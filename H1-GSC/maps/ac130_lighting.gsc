/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\ac130_lighting.gsc
********************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("ac130", 0);
  level.player maps\_utility::set_light_set_player("ac130");
  level.player setclutforplayer("clut_ac130", 0.0);
}