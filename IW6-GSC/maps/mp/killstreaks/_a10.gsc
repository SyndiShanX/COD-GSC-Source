/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_a10.gsc
****************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

KS_NAME = "a10_strafe";
kTransitionTime = 0.75;
kLockIconOffset = (0, 0, -70);
init() {
  precacheLocationSelector("map_artillery_selector");

  config = spawnStruct();
  config.modelNames = [];
  config.modelNames["allies"] = "vehicle_a10_warthog_iw6_mp";
  config.modelNames["axis"] = "vehicle_a10_warthog_iw6_mp";
  config.vehicle = "a10_warthog_mp";
  config.inboundSfx = "veh_mig29_dist_loop";

  config.speed = 3000;
  config.halfDistance = 12500;
  config.heightRange = 750;
  config.chooseDirection = true;
  config.selectLocationVO = "KS_hqr_airstrike";
  config.inboundVO = "KS_ast_inbound";

  config.cannonFireVfx = LoadFX("fx/smoke/smoke_trail_white_heli");
  config.cannonRumble = "ac130_25mm_fire";
  config.turretName = "a10_30mm_turret_mp";
  config.turretAttachPoint = "tag_barrel";
  config.rocketModelName = "maverick_projectile_mp";
  config.numRockets = 4;
  config.delayBetweenRockets = 0.125;
  config.delayBetweenLockon = 0.4;
  config.lockonIcon = "veh_hud_target_chopperfly";

  config.maxHealth = 1000;
  config.xpPopup = "destroyed_a10_strafe";
  config.callout = "callout_destroyed_a10";
  config.voDestroyed = undefined;
  config.explodeVfx = LoadFX("fx/explosions/aerial_explosion");

  config.sfxCannonFireLoop_1p = "veh_a10_plr_fire_gatling_lp";
  config.sfxCannonFireStop_1p = "veh_a10_plr_fire_gatling_cooldown";
  config.sfxCannonFireLoop_3p = "veh_a10_npc_fire_gatling_lp";
  config.sfxCannonFireStop_3p = "veh_a10_npc_fire_gatling_cooldown";
  config.sfxCannonFireBurpTime = 500;
  config.sfxCannonFireBurpShort_3p = "veh_a10_npc_fire_gatling_short_burst";
  config.sfxCannonFireBurpLong_3p = "veh_a10_npc_fire_gatling_long_burst";
  config.sfxCannonBulletImpact = "veh_a10_bullet_impact_lp";

  config.sfxMissileFire_1p = [];
  config.sfxMissileFire_1p[0] = "veh_a10_plr_missile_ignition_left";
  config.sfxMissileFire_1p[1] = "veh_a10_plr_missile_ignition_right";
  config.sfxMissileFire_3p = "veh_a10_npc_missile_fire";
  config.sfxMissile = "veh_a10_missile_loop";

  config.sfxEngine_1p = "veh_a10_plr_engine_lp";
  config.sfxEngine_3p = "veh_a10_dist_loop";

  level.planeConfigs[KS_NAME] = config;

  level.killstreakFuncs[KS_NAME] = ::onUse;

  buildAllFlightPathsDefault();
}

