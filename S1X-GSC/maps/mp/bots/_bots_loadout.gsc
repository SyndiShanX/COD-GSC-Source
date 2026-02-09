/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_loadout.gsc
******************************************/

init() {
  init_template_table();
  init_class_table();
  init_bot_attachmenttable();
  init_bot_weap_statstable();
  init_bot_reticletable();
  init_bot_camotable();
  level.bot_min_rank_for_item = [];
  level.bot_loadouts_initialized = 1;
}

init_class_table() {
  var_0 = "mp/botClassTable.csv";
  level.botloadoutsets = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "botPersonalities", var_2);
    var_4 = tablelookup(var_0, 0, "botDifficulties", var_2);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = [];

    foreach(var_7 in var_1) {
      var_5[var_7] = tablelookup(var_0, 0, var_7, var_2);
    }

    var_9 = strtok(var_3, "| ");
    var_10 = strtok(var_4, "| ");

    foreach(var_12 in var_9) {
      foreach(var_14 in var_10) {
        var_15 = bot_loadout_set(var_12, var_14, 1);
        var_16 = spawnStruct();
        var_16.loadoutvalues = var_5;
        var_15.loadouts[var_15.loadouts.size] = var_16;
      }
    }
  }
}

init_template_table() {
  var_0 = "mp/botTemplateTable.csv";
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

bot_custom_classes_allowed() {
  if(isusingmatchrulesdata() && !getmatchrulesdata("commonOption", "allowCustomClasses")) {
    return 0;
  }

  return 1;
}

bot_loadout_item_allowed(var_0, var_1, var_2) {
  if(!isusingmatchrulesdata()) {
    return 1;
  }

  if(!bot_custom_classes_allowed()) {
    return 0;
  }

  if(var_1 == "specialty_null") {
    return 1;
  }

  if(var_1 == "none") {
    return 1;
  }

  var_3 = var_0 + "Restricted";
  var_4 = var_0 + "ClassRestricted";
  var_5 = "";

  switch (var_0) {
    case "weapon":
      var_5 = maps\mp\_utility::getweaponclass(var_1);
      break;
    case "attachment":
      var_5 = maps\mp\_utility::getattachmenttype(var_1);
      break;
    case "killstreak":
      if(getmatchrulesdata("commonOption", "allStreaksRestricted")) {
        return 0;
      }

      break;
    case "module":
      var_5 = maps\mp\killstreaks\_killstreaks::getstreakmodulebasekillstreak(var_1);

      if(getsubstr(var_5, 0, 3) == "zm_") {
        return 0;
      }

      break;
    case "perk":
      var_5 = var_2;
      break;
    default:
      return 0;
  }

  if(getmatchrulesdata("commonOption", var_3, var_1)) {
    return 0;
  }

  if(var_5 != "" && getmatchrulesdata("commonOption", var_4, var_5)) {
    return 0;
  }

  return 1;
}

bot_loadout_choose_fallback_primary(var_0) {
  var_1 = "none";
  var_2 = ["veteran", "hardened", "regular", "recruit"];
  var_2 = common_scripts\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimary", self.personality, var_4);

    if(var_1 != "none") {
      return var_1;
    }
  }

  if(isDefined(level.bot_personality_list)) {
    var_6 = common_scripts\utility::array_randomize(level.bot_personality_list);

    foreach(var_8 in var_6) {
      foreach(var_4 in var_2) {
        var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimary", var_8, var_4);

        if(var_1 != "none") {
          self.bot_fallback_personality = var_8;
          return var_1;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    var_12 = 0.0;
    var_13 = 0;

    for(var_14 = "none"; var_13 < 6; var_13++) {
      if(getmatchrulesdata("defaultClasses", bot_loadout_team(), var_13, "class", "inUse")) {
        var_1 = bot_loadout_choose_from_custom_default_class(var_13, "loadoutPrimary");

        if(var_1 != "none") {
          var_12 = var_12 + 1.0;

          if(randomfloat(1.0) >= 1.0 / var_12) {
            var_14 = var_1;
          }
        }
      }
    }

    if(var_14 != "none") {
      self.bot_fallback_personality = "weapon";
      return var_14;
    }
  }

  self.bot_fallback_personality = "weapon";
  return level.bot_fallback_weapon;
}

bot_loadout_team() {
  if(!isDefined(level.teambased) || !level.teambased) {
    return "allies";
  }

  return maps\mp\bots\_bots::bot_get_player_team();
}

bot_default_class_random() {
  var_0 = ["class1", "class2", "class3", "class4", "class5"];

  if(isusingmatchrulesdata()) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(getmatchrulesdata("defaultClasses", bot_loadout_team(), var_1, "class", "inUse")) {
        var_0[var_1] = var_1;
      }
    }
  }

  var_2 = common_scripts\utility::random(var_0);
  var_3 = [];

  foreach(var_5 in level.bot_loadout_fields) {
    if(isstring(var_2)) {
      var_3[var_5] = bot_loadout_choose_from_default_class(var_2, var_5);
      continue;
    }

    var_3[var_5] = bot_loadout_choose_from_custom_default_class(var_2, var_5);
  }

  return var_3;
}

bot_pick_personality_from_weapon(var_0) {
  if(isDefined(var_0)) {
    var_1 = level.bot_weap_personality[var_0];

    if(isDefined(var_1)) {
      var_2 = strtok(var_1, "| ");

      if(var_2.size > 0) {
        maps\mp\bots\_bots_util::bot_set_personality(common_scripts\utility::random(var_2));
      }
    }
  }
}

bot_loadout_set_has_wildcard(var_0, var_1) {
  if(var_0["loadoutWildcard1"] == var_1) {
    return 1;
  }

  if(var_0["loadoutWildcard2"] == var_1) {
    return 1;
  }

  if(var_0["loadoutWildcard3"] == var_1) {
    return 1;
  }

  return 0;
}

bot_loadout_fields() {
  var_0 = "mp/botClassTable.csv";

  if(!isDefined(level.bot_loadout_fields)) {
    level.bot_loadout_fields = [];
    level.bot_loadout_fields[0] = "loadoutWildcard1";
    level.bot_loadout_fields[1] = "loadoutWildcard2";
    level.bot_loadout_fields[2] = "loadoutWildcard3";
    var_1 = 2;

    for(;;) {
      var_2 = tablelookupbyrow(var_0, var_1, 0);

      if(var_2 == "") {
        break;
      }

      if(!issubstr(var_2, "Wildcard")) {
        level.bot_loadout_fields[level.bot_loadout_fields.size] = var_2;
      }

      var_1++;
    }
  }

  return level.bot_loadout_fields;
}

bot_loadout_set(var_0, var_1, var_2) {
  var_3 = var_1 + "_" + var_0;

  if(!isDefined(level.botloadoutsets)) {
    level.botloadoutsets = [];
  }

  if(!isDefined(level.botloadoutsets[var_3]) && var_2) {
    level.botloadoutsets[var_3] = spawnStruct();
    level.botloadoutsets[var_3].loadouts = [];
  }

  if(isDefined(level.botloadoutsets[var_3])) {
    return level.botloadoutsets[var_3];
  }
}

bot_loadout_pick(var_0, var_1) {
  var_2 = bot_loadout_set(var_0, var_1, 0);

  if(isDefined(var_2) && isDefined(var_2.loadouts) && var_2.loadouts.size > 0) {
    var_3 = randomint(var_2.loadouts.size);
    return var_2.loadouts[var_3].loadoutvalues;
  }
}

bot_validate_weapon(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 0;

  if(isDefined(level.bot_weap_built_in_attachments[var_0]) && level.bot_weap_built_in_attachments[var_0] != "none") {
    var_4[var_4.size] = level.bot_weap_built_in_attachments[var_0];
    var_5++;
  }

  if(isDefined(var_1) && var_1 != "none") {
    var_4[var_4.size] = var_1;
  }

  if(isDefined(var_2) && var_2 != "none") {
    var_4[var_4.size] = var_2;
  }

  if(isDefined(var_3) && var_3 != "none") {
    var_4[var_4.size] = var_3;
  }

  var_6 = maps\mp\_utility::getweaponattachmentarrayfromstats(var_0);

  for(var_7 = var_5; var_7 < var_4.size; var_7++) {
    var_8 = maps\mp\_utility::attachmentmap_tobase(var_4[var_7]);

    if(var_8 != var_4[var_7]) {
      return 0;
    }

    if(!bot_loadout_item_allowed("attachment", var_4[var_7], undefined)) {
      return 0;
    }

    if(!common_scripts\utility::array_contains(var_6, var_4[var_7])) {
      return 0;
    }

    var_9 = 0;

    for(var_10 = var_7 - 1; var_10 >= 0; var_10--) {
      if(var_4[var_7] == var_4[var_10]) {
        var_9++;

        if(var_9 == 1) {
          if(!isDefined(level.allowable_double_attachments[var_4[var_7]])) {
            return 0;
          }
        } else if(var_9 > 1) {
          return 0;
        }
      } else if(isDefined(level.bot_invalid_attachment_combos[var_4[var_7]])) {
        if(isDefined(level.bot_invalid_attachment_combos[var_4[var_7]][var_4[var_10]])) {
          return 0;
        }
      }
    }
  }

  return 1;
}

bot_validate_reticle(var_0, var_1, var_2) {
  if(!maps\mp\gametypes\_class::isvalidreticle(var_2, 1)) {
    return 0;
  }

  var_3 = ["Attachment", "Attachment2", "Attachment3"];

  foreach(var_5 in var_3) {
    var_6 = var_0 + var_5;
    var_7 = var_1[var_6];

    if(isDefined(var_7) && isDefined(level.bot_attachment_reticle[var_7])) {
      return 1;
    }
  }

  return 0;
}

init_bot_weap_statstable() {
  var_0 = "mp/statstable.csv";
  var_1 = 4;
  var_2 = 57;
  var_3 = 58;
  var_4 = 40;
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];
  level.bot_weap_built_in_attachments = [];
  level.bot_weap_personality["iw5_combatknife"] = "cqb";
  var_5 = 1;

  for(;;) {
    var_6 = tablelookupbyrow(var_0, var_5, 0);

    if(var_6 == "") {
      break;
    }

    var_7 = tablelookupbyrow(var_0, var_5, var_1);
    var_8 = tablelookupbyrow(var_0, var_5, var_3);
    var_9 = tablelookupbyrow(var_0, var_5, var_2);

    if(var_7 != "" && var_9 != "") {
      level.bot_weap_personality[var_7] = var_9;
    }

    if(var_8 != "" && var_7 != "" && var_9 != "") {
      var_10 = var_7;

      if(maps\mp\_utility::islootweapon(var_7)) {
        var_10 = maps\mp\gametypes\_class::getbasefromlootversion(var_7);
      }

      var_11 = "loadoutPrimary";

      if(maps\mp\gametypes\_class::isvalidsecondary(var_10, 0)) {
        var_11 = "loadoutSecondary";
      } else if(!maps\mp\gametypes\_class::isvalidprimary(var_10)) {
        var_5++;
        continue;
      }

      if(!isDefined(level.bot_weap_statstable[var_11])) {
        level.bot_weap_statstable[var_11] = [];
      }

      var_17 = strtok(var_9, "| ");
      var_18 = strtok(var_8, "| ");

      foreach(var_20 in var_17) {
        if(!isDefined(level.bot_weap_statstable[var_11][var_20])) {
          level.bot_weap_statstable[var_11][var_20] = [];
        }

        foreach(var_22 in var_18) {
          if(!isDefined(level.bot_weap_statstable[var_11][var_20][var_22])) {
            level.bot_weap_statstable[var_11][var_20][var_22] = [];
          }

          var_23 = level.bot_weap_statstable[var_11][var_20][var_22].size;
          level.bot_weap_statstable[var_11][var_20][var_22][var_23] = var_7;
        }
      }

      var_26 = tablelookupbyrow(var_0, var_5, var_4);

      if(var_26 != "") {
        level.bot_weap_built_in_attachments[var_7] = var_26;
      }
    }

    var_5++;
  }
}

