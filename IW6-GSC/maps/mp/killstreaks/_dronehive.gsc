/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_dronehive.gsc
**********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

CONST_DRONE_HIVE_DEBUG = false;
CONST_MISSILE_COUNT = 2;
CONST_WEAPON_MAIN = "drone_hive_projectile_mp";
CONST_WEAPON_CHILD = "switch_blade_child_mp";

init() {
  level.killstreakFuncs["drone_hive"] = ::tryUseDroneHive;

  level.droneMissileSpawnArray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(missileSpawn in level.droneMissileSpawnArray) {
    missileSpawn.targetEnt = GetEnt(missileSpawn.target, "targetname");
  }
}

tryUseDroneHive(lifeId, streakName) {
  if((!isDefined(level.droneMissileSpawnArray) || !level.droneMissileSpawnArray.size)) {
    AssertMsg("map needs remoteMissileSpawn entities");
  }

  return useDroneHive(self, lifeId);
}

useDroneHive(player, lifeId) {
  if(isDefined(self.underWater) && self.underWater) {
    return false;
  }

  player setUsingRemote("remotemissile");
  player freezeControlsWrapper(true);
  player _disableWeaponSwitch();

  level thread monitorDisownKillstreaks(player);
  level thread monitorGameEnd(player);
  level thread monitorObjectiveCamera(player);

  result = player maps\mp\killstreaks\_killstreaks::initRideKillstreak("drone_hive");

  if(result == "success") {
    player freezeControlsWrapper(false);
    level thread runDroneHive(player, lifeId);
  } else {
    player notify("end_kill_streak");
    player clearUsingRemote();
    player _enableWeaponSwitch();
  }

  return result == "success";
}

watchHostMigrationStartedInit(player) {
  player endon("killstreak_disowned");
  player endon("disconnect");
  levelendon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      player VisionSetMissilecamForPlayer(game["thermal_vision"], 0);
      player set_visionset_for_watching_players("default", 0, undefined, true);
      player ThermalVisionFOFOverlayOn();
    } else {
      player SetClientOmnvar("ui_predator_missile", 2);
    }
  }
}

watchHostMigrationFinishedInit(player) {
  player endon("killstreak_disowned");
  player endon("disconnect");
  levelendon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(isDefined(self)) {
      player SetClientOmnvar("ui_predator_missile", 1);
      player SetClientOmnvar("ui_predator_missiles_left", self.missilesLeft);
    } else {
      player SetClientOmnvar("ui_predator_missile", 2);
    }

  }
}

runDroneHive(player, lifeId) {
  player endon("killstreak_disowned");
  levelendon("game_ended");

  player notifyOnPlayerCommand("missileTargetSet", "+attack");
  player notifyOnPlayerCommand("missileTargetSet", "+attack_akimbo_accessible");

  remoteMissileSpawn = getBestMissileSpawnPoint(player, level.droneMissileSpawnArray);

  startPos = remoteMissileSpawn.origin;
  targetPos = remoteMissileSpawn.targetEnt.origin;
  vector = VectorNormalize(startPos - targetPos);
  startPos = (vector * 14000) + targetPos;

  if(CONST_DRONE_HIVE_DEBUG) {
    level thread drawLine(startPos, targetPos, 15, (1, 0, 0));
  }

  rocket = MagicBullet(CONST_WEAPON_MAIN, startpos, targetPos, player);
  rocket setCanDamage(true);
  rocket DisableMissileBoosting();
  rocket SetMissileMinimapVisible(true);

  rocket.team = player.team;
  rocket.lifeId = lifeId;
  rocket.type = "remote";
  rocket.owner = player;
  rocket.entityNumber = rocket GetEntityNumber();

  level.rockets[rocket.entityNumber] = rocket;
  level.remoteMissileInProgress = true;

  level thread monitorDeath(rocket, true);
  level thread monitorBoost(rocket);

  if(isDefined(player.killsThisLifePerWeapon)) {
    player.killsThisLifePerWeapon[CONST_WEAPON_MAIN] = 0;
    player.killsThisLifePerWeapon[CONST_WEAPON_CHILD] = 0;
  }

  missileEyes(player, rocket);

  player SetClientOmnvar("ui_predator_missile", 1);

  rocket thread watchHostMigrationStartedInit(player);
  rocket thread watchHostMigrationFinishedInit(player);

  missileCount = 0;
  rocket.missilesLeft = CONST_MISSILE_COUNT;

  player setClientOmnVar("ui_predator_missiles_left", CONST_MISSILE_COUNT);

  while(true) {
    result = rocket waittill_any_return("death", "missileTargetSet");
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(result == "death") {
      break;
    }

    if(!isDefined(rocket)) {
      break;
    }

    if(missileCount < CONST_MISSILE_COUNT) {
      level thread spawnSwitchBlade(rocket, missileCount);
      missileCount++;

      rocket.missilesLeft = CONST_MISSILE_COUNT - missileCount;
      player setClientOmnVar("ui_predator_missiles_left", rocket.missilesLeft);

      if(missileCount == CONST_MISSILE_COUNT)
        rocket EnableMissileBoosting();
    }
  }

  thread returnPlayer(player);
}

