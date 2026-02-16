/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_solar.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

CONST_DAMAGE_RADIUS = 128;
CONST_DAMAGE_MIN = 2;
CONST_DAMAGE_MAX = 8;
CONST_FIRE_TIME = 5;
CONST_FIRE_RADIUS_SQ = 70 * 70;
CONST_FIRE_DIST_RADIUS_SQ = 50 * 50;
CONST_FIRE_HEIGHT = 80;

init() {
  level.solar_killstreak_duration = 30;

  level.solar_fire_fx = LoadFX("vfx/fire/fire_xsglow_runner_5s");

  level.solar_reflector_sfx = "mp_solar_array_player";
  level.solar_reflector_target_sfx = "mp_solar_array_target";

  level.killstreakFuncs["mp_solar"] = ::tryUseSolarReflector;
  level.mapKillStreak = "mp_solar";
  level.mapKillstreakPickupString = &"MP_SOLAR_MAP_KILLSTREAK_PICKUP";
  level.mapKillStreakDamageFeedbackSound = ::handleDamageFeedbackSound;

  level.mapCustomBotKillstreakFunc = ::setupBotsForMapKillstreak;

  level.killstreakWieldWeapons["killstreak_solar_mp"] = "mp_solar";
}

setupBotsForMapKillstreak() {
  level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_solar", maps\mp\bots\_bots_ks::bot_killstreak_never_use, maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
}

