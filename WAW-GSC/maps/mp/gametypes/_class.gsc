/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_class.gsc
****************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  level.classMap["assault_mp"] = "CLASS_ASSAULT";
  level.classMap["specops_mp"] = "CLASS_SPECOPS";
  level.classMap["heavygunner_mp"] = "CLASS_HEAVYGUNNER";
  level.classMap["demolitions_mp"] = "CLASS_DEMOLITIONS";
  level.classMap["sniper_mp"] = "CLASS_SNIPER";

  level.classMap["offline_class1_mp"] = "OFFLINE_CLASS1";
  level.classMap["offline_class2_mp"] = "OFFLINE_CLASS2";
  level.classMap["offline_class3_mp"] = "OFFLINE_CLASS3";
  level.classMap["offline_class4_mp"] = "OFFLINE_CLASS4";
  level.classMap["offline_class5_mp"] = "OFFLINE_CLASS5";
  level.classMap["offline_class6_mp"] = "OFFLINE_CLASS6";
  level.classMap["offline_class7_mp"] = "OFFLINE_CLASS7";
  level.classMap["offline_class8_mp"] = "OFFLINE_CLASS8";
  level.classMap["offline_class9_mp"] = "OFFLINE_CLASS9";
  level.classMap["offline_class10_mp"] = "OFFLINE_CLASS10";

  level.classMap["offline_class11_mp"] = "OFFLINE_CLASS11";

  level.classMap["custom1"] = "CLASS_CUSTOM1";
  level.classMap["custom2"] = "CLASS_CUSTOM2";
  level.classMap["custom3"] = "CLASS_CUSTOM3";
  level.classMap["custom4"] = "CLASS_CUSTOM4";
  level.classMap["custom5"] = "CLASS_CUSTOM5";

  level.classMap["prestige1"] = "CLASS_CUSTOM6";
  level.classMap["prestige2"] = "CLASS_CUSTOM7";
  level.classMap["prestige3"] = "CLASS_CUSTOM8";
  level.classMap["prestige4"] = "CLASS_CUSTOM9";
  level.classMap["prestige5"] = "CLASS_CUSTOM10";

  level.PrestigeNumber = 5;

  setShadesModels();

  precacheModel(level.alliesShadesModel);
  precacheModel(level.axisShadesModel);

  if(level.onlineGame) {
    level.defaultClass = "CLASS_ASSAULT";
  } else {
    level.defaultClass = "OFFLINE_CLASS1";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("weapon", "allowfrag")) {
    level.weapons["frag"] = "frag_grenade_mp";
  } else {
    level.weapons["frag"] = "";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("weapon", "allowsmoke")) {
    level.weapons["smoke"] = "smoke_grenade_mp";
  } else {
    level.weapons["smoke"] = "";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("weapon", "allowflash")) {
    level.weapons["flash"] = "flash_grenade_mp";
  } else {
    level.weapons["flash"] = "";
  }

  level.weapons["concussion"] = "concussion_grenade_mp";

  if(maps\mp\gametypes\_tweakables::getTweakableValue("weapon", "allowsatchel")) {
    level.weapons["satchel_charge"] = "satchel_charge_mp";
  } else {
    level.weapons["satchel_charge"] = "";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("weapon", "allowbetty")) {
    level.weapons["betty"] = "mine_bouncing_betty_mp";
  } else {
    level.weapons["betty"] = "";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("weapon", "allowrpgs")) {
    level.weapons["rpg"] = "bazooka_mp";
  } else {
    level.weapons["rpg"] = "";
  }

  cac_init();

  offline_class_datatable = "mp/offline_classTable.csv";

  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS1", 200);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS2", 210);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS3", 220);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS4", 230);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS5", 240);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS6", 250);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS7", 260);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS8", 270);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS9", 280);
  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS10", 290);

  load_default_loadout(offline_class_datatable, "both", "OFFLINE_CLASS11", 300);

  online_class_datatable = "mp/classTable.csv";

  load_default_loadout(online_class_datatable, "both", "CLASS_ASSAULT", 200);
  load_default_loadout(online_class_datatable, "both", "CLASS_SPECOPS", 210);
  load_default_loadout(online_class_datatable, "both", "CLASS_HEAVYGUNNER", 220);
  load_default_loadout(online_class_datatable, "both", "CLASS_DEMOLITIONS", 230);
  load_default_loadout(online_class_datatable, "both", "CLASS_SNIPER", 240);

  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.inventory_array = [];
  max_weapon_num = 149;
  for(i = 0; i < max_weapon_num; i++) {
    if(!isDefined(level.tbl_weaponIDs[i]) || level.tbl_weaponIDs[i]["group"] == "") {
      continue;
    }
    if(!isDefined(level.tbl_weaponIDs[i]) || level.tbl_weaponIDs[i]["reference"] == "") {
      continue;
    }

    weapon_type = level.tbl_weaponIDs[i]["group"];
    weapon = level.tbl_weaponIDs[i]["reference"];
    attachment = level.tbl_weaponIDs[i]["attachment"];

    weapon_class_register(weapon + "_mp", weapon_type);

    if(isDefined(attachment) && attachment != "") {
      attachment_tokens = strtok(attachment, " ");
      if(isDefined(attachment_tokens)) {
        if(attachment_tokens.size == 0) {
          weapon_class_register(weapon + "_" + attachment + "_mp", weapon_type);
        } else {
          {}

          for(k = 0; k < attachment_tokens.size; k++) {
            weapon_class_register(weapon + "_" + attachment_tokens[k] + "_mp", weapon_type);
          }
        }
      }
    }
  }

  precacheShader("waypoint_bombsquad");
  precacheShader("waypoint_second_chance");

  level thread onPlayerConnecting();
}

setShadesModels() {
  level.alliesShadesModel = "char_usa_raider_player_shades";

  if(game["axis"] == "japanese") {
    level.axisShadesModel = "char_jap_impinf_player_shades";
  } else {
    level.axisShadesModel = "char_ger_hnrgd_player_shades";
  }
}

load_default_loadout(datatable, team, class, stat_num) {
  if(team == "both") {
    load_default_loadout_raw(datatable, "allies", class, stat_num);
    load_default_loadout_raw(datatable, "axis", class, stat_num);
  } else {
    load_default_loadout_raw(datatable, team, class, stat_num);
  }
}

