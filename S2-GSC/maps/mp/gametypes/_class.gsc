/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_class.gsc
*********************************************/

func_00D5() {
  setdvarifuninitialized("spv_cavalryRiflemanPerk_enabled", 1);
  level.var_2321["class0"] = 0;
  level.var_2321["class1"] = 1;
  level.var_2321["class2"] = 2;
  level.var_2321["class3"] = 3;
  level.var_2321["class4"] = 4;
  level.var_2321["class5"] = 5;
  level.var_2321["class6"] = 6;
  level.var_2321["class7"] = 7;
  level.var_2321["class8"] = 8;
  level.var_2321["class9"] = 9;
  level.var_2321["class10"] = 10;
  level.var_2321["class11"] = 11;
  level.var_2321["class12"] = 12;
  level.var_2321["class13"] = 13;
  level.var_2321["class14"] = 14;
  level.var_2321["custom1"] = 0;
  level.var_2321["custom2"] = 1;
  level.var_2321["custom3"] = 2;
  level.var_2321["custom4"] = 3;
  level.var_2321["custom5"] = 4;
  level.var_2321["custom6"] = 5;
  level.var_2321["custom7"] = 6;
  level.var_2321["custom8"] = 7;
  level.var_2321["custom9"] = 8;
  level.var_2321["custom10"] = 9;
  level.var_2321["custom11"] = 10;
  level.var_2321["custom12"] = 11;
  level.var_2321["custom13"] = 12;
  level.var_2321["custom14"] = 13;
  level.var_2321["custom15"] = 14;
  level.var_2321["custom16"] = 15;
  level.var_2321["custom17"] = 16;
  level.var_2321["custom18"] = 17;
  level.var_2321["custom19"] = 18;
  level.var_2321["custom20"] = 19;
  level.var_2321["custom21"] = 20;
  level.var_2321["custom22"] = 21;
  level.var_2321["custom23"] = 22;
  level.var_2321["custom24"] = 23;
  level.var_2321["custom25"] = 24;
  level.var_2321["custom26"] = 25;
  level.var_2321["custom27"] = 26;
  level.var_2321["custom28"] = 27;
  level.var_2321["custom29"] = 28;
  level.var_2321["custom30"] = 29;
  level.var_2321["custom31"] = 30;
  level.var_2321["custom32"] = 31;
  level.var_2321["custom33"] = 32;
  level.var_2321["custom34"] = 33;
  level.var_2321["custom35"] = 34;
  level.var_2321["custom36"] = 35;
  level.var_2321["custom37"] = 36;
  level.var_2321["custom38"] = 37;
  level.var_2321["custom39"] = 38;
  level.var_2321["custom40"] = 39;
  level.var_2321["custom41"] = 40;
  level.var_2321["custom42"] = 41;
  level.var_2321["custom43"] = 42;
  level.var_2321["custom44"] = 43;
  level.var_2321["custom45"] = 44;
  level.var_2321["custom46"] = 45;
  level.var_2321["custom47"] = 46;
  level.var_2321["custom48"] = 47;
  level.var_2321["custom49"] = 48;
  level.var_2321["custom50"] = 49;
  level.var_2321["custom51"] = 50;
  level.var_2321["custom52"] = 51;
  level.var_2321["custom53"] = 52;
  level.var_2321["custom54"] = 53;
  level.var_2321["custom55"] = 54;
  level.var_2321["custom56"] = 55;
  level.var_2321["custom57"] = 56;
  level.var_2321["custom58"] = 57;
  level.var_2321["custom59"] = 58;
  level.var_2321["custom60"] = 59;
  level.var_2321["practice1"] = 0;
  level.var_2321["practice2"] = 1;
  level.var_2321["practice3"] = 2;
  level.var_2321["practice4"] = 3;
  level.var_2321["practice5"] = 4;
  level.var_2321["practice6"] = 5;
  level.var_2321["practice7"] = 6;
  level.var_2321["practice8"] = 7;
  level.var_2321["practice9"] = 8;
  level.var_2321["practice10"] = 9;
  level.var_2321["lobby1"] = 0;
  level.var_2321["lobby2"] = 1;
  level.var_2321["lobby3"] = 2;
  level.var_2321["lobby4"] = 3;
  level.var_2321["lobby5"] = 4;
  level.var_2321["lobby6"] = 5;
  level.var_2321["lobby7"] = 6;
  level.var_2321["lobby8"] = 7;
  level.var_2321["lobby9"] = 8;
  level.var_2321["lobby10"] = 9;
  level.var_2321["lobby11"] = 10;
  level.var_2321["lobby12"] = 11;
  level.var_2321["lobby13"] = 12;
  level.var_2321["lobby14"] = 13;
  level.var_2321["lobby15"] = 14;
  level.var_2321["lobby16"] = 15;
  level.var_2321["lobby17"] = 16;
  level.var_2321["lobby18"] = 17;
  level.var_2321["lobby19"] = 18;
  level.var_2321["lobby20"] = 19;
  level.var_2321["lobby21"] = 20;
  level.var_2321["lobby22"] = 21;
  level.var_2321["lobby23"] = 22;
  level.var_2321["lobby24"] = 23;
  level.var_2321["lobby25"] = 24;
  level.var_2321["lobby26"] = 25;
  level.var_2321["lobby27"] = 26;
  level.var_2321["lobby28"] = 27;
  level.var_2321["lobby29"] = 28;
  level.var_2321["lobby30"] = 29;
  level.var_2321["lobby31"] = 30;
  level.var_2321["lobby32"] = 31;
  level.var_2321["lobby33"] = 32;
  level.var_2321["lobby34"] = 33;
  level.var_2321["lobby35"] = 34;
  level.var_2321["lobby36"] = 35;
  level.var_2321["lobby37"] = 36;
  level.var_2321["lobby38"] = 37;
  level.var_2321["lobby39"] = 38;
  level.var_2321["lobby40"] = 39;
  level.var_2321["lobby41"] = 40;
  level.var_2321["lobby42"] = 41;
  level.var_2321["lobby43"] = 42;
  level.var_2321["lobby44"] = 43;
  level.var_2321["lobby45"] = 44;
  level.var_2321["lobby46"] = 45;
  level.var_2321["lobby47"] = 46;
  level.var_2321["lobby48"] = 47;
  level.var_2321["lobby49"] = 48;
  level.var_2321["lobby50"] = 49;
  level.var_2321["lobby51"] = 50;
  level.var_2321["lobby52"] = 51;
  level.var_2321["lobby53"] = 52;
  level.var_2321["lobby54"] = 53;
  level.var_2321["lobby55"] = 54;
  level.var_2321["lobby56"] = 55;
  level.var_2321["lobby57"] = 56;
  level.var_2321["lobby58"] = 57;
  level.var_2321["lobby59"] = 58;
  level.var_2321["lobby60"] = 59;
  level.var_2321["axis_recipe1"] = 0;
  level.var_2321["axis_recipe2"] = 1;
  level.var_2321["axis_recipe3"] = 2;
  level.var_2321["axis_recipe4"] = 3;
  level.var_2321["axis_recipe5"] = 4;
  level.var_2321["axis_recipe6"] = 5;
  level.var_2321["allies_recipe1"] = 0;
  level.var_2321["allies_recipe2"] = 1;
  level.var_2321["allies_recipe3"] = 2;
  level.var_2321["allies_recipe4"] = 3;
  level.var_2321["allies_recipe5"] = 4;
  level.var_2321["allies_recipe6"] = 5;
  level.var_2321["copycat"] = -1;
  level.var_2321["gamemode"] = 0;
  level.var_2321["callback"] = 0;
  level.var_2BC2 = "CLASS_ASSAULT";
  level.var_2324 = "mp/classTable.csv";
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    if(getdvarint("6019", 1) == 1) {
      level.var_2324 = "mp/classTableDivisionsOverhaulDLC4.csv";
    } else if(getdvarint("6020", 1) == 1) {
      if(getdvarint("spv_cavalryRiflemanPerk_enabled", 1) == 1) {
        level.var_2324 = "mp/classTableDivisionsOverhaulMTX6.csv";
      } else {
        level.var_2324 = "mp/classTableDivisionsOverhaulMTX6CavalryNerf.csv";
      }
    } else {
      level.var_2324 = "mp/classTableDivisionsOverhaul.csv";
    }
  }

  if(getdvarint("2543", 0) == 1 && getdvarint("2803", 0) == 1) {
    level.var_2324 = "mp/classTableGamescom.csv";
  }

  if(getdvarint("isMLGMatch", 0) == 1 || function_03AF()) {
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      level.var_2324 = "mp/classTableCompetitiveDivisionsOverhaul.csv";
    } else {
      level.var_2324 = "mp/classTableCompetitive.csv";
    }
  }

  if(getdvarint("scr_oneShot", 0) == 1) {
    if(getdvarint("6019", 1) == 1) {
      level.var_2324 = "mp/classTableOneShotDivisionsOverhaulDLC4.csv";
    } else if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      level.var_2324 = "mp/classTableOneShotDivisionsOverhaul.csv";
    } else {
      level.var_2324 = "mp/classTableOneShot.csv";
    }
  }

  if(level.var_3FDC == "infect") {
    level.var_2324 = "mp/classtableInfect.csv";
  }

  if(getdvarint("scr_wanderlustOnly", 0) == 1) {
    if(getdvarint("6019", 1) == 1) {
      level.var_2324 = "mp/classTableWanderlustOnlyDLC4.csv";
    } else {
      level.var_2324 = "mp/classTableWanderlustOnly.csv";
    }
  }

  if(level.var_3FDC == "undead") {
    if(getdvarint("6019", 1) == 1) {
      level.var_2324 = "mp/classTableUndeadDLC4.csv";
    } else {
      level.var_2324 = "mp/classTableUndead.csv";
    }
  }

  if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    if(getdvarint("6019", 1) == 1) {
      level.var_2324 = "mp/classTableThrowbackDLC4.csv";
    } else if(getdvarint("spv_cavalryRiflemanPerk_enabled", 1) == 1) {
      level.var_2324 = "mp/classTableThrowback.csv";
    } else {
      level.var_2324 = "mp/classTableThrowbackCavalryNerf.csv";
    }
  }

  level.var_761A = "mp/practiceRoundClassTable.csv";
  level.var_761B = "mp/practiceRoundCostumeTable.csv";
  level.var_0A53 = "mp/agentCostumeTable.csv";
  level.var_4B16 = "mp/hardcoreCostumeTable.csv";
  level.var_2323 = 10;
  if(!isDefined(level.var_297A)) {
    level.var_297A = 10;
  }

  level.var_2681 = [];
  level.var_2681["shirt"] = 10;
  level.var_2681["pants"] = 12;
  level.var_2681["gear"] = 11;
  level.var_2681["hat"] = 9;
  level.var_2681["eyewear"] = 8;
  level thread func_6B71();
}

func_1D3F() {
  var_00 = ["class0", "class1", "class2", "class3", "class4"];
  foreach(var_02 in var_00) {
    var_03 = level func_455F(0, var_02);
  }
}

func_44B4() {
  var_00 = [];
  var_00["loadoutDivision"] = 5;
  var_00["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(0, 0);
  for(var_01 = 0; var_01 < 6; var_01++) {
    var_00["loadoutPrimaryAttachmentsGUID"][var_01] = 0;
  }

  var_00["loadoutPrimaryCamoGUID"] = 0;
  var_00["loadoutPrimaryCamo2GUID"] = 0;
  var_00["loadoutPrimaryReticleGUID"] = 0;
  var_00["loadoutPrimaryCustomization"] = 0;
  var_00["loadoutPrimaryPaintjobId"] = 0;
  var_00["loadoutPrimaryCharmGUID"] = 0;
  var_00["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(0, 0);
  for(var_01 = 0; var_01 < 6; var_01++) {
    var_00["loadoutSecondaryAttachmentsGUID"][var_01] = 0;
  }

  var_00["loadoutSecondaryCamoGUID"] = 0;
  var_00["loadoutSecondaryCamo2GUID"] = 0;
  var_00["loadoutSecondaryReticleGUID"] = 0;
  var_00["loadoutSecondaryCustomization"] = 0;
  var_00["loadoutSecondaryPaintjobId"] = 0;
  var_00["loadoutSecondaryCharmGUID"] = 0;
  var_00["loadoutEquipmentStruct"] = maps\mp\_utility::func_44CE(0, 0);
  var_00["loadoutEquipmentNumExtra"] = 0;
  var_00["loadoutOffhandStruct"] = maps\mp\_utility::func_44CE(0, 0);
  var_00["loadoutOffhandNumExtra"] = 0;
  for(var_01 = 0; var_01 < 4; var_01++) {
    var_00["loadoutKillstreaksGUID"][var_01] = 0;
  }

  var_00["loadoutPerksGUID"] = maps\mp\perks\_perks::func_44B5();
  return var_00;
}

func_445C(param_00) {
  return param_00;
}

func_4729(param_00) {
  var_01 = strtok(param_00, ",");
  if(var_01.size > 1) {
    return int(var_01[1]);
  }

  return 0;
}

func_5E8D(param_00, param_01, param_02, param_03) {
  if(param_00 == self.var_5B84) {
    return;
  }

  self method_802B("choseclass: " + param_00 + " weapon: " + param_01 + " special: " + param_02);
  for(var_04 = 0; var_04 < param_03.size; var_04++) {
    self method_802B("perk" + var_04 + ": " + param_03[var_04]);
  }

  self.var_5B84 = param_00;
}

func_1E12(param_00) {
  return self getrankedplayerdata(common_scripts\utility::func_46A8(), "selectedLoadout", "weaponSetups", param_00, "weapon");
}

func_1E11(param_00) {
  return self getrankedplayerdata(common_scripts\utility::func_46A8(), "selectedLoadout", "perkSlots", param_00);
}

func_1E10() {
  return self getrankedplayerdata(common_scripts\utility::func_46A8(), "selectedLoadout", "equipmentSetups", 0, "equipment");
}

func_1E05(param_00) {
  if(!isDefined(param_00)) {
    param_00 = common_scripts\utility::func_46AF();
    var_01 = maps\mp\_utility::func_5385();
    if(!function_03AC() || var_01) {
      param_00 = common_scripts\utility::func_46AC();
    } else if(common_scripts\utility::func_562E(self.inrankedlobby)) {
      param_00 = common_scripts\utility::func_ACEE();
    }
  }

  return self getrankedplayerdata(var_01, "displayClassIndex");
}

func_1E07() {
  var_00 = common_scripts\utility::func_46AF();
  var_01 = maps\mp\_utility::func_5385();
  if(!function_03AC() || var_01) {
    var_00 = common_scripts\utility::func_46AC();
  } else if(function_03AF()) {
    var_00 = common_scripts\utility::func_ACEE();
  }

  return self getrankedplayerdata(var_00, "meleeWeapon", "weapon");
}

cac_getweaponcharm(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "charm");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "charm");
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "charm");
}

func_1E02(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "division");
  }

  if(function_0367()) {
    if(isDefined(param_01) && param_01 == common_scripts\utility::func_46AF()) {
      return self getcacplayerdataforgroup("customClasses", param_00, "division");
    }

    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "division");
  }

  return self getcacplayerdata(param_00, "division");
}

func_1E0A(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "weapon");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "weapon");
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "weapon");
}

func_1E0B(param_00, param_01, param_02) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "attachment", param_02);
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "attachment", param_02);
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "attachment", param_02);
}

func_1E0C(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "camo");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "camo");
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "camo");
}

func_1E0D(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "camo2");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "camo2");
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "camo2");
}

func_1E0F(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "reticle");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "reticle");
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "reticle");
}

func_1E0E(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "customization");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "customization");
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "customization");
}

cac_getweaponpaintjob(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "weaponSetups", param_01, "paintjob");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "weaponSetups", param_01, "paintjob");
  }

  return self getcacplayerdata(param_00, "weaponSetups", param_01, "paintjob");
}

func_1E09(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "perkSlots", param_01);
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "perkSlots", param_01);
  }

  return self getcacplayerdata(param_00, "perkSlots", param_01);
}

func_1E06(param_00, param_01) {
  var_02 = common_scripts\utility::func_46AF();
  var_03 = maps\mp\_utility::func_5385();
  if(!function_03AC()) {
    var_02 = common_scripts\utility::func_46AC();
  } else if(function_03AF()) {
    var_02 = common_scripts\utility::func_ACEE();
  }

  var_04 = "none";
  if(isDefined(level.var_3E0E)) {
    if(issubstr(level.var_3E0E, "private")) {
      var_02 = common_scripts\utility::func_46AC();
    } else {
      var_02 = common_scripts\utility::func_46AF();
    }
  }

  var_04 = self getrankedplayerdata(var_02, "assaultStreaks", param_01, "streak");
  if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::func_452B(var_04)) == 0) {
    return 0;
  }

  return var_04;
}

func_1E03(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return self getcacplayerdataforgroup(level.var_3E0E, param_00, "equipmentSetups", param_01, "equipment");
  }

  if(function_0367()) {
    return self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "equipmentSetups", param_01, "equipment");
  }

  return self getcacplayerdata(param_00, "equipmentSetups", param_01, "equipment");
}

func_1E04(param_00, param_01) {
  if(isDefined(level.var_3E0E)) {
    return int(self getcacplayerdataforgroup(level.var_3E0E, param_00, "equipmentSetups", param_01, "numExtra"));
  }

  if(function_0367()) {
    return int(self getcacplayerdataforgroup(maps\mp\_utility::func_1E01(), param_00, "equipmentSetups", param_01, "numExtra"));
  }

  return int(self getcacplayerdata(param_00, "equipmentSetups", param_01, "numExtra"));
}

func_1E08(param_00) {
  return func_1E03(param_00, 1);
}

func_1F9B(param_00) {
  return param_00 == "head";
}

func_1F98(param_00) {
  return self getrankedplayerdata(common_scripts\utility::func_46A9(), "globalCostume", param_00);
}

