/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_airstrike.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

CONST_AIRSTRIKE_Z_OFFSET_FROM_ANCHOR = 750;
CONST_AIRSTRIKE_FLY_IN_DIST = 10000;
CONST_AIRSTRIKE_FLY_IN_TIME = 3;
CONST_AIRSTRIKE_FLY_THROUGH_DIST = 10000;
CONST_AIRSTRIKE_FLY_THROUGH_TIME = 10;
CONST_AIRSTRIKE_WING_WIDTH = 380;
CONST_AIRSTRIKE_ADDITIONAL_BOMBER_DIST = 500;

init() {
  level._effect["airstrike_ground"] = LoadFX("vfx/explosion/clusterbomb_explode");
  level._effect["airstrike_bombs"] = LoadFX("vfx/explosion/vfx_clusterbomb");
  level._effect["airstrike_death"] = LoadFX("vfx/explosion/vehicle_warbird_explosion_midair");
  level._effect["airstrike_engine"] = LoadFX("vfx/fire/jet_afterburner");
  level._effect["airstrike_wingtip"] = LoadFX("vfx/trail/jet_contrail");

  level.harriers = [];
  level.planes = [];
  level.artilleryDangerCenters = [];

  level.dangerMaxRadius["strafing_run_airstrike"] = 900;
  level.dangerMinRadius["strafing_run_airstrike"] = 750;
  level.dangerForwardPush["strafing_run_airstrike"] = 1;
  level.dangerOvalScale["strafing_run_airstrike"] = 6.0;

  level.killStreakFuncs["strafing_run_airstrike"] = ::tryUseStrafingRunAirstrike;

  level.killstreakWieldWeapons["stealth_bomb_mp"] = "strafing_run_airstrike";
  level.killstreakWieldWeapons["airstrike_missile_mp"] = "strafing_run_airstrike";
  level.killstreakWieldWeapons["orbital_carepackage_pod_plane_mp"] = "strafing_run_airstrike";
}

tryUseStrafingRunAirstrike(lifeId, modules) {
  return tryUseAirstrike(lifeId, "strafing_run_airstrike", modules);
}

tryUseAirstrike(lifeId, streakName, modules) {
  if(isDefined(level.strafing_run_airstrike)) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  result = self selectAirstrikeLocation(lifeId, streakName, modules);

  if(!isDefined(result) || !result) {
    return false;
  }

  return true;
}

debugLocation(trace, location) {
  level notify("debug_airstrike");
  level endon("debug_airstrike");

  while(true) {
    if(GetDvarInt("scr_debugairstrike", 0) == 0) {
      return;
    }

    Print3d(level.mapCenter, "Map Center", (1, 0, 0));
    Print3d(level.mapCenter, "Map Center origin: " + level.mapCenter[0] + ", " + level.mapCenter[1] + ", " + level.mapCenter[2], (1, 0, 0));

    Print3d(location, "Location", (1, 0, 0));
    Print3d(location, "Location origin: " + location[0] + ", " + location[1] + ", " + location[2], (1, 0, 0));

    Print3d(trace["position"], "Trace Position", (1, 0, 0));
    Print3d(trace["position"], "Trace Position origin: " + trace["position"][0] + ", " + trace["position"][1] + ", " + trace["position"][2], (1, 0, 0));

    Line(level.mapCenter, trace["position"], (0, 0, 1));

    wait(0.05);
  }
}

debugFlyHeight(planeFlyHeight) {
  level endon("debug_airstrike");

  while(true) {
    if(GetDvarInt("scr_debugairstrike", 0) == 0) {
      return;
    }

    anglesForward = anglesToForward(level.players[0].angles);
    scalar = (anglesForward[0] * 200, anglesForward[1] * 200, anglesForward[2]);
    Print3d(level.players[0].origin + scalar, "Fly Height: " + planeFlyHeight, (1, 0, 0));
    wait(0.05);
  }
}

doAirstrike(lifeId, origin, yaw, owner, team, streakName, modules) {
  assert(isDefined(origin));
  assert(isDefined(yaw));

  if(isDefined(level.airstrikeInProgress)) {
    while(isDefined(level.airstrikeInProgress)) {
      level waittill("begin_airstrike");
    }

    level.airstrikeInProgress = true;
    wait(2.0);
  }

  if(!isDefined(owner)) {
    return;
  }

  level.airstrikeInProgress = true;

  targetpos = dropSiteTrace(origin, owner);

  dangerCenter = spawnStruct();
  dangerCenter.origin = targetpos;
  dangerCenter.forward = anglesToForward((0, yaw, 0));
  dangerCenter.streakName = streakName;
  dangerCenter.team = team;

  level.artilleryDangerCenters[level.artilleryDangerCenters.size] = dangerCenter;
  level thread debugArtilleryDangerCenters(streakName);

  harrierEnt = callStrike(lifeId, owner, targetpos, yaw, streakName, modules);

  wait(1.0);
  level.airstrikeInProgress = undefined;
  owner notify("begin_airstrike");
  level notify("begin_airstrike");

  wait 7.5;

  found = false;
  newarray = [];
  for(i = 0; i < level.artilleryDangerCenters.size; i++) {
    if(!found && level.artilleryDangerCenters[i].origin == targetpos) {
      found = true;
      continue;
    }

    newarray[newarray.size] = level.artilleryDangerCenters[i];
  }
  assert(found);
  assert(newarray.size == level.artilleryDangerCenters.size - 1);
  level.artilleryDangerCenters = newarray;
}

