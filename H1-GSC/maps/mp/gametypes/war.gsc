/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\war.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 75);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.teambased = 1;
  level.classicgamemode = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  game["dialog"]["gametype"] = "team_deathmtch";
  game["strings"]["overtime_hint"] = & "MP_FIRST_BLOOD";
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_war_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("war", 0, 0, 9);
  setdynamicdvar("scr_war_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("war", 1);
  setdynamicdvar("scr_war_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("war", 1);
  setdynamicdvar("scr_war_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("war", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_WAR");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_WAR");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_WAR");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_WAR_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_WAR_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_WAR_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_WAR_HINT");
  initspawns();
  var_2[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_2);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"])
    var_0 = maps\mp\_utility::getotherteam(var_0);

  if(level.usestartspawns && level.ingraceperiod)
    var_1 = maps\mp\gametypes\_spawnlogic::getbeststartspawn("mp_tdm_spawn_" + var_0 + "_start");
  else {
    var_2 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_2, var_0);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_1);
  return var_1;
}

onnormaldeath(var_0, var_1, var_2) {
  level maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_1.pers["team"], 1);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]])
    var_1.finalkill = 1;
}