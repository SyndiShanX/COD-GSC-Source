/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_division_specialty.gsc
*****************************************************/

func_8667(param_00) {
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }

  if(!isDefined(param_00) || param_00 == 5) {
    return;
  }

  if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    return;
  }

  var_01 = maps\mp\gametypes\_divisions::func_461D(param_00);
  var_02 = 1;
  switch (var_01) {
    case "specialty_class_infantry_master":
      maps\mp\_utility::giveperk("specialty_stalker_pro");
      break;

    case "specialty_class_infantry_expert":
      maps\mp\_utility::giveperk("specialty_extraammo");
      break;

    case "specialty_class_infantry_enlisted":
      break;

    case "specialty_class_airborne_master":
      maps\mp\_utility::giveperk("specialty_lightweight");
      break;

    case "specialty_class_airborne_expert":
      maps\mp\_utility::giveperk("specialty_fastclimb");
      maps\mp\_utility::giveperk("specialty_fastmantle");
      break;

    case "specialty_class_airborne_enlisted":
      maps\mp\_utility::giveperk("specialty_longersprint");
      break;

    case "specialty_class_armored_master":
      maps\mp\_utility::giveperk("specialty_blastshield2");
      self.var_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 35) / 100;
      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self.var_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 9) / 100;
      }

      break;

    case "specialty_class_armored_expert":
      maps\mp\_utility::giveperk("specialty_fireshield");
      self.var_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale", 35) / 100;
      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self.var_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale_HC", 9) / 100;
      }

      break;

    case "specialty_class_armored_enlisted":
      maps\mp\_utility::giveperk("specialty_stun_resistance");
      maps\mp\_utility::giveperk("specialty_resistshellshock");
      maps\mp\_utility::giveperk("specialty_immunesmoke");
      self.var_94BE = 0.1;
      break;

    case "specialty_class_mountain_master":
      maps\mp\_utility::giveperk("specialty_silentmovement");
      break;

    case "specialty_class_mountain_expert":
      maps\mp\_utility::giveperk("specialty_plainsight");
      break;

    case "specialty_class_mountain_enlisted":
      maps\mp\_utility::giveperk("specialty_uavhidden");
      break;

    case "specialty_class_expeditionary_master":
      maps\mp\_utility::giveperk("specialty_scavenger");
      maps\mp\_utility::giveperk("specialty_lethalresupply");
      maps\mp\_utility::giveperk("specialty_tacticalresupply");
      break;

    case "specialty_class_expeditionary_expert":
      maps\mp\_utility::giveperk("specialty_fastoffhand");
      maps\mp\_utility::giveperk("specialty_sprintequipment");
      maps\mp\_utility::giveperk("specialty_throwequipmentfarther");
      break;

    case "specialty_class_expeditionary_enlisted":
      break;

    case "specialty_class_resistance_master":
    case "specialty_class_resistance_expert":
      maps\mp\_utility::giveperk("specialty_quickswap");
      break;

    case "specialty_class_resistance_enlisted":
      break;

    case "specialty_class_grenadier_master":
    case "specialty_class_grenadier_expert":
    case "specialty_class_grenadier_enlisted":
      break;

    case "specialty_class_commando_master":
      maps\mp\_utility::giveperk("specialty_fastadsaftersprint");
      break;

    case "specialty_class_commando_expert":
    case "specialty_class_commando_enlisted":
      maps\mp\_utility::giveperk("specialty_fastreload");
      break;

    case "specialty_class_scout_master":
    case "specialty_class_scout_expert":
      maps\mp\_utility::giveperk("specialty_minimapwhileads");
      break;

    case "specialty_class_scout_enlisted":
      maps\mp\_utility::giveperk("specialty_twoprimaries");
      maps\mp\_utility::giveperk("specialty_overkill");
      break;

    case "specialty_class_artillery_master":
    case "specialty_class_artillery_expert":
    case "specialty_class_artillery_enlisted":
      break;

    default:
      var_02 = 0;
      break;
  }

  if(var_02) {
    maps\mp\_utility::func_47A3(var_01, 0);
  }
}