bot_loadout_choose_from_statstable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";

  if(var_3 == "default") {
    var_3 = "run_and_gun";
  }

  var_6 = var_2;

  if(var_6 == "loadoutSecondary" && bot_loadout_set_has_wildcard(var_1, "specialty_wildcard_dualprimaries")) {
    var_6 = "loadoutPrimary";

    if(var_3 == "camper" || var_3 == "run_and_gun") {
      var_3 = "cqb";
    } else if(var_3 == "cqb") {
      var_3 = "run_and_gun";
    }
  }

  if(!isDefined(level.bot_weap_statstable)) {
    return var_5;
  }

  if(!isDefined(level.bot_weap_statstable[var_6])) {
    return var_5;
  }

  if(!isDefined(level.bot_weap_statstable[var_6][var_3])) {
    return var_5;
  }

  if(!isDefined(level.bot_weap_statstable[var_6][var_3][var_4])) {
    return var_5;
  }

  var_5 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_6][var_3][var_4], var_0, var_1, var_2);
  return var_5;
}

bot_validate_perk(var_0, var_1, var_2) {
  var_3 = "Perk_Slot1";

  if(var_1 == "loadoutPerk3" || var_1 == "loadoutPerk4") {
    var_3 = "Perk_Slot2";
  } else if(var_1 == "loadoutPerk5" || var_1 == "loadoutPerk6") {
    var_3 = "Perk_Slot3";
  }

  if(!bot_loadout_item_allowed("perk", var_0, var_3)) {
    return 0;
  }

  var_4 = int(getsubstr(var_1, 11));
  var_5 = "";

  if(var_4 == 2) {
    var_5 = "specialty_wildcard_perkslot1";
  } else if(var_4 == 4) {
    var_5 = "specialty_wildcard_perkslot2";
  } else if(var_4 == 6) {
    var_5 = "specialty_wildcard_perkslot3";
  }

  if(var_5 != "") {
    if(!bot_loadout_set_has_wildcard(var_2, var_5)) {
      return 0;
    }
  }

  for(var_6 = var_4 - 1; var_6 > 0; var_6--) {
    var_7 = "loadoutPerk" + var_6;

    if(var_2[var_7] == "none" || var_2[var_7] == "specialty_null") {
      continue;
    }
    if(var_0 == var_2[var_7]) {
      return 0;
    }
  }

  return 1;
}

