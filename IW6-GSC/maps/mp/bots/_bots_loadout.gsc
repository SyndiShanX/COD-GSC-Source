/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_loadout.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots_ks;

SCR_CONST_base_perk_slots = 8;
SCR_CONST_MAX_CUSTOM_DEFAULT_LOADOUTS = 6;

init() {
  init_template_table();
  init_class_table();
  init_perktable();
  init_bot_weap_statstable();
  init_bot_attachmenttable();
  init_bot_camotable();

  level.bot_loadouts_initialized = true;
}

init_class_table() {
  filename = "mp/botClassTable.csv";

  level.botLoadoutSets = [];
  fieldArray = bot_loadout_fields();
  column = 0;

  for(;;) {
    column++;

    strPers = tableLookup(filename, 0, "botPersonalities", column);
    strDiff = tableLookup(filename, 0, "botDifficulties", column);

    if(!isDefined(strPers) || (strPers == "")) {
      break;
    }

    if(!isDefined(strDiff) || (strDiff == "")) {
      break;
    }

    loadoutValues = [];
    foreach(field in fieldArray) {
      loadoutValues[field] = tableLookup(filename, 0, field, column);

      assert_field_valid(field, loadoutValues[field]);

    }

    personalities = StrTok(strPers, "| ");
    difficulties = StrTok(strDiff, "| ");

    foreach(personality in personalities) {
      foreach(difficulty in difficulties) {
        loadoutSet = bot_loadout_set(personality, difficulty, true);
        loadout = spawnStruct();
        loadout.loadoutValues = loadoutValues;
        loadoutSet.loadouts[loadoutSet.loadouts.size] = loadout;
      }
    }
  }
}

init_template_table() {
  filename = "mp/botTemplateTable.csv";

  level.botLoadoutTemplates = [];
  fieldArray = bot_loadout_fields();
  column = 0;

  for(;;) {
    column++;

    strTemplateName = tableLookup(filename, 0, "template_", column);

    if(!isDefined(strTemplateName) || (strTemplateName == "")) {
      break;
    }

    strTemplateLookupName = "template_" + strTemplateName;

    level.botLoadoutTemplates[strTemplateLookupName] = [];

    foreach(field in fieldArray) {
      entry = tableLookup(filename, 0, field, column);
      if(isDefined(entry) && entry != "") {
        level.botLoadoutTemplates[strTemplateLookupName][field] = entry;

        assert_field_valid(field, entry);

      }
    }
  }
}

bot_loadout_item_allowed(type, item, streakType) {
  if(!IsUsingMatchRulesData())
    return true;

  if(!GetMatchRulesData("commonOption", "allowCustomClasses"))
    return true;

  if(item == "specialty_null")
    return true;

  if(item == "none")
    return true;

  if(type == "equipment") {
    if(GetMatchRulesData("commonOption", "perkRestricted", item))
      return false;

    type = "weapon";
  }

  itemRuleName = type + "Restricted";
  classRuleName = type + "ClassRestricted";
  class = "";

  switch (type) {
    case "weapon":
      class = getWeaponClass(item);
      break;
    case "attachment":
      class = getAttachmentType(item);
      break;
    case "killstreak":
      assert(isDefined(streakType));
      class = streakType;
      break;
    case "perk":
      assert(isDefined(level.bot_perktypes[item]));
      class = "ability_" + level.bot_perktypes[item];
      break;
    default:
      AssertEx(0, "bot_loadout_item_allowed() - Unsupported loadout type '" + type + "'");
      return false;
  }

  if(GetMatchRulesData("commonOption", itemRuleName, item))
    return false;

  if(GetMatchRulesData("commonOption", classRuleName, class))
    return false;

  return true;
}

bot_loadout_choose_fallback_primary(loadoutValueArray) {
  weapon = "none";

  difficulties = ["veteran", "hardened", "regular", "recruit"];
  difficulties = array_randomize(difficulties);
  foreach(difficulty in difficulties) {
    weapon = bot_loadout_choose_from_statstable("weap_statstable", loadoutValueArray, "loadoutPrimary", self.personality, difficulty);
    if(weapon != "none")
      return weapon;
  }

  if(isDefined(level.bot_personality_list)) {
    personalities = array_randomize(level.bot_personality_list);
    foreach(personality in personalities) {
      foreach(difficulty in difficulties) {
        weapon = bot_loadout_choose_from_statstable("weap_statstable", loadoutValueArray, "loadoutPrimary", personality, difficulty);
        if(weapon != "none") {
          self.bot_fallback_personality = personality;
          return weapon;
        }
      }
    }
  }

  if(IsUsingMatchRulesData()) {
    index = 0;
    while(index < SCR_CONST_MAX_CUSTOM_DEFAULT_LOADOUTS && (!isDefined(weapon) || weapon == "none" || weapon == "")) {
      if(getMatchRulesData("defaultClasses", self.team, index, "class", "inUse")) {
        weapon = getMatchRulesData("defaultClasses", self.team, index, "class", "weaponSetups", 0, "weapon");
        if(weapon != "none") {
          self.bot_fallback_personality = "weapon";
          return weapon;
        }
      }
      index++;
    }
  }

  self.bot_fallback_personality = "weapon";
  return level.bot_fallback_weapon;
}

bot_pick_personality_from_weapon(weapon) {
  if(isDefined(weapon)) {
    weapPers = level.bot_weap_personality[weapon];
    if(isDefined(weapPers)) {
      personalityChoices = StrTok(weapPers, "| ");
      if(personalityChoices.size > 0)
        self maps\mp\bots\_bots_util::bot_set_personality(random(personalityChoices));
    }
  }
}

assert_field_valid(field, value) {
  if(field == "loadoutStreak1" || field == "loadoutStreak2" || field == "loadoutStreak3") {
    killstreaks = StrTok(value, "| ");
    foreach(streak in killstreaks) {
      if(streak != "none" && GetSubStr(streak, 0, 9) != "template_" && GetSubStr(streak, 0, 5) != "class")
        assert_streak_valid_for_bots_in_general(streak);
    }
  }
}

