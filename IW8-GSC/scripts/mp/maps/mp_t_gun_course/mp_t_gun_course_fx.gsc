/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_t_gun_course\mp_t_gun_course_fx.gsc
******************************************************************/

function main() {
  level._effect["vfx_fluorescent_flare"] = loadfx("vfx/iw8_mp/level/mp_t_gun_course/vfx_fluorescent_flare.vfx");
  level._effect["vfx_flood_light_flare"] = loadfx("vfx/iw8_mp/level/mp_t_gun_course/vfx_flood_light_flare.vfx");
  level._effect["vfx_br_fluorescent_flare"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_fluorescent_flare.vfx");
  level._effect["vfx_flood_light_flare"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_flood_light_flare.vfx");
  level._effect["vfx_br_water_drips_single_fast"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_water_drips_single_fast.vfx");
  level._effect["vfx_br_water_drips_line_1"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_water_drips_line_1.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_car_fire_linger_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_linger_2.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
  level._effect["vfx_speed_sunflare"] = loadfx("vfx/iw8_mp/level/speed/vfx_speed_sunflare.vfx");
  level._effect["vfx_speed_falling_dust_ceiling_sm_ch2"] = loadfx("vfx/iw8_mp/level/speed/vfx_speed_falling_dust_ceiling_sm_ch2.vfx");
  level._effect["vfx_mosquitos_over_water_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mosquitos_over_water_1.vfx");
  level._effect["vfx_speed_gd_steam_a"] = loadfx("vfx/iw8_mp/level/speed/vfx_speed_gd_steam_a.vfx");
  level._effect["vfx_pine_constant_motes"] = loadfx("vfx/iw8_mp/level/pine/vfx_pine_constant_motes.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_speed_sand_flat"] = loadfx("vfx/iw8_mp/level/speed/vfx_speed_sand_flat.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_speed_dust_move_slow"] = loadfx("vfx/iw8_mp/level/speed/vfx_speed_dust_move_slow.vfx");
  level._effect["vfx_speed_billow_mist_a"] = loadfx("vfx/iw8_mp/level/speed/vfx_speed_billow_mist_a.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_br_dust_motes_fast_sml"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_dust_motes_fast_sml.vfx");
  level._effect["vfx_br_dust_motes_fast_med"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_dust_motes_fast_med.vfx");
  level._effect["vfx_br_dust_motes_sml"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_dust_motes_sml.vfx");
  level._effect["vfx_br_dust_motes_med"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_dust_motes_med.vfx");
  level._effect["vfx_br_ambient_smk"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_ambient_smk.vfx");
  level._effect["vfx_br_ambient_smk_lg"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_ambient_smk_lg.vfx");
  level._effect["vfx_br_wind_blowing"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_wind_blowing.vfx");
  level._effect["vfx_br_wind_blowing_sand"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_wind_blowing_sand.vfx");
  level._effect["vfx_br_wind_debris"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_wind_debris.vfx");
  level._effect["vfx_br_wind_dust_debris"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_wind_dust_debris.vfx");
  level._effect["vfx_br_car_smoke"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_car_smoke.vfx");
  level._effect["vfx_br_smoke_hood"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_smoke_hood.vfx");
  level._effect["vfx_br_trash_circle"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_trash_circle.vfx");
  level._effect["vfx_br_electrical_sparks"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_electrical_sparks.vfx");
  level._effect["vfx_br_electrical_sparks_2"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_electrical_sparks_2.vfx");
  level._effect["vfx_br_electrical_transformer_sparks"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_electrical_transformer_sparks.vfx");
  level._effect["vfx_br_car_fire_linger"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_car_fire_linger.vfx");
  level._effect["vfx_br_insect_flies_trash"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_insect_flies_trash.vfx");
  level._effect["vfx_br_insect_flies_sml"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_insect_flies_sml.vfx");
  level._effect["vfx_br_birds_circling"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_birds_circling.vfx");
}