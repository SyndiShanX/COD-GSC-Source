/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_loadout.gsc
**************************************************/

init() {
  _id_51B7();
  _id_523A();
  init_template_table();
  init_class_table();
  init_bot_attachmenttable();
  _id_5172();
  init_bot_weap_statstable();
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

_id_51B7() {
  var_0 = "mp/botDivisionTable.csv";
  level._id_1B30 = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "division_", var_2);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    var_4 = "division_" + var_3;
    level._id_1B30[var_4] = [];

    foreach(var_6 in var_1) {
      var_7 = tablelookup(var_0, 0, var_6, var_2);

      if(isDefined(var_7) && var_7 != "") {
        level._id_1B30[var_4][var_6] = var_7;
      }
    }
  }
}

_id_523A() {
  var_0 = "mp/botPerkTable.csv";
  level._id_1B38 = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "specialty_class_", var_2);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    var_4 = "specialty_class_" + var_3;
    level._id_1B30[var_4] = [];

    foreach(var_6 in var_1) {
      var_7 = tablelookup(var_0, 0, var_6, var_2);

      if(isDefined(var_7) && var_7 != "") {
        level._id_1B38[var_4][var_6] = var_7;
      }
    }
  }
}

bot_custom_classes_allowed() {
  if(_isusingmatchrulesdata()) {
    if(!_getmatchrulesdata("commonOption", "allowCustomClasses")) {
      return 0;
    }
  }

  return 1;
}

bot_loadout_item_allowed(var_0, var_1, var_2) {
  if(!_isusingmatchrulesdata()) {
    return 1;
  }

  if(!bot_custom_classes_allowed()) {
    return 0;
  }

  if(!_isstring(var_1)) {
    var_1 = maps\mp\_utility::_id_452B(var_1);
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
      if(_getmatchrulesdata("commonOption", "allStreaksRestricted")) {
        return 0;
      }

      break;
    case "perk":
      var_5 = var_2;
      break;
    default:
      return 0;
  }

  if(_getmatchrulesdata("commonOption", var_3, var_1)) {
    return 0;
  }

  if(var_5 != "" && _getmatchrulesdata("commonOption", var_4, var_5)) {
    return 0;
  }

  return 1;
}

bot_loadout_choose_fallback_primary(var_0) {
  var_1 = 0;
  var_2 = ["veteran", "hardened", "regular", "recruit"];
  var_2 = common_scripts\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimaryGUID", self.personality, var_4);

    if(var_1 != 0) {
      return var_1;
    }
  }

  if(isDefined(level.bot_personality_list)) {
    var_6 = common_scripts\utility::array_randomize(level.bot_personality_list);

    foreach(var_8 in var_6) {
      foreach(var_4 in var_2) {
        var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimaryGUID", var_8, var_4);

        if(var_1 != 0) {
          self.bot_fallback_personality = var_8;
          return var_1;
        }
      }
    }
  }

  if(_isusingmatchrulesdata()) {
    var_12 = 0.0;
    var_13 = 0;

    for(var_14 = 0; var_13 < 6; var_13++) {
      if(_getmatchrulesdata("defaultClasses", bot_loadout_team(), "defaultClass", var_13, "class", "inUse")) {
        var_1 = bot_loadout_choose_from_custom_default_class(var_13, "loadoutPrimaryGUID");

        if(var_1 != 0) {
          var_12 = var_12 + 1.0;

          if(_randomfloat(1.0) >= 1.0 / var_12) {
            var_14 = var_1;
          }
        }
      }
    }

    if(var_14 != 0) {
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

  if(_isusingmatchrulesdata()) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(_getmatchrulesdata("defaultClasses", bot_loadout_team(), "defaultClass", var_1, "class", "inUse")) {
        var_0[var_1] = var_1;
      }
    }
  }

  var_2 = common_scripts\utility::random(var_0);
  var_3 = [];

  foreach(var_5 in level.bot_loadout_fields) {
    if(_isstring(var_2)) {
      var_3[var_5] = bot_loadout_choose_from_default_class(var_2, var_5);
      continue;
    }

    var_3[var_5] = bot_loadout_choose_from_custom_default_class(var_2, var_5);
  }

  return var_3;
}

bot_pick_personality_from_weapon(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 + "";
    var_2 = level.bot_weap_personality[var_1];

    if(isDefined(var_2)) {
      var_3 = strtok(var_2, "| ");

      if(var_3.size > 0) {
        maps\mp\bots\_bots_util::bot_set_personality(common_scripts\utility::random(var_3));
      }
    }
  }
}

