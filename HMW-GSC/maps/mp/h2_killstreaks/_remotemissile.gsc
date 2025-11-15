#include maps\mp\_utility;
#include common_scripts\utility;
#include scripts\utility;

h2_remotemissile(rocket) {
  compass_icon = spawnPlane(self, "script_model", rocket.origin, "remotemissile_target_friendly", "remotemissile_target_hostile");
  compass_icon setModel("tag_origin");
  compass_icon setContents(0);
  compass_icon linkTo(rocket, "tag_origin", (0, 0, 0), (0, 0, 0));

  soundEnt = spawn("script_model", rocket.origin);
  soundEnt setModel("tag_origin");
  soundEnt setContents(0);
  soundEnt linkTo(rocket, "tag_origin", (0, 0, 0), (0, 0, 0));
  soundEnt hide();
  soundEnt showToPlayer(self);
  soundEnt playLoopSound("predator_drone_missile");

  var_3 = 200;
  var_4 = 200;
  var_5 = var_3 / 2;
  var_6 = var_4 / 2;

  var_7 = newclienthudelem(self);
  var_7.horzalign = "center";
  var_7.vertalign = "middle";
  var_7.x -= var_5;
  var_7.y -= var_6;
  var_7.archived = true;
  var_7 setshader("h2_overlays_predator_reticle", var_3, var_4);

  self setClientOmnVar("ui_predator_enabled", 1);

  self h2_remotemissile_wait(rocket);

  compass_icon delete();
  soundEnt delete();

  if(isDefined(self)) {
    var_7 destroy();
    self setClientOmnVar("ui_predator_enabled", 0);
  }
}

h2_remotemissile_wait(rocket) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  rocket waittill("death");
}

init() {
  mapname = getDvar("mapname");
  if(mapname == "mp_suburbia") {
    level.missileRemoteLaunchVert = 7000;
    level.missileRemoteLaunchHorz = 10000;
    level.missileRemoteLaunchTargetDist = 2000;
  } else if(mapname == "mp_mainstreet") {
    level.missileRemoteLaunchVert = 7000;
    level.missileRemoteLaunchHorz = 10000;
    level.missileRemoteLaunchTargetDist = 2000;
  } else {
    level.missileRemoteLaunchVert = 14000;
    level.missileRemoteLaunchHorz = 7000;
    level.missileRemoteLaunchTargetDist = 1500;

  }

  //precacheItem( "remotemissile_projectile_mp" );
  precacheShader("ac130_overlay_grain");
  precacheString( & "MP_CIVILIAN_AIR_TRAFFIC");
  precacheShader("h2_overlays_predator_reticle");
  precacheMinimapIcon("remotemissile_target_friendly");
  precacheMinimapIcon("remotemissile_target_hostile");

  level.rockets = [];

  level.killstreakFuncs["predator_mp"] = ::tryUsePredatorMissile;

  level.missilesForSightTraces = [];
}

tryUsePredatorMissile(lifeId) {
  if(isDefined(level.civilianJetFlyBy)) {
    self iprintlnbold( & "MP_CIVILIAN_AIR_TRAFFIC");
    return false;
  }

  self setusingremote("remotemissile");

  result = self maps\mp\h2_killstreaks\_common::initridekillstreak();
  if(result != "success") {
    if(result != "disconnect")
      self clearUsingRemote();

    return false;
  }

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
    if(!isReallyAlive(player))
      continue;

    if(player.team == self.team)
      continue;

    if(player.team == "spectator")
      continue;

    bestDistance = 999999999;
    bestSpawnPoint = undefined;

    foreach(spawnPoint in remoteMissileSpawnPoints) {
      //could add a filtering component here but i dont know what it would be.
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

      if(bulletTracePassed(player.origin + (0, 0, 32), spawnPoint.origin, false, player))
        spawnPoint.spawnScore += 3;

      if(spawnPoint.spawnScore > bestSpawn.spawnScore) {
        bestSpawn = spawnPoint;
      } else if(spawnPoint.spawnScore == bestSpawn.spawnScore) // equal spawn weights so we toss a coin.
      {
        if(coinToss())
          bestSpawn = spawnPoint;
      }
    }
  }

  return (bestSpawn);
}

