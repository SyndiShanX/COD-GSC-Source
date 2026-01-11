/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gamelogic.gsc
********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

FACTION_REF_COL = 0;
FACTION_NAME_COL = 1;
FACTION_SHORT_NAME_COL = 1;
FACTION_WIN_GAME_COL = 3;
FACTION_WIN_ROUND_COL = 4;
FACTION_MISSION_ACCOMPLISHED_COL = 5;
FACTION_ELIMINATED_COL = 6;
FACTION_FORFEITED_COL = 7;
FACTION_ICON_COL = 8;
FACTION_HUD_ICON_COL = 9;
FACTION_VOICE_PREFIX_COL = 10;
FACTION_SPAWN_MUSIC_COL = 11;
FACTION_WIN_MUSIC_COL = 12;
FACTION_COLOR_R_COL = 13;
FACTION_COLOR_G_COL = 14;
FACTION_COLOR_B_COL = 15;

HACK_EXTRA_PRESTIGE_PRECACHE = 11;

onForfeit(team) {
  if(isDefined(level.forfeitInProgress)) {
    return;
  }
  level endon("abort_forfeit");

  level thread forfeitWaitforAbort();

  level.forfeitInProgress = true;

  if(!level.teambased && level.players.size > 1) {
    wait(10);
  }
  else {
    wait(1.05);
  }

  level.forfeit_aborted = false;
  forfeit_delay = 20.0;
  matchForfeitTimer(forfeit_delay);

  endReason = &"";
  if(!isDefined(team)) {
    level.finalKillCam_winner = "none";
    endReason = game["end_reason"]["players_forfeited"];
    winner = level.players[0];
  } else if(team == "axis") {
    level.finalKillCam_winner = "axis";
    endReason = game["end_reason"]["allies_forfeited"];
    winner = "axis";
  } else if(team == "allies") {
    level.finalKillCam_winner = "allies";
    endReason = game["end_reason"]["axis_forfeited"];
    winner = "allies";
  } else {
    if(level.multiTeamBased && IsSubStr(team, "team_")) {
      winner = team;
    } else {
      assertEx(isDefined(team), "Forfeited team is not defined");
      assertEx(0, "Forfeited team " + team + " is not allies or axis");
      level.finalKillCam_winner = "none";
      winner = "tie";
    }
  }

  level.forcedEnd = true;

  if(isPlayer(winner)) {
    logString("forfeit, win: " + winner getXuid() + "(" + winner.name + ")");
  }
  else {
    logString("forfeit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  }
  thread endGame(winner, endReason);
}

forfeitWaitforAbort() {
  level endon("game_ended");

  level waittill("abort_forfeit");

  level.forfeit_aborted = true;
  SetOmnvar("ui_match_start_countdown", 0);
}

matchForfeitTimer_Internal(countTime) {
  waittillframeend;

  level endon("match_forfeit_timer_beginning");

  while(countTime > 0 && !level.gameEnded && !level.forfeit_aborted && !level.inGracePeriod) {
    SetOmnvar("ui_match_start_countdown", countTime);
    countTime--;
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(1.0);
  }
  SetOmnvar("ui_match_start_countdown", 0);
}

matchForfeitTimer(duration) {
  level notify("match_forfeit_timer_beginning");

  countTime = int(duration);
  SetOmnvar("ui_match_start_text", "opponent_forfeiting_in");

  matchForfeitTimer_Internal(countTime);
}

default_onDeadEvent(team) {
  level.finalKillCam_winner = "none";

  if(team == "allies") {
    iPrintLn(&"MP_GHOSTS_ELIMINATED");

    logString("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    level.finalKillCam_winner = "axis";
    thread endGame("axis", game["end_reason"]["allies_eliminated"]);
  } else if(team == "axis") {
    iPrintLn(&"MP_FEDERATION_ELIMINATED");

    logString("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    level.finalKillCam_winner = "allies";
    thread endGame("allies", game["end_reason"]["axis_eliminated"]);
  } else {
    logString("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    level.finalKillCam_winner = "none";
    if(level.teamBased) {
      thread endGame("tie", game["end_reason"]["tie"]);
    }
    else {
      thread endGame(undefined, game["end_reason"]["tie"]);
    }
  }
}

default_onOneLeftEvent(team) {
  if(level.teamBased) {
    assert(team == "allies" || team == "axis");

    lastPlayer = getLastLivingPlayer(team);

    if(isDefined(lastPlayer)) {
      lastPlayer thread giveLastOnTeamWarning();
    }
  } else {
    lastPlayer = getLastLivingPlayer();

    logString("last one alive, win: " + lastPlayer.name);
    level.finalKillCam_winner = "none";
    thread endGame(lastPlayer, game["end_reason"]["enemies_eliminated"]);
  }

  return true;
}

default_onTimeLimit() {
  winner = undefined;
  level.finalKillCam_winner = "none";

  if(level.teamBased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      winner = "tie";
    }
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.finalKillCam_winner = "axis";
      winner = "axis";
    } else {
      level.finalKillCam_winner = "allies";
      winner = "allies";
    }

    logString("time limit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    winner = maps\mp\gametypes\_gamescore::getHighestScoringPlayer();

    if(isDefined(winner)) {
      logString("time limit, win: " + winner.name);
    }
    else {
      logString("time limit, tie");
    }
  }

  thread endGame(winner, game["end_reason"]["time_limit_reached"]);
}

default_onHalfTime() {
  winner = undefined;

  level.finalKillCam_winner = "none";
  thread endGame("halftime", game["end_reason"]["time_limit_reached"]);
}

forceEnd(reason) {
  if(level.hostForcedEnd || level.forcedEnd) {
    return;
  }
  winner = undefined;
  level.finalKillCam_winner = "none";

  if(level.teamBased) {
    if(GetDvarInt("squad_match") == 1 && isDefined(reason) && reason == 2) {
      winner = "axis";
    } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      winner = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.finalKillCam_winner = "axis";
      winner = "axis";
    } else {
      level.finalKillCam_winner = "allies";
      winner = "allies";
    }
    logString("host ended game, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    winner = maps\mp\gametypes\_gamescore::getHighestScoringPlayer();
    if(isDefined(winner)) {
      logString("host ended game, win: " + winner.name);
    }
    else {
      logString("host ended game, tie");
    }
  }

  level.forcedEnd = true;
  level.hostForcedEnd = true;

  if(level.splitscreen) {
    endString = game["end_reason"]["ended_game"];
  }
  else {
    endString = game["end_reason"]["host_ended_game"];
  }

  if(isDefined(reason) && reason == 2) {
    endString = game["end_reason"]["allies_forfeited"];
  }

  level notify("force_end");

  thread endGame(winner, endString);
}

onScoreLimit() {
  scoreText = game["end_reason"]["score_limit_reached"];
  winner = undefined;

  level.finalKillCam_winner = "none";

  if(level.multiTeamBased) {
    winner = maps\mp\gametypes\_gamescore::getWinningTeam();
    if(winner == "none") {
      winner = "tie";
    }
  } else if(level.teamBased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      winner = "tie";
    }
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
      level.finalKillCam_winner = "axis";
    } else {
      winner = "allies";
      level.finalKillCam_winner = "allies";
    }
    logString("scorelimit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    winner = maps\mp\gametypes\_gamescore::getHighestScoringPlayer();
    if(isDefined(winner)) {
      logString("scorelimit, win: " + winner.name);
    }
    else {
      logString("scorelimit, tie");
    }
  }

  thread endGame(winner, scoreText);
  return true;
}

updateGameEvents() {
  if(matchMakingGame() && !level.inGracePeriod && (!isDefined(level.disableForfeit) || !level.disableForfeit)) {
    if(level.multiTeamBased) {
      totalPlayers = 0;
      numActiveTeams = 0;
      for(i = 0; i < level.teamNameList.size; i++) {
        totalPlayers = totalPlayers + level.teamCount[level.teamNameList[i]];
        if(level.teamCount[level.teamNameList[i]]) {
          numActiveTeams = numActiveTeams + 1;
        }
      }

      for(i = 0; i < level.teamNameList.size; i++) {
        if(totalPlayers == level.teamCount[level.teamNameList[i]] && game["state"] == "playing") {
          thread onForfeit(level.teamNameList[i]);
          return;
        }
      }

      if(numActiveTeams > 1) {
        level.forfeitInProgress = undefined;
        level notify("abort_forfeit");
      }

    } else if(level.teamBased) {
      if(level.teamCount["allies"] < 1 && level.teamCount["axis"] > 0 && game["state"] == "playing") {
        thread onForfeit("axis");
        return;
      }

      if(level.teamCount["axis"] < 1 && level.teamCount["allies"] > 0 && game["state"] == "playing") {
        thread onForfeit("allies");
        return;
      }

      if(level.teamCount["axis"] > 0 && level.teamCount["allies"] > 0) {
        level.forfeitInProgress = undefined;
        level notify("abort_forfeit");
      }
    } else {
      if(level.teamCount["allies"] + level.teamCount["axis"] == 1 && level.maxPlayerCount > 1) {
        thread onForfeit();
        return;
      }

      if(level.teamCount["axis"] + level.teamCount["allies"] > 1) {
        level.forfeitInProgress = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(!getGametypeNumLives() && (!isDefined(level.disableSpawning) || !level.disableSpawning)) {
    return;
  }
  if(!gameHasStarted()) {
    return;
  }
  if(level.inGracePeriod) {
    return;
  }
  if(level.multiTeamBased) {
    return;
  }
  if(level.teamBased) {
    livesCount["allies"] = level.livesCount["allies"];
    livesCount["axis"] = level.livesCount["axis"];

    if(isDefined(level.disableSpawning) && level.disableSpawning) {
      livesCount["allies"] = 0;
      livesCount["axis"] = 0;
    }

    if(!level.aliveCount["allies"] && !level.aliveCount["axis"] && !livesCount["allies"] && !livesCount["axis"]) {
      return [
        [level.onDeadEvent]
      ]("all");
    }

    if(!level.aliveCount["allies"] && !livesCount["allies"]) {
      return [
        [level.onDeadEvent]
      ]("allies");
    }

    if(!level.aliveCount["axis"] && !livesCount["axis"]) {
      return [
        [level.onDeadEvent]
      ]("axis");
    }

    one_ally_left = (level.aliveCount["allies"] == 1 && !livesCount["allies"]);
    one_axis_left = (level.aliveCount["axis"] == 1 && !livesCount["axis"]);
    if(one_ally_left || one_axis_left) {
      return_val = undefined;
      if(one_ally_left && !isDefined(level.oneLeftTime["allies"])) {
        level.oneLeftTime["allies"] = getTime();
        ally_return_val = [
          [level.onOneLeftEvent]
        ]("allies");
        if(isDefined(ally_return_val)) {
          if(!isDefined(return_val)) {
            return_val = ally_return_val;
          }
          return_val = return_val || ally_return_val;
        }
      }

      if(one_axis_left && !isDefined(level.oneLeftTime["axis"])) {
        level.oneLeftTime["axis"] = getTime();
        axis_return_val = [
          [level.onOneLeftEvent]
        ]("axis");
        if(isDefined(axis_return_val)) {
          if(!isDefined(return_val)) {
            return_val = axis_return_val;
          }
          return_val = return_val || axis_return_val;
        }
      }

      return return_val;
    }
  } else {
    if((!level.aliveCount["allies"] && !level.aliveCount["axis"]) && (!level.livesCount["allies"] && !level.livesCount["axis"])) {
      return [
        [level.onDeadEvent]
      ]("all");
    }

    livePlayers = getPotentialLivingPlayers();

    if(livePlayers.size == 1) {
      return [
        [level.onOneLeftEvent]
      ]("all");
    }
  }
}

waittillFinalKillcamDone() {
  if(!isDefined(level.finalKillCam_winner)) {
    return false;
  }

  level waittill("final_killcam_done");

  return true;
}

timeLimitClock_Intermission(waitTime) {
  setGameEndTime(getTime() + int(waitTime * 1000));
  clockObject = spawn("script_origin", (0, 0, 0));
  clockObject hide();

  if(waitTime >= 10.0) {
    wait(waitTime - 10.0);
  }

  for(;;) {
    clockObject playSound("ui_mp_timer_countdown");
    wait(1.0);
  }
}

waitForPlayers(maxTime) {
  startTime = gettime();
  endTime = startTime + maxTime * 1000 - 200;

  if(maxTime > 5) {
    minTime = gettime() + getDvarInt("min_wait_for_players") * 1000;
  }
  else {
    minTime = 0;
  }

  numToWaitFor = (level.connectingPlayers / 3);

  for(;;) {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
      break;
    }

    totalSpawnedPlayers = level.maxPlayerCount;

    curTime = gettime();

    if((totalSpawnedPlayers >= numToWaitFor && (curTime > minTime)) || curTime > endTime) {
      break;
    }

    wait 0.05;
  }

  totalTime = gettime() - startTime;
  printLn("waitForPlayers waited " + totalTime + "ms for players to join");
}

prematchPeriod() {
  level endon("game_ended");
  level.connectingPlayers = GetDvarInt("party_partyPlayerCountNum");

  if(level.prematchPeriod > 0) {
    matchStartTimerWaitForPlayers();
  } else {
    matchStartTimerSkip();
  }

  foreach(player in level.players) {
    player freezeControlsWrapper(false);
    player enableWeapons();

    if(!isDefined(player.pers["team"])) {
      continue;
    }
    player_team = player.pers["team"];
    hintMessage = getObjectiveHintText(player_team);
    if(!isDefined(hintMessage) || !player.hasSpawned) {
      continue;
    }
    idx = 0;
    if(game["defenders"] == player_team) {
      idx = 1;
    }
    player SetClientOmnvar("ui_objective_text", idx);
  }

  if(game["state"] != "playing") {
    return;
  }
}

gracePeriod() {
  level endon("game_ended");

  if(!isDefined(game["clientActive"])) {
    while(GetActiveClientCount() == 0) {
      wait 0.05;
    }

    game["clientActive"] = true;
  }

  while(level.inGracePeriod > 0) {
    wait(1.0);
    level.inGracePeriod--;
  }

  level notify("grace_period_ending");
  wait(0.05);

  gameFlagSet("graceperiod_done");
  level.inGracePeriod = false;

  if(game["state"] != "playing") {
    return;
  }
  if(getGametypeNumLives()) {
    players = level.players;

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!player.hasSpawned && player.sessionteam != "spectator" && !isAlive(player)) {
        player.statusicon = "hud_status_dead";
      }
    }
  }

  level thread updateGameEvents();
}

setHasDoneCombat(player, newHasDoneCombat) {
  player.hasDoneCombat = newHasDoneCombat;

  wasFalse = (!isDefined(player.hasDoneAnyCombat) || !player.hasDoneAnyCombat);
  if(wasFalse && newHasDoneCombat) {
    player.hasDoneAnyCombat = true;

    if(isDefined(player.pers["hasMatchLoss"]) && player.pers["hasMatchLoss"]) {
      return;
    }
    if(!is_aliens()) {
      maps\mp\gametypes\_gamelogic::updateLossStats(player);
    }
  }
}

updateWinStats(winner) {
  if(!winner rankingEnabled()) {
    return;
  }
  if(!isDefined(winner.hasDoneAnyCombat) || !winner.hasDoneAnyCombat) {
    return;
  }
  if(!IsSquadsMode()) {
    winner maps\mp\gametypes\_persistence::statAdd("losses", -1);

    println("setting winner: " + winner maps\mp\gametypes\_persistence::statGet("wins"));
    winner maps\mp\gametypes\_persistence::statAdd("wins", 1);
    winner updatePersRatio("winLossRatio", "wins", "losses");
    winner maps\mp\gametypes\_persistence::statAdd("currentWinStreak", 1);

    cur_win_streak = winner maps\mp\gametypes\_persistence::statGet("currentWinStreak");
    if(cur_win_streak > winner maps\mp\gametypes\_persistence::statGet("winStreak")) {
      winner maps\mp\gametypes\_persistence::statSet("winStreak", cur_win_streak);
    }
  }

  winner maps\mp\gametypes\_persistence::statSetChild("round", "win", true);
  winner maps\mp\gametypes\_persistence::statSetChild("round", "loss", false);
}

updateLossStats(loser) {
  if(!loser rankingEnabled()) {
    return;
  }
  if(!isDefined(loser.hasDoneAnyCombat) || !loser.hasDoneAnyCombat) {
    return;
  }
  loser.pers["hasMatchLoss"] = true;

  if(!IsSquadsMode()) {
    loser maps\mp\gametypes\_persistence::statAdd("losses", 1);
    loser updatePersRatio("winLossRatio", "wins", "losses");

    self maps\mp\gametypes\_persistence::statAdd("gamesPlayed", 1);
  }
  loser maps\mp\gametypes\_persistence::statSetChild("round", "loss", true);
}

updateTieStats(loser) {
  if(!loser rankingEnabled()) {
    return;
  }
  if(!isDefined(loser.hasDoneAnyCombat) || !loser.hasDoneAnyCombat) {
    return;
  }
  if(!IsSquadsMode()) {
    loser maps\mp\gametypes\_persistence::statAdd("losses", -1);

    loser maps\mp\gametypes\_persistence::statAdd("ties", 1);
    loser updatePersRatio("winLossRatio", "wins", "losses");
    loser maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
  }

  loser maps\mp\gametypes\_persistence::statSetChild("round", "loss", false);
}

updateWinLossStats(winner) {
  if(privateMatch()) {
    return;
  }
  if(!wasLastRound()) {
    return;
  }
  players = level.players;

  updatePlayerCombatStatus();

  if(!isDefined(winner) || (isDefined(winner) && isString(winner) && winner == "tie")) {
    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }
      if(level.hostForcedEnd && player isHost()) {
        if(!IsSquadsMode()) {
          player maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
        }
        continue;
      }

      updateTieStats(player);
    }
  } else if(isPlayer(winner)) {
    if(level.hostForcedEnd && winner isHost()) {
      if(!IsSquadsMode()) {
        winner maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
      }
      return;
    }

    updateWinStats(winner);
  } else if(isString(winner)) {
    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }
      if(level.hostForcedEnd && player isHost()) {
        if(!IsSquadsMode()) {
          player maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
        }
        continue;
      }

      if(winner == "tie") {
        updateTieStats(player);
      } else if(player.pers["team"] == winner) {
        updateWinStats(player);
      } else {
        if(!IsSquadsMode()) {
          player maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
        }
      }
    }
  }
}

