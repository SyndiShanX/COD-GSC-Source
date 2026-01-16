/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_jetwing.gsc
**************************************/

#include maps\_vehicle;
#include common_scripts\utility;

init() {
  vehicle_add_main_callback("plane_jetwing", ::main);
  vehicle_add_main_callback("plane_jetwing_ai", ::main);
  vehicle_add_main_callback("plane_jetwing_haiti", ::main);
  vehicle_add_main_callback("plane_jetwing_haiti_ai", ::main);
  vehicle_add_main_callback("plane_jetwing_haiti_ai_hero", ::main);
}

main() {
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
}

#using_animtree("vehicles");

set_vehicle_anims(positions) {
  positions[0].vehicle_idle = % v_crew_jetpack_flight_idle;
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];

  for(i = 0; i < 1; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[0].idle = % ai_crew_jetpack_flight_idle;
  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["driver"] = [];
  unload_groups["driver"][unload_groups["driver"].size] = 0;
  unload_groups["default"] = unload_groups["driver"];
  return unload_groups;
}