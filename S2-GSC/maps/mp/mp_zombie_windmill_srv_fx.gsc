/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_windmill_srv_fx.gsc
*************************************************/

main() {
  level._effect["zmb_wm_ground_fire_a"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ground_fire_a");
  level._effect["zmb_wm_fire_lp_m_tall"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_lp_m_tall");
  level._effect["zmb_ber_elec_sparks_pzl_battery_on"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_elec_sparks_pzl_battery_on");
  level._effect["zmb_snipe_fire_lp_m_whitesmk"] = loadfx("vfx/map/mp_zombie_snipe/zmb_snipe_fire_lp_m_whitesmk");
  level._effect["zmb_fire_vista_lrg_fog"] = loadfx("vfx/map/mp_zombie_island/zmb_fire_vista_lrg_fog");

  level._effect["test_effect"] = loadfx("vfx/test/test_fx");

  level._effect["zmb_jolts_out"] = loadfx("vfx/zombie/zmb_jolts_out");
  level._effect["zmb_zmb_key_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zmb_key_light");
  level._effect["vf_zmb_windmill"] = loadfx("vfx/map/mp_zombie_windmill/vf_zmb_windmill");
  level._effect["zmb_windmill_sky_lightning"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_sky_lightning");
  level._effect["ground_impact"] = LoadFX("vfx/zombie/zmb_ground_impact");
  level._effect["zmb_wm_target_sphere"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_target_sphere");

  level._effect["zmb_wm_water_dripping_line_lrg1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_dripping_line_lrg1");
  level._effect["zmb_wm_water_dripping_line_med1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_dripping_line_med1");
  level._effect["zmb_wm_water_falling_line_1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_falling_line_1");
  level._effect["zmb_wm_water_falling_splash_1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_falling_splash_1");
  level._effect["zmb_wm_rain_splash_area_1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_rain_splash_area_1");
  level._effect["zmb_windmill_drops_attach_player"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_drops_attach_player");
  level._effect["zmb_windmill_rain_attach_player"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_rain_attach_player");
  level._effect["falling_water_drip_runner_slow"] = loadfx("vfx/water/falling_water_drip_runner_slow");
  level._effect["falling_water_drip_runner_fast"] = loadfx("vfx/water/falling_water_drip_runner_fast");
  level._effect["zmb_wm_ground_rainy_sheets_mist1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ground_rainy_sheets_mist1");
  level._effect["zmb_wm_river_splash1_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_splash1_sm");
  level._effect["zmb_wm_river_splash1_m"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_splash1_m");
  level._effect["zmb_wm_river_splash_runner"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_splash_runner");
  level._effect["zmb_wm_water_falling_line_2_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_falling_line_2_sm");
  level._effect["zmb_wm_rain_splashes_props_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_rain_splashes_props_sm");
  level._effect["zmb_wm_house_waterfall01_splash"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_house_waterfall01_splash");
  level._effect["zmb_wm_house_waterfall01_thin"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_house_waterfall01_thin");
  level._effect["zmb_wm_water_trickle_loop"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_trickle_loop");
  level._effect["zmb_wm_water_leak_pipe_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_leak_pipe_sm");
  level._effect["zmb_wm_heavy_rain_attach_player"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_heavy_rain_attach_player");
  level._effect["zmb_wm_rain_volume_windy"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_rain_volume_windy");
  level._effect["zmb_wm_sink_drip01_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_sink_drip01_rnr");
  level._effect["zmb_wm_frank_mud_splash_impt_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_frank_mud_splash_impt_rnr");
  level._effect["zmb_wm_river_foam_end"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_foam_end");
  level._effect["zmb_wm_river_foam"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_foam");

  level._effect["battery_glow"] = loadfx("vfx/lights/red_dot_light");

  level._effect["zmb_wm_wood_falling_dust_med_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_wood_falling_dust_med_rnr");
  level._effect["zmb_wm_wood_burst_splinter"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_wood_burst_splinter");

  level._effect["roach_flock_slow_crawl_runner"] = loadfx("vfx/map/mp_clowntown/roach_flock_slow_crawl_runner");
  level._effect["zmb_rat_flock_short_runner"] = loadfx("vfx/map/mp_zombie_training/zmb_rat_flock_short_runner");
  level._effect["insects_flies_landing_sm"] = loadfx("vfx/animal/insects_flies_landing_sm");
  level._effect["insects_gnats_flying"] = loadfx("vfx/map/mp_dam/insects_gnats_flying");
  level._effect["roach_flock_straight_runner"] = loadfx("vfx/animal/roach_flock_straight_runner");
  level._effect["zmb_rat_flock_runaway_runner"] = loadfx("vfx/map/mp_zombie_nest/zmb_rat_flock_runaway_runner");

  level._effect["zmb_windmill_wind_leaves"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_wind_leaves");
  level._effect["zmb_wm_windy_leaves2"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_windy_leaves2");

  level._effect["zmb_wm_lightning_flasha_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_lightning_flasha_rnr");
  level._effect["zmb_elec_sparks_far_burst_rnr"] = loadfx("vfx/map/mp_zombie_berlin/zmb_elec_sparks_far_burst_rnr");
  level._effect["zmb_wm_radio_damaged"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_radio_damaged");
  level._effect["zmb_wm_radio_fixed"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_radio_fixed");

  level._effect["zmb_dust_fall_wood_debris_01_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_dust_fall_wood_debris_01_rnr");
  level._effect["zmb_dust_falling_wood_debris_01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_dust_falling_wood_debris_01");
  level._effect["zmb_wm_ground_ambient_smk_wispy"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ground_ambient_smk_wispy");
  level._effect["ambient_indoor_dust"] = loadfx("vfx/dust/ambient_indoor_dust");
  level._effect["zmb_wm_frank_mud_splash_impact1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_frank_mud_splash_impact1");
  level._effect["zmb_wm_ambient_indoor_dust"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ambient_indoor_dust");
  level._effect["zmb_wm_smk_smoldering_crater01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_smk_smoldering_crater01");
  level._effect["zmb_wm_falling_debris_brick_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_falling_debris_brick_rnr");
  level._effect["zmb_wm_explosion_dirt01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_explosion_dirt01");
  level._effect["zmb_wm_lightning_impact_base_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_lightning_impact_base_rnr");
  level._effect["zmb_wm_lightning_impact_base"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_lightning_impact_base");
  level._effect["zmb_wm_droppod_dirt_impact"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_droppod_dirt_impact");
  level._effect["zmb_wm_frank_ele_explosion"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_frank_ele_explosion");
  level._effect["zmb_wm_smk_smoldering_crater_lrg"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_smk_smoldering_crater_lrg");

  level._effect["zmb_isl_ground_fire_a"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_ground_fire_a");
  level._effect["zmb_wm_veh_opel_fire_01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_veh_opel_fire_01");
  level._effect["zmb_wm_fire_roof_01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_roof_01");
  level._effect["zmb_wm_fireplace_fire01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fireplace_fire01");
  level._effect["zmb_wm_fire_roof_02"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_roof_02");
  level._effect["zmb_wm_fire_falling_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_falling_rnr");

  level._effect["fx_sunflare_zombie_windmill_dlc3"] = loadfx("vfx/lensflare/dlc/fx_sunflare_zombie_windmill_dlc3");

  level._effect["zmb_snipe_boss_energy_field"] = LoadFX("vfx/map/mp_zombie_snipe/zmb_snipe_boss_pommel_shield");
  level._effect["zmb_snipe_boss_energy_field_burst"] = LoadFX("vfx/map/mp_zombie_snipe/zmb_snipe_boss_pommel_shield_burst");
  level._effect["bombing_run_targeting"] = LoadFX("vfx/map/mp_zombie_windmill/zmb_wm_target_sphere");

  level._effect["bombing_run_bomb_explode"] = LoadFX("vfx/explosion/zmb_windmill_boss_explosion_01");
  level._effect["zmb_wm_boss_bmb_target_400"] = LoadFX("vfx/map/mp_zombie_windmill/zmb_wm_boss_bmb_target_400");

  if(getDvar("3508") != "1")
    maps\createfx\mp_zombie_windmill_srv_fx::main();
}