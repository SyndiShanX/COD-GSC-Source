/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_airstrike.gsc
**********************************************/

#include maps\mp\_utility;
#include maps\mp\killstreaks\_harrier;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  precacheLocationSelector("map_artillery_selector");

  level.airstrikefx = loadfx("fx/explosions/clusterbomb");
  level.airstrikessfx = loadfx("fx/explosions/clusterbomb_no_fount");
  level.airstrikeexplosion = loadfx("fx/explosions/clusterbomb_exp_direct_runner_cheap");
  level.mortareffect = loadfx("fx/explosions/clusterbomb_exp_direct_runner_stealth");
  level.bombstrike = loadfx("fx/explosions/wall_explosion_pm_a");
  level.airBurstBomb = loadfx("fx/explosions/airburst");

  level.harriers = [];

  level.fx_airstrike_afterburner = loadfx("fx/fire/jet_afterburner");
  level.fx_airstrike_contrail = loadfx("fx/smoke/jet_contrail");

  level.dangerMaxRadius["stealth_airstrike"] = 900;
  level.dangerMinRadius["stealth_airstrike"] = 750;
  level.dangerForwardPush["stealth_airstrike"] = 1;
  level.dangerOvalScale["stealth_airstrike"] = 6.0;

  level.dangerMaxRadius["airstrike"] = 550;
  level.dangerMinRadius["airstrike"] = 300;
  level.dangerForwardPush["airstrike"] = 1.5;
  level.dangerOvalScale["airstrike"] = 6.0;

  level.dangerMaxRadius["precision_airstrike"] = 550;
  level.dangerMinRadius["precision_airstrike"] = 300;
  level.dangerForwardPush["precision_airstrike"] = 2.0;
  level.dangerOvalScale["precision_airstrike"] = 6.0;

  level.dangerMaxRadius["harrier_airstrike"] = 550;
  level.dangerMinRadius["harrier_airstrike"] = 300;
  level.dangerForwardPush["harrier_airstrike"] = 1.5;
  level.dangerOvalScale["harrier_airstrike"] = 6.0;

  level.artilleryDangerCenters = [];

  level.killStreakFuncs["airstrike"] = ::tryUseAirstrike;
  level.killStreakFuncs["precision_airstrike"] = ::tryUseAirstrike;
  level.killStreakFuncs["super_airstrike"] = ::tryUseAirstrike;
  level.killStreakFuncs["harrier_airstrike"] = ::tryUseAirstrike;
  level.killStreakFuncs["stealth_airstrike"] = ::tryUseAirstrike;

  level.planes = [];
}

tryUseAirstrike(lifeId, streakName) {
  switch (streakName) {
    case "precision_airstrike":
      break;
    case "stealth_airstrike":
      break;
    case "harrier_airstrike":
      if(isDefined(level.harrier_incoming) || level.harriers.size >= 1) {
        self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
        return false;
      }
      break;
    case "super_airstrike":
      break;
  }

  result = self selectAirstrikeLocation(lifeId, streakName);

  if(!isDefined(result) || !result)
    return false;

  return true;
}