updatePlayerCombatStatus() {
  if(level.gameType != "infect") {
    return;
  }
  foreach(player in level.players) {
    if(player.sessionstate == "spectator" && !player.spectatekillcam) {
      continue;
    }
    else if(isDefined(player.hasDoneAnyCombat) && player.hasDoneAnyCombat) {
      continue;
    }
    else if(player.team == "axis") {
      continue;
    }
    else {
      player setHasDoneCombat(player, true);
    }
  }
}

freezePlayerForRoundEnd(delay) {
  self endon("disconnect");
  self clearLowerMessages();

  if(!isDefined(delay)) {
    delay = 0.05;
  }

  wait(delay);
  self freezeControlsWrapper(true);
}

updateMatchBonusScores(winner) {
  if(!game["timePassed"]) {
    return;
  }
  if(!matchMakingGame()) {
    return;
  }
  if(!getTimeLimit() || level.forcedEnd) {
    gameLength = getTimePassed() / 1000;

    gameLength = min(gameLength, 1200);
  } else {
    gameLength = getTimeLimit() * 60;
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
      setWinningTeam(winningTeam);
    } else {
      winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
      loserScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
    }

    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }
      if(!player rankingEnabled()) {
        continue;
      }
      if(player.timePlayed["total"] < 1 || player.pers["participation"] < 1) {
        player thread maps\mp\gametypes\_rank::endGameUpdate();
        continue;
      }

      if(level.hostForcedEnd && player isHost()) {
        continue;
      }
      if(!isDefined(player.hasDoneAnyCombat) || !player.hasDoneAnyCombat) {
        continue;
      }
      spm = player maps\mp\gametypes\_rank::getSPM();
      if(winningTeam == "tie") {
        playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (player.timePlayed["total"] / gameLength));
        player thread giveMatchBonus("tie", playerScore);
        player.matchBonus = playerScore;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] == winningTeam) {
        playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (player.timePlayed["total"] / gameLength));
        player thread giveMatchBonus("win", playerScore);
        player.matchBonus = playerScore;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] == losingTeam) {
        playerScore = int((loserScale * ((gameLength / 60) * spm)) * (player.timePlayed["total"] / gameLength));
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

    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }
      if(player.timePlayed["total"] < 1 || player.pers["participation"] < 1) {
        player thread maps\mp\gametypes\_rank::endGameUpdate();
        continue;
      }

      if(!isDefined(player.hasDoneAnyCombat) || !player.hasDoneAnyCombat) {
        continue;
      }
      spm = player maps\mp\gametypes\_rank::getSPM();

      isWinner = false;
      for(pIdx = 0; pIdx < min(level.placement["all"].size, 3); pIdx++) {
        if(level.placement["all"][pIdx] != player) {
          continue;
        }
        isWinner = true;
      }

      if(isWinner) {
        playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (player.timePlayed["total"] / gameLength));
        player thread giveMatchBonus("win", playerScore);
        player.matchBonus = playerScore;
      } else {
        playerScore = int((loserScale * ((gameLength / 60) * spm)) * (player.timePlayed["total"] / gameLength));
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
    spm = player.score;
    if(getMinutesPassed()) {
      spm = player.score / getMinutesPassed();
    }

    println("Score:" + player.score + " Minutes Passed:" + getMinutesPassed() + " SPM:" + spm);

    setPlayerTeamRank(player, player.clientid, int(spm));
  }
}

