/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_tracking_drone.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;

STUNNED_TIME = 10.0;
Z_OFFSET = (0, 0, 90);

BALL_DRONE_SPAWN_STAND_UP_OFFSET = 80;
BALL_DRONE_SPAWN_CROUCH_UP_OFFSET = 65;
BALL_DRONE_SPAWN_PRONE_UP_OFFSET = 37;
BALL_DRONE_SPAWN_FORWARD_OFFSET = 50;
BALL_DRONE_SPAWN_SIDE_OFFSET = 0;

BALL_DRONE_STAND_UP_OFFSET = 65;
BALL_DRONE_CROUCH_UP_OFFSET = 50;
BALL_DRONE_PRONE_UP_OFFSET = 22;
BALL_DRONE_FORWARD_OFFSET = 65;
BALL_DRONE_SIDE_OFFSET = 0;

HORDE_BALL_DRONE_STAND_UP_OFFSET = 105;
HORDE_BALL_DRONE_CROUCH_UP_OFFSET = 75;
HORDE_BALL_DRONE_PRONE_UP_OFFSET = 45;
HORDE_BALL_DRONE_FORWARD_OFFSET = 0;
HORDE_BALL_DRONE_SIDE_OFFSET = 30;

watchTrackingDroneUsage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level.trackingDroneSettings)) {
    trackingDroneInit();
  }

  while(1) {
    self waittill("grenade_fire", grenade, weapname);

    shortWeaponName = maps\mp\_utility::strip_suffix(weapname, "_lefthand");

    if(shortWeaponName == "tracking_drone_mp") {
      grenade thread destroy_tracking_drone_in_water();

      wait(0.5);

      if(!IsRemovedEntity(grenade) && isDefined(grenade)) {
        self.trackingDroneStartPosition = grenade.origin;
        self.trackingDroneStartAngles = grenade.angles;

        grenade deleteTrackingDrone();

        if(!prevent_tracking_drone_in_water(self.trackingDroneStartPosition)) {
          tryUseTrackingDrone(weapname);
        }
      }
    }
  }
}

trackingDroneInit() {
  level.trackingDroneMaxPerPlayer = 1;

  level.trackingDroneSettings = spawnStruct();
  level.trackingDroneSettings.timeOut = 20.0;
  level.trackingDroneSettings.ExplosiveTimeOut = 30.0;
  level.trackingDroneSettings.health = 999999;
  level.trackingDroneSettings.maxHealth = 60;
  level.trackingDroneSettings.vehicleInfo = "vehicle_tracking_drone_mp";
  level.trackingDroneSettings.modelBase = "npc_drone_tracking";
  level.trackingDroneSettings.fxId_sparks = Loadfx("vfx/sparks/direct_hack_stun");
  level.trackingDroneSettings.fxId_laser_glow = Loadfx("vfx/lights/tracking_drone_laser_blue");
  level.trackingDroneSettings.fxId_explode = LoadFX("vfx/explosion/tracking_drone_explosion");
  level.trackingDroneSettings.fxId_LethalExplode = LoadFX("vfx/explosion/frag_grenade_default");
  level.trackingDroneSettings.fxId_warning = LoadFX("vfx/lights/light_tracking_drone_blink_warning");
  level.trackingDroneSettings.fxId_enemy_light = LoadFX("vfx/lights/light_tracking_drone_blink_enemy");
  level.trackingDroneSettings.fxId_friendly_light = LoadFX("vfx/lights/light_tracking_drone_blink_friendly");
  level.trackingDroneSettings.fxId_thruster_down = LoadFX("vfx/distortion/tracking_drone_distortion_down");
  level.trackingDroneSettings.fxId_thruster_up = LoadFX("vfx/distortion/tracking_drone_distortion_up");
  level.trackingDroneSettings.fxId_engine_distort = LoadFX("vfx/distortion/tracking_drone_distortion_hemi");
  level.trackingDroneSettings.sound_explode = "veh_tracking_drone_explode";
  level.trackingDroneSettings.sound_lock = "veh_tracking_drone_lock_lp";

  level.trackingDrones = [];

  foreach(player in level.players) {
    player.is_being_tracked = false;
  }

  level thread onTrackingPlayerConnect();

  level.trackingDroneTimeout = level.trackingDroneSettings.timeOut;
  level.explosiveDroneTimeout = level.trackingDroneSettings.ExplosiveTimeOut;
  level.trackingDroneDebugPosition = 0;
  level.trackingDroneDebugPositionForward = BALL_DRONE_FORWARD_OFFSET;
  level.trackingDroneDebugPositionHeight = BALL_DRONE_SIDE_OFFSET;
}

