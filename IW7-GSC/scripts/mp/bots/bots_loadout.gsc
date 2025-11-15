/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_loadout.gsc
********************************************/

init() {
  init_template_table();
  init_class_table();
  init_perktable();
  init_bot_weap_statstable();
  init_bot_attachmenttable();
  init_bot_camotable();
  init_bot_archetypes();
  level.bot_loadouts_initialized = 1;
}

init_class_table() {
  var_00 = "mp\botClassTable.csv";
  level.botloadoutsets = [];
  var_01 = bot_loadout_fields();
  var_02 = 0;
  for(;;) {
    var_02++;
    var_03 = tablelookup(var_00, 0, "botArchetype", var_02);
    var_04 = tablelookup(var_00, 0, "botPersonalities", var_02);
    var_05 = tablelookup(var_00, 0, "botDifficulties", var_02);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    if(!isDefined(var_04) || var_04 == "") {
      break;
    }

    if(!isDefined(var_05) || var_05 == "") {
      break;
    }

    var_06 = [];
    foreach(var_08 in var_01) {
      var_06[var_08] = tablelookup(var_00, 0, var_08, var_02);
    }

    var_0A = strtok(var_03, "|");
    var_0B = strtok(var_04, "| ");
    var_0C = strtok(var_05, "| ");
    foreach(var_0E in var_0A) {
      var_0E = "archetype_" + var_0E;
      var_06["loadoutArchetype"] = var_0E;
      foreach(var_10 in var_0B) {
        foreach(var_12 in var_0C) {
          var_13 = bot_loadout_set(var_0E, var_10, var_12, 1);
          var_14 = spawnStruct();
          var_14.loadoutvalues = var_06;
          var_13.loadouts[var_13.loadouts.size] = var_14;
        }
      }
    }
  }
}

init_template_table() {
  var_00 = "mp\botTemplateTable.csv";
  level.botloadouttemplates = [];
  var_01 = bot_loadout_fields();
  var_02 = 0;
  for(;;) {
    var_02++;
    var_03 = tablelookup(var_00, 0, "template_", var_02);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    var_04 = "template_" + var_03;
    level.botloadouttemplates[var_04] = [];
    foreach(var_06 in var_01) {
      var_07 = tablelookup(var_00, 0, var_06, var_02);
      if(isDefined(var_07) && var_07 != "") {
        level.botloadouttemplates[var_04][var_06] = var_07;
      }
    }
  }
}

init_bot_archetypes() {
  level.botarchetypes = [];
  level.botarchetypes["cqb"] = ["archetype_assault", "archetype_scout", "archetype_assassin", "archetype_heavy", "archetype_engineer"];
  level.botarchetypes["run_and_gun"] = ["archetype_assault", "archetype_scout", "archetype_heavy", "archetype_engineer"];
  level.botarchetypes["camper"] = ["archetype_assassin", "archetype_heavy", "archetype_sniper"];
  level.botarchetypes["default"] = ["archetype_assault"];
}

bot_loadout_item_allowed(param_00, param_01, param_02) {
  if(!isusingmatchrulesdata()) {
    return 1;
  }

  if(!getmatchrulesdata("commonOption", "allowCustomClasses")) {
    return 1;
  }

  if(param_01 == "specialty_null") {
    return 1;
  }

  if(param_01 == "none") {
    return 1;
  }

  if(param_00 == "equipment") {
    if(getmatchrulesdata("commonOption", "perkRestricted", param_01)) {
      return 0;
    }

    param_00 = "weapon";
  }

  var_03 = param_00 + "Restricted";
  var_04 = param_00 + "ClassRestricted";
  var_05 = "";
  switch (param_00) {
    case "weapon":
      var_05 = scripts\mp\utility::getweapongroup(param_01);
      break;

    case "attachment":
      var_05 = scripts\mp\utility::getattachmenttype(param_01);
      break;

    case "killstreak":
      var_05 = param_02;
      break;

    case "perk":
      var_05 = "ability_" + level.bot_perktypes[param_01];
      break;

    default:
      return 0;
  }

  if(getmatchrulesdata("commonOption", var_03, param_01)) {
    return 0;
  }

  if(getmatchrulesdata("commonOption", var_04, var_05)) {
    return 0;
  }

  return 1;
}

