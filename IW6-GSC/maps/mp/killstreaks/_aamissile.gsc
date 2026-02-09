/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_aamissile.gsc
**********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  precacheItem("aamissile_projectile_mp");
  precacheShader("ac130_overlay_grain");

  level.AAMissileLaunchVert = 14000;
  level.AAMissileLaunchHorz = 30000;
  level.AAMissileLaunchTargetDist = 1500;

  level.rockets = [];
  level.killstreakFuncs["aamissile"] = ::tryUseAAMissile;
}

tryUseAAMissile(lifeId, streakName) {
  self setUsingRemote("aamissile");
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak();
  if(result != "success") {
    if(result != "disconnect")
      self clearUsingRemote();

    return false;
  }

  level thread aa_missile_fire(lifeId, self);

  return true;
}

getTargets() {
  lbTargets = [];
  heliTargets = [];

  if(isDefined(level.littleBirds) && level.littleBirds.size) {
    foreach(lb in level.littleBirds) {
      if(lb.team != self.team)
        lbTargets[lbTargets.size] = lb;
    }
  }

  if(isDefined(level.helis) && level.helis.size) {
    foreach(heli in level.helis) {
      if(heli.team != self.team)
        heliTargets[heliTargets.size] = heli;
    }
  }

  if(isDefined(heliTargets) && heliTargets.size)
    return heliTargets[0];
  else if(isDefined(lbTargets) && lbTargets.size)
    return lbTargets[0];
}

aa_missile_fire(lifeId, player) {
  aaMissileSpawn = undefined;

  upVector = (0, 0, level.AAMissileLaunchVert);
  backDist = level.AAMissileLaunchHorz;
  targetDist = level.AAMmissileLaunchTargetDist;

  bestTarget = player getTargets();

  if(!isDefined(bestTarget))
    targetPos = (0, 0, 0);
  else {
    targetPos = bestTarget.origin;
    upVector = (0, 0, 1) * (targetPos) + (0, 0, 1000);
  }

  forward = anglesToForward(player.angles);
  startpos = player.origin + upVector + forward * backDist * -1;

  rocket = MagicBullet("aamissile_projectile_mp", startpos, targetPos, player);

  if(!isDefined(rocket)) {
    player clearUsingRemote();
    return;
  }

  rocket.lifeId = lifeId;
  rocket.type = "remote";
  MissileEyes(player, rocket);
}

MissileEyes(player, rocket) {
  player endon("joined_team");
  player endon("joined_spectators");

  rocket thread Rocket_CleanupOnDeath();
  player thread Player_CleanupOnGameEnded(rocket);
  player thread Player_CleanupOnTeamChange(rocket);

  player VisionSetMissilecamForPlayer("black_bw", 0);

  player endon("disconnect");

  if(isDefined(rocket)) {
    player VisionSetMissilecamForPlayer(game["thermal_vision"], 1.0);
    player thread delayedFOFOverlay();
    player CameraLinkTo(rocket, "tag_origin");
    player ControlsLinkTo(rocket);

    if(getDvarInt("camera_thirdPerson"))
      player setThirdPersonDOF(false);

    rocket waittill("death");

    if(isDefined(rocket))
      player maps\mp\_matchdata::logKillstreakEvent("predator_missile", rocket.origin);

    player ControlsUnlink();
    player freezeControlsWrapper(true);

    if(!level.gameEnded || isDefined(player.finalKill))
      player thread staticEffect(0.5);

    wait(0.5);

    player ThermalVisionFOFOverlayOff();

    player CameraUnlink();

    if(getDvarInt("camera_thirdPerson"))
      player setThirdPersonDOF(true);
  }

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
  self ControlsUnlink();
  self CameraUnlink();

  if(getDvarInt("camera_thirdPerson"))
    self setThirdPersonDOF(true);
}