load_default_loadout_raw(class_dataTable, team, class, stat_num) {
  primary_attachment = tablelookup(class_dataTable, 1, stat_num + 2, 4);
  if(primary_attachment != "" && primary_attachment != "none") {
    level.classWeapons[team][class][0] = tablelookup(class_dataTable, 1, stat_num + 1, 4) + "_" + primary_attachment + "_mp";
  } else {
    level.classWeapons[team][class][0] = tablelookup(class_dataTable, 1, stat_num + 1, 4) + "_mp";
  }

  level.classWeapons[team][class][1] = tablelookup(class_dataTable, 1, stat_num + 1, 13) + "_mp";
  level.classWeapons[team][class][2] = tablelookup(class_dataTable, 1, stat_num + 1, 14) + "_mp";

  if(getDvarInt("scr_game_perks")) {
    secondary_attachment = tablelookup(class_dataTable, 1, stat_num + 4, 4);
    if(secondary_attachment != "" && secondary_attachment != "none") {
      level.classSidearm[team][class] = tablelookup(class_dataTable, 1, stat_num + 3, 4) + "_" + secondary_attachment + "_mp";
    } else {
      level.classSidearm[team][class] = tablelookup(class_dataTable, 1, stat_num + 3, 4) + "_mp";
    }
  } else {
    level.classSidearm[team][class] = "colt_mp";
  }
  level.classGrenades[class]["primary"]["type"] = tablelookup(class_dataTable, 1, stat_num, 4) + "_mp";
  level.classGrenades[class]["primary"]["count"] = int(tablelookup(class_dataTable, 1, stat_num, 6));
  level.classGrenades[class]["secondary"]["type"] = tablelookup(class_dataTable, 1, stat_num + 8, 4) + "_mp";
  level.classGrenades[class]["secondary"]["count"] = int(tablelookup(class_dataTable, 1, stat_num + 8, 6));

  level.default_perk[class] = [];
  if(getDvarInt("scr_game_perks")) {
    level.default_perk[class][0] = tablelookup(class_dataTable, 1, stat_num + 5, 4);
    level.default_perk[class][1] = tablelookup(class_dataTable, 1, stat_num + 6, 4);
    level.default_perk[class][2] = tablelookup(class_dataTable, 1, stat_num + 7, 4);
    level.default_perk[class][3] = tablelookup(class_dataTable, 1, stat_num + 105, 4);
  } else {
    level.default_perk[class][0] = "specialty_null";
    level.default_perk[class][1] = "specialty_null";
    level.default_perk[class][2] = "specialty_null";
    level.default_perk[class][3] = "specialty_null";

    level.classGrenades[class]["primary"]["count"] = 1;
    level.classGrenades[class]["secondary"]["count"] = 1;
  }

  inventory_ref = tablelookup(class_dataTable, 1, stat_num + 5, 4);
  if(isDefined(inventory_ref) && tablelookup("mp/statsTable.csv", 6, inventory_ref, 2) == "inventory" && getDvarInt("scr_game_perks")) {
    inventory_count = int(tablelookup("mp/statsTable.csv", 6, inventory_ref, 5));
    inventory_item_ref = tablelookup("mp/statsTable.csv", 6, inventory_ref, 4);
    assertex(isDefined(inventory_count) && inventory_count != 0 && isDefined(inventory_item_ref) && inventory_item_ref != "", "Inventory in statsTable.csv not specified correctly");

    level.classItem[team][class]["type"] = inventory_item_ref;
    level.classItem[team][class]["count"] = inventory_count;
  } else {
    level.classItem[team][class]["type"] = "";
    level.classItem[team][class]["count"] = 0;
  }
}

