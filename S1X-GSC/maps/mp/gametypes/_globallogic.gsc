/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_globallogic.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.splitscreen = isSplitScreen();
  level.ps3 = (getDvar("ps3Game") == "true");
  level.xenon = (getDvar("xenonGame") == "true");
  level.console = getDvar("consoleGame") == "true";

  level.onlineGame = IsOnlineGame();
  level.rankedMatch = (level.onlineGame && !getDvarInt("xblive_privatematch"));
  level.practiceRound = GetDvarInt("practiceroundgame");

  if(getdvarint("force_ranking") == 1) {
    level.onlineGame = true;
    level.rankedMatch = true;
  }

  level.script = toLower(getDvar("mapname"));
  if(GetDvarInt("virtualLobbyActive", 0)) {
    level.gametype = "vlobby";
  } else {
    level.gametype = toLower(getDvar("g_gametype"));
  }

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

  precacheString(&"MP_HALFTIME");
  precacheString(&"MP_OVERTIME");
  precacheString(&"MP_ROUNDEND");
  precacheString(&"MP_INTERMISSION");
  precacheString(&"MP_SWITCHING_SIDES");
  precacheString(&"MP_FRIENDLY_FIRE_WILL_NOT");
  precacheString(&"MP_SUICIDE_PUNISHED");
  precacheString(&"PLATFORM_REVIVE");

  precacheString(&"MP_OBITUARY_NEUTRAL");
  precacheString(&"MP_OBITUARY_FRIENDLY");
  precacheString(&"MP_OBITUARY_ENEMY");

  if(level.splitScreen) {
    precacheString(&"MP_ENDED_GAME");
  } else {
    precacheString(&"MP_HOST_ENDED_GAME");
  }

  level.halftimeType = "halftime";
  level.halfTimeOnScoreLimit = false;

  level.lastStatusTime = 0;
  level.wasWinning = "none";

  level.lastSlowProcessFrame = 0;

  level.placement["allies"] = [];
  level.placement["axis"] = [];
  level.placement["all"] = [];

  level.postRoundTime = 5.0;
  if(practiceRoundGame()) {
    level.postRoundTime = 0.0;
  }

  level.playersLookingForSafeSpawn = [];

  registerDvars();

  precacheModel("tag_origin");

  if(!level.practiceRound && (matchMakingGame() || (level.gametype == "horde" && level.onlineGame))) {
    mapLeaderboard = " LB_MAP_" + getDvar("ui_mapname");

    gamemodeLeaderboard = " LB_GM_" + level.gametype;

    if(getDvarInt("g_hardcore")) {
      gamemodeLeaderboard += "_HC";
    } else if(!isAugmentedGameMode()) {
      gamemodeLeaderboard += "_CL";
    }

    if(level.gametype == "horde" && level.onlineGame) {
      precacheLeaderboards("LB_GM_HORDE LB_GM_HORDE_BESTS");
    } else {
      precacheLeaderboards("LB_GB_TOTALXP_AT LB_GB_TOTALXP_LT LB_GB_WINS_AT LB_GB_WINS_LT LB_GB_KILLS_AT LB_GB_KILLS_LT LB_GB_ACCURACY_AT LB_ACCOLADES" + gamemodeLeaderboard + mapLeaderboard);
    }
  }

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
  SetOmnvar("ui_nuke_end_milliseconds", 0);
  setDvar("ui_danger_team", "");
  setDvar("ui_inhostmigration", 0);

  setDvar("camera_thirdPerson", getDvarInt("scr_thirdPerson"));
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

  level.autoassign = maps\mp\gametypes\_menus::autoAssign;
}

blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {}

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
  level thread maps\mp\gametypes\_rank::awardGameEvent(event, self);
}

debugLine(start, end) {
  for(i = 0; i < 50; i++) {
    line(start, end);
    wait .05;
  }
}