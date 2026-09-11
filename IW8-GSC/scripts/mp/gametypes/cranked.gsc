/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cranked.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function onplayerconnect(var_0) {
  thread onplayerspawned();
}

function onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
  }
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_cranked_roundswitch", 0);
  scripts\mp\utility\game::registerroundswitchdvar("cranked", 0, 0, 9);
  setdynamicdvar("scr_cranked_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("cranked", 1);
  setdynamicdvar("scr_cranked_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("cranked", 1);
  setdynamicdvar("scr_cranked_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("cranked", 0);
  setdynamicdvar("scr_cranked_promode", 0);
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

  var_2 = &"OBJECTIVES/WAR";
  var_3 = &"OBJECTIVES/WAR_SCORE";
  var_4 = &"OBJECTIVES/WAR_HINT";

  if(!level.teambased) {
    var_2 = &"OBJECTIVES/DM";
    var_3 = &"OBJECTIVES/DM_SCORE";
    var_4 = &"OBJECTIVES/DM_HINT";
  }

  foreach(var_6 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_6, var_2);

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_6, var_2);
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_6, var_3);
    }

    scripts\mp\utility\game::setobjectivehinttext(var_6, var_4);
  }

  initspawns();
  cranked();
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(level.teambased) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::registerspawnset("normal", "mp_tdm_spawn");
    scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
    scripts\mp\spawnlogic::registerspawnset("normal", "mp_dm_spawn");
    scripts\mp\spawnlogic::registerspawnset("fallback", "mp_dm_spawn_secondary");
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  if(level.teambased) {
    var_0 = self.pers["team"];

    if(game["switchedsides"]) {
      var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
    }

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
      var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    } else {
      var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "normal", "fallback");
    }
  } else if(level.ingraceperiod) {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
    var_2 = scripts\mp\spawnlogic::getspawnpoint_random(var_1);
  } else {
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "normal", "fallback");
  }

  return var_2;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  cleanupcrankedtimer(var_0);
  var_6 = scripts\mp\rank::getscoreinfovalue("score_increment");

  if(isDefined(var_1.cranked)) {
    var_6 *= 2;
    var_7 = "kill_cranked";
    thread onkill(var_1);
    var_1.pers["killChains"]++;
    var_1 scripts\mp\persistence::statsetchild("round", "killChains", var_1.pers["killChains"]);
  } else if(scripts\mp\utility\player::isreallyalive(var_1)) {
    makecranked(var_1, "begin_cranked");
  }

  if(isDefined(var_0.attackers) && !isDefined(level.assists_disabled)) {
    foreach(var_9 in var_0.attackers) {
      if(var_9 == var_1) {
        continue;
      }

      if(var_0 == var_9) {
        continue;
      }

      if(!isDefined(var_9.cranked)) {
        continue;
      }

      thread onassist(var_9);
      LOC_000000f8:
    }
  }

  if(level.teambased) {
    level scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_6, 0);
    return;
  }

  var_11 = 0;

  foreach(var_9 in level.players) {
    if(isDefined(var_9.score) && var_9.score > var_11) {
      var_11 = var_9.score;
    }
  }
}

function cleanupcrankedtimer() {
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
}

function ontimelimit() {
  var_0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if(var_0 == "tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

function onplayerscore(var_0, var_1) {
  if(var_0 != "super_kill" && issubstr(var_0, "kill")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("score_increment");

    if(isDefined(var_1.cranked)) {
      var_2 *= 2;
    }

    return var_2;
  }

  return 0;
}

function cranked() {
  level.crankedbombtimer = 30;
}

function makecranked(var_0) {
  scripts\mp\utility\dialog::leaderdialogonplayer(var_0);
  thread scripts\mp\rank::scoreeventpopup(var_0);
  setcrankedbombtimer("kill");
  self.cranked = 1;
  scripts\mp\utility\perk::giveperk("specialty_fastreload");
  scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  scripts\mp\utility\perk::giveperk("specialty_fastoffhand");
  scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::giveperk("specialty_marathon");
  scripts\mp\utility\perk::giveperk("specialty_quickswap");
  scripts\mp\utility\perk::giveperk("specialty_stalker");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

function onkill(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  thread scripts\mp\utility\points::giveunifiedpoints(var_0);
  setcrankedbombtimer("kill");
}

function onassist(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  thread scripts\mp\rank::scoreeventpopup(var_0);
  setcrankedbombtimer("assist");
}

function watchbombtimer(var_0) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_1 = 5;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0 - var_1 - 1);
  scripts\mp\utility\dialog::leaderdialogonplayer("five_seconds_left");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);

  while(var_1 > 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
    var_1--;
  }

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self)) {
    self playSound("frag_grenade_expl_trans");
    scripts\mp\utility\damage::_suicide();
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
    return;
  }
}

function setcrankedbombtimer(var_0) {
  var_1 = level.crankedbombtimer;

  if(var_0 == "assist") {
    var_1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
  }

  var_2 = var_1 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_2);
  self.cranked_end_time = var_2;
  thread watchcrankedhostmigration();
  thread watchbombtimer(var_1);
  thread watchendgame();
}

function watchcrankedhostmigration() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death_or_disconnect");
  level waittill("host_migration_begin");
  self setclientomnvar("ui_cranked_timer_stopped", 1);
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();
  self setclientomnvar("ui_cranked_timer_stopped", 0);

  if(var_0 > 0) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var_0);
    return;
  }

  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time);
}

function watchendgame() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death_or_disconnect");

  for(;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      break;
    }

    wait 0.1;
  }
}