clearProgress(delay) {
  wait(2.0);

  level.airstrikeInProgress = undefined;
}

debugArtilleryDangerCenters(streakName) {
  level notify("debugArtilleryDangerCenters_thread");
  level endon("debugArtilleryDangerCenters_thread");

  if(getdvarint("scr_airstrikedebug", 0) != 1 && getdvarint("scr_spawnpointdebug", 0) == 0) {
    return;
  }

  while(level.artilleryDangerCenters.size > 0) {
    for(i = 0; i < level.artilleryDangerCenters.size; i++) {
      origin = level.artilleryDangerCenters[i].origin;
      forward = level.artilleryDangerCenters[i].forward;

      origin += forward * level.dangerForwardPush[streakName] * level.dangerMaxRadius[streakName];

      previnnerpos = (0, 0, 0);
      prevouterpos = (0, 0, 0);
      for(j = 0; j <= 40; j++) {
        frac = (j * 1.0) / 40;
        angle = frac * 360;
        dir = anglesToForward((0, angle, 0));
        forwardPart = vectordot(dir, forward) * forward;
        perpendicularPart = dir - forwardPart;
        pos = forwardPart * level.dangerOvalScale[streakName] + perpendicularPart;
        innerpos = pos * level.dangerMinRadius[streakName];
        innerpos += origin;
        outerpos = pos * level.dangerMaxRadius[streakName];
        outerpos += origin;

        if(j > 0) {
          line(innerpos, previnnerpos, (1, 0, 0));
          line(outerpos, prevouterpos, (1, .5, .5));
        }

        previnnerpos = innerpos;
        prevouterpos = outerpos;
      }
    }
    wait .05;
  }
}

getAirstrikeDanger(point) {
  danger = 0;
  for(i = 0; i < level.artilleryDangerCenters.size; i++) {
    origin = level.artilleryDangerCenters[i].origin;
    forward = level.artilleryDangerCenters[i].forward;
    streakName = level.artilleryDangerCenters[i].streakName;

    danger += getSingleAirstrikeDanger(point, origin, forward, streakName);
  }
  return danger;
}

getSingleAirstrikeDanger(point, origin, forward, streakName) {
  center = origin + level.dangerForwardPush[streakName] * level.dangerMaxRadius[streakName] * forward;

  diff = point - center;
  diff = (diff[0], diff[1], 0);

  forwardPart = vectorDot(diff, forward) * forward;
  perpendicularPart = diff - forwardPart;

  circlePos = perpendicularPart + forwardPart / level.dangerOvalScale[streakName];

  distsq = lengthSquared(circlePos);

  if(distsq > level.dangerMaxRadius[streakName] * level.dangerMaxRadius[streakName]) {
    return 0;
  }

  if(distsq < level.dangerMinRadius[streakName] * level.dangerMinRadius[streakName]) {
    return 1;
  }

  dist = sqrt(distsq);
  distFrac = (dist - level.dangerMinRadius[streakName]) / (level.dangerMaxRadius[streakName] - level.dangerMinRadius[streakName]);

  assertEx(distFrac >= 0 && distFrac <= 1, distFrac);

  return 1 - distFrac;
}

pointIsInAirstrikeArea(point, targetpos, yaw, streakName) {
  return distance2d(point, targetpos) <= level.dangerMaxRadius[streakName] * 1.25;
}

radiusArtilleryShellshock(pos, radius, maxduration, minduration, team) {
  players = level.players;

  foreach(player in level.players) {
    if(!isAlive(player)) {
      continue;
    }

    if(player.team == team || player.team == "spectator") {
      continue;
    }

    playerPos = player.origin + (0, 0, 32);
    dist = distance(pos, playerPos);

    if(dist > radius) {
      continue;
    }

    duration = int(maxduration + (minduration - maxduration) * dist / radius);
    player thread artilleryShellshock("default", duration);
  }
}

artilleryShellshock(type, duration) {
  self endon("disconnect");

  if(isDefined(self.beingArtilleryShellshocked) && self.beingArtilleryShellshocked) {
    return;
  }
  self.beingArtilleryShellshocked = true;

  self shellshock(type, duration);
  wait(duration + 1);

  self.beingArtilleryShellshocked = false;
}

airstrikeLine(start, end, color, duration) {
  frames = duration * 20;
  for(i = 0; i < frames; i++) {
    line(start, end, color);
    wait .05;
  }
}

traceBomb() {
  self endon("death");
  prevpos = self.origin;
  while(1) {
    thread airstrikeLine(prevpos, self.origin, (.5, 1, 0), 40);
    prevpos = self.origin;
    wait .2;
  }
}