debugLocation(trace, location) {
  level notify("debug_airstrike");
  level endon("debug_airstrike");

  while(true) {
    if(GetDvarInt("scr_debugairstrike") == 0) {
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
    if(GetDvarInt("scr_debugairstrike") == 0) {
      return;
    }
    anglesForward = anglesToForward(level.players[0].angles);
    scalar = (anglesForward[0] * 200, anglesForward[1] * 200, anglesForward[2]);
    Print3d(level.players[0].origin + scalar, "Fly Height: " + planeFlyHeight, (1, 0, 0));
    wait(0.05);
  }
}

doAirstrike(lifeId, origin, yaw, owner, team, streakName) {
  assert(isDefined(origin));
  assert(isDefined(yaw));

  if(streakName == "harrier_airstrike")
    level.harrier_incoming = true;

  if(isDefined(level.airstrikeInProgress)) {
    while(isDefined(level.airstrikeInProgress))
      level waittill("begin_airstrike");

    level.airstrikeInProgress = true;
    wait(2.0);
  }

  if(!isDefined(owner)) {
    if(streakName == "harrier_airstrike")
      level.harrier_incoming = undefined;

    return;
  }

  level.airstrikeInProgress = true;

  trace = bulletTrace(origin, origin + (0, 0, -1000000), false, undefined);
  targetpos = trace["position"];

  dangerCenter = spawnStruct();
  dangerCenter.origin = targetpos;
  dangerCenter.forward = anglesToForward((0, yaw, 0));
  dangerCenter.streakName = streakName;
  dangerCenter.team = team;

  level.artilleryDangerCenters[level.artilleryDangerCenters.size] = dangerCenter;
  /# level thread debugArtilleryDangerCenters( streakName );

  callStrike(lifeId, owner, targetpos, yaw, streakName);

  if(streakName == "harrier_airstrike")
    level.harrier_incoming = undefined;

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

  if(getdvarint("scr_airstrikedebug") != 1) {
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

  if(distsq > level.dangerMaxRadius[streakName] * level.dangerMaxRadius[streakName])
    return 0;

  if(distsq < level.dangerMinRadius[streakName] * level.dangerMinRadius[streakName])
    return 1;

  dist = sqrt(distsq);
  distFrac = (dist - level.dangerMinRadius[streakName]) / (level.dangerMaxRadius[streakName] - level.dangerMinRadius[streakName]);

  assertEx(distFrac >= 0 && distFrac <= 1, distFrac);

  return 1 - distFrac;
}

pointIsInAirstrikeArea(point, targetpos, yaw, streakName) {
  return distance2d(point, targetpos) <= level.dangerMaxRadius[streakName] * 1.25;
}

losRadiusDamage(pos, radius, max, min, owner, eInflictor, sWeapon) {
  ents = maps\mp\gametypes\_weapons::getDamageableEnts(pos, radius, true);

  glassRadiusDamage(pos, radius, max, min);

  for(i = 0; i < ents.size; i++) {
    if(ents[i].entity == self) {
      continue;
    }
    dist = distance(pos, ents[i].damageCenter);

    if(ents[i].isPlayer || (isDefined(ents[i].isSentry) && ents[i].isSentry)) {
      indoors = !BulletTracePassed(ents[i].entity.origin, ents[i].entity.origin + (0, 0, 130), false, undefined);
      if(indoors) {
        indoors = !BulletTracePassed(ents[i].entity.origin + (0, 0, 130), pos + (0, 0, 130 - 16), false, undefined);
        if(indoors) {
          dist *= 4;
          if(dist > radius)
            continue;
        }
      }
    }

    ents[i].damage = int(max + (min - max) * dist / radius);
    ents[i].pos = pos;
    ents[i].damageOwner = owner;
    ents[i].eInflictor = eInflictor;
    level.airStrikeDamagedEnts[level.airStrikeDamagedEntsCount] = ents[i];
    level.airStrikeDamagedEntsCount++;
  }

  thread airstrikeDamageEntsThread(sWeapon);
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
    if(!ent.isPlayer || isAlive(ent.entity)) {
      ent maps\mp\gametypes\_weapons::damageEnt(
        ent.eInflictor,
        ent.damageOwner,
        ent.damage,
        "MOD_PROJECTILE_SPLASH",
        sWeapon,
        ent.pos,
        vectornormalize(ent.damageCenter - ent.pos)
      );

      level.airstrikeDamagedEnts[level.airstrikeDamagedEntsIndex] = undefined;

      if(ent.isPlayer)
        wait(0.05);
    } else {
      level.airstrikeDamagedEnts[level.airstrikeDamagedEntsIndex] = undefined;
    }
  }
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

  if(isDefined(self.beingArtilleryShellshocked) && self.beingArtilleryShellshocked)
    return;
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

doBomberStrike(lifeId, owner, requiredDeathCount, bombsite, startPoint, endPoint, bombTime, flyTime, direction, streakName) {
  if(!isDefined(owner)) {
    return;
  }
  startPathRandomness = 100;
  endPathRandomness = 150;

  pathStart = startPoint + ((randomfloat(2) - 1) * startPathRandomness, (randomfloat(2) - 1) * startPathRandomness, 4000);
  pathEnd = endPoint + ((randomfloat(2) - 1) * endPathRandomness, (randomfloat(2) - 1) * endPathRandomness, 4000);

  plane = spawnplane(owner, "script_model", pathStart, "compass_objpoint_b2_airstrike_friendly", "compass_objpoint_b2_airstrike_enemy");

  addPlaneToList(plane);
  plane thread handleDeath();

  plane playLoopSound("veh_b2_dist_loop");
  plane setModel("vehicle_b2_bomber");
  plane thread handleEMP(owner);
  plane.lifeId = lifeId;

  plane.angles = direction;
  forward = anglesToForward(direction);
  plane moveTo(pathEnd, flyTime, 0, 0);

  thread stealthBomber_killCam(plane, pathEnd, flyTime, streakName);

  thread bomberDropBombs(plane, bombsite, owner);

  plane endon("death");

  wait(flyTime * 0.65);

  removePlaneFromList(plane);
  plane notify("delete");
  plane delete();
}

bomberDropBombs(plane, bombSite, owner) {
  plane endon("death");

  while(!targetIsClose(plane, bombsite, 5000))
    wait(0.05);

  showFx = true;
  sonicBoom = false;

  plane notify("start_bombing");

  bombsDropped = 0;

  for(dist = targetGetDist(plane, bombsite); dist < 5000; dist = targetGetDist(plane, bombsite)) {
    if(dist < 1500 && !sonicBoom) {
      plane PlaySoundOnMovingEnt("veh_b2_sonic_boom");
      sonicBoom = true;
    }

    if(dist < 3000 && bombsDropped < 4) {
      plane thread dropParachuteBomb(plane, owner);
      bombsDropped++;
      wait(randomFloatRange(.15, .3));
    }

    wait(0.1);
  }

  plane notify("stop_bombing");
}

dropParachuteBomb(plane, owner) {
  self endon("stop_bombing");
  self endon("death");

  bomb = spawn("script_model", self.origin);
  bomb setModel("parachute_cargo_static");
  bomb.team = owner.team;
  bomb.owner = owner;
  bomb setCanDamage(true);

  bombTrace = bulletTrace(bomb.origin, bomb.origin - (0, 0, 20000), false, bomb, false, false);
  endPosition = bombTrace["position"];

  bomb moveTo(endPosition, RandomIntRange(8, 14));

  bomb thread bombDamageWatcher(plane, endPosition);
  bomb thread bombWatcher(plane, endPosition);
}

bombDamageWatcher(plane, endPosition) {
  bomb = self;
  self endon("death");

  self setCanDamage(true);

  self.health = 999999;
  self.maxHealth = 200;
  self.damageTaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
      continue;
    }
    if(!isDefined(self)) {
      return;
    }
    self.wasDamaged = true;

    self.damageTaken += damage;

    if(isPlayer(attacker)) {
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("tactical_insertion");
    }

    if(self.damageTaken >= self.maxHealth) {
      RadiusDamage(bomb.origin, 1024, 600, 65, bomb.owner, "MOD_EXPLOSIVE", "stealth_bomb_mp");
      playFX(level.airBurstBomb, bomb.origin, anglesToForward(bomb.angles), bomb.origin - endPosition);

      if(isDefined(bomb))
        bomb Delete();

      self notify("death");
    }
  }

}