bot_loadout_choose_from_default_class(var_0, var_1) {
  var_2 = int(getsubstr(var_0, 5, 6)) - 1;

  switch (var_1) {
    case "loadoutPrimary":
      return maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_2, 0);
    case "loadoutPrimaryAttachment":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 0);
    case "loadoutPrimaryAttachment2":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 1);
    case "loadoutPrimaryAttachment3":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 2);
    case "loadoutPrimaryCamo":
      return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_2, 0);
    case "loadoutPrimaryReticle":
      return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_2, 0);
    case "loadoutSecondary":
      return maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_2, 1);
    case "loadoutSecondaryAttachment":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 0);
    case "loadoutSecondaryAttachment2":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 1);
    case "loadoutSecondaryAttachment3":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 2);
    case "loadoutSecondaryCamo":
      return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_2, 1);
    case "loadoutSecondaryReticle":
      return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_2, 1);
    case "loadoutEquipment":
      return maps\mp\gametypes\_class::table_getequipment(level.classtablename, var_2);
    case "loadoutEquipment2":
      return tablelookup(level.classtablename, 0, "loadoutEquipment2", var_2 + 1);
    case "loadoutOffhand":
      return maps\mp\gametypes\_class::table_getoffhand(level.classtablename, var_2);
    case "loadoutOffhand2":
      if(maps\mp\gametypes\_class::table_getoffhandextra(level.classtablename, var_2)) {
        return maps\mp\gametypes\_class::table_getoffhand(level.classtablename, var_2);
      } else {
        return "specialty_null";
      }
    case "loadoutStreak1":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 0);
    case "loadoutStreakModule1a":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 0, 0);
    case "loadoutStreakModule1b":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 0, 1);
    case "loadoutStreakModule1c":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 0, 2);
    case "loadoutStreak2":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 1);
    case "loadoutStreakModule2a":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 1, 0);
    case "loadoutStreakModule2b":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 1, 1);
    case "loadoutStreakModule2c":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 1, 2);
    case "loadoutStreak3":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 2);
    case "loadoutStreakModule3a":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 2, 0);
    case "loadoutStreakModule3b":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 2, 1);
    case "loadoutStreakModule3c":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 2, 2);
    case "loadoutStreak4":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 3);
    case "loadoutStreakModule4a":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 3, 0);
    case "loadoutStreakModule4b":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 3, 1);
    case "loadoutStreakModule4c":
      return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_2, 3, 2);
    case "loadoutPerk2":
    case "loadoutPerk1":
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
      var_3 = int(getsubstr(var_1, 11)) - 1;
      var_4 = maps\mp\gametypes\_class::table_getperk(level.classtablename, var_2, var_3);

      if(var_4 == "") {
        return "specialty_null";
      }

      return var_4;
    case "loadoutWildcard1":
      return maps\mp\gametypes\_class::table_getwildcard(level.classtablename, var_2, 0);
    case "loadoutWildcard2":
      return maps\mp\gametypes\_class::table_getwildcard(level.classtablename, var_2, 1);
    case "loadoutWildcard3":
      return maps\mp\gametypes\_class::table_getwildcard(level.classtablename, var_2, 2);
  }

  return var_0;
}