func_1F9A(param_00, param_01) {
  return self getrankedplayerdata(common_scripts\utility::func_46A9(), "costumes", param_01, param_00);
}

func_1F93(param_00, param_01) {
  var_02 = param_00;
  if(param_00 > 5) {
    var_02 = param_00 - 1;
  }

  if(param_01 == "allies") {
    var_02 = var_02 * 2;
  } else if(param_01 == "axis") {
    var_02 = var_02 * 2 + 1;
  }

  return var_02;
}

func_1F96(param_00) {
  var_01 = self getrankedplayerdata(common_scripts\utility::func_46A9(), "activeCostume");
  if(isDefined(self.var_01A7)) {
    if(isDefined(param_00) && param_00) {
      if(self.var_01A7 == "allies") {
        var_01 = var_01 | 1;
      } else if(self.var_01A7 == "axis") {
        var_01 = var_01 & 254;
      }
    } else if(self.var_01A7 == "allies") {
      var_01 = var_01 & 254;
    } else if(self.var_01A7 == "axis") {
      var_01 = var_01 | 1;
    }
  }

  return var_01;
}

cao_costumeindexteam(param_00) {
  if(param_00 & 1) {
    return "axis";
  }

  return "allies";
}

func_1F97(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_2683.size; var_02++) {
    var_03 = level.var_2683[var_02];
    if(func_1F9B(var_03)) {
      var_01[var_02] = func_1F98(var_03);
      continue;
    }

    var_01[var_02] = func_1F9A(var_03, param_00);
  }

  var_04 = func_1F9A("faceCamoId", param_00);
  if(isDefined(var_04) && var_04 >= 0) {
    var_01[level.var_2683.size] = var_04;
  }

  return var_01;
}

func_1F95(param_00) {
  var_01 = func_1F96(param_00);
  return func_1F97(var_01);
}

func_1F99(param_00) {
  var_01 = func_1E05(param_00);
  var_02 = func_1E02(var_01, param_00);
  var_03 = func_1F93(var_02, "allies");
  self setrankedplayerdata(common_scripts\utility::func_46A9(), "activeCostume", var_03);
  return func_1F97(var_03);
}

func_1FA2(param_00) {
  self.var_267E = func_1F99(param_00);
  if(isDefined(self.var_01A7) && self.var_01A7 == "axis") {
    self switchcustomizationteam(1);
  }

  self setcostumemodels(self.var_267E);
}

func_1FA0() {
  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  if(function_01EF(self)) {
    return;
  }

  for(var_00 = 0; var_00 < level.var_2683.size; var_00++) {
    var_01 = level.var_2683[var_00];
    if(func_1F9B(var_01)) {
      continue;
    }

    var_02 = level.var_2686[var_01];
    var_03 = self.var_267E[var_00];
    var_04 = createcostumeguid(var_02, var_03);
    var_05 = tablelookup("mp/statstable.csv", 18, var_04, 29);
    func_1FA1(var_01, int(var_05));
  }
}

func_1FA1(param_00, param_01) {
  var_02 = 0;
  var_03 = 1;
  var_04 = 2;
  var_05 = 3;
  var_06 = 4;
  var_07 = 5;
  var_08 = "mp/costumeStatTable.csv";
  var_09 = var_04;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  switch (param_01) {
    case 0:
      var_09 = var_04;
      break;

    case 1:
      var_09 = var_05;
      break;

    case 2:
      var_09 = var_06;
      break;

    case 3:
      var_09 = var_07;
      break;

    default:
      var_09 = var_04;
      break;
  }

  var_0A = tablelookup(var_08, 0, param_00, 1);
  var_0B = tablelookup(var_08, 0, param_00, var_09);
  if(var_0B == "NA") {
    return;
  }

  maps\mp\_utility::func_47A2(var_0A);
  switch (var_0A) {
    case "specialty_falldamage":
      self.var_3A0F = float(var_0B);
      break;

    case "specialty_streakshield":
      self.var_944B = float(var_0B);
      break;

    case "specialty_streakdamager":
      self.var_2998 = float(var_0B);
      break;

    case "specialty_extraammo":
      self.var_9AAE = float(var_0B);
      break;

    case "specialty_paint":
      maps\mp\_utility::func_47A2("specialty_paint_pro");
      self.var_90DA = float(var_0B);
      break;

    default:
      break;
  }
}

func_21B9() {
  if((!isDefined(self.var_5097) || !self.var_5097) && isDefined(self.var_267E) && getdvarint("5092")) {
    var_00 = [];
    self.var_2680 = [];
    var_01 = 0;
    while(var_01 < self.var_267E.size) {
      var_02 = level.var_2683[var_01];
      var_03 = level.var_2686[var_02];
      var_04 = self.var_267E[var_01];
      var_05 = createcostumeguid(var_03, var_04);
      var_06 = level.var_2681[var_02];
      if(isDefined(var_06)) {
        var_07 = tablelookuprownum("mp/characterGearSetTable.csv", var_06, var_05);
        while(isDefined(var_07) && var_07 >= 0) {
          var_08 = tablelookupbyrow("mp/characterGearSetTable.csv", var_07, 0);
          if(!isDefined(var_00[var_08])) {
            var_09 = tablelookupbyrow("mp/characterGearSetTable.csv", var_07, 4);
            var_0A = tablelookupbyrow("mp/characterGearSetTable.csv", var_07, 5);
            var_0B = tablelookupbyrow("mp/characterGearSetTable.csv", var_07, 7);
            var_0C = [];
            var_0C["bonusType"] = var_09;
            var_0C["bonus"] = float(var_0A);
            var_0C["amtInSet"] = var_0B;
            var_0C["foundAmt"] = 1;
            var_00[var_08] = var_0C;
          } else {
            var_00[var_08]["foundAmt"]++;
          }

          var_07 = var_07 - 1;
          if(var_07 >= 0) {
            var_07 = tablelookuprownum("mp/characterGearSetTable.csv", var_06, var_05, var_07);
          }
        }
      }

      var_03++;
    }

    var_0D = getarraykeys(var_00);
    for(var_01 = 0; var_01 < var_0D.size; var_01++) {
      var_08 = var_0D[var_01];
      var_09 = var_00[var_08]["bonusType"];
      var_0A = var_00[var_08]["bonus"];
      var_0B = int(var_00[var_08]["amtInSet"]);
      var_0E = var_00[var_08]["foundAmt"];
      if(var_0B == var_0E) {
        if(!isDefined(self.var_2680[var_09])) {
          var_0F = [];
          var_0F[var_08] = var_0A;
          self.var_2680[var_09] = [];
          self.var_2680[var_09]["refs"] = var_0F;
          self.var_2680[var_09]["bonusTotal"] = var_0A;
          continue;
        }

        self.var_2680[var_09]["refs"][var_08] = var_0A;
        self.var_2680[var_09]["bonusTotal"] = self.var_2680[var_09]["bonusTotal"] + var_0A;
      }
    }
  }
}

func_9583(param_00, param_01) {
  var_02 = 5;
  var_03 = tablelookup(param_00, 0, "loadoutDivision", param_01 + 1);
  if(isDefined(var_03) && isstringinteger(var_03) && maps\mp\gametypes\_divisions::func_56CC(int(var_03))) {
    var_02 = int(var_03);
  }

  return var_02;
}

func_9590(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = "";
  if(param_02 == 0) {
    var_04 = tablelookup(param_00, 0, "loadoutPrimary", param_01 + 1);
  } else {
    var_04 = tablelookup(param_00, 0, "loadoutSecondary", param_01 + 1);
  }

  var_03 = maps\mp\_utility::func_452A(var_04);
  return var_03;
}

func_958B(param_00, param_01, param_02, param_03) {
  var_04 = "none";
  var_05 = "loadoutPrimaryAttachment";
  if(param_02) {
    var_05 = "loadoutSecondaryAttachment";
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  switch (param_03) {
    case 0:
      break;

    case 1:
      var_05 = var_05 + "2";
      break;

    case 2:
      var_05 = var_05 + "3";
      break;

    case 3:
      var_05 = var_05 + "4";
      break;

    case 4:
      var_05 = var_05 + "5";
      break;

    case 5:
      var_05 = var_05 + "6";
      break;

    default:
      break;
  }

  var_04 = tablelookup(param_00, 0, var_05, param_01 + 1);
  var_06 = maps\mp\_utility::func_452A(var_04);
  return var_06;
}

func_958C(param_00, param_01, param_02) {
  if(param_02 == 0) {
    return tablelookup(param_00, 0, "loadoutPrimaryBuff", param_01 + 1);
  }

  return tablelookup(param_00, 0, "loadoutSecondaryBuff", param_01 + 1);
}

func_958E(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = "";
  if(param_02 == 0) {
    var_04 = tablelookup(param_00, 0, "loadoutPrimaryCamo", param_01 + 1);
  } else {
    var_04 = tablelookup(param_00, 0, "loadoutSecondaryCamo", param_01 + 1);
  }

  var_03 = maps\mp\_utility::func_452A(var_04);
  return var_03;
}

func_958D(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = "";
  if(param_02 == 0) {
    var_04 = tablelookup(param_00, 0, "loadoutPrimaryCamo2", param_01 + 1);
  } else {
    var_04 = tablelookup(param_00, 0, "loadoutSecondaryCamo2", param_01 + 1);
  }

  var_03 = maps\mp\_utility::func_452A(var_04);
  return var_03;
}

func_9591(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = "";
  if(param_02 == 0) {
    var_04 = tablelookup(param_00, 0, "loadoutPrimaryReticle", param_01 + 1);
  } else {
    var_04 = tablelookup(param_00, 0, "loadoutSecondaryReticle", param_01 + 1);
  }

  var_03 = maps\mp\_utility::func_452A(var_04);
  return var_03;
}

func_958F(param_00, param_01, param_02) {
  if(param_02 == 0) {
    var_03 = tablelookup(param_00, 0, "loadoutPrimaryCustomization", param_01 + 1);
  } else {
    var_03 = tablelookup(param_01, 0, "loadoutSecondaryCustomization", param_02 + 1);
  }

  if(var_03 == "") {
    var_03 = 0;
  }

  return var_03;
}

func_9589(param_00, param_01, param_02) {
  param_02++;
  var_03 = "loadoutPerk" + param_02;
  var_04 = tablelookup(param_00, 0, var_03, param_01 + 1);
  var_05 = maps\mp\_utility::func_452A(var_04);
  return var_05;
}

func_9584(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, "loadoutEquipment", param_01 + 1);
  var_03 = maps\mp\_utility::func_452A(var_02);
  return var_03;
}

func_9585(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, "loadoutEquipmentNumExtra", param_01 + 1);
  if(var_02 != "" && isstringinteger(var_02)) {
    return int(var_02);
  }

  return 0;
}

func_958A(param_00, param_01) {
  return tablelookup(param_00, 0, "loadoutTeamPerk", param_01 + 1);
}

func_9587(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, "loadoutOffhand", param_01 + 1);
  var_03 = maps\mp\_utility::func_452A(var_02);
  return var_03;
}

func_9588(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, "loadoutOffhandNumExtra", param_01 + 1);
  if(var_02 != "" && isstringinteger(var_02)) {
    return int(var_02);
  }

  return 0;
}

func_9586(param_00, param_01, param_02) {
  var_03 = tablelookup(param_00, 0, "loadoutStreak" + param_02 + 1, param_01 + 1);
  var_04 = maps\mp\_utility::func_452A(var_03);
  return var_04;
}

func_242D() {
  var_00 = "none";
  var_01 = self.var_28D0;
  var_02 = self.var_231D;
  var_03 = undefined;
  if(var_01 == "copycat") {
    var_01 = self.var_012C["copyCatLoadout"]["className"];
    var_03 = self.var_012C["copyCatLoadout"]["practiceClassNum"];
    if(var_01 == "callback") {
      var_02 = self.var_012C["copyCatLoadout"]["classCallbackFunc"];
    }
  }

  if(issubstr(var_01, "axis")) {
    var_00 = "axis";
  } else if(issubstr(var_01, "allies")) {
    var_00 = "allies";
  }

  var_04 = 5;
  var_05 = [];
  var_06 = [];
  var_07 = [];
  var_08 = [];
  if(var_00 != "none") {
    var_09 = maps\mp\_utility::func_445D(var_01);
    var_04 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "division");
    var_0A = maps\mp\_utility::func_473C(getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "weapon"), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_07[var_0B] = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "attachment", var_0B);
    }

    var_0C = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "camo");
    var_0D = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "camo2");
    var_0E = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "reticle");
    var_0F = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "customization");
    var_10 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "paintjob");
    var_11 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 0, "charm");
    var_12 = maps\mp\_utility::func_473C(getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "weapon"), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_08[var_0B] = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "attachment", var_0B);
    }

    var_13 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "camo");
    var_14 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "camo2");
    var_15 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "reticle");
    var_16 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "customization");
    var_17 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "paintjob");
    var_18 = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "weaponSetups", 1, "charm");
    var_19 = maps\mp\_utility::func_44CE(getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "equipmentSetups", 0, "equipment"), 0);
    var_1A = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "equipmentSetups", 0, "numExtra");
    var_1B = maps\mp\_utility::func_44CE(getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "equipmentSetups", 1, "equipment"), 0);
    var_1C = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "equipmentSetups", 1, "numExtra");
    for(var_0B = 0; var_0B < 9; var_0B++) {
      var_05[var_0B] = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "perkSlots", var_0B);
    }

    for(var_0B = 0; var_0B < 4; var_0B++) {
      var_06[var_0B] = getmatchrulesdata("defaultClasses", var_00, "defaultClass", var_09, "class", "assaultStreaks", var_0B, "streak");
    }
  } else if(issubstr(var_15, "custom")) {
    var_1D = maps\mp\_utility::func_445D(var_15);
    var_04 = func_1E02(var_1D);
    var_0A = maps\mp\_utility::func_473C(func_1E0A(var_1D, 0), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_07[var_0B] = func_1E0B(var_1D, 0, var_0B);
    }

    var_0C = func_1E0C(var_1D, 0);
    var_0D = func_1E0D(var_1D, 0);
    var_0E = func_1E0F(var_1D, 0);
    var_0F = func_1E0E(var_1D, 0);
    var_10 = cac_getweaponpaintjob(var_1D, 0);
    var_11 = cac_getweaponcharm(var_1D, 0);
    var_12 = maps\mp\_utility::func_473C(func_1E0A(var_1D, 1), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_08[var_0B] = func_1E0B(var_1D, 1, var_0B);
    }

    var_13 = func_1E0C(var_1D, 1);
    var_14 = func_1E0D(var_1D, 1);
    var_15 = func_1E0F(var_1D, 1);
    var_16 = func_1E0E(var_1D, 1);
    var_17 = cac_getweaponpaintjob(var_1D, 1);
    var_18 = cac_getweaponcharm(var_1D, 1);
    var_19 = maps\mp\_utility::func_44CE(func_1E03(var_1D, 0), 0);
    var_1A = func_1E04(var_1D, 0);
    var_1B = maps\mp\_utility::func_44CE(func_1E03(var_1D, 1), 0);
    var_1C = func_1E04(var_1D, 1);
    for(var_0B = 0; var_0B < 9; var_0B++) {
      var_05[var_0B] = func_1E09(var_1D, var_0B);
    }

    for(var_0B = 0; var_0B < 4; var_0B++) {
      var_06[var_0B] = func_1E06(var_1D, var_0B);
    }
  } else if(maps\mp\_utility::func_761E() && issubstr(var_15, "practice")) {
    var_1D = maps\mp\_utility::func_445D(var_15);
    if(isDefined(var_03)) {
      var_1D = var_03;
    } else {
      var_1D = self.var_012C["practiceRoundClasses"][var_1D];
      var_03 = var_1D;
    }

    var_04 = func_9583(level.var_761A, var_1D);
    var_0A = maps\mp\_utility::func_473C(func_9590(level.var_761A, var_1D, 0), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_07[var_0B] = func_958B(level.var_761A, var_1D, 0, var_0B);
    }

    var_0C = func_958E(level.var_761A, var_1D, 0);
    var_0D = func_958D(level.var_761A, var_1D, 0);
    var_0E = func_9591(level.var_761A, var_1D, 0);
    var_0F = func_958F(level.var_761A, var_1D, 0);
    var_10 = 0;
    var_11 = 0;
    var_12 = maps\mp\_utility::func_473C(func_9590(level.var_761A, var_1D, 1), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_08[var_0B] = func_958B(level.var_761A, var_1D, 1, var_0B);
    }

    var_13 = func_958E(level.var_761A, var_1D, 1);
    var_14 = func_958D(level.var_761A, var_1D, 1);
    var_15 = func_9591(level.var_761A, var_1D, 1);
    var_16 = func_958F(level.var_761A, var_1D, 1);
    var_17 = 0;
    var_18 = 0;
    var_19 = maps\mp\_utility::func_44CE(func_9584(level.var_761A, var_1D), 0);
    var_1A = func_9585(level.var_761A, var_1D);
    var_1B = maps\mp\_utility::func_44CE(func_9587(level.var_761A, var_1D), 0);
    var_1C = func_9588(level.var_761A, var_1D);
    for(var_0B = 0; var_0B < 9; var_0B++) {
      var_05[var_0B] = func_9589(level.var_761A, var_1D, var_0B);
    }

    for(var_0B = 0; var_0B < 4; var_0B++) {
      var_06[var_0B] = func_9586(level.var_761A, var_1D, var_0B);
    }
  } else if(var_16 == "callback") {
    if(!isDefined(var_17)) {
      common_scripts\utility::func_3809("self.classCallback function reference required for class \'callback\'");
    }

    var_1E = [[var_17]](1);
    if(!isDefined(var_1E)) {
      common_scripts\utility::func_3809("array required from self.classCallback for class \'callback\'");
    }

    var_05 = var_1E["loadoutDivision"];
    var_0B = var_1E["loadoutPrimaryWeaponStruct"];
    for(var_0C = 0; var_0C < 6; var_0C++) {
      var_08[var_0C] = var_1E["loadoutPrimaryAttachmentsGUID"][var_0C];
    }

    var_0D = var_1E["loadoutPrimaryCamoGUID"];
    var_0E = var_1E["loadoutPrimaryCamo2GUID"];
    var_0F = var_1E["loadoutPrimaryReticleGUID"];
    var_10 = var_1E["loadoutPrimaryCustomization"];
    var_11 = var_1E["loadoutPrimaryPaintjobId"];
    var_12 = var_1E["loadoutPrimaryCharmGUID"];
    for(var_0C = 0; var_0C < 9; var_0C++) {
      var_06[var_0C] = var_1E["loadoutPerkGUID" + var_0C + 1];
    }

    var_13 = var_1E["loadoutSecondaryWeaponStruct"];
    for(var_0C = 0; var_0C < 6; var_0C++) {
      var_0A[var_0C] = var_1E["loadoutSecondaryAttachmentsGUID" + var_0C + 1];
    }

    var_14 = var_1E["loadoutSecondaryCamoGUID"];
    var_15 = var_1E["loadoutSecondaryCamo2GUID"];
    var_16 = var_1E["loadoutSecondaryReticleGUID"];
    var_17 = var_1E["loadoutSecondaryCustomization"];
    var_18 = var_1E["loadoutSecondaryPaintjobId"];
    var_19 = var_1E["loadoutSecondaryCharmGUID"];
    var_1A = var_1E["loadoutEquipmentStruct"];
    var_1B = int(var_1E["loadoutEquipmentNumExtra"]);
    var_1C = var_1E["loadoutOffhandStruct"];
    var_1D = int(var_1E["loadoutOffhandNumExtra"]);
    for(var_0C = 0; var_0C < 4; var_0C++) {
      var_07[var_0C] = var_1E["loadoutStreakGUID" + var_0C + 1];
    }
  } else {
    var_1D = maps\mp\_utility::func_445D(var_16);
    var_04 = func_9583(level.var_2324, var_1D);
    var_0A = maps\mp\_utility::func_473C(func_9590(level.var_2324, var_1D, 0), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_07[var_0B] = func_958B(level.var_2324, var_1D, 0, var_0B);
    }

    var_0C = func_958E(level.var_2324, var_1D, 0);
    var_0D = func_958D(level.var_2324, var_1D, 0);
    var_0E = func_9591(level.var_2324, var_1D, 0);
    var_0F = func_958F(level.var_2324, var_1D, 0);
    var_10 = 0;
    var_11 = 0;
    var_12 = maps\mp\_utility::func_473C(func_9590(level.var_2324, var_1D, 1), 0);
    for(var_0B = 0; var_0B < 6; var_0B++) {
      var_08[var_0B] = func_958B(level.var_2324, var_1D, 1, var_0B);
    }

    var_13 = func_958E(level.var_2324, var_1D, 1);
    var_14 = func_958D(level.var_2324, var_1D, 1);
    var_15 = func_9591(level.var_2324, var_1D, 1);
    var_16 = func_958F(level.var_2324, var_1D, 1);
    var_17 = 0;
    var_18 = 0;
    var_19 = maps\mp\_utility::func_44CE(func_9584(level.var_2324, var_1D), 0);
    var_1A = func_9585(level.var_2324, var_1D);
    var_1B = maps\mp\_utility::func_44CE(func_9587(level.var_2324, var_1D), 0);
    var_1C = func_9588(level.var_2324, var_1D);
    for(var_0B = 0; var_0B < 9; var_0B++) {
      var_05[var_0B] = func_9589(level.var_2324, var_1D, var_0B);
    }

    var_1F = common_scripts\utility::func_46AF();
    if(!function_03AC()) {
      var_1F = common_scripts\utility::func_46AC();
    } else if(function_03AF()) {
      var_1F = common_scripts\utility::func_ACEE();
    }

    for(var_0B = 0; var_0B < 4; var_0B++) {
      var_06[var_0B] = self getrankedplayerdata(var_1F, "assaultStreaks", var_0B, "streak");
    }
  }

  var_20 = [];
  var_20["inUse"] = 0;
  var_20["className"] = var_03;
  if(isDefined(var_05)) {
    var_20["practiceClassNum"] = var_05;
  }

  if(var_03 == "callback" && isDefined(var_04)) {
    var_20["classCallbackFunc"] = var_04;
  }

  var_20["loadoutDivision"] = var_06;
  var_20["loadoutPrimaryWeaponStruct"] = var_0C;
  for(var_0D = 0; var_0D < 6; var_0D++) {
    var_20["loadoutPrimaryAttachmentsGUID"][var_0D] = var_0A[var_0D];
  }

  var_20["loadoutPrimaryCamoGUID"] = var_0E;
  var_20["loadoutPrimaryCamo2GUID"] = var_0F;
  var_20["loadoutPrimaryReticleGUID"] = var_10;
  var_20["loadoutPrimaryCustomization"] = var_11;
  var_20["loadoutPrimaryPaintjobId"] = var_12;
  var_20["loadoutPrimaryCharmGUID"] = var_13;
  var_20["loadoutSecondaryWeaponStruct"] = var_14;
  for(var_0D = 0; var_0D < 6; var_0D++) {
    var_20["loadoutSecondaryAttachmentsGUID"][var_0D] = var_0B[var_0D];
  }

  var_20["loadoutSecondaryCamoGUID"] = var_15;
  var_20["loadoutSecondaryCamo2GUID"] = var_16;
  var_20["loadoutSecondaryReticleGUID"] = var_17;
  var_20["loadoutSecondaryCustomization"] = var_18;
  var_20["loadoutSecondaryPaintjobId"] = var_19;
  var_20["loadoutSecondaryCharmGUID"] = var_1A;
  var_20["loadoutEquipmentStruct"] = var_1B;
  var_20["loadoutEquipmentNumExtra"] = var_1C;
  var_20["loadoutOffhandStruct"] = var_1D;
  var_20["loadoutOffhandNumExtra"] = var_1F;
  for(var_0D = 0; var_0D < 9; var_0D++) {
    var_20["loadoutPerksGUID"][var_0D] = var_07[var_0D];
  }

  for(var_0D = 0; var_0D < 4; var_0D++) {
    var_20["loadoutKillstreaksGUID"][var_0D] = var_08[var_0D];
  }

  return var_20;
}

