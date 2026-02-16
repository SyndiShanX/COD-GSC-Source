/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_explosive_drone.gsc
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
BALL_DRONE_FORWARD_OFFSET = 0;
BALL_DRONE_SIDE_OFFSET = 0;

CONST_ACTIVATION_TIME = 3;
CONST_Mine_TriggerRadius = 192;
CONST_Mine_TriggerHeight = 192;

CONST_TRACKING_TIME = 3000;
CONST_EXPLODE_PAUSE = 0.5;
CONST_REMOTE_DETONATE_HOLD_TIME = 1;

message_alpha = 1;
message_fade_time = 0.1;
explosive_drone_pickup_string = &"MP_PICKUP_EXPLOSIVE_DRONE";

watchExplosiveDroneUsage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level.explosiveDroneSettings)) {
    explosiveDroneInit();
  }

  while(true) {
    self waittill("grenade_fire", grenade, weapname);

    shortWeaponName = maps\mp\_utility::strip_suffix(weapname, "_lefthand");

    if(shortWeaponName == "explosive_drone_mp") {
      grenade.team = self.team;
      if(!isDefined(grenade.owner)) {
        grenade.owner = self;
      }

      if(!isDefined(grenade.weaponname)) {
        grenade.weaponname = weapname;
      }
      grenade thread explosiveDroneLink();
    }
  }
}

explosiveDroneLink() {
  self thread watchForStick();

  wait(0.1);

  if(isDefined(self)) {
    self.explosiveDrone = spawn("script_model", self.origin);
    self.explosiveDrone.targetname = "explosive_drone_head_model";
    self.explosiveDrone setModel(level.explosiveDroneSettings.modelBase);
    self.explosiveDrone.oldContents = self.explosiveDrone SetContents(0);
    self.explosiveDrone LinkTo(self, "tag_spike", (0, 0, 0), (0, 0, 0));
    self.explosiveDrone.owner = self.owner;

    explosive_drone_model = self.explosiveDrone;

    explosive_drone_model thread cleanup_on_grenade_death(self);

    self thread monitorSpikeDestroy();

    self thread monitorHeadDestroy();
  }
}

cleanup_on_grenade_death(grenade) {
  grenade waittill("death");

  if(isDefined(self)) {
    self Delete();
  }
}

explosiveGrenadeDeath(attacker, weapon, meansOfDeath, damage) {
  if(isDefined(self)) {
    self notify("death");

    if(isDefined(self.explosiveDrone)) {
      self.explosiveDrone deleteExplosiveDrone();
    }

    self delete();
  }
}

explosiveHeadDeath(attacker, weapon, meansOfDeath, damage) {
  if(isDefined(self)) {
    self delete();
  }
}

explosiveDroneInit() {
  level.explosiveDroneMaxPerPlayer = 1;

  level.explosiveDroneSettings = spawnStruct();
  level.explosiveDroneSettings.timeOut = 20.0;
  level.explosiveDroneSettings.ExplosiveTimeOut = 30.0;
  level.explosiveDroneSettings.health = 60;
  level.explosiveDroneSettings.maxHealth = 60;
  level.explosiveDroneSettings.vehicleInfo = "vehicle_tracking_drone_mp";
  level.explosiveDroneSettings.modelBase = "npc_drone_explosive_main";
  level.explosiveDroneSettings.fxId_sparks = Loadfx("vfx/sparks/direct_hack_stun");
  level.explosiveDroneSettings.fxId_laser_glow = LoadFx("vfx/lights/tracking_drone_laser_blue");
  level.explosiveDroneSettings.fxId_explode = LoadFX("vfx/explosion/explosive_drone_explosion");
  level.explosiveDroneSettings.fxId_LethalExplode = LoadFX("vfx/explosion/explosive_drone_explosion");

  level.explosiveDroneSettings.fxId_enemy_light = LoadFX("vfx/lights/light_explosive_drone_beacon_enemy");
  level.explosiveDroneSettings.fxId_friendly_light = LoadFX("vfx/lights/light_explosive_drone_beacon_friendly");

  level.explosiveDroneSettings.fxId_engine_distort = LoadFX("vfx/distortion/tracking_drone_distortion_hemi");
  level.explosiveDroneSettings.fxId_launch_thruster = LoadFX("vfx/trail/explosive_drone_thruster_large");
  level.explosiveDroneSettings.fxId_position_thruster = LoadFX("vfx/trail/explosive_drone_thruster_small");
  level.explosiveDroneSettings.sound_explode = "wpn_explosive_drone_exp";
  level.explosiveDroneSettings.sound_lock = "wpn_explosive_drone_lock";
  level.explosiveDroneSettings.sound_launch = "wpn_explosive_drone_open";

  foreach(player in level.players) {
    player.is_being_tracked = false;
  }

  level thread onExplosivePlayerConnect();

  level.explosiveDroneTimeout = level.explosiveDroneSettings.timeOut;
  level.explosiveDroneTimeout = level.explosiveDroneSettings.ExplosiveTimeOut;
  level.explosiveDroneDebugPosition = 0;
  level.explosiveDroneDebugPositionForward = BALL_DRONE_FORWARD_OFFSET;
  level.explosiveDroneDebugPositionHeight = BALL_DRONE_SIDE_OFFSET;
}