weapon_class_register(weapon, weapon_type) {
  if(isSubstr("weapon_smg weapon_assault weapon_projectile weapon_sniper weapon_shotgun weapon_lmg weapon_hmg", weapon_type)) {
    level.primary_weapon_array[weapon] = 1;
  } else if(weapon_type == "weapon_pistol") {
    level.side_arm_array[weapon] = 1;
  } else if(weapon_type == "weapon_grenade") {
    level.grenade_array[weapon] = 1;
  } else if(weapon_type == "weapon_explosive") {
    level.inventory_array[weapon] = 1;
  } else if(weapon_type == "weapon_rifle") {
    level.inventory_array[weapon] = 1;
  } else {
    assertex(false, "Weapon group info is missing from statsTable for: " + weapon_type);
  }
}
cac_init() {
  level.cac_size = 5;

  level.cac_numbering = 0;
  level.cac_cstat = 1;
  level.cac_cgroup = 2;
  level.cac_cname = 3;
  level.cac_creference = 4;
  level.cac_ccount = 5;
  level.cac_cimage = 6;
  level.cac_cdesc = 7;
  level.cac_cstring = 8;
  level.cac_cint = 9;
  level.cac_cunlock = 10;
  level.cac_cint2 = 11;

  level.tbl_CamoSkin = [];
  for(i = 0; i < 8; i++) {
    level.tbl_CamoSkin[i]["bitmask"] = int(tableLookup("mp/attachmentTable.csv", 11, i, 10));
  }

  for(i = 0; i < 13; i++) {
    level.tbl_WeaponAttachment[i]["reference"] = tableLookup("mp/attachmentTable.csv", 9, i, 4);
  }

  level.tbl_weaponIDs = [];
  for(i = 0; i < 150; i++) {
    reference_s = tableLookup("mp/statsTable.csv", 0, i, 4);
    if(reference_s != "") {
      level.tbl_weaponIDs[i]["reference"] = reference_s;
      level.tbl_weaponIDs[i]["group"] = tablelookup("mp/statstable.csv", 0, i, 2);
      level.tbl_weaponIDs[i]["count"] = int(tablelookup("mp/statstable.csv", 0, i, 5));
      level.tbl_weaponIDs[i]["attachment"] = tablelookup("mp/statstable.csv", 0, i, 8);
    } else {
      continue;
    }
  }

  perkReferenceToIndex = [];

  level.perkNames = [];
  level.perkIcons = [];
  level.PerkData = [];
  for(i = 150; i < 194; i++) {
    reference_s = tableLookup("mp/statsTable.csv", 0, i, 4);
    if(reference_s != "") {
      level.tbl_PerkData[i]["reference"] = reference_s;
      level.tbl_PerkData[i]["reference_full"] = tableLookup("mp/statsTable.csv", 0, i, 6);
      level.tbl_PerkData[i]["count"] = int(tableLookup("mp/statsTable.csv", 0, i, 5));
      level.tbl_PerkData[i]["group"] = tableLookup("mp/statsTable.csv", 0, i, 2);
      level.tbl_PerkData[i]["name"] = tableLookupIString("mp/statsTable.csv", 0, i, 3);
      precacheString(level.tbl_PerkData[i]["name"]);
      level.tbl_PerkData[i]["perk_num"] = tableLookup("mp/statsTable.csv", 0, i, 8);

      perkReferenceToIndex[level.tbl_PerkData[i]["reference_full"]] = i;

      level.perkNames[level.tbl_PerkData[i]["reference_full"]] = level.tbl_PerkData[i]["name"];
      level.perkIcons[level.tbl_PerkData[i]["reference_full"]] = level.tbl_PerkData[i]["reference_full"];
      precacheShader(level.perkIcons[level.tbl_PerkData[i]["reference_full"]]);
    } else {
      continue;
    }
  }

  level.allowedPerks[0] = [];
  level.allowedPerks[1] = [];
  level.allowedPerks[2] = [];
  level.allowedPerks[3] = [];

  level.allowedPerks[0][0] = 190;
  level.allowedPerks[0][1] = 191;
  level.allowedPerks[0][2] = 192;
  level.allowedPerks[0][3] = 193;
  level.allowedPerks[0][4] = perkReferenceToIndex["specialty_specialgrenade"];
  level.allowedPerks[0][5] = perkReferenceToIndex["specialty_weapon_bouncing_betty"];
  level.allowedPerks[0][6] = perkReferenceToIndex["specialty_fraggrenade"];
  level.allowedPerks[0][7] = perkReferenceToIndex["specialty_extraammo"];
  level.allowedPerks[0][8] = perkReferenceToIndex["specialty_detectexplosive"];
  level.allowedPerks[0][9] = perkReferenceToIndex["specialty_weapon_flamethrower"];
  level.allowedPerks[0][10] = perkReferenceToIndex["specialty_weapon_bazooka"];
  level.allowedPerks[0][11] = perkReferenceToIndex["specialty_weapon_satchel_charge"];

  level.allowedPerks[1][0] = 190;
  level.allowedPerks[1][1] = perkReferenceToIndex["specialty_bulletdamage"];
  level.allowedPerks[1][2] = perkReferenceToIndex["specialty_armorvest"];
  level.allowedPerks[1][3] = perkReferenceToIndex["specialty_fastreload"];
  level.allowedPerks[1][4] = perkReferenceToIndex["specialty_rof"];
  level.allowedPerks[1][5] = perkReferenceToIndex["specialty_twoprimaries"];
  level.allowedPerks[1][6] = perkReferenceToIndex["specialty_gpsjammer"];
  level.allowedPerks[1][7] = perkReferenceToIndex["specialty_explosivedamage"];
  level.allowedPerks[1][8] = perkReferenceToIndex["specialty_flakjacket"];
  level.allowedPerks[1][9] = perkReferenceToIndex["specialty_shades"];
  level.allowedPerks[1][10] = perkReferenceToIndex["specialty_gas_mask"];

  level.allowedPerks[2][0] = 190;
  level.allowedPerks[2][1] = perkReferenceToIndex["specialty_longersprint"];
  level.allowedPerks[2][2] = perkReferenceToIndex["specialty_bulletaccuracy"];
  level.allowedPerks[2][3] = perkReferenceToIndex["specialty_pistoldeath"];
  level.allowedPerks[2][4] = perkReferenceToIndex["specialty_grenadepulldeath"];
  level.allowedPerks[2][5] = perkReferenceToIndex["specialty_bulletpenetration"];
  level.allowedPerks[2][6] = perkReferenceToIndex["specialty_holdbreath"];
  level.allowedPerks[2][7] = perkReferenceToIndex["specialty_quieter"];
  level.allowedPerks[2][8] = perkReferenceToIndex["specialty_fireproof"];
  level.allowedPerks[2][9] = perkReferenceToIndex["specialty_reconnaissance"];
  level.allowedPerks[2][10] = perkReferenceToIndex["specialty_pin_back"];

  level.allowedPerks[3][0] = 190;
  level.allowedPerks[3][1] = perkReferenceToIndex["specialty_water_cooled"];
  level.allowedPerks[3][2] = perkReferenceToIndex["specialty_greased_barrings"];
  level.allowedPerks[3][3] = perkReferenceToIndex["specialty_ordinance"];
  level.allowedPerks[3][4] = perkReferenceToIndex["specialty_boost"];
  level.allowedPerks[3][5] = perkReferenceToIndex["specialty_leadfoot"];
}

getClassChoice(response) {
  tokens = strtok(response, ",");

  assert(isDefined(level.classMap[tokens[0]]));

  return (level.classMap[tokens[0]]);
}

getWeaponChoice(response) {
  tokens = strtok(response, ",");
  if(tokens.size > 1) {
    return int(tokens[1]);
  } else {
    return 0;
  }
}
cac_getdata(prestige) {
  if(isDefined(self.cac_initialized)) {
    return;
  }

  getCacDataGroup(200, 0, 5);

  if(prestige) {
    getCacDataGroup(1200, 5, 10);
  }
}

