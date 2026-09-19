/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_class.gsc
************************************************/

init() {
  setdvarifuninitialized("spv_cavalryRiflemanPerk_enabled", 1);
  level.classmap["class0"] = 0;
  level.classmap["class1"] = 1;
  level.classmap["class2"] = 2;
  level.classmap["class3"] = 3;
  level.classmap["class4"] = 4;
  level.classmap["class5"] = 5;
  level.classmap["class6"] = 6;
  level.classmap["class7"] = 7;
  level.classmap["class8"] = 8;
  level.classmap["class9"] = 9;
  level.classmap["class10"] = 10;
  level.classmap["class11"] = 11;
  level.classmap["class12"] = 12;
  level.classmap["class13"] = 13;
  level.classmap["class14"] = 14;
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
  level.classmap["custom11"] = 10;
  level.classmap["custom12"] = 11;
  level.classmap["custom13"] = 12;
  level.classmap["custom14"] = 13;
  level.classmap["custom15"] = 14;
  level.classmap["custom16"] = 15;
  level.classmap["custom17"] = 16;
  level.classmap["custom18"] = 17;
  level.classmap["custom19"] = 18;
  level.classmap["custom20"] = 19;
  level.classmap["custom21"] = 20;
  level.classmap["custom22"] = 21;
  level.classmap["custom23"] = 22;
  level.classmap["custom24"] = 23;
  level.classmap["custom25"] = 24;
  level.classmap["custom26"] = 25;
  level.classmap["custom27"] = 26;
  level.classmap["custom28"] = 27;
  level.classmap["custom29"] = 28;
  level.classmap["custom30"] = 29;
  level.classmap["custom31"] = 30;
  level.classmap["custom32"] = 31;
  level.classmap["custom33"] = 32;
  level.classmap["custom34"] = 33;
  level.classmap["custom35"] = 34;
  level.classmap["custom36"] = 35;
  level.classmap["custom37"] = 36;
  level.classmap["custom38"] = 37;
  level.classmap["custom39"] = 38;
  level.classmap["custom40"] = 39;
  level.classmap["custom41"] = 40;
  level.classmap["custom42"] = 41;
  level.classmap["custom43"] = 42;
  level.classmap["custom44"] = 43;
  level.classmap["custom45"] = 44;
  level.classmap["custom46"] = 45;
  level.classmap["custom47"] = 46;
  level.classmap["custom48"] = 47;
  level.classmap["custom49"] = 48;
  level.classmap["custom50"] = 49;
  level.classmap["custom51"] = 50;
  level.classmap["custom52"] = 51;
  level.classmap["custom53"] = 52;
  level.classmap["custom54"] = 53;
  level.classmap["custom55"] = 54;
  level.classmap["custom56"] = 55;
  level.classmap["custom57"] = 56;
  level.classmap["custom58"] = 57;
  level.classmap["custom59"] = 58;
  level.classmap["custom60"] = 59;
  level.classmap["practice1"] = 0;
  level.classmap["practice2"] = 1;
  level.classmap["practice3"] = 2;
  level.classmap["practice4"] = 3;
  level.classmap["practice5"] = 4;
  level.classmap["practice6"] = 5;
  level.classmap["practice7"] = 6;
  level.classmap["practice8"] = 7;
  level.classmap["practice9"] = 8;
  level.classmap["practice10"] = 9;
  level.classmap["lobby1"] = 0;
  level.classmap["lobby2"] = 1;
  level.classmap["lobby3"] = 2;
  level.classmap["lobby4"] = 3;
  level.classmap["lobby5"] = 4;
  level.classmap["lobby6"] = 5;
  level.classmap["lobby7"] = 6;
  level.classmap["lobby8"] = 7;
  level.classmap["lobby9"] = 8;
  level.classmap["lobby10"] = 9;
  level.classmap["lobby11"] = 10;
  level.classmap["lobby12"] = 11;
  level.classmap["lobby13"] = 12;
  level.classmap["lobby14"] = 13;
  level.classmap["lobby15"] = 14;
  level.classmap["lobby16"] = 15;
  level.classmap["lobby17"] = 16;
  level.classmap["lobby18"] = 17;
  level.classmap["lobby19"] = 18;
  level.classmap["lobby20"] = 19;
  level.classmap["lobby21"] = 20;
  level.classmap["lobby22"] = 21;
  level.classmap["lobby23"] = 22;
  level.classmap["lobby24"] = 23;
  level.classmap["lobby25"] = 24;
  level.classmap["lobby26"] = 25;
  level.classmap["lobby27"] = 26;
  level.classmap["lobby28"] = 27;
  level.classmap["lobby29"] = 28;
  level.classmap["lobby30"] = 29;
  level.classmap["lobby31"] = 30;
  level.classmap["lobby32"] = 31;
  level.classmap["lobby33"] = 32;
  level.classmap["lobby34"] = 33;
  level.classmap["lobby35"] = 34;
  level.classmap["lobby36"] = 35;
  level.classmap["lobby37"] = 36;
  level.classmap["lobby38"] = 37;
  level.classmap["lobby39"] = 38;
  level.classmap["lobby40"] = 39;
  level.classmap["lobby41"] = 40;
  level.classmap["lobby42"] = 41;
  level.classmap["lobby43"] = 42;
  level.classmap["lobby44"] = 43;
  level.classmap["lobby45"] = 44;
  level.classmap["lobby46"] = 45;
  level.classmap["lobby47"] = 46;
  level.classmap["lobby48"] = 47;
  level.classmap["lobby49"] = 48;
  level.classmap["lobby50"] = 49;
  level.classmap["lobby51"] = 50;
  level.classmap["lobby52"] = 51;
  level.classmap["lobby53"] = 52;
  level.classmap["lobby54"] = 53;
  level.classmap["lobby55"] = 54;
  level.classmap["lobby56"] = 55;
  level.classmap["lobby57"] = 56;
  level.classmap["lobby58"] = 57;
  level.classmap["lobby59"] = 58;
  level.classmap["lobby60"] = 59;
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
  level.classmap["copycat"] = -1;
  level.classmap["gamemode"] = 0;
  level.classmap["callback"] = 0;
  level.defaultclass = "CLASS_ASSAULT";
  level.classtablename = "mp/classTable.csv";

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    if(getdvarint("6019", 1) == 1)
      level.classtablename = "mp/classTableDivisionsOverhaulDLC4.csv";
    else if(getdvarint("6020", 1) == 1) {
      if(getdvarint("spv_cavalryRiflemanPerk_enabled", 1) == 1)
        level.classtablename = "mp/classTableDivisionsOverhaulMTX6.csv";
      else
        level.classtablename = "mp/classTableDivisionsOverhaulMTX6CavalryNerf.csv";
    } else
      level.classtablename = "mp/classTableDivisionsOverhaul.csv";
  }

  if(getdvarint("2543", 0) == 1 && getdvarint("2803", 0) == 1)
    level.classtablename = "mp/classTableGamescom.csv";

  if(getdvarint("isMLGMatch", 0) == 1 || _func_3AF()) {
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
      level.classtablename = "mp/classTableCompetitiveDivisionsOverhaul.csv";
    else
      level.classtablename = "mp/classTableCompetitive.csv";
  }

  if(getdvarint("scr_oneShot", 0) == 1) {
    if(getdvarint("6019", 1) == 1)
      level.classtablename = "mp/classTableOneShotDivisionsOverhaulDLC4.csv";
    else if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
      level.classtablename = "mp/classTableOneShotDivisionsOverhaul.csv";
    else
      level.classtablename = "mp/classTableOneShot.csv";
  }

  if(level.gametype == "infect")
    level.classtablename = "mp/classtableInfect.csv";

  if(getdvarint("scr_wanderlustOnly", 0) == 1) {
    if(getdvarint("6019", 1) == 1)
      level.classtablename = "mp/classTableWanderlustOnlyDLC4.csv";
    else
      level.classtablename = "mp/classTableWanderlustOnly.csv";
  }

  if(level.gametype == "undead") {
    if(getdvarint("6019", 1) == 1)
      level.classtablename = "mp/classTableUndeadDLC4.csv";
    else
      level.classtablename = "mp/classTableUndead.csv";
  }

  if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    if(getdvarint("6019", 1) == 1)
      level.classtablename = "mp/classTableThrowbackDLC4.csv";
    else if(getdvarint("spv_cavalryRiflemanPerk_enabled", 1) == 1)
      level.classtablename = "mp/classTableThrowback.csv";
    else
      level.classtablename = "mp/classTableThrowbackCavalryNerf.csv";
  }

  level._id_761A = "mp/practiceRoundClassTable.csv";
  level._id_761B = "mp/practiceRoundCostumeTable.csv";
  level._id_0A53 = "mp/agentCostumeTable.csv";
  level._id_4B16 = "mp/hardcoreCostumeTable.csv";
  level._id_2323 = 10;

  if(!isDefined(level._id_297A))
    level._id_297A = 10;

  level._id_2681 = [];
  level._id_2681["shirt"] = 10;
  level._id_2681["pants"] = 12;
  level._id_2681["gear"] = 11;
  level._id_2681["hat"] = 9;
  level._id_2681["eyewear"] = 8;
  level thread onplayerconnecting();
}

_id_1D3F() {
  var_0 = ["class0", "class1", "class2", "class3", "class4"];

  foreach(var_2 in var_0)
  var_3 = level giveloadout(0, var_2);
}

_id_44B4() {
  var_0 = [];
  var_0["loadoutDivision"] = 5;
  var_0["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(0, 0);

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0["loadoutPrimaryAttachmentsGUID"][var_1] = 0;

  var_0["loadoutPrimaryCamoGUID"] = 0;
  var_0["loadoutPrimaryCamo2GUID"] = 0;
  var_0["loadoutPrimaryReticleGUID"] = 0;
  var_0["loadoutPrimaryCustomization"] = 0;
  var_0["loadoutPrimaryPaintjobId"] = 0;
  var_0["loadoutPrimaryCharmGUID"] = 0;
  var_0["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(0, 0);

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0["loadoutSecondaryAttachmentsGUID"][var_1] = 0;

  var_0["loadoutSecondaryCamoGUID"] = 0;
  var_0["loadoutSecondaryCamo2GUID"] = 0;
  var_0["loadoutSecondaryReticleGUID"] = 0;
  var_0["loadoutSecondaryCustomization"] = 0;
  var_0["loadoutSecondaryPaintjobId"] = 0;
  var_0["loadoutSecondaryCharmGUID"] = 0;
  var_0["loadoutEquipmentStruct"] = maps\mp\_utility::_id_44CE(0, 0);
  var_0["loadoutEquipmentNumExtra"] = 0;
  var_0["loadoutOffhandStruct"] = maps\mp\_utility::_id_44CE(0, 0);
  var_0["loadoutOffhandNumExtra"] = 0;

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0["loadoutKillstreaksGUID"][var_1] = 0;

  var_0["loadoutPerksGUID"] = _id_052D::_id_44B5();
  return var_0;
}

getclasschoice(var_0) {
  return var_0;
}

getweaponchoice(var_0) {
  var_1 = strtok(var_0, ",");

  if(var_1.size > 1)
    return int(var_1[1]);
  else
    return 0;
}

logclasschoice(var_0, var_1, var_2, var_3) {
  if(var_0 == self.lastclass) {
    return;
  }
  self logstring("choseclass: " + var_0 + " weapon: " + var_1 + " special: " + var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    self logstring("perk" + var_4 + ": " + var_3[var_4]);

  self.lastclass = var_0;
}

cac_getdefaultweapon(var_0) {
  return self getplayerdata(common_scripts\utility::_id_46A8(), "selectedLoadout", "weaponSetups", var_0, "weapon");
}

cac_getdefaultperk(var_0) {
  return self getplayerdata(common_scripts\utility::_id_46A8(), "selectedLoadout", "perkSlots", var_0);
}

cac_getdefaultequipment() {
  return self getplayerdata(common_scripts\utility::_id_46A8(), "selectedLoadout", "equipmentSetups", 0, "equipment");
}

_id_1E05(var_0) {
  if(!isDefined(var_0)) {
    var_0 = common_scripts\utility::_id_46AF();
    var_1 = maps\mp\_utility::_id_5385();

    if(!_func_3AC() || var_1)
      var_0 = common_scripts\utility::_id_46AC();
    else if(common_scripts\utility::_id_562E(self.inrankedlobby))
      var_0 = common_scripts\utility::_id_ACEE();
  }

  return self getplayerdata(var_0, "displayClassIndex");
}

_id_1E07() {
  var_0 = common_scripts\utility::_id_46AF();
  var_1 = maps\mp\_utility::_id_5385();

  if(!_func_3AC() || var_1)
    var_0 = common_scripts\utility::_id_46AC();
  else if(_func_3AF())
    var_0 = common_scripts\utility::_id_ACEE();

  return self getplayerdata(var_0, "meleeWeapon", "weapon");
}

cac_getweaponcharm(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "charm");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "charm");
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "charm");
}

cac_getdivision(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "division");
  else if(_func_367()) {
    if(isDefined(var_1) && var_1 == common_scripts\utility::_id_46AF())
      return self _meth_844D("customClasses", var_0, "division");
    else
      return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "division");
  } else
    return self _meth_823F(var_0, "division");
}

cac_getweapon(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "weapon");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "weapon");
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "weapon");
}

cac_getweaponattachment(var_0, var_1, var_2) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "attachment", var_2);
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "attachment", var_2);
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "attachment", var_2);
}

cac_getweaponcamo(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "camo");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "camo");
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "camo");
}

cac_getweaponcamo2(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "camo2");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "camo2");
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "camo2");
}

cac_getweaponcustomization(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "reticle");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "reticle");
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "reticle");
}

_id_1E0E(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "customization");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "customization");
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "customization");
}

cac_getweaponpaintjob(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "weaponSetups", var_1, "paintjob");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "weaponSetups", var_1, "paintjob");
  else
    return self _meth_823F(var_0, "weaponSetups", var_1, "paintjob");
}

cac_getperk(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "perkSlots", var_1);
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "perkSlots", var_1);
  else
    return self _meth_823F(var_0, "perkSlots", var_1);
}

cac_getkillstreak(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46AF();
  var_3 = maps\mp\_utility::_id_5385();

  if(!_func_3AC())
    var_2 = common_scripts\utility::_id_46AC();
  else if(_func_3AF())
    var_2 = common_scripts\utility::_id_ACEE();

  var_4 = "none";

  if(isDefined(level._id_3E0E)) {
    if(issubstr(level._id_3E0E, "private"))
      var_2 = common_scripts\utility::_id_46AC();
    else
      var_2 = common_scripts\utility::_id_46AF();
  }

  var_4 = self getplayerdata(var_2, "assaultStreaks", var_1, "streak");

  if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::_id_452B(var_4)) == 0)
    return 0;

  return var_4;
}

cac_getequipment(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return self _meth_844D(level._id_3E0E, var_0, "equipmentSetups", var_1, "equipment");
  else if(_func_367())
    return self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "equipmentSetups", var_1, "equipment");
  else
    return self _meth_823F(var_0, "equipmentSetups", var_1, "equipment");
}

cac_getequipmentextra(var_0, var_1) {
  if(isDefined(level._id_3E0E))
    return int(self _meth_844D(level._id_3E0E, var_0, "equipmentSetups", var_1, "numExtra"));
  else if(_func_367())
    return int(self _meth_844D(maps\mp\_utility::_id_1E01(), var_0, "equipmentSetups", var_1, "numExtra"));
  else
    return int(self _meth_823F(var_0, "equipmentSetups", var_1, "numExtra"));
}

_id_1E08(var_0) {
  return cac_getequipment(var_0, 1);
}

_id_1F9B(var_0) {
  return var_0 == "head";
}

_id_1F98(var_0) {
  return self getplayerdata(common_scripts\utility::_id_46A9(), "globalCostume", var_0);
}

_id_1F9A(var_0, var_1) {
  return self getplayerdata(common_scripts\utility::_id_46A9(), "costumes", var_1, var_0);
}

_id_1F93(var_0, var_1) {
  var_2 = var_0;

  if(var_0 > 5)
    var_2 = var_0 - 1;

  if(var_1 == "allies")
    var_2 = var_2 * 2;
  else if(var_1 == "axis")
    var_2 = var_2 * 2 + 1;

  return var_2;
}

_id_1F96(var_0) {
  var_1 = self getplayerdata(common_scripts\utility::_id_46A9(), "activeCostume");

  if(isDefined(self.team)) {
    if(isDefined(var_0) && var_0) {
      if(self.team == "allies")
        var_1 = var_1 | 1;
      else if(self.team == "axis")
        var_1 = var_1 & 254;
    } else if(self.team == "allies")
      var_1 = var_1 & 254;
    else if(self.team == "axis")
      var_1 = var_1 | 1;
  }

  return var_1;
}

cao_costumeindexteam(var_0) {
  if(var_0 & 1)
    return "axis";
  else
    return "allies";
}

_id_1F97(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_2683.size; var_2++) {
    var_3 = level._id_2683[var_2];

    if(_id_1F9B(var_3)) {
      var_1[var_2] = _id_1F98(var_3);
      continue;
    }

    var_1[var_2] = _id_1F9A(var_3, var_0);
  }

  var_4 = _id_1F9A("faceCamoId", var_0);

  if(isDefined(var_4) && var_4 >= 0)
    var_1[level._id_2683.size] = var_4;

  return var_1;
}

_id_1F95(var_0) {
  var_1 = _id_1F96(var_0);
  return _id_1F97(var_1);
}

_id_1F99(var_0) {
  var_1 = _id_1E05(var_0);
  var_2 = cac_getdivision(var_1, var_0);
  var_3 = _id_1F93(var_2, "allies");
  self setplayerdata(common_scripts\utility::_id_46A9(), "activeCostume", var_3);
  return _id_1F97(var_3);
}

_id_1FA2(var_0) {
  self._id_267E = _id_1F99(var_0);

  if(isDefined(self.team) && self.team == "axis")
    self _meth_866E(1);

  self _meth_84C7(self._id_267E);
}

_id_1FA0() {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(_func_1EF(self)) {
    return;
  }
  for(var_0 = 0; var_0 < level._id_2683.size; var_0++) {
    var_1 = level._id_2683[var_0];

    if(_id_1F9B(var_1)) {
      continue;
    }
    var_2 = level._id_2686[var_1];
    var_3 = self._id_267E[var_0];
    var_4 = _func_2C0(var_2, var_3);
    var_5 = tablelookup("mp/statstable.csv", 18, var_4, 29);
    _id_1FA1(var_1, int(var_5));
  }
}

