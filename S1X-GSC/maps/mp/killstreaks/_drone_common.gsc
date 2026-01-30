/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_drone_common.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

CONST_cloak_duration = 10;
CONST_cloak_cooldown_min_duration = 5;

droneGetSpawnPoint(eyeZOffset) {
  if(!isDefined(eyeZOffset)) {
    eyeZOffset = 50;
  }

  forwardOffset = 75;
  trace_radius = 23;
  trace_height = trace_radius * 2;

  eye = (self.origin + (0, 0, eyeZOffset));
  angles = self getplayerangles();
  forward = anglesToForward(flat_angle(angles));

  end = eye + (forward * forwardOffset);

  spawnOrigin = end;
  spawnAngles = self.angles;

  placementOK = true;

  offset = getSpawnInWaterOffset(spawnOrigin + (0, 0, -1 * 30));
  if(isDefined(offset) && offset > 0) {
    spawnOrigin += (0, 0, offset);
    eye += (0, 0, offset);
  } else if(!isDefined(offset)) {
    placementOK = false;
  }

  if(placementOK && !SightTracePassed(eye, end, true, self)) {
    placementOK = false;
  }

  if(placementOK) {
    trace = bulletTrace(eye, end, true, self, true, false, true, true, true);
    if(trace["fraction"] < 1) {
      placementOK = false;
    }
  }

  if(placementOK) {
    start = eye + (0, 0, trace_height * -0.5);
    end = end + (0, 0, trace_height * -0.5);

    trace = self AIPhysicsTrace(start, end, trace_radius, trace_height, false, true);
    if(trace["fraction"] < 1) {
      placementOK = false;
    }
  }

  results = spawnStruct();
  results.placementOK = placementOK;
  results.origin = spawnOrigin;
  results.angles = spawnAngles;

  return results;
}

getSpawnInWaterOffset(spawnOrigin) {
  triggers = getEntArray("trigger_underwater", "targetname");
  if(triggers.size == 0) {
    return 0;
  }

  MAX_UNITS_UP = 200;
  unitsUp = 0;
  testOrigin = spawn("script_origin", spawnOrigin);
  touchingWater = false;
  while(unitsUp < MAX_UNITS_UP) {
    if(touchingWaterTriggers(testOrigin, triggers)) {
      unitsUp += 10;
      testOrigin.origin += (0, 0, 10);
    } else {
      break;
    }
  }

  testOrigin Delete();

  if(unitsUp >= MAX_UNITS_UP) {
    return undefined;
  } else {
    return unitsUp;
  }
}

touchingWaterTriggers(ent, triggers) {
  for(i = 0; i < triggers.size; i++) {
    trigger = triggers[i];
    if(ent IsTouching(trigger)) {
      return true;
    }
  }

  return false;
}

droneAddToGlobalList(entNum) {
  level.ugvs[entNum] = self;
}

droneRemoveFromGlobalList(entNum) {
  level.ugvs[entNum] = undefined;
}

droneInitCloakOmnvars() {}

droneSetupCloaking(vehicle, startAsCloaked) {
  vehicle endon("death");

  droneInitCloakOmnvars();
  vehicle.cloakState = 0;
  vehicle.CloakCooldown = 0;
  self droneCloakingTransition(vehicle, true, true);
  maps\mp\killstreaks\_killstreaks::playerWaittillRideKillstreakComplete();
  if(isDefined(startAsCloaked) && startAsCloaked) {
    self thread droneMonitorDamageWhileCloaking(vehicle);
    self SetClientOmnvar("ui_drone_cloak", 2);

    cloakMS = CONST_cloak_duration * 1000;
    cloakEndTime = GetTime() + cloakMS;
    self SetClientOmnvar("ui_drone_cloak_time", cloakEndTime);

    vehicle.CloakCooldown = CONST_cloak_cooldown_min_duration;
    thread CloakCooldown(vehicle);
    self thread droneCloakWaitForExit(vehicle);
  } else {
    vehicle playSound("recon_drn_cloak_deactivate");
    self droneCloakingTransition(vehicle, false);
  }
}

droneIsCloaked(vehicle) {
  return (vehicle.hasCloak && vehicle.cloakState >= 0);
}