bot_loadout_fields() {
  result = [];
  result[result.size] = "loadoutPrimary";
  result[result.size] = "loadoutPrimaryBuff";
  result[result.size] = "loadoutPrimaryAttachment";
  result[result.size] = "loadoutPrimaryAttachment2";
  result[result.size] = "loadoutPrimaryCamo";
  result[result.size] = "loadoutPrimaryReticle";
  result[result.size] = "loadoutSecondary";
  result[result.size] = "loadoutSecondaryBuff";
  result[result.size] = "loadoutSecondaryAttachment";
  result[result.size] = "loadoutSecondaryAttachment2";
  result[result.size] = "loadoutSecondaryCamo";
  result[result.size] = "loadoutSecondaryReticle";
  result[result.size] = "loadoutEquipment";
  result[result.size] = "loadoutOffhand";
  result[result.size] = "loadoutStreakType";
  result[result.size] = "loadoutStreak1";
  result[result.size] = "loadoutStreak2";
  result[result.size] = "loadoutStreak3";
  result[result.size] = "loadoutPerk1";
  result[result.size] = "loadoutPerk2";
  result[result.size] = "loadoutPerk3";
  result[result.size] = "loadoutPerk4";
  result[result.size] = "loadoutPerk5";
  result[result.size] = "loadoutPerk6";
  result[result.size] = "loadoutPerk7";
  result[result.size] = "loadoutPerk8";
  result[result.size] = "loadoutPerk9";
  result[result.size] = "loadoutPerk10";
  result[result.size] = "loadoutPerk11";
  result[result.size] = "loadoutPerk12";
  result[result.size] = "loadoutPerk13";
  result[result.size] = "loadoutPerk14";
  result[result.size] = "loadoutPerk15";
  result[result.size] = "loadoutPerk16";
  result[result.size] = "loadoutPerk17";
  result[result.size] = "loadoutPerk18";
  result[result.size] = "loadoutPerk19";
  result[result.size] = "loadoutPerk20";
  result[result.size] = "loadoutPerk21";
  result[result.size] = "loadoutPerk22";
  result[result.size] = "loadoutPerk23";
  return result;
}

bot_loadout_set(personality, difficulty, createIfNeeded) {
  setName = difficulty + "_" + personality;

  if(!isDefined(level.botLoadoutSets))
    level.botLoadoutSets = [];

  if(!isDefined(level.botLoadoutSets[setName]) && createIfNeeded) {
    level.botLoadoutSets[setName] = spawnStruct();
    level.botLoadoutSets[setName].loadouts = [];
  }

  if(isDefined(level.botLoadoutSets[setName]))
    return level.botLoadoutSets[setName];
}

bot_loadout_pick(personality, difficulty) {
  loadoutSet = bot_loadout_set(personality, difficulty, false);
  if(isDefined(loadoutSet) && isDefined(loadoutSet.loadouts) && loadoutSet.loadouts.size > 0) {
    loadoutChoice = RandomInt(loadoutSet.loadouts.size);
    return loadoutSet.loadouts[loadoutChoice].loadoutValues;
  }
}

bot_validate_weapon(weaponName, attachment, attachment2, attachment3) {
  validAttachments = getWeaponAttachmentArrayFromStats(weaponName);

  if(isDefined(attachment) && attachment != "none" && !bot_loadout_item_allowed("attachment", attachment))
    return false;

  if(isDefined(attachment2) && attachment2 != "none" && !bot_loadout_item_allowed("attachment", attachment2))
    return false;

  if(isDefined(attachment3) && attachment3 != "none" && !bot_loadout_item_allowed("attachment", attachment3))
    return false;

  if(attachment != "none" && !array_contains(validAttachments, attachment))
    return false;

  if(attachment2 != "none" && !array_contains(validAttachments, attachment2))
    return false;

  if(isDefined(attachment3) && attachment3 != "none" && !array_contains(validAttachments, attachment3))
    return false;

  if((attachment == "none" || attachment2 == "none") && (!isDefined(attachment3) || attachment3 == "none"))
    return true;

  if(!isDefined(level.bot_invalid_attachment_combos)) {
    level.bot_invalid_attachment_combos = [];
    level.allowable_double_attachments = [];

    attachmentComboTable = "mp/attachmentcombos.csv";
    column = 0;
    while(1) {
      column++;
      currentAttachment = TableLookupByRow(attachmentComboTable, 0, column);
      if(currentAttachment == "") {
        break;
      }

      row = 0;
      while(1) {
        row++;
        attachmentTesting = TableLookupByRow(attachmentComboTable, row, 0);
        if(attachmentTesting == "") {
          break;
        }

        if(attachmentTesting == currentAttachment) {
          if(TableLookupByRow(attachmentComboTable, row, column) != "no")
            level.allowable_double_attachments[attachmentTesting] = true;
        } else {
          if(TableLookupByRow(attachmentComboTable, row, column) == "no")
            level.bot_invalid_attachment_combos[currentAttachment][attachmentTesting] = true;
        }
      }
    }
  }

  if(attachment == attachment2 && !isDefined(level.allowable_double_attachments[attachment]))
    return false;

  if(isDefined(attachment3)) {
    if(attachment2 == attachment3 && !isDefined(level.allowable_double_attachments[attachment2]))
      return false;

    if(attachment == attachment3 && !isDefined(level.allowable_double_attachments[attachment]))
      return false;

    if(attachment3 != "none" && attachment == attachment3 && attachment2 == attachment3)
      return false;

    if(isDefined(level.bot_invalid_attachment_combos[attachment2]) && isDefined(level.bot_invalid_attachment_combos[attachment2][attachment3]))
      return false;

    if(isDefined(level.bot_invalid_attachment_combos[attachment]) && isDefined(level.bot_invalid_attachment_combos[attachment][attachment3]))
      return false;
  }

  return !(isDefined(level.bot_invalid_attachment_combos[attachment]) && isDefined(level.bot_invalid_attachment_combos[attachment][attachment2]));
}

bot_validate_reticle(loadoutBaseName, loadoutValueArray, choice) {
  if(isDefined(loadoutValueArray[loadoutBaseName + "Attachment"]) && isDefined(level.bot_attachment_reticle[loadoutValueArray[loadoutBaseName + "Attachment"]]))
    return true;
  if(isDefined(loadoutValueArray[loadoutBaseName + "Attachment2"]) && isDefined(level.bot_attachment_reticle[loadoutValueArray[loadoutBaseName + "Attachment2"]]))
    return true;
  if(isDefined(loadoutValueArray[loadoutBaseName + "Attachment3"]) && isDefined(level.bot_attachment_reticle[loadoutValueArray[loadoutBaseName + "Attachment3"]]))
    return true;

  return false;
}

bot_perk_cost(perkName) {
  Assert(isDefined(level.perktable_costs[perkName]));
  return level.perktable_costs[perkName];
}

perktable_add(perkName, perkType) {
  Assert(perkName != "");
  if(bot_perk_cost(perkName) > 0) {
    perk = [];
    perk["type"] = perkType;
    perk["name"] = perkName;

    level.bot_perktable[level.bot_perktable.size] = perk;

    level.bot_perktypes[perkName] = perkType;
  }
}

