/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_titan\shipcrib_titan_lights.gsc
********************************************************************/

main() {
  setsaveddvar("sm_spotDistCull", "550");
}

_id_11233() {
  setsaveddvar("sm_suncascadesizemultiplier1", "4");
}

bridge_hallway() {
  scripts\engine\utility::flag_init("return_elevator_floor_bridge_deck");
  scripts\engine\utility::flag_wait("return_elevator_floor_bridge_deck");
  var_0 = _id_0EEB::_id_7976("return");
  var_1 = getdvarfloat("sm_spotdistcull");
  wait 1;

  foreach(var_3 in var_0.lights) {
    if(var_3 _meth_8136() > 80)
      var_3 scripts\sp\lights::_id_AB83(0, 2);
  }

  wait 2;
}

_id_C6A9() {
  thread scripts\sp\lights::_id_AB83(0.5, 0.5);
  level waittill("jump_started");
  thread scripts\sp\lights::_id_AB83(0.5, 0.5);
  wait 4;
  scripts\sp\lights::_id_3C57((0.87, 0.15, 0.1), 0.5);
  wait 2;
  scripts\sp\lights::_id_3C57((0.87, 0.915, 0.91), 0.5);
  thread scripts\sp\lights::_id_AB83(1, 2);
  wait 7;
  scripts\sp\lights::_id_3C57((0.92, 0.315, 0.21), 0.25);
  wait 10;
  scripts\sp\lights::_id_3C57((0.87, 0.915, 0.91), 0.25);
  level waittill("ftl_finished");
  scripts\sp\lights::_id_3C57((0.87, 0.925, 0.81), 0.5);
  thread scripts\sp\lights::_id_AB83(1, 0.5);
}

_id_74AA() {
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_wait("lgt_flag_bridge_armory");
  visionsetalternate(1, 1);
  resetsunlight();
  resetsundirection();
}

_id_7471() {
  var_0 = getmapsunlight();
  var_1 = 1.5;
  var_2 = vectorNormalize((1, 0.8, 0.576)) * var_1;
  var_3 = vectorNormalize((1, 0.8, 0.576)) * 0.75;
  var_4 = vectorNormalize((0.341176, 0.521569, 0.992157)) * 0.4;
  var_5 = getEntArray("lgt_ftl_monitors", "script_noteworthy");
  var_6 = getEntArray("lgt_ftl_monitors_02", "script_noteworthy");
  var_7 = getEntArray("lgt_bridge_dark", "script_noteworthy");
  var_8 = getEntArray("lgt_bridge_klaxon", "script_noteworthy");
  var_9 = getEnt("lgt_bridge_opsmap", "script_noteworthy");

  if(isDefined(var_9))
    var_9 thread _id_C6A9();

  level waittill("jump_started");
}

_id_A244() {
  level waittill("start_klaxon");
  _id_0EE4::_id_E389("decompression_claxon");
  level waittill("kill_return_klaxon");
  _id_0EE4::_id_E388("decompression_claxon");
}

_id_626E() {
  var_0 = randomfloatrange(0, 0.2);
  wait(var_0);
  scripts\sp\lights::_id_AB83(10, 0.5);
  thread _id_E72C();
}

_id_55F7() {
  thread _id_E72C();
  scripts\sp\lights::_id_AB83(0.0, 0.5);
}

_id_E72C() {
  self endon("kill_klaxon");

  for(;;) {
    self rotateYaw(90, 0.5);
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