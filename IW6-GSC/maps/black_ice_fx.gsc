/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_fx.gsc
*****************************************************/

main() {
  level._effect["water_drops_ground_hits"] = loadfx("vfx/moments/black_ice/vfx_water_drops_ground_hits");
  level._effect["snow_wind_spkcld_400"] = loadfx("vfx/moments/black_ice/snow_wind_spkcld_400");
  level._effect["snow_wind_spkcld_100"] = loadfx("vfx/moments/black_ice/snow_wind_spkcld_100");
  level._effect["large_woodhit_exit_cheaper"] = loadfx("fx/impacts/large_woodhit_exit_cheaper");
  level._effect["large_woodhit_cheaper"] = loadfx("fx/impacts/large_woodhit_cheaper");
  level._effect["water_splash_truck_large_black_ice"] = loadfx("vfx/moments/black_ice/water_splash_truck_large_black_ice");
  level._effect["water_splash_truck_oriented_black_ice"] = loadfx("vfx/moments/black_ice/water_splash_truck_oriented_black_ice");
  level._effect["water_drip_tire_black_ice"] = loadfx("vfx/moments/black_ice/water_drip_tire_black_ice");
  level._effect["water_splash_black_ice"] = loadfx("vfx/moments/black_ice/water_splash_black_ice");

  if(!getdvarint("r_reflectionProbeGenerate")) {
    maps\createfx\black_ice_fx::main();
    maps\createfx\black_ice_sound::main();
  }

  level._effect["underwater_blood_cloud_01"] = loadfx("vfx/moments/black_ice/underwater_blood_cloud_01");
  level._effect["snwmbl_taillamp"] = loadfx("vfx/gameplay/vehicles/snowmobile_iw6/snwmbl_iw6_taillamp");
  level._effect["snakecam_shmutz_02"] = loadfx("vfx/moments/black_ice/vfx_screen_snakecam_shmutz_02");
  level._effect["snakecam_shmutz_01"] = loadfx("vfx/moments/black_ice/vfx_screen_snakecam_shmutz_01");
  level._effect["slow_veh_treadfx_snow"] = loadfx("vfx/moments/black_ice/vfx_veh_treadfx_snow_emit_slw_blkice");
  level._effect["veh_treadfx_snow"] = loadfx("vfx/moments/black_ice/vfx_veh_treadfx_snow_emit_blkice");
  level._effect["heli_spotlight"] = loadfx("vfx/moments/black_ice/vfx_spotlight_heli_model");
  level._effect["glow_cone_cloudy_dust_01"] = loadfx("vfx/moments/black_ice/vfx_glow_cone_cloudy_dust_01");
  level._effect["glow_tv_small_01"] = loadfx("vfx/moments/black_ice/vfx_glow_tv_small_01");
  level._effect["glow_tv_med_01"] = loadfx("vfx/moments/black_ice/vfx_glow_tv_med_01");
  level._effect["glow_flourescent_bulb_01"] = loadfx("vfx/moments/black_ice/vfx_glow_flourescent_bulb_01");
  level._effect["glow_tv_large_flicker"] = loadfx("vfx/moments/black_ice/vfx_glow_tv_large_flicker");
  level._effect["flare_light_yllwgrn_square_cone1"] = loadfx("vfx/moments/black_ice/vfx_flare_light_yllwgrn_square_cone1");
  level._effect["smk_hanging_gray_01"] = loadfx("vfx/moments/black_ice/vfx_smk_hanging_gray_01_before");
  level._effect["smk_hanging_orange_01"] = loadfx("vfx/moments/black_ice/vfx_smk_hanging_orange_01_before");
  level._effect["vfx_rig_fire_exfil_huge"] = loadfx("vfx/moments/black_ice/vfx_rig_fire_exfil_huge");
  level._effect["exfil_light_explode"] = loadfx("fx/explosions/sparks_light_explode_blackice");
  level._effect["flarestack_siren_red"] = loadfx("fx/lights/siren_light_red_big");
  level._effect["command_siren_red"] = loadfx("fx/lights/siren_light_red_static");
  level._effect["command_siren_red_low"] = loadfx("fx/lights/siren_light_red_static_low");
  level._effect["oil_rain_pipedeck"] = loadfx("fx/misc/blackice_oil_rain_pipedeck");
  level._effect["steam_flamestack_shutdown"] = loadfx("vfx/moments/black_ice/vfx_flarestack_pipeburst_sequence_01");
  level._effect["flamestack_hand_Scan"] = loadfx("fx/misc/blackice_hand_scan");
  level._effect["flamestack_snow_door_open"] = loadfx("fx/misc/blackice_snow_door_open");
  level._effect["refinery_pipe_explosion_small"] = loadfx("fx/explosions/blackice_refinery_prederrick_small");
  level._effect["refinery_pipe_explosion_large"] = loadfx("fx/explosions/blackice_refinery_prederrick_large");
  level._effect["exfil_steam_burst"] = loadfx("fx/smoke/steam_jet_large_blackice");
  level._effect["exfil_steam_small"] = loadfx("fx/smoke/blackice_steam_engineroom_small");
  level._effect["exfil_wall_alarm_yellow"] = loadfx("fx/misc/blackice_wall_alarm_yellow");
  level._effect["smoke_doorway_windy"] = loadfx("fx/smoke/doorway_smoke_windy_blackice");
  level._effect["fire_tanks_pipefire_windy"] = loadfx("fx/fire/blackice_oil_pipe_fire_windy");
  level._effect["tanks_fire_huge"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_windy_fireball_large_01");
  level._effect["icehole_light"] = loadfx("fx/misc/blackice_icehole_light");
  level._effect["icehole_godray"] = loadfx("vfx/ambient/lights/vfx_godray_underice_anim");
  level._effect["hind_turret_impacts"] = loadfx("fx/impacts/hind_turret_blackice_runner");
  level._effect["exfil_view_explosion"] = loadfx("fx/explosions/blackice_exfil_viewscreen_explosion");
  level._effect["exfil_command_fail_blast"] = loadfx("fx/explosions/blackice_explosion_large");
  level._effect["console_command_start"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_start");
  level._effect["console_command_timer"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_timer");
  level._effect["console_command_green_u"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_green_u");
  level._effect["console_command_green_d"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_green_d");
  level._effect["console_command_yellow_u"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_yellow_u");
  level._effect["console_command_yellow_d"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_yellow_d");
  level._effect["console_command_red_u"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_red_u");
  level._effect["console_command_red_d"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_red_d");
  level._effect["console_command_end"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_end");
  level._effect["console_command_fail"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_fail");
  level._effect["command_control_explosion"] = loadfx("fx/explosions/blackice_refinery_oiltank_huge");
  level._effect["command_console_baker"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_baker");
  level._effect["command_console_baker_sm"] = loadfx("vfx/moments/black_ice/vfx_console_command_display_baker_sm");
  level._effect["hind_shell_eject"] = loadfx("fx/shellejects/hind_turret_shell_blackice");
  level._effect["breacher_light_green"] = loadfx("fx/misc/light_breacher_green");
  level._effect["breacher_light_red"] = loadfx("fx/misc/light_breacher_red");
  level._effect["truck_underside"] = loadfx("vfx/moments/black_ice/blackice_bouncelight_undertruck");
  level._effect["exfil_rigcollapse_splash"] = loadfx("vfx/moments/black_ice/vfx_rigcollapse_splash");
  level._effect["exfil_sphere_trail"] = loadfx("fx/smoke/blackice_exfil_sphere_trail");
  level._effect["ice_breach_explosion"] = loadfx("fx/explosions/underwater_breach_charge_large_blackice");
  level._effect["ice_breach_collapse"] = loadfx("fx/misc/underwater_ice_collapse");
  level._effect["glowstick_orange"] = loadfx("fx/misc/glow_stick_glow_orange_blackice");
  level._effect["glowstick_orange_dlight"] = loadfx("fx/misc/glow_stick_glow_orange_blackice_dlight");
  level._effect["snake_cam_waterline_under"] = loadfx("vfx/moments/black_ice/vfx_screen_snakecam_tunnel_01");
  level._effect["scuba_bubbles"] = loadfx("vfx/moments/ship_graveyard/scuba_bubbles_plr_front");
  level._effect["scuba_bubbles_friendly"] = loadfx("vfx/ambient/water/bubbles_breath_hero");
  level._effect["scuba_mask_distortion"] = loadfx("vfx/moments/ship_graveyard/scuba_mask_distortion");
  level._effect["swim_kick_bubble"] = loadfx("vfx/gameplay/footsteps/swim_kick_bubbles");
  level._effect["swim_ai_blood_impact"] = loadfx("fx/water/blood_spurt_underwater");
  level._effect["swim_ai_death_blood"] = loadfx("fx/impacts/deathfx_bloodpool_underwater");
  level._effect["water_particulate_01"] = loadfx("fx/water/ocean_particulate_dark");
  level._effect["mine_light"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_100_blinker_undrwater");
  level._effect["water_bubble_cloud_descent_med"] = loadfx("vfx/moments/black_ice/underwater_gascloud_med_emit");
  level._effect["snow_blowoff_edge_small"] = loadfx("vfx/moments/black_ice/vfx_snow_blowoff_edge_small_black_ice");
  level._effect["snow_wind"] = loadfx("vfx/moments/black_ice/snow_wind_black_ice");
  level._effect["cold_breath"] = loadfx("fx/misc/cold_breath_cheap");
  level._effect["snow_wind_fast"] = loadfx("vfx/moments/black_ice/vfx_snow_wind_fast_black_ice");
  level._effect["snow_wind_fast_short"] = loadfx("vfx/moments/black_ice/vfx_snow_wind_fast_short_black_ice");
  level._effect["snow_wind_tanks"] = loadfx("fx/snow/snow_wind_tanks_blackice");
  level._effect["snow_wind_catwalks"] = loadfx("fx/snow/snow_wind_catwalks_blackice");
  level._effect["snow_wind_ascend_huge"] = loadfx("fx/snow/snow_wind_ascend_huge_blackice");
  level._effect["snow_wind_catwalks_windtunnel"] = loadfx("fx/snow/snow_wind_catwalks_windtunnel_blackice");
  level._effect["snow_drift_heavy_short"] = loadfx("vfx/moments/black_ice/vfx_snow_drift_oriented_heavy_short");
  level._effect["snow_drift_heavy"] = loadfx("vfx/moments/black_ice/vfx_snow_drift_oriented_heavy");
  level._effect["catwalks_snow_door_open"] = loadfx("fx/misc/blackice_snow_door_open_inward");
  level._effect["catwalks_snow_door_open_ground"] = loadfx("fx/misc/blackice_snow_door_open_inward_ground");
  level._effect["snow_blowoff_ledge_loop_heavy"] = loadfx("fx/snow/snow_blowoff_ledge_oriented_heavy");
  level._effect["shockwave_snow_disturb"] = loadfx("fx/misc/blackice_snow_shockwave_disturb");
  level._effect["shockwave_snow_disturb_small"] = loadfx("fx/misc/blackice_snow_shockwave_disturb_small");
  level._effect["shockwave_snow_disturb_huge"] = loadfx("fx/misc/blackice_snow_shockwave_disturb_huge");
  level._effect["headlight_bm21_underwater"] = loadfx("vfx/moments/black_ice/headlight_bm21_underwater");
  level._effect["headlight_bm21_underwater_flicker"] = loadfx("vfx/moments/black_ice/headlight_bm21_underwater_flicker");
  level._effect["headlight_gaz_underwater"] = loadfx("vfx/moments/black_ice/headlight_gaz_underwater");
  level._effect["vehicle_gaz_brakelight"] = loadfx("fx/misc/car_taillight_btr80_eye");
  level._effect["vehicle_bm21_brakelight"] = loadfx("fx/misc/car_brakelight_bm21");
  level._effect["vfx_aircraft_light_red_blink_fog"] = loadfx("vfx/moments/black_ice/vfx_aircraft_light_red_blink_fog");
  level._effect["vfx_aircraft_light_white_blink_fog"] = loadfx("vfx/moments/black_ice/vfx_aircraft_light_white_blink_fog");
  level._effect["vfx_aircraft_light_green_blink_fog"] = loadfx("vfx/moments/black_ice/vfx_aircraft_light_green_blink_fog");
  level._effect["catwalk_det_tape"] = loadfx("fx/explosions/door_breach_metal_tape_blackice");
  level._effect["common_breach_charge"] = loadfx("fx/explosions/blackice_commonroom_breach");
  level._effect["common_breach_damaged_breacher"] = loadfx("fx/misc/blackice_damaged_breacher");
  level._effect["derrick_explode_small"] = loadfx("fx/explosions/oil_derrick_explosion_02");
  level._effect["derrick_explode_large"] = loadfx("vfx/moments/black_ice/vfx_oil_derrick_explosion_01");
  level._effect["derrick_dirt_shockwave"] = loadfx("fx/explosions/oil_derrick_collapse_shockwave");
  level._effect["smoke_blowing_gray_large"] = loadfx("fx/smoke/smoke_large_cheap_grey");
  level._effect["smoke_blowing_hot_large"] = loadfx("fx/smoke/smoke_large_hot");
  level._effect["smoke_blowing_white_white"] = loadfx("fx/smoke/steam_vent_large_windslow");
  level._effect["smoke_blowing_white_white_2"] = loadfx("vfx/ambient/smoke/vfx_steam_stack_blowing_drkprpl_1");
  level._effect["smoke_blowing_white_2_shockwave"] = loadfx("vfx/ambient/smoke/vfx_steam_stack_blown_drkprpl_1");
  level._effect["red_light_derrick_01"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_200_nolight");
  level._effect["red_light_derrick_oscillator_01"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_200_oscillate_nolight");
  level._effect["red_light_derrick_blinking_01"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_400_blinker_nolight");
  level._effect["blue_light_derrick_01"] = loadfx("vfx/ambient/lights/vfx_glow_blue_light_200_nolight");
  level._effect["warm_light_derrick_01"] = loadfx("vfx/ambient/lights/vfx_warm_light_oriented_square_nolight");
  level._effect["flesh_hit"] = loadfx("fx/impacts/flesh_hit");
  level._effect["catwalk_spot"] = loadfx("vfx/moments/black_ice/vfx_spotlight_heli_model");
  level._effect["catwalk_spot_cheap"] = loadfx("vfx/moments/black_ice/vfx_spotlight_search_snow_cheap");
  level._effect["fire_sputter_med"] = loadfx("fx/fire/oil_fire_suppressed");
  level._effect["fire_oil_burnoff_01"] = loadfx("fx/fire/oil_burnoff");
  level._effect["fire_oil_burnoff_extinguish"] = loadfx("fx/fire/oil_burnoff_extinguish");
  level._effect["water_sprinkler_01"] = loadfx("vfx/ambient/water/water_sprinkler_high_pressure");
  level._effect["fire_burning_oil_patch_01"] = loadfx("fx/fire/burning_oil_patch");
  level._effect["fire_falling_point"] = loadfx("vfx/ambient/fire/dripping/vfx_fire_falling_runner_pnt_2");
  level._effect["smoke_dark_large_cloud"] = loadfx("fx/smoke/dark_smoke_cloud_large_blackice");
  level._effect["fire_grounded_med_01"] = loadfx("vfx/ambient/fire/vfx_fire_grounded_med_nxglight");
  level._effect["fire_grounded_large_01"] = loadfx("vfx/ambient/fire/vfx_fire_grounded_large_nxglight");
  level._effect["sparks_twisty_blown_500x1000"] = loadfx("vfx/ambient/sparks/vfx_sparks_twisty_blown_500x1000");
  level._effect["fire_grounded_xtralarge"] = loadfx("vfx/ambient/fire/vfx_fire_grounded_xtralarge_nxglight");
  level._effect["fire_ceiling_large_fade_01"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_lg_nofog_ae_fade");
  level._effect["fire_ceiling_large_01"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_lg");
  level._effect["fire_fireball_hall_large_01"] = loadfx("vfx/moments/black_ice/vfx_fireball_hall_blocking_large");
  level._effect["fire_fireball_med_01"] = loadfx("fx/fire/blackice_fireball_med");
  level._effect["fire_glow_med_01"] = loadfx("vfx/ambient/lights/vfx_glow_fire_200_nolight_ae");
  level._effect["fire_grounded_engine_room"] = loadfx("fx/fire/blackice_fire_grounded_engine_room");
  level._effect["fire_supression_pipedeck"] = loadfx("fx/water/blackice_fire_supression");
  level._effect["fire_supression_shutdown_a"] = loadfx("fx/water/blackice_fire_supression_shutdown_a");
  level._effect["fire_supression_shutdown_b"] = loadfx("fx/water/blackice_fire_supression_shutdown_b");
  level._effect["fire_supression_shutdown_c"] = loadfx("fx/water/blackice_fire_supression_shutdown_c");
  level._effect["fire_supression_shutdown_d"] = loadfx("fx/water/blackice_fire_supression_shutdown_d");
  level._effect["fire_supression_shutdown_e"] = loadfx("fx/water/blackice_fire_supression_shutdown_e");
  level._effect["fire_supression_shutdown_f"] = loadfx("fx/water/blackice_fire_supression_shutdown_f");
  level._effect["steam_jet_medium_01"] = loadfx("vfx/moments/black_ice/vfx_steam_pipe_burst_linger_01");
  level._effect["refinery_debris_explosion"] = loadfx("vfx/gameplay/explosions/vfx_exp_oiltank_lg");
  level._effect["refinery_debris_trail_large"] = loadfx("fx/smoke/blackice_debris_trail_large");
  level._effect["refinery_debris_trail_small"] = loadfx("fx/smoke/blackice_debris_trail_small");
  level._effect["refinery_debris_smolder_large"] = loadfx("vfx/ambient/fire/debris_smolder_large");
  level._effect["refinery_debris_smolder_small"] = loadfx("fx/fire/blackice_debris_smolder_small");
  level._effect["refinery_debris_fire_oiltank"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_burning_tank_fireball_01");
  level._effect["refinery_debris_sparks_01"] = loadfx("vfx/moments/black_ice/vfx_tb_metal_sparks_trail");
  level._effect["refinery_debris_tb_impact_01"] = loadfx("vfx/moments/black_ice/vfx_tb_metal_impact_sparks_large");
  level._effect["oil_geyser_01"] = loadfx("fx/fire/oil_geyser_burning");
  level._effect["oil_spots_01"] = loadfx("fx/impacts/oil_spots_growing_decal_1");
  level._effect["oil_rain_500"] = loadfx("vfx/ambient/liquids/vfx_oil_rain_500");
  level._effect["oil_rain_500_outdoor"] = loadfx("vfx/ambient/liquids/vfx_oil_rain_500_outdoor");
  level._effect["oil_rain_500_heavy_outdoor"] = loadfx("vfx/ambient/liquids/vfx_oil_rain_500_outdoor_heavy");
  level._effect["oil_droplet_imapcts_50"] = loadfx("vfx/ambient/liquids/vfx_oil_droplet_impacts_50");
  level._effect["oil_droplet_imapcts_100"] = loadfx("vfx/ambient/liquids/vfx_oil_droplet_impacts_100");
  level._effect["oil_droplet_imapcts_200"] = loadfx("vfx/ambient/liquids/vfx_oil_droplet_impacts_200");
  level._effect["oil_droplet_imapcts_heavy_200"] = loadfx("vfx/ambient/liquids/vfx_oil_droplet_impacts_heavy_200");
  level._effect["oil_rain_500_heavy"] = loadfx("vfx/moments/black_ice/vfx_oil_rain_500_heavy");
  level._effect["smoke_doorway_01"] = loadfx("fx/smoke/doorway_smoke_thick_blackice");
  level._effect["smoke_tanks_pipe"] = loadfx("fx/smoke/blackice_tanks_pipe_smoke");
  level._effect["smoke_hallway_01"] = loadfx("fx/smoke/hallway_smoke_thick_blackice");
  level._effect["obscuring_haze_playerview"] = loadfx("vfx/moments/black_ice/vfx_obscuring_haze_playerview");
  level._effect["heli_smoke_01"] = loadfx("fx/smoke/smoke_swirl_heli_flyin");
  level._effect["console_light_blink"] = loadfx("fx/misc/light_console_blink");
  level._effect["pistol_muzzleflash"] = loadfx("fx/muzzleflashes/pistolflash");
  level._effect["pistol_shot_smoke"] = loadfx("vfx/moments/black_ice/vfx_smk_puff_flash");
  level._effect["headshot_blood"] = loadfx("fx/maps/dubai/yuri_headshot_blood");
  level._effect["flarestack_console_01"] = loadfx("vfx/moments/black_ice/vfx_console_flarestack_display_01");
  level._effect["flarestack_console_02"] = loadfx("vfx/moments/black_ice/vfx_console_flarestack_display_02");
  level._effect["flarestack_console_01_sm"] = loadfx("vfx/moments/black_ice/vfx_console_flarestack_display_01_sm");
  level._effect["flarestack_console_02_sm"] = loadfx("vfx/moments/black_ice/vfx_console_flarestack_display_02_sm");
  level._effect["flarestack_bloodsplatter_window"] = loadfx("vfx/moments/black_ice/vfx_blood_splatter_drips_oriented_01");
  level._effect["tanks_pipe_trail"] = loadfx("fx/smoke/blackice_tanks_pipe_trail");
  level._effect["fire_extinguisher_spray"] = loadfx("vfx/moments/black_ice/fire_extinguisher_spray_engineroom");
  level._effect["bokeh_splats_01"] = loadfx("vfx/gameplay/screen_effects/vfx_screen_bokeh_splats_add_01");
  level._effect["bokeh_fieryflash_01"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_fiery_bokeh_flash_01");
  level._effect["pipedeck_heat_haze2"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_heat_haze_2");
  level._effect["pipedeck_heat_haze3"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_heat_haze_3");
  level._effect["pipedeck_heat_haze4"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_heat_haze_4");
  level._effect["pipedeck_heat_haze5"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_heat_haze_5");
  level._effect["raindrops_screen_3"] = loadfx("vfx/gameplay/screen_effects/raindrops_screen_3");
  level._effect["raindrops_screen_5"] = loadfx("vfx/gameplay/screen_effects/raindrops_screen_5");
  level._effect["raindrops_screen_10"] = loadfx("vfx/gameplay/screen_effects/raindrops_screen_10");
  level._effect["raindrops_screen_20"] = loadfx("vfx/gameplay/screen_effects/raindrops_screen_20");
  level._effect["oildrops_screen_3"] = loadfx("vfx/gameplay/screen_effects/oildrops_screen_3");
  level._effect["oildrops_screen_5"] = loadfx("vfx/gameplay/screen_effects/oildrops_screen_5");
  level._effect["oildrops_screen_10"] = loadfx("vfx/gameplay/screen_effects/oildrops_screen_10");
  level._effect["oildrops_screen_20"] = loadfx("vfx/gameplay/screen_effects/oildrops_screen_20");
  level._effect["snakecam_static"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_snakecam_static");
  level._effect["snakecam_on"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_snakecam_on");
  level._effect["heli_spotlight_bright"] = loadfx("fx/misc/blackice_spotlight_model_superbright");
  level._effect["heli_spotlight_bright_fade"] = loadfx("fx/misc/blackice_spotlight_model_superbright_fade");
  level._effect["command_window_light"] = loadfx("vfx/moments/black_ice/vfx_command_center_window_lighting");
  level._effect["electrical_sparks_med_rndm_loop"] = loadfx("vfx/ambient/sparks/electrical_sparks_med_rndm_loop");
  level._effect["paper_blowing_stack_vortex"] = loadfx("fx/misc/paper_blowing_stack_vortex");
  level._effect["exfil_fire"] = loadfx("vfx/moments/black_ice/vfx_fire_ground_exfil");
  level._effect["smoke_plume_thick_blk_01"] = loadfx("fx/smoke/smoke_thick_black_plume_fat");
  level._effect["player_view_smoke"] = loadfx("fx/smoke/blackice_view_smoke");
  level._effect["exfil_xplosion_huge"] = loadfx("vfx/moments/black_ice/vfx_rig_fire_exfil_xplosion_huge");
  level._effect["exfil_xplosion_huger"] = loadfx("vfx/moments/black_ice/vfx_rig_fire_exfil_xplosion_huger");
  level._effect["explosion_oiltank_lg"] = loadfx("vfx/gameplay/explosions/vfx_exp_oiltank_lg");
  level._effect["water_wake_med"] = loadfx("vfx/moments/black_ice/vfx_water_wake_med");
  level._effect["exfil_xplosion_shockwave"] = loadfx("vfx/moments/black_ice/vfx_exfil_xplosion_shockwave");
  level._effect["vfx_perif_smkfire_plume_5k_b4"] = loadfx("vfx/ambient/skybox/vfx_perif_smkfire_plume_5k_b4");
  level._effect["perif_smk_plume_01"] = loadfx("vfx/ambient/smoke/vfx_smk_perif_plume_auroralit_large_01");
  level._effect["flare_light_med_orange1_cone1_snw1"] = loadfx("vfx/moments/black_ice/vfx_flare_light_med_orange1_cone1_sn1");
  level._effect["flare_light_med_orange1_cone1"] = loadfx("vfx/moments/black_ice/vfx_flare_light_med_orange1_cone1");
  level._effect["flare_light_med_orange1"] = loadfx("vfx/moments/black_ice/vfx_flare_light_med_orange1");
  level._effect["flare_light_med_cwhite1_cone1_snw1"] = loadfx("vfx/moments/black_ice/vfx_flare_light_med_cwhite1_cone1_sn1");
  level._effect["flare_light_med_cwhite1_cone1"] = loadfx("vfx/moments/black_ice/vfx_flare_light_med_cwhite1_cone1");
  level._effect["flare_light_med_cwhite1"] = loadfx("vfx/moments/black_ice/vfx_flare_light_med_cwhite1");
}

fx_init() {
  common_scripts\utility::flag_init("flag_fx_player_watersheeting");
  common_scripts\utility::flag_init("flag_fx_screen_raindrops");
  common_scripts\utility::flag_init("flag_fx_screen_oildrops");
  common_scripts\utility::flag_init("flag_fx_screen_bokehdots_rain");
  level thread fx_screen_bokehdots_rain();
}

create_view_particle_source() {
  if(!isDefined(level.view_particle_source)) {
    level.view_particle_source = spawn("script_model", (0, 0, 0));
    level.view_particle_source setModel("tag_origin");
    level.view_particle_source.origin = level.player.origin;
    level.view_particle_source linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  }
}

create_view_particle_source_alt() {
  if(!isDefined(level.view_particle_source_alt)) {
    level.view_particle_source_alt = spawn("script_model", (0, 0, 0));
    level.view_particle_source_alt setModel("tag_origin");
    level.view_particle_source_alt.origin = level.player.origin;
    level.view_particle_source_alt linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  }
}

fx_intro_friendly_glowsticks() {
  common_scripts\utility::flag_wait("flag_snake_cam_below_water");
  playFXOnTag(common_scripts\utility::getfx("glowstick_orange"), self, "J_glowstick_fx");
  playFXOnTag(common_scripts\utility::getfx("glowstick_orange_dlight"), self, "J_glowstick_fx");
  common_scripts\utility::flag_wait("flag_swim_breach_detonate");
  stopFXOnTag(common_scripts\utility::getfx("glowstick_orange_dlight"), self, "J_glowstick_fx");
}

setup_footstep_fx() {
  level._effect["footstep_snow"] = loadfx("vfx/moments/black_ice/char_treadfx_snow_blkice");
  level._effect["footstep_snow_small"] = loadfx("vfx/moments/black_ice/char_treadfx_snow_blkice");
  animscripts\utility::setfootstepeffect("snow", level._effect["footstep_snow"]);
  animscripts\utility::setfootstepeffectsmall("snow", level._effect["footstep_snow_small"]);
  level.player thread maps\_utility::playersnowfootsteps();
}

intro_turn_on_vehicle_drive_in_treadfx() {
  level.vehicles_no_breach["snowmobile_1"] thread turn_on_snowmobile_treadfx();
  level.vehicles_no_breach["snowmobile_2"] thread turn_on_snowmobile_treadfx();
  level.breach_vehicles["bm21_1"] thread turn_on_tatra_treadfx();
  level.breach_vehicles["bm21_2"] thread turn_on_tatra_treadfx();
  level.breach_vehicles["gaz71"] thread turn_on_tatra_treadfx();
  level.vehicles_no_breach["bm21_3"] thread turn_on_tatra_treadfx();
  level.breach_vehicles["gaztiger"] thread turn_on_lnyx_treadfx();
}

turn_on_snowmobile_treadfx() {
  self endon("death");
  playFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_back_right");
  playFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_back_left");
  wait(level.timestep);
  playFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_front_right");
  playFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_front_left");
  wait(level.timestep);
  playFXOnTag(level._effect["snwmbl_taillamp"], self, "origin_animate_jnt");
  playFXOnTag(level._effect["snwmbl_taillamp"], self, "origin_animate_jnt");
  level waittill("flag_snake_cam_below_water");
  stopFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_back_right");
  stopFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_back_left");
  wait(level.timestep);
  stopFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_front_right");
  stopFXOnTag(level._effect["veh_treadfx_snow"], self, "tag_wheel_front_left");
  wait(level.timestep);
  stopFXOnTag(level._effect["snwmbl_taillamp"], self, "origin_animate_jnt");
  stopFXOnTag(level._effect["snwmbl_taillamp"], self, "origin_animate_jnt");
}

turn_on_lnyx_treadfx() {
  self endon("death");
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_right");
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_left");
  wait(level.timestep);
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_right");
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_left");
  wait(level.timestep);
  playFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_brakelight_left");
  playFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_brakelight_right");
  level waittill("flag_snake_cam_below_water");
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_right");
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_left");
  wait(level.timestep);
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_right");
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_left");
  wait(level.timestep);
  stopFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_brakelight_left");
  stopFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_brakelight_right");
}

turn_on_tatra_treadfx() {
  self endon("death");
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_right");
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_left");
  wait(level.timestep);
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_right");
  playFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_left");
  wait(level.timestep);
  playFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_taillight_left");
  playFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_taillight_right");
  level waittill("flag_snake_cam_below_water");
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_right");
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_back_left");
  wait(level.timestep);
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_right");
  stopFXOnTag(level._effect["slow_veh_treadfx_snow"], self, "tag_wheel_front_left");
  wait(level.timestep);
  stopFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_taillight_left");
  stopFXOnTag(level._effect["vehicle_gaz_brakelight"], self, "tag_taillight_right");
}

snake_cam_fx() {
  create_view_particle_source();
  thread fx_snakecam_lens_shmutz();
  playFXOnTag(common_scripts\utility::getfx("snakecam_static"), level.view_particle_source, "tag_origin");
  common_scripts\utility::exploder("intro_snakecam");
  level waittill("notify_snakecam_on");
  playFXOnTag(common_scripts\utility::getfx("snakecam_on"), level.view_particle_source, "tag_origin");
  level waittill("notify_underwater_transition");
  maps\_utility::stop_exploder("intro_snakecam");
  killfxontag(common_scripts\utility::getfx("snakecam_static"), level.view_particle_source, "tag_origin");
}

fx_snakecam_lens_shmutz() {
  create_view_particle_source_alt();
  var_0 = level.view_particle_source_alt;
  level waittill("notify_rumble_truck_1");
  wait 0.2;
  playFXOnTag(level._effect["snakecam_shmutz_01"], var_0, "tag_origin");
  level waittill("notify_rumble_truck_2");
  wait 0.2;
  playFXOnTag(level._effect["snakecam_shmutz_01"], var_0, "tag_origin");
  level waittill("notify_rumble_truck_3");
  wait 0.2;
  playFXOnTag(level._effect["snakecam_shmutz_01"], var_0, "tag_origin");
  level waittill("notify_rumble_cam_3");
  wait 0.2;
  playFXOnTag(level._effect["snakecam_shmutz_02"], var_0, "tag_origin");
  level waittill("flag_snake_cam_below_water");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

intro_turn_on_vehicle_underwater_lights_fx() {
  thread turn_on_gaztiger_underwater_lights_fx();
  thread turn_on_gaztiger_underwater_bubble_fx();
  thread turn_on_bm21_underwater_bubble_fx();
  wait 5.0;
  thread turn_on_bm21_2_underwater_lights_fx();
  wait 15.0;
  thread turn_off_bm21_2_underwater_lights_fx();
}

turn_on_gaztiger_underwater_lights_fx() {
  playFXOnTag(level._effect["headlight_gaz_underwater"], level.breach_vehicles["gaztiger"], "tag_headlight_left");
  playFXOnTag(level._effect["headlight_gaz_underwater"], level.breach_vehicles["gaztiger"], "tag_headlight_right");
  wait(level.timestep);
  playFXOnTag(level._effect["vehicle_gaz_brakelight"], level.breach_vehicles["gaztiger"], "tag_brakelight_left");
  playFXOnTag(level._effect["vehicle_gaz_brakelight"], level.breach_vehicles["gaztiger"], "tag_brakelight_right");
}

turn_on_gaztiger_underwater_bubble_fx() {
  wait(level.timestep);
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_back_right");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_back_left");
  wait(level.timestep);
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_front_right");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_front_left");
  wait(level.timestep);
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_antenna");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_brakelight_left");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_brakelight_right");
}

turn_off_gaztiger_underwater_lights_fx() {
  stopFXOnTag(level._effect["headlight_gaz_underwater"], level.breach_vehicles["gaztiger"], "tag_headlight_left");
  stopFXOnTag(level._effect["headlight_gaz_underwater"], level.breach_vehicles["gaztiger"], "tag_headlight_right");
  wait(level.timestep);
  stopFXOnTag(level._effect["vehicle_gaz_brakelight"], level.breach_vehicles["gaztiger"], "tag_brakelight_left");
  stopFXOnTag(level._effect["vehicle_gaz_brakelight"], level.breach_vehicles["gaztiger"], "tag_brakelight_right");
}

turn_on_bm21_2_underwater_lights_fx() {
  wait(level.timestep);
  playFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_2"], "tag_taillight_left");
  playFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_2"], "tag_taillight_right");
  wait(level.timestep);
  playFXOnTag(level._effect["headlight_bm21_underwater"], level.breach_vehicles["bm21_2"], "tag_headlight_right");
  playFXOnTag(level._effect["headlight_bm21_underwater"], level.breach_vehicles["bm21_2"], "tag_headlight_left");
}

turn_on_bm21_underwater_bubble_fx() {
  wait(level.timestep);
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_back_right");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_back_left");
  wait 5.0;
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_front_right");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_wheel_front_left");
  wait(level.timestep);
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_brakelight_left");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], level.breach_vehicles["gaztiger"], "tag_brakelight_right");
}

turn_off_bm21_2_underwater_lights_fx() {
  stopFXOnTag(level._effect["headlight_bm21_underwater"], level.breach_vehicles["bm21_2"], "tag_headlight_right");
  playFXOnTag(level._effect["headlight_bm21_underwater_flicker"], level.breach_vehicles["bm21_2"], "tag_headlight_right");
  wait 0.01;
  stopFXOnTag(level._effect["headlight_bm21_underwater"], level.breach_vehicles["bm21_2"], "tag_headlight_left");
  playFXOnTag(level._effect["headlight_bm21_underwater_flicker"], level.breach_vehicles["bm21_2"], "tag_headlight_left");
  wait(level.timestep);
  stopFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_2"], "tag_taillight_left");
  stopFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_2"], "tag_taillight_right");
}

intro_turn_on_prop_bm21_1_lights_fx() {
  wait 0.01;
  playFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_1"], "tag_taillight_left");
  playFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_1"], "tag_taillight_right");
}

intro_turn_off_prop_bm21_1_lights_fx() {
  stopFXOnTag(level._effect["vehicle_bm21_headlight"], level.breach_vehicles["bm21_1"], "tag_headlight_right");
  stopFXOnTag(level._effect["vehicle_bm21_headlight"], level.breach_vehicles["bm21_1"], "tag_headlight_left");
  stopFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_1"], "tag_taillight_left");
  wait 0.01;
  stopFXOnTag(level._effect["vehicle_bm21_brakelight"], level.breach_vehicles["bm21_1"], "tag_taillight_right");
}

intro_detonation_sequence_fx() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 linkto(level.breach_mines[1], "tag_fx", (0, 0, 0), (-90, 0, 0));
  playFXOnTag(level._effect["ice_breach_explosion"], var_0, "tag_origin");
  level.player playrumbleonentity("grenade_rumble");
  wait 0.2;
  level.player playrumbleonentity("grenade_rumble");
  wait 0.25;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(level.breach_mines[0], "tag_fx", (0, 0, 0), (-90, 0, 0));
  playFXOnTag(level._effect["ice_breach_explosion"], var_1, "tag_origin");
  level.player playrumbleonentity("grenade_rumble");
  wait 0.2;
  common_scripts\utility::exploder("underwater_blood_cloud");
}

fx_camp_truck_submerge() {
  playFXOnTag(level._effect["vehicle_bm21_brakelight"], level.surface_truck, "tag_taillight_left");
  playFXOnTag(level._effect["vehicle_bm21_brakelight"], level.surface_truck, "tag_taillight_right");
  thread fx_camp_truck_submerge_front();
  thread fx_camp_truck_submerge_rear();
  thread fx_camp_truck_submerge_body();
}

fx_camp_truck_submerge_front() {
  var_0 = level.surface_truck gettagorigin("tag_wheel_front_left");
  var_1 = anglesToForward(level.surface_truck.angles - (-90, 0, 0));
  var_2 = anglesToForward(level.surface_truck.angles - (0, 0, 0));
  wait 5.0;

  for(var_3 = 0; var_3 < 12; var_3++) {
    playFX(level._effect["water_splash_black_ice"], var_0 + (0, 0, 22), var_1, var_2);
    wait(randomfloatrange(1.0, 1.5));
  }
}

fx_camp_truck_submerge_rear() {
  level.surface_truck_rear = common_scripts\utility::spawn_tag_origin();
  wait 5.0;
  level.surface_truck_rear = common_scripts\utility::spawn_tag_origin();
  level.surface_truck_rear linkto(level.surface_truck, "tag_wheel_back_left", (0, 0, 0), (-100, 0, 0));
  var_0 = level.surface_truck gettagorigin("tag_wheel_back_left");
  var_1 = anglesToForward(level.surface_truck.angles + (-100, 0, 0));
  var_2 = anglestoup(level.surface_truck.angles + (0, 0, 0));

  for(var_3 = 0; var_3 < 1; var_3++) {
    playFX(level._effect["water_splash_truck_large_black_ice"], var_0 + (0, -60, 0), var_1, var_2);
    playFXOnTag(level._effect["water_splash_black_ice"], level.surface_truck_rear, "tag_origin");
    wait 1.0;
  }

  playFXOnTag(level._effect["water_drip_tire_black_ice"], level.surface_truck_rear, "tag_origin");
  wait 2.0;

  for(var_3 = 0; var_3 < 2; var_3++) {
    playFXOnTag(level._effect["water_splash_black_ice"], level.surface_truck_rear, "tag_origin");
    wait(randomfloatrange(1, 1.5));
  }

  var_0 = level.surface_truck gettagorigin("tag_wheel_back_left");
  var_1 = anglesToForward(level.surface_truck.angles + (15, 0, 0));
  var_2 = anglestoup(level.surface_truck.angles + (0, 0, 0));

  for(var_3 = 0; var_3 < 8; var_3++) {
    playFX(level._effect["water_splash_black_ice"], var_0 + (0, 55, 52), var_1, var_2);
    wait(randomfloatrange(0.5, 1));
  }
}

fx_camp_truck_submerge_body() {
  var_0 = level.surface_truck gettagorigin("tag_wheel_front_left");
  var_1 = level.surface_truck gettagorigin("tag_wheel_back_left");
  var_2 = anglesToForward(level.surface_truck.angles - (100, 0, 0));
  var_3 = anglestoup(level.surface_truck.angles - (0, 0, 0));
  wait 5.0;

  for(var_4 = 0; var_4 < 5; var_4++) {
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_0 + (0, 0, 30), var_2, var_3);
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_1 + (0, 0, 5), var_2, var_3);
    wait 1.0;
  }

  var_1 = level.surface_truck gettagorigin("tag_wheel_back_left");

  for(var_4 = 0; var_4 < 5; var_4++) {
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_0 + (0, -10, 30), var_2, var_3);
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_1 + (0, 0, 45), var_2, var_3);
    wait(randomfloatrange(0.5, 1.0));
  }

  var_1 = level.surface_truck gettagorigin("tag_wheel_back_left");

  for(var_4 = 0; var_4 < 7; var_4++) {
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_0 + (0, -20, 30), var_2, var_3);
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_1 + (0, 30, 45), var_2, var_3);
    wait(randomfloatrange(0.5, 1.0));
  }

  playFX(level._effect["water_splash_truck_large_black_ice"], var_1 + (0, 0, 45), var_2, var_3);

  for(var_4 = 0; var_4 < 4; var_4++) {
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_0 + (0, 0, 30), var_2, var_3);
    playFX(level._effect["water_splash_truck_oriented_black_ice"], var_1 + (0, 0, 45), var_2, var_3);
    wait(randomfloatrange(0.5, 1.0));
  }
}

turn_on_oil_derrick_lightsfx() {
  var_0 = level._refinery.derrick_model;
  wait 0.01;
  playFXOnTag(level._effect["blue_light_derrick_01"], var_0, "tagFX_blue_light_01");
  playFXOnTag(level._effect["blue_light_derrick_01"], var_0, "tagFX_blue_light_03");
  playFXOnTag(level._effect["blue_light_derrick_01"], var_0, "tagFX_blue_light_02");
  wait 0.01;
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_01");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_01");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_01");
  wait 0.01;
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_02");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_02");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_02");
  wait 0.01;
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_03");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_03");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_03");
  wait 0.01;
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_04");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_04");
  playFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_04");
  wait 0.01;
  playFXOnTag(level._effect["red_light_derrick_blinking_01"], var_0, "tagFX_red_light_d_01");
  playFXOnTag(level._effect["red_light_derrick_oscillator_01"], var_0, "tagFX_red_light_d_01");
  wait 0.01;
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_01");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_01");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_01");
  wait 0.01;
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_02");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_02");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_02");
  wait 0.01;
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_03");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_03");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_03");
  wait 0.01;
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_04");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_04");
  playFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_04");
  wait 0.01;
}

turn_off_oil_derrick_lightsfx() {
  var_0 = level._refinery.derrick_model;
  wait 0.01;
  stopFXOnTag(level._effect["blue_light_derrick_01"], var_0, "tagFX_blue_light_01");
  stopFXOnTag(level._effect["blue_light_derrick_01"], var_0, "tagFX_blue_light_03");
  stopFXOnTag(level._effect["blue_light_derrick_01"], var_0, "tagFX_blue_light_02");
  wait 0.01;
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_01");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_01");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_01");
  wait 0.01;
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_02");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_02");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_02");
  wait 0.01;
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_03");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_03");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_03");
  wait 0.01;
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_a_04");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_b_04");
  stopFXOnTag(level._effect["red_light_derrick_01"], var_0, "tagFX_red_light_c_04");
  wait 0.01;
  stopFXOnTag(level._effect["red_light_derrick_blinking_01"], var_0, "tagFX_red_light_d_01");
  stopFXOnTag(level._effect["red_light_derrick_oscillator_01"], var_0, "tagFX_red_light_d_01");
  wait 0.01;
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_01");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_01");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_01");
  wait 0.01;
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_02");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_02");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_02");
  wait 0.01;
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_03");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_03");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_03");
  wait 0.01;
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_a_04");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_b_04");
  stopFXOnTag(level._effect["warm_light_derrick_01"], var_0, "tagFX_core_light_c_04");
  wait 0.01;
}

