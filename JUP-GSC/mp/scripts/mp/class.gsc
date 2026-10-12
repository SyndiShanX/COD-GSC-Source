/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\class.gsc
***********************************************/

#using script_15eddb0fac236a22;
#using script_4a6760982b403bad;
#using script_55e418c5cc946593;
#using script_b7a9ce0a2282b79;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\accessories;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\archetypes\archcommon;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\class;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\flash_grenade;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\molotov;
#using scripts\mp\equipment\nvg;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\loot;
#using scripts\mp\menus;
#using scripts\mp\passives;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\perks\weaponpassives;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\riotshield;
#using scripts\mp\supers;
#using scripts\mp\supers\super_emp_pulse;
#using scripts\mp\teams;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\validation;
#using scripts\mp\weapons;
#namespace class;

function init() {
  level.classmap["gamemode"] = 0;
  level.classmap["callback"] = 0;
  level.classmap["juggernaut"] = 0;

  if(istrue(level.var_7ebad80a50484a39)) {
    level.classmap["superpower"] = 0;
  }

  for(i = 0; i <= 2; i++) {
    level.classmap["class" + i] = 0;
  }

  for(i = 1; i <= 12; i++) {
    level.classmap["custom" + i] = i - 1;
  }

  for(i = 1; i <= 6; i++) {
    level.classmap["axis_recipe" + i] = i - 1;
    level.classmap["allies_recipe" + i] = i - 1;
  }

  for(i = 1; i <= 11; i++) {
    level.classmap["default" + i] = i - 1;
  }

  level.defaultclass = "CLASS_ASSAULT";

  if(getdvarint(@ "mgl", 0) && (scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.gametype == "brtdm" || level.gametype == "brtdm_mgl")) {
    level.classtablename = "classtable:classtable_br_default_mgl";
  } else if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    level.classtablename = "classtable:classtable_dmz_default";
  } else if(getdvarint(@ "hash_72fe29aa713ea21e", 0) != 0) {
    loadoutoverride = getdvarint(@ "hash_72fe29aa713ea21e", 0);

    switch (loadoutoverride) {
      case 1:
        level.classtablename = "classtable:classtable_snipers_only";

        if(getprojectname() == "JUP") {
          level.classtablename += "_jup";
        }

        break;
      case 2:
        level.classtablename = "classtable:classtable_juggermosh";
        break;
      case 3:
        level.classtablename = "classtable:" + level.gamemodebundle.classtable;
        break;
      case 4:
        level.classtablename = "classtable:classtable_jup_no_equip";
        break;
      default:
        level.classtablename = "classtable:classtable";
        break;
    }

    setomnvar("ui_classtable_override", loadoutoverride);
  } else if(getdvarint(@ "hash_1e31d1da0a5b6558", 0)) {
    level.classtablename = "classtable:classtable_weapon_test";
  } else if(getdvarint(@ "hash_48b4d51ad390da4f", 0)) {
    level.classtablename = "classtable:classtable_gwplus";
  } else if(isanymlgmatch()) {
    level.classtablename = "classtable:classtable_cdl";
  } else if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.classtable)) {
    level.classtablename = "classtable:" + level.gametypebundle.classtable;
  } else if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.classtable)) {
    level.classtablename = "classtable:" + level.gamemodebundle.classtable;
  } else if(getdvarint(@ "scr_test_loadouts", 0)) {
    level.classtablename = "classtable:" + level.gamemodebundle.var_6452bbdfe7671a5d;
  }

  if(issharedfuncdefined("classtable", "getClassTableOverride")) {
    level.classtablename = [[getsharedfunc("classtable", "getClassTableOverride")]]();
  }

  level.var_a0b81643aba2ec27 = getdvarint(@ "scr_enable_classswap_postcombat", 0) == 1;
  assertex(isDefined(level.classtablename), "<dev string:x1c>");
  killstreakoverrides = getDvar(@ "killstreak_overrides", "");

  if(killstreakoverrides != "") {
    level.killstreakoverrides = strtok(killstreakoverrides, ",");
  }

  if(isusingmatchrulesdata()) {
    level.var_dd07587af7d0ec5e = getmatchrulesdata("commonOption", "backupPistol");
    level.var_6ff4dcd4533c4a93 = getmatchrulesdata("commonOption", "backupPistolReload");
  }

  level thread onplayerconnecting();
  level thread onplayerspawned();
}

function function_e83615f8a92e4378(rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg) {
  return buildweapon(rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg);
}

function getclasschoice(response) {
  assert(isDefined(level.classmap[response]));
  return response;
}

function getweaponchoice(response) {
  tokens = strtok(response, ",");

  if(tokens.size > 1) {
    return int(tokens[1]);
  }

  return 0;
}

function cac_getweapon(classindex, weaponindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weapon");
}

function cac_getweaponattachment(classindex, weaponindex, attachmentindex) {
  playerdatavalue = self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "attachment");
  weapon = cac_getweapon(classindex, weaponindex);
  return scripts\cp_mp\weapon::function_6e7bc1b23afa0ea8(weapon, playerdatavalue);
}

function cac_getweaponattachmentid(classindex, weaponindex, attachmentindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "variantID");
}

function function_a4065e820eb1f919(classindex, weaponindex, attachmentindex) {
  slider1 = self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "customTune", 0);
  slider2 = self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "customTune", 1);
  var_bf247e07a72958e = self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "hasBPTune");
  return function_a5d1432d54033ea9(slider1, slider2, var_bf247e07a72958e);
}

function function_a5d1432d54033ea9(slider1, slider2, var_bf247e07a72958e) {
  if(var_bf247e07a72958e == 1 && slider1 == 0 && slider2 == 0) {
    var_a3ddb63bdd450f67 = "clr";
    var_62365e59d2d3fabc = "clr";
  } else {
    var_a3ddb63bdd450f67 = function_f76ff66a6601d9c9(slider1);
    var_62365e59d2d3fabc = function_f76ff66a6601d9c9(slider2);
  }

  if(!isDefined(var_a3ddb63bdd450f67) || !isDefined(var_62365e59d2d3fabc)) {
    return undefined;
  }

  sliders = [var_a3ddb63bdd450f67, var_62365e59d2d3fabc];
  return sliders;
}

function cac_getweaponlootitemid(classindex, weaponindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID");
}

function cac_getweaponvariantid(classindex, weaponindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "variantID");
}

function cac_getweaponcamo(classindex, weaponindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "camo");
}

function cac_getweaponreticle(classindex, weaponindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "reticle");
}

function cac_getkillstreak(index, class) {
  cackillstreak = self getplayerdata(level.loadoutdata, "squadMembers", "killstreakSetups", index, "killstreak");
  var_8dfcebbe026021fc = getdvarint(@ "hash_c71c23fbd639d5d3", 0);

  if(var_8dfcebbe026021fc && scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
    switch (index) {
      case 0:
        cackillstreak = "uav";
        break;
      case 1:
        cackillstreak = "toma_strike";
        break;
      case 2:
        cackillstreak = "directional_uav";
        break;
      default:
        break;
    }
  }

  if(isDefined(level.var_c26d962ddc188b43) && level.gametype == "conf_v") {
    switch (index) {
      case 0:
        cackillstreak = "none";
        break;
      case 1:
        cackillstreak = "electric_discharge";
        break;
      case 2:
        cackillstreak = "laser_charge";
        break;
      case 3:
        cackillstreak = "none";
        break;
      default:
        break;
    }

    return cackillstreak;
  }

  if(istrue(level.var_44815c2275fee420)) {
    switch (index) {
      case 0:
        cackillstreak = getDvar(hashcat(@ "hash_7129c8b31055dff8", 1), "switchblade_drone");
        break;
      case 1:
        cackillstreak = getDvar(hashcat(@ "hash_7129c8b31055dff8", 2), "cruise_predator");
        break;
      case 2:
        cackillstreak = getDvar(hashcat(@ "hash_7129c8b31055dff8", 3), "fuel_airstrike");
        break;
      default:
        break;
    }

    return cackillstreak;
  }

  if(isDefined(level.killstreakoverrides) && (getdvarint(@ "t10", 0) > 0 || getdvarint(@ "hash_8b17e0ec412187d3", 0) > 0)) {
    overridekillstreak = level.killstreakoverrides[index];

    if(!isDefined(overridekillstreak)) {
      overridekillstreak = "";
    }

    return overridekillstreak;
  }

  return cackillstreak;
}

function function_3d362af202938e22(index, class) {
  var_8dfcebbe026021fc = getdvarint(@ "hash_c71c23fbd639d5d3", 0);

  if(var_8dfcebbe026021fc && scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
    return 0;
  }

  if(isDefined(level.killstreakoverrides) && (getdvarint(@ "t10", 0) > 0 || getdvarint(@ "hash_8b17e0ec412187d3", 0) > 0)) {
    return 0;
  }

  return self getplayerdata(level.loadoutdata, "squadMembers", "killstreakSetups", index, "blueprintIndex");
}

function cac_getcharacterarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.archetype;
  }

  return "archetype_assault";
}

function cac_getequipmentprimary(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "equipment");
}

function function_9c883cb23c614891(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "variantID");
}

function cac_getextraequipmentprimary(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "extraCharge");
}

function cac_getflcextraequipmentprimary(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "flcExtraEquipment");
}

function cac_getequipmentsecondary(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "equipment");
}

function function_d9e6d0a8cbe6b48d(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "variantID");
}

function cac_getextraequipmentsecondary(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "extraCharge");
}

function cac_getflcextraequipmentsecondary(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "flcExtraEquipment");
}

function cac_getfieldupgrade(classindex, superindex) {
  var_cafe84b3bb165c25 = getdvarint(@ "hash_6f667009cb37e9a0", 0);

  if(var_cafe84b3bb165c25 && scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
    return "super_ammo_drop";
  }

  if(istrue(level.var_4b56eabbc77bfd21)) {
    return "none";
  }

  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgradeSetups", superindex, "fieldUpgrade");
}

function function_a2a7f87d758bbfb8(classindex, superindex) {
  var_cafe84b3bb165c25 = getdvarint(@ "hash_6f667009cb37e9a0", 0);

  if(var_cafe84b3bb165c25 && scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
    return 0;
  }

  if(istrue(level.var_4b56eabbc77bfd21)) {
    return 0;
  }

  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgradeSetups", superindex, "blueprintIndex");
}

function function_db6f12d0d1006658(classindex, superindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgradeUses", superindex);
}

function cac_getgesture() {
  gestureid = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    archetypeindex = level.archetypeids[self.changedarchetypeinfo.archetype];
    gestureid = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", archetypeindex, "gesture");
  } else {
    gestureid = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");
  }

  return scripts\cp_mp\gestures::getgesturedata(gestureid);
}

function cac_getaccessoryweapon() {
  accessoryindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessoryweaponbyindex(accessoryindex);
}

function cac_getaccessorydata() {
  accessoryindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessorydatabyindex(accessoryindex);
}

function cac_getaccessorylogic() {
  accessoryindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessorylogicbyindex(accessoryindex);
}

function cac_getloadoutperk(classindex, perkindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "loadoutPerks", perkindex);
}

function function_12b59a6e11ff097f(packageindex) {
  packagelist = function_3bb637a8e8d0a7c8();
  packagecount = 6;

  if(isDefined(packagelist)) {
    if(getdvarint(@ "hash_b8e2aa1e6fa68b8d", 0)) {
      packagecount = packagelist.packages.size;
    } else {
      packagecount = packagelist.bundlesize;
    }
  }

  if(packageindex < packagecount) {
    return function_5d63ef3292dd14b9(packagelist.packages[packageindex].package);
  } else {
    packageindex -= packagecount;
  }

  perkarray = [];
  perkarray[0] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 0);
  perkarray[1] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 1);
  perkarray[2] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 2);
  perkarray[3] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 3);
  return perkarray;
}

function function_7e02bbbe3ca7ac36(perksarray) {
  return !isDefined(perksarray[0]) || perksarray[0] == "specialty_null";
}

function function_ab0d3a90ebca6e74(perksarray, package) {
  if(perksarray.size != package.size) {
    return false;
  }

  for(i = 0; i < perksarray.size; i++) {
    if(package[i] != perksarray[i]) {
      return false;
    }
  }

  return true;
}

function function_ed0c3acfdac0baed(perksarray) {
  if(function_7e02bbbe3ca7ac36(perksarray)) {
    return -1;
  }

  packagelist = function_3bb637a8e8d0a7c8();

  if(isDefined(packagelist)) {
    packagecount = packagelist.packages.size;

    for(i = 0; i < packagecount; i++) {
      var_5a1fb4f30c863254 = packagelist.packages[i].package;
      package = function_5d63ef3292dd14b9(var_5a1fb4f30c863254);

      if(function_ab0d3a90ebca6e74(perksarray, package)) {
        scriptable = namespace_708f627020de59d3::function_cf81579b65f85dcf(var_5a1fb4f30c863254);

        if(isDefined(scriptable)) {
          return i;
        }
      }
    }
  }

  return -2;
}

function function_3c33d2d97119a585(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equippedPerkPackageIndex");
}

function cac_getloadoutextraperk(classindex, perkindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "extraPerks", perkindex);
}

function function_e329ffc7ff0dcf96(classindex, perkindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "flcPerks", perkindex);
}

function cac_getloadoutarchetypeperk() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.trait;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePerk");
}

function function_3bb637a8e8d0a7c8() {
  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    bundlename = "perkpackagelist_mgl";
    var_162624fd9ac6a209 = 5;
  } else {
    bundlename = "perkpackagelist_iw9";
    var_162624fd9ac6a209 = 6;
  }

  if(istrue(level.leagueplaymatch)) {
    bundlename = "ranked_perkpackagelist_iw9";
    var_162624fd9ac6a209 = 3;
  } else if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
      bundlename = "br_perkpackagelist_mgl";
      var_162624fd9ac6a209 = 5;
    } else {
      bundlename = "perkpackagelist_wz";
      var_162624fd9ac6a209 = 14;
    }
  }

  packagesstruct = getscriptbundle("perkpackagelist:" + bundlename);
  packagesstruct.bundlesize = packagesstruct.packages.size;

  for(i = packagesstruct.packages.size - 1; i >= 0; i--) {
    if(!isDefined(packagesstruct.packages[i].package)) {
      packagesstruct.packages[i] = undefined;
    }
  }

  if(isDefined(var_162624fd9ac6a209) && packagesstruct.bundlesize != var_162624fd9ac6a209) {
    assertmsg("<dev string:x5e>");
    scripts\mp\utility\script::demoforcesre("<dev string:x5e>");
  }

  return packagesstruct;
}

function cac_getusingspecialist(classindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "usingSpecialist");
}

function cac_getweaponcosmeticattachment(classindex, weaponindex) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachment");
}

function cac_getweaponsticker(classindex, weaponindex, var_36d2abbdcbcb186c) {
  return self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "sticker", var_36d2abbdcbcb186c);
}

function recipe_getkillstreak(classteam, classindex, streakindex) {
  return getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "kilstreakSetups", streakindex, "killstreak");
}

function function_de324c78ecdc7acd(player) {
  return player getplayerdata(level.progressiongroup, "enableDefaultDMZLoadouts");
}

function function_cfa0343e808b7421(player, enabled) {
  player setplayerdata(level.progressiongroup, "enableDefaultDMZLoadouts", enabled);
}

function function_acad491093697c6c(tablename) {
  if(!isDefined(level.var_f64740277f13e29b) || level.var_f64740277f13e29b.id != tablename) {
    level.var_f64740277f13e29b = spawnStruct();
    level.var_f64740277f13e29b.id = tablename;
    level.var_f64740277f13e29b.classes = [];
    level.var_f64740277f13e29b.classtable = getscriptbundle(tablename);
    assert(isDefined(level.var_f64740277f13e29b.classtable));
  }

  return level.var_f64740277f13e29b;
}

function function_c7a0b640c398497(tablename, classindex) {
  var_f64740277f13e29b = function_acad491093697c6c(tablename);

  if(!isDefined(var_f64740277f13e29b.classes[classindex])) {
    classtableentry = var_f64740277f13e29b.classtable.classlist[classindex];
    assert(isDefined(classtableentry));
    var_f64740277f13e29b.classes[classindex] = getscriptbundle("classtableentry:" + classtableentry.entry);
  }

  return var_f64740277f13e29b.classes[classindex];
}

function function_df2933f96d726d71(tablename) {
  var_f64740277f13e29b = function_acad491093697c6c(tablename);
  return var_f64740277f13e29b.classtable.classlist.size;
}

function table_getaddblueprintattachments(tablename, classindex, weaponindex) {
  return function_aacbcd2576b3af83(tablename, classindex, weaponindex).addblueprintattachments;
}

function function_aacbcd2576b3af83(tablename, classindex, weaponindex) {
  weaponinfo = function_c7a0b640c398497(tablename, classindex);

  switch (weaponindex) {
    case 0:
      return weaponinfo.primaryweapon;
    case 1:
      return weaponinfo.secondaryweapon;
  }

  return weaponinfo.tertiaryweapon;
}

function table_getweapon(tablename, classindex, weaponindex) {
  return function_aacbcd2576b3af83(tablename, classindex, weaponindex).weapon;
}

function table_getweaponattachment(tablename, classindex, weaponindex, attachmentindex) {
  tempname = "none";
  classstruct = function_c7a0b640c398497(tablename, classindex);

  if(!isDefined(classstruct.primaryweapon.attachments)) {
    classstruct.primaryweapon.attachments = [classstruct.primaryweapon.attachment1, classstruct.primaryweapon.attachment2, classstruct.primaryweapon.attachment3, classstruct.primaryweapon.attachment4, classstruct.primaryweapon.attachment5, classstruct.primaryweapon.attachment6];
  }

  if(!isDefined(classstruct.secondaryweapon.attachments)) {
    classstruct.secondaryweapon.attachments = [classstruct.secondaryweapon.attachment1, classstruct.secondaryweapon.attachment2, classstruct.secondaryweapon.attachment3, classstruct.secondaryweapon.attachment4, classstruct.secondaryweapon.attachment5];
  }

  if(istrue(level.tertiaryweaponslotenabled)) {
    if(!isDefined(classstruct.tertiaryweapon.attachments)) {
      classstruct.tertiaryweapon.attachments = [classstruct.tertiaryweapon.attachment1, classstruct.tertiaryweapon.attachment2, classstruct.tertiaryweapon.attachment3, classstruct.tertiaryweapon.attachment4, classstruct.tertiaryweapon.attachment5];
    }
  }

  if(weaponindex == 0) {
    tempname = classstruct.primaryweapon.attachments[attachmentindex];
  } else if(weaponindex == 1) {
    tempname = classstruct.secondaryweapon.attachments[attachmentindex];
  } else {
    tempname = classstruct.tertiaryweapon.attachments[attachmentindex];
  }

  if(!isDefined(tempname) || tempname == "") {
    return "none";
  }

  return tempname;
}

function table_getweaponcamo(tablename, classindex, weaponindex) {
  return function_aacbcd2576b3af83(tablename, classindex, weaponindex).camo;
}

function table_getweaponreticle(tablename, classindex, weaponindex) {
  return function_aacbcd2576b3af83(tablename, classindex, weaponindex).reticle;
}

function table_getweaponvariantid(tablename, classindex, weaponindex, rootweapon, norandom) {
  svariantid = function_aacbcd2576b3af83(tablename, classindex, weaponindex).variantid;
  return table_parseweaponvariantidvalue(rootweapon, svariantid, norandom);
}

function table_parseweaponvariantidvalue(rootweapon, value, norandom) {
  if(rootweapon == "none") {
    return 0;
  }

  if(!isDefined(level.blockedvariantidsmap)) {
    level.blockedvariantidsmap = [];
    level.blockedvariantidsmap["iw8_ar_tango21"] = [1];
    level.blockedvariantidsmap["iw8_ar_mike4"] = [5];
    level.blockedvariantidsmap["iw8_ar_kilo433"] = [3];
    level.blockedvariantidsmap["iw8_ar_scharlie"] = [3];
    level.blockedvariantidsmap["iw8_sm_uzulu"] = [4];
    level.blockedvariantidsmap["iw8_sh_romeo870"] = [5];
    level.blockedvariantidsmap["iw8_sh_dpapa12"] = [3];
    level.blockedvariantidsmap["iw8_lm_mgolf34"] = [4];
    level.blockedvariantidsmap["iw8_sn_kilo98"] = [16];
    level.blockedvariantidsmap["iw8_sn_alpha50"] = [2];
    level.blockedvariantidsmap["iw8_sn_hdromeo"] = [4];
    level.blockedvariantidsmap["iw8_pi_golf21"] = [3];
    level.blockedvariantidsmap["iw8_pi_cpapa"] = [15];
    var_a6f6c01484bd5665 = getDvar(@ "hash_4caa11caeebf587b", "");

    if(var_a6f6c01484bd5665 != "") {
      var_9c58c4f8acc9cf26 = strtok(var_a6f6c01484bd5665, ",");

      foreach(weaponvariant in var_9c58c4f8acc9cf26) {
        pair = strtok(weaponvariant, "|");

        if(pair.size == 2) {
          weaponblock = pair[0];
          idblock = int(pair[1]);

          if(!isDefined(level.blockedvariantidsmap[weaponblock])) {
            level.blockedvariantidsmap[weaponblock] = [];
          }

          level.blockedvariantidsmap[weaponblock][level.blockedvariantidsmap[weaponblock].size] = idblock;
        }
      }
    }
  }

  blockedids = undefined;

  if(isDefined(level.blockedvariantidsmap[rootweapon])) {
    blockedids = level.blockedvariantidsmap[rootweapon];
  }

  variantid = 0;
  allowrandom = !istrue(norandom);
  forcerandom = allowrandom && getdvarint(@ "hash_c895ae760d4177d4", 0);

  if(forcerandom == 1) {
    variantid = getweaponrandomvariantid(rootweapon, blockedids);
  } else {
    var_2891e3df80a13684 = strtok(value, " ");
    variantids = [];

    foreach(sid in var_2891e3df80a13684) {
      iid = int(sid);

      if(!isDefined(blockedids) || !array_contains(blockedids, iid)) {
        variantids[variantids.size] = iid;
      }
    }

    if(variantids.size != 0) {
      if(allowrandom) {
        variantid = variantids[randomint(variantids.size)];
      } else {
        variantid = variantids[0];
      }
    }
  }

  if(variantid == -1) {
    if(allowrandom) {
      variantid = getweaponrandomvariantid(rootweapon, blockedids);
    } else {
      variantid = 0;
    }
  }

  if(variantid != 0) {
    validweapon = weaponisValid(rootweapon, variantid);
    assertex(validweapon, "<dev string:xb6>" + rootweapon + "<dev string:xf1>" + variantid);

    if(!validweapon) {
      variantid = 0;
    }
  }

  return variantid;
}

function table_getperk(tablename, classindex, perkindex) {
  assert(perkindex <= 3);
  classstruct = function_c7a0b640c398497(tablename, classindex);

  if(!isDefined(classstruct.perksarray)) {
    classstruct.perksarray = [classstruct.perks.perk1, classstruct.perks.perk2, classstruct.perks.perk3];
  }

  return classstruct.perksarray[perkindex];
}

function function_f9c715f78b428034(tablename, classindex) {
  var_5ed4f9b02e1d9c1c = function_c7a0b640c398497(tablename, classindex).perkpackage;

  if(isDefined(var_5ed4f9b02e1d9c1c)) {
    return function_5d63ef3292dd14b9(var_5ed4f9b02e1d9c1c);
  }

  return undefined;
}

function table_getextraperk(tablename, classindex, perkindex) {
  assert(perkindex <= 3);
  classstruct = function_c7a0b640c398497(tablename, classindex);

  if(!isDefined(classstruct.var_9e0a050f0398edc3)) {
    classstruct.var_9e0a050f0398edc3 = [classstruct.extraperks.perk1, classstruct.extraperks.perk2, classstruct.extraperks.perk3];
  }

  return classstruct.var_9e0a050f0398edc3[perkindex];
}

function function_f8e92e6cd8007d6b(tablename, classindex, perkindex) {
  assert(perkindex <= 5);
  classstruct = function_c7a0b640c398497(tablename, classindex);

  if(!isDefined(classstruct.var_d664a7af3b17529e)) {
    classstruct.var_d664a7af3b17529e = [classstruct.flcperks.perk1, classstruct.flcperks.perk2, classstruct.flcperks.perk3, classstruct.flcperks.perk4, classstruct.flcperks.perk5, classstruct.flcperks.perk6, classstruct.flcperks.perk7];
  }

  return classstruct.var_d664a7af3b17529e[perkindex];
}

function table_getequipmentprimary(tablename, classindex) {
  return function_c7a0b640c398497(tablename, classindex).equipment.primary;
}

function table_getextraequipmentprimary(tablename, classindex) {
  value = function_c7a0b640c398497(tablename, classindex).extrapower.primary;
  return isDefined(value) && value == 1;
}

function table_getflcextraequipmentprimary(tablename, classindex) {
  value = function_c7a0b640c398497(tablename, classindex).flcextraequipment.primary;
  return isDefined(value) && value == 1;
}

function table_getequipmentsecondary(tablename, classindex) {
  return function_c7a0b640c398497(tablename, classindex).equipment.secondary;
}

function table_getextraequipmentsecondary(tablename, classindex) {
  value = function_c7a0b640c398497(tablename, classindex).extrapower.secondary;
  return isDefined(value) && value == 1;
}

function table_getflcextraequipmentsecondary(tablename, classindex) {
  value = function_c7a0b640c398497(tablename, classindex).flcextraequipment.secondary;
  return isDefined(value) && value == 1;
}

function table_getsuper(tablename, classindex, index) {
  classstruct = function_c7a0b640c398497(tablename, classindex);
  classstruct.var_ed1e9520c9e770ea = [classstruct.fieldupgrades.fieldupgrade1, classstruct.fieldupgrades.fieldupgrade2];
  return classstruct.var_ed1e9520c9e770ea[index];
}

function function_fc81ca208ad5823f(tablename, classindex, index) {
  classstruct = function_c7a0b640c398497(tablename, classindex);
  classstruct.var_9934efcb7046574a = [classstruct.var_c0936af6fe335d3c.fieldupgrade1, classstruct.var_c0936af6fe335d3c.fieldupgrade2];
  return classstruct.var_9934efcb7046574a[index];
}

function table_getspecialist(tablename, classindex) {
  value = function_c7a0b640c398497(tablename, classindex).specialist;
  return isDefined(value) && value == 1;
}

function table_getgesture(tablename, classindex) {
  return function_c7a0b640c398497(tablename, classindex).gesture;
}

function table_getexecution(tablename, classindex) {
  return function_c7a0b640c398497(tablename, classindex).execution;
}

function loadout_getplayerstreaktype(loadoutstreaktype) {
  assertex(isDefined(loadoutstreaktype), "<dev string:xf6>");
  result = undefined;

  switch (loadoutstreaktype) {
    case #"hash_e23522b86eb526c3":
      result = "support";
      break;
    case #"hash_946bfb43e361a475":
      result = "specialist";
      break;
    case #"hash_84b8b53bd4ec32c0":
      result = "resource";
      break;
    default:
      result = "assault";
      break;
  }

  return result;
}

function function_5d63ef3292dd14b9(bundlename) {
  var_6db51b5b1a26eea7 = getscriptbundle("perkpackage:" + bundlename);
  perkpackage = [4];
  perkpackage[0] = var_6db51b5b1a26eea7.perks.baseperk1;
  perkpackage[1] = var_6db51b5b1a26eea7.perks.baseperk2;
  perkpackage[2] = var_6db51b5b1a26eea7.perks.bonusperk;
  perkpackage[3] = var_6db51b5b1a26eea7.perks.ultimateperk;
  return perkpackage;
}

function getloadoutstreaktypefromstreaktype(streaktype) {
  if(!isDefined(streaktype)) {
    assertmsg("<dev string:x150>");
    return "streaktype_assault";
  }

  switch (streaktype) {
    case #"hash_605929bc0f7f95c8":
      return "streaktype_support";
    case #"hash_2bee0bf604b15c84":
      return "streaktype_specialist";
    case #"hash_d4f05e450448c3ec":
      return "streaktype_assault";
    default:
      assertex(0, "<dev string:x199>");
      return "streaktype_assault";
  }
}

function loadout_getclassteam(class) {
  if(isDefined(self.team) && self.team == "spectator") {
    class = "none";
  }

  classteam = "none";

  if(issubstr(class, "axis")) {
    classteam = "axis";
  } else if(issubstr(class, "allies")) {
    classteam = "allies";
  }

  return classteam;
}

function loadout_clearplayer(var_bea1f8064eda3de9) {
  loadout_clearweapons(var_bea1f8064eda3de9);
  _detachall(var_bea1f8064eda3de9);
  scripts\mp\equipment::clearallequipment();

  if(isDefined(self.loadoutarchetype)) {
    clearscriptable();
  }

  scripts\mp\archetypes\archcommon::removearchetype(self.loadoutarchetype);
  loadout_clearperks(var_bea1f8064eda3de9);
  scripts\mp\perks\weaponpassives::forgetpassives();
  scripts\cp_mp\gestures::cleargesture();
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\accessories::clearplayeraccessory();
  scripts\mp\perks\perkpackage::perkpackage_resetoverridefieldupgrades();

  if(!istrue(var_bea1f8064eda3de9)) {
    resetfunctionality();
    resetactionslots();
  }
}

