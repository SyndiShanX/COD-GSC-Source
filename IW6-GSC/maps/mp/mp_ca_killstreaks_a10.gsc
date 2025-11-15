/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_ca_killstreaks_a10.gsc
*********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

KS_NAME = "ca_a10_strafe";
kTransitionTime = 0.125;
kLockIconOffset = (0, 0, -70);

init(map_name) {
  level._effect["vfx_a10_missile_fire"] = LoadFX("vfx/moments/mp_ca_impact/vfx_a10_missile_fire");

  config = spawnStruct();
  config.modelNames = [];
  config.modelNames["allies"] = "vehicle_ca_a10_warthog";
  config.modelNames["axis"] = "vehicle_ca_a10_warthog";
  config.vehicle = "ca_a10warthog_mp";
  config.inboundSfx = "veh_mig29_dist_loop";

  config.speed = 750;
  config.halfDistance = 12500;
  config.heightRange = 750;
  config.chooseDirection = true;
  config.selectLocationVO = "KS_hqr_airstrike";
  config.inboundVO = "KS_ast_inbound";

  config.cannonFireVfx = LoadFX("fx/smoke/smoke_trail_white_heli");
  config.cannonRumble = "ac130_25mm_fire";
  config.turretName = "a10_cammturret_mp";
  config.turretAttachPoint = "tag_barrel";

  config.rocketModelName = "iw6_a10impactmissile_mp";

  config.numRockets = 4;
  config.delayBetweenRockets = 0.125;
  config.delayBetweenLockon = 0.4;
  config.lockonIcon = "veh_hud_target_chopperfly";

  config.maxHealth = 10000;
  config.xpPopup = "destroyed_a10_strafe";
  config.callout = "callout_destroyed_a10";
  config.voDestroyed = undefined;
  config.explodeVfx = LoadFX("vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary");

  config.sfxCannonFireLoop_1p = "a10_plr_fire_gatling_lp";
  config.sfxCannonFireStop_1p = "a10_plr_fire_gatling_cooldown";
  config.sfxCannonFireLoop_3p = "a10_npc_fire_gatling_lp";
  config.sfxCannonFireStop_3p = "a10_npc_fire_gatling_cooldown";
  config.sfxCannonFireBurpTime = 500;
  config.sfxCannonFireBurpShort_3p = "veh_a10_npc_fire_gatling_short_burst";
  config.sfxCannonFireBurpLong_3p = "veh_a10_npc_fire_gatling_long_burst";
  config.sfxCannonBulletImpact = "a10_bullet_impact_lp";

  config.sfxMissileFire_1p = [];
  config.sfxMissileFire_1p[0] = "veh_a10_plr_missile_ignition_left";
  config.sfxMissileFire_1p[1] = "veh_a10_plr_missile_ignition_right";
  config.sfxMissileFire_3p = "veh_a10_npc_missile_fire";
  config.sfxMissile = "veh_a10_missile_loop";

  config.sfxEngine_1p = "veh_a10_plr_engine_lp";
  config.sfxEngine_3p = "veh_a10_dist_loop";

  level.planeConfigs[KS_NAME] = config;

  level.killstreakFuncs[KS_NAME] = ::onUse;

  level.a10_active = 0;
  level.curr_a10_index = 0;

  if(map_name == "impact")
    buildAllFlightPathsImpact();
  else
    buildAllFlightPathsDefault();

  level.debug_prints = 0;
}

