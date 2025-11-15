/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_fx.gsc
**************************************/

main() {
  level._effect["melee_bubbles"] = loadfx("vfx/moments/ship_graveyard/melee_bubbles");
  level._effect["melee_scuba_bubbles"] = loadfx("vfx/moments/ship_graveyard/melee_scuba_bubbles");
  level._effect["vfx_godray_uw_narrow_02"] = loadfx("vfx/ambient/lights/vfx_godray_uw_narrow_02");
  level._effect["vfx_godray_uw_narrow_01"] = loadfx("vfx/ambient/lights/vfx_godray_uw_narrow_01");
  level._effect["vfx_godray_uw_patch_04"] = loadfx("vfx/ambient/lights/vfx_godray_uw_patch_04");
  level._effect["vfx_godray_uw_patch_03"] = loadfx("vfx/ambient/lights/vfx_godray_uw_patch_03");
  level._effect["vfx_godray_uw_patch_02"] = loadfx("vfx/ambient/lights/vfx_godray_uw_patch_02");
  level._effect["vfx_godray_uw_patch_kelp"] = loadfx("vfx/ambient/lights/vfx_godray_uw_patch_kelp");
  level._effect["vfx_godray_underwater_patch"] = loadfx("vfx/ambient/lights/vfx_godray_underwater_patch");
  surface_fx();
  level._effect["fish_school01"] = loadfx("fx/animals/fish_school01");
  level._effect["fish_school_side_med"] = loadfx("fx/animals/fish_school_side_med");
  level._effect["water_bubbles_longlife_lp"] = loadfx("fx/water/water_bubbles_longlife_lp");
  level._effect["water_bubbles_random_ch2"] = loadfx("fx/water/water_bubbles_random_ch2");
  level._effect["water_bubbles_random_ch3"] = loadfx("fx/water/water_bubbles_random_ch3");
  level._effect["water_bubbles_wide_sm_lp"] = loadfx("fx/water/water_bubbles_wide_sm_lp");
  level._effect["caustics"] = loadfx("fx/water/caustics");
  level._effect["dubai_lights_glow_white"] = loadfx("fx/lights/dubai_lights_glow_white");
  level._effect["floating_debris_xlg_underwater"] = loadfx("fx/misc/floating_debris_xlg_underwater");
  level._effect["floating_obj_bottles_underwater"] = loadfx("fx/misc/floating_obj_bottles_underwater");
  level._effect["floating_obj_trash_underwater"] = loadfx("fx/misc/floating_obj_trash_underwater");
  level._effect["underwater_blood_linger_thick"] = loadfx("fx/water/underwater_blood_linger_thick");
  level._effect["underwater_blood_linger_thick_stairs"] = loadfx("fx/water/underwater_blood_linger_thick_stairs");
  level._effect["water_intro_river_wake02_large"] = loadfx("fx/water/water_intro_river_wake02_large");
  level._effect["ocean_particulate_lightsource"] = loadfx("fx/water/ocean_particulate_lightsource");
  level._effect["ocean_particulate_lightsource_large"] = loadfx("fx/water/ocean_particulate_lightsource_large");
  level._effect["underwater_particulates_glitter"] = loadfx("fx/water/underwater_particulates_glitter");
  level._effect["ny_harbor_underwater_dust_swirl"] = loadfx("fx/water/ny_harbor_underwater_dust_swirl");
  level._effect["ice_infil_underwater_murk"] = loadfx("fx/water/ice_infil_underwater_murk");
  level._effect["ny_harbor_underwater_dust_bright"] = loadfx("fx/water/ny_harbor_underwater_dust_bright");
  level._effect["vfx_murk_underwater_wall"] = loadfx("vfx/ambient/water/vfx_murk_underwater_wall");
  level._effect["silt_ground_ambient"] = loadfx("fx/water/silt_ground_ambient");
  level._effect["silt_ground_ambient_dark"] = loadfx("fx/water/silt_ground_ambient_dark");
  level._effect["silt_ground_ambient_medium"] = loadfx("fx/water/silt_ground_ambient_medium");
  level._effect["silt_ground_ambient_dark_large"] = loadfx("fx/water/silt_ground_ambient_dark_large");
  level._effect["silt_ground_ambient_light_large"] = loadfx("fx/water/silt_ground_ambient_light_large");
  level._effect["silt_ground_ambient_medium_large"] = loadfx("fx/water/silt_ground_ambient_medium_large");
  level._effect["silt_ground_ambient_line"] = loadfx("fx/water/silt_ground_ambient_line");
  level._effect["bubbles_leak_vent_small"] = loadfx("vfx/ambient/water/bubbles_leak_vent_small");
  level._effect["bubbles_leak_vent"] = loadfx("vfx/ambient/water/bubbles_leak_vent");
  level._effect["bubbles_bunch_leak_vent"] = loadfx("vfx/ambient/water/bubbles_bunch_leak_vent");
  level._effect["bubbles_mass_sheet_wide"] = loadfx("vfx/ambient/water/bubbles_mass_sheet_wide");
  level._effect["light_beam_glow_wide_underwater"] = loadfx("vfx/ambient/lights/light_beam_glow_wide_underwater");
  level._effect["light_boat_bottom_wide_underwater"] = loadfx("vfx/ambient/lights/light_boat_bottom_wide_underwater");
  level._effect["godray_underwater_huge"] = loadfx("vfx/ambient/lights/vfx_godray_underwater_huge");
  level._effect["godray_underwater_large"] = loadfx("vfx/ambient/lights/vfx_godray_underwater_large");
  level._effect["godray_underwater"] = loadfx("vfx/ambient/lights/vfx_godray_underwater");
  level._effect["godray_underwater_short"] = loadfx("vfx/ambient/lights/vfx_godray_underwater_short");
  level._effect["godray_underwater_tight"] = loadfx("vfx/ambient/lights/vfx_godray_underwater_tight");
  level._effect["godray_underwater_tight_short"] = loadfx("vfx/ambient/lights/vfx_godray_underwater_tight_short");
  level._effect["circle_glow_w_beam_lg"] = loadfx("vfx/ambient/lights/circle_glow_w_beam_lg");
  level._effect["vfx_underwater_sunflare"] = loadfx("vfx/ambient/lights/vfx_underwater_sunflare");
  level._effect["vfx_underwater_sunflare_roof"] = loadfx("vfx/ambient/lights/vfx_underwater_sunflare_roof");
  level._effect["murk_cloud_slow"] = loadfx("vfx/ambient/water/murk_cloud_slow");
  level._effect["murk_cloud_slow_spread"] = loadfx("vfx/ambient/water/murk_cloud_slow_spread");
  level._effect["murk_white_water_lg"] = loadfx("vfx/ambient/water/murk_white_water_lg");
  level._effect["silt_ground_ambient_light"] = loadfx("vfx/ambient/water/silt_ground_ambient_light");
  level._effect["silt_floating_ambient_light"] = loadfx("vfx/ambient/water/silt_floating_ambient_light");
  level._effect["silt_water_fill"] = loadfx("vfx/ambient/water/silt_water_fill");
  level._effect["silt_water_fill_soft"] = loadfx("vfx/ambient/water/silt_water_fill_soft");
  level._effect["ocean_particulate_drowning"] = loadfx("vfx/moments/ship_graveyard/ocean_particulate_drowning");
  level._effect["ocean_particulate_lighthouse"] = loadfx("vfx/moments/ship_graveyard/ocean_particulate_lighthouse");
  level._effect["vfx_scrnfx_water_distortion"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_water_distortion");
  level._effect["vfx_scrnfx_water_distortion_mov"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_water_distortion_mov");
  level._effect["scuba_bubbles"] = loadfx("vfx/moments/ship_graveyard/scuba_bubbles_plr_front");
  level._effect["scuba_bubbles_panic"] = loadfx("vfx/moments/ship_graveyard/scuba_bubbles_plr_panic");
  level._effect["scuba_mask_distortion"] = loadfx("vfx/moments/ship_graveyard/scuba_mask_distortion");
  level._effect["ocean_particulate_player"] = loadfx("vfx/moments/ship_graveyard/ocean_particulate_player_oneshot");
  level._effect["ocean_particulate_player_view"] = loadfx("vfx/moments/ship_graveyard/ocean_particulate_player_view");
  level._effect["ocean_particulate_player_mov"] = loadfx("vfx/moments/ship_graveyard/ocean_particulate_player_mov");
  level._effect["reload_clip_bubbles"] = loadfx("vfx/moments/ship_graveyard/reload_clip_bubbles");
  level._effect["reload_gun_bubbles"] = loadfx("vfx/moments/ship_graveyard/reload_gun_bubbles");
  level._effect["reload_snap_bubbles"] = loadfx("vfx/moments/ship_graveyard/reload_snap_bubbles");
  level._effect["aps_underwater_reload"] = loadfx("vfx/moments/ship_graveyard/aps_underwater_reload");
  level._effect["ai_marker_light"] = loadfx("vfx/moments/ship_graveyard/ai_marker_light");
  level._effect["vfx_headlamp_enemy_diver"] = loadfx("vfx/moments/ship_graveyard/vfx_headlamp_enemy_diver");
  level._effect["vfx_headlamp_enemy_off_runner"] = loadfx("vfx/moments/ship_graveyard/vfx_headlamp_enemy_off_runner");
  level._effect["silt_ground_kickup_runner"] = loadfx("vfx/gameplay/footsteps/swim_silt_ground_kickup_runner");
  level._effect["knife_stab_blood"] = loadfx("fx/_requests/ship_graveyard/knife_bloodpool_underwater");
  level._effect["underwater_bullet"] = loadfx("fx/_requests/ship_graveyard/shpg_underwater_bullet_trail1");
  level._effect["underwater_surface_splash_bullet"] = loadfx("fx/_requests/ship_graveyard/underwater_splash_bullet");
  level._effect["shpg_enm_death_bubbles_a"] = loadfx("vfx/_requests/shipg/shpg_enm_death_bubbles_a");
  level._effect["vfx_exp_underwater_runner"] = loadfx("vfx/gameplay/explosions/vfx_exp_underwater_runner");
  level._effect["shpg_caustic_pulse_light_a"] = loadfx("fx/_requests/ship_graveyard/shpg_caustic_pulse_light_a");
  level._effect["shpg_uwater_glow_beam_flash_a"] = loadfx("fx/_requests/ship_graveyard/shpg_uwater_glow_beam_flash_a");
  level._effect["dlight_white"] = loadfx("fx/_requests/ship_graveyard/dlight_white");
  level._effect["glow_beam_lcs_large"] = loadfx("vfx/moments/ship_graveyard/glow_beam_lcs_large");
  level._effect["bubble_burst_large"] = loadfx("vfx/ambient/water/bubble_burst_large");
  level._effect["boat_fall_slide"] = loadfx("vfx/_requests/shipg/boat_fall_slide");
  level._effect["vfx_exp_underwater"] = loadfx("vfx/gameplay/explosions/vfx_exp_underwater");
  level._effect["lighthouse_glass_break"] = loadfx("vfx/_requests/shipg/shpg_glass_break_a");
  level._effect["boat_trail"] = loadfx("fx/_requests/ship_graveyard/zodiac_wake_geotrail_shpg");
  level._effect["boat_trail_large"] = loadfx("fx/_requests/ship_graveyard/water_wake_underwater_lg");
  level._effect["lcs_front_lights"] = loadfx("fx/_requests/ship_graveyard/lcs_front_lights");
  level._effect["lcs_front_bubbles"] = loadfx("fx/_requests/ship_graveyard/shipg_lcs_front_bubbles");
  level._effect["lcs_back_lights"] = loadfx("fx/_requests/ship_graveyard/lcs_back_lights");
  level._effect["ship_wreckage_spark_delay"] = loadfx("fx/_requests/ship_graveyard/ship_wreckage_spark_delay");
  level._effect["underwater_object_trail"] = loadfx("fx/_requests/ship_graveyard/underwater_obj_trail");
  level._effect["underwater_obj_trail_small"] = loadfx("fx/_requests/ship_graveyard/underwater_obj_trail_small");
  level._effect["weld_sparks"] = loadfx("fx/misc/welding_underwater");
  level._effect["metal_sequence_silt_large"] = loadfx("fx/water/metal_sequence_silt_large");
  level._effect["player_arm_blood"] = loadfx("fx/water/blood_spurt_trapped_underwater");
  level._effect["ship_wreckage_spark_underwater"] = loadfx("fx/misc/ship_wreckage_spark_underwater");
  level._effect["sniper_glint"] = loadfx("fx/misc/scope_glint");
  level._effect["shpg_underwater_explosion_med_a"] = loadfx("fx/_requests/ship_graveyard/shpg_underwater_explosion_med_a");
  level._effect["shpg_underwater_bubble_explo"] = loadfx("fx/_requests/ship_graveyard/shpg_underwater_bubble_explo");
  level._effect["underwater_surface_splash"] = loadfx("vfx/moments/ship_graveyard/bubbles_diver_drop_underwater");
  level._effect["vfx_boat_wake_lcs_abovewater"] = loadfx("vfx/gameplay/tread_fx/vfx_boat_wake_lcs_abovewater");
  level._effect["wake_lg"] = loadfx("vfx/gameplay/tread_fx/vfx_boat_wake_large");
  level._effect["wake_med"] = loadfx("vfx/gameplay/tread_fx/vfx_boat_wake_med");
  level._effect["prop_wash"] = loadfx("vfx/gameplay/tread_fx/vfx_prop_wash");
  level._effect["boat_fall_impact_wreck"] = loadfx("vfx/moments/ship_graveyard/vfx_underwater_impact_largehit");
  level._effect["boat_fall_impact_wreck"] = loadfx("vfx/moments/ship_graveyard/vfx_underwater_impact_lilboathit");
  level._effect["large_water_impact_surface_breach"] = loadfx("vfx/ambient/water/large_water_impact_surface_breach");
  level._effect["large_water_impact_close_rocks"] = loadfx("vfx/ambient/water/large_water_impact_close_rocks");
  level._effect["large_water_impact_close_wave"] = loadfx("vfx/ambient/water/large_water_impact_close_wave");
  level._effect["abv_large_water_impact_close_wave"] = loadfx("vfx/ambient/water/large_water_impact_close_wave");
  level._effect["large_water_impact_close_ship"] = loadfx("vfx/ambient/water/large_water_impact_close_ship");
  level._effect["large_water_impact_close_bouy"] = loadfx("vfx/ambient/water/large_water_impact_close_bouy");
  level._effect["ocean_waves_blowoff"] = loadfx("vfx/ambient/water/ocean_waves_blowoff");
  level._effect["ocean_waves_splash"] = loadfx("vfx/ambient/water/ocean_waves_splash");
  level._effect["ocean_waves_mist"] = loadfx("vfx/ambient/water/ocean_waves_mist");
  level._effect["boat_crashing_waves"] = loadfx("vfx/ambient/water/large_water_impact_close_player_boat");
  level._effect["player_dive_bubbles"] = loadfx("vfx/_requests/shipg/shpg_scuba_bubbles_plr_front_dive");
  level._effect["large_water_impact_close_rain_windy"] = loadfx("fx/maps/ny_harbor/large_water_impact_close_rain_windy");
  level._effect["abv_water_splash"] = loadfx("vfx/ambient/water/rain_drop_impact_splash");
  level._effect["abv_spotlight"] = loadfx("fx/misc/hunted_spotlight_model");
  level._effect["abv_rain/rain_10"] = loadfx("vfx/ambient/weather/rain/rain_10_windy");
  level._effect["rain_10"] = loadfx("vfx/ambient/weather/rain/rain_10_windy");
  level._effect["abv_factory_fog_patch"] = loadfx("fx/smoke/factory_fog_patch");
  level._effect["abv_large_water_impact"] = loadfx("fx/maps/ny_harbor/large_water_impact");
  level._effect["abv_large_water_impact_close"] = loadfx("fx/maps/ny_harbor/large_water_impact_close");
  level._effect["abv_large_water_impact_close_rain"] = loadfx("fx/maps/ny_harbor/large_water_impact_close_rain_windy");
  level._effect["spotlight_underwater"] = loadfx("fx/misc/hunted_spotlight_model");
  level._effect["spotlight_underwater_cheap"] = loadfx("fx/misc/docks_heli_spotlight_model_cheap");
  level._effect["dive_in_bubbles_hand"] = loadfx("vfx/moments/ship_graveyard/dive_in_bubbles_hand");
  level._effect["dive_in_bubbles_feet"] = loadfx("vfx/moments/ship_graveyard/dive_in_bubbles_feet");
  level._effect["dive_in_ripple"] = loadfx("vfx/moments/ship_graveyard/dive_in_ripple");
  level._effect["cave_ceiling_silt_knockoff"] = loadfx("vfx/moments/ship_graveyard/cave_ceiling_silt_knockoff");
  level._effect["weld_sparks"] = loadfx("fx/misc/welding_underwater");
  level._effect["welding_underwater_ignition"] = loadfx("fx/misc/welding_underwater_ignition");
  level._effect["welding_underwater_pop"] = loadfx("fx/misc/welding_underwater_pop");
  level._effect["welding_underwater_torch"] = loadfx("fx/misc/welding_underwater_torch");
  level._effect["welding_underwater_torch_npc"] = loadfx("fx/misc/welding_underwater_torch_npc");
  level._effect["welding_underwater"] = loadfx("fx/misc/welding_underwater");
  level._effect["welding_underwater_off"] = loadfx("fx/misc/welding_underwater_off");
  level._effect["underwater_silt_barrel_hit"] = loadfx("vfx/moments/ship_graveyard/underwater_silt_barrel_hit");
  level._effect["sonar_silt_whoosh"] = loadfx("vfx/moments/ship_graveyard/sonar_silt_whoosh");
  level._effect["sonar_silt_center_whoosh"] = loadfx("vfx/moments/ship_graveyard/sonar_silt_center_whoosh");
  level._effect["shockwave"] = loadfx("fx/_requests/ship_graveyard/sonar_ping_dust");
  level._effect["sonar_ping_light"] = loadfx("fx/_requests/ship_graveyard/light_blink_red");
  level._effect["sonar_ping_distortion"] = loadfx("fx/_requests/ship_graveyard/sonar_ping");
  level._effect["vfx_sonar_dust_blast"] = loadfx("vfx/moments/ship_graveyard/vfx_sonar_dust_blast");
  level._effect["vfx_sonar_dust_blast_detail"] = loadfx("vfx/moments/ship_graveyard/vfx_sonar_dust_blast_detail");
  level._effect["vfx_sonar_blast_bits"] = loadfx("vfx/moments/ship_graveyard/vfx_sonar_blast_bits");
  level._effect["vfx_sonar_dust_crate"] = loadfx("vfx/moments/ship_graveyard/vfx_sonar_dust_crate");
  level._effect["vfx_sonar_dust_blast_lh"] = loadfx("vfx/moments/ship_graveyard/vfx_sonar_dust_blast_lh");
  level._effect["torpedo_kickup"] = loadfx("vfx/moments/ship_graveyard/torpedo_kickup");
  level._effect["torpedo_wings_out"] = loadfx("vfx/moments/ship_graveyard/torpedo_wings_out");
  level._effect["tpd_wo"] = loadfx("vfx/moments/ship_graveyard/tpd_wo");
  level._effect["tpd_wo_l"] = loadfx("vfx/moments/ship_graveyard/tpd_wo_l");
  level._effect["tpd_wo_r"] = loadfx("vfx/moments/ship_graveyard/tpd_wo_r");
  level._effect["torpedo_propellor"] = loadfx("vfx/moments/ship_graveyard/torpedo_propellor");
  level._effect["torpedo_propellor_loop"] = loadfx("vfx/moments/ship_graveyard/torpedo_propellor_loop");
  level._effect["vfx_scrnfx_torpedocam"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_torpedocam");
  level._effect["lighthouse_bubbles"] = loadfx("vfx/moments/ship_graveyard/lighthouse_player_mess_main");
  level._effect["lighthouse_debris"] = loadfx("vfx/moments/ship_graveyard/lighthouse_outer_bubble_mess");
  level._effect["lighthouse_wood"] = loadfx("vfx/moments/ship_graveyard/lighthouse_base_snap_debris");
  level._effect["lighthouse_view_impact_force"] = loadfx("vfx/moments/ship_graveyard/debris_hit_wood_metal");
  level._effect["debris_hit_wood_metal"] = loadfx("vfx/moments/ship_graveyard/debris_hit_wood_metal");
  level._effect["lighthouse_lcs_detonation"] = loadfx("vfx/gameplay/explosions/vfx_exp_underwater_runner");
  level._effect["lighthouse_lcs_detonation_sink"] = loadfx("vfx/moments/ship_graveyard/lighthouse_lcs_detonation_sink");
  level._effect["lighthouse_window_mess"] = loadfx("vfx/moments/ship_graveyard/lighthouse_window_mess");
  level._effect["rebreather_hose_bubbles"] = loadfx("vfx/moments/ship_graveyard/rebreather_hose_bubbles");
  level._effect["scuba_bubbles_friendly"] = loadfx("vfx/ambient/water/bubbles_breath_hero");
  level._effect["hand_debris_ambient"] = loadfx("vfx/moments/ship_graveyard/hand_debris_ambient");
  level._effect["hand_free_debris_burst"] = loadfx("vfx/moments/ship_graveyard/hand_free_debris_burst");
  level._effect["hand_debris_baker_off"] = loadfx("vfx/moments/ship_graveyard/hand_debris_baker_off");
  level._effect["hand_debris_baker_on"] = loadfx("vfx/moments/ship_graveyard/hand_debris_baker_on");
  level._effect["hand_debris_baker_strain"] = loadfx("vfx/moments/ship_graveyard/hand_debris_baker_strain");
  level._effect["hand_debris_player_off"] = loadfx("vfx/moments/ship_graveyard/hand_debris_player_off");
  level._effect["hand_debris_player_on"] = loadfx("vfx/moments/ship_graveyard/hand_debris_player_on");
  level._effect["hand_debris_strain_forearm"] = loadfx("vfx/moments/ship_graveyard/hand_debris_strain_forearm");
  level._effect["hand_debris_strain_wrist"] = loadfx("vfx/moments/ship_graveyard/hand_debris_strain_wrist");
  level._effect["metal_plate_bubbles"] = loadfx("vfx/moments/ship_graveyard/metal_plate_bubbles");
  level._effect["underwater_impact_vehicle_heli"] = loadfx("vfx/moments/ship_graveyard/underwater_impact_vehicle_heli");
  level._effect["underwater_impact_vehicle_cheap"] = loadfx("vfx/moments/ship_graveyard/underwater_impact_vehicle_cheap");
  level._effect["lcs_back_bubbles"] = loadfx("vfx/moments/ship_graveyard/bubbles_ship_sinking_wide");
  level._effect["lcs_back_mess"] = loadfx("vfx/moments/ship_graveyard/ship_mess_pushout");
  level._effect["vfx_lcs_collapsing"] = loadfx("vfx/moments/ship_graveyard/vfx_lcs_collapsing");
  level._effect["ship_sinking_white_water_lg"] = loadfx("vfx/moments/ship_graveyard/ship_sinking_white_water_lg");
  level._effect["dead_bodies_underwater"] = loadfx("vfx/moments/ship_graveyard/dead_bodies_underwater");
  level._effect["underwater_fire_field"] = loadfx("vfx/moments/ship_graveyard/underwater_fire_field");
  level._effect["underwater_fire_field_core"] = loadfx("vfx/moments/ship_graveyard/underwater_fire_field_core");
  level._effect["vfx_fire_fuel_ocean_top"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_fuel_ocean_top");
  level._effect["falling_metal_debris_underwater"] = loadfx("vfx/ambient/misc/falling_metal_debris_underwater");
  level._effect["falling_metal_burst"] = loadfx("vfx/ambient/misc/falling_metal_debris_underwater_burst");
  level._effect["falling_support_beam"] = loadfx("vfx/ambient/misc/falling_support_beam_underwater");
  level._effect["bubbles_ship_sinking_wide"] = loadfx("vfx/moments/ship_graveyard/bubbles_ship_sinking_wide");
  level._effect["underwater_impact_vehicle_large"] = loadfx("vfx/moments/ship_graveyard/underwater_impact_vehicle_large");
  level._effect["underwater_impact_wreckage_long"] = loadfx("vfx/moments/ship_graveyard/underwater_impact_wreckage_long");
  level._effect["boat_collapse_silt_runner"] = loadfx("vfx/moments/ship_graveyard/boat_collapse_silt_runner");
  level._effect["boat_collapse_debris_runner"] = loadfx("vfx/moments/ship_graveyard/boat_collapse_debris_runner");
  level._effect["sm_dust"] = loadfx("fx/impacts/footstep_dust");
  level._effect["boat_fall_impact"] = loadfx("fx/smoke/underwater_impact_vehicle_dark");
  level._effect["boat_fall_impact_small"] = loadfx("fx/smoke/underwater_impact_largehit");
  level._effect["boat_fall_impact_fast"] = loadfx("fx/water/underwater_impact_vehicle_fast_dark");
  level._effect["falling_box_bubbles"] = loadfx("fx/_requests/ship_graveyard/underwater_obj_trail");
  level._effect["falling_car_bubbles"] = loadfx("fx/_requests/ship_graveyard/underwater_obj_trail_small");
  level._effect["big_wreck_ceiling_collapse"] = loadfx("fx/explosions/wall_explosion_1");

  if(!getdvarint("r_reflectionProbeGenerate"))
    maps\createfx\ship_graveyard_fx::main();

  maps\createfx\ship_graveyard_sound::main();
}

surface_fx() {
  maps\_ocean::setup_ocean();
  level._effect["abv_ocean_ripple"] = loadfx("fx/misc/ny_harbor_ripple");
  level._effect["abv_raindrops_screen_3"] = loadfx("vfx/gameplay/screen_effects/raindrop_loop");
  level._effect["abv_raindrops_screen_5"] = loadfx("vfx/gameplay/screen_effects/raindrop_loop");
  level._effect["abv_raindrops_screen_10"] = loadfx("vfx/gameplay/screen_effects/raindrop_loop");
  level._effect["abv_raindrops_screen_20"] = loadfx("vfx/gameplay/screen_effects/raindrop_loop");
  level._effect["abv_lightning"] = loadfx("fx/weather/lightning");
  level._effect["abv_lightning_bolt"] = loadfx("fx/weather/lightning_bolt");
  level._effect["abv_lightning_bolt_lrg"] = loadfx("fx/weather/lightning_bolt_lrg");
  maps\_weather::addlightningexploder(10);
  maps\_weather::addlightningexploder(11);
  maps\_weather::addlightningexploder(12);
  level.nextlightning = gettime() + 1;
  common_scripts\utility::flag_init("fx_screen_raindrops");
  common_scripts\utility::flag_init("fx_player_watersheeting");
}

water_particulates() {
  level endon("stop_particulates");
  thread water_particulates_while_moving();

  for(;;) {
    var_0 = anglesToForward(level.player.angles) * 96;
    playFX(common_scripts\utility::getfx("ocean_particulate_player"), level.player.origin + var_0);
    playFX(common_scripts\utility::getfx("ocean_particulate_player_view"), level.player.origin + var_0);
    wait 0.6;
  }
}

water_particulates_while_moving() {
  level endon("stop_particulates");

  for(;;) {
    var_0 = level.player.origin;
    wait 0.1;

    if(distance(var_0, level.player.origin) > 1) {
      var_1 = vectortoangles(level.player.origin - var_0);
      var_2 = anglesToForward(var_1) * 256;
      playFX(common_scripts\utility::getfx("ocean_particulate_player_mov"), level.player.origin + var_2);
    }
  }
}

trigger_fish_school(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_2 notify(var_1);
}

mask_interactives() {
  var_0 = getEntArray("interactives_mask_first_area", "script_noteworthy");
  var_1 = getEntArray("interactives_mask_last_area", "script_noteworthy");
  maps\_utility::mask_interactives_in_volumes(var_1);
  maps\_utility::mask_interactives_in_volumes(var_0);
  level waittill("load_finished");
  common_scripts\utility::flag_wait("start_swim");
  common_scripts\utility::array_thread(var_0, maps\_utility::activate_interactives_in_volume);
  common_scripts\utility::flag_wait("start_new_trench");
  maps\_utility::mask_interactives_in_volumes(var_0);
  common_scripts\utility::array_thread(var_1, maps\_utility::activate_interactives_in_volume);
}

weld_breach_fx(var_0, var_1) {
  var_0 waittillmatch("single anim", "torch_on");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater_ignition"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater_torch" + var_1), self, "tag_origin");
  var_0 waittillmatch("single anim", "torch_cut");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater"), self, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("welding_underwater_torch" + var_1), self, "tag_origin");
  var_0 waittillmatch("single anim", "torch_stop_cut");
  stopFXOnTag(common_scripts\utility::getfx("welding_underwater"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater_off"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater_torch" + var_1), self, "tag_origin");
  var_0 waittillmatch("single anim", "torch_cut");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater"), self, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("welding_underwater_torch" + var_1), self, "tag_origin");
  var_0 waittillmatch("single anim", "torch_stop_cut");
  stopFXOnTag(common_scripts\utility::getfx("welding_underwater"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater_off"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("welding_underwater_torch" + var_1), self, "tag_origin");
  var_0 waittillmatch("single anim", "torch_off");
  stopFXOnTag(common_scripts\utility::getfx("welding_underwater_torch" + var_1), self, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("welding_underwater_ignition"), self, "tag_origin");
}