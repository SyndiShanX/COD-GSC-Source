/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2706.gsc
***************************************/

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

getclasschoice(var_00) {
  return var_00;
}

getweaponchoice(var_00) {
  var_01 = strtok(var_00, ",");

  if(var_1.size > 1)
    return int(var_1[1]);
  else
    return 0;
}

cac_getweapon(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "weaponSetups", var_01, "weapon");
}

cac_getweaponattachment(var_00, var_01, var_02) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "weaponSetups", var_01, "attachment", var_02);
}

cac_getweaponlootitemid(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "weaponSetups", var_01, "lootItemID");
}

cac_getweaponvariantid(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "weaponSetups", var_01, "variantID");
}

cac_getweaponcamo(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "weaponSetups", var_01, "camo");
}

cac_getweaponreticle(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "weaponSetups", var_01, "reticle");
}

cac_getkillstreak(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_00, "killstreak");
}

cac_getcharacterarchetype() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.archetype;

  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "archetype");
}

cac_getpower(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "powerSetups", 0, "power");
}

cac_getextracharge(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "powerSetups", 0, "extraCharge");
}

cac_getpower2(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "powerSetups", 1, "power");
}

cac_getextracharge2(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "powerSetups", 1, "extraCharge");
}

cac_getpowerid(var_00) {
  var_01 = self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "powerSetups", 0, "lootItemID");
  return scripts\mp\powerloot::getpassiveperk(var_01);
}

cac_getpower2id(var_00) {
  var_01 = self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "powerSetups", 1, "lootItemID");
  return scripts\mp\powerloot::getpassiveperk(var_01);
}

cac_getsuper() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.super;

  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
}

cac_getgesture() {
  var_00 = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    var_01 = level.archetypeids[self.changedarchetypeinfo.archetype];

    if(level.rankedmatch)
      var_00 = self getrankedplayerdata("rankedloadouts", "squadMembers", "archetypePreferences", var_01, "gesture");
    else
      var_00 = self getrankedplayerdata("privateloadouts", "squadMembers", "archetypePreferences", var_01, "gesture");
  } else if(level.rankedmatch)
    var_00 = self getrankedplayerdata("rankedloadouts", "squadMembers", "gesture");
  else
    var_00 = self getrankedplayerdata("privateloadouts", "squadMembers", "gesture");

  return scripts\mp\gestures::getgesturedata(var_00);
}

cac_getloadoutperk(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "loadoutPerks", var_01);
}

cac_getloadoutextraperk(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "extraPerks", var_01);
}

cac_getloadoutarchetypeperk() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.trait;

  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "archetypePerk");
}

cac_getkillstreaklootid(var_00, var_01) {
  var_02 = self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_01, "lootItemID");
  return scripts\mp\killstreak_loot::getpassiveperk(var_02);
}

cac_getkillstreakvariantid(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_00, "lootItemID");
}

cac_getweaponcosmeticattachment(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_00, "weaponSetups", var_01, "cosmeticAttachment");
}

recipe_getkillstreak(var_00, var_01, var_02) {
  return scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "kilstreakSetups", var_02, "killstreak");
}

table_getarchetype(var_00, var_01) {
  return tablelookup(var_00, 0, "loadoutArchetype", var_01 + 1);
}

table_getweapon(var_00, var_01, var_02) {
  if(var_02 == 0)
    return tablelookup(var_00, 0, "loadoutPrimary", var_01 + 1);
  else
    return tablelookup(var_00, 0, "loadoutSecondary", var_01 + 1);
}

table_getweaponattachment(var_00, var_01, var_02, var_03) {
  var_04 = "none";

  if(var_02 == 0)
    var_04 = tablelookup(var_00, 0, "loadoutPrimaryAttachment" + (var_03 + 1), var_01 + 1);
  else
    var_04 = tablelookup(var_00, 0, "loadoutSecondaryAttachment" + (var_03 + 1), var_01 + 1);

  if(var_04 == "" || var_04 == "none")
    return "none";
  else
    return var_04;
}

table_getweaponcamo(var_00, var_01, var_02) {
  if(var_02 == 0)
    return tablelookup(var_00, 0, "loadoutPrimaryCamo", var_01 + 1);
  else
    return tablelookup(var_00, 0, "loadoutSecondaryCamo", var_01 + 1);
}

table_getweaponreticle(var_00, var_01, var_02) {
  if(var_02 == 0)
    return tablelookup(var_00, 0, "loadoutPrimaryReticle", var_01 + 1);
  else
    return tablelookup(var_00, 0, "loadoutSecondaryReticle", var_01 + 1);
}

table_getperk(var_00, var_01, var_02) {
  return tablelookup(var_00, 0, "loadoutPerk" + (var_02 + 1), var_01 + 1);
}

table_getextraperk(var_00, var_01, var_02) {
  return tablelookup(var_00, 0, "loadoutExtraPerk" + (var_02 + 1), var_01 + 1);
}

table_getpowerprimary_MAYBE(var_00, var_01) {
  return tablelookup(var_00, 0, "loadoutPowerPrimary", var_01 + 1);
}

table_getextrapowerprimary_MAYBE(var_00, var_01) {
  var_02 = tablelookup(var_00, 0, "loadoutExtraPowerPrimary", var_01 + 1);
  return isDefined(var_02) && var_02 == "TRUE";
}

table_getpowersecondary_MAYBE(var_00, var_01) {
  return tablelookup(var_00, 0, "loadoutPowerSecondary", var_01 + 1);
}

table_getextrapowersecondary_MAYBE(var_00, var_01) {
  var_02 = tablelookup(var_00, 0, "loadoutExtraPowerSecondary", var_01 + 1);
  return isDefined(var_02) && var_02 == "TRUE";
}

table_getsuper(var_00, var_01) {
  return tablelookup(var_00, 0, "loadoutSuper", var_01 + 1);
}

table_getgesture(var_00, var_01) {
  return tablelookup(var_00, 0, "loadoutGesture", var_01 + 1);
}

table_getkillstreak(var_00, var_01, var_02) {
  return tablelookup(var_00, 0, "loadoutStreak" + var_02, var_01 + 1);
}

loadout_getplayerstreaktype(var_00) {
  var_01 = undefined;

  switch (var_00) {
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
  }

  return var_01;
}

getloadoutstreaktypefromstreaktype(var_00) {
  if(!isDefined(var_00))
    return "streaktype_assault";

  switch (var_00) {
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

loadout_getclassteam(var_00) {
  var_01 = undefined;

  if(issubstr(var_00, "axis"))
    var_01 = "axis";
  else if(issubstr(var_00, "allies"))
    var_01 = "allies";
  else
    var_01 = "none";

  return var_01;
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

  if(isDefined(self.loadoutarchetype))
    clearscriptable();

  scripts\mp\archetypes\archcommon::removearchetype(self.loadoutarchetype);
  scripts\mp\perks::_clearperks();
  scripts\mp\perks\weaponpassives::forgetpassives();
  scripts\mp\gestures::func_41B2();
  resetactionslots();
  resetfunctionality();

  if(isplayer(self))
    scripts\mp\killstreaks\emp_common::func_E24E();
}

loadout_getclassstruct() {
  var_00 = spawnStruct();
  var_0.loadoutarchetype = "none";
  var_0.loadoutprimary = "none";
  var_0.loadoutprimaryattachments = [];

  for(var_01 = 0; var_01 < 6; var_1++)
    var_0.loadoutprimaryattachments[var_01] = "none";

  var_0.loadoutprimarycamo = "none";
  var_0.loadoutprimaryreticle = "none";
  var_0.loadoutprimarylootitemid = 0;
  var_0.loadoutprimaryvariantid = -1;
  var_0.loadoutprimarycosmeticattachment = "none";
  var_0.loadoutsecondary = "none";
  var_0.loadoutsecondaryattachments = [];

  for(var_01 = 0; var_01 < 5; var_1++)
    var_0.loadoutsecondaryattachments[var_01] = "none";

  var_0.loadoutsecondarycamo = "none";
  var_0.loadoutsecondaryreticle = "none";
  var_0.func_AE9E = 0;
  var_0.func_AEA5 = -1;
  var_0.loadoutsecondarycosmeticattachment = "none";
  var_0.loadoutperksfromgamemode = 0;
  var_0.loadoutperks = [];
  var_0.loadoutstandardperks = [];
  var_0.loadoutextraperks = [];
  var_0.loadoutrigtrait = "specialty_null";
  var_0.func_AE7B = "none";
  var_0.func_AE7C = [];
  var_0.loadoutextrapowerprimary = 0;
  var_0.func_AE7D = "none";
  var_0.func_AE7E = [];
  var_0.loadoutextrapowersecondary = 0;
  var_0.loadoutsuper = "none";
  var_0.loadoutgesture = "none";
  var_0.loadoutstreaksfilled = 0;
  var_0.loadoutstreaktype = "streaktype_assault";
  var_0.loadoutkillstreak1 = "none";
  var_0.loadoutkillstreak1variantid = -1;
  var_0.func_AE6F = [];
  var_0.loadoutkillstreak2 = "none";
  var_0.loadoutkillstreak2variantid = -1;
  var_0.func_AE71 = [];
  var_0.loadoutkillstreak3 = "none";
  var_0.loadoutkillstreak3variantid = -1;
  var_0.func_AE73 = [];
  return var_00;
}

loadout_updateclassteam(var_00, var_01, var_02) {
  var_02 = loadout_getclassteam(var_01);
  var_03 = scripts\mp\utility\game::getclassindex(var_01);
  self.class_num = var_03;
  self.classteam = var_02;
  var_0.loadoutarchetype = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "archetype");
  var_0.loadoutprimary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 0, "weapon");

  if(var_0.loadoutprimary == "none")
    var_0.loadoutprimary = "iw7_fists";
  else {
    for(var_04 = 0; var_04 < 6; var_4++)
      var_0.loadoutprimaryattachments[var_04] = ::scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 0, "attachment", var_04);
  }

  var_0.loadoutprimarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 0, "camo");
  var_0.loadoutprimaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 0, "reticle");
  var_0.loadoutsecondary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 1, "weapon");

  for(var_04 = 0; var_04 < 5; var_4++)
    var_0.loadoutsecondaryattachments[var_04] = ::scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 1, "attachment", var_04);

  var_0.loadoutsecondarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 1, "camo");
  var_0.loadoutsecondaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "weaponSetups", 1, "reticle");
  var_0.func_AE7B = "none";
  var_0.loadoutextrapowerprimary = 0;
  var_0.func_AE7D = "none";
  var_0.loadoutextrapowersecondary = 0;
  var_0.loadoutsuper = "none";
  var_0.loadoutgesture = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "class", "gesture");
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = recipe_getkillstreak(var_02, var_03, 0);
  var_0.loadoutkillstreak2 = recipe_getkillstreak(var_02, var_03, 1);
  var_0.loadoutkillstreak3 = recipe_getkillstreak(var_02, var_03, 2);
  var_0.func_AE6F = [];
  var_0.func_AE71 = [];
  var_0.func_AE73 = [];
  var_0.func_AE7C = [];
  var_0.func_AE7E = [];
  var_0.loadoutkillstreak1variantid = -1;
  var_0.loadoutkillstreak2variantid = -1;
  var_0.loadoutkillstreak3variantid = -1;

  if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_02, var_03, "juggernaut"))
    func_AE23();
  else if(scripts\mp\utility\game::isjuggernaut())
    loadout_removejugg_MAYBE();
}

