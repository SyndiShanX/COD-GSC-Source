/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_divisions.gsc
*********************************************/

getdivisionlevelingtablename() {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    return "mp/divisionLevelingOverhaul.csv";
  }

  return "mp/divisionLeveling.csv";
}

func_00D5() {
  func_52AC();
  func_52AD();
}

func_56CC(param_00) {
  switch (param_00) {
    case 5:
    case 4:
    case 3:
    case 2:
    case 1:
    case 0:
      return 1;

    case 6:
      return getdvarint("6021", 1) == 1;

    case 7:
      return getdvarint("6020", 1) == 1;

    case 8:
      return getdvarint("6019", 1) == 1;

    case 9:
      return getdvarint("6018", 0) == 1;

    case 10:
      return getdvarint("6017", 0) == 1;

    default:
      return 0;
  }
}

func_56CB(param_00) {
  switch (param_00) {
    case "artillery":
    case "scout":
    case "commando":
    case "grenadier":
    case "resistance":
    case "expeditionary":
    case "mountain":
    case "armored":
    case "airborne":
    case "infantry":
    case "none":
      return 1;

    default:
      return 0;
  }
}

func_44A0(param_00) {
  switch (param_00) {
    case 0:
      return "infantry";

    case 1:
      return "airborne";

    case 2:
      return "armored";

    case 3:
      return "mountain";

    case 4:
      return "expeditionary";

    case 6:
      return "resistance";

    case 7:
      return "grenadier";

    case 8:
      return "commando";

    case 9:
      return "scout";

    case 10:
      return "artillery";

    case 5:
    default:
      return "none";
  }
}

func_449C(param_00) {
  switch (param_00) {
    case "infantry":
      return 0;

    case "airborne":
      return 1;

    case "armored":
      return 2;

    case "mountain":
      return 3;

    case "expeditionary":
      return 4;

    case "resistance":
      return 6;

    case "grenadier":
      return 7;

    case "commando":
      return 8;

    case "scout":
      return 9;

    case "artillery":
      return 10;

    case "none":
    default:
      return 5;
  }
}

func_4498(param_00) {
  switch (param_00) {
    case 0:
      return "enlist_division_infantry";

    case 1:
      return "enlist_division_airborne";

    case 2:
      return "enlist_division_armored";

    case 3:
      return "enlist_division_mountain";

    case 4:
      return "enlist_division_expeditionary";

    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
    default:
      return undefined;
  }
}

func_449D(param_00) {
  switch (param_00) {
    case 0:
      return "division_infantry";

    case 1:
      return "division_airborne";

    case 2:
      return "division_armored";

    case 3:
      return "division_mountain";

    case 4:
      return "division_expeditionary";

    case 6:
      return "division_resistance";

    case 7:
      return "division_grenadier";

    case 8:
      return "division_commando";

    case 9:
      return "division_scout";

    case 10:
      return "division_artillery";

    case 5:
    default:
      return "none";
  }
}

func_449E(param_00) {
  switch (param_00) {
    case 0:
      return "infantryRankUp";

    case 1:
      return "airborneRankUp";

    case 2:
      return "armoredRankUp";

    case 3:
      return "mountainRankUp";

    case 4:
      return "expeditionaryRankUp";

    case 6:
      return "resistanceRankUp";

    case 7:
      return "grenadierRankUp";

    case 8:
      return "commandoRankUp";

    case 9:
      return "scoutRankUp";

    case 10:
      return "artilleryRankUp";

    case 5:
    default:
      return undefined;
  }
}

