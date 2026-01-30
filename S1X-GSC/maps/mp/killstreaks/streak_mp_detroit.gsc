/*****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_detroit.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\mp_detroit_events;

init() {
  level.killstreakWieldWeapons["detroit_tram_turret_mp"] = "mp_detroit";

  level.killstreakFuncs["mp_detroit"] = ::tryUseKillstreak;

  level.mapKillStreak = "mp_detroit";
  level.mapKillstreakPickupString = &"MP_DETROIT_MAP_KILLSTREAK_PICKUP";

  level.getAerialKillstreakArray = ::tramLockOnEntsForTeam;

  level.streak_trams = getEntArray("streak_tram", "targetname");
  array_thread(level.streak_trams, ::tram_init);
  array_thread(level.streak_trams, ::tram_killstreak_init);

  array_thread(level.streak_trams, ::tram_spline_debug);

  level.detroitTramObjIds = [];
  teams = ["allies", "axis"];
  foreach(team in teams) {
    level.detroitTramObjIds[team] = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(level.detroitTramObjIds[team], "invisible", (0, 0, 0));
    objective_icon(level.detroitTramObjIds[team], ter_op(team == "allies", "compass_objpoint_tram_turret_friendly", "compass_objpoint_tram_turret_enemy"));
  }
}

setupBotsForMapKillstreak() {
  level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_detroit", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tram_killstreak_init() {
  self.getStingerTargetPosFunc = ::tram_stinger_target_pos;
}

tram_stinger_target_pos() {
  return self GetTagOrigin("tag_turret");
}

tramLockOnEntsForTeam(team) {
  lockOnEnts = [];
  foreach(tram in level.streak_trams) {
    if(tram.active && isDefined(tram.owner) && (!level.teamBased || tram.owner.team == team)) {
      lockOnEnts[lockOnEnts.size] = tram;
    }
  }

  return lockOnEnts;
}

tryUseKillstreak(lifeId, modules) {
  if(level.fauxVehicleCount + 1 >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"MP_TOO_MANY_VEHICLES");
    return false;
  }

  killstreak_active = false;
  foreach(tram in level.streak_trams) {
    if(tram.active) {
      killstreak_active = true;
      break;
    } else {
      tram maps\mp\mp_detroit_events::tram_reset();
    }
  }

  killstreak_tram = undefined;
  if(!killstreak_active) {
    level.streak_trams = SortByDistance(level.streak_trams, self.origin);
    killstreak_tram = level.streak_trams[0];
  }

  if(isDefined(killstreak_tram)) {
    result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("mp_detroit_tram");
    if(result != "success") {
      return false;
    }

    incrementFauxVehicleCount();
    self thread run_tram_killstreak(killstreak_tram);
    return true;
  } else {
    self IPrintLnBold(&"MP_DETROIT_MAP_KILLSTREAK_NOT_AVAILABLE");
    return false;
  }
}

run_tram_killstreak(tram) {
  time = 35;
  tram maps\mp\mp_detroit_events::tram_reset();

  tram.owner = self;
  tram.team = self.team;
  tram.turret = tram spawn_tram_turret();
  tram.isLeaving = false;
  tram.stopDamageFunc = false;

  tram tram_show_icon();
  tram thread maps\mp\gametypes\_damage::setEntityDamageCallback(1000, undefined, ::tramOnDeath, undefined, true);

  self NotifyOnPlayerCommand("CancelTramStart", "+usereload");
  self NotifyOnPlayerCommand("CancelTramEnd", "-usereload");

  self setUsingRemote("mp_detroit_tram");

  self RemoteControlTurret(tram.turret, 30, tram.angles[1] - 90);
  tram thread tram_update_shooting_location();

  tram make_entity_sentient_mp(tram.team);

  self PlayerLinkWeaponViewToDelta(tram, "tag_player", 0, 180, 180, 0, 90, false);
  self PlayerLinkedSetViewZNear(false);

  self ThermalVisionFOFOverlayON();
  self SetClientOmnvar("ui_detroit_tram_turret", true);

  tram thread tram_killstreak_team_change_watch();
  tram thread tram_killstreak_cancel_watch();
  tram thread tram_killstreak_exit_watch();
  tram thread tram_killstreak_move(time);
  tram thread tram_killstreak_match_ended();
  tram thread maps\mp\killstreaks\_killstreaks::updateAerialKillStreakMarker();
}

tram_update_shooting_location() {
  player = self.owner;

  self endon("player_exit");
  player endon("disconnect");
  self.turret endon("death");

  self.target_ent = spawn("script_model", (0, 0, 0));
  self.target_ent setModel("tag_origin");
  self.turret TurretSetGroundAimEntity(self.target_ent);

  while(true) {
    startpoint = self.turret GetTagOrigin("tag_player");
    endpoint = self.turret GetTagOrigin("tag_player") + anglesToForward(self.turret GetTagAngles("tag_player")) * 20000;
    trace = bulletTrace(startpoint, endpoint, false, self.turret);

    point = trace["position"];

    self.target_ent.origin = point;

    waitframe();
  }
}

tram_killstreak_match_ended() {
  self endon("player_exit");
  level waittill("game_ended");
  self notify("player_exit");
}

tram_show_icon() {
  foreach(team, objId in level.detroitTramObjIds) {
    objective_state(objId, "active");
    if(team == "allies") {
      Objective_PlayerTeam(objId, self.owner GetEntityNumber());
    } else {
      Objective_PlayerEnemyTeam(objId, self.owner GetEntityNumber());
    }
    Objective_OnEntityWithRotation(objId, self.turret.obj_ent);
  }
}

tram_hide_icon() {
  foreach(team, objId in level.detroitTramObjIds) {
    objective_state(objId, "invisible");
  }
}

tramOnDeath(attacker, weapon, meansOfDeath, damage) {
  self notify("player_exit");

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "map_killstreak_destroyed", undefined, "callout_destroyed_tram_turet", true);

  waitframe();

  playFXOnTag(getfx("vehicle_pdrone_explosion"), self, "tag_turret");

  if(isDefined(self.turret)) {
    self.turret Delete();
  }
  if(isDefined(self.target_ent)) {
    self.target_ent Delete();
  }
}

tram_killstreak_cancel_watch() {
  player = self.owner;

  self endon("player_exit");
  player endon("disconnect");

  while(1) {
    player waittill("CancelTramStart");

    result = player waittill_any_timeout(1, "CancelTramEnd");

    if(result == "timeout") {
      self notify("player_exit");
    }
  }
}

tram_killstreak_team_change_watch() {
  player = self.owner;

  self endon("player_exit");
  player endon("disconnect");

  player waittill_any("joined_team", "joined_spectators");

  self notify("player_exit");
}

tram_killstreak_move(time) {
  self maps\mp\mp_detroit_events::tram_spline_move(time);

  self notify("player_exit");

  self waittill("trackEnd");

  if(isDefined(self.turret)) {
    self.turret Delete();
  }
  if(isDefined(self.target_ent)) {
    self.target_ent Delete();
  }
}

tram_killstreak_exit_watch() {
  self endon("disconnect");

  self waittill("player_exit");

  tram_hide_icon();

  self.owner SetClientOmnvar("ui_detroit_tram_turret", false);
  self.owner ThermalVisionFOFOverlayOff();

  self.owner unlink();
  self.owner RemoteControlTurretOff(self.turret);
  self FreeEntitySentient();
  self.owner clearUsingRemote();
  self.owner = undefined;
  self thread maps\mp\killstreaks\_killstreaks::updateAerialKillStreakMarker();
  self notify("leaving");
  self.isLeaving = true;
}

spawn_tram_turret() {
  linktotag = "tag_turret";

  spawned_turret = SpawnTurret("misc_turret", self.origin, "detroit_tram_turret_mp", false);
  spawned_turret.angles = (0, 0, 0);
  spawned_turret setModel("vehicle_xh9_warbird_turret_detroit_mp");
  spawned_turret SetDefaultDropPitch(45.0);
  spawned_turret LinkTo(self, linktotag, (0, 0, 0), (0, 0, 0));
  spawned_turret.owner = self.owner;
  spawned_turret.health = 99999;
  spawned_turret.maxHealth = 1000;
  spawned_turret.damageTaken = 0;
  spawned_turret.stunned = false;
  spawned_turret.stunnedTime = 0.0;
  spawned_turret setCanDamage(false);
  spawned_turret setCanRadiusDamage(false);
  spawned_turret.team = self.team;
  spawned_turret.pers["team"] = self.team;
  if(level.teamBased) {
    spawned_turret SetTurretTeam(self.team);
  }
  spawned_turret SetMode("sentry_manual");
  spawned_turret SetSentryOwner(self.owner);
  spawned_turret SetTurretMinimapVisible(false);
  spawned_turret.chopper = self;

  obj_ent = spawn("script_model", self.origin);
  obj_ent Linkto(spawned_turret, "tag_aim_pivot", (0, 0, 0), (0, 0, 0));
  obj_ent SetContents(0);
  spawned_turret thread delete_on_death(obj_ent);
  spawned_turret.obj_ent = obj_ent;

  return spawned_turret;
}