/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\class.gsc
********************************/

init() {
  level.classmap["class0"] = 0;
  level.classmap["class1"] = 1;
  level.classmap["class2"] = 2;
  level.classmap["custom1"] = 0;
  level.classmap["custom2"] = 1;
  level.classmap["custom3"] = 2;
  level.classmap["custom4"] = 3;
  level.classmap["custom5"] = 4;
  level.classmap["custom6"] = 5;
  level.classmap["custom7"] = 6;
  level.classmap["custom8"] = 7;
  level.classmap["custom9"] = 8;
  level.classmap["custom10"] = 9;
  level.classmap["axis_recipe1"] = 0;
  level.classmap["axis_recipe2"] = 1;
  level.classmap["axis_recipe3"] = 2;
  level.classmap["axis_recipe4"] = 3;
  level.classmap["axis_recipe5"] = 4;
  level.classmap["axis_recipe6"] = 5;
  level.classmap["allies_recipe1"] = 0;
  level.classmap["allies_recipe2"] = 1;
  level.classmap["allies_recipe3"] = 2;
  level.classmap["allies_recipe4"] = 3;
  level.classmap["allies_recipe5"] = 4;
  level.classmap["allies_recipe6"] = 5;
  level.classmap["gamemode"] = 0;
  level.classmap["callback"] = 0;
  level.classmap["default1"] = 0;
  level.classmap["default2"] = 1;
  level.classmap["default3"] = 2;
  level.classmap["default4"] = 3;
  level.classmap["default5"] = 4;
  level.defaultclass = "CLASS_ASSAULT";
  level.classtablename = "mp\classTable.csv";
  level thread onplayerconnecting();
}

getclasschoice(param_00) {
  return param_00;
}

getweaponchoice(param_00) {
  var_01 = strtok(param_00, ",");
  if(var_01.size > 1) {
    return int(var_01[1]);
  }

  return 0;
}

cac_getweapon(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "weaponSetups", param_01, "weapon");
}

cac_getweaponattachment(param_00, param_01, param_02) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "weaponSetups", param_01, "attachment", param_02);
}

cac_getweaponlootitemid(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "weaponSetups", param_01, "lootItemID");
}

cac_getweaponvariantid(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "weaponSetups", param_01, "variantID");
}

cac_getweaponcamo(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "weaponSetups", param_01, "camo");
}

cac_getweaponreticle(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "weaponSetups", param_01, "reticle");
}

cac_getkillstreak(param_00) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", param_00, "killstreak");
}

cac_getcharacterarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.archetype;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetype");
}

cac_getpower(param_00) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "powerSetups", 0, "power");
}

cac_getextracharge(param_00) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "powerSetups", 0, "extraCharge");
}

cac_getpower2(param_00) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "powerSetups", 1, "power");
}

cac_getextracharge2(param_00) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "powerSetups", 1, "extraCharge");
}

cac_getpowerid(param_00) {
  var_01 = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "powerSetups", 0, "lootItemID");
  return scripts\mp\powerloot::getpassiveperk(var_01);
}

cac_getpower2id(param_00) {
  var_01 = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "powerSetups", 1, "lootItemID");
  return scripts\mp\powerloot::getpassiveperk(var_01);
}

cac_getsuper() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.super;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
}

cac_getgesture() {
  var_00 = "none";
  if(isDefined(self.changedarchetypeinfo)) {
    var_01 = level.archetypeids[self.changedarchetypeinfo.archetype];
    if(level.rankedmatch) {
      var_00 = self getplayerdata("rankedloadouts", "squadMembers", "archetypePreferences", var_01, "gesture");
    } else {
      var_00 = self getplayerdata("privateloadouts", "squadMembers", "archetypePreferences", var_01, "gesture");
    }
  } else if(level.rankedmatch) {
    var_00 = self getplayerdata("rankedloadouts", "squadMembers", "gesture");
  } else {
    var_00 = self getplayerdata("privateloadouts", "squadMembers", "gesture");
  }

  return scripts\mp\gestures_mp::getgesturedata(var_00);
}

cac_getloadoutperk(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "loadoutPerks", param_01);
}

cac_getloadoutextraperk(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "extraPerks", param_01);
}

cac_getloadoutarchetypeperk() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.trait;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePerk");
}

cac_getkillstreaklootid(param_00, param_01) {
  var_02 = self getplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", param_01, "lootItemID");
  return scripts\mp\killstreak_loot::getpassiveperk(var_02);
}

cac_getkillstreakvariantid(param_00) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", param_00, "lootItemID");
}

cac_getweaponcosmeticattachment(param_00, param_01) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", param_00, "weaponSetups", param_01, "cosmeticAttachment");
}

recipe_getkillstreak(param_00, param_01, param_02) {
  return scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_00, param_01, "class", "kilstreakSetups", param_02, "killstreak");
}

table_getarchetype(param_00, param_01) {
  return tablelookup(param_00, 0, "loadoutArchetype", param_01 + 1);
}

table_getweapon(param_00, param_01, param_02) {
  if(param_02 == 0) {
    return tablelookup(param_00, 0, "loadoutPrimary", param_01 + 1);
  }

  return tablelookup(param_00, 0, "loadoutSecondary", param_01 + 1);
}

table_getweaponattachment(param_00, param_01, param_02, param_03) {
  var_04 = "none";
  if(param_02 == 0) {
    var_04 = tablelookup(param_00, 0, "loadoutPrimaryAttachment" + param_03 + 1, param_01 + 1);
  } else {
    var_04 = tablelookup(param_00, 0, "loadoutSecondaryAttachment" + param_03 + 1, param_01 + 1);
  }

  if(var_04 == "" || var_04 == "none") {
    return "none";
  }

  return var_04;
}

table_getweaponcamo(param_00, param_01, param_02) {
  if(param_02 == 0) {
    return tablelookup(param_00, 0, "loadoutPrimaryCamo", param_01 + 1);
  }

  return tablelookup(param_00, 0, "loadoutSecondaryCamo", param_01 + 1);
}

table_getweaponreticle(param_00, param_01, param_02) {
  if(param_02 == 0) {
    return tablelookup(param_00, 0, "loadoutPrimaryReticle", param_01 + 1);
  }

  return tablelookup(param_00, 0, "loadoutSecondaryReticle", param_01 + 1);
}

table_getperk(param_00, param_01, param_02) {
  return tablelookup(param_00, 0, "loadoutPerk" + param_02 + 1, param_01 + 1);
}

table_getextraperk(param_00, param_01, param_02) {
  return tablelookup(param_00, 0, "loadoutExtraPerk" + param_02 + 1, param_01 + 1);
}

table_getpowerprimary_MAYBE(param_00, param_01) {
  return tablelookup(param_00, 0, "loadoutPowerPrimary", param_01 + 1);
}

table_getextrapowerprimary_MAYBE(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, "loadoutExtraPowerPrimary", param_01 + 1);
  return isDefined(var_02) && var_02 == "TRUE";
}

table_getpowersecondary_MAYBE(param_00, param_01) {
  return tablelookup(param_00, 0, "loadoutPowerSecondary", param_01 + 1);
}

table_getextrapowersecondary_MAYBE(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, "loadoutExtraPowerSecondary", param_01 + 1);
  return isDefined(var_02) && var_02 == "TRUE";
}

table_getsuper(param_00, param_01) {
  return tablelookup(param_00, 0, "loadoutSuper", param_01 + 1);
}

table_getgesture(param_00, param_01) {
  return tablelookup(param_00, 0, "loadoutGesture", param_01 + 1);
}

table_getkillstreak(param_00, param_01, param_02) {
  return tablelookup(param_00, 0, "loadoutStreak" + param_02, param_01 + 1);
}

loadout_getplayerstreaktype(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "streaktype_support":
      var_01 = "support";
      break;

    case "streaktype_specialist":
      var_01 = "specialist";
      break;

    case "streaktype_resource":
      var_01 = "resource";
      break;

    default:
      var_01 = "assault";
      break;
  }

  return var_01;
}

getloadoutstreaktypefromstreaktype(param_00) {
  if(!isDefined(param_00)) {
    return "streaktype_assault";
  }

  switch (param_00) {
    case "support":
      return "streaktype_support";

    case "specialist":
      return "streaktype_specialist";

    case "assault":
      return "streaktype_assault";

    default:
      return "streaktype_assault";
  }
}

loadout_getclassteam(param_00) {
  var_01 = undefined;
  if(issubstr(param_00, "axis")) {
    var_01 = "axis";
  } else if(issubstr(param_00, "allies")) {
    var_01 = "allies";
  } else {
    var_01 = "none";
  }

  return var_01;
}

func_AE23() {
  self.health = self.maxhealth;
  thread scripts\mp\utility::func_DDD9(scripts\mp\utility::isjuggernaut());
  self.isjuggernaut = 1;
}

loadout_removejugg_MAYBE() {
  self notify("lost_juggernaut");
  self.isjuggernaut = 0;
  self.movespeedscaler = 1;
}

loadout_clearweapons() {
  self takeallweapons();
  scripts\mp\perks\_weaponpassives::resetmodeswitchkillweapons(self);
  _detachall();
  scripts\mp\powers::func_110C2();
  scripts\mp\powers::clearpowers();
  if(isDefined(self.loadoutarchetype)) {
    clearscriptable();
  }

  scripts\mp\archetypes\archcommon::removearchetype(self.loadoutarchetype);
  scripts\mp\perks\_perks::_clearperks();
  scripts\mp\perks\_weaponpassives::forgetpassives();
  scripts\mp\gestures_mp::func_41B2();
  resetactionslots();
  resetfunctionality();
  if(isplayer(self)) {
    scripts\mp\killstreaks\_emp_common::func_E24E();
  }
}

loadout_getclassstruct() {
  var_00 = spawnStruct();
  var_00.loadoutarchetype = "none";
  var_00.loadoutprimary = "none";
  var_00.loadoutprimaryattachments = [];
  for(var_01 = 0; var_01 < 6; var_01++) {
    var_00.loadoutprimaryattachments[var_01] = "none";
  }

  var_00.loadoutprimarycamo = "none";
  var_00.loadoutprimaryreticle = "none";
  var_00.loadoutprimarylootitemid = 0;
  var_00.loadoutprimaryvariantid = -1;
  var_00.loadoutprimarycosmeticattachment = "none";
  var_00.loadoutsecondary = "none";
  var_00.loadoutsecondaryattachments = [];
  for(var_01 = 0; var_01 < 5; var_01++) {
    var_00.loadoutsecondaryattachments[var_01] = "none";
  }

  var_00.loadoutsecondarycamo = "none";
  var_00.loadoutsecondaryreticle = "none";
  var_00.var_AE9E = 0;
  var_00.var_AEA5 = -1;
  var_00.loadoutsecondarycosmeticattachment = "none";
  var_00.loadoutperksfromgamemode = 0;
  var_00.loadoutperks = [];
  var_00.loadoutstandardperks = [];
  var_00.loadoutextraperks = [];
  var_00.loadoutrigtrait = "specialty_null";
  var_00.var_AE7B = "none";
  var_00.var_AE7C = [];
  var_00.loadoutextrapowerprimary = 0;
  var_00.var_AE7D = "none";
  var_00.var_AE7E = [];
  var_00.loadoutextrapowersecondary = 0;
  var_00.loadoutsuper = "none";
  var_00.loadoutgesture = "none";
  var_00.loadoutstreaksfilled = 0;
  var_00.loadoutstreaktype = "streaktype_assault";
  var_00.loadoutkillstreak1 = "none";
  var_00.loadoutkillstreak1variantid = -1;
  var_00.var_AE6F = [];
  var_00.loadoutkillstreak2 = "none";
  var_00.loadoutkillstreak2variantid = -1;
  var_00.var_AE71 = [];
  var_00.loadoutkillstreak3 = "none";
  var_00.loadoutkillstreak3variantid = -1;
  var_00.var_AE73 = [];
  return var_00;
}