loadout_updateclasscustom(var_00, var_01) {
  var_02 = scripts\mp\utility\game::getclassindex(var_01);
  self.class_num = var_02;
  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutprimary = cac_getweapon(var_02, 0);

  for(var_03 = 0; var_03 < 6; var_3++)
    var_0.loadoutprimaryattachments[var_03] = cac_getweaponattachment(var_02, 0, var_03);

  var_0.loadoutprimarycamo = cac_getweaponcamo(var_02, 0);
  var_0.loadoutprimaryreticle = cac_getweaponreticle(var_02, 0);
  var_0.loadoutprimarylootitemid = cac_getweaponlootitemid(var_02, 0);
  var_0.loadoutprimaryvariantid = cac_getweaponvariantid(var_02, 0);
  var_0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_02, 0);
  var_0.loadoutsecondary = cac_getweapon(var_02, 1);

  for(var_03 = 0; var_03 < 5; var_3++)
    var_0.loadoutsecondaryattachments[var_03] = cac_getweaponattachment(var_02, 1, var_03);

  var_0.loadoutsecondarycamo = cac_getweaponcamo(var_02, 1);
  var_0.loadoutsecondaryreticle = cac_getweaponreticle(var_02, 1);
  var_0.func_AE9E = cac_getweaponlootitemid(var_02, 1);
  var_0.func_AEA5 = cac_getweaponvariantid(var_02, 1);
  var_0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_02, 1);
  var_0.func_AE7B = cac_getpower(var_02);
  var_0.func_AE7C = cac_getpowerid(var_02);
  var_0.loadoutextrapowerprimary = cac_getextracharge(var_02);
  var_0.func_AE7D = cac_getpower2(var_02);
  var_0.func_AE7E = cac_getpower2id(var_02);
  var_0.loadoutextrapowersecondary = cac_getextracharge2(var_02);
  var_0.loadoutsuper = cac_getsuper();
  var_0.loadoutgesture = cac_getgesture();
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = cac_getkillstreak(0);
  var_0.func_AE6F = cac_getkillstreaklootid(var_02, 0);
  var_0.loadoutkillstreak1variantid = cac_getkillstreakvariantid(0);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1);
  var_0.func_AE71 = cac_getkillstreaklootid(var_02, 1);
  var_0.loadoutkillstreak2variantid = cac_getkillstreakvariantid(1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2);
  var_0.func_AE73 = cac_getkillstreaklootid(var_02, 2);
  var_0.loadoutkillstreak3variantid = cac_getkillstreakvariantid(2);
}

loadout_updateclassgamemode(var_00, var_01) {
  var_02 = scripts\mp\utility\game::getclassindex(var_01);
  self.class_num = var_02;
  var_03 = self.pers["gamemodeLoadout"];

  if(isDefined(var_3["loadoutArchetype"])) {
    var_0.loadoutarchetype = var_3["loadoutArchetype"];

    if(isbot(self))
      self.botarchetype = var_3["loadoutArchetype"];
  } else if(isbot(self)) {
    var_04 = scripts\mp\bots\bots_loadout::bot_loadout_class_callback();
    var_0.loadoutarchetype = var_4["loadoutArchetype"];
  } else
    var_0.loadoutarchetype = cac_getcharacterarchetype();

  if(isDefined(var_3["loadoutRigTrait"]))
    var_0.loadoutrigtrait = var_3["loadoutRigTrait"];

  if(isDefined(var_3["loadoutPrimary"]))
    var_0.loadoutprimary = var_3["loadoutPrimary"];

  for(var_05 = 0; var_05 < 6; var_5++) {
    var_06 = getattachmentloadoutstring(var_05, "primary");

    if(isDefined(var_3[var_06]))
      var_0.loadoutprimaryattachments[var_05] = var_3[var_06];
  }

  if(isDefined(var_3["loadoutPrimaryCamo"]))
    var_0.loadoutprimarycamo = var_3["loadoutPrimaryCamo"];

  if(isDefined(var_3["loadoutPrimaryReticle"]))
    var_0.loadoutprimaryreticle = var_3["loadoutPrimaryReticle"];

  if(isDefined(var_3["loadoutSecondary"]))
    var_0.loadoutsecondary = var_3["loadoutSecondary"];

  for(var_05 = 0; var_05 < 5; var_5++) {
    var_06 = getattachmentloadoutstring(var_05, "secondary");

    if(isDefined(var_3[var_06]))
      var_0.loadoutsecondaryattachments[var_05] = var_3[var_06];
  }

  if(isDefined(var_3["loadoutSecondaryCamo"]))
    var_0.loadoutsecondarycamo = var_3["loadoutSecondaryCamo"];

  if(isDefined(var_3["loadoutSecondaryReticle"]))
    var_0.loadoutsecondaryreticle = var_3["loadoutSecondaryReticle"];

  var_0.loadoutperksfromgamemode = isDefined(var_3["loadoutPerks"]);

  if(isDefined(var_3["loadoutPerks"]))
    var_0.loadoutperks = var_3["loadoutPerks"];

  if(isDefined(var_3["loadoutPowerPrimary"]))
    var_0.func_AE7B = var_3["loadoutPowerPrimary"];

  if(isDefined(var_3["loadoutExtraPowerPrimary"]))
    var_0.loadoutextrapowerprimary = var_3["loadoutExtraPowerPrimary"];

  if(isDefined(var_3["loadoutPowerPrimaryPassives"]))
    var_0.func_AE7C = var_3["loadoutPowerPrimaryPassives"];

  if(isDefined(var_3["loadoutPowerSecondary"]))
    var_0.func_AE7D = var_3["loadoutPowerSecondary"];

  if(isDefined(var_3["loadoutExtraPowerSecondary"]))
    var_0.loadoutextrapowersecondary = var_3["loadoutExtraPowerSecondary"];

  if(isDefined(var_3["loadoutPowerSecondaryPassives"]))
    var_0.func_AE7E = var_3["loadoutPowerSecondaryPassives"];

  if(isDefined(var_3["loadoutSuper"]))
    var_0.loadoutsuper = var_3["loadoutSuper"];

  if(isDefined(var_3["loadoutGesture"]) && var_3["loadoutGesture"] == "playerData") {
    if(isbot(self))
      var_0.loadoutgesture = "none";
    else
      var_0.loadoutgesture = cac_getgesture();
  } else if(isDefined(var_3["loadoutGesture"]))
    var_0.loadoutgesture = var_3["loadoutGesture"];

  if(isDefined(var_3["loadoutKillstreak1"]) && var_3["loadoutKillstreak1"] != "specialty_null" || isDefined(var_3["loadoutKillstreak2"]) && var_3["loadoutKillstreak2"] != "specialty_null" || isDefined(var_3["loadoutKillstreak3"]) && var_3["loadoutKillstreak3"] != "specialty_null") {
    var_0.loadoutstreaksfilled = 1;
    var_0.loadoutkillstreak1 = var_3["loadoutKillstreak1"];
    var_0.loadoutkillstreak2 = var_3["loadoutKillstreak2"];
    var_0.loadoutkillstreak3 = var_3["loadoutKillstreak3"];

    if(isDefined(var_3["loadoutKillstreak1Passives"]))
      var_0.func_AE6F = var_3["loadoutKillstreak1Passives"];

    if(isDefined(var_3["loadoutKillstreak2Passives"]))
      var_0.func_AE71 = var_3["loadoutKillstreak2Passives"];

    if(isDefined(var_3["loadoutKillstreak3Passives"]))
      var_0.func_AE73 = var_3["loadoutKillstreak3Passives"];
  }

  if(var_3["loadoutJuggernaut"])
    func_AE23();
  else if(scripts\mp\utility\game::isjuggernaut())
    loadout_removejugg_MAYBE();
}