refinery_travelling_block_impact_fx() {
  level waittill("notify_debris_ground_fx_1");
  level.chunk_spark_fx_tag = common_scripts\utility::spawn_tag_origin();
  level.chunk_spark_fx_tag linkto(level._refinery.scripted["derrick_chunk"], "tag_origin", (20, 20, 0), (0, -45, 180));
  playFXOnTag(level._effect["refinery_debris_sparks_01"], level.chunk_spark_fx_tag, "tag_origin");
  thread refinery_stop_chunk_spark_fx();
  var_0 = level._refinery.scripted["traveling_block"] gettagorigin("tag_origin");
  playFX(level._effect["refinery_debris_tb_impact_01"], var_0 + (0, 0, -70));
  level waittill("notify_debris_ground_fx_2");
}

refinery_stop_chunk_spark_fx() {
  wait 0.75;
  stopFXOnTag(level._effect["refinery_debris_sparks_01"], level.chunk_spark_fx_tag, "tag_origin");
}

refinery_stop_travelling_block_spark_fx() {
  wait 0.75;
  stopFXOnTag(level._effect["refinery_debris_sparks_01"], level.tb_spark_fx_tag, "tag_origin");
}

pipe_deck_fx() {
  common_scripts\utility::exploder("pipe_deck_oil_rain");
  common_scripts\utility::exploder("pipe_deck_lights");
  thread pipe_deck_water_suppression_fx();
}

