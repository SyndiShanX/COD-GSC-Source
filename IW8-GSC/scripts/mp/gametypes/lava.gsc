/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\lava.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_lava_roundswitch", 0);
  scripts\mp\utility\game::registerroundswitchdvar("lava", 0, 0, 9);
  setdynamicdvar("scr_lava_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("lava", 1);
  setdynamicdvar("scr_lava_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("lava", 1);
  setdynamicdvar("scr_lava_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("lava", 0);
  setdynamicdvar("scr_lava_promode", 0);
}

function onstartgametype() {
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

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"OBJECTIVES/LAVA");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/LAVA");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/LAVA_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"OBJECTIVES/LAVA_HINT");
  }

  initspawns();
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_2);
    var_2 = undefined;
  }

  return var_2;
}

function onsuicidedeath(var_0) {
  var_1 = scripts\mp\rank::getscoreinfovalue("score_increment");
  level scripts\mp\gamescore::giveteamscoreforobjective(scripts\mp\utility\game::getotherteam(var_0.pers["team"])[0], var_1, 0);
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

function ontimelimit() {
  var_0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if("tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

function watchplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    watchplayeronground(var_0);
  }
}

function watchplayeronground() {
  self endon("disconnect");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self)) {
      if(self isonground() &!self iswallrunning()) {
        self dodamage(8, self.origin, self, undefined, "MOD_SUICIDE");
        wait 1;
      }
    }

    waitframe();
  }
}