bot_loadout_choose_fallback_primary(param_00) {
  var_01 = "none";
  var_02 = ["veteran", "hardened", "regular", "recruit"];
  var_02 = scripts\engine\utility::array_randomize(var_02);
  foreach(var_04 in var_02) {
    var_01 = bot_loadout_choose_from_statstable("weap_statstable", param_00, "loadoutPrimary", self.botarchetype, self.personality, var_04);
    if(var_01 != "none") {
      return var_01;
    }
  }

  if(isDefined(level.bot_personality_list)) {
    var_06 = scripts\engine\utility::array_randomize(level.bot_personality_list);
    foreach(var_08 in var_06) {
      foreach(var_04 in var_02) {
        var_01 = bot_loadout_choose_from_statstable("weap_statstable", param_00, "loadoutPrimary", param_00["loadoutArchetype"], var_08, var_04);
        if(var_01 != "none") {
          self.bot_fallback_personality = var_08;
          return var_01;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    for(var_0C = 0; var_0C < 6 && !isDefined(var_01) || var_01 == "none" || var_01 == ""; var_0C++) {
      if(scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", self.team, var_0C, "class", "inUse")) {
        var_01 = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", self.team, var_0C, "class", "weaponSetups", 0, "weapon");
        if(var_01 != "none") {
          self.bot_fallback_personality = "weapon";
          return var_01;
        }
      }
    }
  }

  self.bot_fallback_personality = "weapon";
  return level.bot_fallback_weapon;
}

bot_pick_personality_from_weapon(param_00) {
  if(isDefined(param_00)) {
    var_01 = level.bot_weap_personality[param_00];
    if(isDefined(var_01)) {
      var_02 = strtok(var_01, "| ");
      if(var_02.size > 0) {
        scripts\mp\bots\_bots_util::bot_set_personality(scripts\engine\utility::random(var_02));
        return;
      }
    }
  }
}

bot_loadout_fields() {
  var_00 = [];
  var_00[var_00.size] = "loadoutPrimary";
  var_00[var_00.size] = "loadoutPrimaryAttachment";
  var_00[var_00.size] = "loadoutPrimaryAttachment2";
  var_00[var_00.size] = "loadoutPrimaryCamo";
  var_00[var_00.size] = "loadoutPrimaryReticle";
  var_00[var_00.size] = "loadoutSecondary";
  var_00[var_00.size] = "loadoutSecondaryAttachment";
  var_00[var_00.size] = "loadoutSecondaryAttachment2";
  var_00[var_00.size] = "loadoutSecondaryCamo";
  var_00[var_00.size] = "loadoutSecondaryReticle";
  var_00[var_00.size] = "loadoutStreakType";
  var_00[var_00.size] = "loadoutStreak1";
  var_00[var_00.size] = "loadoutStreak2";
  var_00[var_00.size] = "loadoutStreak3";
  var_00[var_00.size] = "loadoutPowerPrimary";
  var_00[var_00.size] = "loadoutPowerSecondary";
  var_00[var_00.size] = "loadoutPerk1";
  var_00[var_00.size] = "loadoutPerk2";
  var_00[var_00.size] = "loadoutPerk3";
  return var_00;
}

bot_loadout_set(param_00, param_01, param_02, param_03) {
  var_04 = bot_loadout_make_index(param_00, param_01, param_02);
  if(!isDefined(level.botloadoutsets)) {
    level.botloadoutsets = [];
  }

  if(!isDefined(level.botloadoutsets[var_04]) && param_03) {
    level.botloadoutsets[var_04] = spawnStruct();
    level.botloadoutsets[var_04].loadouts = [];
  }

  if(isDefined(level.botloadoutsets[var_04])) {
    return level.botloadoutsets[var_04];
  }
}

bot_loadout_pick(param_00, param_01, param_02) {
  var_03 = bot_loadout_set(param_00, param_01, param_02, 0);
  if(isDefined(var_03) && isDefined(var_03.loadouts) && var_03.loadouts.size > 0) {
    var_04 = randomint(var_03.loadouts.size);
    return var_03.loadouts[var_04].loadoutvalues;
  }
}

bot_validate_weapon(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\utility::getweaponattachmentarrayfromstats(param_00);
  if(isDefined(param_01) && param_01 != "none" && !bot_loadout_item_allowed("attachment", param_01)) {
    return 0;
  }

  if(isDefined(param_02) && param_02 != "none" && !bot_loadout_item_allowed("attachment", param_02)) {
    return 0;
  }

  if(isDefined(param_03) && param_03 != "none" && !bot_loadout_item_allowed("attachment", param_03)) {
    return 0;
  }

  if(param_01 != "none" && !scripts\engine\utility::array_contains(var_04, param_01)) {
    return 0;
  }

  if(param_02 != "none" && !scripts\engine\utility::array_contains(var_04, param_02)) {
    return 0;
  }

  if(isDefined(param_03) && param_03 != "none" && !scripts\engine\utility::array_contains(var_04, param_03)) {
    return 0;
  }

  if((param_01 == "none" || param_02 == "none") && !isDefined(param_03) || param_03 == "none") {
    return 1;
  }

  if(!isDefined(level.bot_invalid_attachment_combos)) {
    level.bot_invalid_attachment_combos = [];
    level.allowable_double_attachments = [];
    var_05 = "mp\attachmentcombos.csv";
    var_06 = 0;
    for(;;) {
      var_06++;
      var_07 = tablelookupbyrow(var_05, 0, var_06);
      if(var_07 == "") {
        break;
      }

      var_08 = 0;
      for(;;) {
        var_08++;
        var_09 = tablelookupbyrow(var_05, var_08, 0);
        if(var_09 == "") {
          break;
        }

        if(var_09 == var_07) {
          if(tablelookupbyrow(var_05, var_08, var_06) != "no") {
            level.allowable_double_attachments[var_09] = 1;
          }

          continue;
        }

        if(tablelookupbyrow(var_05, var_08, var_06) == "no") {
          level.bot_invalid_attachment_combos[var_07][var_09] = 1;
        }
      }
    }
  }

  if(param_01 == param_02 && !isDefined(level.allowable_double_attachments[param_01])) {
    return 0;
  }

  if(isDefined(param_03)) {
    if(param_02 == param_03 && !isDefined(level.allowable_double_attachments[param_02])) {
      return 0;
    }

    if(param_01 == param_03 && !isDefined(level.allowable_double_attachments[param_01])) {
      return 0;
    }

    if(param_03 != "none" && param_01 == param_03 && param_02 == param_03) {
      return 0;
    }

    if(isDefined(level.bot_invalid_attachment_combos[param_02]) && isDefined(level.bot_invalid_attachment_combos[param_02][param_03])) {
      return 0;
    }

    if(isDefined(level.bot_invalid_attachment_combos[param_01]) && isDefined(level.bot_invalid_attachment_combos[param_01][param_03])) {
      return 0;
    }
  }

  return !isDefined(level.bot_invalid_attachment_combos[param_01]) && isDefined(level.bot_invalid_attachment_combos[param_01][param_02]);
}

bot_validate_reticle(param_00, param_01, param_02) {
  if(isDefined(param_01[param_00 + "Attachment"]) && isDefined(level.bot_attachment_reticle[param_01[param_00 + "Attachment"]])) {
    return 1;
  }

  if(isDefined(param_01[param_00 + "Attachment2"]) && isDefined(level.bot_attachment_reticle[param_01[param_00 + "Attachment2"]])) {
    return 1;
  }

  if(isDefined(param_01[param_00 + "Attachment3"]) && isDefined(level.bot_attachment_reticle[param_01[param_00 + "Attachment3"]])) {
    return 1;
  }

  return 0;
}

bot_perk_cost(param_00) {
  return level.perktable_costs[param_00];
}

perktable_add(param_00, param_01) {
  if(bot_perk_cost(param_00) > 0) {
    var_02 = [];
    var_02["type"] = param_01;
    var_02["name"] = param_00;
    level.bot_perktable[level.bot_perktable.size] = var_02;
    level.bot_perktypes[param_00] = param_01;
  }
}

init_perktable() {
  level.perktable_costs = [];
  var_00 = 1;
  for(;;) {
    var_01 = tablelookupbyrow("mp\perktable.csv", var_00, 1);
    if(var_01 == "") {
      break;
    }

    level.perktable_costs[var_01] = int(tablelookupbyrow("mp\perktable.csv", var_00, 10));
    var_00++;
  }

  level.perktable_costs["none"] = 0;
  level.perktable_costs["specialty_null"] = 0;
  level.bot_perktable = [];
  level.bot_perktypes = [];
  var_00 = 1;
  var_02 = "ability_null";
  while(isDefined(var_02) && var_02 != "") {
    var_02 = getsubstr(var_02, 8);
    for(var_03 = 4; var_03 <= 13; var_03++) {
      var_01 = tablelookupbyrow("mp\cacabilitytable.csv", var_00, var_03);
      if(var_01 != "") {
        perktable_add(var_01, var_02);
      }
    }

    var_00++;
    var_02 = tablelookupbyrow("mp\cacabilitytable.csv", var_00, 1);
  }
}

init_bot_weap_statstable() {
  var_00 = "mp\statstable.csv";
  var_01 = 4;
  var_02 = 38;
  var_03 = 39;
  var_04 = 40;
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];
  var_05 = 1;
  for(;;) {
    var_06 = tablelookupbyrow(var_00, var_05, var_01);
    if(var_06 == "specialty_null") {
      break;
    }

    var_07 = tablelookupbyrow(var_00, var_05, var_02);
    var_08 = tablelookupbyrow(var_00, var_05, var_04);
    var_09 = tablelookupbyrow(var_00, var_05, var_03);
    if(var_06 != "" && var_09 != "") {
      level.bot_weap_personality[var_06] = var_09;
    }

    if(var_08 != "" && var_06 != "" && var_09 != "" && var_07 != "") {
      var_0A = "loadoutPrimary";
      if(scripts\mp\utility::iscacsecondaryweapon(var_06)) {
        var_0A = "loadoutSecondary";
      } else if(!scripts\mp\utility::iscacprimaryweapon(var_06)) {
        var_05++;
        continue;
      }

      if(!isDefined(level.bot_weap_statstable[var_0A])) {
        level.bot_weap_statstable[var_0A] = [];
      }

      var_0B = strtok(var_07, "|");
      var_0C = strtok(var_09, "| ");
      var_0D = strtok(var_08, "| ");
      foreach(var_0F in var_0B) {
        var_0F = "archetype_" + var_0F;
        foreach(var_11 in var_0C) {
          foreach(var_13 in var_0D) {
            var_14 = bot_loadout_make_index(var_0F, var_11, var_13);
            if(!isDefined(level.bot_weap_statstable[var_0A][var_14])) {
              level.bot_weap_statstable[var_0A][var_14] = [];
            }

            var_15 = level.bot_weap_statstable[var_0A][var_14].size;
            level.bot_weap_statstable[var_0A][var_14][var_15] = var_06;
          }
        }
      }
    }

    var_05++;
  }
}

bot_loadout_choose_from_statstable(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = "specialty_null";
  if(param_02 == "loadoutPrimary") {
    var_06 = "iw7_ar57";
  } else if(param_02 == "loadoutSecondary") {
    var_06 = "iw7_revolver";
  }

  if(param_04 == "default") {
    param_04 = "run_and_gun";
  }

  if(param_02 == "loadoutSecondary" && scripts\engine\utility::array_contains(param_01, "specialty_twoprimaries")) {
    param_02 = "loadoutPrimary";
  }

  if(!isDefined(level.bot_weap_statstable)) {
    return var_06;
  }

  if(!isDefined(level.bot_weap_statstable[param_02])) {
    return var_06;
  }

  var_07 = bot_loadout_make_index(param_03, param_04, param_05);
  if(!isDefined(level.bot_weap_statstable[param_02][var_07])) {
    return var_06;
  }

  var_06 = bot_loadout_choose_from_set(level.bot_weap_statstable[param_02][var_07], param_00, param_01, param_02);
  return var_06;
}

bot_loadout_choose_from_perktable(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = "specialty_null";
  if(!isDefined(level.bot_perktable)) {
    return var_06;
  }

  if(!isDefined(level.bot_perktable_groups)) {
    level.bot_perktable_groups = [];
  }

  if(!isDefined(level.bot_perktable_groups[param_00])) {
    var_07 = strtok(param_00, "_");
    var_07[0] = "";
    var_08 = 0;
    if(scripts\engine\utility::array_contains(var_07, "any")) {
      var_08 = 1;
    }

    var_09 = [];
    foreach(var_0B in level.bot_perktable) {
      if(var_08 || scripts\engine\utility::array_contains(var_07, var_0B["type"])) {
        var_09[var_09.size] = var_0B["name"];
      }
    }

    level.bot_perktable_groups[param_00] = var_09;
  }

  if(level.bot_perktable_groups[param_00].size > 0) {
    var_06 = bot_loadout_choose_from_set(level.bot_perktable_groups[param_00], param_01, param_02, param_03);
  }

  return var_06;
}

bot_validate_perk(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = param_04 - param_03 + 1;
  if(isDefined(param_05)) {
    var_06 = param_05;
  }

  var_07 = 0;
  var_08 = int(getsubstr(param_01, 11));
  if(param_00 == "specialty_twoprimaries") {
    return 0;
  }

  if(param_00 == "specialty_extra_attachment") {
    return 0;
  }

  if(!bot_loadout_item_allowed("perk", param_00)) {
    return 0;
  }

  for(var_09 = var_08 - 1; var_09 > 0; var_09--) {
    var_0A = "loadoutPerk" + var_09;
    if(param_02[var_0A] == "none" || param_02[var_0A] == "specialty_null") {
      continue;
    }

    if(param_00 == param_02[var_0A]) {
      return 0;
    }

    if(var_09 >= param_03 && var_09 <= param_04) {
      var_07 = var_07 + bot_perk_cost(param_02[var_0A]);
    }
  }

  if(var_07 + bot_perk_cost(param_00) > var_06) {
    return 0;
  }

  return 1;
}

bot_loadout_choose_from_default_class(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = int(getsubstr(param_00, 5, 6)) - 1;
  switch (param_03) {
    case "loadoutPrimary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_06, 0);

    case "loadoutPrimaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 0, 0);

    case "loadoutPrimaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 0, 1);

    case "loadoutPrimaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_06, 0);

    case "loadoutPrimaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_06, 0);

    case "loadoutSecondary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_06, 1);

    case "loadoutSecondaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 1, 0);

    case "loadoutSecondaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 1, 1);

    case "loadoutSecondaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_06, 1);

    case "loadoutSecondaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_06, 1);

    case "loadoutStreak1":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_06, 0);

    case "loadoutStreak2":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_06, 1);

    case "loadoutStreak3":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_06, 2);

    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_07 = int(getsubstr(param_03, 11));
      var_08 = scripts\mp\class::table_getperk(level.classtablename, var_06, var_07);
      if(var_08 == "") {
        return "specialty_null";
      }

      var_09 = int(getsubstr(var_08, 0, 1));
      var_0A = int(getsubstr(var_08, 1, 2));
      var_0B = tablelookupbyrow("mp\cacabilitytable.csv", var_09 + 1, var_0A + 3);
      return var_0B;
  }

  return param_05;
}

