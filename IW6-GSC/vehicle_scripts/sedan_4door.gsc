/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\sedan_4door.gsc
*******************************************/

main(var_0, var_1, var_2) {
  build_car(var_0, var_1, var_2);
}

#using_animtree("vehicles");

build_car(var_0, var_1, var_2) {
  maps\_vehicle::build_template("coupe", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_drive(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
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