bombWatcher(plane, endPosition) {
  bomb = self;
  bomb endon("death");

  while(bomb.origin[2] > (endPosition[2] + 600)) {
    wait(0.1);
  }

  RadiusDamage(endPosition + (0, 0, 64), 1024, 600, 65, plane.owner, "MOD_EXPLOSIVE", "stealth_bomb_mp");
  playFX(level.airBurstBomb, bomb.origin, anglesToForward(bomb.angles), bomb.origin - endPosition);
  bomb Delete();
}

playBombFx() {
  self endon("stop_bombing");
  self endon("death");

  for(;;) {
    playFXOnTag(level.stealthbombfx, self, "tag_left_alamo_missile");
    playFXOnTag(level.stealthbombfx, self, "tag_right_alamo_missile");

    wait(0.5);
  }
}

stealthBomber_killCam(plane, pathEnd, flyTime, streakName) {
  plane waittill("start_bombing");

  planedir = anglesToForward(plane.angles);

  killCamEnt = spawn("script_model", plane.origin + (0, 0, 100) - planedir * 200);
  plane.killCamEnt = killCamEnt;
  plane.killCamEnt SetScriptMoverKillCam("airstrike");
  plane.airstrikeType = streakName;
  killCamEnt.startTime = gettime();
  killCamEnt thread deleteAfterTime(15.0);

  killCamEnt linkTo(plane, "tag_origin", (-256, 768, 768), (0, 0, 0));
}