bot_loadout_choose_from_custom_default_class(var_0, var_1) {
  var_2 = bot_loadout_team();

  switch (var_1) {
    case "loadoutPrimary":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "weapon");
    case "loadoutPrimaryAttachment":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "attachment", 0);
    case "loadoutPrimaryAttachment2":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "attachment", 1);
    case "loadoutPrimaryAttachment3":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "attachment", 2);
    case "loadoutPrimaryCamo":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "camo");
    case "loadoutPrimaryReticle":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "reticle");
    case "loadoutSecondary":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "weapon");
    case "loadoutSecondaryAttachment":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "attachment", 0);
    case "loadoutSecondaryAttachment2":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "attachment", 1);
    case "loadoutSecondaryAttachment3":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "attachment", 2);
    case "loadoutSecondaryCamo":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "camo");
    case "loadoutSecondaryReticle":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "reticle");
    case "loadoutEquipment":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "equipmentSetups", 0, "equipment");
    case "loadoutEquipment2":
      if(getmatchrulesdata("defaultClasses", var_2, var_0, "class", "equipmentSetups", 0, "extra")) {
        return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "equipmentSetups", 0, "equipment");
      } else {
        return "specialty_null";
      }
    case "loadoutOffhand":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "equipmentSetups", 1, "equipment");
    case "loadoutOffhand2":
      return "specialty_null";
    case "loadoutStreak1":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "streak");
    case "loadoutStreakModule1a":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "modules", 0);
    case "loadoutStreakModule1b":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "modules", 1);
    case "loadoutStreakModule1c":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "modules", 2);
    case "loadoutStreak2":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "streak");
    case "loadoutStreakModule2a":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "modules", 0);
    case "loadoutStreakModule2b":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "modules", 1);
    case "loadoutStreakModule2c":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "modules", 2);
    case "loadoutStreak3":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "streak");
    case "loadoutStreakModule3a":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "modules", 0);
    case "loadoutStreakModule3b":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "modules", 1);
    case "loadoutStreakModule3c":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "modules", 2);
    case "loadoutStreak4":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "streak");
    case "loadoutStreakModule4a":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "modules", 0);
    case "loadoutStreakModule4b":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "modules", 1);
    case "loadoutStreakModule4c":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "modules", 2);
    case "loadoutPerk1":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "perkSlots", 0);
    case "loadoutPerk2":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "perkSlots", 1);
    case "loadoutPerk3":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "perkSlots", 2);
    case "loadoutPerk4":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "perkSlots", 3);
    case "loadoutPerk5":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "perkSlots", 4);
    case "loadoutPerk6":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "perkSlots", 5);
    case "loadoutWildcard1":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "wildcardSlots", 0);
    case "loadoutWildcard2":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "wildcardSlots", 1);
    case "loadoutWildcard3":
      return getmatchrulesdata("defaultClasses", var_2, var_0, "class", "wildcardSlots", 2);
    default:
  }

  return "none";
}