func_449B(param_00) {
  switch (param_00) {
    case 0:
      return "ch_division_iconic_weapon_infantry";

    case 1:
      return "ch_division_iconic_weapon_airborne";

    case 2:
      return "ch_division_iconic_weapon_armored";

    case 3:
      return "ch_division_iconic_weapon_mountain";

    case 4:
      return "ch_division_iconic_weapon_expeditionary";

    case 6:
      return "ch_division_iconic_weapon_resistance";

    case 7:
      return "ch_division_iconic_weapon_grenadier";

    case 8:
      return "ch_division_iconic_weapon_commando";

    case 9:
      return "ch_division_iconic_weapon_scout";

    case 10:
      return "ch_division_iconic_weapon_artillery";

    case 5:
    default:
      return "none";
  }
}

getdivisioniconicbasictrainingunlockchallenge(param_00) {
  switch (param_00) {
    case 0:
      return "ch_division_iconic_basic_training_infantry";

    case 1:
      return "ch_division_iconic_basic_training_airborne";

    case 2:
      return "ch_division_iconic_basic_training_armored";

    case 3:
      return "ch_division_iconic_basic_training_mountain";

    case 4:
      return "ch_division_iconic_basic_training_expeditionary";

    case 6:
      return "ch_division_iconic_basic_training_resistance";

    case 7:
      return "ch_division_iconic_basic_training_grenadier";

    case 8:
      return "ch_division_iconic_basic_training_commando";

    case 9:
      return "ch_division_iconic_basic_training_scout";

    case 10:
      return "ch_division_iconic_basic_training_artillery";

    case 5:
    default:
      return "none";
  }
}

getdivisionweaponclass(param_00) {
  switch (param_00) {
    case 0:
      return "weapon_assault";

    case 1:
      return "weapon_smg";

    case 2:
      return "weapon_heavy";

    case 3:
      return "weapon_sniper";

    case 4:
      return "weapon_shotgun";

    case 6:
      return "weapon_pistol";

    case 7:
      return "weapon_assault";

    case 8:
      return "weapon_smg";

    case 9:
      return "weapon_sniper";

    case 10:
      return "weapon_assault";

    case 5:
    default:
      return "none";
  }
}

getdivisionskillunlocklevel(param_00, param_01) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    switch (param_00) {
      case 1:
        return 1;

      case 2:
        return 1;

      case 3:
        if(param_01 == 7) {
          return 2;
        } else {
          return 1;
        }

        break;
    }
  } else {
    switch (param_00) {
      case 1:
        return 1;

      case 2:
        return 1;

      case 3:
        return 1;
    }
  }

  return -1;
}

getdivisiontrainingunlocklevel(param_00) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    switch (param_00) {
      case 1:
        return 1;

      case 2:
        return 2;

      case 3:
        return 3;

      case 4:
        return 4;
    }
  } else {
    switch (param_00) {
      case 1:
        return 2;

      case 2:
        return 3;

      case 3:
        return 4;

      case 4:
        return 999;
    }
  }

  return -1;
}

