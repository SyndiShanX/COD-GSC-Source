/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_jackal.gsc
**************************************************/

_id_A086() {
  _id_FA05("jackal_arena_start");
}

_id_A085() {
  setglobalsoundcontext("wind", "none", 3.0);
}

_id_A084() {
  thread scripts\sp\maps\titan\titan_code::_id_D250(1);
  level._id_740B = 0.01;
  scripts\engine\utility::flag_wait("jackal_mount_complete");
  level notify("player_in_jackal");

  if(getdvarint("titan_newjackal") && !getdvarint("jackal_video_capture")) {
    _id_0BDC::_id_A226();
    scripts\engine\utility::waitframe();
    scripts\sp\utility::_id_BF95();
  }

  setmusicstate("mx_428_titan_trans");
  thread _id_C6FD();
  thread scripts\sp\maps\titan\titan_code::_id_D24F();
  setglobalsoundcontext("wind", "none", 3.0);
  thread _id_A3A1();
  level._id_D127 _id_0BDC::_id_F48D("default_landed");
  level._id_D127 _id_0BDC::_id_F5BD("vtol");
  level._id_11A70 = _id_0BDC::_id_7BBA();

  if(!isDefined(level._id_EAD6))
    scripts\sp\maps\titan\titan_code::_id_10732();

  level._id_EAD6 thread _id_73C2();
}

_id_C6FD() {
  var_0 = scripts\engine\utility::getStruct("calvary_start_player", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = level._id_D127.origin;
  var_1.angles = level._id_D127.angles;
  level._id_D127 linkTo(var_1, "tag_origin");
  _id_0BDC::_id_D164(var_1);
  _id_0BDC::_id_A14D(1);
  var_2 = 5;
  var_1 rotateTo(var_0.angles, var_2, var_2 * 0.5, var_2 * 0.5);
  wait(var_2);
  var_2 = 7;
  var_1 moveTo(level._id_D127.origin + (0, 0, 900), var_2, var_2 * 0.5, var_2 * 0.5);
  wait(var_2);
  level._id_D127 unlink();
  var_1 delete();
}

_id_A3A1() {
  _id_0BDC::_id_137DA();
  var_0 = level.player _meth_8473();
  var_1 = "j_mainroot_ship";
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_methane_drops"), var_0, var_1);
  level.player scripts\sp\utility::_id_65E8("flag_player_has_jackal");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_jackal_methane_drops"), var_0, var_1);
  _id_0BDC::_id_137D6();
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_methane_drops"), var_0, var_1);
}

_id_73C2() {
  self endon("stop_friendly_wingman");
  _id_0BDC::_id_137D6();

  if(scripts\engine\utility::player_is_in_jackal()) {
    var_0 = level.player _meth_8473();
    _id_0BDC::_id_1994(var_0, (2500, -800, 400), 300, 0.08, 15000, 1.0);
    self waittill("near_goal");
    return;
  }
}

_id_FA05(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0 + "_player", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_0 + "_salter", "targetname");
  var_3 = _id_0BDC::_id_1079F("player_rooftop_jackal");
  _id_0BDC::_id_10CD1(var_3, var_1, "hover");
  scripts\sp\maps\titan\titan_code::_id_10732();
  level._id_EAD6 vehicle_teleport(var_2.origin, var_2.angles);
}