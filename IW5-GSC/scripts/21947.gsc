/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\21947.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("uaz", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2AD0("vehicle_uaz_winter_destructible", "vehicle_uaz_winter");
  maps\_vehicle::_id_2AD0("vehicle_uaz_open_destructible", "vehicle_uaz_open");
  maps\_vehicle::_id_2AC8(0);
  maps\_vehicle::_id_2ABE("vehicle_uaz_light", "vehicle_uaz_light_dsr");
  maps\_vehicle::_id_2ABE("vehicle_uaz_winter", "vehicle_uaz_winter_destroy");
  maps\_vehicle::_id_2ABE("vehicle_uaz_fabric", "vehicle_uaz_fabric_dsr");
  maps\_vehicle::_id_2ABE("vehicle_uaz_hardtop", "vehicle_uaz_hardtop_dsr");
  maps\_vehicle::_id_2ABE("vehicle_uaz_open", "vehicle_uaz_open_dsr");
  maps\_vehicle::_id_2ABE("vehicle_uaz_hardtop_thermal", "vehicle_uaz_hardtop_thermal");
  maps\_vehicle::_id_2ABE("vehicle_uaz_open_for_ride");
  maps\_vehicle::_id_2A02("explosions/small_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::_id_29F3((0, 0, 32), 300, 200, 100, 0);
  maps\_vehicle::_id_2AC1(%uaz_driving_idle_forward, %uaz_driving_idle_backward, 10);
  maps\_vehicle::_id_29F8(1, 1.6, 500);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(2500, 2400, 2600);
  maps\_vehicle::_id_2AC6("axis");
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
  maps\_vehicle::_id_2ACD(::_id_3E58);
}

_id_2B1D() {
  self._id_29D5 = 1;

  if(!isDefined(self._id_24FB)) {
    self._id_24FB = 0;
  }
}

_id_3A9C(var_0) {
  var_0[0]._id_2523 = % uaz_driver_exit_into_stand_door;
  var_0[1]._id_2523 = % uaz_passenger_exit_into_stand_door;
  var_0[2]._id_2523 = % uaz_rear_driver_exit_into_stand_door;
  var_0[3]._id_2523 = % uaz_passenger2_exit_into_stand_door;
  var_0[0]._id_257F = 0;
  var_0[1]._id_257F = 0;
  var_0[2]._id_257F = 0;
  var_0[3]._id_257F = 0;
  var_0[0]._id_2522 = % uaz_driver_enter_from_huntedrun_door;
  var_0[1]._id_2522 = % uaz_passenger_enter_from_huntedrun_door;
  var_0[2]._id_2522 = % uaz_rear_driver_enter_from_huntedrun_door;
  var_0[3]._id_2522 = % uaz_passenger2_enter_from_huntedrun_door;
  var_0[0]._id_2581 = "uaz_door_open";
  var_0[1]._id_2581 = "uaz_door_open";
  var_0[2]._id_2581 = "uaz_door_open";
  var_0[3]._id_2581 = "uaz_door_open";
  var_0[0]._id_2527 = "uaz_door_open";
  var_0[1]._id_2527 = "uaz_door_open";
  var_0[2]._id_2527 = "uaz_door_open";
  var_0[3]._id_2527 = "uaz_door_open";
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0]._id_24F2 = "tag_driver";
  var_0[1]._id_24F2 = "tag_passenger";
  var_0[2]._id_24F2 = "tag_guy0";
  var_0[3]._id_24F2 = "tag_guy1";
  var_0[4]._id_24F2 = "tag_guy2";
  var_0[5]._id_24F2 = "tag_guy3";
  var_0[0]._id_0F59 = % uaz_driver_idle_drive;
  var_0[1]._id_0F59 = % uaz_passenger_idle_drive;
  var_0[2]._id_0F59 = % uaz_rear_driver_idle;
  var_0[3]._id_0F59 = % uaz_passenger2_idle;
  var_0[4]._id_0F59 = % uaz_rear_driver_idle;
  var_0[5]._id_0F59 = % uaz_passenger2_idle;
  var_0[0]._id_257C = % uaz_driver_exit_into_stand;
  var_0[1]._id_257C = % uaz_passenger_exit_into_stand;
  var_0[2]._id_257C = % uaz_rear_driver_exit_into_stand;
  var_0[3]._id_257C = % uaz_passenger2_exit_into_stand;
  var_0[0]._id_2519 = % uaz_driver_enter_from_huntedrun;
  var_0[1]._id_2519 = % uaz_passenger_enter_from_huntedrun;
  var_0[2]._id_2519 = % uaz_rear_driver_enter_from_huntedrun;
  var_0[3]._id_2519 = % uaz_passenger2_enter_from_huntedrun;
  var_0[0]._id_1048 = % uaz_driver_death;
  var_0[1]._id_1048 = % uaz_rear_driver_death;
  var_0[2]._id_1048 = % uaz_rear_driver_death;
  var_0[3]._id_1048 = % uaz_rear_driver_death;
  var_0[0]._id_24F1 = 1;
  var_0[1]._id_24F1 = 1;
  var_0[2]._id_24F1 = 1;
  var_0[3]._id_24F1 = 1;
  return var_0;
}

_id_3E58() {
  var_0 = [];
  var_0["front_passenger"] = [];
  var_0["all"] = [];
  var_1 = "front_passenger";
  var_0[var_1][var_0[var_1].size] = 1;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0["default"] = var_0["all"];
  return var_0;
}