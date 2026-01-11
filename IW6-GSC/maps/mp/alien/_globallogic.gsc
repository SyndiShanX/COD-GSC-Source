/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_globallogic.gsc
******************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.splitscreen = isSplitScreen();
  set_console_status();

  level.onlineGame = getDvarInt("onlinegame");
  level.rankedMatch = ((level.onlineGame && !getDvarInt("xblive_privatematch")) || GetDvarInt("force_ranking"));

  if(getdvarint("scr_forcerankedmatch") == 1) {
    level.onlineGame = true;
    level.rankedMatch = true;
  }

  level.script = toLower(getDvar("mapname"));
  level.gametype = toLower(getDvar("g_gametype"));

  level.teamNameList = ["axis", "allies"];

  level.otherTeam["allies"] = "axis";
  level.otherTeam["axis"] = "allies";

  level.multiTeamBased = false;

  level.teamBased = false;

  level.objectiveBased = false;

  level.endGameOnTimeLimit = true;

  level.showingFinalKillcam = false;

  level.tiSpawnDelay = getDvarInt("scr_tispawndelay");

  if(!isDefined(level.tweakablesInitialized)) {
    maps\mp\gametypes\_tweakables::init();
  }

  level.halftimeType = "halftime";
  level.halftimeSubCaption = &"MP_SWITCHING_SIDES";

  level.lastStatusTime = 0;
  level.wasWinning = "none";

  level.lastSlowProcessFrame = 0;

  level.placement["allies"] = [];
  level.placement["axis"] = [];
  level.placement["all"] = [];

  level.postRoundTime = 5.0;

  level.playersLookingForSafeSpawn = [];

  registerDvars();

  mapLeaderboard = " LB_" + getdvar("ui_mapname");
  if(GetDvarInt("scr_chaos_mode") == 1) {
    mapLeaderboard += "_CHAOS";
  }
  if(getDvarInt("sv_maxclients") == 1) {
    mapLeaderboard += "_SOLO";
  }
  else {
    mapLeaderboard += "_COOP";
  }

  mapEscapesLeaderboard = " LB_" + getdvar("ui_mapname") + "_ESCAPES";

  if(getDvarInt("scr_aliens_hardcore")) {
    mapLeaderboard += "_HC";
  }

  if(GetDvarInt("scr_chaos_mode") == 1) {
    globalLeaderboard = "LB_GB_ALIEN_CHAOS";
    if(getDvarInt("sv_maxclients") == 1) {
      globalLeaderboard += "_SOLO";
    }
    else {
      globalLeaderboard += "_COOP";
    }
    precacheLeaderboards(globalLeaderboard + mapLeaderboard);
  } else
    precacheLeaderboards("LB_GB_ALIEN_HIVES LB_GB_ALIEN_KILLS LB_GB_ALIEN_REVIVES LB_GB_ALIEN_DOWNED LB_GB_ALIEN_XP LB_GB_ALIEN_SCORE LB_GB_ALIEN_CHALLENGES LB_GB_ALIEN_CASHFLOW" + mapLeaderboard + mapEscapesLeaderboard);

  level.teamCount["allies"] = 0;
  level.teamCount["axis"] = 0;
  level.teamCount["spectator"] = 0;

  level.aliveCount["allies"] = 0;
  level.aliveCount["axis"] = 0;
  level.aliveCount["spectator"] = 0;

  level.livesCount["allies"] = 0;
  level.livesCount["axis"] = 0;

  level.oneLeftTime = [];

  level.hasSpawned["allies"] = 0;
  level.hasSpawned["axis"] = 0;

  if(getdvarint("scr_runlevelandquit") == 1) {
    thread runLevelAndQuit();
  }

  max_possible_teams = 9;
  init_multiTeamData(max_possible_teams);
}

init_multiTeamData(max_num_teams) {
  for(i = 0; i < max_num_teams; i++) {
    team_name = "team_" + i;

    level.placement[team_name] = [];

    level.teamCount[team_name] = 0;
    level.aliveCount[team_name] = 0;
    level.livesCount[team_name] = 0;
    level.hasSpawned[team_name] = 0;
  }
}

runLevelAndQuit() {
  wait 1;
  while(level.players.size < 1) {
    wait 0.5;
  }
  wait 0.5;
  level notify("game_ended");
  exitLevel();
}

registerDvars() {
  SetOmnvar("ui_bomb_timer", 0);
  if(getDvar("r_reflectionProbeGenerate") != "1") {
    SetOmnvar("ui_nuke_end_milliseconds", 0);
  }
  SetDvar("ui_danger_team", "");
  SetDvar("ui_inhostmigration", 0);
  SetDvar("ui_inprematch", 0);
  SetDvar("ui_override_halftime", 0);
  SetDvar("camera_thirdPerson", getDvarInt("scr_thirdPerson"));
  SetDvar("scr_alien_intel_pillage", 0);
}

SetupCallbacks() {
  level.onXPEvent = ::onXPEvent;

  level.getSpawnPoint = ::blank;
  level.onSpawnPlayer = ::blank;
  level.onRespawnDelay = ::blank;

  level.onTimeLimit = maps\mp\gametypes\_gamelogic::default_onTimeLimit;
  level.onHalfTime = maps\mp\gametypes\_gamelogic::default_onHalfTime;
  level.onDeadEvent = maps\mp\gametypes\_gamelogic::default_onDeadEvent;
  level.onOneLeftEvent = maps\mp\gametypes\_gamelogic::default_onOneLeftEvent;

  level.onPrecacheGametype = ::blank;
  level.onStartGameType = ::blank;
  level.onPlayerKilled = ::blank;

  level.killStreakInit = ::blank;
  level.matchEventsInit = ::blank;
  level.intelInit = ::blank;

  level.devInit = maps\mp\alien\_dev::init;
}

blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {}

xpRateThread() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  gameFlagWait("prematch_done");

  for(;;) {
    wait(5.0);
    if(level.players[0].pers["team"] == "allies" || level.players[0].pers["team"] == "axis") {
      self maps\mp\gametypes\_rank::giveRankXP("kill", int(min(getDvarInt("scr_xprate"), 50)));
    }
  }
}

testMenu() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    wait(10.0);

    notifyData = spawnStruct();
    notifyData.titleText = &"MP_CHALLENGE_COMPLETED";
    notifyData.notifyText = "wheee";
    notifyData.sound = "mp_challenge_complete";

    self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
  }
}

testShock() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    wait(3.0);

    numShots = randomInt(6);

    for(i = 0; i < numShots; i++) {
      iPrintLnBold(numShots);
      self shellShock("frag_grenade_mp", 0.2);
      wait(0.1);
    }
  }
}

onXPEvent(event) {
  self thread maps\mp\gametypes\_rank::giveRankXP(event);
}

debugLine(start, end) {
  for(i = 0; i < 50; i++) {
    line(start, end);
    wait .05;
  }
}