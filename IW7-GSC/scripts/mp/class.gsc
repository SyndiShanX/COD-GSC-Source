/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\class.gsc
**************************************/

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

getclasschoice(var_0) {
  return var_0;
}

getweaponchoice(var_0) {
  var_1 = strtok(var_0, ",");

  if(var_1.size > 1) {
    return int(var_1[1]);
  } else {
    return 0;
  }
}

cac_getweapon(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "weapon");
}

cac_getweaponattachment(var_0, var_1, var_2) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachment", var_2);
}

cac_getweaponlootitemid(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "lootItemID");
}

cac_getweaponvariantid(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "variantID");
}

cac_getweaponcamo(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "camo");
}

cac_getweaponreticle(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "reticle");
}

cac_getkillstreak(var_0) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_0, "killstreak");
}

cac_getcharacterarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.archetype;
  }

  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "archetype");
}

cac_getpower(var_0) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "powerSetups", 0, "power");
}

cac_getextracharge(var_0) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "powerSetups", 0, "extraCharge");
}

cac_getpower2(var_0) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "powerSetups", 1, "power");
}

cac_getextracharge2(var_0) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "powerSetups", 1, "extraCharge");
}

cac_getpowerid(var_0) {
  var_1 = self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "powerSetups", 0, "lootItemID");
  return scripts\mp\powerloot::getpassiveperk(var_1);
}

cac_getpower2id(var_0) {
  var_1 = self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "powerSetups", 1, "lootItemID");
  return scripts\mp\powerloot::getpassiveperk(var_1);
}

cac_getsuper() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.super;
  }

  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
}

cac_getgesture() {
  var_0 = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    var_1 = level.archetypeids[self.changedarchetypeinfo.archetype];

    if(level.rankedmatch) {
      var_0 = self getrankedplayerdata("rankedloadouts", "squadMembers", "archetypePreferences", var_1, "gesture");
    } else {
      var_0 = self getrankedplayerdata("privateloadouts", "squadMembers", "archetypePreferences", var_1, "gesture");
    }
  } else if(level.rankedmatch) {
    var_0 = self getrankedplayerdata("rankedloadouts", "squadMembers", "gesture");
  } else {
    var_0 = self getrankedplayerdata("privateloadouts", "squadMembers", "gesture");
  }

  return scripts\mp\gestures::getgesturedata(var_0);
}

cac_getloadoutperk(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "loadoutPerks", var_1);
}

cac_getloadoutextraperk(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "extraPerks", var_1);
}

cac_getloadoutarchetypeperk() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.trait;
  }

  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "archetypePerk");
}

cac_getkillstreaklootid(var_0, var_1) {
  var_2 = self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_1, "lootItemID");
  return scripts\mp\killstreak_loot::getpassiveperk(var_2);
}

cac_getkillstreakvariantid(var_0) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_0, "lootItemID");
}

cac_getweaponcosmeticattachment(var_0, var_1) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "cosmeticAttachment");
}

recipe_getkillstreak(var_0, var_1, var_2) {
  return scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "kilstreakSetups", var_2, "killstreak");
}

table_getarchetype(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutArchetype", var_1 + 1);
}

table_getweapon(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimary", var_1 + 1);
  } else {
    return tablelookup(var_0, 0, "loadoutSecondary", var_1 + 1);
  }
}

table_getweaponattachment(var_0, var_1, var_2, var_3) {
  var_4 = "none";

  if(var_2 == 0) {
    var_4 = tablelookup(var_0, 0, "loadoutPrimaryAttachment" + (var_3 + 1), var_1 + 1);
  } else {
    var_4 = tablelookup(var_0, 0, "loadoutSecondaryAttachment" + (var_3 + 1), var_1 + 1);
  }

  if(var_4 == "" || var_4 == "none") {
    return "none";
  } else {
    return var_4;
  }
}

table_getweaponcamo(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimaryCamo", var_1 + 1);
  } else {
    return tablelookup(var_0, 0, "loadoutSecondaryCamo", var_1 + 1);
  }
}

table_getweaponreticle(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimaryReticle", var_1 + 1);
  } else {
    return tablelookup(var_0, 0, "loadoutSecondaryReticle", var_1 + 1);
  }
}

table_getperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutPerk" + (var_2 + 1), var_1 + 1);
}

table_getextraperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutExtraPerk" + (var_2 + 1), var_1 + 1);
}

table_getpowerprimary_MAYBE(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutPowerPrimary", var_1 + 1);
}

table_getextrapowerprimary_MAYBE(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutExtraPowerPrimary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

table_getpowersecondary_MAYBE(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutPowerSecondary", var_1 + 1);
}

table_getextrapowersecondary_MAYBE(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutExtraPowerSecondary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

table_getsuper(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutSuper", var_1 + 1);
}

table_getgesture(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutGesture", var_1 + 1);
}

table_getkillstreak(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutStreak" + var_2, var_1 + 1);
}

loadout_getplayerstreaktype(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "streaktype_support":
      var_1 = "support";
      break;
    case "streaktype_specialist":
      var_1 = "specialist";
      break;
    case "streaktype_resource":
      var_1 = "resource";
      break;
    default:
      var_1 = "assault";
  }

  return var_1;
}

getloadoutstreaktypefromstreaktype(var_0) {
  if(!isDefined(var_0)) {
    return "streaktype_assault";
  }

  switch (var_0) {
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

loadout_getclassteam(var_0) {
  var_1 = undefined;

  if(issubstr(var_0, "axis")) {
    var_1 = "axis";
  } else if(issubstr(var_0, "allies")) {
    var_1 = "allies";
  } else {
    var_1 = "none";
  }

  return var_1;
}

func_AE23() {
  self.health = self.maxhealth;
  thread scripts\mp\utility\game::func_DDD9(scripts\mp\utility\game::isjuggernaut());
  self.isjuggernaut = 1;
}

loadout_removejugg_MAYBE() {
  self notify("lost_juggernaut");
  self.isjuggernaut = 0;
  self.movespeedscaler = 1;
}

loadout_clearweapons() {
  self takeallweapons();
  scripts\mp\perks\weaponpassives::resetmodeswitchkillweapons(self);
  _detachall();
  scripts\mp\powers::func_110C2();
  scripts\mp\powers::clearpowers();

  if(isDefined(self.loadoutarchetype)) {
    clearscriptable();
  }

  scripts\mp\archetypes\archcommon::removearchetype(self.loadoutarchetype);
  scripts\mp\perks::_clearperks();
  scripts\mp\perks\weaponpassives::forgetpassives();
  scripts\mp\gestures::func_41B2();
  resetactionslots();
  resetfunctionality();

  if(isplayer(self)) {
    scripts\mp\killstreaks\emp_common::func_E24E();
  }
}

loadout_getclassstruct() {
  var_0 = spawnStruct();
  var_0.loadoutarchetype = "none";
  var_0.loadoutprimary = "none";
  var_0.loadoutprimaryattachments = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0.loadoutprimaryattachments[var_1] = "none";
  }

  var_0.loadoutprimarycamo = "none";
  var_0.loadoutprimaryreticle = "none";
  var_0.loadoutprimarylootitemid = 0;
  var_0.loadoutprimaryvariantid = -1;
  var_0.loadoutprimarycosmeticattachment = "none";
  var_0.loadoutsecondary = "none";
  var_0.loadoutsecondaryattachments = [];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0.loadoutsecondaryattachments[var_1] = "none";
  }

  var_0.loadoutsecondarycamo = "none";
  var_0.loadoutsecondaryreticle = "none";
  var_0.var_AE9E = 0;
  var_0.var_AEA5 = -1;
  var_0.loadoutsecondarycosmeticattachment = "none";
  var_0.loadoutperksfromgamemode = 0;
  var_0.loadoutperks = [];
  var_0.loadoutstandardperks = [];
  var_0.loadoutextraperks = [];
  var_0.loadoutrigtrait = "specialty_null";
  var_0.var_AE7B = "none";
  var_0.var_AE7C = [];
  var_0.loadoutextrapowerprimary = 0;
  var_0.var_AE7D = "none";
  var_0.var_AE7E = [];
  var_0.loadoutextrapowersecondary = 0;
  var_0.loadoutsuper = "none";
  var_0.loadoutgesture = "none";
  var_0.loadoutstreaksfilled = 0;
  var_0.loadoutstreaktype = "streaktype_assault";
  var_0.loadoutkillstreak1 = "none";
  var_0.loadoutkillstreak1variantid = -1;
  var_0.var_AE6F = [];
  var_0.loadoutkillstreak2 = "none";
  var_0.loadoutkillstreak2variantid = -1;
  var_0.var_AE71 = [];
  var_0.loadoutkillstreak3 = "none";
  var_0.loadoutkillstreak3variantid = -1;
  var_0.var_AE73 = [];
  return var_0;
}

loadout_updateclassteam(var_0, var_1, var_2) {
  var_2 = loadout_getclassteam(var_1);
  var_3 = scripts\mp\utility\game::getclassindex(var_1);
  self.class_num = var_3;
  self.classteam = var_2;
  var_0.loadoutarchetype = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "archetype");
  var_0.loadoutprimary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "weapon");

  if(var_0.loadoutprimary == "none") {
    var_0.loadoutprimary = "iw7_fists";
  } else {
    for(var_4 = 0; var_4 < 6; var_4++) {
      var_0.loadoutprimaryattachments[var_4] = ::scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "attachment", var_4);
    }
  }

  var_0.loadoutprimarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "camo");
  var_0.loadoutprimaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "reticle");
  var_0.loadoutsecondary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "weapon");

  for(var_4 = 0; var_4 < 5; var_4++) {
    var_0.loadoutsecondaryattachments[var_4] = ::scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "attachment", var_4);
  }

  var_0.loadoutsecondarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "camo");
  var_0.loadoutsecondaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "reticle");
  var_0.var_AE7B = "none";
  var_0.loadoutextrapowerprimary = 0;
  var_0.var_AE7D = "none";
  var_0.loadoutextrapowersecondary = 0;
  var_0.loadoutsuper = "none";
  var_0.loadoutgesture = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "gesture");
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = recipe_getkillstreak(var_2, var_3, 0);
  var_0.loadoutkillstreak2 = recipe_getkillstreak(var_2, var_3, 1);
  var_0.loadoutkillstreak3 = recipe_getkillstreak(var_2, var_3, 2);
  var_0.var_AE6F = [];
  var_0.var_AE71 = [];
  var_0.var_AE73 = [];
  var_0.var_AE7C = [];
  var_0.var_AE7E = [];
  var_0.loadoutkillstreak1variantid = -1;
  var_0.loadoutkillstreak2variantid = -1;
  var_0.loadoutkillstreak3variantid = -1;

  if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "juggernaut")) {
    func_AE23();
  } else if(scripts\mp\utility\game::isjuggernaut()) {
    loadout_removejugg_MAYBE();
  }
}