func_455F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  if(isPlayer(self)) {
    var_05 = self;
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(self != level && isDefined(self.var_012C["copyCatLoadout"]) && self.var_012C["copyCatLoadout"]["inUse"] && param_02) {
    var_06 = 1;
  } else {
    var_06 = 0;
  }

  if(isDefined(level.var_5DF2) && isDefined(level.var_5DF2[param_01]) && !function_0367()) {
    var_07 = level.var_5DF2[param_01];
    if(isDefined(var_07)) {
      return var_07;
    }
  }

  if(isDefined(self.var_5DF2) && !function_0367() && (!maps\mp\_utility::func_579B() || !getdvarint("raid_allow_scorestreaks", 0)) && level.var_3FDC != "infect") {
    var_07 = self.var_5DF2[param_01];
    if(isDefined(var_07) && maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.raidclearloadoutcacheonspawn) && isDefined(var_07.raid_team) && self.var_01A7 != var_07.raid_team) {
      var_07 = undefined;
    }

    if(isDefined(var_07)) {
      if(var_07.var_870C == param_03 && var_07.var_2669 == var_06 && var_07.var_2319 == param_01) {
        return var_07;
      }
    }
  }

  var_08 = 0;
  var_09 = undefined;
  var_0A = undefined;
  var_0B = undefined;
  var_0C = [];
  for(var_0D = 0; var_0D < 4; var_0D++) {
    var_0C[var_0D] = undefined;
  }

  var_0E = 0;
  var_0F = undefined;
  var_10 = issubstr(param_01, "custom");
  var_11 = maps\mp\_utility::func_761E() && issubstr(param_01, "practice");
  var_12 = 5;
  var_13 = [];
  var_14 = [];
  var_15 = [];
  for(var_0D = 0; var_0D < 6; var_0D++) {
    var_14[var_0D] = 0;
    var_15[var_0D] = 0;
  }

  var_16 = level.var_2323;
  var_17 = undefined;
  var_18 = 1;
  var_19 = param_01 == "gamemode";
  if(level.var_3FDC == "infect" && param_00 == "axis") {
    var_19 = 1;
  }

  if(issubstr(param_01, "axis")) {
    var_1A = "axis";
  } else if(issubstr(param_02, "allies")) {
    var_1A = "allies";
  } else {
    var_1A = "none";
  }

  var_1B = [];
  if(var_06) {
    var_10 = 0;
    var_11 = 0;
    var_09 = maps\mp\_utility::func_445D("copycat");
    var_1B = self.var_012C["copyCatLoadout"];
    var_12 = var_1B["loadoutDivision"];
    var_1C = var_1B["loadoutPrimaryWeaponStruct"];
    for(var_0D = 0; var_0D < 6; var_0D++) {
      var_14[var_0D] = var_1B["loadoutPrimaryAttachmentsGUID"][var_0D];
    }

    var_1D = var_1B["loadoutPrimaryCamoGUID"];
    var_1E = var_1B["loadoutPrimaryCamo2GUID"];
    var_1F = var_1B["loadoutPrimaryReticleGUID"];
    var_0A = var_1B["loadoutPrimaryCustomization"];
    var_20 = var_1B["loadoutPrimaryPaintjobId"];
    var_21 = var_1B["loadoutPrimaryCharmGUID"];
    var_22 = var_1B["loadoutSecondaryWeaponStruct"];
    for(var_0D = 0; var_0D < 6; var_0D++) {
      var_15[var_0D] = var_1B["loadoutSecondaryAttachmentsGUID"][var_0D];
    }

    var_23 = var_1B["loadoutSecondaryCamoGUID"];
    var_24 = var_1B["loadoutSecondaryCamo2GUID"];
    var_25 = var_1B["loadoutSecondaryReticleGUID"];
    var_0B = var_1B["loadoutSecondaryCustomization"];
    var_26 = var_1B["loadoutSecondaryPaintjobId"];
    var_27 = var_1B["loadoutSecondaryCharmGUID"];
    var_28 = var_1B["loadoutEquipmentStruct"];
    var_29 = var_1B["loadoutEquipmentNumExtra"];
    var_2A = var_1B["loadoutOffhandStruct"];
    var_2B = var_1B["loadoutOffhandNumExtra"];
    for(var_0D = 0; var_0D < 9; var_0D++) {
      var_13[var_0D] = var_1B["loadoutPerksGUID"][var_0D];
    }

    for(var_0D = 0; var_0D < 4; var_0D++) {
      var_0C[var_0D] = var_1B["loadoutKillstreaksGUID"][var_0D];
    }
  } else if(isDefined(level.var_585D) && level.var_585D) {
    var_26 = level.var_297A;
    var_2C = func_1E12(0);
    if(!isDefined(var_2C) || var_2C == 0) {
      var_2D = ["m1a1_mp", "m30_mp", "svt40_mp", "m1911_mp", "model21_mp", "luger_mp", "kar98_mp", "p38_mp", "g43_mp"];
      var_2C = getitemguidfromref(common_scripts\utility::func_7A33(var_2D));
    }

    var_1C = maps\mp\_utility::func_473C(var_2C, 1);
    for(var_0D = 0; var_0D < 6; var_0D++) {
      var_14[var_0D] = 0;
    }

    var_1D = 0;
    var_1E = 0;
    var_1F = 0;
    var_0A = 0;
    var_20 = 0;
    var_21 = 0;
    if(isDefined(level.var_A9CC)) {
      var_2E = maps\mp\_utility::func_4737(var_1C);
      var_2F = [[level.var_A9CC]](var_05, var_2E);
      if(isDefined(var_2F)) {
        if(var_2F.var_7E18) {
          var_1F = var_2F.var_7E18;
        }

        if(var_2F.var_1EC0) {
          var_1D = var_2F.var_1EC0;
        }

        if(var_2F.var_297C) {
          var_0A = var_2F.var_297C;
        }

        for(var_30 = 0; var_30 < var_2F.var_114C.size; var_30++) {
          var_31 = var_2F.var_114C[var_30];
          var_14[var_30] = var_31;
        }

        if(var_2F.var_A9F8) {
          var_2C = var_2F.var_A9F8;
          var_1C = maps\mp\_utility::func_473C(var_2C, 1);
        }

        if(var_2F.charmguid) {
          var_21 = var_2F.charmguid;
        }

        if(var_2F.paintjobdwfileslot) {
          var_20 = var_2F.paintjobdwfileslot;
        }
      }
    }

    var_22 = maps\mp\_utility::func_473C(0, 1);
    for(var_0D = 0; var_0D < 6; var_0D++) {
      var_15[var_0D] = 0;
    }

    var_23 = 0;
    var_24 = 0;
    var_25 = 0;
    var_0B = 0;
    var_26 = 0;
    var_27 = 0;
    var_18 = 1;
    var_17 = maps\mp\_utility::func_473C(0, 0);
    var_28 = maps\mp\_utility::func_44CE(func_1E10(), 1);
    var_29 = 0;
    var_2A = maps\mp\_utility::func_44CE(0, 1);
    var_2B = 0;
    for(var_0D = 0; var_0D < 9; var_0D++) {
      var_13[var_0D] = func_1E11(var_0D);
    }

    for(var_0D = 0; var_0D < 4; var_0D++) {
      var_0C[var_0D] = 0;
    }
  } else if(var_2A != "none") {
    var_32 = maps\mp\_utility::func_445D(var_12);
    var_09 = var_32;
    self.var_231B = var_32;
    self.var_985A = var_1A;
    var_16 = 20;
    var_12 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "division");
    var_2C = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "weapon");
    if(var_2C == 0) {
      var_2C = 17113088;
      for(var_0D = 0; var_0D < 6; var_0D++) {
        var_14[var_0D] = 0;
      }
    } else {
      for(var_0D = 0; var_0D < 6; var_0D++) {
        var_14[var_0D] = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "attachment", var_0D);
      }
    }

    var_1D = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "camo");
    var_1E = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "camo2");
    var_1F = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "reticle");
    var_0A = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "customization");
    var_20 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "paintjob");
    var_21 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 0, "charm");
    var_33 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "weapon");
    for(var_0D = 0; var_0D < 6; var_0D++) {
      var_15[var_0D] = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "attachment", var_0D);
    }

    var_23 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "camo");
    var_24 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "camo2");
    var_25 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "reticle");
    var_0B = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "customization");
    var_26 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "paintjob");
    var_27 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "weaponSetups", 1, "charm");
    var_28 = maps\mp\_utility::func_44CE(getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "equipmentSetups", 0, "equipment"), 0);
    var_29 = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "equipmentSetups", 0, "numExtra");
    var_2A = maps\mp\_utility::func_44CE(getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "equipmentSetups", 1, "equipment"), 0);
    var_2B = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "equipmentSetups", 1, "numExtra");
    for(var_0D = 0; var_0D < 9; var_0D++) {
      var_13[var_0D] = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "perkSlots", var_0D);
    }

    for(var_0D = 0; var_0D < 4; var_0D++) {
      var_0C[var_0D] = getmatchrulesdata("defaultClasses", var_1A, "defaultClass", var_32, "class", "assaultStreaks", var_0D, "streak");
    }

    if((var_2C == 16818176 || var_2C == 0) && var_33 != 0) {
      var_2C = var_33;
      for(var_0D = 0; var_0D < 6; var_0D++) {
        var_14[var_0D] = var_15[var_0D];
      }

      var_1D = var_23;
      var_1E = var_24;
      var_1F = var_25;
      var_20 = var_26;
      var_21 = var_27;
      var_33 = 0;
      for(var_0D = 0; var_0D < 6; var_0D++) {
        var_15[var_0D] = 0;
      }

      var_23 = 0;
      var_24 = 0;
      var_25 = 0;
      var_26 = 0;
      var_27 = 0;
    } else if((var_2C == 16818176 || var_2C == 0) && var_33 == 0) {
      var_08 = 1;
      var_2C = 16863232;
      var_34 = "none";
    }

    var_1C = maps\mp\_utility::func_473C(var_2C, 0);
    var_22 = maps\mp\_utility::func_473C(var_33, 0);
  } else if(issubstr(var_15, "custom")) {
    var_1C = maps\mp\_utility::func_445D(var_15);
    var_29 = level.var_297A;
    var_25 = func_1E02(var_1C);
    var_1C = maps\mp\_utility::func_473C(func_1E0A(var_1C, 0), 0);
    for(var_1F = 0; var_1F < 6; var_1F++) {
      var_26[var_1F] = func_1E0B(var_1B, 0, var_1F);
    }

    var_1D = func_1E0C(var_1B, 0);
    var_1E = func_1E0D(var_1A, 0);
    var_1F = func_1E0F(var_19, 0);
    var_19 = func_1E0E(var_18, 0);
    var_20 = cac_getweaponpaintjob(var_18, 0);
    var_21 = cac_getweaponcharm(var_17, 0);
    var_22 = maps\mp\_utility::func_473C(func_1E0A(var_16, 1), 0);
    for(var_19 = 0; var_19 < 6; var_19++) {
      var_21[var_19] = func_1E0B(var_15, 1, var_19);
    }

    var_23 = func_1E0C(var_15, 1);
    var_24 = func_1E0D(var_14, 1);
    var_25 = func_1E0F(var_13, 1);
    var_14 = func_1E0E(var_12, 1);
    var_26 = cac_getweaponpaintjob(var_12, 1);
    var_27 = cac_getweaponcharm(var_11, 1);
    var_1E = maps\mp\_utility::func_473C(func_1E07(), 0);
    var_28 = maps\mp\_utility::func_44CE(func_1E03(var_10, 0), 0);
    var_29 = func_1E04(var_0F, 0);
    var_2A = maps\mp\_utility::func_44CE(func_1E03(var_0E, 1), 0);
    var_2B = func_1E04(var_0D, 1);
    for(var_10 = 0; var_10 < 9; var_10++) {
      var_16[var_10] = func_1E09(var_0C, var_10);
    }

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_0F[var_10] = func_1E06(var_0C, var_10);
    }
  } else if(var_24) {
    var_1C = maps\mp\_utility::func_445D(var_15);
    var_1C = self.var_012C["practiceRoundClasses"][var_1C];
    var_25 = func_9583(level.var_761A, var_1C);
    var_1C = maps\mp\_utility::func_473C(func_9590(level.var_761A, var_1C, 0), 0);
    for(var_1F = 0; var_1F < 6; var_1F++) {
      var_26[var_1F] = func_958B(level.var_761A, var_1B, 0, var_1F);
    }

    var_1D = func_958E(level.var_761A, var_1B, 0);
    var_1E = func_958D(level.var_761A, var_1A, 0);
    var_1F = func_9591(level.var_761A, var_19, 0);
    var_19 = func_958F(level.var_761A, var_18, 0);
    var_20 = 0;
    var_21 = 0;
    var_22 = maps\mp\_utility::func_473C(func_9590(level.var_761A, var_16, 1), 0);
    for(var_19 = 0; var_19 < 6; var_19++) {
      var_21[var_19] = func_958B(level.var_761A, var_15, 1, var_19);
    }

    var_23 = func_958E(level.var_761A, var_15, 1);
    var_24 = func_958D(level.var_761A, var_14, 1);
    var_25 = func_9591(level.var_761A, var_13, 1);
    var_14 = func_958F(level.var_761A, var_12, 1);
    var_26 = 0;
    var_27 = 0;
    var_28 = maps\mp\_utility::func_44CE(func_9584(level.var_761A, var_10), 0);
    var_29 = func_9585(level.var_761A, var_0F);
    var_2A = maps\mp\_utility::func_44CE(func_9587(level.var_761A, var_0E), 0);
    var_2B = func_9588(level.var_761A, var_0D);
    for(var_10 = 0; var_10 < 9; var_10++) {
      var_16[var_10] = func_9589(level.var_761A, var_0C, var_10);
    }

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_0F[var_10] = func_9586(level.var_761A, var_0C, var_10);
    }
  } else if(issubstr(var_15, "lobby")) {
    var_1C = maps\mp\_utility::func_445D(var_15);
    var_35 = maps\mp\_utility::func_1E01();
    var_07 = self.var_5E01[var_35][var_0C];
    var_15 = var_07["division"];
    var_1F = var_07["primaryWeaponStruct"];
    for(var_10 = 0; var_10 < 6; var_10++) {
      var_17[var_10] = var_07["primaryAttachmentsGUID"][var_10];
    }

    var_20 = var_07["primaryCamoGUID"];
    var_21 = var_07["primaryCamo2GUID"];
    var_22 = var_07["primaryReticleGUID"];
    var_0D = var_07["primaryCustomization"];
    var_23 = var_07["primaryPaintjobId"];
    var_24 = var_07["primaryCharmGUID"];
    for(var_10 = 0; var_10 < 9; var_10++) {
      var_16[var_10] = var_07["perkGUID" + var_10];
    }

    var_2B = var_07["equipmentStruct"];
    var_2C = var_07["offhandStruct"];
    var_32 = 0;
    var_33 = 0;
    var_25 = var_07["secondaryWeaponStruct"];
    for(var_10 = 0; var_10 < 6; var_10++) {
      var_18[var_10] = var_07["secondaryAttachmentsGUID"][var_10];
    }

    var_26 = var_07["secondaryCamoGUID"];
    var_27 = var_07["secondaryCamo2GUID"];
    var_28 = var_07["secondaryReticleGUID"];
    var_0E = var_07["secondaryCustomization"];
    var_29 = var_07["secondaryPaintjobId"];
    var_2A = var_07["secondaryCharmGUID"];
    var_1A = var_07["meleeWeaponStruct"];
  } else if(var_32) {
    var_36 = self.var_012C["gamemodeLoadout"];
    var_15 = var_36["loadoutDivision"];
    var_1F = var_36["loadoutPrimaryWeaponStruct"];
    for(var_10 = 0; var_10 < 6; var_10++) {
      var_17[var_10] = var_36["loadoutPrimaryAttachmentsGUID"][var_10];
    }

    var_20 = var_36["loadoutPrimaryCamoGUID"];
    var_21 = var_36["loadoutPrimaryCamo2GUID"];
    var_22 = var_36["loadoutPrimaryReticleGUID"];
    var_0D = var_36["loadoutPrimaryCustomization"];
    var_23 = var_36["loadoutPrimaryPaintjobId"];
    var_24 = var_36["loadoutPrimaryCharmGUID"];
    for(var_10 = 0; var_10 < 9; var_10++) {
      var_16[var_10] = var_36["loadoutPerksGUID"][var_10];
    }

    var_25 = var_36["loadoutSecondaryWeaponStruct"];
    for(var_10 = 0; var_10 < 6; var_10++) {
      var_18[var_10] = var_36["loadoutSecondaryAttachmentsGUID"][var_10];
    }

    var_26 = var_36["loadoutSecondaryCamoGUID"];
    var_27 = var_36["loadoutSecondaryCamo2GUID"];
    var_28 = var_36["loadoutSecondaryReticleGUID"];
    var_0E = var_36["loadoutSecondaryCustomization"];
    var_29 = var_36["loadoutSecondaryPaintjobId"];
    var_2A = var_36["loadoutSecondaryCharmGUID"];
    var_2B = var_36["loadoutEquipmentStruct"];
    var_32 = var_36["loadoutEquipmentNumExtra"];
    var_2C = var_36["loadoutOffhandStruct"];
    var_33 = var_36["loadoutOffhandNumExtra"];
    if(level.var_5A6F) {
      var_37 = 1;
      if(isDefined(self.var_3FC4) && self.var_3FC4) {
        var_38 = 1;
        foreach(var_3A in var_36["loadoutKillstreaksGUID"]) {
          if(var_3A != 0) {
            var_38 = 0;
            break;
          }
        }

        if(var_38) {
          var_37 = 0;
          var_11 = 1;
        }
      }

      if(var_37) {
        for(var_10 = 0; var_10 < 4; var_10++) {
          var_0F[var_10] = var_36["loadoutKillstreaksGUID"][var_10];
        }
      }
    } else {
      for(var_10 = 0; var_10 < 4; var_10++) {
        var_0F[var_10] = 0;
      }
    }

    var_1B = var_36["ignoreMeleeSlotWeapon"];
  } else if(var_16 == "callback") {
    var_2A = level.var_297A;
    if(!isDefined(self.var_231D)) {
      common_scripts\utility::func_3809("self.classCallback function reference required for class \'callback\'");
    }

    var_3C = [[self.var_231D]](var_19);
    if(!isDefined(var_3C)) {
      common_scripts\utility::func_3809("array required from self.classCallback for class \'callback\'");
    }

    var_16 = var_3C["loadoutDivision"];
    var_20 = var_3C["loadoutPrimaryWeaponStruct"];
    for(var_11 = 0; var_11 < 6; var_11++) {
      var_18[var_11] = var_3C["loadoutPrimaryAttachmentsGUID"][var_11];
    }

    var_21 = var_3C["loadoutPrimaryCamoGUID"];
    var_22 = var_3C["loadoutPrimaryCamo2GUID"];
    var_23 = var_3C["loadoutPrimaryReticleGUID"];
    var_0E = var_3C["loadoutPrimaryCustomization"];
    var_24 = var_3C["loadoutPrimaryPaintjobId"];
    var_25 = var_3C["loadoutPrimaryCharmGUID"];
    for(var_11 = 0; var_11 < 9; var_11++) {
      var_17[var_11] = var_3C["loadoutPerkGUID" + var_11 + 1];
    }

    var_26 = var_3C["loadoutSecondaryWeaponStruct"];
    for(var_11 = 0; var_11 < 6; var_11++) {
      var_19[var_11] = var_3C["loadoutSecondaryAttachmentsGUID"][var_11];
    }

    var_27 = var_3C["loadoutSecondaryCamoGUID"];
    var_28 = var_3C["loadoutSecondaryCamo2GUID"];
    var_29 = var_3C["loadoutSecondaryReticleGUID"];
    var_0F = var_3C["loadoutSecondaryCustomization"];
    var_2A = var_3C["loadoutSecondaryPaintjobId"];
    var_2B = var_3C["loadoutSecondaryCharmGUID"];
    var_1B = var_3C["loadoutMeleeWeaponStruct"];
    var_32 = var_3C["loadoutEquipmentStruct"];
    var_33 = var_3C["loadoutOffhandStruct"];
    var_2C = var_3C["loadoutEquipmentNumExtra"];
    var_36 = var_3C["loadoutOffhandNumExtra"];
    for(var_11 = 0; var_11 < 4; var_11++) {
      var_10[var_11] = var_3C["loadoutStreakGUID" + var_11 + 1];
    }
  } else {
    var_1D = maps\mp\_utility::func_445D(var_16);
    var_26 = func_9583(level.var_2324, var_1D);
    var_1C = maps\mp\_utility::func_473C(func_9590(level.var_2324, var_1D, 0), 0);
    for(var_20 = 0; var_20 < 6; var_20++) {
      var_27[var_20] = func_958B(level.var_2324, var_1C, 0, var_20);
    }

    var_1D = func_958E(level.var_2324, var_1C, 0);
    var_1E = func_958D(level.var_2324, var_1B, 0);
    var_1F = func_9591(level.var_2324, var_1A, 0);
    var_1A = func_958F(level.var_2324, var_19, 0);
    var_20 = 0;
    var_21 = 0;
    for(var_1B = 0; var_1B < 9; var_1B++) {
      var_21[var_1B] = func_9589(level.var_2324, var_17, var_1B);
    }

    var_22 = maps\mp\_utility::func_473C(func_9590(level.var_2324, var_17, 1), 0);
    for(var_1A = 0; var_1A < 6; var_1A++) {
      var_22[var_1A] = func_958B(level.var_2324, var_16, 1, var_1A);
    }

    var_23 = func_958E(level.var_2324, var_16, 1);
    var_24 = func_958D(level.var_2324, var_15, 1);
    var_25 = func_9591(level.var_2324, var_14, 1);
    var_15 = func_958F(level.var_2324, var_13, 1);
    var_26 = 0;
    var_27 = 0;
    var_28 = maps\mp\_utility::func_44CE(func_9584(level.var_2324, var_11), 0);
    var_29 = func_9585(level.var_2324, var_10);
    var_2A = maps\mp\_utility::func_44CE(func_9587(level.var_2324, var_0F), 0);
    var_2B = func_9588(level.var_2324, var_0E);
    var_3D = common_scripts\utility::func_46AF();
    if(!function_03AC()) {
      var_3D = common_scripts\utility::func_46AC();
    } else if(function_03AF()) {
      var_3D = common_scripts\utility::func_ACEE();
    }

    for(var_11 = 0; var_11 < 4; var_11++) {
      var_10[var_11] = self getrankedplayerdata(var_3D, "assaultStreaks", var_11, "streak");
      if(!isDefined(var_10[var_11])) {
        var_10[var_11] = 0;
      }
    }
  }

  var_3E = issubstr(var_06, "custom") || issubstr(var_06, "lobby");
  var_3F = issubstr(var_06, "recipe");
  var_40 = function_03AF();
  if(level.var_5A6F && !isDefined(var_11[0]) && !isDefined(var_11[1]) && !isDefined(var_11[2]) && !isDefined(var_11[3])) {
    var_0E = maps\mp\_utility::func_445D(var_06);
    if(isDefined(self.var_231B)) {
      var_0E = self.var_231B;
    }

    var_14 = "assaultStreaks";
    var_3D = common_scripts\utility::func_46AF();
    if(!function_03AC()) {
      var_40 = common_scripts\utility::func_46AC();
    } else if(function_03AF()) {
      var_40 = common_scripts\utility::func_ACEE();
    }

    var_42 = [];
    for(var_11 = 0; var_11 < 4; var_11++) {
      var_42[var_11] = func_9586(level.var_2324, var_0D, var_11);
      var_10[var_11] = undefined;
    }

    if(var_14) {
      for(var_11 = 0; var_11 < 4; var_11++) {
        var_10[var_11] = self getrankedplayerdata(var_40, var_13, var_11, "streak");
      }
    }

    if(var_1D) {
      foreach(var_3A in self.var_5A71) {
        if(!isDefined(var_10[0])) {
          var_10[0] = var_3A;
          continue;
        }

        if(!isDefined(var_10[1])) {
          var_10[1] = var_3A;
          continue;
        }

        if(!isDefined(var_10[2])) {
          var_10[2] = var_3A;
          continue;
        }

        if(!isDefined(var_10[3])) {
          var_10[3] = var_3A;
        }
      }
    }

    if(!issubstr(var_05, "custom") && !var_1D) {
      for(var_11 = 0; var_11 < 4; var_11++) {
        var_10[var_11] = var_42[var_11];
      }
    }

    for(var_11 = 0; var_11 < 4; var_11++) {
      if(!isDefined(var_10[var_11])) {
        var_10[var_11] = 0;
      }

      if(!func_582D(var_10[var_11]) || var_3D && !self method_85FE(var_10[var_11]) && !var_3F) {
        var_10[var_11] = func_9586(level.var_2324, 0, var_11);
      }
    }
  } else if(!level.var_5A6F) {
    for(var_12 = 0; var_12 < 4; var_12++) {
      var_11[var_12] = 0;
    }
  }

  var_1A[4] = 0;
  var_1A[5] = 0;
  var_19[4] = 0;
  var_19[5] = 0;
  var_45 = maps\mp\_utility::func_452A(tablelookup("mp/statstable.csv", 18, var_21.var_48CA, 9));
  var_46 = maps\mp\_utility::func_452A(tablelookup("mp/statstable.csv", 18, var_27.var_48CA, 9));
  if(!isDefined(var_17) || !maps\mp\gametypes\_divisions::func_56CC(var_17)) {
    var_17 = 5;
  }

  if(!isDefined(var_33)) {
    var_33 = 0;
  }

  if(!isDefined(var_3D)) {
    var_3D = 0;
  }

  if(getdvarint("683", 0)) {
    if(!maps\mp\gametypes\_divisions::func_569B("Primary", var_17)) {
      var_21.var_48CA = 17113088;
      for(var_12 = 0; var_12 < 6; var_12++) {
        var_19[var_12] = 0;
      }
    } else {
      for(var_12 = 0; var_12 < 6; var_12++) {
        if(!maps\mp\gametypes\_divisions::func_569B(maps\mp\gametypes\_divisions::func_9C8A("Primary_Attachment", var_12), var_17)) {
          var_19[var_12] = 0;
        }
      }
    }

    if(!maps\mp\gametypes\_divisions::func_569B("Secondary", var_17)) {
      var_27.var_48CA = 17113088;
      for(var_12 = 0; var_12 < 6; var_12++) {
        var_1A[var_12] = 0;
      }
    } else {
      for(var_12 = 0; var_12 < 6; var_12++) {
        if(!maps\mp\gametypes\_divisions::func_569B(maps\mp\gametypes\_divisions::func_9C8A("Secondary_Attachment", var_12), var_17)) {
          var_1A[var_12] = 0;
        }
      }
    }

    for(var_12 = 0; var_12 < 9; var_12++) {
      if(!maps\mp\gametypes\_divisions::func_569B(maps\mp\gametypes\_divisions::func_9C8A("Perk", var_12), var_17)) {
        var_18[var_12] = 0;
      }
    }

    if(!maps\mp\gametypes\_divisions::func_569B("Lethal1", var_17)) {
      var_2C.var_48CA = 0;
      var_33 = 0;
    } else {
      if(!maps\mp\gametypes\_divisions::func_569B("Lethal3", var_17)) {
        var_33 = min(var_33, 1);
      }

      if(!maps\mp\gametypes\_divisions::func_569B("Lethal2", var_17)) {
        var_33 = 0;
      }
    }

    if(!maps\mp\gametypes\_divisions::func_569B("Tactical1", var_17)) {
      var_36.var_48CA = 0;
      var_3D = 0;
    } else {
      if(!maps\mp\gametypes\_divisions::func_569B("Tactical3", var_17)) {
        var_3D = min(var_3D, 1);
      }

      if(!maps\mp\gametypes\_divisions::func_569B("Tactical2", var_17)) {
        var_3D = 0;
      }
    }

    var_47 = 0;
    if(var_21.var_48CA != 0) {
      var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Primary", var_17);
    }

    if(var_19[0] != 0 && var_45 == 0) {
      var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Primary_Attachment1", var_17);
    }

    for(var_12 = 1; var_12 < 6; var_12++) {
      if(var_19[var_12] != 0) {
        var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Primary_Attachment", var_12), var_17);
      }
    }

    if(var_27.var_48CA != 0) {
      var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Secondary", var_17);
    }

    if(var_1A[0] != 0 && var_46 == 0) {
      var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Secondary_Attachment1", var_17);
    }

    for(var_12 = 1; var_12 < 6; var_12++) {
      if(var_1A[var_12] != 0) {
        var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Secondary_Attachment", var_12), var_17);
      }
    }

    if(var_2C.var_48CA != 0) {
      var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Lethal1", var_17);
    }

    if(isDefined(var_33) && var_33 > 0) {
      if(var_33 >= 1) {
        var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Lethal2", var_17);
      }

      if(var_33 >= 2) {
        var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Lethal3", var_17);
      }
    }

    if(var_36.var_48CA != 0) {
      var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Tactical1", var_17);
    }

    if(isDefined(var_3D) && var_3D > 0) {
      if(var_33 >= 1) {
        var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Tactical2", var_17);
      }

      if(var_33 >= 2) {
        var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443("Tactical3", var_17);
      }
    }

    for(var_12 = 0; var_12 < 9; var_12++) {
      if(var_18[var_12] != 0) {
        var_47 = var_47 + maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", var_12), var_17);
      }
    }

    if(var_47 > var_1B) {
      for(;;) {
        if(var_18[8] != 0) {
          var_18[8] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 8), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[7] != 0) {
          var_18[7] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 7), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[6] != 0) {
          var_18[6] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 6), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[5] != 0) {
          var_18[5] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 5), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[4] != 0) {
          var_18[4] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 4), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[3] != 0) {
          var_18[3] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 3), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[2] != 0) {
          var_18[2] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 2), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[1] != 0) {
          var_18[1] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 1), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_18[0] != 0) {
          var_18[0] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Perk", 0), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(isDefined(var_3D) && var_3D > 0) {
          if(var_3D == 2) {
            var_3D = 1;
            var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Tactical3", var_17);
          }

          if(var_47 <= var_1B) {
            break;
          }

          if(var_3D == 1) {
            var_3D = 0;
            var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Tactical2", var_17);
          }

          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_36.var_48CA != 0) {
          var_36.var_48CA = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Tactical1", var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(isDefined(var_33) && var_33 > 0) {
          if(var_33 == 2) {
            var_33 = 1;
            var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Lethal3", var_17);
          }

          if(var_47 <= var_1B) {
            break;
          }

          if(var_33 == 1) {
            var_33 = 0;
            var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Lethal2", var_17);
          }

          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_2C.var_48CA != 0) {
          var_2C.var_48CA = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Tactical1", var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_1A[1] != 0) {
          var_1A[1] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Secondary_Attachment", 1), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_1A[0] != 0 && var_46 == 0) {
          var_1A[0] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Secondary_Attachment", 0), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_27.var_48CA != 17113088) {
          var_27.var_48CA = 17113088;
          var_1A[0] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Secondary", var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_19[3] != 0) {
          var_19[3] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Primary_Attachment", 3), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_19[2] != 0) {
          var_19[2] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Primary_Attachment", 2), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_19[1] != 0) {
          var_19[1] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Primary_Attachment", 1), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_19[0] != 0 && var_45 == 0) {
          var_19[0] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443(maps\mp\gametypes\_divisions::func_9C8A("Primary_Attachment", 0), var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        if(var_21.var_48CA != 17113088) {
          var_21.var_48CA = 17113088;
          var_19[0] = 0;
          var_47 = var_47 - maps\mp\gametypes\_divisions::func_4443("Primary", var_17);
          if(var_47 <= var_1B) {
            break;
          }
        }

        break;
      }
    }
  }

  if(!var_1E && !var_3F && !isDefined(self.var_012C["copyCatLoadout"]) && self.var_012C["copyCatLoadout"]["inUse"] && var_08) {
    var_48 = var_18[3] == 73400456 || var_18[3] == 73400489;
    var_49 = func_5835(var_21.var_48CA, var_48);
    if(!var_49 || level.var_7A67 && var_3E && !self method_85FE(var_21.var_48CA) && !var_40) {
      var_21.var_48CA = func_9590(level.var_2324, 10, 0);
      for(var_12 = 0; var_12 < 6; var_12++) {
        var_19[var_12] = 0;
      }
    }

    if(var_45 != 0) {
      var_19[0] = var_45;
    } else if(!func_5820(var_19[0], var_21.var_48CA) || level.var_7A67 && var_3E && !func_567C(var_21.var_48CA, var_19[0]) && !var_40) {
      var_19[0] = func_958B(level.var_2324, 10, 0, 0);
    }

    for(var_12 = 1; var_12 < 6; var_12++) {
      if(!func_5820(var_19[var_12], var_21.var_48CA) || level.var_7A67 && var_3E && !func_567C(var_21.var_48CA, var_19[var_12]) && !var_40) {
        var_19[var_12] = func_958B(level.var_2324, 10, 0, var_12);
      }
    }

    var_4A = [];
    for(var_12 = 0; var_12 < 6; var_12++) {
      var_4A[var_12] = var_19[var_12];
    }

    for(var_4B = 0; var_4B < var_4A.size; var_4B++) {
      if(var_4A[var_4B] == 0) {
        continue;
      }

      for(var_4C = var_4B + 1; var_4C < var_4A.size; var_4C++) {
        if(var_4A[var_4C] == 0) {
          continue;
        }

        if(var_4A[var_4B] == var_4A[var_4C]) {
          func_7B3D();
          var_4A[var_4C] = 0;
          var_19[var_4C] = 0;
        }
      }
    }

    if(!func_5821(var_22) || level.var_7A67 && var_3E && !func_56A0(var_21.var_48CA, var_22) && !var_40) {
      var_22 = func_958E(level.var_2324, 10, 0);
    }

    if(!func_5821(var_23) || level.var_7A67 && var_3E && !func_56A0(var_21.var_48CA, var_23) && !var_40) {
      var_23 = func_958D(level.var_2324, 10, 0);
    }

    if(!func_5838(var_24)) {
      var_24 = func_9591(level.var_2325, 10, 0);
    }

    var_4D = (getdvarint("spv_cavalryRiflemanPerk_enabled", 1) == 1 && var_17 == 7) || var_18[3] == 73400419 || level.var_3FDC == "undead";
    var_4E = var_18[3] == 73400426;
    if(!func_5839(var_27.var_48CA, var_4D, var_4E) || level.var_7A67 && var_3E && !self method_85FE(var_27.var_48CA) && !var_40) {
      var_27.var_48CA = func_9590(level.var_2324, 10, 1);
      for(var_12 = 0; var_12 < 6; var_12++) {
        var_1A[var_12] = 0;
      }

      var_28 = 0;
      var_29 = 0;
      var_2A = 0;
      var_10 = 0;
      var_2B = 0;
    }

    if(var_46 != 0) {
      var_1A[0] = var_46;
    } else if(!func_5820(var_1A[0], var_27.var_48CA) || level.var_7A67 && var_3E && !func_567C(var_27.var_48CA, var_1A[0]) && !var_40) {
      var_1A[0] = func_958B(level.var_2324, 10, 1, 0);
    }

    for(var_12 = 1; var_12 < 6; var_12++) {
      if(!func_5820(var_1A[var_12], var_27.var_48CA) || level.var_7A67 && var_3E && !func_567C(var_27.var_48CA, var_1A[var_12]) && !var_40) {
        var_1A[var_12] = func_958B(level.var_2324, 10, 1, var_12);
      }
    }

    if(var_1A[0] != 0) {
      if(var_1A[0] == var_1A[1]) {
        func_7B3D();
        var_1A[1] = 0;
      }
    }

    if(!func_5821(var_28) || level.var_7A67 && var_3E && !func_56A0(var_27.var_48CA, var_28) && !var_40) {
      var_28 = func_958E(level.var_2324, 10, 1);
    }

    if(!func_5821(var_29) || level.var_7A67 && var_3E && !func_56A0(var_27.var_48CA, var_29) && !var_40) {
      var_29 = func_958D(level.var_2324, 10, 1);
    }

    if(!func_5838(var_2A)) {
      var_2A = func_9591(level.var_2324, 10, 1);
    }

    if(!func_5826(maps\mp\_utility::func_44CD(var_2C), 0, var_17 == 8) || level.var_7A67 && var_3E && !self method_85FE(var_2C.var_48CA) && !var_40) {
      var_2C.var_48CA = func_9584(level.var_2324, 10);
    }

    if(var_2C.var_48CA == var_36.var_48CA) {
      var_2C.var_48CA = 0;
    }

    if(!func_5833(maps\mp\_utility::func_44CD(var_36), 0)) {
      var_36.var_48CA = func_9587(level.var_2324, 10);
    }
  }

  for(var_19 = 0; var_19 < 9; var_19++) {
    if(var_1F[var_19] == 0) {
      continue;
    }

    var_4F = var_1F[var_19];
    var_1F[var_19] = maps\mp\perks\_perks::func_A277(var_19, var_1F[var_19]);
    if(var_4F != var_1F[var_19]) {
      func_7B3D();
    }
  }

  var_50 = 0;
  var_51 = var_1F[3] == 73400412;
  var_52 = maps\mp\_utility::func_4431(maps\mp\_utility::func_4737(var_33));
  if(maps\mp\_utility::func_5856(var_52)) {
    var_52 = func_4432(var_52);
  }

  if(var_51 && maps\mp\_utility::func_472A(var_52) == "weapon_pistol") {
    switch (var_52) {
      case "enfieldno2_mp":
      case "reich_mp":
      case "p38_mp":
      case "luger_mp":
      case "m1911_mp":
        var_50 = 50332864;
        break;

      case "m712_mp":
        var_50 = 50333920;
        break;
    }

    for(var_19 = 0; var_19 < var_21.size; var_19++) {
      if(var_21[var_19] == 50338160) {
        var_21[var_19] = 0;
      }
    }
  }

  var_07 = spawnStruct();
  var_07.var_2319 = var_0E;
  var_07.var_231B = var_15;
  var_07.var_985A = var_26;
  var_07.var_23D9 = var_14;
  var_07.var_2669 = var_13;
  var_07.var_1E26 = var_1C;
  var_07.var_7615 = var_1D;
  var_07.var_56FE = var_25;
  var_07.var_0079 = var_1E;
  var_07.var_7709 = var_28;
  var_07.var_76F3 = var_20;
  var_07.var_76F5 = var_29;
  var_07.var_76F4 = var_2A;
  var_07.var_7700 = var_2B;
  var_07.var_0144 = var_16;
  var_07.primarypaintjobid = var_32;
  var_07.primarycharmguid = var_2C;
  var_53 = maps\mp\_utility::func_4737(var_07.var_7709);
  var_07.var_76F8 = func_1D66(var_53, var_07.var_76F3[0], var_07.var_76F3[1], var_07.var_76F3[2], var_07.var_76F3[3], var_07.var_76F3[4], var_07.var_76F3[5], maps\mp\_utility::func_472D(var_07.var_7709), var_07.var_76F5, var_07.var_76F4, var_07.var_7700, var_07.var_0144, var_12, var_07.var_0079);
  var_07.var_835D = var_33;
  var_07.var_8353[0] = var_21[0];
  var_07.var_8353[1] = var_21[1];
  var_07.var_8353[2] = var_21[2];
  var_07.var_8353[3] = var_21[3];
  var_07.var_8353[4] = 0;
  var_07.var_8353[5] = var_50;
  var_07.var_8355 = var_36;
  var_07.var_8354 = var_3D;
  var_07.var_8359 = var_3E;
  var_07.var_0176 = var_17;
  var_07.secondarypaintjobid = var_3F;
  var_07.secondarycharmguid = var_40;
  var_53 = maps\mp\_utility::func_4737(var_07.var_835D);
  var_07.var_8358 = func_1D66(var_53, var_07.var_8353[0], var_07.var_8353[1], var_07.var_8353[2], var_07.var_8353[3], var_07.var_8353[4], var_07.var_8353[5], maps\mp\_utility::func_472D(var_07.var_835D), var_07.var_8355, var_07.var_8354, var_07.var_8359, var_07.var_0176, var_12, var_07.var_0079);
  var_07.var_60FC = var_23;
  var_07.var_509D = var_24;
  var_07.var_37FE = var_45;
  var_07.var_37FD = int(var_46);
  var_07.var_69AD = var_48;
  var_07.var_69AC = int(var_49);
  var_07.var_6F69 = var_1F;
  if(getdvarint("scr_oneShot", 0) == 1) {
    var_07.var_5A62 = 69206017;
    var_07.var_5A63 = 0;
    var_07.var_5A64 = 0;
    var_07.var_5A65 = 0;
  } else if(level.var_3FDC == "undead") {
    var_07.var_5A62 = 69206017;
    var_07.var_5A63 = 69206044;
    var_07.var_5A64 = 69206041;
    var_07.var_5A65 = 69206035;
  } else if(maps\mp\_utility::func_579B() && issubstr(maps\mp\_utility::func_4571(), "dlc2")) {
    if(isDefined(self.var_01A7) && self.var_01A7 == "allies") {
      if(game["switchedsides"]) {
        var_07.var_5A62 = maps\mp\_utility::func_452A("raid_flak");
      } else {
        var_07.var_5A62 = maps\mp\_utility::func_452A("raid_fighters");
      }
    } else if(game["switchedsides"]) {
      var_07.var_5A62 = maps\mp\_utility::func_452A("raid_fighters");
    } else {
      var_07.var_5A62 = maps\mp\_utility::func_452A("raid_flak");
    }

    var_07.var_5A63 = 0;
    var_07.var_5A64 = 0;
    var_07.var_5A65 = 0;
  } else if(maps\mp\_utility::isdogfightgametype()) {
    var_07.var_5A62 = maps\mp\_utility::func_452A("dogfight_flak");
    var_07.var_5A63 = 0;
    var_07.var_5A64 = 0;
    var_07.var_5A65 = 0;
  } else {
    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::func_452B(var_18[0])) == 0) {
      var_07.var_5A62 = 0;
    } else {
      var_07.var_5A62 = var_18[0];
    }

    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::func_452B(var_18[1])) == 0) {
      var_07.var_5A63 = 0;
    } else {
      var_07.var_5A63 = var_18[1];
    }

    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::func_452B(var_18[2])) == 0) {
      var_07.var_5A64 = 0;
    } else {
      var_07.var_5A64 = var_18[2];
    }

    if(getdvarint("scorestreak_enabled_" + maps\mp\_utility::func_452B(var_18[3])) == 0) {
      var_07.var_5A65 = 0;
    } else {
      var_07.var_5A65 = var_18[3];
    }
  }

  var_07.var_59DA = var_1A;
  var_07.var_870C = var_10;
  if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.raidclearloadoutcacheonspawn)) {
    var_07.raid_team = self.var_01A7;
  }

  if(!issubstr(var_0E, "lobby") && !issubstr(var_0E, "callback") && !function_0367() && !isDefined(self.var_509B) || !self.var_509B) {
    self.var_5DF2[var_0E] = var_07;
  }

  return var_07;
}