func_AE50(var_00) {
  var_0.loadoutprimary = "iw7_chargeshot_c8";
  var_0.loadoutsecondary = "iw7_c8landing";
}

loadout_updateclasscallback(var_00) {
  if(!isDefined(self.classcallback))
    scripts\engine\utility::error("self.classCallback function reference required for class 'callback'");

  var_01 = self[[self.classcallback]]();

  if(!isDefined(var_01))
    scripts\engine\utility::error("array required from self.classCallback for class 'callback'");

  if(isDefined(var_1["loadoutArchetype"]))
    var_0.loadoutarchetype = var_1["loadoutArchetype"];

  if(isDefined(var_1["loadoutPrimary"]))
    var_0.loadoutprimary = var_1["loadoutPrimary"];

  for(var_02 = 0; var_02 < 6; var_2++) {
    var_03 = getattachmentloadoutstring(var_02, "primary");

    if(isDefined(var_1[var_03]))
      var_0.loadoutprimaryattachments[var_02] = var_1[var_03];
  }

  if(isDefined(var_1["loadoutPrimaryCamo"]))
    var_0.loadoutprimarycamo = var_1["loadoutPrimaryCamo"];

  if(isDefined(var_1["loadoutPrimaryReticle"]))
    var_0.loadoutprimaryreticle = var_1["loadoutPrimaryReticle"];

  if(isDefined(var_1["loadoutSecondary"]))
    var_0.loadoutsecondary = var_1["loadoutSecondary"];

  for(var_02 = 0; var_02 < 5; var_2++) {
    var_03 = getattachmentloadoutstring(var_02, "secondary");

    if(isDefined(var_1[var_03]))
      var_0.loadoutsecondaryattachments[var_02] = var_1[var_03];
  }

  if(isDefined(var_1["loadoutSecondaryCamo"]))
    var_0.loadoutsecondarycamo = var_1["loadoutSecondaryCamo"];

  if(isDefined(var_1["loadoutSecondaryReticle"]))
    var_0.loadoutsecondaryreticle = var_1["loadoutSecondaryReticle"];

  if(isDefined(var_1["loadoutPowerPrimary"]))
    var_0.func_AE7B = var_1["loadoutPowerPrimary"];

  if(isDefined(var_1["loadoutPowerPrimaryPassives"]))
    var_0.func_AE7C = var_1["loadoutPowerPrimaryPassives"];

  if(isDefined(var_1["loadoutExtraPowerPrimary"]))
    var_0.loadoutextrapowerprimary = var_1["loadoutExtraPowerPrimary"];

  if(isDefined(var_1["loadoutPowerSecondary"]))
    var_0.func_AE7D = var_1["loadoutPowerSecondary"];

  if(isDefined(var_1["loadoutPowerSecondaryPassives"]))
    var_0.func_AE7E = var_1["loadoutPowerSecondaryPassives"];

  if(isDefined(var_1["loadoutExtraPowerSecondary"]))
    var_0.loadoutextrapowersecondary = var_1["loadoutPowerExtraSecondary"];

  if(isDefined(var_1["loadoutSuper"]))
    var_0.loadoutsuper = var_1["loadoutSuper"];

  if(isDefined(var_1["loadoutGesture"]))
    var_0.loadoutgesture = var_1["loadoutGesture"];

  var_0.loadoutstreaksfilled = isDefined(var_1["loadoutStreak1"]) || isDefined(var_1["loadoutStreak2"]) || isDefined(var_1["loadoutStreak3"]);

  if(isDefined(var_1["loadoutStreakType"]))
    var_0.loadoutstreaktype = var_1["loadoutStreakType"];

  if(isDefined(var_1["loadoutStreak1"]))
    var_0.loadoutkillstreak1 = var_1["loadoutStreak1"];

  if(isDefined(var_1["loadoutStreak2"]))
    var_0.loadoutkillstreak2 = var_1["loadoutStreak2"];

  if(isDefined(var_1["loadoutStreak3"]))
    var_0.loadoutkillstreak3 = var_1["loadoutStreak3"];

  if(isDefined(var_1["loadoutKillstreak1Passives"]))
    var_0.func_AE6F = var_1["loadoutKillstreak1Passives"];

  if(isDefined(var_1["loadoutKillstreak2Passives"]))
    var_0.func_AE71 = var_1["loadoutKillstreak2Passives"];

  if(isDefined(var_1["loadoutKillstreak3Passives"]))
    var_0.func_AE73 = var_1["loadoutKillstreak3Passives"];
}

loadout_updateclassdefault(var_00, var_01) {
  var_02 = scripts\mp\utility\game::getclassindex(var_01);
  self.class_num = var_02;
  var_0.loadoutprimary = table_getweapon(level.classtablename, var_02, 0);

  for(var_03 = 0; var_03 < 6; var_3++)
    var_0.loadoutprimaryattachments[var_03] = table_getweaponattachment(level.classtablename, var_02, 0, var_03);

  var_0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_02, 0);
  var_0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_02, 0);
  var_0.loadoutsecondary = table_getweapon(level.classtablename, var_02, 1);

  for(var_03 = 0; var_03 < 5; var_3++)
    var_0.loadoutsecondaryattachments[var_03] = table_getweaponattachment(level.classtablename, var_02, 1, var_03);

  var_0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_02, 1);
  var_0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_02, 1);
  var_0.func_AE7B = table_getpowerprimary_MAYBE(level.classtablename, var_02);
  var_0.loadoutextrapowerprimary = table_getextrapowerprimary_MAYBE(level.classtablename, var_02);
  var_0.func_AE7D = table_getpowersecondary_MAYBE(level.classtablename, var_02);
  var_0.loadoutextrapowersecondary = table_getextrapowersecondary_MAYBE(level.classtablename, var_02);
  var_0.loadoutgesture = table_getgesture(level.classtablename, var_02);
  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutsuper = cac_getsuper();
  var_0.loadoutkillstreak1 = cac_getkillstreak(0);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2);
  var_0.loadoutrigtrait = cac_getloadoutarchetypeperk();
  var_0.loadoutgesture = cac_getgesture();
}

loadout_updatestreaktype(var_00) {
  self.streaktype = "streaktype_assault";
  var_0.loadoutstreaktype = self.streaktype;
}

