/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_globallogic.gsc
**********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_burnplayer;
#include maps\mp\_laststand;
#include maps\mp\_music;
#include maps\mp\_busing;
#include common_scripts\utility;

init() {
  if(!isDefined(level.tweakablesInitialized)) {
    maps\mp\gametypes\_tweakables::init();
  }

  if(getDvar("scr_player_sprinttime") == "") {
    setDvar("scr_player_sprinttime", getDvar("player_sprintTime"));
  }

  level.splitscreen = isSplitScreen();
  level.xenon = (getDvar("xenonGame") == "true");
  level.ps3 = (getDvar("ps3Game") == "true");
  level.onlineGame = getDvarInt("onlinegame");
  level.console = (level.xenon || level.ps3);

  level.rankedMatch = (level.onlineGame && !getDvarInt("xblive_privatematch"));

  if(getdvarint("scr_forcerankedmatch") == 1) {
    level.rankedMatch = true;
  }

  level.script = toLower(getDvar("mapname"));
  level.gametype = toLower(getDvar("g_gametype"));

  level.otherTeam["allies"] = "axis";
  level.otherTeam["axis"] = "allies";

  level.teamBased = false;

  level.overrideTeamScore = false;
  level.overridePlayerScore = false;
  level.displayHalftimeText = false;
  level.displayRoundEndText = true;

  level.endGameOnScoreLimit = true;
  level.endGameOnTimeLimit = true;
  level.scoreLimitIsPerRound = false;

  level.gameForfeited = false;

  precacheString(&"MP_HALFTIME");
  precacheString(&"MP_OVERTIME");
  precacheString(&"MP_ROUNDEND");
  precacheString(&"MP_INTERMISSION");
  precacheString(&"MP_SWITCHING_SIDES");
  precacheString(&"MP_FRIENDLY_FIRE_WILL_NOT");

  if(level.splitScreen) {
    precacheString(&"MP_ENDED_GAME");
  } else {
    precacheString(&"MP_HOST_ENDED_GAME");
  }

  level.halftimeType = "halftime";
  level.halftimeSubCaption = &"MP_SWITCHING_SIDES";

  level.lastStatusTime = 0;
  level.wasWinning = "none";

  level.lastSlowProcessFrame = 0;

  level.placement["allies"] = [];
  level.placement["axis"] = [];
  level.placement["all"] = [];

  level.postRoundTime = 7.0;

  level.inOvertime = false;

  level.dropTeam = getdvarint("sv_maxclients");

  registerDvars();
  maps\mp\gametypes\_class::initPerkDvars();

  level.oldschool = (getDvarInt("scr_oldschool") == 1);
  if(level.oldschool) {
    logString("game mode: oldschool");

    setDvar("jump_height", 64);
    setDvar("jump_slowdownEnable", 0);
    setDvar("bg_fallDamageMinHeight", 256);
    setDvar("bg_fallDamageMaxHeight", 512);
    setDvar("player_sprintUnlimited", 1);
    setDvar("player_clipSizeMultiplier", 2.0);
  }

  precacheModel("aircraft_bomb");
  precacheModel("tag_origin");

  precacheShader("faction_128_american");
  precacheShader("faction_128_german");
  precacheShader("faction_128_japan");
  precacheShader("faction_128_soviet");

  maps\mp\_burnplayer::initBurnPlayer();

  maps\mp\_laststand::initLastStand();

  if(!isDefined(game["tiebreaker"])) {
    game["tiebreaker"] = false;
  }
}

registerDvars() {
  if(getDvar("scr_oldschool") == "") {
    setDvar("scr_oldschool", "0");
  }

  makeDvarServerInfo("scr_oldschool");

  setDvar("ui_bomb_timer", 0);
  makeDvarServerInfo("ui_bomb_timer");

  if(!level.console) {
    if(getDvar("scr_show_unlock_wait") == "") {
      setDvar("scr_show_unlock_wait", 0.1);
    }

    if(getDvar("scr_intermission_time") == "") {
      setDvar("scr_intermission_time", 30.0);
    }
  }

  if(getDvar("scr_vehicle_damage_scalar") == "") {
    setDvar("scr_vehicle_damage_scalar", "1");
  }

  level.vehicleDamageScalar = getDvarFloat("scr_vehicle_damage_scalar");
  level.fire_audio_repeat_duration = getDvarInt("fire_audio_repeat_duration");
  level.fire_audio_random_max_duration = getDvarInt("fire_audio_random_max_duration");
}

SetupCallbacks() {
  level.spawnPlayer = ::spawnPlayer;
  level.spawnClient = ::spawnClient;
  level.spawnSpectator = ::spawnSpectator;
  level.spawnIntermission = ::spawnIntermission;
  level.onPlayerScore = ::default_onPlayerScore;
  level.onTeamScore = ::default_onTeamScore;

  level.onXPEvent = ::onXPEvent;
  level.waveSpawnTimer = ::waveSpawnTimer;

  level.onSpawnPlayer = ::blank;
  level.onSpawnPlayerUnified = ::blank;
  level.onSpawnSpectator = ::default_onSpawnSpectator;
  level.onSpawnIntermission = ::default_onSpawnIntermission;
  level.onRespawnDelay = ::blank;

  level.onForfeit = ::default_onForfeit;
  level.onTimeLimit = ::default_onTimeLimit;
  level.onScoreLimit = ::default_onScoreLimit;
  level.onDeadEvent = ::default_onDeadEvent;
  level.onOneLeftEvent = ::default_onOneLeftEvent;
  level.giveTeamScore = ::giveTeamScore;
  level.givePlayerScore = ::givePlayerScore;

  level.getTimeLimitDvarValue = ::default_getTimeLimitDvarValue;
  level.getTeamKillPenalty = ::default_getTeamKillPenalty;
  level.getTeamKillScore = ::default_getTeamKillScore;

  level._setTeamScore = ::_setTeamScore;
  level._setPlayerScore = ::_setPlayerScore;

  level._getTeamScore = ::_getTeamScore;
  level._getPlayerScore = ::_getPlayerScore;

  level.onPrecacheGametype = ::blank;
  level.onStartGameType = ::blank;
  level.onPlayerConnect = ::blank;
  level.onPlayerDisconnect = ::blank;
  level.onPlayerDamage = ::blank;
  level.onPlayerKilled = ::blank;
  level.onPlayerKilledExtraUnthreadedCBs = [];

  level.onTeamOutcomeNotify = maps\mp\gametypes\_hud_message::teamOutcomeNotify;
  level.onOutcomeNotify = maps\mp\gametypes\_hud_message::outcomeNotify;
  level.onEndGame = ::blank;
  level.onRoundEndGame = ::default_onRoundEndGame;

  level.autoassign = ::menuAutoAssign;
  level.spectator = ::menuSpectator;
  level.class = ::menuClass;
  level.allies = ::menuAllies;
  level.axis = ::menuAxis;

  level.leaveSquad = ::menuLeaveSquad;
  level.createSquad = ::menuCreateSquad;
  level.lockSquad = ::menuLockSquad;
  level.unlockSquad = ::menuUnlockSquad;
  level.joinSquad = ::menuJoinSquad;
  level.showSquadInfo = ::menuShowSquadInfo;
}
WaitTillSlowProcessAllowed() {
  while(level.lastSlowProcessFrame == gettime()) {
    wait .05;
  }

  level.lastSlowProcessFrame = gettime();
}

blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {}
default_onForfeit(team) {
  level.gameForfeited = true;

  level notify("forfeit in progress");
  level endon("forfeit in progress");
  level endon("abort forfeit");

  forfeit_delay = 20.0;

  announcement(game["strings"]["opponent_forfeiting_in"], forfeit_delay);
  wait(10.0);
  announcement(game["strings"]["opponent_forfeiting_in"], 10.0);
  wait(10.0);

  endReason = &"";
  if(!isDefined(team)) {
    setDvar("ui_text_endreason", game["strings"]["players_forfeited"]);
    endReason = game["strings"]["players_forfeited"];
    winner = level.players[0];
  } else if(team == "allies") {
    setDvar("ui_text_endreason", game["strings"]["allies_forfeited"]);
    endReason = game["strings"]["allies_forfeited"];
    winner = "axis";
  } else if(team == "axis") {
    setDvar("ui_text_endreason", game["strings"]["axis_forfeited"]);
    endReason = game["strings"]["axis_forfeited"];
    winner = "allies";
  } else {
    assertEx(isDefined(team), "Forfeited team is not defined");
    assertEx(0, "Forfeited team " + team + " is not allies or axis");
    winner = "tie";
  }
  level.forcedEnd = true;

  if(isPlayer(winner)) {
    logString("forfeit, win: " + winner getXuid() + "(" + winner.name + ")");
  } else {
    logString("forfeit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);
  }
  thread endGame(winner, endReason);
}

default_onDeadEvent(team) {
  if(team == "allies") {
    iPrintLn(game["strings"]["allies_eliminated"]);
    makeDvarServerInfo("ui_text_endreason", game["strings"]["allies_eliminated"]);
    setDvar("ui_text_endreason", game["strings"]["allies_eliminated"]);

    logString("team eliminated, win: axis, allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);

    thread endGame("axis", game["strings"]["allies_eliminated"]);
  } else if(team == "axis") {
    iPrintLn(game["strings"]["axis_eliminated"]);
    makeDvarServerInfo("ui_text_endreason", game["strings"]["axis_eliminated"]);
    setDvar("ui_text_endreason", game["strings"]["axis_eliminated"]);

    logString("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);

    thread endGame("allies", game["strings"]["axis_eliminated"]);
  } else {
    makeDvarServerInfo("ui_text_endreason", game["strings"]["tie"]);
    setDvar("ui_text_endreason", game["strings"]["tie"]);

    logString("tie, allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);

    if(level.teamBased) {
      thread endGame("tie", game["strings"]["tie"]);
    } else {
      thread endGame(undefined, game["strings"]["tie"]);
    }
  }
}

default_onRoundEndGame(winner) {
  return winner;
}

default_onOneLeftEvent(team) {
  if(!level.teamBased) {
    winner = getHighestScoringPlayer();

    if(isDefined(winner)) {
      logString("last one alive, win: " + winner.name);
    } else {
      logString("last one alive, win: unknown");
    }

    thread endGame(winner, &"MP_ENEMIES_ELIMINATED");
  } else {
    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];

      if(!isAlive(player)) {
        continue;
      }

      if(!isDefined(player.pers["team"]) || player.pers["team"] != team) {
        continue;
      }

      player maps\mp\gametypes\_globallogic::leaderDialogOnPlayer("sudden_death");
    }
  }
}

default_onTimeLimit() {
  winner = undefined;

  if(level.teamBased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      winner = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
    } else {
      winner = "allies";
    }

    logString("time limit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);
  } else {
    winner = getHighestScoringPlayer();

    if(isDefined(winner)) {
      logString("time limit, win: " + winner.name);
    } else {
      logString("time limit, tie");
    }
  }

  makeDvarServerInfo("ui_text_endreason", game["strings"]["time_limit_reached"]);
  setDvar("ui_text_endreason", game["strings"]["time_limit_reached"]);

  thread endGame(winner, game["strings"]["time_limit_reached"]);
}

forceEnd(hostsucks) {
  if(!isDefined(hostsucks)) {
    hostsucks = false;
  }

  if(level.hostForcedEnd || level.forcedEnd) {
    return;
  }

  winner = undefined;

  if(level.teamBased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      winner = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
    } else {
      winner = "allies";
    }
    logString("host ended game, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);
  } else {
    winner = getHighestScoringPlayer();
    if(isDefined(winner)) {
      logString("host ended game, win: " + winner.name);
    } else {
      logString("host ended game, tie");
    }
  }

  level.forcedEnd = true;
  level.hostForcedEnd = true;

  if(hostsucks) {
    endString = &"MP_HOST_SUCKS";
  } else {
    if(level.splitscreen) {
      endString = &"MP_ENDED_GAME";
    } else {
      endString = &"MP_HOST_ENDED_GAME";
    }
  }

  makeDvarServerInfo("ui_text_endreason", endString);
  setDvar("ui_text_endreason", endString);
  thread endGame(winner, endString);
}

default_onScoreLimit() {
  if(!level.endGameOnScoreLimit) {
    return;
  }

  winner = undefined;

  if(level.teamBased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      winner = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
    } else {
      winner = "allies";
    }
    logString("scorelimit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);
  } else {
    winner = getHighestScoringPlayer();
    if(isDefined(winner)) {
      logString("scorelimit, win: " + winner.name);
    } else {
      logString("scorelimit, tie");
    }
  }

  makeDvarServerInfo("ui_text_endreason", game["strings"]["score_limit_reached"]);
  setDvar("ui_text_endreason", game["strings"]["score_limit_reached"]);

  if(!level.scoreLimitIsPerRound) {
    level.forcedEnd = true;
  }
  thread endGame(winner, game["strings"]["score_limit_reached"]);
}

updateGameEvents() {
  if(level.rankedMatch && !level.inGracePeriod) {
    if(level.teamBased) {
      if(!level.gameForfeited) {
        if((level.everExisted["allies"] || level.console) && level.playerCount["allies"] < 1 && level.playerCount["axis"] > 0 && game["state"] == "playing") {
          {}

          thread[[level.onForfeit]]("allies");
          return;
        }

        if((level.everExisted["axis"] || level.console) && level.playerCount["axis"] < 1 && level.playerCount["allies"] > 0 && game["state"] == "playing") {
          {}

          thread[[level.onForfeit]]("axis");
          return;
        }
      } else {
        if(level.playerCount["axis"] > 0 && level.playerCount["allies"] > 0) {
          {}
          level.gameForfeited = false;
          level notify("abort forfeit");
        }
      }
    } else {
      if(!level.gameForfeited) {
        if(level.playerCount["allies"] + level.playerCount["axis"] == 1 && level.maxPlayerCount > 1) {
          {}
          thread[[level.onForfeit]]();
          return;
        }
      } else {
        if(level.playerCount["axis"] + level.playerCount["allies"] > 1) {
          {}
          level.gameForfeited = false;
          level notify("abort forfeit");
        }
      }
    }
  }

  if(!level.numLives && !level.inOverTime) {
    return;
  }

  if(level.inGracePeriod) {
    return;
  }

  if(level.teamBased) {
    if(level.everExisted["allies"] && !level.aliveCount["allies"] && level.everExisted["axis"] && !level.aliveCount["axis"] && !level.playerLives["allies"] && !level.playerLives["axis"]) {
      [[level.onDeadEvent]]("all");
      return;
    }

    if(level.everExisted["allies"] && !level.aliveCount["allies"] && !level.playerLives["allies"]) {
      [[level.onDeadEvent]]("allies");
      return;
    }

    if(level.everExisted["axis"] && !level.aliveCount["axis"] && !level.playerLives["axis"]) {
      [[level.onDeadEvent]]("axis");
      return;
    }

    if(level.lastAliveCount["allies"] > 1 && level.aliveCount["allies"] == 1 && level.playerLives["allies"] == 1) {
      [[level.onOneLeftEvent]]("allies");
      return;
    }

    if(level.lastAliveCount["axis"] > 1 && level.aliveCount["axis"] == 1 && level.playerLives["axis"] == 1) {
      [[level.onOneLeftEvent]]("axis");
      return;
    }
  } else {
    if((!level.aliveCount["allies"] && !level.aliveCount["axis"]) && (!level.playerLives["allies"] && !level.playerLives["axis"]) && level.maxPlayerCount > 1) {
      [[level.onDeadEvent]]("all");
      return;
    }

    if((level.aliveCount["allies"] + level.aliveCount["axis"] == 1) && (level.playerLives["allies"] + level.playerLives["axis"] == 1) && level.maxPlayerCount > 1) {
      [[level.onOneLeftEvent]]("all");
      return;
    }
  }
}

matchStartTimer() {
  visionSetNaked("mpIntro", 0);

  matchStartText = createServerFontString("objective", 1.5);
  matchStartText setPoint("CENTER", "CENTER", 0, -40);
  matchStartText.sort = 1001;
  matchStartText setText(game["strings"]["waiting_for_teams"]);
  matchStartText.foreground = false;
  matchStartText.hidewheninmenu = true;

  waitForPlayers();
  matchStartText setText(game["strings"]["match_starting_in"]);

  matchStartTimer = createServerFontString("objective", 2.2);
  matchStartTimer setPoint("CENTER", "CENTER", 0, 0);
  matchStartTimer.sort = 1001;
  matchStartTimer.color = (1, 1, 0);
  matchStartTimer.foreground = false;
  matchStartTimer.hidewheninmenu = true;

  matchStartTimer maps\mp\gametypes\_hud::fontPulseInit();

  countTime = int(level.prematchPeriod);

  if(countTime >= 2) {
    while(countTime > 0 && !level.gameEnded) {
      matchStartTimer setValue(countTime);
      matchStartTimer thread maps\mp\gametypes\_hud::fontPulse(level);
      if(countTime == 2) {
        visionSetNaked(getDvar("mapname"), 3.0);
      }
      countTime--;
      wait(1.0);
    }
  } else {
    visionSetNaked(getDvar("mapname"), 1.0);
  }

  matchStartTimer destroyElem();
  matchStartText destroyElem();
}

matchStartTimerSkip() {
  visionSetNaked(getDvar("mapname"), 0);
}

spawnPlayer() {
  prof_begin("spawnPlayer_preUTS");

  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");

  self setSpawnVariables();

  if(level.teamBased) {
    self.sessionteam = self.team;
  } else {
    self.sessionteam = "none";
  }

  hadSpawned = self.hasSpawned;

  self.sessionstate = "playing";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.statusicon = "";
  if(getDvarInt("scr_csmode") > 0) {
    self.maxhealth = getDvarInt("scr_csmode");
  } else {
    self.maxhealth = maps\mp\gametypes\_tweakables::getTweakableValue("player", "maxhealth");
  }
  self.health = self.maxhealth;
  self.friendlydamage = undefined;
  self.hasSpawned = true;
  self.canDoCombat = true;
  self.spawnTime = getTime();
  self.afk = false;
  if(self.pers["lives"]) {
    self.pers["lives"]--;
  }
  self.lastStand = undefined;
  self.revivingTeammate = false;
  self.burning = undefined;

  self.diedOnVehicle = undefined;

  if(!self.wasAliveAtMatchStart) {
    if(level.inGracePeriod || getTimePassed() < 20 * 1000) {
      self.wasAliveAtMatchStart = true;
    }
  }

  self setClientDvar("cg_thirdPerson", "0");
  self setClientDvar("killcam_title", "@MP_KILLCAM");
  self setDepthOfField(0, 0, 512, 512, 4, 0);

  {
    if(isDefined(level.onSpawnPlayerUnified) {
        &&
        GetDvarInt("scr_disableunifiedspawning") == 0)
    } {
      self[[level.onSpawnPlayerUnified]]();
    } else {
      self[[level.onSpawnPlayer]]();
    }

    if(isDefined(level.playerSpawnedCB)) {
      self[[level.playerSpawnedCB]]();
    }
  }

  self maps\mp\gametypes\_missions::playerSpawned();

  prof_end("spawnPlayer_preUTS");

  level thread updateTeamStatus();

  prof_begin("spawnPlayer_postUTS");

  self thread stopPoisoningAndFlareOnspawn();

  self StopBurning();

  if(level.oldschool) {
    assert(!isDefined(self.class));
    self maps\mp\gametypes\_oldschool::giveLoadout();
    self maps\mp\gametypes\_class::setClass(level.defaultClass);
  } else {
    assert(isValidClass(self.class));

    self maps\mp\gametypes\_class::setClass(self.class);
    self maps\mp\gametypes\_class::giveLoadout(self.team, self.class);
  }

  if(level.inPrematchPeriod) {
    self freezeControls(true);

    self setClientDvar("scr_objectiveText", getObjectiveHintText(self.pers["team"]));

    team = self.pers["team"];

    music = game["music"]["spawn_" + team];
    if(level.splitscreen) {
      if(isDefined(level.playedStartingMusic)) {
        music = undefined;
      } else {
        level.playedStartingMusic = true;
      }
    }

    thread maps\mp\gametypes\_hud_message::oldNotifyMessage(game["strings"][team + "_name"], undefined, game["icons"][team], game["colors"][team], music);
    if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
      if(!isDefined(level.inFinalFight) || !level.inFinalFight) {
        self leaderDialogOnPlayer("gametype");
      }
    }

    thread maps\mp\gametypes\_hud::showClientScoreBar(5.0);
  } else {
    self freezeControls(false);
    self enableWeapons();
    if(!hadSpawned && game["state"] == "playing") {
      team = self.team;

      music = game["music"]["spawn_" + team];
      if(level.splitscreen) {
        if(isDefined(level.playedStartingMusic)) {
          music = undefined;
        } else {
          level.playedStartingMusic = true;
        }
      }

      thread maps\mp\gametypes\_hud_message::oldNotifyMessage(game["strings"][team + "_name"], undefined, game["icons"][team], game["colors"][team], music);
      if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
        if(!isDefined(level.inFinalFight) || !level.inFinalFight) {
          {}
          self leaderDialogOnPlayer("gametype");
          if(team == game["attackers"]) {
            self leaderDialogOnPlayer("offense_obj", "introboost");
          } else {
            self leaderDialogOnPlayer("defense_obj", "introboost");
          }
        }
      }

      self setClientDvar("scr_objectiveText", getObjectiveHintText(self.pers["team"]));
      thread maps\mp\gametypes\_hud::showClientScoreBar(5.0);
    }
  }

  if(getDvar("scr_showperksonspawn") == "") {
    setDvar("scr_showperksonspawn", "1");
  }

  if(!level.splitscreen && getdvarint("scr_showperksonspawn") == 1 && game["state"] != "postgame") {
    perks = getPerks(self);
    self showPerk(0, perks[0], -50);
    self showPerk(1, perks[1], -50);
    self showPerk(2, perks[2], -50);
    self showPerk(3, perks[3], -50);

    self thread hidePerksAfterTime(3.0);
    self thread hidePerksOnDeath();
  }

  prof_end("spawnPlayer_postUTS");

  waittillframeend;
  self notify("spawned_player");

  self logstring("S " + self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);

  setDvar("scr_selecting_location", "");
  self thread maps\mp\gametypes\_hardpoints::hardpointItemWaiter();
  self thread maps\mp\gametypes\_hardpoints::artilleryWaiter();

  self thread maps\mp\_vehicles::vehicleDeathWaiter();
  self thread maps\mp\_vehicles::turretDeathWaiter();

  if(getDvarInt("scr_xprate") > 0) {
    self thread xpRateThread();
  }

  if(game["state"] == "postgame") {
    assert(!level.intermission);

    self freezePlayerForRoundEnd();
  }
}

xpRateThread() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(level.inPrematchPeriod) {
    wait(0.05);
  }

  for(;;) {
    wait(5.0);
    if(level.players[0].pers["team"] == "allies" || level.players[0].pers["team"] == "axis") {
      self maps\mp\gametypes\_rank::giveRankXP("kill", int(min(getDvarInt("scr_xprate"), 50)));
    }
  }
}

hidePerksAfterTime(delay) {
  self endon("disconnect");
  self endon("perks_hidden");

  wait delay;

  self thread hidePerk(0, 2.0);
  self thread hidePerk(1, 2.0);
  self thread hidePerk(2, 2.0);
  self thread hidePerk(3, 2.0);

  self notify("perks_hidden");
}

stopPoisoningAndFlareOnspawn() {
  self endon("disconnect");

  self.inPoisonArea = false;
  self.inFlareVisionArea = false;
}

hidePerksOnDeath() {
  self endon("disconnect");
  self endon("perks_hidden");

  self waittill("death");

  self hidePerk(0);
  self hidePerk(1);
  self hidePerk(2);
  self hidePerk(3);

  self notify("perks_hidden");
}