func_52AC() {
  func_09AB(getdivisionskillunlocklevel(1, 0), "infantry", "bayonet_level1");
  func_09AB(getdivisionskillunlocklevel(2, 0), "infantry", "bayonet_level2");
  func_09AB(getdivisionskillunlocklevel(3, 0), "infantry", "bayonet_level3");
  func_09AB(getdivisionskillunlocklevel(1, 1), "airborne", "suppressor_level1");
  func_09AB(getdivisionskillunlocklevel(2, 1), "airborne", "suppressor_level2");
  func_09AB(getdivisionskillunlocklevel(3, 1), "airborne", "suppressor_level3");
  func_09AB(getdivisionskillunlocklevel(1, 2), "armored", "bipod_level1");
  func_09AB(getdivisionskillunlocklevel(2, 2), "armored", "bipod_level2");
  func_09AB(getdivisionskillunlocklevel(3, 2), "armored", "bipod_level3");
  func_09AB(getdivisionskillunlocklevel(1, 3), "mountain", "sharpshooter_level1");
  func_09AB(getdivisionskillunlocklevel(2, 3), "mountain", "sharpshooter_level2");
  func_09AB(getdivisionskillunlocklevel(3, 3), "mountain", "sharpshooter_level3");
  func_09AB(getdivisionskillunlocklevel(1, 4), "expeditionary", "incendiary_level1");
  func_09AB(getdivisionskillunlocklevel(2, 4), "expeditionary", "incendiary_level2");
  func_09AB(getdivisionskillunlocklevel(3, 4), "expeditionary", "incendiary_level3");
  func_09AB(getdivisionskillunlocklevel(1, 6), "resistance", "tacticalknife_level3");
  func_09AB(getdivisionskillunlocklevel(2, 6), "resistance", "tacticalknife_level3");
  func_09AB(getdivisionskillunlocklevel(3, 6), "resistance", "tacticalknife_level3");
  func_09AB(getdivisionskillunlocklevel(1, 7), "grenadier", "none");
  func_09AB(getdivisionskillunlocklevel(2, 7), "grenadier", "none");
  func_09AB(getdivisionskillunlocklevel(3, 7), "grenadier", "shield_charge");
  func_09AB(getdivisionskillunlocklevel(1, 8), "commando", "adjustablesight_level3");
  func_09AB(getdivisionskillunlocklevel(2, 8), "commando", "adjustablesight_level3");
  func_09AB(getdivisionskillunlocklevel(3, 8), "commando", "adjustablesight_level3");
  func_09AB(getdivisionskillunlocklevel(1, 9), "scout", "ironsight_level3");
  func_09AB(getdivisionskillunlocklevel(2, 9), "scout", "ironsight_level3");
  func_09AB(getdivisionskillunlocklevel(3, 9), "scout", "ironsight_level3");
  func_09AB(getdivisionskillunlocklevel(1, 10), "artillery", "flashhider_level3");
  func_09AB(getdivisionskillunlocklevel(2, 10), "artillery", "flashhider_level3");
  func_09AB(getdivisionskillunlocklevel(3, 10), "artillery", "flashhider_level3");
  func_09AC(getdivisiontrainingunlocklevel(1), "infantry", "specialty_class_infantry_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "infantry", "specialty_class_infantry_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "infantry", "specialty_class_infantry_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "infantry", "specialty_class_infantry_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "airborne", "specialty_class_airborne_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "airborne", "specialty_class_airborne_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "airborne", "specialty_class_airborne_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "airborne", "specialty_class_airborne_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "armored", "specialty_class_armored_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "armored", "specialty_class_armored_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "armored", "specialty_class_armored_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "armored", "specialty_class_armored_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "mountain", "specialty_class_mountain_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "mountain", "specialty_class_mountain_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "mountain", "specialty_class_mountain_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "mountain", "specialty_class_mountain_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "expeditionary", "specialty_class_expeditionary_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "expeditionary", "specialty_class_expeditionary_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "expeditionary", "specialty_class_expeditionary_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "expeditionary", "specialty_class_expeditionary_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "resistance", "specialty_class_resistance_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "resistance", "specialty_class_resistance_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "resistance", "specialty_class_resistance_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "resistance", "specialty_class_resistance_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "grenadier", "specialty_class_grenadier_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "grenadier", "specialty_class_grenadier_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "grenadier", "specialty_class_grenadier_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "grenadier", "specialty_class_grenadier_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "commando", "specialty_class_commando_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "commando", "specialty_class_commando_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "commando", "specialty_class_commando_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "commando", "specialty_class_commando_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "scout", "specialty_class_scout_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "scout", "specialty_class_scout_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "scout", "specialty_class_scout_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "scout", "specialty_class_scout_grandmaster");
  func_09AC(getdivisiontrainingunlocklevel(1), "artillery", "specialty_class_artillery_enlisted");
  func_09AC(getdivisiontrainingunlocklevel(2), "artillery", "specialty_class_artillery_expert");
  func_09AC(getdivisiontrainingunlocklevel(3), "artillery", "specialty_class_artillery_master");
  func_09AC(getdivisiontrainingunlocklevel(4), "artillery", "specialty_class_artillery_grandmaster");
}

func_09AB(param_00, param_01, param_02) {
  level.var_3057[param_00][param_01] = param_02;
}

removedivisionprogressionskillunlock(param_00, param_01) {
  level.var_3057[param_00][param_01] = undefined;
}

func_44A1(param_00, param_01) {
  if(!isDefined(level.var_3057) || !isDefined(level.var_3057[param_00]) || !isDefined(level.var_3057[param_00][param_01])) {
    return "skill_level0";
  }

  return level.var_3057[param_00][param_01];
}

func_461C(param_00) {
  var_01 = func_461A(param_00);
  var_02 = -1;
  if(var_01 >= getdivisionskillunlocklevel(3, param_00)) {
    var_02 = getdivisionskillunlocklevel(3, param_00);
  } else if(var_01 >= getdivisionskillunlocklevel(2, param_00)) {
    var_02 = getdivisionskillunlocklevel(2, param_00);
  } else if(var_01 >= getdivisionskillunlocklevel(1, param_00)) {
    var_02 = getdivisionskillunlocklevel(1, param_00);
  }

  var_03 = func_44A0(param_00);
  return func_44A1(var_02, var_03);
}

func_09AC(param_00, param_01, param_02) {
  level.var_3058[param_00][param_01] = param_02;
}

func_44A2(param_00, param_01) {
  if(!isDefined(level.var_3058[param_00]) || !isDefined(level.var_3058[param_00][param_01])) {
    return "";
  }

  return level.var_3058[param_00][param_01];
}

func_461D(param_00, param_01) {
  var_02 = func_44A0(param_00);
  if((getdvarint("scr_oneShot", 0) == 1 || getdvarint("scr_wanderlustOnly", 0) == 1 || maps\mp\_utility::areexperimentalbasictrainingsenabled()) && maps\mp\_utility::func_0649("specialty_class_" + var_02 + "_grandmaster")) {
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      var_03 = 4;
    } else {
      var_03 = 4;
    }
  } else if((level.var_3FDC == "undead" || level.var_3FDC == "infect") && maps\mp\_utility::func_0649("specialty_class_" + var_03 + "_grandmaster")) {
    var_03 = 4;
  } else if(isDefined(var_02)) {
    var_03 = var_02;
  } else {
    var_03 = func_461A(param_01);
  }

  var_04 = -1;
  if(var_03 >= getdivisiontrainingunlocklevel(4)) {
    var_04 = getdivisiontrainingunlocklevel(4);
  } else if(var_03 >= getdivisiontrainingunlocklevel(3)) {
    var_04 = getdivisiontrainingunlocklevel(3);
  } else if(var_03 >= getdivisiontrainingunlocklevel(2)) {
    var_04 = getdivisiontrainingunlocklevel(2);
  } else if(var_03 >= getdivisiontrainingunlocklevel(1)) {
    var_04 = getdivisiontrainingunlocklevel(1);
  }

  return func_44A2(var_04, var_02);
}

