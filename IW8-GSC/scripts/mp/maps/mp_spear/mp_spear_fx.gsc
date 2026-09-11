/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_spear\mp_spear_fx.gsc
****************************************************/

function main() {
  level._effect["vfx_spear_sandstorm"] = loadfx("vfx/iw8_mp/level/spear/vfx_spear_sandstorm.vfx");
  level._effect["vfx_fire_tiny"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_tiny.vfx");
  level._effect["vfx_birds_sparrow_burst_01"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrow_burst_01.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_mosquitos_over_water_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mosquitos_over_water_1.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_moths_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_2.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
  level._effect["vfx_wind_global_dummy"] = loadfx("vfx/iw8/wind/vfx_wind_global_dummy.vfx");
  level._effect["vfx_fire_sml"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_sml.vfx");
  level._effect["vfx_water_drips_line_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_water_drips_line_1.vfx");
  level._effect["vfx_blowing_sand_low"] = loadfx("vfx/iw8_mp/level/faridah/vfx_blowing_sand_low.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_spr_tower_birds"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_tower_birds.vfx");
  level._effect["vfx_spr_water_pour_sm"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_water_pour_sm.vfx");
  level._effect["vfx_spr_billow_mist_a_sdw"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_billow_mist_a_sdw.vfx");
  level._effect["vfx_spr_mist_fast"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_mist_fast.vfx");
  level._effect["vfx_spr_water_pour_gd"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_water_pour_gd.vfx");
  level._effect["vfx_spr_water_pour"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_water_pour.vfx");
  level._effect["vfx_spr_fire_big"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_fire_big.vfx");
  level._effect["vfx_spr_plume"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_plume.vfx");
  level._effect["vfx_spr_falling_dust_ceiling_s"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_falling_dust_ceiling_s.vfx");
  level._effect["vfx_spr_smk_white"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_smk_white.vfx");
  level._effect["vfx_spear_bird_fly_up_y"] = loadfx("vfx/iw8_mp/level/spear/vfx_spear_bird_fly_up_y.vfx");
  level._effect["vfx_spr_bird_sky_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_bird_sky_a.vfx");
  level._effect["vfx_spr_window_smoke_3"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_window_smoke_3.vfx");
  level._effect["vfx_spr_blowing_leaf_b"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_blowing_leaf_b.vfx");
  level._effect["vfx_spr_fire_linger"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_fire_linger.vfx");
  level._effect["vfx_spr_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_falling_dust_ceiling.vfx");
  level._effect["vfx_spear_bird_roof_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spear_bird_roof_a.vfx");
  level._effect["vfx_spr_gd_steam_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_gd_steam_a.vfx");
  level._effect["vfx_spear_bird_fly_up"] = loadfx("vfx/iw8_mp/level/spear/vfx_spear_bird_fly_up.vfx");
  level._effect["vfx_zmb_rat_emit"] = loadfx("vfx/iw8_mp/level/spear/vfx_zmb_rat_emit.vfx");
  level._effect["vfx_spear_bird_ground_line"] = loadfx("vfx/iw8_mp/level/spear/vfx_spear_bird_ground_line.vfx");
  level._effect["vfx_spear_bird_ground_roof"] = loadfx("vfx/iw8_mp/level/spear/vfx_spear_bird_ground_roof.vfx");
  level._effect["vfx_spear_bird_ground_jump"] = loadfx("vfx/iw8_mp/level/spear/vfx_spear_bird_ground_jump.vfx");
  level._effect["vfx_spr_rat_run_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_rat_run_a.vfx");
  level._effect["vfx_spr_rat_walk"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_rat_walk.vfx");
  level._effect["vfx_spr_indoor_motes_b"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_indoor_motes_b.vfx");
  level._effect["vfx_spr_indoor_motes_wrap"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_indoor_motes_wrap.vfx");
  level._effect["vfx_spr_window_smoke_2"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_window_smoke_2.vfx");
  level._effect["vfx_spr_sunflare"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_sunflare.vfx");
  level._effect["vfx_spr_dust_move_slow"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_dust_move_slow.vfx");
  level._effect["vfx_spr_billow_mist_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_billow_mist_a.vfx");
  level._effect["vfx_spr_chimney_smoke"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_chimney_smoke.vfx");
  level._effect["vfx_spr_blowing_sand_flat"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_blowing_sand_flat.vfx");
}