tryUseExplosiveDrone(grenade) {
  numIncomingVehicles = 1;
  if(self isUsingRemote()) {
    return false;
  } else if(exceededMaxExplosiveDrones()) {
    self IPrintLnBold(&"MP_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"MP_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  if(!isDefined(self.explosiveDroneArray)) {
    self.explosiveDroneArray = [];
  }

  if(self.explosiveDroneArray.size) {
    self.explosiveDroneArray = array_removeUndefined(self.explosiveDroneArray);

    if(self.explosiveDroneArray.size >= level.explosiveDroneMaxPerPlayer) {
      if(isDefined(self.explosiveDroneArray[0])) {
        self.explosiveDroneArray[0] thread explosiveDrone_leave();
      }
    }
  }

  incrementFauxVehicleCount();

  explosiveDrone = grenade createExplosiveDrone();

  if(!isDefined(explosiveDrone)) {
    decrementFauxVehicleCount();

    return false;
  }

  self playSound(level.explosiveDroneSettings.sound_launch);

  self playSound(level.explosiveDroneSettings.sound_lock);

  self.explosiveDroneArray[self.explosiveDroneArray.size] = explosiveDrone;
  self thread startExplosiveDrone(explosiveDrone);

  playFXOnTag(level.explosiveDroneSettings.fxId_launch_thruster, explosiveDrone, "TAG_THRUSTER_BTM");

  grenade notify("mine_selfdestruct");

  return explosiveDrone;
}

createExplosiveDrone(bRecreate, startPosition, startAngles, DroneType) {
  if(!isDefined(bRecreate)) {
    bRecreate = false;
  }

  if(!bRecreate) {
    startAng = self.angles;
    forward = anglesToForward(startAng);
    side = AnglesToRight(startAng);

    forwardOffset = forward * BALL_DRONE_SPAWN_FORWARD_OFFSET;

    sideOffset = side * BALL_DRONE_SPAWN_SIDE_OFFSET;

    heightOffset = BALL_DRONE_SPAWN_STAND_UP_OFFSET;

    if(level.explosiveDroneDebugPosition) {
      targetOffset = (0, 0, level.explosiveDroneDebugSpawnPositionHeight);
      targetOffset += forward * level.explosiveDroneDebugSpawnPositionForward;
    }

    if(isDefined(self.explosiveDrone)) {
      startPos = self.explosiveDrone.origin;
      startAng = self.explosiveDrone.angles;

      self.explosiveDrone deleteExplosiveDrone();
      self addToDeleteSpike();
    } else {
      startPos = self.origin;
    }
  } else {
    startPos = startPosition;
    targetPos = startPosition;
    startAng = startAngles;
  }

  dir = AnglesToUp(self.angles);

  startPos += (dir * 10);

  drone = SpawnHelicopter(self.owner, startPos, startAng, level.explosiveDroneSettings.vehicleInfo, level.explosiveDroneSettings.modelBase);
  if(!isDefined(drone)) {
    return;
  }

  drone.type = "explosive_drone";

  drone make_entity_sentient_mp(self.owner.team);
  drone MakeVehicleNotCollideWithPlayers(true);

  drone addToExplosiveDroneList();
  drone thread removeFromExplosiveDroneListOnDeath();

  drone.health = level.explosiveDroneSettings.health;
  drone.maxHealth = level.explosiveDroneSettings.maxHealth;
  drone.damageTaken = 0;

  drone.speed = 20;
  drone.followSpeed = 20;
  drone.owner = self.owner;
  drone.team = self.owner.team;

  drone Vehicle_SetSpeed(drone.speed, 10, 10);
  drone SetYawSpeed(120, 90);
  drone SetNearGoalNotifyDist(64);
  drone SetHoverParams(20, 5, 5);

  drone.fx_tag0 = undefined;
  if(isDefined(drone.type)) {
    if(drone.type == "explosive_drone") {}
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

  drone thread maps\mp\gametypes\_damage::setEntityDamageCallback(drone.maxHealth, undefined, ::onExplosiveDroneDeath, undefined, false);
  drone thread explosiveDrone_watchDisable();
  drone thread explosiveDrone_watchDeath();
  drone thread explosiveDrone_watchTimeout();
  drone thread explosiveDrone_watchOwnerLoss();
  drone thread explosiveDrone_watchOwnerDeath();
  drone thread explosiveDrone_watchRoundEnd();
  drone thread explosiveDrone_watchHostMigration();

  drone thread ExplosiveDrone_enemy_lightFX();
  drone thread ExplosiveDrone_friendly_lightFX();
  drone thread drone_thrusterFXExplosive();

  return drone;
}

addToDeleteSpike() {
  MAX_SPIKE_LIST = 5;
  if(!isDefined(level.spikeList)) {
    level.spikeList = [];
    level.spikeListIndex = 0;
  }

  if(level.spikeList.size >= MAX_SPIKE_LIST) {
    if(isDefined(level.spikeList[level.spikeListIndex])) {
      level.spikeList[level.spikeListIndex] Delete();
    }
  }

  level.spikeList[level.spikeListIndex] = self;
  level.spikeListIndex = (level.spikeListIndex + 1) % MAX_SPIKE_LIST;
}

idleTargetMoverExplosive(ent) {
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

explosiveDrone_enemy_lightFX() {
  self endon("death");
  self.owner endon("faux_spawn");

  foreach(player in level.players) {
    if(isDefined(player) && IsSentient(player) && IsSentient(self) && player.team != self.team) {
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
    }
  }
}

explosiveDrone_friendly_lightFX() {
  self endon("death");
  self.owner endon("faux_spawn");

  foreach(player in level.players) {
    if(isDefined(player) && IsSentient(player) && IsSentient(self) && player.team == self.team) {
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
    }
  }

  self thread watchConnectedPlayFXExplosive();
  self thread watchJoinedTeamPlayFXExplosive();
}

drone_thrusterFXExplosive() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("faux_spawn");

  while(true) {
    foreach(player in level.players) {
      self thread drone_thrusterFX_bottom_threaded(player);
      self thread drone_thrusterFX_side_threaded(player);
    }

    wait(1.1);
  }
}

drone_thrusterFX_side_threaded(player) {
  self endon("death");
  self endon("disconnect");
  self.owner endon("faux_spawn");

  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_X_nY_Z", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_X_nY_nZ", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_nX_nY_Z", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_nX_nY_nZ", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_nX_Y_nZ", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_nX_Y_Z", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_X_Y_Z", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUST_SIDE_X_Y_nZ", player);
  }
}

drone_thrusterFX_bottom_threaded(player) {
  self endon("death");
  self endon("disconnect");
  self.owner endon("faux_spawn");
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_engine_distort)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_engine_distort, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.10);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_engine_distort)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_engine_distort, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.10);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_engine_distort)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_engine_distort, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.10);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_engine_distort)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_engine_distort, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.10);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_engine_distort)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_engine_distort, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.10);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_position_thruster)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_position_thruster, self, "TAG_THRUSTER_BTM", player);
  }
  wait(0.1);
  if(isDefined(player) && isDefined(self) && isDefined(level.explosiveDroneSettings.fxId_engine_distort)) {
    PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_engine_distort, self, "TAG_THRUSTER_BTM", player);
  }
}