onUse(lifeId, streakName) {
  assert(isDefined(self));

  if(isDefined(level.a10strafeActive)) {
    self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(self isUsingRemote() ||
    self isKillStreakDenied()
  ) {
    return false;
  } else if(GetCSplineCount() < 2) {
    PrintLn("ERROR: need at least two CSpline paths for A10 strafing run. Please add them to your level.");
    return false;
  } else {
    self thread doStrike(lifeId, KS_NAME);

    return true;
  }
}

doStrike(lifeId, streakName) {
  self endon("end_remote");
  self endon("death");
  level endon("game_ended");

  pathIndex = getPathIndex();

  print(" A10 fly path (" + level.a10SplinesIn[pathIndex] + ", " + level.a10SplinesOut[pathIndex] + ")\n");

  result = self startStrafeSequence(streakName, lifeId);
  if(result) {
    plane = spawnAircraft(streakName, lifeId, level.a10SplinesIn[pathIndex]);
    if(isDefined(plane)) {
      plane doOneFlyby();
      self switchAircraft(plane, streakName);

      plane = spawnAircraft(streakName, lifeId, level.a10SplinesIn[pathIndex]);
      if(isDefined(plane)) {
        self thread maps\mp\killstreaks\_killstreaks::clearRideIntro(1.0, kTransitionTime);

        plane doOneFlyby();
        plane thread endFlyby(streakName);

        self endStrafeSequence(streakName);
      }
    }
  }
}

startStrafeSequence(streakName, lifeId) {
  self setUsingRemote(KS_NAME);

  if(GetDvarInt("camera_thirdPerson"))
    self setThirdPersonDOF(false);

  self.restoreAngles = self.angles;

  self freezeControlsWrapper(true);
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak(KS_NAME);
  if(result != "success") {
    if(result != "disconnect")
      self clearUsingRemote();

    if(isDefined(self.disabledWeapon) && self.disabledWeapon)
      self _enableWeapon();
    self notify("death");

    return false;
  }

  if(self isJuggernaut() && isDefined(self.juggernautOverlay)) {
    self.juggernautOverlay.alpha = 0;
  }

  self freezeControlsWrapper(false);

  level.a10strafeActive = true;
  self.using_remote_a10 = true;

  level thread teamPlayerCardSplash("used_" + streakName, self, self.team);

  return true;
}

endStrafeSequence(streakName) {
  self clearUsingRemote();

  if(GetDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(true);
  }

  if(self isJuggernaut() && isDefined(self.juggernautOverlay)) {
    self.juggernautOverlay.alpha = 1;
  }

  self SetPlayerAngles(self.restoreAngles);
  self.restoreAngles = undefined;

  self thread a10_FreezeBuffer();

  level.a10strafeActive = undefined;
  self.using_remote_a10 = undefined;
}

switchAircraft(plane, streakName) {
  self.usingRemote = undefined;

  self VisionSetNakedForPlayer("black_bw", kTransitionTime);
  self thread set_visionset_for_watching_players("black_bw", kTransitionTime, kTransitionTime);
  wait(kTransitionTime);

  if(isDefined(plane)) {
    plane thread endFlyby(streakName);
  }

}

spawnAircraft(streakName, lifeId, splineId) {
  plane = createPlaneAsHeli(streakName, lifeId, splineId);
  if(!isDefined(plane))
    return undefined;

  plane.streakName = streakName;

  self RemoteControlVehicle(plane);
  plane SetPlaneSplineId(self, splineId);

  self thread watchIntroCleared(streakName, plane);

  config = level.planeConfigs[streakName];
  plane playLoopSound(config.sfxEngine_1p);

  plane thread a10_handleDamage();

  maps\mp\killstreaks\_plane::startTrackingPlane(plane);

  return plane;
}

attachTurret(streakName) {
  config = level.planeConfigs[streakName];
  turretPos = self GetTagOrigin(config.turretAttachPoint);
  turret = SpawnTurret("misc_turret", self.origin + turretPos, config.turretName, false);
  turret LinkTo(self, config.turretAttachPoint, (0, 0, 0), (0, 0, 0));
  turret setModel("vehicle_ugv_talon_gun_mp");
  turret.angles = self.angles;
  turret.owner = self.owner;

  turret MakeTurretInoperable();
  turret SetTurretModeChangeWait(false);
  turret SetMode("sentry_offline");
  turret MakeUnusable();
  turret setCanDamage(false);
  turret SetSentryOwner(self.owner);

  self.owner RemoteControlTurret(turret);

  self.turret = turret;
}

cleanupAircraft() {
  if(isDefined(self.turret)) {
    self.turret Delete();
  }

  foreach(targetInfo in self.targetList) {
    if(isDefined(targetInfo["icon"])) {
      targetInfo["icon"] Destroy();
      targetInfo["icon"] = undefined;
    }
  }

  self Delete();
}

getPathIndex() {
  return (RandomInt(level.a10SplinesIn.size));
}

doOneFlyby() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("splinePlaneReachedNode", nodeLabel);
    if(isDefined(nodeLabel) && nodeLabel == "End") {
      self notify("a10_end_strafe");
      break;
    }
  }
}

