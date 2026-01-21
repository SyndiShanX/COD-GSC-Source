/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_ball_drone.gsc
***********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;

STUNNED_TIME = 7.0;
Z_OFFSET = (0, 0, 90);

BALL_DRONE_STAND_UP_OFFSET = 118;
BALL_DRONE_CROUCH_UP_OFFSET = 70;
BALL_DRONE_PRONE_UP_OFFSET = 36;
BALL_DRONE_BACK_OFFSET = 40;
BALL_DRONE_SIDE_OFFSET = 40;

init() {
  level.killStreakFuncs["ball_drone_radar"] = ::tryUseBallDrone;
  level.killStreakFuncs["ball_drone_backup"] = ::tryUseBallDrone;

  level.ballDroneSettings = [];

  level.ballDroneSettings["ball_drone_radar"] = spawnStruct();
  level.ballDroneSettings["ball_drone_radar"].timeOut = 60.0;
  level.ballDroneSettings["ball_drone_radar"].health = 999999;
  level.ballDroneSettings["ball_drone_radar"].maxHealth = 500;
  level.ballDroneSettings["ball_drone_radar"].streakName = "ball_drone_radar";
  level.ballDroneSettings["ball_drone_radar"].vehicleInfo = "ball_drone_mp";
  level.ballDroneSettings["ball_drone_radar"].modelBase = "vehicle_ball_drone_iw6";
  level.ballDroneSettings["ball_drone_radar"].teamSplash = "used_ball_drone_radar";
  level.ballDroneSettings["ball_drone_radar"].fxId_sparks = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level.ballDroneSettings["ball_drone_radar"].fxId_explode = LoadFX("vfx/gameplay/explosions/vehicle/ball/vfx_exp_ball_drone");
  level.ballDroneSettings["ball_drone_radar"].sound_explode = "ball_drone_explode";
  level.ballDroneSettings["ball_drone_radar"].voDestroyed = "nowl_destroyed";
  level.ballDroneSettings["ball_drone_radar"].voTimedOut = "nowl_gone";
  level.ballDroneSettings["ball_drone_radar"].xpPopup = "destroyed_ball_drone_radar";
  level.ballDroneSettings["ball_drone_radar"].playFXCallback = ::radarBuddyPlayFx;
  level.ballDroneSettings["ball_drone_radar"].fxId_light1 = [];
  level.ballDroneSettings["ball_drone_radar"].fxId_light2 = [];
  level.ballDroneSettings["ball_drone_radar"].fxId_light3 = [];
  level.ballDroneSettings["ball_drone_radar"].fxId_light4 = [];
  level.ballDroneSettings["ball_drone_radar"].fxId_light1["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["ball_drone_radar"].fxId_light2["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["ball_drone_radar"].fxId_light3["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["ball_drone_radar"].fxId_light4["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["ball_drone_radar"].fxId_light1["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");
  level.ballDroneSettings["ball_drone_radar"].fxId_light2["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");
  level.ballDroneSettings["ball_drone_radar"].fxId_light3["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");
  level.ballDroneSettings["ball_drone_radar"].fxId_light4["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");

  level.ballDroneSettings["ball_drone_backup"] = spawnStruct();
  level.ballDroneSettings["ball_drone_backup"].timeOut = 90.0;
  level.ballDroneSettings["ball_drone_backup"].health = 999999;
  level.ballDroneSettings["ball_drone_backup"].maxHealth = 500;
  level.ballDroneSettings["ball_drone_backup"].streakName = "ball_drone_backup";
  level.ballDroneSettings["ball_drone_backup"].vehicleInfo = "backup_drone_mp";
  level.ballDroneSettings["ball_drone_backup"].modelBase = "vehicle_drone_backup_buddy";
  level.ballDroneSettings["ball_drone_backup"].teamSplash = "used_ball_drone_radar";
  level.ballDroneSettings["ball_drone_backup"].fxId_sparks = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level.ballDroneSettings["ball_drone_backup"].fxId_explode = LoadFX("fx/explosions/bouncing_betty_explosion");
  level.ballDroneSettings["ball_drone_backup"].sound_explode = "ball_drone_explode";
  level.ballDroneSettings["ball_drone_backup"].voDestroyed = "vulture_destroyed";
  level.ballDroneSettings["ball_drone_backup"].voTimedOut = "vulture_gone";
  level.ballDroneSettings["ball_drone_backup"].xpPopup = "destroyed_ball_drone";
  level.ballDroneSettings["ball_drone_backup"].weaponInfo = "ball_drone_gun_mp";
  level.ballDroneSettings["ball_drone_backup"].weaponModel = "vehicle_drone_backup_buddy_gun";
  level.ballDroneSettings["ball_drone_backup"].weaponTag = "tag_turret_attach";
  level.ballDroneSettings["ball_drone_backup"].sound_weapon = "weap_p99_fire_npc";
  level.ballDroneSettings["ball_drone_backup"].sound_targeting = "ball_drone_targeting";
  level.ballDroneSettings["ball_drone_backup"].sound_lockon = "ball_drone_lockon";
  level.ballDroneSettings["ball_drone_backup"].sentryMode = "sentry";
  level.ballDroneSettings["ball_drone_backup"].visual_range_sq = 1200 * 1200;

  level.ballDroneSettings["ball_drone_backup"].burstMin = 10;
  level.ballDroneSettings["ball_drone_backup"].burstMax = 20;
  level.ballDroneSettings["ball_drone_backup"].pauseMin = 0.15;
  level.ballDroneSettings["ball_drone_backup"].pauseMax = 0.35;
  level.ballDroneSettings["ball_drone_backup"].lockonTime = 0.25;
  level.ballDroneSettings["ball_drone_backup"].playFXCallback = ::backupBuddyPlayFX;
  level.ballDroneSettings["ball_drone_backup"].fxId_light1 = [];
  level.ballDroneSettings["ball_drone_backup"].fxId_light1["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["ball_drone_backup"].fxId_light1["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");

  level.ballDrones = [];

  SetDevDvarIfUninitialized("scr_balldrone_timeout", 60.0);
  SetDevDvarIfUninitialized("scr_balldrone_debug_position", 0);
  SetDevDvarIfUninitialized("scr_balldrone_debug_position_forward", 50.0);
  SetDevDvarIfUninitialized("scr_balldrone_debug_position_height", 35.0);
  SetDevDvarIfUninitialized("scr_balldrone_debug_path", 0);
}

tryUseBallDrone(lifeId, streakName) {
  return useBallDrone(streakName);
}

useBallDrone(ballDroneType) {
  numIncomingVehicles = 1;
  if(self isUsingRemote()) {
    return false;
  } else if(exceededMaxBallDrones()) {
    self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  } else if(isDefined(self.ballDrone)) {
    self IPrintLnBold(&"KILLSTREAKS_COMPANION_ALREADY_EXISTS");
    return false;
  } else if(isDefined(self.drones_disabled)) {
    self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE");
    return false;
  }

  incrementFauxVehicleCount();

  ballDrone = createBallDrone(ballDroneType);
  if(!isDefined(ballDrone)) {
    if(is_aliens())
      self.drone_failed = true;
    else
      self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE");

    decrementFauxVehicleCount();

    return false;
  }

  self.ballDrone = ballDrone;
  self thread startBallDrone(ballDrone);

  if(ballDroneType == "ball_drone_backup" && maps\mp\agents\_agent_utility::getNumOwnedActiveAgentsByType(self, "dog") > 0) {
    self maps\mp\gametypes\_missions::processChallenge("ch_twiceasdeadly");
  }

  return true;
}

createBallDrone(ballDroneType) {
  startAng = self.angles;
  forward = anglesToForward(self.angles);
  startPos = self.origin + (forward * 100) + Z_OFFSET;
  playerStartPos = self.origin + Z_OFFSET;
  trace = bulletTrace(playerStartPos, startPos, false);

  attempts = 3;
  while(trace["surfacetype"] != "none" && attempts > 0) {
    startPos = self.origin + (VectorNormalize(playerStartPos - trace["position"]) * 5);
    trace = bulletTrace(playerStartPos, startPos, false);
    attempts--;
    wait(0.05);
  }
  if(attempts <= 0) {
    return;
  }
  right = AnglesToRight(self.angles);
  targetPos = self.origin + (right * 20) + Z_OFFSET;
  trace = bulletTrace(startPos, targetPos, false);

  attempts = 3;
  while(trace["surfacetype"] != "none" && attempts > 0) {
    targetPos = startPos + (VectorNormalize(startPos - trace["position"]) * 5);
    trace = bulletTrace(startPos, targetPos, false);
    attempts--;
    wait(0.05);
  }
  if(attempts <= 0) {
    return;
  }
  drone = SpawnHelicopter(self, startPos, startAng, level.ballDroneSettings[ballDroneType].vehicleInfo, level.ballDroneSettings[ballDroneType].modelBase);
  if(!isDefined(drone)) {
    return;
  }
  drone EnableAimAssist();

  drone MakeVehicleNotCollideWithPlayers(true);

  drone addToBallDroneList();
  drone thread removeFromBallDroneListOnDeath();

  drone.health = level.ballDroneSettings[ballDroneType].health;
  drone.maxHealth = level.ballDroneSettings[ballDroneType].maxHealth;
  drone.damageTaken = 0;

  drone.speed = 140;
  drone.followSpeed = 140;
  drone.owner = self;
  drone.team = self.team;
  drone Vehicle_SetSpeed(drone.speed, 16, 16);
  drone SetYawSpeed(120, 90);
  drone SetNearGoalNotifyDist(16);
  drone.ballDroneType = ballDroneType;
  drone SetHoverParams(30, 10, 5);
  drone SetOtherEnt(self);

  drone make_entity_sentient_mp(self.team, balldroneType != "ball_drone_backup");
  if(IsSentient(drone)) {
    drone SetThreatBiasGroup("DogsDontAttack");
  }
  if(!is_aliens()) {
    if(level.teamBased)
      drone maps\mp\_entityheadicons::setTeamHeadIcon(drone.team, (0, 0, 25));
    else
      drone maps\mp\_entityheadicons::setPlayerHeadIcon(drone.owner, (0, 0, 25));
  }

  maxPitch = 45;
  maxRoll = 45;
  switch (ballDroneType) {
    case "ball_drone_radar":
      maxPitch = 90;
      maxRoll = 90;

      radar = spawn("script_model", self.origin);
      radar.team = self.team;
      radar MakePortableRadar(self);
      drone.radar = radar;
      drone thread radarMover();
      drone.ammo = 99999;
      drone.cameraOffset = distance(drone.origin, drone GetTagOrigin("camera_jnt"));
      drone thread maps\mp\gametypes\_trophy_system::trophyActive(self);
      drone thread ballDrone_handleDamage();
      break;

    case "ball_drone_backup":
    case "alien_ball_drone":
    case "alien_ball_drone_1":
    case "alien_ball_drone_2":
    case "alien_ball_drone_3":
    case "alien_ball_drone_4":
      turret = SpawnTurret("misc_turret", drone GetTagOrigin(level.ballDroneSettings[ballDroneType].weaponTag), level.ballDroneSettings[ballDroneType].weaponInfo);
      turret LinkTo(drone, level.ballDroneSettings[ballDroneType].weaponTag);
      turret setModel(level.ballDroneSettings[ballDroneType].weaponModel);
      turret.angles = drone.angles;
      turret.owner = drone.owner;
      turret.team = self.team;
      turret MakeTurretInoperable();
      turret MakeUnusable();
      turret.vehicle = drone;

      turret.health = level.ballDroneSettings[ballDroneType].health;
      turret.maxHealth = level.ballDroneSettings[ballDroneType].maxHealth;
      turret.damageTaken = 0;

      idleTargetPos = self.origin + (forward * -100) + (0, 0, 40);
      turret.idleTarget = spawn("script_origin", idleTargetPos);
      turret.idleTarget.targetname = "test";
      self thread idleTargetMover(turret.idleTarget);

      if(level.teamBased)
        turret SetTurretTeam(self.team);
      turret SetMode(level.ballDroneSettings[ballDroneType].sentryMode);
      turret SetSentryOwner(self);
      turret SetLeftArc(180);
      turret SetRightArc(180);
      turret SetBottomArc(50);
      turret thread ballDrone_attackTargets();
      turret SetTurretMinimapVisible(true, "buddy_turret");

      killCamOrigin = (drone.origin + ((anglesToForward(drone.angles) * -10) + (AnglesToRight(drone.angles) * -10))) + (0, 0, 10);
      turret.killCamEnt = spawn("script_model", killCamOrigin);
      turret.killCamEnt SetScriptMoverKillCam("explosive");
      turret.killCamEnt LinkTo(drone);

      drone.turret = turret;
      turret.parent = drone;

      drone thread ballDrone_backup_handleDamage();
      drone.turret thread ballDrone_backup_turret_handleDamage();

      break;

    default:
      break;
  }

  drone SetMaxPitchRoll(maxPitch, maxRoll);

  drone.targetPos = targetPos;

  drone.attract_strength = 10000;
  drone.attract_range = 150;
  if(!(is_aliens() && isDefined(level.script) && level.script == "mp_alien_last"))
    drone.attractor = Missile_CreateAttractorEnt(drone, drone.attract_strength, drone.attract_range);

  drone.hasDodged = false;
  drone.stunned = false;
  drone.inactive = false;

  drone thread watchEMPDamage();
  drone thread ballDrone_watchDeath();
  drone thread ballDrone_watchTimeout();
  drone thread ballDrone_watchOwnerLoss();
  drone thread ballDrone_watchOwnerDeath();
  drone thread ballDrone_watchRoundEnd();
  drone thread ballDrone_enemy_lightFX();
  drone thread ballDrone_friendly_lightFX();

  data = spawnStruct();
  data.validateAccurateTouching = true;
  data.deathOverrideCallback = ::balldrone_moving_platform_death;
  drone thread maps\mp\_movers::handle_moving_platforms(data);

  drone.owner maps\mp\_matchdata::logKillstreakEvent(level.ballDroneSettings[drone.ballDroneType].streakName, drone.targetPos);

  return drone;
}

balldrone_moving_platform_death(data) {
  if(!isDefined(data.lastTouchedPlatform.destroyDroneOnCollision) || data.lastTouchedPlatform.destroyDroneOnCollision) {
    self notify("death");
  }
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

ballDrone_enemy_lightFX() {
  self endon("death");
  settings = level.ballDroneSettings[self.ballDroneType];

  while(true) {
    foreach(player in level.players) {
      if(isDefined(player)) {
        if(level.teamBased) {
          if(player.team != self.team)
            self[[settings.playFXCallback]]("enemy", player);
        } else {
          if(player != self.owner)
            self[[settings.playFXCallback]]("enemy", player);
        }
      }
    }

    wait(1.0);
  }
}

ballDrone_friendly_lightFX() {
  self endon("death");
  settings = level.ballDroneSettings[self.ballDroneType];

  foreach(player in level.players) {
    if(isDefined(player)) {
      if(level.teamBased) {
        if(player.team == self.team)
          self[[settings.playFXCallback]]("friendly", player);
      } else {
        if(player == self.owner)
          self[[settings.playFXCallback]]("friendly", player);
      }
    }
  }

  self thread watchConnectedplayFX();
  self thread watchJoinedTeamplayFX();
}

backupBuddyplayFX(fof, player) {
  settings = level.ballDroneSettings[self.ballDroneType];

  PlayFXOnTagForClients(settings.fxId_light1[fof], self.turret, "tag_fx", player);
  PlayFXOnTagForClients(settings.fxId_light1[fof], self, "tag_fx", player);
}

radarBuddyplayFX(fof, player) {
  settings = level.ballDroneSettings[self.ballDroneType];

  PlayFXOnTagForClients(settings.fxId_light1[fof], self, "tag_fx", player);
  PlayFXOnTagForClients(settings.fxId_light2[fof], self, "tag_fx1", player);
  PlayFXOnTagForClients(settings.fxId_light3[fof], self, "tag_fx2", player);
  PlayFXOnTagForClients(settings.fxId_light4[fof], self, "tag_fx3", player);
}

watchConnectedplayFX() {
  self endon("death");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");

    settings = level.ballDroneSettings[self.ballDroneType];

    if(isDefined(player)) {
      if(level.teamBased) {
        if(player.team == self.team)
          self[[settings.playFXCallback]]("friendly", player);
        else
          self[[settings.playFXCallback]]("enemy", player);
      } else {
        if(player == self.owner)
          self[[settings.playFXCallback]]("friendly", player);
        else
          self[[settings.playFXCallback]]("enemy", player);
      }
    }
  }
}

watchJoinedTeamplayFX() {
  self endon("death");

  while(true) {
    level waittill("joined_team", player);
    player waittill("spawned_player");

    settings = level.ballDroneSettings[self.ballDroneType];

    if(isDefined(player)) {
      if(level.teamBased) {
        if(player.team == self.team)
          self[[settings.playFXCallback]]("friendly", player);
        else
          self[[settings.playFXCallback]]("enemy", player);
      } else {
        if(player == self.owner)
          self[[settings.playFXCallback]]("friendly", player);
        else
          self[[settings.playFXCallback]]("enemy", player);
      }
    }
  }
}

startBallDrone(ballDrone) {
  level endon("game_ended");
  ballDrone endon("death");

  switch (ballDrone.ballDroneType) {
    case "ball_drone_backup":
    case "alien_ball_drone":
    case "alien_ball_drone_1":
    case "alien_ball_drone_2":
    case "alien_ball_drone_3":
    case "alien_ball_drone_4":

      if(isDefined(ballDrone.turret) && isDefined(ballDrone.turret.idleTarget))
        ballDrone SetLookAtEnt(ballDrone.turret.idleTarget);
      else
        ballDrone SetLookAtEnt(self);
      break;

    default:

      ballDrone SetLookAtEnt(self);
      break;
  }

  targetOffset = (0, 0, BALL_DRONE_STAND_UP_OFFSET);
  ballDrone SetDroneGoalPos(self, targetOffset);
  ballDrone waittill("near_goal");
  ballDrone Vehicle_SetSpeed(ballDrone.speed, 10, 10);
  ballDrone waittill("goal");

  ballDrone thread ballDrone_followPlayer();
}

ballDrone_followPlayer() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner)) {
    self thread ballDrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");

  self Vehicle_SetSpeed(self.followSpeed, 10, 10);
  previousOrigin = (0, 0, 0);
  destRadiusSq = 64 * 64;

  self thread low_entries_watcher();

  while(true) {
    if(isDefined(self.owner) && IsAlive(self.owner)) {
      if(self.owner.origin != previousOrigin && DistanceSquared(self.owner.origin, previousOrigin) > destRadiusSq) {
        if(self.ballDroneType == "ball_drone_backup" || self.ballDroneType == "alien_ball_drone" || self.ballDroneType == "alien_ball_drone_1" || self.ballDroneType == "alien_ball_drone_2" || self.ballDroneType == "alien_ball_drone_3" || self.ballDroneType == "alien_ball_drone_4") {
          if(!isDefined(self.turret GetTurretTarget(false))) {
            previousOrigin = self.owner.origin;
            ballDrone_moveToPlayer();
            continue;
          }
        } else {
          previousOrigin = self.owner.origin;
          ballDrone_moveToPlayer();
          continue;
        }
      }
    }
    wait(1);
  }
}

ballDrone_moveToPlayer() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("ballDrone_moveToPlayer");
  self endon("ballDrone_moveToPlayer");

  backOffset = BALL_DRONE_BACK_OFFSET;

  sideOffset = BALL_DRONE_SIDE_OFFSET;

  heightOffset = BALL_DRONE_STAND_UP_OFFSET;
  switch (self.owner getStance()) {
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

  if(isDefined(self.low_entry))
    heightOffset = heightOffset * self.low_entry;

  targetOffset = (sideOffset, backOffset, heightOffset);

  if(GetDvarInt("scr_balldrone_debug_position")) {
    targetOffset = (0, -1 * GetDvarFloat("scr_balldrone_debug_position_forward"), GetDvarFloat("scr_balldrone_debug_position_height"));
  }

  self SetDroneGoalPos(self.owner, targetOffset);
  self.inTransit = true;
  self thread ballDrone_watchForGoal();
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
        if(isDefined(nodePath[i + 1]))
          Line(nodePath[i].origin + Z_OFFSET, nodePath[i + 1].origin + Z_OFFSET, (1, 0, 0));
      }
    }
    wait(0.05);
  }
}

