/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_2_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\createfx\pakistan_2_fx;

main() {
  precache_fxanim_props();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  maps\createfx\pakistan_2_fx::main();
}

precache_scripted_fx() {
  level._effect["drone_spotlight"] = loadfx("light/fx_vlight_firescout_spotlight");
  level._effect["drone_spotlight_targeting"] = loadfx("light/fx_vlight_firescout_spotlight_targeting");
  level._effect["drone_spotlight_cheap"] = loadfx("light/fx_vlight_firescout_spotlight_cheap");
  level._effect["friendly_marker"] = loadfx("misc/fx_friendly_indentify01");
  level._effect["courtyard_spotlight"] = loadfx("light/fx_spotlight_modern_rain_lt");
  level._effect["soct_spotlight"] = loadfx("light/fx_vlight_soct_headlight_spot");
  level._effect["soct_spotlight_cheap"] = loadfx("light/fx_vlight_soct_headlight_cheap");
  level._effect["soct_water_splash"] = loadfx("water/fx_vwater_soct_splash");
  level._effect["big_spotlight"] = loadfx("light/fx_pak2_spotlight_search");
  level._effect["big_spotlight_targeting"] = loadfx("light/fx_pak2_spotlight_search_targeting");
  level._effect["big_spotlight_cheap"] = loadfx("light/fx_pak2_spotlight_search_cheap");
  level._effect["underwater_bullet_fx"] = loadfx("maps/pakistan/fx_pak_bullet_barrage_underwater");
  level._effect["melee_knife_blood_harper"] = loadfx("maps/pakistan/fx_pak_chest_blood_harper");
  level._effect["melee_knife_blood_player"] = loadfx("maps/pakistan/fx_pak_chest_blood_player");
  level._effect["fx_vlight_brakelight_default"] = loadfx("light/fx_vlight_brakelight_default");
  level._effect["fx_vlight_headlight_default"] = loadfx("light/fx_vlight_headlight_default");
  level._effect["fire_crate"] = loadfx("fire/fx_pak_fire_crate01");
  level._effect["fire_board"] = loadfx("fire/fx_pak_fire_boards_on_water_sm");
  level._effect["door_breach"] = loadfx("props/fx_door_breach");
  level._effect["grenade_light"] = loadfx("maps/pakistan/fx_light_blink_incendiary_grenade");
  level._effect["spotlight_target"] = loadfx("maps/pakistan/fx_spotlight_target");
  level._effect["spotlight_lens_flare"] = loadfx("lens_flares/fx_lf_pakistan_searchlight2");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["water_wake"] = loadfx("maps/pakistan/fx_pak_harper_water_wake");
}