loadout_updateclassteam(param_00, param_01, param_02) {
  param_02 = loadout_getclassteam(param_01);
  var_03 = scripts\mp\utility::getclassindex(param_01);
  self.class_num = var_03;
  self.classteam = param_02;
  param_00.loadoutarchetype = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "archetype");
  param_00.loadoutprimary = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 0, "weapon");
  if(param_00.loadoutprimary == "none") {
    param_00.loadoutprimary = "iw7_fists";
  } else {
    for(var_04 = 0; var_04 < 6; var_04++) {
      param_00.loadoutprimaryattachments[var_04] = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 0, "attachment", var_04);
    }
  }

  param_00.loadoutprimarycamo = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 0, "camo");
  param_00.loadoutprimaryreticle = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 0, "reticle");
  param_00.loadoutsecondary = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 1, "weapon");
  for(var_04 = 0; var_04 < 5; var_04++) {
    param_00.loadoutsecondaryattachments[var_04] = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 1, "attachment", var_04);
  }

  param_00.loadoutsecondarycamo = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 1, "camo");
  param_00.loadoutsecondaryreticle = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "weaponSetups", 1, "reticle");
  param_00.var_AE7B = "none";
  param_00.loadoutextrapowerprimary = 0;
  param_00.var_AE7D = "none";
  param_00.loadoutextrapowersecondary = 0;
  param_00.loadoutsuper = "none";
  param_00.loadoutgesture = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "class", "gesture");
  param_00.loadoutstreaksfilled = 1;
  param_00.loadoutkillstreak1 = recipe_getkillstreak(param_02, var_03, 0);
  param_00.loadoutkillstreak2 = recipe_getkillstreak(param_02, var_03, 1);
  param_00.loadoutkillstreak3 = recipe_getkillstreak(param_02, var_03, 2);
  param_00.var_AE6F = [];
  param_00.var_AE71 = [];
  param_00.var_AE73 = [];
  param_00.var_AE7C = [];
  param_00.var_AE7E = [];
  param_00.loadoutkillstreak1variantid = -1;
  param_00.loadoutkillstreak2variantid = -1;
  param_00.loadoutkillstreak3variantid = -1;
  if(scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", param_02, var_03, "juggernaut")) {
    func_AE23();
    return;
  }

  if(scripts\mp\utility::isjuggernaut()) {
    loadout_removejugg_MAYBE();
  }
}

loadout_updateclasscustom(param_00, param_01) {
  var_02 = scripts\mp\utility::getclassindex(param_01);
  self.class_num = var_02;
  param_00.loadoutarchetype = cac_getcharacterarchetype();
  param_00.loadoutprimary = cac_getweapon(var_02, 0);
  for(var_03 = 0; var_03 < 6; var_03++) {
    param_00.loadoutprimaryattachments[var_03] = cac_getweaponattachment(var_02, 0, var_03);
  }

  param_00.loadoutprimarycamo = cac_getweaponcamo(var_02, 0);
  param_00.loadoutprimaryreticle = cac_getweaponreticle(var_02, 0);
  param_00.loadoutprimarylootitemid = cac_getweaponlootitemid(var_02, 0);
  param_00.loadoutprimaryvariantid = cac_getweaponvariantid(var_02, 0);
  param_00.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_02, 0);
  param_00.loadoutsecondary = cac_getweapon(var_02, 1);
  for(var_03 = 0; var_03 < 5; var_03++) {
    param_00.loadoutsecondaryattachments[var_03] = cac_getweaponattachment(var_02, 1, var_03);
  }

  param_00.loadoutsecondarycamo = cac_getweaponcamo(var_02, 1);
  param_00.loadoutsecondaryreticle = cac_getweaponreticle(var_02, 1);
  param_00.var_AE9E = cac_getweaponlootitemid(var_02, 1);
  param_00.var_AEA5 = cac_getweaponvariantid(var_02, 1);
  param_00.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_02, 1);
  param_00.var_AE7B = cac_getpower(var_02);
  param_00.var_AE7C = cac_getpowerid(var_02);
  param_00.loadoutextrapowerprimary = cac_getextracharge(var_02);
  param_00.var_AE7D = cac_getpower2(var_02);
  param_00.var_AE7E = cac_getpower2id(var_02);
  param_00.loadoutextrapowersecondary = cac_getextracharge2(var_02);
  param_00.loadoutsuper = cac_getsuper();
  param_00.loadoutgesture = cac_getgesture();
  param_00.loadoutstreaksfilled = 1;
  param_00.loadoutkillstreak1 = cac_getkillstreak(0);
  param_00.var_AE6F = cac_getkillstreaklootid(var_02, 0);
  param_00.loadoutkillstreak1variantid = cac_getkillstreakvariantid(0);
  param_00.loadoutkillstreak2 = cac_getkillstreak(1);
  param_00.var_AE71 = cac_getkillstreaklootid(var_02, 1);
  param_00.loadoutkillstreak2variantid = cac_getkillstreakvariantid(1);
  param_00.loadoutkillstreak3 = cac_getkillstreak(2);
  param_00.var_AE73 = cac_getkillstreaklootid(var_02, 2);
  param_00.loadoutkillstreak3variantid = cac_getkillstreakvariantid(2);
}

loadout_updateclassgamemode(param_00, param_01) {
  var_02 = scripts\mp\utility::getclassindex(param_01);
  self.class_num = var_02;
  var_03 = self.pers["gamemodeLoadout"];
  if(isDefined(var_03["loadoutArchetype"])) {
    param_00.loadoutarchetype = var_03["loadoutArchetype"];
    if(isbot(self)) {
      self.botarchetype = var_03["loadoutArchetype"];
    }
  } else if(isbot(self)) {
    var_04 = scripts\mp\bots\_bots_loadout::bot_loadout_class_callback();
    param_00.loadoutarchetype = var_04["loadoutArchetype"];
  } else {
    param_00.loadoutarchetype = cac_getcharacterarchetype();
  }

  if(isDefined(var_03["loadoutRigTrait"])) {
    param_00.loadoutrigtrait = var_03["loadoutRigTrait"];
  }

  if(isDefined(var_03["loadoutPrimary"])) {
    param_00.loadoutprimary = var_03["loadoutPrimary"];
  }

  for(var_05 = 0; var_05 < 6; var_05++) {
    var_06 = getattachmentloadoutstring(var_05, "primary");
    if(isDefined(var_03[var_06])) {
      param_00.loadoutprimaryattachments[var_05] = var_03[var_06];
    }
  }

  if(isDefined(var_03["loadoutPrimaryCamo"])) {
    param_00.loadoutprimarycamo = var_03["loadoutPrimaryCamo"];
  }

  if(isDefined(var_03["loadoutPrimaryReticle"])) {
    param_00.loadoutprimaryreticle = var_03["loadoutPrimaryReticle"];
  }

  if(isDefined(var_03["loadoutSecondary"])) {
    param_00.loadoutsecondary = var_03["loadoutSecondary"];
  }

  for(var_05 = 0; var_05 < 5; var_05++) {
    var_06 = getattachmentloadoutstring(var_05, "secondary");
    if(isDefined(var_03[var_06])) {
      param_00.loadoutsecondaryattachments[var_05] = var_03[var_06];
    }
  }

  if(isDefined(var_03["loadoutSecondaryCamo"])) {
    param_00.loadoutsecondarycamo = var_03["loadoutSecondaryCamo"];
  }

  if(isDefined(var_03["loadoutSecondaryReticle"])) {
    param_00.loadoutsecondaryreticle = var_03["loadoutSecondaryReticle"];
  }

  param_00.loadoutperksfromgamemode = isDefined(var_03["loadoutPerks"]);
  if(isDefined(var_03["loadoutPerks"])) {
    param_00.loadoutperks = var_03["loadoutPerks"];
  }

  if(isDefined(var_03["loadoutPowerPrimary"])) {
    param_00.var_AE7B = var_03["loadoutPowerPrimary"];
  }

  if(isDefined(var_03["loadoutExtraPowerPrimary"])) {
    param_00.loadoutextrapowerprimary = var_03["loadoutExtraPowerPrimary"];
  }

  if(isDefined(var_03["loadoutPowerPrimaryPassives"])) {
    param_00.var_AE7C = var_03["loadoutPowerPrimaryPassives"];
  }

  if(isDefined(var_03["loadoutPowerSecondary"])) {
    param_00.var_AE7D = var_03["loadoutPowerSecondary"];
  }

  if(isDefined(var_03["loadoutExtraPowerSecondary"])) {
    param_00.loadoutextrapowersecondary = var_03["loadoutExtraPowerSecondary"];
  }

  if(isDefined(var_03["loadoutPowerSecondaryPassives"])) {
    param_00.var_AE7E = var_03["loadoutPowerSecondaryPassives"];
  }

  if(isDefined(var_03["loadoutSuper"])) {
    param_00.loadoutsuper = var_03["loadoutSuper"];
  }

  if(isDefined(var_03["loadoutGesture"]) && var_03["loadoutGesture"] == "playerData") {
    if(isbot(self)) {
      param_00.loadoutgesture = "none";
    } else {
      param_00.loadoutgesture = cac_getgesture();
    }
  } else if(isDefined(var_03["loadoutGesture"])) {
    param_00.loadoutgesture = var_03["loadoutGesture"];
  }

  if((isDefined(var_03["loadoutKillstreak1"]) && var_03["loadoutKillstreak1"] != "specialty_null") || isDefined(var_03["loadoutKillstreak2"]) && var_03["loadoutKillstreak2"] != "specialty_null" || isDefined(var_03["loadoutKillstreak3"]) && var_03["loadoutKillstreak3"] != "specialty_null") {
    param_00.loadoutstreaksfilled = 1;
    param_00.loadoutkillstreak1 = var_03["loadoutKillstreak1"];
    param_00.loadoutkillstreak2 = var_03["loadoutKillstreak2"];
    param_00.loadoutkillstreak3 = var_03["loadoutKillstreak3"];
    if(isDefined(var_03["loadoutKillstreak1Passives"])) {
      param_00.var_AE6F = var_03["loadoutKillstreak1Passives"];
    }

    if(isDefined(var_03["loadoutKillstreak2Passives"])) {
      param_00.var_AE71 = var_03["loadoutKillstreak2Passives"];
    }

    if(isDefined(var_03["loadoutKillstreak3Passives"])) {
      param_00.var_AE73 = var_03["loadoutKillstreak3Passives"];
    }
  }

  if(var_03["loadoutJuggernaut"]) {
    func_AE23();
    return;
  }

  if(scripts\mp\utility::isjuggernaut()) {
    loadout_removejugg_MAYBE();
  }
}

