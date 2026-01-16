/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_callbacks.csc
*******************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_vehicle;

statechange(clientNum, system, newState) {
  if(!isDefined(level._systemStates)) {
    level._systemStates = [];
  }
  if(!isDefined(level._systemStates[system])) {
    level._systemStates[system] = spawnstruct();
  }
  level._systemStates[system].state = newState;
  if(isDefined(level._systemStates[system].callback)) {
    [
      [level._systemStates[system].callback]
    ](clientNum, newState);
  } else {
    println("*** Unhandled client system state change - " + system + " - has no registered callback function.");
  }
}
maprestart() {
  println("*** Client script VM map restart.");
}
init_fx(clientNum) {
  waitforclient(clientNum);
  thread clientscripts\mp\_fx::fx_init(clientNum);
}
localclientconnect(clientNum) {
  println("*** Client script VM : Local client connect " + clientNum);
  level thread clientscripts\mp\_players::on_connect(clientNum);
  level thread init_fx(clientNum);
}
localclientdisconnect(clientNum) {
  println("*** Client script VM : Local client disconnect " + clientNum);
}
level_notify(notify_name, param1, param2) {
  level notify(notify_name, param1, param2);
}
glass_smash(org, dir) {
  level notify("glass_smash", org, dir);
}
playerspawned(localClientNum) {
  self endon("entityshutdown");
  PrintLn("Player spawned");
  self thread clientscripts\mp\_explode::playerspawned(localClientNum);
  self thread clientscripts\mp\_players::dtp_effects();
  self thread clientscripts\mp\_cameraspike::playerSpawned();
  if(isDefined(level._faceAnimCBFunc))
    self thread[[level._faceAnimCBFunc]](localClientNum);
}
entityspawned(localClientNum) {
  self endon("entityshutdown");
  if(!isDefined(self.type)) {
    println("Entity type undefined!");
    return;
  }
  if(self.type == "missile") {
    switch (self.weapon) {
      case "explosive_bolt_mp":
        PrintLn("threading the explosive_bolt_mp");
        local_players_entity_thread(self, clientscripts\mp\_explosive_bolt::spawned, true);
        break;
      case "crossbow_explosive_mp":
        PrintLn("threading the crossbow_explosive_mp");
        local_players_entity_thread(self, clientscripts\mp\_explosive_bolt::spawned, false);
        break;
      case "acoustic_sensor_mp":
        self thread clientscripts\mp\_acousticsensor::spawned(localClientNum);
        break;
      case "sticky_grenade_mp":
        local_players_entity_thread(self, clientscripts\mp\_sticky_grenade::spawned, true);
        break;
      case "nightingale_mp":
        local_players_entity_thread(self, clientscripts\mp\_decoy::spawned);
        break;
      case "satchel_charge_mp":
        local_players_entity_thread(self, clientscripts\mp\_satchel_charge::spawned);
        break;
      case "claymore_mp":
        local_players_entity_thread(self, clientscripts\mp\_claymore::spawned);
        break;
    }
  }
  if(self.type == "vehicle") {
    if(!isDefined(level.vehicles_inited)) {
      clientscripts\mp\_vehicle::init_vehicles();
    }
    if(self.vehicleclass == "4 wheel") {
      if(self.vehicletype == "rc_car_medium_mp") {
        local_players_entity_thread(self, clientscripts\mp\_rcbomb::spawned);
      }
    } else if(self.vehicleclass == "tank") {
      self thread vehicle_treads(localClientNum);
      self thread vehicle_watch_damage(localClientNum);
      self thread playTankExhaust(localClientNum);
      self thread vehicle_rumble(localClientNum);
      self thread vehicle_variants(localClientNum);
    }
  }
  if(self.type == "helicopter") {
    clientscripts\mp\_treadfx::loadtreadfx(self);
    local_players_entity_thread(self, clientscripts\mp\_helicopter::startfx_loop);
  }
  if(self.type == "actor") {
    self thread clientscripts\mp\_dogs::spawned(localClientNum);
  }
}
entityshutdown_callback(localClientNum, entity) {
  if(isDefined(level._entityShutDownCBFunc)) {
    [
      [level._entityShutDownCBFunc]
    ](localClientNum, entity);
  }
}
airsupport(localClientNum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
  pos = (x, y, z);
  switch (teamFaction) {
    case "v":
      teamfaction = "vietcong";
      break;
    case "n":
    case "nva":
      teamfaction = "nva";
      break;
    case "j":
      teamfaction = "japanese";
      break;
    case "m":
      teamfaction = "marines";
      break;
    case "s":
      teamfaction = "specops";
      break;
    case "r":
      teamfaction = "russian";
      break;
    default:
      println("Warning: Invalid team char provided, defaulted to marines");
      println("Teamfaction received: " + teamFaction + "\n");
      teamfaction = "marines";
      break;
  }
  switch (team) {
    case "x":
      team = "axis";
      break;
    case "l":
      team = "allies";
      break;
    case "r":
      team = "free";
      break;
    default:
      println("Invalid team used with playclientAirstike/napalm: " + team + "\n");
      team = "allies";
      break;
  }
  data = spawnstruct();
  data.team = team;
  data.owner = owner;
  data.bombsite = pos;
  data.yaw = yaw;
  direction = (0, yaw, 0);
  data.direction = direction;
  data.flyHeight = height;
  if(type == "a") {
    planeHalfDistance = 12000;
    data.planeHalfDistance = planeHalfDistance;
    data.startPoint = pos + vector_scale(anglestoforward(direction), -1 * planeHalfDistance);
    data.endPoint = pos + vector_scale(anglestoforward(direction), planeHalfDistance);
    data.planeModel = "t5_veh_air_b52";
    data.flyBySound = "null";
    data.washSound = "veh_b52_flyby_wash";
    data.apexTime = 6145;
    data.exitType = -1;
    data.flySpeed = 2000;
    data.flyTime = ((planeHalfDistance * 2) / data.flySpeed);
    planeType = "airstrike";
    clientscripts\mp\_airstrike::addPlaneEvent(localClientNum, planeType, data, time);
  } else if(type == "n") {
    planeHalfDistance = 24000;
    data.planeHalfDistance = planeHalfDistance;
    data.startPoint = pos + vector_scale(anglestoforward(direction), -1 * planeHalfDistance);
    data.endPoint = pos + vector_scale(anglestoforward(direction), planeHalfDistance);
    data.planeModel = clientscripts\mp\_airsupport::getPlaneModel(teamFaction);
    data.flyBySound = "null";
    data.washSound = "evt_us_napalm_wash";
    data.apexTime = 2362;
    data.exitType = exitType;
    data.flySpeed = 7000;
    data.flyTime = ((planeHalfDistance * 2) / data.flySpeed);
    planeType = "napalm";
    clientscripts\mp\_plane::addPlaneEvent(localClientNum, planeType, data, time);
  } else {
    println("");
    println("Unhandled airsupport type, only A (airstrike) and N (napalm) supported");
    println(type);
    println("");
    return;
  }
}
demo_jump(localClientNum, time) {
  level notify("demo_jump", time);
  level notify("demo_jump" + localClientNum, time);
}
demo_player_switch(localClientNum) {
  level notify("demo_player_switch");
  level notify("demo_player_switch" + localClientNum);
}
stunned_callback(localClientNum, set) {
  self.stunned = set;
  PrintLn("stunned_callback");
  if(set)
    self notify("stunned");
  else
    self notify("not_stunned");
}
client_flag_debug(msg) {}
client_flag_callback(localClientNum, flag, set) {
  assert(isDefined(level._client_flag_callbacks));
  client_flag_debug("*** client_flag_callback(): localClientNum: " + localClientNum + " flag: " + flag + " set: " + set + " self: " + self getentitynumber() + " self.type: " + self.type);
  if(!isDefined(level._client_flag_callbacks[self.type])) {
    client_flag_debug("*** client_flag_callback(): no callback defined for self.type: " + self.type);
    return;
  }
  if(IsArray(level._client_flag_callbacks[self.type])) {
    if(isDefined(level._client_flag_callbacks[self.type][flag])) {
      self thread[[level._client_flag_callbacks[self.type][flag]]](localClientNum, set);
    }
  } else {
    self thread[[level._client_flag_callbacks[self.type]]](localClientNum, flag, set);
  }
}
client_flagasval_callback(localClientNum, val) {
  if(isDefined(level._client_flagasval_callbacks) && isDefined(level._client_flagasval_callbacks[self.type])) {
    self thread[[level._client_flagasval_callbacks[self.type]]](localClientNum, val);
  }
}
CodeCallback_CreatingCorpse(localClientNum, player) {
  if(self isBurning()) {
    self thread clientscripts\mp\_burnplayer::corpseFlameFx(localClientNum);
  }
  wait(0.1);
  self clientscripts\mp\_clientfaceanim_mp::do_corpse_face_hack(localClientNum);
}
CodeCallback_PlayerFootstep(client_num, player, movementtype, ground_type, firstperson, quiet) {
  clientscripts\mp\_footsteps::playerFootstep(client_num, player, movementtype, ground_type, firstperson, quiet);
}
CodeCallback_PlayerJump(client_num, player, ground_type, firstperson, quiet) {
  clientscripts\mp\_footsteps::playerJump(client_num, player, ground_type, firstperson, quiet);
}
CodeCallback_PlayerLand(client_num, player, ground_type, firstperson, quiet, damagePlayer) {
  clientscripts\mp\_footsteps::playerLand(client_num, player, ground_type, firstperson, quiet, damagePlayer);
}
CodeCallback_PlayerFoliage(client_num, player, firstperson, quiet) {
  clientscripts\mp\_footsteps::playerFoliage(client_num, player, firstperson, quiet);
}