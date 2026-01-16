/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\karma_2_fx.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\karma_2_fx;
#include clientscripts\_fx;

precache_util_fx() {
}

precache_scripted_fx() {
  level._effect["blood_cloud_water"] = loadfx("maps/karma/fx_kar_blood_cloud_water");
}

precache_createfx_fx() {
  level._effect["fx_kar_shrimp_crowd_escape"] = loadfx("maps/karma/fx_kar_shrimp_crowd_escape");
  level._effect["fx_kar_exp_store_front"] = loadfx("explosions/fx_kar_exp_store_front");
  level._effect["fx_kar_smk_fire_store_front"] = loadfx("smoke/fx_kar_smk_fire_store_front");
  level._effect["fx_kar_boat_wake1"] = loadfx("maps/karma/fx_kar_boat_wake2");
  level._effect["fx_kar_exp_corner_store"] = loadfx("explosions/fx_kar_exp_corner_store");
  level._effect["fx_kar_concrete_dust_impact_corner_store"] = loadfx("dirt/fx_kar_concrete_dust_impact_corner_store");
  level._effect["fx_kar_exp_aquarium_pillar"] = loadfx("maps/karma/fx_kar_aquarium_pillar_exp");
  level._effect["fx_kar_exp_aquarium_dust"] = loadfx("maps/karma/fx_kar_aquarium_exp_dust");
  level._effect["fx_kar_exp_aquarium"] = loadfx("maps/karma/fx_kar_aquarium_exp");
  level._effect["fx_kar_aquarium_spill_xlg"] = loadfx("water/fx_kar_aquarium_spill_xlg");
  level._effect["fx_kar_aquarium_spill_lg"] = loadfx("water/fx_kar_aquarium_spill_lg");
  level._effect["fx_kar_splash_x100_bright"] = loadfx("maps/karma/fx_kar_splash_x100_bright");
  level._effect["fx_kar_aquarium_pillar_debris"] = loadfx("maps/karma/fx_kar_aquarium_pillar_debris");
  level._effect["fx_kar_aquarium_pillar_debris2"] = loadfx("maps/karma/fx_kar_aquarium_pillar_debris2");
  level._effect["fx_light_c401"] = loadfx("env/light/fx_light_c401");
  level._effect["fx_kar_concrete_pillar_dest"] = loadfx("dirt/fx_kar_concrete_pillar_dest");
  level._effect["fx_kar_concrete_beam_dest"] = loadfx("dirt/fx_kar_concrete_beam_dest");
  level._effect["fx_circlebar_glass_dome_dest"] = loadfx("maps/karma/fx_circlebar_glass_dome_dest");
  level._effect["fx_kar_concrete_dust_impact_circle_bar"] = loadfx("dirt/fx_kar_concrete_dust_impact_circle_bar");
  level._effect["fx_metalstorm_concrete"] = loadfx("impacts/fx_metalstorm_concrete");
  level._effect["fx_kar_spotlight_osprey_int"] = loadfx("light/fx_kar_spotlight_osprey_int");
  level._effect["fx_kar_exp_ship_fail"] = loadfx("explosions/fx_kar_exp_ship_fail");
  level._effect["fx_insects_swarm_lg"] = loadfx("bio/insects/fx_insects_swarm_lg");
  level._effect["fx_waterfall_splash1"] = loadfx("maps/karma/fx_kar_waterfall_splash1");
  level._effect["fx_waterfall_splash2"] = loadfx("maps/karma/fx_kar_waterfall_splash2");
  level._effect["fx_fog_drift_slow"] = loadfx("maps/karma/fx_kar_mist1");
  level._effect["fx_fog_drift_slow2"] = loadfx("maps/karma/fx_kar_mist2");
  level._effect["fx_smoke_room"] = loadfx("maps/karma/fx_kar_smoke_room");
  level._effect["fx_la2_light_beacon_red"] = loadfx("light/fx_la2_light_beacon_red");
  level._effect["fx_dust_crumble_sm_runner"] = loadfx("dirt/fx_dust_crumble_sm_runner");
  level._effect["fx_dust_crumble_md_runner"] = loadfx("dirt/fx_dust_crumble_md_runner");
  level._effect["fx_dust_crumble_lg_runner"] = loadfx("dirt/fx_dust_crumble_lg_runner");
  level._effect["fx_kar_light_pole1"] = loadfx("maps/karma/fx_kar_light_pole1");
  level._effect["fx_kar_water_fountain"] = loadfx("maps/karma/fx_kar_water_fountain");
  level._effect["fx_kar_water_fountain_loop"] = loadfx("maps/karma/fx_kar_water_fountain_loop");
  level._effect["fx_kar_water_fountain_loop_new"] = loadfx("maps/karma/fx_kar_water_fountain_loop_new");
  level._effect["fx_kar_mall_fire_light"] = loadfx("maps/karma/fx_kar_mall_fire_light");
  level._effect["fx_kar_gray1"] = loadfx("maps/karma/fx_kar_gray1");
  level._effect["fx_kar_gray2"] = loadfx("maps/karma/fx_kar_gray2");
  level._effect["fx_lf_karma_light_plain2"] = loadfx("lens_flares/fx_lf_karma_light_plain2");
  level._effect["fx_kar_vista_lights"] = loadfx("maps/karma/fx_kar_vista_lights");
  level._effect["fx_kar_smokewind"] = loadfx("maps/karma/fx_kar_smokewind");
  level._effect["fx_kar_ash1"] = loadfx("maps/karma/fx_kar_ash1");
  level._effect["fx_kar_pagoda_smoke1"] = loadfx("maps/karma/fx_kar_pagoda_smoke1");
  level._effect["fx_kar_tent_wind"] = loadfx("maps/karma/fx_kar_tent_wind");
  level._effect["fx_elec_spark"] = loadfx("electrical/fx_la2_elec_spark_runner_sm");
  level._effect["fx_kar_corner_smoke_rubble"] = loadfx("maps/karma/fx_kar_corner_smoke_rubble");
  level._effect["fx_kar_corner_smoke_under"] = loadfx("maps/karma/fx_kar_corner_smoke_under");
  level._effect["fx_kar_corner_smoke_top"] = loadfx("maps/karma/fx_kar_corner_smoke_top");
  level._effect["fx_kar_light_outdoor"] = loadfx("maps/karma/fx_kar_light_outdoor");
  level._effect["fx_kar_fountain_spray"] = loadfx("maps/karma/fx_kar_fountain_spray");
  level._effect["fx_kar_fountain_spray_new"] = loadfx("maps/karma/fx_kar_fountain_spray_new");
  level._effect["fx_kar_water_fountain_new"] = loadfx("maps/karma/fx_kar_water_fountain_new");
  level._effect["fx_kar_fountain_details06"] = loadfx("maps/karma/fx_kar_fountain_details06");
  level._effect["fx_kar_smolder_steam_field"] = loadfx("maps/karma/fx_kar_smolder_steam_field");
  level._effect["fx_kar_bright_light"] = loadfx("maps/karma/fx_kar_bright_light");
  level._effect["fx_elec_burst_shower_sm_int_runner"] = loadfx("electrical/fx_elec_burst_shower_sm_int_runner");
  level._effect["fx_water_fire_sprinkler"] = loadfx("water/fx_water_fire_sprinkler");
  level._effect["fx_water_fire_sprinkler_dribble"] = loadfx("water/fx_water_fire_sprinkler_dribble");
  level._effect["fx_water_fire_sprinkler_dribble_spatter"] = loadfx("water/fx_water_fire_sprinkler_dribble_spatter");
  level._effect["fx_kar_splash_x100"] = loadfx("maps/karma/fx_kar_splash_x100");
  level._effect["fx_fire_wall_md"] = loadfx("maps/karma/fx_kar_fire_wall_md");
  level._effect["fx_fire_xsm"] = loadfx("maps/karma/fx_kar_fire_xsm");
  level._effect["fx_fire_line_xsm"] = loadfx("maps/karma/fx_kar_fire_line_xsm");
  level._effect["fx_fire_line_sm"] = loadfx("maps/karma/fx_kar_fire_line_sm");
  level._effect["fx_fire_line_md"] = loadfx("env/fire/fx_fire_line_md");
  level._effect["fx_fire_sm_smolder"] = loadfx("maps/karma/fx_kar_fire_sm_smolder");
  level._effect["fx_embers_falling_sm"] = loadfx("env/fire/fx_embers_falling_sm");
  level._effect["fx_embers_falling_md"] = loadfx("env/fire/fx_embers_falling_md");
  level._effect["fx_embers_falling_lg"] = loadfx("fire/fx_embers_falling_lg");
  level._effect["fx_fire_dropper"] = loadfx("maps/karma/fx_kar_fire_dropper");
  level._effect["fx_fire_dropper_single"] = loadfx("maps/karma/fx_kar_fire_dropper_single");
  level._effect["fx_smoke_building_med"] = loadfx("maps/karma/fx_kar_smoke_pillar_xlg");
  level._effect["fx_smk_plume_lg_blk_wispy_dist"] = loadfx("smoke/fx_smk_plume_lg_blk_wispy_dist");
  level._effect["fx_smk_smolder_sm_int"] = loadfx("smoke/fx_smk_smolder_sm_int");
  level._effect["fx_smk_smolder_rubble_lg"] = loadfx("maps/karma/fx_kar_smolder_rubble_lg");
  level._effect["fx_smk_smolder_rubble_md"] = loadfx("smoke/fx_smk_smolder_rubble_md_int");
  level._effect["fx_smk_smolder_black_slow"] = loadfx("smoke/fx_smk_smolder_black_slow");
  level._effect["fx_smk_smolder_gray_slow"] = loadfx("smoke/fx_smk_smolder_gray_slow");
  level._effect["fx_smk_smolder_gray_fast"] = loadfx("smoke/fx_smk_smolder_gray_fast");
  level._effect["fx_smk_ceiling_crawl"] = loadfx("smoke/fx_smk_ceiling_crawl");
  level._effect["fx_smk_fire_md_gray_int"] = loadfx("env/smoke/fx_smk_fire_md_gray_int");
  level._effect["fx_kar_smk_fire_stairwell"] = loadfx("smoke/fx_kar_smk_fire_stairwell");
  level._effect["fx_smk_hallway_md"] = loadfx("maps/karma/fx_kar_smk_hallway1");
  level._effect["fx_smk_field_room_md"] = loadfx("maps/karma/fx_kar_smk_field_room1");
  level._effect["fx_smk_door_crack_exit_dark"] = loadfx("smoke/fx_smk_door_crack_exit_dark");
  level._effect["fx_kar_smk_plume1"] = loadfx("maps/karma/fx_kar_smk_plume1");
  level._effect["fx_kar_smolder_steam"] = loadfx("maps/karma/fx_kar_smolder_steam");
  level._effect["fx_kar_concrete_crumble"] = loadfx("maps/karma/fx_kar_concrete_crumble");
}

main() {
  clientscripts\createfx\karma_2_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_util_fx();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}