bot_loadout_fields() {
  var_0 = "mp/botClassTable.csv";

  if(!isDefined(level.bot_loadout_fields)) {
    level.bot_loadout_fields = [];
    var_1 = 2;

    for(;;) {
      var_2 = _tablelookupbyrow(var_0, var_1, 0);

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

_id_1B1A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_8 = maps\mp\_utility::_id_452B(var_0);

  if(isDefined(var_1) && !_isstring(var_1)) {
    var_1 = maps\mp\_utility::_id_452B(var_1);
  }

  if(isDefined(var_2) && !_isstring(var_2)) {
    var_2 = maps\mp\_utility::_id_452B(var_2);
  }

  if(isDefined(var_3) && !_isstring(var_3)) {
    var_3 = maps\mp\_utility::_id_452B(var_3);
  }

  if(isDefined(var_4) && !_isstring(var_4)) {
    var_4 = maps\mp\_utility::_id_452B(var_4);
  }

  if(isDefined(var_5) && !_isstring(var_5)) {
    var_5 = maps\mp\_utility::_id_452B(var_5);
  }

  if(isDefined(var_6) && !_isstring(var_6)) {
    var_6 = maps\mp\_utility::_id_452B(var_6);
  }

  var_9 = 0;

  if(isDefined(level.bot_weap_built_in_attachments[var_8]) && level.bot_weap_built_in_attachments[var_8] != "none") {
    var_7[var_7.size] = level.bot_weap_built_in_attachments[var_8];
    var_9++;
  }

  if(isDefined(var_1) && var_1 != "none") {
    var_7[var_7.size] = var_1;
  }

  if(isDefined(var_2) && var_2 != "none") {
    var_7[var_7.size] = var_2;
  }

  if(isDefined(var_3) && var_3 != "none") {
    var_7[var_7.size] = var_3;
  }

  if(isDefined(var_4) && var_4 != "none") {
    var_7[var_7.size] = var_4;
  }

  if(isDefined(var_5) && var_5 != "none") {
    var_7[var_7.size] = var_5;
  }

  if(isDefined(var_6) && var_6 != "none") {
    var_7[var_7.size] = var_6;
  }

  var_10 = maps\mp\_utility::_id_4723(var_8);

  for(var_11 = var_9; var_11 < var_7.size; var_11++) {
    var_12 = maps\mp\_utility::attachmentmap_tobase(var_7[var_11]);

    if(var_12 != var_7[var_11]) {
      return 0;
    }

    if(!bot_loadout_item_allowed("attachment", var_7[var_11], undefined)) {
      return 0;
    }

    if(!common_scripts\utility::_id_0F79(var_10, var_7[var_11])) {
      return 0;
    }

    var_13 = 0;

    for(var_14 = var_11 - 1; var_14 >= 0; var_14--) {
      if(var_7[var_11] == var_7[var_14]) {
        var_13++;

        if(var_13 == 1) {
          if(!isDefined(level._id_0C1A[var_7[var_11]])) {
            return 0;
          }
        } else if(var_13 > 1)
          return 0;
      } else if(isDefined(level._id_1A24[var_7[var_11]])) {
        if(isDefined(level._id_1A24[var_7[var_11]][var_7[var_14]])) {
          return 0;
        }
      }
    }
  }

  return 1;
}

bot_validate_reticle(var_0, var_1, var_2) {
  if(_func_30D(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = maps\mp\_utility::_id_452A(var_2);
  }

  if(!maps\mp\gametypes\_class::_id_5838(var_3, 1)) {
    return 0;
  }

  var_4 = ["Attachment", "Attachment2", "Attachment3"];

  foreach(var_6 in var_4) {
    var_7 = var_0 + var_6;
    var_8 = var_1[var_7];

    if(isDefined(var_8) && isDefined(level._id_193B[var_8])) {
      return 1;
    }
  }

  return 0;
}

_id_5172() {
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];
  level.bot_weap_built_in_attachments = [];
  level.bot_weap_personality[_func_310("combatknife_mp") + ""] = "cqb";
  var_0 = 1;

  for(;;) {
    var_1 = _tablelookupbyrow("mp/statstable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    if(_tablelookupbyrow("mp/statstable.csv", var_0, 20) != "") {
      var_0++;
      continue;
    }

    var_2 = _tablelookupbyrow("mp/statstable.csv", var_0, 18);
    var_3 = _tablelookupbyrow("mp/statstable.csv", var_0, 2);
    var_4 = _tablelookupbyrow("mp/statstable.csv", var_0, 27);
    var_5 = _tablelookupbyrow("mp/statstable.csv", var_0, 26);

    if(var_4 != "" && var_3 != "" && var_5 != "") {
      var_6 = int(var_2);
      var_7 = _func_312(var_6);
      var_8 = maps\mp\_utility::_id_452B(var_7);
      var_9 = "loadoutPrimaryGUID";

      if(maps\mp\gametypes\_class::isvalidsecondary(var_8, 0, 0)) {
        var_9 = "loadoutSecondaryGUID";
      } else if(!maps\mp\gametypes\_class::isvalidprimary(var_8, 0)) {
        var_0++;
        continue;
      }

      var_10 = _func_314(var_6);

      if(var_10 > 0 && var_10 < 3) {
        var_3 = var_3 + "+cond" + var_10;
      }

      var_2 = var_6 + "";
      level.bot_weap_personality[var_2] = var_5;

      if(!isDefined(level.bot_weap_statstable[var_9])) {
        level.bot_weap_statstable[var_9] = [];
      }

      var_16 = strtok(var_5, "| ");
      var_17 = strtok(var_4, "| ");

      foreach(var_19 in var_16) {
        if(!isDefined(level.bot_weap_statstable[var_9][var_19])) {
          level.bot_weap_statstable[var_9][var_19] = [];
        }

        foreach(var_21 in var_17) {
          if(!isDefined(level.bot_weap_statstable[var_9][var_19][var_21])) {
            level.bot_weap_statstable[var_9][var_19][var_21] = [];
          }

          var_22 = level.bot_weap_statstable[var_9][var_19][var_21].size;
          level.bot_weap_statstable[var_9][var_19][var_21][var_22] = var_3;
        }
      }

      var_25 = _tablelookupbyrow("mp/statstable.csv", var_0, 9);

      if(var_25 != "") {
        level.bot_weap_built_in_attachments[var_3] = var_25;
      }
    }

    var_0++;
  }
}

bot_loadout_choose_from_statstable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(var_3 == "default") {
    var_3 = "run_and_gun";
  }

  var_6 = var_2;

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

  var_7 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_6][var_3][var_4], var_0, var_1, var_2);

  if(_isstring(var_7)) {
    var_5 = maps\mp\_utility::_id_452A(var_7);
  } else {
    var_5 = var_7;
  }

  return var_5;
}

bot_validate_perk(var_0, var_1, var_2) {
  if(_isstring(var_0)) {
    var_0 = maps\mp\_utility::_id_452A(var_0);
  }

  if(var_0 == 0) {
    return 1;
  }

  var_3 = "Perk_Slot1";

  if(var_1 == "loadoutPerkGUID4" || var_1 == "loadoutPerkGUID5" || var_1 == "loadoutPerkGUID6") {
    var_3 = "Perk_Slot2";
  } else if(var_1 == "loadoutPerkGUID7" || var_1 == "loadoutPerkGUID8" || var_1 == "loadoutPerkGUID9") {
    var_3 = "Perk_Slot3";
  }

  if(!bot_loadout_item_allowed("perk", var_0, var_3)) {
    return 0;
  }

  var_4 = int(getsubstr(var_1, 15));

  for(var_5 = var_4 - 1; var_5 > 0; var_5--) {
    var_6 = "loadoutPerkGUID" + var_5;
    var_7 = var_2[var_6];

    if(!_func_30D(var_7)) {
      var_7 = maps\mp\_utility::_id_452A(var_7);
    }

    if(var_7 == 0) {
      continue;
    }
    if(var_0 == var_7) {
      return 0;
    }
  }

  return 1;
}

