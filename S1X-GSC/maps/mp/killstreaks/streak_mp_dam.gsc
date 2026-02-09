/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_dam.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.killstreakFuncs["mp_dam"] = ::tryUseDamKillstreak;
  level.mapKillStreak = "mp_dam";

  level.dam_killstreak_duration = 30;

  precacheshader("s1_railgun_hud_reticle_center");
  precacheshader("s1_railgun_hud_reticle_meter_circ");
  precacheshader("s1_railgun_hud_inner_frame_edge");
  precacheshader("s1_railgun_hud_inner_frame_edge_right");

  PreCacheItem("killstreak_dam_mp");

  PreCacheModel("mp_dam_large_caliber_turret");

  level.HUDItem = [];
}

tryUseDamKillstreak(lifeId, modules) {
  if(isDefined(level.mp_dam_player)) {
    self iPrintLnBold(&"MP_DAM_IN_USE");
    return false;
  }

  if(self isUsingRemote()) {
    return false;
  }

  if(self isAirDenied()) {
    return false;
  }

  if(self isEMPed()) {
    return false;
  }

  if(isDefined(self.ControllingWarbird) && self.ControllingWarbird == true) {
    self iprintLnBold(&"MP_WARBIRD_ACTIVE");
    return false;
  }

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak();
  if(result != "success") {
    return false;
  }
  self setUsingRemote("mp_dam");

  result = setMPDamPlayer(self);

  if(isDefined(result) && result) {
    self maps\mp\_matchdata::logKillstreakEvent("mp_dam", self.origin);
  } else {
    if(isUsingRemote()) {
      self clearUsingRemote();
    }
  }

  return result;
}

setMPDamPlayer(player) {
  self endon("mp_dam_player_removed");

  if(isDefined(level.mp_dam_player)) {
    return false;
  }

  level.mp_dam_player = player;

  player NotifyOnPlayerCommand("SwitchTurret", "weapnext");
  player NotifyOnPlayerCommand("SwitchVisionMode", "+actionslot 1");

  thread teamPlayerCardSplash("used_mp_dam", player);

  player thread waitSetThermal(1.0);

  if(getDvarInt("camera_thirdPerson")) {
    player setThirdPersonDOF(false);
  }

  player SetClientOmnvar("ui_damturret_countdown", (level.dam_killstreak_duration * 1000) + GetTime());

  player thread CycleTurretControl();
  player thread removeMPDamPlayerAfterTime(level.dam_killstreak_duration);
  player thread removeMPDamPlayerOnDisconnect();
  player thread removeMPDamPlayerOnChangeTeams();
  player thread removeMPDamPlayerOnSpectate();
  player thread removeMPDamPlayerOnGameCleanup();
  player thread removeMPDamPlayerOnCommand();

  return true;
}

CycleTurretControl() {
  self endon("mp_dam_player_removed");

  player = self;

  if(isDefined(level.DamTurrets)) {
    player EnableSlowAim(.2, .2);
    while(1) {
      for(i = 0; i < level.DamTurrets.size; i++) {
        turret = level.DamTurrets[i];

        turret.owner = player;
        turret.team = player.team;
        turret.pers["team"] = player.team;
        if(level.teamBased) {
          turret SetTurretTeam(player.team);
        }
        player.turret = turret;

        turret setmode("sentry_manual");
        turret SetSentryOwner(player);
        player thread shotFired(turret);

        if(i == 0) {
          player PlayerLinkWeaponViewToDelta(turret, "tag_player", 0, 60, 30, 5, 58, false);
        } else {
          player PlayerLinkWeaponViewToDelta(turret, "tag_player", 0, 40, 50, 5, 58, false);
        }

        player PlayerLinkedSetUseBaseAngleForViewClamp(true);

        player RemoteControlTurret(turret, 40);

        wait .5;

        if(isDefined(self.DamThermal) && self.DamThermal == true) {
          self ThermalVisionOn();
        }

        self SetClientOmnvar("ui_damturret_toggle", true);

        self waittill("SwitchTurret");

        if(isDefined(self.DamThermal) && self.DamThermal == true) {
          self ThermalVisionOff();
        }

        self SetClientOmnvar("ui_damturret_toggle", false);

        player TransitionTurret();

        player Unlink();
        player RemoteControlTurretOff(turret);

        turret SetMode("manual");
        turret SetTargetEntity(level.DamDefaultAimEnt);
      }
    }
  }
}

TransitionTurret() {
  self VisionSetNakedForPlayer("black_bw", 0.75);
  wait .8;
  self revertVisionSetForTurretPlayer(.5);
}