func_4790(param_00, param_01, param_02, param_03) {
  self.var_5DEE = func_455F(param_00, param_01, param_02, param_03);
  func_09A7(self.var_5DEE);
  if(!function_0367() || maps\mp\gametypes\_hud_util::func_5527() || level.var_53C7 && !function_01EF(self) || isbot(self)) {
    if(isDefined(level.var_585D) && level.var_585D) {
      for(var_04 = 0; var_04 < self.var_5DEE.var_6F69.size; var_04++) {
        if(var_04 < 9) {
          setmatchdata("players", self.var_2418, "loadout", "mods", var_04, self.var_5DEE.var_6F69[var_04]);
        }
      }

      setmatchdata("players", self.var_2418, "loadout", "primary", self.var_5DEE.var_7709.var_48CA);
      setmatchdata("players", self.var_2418, "loadout", "lethal", self.var_5DEE.var_37FE.var_48CA);
      return;
    }

    func_5E9B();
  }
}

func_5E9B() {
  var_00 = -1;
  var_01 = 6;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = getmatchdata("players", self.var_2418, "loadouts", var_02, "inUse");
    if(var_03) {
      var_04 = getmatchdata("players", self.var_2418, "loadouts", var_02, "name");
      if(self.var_5DEE.var_2319 == var_04) {
        self.var_2943 = var_02;
        self.var_294A = self.var_5DEE.var_7709.var_48CA;
        self.var_294C = self.var_5DEE.var_835D.var_48CA;
        return;
      }

      continue;
    }

    var_00 = var_02;
    break;
  }

  if(var_00 < 0 || var_00 >= var_01) {
    var_00 = var_01 - 1;
  }

  self.var_2943 = var_00;
  setmatchdata("players", self.var_2418, "loadouts", var_00, "name", self.var_5DEE.var_2319);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "inUse", 1);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 0, "weapon", self.var_5DEE.var_7709.var_48CA);
  for(var_05 = 0; var_05 < self.var_5DEE.var_76F3.size; var_05++) {
    if(var_05 < 6) {
      setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 0, "attachment", var_05, self.var_5DEE.var_76F3[var_05]);
    }
  }

  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 0, "camo", self.var_5DEE.var_76F5);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 0, "camo2", self.var_5DEE.var_76F4);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 0, "reticle", self.var_5DEE.var_7700);
  if(isDefined(self.var_5DEE.var_0144)) {
    setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 0, "customization", self.var_5DEE.var_0144);
  }

  if(isDefined(self.var_5DEE.primarycharmguid)) {
    setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 0, "charm", self.var_5DEE.primarycharmguid);
  }

  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 1, "weapon", self.var_5DEE.var_835D.var_48CA);
  for(var_05 = 0; var_05 < self.var_5DEE.var_8353.size; var_05++) {
    if(var_05 < 6) {
      setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 1, "attachment", var_05, self.var_5DEE.var_8353[var_05]);
    }
  }

  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 1, "camo", self.var_5DEE.var_8355);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 1, "camo2", self.var_5DEE.var_8354);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 1, "reticle", self.var_5DEE.var_8359);
  if(isDefined(self.var_5DEE.var_0176)) {
    setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 1, "customization", self.var_5DEE.var_0176);
  }

  if(isDefined(self.var_5DEE.secondarycharmguid)) {
    setmatchdata("players", self.var_2418, "loadouts", var_00, "weaponSetups", 1, "charm", self.var_5DEE.secondarycharmguid);
  }

  setmatchdata("players", self.var_2418, "loadouts", var_00, "division", self.var_5DEE.var_0079);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "equipmentSetups", 0, "equipment", self.var_5DEE.var_37FE.var_48CA);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "equipmentSetups", 0, "numExtra", self.var_5DEE.var_37FD);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "equipmentSetups", 1, "equipment", self.var_5DEE.var_69AD.var_48CA);
  setmatchdata("players", self.var_2418, "loadouts", var_00, "equipmentSetups", 1, "numExtra", self.var_5DEE.var_69AC);
  for(var_05 = 0; var_05 < self.var_5DEE.var_6F69.size; var_05++) {
    if(var_05 < 9) {
      setmatchdata("players", self.var_2418, "loadouts", var_00, "perkSlots", var_05, self.var_5DEE.var_6F69[var_05]);
    }
  }

  if(isDefined(self.var_5DEE.var_5A62)) {
    setmatchdata("players", self.var_2418, "killstreak_guids", 0, self.var_5DEE.var_5A62);
  }

  if(isDefined(self.var_5DEE.var_5A63)) {
    setmatchdata("players", self.var_2418, "killstreak_guids", 1, self.var_5DEE.var_5A63);
  }

  if(isDefined(self.var_5DEE.var_5A64)) {
    setmatchdata("players", self.var_2418, "killstreak_guids", 2, self.var_5DEE.var_5A64);
  }

  if(isDefined(self.var_5DEE.var_5A65)) {
    setmatchdata("players", self.var_2418, "killstreak_guids", 3, self.var_5DEE.var_5A65);
  }

  self.var_294A = self.var_5DEE.var_7709.var_48CA;
  self.var_294C = self.var_5DEE.var_835D.var_48CA;
}