function loadout_clearweapons(var_bea1f8064eda3de9) {
  if(istrue(var_bea1f8064eda3de9)) {
    if(isDefined(self.primaryweaponobj)) {
      _takeweapon(self.primaryweaponobj);
    }

    if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename != "none") {
      _takeweapon(self.secondaryweaponobj);
    }

    if(isDefined(self.tertiaryweaponobj) && self.tertiaryweaponobj.basename != "none") {
      _takeweapon(self.tertiaryweaponobj);
    }
  } else {
    self takeallweapons();
  }

  self.primaryweapon = undefined;
  self.primaryweaponobj = undefined;
  self.secondaryweapon = undefined;
  self.secondaryweaponobj = undefined;
  thread namespace_6b49ddb858f34366::function_adcb155953291ec7(undefined, 0);
}

function loadout_giveperk(perkname) {
  if(!isDefined(self.loadoutperks)) {
    self.loadoutperks = [];
  }

  giveperk(perkname);
  self.loadoutperks[self.loadoutperks.size] = perkname;
  function_df87366a6b9bc3a0(self.loadoutperks);
}

function loadout_removeperk(perkname) {
  if(isDefined(self.loadoutperks)) {
    perkremoved = 0;
    var_f04f11d62e9174ab = [];

    foreach(_perkname in self.loadoutperks) {
      if(!perkremoved) {
        if(_perkname == perkname) {
          removeperk(_perkname);
          perkremoved = 1;
          continue;
        }
      }

      var_f04f11d62e9174ab[var_f04f11d62e9174ab.size] = _perkname;
    }

    self.loadoutperks = var_f04f11d62e9174ab;
    function_df87366a6b9bc3a0(var_f04f11d62e9174ab);
  }
}

function private function_df87366a6b9bc3a0(perkarr) {
  if(isDefined(self.pers)) {
    loadoutperks = [];
    extraperks = [];
    tier2perk = undefined;
    tier3perk = undefined;

    if(isDefined(perkarr) && perkarr.size > 0) {
      foreach(perk in perkarr) {
        slot = scripts\mp\perks\perks::getperkslot(perk);

        if(isDefined(slot)) {
          loadoutperks[loadoutperks.size] = perk;
        }
      }
    }

    self.pers["loadoutPerks"] = loadoutperks;
  }
}

function loadout_clearperks(var_bea1f8064eda3de9, var_8be0f967aaa6eca6) {
  if(!isDefined(var_8be0f967aaa6eca6)) {
    var_8be0f967aaa6eca6 = 0;
  }

  if(getdvarint(@ "hash_6a4d5cd30c97a609", 0)) {
    assertmsg("<dev string:x1e0>");
  }

  if(istrue(var_bea1f8064eda3de9)) {
    if(isDefined(self.loadoutperks) && !istrue(self.perkscleared)) {
      foreach(perkname in self.loadoutperks) {
        removeperk(perkname);
      }
    }

    foreach(perkname, value in self.perks) {
      if(isDefined(self.var_15f3e6df722fb1cf) && perkname == self.var_15f3e6df722fb1cf) {
        removeperk(self.var_15f3e6df722fb1cf);
      }

      if(isDefined(self.var_15f3e5df722faf9c) && perkname == self.var_15f3e5df722faf9c) {
        removeperk(self.var_15f3e5df722faf9c);
      }
    }
  } else {
    if(var_8be0f967aaa6eca6) {
      scripts\mp\perks\perks::function_29ef7a1951b051f7();
    } else {
      scripts\mp\perks\perks::_clearperks();
    }

    self notify("all_perks_cleared");
  }

  if(getdvarint(@ "hash_6a4d5cd30c97a609", 0)) {
    logstring("\n PERKS BUG LOGGING - After clear, player has " + self.perks.size + " perks.");

    foreach(idx, perk in self.perks) {
      logstring("\n" + idx);
    }
  }

  self.loadoutperks = [];
  function_df87366a6b9bc3a0();
  self notify("loadout_perks_cleared");
}

function loadout_getclassstruct() {
  struct = spawnStruct();
  struct.loadoutarchetype = "none";
  struct.loadoutprimary = "none";
  struct.loadoutprimaryattachments = [];
  struct.loadoutprimaryattachmentids = [];

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    struct.loadoutprimaryattachments[attachmentindex] = "none";
    struct.loadoutprimaryattachmentids[attachmentindex] = 0;
  }

  struct.loadoutprimarycamo = "none";
  struct.loadoutprimaryreticle = "none";
  struct.loadoutprimarylootitemid = 0;
  struct.loadoutprimaryvariantid = -1;
  struct.loadoutprimarycosmeticattachment = "none";
  struct.loadoutprimarystickers = [];

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    struct.loadoutprimarystickers[var_36d2abbdcbcb186c] = "none";
  }

  struct.loadoutsecondary = "none";
  struct.loadoutsecondaryattachments = [];
  struct.loadoutsecondaryattachmentids = [];

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    struct.loadoutsecondaryattachments[attachmentindex] = "none";
    struct.loadoutsecondaryattachmentids[attachmentindex] = 0;
  }

  struct.loadoutsecondarycamo = "none";
  struct.loadoutsecondaryreticle = "none";
  struct.loadoutsecondarylootitemid = 0;
  struct.loadoutsecondaryvariantid = -1;
  struct.loadoutsecondarycosmeticattachment = "none";
  struct.loadoutsecondarystickers = [];

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    struct.loadoutsecondarystickers[var_36d2abbdcbcb186c] = "none";
  }

  if(istrue(level.tertiaryweaponslotenabled)) {
    struct.loadouttertiary = "none";
    struct.var_494870a5978b5a09 = [];
    struct.var_6bfdc660c23f71ea = [];

    for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
      struct.var_494870a5978b5a09[attachmentindex] = "none";
      struct.var_6bfdc660c23f71ea[attachmentindex] = 0;
    }

    struct.loadouttertiarycamo = "none";
    struct.loadouttertiaryreticle = "none";
    struct.var_64e57707d385a2f5 = 0;
    struct.loadouttertiaryvariantid = -1;
    struct.var_372f30ef6d6882ab = "none";
    struct.var_afb9de90c523d105 = [];

    for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {
      struct.var_afb9de90c523d105[var_36d2abbdcbcb186c] = "none";
    }
  }

  if(function_da27e3343b019fde()) {
    struct.var_dd07587af7d0ec5e = level.var_dd07587af7d0ec5e;
  }

  struct.loadoutmeleeslot = "none";
  struct.loadoutperksfromgamemode = 0;
  struct.loadoutperks = [];
  struct.loadoutstandardperks = [];
  struct.loadoutextraperks = [];
  struct.loadoutrigtrait = "specialty_null";
  struct.loadoutusingspecialist = 0;
  struct.loadoutequipmentprimary = "none";
  struct.var_b68e3a0a9c628d23 = 0;
  struct.loadoutextraequipmentprimary = 0;
  struct.loadoutequipmentsecondary = "none";
  struct.var_a1dfc5ce15795a3 = 0;
  struct.loadoutextraequipmentsecondary = 0;
  struct.loadoutsuper = "none";
  struct.loadoutgesture = "none";
  struct.loadoutaccessorydata = "none";
  struct.loadoutaccessoryweapon = "none";
  struct.loadoutfieldupgrade1 = "none";
  struct.var_4c4f03fa00925daf = 0;
  struct.loadoutfieldupgrade2 = "none";
  struct.var_2907f1614fe4e5f2 = 0;
  struct.loadoutswimweapon = "none";
  struct.loadoutClimbWeapon = "none";
  struct.loadoutstreaksfilled = 0;
  struct.loadoutstreaktype = "streaktype_assault";
  struct.loadoutkillstreak1 = "none";
  struct.loadoutkillstreak2 = "none";
  struct.loadoutkillstreak3 = "none";
  struct.var_70f190143fb74941 = 0;
  struct.var_2b902dfc607c8860 = 0;
  struct.var_7e3e3c6aebc4618f = 0;
  struct.tweakedbyplayerduringmatch = 0;
  struct.gamemodeforcednewloadout = 0;
  struct.iscopiedclass = 0;
  return struct;
}

function loadout_copyclassstruct(classstruct) {
  copystruct = spawnStruct();
  copystruct.loadoutarchetype = classstruct.loadoutarchetype;

  if(isDefined(classstruct.loadoutprimaryaddblueprintattachments)) {
    copystruct.loadoutprimaryaddblueprintattachments = classstruct.loadoutprimaryaddblueprintattachments;
  }

  copystruct.loadoutprimary = classstruct.loadoutprimary;
  copystruct.loadoutprimaryattachments = classstruct.loadoutprimaryattachments;
  copystruct.loadoutprimaryattachmentids = classstruct.loadoutprimaryattachmentids;
  copystruct.loadoutprimarycamo = classstruct.loadoutprimarycamo;
  copystruct.loadoutprimaryreticle = classstruct.loadoutprimaryreticle;
  copystruct.loadoutprimarylootitemid = classstruct.loadoutprimarylootitemid;
  copystruct.loadoutprimaryvariantid = classstruct.loadoutprimaryvariantid;
  copystruct.loadoutprimarycosmeticattachment = classstruct.loadoutprimarycosmeticattachment;
  copystruct.loadoutprimarystickers = classstruct.loadoutprimaryweaponstickers;

  if(isDefined(classstruct.loadoutsecondaryaddblueprintattachments)) {
    copystruct.loadoutsecondaryaddblueprintattachments = classstruct.loadoutsecondaryaddblueprintattachments;
  }

  copystruct.loadoutsecondary = classstruct.loadoutsecondary;
  copystruct.loadoutsecondaryattachments = classstruct.loadoutsecondaryattachments;
  copystruct.loadoutsecondaryattachmentids = classstruct.loadoutsecondaryattachmentids;
  copystruct.loadoutsecondarycamo = classstruct.loadoutsecondarycamo;
  copystruct.loadoutsecondaryreticle = classstruct.loadoutsecondaryreticle;
  copystruct.loadoutsecondarylootitemid = classstruct.loadoutsecondarylootitemid;
  copystruct.loadoutsecondaryvariantid = classstruct.loadoutsecondaryvariantid;
  copystruct.loadoutsecondarycosmeticattachment = classstruct.loadoutsecondarycosmeticattachment;
  copystruct.loadoutsecondarystickers = classstruct.loadoutsecondarystickers;

  if(istrue(level.tertiaryweaponslotenabled)) {
    if(isDefined(classstruct.loadouttertiaryaddblueprintattachments)) {
      copystruct.loadouttertiaryaddblueprintattachments = classstruct.loadouttertiaryaddblueprintattachments;
    }

    copystruct.loadouttertiary = classstruct.loadouttertiary;
    copystruct.var_494870a5978b5a09 = classstruct.var_494870a5978b5a09;
    copystruct.var_6bfdc660c23f71ea = classstruct.var_6bfdc660c23f71ea;
    copystruct.loadouttertiarycamo = classstruct.loadouttertiarycamo;
    copystruct.loadouttertiaryreticle = classstruct.loadouttertiaryreticle;
    copystruct.var_64e57707d385a2f5 = classstruct.var_64e57707d385a2f5;
    copystruct.loadouttertiaryvariantid = classstruct.loadouttertiaryvariantid;
    copystruct.var_372f30ef6d6882ab = classstruct.var_372f30ef6d6882ab;
    copystruct.var_afb9de90c523d105 = classstruct.var_afb9de90c523d105;
  }

  if(function_da27e3343b019fde()) {
    copystruct.var_dd07587af7d0ec5e = classstruct.var_dd07587af7d0ec5e;
  }

  copystruct.loadoutmeleeslot = classstruct.loadoutmeleeslot;
  copystruct.loadoutperksfromgamemode = classstruct.loadoutperksfromgamemode;
  copystruct.loadoutperks = classstruct.loadoutperks;
  copystruct.loadoutstandardperks = classstruct.loadoutstandardperks;
  copystruct.loadoutextraperks = classstruct.loadoutextraperks;
  copystruct.loadoutrigtrait = classstruct.loadoutrigtrait;
  copystruct.loadoutusingspecialist = classstruct.loadoutusingspecialist;
  copystruct.loadoutequipmentprimary = classstruct.loadoutequipmentprimary;
  copystruct.loadoutextraequipmentprimary = classstruct.loadoutextraequipmentprimary;
  copystruct.loadoutequipmentsecondary = classstruct.loadoutequipmentsecondary;
  copystruct.loadoutextraequipmentsecondary = classstruct.loadoutextraequipmentsecondary;
  copystruct.loadoutsuper = classstruct.loadoutsuper;
  copystruct.loadoutgesture = classstruct.loadoutgesture;
  copystruct.loadoutaccessorydata = classstruct.loadoutaccessorydata;
  copystruct.loadoutaccessoryweapon = classstruct.loadoutaccessoryweapon;
  copystruct.loadoutfieldupgrade1 = classstruct.loadoutfieldupgrade1;
  copystruct.loadoutfieldupgrade2 = classstruct.loadoutfieldupgrade2;
  copystruct.loadoutstreaksfilled = classstruct.loadoutstreaksfilled;
  copystruct.loadoutstreaktype = classstruct.loadoutstreaktype;
  copystruct.loadoutkillstreak1 = classstruct.loadoutkillstreak1;
  copystruct.loadoutkillstreak2 = classstruct.loadoutkillstreak2;
  copystruct.loadoutkillstreak3 = classstruct.loadoutkillstreak3;
  copystruct.tweakedbyplayerduringmatch = classstruct.tweakedbyplayerduringmatch;
  copystruct.gamemodeforcednewloadout = classstruct.gamemodeforcednewloadout;
  copystruct.iscopiedclass = classstruct.iscopiedclass;
  copystruct = loadout_updateclass(copystruct, "copied");
  return copystruct;
}

function loadout_updateclassteam(struct, class, classteam) {
  classteam = loadout_getclassteam(class);
  classindex = getclassindex(class);
  self.class_num = classindex;
  self.classteam = classteam;
  struct.loadoutarchetype = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "archetype");
  struct.loadoutprimary = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "weapon");

  if(struct.loadoutprimary == "none") {
    struct.loadoutprimary = "iw9_me_fists";
  } else {
    for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
      struct.loadoutprimaryattachments[attachmentindex] = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "attachmentSetup");
    }

    for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
      struct.loadoutprimarystickers[var_36d2abbdcbcb186c] = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "sticker");
    }
  }

  struct.loadoutprimarycamo = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "camo");
  struct.loadoutprimaryreticle = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "reticle");
  struct.loadoutsecondary = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "weapon");

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    struct.loadoutsecondaryattachments[attachmentindex] = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "attachmentSetup");
  }

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    struct.loadoutsecondarystickers[var_36d2abbdcbcb186c] = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "sticker");
  }

  struct.loadoutsecondarycamo = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "camo");
  struct.loadoutsecondaryreticle = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "reticle");

  if(istrue(level.tertiaryweaponslotenabled)) {
    struct.loadouttertiary = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "weapon");

    for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
      struct.var_494870a5978b5a09[attachmentindex] = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "attachmentSetup");
    }

    for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {
      struct.var_afb9de90c523d105[var_36d2abbdcbcb186c] = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "sticker");
    }

    struct.loadouttertiarycamo = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "camo");
    struct.loadouttertiaryreticle = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "reticle");
  }

  struct.loadoutmeleeslot = "none";
  struct.loadoutequipmentprimary = "none";
  struct.loadoutextraequipmentprimary = 0;
  struct.loadoutequipmentsecondary = "none";
  struct.loadoutextraequipmentsecondary = 0;
  struct.loadoutfieldupgrade1 = "none";
  struct.loadoutfieldupgrade2 = "none";
  struct.loadoutgesture = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "gesture");
  struct.loadoutstreaksfilled = 1;
  struct.loadoutkillstreak1 = recipe_getkillstreak(classteam, classindex, 0);
  struct.loadoutkillstreak2 = recipe_getkillstreak(classteam, classindex, 1);
  struct.loadoutkillstreak3 = recipe_getkillstreak(classteam, classindex, 2);
}

function loadout_updateclasscustom(struct, class, var_6b02e0d0b48f639a) {
  if(issharedfuncdefined("instanceInventory", "updateCustomClassStruct")) {
    [[getsharedfunc("instanceInventory", "updateCustomClassStruct")]](self, struct, class);
    return;
  }

  classindex = getclassindex(class);
  self.class_num = classindex;
  struct.loadoutarchetype = cac_getcharacterarchetype();
  struct.loadoutprimary = cac_getweapon(classindex, 0);

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    attachmentname = cac_getweaponattachment(classindex, 0, attachmentindex);
    struct.loadoutprimaryattachments[attachmentindex] = attachmentname;
    struct.loadoutprimaryattachmentids[attachmentindex] = cac_getweaponattachmentid(classindex, 0, attachmentindex);

    if(!istrue(var_6b02e0d0b48f639a)) {
      tuningvalues = function_a4065e820eb1f919(classindex, 0, attachmentindex);

      if(isDefined(tuningvalues)) {
        struct.var_193bf3cfb8aeaf0f[attachmentname] = tuningvalues;
      }
    }
  }

  struct.loadoutprimarycamo = cac_getweaponcamo(classindex, 0);
  struct.loadoutprimaryreticle = cac_getweaponreticle(classindex, 0);
  struct.loadoutprimarylootitemid = cac_getweaponlootitemid(classindex, 0);
  struct.loadoutprimaryvariantid = cac_getweaponvariantid(classindex, 0);
  struct.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(classindex, 0);

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    struct.loadoutprimarystickers[var_36d2abbdcbcb186c] = cac_getweaponsticker(classindex, 0, var_36d2abbdcbcb186c);
  }

  struct.loadoutsecondary = cac_getweapon(classindex, 1);

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    attachmentname = cac_getweaponattachment(classindex, 1, attachmentindex);
    struct.loadoutsecondaryattachments[attachmentindex] = attachmentname;
    struct.loadoutsecondaryattachmentids[attachmentindex] = cac_getweaponattachmentid(classindex, 1, attachmentindex);

    if(!istrue(var_6b02e0d0b48f639a)) {
      tuningvalues = function_a4065e820eb1f919(classindex, 1, attachmentindex);

      if(isDefined(tuningvalues)) {
        struct.var_ead3720e647f74a3[attachmentname] = tuningvalues;
      }
    }
  }

  struct.loadoutsecondarycamo = cac_getweaponcamo(classindex, 1);
  struct.loadoutsecondaryreticle = cac_getweaponreticle(classindex, 1);
  struct.loadoutsecondarylootitemid = cac_getweaponlootitemid(classindex, 1);
  struct.loadoutsecondaryvariantid = cac_getweaponvariantid(classindex, 1);
  struct.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(classindex, 1);

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    struct.loadoutsecondarystickers[var_36d2abbdcbcb186c] = cac_getweaponsticker(classindex, 1, var_36d2abbdcbcb186c);
  }

  if(istrue(level.tertiaryweaponslotenabled)) {
    struct.loadouttertiary = cac_getweapon(classindex, 2);

    for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
      attachmentname = cac_getweaponattachment(classindex, 2, attachmentindex);
      struct.var_494870a5978b5a09[attachmentindex] = attachmentname;
      struct.var_6bfdc660c23f71ea[attachmentindex] = cac_getweaponattachmentid(classindex, 2, attachmentindex);
      tuningvalues = function_a4065e820eb1f919(classindex, 2, attachmentindex);

      if(isDefined(tuningvalues)) {
        struct.var_b58a085466758039[attachmentname] = tuningvalues;
      }
    }

    struct.loadouttertiarycamo = cac_getweaponcamo(classindex, 2);
    struct.loadouttertiaryreticle = cac_getweaponreticle(classindex, 2);
    struct.var_64e57707d385a2f5 = cac_getweaponlootitemid(classindex, 2);
    struct.loadouttertiaryvariantid = cac_getweaponvariantid(classindex, 2);
    struct.var_372f30ef6d6882ab = cac_getweaponcosmeticattachment(classindex, 2);

    for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {
      struct.var_afb9de90c523d105[var_36d2abbdcbcb186c] = cac_getweaponsticker(classindex, 2, var_36d2abbdcbcb186c);
    }
  }

  struct.loadoutequipmentprimary = cac_getequipmentprimary(classindex);
  struct.var_b68e3a0a9c628d23 = function_9c883cb23c614891(classindex);
  struct.loadoutextraequipmentprimary = cac_getextraequipmentprimary(classindex);
  struct.loadoutequipmentsecondary = cac_getequipmentsecondary(classindex);
  struct.var_a1dfc5ce15795a3 = function_d9e6d0a8cbe6b48d(classindex);
  struct.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(classindex);
  struct.loadoutgesture = cac_getgesture();
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();
  struct.loadoutfieldupgrade1 = cac_getfieldupgrade(classindex, 0);
  struct.var_4c4f03fa00925daf = function_a2a7f87d758bbfb8(classindex, 0);
  struct.loadoutfieldupgrade2 = cac_getfieldupgrade(classindex, 1);
  struct.var_2907f1614fe4e5f2 = function_a2a7f87d758bbfb8(classindex, 1);
  struct.loadoutstreaksfilled = 1;
  struct.loadoutkillstreak1 = cac_getkillstreak(0, class);
  struct.loadoutkillstreak2 = cac_getkillstreak(1, class);
  struct.loadoutkillstreak3 = cac_getkillstreak(2, class);
  struct.var_70f190143fb74941 = function_3d362af202938e22(0, class);
  struct.var_2b902dfc607c8860 = function_3d362af202938e22(1, class);
  struct.var_7e3e3c6aebc4618f = function_3d362af202938e22(2, class);
  struct.loadoutusingspecialist = cac_getusingspecialist(classindex);
}