watchConnectedPlayFXExplosive() {
  self endon("death");
  self.owner endon("faux_spawn");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(isDefined(player) && player.team == self.team) {
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
    }
  }
}

watchJoinedTeamPlayFXExplosive() {
  self endon("death");
  self.owner endon("faux_spawn");

  while(true) {
    level waittill("joined_team", player);
    player waittill("spawned_player");

    if(isDefined(player) && player.team == self.team) {
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_friendly_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
      wait 0.15;
      PlayFXOnTagForClients(level.explosiveDroneSettings.fxId_enemy_light, self, "TAG_BEACON", player);
    }
  }
}

startExplosiveDrone(drone) {
  level endon("game_ended");
  drone endon("death");

  drone thread explosiveDrone_followTarget();

  drone thread createKillCamEntity();

  if(isDefined(drone.type)) {
    if(drone.type == "explosive_drone") {
      drone thread CheckForExplosiveGoalExplosive();
    }
  }
}
CheckForExplosiveGoalExplosive() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");

  starttime = gettime();

  self thread blowUpAtEndofTrackingTime(starttime);
}

blowUpAtEndofTrackingTime(starttime) {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");

  while((gettime() - starttime) < CONST_TRACKING_TIME) {
    waitframe();
  }
  if(isDefined(self)) {
    self notify("exploding");
    self thread BlowUpDroneSequenceExplosive();
  }
}

