/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_fx.gsc
*****************************************************************/

#using scripts\common\anim;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace sp_jup_tundra_fx;

function main() {
  level._effect["vfx_tun_env_snow_stomp_med_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_stomp_med_1.vfx");
  level._effect["vfx_tun_env_snow_chunks_fall_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_chunks_fall_3.vfx");
  level._effect["vfx_jup_tun_veh_death_exp_foscar"] = loadfx("vfx/jup/level/sp_tundra/vfx_jup_tun_veh_death_exp_foscar.vfx");
  level._effect["vfx_tun_env_head_steam_b"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_head_steam_b.vfx");
  level._effect["vfx_tun_env_head_steam_a"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_head_steam_a.vfx");
  level._effect["vfx_tun_env_rpg_impact_fire"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_rpg_impact_fire.vfx");
  level._effect["vfx_tun_env_head_steam"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_head_steam.vfx");
  level._effect["vfx_tun_env_fire_smoke_veh_1b_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_smoke_veh_1b_sm.vfx");
  level._effect["vfx_tun_fire_truck_chd_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_truck_chd_1.vfx");
  level._effect["vfx_tun_env_fire_crawl_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_crawl_1.vfx");
  level._effect["vfx_tun_env_fire_smoke_veh_1a_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_smoke_veh_1a_sm.vfx");
  level._effect["vfx_tun_fire_vehicle_chd_5"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_vehicle_chd_5.vfx");
  level._effect["vfx_tun_env_fire_ground_med_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_ground_med_1.vfx");
  level._effect["vfx_tun_env_smoke_veh_1_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_smoke_veh_1_med.vfx");
  level._effect["vfx_tun_fire_vehicle_chd_4"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_vehicle_chd_4.vfx");
  level._effect["vfx_tun_env_fire_ground_lrg_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_ground_lrg_2.vfx");
  level._effect["vfx_tun_env_room_mist_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_room_mist_1.vfx");
  level._effect["vfx_tun_env_explo_primary_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_explo_primary_2.vfx");
  level._effect["vfx_tun_env_shockwave_dust_04"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_shockwave_dust_04.vfx");
  level._effect["vfx_tun_env_shockwave_dust_03"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_shockwave_dust_03.vfx");
  level._effect["vfx_tun_env_veh_pickup_2014_fire_linger_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_pickup_2014_fire_linger_med.vfx");
  level._effect["vfx_tun_env_veh_pickup_2014_smk_heavy"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_pickup_2014_smk_heavy.vfx");
  level._effect["vfx_tun_env_shockwave_dust_02"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_shockwave_dust_02.vfx");
  level._effect["vfx_tun_env_snow_chunks_fall_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_chunks_fall_3.vfx");
  level._effect["vfx_tun_env_shockwave_dust_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_shockwave_dust_01.vfx");
  level._effect["vfx_tun_env_fire_ground_1_xsm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_ground_1_xsm.vfx");
  level._effect["vfx_tun_env_fire_grounded_1_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_grounded_1_med.vfx");
  level._effect["vfx_tun_env_edge_gust_sml_02"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_edge_gust_sml_02.vfx");
  level._effect["vfx_tun_env_fire_wall_sml_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_wall_sml_01.vfx");
  level._effect["vfx_tun_env_water_drips_line_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_water_drips_line_01.vfx");
  level._effect["vfx_tun_env_veh_fire_bits_03a"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_fire_bits_03a.vfx");
  level._effect["vfx_tun_env_veh_fire_bits_02a"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_fire_bits_02a.vfx");
  level._effect["vfx_tun_env_veh_fire_bits_01a"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_fire_bits_01a.vfx");
  level._effect["vfx_tun_env_veh_fire_bits_03"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_fire_bits_03.vfx");
  level._effect["vfx_tun_env_veh_fire_bits_02"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_fire_bits_02.vfx");
  level._effect["vfx_tun_env_veh_fire_bits_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_veh_fire_bits_01.vfx");
  level._effect["vfx_tun_env_edge_gust_sml_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_edge_gust_sml_01.vfx");
  level._effect["vfx_tun_env_explo_main_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_explo_main_1.vfx");
  level._effect["vfx_tun_env_blowing_snow_amb_door_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blowing_snow_amb_door_1.vfx");
  level._effect["vfx_tun_env_fire_smoke_veh_1_xsm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_smoke_veh_1_xsm.vfx");
  level._effect["vfx_tun_env_snow_chunks_fall_1_thin"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_chunks_fall_1_thin.vfx");
  level._effect["vfx_tun_env_cold_breath_talk"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_cold_breath_talk.vfx");
  level._effect["vfx_tun_env_engine_steam"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_engine_steam.vfx");
  level._effect["vfx_tun_env_blowing_snow_amb_sm_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blowing_snow_amb_sm_1.vfx");
  level._effect["vfx_tun_env_dust_motes_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_dust_motes_med.vfx");
  level._effect["vfx_tun_env_lensflare_fluorescent"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_lensflare_fluorescent.vfx");
  level._effect["vfx_tun_env_lensflare_light_bulb"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_lensflare_light_bulb.vfx");
  level._effect["vfx_tun_env_lensflare_light_cold"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_lensflare_light_cold.vfx");
  level._effect["vfx_tun_env_fire_ground_lrg_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_ground_lrg_1.vfx");
  level._effect["vfx_tun_env_fire_ground_sm_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_ground_sm_1.vfx");
  level._effect["vfx_tun_env_lensflare_bulb_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_lensflare_bulb_1.vfx");
  level._effect["vfx_tun_camp_fog_ambient_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_camp_fog_ambient_1.vfx");
  level._effect["vfx_tun_env_camp_snow_gust_ambient_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_camp_snow_gust_ambient_1.vfx");
  level._effect["vfx_tun_env_camp_snow_gust_ambient_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_camp_snow_gust_ambient_2.vfx");
  level._effect["vfx_tun_env_fire_smoke_veh_1_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_smoke_veh_1_sm.vfx");
  level._effect["vfx_tun_env_fire_smoke_veh_1_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_smoke_veh_1_med.vfx");
  level._effect["vfx_tun_fire_ground_lrg_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_ground_lrg_1.vfx");
  level._effect["vfx_tun_env_fire_ground_med_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_ground_med_1.vfx");
  level._effect["vfx_tun_fire_ground_runner_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_ground_runner_1.vfx");
  level._effect["vfx_tun_env_fire_spots_veh_1_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_spots_veh_1_med.vfx");
  level._effect["vfx_tun_env_fire_wood_area_lg_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_wood_area_lg_1.vfx");
  level._effect["vfx_tun_env_fire_wood_area_small_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_wood_area_small_1.vfx");
  level._effect["vfx_tun_intro_snow_gust_ambient_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_intro_snow_gust_ambient_2.vfx");
  level._effect["vfx_tun_end_snow_gust_surface_run_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_end_snow_gust_surface_run_1.vfx");
  level._effect["vfx_tun_intro_snow_gust_ambient_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_intro_snow_gust_ambient_1.vfx");
  level._effect["vfx_tun_env_crane_light_red"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_crane_light_red.vfx");
  level._effect["vfx_tun_env_mist_01_lrg"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_mist_01_lrg.vfx");
  level._effect["vfx_tun_env_blowing_snow_top_mist_lrg_dark"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blowing_snow_top_mist_lrg_dark.vfx");
  level._effect["vfx_tun_env_fog_drift_05"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fog_drift_05.vfx");
  level._effect["vfx_tun_env_fire_lg_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_lg_01.vfx");
  level._effect["vfx_tun_env_dust_motes_window_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_dust_motes_window_01.vfx");
  level._effect["vfx_tun_env_pipe_smoke_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_pipe_smoke_01.vfx");
  level._effect["vfx_tun_env_chimney_smoke_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_chimney_smoke_sm.vfx");
  level._effect["vfx_tun_env_snow_chunks_fall_1_shad"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_chunks_fall_1_shad.vfx");
  level._effect["vfx_tun_env_fog_drift_02_shad"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fog_drift_02_shad.vfx");
  level._effect["vfx_tun_env_fog_drift_01_shad"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fog_drift_01_shad.vfx");
  level._effect["vfx_tun_env_falling_pine_needles"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_falling_pine_needles.vfx");
  level._effect["vfx_tun_env_snow_chunks_fall_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_chunks_fall_2.vfx");
  level._effect["vfx_tun_env_snow_chunks_fall_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_chunks_fall_1.vfx");
  level._effect["vfx_tun_env_fog_drift_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fog_drift_01.vfx");
  level._effect["vfx_tun_env_fog_drift_02"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fog_drift_02.vfx");
  level._effect["vfx_tun_env_fog_drift_03"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fog_drift_03.vfx");
  level._effect["vfx_tun_env_fog_drift_04"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fog_drift_04.vfx");
  level._effect["vfx_tun_env_edge_vapor_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_edge_vapor_01.vfx");
  level._effect["vfx_tun_env_drift_vapor_tall_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_drift_vapor_tall_01.vfx");
  level._effect["vfx_tun_env_drift_vapor_med_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_drift_vapor_med_01.vfx");
  level._effect["vfx_tun_env_drift_vapor_gnd_02"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_drift_vapor_gnd_02.vfx");
  level._effect["vfx_tun_env_drift_vapor_gnd_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_drift_vapor_gnd_01.vfx");
  level._effect["vfx_tun_env_fire_smoke_veh_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_fire_smoke_veh_med.vfx");
  level._effect["vfx_water_explosion"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_water_implosion_main_1.vfx");
  level._effect["vfx_water_explosion_cheap"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_water_implosion_1_cheap.vfx");
  level._effect["vfx_exp_lakefloor_sediment_flow_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_lakefloor_sediment_flow_dir_1.vfx");
  level._effect["vfx_exp_lakefloor_sediment_flow_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_lakefloor_sediment_flow_dir_2.vfx");
  level._effect["vfx_exp_lakefloor_sediment_flow_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_lakefloor_sediment_flow_dir_3.vfx");
  level._effect["vfx_exp_lakefloor_sediment_flow_blank"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_lakefloor_sediment_flow_dir_blank.vfx");
  level._effect["vfx_sediment_kickup_area_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_sediment_kickup_area_1.vfx");
  level._effect["vfx_sediment_kickup_area_1_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_sediment_kickup_area_1_sm.vfx");
  level._effect["vfx_sediment_kickup_area_1_xsm"] = loadfx("vfx/jup/level/sp_tundra/vfx_sediment_kickup_area_1_xsm.vfx");
  level._effect["vfx_detonator_charge_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_detonator_charge_1.vfx");
  level._effect["vfx_detonator_charge_1_initial"] = loadfx("vfx/jup/level/sp_tundra/vfx_detonator_charge_1_initial.vfx");
  level._effect["vfx_volumetric_particles_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_volumetric_particles_1.vfx");
  level._effect["vfx_water_silt_area_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_silt_area_1.vfx");
  level._effect["vfx_water_silt_area_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_silt_area_2.vfx");
  level._effect["vfx_water_player_screen_bubbles"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_player_screen_bubbles_1.vfx");
  level._effect["vfx_water_surface_ripples_area_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_surface_ripples_area_1.vfx");
  level._effect["vfx_diver_breathing_bubbles_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_1_main.vfx");
  level._effect["vfx_diver_breathing_bubbles_1_rb2"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_1_main_rb2.vfx");
  level._effect["vfx_decal_test_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_decal_test_1.vfx");
  level._effect["vfx_player_water_screen_blur"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_player_screen_distortion_blur.vfx");
  level._effect["vfx_water_caustic_rays_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_caustic_rays_1.vfx");
  level._effect["vfx_water_caustic_rays_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_caustic_rays_2.vfx");
  level._effect["vfx_water_caustic_rays_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_caustic_rays_3.vfx");
  level._effect["vfx_water_caustic_rays_4"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_caustic_rays_4.vfx");
  level._effect["vfx_water_caustic_rays_5"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_caustic_rays_5.vfx");
  level._effect["vfx_water_caustic_rays_5a"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_caustic_rays_5a.vfx");
  level._effect["vfx_sediment_ambient_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_lakefloor_sediment_ambient_1.vfx");
  level._effect["vfx_sediment_ambient_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_lakefloor_sediment_ambient_2.vfx");
  level._effect["vfx_gasp_bubbles_distress_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_gasp_distress_1_main.vfx");
  level._effect["vfx_gasp_bubbles_distress_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_gasp_distress_2_main.vfx");
  level._effect["vfx_gasp_bubbles_distress_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_gasp_distress_3_main.vfx");
  level._effect["vfx_gasp_bubbles_distress_4"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_gasp_distress_4_main.vfx");
  level._effect["vfx_glass_shatter_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_glass_shatter_1.vfx");
  level._effect["vfx_glass_shatter_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_glass_shatter_2.vfx");
  level._effect["vfx_drill_bubbles_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_drill_bubbles_1_main.vfx");
  level._effect["vfx_water_muzzleflash_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_muzzle_flash_1.vfx");
  level._effect["vfx_water_blood_gush_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_1.vfx");
  level._effect["vfx_water_blood_gush_2_chd"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_1_chd_2.vfx");
  level._effect["vfx_water_blood_gush_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_2.vfx");
  level._effect["vfx_water_blood_gush_2a"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_2a.vfx");
  level._effect["vfx_water_blood_gush_2b"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_2b.vfx");
  level._effect["vfx_water_blood_gush_2c"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_2c.vfx");
  level._effect["vfx_water_blood_gush_2d"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_2d.vfx");
  level._effect["vfx_water_blood_gush_2e"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_blood_gush_2e.vfx");
  level._effect["vfx_sunflare_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_sun_flare_1.vfx");
  level._effect["vfx_vehicle_drive_shadow_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_vehicle_drive_shadow_1.vfx");
  level._effect["vfx_player_screen_condensation_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_player_screen_condensation_1.vfx");
  level._effect["vfx_player_mask_condensation_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_player_mask_condensation_1.vfx");
  level._effect["vfx_ice_cracks_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_ice_cracks_1.vfx");
  level._effect["vfx_blood_turbulence_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_blood_turbulence_1.vfx");
  level._effect["vfx_flashlight_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_flashlight_1.vfx");
  level._effect["vfx_end_snow_gust_surface_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_end_snow_gust_surface_run_1.vfx");
  level._effect["vfx_end_snow_gust_surface_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_end_snow_gust_surface_run_2.vfx");
  level._effect["vfx_end_snow_gust_surface_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_end_snow_gust_surface_run_3.vfx");
  level._effect["vfx_end_snow_gust_edge_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_end_snow_gust_edge_run_1.vfx");
  level._effect["vfx_snowdrift"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_shipyard_snowdrift_obscure_1.vfx");
  level._effect["vfx_snowdrift_screen"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_snowdrift_obscure_1_screen.vfx");
  level._effect["vfx_shipyard_fog_ambient_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_shipyard_fog_ambient_1.vfx");
  level._effect["vfx_finale_fog_ambient_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_fog_ambient_1.vfx");
  level._effect["vfx_vista_fog_background_oriented"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_background_fog_oriented.vfx");
  level._effect["vfx_finale_fog_background_oriented"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_background_fog_oriented.vfx");
  level._effect["vfx_finale_gust_background_layers"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_background_wind_gust_layers.vfx");
  level._effect["vfx_lakebed_rising_bubbles"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_lakebed_bubbles_1_loop.vfx");
  level._effect["vfx_end_snow_fall_edge_line"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_fall_edge_line.vfx");
  level._effect["vfx_cliff_weather_wind_gust_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_cliff_wind_burst_1.vfx");
  level._effect["vfx_cliff_weather_wind_gust_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_cliff_wind_burst_2.vfx");
  level._effect["vfx_cliff_weather_circling_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_cliff_wind_gust_circling_1.vfx");
  level._effect["vfx_finale_veh_destroyed_fire_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_smoke_plume_veh_1a.vfx");
  level._effect["vfx_finale_veh_destroyed_fire_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_smoke_plume_veh_2a.vfx");
  level._effect["vfx_finale_veh_destroyed_fire_2_wind_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_smoke_plume_veh_2a_wind_1.vfx");
  level._effect["vfx_finale_veh_destroyed_fire_2_wind_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_smoke_plume_veh_2a_wind_2.vfx");
  level._effect["vfx_finale_blood_pool_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blood_pool_1.vfx");
  level._effect["vfx_tun_underwater_fish_1_med"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_fish_1_med.vfx");
  level._effect["vfx_tun_underwater_ice_hit_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_ice_hit_1.vfx");
  level._effect["vfx_tun_underwater_fish_1_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_fish_1_sm.vfx");
  level._effect["vfx_tun_underwater_fish_3_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_fish_3_sm.vfx");
  level._effect["vfx_tun_underwater_fish_school_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_fish_school_01.vfx");
  level._effect["vfx_tun_underwater_ice_hit_0"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_ice_hit_0.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_1_hero"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_1.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_2_hero"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_1b.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_1b.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_2.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_3.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_4"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_4.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_1_loop"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_1_loop.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_2_loop"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_2_loop.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_3_loop"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_3_loop.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_4_loop"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_4_loop.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_1_lights"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_1_lights.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_2_lights"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_2_lights.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_3_lights"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_3_lights.vfx");
  level._effect["vfx_tun_underwater_veh_sink_bubbles_4_lights"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_veh_sink_bubbles_4_lights.vfx");
  level._effect["vfx_tun_underwater_debris_ice_1"] = loadfx("vfx/test/quinn/johnstonhms/test/vfx_tun_underwater_debris_ice_1.vfx");
  level._effect["vfx_tun_underwater_mask_off"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_mask_off.vfx");
  level._effect["vfx_tun_underwater_mask_on"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_mask_on.vfx");
  level._effect["vfx_tun_underwater_welding_1_still"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_welding_1_still.vfx");
  level._effect["vfx_tun_underwater_welding_1_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_welding_1.vfx");
  level._effect["vfx_tun_underwater_welding_1a_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_welding_1a.vfx");
  level._effect["vfx_tun_underwater_welding_2_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_welding_2.vfx");
  level._effect["vfx_tun_door_off_bubs_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_door_off_bubs_1.vfx");
  level._effect["vfx_tun_detonator_blink_red"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_detonator_blink_red.vfx");
  level._effect["vfx_tun_detonator_blink_red2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_detonator_blink_red2.vfx");
  level._effect["vfx_tun_underwater_bub_area_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_bub_area_1.vfx");
  level._effect["vfx_tun_glass_suction_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_glass_suction_1.vfx");
  level._effect["vfx_tun_underwater_bub_area_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_bub_area_1.vfx");
  level._effect["vfx_tun_underwater_silt_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_silt_sm.vfx");
  level._effect["vfx_tun_underwater_slosh_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_underwater_slosh_sm.vfx");
  level._effect["vfx_tun_env_snow_powder_fall_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_powder_fall_01.vfx");
  level._effect["vfx_tun_env_blowing_snow_amb_med_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blowing_snow_amb_med_1.vfx");
  level._effect["vfx_tun_env_blowing_snow_amb_med_1a"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blowing_snow_amb_med_1a.vfx");
  level._effect["vfx_tun_env_blowing_snow_amb_lrg_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blowing_snow_amb_lrg_1.vfx");
  level._effect["vfx_tun_env_blowing_snow_top_mist_lrg"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_blowing_snow_top_mist_lrg.vfx");
  level._effect["vfx_tun_env_snow_swirl"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_swirl.vfx");
  level._effect["vfx_tun_env_snow_drift_far"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_snow_drift_far.vfx");
  level._effect["vfx_vehicle_impact_sediment"] = loadfx("vfx/jup/level/sp_tundra/vfx_vehicle_impact_sediment.vfx");
  level._effect["vfx_exp_lakefloor_sediment"] = loadfx("vfx/jup/level/sp_tundra/vfx_exp_lakefloor_sediment.vfx");
  level._effect["vfx_headlight_truck_l"] = loadfx("vfx/iw8/level/embassy/vfx_embassy_car_headlight_truck_l.vfx");
  level._effect["vfx_headlight_truck_r"] = loadfx("vfx/iw8/level/embassy/vfx_embassy_car_headlight_truck_r.vfx");
  level._effect["vfx_headlight_daylight"] = loadfx("vfx/_requests/veh/vfx_veh_headlight_daylight.vfx");
  level._effect["vfx_underwater_truck_headlight"] = loadfx("vfx/jup/level/sp_tundra/vfx_jup_underwater_truck_headlight_truck.vfx");
  level._effect["vfx_underwater_truck_headlight_omni"] = loadfx("vfx/jup/level/sp_tundra/vfx_jup_underwater_truck_headlight_truck_omni.vfx");
  level._effect["vfx_underwater_truck_taillight_omni"] = loadfx("vfx/jup/level/sp_tundra/vfx_jup_underwater_truck_taillight_truck_omni.vfx");
  level._effect["mask_off_on"] = loadfx("vfx/jup/level/sp_tundra/vfx_swim_water_screen_.vfx");
  level._effect["vfx_water_diver_bubble_trail_1_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_1_main.vfx");
  level._effect["vfx_water_diver_bubble_trail_1_main_rb"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_1_main_rb.vfx");
  level._effect["vfx_water_diver_bubble_trail_2_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_2_main.vfx");
  level._effect["vfx_water_diver_bubble_trail_3_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_3_main.vfx");
  level._effect["vfx_water_diver_bubble_trail_4_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_4_main.vfx");
  level._effect["vfx_water_diver_bubble_trail_5_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_5_main.vfx");
  level._effect["vfx_water_diver_bubble_trail_5a_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_5a_main.vfx");
  level._effect["vfx_water_diver_bubble_trail_6_main"] = loadfx("vfx/jup/level/sp_tundra/vfx_water_diver_bubble_trail_6_main.vfx");
  level._effect["vfx_tun_env_dripping_water_droplets"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_dripping_water_droplets.vfx");
  level._effect["vfx_tun_env_dripping_water_splash_sm"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_dripping_water_splash_sm.vfx");
  level._effect["vfx_tun_env_ice_surface_mist_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_ice_surface_mist_01.vfx");
  level._effect["cold_breath"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_cold_breath.vfx");
  level._effect["heli_snow_default"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_env_helo_wash_snow_1.vfx");
  level._effect["heli_wash_finale"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_helo_wash_snow_runner.vfx");
  level._effect["heli_wash_finale_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_helo_wash_snow_runner_2.vfx");
  level._effect["heli_finale_lights"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_helo_lights_runner.vfx");
  level._effect["heli_finale_down_wash"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_helo_lights_runner_2.vfx");
  level._effect["heli_finale_surface_wash_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_helo_wash_snow_v_1.vfx");
  level._effect["heli_finale_surface_wash_2"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_helo_wash_snow_v_2.vfx");
  level._effect["heli_finale_surface_wash_3"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_finale_helo_wash_snow_v_3.vfx");
  level._effect["vfx_thermal_beacon_ai"] = loadfx("vfx/iw9/level/gunship/vfx_thermal_beacon_ai.vfx");
  level._effect["vfx_br_smoke_stack"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_smoke_plume_veh_2_md.vfx");
  level._effect["vfx_lumber_veh_tread_kickups"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_lumber_veh_tread_dust_1.vfx");
  level._effect["vfx_lumber_veh_gate_crash"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_lumber_veh_gate_crash.vfx");
  level._effect["vfx_explo_vehicle_large"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_exp_vehicle_main_1.vfx");
  level._effect["vfx_smk_signal_green_1"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_smoke_signal_green_1.vfx");
  level._effect["vfx_exfil_flare"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_smoke_signal_green_1_flare.vfx");
  level._effect["vfx_smk_signal_green_1_wind"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_smoke_signal_green_1_wind.vfx");
  level._effect["vfx_smk_signal_green_1_init"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_smoke_signal_green_1_init.vfx");
  level._effect["vfx_veh_tread_kickups"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_end_veh_tread_dust_1.vfx");
  level._effect["vfx_convoy_veh_death_smoke_01"] = loadfx("vfx/jup/level/sp_tundra/vfx_tun_fire_smoke_plume_runner_1.vfx");
  level._effect["vfx_gib_explode"] = loadfx("vfx/iw8/weap/_explo/gib/vfx_body_explode_gib.vfx");

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {}
}

function init_flags() {
  flag_init("playerMaskOffFlag");
}

function function_8003dec5036a7051() {
  var_e2013fb183920c7a = getEntArray("suv_convoy", "targetname");
  var_3e44517f86f72f55 = level._effect["vfx_tun_underwater_veh_sink_bubbles_1_hero"];
  var_fd6b0eca3ec13099 = level._effect["vfx_tun_underwater_veh_sink_bubbles_2"];
  var_5c38c505c59515b4 = level._effect["vfx_tun_underwater_veh_sink_bubbles_3"];
  var_f41964ceec53c84d = level._effect["vfx_tun_underwater_veh_sink_bubbles_4"];

  if(isDefined(var_e2013fb183920c7a) && var_e2013fb183920c7a.size > 0) {
    i = 0;
    var_31fdd9d22f01a472 = [];

    foreach(suv in var_e2013fb183920c7a) {
      var_31fdd9d22f01a472[i] = suv.origin;
      i += 1;
    }

    i = 0;
    thread ice_explosion();

    foreach(suv in var_e2013fb183920c7a) {
      if(i == 0) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_3e44517f86f72f55);
      } else if(i == 1) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_fd6b0eca3ec13099);
      } else if(i == 2) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_5c38c505c59515b4);
      } else {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_f41964ceec53c84d);
      }

      i += 1;
      wait 1;
    }
  }

  wait 33;
}

function function_560a94ab6cf8eba6() {
  var_e2013fb183920c7a = getEntArray("suv_convoy", "targetname");
  var_3e44517f86f72f55 = level._effect["vfx_tun_underwater_veh_sink_bubbles_1_lights"];
  var_fd6b0eca3ec13099 = level._effect["vfx_tun_underwater_veh_sink_bubbles_2_lights"];
  var_5c38c505c59515b4 = level._effect["vfx_tun_underwater_veh_sink_bubbles_3_lights"];
  var_f41964ceec53c84d = level._effect["vfx_tun_underwater_veh_sink_bubbles_4_lights"];

  if(isDefined(var_e2013fb183920c7a) && var_e2013fb183920c7a.size > 0) {
    i = 0;
    var_31fdd9d22f01a472 = [];

    foreach(suv in var_e2013fb183920c7a) {
      var_31fdd9d22f01a472[i] = suv.origin;
      i += 1;
    }

    i = 0;

    foreach(suv in var_e2013fb183920c7a) {
      if(i == 0) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_3e44517f86f72f55);
      } else if(i == 1) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_fd6b0eca3ec13099);
      } else if(i == 2) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_5c38c505c59515b4);
      } else {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_f41964ceec53c84d);
      }

      i += 1;
      wait 1;
    }
  }

  wait 33;
}

function function_59c82d5a588507fd() {
  kill_exploder("vfx_detonator_charge_initial");
  var_e2013fb183920c7a = getEntArray("suv_convoy", "targetname");
  var_3e44517f86f72f55 = level._effect["vfx_tun_underwater_veh_sink_bubbles_1_loop"];
  var_fd6b0eca3ec13099 = level._effect["vfx_tun_underwater_veh_sink_bubbles_2_loop"];
  var_5c38c505c59515b4 = level._effect["vfx_tun_underwater_veh_sink_bubbles_3_loop"];
  var_f41964ceec53c84d = level._effect["vfx_tun_underwater_veh_sink_bubbles_4_loop"];

  if(isDefined(var_e2013fb183920c7a) && var_e2013fb183920c7a.size > 0) {
    i = 0;
    var_31fdd9d22f01a472 = [];

    foreach(suv in var_e2013fb183920c7a) {
      var_31fdd9d22f01a472[i] = suv.origin;
      i += 1;
    }

    i = 0;

    foreach(suv in var_e2013fb183920c7a) {
      if(i == 0) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_3e44517f86f72f55);
      } else if(i == 1) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_fd6b0eca3ec13099);
      } else if(i == 2) {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_5c38c505c59515b4);
      } else {
        suv thread move_suv(var_31fdd9d22f01a472[i], i, var_f41964ceec53c84d);
      }

      i += 1;
      wait 1;
    }
  }

  wait 33;
}

function move_suv(position, index, var_65377cbed1237d6e) {
  wait 2;
  playFXOnTag(var_65377cbed1237d6e, self, "tag_body");
  wait 23 - index;
  stop_exploder("vfx_detonator_charge_on");
}

function ice_explosion() {
  ice_surface_whole = getEnt("ice_surface_whole", "targetname");
  ice_surface_broken = getEnt("ice_surface_broken", "targetname");
  var_5e40703f589d3ef = level.var_3aedbd4d3f7d8dfe;

  if(isDefined(var_5e40703f589d3ef) && isDefined(ice_surface_whole)) {
    var_5e40703f589d3ef hide();
    ice_surface_broken hide();
    thread function_462cdb154f95593();
    wait 1.3;
    thread function_e55062ac672a1308(ice_surface_whole, ice_surface_broken, var_5e40703f589d3ef);
    thread function_c4bef03af43b70ff();
    thread function_9fb92e71b7280b9();
  }

  level thread floating_ice_mayhem();
}

function floating_ice_mayhem() {
  waitframe();
  var_3cc31d298723534f = "ice_wave_mayhem";
  var_b81826470f96a66a = getEntArray("floating_ice_mayhem", "targetname");
  spawnmayhem(var_3cc31d298723534f, "jup_tundra_floating_ice", var_b81826470f96a66a[0].origin, var_b81826470f96a66a[0].angles);
  level thread function_90212472991134fe(var_3cc31d298723534f);
}

function function_90212472991134fe(var_3cc31d298723534f) {
  level.player waittill("death");
  killmayhem(var_3cc31d298723534f);
}

function function_462cdb154f95593() {
  exploder("vfx_detonator_charge_on");
  wait 1.3;
  kill_exploder("vfx_detonator_charge_initial");
  var_fc60b65586ce400 = getEnt("water_explosion_center", "targetname");
  playFX(level._effect["vfx_water_explosion"], var_fc60b65586ce400.origin + (0, 0, 150));
  exploder("vfx_debris_field");
  exploder("vfx_debris_silt");
  exploder("vfx_debris_silt_main");
  exploder("vfx_player_screen_bubbles");
  wait 0.1;
  thread function_7d9b815585592db4();
  thread function_36228ff8b8d1413b();
  wait 0.15;
  kill_exploder("vfx_vehicle_drive_shadows");
}

function function_7d9b815585592db4() {
  if(istrue(level.no_slowmo)) {
    return;
  }

  setslowmotion(1, 0.15, 0);
  wait 0.3;
  setslowmotion(0.15, 1, 0.25);
}

function function_36228ff8b8d1413b() {
  wait 0.45;
  earthquake(0.45, 1.5, level.player.origin, 1000);
}

function function_d1a6fec38d0ba01a() {
  wait 1;

  if(isDefined(level.var_a60c69901584d22c)) {
    level.var_a60c69901584d22c playanim("branch_algae_idle_anim");
    level.var_43742b9405683845 playanim("foliage_algae_idle_anim");
    level.var_43742894056831ac playanim("foliage_algae_idle_anim");
    level.var_43742994056833df playanim("foliage_algae_idle_anim");
    level.var_4374269405682d46 playanim("foliage_algae_idle_anim");
    level.var_4374279405682f79 playanim("foliage_algae_idle_anim");
    level.var_43742494056828e0 playanim("foliage_algae_idle_anim");
    level.var_4374259405682b13 playanim("foliage_algae_idle_anim");
  }
}

function function_c4bef03af43b70ff() {
  wait 0.65;
  level.var_a60c69901584d22c playanim("branch_algae_shock_anim");
  level.var_43742b9405683845 playanim("foliage_algae_shock_anim");
  level.var_43742894056831ac playanim("foliage_algae_shock_anim");
  level.var_43742994056833df playanim("foliage_algae_shock_anim");
  level.var_4374269405682d46 playanim("foliage_algae_shock_anim");
  level.var_4374279405682f79 playanim("foliage_algae_shock_anim");
  level.var_43742494056828e0 playanim("foliage_algae_shock_anim");
  level.var_4374259405682b13 playanim("foliage_algae_shock_anim");
  wait 9.9;
  function_d1a6fec38d0ba01a();
}

function function_9fb92e71b7280b9() {
  level.var_df55da12be36b094 hide();
}

function function_e55062ac672a1308(ice_surface_whole, ice_surface_broken, var_7d4c79080da48fbd) {
  wait 0.2;
  ice_surface_broken show();
  ice_surface_whole hide();
  var_16df5606de9733a7 = var_7d4c79080da48fbd.origin;
  var_47b0d14b7fa5b994 = (var_16df5606de9733a7[0], var_16df5606de9733a7[1] + 276, var_16df5606de9733a7[2]);
  var_7d4c79080da48fbd moveTo(var_47b0d14b7fa5b994, 0.02);
}

function function_60589ef1f96ad009() {
  wait 9;
  self hide();
}

function function_ff2f0667ab497704(var_7d4c79080da48fbd) {
  printtoscreen2d(10, 20, "<dev string:x1c>", (1, 1, 1), 1, 3);

  wait 0.2;
  var_7d4c79080da48fbd show();
  var_7d4c79080da48fbd playanim("flying_ice_sim");
}

function floating_ice_sim(var_7d4c79080da48fbd) {
  printtoscreen2d(10, 20, "<dev string:x37>", (1, 1, 1), 1, 3);

  wait 1;
  var_7d4c79080da48fbd show();
  var_7d4c79080da48fbd anim_loop_with_props(var_7d4c79080da48fbd, "floating_ice_sim");
}

function function_1d4f626cce0229e8() {
  waitframe();
  level.player waittill("player_mask_off");
  function_5339ea38eb8f9fb3();
}

function function_5339ea38eb8f9fb3() {
  thread function_8fcf5c935fabd79a();
}

function function_8fcf5c935fabd79a() {
  level.player setblurforplayer(2, 10);
  wait 0.05;
  playFXOnTag(level._effect["vfx_tun_underwater_mask_off"], level.player_rig, "tag_camera");
  wait 0.1;
  visionsetnaked("sp_jup_tundra_mask_off", 0.01);
  level.player waittill("player_mask_on");
  wait 2;
  playFXOnTag(level._effect["vfx_tun_underwater_mask_on"], level.player_rig, "tag_camera");
  playFXOnTag(level._effect["vfx_player_mask_condensation_1"], level.player_rig, "tag_camera");
  wait 0.5;
  visionsetnaked("", 0.25);
  level.player setblurforplayer(0, 0.5);
  wait 1;
  flag_wait("mask_sequence_done");
}

function function_266f0187f23b7269() {
  mask = getEnt("player_mask", "targetname");
  animnode = getStruct("scene_maskOff_trigger_test", "targetname");
  animnode scene::function_bc521bee52fde214(0.2);
  animnode thread scene::play();
  mask linktoplayerview(level.player, "tag_origin", (0.5, 0, 3.5), (-90, 90, 0));
  wait 15;
  flag_set("mask_sequence_done");
  mask unlinkfromplayerview(level.player);
}

#using_animtree("script_model");

function function_b029452f88f894b4() {
  waitframe();
  level.var_3aedbd4d3f7d8dfe = getEnt("jup_ice_explosion_sim", "targetname");

  if(isDefined(level.var_3aedbd4d3f7d8dfe)) {
    level.var_3aedbd4d3f7d8dfe hide();
    animnames = [];
    animnames[0] = "ice_explosion_sim";
    animnames[1] = "ice_explosion_sim_firstframe";
    animnames[2] = "ice_explosion_sim_lastframe";
    animnames[3] = "ice_explosion_sim_idle";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_ice_explosion_sim_anim;
    var_fef45820209549f2[1] = % jup_ice_explosion_sim_firstframe_anim;
    var_fef45820209549f2[2] = % jup_ice_explosion_sim_lastframe_anim;
    var_fef45820209549f2[3] = [%jup_ice_explosion_sim_idle_anim];
    level.var_3aedbd4d3f7d8dfe function_10259c9f60f0f8d9("ice_explosion_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_9fdbe4311269b53d = getEnt("flying_ice_sim", "targetname");

  if(isDefined(level.var_9fdbe4311269b53d)) {
    level.var_9fdbe4311269b53d hide();
    animnames = [];
    animnames[0] = "flying_ice_sim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_tundra_flying_ice_sim;
    level.var_9fdbe4311269b53d function_10259c9f60f0f8d9("flying_ice_sim_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_d2f8f0336a183d46 = getEnt("floating_ice_sim", "targetname");

  if(isDefined(level.var_d2f8f0336a183d46)) {
    level.var_d2f8f0336a183d46 hide();
    animnames = [];
    animnames[0] = "floating_ice_sim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = [%jup_ice_floating_pieces_sim];
    level.var_d2f8f0336a183d46 function_10259c9f60f0f8d9("floating_ice_sim_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_df55da12be36b094 = getEnt("ice_single_large_piece_01", "targetname");

  if(isDefined(level.var_df55da12be36b094)) {
    level.var_df55da12be36b094 hide();
    animnames = [];
    animnames[0] = "ice_explosion_single_larget_01";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_ice_explosion_single_large_piece_01_anim;
    level.var_df55da12be36b094 function_10259c9f60f0f8d9("ice_single_large_piece_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_a60c69901584d22c = getEnt("branch_algae_01", "targetname");

  if(isDefined(level.var_a60c69901584d22c)) {
    animnames = [];
    animnames[0] = "branch_algae_shock_anim";
    animnames[1] = "branch_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_branch_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_branch_algae_idle;
    level.var_a60c69901584d22c function_10259c9f60f0f8d9("branch_algae_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_43742b9405683845 = getEnt("foliage_single_algae_01", "targetname");

  if(isDefined(level.var_43742b9405683845)) {
    animnames = [];
    animnames[0] = "foliage_algae_shock_anim";
    animnames[1] = "foliage_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_algae_idle;
    level.var_43742b9405683845 function_10259c9f60f0f8d9("foliage_algae01_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_43742894056831ac = getEnt("foliage_single_algae_02", "targetname");

  if(isDefined(level.var_43742894056831ac)) {
    animnames = [];
    animnames[0] = "foliage_algae_shock_anim";
    animnames[1] = "foliage_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_algae_idle;
    level.var_43742894056831ac function_10259c9f60f0f8d9("foliage_algae02_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_43742994056833df = getEnt("foliage_single_algae_03", "targetname");

  if(isDefined(level.var_43742994056833df)) {
    animnames = [];
    animnames[0] = "foliage_algae_shock_anim";
    animnames[1] = "foliage_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_algae_idle;
    level.var_43742994056833df function_10259c9f60f0f8d9("foliage_algae03_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_4374269405682d46 = getEnt("foliage_single_algae_04", "targetname");

  if(isDefined(level.var_4374269405682d46)) {
    animnames = [];
    animnames[0] = "foliage_algae_shock_anim";
    animnames[1] = "foliage_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_algae_idle;
    level.var_4374269405682d46 function_10259c9f60f0f8d9("foliage_algae04_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_4374279405682f79 = getEnt("foliage_single_algae_05", "targetname");

  if(isDefined(level.var_4374279405682f79)) {
    animnames = [];
    animnames[0] = "foliage_algae_shock_anim";
    animnames[1] = "foliage_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_algae_idle;
    level.var_4374279405682f79 function_10259c9f60f0f8d9("foliage_algae05_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_43742494056828e0 = getEnt("foliage_single_algae_06", "targetname");

  if(isDefined(level.var_43742494056828e0)) {
    animnames = [];
    animnames[0] = "foliage_algae_shock_anim";
    animnames[1] = "foliage_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_algae_idle;
    level.var_43742494056828e0 function_10259c9f60f0f8d9("foliage_algae06_anim_tree", animnames, var_fef45820209549f2);
  }

  level.var_4374259405682b13 = getEnt("foliage_single_algae_07", "targetname");

  if(isDefined(level.var_4374259405682b13)) {
    animnames = [];
    animnames[0] = "foliage_algae_shock_anim";
    animnames[1] = "foliage_algae_idle_anim";
    var_fef45820209549f2 = [];
    var_fef45820209549f2[0] = % jup_foliage_algae_shock;
    var_fef45820209549f2[1] = % jup_foliage_algae_idle;
    level.var_4374259405682b13 function_10259c9f60f0f8d9("foliage_algae07_anim_tree", animnames, var_fef45820209549f2);
  }

  getEnt("veh1_window_00", "targetname") hide();
  getEnt("veh1_window_01", "targetname") hide();
  getEnt("veh1_window_02", "targetname") hide();
  getEnt("veh1_window_03", "targetname") hide();
}

function function_10259c9f60f0f8d9(var_5e1ec848a050b4f7, var_5409266f06c66752, var_448718ba9265b51a) {
  assert(isDefined(self));

  if(!isDefined(self.animname)) {
    self.animname = var_5e1ec848a050b4f7;
    level.scr_animtree[var_5e1ec848a050b4f7] = #animtree;
    level.scr_model[var_5e1ec848a050b4f7] = self.model;

    for(i = 0; i < var_5409266f06c66752.size; i++) {
      level.scr_anim[var_5e1ec848a050b4f7][var_5409266f06c66752[i]] = var_448718ba9265b51a[i];
    }

    assign_animtree();
  }
}

function private playanim(var_f85b3f1763235d15) {
  thread anim_single_solo(self, var_f85b3f1763235d15);
}

function private function_8624f23784a1e784(var_f85b3f1763235d15) {
  thread anim_single_solo_run(self, var_f85b3f1763235d15);
}

function private function_4af06fad6c09a1b1(var_f85b3f1763235d15) {
  thread anim_first_frame_solo(self, var_f85b3f1763235d15);
}

function function_b6e2f5f1a276d090() {
  if(isDefined(level.var_3aedbd4d3f7d8dfe)) {
    level.var_3aedbd4d3f7d8dfe delete();
    level.var_3aedbd4d3f7d8dfe = undefined;
  }

  if(isDefined(level.var_9fdbe4311269b53d)) {
    level.var_9fdbe4311269b53d delete();
    level.var_9fdbe4311269b53d = undefined;
  }

  if(isDefined(level.var_d2f8f0336a183d46)) {
    level.var_d2f8f0336a183d46 delete();
    level.var_d2f8f0336a183d46 = undefined;
  }

  if(isDefined(level.var_df55da12be36b094)) {
    level.var_df55da12be36b094 delete();
    level.var_df55da12be36b094 = undefined;
  }

  if(isDefined(level.var_a60c69901584d22c)) {
    level.var_a60c69901584d22c delete();
    level.var_a60c69901584d22c = undefined;
  }

  if(isDefined(level.var_43742b9405683845)) {
    level.var_43742b9405683845 delete();
    level.var_43742b9405683845 = undefined;
  }

  if(isDefined(level.var_43742894056831ac)) {
    level.var_43742894056831ac delete();
    level.var_43742894056831ac = undefined;
  }

  if(isDefined(level.var_43742994056833df)) {
    level.var_43742994056833df delete();
    level.var_43742994056833df = undefined;
  }

  if(isDefined(level.var_4374269405682d46)) {
    level.var_4374269405682d46 delete();
    level.var_4374269405682d46 = undefined;
  }

  if(isDefined(level.var_4374279405682f79)) {
    level.var_4374279405682f79 delete();
    level.var_4374279405682f79 = undefined;
  }

  if(isDefined(level.var_43742494056828e0)) {
    level.var_43742494056828e0 delete();
    level.var_43742494056828e0 = undefined;
  }

  if(isDefined(level.var_4374259405682b13)) {
    level.var_4374259405682b13 delete();
    level.var_4374259405682b13 = undefined;
  }
}