endFlyby(streakName) {
  if(!isDefined(self)) {
    return;
  }
  self.owner RemoteControlVehicleOff(self);
  if(isDefined(self.turret)) {
    self.owner RemoteControlTurretOff(self.turret);
  }

  self notify("end_remote");

  self.owner SetClientOmnvar("ui_a10", false);
  self.owner ThermalVisionFOFOverlayOff();

  config = level.planeConfigs[streakName];
  self StopLoopSound(config.sfxCannonFireLoop_1p);

  maps\mp\killstreaks\_plane::stopTrackingPlane(self);

  wait(5);

  if(isDefined(self)) {
    self StopLoopSound(config.sfxEngine_1p);

    self cleanupAircraft();

  }
}

createPlaneAsHeli(streakName, lifeId, splineId) {
  config = level.planeConfigs[streakName];

  startPos = GetCSplinePointPosition(splineId, 0);
  startTangent = GetCSplinePointTangent(splineId, 0);

  startAngles = VectorToAngles(startTangent);

  plane = SpawnHelicopter(self, startPos, startAngles, config.vehicle, config.modelNames[self.team]);
  if(!isDefined(plane))
    return undefined;

  plane MakeVehicleSolidCapsule(18, -9, 18);

  plane.owner = self;
  plane.team = self.team;

  plane.lifeId = lifeId;

  plane thread maps\mp\killstreaks\_plane::playPlaneFX();

  return plane;
}

handleDeath() {
  level endon("game_ended");
  self endon("delete");

  self waittill("death");

  level.a10strafeActive = undefined;
  self.owner.using_remote_a10 = undefined;

  self delete();
}

a10_FreezeBuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

monitorRocketFire(streakName, plane) {
  plane endon("end_remote");
  plane endon("death");
  self endon("death");
  level endon("game_ended");

  config = level.planeConfigs[streakName];
  plane.numRocketsLeft = config.numRockets;

  self NotifyOnPlayerCommand("rocket_fire_pressed", "+speed_throw");
  self NotifyOnPlayerCommand("rocket_fire_pressed", "+ads_akimbo_accessible");
  if(!level.console) {
    self NotifyOnPlayerCommand("rocket_fire_pressed", "+toggleads_throw");
  }

  self SetClientOmnvar("ui_a10_rocket", plane.numRocketsLeft);

  while(plane.numRocketsLeft > 0) {
    self waittill("rocket_fire_pressed");

    plane onFireRocket(streakName);

    wait(config.delayBetweenRockets);
  }
}

monitorRocketFire2(streakName, plane) {
  plane endon("end_remote");
  plane endon("death");
  self endon("death");
  level endon("game_ended");

  config = level.planeConfigs[streakName];
  plane.numRocketsLeft = config.numRockets;

  self NotifyOnPlayerCommand("rocket_fire_pressed", "+speed_throw");
  self NotifyOnPlayerCommand("rocket_fire_pressed", "+ads_akimbo_accessible");
  if(!level.console) {
    self NotifyOnPlayerCommand("rocket_fire_pressed", "+toggleads_throw");
  }

  plane.targetList = [];

  self SetClientOmnvar("ui_a10_rocket", plane.numRocketsLeft);

  while(plane.numRocketsLeft > 0) {
    if(!(self AdsButtonPressed())) {
      self waittill("rocket_fire_pressed");
    }

    plane missileAcquireTargets();

    if(plane.targetList.size > 0) {
      plane thread fireMissiles();
    }
  }
}