BlowUpDroneSequenceExplosive() {
  StoredOwner = undefined;
  if(isDefined(self)) {
    if(isDefined(self.owner)) {
      StoredOwner = self.owner;
    }

    self playSound(level.explosiveDroneSettings.sound_lock);

    wait(CONST_EXPLODE_PAUSE);
  }

  if(isDefined(self)) {
    self playSound("wpn_explosive_drone_exp");
    up_v = AnglesToUp(self.angles);
    forward_v = anglesToForward(self.angles);

    playFX(level.explosiveDroneSettings.fxId_LethalExplode, self.origin, forward_v, up_v);
    if(isDefined(StoredOwner)) {
      self RadiusDamage(self.origin, 256, 130, 55, StoredOwner, "MOD_EXPLOSIVE", "explosive_drone_mp");
    } else {
      self RadiusDamage(self.origin, 256, 130, 55, undefined, "MOD_EXPLOSIVE", "explosive_drone_mp");
    }

    self notify("death");
  }
}
TurnOnDangerLightsExplosive() {
  if(isDefined(self)) {}
  wait(0.05);
  if(isDefined(self)) {}
  wait(0.15);
  if(isDefined(self)) {}
}
explosiveDrone_followTarget() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self endon("exploding");

  if(!isDefined(self.owner)) {
    self thread explosiveDrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");

  self Vehicle_SetSpeed(self.followSpeed, 10, 10);
  self.previousTrackedPlayer = self.owner;
  self.trackedPlayer = undefined;
  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait(0.5);
      continue;
    }

    if(isDefined(self.owner) && IsAlive(self.owner)) {
      maxRangeSquared = self.maxTrackingRange * self.maxTrackingRange;
      closestDistanceSquared = maxRangeSquared;

      if(!isDefined(self.trackedPlayer) || self.trackedPlayer == self.owner) {
        foreach(player in level.players) {
          if(isDefined(player) && IsAlive(player) && player != self.owner && (!level.teamBased || player.team != self.team) && !player _hasPerk("specialty_blindeye")) {
            currentDistanceSquared = DistanceSquared(self.origin, player.origin);
            if(currentDistanceSquared < closestDistanceSquared) {
              closestDistanceSquared = currentDistanceSquared;
              self.trackedPlayer = player;

              self thread watchPlayerDeathDisconnectExplosive(player);
            }
          }
        }
      }

      if(!isDefined(self.trackedPlayer)) {
        self thread explosiveDroneExplode();
      }

      if(isDefined(self.trackedPlayer)) {
        explosiveDrone_moveToPlayer(self.trackedPlayer);
      }

      if(self.trackedPlayer != self.previousTrackedPlayer) {
        stopHighlightingPlayerExplosive(self.previousTrackedPlayer);
        self.previousTrackedPlayer = self.trackedPlayer;
      }
    }
    wait(1);
  }
}

watchPlayerDeathDisconnectExplosive(trackedPlayer) {
  trackedPlayer waittill_any("death", "disconnect", "faux_spawn", "joined_team");

  if(trackedPlayer.is_being_tracked == true) {
    self thread explosiveDrone_leave();
  } else {
    self.trackedPlayer = undefined;
  }
}

