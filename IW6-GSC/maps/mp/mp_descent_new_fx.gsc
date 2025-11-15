/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_descent_new_fx.gsc
*****************************************/

main() {
  level._effect["vfx_floor_collapse_drip"] = loadfx("vfx/moments/mp_descent/vfx_floor_collapse_drip");
  level._effect["vfx_pipe_pour_wtr_dec"] = loadfx("vfx/moments/mp_descent/vfx_pipe_pour_wtr_dec");
  level._effect["vfx_quake_debris"] = loadfx("vfx/moments/mp_descent/vfx_quake_debris");
  level._effect["vfx_dirt_kickup"] = loadfx("vfx/moments/mp_descent/vfx_dirt_kickup");
  level._effect["vfx_small_area_dust_hang"] = loadfx("vfx/moments/mp_descent/vfx_small_area_dust_hang");
  level._effect["vfx_dust_mp_dec_bright"] = loadfx("vfx/moments/mp_descent/vfx_dust_mp_dec_bright");
  level._effect["vfx_embers_tails"] = loadfx("vfx/moments/mp_descent/vfx_embers_tails");
  level._effect["vfx_room_collapse_dust"] = loadfx("vfx/moments/mp_descent/vfx_room_collapse_dust");
  level._effect["vfx_glass_floor_smash"] = loadfx("vfx/moments/mp_descent/vfx_glass_floor_smash");
  level._effect["vfx_spark_lights_dec_runner"] = loadfx("vfx/moments/mp_descent/vfx_spark_lights_dec_runner");
  level._effect["vfx_debris_dust_large"] = loadfx("vfx/moments/mp_descent/vfx_debris_dust_large");
  level._effect["vfx_building_debris_b_runner"] = loadfx("vfx/moments/mp_descent/vfx_building_debris_b_runner");
  level._effect["vfx_building_fire_dec_sm"] = loadfx("vfx/moments/mp_descent/vfx_building_fire_dec_sm");
  level._effect["vfx_glass_shard_fall"] = loadfx("vfx/moments/mp_descent/vfx_glass_shard_fall");
  level._effect["vfx_level_shake_dust_dec"] = loadfx("vfx/moments/mp_descent/vfx_level_shake_dust_dec");
  level._effect["vfx_pipe_pour_dec"] = loadfx("vfx/moments/mp_descent/vfx_pipe_pour_dec");
  level._effect["vfx_water_trash_collect"] = loadfx("vfx/moments/mp_descent/vfx_water_trash_collect");
  level._effect["vfx_pipe_pour_splash_dec"] = loadfx("vfx/moments/mp_descent/vfx_pipe_pour_splash_dec");
  level._effect["vfx_building_fire_dec"] = loadfx("vfx/moments/mp_descent/vfx_building_fire_dec");
  level._effect["vfx_dust_vortex_runner"] = loadfx("vfx/moments/mp_descent/vfx_dust_vortex_runner");
  level._effect["vfx_paper_blow_runner"] = loadfx("vfx/moments/mp_descent/vfx_paper_blow_runner");
  level._effect["vfx_building_debris_runner"] = loadfx("vfx/moments/mp_descent/vfx_building_debris_runner");
  level._effect["vfx_building_hole_elec_short_runner"] = loadfx("vfx/moments/mp_descent/vfx_building_hole_elec_short_runner");
  level._effect["vfx_building_debris_childa"] = loadfx("vfx/moments/mp_descent/vfx_building_debris_childa");
  level._effect["vfx_debris_impact"] = loadfx("vfx/moments/mp_descent/vfx_debris_impact");
  level._effect["vfx_dirt_dec"] = loadfx("vfx/moments/mp_descent/vfx_dirt_dec");
  level._effect["vfx_water_swirl_dec"] = loadfx("vfx/moments/mp_descent/vfx_water_swirl_dec");
  level._effect["vfx_floating_debris_dec"] = loadfx("vfx/moments/mp_descent/vfx_floating_debris_dec");
  level._effect["vfx_ash_dec"] = loadfx("vfx/moments/mp_descent/vfx_ash_dec");
  level._effect["vfx_heat_haze_dec"] = loadfx("vfx/moments/mp_descent/vfx_heat_haze_dec");
  level._effect["vfx_single_drip_dec_runner"] = loadfx("vfx/moments/mp_descent/vfx_single_drip_dec_runner");
  level._effect["vfx_broken_water_pipe_dec"] = loadfx("vfx/moments/mp_descent/vfx_broken_water_pipe_dec");
  level._effect["vfx_crowd_standing_dec"] = loadfx("vfx/moments/mp_descent/vfx_crowd_standing_dec");
  level._effect["vfx_dust_hang_mp_dec"] = loadfx("vfx/moments/mp_descent/vfx_dust_hang_mp_dec");
  level._effect["vfx_embers_ash_dec"] = loadfx("vfx/moments/mp_descent/vfx_embers_ash_dec");
  level._effect["vfx_fire_wall_dec"] = loadfx("vfx/moments/mp_descent/vfx_fire_wall_dec");
  level._effect["vfx_ground_fire_dec"] = loadfx("vfx/moments/mp_descent/vfx_ground_fire_dec");
  level._effect["vfx_ground_fire_sm_dec"] = loadfx("vfx/moments/mp_descent/vfx_ground_fire_sm_dec");
  level._effect["vfx_ground_fire_tiny"] = loadfx("vfx/moments/mp_descent/vfx_ground_fire_tiny");
  level._effect["vfx_insects_dec"] = loadfx("vfx/moments/mp_descent/vfx_insects_dec");
  level._effect["vfx_paper_blowing_trash"] = loadfx("vfx/moments/mp_descent/vfx_paper_blowing_trash");
  level._effect["vfx_pipe_drip_dec"] = loadfx("vfx/moments/mp_descent/vfx_pipe_drip_dec");
  level._effect["vfx_rog_impact_smoke"] = loadfx("vfx/moments/mp_descent/vfx_rog_impact_smoke");
  level._effect["vfx_spark_drip_dec_runner"] = loadfx("vfx/moments/mp_descent/vfx_spark_drip_dec_runner");
  level._effect["vfx_sprinkler_imp_dec"] = loadfx("vfx/moments/mp_descent/vfx_sprinkler_imp_dec");
  level._effect["vfx_thin_dust_drip_dec"] = loadfx("vfx/moments/mp_descent/vfx_thin_dust_drip_dec");
  level._effect["vfx_thn_dst_dec_runner"] = loadfx("vfx/moments/mp_descent/vfx_thn_dst_dec_runner");
  level._effect["vfx_collumn_collapse"] = loadfx("vfx/moments/mp_descent/vfx_collumn_collapse");
  level._effect["mp_descent_debris"] = loadfx("vfx/moments/mp_descent/vfx_quake_debris");
  level._effect["mp_descent_debris_lrg"] = loadfx("vfx/moments/mp_descent/mp_descent_trim");
  level._effect["mp_descent_dust_int"] = loadfx("fx/maps/mp_lonestar/mp_ls_quake_dust_int");
  level._effect["mp_descent_dustkickup"] = loadfx("vfx/moments/mp_descent/vfx_quake_debris");
  level._effect["mp_descent_chunks"] = loadfx("vfx/moments/mp_descent/vfx_quake_debris");
  level._effect["mp_descent_panel"] = loadfx("fx/maps/mp_lonestar/mp_ls_panel");
  level._effect["mp_descent_trim"] = loadfx("vfx/moments/mp_descent/vfx_quake_debris");
}