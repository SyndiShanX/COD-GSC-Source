/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler_2\cp_smuggler_2_fx.gsc
**************************************************************/

function main() {
  level._effect["vfx_train_treadfx_dust"] = loadfx("vfx/iw8_cp/quarry/vfx_train_treadfx_dust.vfx");
  level._effect["vfx_cp_camera_flash"] = loadfx("vfx/iw8_cp/vfx_cp_camera_flash.vfx");
  level._effect["vfx_ai_techo_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood.vfx");
  level._effect["vfx_ai_techo_smoke_moving"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood_moving.vfx");
  level._effect["vfx_ai_mkilo_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood_mkilo23.vfx");
  level._effect["vfx_ai_mkilo_smoke_moving"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood_moving_mkilo23.vfx");
  level._effect["vfx_ai_gen_fire"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_const_lrg.vfx");
  level._effect["vfx_fire_linger_small"] = loadfx("vfx/iw8/veh/scriptables/shared/vfx_veh_fire_linger_sml.vfx");
  level._effect["vfx_mkilo_tire_explode_right"] = loadfx("vfx/iw8/veh/mkilo/vfx_mkilo_tire_explode_right.vfx");
  level._effect["vfx_mkilo_tire_explode_left"] = loadfx("vfx/iw8/veh/mkilo/vfx_mkilo_tire_explode_left.vfx");
  level._effect["vfx_wp_train_explosion"] = loadfx("vfx/iw8_cp/quarry/vfx_wp_train_explosion.vfx");
  level._effect["vfx_carepkg_landing_dust"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
  level._effect["vfx_train_breach"] = loadfx("vfx/iw8_cp/quarry/vfx_wp_train_breach.vfx");
  level._effect["vfx_train_exhsmk"] = loadfx("vfx/iw8_cp/quarry/vfx_wp_train_exhsmk.vfx");
  level._effect["vfx_marker_dom_yellow"] = loadfx("vfx/core/mp/core/vfx_marker_dom_yellow");
  level._effect["vfx_ac130_explosion"] = loadfx("vfx/iw8_cp/vfx_cp_ac130_explode_fireball.vfx");
  level._effect["vfx_mp_smoke_01"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_mp");
  level._effect["helidown_rpghit"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx");
  level._effect["helidown_tailfire"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_fire_fire_trail.vfx");
  level._effect["helidown_groundexp"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_chopper_ground_exp.vfx");
  scripts\cp\maps\cp_donetsk\milbase\ai_flare::load_fx();
}