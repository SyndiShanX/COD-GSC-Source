/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_plane.gsc
******************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

kPlaneHealth = 800;

init() {
  if(!isDefined(level.planes)) {
    level.planes = [];
  }

  if(!isDefined(level.planeConfigs)) {
    level.planeConfigs = [];
  }

  level.fighter_deathfx = LoadFX("vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary");
  level.fx_airstrike_afterburner = loadfx("vfx/gameplay/mp/killstreaks/vfx_air_superiority_afterburner");
  level.fx_airstrike_contrail = loadfx("vfx/gameplay/mp/killstreaks/vfx_aircraft_contrail");
  level.fx_airstrike_wingtip_light_green = LoadFX("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_green");
  level.fx_airstrike_wingtip_light_red = LoadFX("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_red");
}

getFlightPath(coord, directionVector, planeHalfDistance, absoluteHeight, planeFlyHeight, planeFlySpeed, attackDistance, streakName) {
  startPoint = coord + (directionVector * (-1 * planeHalfDistance));
  endPoint = coord + (directionVector * planeHalfDistance);

  if(absoluteHeight) {
    startPoint *= (1, 1, 0);
    endPoint *= (1, 1, 0);
  }

  startPoint += (0, 0, planeFlyHeight);
  endPoint += (0, 0, planeFlyHeight);

  d = length(startPoint - endPoint);
  flyTime = (d / planeFlySpeed);

  d = abs(0.5 * d + attackDistance);
  attackTime = (d / planeFlySpeed);

  assert(flyTime > attackTime);

  flightPath["startPoint"] = startPoint;
  flightPath["endPoint"] = endPoint;
  flightPath["attackTime"] = attackTime;
  flightPath["flyTime"] = flyTime;

  return flightPath;
}

doFlyby(lifeId, owner, requiredDeathCount, startPoint, endPoint, attackTime, flyTime, directionVector, streakName) {
  plane = planespawn(lifeId, owner, startPoint, directionVector, streakName);

  plane endon("death");

  endPathRandomness = 150;
  pathEnd = endPoint + ((RandomFloat(2) - 1) * endPathRandomness, (RandomFloat(2) - 1) * endPathRandomness, 0);

  plane planeMove(pathEnd, flyTime, attackTime, streakName);

  plane planecleanup();
}

planespawn(lifeId, owner, startPoint, directionVector, streakName) {
  if(!isDefined(owner)) {
    return;
  }
  startPathRandomness = 100;
  pathStart = startPoint + ((RandomFloat(2) - 1) * startPathRandomness, (RandomFloat(2) - 1) * startPathRandomness, 0);

  configData = level.planeConfigs[streakName];

  plane = undefined;

  plane = spawn("script_model", pathStart);
  plane.team = owner.team;
  plane.origin = pathStart;
  plane.angles = VectorToAngles(directionVector);
  plane.lifeId = lifeId;
  plane.streakName = streakName;
  plane.owner = owner;

  plane setModel(configData.modelNames[owner.team]);

  if(isDefined(configData.compassIconFriendly)) {
    plane setObjectiveIcons(configData.compassIconFriendly, configData.compassIconEnemy);
  }

  plane thread handleDamage();
  plane thread handleDeath();

  startTrackingPlane(plane);

  if(!isDefined(configData.noLightFx)) {
    plane thread playPlaneFx();
  }
  plane playLoopSound(configData.inboundSfx);

  plane createKillCam(streakName);

  return plane;
}

planeMove(destination, flyTime, attackTime, streakName) {
  configData = level.planeConfigs[streakName];

  self MoveTo(destination, flyTime, 0, 0);

  if(isDefined(configData.onAttackDelegate)) {
    self thread[[configData.onAttackDelegate]](destination, flyTime, attackTime, self.owner, streakName);
  }

  if(isDefined(configData.sonicBoomSfx)) {
    self thread playSonicBoom(configData.sonicBoomSfx, 0.5 * flyTime);
  }

  wait(0.65 * flyTime);

  if(isDefined(configData.outboundSfx)) {
    self StopLoopSound();
    self playLoopSound(configData.outboundSfx);
  }

  if(isDefined(configData.outboundFlightAnim)) {
    self ScriptModelPlayAnimDeltaMotion(configData.outboundFlightAnim);
  }

  wait(0.35 * flyTime);
}

planeCleanup() {
  configData = level.planeConfigs[self.streakName];

  if(isDefined(configData.onFlybyCompleteDelegate)) {
    thread[[configData.onFlybyCompleteDelegate]](self.owner, self, self.streakName);
  }

  if(isDefined(self.friendlyTeamId)) {
    _objective_delete(self.friendlyTeamId);
    _objective_delete(self.enemyTeamID);
  }

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt Delete();
  }

  stopTrackingPlane(self);

  self notify("delete");
  self delete();
}

handleEMP(owner) {
  self endon("death");

  while(true) {
    if(owner isEMPed()) {
      self notify("death");
      return;
    }

    level waittill("emp_update");
  }
}