init_bot_attachmenttable() {
  var_0 = "mp/attachmenttable.csv";
  var_1 = 3;
  var_2 = 15;
  var_3 = 7;
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

        if(!common_scripts\utility::array_contains(level.bot_attachmenttable[var_10], var_5)) {
          var_11 = level.bot_attachmenttable[var_10].size;
          level.bot_attachmenttable[var_10][var_11] = var_5;
        }
      }
    }

    var_4++;
  }

  level.bot_invalid_attachment_combos = [];
  level.allowable_double_attachments = [];
  var_13 = "mp/attachmentcombos.csv";
  var_14 = 0;

  for(;;) {
    var_14++;
    var_15 = tablelookupbyrow(var_13, 0, var_14);

    if(var_15 == "") {
      break;
    }

    var_4 = 0;

    for(;;) {
      var_4++;
      var_16 = tablelookupbyrow(var_13, var_4, 0);

      if(var_16 == "") {
        break;
      }

      if(var_16 == var_15) {
        if(tablelookupbyrow(var_13, var_4, var_14) != "no") {
          level.allowable_double_attachments[var_16] = 1;
        }

        continue;
      }

      if(tablelookupbyrow(var_13, var_4, var_14) == "no") {
        level.bot_invalid_attachment_combos[var_15][var_16] = 1;
      }
    }
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

init_bot_reticletable() {
  var_0 = "mp/reticletable.csv";
  var_1 = 1;
  var_2 = 8;
  level.bot_reticletable = [];
  var_3 = 0;

  for(;;) {
    var_4 = tablelookupbyrow(var_0, var_3, var_1);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = tablelookupbyrow(var_0, var_3, var_2);

    if(isDefined(var_5) && int(var_5)) {
      level.bot_reticletable[level.bot_reticletable.size] = var_4;
    }

    var_3++;
  }
}

bot_loadout_choose_from_reticletable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";

  if(!isDefined(level.bot_reticletable)) {
    return var_5;
  }

  var_6 = randomint(100) > 50;

  if(var_6) {
    var_5 = bot_loadout_choose_from_set(level.bot_reticletable, var_0, var_1, var_2);
  }

  return var_5;
}

init_bot_camotable() {
  var_0 = "mp/camotable.csv";
  var_1 = 1;
  var_2 = 8;
  var_3 = 9;
  var_4 = 11;
  level.bot_camotable = [];
  var_5 = 0;

  for(;;) {
    var_6 = tablelookupbyrow(var_0, var_5, var_1);

    if(!isDefined(var_6) || var_6 == "") {
      break;
    }

    var_7 = int(tablelookupbyrow(var_0, var_5, var_4));
    var_8 = tablelookupbyrow(var_0, var_5, var_2);

    if(isDefined(var_8) && var_8 != "" && !var_7) {
      var_9 = tablelookupbyrow(var_0, var_5, var_3);

      if(isDefined(var_9) && int(var_9)) {
        level.bot_camotable[level.bot_camotable.size] = var_6;
      }
    }

    var_5++;
  }
}

bot_loadout_choose_from_camotable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";

  if(!isDefined(level.bot_camotable)) {
    return var_5;
  }

  var_6 = randomint(100) > 50;

  if(var_6) {
    var_5 = bot_loadout_choose_from_set(level.bot_camotable, var_0, var_1, var_2);
  }

  return var_5;
}

bot_loadout_item_valid_for_rank(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return 1;
  }

  if(!isDefined(level.bot_min_rank_for_item[var_1])) {
    var_3 = "mp/unlockTable.csv";
    var_4 = tablelookuprownum(var_3, 0, var_1);
    level.bot_min_rank_for_item[var_1] = int(tablelookupbyrow(var_3, var_4, 2));
  }

  if(var_0 == "classtable_any" && var_2 == "recruit") {
    return 1;
  }

  if(!isDefined(self.rank_for_items)) {
    if(var_2 == "recruit") {
      self.rank_for_items = 3;
    } else {
      self.rank_for_items = self.pers["rank"];

      if(!isDefined(self.rank_for_items)) {
        self.rank_for_items = level.bot_rnd_rank[var_2][0];
      }
    }
  }

  if(level.bot_min_rank_for_item[var_1] <= self.rank_for_items) {
    return 1;
  }

  return 0;
}