_id_1FA1(var_0, var_1) {
  var_2 = 0;
  var_3 = 1;
  var_4 = 2;
  var_5 = 3;
  var_6 = 4;
  var_7 = 5;
  var_8 = "mp/costumeStatTable.csv";
  var_9 = var_4;

  if(!isDefined(var_1))
    var_1 = 0;

  switch (var_1) {
    case 0:
      var_9 = var_4;
      break;
    case 1:
      var_9 = var_5;
      break;
    case 2:
      var_9 = var_6;
      break;
    case 3:
      var_9 = var_7;
      break;
    default:
      var_9 = var_4;
      break;
  }

  var_10 = tablelookup(var_8, 0, var_0, 1);
  var_11 = tablelookup(var_8, 0, var_0, var_9);

  if(var_11 == "NA") {
    return;
  }
  maps\mp\_utility::giveperk(var_10);

  switch (var_10) {
    case "specialty_falldamage":
      self._id_3A0F = _func_0AD(var_11);
      break;
    case "specialty_streakshield":
      self._id_944B = _func_0AD(var_11);
      break;
    case "specialty_streakdamager":
      self._id_2998 = _func_0AD(var_11);
      break;
    case "specialty_extraammo":
      self._id_9AAE = _func_0AD(var_11);
      break;
    case "specialty_paint":
      maps\mp\_utility::giveperk("specialty_paint_pro");
      self._id_90DA = _func_0AD(var_11);
      break;
    default:
      break;
  }
}

_id_21B9() {
  if((!isDefined(self._id_5097) || !self._id_5097) && isDefined(self._id_267E) && getdvarint("5092")) {
    var_0 = [];
    self._id_2680 = [];

    for(var_1 = 0; var_1 < self._id_267E.size; var_1++) {
      var_2 = level._id_2683[var_1];
      var_3 = level._id_2686[var_2];
      var_4 = self._id_267E[var_1];
      var_5 = _func_2C0(var_3, var_4);
      var_6 = level._id_2681[var_2];

      if(isDefined(var_6)) {
        var_7 = _func_1B1("mp/characterGearSetTable.csv", var_6, var_5);

        while(isDefined(var_7) && var_7 >= 0) {
          var_8 = _func_1AE("mp/characterGearSetTable.csv", var_7, 0);

          if(!isDefined(var_0[var_8])) {
            var_9 = _func_1AE("mp/characterGearSetTable.csv", var_7, 4);
            var_10 = _func_1AE("mp/characterGearSetTable.csv", var_7, 5);
            var_11 = _func_1AE("mp/characterGearSetTable.csv", var_7, 7);
            var_12 = [];
            var_12["bonusType"] = var_9;
            var_12["bonus"] = _func_0AD(var_10);
            var_12["amtInSet"] = var_11;
            var_12["foundAmt"] = 1;
            var_0[var_8] = var_12;
          } else
            var_0[var_8]["foundAmt"]++;

          var_7 = var_7 - 1;

          if(var_7 >= 0)
            var_7 = _func_1B1("mp/characterGearSetTable.csv", var_6, var_5, var_7);
        }
      }
    }

    var_13 = getarraykeys(var_0);

    for(var_1 = 0; var_1 < var_13.size; var_1++) {
      var_8 = var_13[var_1];
      var_9 = var_0[var_8]["bonusType"];
      var_10 = var_0[var_8]["bonus"];
      var_11 = int(var_0[var_8]["amtInSet"]);
      var_14 = var_0[var_8]["foundAmt"];

      if(var_11 == var_14) {
        if(!isDefined(self._id_2680[var_9])) {
          var_15 = [];
          var_15[var_8] = var_10;
          self._id_2680[var_9] = [];
          self._id_2680[var_9]["refs"] = var_15;
          self._id_2680[var_9]["bonusTotal"] = var_10;
          continue;
        }

        self._id_2680[var_9]["refs"][var_8] = var_10;
        self._id_2680[var_9]["bonusTotal"] = self._id_2680[var_9]["bonusTotal"] + var_10;
      }
    }
  }
}

table_getdivision(var_0, var_1) {
  var_2 = 5;
  var_3 = tablelookup(var_0, 0, "loadoutDivision", var_1 + 1);

  if(isDefined(var_3) && _func_30E(var_3) && _id_04CA::_id_56CC(int(var_3)))
    var_2 = int(var_3);

  return var_2;
}

table_getweapon(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = "";

  if(var_2 == 0)
    var_4 = tablelookup(var_0, 0, "loadoutPrimary", var_1 + 1);
  else
    var_4 = tablelookup(var_0, 0, "loadoutSecondary", var_1 + 1);

  var_3 = maps\mp\_utility::_id_452A(var_4);
  return var_3;
}

table_getweaponattachment(var_0, var_1, var_2, var_3) {
  var_4 = "none";
  var_5 = "loadoutPrimaryAttachment";

  if(var_2)
    var_5 = "loadoutSecondaryAttachment";

  if(!isDefined(var_3))
    var_3 = 0;

  switch (var_3) {
    case 0:
      break;
    case 1:
      var_5 = var_5 + "2";
      break;
    case 2:
      var_5 = var_5 + "3";
      break;
    case 3:
      var_5 = var_5 + "4";
      break;
    case 4:
      var_5 = var_5 + "5";
      break;
    case 5:
      var_5 = var_5 + "6";
      break;
    default:
  }

  var_4 = tablelookup(var_0, 0, var_5, var_1 + 1);
  var_6 = maps\mp\_utility::_id_452A(var_4);
  return var_6;
}

table_getweaponbuff(var_0, var_1, var_2) {
  if(var_2 == 0)
    return tablelookup(var_0, 0, "loadoutPrimaryBuff", var_1 + 1);
  else
    return tablelookup(var_0, 0, "loadoutSecondaryBuff", var_1 + 1);
}

table_getweaponcamo(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = "";

  if(var_2 == 0)
    var_4 = tablelookup(var_0, 0, "loadoutPrimaryCamo", var_1 + 1);
  else
    var_4 = tablelookup(var_0, 0, "loadoutSecondaryCamo", var_1 + 1);

  var_3 = maps\mp\_utility::_id_452A(var_4);
  return var_3;
}

table_getweaponcamo2(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = "";

  if(var_2 == 0)
    var_4 = tablelookup(var_0, 0, "loadoutPrimaryCamo2", var_1 + 1);
  else
    var_4 = tablelookup(var_0, 0, "loadoutSecondaryCamo2", var_1 + 1);

  var_3 = maps\mp\_utility::_id_452A(var_4);
  return var_3;
}

table_getweaponreticle(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = "";

  if(var_2 == 0)
    var_4 = tablelookup(var_0, 0, "loadoutPrimaryReticle", var_1 + 1);
  else
    var_4 = tablelookup(var_0, 0, "loadoutSecondaryReticle", var_1 + 1);

  var_3 = maps\mp\_utility::_id_452A(var_4);
  return var_3;
}

table_getweaponcustomization(var_0, var_1, var_2) {
  if(var_2 == 0)
    var_3 = tablelookup(var_0, 0, "loadoutPrimaryCustomization", var_1 + 1);
  else
    var_3 = tablelookup(var_0, 0, "loadoutSecondaryCustomization", var_1 + 1);

  if(var_3 == "")
    var_3 = 0;

  return var_3;
}

table_getperk(var_0, var_1, var_2) {
  var_2++;
  var_3 = "loadoutPerk" + var_2;
  var_4 = tablelookup(var_0, 0, var_3, var_1 + 1);
  var_5 = maps\mp\_utility::_id_452A(var_4);
  return var_5;
}

table_getequipment(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutEquipment", var_1 + 1);
  var_3 = maps\mp\_utility::_id_452A(var_2);
  return var_3;
}

_id_9585(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutEquipmentNumExtra", var_1 + 1);

  if(var_2 != "" && _func_30E(var_2))
    return int(var_2);
  else
    return 0;
}

table_getperkteam(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutTeamPerk", var_1 + 1);
}

table_getoffhand(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutOffhand", var_1 + 1);
  var_3 = maps\mp\_utility::_id_452A(var_2);
  return var_3;
}

table_getoffhandextra(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutOffhandNumExtra", var_1 + 1);

  if(var_2 != "" && _func_30E(var_2))
    return int(var_2);
  else
    return 0;
}

table_getkillstreak(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, "loadoutStreak" + (var_2 + 1), var_1 + 1);
  var_4 = maps\mp\_utility::_id_452A(var_3);
  return var_4;
}