func_461A(param_00) {
  var_01 = func_44A0(param_00);
  if(!isDefined(self.var_3053)) {
    self.var_3053 = [];
  }

  if(!isDefined(self.var_3053[var_01])) {
    self.var_3053[var_01] = func_461B(param_00);
  }

  return self.var_3053[var_01];
}

func_2406() {
  self.var_3053 = undefined;
}

func_461B(param_00) {
  if(!isPlayer(self)) {
    return -1;
  }

  if(isDefined(level.var_585D) && level.var_585D) {
    return -1;
  }

  if(!isDefined(param_00) || !func_56CC(param_00) || param_00 == 5) {
    return -1;
  }

  if(getdvarint("709") || getdvarint("742")) {
    return func_449F(param_00);
  }

  if(function_03AF()) {
    return func_449F(param_00);
  }

  var_01 = func_44A0(param_00);
  if(isDefined(self.var_012C) && isDefined(self.var_012C["divisionLevel"]) && isDefined(self.var_012C["divisionLevel"][var_01])) {
    return self.var_012C["divisionLevel"][var_01];
  }

  if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
    var_02 = func_449F(param_00);
  } else {
    var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_02, "level");
    var_02 = var_02 + 1;
  }

  if(!isDefined(self.var_012C["divisionLevel"])) {
    self.var_012C["divisionLevel"] = [];
  }

  self.var_012C["divisionLevel"][var_01] = var_02;
  return var_02;
}