hidePerksOnKill() {
  self endon("disconnect");
  self endon("death");
  self endon("perks_hidden");

  self waittill("killed_player");

  self hidePerk(0);
  self hidePerk(1);
  self hidePerk(2);
  self hidePerk(3);

  self notify("perks_hidden");
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

testHPs() {
  self endon("death");
  self endon("disconnect");

  hps = [];
  hps[hps.size] = "radar_mp";
  hps[hps.size] = "artillery_mp";
  hps[hps.size] = "dogs_mp";

  for(;;) {
    hp = "radar_mp";
    if(self thread maps\mp\gametypes\_hardpoints::giveHardpointItem(hp)) {
      self playLocalSound(level.hardpointInforms[hp]);
    }

    wait(20.0);
  }
}

spawnSpectator(origin, angles) {
  self notify("spawned");
  self notify("end_respawn");
  in_spawnSpectator(origin, angles);
}
respawn_asSpectator(origin, angles) {
  in_spawnSpectator(origin, angles);
}
in_spawnSpectator(origin, angles) {
  self setSpawnVariables();

  if(self.pers["team"] == "spectator") {
    self clearLowerMessage();
  }

  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;

  if(self.pers["team"] == "spectator") {
    self.statusicon = "";
  } else {
    self.statusicon = "hud_status_dead";
  }

  maps\mp\gametypes\_spectating::setSpectatePermissions();

  [[level.onSpawnSpectator]](origin, angles);

  if(level.teamBased && !level.splitscreen) {
    self thread spectatorThirdPersonness();
  }

  level thread updateTeamStatus();
}

spectatorThirdPersonness() {
  self endon("disconnect");
  self endon("spawned");

  self notify("spectator_thirdperson_thread");
  self endon("spectator_thirdperson_thread");

  self.spectatingThirdPerson = false;

  self setThirdPerson(true);
}

getPlayerFromClientNum(clientNum) {
  if(clientNum < 0) {
    return undefined;
  }

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] getEntityNumber() == clientNum) {
      return level.players[i];
    }
  }
  return undefined;
}

setThirdPerson(value) {
  if(value != self.spectatingThirdPerson) {
    self.spectatingThirdPerson = value;
    if(value) {
      self setClientDvar("cg_thirdPerson", "1");
    } else {
      self setClientDvar("cg_thirdPerson", "0");
    }
  }
}

waveSpawnTimer() {
  level endon("game_ended");

  while(game["state"] == "playing") {
    time = getTime();

    if(time - level.lastWave["allies"] > (level.waveDelay["allies"] * 1000)) {
      level notify("wave_respawn_allies");
      level.lastWave["allies"] = time;
      level.wavePlayerSpawnIndex["allies"] = 0;
    }

    if(time - level.lastWave["axis"] > (level.waveDelay["axis"] * 1000)) {
      level notify("wave_respawn_axis");
      level.lastWave["axis"] = time;
      level.wavePlayerSpawnIndex["axis"] = 0;
    }

    wait(0.05);
  }
}

default_onSpawnSpectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }

  spawnpointname = "mp_global_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");
  assertex(spawnpoints.size, "There are no mp_global_intermission spawn points in the map.There must be at least one.");
  spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

  self spawn(spawnpoint.origin, spawnpoint.angles);
}

spawnIntermission() {
  self notify("spawned");
  self notify("end_respawn");

  self setSpawnVariables();

  self clearLowerMessage();

  self freezeControls(false);

  self setClientDvar("cg_everyoneHearsEveryone", "1");

  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;

  [[level.onSpawnIntermission]]();
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}

default_onSpawnIntermission() {
  spawnpointname = "mp_global_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");
  spawnpoint = spawnPoints[0];

  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
  } else {
    maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
  }
}
timeUntilRoundEnd() {
  if(level.gameEnded) {
    timePassed = (getTime() - level.gameEndTime) / 1000;
    timeRemaining = level.postRoundTime - timePassed;

    if(timeRemaining < 0) {
      return 0;
    }

    return timeRemaining;
  }

  if(level.inOvertime) {
    return undefined;
  }

  if(level.timeLimit <= 0) {
    return undefined;
  }

  if(!isDefined(level.startTime)) {
    return undefined;
  }

  timePassed = (getTime() - level.startTime) / 1000;
  timeRemaining = (level.timeLimit * 60) - timePassed;

  return timeRemaining + level.postRoundTime;
}

freezePlayerForRoundEnd() {
  self clearLowerMessage();

  self closeMenu();
  self closeInGameMenu();

  self freezeControls(true);
}

logXPGains() {
  if(!isDefined(self.xpGains)) {
    return;
  }

  xpTypes = getArrayKeys(self.xpGains);
  for(index = 0; index < xpTypes.size; index++) {
    gain = self.xpGains[xpTypes[index]];
    if(!gain) {
      continue;
    }

    self logString("xp " + xpTypes[index] + ": " + gain);
  }
}

freeGameplayHudElems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] destroyElem();
      self.perkname[0] destroyElem();
    }
    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] destroyElem();
      self.perkname[1] destroyElem();
    }
    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] destroyElem();
      self.perkname[2] destroyElem();
    }
    if(isDefined(self.perkicon[3])) {
      self.perkicon[3] destroyElem();
      self.perkname[3] destroyElem();
    }
  }
  self notify("perks_hidden");

  self.lowerMessage destroyElem();
  self.lowerTimer destroyElem();

  if(isDefined(self.proxBar)) {
    self.proxBar destroyElem();
  }
  if(isDefined(self.proxBarText)) {
    self.proxBarText destroyElem();
  }
}

getHostPlayer() {
  players = get_players();

  for(index = 0; index < players.size; index++) {
    if(players[index] getEntityNumber() == 0) {
      return players[index];
    }
  }
}

hostIdledOut() {
  hostPlayer = getHostPlayer();

  if(isDefined(hostPlayer) && !hostPlayer.hasSpawned && !isDefined(hostPlayer.selectedClass)) {
    return true;
  }

  return false;
}

endGame(winner, endReasonText) {
  if(game["state"] == "postgame" || level.gameEnded) {
    return;
  }

  if(isDefined(level.onEndGame)) {
    [[level.onEndGame]](winner);
  }

  visionSetNaked("mpOutro", 2.0);

  game["state"] = "postgame";
  level.gameEndTime = getTime();
  level.gameEnded = true;
  level.inGracePeriod = false;
  level notify("game_ended");
  level.allowBattleChatter = false;

  setGameEndTime(0);

  if(level.rankedMatch) {
    setXenonRanks();

    if(hostIdledOut()) {
      level.hostForcedEnd = true;
      logString("host idled out");
      endLobby();
    }
  }

  updatePlacement();
  updateMatchBonusScores(winner);
  updateWinLossStats(winner);

  for(index = 0; index < level.players.size; index++) {
    nemesis = level.players[index].pers["nemesis_name"];

    if(!isDefined(level.players[index].pers["killed_players"][nemesis])) {
      level.players[index].pers["killed_players"][nemesis] = 0;
    }
    if(!isDefined(level.players[index].pers["killed_by"][nemesis])) {
      level.players[index].pers["killed_by"][nemesis] = 0;
    }

    spread = level.players[index].kills - level.players[index].deaths;

    if(level.players[index].cur_kill_streak > level.players[index].pers["best_kill_streak"]) {
      level.players[index].pers["best_kill_streak"] = level.players[index].cur_kill_streak;
    }

    if(level.ps3) {
      level.players[index] setClientDvars("ns_n", nemesis, "ns_r", level.players[index].pers["nemesis_rank"], "ns_ri", level.players[index].pers["nemesis_rankIcon"]);

      level.players[index] setClientDvars("ns_x", level.players[index].pers["nemesis_xp"], "ns_id", level.players[index].pers["nemesis_xuid"]);

      level.players[index] setClientDvars("ns_k", level.players[index].pers["killed_players"][nemesis], "ps_k", level.players[index].kills);

      level.players[index] setClientDvars("ns_d", level.players[index].pers["killed_by"][nemesis], "ps_n", level.players[index].name);

      level.players[index] setClientDvars("ps_d", level.players[index].deaths, "ps_h", level.players[index].headshots, "ps_kds", spread);

      level.players[index] setClientDvars("ps_st", level.players[index].pers["best_kill_streak"], "ps_r", level.players[index].pers["uav_used"], "ps_ac", level.players[index].pers["artillery_used"]);

      level.players[index] setClientDvars("ps_dc", level.players[index].pers["dogs_used"], "ps_ak", level.players[index].pers["artillery_kills"], "ps_dk", level.players[index].pers["dog_kills"]);
    } else {
      level.players[index] setClientDvars("ns_n", nemesis, "ns_r", level.players[index].pers["nemesis_rank"], "ns_ri", level.players[index].pers["nemesis_rankIcon"], "ns_x", level.players[index].pers["nemesis_xp"], "ns_id", level.players[index].pers["nemesis_xuid"], "ns_k", level.players[index].pers["killed_players"][nemesis], "ns_d", level.players[index].pers["killed_by"][nemesis], "ps_n", level.players[index].name, "ps_k", level.players[index].kills, "ps_d", level.players[index].deaths, "ps_h", level.players[index].headshots, "ps_kds", spread, "ps_st", level.players[index].pers["best_kill_streak"], "ps_r", level.players[index].pers["uav_used"], "ps_ac", level.players[index].pers["artillery_used"], "ps_dc", level.players[index].pers["dogs_used"], "ps_ak", level.players[index].pers["artillery_kills"], "ps_dk", level.players[index].pers["dog_kills"]);
    }
    recordPlayerStats(level.players[index], "highestKillStreak", level.players[index].pers["best_kill_streak"]);
    recordPlayerStats(level.players[index], "numUavCalled", level.players[index].pers["uav_used"]);
    recordPlayerStats(level.players[index], "numArtilleryCalled", level.players[index].pers["artillery_used"]);
    recordPlayerStats(level.players[index], "numDogsCalled", level.players[index].pers["dogs_used"]);
    recordPlayerStats(level.players[index], "numArtilleryKills", level.players[index].pers["artillery_kills"]);
    recordPlayerStats(level.players[index], "numDogsKills", level.players[index].pers["dog_kills"]);
  }

  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];

    player freezePlayerForRoundEnd();
    player thread roundEndDoF(4.0);

    player freeGameplayHudElems();

    player setClientDvar("cg_everyoneHearsEveryone", "1");

    if(level.rankedMatch) {
      if(isDefined(player.setPromotion)) {
        player setClientDvar("ui_lobbypopup", "promotion");
      } else {
        player setClientDvar("ui_lobbypopup", "summary");
      }
    }
  }

  setmusicstate("SILENT");
  setbusstate("map_end");

  if((level.roundLimit > 1 || (!level.roundLimit && level.scoreLimit != 1)) && !level.forcedEnd) {
    if(level.displayRoundEndText) {
      players = level.players;
      for(index = 0; index < players.size; index++) {
        player = players[index];

        if(level.teamBased) {
          player thread[[level.onTeamOutcomeNotify]](winner, true, endReasonText);
        } else {
          player thread[[level.onOutcomeNotify]](winner, endReasonText);
        }

        player setClientDvars("ui_hud_hardcore", 1, "cg_drawSpectatorMessages", 0, "g_compassShowEnemies", 0);
      }

      if(level.teamBased && !(hitRoundLimit() || hitScoreLimit())) {
        thread announceRoundWinner(winner, level.roundEndDelay / 4);
      }

      if(hitRoundLimit() || hitScoreLimit()) {
        roundEndWait(level.roundEndDelay / 2, false);
      } else {
        roundEndWait(level.roundEndDelay, true);
      }
    }

    game["roundsplayed"]++;
    roundSwitching = false;
    if(!hitRoundLimit() && !hitScoreLimit()) {
      roundSwitching = checkRoundSwitch();
    }

    if(roundSwitching && level.teamBased) {
      players = level.players;
      for(index = 0; index < players.size; index++) {
        player = players[index];

        if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") {
          {}
          player[[level.spawnIntermission]]();
          player closeMenu();
          player closeInGameMenu();
          continue;
        }

        switchType = level.halftimeType;
        if(switchType == "halftime") {
          {}
          if(level.roundLimit) {
            if((game["roundsplayed"] * 2) == level.roundLimit) {
              switchType = "halftime";
            } else {
              switchType = "intermission";
            }
          } else if(level.scoreLimit) {
            if(game["roundsplayed"] == (level.scoreLimit - 1)) {
              switchType = "halftime";
            } else {
              switchType = "intermission";
            }
          } else {
            switchType = "intermission";
          }
        }
        switch (switchType) {
          case "halftime":
            player leaderDialogOnPlayer("halftime");
            break;
          case "overtime":
            player leaderDialogOnPlayer("overtime");
            break;
          case "finalfight":
            player leaderDialogOnPlayer("finalfight");
            break;
          case "endregulation":
            player leaderDialogOnPlayer("side_switch");
            break;
          default:
            player leaderDialogOnPlayer("side_switch");
            break;
        }
        player thread[[level.onTeamOutcomeNotify]](switchType, true, level.halftimeSubCaption);
        player setClientDvar("ui_hud_hardcore", 1);
      }

      roundEndWait(level.halftimeRoundEndDelay, false);
    } else if(!hitRoundLimit() && !hitScoreLimit() && !level.displayRoundEndText && level.teamBased) {
      players = level.players;
      for(index = 0; index < players.size; index++) {
        player = players[index];

        if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") {
          {}
          player[[level.spawnIntermission]]();
          player closeMenu();
          player closeInGameMenu();
          continue;
        }

        switchType = level.halftimeType;
        if(switchType == "halftime") {
          {}
          if(level.roundLimit) {
            if((game["roundsplayed"] * 2) == level.roundLimit) {
              switchType = "halftime";
            } else {
              switchType = "roundend";
            }
          } else if(level.scoreLimit) {
            if(game["roundsplayed"] == (level.scoreLimit - 1)) {
              switchType = "halftime";
            } else {
              switchTime = "roundend";
            }
          }
        }
        switch (switchType) {
          case "halftime":
            player leaderDialogOnPlayer("halftime");
            break;
          case "overtime":
            player leaderDialogOnPlayer("overtime");
            break;
        }
        player thread[[level.onTeamOutcomeNotify]](switchType, true, endReasonText);
        player setClientDvar("ui_hud_hardcore", 1);
      }

      roundEndWait(level.halftimeRoundEndDelay, !(hitRoundLimit() || hitScoreLimit()));
    }

    if(!hitRoundLimit() && !hitScoreLimit()) {
      game["state"] = "playing";
      if(level.teamBalance) {
        level notify("roundSwitching");
        wait 1;
      }
      level.allowBattleChatter = getdvarint("scr_allowbattlechatter");
      map_restart(true);
      return;
    }

    if(isDefined(level.onRoundEndGame)) {
      winner = [[level.onRoundEndGame]](winner);
    }

    if(hitRoundLimit()) {
      endReasonText = game["strings"]["round_limit_reached"];
    } else if(hitScoreLimit()) {
      endReasonText = game["strings"]["score_limit_reached"];
    } else {
      endReasonText = game["strings"]["time_limit_reached"];
    }
  }

  thread maps\mp\gametypes\_missions::roundEnd(winner);

  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];

    if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") {
      player[[level.spawnIntermission]]();
      player closeMenu();
      player closeInGameMenu();
      continue;
    }

    if(level.teamBased) {
      player thread[[level.onTeamOutcomeNotify]](winner, false, endReasonText);
    } else {
      player thread[[level.onOutcomeNotify]](winner, endReasonText);

      if(isDefined(winner) && player == winner) {
        player playLocalSound(game["music"]["victory_" + player.pers["team"]]);
      } else if(!level.splitScreen) {
        player playLocalSound(game["music"]["defeat"]);
      }
    }

    player setClientDvars("ui_hud_hardcore", 1, "cg_drawSpectatorMessages", 0, "g_compassShowEnemies", 0);
  }

  if(level.teamBased) {
    thread announceGameWinner(winner, level.postRoundTime / 2);

    if(level.splitscreen) {
      if(winner == "allies") {
        playSoundOnPlayers(game["music"]["victory_allies"], "allies");
      } else if(winner == "axis") {
        playSoundOnPlayers(game["music"]["victory_axis"], "axis");
      } else {
        playSoundOnPlayers(game["music"]["defeat"]);
      }
    } else {
      if(winner == "allies") {
        playSoundOnPlayers(game["music"]["victory_allies"], "allies");
        playSoundOnPlayers(game["music"]["defeat"], "axis");
      } else if(winner == "axis") {
        playSoundOnPlayers(game["music"]["victory_axis"], "axis");
        playSoundOnPlayers(game["music"]["defeat"], "allies");
      } else {
        playSoundOnPlayers(game["music"]["defeat"]);
      }
    }
  }

  roundEndWait(level.postRoundTime, true);

  level.intermission = true;

  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];

    player closeMenu();
    player closeInGameMenu();
    player notify("reset_outcome");
    player thread spawnIntermission();
    player setClientDvar("ui_hud_hardcore", 0);
    if(!level.console) {
      player setclientdvar("g_scriptMainMenu", game["menu_eog_main"]);
    }
  }

  logString("game ended");

  if(level.console) {
    wait 9.0;
    exitLevel(false);
    return;
  } else {
    wait getDvarFloat("scr_show_unlock_wait");
  }

  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];

    player openMenu(game["menu_eog_unlock"]);
  }

  thread timeLimitClock_Intermission(getDvarFloat("scr_intermission_time"));
  wait getDvarFloat("scr_intermission_time");

  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];

    player closeMenu();
    player closeInGameMenu();
  }

  exitLevel(false);
}

getWinningTeam() {
  if(getGameScore("allies") == getGameScore("axis")) {
    winner = "tie";
  } else if(getGameScore("allies") > getGameScore("axis")) {
    winner = "allies";
  } else {
    winner = "axis";
  }
  return winner;
}

roundEndWait(defaultDelay, matchBonus) {
  notifiesDone = false;
  while(!notifiesDone) {
    players = level.players;
    notifiesDone = true;
    for(index = 0; index < players.size; index++) {
      if(!isDefined(players[index].doingNotify) || !players[index].doingNotify) {
        continue;
      }

      notifiesDone = false;
    }
    wait(0.5);
  }

  if(!matchBonus) {
    wait(defaultDelay);
    return;
  }

  wait(defaultDelay / 2);
  level notify("give_match_bonus");
  wait(defaultDelay / 2);

  notifiesDone = false;
  while(!notifiesDone) {
    players = level.players;
    notifiesDone = true;
    for(index = 0; index < players.size; index++) {
      if(!isDefined(players[index].doingNotify) || !players[index].doingNotify) {
        continue;
      }

      notifiesDone = false;
    }
    wait(0.5);
  }
}

roundEndDOF(time) {
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}

updateMatchBonusScores(winner) {
  if(!game["timepassed"]) {
    return;
  }

  if(!level.rankedMatch) {
    return;
  }

  if(level.teamBased && isDefined(winner)) {
    if(winner == "endregulation") {
      return;
    }
  }

  if(!level.timeLimit || level.forcedEnd) {
    gameLength = getTimePassed() / 1000;

    gameLength = min(gameLength, 1200);

    if(level.gameType == "twar" && game["roundsplayed"] > 0) {
      gameLength += level.timeLimit * 60;
    }
  } else {
    gameLength = level.timeLimit * 60;
  }

  if(level.teamBased) {
    if(winner == "allies") {
      winningTeam = "allies";
      losingTeam = "axis";
    } else if(winner == "axis") {
      winningTeam = "axis";
      losingTeam = "allies";
    } else {
      winningTeam = "tie";
      losingTeam = "tie";
    }

    if(winningTeam != "tie") {
      winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue("win");
      loserScale = maps\mp\gametypes\_rank::getScoreInfoValue("loss");
    } else {
      winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
      loserScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
    }

    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(player.timePlayed["total"] < 1 || player.pers["participation"] < 1) {
        player thread maps\mp\gametypes\_rank::endGameUpdate();
        continue;
      }

      totalTimePlayed = player.timePlayed["total"];

      if(totalTimePlayed > gameLength) {
        totalTimePlayed = gameLength;
      }

      if(level.hostForcedEnd && player getEntityNumber() == 0) {
        continue;
      }

      spm = player maps\mp\gametypes\_rank::getSPM();
      if(winningTeam == "tie") {
        playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (totalTimePlayed / gameLength));
        player thread giveMatchBonus("tie", playerScore);
        player.matchBonus = playerScore;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] == winningTeam) {
        playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (totalTimePlayed / gameLength));
        player thread giveMatchBonus("win", playerScore);
        player.matchBonus = playerScore;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] == losingTeam) {
        playerScore = int((loserScale * ((gameLength / 60) * spm)) * (totalTimePlayed / gameLength));
        player thread giveMatchBonus("loss", playerScore);
        player.matchBonus = playerScore;
      }
    }
  } else {
    if(isDefined(winner)) {
      winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue("win");
      loserScale = maps\mp\gametypes\_rank::getScoreInfoValue("loss");
    } else {
      winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
      loserScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
    }

    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(player.timePlayed["total"] < 1 || player.pers["participation"] < 1) {
        player thread maps\mp\gametypes\_rank::endGameUpdate();
        continue;
      }

      totalTimePlayed = player.timePlayed["total"];

      if(totalTimePlayed > gameLength) {
        totalTimePlayed = gameLength;
      }

      spm = player maps\mp\gametypes\_rank::getSPM();

      isWinner = false;
      for(pIdx = 0; pIdx < min(level.placement["all"][0].size, 3); pIdx++) {
        if(level.placement["all"][pIdx] != player) {
          continue;
        }
        isWinner = true;
      }

      if(isWinner) {
        playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (totalTimePlayed / gameLength));
        player thread giveMatchBonus("win", playerScore);
        player.matchBonus = playerScore;
      } else {
        playerScore = int((loserScale * ((gameLength / 60) * spm)) * (totalTimePlayed / gameLength));
        player thread giveMatchBonus("loss", playerScore);
        player.matchBonus = playerScore;
      }
    }
  }
}

giveMatchBonus(scoreType, score) {
  self endon("disconnect");

  level waittill("give_match_bonus");

  self maps\mp\gametypes\_rank::giveRankXP(scoreType, score);
  logXPGains();

  self maps\mp\gametypes\_rank::endGameUpdate();
}

setXenonRanks(winner) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player.score) || !isDefined(player.pers["team"])) {
      continue;
    }
  }

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player.score) || !isDefined(player.pers["team"])) {
      continue;
    }

    setPlayerTeamRank(player, i, player.score - 5 * player.deaths);
    player logString("team: score " + player.pers["team"] + ":" + player.score);
  }
  sendranks();
}

getHighestScoringPlayer() {
  players = level.players;
  winner = undefined;
  tie = false;

  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].score)) {
      continue;
    }

    if(players[i].score < 1) {
      continue;
    }

    if(!isDefined(winner) || players[i].score > winner.score) {
      winner = players[i];
      tie = false;
    } else if(players[i].score == winner.score) {
      tie = true;
    }
  }

  if(tie || !isDefined(winner)) {
    return undefined;
  } else {
    return winner;
  }
}

checkTimeLimit() {
  if(isDefined(level.timeLimitOverride) && level.timeLimitOverride) {
    return;
  }

  if(game["state"] != "playing") {
    setGameEndTime(0);
    return;
  }

  if(level.timeLimit <= 0) {
    setGameEndTime(0);
    return;
  }

  if(level.inPrematchPeriod) {
    setGameEndTime(0);
    return;
  }

  if(!isDefined(level.startTime)) {
    return;
  }

  timeLeft = getTimeRemaining();

  setGameEndTime(getTime() + int(timeLeft));

  if(timeLeft > 0) {
    return;
  }

  [[level.onTimeLimit]]();
}

getTimeRemaining() {
  return level.timeLimit * 60 * 1000 - getTimePassed();
}

checkScoreLimit() {
  if(game["state"] != "playing") {
    return;
  }

  if(level.scoreLimit <= 0) {
    return;
  }

  if(level.teamBased) {
    if(game["teamScores"]["allies"] < level.scoreLimit && game["teamScores"]["axis"] < level.scoreLimit) {
      return;
    }
  } else {
    if(!isPlayer(self)) {
      return;
    }

    if(self.score < level.scoreLimit) {
      return;
    }
  }

  [[level.onScoreLimit]]();
}

hitRoundLimit() {
  if(level.roundLimit <= 0) {
    return false;
  }

  return (game["roundsplayed"] >= level.roundLimit);
}

