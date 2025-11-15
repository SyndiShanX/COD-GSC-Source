/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_3_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\pakistan_3_fx;

main() {
  precache_fxanim_props();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  maps\createfx\pakistan_3_fx::main();
}

precache_scripted_fx() {
  level._effect["friendly_marker"] = loadfx("misc/fx_friendly_indentify01");
  level._effect["ending_helicopter_explosion"] = loadfx("explosions/fx_vexp_hind_future_impact");
  level._effect["blockade_explosion"] = loadfx("explosions/fx_vexp_gen_boat_x_up");
  level._effect["drone_spotlight_cheap"] = loadfx("light/fx_vlight_firescout_spotlight_cheap_short");
  level._effect["firescout_spotlight"] = loadfx("light/fx_vlight_drone_spotlight");
  level._effect["soct_spotlight"] = loadfx("light/fx_vlight_soct_headlight_spot");
  level._effect["soct_spotlight_cheap"] = loadfx("light/fx_vlight_soct_headlight_cheap");
  level._effect["heli_crash_smoke_trail"] = loadfx("trail/fx_trail_la_plane_pieces");
  level._effect["apache_spotlight_cheap"] = loadfx("light/fx_vlight_apache_spotlight_cheap_no_lf");
  level._effect["heli_spotlight_lens_flare"] = loadfx("lens_flares/fx_lf_pakistan_searchlight2");
  level._effect["soct_water_splash"] = loadfx("water/fx_vwater_soct_splash");
  level._effect["soct_boost_fx"] = loadfx("maps/pakistan/fx_soct_player_boost_os");
  level._effect["soct_player_exp"] = loadfx("maps/pakistan/fx_pak3_exp_soct");
  level._effect["soct_damaged"] = loadfx("vehicle/vfire/fx_vfire_soc_t");
  level._effect["soct_window_smash"] = loadfx("maps/pakistan/fx_window_shatter_xlg_wide");
  level._effect["pak_water_tower_spill"] = loadfx("water/fx_pak_water_tower_spill");
  level._effect["fx_palm_tree_impact"] = loadfx("maps/pakistan/fx_palm_tree_impact");
  level._effect["street_light_long_double_bent_2"] = loadfx("light/fx_pak_street_light_long_double_bent_2");
  level._effect["street_light_long_single"] = loadfx("light/fx_pak_street_light_long_single");
  level._effect["street_light_long_single_bent_1"] = loadfx("light/fx_pak_street_light_long_single_bent_1");
  level._effect["street_light_short_double_full"] = loadfx("light/fx_pak_street_light_short_double_full");
  level._effect["street_light_short_single_bent_1"] = loadfx("light/fx_pak_street_light_short_single_bent_1");
  level._effect["fx_drone_damage_low"] = loadfx("maps/pakistan/fx_firescout_dmg_1_sparks");
  level._effect["fx_drone_damage_med_1"] = loadfx("maps/pakistan/fx_firescout_dmg_2_sparks");
  level._effect["fx_drone_damage_med_2"] = loadfx("maps/pakistan/fx_firescout_dmg_2_fuel_leak");
  level._effect["fx_drone_damage_hi_1"] = loadfx("maps/pakistan/fx_firescout_dmg_3_sparks");
  level._effect["fx_drone_damage_hi_2"] = loadfx("maps/pakistan/fx_firescout_dmg_3_fuel_fire");
  level._effect["fx_soct_damage_low_1"] = loadfx("maps/pakistan/fx_soct_dmg_1_console_spark");
  level._effect["fx_soct_damage_low_2"] = loadfx("maps/pakistan/fx_soct_dmg_1_smk_vent");
  level._effect["fx_soct_damage_med_1"] = loadfx("maps/pakistan/fx_soct_dmg_2_console_spark");
  level._effect["fx_soct_damage_med_2"] = loadfx("maps/pakistan/fx_soct_dmg_2_smk_vent");
  level._effect["fx_soct_damage_hi_1"] = loadfx("maps/pakistan/fx_soct_dmg_3_console_spark");
  level._effect["fx_soct_damage_hi_2"] = loadfx("maps/pakistan/fx_soct_dmg_3_smk_vent");
}