bot_loadout_choose_from_default_class(var_0, var_1) {
  var_2 = int(getsubstr(var_0, 5, 6)) - 1;

  switch (var_1) {
    case "loadoutDivision":
      return maps\mp\gametypes\_class::table_getdivision(level.classtablename, var_2);
    case "loadoutPrimaryGUID":
      return maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_2, 0);
    case "loadoutPrimaryAttachmentGUID1":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 0);
    case "loadoutPrimaryAttachmentGUID2":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 1);
    case "loadoutPrimaryAttachmentGUID3":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 2);
    case "loadoutPrimaryAttachmentGUID4":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 3);
    case "loadoutPrimaryAttachmentGUID5":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 4);
    case "loadoutPrimaryAttachmentGUID6":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 0, 5);
    case "loadoutPrimaryCamoGUID":
      return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_2, 0);
    case "loadoutPrimaryCamo2GUID":
      return 0;
    case "loadoutPrimaryReticleGUID":
      return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_2, 0);
    case "loadoutPrimaryPaintjobId":
      return 0;
    case "loadoutPrimaryCharmGUID":
      return 0;
    case "loadoutSecondaryGUID":
      return maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_2, 1);
    case "loadoutSecondaryAttachmentGUID1":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 0);
    case "loadoutSecondaryAttachmentGUID2":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 1);
    case "loadoutSecondaryAttachmentGUID3":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 2);
    case "loadoutSecondaryAttachmentGUID4":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 3);
    case "loadoutSecondaryAttachmentGUID5":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 4);
    case "loadoutSecondaryAttachmentGUID6":
      return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_2, 1, 5);
    case "loadoutSecondaryCamoGUID":
      return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_2, 1);
    case "loadoutSecondaryCamo2GUID":
      return 0;
    case "loadoutSecondaryReticleGUID":
      return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_2, 1);
    case "loadoutSecondaryPaintjobId":
      return 0;
    case "loadoutSecondaryCharmGUID":
      return 0;
    case "loadoutEquipmentGUID":
      return maps\mp\gametypes\_class::table_getequipment(level.classtablename, var_2);
    case "loadoutEquipmentNumExtra":
      var_3 = maps\mp\gametypes\_class::_id_9585(level.classtablename, var_2);

      if(_func_30D(var_3) || _func_30E(var_3)) {
        return var_3;
      } else {
        return 0;
      }
    case "loadoutOffhandGUID":
      return maps\mp\gametypes\_class::table_getoffhand(level.classtablename, var_2);
    case "loadoutOffhandNumExtra":
      var_4 = maps\mp\gametypes\_class::table_getoffhandextra(level.classtablename, var_2);

      if(_func_30D(var_4) || _func_30E(var_4)) {
        return var_4;
      } else {
        return 0;
      }
    case "loadoutStreakGUID1":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 0);
    case "loadoutStreakGUID2":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 1);
    case "loadoutStreakGUID3":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 2);
    case "loadoutStreakGUID4":
      return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_2, 3);
    case "loadoutPerkGUID3":
    case "loadoutPerkGUID2":
    case "loadoutPerkGUID1":
    case "loadoutPerkGUID9":
    case "loadoutPerkGUID8":
    case "loadoutPerkGUID7":
    case "loadoutPerkGUID6":
    case "loadoutPerkGUID5":
    case "loadoutPerkGUID4":
      var_5 = int(getsubstr(var_1, 15)) - 1;
      return maps\mp\gametypes\_class::table_getperk(level.classtablename, var_2, var_5);
  }

  return var_0;
}

bot_loadout_choose_from_custom_default_class(var_0, var_1) {
  var_2 = bot_loadout_team();

  switch (var_1) {
    case "loadoutDivsion":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "division");
    case "loadoutPrimaryGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "weapon");
    case "loadoutPrimaryAttachmentGUID1":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "attachment", 0);
    case "loadoutPrimaryAttachmentGUID2":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "attachment", 1);
    case "loadoutPrimaryAttachmentGUID3":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "attachment", 2);
    case "loadoutPrimaryAttachmentGUID4":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "attachment", 3);
    case "loadoutPrimaryAttachmentGUID5":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "attachment", 4);
    case "loadoutPrimaryAttachmentGUID6":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "attachment", 5);
    case "loadoutPrimaryCamoGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "camo");
    case "loadoutPrimaryCamo2GUID":
      return 0;
    case "loadoutPrimaryReticleGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "reticle");
    case "loadoutPrimaryPaintjobId":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "paintjob");
    case "loadoutPrimaryCharmGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "charm");
    case "loadoutSecondaryGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "weapon");
    case "loadoutSecondaryAttachmentGUID1":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "attachment", 0);
    case "loadoutSecondaryAttachmentGUID2":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "attachment", 1);
    case "loadoutSecondaryAttachmentGUID3":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "attachment", 2);
    case "loadoutSecondaryAttachmentGUID4":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "attachment", 3);
    case "loadoutSecondaryAttachmentGUID5":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "attachment", 4);
    case "loadoutSecondaryAttachmentGUID6":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "attachment", 5);
    case "loadoutSecondaryCamoGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "camo");
    case "loadoutSecondaryCamo2GUID":
      return 0;
    case "loadoutSecondaryReticleGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "reticle");
    case "loadoutSecondaryPaintjobId":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "paintjob");
    case "loadoutSecondaryCharmGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "charm");
    case "loadoutEquipmentGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "equipmentSetups", 0, "equipment");
    case "loadoutEquipmentNumExtra":
      if(_func_30E(_getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "equipmentSetups", 0, "numExtra"))) {
        return int(_getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "equipmentSetups", 0, "numExtra"));
      } else {
        return 0;
      }
    case "loadoutOffhandGUID":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "equipmentSetups", 1, "equipment");
    case "loadoutOffhandNumExtra":
      return 0;
    case "loadoutStreakGUID1":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "assaultStreaks", 0, "streak");
    case "loadoutStreakGUID2":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "assaultStreaks", 1, "streak");
    case "loadoutStreakGUID3":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "assaultStreaks", 2, "streak");
    case "loadoutStreakGUID4":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "assaultStreaks", 3, "streak");
    case "loadoutPerkGUID1":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 0);
    case "loadoutPerkGUID2":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 1);
    case "loadoutPerkGUID3":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 2);
    case "loadoutPerkGUID4":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 3);
    case "loadoutPerkGUID5":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 4);
    case "loadoutPerkGUID6":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 5);
    case "loadoutPerkGUID7":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 6);
    case "loadoutPerkGUID8":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 7);
    case "loadoutPerkGUID9":
      return _getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 8);
    default:
  }

  return "none";
}

