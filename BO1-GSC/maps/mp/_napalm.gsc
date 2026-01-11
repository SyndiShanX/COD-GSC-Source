/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_napalm.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_airsupport;

init() {
  level.napalmDangerMaxRadius = 750;
  level.napalmDangerMaxRadiusSq = level.napalmDangerMaxRadius * level.napalmDangerMaxRadius;
  PrecacheRumble("plane_rumble");
  level.alliesplaneModel = "t5_veh_jet_f4_gearup";
  axisplaneModel = "t5_veh_jet_f4_gearup";
  precacheModel(level.alliesplaneModel);
  level.fx_napalm_bomb = loadfx("weapon/napalm/fx_napalm_drop_mp");
  level.fx_flame_lg = "napalmground_lg_mp";
  level.fx_flame_sm = "napalmground_sm_mp";
  precacheItem(level.fx_flame_lg);
  precacheItem(level.fx_flame_sm);
  level.napalmImpactDamageRadius = getDvarIntDefault(#"scr_napalmImpactDamageRadius", 512);
  burnNapalmEffectRadiusSmall = getDvarIntDefault(#"scr_burnNapalmEffectRadiusSmall", 100.0);
  burnNapalmEffectRadiusLarge = getDvarIntDefault(#"scr_burnNapalmEffectRadiusLarge", 150.0);
  level.burnNapalmEffectRadiusSmall = 100;
  level.burnNapalmEffectRadiusLarge = 200;
  level.burnNapalmDuration = 13;
  level.napalmGroundDamage = 51;
  level.groundBurnTime = 3;
  level.napalm_spawnprotection = getDvarIntDefault("scr_napalm_spawnprotection", 5);
  precacheLocationSelector("map_napalm_selector");
  PrecacheRumble("artillery_rumble");
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allownapalm")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("napalm_mp", "napalm_mp", "killstreak_napalm", "napalm_used", ::useKillstreakNapalm, true);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("napalm_mp", &"MP_EARNED_NAPALM", &"KILLSTREAK_NAPALM_NOT_AVAILABLE", &"MP_WAR_NAPALM_INBOUND", &"MP_WAR_NAPALM_INBOUND_NEAR_YOUR_POSITION");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("napalm_mp", "mpl_killstreak_napalm", "kls_napalm_used", "", "kls_napalm_enemy", "", "kls_napalm_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("napalm_mp", "scr_givenapalm");
  }
  level.napalmFlameMinAngle = 25;
  level.napalmFlameMaxAngle = 40;
}
useKillstreakNapalm(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  result = self maps\mp\_napalm::selectNapalmLocation(hardpointType);
  if(!isDefined(result) || !result) {
    return false;
  }
  return true;
}
selectNapalmLocation(hardpointType) {
  napalmSelectorSize = getDvarIntDefault(#"scr_napalmSelectorSize", 3000);
  self beginLocationNapalmSelection("map_napalm_selector", napalmSelectorSize, "killstreak_napalm");
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
  return self finishDualHardpointLocationUsage(location, int(yaw), ::useNapalm);
}
useNapalm(origin, yaw) {
  if(self maps\mp\_killstreakrules::killstreakStart("napalm_mp", self.team) == false) {
    return false;
  }
  if(maps\mp\gametypes\_tweakables::getTweakableValue("team", "allowHardpointStreakAfterDeath")) {
    ownerDeathCount = self.deathCount;
  } else {
    ownerDeathCount = self.pers["hardPointItemDeathCountnapalm_mp"];
  }
  thread doNapalm(origin, yaw, self, self.team);
  return true;
}
callNapalmStrike(owner, targetPos, startPoint, endPoint, yaw, planeFlyHeight) {
  level.napalmDamagedEnts = [];
  level.napalmDamagedEntsCount = 0;
  level.napalmDamagedEntsIndex = 0;
  level.napalmGroundFlameEnts = [];
  level.napalmGroundFlameCount = 0;
  level notify("napalm strike");
  planeBombExplodeDistance = 1500;
  planeFlySpeed = 7000;
  direction = (0, yaw, 0);
  debugDirection = direction;
  heightAboveGround = planeFlyHeight - targetPos[2];
  d = length(startPoint - endPoint);
  flyTime = (d / planeFlySpeed);
  d = abs(d / 2 + planeBombExplodeDistance);
  bombTime = (d / planeFlySpeed);
  assert(flyTime > bombTime);
  requiredDeathCount = owner.deathCount;
  plane = Spawnplane(owner, "script_model", startPoint);
  plane.angles = direction;
  wait(0.2);
  plane setModel(level.alliesplaneModel);
  plane setClientFlag(level.const_flag_napalm);
  team = owner.team;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] PlayRumbleOnEntity("plane_rumble");
  }
  exitRatio = 0.5;
  destPoint = getPointOnLine(startPoint, endPoint, exitRatio);
  plane moveTo(endPoint, flyTime, 0, 0);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] PlayRumbleOnEntity("plane_rumble");
  }
  planedir = anglesToForward(plane.angles);
  killcamEntities = createKillcams(startPoint, destPoint, planedir, flyTime * 0.5);
  level.napalmDamagedEnts = [];
  level.napalmDamagedEntsCount = 0;
  level.napalmDamagedEntsIndex = 0;
  level.napalmGroundFlameEnts = [];
  level.napalmGroundFlameCount = 0;
  level thread releaseNapalm(owner, plane, requiredDeathCount, targetPos, startPoint, endPoint, bombTime, flyTime, direction, yaw, heightAboveGround, killcamEntities, 0, (0.5, 0.5, 0));
  wait(0.2);
  level thread releaseNapalm(owner, plane, requiredDeathCount, targetPos, startPoint, endPoint, bombTime, flyTime, direction, yaw, heightAboveGround, killcamEntities, 2, (0.5, 0, 0.5));
  wait(0.2);
  level thread releaseNapalm(owner, plane, requiredDeathCount, targetPos, startPoint, endPoint, bombTime, flyTime, direction, yaw, heightAboveGround, killcamEntities, 4, (0, 0.5, 0.5));
  exitType = owner getPlaneExitType();
  wait((flyTime * 0.5) - 0.4);
  planeExit(plane, yaw, flytime, startPoint, endPoint, exitRatio, exitType);
  plane delete();
}
createKillcams(startPoint, destPoint, planedir, flyTime) {
  killcamEntities = [];
  for(i = 0; i < 6; i++) {
    killcamEntities[killcamEntities.size] = createBombKillcamEnt(startPoint, destPoint, planedir, flyTime);
  }
  return killcamEntities;
}
createBombKillcamEnt(origin, endPoint, dir, time) {
  height = getDvarIntDefault(#"scr_napalmkillcamheight", 256);
  offset = getDvarIntDefault(#"scr_napalmkillcamoffset", 700);
  killCamEnt = spawn("script_model", origin + (0, 0, height) - dir * offset);
  killCamEnt thread deleteAfterTime(25.0);
  killCamEnt moveTo(endPoint + (0, 0, height), time, 0, 0);
  killCamEnt.startTime = gettime() + 2500;
  killCamEnt thread debug_draw_bomb_path(undefined, (0, 0.5, 0), 400);
  killCamEnt.offsetPoint = dir * 300;
  return killCamEnt;
}
dropBombKillcam(velocity, heightAboveGround) {
  velocityScale = getDvarFloatDefault(#"scr_killcamVelocityScale", 0.75);
  killcamFallTime = calculateFallTime(heightAboveGround - getDvarFloatDefault(#"scr_killcamStopHeight", 0));
  self MoveGravity(velocity * velocityScale, killcamFallTime);
  self waittill("movedone");
  finalDistance = getDvarFloatDefault(#"scr_killcamFinalDistance", 2000);
  finalTime = getDvarFloatDefault(#"scr_killcamFinalTime", 10);
  dir = vectornormalize((velocity[0], velocity[1], 0));
  endPoint = self.origin + dir * finalDistance;
  self moveto(endPoint, finalTime);
}
doBombKillcams(killcamEntities, killcamIndex, velocity, heightAboveGround) {
  killcamEntities[killcamIndex] thread dropBombKillcam(velocity, heightAboveGround);
  wait(0.1);
  killcamEntities[killcamIndex + 1] thread dropBombKillcam(velocity, heightAboveGround);
}
createGroundFlameEnt(origin) {
  groundFlameEnt = spawn("script_model", origin);
  if(isDefined(groundFlameEnt)) {
    groundFlameEnt playSound("mpl_kls_napalm_exlpo");
    groundFlameEnt playLoopSound("mpl_kls_napalm_fire");
    groundFlameEnt thread stopLoopSoundAfterTime(13.0);
  }
  return groundFlameEnt;
}
callStrike_bombEffect(plane, pathEnd, flyTime, launchTime, owner, requiredDeathCount, yaw, heightAboveGround, killcamEntities, killcamIndex, debugColor) {
  owner endon("disconnect");
  mutex = gettime();
  bombSpeedScale = 1 / 2;
  planeflyspeed = 7000;
  bombWait = calculateReleaseTime(flyTime, heightAboveGround, planeflyspeed, bombSpeedScale);
  if(bombWait < 0.0) {
    bombWait = 0.0;
  }
  wait(bombWait);
  planedir = anglesToForward(plane.angles);
  velocity = vector_scale(anglesToForward(plane.angles), planeflyspeed * bombSpeedScale);
  bomb = owner launchbomb("napalm_mp", plane.origin, velocity);
  assert(isDefined(bomb));
  if(!isDefined(bomb)) {
    return;
  }
  bomb.killCamEntities = killcamEntities;
  thread doBombKillcams(killcamEntities, killcamIndex, velocity, heightAboveGround);
  fallTime = calculateFallTime(heightAboveGround);
  fxTimer = fallTime - 0.5;
  if(fxTimer < 0.1) {
    fxTimer = 0.1;
  }
  bomb.ownerRequiredDeathCount = requiredDeathCount;
  wait(fxTimer);
  if(!isDefined(bomb)) {
    return;
  }
  originalBombAngles = bomb.angles;
  originalBombOrigin = bomb.origin;
  fakeBomb = spawn("script_model", originalBombOrigin);
  fakeBomb thread deleteAfterTime(20.0);
  fakeBomb setModel("tag_origin");
  fakeBomb.origin = originalBombOrigin;
  fakeBomb.angles = originalBombAngles;
  fakeBomb.killCamEntities = killcamEntities;
  if(isDefined(bomb)) {
    bomb setModel("tag_origin");
  }
  wait(0.10);
  playFXOnTag(level.fx_napalm_bomb, fakeBomb, "tag_origin");
  wait 0.05;
  if(!isDefined(bomb) || !isDefined(bomb.origin)) {
    bombOrigin = originalBombOrigin;
  }
  else {
    bombOrigin = bomb.origin;
  }
  bombAngles = fakeBomb.angles;
  repeat = 7;
  minAngles = getDvarIntDefault(#"scr_napalm_minAngles", 5);
  maxAngles = getDvarIntDefault(#"scr_napalm_maxAngles", 60);
  angleDiff = (maxAngles - minAngles) / repeat;
  hitpos = (0, 0, 0);
  previousHeight = 0;
  bombDir = anglesToForward(originalBombAngles);
  traceDir = anglesToForward(originalBombAngles + (maxAngles, 0, 0));
  traceEnd = bombOrigin + vector_scale(traceDir, 10000);
  traceStart = bombOrigin - vector_scale(traceDir, 50);
  trace = bulletTrace(traceStart, traceEnd, false, undefined);
  groundFlameEnt = createGroundFlameEnt(trace["position"]);
  seperation = getDvarIntDefault(#"scr_napalm_seperation", 200);
  for(i = 0; i < repeat; i++) {
    traceStart = (bombOrigin - vector_scale(traceDir, 50)) + (bombDir * (seperation * (i + 1)));
    traceEnd = traceStart + vector_scale(traceDir, 10000);
    trace = bulletTrace(traceStart, traceEnd, false, undefined);
    traceHit = trace["position"];
    if(!isDefined(traceHit)) {
      continue;
    }
    hitpos += traceHit;
    hitNormal = trace["normal"];
    currentHeight = traceHit[2];
    thread debug_line(traceStart, traceHit, (1, 0, 0), 400);
    if(hitNormal[2] > 0.5) {
      fxToPlay = level.fx_flame_sm;
      burnNapalmEffectRadius = getDvarIntDefault(#"scr_burnNapalmEffectRadiusSmall", level.burnNapalmEffectRadiusSmall);
      if(i > 0 && i < repeat - 1) {
        heightDifference = previousHeight - currentHeight;
        if(heightDifference < 12 && heightDifference > -12) {
          fxToPlay = level.fx_flame_lg;
          burnNapalmEffectRadius = getDvarIntDefault(#"scr_burnNapalmEffectRadiusLarge", level.burnNapalmEffectRadiusLarge);
        }
      }
      napalmImpactDamageRadius = getDvarIntDefault(#"scr_napalmImpactDamageRadius", level.napalmImpactDamageRadius);
      thread napalmLosRadiusDamage(traceHit + (0, 0, 16), napalmImpactDamageRadius, 200, 30, owner, fakeBomb, hitNormal, i, fxToPlay, yaw, burnNapalmEffectRadius, groundFlameEnt, killCamEntities, debugColor);
    }
    previousHeight = currentHeight;
    wait(0.50);
  }
  hitpos = hitpos / repeat + (0, 0, 128);
  wait(4.0);
}
unlinkKillcam(timer) {
  self.angles = (0, 0, 0);
  if(timer > 0.0) {
    wait(timer);
  }
  self unlink();
}
callStrike_flareEffect(plane, pathEnd, flyTime, owner, heightAboveGround) {
  planeflyspeed = 7000;
  flareSpeedScale = 1 / 3;
  flareWait = calculateReleaseTime(flyTime, heightAboveGround, planeflyspeed, flareSpeedScale);
  wait(flareWait);
  planedir = anglesToForward(plane.angles);
  velocity = vector_scale(anglesToForward(plane.angles), planeflyspeed * flareSpeedScale);
  flare = owner launchbomb("napalmflare_mp", plane.origin, velocity);
  owner waittill("projectile_impact", name, position, explosionRadius);
  debug_star(position, (0, 0, 1));
  playFX(level.fx_napalm_marker, position);
  snd_flare_ent = spawn("script_origin", position);
  snd_flare_ent playLoopSound("mpl_kls_marker_loop");
  wait(5);
  snd_flare_ent delete();
}
releaseNapalm(owner, plane, requiredDeathCount, bombsite, startPoint, endPoint, bombTime, flyTime, direction, yaw, heightAboveGround, killcamEntities, killcamIndex, debugColor) {
  if(!isDefined(owner)) {
    return;
  }
  startPathRandomness = 100;
  endPathRandomness = 150;
  pathStart = startPoint;
  pathEnd = endPoint;
  forward = anglesToForward(direction);
  thread debug_line(pathStart, pathEnd, (1, 1, 1), 10);
  thread callStrike_bombEffect(plane, pathEnd, flyTime, bombTime - 1.0, owner, requiredDeathCount, yaw, heightAboveGround, killcamEntities, killcamIndex, debugColor);
}
anyCloseGroundFlameEnts(pos) {
  radiusSqr = 150 * 150;
  for(index = 0; index < level.napalmGroundFlameCount; index++) {
    if(!isDefined(level.napalmGroundFlameEnts[index])) {
      continue;
    }
    if(DistanceSquared(pos, level.napalmGroundFlameEnts[index].origin) < radiusSqr) {
      return true;
    }
  }
  return false;
}
doFlameDamage() {
  self.entity endon("death");
  if((self.isPlayer || self.isActor) && IsAlive(self.entity)) {
    if(!anyCloseGroundFlameEnts(self.pos)) {
      groundFlameEnt = createGroundFlameEnt(self.pos);
      groundFlameEnt spawnGroundFlame(self.pos, self.fxToPlay, self.fxAngles, self.killCamEntities);
      println("CREATING GROUND FLAME");
      wait(0.25);
    }
  }
  self maps\mp\gametypes\_weapons::damageEnt(
    self.eInflictor,
    self.damageOwner,
    self.damage,
    "MOD_BURNED",
    "napalm_mp",
    self.pos,
    vectornormalize(self.damageCenter - self.pos)
  );
}
napalmDamageEntsThread() {
  self notify("napalmDamageEntsThread");
  self endon("napalmDamageEntsThread");
  for(; level.napalmDamagedEntsIndex < level.napalmDamagedEntsCount; level.napalmDamagedEntsIndex++) {
    if(!isDefined(level.napalmDamagedEnts[level.napalmDamagedEntsIndex])) {
      continue;
    }
    ent = level.napalmDamagedEnts[level.napalmDamagedEntsIndex];
    if(!isDefined(ent.entity)) {
      continue;
    }
    if((!ent.isPlayer && !ent.isActor) || isAlive(ent.entity)) {
      if(ent.isPlayer && isDefined(ent.spawntime) && (gettime() - ent.spawntime) / 1000 <= level.napalm_spawnprotection) {
        continue;
      }
      ent thread doFlameDamage();
      level.napalmDamagedEnts[level.napalmDamagedEntsIndex] = undefined;
      if(ent.isPlayer || ent.isActor) {
        wait(0.05);
      }
    } else {
      level.napalmDamagedEnts[level.napalmDamagedEntsIndex] = undefined;
    }
  }
}
clearGroundFlameEnt(index) {
  level endon("napalm strike");
  self waittill("death");
  level.napalmGroundFlameEnts[index] = undefined;
}
spawnGroundFlame(pos, fxToPlay, fxAngles, killCamEntities) {
  self SpawnNapalmGroundFlame(pos - (0, 0, 16), fxToPlay, fxAngles);
  self.killCamEntities = killCamEntities;
  level.napalmGroundFlameEnts[level.napalmGroundFlameCount] = self;
  self thread clearGroundFlameEnt(level.napalmGroundFlameCount);
  level.napalmGroundFlameCount++;
}
napalmLosRadiusDamage(pos, radius, max, min, owner, eInflictor, normal, waitframes, fxToPlay, yaw, burnNapalmEffectRadius, groundFlameEnt, killCamEntities, debugColor) {
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  waittime = 0.5 - (waitframes * 0.1);
  if(waittime > 0) {
    wait(waittime);
  }
  fxAngles = (270, yaw - 180, 0);
  groundFlameEnt spawnGroundFlame(pos, fxToPlay, fxAngles, killCamEntities);
  wait(0.25);
  thread doGlassDamage(pos, radius, max, min, "MOD_EXPLOSIVE");
  pixbeginevent("napalm losRadiusDamage");
  ents = maps\mp\gametypes\_weapons::getDamageableEnts(pos, radius, true);
  for(i = 0; i < ents.size; i++) {
    if(ents[i].entity == self) {
      continue;
    }
    if(entLOSRadiusDamage(ents[i], pos, radius, max, min, owner, eInflictor)) {
      ents[i].fxToPlay = fxToPlay;
      ents[i].fxAngles = fxAngles;
      ents[i].damageWait = waittime;
      ents[i].killcamEntities = killCamEntities;
      level.napalmDamagedEnts[level.napalmDamagedEntsCount] = ents[i];
      level.napalmDamagedEntsCount++;
    }
  }
  pixendevent();
  thread napalmDamageEntsThread();
  watchNapalmBurn(owner, groundflameEnt, pos, burnNapalmEffectRadius, debugColor);
}
watchNapalmBurn(owner, eInflictor, pos, burnNapalmEffectRadius, debugColor) {
  napalmGroundBurnArea = spawn("trigger_radius", pos, 0, burnNapalmEffectRadius, burnNapalmEffectRadius * 2);
  loopWaitTime = 0.25;
  burnNapalmDuration = getDvarIntDefault(#"scr_burnNapalmDuration", level.burnNapalmDuration);
  napalmBurnDist2 = burnNapalmEffectRadius * burnNapalmEffectRadius;
  while(burnNapalmDuration > 0) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i].item)) {
        players[i].item = 0;
      }
      if(isDefined(players[i].spawntime) && (gettime() - players[i].spawntime) / 1000 <= level.napalm_spawnprotection) {
        continue;
      }
      if((!isDefined(players[i].inGroundNapalm)) || (players[i].inGroundNapalm == false)) {
        if(players[i].sessionstate == "playing") {
          debug_star(pos, debugColor, 400);
          dist2 = DistanceSquared(players[i].origin, pos);
          if(dist2 < napalmBurnDist2) {
            if((pos[2] - players[i].origin[2]) > 80) {
              continue;
            }
            if((players[i].origin[2] - pos[2]) > 100) {
              continue;
            }
            players[i].napalmlastburntby = owner;
            players[i] thread maps\mp\_burnplayer::doNapalmGroundDamage(owner, eInflictor, "MOD_BURNED");
          }
        }
      }
    }
    wait(loopWaitTime);
    burnNapalmDuration -= loopWaitTime;
  }
  napalmGroundBurnArea delete();
}
doNapalm(origin, yaw, owner, team) {
  planeHalfDistance = 24000;
  direction = (0, yaw, 0);
  startPoint = origin + vector_scale(anglesToForward(direction), -1 * planeHalfDistance);
  endPoint = origin + vector_scale(anglesToForward(direction), planeHalfDistance);
  minHeight = int(maps\mp\_airsupport::getMinimumFlyHeight());
  startPoint = (startPoint[0], startPoint[1], minHeight);
  endPoint = (endPoint[0], endPoint[1], minHeight);
  planeFlyHeight = int(getNoFlyZoneHeightCrossed(startPoint, endPoint, minHeight));
  origin = (origin[0], origin[1], planeFlyHeight);
  startPoint = (startPoint[0], startPoint[1], planeFlyHeight);
  endPoint = (endPoint[0], endPoint[1], planeFlyHeight);
  trace = bulletTrace(origin, origin + (0, 0, -4000), false, undefined);
  targetpos = trace["position"];
  maxs = level.spawnMaxs[2] + 200;
  mins = level.spawnMins[2] - 200;
  if(targetpos[2] > maxs) {
    targetpos = (targetpos[0], targetpos[1], maxs);
  } else if(targetpos[2] < mins) {
    targetpos = (targetpos[0], targetpos[1], mins);
  }
  owner maps\mp\gametypes\_hardpoints::playKillstreakStartDialog("napalm_mp", team);
  owner maps\mp\gametypes\_persistence::statAdd("NAPALM_USED", 1, false);
  if(isDefined(level.globalKillstreaksCalled)) {
    level.globalKillstreaksCalled++;
  }
  self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_napalm", 1, "used");
  if(!isDefined(owner)) {
    maps\mp\_killstreakrules::killstreakStop("napalm_mp", team);
    return;
  }
  owner notify("begin_napalm");
  ownerEntNum = owner GetEntityNumber();
  if(level.teambased) {
    teamType = owner.team;
  }
  else {
    teamType = "free";
  }
  burnNapalmDuration = getDvarFloatDefault("scr_burnNapalmDuration", level.burnNapalmDuration);
  influencer_org = targetpos + vector_scale(anglesToForward(direction), 0);
  maps\mp\gametypes\_spawning::create_napalm_fire_influencers(influencer_org, direction, team, level.burnNapalmDuration + 5.5);
  callNapalmStrike(owner, targetpos, startPoint, endPoint, yaw, planeFlyHeight);
  maps\mp\_killstreakrules::killstreakStop("napalm_mp", team);
}
targetisclose(other, target) {
  infront = targetisinfront(other, target);
  if(infront) {
    dir = 1;
  }
  else {
    dir = -1;
  }
  a = flat_origin(other.origin);
  b = a + vector_scale(anglesToForward(flat_angle(other.angles)), (dir * 100000));
  point = pointOnSegmentNearestToPoint(a, b, target);
  dist = distance(a, point);
  if(dist < 3000) {
    return true;
  }
  else {
    return false;
  }
}
targetisinfront(other, target) {
  forwardvec = anglesToForward(flat_angle(other.angles));
  normalvec = vectorNormalize(flat_origin(target) - other.origin);
  dot = vectordot(forwardvec, normalvec);
  if(dot > 0) {
    return true;
  }
  else {
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
flaten_vector(vector) {
  flatVec = (vector[0], vector[1], 0);
  return flatVec;
}
getPlaneExitType() {
  exitType = randomInt(8);
  return exitType;
}
getScoreRank() {
  players = get_players();
  rank = players.size;
  if(!isDefined(self.score) || self.score < 1) {
    return undefined;
  }
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].score) || players[i].score < 1) {
      rank--;
      continue;
    }
    if(players[i].score < self.score) {
      rank--;
    }
  }
  return rank;
}
planeExit(plane, yaw, flytime, startPoint, endPoint, destratio, exitType) {
  halflife = getDvarFloatDefault(#"scr_napalmhalflife", 2.0);
  exitType = int(exitType);
  if(exitType != -1) {
    exitType = exitType % 2;
  }
  switch (exitType) {
    case 0:
      planeTurnSimple(plane, startPoint, endPoint, flytime, false);
      break;
    case 1:
      planeTurnSimple(plane, startPoint, endPoint, flytime, true);
      break;
    default:
      planeGoStraight(plane, startPoint, endPoint, flytime);
      plane waittill("movedone");
      break;
  }
}
planeGoStraight(plane, startPoint, endPoint, moveTime) {
  plane endon("delete");
  level endon("demo_jump");
  distanceIncreaseRatio = 1.2;
  destPoint = getPointOnLine(startPoint, endPoint, distanceIncreaseRatio);
  plane moveto(destPoint, moveTime);
  plane waittill("movedone");
}
planeTurnSimple(plane, startPoint, endPoint, moveTime, isTurningRight) {
  plane endon("delete");
  level endon("demo_jump");
  leftTurn = -1;
  rightTurn = 1;
  if(isTurningRight) {
    turnDirection = rightTurn;
  }
  else {
    turnDirection = leftTurn;
  }
  radius = 25000;
  angles = VectorToAngles(endPoint - startPoint);
  right = anglestoright(angles);
  right = VectorNormalize(right);
  turn_rig_origin = plane.origin + ((radius * turnDirection) * right);
  turn_rig = spawn("script_model", turn_rig_origin);
  turn_rig setModel("tag_origin");
  turn_rig.angles = (0, 0, 0);
  turn_rig hide();
  turn_rig thread delete_with_plane(plane);
  debug_circle(turn_rig_origin, radius, (1, 0, 0), 400);
  debug_sphere(turn_rig_origin, 20, (1, 0, 0), 1, 400);
  velocity = get_velocity(startPoint, endPoint, moveTime);
  rotate_amount_per_second = 360 / get_rotations_per_second(velocity, radius);
  rotate = -1 * turnDirection * (0, rotate_amount_per_second, 0);
  turn_rig RotateTo(rotate * 0.5, moveTime * 0.5);
  wait(0.2);
  turn_rig_origin = plane.origin + ((radius * turnDirection) * right);
  turn_rig.origin = turn_rig_origin;
  plane LinkTo(turn_rig);
  turn_rig waittill("rotatedone");
  plane Unlink();
}
get_rotations_per_second(velocity, radius) {
  pi = 3.14159;
  two_pi = 2 * pi;
  rotations = velocity / (two_pi * radius);
  return (rotations * (180.0 / pi));
}
get_velocity(startPoint, endPoint, moveTime) {
  seconds = moveTime * 0.001;
  velocity = Distance(startPoint, endPoint) / moveTime;
  return velocity;
}
delete_with_plane(plane) {
  self endon("delete");
  plane waittill("delete");
  self Delete();
}