ballDrone_watchForGoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  self notify("ballDrone_watchForGoal");
  self endon("ballDrone_watchForGoal");

  result = self waittill_any_return("goal", "near_goal", "hit_goal");
  self.inTransit = false;
  self.inactive = false;
  self notify("hit_goal");
}

radarMover() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait(0.5);
      continue;
    }
    if(isDefined(self.inactive) && self.inactive) {
      wait(0.5);
      continue;
    }

    if(isDefined(self.radar))
      self.radar MoveTo(self.origin, 0.5);

    wait(0.5);
  }
}

low_entries_watcher() {
  level endon("game_ended");
  self endon("gone");
  self endon("death");

  low_entries = getEntArray("low_entry", "targetname");

  while(low_entries.size > 0) {
    foreach(trigger in low_entries) {
      while(self IsTouching(trigger) || self.owner IsTouching(trigger)) {
        if(isDefined(trigger.script_parameters))
          self.low_entry = float(trigger.script_parameters);
        else
          self.low_entry = 0.5;

        wait 0.1;
      }

      self.low_entry = undefined;
    }

    wait 0.1;
  }
}

ballDrone_watchDeath() {
  level endon("game_ended");
  self endon("gone");

  self waittill("death");

  self thread ballDroneDestroyed();
}

ballDrone_watchTimeout() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");

  config = level.ballDroneSettings[self.ballDroneType];
  timeout = config.timeOut;
  if(is_aliens() && isDefined(level.ball_drone_alien_timeout_func) && isDefined(self.owner)) {
    timeout = self[[level.ball_drone_alien_timeout_func]](timeout, self.owner);
  }
  if(!is_aliens()) {
    timeout = GetDvarFloat("scr_balldrone_timeout");

  }
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeout);
  if(isDefined(self.owner) && !is_aliens())
    self.owner leaderDialogOnPlayer(config.voTimedOut);

  self thread ballDrone_leave();
}