missileGetBestTarget() {
  candidateList = [];

  foreach(player in level.players) {
    if(self missileIsGoodTarget(player)) {
      candidateList[candidateList.size] = player;
    }
  }

  foreach(uplink in level.uplinks) {
    if(self missileIsGoodTarget(uplink)) {
      candidateList[candidateList.size] = uplink;
    }
  }

  if(candidateList.size > 0) {
    sortedCandidateList = SortByDistance(candidateList, self.origin);

    return sortedCandidateList[0];
  }

  return undefined;
}

missileIsGoodTarget(target) {
  return (IsAlive(target) &&
    target.team != self.owner.team &&
    !(self isMissileTargeted(target)) &&
    (IsPlayer(target) && !(target _hasPerk("specialty_blindeye")))

    &&
    self missileTargetAngle(target) > 0.25
  );
}

missileTargetAngle(target) {
  dirToTarget = VectorNormalize(target.origin - self.origin);
  facingDir = anglesToForward(self.angles);

  return VectorDot(dirToTarget, facingDir);
}

missileAcquireTargets() {
  self endon("death");
  self endon("end_remote");
  level endon("game_ended");
  self endon("a10_missiles_fired");

  config = level.planeConfigs[self.streakName];

  self.owner SetClientOmnvar("ui_a10_rocket_lock", true);

  self thread missileWaitForTriggerRelease();

  currentTarget = undefined;

  while(self.targetList.size < self.numRocketsLeft) {
    if(!isDefined(currentTarget)) {
      currentTarget = self missileGetBestTarget();

      if(isDefined(currentTarget)) {
        self thread missileLockTarget(currentTarget);

        wait(config.delayBetweenLockon);

        currentTarget = undefined;

        continue;
      }
    }

    wait(0.1);
  }

  self.owner SetClientOmnvar("ui_a10_rocket_lock", false);
  self notify("a10_missiles_fired");
}

missileWaitForTriggerRelease() {
  self endon("end_remote");
  self endon("death");
  level endon("game_ended");
  self endon("a10_missiles_fired");

  owner = self.owner;
  owner NotifyOnPlayerCommand("rocket_fire_released", "-speed_throw");
  owner NotifyOnPlayerCommand("rocket_fire_released", "-ads_akimbo_accessible");
  if(!level.console) {
    owner NotifyOnPlayerCommand("rocket_fire_released", "-toggleads_throw");
  }

  self.owner waittill("rocket_fire_released");

  owner SetClientOmnvar("ui_a10_rocket_lock", false);

  self notify("a10_missiles_fired");
}

missileLockTarget(target) {
  config = level.planeConfigs[self.streakName];

  info = [];

  info["icon"] = target maps\mp\_entityheadIcons::setHeadIcon(self.owner, config.lockonIcon, kLockIconOffset, 10, 10, false, 0.05, true, false, false, false);
  info["target"] = target;

  self.targetList[target GetEntityNumber()] = info;

  self.owner PlayLocalSound("recondrone_lockon");
}

isMissileTargeted(target) {
  return (isDefined(self.targetList[target GetEntityNumber()]));
}

fireMissiles() {
  self endon("death");
  level endon("game_ended");

  config = level.planeConfigs[self.streakName];

  foreach(targetInfo in self.targetList) {
    if(self.numRocketsLeft > 0) {
      missile = self onFireHomingMissile(self.streakName, targetInfo["target"], kLockIconOffset);

      if(isDefined(targetInfo["icon"])) {
        missile.icon = targetInfo["icon"];
        targetInfo["icon"] = undefined;
      }

      wait(config.delayBetweenRockets);
    } else {
      break;
    }
  }

  targetList = [];
}