init_bot_attachmenttable() {
  var_00 = "mp\attachmenttable.csv";
  var_01 = 5;
  var_02 = 19;
  var_03 = 11;
  level.bot_attachmenttable = [];
  level.bot_attachment_reticle = [];
  var_04 = 1;
  for(;;) {
    var_05 = tablelookupbyrow(var_00, var_04, var_01);
    if(var_05 == "done") {
      break;
    }

    var_06 = tablelookupbyrow(var_00, var_04, var_02);
    if(var_05 != "" && var_06 != "") {
      var_07 = tablelookupbyrow(var_00, var_04, var_03);
      if(var_07 == "TRUE") {
        level.bot_attachment_reticle[var_05] = 1;
      }

      var_08 = strtok(var_06, "| ");
      foreach(var_0A in var_08) {
        if(!isDefined(level.bot_attachmenttable[var_0A])) {
          level.bot_attachmenttable[var_0A] = [];
        }

        if(!scripts\engine\utility::array_contains(level.bot_attachmenttable[var_0A], var_05)) {
          var_0B = level.bot_attachmenttable[var_0A].size;
          level.bot_attachmenttable[var_0A][var_0B] = var_05;
        }
      }
    }

    var_04++;
  }
}

bot_loadout_choose_from_attachmenttable(param_00, param_01, param_02, param_03, param_04) {
  var_05 = "none";
  if(!isDefined(level.bot_attachmenttable)) {
    return var_05;
  }

  if(!isDefined(level.bot_attachmenttable[param_04])) {
    return var_05;
  }

  var_05 = bot_loadout_choose_from_set(level.bot_attachmenttable[param_04], param_00, param_01, param_02);
  return var_05;
}

