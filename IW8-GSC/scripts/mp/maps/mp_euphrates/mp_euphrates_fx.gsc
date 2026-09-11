/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_euphrates\mp_euphrates_fx.gsc
************************************************************/

function main() {
  level._effect["vfx_eup_smk_vista"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_smk_vista.vfx");
  level._effect["vfx_fire_tiny"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_tiny.vfx");
  level._effect["vfx_fire_sml"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_sml.vfx");
  level._effect["vfx_eup_light_flare"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_light_flare.vfx");
  level._effect["vfx_wind_global_dummy"] = loadfx("vfx/iw8/wind/vfx_wind_global_dummy.vfx");
  level._effect["vfx_barricade_flashing_lights"] = loadfx("vfx/iw8_mp/gen_amb/vfx_barricade_flashing_lights.vfx");
  level._effect["vfx_eup_townsquare_motes"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_townsquare_motes.vfx");
  level._effect["vfx_swirling_dust"] = loadfx("vfx/iw8_mp/level/faridah/vfx_swirling_dust.vfx");
  level._effect["vfx_blowing_sand_pile"] = loadfx("vfx/iw8_mp/level/faridah/vfx_blowing_sand_pile.vfx");
  level._effect["vfx_blowing_sand_low"] = loadfx("vfx/iw8_mp/level/faridah/vfx_blowing_sand_low.vfx");
  level._effect["vfx_electrical_sparks_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_electrical_sparks_1.vfx");
  level._effect["vfx_eup_blowing_sand_flat"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_blowing_sand_flat.vfx");
  level._effect["vfx_eup_fire_sm"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_fire_sm.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_eup_fire_big"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_fire_big.vfx");
  level._effect["vfx_eup_fire_linger"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_fire_linger.vfx");
  level._effect["vfx_eup_blowing_leaf"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_blowing_leaf.vfx");
  level._effect["vfx_eup_gd_steam_a"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_gd_steam_a.vfx");
  level._effect["vfx_eup_indoor_motes_wrap"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_indoor_motes_wrap.vfx");
  level._effect["vfx_eup_billow_mist_a"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_billow_mist_a.vfx");
  level._effect["vfx_eup_dust_move_slow"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_eup_dust_move_slow.vfx");
  level._effect["vfx_euphrates_sunflare"] = loadfx("vfx/iw8_mp/level/euphrates/vfx_euphrates_sunflare.vfx");
  level._effect["vfx_mist_ground_01"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mist_ground_01.vfx");
  level._effect["vfx_dragonflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dragonflies.vfx");
  level._effect["vfx_car_smolder_lrg"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_smolder_lrg.vfx");
  level._effect["vfx_car_fire_const_lrg"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_const_lrg.vfx");
  level._effect["vfx_birds_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_circling.vfx");
  level._effect["vfx_birds_circling_seagulls"] = loadfx("vfx/iw8/level/gen_amb/vfx_birds_circling_seagulls.vfx");
  level._effect["vfx_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_falling_dust_ceiling.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8/level/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_dust_motes_lrg"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_lrg.vfx");
  level._effect["vfx_dust_move_slow"] = loadfx("vfx/iw8_mp/level/faridah/vfx_dust_move_slow.vfx");
  level._effect["vfx_water_drips_line_1"] = loadfx("vfx/iw8/level/gen_amb/vfx_water_drips_line_1.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_mosquitos_over_water_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mosquitos_over_water_1.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_moths_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_2.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
}