tryUseTrackingDrone(weaponName) {
  numIncomingVehicles = 1;
  if(self isUsingRemote()) {
    return false;
  } else if(exceededMaxTrackingDrones()) {
    self IPrintLnBold(&"MP_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"MP_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  if(!isDefined(self.trackingDroneArray)) {
    self.trackingDroneArray = [];
  }

  if(self.trackingDroneArray.size) {
    self.trackingDroneArray = array_removeUndefined(self.trackingDroneArray);

    if(self.trackingDroneArray.size >= level.trackingDroneMaxPerPlayer) {
      if(isDefined(self.trackingDroneArray[0])) {
        self.trackingDroneArray[0] thread trackingDrone_leave();
      }
    }
  }

  incrementFauxVehicleCount();

  trackingDrone = createTrackingDrone(weaponName);

  if(!isDefined(trackingDrone)) {
    decrementFauxVehicleCount();

    return false;
  }
  trackingDrone.weaponName = weaponName;

  self.trackingDroneArray[self.trackingDroneArray.size] = trackingDrone;
  level.trackingDrones = array_removeUndefined(level.trackingDrones);
  level.trackingDrones[level.trackingDrones.size] = trackingDrone;
  self thread startTrackingDrone(trackingDrone);

  return true;
}

createTrackingDrone(weaponName, bRecreate, startPosition, startAngles, DroneType) {
  if(!isDefined(bRecreate)) {
    bRecreate = false;
  }

  if(!bRecreate) {
    origin = self getEye();
    forward = anglesToForward(self GetPlayerAngles());

    startAng = self GetPlayerAngles();
    forward = anglesToForward(startAng);
    side = AnglesToRight(startAng);

    forwardOffset = forward * BALL_DRONE_SPAWN_FORWARD_OFFSET;

    sideOffset = side * BALL_DRONE_SPAWN_SIDE_OFFSET;

    heightOffset = BALL_DRONE_SPAWN_STAND_UP_OFFSET;
    switch (self getStance()) {
      case "stand":
        heightOffset = BALL_DRONE_SPAWN_STAND_UP_OFFSET;
        break;
      case "crouch":
        heightOffset = BALL_DRONE_SPAWN_CROUCH_UP_OFFSET;
        break;
      case "prone":
        heightOffset = BALL_DRONE_SPAWN_PRONE_UP_OFFSET;
        break;
    }

    targetOffset = (0, 0, heightOffset);
    targetOffset += sideOffset;
    targetOffset += forwardOffset;

    if(level.trackingDroneDebugPosition) {
      targetOffset = (0, 0, level.trackingDroneDebugSpawnPositionHeight);
      targetOffset += forward * level.trackingDroneDebugSpawnPositionForward;
    }

    if(isDefined(self.trackingDroneStartPosition) && isDefined(self.trackingDroneStartAngles)) {
      startPos = self.trackingDroneStartPosition;
      startAng = self.trackingDroneStartAngles;
    } else {
      startPos = self.origin + targetOffset;
    }
  } else {
    startPos = startPosition;
    targetPos = startPosition;
    startAng = startAngles;
  }

  owner = self;
  if(isDefined(level.isHorde) && level.isHorde) {
    owner = level.player;
  }

  drone = SpawnHelicopter(owner, startPos, startAng, level.trackingDroneSettings.vehicleInfo, level.trackingDroneSettings.modelBase);
  if(!isDefined(drone)) {
    return;
  }

  if(isDefined(DroneType)) {
    drone.type = "explosive_drone";
    drone setModel("vehicle_pdrone");
  } else {
    drone.type = "tracking_drone";
  }

  drone make_entity_sentient_mp(self.team);
  drone MakeVehicleNotCollideWithPlayers(true);

  drone addToTrackingDroneList();
  drone thread removeFromTrackingDroneListOnDeath();

  drone.health = level.trackingDroneSettings.health;
  drone.maxHealth = level.trackingDroneSettings.maxHealth;
  drone.damageTaken = 0;

  drone.speed = 20;
  drone.followSpeed = 20;
  drone.owner = self;
  drone.team = self.team;

  drone Vehicle_SetSpeed(drone.speed, 10, 10);
  drone SetYawSpeed(120, 90);
  drone SetNearGoalNotifyDist(64);
  drone SetHoverParams(4, 5, 5);

  drone.fx_tag0 = undefined;
  if(isDefined(drone.type)) {
    if(drone.type == "tracking_drone") {
      drone.fx_tag0 = "fx_joint_0";
    } else if(drone.type == "explosive_drone") {
      drone.fx_tag0 = "TAG_EYE";
    }
  }

  if(level.teamBased) {
    drone maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 25), drone.fx_tag0);
  } else {
    drone maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 25), drone.fx_tag0);
  }

  drone.maxTrackingRange = 2000;
  drone.maxLaserRange = 300;
  drone.trackedPlayer = undefined;

  maxPitch = 45;
  maxRoll = 45;
  drone SetMaxPitchRoll(maxPitch, maxRoll);

  drone.targetPos = startPos;

  drone.attract_strength = 10000;
  drone.attract_range = 150;
  drone.attractor = Missile_CreateAttractorEnt(drone, drone.attract_strength, drone.attract_range);

  drone.hasDodged = false;
  drone.stunned = false;
  drone.inactive = false;

  drone thread maps\mp\gametypes\_damage::setEntityDamageCallback(drone.maxHealth, undefined, ::onTrackingDroneDeath, undefined, false);
  drone thread trackingDrone_watchDisable();
  drone thread trackingDrone_watchDeath();
  drone thread trackingDrone_watchOwnerLoss();
  drone thread trackingDrone_watchOwnerDeath();
  drone thread trackingDrone_watchRoundEnd();
  drone thread trackingDrone_watchHostMigration();
  if(!isDefined(level.isHorde)) {
    drone thread trackingDrone_watchTimeout();
  }

  if(drone.type == "tracking_drone") {
    drone thread trackingDrone_enemy_lightFX();
    drone thread trackingDrone_friendly_lightFX();
    drone thread drone_thrusterFX();
  }

  return drone;
}