heat_column_fx() {
  level endon("flag_vision_command");
  level endon("flag_vision_pipedeck_off");
  var_0 = 1650;
  var_1 = 1200;
  var_2 = 850;
  var_3 = 670;
  var_4 = 570;
  var_5 = 0.11;
  var_6 = 1900;
  var_7 = 500;
  var_8 = 0.5;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = level._refinery.derrick_struct;
  create_view_particle_source();

  for(;;) {
    var_14 = distance(level.player.origin, var_13.origin);
    var_15 = var_13.origin - level.player.origin;
    var_15 = (var_15[0], var_15[1], 0);
    var_15 = vectornormalize(var_15);
    var_16 = anglesToForward(level.player.angles);
    var_16 = (var_16[0], var_16[1], 0);
    var_16 = vectornormalize(var_16);
    var_17 = vectordot(var_15, var_16);

    if(var_14 < var_4) {
      if(var_17 > 0.33) {
        var_18 = 5;
      } else if(var_17 > -0.33) {
        var_18 = 4;
      } else {
        var_18 = 3;
      }
    } else if(var_14 < var_3) {
      if(var_17 > 0.65) {
        var_18 = 5;
      } else if(var_17 > -0.33) {
        var_18 = 4;
      } else {
        var_18 = 3;
      }
    } else if(var_14 < var_2) {
      if(var_17 > 0.35) {
        var_18 = 3;
      } else {
        var_18 = 2;
      }
    } else if(var_14 < var_1) {
      if(var_17 > 0.75) {
        var_18 = 3;
      } else if(var_17 > -0.33) {
        var_18 = 2;
      } else {
        var_18 = 1;
      }
    } else if(var_14 < var_0) {
      if(var_17 > 0.6) {
        var_18 = 2;
      } else if(var_17 > -0.25) {
        var_18 = 1;
      } else {
        var_18 = 0;
      }
    } else
      var_18 = 0;

    if(common_scripts\utility::flag("flag_vision_mudpumps")) {
      var_18 = 0;
    }

    if(var_18 != var_10) {
      switch (var_18) {
        case 0:
          var_10 = 0;
          var_9 = 0;
          var_12 = 0;
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          maps\_art::dof_disable_script(0);
          level.player setviewmodeldepthoffield(0.0, 0.0);
          break;
        case 1:
          var_10 = 1;
          var_9 = 0.03;
          var_12 = 0.2;
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          playFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          maps\_art::dof_enable_script(0, 0, 4, 0, 194.25, 0.1225, 0);
          level.player setviewmodeldepthoffield(0.0, 13.26);
          break;
        case 2:
          var_10 = 2;
          var_9 = 0.042;
          var_12 = 0.4;
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          playFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          maps\_art::dof_enable_script(0, 0, 4, 0, 389, 0.245, 0);
          level.player setviewmodeldepthoffield(0.0, 13.26);
          break;
        case 3:
          var_10 = 3;
          var_9 = 0.08;
          var_12 = 0.55;
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          playFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          maps\_art::dof_enable_script(0, 0, 4, 0, 583, 0.3675, 0);
          level.player setviewmodeldepthoffield(0.0, 13.26);
          break;
        case 4:
          var_10 = 4;
          var_9 = 0.105;
          var_12 = 0.75;
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          playFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          maps\_art::dof_enable_script(0, 0, 4, 0, 777, 0.49, 0);
          level.player setviewmodeldepthoffield(0.0, 13.26);
          break;
        case 5:
          var_10 = 5;
          var_9 = 0.125;
          var_12 = 1.0;
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          playFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          maps\_art::dof_enable_script(0, 188, 4, 250, 777, 1.49, 0);
          level.player setviewmodeldepthoffield(0.0, 23.2);
          break;
        default:
          var_10 = 0;
          var_9 = 0;
          var_12 = 0.0;
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze2"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze4"), level.view_particle_source, "tag_origin");
          wait(level.timestep);
          stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze5"), level.view_particle_source, "tag_origin");
          maps\_art::dof_disable_script(0);
          level.player setviewmodeldepthoffield(0.0, 0.0);
      }
    }

    if(!common_scripts\utility::flag("flag_vision_mudpumps")) {
      var_11 = pipedeckvisionswitching(var_11, var_12);
    }

    if(var_9 > 0) {
      earthquake(var_9, 0.2, level.player.origin, 128);
    }

    wait(level.timestep);
  }
}