monitorLockedTarget() {
  level endon("game_ended");
  self endon("death");

  enemyTargets = [];
  sortedTargets = [];

  for(;;) {
    targetsInsideReticle = [];
    enemyTargets = getEnemyTargets();

    foreach(targ in enemyTargets) {
      targInReticle = self.owner WorldPointInReticle_Circle(targ.origin, 65, 90);

      if(targInReticle) {
        self.owner thread drawLine(self.origin, targ.origin, 10, (0, 0, 1));
        targetsInsideReticle[targetsInsideReticle.size] = targ;
      }
    }

    if(targetsInsideReticle.size) {
      sortedTargets = SortByDistance(targetsInsideReticle, self.origin);
      self.lastTargetLocked = sortedTargets[0];
      maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(0.25);
    }

    wait(0.05);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }
}

getEnemyTargets(owner) {
  enemyTargets = [];

  foreach(player in level.participants) {
    if(owner isEnemy(player) && !(player _hasPerk("specialty_blindeye"))) {
      enemyTargets[enemyTargets.size] = player;
    }
  }

  enemyVehicleTargets = maps\mp\gametypes\_weapons::lockOnLaunchers_getTargetArray();

  if(enemyTargets.size && enemyVehicleTargets.size) {
    finalTargets = array_combine(enemyTargets, enemyVehicleTargets);
    return finalTargets;
  } else if(enemyTargets.size) {
    return enemyTargets;
  } else {
    return enemyVehicleTargets;
  }
}

spawnSwitchBlade(rocket, spawnOnLeft) {
  rocket.owner playLocalSound("ammo_crate_use");

  playerViewAngles = rocket GetTagAngles("tag_camera");
  forwardDir = anglesToForward(playerViewAngles);
  rightDir = AnglesToRight(playerViewAngles);
  spawnOffset = (35, 35, 35);
  targetOffset = (15000, 15000, 15000);

  if(spawnOnLeft)
    spawnOffset = spawnOffset * -1;

  result = bulletTrace(rocket.origin, rocket.origin + (forwardDir * targetOffset), false, rocket);

  targetOffset = targetOffset * result["fraction"];
  startPosition = rocket.origin + (rightDir * spawnOffset);
  targetLocation = rocket.origin + (forwardDir * targetOffset);

  targets = rocket.owner getEnemyTargets(rocket.owner);
  missile = MagicBullet(CONST_WEAPON_CHILD, startPosition, targetLocation, rocket.owner);

  foreach(targ in targets) {
    if(Distance2dsquared(targ.origin, targetLocation) < (512 * 512)) {
      missile Missile_SetTargetEnt(targ);
      break;
    }
  }

  missile setCanDamage(true);
  missile SetMissileMinimapVisible(true);

  missile.team = rocket.team;
  missile.lifeId = rocket.lifeId;
  missile.type = rocket.type;
  missile.owner = rocket.owner;
  missile.entityNumber = missile GetEntityNumber();

  level.rockets[missile.entityNumber] = missile;
  level thread monitorDeath(missile, false);
}

loopTriggeredEffect(effect, missile) {
  missile endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    TriggerFX(effect);
    wait(0.25);
  }
}