func_4560() {
  var_00 = spawnStruct();
  var_00.var_2319 = "aitype";
  var_00.var_231B = undefined;
  var_00.var_985A = "none";
  var_00.var_23D9 = 0;
  var_00.var_2669 = 0;
  var_00.var_1E26 = 0;
  var_00.var_7615 = 0;
  var_00.var_56FE = 0;
  var_00.var_0079 = 5;
  var_00.var_7709 = maps\mp\_utility::func_473D(self.var_01D0);
  for(var_01 = 0; var_01 < 6; var_01++) {
    var_00.var_76F3[var_01] = 0;
  }

  var_00.var_76F5 = 0;
  var_00.var_76F4 = 0;
  var_00.var_7700 = 0;
  var_00.var_0144 = 0;
  var_00.var_76F8 = func_1D66(self.var_01D0, var_00.var_76F3[0], var_00.var_76F3[1], var_00.var_76F3[2], var_00.var_76F3[3], var_00.var_76F3[4], var_00.var_76F3[5], 0, var_00.var_76F5, var_00.var_76F4, var_00.var_7700, var_00.var_0144, self, self.var_0079);
  var_00.var_835D = maps\mp\_utility::func_473D(self.var_8C3C);
  for(var_01 = 0; var_01 < 6; var_01++) {
    var_00.var_5E02[var_01] = 0;
  }

  var_00.var_8355 = 0;
  var_00.var_8354 = 0;
  var_00.var_8359 = 0;
  var_00.var_0176 = 0;
  var_00.var_8358 = func_1D66(self.var_8C3C, var_00.var_5E02[0], var_00.var_5E02[1], var_00.var_5E02[2], var_00.var_5E02[3], var_00.var_5E02[4], var_00.var_5E02[5], 0, var_00.var_8355, var_00.var_8354, var_00.var_8359, var_00.var_0176, self, self.var_0079);
  var_00.var_37FE = maps\mp\_utility::func_44CF(self.var_00B4);
  var_00.var_37FA = 0;
  var_00.var_69AD = maps\mp\_utility::func_44CE(0, 0);
  var_00.var_69AA = 0;
  var_00.var_6F69 = [];
  for(var_01 = 0; var_01 < 9; var_01++) {
    var_00.var_6F69[var_01] = 0;
  }

  var_00.var_5A62 = 0;
  var_00.var_5A63 = 0;
  var_00.var_5A64 = 0;
  var_00.var_5A65 = 0;
  var_00.var_59DA = 0;
  var_00.var_870C = 1;
  return var_00;
}

