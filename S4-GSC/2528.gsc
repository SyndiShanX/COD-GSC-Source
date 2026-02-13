/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2528.gsc
*************************************************/

_id_1009D(var_0, var_1, var_2) {
  var_3 = _id_10099(var_0, 1);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = var_0._id_1031E;
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  _func_03BF("dlog_event_vehicle_spawn", ["vehicle_spawn_id", var_3._id_7C8C, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "matchtime_ms", scripts\cp_mp\utility\game_utility::_id_6DEB(), "spawn_type", var_1, "vehicle_type", var_2]);
}

_id_10098(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_1)) {
    return;
  }
  var_4 = _id_10099(var_0);

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  var_1 _meth_870F("dlog_event_player_vehicle_exit", ["vehicle_spawn_id", var_4._id_7C8C, "exit_pos_x", var_0.origin[0], "exit_pos_y", var_0.origin[1], "exit_pos_z", var_0.origin[2], "exit_seat_id", var_2, "exit_matchtime_ms", scripts\cp_mp\utility\game_utility::_id_6DEB(), "exit_type", var_3]);
}

_id_10097(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_1)) {
    return;
  }
  var_4 = _id_10099(var_0);

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  var_1 _meth_870F("dlog_event_player_vehicle_enter", ["vehicle_spawn_id", var_4._id_7C8C, "enter_pos_x", var_0.origin[0], "enter_pos_y", var_0.origin[1], "enter_pos_z", var_0.origin[2], "enter_seat_id", var_2, "enter_matchtime_ms", scripts\cp_mp\utility\game_utility::_id_6DEB(), "enter_type", var_3]);
}

_id_1009C() {
  var_0 = spawnStruct();
  var_0._id_F950 = 0;
  level.vehicle._id_4BC7 = var_0;
}

_id_1009A() {
  return level.vehicle._id_4BC7;
}

_id_10099(var_0, var_1) {
  var_2 = _id_1009A();
  var_3 = var_0._id_4BC7;

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_0._id_4BC7 = var_3;
    var_3._id_7C8C = var_2._id_F950;
    var_2._id_F950++;
  }

  return var_3;
}

_id_1009B(var_0) {
  return var_0._id_4BC8;
}