precache_createfx_fx() {
  level._effect["fx_pak_dest_billboard_top"] = loadfx("destructibles/fx_pak_dest_billboard_top");
  level._effect["fx_balcony_collapse_wood"] = loadfx("maps/pakistan/fx_balcony_collapse_wood");
  level._effect["fx_pak_balcony_collapse_ground_impact"] = loadfx("dirt/fx_pak_balcony_collapse_ground_impact");
  level._effect["fx_dest_pak_window_wall"] = loadfx("maps/pakistan/fx_dest_pak_window_wall");
  level._effect["fx_pak_window_wall_ground_impact"] = loadfx("dirt/fx_pak_window_wall_ground_impact");
  level._effect["fx_pak_dest_scaffolding"] = loadfx("destructibles/fx_pak_dest_scaffolding");
  level._effect["fx_pak_window_shatter_600"] = loadfx("maps/pakistan/fx_pak_window_shatter_600");
  level._effect["fx_pak_window_shatter_300"] = loadfx("maps/pakistan/fx_pak_window_shatter_300");
  level._effect["fx_pak_window_shatter_500_tall"] = loadfx("maps/pakistan/fx_pak_window_shatter_500_tall");
  level._effect["fx_pak_window_shatter_500"] = loadfx("maps/pakistan/fx_pak_window_shatter_500");
  level._effect["fx_pak_window_shatter_720"] = loadfx("maps/pakistan/fx_pak_window_shatter_720");
  level._effect["fx_pak_window_shatter_1300"] = loadfx("maps/pakistan/fx_pak_window_shatter_1300");
  level._effect["fx_pak_window_shatter_880"] = loadfx("maps/pakistan/fx_pak_window_shatter_880");
  level._effect["fx_pak_heli_crash_exp"] = loadfx("maps/pakistan/fx_pak_heli_crash_exp");
  level._effect["fx_pak_smk_signal_dist"] = loadfx("smoke/fx_pak_smk_signal_dist");
  level._effect["fx_elec_led_sign_dest_sm"] = loadfx("electrical/fx_elec_led_sign_dest_sm");
  level._effect["fx_pak_exp_drone_blockade"] = loadfx("explosions/fx_pak_exp_drone_blockade");
  level._effect["fx_pak_scaffold_collapse"] = loadfx("maps/pakistan/fx_pak_scaffold_collapse");
  level._effect["fx_pak_scaffold_collapse_02"] = loadfx("maps/pakistan/fx_pak_scaffold_collapse_02");
  level._effect["fx_pak_exp_catwalk"] = loadfx("explosions/fx_pak_exp_catwalk");
  level._effect["fx_pak_water_splash_catwalk"] = loadfx("water/fx_pak_water_splash_catwalk");
  level._effect["fx_pak_water_splash_silo"] = loadfx("water/fx_pak_water_splash_silo");
  level._effect["fx_silo_catwalk_impact_scrape"] = loadfx("maps/pakistan/fx_silo_catwalk_impact_scrape");
  level._effect["fx_silo_break"] = loadfx("maps/pakistan/fx_silo_break");
  level._effect["fx_water_silo_exp"] = loadfx("maps/pakistan/fx_exp_silo_ground");
  level._effect["fx_pak_exp_tower_collapse"] = loadfx("explosions/fx_pak_exp_tower_collapse");
  level._effect["fx_tower_collapse_roof_impact"] = loadfx("maps/pakistan/fx_tower_collapse_roof_impact");
  level._effect["fx_tower_collapse_spire_break"] = loadfx("maps/pakistan/fx_tower_collapse_spire_break");
  level._effect["fx_pak_tower_collapse_fire_leak"] = loadfx("fire/fx_pak_tower_collapse_fire_leak");
  level._effect["fx_pak_water_tower_collapse_splash_area_sm"] = loadfx("water/fx_pak_water_tower_collapse_splash_area_sm");
  level._effect["fx_pak_pipe_acid_gush"] = loadfx("water/fx_pak_pipe_acid_gush");
  level._effect["fx_pak_water_tower_pipe_splash"] = loadfx("water/fx_pak_water_tower_pipe_splash");
  level._effect["fx_pak_water_splash_water_tower"] = loadfx("water/fx_pak_water_splash_water_tower");
  level._effect["fx_pak_exp_pipe_runner_long"] = loadfx("explosions/fx_pak_exp_pipe_runner_long");
  level._effect["fx_pak_exp_pipe_runner_short"] = loadfx("explosions/fx_pak_exp_pipe_runner_short");
  level._effect["fx_pak_exp_pipe_lg"] = loadfx("explosions/fx_pak_exp_pipe_lg");
  level._effect["fx_pak_fire_gas_pipe_hangar"] = loadfx("fire/fx_pak_fire_gas_pipe_hangar");
  level._effect["fx_elec_transformer_exp_lg_os"] = loadfx("electrical/fx_elec_transformer_exp_lg_os_dist");
  level._effect["fx_elec_transformer_exp_md_os"] = loadfx("electrical/fx_elec_transformer_exp_md_os_dist");
  level._effect["fx_exp_fire_harper_face_burn"] = loadfx("maps/pakistan/fx_exp_fire_harper_face_burn");
  level._effect["fx_pak3_spotlight_zhao"] = loadfx("light/fx_pak3_spotlight_zhao");
  level._effect["fx_rain_light_loop"] = loadfx("weather/fx_rain_med_loop");
  level._effect["fx_pak_water_debris_splash_lg_os"] = loadfx("water/fx_pak3_water_debris_splash_lg_os");
  level._effect["fx_pak_water_debris_splash_md_os"] = loadfx("water/fx_pak3_water_debris_splash_md_os");
  level._effect["fx_pak3_water_spatter_lg"] = loadfx("water/fx_pak3_water_spatter_lg");
  level._effect["fx_pak3_water_spill_pipe_lg_tall"] = loadfx("water/fx_pak3_water_spill_pipe_lg_tall");
  level._effect["fx_rain_splash_heavy_200x200"] = loadfx("water/fx_rain_splash_heavy_200x200");
  level._effect["fx_fire_fuel_sm_water"] = loadfx("fire/fx_fire_fuel_sm_water");
  level._effect["fx_fire_fuel_md_water"] = loadfx("fire/fx_fire_fuel_md_water");
  level._effect["fx_fire_fuel_sm_ground"] = loadfx("fire/fx_fire_fuel_sm_ground");
  level._effect["fx_fire_fuel_sm_line"] = loadfx("fire/fx_fire_fuel_sm_line");
  level._effect["fx_fire_fuel_sm"] = loadfx("fire/fx_fire_fuel_sm");
  level._effect["fx_fire_fuel_xsm"] = loadfx("fire/fx_fire_fuel_xsm");
  level._effect["fx_fire_line_lg"] = loadfx("env/fire/fx_fire_line_lg");
  level._effect["fx_fire_line_lg_dist"] = loadfx("env/fire/fx_fire_line_lg_dist");
  level._effect["fx_fire_line_md"] = loadfx("env/fire/fx_fire_line_md");
  level._effect["fx_fire_line_sm_dist"] = loadfx("env/fire/fx_fire_line_sm_dist");
  level._effect["fx_fire_xsm"] = loadfx("fire/fx_fire_xsm");
  level._effect["fx_fire_sm_smolder"] = loadfx("fire/fx_fire_sm_smolder");
  level._effect["fx_fire_bldg_lg_dist"] = loadfx("fire/fx_fire_bldg_lg_dist");
  level._effect["fx_pak_fire_edge_windblown_md_dist"] = loadfx("fire/fx_pak_fire_edge_windblown_md_dist");
  level._effect["fx_pak_fire_fuel_edge_windblown_md_dist"] = loadfx("fire/fx_pak_fire_fuel_edge_windblown_md_dist");
  level._effect["fx_pak_tower_fire_flareup"] = loadfx("fire/fx_pak_tower_fire_flareup");
  level._effect["fx_pak_fire_building_md"] = loadfx("fire/fx_pak_fire_building_md");
  level._effect["fx_pak_fire_building_wall_lg"] = loadfx("fire/fx_pak_fire_building_wall_lg");
  level._effect["fx_pak_fire_rafter_xlg"] = loadfx("fire/fx_pak_fire_rafter_xlg");
  level._effect["fx_embers_falling_lg"] = loadfx("fire/fx_embers_falling_lg");
  level._effect["fx_smk_bldg_lg"] = loadfx("smoke/fx_smk_bldg_lg");
  level._effect["fx_pak_smk_cooling_tower"] = loadfx("smoke/fx_pak_smk_cooling_tower");
  level._effect["fx_smk_plume_md_blk_wispy_dist"] = loadfx("smoke/fx_smk_plume_md_blk_wispy_dist");
  level._effect["fx_smk_plume_md_blk_wispy_dist_slow"] = loadfx("smoke/fx_smk_plume_md_blk_wispy_dist_slow");
  level._effect["fx_smk_plume_md_gray_wispy_dist"] = loadfx("smoke/fx_smk_plume_md_gray_wispy_dist");
  level._effect["fx_smk_plume_md_gray_wispy_dist_slow"] = loadfx("smoke/fx_smk_plume_md_gray_wispy_dist_slow");
  level._effect["fx_pak3_ambient_mist_moving"] = loadfx("smoke/fx_pak3_ambient_mist_moving");
  level._effect["fx_pak3_ambient_mist"] = loadfx("smoke/fx_pak3_ambient_mist");
  level._effect["fx_pak3_smk_fire_outro"] = loadfx("smoke/fx_pak3_smk_fire_outro");
  level._effect["fx_pak_light_overhead_dist"] = loadfx("light/fx_pak_light_overhead_dist");
  level._effect["fx_pak_light_overhead_sm_dist"] = loadfx("light/fx_pak_light_overhead_sm_dist");
  level._effect["fx_lights_stadium_drizzle_pak"] = loadfx("light/fx_lights_stadium_drizzle_pak");
  level._effect["fx_pak_light_road_flare"] = loadfx("maps/pakistan/fx_pak_light_road_flare");
  level._effect["fx_pak_light_road_flare_hero"] = loadfx("maps/pakistan/fx_pak_light_road_flare_hero");
  level._effect["fx_light_glow_blue_lrg"] = loadfx("maps/pakistan/fx_light_glow_blue_lrg");
  level._effect["fx_pak_light_overhead_rain_hvy"] = loadfx("light/fx_pak_light_overhead_rain_hvy");
  level._effect["fx_pak_light_overhead_rain_hvy_blink"] = loadfx("light/fx_pak_light_overhead_rain_hvy_blink");
  level._effect["fx_pak_light_fluorescent_dist"] = loadfx("light/fx_pak_light_fluorescent_dist");
  level._effect["fx_pak_light_fluorescent_double_dist"] = loadfx("light/fx_pak_light_fluorescent_double_dist");
  level._effect["fx_pak_light_ray_street_rain"] = loadfx("light/fx_pak_light_ray_street_rain");
  level._effect["fx_pak_light_square_flood"] = loadfx("light/fx_pak_light_square_flood");
  level._effect["fx_pak_light_glow_sign_red"] = loadfx("light/fx_pak_light_glow_sign_red");
  level._effect["fx_pak_light_glow_sign_white"] = loadfx("light/fx_pak_light_glow_sign_white");
  level._effect["fx_pak_light_glow_sign_white_lg"] = loadfx("light/fx_pak_light_glow_sign_white_lg_dist");
  level._effect["fx_pak_light_window_glow"] = loadfx("light/fx_pak_light_window_glow");
  level._effect["fx_street_light_long_double_bent_2"] = loadfx("light/fx_pak_street_light_long_double_bent_2");
  level._effect["fx_street_light_long_single"] = loadfx("light/fx_pak_street_light_long_single");
  level._effect["fx_street_light_long_single_bent_1"] = loadfx("light/fx_pak_street_light_long_single_bent_1");
  level._effect["fx_street_light_short_double_full"] = loadfx("light/fx_pak_street_light_short_double_full");
  level._effect["fx_street_light_short_single_bent_1"] = loadfx("light/fx_pak_street_light_short_single_bent_1");
  level._effect["fx_la2_light_beacon_red_blink"] = loadfx("light/fx_la2_light_beacon_red_blink");
  level._effect["fx_pak3_light_beacon_red"] = loadfx("light/fx_pak3_light_beacon_red");
  level._effect["fx_steelworks_lava_bubbles"] = loadfx("maps/pakistan/fx_steelworks_lava_bubbles");
  level._effect["fx_steelworks_lavafall"] = loadfx("maps/pakistan/fx_steelworks_lavafall");
  level._effect["fx_steelworks_lava_surface"] = loadfx("maps/pakistan/fx_steelworks_lava_surface");
  level._effect["fx_elec_transformer_sparks_runner"] = loadfx("electrical/fx_elec_transformer_sparks_runner_dist");
  level._effect["fx_elec_burst_shower_sm_runner_dist"] = loadfx("electrical/fx_elec_burst_shower_sm_runner_dist");
}