cloneloadout() {
  var_0 = "none";
  var_1 = self.curclass;
  var_2 = self._id_231D;
  var_3 = undefined;

  if(var_1 == "copycat") {
    var_1 = self.pers["copyCatLoadout"]["className"];
    var_3 = self.pers["copyCatLoadout"]["practiceClassNum"];

    if(var_1 == "callback")
      var_2 = self.pers["copyCatLoadout"]["classCallbackFunc"];
  }

  if(issubstr(var_1, "axis"))
    var_0 = "axis";
  else if(issubstr(var_1, "allies"))
    var_0 = "allies";

  var_4 = 5;
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];

  if(var_0 != "none") {
    var_9 = maps\mp\_utility::getclassindex(var_1);
    var_4 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "division");
    var_10 = maps\mp\_utility::_id_473C(_func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "weapon"), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_7[var_11] = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "attachment", var_11);

    var_12 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "camo");
    var_13 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "camo2");
    var_14 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "reticle");
    var_15 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "customization");
    var_16 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "paintjob");
    var_17 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 0, "charm");
    var_18 = maps\mp\_utility::_id_473C(_func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "weapon"), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_8[var_11] = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "attachment", var_11);

    var_19 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "camo");
    var_20 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "camo2");
    var_21 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "reticle");
    var_22 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "customization");
    var_23 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "paintjob");
    var_24 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "weaponSetups", 1, "charm");
    var_25 = maps\mp\_utility::_id_44CE(_func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "equipmentSetups", 0, "equipment"), 0);
    var_26 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "equipmentSetups", 0, "numExtra");
    var_27 = maps\mp\_utility::_id_44CE(_func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "equipmentSetups", 1, "equipment"), 0);
    var_28 = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "equipmentSetups", 1, "numExtra");

    for(var_11 = 0; var_11 < 9; var_11++)
      var_5[var_11] = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "perkSlots", var_11);

    for(var_11 = 0; var_11 < 4; var_11++)
      var_6[var_11] = _func_132("defaultClasses", var_0, "defaultClass", var_9, "class", "assaultStreaks", var_11, "streak");
  } else if(issubstr(var_1, "custom")) {
    var_29 = maps\mp\_utility::getclassindex(var_1);
    var_4 = cac_getdivision(var_29);
    var_10 = maps\mp\_utility::_id_473C(cac_getweapon(var_29, 0), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_7[var_11] = cac_getweaponattachment(var_29, 0, var_11);

    var_12 = cac_getweaponcamo(var_29, 0);
    var_13 = cac_getweaponcamo2(var_29, 0);
    var_14 = cac_getweaponcustomization(var_29, 0);
    var_15 = _id_1E0E(var_29, 0);
    var_16 = cac_getweaponpaintjob(var_29, 0);
    var_17 = cac_getweaponcharm(var_29, 0);
    var_18 = maps\mp\_utility::_id_473C(cac_getweapon(var_29, 1), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_8[var_11] = cac_getweaponattachment(var_29, 1, var_11);

    var_19 = cac_getweaponcamo(var_29, 1);
    var_20 = cac_getweaponcamo2(var_29, 1);
    var_21 = cac_getweaponcustomization(var_29, 1);
    var_22 = _id_1E0E(var_29, 1);
    var_23 = cac_getweaponpaintjob(var_29, 1);
    var_24 = cac_getweaponcharm(var_29, 1);
    var_25 = maps\mp\_utility::_id_44CE(cac_getequipment(var_29, 0), 0);
    var_26 = cac_getequipmentextra(var_29, 0);
    var_27 = maps\mp\_utility::_id_44CE(cac_getequipment(var_29, 1), 0);
    var_28 = cac_getequipmentextra(var_29, 1);

    for(var_11 = 0; var_11 < 9; var_11++)
      var_5[var_11] = cac_getperk(var_29, var_11);

    for(var_11 = 0; var_11 < 4; var_11++)
      var_6[var_11] = cac_getkillstreak(var_29, var_11);
  } else if(maps\mp\_utility::_id_761E() && issubstr(var_1, "practice")) {
    var_29 = maps\mp\_utility::getclassindex(var_1);

    if(isDefined(var_3))
      var_29 = var_3;
    else {
      var_29 = self.pers["practiceRoundClasses"][var_29];
      var_3 = var_29;
    }

    var_4 = table_getdivision(level._id_761A, var_29);
    var_10 = maps\mp\_utility::_id_473C(table_getweapon(level._id_761A, var_29, 0), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_7[var_11] = table_getweaponattachment(level._id_761A, var_29, 0, var_11);

    var_12 = table_getweaponcamo(level._id_761A, var_29, 0);
    var_13 = table_getweaponcamo2(level._id_761A, var_29, 0);
    var_14 = table_getweaponreticle(level._id_761A, var_29, 0);
    var_15 = table_getweaponcustomization(level._id_761A, var_29, 0);
    var_16 = 0;
    var_17 = 0;
    var_18 = maps\mp\_utility::_id_473C(table_getweapon(level._id_761A, var_29, 1), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_8[var_11] = table_getweaponattachment(level._id_761A, var_29, 1, var_11);

    var_19 = table_getweaponcamo(level._id_761A, var_29, 1);
    var_20 = table_getweaponcamo2(level._id_761A, var_29, 1);
    var_21 = table_getweaponreticle(level._id_761A, var_29, 1);
    var_22 = table_getweaponcustomization(level._id_761A, var_29, 1);
    var_23 = 0;
    var_24 = 0;
    var_25 = maps\mp\_utility::_id_44CE(table_getequipment(level._id_761A, var_29), 0);
    var_26 = _id_9585(level._id_761A, var_29);
    var_27 = maps\mp\_utility::_id_44CE(table_getoffhand(level._id_761A, var_29), 0);
    var_28 = table_getoffhandextra(level._id_761A, var_29);

    for(var_11 = 0; var_11 < 9; var_11++)
      var_5[var_11] = table_getperk(level._id_761A, var_29, var_11);

    for(var_11 = 0; var_11 < 4; var_11++)
      var_6[var_11] = table_getkillstreak(level._id_761A, var_29, var_11);
  } else if(var_1 == "callback") {
    if(!isDefined(var_2))
      common_scripts\utility::_id_3809("self.classCallback function reference required for class 'callback'");

    var_30 = [[var_2]](1);

    if(!isDefined(var_30))
      common_scripts\utility::_id_3809("array required from self.classCallback for class 'callback'");

    var_4 = var_30["loadoutDivision"];
    var_10 = var_30["loadoutPrimaryWeaponStruct"];

    for(var_11 = 0; var_11 < 6; var_11++)
      var_7[var_11] = var_30["loadoutPrimaryAttachmentsGUID"][var_11];

    var_12 = var_30["loadoutPrimaryCamoGUID"];
    var_13 = var_30["loadoutPrimaryCamo2GUID"];
    var_14 = var_30["loadoutPrimaryReticleGUID"];
    var_15 = var_30["loadoutPrimaryCustomization"];
    var_16 = var_30["loadoutPrimaryPaintjobId"];
    var_17 = var_30["loadoutPrimaryCharmGUID"];

    for(var_11 = 0; var_11 < 9; var_11++)
      var_5[var_11] = var_30["loadoutPerkGUID" + (var_11 + 1)];

    var_18 = var_30["loadoutSecondaryWeaponStruct"];

    for(var_11 = 0; var_11 < 6; var_11++)
      var_8[var_11] = var_30["loadoutSecondaryAttachmentsGUID" + (var_11 + 1)];

    var_19 = var_30["loadoutSecondaryCamoGUID"];
    var_20 = var_30["loadoutSecondaryCamo2GUID"];
    var_21 = var_30["loadoutSecondaryReticleGUID"];
    var_22 = var_30["loadoutSecondaryCustomization"];
    var_23 = var_30["loadoutSecondaryPaintjobId"];
    var_24 = var_30["loadoutSecondaryCharmGUID"];
    var_25 = var_30["loadoutEquipmentStruct"];
    var_26 = int(var_30["loadoutEquipmentNumExtra"]);
    var_27 = var_30["loadoutOffhandStruct"];
    var_28 = int(var_30["loadoutOffhandNumExtra"]);

    for(var_11 = 0; var_11 < 4; var_11++)
      var_6[var_11] = var_30["loadoutStreakGUID" + (var_11 + 1)];
  } else {
    var_29 = maps\mp\_utility::getclassindex(var_1);
    var_4 = table_getdivision(level.classtablename, var_29);
    var_10 = maps\mp\_utility::_id_473C(table_getweapon(level.classtablename, var_29, 0), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_7[var_11] = table_getweaponattachment(level.classtablename, var_29, 0, var_11);

    var_12 = table_getweaponcamo(level.classtablename, var_29, 0);
    var_13 = table_getweaponcamo2(level.classtablename, var_29, 0);
    var_14 = table_getweaponreticle(level.classtablename, var_29, 0);
    var_15 = table_getweaponcustomization(level.classtablename, var_29, 0);
    var_16 = 0;
    var_17 = 0;
    var_18 = maps\mp\_utility::_id_473C(table_getweapon(level.classtablename, var_29, 1), 0);

    for(var_11 = 0; var_11 < 6; var_11++)
      var_8[var_11] = table_getweaponattachment(level.classtablename, var_29, 1, var_11);

    var_19 = table_getweaponcamo(level.classtablename, var_29, 1);
    var_20 = table_getweaponcamo2(level.classtablename, var_29, 1);
    var_21 = table_getweaponreticle(level.classtablename, var_29, 1);
    var_22 = table_getweaponcustomization(level.classtablename, var_29, 1);
    var_23 = 0;
    var_24 = 0;
    var_25 = maps\mp\_utility::_id_44CE(table_getequipment(level.classtablename, var_29), 0);
    var_26 = _id_9585(level.classtablename, var_29);
    var_27 = maps\mp\_utility::_id_44CE(table_getoffhand(level.classtablename, var_29), 0);
    var_28 = table_getoffhandextra(level.classtablename, var_29);

    for(var_11 = 0; var_11 < 9; var_11++)
      var_5[var_11] = table_getperk(level.classtablename, var_29, var_11);

    var_31 = common_scripts\utility::_id_46AF();

    if(!_func_3AC())
      var_31 = common_scripts\utility::_id_46AC();
    else if(_func_3AF())
      var_31 = common_scripts\utility::_id_ACEE();

    for(var_11 = 0; var_11 < 4; var_11++)
      var_6[var_11] = self getplayerdata(var_31, "assaultStreaks", var_11, "streak");
  }

  var_32 = [];
  var_32["inUse"] = 0;
  var_32["className"] = var_1;

  if(isDefined(var_3))
    var_32["practiceClassNum"] = var_3;

  if(var_1 == "callback" && isDefined(var_2))
    var_32["classCallbackFunc"] = var_2;

  var_32["loadoutDivision"] = var_4;
  var_32["loadoutPrimaryWeaponStruct"] = var_10;

  for(var_11 = 0; var_11 < 6; var_11++)
    var_32["loadoutPrimaryAttachmentsGUID"][var_11] = var_7[var_11];

  var_32["loadoutPrimaryCamoGUID"] = var_12;
  var_32["loadoutPrimaryCamo2GUID"] = var_13;
  var_32["loadoutPrimaryReticleGUID"] = var_14;
  var_32["loadoutPrimaryCustomization"] = var_15;
  var_32["loadoutPrimaryPaintjobId"] = var_16;
  var_32["loadoutPrimaryCharmGUID"] = var_17;
  var_32["loadoutSecondaryWeaponStruct"] = var_18;

  for(var_11 = 0; var_11 < 6; var_11++)
    var_32["loadoutSecondaryAttachmentsGUID"][var_11] = var_8[var_11];

  var_32["loadoutSecondaryCamoGUID"] = var_19;
  var_32["loadoutSecondaryCamo2GUID"] = var_20;
  var_32["loadoutSecondaryReticleGUID"] = var_21;
  var_32["loadoutSecondaryCustomization"] = var_22;
  var_32["loadoutSecondaryPaintjobId"] = var_23;
  var_32["loadoutSecondaryCharmGUID"] = var_24;
  var_32["loadoutEquipmentStruct"] = var_25;
  var_32["loadoutEquipmentNumExtra"] = var_26;
  var_32["loadoutOffhandStruct"] = var_27;
  var_32["loadoutOffhandNumExtra"] = var_28;

  for(var_11 = 0; var_11 < 9; var_11++)
    var_32["loadoutPerksGUID"][var_11] = var_5[var_11];

  for(var_11 = 0; var_11 < 4; var_11++)
    var_32["loadoutKillstreaksGUID"][var_11] = var_6[var_11];

  return var_32;
}

giveloadout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isPlayer(self))
    var_5 = self;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(self != level && isDefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && var_2)
    var_6 = 1;
  else
    var_6 = 0;

  if(isDefined(level._id_5DF2) && isDefined(level._id_5DF2[var_1]) && !_func_367()) {
    var_7 = level._id_5DF2[var_1];

    if(isDefined(var_7))
      return var_7;
  }

  if(isDefined(self._id_5DF2) && !_func_367() && (!maps\mp\_utility::_id_579B() || !getdvarint("raid_allow_scorestreaks", 0)) && level.gametype != "infect") {
    var_7 = self._id_5DF2[var_1];

    if(isDefined(var_7) && maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level.raidclearloadoutcacheonspawn) && isDefined(var_7.raid_team) && self.team != var_7.raid_team)
      var_7 = undefined;

    if(isDefined(var_7)) {
      if(var_7._id_870C == var_3 && var_7._id_2669 == var_6 && var_7.class == var_1)
        return var_7;
    }
  }

  var_8 = 0;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = [];

  for(var_13 = 0; var_13 < 4; var_13++)
    var_12[var_13] = undefined;

  var_14 = 0;
  var_15 = undefined;
  var_16 = issubstr(var_1, "custom");
  var_17 = maps\mp\_utility::_id_761E() && issubstr(var_1, "practice");
  var_18 = 5;
  var_19 = [];
  var_20 = [];
  var_21 = [];

  for(var_13 = 0; var_13 < 6; var_13++) {
    var_20[var_13] = 0;
    var_21[var_13] = 0;
  }

  var_22 = level._id_2323;
  var_23 = undefined;
  var_24 = 1;
  var_25 = var_1 == "gamemode";

  if(level.gametype == "infect" && var_0 == "axis")
    var_25 = 1;

  if(issubstr(var_1, "axis"))
    var_26 = "axis";
  else if(issubstr(var_1, "allies"))
    var_26 = "allies";
  else
    var_26 = "none";

  var_27 = [];

  if(var_6) {
    var_16 = 0;
    var_17 = 0;
    var_9 = maps\mp\_utility::getclassindex("copycat");
    var_27 = self.pers["copyCatLoadout"];
    var_18 = var_27["loadoutDivision"];
    var_28 = var_27["loadoutPrimaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = var_27["loadoutPrimaryAttachmentsGUID"][var_13];

    var_29 = var_27["loadoutPrimaryCamoGUID"];
    var_30 = var_27["loadoutPrimaryCamo2GUID"];
    var_31 = var_27["loadoutPrimaryReticleGUID"];
    var_10 = var_27["loadoutPrimaryCustomization"];
    var_32 = var_27["loadoutPrimaryPaintjobId"];
    var_33 = var_27["loadoutPrimaryCharmGUID"];
    var_34 = var_27["loadoutSecondaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = var_27["loadoutSecondaryAttachmentsGUID"][var_13];

    var_35 = var_27["loadoutSecondaryCamoGUID"];
    var_36 = var_27["loadoutSecondaryCamo2GUID"];
    var_37 = var_27["loadoutSecondaryReticleGUID"];
    var_11 = var_27["loadoutSecondaryCustomization"];
    var_38 = var_27["loadoutSecondaryPaintjobId"];
    var_39 = var_27["loadoutSecondaryCharmGUID"];
    var_40 = var_27["loadoutEquipmentStruct"];
    var_41 = var_27["loadoutEquipmentNumExtra"];
    var_42 = var_27["loadoutOffhandStruct"];
    var_43 = var_27["loadoutOffhandNumExtra"];

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = var_27["loadoutPerksGUID"][var_13];

    for(var_13 = 0; var_13 < 4; var_13++)
      var_12[var_13] = var_27["loadoutKillstreaksGUID"][var_13];
  } else if(isDefined(level._id_585D) && level._id_585D) {
    var_22 = level._id_297A;
    var_44 = cac_getdefaultweapon(0);

    if(!isDefined(var_44) || var_44 == 0) {
      var_45 = ["m1a1_mp", "m30_mp", "svt40_mp", "m1911_mp", "model21_mp", "luger_mp", "kar98_mp", "p38_mp", "g43_mp"];
      var_44 = _func_310(common_scripts\utility::random(var_45));
    }

    var_28 = maps\mp\_utility::_id_473C(var_44, 1);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = 0;

    var_29 = 0;
    var_30 = 0;
    var_31 = 0;
    var_10 = 0;
    var_32 = 0;
    var_33 = 0;

    if(isDefined(level._id_A9CC)) {
      var_46 = maps\mp\_utility::_id_4737(var_28);
      var_47 = [[level._id_A9CC]](var_5, var_46);

      if(isDefined(var_47)) {
        if(var_47._id_7E18)
          var_31 = var_47._id_7E18;

        if(var_47._id_1EC0)
          var_29 = var_47._id_1EC0;

        if(var_47._id_297C)
          var_10 = var_47._id_297C;

        for(var_48 = 0; var_48 < var_47._id_114C.size; var_48++) {
          var_49 = var_47._id_114C[var_48];
          var_20[var_48] = var_49;
        }

        if(var_47._id_A9F8) {
          var_44 = var_47._id_A9F8;
          var_28 = maps\mp\_utility::_id_473C(var_44, 1);
        }

        if(var_47.charmguid)
          var_33 = var_47.charmguid;

        if(var_47.paintjobdwfileslot)
          var_32 = var_47.paintjobdwfileslot;
      }
    }

    var_34 = maps\mp\_utility::_id_473C(0, 1);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = 0;

    var_35 = 0;
    var_36 = 0;
    var_37 = 0;
    var_11 = 0;
    var_38 = 0;
    var_39 = 0;
    var_24 = 1;
    var_23 = maps\mp\_utility::_id_473C(0, 0);
    var_40 = maps\mp\_utility::_id_44CE(cac_getdefaultequipment(), 1);
    var_41 = 0;
    var_42 = maps\mp\_utility::_id_44CE(0, 1);
    var_43 = 0;

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = cac_getdefaultperk(var_13);

    for(var_13 = 0; var_13 < 4; var_13++)
      var_12[var_13] = 0;
  } else if(var_26 != "none") {
    var_50 = maps\mp\_utility::getclassindex(var_1);
    var_9 = var_50;
    self._id_231B = var_50;
    self._id_985A = var_26;
    var_22 = 20;
    var_18 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "division");
    var_44 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "weapon");

    if(var_44 == 0) {
      var_44 = 17113088;

      for(var_13 = 0; var_13 < 6; var_13++)
        var_20[var_13] = 0;
    } else {
      for(var_13 = 0; var_13 < 6; var_13++)
        var_20[var_13] = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "attachment", var_13);
    }

    var_29 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "camo");
    var_30 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "camo2");
    var_31 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "reticle");
    var_10 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "customization");
    var_32 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "paintjob");
    var_33 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 0, "charm");
    var_51 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "weapon");

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "attachment", var_13);

    var_35 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "camo");
    var_36 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "camo2");
    var_37 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "reticle");
    var_11 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "customization");
    var_38 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "paintjob");
    var_39 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "weaponSetups", 1, "charm");
    var_40 = maps\mp\_utility::_id_44CE(_func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "equipmentSetups", 0, "equipment"), 0);
    var_41 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "equipmentSetups", 0, "numExtra");
    var_42 = maps\mp\_utility::_id_44CE(_func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "equipmentSetups", 1, "equipment"), 0);
    var_43 = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "equipmentSetups", 1, "numExtra");

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "perkSlots", var_13);

    for(var_13 = 0; var_13 < 4; var_13++)
      var_12[var_13] = _func_132("defaultClasses", var_26, "defaultClass", var_50, "class", "assaultStreaks", var_13, "streak");

    if((var_44 == 16818176 || var_44 == 0) && var_51 != 0) {
      var_44 = var_51;

      for(var_13 = 0; var_13 < 6; var_13++)
        var_20[var_13] = var_21[var_13];

      var_29 = var_35;
      var_30 = var_36;
      var_31 = var_37;
      var_32 = var_38;
      var_33 = var_39;
      var_51 = 0;

      for(var_13 = 0; var_13 < 6; var_13++)
        var_21[var_13] = 0;

      var_35 = 0;
      var_36 = 0;
      var_37 = 0;
      var_38 = 0;
      var_39 = 0;
    } else if((var_44 == 16818176 || var_44 == 0) && var_51 == 0) {
      var_8 = 1;
      var_44 = 16863232;
      var_52 = "none";
    }

    var_28 = maps\mp\_utility::_id_473C(var_44, 0);
    var_34 = maps\mp\_utility::_id_473C(var_51, 0);
  } else if(issubstr(var_1, "custom")) {
    var_9 = maps\mp\_utility::getclassindex(var_1);
    var_22 = level._id_297A;
    var_18 = cac_getdivision(var_9);
    var_28 = maps\mp\_utility::_id_473C(cac_getweapon(var_9, 0), 0);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = cac_getweaponattachment(var_9, 0, var_13);

    var_29 = cac_getweaponcamo(var_9, 0);
    var_30 = cac_getweaponcamo2(var_9, 0);
    var_31 = cac_getweaponcustomization(var_9, 0);
    var_10 = _id_1E0E(var_9, 0);
    var_32 = cac_getweaponpaintjob(var_9, 0);
    var_33 = cac_getweaponcharm(var_9, 0);
    var_34 = maps\mp\_utility::_id_473C(cac_getweapon(var_9, 1), 0);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = cac_getweaponattachment(var_9, 1, var_13);

    var_35 = cac_getweaponcamo(var_9, 1);
    var_36 = cac_getweaponcamo2(var_9, 1);
    var_37 = cac_getweaponcustomization(var_9, 1);
    var_11 = _id_1E0E(var_9, 1);
    var_38 = cac_getweaponpaintjob(var_9, 1);
    var_39 = cac_getweaponcharm(var_9, 1);
    var_23 = maps\mp\_utility::_id_473C(_id_1E07(), 0);
    var_40 = maps\mp\_utility::_id_44CE(cac_getequipment(var_9, 0), 0);
    var_41 = cac_getequipmentextra(var_9, 0);
    var_42 = maps\mp\_utility::_id_44CE(cac_getequipment(var_9, 1), 0);
    var_43 = cac_getequipmentextra(var_9, 1);

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = cac_getperk(var_9, var_13);

    for(var_13 = 0; var_13 < 4; var_13++)
      var_12[var_13] = cac_getkillstreak(var_9, var_13);
  } else if(var_17) {
    var_9 = maps\mp\_utility::getclassindex(var_1);
    var_9 = self.pers["practiceRoundClasses"][var_9];
    var_18 = table_getdivision(level._id_761A, var_9);
    var_28 = maps\mp\_utility::_id_473C(table_getweapon(level._id_761A, var_9, 0), 0);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = table_getweaponattachment(level._id_761A, var_9, 0, var_13);

    var_29 = table_getweaponcamo(level._id_761A, var_9, 0);
    var_30 = table_getweaponcamo2(level._id_761A, var_9, 0);
    var_31 = table_getweaponreticle(level._id_761A, var_9, 0);
    var_10 = table_getweaponcustomization(level._id_761A, var_9, 0);
    var_32 = 0;
    var_33 = 0;
    var_34 = maps\mp\_utility::_id_473C(table_getweapon(level._id_761A, var_9, 1), 0);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = table_getweaponattachment(level._id_761A, var_9, 1, var_13);

    var_35 = table_getweaponcamo(level._id_761A, var_9, 1);
    var_36 = table_getweaponcamo2(level._id_761A, var_9, 1);
    var_37 = table_getweaponreticle(level._id_761A, var_9, 1);
    var_11 = table_getweaponcustomization(level._id_761A, var_9, 1);
    var_38 = 0;
    var_39 = 0;
    var_40 = maps\mp\_utility::_id_44CE(table_getequipment(level._id_761A, var_9), 0);
    var_41 = _id_9585(level._id_761A, var_9);
    var_42 = maps\mp\_utility::_id_44CE(table_getoffhand(level._id_761A, var_9), 0);
    var_43 = table_getoffhandextra(level._id_761A, var_9);

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = table_getperk(level._id_761A, var_9, var_13);

    for(var_13 = 0; var_13 < 4; var_13++)
      var_12[var_13] = table_getkillstreak(level._id_761A, var_9, var_13);
  } else if(issubstr(var_1, "lobby")) {
    var_9 = maps\mp\_utility::getclassindex(var_1);
    var_53 = maps\mp\_utility::_id_1E01();
    var_7 = self._id_5E01[var_53][var_9];
    var_18 = var_7["division"];
    var_28 = var_7["primaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = var_7["primaryAttachmentsGUID"][var_13];

    var_29 = var_7["primaryCamoGUID"];
    var_30 = var_7["primaryCamo2GUID"];
    var_31 = var_7["primaryReticleGUID"];
    var_10 = var_7["primaryCustomization"];
    var_32 = var_7["primaryPaintjobId"];
    var_33 = var_7["primaryCharmGUID"];

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = var_7["perkGUID" + var_13];

    var_40 = var_7["equipmentStruct"];
    var_42 = var_7["offhandStruct"];
    var_41 = 0;
    var_43 = 0;
    var_34 = var_7["secondaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = var_7["secondaryAttachmentsGUID"][var_13];

    var_35 = var_7["secondaryCamoGUID"];
    var_36 = var_7["secondaryCamo2GUID"];
    var_37 = var_7["secondaryReticleGUID"];
    var_11 = var_7["secondaryCustomization"];
    var_38 = var_7["secondaryPaintjobId"];
    var_39 = var_7["secondaryCharmGUID"];
    var_23 = var_7["meleeWeaponStruct"];
  } else if(var_25) {
    var_54 = self.pers["gamemodeLoadout"];
    var_18 = var_54["loadoutDivision"];
    var_28 = var_54["loadoutPrimaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = var_54["loadoutPrimaryAttachmentsGUID"][var_13];

    var_29 = var_54["loadoutPrimaryCamoGUID"];
    var_30 = var_54["loadoutPrimaryCamo2GUID"];
    var_31 = var_54["loadoutPrimaryReticleGUID"];
    var_10 = var_54["loadoutPrimaryCustomization"];
    var_32 = var_54["loadoutPrimaryPaintjobId"];
    var_33 = var_54["loadoutPrimaryCharmGUID"];

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = var_54["loadoutPerksGUID"][var_13];

    var_34 = var_54["loadoutSecondaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = var_54["loadoutSecondaryAttachmentsGUID"][var_13];

    var_35 = var_54["loadoutSecondaryCamoGUID"];
    var_36 = var_54["loadoutSecondaryCamo2GUID"];
    var_37 = var_54["loadoutSecondaryReticleGUID"];
    var_11 = var_54["loadoutSecondaryCustomization"];
    var_38 = var_54["loadoutSecondaryPaintjobId"];
    var_39 = var_54["loadoutSecondaryCharmGUID"];
    var_40 = var_54["loadoutEquipmentStruct"];
    var_41 = var_54["loadoutEquipmentNumExtra"];
    var_42 = var_54["loadoutOffhandStruct"];
    var_43 = var_54["loadoutOffhandNumExtra"];

    if(level._id_5A6F) {
      var_55 = 1;

      if(isDefined(self._id_3FC4) && self._id_3FC4) {
        var_56 = 1;

        foreach(var_58 in var_54["loadoutKillstreaksGUID"]) {
          if(var_58 != 0) {
            var_56 = 0;
            break;
          }
        }

        if(var_56) {
          var_55 = 0;
          var_14 = 1;
        }
      }

      if(var_55) {
        for(var_13 = 0; var_13 < 4; var_13++)
          var_12[var_13] = var_54["loadoutKillstreaksGUID"][var_13];
      }
    } else {
      for(var_13 = 0; var_13 < 4; var_13++)
        var_12[var_13] = 0;
    }

    var_24 = var_54["ignoreMeleeSlotWeapon"];
  } else if(var_1 == "callback") {
    var_22 = level._id_297A;

    if(!isDefined(self._id_231D))
      common_scripts\utility::_id_3809("self.classCallback function reference required for class 'callback'");

    var_60 = [[self._id_231D]](var_4);

    if(!isDefined(var_60))
      common_scripts\utility::_id_3809("array required from self.classCallback for class 'callback'");

    var_18 = var_60["loadoutDivision"];
    var_28 = var_60["loadoutPrimaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = var_60["loadoutPrimaryAttachmentsGUID"][var_13];

    var_29 = var_60["loadoutPrimaryCamoGUID"];
    var_30 = var_60["loadoutPrimaryCamo2GUID"];
    var_31 = var_60["loadoutPrimaryReticleGUID"];
    var_10 = var_60["loadoutPrimaryCustomization"];
    var_32 = var_60["loadoutPrimaryPaintjobId"];
    var_33 = var_60["loadoutPrimaryCharmGUID"];

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = var_60["loadoutPerkGUID" + (var_13 + 1)];

    var_34 = var_60["loadoutSecondaryWeaponStruct"];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = var_60["loadoutSecondaryAttachmentsGUID"][var_13];

    var_35 = var_60["loadoutSecondaryCamoGUID"];
    var_36 = var_60["loadoutSecondaryCamo2GUID"];
    var_37 = var_60["loadoutSecondaryReticleGUID"];
    var_11 = var_60["loadoutSecondaryCustomization"];
    var_38 = var_60["loadoutSecondaryPaintjobId"];
    var_39 = var_60["loadoutSecondaryCharmGUID"];
    var_23 = var_60["loadoutMeleeWeaponStruct"];
    var_40 = var_60["loadoutEquipmentStruct"];
    var_42 = var_60["loadoutOffhandStruct"];
    var_41 = var_60["loadoutEquipmentNumExtra"];
    var_43 = var_60["loadoutOffhandNumExtra"];

    for(var_13 = 0; var_13 < 4; var_13++)
      var_12[var_13] = var_60["loadoutStreakGUID" + (var_13 + 1)];
  } else {
    var_9 = maps\mp\_utility::getclassindex(var_1);
    var_18 = table_getdivision(level.classtablename, var_9);
    var_28 = maps\mp\_utility::_id_473C(table_getweapon(level.classtablename, var_9, 0), 0);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_20[var_13] = table_getweaponattachment(level.classtablename, var_9, 0, var_13);

    var_29 = table_getweaponcamo(level.classtablename, var_9, 0);
    var_30 = table_getweaponcamo2(level.classtablename, var_9, 0);
    var_31 = table_getweaponreticle(level.classtablename, var_9, 0);
    var_10 = table_getweaponcustomization(level.classtablename, var_9, 0);
    var_32 = 0;
    var_33 = 0;

    for(var_13 = 0; var_13 < 9; var_13++)
      var_19[var_13] = table_getperk(level.classtablename, var_9, var_13);

    var_34 = maps\mp\_utility::_id_473C(table_getweapon(level.classtablename, var_9, 1), 0);

    for(var_13 = 0; var_13 < 6; var_13++)
      var_21[var_13] = table_getweaponattachment(level.classtablename, var_9, 1, var_13);

    var_35 = table_getweaponcamo(level.classtablename, var_9, 1);
    var_36 = table_getweaponcamo2(level.classtablename, var_9, 1);
    var_37 = table_getweaponreticle(level.classtablename, var_9, 1);
    var_11 = table_getweaponcustomization(level.classtablename, var_9, 1);
    var_38 = 0;
    var_39 = 0;
    var_40 = maps\mp\_utility::_id_44CE(table_getequipment(level.classtablename, var_9), 0);
    var_41 = _id_9585(level.classtablename, var_9);
    var_42 = maps\mp\_utility::_id_44CE(table_getoffhand(level.classtablename, var_9), 0);
    var_43 = table_getoffhandextra(level.classtablename, var_9);
    var_61 = common_scripts\utility::_id_46AF();

    if(!_func_3AC())
      var_61 = common_scripts\utility::_id_46AC();
    else if(_func_3AF())
      var_61 = common_scripts\utility::_id_ACEE();

    for(var_13 = 0; var_13 < 4; var_13++) {
      var_12[var_13] = self getplayerdata(var_61, "assaultStreaks", var_13, "streak");

      if(!isDefined(var_12[var_13]))
        var_12[var_13] = 0;
    }
  }

  var_62 = issubstr(var_1, "custom") || issubstr(var_1, "lobby");
  var_63 = issubstr(var_1, "recipe");
  var_64 = _func_3AF();

  if(level._id_5A6F && !isDefined(var_12[0]) && !isDefined(var_12[1]) && !isDefined(var_12[2]) && !isDefined(var_12[3])) {
    var_9 = maps\mp\_utility::getclassindex(var_1);

    if(isDefined(self._id_231B))
      var_9 = self._id_231B;

    var_15 = "assaultStreaks";
    var_61 = common_scripts\utility::_id_46AF();

    if(!_func_3AC())
      var_61 = common_scripts\utility::_id_46AC();
    else if(_func_3AF())
      var_61 = common_scripts\utility::_id_ACEE();

    var_66 = [];

    for(var_13 = 0; var_13 < 4; var_13++) {
      var_66[var_13] = table_getkillstreak(level.classtablename, var_9, var_13);
      var_12[var_13] = undefined;
    }

    if(var_16) {
      for(var_13 = 0; var_13 < 4; var_13++)
        var_12[var_13] = self getplayerdata(var_61, var_15, var_13, "streak");
    }

    if(var_25) {
      foreach(var_58 in self.killstreaks) {
        if(!isDefined(var_12[0])) {
          var_12[0] = var_58;
          continue;
        }

        if(!isDefined(var_12[1])) {
          var_12[1] = var_58;
          continue;
        }

        if(!isDefined(var_12[2])) {
          var_12[2] = var_58;
          continue;
        }

        if(!isDefined(var_12[3]))
          var_12[3] = var_58;
      }
    }

    if(!issubstr(var_1, "custom") && !var_25) {
      for(var_13 = 0; var_13 < 4; var_13++)
        var_12[var_13] = var_66[var_13];
    }

    for(var_13 = 0; var_13 < 4; var_13++) {
      if(!isDefined(var_12[var_13]))
        var_12[var_13] = 0;

      if(!_id_582D(var_12[var_13]) || var_62 && !self isitemunlocked(var_12[var_13]) && !var_64)
        var_12[var_13] = table_getkillstreak(level.classtablename, 0, var_13);
    }
  } else if(!level._id_5A6F) {
    for(var_13 = 0; var_13 < 4; var_13++)
      var_12[var_13] = 0;
  }

  var_21[4] = 0;
  var_21[5] = 0;
  var_20[4] = 0;
  var_20[5] = 0;
  var_69 = maps\mp\_utility::_id_452A(tablelookup("mp/statstable.csv", 18, var_28.guid, 9));
  var_70 = maps\mp\_utility::_id_452A(tablelookup("mp/statstable.csv", 18, var_34.guid, 9));

  if(!isDefined(var_18) || !_id_04CA::_id_56CC(var_18))
    var_18 = 5;

  if(!isDefined(var_41))
    var_41 = 0;

  if(!isDefined(var_43))
    var_43 = 0;

  if(getdvarint("683", 0)) {
    if(!_id_04CA::_id_569B("Primary", var_18)) {
      var_28.guid = 17113088;

      for(var_13 = 0; var_13 < 6; var_13++)
        var_20[var_13] = 0;
    } else {
      for(var_13 = 0; var_13 < 6; var_13++) {
        if(!_id_04CA::_id_569B(_id_04CA::_id_9C8A("Primary_Attachment", var_13), var_18))
          var_20[var_13] = 0;
      }
    }

    if(!_id_04CA::_id_569B("Secondary", var_18)) {
      var_34.guid = 17113088;

      for(var_13 = 0; var_13 < 6; var_13++)
        var_21[var_13] = 0;
    } else {
      for(var_13 = 0; var_13 < 6; var_13++) {
        if(!_id_04CA::_id_569B(_id_04CA::_id_9C8A("Secondary_Attachment", var_13), var_18))
          var_21[var_13] = 0;
      }
    }

    for(var_13 = 0; var_13 < 9; var_13++) {
      if(!_id_04CA::_id_569B(_id_04CA::_id_9C8A("Perk", var_13), var_18))
        var_19[var_13] = 0;
    }

    if(!_id_04CA::_id_569B("Lethal1", var_18)) {
      var_40.guid = 0;
      var_41 = 0;
    } else {
      if(!_id_04CA::_id_569B("Lethal3", var_18))
        var_41 = _func_0AF(var_41, 1);

      if(!_id_04CA::_id_569B("Lethal2", var_18))
        var_41 = 0;
    }

    if(!_id_04CA::_id_569B("Tactical1", var_18)) {
      var_42.guid = 0;
      var_43 = 0;
    } else {
      if(!_id_04CA::_id_569B("Tactical3", var_18))
        var_43 = _func_0AF(var_43, 1);

      if(!_id_04CA::_id_569B("Tactical2", var_18))
        var_43 = 0;
    }

    var_71 = 0;

    if(var_28.guid != 0)
      var_71 = var_71 + _id_04CA::_id_4443("Primary", var_18);

    if(var_20[0] != 0 && var_69 == 0)
      var_71 = var_71 + _id_04CA::_id_4443("Primary_Attachment1", var_18);

    for(var_13 = 1; var_13 < 6; var_13++) {
      if(var_20[var_13] != 0)
        var_71 = var_71 + _id_04CA::_id_4443(_id_04CA::_id_9C8A("Primary_Attachment", var_13), var_18);
    }

    if(var_34.guid != 0)
      var_71 = var_71 + _id_04CA::_id_4443("Secondary", var_18);

    if(var_21[0] != 0 && var_70 == 0)
      var_71 = var_71 + _id_04CA::_id_4443("Secondary_Attachment1", var_18);

    for(var_13 = 1; var_13 < 6; var_13++) {
      if(var_21[var_13] != 0)
        var_71 = var_71 + _id_04CA::_id_4443(_id_04CA::_id_9C8A("Secondary_Attachment", var_13), var_18);
    }

    if(var_40.guid != 0)
      var_71 = var_71 + _id_04CA::_id_4443("Lethal1", var_18);

    if(isDefined(var_41) && var_41 > 0) {
      if(var_41 >= 1)
        var_71 = var_71 + _id_04CA::_id_4443("Lethal2", var_18);

      if(var_41 >= 2)
        var_71 = var_71 + _id_04CA::_id_4443("Lethal3", var_18);
    }

    if(var_42.guid != 0)
      var_71 = var_71 + _id_04CA::_id_4443("Tactical1", var_18);

    if(isDefined(var_43) && var_43 > 0) {
      if(var_41 >= 1)
        var_71 = var_71 + _id_04CA::_id_4443("Tactical2", var_18);

      if(var_41 >= 2)
        var_71 = var_71 + _id_04CA::_id_4443("Tactical3", var_18);
    }

    for(var_13 = 0; var_13 < 9; var_13++) {
      if(var_19[var_13] != 0)
        var_71 = var_71 + _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", var_13), var_18);
    }

    if(var_71 > var_22) {
      for(;;) {
        if(var_19[8] != 0) {
          var_19[8] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 8), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[7] != 0) {
          var_19[7] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 7), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[6] != 0) {
          var_19[6] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 6), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[5] != 0) {
          var_19[5] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 5), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[4] != 0) {
          var_19[4] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 4), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[3] != 0) {
          var_19[3] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 3), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[2] != 0) {
          var_19[2] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 2), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[1] != 0) {
          var_19[1] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 1), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_19[0] != 0) {
          var_19[0] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Perk", 0), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(isDefined(var_43) && var_43 > 0) {
          if(var_43 == 2) {
            var_43 = 1;
            var_71 = var_71 - _id_04CA::_id_4443("Tactical3", var_18);
          }

          if(var_71 <= var_22) {
            break;
          }

          if(var_43 == 1) {
            var_43 = 0;
            var_71 = var_71 - _id_04CA::_id_4443("Tactical2", var_18);
          }

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_42.guid != 0) {
          var_42.guid = 0;
          var_71 = var_71 - _id_04CA::_id_4443("Tactical1", var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(isDefined(var_41) && var_41 > 0) {
          if(var_41 == 2) {
            var_41 = 1;
            var_71 = var_71 - _id_04CA::_id_4443("Lethal3", var_18);
          }

          if(var_71 <= var_22) {
            break;
          }

          if(var_41 == 1) {
            var_41 = 0;
            var_71 = var_71 - _id_04CA::_id_4443("Lethal2", var_18);
          }

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_40.guid != 0) {
          var_40.guid = 0;
          var_71 = var_71 - _id_04CA::_id_4443("Tactical1", var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_21[1] != 0) {
          var_21[1] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Secondary_Attachment", 1), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_21[0] != 0 && var_70 == 0) {
          var_21[0] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Secondary_Attachment", 0), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_34.guid != 17113088) {
          var_34.guid = 17113088;
          var_21[0] = 0;
          var_71 = var_71 - _id_04CA::_id_4443("Secondary", var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_20[3] != 0) {
          var_20[3] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Primary_Attachment", 3), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_20[2] != 0) {
          var_20[2] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Primary_Attachment", 2), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_20[1] != 0) {
          var_20[1] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Primary_Attachment", 1), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_20[0] != 0 && var_69 == 0) {
          var_20[0] = 0;
          var_71 = var_71 - _id_04CA::_id_4443(_id_04CA::_id_9C8A("Primary_Attachment", 0), var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        if(var_28.guid != 17113088) {
          var_28.guid = 17113088;
          var_20[0] = 0;
          var_71 = var_71 - _id_04CA::_id_4443("Primary", var_18);

          if(var_71 <= var_22) {
            break;
          }
        }

        break;
      }
    }
  }

  if(!var_25 && !var_63 && !(isDefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && var_2)) {
    var_72 = var_19[3] == 73400456 || var_19[3] == 73400489;
    var_73 = isvalidprimary(var_28.guid, var_72);

    if(!var_73 || level.rankedmatch && var_62 && !self isitemunlocked(var_28.guid) && !var_64) {
      var_28.guid = table_getweapon(level.classtablename, 10, 0);

      for(var_13 = 0; var_13 < 6; var_13++)
        var_20[var_13] = 0;
    }

    if(var_69 != 0)
      var_20[0] = var_69;
    else if(!isvalidattachment(var_20[0], var_28.guid) || level.rankedmatch && var_62 && !_id_567C(var_28.guid, var_20[0]) && !var_64)
      var_20[0] = table_getweaponattachment(level.classtablename, 10, 0, 0);

    for(var_13 = 1; var_13 < 6; var_13++) {
      if(!isvalidattachment(var_20[var_13], var_28.guid) || level.rankedmatch && var_62 && !_id_567C(var_28.guid, var_20[var_13]) && !var_64)
        var_20[var_13] = table_getweaponattachment(level.classtablename, 10, 0, var_13);
    }

    var_74 = [];

    for(var_13 = 0; var_13 < 6; var_13++)
      var_74[var_13] = var_20[var_13];

    for(var_75 = 0; var_75 < var_74.size; var_75++) {
      if(var_74[var_75] == 0) {
        continue;
      }
      for(var_76 = var_75 + 1; var_76 < var_74.size; var_76++) {
        if(var_74[var_76] == 0) {
          continue;
        }
        if(var_74[var_75] == var_74[var_76]) {
          _id_7B3D();
          var_74[var_76] = 0;
          var_20[var_76] = 0;
        }
      }
    }

    if(!_id_5821(var_29) || level.rankedmatch && var_62 && !_id_56A0(var_28.guid, var_29) && !var_64)
      var_29 = table_getweaponcamo(level.classtablename, 10, 0);

    if(!_id_5821(var_30) || level.rankedmatch && var_62 && !_id_56A0(var_28.guid, var_30) && !var_64)
      var_30 = table_getweaponcamo2(level.classtablename, 10, 0);

    if(!_id_5838(var_31))
      var_31 = table_getweaponreticle(level._id_2325, 10, 0);

    var_77 = getdvarint("spv_cavalryRiflemanPerk_enabled", 1) == 1 && var_18 == 7 || var_19[3] == 73400419 || level.gametype == "undead";
    var_78 = var_19[3] == 73400426;

    if(!isvalidsecondary(var_34.guid, var_77, var_78) || level.rankedmatch && var_62 && !self isitemunlocked(var_34.guid) && !var_64) {
      var_34.guid = table_getweapon(level.classtablename, 10, 1);

      for(var_13 = 0; var_13 < 6; var_13++)
        var_21[var_13] = 0;

      var_35 = 0;
      var_36 = 0;
      var_37 = 0;
      var_11 = 0;
      var_38 = 0;
    }

    if(var_70 != 0)
      var_21[0] = var_70;
    else if(!isvalidattachment(var_21[0], var_34.guid) || level.rankedmatch && var_62 && !_id_567C(var_34.guid, var_21[0]) && !var_64)
      var_21[0] = table_getweaponattachment(level.classtablename, 10, 1, 0);

    for(var_13 = 1; var_13 < 6; var_13++) {
      if(!isvalidattachment(var_21[var_13], var_34.guid) || level.rankedmatch && var_62 && !_id_567C(var_34.guid, var_21[var_13]) && !var_64)
        var_21[var_13] = table_getweaponattachment(level.classtablename, 10, 1, var_13);
    }

    if(var_21[0] != 0) {
      if(var_21[0] == var_21[1]) {
        _id_7B3D();
        var_21[1] = 0;
      }
    }

    if(!_id_5821(var_35) || level.rankedmatch && var_62 && !_id_56A0(var_34.guid, var_35) && !var_64)
      var_35 = table_getweaponcamo(level.classtablename, 10, 1);

    if(!_id_5821(var_36) || level.rankedmatch && var_62 && !_id_56A0(var_34.guid, var_36) && !var_64)
      var_36 = table_getweaponcamo2(level.classtablename, 10, 1);

    if(!_id_5838(var_37))
      var_37 = table_getweaponreticle(level.classtablename, 10, 1);

    if(!_id_5826(maps\mp\_utility::_id_44CD(var_40), 0, var_18 == 8) || level.rankedmatch && var_62 && !self isitemunlocked(var_40.guid) && !var_64)
      var_40.guid = table_getequipment(level.classtablename, 10);

    if(var_40.guid == var_42.guid)
      var_40.guid = 0;

    if(!_id_5833(maps\mp\_utility::_id_44CD(var_42), 0))
      var_42.guid = table_getoffhand(level.classtablename, 10);
  }

  for(var_13 = 0; var_13 < 9; var_13++) {
    if(var_19[var_13] == 0) {
      continue;
    }
    var_79 = var_19[var_13];
    var_19[var_13] = _id_052D::_id_A277(var_13, var_19[var_13]);

    if(var_79 != var_19[var_13])
      _id_7B3D();
  }

  var_80 = 0;
  var_81 = var_19[3] == 73400412;
  var_82 = maps\mp\_utility::_id_4431(maps\mp\_utility::_id_4737(var_34));

  if(maps\mp\_utility::_id_5856(var_82))
    var_82 = _id_4432(var_82);

  if(var_81 && maps\mp\_utility::getweaponclass(var_82) == "weapon_pistol") {
    switch (var_82) {
      case "enfieldno2_mp":
      case "reich_mp":
      case "p38_mp":
      case "luger_mp":
      case "m1911_mp":
        var_80 = 50332864;
        break;
      case "m712_mp":
        var_80 = 50333920;
        break;
    }

    for(var_13 = 0; var_13 < var_21.size; var_13++) {
      if(var_21[var_13] == 50338160)
        var_21[var_13] = 0;
    }
  }

  var_7 = spawnStruct();
  var_7.class = var_1;
  var_7._id_231B = var_9;
  var_7._id_985A = var_26;
  var_7._id_23D9 = var_8;
  var_7._id_2669 = var_6;
  var_7._id_1E26 = var_16;
  var_7._id_7615 = var_17;
  var_7._id_56FE = var_25;
  var_7._id_0079 = var_18;
  var_7._id_7709 = var_28;
  var_7._id_76F3 = var_20;
  var_7._id_76F5 = var_29;
  var_7._id_76F4 = var_30;
  var_7._id_7700 = var_31;
  var_7._id_0144 = var_10;
  var_7.primarypaintjobid = var_32;
  var_7.primarycharmguid = var_33;
  var_83 = maps\mp\_utility::_id_4737(var_7._id_7709);
  var_7._id_76F8 = _id_1D66(var_83, var_7._id_76F3[0], var_7._id_76F3[1], var_7._id_76F3[2], var_7._id_76F3[3], var_7._id_76F3[4], var_7._id_76F3[5], maps\mp\_utility::_id_472D(var_7._id_7709), var_7._id_76F5, var_7._id_76F4, var_7._id_7700, var_7._id_0144, var_5, var_7._id_0079);
  var_7._id_835D = var_34;
  var_7._id_8353[0] = var_21[0];
  var_7._id_8353[1] = var_21[1];
  var_7._id_8353[2] = var_21[2];
  var_7._id_8353[3] = var_21[3];
  var_7._id_8353[4] = 0;
  var_7._id_8353[5] = var_80;
  var_7._id_8355 = var_35;
  var_7._id_8354 = var_36;
  var_7._id_8359 = var_37;
  var_7._id_0176 = var_11;
  var_7.secondarypaintjobid = var_38;
  var_7.secondarycharmguid = var_39;
  var_83 = maps\mp\_utility::_id_4737(var_7._id_835D);
  var_7._id_8358 = _id_1D66(var_83, var_7._id_8353[0], var_7._id_8353[1], var_7._id_8353[2], var_7._id_8353[3], var_7._id_8353[4], var_7._id_8353[5], maps\mp\_utility::_id_472D(var_7._id_835D), var_7._id_8355, var_7._id_8354, var_7._id_8359, var_7._id_0176, var_5, var_7._id_0079);
  var_7._id_60FC = var_23;
  var_7._id_509D = var_24;
  var_7._id_37FE = var_40;
  var_7._id_37FD = int(var_41);
  var_7._id_69AD = var_42;
  var_7._id_69AC = int(var_43);
  var_7._id_6F69 = var_19;

  if(getdvarint("scr_oneShot", 0) == 1) {
    var_7._id_5A62 = 69206017;
    var_7._id_5A63 = 0;
    var_7._id_5A64 = 0;
    var_7._id_5A65 = 0;
  } else if(level.gametype == "undead") {
    var_7._id_5A62 = 69206017;
    var_7._id_5A63 = 69206044;
    var_7._id_5A64 = 69206041;
    var_7._id_5A65 = 69206035;
  } else if(maps\mp\_utility::_id_579B() && issubstr(maps\mp\_utility::_id_4571(), "dlc2")) {
    if(isDefined(self.team) && self.team == "allies") {
      if(game["switchedsides"])
        var_7._id_5A62 = maps\mp\_utility::_id_452A("raid_flak");
      else
        var_7._id_5A62 = maps\mp\_utility::_id_452A("raid_fighters");
    } else if(game["switchedsides"])
      var_7._id_5A62 = maps\mp\_utility::_id_452A("raid_fighters");
    else
      var_7._id_5A62 = maps\mp\_utility::_id_452A("raid_flak");

    var_7._id_5A63 = 0;
    var_7._id_5A64 = 0;
    var_7._id_5A65 = 0;
  } else if(maps\mp\_utility::isdogfightgametype()) {
    var_7._id_5A62 = maps\mp\_utility::_id_452A("dogfight_flak");
    var_7._id_5A63 = 0;
    var_7._id_5A64 = 0;
    var_7._id_5A65 = 0;
  } else {
    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::_id_452B(var_12[0])) == 0)
      var_7._id_5A62 = 0;
    else
      var_7._id_5A62 = var_12[0];

    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::_id_452B(var_12[1])) == 0)
      var_7._id_5A63 = 0;
    else
      var_7._id_5A63 = var_12[1];

    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::_id_452B(var_12[2])) == 0)
      var_7._id_5A64 = 0;
    else
      var_7._id_5A64 = var_12[2];

    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::_id_452B(var_12[3])) == 0)
      var_7._id_5A65 = 0;
    else
      var_7._id_5A65 = var_12[3];
  }

  var_7._id_59DA = var_14;
  var_7._id_870C = var_3;

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level.raidclearloadoutcacheonspawn))
    var_7.raid_team = self.team;

  if(!issubstr(var_1, "lobby") && !issubstr(var_1, "callback") && !_func_367() && (!isDefined(self._id_509B) || !self._id_509B))
    self._id_5DF2[var_1] = var_7;

  return var_7;
}