revertVisionSetForTurretPlayer(time) {
  AssertEx(isPlayer(self), "revertVisionSetForPlayer() called on a non player entity");

  if(!isDefined(time)) {
    time = 1;
  }
  if(isDefined(level.nukeDetonated) && isDefined(level.nukeVisionSet)) {
    self VisionSetNakedForPlayer(level.nukeVisionSet, time);
  } else if(isDefined(self.usingRemote) && isDefined(self.rideVisionSet)) {
    self VisionSetNakedForPlayer(self.rideVisionSet, time);
  } else {
    self VisionSetNakedForPlayer("", time);
  }
}

waitSetThermal(delay) {
  self endon("disconnect");
  level endon("mp_dam_player_removed");

  wait(delay);

  self VisionSetThermalForPlayer(game["thermal_vision"], 0);
  self ThermalVisionFOFOverlayOn();
  self SetBlurForPlayer(1.1, 0);
}

thermalVision() {
  self endon("mp_dam_player_removed");

  while(1) {
    self.DamThermal = false;
    self waittill("SwitchVisionMode");
    self ThermalVisionOn();

    self.DamThermal = true;
    self waittill("SwitchVisionMode");
    self ThermalVisionOff();
  }
}

createMPDamKillstreakClock() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mp_dam_player_removed");

  self.dam_clock = maps\mp\gametypes\_hud_util::createTimer("hudsmall", 0.9);
  self.dam_clock maps\mp\gametypes\_hud_util::setPoint("CENTER", "CENTER", 0, -145);

  self.dam_clock setTimer(level.dam_killstreak_duration);
  self.dam_clock.color = (1.0, 1.0, 1.0);
  self.dam_clock.archived = false;
  self.dam_clock.foreground = true;

  self thread destroyMPDamKillstreakClock();
}

destroyMPDamKillstreakClock() {
  self waittill("mp_dam_player_removed");

  if(isDefined(self.dam_clock)) {
    self.dam_clock Destroy();
  }
}

removeMPDamPlayerOnCommand() {
  self endon("mp_dam_player_removed");

  while(true) {
    button_hold_time = 0;
    while(self UseButtonPressed()) {
      button_hold_time += 0.05;
      if(button_hold_time > 0.75) {
        level thread removeMPDamPlayer(self, false);
        return;
      }
      wait(0.05);
    }
    wait(0.05);
  }
}

removeMPDamPlayerOnGameCleanup() {
  self endon("mp_dam_player_removed");

  level waittill("game_cleanup");

  level thread removeMPDamPlayer(self, false);
}

removeMPDamPlayerOnDeath() {
  self endon("mp_dam_player_removed");

  self waittill("death");

  level thread removeMPDamPlayer(self, false);
}

removeMPDamPlayerOnDisconnect() {
  self endon("mp_dam_player_removed");

  self waittill("disconnect");

  level thread removeMPDamPlayer(self, true);
}

removeMPDamPlayerOnChangeTeams() {
  self endon("mp_dam_player_removed");

  self waittill("joined_team");

  level thread removeMPDamPlayer(self, false);
}

removeMPDamPlayerOnSpectate() {
  self endon("mp_dam_player_removed");

  self waittill_any("joined_spectators", "spawned");

  level thread removeMPDamPlayer(self, false);
}

removeMPDamPlayerAfterTime(removeDelay) {
  self endon("mp_dam_player_removed");

  if(self _hasPerk("specialty_blackbox") && isDefined(self.specialty_blackbox_bonus)) {
    removeDelay *= self.specialty_blackbox_bonus;
  }

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(removeDelay);

  level thread removeMPDamPlayer(self, false);
}

removeMPDamPlayer(player, disconnected) {
  player notify("mp_dam_player_removed");
  level notify("mp_dam_player_removed");

  waittillframeend;

  if(!disconnected) {
    player SetClientOmnvar("ui_damturret_toggle", false);
    player SetBlurForPlayer(0, 0);
    player ThermalVisionOff();
    player ThermalVisionFOFOverlayOff();
    player RemoteControlTurretOff(player.turret);
    player Unlink();
    player clearUsingRemote();
    player revertVisionSetForPlayer(.5);
    player DisableSlowAim();

    if(getDvarInt("camera_thirdPerson")) {
      player setThirdPersonDOF(true);
    }

    if(isDefined(player.darkScreenOverlay)) {
      player.darkScreenOverlay destroy();
    }

    foreach(turret in level.DamTurrets) {
      turret SetMode("manual");
      turret SetTargetEntity(level.DamDefaultAimEnt);
    }
  }

  level.mp_dam_player = undefined;
}