init_perktable() {
  level.perktable_costs = [];
  row = 1;
  while(1) {
    perkName = TableLookupByRow("mp/perktable.csv", row, 1);
    if(perkName == "") {
      break;
    }

    level.perktable_costs[perkName] = int(TableLookupByRow("mp/perktable.csv", row, 10));
    row++;
  }
  level.perktable_costs["none"] = 0;
  level.perktable_costs["specialty_null"] = 0;

  level.bot_perktable = [];
  level.bot_perktypes = [];

  row = 1;
  abilityType = "ability_null";

  while(isDefined(abilityType) && (abilityType != "")) {
    abilityType = GetSubStr(abilityType, 8);

    for(col = 4; col <= 13; col++) {
      perkName = TableLookupByRow("mp/cacabilitytable.csv", row, col);
      if(perkName != "")
        perktable_add(perkName, abilityType);
    }

    row++;
    abilityType = TableLookupByRow("mp/cacabilitytable.csv", row, 1);
  }
}

init_bot_weap_statstable() {
  fileName = "mp/statstable.csv";
  colName = 4;
  colPers = 37;
  colDiff = 38;

  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];

  row = 1;
  while(1) {
    weapName = TableLookupByRow(fileName, row, colName);

    if(weapName == "specialty_null") {
      break;
    }

    weapDiff = TableLookupByRow(fileName, row, colDiff);
    weapPers = TableLookupByRow(fileName, row, colPers);

    if(weapName != "" && weapPers != "")
      level.bot_weap_personality[weapName] = weapPers;

    if(weapDiff != "" && weapName != "" && weapPers != "") {
      slotType = "loadoutPrimary";
      if(maps\mp\gametypes\_class::isValidSecondary(weapName, false)) {
        slotType = "loadoutSecondary";
      } else if(!maps\mp\gametypes\_class::isValidPrimary(weapName, false)) {
        row++;
        continue;
      }

      if(!isDefined(level.bot_weap_statstable[slotType]))
        level.bot_weap_statstable[slotType] = [];

      persList = StrTok(weapPers, "| ");
      diffList = StrTok(weapDiff, "| ");

      foreach(personality in persList) {
        if(!isDefined(level.bot_weap_statstable[slotType][personality]))
          level.bot_weap_statstable[slotType][personality] = [];

        foreach(difficulty in diffList) {
          if(!isDefined(level.bot_weap_statstable[slotType][personality][difficulty]))
            level.bot_weap_statstable[slotType][personality][difficulty] = [];

          newIndex = level.bot_weap_statstable[slotType][personality][difficulty].size;
          level.bot_weap_statstable[slotType][personality][difficulty][newIndex] = weapName;
        }
      }
    }

    row++;
  }
}

bot_loadout_choose_from_statstable(loadoutValue, loadoutValueArray, loadoutValueName, personality, difficulty) {
  result = "specialty_null";
  if(loadoutValueName == "loadoutPrimary")
    result = "iw6_honeybadger";
  else if(loadoutValueName == "loadoutSecondary")
    result = "iw6_p226";

  if(personality == "default")
    personality = "run_and_gun";

  if(loadoutValueName == "loadoutSecondary" && array_contains(loadoutValueArray, "specialty_twoprimaries"))
    loadoutValueName = "loadoutPrimary";

  if(!isDefined(level.bot_weap_statstable))
    return result;

  if(!isDefined(level.bot_weap_statstable[loadoutValueName]))
    return result;

  if(!isDefined(level.bot_weap_statstable[loadoutValueName][personality]))
    return result;

  if(!isDefined(level.bot_weap_statstable[loadoutValueName][personality][difficulty]))
    return result;

  result = bot_loadout_choose_from_set(level.bot_weap_statstable[loadoutValueName][personality][difficulty], loadoutValue, loadoutValueArray, loadoutValueName);

  return result;
}

bot_loadout_choose_from_perktable(choice, loadoutValue, loadoutValueArray, loadoutValueName, personality, difficulty) {
  result = "specialty_null";

  if(!isDefined(level.bot_perktable))
    return result;

  if(!isDefined(level.bot_perktable_groups))
    level.bot_perktable_groups = [];

  if(!isDefined(level.bot_perktable_groups[choice])) {
    types = StrTok(choice, "_");
    assert(types[0] == "perktable");
    types[0] = "";
    any = false;
    if(array_contains(types, "any"))
      any = true;

    choices = [];

    foreach(perk in level.bot_perktable) {
      if(any || array_contains(types, perk["type"]))
        choices[choices.size] = perk["name"];
    }

    level.bot_perktable_groups[choice] = choices;
  }

  if(level.bot_perktable_groups[choice].size > 0)
    result = bot_loadout_choose_from_set(level.bot_perktable_groups[choice], loadoutValue, loadoutValueArray, loadoutValueName);

  return result;
}

bot_validate_perk(choice, loadoutValueName, loadoutValueArray, costRangeStart, costRangeEnd, costAllowed) {
  totalCostAllowed = (costRangeEnd - costRangeStart) + 1;
  if(isDefined(costAllowed))
    totalCostAllowed = costAllowed;
  allocatedCost = 0;

  index = int(GetSubStr(loadoutValueName, 11));

  if(choice == "specialty_twoprimaries")
    return false;
  if(choice == "specialty_extra_attachment")
    return false;

  if(!bot_loadout_item_allowed("perk", choice))
    return false;

  for(i = index - 1; i > 0; i--) {
    prevPerkName = "loadoutPerk" + i;

    if(loadoutValueArray[prevPerkName] == "none" || loadoutValueArray[prevPerkName] == "specialty_null") {
      continue;
    }
    if(choice == loadoutValueArray[prevPerkName])
      return false;

    if((i >= costRangeStart) && (i <= costRangeEnd))
      allocatedCost += bot_perk_cost(loadoutValueArray[prevPerkName]);
  }

  if((allocatedCost + bot_perk_cost(choice)) > totalCostAllowed)
    return false;

  return true;
}