_id_4790(var_0, var_1, var_2, var_3) {
  self._id_5DEE = giveloadout(var_0, var_1, var_2, var_3);
  _id_09A7(self._id_5DEE);

  if(!(_func_367() || maps\mp\gametypes\_hud_util::_id_5527() || level._id_53C7) && !(_func_1EF(self) || isbot(self))) {
    if(isDefined(level._id_585D) && level._id_585D) {
      for(var_4 = 0; var_4 < self._id_5DEE._id_6F69.size; var_4++) {
        if(var_4 < 9)
          setmatchdata("players", self.clientid, "loadout", "mods", var_4, self._id_5DEE._id_6F69[var_4]);
      }

      setmatchdata("players", self.clientid, "loadout", "primary", self._id_5DEE._id_7709.guid);
      setmatchdata("players", self.clientid, "loadout", "lethal", self._id_5DEE._id_37FE.guid);
    } else
      _id_5E9B();
  }
}

_id_5E9B() {
  var_0 = -1;
  var_1 = 6;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = getmatchdata("players", self.clientid, "loadouts", var_2, "inUse");

    if(var_3) {
      var_4 = getmatchdata("players", self.clientid, "loadouts", var_2, "name");

      if(self._id_5DEE.class == var_4) {
        self._id_2943 = var_2;
        self._id_294A = self._id_5DEE._id_7709.guid;
        self._id_294C = self._id_5DEE._id_835D.guid;
        return;
      }
    } else {
      var_0 = var_2;
      break;
    }
  }

  if(var_0 < 0 || var_0 >= var_1)
    var_0 = var_1 - 1;

  self._id_2943 = var_0;
  setmatchdata("players", self.clientid, "loadouts", var_0, "name", self._id_5DEE.class);
  setmatchdata("players", self.clientid, "loadouts", var_0, "inUse", 1);
  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 0, "weapon", self._id_5DEE._id_7709.guid);

  for(var_5 = 0; var_5 < self._id_5DEE._id_76F3.size; var_5++) {
    if(var_5 < 6)
      setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 0, "attachment", var_5, self._id_5DEE._id_76F3[var_5]);
  }

  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 0, "camo", self._id_5DEE._id_76F5);
  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 0, "camo2", self._id_5DEE._id_76F4);
  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 0, "reticle", self._id_5DEE._id_7700);

  if(isDefined(self._id_5DEE._id_0144))
    setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 0, "customization", self._id_5DEE._id_0144);

  if(isDefined(self._id_5DEE.primarycharmguid))
    setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 0, "charm", self._id_5DEE.primarycharmguid);

  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 1, "weapon", self._id_5DEE._id_835D.guid);

  for(var_5 = 0; var_5 < self._id_5DEE._id_8353.size; var_5++) {
    if(var_5 < 6)
      setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 1, "attachment", var_5, self._id_5DEE._id_8353[var_5]);
  }

  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 1, "camo", self._id_5DEE._id_8355);
  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 1, "camo2", self._id_5DEE._id_8354);
  setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 1, "reticle", self._id_5DEE._id_8359);

  if(isDefined(self._id_5DEE._id_0176))
    setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 1, "customization", self._id_5DEE._id_0176);

  if(isDefined(self._id_5DEE.secondarycharmguid))
    setmatchdata("players", self.clientid, "loadouts", var_0, "weaponSetups", 1, "charm", self._id_5DEE.secondarycharmguid);

  setmatchdata("players", self.clientid, "loadouts", var_0, "division", self._id_5DEE._id_0079);
  setmatchdata("players", self.clientid, "loadouts", var_0, "equipmentSetups", 0, "equipment", self._id_5DEE._id_37FE.guid);
  setmatchdata("players", self.clientid, "loadouts", var_0, "equipmentSetups", 0, "numExtra", self._id_5DEE._id_37FD);
  setmatchdata("players", self.clientid, "loadouts", var_0, "equipmentSetups", 1, "equipment", self._id_5DEE._id_69AD.guid);
  setmatchdata("players", self.clientid, "loadouts", var_0, "equipmentSetups", 1, "numExtra", self._id_5DEE._id_69AC);

  for(var_5 = 0; var_5 < self._id_5DEE._id_6F69.size; var_5++) {
    if(var_5 < 9)
      setmatchdata("players", self.clientid, "loadouts", var_0, "perkSlots", var_5, self._id_5DEE._id_6F69[var_5]);
  }

  if(isDefined(self._id_5DEE._id_5A62))
    setmatchdata("players", self.clientid, "killstreak_guids", 0, self._id_5DEE._id_5A62);

  if(isDefined(self._id_5DEE._id_5A63))
    setmatchdata("players", self.clientid, "killstreak_guids", 1, self._id_5DEE._id_5A63);

  if(isDefined(self._id_5DEE._id_5A64))
    setmatchdata("players", self.clientid, "killstreak_guids", 2, self._id_5DEE._id_5A64);

  if(isDefined(self._id_5DEE._id_5A65))
    setmatchdata("players", self.clientid, "killstreak_guids", 3, self._id_5DEE._id_5A65);

  self._id_294A = self._id_5DEE._id_7709.guid;
  self._id_294C = self._id_5DEE._id_835D.guid;
}