ballDrone_watchOwnerLoss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  self.owner waittill("killstreak_disowned");

  self notify("owner_gone");

  self thread ballDrone_leave();
}

ballDrone_watchOwnerDeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  while(true) {
    self.owner waittill("death");

    if(getGametypeNumLives() && self.owner.pers["deaths"] == getGametypeNumLives())
      self thread ballDrone_leave();

  }
}

ballDrone_watchRoundEnd() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");

  level waittill_any("round_end_finished", "game_ended");

  self thread ballDrone_leave();
}

ballDrone_leave() {
  self endon("death");
  self notify("leaving");

  ballDroneExplode();
}

ballDrone_handleDamage() {
  self maps\mp\gametypes\_damage::monitorDamage(self.maxHealth, "ball_drone", ::handleDeathDamage, ::modifyDamage, true);
}

ballDrone_backup_handleDamage() {
  self endon("death");
  level endon("game_ended");

  self setCanDamage(true);

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    self maps\mp\gametypes\_damage::monitorDamageOneShot(damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon, "ball_drone", ::handleDeathDamage, ::modifyDamage, true);
  }
}

ballDrone_backup_turret_handleDamage() {
  self endon("death");
  level endon("game_ended");

  self MakeTurretSolid();
  self setCanDamage(true);

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(isDefined(self.parent)) {
      self.parent maps\mp\gametypes\_damage::monitorDamageOneShot(damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon, "ball_drone", ::handleDeathDamage, ::modifyDamage, true);
    }
  }
}

modifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

handleDeathDamage(attacker, weapon, type, damage) {
  config = level.ballDroneSettings[self.ballDroneType];
  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, config.xpPopup, config.voDestroyed);

  if(self.ballDroneType == "ball_drone_backup") {
    attacker maps\mp\gametypes\_missions::processChallenge("ch_vulturekiller");
  }

}

watchEMPDamage() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self ballDrone_stunned(duration);
  }
}

ballDrone_stunned(duration) {
  self notify("ballDrone_stunned");
  self endon("ballDrone_stunned");

  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  self.stunned = true;

  if(isDefined(level.ballDroneSettings[self.ballDroneType].fxId_sparks)) {
    playFXOnTag(level.ballDroneSettings[self.ballDroneType].fxId_sparks, self, "tag_origin");
  }

  if(self.ballDroneType == "ball_drone_radar") {
    if(isDefined(self.radar))
      self.radar delete();
  }

  if(isDefined(self.turret)) {
    self.turret notify("turretstatechange");
  }

  wait(duration);

  self.stunned = false;

  if(self.ballDroneType == "ball_drone_radar") {
    radar = spawn("script_model", self.origin);
    radar.team = self.team;
    radar MakePortableRadar(self.owner);
    self.radar = radar;
  }

  if(isDefined(self.turret)) {
    self.turret notify("turretstatechange");
  }
}