init_bot_attachmenttable() {
  level.bot_attachkittable = [];
  level._id_193B = [];
  var_0 = 1;

  for(;;) {
    var_1 = _tablelookupbyrow("mp/attachmenttable.csv", var_0, 3);

    if(var_1 == "done") {
      break;
    }

    var_2 = _tablelookupbyrow("mp/attachmenttable.csv", var_0, 15);

    if(var_1 != "" && var_2 != "") {
      var_3 = _tablelookupbyrow("mp/attachmenttable.csv", var_0, 7);

      if(var_3 == "TRUE") {
        level._id_193B[var_1] = 1;
      }

      var_4 = strtok(var_2, "| ");

      foreach(var_6 in var_4) {
        if(!isDefined(level.bot_attachkittable[var_6])) {
          level.bot_attachkittable[var_6] = [];
        }

        if(!common_scripts\utility::_id_0F79(level.bot_attachkittable[var_6], var_1)) {
          var_7 = level.bot_attachkittable[var_6].size;
          level.bot_attachkittable[var_6][var_7] = var_1;
        }
      }
    }

    var_0++;
  }

  level._id_1A24 = [];
  level._id_0C1A = [];
  var_9 = 0;

  for(;;) {
    var_9++;
    var_10 = _tablelookupbyrow("mp/attachmentcombos_mtx12.csv", 0, var_9);

    if(var_10 == "") {
      break;
    }

    var_0 = 0;

    for(;;) {
      var_0++;
      var_11 = _tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_0, 0);

      if(var_11 == "") {
        break;
      }

      if(var_11 == var_10) {
        if(_tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_0, var_9) != "no") {
          level._id_0C1A[var_11] = 1;
        }

        continue;
      }

      if(_tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_0, var_9) == "no") {
        level._id_1A24[var_10][var_11] = 1;
      }
    }
  }
}

bot_loadout_choose_from_attachkittable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(!isDefined(level.bot_attachkittable)) {
    return var_5;
  }

  if(!isDefined(level.bot_attachkittable[var_4])) {
    return var_5;
  }

  var_6 = bot_loadout_choose_from_set(level.bot_attachkittable[var_4], var_0, var_1, var_2);

  if(_isstring(var_6)) {
    var_5 = maps\mp\_utility::_id_452A(var_6);
  } else {
    var_5 = var_6;
  }

  return var_5;
}

init_bot_weap_statstable() {
  var_0 = "mp/reticletable.csv";
  var_1 = 1;
  var_2 = 8;
  level.bot_reticletable = [];
  var_3 = 0;

  for(;;) {
    var_4 = _tablelookupbyrow(var_0, var_3, var_1);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = maps\mp\_utility::_id_452A(var_4);
    var_6 = _tablelookupbyrow(var_0, var_3, var_2);

    if(isDefined(var_6) && int(var_6)) {
      level.bot_reticletable[level.bot_reticletable.size] = var_4;
    }

    var_3++;
  }
}

bot_loadout_choose_from_reticletable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(!isDefined(level.bot_reticletable) || level.bot_reticletable.size == 0) {
    return var_5;
  }

  var_6 = randomint(100) > 50;

  if(var_6) {
    var_7 = bot_loadout_choose_from_set(level.bot_reticletable, var_0, var_1, var_2);

    if(_isstring(var_7)) {
      var_5 = maps\mp\_utility::_id_452A(var_7);
    } else {
      var_5 = var_7;
    }
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
    var_6 = _tablelookupbyrow(var_0, var_5, var_1);

    if(!isDefined(var_6) || var_6 == "") {
      break;
    }

    var_7 = int(_tablelookupbyrow(var_0, var_5, var_4));
    var_8 = _tablelookupbyrow(var_0, var_5, var_2);

    if(isDefined(var_8) && var_8 != "" && !var_7) {
      var_9 = maps\mp\_utility::_id_452A(var_6);
      var_10 = _tablelookupbyrow(var_0, var_5, var_3);

      if(isDefined(var_10) && int(var_10)) {
        level.bot_camotable[level.bot_camotable.size] = var_6;
      }
    }

    var_5++;
  }
}

bot_loadout_choose_from_camotable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(!isDefined(level.bot_camotable) || level.bot_camotable.size == 0) {
    return var_5;
  }

  var_6 = randomint(100) > 50;

  if(var_6) {
    var_7 = bot_loadout_choose_from_set(level.bot_camotable, var_0, var_1, var_2);

    if(_isstring(var_7)) {
      var_5 = maps\mp\_utility::_id_452A(var_7);
    } else {
      var_5 = var_7;
    }
  }

  return var_5;
}