loadout_updateclasscustom(var_0, var_1) {
  var_2 = scripts\mp\utility\game::getclassindex(var_1);
  self.class_num = var_2;
  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutprimary = cac_getweapon(var_2, 0);

  for(var_3 = 0; var_3 < 6; var_3++) {
    var_0.loadoutprimaryattachments[var_3] = cac_getweaponattachment(var_2, 0, var_3);
  }

  var_0.loadoutprimarycamo = cac_getweaponcamo(var_2, 0);
  var_0.loadoutprimaryreticle = cac_getweaponreticle(var_2, 0);
  var_0.loadoutprimarylootitemid = cac_getweaponlootitemid(var_2, 0);
  var_0.loadoutprimaryvariantid = cac_getweaponvariantid(var_2, 0);
  var_0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 0);
  var_0.loadoutsecondary = cac_getweapon(var_2, 1);

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0.loadoutsecondaryattachments[var_3] = cac_getweaponattachment(var_2, 1, var_3);
  }

  var_0.loadoutsecondarycamo = cac_getweaponcamo(var_2, 1);
  var_0.loadoutsecondaryreticle = cac_getweaponreticle(var_2, 1);
  var_0.var_AE9E = cac_getweaponlootitemid(var_2, 1);
  var_0.var_AEA5 = cac_getweaponvariantid(var_2, 1);
  var_0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 1);
  var_0.var_AE7B = cac_getpower(var_2);
  var_0.var_AE7C = cac_getpowerid(var_2);
  var_0.loadoutextrapowerprimary = cac_getextracharge(var_2);
  var_0.var_AE7D = cac_getpower2(var_2);
  var_0.var_AE7E = cac_getpower2id(var_2);
  var_0.loadoutextrapowersecondary = cac_getextracharge2(var_2);
  var_0.loadoutsuper = cac_getsuper();
  var_0.loadoutgesture = cac_getgesture();
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = cac_getkillstreak(0);
  var_0.var_AE6F = cac_getkillstreaklootid(var_2, 0);
  var_0.loadoutkillstreak1variantid = cac_getkillstreakvariantid(0);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1);
  var_0.var_AE71 = cac_getkillstreaklootid(var_2, 1);
  var_0.loadoutkillstreak2variantid = cac_getkillstreakvariantid(1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2);
  var_0.var_AE73 = cac_getkillstreaklootid(var_2, 2);
  var_0.loadoutkillstreak3variantid = cac_getkillstreakvariantid(2);
}

loadout_updateclassgamemode(var_0, var_1) {
  var_2 = scripts\mp\utility\game::getclassindex(var_1);
  self.class_num = var_2;
  var_3 = self.pers["gamemodeLoadout"];

  if(isDefined(var_3["loadoutArchetype"])) {
    var_0.loadoutarchetype = var_3["loadoutArchetype"];

    if(isbot(self)) {
      self.botarchetype = var_3["loadoutArchetype"];
    }
  } else if(isbot(self)) {
    var_4 = scripts\mp\bots\bots_loadout::bot_loadout_class_callback();
    var_0.loadoutarchetype = var_4["loadoutArchetype"];
  } else {
    var_0.loadoutarchetype = cac_getcharacterarchetype();
  }

  if(isDefined(var_3["loadoutRigTrait"])) {
    var_0.loadoutrigtrait = var_3["loadoutRigTrait"];
  }

  if(isDefined(var_3["loadoutPrimary"])) {
    var_0.loadoutprimary = var_3["loadoutPrimary"];
  }

  for(var_5 = 0; var_5 < 6; var_5++) {
    var_6 = getattachmentloadoutstring(var_5, "primary");

    if(isDefined(var_3[var_6])) {
      var_0.loadoutprimaryattachments[var_5] = var_3[var_6];
    }
  }

  if(isDefined(var_3["loadoutPrimaryCamo"])) {
    var_0.loadoutprimarycamo = var_3["loadoutPrimaryCamo"];
  }

  if(isDefined(var_3["loadoutPrimaryReticle"])) {
    var_0.loadoutprimaryreticle = var_3["loadoutPrimaryReticle"];
  }

  if(isDefined(var_3["loadoutSecondary"])) {
    var_0.loadoutsecondary = var_3["loadoutSecondary"];
  }

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_6 = getattachmentloadoutstring(var_5, "secondary");

    if(isDefined(var_3[var_6])) {
      var_0.loadoutsecondaryattachments[var_5] = var_3[var_6];
    }
  }

  if(isDefined(var_3["loadoutSecondaryCamo"])) {
    var_0.loadoutsecondarycamo = var_3["loadoutSecondaryCamo"];
  }

  if(isDefined(var_3["loadoutSecondaryReticle"])) {
    var_0.loadoutsecondaryreticle = var_3["loadoutSecondaryReticle"];
  }

  var_0.loadoutperksfromgamemode = isDefined(var_3["loadoutPerks"]);

  if(isDefined(var_3["loadoutPerks"])) {
    var_0.loadoutperks = var_3["loadoutPerks"];
  }

  if(isDefined(var_3["loadoutPowerPrimary"])) {
    var_0.var_AE7B = var_3["loadoutPowerPrimary"];
  }

  if(isDefined(var_3["loadoutExtraPowerPrimary"])) {
    var_0.loadoutextrapowerprimary = var_3["loadoutExtraPowerPrimary"];
  }

  if(isDefined(var_3["loadoutPowerPrimaryPassives"])) {
    var_0.var_AE7C = var_3["loadoutPowerPrimaryPassives"];
  }

  if(isDefined(var_3["loadoutPowerSecondary"])) {
    var_0.var_AE7D = var_3["loadoutPowerSecondary"];
  }

  if(isDefined(var_3["loadoutExtraPowerSecondary"])) {
    var_0.loadoutextrapowersecondary = var_3["loadoutExtraPowerSecondary"];
  }

  if(isDefined(var_3["loadoutPowerSecondaryPassives"])) {
    var_0.var_AE7E = var_3["loadoutPowerSecondaryPassives"];
  }

  if(isDefined(var_3["loadoutSuper"])) {
    var_0.loadoutsuper = var_3["loadoutSuper"];
  }

  if(isDefined(var_3["loadoutGesture"]) && var_3["loadoutGesture"] == "playerData") {
    if(isbot(self)) {
      var_0.loadoutgesture = "none";
    } else {
      var_0.loadoutgesture = cac_getgesture();
    }
  } else if(isDefined(var_3["loadoutGesture"])) {
    var_0.loadoutgesture = var_3["loadoutGesture"];
  }

  if(isDefined(var_3["loadoutKillstreak1"]) && var_3["loadoutKillstreak1"] != "specialty_null" || isDefined(var_3["loadoutKillstreak2"]) && var_3["loadoutKillstreak2"] != "specialty_null" || isDefined(var_3["loadoutKillstreak3"]) && var_3["loadoutKillstreak3"] != "specialty_null") {
    var_0.loadoutstreaksfilled = 1;
    var_0.loadoutkillstreak1 = var_3["loadoutKillstreak1"];
    var_0.loadoutkillstreak2 = var_3["loadoutKillstreak2"];
    var_0.loadoutkillstreak3 = var_3["loadoutKillstreak3"];

    if(isDefined(var_3["loadoutKillstreak1Passives"])) {
      var_0.var_AE6F = var_3["loadoutKillstreak1Passives"];
    }

    if(isDefined(var_3["loadoutKillstreak2Passives"])) {
      var_0.var_AE71 = var_3["loadoutKillstreak2Passives"];
    }

    if(isDefined(var_3["loadoutKillstreak3Passives"])) {
      var_0.var_AE73 = var_3["loadoutKillstreak3Passives"];
    }
  }

  if(var_3["loadoutJuggernaut"]) {
    func_AE23();
  } else if(scripts\mp\utility\game::isjuggernaut()) {
    loadout_removejugg_MAYBE();
  }
}

func_AE50(var_0) {
  var_0.loadoutprimary = "iw7_chargeshot_c8";
  var_0.loadoutsecondary = "iw7_c8landing";
}