function loadout_updateclassgamemode(struct, class) {
  if(!isDefined(self.pers["gamemodeLoadout"]) && isbot(self)) {
    scripts\mp\bots\bots_loadout::function_a693c24def6fb1ed();
    loadout_updateclasscallback(struct);
    return;
  }

  self.class_num = getclassindex(class);
  gamemodeloadout = self.pers["gamemodeLoadout"];

  if(function_4ef12b6ed882dc9b()) {
    if(self.team == "allies") {
      gamemodeloadout = level.var_76c17959f073bcae["allies"];
    } else if(self.team == "axis") {
      gamemodeloadout = level.var_76c17959f073bcae["axis"];
    }
  }

  if(!isDefined(gamemodeloadout) || !isDefined(gamemodeloadout["loadoutArchetype"])) {
    if(isbot(self)) {
      struct.loadoutarchetype = "archetype_assault";
    } else {
      struct.loadoutarchetype = cac_getcharacterarchetype();
    }
  } else {
    struct.loadoutarchetype = gamemodeloadout["loadoutArchetype"];
  }

  if(isDefined(gamemodeloadout["loadoutRigTrait"])) {
    struct.loadoutrigtrait = gamemodeloadout["loadoutRigTrait"];
  }

  if(isDefined(gamemodeloadout["loadoutPrimaryAddBlueprintAttachments"])) {
    struct.loadoutprimaryaddblueprintattachments = gamemodeloadout["loadoutPrimaryAddBlueprintAttachments"];
  }

  if(isDefined(gamemodeloadout["loadoutPrimary"])) {
    struct.loadoutprimary = gamemodeloadout["loadoutPrimary"];
  }

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    attachstring = getattachmentloadoutstring(attachmentindex, #"primary");

    if(isDefined(gamemodeloadout[attachstring])) {
      struct.loadoutprimaryattachments[attachmentindex] = gamemodeloadout[attachstring];
    }

    attachmentvariantid = function_9f808ad55705b616(attachmentindex, #"primary");

    if(isDefined(gamemodeloadout[attachmentvariantid])) {
      struct.loadoutprimaryattachmentids[attachmentindex] = gamemodeloadout[attachmentvariantid];
    }
  }

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    var_5e5774b116a39979 = getstickerloadoutstring(var_36d2abbdcbcb186c, #"primary");

    if(isDefined(gamemodeloadout[var_5e5774b116a39979])) {
      struct.loadoutprimarystickers[var_36d2abbdcbcb186c] = gamemodeloadout[var_5e5774b116a39979];
    }
  }

  if(isDefined(gamemodeloadout["loadoutPrimaryCamo"])) {
    struct.loadoutprimarycamo = gamemodeloadout["loadoutPrimaryCamo"];
  }

  if(isDefined(gamemodeloadout["loadoutPrimaryCosmeticAttachment"])) {
    struct.loadoutprimarycosmeticattachment = gamemodeloadout["loadoutPrimaryCosmeticAttachment"];
  }

  if(isDefined(gamemodeloadout["loadoutPrimaryReticle"])) {
    struct.loadoutprimaryreticle = gamemodeloadout["loadoutPrimaryReticle"];
  }

  if(isDefined(gamemodeloadout["loadoutPrimaryVariantID"])) {
    struct.loadoutprimaryvariantid = gamemodeloadout["loadoutPrimaryVariantID"];
  }

  if(isDefined(gamemodeloadout["loadoutPrimaryVariantID"]) && getgametype() == "arena") {
    if(isDefined(gamemodeloadout["roundWinStreakPrimaryCamoTeam"]) && isDefined(self.pers["team"]) && gamemodeloadout["roundWinStreakPrimaryCamoTeam"] == self.pers["team"]) {
      if(isDefined(gamemodeloadout["roundWinStreakPrimaryCamo"])) {
        struct.loadoutprimarycamo = gamemodeloadout["roundWinStreakPrimaryCamo"];
      }
    }

    if(gamemodeloadout["loadoutPrimaryVariantID"] != -1) {
      setomnvar("ui_arena_primaryVariantID", gamemodeloadout["loadoutPrimaryVariantID"]);
    }
  }

  if(isDefined(gamemodeloadout["loadoutSecondaryAddBlueprintAttachments"])) {
    struct.loadoutsecondaryaddblueprintattachments = gamemodeloadout["loadoutSecondaryAddBlueprintAttachments"];
  }

  if(isDefined(gamemodeloadout["loadoutSecondary"])) {
    struct.loadoutsecondary = gamemodeloadout["loadoutSecondary"];
  }

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    attachstring = getattachmentloadoutstring(attachmentindex, #"secondary");

    if(isDefined(gamemodeloadout[attachstring])) {
      struct.loadoutsecondaryattachments[attachmentindex] = gamemodeloadout[attachstring];
    }

    attachmentvariantid = function_9f808ad55705b616(attachmentindex, #"secondary");

    if(isDefined(gamemodeloadout[attachmentvariantid])) {
      struct.loadoutsecondaryattachmentids[attachmentindex] = gamemodeloadout[attachmentvariantid];
    }
  }

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    var_5e5774b116a39979 = getstickerloadoutstring(var_36d2abbdcbcb186c, #"secondary");

    if(isDefined(gamemodeloadout[var_5e5774b116a39979])) {
      struct.loadoutsecondarystickers[var_36d2abbdcbcb186c] = gamemodeloadout[var_5e5774b116a39979];
    }
  }

  if(isDefined(gamemodeloadout["loadoutSecondaryCamo"])) {
    struct.loadoutsecondarycamo = gamemodeloadout["loadoutSecondaryCamo"];
  }

  if(isDefined(gamemodeloadout["loadoutSecondaryCosmeticAttachment"])) {
    struct.loadoutsecondarycosmeticattachment = gamemodeloadout["loadoutSecondaryCosmeticAttachment"];
  }

  if(isDefined(gamemodeloadout["loadoutSecondaryReticle"])) {
    struct.loadoutsecondaryreticle = gamemodeloadout["loadoutSecondaryReticle"];
  }

  if(isDefined(gamemodeloadout["loadoutSecondaryVariantID"])) {
    struct.loadoutsecondaryvariantid = gamemodeloadout["loadoutSecondaryVariantID"];
  }

  if(isDefined(gamemodeloadout["loadoutSecondaryVariantID"]) && getgametype() == "arena" && gamemodeloadout["loadoutSecondaryVariantID"] != -1) {
    if(isDefined(gamemodeloadout["roundWinStreakecondaryCamoTeam"]) && isDefined(self.pers["team"]) && gamemodeloadout["roundWinStreakecondaryCamoTeam"] == self.pers["team"]) {
      if(isDefined(gamemodeloadout["roundWinStreakSecondaryCamo"])) {
        struct.loadoutsecondarycamo = gamemodeloadout["roundWinStreakSecondaryCamo"];
      }
    }

    if(gamemodeloadout["loadoutSecondaryVariantID"] != -1) {
      setomnvar("ui_arena_secondaryVariantID", gamemodeloadout["loadoutSecondaryVariantID"]);
    }
  }

  if(isDefined(gamemodeloadout["loadoutMeleeSlot"])) {
    struct.loadoutmeleeslot = gamemodeloadout["loadoutMeleeSlot"];
  }

  if(isDefined(gamemodeloadout["loadoutSwimWeapon"])) {
    struct.loadoutswimweapon = gamemodeloadout["loadoutSwimWeapon"];
  }

  struct.loadoutperksfromgamemode = isDefined(gamemodeloadout["loadoutPerks"]);

  if(isDefined(gamemodeloadout["loadoutPerks"])) {
    struct.loadoutperks = gamemodeloadout["loadoutPerks"];
  }

  struct.loadoutextraperksfromgamemode = isDefined(gamemodeloadout["loadoutExtraPerks"]);

  if(isDefined(gamemodeloadout["loadoutExtraPerks"])) {
    struct.loadoutextraperks = gamemodeloadout["loadoutExtraPerks"];
  }

  if(isDefined(gamemodeloadout["loadoutEquipmentPrimary"])) {
    struct.loadoutequipmentprimary = gamemodeloadout["loadoutEquipmentPrimary"];
  }

  if(isDefined(gamemodeloadout["loadoutExtraEquipmentPrimary"])) {
    struct.loadoutextraequipmentprimary = gamemodeloadout["loadoutExtraEquipmentPrimary"];
  }

  if(isDefined(gamemodeloadout["loadoutEquipmentSecondary"])) {
    struct.loadoutequipmentsecondary = gamemodeloadout["loadoutEquipmentSecondary"];
  }

  if(isDefined(gamemodeloadout["loadoutExtraEquipmentSecondary"])) {
    struct.loadoutextraequipmentsecondary = gamemodeloadout["loadoutExtraEquipmentSecondary"];
  }

  if(isDefined(gamemodeloadout["loadoutSuper"])) {
    struct.loadoutsuper = gamemodeloadout["loadoutSuper"];
  }

  if(isDefined(gamemodeloadout["loadoutFieldUpgrade1"])) {
    struct.loadoutfieldupgrade1 = gamemodeloadout["loadoutFieldUpgrade1"];
  }

  if(isDefined(gamemodeloadout["loadoutFieldUpgrade2"])) {
    struct.loadoutfieldupgrade2 = gamemodeloadout["loadoutFieldUpgrade2"];
  }

  if(isDefined(gamemodeloadout["disableBackupPistol"])) {
    struct.disablebackuppistol = gamemodeloadout["disableBackupPistol"];
  }

  if(isbot(self)) {
    struct.loadoutaccessoryweapon = "none";
    struct.loadoutaccessorydata = "none";
    struct.loadoutaccessorylogic = "none";
  } else {
    struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
    struct.loadoutaccessorydata = cac_getaccessorydata();
    struct.loadoutaccessorylogic = cac_getaccessorylogic();
  }

  if(isDefined(gamemodeloadout["loadoutGesture"])) {
    if(gamemodeloadout["loadoutGesture"] == "playerData") {
      if(isbot(self)) {
        struct.loadoutgesture = "none";
      } else {
        struct.loadoutgesture = cac_getgesture();
      }
    } else {
      struct.loadoutgesture = gamemodeloadout["loadoutGesture"];
    }
  }

  if(isDefined(gamemodeloadout["loadoutKillstreak1"]) && gamemodeloadout["loadoutKillstreak1"] != "specialty_null" || isDefined(gamemodeloadout["loadoutKillstreak2"]) && gamemodeloadout["loadoutKillstreak2"] != "specialty_null" || isDefined(gamemodeloadout["loadoutKillstreak3"]) && gamemodeloadout["loadoutKillstreak3"] != "specialty_null") {
    struct.loadoutstreaksfilled = 1;
    struct.loadoutkillstreak1 = gamemodeloadout["loadoutKillstreak1"];
    struct.loadoutkillstreak2 = gamemodeloadout["loadoutKillstreak2"];
    struct.loadoutkillstreak3 = gamemodeloadout["loadoutKillstreak3"];
  }

  if(isDefined(gamemodeloadout["loadoutUsingSpecialist"])) {
    struct.loadoutusingspecialist = 1;
  }
}

function loadout_updateclasscallback(struct) {
  if(!isDefined(self.classcallback)) {
    error("self.classCallback function reference required for class 'callback'");
  }

  callbackloadout = self[[self.classcallback]]();

  if(!isDefined(callbackloadout)) {
    error("array required from self.classCallback for class 'callback'");
  }

  if(isbot(self)) {
    if(isDefined(callbackloadout.archetype)) {
      struct.loadoutarchetype = "archetype_" + tolower(callbackloadout.archetype);
    }

    if(isDefined(callbackloadout.primaryweapon.weapon)) {
      struct.loadoutprimary = callbackloadout.primaryweapon.weapon;
    }

    if(isDefined(callbackloadout.primaryweapon.attachment1)) {
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = callbackloadout.primaryweapon.attachment1;
    }

    if(isDefined(callbackloadout.primaryweapon.attachment2)) {
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = callbackloadout.primaryweapon.attachment2;
    }

    if(isDefined(callbackloadout.primaryweapon.attachment3)) {
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = callbackloadout.primaryweapon.attachment3;
    }

    if(isDefined(callbackloadout.primaryweapon.attachment4)) {
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = callbackloadout.primaryweapon.attachment4;
    }

    if(isDefined(callbackloadout.primaryweapon.attachment5)) {
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = callbackloadout.primaryweapon.attachment5;
    }

    if(isDefined(callbackloadout.primaryweapon.attachment6)) {
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = callbackloadout.primaryweapon.attachment6;
    }

    if(isDefined(callbackloadout.primaryweapon.camo)) {
      struct.loadoutprimarycamo = callbackloadout.primaryweapon.camo;
    }

    if(isDefined(callbackloadout.primaryweapon.reticle)) {
      struct.loadoutprimaryreticle = callbackloadout.primaryweapon.reticle;
    }

    if(isDefined(callbackloadout.secondaryweapon.weapon)) {
      struct.loadoutsecondary = callbackloadout.secondaryweapon.weapon;
    }

    if(isDefined(callbackloadout.secondaryweapon.attachment1)) {
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = callbackloadout.secondaryweapon.attachment1;
    }

    if(isDefined(callbackloadout.secondaryweapon.attachment2)) {
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = callbackloadout.secondaryweapon.attachment2;
    }

    if(isDefined(callbackloadout.secondaryweapon.attachment3)) {
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = callbackloadout.secondaryweapon.attachment3;
    }

    if(isDefined(callbackloadout.secondaryweapon.attachment4)) {
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = callbackloadout.secondaryweapon.attachment4;
    }

    if(isDefined(callbackloadout.secondaryweapon.attachment5)) {
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = callbackloadout.secondaryweapon.attachment5;
    }

    if(isDefined(callbackloadout.secondaryweapon.camo)) {
      struct.loadoutsecondarycamo = callbackloadout.secondaryweapon.camo;
    }

    if(isDefined(callbackloadout.secondaryweapon.reticle)) {
      struct.loadoutsecondaryreticle = callbackloadout.secondaryweapon.reticle;
    }

    if(isDefined(callbackloadout.tertiaryweapon)) {
      if(isDefined(callbackloadout.tertiaryweapon.weapon)) {
        struct.loadouttertiary = callbackloadout.tertiaryweapon.weapon;
      }

      if(isDefined(callbackloadout.tertiaryweapon.attachment1)) {
        struct.var_494870a5978b5a09[struct.var_494870a5978b5a09.size] = callbackloadout.tertiaryweapon.attachment1;
      }

      if(isDefined(callbackloadout.tertiaryweapon.attachment2)) {
        struct.var_494870a5978b5a09[struct.var_494870a5978b5a09.size] = callbackloadout.tertiaryweapon.attachment2;
      }

      if(isDefined(callbackloadout.tertiaryweapon.attachment3)) {
        struct.var_494870a5978b5a09[struct.var_494870a5978b5a09.size] = callbackloadout.tertiaryweapon.attachment3;
      }

      if(isDefined(callbackloadout.tertiaryweapon.attachment4)) {
        struct.var_494870a5978b5a09[struct.var_494870a5978b5a09.size] = callbackloadout.tertiaryweapon.attachment4;
      }

      if(isDefined(callbackloadout.tertiaryweapon.attachment5)) {
        struct.var_494870a5978b5a09[struct.var_494870a5978b5a09.size] = callbackloadout.tertiaryweapon.attachment5;
      }

      if(isDefined(callbackloadout.tertiaryweapon.camo)) {
        struct.loadouttertiarycamo = callbackloadout.tertiaryweapon.camo;
      }

      if(isDefined(callbackloadout.tertiaryweapon.reticle)) {
        struct.loadouttertiaryreticle = callbackloadout.tertiaryweapon.reticle;
      }
    }

    if(isDefined(callbackloadout.equipment.primary)) {
      struct.loadoutequipmentprimary = callbackloadout.equipment.primary;
    }

    if(isDefined(callbackloadout.equipment.secondary)) {
      struct.loadoutequipmentsecondary = callbackloadout.equipment.secondary;
    }

    if(isDefined(callbackloadout.perks.perk1)) {
      struct.loadoutperks[struct.loadoutperks.size] = callbackloadout.perks.perk1;
    }

    if(isDefined(callbackloadout.perks.perk2)) {
      struct.loadoutperks[struct.loadoutperks.size] = callbackloadout.perks.perk2;
    }

    if(isDefined(callbackloadout.perks.perk3)) {
      struct.loadoutperks[struct.loadoutperks.size] = callbackloadout.perks.perk3;
    }

    if(isDefined(callbackloadout.extraperks.perk1)) {
      struct.loadoutperks[struct.loadoutperks.size] = callbackloadout.extraperks.perk1;
    }

    if(isDefined(callbackloadout.extraperks.perk2)) {
      struct.loadoutperks[struct.loadoutperks.size] = callbackloadout.extraperks.perk2;
    }

    if(isDefined(callbackloadout.extraperks.perk3)) {
      struct.loadoutperks[struct.loadoutperks.size] = callbackloadout.extraperks.perk3;
    }

    if(isDefined(callbackloadout.gesture)) {
      struct.loadoutgesture = callbackloadout.gesture;
    }

    if(isDefined(callbackloadout.fieldupgrade1)) {
      struct.loadoutfieldupgrade1 = callbackloadout.fieldupgrade1;
    }

    if(isDefined(callbackloadout.fieldupgrade2)) {
      struct.loadoutfieldupgrade2 = callbackloadout.fieldupgrade2;
    }

    if(isDefined(callbackloadout.specialist)) {
      struct.loadoutusingspecialist = callbackloadout.specialist;
    }
  } else {
    if(isDefined(callbackloadout["loadoutArchetype"])) {
      struct.loadoutarchetype = callbackloadout["loadoutArchetype"];
    }

    if(isDefined(callbackloadout["loadoutPrimaryAddBlueprintAttachments"])) {
      struct.loadoutprimaryaddblueprintattachments = callbackloadout["loadoutPrimaryAddBlueprintAttachments"];
    }

    if(isDefined(callbackloadout["loadoutPrimary"])) {
      struct.loadoutprimary = callbackloadout["loadoutPrimary"];
    }

    for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
      attachstring = getattachmentloadoutstring(attachmentindex, #"primary");

      if(isDefined(callbackloadout[attachstring])) {
        struct.loadoutprimaryattachments[attachmentindex] = callbackloadout[attachstring];
      }
    }

    if(isDefined(callbackloadout["loadoutPrimaryCamo"])) {
      struct.loadoutprimarycamo = callbackloadout["loadoutPrimaryCamo"];
    }

    if(isDefined(callbackloadout["loadoutPrimaryReticle"])) {
      struct.loadoutprimaryreticle = callbackloadout["loadoutPrimaryReticle"];
    }

    if(isDefined(callbackloadout["loadoutPrimaryVariantID"])) {
      struct.loadoutprimaryvariantid = callbackloadout["loadoutPrimaryVariantID"];
    }

    if(isDefined(callbackloadout["loadoutSecondaryAddBlueprintAttachments"])) {
      struct.loadoutsecondaryaddblueprintattachments = callbackloadout["loadoutSecondaryAddBlueprintAttachments"];
    }

    if(isDefined(callbackloadout["loadoutSecondary"])) {
      struct.loadoutsecondary = callbackloadout["loadoutSecondary"];
    }

    for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
      attachstring = getattachmentloadoutstring(attachmentindex, #"secondary");

      if(isDefined(callbackloadout[attachstring])) {
        struct.loadoutsecondaryattachments[attachmentindex] = callbackloadout[attachstring];
      }
    }

    if(isDefined(callbackloadout["loadoutSecondaryCamo"])) {
      struct.loadoutsecondarycamo = callbackloadout["loadoutSecondaryCamo"];
    }

    if(isDefined(callbackloadout["loadoutSecondaryReticle"])) {
      struct.loadoutsecondaryreticle = callbackloadout["loadoutSecondaryReticle"];
    }

    if(isDefined(callbackloadout["loadoutSecondaryVariantID"])) {
      struct.loadoutsecondaryvariantid = callbackloadout["loadoutSecondaryVariantID"];
    }

    if(istrue(level.tertiaryweaponslotenabled)) {
      if(isDefined(callbackloadout["loadoutTertiaryAddBlueprintAttachments"])) {
        struct.loadouttertiaryaddblueprintattachments = callbackloadout["loadoutTertiaryAddBlueprintAttachments"];
      }

      if(isDefined(callbackloadout["loadoutTertiary"])) {
        struct.loadouttertiary = callbackloadout["loadoutTertiary"];
      }

      for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
        attachstring = getattachmentloadoutstring(attachmentindex, #"tertiary");

        if(isDefined(callbackloadout[attachstring])) {
          struct.var_494870a5978b5a09[attachmentindex] = callbackloadout[attachstring];
        }
      }

      if(isDefined(callbackloadout["loadoutTertiaryCamo"])) {
        struct.loadouttertiarycamo = callbackloadout["loadoutTertiaryCamo"];
      }

      if(isDefined(callbackloadout["loadoutTertiaryReticle"])) {
        struct.loadouttertiaryreticle = callbackloadout["loadoutTertiaryReticle"];
      }

      if(isDefined(callbackloadout["loadoutTertiaryVariantID"])) {
        struct.loadouttertiaryvariantid = callbackloadout["loadoutTertiaryVariantID"];
      }
    }

    if(isDefined(callbackloadout["loadoutMeleeSlot"])) {
      struct.loadoutmeleeslot = callbackloadout["loadoutMeleeSlot"];
    }

    if(isDefined(callbackloadout["loadoutEquipmentPrimary"])) {
      struct.loadoutequipmentprimary = callbackloadout["loadoutEquipmentPrimary"];
    }

    if(isDefined(callbackloadout["loadoutExtraEquipmentPrimary"])) {
      struct.loadoutextraequipmentprimary = callbackloadout["loadoutExtraEquipmentPrimary"];
    }

    if(isDefined(callbackloadout["loadoutEquipmentSecondary"])) {
      struct.loadoutequipmentsecondary = callbackloadout["loadoutEquipmentSecondary"];
    }

    if(isDefined(callbackloadout["loadoutExtraEquipmentSecondary"])) {
      struct.loadoutextraequipmentsecondary = callbackloadout["loadoutExtraEquipmentSecondary"];
    }

    if(isDefined(callbackloadout["loadoutSuper"])) {
      struct.loadoutsuper = callbackloadout["loadoutSuper"];
    }

    if(isDefined(callbackloadout["loadoutGesture"])) {
      struct.loadoutgesture = callbackloadout["loadoutGesture"];
    }

    struct.loadoutstreaksfilled = isDefined(callbackloadout["loadoutStreak1"]) || isDefined(callbackloadout["loadoutStreak2"]) || isDefined(callbackloadout["loadoutStreak3"]);

    if(isDefined(callbackloadout["loadoutStreakType"])) {
      struct.loadoutstreaktype = callbackloadout["loadoutStreakType"];
    }

    if(isDefined(callbackloadout["loadoutStreak1"])) {
      struct.loadoutkillstreak1 = callbackloadout["loadoutStreak1"];
    }

    if(isDefined(callbackloadout["loadoutStreak2"])) {
      struct.loadoutkillstreak2 = callbackloadout["loadoutStreak2"];
    }

    if(isDefined(callbackloadout["loadoutStreak3"])) {
      struct.loadoutkillstreak3 = callbackloadout["loadoutStreak3"];
    }

    if(isDefined(callbackloadout["disableBackupPistol"])) {
      struct.disablebackuppistol = callbackloadout["disableBackupPistol"];
    }
  }

  struct.var_de7fe0f200a1deff = isDefined(struct.loadoutperks) && struct.loadoutperks.size > 0;
  struct.var_b5c2d62f9d1dae7b = isDefined(struct.loadoutextraperks) && struct.loadoutextraperks.size > 0;
}

function loadout_updateclassdefault(struct, class) {
  classindex = getclassindex(class);
  self.class_num = classindex;
  loadout_updateclassdefault_weapons(struct, classindex);
  struct.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, classindex);
  struct.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, classindex);
  struct.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, classindex);
  struct.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, classindex);
  struct.loadoutgesture = table_getgesture(level.classtablename, classindex);
  struct.loadoutusingspecialist = table_getspecialist(level.classtablename, classindex);
  struct.loadoutfieldupgrade1 = table_getsuper(level.classtablename, classindex, 0);
  struct.loadoutfieldupgrade2 = table_getsuper(level.classtablename, classindex, 1);
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();
  struct.loadoutarchetype = cac_getcharacterarchetype();
  struct.loadoutkillstreak1 = cac_getkillstreak(0, class);
  struct.loadoutkillstreak2 = cac_getkillstreak(1, class);
  struct.loadoutkillstreak3 = cac_getkillstreak(2, class);
  struct.var_70f190143fb74941 = function_3d362af202938e22(0, class);
  struct.var_2b902dfc607c8860 = function_3d362af202938e22(1, class);
  struct.var_7e3e3c6aebc4618f = function_3d362af202938e22(2, class);
  struct.loadoutrigtrait = cac_getloadoutarchetypeperk();

  if(issharedfuncdefined("instanceInventory", "updateDefaultClassStruct")) {
    [[getsharedfunc("instanceInventory", "updateDefaultClassStruct")]](self, struct);
  }
}

function loadout_updateclassdefault_weapons(struct, classindex) {
  struct.loadoutprimary = table_getweapon(level.classtablename, classindex, 0);

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    struct.loadoutprimaryattachments[attachmentindex] = table_getweaponattachment(level.classtablename, classindex, 0, attachmentindex);
  }

  struct.loadoutprimarycamo = table_getweaponcamo(level.classtablename, classindex, 0);
  struct.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, classindex, 0);
  struct.loadoutprimaryaddblueprintattachments = table_getaddblueprintattachments(level.classtablename, classindex, 0);
  struct.loadoutprimaryvariantid = table_getweaponvariantid(level.classtablename, classindex, 0, struct.loadoutprimary, 1);
  struct.loadoutsecondary = table_getweapon(level.classtablename, classindex, 1);

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    struct.loadoutsecondaryattachments[attachmentindex] = table_getweaponattachment(level.classtablename, classindex, 1, attachmentindex);
  }

  struct.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, classindex, 1);
  struct.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, classindex, 1);
  struct.loadoutsecondaryaddblueprintattachments = table_getaddblueprintattachments(level.classtablename, classindex, 1);
  struct.loadoutsecondaryvariantid = table_getweaponvariantid(level.classtablename, classindex, 1, struct.loadoutsecondary, 1);

  if(istrue(level.tertiaryweaponslotenabled)) {
    struct.loadouttertiary = table_getweapon(level.classtablename, classindex, 2);

    for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
      struct.var_494870a5978b5a09[attachmentindex] = table_getweaponattachment(level.classtablename, classindex, 2, attachmentindex);
    }

    struct.loadouttertiarycamo = table_getweaponcamo(level.classtablename, classindex, 2);
    struct.loadouttertiaryreticle = table_getweaponreticle(level.classtablename, classindex, 2);
  }
}

function loadout_updateclassdefault_weaponsheadless(struct) {
  if(!isDefined(self.headlessloadoutindexprimary)) {
    if(!isDefined(level.headlessloadoutindexprimary)) {
      offset = randomint(200);
      level.headlessloadoutindexprimary = offset;
      level.headlessloadoutindexsecondary = offset;
    } else {
      level.headlessloadoutindexprimary++;
      level.headlessloadoutindexsecondary++;
    }

    self.headlessloadoutindexprimary = level.headlessloadoutindexprimary;
    self.headlessloadoutindexsecondary = level.headlessloadoutindexsecondary;
  }

  primaryweaponarray = loadout_updateclassdefault_headlessgetweaponn(self.headlessloadoutindexprimary, 1);
  rootprimary = primaryweaponarray[0];
  structprimary = primaryweaponarray[1];
  struct.loadoutprimary = rootprimary;

  foreach(attachment, id in structprimary.attachcustomtoidmap) {
    struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = attachment;
    struct.loadoutprimaryattachmentids[struct.loadoutprimaryattachmentids.size] = id;
  }

  struct.loadoutprimaryvariantid = structprimary.variantid;
  var_3b584d0e4acc08fa = loadout_updateclassdefault_headlessgetweaponn(self.headlessloadoutindexsecondary, 0);
  rootsecondary = var_3b584d0e4acc08fa[0];
  structsecondary = var_3b584d0e4acc08fa[1];
  struct.loadoutsecondary = rootsecondary;

  foreach(attachment, id in structsecondary.attachcustomtoidmap) {
    struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = attachment;
    struct.loadoutsecondaryattachmentids[struct.loadoutsecondaryattachmentids.size] = id;
  }

  struct.loadoutsecondaryvariantid = structsecondary.variantid;

  if(istrue(level.tertiaryweaponslotenabled)) {
    var_b11f66fe609e2564 = loadout_updateclassdefault_headlessgetweaponn(self.var_49f7f5b78e79b56c, 0);
    var_cbf04d21c906f2af = var_b11f66fe609e2564[0];
    var_886ab8d288b46b2e = var_b11f66fe609e2564[1];
    struct.loadouttertiary = var_cbf04d21c906f2af;

    foreach(attachment, id in var_886ab8d288b46b2e.attachcustomtoidmap) {
      struct.var_494870a5978b5a09[struct.var_494870a5978b5a09.size] = attachment;
      struct.var_6bfdc660c23f71ea[struct.var_6bfdc660c23f71ea.size] = id;
    }

    struct.loadouttertiaryvariantid = var_886ab8d288b46b2e.variantid;
  }
}

function loadout_updateclassdefault_headlessgetweaponn(index, chooseprimary) {
  weaponfound = 0;
  idxcur = -1;

  while(true) {
    foreach(key, struct in level.weaponlootmapdata) {
      if(struct.variantid == 0 || struct.islocked || !isDefined(struct.attachcustomtoidmap)) {
        continue;
      }

      root = strtok(key, "|")[0];

      if(chooseprimary != iscacprimaryweapon(root)) {
        continue;
      }

      idxcur++;

      if(idxcur == index) {
        return [root, struct];
      }
    }
  }
}

function loadout_updatestreaktype(struct) {
  if(istrue(struct.loadoutusingspecialist)) {
    self.streaktype = "streaktype_specialist";
  } else {
    self.streaktype = "streaktype_assault";
  }

  struct.loadoutstreaktype = self.streaktype;
}

function loadout_updateabilities(struct, class) {
  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7() && getdvarint(@ "hash_48587f2cfa448879", 1) == 1) {
    return;
  }

  if(!isDefined(scripts\mp\utility\stats::getpersstat("loadoutPerks"))) {
    self.pers["loadoutPerks"] = [];
  }

  if(!isDefined(scripts\mp\utility\stats::getpersstat("loadoutStandardPerks"))) {
    self.pers["loadoutStandardPerks"] = [];
  }

  if(!isDefined(scripts\mp\utility\stats::getpersstat("loadoutExtraPerks"))) {
    self.pers["loadoutExtraPerks"] = [];
  }

  if(!isDefined(scripts\mp\utility\stats::getpersstat("loadoutRigTrait"))) {
    self.pers["loadoutRigTrait"] = [];
  }

  if(!isDefined(scripts\mp\utility\stats::getpersstat("loadoutUsingSpecialist"))) {
    self.pers["loadoutUsingSpecialist"] = 0;
  }

  isdefaultclass = getsubstr(class, 0, 7) == "default";

  if(istrue(struct.loadoutperksfromgamemode) || istrue(struct.var_de7fe0f200a1deff)) {
    loadoutperks = struct.loadoutperks;
    struct.loadoutperks = [];

    foreach(perk in loadoutperks) {
      if(!isDefined(perk) || perk == "specialty_null") {
        continue;
      }

      slot = scripts\mp\perks\perks::getperkslot(perk);

      if(!isDefined(slot)) {
        continue;
      }

      if(level.var_f3a9bf9e4404820f) {
        switch (slot) {
          case 2:
            struct.var_15f3e6df722fb1cf = perk;
            break;
          case 3:
            struct.var_15f3e5df722faf9c = perk;
            break;
          default:
            struct.loadoutperks[struct.loadoutperks.size] = perk;
            struct.loadoutstandardperks[struct.loadoutstandardperks.size] = perk;
            break;
        }

        continue;
      }

      struct.loadoutperks[struct.loadoutperks.size] = perk;
      struct.loadoutstandardperks[struct.loadoutstandardperks.size] = perk;
    }

    if(istrue(struct.loadoutextraperksfromgamemode) || istrue(struct.var_b5c2d62f9d1dae7b)) {
      struct.loadoutextraperks = struct.loadoutextraperks;
    }
  } else if(!perksenabled()) {
    return;
  } else if(class == "juggernaut" || class == "copied" || class == "superpower") {} else if(ismutationgamemodezombie()) {
    return;
  } else {
    classteam = loadout_getclassteam(class);
    perkpackage = [];

    if(level.var_606eb45e074ff204) {
      if(classteam != "none") {} else if(isdefaultclass) {
        classindex = getclassindex(class);
        var_7ca920f6d0b36b7e = function_f9c715f78b428034(level.classtablename, classindex);

        if(isDefined(var_7ca920f6d0b36b7e)) {
          perkpackage = var_7ca920f6d0b36b7e;
        }
      } else {
        perkpackageindex = function_3c33d2d97119a585(self.class_num);
        perkpackage = function_12b59a6e11ff097f(perkpackageindex);
      }
    }

    if(perkpackage.size > 0) {
      foreach(perk in perkpackage) {
        if(perk != "<dev string:x20d>") {
          var_e8826231d6ac089d = 1;
          break;
        }
      }

      assertex(var_e8826231d6ac089d, "<dev string:x21f>");
    }

    var_a220faf2607a348f = function_ea4c5dc15c3bbdd9();

    if(var_a220faf2607a348f) {
      for(perkindex = 0; perkindex < 5; perkindex++) {
        perk = "specialty_null";

        if(classteam != "none") {
          classindex = getclassindex(class);
          perk = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "loadoutPerks");
        } else if(isdefaultclass) {
          classindex = getclassindex(class);
          perk = function_f8e92e6cd8007d6b(level.classtablename, classindex, perkindex);
        } else {
          perk = function_e329ffc7ff0dcf96(self.class_num, perkindex);
        }

        if(isDefined(perk) && perk != "specialty_null") {
          struct.loadoutperks[struct.loadoutperks.size] = perk;
          struct.loadoutstandardperks[struct.loadoutstandardperks.size] = perk;
        }
      }
    } else {
      maxperks = int(max(3, perkpackage.size));

      if(level.var_f3a9bf9e4404820f) {
        maxperks = 3;
      }

      for(perkindex = 0; perkindex < maxperks; perkindex++) {
        perk = "specialty_null";

        if(level.var_606eb45e074ff204) {
          perk = perkpackage[perkindex];
        } else if(classteam != "none") {
          classindex = getclassindex(class);
          perk = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "loadoutPerks");
        } else if(isdefaultclass) {
          classindex = getclassindex(class);
          perk = table_getperk(level.classtablename, classindex, perkindex);
        } else {
          perk = cac_getloadoutperk(self.class_num, perkindex);
        }

        if(isDefined(perk) && perk != "specialty_null") {
          if(level.var_f3a9bf9e4404820f) {
            if(3 < perkindex) {
              struct.var_15f3e6df722fb1cf = perk;
            } else {
              struct.loadoutperks[struct.loadoutperks.size] = perk;
              struct.loadoutstandardperks[struct.loadoutstandardperks.size] = perk;
            }

            continue;
          }

          struct.loadoutperks[struct.loadoutperks.size] = perk;
          struct.loadoutstandardperks[struct.loadoutstandardperks.size] = perk;
        }
      }

      for(perkindex = 0; perkindex < 3; perkindex++) {
        perk = "specialty_null";

        if(classteam != "none") {
          classindex = getclassindex(class);
          perk = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "extraPerks");
        } else if(isdefaultclass) {
          classindex = getclassindex(class);
          perk = table_getextraperk(level.classtablename, classindex, perkindex);
        } else {
          perk = cac_getloadoutextraperk(self.class_num, perkindex);
        }

        if(isDefined(perk) && perk != "specialty_null") {
          if(level.var_f3a9bf9e4404820f) {
            if(perkindex == 0) {
              struct.var_15f3e5df722faf9c = perkpackage[3];
            }

            struct.loadoutextraperks[struct.loadoutextraperks.size] = perk;

            if(perk == "specialty_third_person") {
              struct.loadoutperks[struct.loadoutperks.size] = perk;
            }

            continue;
          }

          struct.loadoutextraperks[struct.loadoutextraperks.size] = perk;
          struct.var_15f3e5df722faf9c = perk;
        }
      }
    }

    perk = "specialty_null";

    if(classteam != "none") {
      classindex = getclassindex(class);
      perk = getmatchrulesdatawithteamandindex("defaultClasses", classteam, classindex, "class", "archetypePerk");
    } else {
      perk = cac_getloadoutarchetypeperk();
    }

    if(isDefined(perk) && perk != "specialty_null") {
      struct.loadoutperks[struct.loadoutperks.size] = perk;
      self.pers["loadoutRigTrait"] = perk;
      struct.loadoutrigtrait = perk;
    }
  }

  assert(isDefined(level.perkbundles));

  foreach(perk in struct.loadoutperks) {
    assertex(isDefined(level.perkbundles[perk]) && isDefined(level.var_d5f3dcf05b7e8be6[perk]), "<dev string:x25a>" + perk);
  }
}

