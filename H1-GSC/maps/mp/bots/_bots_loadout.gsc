/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_loadout.gsc
******************************************/

init() {
  init_template_table();
  init_class_table();
  init_bot_attachkittable();
  init_bot_weap_statstable();
  init_bot_camotable();
  level.bot_min_rank_for_item = [];
  level.bot_loadouts_initialized = 1;
}

init_class_table() {
  var_0 = "mp\botClassTable.csv";
  level.botloadoutsets = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for (;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "botPersonalities", var_2);
    var_4 = tablelookup(var_0, 0, "botDifficulties", var_2);

    if(!isdefined(var_3) || var_3 == "") {
      break;
    }

    if(!isdefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = [];

    foreach(var_7 in var_1)
    var_5[var_7] = tablelookup(var_0, 0, var_7, var_2);

    var_9 = strtok(var_3, "| ");
    var_10 = strtok(var_4, "| ");

    foreach(var_12 in var_9) {
      foreach(var_14 in var_10) {
        var_15 = bot_loadout_set(var_12, var_14, 1);
        var_16 = spawnstruct();
        var_16.loadoutvalues = var_5;
        var_15.loadouts[var_15.loadouts.size] = var_16;
      }
    }
  }
}

init_template_table() {
  var_0 = "mp\botTemplateTable.csv";
  level.botloadouttemplates = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for (;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "template_", var_2);

    if(!isdefined(var_3) || var_3 == "") {
      break;
    }

    var_4 = "template_" + var_3;
    level.botloadouttemplates[var_4] = [];

    foreach(var_6 in var_1) {
      var_7 = tablelookup(var_0, 0, var_6, var_2);

      if(isdefined(var_7) && var_7 != "")
        level.botloadouttemplates[var_4][var_6] = var_7;
    }
  }
}

bot_custom_classes_allowed() {
  if(isusingmatchrulesdata()) {
    if(!getmatchrulesdata("commonOption", "allowCustomClasses"))
      return 0;
  }

  return 1;
}

bot_loadout_item_allowed(var_0, var_1, var_2) {
  if(!isusingmatchrulesdata())
    return 1;

  if(!bot_custom_classes_allowed())
    return 0;

  if(var_1 == "specialty_null")
    return 1;

  if(var_1 == "none")
    return 1;

  var_3 = var_0 + "Restricted";
  var_4 = var_0 + "ClassRestricted";
  var_5 = "";

  switch (var_0) {
    case "weapon":
      var_5 = maps\mp\_utility::getweaponclass(var_1);
      break;
    case "attachment":
      var_3 = "attachmentBaseRestricted";
      var_1 = maps\mp\_utility::getbasearrayforattachkit(var_1);

      foreach(var_7 in var_1) {
        if(var_5 == "")
          var_5 = maps\mp\_utility::getgroupforattachkitbase(var_7);
      }

      break;
    case "perk":
      var_5 = var_2;
      break;
    default:
      return 0;
  }

  if(isarray(var_1)) {
    foreach(var_7 in var_1) {
      if(getmatchrulesdata("commonOption", var_3, var_7))
        return 0;
    }
  } else if(getmatchrulesdata("commonOption", var_3, var_1))
    return 0;

  if(var_5 != "" && getmatchrulesdata("commonOption", var_4, var_5))
    return 0;

  return 1;
}

