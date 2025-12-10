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
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
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
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  var_02 = &"OBJECTIVES_WAR";
  var_03 = &"OBJECTIVES_WAR_SCORE";
  var_04 = &"OBJECTIVES_WAR_HINT";
  if(!level.teambased) {
    var_02 = &"OBJECTIVES_DM";
    var_03 = &"OBJECTIVES_DM_SCORE";
    var_04 = &"OBJECTIVES_DM_HINT";
  }

  scripts\mp\utility::setobjectivetext("allies", var_02);
  scripts\mp\utility::setobjectivetext("axis", var_02);
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", var_02);
    scripts\mp\utility::setobjectivescoretext("axis", var_02);
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", var_03);
    scripts\mp\utility::setobjectivescoretext("axis", var_03);
  }

  scripts\mp\utility::setobjectivehinttext("allies", var_04);
  scripts\mp\utility::setobjectivehinttext("axis", var_04);
  initspawns();
  cranked();
  var_05[0] = level.gametype;
  scripts\mp\gameobjects::main(var_05);
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
    var_00 = self.pers["team"];
    if(game["switchedsides"]) {
      var_00 = scripts\mp\utility::getotherteam(var_00);
    }

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      var_01 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_00 + "_start");
      var_02 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_01);
    } else {
      var_01 = scripts\mp\spawnlogic::getteamspawnpoints(var_00);
      var_02 = scripts\mp\spawnscoring::getspawnpoint(var_01);
    }
  } else {
    var_01 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
    if(level.ingraceperiod) {
      var_02 = scripts\mp\spawnlogic::getspawnpoint_random(var_02);
    } else {
      var_02 = scripts\mp\spawnscoring::getspawnpoint(var_02);
    }
  }

  return var_02;
}

onnormaldeath(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_00.cranked) && param_01 scripts\mp\utility::isenemy(param_00)) {
    param_01 scripts\mp\missions::processchallenge("ch_cranky");
  }

  param_00 cleanupcrankedtimer();
  var_05 = scripts\mp\rank::getscoreinfovalue("score_increment");
  if(isDefined(param_01.cranked)) {
    if(param_01.cranked_end_time - gettime() <= 1000) {
      param_01 scripts\mp\missions::processchallenge("ch_cranked_reset");
    }

    var_05 = var_05 * 2;
    var_06 = "kill_cranked";
    param_01 thread onkill(var_06);
    param_01.pers["killChains"]++;
    param_01 scripts\mp\persistence::statsetchild("round", "killChains", param_01.pers["killChains"]);
  } else if(scripts\mp\utility::isreallyalive(param_01)) {
    param_01 makecranked("begin_cranked");
  }

  if(isDefined(param_00.attackers) && !isDefined(level.assists_disabled)) {
    foreach(var_08 in param_00.attackers) {
      if(!isDefined(scripts\mp\utility::_validateattacker(var_08))) {
        continue;
      }

      if(var_08 == param_01) {
        continue;
      }

      if(param_00 == var_08) {
        continue;
      }

      if(!isDefined(var_08.cranked)) {
        continue;
      }

      var_08 thread onassist("assist_cranked");
    }
  }

  if(level.teambased) {
    level scripts\mp\gamescore::giveteamscoreforobjective(param_01.pers["team"], var_05, 0);
    return;
  }

  var_0A = 0;
  foreach(var_08 in level.players) {
    if(isDefined(var_08.destroynavrepulsor) && var_08.destroynavrepulsor > var_0A) {
      var_0A = var_08.destroynavrepulsor;
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
    var_00 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_00 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    var_00 = "axis";
  } else {
    var_00 = "allies";
  }

  thread scripts\mp\gamelogic::endgame(var_00, game["end_reason"]["time_limit_reached"]);
}

onplayerscore(param_00, param_01) {
  if(param_00 != "super_kill" && issubstr(param_00, "kill")) {
    var_02 = scripts\mp\rank::getscoreinfovalue("score_increment");
    if(isDefined(param_01.cranked)) {
      var_02 = var_02 * 2;
    }

    return var_02;
  }

  return 0;
}

cranked() {
  level.crankedbombtimer = 30;
}

makecranked(param_00) {
  scripts\mp\utility::leaderdialogonplayer(param_00);
  thread scripts\mp\rank::scoreeventpopup(param_00);
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

onkill(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  while(!isDefined(self.pers)) {
    wait(0.05);
  }

  thread scripts\mp\utility::giveunifiedpoints(param_00);
  setcrankedbombtimer("kill");
}

onassist(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  thread scripts\mp\rank::scoreeventpopup(param_00);
  setcrankedbombtimer("assist");
}

watchbombtimer(param_00) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_01 = 5;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00 - var_01 - 1);
  scripts\mp\utility::leaderdialogonplayer("five_seconds_left");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  while(var_01 > 0) {
    self playsoundtoplayer("mp_cranked_countdown", self);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
    var_01--;
  }

  if(isDefined(self) && scripts\mp\utility::isreallyalive(self)) {
    self playSound("frag_grenade_explode");
    playFX(level.mine_explode, self.origin + (0, 0, 32));
    scripts\mp\utility::_suicide();
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  }
}

setcrankedbombtimer(param_00) {
  var_01 = level.crankedbombtimer;
  if(param_00 == "assist") {
    var_01 = int(min(self.cranked_end_time - gettime() / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
  }

  var_02 = var_01 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_02);
  self.cranked_end_time = var_02;
  thread watchcrankedhostmigration();
  thread watchbombtimer(var_01);
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
  var_00 = scripts\mp\hostmigration::waittillhostmigrationdone();
  self setclientomnvar("ui_cranked_timer_stopped", 0);
  if(self.cranked_end_time + var_00 < 5) {
    self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  }

  if(var_00 > 0) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var_00);
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