func_449F(param_00) {
  var_01 = func_44A0(param_00);
  var_02 = tablelookuprownum(getdivisionlevelingtablename(), 0, var_01);
  if(var_02 == -1) {
    return;
  }

  var_03 = int(tablelookupbyrow(getdivisionlevelingtablename(), var_02, 1));
  return var_03;
}

hasaccesstov2rocket() {
  if(!isPlayer(self)) {
    return 0;
  }

  if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
    return 0;
  }

  if(getdvarint("709") || getdvarint("742")) {
    return 1;
  }

  if(isDefined(self.var_012C["hasAccessToV2Rocket"])) {
    return self.var_012C["hasAccessToV2Rocket"];
  }

  var_00 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "infantry", "prestigeLevel");
  var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "airborne", "prestigeLevel");
  var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "armored", "prestigeLevel");
  var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "mountain", "prestigeLevel");
  var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "expeditionary", "prestigeLevel");
  var_05 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "resistance", "prestigeLevel");
  var_06 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "grenadier", "prestigeLevel");
  var_07 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "commando", "prestigeLevel");
  var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "scout", "prestigeLevel");
  var_09 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "artillery", "prestigeLevel");
  var_0A = 0;
  if(var_00 >= 1) {
    var_0A++;
  }

  if(var_01 >= 1) {
    var_0A++;
  }

  if(var_02 >= 1) {
    var_0A++;
  }

  if(var_03 >= 1) {
    var_0A++;
  }

  if(var_04 >= 1) {
    var_0A++;
  }

  if(var_05 >= 1) {
    var_0A++;
  }

  if(var_06 >= 1) {
    var_0A++;
  }

  if(var_07 >= 1) {
    var_0A++;
  }

  if(var_08 >= 1) {
    var_0A++;
  }

  if(var_09 >= 1) {
    var_0A++;
  }

  self.var_012C["hasAccessToV2Rocket"] = var_0A >= 5;
  return self.var_012C["hasAccessToV2Rocket"];
}

updatedivisionusagestats() {
  if(isDefined(self.var_305A) && isDefined(self.divisionusageindex)) {
    var_00 = int(gettime() - self.var_305A / 1000);
    func_50FC(self.divisionusageindex, var_00, "timeInUse");
  }
}

