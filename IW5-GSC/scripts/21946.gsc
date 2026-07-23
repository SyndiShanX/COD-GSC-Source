/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\21946.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("humvee", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  build_humvee_anims();
  maps\_vehicle::build_deathmodel("vehicle_jeep_rubicon", "vehicle_hummer_opentop_destroyed");
  var_3 = [];
  var_3["vehicle_jeep_rubicon"] = "explosions/vehicle_explosion_hummer_nodoors";
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_deathfx("fire/firelp_med_pm", "TAG_CAB_FIRE", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx(var_3[var_0], "tag_deathfx", "car_explode");
  maps\_vehicle::build_drive(%rubicon_driving_idle_forward, %rubicon_driving_idle_backward, 10);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  var_4 = maps\_vehicle::get_light_model(var_0, var_2);
  maps\_vehicle::build_light(var_4, "headlight_truck_left", "tag_headlight_left", "maps/payback/payback_headlights_l", "headlights");
  maps\_vehicle::build_light(var_4, "headlight_truck_right", "tag_headlight_right", "maps/payback/payback_headlights_r", "headlights");
  maps\_vehicle::build_light(var_4, "taillight_truck_right", "tag_brakelight_right", "misc/car_taillight_truck_R_pb", "headlights");
  maps\_vehicle::build_light(var_4, "taillight_truck_left", "tag_brakelight_left", "misc/car_taillight_truck_L_pb", "headlights");
  maps\_vehicle::build_light(var_4, "brakelight_truck_right", "tag_brakelight_right", "misc/car_brakelight_truck_R_pb", "brakelights");
  maps\_vehicle::build_light(var_4, "brakelight_truck_left", "tag_brakelight_left", "misc/car_brakelight_truck_L_pb", "brakelights");
}

init_local() {
  if(issubstr(self.vehicletype, "physics")) {
    var_0 = [];
    var_0["idle"] = % humvee_antennas_idle_movement;
    var_0["rot_l"] = % humvee_antenna_l_rotate_360;
    var_0["rot_r"] = % humvee_antenna_r_rotate_360;
    thread maps\_vehicle::humvee_antenna_animates(var_0);
  }
}

build_humvee_anims() {
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0].sittag = "tag_driver";
  var_0[0].getin = % rubicon_mount_driver;
  var_0[0].getout = % rubicon_dismount_driver;
  var_0[0].idle[0] = % rubicon_idle_driver;
  var_0[0].idle[1] = % rubicon_duck_driver;
  var_0[0].idleoccurrence[0] = 1000;
  var_0[0].idleoccurrence[1] = 100;
  var_0[0].death = % rubicon_fallout_driver;
  var_0[1].sittag = "tag_passenger";
  var_0[1].getin = % rubicon_mount_passenger;
  var_0[1].getout = % rubicon_dismount_passenger;
  var_0[1].idle[0] = % rubicon_idle_passenger;
  var_0[1].idle[1] = % rubicon_duck_passenger;
  var_0[1].idleoccurrence[0] = 1000;
  var_0[1].idleoccurrence[1] = 100;
  var_0[1].death = % rubicon_fallout_passenger;
  var_0[2].sittag = "tag_guy0";
  var_0[2].getin = % rubicon_mount_backl;
  var_0[2].getout = % rubicon_dismount_backl;
  var_0[2].idle[0] = % rubicon_idle_backl;
  var_0[2].idle[1] = % rubicon_duck_backl;
  var_0[2].idleoccurrence[0] = 1000;
  var_0[2].idleoccurrence[1] = 100;
  var_0[2].death = % rubicon_fallout_backl;
  var_0[3].sittag = "tag_guy1";
  var_0[3].getin = % rubicon_mount_backr;
  var_0[3].getout = % rubicon_dismount_backr;
  var_0[3].idle[0] = % rubicon_idle_backr;
  var_0[3].idle[1] = % rubicon_duck_backr;
  var_0[3].idleoccurrence[0] = 1000;
  var_0[3].idleoccurrence[1] = 100;
  var_0[3].death = % rubicon_fallout_backr;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["passengers"] = [];
  var_0["passenger_and_gunner"] = [];
  var_0["passenger_and_driver"] = [];
  var_0["all"] = [];
  var_1 = "passenger_and_gunner";
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 4;
  var_1 = "passenger_and_driver";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_1 = "passengers";
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}