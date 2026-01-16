/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\so_rts_mp_drone_fx.gsc
***************************************/

#include maps\_utility;
#include maps\createfx\so_rts_mp_drone_fx;

main() {
  precache_scripted_fx();
  precache_fxanim_props();
  precache_createfx_fx();
  maps\createfx\so_rts_mp_drone_fx::main();
}

precache_scripted_fx() {
  level._effect["rts_poi_dish_dmg"] = loadfx("electrical/fx_rts_elec_spark_burst_satdish_run");
  level._effect["rts_poi_dish_smk_dmg"] = loadfx("electrical/fx_rts_elec_spark_smk_satdish_run");
}

precache_createfx_fx() {
  level._effect["fx_dest_computer_terminal"] = loadfx("electrical/fx_rts_elec_spark_burst_satdish_run");
  level._effect["fx_dest_elec_transformer01_smk"] = loadfx("destructibles/fx_dest_elec_transformer01_smk");
  level._effect["fx_dest_elec_transformer01_base"] = loadfx("destructibles/fx_dest_elec_transformer01_base");
  level._effect["fx_elec_rts_transformer_single"] = loadfx("electrical/fx_elec_rts_transformer_single");
  level._effect["fx_dest_drone_gas_silo"] = loadfx("destructibles/fx_dest_drone_gas_silo");
  level._effect["fx_dest_drone_gas_silo_dmg1"] = loadfx("destructibles/fx_dest_drone_gas_silo_dmg1");
  level._effect["fx_dest_drone_gas_silo_dmg2"] = loadfx("destructibles/fx_dest_drone_gas_silo_dmg2");
  level._effect["fx_dest_computer_terminal"] = loadfx("electrical/fx_rts_elec_spark_burst_satdish_run");
  level._effect["fx_war_heli_dust_concrete"] = loadfx("vehicle/treadfx/fx_war_heli_dust_concrete");
  level._effect["fx_rts_dust_jump_land"] = loadfx("dirt/fx_rts_dust_jump_land");
  level._effect["fx_delete_emp"] = loadfx("weapon/emp/fx_emp_rts_grenade_exp");
  level._effect["fx_emp_elec_lg"] = loadfx("electrical/fx_rts_elec_emp_fill_lg");
  level._effect["fx_rts_elec_emp_room_sparks"] = loadfx("electrical/fx_rts_elec_emp_room_sparks");
  level._effect["fx_leaves_falling_mangrove_lg_dark"] = loadfx("env/foliage/fx_leaves_falling_mangrove_lg_dark");
  level._effect["fx_leaves_falling_lite"] = loadfx("env/foliage/fx_leaves_falling_lite");
  level._effect["fx_mp_vent_steam"] = loadfx("maps/mp_maps/fx_mp_vent_steam");
  level._effect["fx_hvac_steam_md"] = loadfx("smoke/fx_hvac_steam_md");
  level._effect["fx_mp_water_drip_light_shrt"] = loadfx("maps/mp_maps/fx_mp_water_drip_light_shrt");
  level._effect["fx_mp_elec_spark_burst_xsm_thin_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_xsm_thin_runner");
  level._effect["fx_fog_street_cool_slw_md"] = loadfx("fog/fx_fog_street_cool_slw_md");
  level._effect["fx_light_emrgncy_floodlight"] = loadfx("light/fx_light_emrgncy_floodlight");
  level._effect["fx_insects_swarm_dark_lg"] = loadfx("bio/insects/fx_insects_swarm_dark_lg");
  level._effect["fx_mp_fog_low"] = loadfx("maps/mp_maps/fx_mp_fog_low");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_lf_dockside_sun1"] = loadfx("lens_flares/fx_lf_dockside_sun1");
  level._effect["fx_light_floodlight_rnd_cool_glw_dim"] = loadfx("light/fx_light_floodlight_rnd_cool_glw_dim");
  level._effect["fx_mp_steam_pipe_md"] = loadfx("maps/mp_maps/fx_mp_steam_pipe_md");
  level._effect["fx_mp_light_dust_motes_md"] = loadfx("maps/mp_maps/fx_mp_light_dust_motes_md");
  level._effect["fx_mp_light_dust_motes_sm"] = loadfx("maps/mp_maps/fx_mp_light_dust_motes_sm");
  level._effect["fx_mp_fog_cool_ground"] = loadfx("maps/mp_maps/fx_mp_fog_cool_ground");
  level._effect["fx_water_splash_detail"] = loadfx("water/fx_water_splash_detail");
  level._effect["fx_red_button_flash"] = loadfx("light/fx_red_button_flash");
  level._effect["fx_wall_water_bottom"] = loadfx("water/fx_wall_water_bottom");
  level._effect["fx_mp_distant_cloud"] = loadfx("maps/mp_maps/fx_mp_distant_cloud");
  level._effect["fx_light_god_ray_mp_drone"] = loadfx("env/light/fx_light_god_ray_mp_drone");
  level._effect["fx_mp_fumes_vent_xsm_int"] = loadfx("maps/mp_maps/fx_mp_fumes_vent_xsm_int");
  level._effect["fx_mp_vent_steam_dark"] = loadfx("maps/mp_maps/fx_mp_vent_steam_dark");
  level._effect["fx_ceiling_circle_light_glare"] = loadfx("light/fx_ceiling_circle_light_glare");
  level._effect["fx_drone_rectangle_light"] = loadfx("light/fx_drone_rectangle_light");
  level._effect["fx_drone_rectangle_light_02"] = loadfx("light/fx_drone_rectangle_light_02");
  level._effect["fx_mp_water_drip_light_long"] = loadfx("maps/mp_maps/fx_mp_water_drip_light_long");
  level._effect["fx_pc_panel_lights_runner"] = loadfx("props/fx_pc_panel_lights_runner");
  level._effect["fx_drone_red_ring_console"] = loadfx("light/fx_drone_red_ring_console");
  level._effect["fx_blue_light_flash"] = loadfx("light/fx_blue_light_flash");
  level._effect["fx_window_god_ray"] = loadfx("light/fx_window_god_ray");
  level._effect["fx_mp_drone_interior_steam"] = loadfx("maps/mp_maps/fx_mp_drone_interior_steam");
  level._effect["fx_drone_pipe_water"] = loadfx("water/fx_drone_pipe_water");
  level._effect["fx_pc_panel_heli"] = loadfx("props/fx_pc_panel_heli");
  level._effect["fx_red_light_flash"] = loadfx("light/fx_red_light_flash");
  level._effect["fx_drone_rectangle_light_blue"] = loadfx("light/fx_drone_rectangle_light_blue");
  level._effect["fx_mp_distant_cloud_vista"] = loadfx("maps/mp_maps/fx_mp_distant_cloud_vista");
  level._effect["fx_drone_rectangle_light_blue_4"] = loadfx("light/fx_drone_rectangle_light_blue_4");
  level._effect["fx_drone_rectangle_light_yellow"] = loadfx("light/fx_drone_rectangle_light_yellow");
  level._effect["fx_ceiling_circle_light_led"] = loadfx("light/fx_ceiling_circle_light_led");
  level._effect["fx_drone_red_ring_console_runner"] = loadfx("light/fx_drone_red_ring_console_runner");
  level._effect["fx_light_beacon_red_blink_fst"] = loadfx("light/fx_light_beacon_red_blink_fst");
  level._effect["fx_wall_water_ground"] = loadfx("water/fx_wall_water_ground");
  level._effect["fx_drone_rectangle_light_03"] = loadfx("light/fx_drone_rectangle_light_03");
  level._effect["fx_drone_red_blink"] = loadfx("light/fx_drone_red_blink");
  level._effect["fx_mp_debris_papers"] = loadfx("maps/mp_maps/fx_mp_debris_papers");
  level._effect["fx_light_god_ray_mp_drone2"] = loadfx("env/light/fx_light_god_ray_mp_drone2");
  level._effect["fx_embers_falling_sm"] = loadfx("env/fire/fx_embers_falling_sm");
  level._effect["fx_embers_falling_md"] = loadfx("env/fire/fx_embers_falling_md");
  level._effect["fx_fire_fuel_xsm"] = loadfx("fire/fx_fire_fuel_xsm");
  level._effect["fx_fire_fuel_sm"] = loadfx("fire/fx_fire_fuel_sm");
  level._effect["fx_fire_fuel_sm_smolder"] = loadfx("fire/fx_fire_fuel_sm_smolder");
  level._effect["fx_fire_fuel_sm_smoke"] = loadfx("fire/fx_fire_fuel_sm_smoke");
  level._effect["fx_fire_fuel_sm_line"] = loadfx("fire/fx_fire_fuel_sm_line");
  level._effect["fx_fire_fuel_sm_ground"] = loadfx("fire/fx_fire_fuel_sm_ground");
  level._effect["fx_fire_line_md"] = loadfx("env/fire/fx_fire_line_md");
  level._effect["fx_fire_sm_smolder"] = loadfx("env/fire/fx_fire_sm_smolder");
  level._effect["fx_smk_fire_xlg_black_dist"] = loadfx("smoke/fx_smk_fire_xlg_black_dist");
  level._effect["fx_smk_fire_md_black"] = loadfx("smoke/fx_smk_fire_md_black");
  level._effect["fx_smk_fire_lg_black"] = loadfx("smoke/fx_smk_fire_lg_black");
  level._effect["fx_smk_fire_lg_white"] = loadfx("smoke/fx_smk_fire_lg_white");
  level._effect["fx_mp_smk_plume_lg_blk_distant"] = loadfx("maps/mp_maps/fx_mp_smk_plume_md_blk_distant_wispy");
  level._effect["fx_mp_smk_plume_md_blk_distant"] = loadfx("maps/mp_maps/fx_mp_smk_plume_sm_blk_distant_wispy");
  level._effect["fx_smk_wood_wispy_lg_dark_dist"] = loadfx("smoke/fx_smk_wood_wispy_lg_dark_dist");
  level._effect["fx_nic_smk_plume_lg_gray_dark"] = loadfx("smoke/fx_nic_smk_plume_lg_gray_dark");
  level._effect["fx_fire_ceiling_rafter_lg"] = loadfx("fire/fx_nic_fire_ceiling_rafter_lg");
  level._effect["fx_fire_ceiling_rafter_md"] = loadfx("fire/fx_nic_fire_ceiling_rafter_md");
  level._effect["fx_fire_ceiling_rafter_md_long"] = loadfx("fire/fx_nic_fire_ceiling_rafter_md_long");
  level._effect["fx_fire_eaves_md"] = loadfx("fire/fx_nic_fire_eaves_md");
  level._effect["fx_fire_eaves_md_left"] = loadfx("fire/fx_nic_fire_eaves_md_left");
  level._effect["fx_fire_eaves_md_right"] = loadfx("fire/fx_nic_fire_eaves_md_right");
  level._effect["fx_fire_eaves_lg_left"] = loadfx("fire/fx_nic_fire_eaves_lg_left");
  level._effect["fx_fire_eaves_lg_right"] = loadfx("fire/fx_nic_fire_eaves_lg_right");
  level._effect["fx_fire_pole_md_long"] = loadfx("fire/fx_nic_fire_pole_md_long");
  level._effect["fx_fire_smolder_area_sm"] = loadfx("fire/fx_fire_smolder_area_sm");
  level._effect["fx_mp_elec_spark_burst_sm"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_sm");
  level._effect["fx_mp_elec_spark_burst_sm_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_sm_runner");
  level._effect["fx_mp_elec_spark_burst_xsm_thin"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_xsm_thin");
  level._effect["fx_mp_elec_spark_burst_xsm_thin_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_xsm_thin_runner");
  level._effect["fx_mp_elec_spark_burst_md"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_md");
  level._effect["fx_mp_elec_spark_burst_md_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_md_runner");
  level._effect["fx_mp_elec_spark_burst_lg"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_lg");
  level._effect["fx_mp_elec_spark_burst_lg_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_lg_runner");
  level._effect["fx_mp_elec_spark_pop_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_pop_runner");
}

precache_fxanim_props() {
}