ballDroneDestroyed() {
  if(!isDefined(self)) {
    return;
  }
  ballDroneExplode();
}

ballDroneExplode() {
  if(isDefined(level.ballDroneSettings[self.ballDroneType].fxId_explode)) {
    playFX(level.ballDroneSettings[self.ballDroneType].fxId_explode, self.origin);
  }

  if(isDefined(level.ballDroneSettings[self.ballDroneType].sound_explode)) {
    self playSound(level.ballDroneSettings[self.ballDroneType].sound_explode);
  }

  self notify("explode");

  self removeBallDrone();
}

removeBallDrone() {
  decrementFauxVehicleCount();

  if(isDefined(self.radar))
    self.radar delete();

  if(isDefined(self.turret)) {
    self.turret SetTurretMinimapVisible(false);

    if(isDefined(self.turret.idleTarget))
      self.turret.idleTarget delete();

    if(isDefined(self.turret.killCamEnt))
      self.turret.killCamEnt delete();

    self.turret delete();
  }

  if(isDefined(self.owner) && isDefined(self.owner.ballDrone))
    self.owner.ballDrone = undefined;

  self delete();
}

addToBallDroneList() {
  level.ballDrones[self GetEntityNumber()] = self;
}

removeFromBallDroneListOnDeath() {
  entNum = self GetEntityNumber();

  self waittill("death");

  level.ballDrones[entNum] = undefined;
}