getCacDataGroup(statRange, cacRange, numClasses) {
  statMultiplier = 0;

  for(i = cacRange; i < numClasses; i++) {
    primary_grenade = self getstat(statRange + (statMultiplier * 10) + 0);
    primary_num = self getstat(statRange + (statMultiplier * 10) + 1);
    primary_attachment_flag = self getstat(statRange + (statMultiplier * 10) + 2);

    if(!isDefined(level.tbl_WeaponAttachment[primary_attachment_flag])) {
      primary_attachment_flag = 0;
    }
    primary_attachment_mask = level.tbl_WeaponAttachment[primary_attachment_flag]["bitmask"];
    if(getDvarInt("scr_game_perks")) {
      secondary_num = self getstat(statRange + (statMultiplier * 10) + 3);
      secondary_attachment_flag = self getstat(statRange + (statMultiplier * 10) + 4);
    } else {
      secondary_num = 0;
      secondary_attachment_flag = 0;
    }

    if(!isDefined(level.tbl_WeaponAttachment[secondary_attachment_flag])) {
      secondary_attachment_flag = 0;
    }
    secondary_attachment_mask = level.tbl_WeaponAttachment[secondary_attachment_flag]["bitmask"];
    specialty1 = self getstat(statRange + (statMultiplier * 10) + 5);
    specialty2 = self getstat(statRange + (statMultiplier * 10) + 6);
    specialty3 = self getstat(statRange + (statMultiplier * 10) + 7);
    specialty4 = self getstat(statRange + (statMultiplier * 10) + 105);
    special_grenade = self getstat(statRange + (statMultiplier * 10) + 8);
    camo_num = self getstat(statRange + (statMultiplier * 10) + 9);

    if(camo_num < 0 || camo_num >= level.tbl_CamoSkin.size) {
      iprintln("^1Warning: (" + self.name + ") camo " + camo_num + " is invalid. Setting to none.");
      camo_num = 0;
    }

    camo_mask = level.tbl_CamoSkin[camo_num]["bitmask"];

    if(primary_grenade < 100) {
      println("^1Warning: (" + self.name + ") primary grenade " + primary_grenade + " is invalid. Setting to frag.");
      primary_grenade = 100;
    }

    self.custom_class[i]["primary_grenades"] = level.tbl_weaponIDs[primary_grenade]["reference"] + "_mp";
    self.custom_class[i]["primary_grenades_count"] = 1;

    svt40WeaponIndex = 20;
    assert(level.tbl_weaponIDs[svt40WeaponIndex]["reference"] == "svt40");

    if(primary_num < 0 || !isDefined(level.tbl_weaponIDs[primary_num])) {
      primary_num = svt40WeaponIndex;
      primary_attachment_flag = 0;
    }
    if(secondary_num < 0 || !isDefined(level.tbl_weaponIDs[secondary_num])) {
      secondary_num = 0;
      secondary_attachment_flag = 0;
    }

    specialty1 = validatePerk(specialty1, 0);
    specialty2 = validatePerk(specialty2, 1);
    specialty3 = validatePerk(specialty3, 2);
    specialty4 = validatePerk(specialty4, 3);

    if(level.tbl_PerkData[specialty2]["reference_full"] != "specialty_twoprimaries") {
      if(level.tbl_weaponIDs[secondary_num]["group"] != "weapon_pistol") {
        iprintln("^1Warning: (" + self.name + ") secondary weapon is not a pistol but perk 2 is not Overkill. Setting secondary weapon to pistol.");
        secondary_num = 0;
        secondary_attachment_flag = 0;
      }
    }

    primary_ref = level.tbl_WeaponIDs[primary_num]["reference"];
    primary_attachment_set = level.tbl_weaponIDs[primary_num]["attachment"];
    primary_attachment_ref = tableLookup("mp/statsTable.csv", 4, primary_ref, primary_attachment_flag + 11);

    secondary_ref = level.tbl_WeaponIDs[secondary_num]["reference"];
    secondary_attachment_set = level.tbl_weaponIDs[secondary_num]["attachment"];
    secondary_attachment_ref = tableLookup("mp/statsTable.csv", 4, secondary_ref, secondary_attachment_flag + 11);

    if(primary_attachment_ref == "grip" || primary_attachment_ref == "gl" || secondary_attachment_ref == "grip" || secondary_attachment_ref == "gl") {
      if(specialty1 != 190 && specialty1 != 191 && specialty1 != 192 && specialty1 != 193) {
        specialty1 = 193;
      }
    }

    if(!issubstr(primary_attachment_set, primary_attachment_ref)) {
      if(primary_attachment_ref != "none") {
        iprintln("^1Warning: (" + self.name + ") attachment [" + primary_attachment_ref + "] is not valid for [" + primary_ref + "]. Removing attachment.");
      }

      primary_attachment_flag = 0;
    }
    if(!issubstr(secondary_attachment_set, secondary_attachment_ref)) {
      if(secondary_attachment_ref != "none") {
        iprintln("^1Warning: (" + self.name + ") attachment [" + secondary_attachment_ref + "] is not valid for [" + secondary_ref + "]. Removing attachment.");
      }

      secondary_attachment_flag = 0;
    }

    molotovGrenadeIndex = 101;
    assert(level.tbl_weaponIDs[molotovGrenadeIndex]["reference"] == "molotov");
    if(!isDefined(level.tbl_weaponIDs[special_grenade])) {
      special_grenade = molotovGrenadeIndex;
    }
    specialGrenadeType = level.tbl_weaponIDs[special_grenade]["reference"];
    if(specialGrenadeType != "molotov" && specialGrenadeType != "m8_white_smoke" && specialGrenadeType != "tabun_gas" && specialGrenadeType != "signal_flare") {
      iprintln("^1Warning: (" + self.name + ") special grenade " + special_grenade + " is invalid. Setting togrenade.");
      special_grenade = molotovGrenadeIndex;
    }

    if(specialGrenadeType == "smoke_grenade" && level.tbl_PerkData[specialty1]["reference_full"] == "specialty_specialgrenade") {
      iprintln("^1Warning: (" + self.name + ") smoke grenade may not be used with extra special grenades. Setting to molotov grenade.");
      special_grenade = molotovGrenadeIndex;
    }

    if(primary_attachment_flag != 0 && primary_attachment_ref != "") {
      self.custom_class[i]["primary"] = level.tbl_weaponIDs[primary_num]["reference"] + "_" + primary_attachment_ref + "_mp";
    } else {
      self.custom_class[i]["primary"] = level.tbl_weaponIDs[primary_num]["reference"] + "_mp";
    }

    if(secondary_attachment_flag != 0 && secondary_attachment_ref != "") {
      self.custom_class[i]["secondary"] = level.tbl_weaponIDs[secondary_num]["reference"] + "_" + secondary_attachment_ref + "_mp";
    } else {
      self.custom_class[i]["secondary"] = level.tbl_weaponIDs[secondary_num]["reference"] + "_mp";
    }

    assertex(isDefined(level.tbl_PerkData[specialty1]), "Specialty #:" + specialty1 + "'s data is undefined");
    self.custom_class[i]["specialty1"] = level.tbl_PerkData[specialty1]["reference_full"];
    self.custom_class[i]["specialty1_weaponref"] = level.tbl_PerkData[specialty1]["reference"];
    self.custom_class[i]["specialty1_count"] = level.tbl_PerkData[specialty1]["count"];
    self.custom_class[i]["specialty1_group"] = level.tbl_PerkData[specialty1]["group"];

    self.custom_class[i]["specialty2"] = level.tbl_PerkData[specialty2]["reference"];
    self.custom_class[i]["specialty2_weaponref"] = self.custom_class[i]["specialty2"];
    self.custom_class[i]["specialty2_count"] = level.tbl_PerkData[specialty2]["count"];
    self.custom_class[i]["specialty2_group"] = level.tbl_PerkData[specialty2]["group"];

    self.custom_class[i]["specialty3"] = level.tbl_PerkData[specialty3]["reference"];
    self.custom_class[i]["specialty3_weaponref"] = self.custom_class[i]["specialty3"];
    self.custom_class[i]["specialty3_count"] = level.tbl_PerkData[specialty3]["count"];
    self.custom_class[i]["specialty3_group"] = level.tbl_PerkData[specialty3]["group"];

    self.custom_class[i]["specialty4"] = level.tbl_PerkData[specialty4]["reference"];
    self.custom_class[i]["specialty4_weaponref"] = self.custom_class[i]["specialty4"];
    self.custom_class[i]["specialty4_count"] = level.tbl_PerkData[specialty4]["count"];
    self.custom_class[i]["specialty4_group"] = level.tbl_PerkData[specialty4]["group"];

    self.custom_class[i]["special_grenade"] = level.tbl_weaponIDs[special_grenade]["reference"] + "_mp";
    self.custom_class[i]["special_grenade_count"] = level.tbl_weaponIDs[special_grenade]["count"];

    self.custom_class[i]["camo_num"] = camo_num;
    self.cac_initialized = true;

    statMultiplier++;
  }
}

