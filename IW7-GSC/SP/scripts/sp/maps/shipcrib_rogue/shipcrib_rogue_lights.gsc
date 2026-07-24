/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_lights.gsc
********************************************************************/

main() {
  thread _id_7471();
  setsaveddvar("sm_spotDistCull", "350");
}

_id_11233() {
  setsaveddvar("sm_suncascadesizemultiplier1", "4");
}

_id_2FC9() {
  var_0 = getEntArray("lgt_bridge_opsmap", "script_noteworthy");
}

_id_C6A9() {
  if(!isDefined(self)) {
    return;
  }
  thread scripts\sp\lights::_id_AB83(1, 0.5);
  level waittill("jump_started");
  thread scripts\sp\lights::_id_AB83(0.5, 0.5);
  wait 4;
  scripts\sp\lights::_id_3C57((0.87, 0.15, 0.1), 0.5);
  wait 2;
  scripts\sp\lights::_id_3C57((0.87, 0.915, 0.91), 0.5);
  wait 7;
  scripts\sp\lights::_id_3C57((0.92, 0.315, 0.21), 0.25);
  wait 10;
  scripts\sp\lights::_id_3C57((0.87, 0.915, 0.91), 0.25);
  level waittill("ftl_finished");
  scripts\sp\lights::_id_3C57((0.87, 0.925, 0.81), 0.5);
  thread scripts\sp\lights::_id_AB83(1, 0.5);
}

_id_74A7() {
  level waittill("ftl_drives_opening");
  scripts\sp\lights::_id_AB83(6, 0.5);
  level waittill("jump_started");
  scripts\sp\lights::_id_3C57((0.97, 0.93, 0.93), 1);
  thread scripts\sp\lights::_id_AB83(10, 2);
  level waittill("ftl_drives_closing");
  scripts\sp\lights::_id_AB83(0, 0.5);
  self _meth_8300(100);
}

_id_74AA() {
  level waittill("ftl_drives_opening");
  visionsetalternate(1, 4);
  level waittill("jump_started");
  visionsetalternate(2, 1);
  wait 3;
  visionsetalternate(3, 0.5);
  wait 1;
  visionsetalternate(2, 0.75);
  level waittill("ftl_stop");
  visionsetalternate(4, 7);
  wait 3;
  visionsetalternate(5, 3);
  wait 4;
  visionsetalternate(4, 4);
}

_id_74A5() {
  var_0 = 700;
  var_1 = 100;
  var_2 = getEntArray("lgt_ftl_drives_01", "script_noteworthy");
  var_3 = getEntArray("lgt_ftl_drives_02", "script_noteworthy");
  var_4 = getEntArray("lgt_ftl_drives_03", "script_noteworthy");
  var_5 = getEntArray("lgt_ftl_drives_04", "script_noteworthy");
  var_6 = getEntArray("lgt_ftl_drives_05", "script_noteworthy");
  var_7 = getEntArray("lgt_ftl_drives_06", "script_noteworthy");
  var_8 = getEntArray("lgt_ftl_drives_07", "script_noteworthy");
  var_9 = getEntArray("lgt_ftl_drives_08", "script_noteworthy");
  var_10 = getEntArray("lgt_ftl_drives_09", "script_noteworthy");
  var_11 = getEnt("lgt_ftl_blue", "script_noteworthy");
  level waittill("ftl_drives_opening");
  wait 1;
  scripts\engine\utility::array_thread(var_2, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(4, scripts\engine\utility::array_thread, var_3, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(8, scripts\engine\utility::array_thread, var_4, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(12, scripts\engine\utility::array_thread, var_5, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(16, scripts\engine\utility::array_thread, var_6, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(20, scripts\engine\utility::array_thread, var_7, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(22, scripts\engine\utility::array_thread, var_8, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(24, scripts\engine\utility::array_thread, var_9, scripts\sp\lights::_id_AB83, var_0, 3.5);
  scripts\engine\utility::delaythread(26, scripts\engine\utility::array_thread, var_10, scripts\sp\lights::_id_AB83, var_0, 3.5);
  wait 20;
  var_11 thread scripts\sp\lights::_id_AB83(var_1, 7.5);
  level waittill("ftl_drives_closing");
  scripts\engine\utility::array_thread(var_10, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(2, scripts\engine\utility::array_thread, var_9, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(4, scripts\engine\utility::array_thread, var_8, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(6, scripts\engine\utility::array_thread, var_7, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(8, scripts\engine\utility::array_thread, var_6, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(12, scripts\engine\utility::array_thread, var_5, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(16, scripts\engine\utility::array_thread, var_4, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(20, scripts\engine\utility::array_thread, var_3, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(24, scripts\engine\utility::array_thread, var_2, scripts\sp\lights::_id_AB83, 0, 3.5);
  wait 6;
  var_11 thread scripts\sp\lights::_id_AB83(0, 7.5);
}

_id_7471() {
  var_0 = getmapsunangles();
  var_1 = getmapsunlight();
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_3 = 55;
  var_4 = vectorNormalize(var_2) * var_3;
  var_5 = vectorNormalize(var_2) * 10;
  var_6 = getEntArray("lgt_ftl_monitors", "script_noteworthy");
  var_7 = getEntArray("lgt_ftl_monitors_02", "script_noteworthy");
  var_8 = getEntArray("lgt_bridge_dark", "script_noteworthy");
  var_9 = getEntArray("lgt_bridge_klaxon", "script_noteworthy");
  level waittill("jump_started");

  foreach(var_11 in var_8)
  var_11 setlightintensity(0);

  foreach(var_11 in var_6)
  var_11 setlightintensity(0);

  foreach(var_11 in var_7)
  var_11 setlightintensity(0);

  wait 2;
  level waittill("ftl_finished");
  wait 1;
  wait 2;

  foreach(var_11 in var_7) {
    var_11 _meth_82FC((1, 0.92549, 0.74902));
    var_11 thread scripts\sp\lights::_id_AB83(3, 0.5);
  }

  wait 3;

  foreach(var_11 in var_6) {
    var_11 _meth_82FC((0.768627, 0.945098, 1));
    var_11 thread scripts\sp\lights::_id_AB83(1.25, 0.25);
  }

  wait 1;

  foreach(var_11 in var_8)
  var_11 thread scripts\sp\lights::_id_AB83(1.25, 0.25);
}

_id_226C() {}

_id_A244() {
  level waittill("start_klaxon");
  var_0 = 0;
  var_1 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_1, ::_id_55F7);

  if(var_0) {
    var_0 = 0;
    var_1 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
    scripts\engine\utility::array_thread(var_1, ::_id_55F7);
  } else {
    var_0 = 1;
    var_1 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
    scripts\engine\utility::array_thread(var_1, ::_id_626E);
  }
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