bot_loadout_choose_from_default_class(class, loadoutValue, loadoutValueArray, loadoutValueName, personality, difficulty) {
  class_num = int(GetSubStr(class, 5, 6)) - 1;

  switch (loadoutValueName) {
    case "loadoutPrimary":
      return maps\mp\gametypes\_class::table_getWeapon(level.classTableName, class_num, 0);
    case "loadoutPrimaryAttachment":
      return maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 0, 0);
    case "loadoutPrimaryAttachment2":
      return maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 0, 1);
    case "loadoutPrimaryBuff":
      return maps\mp\gametypes\_class::table_getWeaponBuff(level.classTableName, class_num, 0);
    case "loadoutPrimaryCamo":
      return maps\mp\gametypes\_class::table_getWeaponCamo(level.classTableName, class_num, 0);
    case "loadoutPrimaryReticle":
      return maps\mp\gametypes\_class::table_getWeaponReticle(level.classTableName, class_num, 0);
    case "loadoutSecondary":
      return maps\mp\gametypes\_class::table_getWeapon(level.classTableName, class_num, 1);
    case "loadoutSecondaryAttachment":
      return maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 1, 0);
    case "loadoutSecondaryAttachment2":
      return maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 1, 1);
    case "loadoutSecondaryBuff":
      return maps\mp\gametypes\_class::table_getWeaponBuff(level.classTableName, class_num, 1);
    case "loadoutSecondaryCamo":
      return maps\mp\gametypes\_class::table_getWeaponCamo(level.classTableName, class_num, 1);
    case "loadoutSecondaryReticle":
      return maps\mp\gametypes\_class::table_getWeaponReticle(level.classTableName, class_num, 1);
    case "loadoutEquipment":
      return maps\mp\gametypes\_class::table_getEquipment(level.classTableName, class_num, 0);
    case "loadoutOffhand":
      return maps\mp\gametypes\_class::table_getOffhand(level.classTableName, class_num, 0);
    case "loadoutStreak1":
      return maps\mp\gametypes\_class::table_getKillstreak(level.classTableName, class_num, 0);
    case "loadoutStreak2":
      return maps\mp\gametypes\_class::table_getKillstreak(level.classTableName, class_num, 1);
    case "loadoutStreak3":
      return maps\mp\gametypes\_class::table_getKillstreak(level.classTableName, class_num, 2);
    case "loadoutPerk1":
    case "loadoutPerk2":
    case "loadoutPerk3":
    case "loadoutPerk4":
    case "loadoutPerk5":
    case "loadoutPerk6": {
      perkIndex = int(GetSubStr(loadoutValueName, 11));
      perk = maps\mp\gametypes\_class::table_getPerk(level.classTableName, class_num, perkIndex);
      if(perk == "")
        return "specialty_null";
      perkRow = int(GetSubStr(perk, 0, 1));
      perkCol = int(GetSubStr(perk, 1, 2));
      perkName = TableLookupByRow("mp/cacabilitytable.csv", perkRow + 1, perkCol + 3);
      return perkName;
    }
  }

  AssertMsg("Loadout type '" + loadoutValueName + "' is not supported for bot_loadout_choose_from_default_class('" + class + "')");

  return class;
}

init_bot_attachmenttable() {
  fileName = "mp/attachmenttable.csv";
  colName = 5;
  colDiff = 19;
  colReticle = 11;

  level.bot_attachmenttable = [];
  level.bot_attachment_reticle = [];

  level.bot_att_cross_reference = [];

  row = 1;
  while(1) {
    attachmentName = TableLookupByRow(fileName, row, colName);

    if(attachmentName == "done") {
      break;
    }

    attachmentDiff = TableLookupByRow(fileName, row, colDiff);

    if(attachmentName != "" && attachmentDiff != "") {
      if(isDefined(level.bot_att_cross_reference[attachmentName]) && level.bot_att_cross_reference[attachmentName] != attachmentDiff)
        AssertMsg("base ref '" + attachmentName + "' is associated with conflicting Bot Difficulty in attachmenttable.csv");
      level.bot_att_cross_reference[attachmentName] = attachmentDiff;

      attachmentReticle = TableLookupByRow(fileName, row, colReticle);
      if(attachmentReticle == "TRUE")
        level.bot_attachment_reticle[attachmentName] = true;

      diffList = StrTok(attachmentDiff, "| ");

      foreach(difficulty in diffList) {
        if(!isDefined(level.bot_attachmenttable[difficulty]))
          level.bot_attachmenttable[difficulty] = [];

        if(!array_contains(level.bot_attachmenttable[difficulty], attachmentName)) {
          newIndex = level.bot_attachmenttable[difficulty].size;
          level.bot_attachmenttable[difficulty][newIndex] = attachmentName;
        }
      }
    }

    row++;
  }

  level.bot_att_cross_reference = undefined;
}

bot_loadout_choose_from_attachmenttable(loadoutValue, loadoutValueArray, loadoutValueName, personality, difficulty) {
  result = "none";

  if(!isDefined(level.bot_attachmenttable))
    return result;

  if(!isDefined(level.bot_attachmenttable[difficulty]))
    return result;

  result = bot_loadout_choose_from_set(level.bot_attachmenttable[difficulty], loadoutValue, loadoutValueArray, loadoutValueName);

  return result;
}

init_bot_camotable() {
  fileName = "mp/camotable.csv";
  colName = 1;
  colBotValid = 5;

  level.bot_camotable = [];

  row = 0;
  while(1) {
    camoName = TableLookupByRow(fileName, row, colName);

    if(!isDefined(camoName) || camoName == "") {
      break;
    }

    botValid = TableLookupByRow(fileName, row, colBotValid);
    if(isDefined(botValid) && Int(botValid))
      level.bot_camotable[level.bot_camotable.size] = camoName;

    row++;
  }
}

bot_loadout_choose_from_camotable(loadoutValue, loadoutValueArray, loadoutValueName, personality, difficulty) {
  result = "none";

  if(!isDefined(level.bot_camotable))
    return result;

  result = bot_loadout_choose_from_set(level.bot_camotable, loadoutValue, loadoutValueArray, loadoutValueName);

  return result;
}

bot_loadout_perk_slots(loadoutValueArray) {
  result = SCR_CONST_base_perk_slots;
  if(isDefined(loadoutValueArray["loadoutPrimary"]) && loadoutValueArray["loadoutPrimary"] == "none")
    result = result + 1;
  if(isDefined(loadoutValueArray["loadoutSecondary"]) && loadoutValueArray["loadoutSecondary"] == "none")
    result = result + 1;
  if(isDefined(loadoutValueArray["loadoutEquipment"]) && loadoutValueArray["loadoutEquipment"] == "none")
    result = result + 1;
  if(isDefined(loadoutValueArray["loadoutOffhand"]) && loadoutValueArray["loadoutOffhand"] == "none")
    result = result + 1;
  return result;
}

