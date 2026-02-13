/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2447.gsc
*************************************************/

_id_A42A(var_0, var_1) {
  if(!isDefined(level._id_11034)) {
    level._id_11034 = [];
    level._id_11033 = [];
  }

  level._id_11034[var_0] = var_1;
  level._id_11033[var_0] = 0;
  level thread _id_A42C(var_0);
}

_id_A42C(var_0) {
  level endon("game_end");
  level notify("kill_network_choke_thread" + var_0);
  level endon("kill_network_choke_thread" + var_0);

  for(;;) {
    waitframe();
    waitframe();
    level._id_11033[var_0] = 0;
  }
}

_id_A42B(var_0) {
  return level._id_11033[var_0] < level._id_11034[var_0];
}

_id_A429(var_0, var_1, var_2, var_3, var_4) {
  while(!_id_A42B(var_0)) {
    waitframe();
  }

  level._id_11033[var_0]++;

  if(isDefined(var_4)) {
    return [[var_1]](var_2, var_3, var_4);
  }

  if(isDefined(var_3)) {
    return [[var_1]](var_2, var_3);
  }

  if(isDefined(var_2)) {
    return [[var_1]](var_2);
  }

  return [[var_1]]();
}

_id_A42D(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return 1;
}

_id_A42E(var_0, var_1) {
  if(!isDefined(level._id_11034) || !isDefined(level._id_11034[var_0])) {
    _id_A42A(var_0, var_1);
  }
}

_id_0C6C(var_0, var_1) {
  return spawn(var_0, var_1);
}

_id_A430(var_0, var_1, var_2, var_3) {
  _id_A42E(var_0, var_1);
  return _id_A429(var_0, ::_id_0C6C, var_2, var_3);
}

_id_0C6B(var_0, var_1, var_2) {
  if(_id_A42D(var_1)) {
    playFXOnTag(var_0, var_1, var_2);
  }
}

_id_A42F(var_0, var_1, var_2, var_3, var_4) {
  _id_A42E(var_0, var_1);
  _id_A429(var_0, ::_id_0C6B, var_2, var_3, var_4);
}