/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_loadout.gsc
*********************************************/

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
  var_0 = "mp\botClassTable.csv";
  level.botloadoutsets = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;
  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "botArchetype", var_2);
    var_4 = tablelookup(var_0, 0, "botPersonalities", var_2);
    var_5 = tablelookup(var_0, 0, "botDifficulties", var_2);
    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    if(!isDefined(var_5) || var_5 == "") {
      break;
    }

    var_6 = [];
    foreach(var_8 in var_1) {
      var_6[var_8] = tablelookup(var_0, 0, var_8, var_2);
    }

    var_10 = strtok(var_3, "|");
    var_11 = strtok(var_4, "| ");
    var_12 = strtok(var_5, "| ");
    foreach(var_14 in var_10) {
      var_14 = "archetype_" + var_14;
      var_6["loadoutArchetype"] = var_14;
      foreach(var_10 in var_11) {
        foreach(var_12 in var_12) {
          var_13 = bot_loadout_set(var_14, var_10, var_12, 1);
          var_14 = spawnStruct();
          var_14.loadoutvalues = var_6;
          var_13.loadouts[var_13.loadouts.size] = var_14;
        }
      }
    }
  }
}

init_template_table() {
  var_0 = "mp\botTemplateTable.csv";
  level.botloadouttemplates = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;
  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "template_", var_2);
    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    var_4 = "template_" + var_3;
    level.botloadouttemplates[var_4] = [];
    foreach(var_6 in var_1) {
      var_7 = tablelookup(var_0, 0, var_6, var_2);
      if(isDefined(var_7) && var_7 != "") {
        level.botloadouttemplates[var_4][var_6] = var_7;
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

bot_loadout_item_allowed(var_0, var_1, var_2) {
  if(!isusingmatchrulesdata()) {
    return 1;
  }

  if(!getmatchrulesdata("commonOption", "allowCustomClasses")) {
    return 1;
  }

  if(var_1 == "specialty_null") {
    return 1;
  }

  if(var_1 == "none") {
    return 1;
  }

  if(var_0 == "equipment") {
    if(getmatchrulesdata("commonOption", "perkRestricted", var_1)) {
      return 0;
    }

    var_0 = "weapon";
  }

  var_3 = var_0 + "Restricted";
  var_4 = var_0 + "ClassRestricted";
  var_5 = "";
  switch (var_0) {
    case "weapon":
      var_5 = scripts\mp\utility::getweapongroup(var_1);
      break;

    case "attachment":
      var_5 = scripts\mp\utility::getattachmenttype(var_1);
      break;

    case "killstreak":
      var_5 = var_2;
      break;

    case "perk":
      var_5 = "ability_" + level.bot_perktypes[var_1];
      break;

    default:
      return 0;
  }

  if(getmatchrulesdata("commonOption", var_3, var_1)) {
    return 0;
  }

  if(getmatchrulesdata("commonOption", var_4, var_5)) {
    return 0;
  }

  return 1;
}

bot_loadout_choose_fallback_primary(var_0) {
  var_1 = "none";
  var_2 = ["veteran", "hardened", "regular", "recruit"];
  var_2 = scripts\engine\utility::array_randomize(var_2);
  foreach(var_4 in var_2) {
    var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimary", self.botarchetype, self.personality, var_4);
    if(var_1 != "none") {
      return var_1;
    }
  }

  if(isDefined(level.bot_personality_list)) {
    var_6 = scripts\engine\utility::array_randomize(level.bot_personality_list);
    foreach(var_8 in var_6) {
      foreach(var_4 in var_2) {
        var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimary", var_0["loadoutArchetype"], var_8, var_4);
        if(var_1 != "none") {
          self.bot_fallback_personality = var_8;
          return var_1;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    for(var_12 = 0; var_12 < 6 && !isDefined(var_1) || var_1 == "none" || var_1 == ""; var_12++) {
      if(scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", self.team, var_12, "class", "inUse")) {
        var_1 = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", self.team, var_12, "class", "weaponSetups", 0, "weapon");
        if(var_1 != "none") {
          self.bot_fallback_personality = "weapon";
          return var_1;
        }
      }
    }
  }

  self.bot_fallback_personality = "weapon";
  return level.bot_fallback_weapon;
}

bot_pick_personality_from_weapon(var_0) {
  if(isDefined(var_0)) {
    var_1 = level.bot_weap_personality[var_0];
    if(isDefined(var_1)) {
      var_2 = strtok(var_1, "| ");
      if(var_2.size > 0) {
        scripts\mp\bots\_bots_util::bot_set_personality(scripts\engine\utility::random(var_2));
        return;
      }
    }
  }
}

bot_loadout_fields() {
  var_0 = [];
  var_0[var_0.size] = "loadoutPrimary";
  var_0[var_0.size] = "loadoutPrimaryAttachment";
  var_0[var_0.size] = "loadoutPrimaryAttachment2";
  var_0[var_0.size] = "loadoutPrimaryCamo";
  var_0[var_0.size] = "loadoutPrimaryReticle";
  var_0[var_0.size] = "loadoutSecondary";
  var_0[var_0.size] = "loadoutSecondaryAttachment";
  var_0[var_0.size] = "loadoutSecondaryAttachment2";
  var_0[var_0.size] = "loadoutSecondaryCamo";
  var_0[var_0.size] = "loadoutSecondaryReticle";
  var_0[var_0.size] = "loadoutStreakType";
  var_0[var_0.size] = "loadoutStreak1";
  var_0[var_0.size] = "loadoutStreak2";
  var_0[var_0.size] = "loadoutStreak3";
  var_0[var_0.size] = "loadoutPowerPrimary";
  var_0[var_0.size] = "loadoutPowerSecondary";
  var_0[var_0.size] = "loadoutPerk1";
  var_0[var_0.size] = "loadoutPerk2";
  var_0[var_0.size] = "loadoutPerk3";
  return var_0;
}

bot_loadout_set(var_0, var_1, var_2, var_3) {
  var_4 = bot_loadout_make_index(var_0, var_1, var_2);
  if(!isDefined(level.botloadoutsets)) {
    level.botloadoutsets = [];
  }

  if(!isDefined(level.botloadoutsets[var_4]) && var_3) {
    level.botloadoutsets[var_4] = spawnStruct();
    level.botloadoutsets[var_4].loadouts = [];
  }

  if(isDefined(level.botloadoutsets[var_4])) {
    return level.botloadoutsets[var_4];
  }
}

bot_loadout_pick(var_0, var_1, var_2) {
  var_3 = bot_loadout_set(var_0, var_1, var_2, 0);
  if(isDefined(var_3) && isDefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    var_4 = randomint(var_3.loadouts.size);
    return var_3.loadouts[var_4].loadoutvalues;
  }
}

bot_validate_weapon(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility::getweaponattachmentarrayfromstats(var_0);
  if(isDefined(var_1) && var_1 != "none" && !bot_loadout_item_allowed("attachment", var_1)) {
    return 0;
  }

  if(isDefined(var_2) && var_2 != "none" && !bot_loadout_item_allowed("attachment", var_2)) {
    return 0;
  }

  if(isDefined(var_3) && var_3 != "none" && !bot_loadout_item_allowed("attachment", var_3)) {
    return 0;
  }

  if(var_1 != "none" && !scripts\engine\utility::array_contains(var_4, var_1)) {
    return 0;
  }

  if(var_2 != "none" && !scripts\engine\utility::array_contains(var_4, var_2)) {
    return 0;
  }

  if(isDefined(var_3) && var_3 != "none" && !scripts\engine\utility::array_contains(var_4, var_3)) {
    return 0;
  }

  if((var_1 == "none" || var_2 == "none") && !isDefined(var_3) || var_3 == "none") {
    return 1;
  }

  if(!isDefined(level.bot_invalid_attachment_combos)) {
    level.bot_invalid_attachment_combos = [];
    level.allowable_double_attachments = [];
    var_5 = "mp\attachmentcombos.csv";
    var_6 = 0;
    for(;;) {
      var_6++;
      var_7 = tablelookupbyrow(var_5, 0, var_6);
      if(var_7 == "") {
        break;
      }

      var_8 = 0;
      for(;;) {
        var_8++;
        var_9 = tablelookupbyrow(var_5, var_8, 0);
        if(var_9 == "") {
          break;
        }

        if(var_9 == var_7) {
          if(tablelookupbyrow(var_5, var_8, var_6) != "no") {
            level.allowable_double_attachments[var_9] = 1;
          }

          continue;
        }

        if(tablelookupbyrow(var_5, var_8, var_6) == "no") {
          level.bot_invalid_attachment_combos[var_7][var_9] = 1;
        }
      }
    }
  }

  if(var_1 == var_2 && !isDefined(level.allowable_double_attachments[var_1])) {
    return 0;
  }

  if(isDefined(var_3)) {
    if(var_2 == var_3 && !isDefined(level.allowable_double_attachments[var_2])) {
      return 0;
    }

    if(var_1 == var_3 && !isDefined(level.allowable_double_attachments[var_1])) {
      return 0;
    }

    if(var_3 != "none" && var_1 == var_3 && var_2 == var_3) {
      return 0;
    }

    if(isDefined(level.bot_invalid_attachment_combos[var_2]) && isDefined(level.bot_invalid_attachment_combos[var_2][var_3])) {
      return 0;
    }

    if(isDefined(level.bot_invalid_attachment_combos[var_1]) && isDefined(level.bot_invalid_attachment_combos[var_1][var_3])) {
      return 0;
    }
  }

  return !isDefined(level.bot_invalid_attachment_combos[var_1]) && isDefined(level.bot_invalid_attachment_combos[var_1][var_2]);
}

bot_validate_reticle(var_0, var_1, var_2) {
  if(isDefined(var_1[var_0 + "Attachment"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "Attachment"]])) {
    return 1;
  }

  if(isDefined(var_1[var_0 + "Attachment2"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "Attachment2"]])) {
    return 1;
  }

  if(isDefined(var_1[var_0 + "Attachment3"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "Attachment3"]])) {
    return 1;
  }

  return 0;
}

bot_perk_cost(var_0) {
  return level.perktable_costs[var_0];
}

perktable_add(var_0, var_1) {
  if(bot_perk_cost(var_0) > 0) {
    var_2 = [];
    var_2["type"] = var_1;
    var_2["name"] = var_0;
    level.bot_perktable[level.bot_perktable.size] = var_2;
    level.bot_perktypes[var_0] = var_1;
  }
}

init_perktable() {
  level.perktable_costs = [];
  var_0 = 1;
  for(;;) {
    var_1 = tablelookupbyrow("mp\perktable.csv", var_0, 1);
    if(var_1 == "") {
      break;
    }

    level.perktable_costs[var_1] = int(tablelookupbyrow("mp\perktable.csv", var_0, 10));
    var_0++;
  }

  level.perktable_costs["none"] = 0;
  level.perktable_costs["specialty_null"] = 0;
  level.bot_perktable = [];
  level.bot_perktypes = [];
  var_0 = 1;
  var_2 = "ability_null";
  while(isDefined(var_2) && var_2 != "") {
    var_2 = getsubstr(var_2, 8);
    for(var_3 = 4; var_3 <= 13; var_3++) {
      var_1 = tablelookupbyrow("mp\cacabilitytable.csv", var_0, var_3);
      if(var_1 != "") {
        perktable_add(var_1, var_2);
      }
    }

    var_0++;
    var_2 = tablelookupbyrow("mp\cacabilitytable.csv", var_0, 1);
  }
}

init_bot_weap_statstable() {
  var_0 = "mp\statstable.csv";
  var_1 = 4;
  var_2 = 38;
  var_3 = 39;
  var_4 = 40;
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];
  var_5 = 1;
  for(;;) {
    var_6 = tablelookupbyrow(var_0, var_5, var_1);
    if(var_6 == "specialty_null") {
      break;
    }

    var_7 = tablelookupbyrow(var_0, var_5, var_2);
    var_8 = tablelookupbyrow(var_0, var_5, var_4);
    var_9 = tablelookupbyrow(var_0, var_5, var_3);
    if(var_6 != "" && var_9 != "") {
      level.bot_weap_personality[var_6] = var_9;
    }

    if(var_8 != "" && var_6 != "" && var_9 != "" && var_7 != "") {
      var_10 = "loadoutPrimary";
      if(scripts\mp\utility::iscacsecondaryweapon(var_6)) {
        var_10 = "loadoutSecondary";
      } else if(!scripts\mp\utility::iscacprimaryweapon(var_6)) {
        var_5++;
        continue;
      }

      if(!isDefined(level.bot_weap_statstable[var_10])) {
        level.bot_weap_statstable[var_10] = [];
      }

      var_11 = strtok(var_7, "|");
      var_12 = strtok(var_9, "| ");
      var_13 = strtok(var_8, "| ");
      foreach(var_15 in var_11) {
        var_15 = "archetype_" + var_15;
        foreach(var_11 in var_12) {
          foreach(var_13 in var_13) {
            var_14 = bot_loadout_make_index(var_15, var_11, var_13);
            if(!isDefined(level.bot_weap_statstable[var_10][var_14])) {
              level.bot_weap_statstable[var_10][var_14] = [];
            }

            var_15 = level.bot_weap_statstable[var_10][var_14].size;
            level.bot_weap_statstable[var_10][var_14][var_15] = var_6;
          }
        }
      }
    }

    var_5++;
  }
}

bot_loadout_choose_from_statstable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "specialty_null";
  if(var_2 == "loadoutPrimary") {
    var_6 = "iw7_ar57";
  } else if(var_2 == "loadoutSecondary") {
    var_6 = "iw7_revolver";
  }

  if(var_4 == "default") {
    var_4 = "run_and_gun";
  }

  if(var_2 == "loadoutSecondary" && scripts\engine\utility::array_contains(var_1, "specialty_twoprimaries")) {
    var_2 = "loadoutPrimary";
  }

  if(!isDefined(level.bot_weap_statstable)) {
    return var_6;
  }

  if(!isDefined(level.bot_weap_statstable[var_2])) {
    return var_6;
  }

  var_7 = bot_loadout_make_index(var_3, var_4, var_5);
  if(!isDefined(level.bot_weap_statstable[var_2][var_7])) {
    return var_6;
  }

  var_6 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_2][var_7], var_0, var_1, var_2);
  return var_6;
}

