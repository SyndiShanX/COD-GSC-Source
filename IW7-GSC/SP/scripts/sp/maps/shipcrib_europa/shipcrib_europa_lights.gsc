/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_europa\shipcrib_europa_lights.gsc
**********************************************************************/

main() {
  init_lighting();
}

init_lighting() {
  thread _id_A244();
}

_id_10A5E() {
  setsaveddvar("sm_spotdistcull", 950);
}

_id_11204() {
  var_0 = getDvar("sm_sunsamplesizenear", "0.25");
  setsaveddvar("sm_sunsamplesizenear", "0");
  level waittill("entering_bridge_scene");
  setsaveddvar("sm_suncascadesizemultiplier1", "3");
  setsaveddvar("sm_sunsamplesizenear", var_0);
  level scripts\engine\utility::waittill_any("armory_started", "lgt_E3_jackal");
  setsaveddvar("sm_sunsamplesizenear", "0");
  level waittill("launch_decompression_done");
  scripts\engine\utility::noself_delaycall(7, ::setsaveddvar, "sm_sunsamplesizenear", 0.7);
}

_id_798A(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE52)) {
      if(var_5._id_EE52 == var_2)
        return var_5;
    }
  }
}

_id_A24D() {
  var_0 = 0.15;
  wait 1;
  var_1 = getEntArray("lgt_jackal_decompression", "script_noteworthy");
  var_2 = getEntArray("lgt_jackal_decompression_fill", "script_noteworthy");
  var_3 = 0.3;
  level waittill("lgt_jackal_mounted");
  level waittill("lgt_jackal_launch_prep");
  scripts\engine\utility::delaythread(6.0, scripts\engine\utility::array_thread, var_1, scripts\sp\lights::_id_AB83, 0.0, 1.25);
  level waittill("launch_decompression_done");
  wait 2.5;
  visionsetnaked("shipcrib_jackal_launch", 3);
  wait 1.5;
  level notify("lgt_ntfy_launch_red_done");
  wait 4.7;
  visionsetnaked("", 1);
}

_id_4CCC() {
  self setscriptablepartstate("cycle", "yellow");
  wait 3;
  self setscriptablepartstate("cycle", "green");
  wait 10;
  self setscriptablepartstate("cycle", "hide");
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
  scripts\engine\utility::flag_wait("lgt_flag_bridge_armory");
  lerpsunangles((-23, -13, 0), (-15, -109, 0), 6);
  thread scripts\sp\utility::_id_111DA(var_2, var_3, 6);
}

_id_A244() {
  level waittill("start_klaxon");
  _id_0EE4::_id_E389("decompression_claxon");
  level waittill("kill_return_klaxon");
  _id_0EE4::_id_E388("decompression_claxon");
}

_id_620F(var_0, var_1) {
  var_2 = var_0;

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(!isDefined(var_1))
    var_1 = 0;

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

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(!isDefined(var_1))
    var_1 = 0;

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