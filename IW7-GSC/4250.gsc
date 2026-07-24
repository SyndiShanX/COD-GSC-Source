/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4250.gsc
**************************************/

main() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\titanjackal\gen\titanjackal_fx::main();
    scripts\sp\maps\titanjackal\gen\titanjackal_sound::main();
  }

  level._effect["vfx_rain_player_attached_torrential"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_rain_player_attached_torrential.vfx");
  level._effect["vfx_rain_player_attached_heavy"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_rain_player_attached_heavy.vfx");
  level._effect["vfx_rain_player_attached_medium"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_rain_player_attached_medium.vfx");
  level._effect["vfx_rain_player_attached_light"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_rain_player_attached_light.vfx");
  level._effect["vfx_jackal_methane_drops"] = loadfx("vfx/iw7/levels/titan/vfx_jackal_methane_drops.vfx");
  level._effect["vfx_jackal_windshield_gust"] = loadfx("vfx/iw7/levels/titan/vfx_jackal_windshield_gust.vfx");
  level._effect["vfx_jackal_windshield_rain_gust"] = loadfx("vfx/iw7/levels/titan/vfx_jackal_windshield_rain_gust.vfx");
  level._effect["vfx_cloud_ceiling_01"] = loadfx("vfx/iw7/levels/titan/vfx_cloud_ceiling_01.vfx");
  level._effect["tower_explosions"] = loadfx("vfx/iw7/levels/titan/new/vfx_titan_tower_explosion.vfx");
  level._effect["tower_explosion_small"] = loadfx("vfx/iw7/levels/titan/new/vfx_titan_tower_explosion_small.vfx");
  level._effect["vfx_titan_fuelline_imp_splash_runner_04"] = loadfx("vfx/iw7/levels/titan/vfx_titan_fuelline_imp_splash_runner_04.vfx");
  level._effect["pipe_bridge_main_connector_01"] = loadfx("vfx/iw7/levels/titan/vfx_titan_pipe_bridge_main_connector_01.vfx");
  level._effect["vfx_titan_cloud_battle"] = loadfx("vfx/iw7/levels/titan/vfx_titan_cloud_battle.vfx");
  level._effect["turbine_explosion"] = loadfx("vfx/iw7/levels/titan/scripted/turbine_explosion.vfx");
  level._effect["turbine_explosion_fire"] = loadfx("vfx/iw7/levels/titan/scripted/turbine_explosion_fire.vfx");
  level._effect["turbine_explosion_small"] = loadfx("vfx/iw7/levels/titan/new/vfx_titan_turbine_explosion_small.vfx");
  level._effect["vfx_turbine_dest_dust_fill_01"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_turbine_dest_smoke_fill.vfx");
  level._effect["vfx_turbine_lingering_fire_small_1"] = loadfx("vfx/iw7/levels/titan/new/vfx_fire_lingering_lg_02a.vfx");
  level._effect["vfx_turbine_lingering_fire_small_2"] = loadfx("vfx/iw7/levels/titan/new/vfx_fire_lingering_lg_02b.vfx");
  level._effect["vfx_turbine_fire_drips_run"] = loadfx("vfx/iw7/levels/titan/new/vfx_turbine_fire_drips_run.vfx");
  level._effect["vfx_vol_cloud_ret_bg_01"] = loadfx("vfx/iw7/levels/titan/vfx_vol_cloud_ret_bg_01.vfx");
  level._effect["vfx_titan_planet_hotlanding"] = loadfx("vfx/iw7/levels/titan/vfx_titan_planet_hotlanding.vfx");
  level._effect["vfx_titan_mons_breach_cloud_slices_run"] = loadfx("vfx/iw7/levels/titan/vfx_titan_mons_breach_cloud_slices_run.vfx");
  level._effect["vfx_titan_mons_breach_cloud_slices"] = loadfx("vfx/iw7/levels/titan/vfx_titan_mons_breach_cloud_slices.vfx");
  level._effect["zerog_exp_1"] = loadfx("vfx/iw7/levels/titan/impacts/vfx_titan_med_expl_zerog_v1.vfx");
  level._effect["zerog_small_exp"] = loadfx("vfx/iw7/levels/titan/impacts/vfx_titan_sm_expl_zerog_v1.vfx");
  level._effect["zerog_spark_burst"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_hot_landing.vfx");
  level._effect["lander_smoke_trail"] = loadfx("vfx/iw7/_requests/titan/vfx_smktrail_landing_drone.vfx");
  level._effect["defense_turret_muzzle"] = loadfx("vfx/iw7/_requests/titan/vfx_capital_ship_tracer_sm.vfx");
  level._effect["om_flak_expl"] = loadfx("vfx/iw7/levels/titan/impacts/vfx_titan_flak_zerog.vfx");
  level._effect["vfx_burst_window_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_burst_window_01.vfx");
  level._effect["vfx_burst_window_01_run"] = loadfx("vfx/iw7/levels/titan/new/vfx_burst_window_01_run.vfx");
  level._effect["vfx_water_debris_splash_large_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_water_splash_debris_lrg_01.vfx");
  level._effect["vfx_water_debris_splash_med_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_water_splash_debris_med_01.vfx");
  level._effect["vfx_water_debris_splash_xlarge_01_run"] = loadfx("vfx/iw7/levels/titan/new/vfx_water_splash_debris_xlrg_01_run.vfx");
  level._effect["vfx_water_debris_splash_field_01_run"] = loadfx("vfx/iw7/levels/titan/new/vfx_water_splash_debris_field_01_run.vfx");
  level._effect["vfx_water_debris_splash_shock_01_run"] = loadfx("vfx/iw7/levels/titan/new/vfx_water_splash_debris_shock_lrg_01_run.vfx");
  level._effect["vfx_tower_dest_debris_trail_1_run"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_tower_dest_debris_trail_run.vfx");
  level._effect["vfx_tower_dest_debris_trail_2_run"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_tower_dest_debris_trail_2_run.vfx");
  level._effect["vfx_tower_dest_debris_fall_01_run"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_tower_dest_debris_fall_run.vfx");
  level._effect["vfx_tower_dest_debris_fall_02_run"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_tower_dest_debris_fall_run2.vfx");
  level._effect["vfx_tower_dest_smoke_spread"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_tower_dest_smoke_spread.vfx");
  level._effect["vfx_hms_waterfall_splash_large_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_waterfall_splash_lrg_01.vfx");
  level._effect["vfx_water_tread_wash_xlrg_01"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_water_tread_wash_xlrg_01_run.vfx");
  level._effect["vfx_tb_light_red_blinking"] = loadfx("vfx/iw7/levels/titan/vfx_tb_light_red_blinking.vfx");
  level._effect["vfx_tb_light_blue_steady"] = loadfx("vfx/iw7/levels/titan/vfx_tb_light_blue_steady.vfx");
  level._effect["vfx_tb_light_white_steady"] = loadfx("vfx/iw7/levels/titan/vfx_tb_light_white_steady.vfx");
  level._effect["vfx_hms_lensflare_light_05_tj"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_flare_05_tj.vfx");
  level._effect["vfx_hms_lensflare_light_06_tj"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_flare_06_tj.vfx");
  level._effect["vfx_hms_lensflare_light_06_lightpost"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_flare_06_lightpost.vfx");
  level._effect["vfx_hms_lensflare_light_06a"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_flare_06a.vfx");
  level._effect["vfx_hms_lensflare_light_06a_tj"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_flare_06a_tj.vfx");
  level._effect["vfx_hms_lensflare_light_stadium_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_tj_light_glow_stadium_01.vfx");
  level._effect["vfx_hms_light_beacon_red_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_beacon_red_01.vfx");
  level._effect["vfx_hms_light_beacon_red_01a"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_beacon_red_01a.vfx");
  level._effect["vfx_hms_light_beacon_red_02"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_beacon_red_02.vfx");
  level._effect["vfx_hms_light_beacon_white_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_light_glow_beacon_white_01.vfx");
  level._effect["vfx_sun_titanjackal2"] = loadfx("vfx/iw7/levels/titan/new/vfx_sun_titanjackal2.vfx");
  level._effect["vfx_sun_titanjackal"] = loadfx("vfx/iw7/levels/titan/new/vfx_sun_titanjackal.vfx");
  level._effect["vfx_sunflare_titanjackal"] = loadfx("vfx/iw7/levels/titan/new/vfx_sunflare_titanjackal.vfx");
  level._effect["vfx_titan_lightning_02_run"] = loadfx("vfx/iw7/levels/titan/new/vfx_lightning_distant_01_runner.vfx");
  level._effect["vfx_hms_methane_mist_distant_01_tj"] = loadfx("vfx/iw7/levels/titan/new/vfx_methane_mist_distant_01_tj.vfx");
  level._effect["vfx_hms_methane_mist_distant_02_tj"] = loadfx("vfx/iw7/levels/titan/new/vfx_methane_mist_distant_02_tj.vfx");
  level._effect["vfx_hms_methane_clouds_distant_02_tj"] = loadfx("vfx/iw7/levels/titan/new/vfx_methane_clouds_thick_distant_02_tj.vfx");
  level._effect["vfx_hms_fire_burn_off_xlg_loop"] = loadfx("vfx/iw7/levels/titan/new/vfx_fire_burn_off_source_xlg_03.vfx");
  level._effect["vfx_hms_fire_burn_off_lg_runner_01"] = loadfx("vfx/iw7/levels/titan/new/vfx_fire_burn_off_source_lg_runner_01.vfx");
  level._effect["vfx_hms_burn_off_plume_lg_02"] = loadfx("vfx/iw7/levels/titan/new/vfx_fire_burn_off_plume_lg_02.vfx");
  level._effect["vfx_hms_methane_ambiance_area_lg_windy_01_lit"] = loadfx("vfx/iw7/levels/titan/new/vfx_methane_ambiance_area_lg_wind_01.vfx");
  level._effect["vfx_hms_fog_ambiance_indoor_sm_02"] = loadfx("vfx/iw7/levels/titan/new/vfx_fog_ambiance_area_indoor_sm_02.vfx");
  level._effect["vfx_hms_air_release_small"] = loadfx("vfx/iw7/levels/titan/new/vfx_air_release_small.vfx");
  level._effect["vfx_clouds_ship_arrival"] = loadfx("vfx/iw7/levels/titan/hot_landing/vfx_clouds_ship_arrival_01.vfx");
  level._effect["aa_turret_explosion"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_death_01.vfx");
  level._effect["vfx_tdi_burst_pipe_steam"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_tdi_burst_pipe_steam.vfx");
  level._effect["vfx_tdi_falling_dust_and_debris"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_tdi_falling_dust_and_debris.vfx");
  level._effect["vfx_tdi_exploding_sparks"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_tdi_exploding_sparks.vfx");
  level._effect["vfx_titan_jackal_flyout_cloud_run"] = loadfx("vfx/iw7/levels/titan/vfx_titan_jackal_flyout_cloud_run.vfx");
  level._effect["vfx_titan_jackal_flyout_cloud_close_thin"] = loadfx("vfx/iw7/levels/titan/vfx_titan_jackal_flyout_cloud_close_thin.vfx");
  level._effect["vfx_titan_mons_hotlanding_wisps_run"] = loadfx("vfx/iw7/levels/titan/vfx_titan_mons_hotlanding_wisps_run.vfx");
  level._effect["vfx_titan_mons_hotlanding_wisps"] = loadfx("vfx/iw7/levels/titan/vfx_titan_mons_hotlanding_wisps.vfx");
  level._effect["vfx_mons_hl_cannon_impact"] = loadfx("vfx/iw7/levels/titan/vfx_mons_hl_cannon_impact.vfx");
  level._effect["vfx_rtd_lingering_fire"] = loadfx("vfx/iw7/levels/titan/vfx_rtd_lingering_fire.vfx");
  level._effect["vfx_rtd_lingering_fire_small"] = loadfx("vfx/iw7/levels/titan/new/vfx_fire_lingering_lg_02.vfx");
  level._effect["scripted_jackal_rocket_impact"] = loadfx("vfx/iw7/levels/titan/impacts/vfx_imp_rocket_expl_jackal.vfx");
  level._effect["scripted_jackal_rocket_trail"] = loadfx("vfx/iw7/levels/titan/c12/vfx_titan_smktrail_ignite_c12_far.vfx");
  _id_0EEE::_id_FD90();
}