exceededMaxBallDrones() {
  if(level.ballDrones.size >= maxVehiclesAllowed())
    return true;
  else
    return false;
}

ballDrone_attackTargets() {
  self.vehicle endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("turretstatechange");

    if(self IsFiringTurret() && (isDefined(self.vehicle.stunned) && !self.vehicle.stunned) && (isDefined(self.vehicle.inactive) && !self.vehicle.inactive)) {
      self LaserOn();
      self doLockOn(level.ballDroneSettings[self.vehicle.ballDroneType].lockonTime);
      self thread ballDrone_burstFireStart();
    } else {
      self LaserOff();
      self thread ballDrone_burstFireStop();
    }
  }
}

ballDrone_burstFireStart() {
  self.vehicle endon("death");
  self endon("stop_shooting");
  level endon("game_ended");

  vehicle = self.vehicle;

  fireTime = WeaponFireTime(level.ballDroneSettings[vehicle.ballDroneType].weaponInfo);
  minShots = level.ballDroneSettings[vehicle.ballDroneType].burstMin;
  maxShots = level.ballDroneSettings[vehicle.ballDroneType].burstMax;
  minPause = level.ballDroneSettings[vehicle.ballDroneType].pauseMin;
  maxPause = level.ballDroneSettings[vehicle.ballDroneType].pauseMax;

  if(is_aliens() && level.ballDroneSettings[vehicle.ballDroneType].weaponInfo == "alien_ball_drone_gun4_mp")
    self childthread fire_rocket();

  while(true) {
    numShots = RandomIntRange(minShots, maxShots + 1);
    for(i = 0; i < numShots; i++) {
      if(isDefined(vehicle.inactive) && vehicle.inactive) {
        break;
      }

      targetEnt = self GetTurretTarget(false);
      if(isDefined(targetEnt) && canBeTargeted(targetEnt)) {
        vehicle SetLookAtEnt(targetEnt);

        self ShootTurret();

      }

      wait(fireTime);
    }

    wait(RandomFloatRange(minPause, maxPause));
  }
}

