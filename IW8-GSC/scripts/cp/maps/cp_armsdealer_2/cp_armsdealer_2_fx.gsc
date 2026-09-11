/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_fx.gsc
******************************************************************/

function main() {
  level._effect["vfx_cp_plane_landing_dust"] = loadfx("vfx/iw8_cp/vfx_cp_plane_landing_dust.vfx");
  level._effect["vfx_plane_landing_treadfx"] = loadfx("vfx/iw8_cp/prop/vfx_plane_landing_treadfx.vfx");
  level._effect["vfx_wp_train_explosion"] = loadfx("vfx/iw8_cp/quarry/vfx_wp_train_explosion.vfx");
  level._effect["vfx_carepkg_landing_dust"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
  level._effect["vfx_train_breach"] = loadfx("vfx/iw8_cp/quarry/vfx_wp_train_breach.vfx");
  level._effect["vfx_train_exhsmk"] = loadfx("vfx/iw8_cp/quarry/vfx_wp_train_exhsmk.vfx");
  level._effect["vfx_ac130_explosion"] = loadfx("vfx/iw8_cp/vfx_cp_ac130_explode_fireball.vfx");
  level._effect["vfx_mp_smoke_01"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_mp");
  level._effect["nuke_core_vapor"] = loadfx("vfx/iw8_cp/prop/vfx_cp_nuke_core_expose_vapor");
  level._effect["vfx_signal_jammer_damage_1"] = loadfx("vfx/iw8_cp/vfx_signal_jammer_damage_1");
  level._effect["vfx_signal_jammer_damage_2"] = loadfx("vfx/iw8_cp/vfx_signal_jammer_damage_2");
  level._effect["vfx_signal_jammer_damage_3"] = loadfx("vfx/iw8_cp/vfx_signal_jammer_damage_3");
  level._effect["vfx_signal_jammer_damage_4"] = loadfx("vfx/iw8_cp/vfx_signal_jammer_damage_4");
  level._effect["vfx_signal_jammer_exp"] = loadfx("vfx/iw8_cp/vfx_signal_jammer_exp");
  level._effect["vfx_cp_camera_flash"] = loadfx("vfx/iw8_cp/vfx_cp_camera_flash.vfx");
  level._effect["vfx_gib_explode"] = loadfx("vfx/iw8/weap/_explo/gib/vfx_body_explode_gib.vfx");
  level._effect["vfx_ai_techo_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood.vfx");
  level._effect["vfx_ai_techo_smoke_moving"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood_moving.vfx");
  level._effect["vfx_ai_mkilo_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood_mkilo23.vfx");
  level._effect["vfx_ai_mkilo_smoke_moving"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood_moving_mkilo23.vfx");
  level._effect["vfx_ai_gen_fire"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_const_lrg.vfx");
  level._effect["vfx_mkilo_tire_explode_right"] = loadfx("vfx/iw8/veh/mkilo/vfx_mkilo_tire_explode_right.vfx");
  level._effect["vfx_mkilo_tire_explode_left"] = loadfx("vfx/iw8/veh/mkilo/vfx_mkilo_tire_explode_left.vfx");
  scripts\cp\maps\cp_donetsk\milbase\ai_flare::load_fx();
  scripts\cp\cp_skits::skit_fx();
  scripts\cp\helicopter\cp_helicopter::heli_precache();
}