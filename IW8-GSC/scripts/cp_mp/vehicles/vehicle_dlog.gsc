/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_dlog.gsc
***************************************************/

function vehicle_dlog_spawnevent(var_0, var_1, var_2) {
  var_3 = vehicle_dlog_getinstancedata(var_0, 1);

  if(!isDefined(var_3)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0.vehiclename;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(var_2)) {
    return;
  }

  getentitylessscriptablearray("dlog_event_vehicle_spawn", ["vehicle_spawn_id", var_3.id, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "spawn_type", var_1, "vehicle_type", var_2]);
}

function vehicle_dlog_exitevent(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_1)) {
    return;
  }

  var_4 = vehicle_dlog_getinstancedata(var_0);

  if(!isDefined(var_4)) {
    return;
  }

  if(!isDefined(var_2)) {
    return;
  }

  if(!isDefined(var_3)) {
    return;
  }

  var_1 dlog_recordplayerevent("dlog_event_player_vehicle_exit", ["vehicle_spawn_id", var_4.id, "exit_pos_x", var_0.origin[0], "exit_pos_y", var_0.origin[1], "exit_pos_z", var_0.origin[2], "exit_seat_id", var_2, "exit_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "exit_type", var_3]);
}

function ref_1418a(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_1)) {
    return;
  }

  var_4 = vehicle_dlog_getinstancedata(var_0);

  if(!isDefined(var_4)) {
    return;
  }

  if(!isDefined(var_2)) {
    return;
  }

  if(!isDefined(var_3)) {
    return;
  }

  var_1 dlog_recordplayerevent("dlog_event_player_vehicle_enter", ["vehicle_spawn_id", var_4.id, "enter_pos_x", var_0.origin[0], "enter_pos_y", var_0.origin[1], "enter_pos_z", var_0.origin[2], "enter_seat_id", var_2, "enter_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "enter_type", var_3]);
}

function vehicle_dlog_init() {
  var_0 = spawnStruct();
  var_0.uniqueid = 0;
  level.vehicle.dlogdata = var_0;
}

function vehicle_dlog_getleveldata() {
  return level.vehicle.dlogdata;
}

function vehicle_dlog_getinstancedata(var_0, var_1) {
  var_2 = vehicle_dlog_getleveldata();
  var_3 = var_0.dlogdata;

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_0.dlogdata = var_3;
    var_3.id = var_2.uniqueid;
    var_2.uniqueid++;
  }

  return var_3;
}

function vehicle_dlog_getuniqueid(var_0) {
  return var_0.dlogid;
}