checkTimeLimit(prevTimePassed) {
  if(isDefined(level.timeLimitOverride) && level.timeLimitOverride) {
    return;
  }
  if(game["state"] != "playing") {
    setGameEndTime(0);
    return;
  }

  if(getTimeLimit() <= 0) {
    if(isDefined(level.startTime)) {
      setGameEndTime(level.startTime);
    }
    else {
      setGameEndTime(0);
    }
    return;
  }

  if(!gameFlag("prematch_done")) {
    setGameEndTime(0);
    return;
  }

  if(!isDefined(level.startTime)) {
    return;
  }
  if(getTimePassedPercentage() > level.timePercentageCutOff) {
    SetNoJIPTime(true);
  }

  timeLeft = getTimeRemaining();

  setGameEndTime(getTime() + int(timeLeft));

  if(timeLeft > 0) {
    return;
  }

  [[level.onTimeLimit]]();
}

getTimeRemaining() {
  return getTimeLimit() * 60 * 1000 - getTimePassed();
}

getTimeRemainingPercentage() {
  timeLimit = getTimeLimit() * 60 * 1000;

  return (timeLimit - getTimePassed()) / timeLimit;
}

checkTeamScoreLimitSoon(team) {
  assert(isDefined(team));

  if(getWatchedDvar("scorelimit") <= 0 || isObjectiveBased()) {
    return;
  }
  if(isDefined(level.scoreLimitOverride) && level.scoreLimitOverride) {
    return;
  }
  if(level.gameType == "conf" || level.gameType == "jugg") {
    return;
  }
  if(!level.teamBased) {
    return;
  }
  if(getTimePassed() < (60 * 1000)) {
    return;
  }
  timeLeft = estimatedTimeTillScoreLimit(team);

  if(timeLeft < 2) {
    level notify("match_ending_soon", "score");
  }
}

checkPlayerScoreLimitSoon() {
  if(getWatchedDvar("scorelimit") <= 0 || isObjectiveBased()) {
    return;
  }
  if(level.teamBased) {
    return;
  }
  if(getTimePassed() < (60 * 1000)) {
    return;
  }
  timeLeft = self estimatedTimeTillScoreLimit();

  if(timeLeft < 2) {
    level notify("match_ending_soon", "score");
  }
}

checkScoreLimit() {
  if(isObjectiveBased()) {
    return false;
  }

  if(isDefined(level.scoreLimitOverride) && level.scoreLimitOverride) {
    return false;
  }

  if(game["state"] != "playing") {
    return false;
  }

  if(getWatchedDvar("scorelimit") <= 0) {
    return false;
  }

  if(level.teamBased) {
    limitReached = false;

    for(i = 0; i < level.teamNameList.size; i++) {
      if(game["teamScores"][level.teamNameList[i]] >= getWatchedDvar("scorelimit")) {
        limitReached = true;
      }
    }

    if(!limitReached) {
      return false;
    }
  } else {
    if(!isPlayer(self)) {
      return false;
    }

    if(self.score < getWatchedDvar("scorelimit")) {
      return false;
    }
  }

  return onScoreLimit();
}

updateGameTypeDvars() {
  level endon("game_ended");

  while(game["state"] == "playing") {
    if(isDefined(level.startTime)) {
      if(getTimeRemaining() < 3000) {
        wait .1;
        continue;
      }
    }
    wait 1;
  }
}

matchStartTimerWaitForPlayers() {
  thread matchStartTimer("match_starting_in", level.prematchPeriod + level.prematchPeriodEnd);

  waitForPlayers(level.prematchPeriod);

  if(level.prematchPeriodEnd > 0 && !isDefined(level.hostMigrationTimer)) {
    adjusted_time = level.prematchPeriodEnd;

    if(isRoundBased() && !isFirstRound() || isMLGMatch()) {
      adjusted_time = level.prematchPeriod;
    }
    matchStartTimer("match_starting_in", adjusted_time);
  }
}

matchStartTimer_Internal(countTime) {
  waittillframeend;
  introVisionSet();

  level endon("match_start_timer_beginning");
  while(countTime > 0 && !level.gameEnded) {
    SetOmnvar("ui_match_start_countdown", countTime);
    if(countTime == 0) {
      visionSetNaked("", 0);
    }
    countTime--;
    wait(1.0);
  }
  SetOmnvar("ui_match_start_countdown", 0);
}