bot_loadout_choose_fallback_primary(var_0) {
  var_1 = "none";
  var_2 = ["veteran", "hardened", "regular", "recruit"];
  var_2 = common_scripts\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimary", self.personality, var_4);

    if(var_1 != "none")
      return var_1;
  }

  if(isdefined(level.bot_personality_list)) {
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

    for (var_14 = "none"; var_13 < 5; var_13++) {
      if(getmatchrulesdata("defaultClasses", bot_loadout_team(), "defaultClass", var_13, "class", "inUse")) {
        var_1 = bot_loadout_choose_from_custom_default_class(var_13, "loadoutPrimary");

        if(var_1 != "none") {
          var_12 = var_12 + 1.0;

          if(randomfloat(1.0) >= 1.0 / var_12)
            var_14 = var_1;
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
  if(!isdefined(level.teambased) || !level.teambased)
    return "allies";

  return maps\mp\bots\_bots::bot_get_player_team();
}

bot_default_class_random() {
  var_0 = ["class1", "class2", "class3", "class4", "class5"];

  if(isusingmatchrulesdata()) {
    for (var_1 = 0; var_1 < var_0.size; var_1++) {
      if(getmatchrulesdata("defaultClasses", bot_loadout_team(), "defaultClass", var_1, "class", "inUse"))
        var_0[var_1] = var_1;
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
  if(isdefined(var_0)) {
    var_1 = level.bot_weap_personality[var_0];

    if(isdefined(var_1)) {
      var_2 = strtok(var_1, "| ");

      if(var_2.size > 0)
        maps\mp\bots\_bots_util::bot_set_personality(common_scripts\utility::random(var_2));
    }
  }
}

bot_loadout_fields() {
  var_0 = "mp\botClassTable.csv";

  if(!isdefined(level.bot_loadout_fields)) {
    level.bot_loadout_fields = [];
    var_1 = 2;

    for (;;) {
      var_2 = tablelookupbyrow(var_0, var_1, 0);

      if(var_2 == "") {
        break;
      }

      level.bot_loadout_fields[level.bot_loadout_fields.size] = var_2;
      var_1++;
    }
  }

  return level.bot_loadout_fields;
}

bot_loadout_set(var_0, var_1, var_2) {
  var_3 = var_1 + "_" + var_0;

  if(!isdefined(level.botloadoutsets))
    level.botloadoutsets = [];

  if(!isdefined(level.botloadoutsets[var_3]) && var_2) {
    level.botloadoutsets[var_3] = spawnstruct();
    level.botloadoutsets[var_3].loadouts = [];
  }

  if(isdefined(level.botloadoutsets[var_3]))
    return level.botloadoutsets[var_3];
}

bot_loadout_pick(var_0, var_1) {
  var_2 = bot_loadout_set(var_0, var_1, 0);

  if(isdefined(var_2) && isdefined(var_2.loadouts) && var_2.loadouts.size > 0) {
    var_3 = randomint(var_2.loadouts.size);
    return var_2.loadouts[var_3].loadoutvalues;
  }
}

bot_validate_attachkit_for_weapon(var_0, var_1, var_2) {
  if(var_1 == "none")
    return 0;

  if(var_0 == "none")
    return 1;

  if(!bot_loadout_item_allowed("attachment", var_0, undefined))
    return 0;

  if(var_1 == "h1_mp44" || var_1 == "h1_deserteagle" || var_1 == "h1_deserteagle55")
    return 0;

  var_3 = var_1 + "_mp";
  var_4 = weaponclass(var_3);

  if(var_0 == "silencer" && var_2 == "recruit") {
    if(var_4 != "pistol")
      return 0;
  }

  if(var_0 == "acog" && var_4 == "sniper") {
    if(!self.bot_loadout_can_pick_acog_for_sniper)
      return 0;
  }

  if(bot_attachkit_replaces_perk1(var_0)) {
    if(isdefined(self.loadoutitemsalreadychosen) && isdefined(self.loadoutitemsalreadychosen["loadoutPerk1"])) {
      if(self.loadoutitemsalreadychosen["loadoutPerk1"] != "specialty_null")
        return 0;
    }
  }

  if(var_0 == "silencer") {
    if(!self.bot_loadout_can_pick_silencer)
      return 0;
  }

  var_5 = level.bot_attachkittable_reference[var_0]["validClasses"];
  var_6 = level.bot_attach_weaponclasstoattachtableclass[var_4];

  if(!common_scripts\utility::array_contains(var_5, var_6))
    return 0;

  var_7 = getattachmentsforweapon(var_3);

  if(var_7.size == 0)
    return 0;

  var_8 = level.bot_attachkittable_reference[var_0]["attachmentArray"];

  if(var_8.size == 1) {
    if(!common_scripts\utility::array_contains(var_7, var_8[0]))
      return 0;
  } else {
    var_9 = 0;

    for (var_10 = 0; var_10 < var_8.size; var_10++) {
      if(common_scripts\utility::array_contains(var_7, var_8[var_10])) {
        var_9 = 1;

        for (var_11 = 0; var_11 < var_8.size; var_11++) {
          if(var_11 != var_10) {

          }
        }

        break;
      }
    }

    if(!var_9)
      return 0;
  }

  return 1;
}

init_bot_weap_statstable() {
  var_0 = "mp\statstable.csv";
  var_1 = 4;
  var_2 = 57;
  var_3 = 58;
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];
  var_4 = 1;

  for (;;) {
    var_5 = tablelookupbyrow(var_0, var_4, 0);

    if(var_5 == "") {
      break;
    }

    var_6 = tablelookupbyrow(var_0, var_4, var_1);
    var_7 = tablelookupbyrow(var_0, var_4, var_3);
    var_8 = tablelookupbyrow(var_0, var_4, var_2);

    if(var_7 != "" && var_6 != "" && var_8 != "") {
      var_9 = "loadoutPrimary";

      if(maps\mp\gametypes\_class::isvalidsecondary(var_6))
        var_9 = "loadoutSecondary";
      else if(!maps\mp\gametypes\_class::isvalidprimary(var_6)) {
        var_4++;
        continue;
      }

      if(var_6 != "" && var_8 != "")
        level.bot_weap_personality[var_6] = var_8;

      if(!isdefined(level.bot_weap_statstable[var_9]))
        level.bot_weap_statstable[var_9] = [];

      var_10 = strtok(var_8, "| ");
      var_11 = strtok(var_7, "| ");

      foreach(var_13 in var_10) {
        if(!isdefined(level.bot_weap_statstable[var_9][var_13]))
          level.bot_weap_statstable[var_9][var_13] = [];

        foreach(var_15 in var_11) {
          if(!isdefined(level.bot_weap_statstable[var_9][var_13][var_15]))
            level.bot_weap_statstable[var_9][var_13][var_15] = [];

          var_16 = level.bot_weap_statstable[var_9][var_13][var_15].size;
          level.bot_weap_statstable[var_9][var_13][var_15][var_16] = var_6;
        }
      }
    }

    var_4++;
  }
}

bot_loadout_choose_from_statstable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";

  if(var_3 == "default")
    var_3 = "run_and_gun";

  var_6 = var_2;

  if(var_6 == "loadoutSecondary" && var_1["loadoutPerk2"] == "specialty_twoprimaries") {
    var_6 = "loadoutPrimary";

    if(var_3 == "camper" || var_3 == "run_and_gun")
      var_3 = "cqb";
    else if(var_3 == "cqb")
      var_3 = "run_and_gun";
  }

  if(!isdefined(level.bot_weap_statstable))
    return var_5;

  if(!isdefined(level.bot_weap_statstable[var_6]))
    return var_5;

  if(!isdefined(level.bot_weap_statstable[var_6][var_3]))
    return var_5;

  if(!isdefined(level.bot_weap_statstable[var_6][var_3][var_4]))
    return var_5;

  var_5 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_6][var_3][var_4], var_0, var_1, var_2);
  return var_5;
}

bot_validate_offhand(var_0, var_1, var_2) {
  if(!bot_loadout_item_allowed("perk", var_0, "Tactical"))
    return 0;

  if(!maps\mp\gametypes\_class::isvalidoffhand(var_0))
    return 0;

  if(var_0 == "h1_smokegrenade_mp") {
    if(isdefined(var_2["loadoutPerk1"])) {
      if(var_2["loadoutPerk1"] == "specialty_specialgrenade")
        return 0;
    }

    if(isdefined(self.loadoutitemsalreadychosen) && isdefined(self.loadoutitemsalreadychosen["loadoutPerk1"])) {
      if(self.loadoutitemsalreadychosen["loadoutPerk1"] == "specialty_specialgrenade")
        return 0;
    }
  }

  return 1;
}

bot_validate_perk(var_0, var_1, var_2) {
  if(var_0 == "specialty_null")
    return 1;

  var_3 = "Perk_Slot1";

  if(var_1 == "loadoutPerk2")
    var_3 = "Perk_Slot2";
  else if(var_1 == "loadoutPerk3")
    var_3 = "Perk_Slot3";

  if(!bot_loadout_item_allowed("perk", var_0, var_3))
    return 0;

  if(var_0 == "specialty_specialgrenade") {
    if(isdefined(var_2["loadoutOffhand"])) {
      if(var_2["loadoutOffhand"] == "h1_smokegrenade_mp")
        return 0;
    }

    if(isdefined(self.loadoutitemsalreadychosen) && isdefined(self.loadoutitemsalreadychosen["loadoutOffhand"])) {
      if(self.loadoutitemsalreadychosen["loadoutOffhand"] == "h1_smokegrenade_mp")
        return 0;
    }
  }

  var_4 = int(getsubstr(var_1, 11));

  if(var_4 == 1) {
    if(isdefined(self.loadoutitemsalreadychosen)) {
      if(isdefined(self.loadoutitemsalreadychosen["loadoutPrimaryAttachKit"])) {
        if(bot_attachkit_replaces_perk1(self.loadoutitemsalreadychosen["loadoutPrimaryAttachKit"]))
          return 0;
      }

      if(isdefined(self.loadoutitemsalreadychosen["loadoutSecondaryAttachKit"])) {
        if(bot_attachkit_replaces_perk1(self.loadoutitemsalreadychosen["loadoutSecondaryAttachKit"]))
          return 0;
      }
    }
  }

  return 1;
}

bot_loadout_choose_from_default_class(var_0, var_1) {
  var_2 = int(getsubstr(var_0, 5, 6)) - 1;

  switch (var_1) {
    case "loadoutPrimary":
      return maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_2, 0);
    case "loadoutPrimaryAttachKit":
      return maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, var_2, 0);
    case "loadoutPrimaryFurnitureKit":
      return maps\mp\gametypes\_class::table_getweaponfurniturekit(level.classtablename, var_2, 0);
    case "loadoutPrimaryCamo":
      return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_2, 0);
    case "loadoutPrimaryReticle":
      return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_2, 0);
    case "loadoutSecondary":
      return maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_2, 1);
    case "loadoutSecondaryAttachKit":
      return maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, var_2, 1);
    case "loadoutSecondaryFurnitureKit":
      return maps\mp\gametypes\_class::table_getweaponfurniturekit(level.classtablename, var_2, 1);
    case "loadoutSecondaryCamo":
      return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_2, 1);
    case "loadoutSecondaryReticle":
      return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_2, 1);
    case "loadoutEquipment":
      return maps\mp\gametypes\_class::table_getequipment(level.classtablename, var_2);
    case "loadoutOffhand":
      return maps\mp\gametypes\_class::table_getoffhand(level.classtablename, var_2);
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_3 = int(getsubstr(var_1, 11)) - 1;
      var_4 = maps\mp\gametypes\_class::table_getperk(level.classtablename, var_2, var_3);

      if(var_4 == "")
        return "specialty_null";

      return var_4;
  }

  return var_0;
}

