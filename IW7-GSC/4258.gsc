/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4258.gsc
**************************************/

_id_1A5D(var_0, var_1) {
  _id_DE96();
  _id_1A5F(var_0, var_1);
}

_id_1A5E() {
  _id_0EFB::_id_FDBB("aircontrol");
}

#using_animtree("generic_human");

_id_DE96() {
  level._id_EC85["generic"]["shipcrib_air_control_loop_A_01"][0] = % shipcrib_air_control_loop_a_01;
  level._id_EC85["generic"]["shipcrib_air_control_loop_A_02"][0] = % shipcrib_air_control_loop_a_02;
  level._id_EC85["generic"]["shipcrib_air_control_loop_B_01"][0] = % shipcrib_air_control_loop_b_01;
  level._id_EC85["generic"]["shipcrib_air_control_loop_B_02"][0] = % shipcrib_air_control_loop_b_02;
}

_id_1A5F(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_0) {
    var_2 = scripts\engine\utility::getStruct("aircontrol1a", "targetname");
    var_3 = _id_0EF8::_id_FDFC("spawner_interior", "aircontrol1a", "cheap");
    var_2 thread scripts\sp\anim::_id_1ECC(var_3, "shipcrib_air_control_loop_A_01");
    var_2 = scripts\engine\utility::getStruct("aircontrol1b", "targetname");
    var_3 = _id_0EF8::_id_FDFC("spawner_interior", "aircontrol1b", "cheap");
    var_2 thread scripts\sp\anim::_id_1ECC(var_3, "shipcrib_air_control_loop_A_02");
  }

  if(var_1) {
    var_2 = scripts\engine\utility::getStruct("aircontrol2a", "targetname");
    var_3 = _id_0EF8::_id_FDFC("spawner_interior", "aircontrol2a", "cheap");
    var_2 thread scripts\sp\anim::_id_1ECC(var_3, "shipcrib_air_control_loop_B_01");
    var_2 = scripts\engine\utility::getStruct("aircontrol2b", "targetname");
    var_3 = _id_0EF8::_id_FDFC("spawner_interior", "aircontrol2b", "cheap");
    var_2 thread scripts\sp\anim::_id_1ECC(var_3, "shipcrib_air_control_loop_B_02");
  }
}