bot_loadout_item_valid_for_rank(var_0, var_1, var_2) {
  if(_isagent(self)) {
    return 1;
  }

  if(!_isstring(var_1)) {
    var_1 = maps\mp\_utility::_id_452B(var_1);
  }

  if(!isDefined(level.bot_min_rank_for_item[var_1])) {
    var_3 = "mp/unlockTable.csv";
    var_4 = _tablelookuprownum(var_3, 0, var_1);
    level.bot_min_rank_for_item[var_1] = int(_tablelookupbyrow(var_3, var_4, 2));
  }

  if(var_0 == "classtable_any" && var_2 == "recruit") {
    return 1;
  }

  if(!isDefined(self.rank_for_items)) {
    self.rank_for_items = self.pers["rank"];

    if(!isDefined(self.rank_for_items)) {
      self.rank_for_items = level.bot_rnd_rank[var_2][0];
    }
  }

  if(level.bot_min_rank_for_item[var_1] <= self.rank_for_items) {
    return 1;
  }

  return 0;
}

_id_1A66(var_0, var_1) {
  if(!_isstring(var_0)) {
    var_0 = maps\mp\_utility::_id_452B(var_0);
  }

  return maps\mp\gametypes\_class::isvalidequipment(var_0, 0);
}

_id_1A67(var_0, var_1) {
  if(!_isstring(var_0)) {
    var_0 = maps\mp\_utility::_id_452B(var_0);
  }

  return maps\mp\gametypes\_class::_id_5833(var_0, 0);
}

_id_1A12(var_0, var_1) {
  var_2 = var_0["loadoutPerkGUID4"];

  if(_func_30D(var_2)) {
    var_2 = maps\mp\_utility::_id_452B(var_2);
  }

  return var_2 == var_1;
}

bot_loadout_valid_choice(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  switch (var_2) {
    case "loadoutDivision":
      if(_func_30D(var_3)) {
        var_4 = _id_04CA::_id_56CC(var_3);
      } else {
        var_4 = _id_04CA::_id_56CB(var_3);
      }

      break;
    case "loadoutPrimaryGUID":
      var_5 = var_3;

      if(maps\mp\_utility::_id_5856(var_5)) {
        var_5 = maps\mp\gametypes\_class::getbasefromlootversion(var_5);
      }

      var_4 = bot_loadout_item_allowed("weapon", var_5, undefined);
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidprimary(var_5, _id_1A12(var_1, "specialty_class_serrated"));
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutEquipmentGUID":
      var_4 = bot_loadout_item_allowed("perk", var_3, "Lethal");
      var_4 = var_4 && _id_1A66(var_3, var_1);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutEquipmentNumExtra":
      var_4 = _func_30D(var_3) && var_3 >= 0;
      break;
    case "loadoutOffhandGUID":
      var_4 = bot_loadout_item_allowed("perk", var_3, "Tactical");
      var_4 = var_4 && _id_1A67(var_3, var_1);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutOffhandNumExtra":
      var_4 = _func_30D(var_3) && var_3 >= 0;
      break;
    case "loadoutPrimaryAttachmentGUID1":
      var_4 = _id_1B1A(var_1["loadoutPrimaryGUID"], var_3);
      break;
    case "loadoutPrimaryAttachmentGUID2":
      var_4 = _id_1B1A(var_1["loadoutPrimaryGUID"], var_1["loadoutPrimaryAttachmentGUID1"], var_3);
      break;
    case "loadoutPrimaryAttachmentGUID3":
      var_4 = _id_1B1A(var_1["loadoutPrimaryGUID"], var_1["loadoutPrimaryAttachmentGUID1"], var_1["loadoutPrimaryAttachmentGUID2"], var_3);
      break;
    case "loadoutPrimaryAttachmentGUID4":
      var_4 = _id_1B1A(var_1["loadoutPrimaryGUID"], var_1["loadoutPrimaryAttachmentGUID1"], var_1["loadoutPrimaryAttachmentGUID2"], var_1["loadoutPrimaryAttachmentGUID3"], var_3);
      break;
    case "loadoutPrimaryAttachmentGUID5":
      var_4 = _id_1B1A(var_1["loadoutPrimaryGUID"], var_1["loadoutPrimaryAttachmentGUID1"], var_1["loadoutPrimaryAttachmentGUID2"], var_1["loadoutPrimaryAttachmentGUID3"], var_1["loadoutPrimaryAttachmentGUID4"], var_3);
      break;
    case "loadoutPrimaryAttachmentGUID6":
      var_4 = _id_1B1A(var_1["loadoutPrimaryGUID"], var_1["loadoutPrimaryAttachmentGUID1"], var_1["loadoutPrimaryAttachmentGUID2"], var_1["loadoutPrimaryAttachmentGUID3"], var_1["loadoutPrimaryAttachmentGUID4"], var_1["loadoutPrimaryAttachmentGUID5"], var_3);
      break;
    case "loadoutPrimaryReticleGUID":
      var_4 = bot_validate_reticle("loadoutPrimaryGUID", var_1, var_3);
      break;
    case "loadoutPrimaryCamoGUID":
      if(_func_30D(var_3)) {
        var_6 = var_3;
      } else {
        var_6 = maps\mp\_utility::_id_452A(var_3);
      }

      var_4 = !isDefined(self.botloadoutfavoritecamoprimary) || var_6 == self.botloadoutfavoritecamoprimary;
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo(var_6);
      break;
    case "loadoutPrimaryCamo2GUID":
      if(_func_30D(var_3)) {
        var_6 = var_3;
      } else {
        var_6 = maps\mp\_utility::_id_452A(var_3);
      }

      var_4 = var_6 == 0;
      break;
    case "loadoutPrimaryPaintjobId":
      break;
    case "loadoutPrimaryCharmGUID":
      break;
    case "loadoutSecondaryGUID":
      if(_func_30D(var_3)) {
        var_3 = maps\mp\_utility::_id_452B(var_3);
      }

      var_4 = var_3 != maps\mp\_utility::_id_452B(var_1["loadoutPrimaryGUID"]);
      var_5 = var_3;

      if(maps\mp\_utility::_id_5856(var_5)) {
        var_5 = maps\mp\gametypes\_class::getbasefromlootversion(var_5);
      }

      var_4 = var_4 && bot_loadout_item_allowed("weapon", var_5, undefined);
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidsecondary(var_5, _id_1A12(var_1, "specialty_class_rifleman"), _id_1A12(var_1, "specialty_class_launched"));
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutSecondaryAttachmentGUID1":
      var_4 = _id_1B1A(var_1["loadoutSecondaryGUID"], var_3, "none");
      break;
    case "loadoutSecondaryAttachmentGUID2":
      var_4 = _id_1B1A(var_1["loadoutSecondaryGUID"], var_1["loadoutSecondaryAttachmentGUID1"], var_3);
      break;
    case "loadoutSecondaryAttachmentGUID3":
      var_4 = _id_1B1A(var_1["loadoutSecondaryGUID"], var_1["loadoutSecondaryAttachmentGUID1"], var_1["loadoutSecondaryAttachmentGUID2"], var_3);
      break;
    case "loadoutSecondaryAttachmentGUID4":
      var_4 = _id_1B1A(var_1["loadoutSecondaryGUID"], var_1["loadoutSecondaryAttachmentGUID1"], var_1["loadoutSecondaryAttachmentGUID2"], var_1["loadoutSecondaryAttachmentGUID3"], var_3);
      break;
    case "loadoutSecondaryAttachmentGUID5":
      var_4 = _id_1B1A(var_1["loadoutSecondaryGUID"], var_1["loadoutSecondaryAttachmentGUID1"], var_1["loadoutSecondaryAttachmentGUID2"], var_1["loadoutSecondaryAttachmentGUID3"], var_1["loadoutSecondaryAttachmentGUID4"], var_3);
      break;
    case "loadoutSecondaryAttachmentGUID6":
      var_4 = _id_1B1A(var_1["loadoutSecondaryGUID"], var_1["loadoutSecondaryAttachmentGUID1"], var_1["loadoutSecondaryAttachmentGUID2"], var_1["loadoutSecondaryAttachmentGUID3"], var_1["loadoutSecondaryAttachmentGUID4"], var_1["loadoutSecondaryAttachmentGUID5"], var_3);
      break;
    case "loadoutSecondaryReticleGUID":
      var_4 = bot_validate_reticle("loadoutSecondaryGUID", var_1, var_3);
      break;
    case "loadoutSecondaryCamoGUID":
      if(_func_30D(var_3)) {
        var_6 = var_3;
      } else {
        var_6 = maps\mp\_utility::_id_452A(var_3);
      }

      var_4 = !isDefined(self.botloadoutfavoritecamosecondary) || var_6 == self.botloadoutfavoritecamosecondary;
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo(var_6);
      break;
    case "loadoutSecondaryCamo2GUID":
      if(_func_30D(var_3)) {
        var_6 = var_3;
      } else {
        var_6 = maps\mp\_utility::_id_452A(var_3);
      }

      var_4 = var_6 == 0;
      break;
    case "loadoutSecondaryPaintjobId":
      break;
    case "loadoutSecondaryCharmGUID":
      break;
    case "loadoutStreakGUID4":
    case "loadoutStreakGUID3":
    case "loadoutStreakGUID2":
    case "loadoutStreakGUID1":
      var_4 = maps\mp\bots\_bots_ks::bot_killstreak_is_valid_internal(var_3, "bots", undefined);
      var_4 = var_4 && bot_loadout_item_allowed("killstreak", var_3, undefined);
      break;
    case "loadoutPerkGUID3":
    case "loadoutPerkGUID2":
    case "loadoutPerkGUID1":
    case "loadoutPerkGUID9":
    case "loadoutPerkGUID8":
    case "loadoutPerkGUID7":
    case "loadoutPerkGUID6":
    case "loadoutPerkGUID5":
    case "loadoutPerkGUID4":
      var_4 = bot_validate_perk(var_3, var_2, var_1);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutWildcardGUID3":
    case "loadoutWildcardGUID2":
    case "loadoutWildcardGUID1":
      break;
    default:
      break;
  }

  return var_4;
}