callStrike_bomb(coord, owner, offset, showFx) {
  if(!isDefined(owner) || owner isKillStreakDenied()) {
    self notify("stop_bombing");
    return;
  }

  accuracyRadius = 512;

  randVec = (0, randomint(360), 0);
  bombPoint = coord + (anglesToForward(randVec) * RandomFloat(accuracyRadius));
  trace = bulletTrace(bombPoint, bombPoint + (0, 0, -10000), false, undefined);

  bombPoint = trace["position"];

  bombHeight = distance(coord, bombPoint);

  if(bombHeight > 5000) {
    return;
  }
  wait(0.85 * (bombHeight / 2000));

  if(!isDefined(owner) || owner isKillStreakDenied()) {
    self notify("stop_bombing");
    return;
  }

  if(showFx) {
    playFX(level.mortareffect, bombPoint);
    level thread maps\mp\gametypes\_shellshock::stealthAirstrike_earthQuake(bombPoint);
  }

  thread playSoundInSpace("exp_airstrike_bomb", bombPoint);
  radiusArtilleryShellshock(bombPoint, 512, 8, 4, owner.team);
  losRadiusDamage(bombPoint + (0, 0, 16), 896, 300, 50, owner, self, "stealth_bomb_mp");
}

handleHarrierAirstrikeObjectiveIcons() {
  self endon("death");
  self.owner endon("disconnect");

  wait 2;

  self maps\mp\killstreaks\_plane::setObjectiveIcons("hud_minimap_harrier_green", "hud_minimap_harrier_red");
  self thread cleanupHarrierAirstrikeObjectiveIcons();
}

cleanupHarrierAirstrikeObjectiveIcons() {
  friendlyTeamId = self.friendlyTeamId;
  enemyTeamID = self.enemyTeamID;

  self waittill_any_timeout(3.5, "death");

  if(isDefined(friendlyTeamId)) {
    _objective_delete(friendlyTeamId);
    _objective_delete(enemyTeamID);
  }
}

