/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_airstrike.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_airsupport;

init() {
  precacheModel("projectile_cbu97_clusterbomb");
  precacheItem("airstrike_mp");
  level.airstrikeModel = "t5_veh_air_b52";
  precacheModel(level.airstrikeModel);
  PrecacheRumble("rolling_thunder_rumble");
  PrecacheRumble("artillery_rumble");
  precacheLocationSelector("map_airstrike_selector");
  level.airstrikeBombCount = 15;
  level.airstrikeDangerMaxRadius = 750;
  level.airstrikeDangerMinRadius = 300;
  level.airstrikeDangerForwardPush = 1.5;
  level.airstrikeDangerOvalScale = 6.0;
  level.airstrikeMapRange = level.airstrikeDangerMinRadius * .3 + level.airstrikeDangerMaxRadius * .7;
  level.airstrikeDangerMaxRadiusSq = level.airstrikeDangerMaxRadius * level.airstrikeDangerMaxRadius;
  level.fx_jet_trail = loadfx("trail/fx_geotrail_jet_contrail");
  level.fx_airstrike_afterburner = loadfx("vehicle/exhaust/fx_exhaust_jet_afterburner");
  level.fx_airstrike_bomb = loadfx("weapon/bombing_run/fx_mp_bombing_run_bomb");
  level.fx_airstrike_bomb = loadfx("vehicle/exhaust/fx_exhaust_b52_bomber");
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowairstrike")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("airstrike_mp", "airstrike_mp", "killstreak_airstrike", "airstrike_used", ::useKillstreakAirstrike, true);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("airstrike_mp", &"KILLSTREAK_EARNED_AIRSTRIKE", &"KILLSTREAK_AIRSTRIKE_NOT_AVAILABLE", &"KILLSTREAK_AIRSTRIKE_INBOUND", &"KILLSTREAK_AIRSTRIKE_INBOUND_NEAR_YOUR_POSITION");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("airstrike_mp", "mpl_killstreak_air", "kls_airstrike_used", "", "kls_airstrike_enemy", "", "kls_airstrike_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("airstrike_mp", "scr_giveairstrike");
  }
}
useKillstreakAirstrike(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  result = self maps\mp\_airstrike::selectAirstrikeLocation(hardpointType);
  if(!isDefined(result) || !result) {
    return false;
  }
  return true;
}
selectAirstrikeLocation(hardpointType) {
  airstrikeSelectorSize = getDvarIntDefault(#"scr_airstrikeSelectorSize", 3000);
  self beginLocationAirstrikeSelection("map_airstrike_selector", airstrikeSelectorSize);
  self.selectingLocation = true;
  self thread endSelectionThink();
  self waittill("confirm_location", location, yaw);
  if(!isDefined(location)) {
    return false;
  }
  yaw = yaw + getnorthyaw();
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  return self finishDualHardpointLocationUsage(location, int(yaw), ::useAirstrike);
}
useAirstrike(pos, yaw) {
  if(self maps\mp\_killstreakrules::killstreakStart("airstrike_mp", self.team) == false) {
    return false;
  }
  trace = bulletTrace(self.origin + (0, 0, 10000), self.origin, false, undefined);
  pos = (pos[0], pos[1], trace["position"][2] - 514);
  if(maps\mp\gametypes\_tweakables::getTweakableValue("team", "allowHardpointStreakAfterDeath")) {
    ownerDeathCount = self.deathCount;
  } else {
    ownerDeathCount = self.pers["hardPointItemDeathCountairstrike_mp"];
  }
  thread doAirstrike(pos, self, self.team, yaw);
  return true;
}
callAirStrike(owner, coord, yaw, planeFlyHeight, startPoint, endPoint) {
  level.airstrikeDamagedEnts = [];
  level.airstrikeDamagedEntsCount = 0;
  level.airstrikeDamagedEntsIndex = 0;
  direction = (0, yaw, 0);
  debugDirection = direction;
  planeBombExplodeDistance = 1500;
  planeFlySpeed = 2000;
  d = length(startPoint - endPoint);
  flyTime = (d / planeFlySpeed);
  d = abs(d / 2 + planeBombExplodeDistance);
  bombTime = (d / planeFlySpeed);
  assert(flyTime > bombTime);
  requiredDeathCount = owner.deathCount;
  level.airstrikeDamagedEnts = [];
  level.airstrikeDamagedEntsCount = 0;
  level.airstrikeDamagedEntsIndex = 0;
  xOffset = sin(yaw) * -1000;
  yOffset = cos(yaw) * 1000;
  level doPlaneStrike(owner, requiredDeathCount, coord, startPoint, endPoint, bombTime, flyTime, direction, debugDirection, planeFlySpeed, planeFlyHeight);
}
getBestPlaneDirection() {
  random = randomint(360);
  random = int(getDvarIntDefault(#"scr_random", random));
  return random;
}
createKillcams(plane, startPoint, destPoint, flyTime) {
  killcamEntities = [];
  killCamCount = 12;
  for(i = 0; i < killCamCount; i++) {
    killcamEntities[killcamEntities.size] = bombrun_killCam(plane, destPoint, flyTime);
  }
  velocity = (destPoint - startPoint) / flyTime;
  thread dropKillcams(plane, velocity, killcamEntities, killCamCount);
  return killcamEntities;
}
bombrun_killCam(plane, pathEnd, flyTime) {
  planedir = anglesToForward(plane.angles);
  planeRight = AnglesToRight(plane.angles);
  offset = (0, 0, 50) - (planedir * 400) - (planeRight * 50);
  origin = plane.origin + offset;
  killCamEnt = spawn("script_model", origin);
  killCamEnt.startTime = gettime();
  killCamEnt thread deleteAfterTime(15.0);
  killCamEnt thread debug_draw_bomb_path(undefined, (0, 0.5, 0));
  killCamEnt.offsetPoint = planedir * 300;
  killCamEnt moveTo(pathEnd + offset, flyTime, 0, 0);
  return killCamEnt;
}
dropKillcams(plane, velocity, killcamEntities, killCamCount) {
  plane endon("death");
  count = 0;
  while(1) {
    plane waittill("drop_killcam", height);
    killcamEntities[count] thread dropKillcam(velocity, height);
    count++;
    if(count >= killCamCount) {
      return;
    }
  }
}
dropKillcam(velocity, height) {
  velocityScale = getDvarFloatDefault(#"scr_killcamVelocityScale", 0.75);
  killcamFallTime = calculateFallTime(height - getDvarFloatDefault(#"scr_airstrikeKillcamStopHeight", 200));
  self MoveGravity(velocity * velocityScale, killcamFallTime);
}
callStrike_bombEffect(plane, bombsite, pathEnd, flyTime, launchTime, owner, requiredDeathCount, planeFlySpeed, planeFlyHeight) {
  bombSpeedScale = 1 / 4;
  bombWait = calculateReleaseTime(flyTime, planeFlyHeight, planeflyspeed, bombSpeedScale);
  bombWait = getDvarIntDefault(#"scr_bombTimer", bombWait);
  bombReleaseWait = getDvarIntDefault(#"scr_bombReleaseWait", 0.2);
  wait(bombWait - (level.airstrikeBombCount / 2 * bombReleaseWait));
  planedir = anglesToForward(plane.angles);
  scaledBy = getDvarIntDefault(#"scr_airstrikeSpeedScale", planeFlySpeed * bombSpeedScale);
  velocity = vector_scale(anglesToForward(plane.angles), scaledBy);
  thread bomberDropBombs(plane, bombsite, owner);
}
bomberDropBombs(plane, bombSite, owner) {
  while(!targetIsClose(plane, bombsite, 5000)) {
    wait(0.05);
  }
  showFx = true;
  sonicBoom = false;
  plane notify("start_bombing");
  count = 0;
  plane SetClientFlag(level.const_flag_bombing);
  for(dist = targetGetDist(plane, bombsite); dist < 5000; dist = targetGetDist(plane, bombsite)) {
    count++;
    bombPoint = getBombPoint(plane.origin);
    bombHeight = distance(plane.origin, bombPoint);
    {
      plane notify("drop_killcam", bombHeight);
    }
    plane thread callStrike_bomb(plane.origin, bombPoint, bombHeight, owner, (0, 0, 0), showFx, count % 1);
    wait(0.45);
  }
  plane ClearClientFlag(level.const_flag_bombing);
  plane notify("stop_bombing");
}
getBombPoint(coord) {
  accuracyRadius = 250;
  randVec = (0, randomint(360), 0);
  bombPoint = coord + vector_multiply(anglesToForward(randVec), randomFloat(accuracyRadius));
  trace = bulletTrace(bombPoint, bombPoint + (0, 0, -10000), false, undefined);
  return trace["position"];
}
callStrike_bomb(coord, bombPoint, bombHeight, owner, offset, showFx, breakGlass) {
  if(!isDefined(owner)) {
    self notify("stop_bombing");
    return;
  }
  if(bombHeight > 5000) {
    return;
  }
  wait(0.95 * (bombHeight / 2000));
  if(!isDefined(owner)) {
    self notify("stop_bombing");
    return;
  }
  airstrikeLOSRadiusDamage(bombPoint + (0, 0, 16), 896, 300, 50, owner, self, "airstrike_mp", breakGlass);
}
doPlaneStrike(owner, requiredDeathCount, bombsite, pathStart, pathEnd, bombTime, flyTime, direction, debugDirection, planeFlySpeed, planeFlyHeight) {
  if(!isDefined(owner)) {
    return;
  }
  plane = SpawnPlane(owner, "script_model", pathStart);
  plane.angles = direction;
  wait(0.2);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] PlayRumbleOnEntity("rolling_thunder_rumble");
  }
  plane setModel(level.airstrikeModel);
  destPoint = getPointOnLine(pathStart, pathEnd, 1.0);
  plane setClientFlag(level.const_flag_airstrike);
  plane moveTo(destPoint, flyTime, 0, 0);
  plane.killcamEntities = createKillcams(plane, pathStart, pathEnd, flyTime);
  thread callStrike_bombEffect(plane, bombsite, pathEnd, flyTime, bombTime - 1.0, owner, requiredDeathCount, planeFlySpeed, planeFlyHeight);
  plane waittill("movedone");
  plane notify("delete");
  plane delete();
}
causeRumble() {
  while(isDefined(self)) {
    position = (self.origin[0], self.origin[1], 0);
    PlayRumbleOnPosition("artillery_rumble", position);
    wait(0.1);
  }
}
airstrikeDamageEntsThread(sWeapon) {
  self notify("airstrikeDamageEntsThread");
  self endon("airstrikeDamageEntsThread");
  for(; level.airstrikeDamagedEntsIndex < level.airstrikeDamagedEntsCount; level.airstrikeDamagedEntsIndex++) {
    if(!isDefined(level.airstrikeDamagedEnts[level.airstrikeDamagedEntsIndex])) {
      continue;
    }
    ent = level.airstrikeDamagedEnts[level.airstrikeDamagedEntsIndex];
    if(!isDefined(ent.entity)) {
      continue;
    }
    if((!ent.isPlayer && !ent.isActor) || isAlive(ent.entity)) {
      ent maps\mp\gametypes\_weapons::damageEnt(
        ent.eInflictor,
        ent.damageOwner,
        ent.damage,
        "MOD_EXPLOSIVE",
        sWeapon,
        ent.pos,
        vectornormalize(ent.damageCenter - ent.pos)
      );
      level.airstrikeDamagedEnts[level.airstrikeDamagedEntsIndex] = undefined;
      if(ent.isPlayer || ent.isActor) {
        wait(0.05);
      }
    } else {
      level.airstrikeDamagedEnts[level.airstrikeDamagedEntsIndex] = undefined;
    }
  }
}
airstrikeLOSRadiusDamage(pos, radius, max, min, owner, eInflictor, sWeapon, breakGlass) {
  ents = maps\mp\gametypes\_weapons::getDamageableEnts(pos, radius, false);
  thread doGlassDamage(pos, radius, max, min, "MOD_EXPLOSIVE");
  self thread checkPlayersTinitus(pos);
  debugstar(pos + (0, 0, 100), 20 * 100, (1, 0.2, 0.2));
  dist = (100 - max) * radius / (min - max);
  for(i = 0; i < ents.size; i++) {
    if(ents[i].entity == self) {
      continue;
    }
    if(entLOSRadiusDamage(ents[i], pos, radius, max, min, owner, eInflictor)) {
      level.airstrikeDamagedEnts[level.airstrikeDamagedEntsCount] = ents[i];
      level.airstrikeDamagedEntsCount++;
    }
  }
  thread airstrikeDamageEntsThread(sWeapon);
}
doAirstrike(origin, owner, team, yaw, height) {
  xOffset = sin(yaw) * -1000;
  yOffset = cos(yaw) * 1000;
  trace = bulletTrace(origin, origin + (0, 0, -4000), false, undefined);
  targetpos = trace["position"];
  maxs = level.spawnMaxs[2] + 200;
  mins = level.spawnMins[2] - 200;
  if(targetpos[2] > maxs) {
    targetpos = (targetpos[0], targetpos[1], maxs);
  } else if(targetpos[2] < mins) {
    targetpos = (targetpos[0], targetpos[1], mins);
  }
  direction = (0, yaw, 0);
  heightIncrease = getDvarIntDefault(#"scr_airstrike_height_increase", 200);
  planeFlyHeight = int(maps\mp\_airsupport::getMinimumFlyHeight()) + heightIncrease;
  planeHalfDistance = 12000;
  startPoint = origin + vector_scale(anglesToForward(direction), -1 * planeHalfDistance);
  endPoint = origin + vector_scale(anglesToForward(direction), planeHalfDistance);
  planeFlyHeight = int(getNoFlyZoneHeightCrossed(startPoint, endPoint, planeFlyHeight));
  startPoint = (startPoint[0], startPoint[1], planeFlyHeight);
  endPoint = (endPoint[0], endPoint[1], planeFlyHeight);
  centerPoint = (origin[0], origin[1], planeFlyHeight);
  owner maps\mp\gametypes\_hardpoints::playKillstreakStartDialog("airstrike_mp", team);
  owner maps\mp\gametypes\_persistence::statAdd("AIRSTRIKE_USED", 1, false);
  level.globalKillstreaksCalled++;
  self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_airstrike", 1, "used");
  if(!isDefined(owner)) {
    maps\mp\_killstreakrules::killstreakStop("airstrike_mp", team);
    return;
  }
  danger_influencer_id = maps\mp\gametypes\_spawning::create_artillery_influencers(targetpos, level.airstrikeDangerMaxRadius * 2.0);
  owner notify("begin_airstrike");
  ownerEntNum = owner GetEntityNumber();
  exitType = 0;
  if(level.teambased) {
    teamType = owner.team;
  } else {
    teamType = "free";
  }
  callAirStrike(owner, targetpos, yaw, planeFlyHeight, startPoint, endPoint);
  maps\mp\_killstreakrules::killstreakStop("airstrike_mp", team);
  removeinfluencer(danger_influencer_id);
}
targetisclose(other, target, closeDist) {
  if(!isDefined(closeDist)) {
    closeDist = 3000;
  }
  infront = targetisinfront(other, target);
  if(infront) {
    dir = 1;
  } else {
    dir = -1;
  }
  a = flat_origin(other.origin);
  b = a + vector_multiply(anglesToForward(flat_angle(other.angles)), (dir * 100000));
  point = pointOnSegmentNearestToPoint(a, b, target);
  dist = distance(a, point);
  if(dist < closeDist) {
    return true;
  } else {
    return false;
  }
}
targetisinfront(other, target) {
  forwardvec = anglesToForward(flat_angle(other.angles));
  normalvec = vectorNormalize(flat_origin(target) - other.origin);
  dot = vectordot(forwardvec, normalvec);
  if(dot > 0) {
    return true;
  } else {
    return false;
  }
}
flat_origin(org) {
  rorg = (org[0], org[1], 0);
  return rorg;
}
flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}
targetGetDist(other, target) {
  infront = targetisinfront(other, target);
  if(infront) {
    dir = 1;
  } else {
    dir = -1;
  }
  a = flat_origin(other.origin);
  b = a + vector_multiply(anglesToForward(flat_angle(other.angles)), (dir * 100000));
  point = pointOnSegmentNearestToPoint(a, b, target);
  dist = distance(a, point);
  return dist;
}
checkPlayersTinitus(bomsite) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    area = 1000 * 1000;
    if(isDefined(bomsite)) {
      if(DistanceSquared(bomsite, players[i].origin) < area) {
        if(isDefined(players[i]) && isplayer(players[i])) {
          players[i] playlocalsound("mpl_kls_exlpo_tinitus");
        }
      }
    }
  }
}