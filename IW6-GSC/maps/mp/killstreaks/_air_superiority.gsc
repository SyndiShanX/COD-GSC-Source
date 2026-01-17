/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_air_superiority.gsc
****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

KS_NAME = "air_superiority";
kProjectileName = "aamissile_projectile_mp";

init() {
  config = spawnStruct();
  config.modelNames = [];
  config.modelNames["allies"] = "vehicle_a10_warthog_iw6_mp";
  config.modelNames["axis"] = "vehicle_a10_warthog_iw6_mp";
  config.inboundSfx = "veh_mig29_dist_loop";

  config.compassIconFriendly = "compass_objpoint_airstrike_friendly";
  config.compassIconEnemy = "compass_objpoint_airstrike_busy";

  config.speed = 4000;
  config.halfDistance = 20000;
  config.distFromPlayer = 4000;
  config.heightRange = 250;

  config.numMissileVolleys = 3;
  config.outboundFlightAnim = "airstrike_mp_roll";
  config.sonicBoomSfx = "veh_mig29_sonic_boom";
  config.onAttackDelegate = ::attackEnemyAircraft;
  config.onFlybyCompleteDelegate = ::cleanupFlyby;
  config.xpPopup = "destroyed_air_superiority";
  config.callout = "callout_destroyed_air_superiority";
  config.voDestroyed = undefined;
  config.killCamOffset = (-800, 0, 200);

  level.planeConfigs[KS_NAME] = config;

  level.killstreakFuncs[KS_NAME] = ::onUse;

  level.teamAirDenied["axis"] = false;
  level.teamAirDenied["allies"] = false;
}