bot_loadout_valid_choice(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  switch (var_2) {
    case "loadoutPrimary":
      var_5 = var_3;

      if(maps\mp\_utility::islootweapon(var_5)) {
        var_5 = maps\mp\gametypes\_class::getbasefromlootversion(var_5);
      }

      var_4 = bot_loadout_item_allowed("weapon", var_5, undefined);
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidprimary(var_3);
      break;
    case "loadoutEquipment":
      var_4 = bot_loadout_item_allowed("perk", var_3, "Lethal");
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidequipment(var_3, bot_loadout_set_has_wildcard(var_1, "specialty_wildcard_dualtacticals"));
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutEquipment2":
      var_4 = var_3 == "specialty_null" || var_3 == var_1["loadoutEquipment"];
      break;
    case "loadoutOffhand":
      var_4 = bot_loadout_item_allowed("perk", var_3, "Tactical");
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidoffhand(var_3, bot_loadout_set_has_wildcard(var_1, "specialty_wildcard_duallethals"));
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutOffhand2":
      var_4 = var_3 == "specialty_null";
      break;
    case "loadoutPrimaryAttachment":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_3);
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
      var_4 = !isDefined(self.botloadoutfavoritecamoprimary) || var_3 == self.botloadoutfavoritecamoprimary;
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo(var_3);
      break;
    case "loadoutSecondary":
      var_4 = var_3 != var_1["loadoutPrimary"];
      var_5 = var_3;

      if(maps\mp\_utility::islootweapon(var_5)) {
        var_5 = maps\mp\gametypes\_class::getbasefromlootversion(var_5);
      }

      var_4 = var_4 && bot_loadout_item_allowed("weapon", var_5, undefined);
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidsecondary(var_3, bot_loadout_set_has_wildcard(var_1, "specialty_wildcard_dualprimaries"));
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
      var_4 = !isDefined(self.botloadoutfavoritecamosecondary) || var_3 == self.botloadoutfavoritecamosecondary;
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo(var_3);
      break;
    case "loadoutStreak4":
    case "loadoutStreak3":
    case "loadoutStreak2":
    case "loadoutStreak1":
      var_4 = maps\mp\bots\_bots_ks::bot_killstreak_is_valid_internal(var_3, "bots", undefined);
      var_4 = var_4 && bot_loadout_item_allowed("killstreak", var_3, undefined);
      break;
    case "loadoutStreakModule4c":
    case "loadoutStreakModule4b":
    case "loadoutStreakModule4a":
    case "loadoutStreakModule3c":
    case "loadoutStreakModule3b":
    case "loadoutStreakModule3a":
    case "loadoutStreakModule2c":
    case "loadoutStreakModule2b":
    case "loadoutStreakModule2a":
    case "loadoutStreakModule1c":
    case "loadoutStreakModule1b":
    case "loadoutStreakModule1a":
      var_4 = bot_loadout_item_allowed("module", var_3, undefined);
      break;
    case "loadoutPerk2":
    case "loadoutPerk1":
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
      var_4 = var_3 == "specialty_null" || bot_validate_perk(var_3, var_2, var_1);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutWildcard3":
    case "loadoutWildcard2":
    case "loadoutWildcard1":
      var_4 = 1;
      break;
    default:
      break;
  }

  return var_4;
}