getNextMissileSpawnIndex(oldIndex) {
  index = oldIndex + 1;

  if(index == level.droneMissileSpawnArray.size) {
    index = 0;
  }

  return index;
}

monitorBoost(rocket) {
  rocket endon("death");

  while(true) {
    rocket.owner waittill("missileTargetSet");
    rocket notify("missileTargetSet");
  }
}

getBestMissileSpawnPoint(owner, remoteMissileSpawnPoints) {
  validEnemies = [];

  foreach(player in level.players) {
    if(!isReallyAlive(player)) {
      continue;
    }
    if(player.team == owner.team) {
      continue;
    }
    if(player.team == "spectator") {
      continue;
    }
    validEnemies[validEnemies.size] = player;
  }

  if(!validEnemies.size) {
    return remoteMissileSpawnPoints[RandomInt(remoteMissileSpawnPoints.size)];
  }

  remoteMissileSpawnPointsRandomized = array_randomize(remoteMissileSpawnPoints);
  bestMissileSpawn = remoteMissileSpawnPointsRandomized[0];

  foreach(missileSpawn in remoteMissileSpawnPointsRandomized) {
    missileSpawn.sightedEnemies = 0;

    for(i = 0; i < validEnemies.size; i++) {
      enemy = validEnemies[i];
      if(!isReallyAlive(enemy)) {
        validEnemies[i] = validEnemies[validEnemies.size - 1];
        validEnemies[validEnemies.size - 1] = undefined;
        i--;
        continue;
      }

      if(BulletTracePassed(enemy.origin + (0, 0, 32), missileSpawn.origin, false, enemy)) {
        missileSpawn.sightedEnemies += 1;
        return missileSpawn;
      }

      wait(0.05);
      maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    }

    if(missileSpawn.sightedEnemies == validEnemies.size) {
      return missileSpawn;
    }

    if(missileSpawn.sightedEnemies > bestMissileSpawn.sightedEnemies) {
      bestMissileSpawn = missileSpawn;
    }
  }

  return bestMissileSpawn;
}

missileEyes(player, rocket) {
  delayTime = 1.0;

  player freezeControlsWrapper(true);
  player CameraLinkTo(rocket, "tag_origin");
  player ControlsLinkTo(rocket);
  player VisionSetMissilecamForPlayer("default", delayTime);
  player thread set_visionset_for_watching_players("default", delayTime, undefined, true);

  player VisionSetMissilecamForPlayer(game["thermal_vision"], 1.0);
  player thread delayedFOFOverlay();

  level thread unfreezeControls(player, delayTime);
}

delayedFOFOverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(0.25);

  self ThermalVisionFOFOverlayOn();
}

unfreezeControls(player, delayTime, i) {
  player endon("disconnect");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(delayTime - 0.35);

  player freezeControlsWrapper(false);
}

monitorDisownKillstreaks(player) {
  player endon("disconnect");
  player endon("end_kill_streak");

  player waittill("killstreak_disowned");

  level thread returnPlayer(player);
}

monitorGameEnd(player) {
  player endon("disconnect");
  player endon("end_kill_streak");

  level waittill("game_ended");

  level thread returnPlayer(player);
}

monitorObjectiveCamera(player) {
  player endon("end_kill_streak");
  player endon("disconnect");

  level waittill("objective_cam");

  level thread returnPlayer(player, true);
}

monitorDeath(killStreakEnt, mainMissile) {
  killStreakEnt waittill("death");
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(isDefined(killStreakEnt.targEffect))
    killStreakEnt.targEffect Delete();

  if(isDefined(killStreakEnt.entityNumber))
    level.rockets[killStreakEnt.entityNumber] = undefined;

  if(mainMissile)
    level.remoteMissileInProgress = undefined;
}

returnPlayer(player, instant) {
  if(!isDefined(player)) {
    return;
  }
  player SetClientOmnvar("ui_predator_missile", 2);
  player notify("end_kill_streak");

  player freezeControlsWrapper(true);
  player ThermalVisionFOFOverlayOff();
  player ControlsUnlink();

  if(!isDefined(instant))
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(0.95);

  player CameraUnlink();
  player SetClientOmnvar("ui_predator_missile", 0);
  player clearUsingRemote();
  player _enableWeaponSwitch();
}