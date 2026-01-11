/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_vehicle.csc
*****************************************************/

#include clientscripts\mp\_utility;

init_vehicles() {
  init_aircraft_list();
  init_boat_list();
  level.vehicles_inited = true;
}

init_aircraft_list() {
  level.aircraft_list = [];
  level.aircraft_list["player_corsair"] = true;
  level.aircraft_list["rufe"] = true;
  level.aircraft_list["corsair"] = true;
  level.aircraft_list["zero"] = true;
  level.aircraft_list["pby"] = true;
  level.aircraft_list["pby_blackcat"] = true;
  level.aircraft_list["jap_gunboat"] = true;
  level.aircraft_list["il2"] = true;
}

init_boat_list() {
  level.boat_list = [];
  level.boat_list["rubber_raft"] = true;
  level.boat_list["jap_ptboat"] = true;
  level.boat_list["jap_shinyo"] = true;
  level.boat_list["jap_merchant_ship"] = true;
}

is_aircraft() {
  return isDefined(level.aircraft_list[self.vehicletype]);
}

is_boat() {
  return isDefined(level.boat_list[self.vehicletype]);
}

vehicle_rumble(localClientNum) {
  self endon("entityshutdown");
  if(!isDefined(level.vehicle_rumble)) {
    return;
  }
  type = self.vehicletype;
  if(!isDefined(level.vehicle_rumble[type])) {
    return;
  }
  rumblestruct = level.vehicle_rumble[type];
  height = rumblestruct.radius * 2;
  zoffset = -1 * rumblestruct.radius;
  if(!isDefined(self.rumbleon)) {
    self.rumbleon = true;
  }
  if(isDefined(rumblestruct.scale)) {
    self.rumble_scale = rumblestruct.scale;
  } else {
    self.rumble_scale = 0.15;
  }
  if(isDefined(rumblestruct.duration)) {
    self.rumble_duration = rumblestruct.duration;
  } else {
    self.rumble_duration = 4.5;
  }
  if(isDefined(rumblestruct.radius)) {
    self.rumble_radius = rumblestruct.radius;
  } else {
    self.rumble_radius = 600;
  }
  if(isDefined(rumblestruct.basetime)) {
    self.rumble_basetime = rumblestruct.basetime;
  } else {
    self.rumble_basetime = 1;
  }
  if(isDefined(rumblestruct.randomaditionaltime)) {
    self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }
  self.player_touching = 0;
  radius_squared = rumblestruct.radius * rumblestruct.radius;
  while(1) {
    if((distancesquared(self.origin, getlocalplayers()[localClientNum].origin) > radius_squared) || self getspeed() < 35) {
      wait(0.2);
      continue;
    }
    if(isDefined(self.rumbleon) && !self.rumbleon) {
      wait(0.2);
      continue;
    }
    leftTreadHealth = self getlefttreadhealth();
    rightTreadHealth = self getrighttreadhealth();
    if((leftTreadHealth < .7) || (rightTreadHealth < .7)) {
      self PlayRumbleLoopOnEntity(localClientNum, "tank_damaged_rumble_mp");
    } else {
      self PlayRumbleLoopOnEntity(localClientNum, level.vehicle_rumble[type].rumble);
    }
    while((distancesquared(self.origin, getlocalplayers()[localClientNum].origin) < radius_squared) && (self getspeed() > 5)) {
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
    }
    self StopRumble(localClientNum, level.vehicle_rumble[type].rumble);
  }
}

vehicle_treads(localClientNum) {
  if(!isDefined(level._vehicle_effect)) {
    level._vehicle_effect = [];
  }
  if(!isDefined(level.vehicles_inited) || !isDefined(level.vehicle_treads)) {
    return;
  }
  if(isDefined(level.vehicle_treads[self.vehicletype]) && level.vehicle_treads[self.vehicletype] == false) {
    return;
  }
  if(self is_aircraft()) {
    return;
  }
  if(self.vehicletype == "buffalo" || self.vehicletype == "amtank" || self.vehicletype == "rubber_raft" || self.vehicletype == "jap_ptboat" || self.vehicletype == "jap_shinyo") {
    self thread tread(localClientNum, "tag_wake", "back_left");
  } else {
    self thread tread(localClientNum, "tag_wheel_back_left", "back_left");
    self thread tread(localClientNum, "tag_wheel_back_right", "back_right");
  }
}

vehicle_kill_treads_forever() {
  self notify("kill_treads_forever");
}

