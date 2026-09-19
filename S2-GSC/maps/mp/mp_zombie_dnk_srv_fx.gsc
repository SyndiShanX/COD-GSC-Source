/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dnk_srv_fx.gsc
********************************************/

main() {
  level._effect["snow_chunk_impact"] = loadfx("vfx/weaponimpact/snow_chunk_impact");
  level._effect["water_splash_small"] = loadfx("vfx/water/water_splash_small");
  level._effect["snow_chunk_impact_small"] = loadfx("vfx/weaponimpact/snow_chunk_impact_small");
  level._effect["zmb_dnk_boat_water_pull"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_boat_water_pull");
  level._effect["zmb_dlc2_straub_death"] = loadfx("vfx/blood/zmb_dlc2_straub_death");
  level._effect["zmb_dlc2_straub_hit"] = loadfx("vfx/blood/zmb_dlc2_straub_hit");
  level._effect["zmb_dnk_altered_snowfall"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_snowfall");
  level._effect["zmb_isl_fog_freezer_gas_pocket"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_fog_freezer_gas_pocket");
  level._effect["zmb_isl_beach_fish_flop_rnr"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_beach_fish_flop_rnr");
  level._effect["zmb_dnk_altered_firebowl"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_firebowl");
  level._effect["dlc_zmb_dig02_fire_bowl_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl_sm");
  level._effect["zmb_dnk_altered_bloodfountain"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bloodfountain");
  level._effect["zmb_dnk_geistkraftexplode"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_geistkraftexplode");
  level._effect["zmb_dnk_steam_linger"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_steam_linger");
  level._effect["zmb_dnk_altered_geistkraft_suck"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_geistkraft_suck");
  level._effect["zmb_dnk_altered_geistkraft_edge"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_geistkraft_edge");
  level._effect["zmb_dnk_altered_bubbles_burst_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_burst_rnr");
  level._effect["zmb_dnk_altered_bubbles_burst"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_burst");
  level._effect["zmb_dnk_altered_bubbles_chld"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_chld");
  level._effect["zmb_dnk_altered_bubbles_debris"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_debris");
  level._effect["zmb_dnk_altered_bubbles"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles");
  level._effect["zmb_dnk_fish_energy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_fish_energy");
  level._effect["zmb_dnk_altered_sizzlerbolt"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_sizzlerbolt");
  level._effect["zmb_ber_fire_vista_lrg_blck_smk"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_fire_vista_lrg_blck_smk");
  level._effect["zmb_ber_fire_tank_ground"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_fire_tank_ground");
  level._effect["zmb_dnk_altered_fog_ring_chld"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fog_ring_chld");
  level._effect["zmb_dnk_altered_fog_ring"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fog_ring");
  level._effect["zmb_dnk_ship_tilt_vf"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ship_tilt_vf");
  level._effect["zmb_dnk_altered_ambient_energy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_ambient_energy");
  level._effect["zmb_dnk_altered_platform_mist"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_platform_mist");
  level._effect["zmb_dnk_foam_linger"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_foam_linger");
  level._effect["zmb_dnk_foam_flowing"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_foam_flowing");
  level._effect["zmb_red_flare_idle"] = loadfx("vfx/map/mp_zombie_berlin/zmb_red_flare_idle");
  level._effect["fire_licks_xsmall"] = loadfx("vfx/fire/fire_licks_xsmall");
  level._effect["zmb_dnk_uber_leak"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_leak");
  level._effect["zmb_dnk_uber_explode"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_explode");
  level._effect["test_effect"] = loadfx("vfx/test/test_fx");
  level._effect["zmb_jolts_out"] = loadfx("vfx/zombie/zmb_jolts_out");
  level._effect["ground_impact"] = LoadFX("vfx/zombie/zmb_ground_impact");

  level._effect["zmb_dnk_wind_snow_swirl"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_wind_snow_swirl");
  level._effect["zmb_dnk_spotlight_heavy_snow"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_spotlight_heavy_snow");
  level._effect["zmb_dnk_snow_attach_player_hvy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_snow_attach_player_hvy");
  level._effect["zmb_dnk_ground_snow_skitter_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ground_snow_skitter_rnr");
  level._effect["zmb_dnk_snow_chunks_falling_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_snow_chunks_falling_rnr");
  level._effect["mp_prague_falling_ledge_snow_runner"] = loadfx("vfx/map/mp_prauge/mp_prague_falling_ledge_snow_runner");

  level._effect["zmb_vent_steam"] = loadfx("vfx/map/mp_zombie_nest/zmb_vent_steam");
  level._effect["zmb_steam_pipe_leak_rnr"] = loadfx("vfx/map/mp_zombie_island/zmb_steam_pipe_leak_rnr");
  level._effect["zmb_dnk_steam_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_steam_lrg");

  level._effect["zmb_dnk_water_busted_pipe_metal"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_busted_pipe_metal");
  level._effect["zmb_dnk_water_busted_pipe"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_busted_pipe");
  level._effect["zmb_dnk_side_splashes_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_side_splashes_rnr");
  level._effect["zmb_dnk_mainship_upward_mist"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_mainship_upward_mist");
  level._effect["zmb_dnk_large_boat_splash_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_large_boat_splash_rnr");
  level._effect["falling_water_drip_runner_slow"] = loadfx("vfx/water/falling_water_drip_runner_slow");
  level._effect["falling_water_drip_runner_fast"] = loadfx("vfx/water/falling_water_drip_runner_fast");
  level._effect["falling_water_drip_central_fast"] = loadfx("vfx/water/falling_water_drip_central_fast");
  level._effect["falling_water_drip_line_lg_runner_fast"] = loadfx("vfx/water/falling_water_drip_line_lg_runner_fast");
  level._effect["zmb_dnk_water_leak_sm"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_sm");
  level._effect["zmb_dnk_water_leak_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_lrg");
  level._effect["zmb_dnk_water_leak_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_lrg");
  level._effect["zmb_dnk_water_leak_sm"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_sm");
  level._effect["zmb_dnk_water_foam_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_foam_lrg");

  level._effect["zmb_dnk_ice_drifting"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ice_drifting");
  level._effect["zmb_dnk_projector_lightbeam"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_projector_lightbeam");
  level._effect["zmb_dnk_floating_debri"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_floating_debri");
  level._effect["zmb_dnk_ambient_motes_interior"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ambient_motes_interior");
  level._effect["zmb_dnk_fog_wispy_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_fog_wispy_lrg");
  level._effect["zmb_plastic_shreds_sheet_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_plastic_shreds_sheet_1");
  level._effect["plastic_shreds_hanging_e"] = loadfx("vfx/wind/plastic_shreds_hanging_e");
  level._effect["plastic_shreds_hanging_d"] = loadfx("vfx/wind/plastic_shreds_hanging_d");
  level._effect["electrical_sparks_burst_runner"] = loadfx("vfx/map/mp_gibraltar/electrical_sparks_burst_runner");
  level._effect["fish_flop"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_floppy_fish");
  level._effect["geistkraft_poof"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftexplode_1");
  level._effect["fish_energy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_fish_energy");

  level._effect["trap_ready"] = LoadFX("vfx/zombie/zmb_trap_light_orange_small");
  level._effect["trap_not_ready"] = LoadFX("vfx/zombie/zmb_trap_light_orange_blink_small");
  level._effect["zmb_med_trap_gib"] = LoadFX("vfx/zombie/zmb_med_trap_gib");

  level._effect["water_jet"] = loadfx("vfx/water/water_jet");
  level._effect["boss_bomb_explode"] = loadfx("vfx/destructible/veh_sedan_police_explo_1_no_door");

  level._effect["spider_web_mesh"] = loadfx("vfx/unique/spider_web_mesh");
  level._effect["insects_flies_landing_sm"] = loadfx("vfx/animal/insects_flies_landing_sm");

  level._effect["zmb_dnk_altered_fake_tether"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fake_tether");
  level._effect["zmb_dnk_altered_fire_med"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fire_med");
  level._effect["zmb_dnk_altered_flare"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_flare");
  level._effect["zmb_dnk_altered_fog_ground"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fog_ground");
  level._effect["zmb_dnk_altered_flak"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_flak");
  level._effect["zmb_dnk_altered_smk_smolder"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_smk_smolder");
  level._effect["zmb_dnk_altered_fire_vertical"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fire_vertical");
  level._effect["zmb_dnk_altered_ash_cloud"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_ash_cloud");
  level._effect["zmb_dnk_altered_zepellin"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_zepellin");

  if(getDvar("3508") != "1")
    maps\createfx\mp_zombie_dnk_srv_fx::main();
}