init_bot_camotable() {
  var_00 = "mp\camotable.csv";
  level.var_2D1E = [];
  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, scripts\engine\utility::getcamotablecolumnindex("ref"));
    if(!isDefined(var_02) || var_02 == "") {
      break;
    }

    var_03 = tablelookupbyrow(var_00, var_01, scripts\engine\utility::getcamotablecolumnindex("bot_valid"));
    if(isDefined(var_03) && int(var_03)) {
      level.var_2D1E[level.var_2D1E.size] = var_02;
    }

    var_01++;
  }
}

bot_loadout_choose_from_camotable(param_00, param_01, param_02, param_03, param_04) {
  var_05 = "none";
  return var_05;
}

bot_loadout_perk_slots(param_00) {
  var_01 = 8;
  if(isDefined(param_00["loadoutPrimary"]) && param_00["loadoutPrimary"] == "none") {
    var_01 = var_01 + 1;
  }

  if(isDefined(param_00["loadoutSecondary"]) && param_00["loadoutSecondary"] == "none") {
    var_01 = var_01 + 1;
  }

  if(isDefined(param_00["loadoutPowerPrimary"]) && param_00["loadoutPowerPrimary"] == "none") {
    var_01 = var_01 + 1;
  }

  if(isDefined(param_00["loadoutPowerSecondary"]) && param_00["loadoutPowerSecondary"] == "none") {
    var_01 = var_01 + 1;
  }

  return var_01;
}