func_4791() {
  self.var_5DEE = func_4560();
  self.var_5097 = 1;
  func_09A7(self.var_5DEE);
}

func_0F35() {
  var_00 = self.var_5DEE;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  if(!isDefined(self.var_5DEE)) {
    return;
  }

  var_06 = level.var_47C4;
  if(!isDefined(var_06)) {
    var_06 = ::maps\mp\_utility::func_0642;
  }

  var_07 = 0;
  if(isDefined(self.var_012C) && isDefined(self.var_012C["hasSerumBasicTraining"]) && self.var_012C["hasSerumBasicTraining"]) {
    var_07 = 1;
  }

  var_08 = 0;
  if(isDefined(self.var_012C) && isDefined(self.var_012C["hasSpecialistPerkStreak"]) && self.var_012C["hasSpecialistPerkStreak"]) {
    var_08 = 1;
  }

  var_09 = 0;
  if(isDefined(self.var_012C) && isDefined(self.var_012C["hasSupportStreaks"]) && self.var_012C["hasSupportStreaks"]) {
    var_09 = 1;
  }

  var_0A = 0;
  if(isDefined(self.var_012C) && isDefined(self.var_012C["hasKillStreaks"]) && self.var_012C["hasKillStreaks"]) {
    var_0A = 1;
  }

  var_0B = 0;
  if(isDefined(self.var_012C) && isDefined(self.var_012C["hasFourthStreak"]) && self.var_012C["hasFourthStreak"]) {
    var_0B = 1;
  }

  var_0C = 5;
  if(isDefined(self.var_0079)) {
    var_0C = self.var_0079;
  }

  self.var_5DEE = undefined;
  self.var_90E4 = var_00;
  if(!maps\mp\gametypes\_hud_util::func_5527()) {
    maps\mp\gametypes\_division_change::func_A050();
  }

  self takeallweapons();
  maps\mp\_utility::func_05E4();
  if(!isDefined(self.var_5097) || !self.var_5097) {
    func_05FF();
  }

  self.var_20CC = undefined;
  if(var_00.var_2669) {
    func_864F("copycat");
  }

  self.var_231B = var_00.var_231B;
  self.var_5E00 = var_00.var_7709;
  self.var_5DFE = var_00.var_76F8;
  self.var_5DFC = var_00.var_76F5;
  self.var_5DFB = var_00.var_76F4;
  self.var_5DFD = var_00.var_0144;
  self.loadoutprimarypaintjobid = var_00.primarypaintjobid;
  self.var_5DFF = var_00.var_7700;
  self.loadoutprimarycharmguid = var_00.primarycharmguid;
  self.var_5E08 = var_00.var_835D;
  self.var_5E06 = var_00.var_8358;
  self.var_5E04 = var_00.var_8355;
  self.var_5E03 = var_00.var_8354;
  self.var_5E05 = var_00.var_0176;
  self.loadoutsecondarypaintjobid = var_00.secondarypaintjobid;
  self.loadoutsecondarycharmguid = var_00.secondarycharmguid;
  self.var_5E07 = var_00.var_8359;
  maps\mp\_utility::func_06D4(var_0C, var_00.var_0079);
  self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
  var_0D = 0;
  if(!isDefined(level.var_585D) || !level.var_585D) {
    self setclientomnvar("ui_show_division_shotgun_ability_prompt", 0);
    self setclientomnvar("ui_show_division_smg_ability_prompt", 0);
    self setclientomnvar("ui_show_division_rifle_ability_prompt", 0);
    self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);
    self setclientomnvar("ui_show_rifle_grenade_ability_prompt", 0);
    self setclientomnvar("ui_show_division_resistance_ability_prompt", 0);
    self setclientomnvar("ui_show_shield_charge_ability_prompt", 0);
    self setclientomnvar("ui_show_zk383_smg_altmode_prompt", 0);
    self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 0);
    if(self method_85EC() && (maps\mp\_utility::func_472A(self.var_5DFE) == "weapon_shotgun" && issubstr(self.var_5DFE, "dragon_breath")) || maps\mp\_utility::func_472A(self.var_5E06) == "weapon_shotgun" && issubstr(self.var_5E06, "dragon_breath")) {
      self setclientomnvar("ui_show_division_shotgun_ability_prompt", 1);
      var_0D = 1;
    } else if(self method_85EC() && (maps\mp\_utility::func_472A(self.var_5DFE) == "weapon_smg" && issubstr(self.var_5DFE, "suppressor")) || maps\mp\_utility::func_472A(self.var_5E06) == "weapon_smg" && issubstr(self.var_5E06, "suppressor")) {
      self setclientomnvar("ui_show_division_smg_ability_prompt", 1);
      var_0D = 1;
    }

    if(self method_85EC() && (maps\mp\_utility::func_472A(self.var_5DFE) == "weapon_assault" && issubstr(self.var_5DFE, "grenade_launcher")) || maps\mp\_utility::func_472A(self.var_5E06) == "weapon_assault" && issubstr(self.var_5E06, "grenade_launcher")) {
      self setclientomnvar("ui_show_rifle_grenade_ability_prompt", 1);
      var_0D = 1;
    }

    if(self method_85EC() && (maps\mp\_utility::func_472A(self.var_5DFE) == "weapon_shotgun" && issubstr(self.var_5DFE, "m30_rifle")) || maps\mp\_utility::func_472A(self.var_5E06) == "weapon_shotgun" && issubstr(self.var_5E06, "m30_rifle")) {
      var_0D = 1;
    }

    if(self method_85EC() && maps\mp\_utility::func_472A(self.var_5DFE) == "weapon_heavy" || maps\mp\_utility::func_472A(self.var_5E06) == "weapon_heavy") {
      var_0D = 1;
    }

    if(self method_85EC() && issubstr(self.var_5DFE, "zk383") || issubstr(self.var_5E06, "zk383")) {
      var_0D = 1;
    }

    for(var_0E = 0; var_0E < 9; var_0E++) {
      if(var_00.var_6F69[var_0E] == 73400499 && self method_85EC()) {
        var_0D = 1;
      }
    }
  }

  self.var_012C["loadoutContainsAltSwitchWeapon"] = var_0D;
  var_0F = func_4585(var_00);
  if(var_0F != "none") {
    self[[var_06]](var_0F);
  }

  var_00.var_60EE = var_0F;
  var_10 = var_00.var_8358;
  if(var_10 != "none") {
    self[[var_06]](var_10, undefined, var_00.secondarypaintjobid, var_00.secondarycharmguid);
  }

  if(level.var_2EF3) {
    maps\mp\_utility::func_47A2("specialty_pistoldeath");
  }

  func_5DF1(var_00.var_37FE, var_00.var_6F69);
  maps\mp\perks\_perks::func_0F36();
  if(maps\mp\_utility::func_0649("specialty_perkstreaks")) {
    if(maps\mp\perks\_perkfunctions::handlespecialisttrainingunlocks()) {
      maps\mp\perks\_perks::func_0F36();
    }
  }

  func_4781();
  if(isDefined(level.var_6AB9)) {
    [[level.var_6AB9]](var_00);
  }

  if(isDefined(var_00.var_37FE) && isDefined(var_00.var_37FE.var_48CA) && var_00.var_37FE.var_48CA == 16805888 && isDefined(self.var_01A7)) {
    var_11 = self.var_01A7;
    if(common_scripts\utility::func_562E(level.var_9565)) {
      if(game["switchedsides"]) {
        var_11 = maps\mp\_utility::func_45DE(var_11);
      }
    }

    if(var_11 == "axis") {
      var_00.var_37FE.var_48CA = 17084416;
      var_01 = 1;
    }
  }

  var_12 = maps\mp\_utility::func_44CD(var_00.var_37FE);
  self method_8349(var_12);
  self.var_6088 = 1;
  if(var_00.var_37FE.var_48CA != 0 && self hasweapon(var_12)) {
    var_13 = self getweaponammoclip(var_12);
    self method_82FA(var_12, var_13 + 1);
  } else {
    func_479F(var_12);
  }

  if(isDefined(var_00.var_37FD) && var_00.var_37FD > 0) {
    if(var_00.var_37FD == 2) {
      maps\mp\_utility::func_47A2("specialty_twoextralethal");
    } else {
      maps\mp\_utility::func_47A2("specialty_extralethal");
    }

    var_13 = self getweaponammoclip(var_12);
    self method_82FA(var_12, var_13 + var_00.var_37FD);
    self.var_6088 = self.var_6088 + var_00.var_37FD;
  }

  if(var_01) {
    var_00.var_37FE.var_48CA = 16805888;
  }

  var_14 = var_00.var_76F8;
  if(maps\mp\_utility::func_0649("specialty_randomgun") && var_14 == "none") {
    var_14 = self.curwunderlustgun;
  }

  var_14 = maps\mp\_utility::func_922B(var_14);
  self[[var_06]](var_14, undefined, var_00.primarypaintjobid, var_00.primarycharmguid);
  if(!isai(self)) {
    self switchtoweapon(var_14);
  }

  if(var_14 == "riotshield_mp" && level.var_5139) {
    self notify("weapon_change", "riotshield_mp");
  }

  if(var_00.var_870C) {
    var_15 = 0;
    if(isDefined(level.var_50CA)) {
      var_15 = level.var_50CA;
    }

    var_16 = maps\mp\_utility::func_4340(var_00);
    if(maps\mp\_utility::func_0649("specialty_randomgun")) {
      var_16 = self.curwunderlustgun;
    }

    self setspawnweapon(var_16, !maps\mp\_utility::func_551F() || var_15, !maps\mp\_utility::func_3FA0("prematch_done"));
  }

  self.var_012C["primaryWeapon"] = maps\mp\_utility::func_4431(var_14);
  if(isDefined(var_00.var_69AD) && isDefined(var_00.var_69AD.var_48CA) && var_00.var_69AD.var_48CA == 17133568 && isDefined(self.var_0079) && self.var_0079 == 4) {
    var_17 = maps\mp\gametypes\_divisions::func_461D(self.var_0079);
    if(var_17 == "specialty_class_expeditionary_grandmaster" || var_17 == "specialty_class_expeditionary_master") {
      var_00.var_69AD.var_48CA = 17293312;
      var_05 = 1;
    }
  }

  if(isDefined(var_00.var_69AD) && isDefined(var_00.var_69AD.var_48CA) && var_00.var_69AD.var_48CA == 16809984) {
    if(isDefined(self.var_01A7) && self.var_01A7 == "axis") {
      if(isDefined(self.var_0079) && self.var_0079 == 4) {
        var_17 = maps\mp\gametypes\_divisions::func_461D(self.var_0079);
        if(var_17 == "specialty_class_expeditionary_grandmaster" || var_17 == "specialty_class_expeditionary_master") {
          var_00.var_69AD.var_48CA = 17301504;
          var_04 = 1;
        }
      }

      if(!var_04) {
        var_00.var_69AD.var_48CA = 17203200;
        var_02 = 1;
      }
    } else if(isDefined(self.var_0079) && self.var_0079 == 4) {
      var_17 = maps\mp\gametypes\_divisions::func_461D(self.var_0079);
      if(var_17 == "specialty_class_expeditionary_grandmaster" || var_17 == "specialty_class_expeditionary_master") {
        var_00.var_69AD.var_48CA = 17297408;
        var_03 = 1;
      }
    }
  }

  self.var_5DF8 = var_00.var_69AD;
  var_18 = maps\mp\_utility::func_44CD(var_00.var_69AD);
  self method_831E(var_18);
  func_479F(var_18);
  self.var_60A0 = 1;
  if(isDefined(var_00.var_69AC) && var_00.var_69AC > 0) {
    if(var_00.var_69AC == 2) {
      maps\mp\_utility::func_47A2("specialty_twoextratactical");
    } else {
      maps\mp\_utility::func_47A2("specialty_extratactical");
    }

    var_13 = self getweaponammoclip(var_18);
    self method_82FA(var_18, var_13 + var_00.var_69AC);
    self.var_60A0 = self.var_60A0 + var_00.var_69AC;
  }

  if(var_02 || var_04 || var_03) {
    var_00.var_69AD.var_48CA = 16809984;
  }

  if(var_05) {
    var_00.var_69AD.var_48CA = 17133568;
  }

  self.var_7704 = var_14;
  self.var_835A = var_10;
  self.var_60FA = var_0F;
  if(var_00.var_23D9) {
    self method_82FA(self.var_7704, 0);
    self setweaponammostock(self.var_7704, 0);
  }

  self.var_57D6 = function_01AA(self.var_7704) == "sniper";
  maps\mp\_utility::func_861B();
  var_19 = var_00.var_5A62;
  var_1A = var_00.var_5A63;
  var_1B = var_00.var_5A64;
  var_1C = var_00.var_5A65;
  if(!maps\mp\_utility::func_551F()) {
    var_1D = 0;
    var_1E = 0;
    var_1F = 0;
    var_20 = 0;
    var_21 = 0;
    if(!isDefined(level.dlc2wardogfightactive) || !level.dlc2wardogfightactive) {
      if(maps\mp\_utility::func_579B()) {
        var_19 = 0;
        var_1A = 0;
        var_1B = 0;
        var_1C = 0;
      }

      if(isDefined(self.var_6F65) && isDefined(self.var_6F65["specialty_sessionProgressionA"]) && self.var_6F65["specialty_sessionProgressionA"]) {
        var_1D = 1;
      }

      self.var_012C["hasSerumBasicTraining"] = var_1D;
      if(var_1D) {
        var_1C = var_1B;
        var_1B = var_1A;
        var_1A = var_19;
        var_19 = 69206048;
      }

      if(isDefined(self.var_6F65) && isDefined(self.var_6F65["specialty_perkstreaks"]) && self.var_6F65["specialty_perkstreaks"]) {
        var_1E = 1;
      }

      self.var_012C["hasSpecialistPerkStreak"] = var_1E;
      if(var_1E) {
        var_19 = 0;
        var_1A = 0;
        var_1B = 0;
        var_1C = 0;
      }

      if(isDefined(self.var_6F65) && isDefined(self.var_6F65["specialty_supportstreaks"]) && self.var_6F65["specialty_supportstreaks"]) {
        var_1F = 1;
      }

      self.var_012C["hasSupportStreaks"] = var_1F;
      if(isDefined(self.var_6F65) && isDefined(self.var_6F65["specialty_killstreaks"]) && self.var_6F65["specialty_killstreaks"]) {
        var_20 = 1;
      }

      self.var_012C["hasKillStreaks"] = var_20;
      if(isDefined(self.var_6F65) && isDefined(self.var_6F65["specialty_fourthstreak"]) && self.var_6F65["specialty_fourthstreak"]) {
        var_21 = 1;
      }

      self.var_012C["hasFourthStreak"] = var_21;
      if(!var_21 && !var_1D) {
        var_1C = 0;
      }
    }

    func_86B9(var_19, var_1A, var_1B, var_1C, var_00.var_1E26, var_00.var_7615, var_00.var_2669, var_00.var_56FE, var_00.var_985A);
    var_22 = 0;
    if(var_09 != var_1F || var_0A != var_20 || var_0B != var_21 || var_08 != var_1E || var_07 != var_1D) {
      var_22 = 1;
    }

    if(var_00.var_59DA && var_07 == var_1D) {
      var_22 = 0;
    } else if(!maps\mp\_utility::func_0F5C()) {
      var_22 = 0;
    } else if(function_01EF(self)) {
      var_22 = 0;
    } else if(!isDefined(self.var_5B84)) {
      var_22 = 0;
    } else if(!isbot(self) && self.var_5B84 == self.var_2319 && !isDefined(self.var_3FC4) && self.var_3FC4) {
      var_22 = 0;
    } else if(isbot(self) && self.var_1A56 == self.var_1994) {
      var_22 = 0;
    }

    var_00.var_59DA = !var_22;
    if(var_22) {
      if(maps\mp\_utility::func_A875() || self.var_5B84 != "") {
        var_23 = [];
        var_24 = 0;
        var_25 = self.var_012C["killstreaks"];
        var_26 = 0;
        if(var_26) {
          if(var_25.size > 5) {
            for(var_0E = 5; var_0E < var_25.size; var_0E++) {
              var_23[var_24] = var_25[var_0E].var_944C;
              var_24++;
            }
          }

          if(var_25.size) {
            for(var_0E = 1; var_0E < 5; var_0E++) {
              if(isDefined(var_25[var_0E]) && isDefined(var_25[var_0E].var_944C) && var_25[var_0E].var_944C != "basic_training_serum" && var_25[var_0E].var_13AF) {
                var_23[var_24] = var_25[var_0E].var_944C;
                var_24++;
              }
            }
          }
        }

        self notify("givingLoadout");
        var_27 = var_09 != var_1F || var_0A != var_20 || var_0B != var_21 || var_08 != var_1E;
        if(!var_27 && var_07 != var_1D) {
          maps\mp\killstreaks\_killstreaks::transferkillstreaks();
        } else {
          maps\mp\killstreaks\_killstreaks::func_2400(var_27);
        }

        for(var_0E = 0; var_0E < var_23.size; var_0E++) {
          maps\mp\killstreaks\_killstreaks::func_478D(var_23[var_0E], undefined, undefined, undefined);
        }
      }
    }

    self setclientomnvar("ui_killstreak_scorestreak_switch", var_0A != var_20 || var_08 != var_1E);
    self.var_5DF6 = var_00.var_59DA;
  }

  if(isDefined(self.var_5B84) && self.var_5B84 != "" && self.var_5B84 != self.var_2319) {
    self notify("changed_class");
  }

  self.var_012C["lastClass"] = self.var_2319;
  self.var_5B84 = self.var_2319;
  if(isDefined(self.var_3FC5)) {
    self.var_012C["class"] = self.var_3FC5;
    self.var_012C["lastClass"] = self.var_3FC5;
    self.var_2319 = self.var_3FC5;
    if(!isDefined(self.var_3FC4) || var_06.var_59DA) {
      self.var_5B84 = self.var_3FC5;
    }

    self.var_3FC5 = undefined;
  }

  self.var_3FC4 = undefined;
  var_28 = self.var_01A7;
  if(common_scripts\utility::func_562E(level.var_9565)) {
    if(game["switchedsides"]) {
      var_28 = maps\mp\_utility::func_45DE(var_28);
    }
  }

  if((!isDefined(self.var_5097) || !self.var_5097) && !isDefined(level.var_585D) || !level.var_585D) {
    if(function_0367()) {
      self.var_267E = func_1F99(common_scripts\utility::func_46AF());
    } else if(!isDefined(self.var_267E) || self.var_267E.size == 0) {
      if(maps\mp\_utility::func_761E()) {
        self.var_267E = maps\mp\gametypes\_teams::func_4636();
      } else if(isbot(self)) {
        if(var_28 == "axis") {
          if(isDefined(self.var_0079) && self.var_0079 != 5) {
            var_29 = getdivisioncostume(self.var_0079, 0);
          } else {
            var_29 = function_0332();
          }

          self.var_147C = var_29;
          self.var_267E = var_29;
        } else {
          if(isDefined(self.var_0079) && self.var_0079 != 5) {
            var_29 = getdivisioncostume(self.var_0079, 1);
          } else {
            var_29 = getdivisioncostume(0, 1);
          }

          self.var_267E = var_29;
        }

        func_21B9();
      } else if(isPlayer(self)) {
        if(isDefined(self.var_0079) && self.var_0079 != 5) {
          if(!function_03AF() && !maps\mp\_utility::func_56B1()) {
            var_2A = func_1F93(self.var_0079, var_29);
            self.var_267E = func_1F97(var_2A);
            self setrankedplayerdata(common_scripts\utility::func_46A9(), "activeCostume", var_2A);
          } else {
            self.var_267E = getdivisioncostume(self.var_0079, var_29 == "allies");
          }

          var_29 = func_1F95();
          self.var_267E[1] = var_29[1];
        } else if(var_29 == "axis") {
          if(!isDefined(self.var_147C)) {
            self.var_147C = maps\mp\gametypes\_teams::func_4430();
          }

          self.var_267E = self.var_147C;
          var_29 = func_1F95();
          self.var_267E[1] = var_29[1];
        } else {
          self.var_267E = func_1F95();
        }

        func_21B9();
      } else if(function_01EF(self) && self.var_0A4B == "player") {
        self.var_267E = maps\mp\gametypes\_teams::func_448C();
      }
    } else if(isPlayer(self) && !isai(self)) {
      if(isDefined(self.var_0079) && self.var_0079 != 5) {
        if(!function_03AF() && !maps\mp\_utility::func_56B1()) {
          var_2A = func_1F93(self.var_0079, var_29);
          self.var_267E = func_1F97(var_2A);
          self setrankedplayerdata(common_scripts\utility::func_46A9(), "activeCostume", var_2A);
        } else {
          self.var_267E = getdivisioncostume(self.var_0079, var_29 == "allies");
        }

        var_29 = func_1F95();
        self.var_267E[1] = var_29[1];
      } else if(var_29 == "axis") {
        if(!isDefined(self.var_147C)) {
          self.var_147C = maps\mp\gametypes\_teams::func_4430();
        }

        self.var_267E = self.var_147C;
        var_29 = func_1F95();
        self.var_267E[1] = var_29[1];
      } else {
        self.var_267E = func_1F95();
      }

      func_21B9();
    }

    if(!function_01EF(self) && !maps\mp\gametypes\_teams::func_A27D(self.var_267E, var_29)) {
      if(isDefined(self.var_83F4) && maps\mp\gametypes\_teams::func_A27D(self.var_83F4, var_29)) {
        self.var_267E = self.var_83F4;
      } else {
        if(var_29 == "axis") {
          self.var_267E = maps\mp\gametypes\_teams::func_4430();
        } else {
          self.var_267E = maps\mp\gametypes\_teams::func_448C();
        }

        self.var_83F4 = self.var_267E;
      }
    }

    func_5EA3();
    maps\mp\gametypes\_teams::func_7427(self.var_012C["primaryWeapon"], maps\mp\_utility::func_4431(var_1C));
  }

  if(maps\mp\_utility::func_0649("specialty_extraammo")) {
    if(var_1E != "none") {
      self givemaxammo(var_1E);
    }

    if(var_1C != "none" && maps\mp\_utility::func_472A(var_1C) != "weapon_projectile") {
      self givemaxammo(var_1C);
    }
  }

  maps\mp\gametypes\_weapons::func_A13B();
  self.var_012C["altModeActive"] = 0;
  self.var_012C["dragonBreathActive"] = 0;
  self.var_012C["rifleGrenadeActive"] = 0;
  maps\mp\perks\_perks::func_1E15();
  func_477C(var_07);
  if(!maps\mp\gametypes\_hud_util::func_5527()) {
    thread maps\mp\gametypes\_division_change::func_8622(self.var_0079, var_1E);
  }

  level notify("broadcasterLoadoutChanged", self.var_2418);
}

