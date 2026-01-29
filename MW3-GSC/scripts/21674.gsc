/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\21674.gsc
**************************************/

main(var_0, var_1, var_2) {
  _id_54A7(var_0, var_1, var_2, "weapon_m2_50cal_center", "50cal_turret_technical");
  _id_54A8();
  _id_54A9(var_2);
}

#using_animtree("vehicles");

_id_54A7(var_0, var_1, var_2, var_3, var_4) {
  maps\_vehicle::_id_2AC2("technical", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2A4A(var_4, "tag_50cal", var_3, undefined, "auto_ai", 0.5, 20, -14);
  maps\_vehicle::_id_2AC1( % technical_driving_idle_forward, % technical_driving_idle_backward, 10);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");
  maps\_vehicle::_id_2ACD(::_id_3E58);
  var_5 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_5, "headlight_truck_left", "tag_headlight_left", "misc/car_headlight_truck_L", "headlights");
  maps\_vehicle::_id_2AAD(var_5, "headlight_truck_right", "tag_headlight_right", "misc/car_headlight_truck_R", "headlights");
  maps\_vehicle::_id_2AAD(var_5, "parkinglight_truck_left_f", "tag_parkinglight_left_f", "misc/car_parkinglight_truck_LF", "headlights");
  maps\_vehicle::_id_2AAD(var_5, "parkinglight_truck_right_f", "tag_parkinglight_right_f", "misc/car_parkinglight_truck_RF", "headlights");
  maps\_vehicle::_id_2AAD(var_5, "taillight_truck_right", "tag_taillight_right", "misc/car_taillight_truck_R", "headlights");
  maps\_vehicle::_id_2AAD(var_5, "taillight_truck_left", "tag_taillight_left", "misc/car_taillight_truck_L", "headlights");
  maps\_vehicle::_id_2AAD(var_5, "brakelight_truck_right", "tag_taillight_right", "misc/car_brakelight_truck_R", "brakelights");
  maps\_vehicle::_id_2AAD(var_5, "brakelight_truck_left", "tag_taillight_left", "misc/car_brakelight_truck_L", "brakelights");
}

_id_54A8() {
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
}

_id_54A9(var_0) {
  maps\_vehicle::_id_2ABE("vehicle_pickup_technical", "vehicle_pickup_technical_destroyed", 3, var_0);
  maps\_vehicle::_id_2A02("fire/firelp_med_pm_nolight", "tag_fx_tank", "smallfire", undefined, undefined, 1, 0);
  maps\_vehicle::_id_2A02("explosions/ammo_cookoff", "tag_fx_bed", undefined, undefined, undefined, undefined, 0.5);
  maps\_vehicle::_id_2A02("explosions/Vehicle_Explosion_Pickuptruck", "tag_deathfx", "car_explode", undefined, undefined, undefined, 2.9);
  maps\_vehicle::_id_2A02("fire/firelp_small_pm_a", "tag_fx_tire_right_r", "smallfire", undefined, undefined, 1, 3);
  maps\_vehicle::_id_2A02("fire/firelp_med_pm_nolight", "tag_fx_cab", "fire_metal_medium", undefined, undefined, 1, 3.01);
  maps\_vehicle::_id_2A02("fire/firelp_small_pm_a", "tag_engine_left", "smallfire", undefined, undefined, 1, 3.01);
  maps\_vehicle::_id_2AEA(0.5, 3, 512, 700, "axis", "allies");
  maps\_vehicle::_id_2AEB(2.9);
  maps\_vehicle::_id_29F3((0, 0, 53), 512, 300, 20, 1, 2.9);
}

_id_3A9C(var_0) {
  return var_0;
}

_id_2B1D() {
  if(!isDefined(self._id_24FB)) {
    self._id_24FB = 1;

  }
  if(!isDefined(self._id_24F9)) {
    self._id_24F9 = 1;
  }
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_0[var_1] = spawnStruct();

  }
  var_0[0]._id_24F2 = "tag_driver";
  var_0[1]._id_24F2 = "tag_gunner";
  var_0[2]._id_24F2 = "tag_passenger";
  var_0[0]._id_0F59[0] = % technical_driver_idle;
  var_0[0]._id_0F59[1] = % technical_driver_duck;
  var_0[0]._id_254D[0] = 1000;
  var_0[0]._id_254D[1] = 100;
  var_0[0]._id_1048 = % technical_driver_fallout;
  var_0[2]._id_1048 = % technical_passenger_fallout;
  var_0[0]._id_2598 = 0.9;
  var_0[1]._id_2598 = 0.9;
  var_0[2]._id_2598 = 0.9;
  var_0[2]._id_0F59[0] = % technical_passenger_idle;
  var_0[2]._id_0F59[1] = % technical_passenger_duck;
  var_0[2]._id_254D[0] = 1000;
  var_0[2]._id_254D[1] = 100;
  var_0[0]._id_257C = % technical_driver_climb_out;
  var_0[2]._id_257C = % technical_passenger_climb_out;
  var_0[1].mgturret = 0;
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
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "passenger_and_driver";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "passengers";
  var_0[var_1][var_0[var_1].size] = 2;
  var_0["default"] = var_0["all"];
  return var_0;
}