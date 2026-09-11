/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_conf.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  level.tacopssublevel = "to_conf";
  level.currentmode = "to_conf";
  setomnvar("ui_tac_ops_submode", level.currentmode);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.ontimelimit = &scripts\mp\gamelogic::default_ontimelimit;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = &scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  scripts\mp\bots\bots_gametype_to_conf::setup_callbacks();
  scripts\mp\bots\bots_gametype_to_conf::setup_bot_conf();
  onstartgametype();
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_to_conf_waverespawndelay", 5);
  setdynamicdvar("scr_to_conf_waverespawndelay_alt", 10);
  setdynamicdvar("scr_conf_pointsPerConfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsPerDeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
}

function onstartgametype() {
  level.dogtagallyonusecb = &dogtagallyonusecb;
  level.dogtagenemyonusecb = &dogtagenemyonusecb;
  level.extratime = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 6);
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function updategametypedvars() {
  level.overridewatchdvars["scr_" + scripts\mp\utility\game::getgametype() + "_dogtags"] = 1;
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.scoreconfirm = scripts\mp\utility\dvars::dvarintvalue("pointsPerConfirm", 1, 0, 25);
  level.scoredeny = scripts\mp\utility\dvars::dvarintvalue("pointsPerDeny", 0, 0, 25);
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getteamspawnpoints(var0);
    var2 = undefined;
  } else {
    var1 = scripts\mp\spawnlogic::getteamspawnpoints(var2);
    var3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var2);
    var2 = undefined;
  }

  return var2;
}

function onnormaldeath(var0, var1, var2, var3, var4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4);
}

function onspawnplayer() {
  var0 = 0;

  if(self.team == "allies") {
    var0 = 1;
  } else if(self.team == "axis") {
    var0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var0);
}

function dogtagallyonusecb(var0) {
  if(isPlayer(var0)) {
    var0 scripts\mp\utility\stats::setextrascore1(var0.pers["denied"]);
    var0 scripts\mp\gamescore::giveteamscoreforobjective(var0.pers["team"], level.scoredeny, 0);
    return;
  }
}

function dogtagenemyonusecb(var0) {
  if(isPlayer(var0)) {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["confirmed"]);
  }

  var0 scripts\mp\gamescore::giveteamscoreforobjective(var0.pers["team"], level.scoreconfirm, 0);
}