idleTargetMover(ent) {
  self endon("disconnect");
  level endon("game_ended");
  ent endon("death");

  forward = anglesToForward(self.angles);
  while(true) {
    if(isReallyAlive(self) && !self isUsingRemote() && anglesToForward(self.angles) != forward) {
      forward = anglesToForward(self.angles);
      pos = self.origin + (forward * -100) + (0, 0, 40);
      ent MoveTo(pos, 0.5);
    }
    wait(0.5);
  }
}

trackingDrone_lightFX(fx, player) {
  player endon("disconnect");

  PlayFXOnTagForClients(fx, self, "fx_light_1", player);
  wait 0.05;
  PlayFXOnTagForClients(fx, self, "fx_light_2", player);
  wait 0.05;
  PlayFXOnTagForClients(fx, self, "fx_light_3", player);
  wait 0.05;
  PlayFXOnTagForClients(fx, self, "fx_light_4", player);
}

trackingDrone_enemy_lightFX() {
  self endon("death");

  foreach(player in level.players) {
    if(isDefined(player) && IsSentient(player) && IsSentient(self) && player.team != self.team) {
      self childthread trackingDrone_lightFX(level.trackingDroneSettings.fxId_enemy_light, player);
      wait(0.2);
    }
  }
}

trackingDrone_friendly_lightFX() {
  self endon("death");

  foreach(player in level.players) {
    if(isDefined(player) && IsSentient(player) && IsSentient(self) && player.team == self.team) {
      self childthread trackingDrone_lightFX(level.trackingDroneSettings.fxId_friendly_light, player);
      wait(0.2);
    }
  }

  self thread watchConnectedplayFX();
  self thread watchJoinedTeamplayFX();
}

