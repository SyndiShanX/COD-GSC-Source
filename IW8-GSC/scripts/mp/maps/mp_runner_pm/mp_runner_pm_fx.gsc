/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_runner_pm\mp_runner_pm_fx.gsc
************************************************************/

function main() {
  level._effect["vfx_runpm_box_light_flare"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_box_light_flare.vfx");
  level._effect["vfx_runpm_bulb_light_flare_red"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_bulb_light_flare_red.vfx");
  level._effect["vfx_runpm_bulb_light_flare"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_bulb_light_flare.vfx");
  level._effect["vfx_run_pipe_runoff"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_pipe_runoff.vfx");
  level._effect["vfx_flood_light_flare"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_flood_light_flare.vfx");
  level._effect["vfx_runpm_grate_steam_sm"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_grate_steam_sm.vfx");
  level._effect["vfx_grate_round_steam"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_grate_round_steam.vfx");
  level._effect["vfx_run_small_desert"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_small_desert.vfx");
  level._effect["vfx_run_water_top_b"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_water_top_b.vfx");
  level._effect["vfx_run_water_top"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_water_top.vfx");
  level._effect["vfx_grate_steam_sm"] = loadfx("vfx/iw8_mp/level/runner/vfx_grate_steam_sm.vfx");
  level._effect["vfx_electrical_sparks_1"] = loadfx("vfx/iw8/level/gen_amb/vfx_electrical_sparks_1.vfx");
  level._effect["vfx_work_light_distant"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_work_light_distant.vfx");
  level._effect["vfx_tower_flash_red"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_tower_flash_red.vfx");
  level._effect["vfx_flood_light_flare_bright"] = loadfx("vfx/iw8_mp/gen_amb/vfx_flood_light_flare_bright.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_runpm_fly"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_fly.vfx");
  level._effect["vfx_runpm_fireflys"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_fireflys.vfx");
  level._effect["vfx_runpm_chimney_smoke_br"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_chimney_smoke_br.vfx");
  level._effect["vfx_run_billow_mist_a"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_billow_mist_a.vfx");
  level._effect["vfx_runpm_fire_linger"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_fire_linger.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_run_machine_quarry_far"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_machine_quarry_far.vfx");
  level._effect["vfx_run_small_pour_top"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_small_pour_top.vfx");
  level._effect["vfx_run_small_pour"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_small_pour.vfx");
  level._effect["vfx_run_green_lensflare_tfl"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_green_lensflare_tfl.vfx");
  level._effect["vfx_run_red_lensflare_tfl"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_red_lensflare_tfl.vfx");
  level._effect["vfx_run_water_splash"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_water_splash.vfx");
  level._effect["vfx_run_water_pour_sm"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_water_pour_sm.vfx");
  level._effect["vfx_run_red_lensflare_dim"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_red_lensflare_dim.vfx");
  level._effect["vfx_run_red_lensflare"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_red_lensflare.vfx");
  level._effect["vfx_car_taillight_lensflare_nolight"] = loadfx("vfx/iw8/level/estate/vfx_car_taillight_lensflare_nolight.vfx");
  level._effect["vfx_run_light_flare"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_light_flare.vfx");
  level._effect["vfx_run_machine_quarry_imp"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_machine_quarry_imp.vfx");
  level._effect["vfx_run_machine_quarry"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_machine_quarry.vfx");
  level._effect["vfx_run_blowing_leaf_d"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_blowing_leaf_d.vfx");
  level._effect["vfx_run_chimney_smoke"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_chimney_smoke.vfx");
  level._effect["vfx_run_chimney_smoke_bg"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_chimney_smoke_bg.vfx");
  level._effect["vfx_run_sand_flat"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_runpm_sand_flat.vfx");
  level._effect["vfx_run_cloud_2"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_cloud_2.vfx");
  level._effect["vfx_run_cloud_1"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_cloud_1.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_run_train_control_screen_pong"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_train_control_screen_pong.vfx");
  level._effect["vfx_run_train_control_screen_main"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_train_control_screen_main.vfx");
  level._effect["vfx_run_dust_move_slow"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_dust_move_slow.vfx");
  level._effect["vfx_run_fire_linger"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_fire_linger.vfx");
  level._effect["vfx_run_gd_steam_a"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_gd_steam_a.vfx");
  level._effect["vfx_run_window_smoke"] = loadfx("vfx/iw8_mp/level/runner/vfx_run_window_smoke.vfx");
}