function loadout_getclasstype(classname) {
  classteam = loadout_getclassteam(classname);

  if(classteam == "none" && !isDefined(classname)) {
    return "custom";
  }

  if(classteam != "none") {
    return "team";
  }

  if(issubstr(classname, "custom")) {
    return "custom";
  }

  if(classname == "gamemode") {
    return "gamemode";
  }

  if(classname == "callback") {
    return "callback";
  }

  if(classname == "juggernaut") {
    return "juggernaut";
  }

  if(classname == "superpower") {
    return "superpower";
  }

  if(classname == "copied") {
    return "copied";
  }

  return "default";
}

function function_72aa88e22948f6c5() {
  if(istrue(level.leagueplaymatch)) {
    if(level.var_bbcb5f6b1b0a78ae == 1 && getdvarint(@ "hash_ca2769e986904fa", 0) == 1 || level.var_bbcb5f6b1b0a78ae != 1) {
      return true;
    }
  }

  return false;
}

function loadout_updateglobalclass(globalstruct, class) {
  classtype = loadout_getclasstype(class);

  switch (classtype) {
    case #"hash_33857c6e26098e6c":
      break;
    case #"hash_44e999799ff10fce":
      break;
    case #"hash_412d4adaf2412dc0":
      loadout_updateglobalclassgamemode(globalstruct, class);
      break;
    case #"hash_43e76e9ca2c4666":
      break;
    case #"hash_7038dec66d8275be":
      break;
    case #"hash_4ad475e6e15635bd":
      break;
  }

  return globalstruct;
}

function function_7ef7699b039b00e3() {
  if(isDefined(level.var_127cc78420f659f8)) {
    return [[level.var_127cc78420f659f8]]();
  }

  return !scripts\cp_mp\utility\game_utility::isbrstylegametype();
}

function loadout_updateclass(struct, class) {
  if(!isagent(self) && self isplayerheadless() && function_7ef7699b039b00e3()) {
    class = "default" + randomint(5) + 1;
  }

  if(issubstr(class, "custom") && ismutationgamemodezombie()) {
    class = "default1";
  }

  if(!(istrue(level.leagueplaymatch) || istrue(level.var_77907d733abe8b63))) {
    if(function_de324c78ecdc7acd(self) && (getsubgametype() == "dmz" || getsubgametype() == "ob")) {
      numloadouts = function_df2933f96d726d71(level.classtablename);
      loadoutindex = randomint(numloadouts);
      class = "default" + loadoutindex + 1;
    }
  }

  classtype = loadout_getclasstype(class);
  var_6b02e0d0b48f639a = function_72aa88e22948f6c5();

  switch (classtype) {
    case #"hash_33857c6e26098e6c":
      loadout_updateclassteam(struct, class);
      break;
    case #"hash_44e999799ff10fce":
      loadout_updateclasscustom(struct, class, var_6b02e0d0b48f639a);
      break;
    case #"hash_412d4adaf2412dc0":
      loadout_updateclassgamemode(struct, class);
      break;
    case #"hash_43e76e9ca2c4666":
      loadout_updateclasscallback(struct);
      break;
    case #"hash_7038dec66d8275be":
      loadout_updateclassdefault(struct, class);
      break;
    case #"hash_4ad475e6e15635bd":
      break;
    case #"hash_80a9479df6c38d3d":
      break;
    case #"hash_bd4afc9a088efe45":
      break;
  }

  if(!istrue(game["isLaunchChunk"])) {
    self.pers["defaultOperatorSkinIndex"] = scripts\mp\teams::pickdefaultoperatorskin(struct.loadoutprimary);
  }

  loadout_updatehasnvg(struct);
  loadout_updateclassfistweapons(struct);
  function_2dad855d27735128(struct);
  function_fb9c11aeb7909511(struct);
  loadout_updatestreaktype(struct);
  loadout_updateabilities(struct, class);
  struct = loadout_validateclass(struct, class);
  loadout_updateclassfinalweapons(struct);

  if(isDefined(level.modeupdateloadoutclass)) {
    self[[level.modeupdateloadoutclass]](struct);
  }

  return struct;
}

function function_1d52554d28b51cbc(struct, classindex, table) {
  struct.loadoutarchetype = "archetype_assault";
  struct.loadoutprimary = function_c7a0b640c398497(table, classindex).primaryweapon.weapon;

  for(attachmentindex = 0; attachmentindex < scripts\mp\class::getmaxprimaryattachments(); attachmentindex++) {
    struct.loadoutprimaryattachments[attachmentindex] = table_getweaponattachment(table, classindex, 0, attachmentindex);
  }

  struct.loadoutprimarycamo = function_c7a0b640c398497(table, classindex).primaryweapon.camo;
  struct.loadoutprimaryreticle = function_c7a0b640c398497(table, classindex).primaryweapon.reticle;
  struct.loadoutsecondary = function_c7a0b640c398497(table, classindex).secondaryweapon.weapon;

  for(attachmentindex = 0; attachmentindex < scripts\mp\class::getmaxsecondaryattachments(); attachmentindex++) {
    struct.loadoutsecondaryattachment[attachmentindex] = table_getweaponattachment(table, classindex, 1, attachmentindex);
  }

  struct.loadoutsecondarycamo = function_c7a0b640c398497(table, classindex).secondaryweapon.camo;
  struct.loadoutsecondaryreticle = function_c7a0b640c398497(table, classindex).secondaryweapon.reticle;
  struct.loadoutmeleeslot = "none";
  struct.loadoutequipmentprimary = function_c7a0b640c398497(table, classindex).equipment.primary;
  struct.loadoutequipmentsecondary = function_c7a0b640c398497(table, classindex).equipment.secondary;
  struct.loadoutstreaktype = "assault";
  struct.loadoutkillstreak1 = "none";
  struct.loadoutkillstreak2 = "none";
  struct.loadoutkillstreak3 = "none";
  struct.var_70f190143fb74941 = 0;
  struct.var_2b902dfc607c8860 = 0;
  struct.var_7e3e3c6aebc4618f = 0;
  struct.loadoutfieldupgrade1 = "super_br_extract";
  struct.loadoutfieldupgrade2 = "none";
  struct.var_4c4f03fa00925daf = 0;
  struct.var_2907f1614fe4e5f2 = 0;
  struct.loadoutperks = [function_c7a0b640c398497(table, classindex).perks.perk1, function_c7a0b640c398497(table, classindex).perks.perk2, function_c7a0b640c398497(table, classindex).perks.perk3, function_c7a0b640c398497(table, classindex).extraperks.perk1, function_c7a0b640c398497(table, classindex).extraperks.perk2, function_c7a0b640c398497(table, classindex).extraperks.perk3];
  struct.loadoutgesture = "playerData";
  return struct;
}

function loadout_updateclassfistweapons(struct) {
  if(struct.loadoutprimary == "none") {
    struct.loadoutprimary = "iw9_me_fists";
  }

  if(function_b7d052e4bf41ee9b()) {
    if(struct.loadoutsecondary == "none") {
      struct.loadoutsecondary = "none";
    }

    return;
  }

  if(struct.loadoutsecondary == "none" && struct.loadoutprimary != "iw9_me_fists" && !istrue(self.isjuggernaut)) {
    struct.loadoutsecondary = "iw9_me_fists";
    return;
  }

  if(struct.loadoutprimary == "iw9_me_fists" && struct.loadoutsecondary == "iw9_me_fists") {
    struct.loadoutsecondary = "none";
  }
}

function function_2dad855d27735128(struct) {
  if(struct.loadoutswimweapon == "none") {
    if(getsubgametype() == "dmz" || getsubgametype() == "exgm" || getsubgametype() == "mini" || getsubgametype() == "plunder" || getsubgametype() == "br" || scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      struct.loadoutswimweapon = "iw9_swimfists_mp";
      return;
    }

    struct.loadoutswimweapon = "iw9_me_diveknife_mp";
  }
}

function function_fb9c11aeb7909511(struct) {
  if(struct.loadoutClimbWeapon == "none") {
    struct.loadoutClimbWeapon = "iw9_me_climbfists";
  }
}

function loadout_updatehasnvg(struct) {
  if(scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
    struct.loadouthasnvg = 1;
  }
}

function loadout_validateclass(struct, class) {
  var_c9a3e851ee6c762a = getgametype() == "gold_gun" && getdvarint(@ "hash_131708578e1fbe81", 1);
  var_c06f071f7e2f617e = isDefined(level.gametypebundle.namekey) && (level.gametypebundle.namekey == "br_ranked" || level.gametypebundle.namekey == "resranked");
  validatedefaultclass = (var_c9a3e851ee6c762a || var_c06f071f7e2f617e || isanymlgmatch()) && issubstr(class, "default");

  if(issubstr(class, "custom") || validatedefaultclass) {
    if(isDefined(level.var_8b5c3bda53460402)) {
      return [[level.var_8b5c3bda53460402]](struct);
    }

    return scripts\mp\validation::validateloadout(struct);
  }

  return struct;
}

function loadout_forcearchetype(struct) {
  forcearchetype = getdvarint(@ "forcearchetype", 0);

  if(forcearchetype > 0) {
    idx = getdvarint(@ "forcearchetype", 0);

    switch (idx) {
      case 1:
        struct.loadoutarchetype = "archetype_assault";
        break;
      default:
        assertmsg("<dev string:x280>");
        struct.loadoutarchetype = "archetype_assault";
        break;
    }

    return;
  }

  if(forcearchetype == -1) {
    archetypes = ["archetype_assault"];
    rand = randomint(archetypes.size);
    struct.loadoutarchetype = archetypes[rand];
    self iprintlnbold("Random Archetype: " + archetypes[rand]);
  }
}

function loadout_updateplayerarchetype(struct) {
  loadout_forcearchetype(struct);

  if(!istrue(self.btestclient)) {
    if(!isDefined(level.aonrules) || level.aonrules == 0) {
      assertex(struct.loadoutarchetype != "<dev string:x2c3>", "<dev string:x2cb>");
    }
  }

  self.loadoutarchetype = struct.loadoutarchetype;
  scripts\mp\weapons::updatemovespeedscale();
  var_b6592bb80f5ee4f5 = 1;
  move_slide = 2;
  var_cb3e24e9928efa4f = 4;
  move_dodge = 8;
  movemask = 0;
  funcapply = undefined;
  clothtype = undefined;
  maxenergy = 400;
  restorerate = 400;
  resttime = 900;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    restorerate = 133.333;
    resttime = 1800;
  }

  switch (self.loadoutarchetype) {
    case #"hash_98ff6f21872f18e0":
      movemask = var_b6592bb80f5ee4f5 | move_slide | var_cb3e24e9928efa4f;
      funcapply = &scripts\mp\archetypes\archassault::applyarchetype;
      clothtype = "vestlight";
      self.clothtype = clothtype;
      break;
    default:
      if(!istrue(self.btestclient)) {
        if(!isDefined(level.aonrules) || level.aonrules == 0) {
          assertmsg("<dev string:x320>" + struct.loadoutarchetype);
        }
      }

      break;
  }

  setdevdvarifuninitialized(@ "hash_ba3719a1ad298b5", 0);

  if(getdvarint(@ "hash_ba3719a1ad298b5")) {
    self allowdoublejump(movemask &var_b6592bb80f5ee4f5);
    self allowwallrun(movemask &var_cb3e24e9928efa4f);
    self allowdodge(movemask &move_dodge);
  } else {
    self allowdoublejump(0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowslide(movemask &move_slide);
  self allowlean(0);
  self energy_setmax(0, maxenergy);
  self energy_setenergy(0, maxenergy);
  self energy_setrestorerate(0, restorerate);
  self energy_setresttimems(0, resttime);
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
  self energy_setrestorerate(1, 10);
  self energy_setresttimems(1, ter_op(isanymlgmatch(), 2500, 0));

  if(isDefined(funcapply)) {
    self[[funcapply]]();
  }
}

function loadout_updateclassfinalweapons(struct) {
  if(istrue(struct.loadoutprimaryaddblueprintattachments)) {
    struct.loadoutprimaryobject = buildweapon_blueprint(struct.loadoutprimary, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue(struct.loadouthasnvg));
  } else {
    struct.loadoutprimaryobject = buildweapon(struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue(struct.loadouthasnvg), struct.var_193bf3cfb8aeaf0f);
  }

  struct.loadoutprimaryfullname = getcompleteweaponname(struct.loadoutprimaryobject);

  if(struct.loadoutsecondary == "none") {
    struct.loadoutsecondaryfullname = "none";
    struct.loadoutsecondaryobject = undefined;
  } else {
    if(istrue(struct.loadoutsecondaryaddblueprintattachments)) {
      struct.loadoutsecondaryobject = buildweapon_blueprintwithcustomattachments(struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue(struct.loadouthasnvg));
    } else {
      struct.loadoutsecondaryobject = buildweapon(struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue(struct.loadouthasnvg), struct.var_ead3720e647f74a3);
    }

    struct.loadoutsecondaryfullname = getcompleteweaponname(struct.loadoutsecondaryobject);
  }

  if(istrue(level.tertiaryweaponslotenabled)) {
    if(!isDefined(struct.loadouttertiary) || struct.loadouttertiary == "none") {
      struct.var_e3f8e7ca9c87781f = "none";
      struct.var_cc881f2bd3565d22 = undefined;
    } else {
      if(istrue(struct.loadouttertiaryaddblueprintattachments)) {
        struct.var_cc881f2bd3565d22 = buildweapon_blueprintwithcustomattachments(struct.loadouttertiary, struct.var_494870a5978b5a09, struct.loadouttertiarycamo, struct.loadouttertiaryreticle, struct.loadouttertiaryvariantid, struct.var_6bfdc660c23f71ea, struct.var_372f30ef6d6882ab, struct.var_afb9de90c523d105, istrue(struct.loadouthasnvg));
      } else {
        struct.var_cc881f2bd3565d22 = buildweapon(struct.loadouttertiary, struct.var_494870a5978b5a09, struct.loadouttertiarycamo, struct.loadouttertiaryreticle, struct.loadouttertiaryvariantid, struct.var_6bfdc660c23f71ea, struct.var_372f30ef6d6882ab, struct.var_afb9de90c523d105, istrue(struct.loadouthasnvg), struct.var_b58a085466758039);
      }

      struct.var_e3f8e7ca9c87781f = getcompleteweaponname(struct.var_cc881f2bd3565d22);
    }
  }

  if(function_da27e3343b019fde()) {
    struct.var_91e10e152b08ec1d = buildweapon(struct.var_dd07587af7d0ec5e, ["backup_pistol"]);
  }
}

function loadout_updateplayerweapons(struct, class, setspawnweap, skipfirstraise) {
  respawnitems = respawnitems_getrespawnitems();
  var_b86cf5cef6838543 = respawnitems_hasweapondata(respawnitems);
  var_10b09490bb78e90e = level.magcount;
  var_3920d61392aec9d5 = loadout_giveprimaryweapon(struct, respawnitems, var_b86cf5cef6838543);
  var_976a64288e459315 = undefined;
  var_f4aa3ed154783647 = !isDefined(respawnitems) || isDefined(respawnitems.weapons) && isDefined(respawnitems.weapons["secondary"]);

  if(var_f4aa3ed154783647) {
    var_976a64288e459315 = loadout_givesecondaryweapon(struct, respawnitems, var_b86cf5cef6838543);
  }

  namespace_6b49ddb858f34366::function_e90bd443e0a197dd(var_3920d61392aec9d5, var_976a64288e459315);
  var_166a71f33928f623 = undefined;

  if(istrue(level.tertiaryweaponslotenabled)) {
    var_9be1ec9738546b41 = !isDefined(respawnitems) || isDefined(respawnitems.weapons["tertiary"]);

    if(var_9be1ec9738546b41) {
      var_166a71f33928f623 = function_6927b3b638f60d97(struct, respawnitems, var_b86cf5cef6838543);
    }
  }

  if(function_da27e3343b019fde()) {
    function_4ffce833ce15363c(struct);
  }

  function_9743c56a4d2dc135(struct);
  function_a80b77a2abaa376e(struct);
  function_607536857fac2407(struct);
  loadout_updateammo(struct, var_3920d61392aec9d5, var_976a64288e459315, var_166a71f33928f623, respawnitems, var_b86cf5cef6838543, var_10b09490bb78e90e);
  self.loadoutmeleeslot = struct.loadoutmeleeslot;

  if(!isDefined(var_3920d61392aec9d5)) {
    if(isDefined(struct.loadoutprimary)) {
      logstring("IW9-688909: primaryGiveWeaponObj is undefined, weapon name is " + struct.loadoutprimary);
    } else {
      logstring("IW9-688909: primaryGiveWeaponObj is undefined, weapon name is also undefined");
    }
  }

  if(self hasweapon(var_3920d61392aec9d5)) {
    spawnweaponobj = var_3920d61392aec9d5;
  } else {
    spawnweaponobj = var_976a64288e459315;
  }

  if(isDefined(var_976a64288e459315) && var_976a64288e459315.basename != "none" && isDefined(var_3920d61392aec9d5) && var_3920d61392aec9d5.basename == "iw9_me_fists_mp") {
    spawnweaponobj = var_976a64288e459315;
  }

  if(!isai(self)) {
    _switchtoweapon(spawnweaponobj);
  }

  if(!isDefined(setspawnweap) || setspawnweap) {
    skipfirstraise = function_bae2a0b1db21cab9(spawnweaponobj, skipfirstraise);

    if(!isagent(self)) {
      self setspawnweapon(spawnweaponobj, !skipfirstraise);
    }
  }

  self.spawnweaponobj = spawnweaponobj;
  loadout_updateweapondependentsettings();
}

function loadout_finalizeweapons() {
  self notify("loadout_weapon_finalize");
  var_e5c5201a787eeb87 = 0;

  if(isDefined(self.primaryweaponobj) && !self hasweapon(self.primaryweaponobj)) {
    loadout_giveprimaryweapon(self.classstruct);
    var_e5c5201a787eeb87 = 1;
  }

  if(isDefined(self.secondaryweaponobj) && !self hasweapon(self.secondaryweaponobj)) {
    loadout_givesecondaryweapon(self.classstruct);
    var_e5c5201a787eeb87 = 1;
  }

  if(isDefined(self.tertiaryweaponobj) && !self hasweapon(self.tertiaryweaponobj)) {
    function_6927b3b638f60d97(self.classstruct);
    var_e5c5201a787eeb87 = 1;
  }

  if(var_e5c5201a787eeb87) {
    thread trackriotshield_monitorshieldattach();
  }
}

function loadout_giveprimaryweapon(struct, respawnitems, var_b86cf5cef6838543) {
  self.loadoutprimary = struct.loadoutprimary;
  self.loadoutprimarycamo = struct.loadoutprimarycamo;
  self.loadoutprimaryattachments = struct.loadoutprimaryattachments;
  self.loadoutprimaryattachmentids = struct.loadoutprimaryattachmentids;
  self.loadoutprimaryreticle = struct.loadoutprimaryreticle;
  self.loadoutprimarylootitemid = struct.loadoutprimarylootitemid;
  self.loadoutprimaryvariantid = struct.loadoutprimaryvariantid;
  var_3920d61392aec9d5 = loadout_giveweaponobj("primary", struct.loadoutprimaryobject, respawnitems, var_b86cf5cef6838543);
  self.primaryweapon = struct.loadoutprimaryfullname;
  self.primaryweaponobj = struct.loadoutprimaryobject;
  namespace_6b49ddb858f34366::function_adcb155953291ec7(1, 0);
  self.pers["primaryWeapon"] = struct.loadoutprimaryfullname;
  return var_3920d61392aec9d5;
}

function loadout_givesecondaryweapon(struct, respawnitems, var_b86cf5cef6838543) {
  self.loadoutsecondary = struct.loadoutsecondary;
  self.loadoutsecondarycamo = struct.loadoutsecondarycamo;
  self.loadoutsecondaryattachments = struct.loadoutsecondaryattachments;
  self.loadoutsecondaryattachmentids = struct.loadoutsecondaryattachmentids;
  self.loadoutsecondaryreticle = struct.loadoutsecondaryreticle;
  self.loadoutsecondarylootitemid = struct.loadoutsecondarylootitemid;
  self.loadoutsecondaryvariantid = struct.loadoutsecondaryvariantid;
  var_976a64288e459315 = loadout_giveweaponobj("secondary", struct.loadoutsecondaryobject, respawnitems, var_b86cf5cef6838543);
  self.secondaryweapon = struct.loadoutsecondaryfullname;
  self.secondaryweaponobj = struct.loadoutsecondaryobject;
  namespace_6b49ddb858f34366::function_adcb155953291ec7(0, 0);
  self.pers["secondaryWeapon"] = struct.loadoutsecondaryfullname;
  return var_976a64288e459315;
}

function function_6927b3b638f60d97(struct, respawnitems, var_b86cf5cef6838543) {
  self.loadouttertiary = struct.loadouttertiary;
  self.loadouttertiarycamo = struct.loadouttertiarycamo;
  self.var_494870a5978b5a09 = struct.var_494870a5978b5a09;
  self.var_6bfdc660c23f71ea = struct.var_6bfdc660c23f71ea;
  self.loadouttertiaryreticle = struct.loadouttertiaryreticle;
  self.var_64e57707d385a2f5 = struct.var_64e57707d385a2f5;
  self.loadouttertiaryvariantid = struct.loadouttertiaryvariantid;
  var_166a71f33928f623 = loadout_giveweaponobj("tertiary", struct.var_cc881f2bd3565d22, respawnitems, var_b86cf5cef6838543);
  self.tertiaryweapon = struct.var_e3f8e7ca9c87781f;
  self.tertiaryweaponobj = struct.var_cc881f2bd3565d22;
  self.pers["tertiaryWeapon"] = struct.var_e3f8e7ca9c87781f;

  if(!isundefinedweapon(var_166a71f33928f623) && getdvarint(@ "hash_547403d0bcc39f5") == 1) {
    self assignweaponmeleeslot(var_166a71f33928f623);
  }

  return var_166a71f33928f623;
}

function function_4ffce833ce15363c(struct) {
  if(istrue(struct.disablebackuppistol)) {
    return;
  }

  if(scripts\mp\gametypes\br_public::playeriszombie() || isDefined(self.var_e5520effcbe8bd30)) {
    return;
  }

  self giveweapon(struct.var_91e10e152b08ec1d, 0, 0, 0, 1, 1);
  thread function_d32d2baaa9465105(struct.var_91e10e152b08ec1d);
  thread function_6254bac9f9be9cf4(struct.var_91e10e152b08ec1d);
  thread function_1ca935941daaf046(struct.var_91e10e152b08ec1d);
}

function loadout_giveweaponobj(weaponslot, weaponobj, respawnitems, var_b86cf5cef6838543) {
  giveweaponobj = undefined;

  if(!istrue(var_b86cf5cef6838543)) {
    giveweaponobj = weaponobj;
  } else {
    giveweaponobj = respawnitems_getweaponobj(respawnitems, weaponslot);
  }

  if(!isundefinedweapon(giveweaponobj)) {
    if(function_38642db3c423bcdc(giveweaponobj) && !scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("infil_will_run")) {
      thread function_c6cd33220cce845a(weaponslot, weaponobj, respawnitems, var_b86cf5cef6838543);
    } else {
      giveweaponobj = scripts\mp\weapons::updatesavedaltstate(giveweaponobj);
      _giveweapon(giveweaponobj, undefined, undefined, 1);
      scripts\mp\weapons::updatetogglescopestate(giveweaponobj);
      scripts\mp\perks\weaponpassives::loadoutweapongiven(giveweaponobj);
    }
  }

  return giveweaponobj;
}

function function_c6cd33220cce845a(weaponslot, weaponobj, respawnitems, var_b86cf5cef6838543) {
  self endon("death_or_disconnect");
  self endon("swapLoadout");
  self endon("giveLoadout_start");
  level waittill("prematch_over");
  giveweaponobj = undefined;

  if(!istrue(var_b86cf5cef6838543)) {
    giveweaponobj = weaponobj;
  } else {
    giveweaponobj = respawnitems_getweaponobj(respawnitems, weaponslot);
  }

  if(!isundefinedweapon(giveweaponobj)) {
    giveweaponobj = scripts\mp\weapons::updatesavedaltstate(giveweaponobj);
    _giveweapon(giveweaponobj, undefined, undefined, 1);
    scripts\mp\weapons::updatetogglescopestate(giveweaponobj);
    scripts\mp\perks\weaponpassives::loadoutweapongiven(giveweaponobj);
  }

  if(weaponslot == "primary") {
    _switchtoweapon(giveweaponobj);
  }
}

function function_d792585d22273603(primaryweaponobj, secondaryweaponobj, respawnitems, var_b86cf5cef6838543) {
  self endon("death_or_disconnect");
  level waittill("prematch_over");
  loadout_updateammo(self.classstruct, primaryweaponobj, secondaryweaponobj, undefined, respawnitems, var_b86cf5cef6838543, level.magcount);
}

function function_9743c56a4d2dc135(struct) {
  if(struct.loadoutswimweapon != "none") {
    giveweaponobj = buildweapon(struct.loadoutswimweapon);
    self giveweapon(giveweaponobj);
  }

  self.swimweapon = struct.loadoutswimweapon;
}

function function_a80b77a2abaa376e(struct) {
  if(struct.loadoutClimbWeapon != "none") {
    giveweaponobj = buildweapon(struct.loadoutClimbWeapon);
    self giveweapon(giveweaponobj);
  }

  self.climbweapon = struct.loadoutClimbWeapon;
}

function function_607536857fac2407(struct) {
  if(struct.loadoutmeleeslot != "none") {
    giveweaponobj = buildweapon(struct.loadoutmeleeslot);
    self giveweapon(giveweaponobj);
    self assignweaponmeleeslot(giveweaponobj);
  }
}

function loadout_updateammo(struct, var_3920d61392aec9d5, var_976a64288e459315, var_166a71f33928f623, respawnitems, var_b86cf5cef6838543, var_10b09490bb78e90e) {
  loadoutweapons = [];
  altweaponnum = 0;

  if(isDefined(struct.loadoutprimaryobject) && struct.loadoutprimaryobject.basename != "none") {
    loadoutweapons[loadoutweapons.size] = struct.loadoutprimaryobject;
  }

  if(isDefined(struct.loadoutsecondaryobject) && struct.loadoutsecondaryobject.basename != "none") {
    loadoutweapons[loadoutweapons.size] = struct.loadoutsecondaryobject;
  }

  if(isDefined(struct.var_cc881f2bd3565d22) && struct.var_cc881f2bd3565d22.basename != "none") {
    loadoutweapons[loadoutweapons.size] = struct.var_cc881f2bd3565d22;
  }

  if(function_da27e3343b019fde() && isDefined(struct.var_91e10e152b08ec1d) && struct.var_91e10e152b08ec1d.basename != "none") {
    loadoutweapons[loadoutweapons.size] = struct.var_91e10e152b08ec1d;
  }

  if(isDefined(level.modeloadoutupdateammo)) {
    self[[level.modeloadoutupdateammo]](loadoutweapons);
  } else if(istrue(var_b86cf5cef6838543)) {
    respawnitems_giveweaponammo(respawnitems, "primary");
    respawnitems_giveweaponammo(respawnitems, "secondary");
    respawnitems_giveweaponammo(respawnitems, "tertiary");
  } else if(var_10b09490bb78e90e != 3) {
    if(isDefined(var_3920d61392aec9d5)) {
      spawnammocountoverride_giveweaponammo(var_3920d61392aec9d5, "primary", var_10b09490bb78e90e);
    }

    if(isDefined(var_976a64288e459315)) {
      spawnammocountoverride_giveweaponammo(var_976a64288e459315, "secondary", var_10b09490bb78e90e);
    }

    if(isDefined(var_166a71f33928f623)) {
      spawnammocountoverride_giveweaponammo(var_166a71f33928f623, "tertiary", var_10b09490bb78e90e);
    }
  } else {
    foreach(weapon in loadoutweapons) {
      if(getweaponhasperk(weapon, "specialty_extraclip")) {
        addstock = self getweaponammoclip(weapon);

        if(addstock < 6) {
          addstock = 6;
        }

        currentstock = self getweaponammostock(weapon);
        self setweaponammostock(weapon, currentstock + addstock);
      }
    }
  }

  if(!istrue(var_b86cf5cef6838543) && var_10b09490bb78e90e == 3) {
    foreach(weapon in loadoutweapons) {
      if(istrue(weapon.hasalternate)) {
        weaponaltobj = weapon getaltweapon();
        var_91093ef03654702c = weaponclass(weaponaltobj);

        if(var_91093ef03654702c == "grenade") {
          self setweaponammostock(weaponaltobj, 1);
        }

        continue;
      }

      if(isakimbo(weapon)) {
        self setweaponammostock(weapon, self getweaponammostock(weapon) + weaponclipsize(weapon) * 3);
      }
    }
  }
}

function loadout_updateweapondependentsettings() {
  scripts\mp\weapons::updatemovespeedscale();
}

function function_f94ec5ad05cc1001(classindex, isprimary) {
  class = scripts\mp\menus::getclasschoice(classindex);
  struct = loadout_getclassstruct();
  var_6b02e0d0b48f639a = function_72aa88e22948f6c5();
  loadout_updateclasscustom(struct, class, var_6b02e0d0b48f639a);
  loadout_updatehasnvg(struct);
  struct = loadout_validateclass(struct, class);

  if(isprimary) {
    struct.loadoutprimaryobject = buildweapon(struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue(struct.loadouthasnvg), struct.var_193bf3cfb8aeaf0f);
    return struct.loadoutprimaryobject;
  }

  struct.loadoutsecondaryobject = buildweapon(struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue(struct.loadouthasnvg), struct.var_ead3720e647f74a3);
  return struct.loadoutsecondaryobject;
}

function function_87c3b562f2b366ee(player) {
  perks = ["specialty_selectivehearing", "specialty_pistoldraw", "specialty_location_marking", "specialty_mantle_scale", "specialty_fastladderclimb"];

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    perks[perks.size] = "specialty_fall_damage_scale";
  }

  if(scripts\mp\utility\game::islaststandenabled()) {
    perks[perks.size] = "specialty_pistoldeath";
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap() && scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
    if(getdvarint(@ "hash_58735393383459d4", 1) == 1) {
      perks[perks.size] = "specialty_spygame";
    }
  }

  if(istrue(player.scorestreaktype)) {
    perks[perks.size] = "specialty_strategist";
  }

  if(istrue(level.var_7f3aafcf56c9ce14) && isDefined(player.var_4045f099f3da4bd)) {
    perks[perks.size] = scripts\mp\gametypes\br_pickups::function_77702c2321292aa3(player.var_4045f099f3da4bd);
  }

  if(istrue(level.var_1bc9ccb3f47cf947)) {
    perks[perks.size] = "specialty_br_movement_mod";
  }

  return perks;
}