onUse(lifeId, streakName) {
  config = level.planeConfigs[KS_NAME];
  level.killstreakWeildWeapons[config.rocketModelName] = "ca_a10_strafe";
  level.killstreakWeildWeapons[config.turretName] = "ca_a10_strafe";

  if(isAirDenied()) {
    self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE_WHEN_AA");
    return false;
  }

  if(isDefined(level.nukeIncoming) && level.nukeIncoming) {
    self IPrintLnBold(&"MP_CA_KILLSTREAKS_A10_UNAVAIL_NUKE");
    return false;
  }

  if(self isNuked()) {
    self iPrintlnBold(&"KILLSTREAKS_UNAVAILABLE_FOR_N_WHEN_NUKE", level.nukeEmpTimeRemaining);
    return false;
  }

  if(level.a10_active || self isUsingRemote() || self isKillStreakDenied() || !isAlive(self)) {
    return false;
  }

  if((level.littleBirds.size == 0) && !(isDefined(level.chopper))) {
    self thread doStrike(lifeId, KS_NAME);
    return true;
  }

  self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
  return false;
}

doStrike(lifeId, streakName) {
  self endon("end_remote");
  self endon("disconnect");
  level endon("game_ended");
  self endon("ca_a10_nuked");

  self thread watchTeamSwitchPre();
  self thread watchDisconnect();
  self thread watchNukePlayer();

  index_a = 0;
  index_b = 1;

  pathIndex = 0;

  print(" A10 fly path (" + level.a10SplinesIn[pathIndex] + ", " + level.a10SplinesOut[pathIndex] + ")\n");

  result = self startStrafeSequence(streakName, lifeId);
  if(result) {
    if(level.teamBased) {
      level.teamAirDenied[self.team] = true;
      level.teamAirDenied[getOtherTeam(self.team)] = true;
    } else
      level.airDeniedPlayer = self;

    self thread watchGameEnd();

    level.a10_active = 1;

    level thread teamPlayerCardSplash("used_ca_a10_strafe", self, self.team);

    self.is_attacking = 0;
    plane = spawnAircraft(streakName, lifeId, level.a10SplinesIn[index_a], "1");
    if(isDefined(plane)) {
      self thread a10_play_pilot_vo_with_wait("mp_ca_impact_a10_pilot_01", 1.05);
      plane doOneFlyby();

      self.is_attacking = 0;

      self VisionSetNakedForPlayer("black_bw", 0.75);
      wait(0.80);

      self RemoteControlVehicleOff();

      if(isDefined(plane)) {
        plane.forceClean = true;
        plane thread endFlyby(streakName);
      }

      plane = spawnAircraft(streakName, lifeId, level.a10SplinesIn[index_b], "2");

      if(isDefined(plane)) {
        self thread maps\mp\killstreaks\_killstreaks::clearRideIntro(1.0, kTransitionTime);
        self thread a10_play_pilot_vo_with_wait("mp_ca_impact_a10_pilot_02", 0.3);

        plane doOneFlyby();

        if(isDefined(plane))
          plane thread endFlyby(streakName);

        self endStrafeSequence(streakName);
      }
    }
  }

  return result;
}

a10_play_pilot_vo_with_wait(aliasname, waittime) {
  wait(waittime);
  self PlayLocalSound(aliasname);
}

startStrafeSequence(streakName, lifeId) {
  self endon("end_remote");
  self endon("disconnect");

  self setUsingRemote(KS_NAME);
  self freezeControlsWrapper(true);

  if(GetDvarInt("camera_thirdPerson"))
    self setThirdPersonDOF(false);

  self.restoreAngles = self.angles;

  if(self isJuggernaut() && isDefined(self.juggernautOverlay)) {
    self.juggernautOverlay.alpha = 0;
  }

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak(KS_NAME);
  if(result != "success") {
    if(result != "disconnect")
      self clearUsingRemote();

    if(isDefined(self.disabledWeapon) && self.disabledWeapon)
      self _enableWeapon();
    self notify("death");

    return false;
  }

  self freezeControlsWrapper(false);

  level.a10strafeActive = true;
  self.using_remote_a10 = true;

  return true;
}