doPlaneStrike(lifeId, owner, requiredDeathCount, bombsite, startPoint, endPoint, bombTime, flyTime, direction, streakName) {
  if(!isDefined(owner)) {
    return;
  }
  startPathRandomness = 100;
  endPathRandomness = 150;

  pathStart = startPoint + ((randomfloat(2) - 1) * startPathRandomness, (randomfloat(2) - 1) * startPathRandomness, 0);
  pathEnd = endPoint + ((randomfloat(2) - 1) * endPathRandomness, (randomfloat(2) - 1) * endPathRandomness, 0);

  plane = spawn("script_model", pathStart);
  plane.owner = owner;
  plane.origin = pathStart;
  plane.angles = direction;
  plane.team = owner.team;

  plane thread handleDeath();

  if(streakName == "harrier_airstrike") {
    plane setModel("vehicle_av8b_harrier_jet_mp");
    plane playLoopSound("harrier_fly_in");
  } else {
    plane setModel("vehicle_a10_warthog_iw6_mp");
    plane playLoopSound("veh_mig29_dist_loop");
  }

  plane thread handleEMP(owner);

  plane.lifeId = lifeId;

  plane.angles = direction;
  forward = anglesToForward(direction);
  plane thread playPlaneFx();
  plane moveTo(pathEnd, flyTime, 0, 0);

  if(streakName == "harrier_airstrike")
    plane thread handleHarrierAirstrikeObjectiveIcons();

  if(getdvar("scr_airstrikedebug") == "1")
    thread airstrikeLine(pathStart, pathEnd, (1, 1, 1), 20);

  thread callStrike_bombEffect(plane, pathEnd, flyTime, bombTime - 1.0, owner, requiredDeathCount, streakName);

  wait(bombTime - .75);
  plane ScriptModelPlayAnimDeltaMotion("airstrike_mp_roll");

  plane endon("death");
  wait(flyTime - bombTime);

  removePlaneFromList(plane);
  plane notify("delete");
  plane delete();
}

handleDeath() {
  level endon("game_ended");
  self endon("delete");

  self waittill("death");

  forward = anglesToForward(self.angles) * 200;
  playFX(level.harrier_deathfx, self.origin, forward);
  removePlaneFromList(self);
  self delete();
}

addPlaneToList(plane) {
  level.planes[level.planes.size] = plane;
}

removePlaneFromList(plane) {
  for(i = 0; i < level.planes.size; i++) {
    if(isDefined(level.planes[i]) && level.planes[i] == plane) {
      level.planes[i] = undefined;
    }
  }
}

callStrike_bombEffect(plane, pathEnd, flyTime, launchTime, owner, requiredDeathCount, streakName) {
  plane endon("death");
  wait(launchTime);

  if(!isDefined(owner) || owner isKillStreakDenied()) {
    return;
  }
  if(streakName == "harrier_airstrike")
    plane PlaySoundOnMovingEnt("harrier_sonic_boom");
  else
    plane PlaySoundOnMovingEnt("veh_mig29_sonic_boom");

  planedir = anglesToForward(plane.angles);

  bomb = spawnbomb(plane.origin, plane.angles);
  bomb MoveGravity((anglesToForward(plane.angles) * (7000 / 1.5)), 3.0);

  bomb.lifeId = requiredDeathCount;

  killCamEnt = spawn("script_model", plane.origin + (0, 0, 100) - planedir * 200);
  bomb.killCamEnt = killCamEnt;
  bomb.killCamEnt SetScriptMoverKillCam("airstrike");
  bomb.airstrikeType = streakName;
  killCamEnt.startTime = gettime();
  killCamEnt thread deleteAfterTime(15.0);
  killCamEnt.angles = planedir;
  killCamEnt moveTo(pathEnd + (0, 0, 100), flyTime, 0, 0);

  if(getdvar("scr_airstrikedebug") == "1")
    bomb thread traceBomb();

  wait .4;

  killCamEnt moveTo(killCamEnt.origin + planedir * 4000, 1, 0, 0);

  wait .45;
  killCamEnt moveTo(killCamEnt.origin + (planedir + (0, 0, -.2)) * 3500, 2, 0, 0);

  wait(0.15);

  newBomb = spawn("script_model", bomb.origin);
  newBomb setModel("tag_origin");
  newBomb.origin = bomb.origin;
  newBomb.angles = bomb.angles;

  bomb setModel("tag_origin");
  wait(0.10);

  bombOrigin = newBomb.origin;
  bombAngles = newBomb.angles;
  if(level.splitscreen)
    playFXOnTag(level.airstrikessfx, newBomb, "tag_origin");
  else
    playFXOnTag(level.airstrikefx, newBomb, "tag_origin");

  wait .05;
  killCamEnt moveTo(killCamEnt.origin + (planedir + (0, 0, -.25)) * 2500, 2, 0, 0);

  wait .25;
  killCamEnt moveTo(killCamEnt.origin + (planedir + (0, 0, -.35)) * 2000, 2, 0, 0);

  wait .2;
  killCamEnt moveTo(killCamEnt.origin + (planedir + (0, 0, -.45)) * 1500, 2, 0, 0);

  wait(0.5);

  repeat = 12;
  minAngles = 5;
  maxAngles = 55;
  angleDiff = (maxAngles - minAngles) / repeat;

  hitpos = (0, 0, 0);

  for(i = 0; i < repeat; i++) {
    traceDir = anglesToForward(bombAngles + (maxAngles - (angleDiff * i), randomInt(10) - 5, 0));
    traceEnd = bombOrigin + (traceDir * 10000);
    trace = bulletTrace(bombOrigin, traceEnd, false, undefined);

    traceHit = trace["position"];
    hitpos += traceHit;

    if(getdvar("scr_airstrikedebug") == "1")
      thread airstrikeLine(bombOrigin, traceHit, (1, 0, 0), 40);

    playFX(level.airstrikeexplosion, traceHit);

    thread losRadiusDamage(traceHit + (0, 0, 16), 512, 200, 30, owner, bomb, "artillery_mp");

    if(i % 3 == 0) {
      thread playsoundinspace("exp_airstrike_bomb", traceHit);
      level thread maps\mp\gametypes\_shellshock::airstrike_earthQuake(traceHit);
    }

    wait(0.05);
  }

  hitpos = hitpos / repeat + (0, 0, 128);
  killCamEnt moveto(bomb.killCamEnt.origin * .35 + hitpos * .65, 1.5, 0, .5);

  wait(5.0);
  newBomb delete();
  bomb delete();
}