validatePerk(perkIndex, perkSlotIndex) {
  for(i = 0; i < level.allowedPerks[perkSlotIndex].size; i++) {
    if(perkIndex == level.allowedPerks[perkSlotIndex][i]) {
      return perkIndex;
    }
  }
  return 190;
}

logClassChoice(class, primaryWeapon, specialType, perks) {
  if(class == self.lastClass) {
    return;
  }

  self logstring("choseclass: " + class + " weapon: " + primaryWeapon + " special: " + specialType);
  for(i = 0; i < perks.size; i++) {
    self logstring("perk" + i + ": " + perks[i]);
  }

  self.lastClass = class;
}
get_specialtydata(class_num, specialty) {
  cac_reference = self.custom_class[class_num][specialty];
  cac_weaponref = self.custom_class[class_num][specialty + "_weaponref"];
  cac_group = self.custom_class[class_num][specialty + "_group"];
  cac_count = self.custom_class[class_num][specialty + "_count"];

  assertex(isDefined(cac_group), "Missing " + specialty + "'s group name");

  if(specialty == "specialty1") {
    if(isSubstr(cac_group, "grenade")) {
      if(cac_reference == "specialty_fraggrenade" && getDvarInt("scr_game_perks")) {
        self.custom_class[class_num]["grenades"] = self.custom_class[class_num]["primary_grenades"];
        self.custom_class[class_num]["grenades_count"] = cac_count;
      } else {
        self.custom_class[class_num]["grenades"] = self.custom_class[class_num]["primary_grenades"];
        self.custom_class[class_num]["grenades_count"] = 1;
      }

      assertex(isDefined(self.custom_class[class_num]["special_grenade"]) && isDefined(self.custom_class[class_num]["special_grenade_count"]), "Special grenade missing from custom class loadout");
      if(cac_reference == "specialty_specialgrenade" && getDvarInt("scr_game_perks")) {
        self.custom_class[class_num]["specialgrenades"] = self.custom_class[class_num]["special_grenade"];
        self.custom_class[class_num]["specialgrenades_count"] = cac_count;
      } else {
        self.custom_class[class_num]["specialgrenades"] = self.custom_class[class_num]["special_grenade"];
        self.custom_class[class_num]["specialgrenades_count"] = 1;
      }
      return;
    } else {
      assertex(isDefined(self.custom_class[class_num]["special_grenade"]), "Special grenade missing from custom class loadout");
      self.custom_class[class_num]["grenades"] = self.custom_class[class_num]["primary_grenades"];
      self.custom_class[class_num]["grenades_count"] = 1;
      self.custom_class[class_num]["specialgrenades"] = self.custom_class[class_num]["special_grenade"];
      self.custom_class[class_num]["specialgrenades_count"] = 1;
    }
  }

  if(cac_group == "inventory") {
    if(getDvarInt("scr_game_perks")) {
      assertex(isDefined(cac_count) && isDefined(cac_weaponref), "Missing " + specialty + "'s reference or count data");
      self.custom_class[class_num]["inventory"] = cac_weaponref;
      self.custom_class[class_num]["inventory_count"] = cac_count;
    } else {
      self.custom_class[class_num]["inventory"] = "";
      self.custom_class[class_num]["inventory_count"] = 0;
    }
  } else if(cac_group == "specialty") {
    if(self.custom_class[class_num][specialty] != "") {
      self.specialty[self.specialty.size] = self.custom_class[class_num][specialty];
    }
  }
}

reset_specialty_slots(class_num) {
  self.specialty = [];
  self.custom_class[class_num]["inventory"] = "";
  self.custom_class[class_num]["inventory_count"] = 0;
  self.custom_class[class_num]["inventory_group"] = "";
  self.custom_class[class_num]["grenades"] = "";
  self.custom_class[class_num]["grenades_count"] = 0;
  self.custom_class[class_num]["grenades_group"] = "";
  self.custom_class[class_num]["specialgrenades"] = "";
  self.custom_class[class_num]["specialgrenades_count"] = 0;
  self.custom_class[class_num]["specialgrenades_group"] = "";
}