onFireHomingMissile(streakName, target, targetOffset) {
  side = self.numRocketsLeft % 2;
  tagName = "tag_missile_" + (side + 1);

  rocketPos = self GetTagOrigin(tagName);
  if(isDefined(rocketPos)) {
    owner = self.owner;

    config = level.planeConfigs[streakName];

    rocket = MagicBullet(config.rocketModelName, rocketPos, rocketPos + 100 * anglesToForward(self.angles), self.owner);
    rocket thread a10_missile_set_target(target, targetOffset);

    Earthquake(0.25, 0.05, self.origin, 512);

    self.numRocketsLeft--;
    self.owner SetClientOmnvar("ui_a10_rocket", self.numRocketsLeft);

    config = level.planeConfigs[streakName];
    rocket PlaySoundOnMovingEnt(config.sfxMissileFire_1p[side]);
    rocket playLoopSound(config.sfxMissile);

    return rocket;
  }

  return undefined;
}

MISSILE_IMPACT_DIST_MAX = 15000;
MISSILE_IMPACT_DIST_MIN = 1000;
onFireRocket(streakName) {
  tagName = "tag_missile_" + self.numRocketsLeft;

  rocketPos = self GetTagOrigin(tagName);
  if(isDefined(rocketPos)) {
    owner = self.owner;

    config = level.planeConfigs[streakName];

    rocket = MagicBullet(config.rocketModelName, rocketPos, rocketPos + 100 * anglesToForward(self.angles), self.owner);

    Earthquake(0.25, 0.05, self.origin, 512);

    self.numRocketsLeft--;
    self.owner SetClientOmnvar("ui_a10_rocket", self.numRocketsLeft);

    rocket PlaySoundOnMovingEnt(config.sfxMissileFire_1p[self.numRocketsLeft]);
    rocket playLoopSound(config.sfxMissile);

    self PlaySoundOnMovingEnt("a10p_missile_launch");

  }
}

a10_missile_set_target(target, offset) {
  self thread a10_missile_cleanup();

  wait 0.2;

  self Missile_SetTargetEnt(target, offset);
}

a10_missile_cleanup() {
  self waittill("death");

  if(isDefined(self.icon)) {
    self.icon Destroy();
  }
}

CANNON_SHAKE_TIME = 0.5;
monitorWeaponFire(streakName, plane) {
  plane endon("end_remote");
  plane endon("death");
  self endon("death");
  level endon("game_ended");

  config = level.planeConfigs[streakName];

  plane.ammoCount = 1350;

  self SetClientOmnvar("ui_a10_cannon", plane.ammoCount);

  self NotifyOnPlayerCommand("a10_cannon_start", "+attack");
  self NotifyOnPlayerCommand("a10_cannon_stop", "-attack");

  while(plane.ammoCount > 0) {
    if(!(self AttackButtonPressed())) {
      self waittill("a10_cannon_start");
    }

    cannonShortBurstTimeLimit = GetTime() + config.sfxCannonFireBurpTime;

    plane playLoopSound(config.sfxCannonFireLoop_1p);
    plane thread updateCannonShake(streakName);

    self waittill("a10_cannon_stop");

    plane StopLoopSound(config.sfxCannonFireLoop_1p);
    plane PlaySoundOnMovingEnt(config.sfxCannonFireStop_1p);

    if(GetTime() < cannonShortBurstTimeLimit) {
      playSoundAtPos(plane.origin, config.sfxCannonFireBurpShort_3p);
    } else {
      playSoundAtPos(plane.origin, config.sfxCannonFireBurpLong_3p);
    }
  }
}

updateCannonShake(streakName) {
  self.owner endon("a10_cannon_stop");
  self endon("death");
  level endon("game_ended");

  config = level.planeConfigs[streakName];

  while(self.ammoCount > 0) {
    Earthquake(0.2, CANNON_SHAKE_TIME, self.origin, 512);
    self.ammoCount -= 10;
    self.owner SetClientOmnvar("ui_a10_cannon", self.ammoCount);

    barrelPoint = self GetTagOrigin("tag_flash_attach") + 20 * anglesToForward(self.angles);
    playFX(config.cannonFireVFX, barrelPoint);

    self PlayRumbleOnEntity(config.cannonRumble);

    wait(0.1);
  }

  self.turret TurretFireDisable();
}