function loadout_updateplayerperks(struct, class) {
  loadoutperks = struct.loadoutperks;
  var_15f3e6df722fb1cf = struct.var_15f3e6df722fb1cf;
  var_15f3e5df722faf9c = struct.var_15f3e5df722faf9c;
  loadoutstandardperks = scripts\mp\utility\stats::getpersstat("loadoutStandardPerks");
  loadoutextraperks = scripts\mp\utility\stats::getpersstat("loadoutExtraPerks");
  loadoutrigtrait = scripts\mp\utility\stats::getpersstat("loadoutRigTrait");
  loadoutusingspecialist = scripts\mp\utility\stats::getpersstat("loadoutUsingSpecialist");
  perkpackageprogress = scripts\mp\utility\stats::getpersstat("perkPackageProgress");
  perkpackagetier2earned = scripts\mp\utility\stats::getpersstat("perkPackageTier2Earned");
  perkpackagetier3state = scripts\mp\utility\stats::getpersstat("perkPackageTier3State");
  respawnitems = respawnitems_getrespawnitems();

  if(function_b19856925ddabd5a(respawnitems)) {
    loadoutperks = function_40a3148d5514ffa3(respawnitems);
    var_15f3e6df722fb1cf = function_dc2f8c385699a6e8(respawnitems);
    var_15f3e5df722faf9c = function_dc2f8d385699a91b(respawnitems);
    loadoutstandardperks = function_64d9f4542fdd7b14(respawnitems);
    loadoutextraperks = function_dc35cb143c497599(respawnitems);
    loadoutrigtrait = function_7f47875b5fd88f24(respawnitems);
    loadoutusingspecialist = function_eba2981fa45ae3bf(respawnitems);
    perkpackageprogress = function_33e44385e17eecc1(respawnitems);
    perkpackagetier2earned = function_7af26fc564e26a5f(respawnitems);
    perkpackagetier3state = function_7d2ba1e36afe24b0(respawnitems);
  } else {
    defaultperks = function_87c3b562f2b366ee(self);

    foreach(perk in defaultperks) {
      loadout_giveperk(perk);
    }
  }

  if(!isDefined(class) || class != "juggernaut") {
    if(isDefined(loadoutperks) && loadoutperks.size > 0) {
      var_4699b9f7e9066068 = function_834af98b3970133b(struct);

      if(istrue(var_4699b9f7e9066068)) {
        scripts\mp\perks\perks::giveperks(struct.loadoutperks);
      } else {
        scripts\mp\perks\perks::giveperks(loadoutperks);
      }

      if(!istrue(level.var_606eb45e074ff204) && function_ea4c5dc15c3bbdd9()) {
        scripts\mp\perks\perks::giveperks(loadoutextraperks);
      } else {
        scripts\mp\perks\perks::function_4613ec15f87b7cf2(var_15f3e6df722fb1cf, var_15f3e5df722faf9c);
      }

      if(getdvarint(@ "scr_test_loadouts", 0)) {
        if(!istrue(level.var_606eb45e074ff204) && function_ea4c5dc15c3bbdd9()) {
          scripts\mp\perks\perks::giveperks(struct.loadoutextraperks);
        }

        self.shooting_mode = "1st";

        foreach(perk in loadoutperks) {
          if(perk == "specialty_third_person") {
            self.shooting_mode = "3rd";
          }
        }

        self.pers["shootingMode"] = self.shooting_mode;
      }
    }

    if(istrue(level.var_606eb45e074ff204)) {
      if(istrue(perkpackagetier2earned) && isDefined(var_15f3e6df722fb1cf) && (!isDefined(loadoutperks) || !array_contains(loadoutperks, var_15f3e6df722fb1cf))) {
        scripts\mp\utility\perk::giveperk(var_15f3e6df722fb1cf);
      }

      if(isDefined(perkpackagetier3state) && isDefined(var_15f3e5df722faf9c) && perkpackagetier3state >= 2 && (!isDefined(loadoutperks) || !array_contains(loadoutperks, var_15f3e5df722faf9c))) {
        scripts\mp\utility\perk::giveperk(var_15f3e5df722faf9c);
      }
    }

    self.pers["loadoutPerks"] = loadoutperks;
    self.pers["loadoutStandardPerks"] = loadoutstandardperks;
    self.pers["loadoutExtraPerks"] = loadoutextraperks;
    self.pers["loadoutRigTrait"] = loadoutrigtrait;
    self.pers["loadoutUsingSpecialist"] = loadoutusingspecialist;

    if(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0) {
      thread scripts\mp\perks\perks::giveperksafterspawn();
    }

    if(!isagent(self) && scripts\mp\utility\dvars::getintproperty(@ "scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {
      perksarray = isDefined(loadoutperks) ? loadoutperks : [];
      var_9e0a050f0398edc3 = isDefined(loadoutextraperks) ? loadoutextraperks : [];

      if(istrue(level.var_606eb45e074ff204) || istrue(level.var_9a849908e60b857c)) {
        perksarray[perksarray.size] = var_15f3e6df722fb1cf;
        perksarray[perksarray.size] = var_15f3e5df722faf9c;
      }

      scripts\mp\perks\perks::function_7c8cc44b58093ce4(perksarray);
      scripts\mp\perks\perks::setomnvarsforperklist("ui_spawn_perk_", perksarray, var_9e0a050f0398edc3);
    }
  }

  if(getdvarint(@ "hash_6a4d5cd30c97a609", 0)) {
    logstring("\n PERKS BUG LOGGING - After update, player has " + self.perks.size + " perks.");

    foreach(idx, perk in self.perks) {
      logstring("\n" + idx);
    }
  }

  function_dc63eafe3f6318df();
}

function function_834af98b3970133b(struct) {
  vestperk = function_5d4e4fb280574542(struct);

  if(isDefined(vestperk)) {
    var_756aa31d4082215 = function_2ab1572c5a4fce7c(vestperk);

    if(!isDefined(var_756aa31d4082215)) {
      return 0;
    }

    if(!isarray(var_756aa31d4082215)) {
      var_756aa31d4082215 = [var_756aa31d4082215];
    }

    var_4699b9f7e9066068 = 0;

    foreach(dupe in var_756aa31d4082215) {
      foreach(perk in struct.loadoutperks) {
        if(perk == dupe) {
          var_354edb08b70e0e56 = function_cd922f6a30d9f3e8(vestperk, dupe, struct);
          var_4699b9f7e9066068 = var_354edb08b70e0e56 || var_4699b9f7e9066068;
        }
      }
    }

    return var_4699b9f7e9066068;
  }
}

function function_5d4e4fb280574542(struct) {
  var_ff08a8d642ef2d44 = ["specialty_infantry_vest", "specialty_grenadier_vest", "specialty_cct_vest", "specialty_overkill_vest", "specialty_tac_vest", "specialty_gunner_vest", "specialty_scout_vest", "specialty_marksman_vest", "specialty_ninja_vest", "specialty_compression_carrier_vest", "specialty_rhino_rig", "specialty_pistol_vest", "specialty_combined_arms_vest", "specialty_infantry_vest_ranked"];

  foreach(perk in struct.loadoutperks) {
    if(array_contains(var_ff08a8d642ef2d44, perk)) {
      return perk;
    }
  }

  foreach(perk in struct.loadoutextraperks) {
    if(array_contains(var_ff08a8d642ef2d44, perk)) {
      return perk;
    }
  }

  return undefined;
}

function function_2ab1572c5a4fce7c(vestperk) {
  switch (vestperk) {
    case #"hash_568523fdd9886154":
    case #"hash_d492f15f3873725a":
      return "specialty_running_sneakers";
    case #"hash_2fbe6bc056549a68":
      return undefined;
    case #"hash_c1dfdb4041d59e89":
      return "specialty_intel_jacker";
    case #"hash_522bef19e9286b39":
      return ["specialty_custom_gloves", "specialty_silicon_gloves"];
    case #"hash_82a9f5a3ce609b36":
      return "specialty_fast_reload";
    case #"hash_39fbb731f952e175":
      return "specialty_ghost_camo";
    case #"hash_24af5eb2e03b90bd":
      return "specialty_marksman_gloves";
    case #"hash_ceead0eadcdc2887":
      return ["specialty_canvas_sneakers", "specialty_dauntless_boots"];
    case #"hash_c474ef13b42188e8":
      return ["specialty_compression_plate", "specialty_tac_mask"];
    case #"hash_f0ce2815ea1b92db":
      return undefined;
    case #"hash_6bbf74cf8705b69a":
      return ["specialty_custom_gloves", "specialty_silicon_gloves", "specialty_fast_reload"];
    case #"hash_d3a49b6afca4c8ce":
      return "specialty_hardline";
  }

  return undefined;
}

function function_cd922f6a30d9f3e8(vestperk, var_756aa31d4082215, struct) {
  newperk = undefined;

  switch (vestperk) {
    case #"hash_568523fdd9886154":
    case #"hash_d492f15f3873725a":
      newperk = "specialty_ultra_light_boots";
      break;
    case #"hash_c1dfdb4041d59e89":
      newperk = "specialty_hardline";
      break;
    case #"hash_522bef19e9286b39":
      newperk = "specialty_marksman_gloves";
      break;
    case #"hash_82a9f5a3ce609b36":
      newperk = "specialty_hardline";
      break;
    case #"hash_39fbb731f952e175":
      newperk = "specialty_covert_ops";
      break;
    case #"hash_24af5eb2e03b90bd":
      newperk = "specialty_custom_gloves";
      break;
    case #"hash_ceead0eadcdc2887":
      newperk = "specialty_running_sneakers";
      break;
    case #"hash_c474ef13b42188e8":
      newperk = "specialty_eod_vest";
      break;
    case #"hash_d3a49b6afca4c8ce":
      newperk = "specialty_high_gain_antenna";
      break;
  }

  if(vestperk == "specialty_tac_vest" && (array_contains(struct.loadoutperks, "specialty_hardline") || array_contains(struct.loadoutextraperks, "specialty_hardline"))) {
    newperk = "specialty_tac_mask";
  }

  if(vestperk == "specialty_pistol_vest") {
    if(var_756aa31d4082215 == "specialty_custom_gloves" || var_756aa31d4082215 == "specialty_silicon_gloves") {
      newperk = "specialty_marksman_gloves";
    } else if(var_756aa31d4082215 == "specialty_fast_reload") {
      newperk = "specialty_hardline";
    }
  }

  key = array_find(struct.loadoutperks, var_756aa31d4082215);

  if(isDefined(key)) {
    struct.loadoutperks[key] = newperk;
    return true;
  } else {
    key = array_find(struct.loadoutextraperks, var_756aa31d4082215);

    if(isDefined(key)) {
      struct.loadoutextraperks[key] = newperk;
      return true;
    }
  }

  return false;
}

function function_dc63eafe3f6318df() {
  if(!isDefined(level.var_41cf8d43ac1cd207)) {
    return;
  }

  var_329ba2d003b49f7 = [];

  foreach(perkname, perk in self.perks) {
    foreach(var_f7887a5764a7d38c in level.var_41cf8d43ac1cd207) {
      bundle = level.perkbundles[perkname];

      if(!isDefined(bundle) || !isDefined(bundle.var_8bf15bcb91a06389)) {
        continue;
      }

      if(bundle.var_8bf15bcb91a06389 == var_f7887a5764a7d38c.playstyle) {
        if(!isDefined(var_329ba2d003b49f7[var_f7887a5764a7d38c.playstyle])) {
          countdata = spawnStruct();
          countdata.var_f7887a5764a7d38c = var_f7887a5764a7d38c;
          countdata.ctr = 1;
          var_329ba2d003b49f7[var_f7887a5764a7d38c.playstyle] = countdata;
          continue;
        }

        if(!istrue(var_329ba2d003b49f7[var_f7887a5764a7d38c.playstyle].isgiven)) {
          var_329ba2d003b49f7[var_f7887a5764a7d38c.playstyle].ctr++;

          if(var_329ba2d003b49f7[var_f7887a5764a7d38c.playstyle].ctr == var_f7887a5764a7d38c.var_1a254f1dc28ba4ad) {
            bonusperk = level.var_f54c174ff247a969[var_f7887a5764a7d38c.bundle];
            assert(isDefined(bonusperk));

            if(isDefined(bonusperk)) {
              loadout_giveperk(bonusperk);
            }

            var_329ba2d003b49f7[var_f7887a5764a7d38c.playstyle].isgiven = 1;
          }
        }
      }
    }
  }
}

function loadout_updateplayerequipment(struct, class) {
  respawnitems = respawnitems_getrespawnitems();
  var_b86cf5cef6838543 = respawnitems_hasequipmentdata(respawnitems);
  self.loadoutequipmentprimary = struct.loadoutequipmentprimary;
  self.loadoutequipmentsecondary = struct.loadoutequipmentsecondary;
  var_e7d8e765ac9243a6 = undefined;

  if(!var_b86cf5cef6838543) {
    var_e7d8e765ac9243a6 = struct.loadoutequipmentprimary;
  } else {
    var_e7d8e765ac9243a6 = respawnitems_getequipmentref(respawnitems, "primary");
  }

  var_6dc747a4410e0395 = struct.var_b68e3a0a9c628d23;
  var_604669419e2560e6 = undefined;

  if(!var_b86cf5cef6838543) {
    var_604669419e2560e6 = struct.loadoutequipmentsecondary;
  } else {
    var_604669419e2560e6 = respawnitems_getequipmentref(respawnitems, "secondary");
  }

  var_6e8f0546b97c1dd5 = struct.var_a1dfc5ce15795a3;
  scripts\mp\equipment::giveequipment(var_e7d8e765ac9243a6, "primary", class, var_6dc747a4410e0395);
  scripts\mp\equipment::giveequipment(var_604669419e2560e6, "secondary", class, var_6e8f0546b97c1dd5);

  if(_hasperk("specialty_extra_tactical")) {
    scripts\mp\equipment::incrementequipmentammo(var_604669419e2560e6);
  }

  classtype = loadout_getclasstype(class);
  var_1bc3bf54ae8e6ed7 = equipment::function_11a4d197e8db4f(classtype);
  var_20327dd6b8d19acf = equipment::function_58ea099b568dbfaf(classtype);

  if(var_1bc3bf54ae8e6ed7) {
    scripts\mp\equipment::incrementequipmentammo(var_e7d8e765ac9243a6, undefined, class);
  }

  if(var_20327dd6b8d19acf) {
    scripts\mp\equipment::incrementequipmentammo(var_604669419e2560e6, undefined, class);
  }

  if(var_b86cf5cef6838543) {
    respawnitems_giveequipmentammo(respawnitems, "primary");
    respawnitems_giveequipmentammo(respawnitems, "secondary");
  }

  if(scripts\mp\equipment\nvg::function_258c5e445c8b7f80()) {
    thread scripts\mp\equipment\nvg::runnvg();
    thread loadout_updateplayernvgs();
  }
}

function loadout_updateplayernvgs() {
  self endon("death_or_disconnect");
  self notify("loadout_updatePlayerNVGs");
  self endon("loadout_updatePlayerNVGs");
  apply = 0;

  if(game["roundsPlayed"] == 0 && !istrue(self.hasspawned) && (scripts\cp_mp\utility\game_utility::isnightmap() || getdvarint(@ "hash_68a323d5bd07266c", 0) == 1)) {
    if(!gameflag("infil_will_run") || gameflag("infil_started")) {
      apply = 1;
    }
  } else if(istrue(self.pers["useNVG"])) {
    apply = 1;
  }

  if(istrue(self.inspawncamera)) {
    waittill_any_2("spawned_player", "fadeUp_start");
  }

  while(!isDefined(self.operatorcustomization)) {
    waitframe();
  }

  if(apply) {
    self nightvisionviewon(1);
  }

  scripts\mp\equipment\nvg::nvg_update3rdperson(apply);
}

function loadout_updateplayersuper(struct) {
  var_3ee5f90ec4d78460 = struct.loadoutsuper;
  respawnitems = respawnitems_getrespawnitems();
  var_b86cf5cef6838543 = respawnitems_hassuperdata(respawnitems);

  if(var_b86cf5cef6838543) {
    var_3ee5f90ec4d78460 = respawnitems_getsuperref(respawnitems);
  }

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    currentsuper = scripts\mp\supers::getcurrentsuperref();

    if(currentsuper == var_3ee5f90ec4d78460 && !haschangedarchetype()) {
      scripts\mp\supers::givesuperweapon(self.super);
      return;
    }
  }

  if(var_3ee5f90ec4d78460 == "none" || !level.allowsupers) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
    return;
  }

  if(level.allowsupers && isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["loadoutSuper"])) {
    self.loadoutsuper = self.pers["gamemodeLoadout"]["loadoutSuper"];
    scripts\mp\supers::givesuper(self.loadoutsuper, 1);
    return;
  }

  self.loadoutsuper = struct.loadoutsuper;
  scripts\mp\supers::givesuper(var_3ee5f90ec4d78460, 1);

  if(var_b86cf5cef6838543) {
    scripts\mp\supers::setsuperbasepoints(respawnitems_getsuperpoints(respawnitems));
    scripts\mp\supers::setsuperextrapoints(respawnitems_getsuperextrapoints(respawnitems));
  }
}

function loadout_updateplayergesture(struct) {
  if(!istrue(self.btestclient)) {
    if(struct.loadoutgesture != "none") {
      self.loadoutgesture = struct.loadoutgesture;
      scripts\cp_mp\gestures::givegesture(struct.loadoutgesture);
    }
  }
}

function loadout_updateplayeraccessory(struct) {
  if(!istrue(self.btestclient)) {
    if(isDefined(struct.loadoutaccessoryweapon) && struct.loadoutaccessoryweapon != "none") {
      self.loadoutaccessorydata = struct.loadoutaccessorydata;
      self.loadoutaccessoryweapon = struct.loadoutaccessoryweapon;
      scripts\mp\accessories::giveplayeraccessory(struct.loadoutaccessorydata, struct.loadoutaccessoryweapon, struct.loadoutaccessorylogic);
    }
  }
}

function loadout_updateplayerstreaktype(struct) {
  self.streaktype = loadout_getplayerstreaktype(struct.loadoutstreaktype);
  var_7f10159f1efb1ca8 = isDefined(level.gametypebundle) && istrue(level.gametypebundle.var_b0455df76d97746a);

  if(isDefined(level.gametype) && !scripts\cp_mp\utility\game_utility::isbrstylegametype() && !var_7f10159f1efb1ca8) {
    isscorestreaktype = self getplayerdata(level.loadoutdata, "squadMembers", "scoreStreak");

    if(!istrue(isscorestreaktype)) {
      debugscorestreak = getdvarint(@ "hash_6644f43939a024", 0);
      isscorestreaktype = debugscorestreak;
    }

    self.scorestreaktype = istrue(isscorestreaktype);
  }
}

function function_3793a6c73d46459f(struct, streakname) {
  blueprintindex = 0;

  if(streakname == struct.loadoutkillstreak1) {
    blueprintindex = struct.var_70f190143fb74941;
  } else if(streakname == struct.loadoutkillstreak2) {
    blueprintindex = struct.var_2b902dfc607c8860;
  } else if(streakname == struct.loadoutkillstreak3) {
    blueprintindex = struct.var_7e3e3c6aebc4618f;
  }

  return blueprintindex;
}

function loadout_updateplayerkillstreaks(struct, class) {
  if(level.gamemodebundle.streakearn == #"score") {
    scripts\mp\utility\perk::giveperk("specialty_killstreak_to_scorestreak");
  }

  if(!level.allowkillstreaks) {
    struct.loadoutkillstreak1 = "none";
    struct.loadoutkillstreak2 = "none";
    struct.loadoutkillstreak3 = "none";
    struct.var_70f190143fb74941 = 0;
    struct.var_2b902dfc607c8860 = 0;
    struct.var_7e3e3c6aebc4618f = 0;
  }

  if(struct.loadoutstreaksfilled == 0 && isDefined(self.streakdata) && self.streakdata.streaks.size > 0 && class == "gamemode") {
    collected = 0;

    foreach(killstreak in self.streakdata.streaks) {
      if(collected == 0) {
        struct.loadoutkillstreak1 = killstreak.streakname;
        struct.var_70f190143fb74941 = 0;
        collected++;
        continue;
      }

      if(collected == 1) {
        struct.loadoutkillstreak2 = killstreak.streakname;
        struct.var_2b902dfc607c8860 = 0;
        collected++;
        continue;
      }

      if(collected == 2) {
        struct.loadoutkillstreak3 = killstreak.streakname;
        struct.var_7e3e3c6aebc4618f = 0;
        break;
      }
    }
  }

  var_66383c9fdf2d18c4 = [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];

  if(level.allowkillstreaks) {
    self.pers["hackedStreaks"] = 0;
    var_66383c9fdf2d18c4 = [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];
  }

  self.loadoutusingspecialist = ter_op(istrue(level.var_606eb45e074ff204), 0, struct.loadoutusingspecialist);

  if(!istrue(level.var_606eb45e074ff204) && struct.loadoutusingspecialist && level.allowkillstreaks) {
    var_66383c9fdf2d18c4 = replacewithspecialistkillstreaks(struct);
  }

  respawnitems = respawnitems_getrespawnitems();
  var_b86cf5cef6838543 = respawnitems_hasstreakdata(respawnitems);

  if(var_b86cf5cef6838543 && level.allowkillstreaks) {
    var_66383c9fdf2d18c4 = respawnitems_getstreaks(respawnitems);
  }

  if(level.allowkillstreaks) {
    var_66383c9fdf2d18c4 = sortkillstreaksbycost(var_66383c9fdf2d18c4);
  }

  if(!isagent(self)) {
    var_92bbbe3246f6a87b = scripts\mp\killstreaks\killstreaks::arekillstreaksequipped(var_66383c9fdf2d18c4);

    if(!var_92bbbe3246f6a87b) {
      self notify("givingLoadout");
      var_8d31993278c0bbe1 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();
      earnedkillstreaks = scripts\mp\killstreaks\killstreaks::getavailableequippedkillstreakstructs();

      if(!_hasperk("specialty_support_killstreaks") && !isDefined(self.earnedmaxkillstreak)) {
        scripts\mp\killstreaks\killstreaks::clearkillstreaks();
      }

      for(streakindex = 0; streakindex < var_66383c9fdf2d18c4.size; streakindex++) {
        streak = var_66383c9fdf2d18c4[streakindex];

        if(isDefined(streak) && streak != "none" && streak != "") {
          scripts\mp\killstreaks\killstreaks::equipkillstreak(streak, streakindex + 1, function_3793a6c73d46459f(struct, streak));
        }
      }

      for(structindex = var_8d31993278c0bbe1.size - 1; structindex >= 0; structindex--) {
        streak = var_8d31993278c0bbe1[structindex];

        if(!streak.isspecialist) {
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var_8d31993278c0bbe1[structindex], "other");
        }
      }

      for(structindex = 0; structindex < earnedkillstreaks.size; structindex++) {
        streak = earnedkillstreaks[structindex];

        if(!streak.isspecialist) {
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(earnedkillstreaks[structindex], "other");
        }
      }
    }
  }

  self notify("equipKillstreaksFinished");
}

function sortkillstreaksbycost(streaklist) {
  for(i = 0; i < streaklist.size - 1; i++) {
    if(isDefined(streaklist[i]) && streaklist[i] != "none" && streaklist[i] != "") {
      for(j = i + 1; j < streaklist.size; j++) {
        if(isDefined(streaklist[j]) && streaklist[j] != "none" && streaklist[j] != "") {
          currentcost = scripts\mp\killstreaks\killstreaks::calcstreakcost(streaklist[i]);
          nextcost = scripts\mp\killstreaks\killstreaks::calcstreakcost(streaklist[j]);

          if(nextcost < currentcost) {
            ref = streaklist[j];
            streaklist[j] = streaklist[i];
            streaklist[i] = ref;
          }
        }
      }
    }
  }

  return streaklist;
}

function loadout_updateplayeractionslots(struct, class) {
  self setactionslot(3, "altmode");
}

function loadout_updatefieldupgrades(struct, class) {
  if(class == "juggernaut" || class == "superpower") {
    return;
  }

  respawnitems = respawnitems_getrespawnitems();

  if(respawnitems_hassuperdata(respawnitems)) {
    [self.loadoutfieldupgrade1, self.loadoutfieldupgrade2] = function_2f17741f5c15a7d6(respawnitems);
  } else {
    self.loadoutfieldupgrade1 = struct.loadoutfieldupgrade1;
    self.var_4c4f03fa00925daf = struct.var_4c4f03fa00925daf;
    self.loadoutfieldupgrade2 = struct.loadoutfieldupgrade2;
    self.var_2907f1614fe4e5f2 = struct.var_39aa4db252bf8db2;
  }

  if(superisrestricted(self.loadoutfieldupgrade1)) {
    self.loadoutfieldupgrade1 = "super_deadsilence";
    var_4c4f03fa00925daf = 0;
  }

  if(superisrestricted(self.loadoutfieldupgrade2)) {
    self.loadoutfieldupgrade2 = "super_deadsilence";
    self.var_2907f1614fe4e5f2 = 0;
  }

  if(isanymlgmatch() || self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2) {
    self.loadoutfieldupgrade2 = "none";
    var_2907f1614fe4e5f2 = 0;
  }

  if(level.allowsupers) {
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(mapname, "mp_m_") && mapname != "mp_m_speed") {
      self.loadoutfieldupgrade1 = function_15da17f6ac6380af(self.loadoutfieldupgrade1);
      self.loadoutfieldupgrade2 = function_15da17f6ac6380af(self.loadoutfieldupgrade2);

      if(self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2) {
        self.loadoutfieldupgrade2 = "none";
        self.var_2907f1614fe4e5f2 = 0;
      }
    }

    thread scripts\mp\supers::watchplayersuperdelayweapon();
    thread scripts\mp\perks\perkpackage::perkpackage_initperkpackages();

    if(!istrue(level.var_4b56eabbc77bfd21) && (scripts\cp_mp\utility\game_utility::isbrstylegametype() || getgametype() == "gwai")) {
      super = fixsuperforbr(self.loadoutfieldupgrade1);

      if(isDefined(level.forcegivesuper)) {
        self[[level.forcegivesuper]](super);
      }
    }
  } else if(!istrue(level.var_4b56eabbc77bfd21) && scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.loadoutbrfieldupgrade = fixsuperforbr(self.loadoutfieldupgrade1);
    self.loadoutfieldupgrade1 = "none";
    self.var_4c4f03fa00925daf = 0;
    self.loadoutfieldupgrade2 = "none";
    self.var_2907f1614fe4e5f2 = 0;

    if(getdvarint(@ "hash_52994f8fc649c87a", 0) == 0) {
      scripts\mp\perks\perkpackage::perkpackage_initpersdata();
    }

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() && isDefined(level.forcegivesuper)) {
      self[[level.forcegivesuper]](self.loadoutbrfieldupgrade);
    }
  }

  if(self.loadoutfieldupgrade1 != "super_emp_pulse" && self.loadoutfieldupgrade2 != "super_emp_pulse") {
    scripts\mp\supers\super_emp_pulse::function_75baa17a54260f6f(0);
  }
}

function fixsuperforbr(superref) {
  if(!istrue(level.var_d040719163e20394) && !isDefined(superref)) {
    return "super_ammo_drop";
  }

  var_55319c52de1e69f5 = !scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() || getsubgametype() == "rumble_mgl";

  if(superref == "none" && var_55319c52de1e69f5 && !namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    return "super_ammo_drop";
  }

  return superref;
}

function function_15da17f6ac6380af(var_fed7b85886638423) {
  switch (var_fed7b85886638423) {
    case #"hash_699e6c3e460adde4":
    case #"hash_7266a252f51150e9":
    case #"hash_ac520bae8aaba66b":
      var_fed7b85886638423 = "super_ammo_drop";
      break;
    default:
      break;
  }

  return var_fed7b85886638423;
}