bot_loadout_valid_choice(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  switch (param_02) {
    case "loadoutPrimary":
      var_04 = bot_loadout_item_allowed("weapon", param_03);
      break;

    case "loadoutPowerSecondary":
    case "loadoutPowerPrimary":
      var_04 = bot_loadout_item_allowed("equipment", param_03);
      break;

    case "loadoutPrimaryAttachment":
      var_04 = bot_validate_weapon(param_01["loadoutPrimary"], param_03, "none");
      break;

    case "loadoutPrimaryAttachment2":
      var_04 = bot_validate_weapon(param_01["loadoutPrimary"], param_01["loadoutPrimaryAttachment"], param_03);
      break;

    case "loadoutPrimaryAttachment3":
      var_04 = bot_validate_weapon(param_01["loadoutPrimary"], param_01["loadoutPrimaryAttachment"], param_01["loadoutPrimaryAttachment2"], param_03);
      break;

    case "loadoutPrimaryReticle":
      var_04 = bot_validate_reticle("loadoutPrimary", param_01, param_03);
      break;

    case "loadoutPrimaryCamo":
      var_04 = !isDefined(self.botloadoutfavoritecamo) || param_03 == self.botloadoutfavoritecamo;
      break;

    case "loadoutSecondary":
      var_04 = param_03 != param_01["loadoutPrimary"];
      var_04 = var_04 && bot_loadout_item_allowed("weapon", param_03);
      break;

    case "loadoutSecondaryAttachment":
      var_04 = bot_validate_weapon(param_01["loadoutSecondary"], param_03, "none");
      break;

    case "loadoutSecondaryAttachment2":
      var_04 = bot_validate_weapon(param_01["loadoutSecondary"], param_01["loadoutSecondaryAttachment"], param_03);
      break;

    case "loadoutSecondaryAttachment3":
      var_04 = bot_validate_weapon(param_01["loadoutSecondary"], param_01["loadoutSecondaryAttachment"], param_01["loadoutSecondaryAttachment2"], param_03);
      break;

    case "loadoutSecondaryReticle":
      var_04 = bot_validate_reticle("loadoutSecondary", param_01, param_03);
      break;

    case "loadoutSecondaryCamo":
      var_04 = !isDefined(self.botloadoutfavoritecamo) || param_03 == self.botloadoutfavoritecamo;
      break;

    case "loadoutStreak3":
    case "loadoutStreak2":
    case "loadoutStreak1":
      var_04 = scripts\mp\bots\_bots_killstreaks::bot_killstreak_is_valid_internal(param_03, "bots", undefined, param_01["loadoutStreakType"]);
      var_04 = var_04 && bot_loadout_item_allowed("killstreak", param_03, param_01["loadoutStreakType"]);
      break;

    case "loadoutPerk12":
    case "loadoutPerk11":
    case "loadoutPerk10":
    case "loadoutPerk9":
    case "loadoutPerk8":
    case "loadoutPerk7":
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_04 = bot_validate_perk(param_03, param_02, param_01, 1, 12, bot_loadout_perk_slots(param_01));
      break;

    case "loadoutPerk15":
    case "loadoutPerk14":
    case "loadoutPerk13":
      if(param_01["loadoutStreakType"] != "streaktype_specialist") {
        var_04 = 0;
      } else {
        var_04 = bot_validate_perk(param_03, param_02, param_01, -1, -1);
      }
      break;

    case "loadoutPerk23":
    case "loadoutPerk22":
    case "loadoutPerk21":
    case "loadoutPerk20":
    case "loadoutPerk19":
    case "loadoutPerk18":
    case "loadoutPerk17":
    case "loadoutPerk16":
      if(param_01["loadoutStreakType"] != "streaktype_specialist") {
        var_04 = 0;
      } else {
        var_04 = bot_validate_perk(param_03, param_02, param_01, 16, 23, 8);
      }
      break;
  }

  return var_04;
}

