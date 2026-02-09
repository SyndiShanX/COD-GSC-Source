/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_vehicle\.csc
**************************************/

#include clientscripts\_utility;

init_vehicles() {
  level.vehicles_inited = true;
}
vehicle_rumble(localClientNum) {
  self endon("entityshutdown");
  level endon("save_restore");
  if(!isDefined(self.rumbletype) || (self.rumbleradius == 0)) {
    return;
  }
  if(!isDefined(self.rumbleon)) {
    self.rumbleon = true;
  }
  height = self.rumbleradius * 2;
  zoffset = -1 * self.rumbleradius;
  self.player_touching = 0;
  radius_squared = self.rumbleradius * self.rumbleradius;
  wait 2;
  while(1) {
    if((distancesquared(self.origin, getlocalplayers()[localClientNum].origin) > radius_squared) || self getspeed() == 0) {
      wait(0.2);
      continue;
    }
    if(isDefined(self.rumbleon) && !self.rumbleon) {
      wait(0.2);
      continue;
    }
    self PlayRumbleLoopOnEntity(localClientNum, self.rumbletype);
    while((distancesquared(self.origin, getlocalplayers()[localClientNum].origin) < radius_squared) && (self getspeed() > 0)) {
      self earthquake(self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius);
      wait(self.rumblebasetime + randomfloat(self.rumbleadditionaltime));
    }
    self StopRumble(localClientNum, self.rumbletype);
  }
}
vehicle_treads(localClientNum) {
  waittillframeend;
  PrintLn("****CLIENT:: Creating TreadFX: " + self GetEntityNumber());
  if(!isDefined(level.vehicles_inited) || !isDefined(self.treadfx)) {
    return;
  }
  if(isDefined(self.csf_no_tread) && self.csf_no_tread) {
    return;
  }
  if(self is_plane()) {
    return;
  }
  if(self.vehicleclass == "boat" && self.vehicletype != "inc_base_jump_spotlight") {
    self thread wake(localClientNum, "tag_wake");
    self thread splash(localClientNum);
    self thread splash_small();
  } else if(self.vehicleclass == "motorcycle") {
    self thread tread(localClientNum, "tag_wheel_back", "back_left");
  } else {
    self thread tread(localClientNum, "tag_wheel_back_left", "back_left");
    self thread tread(localClientNum, "tag_wheel_back_right", "back_right");
  }
}
vehicle_kill_treads_forever() {
  PrintLn("****CLIENT:: killing the tread_fx");
  self notify("kill_treads_forever");
}
get_throttle_effect(throttle) {
  if(isDefined(self.throttlefx)) {
    if(throttle < 0.3) {
      return self.throttlefx[0];
    } else if(throttle < 0.7) {
      return self.throttlefx[1];
    } else {
      return self.throttlefx[2];
    }
  }
  return undefined;
}
wake_mon(localClientNum) {
  self waittill("kill_treads_forever");
  level endon("save_restore");
  self endon("entityshutdown");
  if(isDefined(self.wake_fxHandle)) {
    deletefx(localClientNum, self.wake_fxHandle, 0);
    self.wake_fxHandle = undefined;
  }
}
wake(localClientNum, tagname) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  level endon("save_restore");
  treadfx = treadget(self, "back_left");
  if(treadfx == -1) {
    return;
  }
  self thread wake_mon(localClientNum);
  self.wake_fxHandle = undefined;
  wakeState = -1;
  inwater = true;
  for(;;) {
    speed = self getspeed();
    if(!isDefined(self.wakefx)) {
      if(speed < 50) {
        if(isDefined(self.wake_fxHandle)) {
          deletefx(localClientNum, self.wake_fxHandle, 0);
          self.wake_fxHandle = undefined;
        }
      } else if(!isDefined(self.wake_fxHandle)) {
        self.wake_fxHandle = playFXOnTag(localClientNum, treadfx, self, tagname);
      }
    } else {
      newState = 0;
      if(speed > 150 && self getthrottle() < 0) {
        newState = 0;
      } else if(speed < 70) {
        newState = 1;
      } else if(speed < 300) {
        newState = 2;
      } else if(speed < 600) {
        newState = 3;
      } else {
        newState = 4;
      }
      if(wakeState != newState) {
        if(isDefined(self.wake_fxHandle)) {
          deletefx(localClientNum, self.wake_fxHandle, 0);
          self.wake_fxHandle = undefined;
        }
        wakeState = newState;
        fx = self.wakefx[wakeState];
        self.wake_fxHandle = playFXOnTag(localClientNum, fx, self, tagname);
      }
    }
    throttle = self getthrottle();
    if(throttle > 0.0) {
      throttleEffect = self get_throttle_effect(throttle);
      if(isDefined(throttleEffect)) {
        effectOrigin = self getTagOrigin(tagname);
        fwd = self gettagforwardvector(tagname);
        playFX(localClientNum, throttleEffect, effectOrigin, fwd);
      }
    }
    wait 0.1;
  }
}
splash(localClientNum) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  level endon("save_restore");
  if(!isDefined(self.splashfx)) {
    return;
  }
  wasinwater = true;
  offset = (0, 0, -10);
  last_water_check_pos = self.origin + anglesToForward(self.angles) * 100 + offset;
  for(;;) {
    wait(0.5);
    water_check_pos = self.origin + anglesToForward(self.angles) * 100 + offset;
    water_height = getwaterheight(water_check_pos);
    isinwater = water_check_pos[2] < water_height;
    vertical_speed = water_check_pos[2] - last_water_check_pos[2];
    if(!wasinwater && isinwater) {
      vertical_speed = water_check_pos[2] - last_water_check_pos[2];
      if(self getspeed() > 300 && vertical_speed < -2) {
        splashOrigin = self getTagOrigin("snd_bow_center");
        effectOrigin = self getTagOrigin("tag_wake");
        fwd = self gettagforwardvector("tag_wake");
        playFX(localClientNum, self.splashfx, effectOrigin, fwd);
        id = playSound(0, "veh_boat_splash", splashOrigin);
      }
    }
    wasinwater = isinwater;
    last_water_check_pos = water_check_pos;
  }
}
splash_small() {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  level endon("save_restore");
  offset = (0, 0, -10);
  wait(randomfloat(0.5));
  for(;;) {
    water_check_pos = self.origin + anglesToForward(self.angles) * 100 + offset;
    wait(0.5);
    water_check_pos_2 = self.origin + anglesToForward(self.angles) * 100 + offset;
    water_height = getwaterheight(water_check_pos);
    isinwater = water_check_pos[2] < water_height;
    vertical_speed = water_check_pos[2] - water_check_pos_2[2];
    if(isinwater) {
      vertical_speed = water_check_pos_2[2] - water_check_pos[2];
      if(self getspeed() > 100 && vertical_speed < -0.6) {
        splashOrigin = self getTagOrigin("snd_bow_center");
        if(!isDefined(splashOrigin)) {
          splashOrigin = self getTagOrigin("tag_origin");
          println("***SOUND: Can't find snd_bow_center***");
        }
        id = playSound(0, "veh_boat_splash_small", splashOrigin);
        wait(1.6);
      }
    }
  }
}
tread(localClientNum, tagname, side, relativeOffset) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  level endon("save_restore");
  treadfx = treadget(self, side);
  if(treadfx == -1) {
    return;
  }
  wait(randomfloat(0.5));
  for(;;) {
    speed = self getspeed();
    if(speed == 0 || (speed > -1 && speed < 1)) {
      wait 0.11;
      continue;
    }
    if(speed > 350) {
      waitTime = 0.1;
    } else if(speed < 166) {
      waitTime = 0.3;
    } else {
      waitTime = (35 / speed);
    }
    wait waitTime;
    treadfx = treadget(self, side);
    if(treadfx != -1) {
      forwardVec = self gettagforwardvector(tagname);
      effectOrigin = self getTagOrigin(tagname);
      forwardVec = vector_scale(forwardVec, waitTime);
      playFX(localClientNum, treadfx, effectOrigin, (0, 0, 0) - forwardVec);
    }
  }
}
treadget(vehicle, side) {
  if(vehicle.vehicleclass == "boat") {
    if(!isDefined(vehicle.treadfx["water"])) {
      println("clientside treadfx not setup for boat type( only needs water ): ", vehicle.vehicletype);
      wait 10;
      return -1;
    }
    return vehicle.treadfx["water"];
  }
  surface = self getwheelsurface(side);
  if(!isDefined(vehicle.vehicletype)) {
    treadfx = -1;
    return treadfx;
  }
  if(!isDefined(vehicle.treadfx[surface])) {
    println("clientside treadfx not setup for vehicle type: ", vehicle.vehicletype + " (surface: " + surface + ")");
    wait 10;
    return -1;
  }
  treadfx = vehicle.treadfx[surface];
  if(!isDefined(treadfx)) {
    treadfx = -1;
  }
  return treadfx;
}
playTankExhaust(localClientNum) {
  if(isDefined(self.csf_no_exhaust) && self.csf_no_exhaust) {
    return;
  }
  if(isDefined(self) && (self isalive()) && isDefined(self.exhaust_fx)) {
    playFXOnTag(localClientNum, self.exhaust_fx, self, "tag_engine_left");
    if(!self.oneexhaust) {
      playFXOnTag(localClientNum, self.exhaust_fx, self, "tag_engine_right");
    }
  }
}
play_exhaust(localClientNum) {
  if(isDefined(self.csf_no_exhaust) && self.csf_no_exhaust) {
    return;
  }
  if(isDefined(self) && (self isalive()) && isDefined(self.exhaust_fx)) {
    playFXOnTag(localClientNum, self.exhaust_fx, self, "tag_engine_left");
    if(!self.oneexhaust) {
      playFXOnTag(localClientNum, self.exhaust_fx, self, "tag_engine_right");
    }
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
vehicle_variants(localClientNum) {
  if(isDefined(level.vehicleGearModels)) {
    if(isDefined(level.vehicleGearModels[self.vehicletype])) {
      numGear = level.vehicleGearModels[self.vehicletype].size;
      maxGear = 2;
      if(numGear < maxGear) {
        maxGear = numGear;
      }
      randomConstantNumber = self getentitynumber();
      for(i = 0; i < maxGear; i++) {
        alreadyChosen = true;
        gearChoices[i] = -1;
        while(alreadyChosen) {
          alreadyChosen = false;
          gearChoices[i] = randomConstantNumber % numGear;
          for(j = 0; j < i; j++) {
            if(level.vehicleGearTags[self.vehicletype][gearChoices[j]] == level.vehicleGearTags[self.vehicletype][gearChoices[i]]) {
              alreadyChosen = true;
              break;
            }
          }
        }
        self attach(level.vehicleGearModels[self.vehicletype][gearChoices[i]], level.vehicleGearTags[self.vehicletype][gearChoices[i]]);
        randomConstantNumber++;
      }
    }
  }
}
aircraft_dustkick() {
  waittillframeend;
  self endon("kill_treads_forever");
  self endon("entityshutdown");
  level endon("save_restore");
  if(isDefined(self.csf_no_tread) && self.csf_no_tread) {
    return;
  }
  maxHeight = 1200;
  minHeight = 350;
  slowestRepeatWait = 0.15;
  fastestRepeatWait = 0.05;
  if(self is_mig()) {
    numFramesPerTrace = 1;
  } else {
    numFramesPerTrace = 3;
  }
  doTraceThisFrame = numFramesPerTrace;
  defaultRepeatRate = 1.0;
  repeatRate = defaultRepeatRate;
  trace = undefined;
  d = undefined;
  trace_ent = self;
  while(isDefined(self)) {
    if(repeatRate <= 0) {
      repeatRate = defaultRepeatRate;
    }
    if(self is_mig()) {
      repeatRate = 0.02;
    }
    realwait(repeatRate);
    if(!isDefined(self)) {
      return;
    }
    doTraceThisFrame--;
    if(doTraceThisFrame <= 0) {
      doTraceThisFrame = numFramesPerTrace;
      trace = tracepoint(trace_ent.origin, trace_ent.origin - (0, 0, 100000));
      d = distance(trace_ent.origin, trace["position"]);
      repeatRate = ((d - minHeight) / (maxHeight - minHeight)) * (slowestRepeatWait - fastestRepeatWait) + fastestRepeatWait;
    }
    if(isDefined(trace)) {
      if(d > maxHeight) {
        repeatRate = defaultRepeatRate;
        continue;
      }
      if(!isDefined(trace["surfacetype"])) {
        trace["surfacetype"] = "dirt";
      }
      if(isDefined(self.treadfx[trace["surfacetype"]])) {
        playFX(0, self.treadfx[trace["surfacetype"]], trace["position"]);
      } else {
        println("SCRIPT PRINT: Unknown surface type " + trace["surfacetype"] + " for vehicle type " + self.vehicletype);
        return;
      }
    }
  }
}
vehicle_weapon_fired() {
  self endon("entityshutdown");
  level endon("save_restore");
  shock_distance = 400 * 400;
  rumble_distance = 500 * 500;
  while(true) {
    self waittill("weapon_fired");
    players = getlocalplayers();
    for(i = 0; i < players.size; i++) {
      player_distance = DistanceSquared(self.origin, players[i].origin);
      if(player_distance < rumble_distance) {
        if(isDefined(self.shootrumble) && self.shootrumble != "") {
          PlayRumbleOnPosition(i, self.shootrumble, self.origin + (0, 0, 32));
        }
      }
      if(player_distance < shock_distance) {
        fraction = player_distance / shock_distance;
        time = 4 - (3 * fraction);
        if(isDefined(players[i])) {
          if(isDefined(self.shootshock) && self.shootshock != "") {
            players[i] ShellShock(i, self.shootshock, time);
          }
        }
      }
    }
  }
}
delete_rotor_fx_on_save_restore(localClientNum) {
  self endon("entityshutdown");
  level waittill("save_restore");
  if(isDefined(self.rotorMainfxHandle_saved)) {
    DeleteFX(localClientNum, self.rotorMainfxHandle_saved);
  }
  if(isDefined(self.rotorTailfxHandle_saved)) {
    DeleteFX(localClientNum, self.rotorTailfxHandle_saved);
  }
}
play_rotor_fx(localClientNum) {
  self endon("entityshutdown");
  level endon("save_restore");
  PrintLn("prfx");
  if(isDefined(self.csf_stationary_rotor) && self.csf_stationary_rotor) {
    PrintLn("prfx falls into prffxstat");
    self play_rotor_fx_stationary(localClientNum);
    return;
  }
  if(isDefined(self.csf_stationary_rotor) && !self.csf_stationary_rotor) {
    PrintLn("prfx plays start up seq.");
    if(isDefined(self.rotorMainStartFxName) && self.rotorMainStartFxName != "") {
      self.rotorMainStartFx = LoadFX(self.rotorMainStartFxName);
      if(isDefined(self.rotorMainStartFx)) {
        self.rotorMainFxHandle = playFXOnTag(localClientNum, self.rotorMainStartFx, self, "main_rotor_jnt");
        self.rotorMainfxHandle_saved = self.rotorMainfxHandle;
      } else {
        println("Client: _vehicles.csc - play_rotor_fx() - main rotor fx for starting is not loaded");
      }
    }
    if(isDefined(self.rotorTailStartFxName) && self.rotorTailStartFxName != "") {
      self.rotorTailStartFx = LoadFX(self.rotorTailStartFxName);
      if(isDefined(self.rotorTailStartFx)) {
        self.rotorTailfxHandle = playFXOnTag(localClientNum, self.rotorTailStartFx, self, "tail_rotor_jnt");
        self.rotorTailfxHandle_saved = self.rotorTailfxHandle;
      } else {
        println("Client: _vehicles.csc - play_rotor_fx_stationary() - tail rotor fx aren't loaded for starting the rotor");
      }
    }
    self notify("stop_exhaust_fx");
    self thread play_exhaust(localClientNum);
    if(isDefined(self.rotorMainStartFxName) && self.rotorMainStartFxName != "") {
      realwait(4.0);
    }
    self vehicle_kill_treads_forever();
    self thread aircraft_dustkick();
    if(isDefined(self.rotorMainStartFxName) && self.rotorMainStartFxName != "") {
      realwait(4.0);
    }
    if(isDefined(self.rotorMainFxHandle)) {
      DeleteFX(localClientNum, self.rotorMainFxHandle);
    }
    if(isDefined(self.rotorTailFxHandle)) {
      DeleteFX(localClientNum, self.rotorTailFxHandle);
    }
  }
  println("rotorMainRunningFxName: " + self.rotorMainRunningFxName);
  println("rotormainrunningfxname: " + self.rotormainrunningfxname);
  if(isDefined(self.rotorMainRunningFxName) && self.rotorMainRunningFxName != "") {
    self.rotorMainRunningFx = LoadFX(self.rotorMainRunningFxName);
    if(isDefined(self.useAlternateRotor) && self.useAlternateRotor) {
      while(!isDefined(level.rotorAlternateRunningFX)) {
        wait(0.05);
      }
      self.rotorMainRunningFX = level.rotorAlternateRunningFX;
      self.useAlternateRotor = false;
    }
    if(isDefined(self.rotorMainRunningFx)) {
      self.rotorMainfxHandle = playFXOnTag(localClientNum, self.rotorMainRunningFx, self, "main_rotor_jnt");
      self.rotorMainfxHandle_saved = self.rotorMainfxHandle;
    } else {
      println("Client: _vehicles.csc - play_rotor_fx() - main rotor fx aren't loaded");
    }
  }
  if(isDefined(self.rotorTailRunningFxName) && self.rotorTailRunningFxName != "") {
    self.rotorTailRunningFx = LoadFX(self.rotorTailRunningFxName);
    if(isDefined(self.rotorTailRunningFx)) {
      self.rotorTailfxHandle = playFXOnTag(localClientNum, self.rotorTailRunningFx, self, "tail_rotor_jnt");
      self.rotorTailfxHandle_saved = self.rotorTailfxHandle;
    } else {
      println("Client: _vehicles.csc - play_rotor_fx() - tail rotor fx aren't loaded");
    }
  }
  PrintLn("script sets csf_stationary to false.");
  self thread csf_stat_rotor_mon();
  self.csf_stationary_rotor = false;
}
csf_stat_rotor_mon() {
  self endon("entityshutdown");
  self waittill("save_restore");
  self.csf_stationary_rotor = undefined;
}
play_rotor_fx_stationary(localClientNum) {
  self endon("entityshutdown");
  level endon("save_restore");
  println("rotorMainIdleFxName: " + self.rotorMainIdleFxName);
  println("rotormainIdlefxname: " + self.rotormainidlefxname);
  if(!isDefined(self.csf_stationary_rotor) || !self.csf_stationary_rotor) {
    if(isDefined(self.rotorMainStopFxName) && self.rotorMainStopFxName != "") {
      self.rotorMainStopFx = LoadFX(self.rotorMainStopFxName);
      if(isDefined(self.rotorMainStopFx)) {
        self.rotorMainFxHandle = playFXOnTag(localClientNum, self.rotorMainStopFx, self, "main_rotor_jnt");
        self.rotorMainfxHandle_saved = self.rotorMainfxHandle;
      } else {
        println("Client: _vehicles.csc - play_rotor_fx_stationary() - main rotor fx for stopping is not loaded");
      }
    }
    if(isDefined(self.rotorTailStopFxName) && self.rotorTailStopFxName != "") {
      self.rotorTailStopFx = LoadFX(self.rotorTailStopFxName);
      if(isDefined(self.rotorTailStopFx)) {
        self.rotorTailfxHandle = playFXOnTag(localClientNum, self.rotorTailStopFx, self, "tail_rotor_jnt");
        self.rotorTailfxHandle_saved = self.rotorTailfxHandle;
      } else {
        println("Client: _vehicles.csc - play_rotor_fx_stationary() - tail rotor fx aren't loaded for stopping the rotor");
      }
    }
    realwait(4);
    self notify("stop_exhaust_fx");
    self vehicle_kill_treads_forever();
    realwait(3.9);
    if(isDefined(self.rotorMainFxHandle)) {
      DeleteFX(localClientNum, self.rotorMainFxHandle);
    }
    if(isDefined(self.rotorTailFxHandle)) {
      DeleteFX(localClientNum, self.rotorTailFxHandle);
    }
  }
  if(isDefined(self.rotorMainIdleFxName) && self.rotorMainIdleFxName != "") {
    self.rotorMainIdleFx = LoadFX(self.rotorMainIdleFxName);
    if(isDefined(self.rotorMainIdleFx)) {
      self.rotorMainfxHandle = playFXOnTag(localClientNum, self.rotorMainIdleFx, self, "main_rotor_jnt");
      self.rotorMainfxHandle_saved = self.rotorMainfxHandle;
    } else {
      println("Client: _vehicles.csc - play_rotor_fx_stationary() - main rotor fx aren't loaded");
    }
  }
  if(isDefined(self.rotorTailIdleFxName) && self.rotorTailIdleFxName != "") {
    self.rotorTailIdleFx = LoadFX(self.rotorTailIdleFxName);
    if(isDefined(self.rotorTailIdleFx)) {
      self.rotorTailfxHandle = playFXOnTag(localClientNum, self.rotorTailIdleFx, self, "tail_rotor_jnt");
      self.rotorTailfxHandle_saved = self.rotorTailfxHandle;
    } else {
      println("Client: _vehicles.csc - play_rotor_fx_stationary() - tail rotor fx aren't loaded");
    }
  }
  PrintLn("Script sets csf_stationary to true.");
  self.csf_stationary_rotor = true;
}
loop_rotor_fx(localClientNum, effect, attachTag) {
  self endon("entityshutdown");
  level endon("save_restore");
  assert(isDefined(effect));
  if(isDefined(level._customRotorFx)) {
    self thread[[level._customRotorFx]](localClientNum);
    return;
  }
  while(true) {
    if(!isDefined(self)) {
      break;
    }
    fxHandle = playFXOnTag(localClientNum, effect, self, attachTag);
    realwait(0.01);
    while(IsFXPlaying(localClientNum, fxHandle)) {
      realwait(0.01);
    }
  }
}
vehicle_clientmain(localClientNum) {
  switch (self.vehicletype) {
    case "uaz":
    case "cobra":
    case "jeep":
    case "willys":
      break;
    default:
      break;
  }
}
headlights_on(localClientNum) {
  if(self.vehicletype == "police") {
    self.headlightFX = LoadFX("vehicle/light/fx_cuba_police_headlight");
    self.frontDLightFX = LoadFX("maps/cuba/fx_cuba_veh_front_end_lights");
    if(!isDefined(self.frontDLightFXHandle)) {
      self.frontDLightFXHandle = playFXOnTag(localClientNum, self.frontDLightFX, self, "tag_origin_animate_jnt");
    }
  } else if(self.vehicletype == "cuba_player") {
    return;
  } else {
    self.headlightFX = LoadFX("vehicle/light/fx_jeep_uaz_headlight");
  }
  if(!isDefined(self.headlightLeftFXHandle)) {
    self.headlightLeftFXHandle = playFXOnTag(localClientNum, self.headlightFX, self, "tag_headlight_left");
  }
  if(!isDefined(self.headlightRightFXHandle)) {
    self.headlightRightFXHandle = playFXOnTag(localClientNum, self.headlightFX, self, "tag_headlight_right");
  }
}
headlights_off(localClientNum) {
  if(isDefined(self.headlightLeftFXHandle)) {
    DeleteFX(localClientNum, self.headlightLeftFXHandle);
    self.headlightLeftFXHandle = undefined;
  }
  if(isDefined(self.headlightRightFXHandle)) {
    DeleteFX(localClientNum, self.headlightRightFXHandle);
    self.headlightRightFXHandle = undefined;
  }
  if(isDefined(self.frontDLightFXHandle)) {
    DeleteFX(localClientNum, self.frontDLightFXHandle);
    self.frontDLightFXHandle = undefined;
  }
}
taillights_on(localClientNum) {
  if(self.vehicletype == "police") {
    self.taillightLeftFX = LoadFX("vehicle/light/fx_cuba_police_taillight_left");
    self.taillightRightFX = LoadFX("vehicle/light/fx_cuba_police_taillight_right");
    self.taillightLeftTag = "tag_brakelight_left";
    self.taillightRightTag = "tag_brakelight_right";
  } else if(self.vehicletype == "cuba_player") {
    self.taillightLeftFX = LoadFX("vehicle/light/fx_cuba_car_brakelight");
    self.taillightLeftTag = "body_animate_jnt";
  } else {
    self.taillightLeftFX = LoadFX("vehicle/light/fx_jeep_uaz_taillight");
    self.taillightRightFX = LoadFX("vehicle/light/fx_jeep_uaz_taillight");
    self.taillightLeftTag = "tag_tail_light_left";
    self.taillightRightTag = "tag_tail_light_right";
  }
  if(!isDefined(self.taillightLeftFXHandle)) {
    self.taillightLeftFXHandle = playFXOnTag(localClientNum, self.taillightLeftFX, self, self.taillightLeftTag);
  }
  if(!isDefined(self.taillightRightFXHandle) && isDefined(self.taillightRightFX)) {
    self.taillightRightFXHandle = playFXOnTag(localClientNum, self.taillightRightFX, self, self.taillightRightTag);
  }
}
taillights_off(localClientNum) {
  if(isDefined(self.taillightLeftFXHandle)) {
    DeleteFX(localClientNum, self.taillightLeftFXHandle);
    self.taillightLeftFXHandle = undefined;
  }
  if(isDefined(self.taillightRightFXHandle)) {
    DeleteFX(localClientNum, self.taillightRightFXHandle);
    self.taillightRightFXHandle = undefined;
  }
}
interior_lights_on(localClientNum) {
  if(self.vehicletype == "police") {
    self.interiorLightFX = LoadFX("maps/cuba/fx_cuba_veh_interior_lights");
    self.interiorLightTag = "tag_origin_animate_jnt";
    if(!isDefined(self.interiorLightFXHandle)) {
      self.interiorLightFXHandle = playFXOnTag(localClientNum, self.interiorLightFX, self, self.interiorLightTag);
    }
  }
}
interior_lights_off(localClientNum) {
  if(isDefined(self.interiorLightFXHandle)) {
    DeleteFX(localClientNum, self.interiorLightFXHandle);
    self.interiorLightFXHandle = undefined;
  }
}
sirenlights_on(localClientNum) {
  if(!isDefined(self.sirenlightFXHandle)) {
    self.sirenlightFX = LoadFX("maps/cuba/fx_cuba_siren_light");
    self.sirenlightFXHandle = playFXOnTag(localClientNum, self.sirenlightFX, self, "tag_origin_animate_jnt");
  }
}
sirenlights_off(localClientNum) {
  if(isDefined(self.sirenlightFXHandle)) {
    DeleteFX(localClientNum, self.sirenlightFXHandle);
    self.sirenlightFXHandle = undefined;
  }
}
vehicle_flag_toggle_sounds(localClientNum, set, newEnt) {
  if(self is_helicopter()) {
    if(set) {
      self notify("stop_heli_sounds");
      self.should_not_play_sounds = true;
    } else {
      self notify("play_heli_sounds");
      self.should_not_play_sounds = false;
    }
  } else {}
}
vehicle_flag_turn_off_treadfx(localClientNum, set, newEnt) {
  if(self is_helicopter() || self is_plane()) {
    PrintLn("****CLIENT:: Vehicle Flag Plane");
    if(set) {
      if(isDefined(newEnt) && newEnt) {
        self.csf_no_tread = true;
      } else {
        self vehicle_kill_treads_forever();
      }
    } else {
      if(isDefined(self.csf_no_tread)) {
        self.csf_no_tread = false;
      }
      self vehicle_kill_treads_forever();
      self thread aircraft_dustkick();
    }
  } else {
    if(set) {
      PrintLn("****CLIENT:: Vehicle Flag Tread FX Set");
      if(isDefined(newEnt) && newEnt) {
        PrintLn("****CLIENT:: TreadFX NewEnt: " + self GetEntityNumber());
        self.csf_no_tread = true;
      } else {
        PrintLn("****CLIENT:: TreadFX OldEnt" + self GetEntityNumber());
        self vehicle_kill_treads_forever();
      }
    } else {
      PrintLn("****CLIENT:: Vehicle Flag Tread FX Clear");
      if(isDefined(self.csf_no_tread)) {
        self.csf_no_tread = false;
      }
      self vehicle_kill_treads_forever();
      self thread vehicle_treads(localClientNum);
    }
  }
}
vehicle_flag_switch_rotor_fx(localClientNum, set, newEnt) {
  if(set) {
    if(isDefined(newEnt) && newEnt) {
      self.useAlternateRotor = true;
    } else if(!isDefined(level.rotorAlternateRunningFX)) {
      assertmsg("helicopter tried to switch to alternate rotor without defining level.rotorAlternateRunningFX");
    } else {
      self.rotorOldRunningFx = self.rotorMainRunningFX;
      self.rotorMainRunningFx = level.rotorAlternateRunningFX;
      DeleteFX(localClientNum, self.rotorMainfxHandle);
      self.rotorMainfxHandle = playFXOnTag(localClientNum, self.rotorMainRunningFx, self, "main_rotor_jnt");
    }
  } else {
    if(isDefined(self.rotorOldRunningFX)) {
      self.rotorMainRunningFx = self.rotorOldRunningFX;
      DeleteFX(localClientNum, self.rotorMainfxHandle);
      self.rotorMainfxHandle = playFXOnTag(localClientNum, self.rotorMainRunningFx, self, "main_rotor_jnt");
    }
  }
}
vehicle_flag_0_handler(localClientNum, set, newEnt) {
  if(self is_helicopter()) {
    vehicle_flag_switch_rotor_fx(localClientNum, set, newEnt);
  } else {}
}
vehicle_flag_start_stop_rotor_fx(localClientNum, set, newEnt) {
  if(set) {
    if(isDefined(newEnt) && newEnt) {
      PrintLn("Flag sets csf_stationary to true.");
      self.csf_stationary_rotor = true;
    } else {
      DeleteFx(localClientNum, self.rotorMainfxHandle);
      DeleteFx(localClientNum, self.rotorTailfxHandle);
      self play_rotor_fx_stationary(localClientNum);
    }
  } else {
    if(isDefined(newEnt) && newEnt) {
      PrintLn("*** You should bypass spin up.");
    }
    if(isDefined(self.csf_stationary_rotor)) {
      self.csf_stationary_rotor = false;
      PrintLn("Flag sets csf stationary to false.");
    }
    DeleteFx(localClientNum, self.rotorMainfxHandle);
    DeleteFx(localClientNum, self.rotorTailfxHandle);
    self play_rotor_fx(localClientNum);
  }
}
vehicle_flag_1_handler(localClientNum, set, newEnt) {
  if(self is_helicopter()) {
    vehicle_flag_start_stop_rotor_fx(localClientNum, set, newEnt);
  } else {}
}
vehicle_flag_start_use_engine_damage_low_sounds(localClientNum, set, newEnt) {
  if(set) {
    self.engine_damage_low = true;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  } else {
    self.engine_damage_low = false;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  }
}
vehicle_flag_3_handler(localClientNum, set, newEnt) {
  if(self is_helicopter()) {
    vehicle_flag_start_use_engine_damage_low_sounds(localClientNum, set, newEnt);
  } else {}
}
vehicle_flag_start_use_engine_damage_high_sounds(localClientNum, set, newEnt) {
  if(set) {
    self.engine_damage_high = true;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  } else {
    self.engine_damage_high = false;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  }
}
vehicle_flag_4_handler(localClientNum, set, newEnt) {
  if(self is_helicopter()) {
    vehicle_flag_start_use_engine_damage_high_sounds(localClientNum, set, newEnt);
  } else {}
}
vehicle_flag_change_treadfx_handler(localClientNum, set, newEnt) {
  if(set) {} else {}
}
vehicle_flag_toggle_exhaustfx_handler(localClientNum, set, newEnt) {
  if(set) {
    if(isDefined(newEnt) && newEnt) {
      self.csf_no_exhaust = true;
    } else {
      self notify("stop_exhaust_fx");
    }
  } else {
    if(isDefined(self.csf_no_exhaust)) {
      self.csf_no_exhaust = false;
    }
    self notify("stop_exhaust_fx");
    if(!self is_plane() && !self is_helicopter() && level.usetreadfx == 1) {
      self thread playTankExhaust(localClientNum);
    } else if(!self is_plane()) {
      self thread play_exhaust(localClientNum);
    }
  }
}
vehicle_flag_change_exhaustfx_handler(localClientNum, set, newEnt) {
  if(set) {} else {}
}
vehicle_flag_toggle_lights_handler(localClientNum, set, newent) {
  if(set) {
    self headlights_on(localClientNum);
    self taillights_on(localClientNum);
  } else {
    self headlights_off(localClientNum);
    self taillights_off(localClientNum);
  }
}
vehicle_flag_toggle_siren_lights_handler(localClientNum, set, newent) {
  if(set) {
    self sirenlights_on(localClientNum);
  } else {
    self sirenlights_off(localClientNum);
  }
}
vehicle_flag_toggle_interior_lights_handler(localClientNum, set, newent) {
  if(set) {
    self interior_lights_on(localClientNum);
  } else {
    self interior_lights_off(localClientNum);
  }
}