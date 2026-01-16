/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend_fx.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\createfx\frontend_fx;

precache_util_fx() {
}

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_missing_effect"] = loadfx("misc/fx_missing_fx");
  level._effect["fx_smoke_plume_lg_slow_blk"] = loadfx("env/smoke/fx_smoke_plume_lg_slow_blk");
  level._effect["fx_com_flourescent_glow_cool"] = loadfx("maps/command_center/fx_com_flourescent_glow_cool");
  level._effect["fx_com_tv_glow_blue"] = loadfx("maps/command_center/fx_com_tv_glow_blue");
  level._effect["fx_com_tv_glow_green"] = loadfx("maps/command_center/fx_com_tv_glow_green");
  level._effect["fx_com_tv_glow_yellow"] = loadfx("maps/command_center/fx_com_tv_glow_yellow");
  level._effect["fx_com_tv_glow_yellow_sml"] = loadfx("maps/command_center/fx_com_tv_glow_yellow_sml");
  level._effect["fx_com_light_glow_white"] = loadfx("maps/command_center/fx_com_light_glow_white");
  level._effect["fx_lf_commandcenter_light1"] = loadfx("lens_flares/fx_lf_commandcenter_light1");
  level._effect["fx_lf_frontend_light1"] = loadfx("lens_flares/fx_lf_frontend_light1");
  level._effect["fx_com_glow_sml_blue"] = loadfx("maps/command_center/fx_com_glow_sml_blue");
  level._effect["fx_com_hologram_glow"] = loadfx("maps/command_center/fx_com_hologram_glow");
  level._effect["fx_com_button_glows_1"] = loadfx("maps/command_center/fx_com_button_glows_1");
  level._effect["fx_com_button_glows_2"] = loadfx("maps/command_center/fx_com_button_glows_2");
  level._effect["fx_com_button_glows_3"] = loadfx("maps/command_center/fx_com_button_glows_3");
  level._effect["fx_com_button_glows_4"] = loadfx("maps/command_center/fx_com_button_glows_4");
  level._effect["fx_com_button_glows_5"] = loadfx("maps/command_center/fx_com_button_glows_5");
  level._effect["fx_com_button_glows_6"] = loadfx("maps/command_center/fx_com_button_glows_6");
  level._effect["fx_com_button_glows_7"] = loadfx("maps/command_center/fx_com_button_glows_7");
  level._effect["fx_com_button_glows_8"] = loadfx("maps/command_center/fx_com_button_glows_8");
  level._effect["fx_com_hologram_static"] = loadfx("maps/command_center/fx_com_hologram_static");
  level._effect["fx_com_hologram_model_godray"] = loadfx("maps/command_center/fx_com_hologram_model_godray");
  level._effect["fx_com_hologram_globe_godray"] = loadfx("maps/command_center/fx_com_hologram_globe_godray");
  level._effect["globe_city_marker"] = loadfx("maps/command_center/fx_com_hologram_indicator");
  level._effect["globe_satellite_fx"] = loadfx("maps/command_center/fx_com_hologram_sat_blip");
  level._effect["fx_com_hologram_widget_globe"] = loadfx("maps/command_center/fx_com_hologram_widget_globe");
  level._effect["fx_com_hologram_widget_bust"] = loadfx("maps/command_center/fx_com_hologram_widget_bust");
  level._effect["fx_com_hologram_widget_base"] = loadfx("maps/command_center/fx_com_hologram_widget_base");
  level._effect["fx_com_hologram_widget_drone"] = loadfx("maps/command_center/fx_com_hologram_widget_drone");
  level._effect["fx_com_hologram_widget_amb"] = loadfx("maps/command_center/fx_com_hologram_widget_amb");
  level._effect["fx_com_frontend_spotlight"] = loadfx("maps/command_center/fx_com_frontend_spotlight");
  level._effect["fx_com_vtol_clouds"] = loadfx("maps/command_center/fx_com_vtol_clouds");
  level._effect["fx_com_vtol_green_glow"] = loadfx("maps/command_center/fx_com_vtol_green_glow");
  level._effect["fx_com_vtol_red_glow"] = loadfx("maps/command_center/fx_com_vtol_red_glow");
  level._effect["fx_briefing_objective"] = loadfx("maps/command_center/fx_com_hologram_objective_glow");
  level._effect["fx_dockside_base"] = loadfx("maps/command_center/fx_com_hologram_static_base");
  level._effect["fx_dockside_missile"] = loadfx("maps/command_center/fx_com_hologram_static_missile");
  level._effect["fx_dockside_beam"] = loadfx("maps/command_center/fx_com_hologram_static_beam");
  level._effect["fx_dockside_ship"] = loadfx("maps/command_center/fx_com_hologram_static_ship");
  level._effect["hologram_widget_fx"] = loadfx("maps/command_center/fx_com_hologram_widget_models");
  level._effect["data_glove_glow"] = loadfx("light/fx_com_data_glove_glow");
}

main() {
  precache_util_fx();
  precache_createfx_fx();
  precache_scripted_fx();
  maps\createfx\frontend_fx::main();
}