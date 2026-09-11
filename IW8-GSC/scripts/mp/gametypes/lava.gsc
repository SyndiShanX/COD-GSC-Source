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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/LAVA");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/LAVA");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/LAVA_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/LAVA_HINT");
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
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else {
    var1 = scripts\mp\spawnlogic::getteamspawnpoints(var2);
    var2 = undefined;
  }

  return var2;
}

function onsuicidedeath(var0) {
  var1 = scripts\mp\rank::getscoreinfovalue("score_increment");
  level scripts\mp\gamescore::giveteamscoreforobjective(scripts\mp\utility\game::getotherteam(var0.pers["team"])[0], var1, 0);
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
}

function ontimelimit() {
  var0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    var0 = "forfeit";
  } else if("tie") {
    var0 = "overtime";
  }

  thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["time_limit_reached"]);
}

function watchplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    watchplayeronground(var0);
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