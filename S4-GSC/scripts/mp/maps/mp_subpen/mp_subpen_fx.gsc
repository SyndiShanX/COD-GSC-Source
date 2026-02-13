/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_subpen\mp_subpen_fx.gsc
******************************************************/

main() {
  level._effect["mp_subpen_truck_headlight_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_truck_headlight_01.vfx");
  level._effect["mp_subpen_fire_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_fire_01.vfx");
  level._effect["mp_subpen_birds_straight_burst_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_birds_straight_burst_01.vfx");
  level._effect["mp_subpen_birds_circling_seagulls_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_birds_circling_seagulls_01.vfx");
  level._effect["mp_subpen_birds_circling_seagulls_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_birds_circling_seagulls_02.vfx");
  level._effect["mp_subpen_chimney_smoke_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_chimney_smoke_02.vfx");
  level._effect["mp_subpen_water_caustics_wall_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_caustics_wall_01.vfx");
  level._effect["mp_subpen_fog_vista_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_fog_vista_01.vfx");
  level._effect["mp_subpen_chimney_smoke_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_chimney_smoke_01.vfx");
  level._effect["mp_subpen_light_lens_flare_white"] = loadfx("vfx/s4/level/subpen/mp_subpen_light_lens_flare_white.vfx");
  level._effect["mp_subpen_light_lens_flare_red"] = loadfx("vfx/s4/level/subpen/mp_subpen_light_lens_flare_red.vfx");
  level._effect["mp_subpen_water_drip_02_interior"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_02_interior.vfx");
  level._effect["mp_subpen_water_drip_03_interior"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_03_interior.vfx");
  level._effect["mp_subpen_water_drip_04_interior"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_04_interior.vfx");
  level._effect["mp_subpen_water_drip_05_interior"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_05_interior.vfx");
  level._effect["mp_subpen_fog_lingering_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_fog_lingering_02.vfx");
  level._effect["mp_subpen_fog_lingering_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_fog_lingering_01.vfx");
  level._effect["mp_subpen_spark_burst_line_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_spark_burst_line_01.vfx");
  level._effect["mp_subpen_water_drip_splash_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_splash_02.vfx");
  level._effect["mp_subpen_water_drip_splash_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_splash_01.vfx");
  level._effect["mp_subpen_water_drip_05"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_05.vfx");
  level._effect["mp_subpen_spark_burst_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_spark_burst_02.vfx");
  level._effect["mp_subpen_water_drip_04"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_04.vfx");
  level._effect["mp_subpen_steam_lrg_rise"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_lrg_rise.vfx");
  level._effect["mp_subpen_water_drip_03"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_03.vfx");
  level._effect["mp_subpen_steam_vent_03"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_vent_03.vfx");
  level._effect["mp_subpen_steam_vent_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_vent_02.vfx");
  level._effect["mp_subpen_water_drip_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_02.vfx");
  level._effect["mp_subpen_water_drip_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_water_drip_01.vfx");
  level._effect["mp_subpen_spark_burst_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_spark_burst_01.vfx");
  level._effect["mp_subpen_steam_pipe_03"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_pipe_03.vfx");
  level._effect["mp_subpen_steam_pipe_02"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_pipe_02.vfx");
  level._effect["mp_subpen_steam_pipe_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_pipe_01.vfx");
  level._effect["mp_subpen_steam_vent_01"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_vent_01.vfx");
  level._effect["vfx_mp_subpen_sunflare"] = loadfx("vfx/s4/sunflares/vfx_mp_subpen_sunflare.vfx");
  level._effect["mp_subpen_steam_vent_02_mvp"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_vent_02_mvp.vfx");
  level._effect["mp_subpen_steam_pipe_01_mvp"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_pipe_01_mvp.vfx");
  level._effect["mp_subpen_steam_lrg_rise_mvp"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_lrg_rise_mvp.vfx");
  level._effect["mp_subpen_steam_pipe_03_mvp"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_pipe_03_mvp.vfx");
  level._effect["mp_subpen_steam_pipe_02_mvp"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_pipe_02_mvp.vfx");
  level._effect["mp_subpen_steam_vent_03_mvp"] = loadfx("vfx/s4/level/subpen/mp_subpen_steam_vent_03_mvp.vfx");
}