matchStartTimer(type, duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");

  level notify("match_start_timer_beginning");

  countTime = int(duration);

  if(countTime >= 2) {
    SetOmnvar("ui_match_start_text", type);

    matchStartTimer_Internal(countTime);
    visionSetNaked("", 3.0);
  } else {
    introVisionSet();
    visionSetNaked("", 1.0);
  }
}

introVisionSet() {
  if(!isDefined(level.introVisionSet)) {
    level.introVisionSet = "mpIntro";
  }
  visionSetNaked(level.introVisionSet, 0);
}

matchStartTimerSkip() {
  visionSetNaked("", 0);
}

onRoundSwitch() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = false;
  }

  if(game["roundsWon"]["allies"] == getWatchedDvar("winlimit") - 1 && game["roundsWon"]["axis"] == getWatchedDvar("winlimit") - 1) {
    aheadTeam = getBetterTeam();
    if(aheadTeam != game["defenders"]) {
      game["switchedsides"] = !game["switchedsides"];
      level.switchedSides = true;
    } else {
      level.switchedSides = undefined;
    }

    level.halftimeType = "overtime";
  } else {
    level.halftimeType = "halftime";
    game["switchedsides"] = !game["switchedsides"];
    level.switchedSides = true;
  }
}

checkRoundSwitch() {
  if(!level.teamBased) {
    return false;
  }

  if(!isDefined(level.roundSwitch) || !level.roundSwitch) {
    return false;
  }

  assert(game["roundsPlayed"] > 0);
  if(game["roundsPlayed"] % level.roundSwitch == 0) {
    onRoundSwitch();
    return true;
  }

  return false;
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

  if(getTimeLimit() <= 0) {
    return undefined;
  }

  if(!isDefined(level.startTime)) {
    return undefined;
  }

  tl = getTimeLimit();

  timePassed = (getTime() - level.startTime) / 1000;
  timeRemaining = (getTimeLimit() * 60) - timePassed;

  if(isDefined(level.timePaused)) {
    timeRemaining += level.timePaused;
  }

  return timeRemaining + level.postRoundTime;
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
  players = getEntArray("player", "classname");

  for(index = 0; index < players.size; index++) {
    if(players[index] isHost()) {
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

roundEndWait(defaultDelay, matchBonus) {
  notifiesDone = false;
  while(!notifiesDone) {
    players = level.players;
    notifiesDone = true;

    foreach(player in players) {
      if(!isDefined(player.doingSplash)) {
        continue;
      }
      if(!player maps\mp\gametypes\_hud_message::isDoingSplash()) {
        continue;
      }
      notifiesDone = false;
    }
    wait(0.5);
  }

  if(!matchBonus) {
    wait(defaultDelay);
    level notify("round_end_finished");

    return;
  }

  wait(defaultDelay / 2);
  level notify("give_match_bonus");
  wait(defaultDelay / 2);

  notifiesDone = false;
  while(!notifiesDone) {
    players = level.players;
    notifiesDone = true;
    foreach(player in players) {
      if(!isDefined(player.doingSplash)) {
        continue;
      }
      if(!player maps\mp\gametypes\_hud_message::isDoingSplash()) {
        continue;
      }
      notifiesDone = false;
    }
    wait(0.5);
  }

  level notify("round_end_finished");
}

roundEndDOF(time) {
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}

updateSquadVsSquad() {
  for(;;) {
    SetNoJIPTime(true);
    wait 0.05;
  }
}

Callback_StartGameType() {
  maps\mp\_load::main();

  levelFlagInit("round_over", false);
  levelFlagInit("game_over", false);
  levelFlagInit("block_notifies", false);
  levelFlagInit("post_game_level_event_active", false);

  level.prematchPeriod = 0;
  level.prematchPeriodEnd = 0;
  level.postGameNotifies = 0;

  level.intermission = false;

  SetDvar("bg_compassShowEnemies", getDvar("scr_game_forceuav"));

  if(matchMakingGame()) {
    SetDvar("isMatchMakingGame", 1);
  }
  else {
    SetDvar("isMatchMakingGame", 0);
  }

  if(level.multiTeamBased) {
    SetDvar("ui_numteams", level.numTeams);
  }

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    game["truncated_killcams"] = 0;

    if(!isDefined(game["attackers"]) || !isDefined(game["defenders"])) {
      thread error("No attackers or defenders team defined in level .gsc.");
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

    game["allies"] = "ghosts";
    game["axis"] = "federation";

    game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
    game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
    game["strings"]["spawn_flag_wait"] = &"MP_SPAWN_FLAG_WAIT";
    game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
    game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
    game["strings"]["waiting_to_safespawn"] = &"MP_WAITING_TO_SAFESPAWN";
    game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
    game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
    game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
    game["strings"]["c4_death"] = &"MPUI_C4_DEATH";

    game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";

    game["colors"]["black"] = (0.0, 0.0, 0.0);
    game["colors"]["white"] = (1.0, 1.0, 1.0);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);
    game["colors"]["orange"] = (0.9, 0.6, 0.0);
    game["colors"]["blue"] = (0.2, 0.3, 0.7);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0.0);

    game["strings"]["allies_name"] = maps\mp\gametypes\_teams::getTeamName("allies");
    game["icons"]["allies"] = maps\mp\gametypes\_teams::getTeamIcon("allies");
    game["colors"]["allies"] = maps\mp\gametypes\_teams::getTeamColor("allies");

    game["strings"]["axis_name"] = maps\mp\gametypes\_teams::getTeamName("axis");
    game["icons"]["axis"] = maps\mp\gametypes\_teams::getTeamIcon("axis");
    game["colors"]["axis"] = maps\mp\gametypes\_teams::getTeamColor("axis");

    if(game["colors"]["allies"] == game["colors"]["black"]) {
      game["colors"]["allies"] = game["colors"]["grey"];
    }

    if(game["colors"]["axis"] == game["colors"]["black"]) {
      game["colors"]["axis"] = game["colors"]["grey"];
    }

    [[level.onPrecacheGameType]]();

    SetDvarIfUninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        if(isMLGMatch() || IsDedicatedServer()) {
          level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "graceperiod_comp");
        }
        else {
          level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "graceperiod");
        }

        level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "matchstarttime");
      }
    } else {
      if(isMLGMatch() || IsDedicatedServer()) {
        level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "playerwaittime_comp");
      }
      else {
        level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "playerwaittime");
      }

      level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "matchstarttime");
    }

    SetNoJIPScore(false);
    SetNoJIPTime(false);

    if(GetDvar("squad_vs_squad") == "1") {
      thread updateSquadVsSquad();
    }
  } else {
    SetDvarIfUninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        level.prematchPeriod = 5;
        level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "matchstarttime");
      }
    } else {
      level.prematchPeriod = 5;
      level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "matchstarttime");
    }
  }

  if(!isDefined(game["status"])) {
    game["status"] = "normal";
  }

  SetDvar("ui_overtime", (game["status"] == "overtime"));

  if(game["status"] != "overtime" && game["status"] != "halftime") {
    if(!(isDefined(game["switchedsides"]) && game["switchedsides"] == true && isModdedRoundGame())) {
      game["teamScores"]["allies"] = 0;
      game["teamScores"]["axis"] = 0;
    }

    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        game["teamScores"][level.teamNameList[i]] = 0;
      }
    }
  }

  if(!isDefined(game["timePassed"])) {
    game["timePassed"] = 0;
  }

  if(!isDefined(game["roundsPlayed"])) {
    game["roundsPlayed"] = 0;
  }

  if(!isDefined(game["roundsWon"])) {
    game["roundsWon"] = [];
  }

  if(level.teamBased) {
    if(!isDefined(game["roundsWon"]["axis"])) {
      game["roundsWon"]["axis"] = 0;
    }
    if(!isDefined(game["roundsWon"]["allies"])) {
      game["roundsWon"]["allies"] = 0;
    }

    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        if(!isDefined(game["roundsWon"][level.teamNameList[i]])) {
          game["roundsWon"][level.teamNameList[i]] = 0;
        }
      }
    }
  }

  level.gameEnded = false;
  level.forcedEnd = false;
  level.hostForcedEnd = false;

  if(!is_aliens()) {
    level.hardcoreMode = getDvarInt("g_hardcore");
  }
  if(level.hardcoreMode) {
    logString("game mode: hardcore");
  }

  level.dieHardMode = getDvarInt("scr_diehard");

  if(!level.teamBased) {
    level.dieHardMode = 0;
  }

  if(level.dieHardMode) {
    logString("game mode: diehard");
  }

  level.killstreakRewards = getDvarInt("scr_game_hardpoints");

  printLn("SESSION INFO");
  printLn("=====================================");
  printLn("Map: " + level.script);
  printLn("Script:" + level.gametype);
  printLn("HardCore:" + level.hardcoreMode);
  printLn("Diehard: " + level.dieHardMode);
  printLn("3rd Person:" + getDvarInt("camera_thirdperson"));
  printLn("Round: " + game["roundsPlayed"]);
  printLn("scr_" + level.gametype + "_scorelimit " + getDvar("scr_" + level.gametype + "_scorelimit"));
  printLn("scr_" + level.gametype + "_roundlimit " + getDvar("scr_" + level.gametype + "_roundlimit"));
  printLn("scr_" + level.gametype + "_winlimit " + getDvar("scr_" + level.gametype + "_winlimit"));
  printLn("scr_" + level.gametype + "_timelimit " + getDvar("scr_" + level.gametype + "_timelimit"));
  printLn("scr_" + level.gametype + "_numlives " + getDvar("scr_" + level.gametype + "_numlives"));
  printLn("scr_" + level.gametype + "_halftime " + getDvar("scr_" + level.gametype + "_halftime"));
  printLn("scr_" + level.gametype + "_roundswitch " + getDvar("scr_" + level.gametype + "_roundswitch"));
  printLn("=====================================");

  level.useStartSpawns = true;

  level.objectivePointsMod = 1;

  if(matchMakingGame()) {
    level.maxAllowedTeamKills = 2;
  }
  else {
    level.maxAllowedTeamKills = -1;
  }

  if(!is_aliens()) {
    thread maps\mp\gametypes\_healthoverlay::init();
    thread maps\mp\gametypes\_killcam::init();
    thread maps\mp\gametypes\_damage::initFinalKillCam();
    thread maps\mp\gametypes\_battlechatter_mp::init();
    thread maps\mp\gametypes\_music_and_dialog::init();
  }
  thread[[level.intelInit]]();
  thread maps\mp\gametypes\_persistence::init();
  thread maps\mp\gametypes\_menus::init();
  thread maps\mp\gametypes\_hud::init();
  thread maps\mp\gametypes\_serversettings::init();
  thread maps\mp\gametypes\_teams::init();
  thread maps\mp\gametypes\_weapons::init();
  thread maps\mp\gametypes\_outline::init();
  thread maps\mp\gametypes\_shellshock::init();
  thread maps\mp\gametypes\_deathicons::init();
  thread maps\mp\gametypes\_damagefeedback::init();
  thread maps\mp\gametypes\_objpoints::init();
  thread maps\mp\gametypes\_gameobjects::init();
  thread maps\mp\gametypes\_spectating::init();
  thread maps\mp\gametypes\_spawnlogic::init();
  thread maps\mp\_matchdata::init();
  thread maps\mp\_awards::init();
  thread maps\mp\_areas::init();
  thread[[level.killStreakInit]]();
  thread maps\mp\perks\_perks::init();
  thread maps\mp\_events::init();
  thread maps\mp\_defcon::init();
  thread[[level.matchEventsInit]]();

  thread maps\mp\_zipline::init();

  if(level.teamBased) {
    thread maps\mp\gametypes\_friendicons::init();
  }

  thread maps\mp\gametypes\_hud_message::init();

  game["gamestarted"] = true;

  level.maxPlayerCount = 0;
  level.waveDelay["allies"] = 0;
  level.waveDelay["axis"] = 0;
  level.lastWave["allies"] = 0;
  level.lastWave["axis"] = 0;
  level.wavePlayerSpawnIndex["allies"] = 0;
  level.wavePlayerSpawnIndex["axis"] = 0;
  level.alivePlayers["allies"] = [];
  level.alivePlayers["axis"] = [];
  level.activePlayers = [];

  if(level.multiTeamBased) {
    for(i = 0; i < level.teamNameList.size; i++) {
      level._waveDelay[level.teamNameList[i]] = 0;
      level._lastWave[level.teamNameList[i]] = 0;
      level._wavePlayerSpawnIndex[level.teamNameList[i]] = 0;
      level._alivePlayers[level.teamNameList[i]] = [];
    }
  }

  SetDvar("ui_scorelimit", 0);
  SetDvar("ui_allow_teamchange", 1);

  if(getGametypeNumLives()) {
    setdvar("g_deadChat", 0);
  }
  else {
    setdvar("g_deadChat", 1);
  }

  waveDelay = getDvarInt("scr_" + level.gameType + "_waverespawndelay");
  if(waveDelay) {
    level.waveDelay["allies"] = waveDelay;
    level.waveDelay["axis"] = waveDelay;
    level.lastWave["allies"] = 0;
    level.lastWave["axis"] = 0;

    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        level._waveDelay[level.teamNameList[i]] = waveDelay;
        level._lastWave[level.teamNameList[i]] = 0;
      }
    }

    level thread maps\mp\gametypes\_gamelogic::waveSpawnTimer();
  }

  gameFlagInit("prematch_done", false);

  if(is_aliens()) {
    level.gracePeriod = 10;
  } else
    level.gracePeriod = 15;

  level.inGracePeriod = level.gracePeriod;
  gameFlagInit("graceperiod_done", false);

  level.roundEndDelay = 4;
  level.halftimeRoundEndDelay = 4;

  level.noRagdollEnts = getEntArray("noragdoll", "targetname");

  if(level.teamBased) {
    maps\mp\gametypes\_gamescore::updateTeamScore("axis");
    maps\mp\gametypes\_gamescore::updateTeamScore("allies");

    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        maps\mp\gametypes\_gamescore::updateTeamScore(level.teamNameList[i]);
      }
    }
  } else {
    thread maps\mp\gametypes\_gamescore::initialDMScoreUpdate();
  }

  thread updateUIScoreLimit();
  level notify("update_scorelimit");

  [[level.onStartGameType]]();

  level.scorePercentageCutOff = GetDvarInt("scr_" + level.gameType + "_score_percentage_cut_off", 80);
  level.timePercentageCutOff = GetDvarInt("scr_" + level.gameType + "_time_percentage_cut_off", 80);

  thread[[level.devInit]]();

  if((!level.console) && ((getDvar("dedicated") == "dedicated LAN server") || (getDvar("dedicated") == "dedicated internet server"))) {
    thread verifyDedicatedConfiguration();
  }

  thread startGame();

  level thread updateWatchedDvars();
  level thread timeLimitThread();

  if(!is_aliens()) {
    level thread maps\mp\gametypes\_damage::doFinalKillcam();
  } else {
    monitorAliensFailed();
  }
}