loadout_updateabilities(var_00, var_01) {
  if(!isDefined(self.pers["loadoutPerks"]))
    self.pers["loadoutPerks"] = [];

  if(!isDefined(self.pers["loadoutStandardPerks"]))
    self.pers["loadoutStandardPerks"] = [];

  if(!isDefined(self.pers["loadoutExtraPerks"]))
    self.pers["loadoutExtraPerks"] = [];

  if(!isDefined(self.pers["loadoutRigTrait"]))
    self.pers["loadoutRigTrait"] = [];

  if(scripts\mp\utility\game::isjuggernaut()) {
    return;
  }
  var_02 = getsubstr(var_01, 0, 7) == "default";

  if(var_0.loadoutperksfromgamemode) {
    return;
  }
  if(!scripts\mp\utility\game::perksenabled())
    return;
  else if(isai(self)) {
    if(isDefined(self.pers["loadoutPerks"]))
      var_0.loadoutperks = self.pers["loadoutPerks"];
  } else if(haschangedclass() || haschangedarchetype()) {
    var_03 = loadout_getclassteam(var_01);

    for(var_04 = 0; var_04 < 3; var_4++) {
      var_05 = "specialty_null";

      if(var_03 != "none") {
        var_06 = scripts\mp\utility\game::getclassindex(var_01);
        var_05 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_03, var_06, "class", "loadoutPerks");
      } else if(var_02) {
        var_06 = scripts\mp\utility\game::getclassindex(var_01);
        var_05 = table_getperk(level.classtablename, var_06, var_04);
      } else
        var_05 = cac_getloadoutperk(self.class_num, var_04);

      if(var_05 != "specialty_null") {
        var_0.loadoutperks[var_0.loadoutperks.size] = var_05;
        var_0.loadoutstandardperks[var_0.loadoutstandardperks.size] = var_05;
      }
    }

    for(var_04 = 0; var_04 < 3; var_4++) {
      var_05 = "specialty_null";

      if(var_03 != "none") {
        var_06 = scripts\mp\utility\game::getclassindex(var_01);
        var_05 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_03, var_06, "class", "extraPerks");
      } else if(var_02) {
        var_06 = scripts\mp\utility\game::getclassindex(var_01);
        var_05 = table_getextraperk(level.classtablename, var_06, var_04);
      } else
        var_05 = cac_getloadoutextraperk(self.class_num, var_04);

      if(var_05 != "specialty_null") {
        var_0.loadoutperks[var_0.loadoutperks.size] = var_05;
        var_0.loadoutextraperks[var_0.loadoutextraperks.size] = var_05;
      }
    }

    var_05 = "specialty_null";

    if(var_03 != "none") {
      var_06 = scripts\mp\utility\game::getclassindex(var_01);
      var_05 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_03, var_06, "class", "archetypePerk");
    } else
      var_05 = cac_getloadoutarchetypeperk();

    if(var_05 != "specialty_null") {
      var_0.loadoutperks[var_0.loadoutperks.size] = var_05;
      self.pers["loadoutRigTrait"] = var_05;
      var_0.loadoutrigtrait = var_05;
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

loadout_updateclass(var_00, var_01) {
  var_02 = loadout_getclassteam(var_01);

  if(var_02 != "none")
    loadout_updateclassteam(var_00, var_01);
  else if(issubstr(var_01, "custom"))
    loadout_updateclasscustom(var_00, var_01);
  else if(var_01 == "gamemode")
    loadout_updateclassgamemode(var_00, var_01);
  else if(var_01 == "rc8Agent")
    func_AE50(var_00);
  else if(var_01 == "callback")
    loadout_updateclasscallback(var_00);
  else
    loadout_updateclassdefault(var_00, var_01);

  loadout_updateclassfistweapons(var_00);
  loadout_updatestreaktype(var_00);
  loadout_updateabilities(var_00, var_01);
  var_00 = loadout_validateclass(var_00, var_01);
  return var_00;
}

loadout_updateclassfistweapons(var_00) {
  if(var_0.loadoutprimary == "none")
    var_0.loadoutprimary = "iw7_fists";

  if(var_0.loadoutsecondary == "none" && var_0.loadoutprimary != "iw7_fists")
    var_0.loadoutsecondary = "iw7_fists";
  else if(var_0.loadoutprimary == "iw7_fists" && var_0.loadoutsecondary == "iw7_fists")
    var_0.loadoutsecondary = "none";
}

loadout_validateclass(var_00, var_01) {
  if(issubstr(var_01, "custom"))
    return scripts\mp\validation::validateloadout(var_00);

  return var_00;
}

loadout_forcearchetype(var_00) {
  var_01 = getdvarint("forceArchetype", 0);

  if(var_01 > 0) {
    var_02 = getdvarint("forceArchetype", 0);

    switch (var_02) {
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
  } else if(var_01 == -1) {
    var_03 = ["archetype_assault", "archetype_heavy", "archetype_scout", "archetype_assassin", "archetype_engineer", "archetype_sniper"];
    var_04 = randomint(var_3.size);
    var_0.loadoutarchetype = var_3[var_04];
    self iprintlnbold("Random Archetype: " + var_3[var_04]);
  }
}

loadout_updateplayerarchetype(var_00) {
  if(!scripts\engine\utility::is_true(self.btestclient)) {
    if(!isDefined(level.aonrules) || level.aonrules == 0) {}
  }

  self.loadoutarchetype = var_0.loadoutarchetype;
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
  var_10 = 400;
  var_11 = 900;

  if(level.tactical) {
    var_10 = 133.333;
    var_11 = 1800;
  }

  switch (self.loadoutarchetype) {
    case "archetype_assault":
      var_05 = "assault_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = scripts\mp\archetypes\archassault::applyarchetype;
      var_08 = "vestlight";
      break;
    case "archetype_heavy":
      var_05 = "armor_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = scripts\mp\archetypes\archheavy::applyarchetype;
      var_08 = "vestheavy";
      break;
    case "archetype_scout":
      var_05 = "scout_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = scripts\mp\archetypes\archscout::applyarchetype;
      var_08 = "c6servo";
      break;
    case "archetype_assassin":
      var_05 = "assassin_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = scripts\mp\archetypes\archassassin::applyarchetype;
      var_08 = "vestftl";
      break;
    case "archetype_engineer":
      var_05 = "engineer_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = scripts\mp\archetypes\archengineer::applyarchetype;
      var_08 = "vestlight";
      break;
    case "archetype_sniper":
      var_05 = "sniper_mp";
      var_06 = var_01 | var_02 | var_03;
      var_07 = scripts\mp\archetypes\archsniper::applyarchetype;
      var_08 = "vestghost";
      break;
    default:
      if(!scripts\engine\utility::is_true(self.btestclient)) {
        if(!isDefined(level.aonrules) || level.aonrules == 0) {}
      }

      break;
  }

  if(level.tactical) {
    var_05 = var_05 + "_tactical";
    var_01 = 0;
  }

  self _meth_845E(0);
  self allowdoublejump(var_06 &var_01);
  self allowslide(var_06 &var_02);
  self allowwallrun(var_06 &var_03);
  self allowdodge(var_06 &var_04);
  self allowlean(0);
  self setsuit(var_05);
  self energy_setmax(0, var_09);
  self goal_radius(0, var_09);
  self goalflag(0, var_10);
  self goal_type(0, var_11);
  self energy_setmax(1, 50);
  self goal_radius(1, 50);
  self goalflag(1, 10);
  self goal_type(1, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 2500, 0));

  if(isDefined(level.supportdoublejump_MAYBE)) {
    if(!level.supportdoublejump_MAYBE)
      scripts\engine\utility::allow_doublejump(0);
  }

  if(isDefined(level.supportwallrun_MAYBE)) {
    if(!level.supportwallrun_MAYBE)
      scripts\engine\utility::allow_wallrun(0);
  }

  if(isDefined(var_07))
    self[[var_07]]();

  if(isDefined(var_08)) {
    self give_explosive_touch_on_revived(var_08);

    if(var_08 == "c6servo")
      self _meth_8460("clothtype", "c6servo");
    else
      self _meth_8460("clothtype", "");

    self.func_42B0 = var_08;
  }

  thread scripts\mp\archetypes\archcommon::func_EF38();
  thread scripts\mp\archetypes\archcommon::func_EF41();
}

loadout_updateclassfinalweapons(var_00) {
  if(isDefined(self.class_num)) {
    var_0.func_AE8B = self.class_num * 2 + 0;
    var_0.func_AE9F = self.class_num * 2 + 1;
  } else {
    var_0.func_AE8B = -1;
    var_0.func_AE9F = -1;
  }

  var_0.loadoutprimaryfullname = buildweaponname(var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimaryvariantid, self getentitynumber(), self.clientid, var_0.func_AE8B, var_0.loadoutprimarycosmeticattachment);

  if(var_0.loadoutsecondary == "none")
    var_0.loadoutsecondaryfullname = "none";
  else
    var_0.loadoutsecondaryfullname = buildweaponname(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.func_AEA5, self getentitynumber(), self.clientid, var_0.func_AE9F, var_0.loadoutsecondarycosmeticattachment);
}

loadout_updateplayerweapons(var_00, var_01, var_02) {
  if(getdvarint("scr_require_loot", 0) == 1 && !scripts\mp\utility\game::istrue(self.func_54BC)) {
    if(var_0.loadoutprimarylootitemid == 0 && var_0.func_AE9E == 0) {
      iprintlnbold(self.name + " is not using a loot weapon!");
      self.func_54BC = 1;
    }
  }

  if(var_01 == "rc8Agent") {
    return;
  }
  loadout_updateclassfinalweapons(var_00);
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
  self.func_AE9E = var_0.func_AE9E;
  self.func_AEA5 = var_0.func_AEA5;
  var_03 = scripts\mp\weapons::updatesavedaltstate(var_0.loadoutprimaryfullname);
  scripts\mp\utility\game::_giveweapon(var_03, undefined, undefined, getweaponbasename(var_03) == "iw7_fists_mp");
  scripts\mp\weapons::updatetogglescopestate(var_0.loadoutprimaryfullname);
  scripts\mp\perks\weaponpassives::loadoutweapongiven(var_0.loadoutprimaryfullname);
  var_04 = "none";

  if(var_0.loadoutsecondary != "none") {
    var_04 = scripts\mp\weapons::updatesavedaltstate(var_0.loadoutsecondaryfullname);
    scripts\mp\utility\game::_giveweapon(var_04, undefined, undefined, 1);
    scripts\mp\weapons::updatetogglescopestate(var_0.loadoutsecondaryfullname);

    if(scripts\mp\utility\game::getweaponrootname(var_04) == "iw7_axe")
      self setweaponammoclip(var_04, 1);

    scripts\mp\perks\weaponpassives::loadoutweapongiven(var_0.loadoutsecondaryfullname);
  }

  var_05 = var_03;

  if(var_04 != "none" && getweaponbasename(var_05) == "iw7_fists_mp")
    var_05 = var_04;

  if(!isai(self)) {
    self.saved_lastweaponhack = undefined;
    scripts\mp\utility\game::_switchtoweapon(var_05);
  }

  if(!isDefined(var_02) || var_02) {
    var_06 = !scripts\mp\utility\game::gameflag("prematch_done") && !scripts\mp\weapons::isaltmodeweapon(var_05);
    self setspawnweapon(var_05, var_06);
  }

  self.primaryweapon = var_0.loadoutprimaryfullname;
  self.secondaryweapon = var_0.loadoutsecondaryfullname;
  self.spawnweaponobj = var_05;
  self.pers["primaryWeapon"] = var_0.loadoutprimaryfullname;
  self.pers["secondaryWeapon"] = var_0.loadoutsecondaryfullname;
  scripts\mp\teams::func_FADC();
  scripts\mp\weapons::updatemovespeedscale();
  thread scripts\mp\weapons::func_13BA9();
}

loadout_updateplayerperks(var_00) {
  scripts\mp\utility\game::giveperk("specialty_marathon");
  scripts\mp\utility\game::giveperk("specialty_sharp_focus");
  scripts\mp\utility\game::giveperk("specialty_silentdoublejump");

  if(var_0.loadoutperks.size > 0)
    scripts\mp\perks::giveperks(var_0.loadoutperks, 0);

  self.pers["loadoutPerks"] = var_0.loadoutperks;
  self.pers["loadoutStandardPerks"] = var_0.loadoutstandardperks;
  self.pers["loadoutExtraPerks"] = var_0.loadoutextraperks;
  self.pers["loadoutRigTrait"] = var_0.loadoutrigtrait;
  self setclientomnvar("ui_trait_ref", scripts\mp\perks::getequipmenttableinfo(self.pers["loadoutRigTrait"]));

  if(!scripts\mp\utility\game::isjuggernaut() && isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0)
    thread scripts\mp\perks::giveperksafterspawn();
}

loadout_updateplayerpowers_MAYBE(var_00) {
  self.powers = [];
  self.func_AE7B = var_0.func_AE7B;
  self.func_AE7D = var_0.func_AE7D;
  scripts\mp\powers::givepower(var_0.func_AE7B, "primary", 0, var_0.func_AE7C, var_0.loadoutextrapowerprimary);
  scripts\mp\powers::givepower(var_0.func_AE7D, "secondary", 0, var_0.func_AE7E, var_0.loadoutextrapowersecondary);
}

loadout_updateplayersuper(var_00) {
  var_01 = var_0.loadoutsuper;

  if(isbot(self) && level.allowsupers) {
    if(isDefined(self.loadoutsuper))
      var_01 = self.loadoutsuper;
    else
      var_01 = scripts\mp\bots\bots_supers::func_2EE9();

    var_0.loadoutsuper = var_01;

    if(isDefined(self.loadoutrigtrait))
      var_02 = self.loadoutrigtrait;
    else if(isDefined(var_0.loadoutrigtrait) && self.class == "gamemode")
      var_02 = var_0.loadoutrigtrait;
    else
      var_02 = scripts\mp\bots\bots_supers::botpicktrait();

    var_0.loadoutrigtrait = var_02;
    self.pers["loadoutRigTrait"] = var_02;

    if(var_02 != "specialty_null") {
      scripts\mp\utility\game::giveperk(var_02);
      self setclientomnvar("ui_trait_ref", scripts\mp\perks::getequipmenttableinfo(self.pers["loadoutRigTrait"]));
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
  } else if(level.allowsupers && isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["loadoutSuper"])) {
    self.loadoutsuper = self.pers["gamemodeLoadout"]["loadoutSuper"];
    scripts\mp\supers::stopridingvehicle(self.loadoutsuper, 1);
  } else {
    self.loadoutsuper = var_01;
    scripts\mp\supers::stopridingvehicle(var_01, 1);
  }
}

loadout_updateplayergesture(var_00) {
  if(!scripts\engine\utility::is_true(self.btestclient)) {
    if(var_0.loadoutgesture != "none") {
      self.loadoutgesture = var_0.loadoutgesture;
      scripts\mp\gestures::givegesture(var_0.loadoutgesture);
    }
  }
}

loadout_updateplayerstreaktype(var_00) {
  self.streaktype = loadout_getplayerstreaktype(var_0.loadoutstreaktype);
}

loadout_updateplayerkillstreaks(var_00, var_01) {
  if(!level.allowkillstreaks) {
    var_0.loadoutkillstreak1 = "none";
    var_0.loadoutkillstreak2 = "none";
    var_0.loadoutkillstreak3 = "none";
  }

  self.streakvariantids = [];
  self.streakvariantids[var_0.loadoutkillstreak1] = var_0.loadoutkillstreak1variantid;
  self.streakvariantids[var_0.loadoutkillstreak2] = var_0.loadoutkillstreak2variantid;
  self.streakvariantids[var_0.loadoutkillstreak3] = var_0.loadoutkillstreak3variantid;

  if(var_0.loadoutstreaksfilled == 0 && isDefined(self.func_A6AB) && self.func_A6AB.size > 0 && (var_01 == "gamemode" || issubstr(var_01, "juggernaut"))) {
    var_02 = 0;

    foreach(var_04 in self.func_A6AB) {
      if(var_02 == 0) {
        var_0.loadoutkillstreak1 = var_04;
        var_2++;
        continue;
      }

      if(var_02 == 1) {
        var_0.loadoutkillstreak2 = var_04;
        var_2++;
        continue;
      }

      if(var_02 == 2) {
        var_0.loadoutkillstreak3 = var_04;
        break;
      }
    }
  }

  level.sortedkillstreaksbycost = getsortedkillstreaksbycost(var_00);
  var_0.loadoutkillstreak1 = level.sortedkillstreaksbycost[0];
  var_0.loadoutkillstreak2 = level.sortedkillstreaksbycost[1];
  var_0.loadoutkillstreak3 = level.sortedkillstreaksbycost[2];

  if(var_01 == "gamemode" && self.streaktype == "specialist") {
    self.pers["gamemodeLoadout"]["loadoutKillstreak1"] = var_0.loadoutkillstreak1;
    self.pers["gamemodeLoadout"]["loadoutKillstreak2"] = var_0.loadoutkillstreak2;
    self.pers["gamemodeLoadout"]["loadoutKillstreak3"] = var_0.loadoutkillstreak3;
  }

  func_F775(var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3);
  var_06 = 0;

  if(!isagent(self))
    var_06 = scripts\mp\killstreaks\killstreaks::func_213F([var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3]);

  if(!isagent(self) && !var_06) {
    self notify("givingLoadout");
    var_07 = scripts\mp\killstreaks\killstreaks::func_7ED6();
    var_08 = scripts\mp\killstreaks\killstreaks::func_7DE7();

    if(!scripts\mp\utility\game::_hasperk("specialty_support_killstreaks") && !isDefined(self.func_5FBD))
      scripts\mp\killstreaks\killstreaks::func_41C0();

    if(isDefined(var_0.loadoutkillstreak1) && var_0.loadoutkillstreak1 != "none" && var_0.loadoutkillstreak1 != "")
      scripts\mp\killstreaks\killstreaks::func_66B9(var_0.loadoutkillstreak1, var_0.func_AE6F, var_0.loadoutkillstreak1variantid);

    if(isDefined(var_0.loadoutkillstreak2) && var_0.loadoutkillstreak2 != "none" && var_0.loadoutkillstreak2 != "")
      scripts\mp\killstreaks\killstreaks::func_66BB(var_0.loadoutkillstreak2, var_0.func_AE71, var_0.loadoutkillstreak2variantid);

    if(isDefined(var_0.loadoutkillstreak3) && var_0.loadoutkillstreak3 != "none" && var_0.loadoutkillstreak3 != "")
      scripts\mp\killstreaks\killstreaks::func_66BA(var_0.loadoutkillstreak3, var_0.func_AE73, var_0.loadoutkillstreak3variantid);

    for(var_09 = var_7.size - 1; var_09 >= 0; var_9--)
      scripts\mp\killstreaks\killstreaks::func_26D5(var_7[var_09]);

    for(var_09 = 0; var_09 < var_8.size; var_9++)
      scripts\mp\killstreaks\killstreaks::func_26D5(var_8[var_09]);
  }

  self notify("equipKillstreaksFinished");
}

getsortedkillstreaksbycost(var_00) {
  var_01 = [var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3];

  for(var_02 = 0; var_02 < var_1.size - 1; var_2++) {
    if(isDefined(var_1[var_02]) && var_1[var_02] != "none" && var_1[var_02] != "") {
      for(var_03 = var_02 + 1; var_03 < var_1.size; var_3++) {
        if(isDefined(var_1[var_03]) && var_1[var_03] != "none" && var_1[var_03] != "") {
          var_04 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_1[var_02]);
          var_05 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_1[var_03]);

          if(var_05 < var_04) {
            var_06 = var_1[var_03];
            var_1[var_03] = var_1[var_02];
            var_1[var_02] = var_06;
          }
        }
      }
    }
  }

  return var_01;
}