bomberDropCarepackges(plane, owner) {
  plane endon("death");
  plane endon("crashing");

  dropInfo = spawnStruct();
  dropInfo.usedNodes = [];
  dropInfo.crateTypes = [];

  waitillAirstrikeOverBombingArea(plane);

  wait 0.1;

  start = GetTime();
  dropInfo.crateTypes[0] = shootDownCarepackage(plane, owner, dropInfo);
  end = GetTime();
  waitTime = 0.1 - ((end - start) / 1000);
  if(waitTime > 0) {
    wait waitTime;
  }

  start = GetTime();
  dropInfo.crateTypes[1] = shootDownCarepackage(plane, owner, dropInfo);
  end = GetTime();
  waitTime = 0.1 - ((end - start) / 1000);
  if(waitTime > 0) {
    wait waitTime;
  }

  dropInfo.crateTypes[2] = shootDownCarepackage(plane, owner, dropInfo);
}

shootDownCarepackage(plane, owner, dropInfo) {
  position = dropSiteTrace(plane.origin, plane);

  node = findCloseNode(position, plane, dropInfo, plane.dropSite, owner);

  if(!isDefined(node)) {
    node = spawnStruct();
    node.origin = position;
  }

  dropStart = plane.origin + (0, 0, -5);

  return maps\mp\killstreaks\_orbital_carepackage::FirePod("orbital_carepackage_pod_plane_mp", owner, node, "airdrop_assault", [], undefined, dropStart, dropInfo.crateTypes, false);
}

dropSiteTrace(org, ignoreEnt) {
  start = org;
  end = start + (0, 0, -1000000);

  trace = bulletTrace(start, end, false, ignoreEnt);

  ent = trace["entity"];
  while(isDefined(ent) && isDefined(ent.vehicleType)) {
    waitframe();
    start = trace["position"];
    trace = bulletTrace(start, end, false, ent);
    ent = trace["entity"];
  }

  return trace["position"];
}

withinOtherCarepackageNodes(position, dropInfo) {
  ORBITAL_TRACE_CP_RADIUS = 26;

  dist = ORBITAL_TRACE_CP_RADIUS * 2;
  distSqMin = dist * dist;

  foreach(node in dropInfo.usedNodes) {
    distSq = Distance2DSquared(node.origin, position);
    if(distSq < distSqMin) {
      return true;
    }
  }

  return false;
}

findCloseNode(position, plane, dropInfo, dropSite, owner) {
  numFrames = 4;
  numTracesPerFrame = 5;
  start = plane.origin;

  nodes = GetNodesInRadiusSorted(dropSite, 300, 0, 1000);
  bestNode = undefined;
  foreach(node in nodes) {
    if(numFrames <= 0) {
      break;
    }

    if(!NodeExposedToSky(node, true)) {
      continue;
    }

    if(array_contains(dropInfo.usedNodes, node)) {
      continue;
    }

    if(withinOtherCarepackageNodes(node.origin, dropInfo)) {
      continue;
    }

    end = node.origin + (0, 0, 5);

    passEnt = owner;
    if(!isDefined(passEnt)) {
      passEnt = plane;
    }

    dropInfo.usedNodes[dropInfo.usedNodes.size] = node;
    if(BulletTracePassed(start, end, false, plane) && maps\mp\killstreaks\_orbital_util::carepackageTrace(node.origin, passEnt, "carepackage")) {
      bestNode = node;
      break;
    }
    numTracesPerFrame--;

    if(numTracesPerFrame <= 0) {
      numFrames--;
      numTracesPerFrame = 5;
      waitframe();
    }
  }

  return bestNode;
}

doBomberStrike(lifeId, owner, bombsite, startPoint, direction, streakName, modules) {
  if(!isDefined(owner)) {
    return;
  }

  if(!array_contains(modules, "strafing_run_airstrike_two")) {
    thread spawnAirstrikePlane(lifeId, owner, bombsite, startPoint, direction, streakName, modules, true);
  } else {
    startPointStruct = spawnStruct();
    getAdditionalBomberPlaneStarts(startPoint, direction, startPointStruct);
    thread spawnAirstrikePlane(lifeId, owner, bombsite, startPointStruct.startPoint1, direction, streakName, modules, true);
    wait 1;
    thread spawnAirstrikePlane(lifeId, owner, bombsite, startPointStruct.startPoint2, direction, streakName, modules, false);
  }
}

getAdditionalBomberPlaneStarts(startPoint, direction, startPointStruct) {
  dirRight = AnglesToRight(direction);
  startPointStruct.startPoint1 = startPoint + (dirRight * CONST_AIRSTRIKE_ADDITIONAL_BOMBER_DIST);
  startPointStruct.startPoint2 = startPoint + (dirRight * -1 * CONST_AIRSTRIKE_ADDITIONAL_BOMBER_DIST);
}