hitScoreLimit() {
  if(level.scoreLimitIsPerRound) {
    return false;
  }

  if(level.scoreLimit <= 0) {
    return false;
  }

  if(level.teamBased) {
    if(game["teamScores"]["allies"] >= level.scoreLimit || game["teamScores"]["axis"] >= level.scoreLimit) {
      return true;
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.score) && player.score >= level.scorelimit) {
        return true;
      }
    }
  }
  return false;
}

registerRoundSwitchDvar(dvarString, defaultValue, minValue, maxValue) {
  dvarString = ("scr_" + dvarString + "_roundswitch");
  if(getDvar(dvarString) == "") {
    setDvar(dvarString, defaultValue);
  }

  if(getDvarInt(dvarString) > maxValue) {
    setDvar(dvarString, maxValue);
  } else if(getDvarInt(dvarString) < minValue) {
    setDvar(dvarString, minValue);
  }

  level.roundswitchDvar = dvarString;
  level.roundswitchMin = minValue;
  level.roundswitchMax = maxValue;
  level.roundswitch = getDvarInt(level.roundswitchDvar);
}

registerRoundLimitDvar(dvarString, defaultValue, minValue, maxValue) {
  dvarString = ("scr_" + dvarString + "_roundlimit");
  if(getDvar(dvarString) == "") {
    setDvar(dvarString, defaultValue);
  }

  if(getDvarInt(dvarString) > maxValue) {
    setDvar(dvarString, maxValue);
  } else if(getDvarInt(dvarString) < minValue) {
    setDvar(dvarString, minValue);
  }

  level.roundLimitDvar = dvarString;
  level.roundlimitMin = minValue;
  level.roundlimitMax = maxValue;
  level.roundLimit = getDvarInt(level.roundLimitDvar);
}

registerScoreLimitDvar(dvarString, defaultValue, minValue, maxValue) {
  dvarString = ("scr_" + dvarString + "_scorelimit");
  if(getDvar(dvarString) == "") {
    setDvar(dvarString, defaultValue);
  }

  if(getDvarInt(dvarString) > maxValue) {
    setDvar(dvarString, maxValue);
  } else if(getDvarInt(dvarString) < minValue) {
    setDvar(dvarString, minValue);
  }

  level.scoreLimitDvar = dvarString;
  level.scorelimitMin = minValue;
  level.scorelimitMax = maxValue;
  level.scoreLimit = getDvarInt(level.scoreLimitDvar);

  setDvar("ui_scorelimit", level.scoreLimit);
}

registerTimeLimitDvar(dvarString, defaultValue, minValue, maxValue) {
  dvarString = ("scr_" + dvarString + "_timelimit");
  if(getDvar(dvarString) == "") {
    setDvar(dvarString, defaultValue);
  }

  if(getDvarFloat(dvarString) > maxValue) {
    setDvar(dvarString, maxValue);
  } else if(getDvarFloat(dvarString) < minValue) {
    setDvar(dvarString, minValue);
  }

  level.timeLimitDvar = dvarString;
  level.timelimitMin = minValue;
  level.timelimitMax = maxValue;
  level.timelimit = getDvarFloat(level.timeLimitDvar);

  setDvar("ui_timelimit", level.timelimit);
}

registerNumLivesDvar(dvarString, defaultValue, minValue, maxValue) {
  dvarString = ("scr_" + dvarString + "_numlives");
  if(getDvar(dvarString) == "") {
    setDvar(dvarString, defaultValue);
  }

  if(getDvarInt(dvarString) > maxValue) {
    setDvar(dvarString, maxValue);
  } else if(getDvarInt(dvarString) < minValue) {
    setDvar(dvarString, minValue);
  }

  level.numLivesDvar = dvarString;
  level.numLivesMin = minValue;
  level.numLivesMax = maxValue;
  level.numLives = getDvarInt(level.numLivesDvar);
}

getValueInRange(value, minValue, maxValue) {
  if(value > maxValue) {
    return maxValue;
  } else if(value < minValue) {
    return minValue;
  } else {
    return value;
  }
}

default_getTimeLimitDvarValue() {
  return getValueInRange(getDvarFloat(level.timeLimitDvar), level.timeLimitMin, level.timeLimitMax);
}

updateGameTypeDvars() {
  level endon("game_ended");

  while(game["state"] == "playing") {
    roundlimit = getValueInRange(getDvarInt(level.roundLimitDvar), level.roundLimitMin, level.roundLimitMax);
    if(roundlimit != level.roundlimit) {
      level.roundlimit = roundlimit;
      level notify("update_roundlimit");
    }

    timeLimit = [[level.getTimeLimitDvarValue]]();
    if(timeLimit != level.timeLimit) {
      level.timeLimit = timeLimit;
      setDvar("ui_timelimit", level.timeLimit);
      level notify("update_timelimit");
    }
    thread checkTimeLimit();

    scoreLimit = getValueInRange(getDvarInt(level.scoreLimitDvar), level.scoreLimitMin, level.scoreLimitMax);
    if(scoreLimit != level.scoreLimit) {
      level.scoreLimit = scoreLimit;
      setDvar("ui_scorelimit", level.scoreLimit);
      level notify("update_scorelimit");
    }
    thread checkScoreLimit();

    if(isDefined(level.startTime)) {
      if(getTimeRemaining() < 3000) {
        wait .1;
        continue;
      }
    }
    wait 1;
  }
}

menuShowSquadInfo() {
  if(isDefined(self.pers["squadMessage"])) {
    if(getplayersquad(self) && self.pers["squadMessage"] != 3) {
      obituary_squad(self, self.pers["squadMessage"]);
    }
    self.pers["squadMessage"] = undefined;
  }
}

menuLeaveSquad() {
  if(getplayersquad(self)) {
    leavesquad(self);
    self.pers["squadMessage"] = 3;
  }
}

menuCreateSquad() {
  createsquad(self);
  self.pers["squadMessage"] = 1;
}

menuJoinSquad() {
  if(getplayersquad(self)) {
    self.pers["squadMessage"] = 2;
  }
}

menuLockSquad() {
  locksquad(self);
}

menuUnlockSquad() {
  unlocksquad(self);
}

menuAutoAssign() {
  teams[0] = "allies";
  teams[1] = "axis";
  assignment = teams[randomInt(2)];

  self closeMenus();

  if(level.teamBased) {
    if(getDvarInt("party_autoteams") == 1) {
      teamNum = getAssignedTeam(self);
      switch (teamNum) {
        case 1:
          assignment = teams[1];
          break;

        case 2:
          assignment = teams[0];
          break;

        default:
          assignment = "";
      }
    } else {
      self menuLeaveSquad();
    }

    if(assignment == "" || getDvarInt("party_autoteams") == 0) {
      playerCounts = self maps\mp\gametypes\_teams::CountPlayers();

      if(playerCounts["allies"] == playerCounts["axis"]) {
        if(getTeamScore("allies") == getTeamScore("axis")) {
          assignment = teams[randomInt(2)];
        } else if(getTeamScore("allies") < getTeamScore("axis")) {
          assignment = "allies";
        } else {
          assignment = "axis";
        }
      } else if(playerCounts["allies"] < playerCounts["axis"]) {
        assignment = "allies";
      } else {
        assignment = "axis";
      }
    }

    if(assignment == self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
      self beginClassChoice();
      return;
    }
  }

  if(assignment != self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
    self menuLeaveSquad();
    self.switching_teams = true;
    self.joining_team = assignment;
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self.pers["team"] = assignment;
  self.team = assignment;
  self.pers["class"] = undefined;
  self.class = undefined;
  self.pers["weapon"] = undefined;
  self.pers["savedmodel"] = undefined;

  self updateObjectiveText();

  if(level.teamBased) {
    self.sessionteam = assignment;
  } else {
    self.sessionteam = "none";
  }

  if(!isAlive(self)) {
    self.statusicon = "hud_status_dead";
  }

  lpselfnum = self getEntityNumber();
  lpselfname = self.name;
  lpselfteam = self.pers["team"];
  lpselfguid = self getGuid();

  logPrint("JT;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + "\n");

  self notify("joined_team");
  self notify("end_respawn");

  self beginClassChoice();

  self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}

updateObjectiveText() {
  if(self.pers["team"] == "spectator") {
    self setClientDvar("cg_objectiveText", "");
    return;
  }

  if(level.scorelimit > 0) {
    if(level.splitScreen) {
      self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]));
    } else {
      self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]), level.scorelimit);
    }
  } else {
    self setclientdvar("cg_objectiveText", getObjectiveText(self.pers["team"]));
  }
}

closeMenus() {
  self closeMenu();
  self closeInGameMenu();
}

beginClassChoice(forceNewChoice) {
  assert(self.pers["team"] == "axis" || self.pers["team"] == "allies");

  team = self.pers["team"];

  if(level.oldschool) {
    self.pers["class"] = undefined;
    self.class = undefined;

    self openMenu(game["menu_initteam_" + team]);

    if(self.sessionstate != "playing" && game["state"] == "playing") {
      self thread[[level.spawnClient]]();
    }
    level thread updateTeamStatus();
    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();

    return;
  }

  self openMenu(game["menu_changeclass_" + team]);
}

showMainMenuForTeam() {
  assert(self.pers["team"] == "axis" || self.pers["team"] == "allies");

  team = self.pers["team"];

  self openMenu(game["menu_class_" + team]);
}

menuAllies() {
  self closeMenus();

  if(self.pers["team"] != "allies") {
    if(level.allow_teamchange == "0" && (isDefined(self.hasDoneCombat) && self.hasDoneCombat)) {
      return;
    }

    if(level.inGracePeriod && (!isDefined(self.hasDoneCombat) || !self.hasDoneCombat)) {
      self.hasSpawned = false;
    }

    if(self.sessionstate == "playing") {
      self menuLeaveSquad();
      self.switching_teams = true;
      self.joining_team = "allies";
      self.leaving_team = self.pers["team"];
      self suicide();
    }

    self.pers["team"] = "allies";
    self.team = "allies";
    self.pers["class"] = undefined;
    self.class = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;

    self updateObjectiveText();

    if(level.teamBased) {
      self.sessionteam = "allies";
    } else {
      self.sessionteam = "none";
    }

    self setclientdvar("g_scriptMainMenu", game["menu_class_allies"]);

    lpselfnum = self getEntityNumber();
    lpselfname = self.name;
    lpselfteam = self.pers["team"];
    lpselfguid = self getGuid();

    logPrint("JT;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + "\n");

    self notify("joined_team");
    self notify("end_respawn");
  }

  self beginClassChoice();
}

menuAxis() {
  self closeMenus();

  if(self.pers["team"] != "axis") {
    if(level.allow_teamchange == "0" && (isDefined(self.hasDoneCombat) && self.hasDoneCombat)) {
      return;
    }

    if(level.inGracePeriod && (!isDefined(self.hasDoneCombat) || !self.hasDoneCombat)) {
      self.hasSpawned = false;
    }

    if(self.sessionstate == "playing") {
      self menuLeaveSquad();
      self.switching_teams = true;
      self.joining_team = "axis";
      self.leaving_team = self.pers["team"];
      self suicide();
    }

    self.pers["team"] = "axis";
    self.team = "axis";
    self.pers["class"] = undefined;
    self.class = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;

    self updateObjectiveText();

    if(level.teamBased) {
      self.sessionteam = "axis";
    } else {
      self.sessionteam = "none";
    }

    self setclientdvar("g_scriptMainMenu", game["menu_class_axis"]);

    lpselfnum = self getEntityNumber();
    lpselfname = self.name;
    lpselfteam = self.pers["team"];
    lpselfguid = self getGuid();

    logPrint("JT;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + "\n");

    self notify("joined_team");
    self notify("end_respawn");
  }

  self beginClassChoice();
}

menuSpectator() {
  self closeMenus();

  if(self.pers["team"] != "spectator") {
    if(isAlive(self)) {
      self menuLeaveSquad();
      self.switching_teams = true;
      self.joining_team = "spectator";
      self.leaving_team = self.pers["team"];
      self suicide();
    }

    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.pers["class"] = undefined;
    self.class = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self.canDoCombat = false;

    self updateObjectiveText();

    self.sessionteam = "spectator";
    [[level.spawnSpectator]]();

    self setclientdvar("g_scriptMainMenu", game["menu_team"]);

    self notify("joined_spectators");
  }
}

menuClass(response) {
  self closeMenus();

  if(response == "demolitions_mp,0" && self getstat(int(tablelookup("mp/statstable.csv", 4, "feature_closeassault", 1))) != 1) {
    closeassault_stat = int(tablelookup("mp/statstable.csv", 4, "feature_closeassault", 1));
    self setstat(closeassault_stat, 1);
  }
  if(response == "sniper_mp,0" && self getstat(int(tablelookup("mp/statstable.csv", 4, "feature_sniper", 1))) != 1) {
    sniper_stat = int(tablelookup("mp/statstable.csv", 4, "feature_sniper", 1));
    self setstat(sniper_stat, 1);
  }
  assert(!level.oldschool);

  if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis")) {
    return;
  }

  class = self maps\mp\gametypes\_class::getClassChoice(response);
  primary = self maps\mp\gametypes\_class::getWeaponChoice(response);

  if(class == "restricted") {
    self beginClassChoice();
    return;
  }

  if(self.sessionstate == "playing") {
    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;
    self.pers["weapon"] = undefined;

    if(game["state"] == "postgame") {
      return;
    }

    if(level.inGracePeriod && !self.hasDoneCombat) {
      self maps\mp\gametypes\_class::setClass(self.pers["class"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], self.pers["class"]);
    } else if(!level.splitScreen) {
      self iPrintLnBold(game["strings"]["change_class"]);
    }
  } else {
    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;
    self.pers["weapon"] = undefined;

    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing") {
      self thread[[level.spawnClient]]();
    }
  }

  level thread updateTeamStatus();

  self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

assertProperPlacement() {
  numPlayers = level.placement["all"].size;
  for(i = 0; i < numPlayers - 1; i++) {
    if(level.placement["all"][i].score < level.placement["all"][i + 1].score) {
      println("^1Placement array:");
      for(i = 0; i < numPlayers; i++) {
        player = level.placement["all"][i];
        println("^1" + i + ". " + player.name + ": " + player.score);
      }
      assertmsg("Placement array was not properly sorted");
      break;
    }
  }
}

removeDisconnectedPlayerFromPlacement() {
  offset = 0;
  numPlayers = level.placement["all"].size;
  found = false;
  for(i = 0; i < numPlayers; i++) {
    if(level.placement["all"][i] == self) {
      found = true;
    }

    if(found) {
      level.placement["all"][i] = level.placement["all"][i + 1];
    }
  }
  if(!found) {
    return;
  }

  level.placement["all"][numPlayers - 1] = undefined;
  assert(level.placement["all"].size == numPlayers - 1);

  assertProperPlacement();

  updateTeamPlacement();

  if(level.teamBased) {
    return;
  }

  numPlayers = level.placement["all"].size;
  for(i = 0; i < numPlayers; i++) {
    player = level.placement["all"][i];
    player notify("update_outcome");
  }
}

updatePlacement() {
  prof_begin("updatePlacement");

  if(!level.players.size) {
    return;
  }

  level.placement["all"] = [];
  for(index = 0; index < level.players.size; index++) {
    if(level.players[index].team == "allies" || level.players[index].team == "axis") {
      level.placement["all"][level.placement["all"].size] = level.players[index];
    }
  }

  placementAll = level.placement["all"];

  for(i = 1; i < placementAll.size; i++) {
    player = placementAll[i];
    playerScore = player.score;
    for(j = i - 1; j >= 0 && (playerScore > placementAll[j].score || (playerScore == placementAll[j].score && player.deaths < placementAll[j].deaths)); j--) {
      placementAll[j + 1] = placementAll[j];
    }
    placementAll[j + 1] = player;
  }

  level.placement["all"] = placementAll;

  assertProperPlacement();

  updateTeamPlacement();

  prof_end("updatePlacement");
}

updateTeamPlacement() {
  placement["allies"] = [];
  placement["axis"] = [];
  placement["spectator"] = [];

  if(!level.teamBased) {
    return;
  }

  placementAll = level.placement["all"];
  placementAllSize = placementAll.size;

  for(i = 0; i < placementAllSize; i++) {
    player = placementAll[i];
    team = player.pers["team"];

    placement[team][placement[team].size] = player;
  }

  level.placement["allies"] = placement["allies"];
  level.placement["axis"] = placement["axis"];
}

onXPEvent(event) {
  self maps\mp\gametypes\_rank::giveRankXP(event);
}

givePlayerScore(event, player, victim) {
  if(level.overridePlayerScore) {
    return;
  }

  score = player.pers["score"];
  [[level.onPlayerScore]](event, player, victim);

  if(score == player.pers["score"]) {
    return;
  }

  recordPlayerStats(player, "score", player.pers["score"]);

  player maps\mp\gametypes\_persistence::statAdd("score", (player.pers["score"] - score));

  player.score = player.pers["score"];

  if(!level.teambased) {
    thread sendUpdatedDMScores();
  }

  player notify("update_playerscore_hud");
  player thread checkScoreLimit();
}

default_onPlayerScore(event, player, victim) {
  score = maps\mp\gametypes\_rank::getScoreInfoValue(event);

  assert(isDefined(score));

  player.pers["score"] += score;
  recordPlayerStats(player, "score", player.pers["score"]);
}

_setPlayerScore(player, score) {
  if(score == player.pers["score"]) {
    return;
  }

  player.pers["score"] = score;
  player.score = player.pers["score"];
  recordPlayerStats(player, "score", player.pers["score"]);

  player notify("update_playerscore_hud");
  player thread checkScoreLimit();
}

_getPlayerScore(player) {
  return player.pers["score"];
}

giveTeamScore(event, team, player, victim) {
  if(level.overrideTeamScore) {
    return;
  }

  teamScore = game["teamScores"][team];
  [[level.onTeamScore]](event, team, player, victim);

  if(teamScore == game["teamScores"][team]) {
    return;
  }

  updateTeamScores(team);

  thread checkScoreLimit();
}

_setTeamScore(team, teamScore) {
  if(teamScore == game["teamScores"][team]) {
    return;
  }

  game["teamScores"][team] = teamScore;

  updateTeamScores(team);

  thread checkScoreLimit();
}

updateTeamScores(team1, team2) {
  setTeamScore(team1, getGameScore(team1));
  if(isDefined(team2)) {
    setTeamScore(team2, getGameScore(team2));
  }

  if(level.teambased) {
    thread sendUpdatedTeamScores();
  }
}

_getTeamScore(team) {
  return game["teamScores"][team];
}

default_onTeamScore(event, team, player, victim) {
  score = maps\mp\gametypes\_rank::getScoreInfoValue(event);

  assert(isDefined(score));

  otherTeam = level.otherTeam[team];

  if(game["teamScores"][team] > game["teamScores"][otherTeam]) {
    level.wasWinning = team;
  } else if(game["teamScores"][otherTeam] > game["teamScores"][team]) {
    level.wasWinning = otherTeam;
  }

  game["teamScores"][team] += score;

  isWinning = "none";
  if(game["teamScores"][team] > game["teamScores"][otherTeam]) {
    isWinning = team;
  } else if(game["teamScores"][otherTeam] > game["teamScores"][team]) {
    isWinning = otherTeam;
  }

  if(!level.splitScreen && isWinning != "none" && isWinning != level.wasWinning && getTime() - level.lastStatusTime > 5000) {
    level.lastStatusTime = getTime();
    leaderDialog("lead_taken", isWinning, "status");
    if(level.wasWinning != "none") {
      leaderDialog("lead_lost", level.wasWinning, "status");
    }
  }

  if(isWinning != "none") {
    level.wasWinning = isWinning;
  }
}

sendUpdatedTeamScores() {
  level notify("updating_scores");
  level endon("updating_scores");
  wait .05;

  WaitTillSlowProcessAllowed();

  for(i = 0; i < level.players.size; i++) {
    level.players[i] updateScores();
  }
}

sendUpdatedDMScores() {
  level notify("updating_dm_scores");
  level endon("updating_dm_scores");
  wait .05;

  WaitTillSlowProcessAllowed();

  for(i = 0; i < level.players.size; i++) {
    level.players[i] updateDMScores();
    level.players[i].updatedDMScores = true;
  }
}

initPersStat(dataName, record_stats) {
  if(!isDefined(self.pers[dataName])) {
    self.pers[dataName] = 0;
  }

  if(!isDefined(record_stats) || record_stats == true) {
    recordPlayerStats(self, dataName, self.pers[dataName]);
  }
}

getPersStat(dataName) {
  return self.pers[dataName];
}

incPersStat(dataName, increment, record_stats) {
  self.pers[dataName] += increment;
  self maps\mp\gametypes\_persistence::statAdd(dataName, increment);

  if(!isDefined(record_stats) || record_stats == true) {
    self thread threadedRecordPlayerStats(dataName);
  }
}

threadedRecordPlayerStats(dataName) {
  self endon("disconnect");
  waittillframeend;

  recordPlayerStats(self, dataName, self.pers[dataName]);
}

updatePersRatio(ratio, num, denom) {
  numValue = self maps\mp\gametypes\_persistence::statGet(num);
  denomValue = self maps\mp\gametypes\_persistence::statGet(denom);
  if(denomValue == 0) {
    denomValue = 1;
  }

  self maps\mp\gametypes\_persistence::statSet(ratio, int((numValue * 1000) / denomValue));

  numValue = self maps\mp\gametypes\_persistence::statGetWithGameType(num);
  denomValue = self maps\mp\gametypes\_persistence::statGetWithGameType(denom);
  if(denomValue == 0) {
    denomValue = 1;
  }

  self maps\mp\gametypes\_persistence::statSetWithGameType(ratio, int((numValue * 1000) / denomValue));
}

updateTeamStatus() {
  level notify("updating_team_status");
  level endon("updating_team_status");
  level endon("game_ended");
  waittillframeend;

  wait 0;

  if(game["state"] == "postgame") {
    return;
  }

  resetTimeout();

  prof_begin("updateTeamStatus");

  level.playerCount["allies"] = 0;
  level.playerCount["axis"] = 0;

  level.lastAliveCount["allies"] = level.aliveCount["allies"];
  level.lastAliveCount["axis"] = level.aliveCount["axis"];
  level.aliveCount["allies"] = 0;
  level.aliveCount["axis"] = 0;
  level.playerLives["allies"] = 0;
  level.playerLives["axis"] = 0;
  level.alivePlayers["allies"] = [];
  level.alivePlayers["axis"] = [];
  level.activePlayers = [];
  level.squads["allies"] = [];
  level.squads["axis"] = [];

  players = level.players;
  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player) && level.splitscreen) {
      continue;
    }

    team = player.team;
    class = player.class;

    if(team != "spectator" && (level.oldschool || (isDefined(class) && class != ""))) {
      level.playerCount[team]++;

      if(player.sessionstate == "playing") {
        level.aliveCount[team]++;
        level.playerLives[team]++;

        if(isAlive(player)) {
          {}
          level.alivePlayers[team][level.alivePlayers[team].size] = player;
          level.activeplayers[level.activeplayers.size] = player;

          squadID = getplayersquadid(player);

          if(isDefined(squadID)) {
            if(!isDefined(level.squads[team][squadID])) {
              level.squads[team][squadID] = [];
            }

            level.squads[team][squadID][level.squads[team][squadID].size] = player;
          }
        }
      } else {
        if(player mayspawn()) {
          level.playerLives[team]++;
        }
      }
    }
  }

  if(level.aliveCount["allies"] + level.aliveCount["axis"] > level.maxPlayerCount) {
    level.maxPlayerCount = level.aliveCount["allies"] + level.aliveCount["axis"];
  }

  if(level.aliveCount["allies"]) {
    level.everExisted["allies"] = true;
  }
  if(level.aliveCount["axis"]) {
    level.everExisted["axis"] = true;
  }

  prof_end("updateTeamStatus");

  level updateGameEvents();
}

isValidClass(class) {
  if(level.oldschool) {
    assert(!isDefined(class));
    return true;
  }
  return isDefined(class) && class != "";
}

playTickingSound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");

  while(1) {
    self playSound("ui_mp_suitcasebomb_timer");
    wait 1.0;
  }
}

stopTickingSound() {
  self notify("stop_ticking");
}

