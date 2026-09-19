/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_selfiebooth.gsc
**************************************************/

_id_525D() {
  var_0 = common_scripts\utility::_id_46B5("selfie_player_pos", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_2 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  level._id_83C4 = spawnStruct();
  level._id_83C4._id_7300 = var_0;
  level._id_83C4._id_1EA0 = var_2;
  setdvarifuninitialized("scr_vlobby_selfie_correction_y", 32.0);
  setdvarifuninitialized("scr_vlobby_selfie_collision_z", 10.0);
  level thread _id_7F6F();
}

_id_7F6F() {
  while(!isDefined(level.player))
    waitframe();

  level.player _id_90A1();
  wait 5;

  for(;;) {
    waitframe();

    if(_func_2A4() || !_func_2A3() || getdvarint("664")) {
      continue;
    }
    if(!_id_8B81()) {
      continue;
    }
    _id_95CD();
  }
}

_id_90A1() {
  while(!isDefined(level.player._id_9042) || !isDefined(level.player._id_9042._id_267E))
    waitframe();

  var_0 = level._id_83C4._id_7300.origin;
  var_1 = getdvarfloat("scr_vlobby_selfie_collision_z", 0.0);
  var_2 = getdvarfloat("scr_vlobby_selfie_correction_y", 0.0);
  var_3 = (0, var_2, var_1);
  var_0 = var_0 + var_3;
  var_4 = level._id_83C4._id_7300.angles;
  var_5 = maps\mp\agents\_agent_utility::_id_44EE("selfie_clone");
  var_5._id_565F = 1;
  var_5 _meth_838F(var_0, var_4, undefined, undefined, undefined, undefined, 1);
  var_6 = level.player _meth_8299();
  _func_2BA(var_5, var_6);
  var_5 _meth_83D6(1);
  var_5 _meth_83D5("vlobby_animclass");
  var_5 _meth_83D7("lobby_idle", "selfie_01", 1.0);
  var_5 _meth_84C7(level.player._id_9042._id_267E);
  var_5 _meth_8055(level._id_83C4._id_7300);
  level._id_83C4._id_242C = var_5;
  self._id_83C3 = var_5;
}

_id_8B81() {
  if(!isDefined(level.player))
    return 0;

  if(!isDefined(level.player._id_9042) || !isDefined(level.player._id_9042._id_267E))
    return 0;

  if(level.player _meth_84FC())
    return 0;

  return 1;
}

_id_95CD() {
  if(!isDefined(level._id_83C4._id_242C)) {
    return;
  }
  if(!isDefined(level.player)) {
    return;
  }
  if(!isDefined(level.player._id_9042)) {
    return;
  }
  if(!isDefined(level.player._id_9042._id_267E)) {
    return;
  }
  var_0 = level._id_83C4._id_242C.origin;
  var_1 = level._id_83C4._id_242C getEye();
  level._id_83C4._id_242C _meth_84C7(level.player._id_9042._id_267E);
  waitframe();

  if(!level.player _meth_8535(level._id_83C4._id_1EA0.origin, var_0, var_1[2] - var_0[2], 0, 0)) {
    return;
  }
  while(isDefined(level.player) && !level.player _meth_8500())
    waitframe();
}