explosiveDrone_moveToPlayer(playerToMoveTo) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("explosiveDrone_moveToPlayer");
  self endon("explosiveDrone_moveToPlayer");

  forwardOffset = -1 * BALL_DRONE_FORWARD_OFFSET;

  sideOffset = BALL_DRONE_SIDE_OFFSET;

  heightOffset = BALL_DRONE_STAND_UP_OFFSET;
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

  targetOffset = (sideOffset, forwardOffset, heightOffset);

  if(level.explosiveDroneDebugPosition) {
    targetOffset = (0, -1 * level.explosiveDroneDebugPositionForward, level.explosiveDroneDebugPositionHeight);
  }

  self SetDroneGoalPos(playerToMoveTo, targetOffset);
  self.inTransit = true;
  self thread explosiveDrone_watchForGoal();
  self thread explosiveDrone_watchTargetDisconnect();
}

explosiveDrone_stopMovement() {
  self SetVehGoalPos(self.origin, 1);
  self.inTransit = false;
  self.inactive = true;
}

explosiveDrone_changeOwner(newOwner) {
  incrementFauxVehicleCount();

  explosiveDrone = newOwner createExplosiveDrone(true, self.origin, self.angles);
  if(!isDefined(explosiveDrone)) {
    decrementFauxVehicleCount();

    return false;
  }

  if(!isDefined(newOwner.explosiveDroneArray)) {
    newOwner.explosiveDroneArray = [];
  }

  newOwner.explosiveDroneArray[newOwner.explosiveDroneArray.size] = explosiveDrone;
  newOwner thread startExplosiveDrone(explosiveDrone);

  if(isDefined(level.explosiveDroneSettings.fxId_sparks)) {}

  self removeExplosiveDrone();

  return true;
}

explosiveDrone_highlightTarget() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner)) {
    self thread explosiveDrone_leave();
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
        startHighlightingPlayerExplosive(self.trackedPlayer);
      }
    } else {
      if(isDefined(self.trackedPlayer) && self.trackedPlayer.is_being_tracked == true) {
        stopHighlightingPlayerExplosive(self.trackedPlayer);
      }
    }
    wait(0.05);
  }
}

startHighlightingPlayerExplosive(playerToStart) {
  self.laserTag LaserOn("explosive_drone_laser");
  playFXOnTag(level.explosiveDroneSettings.fxId_laser_glow, self.laserTag, "tag_laser");

  if(isDefined(level.explosiveDroneSettings.sound_lock)) {
    self playSound(level.explosiveDroneSettings.sound_lock);
  }

  playerToStart setPerk("specialty_radararrow", true, false);

  if(playerToStart.is_being_tracked == false) {
    playerToStart.is_being_tracked = true;
    playerToStart.TrackedByPlayer = self.owner;
  }
}

stopHighlightingPlayerExplosive(playerToStop) {
  if(isDefined(self.laserTag)) {
    self.laserTag LaserOff();
    stopFXOnTag(level.explosiveDroneSettings.fxId_laser_glow, self.laserTag, "tag_laser");
  }

  if(isDefined(playerToStop)) {
    if(isDefined(level.explosiveDroneSettings.sound_lock)) {
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

onExplosivePlayerConnect() {
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

explosiveDrone_watchForGoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("explosiveDrone_watchForGoal");
  self endon("explosiveDrone_watchForGoal");

  result = self waittill_any_return("goal", "near_goal", "hit_goal");
  self.inTransit = false;
  self.inactive = false;
  self notify("hit_goal");
}

explosiveDrone_watchDeath() {
  level endon("game_ended");
  self endon("gone");

  self waittill("death");

  self thread explosiveDroneDestroyed();
}

explosiveDrone_watchTimeout() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  timeout = level.explosiveDroneTimeout;
  if(self.type == "explosive_drone") {
    timeout = level.explosiveDroneTimeout;
  }

  wait(timeout);

  self thread explosiveDrone_leave();
}

explosiveDrone_watchOwnerLoss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("owner_gone");

  self thread explosiveDrone_leave();
}

explosiveDrone_watchOwnerDeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  while(true) {
    self.owner waittill("death");

    self thread explosiveDrone_leave();
  }
}

explosiveDrone_watchTargetDisconnect() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("explosiveDrone_watchTargetDisconnect");
  self endon("explosiveDrone_watchTargetDisconnect");

  self.trackedPlayer waittill("disconnect");

  stopHighlightingPlayerExplosive(self.trackedPlayer);
  explosiveDrone_moveToPlayer(self.owner);
}