func_4783(param_00, param_01) {
  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  if(function_0367()) {
    return;
  }

  if(!isDefined(param_00) || !func_56CC(param_00) || param_00 == 5) {
    return;
  }

  if(isDefined(level.var_2F7A) && level.var_2F7A) {
    return;
  }

  if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
    return;
  }

  if(function_03AF()) {
    return;
  }

  if(level.var_3FDC == "gun" || level.var_3FDC == "blades" || level.var_3FDC == "infect" || level.var_3FDC == "prop" || level.var_3FDC == "br" || level.var_3FDC == "aon" || level.var_3FDC == "oitc") {
    return;
  }

  if(!isDefined(self.var_2319) || !issubstr(self.var_2319, "custom")) {
    return;
  }

  if(!self method_85FD(func_449D(param_00))) {
    return;
  }

  var_02 = 0;
  switch (param_01) {
    case "win":
    case "loss":
    case "challenge":
    case "divisionLevel":
    case "weaponLevel":
    case "tie":
      break;

    default:
      if(maps\mp\_utility::func_0649("specialty_killstreaks") && param_01 == "airdrop_kill" || param_01 == "fritzx_kill" || param_01 == "mortar_strike_kill" || param_01 == "missile_strike_kill" || param_01 == "airstrike_kill" || param_01 == "firebomb_kill" || param_01 == "fighter_strike_kill" || param_01 == "plane_gunner_kill" || param_01 == "flamethrower_kill" || param_01 == "attack_dogs_kill" || param_01 == "paratroopers_kill" || param_01 == "molotovs_kill" || param_01 == "v2_rocket_kill") {
        var_02 = maps\mp\gametypes\_rank::func_4671("kill");
      } else {
        var_02 = maps\mp\gametypes\_rank::func_4671(param_01);
      }

      if(maps\mp\_utility::func_44FC() > 0) {
        var_03 = max(1, int(5 / maps\mp\_utility::func_44FC()));
        if(level.var_3FDC == "sr") {
          var_03 = max(1, int(2.5 / maps\mp\_utility::func_44FC()));
        }

        var_02 = int(var_02 * var_03);
      }

      if(!isDefined(self.var_012C["summary"]["divisionXpToScaleWithActiveBoosts"][param_00])) {
        self.var_012C["summary"]["divisionXpToScaleWithActiveBoosts"][param_00]["xp"] = 0;
        self.var_012C["summary"]["divisionXpToScaleWithActiveBoosts"][param_00]["divisionIndex"] = param_00;
      }
      self.var_012C["summary"]["divisionXpToScaleWithActiveBoosts"][param_00]["xp"] = self.var_012C["summary"]["divisionXpToScaleWithActiveBoosts"][param_00]["xp"] + var_02;
      break;
  }

  if(var_02 > 0) {
    thread func_4782(param_00, var_02);
  }
}