droneCloakReady(vehicle, startAsCloaked) {
  vehicle endon("death");

  if(isDefined(startAsCloaked) && startAsCloaked) {
    thread droneCloakCooldown(vehicle);
    self waittill("CloakCharged");
  }

  while(true) {
    self SetClientOmnvar("ui_drone_cloak", 1);

    thread droneCloakActivated(vehicle);
    thread droneCloakCooldown(vehicle);

    if(vehicle.CloakCooldown != 0) {
      self SetClientOmnvar("ui_drone_cloak", 3);
      wait vehicle.CloakCooldown;
    }

    if(vehicle.hasCloak) {
      self SetClientOmnvar("ui_drone_cloak", 1);
    }

    vehicle waittill("Cloak");

    vehicle notify("ActivateCloak");

    vehicle playSound("recon_drn_cloak_activate");

    self waittill("CloakCharged");
  }
}

droneCloakActivated(vehicle) {
  vehicle endon("death");

  vehicle waittill("ActivateCloak");

  self thread droneCloakingTransition(vehicle, true);
  self thread droneMonitorDamageWhileCloaking(vehicle);

  cloakMS = CONST_cloak_duration * 1000;
  cloakEndTime = GetTime() + cloakMS;
  self SetClientOmnvar("ui_drone_cloak_time", cloakEndTime);

  self SetClientOmnvar("ui_drone_cloak", 2);

  vehicle.CloakCooldown = CONST_cloak_cooldown_min_duration;
  thread CloakCooldown(vehicle);
  self thread droneCloakWaitForExit(vehicle);
}

droneCloakCooldown(vehicle) {
  vehicle endon("death");

  self waittill("UnCloak");

  vehicle playSound("recon_drn_cloak_deactivate");
  self thread droneCloakingTransition(vehicle, false);

  self SetClientOmnvar("ui_drone_cloak", 3);

  self thread droneCloakDeactivatedDialog(vehicle);
}

CloakCooldown(vehicle) {
  vehicle endon("death");

  self waittill("UnCloak");

  while(vehicle.CloakCooldown > 0) {
    vehicle.CloakCooldown -= 0.5;
    wait 0.5;
  }

  vehicle.CloakCooldown = 0;
  self notify("CloakCharged");
}

droneCloakWaitForExit(vehicle) {
  vehicle endon("death");

  start = GetTime();
  self waittill_any_timeout_no_endon_death(CONST_cloak_duration, "ForceUncloak", "Cloak");
  end = GetTime();
  cooldownDuration = max((end - start), CONST_cloak_cooldown_min_duration * 1000);
  vehicle.CloakCooldown = cooldownDuration / 1000;

  cooldownEnd = GetTime() + cooldownDuration;
  self SetClientOmnvar("ui_drone_cloak_cooldown", cooldownEnd);

  self notify("UnCloak");
}

droneCloakingTransition(vehicle, enable, init) {
  vehicle notify("cloaking_transition");
  vehicle endon("cloaking_transition");
  vehicle endon("death");

  if(enable) {
    if(vehicle.cloakState == -2) {
      return;
    }

    vehicle.cloakState = -1;
    vehicle CloakingEnable();
    if(isDefined(vehicle.mgTurret)) {
      vehicle.mgTurret CloakingEnable();
    }
    vehicle Vehicle_SetMinimapVisible(false);
    if(!isDefined(init) || !init) {
      wait 2.2;
    } else {
      wait 1.5;
    }
    vehicle Show();
    if(isDefined(vehicle.mgTurret)) {
      vehicle.mgTurret Show();
    }
    vehicle.cloakState = -2;
  } else {
    if(vehicle.cloakState == 2) {
      return;
    }

    vehicle.cloakState = 1;
    vehicle CloakingDisable();
    vehicle Vehicle_SetMinimapVisible(true);
    if(isDefined(vehicle.mgTurret)) {
      vehicle.mgTurret CloakingDisable();
    }
    wait 2.2;
    vehicle.cloakState = 2;
  }
}

droneCloakDeactivatedDialog(vehicle) {
  vehicle endon("death");
  self endon("CloakCharged");

  while(true) {
    self waittill("Cloak");

    self playlocalsound("recon_drn_cloak_notready");

    wait 1;
  }
}