bot_loadout_choose_from_set(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  var_6 = undefined;
  var_7 = 0.0;

  if(common_scripts\utility::array_contains(var_0, "specialty_null")) {
    var_5 = "specialty_null";
  } else if(var_3 == "loadoutEquipment" || var_3 == "loadoutOffhand" || common_scripts\utility::string_find(var_3, "Perk") >= 0) {
    var_5 = "specialty_null";
  }

  if(var_1 == "classtable_any") {
    if(!isDefined(self.default_class_chosen)) {
      self.default_class_chosen = common_scripts\utility::random(["class1", "class2", "class3", "class4", "class5"]);
    }

    var_0 = [self.default_class_chosen];
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
      return bot_loadout_choose_from_statstable(var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(var_9 == "reticletable") {
      return bot_loadout_choose_from_reticletable(var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(var_9 == "camotable") {
      return bot_loadout_choose_from_camotable(var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(getsubstr(var_9, 0, 5) == "class" && int(getsubstr(var_9, 5, 6)) > 0) {
      var_9 = bot_loadout_choose_from_default_class(var_9, var_3);
    }

    if(issubstr(var_3, "loadoutStreakModule")) {
      var_12 = int(getsubstr(var_3, 19, 20));
      var_13 = var_2["loadoutStreak" + var_12];
      var_14 = getsubstr(var_3, 20, 21);

      switch (var_13) {
        case "remote_mg_sentry_turret":
          if(var_14 == "a") {
            var_9 = "sentry_guardian";
          }

          break;
        case "warbird":
          if(var_14 == "a") {
            var_9 = "warbird_ai_attack";
          }

          break;
        case "assault_ugv":
          if(var_14 == "a") {
            var_9 = "assault_ugv_ai";
          } else if(var_14 == "b") {
            var_9 = "assault_ugv_mg";
          }

          break;
      }
    }

    if(bot_loadout_valid_choice(var_1, var_2, var_3, var_9)) {
      var_7 = var_7 + 1.0;

      if(randomfloat(1.0) <= 1.0 / var_7) {
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

  if(self botgetdifficulty() != "recruit") {
    var_7 = bot_get_pick_13_count(var_0);

    for(var_8 = 0; var_7 < level.customclasspickcount && var_8 < 5; var_8++) {
      if(var_7 == level.customclasspickcount - 1) {
        var_0 = bot_find_1_loadout_option(var_0);
      } else if(var_7 <= level.customclasspickcount - 2) {
        var_0 = bot_find_2_loadout_options(var_0);
      }

      var_7 = bot_get_pick_13_count(var_0);
    }
  }

  return var_0;
}

bot_find_1_loadout_option(var_0) {
  if(var_0["loadoutSecondaryAttachment2"] == "none") {
    var_0["loadoutSecondaryAttachment2"] = bot_loadout_choose_from_set(["attachmenttable"], "attachmenttable", var_0, "loadoutSecondaryAttachment2");
  }

  if(bot_get_pick_13_count(var_0) == level.customclasspickcount) {
    return var_0;
  }

  var_2 = "add";
  var_3 = var_0["loadoutWildcard1"] != "specialty_null" && var_0["loadoutWildcard2"] != "specialty_null" && var_0["loadoutWildcard3"] != "specialty_null";

  if(randomint(100) < 50 && !var_3) {
    var_2 = "remove";
  }

  if(var_2 == "remove") {
    if(var_0["loadoutEquipment"] != "specialty_null") {
      var_0["loadoutEquipment"] = "specialty_null";

      if(bot_get_pick_13_count(var_0) == level.customclasspickcount - 2) {
        return var_0;
      }
    }
  } else if(var_2 == "add") {
    if(var_0["loadoutEquipment"] != "specialty_null" && var_0["loadoutEquipment2"] == "specialty_null") {
      var_0["loadoutEquipment2"] = var_0["loadoutEquipment"];

      if(bot_get_pick_13_count(var_0) == level.customclasspickcount) {
        return var_0;
      }
    }
  }

  if(!var_3) {
    var_4 = ["loadoutSecondaryAttachment2", "loadoutSecondaryAttachment", "loadoutStreak3", "loadoutStreak2", "loadoutStreak1"];

    foreach(var_6 in var_4) {
      if(var_0[var_6] != "none") {
        var_0[var_6] = "none";

        if(bot_get_pick_13_count(var_0) == level.customclasspickcount - 2) {
          return var_0;
        }
      }
    }
  }

  return var_0;
}

bot_find_2_loadout_options(var_0) {
  var_1 = ["loadoutWildcard1", "loadoutWildcard2", "loadoutWildcard3"];
  var_2 = common_scripts\utility::array_randomize(["loadoutPerk2", "loadoutPerk4", "loadoutPerk6"]);

  foreach(var_4 in var_2) {
    if(var_0[var_4] == "specialty_null") {
      var_5 = undefined;

      foreach(var_7 in var_1) {
        if(var_0[var_7] == "specialty_null") {
          var_5 = var_7;
          break;
        }
      }

      if(isDefined(var_5)) {
        var_9 = 0;

        if(!var_9) {
          var_11 = int(getsubstr(var_4, 11, 12));
          var_0[var_5] = "specialty_wildcard_perkslot" + var_11 / 2;
          var_0[var_4] = bot_loadout_choose_from_set(["template_any"], "template_any", var_0, var_4);

          if(var_0[var_4] == "specialty_null") {
            var_0[var_5] = "specialty_null";
            continue;
          }

          if(bot_get_pick_13_count(var_0) > level.customclasspickcount - 2) {
            return var_0;
          }
        }
      }
    }
  }

  if(var_0["loadoutEquipment"] == "specialty_null") {
    var_13 = "template_any_noncamper";

    if(level.bot_personality_type[self.personality] == "stationary") {
      var_13 = "template_any_camper";
    }

    var_0["loadoutEquipment"] = bot_loadout_choose_from_set([var_13], var_13, var_0, "loadoutEquipment");
  }

  if(var_0["loadoutEquipment"] != "specialty_null" && var_0["loadoutEquipment2"] == "specialty_null") {
    var_0["loadoutEquipment2"] = var_0["loadoutEquipment"];
  }

  return var_0;
}

bot_get_pick_13_count(var_0) {
  var_1 = tablelookup("mp/statstable.csv", 4, var_0["loadoutPrimary"], 40);
  var_2 = tablelookup("mp/statstable.csv", 4, var_0["loadoutSecondary"], 40);
  var_3 = 0;

  if(var_0["loadoutPrimary"] != "iw5_combatknife") {
    var_3++;
  }

  if(var_0["loadoutPrimaryAttachment"] != "none" && var_1 == "") {
    var_3++;
  }

  if(var_0["loadoutPrimaryAttachment2"] != "none") {
    var_3++;
  }

  if(var_0["loadoutPrimaryAttachment3"] != "none") {
    var_3++;
  }

  if(var_0["loadoutSecondary"] != "iw5_combatknife") {
    var_3++;
  }

  if(var_0["loadoutSecondaryAttachment"] != "none" && var_2 == "") {
    var_3++;
  }

  if(var_0["loadoutSecondaryAttachment2"] != "none") {
    var_3++;
  }

  if(var_0["loadoutSecondaryAttachment3"] != "none") {
    var_3++;
  }

  if(var_0["loadoutEquipment"] != "specialty_null") {
    var_3++;
  }

  if(var_0["loadoutEquipment2"] != "specialty_null") {
    var_3++;
  }

  if(var_0["loadoutOffhand"] != "specialty_null") {
    var_3++;
  }

  if(isDefined(var_0["loadoutOffhandExtra"]) && var_0["loadoutOffhandExtra"]) {
    var_3++;
  }

  for(var_4 = 1; var_4 <= 6; var_4++) {
    if(var_0["loadoutPerk" + var_4] != "specialty_null") {
      var_3++;
    }
  }

  for(var_4 = 1; var_4 <= 3; var_4++) {
    if(var_0["loadoutWildcard" + var_4] != "specialty_null") {
      var_3++;
    }
  }

  for(var_4 = 1; var_4 <= 4; var_4++) {
    if(var_0["loadoutStreak" + var_4] != "none") {
      var_3++;
    }
  }

  return var_3;
}

bot_loadout_get_difficulty() {
  var_0 = self botgetdifficulty();

  if(var_0 == "default") {
    maps\mp\bots\_bots_util::bot_set_difficulty("default");
    var_0 = self botgetdifficulty();
  }

  return var_0;
}

bot_loadout_class_callback(var_0) {
  while(!isDefined(level.bot_loadouts_initialized)) {
    wait 0.05;
  }

  while(!isDefined(self.personality)) {
    wait 0.05;
  }

  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0) && var_0) {
    var_2 = 1;
  } else if(isDefined(self.bot_pick_new_loadout_next_spawn) && self.bot_pick_new_loadout_next_spawn) {
    var_1 = 1;
    self.bot_pick_new_loadout_next_spawn = undefined;
  }

  var_3 = [];
  var_4 = bot_loadout_get_difficulty();
  self.difficulty = var_4;
  var_5 = self botgetpersonality();

  if(!isDefined(self.bot_last_loadout_num)) {
    self.bot_cur_loadout_num = 0;
  }

  self.bot_last_loadout_num = self.bot_cur_loadout_num;

  if(isDefined(self.botlastloadout) && !var_1) {
    if(var_2) {
      return self.botlastloadout;
    }

    var_6 = self.botlastloadoutdifficulty == var_4;
    var_7 = self.botlastloadoutpersonality == var_5;

    if(var_6 && var_7 && (!isDefined(self.hasdied) || self.hasdied) && !isDefined(self.respawn_with_launcher)) {
      var_8 = randomfloat(1.0) > 0.1;

      if(var_8) {
        return self.botlastloadout;
      }
    }
  }

  if(!bot_custom_classes_allowed()) {
    var_3 = bot_default_class_random();
    bot_pick_personality_from_weapon(var_3["loadoutPrimary"]);
  } else {
    var_3 = bot_loadout_pick(var_5, var_4);
    var_3 = bot_loadout_choose_values(var_3);

    if(isDefined(level.bot_funcs["gametype_loadout_modify"])) {
      var_3 = self[[level.bot_funcs["gametype_loadout_modify"]]](var_3);
    }
  }

  if(var_3["loadoutPrimary"] == "none") {
    self.bot_fallback_personality = undefined;
    var_3["loadoutPrimary"] = bot_loadout_choose_fallback_primary(var_3);
    var_3["loadoutPrimaryCamo"] = "none";
    var_3["loadoutPrimaryAttachment"] = "none";
    var_3["loadoutPrimaryAttachment2"] = "none";
    var_3["loadoutPrimaryAttachment3"] = "none";
    var_3["loadoutPrimaryReticle"] = "none";

    if(isDefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon") {
        bot_pick_personality_from_weapon(var_3["loadoutPrimary"]);
      } else {
        maps\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);
      }

      var_5 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  if(isDefined(var_3["loadoutPrimaryCamo"]) && var_3["loadoutPrimaryCamo"] != "none" && !isDefined(self.botloadoutfavoritecamoprimary)) {
    self.botloadoutfavoritecamoprimary = var_3["loadoutPrimaryCamo"];
  }

  if(isDefined(var_3["loadoutSecondaryCamo"]) && var_3["loadoutSecondaryCamo"] != "none" && !isDefined(self.botloadoutfavoritecamosecondary)) {
    self.botloadoutfavoritecamosecondary = var_3["loadoutSecondaryCamo"];
  }

  if(isDefined(self.respawn_with_launcher)) {
    var_12 = level.bot_respawn_launcher_name[self botgetdifficulty()];

    if(bot_loadout_item_allowed("weapon", var_12, undefined)) {
      var_3["loadoutSecondary"] = var_12;
      var_3["loadoutSecondaryAttachment"] = "none";
      var_3["loadoutSecondaryAttachment2"] = "none";
      var_3["loadoutSecondaryAttachment3"] = "none";
      self.bot_pick_new_loadout_next_spawn = 1;
    }

    self.respawn_with_launcher = undefined;
  }

  maps\mp\gametypes\_class::isvalidkillstreak(var_3["loadoutStreak1"]);
  maps\mp\gametypes\_class::isvalidkillstreak(var_3["loadoutStreak2"]);
  maps\mp\gametypes\_class::isvalidkillstreak(var_3["loadoutStreak3"]);
  self.bot_cur_loadout_num++;
  self.botlastloadout = var_3;
  self.botlastloadoutdifficulty = var_4;
  self.botlastloadoutpersonality = var_5;
  return var_3;
}

bot_setup_loadout_callback() {
  var_0 = self botgetpersonality();
  var_1 = bot_loadout_get_difficulty();
  var_2 = bot_loadout_set(var_0, var_1, 0);

  if(isDefined(var_2) && isDefined(var_2.loadouts) && var_2.loadouts.size > 0) {
    self.classcallback = ::bot_loadout_class_callback;
    return 1;
  }

  var_3 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return 0;
}