timeLimitClock() {
  level endon("game_ended");

  wait .05;

  clockObject = spawn("script_origin", (0, 0, 0));

  while(game["state"] == "playing") {
    if(!level.timerStopped && level.timeLimit) {
      timeLeft = getTimeRemaining() / 1000;
      timeLeftInt = int(timeLeft + 0.5);

      if(timeLeftInt >= 40 && timeLeftInt <= 60) {
        level notify("match_ending_soon");
      }

      if(timeLeftInt >= 30 && timeLeftInt <= 40) {
        level notify("match_ending_pretty_soon");
      }

      if(timeLeftInt <= 10 || (timeLeftInt <= 30 && timeLeftInt % 2 == 0)) {
        level notify("match_ending_very_soon");

        if(timeLeftInt == 0) {
          break;
        }

        clockObject playSound("ui_mp_timer_countdown");
      }

      if(timeLeft - floor(timeLeft) >= .05) {
        wait timeLeft - floor(timeLeft);
      }
    }

    wait(1.0);
  }
}

timeLimitClock_Intermission(waitTime) {
  setGameEndTime(getTime() + int(waitTime * 1000));
  clockObject = spawn("script_origin", (0, 0, 0));

  if(waitTime >= 10.0) {
    wait(waitTime - 10.0);
  }

  for(;;) {
    clockObject playSound("ui_mp_timer_countdown");
    wait(1.0);
  }
}

gameTimer() {
  level endon("game_ended");

  level waittill("prematch_over");
  setmusicstate("UNDERSCORE");

  level.startTime = getTime();
  level.discardTime = 0;

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.startTime -= game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  prevtime = gettime();

  while(game["state"] == "playing") {
    if(!level.timerStopped) {
      game["timepassed"] += gettime() - prevtime;
    }
    prevtime = gettime();
    wait(1.0);
  }
}

getTimePassed() {
  if(!isDefined(level.startTime)) {
    return 0;
  }

  if(level.timerStopped) {
    return (level.timerPauseTime - level.startTime) - level.discardTime;
  } else {
    return (gettime() - level.startTime) - level.discardTime;
  }
}

pauseTimer() {
  if(level.timerStopped) {
    return;
  }

  level.timerStopped = true;
  level.timerPauseTime = gettime();
}

resumeTimer() {
  if(!level.timerStopped) {
    return;
  }

  level.timerStopped = false;
  level.discardTime += gettime() - level.timerPauseTime;
}

startGame() {
  thread gameTimer();
  level.timerStopped = false;
  thread maps\mp\gametypes\_spawnlogic::spawnPerFrameUpdate();

  prematchPeriod();
  level notify("prematch_over");

  thread timeLimitClock();
  thread gracePeriod();

  thread musicController();
  thread maps\mp\gametypes\_missions::roundBegin();
}

musicController() {
  level endon("game_ended");

  level waittill("match_ending_soon");

  if(level.roundLimit == 1 || game["roundsplayed"] == (level.roundLimit - 1)) {
    if(!level.splitScreen) {
      if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
        leaderDialog("winning", "allies", undefined, undefined, "squad_winning");
        leaderDialog("losing", "axis", undefined, undefined, "squad_losing");
      } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
        leaderDialog("winning", "axis", undefined, undefined, "squad_winning");
        leaderDialog("losing", "allies", undefined, undefined, "squad_losing");
      } else {
        leaderDialog("timesup", "axis", undefined, undefined, "squad_30sec");
        leaderDialog("timesup", "allies", undefined, undefined, "squad_30sec");
      }

      level waittill("match_ending_pretty_soon");
      setmusicstate("MATCH_END");

      level waittill("match_ending_very_soon");
      leaderDialog("timesup", "axis", undefined, undefined, "squad_30sec");
      leaderDialog("timesup", "allies", undefined, undefined, "squad_30sec");
    }
  } else {
    level waittill("match_ending_pretty_soon");
    setmusicstate("MATCH_END");

    leaderDialog("timesup");
  }
}

suspenseMusic() {
  level endon("game_ended");
  level endon("match_ending_soon");

  numTracks = game["music"]["suspense"].size;
  for(;;) {
    wait(randomFloatRange(60, 120));

    playSoundOnPlayers(game["music"]["suspense"][randomInt(numTracks)]);
  }
}

waitForPlayers() {}

prematchPeriod() {
  makeDvarServerInfo("ui_hud_hardcore", 1);
  setDvar("ui_hud_hardcore", 1);
  level endon("game_ended");

  if(level.prematchPeriod > 0) {
    thread matchStartTimer();

    waitForPlayers();

    wait(level.prematchPeriod);
  } else {
    matchStartTimerSkip();
  }

  level.inPrematchPeriod = false;

  for(index = 0; index < level.players.size; index++) {
    level.players[index] freezeControls(false);
    level.players[index] enableWeapons();

    hintMessage = getObjectiveHintText(level.players[index].pers["team"]);
    if(!isDefined(hintMessage) || !level.players[index].hasSpawned) {
      continue;
    }

    level.players[index] setClientDvar("scr_objectiveText", hintMessage);
    level.players[index] thread maps\mp\gametypes\_hud_message::hintMessage(hintMessage);
  }

  leaderDialog("offense_obj", game["attackers"], "introboost");
  leaderDialog("defense_obj", game["defenders"], "introboost");

  if(game["state"] != "playing") {
    return;
  }

  setDvar("ui_hud_hardcore", level.hardcoreMode);
}

gracePeriod() {
  level endon("game_ended");

  wait(level.gracePeriod);

  level notify("grace_period_ending");
  wait(0.05);

  level.inGracePeriod = false;

  if(game["state"] != "playing") {
    return;
  }

  if(level.numLives) {
    players = level.players;

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!player.hasSpawned && player.sessionteam != "spectator" && !isAlive(player)) {
        player.statusicon = "hud_status_dead";
      }
    }
  }

  level thread updateTeamStatus();
}

announceRoundWinner(winner, delay) {
  if(delay > 0) {
    wait delay;
  }

  if(!isDefined(winner) || isPlayer(winner)) {
    return;
  }

  if(winner == "allies") {
    thread playSoundOnPlayers("mx_round_win" + "_" + level.teamPrefix["allies"]);
    thread playSoundOnPlayers("mx_round_loss" + "_" + level.teamPrefix["axis"]);
    leaderDialog("round_success", "allies");
    leaderDialog("round_failure", "axis");
  } else if(winner == "axis") {
    thread playSoundOnPlayers("mx_round_loss" + "_" + level.teamPrefix["allies"]);
    thread playSoundOnPlayers("mx_round_win" + "_" + level.teamPrefix["axis"]);
    leaderDialog("round_success", "axis");
    leaderDialog("round_failure", "allies");
  } else {
    thread playSoundOnPlayers("mx_round_draw" + "_" + level.teamPrefix["allies"]);
    thread playSoundOnPlayers("mx_round_draw" + "_" + level.teamPrefix["axis"]);
  }
}

announceGameWinner(winner, delay) {
  if(delay > 0) {
    wait delay;
  }

  if(!isDefined(winner) || isPlayer(winner)) {
    return;
  }

  if(winner == "allies") {
    leaderDialog("mission_success", "allies");
    leaderDialog("mission_failure", "axis");
  } else if(winner == "axis") {
    leaderDialog("mission_success", "axis");
    leaderDialog("mission_failure", "allies");
  } else {
    leaderDialog("mission_draw");
  }
}

updateWinStats(winner) {
  winner maps\mp\gametypes\_persistence::statAdd("losses", -1);

  println("setting winner: " + winner maps\mp\gametypes\_persistence::statGet("wins"));
  winner maps\mp\gametypes\_persistence::statAdd("wins", 1);
  winner updatePersRatio("wlratio", "wins", "losses");
  winner maps\mp\gametypes\_persistence::statAdd("cur_win_streak", 1);

  cur_gamemode_win_streak = winner maps\mp\gametypes\_persistence::statGetWithGameType("cur_win_streak");
  gamemode_win_streak = winner maps\mp\gametypes\_persistence::statGetWithGameType("win_streak");

  cur_win_streak = winner maps\mp\gametypes\_persistence::statGet("cur_win_streak");
  if(cur_win_streak > winner maps\mp\gametypes\_persistence::statGet("win_streak")) {
    winner maps\mp\gametypes\_persistence::statSet("win_streak", cur_win_streak, false);
  }

  if(cur_gamemode_win_streak > gamemode_win_streak) {
    winner maps\mp\gametypes\_persistence::statSetWithGameType("win_streak", cur_gamemode_win_streak);
  }

  lpselfnum = winner getEntityNumber();
  lpGuid = winner getGuid();
  logPrint("W;" + lpGuid + ";" + lpselfnum + ";" + winner.name + "\n");
}

updateLossStats(loser) {
  loser maps\mp\gametypes\_persistence::statAdd("losses", 1);
  loser updatePersRatio("wlratio", "wins", "losses");

  lpselfnum = loser getEntityNumber();
  lpGuid = loser getGuid();
  logPrint("L;" + lpGuid + ";" + lpselfnum + ";" + loser.name + "\n");
}

updateTieStats(loser) {
  loser maps\mp\gametypes\_persistence::statAdd("losses", -1);

  loser maps\mp\gametypes\_persistence::statAdd("ties", 1);
  loser updatePersRatio("wlratio", "wins", "losses");
  loser maps\mp\gametypes\_persistence::statSet("cur_win_streak", 0);

  lpselfnum = loser getEntityNumber();
  lpGuid = loser getGuid();
  logPrint("T;" + lpGuid + ";" + lpselfnum + ";" + loser.name + "\n");
}

updateWinLossStats(winner) {
  if(level.roundLimit > 1 && !hitRoundLimit() && !level.hostForcedEnd) {
    return;
  }

  players = level.players;

  if(!isDefined(winner) || (isDefined(winner) && !isPlayer(winner) && winner == "tie")) {
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i].pers["team"])) {
        continue;
      }

      if(level.hostForcedEnd && players[i] getEntityNumber() == 0) {
        continue;
      }

      updateTieStats(players[i]);
    }
  } else if(isPlayer(winner)) {
    if(level.hostForcedEnd && winner getEntityNumber() == 0) {
      return;
    }

    updateWinStats(winner);
  } else {
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i].pers["team"])) {
        continue;
      }

      if(level.hostForcedEnd && players[i] getEntityNumber() == 0) {
        continue;
      }

      if(winner == "tie") {
        updateTieStats(players[i]);
      } else if(players[i].pers["team"] == winner) {
        updateWinStats(players[i]);
      } else {
        if(!level.console) {
          updateLossStats(players[i]);
        }
        players[i] maps\mp\gametypes\_persistence::statSet("cur_win_streak", 0);
      }
    }
  }
}

TimeUntilWavespawn(minimumWait) {
  earliestSpawnTime = gettime() + minimumWait * 1000;

  lastWaveTime = level.lastWave[self.pers["team"]];
  waveDelay = level.waveDelay[self.pers["team"]] * 1000;

  numWavesPassedEarliestSpawnTime = (earliestSpawnTime - lastWaveTime) / waveDelay;
  numWaves = ceil(numWavesPassedEarliestSpawnTime);

  timeOfSpawn = lastWaveTime + numWaves * waveDelay;

  if(isDefined(self.waveSpawnIndex)) {
    timeOfSpawn += 50 * self.waveSpawnIndex;
  }

  return (timeOfSpawn - gettime()) / 1000;
}

ShouldTeamKillKick(teamKillDelay) {
  if(teamKillDelay && maps\mp\gametypes\_tweakables::getTweakableValue("team", "kickteamkillers")) {
    if(getTimePassed() >= 5000) {
      return true;
    }

    if(self.pers["teamkills_nostats"] > 1) {
      return true;
    }
  }

  return false;
}

TeamKillKick() {
  self incPersStat("sessionbans", 1);

  self endon("disconnect");
  waittillframeend;

  playlistbanquantum = maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillerplaylistbanquantum");
  playlistbanpenalty = maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillerplaylistbanpenalty");
  if(playlistbanquantum > 0 && playlistbanpenalty > 0) {
    timeplayedtotal = self maps\mp\gametypes\_persistence::statGet("time_played_total");
    minutesplayed = timeplayedtotal / 60;

    freebees = 2;

    banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;

    if(self.sessionbans > banallowance) {
      self maps\mp\gametypes\_persistence::statSet("gametypeban", timeplayedtotal + (playlistbanpenalty * 60));
    }
  }

  ban(self getentitynumber());
  leaderDialog("kicked");
}

TeamKillDelay() {
  teamkills = self.pers["teamkills_nostats"];
  if(level.minimumAllowedTeamKills < 0 || teamkills <= level.minimumAllowedTeamKills) {
    return 0;
  }

  exceeded = (teamkills - level.minimumAllowedTeamKills);
  return maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillspawndelay") * exceeded;
}

TimeUntilspawn(includeTeamkillDelay) {
  if(level.inGracePeriod && !self.hasSpawned) {
    return 0;
  }

  respawnDelay = 0;
  if(self.hasSpawned) {
    result = self[[level.onRespawnDelay]]();
    if(isDefined(result)) {
      respawnDelay = result;
    } else {
      respawnDelay = getDvarInt("scr_" + level.gameType + "_playerrespawndelay");
    }

    if(includeTeamkillDelay && self.teamKillPunish) {
      respawnDelay += TeamKillDelay();
    }
  }

  waveBased = (getDvarInt("scr_" + level.gameType + "_waverespawndelay") > 0);

  if(waveBased) {
    return self TimeUntilWavespawn(respawnDelay);
  }

  return respawnDelay;
}

mayspawn() {
  if(level.inOvertime) {
    return false;
  }

  if(level.numLives) {
    if(level.teamBased) {
      gameHasStarted = (level.everExisted["axis"] && level.everExisted["allies"]);
    } else {
      gameHasStarted = (level.maxPlayerCount > 1);
    }

    if(!self.pers["lives"] && gameHasStarted) {
      return false;
    } else if(gameHasStarted) {
      if(!level.inGracePeriod && !self.hasSpawned) {
        return false;
      }
    }
  }
  return true;
}

spawnClient(timeAlreadyPassed) {
  assert(isDefined(self.team));
  assert(isValidClass(self.class));

  if(!self mayspawn()) {
    currentorigin = self.origin;
    currentangles = self.angles;

    shouldShowRespawnMessage = true;
    if(level.roundLimit > 1 && game["roundsplayed"] >= (level.roundLimit - 1)) {
      shouldShowRespawnMessage = false;
    }
    if(level.scoreLimit > 1 && level.teambased && game["teamScores"]["allies"] >= level.scoreLimit - 1 && game["teamScores"]["axis"] >= level.scoreLimit - 1) {
      shouldShowRespawnMessage = false;
    }
    if(shouldShowRespawnMessage) {
      setLowerMessage(game["strings"]["spawn_next_round"]);
      self thread removeSpawnMessageShortly(3);
    }
    self thread[[level.spawnSpectator]](currentorigin + (0, 0, 60), currentangles);
    return;
  }

  if(self.waitingToSpawn) {
    return;
  }
  self.waitingToSpawn = true;

  self waitAndSpawnClient(timeAlreadyPassed);

  if(isDefined(self)) {
    self.waitingToSpawn = false;
  }
}

waitAndSpawnClient(timeAlreadyPassed) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("game_ended");

  if(!isDefined(timeAlreadyPassed)) {
    timeAlreadyPassed = 0;
  }

  spawnedAsSpectator = false;

  if(self.teamKillPunish) {
    teamKillDelay = TeamKillDelay();
    if(teamKillDelay > timeAlreadyPassed) {
      teamKillDelay -= timeAlreadyPassed;
      timeAlreadyPassed = 0;
    } else {
      timeAlreadyPassed -= teamKillDelay;
      teamKillDelay = 0;
    }

    if(teamKillDelay > 0) {
      setLowerMessage(&"MP_FRIENDLY_FIRE_WILL_NOT", teamKillDelay);

      self thread respawn_asSpectator(self.origin + (0, 0, 60), self.angles);
      spawnedAsSpectator = true;

      wait(teamKillDelay);
    }

    self.teamKillPunish = false;
  }

  if(!isDefined(self.waveSpawnIndex) && isDefined(level.wavePlayerSpawnIndex[self.team])) {
    self.waveSpawnIndex = level.wavePlayerSpawnIndex[self.team];
    level.wavePlayerSpawnIndex[self.team]++;
  }

  timeUntilSpawn = TimeUntilspawn(false);
  if(timeUntilSpawn > timeAlreadyPassed) {
    timeUntilSpawn -= timeAlreadyPassed;
    timeAlreadyPassed = 0;
  } else {
    timeAlreadyPassed -= timeUntilSpawn;
    timeUntilSpawn = 0;
  }

  if(timeUntilSpawn > 0) {
    setLowerMessage(game["strings"]["waiting_to_spawn"], timeUntilSpawn);

    if(!spawnedAsSpectator) {
      self thread respawn_asSpectator(self.origin + (0, 0, 60), self.angles);
    }
    spawnedAsSpectator = true;

    self waitForTimeOrNotify(timeUntilSpawn, "force_spawn");

    self notify("stop_wait_safe_spawn_button");
  }

  waveBased = (getDvarInt("scr_" + level.gameType + "_waverespawndelay") > 0);
  if(maps\mp\gametypes\_tweakables::getTweakableValue("player", "forcerespawn") == 0 && self.hasSpawned && !waveBased && !self.wantSafeSpawn) {
    setLowerMessage(game["strings"]["press_to_spawn"]);

    if(!spawnedAsSpectator) {
      self thread respawn_asSpectator(self.origin + (0, 0, 60), self.angles);
    }
    spawnedAsSpectator = true;

    self waitRespawnOrSafeSpawnButton();
  }

  self.waitingToSpawn = false;

  self clearLowerMessage();

  self.waveSpawnIndex = undefined;

  self thread[[level.spawnPlayer]]();
}

rumbler() {
  self endon("disconnect");
  while(1) {
    wait(0.1);
    self PlayRumbleOnEntity("damage_heavy");
  }
}

waitRespawnOrSafeSpawnButton() {
  self endon("disconnect");
  self endon("end_respawn");

  while(1) {
    if(self useButtonPressed()) {
      break;
    }

    wait .05;
  }
}

waitForTimeOrNotify(time, notifyname) {
  self endon(notifyname);
  wait time;
}

waitForTimeOrNotifyNoArtillery(time, notifyname) {
  self endon(notifyname);
  wait time;
  while(isDefined(level.artilleryInProgress)) {
    assert(level.artilleryInProgress);
    wait .25;
  }
}

removeSpawnMessageShortly(delay) {
  self endon("disconnect");

  waittillframeend;

  self endon("end_respawn");

  wait delay;

  self clearLowerMessage(2.0);
}