pipedeckvisionswitching(var_0, var_1) {
  var_2 = 0.025;
  var_3 = abs(var_0 - var_1);

  if(var_3 <= var_2) {
    var_0 = var_1;
  } else if(var_0 > var_1) {
    var_0 = var_0 - var_2;
  } else {
    var_0 = var_0 + var_2;
  }

  level.player visionsetnakedforplayer_lerp("black_ice_pipedeck", "black_ice_pipedeck_heat_5", var_0);
  return var_0;
}

exfil_player_view_smoke_particles() {
  create_view_particle_source();
  playFXOnTag(common_scripts\utility::getfx("player_view_smoke"), level.view_particle_source, "tag_origin");
  level waittill("notify_stop_view_smoke_fx");
  stopFXOnTag(common_scripts\utility::getfx("player_view_smoke"), level.view_particle_source, "tag_origin");
}

pipe_deck_water_suppression_fx() {
  level._fire_suppression = spawnStruct();
  level._fire_suppression.loopers = [];
  level._fire_suppression.ents = [];

  if(level.start_point != "exfil") {
    common_scripts\utility::exploder("derrick_fire_ground");
    thread maps\black_ice_util::exploder_damage_loop("derrick_fire_ground", level._fire_damage_ent);
    common_scripts\utility::exploder("water_supression_on_1");
    common_scripts\utility::exploder("water_supression_on_3");
  }
}

