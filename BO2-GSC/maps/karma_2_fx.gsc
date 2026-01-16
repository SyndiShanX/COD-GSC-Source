/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_2_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\karma_2_fx;
#include maps\karma_exit_club;
#include maps\karma_2_anim;
#include maps\karma_2;

precache_util_fx() {
}

precache_scripted_fx() {
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["scanner_ping"] = loadfx("misc/fx_weapon_indicator01");
  level._effect["defalco_blood"] = loadfx("maps/karma/fx_kar_blood_defalco");
  level._effect["karma_blood"] = loadfx("maps/karma/fx_kar_blood_karma");
  level._effect["salazar_blood"] = loadfx("maps/karma/fx_kar_blood_salazar");
  level._effect["guard_blood"] = loadfx("maps/karma/fx_kar_blood_enemy");
  level._effect["def_explosion"] = loadfx("explosions/fx_default_explosion");
  level._effect["fake_tracer"] = loadfx("maps/karma/fx_kar_static_tracer");
  level._effect["metal_storm_death"] = loadfx("explosions/fx_vexp_metalstorm01");
  level._effect["blood_wounded_streak"] = loadfx("bio/player/fx_blood_wounded_streak");
  level._effect["heli_missile_tracer"] = loadfx("weapon/rocket/fx_rocket_drone_geotrail");
  level._effect["light_caution_red_flash"] = loadfx("light/fx_light_caution_red_flash");
  level._effect["kar_exp_ship_fail_player"] = loadfx("explosions/fx_kar_exp_ship_fail_player");
  level._effect["end_hero_explosion"] = loadfx("maps/karma/fx_kar_end_exp_sm");
  level._effect["balcony_death_blood_splat"] = loadfx("maps/karma/fx_kar_blood_melee_hit");
  level._effect["blood_cloud_water"] = loadfx("maps/karma/fx_kar_blood_cloud_water");
  level._effect["metal_storm_damage_1"] = loadfx("vehicle/vfire/fx_metalstorm_damagestate01");
  level._effect["metal_storm_damage_2"] = loadfx("vehicle/vfire/fx_metalstorm_damagestate02");
  level._effect["metal_storm_damage_3"] = loadfx("vehicle/vfire/fx_metalstorm_damagestate03");
  level._effect["metal_storm_damage_4"] = loadfx("vehicle/vfire/fx_metalstorm_damagestate04");
  level._effect["vtol_exhaust"] = loadfx("vehicle/exhaust/fx_exhaust_heli_vtol");
  level._effect["cutter_on"] = loadfx("props/fx_laser_cutter_on");
  level._effect["cutter_spark"] = loadfx("props/fx_laser_cutter_sparking");
  level._effect["intruder_door_smoke_left"] = loadfx("misc/fx_laser_cutter_steam_parent");
  level._effect["intruder_door_smoke_right"] = loadfx("misc/fx_laser_cutter_steam_parent");
  level._effect["intruder_door_sparks_left"] = loadfx("misc/fx_laser_cutter_steam");
  level._effect["intruder_door_sparks_right"] = loadfx("misc/fx_laser_cutter_steam_2");
  level._effect["taser_knuckles"] = loadfx("weapon/taser/fx_taser_knuckles_ambient_start_kar");
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["tree_palm_sm_dest01"] = % fxanim_gp_tree_palm_sm_dest01_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_01"] = % fxanim_gp_seagull_circle_01_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_02"] = % fxanim_gp_seagull_circle_02_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_03"] = % fxanim_gp_seagull_circle_03_anim;
  level.scr_anim["fxanim_props"]["circle_bar"] = % fxanim_karma_circle_bar_anim;
  level.scr_anim["fxanim_props"]["balcony_block"] = % fxanim_karma_balcony_block_anim;
  level.scr_anim["fxanim_props"]["umbrella_01"] = % fxanim_gp_umbrella_01_anim;
  level.scr_anim["fxanim_props"]["cabana_02"] = % fxanim_gp_cabana_02_anim;
  level.scr_anim["fxanim_props"]["store_bomb_01"] = % fxanim_karma_store_bomb_01_anim;
  level.scr_anim["fxanim_props"]["column_explode"] = % fxanim_karma_column_explode_anim;
  level.scr_anim["fxanim_props"]["aquarium_pillar1"] = % fxanim_karma_aquarium_pillar1_anim;
  level.scr_anim["fxanim_props"]["aquarium_pillar2"] = % fxanim_karma_aquarium_pillar2_anim;
  level.scr_anim["fxanim_props"]["aqua_shark1"] = % fxanim_karma_shark1_anim;
  level.scr_anim["fxanim_props"]["aqua_shark2"] = % fxanim_karma_shark2_anim;
  level.scr_anim["fxanim_props"]["aqua_fish1"] = % fxanim_karma_fish1_anim;
  level.scr_anim["fxanim_props"]["aqua_fish2"] = % fxanim_karma_fish2_anim;
  level.scr_anim["fxanim_props"]["aqua_fish3"] = % fxanim_karma_fish3_anim;
  level.scr_anim["fxanim_props"]["aqua_fish_sch1"] = % fxanim_karma_fish_sch1_anim;
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

wind_initial_setting() {
  setsaveddvar("wind_global_vector", "-145 143 0");
  setsaveddvar("wind_global_low_altitude", -3367);
  setsaveddvar("wind_global_hi_altitude", 1500);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

main() {
  initmodelanims();
  precache_util_fx();
  precache_scripted_fx();
  precache_createfx_fx();
  footsteps();
  maps\createfx\karma_2_fx::main();
  maps\karma_exit_club::karma2_hide_tower_and_shell();
  wind_initial_setting();
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_dust");
}

createfx_setup() {
  maps\karma_2_anim::exit_club_anims();
  maps\karma_2_anim::mall_anims();
  maps\karma_2_anim::sundeck_anims();
  level.skipto_point = tolower(getdvar(#"_id_1BEC029F"));

  if(level.skipto_point == "")
    level.skipto_point = "club exit";

  maps\karma_2::load_gumps_karma();
}

createfx_setup_gump_mall() {
}

createfx_setup_gump_sundeck() {
}

createfx_setup_gump_the_end() {
}