spawnbomb(origin, angles) {
  bomb = spawn("script_model", origin);
  bomb.angles = angles;
  bomb setModel("projectile_cbu97_clusterbomb");

  return bomb;
}

deleteAfterTime(time) {
  self endon("death");
  wait(10.0);

  self delete();
}

playPlaneFx() {
  self endon("death");

  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

callStrike(lifeId, owner, coord, yaw, streakName) {
  heightEnt = undefined;
  planeBombExplodeDistance = 0;

  direction = (0, yaw, 0);
  heightEnt = GetEnt("airstrikeheight", "targetname");

  if(streakName == "stealth_airstrike") {
    thread teamPlayerCardSplash("used_stealth_airstrike", owner, owner.team);

    planeHalfDistance = 12000;
    planeFlySpeed = 4000;

    if(!isDefined(heightEnt)) {
      println("NO DEFINED AIRSTRIKE HEIGHT SCRIPT_ORIGIN IN LEVEL");
      planeFlyHeight = 950;
      planeBombExplodeDistance = 1500;
      if(isDefined(level.airstrikeHeightScale))
        planeFlyHeight *= level.airstrikeHeightScale;
    } else {
      planeFlyHeight = heightEnt.origin[2];

      if(GetDvar("mapname") == "mp_exchange")
        planeFlyHeight += 1024;

      planeBombExplodeDistance = getExplodeDistance(planeFlyHeight);
    }

  } else {
    if(streakName == "harrier_airstrike") {
      thread teamPlayerCardSplash("used_harrier", owner);
    }

    planeHalfDistance = 24000;
    planeFlySpeed = 7000;

    if(!isDefined(heightEnt)) {
      println("NO DEFINED AIRSTRIKE HEIGHT SCRIPT_ORIGIN IN LEVEL");
      planeFlyHeight = 850;
      planeBombExplodeDistance = 1500;
      if(isDefined(level.airstrikeHeightScale))
        planeFlyHeight *= level.airstrikeHeightScale;
    } else {
      planeFlyHeight = heightEnt.origin[2];
      planeBombExplodeDistance = getExplodeDistance(planeFlyHeight);
    }
  }

  if(GetDvarInt("scr_debugairstrike")) {
    self thread debugFlyHeight(planeFlyHeight);
  }

  owner endon("disconnect");

  requiredDeathCount = lifeId;

  level.airstrikeDamagedEnts = [];
  level.airStrikeDamagedEntsCount = 0;
  level.airStrikeDamagedEntsIndex = 0;

  if(streakName == "harrier_airstrike") {
    flightPath = getFlightPath(coord, direction, planeHalfDistance, heightEnt, planeFlyHeight, planeFlySpeed, planeBombExplodeDistance, streakName);

    level thread doPlaneStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(500)), flightPath["endPoint"] + (0, 0, randomInt(500)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);

    wait randomfloatrange(1.5, 2.5);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    level thread doPlaneStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(200)), flightPath["endPoint"] + (0, 0, randomInt(200)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);

    wait randomfloatrange(1.5, 2.5);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    level thread doPlaneStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(200)), flightPath["endPoint"] + (0, 0, randomInt(200)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);

    wait randomfloatrange(1.5, 2.5);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    harrier = beginHarrier(lifeId, flightPath["startPoint"], coord);
    owner thread defendLocation(harrier);

  } else if(streakName == "stealth_airstrike") {
    flightPath = getFlightPath(coord, direction, planeHalfDistance, heightEnt, planeFlyHeight, planeFlySpeed, planeBombExplodeDistance, streakName);

    level thread doBomberStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(1000)), flightPath["endPoint"] + (0, 0, randomInt(1000)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);
  } else {
    flightPath = getFlightPath(coord, direction, planeHalfDistance, heightEnt, planeFlyHeight, planeFlySpeed, planeBombExplodeDistance, streakName);

    level thread doPlaneStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(500)), flightPath["endPoint"] + (0, 0, randomInt(500)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);

    wait randomfloatrange(1.5, 2.5);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    level thread doPlaneStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(200)), flightPath["endPoint"] + (0, 0, randomInt(200)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);

    wait randomfloatrange(1.5, 2.5);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    level thread doPlaneStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(200)), flightPath["endPoint"] + (0, 0, randomInt(200)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);

    if(streakName == "super_airstrike") {
      wait randomfloatrange(2.5, 3.5);
      maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
      level thread doPlaneStrike(lifeId, owner, requiredDeathCount, coord, flightPath["startPoint"] + (0, 0, randomInt(200)), flightPath["endPoint"] + (0, 0, randomInt(200)), flightPath["bombTime"], flightPath["flyTime"], direction, streakName);
    }
  }
}

