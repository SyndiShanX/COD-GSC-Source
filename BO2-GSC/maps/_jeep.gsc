/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_jeep.gsc
**************************************/

#include maps\_vehicle;

main() {
  if(self.vehicletype == "jeep_ultimate")
    build_aianims(::setanims, ::set_vehicle_anims_ultimate);
  else
    build_aianims(::setanims, ::set_vehicle_anims);

  build_unload_groups(::unload_groups);
}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("vehicles");

set_vehicle_anims_ultimate(positions) {
  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[0].vehicle_getoutanim_clear = 0;
  positions[1].vehicle_getoutanim_clear = 0;
  positions[0].vehicle_getinanim = % v_jeep_driver_door_open;
  positions[1].vehicle_getinanim = % v_jeep_passenger_door_open;
  positions[0].vehicle_getoutanim = % v_jeep_driver_door_open;
  positions[1].vehicle_getoutanim = % v_jeep_passenger_door_open;
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];

  for(i = 0; i < 4; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_passenger2";
  positions[3].sittag = "tag_passenger3";
  positions[0].idle = % crew_jeep1_driver_drive_idle;
  positions[1].idle = % crew_jeep1_passenger1_drive_idle;
  positions[2].idle = % crew_jeep1_passenger2_drive_idle;
  positions[3].idle = % crew_jeep1_passenger3_drive_idle;
  positions[0].idle_combat = % crew_jeep1_driver_drive_under_fire;
  positions[1].idle_combat = % crew_jeep1_passenger1_drive_under_fire;
  positions[2].idle_combat = % crew_jeep1_passenger2_drive_under_fire;
  positions[3].idle_combat = % crew_jeep1_passenger3_drive_under_fire;
  positions[0].death_shot = % crew_jeep1_driver_death_shot;
  positions[1].death_shot = % crew_jeep1_passenger1_death_shot;
  positions[2].death_shot = % crew_jeep1_passenger2_death_shot;
  positions[3].death_shot = % crew_jeep1_passenger3_death_shot;
  positions[0].death_fire = % crew_jeep1_driver_death_fire;
  positions[1].death_fire = % crew_jeep1_passenger1_death_fire;
  positions[2].death_fire = % crew_jeep1_passenger2_death_fire;
  positions[3].death_fire = % crew_jeep1_passenger3_death_fire;
  positions[0].getout = % crew_jeep1_driver_climbout;
  positions[1].getout = % crew_jeep1_passenger1_climbout;
  positions[2].getout = % crew_jeep1_passenger2_climbout;
  positions[3].getout = % crew_jeep1_passenger3_climbout;
  positions[0].getin = % crew_jeep1_driver_climbin;
  positions[1].getin = % crew_jeep1_passenger1_climbin;
  positions[2].getin = % crew_jeep1_passenger2_climbin;
  positions[3].getin = % crew_jeep1_passenger3_climbin;
  positions[0].start = % crew_jeep1_driver_start;
  positions[1].start = % crew_jeep1_passenger1_start;
  positions[2].start = % crew_jeep1_passenger2_start;
  positions[3].start = % crew_jeep1_passenger3_start;
  positions[0].stop = % crew_jeep1_driver_stop;
  positions[1].stop = % crew_jeep1_passenger1_stop;
  positions[2].stop = % crew_jeep1_passenger2_stop;
  positions[3].stop = % crew_jeep1_passenger3_stop;
  positions[0].turn_left_light = % crew_jeep1_driver_turn_left_light;
  positions[1].turn_left_light = % crew_jeep1_passenger1_turn_left_light;
  positions[2].turn_left_light = % crew_jeep1_passenger2_turn_left_light;
  positions[3].turn_left_light = % crew_jeep1_passenger3_turn_left_light;
  positions[0].turn_left_heavy = % crew_jeep1_driver_turn_left_heavy;
  positions[1].turn_left_heavy = % crew_jeep1_passenger1_turn_left_heavy;
  positions[2].turn_left_heavy = % crew_jeep1_passenger2_turn_left_heavy;
  positions[3].turn_left_heavy = % crew_jeep1_passenger3_turn_left_heavy;
  positions[0].turn_right_light = % crew_jeep1_driver_turn_right_light;
  positions[1].turn_right_light = % crew_jeep1_passenger1_turn_right_light;
  positions[2].turn_right_light = % crew_jeep1_passenger2_turn_right_light;
  positions[3].turn_right_light = % crew_jeep1_passenger3_turn_right_light;
  positions[0].turn_right_heavy = % crew_jeep1_driver_turn_right_heavy;
  positions[1].turn_right_heavy = % crew_jeep1_passenger1_turn_right_heavy;
  positions[2].turn_right_heavy = % crew_jeep1_passenger2_turn_right_heavy;
  positions[3].turn_right_heavy = % crew_jeep1_passenger3_turn_right_heavy;
  positions[0].move_to_driver = % crew_jeep1_passenger_to_driver;
  positions[1].move_to_driver = % crew_jeep1_passenger_to_driver;
  positions[2].move_to_driver = % crew_jeep1_passenger_to_driver;
  positions[3].move_to_driver = % crew_jeep1_passenger_to_driver;
  positions[0].getout_fast = % crew_jeep1_driver_climbout_fast;
  positions[1].getout_fast = % crew_jeep1_passenger1_climbout_fast;
  positions[2].getout_fast = % crew_jeep1_passenger2_climbout_fast;
  positions[3].getout_fast = % crew_jeep1_passenger3_climbout_fast;
  positions[0].getin_fast = % crew_jeep1_driver_climbin_fast;
  positions[1].getin_fast = % crew_jeep1_passenger1_climbin_fast;
  positions[2].getin_fast = % crew_jeep1_passenger2_climbin_fast;
  positions[3].getin_fast = % crew_jeep1_passenger3_climbin_fast;
  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["all"] = [];
  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}