loadout_updateplayer(var_00, var_01, var_02) {
  loadout_updateplayerstreaktype(var_00);
  loadout_updateplayerarchetype(var_00);
  loadout_updateplayerweapons(var_00, var_01, var_02);
  loadout_updateplayerperks(var_00);
  loadout_updateplayerpowers_MAYBE(var_00);
  loadout_updateplayersuper(var_00);
  loadout_updateplayergesture(var_00);
  loadout_updateplayerkillstreaks(var_00, var_01);
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

setmlgspectatorclientloadoutdata(var_00, var_01) {
  var_00 endon("disconnect");
  var_00 notify("setMLGSpectatorClientLoadoutData()");
  var_00 endon("setMLGSpectatorClientLoadoutData()");
  var_00 setclientweaponinfo(0, var_1.loadoutprimaryfullname);
  var_00 setclientweaponinfo(1, var_1.loadoutsecondaryfullname);
  var_02 = scripts\mp\powers::func_D738(var_1.func_AE7B);
  var_00 getrandomindex("primaryPower", var_02);
  var_03 = scripts\mp\powers::func_D738(var_1.func_AE7D);
  var_00 getrandomindex("secondaryPower", var_03);
  var_04 = scripts\mp\supers::_meth_8186(var_1.loadoutsuper);
  var_00 getrandomindex("super", var_04);

  if(isai(var_00)) {
    for(var_05 = 0; var_05 < var_1.loadoutperks.size; var_5++) {
      var_06 = var_1.loadoutperks[var_05];
      var_07 = scripts\mp\perks::getequipmenttableinfo(var_06);
      var_00 getrandomindex(var_05 + 1 + "_perk", var_07);
    }
  } else {
    if(var_1.loadoutperksfromgamemode)
      var_1.loadoutstandardperks = var_1.loadoutperks;

    for(var_05 = 0; var_05 < var_1.loadoutstandardperks.size; var_5++) {
      var_06 = var_1.loadoutstandardperks[var_05];
      var_07 = scripts\mp\perks::getequipmenttableinfo(var_06);
      var_00 getrandomindex(var_05 + 1 + "_perk", var_07);
    }

    for(var_05 = 0; var_05 < var_1.loadoutextraperks.size; var_5++) {
      var_06 = var_1.loadoutextraperks[var_05];
      var_07 = scripts\mp\perks::getequipmenttableinfo(var_06);
      var_00 getrandomindex(var_05 + 1 + "_extraPerk", var_07);
    }
  }

  var_08 = var_1.loadoutrigtrait;
  var_09 = scripts\mp\perks::getequipmenttableinfo(var_08);
  var_00 getrandomindex("rigTrait", var_09);
  var_10 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(var_1.loadoutarchetype);
  var_00 getrandomindex("archetype", var_10);
  var_00 setclientextrasuper(0, var_1.loadoutextrapowerprimary);
  var_00 setclientextrasuper(1, var_1.loadoutextrapowersecondary);
}

shouldallowinstantclassswap() {
  return level.ingraceperiod && level._meth_8487 - level.ingraceperiod >= 0 && level._meth_8487 - level.ingraceperiod < 5 && !self.hasdonecombat;
}

giveloadoutswap() {
  setclass(self.pers["class"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  scripts\mp\weapons::recordtogglescopestates();
  scripts\mp\weapons::func_DDF6();
  giveloadout(self.pers["team"], self.pers["class"]);

  if(!scripts\mp\utility\game::gameflag("prematch_done"))
    scripts\mp\playerlogic::allowprematchlook(self);
}

giveloadout(var_00, var_01, var_02) {
  self notify("giveLoadout_start");
  self.gettingloadout = 1;

  if(isDefined(self.perks))
    self.oldperks = self.perks;

  loadout_clearweapons();
  var_03 = undefined;

  if(scripts\engine\utility::is_true(self.classset)) {
    var_03 = self.classstruct;
    self.classset = undefined;
  } else {
    var_03 = loadout_getclassstruct();
    var_03 = loadout_updateclass(var_03, var_01);
    self.classstruct = var_03;
  }

  loadout_giveextraweapons(var_03);
  loadout_updateplayer(var_03, var_01, var_02);
  func_AE38(var_03, var_01);
  self.gettingloadout = 0;
  self notify("changed_kit");
  self notify("giveLoadout");
}

loadout_giveextraweapons(var_00) {}

func_AE38(var_00, var_01) {
  if(!isplayer(self) && !isalive(self)) {
    return;
  }
  if(getdvarint("com_codcasterEnabled", 0) == 1)
    thread setmlgspectatorclientloadoutdata(self, var_00);

  var_02 = scripts\mp\utility\game::getclassindex(var_01);
  var_03 = var_02;
  var_04 = getsubstr(var_01, 0, 7) == "default";

  if(var_04)
    var_03 = var_03 + 20;

  var_05 = 10;
  var_06 = -1;

  for(var_07 = 0; var_07 < var_05; var_7++) {
    var_08 = _getmatchdata("players", self.clientid, "loadouts", var_07, "slotUsed");

    if(var_08) {
      var_09 = _getmatchdata("players", self.clientid, "loadouts", var_07, "classIndex");

      if(var_09 == var_03) {
        var_06 = var_07;
        break;
      }
    } else {
      var_06 = var_07;
      setmatchdata("players", self.clientid, "loadouts", var_07, "slotUsed", 1);
      setmatchdata("players", self.clientid, "loadouts", var_07, "classIndex", var_03);
      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "weapon", var_0.loadoutprimary);

      for(var_10 = 0; var_10 < 6; var_10++)
        setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "attachment", var_10, var_0.loadoutprimaryattachments[var_10]);

      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "camo", var_0.loadoutprimarycamo);
      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "reticle", var_0.loadoutprimaryreticle);
      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "lootItemID", var_0.loadoutprimarylootitemid);
      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "variantID", var_0.loadoutprimaryvariantid);
      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "paintJobID", var_0.func_AE8B);
      setmatchdata("players", self.clientid, "loadouts", var_07, "primaryWeaponSetup", "cosmeticAttachment", var_0.loadoutprimarycosmeticattachment);
      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "weapon", var_0.loadoutsecondary);

      for(var_10 = 0; var_10 < 5; var_10++)
        setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "attachment", var_10, var_0.loadoutsecondaryattachments[var_10]);

      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "camo", var_0.loadoutsecondarycamo);
      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "reticle", var_0.loadoutsecondaryreticle);
      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "lootItemID", var_0.func_AE9E);
      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "variantID", var_0.func_AEA5);
      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "paintJobID", var_0.func_AE9F);
      setmatchdata("players", self.clientid, "loadouts", var_07, "secondaryWeaponSetup", "cosmeticAttachment", var_0.loadoutsecondarycosmeticattachment);
      setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 0, "power", var_0.func_AE7B);
      setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 0, "extraCharge", cac_getextracharge(var_02));
      setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 1, "power", var_0.func_AE7D);
      setmatchdata("players", self.clientid, "loadouts", var_07, "powerSetups", 1, "extraCharge", cac_getextracharge2(var_02));
      var_11 = var_0.loadoutstandardperks.size;

      if(var_11 > 3)
        var_11 = 3;

      for(var_12 = 0; var_12 < var_11; var_12++)
        setmatchdata("players", self.clientid, "loadouts", var_07, "loadoutPerks", var_12, var_0.loadoutstandardperks[var_12]);

      var_13 = var_0.loadoutextraperks.size;

      if(var_13 > 3)
        var_13 = 3;

      for(var_12 = 0; var_12 < var_13; var_12++)
        setmatchdata("players", self.clientid, "loadouts", var_07, "extraPerks", var_12, var_0.loadoutextraperks[var_12]);

      setmatchdata("players", self.clientid, "killstreaks", 0, var_0.loadoutkillstreak1);
      setmatchdata("players", self.clientid, "killstreaks", 1, var_0.loadoutkillstreak2);
      setmatchdata("players", self.clientid, "killstreaks", 2, var_0.loadoutkillstreak3);

      if(var_06 == 0) {
        self _meth_859B(self.clientid, self.headmodel, self.model);

        if(isDefined(self.loadoutgesture))
          self _meth_85AB(self.clientid, self.loadoutgesture);
      }

      break;
    }
  }

  if(isDefined(self.matchdatalifeindex) && scripts\mp\matchdata::canloglife(self.matchdatalifeindex)) {
    if(isDefined(var_0.loadoutarchetype))
      setmatchdata("lives", self.matchdatalifeindex, "archetype", var_0.loadoutarchetype);

    if(isDefined(var_0.loadoutrigtrait) && var_0.loadoutrigtrait != "specialty_null") {
      setmatchdata("lives", self.matchdatalifeindex, "trait", var_0.loadoutrigtrait);
      self.lastmatchdatarigtrait = var_0.loadoutrigtrait;
    } else if(isDefined(self.lastmatchdatarigtrait))
      setmatchdata("lives", self.matchdatalifeindex, "trait", self.lastmatchdatarigtrait);

    if(isDefined(var_0.loadoutsuper))
      setmatchdata("lives", self.matchdatalifeindex, "super", var_0.loadoutsuper);

    setmatchdata("lives", self.matchdatalifeindex, "loadoutIndex", var_06);
  }

  self.func_AE6D = var_06;
}