func_449A(param_00) {
  var_01 = [1, 52, 24, 51, 51, 44, 44, 51, 52, 51];
  return var_01[param_00];
}

func_4585(param_00) {
  var_01 = param_00.var_509D;
  if(isDefined(param_00.var_509D) && var_01) {
    return "none";
  }

  var_02 = "shovel_mp";
  var_03 = param_00.var_60FC;
  if(isDefined(var_03)) {
    var_04 = maps\mp\_utility::func_4737(var_03);
    if(var_04 != "none") {
      var_02 = var_04;
    }
  }

  return var_02;
}

func_5EA3() {
  if(function_0367() || function_01EF(self)) {
    return;
  }

  if(!isDefined(self.var_2684)) {
    var_00 = func_1F98("head");
    var_01 = func_1F96();
    var_02 = func_1F9A("shirt", var_01);
    var_03 = func_1F9A("pants", var_01);
    var_04 = func_1F9A("eyewear", var_01);
    var_05 = func_1F9A("hat", var_01);
    var_06 = func_1F9A("gear", var_01);
    setmatchdata("players", self.var_2418, "costume", "head", var_00);
    setmatchdata("players", self.var_2418, "costume", "shirt", var_02);
    setmatchdata("players", self.var_2418, "costume", "pants", var_03);
    setmatchdata("players", self.var_2418, "costume", "eyewear", var_04);
    setmatchdata("players", self.var_2418, "costume", "hat", var_05);
    setmatchdata("players", self.var_2418, "costume", "gear", var_06);
    self.var_2684 = 1;
  }
}

func_4773(param_00, param_01, param_02, param_03) {
  func_4790(param_00, param_01, param_02, param_03);
  func_0F35();
}

func_4774() {
  func_4791();
  func_0F35();
}

func_4781() {
  self.var_907E = 0;
  if(!maps\mp\_utility::func_0649("specialty_blindeye") && !isDefined(self.var_1444) || self.var_1444 > 0) {
    thread maps\mp\perks\_perks::func_4778();
  }

  if(maps\mp\_utility::func_0649("specialty_class_fightorfight")) {
    thread maps\mp\perks\_perkfunctions::func_A060();
  }
}

func_7B3D() {
  if(isDefined(self) && isDefined(self.var_012C) && isDefined(self.var_012C["validationInfractions"])) {
    self.var_012C["validationInfractions"] = self.var_012C["validationInfractions"] + 1;
  }
}

func_05FF() {
  self.var_3EF6 = undefined;
  self.var_14EA = undefined;
  self.var_4BF2 = undefined;
  self detachall();
}

func_479F(param_00) {
  var_01 = level.var_47C4;
  if(!isDefined(var_01)) {
    var_01 = ::maps\mp\_utility::func_0642;
  }

  switch (param_00) {
    case "specialty_null":
    case "none":
      break;

    case "frag_grenade_german_mp":
    case "explosive_gel_mp":
    case "throwingknife_mp":
    case "c4_mp":
    case "claymore_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      maps\mp\_utility::func_47A2(param_00);
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
    case "stun_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "s2_tactical_insertion_cavalry_mp":
    case "s2_tactical_insertion_device_mp":
    case "portable_radar_mp":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
      self[[var_01]](param_00);
      break;

    default:
      if(isDefined(level.var_585D) && level.var_585D) {
        self[[var_01]](param_00, undefined, undefined, undefined);
        return;
      }
      break;
  }
}

func_95EE(param_00) {
  switch (param_00) {
    case "specialty_null":
    case "none":
      break;

    case "s2_tactical_insertion_device_mp":
    case "frag_grenade_german_mp":
    case "explosive_gel_mp":
    case "throwingknife_mp":
    case "c4_mp":
    case "claymore_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      maps\mp\_utility::func_0735(param_00);
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
    case "stun_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "s2_tactical_insertion_cavalry_mp":
    case "portable_radar_mp":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
      self takeweapon(param_00);
      break;

    default:
      break;
  }
}

func_5DF1(param_00, param_01) {
  for(var_02 = 0; var_02 < 9; var_02++) {
    param_01[var_02] = maps\mp\perks\_perks::func_A277(var_02, param_01[var_02]);
  }

  self.var_5DFA = param_01;
  self.var_5DF5 = param_00;
  for(var_02 = 0; var_02 < 9; var_02++) {
    if(param_01[var_02] != 0) {
      maps\mp\_utility::func_47A3(param_01[var_02], var_02);
    }
  }
}

func_0F0E(param_00) {
  foreach(var_02 in param_00) {
    if(maps\mp\_utility::func_4429(var_02) == "rail" || var_02 == "zoomscope" || var_02 == "ironsights") {
      return 1;
    }
  }

  return 0;
}

func_774F(param_00, param_01, param_02) {
  var_03 = param_01.size;
  if(var_03 > 1) {
    param_01 = common_scripts\utility::func_0C9E(param_01);
  }

  var_04 = function_0060(param_00);
  var_05 = [];
  foreach(var_07 in param_01) {
    var_08 = 0;
    foreach(var_0A in var_04) {
      if(var_07 == var_0A) {
        var_08 = 1;
        break;
      }
    }

    if(var_08) {
      var_05[var_05.size] = var_07;
      continue;
    }
  }

  return var_05;
}

func_0F72(param_00, param_01) {
  if(isDefined(param_01) && isstring(param_01) && param_01 != "none" && !common_scripts\utility::func_0F79(param_00, param_01)) {
    param_00[param_00.size] = param_01;
  }

  return param_00;
}

func_4432(param_00) {
  var_01 = maps\mp\_utility::func_452A(param_00);
  if(isguidaweapon(var_01)) {
    var_02 = getbaseweaponguid(var_01);
    var_03 = getitemreffromguid(var_02);
    return var_03;
  }

  return param_00;
}

func_1D66(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(!isDefined(param_00) || param_00 == "none" || param_00 == "") {
    return "none";
  }

  if(isDefined(param_01) && function_030D(param_01)) {
    param_01 = maps\mp\_utility::func_452B(param_01);
  }

  if(isDefined(param_02) && function_030D(param_02)) {
    param_02 = maps\mp\_utility::func_452B(param_02);
  }

  if(isDefined(param_03) && function_030D(param_03)) {
    param_03 = maps\mp\_utility::func_452B(param_03);
  }

  if(isDefined(param_04) && function_030D(param_04)) {
    param_04 = maps\mp\_utility::func_452B(param_04);
  }

  if(isDefined(param_05) && function_030D(param_05)) {
    param_05 = maps\mp\_utility::func_452B(param_05);
  }

  if(isDefined(param_06) && function_030D(param_06)) {
    param_06 = maps\mp\_utility::func_452B(param_06);
  }

  if(isDefined(param_0A) && param_0A != 0 && maps\mp\_utility::func_4429(param_01) != "scope" && maps\mp\_utility::func_4429(param_02) != "scope" && maps\mp\_utility::func_4429(param_03) != "scope" && maps\mp\_utility::func_4429(param_04) != "scope" && maps\mp\_utility::func_4429(param_05) != "scope" && maps\mp\_utility::func_4429(param_06) != "scope") {
    param_0A = 0;
  }

  param_01 = maps\mp\_utility::func_1151(param_01, param_00);
  param_02 = maps\mp\_utility::func_1151(param_02, param_00);
  param_03 = maps\mp\_utility::func_1151(param_03, param_00);
  param_04 = maps\mp\_utility::func_1151(param_04, param_00);
  param_05 = maps\mp\_utility::func_1151(param_05, param_00);
  param_06 = maps\mp\_utility::func_1151(param_06, param_00);
  var_0E = "";
  var_0F = param_00;
  var_10 = param_00.size;
  var_0E = param_00;
  var_11 = [];
  var_11 = func_0F72(var_11, param_01);
  var_11 = func_0F72(var_11, param_02);
  var_11 = func_0F72(var_11, param_03);
  var_11 = func_0F72(var_11, param_04);
  var_11 = func_0F72(var_11, param_05);
  var_11 = func_0F72(var_11, param_06);
  if(var_0F != "none" && isDefined(param_0C) && isDefined(param_0D) && param_0D != 5) {
    var_12 = maps\mp\gametypes\_division_change::func_440E(param_0C, param_0D, var_0F, 0, 0, var_11);
    foreach(var_14 in var_12) {
      var_11 = func_0F72(var_11, var_14);
    }
  }

  var_11 = func_774F(var_0F, var_11, param_00);
  if(isDefined(var_11[0]) && var_11[0] == "vzscope") {
    var_11[0] = var_0E + "scopevz";
  } else if(isDefined(var_11[1]) && var_11[1] == "vzscope") {
    var_11[1] = var_0E + "scopevz";
  } else if(isDefined(var_11[2]) && var_11[2] == "vzscope") {
    var_11[2] = var_0E + "scopevz";
  } else if(isDefined(var_11[3]) && var_11[3] == "vzscope") {
    var_11[3] = var_0E + "scopevz";
  } else if(isDefined(var_11[4]) && var_11[4] == "vzscope") {
    var_11[4] = var_0E + "scopevz";
  } else if(isDefined(var_11[5]) && var_11[5] == "vzscope") {
    var_11[5] = var_0E + "scopevz";
  }

  if(isDefined(var_11.size) && var_11.size) {
    for(var_16 = 0; var_16 < var_11.size; var_16++) {
      if(isDefined(var_11[var_16 + 1]) && common_scripts\utility::func_55AF(var_11[var_16], var_11[var_16 + 1])) {
        var_17 = var_11[var_16];
        var_11[var_16] = var_11[var_16 + 1];
        var_11[var_16 + 1] = var_17;
        var_16 = 0;
        continue;
      }
    }
  }

  foreach(var_19 in var_11) {
    var_0F = var_0F + "+" + var_19;
  }

  var_0F = func_1D68(var_0F, param_07);
  var_0F = func_1D67(var_0F, param_08, param_09);
  var_0F = func_1D6A(var_0F, param_0A);
  var_0F = func_1D69(var_0F, param_0B);
  return var_0F;
}

