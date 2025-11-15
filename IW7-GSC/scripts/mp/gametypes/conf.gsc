/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\conf.gsc
*****************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 65);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    scripts\mp\utility::registerdogtagsenableddvar(level.gametype, 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onspawnplayer = ::onspawnplayer;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "kill_confirmed";
  game["dialog"]["kill_confirmed"] = "kill_confirmed";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  level.conf_fx["vanish"] = loadfx("vfx\core\impacts\small_snowhit");
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_conf_pointsPerConfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsPerDeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  scripts\mp\utility::setobjectivetext("allies", & "OBJECTIVES_CONF");
  scripts\mp\utility::setobjectivetext("axis", & "OBJECTIVES_CONF");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_CONF");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_CONF");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_CONF_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_CONF_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", & "OBJECTIVES_CONF_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", & "OBJECTIVES_CONF_HINT");
  initspawns();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  level.dogtagenemyonusecb = ::dogtagenemyonusecb;
  var_02[0] = level.gametype;
  scripts\mp\gameobjects::main(var_02);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.scoreconfirm = scripts\mp\utility::dvarintvalue("pointsPerConfirm", 1, 0, 25);
  level.scoredeny = scripts\mp\utility::dvarintvalue("pointsPerDeny", 0, 0, 25);
}

getspawnpoint() {
  var_00 = self.pers["team"];
  if(game["switchedsides"]) {
    var_00 = scripts\mp\utility::getotherteam(var_00);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_01 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_00 + "_start");
    var_02 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_01);
  } else {
    var_01 = scripts\mp\spawnlogic::getteamspawnpoints(var_02);
    var_03 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_01);
    var_02 = scripts\mp\spawnscoring::getspawnpoint(var_01, var_03);
  }

  return var_02;
}

onnormaldeath(param_00, param_01, param_02, param_03, param_04) {
  scripts\mp\gametypes\common::onnormaldeath(param_00, param_01, param_02, param_03, param_04);
}

onspawnplayer() {
  scripts\mp\utility::func_98D4();
}

dogtagallyonusecb(param_00) {
  if(isplayer(param_00)) {
    param_00 scripts\mp\utility::setextrascore1(param_00.pers["denied"]);
    param_00 scripts\mp\gamescore::giveteamscoreforobjective(param_00.pers["team"], level.scoredeny, 0);
  }
}

dogtagenemyonusecb(param_00) {
  if(isplayer(param_00)) {
    param_00 scripts\mp\utility::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);
    param_00 scripts\mp\utility::setextrascore0(param_00.pers["confirmed"]);
  }

  param_00 scripts\mp\gamescore::giveteamscoreforobjective(param_00.pers["team"], level.scoreconfirm, 0);
}