endStrafeSequence(switch_state) {
  level endon("game_over");

  if(isDefined(self)) {
    if(switch_state != "team_switch") {
      while(!IsAlive(self)) {
        wait 0.5;
      }
    }

    if(self isJuggernaut() && isDefined(self.juggernautOverlay)) {
      self.juggernautOverlay.alpha = 1;
    }

    self freezeControlsWrapper(false);

    if(self isUsingRemote())
      self clearUsingRemote();

    self SetClientOmnvar("ui_a10", false);
    self SetClientOmnvar("ui_a10_alt_warn", false);
    self SetClientOmnvar("ui_a10_cannon", false);
    self ThermalVisionFOFOverlayOff();

    if(GetDvarInt("camera_thirdPerson")) {
      self setThirdPersonDOF(true);
    }

    if(isDefined(self.restoreAngles)) {
      self SetPlayerAngles(self.restoreAngles);
      self.restoreAngles = undefined;
    }

    self thread a10_FreezeBuffer();
    self.using_remote_a10 = undefined;

  }

  level.a10strafeActive = undefined;
  level.a10_active = 0;

  if(level.teamBased) {
    level.teamAirDenied["axis"] = false;
    level.teamAirDenied["allies"] = false;
  } else
    level.airDeniedPlayer = undefined;
}

attachMissiles() {
  i = 4;
  self.missiles = [];
  while(i) {
    missileTag = "tag_missile_" + i;
    self.missiles[missileTag] = spawn("script_model", self GetTagOrigin(missileTag));
    self.missiles[missileTag] setModel("veh_ca_a10_missile");
    self.missiles[missileTag].angles = self GetTagAngles(missileTag);
    self.missiles[missileTag] LinkTo(self, missileTag);
    i--;
  }

}

attachAnimatedFlaps() {
  self.animated_flaps = spawn("script_model", self GetTagOrigin("tag_origin"));
  self.animated_flaps setModel("veh_ca_a10_flaps_animated");
  self.animated_flaps.angles = self GetTagAngles("tag_origin");
  self.animated_flaps LinkTo(self, "tag_origin");
}

spawnAircraft(streakName, lifeId, splineId, numPlane) {
  self endon("end_remote");
  self endon("disconnect");

  self.plane = createPlaneAsHeli(streakName, lifeId, splineId);
  if(!isDefined(self.plane))
    return undefined;

  self.plane.streakName = streakName;

  self.plane attachMissiles();
  self.plane attachAnimatedFlaps();

  self CameraLinkTo(self.plane, "tag_player");
  self RemoteControlVehicle(self.plane);
  self thread watchIntroCleared(streakName, self.plane);
  self.plane SetPlaneSplineId(self, splineId);

  config = level.planeConfigs[streakName];

  sound_name = "scn_impact_a10_passby_0" + numPlane;
  self.plane playsoundonmovingent(sound_name);
  self.plane.sound_name = sound_name;

  self.plane thread a10_handleDamage();

  self.plane thread watchDisconnectPlane();

  return self.plane;
}

SpawnAndPlaySoundForA10(plane, numPlane) {
  sound_ent = spawn("script_model", plane.origin);
  sound_ent setModel("tag_origin");
  sound_alias = ("scn_impact_a10_passby_0" + numPlane);
  sound_ent linkto(plane);
  sound_ent PlaySoundOnMovingEnt(sound_alias);
}

attachTurret(streakName) {
  config = level.planeConfigs[streakName];
  turretPos = self GetTagOrigin(config.turretAttachPoint);
  turret = SpawnTurret("misc_turret", self.origin + turretPos, config.turretName, false);
  turret.angles = self GetTagAngles(config.turretAttachPoint);
  turret LinkTo(self, config.turretAttachPoint, (0, 0, 0), (0, 0, 0));

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

  i = 4;
  while(i) {
    missileTag = "tag_missile_" + i;
    self.missiles[missileTag] Hide();
    self.missiles[missileTag] Delete();
    i--;
  }

  self.animated_flaps Hide();
  self.animated_flaps Delete();

  if(isDefined(self.targetList)) {
    foreach(targetInfo in self.targetList) {
      if(isDefined(targetInfo["icon"])) {
        targetInfo["icon"] Destroy();
        targetInfo["icon"] = undefined;
      }
    }
  }

  self Delete();
}