Callback_StartGameType() {
  level.prematchPeriod = 0;
  level.intermission = false;

  if(!isDefined(game["gamestarted"])) {
    if(!isDefined(game["allies"])) {
      game["allies"] = "marines";
    }
    if(!isDefined(game["axis"])) {
      game["axis"] = "japanese";
    }
    if(!isDefined(game["attackers"])) {
      game["attackers"] = "allies";
    }
    if(!isDefined(game["defenders"])) {
      game["defenders"] = "axis";
    }

    if(!isDefined(game["state"])) {
      game["state"] = "playing";
    }

    precacheStatusIcon("hud_status_dead");
    precacheStatusIcon("hud_status_connecting");

    precacheRumble("damage_heavy");

    precacheShader("white");
    precacheShader("black");

    makeDvarServerInfo("scr_allies", "usmc");
    makeDvarServerInfo("scr_axis", "japanese");

    makeDvarServerInfo("cg_thirdPersonAngle", 354);

    setDvar("cg_thirdPersonAngle", 354);

    game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
    if(level.teamBased) {
      game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_TEAMS";
      game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
    } else {
      game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_PLAYERS";
      game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
    }
    game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
    game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
    game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";

    game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
    game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["last_stand"] = &"MPUI_LAST_STAND";

    game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";

    game["strings"]["tie"] = &"MP_MATCH_TIE";
    game["strings"]["round_draw"] = &"MP_ROUND_DRAW";

    game["strings"]["enemies_eliminated"] = &"MP_ENEMIES_ELIMINATED";
    game["strings"]["score_limit_reached"] = &"MP_SCORE_LIMIT_REACHED";
    game["strings"]["round_limit_reached"] = &"MP_ROUND_LIMIT_REACHED";
    game["strings"]["time_limit_reached"] = &"MP_TIME_LIMIT_REACHED";
    game["strings"]["players_forfeited"] = &"MP_PLAYERS_FORFEITED";

    switch (game["allies"]) {
      case "russian":
        game["strings"]["allies_win"] = &"MP_RUSSIAN_WIN_MATCH";
        game["strings"]["allies_win_round"] = &"MP_RUSSIAN_WIN_ROUND";
        game["strings"]["allies_mission_accomplished"] = &"MP_RUSSIAN_MISSION_ACCOMPLISHED";
        game["strings"]["allies_eliminated"] = &"MP_RUSSIAN_ELIMINATED";
        game["strings"]["allies_forfeited"] = &"MP_RUSSIAN_FORFEITED";
        game["strings"]["allies_name"] = &"MP_RUSSIAN_NAME";

        game["music"]["spawn_allies"] = "mp_spawn_soviet";
        game["music"]["victory_allies"] = "mp_victory_soviet";
        game["icons"]["allies"] = "faction_128_soviet";
        game["colors"]["allies"] = (0, 0, 0);
        game["voice"]["allies"] = "RU_1mc_";
        setDvar("scr_allies", "ussr");
        break;
      default:
      case "marines":
        game["strings"]["allies_win"] = &"MP_MARINE_WIN_MATCH";
        game["strings"]["allies_win_round"] = &"MP_MARINE_WIN_ROUND";
        game["strings"]["allies_mission_accomplished"] = &"MP_MARINE_MISSION_ACCOMPLISHED";
        game["strings"]["allies_eliminated"] = &"MP_MARINE_ELIMINATED";
        game["strings"]["allies_forfeited"] = &"MP_MARINE_FORFEITED";
        game["strings"]["allies_name"] = &"MP_MARINE_NAME";

        game["music"]["spawn_allies"] = "mp_spawn_usa";
        game["music"]["victory_allies"] = "mp_victory_usa";
        game["icons"]["allies"] = "faction_128_american";
        game["colors"]["allies"] = (0.6, 0.64, 0.69);
        game["voice"]["allies"] = "US_1mc_";
        setDvar("scr_allies", "usmc");
        break;
    }
    switch (game["axis"]) {
      case "german":
        game["strings"]["axis_win"] = &"MP_GERMAN_WIN_MATCH";
        game["strings"]["axis_win_round"] = &"MP_GERMAN_WIN_ROUND";
        game["strings"]["axis_mission_accomplished"] = &"MP_GERMAN_MISSION_ACCOMPLISHED";
        game["strings"]["axis_eliminated"] = &"MP_GERMAN_ELIMINATED";
        game["strings"]["axis_forfeited"] = &"MP_GERMAN_FORFEITED";
        game["strings"]["axis_name"] = &"MP_GERMAN_NAME";

        game["music"]["spawn_axis"] = "mp_spawn_german";
        game["music"]["victory_axis"] = "mp_victory_german";
        game["icons"]["axis"] = "faction_128_german";
        game["colors"]["axis"] = (0.65, 0.57, 0.41);
        game["voice"]["axis"] = "GE_1mc_";
        setDvar("scr_axis", "german");
        break;
      default:
      case "japanese":
        game["strings"]["axis_win"] = &"MP_JAPANESE_WIN_MATCH";
        game["strings"]["axis_win_round"] = &"MP_JAPANESE_WIN_ROUND";
        game["strings"]["axis_mission_accomplished"] = &"MP_JAPANESE_MISSION_ACCOMPLISHED";
        game["strings"]["axis_eliminated"] = &"MP_JAPANESE_ELIMINATED";
        game["strings"]["axis_forfeited"] = &"MP_JAPANESE_FORFEITED";
        game["strings"]["axis_name"] = &"MP_JAPANESE_NAME";

        game["music"]["spawn_axis"] = "mp_spawn_japanese";
        game["music"]["victory_axis"] = "mp_victory_japanese";
        game["icons"]["axis"] = "faction_128_japan";
        game["colors"]["axis"] = (0.52, 0.28, 0.28);
        game["voice"]["axis"] = "JP_1mc_";
        setDvar("scr_axis", "japanese");
        break;
    }
    game["music"]["defeat"] = "mp_defeat";
    game["music"]["victory_spectator"] = "mp_defeat";
    game["music"]["winning"] = "mp_time_running_out_winning";
    game["music"]["losing"] = "mp_time_running_out_losing";
    game["music"]["match_end"] = "mx_match_end";
    game["music"]["victory_tie"] = "mp_defeat";

    game["music"]["suspense"] = [];
    game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_01";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_02";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_03";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_04";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_05";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_06";

    game["dialog"]["mission_success"] = "mission_success";
    game["dialog"]["mission_failure"] = "mission_fail";
    game["dialog"]["mission_draw"] = "draw";

    game["dialog"]["round_success"] = "encourage_win";
    game["dialog"]["round_failure"] = "encourage_lost";
    game["dialog"]["round_draw"] = "draw";

    game["dialog"]["timesup"] = "timesup";
    game["dialog"]["winning"] = "winning";
    game["dialog"]["losing"] = "losing";
    game["dialog"]["lead_lost"] = "lead_lost";
    game["dialog"]["lead_tied"] = "tied";
    game["dialog"]["lead_taken"] = "lead_taken";
    game["dialog"]["last_alive"] = "lastalive";

    game["dialog"]["boost"] = "boost";

    if(!isDefined(game["dialog"]["offense_obj"])) {
      game["dialog"]["offense_obj"] = "boost";
    }
    if(!isDefined(game["dialog"]["defense_obj"])) {
      game["dialog"]["defense_obj"] = "boost";
    }

    game["dialog"]["hardcore"] = "hardcore";
    game["dialog"]["oldschool"] = "oldschool";
    game["dialog"]["highspeed"] = "highspeed";
    game["dialog"]["tactical"] = "tactical";

    game["dialog"]["challenge"] = "challengecomplete";
    game["dialog"]["promotion"] = "promotion";

    game["dialog"]["bomb_taken"] = "bomb_taken";
    game["dialog"]["bomb_lost"] = "bomb_lost";
    game["dialog"]["bomb_defused"] = "bomb_defused";
    game["dialog"]["bomb_planted"] = "bomb_planted";

    game["dialog"]["obj_taken"] = "securedobj";
    game["dialog"]["obj_lost"] = "lostobj";

    game["dialog"]["obj_defend"] = "obj_defend";
    game["dialog"]["obj_destroy"] = "obj_destroy";
    game["dialog"]["obj_capture"] = "capture_obj";
    game["dialog"]["objs_capture"] = "capture_objs";

    game["dialog"]["hq_located"] = "hq_located";
    game["dialog"]["hq_enemy_captured"] = "hq_captured";
    game["dialog"]["hq_enemy_destroyed"] = "hq_destroyed";
    game["dialog"]["hq_secured"] = "hq_secured";
    game["dialog"]["hq_offline"] = "hq_offline";
    game["dialog"]["hq_online"] = "hq_online";

    game["dialog"]["move_to_new"] = "new_positions";

    game["dialog"]["attack"] = "attack";
    game["dialog"]["defend"] = "defend";
    game["dialog"]["offense"] = "offense";
    game["dialog"]["defense"] = "defense";

    game["dialog"]["halftime"] = "halftime";
    game["dialog"]["overtime"] = "overtime";
    game["dialog"]["finalfight"] = "finalfight";
    game["dialog"]["side_switch"] = "switching";

    game["dialog"]["flag_taken"] = "ourflag";
    game["dialog"]["flag_dropped"] = "ourflag_drop";
    game["dialog"]["flag_returned"] = "ourflag_return";
    game["dialog"]["flag_captured"] = "ourflag_capt";
    game["dialog"]["enemy_flag_taken"] = "enemyflag";
    game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
    game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
    game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";

    game["dialog"]["capturing_a"] = "capturing_a";
    game["dialog"]["capturing_b"] = "capturing_b";
    game["dialog"]["capturing_c"] = "capturing_c";
    game["dialog"]["capturing_d"] = "capturing_d";
    game["dialog"]["capturing_e"] = "capturing_e";
    game["dialog"]["capturing_f"] = "capturing_f";
    game["dialog"]["captured_a"] = "capture_a";
    game["dialog"]["captured_b"] = "capture_b";
    game["dialog"]["captured_c"] = "capture_c";
    game["dialog"]["captured_d"] = "capture_d";
    game["dialog"]["captured_e"] = "capture_e";
    game["dialog"]["captured_f"] = "capture_f";

    game["dialog"]["securing_a"] = "securing_a";
    game["dialog"]["securing_b"] = "securing_b";
    game["dialog"]["securing_c"] = "securing_c";
    game["dialog"]["securing_d"] = "securing_d";
    game["dialog"]["securing_e"] = "securing_e";
    game["dialog"]["securing_f"] = "securing_f";
    game["dialog"]["secured_a"] = "secure_a";
    game["dialog"]["secured_b"] = "secure_b";
    game["dialog"]["secured_c"] = "secure_c";
    game["dialog"]["secured_d"] = "secure_d";
    game["dialog"]["secured_e"] = "secure_e";
    game["dialog"]["secured_f"] = "secure_f";

    game["dialog"]["losing_a"] = "losing_a";
    game["dialog"]["losing_b"] = "losing_b";
    game["dialog"]["losing_c"] = "losing_c";
    game["dialog"]["losing_d"] = "losing_d";
    game["dialog"]["losing_e"] = "losing_e";
    game["dialog"]["losing_f"] = "losing_f";
    game["dialog"]["lost_a"] = "lost_a";
    game["dialog"]["lost_b"] = "lost_b";
    game["dialog"]["lost_c"] = "lost_c";
    game["dialog"]["lost_d"] = "lost_d";
    game["dialog"]["lost_e"] = "lost_e";
    game["dialog"]["lost_f"] = "lost_f";

    game["dialog"]["enemy_taking_a"] = "enemy_take_a";
    game["dialog"]["enemy_taking_b"] = "enemy_take_b";
    game["dialog"]["enemy_taking_c"] = "enemy_take_c";
    game["dialog"]["enemy_taking_d"] = "enemy_take_d";
    game["dialog"]["enemy_taking_e"] = "enemy_take_e";
    game["dialog"]["enemy_taking_f"] = "enemy_take_f";
    game["dialog"]["enemy_has_a"] = "enemy_has_a";
    game["dialog"]["enemy_has_b"] = "enemy_has_b";
    game["dialog"]["enemy_has_c"] = "enemy_has_c";
    game["dialog"]["enemy_has_d"] = "enemy_has_d";
    game["dialog"]["enemy_has_e"] = "enemy_has_e";
    game["dialog"]["enemy_has_f"] = "enemy_has_f";

    game["dialog"]["secure_flag"] = "secure_flag";
    game["dialog"]["securing_flag"] = "securing_flag";
    game["dialog"]["losing_flag"] = "losing_flag";
    game["dialog"]["lost_flag"] = "lost_flag";
    game["dialog"]["oneflag_enemy"] = "oneflag_enemy";
    game["dialog"]["oneflag_friendly"] = "oneflag_friendly";

    game["dialog"]["lost_all"] = "take_positions";
    game["dialog"]["secure_all"] = "positions_lock";

    game["dialog"]["squad_move"] = "squad_move";
    game["dialog"]["squad_30sec"] = "squad_30sec";
    game["dialog"]["squad_winning"] = "squad_onemin_vic";
    game["dialog"]["squad_losing"] = "squad_onemin_loss";
    game["dialog"]["squad_down"] = "squad_down";
    game["dialog"]["squad_bomb"] = "squad_bomb";
    game["dialog"]["squad_plant"] = "squad_plant";
    game["dialog"]["squad_take"] = "squad_takeobj";

    game["dialog"]["kicked"] = "player_kicked";

    [[level.onPrecacheGameType]]();

    game["gamestarted"] = true;

    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;

    if(!level.splitscreen) {
      level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "graceperiod");
    }
  }

  if(!isDefined(game["timepassed"])) {
    game["timepassed"] = 0;
  }

  if(!isDefined(game["roundsplayed"])) {
    game["roundsplayed"] = 0;
  }

  level.skipVote = false;
  level.gameEnded = false;
  level.teamSpawnPoints["axis"] = [];
  level.teamSpawnPoints["allies"] = [];

  level.objIDStart = 0;
  level.forcedEnd = false;
  level.hostForcedEnd = false;

  level.hardcoreMode = getDvarInt("scr_hardcore");
  if(level.hardcoreMode) {
    logString("game mode: hardcore");
  }

  if(getDvar("scr_max_rank") == "") {
    setDvar("scr_max_rank", "0");
  }
  level.rankCap = getDvarInt("scr_max_rank");
  if(level.rankCap) {
    logString("rank cap: " + level.rankCap);
  }

  level.useStartSpawns = true;

  if(getDvar("scr_teamKillPunishCount") == "") {
    setDvar("scr_teamKillPunishCount", "3");
  }
  level.minimumAllowedTeamKills = getdvarint("scr_teamKillPunishCount") - 1;

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  thread maps\mp\gametypes\_persistence::init();
  thread maps\mp\gametypes\_menus::init();
  thread maps\mp\gametypes\_hud::init();
  thread maps\mp\gametypes\_serversettings::init();
  thread maps\mp\gametypes\_clientids::init();
  thread maps\mp\gametypes\_teams::init();
  thread maps\mp\gametypes\_weapons::init();
  thread maps\mp\gametypes\_scoreboard::init();
  thread maps\mp\gametypes\_killcam::init();
  thread maps\mp\gametypes\_shellshock::init();
  thread maps\mp\gametypes\_deathicons::init();
  thread maps\mp\gametypes\_damagefeedback::init();
  thread maps\mp\gametypes\_healthoverlay::init();
  thread maps\mp\gametypes\_spectating::init();
  thread maps\mp\gametypes\_objpoints::init();
  thread maps\mp\gametypes\_gameobjects::init();
  thread maps\mp\gametypes\_spawnlogic::init();
  thread maps\mp\gametypes\_oldschool::init();
  thread maps\mp\gametypes\_battlechatter_mp::init();

  thread maps\mp\gametypes\_hardpoints::init();

  thread maps\mp\gametypes\_squad::init();

  if(level.teamBased) {
    thread maps\mp\gametypes\_friendicons::init();
  }

  thread maps\mp\gametypes\_hud_message::init();

  if(!level.console) {
    thread maps\mp\gametypes\_quickmessages::init();
  }

  stringNames = getArrayKeys(game["strings"]);
  for(index = 0; index < stringNames.size; index++) {
    precacheString(game["strings"][stringNames[index]]);
  }

  level.maxPlayerCount = 0;
  level.playerCount["allies"] = 0;
  level.playerCount["axis"] = 0;
  level.aliveCount["allies"] = 0;
  level.aliveCount["axis"] = 0;
  level.playerLives["allies"] = 0;
  level.playerLives["axis"] = 0;
  level.lastAliveCount["allies"] = 0;
  level.lastAliveCount["axis"] = 0;
  level.everExisted["allies"] = false;
  level.everExisted["axis"] = false;
  level.waveDelay["allies"] = 0;
  level.waveDelay["axis"] = 0;
  level.lastWave["allies"] = 0;
  level.lastWave["axis"] = 0;
  level.wavePlayerSpawnIndex["allies"] = 0;
  level.wavePlayerSpawnIndex["axis"] = 0;
  level.alivePlayers["allies"] = [];
  level.alivePlayers["axis"] = [];
  level.activePlayers = [];
  level.squads["allies"] = [];
  level.squads["axis"] = [];

  level.allowAnnouncer = getdvarint("scr_allowannouncer");

  if(!isDefined(level.timeLimit)) {
    registerTimeLimitDvar("default", 10, 1, 1440);
  }

  if(!isDefined(level.scoreLimit)) {
    registerScoreLimitDvar("default", 100, 1, 500);
  }

  if(!isDefined(level.roundLimit)) {
    registerRoundLimitDvar("default", 1, 0, 10);
  }

  makeDvarServerInfo("ui_scorelimit");
  makeDvarServerInfo("ui_timelimit");
  makeDvarServerInfo("ui_allow_classchange", getDvar("ui_allow_classchange"));

  waveDelay = getDvarInt("scr_" + level.gameType + "_waverespawndelay");
  if(waveDelay) {
    level.waveDelay["allies"] = waveDelay;
    level.waveDelay["axis"] = waveDelay;
    level.lastWave["allies"] = 0;
    level.lastWave["axis"] = 0;

    level thread[[level.waveSpawnTimer]]();
  }

  level.inPrematchPeriod = true;

  if(level.prematchPeriod > 2.0) {
    level.prematchPeriod = level.prematchPeriod + (randomFloat(4) - 2);
  }

  if(level.numLives || level.waveDelay["allies"] || level.waveDelay["axis"]) {
    level.gracePeriod = 15;
  } else {
    level.gracePeriod = 5;
  }

  level.inGracePeriod = true;

  level.roundEndDelay = 5;
  level.halftimeRoundEndDelay = 3;

  updateTeamScores("axis", "allies");

  if(!level.teamBased) {
    thread initialDMScoreUpdate();
  }

  [[level.onStartGameType]]();

  thread maps\mp\gametypes\_dev::init();

  thread startGame();
  level thread updateGameTypeDvars();
}

initialDMScoreUpdate() {
  wait .2;
  numSent = 0;
  while(1) {
    didAny = false;

    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.updatedDMScores)) {
        continue;
      }

      player.updatedDMScores = true;
      player updateDMScores();

      didAny = true;
      wait .5;
    }

    if(!didAny) {
      wait 3;
    }
  }
}

checkRoundSwitch() {
  if(!isDefined(level.roundSwitch) || !level.roundSwitch) {
    return false;
  }
  if(!isDefined(level.onRoundSwitch)) {
    return false;
  }

  assert(game["roundsplayed"] > 0);

  if(game["roundsplayed"] % level.roundswitch == 0) {
    [[level.onRoundSwitch]]();
    return true;
  }

  return false;
}

getGameScore(team) {
  return game["teamScores"][team];
}

fakeLag() {
  self endon("disconnect");
  self.fakeLag = randomIntRange(50, 150);

  for(;;) {
    self setClientDvar("fakelag_target", self.fakeLag);
    wait(randomFloatRange(5.0, 15.0));
  }
}

listenForGameEnd() {
  self waittill("host_sucks_end_game");
  if(level.console) {
    endparty();
  }
  level.skipVote = true;

  if(!level.gameEnded) {
    level thread maps\mp\gametypes\_globallogic::forceEnd(true);
  }
}

Callback_PlayerConnect() {
  thread notifyConnecting();

  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  waittillframeend;
  self.statusicon = "";

  level notify("connected", self);

  if(level.console && self getEntityNumber() == 0) {
    self thread listenForGameEnd();
  }

  if(!level.splitscreen && !isDefined(self.pers["score"])) {
    iPrintLn(&"MP_CONNECTED", self);
  }

  lpselfnum = self getEntityNumber();
  lpGuid = self getGuid();
  logPrint("J;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");

  self setClientDvars("cg_drawSpectatorMessages", 1, "ui_hud_hardcore", getDvar("ui_hud_hardcore"), "player_sprintTime", getDvar("scr_player_sprinttime"), "g_compassShowEnemies", getDvar("scr_game_forceradar"), "ui_radar_client", getDvar("ui_radar_client"));

  if(level.hardcoreMode) {
    self setClientDvars("cg_drawTalk", 3, "cg_drawCrosshair", 0, "cg_hudGrenadeIconMaxRangeFrag", 0);
  } else {
    self setClientDvars("cg_drawCrosshair", 1, "cg_hudGrenadeIconMaxRangeFrag", 250);
  }

  if(level.splitScreen) {
    self setClientDvars("cg_hudGrenadeIconHeight", "37.5", "cg_hudGrenadeIconWidth", "37.5", "cg_hudGrenadeIconOffset", "75", "cg_hudGrenadePointerHeight", "18", "cg_hudGrenadePointerWidth", "37.5", "cg_hudGrenadePointerPivot", "18 40.5", "cg_fovscale", "0.75");
  } else {
    self setClientDvars("cg_hudGrenadeIconHeight", "25", "cg_hudGrenadeIconWidth", "25", "cg_hudGrenadeIconOffset", "50", "cg_hudGrenadePointerHeight", "12", "cg_hudGrenadePointerWidth", "25", "cg_hudGrenadePointerPivot", "12 27", "cg_fovscale", "1");
  }

  if(level.oldschool) {
    self setClientDvars("ragdoll_explode_force", 60000, "ragdoll_explode_upbias", 0.8, "bg_fallDamageMinHeight", 256, "bg_fallDamageMaxHeight", 512, "player_sprintUnlimited", 1, "player_clipSizeMultiplier", 2.0);
  }

  if(getdvarint("scr_hitloc_debug")) {
    for(i = 0; i < 6; i++) {
      self setClientDvar("ui_hitloc_" + i, "");
    }
    self.hitlocInited = true;
  }

  self initPersStat("score");
  self.score = self.pers["score"];

  self initPersStat("deaths");
  self.deaths = self getPersStat("deaths");

  self initPersStat("suicides");
  self.suicides = self getPersStat("suicides");

  self initPersStat("kills");
  self.kills = self getPersStat("kills");

  self initPersStat("headshots");
  self.headshots = self getPersStat("headshots");

  self initPersStat("challenges");
  self.challenges = self getPersStat("challenges");

  self initPersStat("assists");
  self.assists = self getPersStat("assists");

  self initPersStat("sessionbans");
  self.sessionbans = self getPersStat("sessionbans");
  self initPersStat("gametypeban");
  self initPersStat("time_played_total");

  self initPersStat("teamkills", false);
  self initPersStat("teamkills_nostats");
  self.teamKillPunish = false;
  if(level.minimumAllowedTeamKills >= 0 && self.pers["teamkills_nostats"] > level.minimumAllowedTeamKills) {
    self thread reduceTeamKillsOverTime();
  }

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self.killedPlayersCurrent = [];

  if(!isDefined(self.pers["best_kill_streak"])) {
    self.pers["killed_players"] = [];
    self.pers["killed_by"] = [];
    self.pers["nemesis_tracking"] = [];
    self.pers["uav_used"] = 0;
    self.pers["artillery_used"] = 0;
    self.pers["dogs_used"] = 0;
    self.pers["artillery_kills"] = 0;
    self.pers["dog_kills"] = 0;
    self.pers["nemesis_name"] = "";
    self.pers["nemesis_rank"] = 0;
    self.pers["nemesis_rankIcon"] = 0;
    self.pers["nemesis_xp"] = 0;
    self.pers["nemesis_xuid"] = "";

    self.pers["best_kill_streak"] = 0;

    self setClientDvars("ns_n", "", "ns_r", "0", "ns_ri", "0", "ns_x", "0", "ns_k", "0", "ns_d", "0", "ns_id", "", "ps_n", "", "ps_h", "0", "ps_k", "0", "ps_d", "0", "ps_kds", "0", "ps_st", "0", "ps_r", "0", "ps_ac", "0", "ps_ak", "0", "ps_dc", "0", "ps_dk", "0");
  }

  self.leaderDialogQueue = [];
  self.leaderDialogActive = false;
  self.leaderDialogGroups = [];
  self.leaderDialogGroup = "";

  self.cur_kill_streak = 0;

  self.cur_death_streak = 0;
  self.death_streak = self maps\mp\gametypes\_persistence::statGet("death_streak");
  self.kill_streak = self maps\mp\gametypes\_persistence::statGet("kill_streak");
  self.gametype_death_streak = self maps\mp\gametypes\_persistence::statGetWithGameType("death_streak");
  self.gametype_kill_streak = self maps\mp\gametypes\_persistence::statGetWithGameType("kill_streak");

  self.lastGrenadeSuicideTime = -1;

  self.teamkillsThisRound = 0;

  self.pers["lives"] = level.numLives;

  self.hasSpawned = false;
  self.waitingToSpawn = false;
  self.wantSafeSpawn = false;
  self.deathCount = 0;

  self.wasAliveAtMatchStart = false;

  self thread maps\mp\_flashgrenades::monitorFlash();

  if(level.numLives) {
    self setClientDvars("cg_deadChatWithDead", "1", "cg_deadChatWithTeam", "0", "cg_deadHearTeamLiving", "0", "cg_deadHearAllLiving", "0", "cg_everyoneHearsEveryone", "0");
  } else {
    self setClientDvars("cg_deadChatWithDead", "0", "cg_deadChatWithTeam", "1", "cg_deadHearTeamLiving", "1", "cg_deadHearAllLiving", "0", "cg_everyoneHearsEveryone", "0");
  }

  level.players[level.players.size] = self;

  if(level.splitscreen) {
    setDvar("splitscreen_playerNum", level.players.size);
  }

  if(level.teambased) {
    self updateScores();
  }

  setmusicstate("UNDERSCORE", self);
  if(game["state"] == "postgame") {
    self.pers["team"] = "spectator";
    self.team = "spectator";

    self setClientDvars("ui_hud_hardcore", 1, "cg_drawSpectatorMessages", 0);

    [[level.spawnIntermission]]();
    self closeMenu();
    self closeInGameMenu();
    return;
  }

  if(!isDefined(self.pers["lossAlreadyReported"])) {
    if(level.console) {
      updateLossStats(self);
    }
    if((level.gameType == "ctf") || (level.gameType == "twar")) {
      self.pers["lossAlreadyReported"] = true;
    }
  }

  level endon("game_ended");

  if(level.oldschool) {
    self.pers["class"] = undefined;
    self.class = self.pers["class"];
  }

  if(isDefined(self.pers["team"])) {
    self.team = self.pers["team"];
  }

  if(isDefined(self.pers["class"])) {
    self.class = self.pers["class"];
  }

  if(!isDefined(self.pers["team"])) {
    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.sessionstate = "dead";

    self updateObjectiveText();

    [[level.spawnSpectator]]();

    if(level.rankedMatch && level.console) {
      [[level.autoassign]]();

      self thread kickIfDontspawn();
    } else if(!level.teamBased && level.console) {
      [[level.autoassign]]();
    } else {
      self setclientdvar("g_scriptMainMenu", game["menu_team"]);
      self openMenu(game["menu_team"]);
    }

    if(self.pers["team"] == "spectator") {
      self.sessionteam = "spectator";
    }

    if(level.teamBased) {
      self.sessionteam = self.pers["team"];
      if(!isAlive(self)) {
        self.statusicon = "hud_status_dead";
      }
      self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
    }
  } else if(self.pers["team"] == "spectator") {
    self setclientdvar("g_scriptMainMenu", game["menu_team"]);
    [[level.spawnSpectator]]();
    self.sessionteam = "spectator";
    self.sessionstate = "spectator";
  } else {
    self.sessionteam = self.pers["team"];
    self.sessionstate = "dead";

    self updateObjectiveText();

    [[level.spawnSpectator]]();

    if(isValidClass(self.pers["class"])) {
      self thread[[level.spawnClient]]();
    } else {
      self showMainMenuForTeam();
    }

    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
  }

  if(isDefined(self.pers["isBot"])) {
    return;
  }
}

forcespawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");

  wait(60.0);

  if(self.hasSpawned) {
    return;
  }

  if(self.pers["team"] == "spectator") {
    return;
  }

  if(!isValidClass(self.pers["class"])) {
    if(getDvarInt("onlinegame")) {
      self.pers["class"] = "CLASS_CUSTOM1";
    } else {
      self.pers["class"] = "CLASS_ASSAULT";
    }

    self.class = self.pers["class"];
  }

  self closeMenus();
  self thread[[level.spawnClient]]();
}

kickIfDontspawn() {
  if(self getEntityNumber() == 0) {
    return;
  }

  self kickIfIDontSpawnInternal();
}

kickIfIDontSpawnInternal() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");

  waittime = 90;
  if(getDvar("scr_kick_time") != "") {
    waittime = getdvarfloat("scr_kick_time");
  }
  mintime = 45;
  if(getDvar("scr_kick_mintime") != "") {
    mintime = getdvarfloat("scr_kick_mintime");
  }

  starttime = gettime();

  kickWait(waittime);

  timePassed = (gettime() - starttime) / 1000;
  if(timePassed < waittime - .1 && timePassed < mintime) {
    return;
  }

  if(self.hasSpawned) {
    return;
  }

  if(self.pers["team"] == "spectator") {
    return;
  }

  kick(self getEntityNumber());
}