Callback_CodeEndGame() {
  endparty();

  if(!level.gameEnded) {
    level thread maps\mp\gametypes\_gamelogic::forceEnd();
  }
}

verifyDedicatedConfiguration() {
  for(;;) {
    if(level.rankedMatch) {
      ExitLevel(false);
    }

    if(!getDvarInt("xblive_privatematch")) {
      ExitLevel(false);
    }

    if((getDvar("dedicated") != "dedicated LAN server") && (getDvar("dedicated") != "dedicated internet server")) {
      ExitLevel(false);
    }

    wait 5;
  }
}

timeLimitThread() {
  level endon("game_ended");

  prevTimePassed = getTimePassed();

  while(game["state"] == "playing") {
    thread checkTimeLimit(prevTimePassed);
    prevTimePassed = getTimePassed();

    if(isDefined(level.startTime)) {
      if(getTimeRemaining() < 3000) {
        wait .1;
        continue;
      }
    }
    wait 1;
  }
}

updateUIScoreLimit() {
  for(;;) {
    level waittill_either("update_scorelimit", "update_winlimit");

    if(!isRoundBased() || !isObjectiveBased()) {
      SetDvar("ui_scorelimit", getWatchedDvar("scorelimit"));
      thread checkScoreLimit();
    } else {
      SetDvar("ui_scorelimit", getWatchedDvar("winlimit"));
    }
  }
}

playTickingSound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");

  time = level.bombTimer;

  while(1) {
    self playSound("ui_mp_suitcasebomb_timer");

    if(time > 10) {
      time -= 1;
      wait 1;
    } else if(time > 4) {
      time -= .5;
      wait .5;
    } else if(time > 1) {
      time -= .4;
      wait .4;
    } else {
      time -= .3;
      wait .3;
    }
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }
}

stopTickingSound() {
  self notify("stop_ticking");
}

