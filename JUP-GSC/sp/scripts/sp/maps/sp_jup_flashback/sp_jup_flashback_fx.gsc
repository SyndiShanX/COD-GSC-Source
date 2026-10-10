/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_fx.gsc
***********************************************************************/

#namespace sp_jup_flashback_fx;

function main() {
  level._effect["vfx_flashback_intro_player_veh_lights_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_intro_player_veh_lights_01.vfx");
  level._effect["vfx_flashback_ambulance_lights_mak"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_lights_mak.vfx");
  level._effect["vfx_flashback_tire_splash"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_tire_splash.vfx");
  level._effect["vfx_flashback_dashboard_lights"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_dashboard_lights.vfx");
  level._effect["vfx_hatch_small_2015_lights_cheap_01"] = loadfx("vfx/jup/veh/lights/vfx_hatch_small_2015_lights_cheap_01.vfx");
  level._effect["vfx_sedan_2009_lights_cheap_01"] = loadfx("vfx/jup/veh/lights/vfx_sedan_2009_lights_cheap_01.vfx");
  level._effect["vfx_ralfa_lights_cheap_01"] = loadfx("vfx/jup/veh/lights/vfx_ralfa_lights_cheap_01.vfx");
  level._effect["vfx_sedan_hatchback_1985_lights_cheap_01"] = loadfx("vfx/jup/veh/lights/vfx_sedan_hatchback_1985_lights_cheap_01.vfx");
  level._effect["vfx_flashback_heli_vector_field_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_heli_vector_field_01.vfx");
  level._effect["vfx_ralfa_lights"] = loadfx("vfx/jup/veh/lights/vfx_ralfa_lights.vfx");
  level._effect["vfx_sedan_hatchback_1985_lights"] = loadfx("vfx/jup/veh/lights/vfx_sedan_hatchback_1985_lights.vfx");
  level._effect["vfx_sedan_2009_lights"] = loadfx("vfx/jup/veh/lights/vfx_sedan_2009_lights.vfx");
  level._effect["vfx_flashback_ambulance_imp_sparks_sml_1"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_imp_sparks_sml_1.vfx");
  level._effect["vfx_flashback_flashlight_midtro"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_flashlight_midtro.vfx");
  level._effect["vfx_flashback_police_siren_lights_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_police_siren_lights_01.vfx");
  level._effect["vfx_flashback_ambulance_lights_intro"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_lights_intro.vfx");
  level._effect["vfx_flashlight_npc_perf"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf.vfx");
  level._effect["vfx_flashback_car_headlights_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_car_headlights_01.vfx");
  level._effect["vfx_flashback_exhaust_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_exhaust_01.vfx");
  level._effect["vfx_flashback_ambulance_imp_dust"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_imp_dust.vfx");
  level._effect["vfx_flashback_ambulance_damage_smoke_hood"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_damage_smoke_hood.vfx");
  level._effect["vfx_flashback_ambulance_imp_sparks_1"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_imp_sparks_1.vfx");
  level._effect["vfx_flashback_ambulance_sil_light"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_sil_light.vfx");
  level._effect["vfx_flashback_ambulance_blood"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_blood.vfx");
  level._effect["vfx_convoy_wt_smoke_plume_lrg_01"] = loadfx("vfx/iw9/level/convoy/vfx_convoy_wt_smoke_plume_lrg_01.vfx");
  level._effect["vfx_flashback_ambulance_lights"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_ambulance_lights.vfx");
  level._effect["vfx_flashback_crowd_run_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_crowd_run_01.vfx");
  level._effect["vfx_flashback_crowd_run_02"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_crowd_run_02.vfx");
  level._effect["vfx_flashback_crowd_run_03"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_crowd_run_03.vfx");
  level._effect["vfx_flashback_crowd_run_grass_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_crowd_run_grass_01.vfx");
  level._effect["vfx_flashback_crowd_run_stairs_01"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_crowd_run_stairs_01.vfx");
  level._effect["vfx_flashback_crowd_run_stairs_02"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_crowd_run_stairs_02.vfx");
  level._effect["vfx_flashback_flashlight_player"] = loadfx("vfx/jup/level/sp_jup_flashback/vfx_flashback_flashlight_player.vfx");
  level._effect["vfx_flashlight_player"] = loadfx("vfx/iw8/level/proxywar/vfx_flashlight_player.vfx");
  level._effect["vfx_flashlight_player_hero"] = loadfx("vfx/iw9/cp/vfx_flashlight_player_hero.vfx");
  level._effect["vfx_imp_flesh_lrg"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_lrg.vfx");
  level._effect["vfx_imp_flesh_lrg_a"] = loadfx("vfx/iw9/core/weapons/impacts/vfx_imp_flesh_lrg_a.vfx");
  level._effect["vfx_nw_lsrbldg_ghost_exec"] = loadfx("vfx/iw9/level/nightwar/vfx_nw_lsrbldg_ghost_exec.vfx");
  level._effect["vfx_vehicle_glass_shatter"] = loadfx("vfx/code/glass/glass_shatter_32x32.vfx");
  level._effect["vfx_wounded_npc_flashlight"] = loadfx("vfx/iw9/level/wounded/vfx_wounded_npc_flashlight.vfx");
  level._effect["vfx_player_flashlight"] = loadfx("vfx/iw9/level/wounded/vfx_flashlight_player.vfx");

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {}
}