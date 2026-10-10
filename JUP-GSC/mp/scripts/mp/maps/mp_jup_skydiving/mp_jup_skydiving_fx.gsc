/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_fx.gsc
***********************************************************************/

#namespace mp_jup_skydiving_fx;

function main() {
  level._effect["blima_flares"] = loadfx("vfx/iw9/core/flare/vfx_blima_angel_flares.vfx");
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level._effect["vfx_tracer_lmg_wheelson_w"] = loadfx("vfx/iw8/weap/_tracer/vfx_tracer_lmg_wheelson_w.vfx");
  level._effect["vfx_nightwar_amb_aafire_01"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_launchfacility_nightwar_amb_aafire_01.vfx");
  level._effect["explode_zone1"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_launchfacility_derail_veh_talfa_explosion_rnr.vfx");
  level._effect["lab_explosion"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_device_exp.vfx");
  level._effect["zombie_appear"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_container_open_smk.vfx");
  level._effect["vfx_dmz_bio_lab_heli_spotlight"] = loadfx("vfx/iw9/level/mp_dmz_bio_lab/vfx_dmz_heli_spotlight_01.vfx");
  level._effect["vfx_dmz_bio_lab_heli_exfil_gas"] = loadfx("vfx/iw9/level/mp_dmz_bio_lab/vfx_dmz_gas_smk_evacuate.vfx");
  level._effect["lab_gas_leak"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_range_gas_fog.vfx");
  level._effect["lab_gas_leak_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_range_gas_fog_p.vfx");
  level._effect["lab_gas_leak_wall"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_steam_Infect_down_wall.vfx");
  level._effect["lab_gas_leak_wall_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_steam_Infect_down_wall_p.vfx");
  level._effect["lab_gas_leak_ceiling"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_steam_Infect_down_ceiling.vfx");
  level._effect["lab_gas_leak_ceiling_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_steam_Infect_down_ceiling_p.vfx");
  level._effect["lab_gas_lobby_fog"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_range_gas_bbox.vfx");
  level._effect["lab_gas_lobby_fog_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_range_gas_bbox_p.vfx");
  level._effect["lab_gas_center_fog"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_range_gas_bbox_1.vfx");
  level._effect["lab_gas_center_fog_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_range_gas_bbox_p_1.vfx");
  level._effect["lab_gas_final"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_building_exp_gas.vfx");
  level._effect["lab_gas_final_p"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_building_exp_gas_p.vfx");
  level._effect["lab_explosion_final"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_building_exp.vfx");
  level._effect["lab_explosion_final_p"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_building_exp_p.vfx");
  level._effect["vista_gas_leak_1"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_range_lrg.vfx");
  level._effect["vista_gas_leak_1_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_range_lrg_p.vfx");
  level._effect["vista_gas_leak_2"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_range_sml.vfx");
  level._effect["vista_gas_leak_2_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_range_sml_p.vfx");
  level._effect["vista_gas_leak_3"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_range_med.vfx");
  level._effect["vista_gas_leak_3_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_range_med_p.vfx");
  level._effect["vista_gas_leak_building_bottom"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_building_bottom.vfx");
  level._effect["vista_gas_leak_building_bottom_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_gas_building_bottom_p.vfx");
  level._effect["vista_gas_surrounding_still"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_gas_circle_smk.vfx");
  level._effect["vista_gas_surrounding_still_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_gas_circle_smk_p.vfx");
  level._effect["vista_gas_surrounding_shrink"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_gas_circle_smk_scale.vfx");
  level._effect["vista_gas_surrounding_shrink_zm"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_gas_circle_smk_scale_p.vfx");
  level._effect["wheelson_forward_light"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_wheelson_light_g.vfx");
  level._effect["wheelson_reverse_light"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_wheelson_flash_y.vfx");
  level._effect["wheelson_hacking_light"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_wheelson_flash_g.vfx");
  level._effect["wheelson_stop_light"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_wheelson_light_r.vfx");
  level._effect["wheelson_sweep_screen_on"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_wheelson_sweep_screen.vfx");
  level._effect["wheelson_sweep_screen_off"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_wheelson_sweep_screen_close.vfx");
  level._effect["vfx_radiation_circle"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_skydiving_radiation_circle.vfx");
  level._effect["exploder_full_smoke"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_lab_roof_down_smk.vfx");
  level._effect["PDSF_field_spreading"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_aura_clean.vfx");
  level._effect["pds_elec_1"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_pds_ground_elec_01.vfx");
  level._effect["pds_elec_2"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_pds_ground_elec_02.vfx");
  level._effect["pds_elec_3"] = loadfx("vfx/jup/level/mp_jup_skydiving/vfx_jup_sd_pds_ground_elec_03.vfx");
  level._effect["wall_explode"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_buildwall_exp.vfx");
  level._effect["vision_in_gas_zm"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_phase_crystal_screen.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}