func_AE50(param_00) {
  param_00.loadoutprimary = "iw7_chargeshot_c8";
  param_00.loadoutsecondary = "iw7_c8landing";
}

loadout_updateclasscallback(param_00) {
  if(!isDefined(self.classcallback)) {
    scripts\engine\utility::error("self.classCallback function reference required for class \'callback\'");
  }

  var_01 = self[[self.classcallback]]();
  if(!isDefined(var_01)) {
    scripts\engine\utility::error("array required from self.classCallback for class \'callback\'");
  }

  if(isDefined(var_01["loadoutArchetype"])) {
    param_00.loadoutarchetype = var_01["loadoutArchetype"];
  }

  if(isDefined(var_01["loadoutPrimary"])) {
    param_00.loadoutprimary = var_01["loadoutPrimary"];
  }

  for(var_02 = 0; var_02 < 6; var_02++) {
    var_03 = getattachmentloadoutstring(var_02, "primary");
    if(isDefined(var_01[var_03])) {
      param_00.loadoutprimaryattachments[var_02] = var_01[var_03];
    }
  }

  if(isDefined(var_01["loadoutPrimaryCamo"])) {
    param_00.loadoutprimarycamo = var_01["loadoutPrimaryCamo"];
  }

  if(isDefined(var_01["loadoutPrimaryReticle"])) {
    param_00.loadoutprimaryreticle = var_01["loadoutPrimaryReticle"];
  }

  if(isDefined(var_01["loadoutSecondary"])) {
    param_00.loadoutsecondary = var_01["loadoutSecondary"];
  }

  for(var_02 = 0; var_02 < 5; var_02++) {
    var_03 = getattachmentloadoutstring(var_02, "secondary");
    if(isDefined(var_01[var_03])) {
      param_00.loadoutsecondaryattachments[var_02] = var_01[var_03];
    }
  }

  if(isDefined(var_01["loadoutSecondaryCamo"])) {
    param_00.loadoutsecondarycamo = var_01["loadoutSecondaryCamo"];
  }

  if(isDefined(var_01["loadoutSecondaryReticle"])) {
    param_00.loadoutsecondaryreticle = var_01["loadoutSecondaryReticle"];
  }

  if(isDefined(var_01["loadoutPowerPrimary"])) {
    param_00.var_AE7B = var_01["loadoutPowerPrimary"];
  }

  if(isDefined(var_01["loadoutPowerPrimaryPassives"])) {
    param_00.var_AE7C = var_01["loadoutPowerPrimaryPassives"];
  }

  if(isDefined(var_01["loadoutExtraPowerPrimary"])) {
    param_00.loadoutextrapowerprimary = var_01["loadoutExtraPowerPrimary"];
  }

  if(isDefined(var_01["loadoutPowerSecondary"])) {
    param_00.var_AE7D = var_01["loadoutPowerSecondary"];
  }

  if(isDefined(var_01["loadoutPowerSecondaryPassives"])) {
    param_00.var_AE7E = var_01["loadoutPowerSecondaryPassives"];
  }

  if(isDefined(var_01["loadoutExtraPowerSecondary"])) {
    param_00.loadoutextrapowersecondary = var_01["loadoutPowerExtraSecondary"];
  }

  if(isDefined(var_01["loadoutSuper"])) {
    param_00.loadoutsuper = var_01["loadoutSuper"];
  }

  if(isDefined(var_01["loadoutGesture"])) {
    param_00.loadoutgesture = var_01["loadoutGesture"];
  }

  param_00.loadoutstreaksfilled = isDefined(var_01["loadoutStreak1"]) || isDefined(var_01["loadoutStreak2"]) || isDefined(var_01["loadoutStreak3"]);
  if(isDefined(var_01["loadoutStreakType"])) {
    param_00.loadoutstreaktype = var_01["loadoutStreakType"];
  }

  if(isDefined(var_01["loadoutStreak1"])) {
    param_00.loadoutkillstreak1 = var_01["loadoutStreak1"];
  }

  if(isDefined(var_01["loadoutStreak2"])) {
    param_00.loadoutkillstreak2 = var_01["loadoutStreak2"];
  }

  if(isDefined(var_01["loadoutStreak3"])) {
    param_00.loadoutkillstreak3 = var_01["loadoutStreak3"];
  }

  if(isDefined(var_01["loadoutKillstreak1Passives"])) {
    param_00.var_AE6F = var_01["loadoutKillstreak1Passives"];
  }

  if(isDefined(var_01["loadoutKillstreak2Passives"])) {
    param_00.var_AE71 = var_01["loadoutKillstreak2Passives"];
  }

  if(isDefined(var_01["loadoutKillstreak3Passives"])) {
    param_00.var_AE73 = var_01["loadoutKillstreak3Passives"];
  }
}

loadout_updateclassdefault(param_00, param_01) {
  var_02 = scripts\mp\utility::getclassindex(param_01);
  self.class_num = var_02;
  param_00.loadoutprimary = table_getweapon(level.classtablename, var_02, 0);
  for(var_03 = 0; var_03 < 6; var_03++) {
    param_00.loadoutprimaryattachments[var_03] = table_getweaponattachment(level.classtablename, var_02, 0, var_03);
  }

  param_00.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_02, 0);
  param_00.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_02, 0);
  param_00.loadoutsecondary = table_getweapon(level.classtablename, var_02, 1);
  for(var_03 = 0; var_03 < 5; var_03++) {
    param_00.loadoutsecondaryattachments[var_03] = table_getweaponattachment(level.classtablename, var_02, 1, var_03);
  }

  param_00.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_02, 1);
  param_00.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_02, 1);
  param_00.var_AE7B = table_getpowerprimary_MAYBE(level.classtablename, var_02);
  param_00.loadoutextrapowerprimary = table_getextrapowerprimary_MAYBE(level.classtablename, var_02);
  param_00.var_AE7D = table_getpowersecondary_MAYBE(level.classtablename, var_02);
  param_00.loadoutextrapowersecondary = table_getextrapowersecondary_MAYBE(level.classtablename, var_02);
  param_00.loadoutgesture = table_getgesture(level.classtablename, var_02);
  param_00.loadoutarchetype = cac_getcharacterarchetype();
  param_00.loadoutsuper = cac_getsuper();
  param_00.loadoutkillstreak1 = cac_getkillstreak(0);
  param_00.loadoutkillstreak2 = cac_getkillstreak(1);
  param_00.loadoutkillstreak3 = cac_getkillstreak(2);
  param_00.loadoutrigtrait = cac_getloadoutarchetypeperk();
  param_00.loadoutgesture = cac_getgesture();
}

loadout_updatestreaktype(param_00) {
  self.streaktype = "streaktype_assault";
  param_00.loadoutstreaktype = self.streaktype;
}

loadout_updateabilities(param_00, param_01) {
  if(!isDefined(self.pers["loadoutPerks"])) {
    self.pers["loadoutPerks"] = [];
  }

  if(!isDefined(self.pers["loadoutStandardPerks"])) {
    self.pers["loadoutStandardPerks"] = [];
  }

  if(!isDefined(self.pers["loadoutExtraPerks"])) {
    self.pers["loadoutExtraPerks"] = [];
  }

  if(!isDefined(self.pers["loadoutRigTrait"])) {
    self.pers["loadoutRigTrait"] = [];
  }

  if(scripts\mp\utility::isjuggernaut()) {
    return;
  }

  var_02 = getsubstr(param_01, 0, 7) == "default";
  if(param_00.loadoutperksfromgamemode) {
    return;
  }

  if(!scripts\mp\utility::perksenabled()) {
    return;
  }

  if(isai(self)) {
    if(isDefined(self.pers["loadoutPerks"])) {
      param_00.loadoutperks = self.pers["loadoutPerks"];
      return;
    }

    return;
  }

  if(haschangedclass() || haschangedarchetype()) {
    var_03 = loadout_getclassteam(param_01);
    for(var_04 = 0; var_04 < 3; var_04++) {
      var_05 = "specialty_null";
      if(var_03 != "none") {
        var_06 = scripts\mp\utility::getclassindex(param_01);
        var_05 = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", var_03, var_06, "class", "loadoutPerks");
      } else if(var_02) {
        var_06 = scripts\mp\utility::getclassindex(param_01);
        var_05 = table_getperk(level.classtablename, var_06, var_04);
      } else {
        var_05 = cac_getloadoutperk(self.class_num, var_04);
      }

      if(var_05 != "specialty_null") {
        param_00.loadoutperks[param_00.loadoutperks.size] = var_05;
        param_00.loadoutstandardperks[param_00.loadoutstandardperks.size] = var_05;
      }
    }

    for(var_04 = 0; var_04 < 3; var_04++) {
      var_05 = "specialty_null";
      if(var_03 != "none") {
        var_06 = scripts\mp\utility::getclassindex(param_01);
        var_05 = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", var_03, var_06, "class", "extraPerks");
      } else if(var_02) {
        var_06 = scripts\mp\utility::getclassindex(param_01);
        var_05 = table_getextraperk(level.classtablename, var_06, var_04);
      } else {
        var_05 = cac_getloadoutextraperk(self.class_num, var_04);
      }

      if(var_05 != "specialty_null") {
        param_00.loadoutperks[param_00.loadoutperks.size] = var_05;
        param_00.loadoutextraperks[param_00.loadoutextraperks.size] = var_05;
      }
    }

    var_05 = "specialty_null";
    if(var_03 != "none") {
      var_06 = scripts\mp\utility::getclassindex(param_01);
      var_05 = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", var_03, var_06, "class", "archetypePerk");
    } else {
      var_05 = cac_getloadoutarchetypeperk();
    }

    if(var_05 != "specialty_null") {
      param_00.loadoutperks[param_00.loadoutperks.size] = var_05;
      self.pers["loadoutRigTrait"] = var_05;
      param_00.loadoutrigtrait = var_05;
      return;
    }

    return;
  }

  param_00.loadoutperks = self.pers["loadoutPerks"];
  param_00.loadoutstandardperks = self.pers["loadoutStandardPerks"];
  param_00.loadoutextraperks = self.pers["loadoutExtraPerks"];
  param_00.loadoutrigtrait = self.pers["loadoutRigTrait"];
}

