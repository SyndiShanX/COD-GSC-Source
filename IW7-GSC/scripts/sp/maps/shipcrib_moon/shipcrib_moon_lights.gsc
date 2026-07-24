/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_moon\shipcrib_moon_lights.gsc
******************************************************************/

main() {
  scripts\engine\utility::flag_init("lgt_trigger_return_elevator");
  scripts\engine\utility::flag_init("lgt_trigger_return_elevator_exit");
  scripts\engine\utility::flag_init("lgt_trigger_leave_elevator");
  scripts\engine\utility::flag_init("lgt_trigger_leave_elevator_exit");
  scripts\engine\utility::flag_init("lgt_bridge_hallway_mid");
}

init_lighting() {
  thread _id_3030();
  thread _id_304A();
  thread _id_A244();
  thread _id_8A7E();
  thread _id_E439();
  thread _id_2215();
}

_id_2215() {
  scripts\engine\utility::flag_wait("lgt_trigger_leave_elevator");
  _id_0EE4::_id_E389("armory_hallway_01");
  scripts\engine\utility::flag_wait("lgt_trigger_leave_elevator_exit");
  _id_0EE4::_id_E388("armory_hallway_01");
}

_id_3030() {
  var_0 = getEnt("lgt_bridge_hallway_warm", "script_noteworthy");
  var_1 = getEnt("lgt_bridge_hallway_red1", "script_noteworthy");
  var_2 = getEnt("lgt_bridge_hallway_red2", "script_noteworthy");
  var_3 = getEnt("lgt_bridge_hallway_door1", "script_noteworthy");
  var_4 = getEnt("lgt_bridge_hallway_door2", "script_noteworthy");
  var_5 = getEntArray("lgt_bridge_hallway_approach", "script_noteworthy");
  var_6 = [var_1, var_2, var_4];
  var_7 = scripts\engine\utility::array_add(var_6, var_3);

  foreach(var_9 in var_7) {
    var_9._id_99E6 = scripts\sp\lights::_id_95A8([var_9 _meth_8134()]);
  }

  var_11 = _id_0EEB::_id_7976("return");
  scripts\engine\utility::array_call(var_6, ::setlightintensity, 0);
  var_0 setlightintensity(0);
  scripts\engine\utility::flag_wait("player_entered_bridgehallway");
  scripts\engine\utility::array_call(var_11.lights, ::_meth_8300, 80);
  scripts\engine\utility::flag_wait("player_start_lift");
  var_3 thread scripts\sp\lights::_id_AB83(0, 0.2);
  var_4 thread scripts\sp\lights::_id_AB83(var_4._id_99E6, 0.2);
  var_0 thread scripts\sp\lights::_id_AB83(6, 2);
  scripts\engine\utility::array_thread(var_5, scripts\sp\lights::_id_AB83, 0, 0.5);
  var_1 thread scripts\sp\lights::_id_AB83(var_1._id_99E6, 0.5);
  scripts\engine\utility::flag_wait("lift_complete");
  var_0 scripts\sp\lights::_id_AB83(15, 0.5);
  wait 7;
  var_1 thread scripts\sp\lights::_id_AB83(0, 0.5);
  var_2 thread scripts\sp\lights::_id_AB83(var_2._id_99E6, 0.5);
}

_id_304A() {
  var_0 = getEnt("lgt_bridge_hallway_warm", "script_noteworthy");
  var_1 = getEnt("lgt_bridge_hallway_red1", "script_noteworthy");
  var_2 = getEnt("lgt_bridge_hallway_red2", "script_noteworthy");
  var_3 = getEnt("lgt_bridge_hallway_door1", "script_noteworthy");
  var_4 = getEnt("lgt_bridge_hallway_door2", "script_noteworthy");
  var_5 = getEntArray("lgt_bridge_hallway_approach", "script_noteworthy");
  var_6 = [var_1, var_2, var_3, var_4, var_0];
  var_7 = scripts\engine\utility::array_combine(var_6, var_5);
  level scripts\engine\utility::waittill_any("start_bridge_scene", "bridge_intro_bink_done");
  scripts\engine\utility::array_call(var_7, ::setlightintensity, 0);
}

_id_10A5E() {
  setsaveddvar("sm_spotDistCull", 450);
}

_id_A244() {
  level waittill("start_klaxon");
  _id_0EE4::_id_E389("decompression_claxon");
  level waittill("kill_return_klaxon");
  _id_0EE4::_id_E388("decompression_claxon");
}

_id_8A7E() {
  level waittill("start_klaxon");
  _id_0EE4::_id_E389("hangar_claxon");
  _id_0EE4::_id_E389("return_deck_claxon");
  level waittill("kill_return_hangar_claxons");
  _id_0EE4::_id_E388("hangar_claxon");
  _id_0EE4::_id_E388("return_deck_claxon");
}

_id_2213() {
  _id_0EE4::_id_E389("hangar_claxon");
  _id_0EE4::_id_E389("return_deck_claxon");
  level waittill("kill_klaxon_armory");
  _id_0EE4::_id_E388("hangar_claxon");
  _id_0EE4::_id_E388("return_deck_claxon");
}

_id_E439() {
  scripts\engine\utility::flag_wait("lgt_trigger_return_elevator");
  _id_0EE4::_id_E389("return_elevator_01");
  scripts\engine\utility::flag_wait("lgt_trigger_return_elevator_exit");
  _id_0EE4::_id_E388("return_elevator_01");
}

_id_620F(var_0, var_1) {
  var_2 = var_0;

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  scripts\sp\lights::_id_AB83(10, 0.5);
  thread _id_E707(var_0, var_1);
}

_id_5548() {
  thread _id_E707();
  scripts\sp\lights::_id_AB83(0.0, 0.5);
}

_id_E707(var_0, var_1) {
  self endon("kill_klaxon");
  var_2 = var_0;

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  wait(var_1);

  for(;;) {
    self rotateYaw(90, var_2);
    scripts\engine\utility::waitframe();
  }
}

_id_A245() {
  var_0 = getEntArray("jackal_middoor_lights", "script_noteworthy");

  foreach(var_2 in var_0) {}

  level waittill("light_jackal_middoor");
  scripts\engine\utility::array_thread(var_0, scripts\sp\lights::_id_AB83, 8, 0.5);
  wait 15;
  scripts\engine\utility::array_thread(var_0, scripts\sp\lights::_id_AB83, 0, 0.5);
}