precache_createfx_fx() {
  level._effect["fx_pak2_spotlight_harper_intro"] = loadfx("light/fx_pak2_spotlight_harper_intro");
  level._effect["fx_pak_light_spot_incendiary_grenade_room"] = loadfx("light/fx_pak_light_spot_incendiary_grenade_room");
  level._effect["fx_pak_light_spot_gaz_tigr_dome"] = loadfx("light/fx_pak_light_spot_gaz_tigr_dome");
  level._effect["fx_vlight_dome_gaz_tigr"] = loadfx("light/fx_vlight_dome_gaz_tigr");
  level._effect["fx_fire_fuel_sm_water"] = loadfx("fire/fx_fire_fuel_sm_water");
  level._effect["fx_fire_fuel_md_water"] = loadfx("fire/fx_fire_fuel_md_water");
  level._effect["fx_fire_fuel_sm_ground"] = loadfx("fire/fx_fire_fuel_sm_ground");
  level._effect["fx_fire_fuel_sm_line"] = loadfx("fire/fx_fire_fuel_sm_line");
  level._effect["fx_fire_fuel_sm"] = loadfx("fire/fx_fire_fuel_sm");
  level._effect["fx_fire_wall_md"] = loadfx("env/fire/fx_fire_wall_md");
  level._effect["fx_fire_ceiling_md"] = loadfx("env/fire/fx_fire_ceiling_md");
  level._effect["fx_ceiling_edge_md"] = loadfx("fire/fx_ceiling_edge_md");
  level._effect["fx_fire_ceiling_line_sm"] = loadfx("fire/fx_fire_ceiling_line_sm");
  level._effect["fx_fire_edge_windblown_md"] = loadfx("fire/fx_pak_fire_edge_windblown_md");
  level._effect["fx_pak_pipe_fire"] = loadfx("maps/pakistan/fx_pak_pipe_fire");
  level._effect["fx_lights_stadium_drizzle_pak"] = loadfx("light/fx_lights_stadium_drizzle_pak");
  level._effect["fx_lights_small_drizzle_pak"] = loadfx("light/fx_lights_small_drizzle_pak");
  level._effect["fx_lights_small_glow_pak"] = loadfx("light/fx_lights_small_glow_pak");
  level._effect["fx_lights_small_glow_pak_b"] = loadfx("light/fx_lights_small_glow_pak_b");
  level._effect["fx_lights_small_drizzle_pak_b"] = loadfx("light/fx_lights_small_drizzle_pak_b");
  level._effect["fx_light_glow_red_sml"] = loadfx("maps/pakistan/fx_light_glow_red_sml");
  level._effect["fx_light_glow_blue_sml"] = loadfx("maps/pakistan/fx_light_glow_blue_sml");
  level._effect["fx_light_glow_yellow_sml"] = loadfx("maps/pakistan/fx_light_glow_yellow_sml");
  level._effect["fx_pak_flourescent_glow"] = loadfx("maps/pakistan/fx_pak_flourescent_glow");
  level._effect["fx_pak_light_ray_grate_warm"] = loadfx("light/fx_pak_light_ray_grate_warm");
  level._effect["fx_pak_light_ray_underwater"] = loadfx("light/fx_pak_light_ray_underwater");
  level._effect["fx_pak_light_ray_underwater_spread"] = loadfx("light/fx_pak_light_ray_underwater_spread");
  level._effect["fx_pak_ray_underwater_fire"] = loadfx("light/fx_pak_ray_underwater_fire");
  level._effect["fx_pak_light_overhead_rain"] = loadfx("light/fx_pak_light_overhead_rain");
  level._effect["fx_pak_light_ray_street_rain"] = loadfx("light/fx_pak_light_ray_street_rain");
  level._effect["fx_pak_light_square_flood"] = loadfx("light/fx_pak_light_square_flood");
  level._effect["fx_pak_light_overhead"] = loadfx("light/fx_pak2_light_overhead");
  level._effect["fx_pak2_light_overhead_dist_rain"] = loadfx("light/fx_pak2_light_overhead_dist_rain");
  level._effect["fx_pak2_light_overhead_cool_dist_rain"] = loadfx("light/fx_pak2_light_overhead_cool_dist_rain");
  level._effect["fx_pak_light_overhead_blink"] = loadfx("light/fx_pak_light_overhead_blink");
  level._effect["fx_pak_light_fluorescent_dist"] = loadfx("light/fx_pak_light_fluorescent_dist");
  level._effect["fx_pak_light_fluorescent"] = loadfx("light/fx_pak_light_fluorescent");
  level._effect["fx_pak_light_overhead_warm"] = loadfx("light/fx_pak_light_overhead_warm");
  level._effect["fx_pak_light_overhead_warm_rain"] = loadfx("light/fx_pak_light_overhead_warm_rain");
  level._effect["fx_pak_street_light_short_single_warm"] = loadfx("light/fx_pak_street_light_short_single_warm");
  level._effect["fx_rain_light_loop"] = loadfx("weather/fx_rain_med_loop");
  level._effect["fx_pak_rooftop_water"] = loadfx("maps/pakistan/fx_pak_rooftop_water");
  level._effect["fx_pak_water_bubble_leak"] = loadfx("water/fx_pak_water_bubble_leak");
  level._effect["fx_wtr_spill_sm_thin"] = loadfx("env/water/fx_wtr_spill_sm_thin");
  level._effect["fx_water_pipe_spill_sm_thin_short"] = loadfx("water/fx_water_pipe_spill_sm_thin_short");
  level._effect["fx_water_pipe_spill_sm_thin_tall"] = loadfx("water/fx_water_pipe_spill_sm_thin_tall");
  level._effect["fx_water_spill_sm"] = loadfx("water/fx_water_spill_sm");
  level._effect["fx_water_spill_sm_splash"] = loadfx("water/fx_water_spill_sm_splash");
  level._effect["fx_water_roof_spill_md"] = loadfx("water/fx_water_roof_spill_md");
  level._effect["fx_water_roof_spill_md_short"] = loadfx("water/fx_water_roof_spill_md_short");
  level._effect["fx_pak_water_roof_spill_expensive"] = loadfx("water/fx_pak_water_roof_spill_expensive");
  level._effect["fx_water_roof_spill_lg"] = loadfx("water/fx_water_roof_spill_lg");
  level._effect["fx_water_spill_splash_wide"] = loadfx("water/fx_water_spill_splash_wide");
  level._effect["fx_water_sheeting_lg_hvy"] = loadfx("water/fx_water_sheeting_lg_hvy");
  level._effect["fx_rain_spatter_06x30"] = loadfx("water/fx_rain_spatter_06x30");
  level._effect["fx_rain_spatter_06x60"] = loadfx("water/fx_rain_spatter_06x60");
  level._effect["fx_rain_spatter_06x120"] = loadfx("water/fx_rain_spatter_06x120");
  level._effect["fx_rain_spatter_06x200"] = loadfx("water/fx_rain_spatter_06x200");
  level._effect["fx_rain_spatter_06x300"] = loadfx("water/fx_rain_spatter_06x300");
  level._effect["fx_rain_spatter_25x25"] = loadfx("water/fx_rain_spatter_25x25");
  level._effect["fx_rain_spatter_25x50"] = loadfx("water/fx_rain_spatter_25x50");
  level._effect["fx_rain_spatter_50x50"] = loadfx("water/fx_rain_spatter_50x50");
  level._effect["fx_rain_spatter_25x120"] = loadfx("water/fx_rain_spatter_25x120");
  level._effect["fx_rain_spatter_50x120"] = loadfx("water/fx_rain_spatter_50x120");
  level._effect["fx_rain_spatter_50x200"] = loadfx("water/fx_rain_spatter_50x200");
  level._effect["fx_rain_splash_100x200"] = loadfx("water/fx_rain_splash_100x200");
  level._effect["fx_rain_splash_200x200"] = loadfx("water/fx_rain_splash_200x200");
  level._effect["fx_water_drips_light_30_long"] = loadfx("water/fx_water_drips_light_30_long");
  level._effect["fx_water_drips_hvy_30"] = loadfx("water/fx_water_drips_hvy_30");
  level._effect["fx_water_drips_hvy_120"] = loadfx("water/fx_water_drips_hvy_120");
  level._effect["fx_water_drips_hvy_200"] = loadfx("water/fx_water_drips_hvy_200");
  level._effect["fx_water_drips_hvy_200_short"] = loadfx("water/fx_water_drips_hvy_200_short");
  level._effect["fx_pak_water_particles"] = loadfx("water/fx_pak_water_particles");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_linger_lit_slow"] = loadfx("smoke/fx_smk_linger_lit_slow");
  level._effect["fx_pak_smk_ceiling_fast"] = loadfx("smoke/fx_pak_smk_ceiling_fast");
  level._effect["fx_pak_smk_fire_thick"] = loadfx("smoke/fx_pak_smk_fire_thick");
  level._effect["fx_trainstation_steam_vent"] = loadfx("maps/pakistan/fx_trainstation_steam_vent");
  level._effect["fx_trainstation_steam_train"] = loadfx("maps/pakistan/fx_trainstation_steam_train");
  level._effect["fx_elec_burst_shower_sm_int_runner"] = loadfx("electrical/fx_elec_burst_shower_sm_int_runner");
  level._effect["fx_elec_transformer_exp_lg_os"] = loadfx("electrical/fx_elec_transformer_exp_lg_os");
  level._effect["fx_elec_transformer_exp_md_os"] = loadfx("electrical/fx_elec_transformer_exp_md_os");
  level._effect["fx_elec_transformer_sparks_runner"] = loadfx("electrical/fx_elec_transformer_sparks_runner");
}

wind_init() {
  setsaveddvar("wind_global_vector", "-145 110 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

#using_animtree("fxanim_props");

precache_fxanim_props() {
  level.scr_anim["fxanim_props"]["billboard_pillar_top03"] = % fxanim_la_billboard_pillar_top01_anim;
  level.scr_anim["fxanim_props"]["scaffold_collapse"] = % fxanim_pak_scaffold_collapse_anim;
  level.scr_anim["fxanim_props"]["catwalk_end_collapse"] = % fxanim_pak_catwalk_end_collapse_anim;
  level.scr_anim["fxanim_props"]["silo_end_collapse"] = % fxanim_pak_silo_end_collapse_anim;
  level.scr_anim["fxanim_props"]["underwater_wires"] = % fxanim_pak_underwater_wires_anim;
  level.scr_anim["fxanim_props"]["pak_canopies_brown"] = % fxanim_pak_canopy_brown_anim;
  level.scr_anim["fxanim_props"]["pak_canopies_brown_sml"] = % fxanim_pak_canopy_brown_sml_anim;
}