getFlightPath(coord, direction, planeHalfDistance, heightEnt, planeFlyHeight, planeFlySpeed, planeBombExplodeDistance, streakName) {
  startPoint = coord + (anglesToForward(direction) * (-1 * planeHalfDistance));

  if(isDefined(heightEnt))
    startPoint *= (1, 1, 0);

  startPoint += (0, 0, planeFlyHeight);

  if(streakName == "stealth_airstrike")
    endPoint = coord + (anglesToForward(direction) * (planeHalfDistance * 4));
  else
    endPoint = coord + (anglesToForward(direction) * planeHalfDistance);

  if(isDefined(heightEnt))
    endPoint *= (1, 1, 0);

  endPoint += (0, 0, planeFlyHeight);

  d = length(startPoint - endPoint);
  flyTime = (d / planeFlySpeed);

  d = abs(d / 2 + planeBombExplodeDistance);
  bombTime = (d / planeFlySpeed);

  assert(flyTime > bombTime);

  flightPath["startPoint"] = startPoint;
  flightPath["endPoint"] = endPoint;
  flightPath["bombTime"] = bombTime;
  flightPath["flyTime"] = flyTime;

  return flightPath;
}

getExplodeDistance(height) {
  standardHeight = 850;
  standardDistance = 1500;
  distanceFrac = standardHeight / height;

  newDistance = distanceFrac * standardDistance;

  return newDistance;
}

targetGetDist(other, target) {
  infront = targetisinfront(other, target);
  if(infront)
    dir = 1;
  else
    dir = -1;
  a = flat_origin(other.origin);
  b = a + (anglesToForward(flat_angle(other.angles)) * (dir * 100000));
  point = pointOnSegmentNearestToPoint(a, b, target);
  dist = distance(a, point);

  return dist;
}

