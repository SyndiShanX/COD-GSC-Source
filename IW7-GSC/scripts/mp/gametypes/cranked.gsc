/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cranked.gsc
********************************************/

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
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 100);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.teambased = getdvarint("scr_cranked_teambased", 1) == 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  if(!level.teambased) {
    level.onplayerscore = ::onplayerscore;
    setdvar("scr_cranked_scorelimit", getdvarint("scr_cranked_scorelimit_ffa", 60));
    setteammode("ffa");
  }

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "cranked";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "crnk_hint";
  game["dialog"]["begin_cranked"] = "crnk_cranked";
  game["dialog"]["five_seconds_left"] = "crnk_det";
  game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_cranked_roundswitch", 0);
  scripts\mp\utility::registerroundswitchdvar("cranked", 0, 0, 9);
  setdynamicdvar("scr_cranked_roundlimit", 1);
  scripts\mp\utility::registerroundlimitdvar("cranked", 1);
  setdynamicdvar("scr_cranked_winlimit", 1);
  scripts\mp\utility::registerwinlimitdvar("cranked", 1);
  setdynamicdvar("scr_cranked_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("cranked", 0);
  setdynamicdvar("scr_cranked_promode", 0);
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

  var_2 = &"OBJECTIVES_WAR";
  var_3 = &"OBJECTIVES_WAR_SCORE";
  var_4 = &"OBJECTIVES_WAR_HINT";
  if(!level.teambased) {
    var_2 = &"OBJECTIVES_DM";
    var_3 = &"OBJECTIVES_DM_SCORE";
    var_4 = &"OBJECTIVES_DM_HINT";
  }

  scripts\mp\utility::setobjectivetext("allies", var_2);
  scripts\mp\utility::setobjectivetext("axis", var_2);
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", var_2);
    scripts\mp\utility::setobjectivescoretext("axis", var_2);
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", var_3);
    scripts\mp\utility::setobjectivescoretext("axis", var_3);
  }

  scripts\mp\utility::setobjectivehinttext("allies", var_4);
  scripts\mp\utility::setobjectivehinttext("axis", var_4);
  initspawns();
  cranked();
  var_5[0] = level.gametype;
  scripts\mp\gameobjects::main(var_5);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  if(level.teambased) {
    scripts\mp\spawnlogic::setactivespawnlogic("TDM");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  if(level.teambased) {
    var_0 = self.pers["team"];
    if(game["switchedsides"]) {
      var_0 = scripts\mp\utility::getotherteam(var_0);
    }

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
      var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    } else {
      var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
      var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1);
    }
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
    if(level.ingraceperiod) {
      var_2 = scripts\mp\spawnlogic::getspawnpoint_random(var_2);
    } else {
      var_2 = scripts\mp\spawnscoring::getspawnpoint(var_2);
    }
  }

  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0.cranked) && var_1 scripts\mp\utility::isenemy(var_0)) {
    var_1 scripts\mp\missions::processchallenge("ch_cranky");
  }

  var_0 cleanupcrankedtimer();
  var_5 = scripts\mp\rank::getscoreinfovalue("score_increment");
  if(isDefined(var_1.cranked)) {
    if(var_1.cranked_end_time - gettime() <= 1000) {
      var_1 scripts\mp\missions::processchallenge("ch_cranked_reset");
    }

    var_5 = var_5 * 2;
    var_6 = "kill_cranked";
    var_1 thread onkill(var_6);
    var_1.pers["killChains"]++;
    var_1 scripts\mp\persistence::statsetchild("round", "killChains", var_1.pers["killChains"]);
  } else if(scripts\mp\utility::isreallyalive(var_1)) {
    var_1 makecranked("begin_cranked");
  }

  if(isDefined(var_0.attackers) && !isDefined(level.assists_disabled)) {
    foreach(var_8 in var_0.attackers) {
      if(!isDefined(scripts\mp\utility::_validateattacker(var_8))) {
        continue;
      }

      if(var_8 == var_1) {
        continue;
      }

      if(var_0 == var_8) {
        continue;
      }

      if(!isDefined(var_8.cranked)) {
        continue;
      }

      var_8 thread onassist("assist_cranked");
    }
  }

  if(level.teambased) {
    level scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_5, 0);
    return;
  }

  var_0A = 0;
  foreach(var_8 in level.players) {
    if(isDefined(var_8.destroynavrepulsor) && var_8.destroynavrepulsor > var_0A) {
      var_0A = var_8.destroynavrepulsor;
    }
  }
}

cleanupcrankedtimer() {
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
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

onplayerscore(var_0, var_1) {
  if(var_0 != "super_kill" && issubstr(var_0, "kill")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("score_increment");
    if(isDefined(var_1.cranked)) {
      var_2 = var_2 * 2;
    }

    return var_2;
  }

  return 0;
}

cranked() {
  level.crankedbombtimer = 30;
}

makecranked(var_0) {
  scripts\mp\utility::leaderdialogonplayer(var_0);
  thread scripts\mp\rank::scoreeventpopup(var_0);
  setcrankedbombtimer("kill");
  self.cranked = 1;
  scripts\mp\utility::giveperk("specialty_fastreload");
  scripts\mp\utility::giveperk("specialty_quickdraw");
  scripts\mp\utility::giveperk("specialty_fastoffhand");
  scripts\mp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility::giveperk("specialty_marathon");
  scripts\mp\utility::giveperk("specialty_quickswap");
  scripts\mp\utility::giveperk("specialty_stalker");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

onkill(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  while(!isDefined(self.pers)) {
    wait(0.05);
  }

  thread scripts\mp\utility::giveunifiedpoints(var_0);
  setcrankedbombtimer("kill");
}

onassist(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  thread scripts\mp\rank::scoreeventpopup(var_0);
  setcrankedbombtimer("assist");
}

watchbombtimer(var_0) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = 5;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0 - var_1 - 1);
  scripts\mp\utility::leaderdialogonplayer("five_seconds_left");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  while(var_1 > 0) {
    self playsoundtoplayer("mp_cranked_countdown", self);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
    var_1--;
  }

  if(isDefined(self) && scripts\mp\utility::isreallyalive(self)) {
    self playSound("frag_grenade_explode");
    playFX(level.mine_explode, self.origin + (0, 0, 32));
    scripts\mp\utility::_suicide();
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  }
}

setcrankedbombtimer(var_0) {
  var_1 = level.crankedbombtimer;
  if(var_0 == "assist") {
    var_1 = int(min(self.cranked_end_time - gettime() / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
  }

  var_2 = var_1 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_2);
  self.cranked_end_time = var_2;
  thread watchcrankedhostmigration();
  thread watchbombtimer(var_1);
  thread watchendgame();
}

watchcrankedhostmigration() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  level waittill("host_migration_begin");
  self setclientomnvar("ui_cranked_timer_stopped", 1);
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();
  self setclientomnvar("ui_cranked_timer_stopped", 0);
  if(self.cranked_end_time + var_0 < 5) {
    self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  }

  if(var_0 > 0) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var_0);
    return;
  }

  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time);
}

watchendgame() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      break;
    }

    wait(0.1);
  }
}