function loadout_updateplayer(globalstruct, struct, class, setspawnweap, skipfirstraise) {
  loadout_updateplayerstreaktype(struct);
  loadout_updateplayerarchetype(struct);

  if(!istrue(level.noweaponsonstart)) {
    loadout_updateplayerweapons(struct, class, setspawnweap, skipfirstraise);
  }

  loadout_updateplayerperks(struct, class);

  if(!istrue(level.noweaponsonstart)) {
    loadout_updateplayerequipment(struct, class);
  }

  if(!istrue(game["isLaunchChunk"]) && !scripts\cp_mp\utility\game_utility::isbrstylegametype() && !(isDefined(level.gametypebundle) && istrue(level.gametypebundle.var_71b7ca11bb26d366))) {
    loadout_updateplayerkillstreaks(struct, class);
  }

  loadout_updateplayeractionslots(struct, class);

  if(!istrue(game["isLaunchChunk"])) {
    loadout_updatefieldupgrades(struct, class);
  }

  self.pers["lastClass"] = self.class;
  self.lastclass = self.class;
  self.lastarchetypeinfo = self.changedarchetypeinfo;

  if(isDefined(self.gamemode_chosenclass)) {
    self.pers["class"] = self.gamemode_chosenclass;
    self.pers["lastClass"] = self.gamemode_chosenclass;
    self.class = self.gamemode_chosenclass;
    self.lastclass = self.gamemode_chosenclass;
    self.gamemode_chosenclass = undefined;
  }

  if(isDefined(self.revive_chosenclass)) {
    self.pers["class"] = self.revive_chosenclass;
    self.pers["lastClass"] = self.revive_chosenclass;
    self.class = self.revive_chosenclass;
    self.lastclass = self.revive_chosenclass;
  }

  scripts\mp\teams::setupplayermodel();
  setthirdpersonview();
  loadout_updateplayeraccessory(struct);

  if(issharedfuncdefined("instanceInventory", "updateInstanceInventoryFromDefault")) {
    [[getsharedfunc("instanceInventory", "updateInstanceInventoryFromDefault")]](self);
  }
}

function setmlgspectatorclientloadoutdata(player, struct) {
  if(isagent(player)) {
    return;
  }

  player endon("disconnect");
  player notify("setMLGSpectatorClientLoadoutData()");
  player endon("setMLGSpectatorClientLoadoutData()");
  player setclientweaponinfo(0, struct.loadoutprimaryfullname);
  player setclientweaponinfo(1, struct.loadoutsecondaryfullname);

  if(isDefined(self.equipment["primary"])) {
    var_9da2f83262bca52f = scripts\mp\equipment::getequipmenttableinfo(self.equipment["primary"]);

    if(isDefined(var_9da2f83262bca52f)) {
      player setclientloadoutinfo("primaryPower", var_9da2f83262bca52f.id);
    }
  } else {
    player setclientloadoutinfo("primaryPower", 0);
  }

  if(isDefined(self.equipment["secondary"])) {
    var_ef8ce378a3dc072b = scripts\mp\equipment::getequipmenttableinfo(self.equipment["secondary"]);

    if(isDefined(var_ef8ce378a3dc072b)) {
      player setclientloadoutinfo("secondaryPower", var_ef8ce378a3dc072b.id);
    }
  } else {
    player setclientloadoutinfo("secondaryPower", 0);
  }

  player setclientloadoutinfo("fieldUpgrade", scripts\mp\supers::getsuperid(self.loadoutfieldupgrade1));
  var_c59e88d893128017 = scripts\mp\supers::getsuperid(struct.loadoutsuper);
  player setclientloadoutinfo("super", var_c59e88d893128017);

  if(isai(player)) {
    for(perkindex = 0; perkindex < struct.loadoutperks.size; perkindex++) {
      perk = struct.loadoutperks[perkindex];
      perkid = scripts\mp\perks\perks::getperkid(perk);
      player setclientloadoutinfo(perkindex + 1 + "_perk", perkid);
    }
  } else {
    if(struct.loadoutperksfromgamemode) {
      struct.loadoutstandardperks = struct.loadoutperks;
    }

    for(perkindex = 0; perkindex < self.pers["loadoutPerks"].size; perkindex++) {
      perk = self.pers["loadoutPerks"][perkindex];
      perkid = scripts\mp\perks\perks::getperkid(perk);
      player setclientloadoutinfo(perkindex + 1 + "_perk", perkid);
    }

    for(perkindex = 0; perkindex < struct.loadoutextraperks.size; perkindex++) {
      perk = struct.loadoutextraperks[perkindex];
      perkid = scripts\mp\perks\perks::getperkid(perk);
      player setclientloadoutinfo(perkindex + 1 + "_extraPerk", perkid);
    }
  }

  rigtrait = struct.loadoutrigtrait;
  var_cadb7e2a87892576 = scripts\mp\perks\perks::getperkid(rigtrait);
  player setclientloadoutinfo("rigTrait", var_cadb7e2a87892576);
  archetypeindex = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(struct.loadoutarchetype);
  player setclientloadoutinfo("archetype", archetypeindex);
}

function shouldallowinstantclassswap(error) {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    disableclassswapallowed();
  }

  if(isjuggermoshgamemode()) {
    return 0;
  }

  if(!isDefined(self.instantclassswapallowed)) {
    return 1;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\gamelogic::inprematch()) {
    return 0;
  }

  if(scripts\mp\utility\game::ismutationgamemodezombie()) {
    self iprintlnbold(game["strings"]["change_class"]);
    return 0;
  }

  if(!self.instantclassswapallowed) {
    if(isDefined(self.var_b19b4be400b7ac35)) {
      timepassed = (gettime() - self.var_b19b4be400b7ac35) / 1000;
      var_82fba1954144c48 = getdvarfloat(@ "hash_ea52d059e79ddfbf", 10);
      println("<dev string:x365>" + timepassed + "<dev string:x398>" + var_82fba1954144c48);

      if(isDefined(error)) {
        error.string = "MP/CHANGE_CLASS_COOLDOWN_COMBAT";
        error.param = int(var_82fba1954144c48 - timepassed);
      }

      return time_has_passed(self.var_b19b4be400b7ac35, var_82fba1954144c48);
    }

    if(isDefined(error)) {
      error.string = "MP/CHANGE_CLASS_NEXT_SPAWN";
    }

    return 0;
  }

  return 1;
}

function swaploadout() {
  if(ent_flag_exist("swapLoadout_blocked") && ent_flag("swapLoadout_blocked")) {
    self endon("death_or_disconnect");
    self endon("joined_team");
    self endon("joined_spectators");
    self notify("swapLoadout");
    self endon("swapLoadout");

    if(!ent_flag("swapLoadout_pending")) {
      ent_flag_set("swapLoadout_pending");
    }

    self waittill("swapLoadout_blocked");
  }

  scripts\mp\class::setclass(self.pers["class"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(allowclasschoice()) {
    scripts\mp\utility\stats::incpersstat("classChanges", 1);
  }

  scripts\mp\class::giveloadout(self.pers["team"], self.pers["class"], undefined, 1);

  if(isakimbo(self.primaryweaponobj) || isakimbo(self.secondaryweaponobj)) {
    if(!scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("infil_will_run")) {
      respawnitems = respawnitems_getrespawnitems();
      var_b86cf5cef6838543 = respawnitems_hasweapondata(respawnitems);
      thread function_d792585d22273603(self.primaryweaponobj, self.secondaryweaponobj, respawnitems, var_b86cf5cef6838543);
    }
  }

  var_2b89ca43cac539d8 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_done");

  if(var_2b89ca43cac539d8 && isDefined(level.var_b89a535236a6f3d8) && !istrue(level.var_8281a47e2cecb257)) {
    self[[level.var_b89a535236a6f3d8]]();
  }

  if(ent_flag_exist("swapLoadout_pending") && ent_flag("swapLoadout_pending")) {
    ent_flag_clear("swapLoadout_pending");
    ent_flag_set("swapLoadout_complete");
  }
}

function function_a1c8aa2264227d22(class) {
  if(isbot(self)) {
    var_61f5d15d65ccb2ba = getdvarint(@ "hash_3b22f26edfbc398", 0);

    if(var_61f5d15d65ccb2ba > 0) {
      class = "<dev string:x3a9>" + var_61f5d15d65ccb2ba;
      self.preloadedclassstruct = undefined;
    }
  }

  return class;
}

function giveloadout(team, class, setspawnweap, var_bea1f8064eda3de9, skipfirstraise, var_f15fdb6dca506606) {
  self notify("giveLoadout_start");
  self.gettingloadout = 1;

  if(getdvarint(@ "hash_6a4d5cd30c97a609", 0)) {
    assertmsg("<dev string:x3b4>" + class);
    logstring("\n Player already has " + self.perks.size + " perks.");

    foreach(idx, perk in self.perks) {
      logstring("\n" + idx);
    }
  }

  if(isDefined(self.perks)) {
    self.oldperks = self.perks;
  }

  var_99ef88e44462109e = self.attached_bag;
  loadout_clearplayer(var_bea1f8064eda3de9);

  class = function_a1c8aa2264227d22(class);

  globalstruct = loadout_getglobalclassstruct();
  globalstruct = loadout_updateglobalclass(globalstruct, class);
  self.globalstruct = globalstruct;
  struct = undefined;

  if(isDefined(self.preloadedclassstruct)) {
    struct = self.preloadedclassstruct;
    self.preloadedclassstruct = undefined;
    self.class_num = getclassindex(class);
  } else {
    struct = loadout_getclassstruct();
    struct = loadout_updateclass(struct, class);
  }

  self.classstruct = struct;
  loadout_updateplayer(globalstruct, struct, class, setspawnweap, skipfirstraise);

  if(class != "juggernaut" || class != "superpower") {
    function_200c71e93799b32f(struct);

    if(gameflag("prematch_done")) {
      loadout_lognewlygivenloadout(globalstruct, struct, class);
    }
  }

  self.gettingloadout = 0;

  if(isDefined(var_99ef88e44462109e) && istrue(var_f15fdb6dca506606)) {
    scripts\mp\gametypes\br_gametype_dmz::attachbag(var_99ef88e44462109e);
  }

  respawnitems_clear();
  self notify("changed_kit");
  self notify("giveLoadout");
  scripts\mp\rank::tryresetrankxp();

  if(!istrue(game["isLaunchChunk"]) && !isagent(self)) {
    scripts\mp\killstreaks\killstreaks::resetforloadoutswitch();
  }

  scripts\mp\playerlogic::trydisableminimap();

  if(getdvarint(@ "hash_61b02b55a172e917", 0) == 1) {
    time = getdvarfloat(@ "hash_e8b67c3d7a0df987", 2.2);
    scale = getdvarfloat(@ "hash_86724d0d77c5e70c", 1.35);
    thread function_222538ff1074a754(time, scale);
  }

  var_740fb89f7c4097d1 = getdvarint(@ "hash_71175162fc904ea1", 0);
  enableenemyoutlines = getdvarint(@ "hash_cc275c16edd52097", 0);

  if(var_740fb89f7c4097d1 > 0) {
    thread function_1efc9881377752ac(var_740fb89f7c4097d1);
  }

  if(enableenemyoutlines > 0) {
    thread function_f3ee15ceb4922f2(enableenemyoutlines);
  }

  if(getdvarint(@ "hash_845243985c59afcc", 0) == 1) {
    thread function_866622357ab7abae();
  }

  if(getdvarint(@ "hash_ae93197786d503ec", 0) == 1) {
    thread monitorstowedriotshieldspeed();
  }

  if(getDvar(@ "hash_138eb261013ca091") != "") {
    thread function_cfb799b827f505af();
  }

  if(getdvarint(@ "hash_862eba26990b004c", 0) == 1) {
    thread function_3f6e46db719fb8f2();
  }

  if(getdvarint(@ "hash_f834da80397b0ab6", 0) == 1) {
    thread disablesprintingpronehackcomplex();
  }

  if(getdvarint(@ "hash_e0b56c606d3e4c3", 0) == 1) {
    if(self hasperk("specialty_super_speed")) {
      self unsetperk("specialty_super_speed", 1);
    }
  }

  if(ismutationgamemodezombie()) {
    callsharedfunc("game", "mutationModeGiveEarnedPerks");
  }

  if(getdvarint(@ "hash_1988997dc2c8b83f", 0) == 1) {
    foreach(weapon in self.weaponlist) {
      if(isDefined(weapon.basename) && weapon.basename == "jup_jp26_la_mike32_mp") {
        thread function_64bffc8dc3c3f1ae(weapon);
      }
    }
  }
}

function disablesprintingpronehackcomplex() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    waitframe();

    if(isDefined(self.var_6900f3419d3c4dd0) && self.var_6900f3419d3c4dd0 == 0) {
      continue;
    }

    if(self isjumping()) {
      set_allowprone(0);

      while(self isjumping()) {
        wait 0.1;
      }

      set_allowprone(1);
    }
  }
}

function function_3f6e46db719fb8f2() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    if(self issprinting() && self getstance() == "prone") {
      self setstance("stand");
    }

    wait 0.1;
  }
}

function function_cfb799b827f505af() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 0.3;
  execution = getDvar(@ "hash_138eb261013ca091");

  if(isDefined(execution) && execution != "") {
    if(isPlayer(self)) {
      self clearexecution();

      if(isDefined(self.equippedweapons)) {
        foreach(weapon in self.equippedweapons) {
          if(issubstr(weapon.basename, "iw8_execution_")) {
            self takeweapon(weapon);
          }
        }
      }

      scripts\cp_mp\execution::_giveexecution(execution);
      self iprintlnbold("Execution Equipped:" + execution);
    }
  }
}

function function_200c71e93799b32f(struct) {
  if(istrue(level.codcasterenabled)) {
    if(!isPlayer(self) && !isalive(self)) {
      return;
    }

    if(isagent(self)) {
      return;
    }

    thread setmlgspectatorclientloadoutdata(self, struct);
  }
}

function loadout_lognewlygivenloadout(globalstruct, struct, class) {
  if(!isPlayer(self) && !isalive(self)) {
    return;
  }

  if(isagent(self)) {
    return;
  }

  if(istrue(level.codcasterenabled)) {
    thread setmlgspectatorclientloadoutdata(self, struct);
  }

  if(getdvarint(@ "online_matchdata_enabled") == 0) {
    return;
  }

  if(istrue(self.var_2676523c73704bb0)) {
    return;
  }

  if(struct.iscopiedclass) {
    var_2654b22c71e9aafc = 99;
    classtype = "copied";
  } else {
    var_2654b22c71e9aafc = getclassindex(class);
    classtype = loadout_getclasstype(class);
    isdefaultclass = getsubstr(class, 0, 7) == "default";
    self.loadoutclass = class;

    if(isdefaultclass) {
      var_2654b22c71e9aafc += 20;
    }
  }

  var_4c5b4888ff814cde = struct.tweakedbyplayerduringmatch || struct.gamemodeforcednewloadout;
  struct.tweakedbyplayerduringmatch = 0;
  struct.gamemodeforcednewloadout = 0;
  var_15bab3eaa5df4c14 = 0;

  if(!isDefined(self.pers["loggedClasses"])) {
    self.pers["loggedClasses"] = [];
  }

  loadoutindex = -1;

  foreach(index, loggedclass in self.pers["loggedClasses"]) {
    var_b7bfc64a828a13ff = self.pers["loggedClasses"][index];

    if(var_b7bfc64a828a13ff == var_2654b22c71e9aafc) {
      if(var_4c5b4888ff814cde) {
        var_15bab3eaa5df4c14 += 1;
        continue;
      }

      loadoutindex = index;
    }
  }

  primaryblueprint = undefined;
  secondaryblueprint = undefined;

  if(loadoutindex == -1 || struct.iscopiedclass) {
    loadoutindex = self.pers["loggedClasses"].size;
    self.pers["loggedClasses"][loadoutindex] = var_2654b22c71e9aafc;
    primaryweapon = struct.loadoutprimaryobject;

    if(isDefined(primaryweapon)) {
      primaryvariantid = getweaponvariantindex(primaryweapon);

      if(isDefined(primaryvariantid)) {
        var_8ef2c236f415dcd = getweaponrootname(primaryweapon) + "|" + primaryvariantid;
        blueprint = level.weaponlootmapdata[var_8ef2c236f415dcd];

        if(isDefined(blueprint)) {
          primaryblueprint = blueprint;
          primaryblueprint.blueprintname = var_8ef2c236f415dcd;
        }
      }
    }

    secondaryweapon = struct.loadoutsecondaryobject;

    if(isDefined(secondaryweapon)) {
      secondaryvariantid = getweaponvariantindex(secondaryweapon);

      if(isDefined(secondaryvariantid)) {
        var_f5763b2cfaf2080d = getweaponrootname(secondaryweapon) + "|" + secondaryvariantid;
        blueprint = level.weaponlootmapdata[var_f5763b2cfaf2080d];

        if(isDefined(blueprint)) {
          secondaryblueprint = blueprint;
          secondaryblueprint.blueprintname = var_f5763b2cfaf2080d;
        }
      }
    }

    var_7e2c53b0bcf117d9 = spawnStruct();

    if(isDefined(self.pers["telemetry"]) && isDefined(self.pers["telemetry"].life) && isDefined(self.pers["telemetry"].life.life_index)) {
      var_7e2c53b0bcf117d9.lifeindex = self.pers["telemetry"].life.life_index;
    }

    if(isDefined(primaryblueprint)) {
      var_7e2c53b0bcf117d9.primaryblueprint = primaryblueprint;
    }

    if(isDefined(secondaryblueprint)) {
      var_7e2c53b0bcf117d9.secondaryblueprint = secondaryblueprint;
    }

    var_7e2c53b0bcf117d9.globalstruct = globalstruct;
    var_7e2c53b0bcf117d9.classstruct = struct;
    var_7e2c53b0bcf117d9.classtype = classtype;
    var_7e2c53b0bcf117d9.loadoutindex = loadoutindex;
    var_7e2c53b0bcf117d9.var_15bab3eaa5df4c14 = var_15bab3eaa5df4c14;
    var_7e2c53b0bcf117d9.player = self;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_new_loadout_used", var_7e2c53b0bcf117d9);
  }

  if(!isDefined(self.loadoutindex) || self.loadoutindex != loadoutindex) {
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = self;
    var_7e2c53b0bcf117d9.globalstruct = globalstruct;
    var_7e2c53b0bcf117d9.struct = struct;
    var_7e2c53b0bcf117d9.class = class;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_loadout_changed", var_7e2c53b0bcf117d9);
  }

  self.loadoutindex = loadoutindex;
}

function hasvalidationinfraction() {
  return isDefined(self.pers) && isDefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

function recordvalidationinfraction() {
  if(isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
  }
}

function _detachall(var_be69c03caa346d6c) {
  if(!istrue(var_be69c03caa346d6c)) {
    self.headmodel = undefined;
  }

  if(isDefined(self.riotshieldmodel)) {
    riotshield_detach(1);
  }

  if(isDefined(self.riotshieldmodelstowed)) {
    riotshield_detach(0);
  }

  if(!istrue(var_be69c03caa346d6c)) {
    scripts\mp\gametypes\br_gametype_dmz::detachbag();
    self detachall();
  }

  scripts\mp\equipment\nvg::clearnvg(istrue(var_be69c03caa346d6c));
}

function trackriotshield_ontrophystow() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  while(true) {
    self waittill("grenade_pullback", objweapon);

    if(objweapon.basename != "trophy_mp") {
      continue;
    }

    if(!isDefined(self.riotshieldmodel)) {
      continue;
    }

    riotshield_move(1);
    self waittill("offhand_end");

    if(isriotshield(self getcurrentweapon()) && isDefined(self.riotshieldmodelstowed)) {
      riotshield_move(0);
    }
  }
}

function istwohandedoffhand(grenade) {
  if(isDefined(grenade) && grenade.basename != "none") {
    if(issuperweapon(grenade.basename) && !scripts\cp_mp\weapon::issupergestureweapon(grenade.basename)) {
      return true;
    }

    equipmenttype = getequipmenttype(grenade);

    if(isDefined(equipmenttype) && equipmenttype == "lethal") {
      return true;
    }
  }

  return false;
}

function trackriotshield_grenadepullbackforc4() {
  while(true) {
    self waittill("grenade_pullback", grenade);

    if(!isnullweapon(grenade) && grenade.basename == "c4_mp" && isriotshield(self getcurrentweapon())) {
      self.onriotshieldstow_force = 1;
    }

    waitframe();
  }
}

function trackriotshield_updateoffhandstowignorec4() {
  if(!istrue(self.onriotshieldstow_force)) {
    weaponobj = self getheldoffhand();

    if(!isnullweapon(weaponobj) && weaponobj.basename != "c4_mp" && isriotshield(self getcurrentweapon()) && istwohandedoffhand(weaponobj)) {
      self.onriotshieldstow_force = 1;
    }
  }
}

function trackriotshield_watchswitchawayfromshield() {
  self.riotshieldswitchawaytimer = undefined;
  self.riotshieldswitchaway = undefined;

  while(true) {
    self waittill("weapon_switch_started", weapon);

    if(!isriotshield(weapon)) {
      self.riotshieldswitchawaytimer = gettime() + 200;
      continue;
    }

    self.riotshieldswitchawaytimer = undefined;
    self.riotshieldswitchaway = undefined;
  }
}

function trackriotshield_watchcancelswitchaway() {
  while(true) {
    self waittill("weapon_switch_canceled", weapon);
    waittillframeend();

    if(isriotshield(weapon)) {
      self.riotshieldswitchawaytimer = undefined;
      self.riotshieldswitchaway = undefined;
    }
  }
}

function trackriotshield_monitorshieldattach(wasinlaststand) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");

  if(isDefined(self.infil)) {
    gameflagwait("prematch_done");
  }

  childthread trackriotshield_grenadepullbackforc4();

  if(isDefined(wasinlaststand)) {
    self.wasinlaststand = wasinlaststand;
  } else if(!isDefined(self.wasinlaststand)) {
    self.wasinlaststand = 0;
  }

  while(riotshield_hasweapon()) {
    trackriotshield_updateoffhandstowignorec4();

    if(!istrue(self.inlaststand)) {
      if(self.wasinlaststand) {
        self.laststandforceback = 1;
        self.laststandforcebackendtime = gettime() + 1000;
      } else if(isDefined(self.laststandforcebackendtime) && gettime() >= self.laststandforcebackendtime) {
        self.laststandforceback = undefined;
        self.laststandforcebackendtime = undefined;
      }

      self.wasinlaststand = 0;
    } else {
      self.laststandforceback = undefined;
      self.laststandforcebackendtime = undefined;
      self.wasinlaststand = 1;
    }

    if(self isonladder()) {
      trackriotshield_tryback();
    } else if(self isinexecutionattack()) {
      trackriotshield_tryback();
    } else if(self isinexecutionvictim()) {
      trackriotshield_trydetach();
    } else if(self isparachuting() || self isskydiving()) {
      trackriotshield_tryback();
    } else if(istrue(self.laststandforceback)) {
      trackriotshield_tryback();
    } else if(istrue(self.onriotshieldstow_force)) {
      if(isnullweapon(self getheldoffhand())) {
        self.onriotshieldstow_force = undefined;
        trackriotshield_tryreset();
      } else {
        trackriotshield_tryback();
      }
    } else {
      trackriotshield_tryreset();
    }

    waitframe();
  }

  trackriotshield_tryreset();
}

function trackriotshield_tryback() {
  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!onback) {
    if(onarm) {
      riotshield_move(1);
      return;
    }

    riotshield_attach(0, riotshield_getmodel());
  }
}

function trackriotshield_tryarm() {
  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!onarm) {
    if(onback) {
      riotshield_move(0);
      return;
    }

    riotshield_attach(1, riotshield_getmodel());
  }
}

function trackriotshield_trydetach() {
  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(onarm) {
    riotshield_detach(1);
  }

  if(onback) {
    riotshield_detach(0);
  }
}

function trackriotshield_tryreset() {
  if(riotshield_hasweapon()) {
    holdingshield = isriotshield(self getcurrentweapon());

    if(istrue(holdingshield)) {
      trackriotshield_tryarm();
    } else {
      trackriotshield_tryback();
    }

    return;
  }

  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(onarm) {
    riotshield_detach(1);
  }

  if(onback) {
    riotshield_detach(0);
  }
}

function riotshieldonweaponchange(objweapon) {
  if(riotshield_hasweapon()) {
    thread trackriotshield_monitorshieldattach();
    return;
  }

  trackriotshield_tryreset();
  riotshieldclearvars();
  self notify("riotshield_detach");
}

function riotshieldclearvars(fromdeath) {
  self.laststandforceback = undefined;
  self.laststandforcebackendtime = undefined;
  self.wasinlaststand = undefined;

  if(istrue(fromdeath)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
  }
}

function isweaponsilenced(weapon) {
  return weapon issilenced();
}

function getweaponpassives(weaponbasename, variantid) {
  return scripts\mp\loot::getpassivesforweapon(weaponbasename, variantid);
}

function weaponhaspassive(weaponbasename, variantid, passive) {
  passives = getweaponpassives(weaponbasename, variantid);

  if(!isDefined(passives) || passives.size <= 0) {
    return false;
  }

  foreach(weaponpassive in passives) {
    if(passive == weaponpassive) {
      return true;
    }
  }

  return false;
}

function getweaponvariantattachments(weaponbasename, variantid) {
  attachments = [];
  passives = getweaponpassives(weaponbasename, variantid);

  if(isDefined(passives)) {
    foreach(passive in passives) {
      passiveattachment = scripts\mp\passives::getpassiveattachment(passive);

      if(!isDefined(passiveattachment)) {
        continue;
      }

      attachments[attachments.size] = passiveattachment;
    }
  }

  return attachments;
}

function replenishloadout() {
  team = self.pers["team"];
  class = self.pers["class"];
  weaponslist = self getweaponslistall();

  for(idx = 0; idx < weaponslist.size; idx++) {
    weapon = weaponslist[idx];
    self givemaxammo(weapon);
    self setweaponammoclip(weapon, 9999);
    weaponname = weapon.basename;

    if(weaponname == "claymore_mp" || weaponname == "claymore_detonator_mp") {
      self setweaponammostock(weapon, 2);
    }
  }
}

function onplayerconnecting() {
  for(;;) {
    level waittill("connected", player);
    player enableplayerbreathsystem(0);

    if(!isDefined(player.pers["class"])) {
      player.pers["class"] = "";
    }

    if(!isDefined(player.pers["lastClass"])) {
      player.pers["lastClass"] = "";
    }

    player.class = player.pers["class"];
    player.lastclass = player.pers["lastClass"];
    player.changedarchetypeinfo = player.pers["changedArchetypeInfo"];
    player.lastarchetypeinfo = undefined;

    if(!isDefined(player.pers["validationInfractions"])) {
      player.pers["validationInfractions"] = 0;
    }
  }
}

function onplayerspawned() {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    if(!isDefined(player)) {
      continue;
    }

    player enableplayerbreathsystem(1);

    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.skinref) && player.operatorcustomization.skinref + "" == "355") {
      player function_555e2d32e2756625("gasmask_female");
    } else if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female") {
      player function_555e2d32e2756625("female");
    } else if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.skinref) && player.operatorcustomization.skinref + "" == "319") {
      player setentitysoundcontext("gender", "bongmask_male");
    } else if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.skinref) && player.operatorcustomization.skinref + "" == "597") {
      player setentitysoundcontext("gender", "bongmask_male");
    } else {
      player function_555e2d32e2756625("");
    }

    player stoplocalsound("deaths_door_death");

    if(isDefined(level.var_d39aa4b67cefa0d6)) {
      player stoplocalsound(level.var_d39aa4b67cefa0d6);
    }

    player clearsoundsubmix("player_swimming_underwater", 1);
    player clearsoundsubmix("mp_juggernaut", 0.5);
    player clearsoundsubmix("iw9_mp_soccer_goal", 1);
    player setentitysoundcontext("atmosphere", "", 1);
    player clearclienttriggeraudiozone(2);

    if(isDefined(player.operatorsfx)) {
      player clearsoundsubmix("iw8_mp_spawn_camera");
      player.operatorsfx stoploopsound(self.operatorsfxalias);
      player.operatorsfx delete();
      player.operatorsfx = undefined;
      player.operatorsfxalias = undefined;
    }

    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.clothtype) && player.operatorcustomization.clothtype != "") {
      player setclothtype(getxhash(player.operatorcustomization.clothtype));
    } else {
      player setclothtype(#"vestlight");
    }

    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.geartype) && player.operatorcustomization.geartype != "") {
      player setgeartype(getxhash(player.operatorcustomization.geartype));
    } else {
      player setgeartype(#"millghtgr");
    }

    if(level.gametype == "dungeons") {
      player scripts\cp_mp\execution::_giveexecution("jup_execution_first_person_000", 1);
    }
  }
}

function fadeaway(waitdelay, fadedelay) {
  wait waitdelay;
  self fadeovertime(fadedelay);
  self.alpha = 0;
}

function setclass(newclass) {
  self.curclass = newclass;
}

function haschangedclass() {
  if(isDefined(self.lastclass) && self.lastclass != self.class || !isDefined(self.lastclass)) {
    return true;
  }

  if(scripts\cp_mp\utility\game_utility::isinfectedgametype() && (!isDefined(self.last_infected_class) || self.last_infected_class != self.infected_class)) {
    return true;
  }

  return false;
}

function haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo)) {
      return true;
    }

    if(self.changedarchetypeinfo != self.lastarchetypeinfo) {
      return true;
    }
  }

  return false;
}

function resetactionslots() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");

  if(!isagent(self) && !self isconsoleplayer()) {
    self setactionslot(5, "");
    self setactionslot(6, "");
    self setactionslot(7, "");
  }
}