kickWait(waittime) {
  level endon("game_ended");
  wait waittime;
}

Callback_PlayerDisconnect() {
  self removePlayerOnDisconnect();

  if(!level.gameEnded) {
    self logXPGains();
  }

  if(level.splitscreen) {
    players = level.players;

    if(players.size <= 1) {
      level thread maps\mp\gametypes\_globallogic::forceEnd();
    }

    setDvar("splitscreen_playerNum", players.size);
  }

  if(isDefined(self.score) && isDefined(self.pers["team"])) {
    setPlayerTeamRank(self, level.dropTeam, self.score - 5 * self.deaths);
    self logString("team: score " + self.pers["team"] + ":" + self.score);
    level.dropTeam += 1;
  }

  [[level.onPlayerDisconnect]]();

  lpselfnum = self getEntityNumber();
  lpGuid = self getGuid();
  logPrint("Q;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");

  for(entry = 0; entry < level.players.size; entry++) {
    if(level.players[entry] == self) {
      while(entry < level.players.size - 1) {
        level.players[entry] = level.players[entry + 1];
        entry++;
      }
      level.players[entry] = undefined;
      break;
    }
  }
  for(entry = 0; entry < level.players.size; entry++) {
    if(isDefined(level.players[entry].pers["killed_players"][self.name])) {
      level.players[entry].pers["killed_players"][self.name] = undefined;
    }

    if(isDefined(level.players[entry].killedPlayersCurrent[self.name])) {
      level.players[entry].killedPlayersCurrent[self.name] = undefined;
    }

    if(isDefined(level.players[entry].pers["killed_by"][self.name])) {
      level.players[entry].pers["killed_by"][self.name] = undefined;
    }
  }

  if(level.gameEnded) {
    self removeDisconnectedPlayerFromPlacement();
  }

  level thread updateTeamStatus();
}

removePlayerOnDisconnect() {
  for(entry = 0; entry < level.players.size; entry++) {
    if(level.players[entry] == self) {
      while(entry < level.players.size - 1) {
        level.players[entry] = level.players[entry + 1];
        entry++;
      }
      level.players[entry] = undefined;
      break;
    }
  }
}

isHeadShot(sWeapon, sHitLoc, sMeansOfDeath) {
  return (sHitLoc == "head" || sHitLoc == "helmet") && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_BAYONET" && sMeansOfDeath != "MOD_IMPACT";
}

Callback_VehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, damageFromUnderneath, modelIndex, partName) {
  if(!(level.iDFLAGS_RADIUS &iDFlags)) {
    iDamage = maps\mp\gametypes\_class::cac_modified_vehicle_damage(self, eAttacker, iDamage, sMeansOfDeath, sWeapon, eInflictor);
  }

  self.iDFlags = iDFlags;
  self.iDFlagsTime = getTime();

  if(game["state"] == "postgame") {
    return;
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(eAttacker.canDoCombat) && !eAttacker.canDoCombat) {
    return;
  }

  if(!isDefined(vDir)) {
    iDFlags |= level.iDFLAGS_NO_KNOCKBACK;
  }

  friendly = false;

  if(((self.health == self.maxhealth)) || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerData = [];
    self.attackerDamage = [];
  }

  if(sWeapon == "none" && isDefined(eInflictor)) {
    if(isDefined(eInflictor.targetname) && eInflictor.targetname == "explodable_barrel") {
      sWeapon = "explodable_barrel";
    } else if(isDefined(eInflictor.destructible_type) && isSubStr(eInflictor.destructible_type, "vehicle_")) {
      sWeapon = "destructible_car";
    }
  }

  if(!(iDFlags &level.iDFLAGS_NO_PROTECTION)) {
    if(self IsVehicleImmuneToDamage(iDFlags, sMeansOfDeath, sWeapon)) {
      return;
    }

    if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET") {
      iDamage = GetVehicleBulletDamage(sWeapon);
    } else if(sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_GRENADE") {
      iDamage *= GetVehicleProjectileScalar(sWeapon);
      iDamage = int(iDamage);

      if(iDamage == 0) {
        return;
      }
    } else if(sMeansOfDeath == "MOD_GRENADE_SPLASH") {
      iDamage *= GetVehicleUnderneathSplashScalar(sWeapon);
      iDamage = int(iDamage);

      if(iDamage == 0) {
        return;
      }
    }

    iDamage *= level.vehicleDamageScalar;
    iDamage = int(iDamage);

    if(isPlayer(eAttacker)) {
      eAttacker.pers["participation"]++;
    }

    prevHealthRatio = self.health / self.maxhealth;

    occupant_team = self maps\mp\_vehicles::vehicle_get_occupant_team();

    if(level.teamBased && isPlayer(eAttacker) && (occupant_team == eAttacker.pers["team"])) {
      if(level.friendlyfire == 0) {
        if(sWeapon != "artillery_mp") {
          return;
        }

        vehicle = eAttacker GetVehicleOccupied();

        if(isDefined(vehicle) && vehicle == self) {
          {}

          if(iDamage < 1) {
            iDamage = 1;
          }

          self.lastDamageWasFromEnemy = false;

          self finishVehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, damageFromUnderneath, modelIndex, partName, true);
        } else {
          return;
        }
      } else if(level.friendlyfire == 1) {
        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;

        self finishVehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, damageFromUnderneath, modelIndex, partName, false);
      } else if(level.friendlyfire == 2) {
        if(sWeapon != "artillery_mp") {
          return;
        }

        vehicle = eAttacker GetVehicleOccupied();

        if(isDefined(vehicle) && vehicle == self) {
          {}

          if(iDamage < 1) {
            iDamage = 1;
          }

          self.lastDamageWasFromEnemy = false;

          self finishVehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, damageFromUnderneath, modelIndex, partName, true);
        } else {
          return;
        }
      } else if(level.friendlyfire == 3) {
        iDamage = int(iDamage * .5);

        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;

        self finishVehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, damageFromUnderneath, modelIndex, partName, false);
      }

      friendly = true;
    } else {
      if(iDamage < 1) {
        iDamage = 1;
      }

      if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(sWeapon)) {
        eAttacker maps\mp\gametypes\_weapons::checkHit(sWeapon);
      }

      if(issubstr(sMeansOfDeath, "MOD_GRENADE") && isDefined(eInflictor.isCooked)) {
        self.wasCooked = getTime();
      } else {
        self.wasCooked = undefined;
      }

      attacker_seat = undefined;
      if(isDefined(eAttacker)) {
        attacker_seat = self GetOccupantSeat(eAttacker);
      }

      self.lastDamageWasFromEnemy = (isDefined(eAttacker) && !isDefined(attacker_seat));

      self finishVehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, damageFromUnderneath, modelIndex, partName, false);
    }

    if(isDefined(eAttacker) && eAttacker != self) {
      if(sWeapon != "artillery_mp" && (!isDefined(eInflictor) || !isai(eInflictor))) {
        hasBodyArmor = false;

        if(iDamage > 0) {
          eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(hasBodyArmor, sMeansOfDeath);
        }
      }
    }
  }

  if(getDvarInt("g_debugDamage")) {
    println("actor:" + self getEntityNumber() + " health:" + self.health + " attacker:" + eAttacker.clientid + " inflictor is player:" + isPlayer(eInflictor) + " damage:" + iDamage + " hitLoc:" + sHitLoc);
  }

  if(1) {
    lpselfnum = self getEntityNumber();
    lpselfteam = "";
    lpattackerteam = "";

    if(isPlayer(eAttacker)) {
      lpattacknum = eAttacker getEntityNumber();
      lpattackGuid = eAttacker getGuid();
      lpattackname = eAttacker.name;
      lpattackerteam = eAttacker.pers["team"];
    } else {
      lpattacknum = -1;
      lpattackGuid = "";
      lpattackname = "";
      lpattackerteam = "world";
    }

    logPrint("VD;" + lpselfnum + ";" + lpselfteam + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
  }
}

Callback_VehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, psOffsetTime) {
  iDamage = maps\mp\gametypes\_class::cac_modified_vehicle_damage(self, eAttacker, iDamage, sMeansOfDeath, sWeapon, eInflictor);
  fInnerDamage = maps\mp\gametypes\_class::cac_modified_vehicle_damage(self, eAttacker, fInnerDamage, sMeansOfDeath, sWeapon, eInflictor);
  fOuterDamage = maps\mp\gametypes\_class::cac_modified_vehicle_damage(self, eAttacker, fOuterDamage, sMeansOfDeath, sWeapon, eInflictor);
  self.iDFlags = iDFlags;
  self.iDFlagsTime = getTime();

  if(game["state"] == "postgame") {
    return;
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(eAttacker.canDoCombat) && !eAttacker.canDoCombat) {
    return;
  }

  friendly = false;

  if(!(iDFlags &level.iDFLAGS_NO_PROTECTION)) {
    if(self IsVehicleImmuneToDamage(iDFlags, sMeansOfDeath, sWeapon)) {
      return;
    }

    if(sMeansOfDeath == "MOD_PROJECTILE_SPLASH" || sMeansOfDeath == "MOD_GRENADE_SPLASH" || sMeansOfDeath == "MOD_EXPLOSIVE") {
      scalar = GetVehicleProjectileSplashScalar(sWeapon);
      iDamage = int(iDamage * scalar);
      fInnerDamage = (fInnerDamage * scalar);
      fOuterDamage = (fOuterDamage * scalar);

      if(fInnerDamage == 0) {
        return;
      }
      if(iDamage < 1) {
        iDamage = 1;
      }
    }

    occupant_team = self maps\mp\_vehicles::vehicle_get_occupant_team();

    if(level.teamBased && isPlayer(eAttacker) && (occupant_team == eAttacker.pers["team"])) {
      if(level.friendlyfire == 0) {
        if(sWeapon != "artillery_mp") {
          return;
        }

        vehicle = eAttacker GetVehicleOccupied();

        if(isDefined(vehicle) && vehicle == self) {
          {}

          if(iDamage < 1) {
            iDamage = 1;
          }

          self.lastDamageWasFromEnemy = false;

          self finishVehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, psOffsetTime);
        } else {
          return;
        }
      } else if(level.friendlyfire == 1) {
        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;

        self finishVehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, psOffsetTime);
      } else if(level.friendlyfire == 2) {
        if(sWeapon != "artillery_mp") {
          return;
        }

        vehicle = eAttacker GetVehicleOccupied();

        if(isDefined(vehicle) && vehicle == self) {
          {}

          if(iDamage < 1) {
            iDamage = 1;
          }

          self.lastDamageWasFromEnemy = false;

          self finishVehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, psOffsetTime);
        } else {
          return;
        }
      } else if(level.friendlyfire == 3) {
        iDamage = int(iDamage * .5);

        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;

        self finishVehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, psOffsetTime);
      }

      friendly = true;
    } else {
      if(iDamage < 1) {
        iDamage = 1;
      }

      self finishVehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, psOffsetTime);
    }
  }
}

Callback_PlayerSpawnGenerateInfluencers(
  player_entity, spawn_influencers) {
  return;
}
Callback_PlayerSpawnGenerateSpawnPointEntityBaseScore(
  player_entity, spawn_point_entity) {
  return 0.0;
}

Callback_ActorDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  iDamage = maps\mp\gametypes\_class::cac_modified_damage(self, eAttacker, iDamage, sMeansOfDeath, sWeapon, eInflictor);
  self.iDFlags = iDFlags;
  self.iDFlagsTime = getTime();

  if(game["state"] == "postgame") {
    return;
  }

  if(self.aiteam == "spectator") {
    return;
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(eAttacker.canDoCombat) && !eAttacker.canDoCombat) {
    return;
  }

  if(!isDefined(vDir)) {
    iDFlags |= level.iDFLAGS_NO_KNOCKBACK;
  }

  friendly = false;

  if(((self.health == self.maxhealth)) || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerData = [];
    self.attackerDamage = [];
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath)) {
    sMeansOfDeath = "MOD_HEAD_SHOT";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("game", "onlyheadshots")) {
    if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET") {
      return;
    } else if(sMeansOfDeath == "MOD_HEAD_SHOT") {
      iDamage = 150;
    }
  }

  if(sMeansOfDeath == "MOD_GRENADE" && sWeapon == "molotov_mp") {
    self thread maps\mp\_burnplayer::directHitWithMolotov();
  }

  if(sMeansOfDeath == "MOD_BURNED") {
    if(sWeapon == "none") {
      self maps\mp\_burnplayer::walkedThroughFlames();
    }
    if(sWeapon == "m2_flamethrower_mp") {
      self maps\mp\_burnplayer::burnedWithFlameThrower();
    }
  }

  if(sWeapon == "none" && isDefined(eInflictor)) {
    if(isDefined(eInflictor.targetname) && eInflictor.targetname == "explodable_barrel") {
      sWeapon = "explodable_barrel";
    } else if(isDefined(eInflictor.destructible_type) && isSubStr(eInflictor.destructible_type, "vehicle_")) {
      sWeapon = "destructible_car";
    }
  }

  if(maps\mp\_dogs::dog_get_dvar_int("debug_dog_attack", "0") == 2) {
    iDamage = 1;
  }

  if(!(iDFlags &level.iDFLAGS_NO_PROTECTION)) {
    if(isPlayer(eAttacker)) {
      eAttacker.pers["participation"]++;
    }

    prevHealthRatio = self.health / self.maxhealth;

    if(level.teamBased && isPlayer(eAttacker) && (self != eAttacker) && (self.aiteam == eAttacker.pers["team"])) {
      if(level.friendlyfire == 0) {
        return;
      } else if(level.friendlyfire == 1) {
        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;

        self finishActorDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
      } else if(level.friendlyfire == 2) {
        return;
      } else if(level.friendlyfire == 3) {
        iDamage = int(iDamage * .5);

        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;

        self finishActorDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
      }

      friendly = true;
    } else {
      if(isDefined(eAttacker) && isDefined(self.script_owner) && eAttacker == self.script_owner && !level.hardcoreMode) {
        return;
      }

      if(isDefined(eAttacker) && isDefined(self.script_owner) && isDefined(eAttacker.script_owner) && eAttacker.script_owner == self.script_owner) {
        return;
      }

      if(iDamage < 1) {
        iDamage = 1;
      }

      if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(sWeapon)) {
        eAttacker maps\mp\gametypes\_weapons::checkHit(sWeapon);
      }

      if(issubstr(sMeansOfDeath, "MOD_GRENADE") && isDefined(eInflictor.isCooked)) {
        self.wasCooked = getTime();
      } else {
        self.wasCooked = undefined;
      }

      self.lastDamageWasFromEnemy = (isDefined(eAttacker) && (eAttacker != self));

      self finishActorDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
    }

    if(isDefined(eAttacker) && eAttacker != self) {
      hasBodyArmor = false;

      if(sWeapon != "artillery_mp" && (!isDefined(eInflictor) || !isai(eInflictor))) {
        if(iDamage > 0) {
          eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(hasBodyArmor, sMeansOfDeath);
        }
      }
    }
  }

  if(getDvarInt("g_debugDamage")) {
    println("actor:" + self getEntityNumber() + " health:" + self.health + " attacker:" + eAttacker.clientid + " inflictor is player:" + isPlayer(eInflictor) + " damage:" + iDamage + " hitLoc:" + sHitLoc);
  }

  if(1) {
    lpselfnum = self getEntityNumber();
    lpselfteam = self.aiteam;

    if(isPlayer(eAttacker)) {
      lpattacknum = eAttacker getEntityNumber();
      lpattackGuid = eAttacker getGuid();
      lpattackname = eAttacker.name;
      lpattackerteam = eAttacker.pers["team"];
    } else {
      lpattacknum = -1;
      lpattackGuid = "";
      lpattackname = "";
      lpattackerteam = "world";
    }

    logPrint("AD;" + lpselfnum + ";" + lpselfteam + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
  }
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  iDamage = maps\mp\gametypes\_class::cac_modified_damage(self, eAttacker, iDamage, sMeansOfDeath, sWeapon, eInflictor);
  self.iDFlags = iDFlags;
  self.iDFlagsTime = getTime();

  if(game["state"] == "postgame") {
    return;
  }

  if(self.sessionteam == "spectator") {
    return;
  }

  if(isDefined(self.canDoCombat) && !self.canDoCombat) {
    return;
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(eAttacker.canDoCombat) && !eAttacker.canDoCombat) {
    return;
  }

  if(isDefined(eAttacker)) {
    if(isai(eAttacker) && isDefined(eAttacker.script_owner)) {
      if(eAttacker.script_owner.team != self.team) {
        eAttacker = eAttacker.script_owner;
      }
    }

    if(eAttacker.classname == "script_vehicle" && isDefined(eAttacker.owner)) {
      eAttacker = eAttacker.owner;
    }
  }

  prof_begin("PlayerDamage flags/tweaks");

  if(!isDefined(vDir)) {
    iDFlags |= level.iDFLAGS_NO_KNOCKBACK;
  }

  friendly = false;

  self thread threadedSetStatLBByName(sWeapon, 1, "hits by", 2);

  if(((self.health == self.maxhealth)) || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerData = [];
    self.attackerDamage = [];
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath)) {
    sMeansOfDeath = "MOD_HEAD_SHOT";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("game", "onlyheadshots")) {
    if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET") {
      return;
    } else if(sMeansOfDeath == "MOD_HEAD_SHOT") {
      iDamage = 150;
    }
  }

  if(self maps\mp\_vehicles::player_is_occupant_invulnerable(sMeansOfDeath)) {
    return;
  }

  if((sMeansOfDeath == "MOD_GRENADE" && sWeapon == "molotov_mp") || (sMeansOfDeath == "MOD_BURNED")) {
    self thread doFlameAudio();
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && ((self.pers["team"] != eAttacker.pers["team"]) || (game["dialog"]["gametype"] == "freeforall"))) {
    self.lastAttackWeapon = sWeapon;

    if(eAttacker player_is_driver()) {
      vehicle = eAttacker GetVehicleOccupied();
      self.lastTankThatAttacked = vehicle;
      self thread clearLastTankAttacker();
    }

    if(sMeansOfDeath == "MOD_GRENADE" && sWeapon == "molotov_mp") {
      if(!self hasperk("specialty_fireproof")) {
        self thread maps\mp\_burnplayer::directHitWithMolotov(eAttacker, eInflictor, "MOD_BURNED");
      }
    }

    if(sMeansOfDeath == "MOD_BURNED") {
      if(sWeapon == "none") {
        if(!self hasperk("specialty_fireproof")) {
          self thread maps\mp\_burnplayer::walkedThroughFlames();
        }
      } else if(sWeapon == "m2_flamethrower_mp") {
        if(!self hasperk("specialty_fireproof")) {
          self thread maps\mp\_burnplayer::burnedWithFlameThrower();
        }
      }
    }
  }

  if(sWeapon == "none" && isDefined(eInflictor)) {
    if(isDefined(eInflictor.targetname) && eInflictor.targetname == "explodable_barrel") {
      sWeapon = "explodable_barrel";
    } else if(isDefined(eInflictor.destructible_type) && isSubStr(eInflictor.destructible_type, "vehicle_")) {
      sWeapon = "destructible_car";
    }
  }

  prof_end("PlayerDamage flags/tweaks");

  if(iDFlags &level.iDFLAGS_PENETRATION && eAttacker hasPerk("specialty_bulletpenetration")) {
    self thread maps\mp\gametypes\_battlechatter_mp::perkSpecificBattleChatter("deepimpact", true);
  }

  if(!(iDFlags &level.iDFLAGS_NO_PROTECTION)) {
    if(level.teamBased && isDefined(level.chopper) && isDefined(eAttacker) && eAttacker == level.chopper && eAttacker.team == self.pers["team"]) {
      return;
    }

    if((isSubStr(sMeansOfDeath, "MOD_GRENADE") || isSubStr(sMeansOfDeath, "MOD_EXPLOSIVE") || isSubStr(sMeansOfDeath, "MOD_PROJECTILE")) && isDefined(eInflictor)) {
      if(eInflictor.classname == "grenade" && (self.lastSpawnTime + 3500) > getTime() && distance(eInflictor.origin, self.lastSpawnPoint.origin) < 250) {
        return;
      }

      self.explosiveInfo = [];
      self.explosiveInfo["damageTime"] = getTime();
      self.explosiveInfo["damageId"] = eInflictor getEntityNumber();
      self.explosiveInfo["returnToSender"] = false;
      self.explosiveInfo["bulletPenetrationKill"] = false;
      self.explosiveInfo["chainKill"] = false;
      self.explosiveInfo["counterKill"] = false;
      self.explosiveInfo["chainKill"] = false;
      self.explosiveInfo["cookedKill"] = false;
      self.explosiveInfo["weapon"] = sWeapon;

      isFrag = isSubStr(sWeapon, "frag_");

      if(eAttacker != self) {
        if((isSubStr(sWeapon, "satchel_") || isSubStr(sWeapon, "mine_bouncing_betty_")) && isDefined(eAttacker) && isDefined(eInflictor.owner)) {
          {}
          self.explosiveInfo["returnToSender"] = (eInflictor.owner == self);
          self.explosiveInfo["counterKill"] = isDefined(eInflictor.wasDamaged);
          self.explosiveInfo["chainKill"] = isDefined(eInflictor.wasChained);
          self.explosiveInfo["ohnoyoudontKill"] = isDefined(eInflictor.wasJustPlanted);
          self.explosiveInfo["bulletPenetrationKill"] = isDefined(eInflictor.wasDamagedFromBulletPenetration);
          self.explosiveInfo["cookedKill"] = false;
        }
        if((isSubStr(sWeapon, "sticky_grenade_")) && isDefined(eInflictor)) {
          {}
          self.explosiveInfo["stuckToPlayer"] = isDefined(eInflictor.stuckToPlayer);
        }
        if(isDefined(eAttacker.lastGrenadeSuicideTime) && eAttacker.lastGrenadeSuicideTime >= gettime() - 50 && isFrag) {
          {}
          self.explosiveInfo["suicideGrenadeKill"] = true;
        } else {
          {}
          self.explosiveInfo["suicideGrenadeKill"] = false;
        }
      }

      if(isFrag) {
        self.explosiveInfo["cookedKill"] = isDefined(eInflictor.isCooked);
        self.explosiveInfo["throwbackKill"] = isDefined(eInflictor.threwBack);
      }
    }

    if(isPlayer(eAttacker)) {
      eAttacker.pers["participation"]++;
    }

    prevHealthRatio = self.health / self.maxhealth;

    if(level.teamBased && isPlayer(eAttacker) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"])) {
      prof_begin("PlayerDamage player");
      if(level.friendlyfire == 0) {
        if(sWeapon == "artillery_mp") {
          self damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage);
        }
        return;
      } else if(level.friendlyfire == 1) {
        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;

        self finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
      } else if(level.friendlyfire == 2 && isAlive(eAttacker)) {
        iDamage = int(iDamage * .5);

        if(iDamage < 1) {
          iDamage = 1;
        }

        eAttacker.lastDamageWasFromEnemy = false;

        eAttacker.friendlydamage = true;
        eAttacker finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
        eAttacker.friendlydamage = undefined;
      } else if(level.friendlyfire == 3 && isAlive(eAttacker)) {
        iDamage = int(iDamage * .5);

        if(iDamage < 1) {
          iDamage = 1;
        }

        self.lastDamageWasFromEnemy = false;
        eAttacker.lastDamageWasFromEnemy = false;

        self finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
        eAttacker.friendlydamage = true;
        eAttacker finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
        eAttacker.friendlydamage = undefined;
      }

      friendly = true;
      prof_end("PlayerDamage player");
    } else {
      prof_begin("PlayerDamage world");

      if(iDamage < 1) {
        iDamage = 1;
      }

      if(isDefined(eAttacker) && isPlayer(eAttacker)) {
        if(!isDefined(self.attackerData[eAttacker.clientid])) {
          {}
          self.attackerDamage[eAttacker.clientid] = iDamage;
          self.attackers[self.attackers.size] = eAttacker;

          self.attackerData[eAttacker.clientid] = false;
        } else {
          {}
          self.attackerDamage[eAttacker.clientid] += iDamage;
        }
        if(maps\mp\gametypes\_weapons::isPrimaryWeapon(sWeapon)) {
          self.attackerData[eAttacker.clientid] = true;
        }
      }

      if(isDefined(eAttacker)) {
        level.lastLegitimateAttacker = eAttacker;
      }

      if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(sWeapon)) {
        eAttacker maps\mp\gametypes\_weapons::checkHit(sWeapon);
      }

      if(issubstr(sMeansOfDeath, "MOD_GRENADE") && isDefined(eInflictor.isCooked)) {
        self.wasCooked = getTime();
      } else {
        self.wasCooked = undefined;
      }

      self.lastDamageWasFromEnemy = (isDefined(eAttacker) && (eAttacker != self));

      self finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);

      self thread maps\mp\gametypes\_missions::playerDamaged(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc);

      prof_end("Callback_PlayerDamage world");
    }

    if(isDefined(eAttacker) && eAttacker != self) {
      if(sWeapon != "artillery_mp" && (!isDefined(eInflictor) || !isai(eInflictor))) {
        hasBodyArmor = false;
        if(self hasPerk("specialty_armorvest") && sWeapon != "m2_flamethrower_mp") {
          {}
          hasBodyArmor = true;

          if(isPlayer(eAttacker)) {
            eAttacker thread maps\mp\gametypes\_battlechatter_mp::perkSpecificBattleChatter("juggernaut");
          }
        }

        if(iDamage > 0) {
          eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(hasBodyArmor, sMeansOfDeath);
        }
      }
    }

    self.hasDoneCombat = true;
  }

  if(isDefined(eAttacker) && eAttacker != self && !friendly) {
    level.useStartSpawns = false;
  }

  prof_begin("PlayerDamage log");

  if(getDvarInt("g_debugDamage")) {
    println("client:" + self getEntityNumber() + " health:" + self.health + " attacker:" + eAttacker.clientid + " inflictor is player:" + isPlayer(eInflictor) + " damage:" + iDamage + " hitLoc:" + sHitLoc);
  }

  if(self.sessionstate != "dead") {
    lpselfnum = self getEntityNumber();
    lpselfname = self.name;
    lpselfteam = self.pers["team"];
    lpselfGuid = self getGuid();
    lpattackerteam = "";

    if(isPlayer(eAttacker)) {
      lpattacknum = eAttacker getEntityNumber();
      lpattackGuid = eAttacker getGuid();
      lpattackname = eAttacker.name;
      lpattackerteam = eAttacker.pers["team"];
    } else {
      lpattacknum = -1;
      lpattackGuid = "";
      lpattackname = "";
      lpattackerteam = "world";
    }

    logPrint("D;" + lpselfGuid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
  }

  if(getdvarint("scr_hitloc_debug")) {
    if(!isDefined(eAttacker.hitlocInited)) {
      for(i = 0; i < 6; i++) {
        eAttacker setClientDvar("ui_hitloc_" + i, "");
      }
      eAttacker.hitlocInited = true;
    }

    if(isPlayer(eAttacker) && !level.splitscreen) {
      colors = [];
      colors[0] = 2;
      colors[1] = 3;
      colors[2] = 5;
      colors[3] = 7;

      elemcount = 6;
      if(!isDefined(eAttacker.damageInfo)) {
        eAttacker.damageInfo = [];
        for(i = 0; i < elemcount; i++) {
          {}
          eAttacker.damageInfo[i] = spawnStruct();
          eAttacker.damageInfo[i].damage = 0;
          eAttacker.damageInfo[i].hitloc = "";
          eAttacker.damageInfo[i].bp = false;
          eAttacker.damageInfo[i].jugg = false;
          eAttacker.damageInfo[i].colorIndex = 0;
        }
        eAttacker.damageInfoColorIndex = 0;
        eAttacker.damageInfoVictim = undefined;
      }

      for(i = elemcount - 1; i > 0; i--) {
        eAttacker.damageInfo[i].damage = eAttacker.damageInfo[i - 1].damage;
        eAttacker.damageInfo[i].hitloc = eAttacker.damageInfo[i - 1].hitloc;
        eAttacker.damageInfo[i].bp = eAttacker.damageInfo[i - 1].bp;
        eAttacker.damageInfo[i].jugg = eAttacker.damageInfo[i - 1].jugg;
        eAttacker.damageInfo[i].colorIndex = eAttacker.damageInfo[i - 1].colorIndex;
      }
      eAttacker.damageInfo[0].damage = iDamage;
      eAttacker.damageInfo[0].hitloc = sHitLoc;
      eAttacker.damageInfo[0].bp = (iDFlags &level.iDFLAGS_PENETRATION);
      eAttacker.damageInfo[0].jugg = self hasPerk("specialty_armorvest");
      if(isDefined(eAttacker.damageInfoVictim) && eAttacker.damageInfoVictim != self) {
        eAttacker.damageInfoColorIndex++;
        if(eAttacker.damageInfoColorIndex == colors.size) {
          eAttacker.damageInfoColorIndex = 0;
        }
      }
      eAttacker.damageInfoVictim = self;
      eAttacker.damageInfo[0].colorIndex = eAttacker.damageInfoColorIndex;

      for(i = 0; i < elemcount; i++) {
        color = "^" + colors[eAttacker.damageInfo[i].colorIndex];
        if(eAttacker.damageInfo[i].hitloc != "") {
          {}
          val = color + eAttacker.damageInfo[i].hitloc;
          if(eAttacker.damageInfo[i].bp) {
            val += " (BP)";
          }
          if(eAttacker.damageInfo[i].jugg) {
            val += " (Jugg)";
          }
          eAttacker setClientDvar("ui_hitloc_" + i, val);
        }
        eAttacker setClientDvar("ui_hitloc_damage_" + i, color + eAttacker.damageInfo[i].damage);
      }
    }
  }

  prof_end("PlayerDamage log");
}