hasvalidationinfraction() {
  return isDefined(self.pers) && isDefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

recordvalidationinfraction() {
  if(isDefined(self.pers) && isDefined(self.pers["validationInfractions"]))
    self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
}

_detachall() {
  self.headmodel = undefined;

  if(isDefined(self.riotshieldmodel))
    scripts\mp\utility\game::riotshield_detach(1);

  if(isDefined(self.riotshieldmodelstowed))
    scripts\mp\utility\game::riotshield_detach(0);

  self.hasriotshieldequipped = 0;
  self detachall();
}

func_9EE1(var_00) {
  var_01 = tablelookup("mp\perktable.csv", 1, var_00, 8);

  if(var_01 == "" || var_01 == "specialty_null")
    return 0;

  if(!self getteamdompoints(var_01, "perk"))
    return 0;

  return 1;
}

canplayerplacesentry(var_00) {
  var_01 = tablelookup("mp\perktable.csv", 1, var_00, 8);

  if(var_01 == "" || var_01 == "specialty_null")
    return "specialty_null";

  if(!self getteamdompoints(var_01, "perk"))
    return "specialty_null";

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
    scripts\mp\utility\game::riotshield_move(1);
    self waittill("offhand_end");

    if(scripts\mp\weapons::isriotshield(self getcurrentweapon()) && isDefined(self.riotshieldmodelstowed))
      scripts\mp\utility\game::riotshield_move(0);
  }
}

func_11B04() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.hasriotshield = scripts\mp\utility\game::riotshield_hasweapon();
  self.hasriotshieldequipped = scripts\mp\weapons::isriotshield(self.currentweaponatspawn);

  if(self.hasriotshield) {
    if(self.hasriotshieldequipped)
      scripts\mp\utility\game::riotshield_attach(1, scripts\mp\utility\game::riotshield_getmodel());
    else
      scripts\mp\utility\game::riotshield_attach(0, scripts\mp\utility\game::riotshield_getmodel());
  }

  thread trackriotshield_ontrophystow();

  for(;;) {
    self waittill("weapon_change", var_00);

    if(var_00 == "none") {
      continue;
    }
    var_01 = scripts\mp\weapons::isriotshield(var_00);
    var_02 = !var_01 && scripts\mp\utility\game::riotshield_hasweapon();

    if(var_01) {
      if(!isDefined(self.riotshieldmodel)) {
        if(isDefined(self.riotshieldmodelstowed))
          scripts\mp\utility\game::riotshield_move(0);
        else
          scripts\mp\utility\game::riotshield_attach(1, scripts\mp\utility\game::riotshield_getmodel());
      }
    } else if(var_02) {
      if(!isDefined(self.riotshieldmodelstowed)) {
        if(isDefined(self.riotshieldmodel))
          scripts\mp\utility\game::riotshield_move(1);
        else
          scripts\mp\utility\game::riotshield_attach(0, scripts\mp\utility\game::riotshield_getmodel());
      }
    } else {
      if(isDefined(self.riotshieldmodel))
        scripts\mp\utility\game::riotshield_detach(1);

      if(isDefined(self.riotshieldmodelstowed))
        scripts\mp\utility\game::riotshield_detach(0);
    }

    self.hasriotshield = var_01 || var_02;
    self.hasriotshieldequipped = var_01;
  }
}

