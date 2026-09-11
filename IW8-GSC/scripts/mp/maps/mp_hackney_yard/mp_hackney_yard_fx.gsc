/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hackney_yard\mp_hackney_yard_fx.gsc
******************************************************************/

function main() {
  level._effect["vfx_crane_hangar_01_animate"] = loadfx("vfx/iw8/prop/scriptables/vfx_crane_hangar_01_animate.vfx");
  level._effect["vfx_bg_light_red"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_bg_light_red.vfx");
  level._effect["vfx_hackney_distant_fog"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_hackney_distant_fog.vfx");
  level._effect["vfx_tower_flash_red"] = loadfx("vfx/iw8_mp/level/runner_pm/vfx_tower_flash_red.vfx");
  level._effect["vfx_car_headlight_lensflare_nolight"] = loadfx("vfx/iw8/level/gen_amb/vfx_car_headlight_lensflare_nolight.vfx");
  level._effect["vfx_knee_high_mist_lt"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_knee_high_mist_lt.vfx");
  level._effect["vfx_car_tailight_flare"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_car_tailight_flare.vfx");
  level._effect["vfx_barrel_fire"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_barrel_fire.vfx");
  level._effect["vfx_window_rain_open_drk"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_window_rain_open_drk.vfx");
  level._effect["vfx_vent_steam_windy_drk"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vent_steam_windy_drk.vfx");
  level._effect["vfx_rain_cloud_canopy"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_cloud_canopy.vfx");
  level._effect["vfx_mist_ground_drift_drk_ng"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift_drk_ng.vfx");
  level._effect["vfx_mist_ground_drift_drk"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift_drk.vfx");
  level._effect["vfx_emp_main_blast"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_main_blast.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_trash_drift_hack"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_trash_drift_hack.vfx");
  level._effect["vfx_oc_drips"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_oc_drips.vfx");
  level._effect["vfx_window_rain_open"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_window_rain_open.vfx");
  level._effect["vfx_trash_flys"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_trash_flys.vfx");
  level._effect["vfx_drifting_ivy"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_drifting_ivy.vfx");
  level._effect["vfx_scrn_lookup_drops"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_scrn_lookup_drops.vfx");
  level._effect["vfx_knee_high_mist"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_knee_high_mist.vfx");
  level._effect["vfx_car_exhaust"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_car_exhaust.vfx");
  level._effect["vfx_moths"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_moths.vfx");
  level._effect["vfx_train_sparks_falling"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_sparks_falling.vfx");
  level._effect["vfx_train_sparks_runner"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_sparks_runner.vfx");
  level._effect["vfx_train_back"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_back.vfx");
  level._effect["vfx_flip_light_red"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_flip_light_red.vfx");
  level._effect["vfx_flip_light_yellow"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_flip_light_yellow.vfx");
  level._effect["vfx_rain_runoff_01"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_runoff_01.vfx");
  level._effect["vfx_wall_vent_steam"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_wall_vent_steam.vfx");
  level._effect["vfx_grnd_vent_steam"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_grnd_vent_steam.vfx");
  level._effect["vfx_vista_mist_thick"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vista_mist_thick.vfx");
  level._effect["vfx_runoff_imp"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_runoff_imp.vfx");
  level._effect["vfx_streetlight_flare"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_streetlight_flare.vfx");
  level._effect["vfx_rain_runoff_impacts"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_runoff_impacts.vfx");
  level._effect["vfx_rain_light_centric"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_light_centric.vfx");
  level._effect["vfx_rat_hackney_runner"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rat_hackney_runner.vfx");
  level._effect["vfx_vista_mist_hackney"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vista_mist_hackney.vfx");
  level._effect["vfx_vent_steam_windy"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vent_steam_windy.vfx");
  level._effect["vfx_smoke_stack"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_smoke_stack.vfx");
  level._effect["vfx_mist_ground_drift_ng"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift_ng.vfx");
  level._effect["vfx_mist_large_gust"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_large_gust.vfx");
  level._effect["vfx_mist_ground_drift"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift.vfx");
  level._effect["vfx_rain_splashes_c"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_splashes_c.vfx");
  level._effect["vfx_rain_splashes_b"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_splashes_b.vfx");
  level._effect["vfx_rain_splashes_a"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_splashes_a.vfx");
  level._effect["vfx_cam_heavy_rain"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_cam_heavy_rain.vfx");
  level._effect["iw8_rain_dripping_water_c"] = loadfx("vfx/iw8_mp/level/marawi/iw8_rain_dripping_water_c.vfx");
}