bot_loadout_choose_from_set(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 0.0;

  if(common_scripts\utility::_id_0F79(var_0, "specialty_null")) {
    var_5 = "specialty_null";
  } else if(var_3 == "loadoutEquipmentGUID" || var_3 == "loadoutOffhandGUID" || issubstr(_tolower(var_3), "perk")) {
    var_5 = "specialty_null";
  }

  if(var_1 == "classtable_any") {
    if(!isDefined(self.default_class_chosen)) {
      self.default_class_chosen = common_scripts\utility::random(["class1", "class2", "class3", "class4", "class5"]);
    }

    var_0 = [self.default_class_chosen];
  }

  foreach(var_10 in var_0) {
    var_11 = undefined;
    var_12 = undefined;

    if(getsubstr(var_10, 0, 9) == "template_") {
      var_12 = var_10;
      var_13 = level.botloadouttemplates[var_10][var_3];
      var_10 = bot_loadout_choose_from_set(strtok(var_13, "| "), var_1, var_2, var_3, 1);

      if(isDefined(var_12) && isDefined(self.chosentemplates[var_12])) {
        return var_10;
      }
    }

    if(_isstring(var_10) && var_10 == "specialty_class_assigned") {
      var_14 = maps\mp\_utility::_id_452B(var_2["loadoutPerkGUID4"]);

      if(!isDefined(level._id_1B38[var_14])) {
        var_14 = "specialty_class_any";
      }

      var_15 = level._id_1B38[var_14][var_3];
      var_10 = bot_loadout_choose_from_set(strtok(var_15, "| "), var_1, var_2, var_3, 0);
    }

    if(_isstring(var_10) && _func_2C6(var_10, "division_")) {
      if(var_10 == "division_assigned") {
        var_11 = "division_" + _id_04CA::_id_44A0(var_2["loadoutDivision"]);
        var_16 = level._id_1B30[var_11][var_3];
        var_10 = bot_loadout_choose_from_set(strtok(var_16, "| "), var_1, var_2, var_3, 0);
      } else
        var_10 = pick_division_from_loadout_value(var_10);
    }

    if(_isstring(var_10)) {
      if(var_10 == "attachmenttable") {
        return bot_loadout_choose_from_attachkittable(var_1, var_2, var_3, self.personality, self.difficulty);
      }

      if(var_10 == "weap_statstable") {
        return bot_loadout_choose_from_statstable(var_1, var_2, var_3, self.personality, self.difficulty);
      }

      if(var_10 == "reticletable") {
        return bot_loadout_choose_from_reticletable(var_1, var_2, var_3, self.personality, self.difficulty);
      }

      if(var_10 == "camotable") {
        return bot_loadout_choose_from_camotable(var_1, var_2, var_3, self.personality, self.difficulty);
      }

      if(getsubstr(var_10, 0, 5) == "class" && int(getsubstr(var_10, 5, 6)) > 0) {
        var_10 = bot_loadout_choose_from_default_class(var_10, var_3);
      }
    }

    if(issubstr(var_3, "Num")) {
      var_10 = int(var_10);
    }

    if(bot_loadout_valid_choice(var_1, var_2, var_3, var_10)) {
      var_8 = var_8 + 1.0;
      var_17 = _randomfloat(1.0);

      if(var_17 <= 1.0 / var_8) {
        var_5 = var_10;
        var_6 = var_12;
      }
    }
  }

  if(isDefined(var_6)) {
    self.chosentemplates[var_6] = 1;
  }

  if(_isstring(var_5) && (var_5 == "none" || var_5 == "specialty_null")) {
    return 0;
  }

  return var_5;
}