updateattachmentsformlg(var_00) {
  var_01 = [];

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_03 = var_0[var_02];

    if(var_03 == "ripperrscope_camo")
      var_03 = "ripperrscope_na_camo";
    else if(var_03 == "m8scope_camo")
      var_03 = "m8scope_na_camo";
    else if(var_03 == "arripper" || var_03 == "arm8" || var_03 == "akimbofmg" || var_03 == "glarclassic" || var_03 == "glmp28" || var_03 == "shotgunlongshot" || var_03 == "glsmoke" || var_03 == "glsmoke_slow" || var_03 == "gltacburst" || var_03 == "gltacburst_big") {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

ismark2weapon(var_00) {
  if(!isDefined(var_00))
    return 0;

  return var_00 >= 32;
}

isholidayweapon(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return 0;

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_00), var_01);
  return var_02 == "weapon_iw7_ripper_common_3" || var_02 == "weapon_iw7_lmg03_rare_3" || var_02 == "weapon_iw7_ar57_legendary_3";
}

isholidayweaponusingdefaultscope(var_00, var_01) {
  var_02 = scripts\mp\utility\game::attachmentmap_tounique("scope", getweaponbasename(var_00));
  return isDefined(var_02) && scripts\engine\utility::array_contains(var_01, var_02);
}

issummerholidayweapon(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return 0;

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_00), var_01);
  return var_02 == "weapon_iw7_erad_legendary_4" || var_02 == "weapon_iw7_ake_epic_4" || var_02 == "weapon_iw7_sdflmg_legendary_4" || var_02 == "weapon_iw7_mod2187_legendary_3" || var_02 == "weapon_iw7_longshot_legendary_3";
}

ishalloweenholidayweapon(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return 0;

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_00), var_01);
  return var_02 == "weapon_iw7_kbs_rare_3" || var_02 == "weapon_iw7_ripper_rare_3" || var_02 == "weapon_iw7_m4_rare_3" || var_02 == "weapon_iw7_mod2187_legendary_5" || var_02 == "weapon_iw7_mag_rare_3" || var_02 == "weapon_iw7_minilmg_epic_3";
}

hasscope(var_00) {
  foreach(var_02 in var_00) {
    if(scripts\mp\utility\game::getattachmenttype(var_02) == "rail")
      return 1;
  }

  return 0;
}

buildweaponname(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_01 = scripts\mp\utility\game::weaponattachremoveextraattachments(var_01);
  var_01 = scripts\engine\utility::array_remove(var_01, "none");
  var_09 = scripts\mp\utility\game::weaponattachdefaultmap(var_00);
  var_10 = buildweaponassetname(var_00, var_04);

  if(isDefined(self.gettingloadout) && self.gettingloadout) {
    var_11 = getrandomweaponattachments(var_10, var_04, var_01);

    if(var_11.size > 0) {
      var_01 = scripts\engine\utility::array_combine_unique(var_01, var_11);

      foreach(var_13 in var_11)
      scripts\mp\perks\weaponpassives::checkpassivemessage("passive_random_attachments", "_" + scripts\mp\utility\game::attachmentmap_tounique(var_13, var_10));
    }
  }

  for(var_15 = 0; var_15 < var_1.size; var_15++)
    var_1[var_15] = ::scripts\mp\utility\game::attachmentmap_tounique(var_1[var_15], var_10);

  if(isDefined(var_09)) {
    for(var_15 = 0; var_15 < var_9.size; var_15++)
      var_9[var_15] = ::scripts\mp\utility\game::attachmentmap_tounique(var_9[var_15], var_10);
  }

  if(isDefined(var_09))
    var_01 = scripts\engine\utility::array_combine_unique(var_01, var_09);

  if(isDefined(var_04)) {
    var_16 = getweaponvariantattachments(var_10, var_04);

    if(var_16.size > 0)
      var_01 = scripts\engine\utility::array_combine_unique(var_01, var_16);
  }

  if(isDefined(var_08) && var_08 != "none")
    var_1[var_1.size] = var_08;

  if(var_1.size > 0)
    var_01 = filterattachments(var_01);

  var_17 = [];

  foreach(var_19 in var_01) {
    var_20 = scripts\mp\utility\game::attachmentmap_toextra(var_19);

    if(isDefined(var_20))
      var_17[var_17.size] = ::scripts\mp\utility\game::attachmentmap_tounique(var_20, var_10);
  }

  if(var_17.size > 0)
    var_01 = scripts\engine\utility::array_combine_unique(var_01, var_17);

  if(scripts\mp\utility\game::isanymlgmatch())
    var_01 = updateattachmentsformlg(var_01);

  if(var_1.size > 0)
    var_01 = scripts\engine\utility::alphabetize(var_01);

  foreach(var_23 in var_01)
  var_10 = var_10 + ("+" + var_23);

  if(issubstr(var_10, "iw7")) {
    var_10 = buildweaponnamecamo(var_10, var_02, var_04);
    var_25 = 0;

    if(isholidayweapon(var_10, var_04) || issummerholidayweapon(var_10, var_04) || ishalloweenholidayweapon(var_10, var_04))
      var_25 = isholidayweaponusingdefaultscope(var_10, var_01);

    if(hasscope(var_01)) {
      if(var_25 && !issubstr(var_10, "iw7_longshot")) {
        if(ishalloweenholidayweapon(var_10, var_04))
          var_10 = var_10 + ("+scope" + gethalloweenscopenumber(var_10, var_04));
        else
          var_10 = var_10 + "+scope1";
      } else
        var_10 = buildweaponnamereticle(var_10, var_03);
    }

    var_10 = buildweaponnamevariantid(var_10, var_04);
  }

  return var_10;
}

gethalloweenscopenumber(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return 0;

  var_02 = scripts\mp\loot::lookupvariantref(scripts\mp\utility\game::getweaponrootname(var_00), var_01);
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

getrandomweaponattachments(var_00, var_01, var_02) {
  var_03 = [];

  if(weaponhaspassive(var_00, var_01, "passive_random_attachments")) {
    if(1) {
      var_04 = getavailableattachments(var_00, var_02, 0);
      var_3[var_3.size] = var_4[randomint(var_4.size)];
    } else {
      var_05 = randomintrange(1, 2);
      var_03 = buildrandomattachmentarray(var_00, var_05, var_02);
    }
  }

  return var_03;
}

func_11754(var_00, var_01) {
  var_02 = getavailableattachments(var_00, [], 0);

  foreach(var_04 in var_02)
  scripts\mp\perks\weaponpassives::testpassivemessage("passive_random_attachments", "_" + scripts\mp\utility\game::attachmentmap_tounique(var_04, var_00));
}

buildrandomattachmentarray(var_00, var_01, var_02) {
  var_03 = [];
  var_04 = getattachmenttypeslist(var_00, var_02);

  if(var_4.size > 0) {
    var_03 = [];
    var_05 = scripts\engine\utility::array_randomize_objects(var_04);

    foreach(var_10, var_07 in var_05) {
      if(var_01 <= 0) {
        break;
      }
      var_08 = 1;

      switch (var_10) {
        case "undermount":
        case "barrel":
          var_08 = 1;
          break;
        case "rail":
          var_08 = 0;
          break;
        default:
          var_08 = randomintrange(1, var_01 + 1);
          break;
      }

      if(var_08 > 0) {
        if(var_08 > var_7.size)
          var_08 = var_7.size;

        var_01 = var_01 - var_08;

        for(var_07 = scripts\engine\utility::array_randomize_objects(var_07); var_08 > 0; var_8--) {
          var_09 = var_7[var_7.size - var_08];
          var_3[var_3.size] = var_09;
        }
      }
    }
  }

  return var_03;
}

getattachmenttypeslist(var_00, var_01) {
  var_02 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_00);
  var_03 = [];

  foreach(var_05 in var_02) {
    var_06 = scripts\mp\utility\game::getattachmenttype(var_05);

    if(listhasattachment(var_01, var_05)) {
      continue;
    }
    if(!isDefined(var_3[var_06]))
      var_3[var_06] = [];

    var_07 = var_3[var_06];
    var_7[var_7.size] = var_05;
    var_3[var_06] = var_07;
  }

  return var_03;
}

getavailableattachments(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 1;

  var_03 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_00);
  var_04 = [];

  foreach(var_06 in var_03) {
    var_07 = scripts\mp\utility\game::getattachmenttype(var_06);

    if(!var_02 && var_07 == "rail") {
      continue;
    }
    if(listhasattachment(var_01, var_06)) {
      continue;
    }
    var_4[var_4.size] = var_06;
  }

  return var_04;
}

listhasattachment(var_00, var_01) {
  foreach(var_03 in var_00) {
    if(var_03 == var_01)
      return 1;
  }

  return 0;
}

getrandomarmkillstreak(var_00, var_01) {
  var_02 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_00);
  return dontcastdistantshadows(var_02, var_01);
}