loadout_updateclass(param_00, param_01) {
  var_02 = loadout_getclassteam(param_01);
  if(var_02 != "none") {
    loadout_updateclassteam(param_00, param_01);
  } else if(issubstr(param_01, "custom")) {
    loadout_updateclasscustom(param_00, param_01);
  } else if(param_01 == "gamemode") {
    loadout_updateclassgamemode(param_00, param_01);
  } else if(param_01 == "rc8Agent") {
    func_AE50(param_00);
  } else if(param_01 == "callback") {
    loadout_updateclasscallback(param_00);
  } else {
    loadout_updateclassdefault(param_00, param_01);
  }

  loadout_updateclassfistweapons(param_00);
  loadout_updatestreaktype(param_00);
  loadout_updateabilities(param_00, param_01);
  param_00 = loadout_validateclass(param_00, param_01);
  return param_00;
}

loadout_updateclassfistweapons(param_00) {
  if(param_00.loadoutprimary == "none") {
    param_00.loadoutprimary = "iw7_fists";
  }

  if(param_00.loadoutsecondary == "none" && param_00.loadoutprimary != "iw7_fists") {
    param_00.loadoutsecondary = "iw7_fists";
    return;
  }

  if(param_00.loadoutprimary == "iw7_fists" && param_00.loadoutsecondary == "iw7_fists") {
    param_00.loadoutsecondary = "none";
  }
}

loadout_validateclass(param_00, param_01) {
  if(issubstr(param_01, "custom")) {
    return scripts\mp\validation::validateloadout(param_00);
  }

  return param_00;
}

loadout_forcearchetype(param_00) {
  var_01 = getdvarint("forceArchetype", 0);
  if(var_01 > 0) {
    var_02 = getdvarint("forceArchetype", 0);
    switch (var_02) {
      case 1:
        param_00.loadoutarchetype = "archetype_assault";
        break;

      case 2:
        param_00.loadoutarchetype = "archetype_heavy";
        break;

      case 3:
        param_00.loadoutarchetype = "archetype_scout";
        break;

      case 4:
        param_00.loadoutarchetype = "archetype_assassin";
        break;

      case 5:
        param_00.loadoutarchetype = "archetype_engineer";
        break;

      case 6:
        param_00.loadoutarchetype = "archetype_sniper";
        break;

      case 7:
        param_00.loadoutarchetype = "archetype_reaper";
        break;

      default:
        param_00.loadoutarchetype = "archetype_assault";
        break;
    }

    return;
  }

  if(var_01 == -1) {
    var_03 = ["archetype_assault", "archetype_heavy", "archetype_scout", "archetype_assassin", "archetype_engineer", "archetype_sniper"];
    var_04 = randomint(var_03.size);
    param_00.loadoutarchetype = var_03[var_04];
    self iprintlnbold("Random Archetype: " + var_03[var_04]);
  }
}

loadout_updateplayerarchetype(param_00) {
  if(!scripts\engine\utility::istrue(self.btestclient)) {
    if(!isDefined(level.aonrules) || level.aonrules == 0) {}
  }

  self.loadoutarchetype = param_00.loadoutarchetype;
  scripts\mp\weapons::updatemovespeedscale();
  var_01 = 1;
  var_02 = 2;
  var_03 = 4;
  var_04 = 8;
  var_05 = "defaultsuit_mp";
  var_06 = 0;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = 400;
  var_0A = 400;
  var_0B = 900;
  if(level.tactical) {
    var_0A = 133.3333;
    var_0B = 1800;
  }

  switch (self.loadoutarchetype) {
    case "archetype_assault":
      var_05 = "assault_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = ::scripts\mp\archetypes\archassault::applyarchetype;
      var_08 = "vestlight";
      break;

    case "archetype_heavy":
      var_05 = "armor_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = ::scripts\mp\archetypes\archheavy::applyarchetype;
      var_08 = "vestheavy";
      break;

    case "archetype_scout":
      var_05 = "scout_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = ::scripts\mp\archetypes\archscout::applyarchetype;
      var_08 = "c6servo";
      break;

    case "archetype_assassin":
      var_05 = "assassin_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = ::scripts\mp\archetypes\archassassin::applyarchetype;
      var_08 = "vestftl";
      break;

    case "archetype_engineer":
      var_05 = "engineer_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = ::scripts\mp\archetypes\archengineer::applyarchetype;
      var_08 = "vestlight";
      break;

    case "archetype_sniper":
      var_05 = "sniper_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = ::scripts\mp\archetypes\archsniper::applyarchetype;
      var_08 = "vestghost";
      break;

    default:
      if(!scripts\engine\utility::istrue(self.btestclient)) {
        if(!isDefined(level.aonrules) || level.aonrules == 0) {}
      }
      break;
  }

  if(level.tactical) {
    var_05 = var_05 + "_tactical";
    var_01 = 0;
  }

  self _meth_845E(0);
  self allowdoublejump(var_06 & var_01);
  self allowslide(var_06 & var_02);
  self allowwallrun(var_06 & var_03);
  self allowdodge(var_06 & var_04);
  self allowlean(0);
  self setsuit(var_05);
  self energy_setmax(0, var_09);
  self goal_radius(0, var_09);
  self goalflag(0, var_0A);
  self goal_type(0, var_0B);
  self energy_setmax(1, 50);
  self goal_radius(1, 50);
  self goalflag(1, 10);
  self goal_type(1, scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 2500, 0));
  if(isDefined(level.supportdoublejump_MAYBE)) {
    if(!level.supportdoublejump_MAYBE) {
      scripts\engine\utility::allow_doublejump(0);
    }
  }

  if(isDefined(level.supportwallrun_MAYBE)) {
    if(!level.supportwallrun_MAYBE) {
      scripts\engine\utility::allow_wallrun(0);
    }
  }

  if(isDefined(var_07)) {
    self[[var_07]]();
  }

  if(isDefined(var_08)) {
    self give_explosive_touch_on_revived(var_08);
    if(var_08 == "c6servo") {
      self _meth_8460("clothtype", "c6servo");
    } else {
      self _meth_8460("clothtype", "");
    }

    self.var_42B0 = var_08;
  }

  thread scripts\mp\archetypes\archcommon::func_EF38();
  thread scripts\mp\archetypes\archcommon::func_EF41();
}

loadout_updateclassfinalweapons(param_00) {
  if(isDefined(self.class_num)) {
    param_00.var_AE8B = self.class_num * 2 + 0;
    param_00.var_AE9F = self.class_num * 2 + 1;
  } else {
    param_00.var_AE8B = -1;
    param_00.var_AE9F = -1;
  }

  param_00.loadoutprimaryfullname = buildweaponname(param_00.loadoutprimary, param_00.loadoutprimaryattachments, param_00.loadoutprimarycamo, param_00.loadoutprimaryreticle, param_00.loadoutprimaryvariantid, self getentitynumber(), self.clientid, param_00.var_AE8B, param_00.loadoutprimarycosmeticattachment);
  if(param_00.loadoutsecondary == "none") {
    param_00.loadoutsecondaryfullname = "none";
    return;
  }

  param_00.loadoutsecondaryfullname = buildweaponname(param_00.loadoutsecondary, param_00.loadoutsecondaryattachments, param_00.loadoutsecondarycamo, param_00.loadoutsecondaryreticle, param_00.var_AEA5, self getentitynumber(), self.clientid, param_00.var_AE9F, param_00.loadoutsecondarycosmeticattachment);
}

loadout_updateplayerweapons(param_00, param_01, param_02) {
  if(getdvarint("scr_require_loot", 0) == 1 && !scripts\mp\utility::istrue(self.var_54BC)) {
    if(param_00.loadoutprimarylootitemid == 0 && param_00.var_AE9E == 0) {
      iprintlnbold(self.name + " is not using a loot weapon!");
      self.var_54BC = 1;
    }
  }

  if(param_01 == "rc8Agent") {
    return;
  }

  loadout_updateclassfinalweapons(param_00);
  self.loadoutprimary = param_00.loadoutprimary;
  self.loadoutprimarycamo = param_00.loadoutprimarycamo;
  self.loadoutsecondary = param_00.loadoutsecondary;
  self.loadoutsecondarycamo = param_00.loadoutsecondarycamo;
  self.loadoutprimaryattachments = param_00.loadoutprimaryattachments;
  self.loadoutsecondaryattachments = param_00.loadoutsecondaryattachments;
  self.loadoutprimaryreticle = param_00.loadoutprimaryreticle;
  self.loadoutsecondaryreticle = param_00.loadoutsecondaryreticle;
  self.loadoutprimarylootitemid = param_00.loadoutprimarylootitemid;
  self.loadoutprimaryvariantid = param_00.loadoutprimaryvariantid;
  self.var_AE9E = param_00.var_AE9E;
  self.var_AEA5 = param_00.var_AEA5;
  var_03 = scripts\mp\weapons::updatesavedaltstate(param_00.loadoutprimaryfullname);
  scripts\mp\utility::_giveweapon(var_03, undefined, undefined, getweaponbasename(var_03) == "iw7_fists_mp");
  scripts\mp\weapons::updatetogglescopestate(param_00.loadoutprimaryfullname);
  scripts\mp\perks\_weaponpassives::loadoutweapongiven(param_00.loadoutprimaryfullname);
  var_04 = "none";
  if(param_00.loadoutsecondary != "none") {
    var_04 = scripts\mp\weapons::updatesavedaltstate(param_00.loadoutsecondaryfullname);
    scripts\mp\utility::_giveweapon(var_04, undefined, undefined, 1);
    scripts\mp\weapons::updatetogglescopestate(param_00.loadoutsecondaryfullname);
    if(scripts\mp\utility::getweaponrootname(var_04) == "iw7_axe") {
      self setweaponammoclip(var_04, 1);
    }

    scripts\mp\perks\_weaponpassives::loadoutweapongiven(param_00.loadoutsecondaryfullname);
  }

  var_05 = var_03;
  if(var_04 != "none" && getweaponbasename(var_05) == "iw7_fists_mp") {
    var_05 = var_04;
  }

  if(!isai(self)) {
    self.saved_lastweaponhack = undefined;
    scripts\mp\utility::_switchtoweapon(var_05);
  }

  if(!isDefined(param_02) || param_02) {
    var_06 = !scripts\mp\utility::gameflag("prematch_done") && !scripts\mp\weapons::isaltmodeweapon(var_05);
    self setspawnweapon(var_05, var_06);
  }

  self.primaryweapon = param_00.loadoutprimaryfullname;
  self.secondaryweapon = param_00.loadoutsecondaryfullname;
  self.spawnweaponobj = var_05;
  self.pers["primaryWeapon"] = param_00.loadoutprimaryfullname;
  self.pers["secondaryWeapon"] = param_00.loadoutsecondaryfullname;
  scripts\mp\teams::func_FADC();
  scripts\mp\weapons::updatemovespeedscale();
  thread scripts\mp\weapons::func_13BA9();
}