timeLimitClock() {
  level endon("game_ended");

  wait .05;

  clockObject = spawn("script_origin", (0, 0, 0));
  clockObject hide();

  while(game["state"] == "playing") {
    if(!level.timerStopped && getTimeLimit()) {
      timeLeft = getTimeRemaining() / 1000;
      timeLeftInt = int(timeLeft + 0.5);

      if((timeLeftInt >= 30 && timeLeftInt <= 60)) {
        level notify("match_ending_soon", "time");
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

gameTimer() {
  level endon("game_ended");

  level waittill("prematch_over");

  level.startTime = getTime();
  level.discardTime = 0;

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.startTime -= game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  prevtime = gettime();

  while(game["state"] == "playing") {
    if(!level.timerStopped) {
      game["timePassed"] += gettime() - prevtime;
    }
    prevtime = gettime();
    wait(1.0);
  }
}

UpdateTimerPausedness() {
  shouldBeStopped = level.timerStoppedForGameMode || isDefined(level.hostMigrationTimer);
  if(!gameFlag("prematch_done")) {
    shouldBeStopped = false;
  }

  if(!level.timerStopped && shouldBeStopped) {
    level.timerStopped = true;
    level.timerPauseTime = gettime();
  } else if(level.timerStopped && !shouldBeStopped) {
    level.timerStopped = false;
    level.discardTime += gettime() - level.timerPauseTime;
  }
}

pauseTimer() {
  level.timerStoppedForGameMode = true;
  UpdateTimerPausedness();
}

resumeTimer() {
  level.timerStoppedForGameMode = false;
  UpdateTimerPausedness();
}

startGame() {
  thread gameTimer();
  level.timerStopped = false;
  level.timerStoppedForGameMode = false;

  SetOmnvar("ui_prematch_period", 1);

  if(isDefined(level.customprematchperiod)) {
    [[level.customprematchPeriod]]();
  }
  else {
    prematchPeriod();
  }

  gameFlagSet("prematch_done");
  level notify("prematch_over");
  SetOmnvar("ui_prematch_period", 0);

  UpdateTimerPausedness();

  thread timeLimitClock();
  thread gracePeriod();

  if(!is_aliens()) {
    thread maps\mp\gametypes\_missions::roundBegin();
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

    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        if(time - level.lastWave[level.teamNameList[i]] > (level._waveDelay[level.teamNameList[i]] * 1000)) {
          str_notify = "wave_rewpawn_" + level.teamNameList[i];

          level notify(str_notify);
          level.lastWave[level.teamNameList[i]] = time;
          level.wavePlayerSpawnIndex[level.teamNameList[i]] = 0;
        }
      }
    }

    wait(0.05);
  }
}

getBetterTeam() {
  kills["allies"] = 0;
  kills["axis"] = 0;
  deaths["allies"] = 0;
  deaths["axis"] = 0;

  foreach(player in level.players) {
    team = player.pers["team"];
    if(isDefined(team) && (team == "allies" || team == "axis")) {
      kills[team] += player.kills;
      deaths[team] += player.deaths;
    }
  }

  if(kills["allies"] > kills["axis"]) {
    return "allies";
  }
  else if(kills["axis"] > kills["allies"]) {
    return "axis";
  }

  if(deaths["allies"] < deaths["axis"]) {
    return "allies";
  }
  else if(deaths["axis"] < deaths["allies"]) {
    return "axis";
  }

  if(randomint(2) == 0) {
    return "allies";
  }
  return "axis";
}

rankedMatchUpdates(winner) {
  if(matchMakingGame()) {
    setXenonRanks();

    if(hostIdledOut()) {
      level.hostForcedEnd = true;
      logString("host idled out");
      endLobby();
    }

    updateMatchBonusScores(winner);
  }

  updateWinLossStats(winner);
}

displayRoundEnd(winner, endReasonText) {
  if(isModdedRoundGame()) {
    winner = "roundend";

    allies_numTracks = game["music"]["allies_suspense"].size;
    axis_numTracks = game["music"]["axis_suspense"].size;

    playSoundOnPlayers(game["music"]["allies_suspense"][randomInt(allies_numTracks)], "allies");
    playSoundOnPlayers(game["music"]["axis_suspense"][randomInt(axis_numTracks)], "axis");
  }

  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }
    if(level.teamBased) {
      player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, true, endReasonText);
    }
    else {
      player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
    }
  }

  if(!wasLastRound()) {
    level notify("round_win", winner);
  }

  if(wasLastRound()) {
    roundEndWait(level.roundEndDelay, false);
  }
  else {
    roundEndWait(level.roundEndDelay, true);
  }
}

displayGameEnd(winner, endReasonText) {
  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }
    if(level.teamBased) {
      player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, false, endReasonText);
    }
    else {
      player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
    }
  }

  level notify("game_win", winner);

  roundEndWait(level.postRoundTime, true);
}

displayRoundSwitch() {
  switchType = level.halftimeType;
  if(switchType == "halftime") {
    if(getWatchedDvar("roundlimit")) {
      if((game["roundsPlayed"] * 2) == getWatchedDvar("roundlimit")) {
        switchType = "halftime";
      }
      else {
        switchType = "intermission";
      }
    } else if(getWatchedDvar("winlimit")) {
      if(game["roundsPlayed"] == (getWatchedDvar("winlimit") - 1)) {
        switchType = "halftime";
      }
      else {
        switchType = "intermission";
      }
    } else {
      switchType = "intermission";
    }
  }

  level notify("round_switch", switchType);

  endReason = 0;
  if(isDefined(level.switchedSides)) {
    endReason = game["end_reason"]["switching_sides"];
  }

  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }
    player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(switchType, true, endReason);
  }

  roundEndWait(level.halftimeRoundEndDelay, false);
}

freezeAllPlayers(delay, additionalClientDvarName1, additionalClientDvarValue1) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  foreach(player in level.players) {
    player thread freezePlayerForRoundEnd(delay);
    player thread roundEndDoF(4.0);

    player freeGameplayHudElems();

    player setClientDvars("cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0);

    if(isDefined(additionalClientDvarName1) && isDefined(additionalClientDvarValue1)) {
      player setClientDvars(additionalClientDvarName1, additionalClientDvarValue1);
    }

  }

  foreach(agent in level.agentArray) {
    agent freezeControlsWrapper(true);
  }
}

endGameOvertime(winner, endReasonText) {
  VisionSetNaked("mpOutro", 0.5);
  SetDvar("bg_compassShowEnemies", 0);

  freezeAllPlayers();

  level notify("round_switch", "overtime");

  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }
    if(level.teamBased) {
      player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, false, endReasonText);
    }
    else {
      player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
    }
  }

  roundEndWait(level.roundEndDelay, false);

  if(isDefined(level.finalKillCam_winner)) {
    level.finalKillCam_timeGameEnded[level.finalKillCam_winner] = getSecondsPassed();

    foreach(player in level.players) {
    player notify("reset_outcome");
    }

    level notify("game_cleanup");

    waittillFinalKillcamDone();

    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
        continue;
      }
      if(level.teamBased) {
        player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, false, endReasonText);
      }
      else {
        player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
      }
    }
  }

  game["status"] = "overtime";
  level notify("restarting");
  game["state"] = "playing";
  map_restart(true);
}

endGameHalfTime() {
  VisionSetNaked("mpOutro", 0.5);
  SetDvar("bg_compassShowEnemies", 0);

  game["switchedsides"] = !game["switchedsides"];
  level.switchedSides = undefined;

  freezeAllPlayers();

  foreach(player in level.players) {
  player.pers["stats"] = player.stats;
  }

  level notify("round_switch", "halftime");

  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }
    player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify("halftime", true, game["end_reason"]["switching_sides"]);
  }

  roundEndWait(level.roundEndDelay, false);

  if(isDefined(level.finalKillCam_winner)) {
    level.finalKillCam_timeGameEnded[level.finalKillCam_winner] = getSecondsPassed();

    foreach(player in level.players) {
    player notify("reset_outcome");
    }

    level notify("game_cleanup");

    waittillFinalKillcamDone();

    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
        continue;
      }
      player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify("halftime", true, game["end_reason"]["switching_sides"]);
    }
  }

  game["status"] = "halftime";
  level notify("restarting");
  game["state"] = "playing";
  SetDvar("ui_game_state", game["state"]);
  map_restart(true);
}

endGame(winner, endReasonText, nukeDetonated) {
  if(is_Aliens()) {
    [[level.endGame_Alien]](winner, endReasonText);
  }
  else {
    endGame_RegularMP(winner, endReasonText, nukeDetonated);
  }
}