drone_thrusterFX() {
  self endon("death");

  foreach(player in level.players) {
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_F", player);
    }
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_K", player);
    }
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_L", player);
    }
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_R", player);
    }
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_engine_distort)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_engine_distort, self, "TAG_WEAPON", player);
    }
    wait(0.25);
  }

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");

    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_F", player);
    }
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_K", player);
    }
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_L", player);
    }
    wait(0.1);
    if(isDefined(player) && isDefined(self) && isDefined(level.trackingDroneSettings.fxId_thruster_down)) {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_thruster_down, self, "fx_thruster_down_R", player);
    }
    wait(0.1);
    {
      PlayFXOnTagForClients(level.trackingDroneSettings.fxId_engine_distort, self, "TAG_WEAPON", player);
    }
    wait(0.25);
  }
}

watchConnectedplayFX() {
  self endon("death");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(isDefined(player) && player.team == self.team) {
      self childthread trackingDrone_lightFX(level.trackingDroneSettings.fxId_friendly_light, player);
      wait(0.2);
    }
  }
}

watchJoinedTeamplayFX() {
  self endon("death");

  while(true) {
    level waittill("joined_team", player);
    player waittill("spawned_player");

    if(isDefined(player) && player.team == self.team) {
      self childthread trackingDrone_lightFX(level.trackingDroneSettings.fxId_friendly_light, player);
      wait(0.2);
    }
  }
}