loadout_updateplayerperks(param_00) {
  scripts\mp\utility::giveperk("specialty_marathon");
  scripts\mp\utility::giveperk("specialty_sharp_focus");
  scripts\mp\utility::giveperk("specialty_silentdoublejump");
  if(param_00.loadoutperks.size > 0) {
    scripts\mp\perks\_perks::giveperks(param_00.loadoutperks, 0);
  }

  self.pers["loadoutPerks"] = param_00.loadoutperks;
  self.pers["loadoutStandardPerks"] = param_00.loadoutstandardperks;
  self.pers["loadoutExtraPerks"] = param_00.loadoutextraperks;
  self.pers["loadoutRigTrait"] = param_00.loadoutrigtrait;
  self setclientomnvar("ui_trait_ref", scripts\mp\perks\_perks::getequipmenttableinfo(self.pers["loadoutRigTrait"]));
  if(!scripts\mp\utility::isjuggernaut() && isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0) {
    thread scripts\mp\perks\_perks::giveperksafterspawn();
  }
}

loadout_updateplayerpowers_MAYBE(param_00) {
  self.powers = [];
  self.var_AE7B = param_00.var_AE7B;
  self.var_AE7D = param_00.var_AE7D;
  scripts\mp\powers::givepower(param_00.var_AE7B, "primary", 0, param_00.var_AE7C, param_00.loadoutextrapowerprimary);
  scripts\mp\powers::givepower(param_00.var_AE7D, "secondary", 0, param_00.var_AE7E, param_00.loadoutextrapowersecondary);
}

loadout_updateplayersuper(param_00) {
  var_01 = param_00.loadoutsuper;
  if(isbot(self) && level.allowsupers) {
    if(isDefined(self.loadoutsuper)) {
      var_01 = self.loadoutsuper;
    } else {
      var_01 = scripts\mp\bots\_bots_supers::func_2EE9();
    }

    param_00.loadoutsuper = var_01;
    if(isDefined(self.loadoutrigtrait)) {
      var_02 = self.loadoutrigtrait;
    } else if(isDefined(var_01.loadoutrigtrait) && self.class == "gamemode") {
      var_02 = var_01.loadoutrigtrait;
    } else {
      var_02 = scripts\mp\bots\_bots_supers::botpicktrait();
    }

    param_00.loadoutrigtrait = var_02;
    self.pers["loadoutRigTrait"] = var_02;
    if(var_02 != "specialty_null") {
      scripts\mp\utility::giveperk(var_02);
      self setclientomnvar("ui_trait_ref", scripts\mp\perks\_perks::getequipmenttableinfo(self.pers["loadoutRigTrait"]));
    }
  }

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    var_03 = scripts\mp\supers::getcurrentsuperref();
    if(var_03 == var_01 && !haschangedarchetype()) {
      scripts\mp\supers::givesuperweapon(self.super);
      return;
    }
  }

  if(var_01 == "none" || !level.allowsupers) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
    return;
  }

  if(level.allowsupers && isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["loadoutSuper"])) {
    self.loadoutsuper = self.pers["gamemodeLoadout"]["loadoutSuper"];
    scripts\mp\supers::stopridingvehicle(self.loadoutsuper, 1);
    return;
  }

  self.loadoutsuper = var_01;
  scripts\mp\supers::stopridingvehicle(var_01, 1);
}

loadout_updateplayergesture(param_00) {
  if(!scripts\engine\utility::istrue(self.btestclient)) {
    if(param_00.loadoutgesture != "none") {
      self.loadoutgesture = param_00.loadoutgesture;
      scripts\mp\gestures_mp::givegesture(param_00.loadoutgesture);
    }
  }
}

loadout_updateplayerstreaktype(param_00) {
  self.streaktype = loadout_getplayerstreaktype(param_00.loadoutstreaktype);
}

loadout_updateplayerkillstreaks(param_00, param_01) {
  if(!level.allowkillstreaks) {
    param_00.loadoutkillstreak1 = "none";
    param_00.loadoutkillstreak2 = "none";
    param_00.loadoutkillstreak3 = "none";
  }

  self.streakvariantids = [];
  self.streakvariantids[param_00.loadoutkillstreak1] = param_00.loadoutkillstreak1variantid;
  self.streakvariantids[param_00.loadoutkillstreak2] = param_00.loadoutkillstreak2variantid;
  self.streakvariantids[param_00.loadoutkillstreak3] = param_00.loadoutkillstreak3variantid;
  if(param_00.loadoutstreaksfilled == 0 && isDefined(self.var_A6AB) && self.var_A6AB.size > 0 && param_01 == "gamemode" || issubstr(param_01, "juggernaut")) {
    var_02 = 0;
    foreach(var_04 in self.var_A6AB) {
      if(var_02 == 0) {
        param_00.loadoutkillstreak1 = var_04;
        var_02++;
        continue;
      }

      if(var_02 == 1) {
        param_00.loadoutkillstreak2 = var_04;
        var_02++;
        continue;
      }

      if(var_02 == 2) {
        param_00.loadoutkillstreak3 = var_04;
        break;
      }
    }
  }

  level.sortedkillstreaksbycost = getsortedkillstreaksbycost(param_00);
  param_00.loadoutkillstreak1 = level.sortedkillstreaksbycost[0];
  param_00.loadoutkillstreak2 = level.sortedkillstreaksbycost[1];
  param_00.loadoutkillstreak3 = level.sortedkillstreaksbycost[2];
  if(param_01 == "gamemode" && self.streaktype == "specialist") {
    self.pers["gamemodeLoadout"]["loadoutKillstreak1"] = param_00.loadoutkillstreak1;
    self.pers["gamemodeLoadout"]["loadoutKillstreak2"] = param_00.loadoutkillstreak2;
    self.pers["gamemodeLoadout"]["loadoutKillstreak3"] = param_00.loadoutkillstreak3;
  }

  func_F775(param_00.loadoutkillstreak1, param_00.loadoutkillstreak2, param_00.loadoutkillstreak3);
  var_06 = 0;
  if(!isagent(self)) {
    var_06 = scripts\mp\killstreaks\_killstreaks::func_213F([param_00.loadoutkillstreak1, param_00.loadoutkillstreak2, param_00.loadoutkillstreak3]);
  }

  if(!isagent(self) && !var_06) {
    self notify("givingLoadout");
    var_07 = scripts\mp\killstreaks\_killstreaks::func_7ED6();
    var_08 = scripts\mp\killstreaks\_killstreaks::func_7DE7();
    if(!scripts\mp\utility::_hasperk("specialty_support_killstreaks") && !isDefined(self.var_5FBD)) {
      scripts\mp\killstreaks\_killstreaks::func_41C0();
    }

    if(isDefined(param_00.loadoutkillstreak1) && param_00.loadoutkillstreak1 != "none" && param_00.loadoutkillstreak1 != "") {
      scripts\mp\killstreaks\_killstreaks::func_66B9(param_00.loadoutkillstreak1, param_00.var_AE6F, param_00.loadoutkillstreak1variantid);
    }

    if(isDefined(param_00.loadoutkillstreak2) && param_00.loadoutkillstreak2 != "none" && param_00.loadoutkillstreak2 != "") {
      scripts\mp\killstreaks\_killstreaks::func_66BB(param_00.loadoutkillstreak2, param_00.var_AE71, param_00.loadoutkillstreak2variantid);
    }

    if(isDefined(param_00.loadoutkillstreak3) && param_00.loadoutkillstreak3 != "none" && param_00.loadoutkillstreak3 != "") {
      scripts\mp\killstreaks\_killstreaks::func_66BA(param_00.loadoutkillstreak3, param_00.var_AE73, param_00.loadoutkillstreak3variantid);
    }

    for(var_09 = var_07.size - 1; var_09 >= 0; var_09--) {
      scripts\mp\killstreaks\_killstreaks::func_26D5(var_07[var_09]);
    }

    for(var_09 = 0; var_09 < var_08.size; var_09++) {
      scripts\mp\killstreaks\_killstreaks::func_26D5(var_08[var_09]);
    }
  }

  self notify("equipKillstreaksFinished");
}

getsortedkillstreaksbycost(param_00) {
  var_01 = [param_00.loadoutkillstreak1, param_00.loadoutkillstreak2, param_00.loadoutkillstreak3];
  for(var_02 = 0; var_02 < var_01.size - 1; var_02++) {
    if(isDefined(var_01[var_02]) && var_01[var_02] != "none" && var_01[var_02] != "") {
      for(var_03 = var_02 + 1; var_03 < var_01.size; var_03++) {
        if(isDefined(var_01[var_03]) && var_01[var_03] != "none" && var_01[var_03] != "") {
          var_04 = scripts\mp\killstreaks\_killstreaks::getstreakcost(var_01[var_02]);
          var_05 = scripts\mp\killstreaks\_killstreaks::getstreakcost(var_01[var_03]);
          if(var_05 < var_04) {
            var_06 = var_01[var_03];
            var_01[var_03] = var_01[var_02];
            var_01[var_02] = var_06;
          }
        }
      }
    }
  }

  return var_01;
}

loadout_updateplayer(param_00, param_01, param_02) {
  loadout_updateplayerstreaktype(param_00);
  loadout_updateplayerarchetype(param_00);
  loadout_updateplayerweapons(param_00, param_01, param_02);
  loadout_updateplayerperks(param_00);
  loadout_updateplayerpowers_MAYBE(param_00);
  loadout_updateplayersuper(param_00);
  loadout_updateplayergesture(param_00);
  loadout_updateplayerkillstreaks(param_00, param_01);
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
}

setmlgspectatorclientloadoutdata(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 notify("setMLGSpectatorClientLoadoutData()");
  param_00 endon("setMLGSpectatorClientLoadoutData()");
  param_00 setclientweaponinfo(0, param_01.loadoutprimaryfullname);
  param_00 setclientweaponinfo(1, param_01.loadoutsecondaryfullname);
  var_02 = scripts\mp\powers::func_D738(param_01.var_AE7B);
  param_00 getrandomindex("primaryPower", var_02);
  var_03 = scripts\mp\powers::func_D738(param_01.var_AE7D);
  param_00 getrandomindex("secondaryPower", var_03);
  var_04 = scripts\mp\supers::_meth_8186(param_01.loadoutsuper);
  param_00 getrandomindex("super", var_04);
  if(isai(param_00)) {
    for(var_05 = 0; var_05 < param_01.loadoutperks.size; var_05++) {
      var_06 = param_01.loadoutperks[var_05];
      var_07 = scripts\mp\perks\_perks::getequipmenttableinfo(var_06);
      param_00 getrandomindex(var_05 + 1 + "_perk", var_07);
    }
  } else {
    if(var_04.loadoutperksfromgamemode) {
      var_04.loadoutstandardperks = var_04.loadoutperks;
    }

    for(var_05 = 0; var_05 < param_01.loadoutstandardperks.size; var_05++) {
      var_06 = param_01.loadoutstandardperks[var_05];
      var_07 = scripts\mp\perks\_perks::getequipmenttableinfo(var_06);
      param_00 getrandomindex(var_05 + 1 + "_perk", var_07);
    }

    for(var_05 = 0; var_05 < param_01.loadoutextraperks.size; var_05++) {
      var_06 = param_01.loadoutextraperks[var_05];
      var_07 = scripts\mp\perks\_perks::getequipmenttableinfo(var_06);
      param_00 getrandomindex(var_05 + 1 + "_extraPerk", var_07);
    }
  }

  var_08 = param_01.loadoutrigtrait;
  var_09 = scripts\mp\perks\_perks::getequipmenttableinfo(var_08);
  param_00 getrandomindex("rigTrait", var_09);
  var_0A = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(param_01.loadoutarchetype);
  param_00 getrandomindex("archetype", var_0A);
  param_00 setclientextrasuper(0, param_01.loadoutextrapowerprimary);
  param_00 setclientextrasuper(1, param_01.loadoutextrapowersecondary);
}