bot_loadout_valid_choice(loadoutValueVerbatim, loadoutValueArray, loadoutValueName, choice) {
  valid = true;

  switch (loadoutValueName) {
    case "loadoutPrimary":
      valid = bot_loadout_item_allowed("weapon", choice);
      break;
    case "loadoutEquipment":
    case "loadoutOffhand":
      valid = bot_loadout_item_allowed("equipment", choice);
      break;
    case "loadoutPrimaryBuff":
      valid = maps\mp\gametypes\_class::isValidWeaponBuff(choice, loadoutValueArray["loadoutPrimary"]);
      break;
    case "loadoutPrimaryAttachment":
      valid = self bot_validate_weapon(loadoutValueArray["loadoutPrimary"], choice, "none");
      break;
    case "loadoutPrimaryAttachment2":
      valid = self bot_validate_weapon(loadoutValueArray["loadoutPrimary"], loadoutValueArray["loadoutPrimaryAttachment"], choice);
      break;
    case "loadoutPrimaryAttachment3":
      valid = self bot_validate_weapon(loadoutValueArray["loadoutPrimary"], loadoutValueArray["loadoutPrimaryAttachment"], loadoutValueArray["loadoutPrimaryAttachment2"], choice);
      break;
    case "loadoutPrimaryReticle":
      valid = self bot_validate_reticle("loadoutPrimary", loadoutValueArray, choice);
      break;
    case "loadoutPrimaryCamo":
      valid = (!isDefined(self.botLoadoutFavoriteCamo) || (choice == self.botLoadoutFavoriteCamo));
      break;
    case "loadoutSecondary":
      valid = (choice != loadoutValueArray["loadoutPrimary"]);
      valid = valid && bot_loadout_item_allowed("weapon", choice);
      break;
    case "loadoutSecondaryBuff":
      valid = maps\mp\gametypes\_class::isValidWeaponBuff(choice, loadoutValueArray["loadoutSecondary"]);
      break;
    case "loadoutSecondaryAttachment":
      valid = self bot_validate_weapon(loadoutValueArray["loadoutSecondary"], choice, "none");
      break;
    case "loadoutSecondaryAttachment2":
      valid = self bot_validate_weapon(loadoutValueArray["loadoutSecondary"], loadoutValueArray["loadoutSecondaryAttachment"], choice);
      break;
    case "loadoutSecondaryAttachment3":
      valid = self bot_validate_weapon(loadoutValueArray["loadoutSecondary"], loadoutValueArray["loadoutSecondaryAttachment"], loadoutValueArray["loadoutSecondaryAttachment2"], choice);
      break;
    case "loadoutSecondaryReticle":
      valid = self bot_validate_reticle("loadoutSecondary", loadoutValueArray, choice);
      break;
    case "loadoutSecondaryCamo":
      valid = (!isDefined(self.botLoadoutFavoriteCamo) || (choice == self.botLoadoutFavoriteCamo));
      break;
    case "loadoutStreak1":
    case "loadoutStreak2":
    case "loadoutStreak3":
      valid = bot_killstreak_is_valid_internal(choice, "bots", undefined, loadoutValueArray["loadoutStreakType"]);
      valid = valid && bot_loadout_item_allowed("killstreak", choice, loadoutValueArray["loadoutStreakType"]);
      break;
    case "loadoutPerk1":
    case "loadoutPerk2":
    case "loadoutPerk3":
    case "loadoutPerk4":
    case "loadoutPerk5":
    case "loadoutPerk6":
    case "loadoutPerk7":
    case "loadoutPerk8":
    case "loadoutPerk9":
    case "loadoutPerk10":
    case "loadoutPerk11":
    case "loadoutPerk12":
      valid = bot_validate_perk(choice, loadoutValueName, loadoutValueArray, 1, 12, bot_loadout_perk_slots(loadoutValueArray));
      break;
    case "loadoutPerk13":
    case "loadoutPerk14":
    case "loadoutPerk15":
      if(loadoutValueArray["loadoutStreakType"] != "streaktype_specialist")
        valid = false;
      else
        valid = bot_validate_perk(choice, loadoutValueName, loadoutValueArray, -1, -1);
      break;
    case "loadoutPerk16":
    case "loadoutPerk17":
    case "loadoutPerk18":
    case "loadoutPerk19":
    case "loadoutPerk20":
    case "loadoutPerk21":
    case "loadoutPerk22":
    case "loadoutPerk23":
      if(loadoutValueArray["loadoutStreakType"] != "streaktype_specialist")
        valid = false;
      else
        valid = bot_validate_perk(choice, loadoutValueName, loadoutValueArray, 16, 23, SCR_CONST_base_perk_slots);
      break;
  };

  return valid;
}

bot_loadout_choose_from_set(valueChoices, loadoutValue, loadoutValueArray, loadoutValueName, isTemplate) {
  chosenValue = "none";
  chosenTemplate = undefined;
  validCount = 0.0;

  if(array_contains(valueChoices, "specialty_null"))
    chosenValue = "specialty_null";

  foreach(choice in valueChoices) {
    template = undefined;

    if(GetSubStr(choice, 0, 9) == "template_") {
      if(isDefined(isTemplate) && isTemplate)
        AssertMsg("template_ entries should not reference other template_ entries as the random weighting does not work right for that");

      template = choice;
      templateValues = level.botLoadoutTemplates[choice][loadoutValueName];
      assert(isDefined(templateValues));
      choice = bot_loadout_choose_from_set(StrTok(templateValues, "| "), loadoutValue, loadoutValueArray, loadoutValueName, true);

      if(isDefined(template) && isDefined(self.chosenTemplates[template]))
        return choice;
    }

    if(choice == "attachmenttable")
      return bot_loadout_choose_from_attachmenttable(loadoutValue, loadoutValueArray, loadoutValueName, self.personality, self.difficulty);

    if(choice == "weap_statstable")
      return bot_loadout_choose_from_statstable(loadoutValue, loadoutValueArray, loadoutValueName, self.personality, self.difficulty);

    if(choice == "camotable")
      return bot_loadout_choose_from_camotable(loadoutValue, loadoutValueArray, loadoutValueName, self.personality, self.difficulty);

    if(GetSubStr(choice, 0, 5) == "class" && int(GetSubStr(choice, 5, 6)) > 0)
      choice = bot_loadout_choose_from_default_class(choice, loadoutValue, loadoutValueArray, loadoutValueName, self.personality, self.difficulty);

    if(isDefined(level.bot_perktable) && (GetSubStr(choice, 0, 10) == "perktable_"))
      return bot_loadout_choose_from_perktable(choice, loadoutValue, loadoutValueArray, loadoutValueName, self.personality, self.difficulty);

    if(self bot_loadout_valid_choice(loadoutValue, loadoutValueArray, loadoutValueName, choice)) {
      validCount = validCount + 1.0;
      if(RandomFloat(1.0) <= (1.0 / validCount)) {
        chosenValue = choice;
        chosenTemplate = template;
      }
    }
  }

  if(isDefined(chosenTemplate))
    self.chosenTemplates[chosenTemplate] = true;

  return chosenValue;
}

bot_loadout_choose_values(loadoutValueArray) {
  self.chosenTemplates = [];

  foreach(loadoutValueName, loadoutValue in loadoutValueArray) {
    valueChoices = StrTok(loadoutValue, "| ");

    chosenValue = self bot_loadout_choose_from_set(valueChoices, loadoutValue, loadoutValueArray, loadoutValueName);

    debugLoadoutValue = GetDvar("bot_Debug" + loadoutValueName, "");
    if(isDefined(debugLoadoutValue) && debugLoadoutValue != "")
      chosenValue = debugLoadoutValue;

    loadoutValueArray[loadoutValueName] = chosenValue;
  }

  return loadoutValueArray;
}

