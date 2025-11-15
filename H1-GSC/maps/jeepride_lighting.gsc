/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\jeepride_lighting.gsc
********************************/

main() {
  init_level_lighting_flags();
  level.cheat_invert_override = "_bright";
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread play_flickering_light();
}

play_flickering_light() {
  thread maps\_lighting::model_flicker_preset("flicker_1", 0, 1, 30, undefined, undefined, 0.005, 0.5, 0.005, 0.05, undefined, undefined, 1500);
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("jeepride", 0);
  level.player maps\_utility::set_light_set_player("jeepride");
  level.player setclutforplayer("clut_jeepride", 0.0);
  setsaveddvar("fx_cast_shadow", 0);
}