spawnAirstrikePlane(lifeId, owner, bombsite, startPoint, direction, streakName, modules, doCoop) {
  enemyIcon = "compass_objpoint_airstrike_busy";
  if(array_contains(modules, "strafing_run_airstrike_stealth")) {
    enemyIcon = "compass_objpoint_b2_airstrike_enemy";
  }

  plane = spawn("script_model", startPoint);
  plane.angles = direction;
  plane setModel("vehicle_airplane_shrike");

  PrintLn("Strafing Run: fly height = " + startPoint[2] + ", make nosight clip at least 800 units wide.");

  plane.minimapIcon = spawnplane(owner, "script_model", startPoint, "compass_objpoint_airstrike_friendly", enemyIcon);
  plane.minimapIcon setModel("tag_origin");
  plane.minimapIcon LinkToSynchronizedParent(plane, "tag_origin", (0, 0, 0), (0, 0, 0));

  plane.modules = modules;
  plane.vehicleType = "strafing_run";

  addPlaneToList(plane);
  plane setCanDamage(true);
  plane setCanRadiusDamage(true);
  plane thread maps\mp\gametypes\_damage::setEntityDamageCallback(1000, undefined, ::onAirStrikeDeath, maps\mp\killstreaks\_aerial_utility::heli_ModifyDamage, true);
  if(array_contains(plane.modules, "strafing_run_airstrike_flares")) {
    plane thread airstrike_flares_monitor();
  }
  plane thread handleDeath();
  plane thread planeDebugCrash();

  plane playLoopSound("bombrun_jet_dist_loop");
  plane.lifeId = lifeId;
  plane.owner = owner;
  plane.team = owner.team;
  plane.dropSite = bombsite;
  plane.enteringBombingArea = true;

  plane thread planeAnimatePath(bombsite);
  plane thread planePlayEffects();

  thread stealthBomber_killCam(plane, streakName);

  if(array_contains(plane.modules, "strafing_run_airstrike_package")) {
    thread bomberDropCarepackges(plane, owner);
  } else {
    thread bomberDropBombs(plane, owner);
  }

  if(level.teamBased && doCoop) {
    level thread handleCoopJoining(plane, owner);
  }

  plane endon("death");
  plane endon("crashing");

  waitillAirstrikeOverBombingArea(plane);
  plane.enteringBombingArea = false;

  plane waittill("pathComplete");

  level.strafing_run_airstrike = undefined;

  plane notify("airstrike_complete");

  removePlaneFromList(plane);

  plane waittillmatch("airstrike", "end");

  plane notify("delete");

  if(isDefined(plane.minimapIcon)) {
    plane.minimapIcon Delete();
  }
  plane delete();
}

planeHandleHostMigration() {
  self endon("airstrike_complete");
  self endon("pathComplete");

  while(true) {
    level waittill("host_migration_begin");

    self ScriptModelPauseAnim(true);

    level waittill("host_migration_end");

    self ScriptModelPauseAnim(false);
  }
}

planeAnimatePath(dropSite) {
  self endon("airstrike_complete");

  self ScriptModelPlayAnimDeltaMotion("strafing_run_ks_flyby", "airstrike");
  self thread planeHandleHostMigration();
  self.status = "flying_in";
  self.flyingSpeed = (CONST_AIRSTRIKE_FLY_IN_DIST / CONST_AIRSTRIKE_FLY_IN_TIME);

  wait CONST_AIRSTRIKE_FLY_IN_TIME;

  self.status = "strike";
  self.flyingSpeed = (CONST_AIRSTRIKE_FLY_THROUGH_DIST / CONST_AIRSTRIKE_FLY_THROUGH_TIME);

  wait CONST_AIRSTRIKE_FLY_THROUGH_TIME;

  self.status = "flying_out";
  self.flyingSpeed = (CONST_AIRSTRIKE_FLY_IN_DIST / CONST_AIRSTRIKE_FLY_IN_TIME);

  wait CONST_AIRSTRIKE_FLY_IN_TIME - 0.1;

  self notify("pathComplete");
}

airstrike_flares_monitor() {
  self.numFlares = 4;
  self thread maps\mp\killstreaks\_aerial_utility::handleIncomingStinger();
}

onAirStrikeDeath(attacker, weapon, meansOfDeath, damage) {
  self thread crashPlane();

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "strafing_run_destroyed", undefined, "callout_destroyed_airstrike", true);
}

crashPlane() {
  self notify("crashing");
  self.crashed = true;
}

bomberDropBombs(plane, owner) {
  plane endon("airstrike_complete");

  while(!targetIsClose(plane, plane.dropSite, 5000)) {
    wait(0.05);
  }

  showFx = true;
  sonicBoom = false;

  plane notify("start_bombing");

  plane thread playBombFx();

  for(dist = targetGetDist(plane, plane.dropSite); dist < 5000; dist = targetGetDist(plane, plane.dropSite)) {
    if(dist < 1500 && !sonicBoom) {
      sonicBoom = true;
    }

    showFx = !showFx;
    if(dist < 4500) {
      plane thread callStrike_bomb(plane.origin, owner, (0, 0, 0), showFx);
    }
    wait(0.1);
  }

  plane notify("stop_bombing");

  level.strafing_run_airstrike = undefined;
}

playBombFx() {
  self endon("stop_bombing");
  self endon("airstrike_complete");

  self.bomb_tag_left = spawn("script_model", (0, 0, 0));
  self.bomb_tag_left setModel("tag_origin");
  self.bomb_tag_left LinkTo(self, "bombaydoor_left_jnt", (0, 0, 0), (0, -90, 0));

  self.bomb_tag_right = spawn("script_model", (0, 0, 0));
  self.bomb_tag_right setModel("tag_origin");
  self.bomb_tag_right LinkTo(self, "bombaydoor_right_jnt", (0, 0, 0), (0, -90, 0));

  for(;;) {
    playFXOnTag(getfx("airstrike_bombs"), self.bomb_tag_left, "tag_origin");
    playFXOnTag(getfx("airstrike_bombs"), self.bomb_tag_right, "tag_origin");

    wait(0.5);
  }
}