pick_division_from_loadout_value(var_0) {
  var_1 = level._id_1B30[var_0]["loadoutDivision"];
  var_2 = bot_loadout_choose_from_set(strtok(var_1, "| "), "", undefined, "loadoutDivision", 0);

  if(!_func_30D(var_2) && _id_04CA::_id_56CB(var_2)) {
    var_3 = "division_" + var_2;
    var_2 = _id_04CA::_id_449C(var_2);
  }

  return var_2;
}

bot_loadout_choose_values(var_0) {
  self.chosentemplates = [];

  foreach(var_6, var_2 in var_0) {
    var_3 = undefined;

    if(!isDefined(var_3)) {
      var_5 = strtok(var_2, "| ");
      var_3 = bot_loadout_choose_from_set(var_5, var_2, var_0, var_6);
    }

    if(_isstring(var_3)) {
      var_3 = maps\mp\_utility::_id_452A(var_3);
    }

    var_0[var_6] = var_3;
  }

  return var_0;
}

bot_loadout_get_difficulty() {
  var_0 = self botgetdifficulty();

  if(var_0 == "default") {
    maps\mp\bots\_bots_util::bot_set_difficulty("default");
    var_0 = self botgetdifficulty();
  }

  return var_0;
}

bot_get_stored_custom_classes() {
  if(isDefined(self.pers["botCustomClasses"])) {
    return self.pers["botCustomClasses"];
  }

  return [];
}

bot_get_stored_launcher_class() {
  if(bot_get_stored_custom_classes().size > 0) {
    if(isDefined(self.pers["botLauncherClassIndex"])) {
      var_0 = self.pers["botLauncherClassIndex"];
      return self.pers["botCustomClasses"][var_0];
    }
  }

  return undefined;
}

bot_allowed_to_try_last_loadout() {
  if(common_scripts\utility::_id_562E(self.bot_pick_new_loadout_next_spawn)) {
    return 0;
  } else if(!isDefined(self.pers["botLastLoadout"])) {
    return 0;
  } else if(common_scripts\utility::_id_562E(self.respawn_with_launcher)) {
    return 0;
  } else if(isDefined(self.hasdied) && !self.hasdied) {
    return 0;
  }

  return 1;
}