function resetfunctionality() {
  self enableequipdeployvfx(0);

  if(!isagent(self)) {
    if(!istrue(self.ksempd)) {
      scripts\mp\utility\player::hidehudclear();
    }

    vehicle_allowplayeruse(self, 1);

    if(level.minimaponbydefault || scripts\cp_mp\utility\game_utility::isbrstylegametype() && istrue(game["inLiveLobby"])) {
      self setclientomnvar("ui_hide_minimap", 0);
    } else {
      self setclientomnvar("ui_hide_minimap", 1);
    }
  }

  val::nuke_all();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_clearallowmovementplayer(self, 1);
  self.doublejumpenergy = undefined;
  self.doublejumpenergyrestorerate = undefined;
  self.enabledcollisionnotifies = undefined;
  self.enabledequipdeployvfx = undefined;
  self.minimapstatetracker = undefined;
  self.isstunned = undefined;
  self.isblinded = undefined;
  self.nocorpse = undefined;
  self.prematchlook = undefined;
  self.ladderexecutionblocked = undefined;
  scripts\mp\damage::resetattackerlist();
  scripts\mp\damage::clearcorpsetablefuncs();
  scripts\mp\class::riotshieldclearvars();
  scripts\cp_mp\utility\player_utility::cleardemeanorsafe();
  scripts\mp\weapons::clearburning(1);
  scripts\mp\equipment\molotov::molotov_clear_fx();
  scripts\mp\equipment\flash_grenade::clearflash(1);
  scripts\mp\equipment\gas_grenade::gas_clear(1);

  if(!isagent(self)) {
    scripts\cp_mp\killstreaks\recon_drone::function_a867654273504370();
  }

  scripts\cp_mp\killstreaks\white_phosphorus::clearloopingcoughaudio();
  _resetenableignoreme();
  scripts\cp_mp\utility\player_utility::function_c28310e3b33872cb();
}

function clearscriptable() {
  self setscriptablepartstate("CompassIcon", "defaultIcon");
}

function changearchetype(archetype, super, trait) {
  if(isDefined(self.changedarchetypeinfo)) {
    var_1df3c8537ebf5ed5 = self.changedarchetypeinfo;

    if(var_1df3c8537ebf5ed5.archetype == archetype && var_1df3c8537ebf5ed5.super == super && var_1df3c8537ebf5ed5.trait == trait) {
      return;
    }
  }

  changedarchetypeinfo = spawnStruct();
  changedarchetypeinfo.archetype = archetype;
  changedarchetypeinfo.super = super;
  changedarchetypeinfo.trait = trait;
  self.changedarchetypeinfo = changedarchetypeinfo;
  self.pers["changedArchetypeInfo"] = changedarchetypeinfo;

  if(isDefined(self.pers["class"]) && self.pers["class"] != "") {
    preloadandqueueclass(self.pers["class"]);

    if(shouldallowinstantclassswap()) {
      thread swaploadout();
      return;
    }

    if(isalive(self)) {
      self iprintlnbold(game["strings"]["change_rig"]);
    }
  }
}