_id_4560() {
  var_0 = spawnStruct();
  var_0.class = "aitype";
  var_0._id_231B = undefined;
  var_0._id_985A = "none";
  var_0._id_23D9 = 0;
  var_0._id_2669 = 0;
  var_0._id_1E26 = 0;
  var_0._id_7615 = 0;
  var_0._id_56FE = 0;
  var_0._id_0079 = 5;
  var_0._id_7709 = maps\mp\_utility::_id_473D(self._id_01D0);

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0._id_76F3[var_1] = 0;

  var_0._id_76F5 = 0;
  var_0._id_76F4 = 0;
  var_0._id_7700 = 0;
  var_0._id_0144 = 0;
  var_0._id_76F8 = _id_1D66(self._id_01D0, var_0._id_76F3[0], var_0._id_76F3[1], var_0._id_76F3[2], var_0._id_76F3[3], var_0._id_76F3[4], var_0._id_76F3[5], 0, var_0._id_76F5, var_0._id_76F4, var_0._id_7700, var_0._id_0144, self, self._id_0079);
  var_0._id_835D = maps\mp\_utility::_id_473D(self._id_8C3C);

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0._id_5E02[var_1] = 0;

  var_0._id_8355 = 0;
  var_0._id_8354 = 0;
  var_0._id_8359 = 0;
  var_0._id_0176 = 0;
  var_0._id_8358 = _id_1D66(self._id_8C3C, var_0._id_5E02[0], var_0._id_5E02[1], var_0._id_5E02[2], var_0._id_5E02[3], var_0._id_5E02[4], var_0._id_5E02[5], 0, var_0._id_8355, var_0._id_8354, var_0._id_8359, var_0._id_0176, self, self._id_0079);
  var_0._id_37FE = maps\mp\_utility::_id_44CF(self._id_00B4);
  var_0._id_37FA = 0;
  var_0._id_69AD = maps\mp\_utility::_id_44CE(0, 0);
  var_0._id_69AA = 0;
  var_0._id_6F69 = [];

  for(var_1 = 0; var_1 < 9; var_1++)
    var_0._id_6F69[var_1] = 0;

  var_0._id_5A62 = 0;
  var_0._id_5A63 = 0;
  var_0._id_5A64 = 0;
  var_0._id_5A65 = 0;
  var_0._id_59DA = 0;
  var_0._id_870C = 1;
  return var_0;
}

_id_4791() {
  self._id_5DEE = _id_4560();
  self._id_5097 = 1;
  _id_09A7(self._id_5DEE);
}