bot_loadout_class_callback(var_0) {
  while(!isDefined(level.bot_loadouts_initialized)) {
    waitframe();
  }

  while(!isDefined(self.personality)) {
    waitframe();
  }

  var_1 = [];
  var_2 = bot_loadout_get_difficulty();
  self.difficulty = var_2;
  var_3 = self botgetpersonality();

  if(!isDefined(self.bot_last_loadout_num)) {
    self.bot_cur_loadout_num = 0;
  }

  self.bot_last_loadout_num = self.bot_cur_loadout_num;

  if(isDefined(self.pers["botLastLoadout"]) && common_scripts\utility::_id_562E(var_0)) {
    return self.pers["botLastLoadout"];
  }

  var_4 = !isDefined(self.pers["botLastLoadoutDifficulty"]) || self.pers["botLastLoadoutDifficulty"] == var_2;
  var_5 = !isDefined(self.pers["botLastLoadoutPersonality"]) || self.pers["botLastLoadoutPersonality"] == var_3;
  var_6 = 0;

  if(!var_4 || !var_5) {
    self.pers["botLastLoadout"] = undefined;
    self.pers["botCustomClasses"] = undefined;
    self.pers["botLauncherClassIndex"] = undefined;
    var_6 = 1;
  }

  var_7 = !var_6 && bot_allowed_to_try_last_loadout();

  if(var_7) {
    var_8 = 0.1;
    var_10 = _randomfloat(1.0) > var_8;

    if(var_10) {
      return self.pers["botLastLoadout"];
    }
  }

  self.bot_pick_new_loadout_next_spawn = undefined;

  if(!var_6) {
    var_11 = bot_get_stored_launcher_class();
    var_12 = undefined;

    if(isDefined(self.respawn_with_launcher) && isDefined(var_11)) {
      self.respawn_with_launcher = undefined;
      self.bot_pick_new_loadout_next_spawn = 1;
      var_12 = var_11;
    }

    if(!isDefined(var_12)) {
      var_13 = bot_get_stored_custom_classes();
      var_14 = 0;

      if(isDefined(var_11)) {
        if(var_13.size < 5) {
          var_14 = 1;
        }
      } else if(isDefined(self.respawn_with_launcher))
        var_14 = 1;
      else if(var_13.size < 4) {
        var_14 = 1;
      }

      if(!var_14) {
        var_12 = common_scripts\utility::random(var_13);
      }
    }

    if(isDefined(var_12)) {
      self.bot_cur_loadout_num++;
      self.pers["botLastLoadout"] = var_12;
      return var_12;
    }
  }

  var_15 = undefined;
  var_16 = bot_custom_classes_allowed();

  if(var_16) {
    var_15 = bot_loadout_pick(var_3, var_2);
    var_1 = bot_loadout_choose_values(var_15);

    if(isDefined(level.bot_funcs["gametype_loadout_modify"])) {
      var_1 = self[[level.bot_funcs["gametype_loadout_modify"]]](var_1);
    }

    if(_id_1A78(var_1)) {
      var_16 = 0;
    }
  }

  if(!var_16) {
    var_1 = bot_default_class_random();
    bot_pick_personality_from_weapon(var_1["loadoutPrimaryGUID"]);
  }

  if(var_1["loadoutPrimaryGUID"] == 0) {
    self.bot_fallback_personality = undefined;
    var_1["loadoutPrimaryGUID"] = bot_loadout_choose_fallback_primary(var_1);
    var_1["loadoutPrimaryCamoGUID"] = 0;
    var_1["loadoutPrimaryAttachmentGUID1"] = 0;
    var_1["loadoutPrimaryAttachmentGUID2"] = 0;
    var_1["loadoutPrimaryAttachmentGUID3"] = 0;
    var_1["loadoutPrimaryReticleGUID"] = 0;
    var_1["loadoutPrimaryPaintjobId"] = 0;
    var_1["loadoutPrimaryCharmGUID"] = 0;

    if(isDefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon") {
        bot_pick_personality_from_weapon(var_1["loadoutPrimaryGUID"]);
      } else {
        maps\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);
      }

      var_3 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  var_20 = isDefined(self.respawn_with_launcher);

  if(var_16 && maps\mp\bots\_bots::bot_israndom()) {
    if(isDefined(var_1["loadoutPrimaryCamoGUID"]) && var_1["loadoutPrimaryCamoGUID"] != 0 && !isDefined(self.botloadoutfavoritecamoprimary)) {
      self.botloadoutfavoritecamoprimary = var_1["loadoutPrimaryCamoGUID"];
    }

    if(isDefined(var_1["loadoutSecondaryCamoGUID"]) && var_1["loadoutSecondaryCamoGUID"] != 0 && !isDefined(self.botloadoutfavoritecamosecondary)) {
      self.botloadoutfavoritecamosecondary = var_1["loadoutSecondaryCamoGUID"];
    }

    if(var_20) {
      var_21 = level.bot_respawn_launcher_name[self botgetdifficulty()];

      if(bot_loadout_item_allowed("weapon", var_21, undefined)) {
        var_1["loadoutSecondaryGUID"] = var_21;
        var_1["loadoutSecondaryAttachmentGUID1"] = 0;
        var_1["loadoutSecondaryAttachmentGUID2"] = 0;
        var_1["loadoutSecondaryAttachmentGUID3"] = 0;
        var_1["loadoutSecondaryAttachmentGUID4"] = 0;
        var_1["loadoutSecondaryAttachmentGUID5"] = 0;
        var_1["loadoutSecondaryAttachmentGUID6"] = 0;
        self.bot_pick_new_loadout_next_spawn = 1;
      }

      self.respawn_with_launcher = undefined;
    }
  }

  maps\mp\gametypes\_class::_id_582D(var_1["loadoutStreakGUID1"]);
  maps\mp\gametypes\_class::_id_582D(var_1["loadoutStreakGUID2"]);
  maps\mp\gametypes\_class::_id_582D(var_1["loadoutStreakGUID3"]);
  var_1["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(var_1["loadoutPrimaryGUID"], 0);
  var_1["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(var_1["loadoutSecondaryGUID"], 0);
  var_1["loadoutEquipmentStruct"] = maps\mp\_utility::_id_44CE(var_1["loadoutEquipmentGUID"], 0);
  var_1["loadoutEquipmentNumExtra"] = int(var_1["loadoutEquipmentNumExtra"]);
  var_1["loadoutOffhandStruct"] = maps\mp\_utility::_id_44CE(var_1["loadoutOffhandGUID"], 0);
  var_1["loadoutOffhandNumExtra"] = int(var_1["loadoutOffhandNumExtra"]);
  var_1["loadoutPrimaryAttachmentsGUID"] = [];
  var_1["loadoutSecondaryAttachmentsGUID"] = [];

  for(var_22 = 0; var_22 < 6; var_22++) {
    var_1["loadoutPrimaryAttachmentsGUID"][var_22] = var_1["loadoutPrimaryAttachmentGUID" + (var_22 + 1)];
    var_1["loadoutSecondaryAttachmentsGUID"][var_22] = var_1["loadoutSecondaryAttachmentGUID" + (var_22 + 1)];
  }

  self.bot_cur_loadout_num++;
  self.pers["botLastLoadout"] = var_1;
  self.pers["botLastLoadoutDifficulty"] = var_2;
  self.pers["botLastLoadoutPersonality"] = var_3;

  if(!isDefined(self.pers["botCustomClasses"])) {
    self.pers["botCustomClasses"] = [];
  }

  var_23 = self.pers["botCustomClasses"].size;
  self.pers["botCustomClasses"][var_23] = var_1;

  if(var_20) {
    self.pers["botLauncherClassIndex"] = var_23;
  }

  return var_1;
}

_id_1A78(var_0) {
  if(_isusingmatchrulesdata()) {
    if(var_0["loadoutPrimaryGUID"] == 0) {
      return 1;
    }
  }

  return 0;
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

bot_modify_behavior_from_loadout() {}