bot_loadout_choose_from_custom_default_class(var_0, var_1) {
  var_2 = bot_loadout_team();

  switch (var_1) {
    case "loadoutPrimary":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "weapon");
    case "loadoutPrimaryAttachKit":
      var_3 = getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "kit", "attachKit");
      var_4 = tablelookup("mp\attachkits.csv", 0, common_scripts\utility::tostring(var_3), 1);
      return var_4;
    case "loadoutPrimaryFurnitureKit":
      var_5 = getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "kit", "furnitureKit");
      var_6 = tablelookup("mp\furniturekits.csv", 0, common_scripts\utility::tostring(var_5), 1);
      return var_6;
    case "loadoutPrimaryCamo":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "camo");
    case "loadoutPrimaryReticle":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 0, "reticle");
    case "loadoutSecondary":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "weapon");
    case "loadoutSecondaryAttachKit":
      var_3 = getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "kit", "attachKit");
      var_4 = tablelookup("mp\attachkits.csv", 0, common_scripts\utility::tostring(var_3), 1);
      return var_4;
    case "loadoutSecondaryFurnitureKit":
      var_5 = getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "kit", "furnitureKit");
      var_6 = tablelookup("mp\furniturekits.csv", 0, common_scripts\utility::tostring(var_5), 1);
      return var_6;
    case "loadoutSecondaryCamo":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "camo");
    case "loadoutSecondaryReticle":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "weaponSetups", 1, "reticle");
    case "loadoutEquipment":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "equipment", 0);
    case "loadoutOffhand":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "equipment", 1);
    case "loadoutPerk1":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 0);
    case "loadoutPerk2":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 1);
    case "loadoutPerk3":
      return getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_0, "class", "perkSlots", 2);
    default:
  }

  return "none";
}