handleDeath() {
  level endon("game_ended");
  self endon("delete");

  self waittill("death");

  forward = anglesToForward(self.angles) * 200;
  playFX(level.fighter_deathfx, self.origin, forward);

  self thread planeCleanup();
}

handleDamage() {
  selfendon("end_remote");

  self maps\mp\gametypes\_damage::monitorDamage(
    kPlaneHealth,
    "helicopter", ::handleDeathDamage, ::modifyDamage,
    true
  );
}

modifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

handleDeathDamage(attacker, weapon, type, damage) {
  config = level.planeConfigs[self.streakName];

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, config.xpPopup, config.destroyedVO, config.callout);

  maps\mp\gametypes\_missions::checkAAChallenges(attacker, self, weapon);
}

playPlaneFX() {
  self endon("death");

  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip");
}

getPlaneFlyHeight() {
  heightEnt = GetEnt("airstrikeheight", "targetname");
  if(isDefined(heightEnt)) {
    return heightEnt.origin[2];
  } else {
    println("NO DEFINED AIRSTRIKE HEIGHT SCRIPT_ORIGIN IN LEVEL");
    planeFlyHeight = 950;
    if(isDefined(level.airstrikeHeightScale)) {
      planeFlyHeight *= level.airstrikeHeightScale;
    }

    return planeFlyHeight;
  }
}

getPlaneFlightPlan(distFromPlayer) {
  result = spawnStruct();
  result.height = getPlaneFlyHeight();

  heightEnt = GetEnt("airstrikeheight", "targetname");
  if(isDefined(heightEnt) &&
    isDefined(heightEnt.script_noteworthy) &&
    heightEnt.script_noteworthy == "fixedposition"
  ) {
    result.targetPos = heightEnt.origin;
    result.flightDir = anglesToForward(heightEnt.angles);
    if(RandomInt(2) == 0) {
      result.flightDir *= -1;
    }
  } else {
    forwardVec = anglesToForward(self.angles);
    rightVec = AnglesToRight(self.angles);
    result.targetPos = self.origin + distFromPlayer * forwardVec;
    result.flightDir = -1 * rightVec;
  }

  return result;
}

getExplodeDistance(height) {
  standardHeight = 850;
  standardDistance = 1500;
  distanceFrac = standardHeight / height;

  newDistance = distanceFrac * standardDistance;

  return newDistance;
}

startTrackingPlane(obj) {
  entNum = obj GetEntityNumber();
  level.planes[entNum] = obj;
}

stopTrackingPlane(obj) {
  entNum = obj GetEntityNumber();
  level.planes[entNum] = undefined;
}

selectAirstrikeLocation(lifeId, streakname, doStrikeFn) {
  targetSize = level.mapSize / 6.46875;
  if(level.splitscreen) {
    targetSize *= 1.5;
  }

  config = level.planeConfigs[streakname];
  if(isDefined(config.selectLocationVO)) {
    self PlayLocalSound(game["voice"][self.team] + config.selectLocationVO);
  }

  self _beginLocationSelection(streakname, "map_artillery_selector", config.chooseDirection, targetSize);

  self endon("stop_location_selection");

  self waittill("confirm_location", location, directionYaw);

  if(!config.chooseDirection) {
    directionYaw = randomint(360);
  }

  self setblurforplayer(0, 0.3);

  if(isDefined(config.inboundVO)) {
    self PlayLocalSound(game["voice"][self.team] + config.inboundVO);
  }

  self thread[[doStrikeFn]](lifeId, location, directionYaw, streakName);

  return true;
}

setObjectiveIcons(friendlyIcon, enemyIcon) {
  friendlyTeamId = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(friendlyTeamId, "active", (0, 0, 0), friendlyIcon);
  Objective_OnEntityWithRotation(friendlyTeamId, self);
  self.friendlyTeamId = friendlyTeamId;

  enemyTeamID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(enemyTeamID, "active", (0, 0, 0), enemyIcon);
  Objective_OnEntityWithRotation(enemyTeamID, self);
  self.enemyTeamID = enemyTeamID;

  if(level.teamBased) {
    Objective_Team(friendlyTeamId, self.team);
    Objective_Team(enemyTeamID, getOtherTeam(self.team));
  } else {
    ownerEntityNum = self.owner GetEntityNumber();
    Objective_PlayerTeam(friendlyTeamId, ownerEntityNum);
    Objective_PlayerEnemyTeam(enemyTeamID, ownerEntityNum);
  }
}

playSonicBoom(soundName, delay) {
  self endon("death");

  wait(delay);

  self PlaySoundOnMovingEnt(soundName);
}

createKillCam(streakName) {
  configData = level.planeConfigs[streakName];

  if(isDefined(configData.killCamOffset)) {
    planedir = anglesToForward(self.angles);

    killCamEnt = spawn("script_model", self.origin + (0, 0, 100) - planedir * 200);
    killCamEnt.startTime = GetTime();
    killCamEnt SetScriptMoverKillCam("airstrike");
    killCamEnt LinkTo(self, "tag_origin", configData.killCamOffset, (0, 0, 0));

    self.killCamEnt = killCamEnt;
  }
}