explosiveDrone_watchRoundEnd() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");

  level waittill_any("round_end_finished", "game_ended");

  self thread explosiveDrone_leave();
}

explosiveDrone_watchHostMigration() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  level waittill("host_migration_begin");

  stopHighlightingPlayerExplosive(self.trackedPlayer);

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  self thread explosiveDrone_changeOwner(self.owner);
}

explosiveDrone_leave() {
  self endon("death");
  self notify("leaving");

  stopHighlightingPlayerExplosive(self.trackedPlayer);

  explosiveDroneExplode();
}

onExplosiveDroneDeath(attacker, weapon, meansOfDeath, damage) {
  self notify("death");
}

explosiveDrone_grenade_watchDisable() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  self.stunned = false;

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self thread explosiveDrone_grenade_stunned();
  }
}

explosiveDrone_watchDisable() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self thread explosiveDrone_stunned();
  }
}

explosiveDrone_grenade_stunned() {
  self notify("explosiveDrone_stunned");
  self endon("explosiveDrone_stunned");

  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  explosiveDrone_grenade_stunBegin();

  wait(STUNNED_TIME);

  explosiveDrone_grenade_stunEnd();
}

explosiveDrone_stunned() {
  self notify("explosiveDrone_stunned");
  self endon("explosiveDrone_stunned");

  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  explosiveDrone_stunBegin();

  wait(STUNNED_TIME);

  explosiveDrone_stunEnd();
}

explosiveDrone_grenade_stunBegin() {
  if(self.stunned) {
    return;
  }

  self.stunned = true;

  if(isDefined(level.explosiveDroneSettings.fxId_sparks)) {
    playFXOnTag(level.explosiveDroneSettings.fxId_sparks, self, "TAG_BEACON");
  }
}

explosiveDrone_stunBegin() {
  if(self.stunned) {
    return;
  }

  self.stunned = true;

  if(isDefined(level.explosiveDroneSettings.fxId_sparks)) {
    playFXOnTag(level.explosiveDroneSettings.fxId_sparks, self, "TAG_BEACON");
  }

  thread stopHighlightingPlayerExplosive(self.trackedPlayer);

  self.trackedPlayer = undefined;
  self.previousTrackedPlayer = self.owner;

  self thread explosiveDrone_stopMovement();
}

explosiveDrone_grenade_stunEnd() {
  if(isDefined(level.explosiveDroneSettings.fxId_sparks)) {
    KillFXOnTag(level.explosiveDroneSettings.fxId_sparks, self, "TAG_BEACON");
  }

  self.stunned = false;
  self.inactive = false;
}

explosiveDrone_stunEnd() {
  if(isDefined(level.explosiveDroneSettings.fxId_sparks)) {
    KillFXOnTag(level.explosiveDroneSettings.fxId_sparks, self, "TAG_BEACON");
  }

  self.stunned = false;
  self.inactive = false;
}

explosiveDroneDestroyed() {
  if(!isDefined(self)) {
    return;
  }

  stopHighlightingPlayerExplosive(self.trackedPlayer);

  explosiveDrone_stunEnd();

  explosiveDroneExplode();
}

explosiveDroneExplode() {
  if(isDefined(level.explosiveDroneSettings.fxId_explode)) {
    playFX(level.explosiveDroneSettings.fxId_explode, self.origin);
  }

  if(isDefined(level.explosiveDroneSettings.sound_explode)) {
    self playSound(level.explosiveDroneSettings.sound_explode);
  }

  self notify("exploding");

  self removeExplosiveDrone();
}

deleteExplosiveDrone() {
  if(isDefined(self.attractor)) {
    Missile_DeleteAttractor(self.attractor);
  }

  self removeKillCamEntity();

  self delete();
}

removeExplosiveDrone() {
  decrementFauxVehicleCount();

  if(isDefined(self.owner) && isDefined(self.owner.explosiveDrone)) {
    self.owner.explosiveDrone = undefined;
  }

  self deleteExplosiveDrone();
}

addToExplosiveDroneList() {
  level.explosiveDrones[self GetEntityNumber()] = self;
}

removeFromExplosiveDroneListOnDeath() {
  entNum = self GetEntityNumber();

  self waittill("death");

  level.explosiveDrones[entNum] = undefined;

  level.explosiveDrones = array_removeUndefined(level.explosiveDrones);
}