bot_load_setup_difficulty_squad_match(game_elo) {
  diff = "recruit";

  for(diffIndex = 18; diffIndex >= 0; diffIndex--) {
    elo = Int(TableLookupByRow("mp/squadEloTable.csv", diffIndex, 0));

    if(game_elo >= elo || diffIndex == 0) {
      return TableLookupByRow("mp/squadEloTable.csv", diffIndex, self.pers["squadSlot"] + 1);
    }
  }

  return diff;
}

bot_loadout_get_difficulty() {
  difficulty = "regular";

  if(GetDvar("squad_match") == "1") {
    difficulty = bot_load_setup_difficulty_squad_match(GetSquadAssaultELO());
  } else {
    difficulty = self BotGetDifficulty();

    if(difficulty == "default") {
      self maps\mp\bots\_bots_util::bot_set_difficulty("default");
      difficulty = self BotGetDifficulty();
    }

  }

  Assert(difficulty != "default");

  return difficulty;
}

bot_loadout_class_callback() {
  while(!isDefined(level.bot_loadouts_initialized))
    wait(0.05);

  while(!isDefined(self.personality))
    wait(0.05);

  loadoutValueArray = [];

  difficulty = self bot_loadout_get_difficulty();
  self.difficulty = difficulty;
  personality = self BotGetPersonality();

  if(GetDvar("squad_match") == "1") {
    loadoutValueArray = self bot_loadout_setup_squad_match(loadoutValueArray);
    AssertEx(isDefined(loadoutValueArray), "Bot '" + self.name + "' spawning (Squad Match) with loadoutValueArray not defined");
    personality = self BotGetPersonality();
  } else if(GetDvar("squad_vs_squad") == "1") {
    loadoutValueArray = self bot_loadout_setup_squad_vs_squad_match(loadoutValueArray);
    AssertEx(isDefined(loadoutValueArray), "Bot '" + self.name + "' spawning (Squad vs Squad Match) with loadoutValueArray not defined");
    personality = self BotGetPersonality();
  } else if(GetDvar("squad_use_hosts_squad") == "1" && level.wargame_client.team == self.team) {
    loadoutValueArray = self bot_loadout_setup_wargame_match(loadoutValueArray);
    AssertEx(isDefined(loadoutValueArray), "Bot '" + self.name + "' spawning (Wargame Match) with loadoutValueArray not defined");
    personality = self BotGetPersonality();
  } else {
    if(isDefined(self.botLastLoadout)) {
      same_difficulty = self.botLastLoadoutDifficulty == difficulty;
      same_personality = self.botLastLoadoutPersonality == personality;
      if(same_difficulty && same_personality && (!isDefined(self.hasDied) || self.hasDied) && !isDefined(self.respawn_with_launcher)) {
        return self.botLastLoadout;
      }
    }

    loadoutValueArray = self bot_loadout_pick(personality, difficulty);
    loadoutValueArray = self bot_loadout_choose_values(loadoutValueArray);

    if(isDefined(level.bot_funcs["gametype_loadout_modify"]))
      loadoutValueArray = self[[level.bot_funcs["gametype_loadout_modify"]]](loadoutValueArray);

    AssertEx(isDefined(loadoutValueArray), "Bot '" + self.name + "'spawning (randomized loadout) with loadoutValueArray not defined");

    if(loadoutValueArray["loadoutPrimary"] == "none") {
      self.bot_fallback_personality = undefined;
      loadoutValueArray["loadoutPrimary"] = self bot_loadout_choose_fallback_primary(loadoutValueArray);
      loadoutValueArray["loadoutPrimaryCamo"] = "none";
      loadoutValueArray["loadoutPrimaryAttachment"] = "none";
      loadoutValueArray["loadoutPrimaryAttachment2"] = "none";
      loadoutValueArray["loadoutPrimaryAttachment3"] = "none";
      loadoutValueArray["loadoutPrimaryReticle"] = "none";
      if(isDefined(self.bot_fallback_personality)) {
        if(self.bot_fallback_personality == "weapon")
          self bot_pick_personality_from_weapon(loadoutValueArray["loadoutPrimary"]);
        else
          self maps\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);

        personality = self.personality;

        self.bot_fallback_personality = undefined;
      }
    }

    self.botLastLoadout = loadoutValueArray;
    self.botLastLoadoutDifficulty = difficulty;
    self.botLastLoadoutPersonality = personality;

    if(isDefined(loadoutValueArray["loadoutPrimaryCamo"]) && loadoutValueArray["loadoutPrimaryCamo"] != "none")
      self.botLoadoutFavoriteCamo = loadoutValueArray["loadoutPrimaryCamo"];

    if(isDefined(self.respawn_with_launcher)) {
      if(isDefined(level.bot_respawn_launcher_name) && bot_loadout_item_allowed("weapon", level.bot_respawn_launcher_name)) {
        loadoutValueArray["loadoutSecondary"] = level.bot_respawn_launcher_name;
        loadoutValueArray["loadoutSecondaryAttachment"] = "none";
        loadoutValueArray["loadoutSecondaryAttachment2"] = "none";
        self.botLastLoadout = undefined;
      }
      self.respawn_with_launcher = undefined;
    }
  }

  loadoutValueArray = self bot_loadout_setup_perks(loadoutValueArray);

  maps\mp\gametypes\_class::isValidKillstreak(loadoutValueArray["loadoutStreak1"]);
  maps\mp\gametypes\_class::isValidKillstreak(loadoutValueArray["loadoutStreak2"]);
  maps\mp\gametypes\_class::isValidKillstreak(loadoutValueArray["loadoutStreak3"]);

  if(self bot_israndom()) {
    if(array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
      otherPrimaryLoadout = self bot_loadout_pick("cqb", difficulty);
      loadoutValueArray["loadoutSecondary"] = otherPrimaryLoadout["loadoutPrimary"];
      loadoutValueArray["loadoutSecondaryAttachment"] = otherPrimaryLoadout["loadoutPrimaryAttachment"];
      loadoutValueArray["loadoutSecondaryAttachment2"] = otherPrimaryLoadout["loadoutPrimaryAttachment2"];
      loadoutValueArray = self bot_loadout_choose_values(loadoutValueArray);
      loadoutValueArray = self bot_loadout_setup_perks(loadoutValueArray);
    }

    if(array_contains(self.pers["loadoutPerks"], "specialty_extra_attachment")) {
      otherAttachmentLoadout = self bot_loadout_pick(personality, difficulty);
      loadoutValueArray["loadoutPrimaryAttachment3"] = otherAttachmentLoadout["loadoutPrimaryAttachment2"];
      if(array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries"))
        loadoutValueArray["loadoutSecondaryAttachment2"] = otherAttachmentLoadout["loadoutPrimaryAttachment2"];
      else
        loadoutValueArray["loadoutSecondaryAttachment2"] = otherAttachmentLoadout["loadoutSecondaryAttachment2"];
      loadoutValueArray = self bot_loadout_choose_values(loadoutValueArray);
      loadoutValueArray = self bot_loadout_setup_perks(loadoutValueArray);
    } else {
      loadoutValueArray["loadoutSecondaryAttachment2"] = "none";
      if(!(self bot_validate_reticle("loadoutSecondary", loadoutValueArray, loadoutValueArray["loadoutSecondaryReticle"])))
        loadoutValueArray["loadoutSecondaryReticle"] = "none";
    }
  }

  AssertEx(isDefined(loadoutValueArray), "Bot returning undefined from bot_loadout_class_callback");
  return loadoutValueArray;
}

