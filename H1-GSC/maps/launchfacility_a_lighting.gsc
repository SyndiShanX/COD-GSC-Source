/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\launchfacility_a_lighting.gsc
**********************************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread handle_rappel_down_vent();
  level.nightvisionlightset = "launchfacility_a_nightvision";
  visionsetnight("launchfacility_a_nightvision");
}

init_level_lighting_flags() {
  common_scripts\utility::flag_init("rappel_down_vent_started");
}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("launchfacility_a", 5);
  level.player maps\_utility::set_light_set_player("launchfacility_a");
  level.player setclutforplayer("clut_launchfacility_a", 0.0);
  setsaveddvar("r_specularcolorscale", "1.2");
}

handle_rappel_down_vent() {
  common_scripts\utility::flag_wait("rappel_down_vent_started");
  maps\_utility::set_vision_set("launchfacility_a_rappel", 15);
}