bot_loadout_choose_from_perktable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "specialty_null";
  if(!isDefined(level.bot_perktable)) {
    return var_6;
  }

  if(!isDefined(level.bot_perktable_groups)) {
    level.bot_perktable_groups = [];
  }

  if(!isDefined(level.bot_perktable_groups[var_0])) {
    var_7 = strtok(var_0, "_");
    var_7[0] = "";
    var_8 = 0;
    if(scripts\engine\utility::array_contains(var_7, "any")) {
      var_8 = 1;
    }

    var_9 = [];
    foreach(var_11 in level.bot_perktable) {
      if(var_8 || scripts\engine\utility::array_contains(var_7, var_11["type"])) {
        var_9[var_9.size] = var_11["name"];
      }
    }

    level.bot_perktable_groups[var_0] = var_9;
  }

  if(level.bot_perktable_groups[var_0].size > 0) {
    var_6 = bot_loadout_choose_from_set(level.bot_perktable_groups[var_0], var_1, var_2, var_3);
  }

  return var_6;
}

bot_validate_perk(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4 - var_3 + 1;
  if(isDefined(var_5)) {
    var_6 = var_5;
  }

  var_7 = 0;
  var_8 = int(getsubstr(var_1, 11));
  if(var_0 == "specialty_twoprimaries") {
    return 0;
  }

  if(var_0 == "specialty_extra_attachment") {
    return 0;
  }

  if(!bot_loadout_item_allowed("perk", var_0)) {
    return 0;
  }

  for(var_9 = var_8 - 1; var_9 > 0; var_9--) {
    var_10 = "loadoutPerk" + var_9;
    if(var_2[var_10] == "none" || var_2[var_10] == "specialty_null") {
      continue;
    }

    if(var_0 == var_2[var_10]) {
      return 0;
    }

    if(var_9 >= var_3 && var_9 <= var_4) {
      var_7 = var_7 + bot_perk_cost(var_2[var_10]);
    }
  }

  if(var_7 + bot_perk_cost(var_0) > var_6) {
    return 0;
  }

  return 1;
}

