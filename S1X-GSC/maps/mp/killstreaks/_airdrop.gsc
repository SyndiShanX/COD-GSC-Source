/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_airdrop.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

CRATE_KILLCAM_OFFSET = (0, 0, -200);
GRAVITY_UNITS_PER_SECOND = 800;
CRATE_ICON_Z_OFFSET = 60;

init() {
  if(GetDvarInt("virtuallobbyactive", 0)) {
    return;
  }

  level._effect["airdrop_crate_destroy"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
  level._effect["airdrop_crate_trap_explode"] = LoadFX("vfx/explosion/frag_grenade_default");

  setAirDropCrateCollision("airdrop_crate");
  setAirDropCrateCollision("care_package");
  assert(isDefined(level.airDropCrateCollision));

  level.numDropCrates = 0;
  level.crateTypes = [];

  level.killstreakWieldWeapons["airdrop_trap_explosive_mp"] = "airdrop_assault";

  level.killStreakFuncs["airdrop_reinforcement_common"] = ::tryUseReinforcementCommon;
  level.killStreakFuncs["airdrop_reinforcement_uncommon"] = ::tryUseReinforcementUncommon;
  level.killStreakFuncs["airdrop_reinforcement_rare"] = ::tryUseReinforcementRare;
  level.killStreakFuncs["airdrop_reinforcement_practice"] = ::tryUseReinforcementPractice;

  addCrateTypes_standard();

  level.secondaryReinforcementHintText = [];
  level.secondaryReinforcementHintText["specialty_extended_battery"] = &"PERKS_EXO_BATTERY";
  level.secondaryReinforcementHintText["specialty_class_lowprofile"] = &"PERKS_LOWPROFILE";
  level.secondaryReinforcementHintText["specialty_class_flakjacket"] = &"PERKS_FLAKJACKET";
  level.secondaryReinforcementHintText["specialty_class_lightweight"] = &"PERKS_LIGHTWEIGHT";
  level.secondaryReinforcementHintText["specialty_class_blindeye"] = &"PERKS_BLINDEYE";
  level.secondaryReinforcementHintText["specialty_class_coldblooded"] = &"PERKS_COLDBLOODED";
  level.secondaryReinforcementHintText["specialty_class_peripherals"] = &"PERKS_PERIPHERALS";
  level.secondaryReinforcementHintText["specialty_class_fasthands"] = &"PERKS_FASTHANDS";
  level.secondaryReinforcementHintText["specialty_class_dexterity"] = &"PERKS_DEXTERITY";
  level.secondaryReinforcementHintText["specialty_exo_blastsuppressor"] = &"PERKS_EXO_BLASTSUPPRESSOR";
  level.secondaryReinforcementHintText["specialty_class_hardwired"] = &"PERKS_HARDWIRED";
  level.secondaryReinforcementHintText["specialty_class_toughness"] = &"PERKS_TOUGHNESS";
  level.secondaryReinforcementHintText["specialty_class_scavenger"] = &"PERKS_SCAVENGER";
  level.secondaryReinforcementHintText["specialty_class_hardline"] = &"PERKS_HARDLINE";

  if(isDefined(level.customCrateFunc)) {
    [[level.customCrateFunc]]();
  }

  generateMaxWeightedCrateValue();

  SetDevDvarIfUninitialized("scr_crateOverride", "");
  SetDevDvarIfUninitialized("scr_crateTypeOverride", "");

  level.mapKillstreakAutoDropIndex = RandomInt(4);
}

addCrateTypes_standard() {
  mapStreak = level.mapKillStreak;
  if(isDefined(level.mapStreaksDisabled) && level.mapStreaksDisabled) {
    mapStreak = undefined;
  }

  addCrateType("airdrop_assault", mapStreak, 168, ::killstreakCrateThink, level.mapKillstreakPickupString, mapStreak);
  addCrateType("airdrop_assault", "b", 168, ::killstreakCrateThink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_heavy_resistance");
  addCrateType("airdrop_assault", "c", 168, ::killstreakCrateThink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addCrateType("airdrop_assault", "d", 168, ::killstreakCrateThink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1");
  addCrateType("airdrop_assault", "e", 168, ::killstreakCrateThink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1");
  addCrateType("airdrop_assault", "f", 168, ::killstreakCrateThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_cloak", "recon_ugv_assist_points");
  addCrateType("airdrop_assault", "g", 168, ::killstreakCrateThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");
  addCrateType("airdrop_assault", "h", 98, ::killstreakCrateThink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam");
  addCrateType("airdrop_assault", "i", 98, ::killstreakCrateThink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addCrateType("airdrop_assault", "j", 100, ::killstreakCrateThink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit");
  addCrateType("airdrop_assault", "k", 100, ::killstreakCrateThink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addCrateType("airdrop_assault", "l", 40, ::killstreakCrateThink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive");
  addCrateType("airdrop_assault", "m", 40, ::killstreakCrateThink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time");
  addCrateType("airdrop_assault", "n", 30, ::killstreakCrateThink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets");
  addCrateType("airdrop_assault", "o", 30, ::killstreakCrateThink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets");
  addCrateType("airdrop_assault", "p", 20, ::killstreakCrateThink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo");
  addCrateType("airdrop_assault", "q", 20, ::killstreakCrateThink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time");
  addCrateType("airdrop_assault", "r", 20, ::killstreakCrateThink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_two", "strafing_run_airstrike_flares");
  addCrateType("airdrop_assault", "s", 20, ::killstreakCrateThink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth");
  addCrateType("airdrop_assault", "t", 10, ::killstreakCrateThink, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash");
  addCrateType("airdrop_assault", "u", 10, ::killstreakCrateThink, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1");
  addCrateType("airdrop_assault", "v", 10, ::killstreakCrateThink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch");
  addCrateType("airdrop_assault", "w", 10, ::killstreakCrateThink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject");

  addCrateType("airdrop_assault_odds", mapStreak, 136, ::killstreakCrateThink, level.mapKillstreakPickupString, mapStreak);
  addCrateType("airdrop_assault_odds", "b", 136, ::killstreakCrateThink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_heavy_resistance");
  addCrateType("airdrop_assault_odds", "c", 136, ::killstreakCrateThink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addCrateType("airdrop_assault_odds", "d", 136, ::killstreakCrateThink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1");
  addCrateType("airdrop_assault_odds", "e", 136, ::killstreakCrateThink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1");
  addCrateType("airdrop_assault_odds", "f", 136, ::killstreakCrateThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_cloak", "recon_ugv_assist_points");
  addCrateType("airdrop_assault_odds", "g", 136, ::killstreakCrateThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");
  addCrateType("airdrop_assault_odds", "h", 116, ::killstreakCrateThink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam");
  addCrateType("airdrop_assault_odds", "i", 116, ::killstreakCrateThink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addCrateType("airdrop_assault_odds", "j", 100, ::killstreakCrateThink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit");
  addCrateType("airdrop_assault_odds", "k", 100, ::killstreakCrateThink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addCrateType("airdrop_assault_odds", "l", 60, ::killstreakCrateThink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive");
  addCrateType("airdrop_assault_odds", "m", 60, ::killstreakCrateThink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time");
  addCrateType("airdrop_assault_odds", "n", 50, ::killstreakCrateThink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets");
  addCrateType("airdrop_assault_odds", "o", 50, ::killstreakCrateThink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets");
  addCrateType("airdrop_assault_odds", "p", 40, ::killstreakCrateThink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo");
  addCrateType("airdrop_assault_odds", "q", 40, ::killstreakCrateThink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time");
  addCrateType("airdrop_assault_odds", "r", 40, ::killstreakCrateThink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_two", "strafing_run_airstrike_flares");
  addCrateType("airdrop_assault_odds", "s", 40, ::killstreakCrateThink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth");
  addCrateType("airdrop_assault_odds", "t", 30, ::killstreakCrateThink, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash");
  addCrateType("airdrop_assault_odds", "u", 30, ::killstreakCrateThink, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1");
  addCrateType("airdrop_assault_odds", "v", 30, ::killstreakCrateThink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch");
  addCrateType("airdrop_assault_odds", "w", 30, ::killstreakCrateThink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject");

  addCrateType("airdrop_reinforcement_common", "a", 100, ::reinforcementCrateKillstreakThink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian");
  addCrateType("airdrop_reinforcement_common", "b", 100, ::reinforcementCrateKillstreakThink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction");
  addCrateType("airdrop_reinforcement_common", "c", 100, ::reinforcementCrateKillstreakThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_assist_points");

  addCrateType("airdrop_reinforcement_uncommon", "a", 100, ::reinforcementCrateKillstreakThink, &"MP_EMP_PICKUP", "emp");
  addCrateType("airdrop_reinforcement_uncommon", "b", 100, ::reinforcementCrateKillstreakThink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_rockets");
  addCrateType("airdrop_reinforcement_uncommon", "c", 100, ::reinforcementCrateKillstreakThink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addCrateType("airdrop_reinforcement_uncommon", "d", 100, ::reinforcementCrateKillstreakThink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1");
  addCrateType("airdrop_reinforcement_uncommon", "e", 100, ::reinforcementCrateKillstreakThink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time");
  addCrateType("airdrop_reinforcement_uncommon", "f", 100, ::reinforcementCrateKillstreakThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");

  addCrateType("airdrop_reinforcement_uncommon", "g", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_EXO_BATTERY", "specialty_extended_battery");
  addCrateType("airdrop_reinforcement_uncommon", "h", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_LOWPROFILE", "specialty_class_lowprofile");
  addCrateType("airdrop_reinforcement_uncommon", "j", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_FLAKJACKET", "specialty_class_flakjacket");
  addCrateType("airdrop_reinforcement_uncommon", "k", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_LIGHTWEIGHT", "specialty_class_lightweight");
  addCrateType("airdrop_reinforcement_uncommon", "l", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_BLINDEYE", "specialty_class_blindeye");
  addCrateType("airdrop_reinforcement_uncommon", "m", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_COLDBLOODED", "specialty_class_coldblooded");
  addCrateType("airdrop_reinforcement_uncommon", "n", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_PERIPHERALS", "specialty_class_peripherals");
  addCrateType("airdrop_reinforcement_uncommon", "o", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_FASTHANDS", "specialty_class_fasthands");
  addCrateType("airdrop_reinforcement_uncommon", "p", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_DEXTERITY", "specialty_class_dexterity");
  addCrateType("airdrop_reinforcement_uncommon", "r", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_EXO_BLASTSUPPRESSOR", "specialty_exo_blastsuppressor");
  addCrateType("airdrop_reinforcement_uncommon", "s", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_HARDWIRED", "specialty_class_hardwired");
  addCrateType("airdrop_reinforcement_uncommon", "t", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_TOUGHNESS", "specialty_class_toughness");
  addCrateType("airdrop_reinforcement_uncommon", "u", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_SCAVENGER", "specialty_class_scavenger");
  addCrateType("airdrop_reinforcement_uncommon", "v", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_HARDLINE", "specialty_class_hardline");

  addCrateType("airdrop_reinforcement_rare", "a", 100, ::reinforcementCrateKillstreakThink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar");
  addCrateType("airdrop_reinforcement_rare", "b", 100, ::reinforcementCrateKillstreakThink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret");
  addCrateType("airdrop_reinforcement_rare", "c", 100, ::reinforcementCrateKillstreakThink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_flares");
  addCrateType("airdrop_reinforcement_rare", "d", 100, ::reinforcementCrateKillstreakThink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares");
  addCrateType("airdrop_reinforcement_rare", "e", 100, ::reinforcementCrateKillstreakThink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addCrateType("airdrop_reinforcement_rare", "f", 100, ::reinforcementCrateKillstreakThink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addCrateType("airdrop_reinforcement_rare", "g", 100, ::reinforcementCrateKillstreakThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points", "recon_ugv_stun");

  addCrateType("airdrop_reinforcement_rare", "h", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_EXO_BATTERY", "specialty_extended_battery");
  addCrateType("airdrop_reinforcement_rare", "i", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_LOWPROFILE", "specialty_class_lowprofile");
  addCrateType("airdrop_reinforcement_rare", "k", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_FLAKJACKET", "specialty_class_flakjacket");
  addCrateType("airdrop_reinforcement_rare", "l", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_LIGHTWEIGHT", "specialty_class_lightweight");
  addCrateType("airdrop_reinforcement_rare", "m", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_BLINDEYE", "specialty_class_blindeye");
  addCrateType("airdrop_reinforcement_rare", "n", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_COLDBLOODED", "specialty_class_coldblooded");
  addCrateType("airdrop_reinforcement_rare", "o", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_PERIPHERALS", "specialty_class_peripherals");
  addCrateType("airdrop_reinforcement_rare", "p", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_FASTHANDS", "specialty_class_fasthands");
  addCrateType("airdrop_reinforcement_rare", "q", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_DEXTERITY", "specialty_class_dexterity");
  addCrateType("airdrop_reinforcement_rare", "s", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_EXO_BLASTSUPPRESSOR", "specialty_exo_blastsuppressor");
  addCrateType("airdrop_reinforcement_rare", "t", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_HARDWIRED", "specialty_class_hardwired");
  addCrateType("airdrop_reinforcement_rare", "u", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_TOUGHNESS", "specialty_class_toughness");
  addCrateType("airdrop_reinforcement_rare", "v", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_SCAVENGER", "specialty_class_scavenger");
  addCrateType("airdrop_reinforcement_rare", "w", 100, ::reinforcementCrateSpecialtyThink, &"PERKS_HARDLINE", "specialty_class_hardline");

  addCrateType("airdrop_reinforcement_practice", "a", 168, ::reinforcementCrateKillstreakThink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addCrateType("airdrop_reinforcement_practice", "b", 168, ::reinforcementCrateKillstreakThink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1");
  addCrateType("airdrop_reinforcement_practice", "c", 168, ::reinforcementCrateKillstreakThink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");
  addCrateType("airdrop_reinforcement_practice", "d", 98, ::reinforcementCrateKillstreakThink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam");
  addCrateType("airdrop_reinforcement_practice", "e", 98, ::reinforcementCrateKillstreakThink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addCrateType("airdrop_reinforcement_practice", "f", 100, ::reinforcementCrateKillstreakThink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit");
  addCrateType("airdrop_reinforcement_practice", "g", 100, ::reinforcementCrateKillstreakThink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addCrateType("airdrop_reinforcement_practice", "h", 40, ::reinforcementCrateKillstreakThink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive");
  addCrateType("airdrop_reinforcement_practice", "i", 40, ::reinforcementCrateKillstreakThink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time");
  addCrateType("airdrop_reinforcement_practice", "j", 30, ::reinforcementCrateKillstreakThink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets");
  addCrateType("airdrop_reinforcement_practice", "k", 30, ::reinforcementCrateKillstreakThink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets");
  addCrateType("airdrop_reinforcement_practice", "l", 20, ::reinforcementCrateKillstreakThink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo");
  addCrateType("airdrop_reinforcement_practice", "m", 20, ::reinforcementCrateKillstreakThink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time");
  addCrateType("airdrop_reinforcement_practice", "n", 20, ::reinforcementCrateKillstreakThink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_flares");
  addCrateType("airdrop_reinforcement_practice", "o", 20, ::reinforcementCrateKillstreakThink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth");
  addCrateType("airdrop_reinforcement_practice", "p", 10, ::reinforcementCrateKillstreakThink, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash");
  addCrateType("airdrop_reinforcement_practice", "q", 10, ::reinforcementCrateKillstreakThink, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1");
  addCrateType("airdrop_reinforcement_practice", "r", 10, ::reinforcementCrateKillstreakThink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch");
  addCrateType("airdrop_reinforcement_practice", "s", 10, ::reinforcementCrateKillstreakThink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject");
}

generateMaxWeightedCrateValue() {
  foreach(dropType, dropTypeArray in level.crateTypes) {
    level.crateMaxVal[dropType] = 0;
    foreach(crateType in dropTypeArray) {
      type = crateType.type;
      if(!level.crateTypes[dropType][type].raw_weight) {
        level.crateTypes[dropType][type].weight = level.crateTypes[dropType][type].raw_weight;
        continue;
      }

      level.crateMaxVal[dropType] += level.crateTypes[dropType][type].raw_weight;
      level.crateTypes[dropType][type].weight = level.crateMaxVal[dropType];
    }
  }
}

changeCrateWeight(dropType, crateType, crateWeight) {
  if(!isDefined(level.crateTypes[dropType]) || !isDefined(level.crateTypes[dropType][crateType])) {
    return;
  }

  level.crateTypes[dropType][crateType].raw_weight = crateWeight;
  generateMaxWeightedCrateValue();
}

setAirDropCrateCollision(carePackageName) {
  airDropCrates = getEntArray(carePackageName, "targetname");

  if(!isDefined(airDropCrates) || (airDropCrates.size == 0)) {
    return;
  }

  level.airDropCrateCollision = GetEnt(airDropCrates[0].target, "targetname");

  foreach(crate in airDropCrates) {
    crate deleteCrate();
  }
}

addCrateType(dropType, crateType, crateWeight, crateFunc, hintString, streakRef, moduleRef1, moduleRef2, moduleRef3) {
  if(!isDefined(crateType)) {
    return;
  }

  level.crateTypes[dropType][crateType] = spawnStruct();

  level.crateTypes[dropType][crateType].dropType = dropType;
  level.crateTypes[dropType][crateType].type = crateType;
  level.crateTypes[dropType][crateType].raw_weight = crateWeight;
  level.crateTypes[dropType][crateType].weight = crateWeight;
  level.crateTypes[dropType][crateType].func = crateFunc;
  level.crateTypes[dropType][crateType].streakRef = streakRef;
  level.crateTypes[dropType][crateType].modules = [];
  level.crateTypes[dropType][crateType].modules[level.crateTypes[dropType][crateType].modules.size] = moduleRef1;
  level.crateTypes[dropType][crateType].modules[level.crateTypes[dropType][crateType].modules.size] = moduleRef2;
  level.crateTypes[dropType][crateType].modules[level.crateTypes[dropType][crateType].modules.size] = moduleRef3;

  if(isDefined(hintString)) {
    game["strings"][dropType + crateType + "_hint"] = hintString;
  }
}

getStreakForCrate(dropType, crateType) {
  if(isDefined(level.crateTypes[dropType]) && isDefined(level.crateTypes[dropType][crateType]) && isDefined(level.crateTypes[dropType][crateType].streakRef)) {
    return level.crateTypes[dropType][crateType].streakRef;
  }

  return crateType;
}

getModulesForCrate(dropType, crateType) {
  if(isDefined(level.customKillstreakCrateModules)) {
    return [[level.customKillstreakCrateModules]](dropType, crateType);
  }

  return level.crateTypes[dropType][crateType].modules;
}

getRandomCrateType(dropType, excludeCrateTypes) {
  if(GetDvar("scr_setnextkillstreak", "") != "") {
    killstreak = GetDvar("scr_setnextkillstreak");
    SetDvar("scr_setnextkillstreak", "");

    foreach(crateType in level.crateTypes[dropType]) {
      type = crateType.type;
      if(level.crateTypes[dropType][type].streakRef == killstreak) {
        return type;
      }
    }
  }

  if(GetDvar("g_gametype") != "horde") {
    typeHasMapKillstreak = isDefined(level.mapKillStreak) && isDefined(level.crateTypes[dropType][level.mapKillStreak]);
    canSpawnMapKillStreak = isDefined(level.mapKillstreakAutoDropIndex) && level.numDropCrates >= level.mapKillstreakAutoDropIndex;
    if(typeHasMapKillstreak && canSpawnMapKillStreak) {
      level.mapKillstreakAutoDropIndex = undefined;
      return level.mapKillStreak;
    }
  }

  value = RandomInt(level.crateMaxVal[dropType]);
  selectedCrateType = undefined;

  dropTypes = level.crateTypes[dropType];
  if(isDefined(excludeCrateTypes)) {
    AssertEx(isArray(excludeCrateTypes), "excludeCrateTypes must be an array");
    dropTypeArray = level.crateTypes[dropType];
    foreach(ent in dropTypeArray) {
      if(crateTypeIsExcluded(ent.type, excludeCrateTypes)) {
        dropTypeArray = special_array_remove(dropTypeArray, ent);
      }
    }
    dropTypes = dropTypeArray;
  }

  foreach(crateType in dropTypes) {
    type = crateType.type;
    if(!level.crateTypes[dropType][type].weight) {
      continue;
    }

    selectedCrateType = type;

    if(level.crateTypes[dropType][type].weight > value) {
      break;
    }
  }

  return (selectedCrateType);
}

crateTypeIsExcluded(type, excludeCrateTypes) {
  foreach(excludeType in excludeCrateTypes) {
    if(excludeType == type) {
      return true;
    }
  }

  return false;
}

special_array_remove(array, remove) {
  new_array = [];
  foreach(ent in array) {
    if(ent != remove) {
      new_array[ent.type] = ent;
    }
  }
  return new_array;
}

getCrateTypeForDropType(dropType, excludedCrateTypes) {
  switch (dropType) {
    case "airdrop_assault":
    case "airdrop_assault_odds":
    default:
      return getRandomCrateType(dropType, excludedCrateTypes);
  }
}

deleteOnOwnerDeath(owner) {
  self linkTo(owner, "tag_origin", (0, 0, 0), (0, 0, 0));

  owner waittill("death");

  self delete();
}

crateTeamModelUpdater() {
  self endon("death");

  self hide();
  foreach(player in level.players) {
    if(player.team != "spectator") {
      self ShowToPlayer(player);
    }
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team != "spectator") {
        self ShowToPlayer(player);
      }
    }
  }
}

crateModelTeamUpdater(showForTeam, showToSpectator) {
  self endon("death");

  self hide();

  foreach(player in level.players) {
    if((player.team == showForTeam) || (showToSpectator && (player.team == "spectator"))) {
      self ShowToPlayer(player);
    }
  }

  for(;;) {
    level waittill_any("joined_team", "joined_spectators");

    self hide();
    foreach(player in level.players) {
      if((player.team == showForTeam) || (showToSpectator && (player.team == "spectator"))) {
        self ShowToPlayer(player);
      }
    }
  }
}

crateModelPlayerUpdater(owner, friendly) {
  self endon("death");

  self hide();

  foreach(player in level.players) {
    if(friendly && isDefined(owner) && player != owner) {
      continue;
    }
    if(!friendly && isDefined(owner) && player == owner) {
      continue;
    }

    self ShowToPlayer(player);
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(friendly && isDefined(owner) && player != owner) {
        continue;
      }
      if(!friendly && isDefined(owner) && player == owner) {
        continue;
      }

      self ShowToPlayer(player);
    }
  }
}

crateUseTeamUpdater(team) {
  self endon("death");

  for(;;) {
    setUsableByTeam(team);

    level waittill("joined_team");
  }
}

crateUseJuggernautUpdater() {
  streakRef = getStreakForCrate(self.dropType, self.crateType);
  if(!isSubStr(streakRef, "juggernaut")) {
    return;
  }

  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("juggernaut_equipped", player);

    self disablePlayerUse(player);
    self thread crateUsePostJuggernautUpdater(player);
  }
}

crateUsePostJuggernautUpdater(player) {
  self endon("death");
  level endon("game_ended");
  player endon("disconnect");

  player waittill("death");
  self enablePlayerUse(player);
}

createAirDropCrate(owner, dropType, crateType, startPos, startAngles, alreadyTrapped, setupCollision) {
  if(!isDefined(startAngles)) {
    startAngles = (0, 0, 0);
  }

  if(!isDefined(alreadyTrapped)) {
    alreadyTrapped = false;
  }

  if(!isDefined(setupCollision)) {
    setupCollision = true;
  }

  dropCrate = spawn("script_model", startPos);
  dropCrate.angles = startAngles;

  dropCrate.curProgress = 0;
  dropCrate.useTime = 0;
  dropCrate.useRate = 0;
  dropCrate.team = self.team;

  if(isDefined(owner)) {
    dropCrate.owner = owner;
  } else {
    dropCrate.owner = undefined;
  }

  dropCrate.crateType = crateType;
  dropCrate.dropType = dropType;
  dropCrate.targetname = "care_package";
  dropCrate.isTrap = alreadyTrapped;

  if(dropCrate.team == "any") {
    dropCrate setModel("orbital_carepackage_pod_01_ai");

    dropCrate.friendlyModel = spawn("script_model", dropCrate.origin);
    dropCrate.friendlyModel setModel("tag_origin");
    dropCrate.friendlyModel thread deleteOnOwnerDeath(dropCrate);
  } else {
    dropCrate setModel(maps\mp\gametypes\_teams::getTeamCrateModel(dropCrate.team));
    dropCrate thread crateTeamModelUpdater();

    friendlyModelName = "orbital_carepackage_pod_01_ai";
    enemyModelName = "orbital_carepackage_pod_01_clr_01_ai";
    if(crateType == "booby_trap") {
      friendlyModelName = "orbital_carepackage_pod_01_logo_trap_ai";
      dropCrate thread trap_createBombSquadModel();
    } else if(alreadyTrapped) {
      dropCrate thread trap_createBombSquadModel();
    }

    dropCrate.friendlyModel = spawn("script_model", startPos);
    dropCrate.friendlyModel setModel(friendlyModelName);
    dropCrate.friendlyModel.parentCrate = dropCrate;
    dropCrate.friendlyModel NotSolid();
    dropCrate.enemyModel = spawn("script_model", startPos);
    dropCrate.enemyModel setModel(enemyModelName);
    dropCrate.enemyModel.parentCrate = dropCrate;
    dropCrate.enemyModel NotSolid();

    dropCrate.friendlyModel thread deleteOnOwnerDeath(dropCrate);
    if(level.teambased) {
      dropCrate.friendlyModel thread crateModelTeamUpdater(dropCrate.team, true);
    } else {
      dropCrate.friendlyModel thread crateModelPlayerUpdater(owner, true);
    }

    dropCrate.enemyModel thread deleteOnOwnerDeath(dropCrate);

    if(level.teambased) {
      dropCrate.enemyModel thread crateModelTeamUpdater(level.otherTeam[dropCrate.team], false);
    } else {
      dropCrate.enemyModel thread crateModelPlayerUpdater(owner, false);
    }
  }

  dropCrate.inUse = false;

  if(setupCollision) {
    dropCrate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
  }

  dropCrate.killCamEnt = spawn("script_model", dropCrate.origin + CRATE_KILLCAM_OFFSET);
  dropCrate.killCamEnt SetScriptMoverKillCam("explosive");
  dropCrate.killCamEnt SetContents(0);
  dropCrate.killCamEnt LinkTo(dropCrate);

  level.numDropCrates++;

  return dropCrate;
}

trap_createBombSquadModel() {
  bombSquadModel = spawn("script_model", self.origin);
  bombSquadModel.angles = self.angles;
  bombSquadModel hide();

  bombSquadModel thread maps\mp\gametypes\_weapons::bombSquadVisibilityUpdater(self.owner);
  bombSquadModel setModel("orbital_carepackage_pod_01_ai_bombsquad");
  bombSquadModel linkTo(self);
  bombSquadModel SetContents(0);

  self waittill("death");

  bombSquadModel delete();
}

crateSetupHintStrings(hintString, secondaryHintString) {
  if(isDefined(secondaryHintString) && isDefined(self.owner)) {
    self.ownerStringEnt = spawn("script_model", self.origin + (0, 0, 60));
    self.ownerStringEnt setCursorHint("HINT_NOICON");
    self.ownerStringEnt setHintString(hintString);
    self.ownerStringEnt SetSecondaryHintString(secondaryHintString);

    self.otherStringEnt = spawn("script_model", self.origin + (0, 0, 60));
    self.otherStringEnt setCursorHint("HINT_NOICON");
    self.otherStringEnt setHintString(hintString);
  } else {
    self setCursorHint("HINT_NOICON");
    self setHintString(hintString);
  }
}

onPlayerConnectHintString(otherStringEnt, ownerStringEnt) {
  otherStringEnt endon("death");
  ownerStringEnt endon("death");

  while(true) {
    level waittill("connected", player);

    player thread onPlayerSpawnedHintString(otherStringEnt, ownerStringEnt);
  }
}

onPlayerSpawnedHintString(otherStringEnt, ownerStringEnt) {
  otherStringEnt endon("death");
  ownerStringEnt endon("death");

  self waittill("spawned");

  otherStringEnt EnablePlayerUse(self);
  ownerStringEnt DisablePlayerUse(self);
}

crateSetupForUse(mode, icons) {
  if(isDefined(level.isHorde) && level.isHorde) {
    self waittill("drop_pod_cleared");
  }

  if(isDefined(self.ownerStringEnt)) {
    self.ownerStringEnt MakeUsable();
    self.otherStringEnt MakeUsable();

    foreach(player in level.players) {
      if(player != self.owner) {
        self.ownerStringEnt DisablePlayerUse(player);
        self.otherStringEnt EnablePlayerUse(player);
      } else {
        self.otherStringEnt DisablePlayerUse(player);
        self.ownerStringEnt EnablePlayerUse(player);
      }
    }

    thread onPlayerConnectHintString(self.otherStringEnt, self.ownerStringEnt);
  } else {
    self MakeUsable();
  }

  self.mode = mode;

  if(self.team == "any") {
    curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(curObjID, "invisible", (0, 0, 0));
    objective_position(curObjID, self.origin);
    objective_state(curObjID, "active");

    shaderName = "compass_objpoint_ammo_friendly";
    objective_icon(curObjID, shaderName);

    Objective_Team(curObjID, "none");

    self.objIdFriendly = curObjID;
  } else {
    if(level.teamBased || isDefined(self.owner)) {
      curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
      objective_add(curObjID, "invisible", (0, 0, 0));
      objective_position(curObjID, self.origin);
      objective_state(curObjID, "active");

      shaderName = "compass_objpoint_ammo_friendly";
      if(mode == "trap") {
        shaderName = "compass_objpoint_trap_friendly";
      }
      objective_icon(curObjID, shaderName);

      if(!level.teamBased && isDefined(self.owner)) {
        Objective_PlayerTeam(curObjId, self.owner GetEntityNumber());
      } else {
        Objective_Team(curObjID, self.team);
      }

      self.objIdFriendly = curObjID;
    }

    if(!(isDefined(level.isHorde) && level.isHorde)) {
      if(!isDefined(self.owner) || !(isDefined(self.moduleHide) && self.moduleHide)) {
        curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
        objective_add(curObjID, "invisible", (0, 0, 0));
        objective_position(curObjID, self.origin);
        objective_state(curObjID, "active");
        objective_icon(curObjID, "compass_objpoint_ammo_enemy");

        if(!level.teamBased && isDefined(self.owner)) {
          Objective_PlayerEnemyTeam(curObjId, self.owner GetEntityNumber());
        } else {
          Objective_Team(curObjID, level.otherTeam[self.team]);
        }

        self.objIdEnemy = curObjID;
      }
    }
  }

  if(self.team == "any") {
    foreach(team in level.teamNameList) {
      if(isDefined(icons) && isArray(icons)) {
        self setHeadIcon_multiple(team, icons);
      } else {
        self maps\mp\_entityheadIcons::setHeadIcon(team, icons, (0, 0, CRATE_ICON_Z_OFFSET), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
      }
    }
  } else if(mode == "trap") {
    self thread crateUseTeamUpdater(getOtherTeam(self.team));
  } else {
    self thread crateUseTeamUpdater();

    streakRef = getStreakForCrate(self.dropType, self.crateType);
    if(isSubStr(streakRef, "juggernaut")) {
      foreach(player in level.players) {
        if(player isJuggernaut())
      }
      self thread crateUsePostJuggernautUpdater(player);
    }

    if(level.teamBased) {
      if(isDefined(icons) && isArray(icons)) {
        self setHeadIcon_multiple(self.team, icons);
      } else {
        self maps\mp\_entityheadIcons::setHeadIcon(self.team, icons, (0, 0, CRATE_ICON_Z_OFFSET), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
      }
    } else if(isDefined(self.owner)) {
      if(isDefined(icons) && isArray(icons)) {
        self setHeadIcon_multiple(self.owner, icons);
      } else {
        self maps\mp\_entityheadIcons::setHeadIcon(self.owner, icons, (0, 0, CRATE_ICON_Z_OFFSET), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
      }
    }
  }

  self thread crateUseJuggernautUpdater();
}

setHeadIcon_multiple(showTo, icons) {
  offset = 10;
  i = 0;
  self.iconEnts = [];
  foreach(icon in icons) {
    self.iconEnts[icon] = self spawn_tag_origin();
    self.iconEnts[icon] maps\mp\_entityheadIcons::setHeadIcon(showTo, icon, (0, 0, (CRATE_ICON_Z_OFFSET - 5) + (i * offset)), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
    i++;
  }
}

setUsableByTeam(team) {
  streakRef = getStreakForCrate(self.dropType, self.crateType);

  foreach(player in level.players) {
    if(isSubStr(streakRef, "juggernaut") && player isJuggernaut()) {
      self DisablePlayerUse(player);
    } else if(!level.teamBased && self.mode == "trap") {
      if(isDefined(self.owner) && player == self.owner) {
        self DisablePlayerUse(player);
      } else {
        self EnablePlayerUse(player);
      }
    } else if(!isDefined(team) || team == player.team) {
      self EnablePlayerUse(player);
    } else {
      self DisablePlayerUse(player);
    }
  }
}

physicsWaiter(dropType, crateType) {
  self waittill("physics_finished");

  self.droppingToGround = false;
  self thread[[level.crateTypes[dropType][crateType].func]](dropType);
  level thread dropTimeOut(self, self.owner, crateType);

  killTriggers = getEntArray("trigger_hurt", "classname");
  foreach(trigger in killTriggers) {
    if(self.friendlyModel isTouching(trigger)) {
      self deleteCrate();
      return;
    }
  }

  if(isDefined(self.owner) && (abs(self.origin[2] - self.owner.origin[2]) > 4000)) {
    self deleteCrate();
    return;
  }

  if(isDefined(level.isZombieGame) && level.isZombieGame) {
    self DisconnectPaths();
  }

  data = spawnStruct();
  data.deathOverrideCallback = ::movingPlatformDeathFunc;
  data.touchingPlatformValid = ::movingPlatformTouchValid;
  self thread maps\mp\_movers::handle_moving_platforms(data);
}

movingPlatformDeathFunc(data) {
  self deleteCrate(true, true);
}

movingPlatformTouchValid(platform) {
  return (carepackageAndCarepackageValid(platform) && carepackageAndGoliathValid(platform) && carepackageAndPlatformValid(platform));
}

carepackageAndGoliathValid(platform) {
  return (!isDefined(self.targetname) || !isDefined(platform.crateType) || self.targetname != "care_package" || platform.crateType != "juggernaut");
}

carepackageAndCarepackageValid(platform) {
  return (!isDefined(self.targetname) || !isDefined(platform.targetname) || self.targetname != "care_package" || platform.targetname != "care_package");
}

carepackageAndPlatformValid(platform) {
  return (!isDefined(self.targetname) || !isDefined(platform.carepackageTouchValid) || self.targetname != "care_package" || !platform.carepackageTouchValid);
}

dropTimeOut(dropCrate, owner, crateType) {
  if(isDefined(level.noCrateTimeOut) && (level.noCrateTimeOut)) {
    return;
  }

  level endon("game_ended");
  dropCrate endon("death");

  if(dropCrate.dropType == "nuke_drop") {
    return;
  }

  timeOut = 90.0;
  if(crateType == "supply") {
    timeOut = 20.0;
  }

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeOut);

  while(dropCrate.curProgress != 0) {
    wait 1;
  }

  dropCrate deleteCrate(true, true);
}

crateOtherCaptureThink(useText) {
  self endon("captured");

  crate = self;
  if(isDefined(self.otherStringEnt)) {
    crate = self.otherStringEnt;
  }

  while(isDefined(self)) {
    crate waittill("trigger", player);

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }

    if(player IsJumping() || (isDefined(player.exo_hover_on) && player.exo_hover_on)) {
      continue;
    }

    if(!player IsOnGround() && !waitPlayerStuckOnCarepackageReturn(player)) {
      continue;
    }

    if(!self validateOpenConditions(player)) {
      continue;
    }

    player.isCapturingCrate = true;
    useEnt = self createUseEnt();
    result = false;
    if(self.crateType == "booby_trap") {
      result = useEnt useHoldThink(player, 500, useText);
    } else {
      result = useEnt useHoldThink(player, undefined, useText);
    }

    if(isDefined(useEnt)) {
      useEnt delete();
    }

    if(!result) {
      if(isDefined(player)) {
        player.isCapturingCrate = false;
      }
      continue;
    }

    player.isCapturingCrate = false;

    if(isDefined(level.isHorde) && level.isHorde) {
      if(self.crateType == "juggernaut" && !(isDefined(player.lastStand) && player.lastStand)) {
        player SetDemiGod(true);
      }

      if(isDefined(player.lastStand) && player.lastStand) {
        continue;
      }
    }

    self notify("captured", player);
  }
}

crateOwnerCaptureThink(useText) {
  self endon("captured");

  if(!isDefined(self.owner)) {
    return;
  }

  self.owner endon("disconnect");

  crate = self;
  if(isDefined(self.ownerStringEnt)) {
    crate = self.ownerStringEnt;
  }

  useHoldTime = 500;
  if(isDefined(self.modulePickup) && self.modulePickup) {
    useHoldTime = 100;
  }

  while(isDefined(self)) {
    crate waittill("trigger", player);

    if(isDefined(self.owner) && player != self.owner) {
      continue;
    }

    if(player IsJumping() || (isDefined(player.exo_hover_on) && player.exo_hover_on)) {
      continue;
    }

    if(!player IsOnGround() && !waitPlayerStuckOnCarepackageReturn(player)) {
      continue;
    }

    if(!self validateOpenConditions(player)) {
      continue;
    }

    player.isCapturingCrate = true;
    if(!useHoldThink(player, useHoldTime, useText)) {
      player.isCapturingCrate = false;
      continue;
    }

    player.isCapturingCrate = false;

    if(isDefined(level.isHorde) && level.isHorde) {
      if(self.crateType == "juggernaut" && !(isDefined(player.lastStand) && player.lastStand)) {
        player SetDemiGod(true);
      }

      if(isDefined(player.lastStand) && player.lastStand) {
        continue;
      }
    }

    self notify("captured", player);
  }
}

waitPlayerStuckOnCarepackageReturn(player) {
  if(player IsOnGround()) {
    return false;
  }

  TIME_UNTIL_STUCK = 200;

  startOrg = player.origin;
  stuckTimeStart = GetTime();

  while(isDefined(player) && isReallyAlive(player) && !player IsOnGround() && startOrg == player.origin && player UseButtonPressed()) {
    curTimeButtonHeld = GetTime() - stuckTimeStart;
    if(curTimeButtonHeld >= TIME_UNTIL_STUCK) {
      return true;
    }

    waitframe();
  }

  return false;
}

validateOpenConditions(opener) {
  currentWeapon = opener GetCurrentPrimaryWeapon();

  if(IsSubStr(currentWeapon, "turrethead")) {
    return true;
  }

  if(!(opener maps\mp\killstreaks\_killstreaks::canShuffleWithKillstreakWeapon())) {
    return false;
  }

  if(isDefined(opener.changingWeapon) && !(opener maps\mp\killstreaks\_killstreaks::canShuffleWithKillstreakWeapon())) {
    return false;
  }

  return true;
}

killstreakCrateThink(dropType) {
  self endon("death");

  streakRef = getStreakForCrate(dropType, self.crateType);
  modules = getModulesForCrate(dropType, self.crateType);

  canReroll = isDefined(self.owner) && (self.owner _hasPerk("specialty_highroller") || (isDefined(self.moduleRoll) && self.moduleRoll));

  secondaryHintString = undefined;
  if(canReroll) {
    secondaryHintString = &"MP_PACKAGE_REROLL";
  }

  crateHint = undefined;
  if(isDefined(game["strings"][dropType + self.crateType + "_hint"])) {
    crateHint = game["strings"][dropType + self.crateType + "_hint"];
  } else {
    crateHint = &"PLATFORM_GET_KILLSTREAK";
  }

  crateSetupHintStrings(crateHint, secondaryHintString);
  crateSetupForUse("all", maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon(streakRef, modules));

  if(isDefined(self.owner)) {
    self thread crateOtherCaptureThink();
  }
  self thread crateOwnerCaptureThink();
  if(canReroll) {
    self thread crateOwnerDoubleTapThink();
  }

  if(self.isTrap) {
    self crateTrapSetupKillcam();
  }

  for(;;) {
    self waittill("captured", player);

    streakRef = getStreakForCrate(dropType, self.crateType);
    modules = getModulesForCrate(dropType, self.crateType);

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        if(self.isTrap) {
          player thread detonateTrap(self, self.owner);
          return;
        } else {
          player thread maps\mp\_events::hijackerEvent(self.owner);
        }
      } else {
        self.owner thread maps\mp\_events::sharedEvent();
      }
    }

    player playLocalSound("orbital_pkg_use");

    slotIndex = player maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex(streakRef, false);
    player thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(streakRef, undefined, undefined, modules, slotIndex);
    player thread maps\mp\killstreaks\_killstreaks::giveKillstreak(streakRef, false, false, self.owner, modules);

    if(isDefined(level.mapKillStreak) && (level.mapKillStreak == self.crateType)) {
      player thread maps\mp\_events::mapKillStreakEvent();
    }

    shouldDestroyPlayVFX = true;
    shouldTrapPerk = (player _hasPerk("specialty_highroller") && (!level.teamBased || player.team != self.team));
    packageHasModuleTrap = isDefined(self.moduleTrap) && self.moduleTrap;
    shouldTrapModule = (packageHasModuleTrap && (self.owner == player || (level.teamBased && player.team == self.team)));
    if(shouldTrapPerk || shouldTrapModule) {
      newTrapCrate = player createAirDropCrate(player, "booby_trap", "booby_trap", self.origin, self.angles);
      if(isDefined(newTrapCrate.enemymodel)) {
        newTrapCrate.enemymodel thread maps\mp\killstreaks\_orbital_carepackage::orbitalAnimate(true);
      }
      newTrapCrate thread boobyTrapCrateThink(self);
      level thread dropTimeOut(newTrapCrate, newTrapCrate.owner, newTrapCrate.crateType);
      shouldDestroyPlayVFX = false;

      if(isDefined(newTrapCrate.friendlyModel)) {
        newTrapCrate.friendlyModel Solid();
      }
      if(isDefined(newTrapCrate.enemyModel)) {
        newTrapCrate.enemyModel Solid();
      }
    }

    self deleteCrate(shouldDestroyPlayVFX);
  }
}

detonateTrap(crate, owner) {
  crate endon("death");

  location = crate.origin + (0, 0, 50);

  if(level.teamBased) {
    crate maps\mp\_entityheadIcons::setHeadIcon(self.team, "specialty_trap_crate", (0, 0, CRATE_ICON_Z_OFFSET), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
  } else {
    crate maps\mp\_entityheadIcons::setHeadIcon(self, "specialty_trap_crate", (0, 0, CRATE_ICON_Z_OFFSET), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
  }

  thread play_sound_in_space("orbital_pkg_trap_armed", location);
  wait(1.0);

  forward = (location + (0, 0, 1)) - location;
  playFX(getfx("airdrop_crate_trap_explode"), location, forward);
  thread play_sound_in_space("orbital_pkg_trap_detonate", location);

  if(isDefined(crate.friendlyModel)) {
    crate.friendlyModel NotSolid();
  }
  if(isDefined(crate.enemyModel)) {
    crate.enemyModel NotSolid();
  }

  if(isDefined(owner)) {
    crate.trapKillCamEnt RadiusDamage(location, 400, 300, 50, owner, "MOD_EXPLOSIVE", "airdrop_trap_explosive_mp");
  } else {
    crate.trapKillCamEnt RadiusDamage(location, 400, 300, 50, undefined, "MOD_EXPLOSIVE", "airdrop_trap_explosive_mp");
  }

  crate deleteCrate();
}

deleteCrate(playDestroyVFX, playDeathSound) {
  if(!isDefined(playDestroyVFX)) {
    playDestroyVFX = true;
  }

  if(!isDefined(playDeathSound)) {
    playDeathSound = false;
  }

  if(isDefined(self.objIdFriendly)) {
    _objective_delete(self.objIdFriendly);
  }

  if(isDefined(self.objIdEnemy)) {
    _objective_delete(self.objIdEnemy);
  }

  if(isDefined(self.trapKillcamEnt)) {
    self.trapKillcamEnt delete();
  }

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }

  if(isDefined(self.ownerStringEnt)) {
    self.ownerStringEnt Delete();
  }

  if(isDefined(self.otherStringEnt)) {
    self.otherStringEnt Delete();
  }

  if(isDefined(self.dropType)) {
    if(playDestroyVFX) {
      playFX(getfx("ocp_death"), self.origin);
    }

    if(playDeathSound) {
      playSoundAtPos(self.origin, "orbital_pkg_self_destruct");
    }
  }

  if(isDefined(self.iconEnts)) {
    foreach(icon_ent in self.iconEnts) {
      icon_ent delete();
    }
  }

  self delete();
}

useHoldThink(player, useTime, useText) {
  if(IsPlayer(player)) {
    player playerLinkTo(self);
  } else {
    player LinkTo(self);
  }
  player playerLinkedOffsetEnable();

  if(!player isJuggernaut()) {
    player _disableWeapon();
  }

  self thread useHoldThinkPlayerReset(player);

  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;

  if(isDefined(useTime)) {
    if(player _hasPerk("specialty_unwrapper") && isDefined(player.specialty_unwrapper_care_bonus)) {
      useTime *= player.specialty_unwrapper_care_bonus;
    }
    self.useTime = useTime;
  } else {
    if(player _hasPerk("specialty_unwrapper") && isDefined(player.specialty_unwrapper_care_bonus)) {
      self.useTime = 3000 * player.specialty_unwrapper_care_bonus;
    } else {
      self.useTime = 3000;
    }
  }

  if(IsPlayer(player)) {
    player thread personalUseBar(self, useText);
  }

  result = useHoldThinkLoop(player);
  assert(isDefined(result));

  if(!isDefined(self)) {
    return false;
  }

  self notify("useHoldThinkLoopDone");

  self.inUse = false;
  self.curProgress = 0;

  return (result);
}

useHoldThinkPlayerReset(player) {
  player endon("death");

  self waittill_any("death", "captured", "useHoldThinkLoopDone");

  if(isAlive(player)) {
    if(!player isJuggernaut()) {
      player _enableWeapon();
    }
    if(player isLinked()) {
      player unlink();
    }
  }
}

personalUseBar(object, useText) {
  self endon("disconnect");

  if(isDefined(useText)) {
    iprintlnbold("Fixme @agersant " + useText);
  }
  self SetClientOmnvar("ui_use_bar_text", 1);
  self SetClientOmnvar("ui_use_bar_start_time", int(GetTime()));

  lastRate = -1;
  while(isReallyAlive(self) && isDefined(object) && object.inUse && !level.gameEnded) {
    if(lastRate != object.useRate) {
      if(object.curProgress > object.useTime) {
        object.curProgress = object.useTime;
      }
      if(object.useRate > 0) {
        now = GetTime();
        current = object.curProgress / object.useTime;
        endTime = now + (1 - current) * (object.useTime / object.useRate);
        self SetClientOmnvar("ui_use_bar_end_time", int(endTime));
      }
      lastRate = object.useRate;
    }
    wait(0.05);
  }

  self SetClientOmnvar("ui_use_bar_end_time", 0);
}

isHordeLastStand(player) {
  return isDefined(level.isHorde) && level.isHorde && isDefined(player.lastStand) && player.lastStand;
}

useHoldThinkLoop(player) {
  while(!level.gameEnded && isDefined(self) && isReallyAlive(player) && !isHordeLastStand(player) && player useButtonPressed() && self.curProgress < self.useTime) {
    self.curProgress += (50 * self.useRate);

    if(isDefined(self.objectiveScaler)) {
      self.useRate = 1 * self.objectiveScaler;
    } else {
      self.useRate = 1;
    }

    if(self.curProgress >= self.useTime) {
      return (isReallyAlive(player));
    }

    wait 0.05;
  }

  return false;
}

isAirdropMarker(weaponName) {
  switch (weaponName) {
    case "airdrop_marker_mp":
    case "airdrop_mp":
      return true;
    default:
      return false;
  }
}

createUseEnt() {
  useEnt = spawn("script_origin", self.origin);
  useEnt.curProgress = 0;
  useEnt.useTime = 0;
  useEnt.useRate = 3000;
  useEnt.inUse = false;

  useEnt thread deleteUseEnt(self);

  return (useEnt);
}

deleteUseEnt(owner) {
  self endon("death");

  owner waittill("death");

  self delete();
}

crateOwnerDoubleTapThink() {
  self.packageHoldTimer = 0;
  self.packageSingleTapped = false;

  while(!level.gameEnded && isDefined(self)) {
    if(isReallyAlive(self.owner) && DistanceSquared(self.origin, self.owner.origin) < 10000) {
      if(self.owner useButtonPressed()) {
        self.packageHoldTimer++;
      } else {
        if(self.packageHoldTimer > 0) {
          if(self.packageHoldTimer < 5) {
            if(self.packageSingleTapped == true) {
              self notify("package_double_tap");
              previous_crateType = self.crateType;
              reroll_attempts = 0;
              while(self.crateType == previous_crateType && reroll_attempts < 100) {
                reroll_attempts++;
                self.crateType = getRandomCrateType(self.dropType);
              }

              streakRef = getStreakForCrate(self.dropType, self.crateType);
              modules = getModulesForCrate(self.dropType, self.crateType);

              hintString = game["strings"][self.dropType + self.crateType + "_hint"];

              if(!isDefined(hintString)) {
                hintString = &"PLATFORM_GET_KILLSTREAK";
              }

              if(isDefined(self.ownerStringEnt)) {
                self.ownerStringEnt setHintString(hintString);
                self.otherStringEnt setHintString(hintString);
                self.ownerStringEnt SetSecondaryHintString("");
              } else {
                self setHintString(hintString);
                self SetSecondaryHintString("");
              }
              if(level.teamBased) {
                self maps\mp\_entityheadIcons::setHeadIcon(self.team, maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon(streakRef, modules), (0, 0, CRATE_ICON_Z_OFFSET), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
              } else if(isDefined(self.owner)) {
                self maps\mp\_entityheadIcons::setHeadIcon(self.owner, maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon(streakRef, modules), (0, 0, CRATE_ICON_Z_OFFSET), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
              }

              self.owner PlayLocalSound("orbital_pkg_reroll");

              return true;
            } else {
              self.packageSingleTapped = true;
              self thread tapPackageThink();
            }
          }
          self.packageHoldTimer = 0;
        }
      }
    }
    wait 0.05;
  }
}

tapPackageThink() {
  level endon("game_ended");
  self endon("death");
  self endon("package_double_tap");

  wait(0.2);

  self.packageSingleTapped = false;
}

boobyTrapCrateThink(originalCrate) {
  self endon("death");

  streakRef = getStreakForCrate(originalCrate.dropType, originalCrate.crateType);
  modules = getModulesForCrate(originalCrate.dropType, originalCrate.crateType);

  crateIcon = maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon(streakRef, modules);

  crateHint = undefined;
  if(isDefined(game["strings"][originalCrate.dropType + originalCrate.crateType + "_hint"])) {
    crateHint = game["strings"][originalCrate.dropType + originalCrate.crateType + "_hint"];
  } else {
    crateHint = &"PLATFORM_GET_KILLSTREAK";
  }

  crateSetupHintStrings(crateHint);
  crateSetupForUse("trap", crateIcon);

  self crateTrapSetupKillcam();

  self thread crateOtherCaptureThink(originalCrate);

  for(;;) {
    self waittill("captured", player);

    player thread detonateTrap(self, self.owner);
  }
}

crateTrapSetupKillcam(originalCrate) {
  result = bulletTrace(self.origin, self.origin + (0, 0, 90), false, self);

  self.trapKillCamEnt = spawn("script_model", result["position"]);
  self.trapKillCamEnt SetContents(0);
  self.trapKillCamEnt SetScriptMoverKillCam("large explosive");
}

tryUseReinforcementCommon(lifeId, kID, modules) {
  return maps\mp\killstreaks\_orbital_carepackage::tryUseOrbitalCarePackage(lifeId, "airdrop_reinforcement_common", modules);
}

tryUseReinforcementUncommon(lifeId, kID, modules) {
  return maps\mp\killstreaks\_orbital_carepackage::tryUseOrbitalCarePackage(lifeId, "airdrop_reinforcement_uncommon", modules);
}

tryUseReinforcementRare(lifeId, kID, modules) {
  return maps\mp\killstreaks\_orbital_carepackage::tryUseOrbitalCarePackage(lifeId, "airdrop_reinforcement_rare", modules);
}

tryUseReinforcementPractice(lifeId, kID, modules) {
  return maps\mp\killstreaks\_orbital_carepackage::tryUseOrbitalCarePackage(lifeId, "airdrop_reinforcement_practice", modules);
}

reinforcementCrateKillstreakThink(dropType) {
  self killstreakCrateThink(dropType);
}

reinforcementCrateSpecialtyThink(dropType) {
  self endon("death");

  perkRef = getPerkForCrate(dropType, self.crateType);
  secondaryPerkRef = undefined;

  if(dropType == "airdrop_reinforcement_rare") {
    secondaryPerkRef = getSecondaryPerkForCrate(dropType);
  }

  icon = undefined;

  if(isDefined(secondaryPerkRef)) {
    primaryHint = game["strings"][dropType + self.crateType + "_hint"];
    secondaryHint = getSecondaryPerkHintFromPerkRef(secondaryPerkRef);

    if(isDefined(primaryHint) && isDefined(secondaryHint)) {
      self SetReinforcementHintStrings(primaryHint, secondaryHint);
    } else {
      crateSetupHintStrings(&"MP_PERK_PICKUP_GENERIC_MULTIPLE");
    }

    icon = [];
    icon[0] = getPerkCrateIcon(perkRef);
    if(!isDefined(icon[0])) {
      icon[0] = "";
    }
    icon[1] = getPerkCrateIcon(secondaryPerkRef);
    if(!isDefined(icon[1])) {
      icon[1] = "";
    }
  } else {
    primaryHint = game["strings"][dropType + self.crateType + "_hint"];
    if(isDefined(primaryHint)) {
      self SetReinforcementHintStrings(primaryHint);
    } else {
      crateSetupHintStrings(&"MP_PERK_PICKUP_GENERIC");
    }

    icon = getPerkCrateIcon(perkRef);
    if(!isDefined(icon)) {
      icon = "";
    }
  }

  crateSetupForUse("all", icon);

  if(isDefined(self.owner)) {
    self thread crateOtherCaptureThink();
  }

  self thread crateOwnerCaptureThink();

  for(;;) {
    self waittill("captured", player);

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        player thread maps\mp\_events::hijackerEvent(self.owner);
      } else {
        self.owner thread maps\mp\_events::sharedEvent();
      }
    }

    player playLocalSound("orbital_pkg_use");

    player apply_reinforcement_perk(perkRef);

    perkIdx = int(TableLookupRowNum("mp/perktable.csv", 1, perkRef));

    player SetClientOmnvar("ui_reinforcement_active_perk_1", perkIdx);

    if(isDefined(secondaryPerkRef)) {
      player apply_reinforcement_perk(secondaryPerkRef);

      perkIdx = int(TableLookupRowNum("mp/perktable.csv", 1, secondaryPerkRef));

      player SetClientOmnvar("ui_reinforcement_active_perk_2", perkIdx);
    } else {
      player SetClientOmnvar("ui_reinforcement_active_perk_2", -1);
    }

    self deleteCrate(true);
  }
}

getPerkForCrate(dropType, crateType) {
  if(isDefined(level.crateTypes[dropType][crateType].streakRef)) {
    return level.crateTypes[dropType][crateType].streakRef;
  }

  return crateType;
}

getSecondaryPerkForCrate(dropType) {
  if(isDefined(level.crateTypes[dropType]) && isDefined(level.crateTypes[dropType][self.crateType])) {
    excludeCrateTypes = [];
    foreach(crate in level.crateTypes[dropType]) {
      if(!IsSubStr(crate.streakRef, "specialty_")) {
        excludeCrateTypes[excludeCrateTypes.size] = crate.type;
      }
    }
    excludeCrateTypes[excludeCrateTypes.size] = self.crateType;
    secondaryCrateType = getRandomCrateType(dropType, excludeCrateTypes);
    if(isDefined(secondaryCrateType) && isDefined(level.crateTypes[dropType][secondaryCrateType].streakRef)) {
      return level.crateTypes[dropType][secondaryCrateType].streakRef;
    }

  }

  return undefined;
}

getSecondaryPerkHintFromPerkRef(perkName) {
  crateHint = undefined;

  if(isDefined(level.secondaryReinforcementHintText[perkName])) {
    crateHint = level.secondaryReinforcementHintText[perkName];
  }

  return crateHint;
}

getPerkCrateIcon(perkName) {
  perk_file = "mp/perktable.csv";
  perkName_column = 1;
  imageName_column = 11;

  return tableLookup(perk_file, perkName_column, perkName, imageName_column);
}

apply_reinforcement_perk(perkName) {
  Assert(isDefined(perkName));

  if(perkName == "specialty_extended_battery") {
    self givePerk("specialty_extended_battery", false);
    self givePerk("specialty_exo_slamboots", false);

    return;
  }

  if(perkName == "specialty_class_lowprofile") {
    self givePerk("specialty_radarimmune", false);
    self givePerk("specialty_exoping_immune", false);

    return;
  }

  if(perkName == "specialty_class_flakjacket") {
    self givePerk("specialty_hard_shell", false);
    self givePerk("specialty_throwback", false);
    self givePerk("_specialty_blastshield", false);

    self.specialty_blastshield_bonus = getIntProperty("perk_blastShieldScale", 45) / 100;

    if(isDefined(level.hardcoreMode) && level.hardcoreMode) {
      self.specialty_blastshield_bonus = getIntProperty("perk_blastShieldScale_HC", 90) / 100;
    }

    return;
  }

  if(perkName == "specialty_class_lightweight") {
    self givePerk("specialty_lightweight", false);

    return;
  }

  if(perkName == "specialty_class_dangerclose") {
    self givePerk("specialty_explosivedamage", false);

    return;
  }

  if(perkName == "specialty_class_blindeye") {
    self givePerk("specialty_blindeye", false);
    self givePerk("specialty_plainsight", false);

    return;
  }

  if(perkName == "specialty_class_coldblooded") {
    self givePerk("specialty_coldblooded", false);
    self givePerk("specialty_spygame", false);
    self givePerk("specialty_heartbreaker", false);

    return;
  }

  if(perkName == "specialty_class_peripherals") {
    self givePerk("specialty_moreminimap", false);
    self givePerk("specialty_silentkill", false);

    return;
  }

  if(perkName == "specialty_class_fasthands") {
    self givePerk("specialty_quickswap", false);
    self givePerk("specialty_fastoffhand", false);
    self givePerk("specialty_sprintreload", false);

    return;
  }

  if(perkName == "specialty_class_dexterity") {
    self givePerk("specialty_sprintfire", false);

    return;
  }

  if(perkName == "specialty_class_hardwired") {
    self givePerk("specialty_empimmune", false);
    self givePerk("specialty_stun_resistance", false);
    self.stunScaler = 0.1;

    return;
  }

  if(perkName == "specialty_class_toughness") {
    self setViewKickScale(0.2);

    return;
  }

  if(perkName == "specialty_class_scavenger") {
    self.ammopickup_scalar = 0.2;
    self givePerk("specialty_scavenger", false);
    self givePerk("specialty_bulletresupply", false);

    self givePerk("specialty_extraammo", false);

    return;
  }

  if(perkName == "specialty_class_hardline") {
    self givePerk("specialty_hardline", false);
    self maps\mp\killstreaks\_killstreaks::updateStreakCount();

    return;
  }

}