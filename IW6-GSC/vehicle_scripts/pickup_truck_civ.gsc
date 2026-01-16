/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\pickup_truck_civ.gsc
************************************************/

main(var_0, var_1, var_2) {
  build_truck(var_0, var_1, var_2);
}

#using_animtree("vehicles");

build_truck(var_0, var_1, var_2) {
  maps\_vehicle::build_template("truck", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_drive( % technical_driving_idle_forward, % technical_driving_idle_backward, 10);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_light(var_2, "headlight_truck_left", "tag_headlight_left", "fx/misc/car_headlight_truck_L", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_right", "tag_headlight_right", "fx/misc/car_headlight_truck_R", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_right", "tag_brakelight_right", "fx/misc/car_taillight_truck_R", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_left", "tag_brakelight_left", "fx/misc/car_taillight_truck_L", "headlights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_right", "tag_brakelight_right", "fx/misc/car_brakelight_truck_R", "brakelights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_left", "tag_brakelight_left", "fx/misc/car_brakelight_truck_L", "brakelights");
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getinanim = % door_pickup_driver_climb_in;
  var_0[1].vehicle_getinanim = % door_pickup_passenger_climb_in;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "tag_driver";
  var_0[0].idle = % yb_car_idle_driver_b;
  var_0[0].death = % yb_car_idle_driver_b;
  var_0[1].sittag = "tag_passenger";
  var_0[1].idle = % uaz_passenger_idle_drive;
  var_0[1].death = % uaz_passenger_idle_drive;
  return var_0;
}