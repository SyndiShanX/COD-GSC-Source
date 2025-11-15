/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3001.gsc
***************************************/

main(var_00, var_01, var_02) {
  scripts\sp\vehicle_build::func_31C5("droppod", var_00, var_01, var_02);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_31A3(1500);
  scripts\sp\vehicle_build::build_ace(::func_F57A, ::func_F5FA);
  scripts\sp\vehicle_build::func_31C4("axis");
  func_0BBB::func_D623(var_00);
}

#using_animtree("c6");

func_F57A() {
  var_00 = [];

  for(var_01 = 0; var_01 < 4; var_1++) {
    var_0[var_01] = spawnStruct();
    var_0[var_01].func_10220 = "tag_origin";
  }

  var_0[0].func_92CC = % vh_red_droppod_exit_idle_c6_01;
  var_0[1].func_92CC = % vh_red_droppod_exit_idle_c6_02;
  var_0[2].func_92CC = % vh_red_droppod_exit_idle_c6_03;
  var_0[3].func_92CC = % vh_red_droppod_exit_idle_c6_04;
  var_0[0].botclearscriptgoal = % vh_red_droppod_exit_c6_01;
  var_0[1].botclearscriptgoal = % vh_red_droppod_exit_c6_02;
  var_0[2].botclearscriptgoal = % vh_red_droppod_exit_c6_03;
  var_0[3].botclearscriptgoal = % vh_red_droppod_exit_c6_04;
  return var_00;
}

func_F5FA(var_00) {
  return var_00;
}

init_location() {
  thread func_0BBB::func_D629();
}