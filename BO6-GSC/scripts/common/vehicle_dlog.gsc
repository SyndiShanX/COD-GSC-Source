/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_dlog.gsc
*******************************************/

#namespace vehicle_dlog;

function spawn_event(vehicle, spawntype = "undefined", vehicletype) {
  if(!isDefined(vehicletype)) {
    vehicletype = vehicle.vehiclename;
  }

  if(!isDefined(vehicletype)) {
    return;
  }

  dlog_recordevent("dlog_event_vehicle_spawn", ["vehicle_spawn_id", vehicle get_unique_id(), "pos_x", vehicle.origin[0], "pos_y", vehicle.origin[1], "pos_z", vehicle.origin[2], "matchtime_ms", function_cd4147ab95a9f684(), "spawn_type", spawntype, "vehicle_type", vehicletype]);
}

function death_event(vehicle, deathdata) {
  killerxuid = "undefined";
  weapon = "undefined";
  meansofdeath = "undefined";

  if(isDefined(deathdata)) {
    if(isPlayer(deathdata.attacker)) {
      killerxuid = deathdata.attacker getxuid();
    }

    if(isDefined(deathdata.objweapon)) {
      if(isstring(deathdata.objweapon)) {
        weapon = deathdata.objweapon;
      } else if(isweapon(deathdata.objweapon)) {
        weapon = deathdata.objweapon.basename;
      }
    }

    if(isDefined(deathdata.meansofdeath)) {
      meansofdeath = deathdata.meansofdeath;
    }
  }

  dlog_recordevent("dlog_event_vehicle_death", ["vehicle_spawn_id", vehicle get_unique_id(), "vehicle_pos_x", vehicle.origin[0], "vehicle_pos_y", vehicle.origin[1], "vehicle_pos_z", vehicle.origin[2], "vehicle_angles_x", vehicle.angles[0], "vehicle_angles_y", vehicle.angles[1], "vehicle_angles_z", vehicle.angles[2], "killer_xuid", killerxuid, "weapon", weapon, "means_of_death", meansofdeath, "matchtime_ms", function_cd4147ab95a9f684()]);
}

function exit_event(vehicle, player, seatid, data) {
  if(!isPlayer(player)) {
    return;
  }

  if(!isDefined(seatid)) {
    return;
  }

  if(!isDefined(data.exittype)) {
    return;
  }

  if(!isDefined(data.exitposition)) {
    return;
  }

  failedexits = 0;

  if(isDefined(vehicle.exitboundinginfo) && isDefined(vehicle.exitboundinginfo.exitsfailed)) {
    failedexits = vehicle.exitboundinginfo.exitsfailed.size;
  }

  player dlog_recordplayerevent("dlog_event_player_vehicle_exit", ["vehicle_spawn_id", vehicle get_unique_id(), "vehicle_pos_x", vehicle.origin[0], "vehicle_pos_y", vehicle.origin[1], "vehicle_pos_z", vehicle.origin[2], "vehicle_angles_x", vehicle.angles[0], "vehicle_angles_y", vehicle.angles[1], "vehicle_angles_z", vehicle.angles[2], "exit_seat_id", seatid, "exit_type", data.exittype, "exit_direction", data.exitdirection ?? "undefined", "exit_pos_x", data.exitposition[0], "exit_pos_y", data.exitposition[1], "exit_pos_z", data.exitposition[2], "failed_exits", failedexits, "exit_matchtime_ms", function_cd4147ab95a9f684()]);
}

function enter_event(vehicle, player, seatid, entertype) {
  if(!isPlayer(player)) {
    return;
  }

  if(!isDefined(seatid)) {
    return;
  }

  if(!isDefined(entertype)) {
    return;
  }

  player dlog_recordplayerevent("dlog_event_player_vehicle_enter", ["vehicle_spawn_id", vehicle get_unique_id(), "vehicle_pos_x", vehicle.origin[0], "vehicle_pos_y", vehicle.origin[1], "vehicle_pos_z", vehicle.origin[2], "vehicle_angles_x", vehicle.angles[0], "vehicle_angles_y", vehicle.angles[1], "vehicle_angles_z", vehicle.angles[2], "enter_seat_id", seatid, "enter_matchtime_ms", function_cd4147ab95a9f684(), "enter_type", entertype]);
}

function get_unique_id() {
  if(!isDefined(level.vehicledlogid)) {
    level.vehicledlogid = 0;
  }

  if(!isDefined(self.dlogid)) {
    self.dlogid = level.vehicledlogid;
    level.vehicledlogid += 1;
  }

  return self.dlogid;
}

function function_cd4147ab95a9f684() {
  matchstarttime = game["startTimeFromMatchStart"] ?? level.starttimefrommatchstart ?? 0;
  timefrom = gettime() - matchstarttime;

  if(timefrom < 0) {
    timefrom = 0;
  }

  return timefrom;
}