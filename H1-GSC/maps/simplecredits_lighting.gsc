/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\simplecredits_lighting.gsc
*******************************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("simplecredits", 0);
  level.player lightsetforplayer("simplecredits");
  level.player setclutforplayer("clut_simplecredits", 0.0);
}