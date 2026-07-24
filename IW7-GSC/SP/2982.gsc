/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2982.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("atv", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  scripts\sp\vehicle_build::_id_31C6();
  scripts\sp\vehicle_build::_id_31A3(999, 500, 1500);
  scripts\sp\vehicle_build::_id_31B3((0, 0, 53), 256, 300, 20, 0);
  var_3 = var_0;

  if(var_0 == "veh_mil_lnd_ca_4x4_atv_drive")
    var_3 = "veh_mil_lnd_ca_4x4_atv_dst";

  scripts\sp\vehicle_build::_id_3186(var_0, var_3);
  scripts\sp\vehicle_build::_id_3184("vfx/iw7/core/vehicle/cars/vfx_veh_explosion_civ.vfx", undefined, "car_explode");
  scripts\sp\vehicle_build::_id_31A4(var_2, "headlight_L", "tag_light_front_left", "vfx/misc/car_headlight_truck_l.vfx", "running", 0.05);
  scripts\sp\vehicle_build::_id_31A4(var_2, "headlight_R", "tag_light_front_right", "vfx/misc/car_headlight_truck_r.vfx", "running", 0.05);
  scripts\sp\vehicle_build::_id_31A4(var_2, "taillight_L", "tag_light_back_left", "vfx/misc/car_taillight_truck_l.vfx", "running", 0.05);
  scripts\sp\vehicle_build::_id_31A4(var_2, "taillight_R", "tag_light_back_right", "vfx/misc/car_taillight_truck_r.vfx", "running", 0.05);

  if(issubstr(var_2, "turret")) {} else
    scripts\sp\vehicle_build::build_ace(::_id_F57A, ::_id_F5FA);

  scripts\sp\vehicle_build::_id_318B(%veh_un_firetruck_01_driving_forward, %veh_un_firetruck_01_driving_backward, 10);
  scripts\sp\vehicle_build::_id_31C4("axis");
}

init_location() {
  thread scripts\sp\vehicle::_id_1320C("running");
}

#using_animtree("generic_human");

_id_F57A() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1]._id_10220 = "tag_detach";
    var_0[var_1]._id_69DF = % death_explosion_up10;
  }

  var_0[0]._id_92CC = % vh_org_4x4_atv_idle_front_guy1;
  var_0[1]._id_92CC = % vh_org_4x4_atv_idle_front_guy2;
  var_0[2]._id_92CC = % vh_org_4x4_atv_idle_rear_guy3;
  var_0[3]._id_92CC = % vh_org_4x4_atv_idle_rear_guy4;
  var_0[0]._id_8028 = % vh_org_4x4_atv_unload_front_guy1;
  var_0[1]._id_8028 = % vh_org_4x4_atv_unload_front_guy2;
  var_0[2]._id_8028 = % vh_org_4x4_atv_unload_rear_guy3;
  var_0[3]._id_8028 = % vh_org_4x4_atv_unload_rear_guy4;
  var_0[0].death = % vh_org_4x4_atv_death_front_guy1;
  var_0[1].death = % vh_org_4x4_atv_death_front_guy2;
  var_0[2].death = % vh_org_4x4_atv_death_front_guy3;
  var_0[3].death = % vh_org_4x4_atv_death_front_guy4;
  var_0[0]._id_4E14 = 1;
  var_0[1]._id_4E14 = 1;
  var_0[2]._id_4E14 = 1;
  var_0[3]._id_4E14 = 1;
  return var_0;
}

_id_F57B() {
  var_0 = _id_F57A();
  var_0[4] = spawnStruct();
  var_0[4]._id_10220 = "tag_cover";
  var_0[4]._id_92CC = % vh_org_4x4_atv_idle_gunner_guy5;
  var_0[4]._id_8028 = % vh_org_4x4_atv_unload_gunner_guy5;
  var_0[4].death = % vh_org_4x4_atv_death_gunner_guy5;
  return var_0;
}

_id_F5FA(var_0) {
  return var_0;
}

_id_12BBD() {
  var_0 = [];
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "all_but_driver";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}