loadout_updateclasscallback(var_0) {
  if(!isDefined(self.classcallback)) {
    scripts\engine\utility::error("self.classCallback function reference required for class 'callback'");
  }

  var_1 = self[[self.classcallback]]();

  if(!isDefined(var_1)) {
    scripts\engine\utility::error("array required from self.classCallback for class 'callback'");
  }

  if(isDefined(var_1["loadoutArchetype"])) {
    var_0.loadoutarchetype = var_1["loadoutArchetype"];
  }

  if(isDefined(var_1["loadoutPrimary"])) {
    var_0.loadoutprimary = var_1["loadoutPrimary"];
  }

  for(var_2 = 0; var_2 < 6; var_2++) {
    var_3 = getattachmentloadoutstring(var_2, "primary");

    if(isDefined(var_1[var_3])) {
      var_0.loadoutprimaryattachments[var_2] = var_1[var_3];
    }
  }

  if(isDefined(var_1["loadoutPrimaryCamo"])) {
    var_0.loadoutprimarycamo = var_1["loadoutPrimaryCamo"];
  }

  if(isDefined(var_1["loadoutPrimaryReticle"])) {
    var_0.loadoutprimaryreticle = var_1["loadoutPrimaryReticle"];
  }

  if(isDefined(var_1["loadoutSecondary"])) {
    var_0.loadoutsecondary = var_1["loadoutSecondary"];
  }

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_3 = getattachmentloadoutstring(var_2, "secondary");

    if(isDefined(var_1[var_3])) {
      var_0.loadoutsecondaryattachments[var_2] = var_1[var_3];
    }
  }

  if(isDefined(var_1["loadoutSecondaryCamo"])) {
    var_0.loadoutsecondarycamo = var_1["loadoutSecondaryCamo"];
  }

  if(isDefined(var_1["loadoutSecondaryReticle"])) {
    var_0.loadoutsecondaryreticle = var_1["loadoutSecondaryReticle"];
  }

  if(isDefined(var_1["loadoutPowerPrimary"])) {
    var_0.var_AE7B = var_1["loadoutPowerPrimary"];
  }

  if(isDefined(var_1["loadoutPowerPrimaryPassives"])) {
    var_0.var_AE7C = var_1["loadoutPowerPrimaryPassives"];
  }

  if(isDefined(var_1["loadoutExtraPowerPrimary"])) {
    var_0.loadoutextrapowerprimary = var_1["loadoutExtraPowerPrimary"];
  }

  if(isDefined(var_1["loadoutPowerSecondary"])) {
    var_0.var_AE7D = var_1["loadoutPowerSecondary"];
  }

  if(isDefined(var_1["loadoutPowerSecondaryPassives"])) {
    var_0.var_AE7E = var_1["loadoutPowerSecondaryPassives"];
  }

  if(isDefined(var_1["loadoutExtraPowerSecondary"])) {
    var_0.loadoutextrapowersecondary = var_1["loadoutPowerExtraSecondary"];
  }

  if(isDefined(var_1["loadoutSuper"])) {
    var_0.loadoutsuper = var_1["loadoutSuper"];
  }

  if(isDefined(var_1["loadoutGesture"])) {
    var_0.loadoutgesture = var_1["loadoutGesture"];
  }

  var_0.loadoutstreaksfilled = isDefined(var_1["loadoutStreak1"]) || isDefined(var_1["loadoutStreak2"]) || isDefined(var_1["loadoutStreak3"]);

  if(isDefined(var_1["loadoutStreakType"])) {
    var_0.loadoutstreaktype = var_1["loadoutStreakType"];
  }

  if(isDefined(var_1["loadoutStreak1"])) {
    var_0.loadoutkillstreak1 = var_1["loadoutStreak1"];
  }

  if(isDefined(var_1["loadoutStreak2"])) {
    var_0.loadoutkillstreak2 = var_1["loadoutStreak2"];
  }

  if(isDefined(var_1["loadoutStreak3"])) {
    var_0.loadoutkillstreak3 = var_1["loadoutStreak3"];
  }

  if(isDefined(var_1["loadoutKillstreak1Passives"])) {
    var_0.var_AE6F = var_1["loadoutKillstreak1Passives"];
  }

  if(isDefined(var_1["loadoutKillstreak2Passives"])) {
    var_0.var_AE71 = var_1["loadoutKillstreak2Passives"];
  }

  if(isDefined(var_1["loadoutKillstreak3Passives"])) {
    var_0.var_AE73 = var_1["loadoutKillstreak3Passives"];
  }
}

loadout_updateclassdefault(var_0, var_1) {
  var_2 = scripts\mp\utility\game::getclassindex(var_1);
  self.class_num = var_2;
  var_0.loadoutprimary = table_getweapon(level.classtablename, var_2, 0);

  for(var_3 = 0; var_3 < 6; var_3++) {
    var_0.loadoutprimaryattachments[var_3] = table_getweaponattachment(level.classtablename, var_2, 0, var_3);
  }

  var_0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_2, 0);
  var_0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_2, 0);
  var_0.loadoutsecondary = table_getweapon(level.classtablename, var_2, 1);

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0.loadoutsecondaryattachments[var_3] = table_getweaponattachment(level.classtablename, var_2, 1, var_3);
  }

  var_0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_2, 1);
  var_0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_2, 1);
  var_0.var_AE7B = table_getpowerprimary_MAYBE(level.classtablename, var_2);
  var_0.loadoutextrapowerprimary = table_getextrapowerprimary_MAYBE(level.classtablename, var_2);
  var_0.var_AE7D = table_getpowersecondary_MAYBE(level.classtablename, var_2);
  var_0.loadoutextrapowersecondary = table_getextrapowersecondary_MAYBE(level.classtablename, var_2);
  var_0.loadoutgesture = table_getgesture(level.classtablename, var_2);
  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutsuper = cac_getsuper();
  var_0.loadoutkillstreak1 = cac_getkillstreak(0);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2);
  var_0.loadoutrigtrait = cac_getloadoutarchetypeperk();
  var_0.loadoutgesture = cac_getgesture();
}

loadout_updatestreaktype(var_0) {
  self.streaktype = "streaktype_assault";
  var_0.loadoutstreaktype = self.streaktype;
}

loadout_updateabilities(var_0, var_1) {
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

  if(scripts\mp\utility\game::isjuggernaut()) {
    return;
  }
  var_2 = getsubstr(var_1, 0, 7) == "default";

  if(var_0.loadoutperksfromgamemode) {
    return;
  }
  if(!scripts\mp\utility\game::perksenabled()) {
    return;
  } else if(isai(self)) {
    if(isDefined(self.pers["loadoutPerks"])) {
      var_0.loadoutperks = self.pers["loadoutPerks"];
    }
  } else if(haschangedclass() || haschangedarchetype()) {
    var_3 = loadout_getclassteam(var_1);

    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = "specialty_null";

      if(var_3 != "none") {
        var_6 = scripts\mp\utility\game::getclassindex(var_1);
        var_5 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_3, var_6, "class", "loadoutPerks");
      } else if(var_2) {
        var_6 = scripts\mp\utility\game::getclassindex(var_1);
        var_5 = table_getperk(level.classtablename, var_6, var_4);
      } else {
        var_5 = cac_getloadoutperk(self.class_num, var_4);
      }

      if(var_5 != "specialty_null") {
        var_0.loadoutperks[var_0.loadoutperks.size] = var_5;
        var_0.loadoutstandardperks[var_0.loadoutstandardperks.size] = var_5;
      }
    }

    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = "specialty_null";

      if(var_3 != "none") {
        var_6 = scripts\mp\utility\game::getclassindex(var_1);
        var_5 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_3, var_6, "class", "extraPerks");
      } else if(var_2) {
        var_6 = scripts\mp\utility\game::getclassindex(var_1);
        var_5 = table_getextraperk(level.classtablename, var_6, var_4);
      } else {
        var_5 = cac_getloadoutextraperk(self.class_num, var_4);
      }

      if(var_5 != "specialty_null") {
        var_0.loadoutperks[var_0.loadoutperks.size] = var_5;
        var_0.loadoutextraperks[var_0.loadoutextraperks.size] = var_5;
      }
    }

    var_5 = "specialty_null";

    if(var_3 != "none") {
      var_6 = scripts\mp\utility\game::getclassindex(var_1);
      var_5 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_3, var_6, "class", "archetypePerk");
    } else {
      var_5 = cac_getloadoutarchetypeperk();
    }

    if(var_5 != "specialty_null") {
      var_0.loadoutperks[var_0.loadoutperks.size] = var_5;
      self.pers["loadoutRigTrait"] = var_5;
      var_0.loadoutrigtrait = var_5;
      return;
    }
  } else {
    var_0.loadoutperks = self.pers["loadoutPerks"];
    var_0.loadoutstandardperks = self.pers["loadoutStandardPerks"];
    var_0.loadoutextraperks = self.pers["loadoutExtraPerks"];
    var_0.loadoutrigtrait = self.pers["loadoutRigTrait"];
    return;
  }
}

loadout_updateclass(var_0, var_1) {
  var_2 = loadout_getclassteam(var_1);

  if(var_2 != "none") {
    loadout_updateclassteam(var_0, var_1);
  } else if(issubstr(var_1, "custom")) {
    loadout_updateclasscustom(var_0, var_1);
  } else if(var_1 == "gamemode") {
    loadout_updateclassgamemode(var_0, var_1);
  } else if(var_1 == "rc8Agent") {
    func_AE50(var_0);
  } else if(var_1 == "callback") {
    loadout_updateclasscallback(var_0);
  } else {
    loadout_updateclassdefault(var_0, var_1);
  }

  loadout_updateclassfistweapons(var_0);
  loadout_updatestreaktype(var_0);
  loadout_updateabilities(var_0, var_1);
  var_0 = loadout_validateclass(var_0, var_1);
  return var_0;
}

loadout_updateclassfistweapons(var_0) {
  if(var_0.loadoutprimary == "none") {
    var_0.loadoutprimary = "iw7_fists";
  }

  if(var_0.loadoutsecondary == "none" && var_0.loadoutprimary != "iw7_fists") {
    var_0.loadoutsecondary = "iw7_fists";
  } else if(var_0.loadoutprimary == "iw7_fists" && var_0.loadoutsecondary == "iw7_fists") {
    var_0.loadoutsecondary = "none";
  }
}

loadout_validateclass(var_0, var_1) {
  if(issubstr(var_1, "custom")) {
    return scripts\mp\validation::validateloadout(var_0);
  }

  return var_0;
}