giveLoadout(team, class) {
  self takeAllWeapons();

  primaryIndex = 0;

  self.specialty = [];

  primaryWeapon = undefined;

  self notify("give_map");

  if(isSubstr(class, "CLASS_CUSTOM") || isSubstr(class, "CLASS_PRESTIGE")) {
    self cac_getdata(self getstat(2326));

    class_num = int(class [class.size - 1]) - 1;

    if(-1 == class_num) {
      class_num = 9;
    }

    self.class_num = class_num;

    assertex(isDefined(self.custom_class[class_num]["primary"]), "Custom class " + class_num + ": primary weapon setting missing");
    assertex(isDefined(self.custom_class[class_num]["secondary"]), "Custom class " + class_num + ": secondary weapon setting missing");
    assertex(isDefined(self.custom_class[class_num]["specialty1"]), "Custom class " + class_num + ": specialty1 setting missing");
    assertex(isDefined(self.custom_class[class_num]["specialty2"]), "Custom class " + class_num + ": specialty2 setting missing");
    assertex(isDefined(self.custom_class[class_num]["specialty3"]), "Custom class " + class_num + ": specialty3 setting missing");
    assertex(isDefined(self.custom_class[class_num]["specialty4"]), "Custom class " + class_num + ": specialty4 setting missing");

    self reset_specialty_slots(class_num);
    self get_specialtydata(class_num, "specialty1");
    self get_specialtydata(class_num, "specialty2");
    self get_specialtydata(class_num, "specialty3");
    self get_specialtydata(class_num, "specialty4");

    self register_perks();

    if(isDefined(self.pers["weapon"]) && self.pers["weapon"] != "none") {
      weapon = self.pers["weapon"];
    } else {
      weapon = self.custom_class[class_num]["primary"];
    }

    sidearm = self.custom_class[class_num]["secondary"];

    self GiveWeapon(sidearm);
    if(self cac_hasSpecialty("specialty_extraammo")) {
      self giveMaxAmmo(sidearm);
    }

    primaryWeapon = weapon;

    assertex(isDefined(self.custom_class[class_num]["camo_num"]), "Player's camo skin is not defined, it should be at least initialized to 0");

    primaryTokens = strtok(primaryWeapon, "_");
    self.pers["primaryWeapon"] = primaryTokens[0];

    self GiveWeapon(weapon, self.custom_class[class_num]["camo_num"]);
    if(self cac_hasSpecialty("specialty_extraammo")) {
      self giveMaxAmmo(weapon);
    }
    self setSpawnWeapon(weapon);

    secondaryWeapon = self.custom_class[class_num]["inventory"];
    if(secondaryWeapon != "") {
      self GiveWeapon(secondaryWeapon);

      self setWeaponAmmoOverall(secondaryWeapon, self.custom_class[class_num]["inventory_count"]);

      self SetActionSlot(3, "weapon", secondaryWeapon);
      self SetActionSlot(4, "");
    } else {
      self SetActionSlot(3, "altMode");
      self SetActionSlot(4, "");
    }

    grenadeTypePrimary = self.custom_class[class_num]["grenades"];
    if(grenadeTypePrimary != "") {
      grenadeCount = self.custom_class[class_num]["grenades_count"];

      self GiveWeapon(grenadeTypePrimary);
      self SetWeaponAmmoClip(grenadeTypePrimary, grenadeCount);
      self SwitchToOffhand(grenadeTypePrimary);
    }

    grenadeTypeSecondary = self.custom_class[class_num]["specialgrenades"];
    if(grenadeTypeSecondary != "") {
      grenadeCount = self.custom_class[class_num]["specialgrenades_count"];

      if(grenadeTypeSecondary == level.weapons["flash"]) {
        self setOffhandSecondaryClass("flash");
      } else {
        self setOffhandSecondaryClass("smoke");
      }

      self giveWeapon(grenadeTypeSecondary);
      self SetWeaponAmmoClip(grenadeTypeSecondary, grenadeCount);
    }

    self maps\mp\gametypes\_teams::playerModelForWeapon(self.pers["primaryWeapon"]);

    self thread logClassChoice(class, primaryWeapon, grenadeTypeSecondary, self.specialty);
  } else {
    assertex(isDefined(self.pers["class"]), "Player during spawn and loadout got no class!");
    selected_class = self.pers["class"];
    specialty_size = level.default_perk[selected_class].size;

    for(i = 0; i < specialty_size; i++) {
      if(isDefined(level.default_perk[selected_class][i]) && level.default_perk[selected_class][i] != "") {
        self.specialty[self.specialty.size] = level.default_perk[selected_class][i];
      }
    }
    assertex(isDefined(self.specialty) && self.specialty.size > 0, "Default class: " + self.pers["class"] + " is missing specialties ");

    self register_perks();

    if(isDefined(self.pers["primary"])) {
      primaryIndex = self.pers["primary"];
    }

    if(isDefined(self.pers["weapon"]) && self.pers["weapon"] != "none") {
      weapon = self.pers["weapon"];
    } else {
      weapon = level.classWeapons[team][class][primaryIndex];
    }

    sidearm = level.classSidearm[team][class];

    println("^5GiveWeapon( " + sidearm + " ) -- sidearm");
    self GiveWeapon(sidearm);
    if(self cac_hasSpecialty("specialty_extraammo")) {
      self giveMaxAmmo(sidearm);
    }

    primaryWeapon = weapon;

    primaryTokens = strtok(primaryWeapon, "_");
    self.pers["primaryWeapon"] = primaryTokens[0];

    if(self.pers["primaryWeapon"] == "m14") {
      self.pers["primaryWeapon"] = "m21";
    }

    println("^5GiveWeapon( " + weapon + " ) -- weapon");
    self GiveWeapon(weapon);
    if(self cac_hasSpecialty("specialty_extraammo")) {
      self giveMaxAmmo(weapon);
    }
    self setSpawnWeapon(weapon);

    secondaryWeapon = level.classItem[team][class]["type"];
    if(secondaryWeapon != "") {
      println("^5GiveWeapon( " + secondaryWeapon + " ) -- secondaryWeapon");
      self GiveWeapon(secondaryWeapon);

      self setWeaponAmmoOverall(secondaryWeapon, level.classItem[team][class]["count"]);

      self SetActionSlot(3, "weapon", secondaryWeapon);
      self SetActionSlot(4, "");
    } else {
      self SetActionSlot(3, "altMode");
      self SetActionSlot(4, "");
    }

    grenadeTypePrimary = level.classGrenades[class]["primary"]["type"];
    if(grenadeTypePrimary != "") {
      grenadeCount = level.classGrenades[class]["primary"]["count"];

      println("^5GiveWeapon( " + grenadeTypePrimary + " ) -- grenadeTypePrimary");
      self GiveWeapon(grenadeTypePrimary);
      self SetWeaponAmmoClip(grenadeTypePrimary, grenadeCount);
      self SwitchToOffhand(grenadeTypePrimary);
    }

    grenadeTypeSecondary = level.classGrenades[class]["secondary"]["type"];
    if(grenadeTypeSecondary != "") {
      grenadeCount = level.classGrenades[class]["secondary"]["count"];

      if(grenadeTypeSecondary == level.weapons["flash"]) {
        self setOffhandSecondaryClass("flash");
      } else {
        self setOffhandSecondaryClass("smoke");
      }

      println("^5GiveWeapon( " + grenadeTypeSecondary + " ) -- grneadeTypeSecondary");
      self giveWeapon(grenadeTypeSecondary);
      self SetWeaponAmmoClip(grenadeTypeSecondary, grenadeCount);
    }

    self maps\mp\gametypes\_teams::playerModelForWeapon(self.pers["primaryWeapon"]);

    self thread logClassChoice(class, primaryWeapon, grenadeTypeSecondary, self.specialty);
  }

  switch (weaponClass(primaryWeapon)) {
    case "rifle":
      self setMoveSpeedScale(0.95);
      break;
    case "pistol":
      self setMoveSpeedScale(1.0);
      break;
    case "mg":
      self setMoveSpeedScale(0.875);
      break;
    case "smg":
      self setMoveSpeedScale(1.0);
      break;
    case "spread":
      self setMoveSpeedScale(1.0);
      break;
    default:
      self setMoveSpeedScale(1.0);
      break;
  }

  self cac_selector();
}
setWeaponAmmoOverall(weaponname, amount) {
  if(isWeaponClipOnly(weaponname)) {
    self setWeaponAmmoClip(weaponname, amount);
  } else {
    self setWeaponAmmoClip(weaponname, amount);
    diff = amount - self getWeaponAmmoClip(weaponname);
    assert(diff >= 0);
    self setWeaponAmmoStock(weaponname, diff);
  }
}