getPathIndex() {
  return (RandomInt(level.a10SplinesIn.size));
}

debug_print_movement(movement) {
  println(movement);
  outString = "";
  if(movement[0] > 0)
    outString += "forward";
  else if(movement[0] == 0)
    outString += "-";
  else if(movement[0] < 0)
    outString += "backward";

  outString += ", ";

  if(movement[1] > 0)
    outString += "right";
  else if(movement[1] == 0)
    outString += "-";
  else if(movement[1] < 0)
    outString += "left";

  println(outString);
}

#using_animtree("mp_ca_impact");
handle_anim(state) {
  self endon("a10_end_strafe");
  self endon("disconnect");

  if(state == "left")
    self.animated_flaps ScriptModelPlayAnim("veh_ca_a10_roll_left");
  if(state == "right")
    self.animated_flaps ScriptModelPlayAnim("veh_ca_a10_roll_right");
  if(state == "level")
    self.animated_flaps ScriptModelPlayAnim("veh_ca_a10_roll_level");
}

player_input_monitor() {
  self endon("a10_end_strafe");
  self.owner endon("disconnect");

  while(isDefined(self)) {
    movement = self.owner GetNormalizedMovement();

    if(movement[1] > 0) {
      self thread handle_anim("right");
    } else if(movement[1] == 0) {
      self thread handle_anim("level");
    } else if(movement[1] < 0) {
      self thread handle_anim("left");
    }
    wait 0.05;
  }

}

doOneFlyby() {
  self endon("death");
  level endon("game_ended");

  self thread player_input_monitor();

  while(true) {
    self waittill("splinePlaneReachedNode", nodeLabel);
    if(isDefined(nodeLabel) && nodeLabel == "End") {
      self notify("a10_end_strafe");
      break;
    }
  }

  self.owner notify("a10_cannon_stop");
  self notify("a10_cannon_stop");
}

