/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan_2_fx.csc
*******************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\pakistan_2_fx;
#include clientscripts\_fx;

precache_scripted_fx() {
  level._effect["soct_water_splash"] = loadfx("water/fx_vwater_soct_splash");
  level._effect["fire_crate"] = loadfx("fire/fx_pak_fire_crate01");
  level._effect["fire_board"] = loadfx("fire/fx_pak_fire_boards_on_water_sm");
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

main() {
  clientscripts\createfx\pakistan_2_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}