bot_loadout_choose_from_default_class(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = int(getsubstr(var_0, 5, 6)) - 1;
  switch (var_3) {
    case "loadoutPrimary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_6, 0);

    case "loadoutPrimaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_6, 0, 0);

    case "loadoutPrimaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_6, 0, 1);

    case "loadoutPrimaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_6, 0);

    case "loadoutPrimaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_6, 0);

    case "loadoutSecondary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_6, 1);

    case "loadoutSecondaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_6, 1, 0);

    case "loadoutSecondaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_6, 1, 1);

    case "loadoutSecondaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_6, 1);

    case "loadoutSecondaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_6, 1);

    case "loadoutStreak1":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_6, 0);

    case "loadoutStreak2":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_6, 1);

    case "loadoutStreak3":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_6, 2);

    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_7 = int(getsubstr(var_3, 11));
      var_8 = scripts\mp\class::table_getperk(level.classtablename, var_6, var_7);
      if(var_8 == "") {
        return "specialty_null";
      }

      var_9 = int(getsubstr(var_8, 0, 1));
      var_10 = int(getsubstr(var_8, 1, 2));
      var_11 = tablelookupbyrow("mp\cacabilitytable.csv", var_9 + 1, var_10 + 3);
      return var_11;
  }

  return var_5;
}

init_bot_attachmenttable() {
  var_0 = "mp\attachmenttable.csv";
  var_1 = 5;
  var_2 = 19;
  var_3 = 11;
  level.bot_attachmenttable = [];
  level.bot_attachment_reticle = [];
  var_4 = 1;
  for(;;) {
    var_5 = tablelookupbyrow(var_0, var_4, var_1);
    if(var_5 == "done") {
      break;
    }

    var_6 = tablelookupbyrow(var_0, var_4, var_2);
    if(var_5 != "" && var_6 != "") {
      var_7 = tablelookupbyrow(var_0, var_4, var_3);
      if(var_7 == "TRUE") {
        level.bot_attachment_reticle[var_5] = 1;
      }

      var_8 = strtok(var_6, "| ");
      foreach(var_10 in var_8) {
        if(!isDefined(level.bot_attachmenttable[var_10])) {
          level.bot_attachmenttable[var_10] = [];
        }

        if(!scripts\engine\utility::array_contains(level.bot_attachmenttable[var_10], var_5)) {
          var_11 = level.bot_attachmenttable[var_10].size;
          level.bot_attachmenttable[var_10][var_11] = var_5;
        }
      }
    }

    var_4++;
  }
}