wind_init() {
  setsaveddvar("wind_global_vector", "-145 110 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

#using_animtree("fxanim_props");

precache_fxanim_props() {
  level.scr_anim["fxanim_props"]["billboard_pillar_top03"] = % fxanim_la_billboard_pillar_top04_anim;
  level.scr_anim["fxanim_props"]["scaffold_collapse"] = % fxanim_pak_scaffold_collapse_anim;
  level.scr_anim["fxanim_props"]["catwalk_end_collapse"] = % fxanim_pak_catwalk_end_collapse_anim;
  level.scr_anim["fxanim_props"]["silo_end_collapse"] = % fxanim_pak_silo_end_collapse_anim;
  level.scr_anim["fxanim_props"]["scaffold_collapse_02"] = % fxanim_pak_scaffold_collapse_02_anim;
  level.scr_anim["fxanim_props"]["palm_sm_dest03"] = % fxanim_gp_tree_palm_sm_dest03_anim;
  level.scr_anim["fxanim_props"]["drone_scaffold_01"] = % fxanim_pak_drone_scaffold_01_anim;
  level.scr_anim["fxanim_props"]["drone_scaffold_02"] = % fxanim_pak_drone_scaffold_02_anim;
  level.scr_anim["fxanim_props"]["drone_scaffold_03"] = % fxanim_pak_drone_scaffold_03_anim;
  level.scr_anim["fxanim_props"]["drone_scaffold_04"] = % fxanim_pak_drone_scaffold_04_anim;
  level.scr_anim["fxanim_props"]["drone_scaffold_05"] = % fxanim_pak_drone_scaffold_05_anim;
  level.scr_anim["fxanim_props"]["drone_blockade"] = % fxanim_pak_drone_blockade_anim;
  level.scr_anim["fxanim_props"]["water_tower_block"] = % fxanim_pak_water_tower_block_anim;
  level.scr_anim["fxanim_props"]["water_tower_pipes_block"] = % fxanim_pak_water_tower_pipes_block_anim;
  level.scr_anim["fxanim_props"]["catwalk_bridge"] = % fxanim_pak_catwalk_anim;
  level.scr_anim["fxanim_props"]["pipes_block"] = % fxanim_pak_pipes_block_anim;
  level.scr_anim["fxanim_props"]["tower_collapse"] = % fxanim_pak_tower_collapse_anim;
  level.scr_anim["fxanim_props"]["highway_sign_01"] = % fxanim_pak_highway_sign_01_anim;
  level.scr_anim["fxanim_props"]["highway_sign_02"] = % fxanim_pak_highway_sign_02_anim;
  level.scr_anim["fxanim_props"]["highway_sign_03"] = % fxanim_pak_highway_sign_03_anim;
  level.scr_anim["fxanim_props"]["highway_sign_04"] = % fxanim_pak_highway_sign_04_anim;
  level.scr_anim["fxanim_props"]["highway_sign_05"] = % fxanim_pak_highway_sign_05_anim;
  level.scr_anim["fxanim_props"]["pak_3_balcony_collapse"] = % fxanim_pak_3_balcony_collapse_anim;
  level.scr_anim["fxanim_props"]["pak_3_window_wall"] = % fxanim_pak_3_window_wall_anim;
  level.scr_anim["fxanim_props"]["smokestack_collapse"] = % fxanim_pak_smokestack_collapse_anim;
  level.scr_anim["fxanim_props"]["smokestack_collapse_fast"] = % fxanim_pak_smokestack_collapse_fast_anim;
  level.scr_anim["fxanim_props"]["smokestack_collapse_fast_02"] = % fxanim_pak_smokestack_collapse_fast_02_anim;
  level.scr_anim["fxanim_props"]["pipes_fire"] = % fxanim_pak_pipes_fire_anim;
  addnotetrack_exploder("fxanim_props", undefined, 10100, "billboard_pillar_top03");
  addnotetrack_fxontag("fxanim_props", "water_tower_block", "exploder 10890 #explosion_start", "pak_water_tower_spill", "mid_04_jnt");
}