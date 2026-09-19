/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_divisions.gsc
****************************************************/

getdivisionlevelingtablename() {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
    return "mp/divisionLevelingOverhaul.csv";
  else
    return "mp/divisionLeveling.csv";
}

init() {
  _id_52AC();
  _id_52AD();
}

_id_56CC(var_0) {
  switch (var_0) {
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

_id_56CB(var_0) {
  switch (var_0) {
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

_id_44A0(var_0) {
  switch (var_0) {
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

_id_449C(var_0) {
  switch (var_0) {
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

_id_4498(var_0) {
  switch (var_0) {
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

_id_449D(var_0) {
  switch (var_0) {
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

_id_449E(var_0) {
  switch (var_0) {
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

_id_449B(var_0) {
  switch (var_0) {
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

getdivisioniconicbasictrainingunlockchallenge(var_0) {
  switch (var_0) {
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

getdivisionweaponclass(var_0) {
  switch (var_0) {
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

getdivisionskillunlocklevel(var_0, var_1) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    switch (var_0) {
      case 1:
        return 1;
      case 2:
        return 1;
      case 3:
        if(var_1 == 7)
          return 2;
        else
          return 1;
    }
  } else {
    switch (var_0) {
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

getdivisiontrainingunlocklevel(var_0) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    switch (var_0) {
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
    switch (var_0) {
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

_id_52AC() {
  _id_09AB(getdivisionskillunlocklevel(1, 0), "infantry", "bayonet_level1");
  _id_09AB(getdivisionskillunlocklevel(2, 0), "infantry", "bayonet_level2");
  _id_09AB(getdivisionskillunlocklevel(3, 0), "infantry", "bayonet_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 1), "airborne", "suppressor_level1");
  _id_09AB(getdivisionskillunlocklevel(2, 1), "airborne", "suppressor_level2");
  _id_09AB(getdivisionskillunlocklevel(3, 1), "airborne", "suppressor_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 2), "armored", "bipod_level1");
  _id_09AB(getdivisionskillunlocklevel(2, 2), "armored", "bipod_level2");
  _id_09AB(getdivisionskillunlocklevel(3, 2), "armored", "bipod_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 3), "mountain", "sharpshooter_level1");
  _id_09AB(getdivisionskillunlocklevel(2, 3), "mountain", "sharpshooter_level2");
  _id_09AB(getdivisionskillunlocklevel(3, 3), "mountain", "sharpshooter_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 4), "expeditionary", "incendiary_level1");
  _id_09AB(getdivisionskillunlocklevel(2, 4), "expeditionary", "incendiary_level2");
  _id_09AB(getdivisionskillunlocklevel(3, 4), "expeditionary", "incendiary_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 6), "resistance", "tacticalknife_level3");
  _id_09AB(getdivisionskillunlocklevel(2, 6), "resistance", "tacticalknife_level3");
  _id_09AB(getdivisionskillunlocklevel(3, 6), "resistance", "tacticalknife_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 7), "grenadier", "none");
  _id_09AB(getdivisionskillunlocklevel(2, 7), "grenadier", "none");
  _id_09AB(getdivisionskillunlocklevel(3, 7), "grenadier", "shield_charge");
  _id_09AB(getdivisionskillunlocklevel(1, 8), "commando", "adjustablesight_level3");
  _id_09AB(getdivisionskillunlocklevel(2, 8), "commando", "adjustablesight_level3");
  _id_09AB(getdivisionskillunlocklevel(3, 8), "commando", "adjustablesight_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 9), "scout", "ironsight_level3");
  _id_09AB(getdivisionskillunlocklevel(2, 9), "scout", "ironsight_level3");
  _id_09AB(getdivisionskillunlocklevel(3, 9), "scout", "ironsight_level3");
  _id_09AB(getdivisionskillunlocklevel(1, 10), "artillery", "flashhider_level3");
  _id_09AB(getdivisionskillunlocklevel(2, 10), "artillery", "flashhider_level3");
  _id_09AB(getdivisionskillunlocklevel(3, 10), "artillery", "flashhider_level3");
  _id_09AC(getdivisiontrainingunlocklevel(1), "infantry", "specialty_class_infantry_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "infantry", "specialty_class_infantry_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "infantry", "specialty_class_infantry_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "infantry", "specialty_class_infantry_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "airborne", "specialty_class_airborne_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "airborne", "specialty_class_airborne_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "airborne", "specialty_class_airborne_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "airborne", "specialty_class_airborne_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "armored", "specialty_class_armored_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "armored", "specialty_class_armored_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "armored", "specialty_class_armored_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "armored", "specialty_class_armored_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "mountain", "specialty_class_mountain_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "mountain", "specialty_class_mountain_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "mountain", "specialty_class_mountain_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "mountain", "specialty_class_mountain_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "expeditionary", "specialty_class_expeditionary_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "expeditionary", "specialty_class_expeditionary_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "expeditionary", "specialty_class_expeditionary_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "expeditionary", "specialty_class_expeditionary_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "resistance", "specialty_class_resistance_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "resistance", "specialty_class_resistance_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "resistance", "specialty_class_resistance_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "resistance", "specialty_class_resistance_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "grenadier", "specialty_class_grenadier_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "grenadier", "specialty_class_grenadier_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "grenadier", "specialty_class_grenadier_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "grenadier", "specialty_class_grenadier_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "commando", "specialty_class_commando_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "commando", "specialty_class_commando_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "commando", "specialty_class_commando_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "commando", "specialty_class_commando_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "scout", "specialty_class_scout_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "scout", "specialty_class_scout_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "scout", "specialty_class_scout_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "scout", "specialty_class_scout_grandmaster");
  _id_09AC(getdivisiontrainingunlocklevel(1), "artillery", "specialty_class_artillery_enlisted");
  _id_09AC(getdivisiontrainingunlocklevel(2), "artillery", "specialty_class_artillery_expert");
  _id_09AC(getdivisiontrainingunlocklevel(3), "artillery", "specialty_class_artillery_master");
  _id_09AC(getdivisiontrainingunlocklevel(4), "artillery", "specialty_class_artillery_grandmaster");
}

_id_09AB(var_0, var_1, var_2) {
  level._id_3057[var_0][var_1] = var_2;
}

removedivisionprogressionskillunlock(var_0, var_1) {
  level._id_3057[var_0][var_1] = undefined;
}

_id_44A1(var_0, var_1) {
  if(!isDefined(level._id_3057) || !isDefined(level._id_3057[var_0]) || !isDefined(level._id_3057[var_0][var_1]))
    return "skill_level0";

  return level._id_3057[var_0][var_1];
}

_id_461C(var_0) {
  var_1 = _id_461A(var_0);
  var_2 = -1;

  if(var_1 >= getdivisionskillunlocklevel(3, var_0))
    var_2 = getdivisionskillunlocklevel(3, var_0);
  else if(var_1 >= getdivisionskillunlocklevel(2, var_0))
    var_2 = getdivisionskillunlocklevel(2, var_0);
  else if(var_1 >= getdivisionskillunlocklevel(1, var_0))
    var_2 = getdivisionskillunlocklevel(1, var_0);

  var_3 = _id_44A0(var_0);
  return _id_44A1(var_2, var_3);
}

_id_09AC(var_0, var_1, var_2) {
  level._id_3058[var_0][var_1] = var_2;
}

_id_44A2(var_0, var_1) {
  if(!isDefined(level._id_3058[var_0]) || !isDefined(level._id_3058[var_0][var_1]))
    return "";

  return level._id_3058[var_0][var_1];
}

_id_461D(var_0, var_1) {
  var_2 = _id_44A0(var_0);

  if((getdvarint("scr_oneShot", 0) == 1 || getdvarint("scr_wanderlustOnly", 0) == 1 || maps\mp\_utility::areexperimentalbasictrainingsenabled()) && maps\mp\_utility::_hasperk("specialty_class_" + var_2 + "_grandmaster")) {
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
      var_3 = 4;
    else
      var_3 = 4;
  } else if((level.gametype == "undead" || level.gametype == "infect") && maps\mp\_utility::_hasperk("specialty_class_" + var_2 + "_grandmaster"))
    var_3 = 4;
  else if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = _id_461A(var_0);

  var_4 = -1;

  if(var_3 >= getdivisiontrainingunlocklevel(4))
    var_4 = getdivisiontrainingunlocklevel(4);
  else if(var_3 >= getdivisiontrainingunlocklevel(3))
    var_4 = getdivisiontrainingunlocklevel(3);
  else if(var_3 >= getdivisiontrainingunlocklevel(2))
    var_4 = getdivisiontrainingunlocklevel(2);
  else if(var_3 >= getdivisiontrainingunlocklevel(1))
    var_4 = getdivisiontrainingunlocklevel(1);

  return _id_44A2(var_4, var_2);
}

_id_461A(var_0) {
  var_1 = _id_44A0(var_0);

  if(!isDefined(self._id_3053))
    self._id_3053 = [];

  if(!isDefined(self._id_3053[var_1]))
    self._id_3053[var_1] = _id_461B(var_0);

  return self._id_3053[var_1];
}

_id_2406() {
  self._id_3053 = undefined;
}

_id_461B(var_0) {
  if(!isPlayer(self))
    return -1;

  if(isDefined(level._id_585D) && level._id_585D)
    return -1;

  if(!isDefined(var_0) || !_id_56CC(var_0) || var_0 == 5)
    return -1;

  if(getdvarint("709") || getdvarint("742"))
    return _id_449F(var_0);

  if(_func_3AF())
    return _id_449F(var_0);

  var_1 = _id_44A0(var_0);

  if(isDefined(self.pers) && isDefined(self.pers["divisionLevel"]) && isDefined(self.pers["divisionLevel"][var_1]))
    return self.pers["divisionLevel"][var_1];

  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_761E())
    var_2 = _id_449F(var_0);
  else {
    var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_1, "level");
    var_2 = var_2 + 1;
  }

  if(!isDefined(self.pers["divisionLevel"]))
    self.pers["divisionLevel"] = [];

  self.pers["divisionLevel"][var_1] = var_2;
  return var_2;
}

_id_449F(var_0) {
  var_1 = _id_44A0(var_0);
  var_2 = _tablelookuprownum(getdivisionlevelingtablename(), 0, var_1);

  if(var_2 == -1) {
    return;
  }
  var_3 = int(_tablelookupbyrow(getdivisionlevelingtablename(), var_2, 1));
  return var_3;
}

hasaccesstov2rocket() {
  if(!isPlayer(self))
    return 0;

  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_761E())
    return 0;

  if(getdvarint("709") || getdvarint("742"))
    return 1;

  if(isDefined(self.pers["hasAccessToV2Rocket"]))
    return self.pers["hasAccessToV2Rocket"];

  var_0 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "infantry", "prestigeLevel");
  var_1 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "airborne", "prestigeLevel");
  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "armored", "prestigeLevel");
  var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "mountain", "prestigeLevel");
  var_4 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "expeditionary", "prestigeLevel");
  var_5 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "resistance", "prestigeLevel");
  var_6 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "grenadier", "prestigeLevel");
  var_7 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "commando", "prestigeLevel");
  var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "scout", "prestigeLevel");
  var_9 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "artillery", "prestigeLevel");
  var_10 = 0;

  if(var_0 >= 1)
    var_10++;

  if(var_1 >= 1)
    var_10++;

  if(var_2 >= 1)
    var_10++;

  if(var_3 >= 1)
    var_10++;

  if(var_4 >= 1)
    var_10++;

  if(var_5 >= 1)
    var_10++;

  if(var_6 >= 1)
    var_10++;

  if(var_7 >= 1)
    var_10++;

  if(var_8 >= 1)
    var_10++;

  if(var_9 >= 1)
    var_10++;

  self.pers["hasAccessToV2Rocket"] = var_10 >= 5;
  return self.pers["hasAccessToV2Rocket"];
}

updatedivisionusagestats() {
  if(isDefined(self._id_305A) && isDefined(self.divisionusageindex)) {
    var_0 = int((gettime() - self._id_305A) / 1000);
    _id_50FC(self.divisionusageindex, var_0, "timeInUse");
  }
}

_id_4783(var_0, var_1) {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(_func_367()) {
    return;
  }
  if(!isDefined(var_0) || !_id_56CC(var_0) || var_0 == 5) {
    return;
  }
  if(isDefined(level._id_2F7A) && level._id_2F7A) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_761E()) {
    return;
  }
  if(_func_3AF()) {
    return;
  }
  if(level.gametype == "gun" || level.gametype == "blades" || level.gametype == "infect" || level.gametype == "prop" || level.gametype == "br" || level.gametype == "aon" || level.gametype == "oitc") {
    return;
  }
  if(!isDefined(self.class) || !issubstr(self.class, "custom")) {
    return;
  }
  if(!self isitemunlocked2(_id_449D(var_0))) {
    return;
  }
  var_2 = 0;

  switch (var_1) {
    case "win":
    case "loss":
    case "challenge":
    case "divisionLevel":
    case "weaponLevel":
    case "tie":
      break;
    default:
      if(maps\mp\_utility::_hasperk("specialty_killstreaks") && (var_1 == "airdrop_kill" || var_1 == "fritzx_kill" || var_1 == "mortar_strike_kill" || var_1 == "missile_strike_kill" || var_1 == "airstrike_kill" || var_1 == "firebomb_kill" || var_1 == "fighter_strike_kill" || var_1 == "plane_gunner_kill" || var_1 == "flamethrower_kill" || var_1 == "attack_dogs_kill" || var_1 == "paratroopers_kill" || var_1 == "molotovs_kill" || var_1 == "v2_rocket_kill"))
        var_2 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
      else
        var_2 = maps\mp\gametypes\_rank::getscoreinfovalue(var_1);

      if(maps\mp\_utility::getgametypenumlives() > 0) {
        var_3 = max(1, int(5 / maps\mp\_utility::getgametypenumlives()));

        if(level.gametype == "sr")
          var_3 = max(1, int(2.5 / maps\mp\_utility::getgametypenumlives()));

        var_2 = int(var_2 * var_3);
      }

      if(!isDefined(self.pers["summary"]["divisionXpToScaleWithActiveBoosts"][var_0])) {
        self.pers["summary"]["divisionXpToScaleWithActiveBoosts"][var_0]["xp"] = 0;
        self.pers["summary"]["divisionXpToScaleWithActiveBoosts"][var_0]["divisionIndex"] = var_0;
      }

      self.pers["summary"]["divisionXpToScaleWithActiveBoosts"][var_0]["xp"] = self.pers["summary"]["divisionXpToScaleWithActiveBoosts"][var_0]["xp"] + var_2;
  }

  if(var_2 > 0)
    thread _id_4782(var_0, var_2);
}

_id_4782(var_0, var_1) {
  var_2 = _id_44A0(var_0);
  var_3 = _tablelookuprownum(getdivisionlevelingtablename(), 0, var_2);
  var_4 = _id_449F(var_0);

  if(getdvarint("1258", 0) == 1 || getdvarint("2803", 0) == 1)
    var_5 = int(_tablelookupbyrow(getdivisionlevelingtablename(), var_3 + (var_4 - 1), 1));
  else
    var_5 = int(_tablelookupbyrow(getdivisionlevelingtablename(), var_3 + var_4, 1));

  var_6 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_2, "level");
  var_6 = var_6 + 1;
  var_7 = var_6;
  var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_2, "experience");
  var_9 = var_8 + var_1;
  var_9 = int(_min(var_5, var_9));
  var_1 = var_9 - var_8;
  var_10 = self getplayerdata(common_scripts\utility::_id_46A7(), "round", "divisionMatchExperience", var_2);
  var_11 = var_10 + var_1;
  self setplayerdata(common_scripts\utility::_id_46A7(), "round", "divisionMatchExperience", var_2, var_11);
  var_12 = 1;

  while(var_12) {
    var_12 = 0;

    if(var_6 < var_4) {
      var_13 = var_3 + var_6;
      var_14 = int(_tablelookupbyrow(getdivisionlevelingtablename(), var_13, 1));

      if(var_9 >= var_14) {
        var_15 = int(_tablelookupbyrow(getdivisionlevelingtablename(), var_13, 3));
        thread maps\mp\gametypes\_rank::giverankxp("divisionLevel", var_15);
        var_6 = var_6 + 1;
        self setplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_2, "level", var_6 - 1);
        _id_0468::_id_0A1D(var_2, var_6);
        var_16 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_2, "timeInUse");

        if(!isDefined(var_16))
          var_16 = -1;

        _reconevent("script_mp_rankup_division: playerName %s, divisionName %s, oldLevel %d, newLevel %d, xpGain %d, timeInUse %d", self.name, var_2, var_7, var_6, var_1, var_16);
        thread _id_3056(var_2, var_6);

        if(!isDefined(self.pers["divisionLevel"]))
          self.pers["divisionLevel"] = [];

        self.pers["divisionLevel"][var_2] = var_6;
        self._id_5DF2 = undefined;
        self._id_509B = 1;
        var_17 = _id_461D(var_0, var_6);

        if(isDefined(var_17) && var_17 != "") {
          var_18 = maps\mp\_utility::_id_452A(var_17);

          for(var_19 = 0; var_19 < 20; var_19++) {
            if(maps\mp\gametypes\_class::cac_getdivision(var_19) == var_0) {
              self setplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "perkSlots", 0, var_18);

              if(!getdvarint("spv_commandoTacInsert_disabled") && issubstr(var_17, "specialty_class_commando_")) {
                self setplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "equipmentSetups", 1, "equipment", 17379328);
                self setplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "equipmentSetups", 1, "numExtra", 0);
              }

              if(var_17 == "specialty_class_commando_grandmaster") {
                var_20 = self getplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "perkSlots", 3);

                if(var_20 == 73400484)
                  self setplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "perkSlots", 4, 73400433);
                else
                  self setplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "perkSlots", 4, 73400484);
              }

              if(!maps\mp\_utility::isdivisionsglobaloverhaulenabled() && var_0 == 4) {
                var_21 = maps\mp\gametypes\_class::cac_getequipment(var_19, 0);
                var_22 = maps\mp\gametypes\_class::cac_getequipment(var_19, 1);

                if(var_21 == 0)
                  self setplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "equipmentSetups", 0, "equipment", 16805888);
                else if(var_22 == 0)
                  self setplayerdata(common_scripts\utility::_id_46AF(), "customClasses", var_19, "equipmentSetups", 1, "equipment", 16785408);
              }
            }
          }
        }

        if(var_6 < var_4)
          var_12 = 1;
      }
    }

    if(getdvarint("1258", 0) == 0 && getdvarint("2803", 0) == 0 && var_6 >= var_4 && var_9 >= var_5) {
      if(var_2 == "infantry")
        maps\mp\gametypes\_missions::processchallenge("ch_infantry_max");
      else if(var_2 == "airborne")
        maps\mp\gametypes\_missions::processchallenge("ch_airborne_max");
      else if(var_2 == "armored")
        maps\mp\gametypes\_missions::processchallenge("ch_armored_max");
      else if(var_2 == "mountain")
        maps\mp\gametypes\_missions::processchallenge("ch_mountain_max");
      else if(var_2 == "expeditionary")
        maps\mp\gametypes\_missions::processchallenge("ch_expeditionary_max");
      else if(var_2 == "resistance")
        maps\mp\gametypes\_missions::processchallenge("ch_resistance_max");
      else if(var_2 == "grenadier")
        maps\mp\gametypes\_missions::processchallenge("ch_grenadier_max");
      else if(var_2 == "commando")
        maps\mp\gametypes\_missions::processchallenge("ch_commando_max");
      else if(var_2 == "scout")
        maps\mp\gametypes\_missions::processchallenge("ch_scout_max");
      else if(var_2 == "artillery")
        maps\mp\gametypes\_missions::processchallenge("ch_artillery_max");
    }

    if(getdvarint("1258", 0) == 0 && getdvarint("2803", 0) == 0 || var_6 < var_4)
      self setplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_2, "experience", var_9);
  }
}

_id_3056(var_0, var_1) {
  thread maps\mp\gametypes\_hud_message::_id_3055("ranked_up_division_" + var_0, var_1);
}

_id_50FC(var_0, var_1, var_2) {
  if(_func_367()) {
    return;
  }
  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }
  if(!isDefined(var_0) || var_0 == 5) {
    return;
  }
  if(isDefined(level.disabledivisionstats) && level.disabledivisionstats || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(isDefined(level._id_2F7A) && level._id_2F7A) {
    return;
  }
  if(_func_3AF()) {
    return;
  }
  var_3 = _id_44A0(var_0);

  if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::_id_761E()) {
    var_4 = self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_3, var_2);
    self setplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", var_3, var_2, var_4 + var_1);
  }
}

_id_52AD() {
  _id_52AB(0, 1);
  _id_52AB(1, 2);
  _id_52AB(2, 3);
  _id_52AB(3, 4);
  _id_52AB(4, 5);
  _id_52AB(5, 6);
}

_id_52AB(var_0, var_1) {
  var_2 = "mp/divisionsCACTable.csv";
  var_3 = ["Primary", "Primary_Attachment1", "Primary_Attachment2", "Primary_Attachment3", "Primary_Attachment4", "Secondary", "Secondary_Attachment1", "Secondary_Attachment2", "Lethal1", "Lethal2", "Lethal3", "Tactical1", "Tactical2", "Tactical3", "Perk_Slot1_Loc1", "Perk_Slot1_Loc2", "Perk_Slot1_Loc3", "Perk_Slot2_Loc1", "Perk_Slot2_Loc2", "Perk_Slot2_Loc3", "Perk_Slot3_Loc1", "Perk_Slot3_Loc2", "Perk_Slot3_Loc3"];

  foreach(var_5 in var_3) {
    var_6 = _id_4444(var_2, var_1, var_5);
    level._id_3059[var_5][var_0] = var_6;
  }
}

_id_4444(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_2, var_1);

  if(!isDefined(var_3) || !_func_30E(var_3) || !_id_57D4(int(var_3))) {
    if(!isDefined(var_3))
      var_3 = "NULL";
  }

  return int(var_3);
}

_id_4443(var_0, var_1) {
  return level._id_3059[var_0][var_1];
}

_id_569B(var_0, var_1) {
  return _id_4443(var_0, var_1) != -1;
}

_id_57D4(var_0) {
  switch (var_0) {
    case 2:
    case 1:
    case 16777215:
      return 1;
    default:
      return 0;
  }
}

_id_9C8A(var_0, var_1) {
  switch (var_0) {
    case "Primary_Attachment":
      switch (var_1) {
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
    case "Secondary_Attachment":
      switch (var_1) {
        case 1:
          return "Secondary_Attachment2";
        case 0:
        default:
          return "Secondary_Attachment1";
      }
    case "Perk":
      switch (var_1) {
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
    case "Lethal":
      switch (var_1) {
        case 2:
          return "Lethal3";
        case 1:
          return "Lethal2";
        case 0:
        default:
          return "Lethal1";
      }
    case "Tactical":
      switch (var_1) {
        case 2:
          return "Tactical3";
        case 1:
          return "Tactical2";
        case 0:
        default:
          return "Tactical1";
      }
  }
}