replenishLoadout() {
  team = self.pers["team"];
  class = self.pers["class"];

  weaponsList = self GetWeaponsList();
  for(idx = 0; idx < weaponsList.size; idx++) {
    weapon = weaponsList[idx];

    self giveMaxAmmo(weapon);
    self SetWeaponAmmoClip(weapon, 9999);

    if(weapon == "mine_bouncing_betty_mp") {
      self setWeaponAmmoStock(weapon, 2);
    }
  }

  if(self getAmmoCount(level.classGrenades[class]["primary"]["type"]) < level.classGrenades[class]["primary"]["count"]) {
    self SetWeaponAmmoClip(level.classGrenades[class]["primary"]["type"], level.classGrenades[class]["primary"]["count"]);
  }

  if(self getAmmoCount(level.classGrenades[class]["secondary"]["type"]) < level.classGrenades[class]["secondary"]["count"]) {
    self SetWeaponAmmoClip(level.classGrenades[class]["secondary"]["type"], level.classGrenades[class]["secondary"]["count"]);
  }
}

onPlayerConnecting() {
  for(;;) {
    level waittill("connecting", player);

    if(!level.oldschool) {
      if(!isDefined(player.pers["class"])) {
        player.pers["class"] = "";
      }
      player.class = player.pers["class"];
      player.lastClass = "";
    }
    player.detectExplosives = false;
    player.bombSquadIcons = [];
    player.bombSquadIds = [];
    player.reviveIcons = [];
    player.reviveIds = [];
  }
}

fadeAway(waitDelay, fadeDelay) {
  wait waitDelay;

  self fadeOverTime(fadeDelay);
  self.alpha = 0;
}

setClass(newClass) {
  self.curClass = newClass;
}

initPerkDvars() {
  level.cac_bulletdamage_data = cac_get_dvar_int("perk_bulletDamage", "40");
  level.cac_fireproof_data = cac_get_dvar_int("perk_fireproof", "55");
  level.cac_armorvest_data = cac_get_dvar_int("perk_armorVest", "75");
  level.cac_explosivedamage_data = cac_get_dvar_int("perk_explosiveDamage", "25");
  level.cac_flakjacket_data = cac_get_dvar_int("perk_flakJacket", "75");
  level.cac_flakjacketmaxdamage_data = cac_get_dvar_int("perk_flakJacketMaxDamage", "75");
}
cac_selector() {
  perks = self.specialty;

  self.detectExplosives = false;
  for(i = 0; i < perks.size; i++) {
    perk = perks[i];

    if(perk == "specialty_detectexplosive") {
      self.detectExplosives = true;
    }
  }

  if(cac_hasSpecialty("specialty_shades")) {
    if(self.pers["team"] == "axis") {
      shadesModel = level.axisShadesModel;
    } else {
      shadesModel = level.alliesShadesModel;
    }
    self attach(shadesModel, "J_Head", true);
  }

  maps\mp\gametypes\_weapons::setupBombSquad();

  self.canreviveothers = false;
  if(cac_hasSpecialty("specialty_pistoldeath")) {
    self.canreviveothers = true;
    maps\mp\_laststand::setupRevive();
  }
}

register_perks() {
  perks = self.specialty;
  self clearPerks();
  for(i = 0; i < perks.size; i++) {
    perk = perks[i];

    if(perk == "specialty_null" || isSubStr(perk, "specialty_weapon_")) {
      continue;
    }

    if(!getDvarInt("scr_game_perks")) {
      continue;
    }

    self setPerk(perk);
  }

  maps\mp\gametypes\_dev::giveExtraPerks();
}
cac_get_dvar_int(dvar, def) {
  return int(cac_get_dvar(dvar, def));
}
cac_get_dvar(dvar, def) {
  if(getDvar(dvar) != "") {
    return getdvarfloat(dvar);
  } else {
    setDvar(dvar, def);
    return def;
  }
}
cac_hasSpecialty(perk_reference) {
  return_value = self hasPerk(perk_reference);
  return return_value;
}

cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, inflictor) {
  if(!isDefined(victim) || !isDefined(attacker) || !isPlayer(attacker)) {
    return damage;
  }
  if(!isDefined(damage) || !isDefined(meansofdeath) || !isDefined(weapon)) {
    return damage;
  }

  old_damage = damage;
  final_damage = damage;

  if(attacker cac_hasSpecialty("specialty_bulletdamage") && isPrimaryDamage(meansofdeath)) {
    final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;

    if(getdvarint("scr_perkdebug")) {
      println("Perk/> " + attacker.name + "'s bullet damage did extra damage to vehicle");
    }
  } else if(attacker cac_hasSpecialty("specialty_explosivedamage") && isPlayerExplosiveWeapon(weapon, meansofdeath)) {
    final_damage = damage * (100 + level.cac_explosivedamage_data) / 100;

    if(getdvarint("scr_perkdebug")) {
      println("Perk/> " + attacker.name + "'s explosive damage did extra damage to vehicle");
    }
  } else {
    final_damage = old_damage;
  }

  if(getdvarint("scr_perkdebug")) {
    println("Perk/> Damage Factor: " + final_damage / old_damage + " - Pre Damage: " + old_damage + " - Post Damage: " + final_damage);
  }

  return int(final_damage);
}
cac_modified_damage(victim, attacker, damage, meansofdeath, weapon, inflictor) {
  if(!isDefined(victim) || !isDefined(attacker) || !isPlayer(attacker) || !isPlayer(victim)) {
    return damage;
  }
  if(!isDefined(damage) || !isDefined(meansofdeath)) {
    return damage;
  }
  if(meansofdeath == "") {
    return damage;
  }

  old_damage = damage;
  final_damage = damage;

  if(attacker cac_hasSpecialty("specialty_bulletdamage") && isPrimaryDamage(meansofdeath)) {
    if(isDefined(victim) && isPlayer(victim) && victim cac_hasSpecialty("specialty_armorvest")) {
      final_damage = old_damage;

      if(getdvarint("scr_perkdebug")) {
        println("Perk/> " + victim.name + "'s armor countered " + attacker.name + "'s increased bullet damage");
      }
    } else {
      final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;

      if(getdvarint("scr_perkdebug")) {
        println("Perk/> " + attacker.name + "'s bullet damage did extra damage to " + victim.name);
      }
    }
  } else if(victim cac_hasSpecialty("specialty_fireproof") && isFireDamage(weapon, meansofdeath)) {
    level.cac_fireproof_data = cac_get_dvar_int("perk_fireproof", level.cac_fireproof_data);

    final_damage = damage * ((100 - level.cac_fireproof_data) / 100);

    if(getdvarint("scr_perkdebug")) {
      println("Perk/> " + attacker.name + "'s flames did less damage to " + victim.name);
    }
  } else if(attacker cac_hasSpecialty("specialty_explosivedamage") && isPlayerExplosiveWeapon(weapon, meansofdeath)) {
    if(isDefined(victim) && isPlayer(victim) && victim cac_hasSpecialty("specialty_flakjacket") && meansofdeath != "MOD_PROJECTILE" && !isDefined(inflictor.stucktoplayer)) {
      final_damage = old_damage;

      if(getdvarint("scr_perkdebug")) {
        println("Perk/> " + victim.name + "'s flakjacket countered " + attacker.name + "'s increased explosive damage");
      }
    } else {
      final_damage = damage * (100 + level.cac_explosivedamage_data) / 100;

      if(getdvarint("scr_perkdebug")) {
        println("Perk/> " + attacker.name + "'s explosive damage did extra damage to " + victim.name);
      }
    }
  } else {
    if(isDefined(victim) && isPlayer(victim) && isDefined(meansofdeath) && isPrimaryDamage(meansofdeath)) {
      if(victim cac_hasSpecialty("specialty_armorvest")) {
        final_damage = old_damage * (level.cac_armorvest_data / 100);

        if(getdvarint("scr_perkdebug")) {
          println("Perk/> " + victim.name + "'s armor decreased " + attacker.name + "'s damage");
        }
      }
    } else if(victim cac_hasSpecialty("specialty_flakjacket") && !isDefined(inflictor.stucktoplayer) && meansofdeath != "MOD_PROJECTILE" && weapon != "briefcase_bomb_mp") {
      if(isExplosiveDamage(meansofdeath) || isSubStr(weapon, "explodable_barrel") || isSubStr(weapon, "destructible_car")) {
        level.cac_flakjacket_data = cac_get_dvar_int("perk_flakJacket", level.cac_flakjacket_data);
        level.cac_flakjacketmaxdamage_data = cac_get_dvar_int("perk_flakJacketmaxdamage", level.cac_flakjacketmaxdamage_data);

        final_damage = int(old_damage * (level.cac_flakjacket_data / 100));
        if(final_damage > level.cac_flakjacketmaxdamage_data) {
          {}
          final_damage = level.cac_flakjacketmaxdamage_data;
        }
      }

      if(getdvarint("scr_perkdebug")) {
        println("Perk/> " + victim.name + "'s flak jacket decreased " + attacker.name + "'s grenade damage");
      }
    } else {
      final_damage = old_damage;
    }
  }

  if(getdvarint("scr_perkdebug")) {
    println("Perk/> Damage Factor: " + final_damage / old_damage + " - Pre Damage: " + old_damage + " - Post Damage: " + final_damage);
  }

  return int(final_damage);
}
isExplosiveDamage(meansofdeath) {
  explosivedamage = "MOD_GRENADE MOD_GRENADE_SPLASH MOD_PROJECTILE_SPLASH MOD_EXPLOSIVE";

  if(isSubstr(explosivedamage, meansofdeath)) {
    return true;
  }
  return false;
}
isPrimaryDamage(meansofdeath) {
  if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET") {
    return true;
  }
  return false;
}

isFireDamage(weapon, meansofdeath) {
  if((isSubStr(weapon, "flame") || isSubStr(weapon, "molotov_") || isSubStr(weapon, "napalmblob_")) && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH")) {
    return true;
  }
  return false;
}

isPlayerExplosiveWeapon(weapon, meansofdeath) {
  if(!isExplosiveDamage(meansofdeath)) {
    return false;
  }

  if(weapon == "artillery_mp") {
    return false;
  }

  if(issubstr(weapon, "turret")) {
    return false;
  }

  return true;
}