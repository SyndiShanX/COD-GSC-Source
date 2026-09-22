/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_division_specialty.gsc
*************************************************************/

_id_8667(var_0) {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(!isDefined(var_0) || var_0 == 5) {
    return;
  }
  if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    return;
  }
  var_1 = _id_04CA::_id_461D(var_0);
  var_2 = 1;

  switch (var_1) {
    case "specialty_class_infantry_master":
      maps\mp\_utility::giveperk("specialty_stalker_pro");
    case "specialty_class_infantry_expert":
      maps\mp\_utility::giveperk("specialty_extraammo");
    case "specialty_class_infantry_enlisted":
      break;
    case "specialty_class_airborne_master":
      maps\mp\_utility::giveperk("specialty_lightweight");
    case "specialty_class_airborne_expert":
      maps\mp\_utility::giveperk("specialty_fastclimb");
      maps\mp\_utility::giveperk("specialty_fastmantle");
    case "specialty_class_airborne_enlisted":
      maps\mp\_utility::giveperk("specialty_longersprint");
      break;
    case "specialty_class_armored_master":
      maps\mp\_utility::giveperk("specialty_blastshield2");
      self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 35) / 100;

      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 9) / 100;
      }
    case "specialty_class_armored_expert":
      maps\mp\_utility::giveperk("specialty_fireshield");
      self._id_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale", 35) / 100;

      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self._id_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale_HC", 9) / 100;
      }
    case "specialty_class_armored_enlisted":
      maps\mp\_utility::giveperk("specialty_stun_resistance");
      maps\mp\_utility::giveperk("specialty_resistshellshock");
      maps\mp\_utility::giveperk("specialty_immunesmoke");
      self._id_94BE = 0.1;
      break;
    case "specialty_class_mountain_master":
      maps\mp\_utility::giveperk("specialty_silentmovement");
    case "specialty_class_mountain_expert":
      maps\mp\_utility::giveperk("specialty_plainsight");
    case "specialty_class_mountain_enlisted":
      maps\mp\_utility::giveperk("specialty_uavhidden");
      break;
    case "specialty_class_expeditionary_master":
      maps\mp\_utility::giveperk("specialty_scavenger");
      maps\mp\_utility::giveperk("specialty_lethalresupply");
      maps\mp\_utility::giveperk("specialty_tacticalresupply");
    case "specialty_class_expeditionary_expert":
      maps\mp\_utility::giveperk("specialty_fastoffhand");
      maps\mp\_utility::giveperk("specialty_sprintequipment");
      maps\mp\_utility::giveperk("specialty_throwequipmentfarther");
    case "specialty_class_expeditionary_enlisted":
      break;
    case "specialty_class_resistance_master":
    case "specialty_class_resistance_expert":
      maps\mp\_utility::giveperk("specialty_quickswap");
    case "specialty_class_resistance_enlisted":
      break;
    case "specialty_class_grenadier_master":
    case "specialty_class_grenadier_expert":
    case "specialty_class_grenadier_enlisted":
      break;
    case "specialty_class_commando_master":
      maps\mp\_utility::giveperk("specialty_fastadsaftersprint");
    case "specialty_class_commando_expert":
    case "specialty_class_commando_enlisted":
      maps\mp\_utility::giveperk("specialty_fastreload");
      break;
    case "specialty_class_scout_master":
    case "specialty_class_scout_expert":
      maps\mp\_utility::giveperk("specialty_minimapwhileads");
    case "specialty_class_scout_enlisted":
      maps\mp\_utility::giveperk("specialty_twoprimaries");
      maps\mp\_utility::giveperk("specialty_overkill");
      break;
    case "specialty_class_artillery_master":
    case "specialty_class_artillery_expert":
    case "specialty_class_artillery_enlisted":
      break;
    default:
      var_2 = 0;
      break;
  }

  if(var_2) {
    maps\mp\_utility::_id_47A3(var_1, 0);
  }
}