fx_command_interior_on() {
  common_scripts\utility::exploder("fx_command_interior");
}

engineroom_turn_on_fx() {
  common_scripts\utility::exploder("engineroom_01");
  common_scripts\utility::exploder("engineroom_02");
  thread maps\black_ice_util::exploder_damage_loop("engineroom_01", level._fire_damage_ent);
}

engineroom_turn_off_fx() {
  maps\_utility::stop_exploder("engineroom_01");
  common_scripts\utility::flag_wait("flag_top_drive_walkway");
  maps\_utility::stop_exploder("engineroom_02");
}

engineroom_headsmoke_fx_start() {
  level.smokehead = level.player common_scripts\utility::spawn_tag_origin();
  level.smokehead linkto(level.player);
  playFXOnTag(level._effect["obscuring_haze_playerview"], level.smokehead, "tag_origin");
  create_view_particle_source();
  playFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
  maps\_art::dof_enable_script(0, 0, 4, 0, 777, 1.49, 0);
  level.player setviewmodeldepthoffield(0.0, 13.26);
}

engineroom_headsmoke_fx_end() {
  stopFXOnTag(level._effect["obscuring_haze_playerview"], level.smokehead, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("pipedeck_heat_haze3"), level.view_particle_source, "tag_origin");
  maps\_art::dof_disable_script(0);
  level.player setviewmodeldepthoffield(0.0, 0.0);
  level notify("notify_stop_screen_shake");
}