exceededMaxExplosiveDrones() {
  if(isDefined(level.explosiveDrones) && level.explosiveDrones.size >= maxVehiclesAllowed()) {
    return true;
  } else {
    return false;
  }
}

ExplosiveDroneProximityTrigger() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");

  wait(CONST_ACTIVATION_TIME);

  if(isDefined(self) && isDefined(self.explosiveDrone)) {
    teamIconoffset = self.explosiveDrone GetTagOrigin("TAG_BEACON") - self GetTagOrigin("TAG_BEACON") + (0, 0, 10);
    if(level.teamBased) {
      self maps\mp\_entityheadicons::setTeamHeadIcon(self.owner.team, teamIconoffset, "TAG_BEACON");
    } else {
      self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, teamIconoffset, "TAG_BEACON");
    }

    trigger = spawn("trigger_radius", (self.origin + (0, 0, ((CONST_Mine_TriggerHeight / 2) * -1))), 0, CONST_Mine_TriggerRadius, CONST_Mine_TriggerHeight);
    trigger.owner = self;

    self thread ExplosiveDroneDeleteTrigger(trigger);
    self thread watchForPickup(trigger);

    player = undefined;
    while(isDefined(self) && isDefined(self.explosiveDrone)) {
      trigger waittill("trigger", player);

      if(!isDefined(player)) {
        wait(0.1);
        continue;
      }

      if(player _hasPerk("specialty_blindeye")) {
        wait(0.1);
        continue;
      }

      if(isDefined(self.explosiveDrone) && !player SightConeTrace(self.explosiveDrone GetTagOrigin("TAG_BEACON"), self.explosiveDrone)) {
        wait(0.1);
        continue;
      }

      if(isDefined(self.explosiveDrone)) {
        start = self.explosiveDrone GetTagOrigin("TAG_BEACON");
        end = player getEye();
        if(!BulletTracePassed(start, end, false, self.explosiveDrone)) {
          wait(0.1);
          continue;
        }
      }

      if(isReallyAlive(player) && player != self.owner && (!level.teamBased || player.team != self.owner.team) && !self.stunned) {
        player tryUseExplosiveDrone(self);
      }
    }
  }
}

ExplosiveDroneDeleteTrigger(trigger) {
  self waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(self.entityHeadIcon)) {
    self notify("kill_entity_headicon_thread");
    self.entityHeadIcon destroy();
  }

  trigger delete();
}

showDebugRadius(owner) {
  effect = SpawnFx(level.explosiveDroneSettings.dome, owner.origin);
  TriggerFx(effect);

  self waittill("death");

  effect delete();
}

endOnPlayerspawn() {
  self.owner waittill_any("spawned_player", "faux_spawn", "delete_explosive_drones");

  self explosiveGrenadeDeath();
}

monitorSpikeDestroy() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");

  self waittill_any("mine_selfdestruct");

  self explosiveGrenadeDeath();
}

monitorHeadDestroy() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");

  while(isDefined(self.explosiveDrone)) {
    wait(0.15);
  }

  if(isDefined(self)) {
    self playSound("wpn_explosive_drone_exp");
    up_v = AnglesToUp(self.angles);
    forward_v = anglesToForward(self.angles);

    playFX(level.explosiveDroneSettings.fxId_LethalExplode, self.origin, forward_v, up_v);
    self RadiusDamage(self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp");

    self notify("death");
  }

  self explosiveGrenadeDeath();
}

startGrenadeLightFX() {
  self endon("death");
  self.owner endon("death");
  self.owner endon("disconnect");

  ExplosiveDroneFXLoopWaitTime = 4 * 0.15;

  while(isDefined(self.explosiveDrone)) {
    foreach(player in level.players) {
      if(isDefined(player) && IsSentient(player) && player.team == self.team && isDefined(self.explosiveDrone)) {
        self thread FXblink(level.explosiveDroneSettings.fxId_friendly_light, self.explosiveDrone, "TAG_BEACON", player);
      }

      if(isDefined(player) && IsSentient(player) && player.team != self.team && isDefined(self.explosiveDrone)) {
        self thread FXblink(level.explosiveDroneSettings.fxId_enemy_light, self.explosiveDrone, "TAG_BEACON", player);
      }
    }
    wait ExplosiveDroneFXLoopWaitTime;
  }
}

