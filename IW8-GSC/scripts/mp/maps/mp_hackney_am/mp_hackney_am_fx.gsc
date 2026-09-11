/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hackney_am\mp_hackney_am_fx.gsc
**************************************************************/

function main() {
  level._effect["vfx_crane_hangar_01_animate"] = loadfx("vfx/iw8/prop/scriptables/vfx_crane_hangar_01_animate.vfx");
  level._effect["vfx_hackam_sunflare"] = loadfx("vfx/iw8_mp/level/hackyard/am/vfx_hackam_sunflare.vfx");
  level._effect["vfx_smoke_stack"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_smoke_stack.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_hackam_grate_steam"] = loadfx("vfx/iw8_mp/level/hackyard/am/vfx_hackam_grate_steam.vfx");
  level._effect["vfx_car_fire_linger_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_linger_2.vfx");
  level._effect["vfx_hackam_billow_mist_1"] = loadfx("vfx/iw8_mp/level/hackyard/am/vfx_hackam_billow_mist_1.vfx");
  level._effect["vfx_knee_high_mist_lt"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_knee_high_mist_lt.vfx");
  level._effect["vfx_barrel_fire"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_barrel_fire.vfx");
  level._effect["vfx_mist_ground_drift_drk_ng"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift_drk_ng.vfx");
  level._effect["vfx_mist_ground_drift_drk"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift_drk.vfx");
  level._effect["vfx_emp_main_blast"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_main_blast.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_trash_flys"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_trash_flys.vfx");
  level._effect["vfx_drifting_ivy"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_drifting_ivy.vfx");
  level._effect["vfx_knee_high_mist"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_knee_high_mist.vfx");
  level._effect["vfx_car_exhaust"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_car_exhaust.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_train_sparks_falling"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_sparks_falling.vfx");
  level._effect["vfx_train_sparks_runner"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_sparks_runner.vfx");
  level._effect["vfx_train_back"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_back.vfx");
  level._effect["vfx_flip_light_red"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_flip_light_red.vfx");
  level._effect["vfx_flip_light_yellow"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_flip_light_yellow.vfx");
  level._effect["vfx_wall_vent_steam"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_wall_vent_steam.vfx");
  level._effect["vfx_grnd_vent_steam"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_grnd_vent_steam.vfx");
  level._effect["vfx_vista_mist_thick"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vista_mist_thick.vfx");
  level._effect["vfx_runoff_imp"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_runoff_imp.vfx");
  level._effect["vfx_rat_hackney_runner"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rat_hackney_runner.vfx");
  level._effect["vfx_vista_mist_hackney"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vista_mist_hackney.vfx");
  level._effect["vfx_vent_steam_windy"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vent_steam_windy.vfx");
  level._effect["vfx_smoke_stack"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_smoke_stack.vfx");
  level._effect["vfx_mist_ground_drift_ng"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift_ng.vfx");
  level._effect["vfx_mist_large_gust"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_large_gust.vfx");
  level._effect["vfx_mist_ground_drift"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift.vfx");
  level._effect["iw8_rain_dripping_water_c"] = loadfx("vfx/iw8_mp/level/marawi/iw8_rain_dripping_water_c.vfx");
  level._effect["vfx_birds_circling_seagulls"] = loadfx("vfx/iw8/level/gen_amb/vfx_birds_circling_seagulls.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8/level/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8/level/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_spr_rat_run_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_rat_run_a.vfx");
  level._effect["vfx_spr_rat_walk"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_rat_walk.vfx");
  level._effect["vfx_water_drips_line_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_water_drips_line_1.vfx");
}