drawLine(start, end, timeSlice, color) {
  drawTime = int(timeSlice * 20);
  for(time = 0; time < drawTime; time++) {
    line(start, end, color, false, 1);
    wait(0.05);
  }
}

add_notify_commands() {
  self notifyonplayercommand("firebuttonpressed", "+attack");
  self notifyonplayercommand("firebuttonpressed", "+attack_akimbo_accessible");
}

remove_notify_commands() {
  self notifyonplayercommandremove("firebuttonpressed", "+attack");
  self notifyonplayercommandremove("firebuttonpressed", "+attack_akimbo_accessible");
}

// rewrote to be similar to https://github.com/mjkzy/s1-gsc-dump/blob/main/decompiled/maps/mp/killstreaks/_missile_strike.gsc
_fire(lifeId, player) {
  player add_notify_commands();

  remote_missile_spawns = getEntArray("remoteMissileSpawn", "targetname");
  //assertEX( remote_missile_spawns.size > 0 && getMapCustom( "map" ) != "", "No remote missile spawn points found.Contact friendly neighborhood designer" );

  foreach(spawn in remote_missile_spawns) {
    if(isDefined(spawn.target))
      spawn.targetent = getent(spawn.target, "targetname");
  }

  remote_missle_spawn = undefined;
  if(remote_missile_spawns.size > 0)
    remote_missle_spawn = player getbestspawnpoint(remote_missile_spawns);

  if(isDefined(remote_missle_spawn)) {
    startPos = remote_missle_spawn.origin;
    targetPos = remote_missle_spawn.targetent.origin;

    //thread drawLine( startPos, targetPos, 30, (0,1,0) );

    vector = vectorNormalize(startPos - targetPos);
    startPos = vector_multiply(vector, 14000) + targetPos;

    //thread drawLine( startPos, targetPos, 15, (1,0,0) );
  } else {
    upVector = (0, 0, level.missileRemoteLaunchVert);
    backDist = level.missileRemoteLaunchHorz;
    targetDist = level.missileRemoteLaunchTargetDist;

    forward = anglesToForward(player.angles);
    startpos = player.origin + upVector + forward * backDist * -1;
    targetPos = player.origin + forward * targetDist;
  }

  rocket = magicbullet("remotemissile_projectile_mp", startpos, targetPos, player);
  if(!isDefined(rocket)) {
    player clearusingremote();
    return;
  }

  rocket.owner = player;
  rocket thread handleDamage();

  rocket.lifeId = lifeId;
  rocket.type = "remote";

  missile_eyes(player, rocket);
}

_fire_noplayer(lifeId, player) {
  upVector = (0, 0, level.missileRemoteLaunchVert);
  backDist = level.missileRemoteLaunchHorz;
  targetDist = level.missileRemoteLaunchTargetDist;

  forward = anglesToForward(player.angles);
  startpos = player.origin + upVector + forward * backDist * -1;
  targetPos = player.origin + forward * targetDist;

  rocket = MagicBullet("remotemissile_projectile_mp", startpos, targetPos, player);

  if(!isDefined(rocket))
    return;

  rocket thread handleDamage();

  rocket.lifeId = lifeId;
  rocket.type = "remote";

  player CameraLinkTo(rocket, "tag_origin");
  player ControlsLinkTo(rocket);

  rocket thread Rocket_CleanupOnDeath();

  wait(2.0);

  player ControlsUnlink();
  player CameraUnlink();
}

  handleDamage() {
    self endon("death");
    self endon("deleted");

    self setCanDamage(true);

    /*
    for( ;; )
    {
    self waittill( "damage" );

    println ( "projectile damaged!" );
    }
    */
  }