bot_loadout_choose_from_attachmenttable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  if(!isDefined(level.bot_attachmenttable)) {
    return var_5;
  }

  if(!isDefined(level.bot_attachmenttable[var_4])) {
    return var_5;
  }

  var_5 = bot_loadout_choose_from_set(level.bot_attachmenttable[var_4], var_0, var_1, var_2);
  return var_5;
}

init_bot_camotable() {
  var_0 = "mp\camotable.csv";
  level.var_2D1E = [];
  var_1 = 0;
  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, scripts\engine\utility::getcamotablecolumnindex("ref"));
    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, scripts\engine\utility::getcamotablecolumnindex("bot_valid"));
    if(isDefined(var_3) && int(var_3)) {
      level.var_2D1E[level.var_2D1E.size] = var_2;
    }

    var_1++;
  }
}

bot_loadout_choose_from_camotable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  return var_5;
}

bot_loadout_perk_slots(var_0) {
  var_1 = 8;
  if(isDefined(var_0["loadoutPrimary"]) && var_0["loadoutPrimary"] == "none") {
    var_1 = var_1 + 1;
  }

  if(isDefined(var_0["loadoutSecondary"]) && var_0["loadoutSecondary"] == "none") {
    var_1 = var_1 + 1;
  }

  if(isDefined(var_0["loadoutPowerPrimary"]) && var_0["loadoutPowerPrimary"] == "none") {
    var_1 = var_1 + 1;
  }

  if(isDefined(var_0["loadoutPowerSecondary"]) && var_0["loadoutPowerSecondary"] == "none") {
    var_1 = var_1 + 1;
  }

  return var_1;
}