startTrackingDrone(drone) {
  level endon("game_ended");
  drone endon("death");

  drone thread trackingDrone_followTarget();
  drone thread aud_drone_start_jets();

  if(isDefined(drone.type)) {
    if(drone.type == "explosive_drone") {
      drone thread CheckForExplosiveGoal();
    } else if(drone.type == "tracking_drone" && !isDefined(level.isHorde)) {
      drone thread trackingDrone_highlightTarget();
    }
  }
}
CheckForExplosiveGoal() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");

  while(true) {
    self waittill_any("goal", "near_goal", "hit_goal");
    {
      if(self.trackedPlayer != self.owner && isReallyAlive(self.trackedPlayer)) {
        DistanceToTargetSq = DistanceSquared(self.trackedPlayer.origin, self.origin);
        if(DistanceToTargetSq <= 16384) {
          self notify("exploding");
          self thread BlowUpDroneSequence();
          break;
        }
      }
    }
  }
}
BlowUpDroneSequence() {
  Time = 2;

  StoredOwner = undefined;
  if(isDefined(self.owner)) {
    StoredOwner = self.owner;
  }
  if(isDefined(self)) {
    self thread TurnOnDangerLights();
    self playSound("drone_warning_beap");
  }

  wait(Time);
  if(isDefined(self)) {
    self playSound("drone_bomb_explosion");
    up_v = AnglesToUp(self.angles);
    forward_v = anglesToForward(self.angles);

    playFX(level.trackingDroneSettings.fxId_LethalExplode, self.origin, forward_v, up_v);
    if(isDefined(StoredOwner)) {
      self RadiusDamage(self.origin, 256, 1000, 25, StoredOwner, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp");
    } else {
      self RadiusDamage(self.origin, 256, 1000, 25, undefined, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp");
    }

    self notify("death");
  }
}
TurnOnDangerLights() {
  if(isDefined(self)) {
    stopFXOnTag(level.trackingDroneSettings.fxId_enemy_light, self, "tag_fx_beacon_0");
    stopFXOnTag(level.trackingDroneSettings.fxId_enemy_light, self, "tag_fx_beacon_1");
    stopFXOnTag(level.trackingDroneSettings.fxId_enemy_light, self, "tag_fx_beacon_2");
    stopFXOnTag(level.trackingDroneSettings.fxId_friendly_light, self, "tag_fx_beacon_0");
    stopFXOnTag(level.trackingDroneSettings.fxId_friendly_light, self, "tag_fx_beacon_1");
    stopFXOnTag(level.trackingDroneSettings.fxId_friendly_light, self, "tag_fx_beacon_2");
  }
  wait(0.05);
  if(isDefined(self)) {
    playFXOnTag(level.trackingDroneSettings.fxId_warning, self, "tag_fx_beacon_0");
    playFXOnTag(level.trackingDroneSettings.fxId_warning, self, "tag_fx_beacon_1");
  }
  wait(0.15);
  if(isDefined(self)) {
    playFXOnTag(level.trackingDroneSettings.fxId_warning, self, "tag_fx_beacon_2");
  }
}
trackingDrone_followTarget() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self endon("exploding");

  if(!isDefined(self.owner)) {
    self thread trackingDrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");

  self Vehicle_SetSpeed(self.followSpeed, 10, 10);
  self.previousTrackedPlayer = self.owner;
  self.trackedPlayer = undefined;
  if(isDefined(level.isHorde) && level.isHorde) {
    self.trackedPlayer = self.owner;
  }
  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait(0.5);
      continue;
    }

    if(isDefined(self.owner) && IsAlive(self.owner)) {
      maxRangeSquared = self.maxTrackingRange * self.maxTrackingRange;
      closestDistanceSquared = maxRangeSquared;

      if(!isDefined(level.isHorde)) {
        if(!isDefined(self.trackedPlayer) || self.trackedPlayer == self.owner) {
          foreach(player in level.players) {
            if(isDefined(player) && IsAlive(player) && player.team != self.team && !player _hasPerk("specialty_blindeye")) {
              currentDistanceSquared = DistanceSquared(self.origin, player.origin);
              if(currentDistanceSquared < closestDistanceSquared) {
                closestDistanceSquared = currentDistanceSquared;
                self.trackedPlayer = player;

                self thread watchPlayerDeathDisconnect(player);
              }
            }
          }
        }
      }

      if(!isDefined(self.trackedPlayer)) {
        self.trackedPlayer = self.owner;
      }

      if(isDefined(self.trackedPlayer)) {
        trackingDrone_moveToPlayer(self.trackedPlayer);
      }

      if(self.trackedPlayer != self.previousTrackedPlayer) {
        stopHighlightingPlayer(self.previousTrackedPlayer);
        self.previousTrackedPlayer = self.trackedPlayer;
      }
    }
    wait(1);
  }
}

watchPlayerDeathDisconnect(trackedPlayer) {
  self endon("death");
  self endon("leaving");
  self endon("exploding");

  trackedPlayer waittill_any("death", "disconnect", "faux_spawn", "joined_team");

  if(isDefined(trackedPlayer)) {
    if(trackedPlayer.is_being_tracked == true) {
      if(!IsAlive(trackedPlayer)) {
        trackedPlayer.died_being_tracked = true;
      }
      self thread trackingDrone_leave();
    } else {
      self.trackedPlayer = undefined;
    }
  }
}