bot_loadout_choose_from_set(param_00, param_01, param_02, param_03, param_04) {
  var_05 = "none";
  var_06 = undefined;
  var_07 = 0;
  if(scripts\engine\utility::array_contains(param_00, "specialty_null")) {
    var_05 = "specialty_null";
  }

  foreach(var_09 in param_00) {
    var_0A = undefined;
    if(getsubstr(var_09, 0, 9) == "template_") {
      var_0A = var_09;
      var_0B = level.botloadouttemplates[var_09][param_03];
      var_09 = bot_loadout_choose_from_set(strtok(var_0B, "| "), param_01, param_02, param_03, 1);
      if(isDefined(var_0A) && isDefined(self.chosentemplates[var_0A])) {
        return var_09;
      }
    }

    if(var_09 == "attachmenttable") {
      return bot_loadout_choose_from_attachmenttable(param_01, param_02, param_03, self.personality, self.difficulty);
    }

    if(var_09 == "weap_statstable") {
      return bot_loadout_choose_from_statstable(param_01, param_02, param_03, self.botarchetype, self.personality, self.difficulty);
    }

    if(var_09 == "camotable") {
      return bot_loadout_choose_from_camotable(param_01, param_02, param_03, self.personality, self.difficulty);
    }

    if(getsubstr(var_09, 0, 5) == "class" && int(getsubstr(var_09, 5, 6)) > 0) {
      var_09 = bot_loadout_choose_from_default_class(var_09, param_01, param_02, param_03, self.personality, self.difficulty);
    }

    if(isDefined(level.bot_perktable) && getsubstr(var_09, 0, 10) == "perktable_") {
      return bot_loadout_choose_from_perktable(var_09, param_01, param_02, param_03, self.personality, self.difficulty);
    }

    if(bot_loadout_valid_choice(param_01, param_02, param_03, var_09)) {
      var_07 = var_07 + 1;
      if(randomfloat(1) <= 1 / var_07) {
        var_05 = var_09;
        var_06 = var_0A;
      }
    }
  }

  if(isDefined(var_06)) {
    self.chosentemplates[var_06] = 1;
  }

  return var_05;
}

bot_loadout_choose_values(param_00) {
  self.chosentemplates = [];
  foreach(var_06, var_02 in param_00) {
    var_03 = strtok(var_02, "| ");
    var_04 = bot_loadout_choose_from_set(var_03, var_02, param_00, var_06);
    param_00[var_06] = var_04;
  }

  return param_00;
}

bot_loadout_get_difficulty() {
  var_00 = "regular";
  var_00 = self botgetdifficulty();
  if(var_00 == "default") {
    scripts\mp\bots\_bots_util::bot_set_difficulty("default");
    var_00 = self botgetdifficulty();
  }

  return var_00;
}

bot_loadout_get_archetype() {
  if(!isDefined(self.botarchetype)) {
    var_00 = self botgetpersonality();
    var_01 = level.botarchetypes[var_00];
    var_02 = randomint(var_01.size);
    self.botarchetype = var_01[var_02];
  }

  return self.botarchetype;
}