engineroom_heat_fx_shake() {
  level endon("notify_stop_screen_shake");
  var_0 = 0.05;

  for(;;) {
    earthquake(var_0, 0.2, level.player.origin, 128);
    wait(level.timestep);
  }
}

refinery_turn_on_buildup_fx_01() {
  common_scripts\utility::exploder("ref_emeg_lights_01");
  common_scripts\utility::flag_wait("flag_refinery_gas_blowout_01");
  common_scripts\utility::exploder("ref_buildup_pre_01");
  refinery_buildup_quake_delay(0.4, 1.5, 0.4);
  common_scripts\utility::flag_wait("flag_refinery_gas_blowout_02");
  common_scripts\utility::exploder("ref_buildup_pre_02");
  refinery_buildup_quake_delay(0.6, 5.5, 0.4);
  common_scripts\utility::flag_wait("flag_refinery_gas_blowout_03");
  common_scripts\utility::exploder("ref_buildup_01");
  common_scripts\utility::exploder("ref_buildup_r_01");
  thread maps\black_ice_audio::sfx_long_pipe_bursts();
  wait 1.5;
  common_scripts\utility::exploder("ref_buildup_02");
}

refinery_buildup_quake_delay(var_0, var_1, var_2) {
  wait(var_2);
  earthquake(var_0, var_1, level.player.origin, 128);
}

