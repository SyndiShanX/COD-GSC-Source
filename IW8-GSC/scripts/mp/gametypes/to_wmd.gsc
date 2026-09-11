/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_wmd.gsc
***********************************************/

function main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  }

  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = &onstartgametype;
}

function maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.startedfromtacops = 1;
  onstartgametype(1);
}

function maintacopsinit() {
  level.tacopssublevel = "to_wmd";
  level.currentmode = "to_wmd";
  setomnvar("ui_tac_ops_submode", level.currentmode);
}

function maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("to_wmd", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("to_wmd", 10);
    scripts\mp\utility\game::registerscorelimitdvar("to_wmd", 65);
    scripts\mp\utility\game::registerroundlimitdvar("to_wmd", 1);
    scripts\mp\utility\game::registerwinlimitdvar("to_wmd", 1);
    scripts\mp\utility\game::registernumlivesdvar("to_wmd", 0);
    scripts\mp\utility\game::registerhalftimedvar("to_wmd", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("to_wmd", 0);
    level.matchrules_damagemultiplier = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.ontimelimit = &scripts\mp\gamelogic::default_ontimelimit;
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_to_wmd_waverespawndelay", 5);
  setdynamicdvar("scr_conf_pointsPerConfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsPerDeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
}

function onstartgametype(var_0) {
  level.extratime = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 6);
  GscBinSkip1(0x45, 0, "dd");
}

function initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_towmd_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_towmd_spawn_axis", 1);
  var_0.to_wmd_spawns = [];
  var_0.to_wmd_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_towmd_spawn_allies");
  var_0.to_wmd_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_towmd_spawn_axis");

  if(var_0.to_wmd_spawns["allies"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
    var_0.to_wmd_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_allies");
  }

  if(var_0.to_wmd_spawns["axis"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
    var_0.to_wmd_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
    return;
  }
}

function getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["team"];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_0.to_wmd_spawns[var_1]);
  var_3 = undefined;
  return var_3;
}

function activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  scripts\mp\tac_ops_map::setactivemapconfig("to_wmd", "allies");
  scripts\mp\tac_ops_map::setactivemapconfig("to_wmd", "axis");
  level.getspawnpoint = &getspawnpoint;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

function onspawnplayer() {
  var_0 = 0;

  if(self.team == "allies") {
    var_0 = 1;
  } else if(self.team == "axis") {
    var_0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var_0);
}