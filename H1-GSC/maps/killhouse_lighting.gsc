/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\killhouse_lighting.gsc
***************************************/

main() {
  init_level_lighting_flags();
  level.cheat_invert_override = "_bright";
  common_scripts\utility::flag_init("in_firerange_lighting_zone1");
  common_scripts\utility::flag_init("in_firerange_lighting_zone2");
  common_scripts\utility::flag_init("in_hangar3_lighting_zoneTower");
  common_scripts\utility::flag_init("in_hangar3_lighting_zoneHangarFloor");
  common_scripts\utility::flag_init("in_hangar3_lighting_zoneShipTopDeck");
  common_scripts\utility::flag_init("in_hangar3_lighting_zoneShipInterior1");
  common_scripts\utility::flag_init("in_hangar3_lighting_zoneShipInterior2");
  level.cheat_highcontrast_override = "_night";
  thread setup_dof_presets();
  thread set_level_lighting_values();
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::set_vision_set("killhouse_interior", 0.0);
  maps\_utility::vision_set_fog_changes("killhouse_interior", 0);
  level.player maps\_utility::set_light_set_player("killhouse_interior");
  level.player setclutforplayer("clut_killhouse", 0.0);
  setsaveddvar("fx_cast_shadow", 0);
}