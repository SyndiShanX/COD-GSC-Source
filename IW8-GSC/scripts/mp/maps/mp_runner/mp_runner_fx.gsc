/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_runner\mp_runner_fx.gsc
******************************************************/

function main() {
  level._effect["vfx_run_pipe_runoff"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_pipe_runoff.vfx");
  level._effect["vfx_birds_sparrows_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrows_circling.vfx");
  level._effect["vfx_birds_sparrow_burst_01"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrow_burst_01.vfx");
  level._effect["vfx_run_green_lensflare"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_green_lensflare.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_run_constant_motes"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_constant_motes.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_electrical_sparks_1"] = loadfx("vfx/iw8/level/gen_amb/vfx_electrical_sparks_1.vfx");
  level._effect["vfx_grate_steam_sm"] = loadfx("vfx/iw8_mp/level/runner/vfx_grate_steam_sm.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_run_machine_quarry_far"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_machine_quarry_far.vfx");
  level._effect["vfx_run_small_pour_top"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_small_pour_top.vfx");
  level._effect["vfx_run_small_pour"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_small_pour.vfx");
  level._effect["vfx_run_water_top_b"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_water_top_b.vfx");
  level._effect["vfx_run_green_lensflare_tfl"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_green_lensflare_tfl.vfx");
  level._effect["vfx_run_red_lensflare_tfl"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_red_lensflare_tfl.vfx");
  level._effect["vfx_run_water_splash"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_water_splash.vfx");
  level._effect["vfx_run_water_top"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_water_top.vfx");
  level._effect["vfx_run_small_desert"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_small_desert.vfx");
  level._effect["vfx_run_water_pour_sm"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_water_pour_sm.vfx");
  level._effect["vfx_run_red_lensflare_dim"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_red_lensflare_dim.vfx");
  level._effect["vfx_run_red_lensflare"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_red_lensflare.vfx");
  level._effect["vfx_run_light_flare"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_light_flare.vfx");
  level._effect["vfx_run_machine_quarry_imp"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_machine_quarry_imp.vfx");
  level._effect["vfx_run_machine_quarry"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_machine_quarry.vfx");
  level._effect["vfx_run_blowing_leaf_d"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_blowing_leaf_d.vfx");
  level._effect["vfx_run_chimney_smoke"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_chimney_smoke.vfx");
  level._effect["vfx_run_chimney_smoke_bg"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_chimney_smoke_bg.vfx");
  level._effect["vfx_run_sand_flat"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_sand_flat.vfx");
  level._effect["vfx_run_cloud_2"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_cloud_2.vfx");
  level._effect["vfx_run_cloud_1"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_cloud_1.vfx");
  level._effect["vfx_run_train_control_screen_pong"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_train_control_screen_pong.vfx");
  level._effect["vfx_run_train_control_screen_main"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_train_control_screen_main.vfx");
  level._effect["vfx_run_billow_mist_a"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_billow_mist_a.vfx");
  level._effect["vfx_run_dust_move_slow"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_dust_move_slow.vfx");
  level._effect["vfx_run_fire_linger"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_fire_linger.vfx");
  level._effect["vfx_run_gd_steam_a"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_gd_steam_a.vfx");
  level._effect["vfx_run_window_smoke"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_window_smoke.vfx");
}