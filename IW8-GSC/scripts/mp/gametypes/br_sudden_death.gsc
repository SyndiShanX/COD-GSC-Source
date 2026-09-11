/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_sudden_death.gsc
****************************************************/

function init() {
  level.disable_super_in_turret.ref_1395e = [];
  level.disable_super_in_turret.ref_13962 = getdvarint("scr_br_sd_countdown", 15);
  level.disable_super_in_turret.ref_13960 = getdvarint("scr_br_sd_circle_delay", 0);
  level.disable_super_in_turret.ref_13961 = getdvarint("scr_br_sd_circle_index", 3);
  level.disable_super_in_turret.ref_1395f = getdvarint("scr_br_sd_circle_close", 1);
  scripts\mp\flags::gameflaginit("sudden_death_started", 0);
  scripts\mp\flags::gameflaginit("sudden_death_complete", 0);
}

function start(var_0) {
  addthrowingknifecharge();
  scripts\mp\flags::gameflagset("sudden_death_started");
  ambusher_spawn_func();
  adsoff(var_0);
  thread ampeddelta(var_0);
  level waittill("sudden_death_spawns_finished");
  thread anim_guy_keep_hidden(var_0);
  wait level.disable_super_in_turret.ref_13960 + level.disable_super_in_turret.ref_1395f;
  ai_operate_turret();
  adrenaline_crate_use();
  ally_manager();
  level.disablespawning = 1;
  scripts\mp\flags::gameflagwait("sudden_death_complete");
  return level.disable_super_in_turret.ref_1395e["losing_team"];
}

function addthrowingknifecharge() {
  scripts\mp\gametypes\br_gametypes::ref_13f25("playerKilledSpawn");

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
  }

  level.ondeadevent = &allowed_gametypes;
}

function ambusher_spawn_func() {
  foreach(var_1 in level.players) {
    var_1 scripts\mp\gametypes\br_public::ref_1264c();
  }
}

function adsoff(var_0) {
  if(isDefined(var_0.has_ammo_drain_passive)) {
    [[var_0.has_ammo_drain_passive]](var_0.ref_1367f);
    return;
  }
}

function ampeddelta(var_0) {
  foreach(var_2 in level.players) {
    var_2 notify("sudden_death_started");
    var_3 = var_2[[var_0.ref_13688]](var_0.ref_1367f);
    thread amped_wid(var_2);
  }

  wait 2;
  level notify("sudden_death_spawns_finished");
}

function amped_wid(var_0) {
  self endon("disconnect");
  self.ref_12ca8 = 1;
  self.plotarmor = 1;
  self.forcespawnorigin = var_0.origin;
  self.forcespawnangles = var_0.angles;
  scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  waitframe();
  scripts\mp\outofbounds::clearoob(self);
  scripts\mp\gametypes\br_armor::searchcirclesize(1);
  scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  self.ref_12ca8 = undefined;
}

function ai_operate_turret() {
  foreach(var_1 in level.players) {
    var_1 scripts\mp\playerlogic::playerprematchallow(0);
  }
}

function ally_manager() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\gametypes\br::defend_wave_2();
    var_1 scripts\mp\playerlogic::playerprematchallow(1);
    var_1.plotarmor = undefined;
    var_1 setclientomnvar("ui_match_start_countdown", 0);
    var_1 setclientomnvar("ui_match_in_progress", 1);
    thread ref_12696();
  }
}

function adrenaline_crate_use() {
  level scripts\mp\gamelogic::livelobbymatchstarttimer("match_starting_in", level.disable_super_in_turret.ref_13962);
}

function ref_12696() {
  self endon("disconnect");
  self setclientomnvar("ui_objective_text", 0);
  wait 5;
  self setclientomnvar("ui_objective_text", -1);
}

function anim_guy_keep_hidden(var_0) {
  level endon("game_ended");
  var_1 = var_0.guard_spawners;
  scripts\mp\gametypes\br_circle::teleport_players_inside_subway_car(var_1, level.disable_super_in_turret.ref_13960, level.disable_super_in_turret.ref_13961, level.disable_super_in_turret.ref_1395f, level.disable_super_in_turret.ref_13962);
}

function allowed_gametypes(var_0) {
  scripts\mp\gamelogic::default_ondeadevent(var_0);
  ai_ascender_getclosestascender(var_0);
}

function ai_ascender_getclosestascender(var_0) {
  level.disable_super_in_turret.ref_1395e["losing_team"] = var_0;
  scripts\mp\flags::gameflagset("sudden_death_complete");
}