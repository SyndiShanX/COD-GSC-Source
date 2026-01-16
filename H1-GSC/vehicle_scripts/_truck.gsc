/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_truck.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("truck", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_pickup_roobars", "vehicle_pickup_technical_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_pickup_4door", "vehicle_pickup_technical_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_opfor_truck", "vehicle_pickup_technical_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_pickup_technical", "vehicle_pickup_technical_destroyed");
  maps\_vehicle::build_deathfx("fx\explosions\small_vehicle_explosion", undefined, "car_explode", undefined, undefined, undefined, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_small_pm_a", "tag_fx_tire_right_r", "smallfire", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_med_pm", "tag_fx_cab", "smallfire", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_small_pm_a", "tag_engine_left", "smallfire", undefined, undefined, 1, 0);
  maps\_vehicle::build_drive( % technical_driving_idle_forward, % technical_driving_idle_backward, 10);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_light(var_2, "headlight_truck_left", "tag_headlight_left", "fx\misc\car_headlight_truck_L", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_right", "tag_headlight_right", "fx\misc\car_headlight_truck_R", "headlights");
  maps\_vehicle::build_light(var_2, "parkinglight_truck_left_f", "tag_parkinglight_left_f", "fx\misc\car_parkinglight_truck_LF", "headlights");
  maps\_vehicle::build_light(var_2, "parkinglight_truck_right_f", "tag_parkinglight_right_f", "fx\misc\car_parkinglight_truck_RF", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_right", "tag_taillight_right", "fx\misc\car_taillight_truck_R", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_left", "tag_taillight_left", "fx\misc\car_taillight_truck_L", "headlights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_right", "tag_taillight_right", "fx\misc\car_brakelight_truck_R", "brakelights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_left", "tag_taillight_left", "fx\misc\car_brakelight_truck_L", "brakelights");
}

init_local() {}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % door_pickup_driver_climb_out;
  var_0[1].vehicle_getoutanim = % door_pickup_passenger_climb_out;
  var_0[2].vehicle_getoutanim = % door_pickup_passenger_rr_climb_out;
  var_0[3].vehicle_getoutanim = % door_pickup_passenger_rl_climb_out;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getinanim = % door_pickup_driver_climb_in;
  var_0[1].vehicle_getinanim = % door_pickup_passenger_climb_in;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 4; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_guy1";
  var_0[3].sittag = "tag_guy0";
  var_0[0].idle = % technical_driver_idle;
  var_0[1].idle = % technical_passenger_idle;
  var_0[2].idle = % pickup_passenger_rr_idle;
  var_0[3].idle = % pickup_passenger_rl_idle;
  var_0[0].getout = % pickup_driver_climb_out;
  var_0[1].getout = % pickup_passenger_climb_out;
  var_0[2].getout = % pickup_passenger_rr_climb_out;
  var_0[3].getout = % pickup_passenger_rl_climb_out;
  var_0[0].getin = % pickup_driver_climb_in;
  var_0[1].getin = % pickup_passenger_climb_in;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["passengers"] = [];
  var_0["all"] = [];
  var_1 = "passengers";
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}