trackingDrone_moveToPlayer(playerToMoveTo) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("trackingDrone_moveToPlayer");
  self endon("trackingDrone_moveToPlayer");

  forwardOffset = 0;
  sideOffset = 0;
  heightOffset = 0;

  if(isDefined(level.isHorde) && level.isHorde) {
    forwardOffset = -1 * HORDE_BALL_DRONE_FORWARD_OFFSET;
    sideOffset = HORDE_BALL_DRONE_SIDE_OFFSET;

    switch (playerToMoveTo getStance()) {
      case "stand":
        heightOffset = HORDE_BALL_DRONE_STAND_UP_OFFSET;
        break;
      case "crouch":
        heightOffset = HORDE_BALL_DRONE_CROUCH_UP_OFFSET;
        break;
      case "prone":
        heightOffset = HORDE_BALL_DRONE_PRONE_UP_OFFSET;
        break;
    }
  } else {
    forwardOffset = -1 * BALL_DRONE_FORWARD_OFFSET;
    sideOffset = BALL_DRONE_SIDE_OFFSET;

    switch (playerToMoveTo getStance()) {
      case "stand":
        heightOffset = BALL_DRONE_STAND_UP_OFFSET;
        break;
      case "crouch":
        heightOffset = BALL_DRONE_CROUCH_UP_OFFSET;
        break;
      case "prone":
        heightOffset = BALL_DRONE_PRONE_UP_OFFSET;
        break;
    }
  }

  targetOffset = (sideOffset, forwardOffset, heightOffset);

  if(level.trackingDroneDebugPosition) {
    targetOffset = (0, -1 * level.trackingDroneDebugPositionForward, level.trackingDroneDebugPositionHeight);
  }

  self SetDroneGoalPos(playerToMoveTo, targetOffset);
  self.inTransit = true;
  self thread trackingDrone_watchForGoal();
  self thread trackingDrone_watchTargetDisconnect();
}

trackingDrone_stopMovement() {
  self SetVehGoalPos(self.origin, 1);
  self.inTransit = false;
  self.inactive = true;
}

trackingDrone_changeOwner(newOwner) {
  incrementFauxVehicleCount();

  trackingDrone = newOwner createTrackingDrone(self.weaponName, true, self.origin, self.angles);
  if(!isDefined(trackingDrone)) {
    decrementFauxVehicleCount();

    return false;
  }

  if(!isDefined(newOwner.trackingDroneArray)) {
    newOwner.trackingDroneArray = [];
  }

  newOwner.trackingDroneArray[newOwner.trackingDroneArray.size] = trackingDrone;
  level.trackingDrones = array_removeUndefined(level.trackingDrones);
  level.trackingDrones[level.trackingDrones.size] = trackingDrone;
  newOwner thread startTrackingDrone(trackingDrone);

  if(isDefined(level.trackingDroneSettings.fxId_sparks)) {
    stopFXOnTag(level.trackingDroneSettings.fxId_sparks, self, self.fx_tag0);
  }

  self removeTrackingDrone();

  return true;
}

trackingDrone_highlightTarget() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner)) {
    self thread trackingDrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  self.laserTag = spawn("script_model", self.origin);
  self.laserTag setModel("tag_laser");

  while(true) {
    if(isDefined(self.trackedPlayer)) {
      self.laserTag.origin = self GetTagOrigin("tag_weapon");
      randomRange = 20;
      randomOffset = (randomFloat(randomRange), randomFloat(randomRange), randomFloat(randomRange)) - (10, 10, 10);

      heightOffset = BALL_DRONE_STAND_UP_OFFSET;
      switch (self.trackedPlayer getStance()) {
        case "stand":
          heightOffset = BALL_DRONE_STAND_UP_OFFSET;
          break;
        case "crouch":
          heightOffset = BALL_DRONE_CROUCH_UP_OFFSET;
          break;
        case "prone":
          heightOffset = BALL_DRONE_PRONE_UP_OFFSET;
          break;
      }

      self.laserTag.angles = VectorToAngles((self.trackedPlayer.origin + (0, 0, heightOffset - 20) + randomOffset) - self.origin);
    }

    if(isDefined(self.stunned) && self.stunned) {
      wait(0.5);
      continue;
    }

    traceEntity = undefined;
    if(isDefined(self.trackedPlayer)) {
      traceData = bulletTrace(self.origin, self.trackedPlayer.origin, true, self);
      traceEntity = traceData["entity"];
    }

    if(isDefined(self.trackedPlayer) &&
      self.trackedPlayer != self.owner &&
      isDefined(traceEntity) &&
      traceEntity == self.trackedPlayer &&
      DistanceSquared(self.origin, self.trackedPlayer.origin) < self.maxLaserRange * self.maxLaserRange) {
      if(self.trackedPlayer.is_being_tracked == false) {
        startHighlightingPlayer(self.trackedPlayer);
      }
    } else {
      if(isDefined(self.trackedPlayer) && self.trackedPlayer.is_being_tracked == true) {
        stopHighlightingPlayer(self.trackedPlayer);
      }
    }
    wait(0.05);
  }
}