fire_rocket() {
  while(true) {
    targetEnt = self GetTurretTarget(false);
    if(isDefined(targetEnt) && canBeTargeted(targetEnt)) {
      MagicBullet("alienvulture_mp", self GetTagOrigin("tag_flash"), targetEnt.origin, self.owner);
    }
    waittime = WeaponFireTime("alienvulture_mp");

    if(isDefined(level.ball_drone_faster_rocket_func) && isDefined(self.owner)) {
      waittime = self[[level.ball_drone_faster_rocket_func]](waittime, self.owner);
    }

    wait WeaponFireTime("alienvulture_mp");
  }
}

doLockOn(time) {
  while(time > 0) {
    self playSound(level.ballDroneSettings[self.vehicle.ballDroneType].sound_targeting);

    wait(0.5);
    time -= 0.5;
  }

  self playSound(level.ballDroneSettings[self.vehicle.ballDroneType].sound_lockon);
}

ballDrone_burstFireStop() {
  self notify("stop_shooting");
  if(isDefined(self.idleTarget))
    self.vehicle SetLookAtEnt(self.idleTarget);
}

canBeTargeted(ent) {
  canTarget = true;

  if(IsPlayer(ent)) {
    if(!isReallyAlive(ent) || ent.sessionstate != "playing")
      return false;
  }

  if(level.teamBased && isDefined(ent.team) && ent.team == self.team)
    return false;

  if(isDefined(ent.team) && ent.team == "spectator")
    return false;

  if(IsPlayer(ent) && ent == self.owner)
    return false;

  if(IsPlayer(ent) && isDefined(ent.spawntime) && (GetTime() - ent.spawntime) / 1000 <= 5)
    return false;

  if(IsPlayer(ent) && ent _hasPerk("specialty_blindeye"))
    return false;

  if(DistanceSquared(ent.origin, self.origin) > level.ballDroneSettings[self.vehicle.ballDroneType].visual_range_sq)
    return false;

  turret_point = self GetTagOrigin("tag_flash");

  return canTarget;
}