loadout_forcearchetype(var_0) {
  var_1 = getdvarint("forceArchetype", 0);

  if(var_1 > 0) {
    var_2 = getdvarint("forceArchetype", 0);

    switch (var_2) {
      case 1:
        var_0.loadoutarchetype = "archetype_assault";
        break;
      case 2:
        var_0.loadoutarchetype = "archetype_heavy";
        break;
      case 3:
        var_0.loadoutarchetype = "archetype_scout";
        break;
      case 4:
        var_0.loadoutarchetype = "archetype_assassin";
        break;
      case 5:
        var_0.loadoutarchetype = "archetype_engineer";
        break;
      case 6:
        var_0.loadoutarchetype = "archetype_sniper";
        break;
      case 7:
        var_0.loadoutarchetype = "archetype_reaper";
        break;
      default:
        var_0.loadoutarchetype = "archetype_assault";
        break;
    }
  } else if(var_1 == -1) {
    var_3 = ["archetype_assault", "archetype_heavy", "archetype_scout", "archetype_assassin", "archetype_engineer", "archetype_sniper"];
    var_4 = randomint(var_3.size);
    var_0.loadoutarchetype = var_3[var_4];
    self iprintlnbold("Random Archetype: " + var_3[var_4]);
  }
}

loadout_updateplayerarchetype(var_0) {
  if(!scripts\engine\utility::is_true(self.btestclient)) {
    if(!isDefined(level.aonrules) || level.aonrules == 0) {}
  }

  self.loadoutarchetype = var_0.loadoutarchetype;
  scripts\mp\weapons::updatemovespeedscale();
  var_1 = 1;
  var_2 = 2;
  var_3 = 4;
  var_4 = 8;
  var_5 = "defaultsuit_mp";
  var_6 = 0;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = 400;
  var_10 = 400;
  var_11 = 900;

  if(level.tactical) {
    var_10 = 133.333;
    var_11 = 1800;
  }

  switch (self.loadoutarchetype) {
    case "archetype_assault":
      var_5 = "assault_mp";
      var_6 = var_1 | var_2 | var_3;
      var_7 = scripts\mp\archetypes\archassault::applyarchetype;
      var_8 = "vestlight";
      break;
    case "archetype_heavy":
      var_5 = "armor_mp";
      var_6 = var_1 | var_2 | var_3;
      var_7 = scripts\mp\archetypes\archheavy::applyarchetype;
      var_8 = "vestheavy";
      break;
    case "archetype_scout":
      var_5 = "scout_mp";
      var_6 = var_1 | var_2 | var_3;
      var_7 = scripts\mp\archetypes\archscout::applyarchetype;
      var_8 = "c6servo";
      break;
    case "archetype_assassin":
      var_5 = "assassin_mp";
      var_6 = var_1 | var_2 | var_3;
      var_7 = scripts\mp\archetypes\archassassin::applyarchetype;
      var_8 = "vestftl";
      break;
    case "archetype_engineer":
      var_5 = "engineer_mp";
      var_6 = var_1 | var_2 | var_3;
      var_7 = scripts\mp\archetypes\archengineer::applyarchetype;
      var_8 = "vestlight";
      break;
    case "archetype_sniper":
      var_5 = "sniper_mp";
      var_6 = var_1 | var_2 | var_3;
      var_7 = scripts\mp\archetypes\archsniper::applyarchetype;
      var_8 = "vestghost";
      break;
    default:
      if(!scripts\engine\utility::is_true(self.btestclient)) {
        if(!isDefined(level.aonrules) || level.aonrules == 0) {}
      }

      break;
  }

  if(level.tactical) {
    var_5 = var_5 + "_tactical";
    var_1 = 0;
  }

  self func_845E(0);
  self allowdoublejump(var_6 &var_1);
  self allowslide(var_6 &var_2);
  self allowwallrun(var_6 &var_3);
  self allowdodge(var_6 &var_4);
  self allowlean(0);
  self setsuit(var_5);
  self energy_setmax(0, var_9);
  self energy_setenergy(0, var_9);
  self energy_setrestorerate(0, var_10);
  self energy_setresttimems(0, var_11);
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
  self energy_setrestorerate(1, 10);
  self energy_setresttimems(1, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 2500, 0));

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

  if(isDefined(var_7)) {
    self[[var_7]]();
  }

  if(isDefined(var_8)) {
    self give_explosive_touch_on_revived(var_8);

    if(var_8 == "c6servo") {
      self func_8460("clothtype", "c6servo");
    } else {
      self func_8460("clothtype", "");
    }

    self.var_42B0 = var_8;
  }

  thread scripts\mp\archetypes\archcommon::func_EF38();
  thread scripts\mp\archetypes\archcommon::func_EF41();
}

loadout_updateclassfinalweapons(var_0) {
  if(isDefined(self.class_num)) {
    var_0.var_AE8B = self.class_num * 2 + 0;
    var_0.var_AE9F = self.class_num * 2 + 1;
  } else {
    var_0.var_AE8B = -1;
    var_0.var_AE9F = -1;
  }

  var_0.loadoutprimaryfullname = buildweaponname(var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimaryvariantid, self getentitynumber(), self.clientid, var_0.var_AE8B, var_0.loadoutprimarycosmeticattachment);

  if(var_0.loadoutsecondary == "none") {
    var_0.loadoutsecondaryfullname = "none";
  } else {
    var_0.loadoutsecondaryfullname = buildweaponname(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.var_AEA5, self getentitynumber(), self.clientid, var_0.var_AE9F, var_0.loadoutsecondarycosmeticattachment);
  }
}

loadout_updateplayerweapons(var_0, var_1, var_2) {
  if(getdvarint("scr_require_loot", 0) == 1 && !scripts\mp\utility\game::istrue(self.var_54BC)) {
    if(var_0.loadoutprimarylootitemid == 0 && var_0.var_AE9E == 0) {
      iprintlnbold(self.name + " is not using a loot weapon!");
      self.var_54BC = 1;
    }
  }

  if(var_1 == "rc8Agent") {
    return;
  }
  loadout_updateclassfinalweapons(var_0);
  self.loadoutprimary = var_0.loadoutprimary;
  self.loadoutprimarycamo = var_0.loadoutprimarycamo;
  self.loadoutsecondary = var_0.loadoutsecondary;
  self.loadoutsecondarycamo = var_0.loadoutsecondarycamo;
  self.loadoutprimaryattachments = var_0.loadoutprimaryattachments;
  self.loadoutsecondaryattachments = var_0.loadoutsecondaryattachments;
  self.loadoutprimaryreticle = var_0.loadoutprimaryreticle;
  self.loadoutsecondaryreticle = var_0.loadoutsecondaryreticle;
  self.loadoutprimarylootitemid = var_0.loadoutprimarylootitemid;
  self.loadoutprimaryvariantid = var_0.loadoutprimaryvariantid;
  self.var_AE9E = var_0.var_AE9E;
  self.var_AEA5 = var_0.var_AEA5;
  var_3 = scripts\mp\weapons::updatesavedaltstate(var_0.loadoutprimaryfullname);
  scripts\mp\utility\game::_giveweapon(var_3, undefined, undefined, getweaponbasename(var_3) == "iw7_fists_mp");
  scripts\mp\weapons::updatetogglescopestate(var_0.loadoutprimaryfullname);
  scripts\mp\perks\weaponpassives::loadoutweapongiven(var_0.loadoutprimaryfullname);
  var_4 = "none";

  if(var_0.loadoutsecondary != "none") {
    var_4 = scripts\mp\weapons::updatesavedaltstate(var_0.loadoutsecondaryfullname);
    scripts\mp\utility\game::_giveweapon(var_4, undefined, undefined, 1);
    scripts\mp\weapons::updatetogglescopestate(var_0.loadoutsecondaryfullname);

    if(scripts\mp\utility\game::getweaponrootname(var_4) == "iw7_axe") {
      self setweaponammoclip(var_4, 1);
    }

    scripts\mp\perks\weaponpassives::loadoutweapongiven(var_0.loadoutsecondaryfullname);
  }

  var_5 = var_3;

  if(var_4 != "none" && getweaponbasename(var_5) == "iw7_fists_mp") {
    var_5 = var_4;
  }

  if(!isai(self)) {
    self.saved_lastweaponhack = undefined;
    scripts\mp\utility\game::_switchtoweapon(var_5);
  }

  if(!isDefined(var_2) || var_2) {
    var_6 = !scripts\mp\utility\game::gameflag("prematch_done") && !scripts\mp\weapons::isaltmodeweapon(var_5);
    self setspawnweapon(var_5, var_6);
  }

  self.primaryweapon = var_0.loadoutprimaryfullname;
  self.secondaryweapon = var_0.loadoutsecondaryfullname;
  self.spawnweaponobj = var_5;
  self.pers["primaryWeapon"] = var_0.loadoutprimaryfullname;
  self.pers["secondaryWeapon"] = var_0.loadoutsecondaryfullname;
  scripts\mp\teams::func_FADC();
  scripts\mp\weapons::updatemovespeedscale();
  thread scripts\mp\weapons::func_13BA9();
}

loadout_updateplayerperks(var_0) {
  scripts\mp\utility\game::giveperk("specialty_marathon");
  scripts\mp\utility\game::giveperk("specialty_sharp_focus");
  scripts\mp\utility\game::giveperk("specialty_silentdoublejump");

  if(var_0.loadoutperks.size > 0) {
    scripts\mp\perks::giveperks(var_0.loadoutperks, 0);
  }

  self.pers["loadoutPerks"] = var_0.loadoutperks;
  self.pers["loadoutStandardPerks"] = var_0.loadoutstandardperks;
  self.pers["loadoutExtraPerks"] = var_0.loadoutextraperks;
  self.pers["loadoutRigTrait"] = var_0.loadoutrigtrait;
  self setclientomnvar("ui_trait_ref", scripts\mp\perks::getequipmenttableinfo(self.pers["loadoutRigTrait"]));

  if(!scripts\mp\utility\game::isjuggernaut() && isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0) {
    thread scripts\mp\perks::giveperksafterspawn();
  }
}