startHighlightingPlayer(playerToStart) {
  self.laserTag LaserOn("tracking_drone_laser");
  playFXOnTag(level.trackingDroneSettings.fxId_laser_glow, self.laserTag, "tag_laser");

  if(isDefined(level.trackingDroneSettings.sound_lock)) {
    self playLoopSound(level.trackingDroneSettings.sound_lock);
  }

  playerToStart setPerk("specialty_radararrow", true, false);

  if(playerToStart.is_being_tracked == false) {
    playerToStart.is_being_tracked = true;
    playerToStart.TrackedByPlayer = self.owner;
  }
}

stopHighlightingPlayer(playerToStop) {
  if(isDefined(self.laserTag)) {
    self.laserTag LaserOff();
    stopFXOnTag(level.trackingDroneSettings.fxId_laser_glow, self.laserTag, "tag_laser");
  }

  if(isDefined(playerToStop)) {
    if(isDefined(level.trackingDroneSettings.sound_lock)) {
      self StopLoopSound();
    }

    if(playerToStop HasPerk("specialty_radararrow", true)) {
      playerToStop unsetPerk("specialty_radararrow", true);
    }

    playerToStop notify("player_not_tracked");
    playerToStop.is_being_tracked = false;
    playerToStop.TrackedByPlayer = undefined;
  }
}

onTrackingPlayerConnect() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    player.is_being_tracked = false;

    foreach(player in level.players) {
      if(!isDefined(player.is_being_tracked)) {
        player.is_being_tracked = false;
      }
    }
  }
}

debugDrawDronePath() {
  self endon("death");
  self endon("hit_goal");

  self notify("debugDrawDronePath");
  self endon("debugDrawDronePath");

  while(true) {
    nodePath = GetNodesOnPath(self.owner.origin, self.origin);
    if(isDefined(nodePath)) {
      for(i = 0; i < nodePath.size; i++) {
        if(isDefined(nodePath[i + 1])) {
          Line(nodePath[i].origin + Z_OFFSET, nodePath[i + 1].origin + Z_OFFSET, (1, 0, 0));
        }
      }
    }
    wait(0.05);
  }
}

trackingDrone_watchForGoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("trackingDrone_watchForGoal");
  self endon("trackingDrone_watchForGoal");

  result = self waittill_any_return("goal", "near_goal", "hit_goal");
  self.inTransit = false;
  self.inactive = false;
  self notify("hit_goal");
}

trackingDrone_watchDeath() {
  level endon("game_ended");
  self endon("gone");

  self waittill("death");

  self thread trackingDroneDestroyed();
}

trackingDrone_watchTimeout() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  timeout = level.trackingDroneTimeout;
  if(self.type == "explosive_drone") {
    timeout = level.explosiveDroneTimeout;
  }

  wait(timeout);

  self thread trackingDrone_leave();
}

trackingDrone_watchOwnerLoss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("owner_gone");

  self thread trackingDrone_leave();
}

trackingDrone_watchOwnerDeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  while(true) {
    self.owner waittill("death");

    self thread trackingDrone_leave();
  }
}

trackingDrone_watchTargetDisconnect() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("trackingDrone_watchTargetDisconnect");
  self endon("trackingDrone_watchTargetDisconnect");

  self.trackedPlayer waittill("disconnect");

  stopHighlightingPlayer(self.trackedPlayer);
  trackingDrone_moveToPlayer(self.owner);
}

trackingDrone_watchRoundEnd() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");

  level waittill_any("round_end_finished", "game_ended");

  self thread trackingDrone_leave();
}

trackingDrone_watchHostMigration() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  level waittill("host_migration_begin");

  stopHighlightingPlayer(self.trackedPlayer);

  trackingDrone_stopMovement();

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  self thread trackingDrone_changeOwner(self.owner);
}