bot_loadout_setup_perks(loadoutValueArray) {
  self.pers["loadoutPerks"] = [];
  self.pers["specialistBonusStreaks"] = [];
  self.pers["specialistStreaks"] = [];
  self.pers["specialistStreakKills"] = [];

  streakIndex = 0;
  isSpecialist = (isDefined(loadoutValueArray["loadoutStreakType"]) && loadoutValueArray["loadoutStreakType"] == "streaktype_specialist");

  if(isSpecialist) {
    loadoutValueArray["loadoutStreak1"] = "none";
    loadoutValueArray["loadoutStreak2"] = "none";
    loadoutValueArray["loadoutStreak3"] = "none";
  }

  foreach(itemName, item in loadoutValueArray) {
    if((item == "specialty_null") || (item == "none")) {
      continue;
    }
    if((GetSubStr(itemName, 0, 11) == "loadoutPerk")) {
      perkIndex = int(GetSubStr(itemName, 11));

      if(!isSpecialist && perkIndex > 12) {
        continue;
      }
      baseName = getBasePerkName(item);

      if(perkIndex <= 12) {
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = baseName;
      } else if(perkIndex <= 15) {
        loadoutValueArray["loadoutStreak" + (streakIndex + 1)] = baseName + "_ks";
        self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = baseName + "_ks";
        prevCost = 0;
        if(streakIndex > 0)
          prevCost = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];
        self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = prevCost + bot_perk_cost(baseName) + 2;
        streakIndex++;
      } else {
        self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = baseName;
      }
    }
  }

  if(isSpecialist && !isDefined(self.pers["specialistStreakKills"][0])) {
    self.pers["specialistStreakKills"][0] = 0;
    self.pers["specialistStreaks"][0] = "specialty_null";
  }
  if(isSpecialist && !isDefined(self.pers["specialistStreakKills"][1])) {
    self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
    self.pers["specialistStreaks"][1] = "specialty_null";
  }
  if(isSpecialist && !isDefined(self.pers["specialistStreakKills"][2])) {
    self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
    self.pers["specialistStreaks"][2] = "specialty_null";
  }

  return loadoutValueArray;
}

bot_setup_loadout_callback() {
  personality = self BotGetPersonality();
  difficulty = self bot_loadout_get_difficulty();

  loadoutSet = bot_loadout_set(personality, difficulty, false);
  if(isDefined(loadoutSet) && isDefined(loadoutSet.loadouts) && loadoutSet.loadouts.size > 0) {
    self.classCallback = ::bot_loadout_class_callback;
    return true;
  }

  bot_name_without_personality = GetSubStr(self.name, 0, self.name.size - 10);
  AssertMsg("Bot <" + bot_name_without_personality + "> has no possible loadouts for personality <" + personality + "> and difficulty <" + difficulty + ">");
  self.classCallback = undefined;
  return false;
}

bot_squad_lookup_private(owner, squad_slot, loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex) {
  if(isDefined(fieldBIndex))
    return owner GetPrivatePlayerData("privateMatchSquadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex);
  else if(isDefined(fieldB))
    return owner GetPrivatePlayerData("privateMatchSquadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex, fieldB);
  else if(isDefined(fieldAIndex))
    return owner GetPrivatePlayerData("privateMatchSquadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex);
  else
    return owner GetPrivatePlayerData("privateMatchSquadMembers", squad_slot, "loadouts", loadout_slot, fieldA);
}

bot_squad_lookup_ranked(owner, squad_slot, loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex) {
  if(isDefined(fieldBIndex))
    return owner GetRankedPlayerData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex);
  else if(isDefined(fieldB))
    return owner GetRankedPlayerData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex, fieldB);
  else if(isDefined(fieldAIndex))
    return owner GetRankedPlayerData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex);
  else
    return owner GetRankedPlayerData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA);
}

bot_squad_lookup_enemy(owner, squad_slot, loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex) {
  if(isDefined(fieldBIndex))
    return GetEnemySquadData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex);
  else if(isDefined(fieldB))
    return GetEnemySquadData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex, fieldB);
  else if(isDefined(fieldAIndex))
    return GetEnemySquadData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA, fieldAIndex);
  else
    return GetEnemySquadData("squadMembers", squad_slot, "loadouts", loadout_slot, fieldA);
}

bot_squad_lookup(owner, squad_slot, loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex) {
  bot_squad_lookup_func = ::bot_squad_lookup_ranked;

  if((GetDvar("squad_match") == "1") && (self.team == "axis"))
    bot_squad_lookup_func = ::bot_squad_lookup_enemy;
  else if(!matchMakingGame())
    bot_squad_lookup_func = ::bot_squad_lookup_private;

  return self[[bot_squad_lookup_func]](owner, squad_slot, loadout_slot, fieldA, fieldAIndex, fieldB, fieldBIndex);
}

bot_squadmember_lookup(owner, squad_slot, fieldA) {
  if((GetDvar("squad_match") == "1") && (self.team == "axis"))
    return GetEnemySquadData("squadMembers", squad_slot, fieldA);
  else if(!matchMakingGame())
    return owner GetPrivatePlayerData("privateMatchSquadMembers", squad_slot, fieldA);
  else
    return owner GetRankedPlayerData("squadMembers", squad_slot, fieldA);
}