player_is_driver() {
  if(!isalive(self)) {
    return false;
  }

  vehicle = self GetVehicleOccupied();

  if(isDefined(vehicle)) {
    seat = vehicle GetOccupantSeat(self);

    if(isDefined(seat) && seat == 0) {
      return true;
    }
  }

  return false;
}

doFlameAudio() {
  self endon("disconnect");
  waittillframeend;

  if(!isDefined(self.lastFlameHurtAudio)) {
    self.lastFlameHurtAudio = 0;
  }

  currentTime = gettime();

  if(self.lastFlameHurtAudio + level.fire_audio_repeat_duration + RandomInt(level.fire_audio_random_max_duration) < currentTime) {
    self playLocalSound("player_pain_small");
    self.lastFlameHurtAudio = currentTime;
  }
}

Callback_ActorKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime) {
  if(game["state"] == "postgame") {
    return;
  }

  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(attacker.script_owner.team != self.aiteam) {
      attacker = attacker.script_owner;
    }
  }

  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  if(isDefined(attacker) && isPlayer(attacker)) {
    if(!level.teamBased || (self.aiteam != attacker.pers["team"])) {
      value = maps\mp\gametypes\_rank::getScoreInfoValue("dogkill");
      attacker thread maps\mp\gametypes\_rank::giveRankXP("dogkill", value);
      givePlayerScore("dogkill", attacker, self);

      if(level.teamBased) {
        giveTeamScore("dogkill", attacker.pers["team"], attacker, self);
      }
    }

  }
}

finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);

  if(getDvar("scr_csmode") != "") {
    self shellShock("damage_mp", 0.2);
  }

  self damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage);
}

damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage) {
  self thread maps\mp\gametypes\_weapons::onWeaponDamage(eInflictor, sWeapon, sMeansOfDeath, iDamage);
  self PlayRumbleOnEntity("damage_heavy");
}

default_getTeamKillPenalty(eInflictor, attacker, sMeansOfDeath, sWeapon) {
  teamkill_penalty = 1;

  if(sWeapon == "artillery_mp") {
    teamkill_penalty = maps\mp\gametypes\_tweakables::getTweakableValue("team", "artilleryTeamKillPenalty");
  }
  return teamkill_penalty;
}

default_getTeamKillScore(eInflictor, attacker, sMeansOfDeath, sWeapon) {
  return maps\mp\gametypes\_rank::getScoreInfoValue("kill");
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  self endon("spawned");
  self notify("killed_player");

  if(self.sessionteam == "spectator") {
    return;
  }

  if(game["state"] == "postgame") {
    return;
  }

  self needsRevive(false);

  if(sWeapon == "none" && isDefined(eInflictor)) {
    if(isDefined(eInflictor.targetname) && eInflictor.targetname == "explodable_barrel") {
      sWeapon = "explodable_barrel";
    } else if(isDefined(eInflictor.destructible_type) && isSubStr(eInflictor.destructible_type, "vehicle_")) {
      sWeapon = "destructible_car";
    }
  }

  prof_begin("PlayerKilled pre constants");

  deathTimeOffset = 0;
  if(isDefined(self.useLastStandParams)) {
    self.useLastStandParams = undefined;

    assert(isDefined(self.lastStandParams));

    eInflictor = self.lastStandParams.eInflictor;
    attacker = self.lastStandParams.attacker;
    iDamage = self.lastStandParams.iDamage;
    sMeansOfDeath = self.lastStandParams.sMeansOfDeath;
    sWeapon = self.lastStandParams.sWeapon;
    vDir = self.lastStandParams.vDir;
    sHitLoc = self.lastStandParams.sHitLoc;

    deathTimeOffset = (gettime() - self.lastStandParams.lastStandStartTime) / 1000;

    self.lastStandParams = undefined;

    self thread maps\mp\gametypes\_battlechatter_mp::perkSpecificBattleChatter("secondchance");
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath)) {
    sMeansOfDeath = "MOD_HEAD_SHOT";
  }

  if(isai(attacker)) {
    attacker notify("killed", self);
  }

  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(!level.teambased || attacker.script_owner.team != self.team) {
      attacker = attacker.script_owner;
    }
  }

  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  if((isDefined(self.capturingLastFlag)) && (self.capturingLastFlag == true)) {
    attacker.lastCapKiller = true;
  }

  if(sWeapon == "dog_bite_mp") {
    sMeansOfDeath = "MOD_PISTOL_BULLET";
  }

  self thread trackLeaderBoardDeathStats(sWeapon, sMeansOfDeath);
  attacker thread trackAttackerLeaderBoardDeathStats(sWeapon, sMeansOfDeath);

  if(level.teamBased && isDefined(attacker.pers) && self.team == attacker.team && sMeansOfDeath == "MOD_GRENADE" && level.friendlyfire == 0) {
    obituary(self, self, sWeapon, sMeansOfDeath);
  } else {
    obituary(self, attacker, sWeapon, sMeansOfDeath);
  }
  if(!level.inGracePeriod) {
    self maps\mp\gametypes\_weapons::dropWeaponForDeath(attacker);
    self maps\mp\gametypes\_weapons::dropOffhand();
  }

  maps\mp\gametypes\_spawnlogic::deathOccured(self, attacker);

  self.sessionstate = "dead";
  self.statusicon = "hud_status_dead";

  self.pers["weapon"] = undefined;

  self.killedPlayersCurrent = [];

  self.deathCount++;

  println("players(" + self.clientId + ") death count ++: " + self.deathCount);

  if(self.cur_kill_streak >= 5 && isPlayer(attacker)) {
    level thread maps\mp\gametypes\_battlechatter_mp::sayLocalSoundDelayed(attacker, "kill_killstreak", "killstreak", 0.75);
  }

  if(!isDefined(self.switching_teams)) {
    if(isPlayer(attacker) && level.teamBased && (attacker != self) && (self.pers["team"] == attacker.pers["team"])) {
      self.cur_kill_streak = 0;
    } else {
      self incPersStat("deaths", 1);
      self.deaths = self getPersStat("deaths");
      self updatePersRatio("kdratio", "kills", "deaths");

      if(self.cur_kill_streak > self.pers["best_kill_streak"]) {
        self.pers["best_kill_streak"] = self.cur_kill_streak;
      }

      self.cur_kill_streak = 0;
      self.cur_death_streak++;

      if(self.cur_death_streak > self.death_streak) {
        self maps\mp\gametypes\_persistence::statSet("death_streak", self.cur_death_streak);
        self.death_streak = self.cur_death_streak;
        self.gametype_death_streak = self.cur_death_streak;
      } else if(self.cur_death_streak > self.gametype_death_streak) {
        self maps\mp\gametypes\_persistence::statSetWithGameType("death_streak", self.cur_death_streak);
        self.gametype_death_streak = self.cur_death_streak;
      }
    }
  }

  lpselfnum = self getEntityNumber();
  lpselfname = self.name;
  lpattackGuid = "";
  lpattackname = "";
  if(isDefined(self.pers["team"])) {
    lpselfteam = self.pers["team"];
  } else {
    lpselfteam = "";
  }
  lpselfguid = self getGuid();
  lpattackerteam = "";

  lpattacknum = -1;

  prof_end("PlayerKilled pre constants");

  prof_begin("PlayerKilled constants");
  if(isPlayer(attacker)) {
    lpattackGuid = attacker getGuid();
    lpattackname = attacker.name;
    if(isDefined(attacker.pers["team"])) {
      lpattackerteam = attacker.pers["team"];
    } else {
      lpattackerteam = "";
    }

    if(attacker == self) {
      doKillcam = false;

      if(isDefined(self.switching_teams)) {
        if(!level.teamBased && ((self.leaving_team == "allies" && self.joining_team == "axis") || (self.leaving_team == "axis" && self.joining_team == "allies"))) {
          {}
          playerCounts = self maps\mp\gametypes\_teams::CountPlayers();
          playerCounts[self.leaving_team]--;
          playerCounts[self.joining_team]++;

          if((playerCounts[self.joining_team] - playerCounts[self.leaving_team]) > 1) {
            self thread[[level.onXPEvent]]("suicide");
            self incPersStat("suicides", 1);
            self.suicides = self getPersStat("suicides");
          }
        }
      } else {
        self thread[[level.onXPEvent]]("suicide");
        self incPersStat("suicides", 1);
        self.suicides = self getPersStat("suicides");

        scoreSub = maps\mp\gametypes\_tweakables::getTweakableValue("game", "suicidepointloss");
        _setPlayerScore(self, _getPlayerScore(self) - scoreSub);

        if(sMeansOfDeath == "MOD_SUICIDE" && sHitLoc == "none" && self.throwingGrenade) {
          {}
          self.lastGrenadeSuicideTime = gettime();
        }

        thread maps\mp\gametypes\_battlechatter_mp::onPlayerSuicideOrTeamKill(self, "suicide");
      }

      if(isDefined(self.friendlydamage)) {
        self iPrintLn(&"MP_FRIENDLY_FIRE_WILL_NOT");
      }
    } else {
      prof_begin("PlayerKilled attacker");

      lpattacknum = attacker getEntityNumber();

      doKillcam = true;

      if(level.teamBased && self.pers["team"] == attacker.pers["team"] && sMeansOfDeath == "MOD_GRENADE" && level.friendlyfire == 0) {} else if(level.teamBased && self.pers["team"] == attacker.pers["team"]) {
        attacker thread[[level.onXPEvent]]("teamkill");

        if(!IgnoreTeamKills(sWeapon, sMeansOfDeath)) {
          {}
          teamkill_penalty = self[[level.getTeamKillPenalty]](eInflictor, attacker, sMeansOfDeath, sWeapon);

          attacker incPersStat("teamkills_nostats", teamkill_penalty, false);
          attacker incPersStat("teamkills", 1);
          attacker.teamkillsThisRound++;

          if(maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillpointloss")) {
            scoreSub = self[[level.getTeamKillScore]](eInflictor, attacker, sMeansOfDeath, sWeapon);
            _setPlayerScore(attacker, _getPlayerScore(attacker) - scoreSub);
          }

          if(getTimePassed() < 5000) {
            teamKillDelay = 1;
          } else if(attacker.pers["teamkills_nostats"] > 1 && getTimePassed() < (8000 + (attacker.pers["teamkills_nostats"] * 1000))) {
            teamKillDelay = 1;
          } else {
            teamKillDelay = attacker TeamKillDelay();
          }

          if(teamKillDelay > 0) {
            attacker.teamKillPunish = true;
            attacker suicide();

            if(attacker ShouldTeamKillKick(teamKillDelay)) {
              {}
              attacker thread TeamKillKick();
            }

            attacker thread reduceTeamKillsOverTime();
          }

          if(isPlayer(attacker)) {
            thread maps\mp\gametypes\_battlechatter_mp::onPlayerSuicideOrTeamKill(attacker, "teamkill");
          }
        }
      } else {
        prof_begin("pks1");

        attacker thread giveKillXP(sMeansOfDeath);

        attacker incPersStat("kills", 1);
        attacker.kills = attacker getPersStat("kills");
        attacker updatePersRatio("kdratio", "kills", "deaths");

        if(isAlive(attacker)) {
          {}
          if(!isDefined(eInflictor) || !isDefined(eInflictor.requiredDeathCount) || attacker.deathCount == eInflictor.requiredDeathCount) {
            attacker.cur_kill_streak++;

            if(isDefined(level.hardpointItems)) {
              attacker thread maps\mp\gametypes\_hardpoints::giveHardpointItemForStreak();
            }
          }

          if(isPlayer(attacker)) {
            self thread maps\mp\gametypes\_battlechatter_mp::onPlayerKillstreak(attacker);
          }
        }

        attacker.cur_death_streak = 0;

        if(attacker.cur_kill_streak > attacker.kill_streak) {
          {}
          attacker maps\mp\gametypes\_persistence::statSet("kill_streak", attacker.cur_kill_streak);
          attacker.kill_streak = attacker.cur_kill_streak;
          attacker.gametype_kill_streak = attacker.cur_kill_streak;
        } else if(attacker.cur_kill_streak > attacker.gametype_kill_streak) {
          {}
          attacker maps\mp\gametypes\_persistence::statSetWithGametype("kill_streak", attacker.cur_kill_streak);
          attacker.gametype_kill_streak = attacker.cur_kill_streak;
        }

        givePlayerScore("kill", attacker, self);

        attacker thread trackAttackerKill(self.name, self.pers["rank"], self.pers["rankxp"], self.pers["prestige"], self getXuid(true));

        attackerName = attacker.name;
        self thread trackAttackeeDeath(attackerName, attacker.pers["rank"], attacker.pers["rankxp"], attacker.pers["prestige"], attacker getXuid(true));

        attacker thread incKillstreakTracker(sWeapon);

        if(level.teamBased && attacker.pers["team"] != "spectator") {
          {}

          if(isai(Attacker)) {
            giveTeamScore("kill", attacker.aiteam, attacker, self);
          } else {
            giveTeamScore("kill", attacker.pers["team"], attacker, self);
          }
        }

        scoreSub = maps\mp\gametypes\_tweakables::getTweakableValue("game", "deathpointloss");
        if(scoreSub != 0) {
          {}
          _setPlayerScore(self, _getPlayerScore(self) - scoreSub);
        }

        if(attacker.cur_kill_streak <= 5 && isPlayer(attacker)) {
          {}
          if(isDefined(level.bcKillInformProbability) && randomIntRange(0, 100) >= level.bcKillInformProbability) {
            level thread maps\mp\gametypes\_battlechatter_mp::sayLocalSoundDelayed(attacker, "kill", "infantry", 0.75);
          }
        }

        prof_end("pks1");

        if(level.teamBased) {
          {}
          prof_begin("PlayerKilled assists");

          if(isDefined(self.attackers)) {
            for(j = 0; j < self.attackers.size; j++) {
              {}
              player = self.attackers[j];

              if(!isDefined(player)) {
                continue;
              }

              if(player == attacker) {
                continue;
              }

              damage_done = self.attackerDamage[player.clientId];
              player thread processAssist(self, damage_done);
            }
            self.attackers = [];
          }

          prof_end("PlayerKilled assists");
        }
      }

      prof_end("PlayerKilled attacker");
    }
  } else {
    doKillcam = false;
    killedByEnemy = false;

    lpattacknum = -1;
    lpattackguid = "";
    lpattackname = "";
    lpattackerteam = "world";

    if(isDefined(attacker) && isDefined(attacker.team) && (attacker.team == "axis" || attacker.team == "allies")) {
      if(attacker.team != self.pers["team"]) {
        killedByEnemy = true;
        if(level.teamBased) {
          giveTeamScore("kill", attacker.team, attacker, self);
        }
      }
    }
  }
  prof_end("PlayerKilled constants");

  prof_begin("PlayerKilled post constants");

  self.lastAttacker = attacker;
  self.lastDeathPos = self.origin;

  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && (!level.teambased || attacker.pers["team"] != self.pers["team"])) {
    self thread maps\mp\gametypes\_missions::playerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc);
  } else {
    self notify("playerKilledChallengesProcessed");
  }

  logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
  attackerString = "none";
  if(isPlayer(attacker)) {
    attackerString = attacker getXuid() + "(" + lpattackname + ")";
  }
  self logstring("d " + sMeansOfDeath + "(" + sWeapon + ") a:" + attackerString + " d:" + iDamage + " l:" + sHitLoc + " @ " + int(self.origin[0]) + " " + int(self.origin[1]) + " " + int(self.origin[2]));

  level thread updateTeamStatus();

  directKill = true;
  killcamentity = undefined;
  killcamentityindex = -1;
  killcamentitystarttime = 0;
  doKillCamEntity = false;
  forceKillcam = getDvarInt("scr_forcekillcam");

  if(isDefined(eInflictor) && (forceKillcam || eInflictor != attacker)) {
    if(isSubStr(sWeapon, "turret_mp") || isSubStr(sWeapon, "cobra") || sWeapon == "dog_bite_mp" || sWeapon == "artillery_mp" || sWeapon == "mine_bouncing_betty_mp") {
      doKillCamEntity = true;
    }
    if(sWeapon == "frag_grenade_mp" || sWeapon == "c4_mp" || sWeapon == "satchel_charge_mp" || sWeapon == "bazooka_mp" || sWeapon == "panzershrek_mp" || isSubStr(sWeapon, "gl_") || sWeapon == "frag_grenade_short_mp" || sWeapon == "molotov_mp" || sWeapon == "sticky_grenade_mp") {
      doKillCamEntity = true;
    }
    if((sWeapon == "c4_mp" || sWeapon == "mine_bouncing_betty_mp") && isDefined(eInflictor.owner) && eInflictor.owner != attacker) {
      doKillCamEntity = false;
      directKill = false;
    }
  }

  if(attacker.classname == "script_vehicle" && sMeansOfDeath == "MOD_CRUSH") {
    doKillCamEntity = true;
    killcamentity = attacker;
  } else if(doKillCamEntity) {
    killcamentity = eInflictor;
  }

  if(doKillCamEntity) {
    killcamentityindex = killcamentity getEntityNumber();
    killcamentitystarttime = killcamentity.birthtime;
  }

  if(!isDefined(killcamentity) && directKill && (sWeapon == "artillery_mp" || sWeapon == "mine_bouncing_betty_mp" || sWeapon == "frag_grenade_short_mp" || sWeapon == "molotov_mp" || sWeapon == "none" || isSubStr(sWeapon, "cobra")) && sMeansOfDeath != "MOD_BURNED") {
    doKillcam = false;
  }

  self maps\mp\gametypes\_weapons::detachCarryObjectModel();

  died_in_vehicle = false;
  if(isDefined(self.diedOnVehicle)) {
    died_in_vehicle = self.diedOnVehicle;
  }
  prof_end("PlayerKilled post constants");

  prof_begin("PlayerKilled body and gibbing");
  if(!died_in_vehicle) {
    vAttackerOrigin = undefined;
    if(isDefined(attacker)) {
      vAttackerOrigin = attacker.origin;
    }

    ragdoll_now = false;
    if(isDefined(self.usingvehicle) && self.usingvehicle && isDefined(self.vehicleposition) && self.vehicleposition == 1) {
      ragdoll_now = true;
    } else {
      ragdoll_now = self maps\mp\_gib::gib_player(iDamage, sMeansOfDeath, sWeapon, sHitLoc, vDir, vAttackerOrigin);
    }

    body = self clonePlayer(deathAnimDuration);
    self createDeadBody(iDamage, sMeansOfDeath, sWeapon, sHitLoc, vDir, vAttackerOrigin, deathAnimDuration, eInflictor, ragdoll_now, body);
  }
  prof_end("PlayerKilled body and gibbing");

  prof_begin("PlayerKilled post post constants");
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;

  self thread[[level.onPlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);

  for(iCB = 0; iCB < level.onPlayerKilledExtraUnthreadedCBs.size; iCB++) {
    self[[level.onPlayerKilledExtraUnthreadedCBs[iCB]]](
      eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
  }

  self.deathTime = getTime();
  self.wantSafeSpawn = false;
  perks = getPerks(attacker);

  wait(0.25);

  weaponClass = maps\mp\gametypes\_missions::getWeaponClass(sWeapon);
  if(weaponClass == "weapon_sniper") {
    self thread maps\mp\gametypes\_battlechatter_mp::KilledBySniper(attacker);
  }

  self.cancelKillcam = false;
  self thread cancelKillCamOnUse();
  waitForTimeOrNotifies(1.75);
  self notify("death_delay_finished");

  if(game["state"] != "playing") {
    return;
  }

  postDeathDelay = (getTime() - self.deathTime) / 1000;

  respawnTimerStartTime = gettime();

  if(getDvarInt("scr_forcekillcam") != 0) {
    doKillcam = true;

    if(lpattacknum < 0) {
      lpattacknum = self getEntityNumber();
    }
  }

  if(!self.cancelKillcam && doKillcam && level.killcam) {
    livesLeft = !(level.numLives && !self.pers["lives"]);
    timeUntilSpawn = TimeUntilspawn(true);
    willRespawnImmediately = livesLeft && (timeUntilSpawn <= 0);

    self maps\mp\gametypes\_killcam::killcam(lpattacknum, killcamentity, killcamentityindex, killcamentitystarttime, sWeapon, postDeathDelay + deathTimeOffset, psOffsetTime, willRespawnImmediately, timeUntilRoundEnd(), perks, attacker);
  }

  prof_end("PlayerKilled post post constants");

  if(game["state"] != "playing") {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    return;
  }

  if(isValidClass(self.class)) {
    timePassed = (gettime() - respawnTimerStartTime) / 1000;
    self thread[[level.spawnClient]](timePassed);
  }
}

incKillstreakTracker(sWeapon) {
  self endon("disconnect");

  waittillframeend;

  if(sWeapon == "artillery_mp") {
    self.pers["artillery_kills"]++;
  }

  if(sWeapon == "dog_bite_mp") {
    self.pers["dog_kills"]++;
  }
}

trackLeaderBoardDeathStats(sWeapon, sMeansOfDeath) {
  self thread threadedSetStatLBByName(sWeapon, 1, "deaths by", 2);
}

trackAttackerLeaderBoardDeathStats(sWeapon, sMeansOfDeath) {
  if(isDefined(self) && isPlayer(self)) {
    if(sMeansOfDeath != "MOD_FALLING") {
      self thread threadedSetStatLBByName(sWeapon, 1, "kills");
    }

    if(sMeansOfDeath == "MOD_HEAD_SHOT") {
      self thread threadedSetStatLBByName(sWeapon, 1, "headshots");
    }
  }
}

trackAttackerKill(name, rank, xp, prestige, xuid) {
  self endon("disconnect");
  attacker = self;

  waittillframeend;

  if(!isDefined(attacker.pers["killed_players"][name])) {
    attacker.pers["killed_players"][name] = 0;
  }

  if(!isDefined(attacker.killedPlayersCurrent[name])) {
    attacker.killedPlayersCurrent[name] = 0;
  }

  if(!isDefined(attacker.pers["nemesis_tracking"][name])) {
    attacker.pers["nemesis_tracking"][name] = 0;
  }

  attacker.pers["killed_players"][name]++;
  attacker.killedPlayersCurrent[name]++;
  attacker.pers["nemesis_tracking"][name] += 1.0;

  if(attacker.pers["nemesis_name"] == "" || attacker.pers["nemesis_tracking"][name] > attacker.pers["nemesis_tracking"][attacker.pers["nemesis_name"]]) {
    attacker.pers["nemesis_name"] = name;
    attacker.pers["nemesis_rank"] = rank;
    attacker.pers["nemesis_rankIcon"] = prestige;
    attacker.pers["nemesis_xp"] = xp;
    attacker.pers["nemesis_xuid"] = xuid;
  } else {
    attacker.pers["nemesis_rank"] = rank;
    attacker.pers["nemesis_xp"] = xp;
  }
}

trackAttackeeDeath(attackerName, rank, xp, prestige, xuid) {
  self endon("disconnect");

  waittillframeend;

  if(!isDefined(self.pers["killed_by"][attackerName])) {
    self.pers["killed_by"][attackerName] = 0;
  }

  self.pers["killed_by"][attackerName]++;

  if(!isDefined(self.pers["nemesis_tracking"][attackerName])) {
    self.pers["nemesis_tracking"][attackerName] = 0;
  }

  self.pers["nemesis_tracking"][attackerName] += 1.5;

  if(self.pers["nemesis_name"] == "" || self.pers["nemesis_tracking"][attackerName] > self.pers["nemesis_tracking"][self.pers["nemesis_name"]]) {
    self.pers["nemesis_name"] = attackerName;
    self.pers["nemesis_rank"] = rank;
    self.pers["nemesis_rankIcon"] = prestige;
    self.pers["nemesis_xp"] = xp;
    self.pers["nemesis_xuid"] = xuid;
  } else {
    self.pers["nemesis_rank"] = rank;
    self.pers["nemesis_xp"] = xp;
  }

  if(self.pers["nemesis_name"] == attackerName && self.pers["nemesis_tracking"][attackerName] >= 2) {
    self setClientDvar("killcam_title", "@MP_NEMESIS_KILLCAM");
  }
}

giveKillXP(sMeansOfDeath) {
  self endon("disconnect");

  waittillframeend;

  attacker = self;
  if(sMeansOfDeath == "MOD_HEAD_SHOT") {
    attacker incPersStat("headshots", 1);
    attacker.headshots = attacker getPersStat("headshots");

    if(isDefined(attacker.lastStand)) {
      value = maps\mp\gametypes\_rank::getScoreInfoValue("headshot") * 2;
    } else {
      value = undefined;
    }

    attacker thread maps\mp\gametypes\_rank::giveRankXP("headshot", value);
    attacker playLocalSound("bullet_impact_headshot_2");
  } else {
    if(isDefined(attacker.lastStand)) {
      value = maps\mp\gametypes\_rank::getScoreInfoValue("kill") * 2;
    } else {
      value = undefined;
    }

    attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", value);
  }
}

createDeadBody(iDamage, sMeansOfDeath, sWeapon, sHitLoc, vDir, vAttackerOrigin, deathAnimDuration, eInflictor, ragdoll_jib, body) {
  if(ragdoll_jib || self isOnLadder() || self isMantling() || sMeansOfDeath == "MOD_CRUSH") {
    body startRagDoll();
  }

  thread delayStartRagdoll(body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath);

  if(sMeansOfDeath == "MOD_BURNED" || isDefined(self.burning)) {
    body maps\mp\_burnplayer::burnedToDeath();
  }
  if(sMeansOfDeath == "MOD_CRUSH") {
    body vehicleCrush();
  }

  self.body = body;
  if(!isDefined(self.switching_teams)) {
    thread maps\mp\gametypes\_deathicons::addDeathicon(body, self, self.pers["team"], 5.0);
  }
}

clearLastTankAttacker() {
  self endon("disconnect");

  self notify("clearLastTankAttacker");
  self endon("clearLastTankAttacker");
  count = 1;

  wait(3);

  while(self.health < 99 && count < 10) {
    wait(1);
    count++;
  }

  self.lastTankThatAttacked = undefined;
}

cancelKillCamOnUse() {
  self thread cancelKillCamOnUse_specificButton(::cancelKillCamUseButton, ::cancelKillCamCallback);
}

cancelKillCamUseButton() {
  return self useButtonPressed();
}
cancelKillCamSafeSpawnButton() {
  return self fragButtonPressed();
}
cancelKillCamCallback() {
  self.cancelKillcam = true;
}
cancelKillCamSafeSpawnCallback() {
  self.cancelKillcam = true;
  self.wantSafeSpawn = true;
}

cancelKillCamOnUse_specificButton(pressingButtonFunc, finishedFunc) {
  self endon("death_delay_finished");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(!self[[pressingButtonFunc]]()) {
      wait(0.05);
      continue;
    }

    buttonTime = 0;
    while(self[[pressingButtonFunc]]()) {
      buttonTime += 0.05;
      wait(0.05);
    }

    if(buttonTime >= 0.5) {
      continue;
    }

    buttonTime = 0;

    while(!self[[pressingButtonFunc]]() && buttonTime < 0.5) {
      buttonTime += 0.05;
      wait(0.05);
    }

    if(buttonTime >= 0.5) {
      continue;
    }

    self[[finishedFunc]]();
    return;
  }
}

