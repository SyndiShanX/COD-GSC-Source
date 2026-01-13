/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\lava.gsc
*********************************************/

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
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 75);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onsuicidedeath = ::onsuicidedeath;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "tm_death";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
  level thread watchplayerconnect();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_lava_roundswitch", 0);
  scripts\mp\utility::registerroundswitchdvar("lava", 0, 0, 9);
  setdynamicdvar("scr_lava_roundlimit", 1);
  scripts\mp\utility::registerroundlimitdvar("lava", 1);
  setdynamicdvar("scr_lava_winlimit", 1);
  scripts\mp\utility::registerwinlimitdvar("lava", 1);
  setdynamicdvar("scr_lava_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("lava", 0);
  setdynamicdvar("scr_lava_promode", 0);
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

  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_LAVA");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_LAVA");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_LAVA");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_LAVA");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_LAVA_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_LAVA_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_LAVA_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_LAVA_HINT");
  initspawns();
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
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
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
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_2);
  }

  return var_2;
}

onsuicidedeath(var_0) {
  var_1 = scripts\mp\rank::getscoreinfovalue("score_increment");
  level scripts\mp\gamescore::giveteamscoreforobjective(scripts\mp\utility::getotherteam(var_0.pers["team"]), var_1, 0);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

ontimelimit() {
  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_0 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    var_0 = "axis";
  } else {
    var_0 = "allies";
  }

  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

watchplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 watchplayeronground();
  }
}

watchplayeronground() {
  self endon("disconnect");
  for(;;) {
    if(scripts\mp\utility::isreallyalive(self)) {
      if(self isonground() &!self iswallrunning()) {
        self dodamage(8, self.origin, self, undefined, "MOD_SUICIDE");
        wait(1);
      }
    }

    scripts\engine\utility::waitframe();
  }
}