ALTITUDE_WARNING_LIMIT = 1000;
monitorAltitude(streakName, plane) {
  plane endon("end_remote");
  plane endon("death");
  self endon("death");
  level endon("game_ended");

  self SetClientOmnvar("ui_a10_alt_warn", false);

  while(true) {
    alt = Int(Clamp(plane.origin[2], 0, 16383));
    self SetClientOmnvar("ui_a10_alt", alt);

    if(alt <= ALTITUDE_WARNING_LIMIT && !isDefined(plane.altWarning)) {
      plane.altWarning = true;
      self SetClientOmnvar("ui_a10_alt_warn", true);
    } else if(alt > ALTITUDE_WARNING_LIMIT && isDefined(plane.altWarning)) {
      plane.altWarning = undefined;
      self SetClientOmnvar("ui_a10_alt_warn", false);
    }

    wait(0.1);
  }
}

watchIntroCleared(streakName, plane) {
  self endon("disconnect");
  level endon("game_ended");

  self waittill("intro_cleared");

  self SetClientOmnvar("ui_a10", true);

  self thread monitorAltitude(streakname, plane);
  self thread monitorRocketFire2(streakName, plane);
  self thread monitorWeaponFire(streakName, plane);
  self thread watchRoundEnd(plane, streakName);

  self ThermalVisionFOFOverlayOn();

  self thread watchEarlyExit(plane);
}

watchRoundEnd(plane, streakName) {
  plane endon("death");
  plane endon("leaving");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  level waittill_any("round_end_finished", "game_ended");

  plane thread endFlyby(streakName);
  self endStrafeSequence(streakName);

  self a10_explode();
}

buildAllFlightPathsDefault() {
  inBoundList = [];
  inBoundList[0] = 1;
  inBoundList[1] = 2;
  inBoundList[2] = 3;
  inBoundList[3] = 4;
  inBoundList[4] = 1;
  inBoundList[5] = 2;
  inBoundList[6] = 4;
  inBoundList[7] = 3;

  outBoundList = [];
  outBoundList[0] = 2;
  outBoundList[1] = 1;
  outBoundList[2] = 4;
  outBoundList[3] = 3;
  outBoundList[4] = 1;
  outBoundList[5] = 4;
  outBoundList[6] = 3;
  outBoundList[7] = 2;

  buildAllFlightPaths(inBoundList, outBoundList);
}

buildAllFlightPaths(inBoundList, outBoundList) {
  level.a10SplinesIn = inBoundList;
  level.a10SplinesOut = outBoundList;
}

a10_cockpit_breathing() {
  level endon("remove_player_control");

  for(;;) {
    wait(RandomFloatRange(3.0, 7.0));

  }
}

watchEarlyExit(veh) {
  level endon("game_ended");
  veh endon("death");
  veh endon("a10_end_strafe");

  veh thread maps\mp\killstreaks\_killstreaks::allowRideKillstreakPlayerExit();

  veh waittill("killstreakExit");

  self notify("end_remote");
  veh thread endFlyby(veh.streakName);
  self endStrafeSequence(veh.streakName);
  veh a10_explode();
}

a10_handleDamage() {
  self endon("end_remote");

  config = level.planeConfigs[self.streakName];

  self maps\mp\gametypes\_damage::monitorDamage(
    config.maxHealth,
    "helicopter", ::handleDeathDamage, ::modifyDamage,
    true
  );
}

modifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  modifiedDamage = self maps\mp\gametypes\_damage::handleEmpDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

handleDeathDamage(attacker, weapon, type, damage) {
  config = level.planeConfigs[self.streakName];

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, config.voDestroyed, config.xpPopup, config.callout);

  self a10_explode();
}

a10_explode() {
  config = level.planeConfigs[self.streakName];

  maps\mp\killstreaks\_plane::stopTrackingPlane(self);
  playFX(config.explodeVfx, self.origin);
  self Delete();
}