endFlyby(streakName) {
  if(!isDefined(self)) {
    return;
  }

  config = level.planeConfigs[streakName];

  if(streakName != "disconnect") {
    self.owner.is_attacking = 0;

    self.owner RemoteControlVehicleOff(self);
    if(isDefined(self.turret)) {
      self.owner RemoteControlTurretOff(self.turret);
    }
  }

  self notify("end_remote");

  if(!(isDefined(self.forceClean)))
    wait(5);
  else
    self StopSounds();

  if(isDefined(self)) {
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
  self endon("delete");

  self waittill("death");

  self.forceClean = true;
  self.owner thread endStrafeSequence(KS_NAME);
  self thread endFlyby(KS_NAME);

  level.a10_active = 0;
  level.a10strafeActive = undefined;
  self.owner.using_remote_a10 = undefined;
}

a10_FreezeBuffer() {
  self endon("disconnect");

  level endon("game_ended");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

monitorRocketFire2(streakName, plane) {
  plane endon("end_remote");
  plane endon("death");
  self endon("disconnect");
  level endon("game_ended");

  config = level.planeConfigs[streakName];
  plane.numRocketsLeft = config.numRockets;

  plane.targetList = [];

  if(!IsBot(self)) {
    self NotifyOnPlayerCommand("rocket_fire_pressed", "+speed_throw");
    self NotifyOnPlayerCommand("rocket_fire_pressed", "+ads_akimbo_accessible");

    if(!level.console) {
      self NotifyOnPlayerCommand("rocket_fire_pressed", "+toggleads_throw");
    }

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
  self endon("disconnect");
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

  info["target"] = target;

  self.targetList[target GetEntityNumber()] = info;

  self.owner PlayLocalSound("recondrone_lockon");
}

isMissileTargeted(target) {
  return (isDefined(self.targetList[target GetEntityNumber()]));
}

fireMissiles() {
  self endon("death");
  self endon("disconnect");
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
  self endon("disconnect");

  tagName = "tag_missile_" + self.numRocketsLeft;

  rocketPos = self GetTagOrigin(tagName);
  if(isDefined(rocketPos)) {
    owner = self.owner;

    config = level.planeConfigs[streakName];

    rocket = MagicBullet(config.rocketModelName, rocketPos, rocketPos + 100 * anglesToForward(self.angles), self.owner);
    rocket thread a10_missile_set_target(target, targetOffset);

    Earthquake(0.25, 0.05, self.origin, 512);

    self.numRocketsLeft--;
    self.owner SetClientOmnvar("ui_a10_rocket", self.numRocketsLeft);

    self PlaySoundOnMovingEnt("a10p_missile_launch");

    playFXOnTag(level._effect["vfx_a10_missile_fire"], self, tagName);

    self.missiles[tagName] Hide();

    return rocket;
  }

  return undefined;
}

MISSILE_IMPACT_DIST_MAX = 15000;
MISSILE_IMPACT_DIST_MIN = 1000;

a10_missile_set_target(target, offset) {
  self thread a10_missile_cleanup();

  wait 0.2;

  if(isDefined(self) && IsAlive(self))
    self Missile_SetTargetEnt(target, offset);
}

a10_missile_cleanup() {
  self waittill("death");

  if(isDefined(self.icon)) {
    self.icon Destroy();
  }
}

bot_plane_watcher(plane) {
  level.end_a10_firing = 0;
  plane waittill("end_remote");
  level.end_a10_firing = 1;
}

bot_fire_controller(plane, config) {
  self BotPressButton("attack");

  self thread bot_plane_watcher(plane);

  self.is_attacking = 1;
  plane thread update_hit_sound_ent();
  plane thread update_gatling_sound_ent();

  while(!level.end_a10_firing) {
    self BotPressButton("attack");
    wait 0.01;
  }

  self.is_attacking = 0;
}

get_look_position() {
  eye = self.origin;
  angles = self.angles;
  forward = anglesToForward(angles);
  end = eye + (forward * 7000);
  trace = bulletTrace(eye, end, true, self);

  return trace["position"];
}

update_hit_sound_ent() {
  level endon("game_ended");

  spawn_origin = self get_look_position();
  moving_ent = spawn("script_origin", spawn_origin);
  moving_ent playLoopSound("a10_bullet_impact_lp");

  while(isDefined(self) && self.owner.is_attacking) {
    moving_ent MoveTo(self get_look_position(), 0.15);
    wait 0.01;
  }

  moving_ent StopLoopSound();
  moving_ent Delete();
}

update_gatling_sound_ent() {
  level endon("game_ended");

  spawn_origin = self.origin;
  moving_gatling_ent = spawn("script_origin", spawn_origin);

  self.owner PlayLocalSound("a10_plr_fire_gatling_lp");

  moving_gatling_ent playLoopSound("a10_npc_fire_gatling_lp");

  while(isDefined(self) && isDefined(self.owner) && isDefined(moving_gatling_ent) && self.owner.is_attacking) {
    moving_gatling_ent MoveTo(self.origin, 0.1);
    wait 0.01;
  }

  if(isDefined(self))
    self thread update_gatling_sound_release_ent();

  if(isDefined(self) && isDefined(self.owner))
    self.owner StopLocalSound("a10_plr_fire_gatling_lp");

  if(isDefined(moving_gatling_ent)) {
    moving_gatling_ent StopLoopSound();

    moving_gatling_ent Delete();
  }
}

cutoff_gatling_sound_release() {
  self waittill_any("end_remote", "end_gatling");
  self.owner StopLocalSound("a10_plr_fire_gatling_cooldown");
}

update_gatling_sound_release_ent() {
  level endon("game_ended");

  spawn_origin = self.origin;
  moving_gatling_release_ent = spawn("script_origin", spawn_origin);

  self thread cutoff_gatling_sound_release();

  self.owner PlayLocalSound("a10_plr_fire_gatling_cooldown");
  moving_gatling_release_ent playSound("a10_npc_fire_gatling_cooldown");

  wait 2.5;

  if(isDefined(moving_gatling_release_ent))
    moving_gatling_release_ent Delete();

  self notify("end_gatling");
}

CANNON_SHAKE_TIME = 0.5;
monitorWeaponFire(streakName, plane) {
  self endon("disconnect");
  level endon("game_ended");
  plane endon("end_remote");
  plane endon("death");
  plane endon("a10_end_strafe");

  config = level.planeConfigs[streakName];

  plane.ammoCount = 1350;

  self SetClientOmnvar("ui_a10_cannon", plane.ammoCount);

  if(isBot(self))
    self thread bot_fire_controller(plane, config);

  else {
    self thread monitor_attack_button(plane);

    while(plane.ammoCount > 0) {
      while(!self.is_attacking) {
        wait 0.01;
      }

      cannonShortBurstTimeLimit = GetTime() + config.sfxCannonFireBurpTime;

      plane thread update_hit_sound_ent();
      plane thread update_gatling_sound_ent();
      plane thread updateCannonShake(streakName);

      while(self.is_attacking) {
        wait 0.1;
      }
    }

    self.is_attacking = 0;
  }

}

monitor_attack_button(plane) {
  plane endon("a10_end_strafe");
  self endon("a10_end_strafe");
  self endon("disconnect");

  self.is_attacking = 0;
  while(isDefined(plane)) {
    if(self AttackButtonPressed())
      self.is_attacking = 1;
    else
      self.is_attacking = 0;
    wait 0.1;
  }
}

updateCannonShake(streakName) {
  self.owner endon("a10_cannon_stop");
  self.owner endon("disconnect");
  self endon("death");
  level endon("game_ended");

  config = level.planeConfigs[streakName];

  while((self.ammoCount > 0) && self.owner.is_attacking && (isDefined(self))) {
    Earthquake(0.2, CANNON_SHAKE_TIME, self.origin, 512);
    self.ammoCount -= 10;
    self.owner SetClientOmnvar("ui_a10_cannon", self.ammoCount);
    barrelPoint = self GetTagOrigin("tag_flash_attach") + 20 * anglesToForward(self.angles);

    playFX(config.cannonFireVFX, barrelPoint);

    self.owner PlayRumbleOnEntity(config.cannonRumble);

    wait(0.1);
  }

  if(isDefined(self))
    if(isDefined(self.turret))
      self.turret TurretFireDisable();
}

ALTITUDE_WARNING_LIMIT = 10;
monitorAltitude(streakName, plane) {
  plane endon("end_remote");
  plane endon("death");
  self endon("disconnect");
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

watchDisconnectPlane() {
  level endon("game_ended");
  level endon("round_end_finished");
  self endon("end_remote");

  self.owner waittill("disconnect");

  self.forceClean = true;
  self thread a10_explode();
  self thread endFlyby("disconnect");
  thread endStrafeSequence(KS_NAME);
}

watchDisconnect() {
  level endon("game_ended");
  level endon("round_end_finished");
  self endon("cleared_intro");

  self waittill("disconnect");

  if(isDefined(self) && isDefined(self.plane)) {
    self.plane.forceClean = true;
    self.plane thread endFlyby(KS_NAME);
  }
  if(isDefined(self))
    self endStrafeSequence("team_switch");
}

watchGameEnd() {
  level endon("round_end_finished");
  self endon("end_remote");

  level waittill("game_ended");

  self notify("a10_end_strafe");

  if(isDefined(self) && isDefined(self.plane)) {
    self.plane.forceClean = true;
    self.plane thread endFlyby(KS_NAME);
  }
  if(isDefined(self))
    self endStrafeSequence("team_switch");
}

watchTeamSwitchPre() {
  level endon("game_ended");
  level endon("round_end_finished");
  self endon("cleared_intro");

  self waittill_any("joined_team", "joined_spectators");

  self notify("switch_team");
  self notify("end_remote");

  if(isDefined(self.plane)) {
    self.plane.forceClean = true;
    self.plane thread endFlyby(KS_NAME);
  }

  self endStrafeSequence("team_switch");
}

watchIntroCleared(streakName, plane) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_remote");

  self waittill("intro_cleared");

  self thread monitorAltitude(streakname, plane);
  self thread monitorRocketFire2(streakName, plane);
  self thread monitorWeaponFire(streakName, plane);
  self thread watchRoundEnd(plane, streakName);

  self thread watchEarlyExit(plane);
  self thread watchNuke(plane, KS_NAME);
  self thread watchTeamSwitchPost(plane, KS_NAME);

  self SetClientOmnvar("ui_a10", true);
  self ThermalVisionFOFOverlayOn();
}

watchEarlyExit(veh) {
  level endon("round_end_finished");
  level endon("game_ended");
  veh endon("death");
  veh endon("a10_end_strafe");

  veh thread maps\mp\killstreaks\_killstreaks::allowRideKillstreakPlayerExit("killstreakExit");

  veh waittill("killstreakExit");

  self notify("end_remote");
  veh notify("end_remote");

  veh.forceClean = true;
  veh thread a10_explode();
  self thread endStrafeSequence(KS_NAME);
  veh thread endFlyby(KS_NAME);
}

watchNukePlayer() {
  self endon("disconnect");
  self endon("end_remote");

  level waittill("nuke_death");
  self notify("ca_a10_nuked");

  self thread endStrafeSequence(KS_NAME);
}

watchNuke(plane, streakName) {
  plane endon("a10_end_strafe");
  self endon("disconnect");
  self endon("end_remote");

  level waittill("nuke_death");
  self notify("ca_a10_nuked");

  self thread endStrafeSequence(KS_NAME);

  if(isDefined(plane)) {
    plane.forceClean = true;
    plane thread a10_explode();
    plane thread endFlyby(KS_NAME);
  }

}

watchTeamSwitchPost(plane, streakName) {
  plane endon("death");
  plane endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  level endon("round_end_finished");

  self notify("cleared_intro");

  self waittill_any("joined_team", "joined_spectators");

  self notify("a10_end_strafe");
  self notify("end_remote");

  plane.forceClean = true;
  self thread endStrafeSequence("team_switch");
  plane thread a10_explode();
  plane thread endFlyby(streakName);
}

watchRoundEnd(plane, streakName) {
  plane endon("death");
  plane endon("leaving");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  level waittill_any("round_end_finished", "game_ended");

  plane.forceClean = true;
  plane thread endFlyby(streakName);
  plane thread a10_explode();
  self endStrafeSequence("team_switch");
}

buildAllFlightPathsImpact() {
  inBoundList = [];
  inBoundList[0] = 1;
  inBoundList[1] = 2;

  outBoundList = [];
  outBoundList[0] = 1;
  outBoundList[1] = 2;

  buildAllFlightPaths(inBoundList, outBoundList);
}

buildAllFlightPathsDefault() {
  inBoundList = [];
  inBoundList[0] = 1;
  inBoundList[1] = 1;

  outBoundList = [];
  outBoundList[0] = 1;
  outBoundList[1] = 1;

  buildAllFlightPaths(inBoundList, outBoundList);
}

buildAllFlightPaths(inBoundList, outBoundList) {
  level.a10SplinesIn = inBoundList;
  level.a10SplinesOut = outBoundList;
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

  self thread a10_explode();
}

a10_explode() {
  if(isDefined(self)) {
    config = level.planeConfigs[self.streakName];

    playFX(config.explodeVfx, self.origin);
    self Hide();

    wait 20.0;

  }
}