turn_off_refinery_buildup_fx_01() {
  maps\_utility::stop_exploder("ref_buildup_pre_01");
  maps\_utility::stop_exploder("ref_buildup_01");
  maps\_utility::stop_exploder("ref_buildup_r_01");
  maps\_utility::stop_exploder("ref_buildup_02");
}

tanks_bridge_fall_fx() {
  playFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_1");
  playFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_2");
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_3");
  playFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_4");
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_5");
  playFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_6");
  wait 5.0;
  stopFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_1");
  stopFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_2");
  wait 0.05;
  stopFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_3");
  stopFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_4");
  wait 0.05;
  stopFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_5");
  stopFXOnTag(common_scripts\utility::getfx("tanks_pipe_trail"), level._tanks.pipe, "tag_fx_6");
}

tanks_bridge_fall_explosions() {
  common_scripts\utility::exploder("tanks_pipe_explode_1");
  earthquake(0.3, 1.6, level.player.origin, 3000);
  common_scripts\utility::exploder("tanks_pipe_explode_smoke");
  wait 1.5;
  common_scripts\utility::exploder("tanks_pipe_explode_2");
  earthquake(0.17, 1.2, level.player.origin, 3000);
  wait 0.8;
  common_scripts\utility::exploder("tanks_pipe_explode_3");
  earthquake(0.3, 1.4, level.player.origin, 3000);
}

tanks_bridge_aftershocks() {
  var_0 = 0.11;
  var_1 = 0.22;
  var_2 = 0.7;
  var_3 = 1.3;
  var_4 = 0.3;
  var_5 = 1.8;
  var_6 = 0.94;

  while(var_0 > 0.01) {
    var_7 = randomfloatrange(var_0, var_1);
    var_8 = randomfloatrange(var_4, var_5);
    var_9 = randomfloatrange(var_2, var_3);
    earthquake(var_7, var_9, level.player.origin, 3000);
    thread maps\black_ice_audio::sfx_screenshake();
    var_0 = var_0 * var_6;
    var_1 = var_1 * var_6;
    wait(var_8);
  }
}

turn_on_flarestack_fx() {
  var_0 = getent("origin_flarestack_fx", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.angles = var_0.angles;
  var_1.origin = var_0.origin;
  playFXOnTag(common_scripts\utility::getfx("fire_oil_burnoff_01"), var_1, "tag_origin");
  level waittill("notify_stop_flare_stack");
  stopFXOnTag(common_scripts\utility::getfx("fire_oil_burnoff_01"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("fire_oil_burnoff_extinguish"), var_1, "tag_origin");
  level notify("notify_flare_stack_off");
  thread maps\black_ice_flarestack::fx_flarestack_motion();
  wait 2.2;
  level notify("flamestack_steam_vent");
  common_scripts\utility::exploder("flamestack_steam_vent");
}

flarestack_turn_on_console_fx() {
  common_scripts\utility::exploder("flarestack_console_normal");
  level waittill("notify_flare_stack_off");
  maps\_utility::stop_exploder("flarestack_console_normal");
  common_scripts\utility::exploder("flarestack_console_emergency");
}

exfil_heli_smoke_fx_01() {
  wait 8.0;

  for(var_0 = 0; var_0 < 3; var_0++) {
    level.exfil_heli_tag = common_scripts\utility::spawn_tag_origin();
    level.exfil_heli_tag linkto(level.heli, "tag_origin", (0, 0, -20), (0, 0, 0));
    playFXOnTag(level._effect["heli_smoke_01"], level.exfil_heli_tag, "tag_origin");
    wait(randomfloatrange(1, 2));
  }
}

coldbreathfx() {
  var_0 = level._allies;

  foreach(var_2 in var_0) {
    var_2 thread turn_on_cold_breath_fx();
  }

  common_scripts\utility::flag_wait("flag_catwalks_end");

  foreach(var_2 in var_0) {
    self notify("stop personal effect");
  }
}

turn_on_cold_breath_fx() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  self.has_cold_breath = 1;

  while(!common_scripts\utility::flag("flag_catwalks_end")) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    playFXOnTag(level._effect["cold_breath"], self, var_0);
    wait(2.5 + randomfloat(2.5));
  }
}

turn_off_cold_breath_fx() {
  self.has_cold_breath = 0;

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }
  }
}

turn_on_cold_breath_player_fx() {
  level.coldbreath_player = common_scripts\utility::spawn_tag_origin();
  level.coldbreath_player linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  self.has_cold_breath = 1;

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    playFX(level._effect["cold_breath"], level.coldbreath_player.origin, level.player.angles);
    wait(0.5 + randomfloat(0.5));
  }
}

fx_screen_bokehdots_rain() {
  common_scripts\utility::flag_wait("flag_fx_screen_bokehdots_rain");
  create_view_particle_source();

  for(;;) {
    if(common_scripts\utility::flag("flag_fx_screen_bokehdots_rain")) {
      playFXOnTag(common_scripts\utility::getfx("bokeh_splats_01"), level.view_particle_source, "tag_origin");
    } else {
      stopFXOnTag(common_scripts\utility::getfx("bokeh_splats_01"), level.view_particle_source, "tag_origin");
    }

    wait 3.0;
  }
}

fx_screen_raindrops() {
  create_view_particle_source();

  for(;;) {
    if(common_scripts\utility::flag("fx_screen_raindrops") || common_scripts\utility::flag("fx_player_watersheeting")) {
      var_0 = 0;
      var_1 = level.player getplayerangles();

      if(common_scripts\utility::flag("fx_player_watersheeting") && var_1[0] < 25) {
        level.player setwatersheeting(1, 1.0);
        var_0 = 1;
      }

      if(common_scripts\utility::flag("fx_screen_raindrops")) {
        if(!var_0 && var_1[0] < -55 && randomint(100) < 20) {
          level.player setwatersheeting(1, 1.0);
        }

        if(var_1[0] < -40) {
          playFXOnTag(level._effect["raindrops_screen_20"], level.view_particle_source, "tag_origin");
        } else if(var_1[0] < -25) {
          playFXOnTag(level._effect["raindrops_screen_10"], level.view_particle_source, "tag_origin");
        } else if(var_1[0] < 25) {
          playFXOnTag(level._effect["raindrops_screen_5"], level.view_particle_source, "tag_origin");
        } else if(var_1[0] < 40) {
          playFXOnTag(level._effect["raindrops_screen_3"], level.view_particle_source, "tag_origin");
        }
      }
    }

    wait 1.0;
  }
}