overlay(player) {
  level.HUDItem["thermal_vision"] = NewClientHudElem(player);
  level.HUDItem["thermal_vision"].x = 200;
  level.HUDItem["thermal_vision"].y = 0;
  level.HUDItem["thermal_vision"].alignX = "left";
  level.HUDItem["thermal_vision"].alignY = "top";
  level.HUDItem["thermal_vision"].horzAlign = "left";
  level.HUDItem["thermal_vision"].vertAlign = "top";
  level.HUDItem["thermal_vision"].fontScale = 2.5;
  level.HUDItem["thermal_vision"] SetText(&"AC130_HUD_FLIR");
  level.HUDItem["thermal_vision"].alpha = 1.0;

  level.HUDItem["enhanced_vision"] = NewClientHudElem(player);
  level.HUDItem["enhanced_vision"].x = -200;
  level.HUDItem["enhanced_vision"].y = 0;
  level.HUDItem["enhanced_vision"].alignX = "right";
  level.HUDItem["enhanced_vision"].alignY = "top";
  level.HUDItem["enhanced_vision"].horzAlign = "right";
  level.HUDItem["enhanced_vision"].vertAlign = "top";
  level.HUDItem["enhanced_vision"].fontScale = 2.5;
  level.HUDItem["enhanced_vision"] SetText(&"AC130_HUD_OPTICS");
  level.HUDItem["enhanced_vision"].alpha = 1.0;

  player setBlurForPlayer(1.2, 0);
}

shotFired(turret) {
  self endon("mp_dam_player_removed");
  self endon("SwitchTurret");
  for(;;) {
    turret waittill("turret_fire");

    earthquake(0.25, 1.0, turret.origin, 3500);
    PlayRumbleOnPosition("artillery_rumble", turret.origin);
    self thread shotFiredDarkScreenOverlay();

    wait 0.05;
  }
}

shotFiredDarkScreenOverlay() {
  self endon("mp_dam_player_removed");
  self notify("darkScreenOverlay");
  self endon("darkScreenOverlay");

  if(!isDefined(self.darkScreenOverlay)) {
    self.darkScreenOverlay = NewClientHudElem(self);
    self.darkScreenOverlay.x = 0;
    self.darkScreenOverlay.y = 0;
    self.darkScreenOverlay.alignX = "left";
    self.darkScreenOverlay.alignY = "top";
    self.darkScreenOverlay.horzAlign = "fullscreen";
    self.darkScreenOverlay.vertAlign = "fullscreen";
    self.darkScreenOverlay setshader("black", 640, 480);
    self.darkScreenOverlay.sort = -10;
    self.darkScreenOverlay.alpha = 0.0;
  }

  self.darkScreenOverlay.alpha = 0.0;
  self.darkScreenOverlay fadeOverTime(0.05);
  self.darkScreenOverlay.alpha = 0.2;
  wait 0.4;
  self.darkScreenOverlay fadeOverTime(0.8);
  self.darkScreenOverlay.alpha = 0.0;
}

movementAudio(turret) {
  self endon("mp_dam_player_removed");
  self endon("SwitchTurret");

  if(!isDefined(level.aud)) {
    level.aud = spawnStruct();
  }

  self thread movementAudioCleanup();

  while(true) {
    yaw_rate = turret GetTurretYawRate();
    yaw_rate = abs(yaw_rate);

    pitch_rate = turret GetTurretPitchRate();
    pitch_rate = abs(pitch_rate);

    if(yaw_rate > 0.1) {
      if(!isDefined(level.aud.turretYawLp)) {
        level.aud.turretYawLp = spawn("script_origin", turret.origin);
        level.aud.turretYawLp playLoopSound("wpn_railgun_dam_lat_move_lp");
      }
    } else {
      if(isDefined(level.aud.turretYawLp)) {
        level.aud.turretYawLp StopLoopSound();
        level.aud.turretYawLp Delete();
        level.aud.turretYawLp = undefined;
        turret playSound("wpn_railgun_dam_lat_stop");
      }
    }

    if(pitch_rate > 0.1) {
      if(!isDefined(level.aud.turretPitchLp)) {
        level.aud.turretPitchLp = spawn("script_origin", turret.origin);
        level.aud.turretPitchLp playLoopSound("wpn_railgun_dam_vert_move_lp");
      }
    } else {
      if(isDefined(level.aud.turretPitchLp)) {
        level.aud.turretPitchLp StopLoopSound();
        level.aud.turretPitchLp Delete();
        level.aud.turretPitchLp = undefined;
        turret playSound("wpn_railgun_dam_vert_stop");
      }
    }

    wait 0.05;
  }
}

movementAudioCleanup() {
  self waittill("mp_dam_player_removed");

  if(isDefined(level.aud.turretYawLp)) {
    level.aud.turretYawLp StopLoopSound();
    level.aud.turretYawLp Delete();
    level.aud.turretYawLp = undefined;
  }

  if(isDefined(level.aud.turretPitchLp)) {
    level.aud.turretPitchLp StopLoopSound();
    level.aud.turretPitchLp Delete();
    level.aud.turretPitchLp = undefined;
  }
}