onUse(lifeId, streakName) {
  assert(isDefined(self));

  otherTeam = getOtherTeam(self.team);
  if((level.teamBased && level.teamAirDenied[otherTeam]) ||
    (!level.teamBased && isDefined(level.airDeniedPlayer) && level.airDeniedPlayer == self)
  ) {
    self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else {
    self thread doStrike(lifeId, KS_NAME);

    self maps\mp\_matchdata::logKillstreakEvent("air_superiority", self.origin);
    self thread teamPlayerCardSplash("used_air_superiority", self);

    return true;
  }

}

doStrike(lifeId, streakName) {
  config = level.planeConfigs[streakName];

  flightPlan = self maps\mp\killstreaks\_plane::getPlaneFlightPlan(config.distFromPlayer);

  wait(1);

  targetTeam = getOtherTeam(self.team);

  level.teamAirDenied[targetTeam] = true;
  level.airDeniedPlayer = self;

  doOneFlyby(streakName, lifeId, flightPlan.targetPos, flightPlan.flightDir, flightPlan.height);

  self waittill("aa_flyby_complete");

  wait(2);
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(isDefined(self)) {
    doOneFlyby(streakName, lifeId, flightPlan.targetPos, -1 * flightPlan.flightDir, flightPlan.height);

    self waittill("aa_flyby_complete");
  }

  level.teamAirDenied[targetTeam] = false;
  level.airDeniedPlayer = undefined;
}

doOneFlyby(streakName, lifeId, targetPos, dir, flyHeight) {
  config = level.planeConfigs[streakName];

  flightPath = maps\mp\killstreaks\_plane::getFlightPath(targetPos, dir, config.halfDistance, true, flyHeight, config.speed, -0.5 * config.halfDistance, streakName);

  level thread maps\mp\killstreaks\_plane::doFlyby(lifeId, self, lifeId,
    flightPath["startPoint"] + (0, 0, randomInt(config.heightRange)),
    flightPath["endPoint"] + (0, 0, randomInt(config.heightRange)),
    flightPath["attackTime"],
    flightPath["flyTime"],
    dir,
    streakName);
}

attackEnemyAircraft(pathEnd, flyTime, beginAttackTime, owner, streakName) {
  self endon("death");
  self.owner endon("killstreak_disowned");
  level endon("game_ended");

  wait(beginAttackTime);

  targets = findAllTargets(self.owner, self.team);
  config = level.planeConfigs[streakName];
  numVolleys = config.numMissileVolleys;
  targetIndex = targets.size - 1;

  while(targetIndex >= 0 &&
    numVolleys > 0
  ) {
    target = targets[targetIndex];
    if(isDefined(target) && IsAlive(target)) {
      self fireAtTarget(target);
      numVolleys--;
      wait(1);
    }
    targetIndex--;
  }
}

cleanupFlyby(owner, plane, streakName) {
  owner notify("aa_flyby_complete");
}

findTargetsOfType(attacker, victimTeam, checkFunc, candidateList, curTargetsStruct) {
  if(isDefined(candidateList)) {
    foreach(target in candidateList) {
      if([[checkFunc]](attacker, victimTeam, target)) {
        curTargetsStruct.targets[curTargetsStruct.targets.size] = target;
      }
    }
  }

  return curTargetsStruct;
}

findAllTargets(attacker, attackerTeam) {
  wrapper = spawnStruct();
  wrapper.targets = [];

  isEnemyFunc = undefined;
  if(level.teamBased) {
    isEnemyFunc = ::isValidTeamTarget;
  } else {
    isEnemyFunc = ::isValidFFATarget;
  }
  victimTeam = undefined;
  if(isDefined(attackerTeam)) {
    victimTeam = getOtherTeam(attackerTeam);
  }

  findTargetsOfType(attacker, victimTeam, isEnemyFunc, level.heli_pilot, wrapper);
  if(isDefined(level.lbSniper)) {
    if([
        [isEnemyFunc]
      ](attacker, victimTeam, level.lbSniper)) {
      wrapper.targets[wrapper.targets.size] = level.lbSniper;
    }
  }

  findTargetsOfType(attacker, victimTeam, isEnemyFunc, level.planes, wrapper);

  findTargetsOfType(attacker, victimTeam, isEnemyFunc, level.littleBirds, wrapper);
  findTargetsOfType(attacker, victimTeam, isEnemyFunc, level.helis, wrapper);

  return wrapper.targets;
}

fireAtTarget(curTarget) {
  if(!isDefined(curTarget)) {
    return;
  }
  owner = undefined;
  if(isDefined(self.owner))
    owner = self.owner;

  forwardVec = 384 * anglesToForward(self.angles);

  startpoint = self GetTagOrigin("tag_missile_1") + forwardVec;
  rocket1 = MagicBullet(kProjectileName, startPoint, startPoint + forwardVec, owner);
  rocket1.vehicle_fired_from = self;

  startpoint = self GetTagOrigin("tag_missile_2") + forwardVec;
  rocket2 = MagicBullet(kProjectileName, startPoint, startPoint + forwardVec, owner);
  rocket2.vehicle_fired_from = self;

  missiles = [rocket1, rocket2];
  curTarget notify("targeted_by_incoming_missile", missiles);

  self thread startMissileGuidance(curTarget, 0.25, missiles);
}

startMissileGuidance(curTarget, igniteTime, missileArray) {
  wait(igniteTime);

  if(isDefined(curTarget)) {
    targetPoint = undefined;

    if(curTarget.model != "vehicle_av8b_harrier_jet_mp")
      targetPoint = curTarget GetTagOrigin("tag_missile_target");
    if(!isDefined(targetPoint)) {
      targetPoint = curTarget GetTagOrigin("tag_body");
    }
    targetOffset = targetPoint - curTarget.origin;

    foreach(missile in missileArray) {
      if(IsValidMissile(missile)) {
        missile Missile_SetTargetEnt(curTarget, targetOffset);
        missile Missile_SetFlightmodeDirect();
      }
    }
  }
}

destroyActiveVehicles(attacker, victimTeam) {
  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", level.helis);
  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", level.littleBirds);
  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", level.heli_pilot);
  if(isDefined(level.lbSniper)) {
    tempArray = [];
    tempArray[0] = level.lbSniper;
    maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", tempArray);
  }

  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", level.remote_uav);
  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", level.planes);
}