shouldallowinstantclassswap() {
  return level.ingraceperiod && level._meth_8487 - level.ingraceperiod >= 0 && level._meth_8487 - level.ingraceperiod < 5 && !self.hasdonecombat;
}

giveloadoutswap() {
  setclass(self.pers["class"]);
  self.weaponispreferreddrop = undefined;
  self.tag_stowed_hip = undefined;
  self.trait = undefined;
  scripts\mp\weapons::recordtogglescopestates();
  scripts\mp\weapons::func_DDF6();
  giveloadout(self.pers["team"], self.pers["class"]);
  if(!scripts\mp\utility::gameflag("prematch_done")) {
    scripts\mp\playerlogic::allowprematchlook(self);
  }
}

giveloadout(param_00, param_01, param_02) {
  self notify("giveLoadout_start");
  self.gettingloadout = 1;
  if(isDefined(self.perks)) {
    self.oldperks = self.perks;
  }

  loadout_clearweapons();
  var_03 = undefined;
  if(scripts\engine\utility::istrue(self.classset)) {
    var_03 = self.classstruct;
    self.classset = undefined;
  } else {
    var_03 = loadout_getclassstruct();
    var_03 = loadout_updateclass(var_03, param_01);
    self.classstruct = var_03;
  }

  loadout_giveextraweapons(var_03);
  loadout_updateplayer(var_03, param_01, param_02);
  func_AE38(var_03, param_01);
  self.gettingloadout = 0;
  self notify("changed_kit");
  self notify("giveLoadout");
}

loadout_giveextraweapons(param_00) {}

func_AE38(param_00, param_01) {
  if(!isplayer(self) && !isalive(self)) {
    return;
  }

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    thread setmlgspectatorclientloadoutdata(self, param_00);
  }

  var_02 = scripts\mp\utility::getclassindex(param_01);
  var_03 = var_02;
  var_04 = getsubstr(param_01, 0, 7) == "default";
  if(var_04) {
    var_03 = var_03 + 20;
  }

  var_05 = 10;
  var_06 = -1;
  for(var_07 = 0; var_07 < var_05; var_07++) {
    var_08 = getmatchdata("players", self.clientid, "loadouts", var_07, "slotUsed");
    if(var_08) {
      var_09 = getmatchdata("players", self.clientid, "loadouts", var_07, "classIndex");
      if(var_09 == var_03) {
        var_06 = var_07;
        break;
      }

      continue;
    }

    var_06 = var_07;
    setmatchdata("players", self.clientid, "loadouts", var_07, "slotUsed", 1);
    setmatchdata("players", self.clientid, "loadouts", var_07, "classIndex", var_03);
    setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "weapon", param_00.loadoutprimary);
    for(var_0A = 0; var_0A < 6; var_0A++) {
      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "attachment", var_0A, param_00.loadoutprimaryattachments[var_0A]);
    }

    setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "camo", param_00.loadoutprimarycamo);
    setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "reticle", param_00.loadoutprimaryreticle);
    setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "lootItemID", param_00.loadoutprimarylootitemid);
    setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "variantID", param_00.loadoutprimaryvariantid);
    setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "paintJobID", param_00.var_AE8B);
    setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "cosmeticAttachment", param_00.loadoutprimarycosmeticattachment);
    setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "weapon", param_00.loadoutsecondary);
    for(var_0A = 0; var_0A < 5; var_0A++) {
      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "attachment", var_0A, param_00.loadoutsecondaryattachments[var_0A]);
    }

    setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "camo", param_00.loadoutsecondarycamo);
    setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "reticle", param_00.loadoutsecondaryreticle);
    setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "lootItemID", param_00.var_AE9E);
    setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "variantID", param_00.var_AEA5);
    setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "paintJobID", param_00.var_AE9F);
    setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "cosmeticAttachment", param_00.loadoutsecondarycosmeticattachment);
    setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 0, "power", param_00.var_AE7B);
    setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 0, "extraCharge", cac_getextracharge(var_02));
    setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 1, "power", param_00.var_AE7D);
    setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 1, "extraCharge", cac_getextracharge2(var_02));
    var_0B = param_00.loadoutstandardperks.size;
    if(var_0B > 3) {
      var_0B = 3;
    }

    for(var_0C = 0; var_0C < var_0B; var_0C++) {
      setmatchdata("players", self.clientid, "loadouts", var_07, "loadoutPerks", var_0C, param_00.loadoutstandardperks[var_0C]);
    }

    var_0D = param_00.loadoutextraperks.size;
    if(var_0D > 3) {
      var_0D = 3;
    }

    for(var_0C = 0; var_0C < var_0D; var_0C++) {
      setmatchdata("players", self.clientid, "loadouts", var_07, "extraPerks", var_0C, param_00.loadoutextraperks[var_0C]);
    }

    setmatchdata("players", self.clientid, "killstreaks", 0, param_00.loadoutkillstreak1);
    setmatchdata("players", self.clientid, "killstreaks", 1, param_00.loadoutkillstreak2);
    setmatchdata("players", self.clientid, "killstreaks", 2, param_00.loadoutkillstreak3);
    if(var_06 == 0) {
      self _meth_859B(self.clientid, self.headmodel, self.model);
      if(isDefined(self.loadoutgesture)) {
        self _meth_85AB(self.clientid, self.loadoutgesture);
      }
    }

    break;
  }

  if(isDefined(self.matchdatalifeindex) && scripts\mp\matchdata::canloglife(self.matchdatalifeindex)) {
    if(isDefined(param_00.loadoutarchetype)) {
      setmatchdata("lives", self.matchdatalifeindex, "archetype", param_00.loadoutarchetype);
    }

    if(isDefined(param_00.loadoutrigtrait) && param_00.loadoutrigtrait != "specialty_null") {
      setmatchdata("lives", self.matchdatalifeindex, "trait", param_00.loadoutrigtrait);
      self.lastmatchdatarigtrait = param_00.loadoutrigtrait;
    } else if(isDefined(self.lastmatchdatarigtrait)) {
      setmatchdata("lives", self.matchdatalifeindex, "trait", self.lastmatchdatarigtrait);
    }

    if(isDefined(param_00.loadoutsuper)) {
      setmatchdata("lives", self.matchdatalifeindex, "super", param_00.loadoutsuper);
    }

    setmatchdata("lives", self.matchdatalifeindex, "loadoutIndex", var_06);
  }

  self.var_AE6D = var_06;
}

hasvalidationinfraction() {
  return isDefined(self.pers) && isDefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

recordvalidationinfraction() {
  if(isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
  }
}

_detachall() {
  self.headmodel = undefined;
  if(isDefined(self.riotshieldmodel)) {
    scripts\mp\utility::riotshield_detach(1);
  }

  if(isDefined(self.riotshieldmodelstowed)) {
    scripts\mp\utility::riotshield_detach(0);
  }

  self.hasriotshieldequipped = 0;
  self detachall();
}

func_9EE1(param_00) {
  var_01 = tablelookup("mp\perktable.csv", 1, param_00, 8);
  if(var_01 == "" || var_01 == "specialty_null") {
    return 0;
  }

  if(!self isitemunlocked(var_01, "perk")) {
    return 0;
  }

  return 1;
}

canplayerplacesentry(param_00) {
  var_01 = tablelookup("mp\perktable.csv", 1, param_00, 8);
  if(var_01 == "" || var_01 == "specialty_null") {
    return "specialty_null";
  }

  if(!self isitemunlocked(var_01, "perk")) {
    return "specialty_null";
  }

  return var_01;
}

trackriotshield_ontrophystow() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    self waittill("grenade_pullback", var_00);
    if(var_00 != "trophy_mp") {
      continue;
    }

    if(!isDefined(self.riotshieldmodel)) {
      continue;
    }

    scripts\mp\utility::riotshield_move(1);
    self waittill("offhand_end");
    if(scripts\mp\weapons::isriotshield(self getcurrentweapon()) && isDefined(self.riotshieldmodelstowed)) {
      scripts\mp\utility::riotshield_move(0);
    }
  }
}

func_11B04() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.hasriotshield = scripts\mp\utility::riotshield_hasweapon();
  self.hasriotshieldequipped = scripts\mp\weapons::isriotshield(self.currentweaponatspawn);
  if(self.hasriotshield) {
    if(self.hasriotshieldequipped) {
      scripts\mp\utility::riotshield_attach(1, scripts\mp\utility::riotshield_getmodel());
    } else {
      scripts\mp\utility::riotshield_attach(0, scripts\mp\utility::riotshield_getmodel());
    }
  }

  thread trackriotshield_ontrophystow();
  for(;;) {
    self waittill("weapon_change", var_00);
    if(var_00 == "none") {
      continue;
    }

    var_01 = scripts\mp\weapons::isriotshield(var_00);
    var_02 = !var_01 && scripts\mp\utility::riotshield_hasweapon();
    if(var_01) {
      if(!isDefined(self.riotshieldmodel)) {
        if(isDefined(self.riotshieldmodelstowed)) {
          scripts\mp\utility::riotshield_move(0);
        } else {
          scripts\mp\utility::riotshield_attach(1, scripts\mp\utility::riotshield_getmodel());
        }
      }
    } else if(var_02) {
      if(!isDefined(self.riotshieldmodelstowed)) {
        if(isDefined(self.riotshieldmodel)) {
          scripts\mp\utility::riotshield_move(1);
        } else {
          scripts\mp\utility::riotshield_attach(0, scripts\mp\utility::riotshield_getmodel());
        }
      }
    } else {
      if(isDefined(self.riotshieldmodel)) {
        scripts\mp\utility::riotshield_detach(1);
      }

      if(isDefined(self.riotshieldmodelstowed)) {
        scripts\mp\utility::riotshield_detach(0);
      }
    }

    self.hasriotshield = var_01 || var_02;
    self.hasriotshieldequipped = var_01;
  }
}

updateattachmentsformlg(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = param_00[var_02];
    if(var_03 == "ripperrscope_camo") {
      var_03 = "ripperrscope_na_camo";
    } else if(var_03 == "m8scope_camo") {
      var_03 = "m8scope_na_camo";
    } else if(var_03 == "arripper" || var_03 == "arm8" || var_03 == "akimbofmg" || var_03 == "glarclassic" || var_03 == "glmp28" || var_03 == "shotgunlongshot" || var_03 == "glsmoke" || var_03 == "glsmoke_slow" || var_03 == "gltacburst" || var_03 == "gltacburst_big" || var_03 == "gltacburst_regen" || var_03 == "glmp28_smoke") {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

ismark2weapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  return param_00 >= 32;
}

isholidayweapon(param_00, param_01) {
  if(!isDefined(param_01) || param_01 < 0) {
    return 0;
  }

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility::getweaponrootname(param_00), param_01);
  return var_02 == "weapon_iw7_ripper_common_3" || var_02 == "weapon_iw7_lmg03_rare_3" || var_02 == "weapon_iw7_ar57_legendary_3";
}