bot_loadout_valid_choice(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  switch (var_2) {
    case "loadoutPrimary":
      var_4 = bot_loadout_item_allowed("weapon", var_3);
      break;

    case "loadoutPowerSecondary":
    case "loadoutPowerPrimary":
      var_4 = bot_loadout_item_allowed("equipment", var_3);
      break;

    case "loadoutPrimaryAttachment":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_3, "none");
      break;

    case "loadoutPrimaryAttachment2":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_3);
      break;

    case "loadoutPrimaryAttachment3":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_1["loadoutPrimaryAttachment2"], var_3);
      break;

    case "loadoutPrimaryReticle":
      var_4 = bot_validate_reticle("loadoutPrimary", var_1, var_3);
      break;

    case "loadoutPrimaryCamo":
      var_4 = !isDefined(self.botloadoutfavoritecamo) || var_3 == self.botloadoutfavoritecamo;
      break;

    case "loadoutSecondary":
      var_4 = var_3 != var_1["loadoutPrimary"];
      var_4 = var_4 && bot_loadout_item_allowed("weapon", var_3);
      break;

    case "loadoutSecondaryAttachment":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_3, "none");
      break;

    case "loadoutSecondaryAttachment2":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_3);
      break;

    case "loadoutSecondaryAttachment3":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_1["loadoutSecondaryAttachment2"], var_3);
      break;

    case "loadoutSecondaryReticle":
      var_4 = bot_validate_reticle("loadoutSecondary", var_1, var_3);
      break;

    case "loadoutSecondaryCamo":
      var_4 = !isDefined(self.botloadoutfavoritecamo) || var_3 == self.botloadoutfavoritecamo;
      break;

    case "loadoutStreak3":
    case "loadoutStreak2":
    case "loadoutStreak1":
      var_4 = scripts\mp\bots\_bots_killstreaks::bot_killstreak_is_valid_internal(var_3, "bots", undefined, var_1["loadoutStreakType"]);
      var_4 = var_4 && bot_loadout_item_allowed("killstreak", var_3, var_1["loadoutStreakType"]);
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
      var_4 = bot_validate_perk(var_3, var_2, var_1, 1, 12, bot_loadout_perk_slots(var_1));
      break;

    case "loadoutPerk15":
    case "loadoutPerk14":
    case "loadoutPerk13":
      if(var_1["loadoutStreakType"] != "streaktype_specialist") {
        var_4 = 0;
      } else {
        var_4 = bot_validate_perk(var_3, var_2, var_1, -1, -1);
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
      if(var_1["loadoutStreakType"] != "streaktype_specialist") {
        var_4 = 0;
      } else {
        var_4 = bot_validate_perk(var_3, var_2, var_1, 16, 23, 8);
      }
      break;
  }

  return var_4;
}