setdivisiontrainingbasedonprogressionglobaloverhaulmtx4(param_00) {
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }

  if(!isDefined(param_00) || param_00 == 5) {
    return;
  }

  if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    return;
  }

  var_01 = maps\mp\gametypes\_divisions::func_461D(param_00);
  var_02 = 1;
  switch (var_01) {
    case "specialty_class_infantry_grandmaster":
      maps\mp\_utility::giveperk("specialty_stalker_pro");
      break;

    case "specialty_class_infantry_master":
      maps\mp\_utility::giveperk("specialty_reducedsway");
      break;

    case "specialty_class_infantry_expert":
      maps\mp\_utility::giveperk("specialty_quickswap");
      break;

    case "specialty_class_infantry_enlisted":
      break;

    case "specialty_class_airborne_grandmaster":
      maps\mp\_utility::giveperk("specialty_sprintfasterovertime");
      break;

    case "specialty_class_airborne_master":
      maps\mp\_utility::giveperk("specialty_fastclimb");
      maps\mp\_utility::giveperk("specialty_fastmantle");
      maps\mp\_utility::giveperk("specialty_falldamage");
      break;

    case "specialty_class_airborne_expert":
      maps\mp\_utility::giveperk("specialty_sprintreload");
      break;

    case "specialty_class_airborne_enlisted":
      if(getdvarint("isMLGMatch", 0) == 0 && !function_03AF()) {
        maps\mp\_utility::giveperk("specialty_steadyaimpro");
        maps\mp\_utility::giveperk("specialty_sprintfire");
        maps\mp\_utility::giveperk("specialty_divefire");
      }
      break;

    case "specialty_class_armored_grandmaster":
      if(getdvarint("isMLGMatch", 0) == 0 && !function_03AF()) {
        maps\mp\_utility::giveperk("specialty_sharp_focus");
      }

      break;

    case "specialty_class_armored_master":
      if(getdvarint("isMLGMatch", 0) == 0 && !function_03AF()) {
        maps\mp\_utility::giveperk("specialty_superbulletpenetration");
        maps\mp\_utility::giveperk("specialty_armorpiercing");
      }

      break;

    case "specialty_class_armored_expert":
      maps\mp\_utility::giveperk("specialty_stun_resistance");
      maps\mp\_utility::giveperk("specialty_resistshellshock");
      maps\mp\_utility::giveperk("specialty_immunesmoke");
      self.var_94BE = 0.1;
      break;

    case "specialty_class_armored_enlisted":
      maps\mp\_utility::giveperk("specialty_explosiveearlywarning");
      maps\mp\_utility::giveperk("specialty_throwback");
      maps\mp\_utility::giveperk("specialty_blastshield2");
      self.var_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 20) / 100;
      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self.var_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 5) / 100;
      }

      maps\mp\_utility::giveperk("specialty_fireshield");
      self.var_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale", 20) / 100;
      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self.var_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale_HC", 5) / 100;
      }
      break;

    case "specialty_class_mountain_grandmaster":
      maps\mp\_utility::giveperk("specialty_silentmovement");
      break;

    case "specialty_class_mountain_master":
      maps\mp\_utility::giveperk("specialty_silentkill");
      break;

    case "specialty_class_mountain_expert":
      maps\mp\_utility::giveperk("specialty_coldblooded");
      maps\mp\_utility::giveperk("specialty_spygame");
      maps\mp\_utility::giveperk("specialty_heartbreaker");
      break;

    case "specialty_class_mountain_enlisted":
      maps\mp\_utility::giveperk("specialty_uavhidden");
      maps\mp\_utility::giveperk("specialty_plainsight");
      break;

    case "specialty_class_expeditionary_grandmaster":
      if(getdvarint("isMLGMatch", 0) == 0 && !function_03AF()) {
        self.var_90DA = 6;
        maps\mp\_utility::giveperk("specialty_paint");
      }

      break;

    case "specialty_class_expeditionary_master":
      maps\mp\_utility::giveperk("specialty_improvedtacticals");
      maps\mp\_utility::giveperk("specialty_explosivewareffectiveness");
      break;

    case "specialty_class_expeditionary_expert":
      maps\mp\_utility::giveperk("specialty_scavenger");
      maps\mp\_utility::giveperk("specialty_bulletresupply");
      maps\mp\_utility::giveperk("specialty_regenbullets");
      if(getdvarint("isMLGMatch", 0) == 0 && !function_03AF()) {
        maps\mp\_utility::giveperk("specialty_lethalresupply");
        maps\mp\_utility::giveperk("specialty_tacticalresupply");
        maps\mp\_utility::giveperk("specialty_regenequipment");
      }

      break;

    case "specialty_class_expeditionary_enlisted":
      maps\mp\_utility::giveperk("specialty_fastoffhand");
      maps\mp\_utility::giveperk("specialty_sprintequipment");
      maps\mp\_utility::giveperk("specialty_throwequipmentfarther");
      break;

    case "specialty_class_resistance_grandmaster":
      maps\mp\_utility::giveperk("specialty_moreminimap");
      maps\mp\_utility::giveperk("specialty_eagleeyes");
      break;

    case "specialty_class_resistance_master":
      maps\mp\_utility::giveperk("specialty_intelkillsandassists");
      break;

    case "specialty_class_resistance_expert":
      maps\mp\_utility::giveperk("specialty_selectivehearing");
      break;

    case "specialty_class_resistance_enlisted":
      break;

    case "specialty_class_grenadier_grandmaster":
      maps\mp\_utility::giveperk("specialty_extraobjectivescore");
      break;

    case "specialty_class_grenadier_master":
      maps\mp\_utility::giveperk("specialty_improvedobjectives");
      break;

    case "specialty_class_grenadier_expert":
      maps\mp\_utility::giveperk("specialty_sprintmeleechargelonger");
      break;

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
      break;

    case "specialty_class_commando_expert":
      maps\mp\_utility::giveperk("specialty_fasterhealthregen");
      maps\mp\_utility::giveperk("specialty_extrascorewhilehealing");
      break;

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
      var_02 = 0;
      break;
  }

  if(var_02) {
    maps\mp\_utility::func_47A3(var_01, 0);
  }
}