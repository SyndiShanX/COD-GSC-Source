/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_lonestar_fx.gsc
**************************************/

main() {
  level._effect["mp_ls_dustkickup_surface"] = loadfx("fx/maps/mp_lonestar/mp_ls_dustkickup_surface");
  level._effect["mp_ls_quake_chunks"] = loadfx("fx/maps/mp_lonestar/mp_ls_quake_chunks");
  level._effect["mp_ls_panel"] = loadfx("fx/maps/mp_lonestar/mp_ls_panel");
  level._effect["mp_ls_trim"] = loadfx("fx/maps/mp_lonestar/mp_ls_trim");
  level._effect["mp_ls_quake_debris"] = loadfx("fx/maps/mp_lonestar/mp_ls_quake_debris");
  level._effect["mp_ls_quake_debris_lrg"] = loadfx("fx/maps/mp_lonestar/mp_ls_quake_debris_lrg");
  level._effect["mp_ls_quake_dust_int"] = loadfx("fx/maps/mp_lonestar/mp_ls_quake_dust_int");
  level._effect["mp_ls_dustkickup"] = loadfx("fx/maps/mp_lonestar/mp_ls_dustkickup");
  level._effect["mp_ls_car_smash"] = loadfx("fx/maps/mp_lonestar/mp_ls_car_smash");
  level._effect["bats_single_spooked"] = loadfx("fx/animals/bats_single_spooked");
  level._effect["mp_ls_concrete_smash"] = loadfx("fx/maps/mp_lonestar/mp_ls_concrete_smash");
  level._effect["mp_ls_gaspipe_fire"] = loadfx("fx/maps/mp_lonestar/mp_ls_gaspipe_fire");
  level._effect["mp_ls_quake_dustfall"] = loadfx("fx/maps/mp_lonestar/mp_ls_quake_dustfall");
  level._effect["vfx_fire_falling_runner_ls"] = loadfx("vfx/moments/mp_lonestar/vfx_fire_falling_runner_ls");
  level._effect["vfx_thick_plume_ls"] = loadfx("vfx/moments/mp_lonestar/vfx_thick_plume_ls");
  level._effect["vfx_hummer_fire"] = loadfx("vfx/moments/mp_lonestar/vfx_hummer_fire");
  level._effect["vfx_sunflare"] = loadfx("vfx/ambient/atmospheric/vfx_sunflare_ls");
  level._effect["mp_ls_trash_wide_runner"] = loadfx("fx/maps/mp_lonestar/mp_ls_trash_wide_runner");
  level._effect["mp_ls_trash_runner"] = loadfx("fx/maps/mp_lonestar/mp_ls_trash_runner");
  level._effect["mp_ls_blowtrash_runner"] = loadfx("fx/maps/mp_lonestar/mp_ls_blowtrash_runner");
  level._effect["vfx_sand_large_gust_runner"] = loadfx("vfx/ambient/weather/sand/vfx_sand_large_gust_runner");
  level._effect["vfx_fire_ground_sov"] = loadfx("vfx/ambient/fire/wall/vfx_fire_ground_sov");
  level._effect["vfx_dust_crack_runner"] = loadfx("vfx/ambient/dust/vfx_dust_crack_runner");
  level._effect["mp_ls_godray_taper"] = loadfx("fx/maps/mp_lonestar/mp_ls_godray_taper");
  level._effect["mp_ls_godray_quad"] = loadfx("fx/maps/mp_lonestar/mp_ls_godray_quad");
  level._effect["vfx_steam_small_up"] = loadfx("vfx/ambient/steam/vfx_steam_small_up");
  level._effect["mp_ls_ng_vista_falling"] = loadfx("fx/maps/mp_lonestar/mp_ls_ng_vista_falling");
  level._effect["mp_ls_vista_dust"] = loadfx("fx/maps/mp_lonestar/mp_ls_vista_dust");
  level._effect["mp_ls_dust_fall"] = loadfx("fx/maps/mp_lonestar/mp_ls_dust_fall");
  level._effect["mp_pb_godray_thin"] = loadfx("fx/maps/mp_lonestar/mp_ls_godray_thin");
  level._effect["mp_pb_godray_single"] = loadfx("fx/maps/mp_lonestar/mp_ls_godray_single");
  level._effect["mp_pb_godraylarge"] = loadfx("fx/maps/mp_lonestar/mp_ls_godraylarge");
  level._effect["leaves_fall_gentlewind_green_100_mp"] = loadfx("fx/misc/leaves_fall_gentlewind_green_100_mp");
  level._effect["insects_carcass_flies_dark"] = loadfx("fx/misc/insects_carcass_flies_dark");
  level._effect["mp_ls_ng_bricks_falling"] = loadfx("fx/maps/mp_lonestar/mp_ls_ng_bricks_falling");
  level._effect["vfx_ls_leaves_falling"] = loadfx("vfx/ambient/atmospheric/vfx_ls_leaves_falling");
  level._effect["vfx_int_haze_ls"] = loadfx("vfx/moments/mp_lonestar/vfx_int_haze_ls");
  level._effect["vfx_slowdust_def"] = loadfx("vfx/moments/mp_lonestar/vfx_slowdust_def");
  level._effect["vfx_slowdust"] = loadfx("vfx/moments/mp_lonestar/vfx_slowdust");
  level._effect["vfx_part_cluster"] = loadfx("vfx/moments/mp_lonestar/vfx_part_cluster");
  level._effect["vfx_mparticlulate_ls"] = loadfx("vfx/moments/mp_lonestar/vfx_mparticlulate_ls");
  level._effect["vfx_dust_bld_ls_runner"] = loadfx("vfx/moments/mp_lonestar/vfx_dust_bld_ls_runner");
  level._effect["vfx_dust_hole_runner"] = loadfx("vfx/moments/mp_lonestar/vfx_dust_hole_runner");
  level._effect["vfx_birds_takeoff_run_ls"] = loadfx("vfx/moments/mp_lonestar/vfx_birds_takeoff_run_ls");
  level._effect["vfx_fire_window_ls"] = loadfx("vfx/moments/mp_lonestar/vfx_fire_window_ls");
  level._effect["vfx_birds_fly_runner"] = loadfx("vfx/moments/mp_lonestar/vfx_birds_fly_runner");
  level._effect["mp_ls_bees"] = loadfx("fx/maps/mp_lonestar/mp_ls_bees");
  level._effect["vfx_ls_roofdust_runner"] = loadfx("vfx/moments/mp_lonestar/vfx_ls_roofdust_runner");
  level._effect["vfx_fire_small_nolight_mp"] = loadfx("vfx/ambient/fire/vfx_fire_small_nolight_mp");
  level._effect["mp_ls_cg_vista_falling"] = loadfx("fx/maps/mp_lonestar/mp_ls_cg_vista_falling");
  level._effect["vfx_handflare_ls"] = loadfx("vfx/ambient/props/vfx_handflare_ls");
}