bot_loadout_choose_from_set(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  var_6 = undefined;
  var_7 = 0;
  if(scripts\engine\utility::array_contains(var_0, "specialty_null")) {
    var_5 = "specialty_null";
  }

  foreach(var_9 in var_0) {
    var_10 = undefined;
    if(getsubstr(var_9, 0, 9) == "template_") {
      var_10 = var_9;
      var_11 = level.botloadouttemplates[var_9][var_3];
      var_9 = bot_loadout_choose_from_set(strtok(var_11, "| "), var_1, var_2, var_3, 1);
      if(isDefined(var_10) && isDefined(self.chosentemplates[var_10])) {
        return var_9;
      }
    }

    if(var_9 == "attachmenttable") {
      return bot_loadout_choose_from_attachmenttable(var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(var_9 == "weap_statstable") {
      return bot_loadout_choose_from_statstable(var_1, var_2, var_3, self.botarchetype, self.personality, self.difficulty);
    }

    if(var_9 == "camotable") {
      return bot_loadout_choose_from_camotable(var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(getsubstr(var_9, 0, 5) == "class" && int(getsubstr(var_9, 5, 6)) > 0) {
      var_9 = bot_loadout_choose_from_default_class(var_9, var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(isDefined(level.bot_perktable) && getsubstr(var_9, 0, 10) == "perktable_") {
      return bot_loadout_choose_from_perktable(var_9, var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(bot_loadout_valid_choice(var_1, var_2, var_3, var_9)) {
      var_7 = var_7 + 1;
      if(randomfloat(1) <= 1 / var_7) {
        var_5 = var_9;
        var_6 = var_10;
      }
    }
  }

  if(isDefined(var_6)) {
    self.chosentemplates[var_6] = 1;
  }

  return var_5;
}

bot_loadout_choose_values(var_0) {
  self.chosentemplates = [];
  foreach(var_6, var_2 in var_0) {
    var_3 = strtok(var_2, "| ");
    var_4 = bot_loadout_choose_from_set(var_3, var_2, var_0, var_6);
    var_0[var_6] = var_4;
  }

  return var_0;
}

bot_loadout_get_difficulty() {
  var_0 = "regular";
  var_0 = self botgetdifficulty();
  if(var_0 == "default") {
    scripts\mp\bots\_bots_util::bot_set_difficulty("default");
    var_0 = self botgetdifficulty();
  }

  return var_0;
}

bot_loadout_get_archetype() {
  if(!isDefined(self.botarchetype)) {
    var_0 = self botgetpersonality();
    var_1 = level.botarchetypes[var_0];
    var_2 = randomint(var_1.size);
    self.botarchetype = var_1[var_2];
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

  var_0 = [];
  var_1 = bot_loadout_get_difficulty();
  self.difficulty = var_1;
  var_2 = self botgetpersonality();
  var_3 = bot_loadout_get_archetype();
  if(isDefined(self.botlastloadout)) {
    var_4 = self.botlastloadoutdifficulty == var_1;
    var_5 = self.botlastloadoutpersonality == var_2;
    if(var_4 && var_5 && !isDefined(self.hasdied) || self.hasdied && !isDefined(self.respawn_with_launcher)) {
      return self.botlastloadout;
    }
  }

  var_0 = bot_loadout_pick(var_3, var_2, var_1);
  var_0 = bot_loadout_choose_values(var_0);
  if(isDefined(level.bot_funcs["gametype_loadout_modify"])) {
    var_0 = self[[level.bot_funcs["gametype_loadout_modify"]]](var_0);
  }

  if(var_0["loadoutPrimary"] == "none") {
    self.bot_fallback_personality = undefined;
    var_0["loadoutPrimary"] = bot_loadout_choose_fallback_primary(var_0);
    var_0["loadoutPrimaryCamo"] = "none";
    var_0["loadoutPrimaryAttachment"] = "none";
    var_0["loadoutPrimaryAttachment2"] = "none";
    var_0["loadoutPrimaryAttachment3"] = "none";
    var_0["loadoutPrimaryReticle"] = "none";
    if(isDefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon") {
        bot_pick_personality_from_weapon(var_0["loadoutPrimary"]);
      } else {
        scripts\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);
      }

      var_2 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  self.botlastloadout = var_0;
  self.botlastloadoutdifficulty = var_1;
  self.botlastloadoutpersonality = var_2;
  if(isDefined(var_0["loadoutPrimaryCamo"]) && var_0["loadoutPrimaryCamo"] != "none") {
    self.botloadoutfavoritecamo = var_0["loadoutPrimaryCamo"];
  }

  if(isDefined(self.respawn_with_launcher)) {
    if(isDefined(level.bot_respawn_launcher_name) && bot_loadout_item_allowed("weapon", level.bot_respawn_launcher_name)) {
      var_0["loadoutSecondary"] = level.bot_respawn_launcher_name;
      var_0["loadoutSecondaryAttachment"] = "none";
      var_0["loadoutSecondaryAttachment2"] = "none";
      self.botlastloadout = undefined;
    }

    self.respawn_with_launcher = undefined;
  }

  var_0 = bot_loadout_setup_perks(var_0);
  if(scripts\mp\utility::bot_israndom()) {
    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
      var_6 = bot_loadout_pick("cqb", var_1);
      var_0["loadoutSecondary"] = var_6["loadoutPrimary"];
      var_0["loadoutSecondaryAttachment"] = var_6["loadoutPrimaryAttachment"];
      var_0["loadoutSecondaryAttachment2"] = var_6["loadoutPrimaryAttachment2"];
      var_0 = bot_loadout_choose_values(var_0);
      var_0 = bot_loadout_setup_perks(var_0);
    }

    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_extra_attachment")) {
      var_7 = bot_loadout_pick(var_2, var_1);
      var_0["loadoutPrimaryAttachment3"] = var_7["loadoutPrimaryAttachment2"];
      if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
        var_0["loadoutSecondaryAttachment2"] = var_7["loadoutPrimaryAttachment2"];
      } else {
        var_0["loadoutSecondaryAttachment2"] = var_7["loadoutSecondaryAttachment2"];
      }

      var_0 = bot_loadout_choose_values(var_0);
      var_0 = bot_loadout_setup_perks(var_0);
    } else {
      var_0["loadoutSecondaryAttachment2"] = "none";
      if(!bot_validate_reticle("loadoutSecondary", var_0, var_0["loadoutSecondaryReticle"])) {
        var_0["loadoutSecondaryReticle"] = "none";
      }
    }
  }

  return var_0;
}

bot_loadout_setup_perks(var_0) {
  self.pers["loadoutPerks"] = [];
  self.pers["specialistBonusStreaks"] = [];
  self.pers["specialistStreaks"] = [];
  self.pers["specialistStreakKills"] = [];
  var_1 = 0;
  var_2 = isDefined(var_0["loadoutStreakType"]) && var_0["loadoutStreakType"] == "streaktype_specialist";
  if(var_2) {
    var_0["loadoutStreak1"] = "none";
    var_0["loadoutStreak2"] = "none";
    var_0["loadoutStreak3"] = "none";
  }

  foreach(var_8, var_4 in var_0) {
    if(var_4 == "specialty_null" || var_4 == "none") {
      continue;
    }

    if(getsubstr(var_8, 0, 11) == "loadoutPerk") {
      var_5 = int(getsubstr(var_8, 11));
      if(!var_2 && var_5 > 12) {
        continue;
      }

      var_6 = scripts\mp\utility::getbaseperkname(var_4);
      if(var_5 <= 12) {
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var_6;
      } else if(var_5 <= 15) {
        var_0["loadoutStreak" + var_1 + 1] = var_6 + "_ks";
        self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var_6 + "_ks";
        var_7 = 0;
        if(var_1 > 0) {
          var_7 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];
        }

        self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_7 + bot_perk_cost(var_6) + 2;
        var_1++;
      } else {
        self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var_6;
      }
    }
  }

  if(var_2 && !isDefined(self.pers["specialistStreakKills"][0])) {
    self.pers["specialistStreakKills"][0] = 0;
    self.pers["specialistStreaks"][0] = "specialty_null";
  }

  if(var_2 && !isDefined(self.pers["specialistStreakKills"][1])) {
    self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
    self.pers["specialistStreaks"][1] = "specialty_null";
  }

  if(var_2 && !isDefined(self.pers["specialistStreakKills"][2])) {
    self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
    self.pers["specialistStreaks"][2] = "specialty_null";
  }

  return var_0;
}

bot_setup_loadout_callback() {
  var_0 = bot_loadout_get_archetype();
  var_1 = self botgetpersonality();
  var_2 = bot_loadout_get_difficulty();
  var_3 = bot_loadout_set(var_0, var_1, var_2, 0);
  if(isDefined(var_3) && isDefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    self.classcallback = ::bot_loadout_class_callback;
    return 1;
  }

  var_4 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return 0;
}

bot_squad_lookup_private(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    return var_0 getplayerdata("privateloadouts", "squadMembers", "loadouts", var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    return var_0 getplayerdata("privateloadouts", "squadMembers", "loadouts", var_2, var_3, var_4, var_5);
  }

  if(isDefined(var_4)) {
    return var_0 getplayerdata("privateloadouts", "squadMembers", "loadouts", var_2, var_3, var_4);
  }

  return var_0 getplayerdata("privateloadouts", "squadMembers", "loadouts", var_2, var_3);
}

bot_squad_lookup_ranked(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    return var_0 getplayerdata("rankedloadouts", "squadMembers", "loadouts", var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    return var_0 getplayerdata("rankedloadouts", "squadMembers", "loadouts", var_2, var_3, var_4, var_5);
  }

  if(isDefined(var_4)) {
    return var_0 getplayerdata("rankedloadouts", "squadMembers", "loadouts", var_2, var_3, var_4);
  }

  return var_0 getplayerdata("rankedloadouts", "squadMembers", "loadouts", var_2, var_3);
}

bot_squad_lookup_enemy(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    return getenemysquaddata("squadMembers", "loadouts", var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    return getenemysquaddata("squadMembers", "loadouts", var_2, var_3, var_4, var_5);
  }

  if(isDefined(var_4)) {
    return getenemysquaddata("squadMembers", "loadouts", var_2, var_3, var_4);
  }

  return getenemysquaddata("squadMembers", "loadouts", var_2, var_3);
}

bot_squad_lookup(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = ::bot_squad_lookup_ranked;
  if(getdvar("squad_match") == "1" && self.team == "axis") {
    var_7 = ::bot_squad_lookup_enemy;
  } else if(!scripts\mp\utility::matchmakinggame()) {
    var_7 = ::bot_squad_lookup_private;
  }

  return self[[var_7]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

bot_squadmember_lookup(var_0, var_1, var_2) {
  if(getdvar("squad_match") == "1" && self.team == "axis") {
    return getenemysquaddata("squadMembers", var_1, var_2);
  }

  if(!scripts\mp\utility::matchmakinggame()) {
    return var_0 getplayerdata("privateloadouts", "squadMembers", var_2);
  }

  return var_0 getplayerdata("rankedloadouts", "squadMembers", var_2);
}

bot_loadout_copy_from_client(var_0, var_1, var_2, var_3) {
  var_0["loadoutPrimary"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 0, "weapon");
  var_0["loadoutPrimaryAttachment"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 0, "attachment", 0);
  var_0["loadoutPrimaryAttachment2"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 0, "attachment", 1);
  var_0["loadoutPrimaryAttachment3"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 0, "attachment", 2);
  var_0["loadoutPrimaryCamo"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 0, "camo");
  var_0["loadoutPrimaryReticle"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 0, "reticle");
  var_0["loadoutSecondary"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 1, "weapon");
  var_0["loadoutSecondaryAttachment"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 1, "attachment", 0);
  var_0["loadoutSecondaryAttachment2"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 1, "attachment", 1);
  var_0["loadoutSecondaryCamo"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 1, "camo");
  var_0["loadoutSecondaryReticle"] = bot_squad_lookup(var_1, var_2, var_3, "weaponSetups", 1, "reticle");
  var_0["loadoutPowerPrimary"] = bot_squad_lookup(var_1, var_2, var_3, "perks", 0);
  var_0["loadoutPowerSecondary"] = bot_squad_lookup(var_1, var_2, var_3, "perks", 1);
  var_0["loadoutStreak1"] = "none";
  var_0["loadoutStreak2"] = "none";
  var_0["loadoutStreak3"] = "none";
  var_4 = bot_squad_lookup(var_1, var_2, var_3, "perks", 5);
  if(isDefined(var_4)) {
    var_0["loadoutStreakType"] = var_4;
    if(var_4 == "streaktype_assault") {
      var_0["loadoutStreak1"] = bot_squad_lookup(var_1, var_2, var_3, "assaultStreaks", 0);
      var_0["loadoutStreak2"] = bot_squad_lookup(var_1, var_2, var_3, "assaultStreaks", 1);
      var_0["loadoutStreak3"] = bot_squad_lookup(var_1, var_2, var_3, "assaultStreaks", 2);
    } else if(var_4 == "streaktype_support") {
      var_0["loadoutStreak1"] = bot_squad_lookup(var_1, var_2, var_3, "supportStreaks", 0);
      var_0["loadoutStreak2"] = bot_squad_lookup(var_1, var_2, var_3, "supportStreaks", 1);
      var_0["loadoutStreak3"] = bot_squad_lookup(var_1, var_2, var_3, "supportStreaks", 2);
    } else if(var_4 == "streaktype_specialist") {
      var_0["loadoutPerk13"] = bot_squad_lookup(var_1, var_2, var_3, "specialistStreaks", 0);
      var_0["loadoutPerk14"] = bot_squad_lookup(var_1, var_2, var_3, "specialistStreaks", 1);
      var_0["loadoutPerk15"] = bot_squad_lookup(var_1, var_2, var_3, "specialistStreaks", 2);
    }
  }

  var_0["loadoutCharacterType"] = bot_squad_lookup(var_1, var_2, var_3, "type");
  bot_pick_personality_from_weapon(var_0["loadoutPrimary"]);
  self.weaponfiretime = bot_squadmember_lookup(var_1, var_2, "patch");
  self.weaponfightdist = bot_squadmember_lookup(var_1, var_2, "background");
  return var_0;
}

bot_loadout_make_index(var_0, var_1, var_2) {
  return var_0 + "_" + var_1 + "_" + var_2;
}