endGame_RegularMP(winner, endReasonText, nukeDetonated) {
  if(!isDefined(nukeDetonated)) {
    nukeDetonated = false;
  }

  if(game["state"] == "postgame" || level.gameEnded && (!isDefined(level.gtnw) || !level.gtnw)) {
    return;
  }
  SetOmnvar("ui_pause_menu_show", false);

  game["state"] = "postgame";
  SetDvar("ui_game_state", "postgame");

  level.gameEndTime = getTime();
  level.gameEnded = true;
  level.inGracePeriod = false;
  level notify("game_ended", winner);
  levelFlagSet("game_over");
  levelFlagSet("block_notifies");
  waitframe();

  setGameEndTime(0);

  gameLength = getMatchData("gameLength");
  gameLength = gameLength + int(getSecondsPassed());
  setMatchData("gameLength", gameLength);

  maps\mp\gametypes\_playerlogic::printPredictedSpawnpointCorrectness();

  if(isDefined(winner) && isString(winner) && winner == "overtime") {
    level.finalKillCam_winner = "none";
    endGameOvertime(winner, endReasonText);
    return;
  }

  if(isDefined(winner) && isString(winner) && winner == "halftime") {
    level.finalKillCam_winner = "none";
    endGameHalfTime();
    return;
  }

  if(isDefined(level.finalKillCam_winner)) {
    level.finalKillCam_timeGameEnded[level.finalKillCam_winner] = getSecondsPassed();
  }

  game["roundsPlayed"]++;

  if(level.teamBased) {
    if(winner == "axis" || winner == "allies") {
      game["roundsWon"][winner]++;
    }

    maps\mp\gametypes\_gamescore::updateTeamScore("axis");
    maps\mp\gametypes\_gamescore::updateTeamScore("allies");
  } else {
    if(isDefined(winner) && isPlayer(winner)) {
      game["roundsWon"][winner.guid]++;
    }
  }

  maps\mp\gametypes\_gamescore::updatePlacement();

  rankedMatchUpdates(winner);

  foreach(player in level.players) {
    player setClientDvar("ui_opensummary", 1);

    if(wasOnlyRound() || wasLastRound()) {
      player maps\mp\killstreaks\_killstreaks::clearKillstreaks();
    }
  }

  setDvar("g_deadChat", 1);
  setDvar("ui_allow_teamchange", 0);
  SetDvar("bg_compassShowEnemies", 0);

  freezeAllPlayers(1.0, "cg_fovScale", 1);

  sendScriptUsageAnalysisData(1, 1);

  if(!nukeDetonated) {
    visionSetNaked("mpOutro", 0.5);
  }

  if(!wasOnlyRound() && !nukeDetonated) {
    displayRoundEnd(winner, endReasonText);

    if(isDefined(level.finalKillCam_winner)) {
      foreach(player in level.players) {
      player notify("reset_outcome");
      }

      level notify("game_cleanup");

      waittillFinalKillcamDone();
    }

    if(!wasLastRound()) {
      levelFlagClear("block_notifies");
      if(checkRoundSwitch()) {
        displayRoundSwitch();
      }

      foreach(player in level.players) {
      player.pers["stats"] = player.stats;
      }

      level notify("restarting");
      game["state"] = "playing";
      SetDvar("ui_game_state", "playing");
      map_restart(true);
      return;
    }

    if(!level.forcedEnd) {
      endReasonText = updateRoundEndReasonText(winner);
    }
  }

  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp/clientmatchdata.def";
    setClientMatchDataDef(game["clientMatchDataDef"]);
  }

  maps\mp\gametypes\_missions::roundEnd(winner);

  if(level.teamBased && isRoundBased() && level.gameEnded && !isModdedRoundGame()) {
    if(game["roundsWon"]["allies"] == game["roundsWon"]["axis"]) {
      winner = "tie";
    } else if(game["roundsWon"]["axis"] > game["roundsWon"]["allies"]) {
      level.finalKillCam_winner = "axis";
      winner = "axis";
    } else {
      level.finalKillCam_winner = "allies";
      winner = "allies";
    }
  }

  displayGameEnd(winner, endReasonText);

  if(isDefined(level.finalKillCam_winner) && wasOnlyRound()) {
    foreach(player in level.players) {
    player notify("reset_outcome");
    }

    level notify("game_cleanup");

    waittillFinalKillcamDone();
  }

  levelFlagClear("block_notifies");

  level.intermission = true;

  level notify("start_custom_ending");
  level notify("spawning_intermission");

  foreach(player in level.players) {
    player notify("reset_outcome");
    player thread maps\mp\gametypes\_playerlogic::spawnIntermission();
  }

  processLobbyData();

  wait(1.0);

  checkForPersonalBests();

  if(level.teamBased) {
    if(winner == "axis" || winner == "allies") {
      setMatchData("victor", winner);
    }
    else {
      setMatchData("victor", "none");
    }

    setMatchData("alliesScore", getTeamScore("allies"));
    setMatchData("axisScore", getTeamScore("axis"));
  } else {
    setMatchData("victor", "none");
  }

  foreach(player in level.players) {
    player setCommonPlayerData("round", "endReasonTextIndex", endReasonText);

    if(player rankingEnabled() && !is_aliens()) {
      player maps\mp\_matchdata::logFinalStats();
    }

  }

  setMatchData("host", level.hostname);
  if(MatchMakingGame()) {
    setMatchData("playlistVersion", getPlaylistVersion());
    setMatchData("playlistID", getPlaylistID());
    setMatchData("isDedicated", isDedicatedServer());
  }

  sendMatchData();

  foreach(player in level.players) {
  player.pers["stats"] = player.stats;
  }

  if(!nukeDetonated && !level.postGameNotifies) {
    if(!wasOnlyRound()) {
      wait 6.0;
    }
    else {
      wait(min(10.0, 4.0 + level.postGameNotifies));
    }
  } else {
    wait(min(10.0, 4.0 + level.postGameNotifies));
  }

  levelFlagWaitOpen("post_game_level_event_active");

  SetNoJIPScore(false);
  SetNoJIPTime(false);

  level notify("exitLevel_called");
  exitLevel(false);
}

updateRoundEndReasonText(winner) {
  if(!level.teamBased) {
    return true;
  }

  if(isModdedRoundGame()) {
    if(hitScoreLimit()) {
      return game["end_reason"]["score_limit_reached"];
    }

    if(hitTimeLimit()) {
      return game["end_reason"]["time_limit_reached"];
    }
  } else {
    if(hitRoundLimit()) {
      return game["end_reason"]["round_limit_reached"];
    }
  }

  if(hitWinLimit()) {
    return game["end_reason"]["score_limit_reached"];
  }

  return game["end_reason"]["objective_completed"];
}

estimatedTimeTillScoreLimit(team) {
  assert(isPlayer(self) || isDefined(team));

  scorePerMinute = getScorePerMinute(team);
  scoreRemaining = getScoreRemaining(team);

  estimatedTimeLeft = 999999;
  if(scorePerMinute) {
    estimatedTimeLeft = scoreRemaining / scorePerMinute;
  }

  return estimatedTimeLeft;
}

getScorePerMinute(team) {
  assert(isPlayer(self) || isDefined(team));

  scoreLimit = getWatchedDvar("scorelimit");
  timeLimit = getTimeLimit();
  minutesPassed = (getTimePassed() / (60 * 1000)) + 0.0001;

  if(isPlayer(self)) {
    scorePerMinute = self.score / minutesPassed;
  }
  else {
    scorePerMinute = getTeamScore(team) / minutesPassed;
  }

  return scorePerMinute;
}

getScoreRemaining(team) {
  assert(isPlayer(self) || isDefined(team));

  scoreLimit = getWatchedDvar("scorelimit");

  if(isPlayer(self)) {
    scoreRemaining = scoreLimit - self.score;
  }
  else {
    scoreRemaining = scoreLimit - getTeamScore(team);
  }

  return scoreRemaining;
}

giveLastOnTeamWarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self waitTillRecoveredHealth(3);

  thread teamPlayerCardSplash("callout_lastteammemberalive", self, self.pers["team"]);

  foreach(teamname in level.teamNameList) {
    if(self.pers["team"] != teamname) {
      thread teamPlayerCardSplash("callout_lastenemyalive", self, teamname);
    }
  }

  level notify("last_alive", self);
}

processLobbyData() {
  curPlayer = 0;
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player.clientMatchDataId = curPlayer;
    curPlayer++;

    if(level.ps3 && (player.name.size > level.MaxNameLength)) {
      playerName = "";
      for(i = 0; i < level.MaxNameLength - 3; i++) {
        playerName += player.name[i];
      }

      playerName += "...";
    } else {
      playerName = player.name;
    }

    setClientMatchData("players", player.clientMatchDataId, "xuid", playerName);

    player setCommonPlayerData("round", "clientMatchIndex", player.clientMatchDataId);
  }

  maps\mp\_awards::assignAwards();
  maps\mp\_scoreboard::processLobbyScoreboards();

  sendClientMatchData();
}

trackLeaderBoardDeathStats(sWeapon, sMeansOfDeath) {
  self thread threadedSetWeaponStatByName(sWeapon, 1, "deaths");
}