loadout_updateplayerpowers_MAYBE(var_0) {
  self.powers = [];
  self.var_AE7B = var_0.var_AE7B;
  self.var_AE7D = var_0.var_AE7D;
  scripts\mp\powers::givepower(var_0.var_AE7B, "primary", 0, var_0.var_AE7C, var_0.loadoutextrapowerprimary);
  scripts\mp\powers::givepower(var_0.var_AE7D, "secondary", 0, var_0.var_AE7E, var_0.loadoutextrapowersecondary);
}

loadout_updateplayersuper(var_0) {
  var_1 = var_0.loadoutsuper;

  if(isbot(self) && level.allowsupers) {
    if(isDefined(self.loadoutsuper)) {
      var_1 = self.loadoutsuper;
    } else {
      var_1 = scripts\mp\bots\bots_supers::func_2EE9();
    }

    var_0.loadoutsuper = var_1;

    if(isDefined(self.loadoutrigtrait)) {
      var_2 = self.loadoutrigtrait;
    } else if(isDefined(var_0.loadoutrigtrait) && self.class == "gamemode") {
      var_2 = var_0.loadoutrigtrait;
    } else {
      var_2 = scripts\mp\bots\bots_supers::botpicktrait();
    }

    var_0.loadoutrigtrait = var_2;
    self.pers["loadoutRigTrait"] = var_2;

    if(var_2 != "specialty_null") {
      scripts\mp\utility\game::giveperk(var_2);
      self setclientomnvar("ui_trait_ref", scripts\mp\perks::getequipmenttableinfo(self.pers["loadoutRigTrait"]));
    }
  }

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    var_3 = scripts\mp\supers::getcurrentsuperref();

    if(var_3 == var_1 && !haschangedarchetype()) {
      scripts\mp\supers::givesuperweapon(self.super);
      return;
    }
  }

  if(var_1 == "none" || !level.allowsupers) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
  } else if(level.allowsupers && isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["loadoutSuper"])) {
    self.loadoutsuper = self.pers["gamemodeLoadout"]["loadoutSuper"];
    scripts\mp\supers::stopridingvehicle(self.loadoutsuper, 1);
  } else {
    self.loadoutsuper = var_1;
    scripts\mp\supers::stopridingvehicle(var_1, 1);
  }
}

loadout_updateplayergesture(var_0) {
  if(!scripts\engine\utility::is_true(self.btestclient)) {
    if(var_0.loadoutgesture != "none") {
      self.loadoutgesture = var_0.loadoutgesture;
      scripts\mp\gestures::givegesture(var_0.loadoutgesture);
    }
  }
}

loadout_updateplayerstreaktype(var_0) {
  self.streaktype = loadout_getplayerstreaktype(var_0.loadoutstreaktype);
}

loadout_updateplayerkillstreaks(var_0, var_1) {
  if(!level.allowkillstreaks) {
    var_0.loadoutkillstreak1 = "none";
    var_0.loadoutkillstreak2 = "none";
    var_0.loadoutkillstreak3 = "none";
  }

  self.streakvariantids = [];
  self.streakvariantids[var_0.loadoutkillstreak1] = var_0.loadoutkillstreak1variantid;
  self.streakvariantids[var_0.loadoutkillstreak2] = var_0.loadoutkillstreak2variantid;
  self.streakvariantids[var_0.loadoutkillstreak3] = var_0.loadoutkillstreak3variantid;

  if(var_0.loadoutstreaksfilled == 0 && isDefined(self.var_A6AB) && self.var_A6AB.size > 0 && (var_1 == "gamemode" || issubstr(var_1, "juggernaut"))) {
    var_2 = 0;

    foreach(var_4 in self.var_A6AB) {
      if(var_2 == 0) {
        var_0.loadoutkillstreak1 = var_4;
        var_2++;
        continue;
      }

      if(var_2 == 1) {
        var_0.loadoutkillstreak2 = var_4;
        var_2++;
        continue;
      }

      if(var_2 == 2) {
        var_0.loadoutkillstreak3 = var_4;
        break;
      }
    }
  }

  level.sortedkillstreaksbycost = getsortedkillstreaksbycost(var_0);
  var_0.loadoutkillstreak1 = level.sortedkillstreaksbycost[0];
  var_0.loadoutkillstreak2 = level.sortedkillstreaksbycost[1];
  var_0.loadoutkillstreak3 = level.sortedkillstreaksbycost[2];

  if(var_1 == "gamemode" && self.streaktype == "specialist") {
    self.pers["gamemodeLoadout"]["loadoutKillstreak1"] = var_0.loadoutkillstreak1;
    self.pers["gamemodeLoadout"]["loadoutKillstreak2"] = var_0.loadoutkillstreak2;
    self.pers["gamemodeLoadout"]["loadoutKillstreak3"] = var_0.loadoutkillstreak3;
  }

  func_F775(var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3);
  var_6 = 0;

  if(!isagent(self)) {
    var_6 = scripts\mp\killstreaks\killstreaks::func_213F([var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3]);
  }

  if(!isagent(self) && !var_6) {
    self notify("givingLoadout");
    var_7 = scripts\mp\killstreaks\killstreaks::func_7ED6();
    var_8 = scripts\mp\killstreaks\killstreaks::func_7DE7();

    if(!scripts\mp\utility\game::_hasperk("specialty_support_killstreaks") && !isDefined(self.var_5FBD)) {
      scripts\mp\killstreaks\killstreaks::func_41C0();
    }

    if(isDefined(var_0.loadoutkillstreak1) && var_0.loadoutkillstreak1 != "none" && var_0.loadoutkillstreak1 != "") {
      scripts\mp\killstreaks\killstreaks::func_66B9(var_0.loadoutkillstreak1, var_0.var_AE6F, var_0.loadoutkillstreak1variantid);
    }

    if(isDefined(var_0.loadoutkillstreak2) && var_0.loadoutkillstreak2 != "none" && var_0.loadoutkillstreak2 != "") {
      scripts\mp\killstreaks\killstreaks::func_66BB(var_0.loadoutkillstreak2, var_0.var_AE71, var_0.loadoutkillstreak2variantid);
    }

    if(isDefined(var_0.loadoutkillstreak3) && var_0.loadoutkillstreak3 != "none" && var_0.loadoutkillstreak3 != "") {
      scripts\mp\killstreaks\killstreaks::func_66BA(var_0.loadoutkillstreak3, var_0.var_AE73, var_0.loadoutkillstreak3variantid);
    }

    for(var_9 = var_7.size - 1; var_9 >= 0; var_9--) {
      scripts\mp\killstreaks\killstreaks::func_26D5(var_7[var_9]);
    }

    for(var_9 = 0; var_9 < var_8.size; var_9++) {
      scripts\mp\killstreaks\killstreaks::func_26D5(var_8[var_9]);
    }
  }

  self notify("equipKillstreaksFinished");
}

getsortedkillstreaksbycost(var_0) {
  var_1 = [var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3];

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    if(isDefined(var_1[var_2]) && var_1[var_2] != "none" && var_1[var_2] != "") {
      for(var_3 = var_2 + 1; var_3 < var_1.size; var_3++) {
        if(isDefined(var_1[var_3]) && var_1[var_3] != "none" && var_1[var_3] != "") {
          var_4 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_1[var_2]);
          var_5 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_1[var_3]);

          if(var_5 < var_4) {
            var_6 = var_1[var_3];
            var_1[var_3] = var_1[var_2];
            var_1[var_2] = var_6;
          }
        }
      }
    }
  }

  return var_1;
}