stealthBomber_killCam(plane, streakName) {
  plane endon("airstrike_complete");

  plane waittill("start_bombing");

  planedir = anglesToForward(plane.angles);

  killCamEnt = spawn("script_model", plane.origin + (0, 0, 100) - planedir * 200);
  plane.killCamEnt = killCamEnt;
  plane.killCamEnt SetScriptMoverKillCam("airstrike");
  plane.airstrikeType = streakName;
  killCamEnt.startTime = gettime();
  killCamEnt thread deleteAfterTime(16.0);

  killCamEnt linkTo(plane, "tag_origin", (-256, 768, 768), (0, 0, 0));
}

callStrike_bomb(coord, owner, offset, showFx) {
  self endon("airstrike_complete");

  if(!isDefined(owner) || owner isEMPed() || owner isAirDenied()) {
    self notify("stop_bombing");
    return;
  }

  accuracyRadius = 512;

  randVec = (0, randomint(360), 0);
  bombPoint = coord + (anglesToForward(randVec) * RandomFloat(accuracyRadius));
  trace = bulletTrace(bombPoint, bombPoint + (0, 0, -10000), false, self);

  bombPoint = trace["position"];

  bombHeight = distance(coord, bombPoint);

  if(bombHeight > 10000) {
    return;
  }

  wait(0.85 * (bombHeight / 2000));

  if(!isDefined(owner) || owner isEMPed() || owner isAirDenied()) {
    self notify("stop_bombing");
    return;
  }

  if(showFx) {
    playFX(getfx("airstrike_ground"), bombPoint);
    level thread maps\mp\gametypes\_shellshock::stealthAirstrike_earthQuake(bombPoint);
  }

  thread playSoundInSpace("bombrun_snap", bombPoint);
  radiusArtilleryShellshock(bombPoint, 512, 8, 4, owner.team);
  self RadiusDamage(bombPoint + (0, 0, 16), 896, 300, 50, owner, "MOD_EXPLOSIVE", "stealth_bomb_mp");
  if(isDefined(level.ishorde) && level.ishorde && isDefined(level.flying_attack_drones)) {
    foreach(drone in level.flying_attack_drones) {
      if(drone.origin[2] > (bombPoint[2] - 24) && drone.origin[2] < (bombPoint[2] + 1000) && Distance2DSquared(drone.origin, bombPoint) < (90000)) {
        drone DoDamage(RandomIntRange(50, 300), bombPoint + (0, 0, 16), owner, owner, "MOD_EXPLOSIVE", "stealth_bomb_mp");
      }
    }
  }
}

handleDeath(player) {
  level endon("game_ended");
  self endon("delete");

  self waittill_either("death", "crashing");

  forward = anglesToForward(self.angles);
  playFX(getfx("airstrike_death"), self.origin, forward);

  playSoundinSpace("bombrun_air_death", self.origin);

  self notify("airstrike_complete");

  removePlaneFromList(self);
  level.strafing_run_airstrike = undefined;

  if(isDefined(self.minimapIcon)) {
    self.minimapIcon Delete();
  }

  self delete();
}

addPlaneToList(plane) {
  level.planes[level.planes.size] = plane;
}

removePlaneFromList(plane) {
  level.planes = array_remove(level.planes, plane);
}

deleteAfterTime(time) {
  self endon("death");
  wait time;

  self delete();
}

planePlayEffects() {
  self endon("airstrike_complete");

  waitframe();
  playFXOnTag(getfx("airstrike_engine"), self, "tag_engine_right");
  playFXOnTag(getfx("airstrike_engine"), self, "tag_engine_left");
  playFXOnTag(getfx("airstrike_wingtip"), self, "tag_right_wingtip");
  playFXOnTag(getfx("airstrike_wingtip"), self, "tag_left_wingtip");
}

callStrike(lifeId, owner, coord, yaw, streakName, modules) {
  thread teamPlayerCardSplash("used_strafing_run_airstrike", owner, owner.team);

  planeFlyHeight = getPlaneFlyHeight();

  if(GetDvarInt("scr_debugairstrike", 0)) {
    self thread debugFlyHeight(planeFlyHeight);
  }

  owner endon("disconnect");

  direction = (0, yaw, 0);
  startPoint = getFlightPath(coord, direction, planeFlyHeight);

  level thread doBomberStrike(lifeId, owner, coord, startPoint, direction, streakName, modules);
}

getPlaneFlyHeight() {
  height_modifier = 0;
  if(isDefined(level.airstrikeoverrides) && isDefined(level.airstrikeoverrides.spawnHeight)) {
    height_modifier = level.airstrikeoverrides.spawnHeight;
  }

  heliAnchor = maps\mp\killstreaks\_aerial_utility::getHeliAnchor();
  return heliAnchor.origin[2] + CONST_AIRSTRIKE_Z_OFFSET_FROM_ANCHOR + height_modifier;
}