bot_loadout_class_callback() {
  while(!isDefined(level.bot_loadouts_initialized)) {
    wait(0.05);
  }

  while(!isDefined(self.personality)) {
    wait(0.05);
  }

  var_00 = [];
  var_01 = bot_loadout_get_difficulty();
  self.difficulty = var_01;
  var_02 = self botgetpersonality();
  var_03 = bot_loadout_get_archetype();
  if(isDefined(self.botlastloadout)) {
    var_04 = self.botlastloadoutdifficulty == var_01;
    var_05 = self.botlastloadoutpersonality == var_02;
    if(var_04 && var_05 && !isDefined(self.hasdied) || self.hasdied && !isDefined(self.respawn_with_launcher)) {
      return self.botlastloadout;
    }
  }

  var_00 = bot_loadout_pick(var_03, var_02, var_01);
  var_00 = bot_loadout_choose_values(var_00);
  if(isDefined(level.bot_funcs["gametype_loadout_modify"])) {
    var_00 = self[[level.bot_funcs["gametype_loadout_modify"]]](var_00);
  }

  if(var_00["loadoutPrimary"] == "none") {
    self.bot_fallback_personality = undefined;
    var_00["loadoutPrimary"] = bot_loadout_choose_fallback_primary(var_00);
    var_00["loadoutPrimaryCamo"] = "none";
    var_00["loadoutPrimaryAttachment"] = "none";
    var_00["loadoutPrimaryAttachment2"] = "none";
    var_00["loadoutPrimaryAttachment3"] = "none";
    var_00["loadoutPrimaryReticle"] = "none";
    if(isDefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon") {
        bot_pick_personality_from_weapon(var_00["loadoutPrimary"]);
      } else {
        scripts\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);
      }

      var_02 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  self.botlastloadout = var_00;
  self.botlastloadoutdifficulty = var_01;
  self.botlastloadoutpersonality = var_02;
  if(isDefined(var_00["loadoutPrimaryCamo"]) && var_00["loadoutPrimaryCamo"] != "none") {
    self.botloadoutfavoritecamo = var_00["loadoutPrimaryCamo"];
  }

  if(isDefined(self.respawn_with_launcher)) {
    if(isDefined(level.bot_respawn_launcher_name) && bot_loadout_item_allowed("weapon", level.bot_respawn_launcher_name)) {
      var_00["loadoutSecondary"] = level.bot_respawn_launcher_name;
      var_00["loadoutSecondaryAttachment"] = "none";
      var_00["loadoutSecondaryAttachment2"] = "none";
      self.botlastloadout = undefined;
    }

    self.respawn_with_launcher = undefined;
  }

  var_00 = bot_loadout_setup_perks(var_00);
  if(scripts\mp\utility::bot_israndom()) {
    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
      var_06 = bot_loadout_pick("cqb", var_01);
      var_00["loadoutSecondary"] = var_06["loadoutPrimary"];
      var_00["loadoutSecondaryAttachment"] = var_06["loadoutPrimaryAttachment"];
      var_00["loadoutSecondaryAttachment2"] = var_06["loadoutPrimaryAttachment2"];
      var_00 = bot_loadout_choose_values(var_00);
      var_00 = bot_loadout_setup_perks(var_00);
    }

    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_extra_attachment")) {
      var_07 = bot_loadout_pick(var_02, var_01);
      var_00["loadoutPrimaryAttachment3"] = var_07["loadoutPrimaryAttachment2"];
      if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
        var_00["loadoutSecondaryAttachment2"] = var_07["loadoutPrimaryAttachment2"];
      } else {
        var_00["loadoutSecondaryAttachment2"] = var_07["loadoutSecondaryAttachment2"];
      }

      var_00 = bot_loadout_choose_values(var_00);
      var_00 = bot_loadout_setup_perks(var_00);
    } else {
      var_00["loadoutSecondaryAttachment2"] = "none";
      if(!bot_validate_reticle("loadoutSecondary", var_00, var_00["loadoutSecondaryReticle"])) {
        var_00["loadoutSecondaryReticle"] = "none";
      }
    }
  }

  return var_00;
}

bot_loadout_setup_perks(param_00) {
  self.pers["loadoutPerks"] = [];
  self.pers["specialistBonusStreaks"] = [];
  self.pers["specialistStreaks"] = [];
  self.pers["specialistStreakKills"] = [];
  var_01 = 0;
  var_02 = isDefined(param_00["loadoutStreakType"]) && param_00["loadoutStreakType"] == "streaktype_specialist";
  if(var_02) {
    param_00["loadoutStreak1"] = "none";
    param_00["loadoutStreak2"] = "none";
    param_00["loadoutStreak3"] = "none";
  }

  foreach(var_08, var_04 in param_00) {
    if(var_04 == "specialty_null" || var_04 == "none") {
      continue;
    }

    if(getsubstr(var_08, 0, 11) == "loadoutPerk") {
      var_05 = int(getsubstr(var_08, 11));
      if(!var_02 && var_05 > 12) {
        continue;
      }

      var_06 = scripts\mp\utility::getbaseperkname(var_04);
      if(var_05 <= 12) {
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var_06;
      } else if(var_05 <= 15) {
        param_00["loadoutStreak" + var_01 + 1] = var_06 + "_ks";
        self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var_06 + "_ks";
        var_07 = 0;
        if(var_01 > 0) {
          var_07 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];
        }

        self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_07 + bot_perk_cost(var_06) + 2;
        var_01++;
      } else {
        self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var_06;
      }
    }
  }

  if(var_02 && !isDefined(self.pers["specialistStreakKills"][0])) {
    self.pers["specialistStreakKills"][0] = 0;
    self.pers["specialistStreaks"][0] = "specialty_null";
  }

  if(var_02 && !isDefined(self.pers["specialistStreakKills"][1])) {
    self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
    self.pers["specialistStreaks"][1] = "specialty_null";
  }

  if(var_02 && !isDefined(self.pers["specialistStreakKills"][2])) {
    self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
    self.pers["specialistStreaks"][2] = "specialty_null";
  }

  return param_00;
}

bot_setup_loadout_callback() {
  var_00 = bot_loadout_get_archetype();
  var_01 = self botgetpersonality();
  var_02 = bot_loadout_get_difficulty();
  var_03 = bot_loadout_set(var_00, var_01, var_02, 0);
  if(isDefined(var_03) && isDefined(var_03.loadouts) && var_03.loadouts.size > 0) {
    self.classcallback = ::bot_loadout_class_callback;
    return 1;
  }

  var_04 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return 0;
}

bot_squad_lookup_private(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_06)) {
    return param_00 getplayerdata("privateloadouts", "squadMembers", "loadouts", param_02, param_03, param_04, param_05, param_06);
  }

  if(isDefined(param_05)) {
    return param_00 getplayerdata("privateloadouts", "squadMembers", "loadouts", param_02, param_03, param_04, param_05);
  }

  if(isDefined(param_04)) {
    return param_00 getplayerdata("privateloadouts", "squadMembers", "loadouts", param_02, param_03, param_04);
  }

  return param_00 getplayerdata("privateloadouts", "squadMembers", "loadouts", param_02, param_03);
}