init_bot_attachkittable() {
  var_0 = "mp\attachkits.csv";
  var_1 = 1;
  var_2 = 2;
  var_3 = 5;
  var_4 = 6;
  var_5 = 12;
  var_6 = 13;
  level.bot_attachkittable = [];
  level.bot_attachkittable_reference = [];
  var_7 = 1;

  for (;;) {
    var_8 = tablelookupbyrow(var_0, var_7, 0);

    if(var_8 == "") {
      break;
    }

    var_9 = tablelookupbyrow(var_0, var_7, var_1);
    var_10 = tablelookupbyrow(var_0, var_7, var_5);
    var_11 = tablelookupbyrow(var_0, var_7, var_6);

    if(var_9 != "" && var_10 != "" && var_11 != "") {
      var_12 = strtok(var_10, "| ");

      foreach(var_14 in var_12) {
        if(!isdefined(level.bot_attachkittable[var_14]))
          level.bot_attachkittable[var_14] = [];

        var_15 = strtok(var_11, "| ");

        foreach(var_17 in var_15) {
          if(!isdefined(level.bot_attachkittable[var_14][var_17]))
            level.bot_attachkittable[var_14][var_17] = [];

          var_18 = level.bot_attachkittable[var_14][var_17].size;
          level.bot_attachkittable[var_14][var_17][var_18] = var_9;
        }
      }

      var_21 = tablelookupbyrow(var_0, var_7, var_4);
      var_22 = strtok(var_21, " ");
      level.bot_attachkittable_reference[var_9]["validClasses"] = var_22;
      var_23 = [];

      for (var_24 = var_2; var_24 <= var_3; var_24++) {
        var_25 = tablelookupbyrow(var_0, var_7, var_24);

        if(var_25 != "")
          var_23[var_23.size] = var_25;
      }

      level.bot_attachkittable_reference[var_9]["attachmentArray"] = var_23;
      level.bot_attachkittable_reference[var_9]["replacesPerk1"] = var_9 == "gl" || var_9 == "grip";
    }

    var_7++;
  }

  level.bot_attach_weaponclasstoattachtableclass["rifle"] = "ast";
  level.bot_attach_weaponclasstoattachtableclass["smg"] = "smg";
  level.bot_attach_weaponclasstoattachtableclass["spread"] = "sht";
  level.bot_attach_weaponclasstoattachtableclass["pistol"] = "pst";
  level.bot_attach_weaponclasstoattachtableclass["mg"] = "lmg";
  level.bot_attach_weaponclasstoattachtableclass["sniper"] = "snp";
}

