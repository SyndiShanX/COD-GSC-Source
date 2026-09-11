/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_bhd.gsc
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
  level.tacopssublevel = "to_bhd";
  level.currentmode = "to_bhd";
  setomnvar("ui_tac_ops_submode", level.currentmode);
}

function maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("to_bhd", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("to_bhd", 10);
    scripts\mp\utility\game::registerscorelimitdvar("to_bhd", 65);
    scripts\mp\utility\game::registerroundlimitdvar("to_bhd", 1);
    scripts\mp\utility\game::registerwinlimitdvar("to_bhd", 1);
    scripts\mp\utility\game::registernumlivesdvar("to_bhd", 0);
    scripts\mp\utility\game::registerhalftimedvar("to_bhd", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("to_bhd", 0);
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
  setdynamicdvar("scr_to_bhd_waverespawndelay", 5);
  setdynamicdvar("scr_to_bhd_waverespawndelay_alt", 10);
  setdynamicdvar("scr_conf_pointsPerConfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsPerDeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
}

function onstartgametype(var_0) {
  GscBinSkip1(0x45, 0, "dd");
}

function initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tobhd_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tobhd_spawn_axis", 1);
  var_0.to_bhd_spawns = [];
  var_0.to_bhd_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_tobhd_spawn_allies");
  var_0.to_bhd_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_tobhd_spawn_axis");

  if(var_0.to_bhd_spawns["allies"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
    var_0.to_bhd_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_allies");
  }

  if(var_0.to_bhd_spawns["axis"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
    var_0.to_bhd_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
    return;
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["team"];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_0.to_blitz_spawns[var_1]);
  var_3 = undefined;
  return var_3;
}

function activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  scripts\mp\tac_ops_map::setactivemapconfig("to_bhd", "allies");
  scripts\mp\tac_ops_map::setactivemapconfig("to_bhd", "axis");
  level.getspawnpoint = &getspawnpoint;
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
  scripts\mp\tac_ops\roles_utility::kitspawn();
}