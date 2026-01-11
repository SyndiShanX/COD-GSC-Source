/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_globallogic.gsc
**********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_burnplayer;
#include maps\mp\_laststand;
#include maps\mp\_busing;
#include common_scripts\utility;

init() {
  if(!isDefined(level.tweakablesInitialized)) {
    maps\mp\gametypes\_tweakables::init();
  }
  if(GetDvar(#"scr_player_sprinttime") == "") {
    setDvar("scr_player_sprinttime", GetDvar(#"player_sprintTime"));
  }
  level.splitscreen = isSplitScreen();
  level.xenon = (GetDvar(#"xenonGame") == "true");
  level.ps3 = (GetDvar(#"ps3Game") == "true");
  level.onlineGame = GetDvarInt(#"onlinegame");
  level.console = (level.xenon || level.ps3);
  level.rankedMatch = (level.onlineGame && !GetDvarInt(#"xblive_privatematch") && !GetDvarInt(#"xblive_wagermatch") && !isPreGame());
  level.contractsEnabled = !GetDvarInt(#"scr_disable_contracts");
  if(GetDvarInt(#"xblive_basictraining")) {
    level.rankedMatch = true;
    level.contractsEnabled = false;
  }
  if(!level.console && !IsGlobalStatsServer()) {
    level.contractsEnabled = false;
  }
  level.script = toLower(GetDvar(#"mapname"));
  level.gametype = toLower(GetDvar(#"g_gametype"));
  level.otherTeam["allies"] = "axis";
  level.otherTeam["axis"] = "allies";
  level.teamBased = false;
  level.overrideTeamScore = false;
  level.overridePlayerScore = false;
  level.displayHalftimeText = false;
  level.displayRoundEndText = true;
  level.endGameOnScoreLimit = true;
  level.endGameOnTimeLimit = true;
  level.scoreRoundBased = false;
  level.resetPlayerScoreEveryRound = false;
  level.gameForfeited = false;
  level.halftimeType = "halftime";
  level.halftimeSubCaption = &"MP_SWITCHING_SIDES_CAPS";
  level.lastStatusTime = 0;
  level.wasWinning = "none";
  level.lastSlowProcessFrame = 0;
  level.placement["allies"] = [];
  level.placement["axis"] = [];
  level.placement["all"] = [];
  level.postRoundTime = 7.0;
  level.inOvertime = false;
  level.defaultOffenseRadius = 140;
  level.dropTeam = GetDvarInt(#"sv_maxclients");
  level.inFinalKillcam = false;
  maps\mp\gametypes\_globallogic_ui::init();
  registerDvars();
  maps\mp\gametypes\_class::initPerkDvars();
  level.oldschool = (GetDvarInt(#"scr_oldschool") == 1);
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
  precacheShader("composite_emblem_team_axis");
  precacheShader("composite_emblem_team_allies");
  maps\mp\_burnplayer::initBurnPlayer();
  maps\mp\_laststand::initLastStand();
  if(!isDefined(game["tiebreaker"])) {
    game["tiebreaker"] = false;
  }
  thread maps\mp\_gameadvertisement::init();
  thread maps\mp\_gamerep::init();
}
registerDvars() {
  if(GetDvar(#"scr_oldschool") == "") {
    setdvar("scr_oldschool", "0");
  }
  makeDvarServerInfo("scr_oldschool");
  if(GetDvar(#"scr_disable_cac") == "") {
    setdvar("scr_disable_cac", 0);
  }
  makedvarserverinfo("scr_disable_cac");
  if(GetDvar(#"ui_guncycle") == "") {
    setDvar("ui_guncycle", 0);
  }
  makedvarserverinfo("ui_guncycle");
  if(GetDvar(#"ui_weapon_tiers") == "") {
    setDvar("ui_weapon_tiers", 0);
  }
  makedvarserverinfo("ui_weapon_tiers");
  setDvar("ui_text_endreason", "");
  makeDvarServerInfo("ui_text_endreason", "");
  setMatchFlag("bomb_timer", 0);
  setMatchFlag("enable_popups", 1);
  setMatchFlag("pregame", isPregame());
  if(!level.console) {
    if(GetDvar(#"scr_show_unlock_wait") == "") {
      setDvar("scr_show_unlock_wait", 0.1);
    }
    if(GetDvar(#"scr_intermission_time") == "") {
      setDvar("scr_intermission_time", 60.0);
    }
  }
  if(GetDvar(#"scr_vehicle_damage_scalar") == "") {
    setdvar("scr_vehicle_damage_scalar", "1");
  }
  level.vehicleDamageScalar = GetDvarFloat(#"scr_vehicle_damage_scalar");
  level.fire_audio_repeat_duration = GetDvarInt(#"fire_audio_repeat_duration");
  level.fire_audio_random_max_duration = GetDvarInt(#"fire_audio_random_max_duration");
}
blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {}
SetupCallbacks() {
  level.spawnPlayer = maps\mp\gametypes\_globallogic_spawn::spawnPlayer;
  level.spawnClient = maps\mp\gametypes\_globallogic_spawn::spawnClient;
  level.spawnSpectator = maps\mp\gametypes\_globallogic_spawn::spawnSpectator;
  level.spawnIntermission = maps\mp\gametypes\_globallogic_spawn::spawnIntermission;
  level.onPlayerScore = maps\mp\gametypes\_globallogic_score::default_onPlayerScore;
  level.onTeamScore = maps\mp\gametypes\_globallogic_score::default_onTeamScore;
  level.onXPEvent = maps\mp\gametypes\_globallogic_score::onXPEvent;
  level.waveSpawnTimer = ::waveSpawnTimer;
  level.onSpawnPlayer = ::blank;
  level.onSpawnPlayerUnified = ::blank;
  level.onSpawnSpectator = maps\mp\gametypes\_globallogic_defaults::default_onSpawnSpectator;
  level.onSpawnIntermission = maps\mp\gametypes\_globallogic_defaults::default_onSpawnIntermission;
  level.onRespawnDelay = ::blank;
  level.onForfeit = maps\mp\gametypes\_globallogic_defaults::default_onForfeit;
  level.onTimeLimit = maps\mp\gametypes\_globallogic_defaults::default_onTimeLimit;
  level.onScoreLimit = maps\mp\gametypes\_globallogic_defaults::default_onScoreLimit;
  level.onDeadEvent = maps\mp\gametypes\_globallogic_defaults::default_onDeadEvent;
  level.onOneLeftEvent = maps\mp\gametypes\_globallogic_defaults::default_onOneLeftEvent;
  level.giveTeamScore = maps\mp\gametypes\_globallogic_score::giveTeamScore;
  level.givePlayerScore = maps\mp\gametypes\_globallogic_score::givePlayerScore;
  level.getTimeLimitDvarValue = maps\mp\gametypes\_globallogic_defaults::default_getTimeLimitDvarValue;
  level.getTeamKillPenalty = maps\mp\gametypes\_globallogic_defaults::default_getTeamKillPenalty;
  level.getTeamKillScore = maps\mp\gametypes\_globallogic_defaults::default_getTeamKillScore;
  level.isKillBoosting = maps\mp\gametypes\_globallogic_score::default_isKillBoosting;
  level._setTeamScore = maps\mp\gametypes\_globallogic_score::_setTeamScore;
  level._setPlayerScore = maps\mp\gametypes\_globallogic_score::_setPlayerScore;
  level._getTeamScore = maps\mp\gametypes\_globallogic_score::_getTeamScore;
  level._getPlayerScore = maps\mp\gametypes\_globallogic_score::_getPlayerScore;
  level.onPrecacheGametype = ::blank;
  level.onStartGameType = ::blank;
  level.onPlayerConnect = ::blank;
  level.onPlayerDisconnect = ::blank;
  level.onPlayerDamage = ::blank;
  level.onPlayerKilled = ::blank;
  level.onPlayerKilledExtraUnthreadedCBs = [];
  level.onTeamOutcomeNotify = maps\mp\gametypes\_hud_message::teamOutcomeNotify;
  level.onOutcomeNotify = maps\mp\gametypes\_hud_message::outcomeNotify;
  level.onTeamWagerOutcomeNotify = maps\mp\gametypes\_hud_message::teamWagerOutcomeNotify;
  level.onWagerOutcomeNotify = maps\mp\gametypes\_hud_message::wagerOutcomeNotify;
  level.onEndGame = ::blank;
  level.onRoundEndGame = maps\mp\gametypes\_globallogic_defaults::default_onRoundEndGame;
  level.onMedalAwarded = ::blank;
  maps\mp\gametypes\_globallogic_ui::SetupCallbacks();
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
    }
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
    }
    else {
      winner = "allies";
    }
    logString("host ended game, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);
  } else {
    winner = maps\mp\gametypes\_globallogic_score::getHighestScoringPlayer();
    if(isDefined(winner)) {
      logString("host ended game, win: " + winner.name);
    }
    else {
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
    }
    else {
      endString = &"MP_HOST_ENDED_GAME";
    }
  }
  setMatchFlag("disableIngameMenu", 1);
  makeDvarServerInfo("ui_text_endreason", endString);
  setDvar("ui_text_endreason", endString);
  thread endGame(winner, endString);
}
killserverPc() {
  if(level.hostForcedEnd || level.forcedEnd) {
    return;
  }
  winner = undefined;
  if(level.teamBased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      winner = "tie";
    }
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
    }
    else {
      winner = "allies";
    }
    logString("host ended game, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", axis: " + game["teamScores"]["axis"]);
  } else {
    winner = maps\mp\gametypes\_globallogic_score::getHighestScoringPlayer();
    if(isDefined(winner)) {
      logString("host ended game, win: " + winner.name);
    }
    else {
      logString("host ended game, tie");
    }
  }
  level.forcedEnd = true;
  level.hostForcedEnd = true;
  level.killserver = true;
  endString = &"MP_HOST_ENDED_GAME";
  thread endGame(winner, endString);
}
updateGameEvents() {
  if((level.rankedMatch || level.wagerMatch) && !level.inGracePeriod) {
    if(level.teamBased) {
      if(!level.gameForfeited) {
        if((level.everExisted["allies"] || level.console) && level.playerCount["allies"] < 1 && level.playerCount["axis"] > 0 && game["state"] == "playing") {
          thread[[level.onForfeit]]("allies");
          return;
        }
        if((level.everExisted["axis"] || level.console) && level.playerCount["axis"] < 1 && level.playerCount["allies"] > 0 && game["state"] == "playing") {
          thread[[level.onForfeit]]("axis");
          return;
        }
      } else {
        if(level.playerCount["axis"] > 0 && level.playerCount["allies"] > 0) {
          level.gameForfeited = false;
          level notify("abort forfeit");
        }
      }
    } else {
      if(!level.gameForfeited) {
        if(level.playerCount["allies"] + level.playerCount["axis"] == 1 && level.maxPlayerCount > 1) {
          thread[[level.onForfeit]]();
          return;
        }
      } else {
        if(level.playerCount["axis"] + level.playerCount["allies"] > 1) {
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
      [
        [level.onDeadEvent]
      ]("all");
      return;
    }
    if(level.everExisted["allies"] && !level.aliveCount["allies"] && !level.playerLives["allies"]) {
      [
        [level.onDeadEvent]
      ]("allies");
      return;
    }
    if(level.everExisted["axis"] && !level.aliveCount["axis"] && !level.playerLives["axis"]) {
      [
        [level.onDeadEvent]
      ]("axis");
      return;
    }
    if(level.lastAliveCount["allies"] > 1 && level.aliveCount["allies"] == 1 && level.playerLives["allies"] == 1) {
      [
        [level.onOneLeftEvent]
      ]("allies");
      return;
    }
    if(level.lastAliveCount["axis"] > 1 && level.aliveCount["axis"] == 1 && level.playerLives["axis"] == 1) {
      [
        [level.onOneLeftEvent]
      ]("axis");
      return;
    }
  } else {
    if((!level.aliveCount["allies"] && !level.aliveCount["axis"]) && (!level.playerLives["allies"] && !level.playerLives["axis"]) && level.maxPlayerCount > 1) {
      [
        [level.onDeadEvent]
      ]("all");
      return;
    }
    if((level.aliveCount["allies"] + level.aliveCount["axis"] == 1) && (level.playerLives["allies"] + level.playerLives["axis"] == 1) && level.maxPlayerCount > 1) {
      [
        [level.onOneLeftEvent]
      ]("all");
      return;
    }
  }
}
matchStartTimer() {
  visionSetNaked("mpIntro", 0);
  matchStartText = createServerFontString("extrabig", 1.5);
  matchStartText setPoint("CENTER", "CENTER", 0, -40);
  matchStartText.sort = 1001;
  matchStartText setText(game["strings"]["waiting_for_teams"]);
  matchStartText.foreground = false;
  matchStartText.hidewheninmenu = true;
  waitForPlayers();
  matchStartText setText(game["strings"]["match_starting_in"]);
  matchStartTimer = createServerFontString("extrabig", 2.2);
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
        visionSetNaked(GetDvar(#"mapname"), 3.0);
      }
      countTime--;
      wait(1.0);
    }
  } else {
    visionSetNaked(GetDvar(#"mapname"), 1.0);
  }
  matchStartTimer destroyElem();
  matchStartText destroyElem();
}
matchStartTimerSkip() {
  if(!isPregame()) {
    visionSetNaked(GetDvar(#"mapname"), 0);
  }
  else {
    visionSetNaked("mpIntro", 0);
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
hostIdledOut() {
  hostPlayer = getHostPlayer();
  if(isDefined(hostPlayer) && !hostPlayer.hasSpawned && !isDefined(hostPlayer.selectedClass)) {
    return true;
  }
  return false;
}
sendAfterActionReport() {
  if(isPregame()) {
    return;
  }
  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];
    if(player is_bot() || player isdemoclient()) {
      continue;
    }
    nemesis = player.pers["nemesis_name"];
    if(!isDefined(player.pers["killed_players"][nemesis])) {
      player.pers["killed_players"][nemesis] = 0;
    }
    if(!isDefined(player.pers["killed_by"][nemesis])) {
      player.pers["killed_by"][nemesis] = 0;
    }
    spread = player.kills - player.deaths;
    if(player.pers["cur_kill_streak"] > player.pers["best_kill_streak"]) {
      player.pers["best_kill_streak"] = player.pers["cur_kill_streak"];
    }
    if((level.rankedMatch || level.wagerMatch)) {
      player maps\mp\gametypes\_persistence::setAfterActionReportStat("privateMatch", 0);
    }
    else {
      player maps\mp\gametypes\_persistence::setAfterActionReportStat("privateMatch", 1);
    }
    player setNemesisXuid(player.pers["nemesis_xuid"]);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("nemesisName", nemesis);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("nemesisRank", player.pers["nemesis_rank"]);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("nemesisRankIcon", player.pers["nemesis_rankIcon"]);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("nemesisKills", player.pers["killed_players"][nemesis]);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("nemesisKilledBy", player.pers["killed_by"][nemesis]);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("bestKillstreak", player.pers["best_kill_streak"]);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("kills", player.kills);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("deaths", player.deaths);
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("headshots", player.headshots);
    currGameType = maps\mp\gametypes\_persistence::getGameTypeName();
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("gameType", getGameTypeEnumFromName(currGameType, level.wagerMatch));
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("xpEarned", int(player.pers["summary"]["xp"]));
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("cpEarned", int(player.pers["summary"]["codpoints"]));
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("score", int(player.pers["summary"]["score"]));
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("miscBonus", int(player.pers["summary"]["challenge"] + player.pers["summary"]["misc"]));
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("matchBonus", int(player.pers["summary"]["match"]));
    recordPlayerStats(player, "total_xp", player.pers["summary"]["xp"]);
    placement = level.placement["all"];
    for(otherPlayerIndex = 0; otherPlayerIndex < placement.size; otherPlayerIndex++) {
      if(level.placement["all"][otherPlayerIndex] == player) {
        recordPlayerStats(player, "position", otherPlayerIndex);
      }
    }
    if(level.wagerMatch) {
      recordPlayerStats(player, "wagerPayout", player.wagerWinnings);
      player maps\mp\gametypes\_wager::setWagerAfterActionReportStats();
      player maps\mp\gametypes\_persistence::setAfterActionReportStat("wagerMatch", 1);
    } else {
      player maps\mp\gametypes\_persistence::setAfterActionReportStat("wagerMatch", 0);
    }
    player maps\mp\gametypes\_persistence::setAfterActionReportStat("wagerMatchFailed", 0);
    if((level.rankedMatch || level.wagerMatch)) {
      player maps\mp\gametypes\_persistence::setAfterActionReportStat("valid", 1);
    }
    if(isDefined(player.pers["matchesPlayedStatsTracked"])) {
      player maps\mp\gametypes\_persistence::statAdd("MATCHES_PLAYED_COMPLETED", 1, false);
      player maps\mp\gametypes\_persistence::statSet("MATCHES_PLAYED_COMPLETED_STREAK", player.pers["MATCHES_PLAYED_COMPLETED_STREAK"], false);
      if(isDefined(player.pers["matchesHostedStatsTracked"])) {
        player maps\mp\gametypes\_persistence::statAdd("MATCHES_HOSTED_COMPLETED", 1, false);
        player maps\mp\gametypes\_persistence::statSet("MATCHES_HOSTED_COMPLETED_STREAK", player.pers["MATCHES_HOSTED_COMPLETED_STREAK"], false);
        player.pers["matchesHostedStatsTracked"] = undefined;
      }
      player.pers["matchesPlayedStatsTracked"] = undefined;
    }
    recordPlayerStats(player, "highestKillStreak", player.pers["best_kill_streak"]);
    recordPlayerStats(player, "numUavCalled", player maps\mp\gametypes\_hardpoints::getKillstreakUsage("uav_used"));
    recordPlayerStats(player, "numArtilleryCalled", player maps\mp\gametypes\_hardpoints::getKillstreakUsage("artillery_used"));
    recordPlayerStats(player, "numDogsCalled", player maps\mp\gametypes\_hardpoints::getKillstreakUsage("dogs_used"));
    recordPlayerStats(player, "numArtilleryKills", player.pers["artillery_kills"]);
    recordPlayerStats(player, "numDogsKills", player.pers["dog_kills"]);
    recordPlayerMatchEnd(player);
  }
}
displayRoundEnd(winner, endReasonText) {
  if(level.displayRoundEndText) {
    setmatchflag("cg_drawSpectatorMessages", 0);
    players = level.players;
    for(index = 0; index < players.size; index++) {
      player = players[index];
      if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") {
        player[[level.spawnIntermission]](true);
        player closeMenu();
        player closeInGameMenu();
        continue;
      }
      if(level.wagerMatch) {
        if(level.teamBased) {
          player thread[[level.onTeamWagerOutcomeNotify]](winner, true, endReasonText);
        }
        else {
          player thread[[level.onWagerOutcomeNotify]](winner, endReasonText);
        }
      } else {
        if(level.teamBased) {
          player thread[[level.onTeamOutcomeNotify]](winner, true, endReasonText);
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("ROUND_END");
        } else {
          player thread[[level.onOutcomeNotify]](winner, true, endReasonText);
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("ROUND_END");
        }
      }
      player setClientUIVisibilityFlag("hud_visible", 0);
      player setClientUIVisibilityFlag("g_compassShowEnemies", 0);
    }
  }
  if(wasLastRound()) {
    roundEndWait(level.roundEndDelay, false);
  } else {
    thread maps\mp\gametypes\_globallogic_audio::announceRoundWinner(winner, level.roundEndDelay / 4);
    roundEndWait(level.roundEndDelay, true);
  }
}
displayRoundSwitch(winner, endReasonText) {
  switchType = level.halftimeType;
  if(switchType == "halftime") {
    if(level.roundLimit) {
      if((game["roundsplayed"] * 2) == level.roundLimit) {
        switchType = "halftime";
      }
      else {
        switchType = "intermission";
      }
    } else if(level.scoreLimit) {
      if(game["roundsplayed"] == (level.scoreLimit - 1)) {
        switchType = "halftime";
      }
      else {
        switchType = "intermission";
      }
    } else {
      switchType = "intermission";
    }
  }
  leaderdialog = maps\mp\gametypes\_globallogic_audio::getRoundSwitchDialog(switchType);
  SetMatchTalkFlag("EveryoneHearsEveryone", 1);
  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];
    if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") {
      player[[level.spawnIntermission]](true);
      player closeMenu();
      player closeInGameMenu();
      continue;
    }
    player maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer(leaderdialog);
    player maps\mp\gametypes\_globallogic_audio::set_music_on_player("ROUND_SWITCH");
    if(level.wagerMatch) {
      player thread[[level.onTeamWagerOutcomeNotify]](switchType, true, level.halftimeSubCaption);
    }
    else {
      player thread[[level.onTeamOutcomeNotify]](switchType, true, level.halftimeSubCaption);
    }
    player setClientUIVisibilityFlag("hud_visible", 0);
  }
  roundEndWait(level.halftimeRoundEndDelay, false);
}
displayGameEnd(winner, endReasonText) {
  SetMatchTalkFlag("EveryoneHearsEveryone", 1);
  setmatchflag("cg_drawSpectatorMessages", 0);
  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];
    if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") {
      player[[level.spawnIntermission]](true);
      player closeMenu();
      player closeInGameMenu();
      continue;
    }
    if(level.wagerMatch) {
      if(level.teamBased) {
        player thread[[level.onTeamWagerOutcomeNotify]](winner, false, endReasonText);
      }
      else {
        player thread[[level.onWagerOutcomeNotify]](winner, endReasonText);
      }
    } else {
      if(level.teamBased) {
        player thread[[level.onTeamOutcomeNotify]](winner, false, endReasonText);
      } else {
        player thread[[level.onOutcomeNotify]](winner, false, endReasonText);
        if(isDefined(winner) && player == winner) {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("VICTORY");
        }
        else if(!level.splitScreen) {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("LOSE");
        }
      }
    }
    player setClientUIVisibilityFlag("hud_visible", 0);
    player setClientUIVisibilityFlag("g_compassShowEnemies", 0);
  }
  if(level.teamBased) {
    thread maps\mp\gametypes\_globallogic_audio::announceGameWinner(winner, level.postRoundTime / 2);
    players = level.players;
    for(index = 0; index < players.size; index++) {
      player = players[index];
      team = player.pers["team"];
      if(level.splitscreen) {
        if(winner == "tie") {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("DRAW");
        } else if(winner == team) {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("VICTORY");
        } else {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("LOSE");
        }
      } else {
        if(winner == "tie") {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("DRAW");
        } else if(winner == team) {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("VICTORY");
        } else {
          player maps\mp\gametypes\_globallogic_audio::set_music_on_player("LOSE");
        }
      }
    }
  }
  bbPrint("session_epilogs: reason %s", endReasonText);
  roundEndWait(level.postRoundTime, true);
}
getEndReasonText() {
  if(hitRoundLimit() || hitRoundWinLimit()) {
    return game["strings"]["round_limit_reached"];
  }
  else if(hitScoreLimit()) {
    return game["strings"]["score_limit_reached"];
  }
  if(level.forcedEnd) {
    if(level.hostForcedEnd) {
      return &"MP_HOST_ENDED_GAME";
    }
    else {
      return &"MP_ENDED_GAME";
    }
  }
  return game["strings"]["time_limit_reached"];
}
resetOutcomeForAllPlayers() {
  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];
    player notify("reset_outcome");
  }
}
startNextRound(winner, endReasonText) {
  if(!isOneRound()) {
    displayRoundEnd(winner, endReasonText);
    maps\mp\gametypes\_globallogic_utils::executePostRoundEvents();
    if(!wasLastRound()) {
      if(checkRoundSwitch()) {
        displayRoundSwitch(winner, endReasonText);
      }
      if(level.numLives) {
        SetMatchTalkFlag("DeadChatWithDead", 1);
        SetMatchTalkFlag("DeadChatWithTeam", 0);
        SetMatchTalkFlag("DeadHearTeamLiving", 0);
        SetMatchTalkFlag("DeadHearAllLiving", 0);
        SetMatchTalkFlag("EveryoneHearsEveryone", 0);
      } else {
        SetMatchTalkFlag("DeadChatWithDead", 0);
        SetMatchTalkFlag("DeadChatWithTeam", 1);
        SetMatchTalkFlag("DeadHearTeamLiving", 1);
        SetMatchTalkFlag("DeadHearAllLiving", 0);
        SetMatchTalkFlag("EveryoneHearsEveryone", 0);
      }
      game["state"] = "playing";
      level.allowBattleChatter = GetDvarInt(#"scr_allowbattlechatter");
      map_restart(true);
      return true;
    }
  }
  return false;
}
setTopPlayerStats() {
  if(level.rankedMatch || level.wagerMatch) {
    placement = level.placement["all"];
    topThreePlayers = min(3, placement.size);
    for(index = 0; index < topThreePlayers; index++) {
      if(level.placement["all"][index].score) {
        if(!index) {
          level.placement["all"][index] maps\mp\gametypes\_persistence::statAdd("TOPPLAYER", 1, true);
          level.placement["all"][index] notify("topplayer");
        } else
          level.placement["all"][index] notify("nottopplayer");
        level.placement["all"][index] maps\mp\gametypes\_persistence::statAdd("TOP3", 1, true);
        level.placement["all"][index] notify("top3");
      }
    }
    for(index = 3; index < placement.size; index++) {
      level.placement["all"][index] notify("nottop3");
      level.placement["all"][index] notify("nottopplayer");
    }
    if(level.teambased) {
      setTopTeamStats("allies");
      setTopTeamStats("axis");
    }
  }
}
setTopTeamStats(team) {
  placementTeam = level.placement[team];
  topThreeTeamPlayers = min(3, placementTeam.size);
  if(placementTeam.size < 5) {
    return;
  }
  for(index = 0; index < topThreeTeamPlayers; index++) {
    if(placementTeam[index].score) {
      placementTeam[index] maps\mp\gametypes\_persistence::statAdd("BASIC_TOP_3_TEAM", 1, false);
      placementTeam[index] maps\mp\gametypes\_persistence::statAdd("TOP3TEAM", 1, true);
    }
  }
}
endGame(winner, endReasonText) {
  if(game["state"] == "postgame" || level.gameEnded) {
    return;
  }
  if(isDefined(level.onEndGame)) {
    [[level.onEndGame]](winner);
  }
  if(!level.wagerMatch) {
    setMatchFlag("enable_popups", 0);
  }
  if(!isDefined(level.disableOutroVisionSet) || level.disableOutroVisionSet == false) {
    visionSetNaked("mpOutro", 2.0);
  }
  setmatchflag("cg_drawSpectatorMessages", 0);
  game["state"] = "postgame";
  level.gameEndTime = getTime();
  level.gameEnded = true;
  SetDvar("g_gameEnded", 1);
  level.inGracePeriod = false;
  level notify("game_ended");
  level.allowBattleChatter = false;
  game["roundsplayed"]++;
  game["roundwinner"][game["roundsplayed"]] = winner;
  if(level.teambased) {
    game["roundswon"][winner]++;
  }
  setGameEndTime(0);
  updatePlacement();
  updateRankedMatch(winner);
  players = level.players;
  newTime = getTime();
  SetMatchTalkFlag("EveryoneHearsEveryone", 1);
  for(index = 0; index < players.size; index++) {
    player = players[index];
    player maps\mp\gametypes\_globallogic_player::freezePlayerForRoundEnd();
    player thread roundEndDoF(4.0);
    player maps\mp\gametypes\_globallogic_ui::freeGameplayHudElems();
    player maps\mp\gametypes\_weapons::updateWeaponTimings(newTime);
    if(isPregame()) {
      continue;
    }
    if((level.rankedMatch || level.wagerMatch) && !player IsSplitscreen()) {
      if(isDefined(player.setPromotion)) {
        player setClientDvar("ui_lobbypopup", "promotion");
      }
      else {
        player setClientDvar("ui_lobbypopup", "summary");
      }
    }
  }
  maps\mp\_music::setmusicstate("SILENT");
  if(!level.inFinalKillcam) {}
  maps\mp\_gamerep::gameRepUpdateInformationForRound();
  maps\mp\gametypes\_wager::finalizeWagerRound();
  maps\mp\gametypes\_gametype_variants::onRoundEnd();
  thread maps\mp\_challenges::roundEnd(winner);
  if(startNextRound(winner, endReasonText)) {
    return;
  }
  if(!isOneRound()) {
    if(isDefined(level.onRoundEndGame)) {
      winner = [
    }
        [level.onRoundEndGame]
      ](winner);
    endReasonText = getEndReasonText();
  }
  setTopPlayerStats();
  thread maps\mp\_challenges::gameEnd(winner);
  thread maps\mp\gametypes\_missions::roundEnd(winner);
  if(!isDefined(level.skipGameEnd) || !level.skipGameEnd) {
    displayGameEnd(winner, endReasonText);
  }
  if(isOneRound()) {
    maps\mp\gametypes\_globallogic_utils::executePostRoundEvents();
  }
  level.intermission = true;
  maps\mp\_gamerep::gameRepAnalyzeAndReport();
  if(!isPregame()) {
    thread sendAfterActionReport();
  }
  maps\mp\gametypes\_wager::finalizeWagerGame();
  SetMatchTalkFlag("EveryoneHearsEveryone", 1);
  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];
    player closeMenu();
    player closeInGameMenu();
    player notify("reset_outcome");
    player thread[[level.spawnIntermission]]();
    player setClientUIVisibilityFlag("hud_visible", 1);
    if(!level.console) {
      if(!isDefined(level.killserver) || !level.killserver) {
        player setclientdvar("g_scriptMainMenu", game["menu_eog_main"]);
      }
    }
  }
  logString("game ended");
  if(level.console) {
    if(!isDefined(level.skipGameEnd) || !level.skipGameEnd) {
      wait 5.0;
    }
    exitLevel(false);
    return;
  }
  if(isDefined(level.killserver) && level.killserver) {
    wait(5);
    killserver();
    return;
  }
  if(IsGlobalStatsServer()) {
    thread maps\mp\_pc::pcserver();
  }
  wait GetDvarFloat(#"scr_show_unlock_wait");
  if(!isPregame()) {
    players = level.players;
    for(index = 0; index < players.size; index++) {
      player = players[index];
      player openMenu(game["menu_eog_unlock"]);
    }
  }
  thread timeLimitClock_Intermission(GetDvarFloat(#"scr_intermission_time"));
  wait GetDvarFloat(#"scr_intermission_time");
  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];
    player closeMenu();
    player closeInGameMenu();
  }
  exitLevel(false);
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
    level notify("round_end_done");
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
  level notify("round_end_done");
}
roundEndDOF(time) {
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
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
  timeLeft = maps\mp\gametypes\_globallogic_utils::getTimeRemaining();
  setGameEndTime(getTime() + int(timeLeft));
  if(timeLeft > 0) {
    return;
  }
  [[level.onTimeLimit]]();
}
checkScoreLimit() {
  if(game["state"] != "playing") {
    return false;
  }
  if(level.scoreLimit <= 0) {
    return false;
  }
  if(level.teamBased) {
    if(game["teamScores"]["allies"] < level.scoreLimit && game["teamScores"]["axis"] < level.scoreLimit) {
      return false;
    }
  } else {
    if(!isPlayer(self)) {
      return false;
    }
    if(self.score < level.scoreLimit) {
      return false;
    }
  }
  [[level.onScoreLimit]]();
}
updateGameTypeDvars() {
  level endon("game_ended");
  while(game["state"] == "playing") {
    roundlimit = maps\mp\gametypes\_globallogic_utils::getValueInRange(getDvarInt(level.roundLimitDvar), level.roundLimitMin, level.roundLimitMax);
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
    scoreLimit = maps\mp\gametypes\_globallogic_utils::getValueInRange(getDvarInt(level.scoreLimitDvar), level.scoreLimitMin, level.scoreLimitMax);
    if(scoreLimit != level.scoreLimit) {
      level.scoreLimit = scoreLimit;
      setDvar("ui_scorelimit", level.scoreLimit);
      level notify("update_scorelimit");
    }
    thread checkScoreLimit();
    if(isDefined(level.startTime)) {
      if(maps\mp\gametypes\_globallogic_utils::getTimeRemaining() < 3000) {
        wait .1;
        continue;
      }
    }
    wait 1;
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
  level.botsCount["allies"] = 0;
  level.botsCount["axis"] = 0;
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
      if(isDefined(player.pers["isBot"])) {
        level.botsCount[team]++;
      }
      if(player.sessionstate == "playing") {
        level.aliveCount[team]++;
        level.playerLives[team]++;
        if(isAlive(player)) {
          level.alivePlayers[team][level.alivePlayers[team].size] = player;
          level.activeplayers[level.activeplayers.size] = player;
        }
      } else {
        if(player maps\mp\gametypes\_globallogic_spawn::mayspawn()) {
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
checkTeamScoreLimitSoon(team) {
  assert(isDefined(team));
  if(level.scoreLimit <= 0) {
    return;
  }
  if(!level.teamBased) {
    return;
  }
  if(maps\mp\gametypes\_globallogic_utils::getTimePassed() < (60 * 1000)) {
    return;
  }
  timeLeft = maps\mp\gametypes\_globallogic_utils::getEstimatedTimeUntilScoreLimit(team);
  if(timeLeft < 1) {
    level notify("match_ending_soon", "score");
    maps\mp\_gameadvertisement::teamScoreLimitSoon(true);
  }
}
checkPlayerScoreLimitSoon() {
  assert(IsPlayer(self));
  if(level.scoreLimit <= 0) {
    return;
  }
  if(level.teamBased) {
    return;
  }
  if(maps\mp\gametypes\_globallogic_utils::getTimePassed() < (60 * 1000)) {
    return;
  }
  timeLeft = maps\mp\gametypes\_globallogic_utils::getEstimatedTimeUntilScoreLimit(undefined);
  if(timeLeft < 1) {
    level notify("match_ending_soon", "score");
    maps\mp\_gameadvertisement::teamScoreLimitSoon(true);
  }
}
timeLimitClock() {
  level endon("game_ended");
  wait .05;
  clockObject = spawn("script_origin", (0, 0, 0));
  while(game["state"] == "playing") {
    if(!level.timerStopped && level.timeLimit) {
      timeLeft = maps\mp\gametypes\_globallogic_utils::getTimeRemaining() / 1000;
      timeLeftInt = int(timeLeft + 0.5);
      if(timeLeftInt == 601) {
        clientnotify("notify_10");
      }
      if(timeLeftInt == 301) {
        clientnotify("notify_5");
      }
      if(timeLeftInt == 60) {
        clientnotify("notify_1");
      }
      if(timeLeftInt == 12) {
        clientnotify("notify_count");
      }
      if(timeLeftInt >= 40 && timeLeftInt <= 60) {
        level notify("match_ending_soon", "time");
      }
      if(timeLeftInt >= 30 && timeLeftInt <= 40) {
        level notify("match_ending_pretty_soon", "time");
      }
      if(timeLeftInt <= 32) {
        level notify("match_ending_vox");
      }
      if(timeLeftInt <= 10 || (timeLeftInt <= 30 && timeLeftInt % 2 == 0)) {
        level notify("match_ending_very_soon", "time");
        if(timeLeftInt == 0) {
          break;
        }
        clockObject playSound("mpl_ui_timer_countdown");
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
    clockObject playSound("mpl_ui_timer_countdown");
    wait(1.0);
  }
}
startGame() {
  thread maps\mp\gametypes\_globallogic_utils::gameTimer();
  level.timerStopped = false;
  if(level.numLives) {
    SetMatchTalkFlag("DeadChatWithDead", 1);
    SetMatchTalkFlag("DeadChatWithTeam", 0);
    SetMatchTalkFlag("DeadHearTeamLiving", 0);
    SetMatchTalkFlag("DeadHearAllLiving", 0);
    SetMatchTalkFlag("EveryoneHearsEveryone", 0);
  } else {
    SetMatchTalkFlag("DeadChatWithDead", 0);
    SetMatchTalkFlag("DeadChatWithTeam", 1);
    SetMatchTalkFlag("DeadHearTeamLiving", 1);
    SetMatchTalkFlag("DeadHearAllLiving", 0);
    SetMatchTalkFlag("EveryoneHearsEveryone", 0);
  }
  prematchPeriod();
  level notify("prematch_over");
  thread timeLimitClock();
  thread gracePeriod();
  thread watchMatchEndingSoon();
  thread maps\mp\gametypes\_globallogic_audio::musicController();
  thread maps\mp\gametypes\_missions::roundBegin();
  thread maps\mp\gametypes\_gametype_variants::onRoundBegin();
  recordMatchBegin();
}
waitForPlayers() {}
prematchPeriod() {
  setMatchFlag("hud_hardcore", level.hardcoreMode);
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
    level.players[index] freeze_player_controls(false);
    level.players[index] enableWeapons();
    hintMessage = maps\mp\gametypes\_globallogic_ui::getObjectiveHintText(level.players[index].pers["team"]);
    if(!isDefined(hintMessage) || !level.players[index].hasSpawned) {
      continue;
    }
    level.players[index] setClientDvar("scr_objectiveText", hintMessage);
    level.players[index] thread maps\mp\gametypes\_hud_message::hintMessage(hintMessage);
  }
  maps\mp\gametypes\_wager::prematchPeriod();
  maps\mp\gametypes\_globallogic_audio::leaderDialog("offense_obj", game["attackers"], "introboost");
  maps\mp\gametypes\_globallogic_audio::leaderDialog("defense_obj", game["defenders"], "introboost");
  if(game["state"] != "playing") {
    return;
  }
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
watchMatchEndingSoon() {
  SetDvar("xblive_matchEndingSoon", 0);
  level waittill("match_ending_soon", reason);
  SetDvar("xblive_matchEndingSoon", 1);
}
Callback_StartGameType() {
  level.prematchPeriod = 0;
  level.intermission = false;
  setmatchflag("cg_drawSpectatorMessages", 1);
  if(!isDefined(game["gamestarted"])) {
    if(!isDefined(game["allies"])) {
      game["allies"] = "marines";
    }
    if(!isDefined(game["axis"])) {
      game["axis"] = "nva";
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
    precacheRumble("damage_light");
    precacheShader("white");
    precacheShader("black");
    makeDvarServerInfo("scr_allies", "marines");
    makeDvarServerInfo("scr_axis", "nva");
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
    game["strings"]["waiting_to_spawn_ss"] = &"MP_WAITING_TO_SPAWN_SS";
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
    if(!level.createFX_enabled) {
      Assert(isDefined(game["strings"]["allies_win"]));
      Assert(isDefined(game["strings"]["allies_win_round"]));
      Assert(isDefined(game["strings"]["allies_mission_accomplished"]));
      Assert(isDefined(game["strings"]["allies_eliminated"]));
      Assert(isDefined(game["strings"]["allies_forfeited"]));
      Assert(isDefined(game["strings"]["allies_name"]));
      Assert(isDefined(game["music"]["spawn_allies"]));
      Assert(isDefined(game["music"]["victory_allies"]));
      Assert(isDefined(game["icons"]["allies"]));
      Assert(isDefined(game["colors"]["allies"]));
      Assert(isDefined(game["voice"]["allies"]));
      Assert(isDefined(game["strings"]["axis_win"]));
      Assert(isDefined(game["strings"]["axis_win_round"]));
      Assert(isDefined(game["strings"]["axis_mission_accomplished"]));
      Assert(isDefined(game["strings"]["axis_eliminated"]));
      Assert(isDefined(game["strings"]["axis_forfeited"]));
      Assert(isDefined(game["strings"]["axis_name"]));
      Assert(isDefined(game["music"]["spawn_axis"]));
      Assert(isDefined(game["music"]["victory_axis"]));
      Assert(isDefined(game["icons"]["axis"]));
      Assert(isDefined(game["colors"]["axis"]));
      Assert(isDefined(game["voice"]["axis"]));
    }
    [[level.onPrecacheGameType]]();
    game["gamestarted"] = true;
    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;
    game["totalKills"] = 0;
    game["totalKillsTeam"]["allies"] = 0;
    game["totalKillsTeam"]["axis"] = 0;
    if(!level.splitscreen && !isPreGame()) {
      level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "prematchperiod");
    }
    if(GetDvarInt(#"xblive_clanmatch") != 0) {
      game["icons"]["allies"] = "composite_emblem_team_allies";
      game["icons"]["axis"] = "composite_emblem_team_axis";
    }
  }
  if(!isDefined(game["timepassed"])) {
    game["timepassed"] = 0;
  }
  if(!isDefined(game["roundsplayed"])) {
    game["roundsplayed"] = 0;
  }
  if(!isDefined(game["roundwinner"])) {
    game["roundwinner"] = [];
  }
  if(!isDefined(game["roundswon"])) {
    game["roundswon"] = [];
  }
  if(!isDefined(game["roundswon"]["allies"])) {
    game["roundswon"]["allies"] = 0;
  }
  if(!isDefined(game["roundswon"]["axis"])) {
    game["roundswon"]["axis"] = 0;
  }
  if(!isDefined(game["roundswon"]["tie"])) {
    game["roundswon"]["tie"] = 0;
  }
  level.skipVote = false;
  level.gameEnded = false;
  SetDvar("g_gameEnded", 0);
  level.teamSpawnPoints["axis"] = [];
  level.teamSpawnPoints["allies"] = [];
  level.spawn_point_team_class_names["axis"] = [];
  level.spawn_point_team_class_names["allies"] = [];
  level.objIDStart = 0;
  level.forcedEnd = false;
  level.hostForcedEnd = false;
  level.hardcoreMode = GetDvarInt(#"scr_hardcore");
  if(level.hardcoreMode) {
    logString("game mode: hardcore");
    if(!isDefined(level.friendlyFireDelayTime)) {
      level.friendlyFireDelayTime = 0;
    }
  }
  if(GetDvar(#"scr_max_rank") == "") {
    setdvar("scr_max_rank", "0");
  }
  level.rankCap = GetDvarInt(#"scr_max_rank");
  if(GetDvar(#"scr_min_prestige") == "") {
    setdvar(#"scr_min_prestige", "0");
  }
  level.minPrestige = GetDvarInt(#"scr_min_prestige");
  level.useStartSpawns = true;
  if(GetDvar(#"scr_teamKillPunishCount") == "") {
    setdvar("scr_teamKillPunishCount", "3");
  }
  level.minimumAllowedTeamKills = GetDvarInt(#"scr_teamKillPunishCount") - 1;
  if(GetDvar(#"r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }
  maps\mp\_clientflags::init();
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
  thread maps\mp\gametypes\_battlechatter_mp::init();
  thread maps\mp\gametypes\_hardpoints::init();
  thread maps\mp\gametypes\_globallogic_audio::init();
  thread maps\mp\gametypes\_wager::init();
  thread maps\mp\gametypes\_gametype_variants::init();
  thread maps\mp\gametypes\_bot::init();
  thread maps\mp\_serverfaceanim_mp::init();
  thread maps\mp\_decoy::init();
  if(level.teamBased) {
    thread maps\mp\gametypes\_friendicons::init();
  }
  thread maps\mp\gametypes\_hud_message::init();
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
  level.allowAnnouncer = GetDvarInt(#"scr_allowannouncer");
  if(!isDefined(level.timeLimit)) {
    maps\mp\gametypes\_globallogic_utils::registerTimeLimitDvar("default", 10, 1, 1440);
  }
  if(!isDefined(level.scoreLimit)) {
    maps\mp\gametypes\_globallogic_utils::registerScoreLimitDvar("default", 100, 1, 500);
  }
  if(!isDefined(level.roundLimit)) {
    maps\mp\gametypes\_globallogic_utils::registerRoundLimitDvar("default", 1, 0, 10);
  }
  if(!isDefined(level.roundWinLimit)) {
    maps\mp\gametypes\_globallogic_utils::registerRoundWinLimitDvar("default", 1, 0, 10);
  }
  maps\mp\gametypes\_globallogic_utils::registerPostRoundEvent(maps\mp\gametypes\_killcam::postRoundFinalKillcam);
  maps\mp\gametypes\_globallogic_utils::registerPostRoundEvent(maps\mp\gametypes\_wager::postRoundSideBet);
  makeDvarServerInfo("ui_scorelimit");
  makeDvarServerInfo("ui_timelimit");
  makeDvarServerInfo("ui_allow_classchange", GetDvar(#"ui_allow_classchange"));
  waveDelay = GetDvarInt("scr_" + level.gameType + "_waverespawndelay");
  if(waveDelay && !isPreGame()) {
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
  }
  else {
    level.gracePeriod = 5;
  }
  level.inGracePeriod = true;
  level.roundEndDelay = 5;
  level.halftimeRoundEndDelay = 3;
  maps\mp\gametypes\_globallogic_score::updateTeamScores("axis", "allies");
  if(GetDvar(#"scr_game_killstreaks") == "") {
    setdvar("scr_game_killstreaks", true);
  }
  level.killstreaksenabled = GetDvarInt(#"scr_game_killstreaks");
  if(GetDvar(#"scr_game_hardpoints") == "") {
    setdvar("scr_game_hardpoints", true);
  }
  level.hardpointsenabled = GetDvarInt(#"scr_game_hardpoints");
  if(GetDvar(#"scr_game_rankenabled") == "") {
    setdvar("scr_game_rankenabled", true);
  }
  level.rankEnabled = GetDvarInt(#"scr_game_rankenabled");
  if(GetDvar(#"scr_game_medalsenabled") == "") {
    setdvar("scr_game_medalsenabled", true);
  }
  level.medalsEnabled = GetDvarInt(#"scr_game_medalsenabled");
  if(level.hardcoreMode && level.rankedMatch && getDvar(#"scr_game_friendlyFireDelay") == "") {
    setDvar("scr_game_friendlyFireDelay", true);
  }
  level.friendlyFireDelay = GetDvarInt(#"scr_game_friendlyFireDelay");
  [[level.onStartGameType]]();
  if(getDvarInt("custom_killstreak_mode") == 1) {
    level.killstreaksenabled = 0;
    level.hardpointsenabled = 0;
  }
  if(!level.console && !isPregame()) {
    StartDemoRecording();
  }
  thread startGame();
  level thread updateGameTypeDvars();
}
registerFriendlyFireDelay(dvarString, defaultValue, minValue, maxValue) {
  dvarString = ("scr_" + dvarString + "_friendlyFireDelayTime");
  if(getDvar(dvarString) == "") {
    setDvar(dvarString, defaultValue);
  }
  if(getDvarInt(dvarString) > maxValue) {
    setDvar(dvarString, maxValue);
  }
  else if(getDvarInt(dvarString) < minValue) {
    setDvar(dvarString, minValue);
  }
  level.friendlyFireDelayTime = getDvarInt(dvarString);
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
getPerks(player) {
  perks[0] = "specialty_null";
  perks[1] = "specialty_null";
  perks[2] = "specialty_null";
  perks[3] = "specialty_null";
  if(isPlayer(player) && !level.oldschool && (GetDvarInt(#"scr_disable_cac") != 1)) {
    if((isSubstr(player.curClass, "CLASS_CUSTOM") || isSubstr(player.curClass, "CLASS_PRESTIGE")) && isDefined(player.custom_class)) {
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
    } else if(player.curClass == "copycat") {
      if(isDefined(player.pers["copycat_loadout"]["specialty1"])) {
        perks[0] = player.pers["copycat_loadout"]["specialty1"];
      }
      if(isDefined(player.pers["copycat_loadout"]["specialty2"])) {
        perks[1] = player.pers["copycat_loadout"]["specialty2"];
      }
      if(isDefined(player.pers["copycat_loadout"]["specialty3"])) {
        perks[2] = player.pers["copycat_loadout"]["specialty3"];
      }
      if(isDefined(player.pers["copycat_loadout"]["specialty4"])) {
        perks[3] = player.pers["copycat_loadout"]["specialty4"];
      }
    } else if(player is_bot()) {
      if(isDefined(player.bot["specialty1"])) {
        perks[0] = player.bot["specialty1"];
      }
      if(isDefined(player.bot["specialty2"])) {
        perks[1] = player.bot["specialty2"];
      }
      if(isDefined(player.bot["specialty3"])) {
        perks[2] = player.bot["specialty3"];
      }
    } else {
      if(isDefined(level.default_perkIcon) && !maps\mp\gametypes\_customClasses::isUsingCustomGameModeClasses()) {
        for(numPerks = 0; numPerks < level.default_perkIcon[player.curClass].size; numPerks++) {
          if(isDefined(level.default_perkIcon[player.curClass][numPerks])) {
            perks[numPerks] = level.default_perkIcon[player.curClass][numPerks];
          }
        }
      }
    }
  }
  return perks;
}
getKillStreaks(player) {
  killstreak[0] = "killstreak_null";
  killstreak[1] = "killstreak_null";
  killstreak[2] = "killstreak_null";
  killstreak[3] = "killstreak_null";
  killstreak[4] = "killstreak_null";
  if(isPlayer(player) && !level.oldschool && (GetDvarInt(#"scr_disable_cac") != 1)) {
    if(!isDefined(player.pers["isBot"]) && isDefined(player.killstreak)) {
      class_num = player.class_num;
      if(isDefined(player.killstreak[0])) {
        killstreak[0] = player.killstreak[0];
      }
      if(isDefined(player.killstreak[1])) {
        killstreak[1] = player.killstreak[1];
      }
      if(isDefined(player.killstreak[2])) {
        killstreak[2] = player.killstreak[2];
      }
    } else if(player.curClass == "copycat") {
      if(isDefined(player.pers["copycat_loadout"]["killstreak1"])) {
        killstreak[0] = player.pers["copycat_loadout"]["killstreak1"];
      }
      if(isDefined(player.pers["copycat_loadout"]["killstreak2"])) {
        killstreak[1] = player.pers["copycat_loadout"]["killstreak2"];
      }
      if(isDefined(player.pers["copycat_loadout"]["killstreak3"])) {
        killstreak[2] = player.pers["copycat_loadout"]["killstreak3"];
      }
    }
  }
  return killstreak;
}
updateRankedMatch(winner) {
  if(level.rankedMatch) {
    maps\mp\gametypes\_globallogic_score::setXenonRanks();
    if(hostIdledOut()) {
      level.hostForcedEnd = true;
      logString("host idled out");
      endLobby();
    }
  }
  if(!level.wagerMatch) {
    maps\mp\gametypes\_globallogic_score::updateMatchBonusScores(winner);
    maps\mp\gametypes\_globallogic_score::updateWinLossStats(winner);
  }
}