isholidayweaponusingdefaultscope(param_00, param_01) {
  var_02 = scripts\mp\utility::attachmentmap_tounique("scope", getweaponbasename(param_00));
  return isDefined(var_02) && scripts\engine\utility::array_contains(param_01, var_02);
}

issummerholidayweapon(param_00, param_01) {
  if(!isDefined(param_01) || param_01 < 0) {
    return 0;
  }

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility::getweaponrootname(param_00), param_01);
  return var_02 == "weapon_iw7_erad_legendary_4" || var_02 == "weapon_iw7_ake_epic_4" || var_02 == "weapon_iw7_sdflmg_legendary_4" || var_02 == "weapon_iw7_mod2187_legendary_3" || var_02 == "weapon_iw7_longshot_legendary_3";
}

ishalloweenholidayweapon(param_00, param_01) {
  if(!isDefined(param_01) || param_01 < 0) {
    return 0;
  }

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility::getweaponrootname(param_00), param_01);
  return var_02 == "weapon_iw7_kbs_rare_3" || var_02 == "weapon_iw7_ripper_rare_3" || var_02 == "weapon_iw7_m4_rare_3" || var_02 == "weapon_iw7_mod2187_legendary_5" || var_02 == "weapon_iw7_mag_rare_3" || var_02 == "weapon_iw7_minilmg_epic_3";
}

hasscope(param_00) {
  foreach(var_02 in param_00) {
    if(scripts\mp\utility::getattachmenttype(var_02) == "rail") {
      return 1;
    }
  }

  return 0;
}

buildweaponname(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  param_01 = scripts\mp\utility::weaponattachremoveextraattachments(param_01);
  param_01 = scripts\engine\utility::array_remove(param_01, "none");
  var_09 = scripts\mp\utility::weaponattachdefaultmap(param_00);
  var_0A = buildweaponassetname(param_00, param_04);
  if(isDefined(self.gettingloadout) && self.gettingloadout) {
    var_0B = getrandomweaponattachments(var_0A, param_04, param_01);
    if(var_0B.size > 0) {
      param_01 = scripts\engine\utility::array_combine_unique(param_01, var_0B);
      foreach(var_0D in var_0B) {
        scripts\mp\perks\_weaponpassives::checkpassivemessage("passive_random_attachments", "_" + scripts\mp\utility::attachmentmap_tounique(var_0D, var_0A));
      }
    }
  }

  for(var_0F = 0; var_0F < param_01.size; var_0F++) {
    param_01[var_0F] = scripts\mp\utility::attachmentmap_tounique(param_01[var_0F], var_0A);
  }

  if(isDefined(var_09)) {
    for(var_0F = 0; var_0F < var_09.size; var_0F++) {
      var_09[var_0F] = scripts\mp\utility::attachmentmap_tounique(var_09[var_0F], var_0A);
    }
  }

  if(isDefined(var_09)) {
    param_01 = scripts\engine\utility::array_combine_unique(param_01, var_09);
  }

  if(isDefined(param_04)) {
    var_10 = getweaponvariantattachments(var_0A, param_04);
    if(var_10.size > 0) {
      param_01 = scripts\engine\utility::array_combine_unique(param_01, var_10);
    }
  }

  if(isDefined(param_08) && param_08 != "none") {
    param_01[param_01.size] = param_08;
  }

  if(param_01.size > 0) {
    param_01 = filterattachments(param_01);
  }

  var_11 = [];
  foreach(var_13 in param_01) {
    var_14 = scripts\mp\utility::attachmentmap_toextra(var_13);
    if(isDefined(var_14)) {
      var_11[var_11.size] = scripts\mp\utility::attachmentmap_tounique(var_14, var_0A);
    }
  }

  if(var_11.size > 0) {
    param_01 = scripts\engine\utility::array_combine_unique(param_01, var_11);
  }

  if(scripts\mp\utility::isanymlgmatch()) {
    param_01 = updateattachmentsformlg(param_01);
  }

  if(param_01.size > 0) {
    param_01 = scripts\engine\utility::alphabetize(param_01);
  }

  foreach(var_17 in param_01) {
    var_0A = var_0A + "+" + var_17;
  }

  if(issubstr(var_0A, "iw7")) {
    var_0A = buildweaponnamecamo(var_0A, param_02, param_04);
    var_19 = 0;
    if(isholidayweapon(var_0A, param_04) || issummerholidayweapon(var_0A, param_04) || ishalloweenholidayweapon(var_0A, param_04)) {
      var_19 = isholidayweaponusingdefaultscope(var_0A, param_01);
    }

    if(hasscope(param_01)) {
      if(var_19 && !issubstr(var_0A, "iw7_longshot") && !issubstr(var_0A, "iw7_kbs")) {
        if(ishalloweenholidayweapon(var_0A, param_04)) {
          var_0A = var_0A + "+scope" + gethalloweenscopenumber(var_0A, param_04);
        } else {
          var_0A = var_0A + "+scope1";
        }
      } else {
        var_0A = buildweaponnamereticle(var_0A, param_03);
      }
    }

    var_0A = buildweaponnamevariantid(var_0A, param_04);
  }

  return var_0A;
}

gethalloweenscopenumber(param_00, param_01) {
  if(!isDefined(param_01) || param_01 < 0) {
    return 0;
  }

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility::getweaponrootname(param_00), param_01);
  var_03 = 0;
  switch (var_02) {
    case "weapon_iw7_minilmg_epic_3":
      var_03 = 1;
      break;

    case "weapon_iw7_mod2187_legendary_5":
    case "weapon_iw7_ripper_rare_3":
      var_03 = 2;
      break;
  }

  return var_03;
}

getrandomweaponattachments(param_00, param_01, param_02) {
  var_03 = [];
  if(weaponhaspassive(param_00, param_01, "passive_random_attachments")) {
    if(1) {
      var_04 = getavailableattachments(param_00, param_02, 0);
      var_03[var_03.size] = var_04[randomint(var_04.size)];
    } else {
      var_05 = randomintrange(1, 2);
      var_03 = buildrandomattachmentarray(param_00, var_05, param_02);
    }
  }

  return var_03;
}

func_11754(param_00, param_01) {
  var_02 = getavailableattachments(param_00, [], 0);
  foreach(var_04 in var_02) {
    scripts\mp\perks\_weaponpassives::testpassivemessage("passive_random_attachments", "_" + scripts\mp\utility::attachmentmap_tounique(var_04, param_00));
  }
}

buildrandomattachmentarray(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = getattachmenttypeslist(param_00, param_02);
  if(var_04.size > 0) {
    var_03 = [];
    var_05 = scripts\engine\utility::array_randomize_objects(var_04);
    foreach(var_0A, var_07 in var_05) {
      if(param_01 <= 0) {
        break;
      }

      var_08 = 1;
      switch (var_0A) {
        case "undermount":
        case "barrel":
          var_08 = 1;
          break;

        case "rail":
          var_08 = 0;
          break;

        default:
          var_08 = randomintrange(1, param_01 + 1);
          break;
      }

      if(var_08 > 0) {
        if(var_08 > var_07.size) {
          var_08 = var_07.size;
        }

        param_01 = param_01 - var_08;
        var_07 = scripts\engine\utility::array_randomize_objects(var_07);
        while(var_08 > 0) {
          var_09 = var_07[var_07.size - var_08];
          var_03[var_03.size] = var_09;
          var_08--;
        }
      }
    }
  }

  return var_03;
}

getattachmenttypeslist(param_00, param_01) {
  var_02 = scripts\mp\utility::getweaponattachmentarrayfromstats(param_00);
  var_03 = [];
  foreach(var_05 in var_02) {
    var_06 = scripts\mp\utility::getattachmenttype(var_05);
    if(listhasattachment(param_01, var_05)) {
      continue;
    }

    if(!isDefined(var_03[var_06])) {
      var_03[var_06] = [];
    }

    var_07 = var_03[var_06];
    var_07[var_07.size] = var_05;
    var_03[var_06] = var_07;
  }

  return var_03;
}

getavailableattachments(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = scripts\mp\utility::getweaponattachmentarrayfromstats(param_00);
  var_04 = [];
  foreach(var_06 in var_03) {
    var_07 = scripts\mp\utility::getattachmenttype(var_06);
    if(!param_02 && var_07 == "rail") {
      continue;
    }

    if(listhasattachment(param_01, var_06)) {
      continue;
    }

    var_04[var_04.size] = var_06;
  }

  return var_04;
}

listhasattachment(param_00, param_01) {
  foreach(var_03 in param_00) {
    if(var_03 == param_01) {
      return 1;
    }
  }

  return 0;
}

getrandomarmkillstreak(param_00, param_01) {
  var_02 = scripts\mp\utility::getweaponattachmentarrayfromstats(param_00);
  return dontcastdistantshadows(var_02, param_01);
}

dontcastshadows(param_00, param_01, param_02) {
  var_03 = scripts\mp\utility::getweaponbarsize(param_00, param_01);
  return dontcastdistantshadows(var_03, param_02);
}

dontcastdistantshadows(param_00, param_01) {
  if(param_00.size > 0) {
    param_00 = scripts\engine\utility::array_randomize(param_00);
    if(param_01 > param_00.size) {
      param_01 = param_00.size;
    }

    var_02 = [];
    while(param_01 > 0 && param_00.size > 0) {
      var_03 = param_00[param_00.size - param_01];
      var_02[var_02.size] = var_03;
      param_01--;
    }

    if(var_02.size > 0) {
      return var_02;
    }
  }

  return param_00;
}

filterattachments(param_00) {
  var_01 = [];
  if(isDefined(param_00)) {
    foreach(var_03 in param_00) {
      if(var_03 == "none") {
        continue;
      }

      var_04 = 1;
      foreach(var_06 in var_01) {
        if(var_03 == var_06) {
          var_04 = 0;
          break;
        }

        if(!scripts\mp\utility::attachmentscompatible(var_03, var_06)) {
          var_04 = 0;
          break;
        }
      }

      if(var_04) {
        var_01[var_01.size] = var_03;
      }
    }
  }

  return var_01;
}

buildweaponassetname(param_00, param_01) {
  if(!isDefined(param_01) || param_01 < 0) {
    return scripts\mp\utility::func_13C75(param_00);
  }

  var_02 = scripts\mp\loot::getweaponassetfromrootweapon(param_00, param_01);
  return var_02;
}