func_4782(param_00, param_01) {
  var_02 = func_44A0(param_00);
  var_03 = tablelookuprownum(getdivisionlevelingtablename(), 0, var_02);
  var_04 = func_449F(param_00);
  if(getdvarint("1258", 0) == 1 || getdvarint("2803", 0) == 1) {
    var_05 = int(tablelookupbyrow(getdivisionlevelingtablename(), var_03 + var_04 - 1, 1));
  } else {
    var_05 = int(tablelookupbyrow(getdivisionlevelingtablename(), var_04 + var_05, 1));
  }

  var_06 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_02, "level");
  var_06 = var_06 + 1;
  var_07 = var_06;
  var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_02, "experience");
  var_09 = var_08 + param_01;
  var_09 = int(min(var_05, var_09));
  param_01 = var_09 - var_08;
  var_0A = self getrankedplayerdata(common_scripts\utility::func_46A7(), "round", "divisionMatchExperience", var_02);
  var_0B = var_0A + param_01;
  self setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "divisionMatchExperience", var_02, var_0B);
  var_0C = 1;
  while(var_0C) {
    var_0C = 0;
    if(var_06 < var_04) {
      var_0D = var_03 + var_06;
      var_0E = int(tablelookupbyrow(getdivisionlevelingtablename(), var_0D, 1));
      if(var_09 >= var_0E) {
        var_0F = int(tablelookupbyrow(getdivisionlevelingtablename(), var_0D, 3));
        thread maps\mp\gametypes\_rank::func_47B2("divisionLevel", var_0F);
        var_06 = var_06 + 1;
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_02, "level", var_06 - 1);
        lib_0468::func_0A1D(var_02, var_06);
        var_10 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_02, "timeInUse");
        if(!isDefined(var_10)) {
          var_10 = -1;
        }

        function_00F5("script_mp_rankup_division: playerName %s, divisionName %s, oldLevel %d, newLevel %d, xpGain %d, timeInUse %d", self.var_0109, var_02, var_07, var_06, param_01, var_10);
        thread func_3056(var_02, var_06);
        if(!isDefined(self.var_012C["divisionLevel"])) {
          self.var_012C["divisionLevel"] = [];
        }

        self.var_012C["divisionLevel"][var_02] = var_06;
        self.var_5DF2 = undefined;
        self.var_509B = 1;
        var_11 = func_461D(param_00, var_06);
        if(isDefined(var_11) && var_11 != "") {
          var_12 = maps\mp\_utility::func_452A(var_11);
          var_13 = 0;
          while(var_13 < 20) {
            if(maps\mp\gametypes\_class::func_1E02(var_13) == param_00) {
              self setrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_13, "perkSlots", 0, var_12);
              if(!getdvarint("spv_commandoTacInsert_disabled") && issubstr(var_11, "specialty_class_commando_")) {
                self setrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_13, "equipmentSetups", 1, "equipment", 17379328);
                self setrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_13, "equipmentSetups", 1, "numExtra", 0);
              }

              if(var_11 == "specialty_class_commando_grandmaster") {
                var_14 = self getrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_13, "perkSlots", 3);
                if(var_14 == 73400484) {
                  self setrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_13, "perkSlots", 4, 73400433);
                } else {
                  self setrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_13, "perkSlots", 4, 73400484);
                }
              }

              if(!maps\mp\_utility::isdivisionsglobaloverhaulenabled() && param_01 == 4) {
                var_15 = maps\mp\gametypes\_class::func_1E03(var_14, 0);
                var_16 = maps\mp\gametypes\_class::func_1E03(var_14, 1);
                if(var_15 == 0) {
                  self setrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_14, "equipmentSetups", 0, "equipment", 16805888);
                } else if(var_16 == 0) {
                  self setrankedplayerdata(common_scripts\utility::func_46AF(), "customClasses", var_14, "equipmentSetups", 1, "equipment", 16785408);
                }
              }
            }

            var_14++;
          }
        }

        if(var_08 < var_06) {
          var_0E = 1;
        }
      }
    }

    if(getdvarint("1258", 0) == 0 && getdvarint("2803", 0) == 0 && var_0B >= var_09 && var_0E >= var_0A) {
      if(var_07 == "infantry") {
        maps\mp\gametypes\_missions::func_7750("ch_infantry_max");
        continue;
      }

      if(var_07 == "airborne") {
        maps\mp\gametypes\_missions::func_7750("ch_airborne_max");
        continue;
      }

      if(var_07 == "armored") {
        maps\mp\gametypes\_missions::func_7750("ch_armored_max");
        continue;
      }

      if(var_07 == "mountain") {
        maps\mp\gametypes\_missions::func_7750("ch_mountain_max");
        continue;
      }

      if(var_07 == "expeditionary") {
        maps\mp\gametypes\_missions::func_7750("ch_expeditionary_max");
        continue;
      }

      if(var_07 == "resistance") {
        maps\mp\gametypes\_missions::func_7750("ch_resistance_max");
        continue;
      }

      if(var_07 == "grenadier") {
        maps\mp\gametypes\_missions::func_7750("ch_grenadier_max");
        continue;
      }

      if(var_07 == "commando") {
        maps\mp\gametypes\_missions::func_7750("ch_commando_max");
        continue;
      }

      if(var_07 == "scout") {
        maps\mp\gametypes\_missions::func_7750("ch_scout_max");
        continue;
      }

      if(var_07 == "artillery") {
        maps\mp\gametypes\_missions::func_7750("ch_artillery_max");
      }
    }

    if((getdvarint("1258", 0) == 0 && getdvarint("2803", 0) == 0) || var_0B < var_09) {
      self setrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_07, "experience", var_0E);
    }
  }
}

func_3056(param_00, param_01) {
  thread maps\mp\gametypes\_hud_message::func_3055("ranked_up_division_" + param_00, param_01);
}