bot_loadout_copy_from_client(loadoutValueArray, owner, squad_slot, loadout_slot) {
  loadoutValueArray["loadoutPrimary"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 0, "weapon");
  loadoutValueArray["loadoutPrimaryAttachment"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 0, "attachment", 0);
  loadoutValueArray["loadoutPrimaryAttachment2"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 0, "attachment", 1);
  loadoutValueArray["loadoutPrimaryAttachment3"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 0, "attachment", 2);
  loadoutValueArray["loadoutPrimaryBuff"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 0, "buff");
  loadoutValueArray["loadoutPrimaryCamo"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 0, "camo");
  loadoutValueArray["loadoutPrimaryReticle"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 0, "reticle");

  loadoutValueArray["loadoutSecondary"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 1, "weapon");
  loadoutValueArray["loadoutSecondaryAttachment"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 1, "attachment", 0);
  loadoutValueArray["loadoutSecondaryAttachment2"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 1, "attachment", 1);
  loadoutValueArray["loadoutSecondaryBuff"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 1, "buff");
  loadoutValueArray["loadoutSecondaryCamo"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 1, "camo");
  loadoutValueArray["loadoutSecondaryReticle"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "weaponSetups", 1, "reticle");

  loadoutValueArray["loadoutEquipment"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "perks", 0);
  loadoutValueArray["loadoutOffhand"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "perks", 1);

  loadoutValueArray["loadoutStreak1"] = "none";
  loadoutValueArray["loadoutStreak2"] = "none";
  loadoutValueArray["loadoutStreak3"] = "none";

  kill_streak = self bot_squad_lookup(owner, squad_slot, loadout_slot, "perks", 5);
  if(isDefined(kill_streak)) {
    loadoutValueArray["loadoutStreakType"] = kill_streak;

    if(kill_streak == "streaktype_assault") {
      loadoutValueArray["loadoutStreak1"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "assaultStreaks", 0);
      loadoutValueArray["loadoutStreak2"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "assaultStreaks", 1);
      loadoutValueArray["loadoutStreak3"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "assaultStreaks", 2);
    } else if(kill_streak == "streaktype_support") {
      loadoutValueArray["loadoutStreak1"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "supportStreaks", 0);
      loadoutValueArray["loadoutStreak2"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "supportStreaks", 1);
      loadoutValueArray["loadoutStreak3"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "supportStreaks", 2);
    } else if(kill_streak == "streaktype_specialist") {
      loadoutValueArray["loadoutPerk13"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "specialistStreaks", 0);
      loadoutValueArray["loadoutPerk14"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "specialistStreaks", 1);
      loadoutValueArray["loadoutPerk15"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "specialistStreaks", 2);
    }
  }

  ability_index = 1;
  num_abils = maps\mp\gametypes\_class::getNumAbilityCategories();
  num_sub_abils = maps\mp\gametypes\_class::getNumSubAbility();

  for(abilityCategoryIndex = 0; abilityCategoryIndex < num_abils; abilityCategoryIndex++) {
    for(abilityIndex = 0; abilityIndex < num_sub_abils; abilityIndex++) {
      picked = self bot_squad_lookup(owner, squad_slot, loadout_slot, "abilitiesPicked", abilityCategoryIndex, abilityIndex);
      if(isDefined(picked) && picked) {
        abilityRef = TableLookup("mp/cacAbilityTable.csv", 0, abilityCategoryIndex + 1, 4 + abilityIndex);
        loadoutValueArray["loadoutPerk" + ability_index] = abilityRef;
        ability_index++;
      } else {
        loadoutValueArray["loadoutPerk" + ability_index] = "specialty_null";
      }
    }
  }

  ability_index = 16;
  for(abilityCategoryIndex = 0; abilityCategoryIndex < num_abils; abilityCategoryIndex++) {
    for(abilityIndex = 0; abilityIndex < num_sub_abils; abilityIndex++) {
      picked = self bot_squad_lookup(owner, squad_slot, loadout_slot, "specialistBonusStreaks", abilityCategoryIndex, abilityIndex);
      if(isDefined(picked) && picked) {
        abilityRef = TableLookup("mp/cacAbilityTable.csv", 0, abilityCategoryIndex + 1, 4 + abilityIndex);
        loadoutValueArray["loadoutPerk" + ability_index] = abilityRef;
        ability_index++;
      } else {
        loadoutValueArray["loadoutPerk" + ability_index] = "specialty_null";
      }
    }
  }

  loadoutValueArray["loadoutCharacterType"] = self bot_squad_lookup(owner, squad_slot, loadout_slot, "type");

  self bot_pick_personality_from_weapon(loadoutValueArray["loadoutPrimary"]);

  self.playerCardPatch = self bot_squadmember_lookup(owner, squad_slot, "patch");
  self.playerCardBackground = self bot_squadmember_lookup(owner, squad_slot, "background");

  if((GetDvar("squad_match") == "1") && (self.team == "axis"))
    self.squad_bot_dog_type = GetEnemySquadDogType();
  else
    self.squad_bot_dog_type = owner GetCommonPlayerDataReservedInt("mp_dog_type");

  return loadoutValueArray;
}

bot_loadout_setup_squad_match(loadoutValueArray) {
  owner = level.players[0];
  foreach(player in level.players) {
    if(!IsAI(player) && IsPlayer(player)) {
      owner = player;
      break;
    }
  }

  squad_slot = self.pers["squadSlot"];
  loadout_slot = self bot_squadmember_lookup(owner, squad_slot, "ai_loadout");

  self.pers["rankxp"] = self bot_squadmember_lookup(owner, squad_slot, "squadMemXP");
  if(self.team == "allies") {
    if(isDefined(owner)) {
      prestige = owner getRankedPlayerDataReservedInt("prestigeLevel");
      self.pers["prestige_fake"] = prestige;
    }
  } else if(self.team == "axis") {
    self.pers["prestige_fake"] = GetSquadAssaultEnemyPrestige();
  }

  loadoutValueArray = self bot_loadout_copy_from_client(loadoutValueArray, owner, squad_slot, loadout_slot);

  return loadoutValueArray;
}

bot_loadout_setup_squad_vs_squad_match(loadoutValueArray) {
  owner = level.squad_vs_squad_allies_client;
  if(self.team == "axis") {
    owner = level.squad_vs_squad_axis_client;
  }

  squad_slot = self.pers["squadSlot"];
  loadout_slot = self bot_squadmember_lookup(owner, squad_slot, "ai_loadout");

  self.pers["rankxp"] = self bot_squadmember_lookup(owner, squad_slot, "squadMemXP");
  if(isDefined(owner)) {
    prestige = owner getRankedPlayerDataReservedInt("prestigeLevel");
    self.pers["prestige_fake"] = prestige;
  }

  loadoutValueArray = self bot_loadout_copy_from_client(loadoutValueArray, owner, squad_slot, loadout_slot);

  return loadoutValueArray;
}

bot_loadout_setup_wargame_match(loadoutValueArray) {
  owner = level.wargame_client;

  squad_slot = self.pers["squadSlot"];
  loadout_slot = self bot_squadmember_lookup(owner, squad_slot, "ai_loadout");

  self.pers["rankxp"] = self bot_squadmember_lookup(owner, squad_slot, "squadMemXP");
  if(isDefined(owner)) {
    prestige = owner getRankedPlayerDataReservedInt("prestigeLevel");
    self.pers["prestige_fake"] = prestige;
  }

  loadoutValueArray = self bot_loadout_copy_from_client(loadoutValueArray, owner, squad_slot, loadout_slot);

  return loadoutValueArray;
}