tryUseSolarReflector(lifeId, modules) {
  if(isDefined(level.solar_reflector_player)) {
    self iPrintLnBold(&"MP_SOLAR_REFLECTOR_IN_USE");
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

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak();
  if(result != "success") {
    return false;
  }
  self setUsingRemote("mp_solar");

  result = setSolarReflectorPlayer(self);

  if(isDefined(result) && result) {
    self maps\mp\_matchdata::logKillstreakEvent("mp_solar", self.origin);
  } else {
    if(self isUsingRemote()) {
      self clearUsingRemote();
    }
  }

  return (isDefined(result) && result);
}

setSolarReflectorPlayer(player) {
  self endon("solar_reflector_player_removed");

  level.solar_reflector_player = player;

  thread teamPlayerCardSplash("used_mp_solar", player);

  thread onPlayerConnect();
  thread setupPlayerDeath();

  player thread overlay();

  player thread runBeam();

  player thread removeSolarReflectorPlayerAfterTime(level.solar_killstreak_duration);
  player thread removeSolarReflectorPlayerWatch();
  player thread removeSolarReflectorLevelWatch();
  player thread removeSolarReflectorPlayerOnCommand();

  return true;
}

beamMinimap(ground_ent) {
  solar_reflector_friendShader = "compassping_orbitallaser_friendly";
  solar_reflector_foeShader = "compassping_orbitallaser_hostile";

  currentObj = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(currentObj, "invisible", (0, 0, 0));
  objective_OnEntity(currentObj, ground_ent);
  objective_state(currentObj, "active");
  if(level.teambased) {
    objective_team(currentObj, self.team);
  } else {
    objective_player(currentObj, self GetEntityNumber());
  }
  objective_icon(currentObj, solar_reflector_friendShader);
  friendlyObjID = currentObj;

  currentObj = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(currentObj, "invisible", (0, 0, 0));
  objective_OnEntity(currentObj, ground_ent);
  objective_state(currentObj, "active");
  if(level.teamBased) {
    objective_team(currentObj, level.otherTeam[self.team]);
  } else {
    objective_playerenemyteam(currentObj, self GetEntityNumber());
  }
  objective_icon(currentObj, solar_reflector_foeShader);
  enemyObjID = currentObj;

  level waittill("solar_reflector_player_removed");

  _objective_delete(friendlyObjID);
  _objective_delete(enemyObjID);
}

beamSounds(cam_ent, ground_ent) {
  waitframe();
  ground_ent playLoopSound(level.solar_reflector_target_sfx);
  cam_ent playLoopSound(level.solar_reflector_sfx);

  PlaySoundAtPos(cam_ent.origin, "array_beam_start");

  level waittill("solar_reflector_player_removed");

  PlaySoundAtPos(cam_ent.origin, "array_beam_stop");
  ground_ent StopLoopSound();
  cam_ent StopLoopSound();
}

runBeam() {
  cam_pos = GetStruct("solar_cam_pos", "targetname");
  beam_pos = GetStruct("solar_beam_pos", "targetname");
  ground_pos = GetStruct("solar_ground_pos", "targetname");

  ground_ent = getGroundEnt(ground_pos);

  cam_ent = getCameraEnt(cam_pos, ground_pos);
  self thread playerSetCamera(cam_ent);

  beam_ent = getBeamEnt(beam_pos, ground_pos);

  self thread beamMinimap(ground_ent);
  self thread beamSounds(cam_ent, ground_ent);

  runBeamUpdate(beam_ent, cam_ent, ground_ent);

  beam_ent.killCamEnt Delete();
  beam_ent Delete();
  cam_ent Delete();
  ground_ent Delete();
}

getCameraEnt(cam_pos, ground_pos) {
  cam_ent = spawn("script_model", cam_pos.origin);
  cam_ent.angles = VectorToAngles(ground_pos.origin - cam_pos.origin);
  cam_ent setModel("tag_player");

  return cam_ent;
}

getGroundEnt(ground_pos) {
  ground_ent = spawn("script_model", ground_pos.origin);
  ground_ent.angles = (0, 0, 0);
  ground_ent setModel("tag_origin");
  return ground_ent;
}

playerSetCamera(cam_ent) {
  cam_ent endon("death");

  if(GetDvarInt("test_mp_solar_killstreak_death", 0) != 0) {
    return;
  }

  self PlayerLinkWeaponViewToDelta(cam_ent, "tag_player", 1.0, 40, 40, 12, 10);
  self SetPlayerAngles(cam_ent GetTagAngles("tag_player"));

  self SetClientOmnvar("fov_scale", 0.2);
  self ThermalVisionFOFOverlayOn();

  while(1) {
    self EnableSlowAim(0.05, 0.05);

    level waittill("host_migration_begin");
    waitframe();
    self SetClientOmnvar("fov_scale", 0.2);
    self ThermalVisionFOFOverlayOn();
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }
}

getBeamEnt(beam_pos, ground_pos) {
  beam_ent = spawn("script_model", beam_pos.origin);
  beam_ent.angles = VectorToAngles(ground_pos.origin - beam_pos.origin);
  beam_ent setModel("tag_laser");
  beam_ent LaserOn("solar_laser");

  offset = (anglesToForward(beam_ent.angles) * 5000) - (0, 0, 100);
  killCamEnt = spawn("script_model", beam_pos.origin + offset);
  killCamEnt.angles = beam_ent.angles;
  killCamEnt LinkTo(beam_ent);
  beam_ent.killCamEnt = killCamEnt;

  return beam_ent;
}

beamGroundFx(ground_ent) {
  ground_ent endon("death");

  lastFX = undefined;
  while(1) {
    waitframe();

    if(!isDefined(ground_ent.surfacetype)) {
      continue;
    }

    nextFX = beamGetGroundFX(ground_ent.surfacetype);
    if(!isDefined(lastFX) || lastFX != nextFX) {
      if(isDefined(lastFX)) {
        stopFXOnTag(lastFX, ground_ent, "tag_origin");
      }

      playFXOnTag(nextFX, ground_ent, "tag_origin");

      lastFX = nextFX;
    }
  }
}

beamGetGroundFX(surfacetype) {
  switch (surfacetype) {
    case "water":
    case "water_waist":
      return getfx("steam_column_rising");
    default:
      return getfx("fx_flare_solar");
  }
}

runBeamUpdate(beam_ent, cam_ent, ground_ent) {
  self endon("solar_reflector_player_removed");

  speed = 300;
  trace_dist = 20000;

  beam_ent_pos = spawnStruct();
  beam_ent_pos.origin = ground_ent.origin;

  test_dvar = 0;

  test_dvar = GetDvarInt("test_mp_solar_killstreak_death", 0);
  if(test_dvar) {
    level.test_start_angles = cam_ent.angles;
  }

  while(1) {
    goal_angles = self GetPlayerAngles();

    if(test_dvar == 2) {
      offset = Sin((GetTime() / 1000) * 3.14 * 10) * 10;
      goal_angles = level.test_start_angles + (0, offset, 0);
    } else if(test_dvar != 0) {
      goal_angles = level.test_start_angles;
    }

    goal_angles = (goal_angles[0], goal_angles[1], 0);
    goal_dir = anglesToForward(goal_angles);

    goal_dist = abs((cam_ent.origin[2] - beam_ent_pos.origin[2]) / goal_dir[2]);
    goal_point = cam_ent.origin + goal_dir * goal_dist;

    move_dist = Distance2D(goal_point, beam_ent_pos.origin);

    if(move_dist <= speed * 0.05) {
      beam_ent_pos.origin = goal_point;
    } else {
      move_dir = goal_point - beam_ent_pos.origin;
      move_dir = VectorNormalize(move_dir);

      beam_ent_pos.origin += move_dir * speed * 0.05;
    }

    beam_dir = VectorNormalize(beam_ent_pos.origin - beam_ent.origin);

    beam_ent RotateTo(VectorToAngles(beam_dir), 0.1);

    start = beam_ent.origin;
    end = start + beam_dir * trace_dist;
    results = bulletTrace(start, end, false);

    Assert(results["fraction"] < 1.0);
    ground_ent MoveTo(results["position"], .1);
    ground_ent.surfacetype = results["surfacetype"];
    ground_ent.killCamEnt = beam_ent.killCamEnt;
    ground_ent RadiusDamage(ground_ent.origin, CONST_DAMAGE_RADIUS, CONST_DAMAGE_MAX, CONST_DAMAGE_MIN, self, "MOD_EXPLOSIVE", "killstreak_solar_mp");

    waitframe();
  }
}

handleDamageFeedbackSound() {
  self.shouldloopdamagefeedback = true;
  self.damagefeedbacktimer = 10;

  self PlayLocalSound("MP_solar_hit_alert");

  self PlayRumbleLoopOnEntity("damage_light");

  while(self.damagefeedbacktimer > 0) {
    self.damagefeedbacktimer--;
    wait(0.05);
  }

  self StopRumble("damage_light");
  self StopLocalSound("MP_solar_hit_alert");

  self.shouldloopdamagefeedback = undefined;
}

removeSolarReflectorPlayerOnCommand() {
  self endon("solar_reflector_player_removed");

  while(true) {
    button_hold_time = 0;
    while(self useButtonPressed()) {
      button_hold_time += 0.05;
      if(button_hold_time > 0.75) {
        level thread removeSolarReflectorPlayer(self);
        return;
      }
      waitframe();
    }
    waitframe();
  }
}

removeSolarReflectorPlayerWatch() {
  self endon("solar_reflector_player_removed");

  self waittill_any("disconnect", "joined_team", "joined_spectators", "spawned", "killstreak_exit");

  level thread removeSolarReflectorPlayer(self);
}

removeSolarReflectorLevelWatch() {
  self endon("solar_reflector_player_removed");

  level waittill("game_cleanup");

  level thread removeSolarReflectorPlayer(self);
}

removeSolarReflectorPlayerAfterTime(removeDelay) {
  self endon("solar_reflector_player_removed");

  wait 1;

  if(self _hasPerk("specialty_blackbox") && isDefined(self.specialty_blackbox_bonus)) {
    removeDelay *= self.specialty_blackbox_bonus;
  }

  self thread solarRelectorTimer(removeDelay);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(removeDelay);

  while(GetDvarInt("test_mp_solar_killstreak_death", 0) != 0) {
    waitframe();
  }

  level thread removeSolarReflectorPlayer(self);
}

solarRelectorTimer(removeDelay) {
  self endon("solar_reflector_player_removed");

  endTime = GetTime() + removeDelay * 1000;

  while(1) {
    self SetClientOmnvar("ui_solar_beam_timer", endTime);

    level waittill("host_migration_begin");

    timePassed = maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    endTime += timePassed;
  }
}

removeSolarReflectorPlayer(player) {
  player notify("solar_reflector_player_removed");
  level notify("solar_reflector_player_removed");

  waittillframeend;

  if(isDefined(player)) {
    player clearUsingRemote();

    player show();
    player unlink();

    player ThermalVisionFOFOverlayOff();
    player setBlurForPlayer(0, 0);
    player SetClientOmnvar("ui_solar_beam", 0);
    player DisableSlowAim();
    player SetClientOmnvar("fov_scale", 1);
  }

  level.solar_reflector_player = undefined;
}

overlay() {
  self endon("disconnect");
  level endon("solar_reflector_player_removed");

  wait 1;
  self setBlurForPlayer(1.2, 0);

  self SetClientOmnvar("ui_solar_beam", 1);
}

onPlayerConnect() {
  level notify("solarOnPlayerConnect");
  level endon("solarOnPlayerConnect");

  level endon("solar_reflector_player_removed");

  while(true) {
    level waittill("connected", player);

    player.preKilledFunc = ::playerPreKilled;
    player thread onPlayerSpawned();
    player thread playerImmuneToFire();
  }
}

onPlayerSpawned() {
  level notify("solarOnPlayerSpawned");
  level endon("solarOnPlayerSpawned");

  level endon("solar_reflector_player_removed");

  while(true) {
    self waittill("player_spawned");

    self.hideOnDeath = undefined;
  }
}

setupPlayerDeath() {
  foreach(player in level.players) {
    if(!isDefined(player) || player == level.solar_reflector_player) {
      continue;
    }

    player.preKilledFunc = ::playerPreKilled;
    player thread onPlayerSpawned();
  }
}

playerPlayVaporizeFX() {
  self.hideOnDeath = true;
  offset = (0, 0, 30);

  stance = self GetStance();
  if(stance == "crouch") {
    offset = (0, 0, 20);
  } else if(stance == "prone") {
    offset = (0, 0, 10);
  }

  playFX(getfx("solar_killstreak_death"), self.origin + offset);
}

playerPreKilled(eInflictor, attacker, victim, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, isFauxDeath) {
  if(sWeapon == "killstreak_solar_mp") {
    self playerPlayVaporizeFX();
  }
}

playerImmuneToFire() {
  self endon("disconnect");

  self.solarImmuneFire = true;

  wait CONST_FIRE_TIME;

  self.solarImmuneFire = undefined;
}

beamStartFires(ground_ent) {
  level endon("solar_reflector_player_removed");

  fireFxEnt = SpawnFx(level.solar_fire_fx, (0, 0, 0));

  lastFirePos = (0, 0, 0);
  lastFireTime = GetTime();

  while(true) {
    waitframe();

    distSq = Distance2DSquared(ground_ent.origin, lastFirePos);
    duration = (lastFireTime - GetTime()) / 1000;
    if(distSq > CONST_FIRE_DIST_RADIUS_SQ || duration > CONST_FIRE_TIME) {
      lastFirePos = ground_ent.origin;
      if(!isDefined(ground_ent.surfacetype) || !isStrStart(ground_ent.surfacetype, "water_")) {
        level thread fireAtPosition(lastFirePos, self);
      }

      lastFireTime = GetTime();
    }
  }
}

fireAtPosition(fireOrigin, killstreakPlayer) {
  playFX(level.solar_fire_fx, fireOrigin);

  endTime = GetTime() + (CONST_FIRE_TIME * 1000);

  while(GetTime() < endTime) {
    foreach(player in level.players) {
      if(isDefined(player.solarImmuneFire)) {
        continue;
      }

      if(player.origin[2] < (fireOrigin[2] - 5)) {
        continue;
      }

      if(player.origin[2] > (fireOrigin[2] + CONST_FIRE_HEIGHT)) {
        continue;
      }

      distSq = Distance2DSquared(player.origin, fireOrigin);

      if(distSq < CONST_FIRE_RADIUS_SQ) {
        player DoDamage(4, fireOrigin, killstreakPlayer, killstreakPlayer, "MOD_EXPLOSIVE", "killstreak_solar_mp");
      }
    }

    wait 0.1;
  }
}