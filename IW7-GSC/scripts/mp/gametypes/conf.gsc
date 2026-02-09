/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\conf.gsc
*********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
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
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
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
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_CONF");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_CONF");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_CONF");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_CONF");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_CONF_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_CONF_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_CONF_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_CONF_HINT");
  initspawns();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  level.dogtagenemyonusecb = ::dogtagenemyonusecb;
  var_2[0] = level.gametype;
  scripts\mp\gameobjects::main(var_2);
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
  var_0 = self.pers["team"];
  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility::getotherteam(var_0);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_2);
    var_3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_1);
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_3);
  }

  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

onspawnplayer() {
  scripts\mp\utility::func_98D4();
}

dogtagallyonusecb(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility::setextrascore1(var_0.pers["denied"]);
    var_0 scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["team"], level.scoredeny, 0);
  }
}

dogtagenemyonusecb(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);
    var_0 scripts\mp\utility::setextrascore0(var_0.pers["confirmed"]);
  }

  var_0 scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["team"], level.scoreconfirm, 0);
}