loadout_updateplayer(var_0, var_1, var_2) {
  loadout_updateplayerstreaktype(var_0);
  loadout_updateplayerarchetype(var_0);
  loadout_updateplayerweapons(var_0, var_1, var_2);
  loadout_updateplayerperks(var_0);
  loadout_updateplayerpowers_MAYBE(var_0);
  loadout_updateplayersuper(var_0);
  loadout_updateplayergesture(var_0);
  loadout_updateplayerkillstreaks(var_0, var_1);
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

setmlgspectatorclientloadoutdata(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 notify("setMLGSpectatorClientLoadoutData()");
  var_0 endon("setMLGSpectatorClientLoadoutData()");
  var_0 setclientweaponinfo(0, var_1.loadoutprimaryfullname);
  var_0 setclientweaponinfo(1, var_1.loadoutsecondaryfullname);
  var_2 = scripts\mp\powers::func_D738(var_1.var_AE7B);
  var_0 getrandomindex("primaryPower", var_2);
  var_3 = scripts\mp\powers::func_D738(var_1.var_AE7D);
  var_0 getrandomindex("secondaryPower", var_3);
  var_4 = scripts\mp\supers::func_8186(var_1.loadoutsuper);
  var_0 getrandomindex("super", var_4);

  if(isai(var_0)) {
    for(var_5 = 0; var_5 < var_1.loadoutperks.size; var_5++) {
      var_6 = var_1.loadoutperks[var_5];
      var_7 = scripts\mp\perks::getequipmenttableinfo(var_6);
      var_0 getrandomindex(var_5 + 1 + "_perk", var_7);
    }
  } else {
    if(var_1.loadoutperksfromgamemode) {
      var_1.loadoutstandardperks = var_1.loadoutperks;
    }

    for(var_5 = 0; var_5 < var_1.loadoutstandardperks.size; var_5++) {
      var_6 = var_1.loadoutstandardperks[var_5];
      var_7 = scripts\mp\perks::getequipmenttableinfo(var_6);
      var_0 getrandomindex(var_5 + 1 + "_perk", var_7);
    }

    for(var_5 = 0; var_5 < var_1.loadoutextraperks.size; var_5++) {
      var_6 = var_1.loadoutextraperks[var_5];
      var_7 = scripts\mp\perks::getequipmenttableinfo(var_6);
      var_0 getrandomindex(var_5 + 1 + "_extraPerk", var_7);
    }
  }

  var_8 = var_1.loadoutrigtrait;
  var_9 = scripts\mp\perks::getequipmenttableinfo(var_8);
  var_0 getrandomindex("rigTrait", var_9);
  var_10 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(var_1.loadoutarchetype);
  var_0 getrandomindex("archetype", var_10);
  var_0 setclientextrasuper(0, var_1.loadoutextrapowerprimary);
  var_0 setclientextrasuper(1, var_1.loadoutextrapowersecondary);
}

shouldallowinstantclassswap() {
  return level.ingraceperiod && level.func_8487 - level.ingraceperiod >= 0 && level.func_8487 - level.ingraceperiod < 5 && !self.hasdonecombat;
}

giveloadoutswap() {
  setclass(self.pers["class"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  scripts\mp\weapons::recordtogglescopestates();
  scripts\mp\weapons::func_DDF6();
  giveloadout(self.pers["team"], self.pers["class"]);

  if(!scripts\mp\utility\game::gameflag("prematch_done")) {
    scripts\mp\playerlogic::allowprematchlook(self);
  }
}

giveloadout(var_0, var_1, var_2) {
  self notify("giveLoadout_start");
  self.gettingloadout = 1;

  if(isDefined(self.perks)) {
    self.oldperks = self.perks;
  }

  loadout_clearweapons();
  var_3 = undefined;

  if(scripts\engine\utility::is_true(self.classset)) {
    var_3 = self.classstruct;
    self.classset = undefined;
  } else {
    var_3 = loadout_getclassstruct();
    var_3 = loadout_updateclass(var_3, var_1);
    self.classstruct = var_3;
  }

  loadout_giveextraweapons(var_3);
  loadout_updateplayer(var_3, var_1, var_2);
  func_AE38(var_3, var_1);
  self.gettingloadout = 0;
  self notify("changed_kit");
  self notify("giveLoadout");
}

loadout_giveextraweapons(var_0) {}

func_AE38(var_0, var_1) {
  if(!isplayer(self) && !isalive(self)) {
    return;
  }
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    thread setmlgspectatorclientloadoutdata(self, var_0);
  }

  var_2 = scripts\mp\utility\game::getclassindex(var_1);
  var_3 = var_2;
  var_4 = getsubstr(var_1, 0, 7) == "default";

  if(var_4) {
    var_3 = var_3 + 20;
  }

  var_5 = 10;
  var_6 = -1;

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_8 = _getmatchdata("players", self.clientid, "loadouts", var_7, "slotUsed");

    if(var_8) {
      var_9 = _getmatchdata("players", self.clientid, "loadouts", var_7, "classIndex");

      if(var_9 == var_3) {
        var_6 = var_7;
        break;
      }
    } else {
      var_6 = var_7;
      setmatchdata("players", self.clientid, "loadouts", var_7, "slotUsed", 1);
      setmatchdata("players", self.clientid, "loadouts", var_7, "classIndex", var_3);
      setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "weapon", var_0.loadoutprimary);

      for(var_10 = 0; var_10 < 6; var_10++) {
        setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "attachment", var_10, var_0.loadoutprimaryattachments[var_10]);
      }

      setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "camo", var_0.loadoutprimarycamo);
      setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "reticle", var_0.loadoutprimaryreticle);
      setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "lootItemID", var_0.loadoutprimarylootitemid);
      setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "variantID", var_0.loadoutprimaryvariantid);
      setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "paintJobID", var_0.var_AE8B);
      setmatchdata("players", self.clientid, "loadouts", var_7, "primaryWeaponSetup", "cosmeticAttachment", var_0.loadoutprimarycosmeticattachment);
      setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "weapon", var_0.loadoutsecondary);

      for(var_10 = 0; var_10 < 5; var_10++) {
        setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "attachment", var_10, var_0.loadoutsecondaryattachments[var_10]);
      }

      setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "camo", var_0.loadoutsecondarycamo);
      setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "reticle", var_0.loadoutsecondaryreticle);
      setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "lootItemID", var_0.var_AE9E);
      setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "variantID", var_0.var_AEA5);
      setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "paintJobID", var_0.var_AE9F);
      setmatchdata("players", self.clientid, "loadouts", var_7, "secondaryWeaponSetup", "cosmeticAttachment", var_0.loadoutsecondarycosmeticattachment);
      setmatchdata("players", self.clientid, "loadouts", var_7, "powerSetups", 0, "power", var_0.var_AE7B);
      setmatchdata("players", self.clientid, "loadouts", var_7, "powerSetups", 0, "extraCharge", cac_getextracharge(var_2));
      setmatchdata("players", self.clientid, "loadouts", var_7, "powerSetups", 1, "power", var_0.var_AE7D);
      setmatchdata("players", self.clientid, "loadouts", var_7, "powerSetups", 1, "extraCharge", cac_getextracharge2(var_2));
      var_11 = var_0.loadoutstandardperks.size;

      if(var_11 > 3) {
        var_11 = 3;
      }

      for(var_12 = 0; var_12 < var_11; var_12++) {
        setmatchdata("players", self.clientid, "loadouts", var_7, "loadoutPerks", var_12, var_0.loadoutstandardperks[var_12]);
      }

      var_13 = var_0.loadoutextraperks.size;

      if(var_13 > 3) {
        var_13 = 3;
      }

      for(var_12 = 0; var_12 < var_13; var_12++) {
        setmatchdata("players", self.clientid, "loadouts", var_7, "extraPerks", var_12, var_0.loadoutextraperks[var_12]);
      }

      setmatchdata("players", self.clientid, "killstreaks", 0, var_0.loadoutkillstreak1);
      setmatchdata("players", self.clientid, "killstreaks", 1, var_0.loadoutkillstreak2);
      setmatchdata("players", self.clientid, "killstreaks", 2, var_0.loadoutkillstreak3);

      if(var_6 == 0) {
        self func_859B(self.clientid, self.headmodel, self.model);

        if(isDefined(self.loadoutgesture)) {
          self func_85AB(self.clientid, self.loadoutgesture);
        }
      }

      break;
    }
  }

  if(isDefined(self.matchdatalifeindex) && scripts\mp\matchdata::canloglife(self.matchdatalifeindex)) {
    if(isDefined(var_0.loadoutarchetype)) {
      setmatchdata("lives", self.matchdatalifeindex, "archetype", var_0.loadoutarchetype);
    }

    if(isDefined(var_0.loadoutrigtrait) && var_0.loadoutrigtrait != "specialty_null") {
      setmatchdata("lives", self.matchdatalifeindex, "trait", var_0.loadoutrigtrait);
      self.lastmatchdatarigtrait = var_0.loadoutrigtrait;
    } else if(isDefined(self.lastmatchdatarigtrait)) {
      setmatchdata("lives", self.matchdatalifeindex, "trait", self.lastmatchdatarigtrait);
    }

    if(isDefined(var_0.loadoutsuper)) {
      setmatchdata("lives", self.matchdatalifeindex, "super", var_0.loadoutsuper);
    }

    setmatchdata("lives", self.matchdatalifeindex, "loadoutIndex", var_6);
  }

  self.var_AE6D = var_6;
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
    scripts\mp\utility\game::riotshield_detach(1);
  }

  if(isDefined(self.riotshieldmodelstowed)) {
    scripts\mp\utility\game::riotshield_detach(0);
  }

  self.hasriotshieldequipped = 0;
  self detachall();
}

func_9EE1(var_0) {
  var_1 = tablelookup("mp\perktable.csv", 1, var_0, 8);

  if(var_1 == "" || var_1 == "specialty_null") {
    return 0;
  }

  if(!self getteamdompoints(var_1, "perk")) {
    return 0;
  }

  return 1;
}

canplayerplacesentry(var_0) {
  var_1 = tablelookup("mp\perktable.csv", 1, var_0, 8);

  if(var_1 == "" || var_1 == "specialty_null") {
    return "specialty_null";
  }

  if(!self getteamdompoints(var_1, "perk")) {
    return "specialty_null";
  }

  return var_1;
}

trackriotshield_ontrophystow() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(var_0 != "trophy_mp") {
      continue;
    }
    if(!isDefined(self.riotshieldmodel)) {
      continue;
    }
    scripts\mp\utility\game::riotshield_move(1);
    self waittill("offhand_end");

    if(scripts\mp\weapons::isriotshield(self getcurrentweapon()) && isDefined(self.riotshieldmodelstowed)) {
      scripts\mp\utility\game::riotshield_move(0);
    }
  }
}

func_11B04() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.hasriotshield = scripts\mp\utility\game::riotshield_hasweapon();
  self.hasriotshieldequipped = scripts\mp\weapons::isriotshield(self.currentweaponatspawn);

  if(self.hasriotshield) {
    if(self.hasriotshieldequipped) {
      scripts\mp\utility\game::riotshield_attach(1, scripts\mp\utility\game::riotshield_getmodel());
    } else {
      scripts\mp\utility\game::riotshield_attach(0, scripts\mp\utility\game::riotshield_getmodel());
    }
  }

  thread trackriotshield_ontrophystow();

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0 == "none") {
      continue;
    }
    var_1 = scripts\mp\weapons::isriotshield(var_0);
    var_2 = !var_1 && scripts\mp\utility\game::riotshield_hasweapon();

    if(var_1) {
      if(!isDefined(self.riotshieldmodel)) {
        if(isDefined(self.riotshieldmodelstowed)) {
          scripts\mp\utility\game::riotshield_move(0);
        } else {
          scripts\mp\utility\game::riotshield_attach(1, scripts\mp\utility\game::riotshield_getmodel());
        }
      }
    } else if(var_2) {
      if(!isDefined(self.riotshieldmodelstowed)) {
        if(isDefined(self.riotshieldmodel)) {
          scripts\mp\utility\game::riotshield_move(1);
        } else {
          scripts\mp\utility\game::riotshield_attach(0, scripts\mp\utility\game::riotshield_getmodel());
        }
      }
    } else {
      if(isDefined(self.riotshieldmodel)) {
        scripts\mp\utility\game::riotshield_detach(1);
      }

      if(isDefined(self.riotshieldmodelstowed)) {
        scripts\mp\utility\game::riotshield_detach(0);
      }
    }

    self.hasriotshield = var_1 || var_2;
    self.hasriotshieldequipped = var_1;
  }
}