func_0F1E(param_00, param_01) {
  if(isDefined(param_01) && param_01.size) {
    return param_00 + "+" + param_01;
  }

  return param_00;
}

func_4447(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = int(tablelookup("mp/camoTable.csv", 1, param_00, 0));
  return var_01;
}

getcamo2indexfromitemref(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = int(tablelookup("mp/camo2Table.csv", 1, param_00, 0));
  return var_01;
}

func_4448(param_00) {
  if(!isDefined(param_00) || param_00 == 0) {
    return;
  }

  var_01 = func_4446(param_00);
  var_02 = tablelookup("mp/camoTable.csv", 0, var_01, 1);
  return var_02;
}

func_4446(param_00) {
  if(!isDefined(param_00) || param_00 == 0) {
    return 0;
  }

  var_01 = func_4447(getitemreffromguid(param_00));
  return var_01;
}

getcamo2indexfromguid(param_00) {
  if(!isDefined(param_00) || param_00 == 0) {
    return 0;
  }

  var_01 = getcamo2indexfromitemref(getitemreffromguid(param_00));
  return var_01;
}

func_A9EF(param_00) {
  if(!isDefined(param_00) || param_00 == 0) {
    return "";
  }

  return "cond" + param_00;
}

func_1D68(param_00, param_01) {
  param_00 = func_0F1E(param_00, func_A9EF(param_01));
  return param_00;
}

func_A9EC(param_00, param_01) {
  var_02 = "";
  if(isDefined(param_00)) {
    var_03 = isDefined(param_01) && param_01 > 0;
    if(param_00 > 0 || var_03) {
      var_02 = "camo";
      if(param_00 < 100) {
        var_02 = var_02 + "0";
      }

      if(param_00 < 10) {
        var_02 = var_02 + "0";
      }

      var_02 = var_02 + param_00;
      if(var_03) {
        if(param_01 < 100) {
          var_02 = var_02 + "0";
        }

        if(param_01 < 10) {
          var_02 = var_02 + "0";
        }

        var_02 = var_02 + param_01;
      }
    }
  }

  return var_02;
}

func_A9EE(param_00, param_01) {
  var_02 = func_A9EC(func_4447(param_00), getcamo2indexfromitemref(param_01));
  return var_02;
}

func_A9ED(param_00, param_01) {
  var_02 = func_A9EC(func_4446(param_00), getcamo2indexfromguid(param_01));
  return var_02;
}

func_1D67(param_00, param_01, param_02) {
  var_03 = func_0F1E(param_00, func_A9ED(param_01, param_02));
  return var_03;
}

func_4666(param_00) {
  var_01 = getitemreffromguid(param_00);
  var_02 = int(tablelookup("mp/reticleTable.csv", 1, var_01, 9));
  return var_02;
}

func_A9F1(param_00) {
  var_01 = "";
  if(!isDefined(param_00) || param_00 <= 0) {
    return var_01;
  }

  var_02 = func_4666(param_00);
  if(isDefined(var_02) && var_02 > 0) {
    var_01 = "scope";
    if(var_02 < 100) {
      var_01 = var_01 + "0";
    }

    if(var_02 < 10) {
      var_01 = var_01 + "0";
    }

    var_01 = var_01 + var_02;
  }

  return var_01;
}

func_1D6A(param_00, param_01) {
  var_02 = func_0F1E(param_00, func_A9F1(param_01));
  return var_02;
}

func_A9F0(param_00) {
  if(!isDefined(param_00) || param_00 == 0) {
    return "";
  }

  var_01 = "cust" + param_00;
  return var_01;
}

func_1D69(param_00, param_01) {
  var_02 = func_0F1E(param_00, func_A9F0(param_01));
  return var_02;
}

func_86B9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!maps\mp\_utility::func_0F5C()) {
    return;
  }

  self.var_5A71 = [];
  self.var_5A66 = [];
  var_09 = [];
  var_0A = [param_00, param_01, param_02, param_03];
  foreach(var_0C in var_0A) {
    if(isDefined(var_0C) && var_0C != 0) {
      var_0D = getitemreffromguid(var_0C);
      var_0E = maps\mp\killstreaks\_killstreaks::func_46B4(var_0D);
      var_0F = 0;
      for(var_0F = 0; var_0F < var_09.size; var_0F++) {
        if(var_09[var_0F].var_A281 == var_0E) {
          var_0E++;
          continue;
        }

        if(var_0E < var_09[var_0F].var_A281) {
          break;
        }
      }

      var_09[var_09.size] = spawnStruct();
      for(var_10 = var_09.size - 2; var_10 >= var_0F; var_10--) {
        var_09[var_10 + 1].var_0109 = var_09[var_10].var_0109;
        var_09[var_10 + 1].var_48CA = var_09[var_10].var_48CA;
        var_09[var_10 + 1].var_A281 = var_09[var_10].var_A281;
      }

      var_09[var_0F].var_0109 = var_0D;
      var_09[var_0F].var_48CA = var_0C;
      var_09[var_0F].var_A281 = var_0E;
    }
  }

  for(var_12 = 0; var_12 < var_09.size; var_12++) {
    self.var_5A71[var_12] = var_09[var_12].var_0109;
    self.var_5A66[var_12] = var_09[var_12].var_48CA;
  }
}

func_7D13() {
  var_00 = self.var_012C["team"];
  var_01 = self.var_012C["class"];
  var_02 = self getweaponslistall();
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    self givemaxammo(var_04);
    self method_82FA(var_04, 9999);
    if(var_04 == "claymore_mp" || var_04 == "claymore_detonator_mp") {
      self setweaponammostock(var_04, 2);
    }
  }

  if(self method_817F(level.var_231E[var_01]["primary"]["type"]) < level.var_231E[var_01]["primary"]["count"]) {
    self method_82FA(level.var_231E[var_01]["primary"]["type"], level.var_231E[var_01]["primary"]["count"]);
  }

  if(self method_817F(level.var_231E[var_01]["secondary"]["type"]) < level.var_231E[var_01]["secondary"]["count"]) {
    self method_82FA(level.var_231E[var_01]["secondary"]["type"], level.var_231E[var_01]["secondary"]["count"]);
  }
}

func_6B71() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isDefined(var_00.var_012C["class"])) {
      var_00.var_012C["class"] = "";
    }

    if(!isDefined(var_00.var_012C["lastClass"])) {
      var_00.var_012C["lastClass"] = "";
    }

    var_00.var_2319 = var_00.var_012C["class"];
    var_00.var_5B84 = var_00.var_012C["lastClass"];
    var_00.var_2E51 = 0;
    var_00.var_1905 = [];
    var_00.var_1906 = [];
  }
}

func_39C3(param_00, param_01) {
  wait(param_00);
  self fadeovertime(param_01);
  self.var_0018 = 0;
}

func_864F(param_00) {
  self.var_28D0 = param_00;
}

func_10E3() {
  if(!isDefined(level.var_7618)) {
    level.var_7618 = [];
    level.var_7619 = [];
    var_00 = function_027B(level.var_761A);
    for(var_01 = 1; var_01 < var_00; var_01++) {
      var_02 = tablelookupbyrow(level.var_761A, 0, var_01);
      if(isDefined(level.var_7618[var_02])) {
        level.var_7618[var_02][level.var_7618[var_02].size] = var_01 - 1;
        continue;
      }

      level.var_7618[var_02][0] = var_01 - 1;
    }

    var_03 = getarraykeys(level.var_7618);
    var_03 = common_scripts\utility::func_0C9E(var_03);
    for(var_01 = 0; var_01 < var_03.size; var_01++) {
      level.var_7619[var_03[var_01]] = var_01;
    }
  }

  self.var_012C["practiceRoundClasses"] = [];
  foreach(var_02, var_05 in level.var_7618) {
    var_06 = 0;
    if(isDefined(level.var_7619[var_02])) {
      var_06 = level.var_7619[var_02];
    }

    var_07 = 0;
    var_08 = randomintrange(0, var_05.size);
    if(isDefined(var_05[var_08])) {
      var_07 = var_05[var_08];
    }

    self.var_012C["practiceRoundClasses"][var_06] = var_07;
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "practiceRoundClassMap", var_06, self.var_012C["practiceRoundClasses"][var_06]);
  }
}

func_4635(param_00) {
  return self.var_012C["practiceRoundClasses"][param_00];
}

func_5E0A(param_00) {
  if(!maps\mp\_utility::func_761E()) {
    return 0;
  }

  var_01 = self.var_2319;
  var_02 = maps\mp\_utility::func_445D(var_01);
  if(!isDefined(var_01) || !isDefined(var_02)) {
    return 0;
  }

  var_03 = 1;
  if(var_02 == -1) {
    var_01 = self.var_012C["copyCatLoadout"]["className"];
    var_02 = maps\mp\_utility::func_445D(var_01);
    if(issubstr(var_01, "practice")) {
      var_02 = self.var_012C["copyCatLoadout"]["practiceClassNum"];
      var_03 = 0;
    }
  } else if(issubstr(var_01, "practice")) {
    var_02 = self.var_012C["practiceRoundClasses"][var_02];
    var_03 = 0;
  } else if(var_01 == "callback") {
    return 1;
  }

  var_04 = param_00.var_2319;
  var_05 = maps\mp\_utility::func_445D(var_04);
  if(!isDefined(var_04) || !isDefined(var_05)) {
    return 0;
  }

  var_06 = 1;
  if(var_05 == -1) {
    var_04 = param_00.var_012C["copyCatLoadout"]["className"];
    var_05 = maps\mp\_utility::func_445D(var_04);
    if(issubstr(var_04, "practice")) {
      var_05 = param_00.var_012C["copyCatLoadout"]["practiceClassNum"];
      var_06 = 0;
    }
  } else if(issubstr(var_04, "practice")) {
    var_05 = param_00.var_012C["practiceRoundClasses"][var_05];
    var_06 = 0;
  } else if(var_04 == "callback") {
    return 1;
  }

  return var_02 != var_05 || var_03 != var_06;
}

func_8657(param_00) {
  if(!maps\mp\_utility::func_761E()) {
    return;
  }

  self.var_2319 = "copycat";
  self.var_012C["class"] = "copycat";
  var_01 = param_00 func_242D();
  self.var_012C["copyCatLoadout"] = var_01;
  self.var_012C["copyCatLoadout"]["inUse"] = 1;
}

func_23DC() {
  self.var_012C["copyCatLoadout"]["inUse"] = 0;
}

func_5835(param_00, param_01) {
  var_02 = param_00;
  if(function_030D(param_00)) {
    var_02 = maps\mp\_utility::func_452B(param_00);
  }

  if(maps\mp\_utility::func_5856(var_02)) {
    var_02 = func_4432(var_02);
  }

  switch (var_02) {
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
    case "none":
    case "m1garand_mp":
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
      return isDefined(param_01) && param_01;

    default:
      func_7B3D();
      return 0;
  }
}

func_5839(param_00, param_01, param_02) {
  if(isDefined(param_01) && param_01 && func_5835(param_00)) {
    return 1;
  }

  var_03 = param_00;
  if(function_030D(param_00)) {
    var_03 = maps\mp\_utility::func_452B(param_00);
  }

  if(maps\mp\_utility::func_5856(var_03)) {
    var_03 = func_4432(var_03);
  }

  switch (var_03) {
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
      return (isDefined(param_02) && param_02) || maps\mp\_utility::isdivisionsglobaloverhaulenabled();

    default:
      func_7B3D();
      return 0;
  }
}

func_5820(param_00, param_01, param_02) {
  var_03 = 0;
  param_02 = 0;
  var_04 = maps\mp\_utility::func_452B(param_00);
  switch (var_04) {
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
      var_03 = 1;
      break;

    default:
      var_03 = 0;
      break;
  }

  var_05 = getsubstr(var_04, 2, 3);
  switch (var_05) {
    case "6":
    case "5":
    case "4":
    case "3":
    case "1":
    case "2":
      var_03 = 1;
      break;
  }

  if(var_03 && var_04 != "none") {
    var_06 = maps\mp\_utility::func_452B(param_01);
    var_07 = maps\mp\_utility::func_4723(var_06);
    var_03 = common_scripts\utility::func_0F79(var_07, var_04);
  }

  if(!var_03 && param_02) {
    func_7B3D();
  }

  return var_03;
}

func_567C(param_00, param_01) {
  if(maps\mp\_utility::func_56B1() || function_03AF()) {
    return 1;
  }

  var_02 = param_00;
  if(function_030D(param_00)) {
    var_02 = maps\mp\_utility::func_452B(param_00);
  }

  var_03 = func_4432(var_02);
  var_04 = var_03 + " " + param_01;
  if(!self method_85FD(var_04)) {
    return 0;
  }

  return 1;
}

func_5821(param_00, param_01) {
  if(param_00 == 0) {
    return 1;
  }

  var_02 = getitemfeaturetype(param_00);
  if(var_02 == 3 || var_02 == 2) {
    var_03 = getitemreffromguid(param_00);
    if(var_03 != "") {
      return 1;
    }
  }

  var_04 = getitemtype(param_00);
  if(var_04 == 1 || var_04 == 4) {
    var_03 = getitemreffromguid(param_00);
    if(var_03 != "") {
      return 1;
    }
  }

  func_7B3D();
  if(!isDefined(param_01) || !param_01) {}

  return 0;
}

func_5838(param_00, param_01) {
  if(param_00 == 0) {
    return 1;
  }

  var_02 = getitemprogressiontype(param_00);
  if(var_02 == 4) {
    var_03 = getitemreffromguid(param_00);
    if(var_03 != "") {
      return 1;
    }
  }

  var_04 = getitemtype(param_00);
  if(var_04 == 2) {
    var_03 = getitemreffromguid(param_00);
    if(var_03 != "") {
      return 1;
    }
  }

  func_7B3D();
  if(!isDefined(param_01) || !param_01) {}

  return 0;
}

func_5824(param_00, param_01) {
  if(param_00 == 0) {
    return 1;
  }

  if(param_00 >= 1 && param_00 < 2) {
    return 1;
  }

  func_7B3D();
  if(!isDefined(param_01) || !param_01) {}

  return 0;
}

func_56A0(param_00, param_01) {
  if(maps\mp\_utility::func_56B1() || function_03AF()) {
    return 1;
  }

  if(param_01 == 0) {
    return 1;
  }

  var_02 = maps\mp\_utility::func_452B(param_00);
  var_03 = func_4432(var_02);
  var_04 = maps\mp\_utility::func_452B(param_01);
  var_05 = var_03 + " " + var_04;
  if(!self method_85FD(var_05)) {
    return 0;
  }

  return 1;
}

func_5826(param_00, param_01, param_02) {
  if(param_01) {
    return func_5833(param_00, 0);
  }

  if(isDefined(param_02) && param_02) {
    var_03 = func_5833(param_00, 0);
    if(var_03) {
      return 1;
    }
  }

  switch (param_00) {
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
    case "claymore_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
    case "specialty_null":
    case "none":
      return 1;

    default:
      if(isDefined(level.var_5827)) {
        if([[level.var_5827]](param_00)) {
          return 1;
        }
      }

      func_7B3D();
      return 0;
  }
}

func_5682(param_00) {
  return param_00 == 0;
}

func_5833(param_00, param_01) {
  if(param_01) {
    return func_5826(param_00, 0);
  }

  switch (param_00) {
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
    case "stun_grenade_mp":
    case "flash_grenade_mp":
    case "s2_tactical_insertion_cavalry_mp":
    case "specialty_null":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
    case "none":
      return 1;

    default:
      if(isDefined(level.var_5834)) {
        if([[level.var_5834]](param_00)) {
          return 1;
        }
      }

      func_7B3D();
      return 0;
  }
}

func_582D(param_00) {
  if(param_00 == 0) {
    return 1;
  }

  var_01 = getitemprogressiontype(param_00);
  if(var_01 == 1) {
    var_02 = getitemreffromguid(param_00);
    if(var_02 != "") {
      return 1;
    }
  }

  func_7B3D();
  return 0;
}

func_7ECD() {
  return self getrankedplayerdata(common_scripts\utility::func_46A7(), "roleData", "roleId");
}

func_7ECE() {
  return self getrankedplayerdata(common_scripts\utility::func_46A7(), "roleData", "slotId");
}

func_4667(param_00, param_01) {
  var_02 = 0;
  if(param_01 == 0) {
    var_02 = 4;
  } else if(param_01 == 1) {
    var_02 = 6;
  } else {}

  return tablelookup("mp/roleTable.csv", 0, param_00, var_02);
}

func_09A7(param_00) {
  if(!getdvarint("1936") || maps\mp\_utility::func_551F()) {
    return;
  }

  if(!function_01EF(self)) {
    if(isDefined(level.var_446F)) {
      param_00.var_7ED2 = self[[level.var_446F]]();
      return;
    }

    param_00.var_7ECF = func_7ECD();
    param_00.var_8CA3 = func_7ECE();
    param_00.var_7ED2 = func_4667(param_00.var_7ECF, param_00.var_8CA3);
  }
}

func_477C(param_00) {
  if(!getdvarint("1936") || maps\mp\_utility::func_551F()) {
    return;
  }

  self endon("disconnect");
  var_01 = level.var_47C4;
  if(!isDefined(var_01)) {
    var_01 = ::maps\mp\_utility::func_0642;
  }

  if(isDefined(param_00.var_7ED2)) {
    self[[var_01]](param_00.var_7ED2);
  }
}