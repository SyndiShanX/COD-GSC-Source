/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_truck.gsc
**************************************/

#include maps\_vehicle;

main(model, type) {
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];

  for(i = 0; i < 10; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy1";
  positions[3].sittag = "tag_guy2";
  positions[4].sittag = "tag_guy3";
  positions[5].sittag = "tag_guy4";
  positions[6].sittag = "tag_guy5";
  positions[7].sittag = "tag_guy6";
  positions[8].sittag = "tag_guy7";
  positions[9].sittag = "tag_guy8";
  positions[0].getout = % crew_truck_driver_climbout;
  positions[1].getout = % crew_truck_passenger_climbout;
  positions[2].getout = % crew_truck_guy1_climbout;
  positions[3].getout = % crew_truck_guy2_climbout;
  positions[4].getout = % crew_truck_guy3_climbout;
  positions[5].getout = % crew_truck_guy4_climbout;
  positions[6].getout = % crew_truck_guy5_climbout;
  positions[7].getout = % crew_truck_guy6_climbout;
  positions[8].getout = % crew_truck_guy7_climbout;
  positions[9].getout = % crew_truck_guy8_climbout;
  positions[0].idle = % crew_truck_driver_sit_idle;
  positions[1].idle = % crew_truck_passenger_sit_idle;
  positions[2].idle = % crew_truck_guy1_sit_idle;
  positions[3].idle = % crew_truck_guy2_sit_idle;
  positions[4].idle = % crew_truck_guy3_sit_idle;
  positions[5].idle = % crew_truck_guy4_sit_idle;
  positions[6].idle = % crew_truck_guy5_sit_idle;
  positions[7].idle = % crew_truck_guy6_sit_idle;
  positions[8].idle = % crew_truck_guy7_sit_idle;
  positions[9].idle = % crew_truck_guy8_sit_idle;
  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["all"] = [];
  unload_groups["passengers"] = [];
  unload_groups["rear_passengers"] = [];
  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 1;
  group = "rear_passengers";
  unload_groups["default"] = unload_groups["passengers"];
  return unload_groups;
}