setdivisiontrainingbasedonprogressionglobaloverhaulmtx4(var_0) {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(!isDefined(var_0) || var_0 == 5) {
    return;
  }
  if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    return;
  }
  var_1 = _id_04CA::_id_461D(var_0);
  var_2 = 1;

  switch (var_1) {
    case "specialty_class_infantry_grandmaster":
      maps\mp\_utility::giveperk("specialty_stalker_pro");
    case "specialty_class_infantry_master":
      maps\mp\_utility::giveperk("specialty_reducedsway");
    case "specialty_class_infantry_expert":
      maps\mp\_utility::giveperk("specialty_quickswap");
    case "specialty_class_infantry_enlisted":
      break;
    case "specialty_class_airborne_grandmaster":
      maps\mp\_utility::giveperk("specialty_sprintfasterovertime");
    case "specialty_class_airborne_master":
      maps\mp\_utility::giveperk("specialty_fastclimb");
      maps\mp\_utility::giveperk("specialty_fastmantle");
      maps\mp\_utility::giveperk("specialty_falldamage");
    case "specialty_class_airborne_expert":
      maps\mp\_utility::giveperk("specialty_sprintreload");
    case "specialty_class_airborne_enlisted":
      if(getdvarint("isMLGMatch", 0) == 0 && !_func_3AF()) {
        maps\mp\_utility::giveperk("specialty_steadyaimpro");
        maps\mp\_utility::giveperk("specialty_sprintfire");
        maps\mp\_utility::giveperk("specialty_divefire");
      }

      break;
    case "specialty_class_armored_grandmaster":
      if(getdvarint("isMLGMatch", 0) == 0 && !_func_3AF()) {
        maps\mp\_utility::giveperk("specialty_sharp_focus");
      }
    case "specialty_class_armored_master":
      if(getdvarint("isMLGMatch", 0) == 0 && !_func_3AF()) {
        maps\mp\_utility::giveperk("specialty_superbulletpenetration");
        maps\mp\_utility::giveperk("specialty_armorpiercing");
      }
    case "specialty_class_armored_expert":
      maps\mp\_utility::giveperk("specialty_stun_resistance");
      maps\mp\_utility::giveperk("specialty_resistshellshock");
      maps\mp\_utility::giveperk("specialty_immunesmoke");
      self._id_94BE = 0.1;
    case "specialty_class_armored_enlisted":
      maps\mp\_utility::giveperk("specialty_explosiveearlywarning");
      maps\mp\_utility::giveperk("specialty_throwback");
      maps\mp\_utility::giveperk("specialty_blastshield2");
      self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 20) / 100;

      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 5) / 100;
      }

      maps\mp\_utility::giveperk("specialty_fireshield");
      self._id_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale", 20) / 100;

      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self._id_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale_HC", 5) / 100;
      }

      break;
    case "specialty_class_mountain_grandmaster":
      maps\mp\_utility::giveperk("specialty_silentmovement");
    case "specialty_class_mountain_master":
      maps\mp\_utility::giveperk("specialty_silentkill");
    case "specialty_class_mountain_expert":
      maps\mp\_utility::giveperk("specialty_coldblooded");
      maps\mp\_utility::giveperk("specialty_spygame");
      maps\mp\_utility::giveperk("specialty_heartbreaker");
    case "specialty_class_mountain_enlisted":
      maps\mp\_utility::giveperk("specialty_uavhidden");
      maps\mp\_utility::giveperk("specialty_plainsight");
      break;
    case "specialty_class_expeditionary_grandmaster":
      if(getdvarint("isMLGMatch", 0) == 0 && !_func_3AF()) {
        self._id_90DA = 6.0;
        maps\mp\_utility::giveperk("specialty_paint");
      }
    case "specialty_class_expeditionary_master":
      maps\mp\_utility::giveperk("specialty_improvedtacticals");
      maps\mp\_utility::giveperk("specialty_explosivewareffectiveness");
    case "specialty_class_expeditionary_expert":
      maps\mp\_utility::giveperk("specialty_scavenger");
      maps\mp\_utility::giveperk("specialty_bulletresupply");
      maps\mp\_utility::giveperk("specialty_regenbullets");

      if(getdvarint("isMLGMatch", 0) == 0 && !_func_3AF()) {
        maps\mp\_utility::giveperk("specialty_lethalresupply");
        maps\mp\_utility::giveperk("specialty_tacticalresupply");
        maps\mp\_utility::giveperk("specialty_regenequipment");
      }
    case "specialty_class_expeditionary_enlisted":
      maps\mp\_utility::giveperk("specialty_fastoffhand");
      maps\mp\_utility::giveperk("specialty_sprintequipment");
      maps\mp\_utility::giveperk("specialty_throwequipmentfarther");
      break;
    case "specialty_class_resistance_grandmaster":
      maps\mp\_utility::giveperk("specialty_moreminimap");
      maps\mp\_utility::giveperk("specialty_eagleeyes");
    case "specialty_class_resistance_master":
      maps\mp\_utility::giveperk("specialty_intelkillsandassists");
    case "specialty_class_resistance_expert":
      maps\mp\_utility::giveperk("specialty_selectivehearing");
    case "specialty_class_resistance_enlisted":
      break;
    case "specialty_class_grenadier_grandmaster":
      maps\mp\_utility::giveperk("specialty_extraobjectivescore");
    case "specialty_class_grenadier_master":
      maps\mp\_utility::giveperk("specialty_improvedobjectives");
    case "specialty_class_grenadier_expert":
      maps\mp\_utility::giveperk("specialty_sprintmeleechargelonger");
    case "specialty_class_grenadier_enlisted":
      maps\mp\_utility::giveperk("specialty_quickswap");

      if(getdvarint("spv_cavalryRiflemanPerk_enabled", 1) == 1) {
        maps\mp\_utility::giveperk("specialty_twoprimaries");
        maps\mp\_utility::giveperk("specialty_overkill");
      }

      break;
    case "specialty_class_commando_grandmaster":
    case "specialty_class_commando_master":
      maps\mp\_utility::giveperk("specialty_multikillboost");
    case "specialty_class_commando_expert":
      maps\mp\_utility::giveperk("specialty_fasterhealthregen");
      maps\mp\_utility::giveperk("specialty_extrascorewhilehealing");
    case "specialty_class_commando_enlisted":
      maps\mp\_utility::giveperk("specialty_tacticalinsertion");
      break;
    case "specialty_class_scout_grandmaster":
    case "specialty_class_scout_master":
    case "specialty_class_scout_expert":
    case "specialty_class_scout_enlisted":
      break;
    case "specialty_class_artillery_grandmaster":
    case "specialty_class_artillery_master":
    case "specialty_class_artillery_expert":
    case "specialty_class_artillery_enlisted":
      break;
    default:
      var_2 = 0;
      break;
  }

  if(var_2) {
    maps\mp\_utility::_id_47A3(var_1, 0);
  }
}