buildweaponnamecamo(param_00, param_01, param_02) {
  var_03 = -1;
  if(isholidayweapon(param_00, param_02)) {
    var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo89", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return param_00 + "+camo" + var_03;
  } else if(issummerholidayweapon(param_00, param_02)) {
    var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo230", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return param_00 + "+camo" + var_03;
  } else if(ishalloweenholidayweapon(param_00, param_02)) {
    var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo242", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return param_00 + "+camo" + var_03;
  } else if((!isDefined(param_01) || param_01 == "none") && ismark2weapon(param_02)) {
    var_04 = scripts\mp\loot::getweaponqualitybyid(param_00, param_02);
    var_05 = undefined;
    switch (var_04) {
      case 1:
        var_05 = "camo99";
        break;

      case 2:
        var_05 = "camo101";
        break;

      case 3:
        var_05 = "camo102";
        break;

      case 4:
        var_05 = "camo103";
        break;

      default:
        break;
    }

    var_03 = int(tablelookup("mp\camoTable.csv", 1, var_05, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return param_00 + "+camo" + var_03;
  }

  if(!isDefined(var_03)) {
    var_05 = 0;
  } else {
    var_05 = int(tablelookup("mp\camoTable.csv", 1, var_03, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
  }

  if(var_05 <= 0) {
    var_04 = scripts\mp\loot::getweaponqualitybyid(param_02, var_04);
    var_05 = undefined;
    switch (var_04) {
      case 1:
        var_05 = "camo24";
        break;

      case 2:
        var_05 = "camo19";
        break;

      case 3:
        var_05 = "camo18";
        break;

      default:
        break;
    }

    if(isDefined(var_05)) {
      var_03 = int(tablelookup("mp\camoTable.csv", 1, var_05, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    } else {
      return param_00;
    }
  }

  return param_00 + "+camo" + var_03;
}

buildweaponnamereticle(param_00, param_01) {
  if(!isDefined(param_01)) {
    return param_00;
  }

  var_02 = int(tablelookup("mp\reticleTable.csv", 1, param_01, 5));
  if(!isDefined(var_02) || var_02 == 0) {
    return param_00;
  }

  param_00 = param_00 + "+scope" + var_02;
  return param_00;
}

buildweaponnamevariantid(param_00, param_01) {
  if(!isDefined(param_01) || param_01 < 0) {
    return param_00;
  }

  param_00 = param_00 + "+loot" + param_01;
  return param_00;
}

getweaponpassives(param_00, param_01) {
  return scripts\mp\loot::getpassivesforweapon(buildweaponnamevariantid(param_00, param_01));
}

weaponhaspassive(param_00, param_01, param_02) {
  var_03 = getweaponpassives(param_00, param_01);
  if(!isDefined(var_03) || var_03.size <= 0) {
    return 0;
  }

  foreach(var_05 in var_03) {
    if(param_02 == var_05) {
      return 1;
    }
  }

  return 0;
}

getweaponvariantattachments(param_00, param_01) {
  var_02 = [];
  var_03 = getweaponpassives(param_00, param_01);
  if(isDefined(var_03)) {
    foreach(var_05 in var_03) {
      var_06 = scripts\mp\passives::getpassiveattachment(var_05);
      if(!isDefined(var_06)) {
        continue;
      }

      var_02[var_02.size] = var_06;
    }
  }

  return var_02;
}

func_F775(param_00, param_01, param_02) {
  self.var_A6AB = [];
  var_03 = [];
  if(isDefined(param_00) && param_00 != "none") {
    var_04 = scripts\mp\killstreaks\_killstreaks::getstreakcost(param_00);
    var_03[var_04] = param_00;
  }

  if(isDefined(param_01) && param_01 != "none") {
    var_04 = scripts\mp\killstreaks\_killstreaks::getstreakcost(param_01);
    var_03[var_04] = param_01;
  }

  if(isDefined(param_02) && param_02 != "none") {
    var_04 = scripts\mp\killstreaks\_killstreaks::getstreakcost(param_02);
    var_03[var_04] = param_02;
  }

  var_05 = 0;
  foreach(var_04, var_07 in var_03) {
    if(var_04 > var_05) {
      var_05 = var_04;
    }
  }

  for(var_08 = 0; var_08 <= var_05; var_08++) {
    if(!isDefined(var_03[var_08])) {
      continue;
    }

    var_07 = var_03[var_08];
    self.var_A6AB[var_08] = var_03[var_08];
  }
}

func_E19F() {
  var_00 = self.pers["team"];
  var_01 = self.pers["class"];
  var_02 = self getweaponslistall();
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    self givemaxammo(var_04);
    self setweaponammoclip(var_04, 9999);
    if(var_04 == "claymore_mp" || var_04 == "claymore_detonator_mp") {
      self setweaponammostock(var_04, 2);
    }
  }

  if(self getrunningforwardpainanim(level.classgrenades[var_01]["primary"]["type"]) < level.classgrenades[var_01]["primary"]["count"]) {
    self setweaponammoclip(level.classgrenades[var_01]["primary"]["type"], level.classgrenades[var_01]["primary"]["count"]);
  }

  if(self getrunningforwardpainanim(level.classgrenades[var_01]["secondary"]["type"]) < level.classgrenades[var_01]["secondary"]["count"]) {
    self setweaponammoclip(level.classgrenades[var_01]["secondary"]["type"], level.classgrenades[var_01]["secondary"]["count"]);
  }
}

onplayerconnecting() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isDefined(var_00.pers["class"])) {
      var_00.pers["class"] = "";
    }

    if(!isDefined(var_00.pers["lastClass"])) {
      var_00.pers["lastClass"] = "";
    }

    var_00.class = var_00.pers["class"];
    var_00.lastclass = var_00.pers["lastClass"];
    var_00.var_53AD = 0;
    var_00.var_2C66 = [];
    var_00.var_2C67 = [];
    var_00.changedarchetypeinfo = var_00.pers["changedArchetypeInfo"];
    var_00.lastarchetypeinfo = undefined;
    if(!isai(var_00) && !scripts\engine\utility::istrue(var_00.btestclient)) {
      var_00 setclientomnvar("ui_selected_archetype", level.archetypeids[var_00 cac_getcharacterarchetype()]);
      var_00 setclientomnvar("ui_selected_super", scripts\mp\supers::_meth_8186(var_00 cac_getsuper()));
      var_00 setclientomnvar("ui_selected_trait", scripts\mp\perks\_perks::getequipmenttableinfo(var_00 cac_getloadoutarchetypeperk()));
    }

    if(!isDefined(var_00.pers["validationInfractions"])) {
      var_00.pers["validationInfractions"] = 0;
    }
  }
}

fadeaway(param_00, param_01) {
  wait(param_00);
  self fadeovertime(param_01);
  self.alpha = 0;
}

setclass(param_00) {
  self.curclass = param_00;
}

iskillstreak(param_00) {
  return scripts\mp\utility::getkillstreakindex(param_00) != -1;
}

haschangedclass() {
  if((isDefined(self.lastclass) && self.lastclass != self.class) || !isDefined(self.lastclass)) {
    return 1;
  }

  if(level.gametype == "infect" && !isDefined(self.last_infected_class) || self.last_infected_class != self.infected_class) {
    return 1;
  }

  return 0;
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo)) {
      return 1;
    }

    if(self.changedarchetypeinfo != self.lastarchetypeinfo) {
      return 1;
    }
  }

  return 0;
}

resetactionslots() {
  scripts\mp\utility::_setactionslot(1, "");
  scripts\mp\utility::_setactionslot(2, "");
  scripts\mp\utility::_setactionslot(3, "");
  scripts\mp\utility::_setactionslot(4, "");
  if(!level.console) {
    scripts\mp\utility::_setactionslot(5, "");
    scripts\mp\utility::_setactionslot(6, "");
    scripts\mp\utility::_setactionslot(7, "");
  }
}

resetfunctionality() {
  self getrankinfolevel(0);
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_hide_minimap", 0);
  self.disabledusability = undefined;
  self.disabledmelee = undefined;
  self.disabledfire = undefined;
  self.disabledads = undefined;
  self.disabledweapon = undefined;
  self.disabledweaponswitch = undefined;
  self.disabledoffhandweapons = undefined;
  self.disabledprone = undefined;
  self.disabledcrouch = undefined;
  self.disabledstances = undefined;
  self.disabledjump = undefined;
  self.disableddoublejump = undefined;
  self.doublejumpenergy = undefined;
  self.doublejumpenergyrestorerate = undefined;
  self.disabledmantle = undefined;
  self.disabledsprint = undefined;
  self.disabledslide = undefined;
  self.disabledwallrun = undefined;
  self.enabledcollisionnotifies = undefined;
  self.enabledequipdeployvfx = undefined;
  self.var_8EC7 = undefined;
  self.var_8ECE = undefined;
  self.isstunned = undefined;
  self.isblinded = undefined;
  self.nocorpse = undefined;
  self.prematchlook = undefined;
  scripts\mp\damage::resetattackerlist();
  scripts\mp\damage::clearcorpsetablefuncs();
  scripts\mp\killstreaks\_chill_common::chill_resetdata();
  scripts\mp\perks\_weaponpassives::passivecolddamageresetdata(self);
  scripts\mp\utility::_resetenableignoreme();
}

clearscriptable() {
  self setscriptablepartstate("CompassIcon", "defaultIcon");
  scripts\mp\killstreaks\_chill_common::chill_resetscriptable();
  scripts\mp\perks\_weaponpassives::passivecolddamageresetscriptable(self);
  scripts\mp\archetypes\archscout::func_B946();
  scripts\mp\equipment\cloak::func_E26A();
}

changearchetype(param_00, param_01, param_02) {
  if(isDefined(self.changedarchetypeinfo)) {
    var_03 = self.changedarchetypeinfo;
    if(var_03.archetype == param_00 && var_03.super == param_01 && var_03.trait == param_02) {
      return;
    }
  }

  var_04 = spawnStruct();
  var_04.archetype = param_00;
  var_04.super = param_01;
  var_04.trait = param_02;
  self.changedarchetypeinfo = var_04;
  self.pers["changedArchetypeInfo"] = var_04;
  if(!isai(self)) {
    self setclientomnvar("ui_selected_archetype", level.archetypeids[param_00]);
    self setclientomnvar("ui_selected_super", scripts\mp\supers::_meth_8186(param_01));
    self setclientomnvar("ui_selected_trait", scripts\mp\perks\_perks::getequipmenttableinfo(param_02));
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] != "") {
    scripts\mp\menus::preloadandqueueclass(self.pers["class"]);
    if(shouldallowinstantclassswap()) {
      giveloadoutswap();
      return;
    }

    if(isalive(self)) {
      self iprintlnbold(game["strings"]["change_rig"]);
      return;
    }
  }
}

getattachmentloadoutstring(param_00, param_01) {
  var_02 = scripts\engine\utility::ter_op(param_01 == "primary", "loadoutPrimaryAttachment", "loadoutSecondaryAttachment");
  if(param_00 == 0) {
    return var_02;
  }

  return var_02 + param_00 + 1;
}

getmaxprimaryattachments() {
  return 6;
}

getmaxsecondaryattachments() {
  return 5;
}

getmaxattachments(param_00) {
  return scripts\engine\utility::ter_op(param_00 == "primary", getmaxprimaryattachments(), getmaxsecondaryattachments());
}