bot_pick_new_loadout_item(var_0, var_1, var_2, var_3) {
  self.loadoutitemsalreadychosen[var_3] = var_1[var_3];
  var_4 = bot_loadout_choose_from_set([var_0], var_0, var_1, var_2);
  self.loadoutitemsalreadychosen[var_3] = undefined;
  return var_4;
}

bot_cross_validate_attachkit_and_perk(var_0, var_1) {
  var_2 = ["attachKit", "perk"];
  var_3 = undefined;

  if(bot_attachkit_replaces_perk1(var_0["loadoutPrimaryAttachKit"]) && var_0["loadoutPerk1"] != "specialty_null") {
    var_3 = common_scripts\utility::random(var_2);

    if(var_3 == "attachKit") {
      var_4 = "loadoutPrimaryAttachKit";
      var_5 = "loadoutPerk1";
    } else {
      var_4 = "loadoutPerk1";
      var_5 = "loadoutPrimaryAttachKit";
    }

    var_0[var_5] = bot_pick_new_loadout_item(var_1[var_5], var_0, var_5, var_4);
  }

  if(bot_attachkit_replaces_perk1(var_0["loadoutSecondaryAttachKit"]) && var_0["loadoutPerk1"] != "specialty_null") {
    var_4 = "loadoutPerk1";
    var_5 = "loadoutSecondaryAttachKit";
    var_0[var_5] = bot_pick_new_loadout_item(var_1[var_5], var_0, var_5, var_4);
  }

  return var_0;
}

bot_attachkit_replaces_perk1(var_0) {
  if(var_0 == "none")
    return 0;

  if(maps\mp\_utility::is_true(level.bot_attachkittable_reference[var_0]["replacesPerk1"]))
    return 1;

  return 0;
}

bot_perk_get_explosive_list() {
  return ["claymore_mp", "c4_mp", "specialty_fraggrenade", "rpg_mp"];
}

bot_perk_is_explosive(var_0) {
  var_1 = bot_perk_get_explosive_list();

  if(common_scripts\utility::array_contains(var_1, var_0))
    return 1;

  return 0;
}

bot_loadout_choose_from_attachkittable(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(level.bot_attachkittable[var_3]) || !isdefined(level.bot_attachkittable[var_3][var_4]))
    return "none";

  var_5 = bot_loadout_choose_from_set(level.bot_attachkittable[var_3][var_4], var_0, var_1, var_2);
  return var_5;
}

init_bot_camotable() {
  var_0 = "mp\camotable.csv";
  var_1 = 1;
  var_2 = 8;
  var_3 = 9;
  level.bot_camotable = [];
  var_4 = 0;

  for (;;) {
    var_5 = tablelookupbyrow(var_0, var_4, var_1);

    if(!isdefined(var_5) || var_5 == "") {
      break;
    }

    var_6 = tablelookupbyrow(var_0, var_4, var_2);

    if(isdefined(var_6) && var_6 != "") {
      var_7 = tablelookupbyrow(var_0, var_4, var_3);

      if(var_7 != "") {
        var_8 = strtok(var_7, "| ");

        foreach(var_10 in var_8) {
          if(!isdefined(level.bot_camotable[var_10]))
            level.bot_camotable[var_10] = [];

          var_11 = level.bot_camotable[var_10].size;
          level.bot_camotable[var_10][var_11] = var_5;
        }
      }
    }

    var_4++;
  }
}

bot_loadout_choose_from_camotable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";

  if(!isdefined(level.bot_camotable))
    return var_5;

  if(!isdefined(level.bot_camotable[var_4]))
    return var_5;

  var_6 = randomint(100) > 50;

  if(var_6)
    var_5 = bot_loadout_choose_from_set(level.bot_camotable[var_4], var_0, var_1, var_2);

  return var_5;
}

bot_loadout_item_valid_for_rank(var_0, var_1, var_2) {
  if(isagent(self))
    return 1;

  if(!isdefined(level.bot_min_rank_for_item[var_1])) {
    var_3 = "mp\unlockTable.csv";
    var_4 = tablelookuprownum(var_3, 0, var_1);
    level.bot_min_rank_for_item[var_1] = int(tablelookupbyrow(var_3, var_4, 2));
  }

  if(var_0 == "classtable_any" && var_2 == "recruit")
    return 1;

  if(!isdefined(self.rank_for_items)) {
    self.rank_for_items = self.pers["rank"];

    if(!isdefined(self.rank_for_items))
      self.rank_for_items = level.bot_rnd_rank[var_2][0];
  }

  if(level.bot_min_rank_for_item[var_1] <= self.rank_for_items)
    return 1;

  return 0;
}

