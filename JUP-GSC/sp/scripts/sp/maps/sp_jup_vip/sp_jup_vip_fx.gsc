/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_vip\sp_jup_vip_fx.gsc
***********************************************************/

#using script_51f0a664afd44022;
#using script_5e60754c97311cd;
#using scripts\common\basic_wind;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace sp_jup_vip_fx;

function main() {
  level._effect["vfx_vip_jet_trails"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_jet_trails.vfx");
  level._effect["vfx_vip_jet_thrusters"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_jet_thrusters.vfx");
  level._effect["vfx_vip_heli_lights_blinkies"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_heli_lights_blinkies.vfx");
  level._effect["vfx_vip_heli_light_cockpit"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_heli_light_cockpit.vfx");
  level._effect["vfx_cargo_truck_headlight_lensflare_l_vip"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_cargo_truck_headlight_lensflare_l_vip.vfx");
  level._effect["vfx_cargo_truck_headlight_lensflare_r_vip"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_cargo_truck_headlight_lensflare_r_vip.vfx");
  level._effect["vfx_vip_dust_motes_elevator_local"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dust_motes_elevator_local.vfx");
  level._effect["vfx_flashlight_npc_perf_short_vip"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_flashlight_npc_perf_short_vip.vfx");
  level._effect["vfx_vip_elevator_flare_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_elevator_flare_01.vfx");
  level._effect["vfx_vip_dust_motes_elevator"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dust_motes_elevator.vfx");
  level._effect["vfx_vip_mayhem_tarp_04"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_mayhem_tarp_04.vfx");
  level._effect["vfx_vip_mayhem_tarp_03"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_mayhem_tarp_03.vfx");
  level._effect["vfx_vip_riot_debris_03"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_03.vfx");
  level._effect["vfx_vip_light_searchlight_mg_move"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_mg_move.vfx");
  level._effect["vfx_vip_mak_cell_smoke"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_mak_cell_smoke.vfx");
  level._effect["vfx_vip_reveal_flare_env_04"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_flare_env_04.vfx");
  level._effect["vfx_vip_yard_truck_exp"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_yard_truck_exp.vfx");
  level._effect["vfx_vip_light_searchlight_mg_death"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_mg_death.vfx");
  level._effect["vfx_vip_light_searchlight_mg"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_mg.vfx");
  level._effect["vfx_vip_muz_boat2_exfil_slide"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_muz_boat2_exfil_slide.vfx");
  level._effect["vfx_vip_muz_boat_exfil_slide"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_muz_boat_exfil_slide.vfx");
  level._effect["vfx_vip_gulag_dest_trail_med_1"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_gulag_dest_trail_med_1.vfx");
  level._effect["vfx_vip_boat_wake_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_boat_wake_01.vfx");
  level._effect["vfx_vip_muz_boat_exfil_vista"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_muz_boat_exfil_vista.vfx");
  level._effect["vfx_vip_flare_ending_linger_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_flare_ending_linger_01.vfx");
  level._effect["vfx_vip_flare_warm_sml_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_flare_warm_sml_02.vfx");
  level._effect["vfx_vip_ceiling_flare_armory_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_ceiling_flare_armory_01.vfx");
  level._effect["vfx_grandprix_boat_wake_01"] = loadfx("vfx/iw9/level/mp_grandprix/vfx_grandprix_boat_wake_01.vfx");
  level._effect["vfx_vip_heli_dust_tread_water"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_heli_dust_tread_water.vfx");
  level._effect["vfx_vip_reveal_flare_env_03"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_flare_env_03.vfx");
  level._effect["vfx_vip_reveal_flare_env_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_flare_env_02.vfx");
  level._effect["vfx_vip_reveal_flare_env_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_flare_env_01.vfx");
  level._effect["vfx_vip_reveal_cigarette_03"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_cigarette_03.vfx");
  level._effect["vfx_vip_mak_cell_breach_dust_body_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_mak_cell_breach_dust_body_02.vfx");
  level._effect["vfx_vip_reveal_cigarette_mouth"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_cigarette_mouth.vfx");
  level._effect["vfx_vip_reveal_cigarette_core_falling_ash"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_cigarette_core_falling_ash.vfx");
  level._effect["vfx_vip_reveal_cigarette_core"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_cigarette_core.vfx");
  level._effect["vfx_vip_riot_debris_anim_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_anim_01.vfx");
  level._effect["vfx_vip_riot_debris_anim_throw_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_anim_throw_01.vfx");
  level._effect["vfx_vip_heli_dust_idle_water"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_heli_dust_idle_water.vfx");
  level._effect["vfx_vip_rain_cam_burst"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_cam_burst.vfx");
  level._effect["vfx_vip_rain_ledge_mayh_06"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_ledge_mayh_06.vfx");
  level._effect["vfx_vip_rain_drip_mayh_tarp_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_drip_mayh_tarp_01.vfx");
  level._effect["vfx_vip_rain_ledge_mayh_05"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_ledge_mayh_05.vfx");
  level._effect["vfx_vip_rain_ledge_mayh_04"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_ledge_mayh_04.vfx");
  level._effect["vfx_vip_rain_ledge_mayh_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_ledge_mayh_01.vfx");
  level._effect["vfx_vip_rain_ledge_mayh_03"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_ledge_mayh_03.vfx");
  level._effect["vfx_vip_rain_ledge_mayh_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_ledge_mayh_02.vfx");
  level._effect["vfx_vip_riot_debris_anim_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_anim_01.vfx");
  level._effect["vfx_vip_riot_debris_anim_throw_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_anim_throw_01.vfx");
  level._effect["vfx_vip_heli_dust_idle_water"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_heli_dust_idle_water.vfx");
  level._effect["vfx_vip_rain_cam_burst"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_cam_burst.vfx");
  level._effect["vfx_vip_reveal_cigarette_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_cigarette_02.vfx");
  level._effect["vfx_vip_reveal_cigarette_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_cigarette_01.vfx");
  level._effect["vfx_vip_reveal_flare_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_flare_02.vfx");
  level._effect["vfx_vip_reveal_flare_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_reveal_flare_01.vfx");
  level._effect["vfx_vip_riot_debris_anim_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_anim_01.vfx");
  level._effect["vfx_vip_riot_debris_anim_throw_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_anim_throw_01.vfx");
  level._effect["vfx_vip_heli_dust_idle_water"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_heli_dust_idle_water.vfx");
  level._effect["vfx_vip_rain_cam_burst"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_cam_burst.vfx");
  level._effect["vfx_vip_tread_drive_slow_med_mud"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_tread_drive_slow_med_mud.vfx");
  level._effect["vfx_vip_cin_descent_muzzle_lights"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_cin_descent_muzzle_lights.vfx");
  level._effect["vfx_vip_flare_alarm_light_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_flare_alarm_light_01.vfx");
  level._effect["vfx_vip_intro_rain_on_arm"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_rain_on_arm.vfx");
  level._effect["vfx_vip_intro_rain_on_back"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_rain_on_back.vfx");
  level._effect["vfx_vip_intro_rain_on_head"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_rain_on_head.vfx");
  level._effect["vfx_vip_intro_camera_water_dive"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_camera_water_dive.vfx");
  level._effect["vfx_vip_intro_camera_water_full"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_camera_water_full.vfx");
  level._effect["vfx_vip_intro_camera_water_divedown"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_camera_water_divedown.vfx");
  level._effect["vfx_vip_intro_camera_water_interaction"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_camera_water_interaction.vfx");
  level._effect["vfx_vip_intro_camera_water_droplets"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_intro_camera_water_droplets.vfx");
  level._effect["vfx_vip_steam_manhole"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_steam_manhole.vfx");
  level._effect["vfx_vip_nightvision_beacon_grenade"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_nightvision_beacon_grenade.vfx");
  level._effect["vfx_vip_piperoom_fan_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_piperoom_fan_02.vfx");
  level._effect["vfx_vip_piperoom_fan_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_piperoom_fan_01.vfx");
  level._effect["vfx_vip_glowstick_glow_red"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red.vfx");
  level._effect["vfx_vip_glowstick_glow_red_bright"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_bright.vfx");
  level._effect["vfx_vip_glowstick_glow_red_dim"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_dim.vfx");
  level._effect["vfx_vip_glowstick_glow_red_dim_perf"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_dim_perf.vfx");
  level._effect["vfx_vip_glowstick_glow_red_r_dim_perf"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_r_dim_perf.vfx");
  level._effect["vfx_vip_glowstick_glow_red_player_cine"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_player_cine.vfx");
  level._effect["vfx_vip_glowstick_glow_red_r_dim"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_r_dim.vfx");
  level._effect["vfx_vip_glowstick_glow_red_r"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_r.vfx");
  level._effect["vfx_vip_glowstick_glow_red_r_bright"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_r_bright.vfx");
  level._effect["vfx_vip_glowstick_glow_red_sm"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_sm.vfx");
  level._effect["vfx_vip_glowstick_glow_red_r_sm"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_r_sm.vfx");
  level._effect["vfx_vip_glowstick_glow_red_player"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_glowstick_glow_red_player.vfx");
  level._effect["vfx_vip_cin_controlbreach_muzzle_lights"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_cin_controlbreach_muzzle_lights.vfx");
  level._effect["vfx_vip_nightvision_beacon"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_nightvision_beacon.vfx");
  level._effect["vfx_vip_mak_cell_breach"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_mak_cell_breach.vfx");
  level._effect["vfx_vip_door_breach_c4_light_blink"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_door_breach_c4_light_blink.vfx");
  level._effect["vfx_vip_uw_wavefoam"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_uw_wavefoam.vfx");
  level._effect["vfx_vip_boat_waterjet_moving_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_boat_waterjet_moving_01.vfx");
  level._effect["vfx_swim_underwater_cam_debris_dirty"] = loadfx("vfx/iw9/core/swimming/vfx_swim_underwater_cam_debris_dirty.vfx");
  level._effect["vfx_swim_underwater_cam_debris_clean"] = loadfx("vfx/iw9/core/swimming/vfx_swim_underwater_cam_debris_clean.vfx");
  level._effect["vfx_vip_dpv_sceen_glow"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dpv_sceen_glow.vfx");
  level._effect["vfx_vip_light_searchlight_wall_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_wall_02.vfx");
  level._effect["vfx_vip_light_searchlight_wall_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_wall_01.vfx");
  level._effect["vfx_vip_light_searchlight_wall_03"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_wall_03.vfx");
  level._effect["vfx_vip_exp_distraction_vista_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_exp_distraction_vista_01.vfx");
  level._effect["vfx_vip_water_drips_grate_1x1"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_drips_grate_1x1.vfx");
  level._effect["vfx_vip_water_impacts_shpere"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_impacts_shpere.vfx");
  level._effect["vfx_vip_water_edges_wall_top_03"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_edges_wall_top_03.vfx");
  level._effect["sp_jup_vip_lf_circular_white"] = loadfx("vfx/jup/level/sp_jup_vip/sp_jup_vip_lf_circular_white.vfx");
  level._effect["vfx_vip_rain_gusts_rnr"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_gusts_rnr.vfx");
  level._effect["vfx_flashlight_npc_descend"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_flashlight_npc_descend.vfx");
  level._effect["vfx_beach_wave_crash_vip"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_beach_wave_crash_vip.vfx");
  level._effect["vfx_vip_water_edges_line_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_edges_line_01.vfx");
  level._effect["vfx_vip_water_edges_wall_top_02"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_edges_wall_top_02.vfx");
  level._effect["vfx_vip_water_edges_wall_top_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_edges_wall_top_01.vfx");
  level._effect["vfx_shipaf_ocean_wavecrests_mist_01"] = loadfx("vfx/iw9/level/shipaf/vfx_shipaf_ocean_wavecrests_mist_01.vfx");
  level._effect["vfx_vip_ocean_wavecrests_mist_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_ocean_wavecrests_mist_01.vfx");
  level._effect["vfx_vip_rain_ground_5x5_wash_rnr"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_ground_5x5_wash_rnr.vfx");
  level._effect["vfx_vip_lightning_strike_cam"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lightning_strike_cam.vfx");
  level._effect["vfx_vip_rain_vista_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_rain_vista_01.vfx");
  level._effect["vfx_vip_light_floodlight_yard"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_floodlight_yard.vfx");
  level._effect["vfx_vip_lf_red"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lf_red.vfx");
  level._effect["vfx_vip_lf_red_blink"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lf_red_blink.vfx");
  level._effect["vfx_vip_lf_searchlight_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lf_searchlight_01.vfx");
  level._effect["vfx_vip_lf_square"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lf_square.vfx");
  level._effect["vfx_flashlight_npc_perf"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf.vfx");
  level._effect["vfx_flashlight_npc_perf_short"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf_short.vfx");
  level._effect["vfx_vip_light_searchlight_boat"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_boat.vfx");
  level._effect["vfx_vip_light_searchlight_boat_uw"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_boat_uw.vfx");
  level._effect["vfx_vip_light_searchlight_ocean_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_ocean_01.vfx");
  level._effect["vfx_vip_dust_falling_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dust_falling_01.vfx");
  level._effect["vfx_vip_dust_falling_lamp_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dust_falling_lamp_01.vfx");
  level._effect["vfx_vip_dust_falling_stair_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dust_falling_stair_01.vfx");
  level._effect["vfx_vip_dust_motes_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dust_motes_01.vfx");
  level._effect["vfx_vip_dust_ground_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dust_ground_01.vfx");
  level._effect["vfx_vip_water_drip_splash_indoor_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_drip_splash_indoor_01.vfx");
  level._effect["vfx_vip_water_drip_indoor_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_drip_indoor_01.vfx");
  level._effect["vfx_vip_flare_warm_sml_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_flare_warm_sml_01.vfx");
  level._effect["vfx_nvg_light_player_vip_proto"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_nvg_light_player_vip_proto.vfx");
  level._effect["vfx_vip_water_diver_ripple_intro"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_diver_ripple_intro.vfx");
  level._effect["vfx_vip_water_diver_dive_in_intro"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_diver_dive_in_intro.vfx");
  level._effect["vfx_vip_water_diver_bubble_trail_1"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_diver_bubble_trail_1.vfx");
  level._effect["vfx_vip_diver_dpv_distortion_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_diver_dpv_distortion_01.vfx");
  level._effect["vfx_vip_diver_dpv_lightglow_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_diver_dpv_lightglow_01.vfx");
  level._effect["vfx_vip_water_diver_bubble_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_water_diver_bubble_01.vfx");
  level._effect["vfx_vip_uw_gpu_silt_globe"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_uw_gpu_silt_globe.vfx");
  level._effect["vfx_vip_uw_cam_breath"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_uw_cam_breath.vfx");
  level._effect["vfx_vip_uw_cam_debris"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_uw_cam_debris.vfx");
  level._effect["vfx_vip_fishes_intro"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_fishes_intro.vfx");
  level._effect["vfx_light_underwater"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_light_underwater.vfx");
  level._effect["vfx_vip_dpv_light_ally"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dpv_light_ally.vfx");
  level._effect["vfx_light_underwater_vol"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_light_underwater_vol.vfx");
  level._effect["vfx_hind_spotlight"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_light_searchlight_heli.vfx");
  level._effect["vfx_vip_dpv_light_ally_bright"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_dpv_light_ally_bright.vfx");
  level._effect["vfx_light_laser_fill"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_light_laser_fill.vfx");
  level._effect["heli_water"] = loadfx("vfx/code/tread/heli_water.vfx");
  level._effect["vfx_light_mak_cig"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_light_mak_cig.vfx");
  level._effect["vfx_light_mak_flare"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_light_mak_flare.vfx");
  level._effect["vfx_vip_riot_debris_mattress"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_mattress.vfx");
  level._effect["vfx_vip_riot_debris_guard"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_riot_debris_guard.vfx");
  level._effect["vfx_vip_uw_silt_diver_dpv_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_uw_silt_diver_dpv_01.vfx");
  level._effect["vfx_vip_uw_silt_diver_dpv_player_01"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_uw_silt_diver_dpv_player_01.vfx");
  level._effect["vfx_bg_tracers"] = loadfx("vfx/iw8/level/marines/vfx_bg_tracers.vfx");
  level._effect["vfx_vip_lgt_heli_search"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lgt_heli_search.vfx");
  level._effect["vfx_mg_tracer"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_tracer_mg_tower.vfx");
  level._effect["vfx_mg_muzzle"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_muz_mg_tower.vfx");
  level._effect["vfx_vip_lgt_boat_search"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lgt_boat_search.vfx");
  level._effect["vfx_vip_lensflare_headlight_white"] = loadfx("vfx/jup/level/sp_jup_vip/vfx_vip_lensflare_headlight_white.vfx");

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {}

  flag_init("rain_cam_burst");
  thread rain_cam_burst();
  flag_init("riot_mattressfall");
  flag_init("vfx_flares_trigger");
  thread vfx_flares_trigger();
  flag_init("vfx_cliff_tree");
  thread vfx_cliff_tree();
  thread function_3e379519d32d703d();
  thread function_fd988025c8bf1a4b();
  thread function_b8e64b7ca251968b();
  thread function_e0f6700b1974ddd6();
  thread function_ee52fa19845fd86d();
  setsaveddvar(@ "hash_81b9a5d52e0be6ac", 20);
  setsaveddvar(@ "hash_a04dd064784d0939", 0.02);
  setsaveddvar(@ "hash_3b399a1604643dec", "-0.5 -1 -10");
  setsaveddvar(@ "hash_aead3f0db524f5d", 0);
  setsaveddvar(@ "hash_16a28dae4d06cb5f", 2000);
  setsaveddvar(@ "hash_dab366f405822e6c", 0.3);
  setsaveddvar(@ "hash_8ae8517615610e73", "-200 -200 -20");
  setsaveddvar(@ "hash_71fe8b216d50a24c", 0.25);
  setsaveddvar(@ "hash_402173c7dbee15d9", 15);
  thread function_b9e130d444d299c9("wall_ascend", "zone01");
  thread function_b9e130d444d299c9("rooftop_ascend", "zone02");
  thread function_b9e130d444d299c9("yard", "zone03");
  thread function_b9e130d444d299c9("wall_top", "zone04");
  thread function_b9e130d444d299c9("scuba_opening", "zone05");
  thread function_b9e130d444d299c9("scuba", "zone06");
  thread function_b9e130d444d299c9("piperoom", "zone07");
  thread function_b9e130d444d299c9("descent", "zone08");
  thread function_b9e130d444d299c9("descent2", "zone09");
  thread function_b9e130d444d299c9("dungeon", "zone10");
  thread function_b9e130d444d299c9("armory", "zone11");
  thread function_b9e130d444d299c9("maintenance", "zone12");
  thread function_b9e130d444d299c9("yard2", "zone13");
  thread function_b9e130d444d299c9("cliffs", "zone14");
  thread function_b9e130d444d299c9("exfil", "zone15");
  thread function_b9e130d444d299c9("helipad", "zone16");
  thread function_b9e130d444d299c9("yard3", "zone17");
}

function function_b8e64b7ca251968b() {
  flag_wait("flag_start_wall_ascend");

  if(isDefined(level.wind_ent)) {
    stop_wind(level.wind_ent);
  }
}

function rain_cam_burst() {
  flag_wait("rain_cam");
  exploder("rain_cam_burst");
}

function function_e0f6700b1974ddd6() {
  flag_wait("vfx_start_gulag_destruction");
  playmayhem("vfx_gulag_destrution_start");
  wait 0.1;
  exploder("aftermath1");
  stop_exploder("mg_nest_light");
  stop_exploder("mg_nest_light_move");
  wait 0.1;
  earthquake(0.7, 0.35, level.player.origin, 200);
  wait 0.35;
  earthquake(0.3, 0.55, level.player.origin, 200);
  wait 2.45;
  earthquake(0.09, 0.6, level.player.origin, 200);
  wait 2.5;
  earthquake(0.07, 0.55, level.player.origin, 200);
  wait 2.3;
  earthquake(0.07, 0.65, level.player.origin, 200);
  wait 1.1;
  exploder("aftermath3");
  earthquake(0.25, 0.35, level.player.origin, 200);
  wait 0.35;
  exploder("aftermath2");
  earthquake(0.08, 0.6, level.player.origin, 200);
  wait 1.95;
  earthquake(0.07, 0.6, level.player.origin, 200);
}

function function_ee52fa19845fd86d() {
  flag_wait("flag_begin_explosions");
  exploder("fx_bravo_intro_distraction");
}

function function_3e379519d32d703d() {
  wait 0.1;
  flag_wait("riot_mattressfall");
  exploder("mattressfall");
  thread namespace_165c742e346e899e::mattress_drop();
}

function function_fd988025c8bf1a4b() {
  flag_wait("flag_player_over_wall");
  wait 0.1;
  exploder("heli_idle");
  flag_wait("flag_infil_chopper_land");
  stop_exploder("heli_idle");
}

function vfx_flares_trigger() {
  wait 0.1;
  flag_wait("vfx_flares_trigger");
}

function vfx_cliff_tree() {
  flag_wait("vfx_cliff_tree");
  exploder("vfx_tree_impacts_01");
  playmayhem("vfx_vip_mayh_tree_02");
  wait 0.1;
  thread namespace_165c742e346e899e::function_79c32affccf83e0();
  playmayhem("vfx_vip_mayh_tree_01");
  source = level.player.origin;
  pitch = 7;
  yaw = 7;
  roll = 4;
  duration = 1.7;
  durationfadeup = 0;
  durationfadedown = 1.2;
  freqpitch = 1.5;
  freqyaw = 0.2;
  freqroll = 0.2;
  waitframe();
  screenshake(source, pitch, yaw, roll, duration, durationfadeup, durationfadedown, 0, freqpitch, freqyaw, freqyaw);
  playrumbleonposition("grenade_rumble", level.player.origin);
}