_id_0F35() {
  var_0 = self._id_5DEE;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(!isDefined(self._id_5DEE)) {
    return;
  }
  var_6 = level._id_47C4;

  if(!isDefined(var_6))
    var_6 = maps\mp\_utility::_giveweapon;

  var_7 = 0;

  if(isDefined(self.pers) && isDefined(self.pers["hasSerumBasicTraining"]) && self.pers["hasSerumBasicTraining"])
    var_7 = 1;

  var_8 = 0;

  if(isDefined(self.pers) && isDefined(self.pers["hasSpecialistPerkStreak"]) && self.pers["hasSpecialistPerkStreak"])
    var_8 = 1;

  var_9 = 0;

  if(isDefined(self.pers) && isDefined(self.pers["hasSupportStreaks"]) && self.pers["hasSupportStreaks"])
    var_9 = 1;

  var_10 = 0;

  if(isDefined(self.pers) && isDefined(self.pers["hasKillStreaks"]) && self.pers["hasKillStreaks"])
    var_10 = 1;

  var_11 = 0;

  if(isDefined(self.pers) && isDefined(self.pers["hasFourthStreak"]) && self.pers["hasFourthStreak"])
    var_11 = 1;

  var_12 = 5;

  if(isDefined(self._id_0079))
    var_12 = self._id_0079;

  self._id_5DEE = undefined;
  self._id_90E4 = var_0;

  if(!maps\mp\gametypes\_hud_util::_id_5527())
    _id_04CB::_id_A050();

  self _meth_8315();
  maps\mp\_utility::_id_05E4();

  if(!isDefined(self._id_5097) || !self._id_5097)
    _id_05FF();

  self._id_20CC = undefined;

  if(var_0._id_2669)
    setclass("copycat");

  self._id_231B = var_0._id_231B;
  self._id_5E00 = var_0._id_7709;
  self._id_5DFE = var_0._id_76F8;
  self._id_5DFC = var_0._id_76F5;
  self._id_5DFB = var_0._id_76F4;
  self._id_5DFD = var_0._id_0144;
  self.loadoutprimarypaintjobid = var_0.primarypaintjobid;
  self._id_5DFF = var_0._id_7700;
  self.loadoutprimarycharmguid = var_0.primarycharmguid;
  self._id_5E08 = var_0._id_835D;
  self._id_5E06 = var_0._id_8358;
  self._id_5E04 = var_0._id_8355;
  self._id_5E03 = var_0._id_8354;
  self._id_5E05 = var_0._id_0176;
  self.loadoutsecondarypaintjobid = var_0.secondarypaintjobid;
  self.loadoutsecondarycharmguid = var_0.secondarycharmguid;
  self._id_5E07 = var_0._id_8359;
  maps\mp\_utility::_id_06D4(var_12, var_0._id_0079);
  self _meth_82FF("ui_show_division_sniper_ability_prompt", 0);
  var_13 = 0;

  if(!isDefined(level._id_585D) || !level._id_585D) {
    self _meth_82FF("ui_show_division_shotgun_ability_prompt", 0);
    self _meth_82FF("ui_show_division_smg_ability_prompt", 0);
    self _meth_82FF("ui_show_division_rifle_ability_prompt", 0);
    self _meth_82FF("ui_show_division_lmg_ability_prompt", 0);
    self _meth_82FF("ui_show_rifle_grenade_ability_prompt", 0);
    self _meth_82FF("ui_show_division_resistance_ability_prompt", 0);
    self _meth_82FF("ui_show_shield_charge_ability_prompt", 0);
    self _meth_82FF("ui_show_zk383_smg_altmode_prompt", 0);
    self _meth_82FF("ui_show_paratrooper_insert_descent_prompt", 0);

    if(self _meth_85EC() && (maps\mp\_utility::getweaponclass(self._id_5DFE) == "weapon_shotgun" && issubstr(self._id_5DFE, "dragon_breath") || maps\mp\_utility::getweaponclass(self._id_5E06) == "weapon_shotgun" && issubstr(self._id_5E06, "dragon_breath"))) {
      self _meth_82FF("ui_show_division_shotgun_ability_prompt", 1);
      var_13 = 1;
    } else if(self _meth_85EC() && (maps\mp\_utility::getweaponclass(self._id_5DFE) == "weapon_smg" && issubstr(self._id_5DFE, "suppressor") || maps\mp\_utility::getweaponclass(self._id_5E06) == "weapon_smg" && issubstr(self._id_5E06, "suppressor"))) {
      self _meth_82FF("ui_show_division_smg_ability_prompt", 1);
      var_13 = 1;
    }

    if(self _meth_85EC() && (maps\mp\_utility::getweaponclass(self._id_5DFE) == "weapon_assault" && issubstr(self._id_5DFE, "grenade_launcher") || maps\mp\_utility::getweaponclass(self._id_5E06) == "weapon_assault" && issubstr(self._id_5E06, "grenade_launcher"))) {
      self _meth_82FF("ui_show_rifle_grenade_ability_prompt", 1);
      var_13 = 1;
    }

    if(self _meth_85EC() && (maps\mp\_utility::getweaponclass(self._id_5DFE) == "weapon_shotgun" && issubstr(self._id_5DFE, "m30_rifle") || maps\mp\_utility::getweaponclass(self._id_5E06) == "weapon_shotgun" && issubstr(self._id_5E06, "m30_rifle")))
      var_13 = 1;

    if(self _meth_85EC() && (maps\mp\_utility::getweaponclass(self._id_5DFE) == "weapon_heavy" || maps\mp\_utility::getweaponclass(self._id_5E06) == "weapon_heavy"))
      var_13 = 1;

    if(self _meth_85EC() && (issubstr(self._id_5DFE, "zk383") || issubstr(self._id_5E06, "zk383")))
      var_13 = 1;

    for(var_14 = 0; var_14 < 9; var_14++) {
      if(var_0._id_6F69[var_14] == 73400499 && self _meth_85EC())
        var_13 = 1;
    }
  }

  self.pers["loadoutContainsAltSwitchWeapon"] = var_13;
  var_15 = _id_4585(var_0);

  if(var_15 != "none")
    self[[var_6]](var_15);

  var_0._id_60EE = var_15;
  var_16 = var_0._id_8358;

  if(var_16 != "none")
    self[[var_6]](var_16, undefined, var_0.secondarypaintjobid, var_0.secondarycharmguid);

  if(level._id_2EF3)
    maps\mp\_utility::giveperk("specialty_pistoldeath");

  _id_5DF1(var_0._id_37FE, var_0._id_6F69);
  _id_052D::_id_0F36();

  if(maps\mp\_utility::_hasperk("specialty_perkstreaks")) {
    if(_id_052C::handlespecialisttrainingunlocks())
      _id_052D::_id_0F36();
  }

  _id_4781();

  if(isDefined(level._id_6AB9))
    [[level._id_6AB9]](var_0);

  if(isDefined(var_0._id_37FE) && isDefined(var_0._id_37FE.guid) && var_0._id_37FE.guid == 16805888 && isDefined(self.team)) {
    var_17 = self.team;

    if(common_scripts\utility::_id_562E(level._id_9565)) {
      if(game["switchedsides"])
        var_17 = maps\mp\_utility::getotherteam(var_17);
    }

    if(var_17 == "axis") {
      var_0._id_37FE.guid = 17084416;
      var_1 = 1;
    }
  }

  var_18 = maps\mp\_utility::_id_44CD(var_0._id_37FE);
  self _meth_8349(var_18);
  self._id_6088 = 1;

  if(var_0._id_37FE.guid != 0 && self _meth_8319(var_18)) {
    var_19 = self getweaponammoclip(var_18);
    self setweaponammoclip(var_18, var_19 + 1);
  } else
    _id_479F(var_18);

  if(isDefined(var_0._id_37FD) && var_0._id_37FD > 0) {
    if(var_0._id_37FD == 2)
      maps\mp\_utility::giveperk("specialty_twoextralethal");
    else
      maps\mp\_utility::giveperk("specialty_extralethal");

    var_19 = self getweaponammoclip(var_18);
    self setweaponammoclip(var_18, var_19 + var_0._id_37FD);
    self._id_6088 = self._id_6088 + var_0._id_37FD;
  }

  if(var_1)
    var_0._id_37FE.guid = 16805888;

  var_20 = var_0._id_76F8;

  if(maps\mp\_utility::_hasperk("specialty_randomgun") && var_20 == "none")
    var_20 = self.curwunderlustgun;

  var_20 = maps\mp\_utility::_id_922B(var_20);
  self[[var_6]](var_20, undefined, var_0.primarypaintjobid, var_0.primarycharmguid);

  if(!_func_0C1(self))
    self switchtoweapon(var_20);

  if(var_20 == "riotshield_mp" && level._id_5139)
    self notify("weapon_change", "riotshield_mp");

  if(var_0._id_870C) {
    var_21 = 0;

    if(isDefined(level._id_50CA))
      var_21 = level._id_50CA;

    var_22 = maps\mp\_utility::_id_4340(var_0);

    if(maps\mp\_utility::_hasperk("specialty_randomgun"))
      var_22 = self.curwunderlustgun;

    self setspawnweapon(var_22, !maps\mp\_utility::_id_551F() || var_21, !maps\mp\_utility::gameflag("prematch_done"));
  }

  self.pers["primaryWeapon"] = maps\mp\_utility::_id_4431(var_20);

  if(isDefined(var_0._id_69AD) && isDefined(var_0._id_69AD.guid) && var_0._id_69AD.guid == 17133568 && isDefined(self._id_0079) && self._id_0079 == 4) {
    var_23 = _id_04CA::_id_461D(self._id_0079);

    if(var_23 == "specialty_class_expeditionary_grandmaster" || var_23 == "specialty_class_expeditionary_master") {
      var_0._id_69AD.guid = 17293312;
      var_5 = 1;
    }
  }

  if(isDefined(var_0._id_69AD) && isDefined(var_0._id_69AD.guid) && var_0._id_69AD.guid == 16809984) {
    if(isDefined(self.team) && self.team == "axis") {
      if(isDefined(self._id_0079) && self._id_0079 == 4) {
        var_23 = _id_04CA::_id_461D(self._id_0079);

        if(var_23 == "specialty_class_expeditionary_grandmaster" || var_23 == "specialty_class_expeditionary_master") {
          var_0._id_69AD.guid = 17301504;
          var_4 = 1;
        }
      }

      if(!var_4) {
        var_0._id_69AD.guid = 17203200;
        var_2 = 1;
      }
    } else if(isDefined(self._id_0079) && self._id_0079 == 4) {
      var_23 = _id_04CA::_id_461D(self._id_0079);

      if(var_23 == "specialty_class_expeditionary_grandmaster" || var_23 == "specialty_class_expeditionary_master") {
        var_0._id_69AD.guid = 17297408;
        var_3 = 1;
      }
    }
  }

  self._id_5DF8 = var_0._id_69AD;
  var_24 = maps\mp\_utility::_id_44CD(var_0._id_69AD);
  self setoffhandsecondaryclass(var_24);
  _id_479F(var_24);
  self._id_60A0 = 1;

  if(isDefined(var_0._id_69AC) && var_0._id_69AC > 0) {
    if(var_0._id_69AC == 2)
      maps\mp\_utility::giveperk("specialty_twoextratactical");
    else
      maps\mp\_utility::giveperk("specialty_extratactical");

    var_19 = self getweaponammoclip(var_24);
    self setweaponammoclip(var_24, var_19 + var_0._id_69AC);
    self._id_60A0 = self._id_60A0 + var_0._id_69AC;
  }

  if(var_2 || var_4 || var_3)
    var_0._id_69AD.guid = 16809984;

  if(var_5)
    var_0._id_69AD.guid = 17133568;

  self.primaryweapon = var_20;
  self._id_835A = var_16;
  self._id_60FA = var_15;

  if(var_0._id_23D9) {
    self setweaponammoclip(self.primaryweapon, 0);
    self setweaponammostock(self.primaryweapon, 0);
  }

  self._id_57D6 = weaponclass(self.primaryweapon) == "sniper";
  maps\mp\_utility::_id_861B();
  var_25 = var_0._id_5A62;
  var_26 = var_0._id_5A63;
  var_27 = var_0._id_5A64;
  var_28 = var_0._id_5A65;

  if(!maps\mp\_utility::_id_551F()) {
    var_29 = 0;
    var_30 = 0;
    var_31 = 0;
    var_32 = 0;
    var_33 = 0;

    if(!isDefined(level.dlc2wardogfightactive) || !level.dlc2wardogfightactive) {
      if(maps\mp\_utility::_id_579B()) {
        var_25 = 0;
        var_26 = 0;
        var_27 = 0;
        var_28 = 0;
      }

      if(isDefined(self._id_6F65) && isDefined(self._id_6F65["specialty_sessionProgressionA"]) && self._id_6F65["specialty_sessionProgressionA"])
        var_29 = 1;

      self.pers["hasSerumBasicTraining"] = var_29;

      if(var_29) {
        var_28 = var_27;
        var_27 = var_26;
        var_26 = var_25;
        var_25 = 69206048;
      }

      if(isDefined(self._id_6F65) && isDefined(self._id_6F65["specialty_perkstreaks"]) && self._id_6F65["specialty_perkstreaks"])
        var_30 = 1;

      self.pers["hasSpecialistPerkStreak"] = var_30;

      if(var_30) {
        var_25 = 0;
        var_26 = 0;
        var_27 = 0;
        var_28 = 0;
      }

      if(isDefined(self._id_6F65) && isDefined(self._id_6F65["specialty_supportstreaks"]) && self._id_6F65["specialty_supportstreaks"])
        var_31 = 1;

      self.pers["hasSupportStreaks"] = var_31;

      if(isDefined(self._id_6F65) && isDefined(self._id_6F65["specialty_killstreaks"]) && self._id_6F65["specialty_killstreaks"])
        var_32 = 1;

      self.pers["hasKillStreaks"] = var_32;

      if(isDefined(self._id_6F65) && isDefined(self._id_6F65["specialty_fourthstreak"]) && self._id_6F65["specialty_fourthstreak"])
        var_33 = 1;

      self.pers["hasFourthStreak"] = var_33;

      if(!var_33 && !var_29)
        var_28 = 0;
    }

    _id_86B9(var_25, var_26, var_27, var_28, var_0._id_1E26, var_0._id_7615, var_0._id_2669, var_0._id_56FE, var_0._id_985A);
    var_34 = 0;

    if(var_9 != var_31 || var_10 != var_32 || var_11 != var_33 || var_8 != var_30 || var_7 != var_29)
      var_34 = 1;

    if(var_0._id_59DA && var_7 == var_29)
      var_34 = 0;
    else if(!maps\mp\_utility::_id_0F5C())
      var_34 = 0;
    else if(_func_1EF(self))
      var_34 = 0;
    else if(!isDefined(self.lastclass))
      var_34 = 0;
    else if(!isbot(self) && self.lastclass == self.class && !(isDefined(self._id_3FC4) && self._id_3FC4))
      var_34 = 0;
    else if(isbot(self) && self._id_1A56 == self._id_1994)
      var_34 = 0;

    var_0._id_59DA = !var_34;

    if(var_34) {
      if(maps\mp\_utility::wasonlyround() || self.lastclass != "") {
        var_35 = [];
        var_36 = 0;
        var_37 = self.pers["killstreaks"];
        var_38 = 0;

        if(var_38) {
          if(var_37.size > 5) {
            for(var_14 = 5; var_14 < var_37.size; var_14++) {
              var_35[var_36] = var_37[var_14]._id_944C;
              var_36++;
            }
          }

          if(var_37.size) {
            for(var_14 = 1; var_14 < 5; var_14++) {
              if(isDefined(var_37[var_14]) && isDefined(var_37[var_14]._id_944C) && var_37[var_14]._id_944C != "basic_training_serum" && var_37[var_14]._id_13AF) {
                var_35[var_36] = var_37[var_14]._id_944C;
                var_36++;
              }
            }
          }
        }

        self notify("givingLoadout");
        var_39 = var_9 != var_31 || var_10 != var_32 || var_11 != var_33 || var_8 != var_30;

        if(!var_39 && var_7 != var_29)
          _id_051E::transferkillstreaks();
        else
          _id_051E::_id_2400(var_39);

        for(var_14 = 0; var_14 < var_35.size; var_14++)
          _id_051E::_id_478D(var_35[var_14], undefined, undefined, undefined);
      }
    }

    self _meth_82FF("ui_killstreak_scorestreak_switch", var_10 != var_32 || var_8 != var_30);
    self._id_5DF6 = var_0._id_59DA;
  }

  if(isDefined(self.lastclass) && self.lastclass != "" && self.lastclass != self.class)
    self notify("changed_class");

  self.pers["lastClass"] = self.class;
  self.lastclass = self.class;

  if(isDefined(self._id_3FC5)) {
    self.pers["class"] = self._id_3FC5;
    self.pers["lastClass"] = self._id_3FC5;
    self.class = self._id_3FC5;

    if(!isDefined(self._id_3FC4) || var_0._id_59DA)
      self.lastclass = self._id_3FC5;

    self._id_3FC5 = undefined;
  }

  self._id_3FC4 = undefined;
  var_40 = self.team;

  if(common_scripts\utility::_id_562E(level._id_9565)) {
    if(game["switchedsides"])
      var_40 = maps\mp\_utility::getotherteam(var_40);
  }

  if((!isDefined(self._id_5097) || !self._id_5097) && (!isDefined(level._id_585D) || !level._id_585D)) {
    if(_func_367())
      self._id_267E = _id_1F99(common_scripts\utility::_id_46AF());
    else if(!isDefined(self._id_267E) || self._id_267E.size == 0) {
      if(maps\mp\_utility::_id_761E())
        self._id_267E = _id_0510::_id_4636();
      else if(isbot(self)) {
        if(var_40 == "axis") {
          if(isDefined(self._id_0079) && self._id_0079 != 5)
            var_41 = _func_333(self._id_0079, 0);
          else
            var_41 = _func_332();

          self._id_147C = var_41;
          self._id_267E = var_41;
        } else {
          if(isDefined(self._id_0079) && self._id_0079 != 5)
            var_41 = _func_333(self._id_0079, 1);
          else
            var_41 = _func_333(0, 1);

          self._id_267E = var_41;
        }

        _id_21B9();
      } else if(isPlayer(self)) {
        if(isDefined(self._id_0079) && self._id_0079 != 5) {
          if(!_func_3AF() && !maps\mp\_utility::_id_56B1()) {
            var_42 = _id_1F93(self._id_0079, var_40);
            self._id_267E = _id_1F97(var_42);
            self setplayerdata(common_scripts\utility::_id_46A9(), "activeCostume", var_42);
          } else
            self._id_267E = _func_333(self._id_0079, var_40 == "allies");

          var_41 = _id_1F95();
          self._id_267E[1] = var_41[1];
        } else if(var_40 == "axis") {
          if(!isDefined(self._id_147C))
            self._id_147C = _id_0510::_id_4430();

          self._id_267E = self._id_147C;
          var_41 = _id_1F95();
          self._id_267E[1] = var_41[1];
        } else
          self._id_267E = _id_1F95();

        _id_21B9();
      } else if(_func_1EF(self) && self._id_0A4B == "player")
        self._id_267E = _id_0510::_id_448C();
    } else if(isPlayer(self) && !_func_0C1(self)) {
      if(isDefined(self._id_0079) && self._id_0079 != 5) {
        if(!_func_3AF() && !maps\mp\_utility::_id_56B1()) {
          var_42 = _id_1F93(self._id_0079, var_40);
          self._id_267E = _id_1F97(var_42);
          self setplayerdata(common_scripts\utility::_id_46A9(), "activeCostume", var_42);
        } else
          self._id_267E = _func_333(self._id_0079, var_40 == "allies");

        var_41 = _id_1F95();
        self._id_267E[1] = var_41[1];
      } else if(var_40 == "axis") {
        if(!isDefined(self._id_147C))
          self._id_147C = _id_0510::_id_4430();

        self._id_267E = self._id_147C;
        var_41 = _id_1F95();
        self._id_267E[1] = var_41[1];
      } else
        self._id_267E = _id_1F95();

      _id_21B9();
    }

    if(!_func_1EF(self) && !_id_0510::_id_A27D(self._id_267E, var_40)) {
      if(isDefined(self._id_83F4) && _id_0510::_id_A27D(self._id_83F4, var_40))
        self._id_267E = self._id_83F4;
      else {
        if(var_40 == "axis")
          self._id_267E = _id_0510::_id_4430();
        else
          self._id_267E = _id_0510::_id_448C();

        self._id_83F4 = self._id_267E;
      }
    }

    _id_5EA3();
    _id_0510::_id_7427(self.pers["primaryWeapon"], maps\mp\_utility::_id_4431(var_16));
  }

  if(maps\mp\_utility::_hasperk("specialty_extraammo")) {
    if(var_20 != "none")
      self givemaxammo(var_20);

    if(var_16 != "none" && maps\mp\_utility::getweaponclass(var_16) != "weapon_projectile")
      self givemaxammo(var_16);
  }

  _id_0513::_id_A13B();
  self.pers["altModeActive"] = 0;
  self.pers["dragonBreathActive"] = 0;
  self.pers["rifleGrenadeActive"] = 0;
  _id_052D::_id_1E15();
  _id_477C(var_0);

  if(!maps\mp\gametypes\_hud_util::_id_5527())
    thread _id_04CB::_id_8622(self._id_0079, var_20);

  self notify("changed_kit");
  self notify("applyLoadout");
  level notify("broadcasterLoadoutChanged", self.clientid);
}

_id_449A(var_0) {
  var_1 = [1, 52, 24, 51, 51, 44, 44, 51, 52, 51];
  return var_1[var_0];
}

_id_4585(var_0) {
  var_1 = var_0._id_509D;

  if(isDefined(var_0._id_509D) && var_1)
    return "none";
  else {
    var_2 = "shovel_mp";
    var_3 = var_0._id_60FC;

    if(isDefined(var_3)) {
      var_4 = maps\mp\_utility::_id_4737(var_3);

      if(var_4 != "none")
        var_2 = var_4;
    }

    return var_2;
  }
}

_id_5EA3() {
  if(_func_367() || _func_1EF(self)) {
    return;
  }
  if(!isDefined(self._id_2684)) {
    var_0 = _id_1F98("head");
    var_1 = _id_1F96();
    var_2 = _id_1F9A("shirt", var_1);
    var_3 = _id_1F9A("pants", var_1);
    var_4 = _id_1F9A("eyewear", var_1);
    var_5 = _id_1F9A("hat", var_1);
    var_6 = _id_1F9A("gear", var_1);
    setmatchdata("players", self.clientid, "costume", "head", var_0);
    setmatchdata("players", self.clientid, "costume", "shirt", var_2);
    setmatchdata("players", self.clientid, "costume", "pants", var_3);
    setmatchdata("players", self.clientid, "costume", "eyewear", var_4);
    setmatchdata("players", self.clientid, "costume", "hat", var_5);
    setmatchdata("players", self.clientid, "costume", "gear", var_6);
    self._id_2684 = 1;
  }
}

_id_4773(var_0, var_1, var_2, var_3) {
  _id_4790(var_0, var_1, var_2, var_3);
  _id_0F35();
}

_id_4774() {
  _id_4791();
  _id_0F35();
}

_id_4781() {
  self._id_907E = 0;

  if(!maps\mp\_utility::_hasperk("specialty_blindeye") && (!isDefined(self._id_1444) || self._id_1444 > 0))
    thread _id_052D::_id_4778();

  if(maps\mp\_utility::_hasperk("specialty_class_fightorfight"))
    thread _id_052C::_id_A060();
}