trackingDrone_leave() {
  self endon("death");
  self notify("leaving");

  stopHighlightingPlayer(self.trackedPlayer);

  trackingDroneExplode();
}

onTrackingDroneDeath(attacker, weapon, meansOfDeath, damage) {
  self notify("death");
}

trackingDrone_watchDisable() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self thread trackingDrone_stunned();
  }
}

trackingDrone_stunned() {
  self notify("trackingDrone_stunned");
  self endon("trackingDrone_stunned");

  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  trackingDrone_stunBegin();

  wait(STUNNED_TIME);

  trackingDrone_stunEnd();
}

trackingDrone_stunBegin() {
  if(self.stunned) {
    return;
  }

  self.stunned = true;

  if(isDefined(level.trackingDroneSettings.fxId_sparks)) {
    playFXOnTag(level.trackingDroneSettings.fxId_sparks, self, self.fx_tag0);
  }

  thread stopHighlightingPlayer(self.trackedPlayer);

  self.trackedPlayer = undefined;
  self.previousTrackedPlayer = self.owner;

  self thread trackingDrone_stopMovement();
}

trackingDrone_stunEnd() {
  if(isDefined(level.trackingDroneSettings.fxId_sparks)) {
    KillFXOnTag(level.trackingDroneSettings.fxId_sparks, self, self.fx_tag0);
  }

  self.stunned = false;
  self.inactive = false;
}

trackingDroneDestroyed() {
  if(!isDefined(self)) {
    return;
  }

  stopHighlightingPlayer(self.trackedPlayer);

  trackingDrone_stunEnd();

  trackingDroneExplode();
}

trackingDroneExplode() {
  if(isDefined(level.trackingDroneSettings.fxId_explode)) {
    playFX(level.trackingDroneSettings.fxId_explode, self.origin);
  }

  if(isDefined(level.trackingDroneSettings.sound_explode)) {
    self playSound(level.trackingDroneSettings.sound_explode);
  }

  self notify("explode");

  self removeTrackingDrone();
}

deleteTrackingDrone() {
  if(!IsRemovedEntity(self) && isDefined(self)) {
    if(isDefined(self.attractor)) {
      Missile_DeleteAttractor(self.attractor);
    }
    self delete();
  }
}

removeTrackingDrone() {
  decrementFauxVehicleCount();

  if(isDefined(self.owner) && isDefined(self.owner.trackingDrone)) {
    self.owner.trackingDrone = undefined;
  }

  if(isDefined(self.laserTag)) {
    self.laserTag Delete();
  }

  self deleteTrackingDrone();
}

addToTrackingDroneList() {
  level.trackingDrones[self GetEntityNumber()] = self;
}

removeFromTrackingDroneListOnDeath() {
  entNum = self GetEntityNumber();

  self waittill("death");

  level.trackingDrones[entNum] = undefined;

  level.trackingDrones = array_removeUndefined(level.trackingDrones);
}

exceededMaxTrackingDrones() {
  if(level.trackingDrones.size >= maxVehiclesAllowed()) {
    return true;
  } else {
    return false;
  }
}

aud_drone_start_jets() {
  self playLoopSound("veh_tracking_drone_jets_lp");
}

destroy_tracking_drone_in_water() {
  self endon("death");

  if(!isDefined(level.water_triggers)) {
    return;
  }

  while(true) {
    foreach(trig in level.water_triggers) {
      if(self IsTouching(trig)) {
        if(isDefined(level.trackingDroneSettings.fxId_explode)) {
          playFX(level.trackingDroneSettings.fxId_explode, self.origin);
        }
        if(isDefined(level.trackingDroneSettings.sound_explode)) {
          self playSound(level.trackingDroneSettings.sound_explode);
        }

        self deleteTrackingDrone();
      }
    }
    wait(0.05);
  }
}

prevent_tracking_drone_in_water(pos) {
  if(!isDefined(level.water_triggers)) {
    return false;
  }

  foreach(trig in level.water_triggers) {
    if(IsPointInVolume(pos, trig)) {
      return true;
    }
  }
  return false;
}