getFlightPath(coord, direction, planeFlyHeight) {
  planeHalfDistance = (getFlightDistance()) / 2;

  startPoint = coord + (anglesToForward(direction) * (-1 * planeHalfDistance));
  startPoint *= (1, 1, 0);
  startPoint += (0, 0, planeFlyHeight);

  return startPoint;
}

getFlightDistance() {
  return (CONST_AIRSTRIKE_FLY_IN_DIST + CONST_AIRSTRIKE_FLY_IN_DIST + CONST_AIRSTRIKE_FLY_THROUGH_DIST);
}

targetGetDist(other, target) {
  infront = targetisinfront(other, target);
  if(infront) {
    dir = 1;
  } else {
    dir = -1;
  }
  a = flat_origin(other.origin);
  b = a + (anglesToForward(flat_angle(other.angles)) * (dir * 100000));
  point = pointOnSegmentNearestToPoint(a, b, target);
  dist = distance(a, point);

  return dist;
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
  b = a + (anglesToForward(flat_angle(other.angles)) * (dir * 100000));
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

waitForAirstrikeCancel() {
  self endon("location_selection_complete");
  self endon("disconnect");

  self waittill("stop_location_selection");
  self setblurforplayer(0, 0.3);
  self SetClientOmnvar("ui_map_location_blocked", 0);

  if(maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone() > 0) {
    self SwitchToWeapon(self getLastWeapon());
  }

  level.strafing_run_airstrike = undefined;
}

selectAirstrikeLocation(lifeId, streakname, modules) {
  if(!isDefined(level.mapSize)) {
    level.mapSize = 1024;
  }

  targetSize = level.mapSize / 6.46875;
  if(level.splitscreen) {
    targetSize *= 1.5;
  }

  level.strafing_run_airstrike = true;
  chooseDirection = true;

  numPlanes = 1;
  if(array_contains(modules, "strafing_run_airstrike_two")) {
    numPlanes = 2;
  }

  self SetClientOmnvar("ui_map_location_use_carepackages", array_contains(modules, "strafing_run_airstrike_package"));
  self SetClientOmnvar("ui_map_location_num_planes", numPlanes);
  self SetClientOmnvar("ui_map_location_height", getPlaneFlyHeight());
  self _beginLocationSelection(streakname, "map_artillery_selector", chooseDirection, targetSize);
  self thread waitForAirstrikeCancel();

  self endon("stop_location_selection");
  self endon("disconnect");

  dropSite = undefined;
  flyYaw = undefined;

  validFlightPath = false;
  while(!validFlightPath) {
    self waittill("confirm_location", location, directionYaw);
    if(!chooseDirection) {
      directionYaw = 0;
    }

    if(validateFlightLocationAndDirection(location, directionYaw, modules, self)) {
      dropSite = location;
      flyYaw = directionYaw;
      self SetClientOmnvar("ui_map_location_use_carepackages", false);
      self SetClientOmnvar("ui_map_location_num_planes", 0);
      self SetClientOmnvar("ui_map_location_height", 0);
      break;
    } else {
      self thread showBlockedHUD();
    }
  }

  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  self SetClientOmnvar("ui_map_location_blocked", 0);

  self maps\mp\_matchdata::logKillstreakEvent(streakName, dropSite);

  self thread finishAirstrikeUsage(lifeId, [dropSite], [flyYaw], streakName, modules);
  return true;
}

showBlockedHUD() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self endon("stop_location_selection");

  self notify("airstrikeShowBlockedHUD");
  self endon("airstrikeShowBlockedHUD");

  if(self GetClientOmnvar("ui_map_location_blocked") == 0) {
    self PlayLocalSound("recon_drn_cloak_notready");
  }

  self SetClientOmnvar("ui_map_location_blocked", 1);

  wait 1.5;

  self SetClientOmnvar("ui_map_location_blocked", 0);
}

validateFlightLocationAndDirection(loc, yaw, modules, owner) {
  planeFlyHeight = getPlaneFlyHeight();
  numPlanes = 1;
  if(array_contains(modules, "strafing_run_airstrike_two")) {
    numPlanes = 2;
  }

  return BombingRunTracePassed(loc, planeFlyHeight, yaw, numPlanes);
}

finishAirstrikeUsage(lifeId, locations, directions, streakName, modules) {
  self notify("used");

  for(i = 0; i < locations.size; i++) {
    location = locations[i];
    directionYaw = directions[i];

    trace = bulletTrace(level.mapCenter + (0, 0, 1000000), level.mapCenter, false, undefined);
    location = (location[0], location[1], trace["position"][2] - 514);

    if(GetDvarInt("scr_debugairstrike", 0)) {
      self thread debugLocation(trace, location);
    }

    thread doAirstrike(lifeId, location, directionYaw, self, self.pers["team"], streakName, modules);
  }
}

waitillAirstrikeOverBombingArea(plane) {
  plane endon("airstrike_complete");

  while(!targetIsClose(plane, plane.dropSite, 200)) {
    waitframe();
  }
}