function getattachmentloadoutstring(attachmentindex, slot) {
  assert(isxhash(slot));

  if(!isDefined(level.var_e6667ec6ac57b25a)) {
    level.var_e6667ec6ac57b25a = [];
    level.var_e6667ec6ac57b25a[#"primary"] = "loadoutPrimaryAttachment";
    level.var_e6667ec6ac57b25a[#"secondary"] = "loadoutSecondaryAttachment";
    level.var_e6667ec6ac57b25a[#"tertiary"] = "loadoutTertiaryAttachment";
  }

  base = level.var_e6667ec6ac57b25a[slot];

  if(attachmentindex == 0) {
    return base;
  }

  return base + attachmentindex + 1;
}

function function_9f808ad55705b616(attachmentindex, slot) {
  assert(isxhash(slot));

  if(!isDefined(level.var_7044d2f68a5aef17)) {
    level.var_7044d2f68a5aef17 = [];
    level.var_7044d2f68a5aef17[#"primary"] = "loadoutPrimaryAttachmentVariantID";
    level.var_7044d2f68a5aef17[#"secondary"] = "loadoutSecondaryAttachmentVariantID";
    level.var_7044d2f68a5aef17[#"tertiary"] = "loadoutTertiaryAttachmentVariantID";
  }

  base = level.var_7044d2f68a5aef17[slot];

  if(attachmentindex == 0) {
    return base;
  }

  return base + attachmentindex + 1;
}

function getstickerloadoutstring(var_36d2abbdcbcb186c, slot) {
  assert(isxhash(slot));

  if(!isDefined(level.var_8058980ac78604fe)) {
    level.var_8058980ac78604fe = [];
    level.var_8058980ac78604fe[#"primary"] = "loadoutPrimarySticker";
    level.var_8058980ac78604fe[#"secondary"] = "loadoutSecondarySticker";
    level.var_8058980ac78604fe[#"tertiary"] = "loadoutTertiarySticker";
  }

  base = level.var_8058980ac78604fe[slot];

  if(var_36d2abbdcbcb186c == 0) {
    return base;
  }

  return base + var_36d2abbdcbcb186c + 1;
}

function getmaxprimaryattachments() {
  return 7;
}

function getmaxsecondaryattachments() {
  return 7;
}

function function_ed8babbe1912171f() {
  return 5;
}

function function_fba1013e19eb56c3() {
  return 5;
}

function function_4073b3f145413cd() {
  return 7;
}

function getmaxattachments(weaponslot) {
  assert(isxhash(weaponslot));

  if(!isDefined(level.maxattachments)) {
    level.maxattachments = [];
    level.maxattachments[#"primary"] = getmaxprimaryattachments();
    level.maxattachments[#"secondary"] = getmaxsecondaryattachments();
    level.maxattachments[#"tertiary"] = function_4073b3f145413cd();
  }

  return level.maxattachments[weaponslot];
}

function fillemptystreakslots(var_66383c9fdf2d18c4, struct) {
  if(!level.allowkillstreaks) {
    return;
  }

  var_3c96db658445965e = [];
  var_5feb6adfd05e27f1 = [];

  foreach(index, streak in var_66383c9fdf2d18c4) {
    if(streak == "none") {
      var_3c96db658445965e[var_3c96db658445965e.size] = index;
      continue;
    }

    var_5feb6adfd05e27f1[var_5feb6adfd05e27f1.size] = streak;
  }

  if(var_3c96db658445965e.size > 0) {
    self.pers["hackedStreaks"] = 1;
  }

  foreach(slot in var_3c96db658445965e) {
    newstreak = findfirststreakdifferentcost(var_5feb6adfd05e27f1);

    if(slot + 1 == 1) {
      struct.loadoutkillstreak1 = newstreak;
    } else if(slot + 1 == 2) {
      struct.loadoutkillstreak2 = newstreak;
    } else {
      struct.loadoutkillstreak3 = newstreak;
    }

    var_5feb6adfd05e27f1[var_5feb6adfd05e27f1.size] = newstreak;
  }

  return [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];
}

function findfirststreakdifferentcost(var_5feb6adfd05e27f1) {
  var_7b0a8d49f719a44e = [];

  foreach(streakref, bundle in level.streakglobals.streakbundles) {
    if(!istrue(bundle.showninmenu)) {
      continue;
    }

    skipstreak = 0;

    foreach(slotstreak in var_5feb6adfd05e27f1) {
      if(streakref == slotstreak || scripts\mp\killstreaks\killstreaks::calcstreakcost(streakref) == scripts\mp\killstreaks\killstreaks::calcstreakcost(slotstreak)) {
        skipstreak = 1;
        break;
      }
    }

    if(!istrue(skipstreak)) {
      var_7b0a8d49f719a44e[var_7b0a8d49f719a44e.size] = streakref;
    }
  }

  return var_7b0a8d49f719a44e[0];
}

function replacewithspecialistkillstreaks(struct) {
  return ["specialist_perk_1", "specialist_perk_2", "specialist_perk_3", "specialist_perk_bonus"];
}

function updateinstantclassswapallowed() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self.instantclassswapallowed = 1;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_cd83a28652a3f837 = scripts\mp\gamelogic::function_20fcd7762daec487();

    if(var_cd83a28652a3f837) {
      scripts\mp\flags::gameflagwait("prematch_fade_done");
      updateinstantclassswapallowedinternal();
    }
  } else {
    scripts\mp\flags::gameflagwait("prematch_done");
    updateinstantclassswapallowedinternal();
  }

  disableclassswapallowed();
}

function updateinstantclassswapallowedinternal() {
  self endon("death");
  graceperiod = ter_op(ismlgmatch(), 5, 15);

  if(scripts\mp\gamelogic::function_20fcd7762daec487()) {
    while(isDefined(self.c130)) {
      waitframe();
    }

    self waittill("parachute_complete");
  }

  if(_hasperk("specialty_tune_up")) {
    graceperiod = ter_op(ismlgmatch(), 5, 5);
  }

  wait graceperiod;
}

function disableclassswapallowed() {
  if(istrue(level.var_f55a78de40f16b44)) {
    return;
  }

  if(istrue(self.instantclassswapallowed)) {
    self.instantclassswapallowed = 0;

    if(isteamreviveenabled() && !ismutationgamemodezombie()) {
      self.revive_chosenclass = self.class;
      self.pers["next_round_class"] = self.class;
    }
  }
}

function function_bc75edb1c34af80e() {
  if(!istrue(level.var_a0b81643aba2ec27)) {
    return;
  }

  player = self;
  player.var_b19b4be400b7ac35 = gettime();
}

function isvalidclass(class) {
  return isDefined(class) && class != "";
}

function getclassindex(classname) {
  assertex(isDefined(level.classmap[classname]), "<dev string:x3ee>" + classname + "<dev string:x40b>");
  return level.classmap[classname];
}

function preloadandqueueclass(class, highpriorityload) {
  struct = loadout_getorbuildclassstruct(class);
  preloadandqueueclassstruct(struct, highpriorityload);
  return struct;
}

function preloadandqueueclassstruct(classstruct, highpriorityload, var_8c3977c9c8dc729b) {
  playerassets = scripts\mp\playerlogic::getplayerassets(classstruct);
  scripts\mp\playerlogic::loadplayerassets([playerassets], highpriorityload, var_8c3977c9c8dc729b);
  self.preloadedclassstruct = classstruct;
}

function loadout_getorbuildclassstruct(classname) {
  if(isDefined(self.team) && self.team == "spectator" && !isDefined(classname)) {
    classname = "custom1";
  } else if(!isDefined(classname)) {
    classname = "default1";
  }

  classtype = loadout_getclasstype(classname);
  cachedstruct = getcachedloadoutstruct(classname, classtype);

  if(isDefined(cachedstruct)) {
    if(!isDefined(cachedstruct.loadoutprimaryobject) && isDefined(cachedstruct.loadoutprimaryfullname)) {
      cachedstruct.loadoutprimaryobject = makeweaponfromstring(cachedstruct.loadoutprimaryfullname);
    }

    if(!isDefined(cachedstruct.loadoutsecondaryobject) && isDefined(cachedstruct.loadoutsecondaryfullname)) {
      cachedstruct.loadoutsecondaryobject = makeweaponfromstring(cachedstruct.loadoutsecondaryfullname);
    }

    if(!isDefined(cachedstruct.var_cc881f2bd3565d22) && isDefined(cachedstruct.var_e3f8e7ca9c87781f)) {
      cachedstruct.var_cc881f2bd3565d22 = makeweaponfromstring(cachedstruct.var_e3f8e7ca9c87781f);
    }
  }

  if(isDefined(cachedstruct)) {
    if(classname == "gamemode") {
      tempstruct = loadout_getclassstruct();
      tempstruct = loadout_updateclass(tempstruct, classname);
      var_94a93d61b8c3e782 = compareclassstructs(tempstruct, cachedstruct);

      if(!var_94a93d61b8c3e782) {
        tempstruct.gamemodeforcednewloadout = 1;
        trytocacheclassstruct(tempstruct, classname, classtype);
        return tempstruct;
      }
    }

    return cachedstruct;
  }

  classstruct = loadout_getclassstruct();
  classstruct = loadout_updateclass(classstruct, classname);
  trytocacheclassstruct(classstruct, classname, classtype);
  return classstruct;
}

function loadout_getglobalclassstruct() {
  if(!isDefined(self.pers["globalLoadoutStruct"])) {
    loadout_updateglobalclassstruct();
  }

  return self.pers["globalLoadoutStruct"];
}

function loadout_updateglobalclassstruct() {
  struct = spawnStruct();
  struct.loadoutfieldupgrade1 = "none";
  struct.loadoutfieldupgrade2 = "none";

  if(!isagent(self)) {
    if(!isDefined(self.loadoutfieldupgrade1) && getdvarint(@ "t10", 0)) {
      if(getDvar(@ "hash_953b8c504c0dd6f2", "") == "zm_t10") {
        struct.loadoutfieldupgrade1 = "super_aether_shroud";
      } else {
        struct.loadoutfieldupgrade1 = "super_trophy";
      }
    }
  }

  self.pers["globalLoadoutStruct"] = struct;
}

function loadout_editglobalclassstruct() {
  var_24e17785934294e8 = loadout_getglobalclassstruct();
  loadout_updateglobalclassstruct();
  var_b7c2ff3894e369a3 = loadout_getglobalclassstruct();

  if(var_24e17785934294e8.loadoutfieldupgrade1 != var_b7c2ff3894e369a3.loadoutfieldupgrade1) {
    return true;
  }

  if(var_24e17785934294e8.loadoutfieldupgrade2 != var_b7c2ff3894e369a3.loadoutfieldupgrade2) {
    return true;
  }

  return false;
}

function loadout_updateglobalclassgamemode(globalstruct, class) {
  gamemodeloadout = self.pers["gamemodeLoadout"];

  if(isDefined(gamemodeloadout)) {
    if(isDefined(gamemodeloadout["loadoutFieldUpgrade1"])) {
      globalstruct.loadoutfieldupgrade1 = gamemodeloadout["loadoutFieldUpgrade1"];
    }

    if(isDefined(gamemodeloadout["loadoutFieldUpgrade2"])) {
      globalstruct.loadoutfieldupgrade2 = gamemodeloadout["loadoutFieldUpgrade2"];
    }
  }
}

function loadout_editcachedclassstruct(classname) {
  classtype = loadout_getclasstype(classname);
  cachedstruct = getcachedloadoutstruct(classname, classtype);

  if(isDefined(cachedstruct)) {
    tempstruct = loadout_getclassstruct();
    tempstruct = loadout_updateclass(tempstruct, classname);
    var_94a93d61b8c3e782 = compareclassstructs(tempstruct, cachedstruct);

    if(!var_94a93d61b8c3e782) {
      tempstruct.tweakedbyplayerduringmatch = 1;
      trytocacheclassstruct(tempstruct, classname, classtype);
      return true;
    }
  }

  return false;
}

function getcachedloadoutstruct(classname, classtype) {
  switch (classtype) {
    case #"hash_412d4adaf2412dc0":
    case #"hash_44e999799ff10fce":
    case #"hash_7038dec66d8275be":
      if(!isDefined(self.pers["classCache"])) {
        break;
      }

      return self.pers["classCache"][classname];
  }

  return undefined;
}

function trytocacheclassstruct(classstruct, classname, classtype) {
  switch (classtype) {
    case #"hash_412d4adaf2412dc0":
    case #"hash_44e999799ff10fce":
    case #"hash_7038dec66d8275be":
      addclassstructtocache(classstruct, classname);
      break;
  }
}

function addclassstructtocache(classstruct, classname) {
  if(!isDefined(self.pers["classCache"])) {
    self.pers["classCache"][classname] = [];
  }

  self.pers["classCache"][classname] = classstruct;
}

function loadout_emptycacheofloadout(classname) {
  if(!isDefined(self.pers["classCache"])) {
    return;
  }

  self.pers["classCache"][classname] = undefined;
}

function loadout_gamemodeloadoutchanged() {
  self.pers["classCache"]["gamemode"] = undefined;
}

function copyclassfornextlife(otherplayer) {
  self setclientomnvar("ui_loadout_copied", gettime());
  thread _loadout_setcopyloadoutomvnaronspawn();
  loadout = undefined;

  if(isDefined(otherplayer.juggcontext) && isDefined(otherplayer.juggcontext.prevclassstruct)) {
    loadout = otherplayer.juggcontext.prevclassstruct;
  } else {
    loadout = otherplayer.classstruct;
  }

  self.pers["copiedClass"] = loadout_copyclassstruct(loadout);
  self.pers["lastKiller"] = otherplayer;
}

function _loadout_setcopyloadoutomvnaronspawn() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned");
  self setclientomnvar("ui_loadout_changed", 13);
}

function loadout_fixcopiedclassstruct(copiedstruct, classstruct) {
  copiedstruct.loadoutsuper = classstruct.loadoutsuper;
  copiedstruct.loadoutstreaksfilled = classstruct.loadoutstreaksfilled;
  copiedstruct.loadoutstreaktype = classstruct.loadoutstreaktype;
  copiedstruct.loadoutkillstreak1 = classstruct.loadoutkillstreak1;
  copiedstruct.loadoutkillstreak2 = classstruct.loadoutkillstreak2;
  copiedstruct.loadoutkillstreak3 = classstruct.loadoutkillstreak3;
  copiedstruct.loadoutaccessoryweapon = classstruct.loadoutaccessoryweapon;
  copiedstruct.loadoutaccessorydata = classstruct.loadoutaccessorydata;
  copiedstruct.loadoutaccessorylogic = classstruct.loadoutaccessorylogic;
  copiedstruct.tweakedbyplayerduringmatch = 0;
  copiedstruct.gamemodeforcednewloadout = 0;
  copiedstruct.iscopiedclass = 1;
}

function function_bae2a0b1db21cab9(weaponobj, skipfirstraise) {
  if(!isDefined(skipfirstraise)) {
    skipfirstraise = 0;
  }

  if(scripts\cp_mp\utility\game_utility::shouldskipfirstraise() && istrue(self.hasspawned)) {
    skipfirstraise = 1;
  }

  if(istrue(self.wassquadspawned)) {
    skipfirstraise = 1;
  }

  return skipfirstraise;
}

function respawnitems_saveplayeritemstostruct(saveweapons, saveequipment, savestreaks, saveperks, savesuper) {
  respawnitems = spawnStruct();

  if(!isDefined(saveweapons) || saveweapons) {
    respawnitems_saveweapons(respawnitems);
  }

  if(!isDefined(saveequipment) || saveequipment) {
    respawnitems_saveequipmentitems(respawnitems);
  }

  if(!isDefined(savestreaks) || savestreaks) {
    respawnitems_savestreaks(respawnitems);
  }

  if(!isDefined(saveperks) || saveperks) {
    function_1a5ecf82792e6bb8(respawnitems);
  }

  if(!isDefined(savesuper) || savesuper) {
    respawnitems_savesuper(respawnitems);
  }

  return respawnitems;
}

function respawnitems_assignrespawnitems(respawnitems) {
  self.respawnitems = respawnitems;
}

function respawnitems_hasrespawnitems() {
  return isDefined(self.respawnitems);
}

function respawnitems_getrespawnitems() {
  if(isDefined(self.respawnitems)) {
    return self.respawnitems;
  }

  return undefined;
}

function respawnitems_clear() {
  self.respawnitems = undefined;
}

function respawnitems_saveweapons(respawnitems) {
  cacweapons = [];
  var_5bc770e98fe2f25e = self.primaryweapons;
  currentweaponobj = self.currentweapon;

  foreach(weapon in var_5bc770e98fe2f25e) {
    if(function_da27e3343b019fde() && isbackuppistol(weapon)) {
      continue;
    }

    if(iscacprimaryorsecondary(weapon)) {
      cacweapons[cacweapons.size] = weapon;
    }
  }

  assertex(cacweapons.size <= 2, "<dev string:x410>");

  if(isDefined(self.var_64a7c6d08000be36)) {
    cacweapons = self.var_64a7c6d08000be36;
    self.var_64a7c6d08000be36 = undefined;
  }

  primaryweaponobj = undefined;

  if(isDefined(self.var_b43e8623c0dd6a67)) {
    primaryweaponobj = self.var_b43e8623c0dd6a67;
    self.var_b43e8623c0dd6a67 = undefined;
  } else if(isDefined(self.lastcacweaponobj) && self hasweapon(self.lastcacweaponobj)) {
    primaryweaponobj = self.lastcacweaponobj;
  } else if(iscacprimaryorsecondary(self.currentweapon)) {
    primaryweaponobj = self.currentweapon;
  } else if(cacweapons.size > 0) {
    primaryweaponobj = cacweapons[0];
  }

  if(isundefinedweapon(primaryweaponobj)) {
    primaryweaponobj = makeweapon("iw9_me_fists_mp");
  }

  respawnitems_saveweapon(primaryweaponobj, "primary", respawnitems);
  secondaryweaponobj = undefined;

  foreach(weapon in cacweapons) {
    if(!issameweapon(weapon, primaryweaponobj, 1)) {
      secondaryweaponobj = weapon;
      break;
    }
  }

  if(isDefined(secondaryweaponobj)) {
    respawnitems_saveweapon(secondaryweaponobj, "secondary", respawnitems);
  }

  function_58e92934b81cbc64(respawnitems);
}

function respawnitems_saveweapon(weaponobj, weaponslot, respawnitems) {
  if(!isDefined(respawnitems.weapons)) {
    respawnitems.weapons = [];
  }

  weaponinfo = spawnStruct();
  respawnitems.weapons[weaponslot] = weaponinfo;
  weaponinfo.weaponobj = weaponobj;
  weaponinfo.clipammo = self getweaponammoclip(weaponobj);
  weaponinfo.stockammo = self getweaponammostock(weaponobj);

  if(weaponobj.hasalternate) {
    weaponaltobj = weaponobj getaltweapon();
    weaponinfo.altclipammo = self getweaponammoclip(weaponaltobj);
    weaponinfo.altstockammo = self getweaponammostock(weaponaltobj);
  }
}

function function_58e92934b81cbc64(respawnitems) {
  if(!isDefined(respawnitems.weapons)) {
    return;
  }

  assert(isDefined(respawnitems.weapons["<dev string:x460>"]) && isDefined(respawnitems.weapons["<dev string:x460>"].weaponobj) && isDefined(respawnitems.weapons["<dev string:x460>"].clipammo) && isDefined(respawnitems.weapons["<dev string:x460>"].stockammo));
  assert(!isDefined(respawnitems.weapons["<dev string:x46b>"]) || isDefined(respawnitems.weapons["<dev string:x46b>"].weaponobj) && isDefined(respawnitems.weapons["<dev string:x46b>"].clipammo) && isDefined(respawnitems.weapons["<dev string:x46b>"].stockammo));
}

function respawnitems_saveequipmentitems(respawnitems) {
  respawnitems_saveequipment("primary", respawnitems);
  respawnitems_saveequipment("secondary", respawnitems);

  function_fddb6546d1d0bc28(respawnitems);
}

function respawnitems_saveequipment(slot, respawnitems) {
  itemref = scripts\mp\equipment::getcurrentequipment(slot);

  if(!isDefined(itemref)) {
    itemref = "none";
  }

  if(!isDefined(respawnitems.equipment)) {
    respawnitems.equipment = [];
  }

  equipmentinfo = spawnStruct();
  respawnitems.equipment[slot] = equipmentinfo;
  equipmentinfo.item = itemref;

  if(itemref != "none") {
    equipmentinfo.ammo = scripts\mp\equipment::getequipmentammo(equipmentinfo.item);
    return;
  }

  equipmentinfo.ammo = 0;
}

function function_fddb6546d1d0bc28(respawnitems) {
  if(!isDefined(respawnitems.equipment)) {
    return;
  }

  assert(!isDefined(respawnitems.equipment["<dev string:x460>"]) || isDefined(respawnitems.equipment["<dev string:x460>"].item) && isDefined(respawnitems.equipment["<dev string:x460>"].ammo));
  assert(!isDefined(respawnitems.equipment["<dev string:x46b>"]) || isDefined(respawnitems.equipment["<dev string:x46b>"].item) && isDefined(respawnitems.equipment["<dev string:x46b>"].ammo));
}

function respawnitems_savestreaks(respawnitems) {
  streakstate = spawnStruct();
  streakstate.streaks = [];
  streakstate.streakpoints = self.streakpoints;

  if(!isDefined(self.streakpoints)) {
    return;
  }

  streakinfo = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(streakinfo)) {
    streakstate.streaks[streakstate.streaks.size] = streakinfo.streakname;
  }

  streakinfo = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(2);

  if(isDefined(streakinfo)) {
    streakstate.streaks[streakstate.streaks.size] = streakinfo.streakname;
  }

  streakinfo = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(3);

  if(isDefined(streakinfo)) {
    streakstate.streaks[streakstate.streaks.size] = streakinfo.streakname;
  }

  if(streakstate.streaks.size <= 0) {
    return;
  }

  respawnitems.streakstate = streakstate;

  function_18e339bfd7cb9efa(respawnitems);
}

function function_18e339bfd7cb9efa(respawnitems) {
  if(!isDefined(respawnitems.streakstate)) {
    return;
  }

  assert(isDefined(respawnitems.streakstate.streakpoints));
  assert(isDefined(respawnitems.streakstate.streaks) && respawnitems.streakstate.streaks.size > 0);
}

function function_1a5ecf82792e6bb8(respawnitems) {
  perkstate = spawnStruct();
  respawnitems.perkstate = perkstate;
  perkstate.loadoutperks = self.loadoutperks;
  perkstate.var_15f3e6df722fb1cf = self.var_15f3e6df722fb1cf;
  perkstate.var_15f3e5df722faf9c = self.var_15f3e5df722faf9c;
  perkstate.loadoutstandardperks = self.pers["loadoutStandardPerks"];
  perkstate.loadoutextraperks = self.pers["loadoutExtraPerks"];
  perkstate.loadoutrigtrait = self.pers["loadoutRigTrait"];
  perkstate.loadoutusingspecialist = self.pers["loadoutUsingSpecialist"];
  perkstate.perkpackageprogress = self.pers["perkPackageProgress"];
  perkstate.perkpackagetier2earned = self.pers["perkPackageTier2Earned"];
  perkstate.perkpackagetier3state = self.pers["perkPackageTier3State"];

  function_f1babd693e0a8c44(respawnitems);
}

function function_f1babd693e0a8c44(respawnitems) {
  if(!isDefined(respawnitems.perkstate)) {
    return;
  }

  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7() && getdvarint(@ "hash_48587f2cfa448879", 1) == 1) {
    return;
  }

  assert(isDefined(respawnitems.perkstate.loadoutperks));
  assert(isDefined(respawnitems.perkstate.loadoutstandardperks));
  assert(isDefined(respawnitems.perkstate.loadoutextraperks));
  assert(isDefined(respawnitems.perkstate.loadoutrigtrait));
  assert(isDefined(respawnitems.perkstate.loadoutusingspecialist));

  if(istrue(level.var_606eb45e074ff204)) {
    assert(isDefined(respawnitems.perkstate.perkpackageprogress));
    assert(isDefined(respawnitems.perkstate.perkpackagetier2earned));
    assert(isDefined(respawnitems.perkstate.perkpackagetier3state));
  }
}

function respawnitems_savesuper(respawnitems) {
  superref = scripts\mp\supers::getcurrentsuperref();

  if(!isDefined(superref)) {
    return;
  }

  superstate = spawnStruct();
  respawnitems.superstate = superstate;
  superstate.super = superref;
  superstate.superpoints = scripts\mp\supers::getcurrentsuperbasepoints();
  superstate.extrapoints = scripts\mp\supers::getcurrentsuperextrapoints();

  if(superref == "super_select") {
    currentsuper = scripts\mp\supers::getcurrentsuper();
    superstate.firstupgrade = currentsuper.firstupgrade;
    superstate.secondupgrade = currentsuper.secondupgrade;
  }

  function_6f401b52c8322c1b(respawnitems);
}

function function_6f401b52c8322c1b(respawnitems) {
  if(!isDefined(respawnitems.superstate)) {
    return;
  }

  assert(isDefined(respawnitems.superstate.super));
  assert(isDefined(respawnitems.superstate.superpoints));
  assert(isDefined(respawnitems.superstate.extrapoints));

  if(respawnitems.superstate.super == "<dev string:x478>") {
    assert(isDefined(respawnitems.superstate.firstupgrade));
    assert(isDefined(respawnitems.superstate.secondupgrade));
  }
}

function respawnitems_hasweapondata(respawnitems) {
  if(!isDefined(respawnitems)) {
    return false;
  }

  return isDefined(respawnitems.weapons);
}

function respawnitems_getweaponobj(respawnitems, weaponslot) {
  return respawnitems.weapons[weaponslot].weaponobj;
}

function respawnitems_giveweaponammo(respawnitems, weaponslot) {
  weaponinfo = respawnitems.weapons[weaponslot];

  if(!isDefined(weaponinfo)) {
    return;
  }

  self setweaponammoclip(weaponinfo.weaponobj, weaponinfo.clipammo);

  if(!isaxeweapon(weaponinfo.weaponobj)) {
    self setweaponammostock(weaponinfo.weaponobj, weaponinfo.stockammo);

    if(weaponinfo.weaponobj.hasalternate) {
      weaponaltobj = weaponinfo.weaponobj getaltweapon();
      self setweaponammoclip(weaponaltobj, weaponinfo.altclipammo);
      self setweaponammostock(weaponaltobj, weaponinfo.altstockammo);
    }
  }
}

function respawnitems_hasequipmentdata(respawnitems) {
  if(!isDefined(respawnitems)) {
    return false;
  }

  return isDefined(respawnitems.equipment);
}

function respawnitems_getequipmentref(respawnitems, slot) {
  return respawnitems.equipment[slot].item;
}

function respawnitems_giveequipmentammo(respawnitems, slot) {
  item = respawnitems_getequipmentref(respawnitems, slot);

  if(!isDefined(item) || item == "none") {
    return;
  }

  ammo = respawnitems.equipment[slot].ammo;

  if(!isDefined(ammo)) {
    return;
  }

  scripts\mp\equipment::setequipmentammo(item, ammo);
}

function respawnitems_hasstreakdata(respawnitems) {
  if(!isDefined(respawnitems)) {
    return false;
  }

  return isDefined(respawnitems.streakstate);
}

function respawnitems_getstreakpoints(respawnitems) {
  return respawnitems.streakstate.streakpoints;
}

function respawnitems_getstreaks(respawnitems) {
  return respawnitems.streakstate.streaks;
}

function function_b19856925ddabd5a(respawnitems) {
  if(!isDefined(respawnitems)) {
    return false;
  }

  return isDefined(respawnitems.perkstate);
}

function function_40a3148d5514ffa3(respawnitems) {
  return respawnitems.perkstate.loadoutperks;
}

function function_dc2f8c385699a6e8(respawnitems) {
  return respawnitems.perkstate.var_15f3e6df722fb1cf;
}

function function_dc2f8d385699a91b(respawnitems) {
  return respawnitems.perkstate.var_15f3e5df722faf9c;
}

function function_64d9f4542fdd7b14(respawnitems) {
  return respawnitems.perkstate.loadoutstandardperks;
}

function function_dc35cb143c497599(respawnitems) {
  return respawnitems.perkstate.loadoutextraperks;
}

function function_7f47875b5fd88f24(respawnitems) {
  return respawnitems.perkstate.loadoutrigtrait;
}

function function_eba2981fa45ae3bf(respawnitems) {
  return respawnitems.perkstate.loadoutusingspecialist;
}

function function_33e44385e17eecc1(respawnitems) {
  return respawnitems.perkstate.perkpackageprogress;
}

function function_7af26fc564e26a5f(respawnitems) {
  return respawnitems.perkstate.perkpackagetier2earned;
}

function function_7d2ba1e36afe24b0(respawnitems) {
  return respawnitems.perkstate.perkpackagetier3state;
}

function respawnitems_hassuperdata(respawnitems) {
  if(!isDefined(respawnitems)) {
    return false;
  }

  return isDefined(respawnitems.superstate);
}

function respawnitems_getsuperref(respawnitems) {
  return respawnitems.superstate.super;
}

function respawnitems_getsuperpoints(respawnitems) {
  return respawnitems.superstate.superpoints;
}

function respawnitems_getsuperextrapoints(respawnitems) {
  return respawnitems.superstate.extrapoints;
}

function function_2f17741f5c15a7d6(respawnitems) {
  if(respawnitems_getsuperref(respawnitems) == "super_select") {
    return [respawnitems.superstate.firstupgrade, respawnitems.superstate.secondupgrade];
  }

  return [respawnitems_getsuperref(respawnitems), "none"];
}

function spawnammocountoverride_giveweaponammo(weaponobj, weaponslot, var_10b09490bb78e90e) {
  weaponinfo = weaponobj;
  noammo = !var_10b09490bb78e90e;

  if(noammo && !ismeleeweapon(weaponobj)) {
    clipsize = 0;
    reserveammo = 0;

    if(weaponobj.isdualwield) {
      self setweaponammoclip(weaponinfo, clipsize, "left");
    }
  } else {
    clipsize = weaponinfo.clipsize;
    reserveammo = var_10b09490bb78e90e - 1;
  }

  if(var_10b09490bb78e90e == 7) {
    reserveammo = weaponmaxammo(weaponinfo);
  } else if(issubstr(weaponinfo.basename, "iw8_sh_charlie725") && !noammo) {
    reserveammo = weaponinfo.clipsize * reserveammo + 18;
  } else {
    reserveammo = weaponinfo.clipsize * reserveammo;
  }

  self setweaponammoclip(weaponinfo, clipsize);
  self setweaponammostock(weaponinfo, reserveammo);

  if(weaponobj.hasalternate) {
    weaponaltobj = weaponobj getaltweapon();

    if(noammo) {
      altclipammo = 0;
      altstockammo = 0;
    } else {
      altclipammo = self getweaponammoclip(weaponaltobj);
      altstockammo = self getweaponammostock(weaponaltobj);
    }

    self setweaponammoclip(weaponaltobj, altclipammo);
    self setweaponammostock(weaponaltobj, altstockammo);
  }
}

function ismeleeweapon(objweapon) {
  ismeleeweapon = isknifeonly(objweapon.basename) || isakimbomeleeweapon(objweapon.basename) || isaxeweapon(objweapon.basename) || ismeleeoverrideweapon(objweapon) || isriotshield(objweapon.basename);
  return ismeleeweapon;
}

function compareclassstructs(classa, classb) {
  if(classa.loadoutarchetype != classb.loadoutarchetype) {
    return false;
  }

  if(classa.loadoutprimary != classb.loadoutprimary) {
    return false;
  }

  if(!checkclassstructarray(classa.loadoutprimaryattachments, classb.loadoutprimaryattachments)) {
    return false;
  }

  if(!checkclassstructarray(classa.loadoutprimaryattachmentids, classb.loadoutprimaryattachmentids)) {
    return false;
  }

  if(classa.loadoutprimarycamo != classb.loadoutprimarycamo) {
    return false;
  }

  if(classa.loadoutprimaryreticle != classb.loadoutprimaryreticle) {
    return false;
  }

  if(classa.loadoutprimarylootitemid != classb.loadoutprimarylootitemid) {
    return false;
  }

  if(classa.loadoutprimaryvariantid != classb.loadoutprimaryvariantid) {
    return false;
  }

  if(classa.loadoutprimarycosmeticattachment != classb.loadoutprimarycosmeticattachment) {
    return false;
  }

  if(classa.loadoutsecondary != classb.loadoutsecondary) {
    return false;
  }

  if(!checkclassstructarray(classa.loadoutsecondaryattachments, classb.loadoutsecondaryattachments)) {
    return false;
  }

  if(!checkclassstructarray(classa.loadoutsecondaryattachmentids, classb.loadoutsecondaryattachmentids)) {
    return false;
  }

  if(classa.loadoutsecondarycamo != classb.loadoutsecondarycamo) {
    return false;
  }

  if(classa.loadoutsecondaryreticle != classb.loadoutsecondaryreticle) {
    return false;
  }

  if(classa.loadoutsecondarylootitemid != classb.loadoutsecondarylootitemid) {
    return false;
  }

  if(classa.loadoutsecondaryvariantid != classb.loadoutsecondaryvariantid) {
    return false;
  }

  if(classa.loadoutsecondarycosmeticattachment != classb.loadoutsecondarycosmeticattachment) {
    return false;
  }

  if(istrue(level.tertiaryweaponslotenabled)) {
    if(!checkclassstructarray(classa.var_494870a5978b5a09, classb.var_494870a5978b5a09)) {
      return false;
    }

    if(!checkclassstructarray(classa.var_6bfdc660c23f71ea, classb.var_6bfdc660c23f71ea)) {
      return false;
    }

    if(classa.loadouttertiarycamo != classb.loadouttertiarycamo) {
      return false;
    }

    if(classa.loadouttertiaryreticle != classb.loadouttertiaryreticle) {
      return false;
    }

    if(classa.var_64e57707d385a2f5 != classb.var_64e57707d385a2f5) {
      return false;
    }

    if(classa.loadouttertiaryvariantid != classb.loadouttertiaryvariantid) {
      return false;
    }

    if(classa.var_372f30ef6d6882ab != classb.var_372f30ef6d6882ab) {
      return false;
    }
  }

  if(!checkclassstructarray(classa.loadoutperks, classb.loadoutperks)) {
    return false;
  }

  if(!checkclassstructarray(classa.loadoutstandardperks, classb.loadoutstandardperks)) {
    return false;
  }

  if(!checkclassstructarray(classa.loadoutextraperks, classb.loadoutextraperks)) {
    return false;
  }

  if(classa.loadoutusingspecialist != classb.loadoutusingspecialist) {
    return false;
  }

  if(classa.loadoutmeleeslot != classb.loadoutmeleeslot) {
    return false;
  }

  if(classa.loadoutperksfromgamemode != classb.loadoutperksfromgamemode) {
    return false;
  }

  if(classa.loadoutrigtrait != classb.loadoutrigtrait) {
    return false;
  }

  if(classa.loadoutequipmentprimary != classb.loadoutequipmentprimary) {
    return false;
  }

  if(classa.var_b68e3a0a9c628d23 != classb.var_b68e3a0a9c628d23) {
    return false;
  }

  if(classa.loadoutextraequipmentprimary != classb.loadoutextraequipmentprimary) {
    return false;
  }

  if(classa.loadoutequipmentsecondary != classb.loadoutequipmentsecondary) {
    return false;
  }

  if(classa.var_a1dfc5ce15795a3 != classb.var_a1dfc5ce15795a3) {
    return false;
  }

  if(classa.loadoutextraequipmentsecondary != classb.loadoutextraequipmentsecondary) {
    return false;
  }

  if(classa.loadoutfieldupgrade1 != classb.loadoutfieldupgrade1) {
    return false;
  }

  if(classa.loadoutfieldupgrade2 != classb.loadoutfieldupgrade2) {
    return false;
  }

  if(classa.loadoutgesture != classb.loadoutgesture) {
    return false;
  }

  if(classa.loadoutstreaksfilled != classb.loadoutstreaksfilled) {
    return false;
  }

  if(classa.loadoutstreaktype != classb.loadoutstreaktype) {
    return false;
  }

  if(classa.loadoutkillstreak1 != classb.loadoutkillstreak1) {
    return false;
  }

  if(classa.loadoutkillstreak2 != classb.loadoutkillstreak2) {
    return false;
  }

  if(classa.loadoutkillstreak3 != classb.loadoutkillstreak3) {
    return false;
  }

  return true;
}

function checkclassstructarray(arraya, arrayb) {
  if(arraya.size != arrayb.size) {
    return false;
  }

  foreach(key, value in arraya) {
    if(!isDefined(arrayb[key])) {
      return false;
    }

    if(arrayb[key] != value) {
      return false;
    }
  }

  return true;
}

function blockclasschange() {
  ent_flag_init("swapLoadout_blocked");
  ent_flag_init("swapLoadout_pending");
  ent_flag_init("swapLoadout_complete");
  ent_flag_set("swapLoadout_blocked");
}

function unblockclasschange() {
  self endon("death_or_disconnect");

  if(ent_flag_exist("swapLoadout_blocked") && ent_flag("swapLoadout_blocked")) {
    ent_flag_clear("swapLoadout_blocked");
  }
}

function setthirdpersonview() {
  if(gameflag("infil_will_run") && !gameflag("prematch_done")) {
    self setcamerathirdperson(0);
    thread restoregameplaythirdperson();
    return;
  }

  if(istrue(self.perkthirdperson)) {
    self setcamerathirdperson(1);
    return;
  }

  if(istrue(self.liveragdoll)) {
    self setcamerathirdperson(1);
    return;
  }

  switch (level.thirdpersonmode) {
    case 1:
      self setcamerathirdperson(1);
      break;
    case 2:
      self setcamerathirdperson(self.team == "allies");
      break;
    case 3:
      self setcamerathirdperson(self.team == "axis");
      break;
    default:
      if(!istrue(level.var_6bec823e343dacea)) {
        self setcamerathirdperson(0);
      }

      break;
  }
}

function restoregameplaythirdperson() {
  self endon("death_or_disconnect");
  self notify("restoreGameplayThirdPerson");
  self endon("restoreGameplayThirdPerson");
  gameflagwait("prematch_done");
  setthirdpersonview();
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function function_a16868d4dcd81a4b() {
  self setclientomnvar("ui_skip_loadout", 1);
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];

  if(isbot(self)) {
    self.classcallback = "gamemode";
  }
}

function function_286b27e21ed2cf0c() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  previousstance = self.laststance;

  while(true) {
    if(previousstance != self.laststance && self.laststance == "prone") {
      timer = 0;
      quakescale = 0;
      quakeduration = 0;
      quakeradius = 25;

      if(previousstance == "stand") {
        timer = 0.68;
        quakescale = 0.4;
        quakeduration = 0.6;
      } else if(previousstance == "crouch") {
        timer = 0.35;
        quakescale = 0.3;
        quakeduration = 0.5;
      }

      thread function_32397139046948fc(timer, quakescale, quakeduration, quakeradius);
      var_e9d7f01676217b00 = timer / 3;
      setrecoilscale(-15);
      wait var_e9d7f01676217b00;
      setrecoilscale(-15);
      wait var_e9d7f01676217b00;
      setrecoilscale(-15);
      wait var_e9d7f01676217b00;
      setrecoilscale(45);
    }

    previousstance = self.laststance;
    waitframe();
  }
}

function function_32397139046948fc(timedelay, _scale, _duration, _radius) {
  self endon("death_or_disconnect");
  self endon("game_ended");
  wait timedelay;
  self earthquakeforplayer(_scale, _duration, self.origin, _radius);
}

function function_222538ff1074a754(_time, _scale) {
  self endon("death_or_disconnect");
  self endon("game_ended");

  if(!gameflag("prematch_done")) {
    level waittill("prematch_over");
  }

  wait 0.3;
  self setmovespeedscale(_scale);
  wait _time;
  scripts\mp\weapons::updatemovespeedscale();
}

function function_1efc9881377752ac(var_740fb89f7c4097d1) {
  self endon("death_or_disconnect");
  self endon("game_ended");

  while(!isDefined(self.team)) {
    waitframe();
  }

  while(!isDefined(getotherteam(self.team))) {
    waitframe();
  }

  while(!isalive(self)) {
    waitframe();
  }

  waitframe();

  switch (var_740fb89f7c4097d1) {
    case 2:
      scripts\mp\utility\outline::outlineenableforteam(self, self.team, "jup_teammate_outline", "lowest");
      break;
    case 1:
      scripts\mp\utility\outline::outlineenableforteam(self, self.team, "jup_teammate_outline_beforetrans", "lowest");
      break;
    case 3:
      scripts\mp\utility\outline::outlineenableforteam(self, self.team, "jup_teammate_outline_nodistance", "lowest");
      break;
    default:
      break;
  }
}

function function_f3ee15ceb4922f2(enableenemyoutlines) {
  self endon("death_or_disconnect");
  self endon("game_ended");

  while(!isDefined(self.team)) {
    waitframe();
  }

  while(!isDefined(getotherteam(self.team))) {
    waitframe();
  }

  while(!isalive(self)) {
    waitframe();
  }

  waitframe();
  otherteams = getotherteam(self.team);

  foreach(team in otherteams) {
    switch (enableenemyoutlines) {
      case 1:
        scripts\mp\utility\outline::outlineenableforteam(self, team, "jup_enemy_outline", "lowest");
        break;
      case 2:
        scripts\mp\utility\outline::outlineenableforteam(self, team, "jup_enemy_outline_beforetrans", "lowest");
        break;
      case 3:
        scripts\mp\utility\outline::outlineenableforteam(self, team, "jup_enemy_outline_nodistance", "lowest");
        break;
      default:
        break;
    }
  }
}

function function_866622357ab7abae() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  var_b6113f673c358828 = 1100;
  currenttimer = 0;
  hasdodged = 0;
  sprintheld = 0;

  while(true) {
    if(self sprintbuttonPressed() && !sprintheld) {
      sprintheld = 1;
      ystick = self getleftsticky();
      xstick = self getleftstickx();

      if(!hasdodged && self sprintbuttonPressed() && self isonground() && ystick < 0.15 && !(ystick == 0 && xstick == 0)) {
        hasdodged = 1;
        self.dodgebar = function_c6071a6e72a4f025(308, 294, 100, 4);
        self.dodgebar updatebar(0, 0.909091);
        wait 1.2;
        self.dodgebar destroyelem();
        hasdodged = 0;
      }
    }

    if(sprintheld && self sprintbuttonPressed() == 0) {
      sprintheld = 0;
    }

    wait 0.05;
  }
}

function monitorstowedriotshieldspeed() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self notify("monitorStowedRiotshieldSpeed");
  self endon("monitorStowedRiotshieldSpeed");

  while(true) {
    self waittill("weapon_change");
    waitframe();

    if(istrue(self.isjuggernaut) || istrue(self.isjuggernautrecon)) {
      continue;
    }

    self.stowedriotshield = 0;

    if(isDefined(self.weaponlist)) {
      foreach(weap in self.weaponlist) {
        if(weap == self.currentprimaryweapon && issubstr(weap.basename, "riotshield")) {
          continue;
        }

        if(issubstr(weap.basename, "riotshield")) {
          var_d9dce4d225162eb4 = getdvarfloat(@ "hash_ed3656881cc512d9", 0.9);
          self setmovespeedscale(var_d9dce4d225162eb4);
          self.stowedriotshield = 1;
        }
      }
    }

    if(!istrue(self.stowedriotshield)) {
      self setmovespeedscale(1);
    }

    waitframe();
  }
}

function function_da27e3343b019fde() {
  return isDefined(level.var_dd07587af7d0ec5e) && level.var_dd07587af7d0ec5e != "" && level.var_dd07587af7d0ec5e != "none";
}

function function_c19397c712573e87(player) {
  usingpistol = 0;
  var_8b95cef36cc88f1 = 0;
  nextreloadtime = 0;
  pausereloadtime = 0;

  while(true) {
    canreload = !player ishanging() && !player isonladder() && !player isswimunderwater();

    if(usingpistol && canreload) {
      usingpistol = 0;
      var_8b95cef36cc88f1 = 1;
      nextreloadtime = gettime() + level.var_6ff4dcd4533c4a93 - pausereloadtime;
    } else if(!usingpistol && !canreload) {
      if(nextreloadtime > gettime()) {
        pausereloadtime = nextreloadtime - gettime();
      } else {
        pausereloadtime = 0;
      }

      var_8b95cef36cc88f1 = 0;
      usingpistol = 1;
    }

    if(var_8b95cef36cc88f1 && nextreloadtime < gettime()) {
      break;
    }

    waitframe();
  }
}

function function_1ca935941daaf046(weaponobj) {
  self endon("death_or_disconnect");
  waittillframeend();
  self endon("giveLoadout");

  while(true) {
    function_c19397c712573e87(self);
    clipsize = weaponclipsize(weaponobj);
    ammo = self getweaponammoclip(weaponobj);
    var_c1192c297bbf292f = 0;

    if(ammo < clipsize) {
      if(isDefined(level.var_d95b39e262c1049a)) {
        var_31b36738ff4eacd = self[[level.var_d95b39e262c1049a]](weaponobj);
      } else {
        var_31b36738ff4eacd = self getweaponammostock(weaponobj);
      }

      var_c1192c297bbf292f += clipsize - ammo;

      if(var_c1192c297bbf292f > var_31b36738ff4eacd) {
        var_c1192c297bbf292f = var_31b36738ff4eacd;
      }

      if(var_c1192c297bbf292f > 0) {
        self setweaponammoclip(weaponobj, clipsize);

        if(isDefined(level.var_f1659f4dcd686291)) {
          self[[level.var_f1659f4dcd686291]](weaponobj, var_c1192c297bbf292f);
          continue;
        }

        self setweaponammostock(weaponobj, var_31b36738ff4eacd - var_c1192c297bbf292f);
      }
    }
  }
}

function function_d32d2baaa9465105(var_d792416e0edaee34) {
  self endon("death_or_disconnect");
  waittillframeend();
  self endon("giveLoadout");

  if(!getdvarint(@ "hash_ad5d112e9d176248", 1)) {
    return;
  }

  while(true) {
    msg = waittill_any_return_2("target_marker_begin_non_cancellable", "target_marker_end_non_cancellable");

    if(msg == "target_marker_begin_non_cancellable") {
      var_a896c0925c401823 = self getcurrentweapon();

      if(isDefined(var_a896c0925c401823)) {
        self.var_631e00e0caec69db = var_a896c0925c401823;
        continue;
      }
    }

    self.var_631e00e0caec69db = undefined;
  }
}

function function_6254bac9f9be9cf4(var_d792416e0edaee34) {
  player = self;
  player endon("death_or_disconnect");
  waittillframeend();
  player endon("giveLoadout");
  player enableweaponpickup();
  player enableweaponfireunderwater();
  underwaterdata = spawnStruct();
  underwaterdata.isunderwater = 0;
  underwaterdata.var_5996df3d783693e8 = undefined;
  underwaterdata.backuppistol = var_d792416e0edaee34;
  var_c528332c83684105 = spawnStruct();
  var_c528332c83684105.ishanging = 0;
  var_c528332c83684105.var_5996df3d783693e8 = undefined;
  var_c528332c83684105.backuppistol = var_d792416e0edaee34;

  while(true) {
    if(player isswimunderwater()) {
      if(!underwaterdata.isunderwater) {
        player notify("player_entered_backup_pistol_state");
        underwaterdata.isunderwater = 1;
        player function_415e5061f6389e8a(underwaterdata);
        player thread function_7f1c954f80ee4bb9(underwaterdata);
      }
    } else if(underwaterdata.isunderwater) {
      player notify("player_backup_pistol_surfaced");
      player enableweaponpickup();
      player enableweaponfireunderwater();
      player function_7d89af78724b2cb8(underwaterdata, 1);
      underwaterdata.isunderwater = 0;
      underwaterdata.var_5996df3d783693e8 = undefined;
    }

    if(player ishanging() || player isonladder()) {
      if(!var_c528332c83684105.ishanging) {
        player notify("player_entered_backup_pistol_state");
        player function_4b56747106ade67d(var_c528332c83684105.backuppistol);
        var_c528332c83684105.ishanging = 1;
        var_c528332c83684105.var_5996df3d783693e8 = player getcurrentprimaryweapon();
      }
    } else if(var_c528332c83684105.ishanging) {
      player function_7d89af78724b2cb8(var_c528332c83684105, 1);
      var_c528332c83684105.ishanging = 0;
      var_c528332c83684105.var_5996df3d783693e8 = undefined;
    }

    waitframe();
  }
}

function function_415e5061f6389e8a(underwaterdata) {
  player = self;
  player disableweaponpickup();
  player enableweaponfireunderwater();
  underwaterdata.var_5996df3d783693e8 = player getcurrentprimaryweapon();
  var_929540bb89d0a925 = underwaterdata.backuppistol;

  foreach(weap in player.primaryweapons) {
    if(weap != underwaterdata.backuppistol && weaponclass(weap) == "pistol" && !scripts\mp\utility\weapon::ismeleeonly(weap)) {
      var_929540bb89d0a925 = weap;
      break;
    }
  }

  player function_4b56747106ade67d(var_929540bb89d0a925);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_929540bb89d0a925, 0, 1);

  if(success != 1) {
    if(!player iscurrentweapon(var_929540bb89d0a925)) {
      player abortmonitoredweaponswitch(var_929540bb89d0a925);
    }
  }
}

function function_6baf1dc15666ea19(var_5996df3d783693e8, data) {
  if(isDefined(self.var_631e00e0caec69db) && self.var_631e00e0caec69db == var_5996df3d783693e8) {
    return true;
  }

  iskillstreakweapon = scripts\cp_mp\weapon::iskillstreakweapon(var_5996df3d783693e8);
  var_84444ff0b7f0f04f = !iskillstreakweapon || iskillstreakweapon && scripts\mp\utility\killstreak::isjuggernaut();
  return var_5996df3d783693e8 != data.backuppistol && !scripts\cp_mp\armor::function_6aa482957b62905c(var_5996df3d783693e8) && !scripts\mp\utility\weapon::isgunlessweapon(var_5996df3d783693e8) && var_84444ff0b7f0f04f;
}

function function_4b56747106ade67d(var_929540bb89d0a925) {
  player = self;

  if(!player hasweapon(var_929540bb89d0a925)) {
    player giveweapon(var_929540bb89d0a925, 0, 0, 0, 1, 1);
  }
}

function function_93d99d806146e8d7(data) {
  player = self;

  if(!isDefined(data.var_5996df3d783693e8) || !function_6baf1dc15666ea19(data.var_5996df3d783693e8, data)) {
    foreach(weap in player.primaryweapons) {
      if(function_6baf1dc15666ea19(weap, data)) {
        data.var_5996df3d783693e8 = weap;
        break;
      }
    }
  }
}

function function_7d89af78724b2cb8(data, var_1da99285175ae8ae) {
  player = self;
  playercurrentweapon = player getcurrentprimaryweapon();
  var_e62d13611d9988e0 = isDefined(playercurrentweapon) && playercurrentweapon.basename != "none";

  if(!var_e62d13611d9988e0 || !function_6baf1dc15666ea19(playercurrentweapon, data)) {
    player function_93d99d806146e8d7(data);
    result = 0;

    while(!result) {
      result = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(data.var_5996df3d783693e8, 0, 1);

      if(!result) {
        waitframe();
        player function_93d99d806146e8d7(data);
      }
    }

    data.var_5996df3d783693e8 = undefined;
    return;
  }

  if(istrue(var_1da99285175ae8ae) && isDefined(playercurrentweapon) && playercurrentweapon != data.backuppistol) {
    player thread function_b63353df1796c99b(data);
  }
}

function function_b63353df1796c99b(data) {
  player = self;
  player notify("player_watch_delayed_backup_pistol_switch");
  player endon("giveLoadout");
  player endon("death_or_disconnect");
  player endon("player_watch_delayed_backup_pistol_switch");
  player endon("player_entered_backup_pistol_state");
  var_3bc829a61e8bfdcb = player getcurrentprimaryweapon();
  var_59d889801ceebae2 = player function_b2ed366433a3d074();

  if(isDefined(var_59d889801ceebae2) && var_3bc829a61e8bfdcb == var_59d889801ceebae2) {
    while(player isswitchingweapon()) {
      waitframe();
    }
  } else {
    msg = player waittill_any_in_array_return(["weapon_switch_done", "weapon_change", "weapon_change_complete"]);
  }

  if(player function_c782e5bc12dc2966()) {
    player function_7d89af78724b2cb8(data, 0);
    return;
  }

  if(ismeleeoverrideweapon(var_3bc829a61e8bfdcb)) {
    player function_b63353df1796c99b(data);
  }
}

function function_7f1c954f80ee4bb9(underwaterdata) {
  player = self;
  player endon("giveLoadout");
  player endon("death_or_disconnect");
  player endon("player_backup_pistol_surfaced");
  var_9d18b2fd550333 = getdvarint(@ "hash_5eb644efd8a6bf0b", 7);
  dotimeout = 0;

  while(true) {
    playercurrentweapon = player getcurrentprimaryweapon();

    if(weaponclass(playercurrentweapon) != "pistol") {
      player enableweaponpickup();
      player disableweaponfireunderwater();
      dotimeout = 1;
    } else {
      player enableweaponfireunderwater();
    }

    if(!dotimeout) {
      dotimeout = 0;
      msg = player waittill_any_in_array_return(["weapon_switch_done", "weapon_change", "weapon_change_complete"]);
      continue;
    }

    msg = player waittill_any_in_array_or_timeout(["damage", "weapon_switch_done", "weapon_change", "weapon_change_complete"], var_9d18b2fd550333);

    if(msg == "timeout" || msg == "damage") {
      player function_415e5061f6389e8a(underwaterdata);
    }
  }
}

function function_c782e5bc12dc2966() {
  currentweap = self getcurrentprimaryweapon();

  if(isDefined(self.classstruct) && isDefined(self.classstruct.var_91e10e152b08ec1d) && isDefined(currentweap)) {
    return (currentweap == self.classstruct.var_91e10e152b08ec1d);
  }

  return false;
}

function function_64bffc8dc3c3f1ae(weapon) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(weapon hasattachment("jup_jp26_la_mike32_rec_amp")) {
    if(weapon hasattachment("jup_ammo_44mm_drill")) {
      var_34e765db0d96519b = getdvarint(@ "hash_f810f62d8e34f749", 6);
      self setweaponammoclip(weapon, int(min(6, var_34e765db0d96519b)));
      self setweaponammostock(weapon, int(max(0, var_34e765db0d96519b) - 6));
    } else if(weapon hasattachment("jup_ammo_44mm_slug")) {
      var_bdb2e712022a2609 = getdvarint(@ "hash_c84b8c70b1a6559b", 12);
      self setweaponammoclip(weapon, int(min(6, var_bdb2e712022a2609)));
      self setweaponammostock(weapon, int(max(0, var_bdb2e712022a2609) - 6));
    } else if(weapon hasattachment("jup_ammo_44mm_sticky")) {
      var_70a5040b89732ddd = getdvarint(@ "hash_217d89d2acacb55b", 6);
      self setweaponammoclip(weapon, int(min(6, var_70a5040b89732ddd)));
      self setweaponammostock(weapon, int(max(0, var_70a5040b89732ddd) - 6));
    } else {
      var_32c8f66713dd8557 = getdvarint(@ "hash_24cb33e0921e4525", 6);
      self setweaponammoclip(weapon, int(min(6, var_32c8f66713dd8557)));
      self setweaponammostock(weapon, int(max(0, var_32c8f66713dd8557) - 6));
    }

    return;
  }

  var_32c8f66713dd8557 = getdvarint(@ "hash_24cb33e0921e4525", 6);
  self setweaponammoclip(weapon, int(min(6, var_32c8f66713dd8557)));
  self setweaponammostock(weapon, int(max(0, var_32c8f66713dd8557) - 6));
}