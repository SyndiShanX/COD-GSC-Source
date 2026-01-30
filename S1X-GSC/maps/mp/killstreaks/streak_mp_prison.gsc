/****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_prison.gsc
****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.mp_prison_killstreak_duration = 25;

  precacheLocationSelector("map_artillery_selector");
  precacheString(&"KILLSTREAKS_MP_PRISON");

  PreCacheItem("prison_turret_mp");

  PreCacheLaser("prison_laser");

  level.mp_prison_InUse = false;
  level.prison_turrets_alive = 0;
  level.prison_turret_alarm_sfx = "mp_prison_ks_alarm";
  level.prison_turret_burn_sfx = "orbital_laser";
  level.prison_turret_warning_light_friendly = LoadFX("vfx/lights/light_tracking_prison_blink_friendly");
  level.prison_turret_warning_light_enemy = LoadFX("vfx/lights/light_tracking_prison_blink_enemy");
  level.prison_turret_laser_glow = LoadFX("vfx/lights/prison_tracking_laser_blue");

  level.killStreakFuncs["mp_prison"] = ::tryUseMpPrison;
  level.mapKillStreak = "mp_prison";

  if(!isDefined(level.sentrySettings)) {
    level.sentrySettings = [];
  }

  level.sentrySettings["prison_turret"] = spawnStruct();
  level.sentrySettings["prison_turret"].health = 999999;
  level.sentrySettings["prison_turret"].maxHealth = 1000;
  level.sentrySettings["prison_turret"].burstMin = 20;
  level.sentrySettings["prison_turret"].burstMax = 120;
  level.sentrySettings["prison_turret"].pauseMin = 0.15;
  level.sentrySettings["prison_turret"].pauseMax = 0.35;
  level.sentrySettings["prison_turret"].sentryModeOn = "sentry";
  level.sentrySettings["prison_turret"].sentryModeOff = "sentry_offline";
  level.sentrySettings["prison_turret"].timeOut = 90.0;
  level.sentrySettings["prison_turret"].spinupTime = 0.05;
  level.sentrySettings["prison_turret"].overheatTime = 8.0;
  level.sentrySettings["prison_turret"].cooldownTime = 0.1;
  level.sentrySettings["prison_turret"].fxTime = 0.3;
  level.sentrySettings["prison_turret"].streakName = "sentry";
  level.sentrySettings["prison_turret"].weaponInfo = "prison_turret_mp";
  level.sentrySettings["prison_turret"].modelBase = "prison_security_laser";
  level.sentrySettings["prison_turret"].modelPlacement = "sentry_minigun_weak_obj";
  level.sentrySettings["prison_turret"].modelPlacementFailed = "sentry_minigun_weak_obj_red";
  level.sentrySettings["prison_turret"].modelDestroyed = "sentry_minigun_weak_destroyed";
  level.sentrySettings["prison_turret"].hintString = &"MP_PRISON_SENSOR_PICKUP";
  level.sentrySettings["prison_turret"].headIcon = true;
  level.sentrySettings["prison_turret"].teamSplash = "used_sentry";
  level.sentrySettings["prison_turret"].shouldSplash = false;
  level.sentrySettings["prison_turret"].voDestroyed = "sentry_destroyed";

  level.mapKillstreakPickupString = level.sentrySettings["prison_turret"].hintString;

  level thread onPrisonPlayerConnect();

  level.prison_turrets = setupPrisonTurrets();
}

tryUseMpPrison(lifeId, modules) {
  if(level.mp_prison_InUse) {
    self iPrintLnBold(&"MP_PRISON_IN_USE");
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

  result = setPrisonTurretPlayer(self);

  if(isDefined(result) && result) {
    self maps\mp\_matchdata::logKillstreakEvent("mp_prison", self.origin);
  }

  return result;
}

setupPrisonTurrets() {
  turrets = getEntArray("prison_turret", "targetname");

  sentryType = "prison_turret";

  for(i = 0; i < turrets.size; i++) {
    turrets[i].spawned_turret = SpawnTurret("misc_turret", turrets[i].origin, level.sentrySettings[sentryType].weaponInfo, false);
    turrets[i].spawned_turret makeTurretSolid();
    turrets[i].spawned_turret sentry_initSentry(sentryType);
    turrets[i].spawned_turret.angles = turrets[i].angles;

    turrets[i].spawned_turret.alarm_on = false;
    turrets[i].spawned_turret.burn_on = false;
    turrets[i].spawned_turret.proxy_alarm_on = false;
    turrets[i].spawned_turret.prison_turret_active = false;
  }

  return turrets;
}

sentry_initSentry(sentryType) {
  self.sentryType = sentryType;
  self.canBePlaced = true;

  self setModel(level.sentrySettings[self.sentryType].modelBase);
  self makeTurretInoperable();
  self SetDefaultDropPitch(0.0);

  self setTurretModeChangeWait(true);
  self maps\mp\killstreaks\_autosentry::sentry_setInactive();

  self thread maps\mp\killstreaks\_autosentry::sentry_handleUse();
}

setPrisonTurretPlayer(player) {
  if(level.mp_prison_InUse) {
    return false;
  }

  level.mp_prison_InUse = true;

  for(i = 0; i < level.prison_turrets.size; i++) {
    level.prison_turrets_alive++;
    Assert(isDefined(level.prison_turrets[i].spawned_turret));
    level.prison_turrets[i].spawned_turret sentry_setOwner(player);
    level.prison_turrets[i].spawned_turret.shouldSplash = false;
    level.prison_turrets[i].spawned_turret.carriedBy = player;
    level.prison_turrets[i].spawned_turret sentry_setPlaced();

    level.prison_turrets[i].spawned_turret setCanDamage(true);
    level.prison_turrets[i].spawned_turret setCanRadiusDamage(true);
    level.prison_turrets[i].spawned_turret thread sentry_handleDamage();
    level.prison_turrets[i].spawned_turret thread sentry_handleDeath();

    level.prison_turrets[i].spawned_turret.alarm_on = false;
    level.prison_turrets[i].spawned_turret.burn_on = false;
    level.prison_turrets[i].spawned_turret.proxy_alarm_on = false;
    level.prison_turrets[i].spawned_turret.shocking_target = false;
    level.prison_turrets[i].spawned_turret.prison_turret_active = true;
    level.prison_turrets[i].spawned_turret.numNearbyPlayers = 0;

    level.prison_turrets[i].spawned_turret thread prisonTurretPortableRadar();
    level.prison_turrets[i].spawned_turret thread repeatOneShotPrisonAlarm();
    level.prison_turrets[i].spawned_turret thread aud_play_announcer_warning();
  }

  level thread prisonTurretTimer();
  level thread monitorPrisonKillstreakOwnership();
  level thread applyPrisonTurretRadarArrow();

  return true;
}

prisonTurretTimer() {
  level endon("game_ended");

  wait_time = level.mp_prison_killstreak_duration;

  while(wait_time > 0) {
    wait(1);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    wait_time--;

    if(level.mp_prison_InUse == false) {
      return;
    }
  }

  for(i = 0; i < level.prison_turrets.size; i++) {
    level.prison_turrets[i].spawned_turret notify("fake_prison_death");
  }
}

sentry_setOwner(owner) {
  self.owner = owner;

  self SetSentryOwner(self.owner);

  if(level.teamBased && isDefined(owner)) {
    self.team = self.owner.team;
    self setTurretTeam(self.team);
  }

  self thread sentry_handleOwnerDisconnect();
}

sentry_setPlaced() {
  self setSentryCarrier(undefined);

  self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
  }

  self sentry_setActive();

  self playSound("sentry_gun_plant");

  self notify("placed");
}

sentry_handleDamage() {
  self endon("fake_prison_death");
  level endon("game_ended");

  self.health = level.sentrySettings[self.sentryType].health;
  self.maxHealth = level.sentrySettings[self.sentryType].maxHealth;
  self.damageTaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
      continue;
    }

    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
      self.wasDamagedFromBulletPenetration = true;
    }

    modifiedDamage = 0;

    if(isDefined(weapon)) {
      shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

      switch (shortWeapon) {
        case "emp_grenade_mp":
        case "emp_grenade_var_mp":
          self.largeProjectileDamage = false;
          modifiedDamage = self.maxHealth + 1;
          if(isPlayer(attacker)) {
            attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("sentry");
          }
          break;
        default:
          if(meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET") {
            modifiedDamage = damage * 3.5;
          } else {
            modifiedDamage = 0;
          }
          if(IsPlayer(attacker)) {
            attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("sentry");
          }
          break;
      }

      maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);
    }

    self.damageTaken += modifiedDamage;

    if(self.damageTaken >= self.maxHealth) {
      thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, attacker, damage, meansOfDeath, weapon);

      if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
        level thread maps\mp\gametypes\_rank::awardGameEvent("map_killstreak_destroyed", attacker, weapon, undefined, meansOfDeath);
      }

      if(isDefined(self.owner)) {
        self.owner thread leaderDialogOnPlayer(level.sentrySettings[self.sentryType].voDestroyed, undefined, undefined, self.origin);
      }

      self notify("fake_prison_death");

      return;
    }
  }
}

sentry_handleDeath() {
  self waittill("fake_prison_death");

  if(!isDefined(self)) {
    return;
  }

  self maps\mp\killstreaks\_autosentry::sentry_setInactive();
  self SetSentryOwner(undefined);
  self SetTurretMinimapVisible(false);

  if(level.sentrySettings[self.sentryType].headIcon) {
    if(level.teamBased) {
      self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
    } else {
      self maps\mp\_entityheadicons::setPlayerHeadIcon("none", (0, 0, 0));
    }
  }

  level.prison_turrets_alive--;

  self setCanDamage(false);
  self setCanRadiusDamage(false);

  if(self.alarm_on == true) {
    self.alarm_on = false;
  }
  if(self.burn_on == true) {
    self.burn_on = false;
  }
  if(isDefined(self.previous_turret_target)) {
    self notify("lost_or_changed_target");
    self.previous_turret_target = undefined;
  }
  self.shocking_target = false;
  self.turret_on_target = undefined;

  if(self.proxy_alarm_on == true) {
    self.proxy_alarm_on = false;
  }
  self.prison_turret_active = false;
}

sentry_setActive() {
  self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);

  if(level.sentrySettings[self.sentryType].headIcon) {
    if(level.teamBased) {
      self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 25));
    } else {
      self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 25));
    }
  }
}

sentry_handleOwnerDisconnect() {
  level endon("game_ended");
  self endon("fake_prison_death");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("fake_prison_death");
}

monitorPrisonKillstreakOwnership() {
  level endon("game_ended");

  while(level.prison_turrets_alive > 0) {
    wait(0.05);
  }

  level.mp_prison_InUse = false;

  for(i = 0; i < level.prison_turrets.size; i++) {
    if(level.prison_turrets[i].spawned_turret.proxy_alarm_on == true) {
      level.prison_turrets[i].spawned_turret.proxy_alarm_on = false;
    }

    for(j = 0; j < level.players.size; j++) {
      level.players[j].laser_tag_array[i] LaserOff();
      stopFXOnTag(level.prison_turret_laser_glow, level.players[j].laser_tag_array[i], "tag_laser");
      level.players[j].laser_tag_array[i] ClearLookAtTarget();
      level.players[j].laser_tag_array[i].laserFXActive = false;
    }
  }

  for(k = 0; k < level.players.size; k++) {
    level.players[k].numNearbyPrisonTurrets = 0;

    if(level.players[k] HasPerk("specialty_radararrow", true)) {
      level.players[k] unsetPerk("specialty_radararrow", true);
    }

    level.players[k] notify("player_not_tracked");

    level.players[k].is_being_tracked = false;
  }
}

handlePrisonTurretLights() {
  playFXOnTag(level.prison_turret_warning_light_friendly, self, "tag_fx");

  self waittill("fake_prison_death");

  stopFXOnTag(level.prison_turret_warning_light_friendly, self, "tag_fx");
}

prisonTurretPortableRadar() {
  level endon("game_ended");

  self.portable_radar = spawn("script_model", self.origin);
  self.portable_radar.team = self.team;

  self.portable_radar.targetname = "portable_radar";

  self.portable_radar makePortableRadar(self.owner);

  self waittill("fake_prison_death");

  level maps\mp\gametypes\_portable_radar::deletePortableRadar(self.portable_radar);
  self.portable_radar = undefined;
}

applyPrisonTurretRadarArrow() {
  level endon("game_ended");

  while(level.mp_prison_InUse) {
    if(isDefined(level.prison_turrets) && isDefined(level.players)) {
      for(i = 0; i < level.prison_turrets.size; i++) {
        if(level.prison_turrets[i].spawned_turret.prison_turret_active != true) {
          for(j = 0; j < level.players.size; j++) {
            if(level.players[j].laser_tag_array[i].laserFXActive == true) {
              level.players[j].laser_tag_array[i] LaserOff();
              level.players[j].laser_tag_array[i] ClearLookAtTarget();
              level.players[j].laser_tag_array[i].laserFXActive = false;
            }
          }
          continue;
        }

        level.prison_turrets[i].spawned_turret.numNearbyPlayers = 0;

        for(j = 0; j < level.players.size; j++) {
          setLaserToOn = false;

          randomRange = 10;
          randomOffset = (randomFloat(randomRange), randomFloat(randomRange), randomFloat(randomRange)) - (5, 5, 5);
          if(level.players[j] GetStance() == "stand") {
            player_origin_offset = (0, 0, 50) + randomOffset;
          } else if(level.players[j] GetStance() == "crouch") {
            player_origin_offset = (0, 0, 35) + randomOffset;
          } else {
            player_origin_offset = (0, 0, 10) + randomOffset;
          }

          if(isDefined(level.players[j]) && IsAlive(level.players[j]) &&
            ((level.teamBased && level.players[j].team != level.prison_turrets[i].spawned_turret.team) ||
              (!level.teamBased && level.players[j] != level.prison_turrets[i].spawned_turret.owner))) {
            turret_to_player_distance = DistanceSquared(level.players[j].origin, level.prison_turrets[i].spawned_turret.origin);

            if(turret_to_player_distance < 3610000) {
              if(SightTracePassed(level.prison_turrets[i].spawned_turret.origin, level.players[j].origin + player_origin_offset, false, undefined)) {
                setLaserToOn = true;
              }
            }
          }

          if(setLaserToOn) {
            if(level.players[j].laser_tag_array[i].laserFXActive == false) {
              level.players[j].laser_tag_array[i].laserFXActive = true;
              level.players[j].laser_tag_array[i] LaserOn("prison_laser");
              playFXOnTag(level.prison_turret_laser_glow, level.players[j].laser_tag_array[i], "tag_laser");
              level.players[j].laser_tag_array[i] SetLookAtTarget(level.players[j], "bone", "tag_eye", "randomoffset");
            }

            level.players[j].numNearbyPrisonTurrets++;
            level.prison_turrets[i].spawned_turret.numNearbyPlayers++;
          } else if(level.players[j].laser_tag_array[i].laserFXActive == true) {
            level.players[j].laser_tag_array[i].laserFXActive = false;
            level.players[j].laser_tag_array[i] LaserOff();
            stopFXOnTag(level.prison_turret_laser_glow, level.players[j].laser_tag_array[i], "tag_laser");
            level.players[j].laser_tag_array[i] ClearLookAtTarget();
          }
        }

        if(level.prison_turrets[i].spawned_turret.numNearbyPlayers > 0) {
          if(level.prison_turrets[i].spawned_turret.proxy_alarm_on == false) {
            level.prison_turrets[i].spawned_turret.proxy_alarm_on = true;
          }
        } else {
          if(level.prison_turrets[i].spawned_turret.proxy_alarm_on == true) {
            level.prison_turrets[i].spawned_turret.proxy_alarm_on = false;
          }
        }
      }

      for(k = 0; k < level.players.size; k++) {
        if(level.players[k].numNearbyPrisonTurrets > 0) {
          level.players[k] setPerk("specialty_radararrow", true, false);

          if(level.players[k].is_being_tracked == false) {
            level.players[k].is_being_tracked = true;
          }
        } else {
          if(level.players[k] HasPerk("specialty_radararrow", true)) {
            level.players[k] unsetPerk("specialty_radararrow", true);
          }

          level.players[k] notify("player_not_tracked");

          level.players[k].is_being_tracked = false;
        }

        level.players[k].numNearbyPrisonTurrets = 0;
      }
    }
    wait(0.1);
  }
}

createLaserTagArray() {
  if(!isDefined(self.laser_tag_array)) {
    self.laser_tag_array = [];
    for(i = 0; i < level.prison_turrets.size; i++) {
      laserOrigin = level.prison_turrets[i].spawned_turret.origin;
      self.laser_tag_array[i] = spawn("script_model", laserOrigin);
      self.laser_tag_array[i] setModel("tag_laser");
      self.laser_tag_array[i].laserFXActive = false;

      self.laser_tag_array[i].targetname = "tag_laser";
    }
  }
}

deleteLaserTagArray() {
  if(isDefined(self.laser_tag_array)) {
    for(i = 0; i < level.prison_turrets.size; i++) {
      self.laser_tag_array[i] ClearLookAtTarget();
      self.laser_tag_array[i] Delete();
    }
  }
}

onPrisonPlayerConnect() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    player.is_being_tracked = false;

    player createLaserTagArray();

    player.numNearbyPrisonTurrets = 0;

    player thread onPrisonPlayerDisconnect();
  }
}

onPrisonPlayerDisconnect() {
  level endon("game_ended");

  self waittill("disconnect");

  self deleteLaserTagArray();
}

createPrisonTurretTrackingOverlay() {
  if(!isDefined(self.prisonTurretTrackingOverlay)) {
    self.prisonTurretTrackingOverlay = newClientHudElem(self);
    self.prisonTurretTrackingOverlay.x = -80;
    self.prisonTurretTrackingOverlay.y = -60;
    self.prisonTurretTrackingOverlay setshader("tracking_drone_targeted_overlay", 800, 600);
    self.prisonTurretTrackingOverlay.alignX = "left";
    self.prisonTurretTrackingOverlay.alignY = "top";
    self.prisonTurretTrackingOverlay.horzAlign = "fullscreen";
    self.prisonTurretTrackingOverlay.vertAlign = "fullscreen";
    self.prisonTurretTrackingOverlay.alpha = 0;
  }
}

fadeInOutPrisonTrackingOverlay() {
  level endon("game_ended");
  self endon("player_not_tracked");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  while(true) {
    if(isDefined(self.TurretTrackingOverlay)) {
      brightness = randomFloatRange(0.25, 1.0);
      self.prisonTurretTrackingOverlay FadeOverTime(0.1);
      self.prisonTurretTrackingOverlay.color = (brightness, brightness, brightness);
      self.prisonTurretTrackingOverlay.alpha = 1;
      wait 0.1;
    }
    wait(0.05);
  }
}

endPrisonTrackingOverlay() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  self.prisonTurretTrackingOverlay FadeOverTime(0.2);
  self.prisonTurretTrackingOverlay.alpha = 0.0;
}

repeatOneShotPrisonAlarm() {
  self endon("fake_prison_death");

  while(level.mp_prison_InUse) {
    if(self.proxy_alarm_on == true) {
      playSoundAtPos(self.origin, level.prison_turret_alarm_sfx);
    }

    wait(4);
  }
}

aud_play_announcer_warning() {
  wait(2.5);
  playSoundAtPos((0, 0, 0), "mp_prison_anouncer_ext");
}