FXblink(blink_fx, explosiveDrone, tag, player_to_show) {
  for(i = 0; i <= 4 && isDefined(explosiveDrone); i++) {
    if(isDefined(player_to_show) && isDefined(explosiveDrone) && isDefined(self.stunned) && !self.stunned) {
      PlayFXOnTagForClients(blink_fx, explosiveDrone, tag, player_to_show);
      wait 0.15;
    }
  }
}

watchForStick() {
  self endon("death");
  self.owner endon("death");
  self.owner endon("disconnect");

  stickReturnParms = undefined;

  stickReturnParms = self waittill_any_return_parms("missile_stuck", "mp_exo_repulsor_repel");

  while(!isDefined(self.explosiveDrone)) {
    waitframe();
  }

  if(isDefined(stickReturnParms[1])) {
    if(stickReturnParms[1].classname == "script_model") {
      self playSound("wpn_explosive_drone_exp");
      up_v = AnglesToUp(self.angles);
      forward_v = anglesToForward(self.angles);

      playFX(level.explosiveDroneSettings.fxId_LethalExplode, self.origin, forward_v, up_v);

      self RadiusDamage(self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp");

      self thread maps\mp\_explosive_drone::explosiveGrenadeDeath();
    }
  }

  if(isDefined(self)) {
    self.explosiveDrone SetContents(self.explosiveDrone.oldContents);

    self thread ExplosiveDroneProximityTrigger();
    self thread endOnPlayerspawn();
    self thread explosiveDrone_grenade_watchDisable();
    self thread startGrenadeLightFX();

    self thread maps\mp\gametypes\_damage::setEntityDamageCallback(100, undefined, ::explosiveGrenadeDeath, undefined, false);

    self.explosiveDrone thread maps\mp\gametypes\_damage::setEntityDamageCallback(100, undefined, ::explosiveHeadDeath, undefined, false);

    self thread maps\mp\gametypes\_weapons::stickyHandleMovers("mine_selfdestruct");
  }
}

createKillCamEntity() {
  killCamOffset = (0, 0, 0);

  self.killCamEnt = spawn("script_model", self.origin);
  self.killCamEnt SetScriptMoverKillCam("explosive");
  self.killCamEnt LinkTo(self, "TAG_THRUSTER_BTM", killCamOffset, (0, 0, 0));
  self.killCamEnt SetContents(0);
  self.killCamEnt.startTime = getTime();
}

removeKillCamEntity() {
  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }
}

watchForPickup(trigger) {
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");
  level endon("game_ended");
  self endon("death");
  self.owner endon("death");

  self.explosiveDrone MakeUsable();
  self.explosiveDrone SetHintString(explosive_drone_pickup_string);
  self.explosiveDrone SetHintStringVisibleOnlyToOwner(true);

  pickupRadiusSq = GetDvarFloat("player_useRadius", 128);
  pickupRadiusSq = pickupRadiusSq * pickupRadiusSq;

  while(true) {
    if(!isDefined(self) || !isDefined(trigger)) {
      break;
    }

    inRange = isDefined(self.explosiveDrone) && DistanceSquared(self.owner getEye(), self.explosiveDrone.origin) <= pickupRadiusSq;

    if(self.owner IsTouching(trigger) && inRange) {
      timeUsed = 0;

      while(self.owner useButtonPressed()) {
        if(!isReallyAlive(self.owner)) {
          break;
        }

        if(!self.owner IsTouching(trigger)) {
          break;
        }

        if(self.owner fragButtonPressed() || self.owner SecondaryOffhandbuttonPressed() || isDefined(self.owner.throwingGrenade)) {
          break;
        }

        if(self.owner IsUsingTurret() || self.owner isUsingRemote()) {
          break;
        }

        if(isDefined(self.owner.isCapturingCrate) && self.owner.isCapturingCrate) {
          break;
        }

        if(isDefined(self.owner.empGrenaded) && self.owner.empGrenaded) {
          break;
        }

        if(isDefined(self.owner.using_remote_turret) && self.owner.using_remote_turret) {
          break;
        }

        timeUsed += 0.05;
        if(timeUsed > 0.75) {
          self.owner SetWeaponAmmoStock(self.weaponname, self.owner GetWeaponAmmoStock(self.weaponname) + 1);

          self.explosiveDrone deleteExplosiveDrone();

          self delete();

          break;
        }
        waitframe();
      }
    }
    waitframe();
  }
}