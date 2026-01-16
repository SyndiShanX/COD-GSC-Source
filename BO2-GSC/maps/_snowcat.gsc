/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_snowcat.gsc
**************************************/

#include maps\_vehicle;

main() {
  build_aianims(::setanims, ::set_vehicle_anims);
  self thread attach_snowcat_props();
}

attach_snowcat_props() {
  if(self.vehicletype == "tank_snowcat_plow")
    self attach("t5_veh_snowcat_plow", "tag_origin");
}

#using_animtree("vehicles");

set_vehicle_anims(positions) {
  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy1";
  positions[3].sittag = "tag_guy6";
  positions[4].sittag = "tag_guy3";
  positions[5].sittag = "tag_guy8";
  positions[6].sittag = "tag_guy5";
  positions[7].sittag = "tag_guy2";
  positions[8].sittag = "tag_guy7";
  positions[9].sittag = "tag_guy4";
  positions[0].vehicle_getoutanim_clear = 0;
  positions[1].vehicle_getoutanim_clear = 0;
  positions[0].vehicle_getinanim = % v_gaz63_driver_door_open;
  positions[1].vehicle_getinanim = % v_gaz63_passenger_door_open;
  positions[0].vehicle_getoutanim = % v_gaz63_driver_door_open;
  positions[1].vehicle_getoutanim = % v_gaz63_passenger_door_open;
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
  positions[3].sittag = "tag_guy6";
  positions[4].sittag = "tag_guy3";
  positions[5].sittag = "tag_guy8";
  positions[6].sittag = "tag_guy5";
  positions[7].sittag = "tag_guy2";
  positions[8].sittag = "tag_guy7";
  positions[9].sittag = "tag_guy4";
  positions[0].getin = % crew_truck_driver_climbin;
  positions[1].getin = % crew_truck_passenger_climbin;
  positions[2].getin = % crew_truck_guy1_climbin;
  positions[3].getin = % crew_truck_guy6_climbin;
  positions[4].getin = % crew_truck_guy3_climbin;
  positions[5].getin = % crew_truck_guy8_climbin;
  positions[6].getin = % crew_truck_guy5_climbin;
  positions[7].getin = % crew_truck_guy2_climbin;
  positions[8].getin = % crew_truck_guy7_climbin;
  positions[9].getin = % crew_truck_guy4_climbin;
  positions[0].idle = % crew_snowcat_driver_idle;
  positions[1].idle = % crew_gaz63_passenger_sit_idle;
  positions[2].idle = % crew_truck_guy1_sit_idle;
  positions[3].idle = % crew_truck_guy6_sit_idle;
  positions[4].idle = % crew_truck_guy3_sit_idle;
  positions[5].idle = % crew_truck_guy8_sit_idle;
  positions[6].idle = % crew_truck_guy5_sit_idle;
  positions[7].idle = % crew_truck_guy2_sit_idle;
  positions[8].idle = % crew_truck_guy7_sit_idle;
  positions[9].idle = % crew_truck_guy4_sit_idle;
  return positions;
}