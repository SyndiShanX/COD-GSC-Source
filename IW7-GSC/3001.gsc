/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3001.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::func_31C5("droppod", var_0, var_1, var_2);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_31A3(1500);
  scripts\sp\vehicle_build::build_ace(::func_F57A, ::func_F5FA);
  scripts\sp\vehicle_build::func_31C4("axis");
  func_0BBB::func_D623(var_0);
}

#using_animtree("c6");

func_F57A() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1].var_10220 = "tag_origin";
  }

  var_0[0].var_92CC = % vh_red_droppod_exit_idle_c6_01;
  var_0[1].var_92CC = % vh_red_droppod_exit_idle_c6_02;
  var_0[2].var_92CC = % vh_red_droppod_exit_idle_c6_03;
  var_0[3].var_92CC = % vh_red_droppod_exit_idle_c6_04;
  var_0[0].botclearscriptgoal = % vh_red_droppod_exit_c6_01;
  var_0[1].botclearscriptgoal = % vh_red_droppod_exit_c6_02;
  var_0[2].botclearscriptgoal = % vh_red_droppod_exit_c6_03;
  var_0[3].botclearscriptgoal = % vh_red_droppod_exit_c6_04;
  return var_0;
}

func_F5FA(var_0) {
  return var_0;
}

init_location() {
  thread func_0BBB::func_D629();
}