tread(localClientNum, tagname, side, relativeOffset) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  treadfx = treadget(self, side);
  if(treadfx == -1) {
    return;
  }
  for(;;) {
    speed = self getspeed();
    if(speed < 25) {
      wait 0.1;
      continue;
    }
    waitTime = (1 / speed);
    waitTime = (waitTime * 35);
    if(waitTime < 0.1) {
      waitTime = 0.1;
    } else if(waitTime > 0.3) {
      waitTime = 0.3;
    }
    wait waitTime;
    lastfx = treadfx;
    treadfx = treadget(self, side);
    if(treadfx != -1) {
      ang = self getTagAngles(tagname);
      forwardVec = anglesToForward(ang);
      effectOrigin = self getTagOrigin(tagname);
      forwardVec = vector_multiply(forwardVec, waitTime);
      playFX(localClientNum, treadfx, effectOrigin, (0, 0, 0) - forwardVec);
    }
  }
}

treadget(vehicle, side) {
  if(vehicle is_boat()) {
    if(!isDefined(level._vehicle_effect[vehicle.vehicletype])) {
      println("clientside treadfx not setup for boat type (only needs water): ", vehicle.vehicletype);
      wait 10;
      return -1;
    }
    return level._vehicle_effect[vehicle.vehicletype]["water"];
  }
  surface = self getwheelsurface(side);
  if(!isDefined(vehicle.vehicletype)) {
    treadfx = -1;
    return treadfx;
  }
  if(!isDefined(level._vehicle_effect[vehicle.vehicletype])) {
    println("clientside treadfx not setup for vehicle type: ", vehicle.vehicletype);
    wait 10;
    return -1;
  }
  treadfx = level._vehicle_effect[vehicle.vehicletype][surface];
  if(!isDefined(treadfx)) {
    treadfx = -1;
  }
  return treadfx;
}

vehicle_watch_damage(localClientNum) {
  self endon("entityshutdown");
  if(!isDefined(level.tread_damage_fx) || !isDefined(level.tread_damage_fx[self.vehicletype]) ||
    !isDefined(level.tread_grind_fx) || !isDefined(level.tread_grind_fx[self.vehicletype])) {
    return;
  }
  keepWatchingLeftTread = true;
  keepWatchingRightTread = true;
  lastLeftTreadHealth = 0;
  lastRightTreadHealth = 0;
  minSparkSpeed = 25;
  while(self GetVehicleHealth() > 0) {
    vehiclespeed = self getspeed();
    leftTreadHealth = self getlefttreadhealth();
    rightTreadHealth = self getrighttreadhealth();
    if((leftTreadHealth != lastLeftTreadHealth || rightTreadHealth != lastRightTreadHealth) && self GetInKillcam(localClientNum)) {
      leftTreadHealth = lastLeftTreadHealth;
      rightTreadHealth = lastRightTreadHealth;
    } else {
      lastLeftTreadHealth = leftTreadHealth;
      lastRightTreadHealth = rightTreadHealth;
    }
    tag = "tag_treads_left";
    if(leftTreadHealth <= 0.4) {
      if(isDefined(level.tread_damage_fx[self.vehicletype][0]) && isDefined(level.tread_damage_fx[self.vehicletype][0][1])) {
        playFXOnTag(localClientNum, level.tread_damage_fx[self.vehicletype][0][1], self, tag);
      }
      if(keepWatchingLeftTread && leftTreadHealth <= 0) {
        keepWatchingLeftTread = false;
        if(isDefined(level.tread_damage_fx[self.vehicletype][0]) && isDefined(level.tread_damage_fx[self.vehicletype][0][2])) {
          playFXOnTag(localClientNum, level.tread_damage_fx[self.vehicletype][0][2], self, tag);
        }
      }
    } else if(leftTreadHealth < 0.7) {
      if(isDefined(level.tread_damage_fx[self.vehicletype][0]) && isDefined(level.tread_damage_fx[self.vehicletype][0][0])) {
        playFXOnTag(localClientNum, level.tread_damage_fx[self.vehicletype][0][0], self, tag);
      }
      if(isDefined(level.tread_grind_fx[self.vehicletype][0]) && vehiclespeed > minSparkSpeed) {
        playFXOnTag(localClientNum, level.tread_grind_fx[self.vehicletype][0], self, tag);
      }
    }
    tag = "tag_treads_right";
    if(rightTreadHealth <= 0.4) {
      if(isDefined(level.tread_damage_fx[self.vehicletype][1]) && isDefined(level.tread_damage_fx[self.vehicletype][1][1])) {
        playFXOnTag(localClientNum, level.tread_damage_fx[self.vehicletype][1][1], self, tag);
      }
      if(keepWatchingRightTread && leftTreadHealth <= 0) {
        keepWatchingRightTread = false;
        if(isDefined(level.tread_damage_fx[self.vehicletype][1]) && isDefined(level.tread_damage_fx[self.vehicletype][1][2])) {
          playFXOnTag(localClientNum, level.tread_damage_fx[self.vehicletype][1][2], self, tag);
        }
      }
    } else if(rightTreadHealth < 0.7) {
      if(isDefined(level.tread_damage_fx[self.vehicletype][1]) && isDefined(level.tread_damage_fx[self.vehicletype][1][0])) {
        playFXOnTag(localClientNum, level.tread_damage_fx[self.vehicletype][1][0], self, tag);
      }
      if(isDefined(level.tread_grind_fx[self.vehicletype][1]) && vehiclespeed > minSparkSpeed) {
        playFXOnTag(localClientNum, level.tread_grind_fx[self.vehicletype][1], self, tag);
      }
    }
    wait(0.1);
  }
}