dontcastshadows(var_00, var_01, var_02) {
  var_03 = scripts\mp\utility\game::getweaponbarsize(var_00, var_01);
  return dontcastdistantshadows(var_03, var_02);
}

dontcastdistantshadows(var_00, var_01) {
  if(var_0.size > 0) {
    var_00 = scripts\engine\utility::array_randomize(var_00);

    if(var_01 > var_0.size)
      var_01 = var_0.size;

    for(var_02 = []; var_01 > 0 && var_0.size > 0; var_1--) {
      var_03 = var_0[var_0.size - var_01];
      var_2[var_2.size] = var_03;
    }

    if(var_2.size > 0)
      return var_02;
  }

  return var_00;
}

filterattachments(var_00) {
  var_01 = [];

  if(isDefined(var_00)) {
    foreach(var_03 in var_00) {
      if(var_03 == "none") {
        continue;
      }
      var_04 = 1;

      foreach(var_06 in var_01) {
        if(var_03 == var_06) {
          var_04 = 0;
          break;
        }

        if(!scripts\mp\utility\game::attachmentscompatible(var_03, var_06)) {
          var_04 = 0;
          break;
        }
      }

      if(var_04)
        var_1[var_1.size] = var_03;
    }
  }

  return var_01;
}

buildweaponassetname(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return scripts\mp\utility\game::func_13C75(var_00);
  else {
    var_02 = scripts\mp\loot::getweaponassetfromrootweapon(var_00, var_01);
    return var_02;
  }
}

buildweaponnamecamo(var_00, var_01, var_02) {
  var_03 = -1;

  if(isholidayweapon(var_00, var_02)) {
    var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo89", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return var_00 + "+camo" + var_03;
  } else if(issummerholidayweapon(var_00, var_02)) {
    var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo230", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return var_00 + "+camo" + var_03;
  } else if(ishalloweenholidayweapon(var_00, var_02)) {
    var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo242", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    return var_00 + "+camo" + var_03;
  } else if((!isDefined(var_01) || var_01 == "none") && ismark2weapon(var_02)) {
    var_04 = scripts\mp\loot::getweaponqualitybyid(var_00, var_02);
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
    return var_00 + "+camo" + var_03;
  }

  if(!isDefined(var_01))
    var_03 = 0;
  else
    var_03 = int(tablelookup("mp\camoTable.csv", 1, var_01, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));

  if(var_03 <= 0) {
    var_04 = scripts\mp\loot::getweaponqualitybyid(var_00, var_02);
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

    if(isDefined(var_05))
      var_03 = int(tablelookup("mp\camoTable.csv", 1, var_05, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    else
      return var_00;
  }

  return var_00 + "+camo" + var_03;
}

buildweaponnamereticle(var_00, var_01) {
  if(!isDefined(var_01))
    return var_00;

  var_02 = int(tablelookup("mp\reticleTable.csv", 1, var_01, 5));

  if(!isDefined(var_02) || var_02 == 0)
    return var_00;

  var_00 = var_00 + ("+scope" + var_02);
  return var_00;
}

buildweaponnamevariantid(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return var_00;

  var_00 = var_00 + ("+loot" + var_01);
  return var_00;
}

getweaponpassives(var_00, var_01) {
  return scripts\mp\loot::getpassivesforweapon(buildweaponnamevariantid(var_00, var_01));
}

weaponhaspassive(var_00, var_01, var_02) {
  var_03 = getweaponpassives(var_00, var_01);

  if(!isDefined(var_03) || var_3.size <= 0)
    return 0;

  foreach(var_05 in var_03) {
    if(var_02 == var_05)
      return 1;
  }

  return 0;
}

getweaponvariantattachments(var_00, var_01) {
  var_02 = [];
  var_03 = getweaponpassives(var_00, var_01);

  if(isDefined(var_03)) {
    foreach(var_05 in var_03) {
      var_06 = scripts\mp\passives::getpassiveattachment(var_05);

      if(!isDefined(var_06)) {
        continue;
      }
      var_2[var_2.size] = var_06;
    }
  }

  return var_02;
}

func_F775(var_00, var_01, var_02) {
  self.func_A6AB = [];
  var_03 = [];

  if(isDefined(var_00) && var_00 != "none") {
    var_04 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_00);
    var_3[var_04] = var_00;
  }

  if(isDefined(var_01) && var_01 != "none") {
    var_04 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_01);
    var_3[var_04] = var_01;
  }

  if(isDefined(var_02) && var_02 != "none") {
    var_04 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_02);
    var_3[var_04] = var_02;
  }

  var_05 = 0;

  foreach(var_04, var_07 in var_03) {
    if(var_04 > var_05)
      var_05 = var_04;
  }

  for(var_08 = 0; var_08 <= var_05; var_8++) {
    if(!isDefined(var_3[var_08])) {
      continue;
    }
    var_07 = var_3[var_08];
    self.func_A6AB[var_08] = var_3[var_08];
  }
}

func_E19F() {
  var_00 = self.pers["team"];
  var_01 = self.pers["class"];
  var_02 = self getweaponslistall();

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03];
    self givemaxammo(var_04);
    self setweaponammoclip(var_04, 9999);

    if(var_04 == "claymore_mp" || var_04 == "claymore_detonator_mp")
      self setweaponammostock(var_04, 2);
  }

  if(self getammocount(level.classgrenades[var_01]["primary"]["type"]) < level.classgrenades[var_01]["primary"]["count"])
    self setweaponammoclip(level.classgrenades[var_01]["primary"]["type"], level.classgrenades[var_01]["primary"]["count"]);

  if(self getammocount(level.classgrenades[var_01]["secondary"]["type"]) < level.classgrenades[var_01]["secondary"]["count"])
    self setweaponammoclip(level.classgrenades[var_01]["secondary"]["type"], level.classgrenades[var_01]["secondary"]["count"]);
}

onplayerconnecting() {
  for(;;) {
    level waittill("connected", var_00);

    if(!isDefined(var_0.pers["class"]))
      var_0.pers["class"] = "";

    if(!isDefined(var_0.pers["lastClass"]))
      var_0.pers["lastClass"] = "";

    var_0.class = var_0.pers["class"];
    var_0.lastclass = var_0.pers["lastClass"];
    var_0.func_53AD = 0;
    var_0.func_2C66 = [];
    var_0.func_2C67 = [];
    var_0.changedarchetypeinfo = var_0.pers["changedArchetypeInfo"];
    var_0.lastarchetypeinfo = undefined;

    if(!isai(var_00) && !scripts\engine\utility::is_true(var_0.btestclient)) {
      var_00 setclientomnvar("ui_selected_archetype", level.archetypeids[var_00 cac_getcharacterarchetype()]);
      var_00 setclientomnvar("ui_selected_super", scripts\mp\supers::_meth_8186(var_00 cac_getsuper()));
      var_00 setclientomnvar("ui_selected_trait", scripts\mp\perks::getequipmenttableinfo(var_00 cac_getloadoutarchetypeperk()));
    }

    if(!isDefined(var_0.pers["validationInfractions"]))
      var_0.pers["validationInfractions"] = 0;
  }
}

fadeaway(var_00, var_01) {
  wait(var_00);
  self fadeovertime(var_01);
  self.alpha = 0;
}

setclass(var_00) {
  self.curclass = var_00;
}

iskillstreak(var_00) {
  return scripts\mp\utility\game::getkillstreakindex(var_00) != -1;
}

haschangedclass() {
  if(isDefined(self.lastclass) && self.lastclass != self.class || !isDefined(self.lastclass))
    return 1;

  if(level.gametype == "infect" && (!isDefined(self.last_infected_class) || self.last_infected_class != self.infected_class))
    return 1;

  return 0;
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo))
      return 1;

    if(self.changedarchetypeinfo != self.lastarchetypeinfo)
      return 1;
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
  self.func_8EC7 = undefined;
  self.func_8ECE = undefined;
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

changearchetype(var_00, var_01, var_02) {
  if(isDefined(self.changedarchetypeinfo)) {
    var_03 = self.changedarchetypeinfo;

    if(var_3.archetype == var_00 && var_3.super == var_01 && var_3.trait == var_02)
      return;
  }

  var_04 = spawnStruct();
  var_4.archetype = var_00;
  var_4.super = var_01;
  var_4.trait = var_02;
  self.changedarchetypeinfo = var_04;
  self.pers["changedArchetypeInfo"] = var_04;

  if(!isai(self)) {
    self setclientomnvar("ui_selected_archetype", level.archetypeids[var_00]);
    self setclientomnvar("ui_selected_super", scripts\mp\supers::_meth_8186(var_01));
    self setclientomnvar("ui_selected_trait", scripts\mp\perks::getequipmenttableinfo(var_02));
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] != "") {
    scripts\mp\menus::preloadandqueueclass(self.pers["class"]);

    if(shouldallowinstantclassswap())
      giveloadoutswap();
    else if(isalive(self))
      self iprintlnbold(game["strings"]["change_rig"]);
  }
}

getattachmentloadoutstring(var_00, var_01) {
  var_02 = scripts\engine\utility::ter_op(var_01 == "primary", "loadoutPrimaryAttachment", "loadoutSecondaryAttachment");

  if(var_00 == 0)
    return var_02;

  return var_02 + (var_00 + 1);
}

getmaxprimaryattachments() {
  return 6;
}

getmaxsecondaryattachments() {
  return 5;
}

getmaxattachments(var_00) {
  return scripts\engine\utility::ter_op(var_00 == "primary", getmaxprimaryattachments(), getmaxsecondaryattachments());
}