updateattachmentsformlg(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 == "ripperrscope_camo") {
      var_3 = "ripperrscope_na_camo";
    } else if(var_3 == "m8scope_camo") {
      var_3 = "m8scope_na_camo";
    } else if(var_3 == "arripper" || var_3 == "arm8" || var_3 == "akimbofmg" || var_3 == "glarclassic" || var_3 == "glmp28" || var_3 == "shotgunlongshot" || var_3 == "glsmoke" || var_3 == "glsmoke_slow" || var_3 == "gltacburst" || var_3 == "gltacburst_big") {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

ismark2weapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 >= 32;
}

isholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_0), var_1);
  return var_2 == "weapon_iw7_ripper_common_3" || var_2 == "weapon_iw7_lmg03_rare_3" || var_2 == "weapon_iw7_ar57_legendary_3";
}

isholidayweaponusingdefaultscope(var_0, var_1) {
  var_2 = scripts\mp\utility\game::attachmentmap_tounique("scope", getweaponbasename(var_0));
  return isDefined(var_2) && scripts\engine\utility::array_contains(var_1, var_2);
}

issummerholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_0), var_1);
  return var_2 == "weapon_iw7_erad_legendary_4" || var_2 == "weapon_iw7_ake_epic_4" || var_2 == "weapon_iw7_sdflmg_legendary_4" || var_2 == "weapon_iw7_mod2187_legendary_3" || var_2 == "weapon_iw7_longshot_legendary_3";
}

ishalloweenholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_0), var_1);
  return var_2 == "weapon_iw7_kbs_rare_3" || var_2 == "weapon_iw7_ripper_rare_3" || var_2 == "weapon_iw7_m4_rare_3" || var_2 == "weapon_iw7_mod2187_legendary_5" || var_2 == "weapon_iw7_mag_rare_3" || var_2 == "weapon_iw7_minilmg_epic_3";
}

hasscope(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\mp\utility\game::getattachmenttype(var_2) == "rail") {
      return 1;
    }
  }

  return 0;
}

buildweaponname(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_1 = scripts\mp\utility\game::weaponattachremoveextraattachments(var_1);
  var_1 = scripts\engine\utility::array_remove(var_1, "none");
  var_9 = scripts\mp\utility\game::weaponattachdefaultmap(var_0);
  var_10 = buildweaponassetname(var_0, var_4);

  if(isDefined(self.gettingloadout) && self.gettingloadout) {
    var_11 = getrandomweaponattachments(var_10, var_4, var_1);

    if(var_11.size > 0) {
      var_1 = scripts\engine\utility::array_combine_unique(var_1, var_11);

      foreach(var_13 in var_11) {
        scripts\mp\perks\weaponpassives::checkpassivemessage("passive_random_attachments", "_" + scripts\mp\utility\game::attachmentmap_tounique(var_13, var_10));
      }
    }
  }

  for(var_15 = 0; var_15 < var_1.size; var_15++) {
    var_1[var_15] = ::scripts\mp\utility\game::attachmentmap_tounique(var_1[var_15], var_10);
  }

  if(isDefined(var_9)) {
    for(var_15 = 0; var_15 < var_9.size; var_15++) {
      var_9[var_15] = ::scripts\mp\utility\game::attachmentmap_tounique(var_9[var_15], var_10);
    }
  }

  if(isDefined(var_9)) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_9);
  }

  if(isDefined(var_4)) {
    var_16 = getweaponvariantattachments(var_10, var_4);

    if(var_16.size > 0) {
      var_1 = scripts\engine\utility::array_combine_unique(var_1, var_16);
    }
  }

  if(isDefined(var_8) && var_8 != "none") {
    var_1[var_1.size] = var_8;
  }

  if(var_1.size > 0) {
    var_1 = filterattachments(var_1);
  }

  var_17 = [];

  foreach(var_19 in var_1) {
    var_20 = scripts\mp\utility\game::attachmentmap_toextra(var_19);

    if(isDefined(var_20)) {
      var_17[var_17.size] = ::scripts\mp\utility\game::attachmentmap_tounique(var_20, var_10);
    }
  }

  if(var_17.size > 0) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_17);
  }

  if(scripts\mp\utility\game::isanymlgmatch()) {
    var_1 = updateattachmentsformlg(var_1);
  }

  if(var_1.size > 0) {
    var_1 = scripts\engine\utility::alphabetize(var_1);
  }

  foreach(var_23 in var_1) {
    var_10 = var_10 + ("+" + var_23);
  }

  if(issubstr(var_10, "iw7")) {
    var_10 = buildweaponnamecamo(var_10, var_2, var_4);
    var_25 = 0;

    if(isholidayweapon(var_10, var_4) || issummerholidayweapon(var_10, var_4) || ishalloweenholidayweapon(var_10, var_4)) {
      var_25 = isholidayweaponusingdefaultscope(var_10, var_1);
    }

    if(hasscope(var_1)) {
      if(var_25 && !issubstr(var_10, "iw7_longshot")) {
        if(ishalloweenholidayweapon(var_10, var_4)) {
          var_10 = var_10 + ("+scope" + gethalloweenscopenumber(var_10, var_4));
        } else {
          var_10 = var_10 + "+scope1";
        }
      } else {
        var_10 = buildweaponnamereticle(var_10, var_3);
      }
    }

    var_10 = buildweaponnamevariantid(var_10, var_4);
  }

  return var_10;
}

gethalloweenscopenumber(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_0), var_1);
  var_3 = 0;

  switch (var_2) {
    case "weapon_iw7_minilmg_epic_3":
      var_3 = 1;
      break;
    case "weapon_iw7_mod2187_legendary_5":
    case "weapon_iw7_ripper_rare_3":
      var_3 = 2;
      break;
  }

  return var_3;
}

getrandomweaponattachments(var_0, var_1, var_2) {
  var_3 = [];

  if(weaponhaspassive(var_0, var_1, "passive_random_attachments")) {
    if(1) {
      var_4 = getavailableattachments(var_0, var_2, 0);
      var_3[var_3.size] = var_4[randomint(var_4.size)];
    } else {
      var_5 = randomintrange(1, 2);
      var_3 = buildrandomattachmentarray(var_0, var_5, var_2);
    }
  }

  return var_3;
}

func_11754(var_0, var_1) {
  var_2 = getavailableattachments(var_0, [], 0);

  foreach(var_4 in var_2) {
    scripts\mp\perks\weaponpassives::testpassivemessage("passive_random_attachments", "_" + scripts\mp\utility\game::attachmentmap_tounique(var_4, var_0));
  }
}

buildrandomattachmentarray(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = getattachmenttypeslist(var_0, var_2);

  if(var_4.size > 0) {
    var_3 = [];
    var_5 = scripts\engine\utility::array_randomize_objects(var_4);

    foreach(var_10, var_7 in var_5) {
      if(var_1 <= 0) {
        break;
      }
      var_8 = 1;

      switch (var_10) {
        case "undermount":
        case "barrel":
          var_8 = 1;
          break;
        case "rail":
          var_8 = 0;
          break;
        default:
          var_8 = randomintrange(1, var_1 + 1);
          break;
      }

      if(var_8 > 0) {
        if(var_8 > var_7.size) {
          var_8 = var_7.size;
        }

        var_1 = var_1 - var_8;

        for(var_7 = scripts\engine\utility::array_randomize_objects(var_7); var_8 > 0; var_8--) {
          var_9 = var_7[var_7.size - var_8];
          var_3[var_3.size] = var_9;
        }
      }
    }
  }

  return var_3;
}

getattachmenttypeslist(var_0, var_1) {
  var_2 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = scripts\mp\utility\game::getattachmenttype(var_5);

    if(listhasattachment(var_1, var_5)) {
      continue;
    }
    if(!isDefined(var_3[var_6])) {
      var_3[var_6] = [];
    }

    var_7 = var_3[var_6];
    var_7[var_7.size] = var_5;
    var_3[var_6] = var_7;
  }

  return var_3;
}

getavailableattachments(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_0);
  var_4 = [];

  foreach(var_6 in var_3) {
    var_7 = scripts\mp\utility\game::getattachmenttype(var_6);

    if(!var_2 && var_7 == "rail") {
      continue;
    }
    if(listhasattachment(var_1, var_6)) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  return var_4;
}

listhasattachment(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

getrandomarmkillstreak(var_0, var_1) {
  var_2 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_0);
  return dontcastdistantshadows(var_2, var_1);
}

dontcastshadows(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::getweaponbarsize(var_0, var_1);
  return dontcastdistantshadows(var_3, var_2);
}

dontcastdistantshadows(var_0, var_1) {
  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    if(var_1 > var_0.size) {
      var_1 = var_0.size;
    }

    for(var_2 = []; var_1 > 0 && var_0.size > 0; var_1--) {
      var_3 = var_0[var_0.size - var_1];
      var_2[var_2.size] = var_3;
    }

    if(var_2.size > 0) {
      return var_2;
    }
  }

  return var_0;
}