monitor_rocket_boosting(rocket) {
  self endon("disconnect");
  rocket endon("death");

  self waittill("firebuttonpressed");

  self playrumbleonentity("sniper_fire");

  rocket playsoundtoplayer("h2_remote_missile_fire_npc", self);
  earthquake(0.3, 1, rocket.origin, 1000);
  self.missileboostused = true;
}

missile_eyes(player, rocket) {
  //level endon ( "game_ended" );
  player endon("joined_team");
  player endon("joined_spectators");
  player endon("disconnect");

  rocket thread Rocket_CleanupOnDeath();
  player thread Player_CleanupOnGameEnded(rocket);
  player thread Player_CleanupOnTeamChange(rocket);

  player ThermalVisionOn();
  player VisionSetThermalForPlayer("black_bw", 0);
  player VisionSetMissileCamForPlayer("", 0);

  player VisionSetThermalForPlayer(game["thermal_vision"], 1.0);
  player thread delayedFOFOverlay();

  player.missileboostused = false;
  player CameraLinkTo(rocket, "tag_origin");
  player ControlsLinkTo(rocket);

  if(getdvarint("camera_thirdPerson"))
    player setthirdpersondof(false);

  rocket enablemissileboosting();
  player thread monitor_rocket_boosting(rocket);
  player thread h2_remotemissile(rocket);

  rocket waittill("death");

  // is defined check required because remote missile doesnt handle lifetime explosion gracefully
  // instantly deletes its self after an explode and death notify
  if(isDefined(rocket))
    player maps\mp\_matchdata::logKillstreakEvent("predator_mp", rocket.origin);

  player ControlsUnlink();
  player freezeControlsWrapper(true);

  // If a player gets the final kill with a hellfire, level.gameEnded will already be true at this point
  if(!level.gameEnded || isDefined(player.finalKill))
    player thread staticEffect(0.5);

  wait(0.5);

  player ThermalVisionFOFOverlayOff();
  player ThermalVisionOff();

  player CameraUnlink();
  player thread maps\mp\h2_killstreaks\_common::takeKillstreakWeapons();

  if(getDvarInt("camera_thirdPerson"))
    player setThirdPersonDOF(true);

  player clearUsingRemote();
}

delayedFOFOverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  wait(0.15);

  self ThermalVisionFOFOverlayOn();
}

staticEffect(duration) {
  self endon("disconnect");

  staticBG = newClientHudElem(self);
  staticBG.horzAlign = "fullscreen";
  staticBG.vertAlign = "fullscreen";
  staticBG setShader("white", 640, 480);
  staticBG.archive = true;
  staticBG.sort = 10;

  static = newClientHudElem(self);
  static.horzAlign = "fullscreen";
  static.vertAlign = "fullscreen";
  static setShader("ac130_overlay_grain", 640, 480);
  static.archive = true;
  static.sort = 20;

  wait(duration);

  static destroy();
  staticBG destroy();
}

Player_CleanupOnTeamChange(rocket) {
  rocket endon("death");
  self endon("disconnect");

  self waittill_any("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self ThermalVisionFOFOverlayOff();
    self ThermalVisionOff();
    self ControlsUnlink();
    self CameraUnlink();

    if(getDvarInt("camera_thirdPerson"))
      self setThirdPersonDOF(true);
  }
  self clearUsingRemote();

  level.remoteMissileInProgress = undefined;
}

Rocket_CleanupOnDeath() {
  entityNumber = self getEntityNumber();
  level.rockets[entityNumber] = self;
  self waittill("death");

  level.rockets[entityNumber] = undefined;
}

Player_CleanupOnGameEnded(rocket) {
  rocket endon("death");
  self endon("death");

  level waittill("game_ended");

  self ThermalVisionFOFOverlayOff();
  self ThermalVisionOff();
  self ControlsUnlink();
  self CameraUnlink();

  if(getDvarInt("camera_thirdPerson"))
    self setThirdPersonDOF(true);
}