targetisclose(other, target, closeDist) {
  if(!isDefined(closeDist))
    closeDist = 3000;

  infront = targetisinfront(other, target);
  if(infront)
    dir = 1;
  else
    dir = -1;
  a = flat_origin(other.origin);
  b = a + (anglesToForward(flat_angle(other.angles)) * (dir * 100000));
  point = pointOnSegmentNearestToPoint(a, b, target);
  dist = distance(a, point);
  if(dist < closeDist)
    return true;
  else
    return false;
}

targetisinfront(other, target) {
  forwardvec = anglesToForward(flat_angle(other.angles));
  normalvec = vectorNormalize(flat_origin(target) - other.origin);
  dot = vectordot(forwardvec, normalvec);
  if(dot > 0)
    return true;
  else
    return false;
}

waitForAirstrikeCancel() {
  self waittill("cancel_location");
  self setblurforplayer(0, 0.3);
}

selectAirstrikeLocation(lifeId, streakname) {
  targetSize = level.mapSize / 6.46875;
  if(level.splitscreen)
    targetSize *= 1.5;

  chooseDirection = false;
  switch (streakName) {
    case "precision_airstrike":
      chooseDirection = true;
      self PlayLocalSound(game["voice"][self.team] + "KS_hqr_airstrike");
      break;
    case "stealth_airstrike":
      chooseDirection = true;
      self PlayLocalSound(game["voice"][self.team] + "KS_hqr_bomber");
      break;
  }

  if(streakName != "harrier_airstrike") {
    self _beginLocationSelection(streakname, "map_artillery_selector", chooseDirection, targetSize);
    self endon("stop_location_selection");

    self waittill("confirm_location", location, directionYaw);
  } else {
    playerPositions = [];

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(!isDefined(player.team)) {
        continue;
      }
      if(player.team == self.team) {
        continue;
      }
      playerPositions[playerPositions.size] = player.origin;
    }

    if(playerPositions.size)
      strikePos = AveragePoint(playerPositions);
    else
      strikePos = (0, 0, 0);

    location = strikePos;
    directionYaw = randomint(360);
  }

  if(!chooseDirection)
    directionYaw = randomint(360);

  self setblurforplayer(0, 0.3);

  if(streakname == "harrier_airstrike" && (isDefined(level.harrier_incoming) || level.harriers.size > 1)) {
    self notify("cancel_location");
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  self thread airstrikeMadeSelectionVO(streakName);

  self maps\mp\_matchdata::logKillstreakEvent(streakName, location);

  self thread finishAirstrikeUsage(lifeId, location, directionYaw, streakName);
  return true;
}

finishAirstrikeUsage(lifeId, location, directionYaw, streakName) {
  self notify("used");

  trace = bulletTrace(level.mapCenter + (0, 0, 1000000), level.mapCenter, false, undefined);
  location = (location[0], location[1], trace["position"][2] - 514);

  if(GetDvarInt("scr_debugairstrike")) {
    self thread debugLocation(trace, location);
  }

  thread doAirstrike(lifeId, location, directionYaw, self, self.pers["team"], streakName);
}

useAirstrike(lifeId, pos, yaw) {}

handleEMP(owner) {
  self endon("death");

  if(owner isEMPed()) {
    self notify("death");
    return;
  }

  for(;;) {
    level waittill("emp_update");

    if(!owner isEMPed()) {
      continue;
    }
    self notify("death");
  }
}

airstrikeMadeSelectionVO(streakName) {
  self endon("death");
  self endon("disconnect");

  switch (streakName) {
    case "precision_airstrike":
      self PlayLocalSound(game["voice"][self.team] + "KS_ast_inbound");
      break;
    case "stealth_airstrike":
      self PlayLocalSound(game["voice"][self.team] + "KS_bmb_inbound");
      break;
  }
}