waitForTimeOrNotifies(desiredDelay) {
  startedWaiting = getTime();

  waitedTime = (getTime() - startedWaiting) / 1000;

  if(waitedTime < desiredDelay) {
    wait desiredDelay - waitedTime;
    return desiredDelay;
  } else {
    return waitedTime;
  }
}

reduceTeamKillsOverTime() {
  timePerOneTeamkillReduction = 20.0;
  reductionPerSecond = 1.0 / timePerOneTeamkillReduction;

  while(1) {
    if(isAlive(self)) {
      self.pers["teamkills_nostats"] -= reductionPerSecond;
      if(self.pers["teamkills_nostats"] < level.minimumAllowedTeamKills) {
        self.pers["teamkills_nostats"] = level.minimumAllowedTeamKills;
        break;
      }
    }
    wait 1;
  }
}

getPerks(player) {
  perks[0] = "specialty_null";
  perks[1] = "specialty_null";
  perks[2] = "specialty_null";
  perks[3] = "specialty_null";

  if(isPlayer(player) && !level.oldschool) {
    if(level.onlineGame && !isDefined(player.pers["isBot"]) && (isSubstr(player.curClass, "CLASS_CUSTOM") || isSubstr(player.curClass, "CLASS_PRESTIGE")) && isDefined(player.custom_class)) {
      class_num = player.class_num;
      if(isDefined(player.custom_class[class_num]["specialty1"])) {
        perks[0] = player.custom_class[class_num]["specialty1"];
      }
      if(isDefined(player.custom_class[class_num]["specialty2"])) {
        perks[1] = player.custom_class[class_num]["specialty2"];
      }
      if(isDefined(player.custom_class[class_num]["specialty3"])) {
        perks[2] = player.custom_class[class_num]["specialty3"];
      }
      if(isDefined(player.custom_class[class_num]["specialty4"])) {
        perks[3] = player.custom_class[class_num]["specialty4"];
      }
    } else {
      if(isDefined(level.default_perk[player.curClass][0])) {
        perks[0] = level.default_perk[player.curClass][0];
      }
      if(isDefined(level.default_perk[player.curClass][1])) {
        perks[1] = level.default_perk[player.curClass][1];
      }
      if(isDefined(level.default_perk[player.curClass][2])) {
        perks[2] = level.default_perk[player.curClass][2];
      }
      if(isDefined(level.default_perk[player.curClass][3])) {
        perks[3] = level.default_perk[player.curClass][3];
      }
    }
  }

  return perks;
}

processAssist(killedplayer, damagedone) {
  self endon("disconnect");
  killedplayer endon("disconnect");

  wait .05;
  WaitTillSlowProcessAllowed();

  if(self.pers["team"] != "axis" && self.pers["team"] != "allies") {
    return;
  }

  if(self.pers["team"] == killedplayer.pers["team"]) {
    return;
  }

  assist_level = "assist";

  assist_level_value = int(floor(damagedone / 25));

  if(assist_level_value > 0) {
    if(assist_level_value > 3) {
      assist_level_value = 3;
    }
    assist_level = assist_level + "_" + (assist_level_value * 25);
  }

  self thread[[level.onXPEvent]](assist_level);
  self incPersStat("assists", 1);
  self.assists = self getPersStat("assists");

  givePlayerScore(assist_level, self, killedplayer);

  self thread maps\mp\gametypes\_missions::playerAssist();
}

Callback_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  maps\mp\_laststand::playerlaststand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
}

setSpawnVariables() {
  resetTimeout();

  self StopShellshock();
  self StopRumble("damage_heavy");
}

notifyConnecting() {
  waittillframeend;

  if(isDefined(self)) {
    level notify("connecting", self);
  }
}

setObjectiveText(team, text) {
  game["strings"]["objective_" + team] = text;
  precacheString(text);
}

setObjectiveScoreText(team, text) {
  game["strings"]["objective_score_" + team] = text;
  precacheString(text);
}

setObjectiveHintText(team, text) {
  game["strings"]["objective_hint_" + team] = text;
  precacheString(text);
}

getObjectiveText(team) {
  return game["strings"]["objective_" + team];
}

getObjectiveScoreText(team) {
  return game["strings"]["objective_score_" + team];
}

getObjectiveHintText(team) {
  return game["strings"]["objective_hint_" + team];
}

getHitLocHeight(sHitLoc) {
  switch (sHitLoc) {
    case "helmet":
    case "head":
    case "neck":
      return 60;
    case "torso_upper":
    case "right_arm_upper":
    case "left_arm_upper":
    case "right_arm_lower":
    case "left_arm_lower":
    case "right_hand":
    case "left_hand":
    case "gun":
      return 48;
    case "torso_lower":
      return 40;
    case "right_leg_upper":
    case "left_leg_upper":
      return 32;
    case "right_leg_lower":
    case "left_leg_lower":
      return 10;
    case "right_foot":
    case "left_foot":
      return 5;
  }
  return 48;
}

debugLine(start, end) {
  for(i = 0; i < 50; i++) {
    line(start, end);
    wait .05;
  }
}

delayStartRagdoll(ent, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath) {
  if(isDefined(ent)) {
    deathAnim = ent getcorpseanim();
    if(animhasnotetrack(deathAnim, "ignore_ragdoll")) {
      return;
    }
  }

  if(level.oldschool) {
    if(!isDefined(vDir)) {
      vDir = (0, 0, 0);
    }

    explosionPos = ent.origin + (0, 0, getHitLocHeight(sHitLoc));
    explosionPos -= vDir * 20;

    explosionRadius = 40;
    explosionForce = .75;
    if(sMeansOfDeath == "MOD_IMPACT" || sMeansOfDeath == "MOD_EXPLOSIVE" || isSubStr(sMeansOfDeath, "MOD_GRENADE") || isSubStr(sMeansOfDeath, "MOD_PROJECTILE") || sHitLoc == "head" || sHitLoc == "helmet") {
      explosionForce = 2.5;
    }

    ent startragdoll(1);

    wait .05;

    if(!isDefined(ent)) {
      return;
    }

    physicsExplosionSphere(explosionPos, explosionRadius, explosionRadius / 2, explosionForce);
    return;
  }

  wait(0.2);

  if(!isDefined(ent)) {
    return;
  }

  if(ent isRagDoll()) {
    return;
  }

  deathAnim = ent getcorpseanim();

  startFrac = 0.35;

  if(animhasnotetrack(deathAnim, "start_ragdoll")) {
    times = getnotetracktimes(deathAnim, "start_ragdoll");
    if(isDefined(times)) {
      startFrac = times[0];
    }
  }

  waitTime = startFrac * getanimlength(deathAnim);
  wait(waitTime);

  if(isDefined(ent)) {
    println("Ragdolling after " + waitTime + " seconds");
    ent startragdoll(1);
  }
}

isExcluded(entity, entityList) {
  for(index = 0; index < entityList.size; index++) {
    if(entity == entityList[index]) {
      return true;
    }
  }
  return false;
}

leaderDialog(dialog, team, group, excludeList, squadDialog, squadID) {
  assert(isDefined(level.players));

  if(level.splitscreen) {
    return;
  }

  if(!isDefined(team)) {
    leaderDialogBothTeams(dialog, "allies", dialog, "axis", group, excludeList);
    return;
  }

  if(level.splitscreen) {
    if(level.players.size) {
      level.players[0] leaderDialogOnPlayer(dialog, group);
    }
    return;
  }

  if(isDefined(squadDialog)) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerSquadID = getplayersquadid(player);
      if(isDefined(squadID) && isDefined(playerSquadID) && (isDefined(player.pers["team"]) && (player.pers["team"] == team)) && playerSquadID == squadID && level.squads[team][squadID].size > 1) {
        player leaderDialogOnPlayer(squadDialog);
      } else if(!isDefined(squadID) && isDefined(getplayersquadid(player)) && (isDefined(player.pers["team"]) && (player.pers["team"] == team))) {
        player leaderDialogOnPlayer(squadDialog);
      } else if(!isDefined(dialog)) {
        continue;
      } else if((isDefined(excludeList)) && (isDefined(player.pers["team"]) && (player.pers["team"] == team)) && !isExcluded(player, excludeList)) {
        player leaderDialogOnPlayer(dialog, group);
      } else if(isDefined(player.pers["team"]) && (player.pers["team"] == team)) {
        player leaderDialogOnPlayer(dialog, group);
      }
    }
  } else if(isDefined(excludeList)) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if((isDefined(player.pers["team"]) && (player.pers["team"] == team)) && !isExcluded(player, excludeList)) {
        player leaderDialogOnPlayer(dialog, group);
      }
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.pers["team"]) && (player.pers["team"] == team)) {
        player leaderDialogOnPlayer(dialog, group);
      }
    }
  }
}

leaderDialogBothTeams(dialog1, team1, dialog2, team2, group, excludeList) {
  assert(isDefined(level.players));

  if(level.splitscreen) {
    return;
  }

  if(level.splitscreen) {
    if(level.players.size) {
      level.players[0] leaderDialogOnPlayer(dialog1, group);
    }
    return;
  }

  if(isDefined(excludeList)) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      team = player.pers["team"];

      if(!isDefined(team)) {
        continue;
      }

      if(isExcluded(player, excludeList)) {
        continue;
      }

      if(team == team1) {
        player leaderDialogOnPlayer(dialog1, group);
      } else if(team == team2) {
        player leaderDialogOnPlayer(dialog2, group);
      }
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      team = player.pers["team"];

      if(!isDefined(team)) {
        continue;
      }

      if(team == team1) {
        player leaderDialogOnPlayer(dialog1, group);
      } else if(team == team2) {
        player leaderDialogOnPlayer(dialog2, group);
      }
    }
  }
}

leaderDialogOnPlayer(dialog, group) {
  team = self.pers["team"];

  if(level.splitscreen) {
    return;
  }

  if(!isDefined(team)) {
    return;
  }

  if(team != "allies" && team != "axis") {
    return;
  }

  if(isDefined(group)) {
    if(self.leaderDialogGroup == group) {
      return;
    }

    hadGroupDialog = isDefined(self.leaderDialogGroups[group]);

    self.leaderDialogGroups[group] = dialog;
    dialog = group;

    if(hadGroupDialog) {
      return;
    }
  }

  if(!self.leaderDialogActive) {
    self thread playLeaderDialogOnPlayer(dialog, team);
  } else {
    self.leaderDialogQueue[self.leaderDialogQueue.size] = dialog;
  }
}

playLeaderDialogOnPlayer(dialog, team) {
  self endon("disconnect");

  self.leaderDialogActive = true;
  if(isDefined(self.leaderDialogGroups[dialog])) {
    group = dialog;
    dialog = self.leaderDialogGroups[group];
    self.leaderDialogGroups[group] = undefined;
    self.leaderDialogGroup = group;
  }

  if(level.allowAnnouncer) {
    self playLocalSound(game["voice"][team] + game["dialog"][dialog]);
  }

  wait(3.0);
  self.leaderDialogActive = false;
  self.leaderDialogGroup = "";

  if(self.leaderDialogQueue.size > 0) {
    nextDialog = self.leaderDialogQueue[0];

    for(i = 1; i < self.leaderDialogQueue.size; i++) {
      self.leaderDialogQueue[i - 1] = self.leaderDialogQueue[i];
    }
    self.leaderDialogQueue[i - 1] = undefined;

    self thread playLeaderDialogOnPlayer(nextDialog, team);
  }
}

getMostKilledBy() {
  mostKilledBy = "";
  killCount = 0;

  killedByNames = getArrayKeys(self.pers["killed_by"]);

  for(index = 0; index < killedByNames.size; index++) {
    killedByName = killedByNames[index];
    if(self.pers["killed_by"][killedByName] <= killCount) {
      continue;
    }

    killCount = self.pers["killed_by"][killedByName];
    mostKilleBy = killedByName;
  }

  return mostKilledBy;
}

getMostKilled() {
  mostKilled = "";
  killCount = 0;

  killedNames = getArrayKeys(self.pers["killed_players"]);

  for(index = 0; index < killedNames.size; index++) {
    killedName = killedNames[index];
    if(self.pers["killed_players"][killedName] <= killCount) {
      continue;
    }

    killCount = self.pers["killed_players"][killedName];
    mostKilled = killedName;
  }

  return mostKilled;
}

vehicleCrush() {
  self endon("disconnect");

  if(isDefined(level._effect) && isDefined(level._effect["tanksquish"])) {
    playFX(level._effect["tanksquish"], self.origin + (0, 0, 30));
  }

  self playSound("human_crunch");
}

GetVehicleProjectileScalar(sWeapon) {
  if(sWeapon == "satchel_charge_mp") {
    scale = 2.75;
  } else if(sWeapon == "sticky_grenade_mp") {
    scale = 2.25;
  } else if(sWeapon == "mine_bouncing_betty_mp") {
    scale = 1;
  } else if(issubstr(sWeapon, "bazooka")) {
    scale = 2.5;
  } else if(sWeapon == "artillery_mp") {
    scale = 2.75;
  } else if(issubstr(sWeapon, "gl_")) {
    scale = 1.5;
  } else if(issubstr(sWeapon, "turret_mp")) {
    scale = 2;
  } else if(issubstr(sWeapon, "grenade")) {
    scale = .5;
  } else {
    scale = 1;
  }

  return scale;
}

GetVehicleProjectileSplashScalar(sWeapon) {
  if(sWeapon == "satchel_charge_mp") {
    scale = 0.5;
  } else if(sWeapon == "sticky_grenade_mp") {
    scale = 0.5;
  } else if(sWeapon == "mine_bouncing_betty_mp") {
    scale = 0.1;
  } else if(issubstr(sWeapon, "bazooka")) {
    scale = 0.1;
  } else if(sWeapon == "artillery_mp") {
    scale = 0.6;
  } else if(issubstr(sWeapon, "gl_")) {
    scale = 0.1;
  } else if(issubstr(sWeapon, "turrent_mp")) {
    scale = 0.1;
  } else if(issubstr(sWeapon, "grenade")) {
    scale = 0.1;
  } else {
    scale = 0.1;
  }

  return scale;
}
GetVehicleUnderneathSplashScalar(sWeapon) {
  if(sWeapon == "satchel_charge_mp") {
    scale = 10.0;

    scale *= 3.0;
  } else {
    scale = 1.0;
  }

  return scale;
}

GetVehicleBulletDamage(sWeapon) {
  if(issubstr(sWeapon, "ptrs41_")) {
    iDamage = 25;
  } else if(isSubStr(sWeapon, "gunner")) {
    iDamage = 5;
  } else if(issubstr(sWeapon, "mg42_bipod") || issubstr(sWeapon, "30cal_bipod")) {
    iDamage = 5;
  } else {
    iDamage = 1;
  }
  return iDamage;
}

threadedSetStatLBByName(name, value, columnname, suffix) {
  self endon("disconnect");
  waittillframeend;

  if(!isDefined(suffix) && !isDefined(columnname)) {
    self setStatLBByName(name, value);
  } else if(!isDefined(suffix)) {
    self setStatLBByName(name, value, columnname);
  } else {
    self setStatLBByName(name, value, columnname, suffix);
  }
}

IgnoreTeamKills(sWeapon, sMeansOfDeath) {
  if(sMeansOfDeath == "MOD_MELEE") {
    return false;
  }

  if(isSubStr(sWeapon, "mine_bouncing_betty_") || sWeapon == "briefcase_bomb_mp") {
    return true;
  }

  return false;
}