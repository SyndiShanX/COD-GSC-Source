/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42935.gsc
**************************************/

init() {
  if(getdvarint("virtuallobbyactive", 0)) {
    return;
  }
  level._effect["airdrop_crate_destroy"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
  level._effect["airdrop_crate_trap_explode"] = loadfx("vfx/explosion/frag_grenade_default");
  setairdropcratecollision("airdrop_crate");
  setairdropcratecollision("care_package");
  level.numdropcrates = 0;
  level.cratetypes = [];
  level.killstreakwieldweapons["airdrop_trap_explosive_mp"] = "airdrop_assault";
  level.killstreakfuncs["airdrop_reinforcement_common"] = ::tryusereinforcementcommon;
  level.killstreakfuncs["airdrop_reinforcement_uncommon"] = ::tryusereinforcementuncommon;
  level.killstreakfuncs["airdrop_reinforcement_rare"] = ::tryusereinforcementrare;
  level.killstreakfuncs["airdrop_reinforcement_practice"] = ::tryusereinforcementpractice;
  addcratetypes_standard();
  level.secondaryreinforcementhinttext = [];
  level.secondaryreinforcementhinttext["specialty_extended_battery"] = &"PERKS_EXO_BATTERY";
  level.secondaryreinforcementhinttext["specialty_class_lowprofile"] = &"PERKS_LOWPROFILE";
  level.secondaryreinforcementhinttext["specialty_class_flakjacket"] = &"PERKS_FLAKJACKET";
  level.secondaryreinforcementhinttext["specialty_class_lightweight"] = &"PERKS_LIGHTWEIGHT";
  level.secondaryreinforcementhinttext["specialty_class_blindeye"] = &"PERKS_BLINDEYE";
  level.secondaryreinforcementhinttext["specialty_class_coldblooded"] = &"PERKS_COLDBLOODED";
  level.secondaryreinforcementhinttext["specialty_class_peripherals"] = &"PERKS_PERIPHERALS";
  level.secondaryreinforcementhinttext["specialty_class_fasthands"] = &"PERKS_FASTHANDS";
  level.secondaryreinforcementhinttext["specialty_class_dexterity"] = &"PERKS_DEXTERITY";
  level.secondaryreinforcementhinttext["specialty_exo_blastsuppressor"] = &"PERKS_EXO_BLASTSUPPRESSOR";
  level.secondaryreinforcementhinttext["specialty_class_hardwired"] = &"PERKS_HARDWIRED";
  level.secondaryreinforcementhinttext["specialty_class_toughness"] = &"PERKS_TOUGHNESS";
  level.secondaryreinforcementhinttext["specialty_class_scavenger"] = &"PERKS_SCAVENGER";
  level.secondaryreinforcementhinttext["specialty_class_hardline"] = &"PERKS_HARDLINE";

  if(isDefined(level.customcratefunc)) {
    [[level.customcratefunc]]();
  }

  generatemaxweightedcratevalue();
  level.mapkillstreakautodropindex = randomint(4);
}

addcratetypes_standard() {
  var_0 = level.mapkillstreak;

  if(isDefined(level.mapstreaksdisabled) && level.mapstreaksdisabled) {
    var_0 = undefined;
  }

  addcratetype("airdrop_assault", var_0, 168, ::killstreakcratethink, level.mapkillstreakpickupstring, var_0);
  addcratetype("airdrop_assault", "b", 168, ::killstreakcratethink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_heavy_resistance");
  addcratetype("airdrop_assault", "c", 168, ::killstreakcratethink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addcratetype("airdrop_assault", "d", 168, ::killstreakcratethink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1");
  addcratetype("airdrop_assault", "e", 168, ::killstreakcratethink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1");
  addcratetype("airdrop_assault", "f", 168, ::killstreakcratethink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_cloak", "recon_ugv_assist_points");
  addcratetype("airdrop_assault", "g", 168, ::killstreakcratethink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");
  addcratetype("airdrop_assault", "h", 98, ::killstreakcratethink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam");
  addcratetype("airdrop_assault", "i", 98, ::killstreakcratethink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addcratetype("airdrop_assault", "j", 100, ::killstreakcratethink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit");
  addcratetype("airdrop_assault", "k", 100, ::killstreakcratethink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addcratetype("airdrop_assault", "l", 40, ::killstreakcratethink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive");
  addcratetype("airdrop_assault", "m", 40, ::killstreakcratethink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time");
  addcratetype("airdrop_assault", "n", 30, ::killstreakcratethink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets");
  addcratetype("airdrop_assault", "o", 30, ::killstreakcratethink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets");
  addcratetype("airdrop_assault", "p", 20, ::killstreakcratethink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo");
  addcratetype("airdrop_assault", "q", 20, ::killstreakcratethink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time");
  addcratetype("airdrop_assault", "r", 20, ::killstreakcratethink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_two", "strafing_run_airstrike_flares");
  addcratetype("airdrop_assault", "s", 20, ::killstreakcratethink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth");
  addcratetype("airdrop_assault", "t", 10, ::killstreakcratethink, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash");
  addcratetype("airdrop_assault", "u", 10, ::killstreakcratethink, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1");
  addcratetype("airdrop_assault", "v", 10, ::killstreakcratethink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch");
  addcratetype("airdrop_assault", "w", 10, ::killstreakcratethink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject");
  addcratetype("airdrop_assault_odds", var_0, 136, ::killstreakcratethink, level.mapkillstreakpickupstring, var_0);
  addcratetype("airdrop_assault_odds", "b", 136, ::killstreakcratethink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_heavy_resistance");
  addcratetype("airdrop_assault_odds", "c", 136, ::killstreakcratethink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addcratetype("airdrop_assault_odds", "d", 136, ::killstreakcratethink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1");
  addcratetype("airdrop_assault_odds", "e", 136, ::killstreakcratethink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1");
  addcratetype("airdrop_assault_odds", "f", 136, ::killstreakcratethink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_cloak", "recon_ugv_assist_points");
  addcratetype("airdrop_assault_odds", "g", 136, ::killstreakcratethink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");
  addcratetype("airdrop_assault_odds", "h", 116, ::killstreakcratethink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam");
  addcratetype("airdrop_assault_odds", "i", 116, ::killstreakcratethink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addcratetype("airdrop_assault_odds", "j", 100, ::killstreakcratethink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit");
  addcratetype("airdrop_assault_odds", "k", 100, ::killstreakcratethink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addcratetype("airdrop_assault_odds", "l", 60, ::killstreakcratethink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive");
  addcratetype("airdrop_assault_odds", "m", 60, ::killstreakcratethink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time");
  addcratetype("airdrop_assault_odds", "n", 50, ::killstreakcratethink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets");
  addcratetype("airdrop_assault_odds", "o", 50, ::killstreakcratethink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets");
  addcratetype("airdrop_assault_odds", "p", 40, ::killstreakcratethink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo");
  addcratetype("airdrop_assault_odds", "q", 40, ::killstreakcratethink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time");
  addcratetype("airdrop_assault_odds", "r", 40, ::killstreakcratethink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_two", "strafing_run_airstrike_flares");
  addcratetype("airdrop_assault_odds", "s", 40, ::killstreakcratethink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth");
  addcratetype("airdrop_assault_odds", "t", 30, ::killstreakcratethink, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash");
  addcratetype("airdrop_assault_odds", "u", 30, ::killstreakcratethink, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1");
  addcratetype("airdrop_assault_odds", "v", 30, ::killstreakcratethink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch");
  addcratetype("airdrop_assault_odds", "w", 30, ::killstreakcratethink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject");
  addcratetype("airdrop_reinforcement_common", "a", 100, ::reinforcementcratekillstreakthink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian");
  addcratetype("airdrop_reinforcement_common", "b", 100, ::reinforcementcratekillstreakthink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction");
  addcratetype("airdrop_reinforcement_common", "c", 100, ::reinforcementcratekillstreakthink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_assist_points");
  addcratetype("airdrop_reinforcement_uncommon", "a", 100, ::reinforcementcratekillstreakthink, &"MP_EMP_PICKUP", "emp");
  addcratetype("airdrop_reinforcement_uncommon", "b", 100, ::reinforcementcratekillstreakthink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_rockets");
  addcratetype("airdrop_reinforcement_uncommon", "c", 100, ::reinforcementcratekillstreakthink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addcratetype("airdrop_reinforcement_uncommon", "d", 100, ::reinforcementcratekillstreakthink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1");
  addcratetype("airdrop_reinforcement_uncommon", "e", 100, ::reinforcementcratekillstreakthink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time");
  addcratetype("airdrop_reinforcement_uncommon", "f", 100, ::reinforcementcratekillstreakthink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");
  addcratetype("airdrop_reinforcement_uncommon", "g", 100, ::reinforcementcratespecialtythink, &"PERKS_EXO_BATTERY", "specialty_extended_battery");
  addcratetype("airdrop_reinforcement_uncommon", "h", 100, ::reinforcementcratespecialtythink, &"PERKS_LOWPROFILE", "specialty_class_lowprofile");
  addcratetype("airdrop_reinforcement_uncommon", "j", 100, ::reinforcementcratespecialtythink, &"PERKS_FLAKJACKET", "specialty_class_flakjacket");
  addcratetype("airdrop_reinforcement_uncommon", "k", 100, ::reinforcementcratespecialtythink, &"PERKS_LIGHTWEIGHT", "specialty_class_lightweight");
  addcratetype("airdrop_reinforcement_uncommon", "l", 100, ::reinforcementcratespecialtythink, &"PERKS_BLINDEYE", "specialty_class_blindeye");
  addcratetype("airdrop_reinforcement_uncommon", "m", 100, ::reinforcementcratespecialtythink, &"PERKS_COLDBLOODED", "specialty_class_coldblooded");
  addcratetype("airdrop_reinforcement_uncommon", "n", 100, ::reinforcementcratespecialtythink, &"PERKS_PERIPHERALS", "specialty_class_peripherals");
  addcratetype("airdrop_reinforcement_uncommon", "o", 100, ::reinforcementcratespecialtythink, &"PERKS_FASTHANDS", "specialty_class_fasthands");
  addcratetype("airdrop_reinforcement_uncommon", "p", 100, ::reinforcementcratespecialtythink, &"PERKS_DEXTERITY", "specialty_class_dexterity");
  addcratetype("airdrop_reinforcement_uncommon", "r", 100, ::reinforcementcratespecialtythink, &"PERKS_EXO_BLASTSUPPRESSOR", "specialty_exo_blastsuppressor");
  addcratetype("airdrop_reinforcement_uncommon", "s", 100, ::reinforcementcratespecialtythink, &"PERKS_HARDWIRED", "specialty_class_hardwired");
  addcratetype("airdrop_reinforcement_uncommon", "t", 100, ::reinforcementcratespecialtythink, &"PERKS_TOUGHNESS", "specialty_class_toughness");
  addcratetype("airdrop_reinforcement_uncommon", "u", 100, ::reinforcementcratespecialtythink, &"PERKS_SCAVENGER", "specialty_class_scavenger");
  addcratetype("airdrop_reinforcement_uncommon", "v", 100, ::reinforcementcratespecialtythink, &"PERKS_HARDLINE", "specialty_class_hardline");
  addcratetype("airdrop_reinforcement_rare", "a", 100, ::reinforcementcratekillstreakthink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar");
  addcratetype("airdrop_reinforcement_rare", "b", 100, ::reinforcementcratekillstreakthink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret");
  addcratetype("airdrop_reinforcement_rare", "c", 100, ::reinforcementcratekillstreakthink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_flares");
  addcratetype("airdrop_reinforcement_rare", "d", 100, ::reinforcementcratekillstreakthink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares");
  addcratetype("airdrop_reinforcement_rare", "e", 100, ::reinforcementcratekillstreakthink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addcratetype("airdrop_reinforcement_rare", "f", 100, ::reinforcementcratekillstreakthink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addcratetype("airdrop_reinforcement_rare", "g", 100, ::reinforcementcratekillstreakthink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points", "recon_ugv_stun");
  addcratetype("airdrop_reinforcement_rare", "h", 100, ::reinforcementcratespecialtythink, &"PERKS_EXO_BATTERY", "specialty_extended_battery");
  addcratetype("airdrop_reinforcement_rare", "i", 100, ::reinforcementcratespecialtythink, &"PERKS_LOWPROFILE", "specialty_class_lowprofile");
  addcratetype("airdrop_reinforcement_rare", "k", 100, ::reinforcementcratespecialtythink, &"PERKS_FLAKJACKET", "specialty_class_flakjacket");
  addcratetype("airdrop_reinforcement_rare", "l", 100, ::reinforcementcratespecialtythink, &"PERKS_LIGHTWEIGHT", "specialty_class_lightweight");
  addcratetype("airdrop_reinforcement_rare", "m", 100, ::reinforcementcratespecialtythink, &"PERKS_BLINDEYE", "specialty_class_blindeye");
  addcratetype("airdrop_reinforcement_rare", "n", 100, ::reinforcementcratespecialtythink, &"PERKS_COLDBLOODED", "specialty_class_coldblooded");
  addcratetype("airdrop_reinforcement_rare", "o", 100, ::reinforcementcratespecialtythink, &"PERKS_PERIPHERALS", "specialty_class_peripherals");
  addcratetype("airdrop_reinforcement_rare", "p", 100, ::reinforcementcratespecialtythink, &"PERKS_FASTHANDS", "specialty_class_fasthands");
  addcratetype("airdrop_reinforcement_rare", "q", 100, ::reinforcementcratespecialtythink, &"PERKS_DEXTERITY", "specialty_class_dexterity");
  addcratetype("airdrop_reinforcement_rare", "s", 100, ::reinforcementcratespecialtythink, &"PERKS_EXO_BLASTSUPPRESSOR", "specialty_exo_blastsuppressor");
  addcratetype("airdrop_reinforcement_rare", "t", 100, ::reinforcementcratespecialtythink, &"PERKS_HARDWIRED", "specialty_class_hardwired");
  addcratetype("airdrop_reinforcement_rare", "u", 100, ::reinforcementcratespecialtythink, &"PERKS_TOUGHNESS", "specialty_class_toughness");
  addcratetype("airdrop_reinforcement_rare", "v", 100, ::reinforcementcratespecialtythink, &"PERKS_SCAVENGER", "specialty_class_scavenger");
  addcratetype("airdrop_reinforcement_rare", "w", 100, ::reinforcementcratespecialtythink, &"PERKS_HARDLINE", "specialty_class_hardline");
  addcratetype("airdrop_reinforcement_practice", "a", 168, ::reinforcementcratekillstreakthink, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret");
  addcratetype("airdrop_reinforcement_practice", "b", 168, ::reinforcementcratekillstreakthink, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1");
  addcratetype("airdrop_reinforcement_practice", "c", 168, ::reinforcementcratekillstreakthink, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points");
  addcratetype("airdrop_reinforcement_practice", "d", 98, ::reinforcementcratekillstreakthink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam");
  addcratetype("airdrop_reinforcement_practice", "e", 98, ::reinforcementcratekillstreakthink, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration");
  addcratetype("airdrop_reinforcement_practice", "f", 100, ::reinforcementcratekillstreakthink, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit");
  addcratetype("airdrop_reinforcement_practice", "g", 100, ::reinforcementcratekillstreakthink, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline");
  addcratetype("airdrop_reinforcement_practice", "h", 40, ::reinforcementcratekillstreakthink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive");
  addcratetype("airdrop_reinforcement_practice", "i", 40, ::reinforcementcratekillstreakthink, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time");
  addcratetype("airdrop_reinforcement_practice", "j", 30, ::reinforcementcratekillstreakthink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets");
  addcratetype("airdrop_reinforcement_practice", "k", 30, ::reinforcementcratekillstreakthink, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets");
  addcratetype("airdrop_reinforcement_practice", "l", 20, ::reinforcementcratekillstreakthink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo");
  addcratetype("airdrop_reinforcement_practice", "m", 20, ::reinforcementcratekillstreakthink, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time");
  addcratetype("airdrop_reinforcement_practice", "n", 20, ::reinforcementcratekillstreakthink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_flares");
  addcratetype("airdrop_reinforcement_practice", "o", 20, ::reinforcementcratekillstreakthink, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth");
  addcratetype("airdrop_reinforcement_practice", "p", 10, ::reinforcementcratekillstreakthink, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash");
  addcratetype("airdrop_reinforcement_practice", "q", 10, ::reinforcementcratekillstreakthink, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1");
  addcratetype("airdrop_reinforcement_practice", "r", 10, ::reinforcementcratekillstreakthink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch");
  addcratetype("airdrop_reinforcement_practice", "s", 10, ::reinforcementcratekillstreakthink, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject");
}

generatemaxweightedcratevalue() {
  foreach(var_6, var_1 in level.cratetypes) {
    level.cratemaxval[var_6] = 0;

    foreach(var_3 in var_1) {
      var_4 = var_3.type;

      if(!level.cratetypes[var_6][var_4].raw_weight) {
        level.cratetypes[var_6][var_4].weight = level.cratetypes[var_6][var_4].raw_weight;
        continue;
      }

      level.cratemaxval[var_6] = level.cratemaxval[var_6] + level.cratetypes[var_6][var_4].raw_weight;
      level.cratetypes[var_6][var_4].weight = level.cratemaxval[var_6];
    }
  }
}

changecrateweight(var_0, var_1, var_2) {
  if(!isDefined(level.cratetypes[var_0]) || !isDefined(level.cratetypes[var_0][var_1])) {
    return;
  }
  level.cratetypes[var_0][var_1].raw_weight = var_2;
  generatemaxweightedcratevalue();
}

setairdropcratecollision(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level.airdropcratecollision = getent(var_1[0].target, "targetname");

  foreach(var_3 in var_1) {
    var_3 deletecrate();
  }
}

addcratetype(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1)) {
    return;
  }
  level.cratetypes[var_0][var_1] = spawnStruct();
  level.cratetypes[var_0][var_1].droptype = var_0;
  level.cratetypes[var_0][var_1].type = var_1;
  level.cratetypes[var_0][var_1].raw_weight = var_2;
  level.cratetypes[var_0][var_1].weight = var_2;
  level.cratetypes[var_0][var_1].func = var_3;
  level.cratetypes[var_0][var_1].streakref = var_5;
  level.cratetypes[var_0][var_1].modules = [];
  level.cratetypes[var_0][var_1].modules[level.cratetypes[var_0][var_1].modules.size] = var_6;
  level.cratetypes[var_0][var_1].modules[level.cratetypes[var_0][var_1].modules.size] = var_7;
  level.cratetypes[var_0][var_1].modules[level.cratetypes[var_0][var_1].modules.size] = var_8;

  if(isDefined(var_4)) {
    game["strings"][var_0 + var_1 + "_hint"] = var_4;
  }
}

getstreakforcrate(var_0, var_1) {
  if(isDefined(level.cratetypes[var_0]) && isDefined(level.cratetypes[var_0][var_1]) && isDefined(level.cratetypes[var_0][var_1].streakref)) {
    return level.cratetypes[var_0][var_1].streakref;
  }

  return var_1;
}

getmodulesforcrate(var_0, var_1) {
  if(isDefined(level.customkillstreakcratemodules)) {
    return [[level.customkillstreakcratemodules]](var_0, var_1);
  }

  return level.cratetypes[var_0][var_1].modules;
}

getrandomcratetype(var_0, var_1) {
  if(getDvar("g_gametype") != "horde") {
    var_7 = isDefined(level.mapkillstreak) && isDefined(level.cratetypes[var_0][level.mapkillstreak]);
    var_8 = isDefined(level.mapkillstreakautodropindex) && level.numdropcrates >= level.mapkillstreakautodropindex;

    if(var_7 && var_8) {
      level.mapkillstreakautodropindex = undefined;
      return level.mapkillstreak;
    }
  }

  var_9 = randomint(level.cratemaxval[var_0]);
  var_10 = undefined;
  var_11 = level.cratetypes[var_0];

  if(isDefined(var_1)) {
    var_12 = level.cratetypes[var_0];

    foreach(var_14 in var_12) {
      if(cratetypeisexcluded(var_14.type, var_1)) {
        var_12 = special_array_remove(var_12, var_14);
      }
    }

    var_11 = var_12;
  }

  foreach(var_4 in var_11) {
    var_5 = var_4.type;

    if(!level.cratetypes[var_0][var_5].weight) {
      continue;
    }
    var_10 = var_5;

    if(level.cratetypes[var_0][var_5].weight > var_9) {
      break;
    }
  }

  return var_10;
}

cratetypeisexcluded(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

special_array_remove(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_4.type] = var_4;
    }
  }

  return var_2;
}

getcratetypefordroptype(var_0, var_1) {
  switch (var_0) {
    case "airdrop_assault_odds":
    case "airdrop_assault":
    default:
      return getrandomcratetype(var_0, var_1);
  }
}

deleteonownerdeath(var_0) {
  self linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 waittill("death");
  self delete();
}

crateteammodelupdater() {
  self endon("death");
  self hide();

  foreach(var_1 in level.players) {
    if(var_1.team != "spectator") {
      self showtoplayer(var_1);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_1 in level.players) {
      if(var_1.team != "spectator") {
        self showtoplayer(var_1);
      }
    }
  }
}

cratemodelteamupdater(var_0, var_1) {
  self endon("death");
  self hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_0 || var_1 && var_3.team == "spectator") {
      self showtoplayer(var_3);
    }
  }

  for(;;) {
    level common_scripts\utility::waittill_any("joined_team", "joined_spectators");
    self hide();

    foreach(var_3 in level.players) {
      if(var_3.team == var_0 || var_1 && var_3.team == "spectator") {
        self showtoplayer(var_3);
      }
    }
  }
}

cratemodelplayerupdater(var_0, var_1) {
  self endon("death");
  self hide();

  foreach(var_3 in level.players) {
    if(var_1 && isDefined(var_0) && var_3 != var_0) {
      continue;
    }
    if(!var_1 && isDefined(var_0) && var_3 == var_0) {
      continue;
    }
    self showtoplayer(var_3);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_3 in level.players) {
      if(var_1 && isDefined(var_0) && var_3 != var_0) {
        continue;
      }
      if(!var_1 && isDefined(var_0) && var_3 == var_0) {
        continue;
      }
      self showtoplayer(var_3);
    }
  }
}

crateuseteamupdater(var_0) {
  self endon("death");

  for(;;) {
    setusablebyteam(var_0);
    level waittill("joined_team");
  }
}

crateusejuggernautupdater() {
  var_0 = getstreakforcrate(self.droptype, self.cratetype);

  if(!issubstr(var_0, "juggernaut")) {
    return;
  }
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("juggernaut_equipped", var_1);
    self disableplayeruse(var_1);
    thread crateusepostjuggernautupdater(var_1);
  }
}

crateusepostjuggernautupdater(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("death");
  self enableplayeruse(var_0);
}

createairdropcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = spawn("script_model", var_3);
  var_7.angles = var_4;
  var_7.curprogress = 0;
  var_7.usetime = 0;
  var_7.userate = 0;
  var_7.team = self.team;

  if(isDefined(var_0)) {
    var_7.owner = var_0;
  } else {
    var_7.owner = undefined;
  }

  var_7.cratetype = var_2;
  var_7.droptype = var_1;
  var_7.targetname = "care_package";
  var_7.istrap = var_5;

  if(var_7.team == "any") {
    var_7 setModel("orbital_carepackage_pod_01_ai");
    var_7.friendlymodel = spawn("script_model", var_7.origin);
    var_7.friendlymodel setModel("tag_origin");
    var_7.friendlymodel thread deleteonownerdeath(var_7);
  } else if(isDefined(level.iszombiegame) && level.iszombiegame) {
    var_7 setModel("orbital_carepackage_pod_01_logo_atlas");
    var_7.friendlymodel = spawn("script_model", var_7.origin);
    var_7.friendlymodel setModel("orbital_carepackage_pod_01_ai");
    var_7.friendlymodel.parentcrate = var_7;
    var_7.friendlymodel notsolid();
    var_7.friendlymodel thread deleteonownerdeath(var_7);
  } else {
    var_7 setModel(maps\mp\gametypes\_teams::getteamcratemodel(var_7.team));
    var_7 thread crateteammodelupdater();
    var_8 = "orbital_carepackage_pod_01_ai";
    var_9 = "orbital_carepackage_pod_01_clr_01_ai";

    if(var_2 == "booby_trap") {
      var_8 = "orbital_carepackage_pod_01_logo_trap_ai";
      var_7 thread trap_createbombsquadmodel();
    } else if(var_5) {
      var_7 thread trap_createbombsquadmodel();
    }

    var_7.friendlymodel = spawn("script_model", var_3);
    var_7.friendlymodel setModel(var_8);
    var_7.friendlymodel.parentcrate = var_7;
    var_7.friendlymodel notsolid();
    var_7.enemymodel = spawn("script_model", var_3);
    var_7.enemymodel setModel(var_9);
    var_7.enemymodel.parentcrate = var_7;
    var_7.enemymodel notsolid();
    var_7.friendlymodel thread deleteonownerdeath(var_7);

    if(level.teambased) {
      var_7.friendlymodel thread cratemodelteamupdater(var_7.team, 1);
    } else {
      var_7.friendlymodel thread cratemodelplayerupdater(var_0, 1);
    }

    var_7.enemymodel thread deleteonownerdeath(var_7);

    if(level.teambased) {
      var_7.enemymodel thread cratemodelteamupdater(level.otherteam[var_7.team], 0);
    } else {
      var_7.enemymodel thread cratemodelplayerupdater(var_0, 0);
    }
  }

  var_7.inuse = 0;

  if(var_6) {
    var_7 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
  }

  var_7.killcament = spawn("script_model", var_7.origin + (0, 0, -200));
  var_7.killcament setscriptmoverkillcam("explosive");
  var_7.killcament setcontents(0);
  var_7.killcament linkto(var_7);
  level.numdropcrates++;
  return var_7;
}

trap_createbombsquadmodel() {
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 hide();
  var_0 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(self.owner);
  var_0 setModel("orbital_carepackage_pod_01_ai_bombsquad");
  var_0 linkto(self);
  var_0 setcontents(0);
  self waittill("death");
  var_0 delete();
}

cratesetuphintstrings(var_0, var_1) {
  if(isDefined(var_1) && isDefined(self.owner)) {
    self.ownerstringent = spawn("script_model", self.origin + (0, 0, 60));
    self.ownerstringent setcursorhint("HINT_NOICON");
    self.ownerstringent sethintstring(var_0);
    self.ownerstringent setsecondaryhintstring(var_1);
    self.otherstringent = spawn("script_model", self.origin + (0, 0, 60));
    self.otherstringent setcursorhint("HINT_NOICON");
    self.otherstringent sethintstring(var_0);
  } else {
    self setcursorhint("HINT_NOICON");
    self sethintstring(var_0);
  }
}

onplayerconnecthintstring(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    level waittill("connected", var_2);
    var_2 thread onplayerspawnedhintstring(var_0, var_1);
  }
}

onplayerspawnedhintstring(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  self waittill("spawned");
  var_0 enableplayeruse(self);
  var_1 disableplayeruse(self);
}

cratesetupforuse(var_0, var_1) {
  if(isDefined(level.ishorde) && level.ishorde) {
    self waittill("drop_pod_cleared");
  }

  if(isDefined(self.ownerstringent)) {
    self.ownerstringent makeusable();
    self.otherstringent makeusable();

    foreach(var_3 in level.players) {
      if(var_3 != self.owner) {
        self.ownerstringent disableplayeruse(var_3);
        self.otherstringent enableplayeruse(var_3);
        continue;
      }

      self.otherstringent disableplayeruse(var_3);
      self.ownerstringent enableplayeruse(var_3);
    }

    thread onplayerconnecthintstring(self.otherstringent, self.ownerstringent);
  } else {
    self makeusable();
  }

  self.mode = var_0;

  if(self.team == "any") {
    var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add(var_5, "invisible", (0, 0, 0));
    objective_position(var_5, self.origin);
    objective_state(var_5, "active");
    var_6 = "compass_objpoint_ammo_friendly";
    objective_icon(var_5, var_6);
    objective_team(var_5, "none");
    self.objidfriendly = var_5;
  } else {
    if(level.teambased || isDefined(self.owner)) {
      var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
      objective_add(var_5, "invisible", (0, 0, 0));
      objective_position(var_5, self.origin);
      objective_state(var_5, "active");
      var_6 = "compass_objpoint_ammo_friendly";

      if(var_0 == "trap") {
        var_6 = "compass_objpoint_trap_friendly";
      }

      objective_icon(var_5, var_6);

      if(!level.teambased && isDefined(self.owner)) {
        objective_playerteam(var_5, self.owner getentitynumber());
      } else {
        objective_team(var_5, self.team);
      }

      self.objidfriendly = var_5;
    }

    if(!(isDefined(level.ishorde) && level.ishorde)) {
      if(!isDefined(self.owner) || !(isDefined(self.modulehide) && self.modulehide)) {
        var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add(var_5, "invisible", (0, 0, 0));
        objective_position(var_5, self.origin);
        objective_state(var_5, "active");
        objective_icon(var_5, "compass_objpoint_ammo_enemy");

        if(!level.teambased && isDefined(self.owner)) {
          objective_playerenemyteam(var_5, self.owner getentitynumber());
        } else {
          objective_team(var_5, level.otherteam[self.team]);
        }

        self.objidenemy = var_5;
      }
    }
  }

  if(self.team == "any") {
    foreach(var_8 in level.teamnamelist) {
      if(isDefined(var_1) && isarray(var_1)) {
        setheadicon_multiple(var_8, var_1);
        continue;
      }

      maps\mp\_entityheadicons::setheadicon(var_8, var_1, (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
    }
  } else if(var_0 == "trap") {
    thread crateuseteamupdater(maps\mp\_utility::getotherteam(self.team));
  } else {
    thread crateuseteamupdater();
    var_10 = getstreakforcrate(self.droptype, self.cratetype);

    if(issubstr(var_10, "juggernaut")) {
      foreach(var_3 in level.players) {
        if(var_3 maps\mp\_utility::isjuggernaut()) {
          thread crateusepostjuggernautupdater(var_3);
        }
      }
    }

    if(level.teambased) {
      if(isDefined(var_1) && isarray(var_1)) {
        setheadicon_multiple(self.team, var_1);
      } else {
        maps\mp\_entityheadicons::setheadicon(self.team, var_1, (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
      }
    } else if(isDefined(self.owner)) {
      if(isDefined(var_1) && isarray(var_1)) {
        setheadicon_multiple(self.owner, var_1);
      } else {
        maps\mp\_entityheadicons::setheadicon(self.owner, var_1, (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
      }
    }
  }

  thread crateusejuggernautupdater();
}

setheadicon_multiple(var_0, var_1) {
  var_2 = 10;
  var_3 = 0;
  self.iconents = [];

  foreach(var_5 in var_1) {
    self.iconents[var_5] = common_scripts\utility::spawn_tag_origin();
    self.iconents[var_5] maps\mp\_entityheadicons::setheadicon(var_0, var_5, (0, 0, 55 + var_3 * var_2), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
    var_3++;
  }
}

setusablebyteam(var_0) {
  var_1 = getstreakforcrate(self.droptype, self.cratetype);

  foreach(var_3 in level.players) {
    if(issubstr(var_1, "juggernaut") && var_3 maps\mp\_utility::isjuggernaut()) {
      self disableplayeruse(var_3);
      continue;
    }

    if(!level.teambased && self.mode == "trap") {
      if(isDefined(self.owner) && var_3 == self.owner) {
        self disableplayeruse(var_3);
      } else {
        self enableplayeruse(var_3);
      }

      continue;
    }

    if(!isDefined(var_0) || var_0 == var_3.team) {
      self enableplayeruse(var_3);
      continue;
    }

    self disableplayeruse(var_3);
  }
}

physicswaiter(var_0, var_1) {
  self waittill("physics_finished");
  self.droppingtoground = 0;
  self thread[[level.cratetypes[var_0][var_1].func]](var_0);
  level thread droptimeout(self, self.owner, var_1);
  var_2 = getEntArray("trigger_hurt", "classname");

  foreach(var_4 in var_2) {
    if(self.friendlymodel istouching(var_4)) {
      deletecrate();
      return;
    }
  }

  if(isDefined(self.owner) && abs(self.origin[2] - self.owner.origin[2]) > 4000) {
    deletecrate();
    return;
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    self disconnectpaths();
  } else if(isDefined(level.ishorde) && level.ishorde) {
    self disconnectpaths();
  }

  var_6 = spawnStruct();
  var_6.deathoverridecallback = ::movingplatformdeathfunc;
  var_6.touchingplatformvalid = ::movingplatformtouchvalid;
  thread maps\mp\_movers::handle_moving_platforms(var_6);
}

movingplatformdeathfunc(var_0) {
  deletecrate(1, 1);
}

movingplatformtouchvalid(var_0) {
  return carepackageandcarepackagevalid(var_0) && carepackageandgoliathvalid(var_0) && carepackageandplatformvalid(var_0);
}

carepackageandgoliathvalid(var_0) {
  return !isDefined(self.targetname) || !isDefined(var_0.cratetype) || self.targetname != "care_package" || var_0.cratetype != "juggernaut";
}

carepackageandcarepackagevalid(var_0) {
  return !isDefined(self.targetname) || !isDefined(var_0.targetname) || self.targetname != "care_package" || var_0.targetname != "care_package";
}

carepackageandplatformvalid(var_0) {
  return !isDefined(self.targetname) || !isDefined(var_0.carepackagetouchvalid) || self.targetname != "care_package" || !var_0.carepackagetouchvalid;
}

droptimeout(var_0, var_1, var_2) {
  if(isDefined(level.nocratetimeout) && level.nocratetimeout) {
    return;
  }
  level endon("game_ended");
  var_0 endon("death");

  if(var_0.droptype == "nuke_drop") {
    return;
  }
  var_3 = 90.0;

  if(var_2 == "supply") {
    var_3 = 20.0;
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_3);

  while(var_0.curprogress != 0) {
    wait 1;
  }

  var_0 deletecrate(1, 1);
}

crateothercapturethink(var_0) {
  self endon("captured");
  var_1 = self;

  if(isDefined(self.otherstringent)) {
    var_1 = self.otherstringent;
  }

  while(isDefined(self)) {
    var_1 waittill("trigger", var_2);

    if(isDefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    if(var_2 isjumping() || isDefined(var_2.exo_hover_on) && var_2.exo_hover_on) {
      continue;
    }
    if(!var_2 isonground() && !waitplayerstuckoncarepackagereturn(var_2)) {
      continue;
    }
    if(!validateopenconditions(var_2)) {
      continue;
    }
    var_2.iscapturingcrate = 1;
    var_3 = createuseent();
    var_4 = 0;

    if(self.cratetype == "booby_trap") {
      var_4 = var_3 useholdthink(var_2, 500, var_0);
    } else {
      var_4 = var_3 useholdthink(var_2, undefined, var_0);
    }

    if(isDefined(var_3)) {
      var_3 delete();
    }

    if(!var_4) {
      if(isDefined(var_2)) {
        var_2.iscapturingcrate = 0;
      }

      continue;
    }

    var_2.iscapturingcrate = 0;

    if(isDefined(level.ishorde) && level.ishorde) {
      if(self.cratetype == "juggernaut" && !(isDefined(var_2.laststand) && var_2.laststand)) {
        var_2 setdemigod(1);
      }

      if(isDefined(var_2.laststand) && var_2.laststand) {
        continue;
      }
    }

    self notify("captured", var_2);
  }
}

crateownercapturethink(var_0) {
  self endon("captured");

  if(!isDefined(self.owner)) {
    return;
  }
  self.owner endon("disconnect");
  var_1 = self;

  if(isDefined(self.ownerstringent)) {
    var_1 = self.ownerstringent;
  }

  var_2 = 500;

  if(isDefined(self.modulepickup) && self.modulepickup) {
    var_2 = 100;
  }

  while(isDefined(self)) {
    var_1 waittill("trigger", var_3);

    if(isDefined(self.owner) && var_3 != self.owner) {
      continue;
    }
    if(var_3 isjumping() || isDefined(var_3.exo_hover_on) && var_3.exo_hover_on) {
      continue;
    }
    if(!var_3 isonground() && !waitplayerstuckoncarepackagereturn(var_3)) {
      continue;
    }
    if(!validateopenconditions(var_3)) {
      continue;
    }
    var_3.iscapturingcrate = 1;

    if(!useholdthink(var_3, var_2, var_0)) {
      var_3.iscapturingcrate = 0;
      continue;
    }

    var_3.iscapturingcrate = 0;

    if(isDefined(level.ishorde) && level.ishorde) {
      if(self.cratetype == "juggernaut" && !(isDefined(var_3.laststand) && var_3.laststand)) {
        var_3 setdemigod(1);
      }

      if(isDefined(var_3.laststand) && var_3.laststand) {
        continue;
      }
    }

    self notify("captured", var_3);
  }
}

waitplayerstuckoncarepackagereturn(var_0) {
  if(var_0 isonground()) {
    return 0;
  }

  var_1 = 200;
  var_2 = var_0.origin;
  var_3 = gettime();

  while(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0) && !var_0 isonground() && var_2 == var_0.origin && var_0 useButtonPressed()) {
    var_4 = gettime() - var_3;

    if(var_4 >= var_1) {
      return 1;
    }

    waitframe();
  }

  return 0;
}

validateopenconditions(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();

  if(issubstr(var_1, "turrethead")) {
    return 1;
  }

  if(!var_0 maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon()) {
    return 0;
  }

  if(isDefined(var_0.changingweapon) && !var_0 maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon()) {
    return 0;
  }

  return 1;
}

killstreakcratethink(var_0) {
  self endon("death");
  var_1 = getstreakforcrate(var_0, self.cratetype);
  var_2 = getmodulesforcrate(var_0, self.cratetype);
  var_3 = isDefined(self.owner) && (self.owner maps\mp\_utility::_hasperk("specialty_highroller") || isDefined(self.moduleroll) && self.moduleroll);
  var_4 = undefined;

  if(var_3) {
    var_4 = &"MP_PACKAGE_REROLL";
  }

  var_5 = undefined;

  if(isDefined(game["strings"][var_0 + self.cratetype + "_hint"])) {
    var_5 = game["strings"][var_0 + self.cratetype + "_hint"];
  } else {
    var_5 = &"PLATFORM_GET_KILLSTREAK";
  }

  cratesetuphintstrings(var_5, var_4);
  cratesetupforuse("all", maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_1, var_2));

  if(isDefined(self.owner)) {
    thread crateothercapturethink();
  }

  thread crateownercapturethink();

  if(var_3) {
    thread crateownerdoubletapthink();
  }

  if(self.istrap) {
    cratetrapsetupkillcam();
  }

  for(;;) {
    self waittill("captured", var_6);
    var_1 = getstreakforcrate(var_0, self.cratetype);
    var_2 = getmodulesforcrate(var_0, self.cratetype);

    if(isDefined(self.owner) && var_6 != self.owner) {
      if(!level.teambased || var_6.team != self.team) {
        if(self.istrap) {
          var_6 thread detonatetrap(self, self.owner);
          return;
        } else {
          var_6 thread maps\mp\_events::hijackerevent(self.owner);
        }
      } else {
        self.owner thread maps\mp\_events::sharedevent();
      }
    }

    var_6 playlocalsound("orbital_pkg_use");
    var_7 = var_6 maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex(var_1, 0);
    var_6 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_1, undefined, undefined, var_2, var_7);
    var_6 thread maps\mp\killstreaks\_killstreaks::givekillstreak(var_1, 0, 0, self.owner, var_2);

    if(isDefined(level.mapkillstreak) && level.mapkillstreak == self.cratetype) {
      var_6 thread maps\mp\_events::mapkillstreakevent();
    }

    var_8 = 1;
    var_9 = var_6 maps\mp\_utility::_hasperk("specialty_highroller") && (!level.teambased || var_6.team != self.team);
    var_10 = isDefined(self.moduletrap) && self.moduletrap;
    var_11 = var_10 && (self.owner == var_6 || level.teambased && var_6.team == self.team);

    if(var_9 || var_11) {
      var_12 = var_6 createairdropcrate(var_6, "booby_trap", "booby_trap", self.origin, self.angles);

      if(isDefined(var_12.enemymodel)) {
        var_12.enemymodel thread maps\mp\killstreaks\_orbital_carepackage::orbitalanimate(1);
      }

      var_12 thread boobytrapcratethink(self);
      level thread droptimeout(var_12, var_12.owner, var_12.cratetype);
      var_8 = 0;

      if(isDefined(var_12.friendlymodel)) {
        var_12.friendlymodel solid();
      }

      if(isDefined(var_12.enemymodel)) {
        var_12.enemymodel solid();
      }
    }

    deletecrate(var_8);
  }
}

detonatetrap(var_0, var_1) {
  var_0 endon("death");
  var_2 = var_0.origin + (0, 0, 50);

  if(level.teambased) {
    var_0 maps\mp\_entityheadicons::setheadicon(self.team, "specialty_trap_crate", (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
  } else {
    var_0 maps\mp\_entityheadicons::setheadicon(self, "specialty_trap_crate", (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
  }

  thread common_scripts\utility::play_sound_in_space("orbital_pkg_trap_armed", var_2);
  wait 1.0;
  var_3 = var_2 + (0, 0, 1) - var_2;
  playFX(common_scripts\utility::getfx("airdrop_crate_trap_explode"), var_2, var_3);
  thread common_scripts\utility::play_sound_in_space("orbital_pkg_trap_detonate", var_2);

  if(isDefined(var_0.friendlymodel)) {
    var_0.friendlymodel notsolid();
  }

  if(isDefined(var_0.enemymodel)) {
    var_0.enemymodel notsolid();
  }

  if(isDefined(var_1)) {
    var_0.trapkillcament radiusdamage(var_2, 400, 300, 50, var_1, "MOD_EXPLOSIVE", "airdrop_trap_explosive_mp");
  } else {
    var_0.trapkillcament radiusdamage(var_2, 400, 300, 50, undefined, "MOD_EXPLOSIVE", "airdrop_trap_explosive_mp");
  }

  var_0 deletecrate();
}

deletecrate(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(self.objidfriendly)) {
    maps\mp\_utility::_objective_delete(self.objidfriendly);
  }

  if(isDefined(self.objidenemy)) {
    maps\mp\_utility::_objective_delete(self.objidenemy);
  }

  if(isDefined(self.trapkillcament)) {
    self.trapkillcament delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.ownerstringent)) {
    self.ownerstringent delete();
  }

  if(isDefined(self.otherstringent)) {
    self.otherstringent delete();
  }

  if(isDefined(self.droptype)) {
    if(var_0) {
      playFX(common_scripts\utility::getfx("ocp_death"), self.origin);
    }

    if(var_1) {
      playsoundatpos(self.origin, "orbital_pkg_self_destruct");
    }
  }

  if(isDefined(self.iconents)) {
    foreach(var_3 in self.iconents) {
      var_3 delete();
    }
  }

  self delete();
}

useholdthink(var_0, var_1, var_2) {
  if(isPlayer(var_0)) {
    var_0 playerlinkto(self);
  } else {
    var_0 linkto(self);
  }

  var_0 playerlinkedoffsetenable();

  if(!var_0 maps\mp\_utility::isjuggernaut()) {
    var_0 common_scripts\utility::_disableweapon();
  }

  thread useholdthinkplayerreset(var_0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(var_1)) {
    if(var_0 maps\mp\_utility::_hasperk("specialty_unwrapper") && isDefined(var_0.specialty_unwrapper_care_bonus)) {
      var_1 = var_1 * var_0.specialty_unwrapper_care_bonus;
    }

    if(isDefined(level.podcapturetimemodifier)) {
      var_1 = var_1 * level.podcapturetimemodifier;
    }

    self.usetime = var_1;
  } else if(var_0 maps\mp\_utility::_hasperk("specialty_unwrapper") && isDefined(var_0.specialty_unwrapper_care_bonus)) {
    self.usetime = 3000 * var_0.specialty_unwrapper_care_bonus;
  } else {
    self.usetime = 3000;
  }

  if(isPlayer(var_0)) {
    var_0 thread personalusebar(self, var_2);
  }

  var_3 = useholdthinkloop(var_0);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  self notify("useHoldThinkLoopDone");
  self.inuse = 0;
  self.curprogress = 0;
  return var_3;
}

useholdthinkplayerreset(var_0) {
  var_0 endon("death");
  common_scripts\utility::waittill_any("death", "captured", "useHoldThinkLoopDone");

  if(isalive(var_0)) {
    if(!var_0 maps\mp\_utility::isjuggernaut()) {
      var_0 common_scripts\utility::_enableweapon();
    }

    if(var_0 islinked()) {
      var_0 unlink();
    }
  }
}

personalusebar(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(var_1)) {
    iprintlnbold("Fixme @agersant " + var_1);
  }

  self setclientomnvar("ui_use_bar_text", 1);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_2 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      if(var_0.userate > 0) {
        var_3 = gettime();
        var_4 = var_0.curprogress / var_0.usetime;
        var_5 = var_3 + (1 - var_4) * (var_0.usetime / var_0.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_5));
      }

      var_2 = var_0.userate;
    }

    wait 0.05;
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

ishordelaststand(var_0) {
  return isDefined(level.ishorde) && level.ishorde && isDefined(var_0.laststand) && var_0.laststand;
}

useholdthinkloop(var_0) {
  var_0 endon("stop_useHoldThinkLoop");

  while(!level.gameended && isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && !ishordelaststand(var_0) && var_0 useButtonPressed() && self.curprogress < self.usetime) {
    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    if(self.curprogress >= self.usetime) {
      return maps\mp\_utility::isreallyalive(var_0);
    }

    wait 0.05;
  }

  return 0;
}

isairdropmarker(var_0) {
  switch (var_0) {
    case "airdrop_mp":
    case "airdrop_marker_mp":
      return 1;
    default:
      return 0;
  }
}

createuseent() {
  var_0 = spawn("script_origin", self.origin);
  var_0.curprogress = 0;
  var_0.usetime = 0;
  var_0.userate = 3000;
  var_0.inuse = 0;
  var_0 thread deleteuseent(self);
  return var_0;
}

deleteuseent(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}

crateownerdoubletapthink() {
  self.packageholdtimer = 0;
  self.packagesingletapped = 0;

  while(!level.gameended && isDefined(self)) {
    if(maps\mp\_utility::isreallyalive(self.owner) && distancesquared(self.origin, self.owner.origin) < 10000) {
      if(self.owner useButtonPressed()) {
        self.packageholdtimer++;
      } else if(self.packageholdtimer > 0) {
        if(self.packageholdtimer < 5) {
          if(self.packagesingletapped == 1) {
            self notify("package_double_tap");
            var_0 = self.cratetype;

            for(var_1 = 0; self.cratetype == var_0 && var_1 < 100; self.cratetype = getrandomcratetype(self.droptype)) {
              var_1++;
            }

            var_2 = getstreakforcrate(self.droptype, self.cratetype);
            var_3 = getmodulesforcrate(self.droptype, self.cratetype);
            var_4 = game["strings"][self.droptype + self.cratetype + "_hint"];

            if(!isDefined(var_4)) {
              var_4 = &"PLATFORM_GET_KILLSTREAK";
            }

            if(isDefined(self.ownerstringent)) {
              self.ownerstringent sethintstring(var_4);
              self.otherstringent sethintstring(var_4);
              self.ownerstringent setsecondaryhintstring("");
            } else {
              self sethintstring(var_4);
              self setsecondaryhintstring("");
            }

            if(level.teambased) {
              maps\mp\_entityheadicons::setheadicon(self.team, maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_2, var_3), (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
            } else if(isDefined(self.owner)) {
              maps\mp\_entityheadicons::setheadicon(self.owner, maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_2, var_3), (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
            }

            self.owner playlocalsound("orbital_pkg_reroll");
            return 1;
          } else {
            self.packagesingletapped = 1;
            thread tappackagethink();
          }
        }

        self.packageholdtimer = 0;
      }
    }

    wait 0.05;
  }
}

tappackagethink() {
  level endon("game_ended");
  self endon("death");
  self endon("package_double_tap");
  wait 0.2;
  self.packagesingletapped = 0;
}

boobytrapcratethink(var_0) {
  self endon("death");
  var_1 = getstreakforcrate(var_0.droptype, var_0.cratetype);
  var_2 = getmodulesforcrate(var_0.droptype, var_0.cratetype);
  var_3 = maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_1, var_2);
  var_4 = undefined;

  if(isDefined(game["strings"][var_0.droptype + var_0.cratetype + "_hint"])) {
    var_4 = game["strings"][var_0.droptype + var_0.cratetype + "_hint"];
  } else {
    var_4 = &"PLATFORM_GET_KILLSTREAK";
  }

  cratesetuphintstrings(var_4);
  cratesetupforuse("trap", var_3);
  cratetrapsetupkillcam();
  thread crateothercapturethink(var_0);

  for(;;) {
    self waittill("captured", var_5);
    var_5 thread detonatetrap(self, self.owner);
  }
}

cratetrapsetupkillcam(var_0) {
  var_1 = bulletTrace(self.origin, self.origin + (0, 0, 90), 0, self);
  self.trapkillcament = spawn("script_model", var_1["position"]);
  self.trapkillcament setcontents(0);
  self.trapkillcament setscriptmoverkillcam("large explosive");
}

tryusereinforcementcommon(var_0, var_1, var_2) {
  return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(var_0, "airdrop_reinforcement_common", var_2);
}

tryusereinforcementuncommon(var_0, var_1, var_2) {
  return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(var_0, "airdrop_reinforcement_uncommon", var_2);
}

tryusereinforcementrare(var_0, var_1, var_2) {
  return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(var_0, "airdrop_reinforcement_rare", var_2);
}

tryusereinforcementpractice(var_0, var_1, var_2) {
  return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(var_0, "airdrop_reinforcement_practice", var_2);
}

reinforcementcratekillstreakthink(var_0) {
  killstreakcratethink(var_0);
}

reinforcementcratespecialtythink(var_0) {
  self endon("death");
  var_1 = getperkforcrate(var_0, self.cratetype);
  var_2 = undefined;

  if(var_0 == "airdrop_reinforcement_rare") {
    var_2 = getsecondaryperkforcrate(var_0);
  }

  var_3 = undefined;

  if(isDefined(var_2)) {
    var_4 = game["strings"][var_0 + self.cratetype + "_hint"];
    var_5 = getsecondaryperkhintfromperkref(var_2);

    if(isDefined(var_4) && isDefined(var_5)) {
      self setreinforcementhintstrings(var_4, var_5);
    } else {
      cratesetuphintstrings(&"MP_PERK_PICKUP_GENERIC_MULTIPLE");
    }

    var_3 = [];
    var_3[0] = getperkcrateicon(var_1);

    if(!isDefined(var_3[0])) {
      var_3[0] = "";
    }

    var_3[1] = getperkcrateicon(var_2);

    if(!isDefined(var_3[1])) {
      var_3[1] = "";
    }
  } else {
    var_4 = game["strings"][var_0 + self.cratetype + "_hint"];

    if(isDefined(var_4)) {
      self setreinforcementhintstrings(var_4);
    } else {
      cratesetuphintstrings(&"MP_PERK_PICKUP_GENERIC");
    }

    var_3 = getperkcrateicon(var_1);

    if(!isDefined(var_3)) {
      var_3 = "";
    }
  }

  cratesetupforuse("all", var_3);

  if(isDefined(self.owner)) {
    thread crateothercapturethink();
  }

  thread crateownercapturethink();

  for(;;) {
    self waittill("captured", var_6);

    if(isDefined(self.owner) && var_6 != self.owner) {
      if(!level.teambased || var_6.team != self.team) {
        var_6 thread maps\mp\_events::hijackerevent(self.owner);
      } else {
        self.owner thread maps\mp\_events::sharedevent();
      }
    }

    var_6 playlocalsound("orbital_pkg_use");
    var_6 apply_reinforcement_perk(var_1);
    var_7 = int(tablelookuprownum("mp/perktable.csv", 1, var_1));
    var_6 setclientomnvar("ui_reinforcement_active_perk_1", var_7);

    if(isDefined(var_2)) {
      var_6 apply_reinforcement_perk(var_2);
      var_7 = int(tablelookuprownum("mp/perktable.csv", 1, var_2));
      var_6 setclientomnvar("ui_reinforcement_active_perk_2", var_7);
    } else {
      var_6 setclientomnvar("ui_reinforcement_active_perk_2", -1);
    }

    deletecrate(1);
  }
}

getperkforcrate(var_0, var_1) {
  if(isDefined(level.cratetypes[var_0][var_1].streakref)) {
    return level.cratetypes[var_0][var_1].streakref;
  }

  return var_1;
}

getsecondaryperkforcrate(var_0) {
  if(isDefined(level.cratetypes[var_0]) && isDefined(level.cratetypes[var_0][self.cratetype])) {
    var_1 = [];

    foreach(var_3 in level.cratetypes[var_0]) {
      if(!issubstr(var_3.streakref, "specialty_")) {
        var_1[var_1.size] = var_3.type;
      }
    }

    var_1[var_1.size] = self.cratetype;
    var_5 = getrandomcratetype(var_0, var_1);

    if(isDefined(var_5) && isDefined(level.cratetypes[var_0][var_5].streakref)) {
      return level.cratetypes[var_0][var_5].streakref;
    }
  }

  return undefined;
}

getsecondaryperkhintfromperkref(var_0) {
  var_1 = undefined;

  if(isDefined(level.secondaryreinforcementhinttext[var_0])) {
    var_1 = level.secondaryreinforcementhinttext[var_0];
  }

  return var_1;
}

getperkcrateicon(var_0) {
  var_1 = "mp/perktable.csv";
  var_2 = 1;
  var_3 = 11;
  return tablelookup(var_1, var_2, var_0, var_3);
}

apply_reinforcement_perk(var_0) {
  self.reinforcementperks[var_0] = 1;

  if(var_0 == "specialty_extended_battery") {
    maps\mp\_utility::giveperk("specialty_extended_battery", 0);
    maps\mp\_utility::giveperk("specialty_exo_slamboots", 0);
    return;
  }

  if(var_0 == "specialty_class_lowprofile") {
    maps\mp\_utility::giveperk("specialty_radarimmune", 0);
    maps\mp\_utility::giveperk("specialty_exoping_immune", 0);
    return;
  }

  if(var_0 == "specialty_class_flakjacket") {
    maps\mp\_utility::giveperk("specialty_hard_shell", 0);
    maps\mp\_utility::giveperk("specialty_throwback", 0);
    maps\mp\_utility::giveperk("_specialty_blastshield", 0);
    self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale", 45) / 100;

    if(isDefined(level.hardcoremode) && level.hardcoremode) {
      self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 90) / 100;
    }

    return;
  }

  if(var_0 == "specialty_class_lightweight") {
    maps\mp\_utility::giveperk("specialty_lightweight", 0);
    return;
  }

  if(var_0 == "specialty_class_dangerclose") {
    maps\mp\_utility::giveperk("specialty_explosivedamage", 0);
    return;
  }

  if(var_0 == "specialty_class_blindeye") {
    maps\mp\_utility::giveperk("specialty_blindeye", 0);
    maps\mp\_utility::giveperk("specialty_plainsight", 0);
    return;
  }

  if(var_0 == "specialty_class_coldblooded") {
    maps\mp\_utility::giveperk("specialty_coldblooded", 0);
    maps\mp\_utility::giveperk("specialty_spygame", 0);
    maps\mp\_utility::giveperk("specialty_heartbreaker", 0);
    return;
  }

  if(var_0 == "specialty_class_peripherals") {
    maps\mp\_utility::giveperk("specialty_moreminimap", 0);
    maps\mp\_utility::giveperk("specialty_silentkill", 0);
    return;
  }

  if(var_0 == "specialty_class_fasthands") {
    maps\mp\_utility::giveperk("specialty_quickswap", 0);
    maps\mp\_utility::giveperk("specialty_fastoffhand", 0);
    maps\mp\_utility::giveperk("specialty_sprintreload", 0);
    return;
  }

  if(var_0 == "specialty_class_dexterity") {
    maps\mp\_utility::giveperk("specialty_sprintfire", 0);
    return;
  }

  if(var_0 == "specialty_class_hardwired") {
    maps\mp\_utility::giveperk("specialty_empimmune", 0);
    maps\mp\_utility::giveperk("specialty_stun_resistance", 0);
    self.stunscaler = 0.1;
    return;
  }

  if(var_0 == "specialty_class_toughness") {
    self setviewkickscale(0.2);
    return;
  }

  if(var_0 == "specialty_class_scavenger") {
    self.ammopickup_scalar = 0.2;
    maps\mp\_utility::giveperk("specialty_scavenger", 0);
    maps\mp\_utility::giveperk("specialty_bulletresupply", 0);
    maps\mp\_utility::giveperk("specialty_extraammo", 0);
    return;
  }

  if(var_0 == "specialty_class_hardline") {
    maps\mp\_utility::giveperk("specialty_hardline", 0);
    maps\mp\killstreaks\_killstreaks::updatestreakcount();
    return;
  }
}