filterattachments(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(var_3 == "none") {
        continue;
      }
      var_4 = 1;

      foreach(var_6 in var_1) {
        if(var_3 == var_6) {
          var_4 = 0;
          break;
        }

        if(!scripts\mp\utility\game::attachmentscompatible(var_3, var_6)) {
          var_4 = 0;
          break;
        }
      }

      if(var_4) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

buildweaponassetname(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return scripts\mp\utility\game::func_13C75(var_0);
  } else {
    var_2 = scripts\mp\loot::getweaponassetfromrootweapon(var_0, var_1);
    return var_2;
  }
}

buildweaponnamecamo(var_0, var_1, var_2) {
  var_3 = -1;

  if(isholidayweapon(var_0, var_2)) {
    var_3 = int(tablelookup("mp\camoTable.csv", 1, "camo89", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return var_0 + "+camo" + var_3;
  } else if(issummerholidayweapon(var_0, var_2)) {
    var_3 = int(tablelookup("mp\camoTable.csv", 1, "camo230", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return var_0 + "+camo" + var_3;
  } else if(ishalloweenholidayweapon(var_0, var_2)) {
    var_3 = int(tablelookup("mp\camoTable.csv", 1, "camo242", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return var_0 + "+camo" + var_3;
  } else if((!isDefined(var_1) || var_1 == "none") && ismark2weapon(var_2)) {
    var_4 = scripts\mp\loot::getweaponqualitybyid(var_0, var_2);
    var_5 = undefined;

    switch (var_4) {
      case 1:
        var_5 = "camo99";
        break;
      case 2:
        var_5 = "camo101";
        break;
      case 3:
        var_5 = "camo102";
        break;
      case 4:
        var_5 = "camo103";
        break;
      default:
        break;
    }

    var_3 = int(tablelookup("mp\camoTable.csv", 1, var_5, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return var_0 + "+camo" + var_3;
  }

  if(!isDefined(var_1)) {
    var_3 = 0;
  } else {
    var_3 = int(tablelookup("mp\camoTable.csv", 1, var_1, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
  }

  if(var_3 <= 0) {
    var_4 = scripts\mp\loot::getweaponqualitybyid(var_0, var_2);
    var_5 = undefined;

    switch (var_4) {
      case 1:
        var_5 = "camo24";
        break;
      case 2:
        var_5 = "camo19";
        break;
      case 3:
        var_5 = "camo18";
        break;
      default:
        break;
    }

    if(isDefined(var_5)) {
      var_3 = int(tablelookup("mp\camoTable.csv", 1, var_5, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    } else {
      return var_0;
    }
  }

  return var_0 + "+camo" + var_3;
}

buildweaponnamereticle(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  var_2 = int(tablelookup("mp\reticleTable.csv", 1, var_1, 5));

  if(!isDefined(var_2) || var_2 == 0) {
    return var_0;
  }

  var_0 = var_0 + ("+scope" + var_2);
  return var_0;
}

buildweaponnamevariantid(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return var_0;
  }

  var_0 = var_0 + ("+loot" + var_1);
  return var_0;
}

getweaponpassives(var_0, var_1) {
  return scripts\mp\loot::getpassivesforweapon(buildweaponnamevariantid(var_0, var_1));
}

weaponhaspassive(var_0, var_1, var_2) {
  var_3 = getweaponpassives(var_0, var_1);

  if(!isDefined(var_3) || var_3.size <= 0) {
    return 0;
  }

  foreach(var_5 in var_3) {
    if(var_2 == var_5) {
      return 1;
    }
  }

  return 0;
}

getweaponvariantattachments(var_0, var_1) {
  var_2 = [];
  var_3 = getweaponpassives(var_0, var_1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = scripts\mp\passives::getpassiveattachment(var_5);

      if(!isDefined(var_6)) {
        continue;
      }
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

func_F775(var_0, var_1, var_2) {
  self.var_A6AB = [];
  var_3 = [];

  if(isDefined(var_0) && var_0 != "none") {
    var_4 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_0);
    var_3[var_4] = var_0;
  }

  if(isDefined(var_1) && var_1 != "none") {
    var_4 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_1);
    var_3[var_4] = var_1;
  }

  if(isDefined(var_2) && var_2 != "none") {
    var_4 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_2);
    var_3[var_4] = var_2;
  }

  var_5 = 0;

  foreach(var_4, var_7 in var_3) {
    if(var_4 > var_5) {
      var_5 = var_4;
    }
  }

  for(var_8 = 0; var_8 <= var_5; var_8++) {
    if(!isDefined(var_3[var_8])) {
      continue;
    }
    var_7 = var_3[var_8];
    self.var_A6AB[var_8] = var_3[var_8];
  }
}

func_E19F() {
  var_0 = self.pers["team"];
  var_1 = self.pers["class"];
  var_2 = self getweaponslistall();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    self givemaxammo(var_4);
    self setweaponammoclip(var_4, 9999);

    if(var_4 == "claymore_mp" || var_4 == "claymore_detonator_mp") {
      self setweaponammostock(var_4, 2);
    }
  }

  if(self getammocount(level.classgrenades[var_1]["primary"]["type"]) < level.classgrenades[var_1]["primary"]["count"]) {
    self setweaponammoclip(level.classgrenades[var_1]["primary"]["type"], level.classgrenades[var_1]["primary"]["count"]);
  }

  if(self getammocount(level.classgrenades[var_1]["secondary"]["type"]) < level.classgrenades[var_1]["secondary"]["count"]) {
    self setweaponammoclip(level.classgrenades[var_1]["secondary"]["type"], level.classgrenades[var_1]["secondary"]["count"]);
  }
}

onplayerconnecting() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["class"])) {
      var_0.pers["class"] = "";
    }

    if(!isDefined(var_0.pers["lastClass"])) {
      var_0.pers["lastClass"] = "";
    }

    var_0.class = var_0.pers["class"];
    var_0.lastclass = var_0.pers["lastClass"];
    var_0.var_53AD = 0;
    var_0.var_2C66 = [];
    var_0.var_2C67 = [];
    var_0.changedarchetypeinfo = var_0.pers["changedArchetypeInfo"];
    var_0.lastarchetypeinfo = undefined;

    if(!isai(var_0) && !scripts\engine\utility::is_true(var_0.btestclient)) {
      var_0 setclientomnvar("ui_selected_archetype", level.archetypeids[var_0 cac_getcharacterarchetype()]);
      var_0 setclientomnvar("ui_selected_super", scripts\mp\supers::func_8186(var_0 cac_getsuper()));
      var_0 setclientomnvar("ui_selected_trait", scripts\mp\perks::getequipmenttableinfo(var_0 cac_getloadoutarchetypeperk()));
    }

    if(!isDefined(var_0.pers["validationInfractions"])) {
      var_0.pers["validationInfractions"] = 0;
    }
  }
}

fadeaway(var_0, var_1) {
  wait(var_0);
  self fadeovertime(var_1);
  self.alpha = 0;
}

setclass(var_0) {
  self.curclass = var_0;
}

iskillstreak(var_0) {
  return scripts\mp\utility\game::getkillstreakindex(var_0) != -1;
}

haschangedclass() {
  if(isDefined(self.lastclass) && self.lastclass != self.class || !isDefined(self.lastclass)) {
    return 1;
  }

  if(level.gametype == "infect" && (!isDefined(self.last_infected_class) || self.last_infected_class != self.infected_class)) {
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
  scripts\mp\utility\game::_setactionslot(1, "");
  scripts\mp\utility\game::_setactionslot(2, "");
  scripts\mp\utility\game::_setactionslot(3, "");
  scripts\mp\utility\game::_setactionslot(4, "");

  if(!level.console) {
    scripts\mp\utility\game::_setactionslot(5, "");
    scripts\mp\utility\game::_setactionslot(6, "");
    scripts\mp\utility\game::_setactionslot(7, "");
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
  scripts\mp\killstreaks\chill_common::chill_resetdata();
  scripts\mp\perks\weaponpassives::passivecolddamageresetdata(self);
  scripts\mp\utility\game::_resetenableignoreme();
}

clearscriptable() {
  self setscriptablepartstate("CompassIcon", "defaultIcon");
  scripts\mp\killstreaks\chill_common::chill_resetscriptable();
  scripts\mp\perks\weaponpassives::passivecolddamageresetscriptable(self);
  scripts\mp\archetypes\archscout::func_B946();
  scripts\mp\equipment\cloak::func_E26A();
}

changearchetype(var_0, var_1, var_2) {
  if(isDefined(self.changedarchetypeinfo)) {
    var_3 = self.changedarchetypeinfo;

    if(var_3.archetype == var_0 && var_3.super == var_1 && var_3.trait == var_2) {
      return;
    }
  }

  var_4 = spawnStruct();
  var_4.archetype = var_0;
  var_4.super = var_1;
  var_4.trait = var_2;
  self.changedarchetypeinfo = var_4;
  self.pers["changedArchetypeInfo"] = var_4;

  if(!isai(self)) {
    self setclientomnvar("ui_selected_archetype", level.archetypeids[var_0]);
    self setclientomnvar("ui_selected_super", scripts\mp\supers::func_8186(var_1));
    self setclientomnvar("ui_selected_trait", scripts\mp\perks::getequipmenttableinfo(var_2));
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] != "") {
    scripts\mp\menus::preloadandqueueclass(self.pers["class"]);

    if(shouldallowinstantclassswap()) {
      giveloadoutswap();
    } else if(isalive(self)) {
      self iprintlnbold(game["strings"]["change_rig"]);
    }
  }
}

getattachmentloadoutstring(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1 == "primary", "loadoutPrimaryAttachment", "loadoutSecondaryAttachment");

  if(var_0 == 0) {
    return var_2;
  }

  return var_2 + (var_0 + 1);
}

getmaxprimaryattachments() {
  return 6;
}

getmaxsecondaryattachments() {
  return 5;
}

getmaxattachments(var_0) {
  return scripts\engine\utility::ter_op(var_0 == "primary", getmaxprimaryattachments(), getmaxsecondaryattachments());
}