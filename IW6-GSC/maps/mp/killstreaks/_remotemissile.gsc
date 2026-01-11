/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_remotemissile.gsc
**************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.missileRemoteLaunchVert = 14000;
  level.missileRemoteLaunchHorz = 7000;
  level.missileRemoteLaunchTargetDist = 1500;

  level.rockets = [];

  level.killstreakFuncs["predator_missile"] = ::tryUsePredatorMissile;

  level.remotemissile_fx["explode"] = LoadFX("fx/explosions/aerial_explosion");
}

tryUsePredatorMissile(lifeId, streakName) {
  self setUsingRemote("remotemissile");
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak();
  if(result != "success") {
    if(result != "disconnect") {
      self clearUsingRemote();
    }

    return false;
  }

  self SetClientOmnvar("ui_predator_missile", 1);
  level thread _fire(lifeId, self);

  return true;
}

getBestSpawnPoint(remoteMissileSpawnPoints) {
  validEnemies = [];

  foreach(spawnPoint in remoteMissileSpawnPoints) {
    spawnPoint.validPlayers = [];
    spawnPoint.spawnScore = 0;
  }

  foreach(player in level.players) {
    if(!isReallyAlive(player)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    if(player.team == "spectator") {
      continue;
    }
    bestDistance = 999999999;
    bestSpawnPoint = undefined;

    foreach(spawnPoint in remoteMissileSpawnPoints) {
      spawnPoint.validPlayers[spawnPoint.validPlayers.size] = player;

      potentialBestDistance = Distance2D(spawnPoint.targetent.origin, player.origin);

      if(potentialBestDistance <= bestDistance) {
        bestDistance = potentialBestDistance;
        bestSpawnpoint = spawnPoint;
      }
    }

    assertEx(isDefined(bestSpawnPoint), "Closest remote-missile spawnpoint undefined for player: " + player.name);
    bestSpawnPoint.spawnScore += 2;
  }

  bestSpawn = remoteMissileSpawnPoints[0];
  foreach(spawnPoint in remoteMissileSpawnPoints) {
    foreach(player in spawnPoint.validPlayers) {
      spawnPoint.spawnScore += 1;

      if(BulletTracePassed(player.origin + (0, 0, 32), spawnPoint.origin, false, player)) {
        spawnPoint.spawnScore += 3;
      }

      if(spawnPoint.spawnScore > bestSpawn.spawnScore) {
        bestSpawn = spawnPoint;
      } else if(spawnPoint.spawnScore == bestSpawn.spawnScore) {
        if(coinToss()) {
          bestSpawn = spawnPoint;
        }
      }
    }
  }

  return (bestSpawn);
}

_fire(lifeId, player) {
  remoteMissileSpawnArray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(spawn in remoteMissileSpawnArray) {
    if(isDefined(spawn.target)) {
      spawn.targetEnt = GetEnt(spawn.target, "targetname");
    }
  }

  if(remoteMissileSpawnArray.size > 0) {
    remoteMissileSpawn = player getBestSpawnPoint(remoteMissileSpawnArray);
  }
  else {
    remoteMissileSpawn = undefined;
  }

  if(isDefined(remoteMissileSpawn)) {
    startPos = remoteMissileSpawn.origin;
    targetPos = remoteMissileSpawn.targetEnt.origin;

    vector = VectorNormalize(startPos - targetPos);
    startPos = (vector * 14000) + targetPos;

    rocket = MagicBullet("remotemissile_projectile_mp", startpos, targetPos, player);
  } else {
    upVector = (0, 0, level.missileRemoteLaunchVert);
    backDist = level.missileRemoteLaunchHorz;
    targetDist = level.missileRemoteLaunchTargetDist;

    forward = anglesToForward(player.angles);
    startpos = player.origin + upVector + forward * backDist * -1;
    targetPos = player.origin + forward * targetDist;

    rocket = MagicBullet("remotemissile_projectile_mp", startpos, targetPos, player);
  }

  if(!isDefined(rocket)) {
    player clearUsingRemote();
    return;
  }

  rocket.team = player.team;
  rocket thread handleDamage();

  rocket.lifeId = lifeId;
  rocket.type = "remote";
  level.remoteMissileInProgress = true;
  missileEyes(player, rocket);
}

_fire_noplayer(lifeId, player) {
  upVector = (0, 0, level.missileRemoteLaunchVert);
  backDist = level.missileRemoteLaunchHorz;
  targetDist = level.missileRemoteLaunchTargetDist;

  forward = anglesToForward(player.angles);
  startpos = player.origin + upVector + forward * backDist * -1;
  targetPos = player.origin + forward * targetDist;

  rocket = MagicBullet("remotemissile_projectile_mp", startpos, targetPos, player);

  if(!isDefined(rocket)) {
    return;
  }
  rocket thread handleDamage();

  rocket.lifeId = lifeId;
  rocket.type = "remote";

  player CameraLinkTo(rocket, "tag_origin");
  player ControlsLinkTo(rocket);

  rocket thread rocket_CleanupOnDeath();

  wait(2.0);

  player ControlsUnlink();
  player CameraUnlink();
}

handleDamage() {
  self endon("death");
  self endon("deleted");

  self setCanDamage(true);

  for(;;) {
    self waittill("damage");

    println("projectile damaged!");
  }
}

missileEyes(player, rocket) {
  player endon("joined_team");
  player endon("joined_spectators");

  rocket thread rocket_CleanupOnDeath();
  player thread player_CleanupOnGameEnded(rocket);
  player thread player_CleanupOnTeamChange(rocket);

  player VisionSetMissilecamForPlayer("black_bw", 0);

  player endon("disconnect");

  if(isDefined(rocket)) {
    player VisionSetMissilecamForPlayer(game["thermal_vision"], 1.0);
    player ThermalVisionOn();
    player thread delayedFOFOverlay();
    player CameraLinkTo(rocket, "tag_origin");
    player ControlsLinkTo(rocket);

    if(GetDvarInt("camera_thirdPerson")) {
      player SetThirdPersonDOF(false);
    }

    rocket waittill("death");
    player ThermalVisionOff();

    if(isDefined(rocket)) {
      player maps\mp\_matchdata::logKillstreakEvent("predator_missile", rocket.origin);
    }

    player ControlsUnlink();
    player freezeControlsWrapper(true);

    if(!level.gameEnded || isDefined(player.finalKill)) {
      player SetClientOmnvar("ui_predator_missile", 2);
    }

    wait(0.5);

    player ThermalVisionFOFOverlayOff();

    player CameraUnlink();

    if(GetDvarInt("camera_thirdPerson")) {
      player SetThirdPersonDOF(true);
    }

  }

  player SetClientOmnvar("ui_predator_missile", 0);
  player clearUsingRemote();
}

delayedFOFOverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  wait(0.15);

  self ThermalVisionFOFOverlayOn();
}

player_CleanupOnTeamChange(rocket) {
  rocket endon("death");
  self endon("disconnect");

  self waittill_any("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self ThermalVisionFOFOverlayOff();
    self ControlsUnlink();
    self CameraUnlink();

    if(GetDvarInt("camera_thirdPerson")) {
      self SetThirdPersonDOF(true);
    }
  }
  self clearUsingRemote();

  level.remoteMissileInProgress = undefined;
}

rocket_CleanupOnDeath() {
  entityNumber = self GetEntityNumber();
  level.rockets[entityNumber] = self;
  self waittill("death");

  level.rockets[entityNumber] = undefined;

  level.remoteMissileInProgress = undefined;
}

player_CleanupOnGameEnded(rocket) {
  rocket endon("death");
  self endon("death");

  level waittill("game_ended");

  self ThermalVisionFOFOverlayOff();
  self ControlsUnlink();
  self CameraUnlink();

  if(GetDvarInt("camera_thirdPerson")) {
    self SetThirdPersonDOF(true);
  }
}