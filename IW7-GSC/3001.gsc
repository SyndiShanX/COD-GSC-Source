/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3001.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("droppod", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  scripts\sp\vehicle_build::_id_31A3(1500);
  scripts\sp\vehicle_build::build_ace(::_id_F57A, ::_id_F5FA);
  scripts\sp\vehicle_build::_id_31C4("axis");
  _id_0BBB::_id_D623(var_0);
}

#using_animtree("c6");

_id_F57A() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1]._id_10220 = "tag_origin";
  }

  var_0[0]._id_92CC = % vh_red_droppod_exit_idle_c6_01;
  var_0[1]._id_92CC = % vh_red_droppod_exit_idle_c6_02;
  var_0[2]._id_92CC = % vh_red_droppod_exit_idle_c6_03;
  var_0[3]._id_92CC = % vh_red_droppod_exit_idle_c6_04;
  var_0[0]._id_8028 = % vh_red_droppod_exit_c6_01;
  var_0[1]._id_8028 = % vh_red_droppod_exit_c6_02;
  var_0[2]._id_8028 = % vh_red_droppod_exit_c6_03;
  var_0[3]._id_8028 = % vh_red_droppod_exit_c6_04;
  return var_0;
}

_id_F5FA(var_0) {
  return var_0;
}

init_location() {
  thread _id_0BBB::_id_D629();
}