playerDelayControl() {
  self endon("disconnect");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

PlayerDoRideKillstreak(plane) {
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("coop", false, 0.5);

  if(result != "success" || !isDefined(plane)) {
    if(result != "disconnect") {
      if(!isDefined(plane)) {
        self thread playerRemoteKillstreakShowHud();
      }
      self playerReset(false);
      self maps\mp\killstreaks\_coop_util::playerResetAfterCoopStreak();
    }

    self notify("initRideKillstreak_complete", false);
    return;
  }

  self notify("initRideKillstreak_complete", true);
}

handleCoopJoining(plane, player) {
  team = player.team;

  if(player.team == "allies") {
    assistVO = "SE_1mc_orbitalsupport_buddyrequest";
    buddyVO = "SE_1mc_orbitalsupport_buddy";
  } else {
    assistVO = "AT_1mc_orbitalsupport_buddyrequest";
    buddyVO = "AT_1mc_orbitalsupport_buddy";
  }

  waittillOverPlayspace(plane);

  if(!isDefined(plane)) {
    return;
  }

  {
    id = maps\mp\killstreaks\_coop_util::promptForStreakSupport(team, &"MP_JOIN_STRAFING_RUN", "strafing_run_airstrike_coop_offensive", assistVO, buddyVO, player);

    level thread watchForJoin(id, plane, player);

    result = waittillPromptComplete(plane, "buddyJoinedStreak");

    maps\mp\killstreaks\_coop_util::stopPromptForStreakSupport(id);

    if(!isDefined(result)) {
      return;
    }

    result = waittillPromptComplete(plane, "airstrike_buddy_removed");

    if(!isDefined(result)) {
      return;
    }
  }
}

notifyCoopOver(plane) {
  plane endon("airstrike_complete");

  if(plane.enteringBombingArea) {
    waitillAirstrikeOverBombingArea(plane);
  }
  waittillLeftPlayspace(plane, 1.65);

  plane notify("coopJoinOver");
}

waittillOverPlayspace(plane) {
  timeSec = 1.65;
  dir = anglesToForward(plane.angles);

  while(true) {
    waitframe();

    if(!isDefined(plane)) {
      return;
    }

    distToEdge = plane.flyingSpeed * timeSec;
    start = plane.origin + (dir * distToEdge);
    end = start + (0, 0, -10000);
    trace = bulletTrace(start, end, false, plane);

    if(trace["fraction"] == 1) {
      continue;
    }

    pos = trace["position"];

    nodes = GetNodesInRadius(pos, 300, 0);

    if(nodes.size > 0) {
      break;
    }
  }
}

waittillLeftPlayspace(plane, timeSec) {
  plane endon("airstrike_complete");

  if(!isDefined(timeSec)) {
    timeSec = 0;
  }

  while(true) {
    waitframe();

    distToEdge = plane.flyingSpeed * timeSec;
    dir = anglesToForward(plane.angles);
    start = plane.origin + (dir * distToEdge);
    end = start + (0, 0, -10000);
    trace = bulletTrace(start, end, false, plane);

    if(trace["fraction"] == 1) {
      break;
    }

    pos = trace["position"];

    nodes = GetNodesInRadius(pos, 300, 0);

    if(nodes.size == 0) {
      break;
    }
  }
}

waittillFireMissile(plane, player) {
  player endon("airstrike_fire");
  plane endon("airstrike_complete");

  if(plane.enteringBombingArea) {
    waitillAirstrikeOverBombingArea(plane);
  }
  waittillLeftPlayspace(plane);
}

waittillPromptComplete(plane, text) {
  plane endon("airstrike_complete");
  plane endon("coopJoinOver");

  plane waittill(text);

  return true;
}

watchForJoin(id, plane, primaryPlayer) {
  buddy = waittillBuddyJoinedAirstrike(id, plane);
  if(!isDefined(buddy)) {
    return;
  }

  plane notify("buddyJoinedStreak");
  level notify("buddyGO");

  buddy thread PlayerDoRideKillstreak(plane);
  buddy waittill("initRideKillstreak_complete", success);
  if(!success) {
    return;
  }

  buddy playerSaveAngles();

  buddy setUsingRemote("strafing_run");
  buddy NotifyOnPlayerCommand("airstrike_fire", "+attack");
  buddy NotifyOnPlayerCommand("airstrike_fire", "+attack_akimbo_accessible");
  missileStrikeTurret = SpawnTurret("misc_turret", plane GetTagOrigin("tag_origin"), "sentry_minigun_mp");
  missileStrikeTurret TurretFireDisable();
  missileStrikeTurret setModel("tag_turret");
  missileStrikeTurret LinkToSynchronizedParent(plane, "tag_origin", (0, 0, 0), (70, 180, 0));
  buddy PlayerLinkWeaponViewToDelta(missileStrikeTurret, "tag_player", 0, 180, 180, 5, 15, false);
  buddy PlayerLinkedSetViewZNear(false);
  buddy PlayerLinkedSetUseBaseAngleForViewClamp(true);
  buddy RemoteControlTurret(missileStrikeTurret, 60, 45);

  MissileWeapon = buddy maps\mp\killstreaks\_missile_strike::BuildWeaponSettings([]);
  MissileEyesInit(buddy, MissileWeapon, primaryPlayer);

  waittillFireMissile(plane, buddy);
  if(isDefined(buddy)) {
    Earthquake(0.4, 1, buddy GetViewOrigin(), 300);
    fireMissile(buddy, missileStrikeTurret, MissileWeapon);

    if(isDefined(buddy)) {
      buddy maps\mp\killstreaks\_coop_util::playerResetAfterCoopStreak();
      buddy NotifyOnPlayerCommandRemove("airstrike_fire", "+attack");
      buddy NotifyOnPlayerCommandRemove("airstrike_fire", "+attack_akimbo_accessible");
    }
  }
  missileStrikeTurret Delete();
}

waittillBuddyJoinedAirstrike(id, plane) {
  plane endon("airstrike_complete");
  plane endon("coopJoinOver");

  thread notifyCoopOver(plane);

  buddy = maps\mp\killstreaks\_coop_util::waittillBuddyJoinedStreak(id);

  return buddy;
}

fireMissile(player, turret, MissileWeapon) {
  start = turret GetTagOrigin("tag_player");
  dir = anglesToForward(turret GetTagAngles("tag_player"));
  end = start + (dir * 10000);
  rocket = MagicBullet("airstrike_missile_mp", start, end, player);
  rocket.owner = player;
  waitframe();
  if(!isDefined(player)) {
    return;
  }
  player Unlink();
  player RemoteControlTurretOff(turret);
  player SetClientOmnvar("fov_scale", 65.0 / 15.0);
  MissileEyesGo(player, rocket, MissileWeapon);
  if(!isDefined(player)) {
    return;
  }
  player SetClientOmnvar("fov_scale", 1.0);
}

MissileEyesInit(player, MissileWeapon, primaryPlayer) {
  player thread hudInit(MissileWeapon, primaryPlayer);

  player ThermalVisionFOFOverlayOn();

  if(getDvarInt("camera_thirdPerson")) {
    player setThirdPersonDOF(false);
  }
}

MissileEyesGo(player, rocket, MissileWeapon) {
  player endon("joined_team");
  player endon("joined_spectators");
  player endon("player_control_strike_over");
  player endon("disconnect");
  MissileWeapon endon("ms_early_exit");

  rocket thread maps\mp\killstreaks\_missile_strike::Rocket_CleanupOnDeath();
  player thread maps\mp\killstreaks\_missile_strike::Player_CleanupOnGameEnded(rocket, MissileWeapon);
  player thread maps\mp\killstreaks\_missile_strike::Player_CleanupOnTeamChange(rocket, MissileWeapon);

  player thread hudGo(rocket, MissileWeapon);

  player thread playerWaitReset(MissileWeapon);

  player CameraLinkTo(rocket, "tag_origin");
  player ControlsLinkTo(rocket);

  player thread maps\mp\killstreaks\_missile_strike::playerWatchForEarlyExit(MissileWeapon);

  rocket waittill_notify_or_timeout("death", 10);

  MissileWeapon notify("missile_strike_complete");
}

playerWaitReset(MissileWeapon) {
  MissileWeapon waittill_either("missile_strike_complete", "ms_early_exit");

  self playerReset();
}

playerReset(shouldWait) {
  self endon("disconnect");

  if(!isDefined(shouldWait)) {
    shouldWait = true;
  }

  self ControlsUnlink();
  self freezeControlsWrapper(true);
  self SetClientOmnvar("fov_scale", 1.0);

  self stopMissileBoostSounds();

  self maps\mp\killstreaks\_missile_strike::stopMissileBoostSounds();

  if(!level.gameEnded || isDefined(self.finalKill)) {
    self maps\mp\killstreaks\_aerial_utility::playerShowFullStatic();
  }

  if(shouldWait) {
    wait(0.5);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }

  self maps\mp\killstreaks\_missile_strike::remove_hud();

  self ThermalVisionFOFOverlayOff();

  self CameraUnlink();

  self freezeControlsWrapper(false);

  if(self isUsingRemote()) {
    self clearUsingRemote();
  }

  self playerRestoreAngles();
}

stopMissileBoostSounds() {
  self StopLocalSound("bombrun_support_mstrike_boost_shot");
  self StopLocalSound("bombrun_support_mstrike_boost_boom");
  self StopLocalSound("bombrun_support_mstrike_boost_jet");
}

hudInit(MissileWeapon, primaryPlayer) {
  self endon("disconnect");

  self SetClientOmnvar("ui_predator_missile", 2);
  self SetClientOmnvar("ui_coop_primary_num", primaryPlayer GetEntityNumber());

  waitframe();

  self maps\mp\killstreaks\_missile_strike::hud_update_fire_text(undefined, MissileWeapon);
  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();
}

hudGo(rocket, MissileWeapon) {
  self thread maps\mp\killstreaks\_missile_strike::targeting_hud_init();
  self thread maps\mp\killstreaks\_missile_strike::targeting_hud_think(rocket, MissileWeapon);
}

planeDebugCrash() {
  self endon("airstrike_complete");

  while(true) {
    if(getDvar("scr_airstrike_crash", "0") != "0") {
      self thread crashPlane();
      setDvar("scr_airstrike_crash", "0");
    }

    waitframe();
  }
}
# /