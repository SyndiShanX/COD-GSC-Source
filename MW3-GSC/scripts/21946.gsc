/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\21946.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("humvee", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  _id_5143();
  maps\_vehicle::_id_2ABE("vehicle_jeep_rubicon", "vehicle_hummer_opentop_destroyed");
  var_3 = [];
  var_3["vehicle_jeep_rubicon"] = "explosions/vehicle_explosion_hummer_nodoors";
  maps\_vehicle::_id_2ACD(::_id_3E58);
  maps\_vehicle::_id_2A02("fire/firelp_med_pm", "TAG_CAB_FIRE", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::_id_2A02(var_3[var_0], "tag_deathfx", "car_explode");
  maps\_vehicle::_id_2AC1( % rubicon_driving_idle_forward, % rubicon_driving_idle_backward, 10);
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
  var_4 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_4, "headlight_truck_left", "tag_headlight_left", "maps/payback/payback_headlights_l", "headlights");
  maps\_vehicle::_id_2AAD(var_4, "headlight_truck_right", "tag_headlight_right", "maps/payback/payback_headlights_r", "headlights");
  maps\_vehicle::_id_2AAD(var_4, "taillight_truck_right", "tag_brakelight_right", "misc/car_taillight_truck_R_pb", "headlights");
  maps\_vehicle::_id_2AAD(var_4, "taillight_truck_left", "tag_brakelight_left", "misc/car_taillight_truck_L_pb", "headlights");
  maps\_vehicle::_id_2AAD(var_4, "brakelight_truck_right", "tag_brakelight_right", "misc/car_brakelight_truck_R_pb", "brakelights");
  maps\_vehicle::_id_2AAD(var_4, "brakelight_truck_left", "tag_brakelight_left", "misc/car_brakelight_truck_L_pb", "brakelights");
}

_id_2B1D() {
  if(issubstr(self.vehicletype, "physics")) {
    var_0 = [];
    var_0["idle"] = % humvee_antennas_idle_movement;
    var_0["rot_l"] = % humvee_antenna_l_rotate_360;
    var_0["rot_r"] = % humvee_antenna_r_rotate_360;
    thread maps\_vehicle::_id_2B01(var_0);
  }
}

_id_5143() {
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
}

_id_3A9C(var_0) {
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();

  }
  var_0[0]._id_24F2 = "tag_driver";
  var_0[0]._id_2519 = % rubicon_mount_driver;
  var_0[0]._id_257C = % rubicon_dismount_driver;
  var_0[0]._id_0F59[0] = % rubicon_idle_driver;
  var_0[0]._id_0F59[1] = % rubicon_duck_driver;
  var_0[0]._id_254D[0] = 1000;
  var_0[0]._id_254D[1] = 100;
  var_0[0]._id_1048 = % rubicon_fallout_driver;
  var_0[1]._id_24F2 = "tag_passenger";
  var_0[1]._id_2519 = % rubicon_mount_passenger;
  var_0[1]._id_257C = % rubicon_dismount_passenger;
  var_0[1]._id_0F59[0] = % rubicon_idle_passenger;
  var_0[1]._id_0F59[1] = % rubicon_duck_passenger;
  var_0[1]._id_254D[0] = 1000;
  var_0[1]._id_254D[1] = 100;
  var_0[1]._id_1048 = % rubicon_fallout_passenger;
  var_0[2]._id_24F2 = "tag_guy0";
  var_0[2]._id_2519 = % rubicon_mount_backl;
  var_0[2]._id_257C = % rubicon_dismount_backl;
  var_0[2]._id_0F59[0] = % rubicon_idle_backl;
  var_0[2]._id_0F59[1] = % rubicon_duck_backl;
  var_0[2]._id_254D[0] = 1000;
  var_0[2]._id_254D[1] = 100;
  var_0[2]._id_1048 = % rubicon_fallout_backl;
  var_0[3]._id_24F2 = "tag_guy1";
  var_0[3]._id_2519 = % rubicon_mount_backr;
  var_0[3]._id_257C = % rubicon_dismount_backr;
  var_0[3]._id_0F59[0] = % rubicon_idle_backr;
  var_0[3]._id_0F59[1] = % rubicon_duck_backr;
  var_0[3]._id_254D[0] = 1000;
  var_0[3]._id_254D[1] = 100;
  var_0[3]._id_1048 = % rubicon_fallout_backr;
  return var_0;
}

_id_3E58() {
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