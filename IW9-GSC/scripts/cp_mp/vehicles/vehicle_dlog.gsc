/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_dlog.gsc
***************************************************/

vehicle_dlog_spawnevent(vehicle, spawntype, vehicletype) {
  instancedata = vehicle_dlog_getinstancedata(vehicle, 1);

  if(!isDefined(instancedata)) {
    return;
  }
  if(!isDefined(vehicletype))
    vehicletype = vehicle.vehiclename;

  if(!isDefined(spawntype)) {
    return;
  }
  if(!isDefined(vehicletype)) {
    return;
  }
  dlog_recordevent("dlog_event_vehicle_spawn", ["vehicle_spawn_id", instancedata.id, "pos_x", vehicle.origin[0], "pos_y", vehicle.origin[1], "pos_z", vehicle.origin[2], "matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "spawn_type", spawntype, "vehicle_type", vehicletype]);
}

vehicle_dlog_exitevent(vehicle, player, seatid, exittype) {
  if(!isPlayer(player)) {
    return;
  }
  instancedata = vehicle_dlog_getinstancedata(vehicle);

  if(!isDefined(instancedata)) {
    return;
  }
  if(!isDefined(seatid)) {
    return;
  }
  if(!isDefined(exittype)) {
    return;
  }
  player dlog_recordplayerevent("dlog_event_player_vehicle_exit", ["vehicle_spawn_id", instancedata.id, "exit_pos_x", vehicle.origin[0], "exit_pos_y", vehicle.origin[1], "exit_pos_z", vehicle.origin[2], "exit_seat_id", seatid, "exit_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "exit_type", exittype]);
}

vehicle_dlog_enterevent(vehicle, player, seatid, _id_6C6D078A43295C39) {
  if(!isPlayer(player)) {
    return;
  }
  instancedata = vehicle_dlog_getinstancedata(vehicle);

  if(!isDefined(instancedata)) {
    return;
  }
  if(!isDefined(seatid)) {
    return;
  }
  if(!isDefined(_id_6C6D078A43295C39)) {
    return;
  }
  player dlog_recordplayerevent("dlog_event_player_vehicle_enter", ["vehicle_spawn_id", instancedata.id, "enter_pos_x", vehicle.origin[0], "enter_pos_y", vehicle.origin[1], "enter_pos_z", vehicle.origin[2], "enter_seat_id", seatid, "enter_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "enter_type", _id_6C6D078A43295C39]);
}

vehicle_dlog_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  _id_962A30A9BB8C0F09.uniqueid = 0;
  level.vehicle.dlogdata = _id_962A30A9BB8C0F09;
}

vehicle_dlog_getleveldata() {
  return level.vehicle.dlogdata;
}

vehicle_dlog_getinstancedata(vehicle, create) {
  _id_962A30A9BB8C0F09 = vehicle_dlog_getleveldata();
  instancedata = vehicle.dlogdata;

  if(!isDefined(instancedata) && istrue(create)) {
    instancedata = spawnStruct();
    vehicle.dlogdata = instancedata;
    instancedata.id = _id_962A30A9BB8C0F09.uniqueid;
    _id_962A30A9BB8C0F09.uniqueid++;
  }

  return instancedata;
}

vehicle_dlog_getuniqueid(vehicle) {
  return vehicle.dlogid;
}