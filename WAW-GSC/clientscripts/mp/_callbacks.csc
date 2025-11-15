/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_callbacks.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_vehicle;

statechange(clientNum, system, newState) {
  if(!isDefined(level._systemStates)) {
    level._systemStates = [];
  }
  if(!isDefined(level._systemStates[system])) {
    level._systemStates[system] = spawnStruct();
  }
  level._systemStates[system].state = newState;
  if(isDefined(level._systemStates[system].callback)) {
    [[level._systemStates[system].callback]](clientNum, newState);
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
  if(clientNum > 0) {
    level thread init_fx(clientNum);
  }
}

localclientdisconnect(clientNum) {
  println("*** Client script VM : Local client disconnect " + clientNum);
}

entityspawned(localClientNum) {
  self endon("entityshutdown");
  if(!isDefined(self.type)) {
    println("Entity type undefined!");
    return;
  }
  if(self.type == "vehicle") {
    if(!isDefined(level.vehicles_inited)) {
      clientscripts\mp\_vehicle::init_vehicles();
    }
    if(!(self is_aircraft())) {
      self thread vehicle_treads(localClientNum);
      self thread vehicle_watch_damage(localClientNum);
      self thread playTankExhaust(localClientNum);
      self thread vehicle_rumble(localClientNum);
      self thread vehicle_variants(localClientNum);
    }
  }
  if(self.type == "actor") {
    self thread clientscripts\mp\_dogs::spawned(localClientNum);
  }
}