playTankExhaust(localClientNum) {
  self endon("entityshutdown");
  self endon("stop_exhaust_fx");
  level endon("stop_exhaust_fx");
  exhaustDelay = 0.1;
  for(;;) {
    if(!isDefined(self) || !(self isalive())) {
      return;
    } else if(!isDefined(level.vehicle_exhaust) || !isDefined(level.vehicle_exhaust[self.model])) {
      println("clientside exhaustfx not set up for vehicle model: " + self.model);
      return;
    }
    tag_left_orig = self gettagorigin("tag_engine_left");
    tag_left_angles = self gettagangles("tag_engine_left");
    if(self getspeed() > 0) {
      playFX(localClientNum, level.vehicle_exhaust[self.model].exhaust_fx, tag_left_orig, anglesToForward(tag_left_angles));
      if(!level.vehicle_exhaust[self.model].one_exhaust) {
        tag_right_orig = self gettagorigin("tag_engine_right");
        tag_right_angles = self gettagangles("tag_engine_right");
        playFX(localClientNum, level.vehicle_exhaust[self.model].exhaust_fx, tag_right_orig, anglesToForward(tag_right_angles));
      }
    }
    wait exhaustDelay;
  }
}

build_treadfx(type) {
  clientscripts\mp\_treadfx::main(type);
}

build_exhaust(model, effect, one_exhaust) {
  println("building exhaust for " + model);
  if(!isDefined(level.vehicle_exhaust)) {
    level.vehicle_exhaust = [];
  }
  level.vehicle_exhaust[model] = spawnStruct();
  level.vehicle_exhaust[model].exhaust_fx = loadfx(effect);
  if(isDefined(one_exhaust) && one_exhaust) {
    level.vehicle_exhaust[model].one_exhaust = true;
  } else {
    level.vehicle_exhaust[model].one_exhaust = false;
  }
}

build_gear(vehicletype, model, tag) {
  index = 0;
  if(isDefined(level.vehicleGearModels)) {
    if(isDefined(level.vehicleGearModels[vehicletype])) {
      index = level.vehicleGearModels[vehicletype].size;
    }
  }
  level.vehicleGearModels[vehicletype][index] = model;
  level.vehicleGearTags[vehicletype][index] = tag;
}

build_quake(scale, duration, radius, basetime, randomaditionaltime) {
  struct = spawnStruct();
  struct.scale = scale;
  struct.duration = duration;
  struct.radius = radius;
  if(isDefined(basetime)) {
    struct.basetime = basetime;
  }
  if(isDefined(randomaditionaltime)) {
    struct.randomaditionaltime = randomaditionaltime;
  }
  return struct;
}

build_rumble(type, rumble, scale, duration, radius, basetime, randomaditionaltime) {
  println("*** Client : Building rumble for " + type);
  if(!isDefined(level.vehicle_rumble)) {
    level.vehicle_rumble = [];
  }
  struct = build_quake(scale, duration, radius, basetime, randomaditionaltime);
  assert(isDefined(rumble));
  struct.rumble = precacherumble(rumble);
  level.vehicle_rumble[type] = struct;
}

vehicle_variants(localClientNum) {}