fx_screen_oildrops() {
  create_view_particle_source();

  for(;;) {
    if(common_scripts\utility::flag("fx_screen_oildrops") || common_scripts\utility::flag("fx_player_watersheeting")) {
      var_0 = 0;
      var_1 = level.player getplayerangles();

      if(common_scripts\utility::flag("fx_player_watersheeting") && var_1[0] < 25) {
        level.player setwatersheeting(1, 1.0);
        var_0 = 1;
      }

      if(common_scripts\utility::flag("fx_screen_oildrops")) {
        if(!var_0 && var_1[0] < -55 && randomint(100) < 20) {
          level.player setwatersheeting(1, 1.0);
        }

        if(var_1[0] < 25) {
          playFXOnTag(level._effect["oildrops_screen_5"], level.view_particle_source, "tag_origin");
        } else if(var_1[0] < 40) {
          playFXOnTag(level._effect["oildrops_screen_3"], level.view_particle_source, "tag_origin");
        }
      }
    }

    wait 2.0;
  }
}

turn_on_bokeh_fieryflash_player_fx() {
  create_view_particle_source();
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("bokeh_fieryflash_01"), level.view_particle_source, "tag_origin");
}

exfil_oilrig_preboom_fx(var_0) {
  level waittill("notify_exfil_player_teleport");
  thread exfil_oilrig_ball_drop_fx(var_0);
  thread exfil_oilrig_explosions_fx(var_0);
  thread exfil_oilrig_shockwave_fx(var_0);
  level.geysertag = common_scripts\utility::spawn_tag_origin();
  level.geysertag linkto(var_0, "j_rigtop_1", (0, 0, 500), (-90, 0, -55));
  level.xplotag1 = common_scripts\utility::spawn_tag_origin();
  level.xplotag1 linkto(var_0, "j_rigtop_1", (500, -1500, 500), (-79, 0, 0));
  level.xplotag2 = common_scripts\utility::spawn_tag_origin();
  level.xplotag2 linkto(var_0, "j_rigtop_1", (-1000, 0, 100), (0, 0, 0));
  level.xplotag3 = common_scripts\utility::spawn_tag_origin();
  level.xplotag3 linkto(var_0, "j_rigtop_1", (500, 0, 500), (-90, 0, 0));
  level.xplotag4 = common_scripts\utility::spawn_tag_origin();
  level.xplotag4 linkto(var_0, "j_rigtop_1", (-1000, -1700, 500), (-90, 0, 0));
  level.xplotag5 = common_scripts\utility::spawn_tag_origin();
  level.xplotag5 linkto(var_0, "j_rigtop_1", (500, 1000, 300), (-90, 0, 0));
  level.splshtag1 = common_scripts\utility::spawn_tag_origin();
  level.splshtag1 linkto(var_0, "tag_fx_splash_leg_01", (0, 0, 0), (0, 0, 0));
  level.splshtag2 = common_scripts\utility::spawn_tag_origin();
  level.splshtag2 linkto(var_0, "tag_fx_splash_leg_02", (0, 0, 0), (0, 0, 0));
  level.splshtag3 = common_scripts\utility::spawn_tag_origin();
  level.splshtag3 linkto(var_0, "tag_fx_splash_leg_03", (0, 0, 0), (0, 0, 0));
  level.splshtag4 = common_scripts\utility::spawn_tag_origin();
  level.splshtag4 linkto(var_0, "tag_fx_splash_leg_04", (0, 0, 0), (0, 0, 0));
  level.splshtag7 = common_scripts\utility::spawn_tag_origin();
  level.splshtag7 linkto(var_0, "tag_fx_splash_leg_07", (0, 0, 0), (0, 0, 0));
  level.splshtag11 = common_scripts\utility::spawn_tag_origin();
  level.splshtag11 linkto(var_0, "tag_fx_splash_leg_11", (0, 0, 0), (0, 0, 0));
  level.splshtag15 = common_scripts\utility::spawn_tag_origin();
  level.splshtag15 linkto(var_0, "tag_fx_splash_leg_15", (0, 0, 0), (0, 0, 0));
  wait 0.1;
  var_1 = var_0 gettagorigin("j_rigtop_1");
  var_2 = spawnfx(common_scripts\utility::getfx("vfx_rig_fire_exfil_huge"), var_1 + (0, 0, 100), (90, 90, 0));
  triggerfx(var_2, -50);
}

exfil_oilrig_explosions_fx(var_0) {
  level waittill("notify_rig_explode");
  playFXOnTag(common_scripts\utility::getfx("exfil_xplosion_huger"), level.xplotag5, "tag_origin");
  thread turn_on_bokeh_fieryflash_player_fx();
  playFXOnTag(common_scripts\utility::getfx("exfil_rigcollapse_splash"), level.splshtag1, "tag_origin");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("exfil_rigcollapse_splash"), level.splshtag2, "tag_origin");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("exfil_rigcollapse_splash"), level.splshtag4, "tag_origin");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("exfil_rigcollapse_splash"), level.splshtag3, "tag_origin");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("exfil_rigcollapse_splash"), level.splshtag7, "tag_origin");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("exfil_rigcollapse_splash"), level.splshtag11, "tag_origin");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("exfil_rigcollapse_splash"), level.splshtag15, "tag_origin");
  wait 0.2;
}

exfil_oilrig_shockwave_fx(var_0) {
  level waittill("notify_rig_explode");
  wait 0.1;
  var_1 = anglesToForward(var_0.angles - (0, 0, 0));
  var_2 = anglestoup(var_0.angles - (0, -90, 0));
  playFX(level._effect["exfil_xplosion_shockwave"], var_0.origin);
  wait 0.1;
  earthquake(0.15, 0.6, level.player.origin, 3000);
  level.player playrumbleonentity("damage_light");
  wait 1.1;
  earthquake(0.41, 1.8, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  level.player thread shockwave_dirt_hit(2, 0.1, 7);
  common_scripts\utility::exploder("shockwave_exfil");
}

shockwave_dirt_hit(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader("fullscreen_dirt_right", 640, 480);
  var_3.splatter = 1;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.foreground = 0;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = 0;
  var_4 = 0;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  while(var_4 < var_1) {
    var_3.alpha = var_3.alpha + 0.05;
    var_4 = var_4 + 0.05;
    wait 0.05;
  }

  var_3.alpha = 1;
  wait(var_0);
  var_4 = 0;

  while(var_4 < var_2) {
    var_3.alpha = var_3.alpha - 0.05;
    var_4 = var_4 + 0.05;
    wait 0.05;
  }

  var_3.alpha = 0;
  var_3 destroy();
}

exfil_oilrig_ball_drop_fx(var_0) {
  level waittill("notify_sphere_start_fall");
  level.trailtag_sphere = common_scripts\utility::spawn_tag_origin();
  level.trailtag_sphere linkto(var_0, "j_sphere_01", (0, 0, 0), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("exfil_sphere_trail"), level.trailtag_sphere, "tag_origin");
  level waittill("notify_sphere_hit_ground");
  stopFXOnTag(common_scripts\utility::getfx("exfil_sphere_trail"), level.trailtag_sphere, "tag_origin");
  var_1 = var_0 gettagorigin("j_sphere_01") + (0, 0, 200);
  playFX(level._effect["exfil_xplosion_huge"], var_1);
}

exfil_blackice_exfil_heli_lights_fx() {
  playFXOnTag(common_scripts\utility::getfx("vfx_aircraft_light_white_blink_fog"), level.heli, "tag_light_belly");
  playFXOnTag(common_scripts\utility::getfx("vfx_aircraft_light_red_blink_fog"), level.heli, "tag_light_tail");
  wait(level.timestep);
  playFXOnTag(common_scripts\utility::getfx("vfx_aircraft_light_red_blink_fog"), level.heli, "tag_light_R_wing");
  playFXOnTag(common_scripts\utility::getfx("vfx_aircraft_light_green_blink_fog"), level.heli, "tag_light_L_wing");
}

fx_command_window_light_on() {
  common_scripts\utility::exploder("pipedeck_command_window_light");
}

fx_command_window_light_off() {
  maps\_utility::stop_exploder("pipedeck_command_window_light");
}

fx_exfil_lifeboat_wake(var_0) {
  wait 2.0;

  for(;;) {
    wait 0.1;
    var_1 = anglesToForward(var_0.angles - (90, 0, 0));
    var_2 = anglesToForward(var_0.angles - (0, -90, 0));
    playFX(level._effect["water_wake_med"], var_0.origin, var_1, var_2);
  }
}

fx_disable_helo_treadfx() {
  maps\_treadfx::setallvehiclefx("vehicle_mi24p_hind_blackice", undefined);
}