trackAttackerLeaderBoardDeathStats(sWeapon, sMeansOfDeath) {
  if(isDefined(self) && isplayer(self)) {
    if(sMeansOfDeath != "MOD_FALLING") {
      if(sMeansOfDeath == "MOD_MELEE" && IsSubStr(sWeapon, "tactical")) {
        self maps\mp\_matchdata::logAttachmentStat("tactical", "kills", 1);
        self maps\mp\_matchdata::logAttachmentStat("tactical", "hits", 1);
        self maps\mp\gametypes\_persistence::incrementAttachmentStat("tactical", "kills", 1);
        self maps\mp\gametypes\_persistence::incrementAttachmentStat("tactical", "hits", 1);
        return;
      }

      if(sMeansOfDeath == "MOD_MELEE" && !maps\mp\gametypes\_weapons::isRiotShield(sWeapon) && sWeapon != "iw6_knifeonly_mp" && sWeapon != "iw6_knifeonlyfast_mp") {
        self maps\mp\_matchdata::logAttachmentStat("none", "kills", 1);
        self maps\mp\_matchdata::logAttachmentStat("none", "hits", 1);
        self maps\mp\gametypes\_persistence::incrementAttachmentStat("none", "kills", 1);
        self maps\mp\gametypes\_persistence::incrementAttachmentStat("none", "hits", 1);
        return;
      }

      self thread threadedSetWeaponStatByName(sWeapon, 1, "kills");
    }

    if(sMeansOfDeath == "MOD_HEAD_SHOT") {
      self thread threadedSetWeaponStatByName(sWeapon, 1, "headShots");
    }
  }
}

setWeaponStat(name, incValue, statName) {
  if(!incValue) {
    return;
  }
  weaponClass = getWeaponClass(name);

  if(weaponClass == "killstreak" || (weaponClass == "other" && name != "trophy_mp")) {
    return;
  }
  if(isEnvironmentWeapon(name)) {
    return;
  }
  if(weaponClass == "weapon_grenade" || weaponClass == "weapon_explosive" || name == "trophy_mp") {
    weaponName = strip_suffix(name, "_mp");
    self maps\mp\gametypes\_persistence::incrementWeaponStat(weaponName, statName, incValue);
    self maps\mp\_matchdata::logWeaponStat(weaponName, statName, incValue);
    return;
  }

  if(!isDefined(self.trackingWeaponName)) {
    self.trackingWeaponName = name;
  }

  if(name != self.trackingWeaponName) {
    self maps\mp\gametypes\_persistence::updateWeaponBufferedStats();
    self.trackingWeaponName = name;
  }

  switch (statName) {
    case "shots":
      self.trackingWeaponShots++;
      break;
    case "hits":
      self.trackingWeaponHits++;
      break;
    case "headShots":
      self.trackingWeaponHeadShots++;
      break;
    case "kills":
      self.trackingWeaponKills++;
      break;
  }

  if(statName == "deaths") {
    if(getDvarInt("g_debugDamage")) {
      println("wrote deaths");
    }

    altAttachment = undefined;
    weaponBaseName = getBaseWeaponName(name);

    if(!isCACPrimaryWeapon(weaponBaseName) && !isCACSecondaryWeapon(weaponBaseName)) {
      return;
    }
    attachments = getWeaponAttachmentsBaseNames(name);

    self maps\mp\gametypes\_persistence::incrementWeaponStat(weaponBaseName, statName, incValue);
    self maps\mp\_matchdata::logWeaponStat(weaponBaseName, "deaths", incValue);

    foreach(attachment in attachments) {
      if(attachment == "scope") {
        continue;
      }
      self maps\mp\gametypes\_persistence::incrementAttachmentStat(attachment, statName, incValue);
      self maps\mp\_matchdata::logAttachmentStat(attachment, statName, incValue);
    }
  }
}

setInflictorStat(eInflictor, eAttacker, sWeapon) {
  if(!isDefined(eAttacker)) {
    return;
  }
  if(!isDefined(eInflictor)) {
    eAttacker setWeaponStat(sWeapon, 1, "hits");
    return;
  }

  if(!isDefined(eInflictor.playerAffectedArray)) {
    eInflictor.playerAffectedArray = [];
  }

  foundNewPlayer = true;
  for(i = 0; i < eInflictor.playerAffectedArray.size; i++) {
    if(eInflictor.playerAffectedArray[i] == self) {
      foundNewPlayer = false;
      break;
    }
  }

  if(foundNewPlayer) {
    eInflictor.playerAffectedArray[eInflictor.playerAffectedArray.size] = self;
    eAttacker setWeaponStat(sWeapon, 1, "hits");
  }
}

threadedSetWeaponStatByName(name, incValue, statName) {
  self endon("disconnect");
  waittillframeend;

  setWeaponStat(name, incValue, statName);
}

checkForPersonalBests() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player rankingEnabled()) {
      roundKills = player getCommonPlayerData("round", "kills");
      roundDeaths = player getCommonPlayerData("round", "deaths");
      roundXP = player.pers["summary"]["xp"];

      bestKills = player getRankedPlayerData("bestKills");
      mostDeaths = player getRankedPlayerData("mostDeaths");
      mostXp = player getRankedPlayerData("mostXp");

      if(roundKills > bestKills) {
        player setRankedPlayerData("bestKills", roundKills);
      }

      if(roundXP > mostXp) {
        player setRankedPlayerData("mostXp", roundXP);
      }

      if(roundDeaths > mostDeaths) {
        player setRankedPlayerData("mostDeaths", roundDeaths);
      }

      if(!is_aliens()) {
        player checkForBestWeapon();
      }
      player maps\mp\_matchdata::logPlayerXP(roundXP, "totalXp");
      player maps\mp\_matchdata::logPlayerXP(player.pers["summary"]["score"], "scoreXp");
      player maps\mp\_matchdata::logPlayerXP(player.pers["summary"]["operation"], "operationXp");
      player maps\mp\_matchdata::logPlayerXP(player.pers["summary"]["challenge"], "challengeXp");
      player maps\mp\_matchdata::logPlayerXP(player.pers["summary"]["match"], "matchXp");
      player maps\mp\_matchdata::logPlayerXP(player.pers["summary"]["misc"], "miscXp");
    }

    if(isDefined(player.pers["confirmed"])) {
      player maps\mp\_matchdata::logKillsConfirmed();
    }
    if(isDefined(player.pers["denied"])) {
      player maps\mp\_matchdata::logKillsDenied();
    }

  }
}

isValidBestWeapon(baseName) {
  scriptClass = getWeaponClass(baseName);

  return isDefined(baseName) &&
    baseName != "" &&
    !isKillstreakWeapon(baseName) &&
    scriptClass != "killstreak" &&
    scriptClass != "other";
}

checkForBestWeapon() {
  baseWeaponList = maps\mp\_matchdata::buildBaseWeaponList();

  bestWeaponName = "";
  bestWeaponKills = -1;

  for(i = 0; i < baseWeaponList.size; i++) {
    weaponName = baseWeaponList[i];
    weaponName = getBaseWeaponName(weaponName);

    if(isValidBestWeapon(weaponName)) {
      weaponKills = self GetRankedPlayerData("weaponStats", weaponName, "kills");

      if(weaponKills > bestWeaponKills) {
        bestWeaponName = weaponName;
        bestWeaponKills = weaponKills;
      }
    }
  }

  weaponShots = self GetRankedPlayerData("weaponStats", bestWeaponName, "shots");
  weaponHeadShots = self GetRankedPlayerData("weaponStats", bestWeaponName, "headShots");
  weaponHits = self GetRankedPlayerData("weaponStats", bestWeaponName, "hits");
  weaponDeaths = self GetRankedPlayerData("weaponStats", bestWeaponName, "deaths");
  weaponXP = 0;

  self SetRankedPlayerData("bestWeapon", "kills", bestWeaponKills);
  self SetRankedPlayerData("bestWeapon", "shots", weaponShots);
  self SetRankedPlayerData("bestWeapon", "headShots", weaponHeadShots);
  self SetRankedPlayerData("bestWeapon", "hits", weaponHits);
  self SetRankedPlayerData("bestWeapon", "deaths", weaponDeaths);
  self SetRankedPlayerData("bestWeaponXP", weaponXP);

  statsTableIdx = Int(TableLookup("mp/statstable.csv", 4, bestWeaponName, 0));
  self SetRankedPlayerData("bestWeaponIndex", statsTableIdx);
}

monitorAliensFailed() {
  level waittill("round_end_finished");
  level notify("final_killcam_done");
  level.forcedEnd = true;
  level thread maps\mp\gametypes\_gamelogic::endGame("axis", game["end_reason"]["objective_failed"]);
}