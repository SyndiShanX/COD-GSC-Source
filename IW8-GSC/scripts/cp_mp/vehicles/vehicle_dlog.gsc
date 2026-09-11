/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_dlog.gsc
***************************************************/

function vehicle_dlog_spawnevent(var0, var1, var2) {
  var3 = vehicle_dlog_getinstancedata(var0, 1);

  if(!isDefined(var3)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = var0.vehiclename;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(var2)) {
    return;
  }

  getentitylessscriptablearray("dlog_event_vehicle_spawn", ["vehicle_spawn_id", var3.id, "pos_x", var0.origin[0], "pos_y", var0.origin[1], "pos_z", var0.origin[2], "matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "spawn_type", var1, "vehicle_type", var2]);
}

function vehicle_dlog_exitevent(var0, var1, var2, var3) {
  if(!isPlayer(var1)) {
    return;
  }

  var4 = vehicle_dlog_getinstancedata(var0);

  if(!isDefined(var4)) {
    return;
  }

  if(!isDefined(var2)) {
    return;
  }

  if(!isDefined(var3)) {
    return;
  }

  var1 dlog_recordplayerevent("dlog_event_player_vehicle_exit", ["vehicle_spawn_id", var4.id, "exit_pos_x", var0.origin[0], "exit_pos_y", var0.origin[1], "exit_pos_z", var0.origin[2], "exit_seat_id", var2, "exit_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "exit_type", var3]);
}

function ref_1418a(var0, var1, var2, var3) {
  if(!isPlayer(var1)) {
    return;
  }

  var4 = vehicle_dlog_getinstancedata(var0);

  if(!isDefined(var4)) {
    return;
  }

  if(!isDefined(var2)) {
    return;
  }

  if(!isDefined(var3)) {
    return;
  }

  var1 dlog_recordplayerevent("dlog_event_player_vehicle_enter", ["vehicle_spawn_id", var4.id, "enter_pos_x", var0.origin[0], "enter_pos_y", var0.origin[1], "enter_pos_z", var0.origin[2], "enter_seat_id", var2, "enter_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "enter_type", var3]);
}

function vehicle_dlog_init() {
  var0 = spawnStruct();
  var0.uniqueid = 0;
  level.vehicle.dlogdata = var0;
}

function vehicle_dlog_getleveldata() {
  return level.vehicle.dlogdata;
}

function vehicle_dlog_getinstancedata(var0, var1) {
  var2 = vehicle_dlog_getleveldata();
  var3 = var0.dlogdata;

  if(!isDefined(var3) && istrue(var1)) {
    var3 = spawnStruct();
    var0.dlogdata = var3;
    var3.id = var2.uniqueid;
    var2.uniqueid++;
  }

  return var3;
}

function vehicle_dlog_getuniqueid(var0) {
  return var0.dlogid;
}