bot_loadout_valid_choice(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  switch (var_2) {
    case "loadoutPrimary":
      var_4 = bot_loadout_item_allowed("weapon", var_3, undefined);
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidprimary(var_3);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutEquipment":
      var_4 = bot_loadout_item_allowed("perk", var_3, "Lethal");
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidequipment(var_3);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutOffhand":
      var_4 = bot_validate_offhand(var_3, var_2, var_1);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutPrimaryAttachKit":
      var_4 = bot_validate_attachkit_for_weapon(var_3, var_1["loadoutPrimary"], self botgetdifficulty());
      break;
    case "loadoutPrimaryFurnitureKit":
      var_4 = 1;
      break;
    case "loadoutPrimaryReticle":
      var_4 = 1;
      break;
    case "loadoutPrimaryCamo":
      var_4 = !isdefined(self.botloadoutfavoritecamoprimary) || var_3 == self.botloadoutfavoritecamoprimary;
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo(var_3);
      break;
    case "loadoutSecondary":
      var_4 = var_3 != var_1["loadoutPrimary"];
      var_4 = var_4 && bot_loadout_item_allowed("weapon", var_3, undefined);
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidsecondary(var_3, var_1["loadoutPerk2"] == "specialty_twoprimaries");
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
      break;
    case "loadoutSecondaryAttachKit":
      var_4 = bot_validate_attachkit_for_weapon(var_3, var_1["loadoutSecondary"], self botgetdifficulty());
      break;
    case "loadoutSecondaryFurnitureKit":
      var_4 = 1;
      break;
    case "loadoutSecondaryReticle":
      var_4 = 1;
      break;
    case "loadoutSecondaryCamo":
      var_4 = !isdefined(self.botloadoutfavoritecamosecondary) || var_3 == self.botloadoutfavoritecamosecondary;
      var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo(var_3);
      break;
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_4 = bot_validate_perk(var_3, var_2, var_1);
      var_4 = var_4 && bot_loadout_item_valid_for_rank(var_0, var_3, self botgetdifficulty());
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

  if(common_scripts\utility::array_contains(var_0, "specialty_null"))
    var_5 = "specialty_null";
  else if(var_3 == "loadoutEquipment" || var_3 == "loadoutOffhand" || issubstr(var_3, "Perk"))
    var_5 = "specialty_null";

  if(var_1 == "classtable_any") {
    if(!isdefined(self.default_class_chosen))
      self.default_class_chosen = common_scripts\utility::random(["class1", "class2", "class3", "class4", "class5", "class6"]);

    var_0 = [self.default_class_chosen];
  }

  foreach(var_9 in var_0) {
    var_10 = undefined;

    if(getsubstr(var_9, 0, 9) == "template_") {
      var_10 = var_9;
      var_11 = level.botloadouttemplates[var_9][var_3];
      var_9 = bot_loadout_choose_from_set(strtok(var_11, "| "), var_1, var_2, var_3, 1);

      if(isdefined(var_10) && isdefined(self.chosentemplates[var_10]))
        return var_9;
    }

    if(var_9 == "attachkittable")
      return bot_loadout_choose_from_attachkittable(var_1, var_2, var_3, self.personality, self.difficulty);

    if(var_9 == "weap_statstable")
      return bot_loadout_choose_from_statstable(var_1, var_2, var_3, self.personality, self.difficulty);

    if(var_9 == "camotable")
      return bot_loadout_choose_from_camotable(var_1, var_2, var_3, self.personality, self.difficulty);

    if(getsubstr(var_9, 0, 5) == "class" && int(getsubstr(var_9, 5, 6)) > 0)
      var_9 = bot_loadout_choose_from_default_class(var_9, var_3);

    if(bot_loadout_valid_choice(var_1, var_2, var_3, var_9)) {
      var_7 = var_7 + 1.0;

      if(randomfloat(1.0) <= 1.0 / var_7) {
        var_5 = var_9;
        var_6 = var_10;
      }
    }
  }

  if(isdefined(var_6))
    self.chosentemplates[var_6] = 1;

  return var_5;
}

bot_loadout_choose_values(var_0) {
  self.chosentemplates = [];

  foreach(var_6, var_2 in var_0) {
    var_3 = undefined;

    if(!isdefined(var_3)) {
      var_5 = strtok(var_2, "| ");
      var_3 = bot_loadout_choose_from_set(var_5, var_2, var_0, var_6);
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
  if(isdefined(self.pers["botCustomClasses"]))
    return self.pers["botCustomClasses"];

  return [];
}

bot_get_stored_launcher_class() {
  if(bot_get_stored_custom_classes().size > 0) {
    if(isdefined(self.pers["botLauncherClassIndex"])) {
      var_0 = self.pers["botLauncherClassIndex"];
      return self.pers["botCustomClasses"][var_0];
    }
  }

  return undefined;
}

bot_allowed_to_try_last_loadout() {
  if(maps\mp\_utility::is_true(self.bot_pick_new_loadout_next_spawn))
    return 0;
  else if(!isdefined(self.pers["botLastLoadout"]))
    return 0;
  else if(maps\mp\_utility::is_true(self.respawn_with_launcher))
    return 0;
  else if(isdefined(self.hasdied) && !self.hasdied)
    return 0;

  return 1;
}

bot_loadout_class_callback(var_0) {
  while (!isdefined(level.bot_loadouts_initialized))
    wait 0.05;

  while (!isdefined(self.personality))
    wait 0.05;

  var_1 = [];
  var_2 = bot_loadout_get_difficulty();
  self.difficulty = var_2;
  var_3 = self botgetpersonality();

  if(!isdefined(self.bot_last_loadout_num))
    self.bot_cur_loadout_num = 0;

  self.bot_last_loadout_num = self.bot_cur_loadout_num;

  if(isdefined(self.pers["botLastLoadout"]) && maps\mp\_utility::is_true(var_0))
    return self.pers["botLastLoadout"];

  var_4 = !isdefined(self.pers["botLastLoadoutDifficulty"]) || self.pers["botLastLoadoutDifficulty"] == var_2;
  var_5 = !isdefined(self.pers["botLastLoadoutPersonality"]) || self.pers["botLastLoadoutPersonality"] == var_3;
  var_6 = 0;

  if(!var_4 || !var_5) {
    self.pers["botLastLoadout"] = undefined;
    self.pers["botCustomClasses"] = undefined;
    self.pers["botLauncherClassIndex"] = undefined;
    var_6 = 1;
  }

  var_7 = !var_6 && bot_allowed_to_try_last_loadout();

  if(var_7) {
    var_8 = randomfloat(1.0) > 0.1;

    if(var_8)
      return self.pers["botLastLoadout"];
  }

  self.bot_pick_new_loadout_next_spawn = undefined;

  if(!var_6) {
    var_9 = bot_get_stored_launcher_class();
    var_10 = undefined;

    if(isdefined(self.respawn_with_launcher) && isdefined(var_9)) {
      self.respawn_with_launcher = undefined;
      self.bot_pick_new_loadout_next_spawn = 1;
      var_10 = var_9;
    }

    if(!isdefined(var_10)) {
      var_11 = bot_get_stored_custom_classes();
      var_12 = 0;

      if(isdefined(var_9)) {
        if(var_11.size < 5)
          var_12 = 1;
      } else if(isdefined(self.respawn_with_launcher))
        var_12 = 1;
      else if(var_11.size < 4)
        var_12 = 1;

      if(!var_12)
        var_10 = common_scripts\utility::random(var_11);
    }

    if(isdefined(var_10)) {
      self.bot_cur_loadout_num++;
      self.pers["botLastLoadout"] = var_10;
      return var_10;
    }
  }

  self.bot_loadout_can_pick_acog_for_sniper = randomfloat(1.0) < 0.5;

  if(var_3 == "cqb")
    self.bot_loadout_can_pick_silencer = randomfloat(1.0) < 0.5;
  else
    self.bot_loadout_can_pick_silencer = randomfloat(1.0) < 0.25;

  var_13 = undefined;
  var_14 = bot_custom_classes_allowed();

  if(var_14) {
    var_13 = bot_loadout_pick(var_3, var_2);
    var_1 = bot_loadout_choose_values(var_13);

    if(isdefined(level.bot_funcs["gametype_loadout_modify"]))
      var_1 = self[[level.bot_funcs["gametype_loadout_modify"]]](var_1);

    var_1 = bot_cross_validate_attachkit_and_perk(var_1, var_13);

    if(bot_match_rules_invalidate_loadout(var_1))
      var_14 = 0;
  }

  if(!var_14) {
    var_1 = bot_default_class_random();
    bot_pick_personality_from_weapon(var_1["loadoutPrimary"]);
  }

  var_1["loadoutMelee"] = "none";

  if(var_1["loadoutPrimary"] == "none") {
    self.bot_fallback_personality = undefined;
    var_1["loadoutPrimary"] = bot_loadout_choose_fallback_primary(var_1);
    var_1["loadoutPrimaryCamo"] = "none";
    var_1["loadoutPrimaryAttachKit"] = "none";
    var_1["loadoutPrimaryFurnitureKit"] = "none";
    var_1["loadoutPrimaryReticle"] = "none";

    if(isdefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon")
        bot_pick_personality_from_weapon(var_1["loadoutPrimary"]);
      else
        maps\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);

      var_3 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  var_18 = isdefined(self.respawn_with_launcher);

  if(var_14 && maps\mp\bots\_bots::bot_israndom()) {
    if(isdefined(var_1["loadoutPrimaryCamo"]) && var_1["loadoutPrimaryCamo"] != "none" && !isdefined(self.botloadoutfavoritecamoprimary))
      self.botloadoutfavoritecamoprimary = var_1["loadoutPrimaryCamo"];

    if(isdefined(var_1["loadoutSecondaryCamo"]) && var_1["loadoutSecondaryCamo"] != "none" && !isdefined(self.botloadoutfavoritecamosecondary))
      self.botloadoutfavoritecamosecondary = var_1["loadoutSecondaryCamo"];

    if(var_18) {
      var_19 = level.bot_respawn_launcher_name[self botgetdifficulty()];

      if(bot_loadout_item_allowed("perk", var_19, "Perk_Slot1")) {
        var_1["loadoutPerk1"] = var_19;
        var_1["loadoutPrimaryAttachKit"] = "none";
        var_1["loadoutPrimaryAttachKit"] = bot_pick_new_loadout_item(var_13["loadoutPrimaryAttachKit"], var_1, "loadoutPrimaryAttachKit", "loadoutPerk1");
        self.bot_pick_new_loadout_next_spawn = 1;
      }

      self.respawn_with_launcher = undefined;
    }

    if(var_1["loadoutPerk2"] == "specialty_explosivedamage") {
      if(randomfloat(1.0) < 0.5) {
        var_20 = common_scripts\utility::array_randomize(["loadoutPrimaryAttachKit", "loadoutPerk1"]);

        for (var_21 = 0; var_21 < var_20.size; var_21++) {
          if(bot_perk_is_explosive(var_1["loadoutPerk1"])) {
            continue;
          }
          if(var_1["loadoutPrimaryAttachKit"] == "gl") {
            continue;
          }
          if(var_20[var_21] == "loadoutPrimaryAttachKit") {
            var_1["loadoutPerk1"] = "specialty_null";
            var_22 = bot_loadout_choose_from_set(["gl"], "special_attachkit_choice", var_1, "loadoutPrimaryAttachKit");

            if(var_22 != "none")
              var_1["loadoutPrimaryAttachKit"] = var_22;
          } else if(var_20[var_21] == "loadoutPerk1") {
            var_1["loadoutPrimaryAttachKit"] = "none";
            var_23 = bot_perk_get_explosive_list();

            if(var_3 != "camper")
              var_23 = common_scripts\utility::array_remove(var_23, "c4_mp");

            var_24 = bot_loadout_choose_from_set(var_23, "special_perk_choice", var_1, "loadoutPerk1");

            if(var_24 != "specialty_null")
              var_1["loadoutPerk1"] = var_24;
          }

          var_25 = var_20[var_21];
          var_26 = var_20[(var_21 + 1) % 2];
          var_1[var_26] = bot_pick_new_loadout_item(var_13[var_26], var_1, var_26, var_25);
        }
      }
    }
  }

  self.bot_cur_loadout_num++;
  self.pers["botLastLoadout"] = var_1;
  self.pers["botLastLoadoutDifficulty"] = var_2;
  self.pers["botLastLoadoutPersonality"] = var_3;

  if(!isdefined(self.pers["botCustomClasses"]))
    self.pers["botCustomClasses"] = [];

  var_27 = self.pers["botCustomClasses"].size;
  self.pers["botCustomClasses"][var_27] = var_1;

  if(var_18)
    self.pers["botLauncherClassIndex"] = var_27;

  return var_1;
}

bot_match_rules_invalidate_loadout(var_0) {
  if(isusingmatchrulesdata()) {
    if(var_0["loadoutPrimary"] == "none")
      return 1;

    if(var_0["loadoutSecondary"] == "none")
      return 1;

    if(var_0["loadoutOffhand"] == "specialty_null")
      return 1;

    if(var_0["loadoutPerk1"] == "specialty_null") {
      if(!bot_attachkit_replaces_perk1(var_0["loadoutPrimaryAttachKit"]) && !bot_attachkit_replaces_perk1(var_0["loadoutSecondaryAttachKit"]))
        return 1;
    }

    if(var_0["loadoutPerk2"] == "specialty_null" || var_0["loadoutPerk3"] == "specialty_null")
      return 1;
  }

  return 0;
}

bot_setup_loadout_callback() {
  var_0 = self botgetpersonality();
  var_1 = bot_loadout_get_difficulty();
  var_2 = bot_loadout_set(var_0, var_1, 0);

  if(isdefined(var_2) && isdefined(var_2.loadouts) && var_2.loadouts.size > 0) {
    self.classcallback = ::bot_loadout_class_callback;
    return 1;
  }

  var_3 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return 0;
}

bot_modify_behavior_from_loadout() {
  foreach(var_2, var_1 in self.perks) {
    if(!var_1) {
      continue;
    }
    if(var_2 == "specialty_fraggrenade" || var_2 == "specialty_specialgrenade")
      self botsetflag("encourage_grenade_use", 1);

    if(var_2 == "specialty_explosivedamage") {
      self.encourage_explosive_use = 1;
      self botsetflag("encourage_explosive_use", 1);
    }
  }
}