_id_7B3D() {
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers["validationInfractions"]))
    self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
}

_id_05FF() {
  self._id_3EF6 = undefined;
  self._id_14EA = undefined;
  self.headmodel = undefined;
  self detachall();
}

_id_479F(var_0) {
  var_1 = level._id_47C4;

  if(!isDefined(var_1))
    var_1 = maps\mp\_utility::_giveweapon;

  switch (var_0) {
    case "specialty_null":
    case "none":
      break;
    case "frag_grenade_german_mp":
    case "explosive_gel_mp":
    case "throwingknife_mp":
    case "c4_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
    case "claymore_mp":
      maps\mp\_utility::giveperk(var_0);
      break;
    case "role_explosive_rat_mp":
    case "role_barbed_wire_mp":
    case "signal_flare_expeditionary_mp":
    case "signal_flare_mp":
    case "decoy_device_mp":
    case "trophy_mp":
    case "tabun_grenade_mp":
    case "thermite_mp":
    case "bouncingbetty_mp":
    case "contact_grenade_mp":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "stun_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "s2_tactical_insertion_cavalry_mp":
    case "s2_tactical_insertion_device_mp":
    case "portable_radar_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
      self[[var_1]](var_0);
      break;
    default:
      if(isDefined(level._id_585D) && level._id_585D) {
        self[[var_1]](var_0, undefined, undefined, undefined);
        return;
      }

      break;
  }
}

_id_95EE(var_0) {
  switch (var_0) {
    case "specialty_null":
    case "none":
      break;
    case "s2_tactical_insertion_device_mp":
    case "frag_grenade_german_mp":
    case "explosive_gel_mp":
    case "throwingknife_mp":
    case "c4_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
    case "claymore_mp":
      maps\mp\_utility::_id_0735(var_0);
      break;
    case "role_explosive_rat_mp":
    case "role_barbed_wire_mp":
    case "signal_flare_expeditionary_mp":
    case "signal_flare_mp":
    case "decoy_device_mp":
    case "trophy_mp":
    case "tabun_grenade_mp":
    case "thermite_mp":
    case "bouncingbetty_mp":
    case "contact_grenade_mp":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "stun_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "s2_tactical_insertion_cavalry_mp":
    case "portable_radar_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
      self takeweapon(var_0);
      break;
    default:
  }
}

_id_5DF1(var_0, var_1) {
  for(var_2 = 0; var_2 < 9; var_2++)
    var_1[var_2] = _id_052D::_id_A277(var_2, var_1[var_2]);

  self._id_5DFA = var_1;
  self._id_5DF5 = var_0;

  for(var_2 = 0; var_2 < 9; var_2++) {
    if(var_1[var_2] != 0)
      maps\mp\_utility::_id_47A3(var_1[var_2], var_2);
  }
}

_id_0F0E(var_0) {
  foreach(var_2 in var_0) {
    if(maps\mp\_utility::_id_4429(var_2) == "rail" || var_2 == "zoomscope" || var_2 == "ironsights")
      return 1;
  }

  return 0;
}

_id_774F(var_0, var_1, var_2) {
  var_3 = var_1.size;

  if(var_3 > 1)
    var_1 = common_scripts\utility::alphabetize(var_1);

  var_4 = _func_060(var_0);
  var_5 = [];

  foreach(var_7 in var_1) {
    var_8 = 0;

    foreach(var_10 in var_4) {
      if(var_7 == var_10) {
        var_8 = 1;
        break;
      }
    }

    if(var_8) {
      var_5[var_5.size] = var_7;
      continue;
    }
  }

  return var_5;
}

_id_0F72(var_0, var_1) {
  if(isDefined(var_1) && _func_031(var_1) && var_1 != "none" && !common_scripts\utility::_id_0F79(var_0, var_1))
    var_0[var_0.size] = var_1;

  return var_0;
}

_id_4432(var_0) {
  var_1 = maps\mp\_utility::_id_452A(var_0);

  if(_func_315(var_1)) {
    var_2 = _func_312(var_1);
    var_3 = _func_311(var_2);
    return var_3;
  } else
    return var_0;
}

_id_1D66(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!isDefined(var_0) || var_0 == "none" || var_0 == "")
    return "none";

  if(isDefined(var_1) && _func_30D(var_1))
    var_1 = maps\mp\_utility::_id_452B(var_1);

  if(isDefined(var_2) && _func_30D(var_2))
    var_2 = maps\mp\_utility::_id_452B(var_2);

  if(isDefined(var_3) && _func_30D(var_3))
    var_3 = maps\mp\_utility::_id_452B(var_3);

  if(isDefined(var_4) && _func_30D(var_4))
    var_4 = maps\mp\_utility::_id_452B(var_4);

  if(isDefined(var_5) && _func_30D(var_5))
    var_5 = maps\mp\_utility::_id_452B(var_5);

  if(isDefined(var_6) && _func_30D(var_6))
    var_6 = maps\mp\_utility::_id_452B(var_6);

  if(isDefined(var_10) && var_10 != 0 && maps\mp\_utility::_id_4429(var_1) != "scope" && maps\mp\_utility::_id_4429(var_2) != "scope" && maps\mp\_utility::_id_4429(var_3) != "scope" && maps\mp\_utility::_id_4429(var_4) != "scope" && maps\mp\_utility::_id_4429(var_5) != "scope" && maps\mp\_utility::_id_4429(var_6) != "scope")
    var_10 = 0;

  var_1 = maps\mp\_utility::_id_1151(var_1, var_0);
  var_2 = maps\mp\_utility::_id_1151(var_2, var_0);
  var_3 = maps\mp\_utility::_id_1151(var_3, var_0);
  var_4 = maps\mp\_utility::_id_1151(var_4, var_0);
  var_5 = maps\mp\_utility::_id_1151(var_5, var_0);
  var_6 = maps\mp\_utility::_id_1151(var_6, var_0);
  var_14 = "";
  var_15 = var_0;
  var_16 = var_0.size;
  var_14 = var_0;
  var_17 = [];
  var_17 = _id_0F72(var_17, var_1);
  var_17 = _id_0F72(var_17, var_2);
  var_17 = _id_0F72(var_17, var_3);
  var_17 = _id_0F72(var_17, var_4);
  var_17 = _id_0F72(var_17, var_5);
  var_17 = _id_0F72(var_17, var_6);

  if(var_15 != "none" && isDefined(var_12) && isDefined(var_13) && var_13 != 5) {
    var_18 = _id_04CB::_id_440E(var_12, var_13, var_15, 0, 0, var_17);

    foreach(var_20 in var_18)
    var_17 = _id_0F72(var_17, var_20);
  }

  var_17 = _id_774F(var_15, var_17, var_0);

  if(isDefined(var_17[0]) && var_17[0] == "vzscope")
    var_17[0] = var_14 + "scopevz";
  else if(isDefined(var_17[1]) && var_17[1] == "vzscope")
    var_17[1] = var_14 + "scopevz";
  else if(isDefined(var_17[2]) && var_17[2] == "vzscope")
    var_17[2] = var_14 + "scopevz";
  else if(isDefined(var_17[3]) && var_17[3] == "vzscope")
    var_17[3] = var_14 + "scopevz";
  else if(isDefined(var_17[4]) && var_17[4] == "vzscope")
    var_17[4] = var_14 + "scopevz";
  else if(isDefined(var_17[5]) && var_17[5] == "vzscope")
    var_17[5] = var_14 + "scopevz";

  if(isDefined(var_17.size) && var_17.size) {
    var_22 = 0;

    while(var_22 < var_17.size) {
      if(isDefined(var_17[var_22 + 1]) && common_scripts\utility::_id_55AF(var_17[var_22], var_17[var_22 + 1])) {
        var_23 = var_17[var_22];
        var_17[var_22] = var_17[var_22 + 1];
        var_17[var_22 + 1] = var_23;
        var_22 = 0;
        continue;
      }

      var_22++;
    }
  }

  foreach(var_25 in var_17)
  var_15 = var_15 + ("+" + var_25);

  var_15 = _id_1D68(var_15, var_7);
  var_15 = _id_1D67(var_15, var_8, var_9);
  var_15 = _id_1D6A(var_15, var_10);
  var_15 = _id_1D69(var_15, var_11);
  return var_15;
}

_id_0F1E(var_0, var_1) {
  if(isDefined(var_1) && var_1.size)
    return var_0 + "+" + var_1;

  return var_0;
}

_id_4447(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = int(tablelookup("mp/camoTable.csv", 1, var_0, 0));
  return var_1;
}

getcamo2indexfromitemref(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = int(tablelookup("mp/camo2Table.csv", 1, var_0, 0));
  return var_1;
}

_id_4448(var_0) {
  if(!isDefined(var_0) || var_0 == 0) {
    return;
  }
  var_1 = _id_4446(var_0);
  var_2 = tablelookup("mp/camoTable.csv", 0, var_1, 1);
  return var_2;
}

_id_4446(var_0) {
  if(!isDefined(var_0) || var_0 == 0)
    return 0;

  var_1 = _id_4447(_func_311(var_0));
  return var_1;
}

getcamo2indexfromguid(var_0) {
  if(!isDefined(var_0) || var_0 == 0)
    return 0;

  var_1 = getcamo2indexfromitemref(_func_311(var_0));
  return var_1;
}

_id_A9EF(var_0) {
  if(!isDefined(var_0) || var_0 == 0)
    return "";

  return "cond" + var_0;
}

_id_1D68(var_0, var_1) {
  var_0 = _id_0F1E(var_0, _id_A9EF(var_1));
  return var_0;
}

_id_A9EC(var_0, var_1) {
  var_2 = "";

  if(isDefined(var_0)) {
    var_3 = isDefined(var_1) && var_1 > 0;

    if(var_0 > 0 || var_3) {
      var_2 = "camo";

      if(var_0 < 100)
        var_2 = var_2 + "0";

      if(var_0 < 10)
        var_2 = var_2 + "0";

      var_2 = var_2 + var_0;

      if(var_3) {
        if(var_1 < 100)
          var_2 = var_2 + "0";

        if(var_1 < 10)
          var_2 = var_2 + "0";

        var_2 = var_2 + var_1;
      }
    }
  }

  return var_2;
}

_id_A9EE(var_0, var_1) {
  var_2 = _id_A9EC(_id_4447(var_0), getcamo2indexfromitemref(var_1));
  return var_2;
}

_id_A9ED(var_0, var_1) {
  var_2 = _id_A9EC(_id_4446(var_0), getcamo2indexfromguid(var_1));
  return var_2;
}

_id_1D67(var_0, var_1, var_2) {
  var_3 = _id_0F1E(var_0, _id_A9ED(var_1, var_2));
  return var_3;
}

_id_4666(var_0) {
  var_1 = _func_311(var_0);
  var_2 = int(tablelookup("mp/reticleTable.csv", 1, var_1, 9));
  return var_2;
}

_id_A9F1(var_0) {
  var_1 = "";

  if(!isDefined(var_0) || var_0 <= 0)
    return var_1;

  var_2 = _id_4666(var_0);

  if(isDefined(var_2) && var_2 > 0) {
    var_1 = "scope";

    if(var_2 < 100)
      var_1 = var_1 + "0";

    if(var_2 < 10)
      var_1 = var_1 + "0";

    var_1 = var_1 + var_2;
  }

  return var_1;
}

_id_1D6A(var_0, var_1) {
  var_2 = _id_0F1E(var_0, _id_A9F1(var_1));
  return var_2;
}

_id_A9F0(var_0) {
  if(!isDefined(var_0) || var_0 == 0)
    return "";

  var_1 = "cust" + var_0;
  return var_1;
}

_id_1D69(var_0, var_1) {
  var_2 = _id_0F1E(var_0, _id_A9F0(var_1));
  return var_2;
}

_id_86B9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!maps\mp\_utility::_id_0F5C()) {
    return;
  }
  self.killstreaks = [];
  self._id_5A66 = [];
  var_9 = [];
  var_10 = [var_0, var_1, var_2, var_3];

  foreach(var_12 in var_10) {
    if(isDefined(var_12) && var_12 != 0) {
      var_13 = _func_311(var_12);
      var_14 = _id_051E::_id_46B4(var_13);
      var_15 = 0;

      for(var_15 = 0; var_15 < var_9.size; var_15++) {
        if(var_9[var_15].value == var_14) {
          var_14++;
          continue;
        }

        if(var_14 < var_9[var_15].value) {
          break;
        }
      }

      var_9[var_9.size] = spawnStruct();

      for(var_16 = var_9.size - 2; var_16 >= var_15; var_16--) {
        var_9[var_16 + 1].name = var_9[var_16].name;
        var_9[var_16 + 1].guid = var_9[var_16].guid;
        var_9[var_16 + 1].value = var_9[var_16].value;
      }

      var_9[var_15].name = var_13;
      var_9[var_15].guid = var_12;
      var_9[var_15].value = var_14;
    }
  }

  for(var_18 = 0; var_18 < var_9.size; var_18++) {
    self.killstreaks[var_18] = var_9[var_18].name;
    self._id_5A66[var_18] = var_9[var_18].guid;
  }
}

replenishloadout() {
  var_0 = self.pers["team"];
  var_1 = self.pers["class"];
  var_2 = self getweaponlistall();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    self givemaxammo(var_4);
    self setweaponammoclip(var_4, 9999);

    if(var_4 == "claymore_mp" || var_4 == "claymore_detonator_mp")
      self setweaponammostock(var_4, 2);
  }

  if(self getammocount(level.classgrenades[var_1]["primary"]["type"]) < level.classgrenades[var_1]["primary"]["count"])
    self setweaponammoclip(level.classgrenades[var_1]["primary"]["type"], level.classgrenades[var_1]["primary"]["count"]);

  if(self getammocount(level.classgrenades[var_1]["secondary"]["type"]) < level.classgrenades[var_1]["secondary"]["count"])
    self setweaponammoclip(level.classgrenades[var_1]["secondary"]["type"], level.classgrenades[var_1]["secondary"]["count"]);
}

onplayerconnecting() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["class"]))
      var_0.pers["class"] = "";

    if(!isDefined(var_0.pers["lastClass"]))
      var_0.pers["lastClass"] = "";

    var_0.class = var_0.pers["class"];
    var_0.lastclass = var_0.pers["lastClass"];
    var_0.detectexplosives = 0;
    var_0.bombsquadicons = [];
    var_0._id_1906 = [];
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

_id_10E3() {
  if(!isDefined(level._id_7618)) {
    level._id_7618 = [];
    level._id_7619 = [];
    var_0 = _func_27B(level._id_761A);

    for(var_1 = 1; var_1 < var_0; var_1++) {
      var_2 = _func_1AE(level._id_761A, 0, var_1);

      if(isDefined(level._id_7618[var_2])) {
        level._id_7618[var_2][level._id_7618[var_2].size] = var_1 - 1;
        continue;
      }

      level._id_7618[var_2][0] = var_1 - 1;
    }

    var_3 = getarraykeys(level._id_7618);
    var_3 = common_scripts\utility::alphabetize(var_3);

    for(var_1 = 0; var_1 < var_3.size; var_1++)
      level._id_7619[var_3[var_1]] = var_1;
  }

  self.pers["practiceRoundClasses"] = [];

  foreach(var_2, var_5 in level._id_7618) {
    var_6 = 0;

    if(isDefined(level._id_7619[var_2]))
      var_6 = level._id_7619[var_2];

    var_7 = 0;
    var_8 = _func_0A4(0, var_5.size);

    if(isDefined(var_5[var_8]))
      var_7 = var_5[var_8];

    self.pers["practiceRoundClasses"][var_6] = var_7;
    self setplayerdata(common_scripts\utility::_id_46AE(), "practiceRoundClassMap", var_6, self.pers["practiceRoundClasses"][var_6]);
  }
}

_id_4635(var_0) {
  return self.pers["practiceRoundClasses"][var_0];
}

_id_5E0A(var_0) {
  if(!maps\mp\_utility::_id_761E())
    return 0;

  var_1 = self.class;
  var_2 = maps\mp\_utility::getclassindex(var_1);

  if(!isDefined(var_1) || !isDefined(var_2))
    return 0;

  var_3 = 1;

  if(var_2 == -1) {
    var_1 = self.pers["copyCatLoadout"]["className"];
    var_2 = maps\mp\_utility::getclassindex(var_1);

    if(issubstr(var_1, "practice")) {
      var_2 = self.pers["copyCatLoadout"]["practiceClassNum"];
      var_3 = 0;
    }
  } else if(issubstr(var_1, "practice")) {
    var_2 = self.pers["practiceRoundClasses"][var_2];
    var_3 = 0;
  } else if(var_1 == "callback")
    return 1;

  var_4 = var_0.class;
  var_5 = maps\mp\_utility::getclassindex(var_4);

  if(!isDefined(var_4) || !isDefined(var_5))
    return 0;

  var_6 = 1;

  if(var_5 == -1) {
    var_4 = var_0.pers["copyCatLoadout"]["className"];
    var_5 = maps\mp\_utility::getclassindex(var_4);

    if(issubstr(var_4, "practice")) {
      var_5 = var_0.pers["copyCatLoadout"]["practiceClassNum"];
      var_6 = 0;
    }
  } else if(issubstr(var_4, "practice")) {
    var_5 = var_0.pers["practiceRoundClasses"][var_5];
    var_6 = 0;
  } else if(var_4 == "callback")
    return 1;

  return var_2 != var_5 || var_3 != var_6;
}

_id_8657(var_0) {
  if(!maps\mp\_utility::_id_761E()) {
    return;
  }
  self.class = "copycat";
  self.pers["class"] = "copycat";
  var_1 = var_0 cloneloadout();
  self.pers["copyCatLoadout"] = var_1;
  self.pers["copyCatLoadout"]["inUse"] = 1;
}

_id_23DC() {
  self.pers["copyCatLoadout"]["inUse"] = 0;
}