droneMonitorDamageWhileCloaking(vehicle) {
  vehicle endon("death");
  self endon("UnCloak");

  wait 1;

  vehicle waittill("damage");
  self notify("ForceUncloak");
}

updateShootingLocation(vehicle, effect, ignoreTurret) {
  vehicle endon("death");
  self endon("disconnect");
  vehicle endon("stopShootLocationUpdate");

  vehicle.targetEnt = spawn("script_model", (0, 0, 0));
  vehicle.targetEnt setModel("tag_origin");
  vehicle.targetEnt.angles = (-90, 0, 0);

  if(isDefined(vehicle.mgTurret) && (!isDefined(ignoreTurret) || !ignoreTurret)) {
    vehicle.mgTurret SetTargetEntity(vehicle.targetEnt);
    vehicle.mgTurret TurretSetGroundAimEntity(vehicle.targetEnt);
  } else {
    vehicle SetOtherEnt(vehicle.targetEnt);
  }

  thread _cleanupShootingLocationOnDeath(vehicle, effect);

  if(isDefined(effect)) {
    PlayFXOnTagForClients(effect, vehicle.targetEnt, "tag_origin", self);
    vehicle thread showReticleToEnemies(effect);
  }

  if(isDefined(vehicle.hasAIOption) && vehicle.hasAIOption) {
    return;
  }

  while(true) {
    start = self GetViewOrigin();
    angles = self GetPlayerAngles();
    forward = anglesToForward(angles);
    end = start + (forward * 8000);
    traceResult = bulletTrace(start, end, false, vehicle);
    vehicle.targetEnt.origin = traceResult["position"];
    waitframe();
  }
}

showReticleToEnemies(effect) {
  self endon("death");
  self endon("end_remote");

  if(!level.hardcoreMode) {
    foreach(player in level.players) {
      if(self.owner isEnemy(player)) {
        waitframe();
        PlayFXOnTagForClients(effect, self.targetEnt, "tag_origin", player);
      }
    }
  }
}

_cleanupShootingLocationOnDeath(vehicle, effect) {
  vehicle waittill_any("death", "stopShootLocationUpdate");

  if(isDefined(vehicle.targetEnt)) {
    targetEnt = vehicle.targetEnt;
    if(isDefined(effect)) {
      stopFXOnTag(effect, targetEnt, "tag_origin");
    }
    waitframe();
    targetEnt delete();
  }
}

playerHandleExhaustFx(vehicle, effectRef, tag, playerEndonString) {
  vehicle endon("death");
  if(isDefined(playerEndonString)) {
    self endon(playerEndonString);
  }

  playFXOnTag(getfx(effectRef), vehicle, tag);

  self thread playerDeleteExhaustFxOnVehicleDeath(vehicle, effectRef, tag);

  if(!vehicle.hasCloak) {
    return;
  }

  while(true) {
    self waittill("Cloak");
    stopFXOnTag(getfx(effectRef), vehicle, tag);
    waitframe();
    PlayFXOnTagForClients(getfx(effectRef), vehicle, tag, self);

    self waittill("UnCloak");
    stopFXOnTag(getfx(effectRef), vehicle, tag);
    waitframe();
    playFXOnTag(getfx(effectRef), vehicle, tag);
  }
}

playerDeleteExhaustFxOnVehicleDeath(vehicle, effectRef, tag) {
  vehicle waittill("death");

  KillFXOnTag(getfx(effectRef), vehicle, tag);
}

setDroneVisionAndLightSetPerMap(delay, vehicle) {
  self endon("disconnect");
  vehicle endon("death");

  wait(delay);

  if(isDefined(level.droneVisionSet)) {
    self SetClientTriggerVisionSet(level.droneVisionSet, 0);
  }

  if(isDefined(level.droneLightSet)) {
    self LightSetForPlayer(level.droneLightSet);
  }
}

removeDroneVisionAndLightSetPerMap(delay) {
  self SetClientTriggerVisionSet("", delay);
  self LightSetForPlayer("");
}

playerWatchForDroneEMP(vehicle) {
  level endon("game_ended");
  vehicle endon("death");
  self endon("assaultDroneHunterKiller");

  vehicle waittill("emp_damage");

  vehicle notify("death");
}