func_50FC(param_00, param_01, param_02) {
  if(function_0367()) {
    return;
  }

  if(!isDefined(param_01) || param_01 == 0) {
    return;
  }

  if(!isDefined(param_00) || param_00 == 5) {
    return;
  }

  if((isDefined(level.disabledivisionstats) && level.disabledivisionstats) || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(isDefined(level.var_2F7A) && level.var_2F7A) {
    return;
  }

  if(function_03AF()) {
    return;
  }

  var_03 = func_44A0(param_00);
  if(maps\mp\_utility::func_7A69() && !maps\mp\_utility::func_761E()) {
    var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_03, param_02);
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", var_03, param_02, var_04 + param_01);
  }
}

func_52AD() {
  func_52AB(0, 1);
  func_52AB(1, 2);
  func_52AB(2, 3);
  func_52AB(3, 4);
  func_52AB(4, 5);
  func_52AB(5, 6);
}

func_52AB(param_00, param_01) {
  var_02 = "mp/divisionsCACTable.csv";
  var_03 = ["Primary", "Primary_Attachment1", "Primary_Attachment2", "Primary_Attachment3", "Primary_Attachment4", "Secondary", "Secondary_Attachment1", "Secondary_Attachment2", "Lethal1", "Lethal2", "Lethal3", "Tactical1", "Tactical2", "Tactical3", "Perk_Slot1_Loc1", "Perk_Slot1_Loc2", "Perk_Slot1_Loc3", "Perk_Slot2_Loc1", "Perk_Slot2_Loc2", "Perk_Slot2_Loc3", "Perk_Slot3_Loc1", "Perk_Slot3_Loc2", "Perk_Slot3_Loc3"];
  foreach(var_05 in var_03) {
    var_06 = func_4444(var_02, param_01, var_05);
    level.var_3059[var_05][param_00] = var_06;
  }
}

func_4444(param_00, param_01, param_02) {
  var_03 = tablelookup(param_00, 0, param_02, param_01);
  if(!isDefined(var_03) || !isstringinteger(var_03) || !func_57D4(int(var_03))) {
    if(!isDefined(var_03)) {
      var_03 = "NULL";
    }
  }

  return int(var_03);
}

func_4443(param_00, param_01) {
  return level.var_3059[param_00][param_01];
}

func_569B(param_00, param_01) {
  return func_4443(param_00, param_01) != -1;
}

func_57D4(param_00) {
  switch (param_00) {
    case 2:
    case 1:
    case 16777215:
      return 1;

    default:
      return 0;
  }
}

func_9C8A(param_00, param_01) {
  switch (param_00) {
    case "Primary_Attachment":
      switch (param_01) {
        case 3:
          return "Primary_Attachment4";

        case 2:
          return "Primary_Attachment3";

        case 1:
          return "Primary_Attachment2";

        case 0:
        default:
          return "Primary_Attachment1";
      }

      break;

    case "Secondary_Attachment":
      switch (param_01) {
        case 1:
          return "Secondary_Attachment2";

        case 0:
        default:
          return "Secondary_Attachment1";
      }

      break;

    case "Perk":
      switch (param_01) {
        case 8:
          return "Perk_Slot3_Loc3";

        case 7:
          return "Perk_Slot3_Loc2";

        case 6:
          return "Perk_Slot3_Loc1";

        case 5:
          return "Perk_Slot2_Loc3";

        case 4:
          return "Perk_Slot2_Loc2";

        case 3:
          return "Perk_Slot2_Loc1";

        case 2:
          return "Perk_Slot1_Loc3";

        case 1:
          return "Perk_Slot1_Loc2";

        case 0:
        default:
          return "Perk_Slot1_Loc1";
      }

      break;

    case "Lethal":
      switch (param_01) {
        case 2:
          return "Lethal3";

        case 1:
          return "Lethal2";

        case 0:
        default:
          return "Lethal1";
      }

      break;

    case "Tactical":
      switch (param_01) {
        case 2:
          return "Tactical3";

        case 1:
          return "Tactical2";

        case 0:
        default:
          return "Tactical1";
      }

      break;
  }
}