isvalidprimary(var_0, var_1) {
  var_2 = var_0;

  if(_func_30D(var_0))
    var_2 = maps\mp\_utility::_id_452B(var_0);

  if(maps\mp\_utility::_id_5856(var_2))
    var_2 = _id_4432(var_2);

  switch (var_2) {
    case "blunderbuss_mp":
    case "walther_mp":
    case "winchester1897_mp":
    case "chatelleroult_mp":
    case "lad_mp":
    case "rpd_mp":
    case "vmg1927_mp":
    case "mg81_mp":
    case "mg15_mp":
    case "m1919_mp":
    case "breda30_mp":
    case "bren_mp":
    case "mg42_mp":
    case "lewis_mp":
    case "erma_mp":
    case "tokyo_mp":
    case "m2hyde_mp":
    case "ribeyrolles_mp":
    case "emp44_mp":
    case "blyskawica_mp":
    case "bechowiec_mp":
    case "austen_mp":
    case "zk383_mp":
    case "nambu_mp":
    case "mas38_mp":
    case "sterling_mp":
    case "type100_mp":
    case "ppsh41_mp":
    case "mp28_mp":
    case "sten_mp":
    case "greasegun_mp":
    case "beretta_mp":
    case "thompson_mp":
    case "mp40_mp":
    case "grofuss_mp":
    case "wimmer_mp":
    case "charlton_mp":
    case "sudaev_mp":
    case "avs36_mp":
    case "federov_mp":
    case "kgm21_mp":
    case "m2carbine_mp":
    case "m1935_mp":
    case "bal27_mp":
    case "bar_mp":
    case "volk_mp":
    case "stg44_mp":
    case "fg42_mp":
    case "m1941_mp":
    case "type5_mp":
    case "wz35_mp":
    case "sdk_mp":
    case "carcano_mp":
    case "delisle_mp":
    case "ptrs41_mp":
    case "mosin_mp":
    case "mas36_mp":
    case "leveraction_mp":
    case "karabin_mp":
    case "leeenfield_mp":
    case "arisaka_mp":
    case "springfield_mp":
    case "riotshield_mp":
    case "g43_mp":
    case "kar98_mp":
    case "model21_mp":
    case "svt40_mp":
    case "m30_mp":
    case "m1a1_mp":
    case "m1garand_mp":
    case "none":
      return 1;
    case "sword_mp":
    case "hammer_mp":
    case "sickle_mp":
    case "helmet_mp":
    case "axe_mp":
    case "dagger_mp":
    case "baseballbat_mp":
    case "trenchknife_mp":
    case "combatknife_mp":
    case "icepick_mp":
    case "shovel_mp":
      return isDefined(var_1) && var_1;
    default:
      _id_7B3D();
      return 0;
  }
}

isvalidsecondary(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 && isvalidprimary(var_0))
    return 1;

  var_3 = var_0;

  if(_func_30D(var_0))
    var_3 = maps\mp\_utility::_id_452B(var_0);

  if(maps\mp\_utility::_id_5856(var_3))
    var_3 = _id_4432(var_3);

  switch (var_3) {
    case "boxing_gloves_mp":
    case "binoculars_mp":
    case "sword_mp":
    case "hammer_mp":
    case "sickle_mp":
    case "helmet_mp":
    case "axe_mp":
    case "dagger_mp":
    case "baseballbat_mp":
    case "trenchknife_mp":
    case "combatknife_mp":
    case "icepick_mp":
    case "shovel_mp":
    case "riotshield_mp":
    case "m712_mp":
    case "enfieldno2_mp":
    case "reich_mp":
    case "p38_mp":
    case "luger_mp":
    case "m1911_mp":
    case "none":
      return 1;
    case "teslagun_war_regular_mp":
    case "teslagunmtx_mp":
    case "piat_mp":
    case "panzerschreck_mp":
    case "bazooka_mp":
    case "rpg_mp":
    case "dp28_mp":
    case "teslagun_war_moon_mp":
      return isDefined(var_2) && var_2 || maps\mp\_utility::isdivisionsglobaloverhaulenabled();
    default:
      _id_7B3D();
      return 0;
  }
}

isvalidattachment(var_0, var_1, var_2) {
  var_3 = 0;
  var_2 = 0;
  var_4 = maps\mp\_utility::_id_452B(var_0);

  switch (var_4) {
    case "tribolt_dp28":
    case "fast_mag_dp28":
    case "fast_bolt_dp28":
    case "explosive_tips_dp28":
    case "tactical_knife":
    case "zk_alt":
    case "bipod_3":
    case "bipod_2":
    case "bipod_1":
    case "suppressor_zk383":
    case "suppressor_smg_axis_3":
    case "suppressor_smg_axis_2":
    case "suppressor_smg_axis_1":
    case "suppressor_smg_allies_3":
    case "suppressor_smg_allies_2":
    case "suppressor_smg_allies_1":
    case "suppressor_greasegun_3":
    case "suppressor_greasegun_2":
    case "suppressor_greasegun_1":
    case "dragon_breath_break_3":
    case "dragon_breath_break_2":
    case "dragon_breath_break_1":
    case "dragon_breath_magazine_3":
    case "dragon_breath_magazine_2":
    case "dragon_breath_magazine_1":
    case "dragon_breath_bolt_action_3":
    case "dragon_breath_bolt_action_2":
    case "dragon_breath_bolt_action_1":
    case "hold_breath_3":
    case "hold_breath_1":
    case "fast_ads_after_sprint":
    case "iron_sight_sniper_mosin":
    case "iron_sight_sniper":
    case "lens_sight_ribeyrolles":
    case "lens_sight_small":
    case "lens_sight":
    case "akimbo_fullauto":
    case "telescopic_sight_sdk":
    case "telescopic_sight_charlton":
    case "telescopic_sight_sudaev":
    case "telescopic_sight_federov":
    case "telescopic_sight_grofuss":
    case "telescopic_sight_wimmer":
    case "telescopic_sight_wz35":
    case "telescopic_sight_dp28":
    case "telescopic_sight_lad":
    case "telescopic_sight_rpd":
    case "telescopic_sight_avs36":
    case "telescopic_sight_leveraction":
    case "telescopic_sight_carcano":
    case "telescopic_sight_delisle":
    case "telescopic_sight_ptrs41":
    case "telescopic_sight_mosin":
    case "telescopic_sight_mas36":
    case "telescopic_sight_kgm21":
    case "telescopic_sight_chatelleroult":
    case "telescopic_sight_m2carbine":
    case "telescopic_sight_vmg1927":
    case "telescopic_sight_m1935":
    case "telescopic_sight_type99":
    case "telescopic_sight_m1919":
    case "telescopic_sight_bren":
    case "telescopic_sight_mg42":
    case "telescopic_sight_mg81":
    case "telescopic_sight_lewis":
    case "telescopic_sight_mg15":
    case "telescopic_sight_type38":
    case "telescopic_sight_fg42":
    case "telescopic_sight_springfield":
    case "telescopic_sight_enfield":
    case "telescopic_sight_kbsp1938":
    case "telescopic_sight_kar98k":
    case "telescopic_sight_m1941":
    case "telescopic_sight_type5":
    case "telescopic_sight_m1a1":
    case "telescopic_sight_volk":
    case "telescopic_sight_g43":
    case "telescopic_sight_stg44":
    case "telescopic_sight_svt40":
    case "telescopic_sight_bar":
    case "telescopic_sight_m1garand":
    case "telescopic_sight":
    case "suppressor_model21":
    case "suppressor_m30":
    case "suppressor_karabin":
    case "suppressor_leeenfield":
    case "suppressor_kar98":
    case "suppressor_springfield":
    case "suppressor_lmg_axis":
    case "suppressor_shotgun_axis":
    case "suppressor_rifle_axis":
    case "suppressor_axis":
    case "suppressor_lmg_allies":
    case "suppressor_shotgun_allies":
    case "suppressor_rifle_allies":
    case "suppressor_allies":
    case "reduced_sway":
    case "rapid_fire_shotgun_rechamber":
    case "rapid_fire_sniper_fastbolt":
    case "rapid_fire_sniper":
    case "rapid_fire_lmg":
    case "rapid_fire":
    case "hipfire_smg":
    case "hipfire":
    case "head_damage":
    case "grip":
    case "grenade_launcher_m1garand":
    case "grenade_launcher_axis":
    case "grenade_launcher_allies":
    case "fmj":
    case "fast_mag_shotgun_segmented":
    case "fast_mag":
    case "fast_ads_smg":
    case "fast_ads_lmg":
    case "fast_ads":
    case "extended_range_rifle":
    case "extended_range_smg":
    case "extended_range_shotgun":
    case "extended_range":
    case "extended_mag_m712":
    case "extended_mag_luger":
    case "extended_mag_m1911":
    case "extended_mag_fg42":
    case "extended_mag_type38":
    case "extended_mag_kbsp1938":
    case "extended_mag_kar98k":
    case "extended_mag_springfield":
    case "extended_mag_enfield":
    case "extended_mag_g43":
    case "extended_mag_svt40":
    case "extended_mag_volk":
    case "extended_mag_stg44":
    case "extended_mag_m1a1":
    case "extended_mag_m1941":
    case "extended_mag_m1garand":
    case "extended_mag_type5":
    case "extended_mag_bar":
    case "extended_mag_m1919":
    case "extended_mag_mg81":
    case "extended_mag_mg42":
    case "extended_mag_mg15":
    case "extended_mag_type99":
    case "extended_mag_bren":
    case "extended_mag_lewis":
    case "extended_mag_type100":
    case "extended_mag_ppsh41":
    case "extended_mag_beretta":
    case "extended_mag_mp40":
    case "extended_mag_mp28":
    case "extended_mag_greasegun":
    case "extended_mag_sten":
    case "extended_mag_thompson":
    case "extended_mag_1897":
    case "extended_mag":
    case "compensator_greasegun":
    case "compensator_sten":
    case "compensator_type100":
    case "compensator_ppsh41":
    case "compensator_thompson":
    case "compensator_beretta":
    case "compensator_mp40":
    case "compensator_mp28":
    case "bayonet_allies":
    case "bayonet_axis":
    case "bayonet_m1garand":
    case "aperture_sight_m2hyde":
    case "aperture_sight_charlton":
    case "aperture_sight_sudaev":
    case "aperture_sight_federov":
    case "aperture_sight_grofuss":
    case "aperture_sight_wimmer":
    case "aperture_sight_dp28":
    case "aperture_sight_lad":
    case "aperture_sight_rpd":
    case "aperture_sight_erma":
    case "aperture_sight_tokyo":
    case "aperture_sight_avs36":
    case "aperture_sight_emp44":
    case "aperture_sight_blyskawica":
    case "aperture_sight_bechowiec":
    case "aperture_sight_austen":
    case "aperture_sight_zk383":
    case "aperture_sight_kgm21":
    case "aperture_sight_chatelleroult":
    case "aperture_sight_ribeyrolles":
    case "aperture_sight_m2carbine":
    case "aperture_sight_vmg1927":
    case "aperture_sight_m1935":
    case "aperture_sight_mas38":
    case "aperture_sight_sterling":
    case "aperture_sight_nambu":
    case "aperture_sight_type99":
    case "aperture_sight_m30":
    case "aperture_sight_walther":
    case "aperture_sight_model21":
    case "aperture_sight_ppsh41":
    case "aperture_sight_beretta":
    case "aperture_sight_mp28":
    case "aperture_sight_type100":
    case "aperture_sight_sten":
    case "aperture_sight_thompson":
    case "aperture_sight_greasegun":
    case "aperture_sight_m1a1":
    case "aperture_sight_m1941":
    case "aperture_sight_type5":
    case "aperture_sight_volk":
    case "aperture_sight_g43":
    case "aperture_sight_stg44":
    case "aperture_sight_svt40":
    case "aperture_sight_mp40":
    case "aperture_sight_fg42":
    case "aperture_sight_m1garand":
    case "aperture_sight_bren":
    case "aperture_sight_m1919":
    case "aperture_sight_mg81":
    case "aperture_sight_mg42":
    case "aperture_sight_mg15":
    case "aperture_sight_lewis":
    case "aperture_sight_bar":
    case "aperture_sight_1897":
    case "aperture_sight":
    case "ads_move_speed_sniper":
    case "ads_move_speed_smg":
    case "ads_move_speed_shotgun":
    case "ads_move_speed_lmg":
    case "ads_move_speed":
    case "m30_rifle":
    case "grenade_launcher":
    case "suppressor":
    case "shield_charge":
    case "bayonet":
    case "akimbo":
      var_3 = 1;
      break;
    default:
      var_3 = 0;
      break;
  }

  var_5 = getsubstr(var_4, 2, 3);

  switch (var_5) {
    case "6":
    case "5":
    case "4":
    case "3":
    case "1":
    case "2":
      var_3 = 1;
      break;
  }

  if(var_3 && var_4 != "none") {
    var_6 = maps\mp\_utility::_id_452B(var_1);
    var_7 = maps\mp\_utility::_id_4723(var_6);
    var_3 = common_scripts\utility::_id_0F79(var_7, var_4);
  }

  if(!var_3 && var_2)
    _id_7B3D();

  return var_3;
}

_id_567C(var_0, var_1) {
  if(maps\mp\_utility::_id_56B1() || _func_3AF())
    return 1;

  var_2 = var_0;

  if(_func_30D(var_0))
    var_2 = maps\mp\_utility::_id_452B(var_0);

  var_3 = _id_4432(var_2);
  var_4 = var_3 + " " + var_1;

  if(!self isitemunlocked2(var_4))
    return 0;

  return 1;
}

_id_5821(var_0, var_1) {
  if(var_0 == 0)
    return 1;

  var_2 = _func_317(var_0);

  if(var_2 == 3 || var_2 == 2) {
    var_3 = _func_311(var_0);

    if(var_3 != "")
      return 1;
  }

  var_4 = _func_3BE(var_0);

  if(var_4 == 1 || var_4 == 4) {
    var_3 = _func_311(var_0);

    if(var_3 != "")
      return 1;
  }

  _id_7B3D();

  if(!isDefined(var_1) || !var_1) {}

  return 0;
}

_id_5838(var_0, var_1) {
  if(var_0 == 0)
    return 1;

  var_2 = _func_318(var_0);

  if(var_2 == 4) {
    var_3 = _func_311(var_0);

    if(var_3 != "")
      return 1;
  }

  var_4 = _func_3BE(var_0);

  if(var_4 == 2) {
    var_3 = _func_311(var_0);

    if(var_3 != "")
      return 1;
  }

  _id_7B3D();

  if(!isDefined(var_1) || !var_1) {}

  return 0;
}

_id_5824(var_0, var_1) {
  if(var_0 == 0)
    return 1;

  if(var_0 >= 1 && var_0 < 2)
    return 1;

  _id_7B3D();

  if(!isDefined(var_1) || !var_1) {}

  return 0;
}

_id_56A0(var_0, var_1) {
  if(maps\mp\_utility::_id_56B1() || _func_3AF())
    return 1;

  if(var_1 == 0)
    return 1;

  var_2 = maps\mp\_utility::_id_452B(var_0);
  var_3 = _id_4432(var_2);
  var_4 = maps\mp\_utility::_id_452B(var_1);
  var_5 = var_3 + " " + var_4;

  if(!self isitemunlocked2(var_5))
    return 0;

  return 1;
}

_id_5826(var_0, var_1, var_2) {
  if(var_1)
    return _id_5833(var_0, 0);

  if(isDefined(var_2) && var_2) {
    var_3 = _id_5833(var_0, 0);

    if(var_3)
      return 1;
  }

  switch (var_0) {
    case "role_explosive_rat_mp":
    case "role_barbed_wire_mp":
    case "signal_flare_expeditionary_mp":
    case "signal_flare_mp":
    case "decoy_device_mp":
    case "trophy_mp":
    case "tabun_grenade_mp":
    case "thermite_mp":
    case "bouncingbetty_mp":
    case "contact_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "s2_tactical_insertion_cavalry_mp":
    case "s2_tactical_insertion_device_mp":
    case "portable_radar_mp":
    case "frag_grenade_german_mp":
    case "explosive_gel_mp":
    case "throwingknife_mp":
    case "c4_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
    case "specialty_null":
    case "claymore_mp":
    case "none":
      return 1;
    default:
      if(isDefined(level._id_5827)) {
        if([[level._id_5827]](var_0))
          return 1;
      }

      _id_7B3D();
      return 0;
  }
}

_id_5682(var_0) {
  return var_0 == 0;
}

_id_5833(var_0, var_1) {
  if(var_1)
    return _id_5826(var_0, 0);

  switch (var_0) {
    case "exomute_equipment_mp":
    case "exohover_equipment_mp":
    case "fast_heal_mp":
    case "extra_health_mp":
    case "adrenaline_mp":
    case "exoshield_equipment_mp":
    case "exorepulsor_equipment_mp":
    case "exoslide_equipment_mp":
    case "exododge_equipment_mp":
    case "exoboost_equipment_mp":
    case "exoping_equipment_mp":
    case "exocloak_equipment_mp":
    case "role_explosive_rat_mp":
    case "role_barbed_wire_mp":
    case "signal_flare_expeditionary_mp":
    case "signal_flare_mp":
    case "decoy_device_mp":
    case "trophy_mp":
    case "tabun_grenade_mp":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "stun_grenade_mp":
    case "flash_grenade_mp":
    case "s2_tactical_insertion_cavalry_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
    case "specialty_null":
    case "none":
      return 1;
    default:
      if(isDefined(level._id_5834)) {
        if([[level._id_5834]](var_0))
          return 1;
      }

      _id_7B3D();
      return 0;
  }
}

_id_582D(var_0) {
  if(var_0 == 0)
    return 1;

  var_1 = _func_318(var_0);

  if(var_1 == 1) {
    var_2 = _func_311(var_0);

    if(var_2 != "")
      return 1;
  }

  _id_7B3D();
  return 0;
}

_id_7ECD() {
  return self getplayerdata(common_scripts\utility::_id_46A7(), "roleData", "roleId");
}

_id_7ECE() {
  return self getplayerdata(common_scripts\utility::_id_46A7(), "roleData", "slotId");
}

_id_4667(var_0, var_1) {
  var_2 = 0;

  if(var_1 == 0)
    var_2 = 4;
  else if(var_1 == 1)
    var_2 = 6;
  else {}

  return tablelookup("mp/roleTable.csv", 0, var_0, var_2);
}

_id_09A7(var_0) {
  if(!getdvarint("1936") || maps\mp\_utility::_id_551F()) {
    return;
  }
  if(!_func_1EF(self)) {
    if(isDefined(level._id_446F))
      var_0._id_7ED2 = self[[level._id_446F]]();
    else {
      var_0._id_7ECF = _id_7ECD();
      var_0.slot = _id_7ECE();
      var_0._id_7ED2 = _id_4667(var_0._id_7ECF, var_0.slot);
    }
  }
}

_id_477C(var_0) {
  if(!getdvarint("1936") || maps\mp\_utility::_id_551F()) {
    return;
  }
  self endon("disconnect");
  var_1 = level._id_47C4;

  if(!isDefined(var_1))
    var_1 = maps\mp\_utility::_giveweapon;

  if(isDefined(var_0._id_7ED2))
    self[[var_1]](var_0._id_7ED2);
}