bot_squad_lookup_ranked(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_06)) {
    return param_00 getplayerdata("rankedloadouts", "squadMembers", "loadouts", param_02, param_03, param_04, param_05, param_06);
  }

  if(isDefined(param_05)) {
    return param_00 getplayerdata("rankedloadouts", "squadMembers", "loadouts", param_02, param_03, param_04, param_05);
  }

  if(isDefined(param_04)) {
    return param_00 getplayerdata("rankedloadouts", "squadMembers", "loadouts", param_02, param_03, param_04);
  }

  return param_00 getplayerdata("rankedloadouts", "squadMembers", "loadouts", param_02, param_03);
}

bot_squad_lookup_enemy(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_06)) {
    return getenemysquaddata("squadMembers", "loadouts", param_02, param_03, param_04, param_05, param_06);
  }

  if(isDefined(param_05)) {
    return getenemysquaddata("squadMembers", "loadouts", param_02, param_03, param_04, param_05);
  }

  if(isDefined(param_04)) {
    return getenemysquaddata("squadMembers", "loadouts", param_02, param_03, param_04);
  }

  return getenemysquaddata("squadMembers", "loadouts", param_02, param_03);
}

bot_squad_lookup(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = ::bot_squad_lookup_ranked;
  if(getdvar("squad_match") == "1" && self.team == "axis") {
    var_07 = ::bot_squad_lookup_enemy;
  } else if(!scripts\mp\utility::matchmakinggame()) {
    var_07 = ::bot_squad_lookup_private;
  }

  return self[[var_07]](param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

bot_squadmember_lookup(param_00, param_01, param_02) {
  if(getdvar("squad_match") == "1" && self.team == "axis") {
    return getenemysquaddata("squadMembers", param_01, param_02);
  }

  if(!scripts\mp\utility::matchmakinggame()) {
    return param_00 getplayerdata("privateloadouts", "squadMembers", param_02);
  }

  return param_00 getplayerdata("rankedloadouts", "squadMembers", param_02);
}

bot_loadout_copy_from_client(param_00, param_01, param_02, param_03) {
  param_00["loadoutPrimary"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 0, "weapon");
  param_00["loadoutPrimaryAttachment"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 0, "attachment", 0);
  param_00["loadoutPrimaryAttachment2"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 0, "attachment", 1);
  param_00["loadoutPrimaryAttachment3"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 0, "attachment", 2);
  param_00["loadoutPrimaryCamo"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 0, "camo");
  param_00["loadoutPrimaryReticle"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 0, "reticle");
  param_00["loadoutSecondary"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 1, "weapon");
  param_00["loadoutSecondaryAttachment"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 1, "attachment", 0);
  param_00["loadoutSecondaryAttachment2"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 1, "attachment", 1);
  param_00["loadoutSecondaryCamo"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 1, "camo");
  param_00["loadoutSecondaryReticle"] = bot_squad_lookup(param_01, param_02, param_03, "weaponSetups", 1, "reticle");
  param_00["loadoutPowerPrimary"] = bot_squad_lookup(param_01, param_02, param_03, "perks", 0);
  param_00["loadoutPowerSecondary"] = bot_squad_lookup(param_01, param_02, param_03, "perks", 1);
  param_00["loadoutStreak1"] = "none";
  param_00["loadoutStreak2"] = "none";
  param_00["loadoutStreak3"] = "none";
  var_04 = bot_squad_lookup(param_01, param_02, param_03, "perks", 5);
  if(isDefined(var_04)) {
    param_00["loadoutStreakType"] = var_04;
    if(var_04 == "streaktype_assault") {
      param_00["loadoutStreak1"] = bot_squad_lookup(param_01, param_02, param_03, "assaultStreaks", 0);
      param_00["loadoutStreak2"] = bot_squad_lookup(param_01, param_02, param_03, "assaultStreaks", 1);
      param_00["loadoutStreak3"] = bot_squad_lookup(param_01, param_02, param_03, "assaultStreaks", 2);
    } else if(var_04 == "streaktype_support") {
      param_00["loadoutStreak1"] = bot_squad_lookup(param_01, param_02, param_03, "supportStreaks", 0);
      param_00["loadoutStreak2"] = bot_squad_lookup(param_01, param_02, param_03, "supportStreaks", 1);
      param_00["loadoutStreak3"] = bot_squad_lookup(param_01, param_02, param_03, "supportStreaks", 2);
    } else if(var_04 == "streaktype_specialist") {
      param_00["loadoutPerk13"] = bot_squad_lookup(param_01, param_02, param_03, "specialistStreaks", 0);
      param_00["loadoutPerk14"] = bot_squad_lookup(param_01, param_02, param_03, "specialistStreaks", 1);
      param_00["loadoutPerk15"] = bot_squad_lookup(param_01, param_02, param_03, "specialistStreaks", 2);
    }
  }

  param_00["loadoutCharacterType"] = bot_squad_lookup(param_01, param_02, param_03, "type");
  bot_pick_personality_from_weapon(param_00["loadoutPrimary"]);
  self.weaponfiretime = bot_squadmember_lookup(param_01, param_02, "patch");
  self.weaponfightdist = bot_squadmember_lookup(param_01, param_02, "background");
  return param_00;
}

bot_loadout_make_index(param_00, param_01, param_02) {
  return param_00 + "_" + param_01 + "_" + param_02;
}