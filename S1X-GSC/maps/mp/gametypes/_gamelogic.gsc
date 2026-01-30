/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gamelogic.gsc
***************************************************/

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
  } else {
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
    if(level.gametype == "infect") {
      endReason = game["end_reason"]["survivors_forfeited"];
    }
    winner = "axis";
  } else if(team == "allies") {
    level.finalKillCam_winner = "allies";
    endReason = game["end_reason"]["axis_forfeited"];
    if(level.gametype == "infect") {
      endReason = game["end_reason"]["infected_forfeited"];
    }
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
  } else {
    logString("forfeit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  }
  thread endGame(winner, endReason);
}

forfeitWaitforAbort() {
  level endon("game_ended");
  level waittill("abort_forfeit");
  level.forfeit_aborted = true;
  SetOmnvar("ui_match_countdown", 0);
  SetOmnvar("ui_match_countdown_title", 0);
  SetOmnvar("ui_match_countdown_toggle", 0);
}

matchForfeitTimer_Internal(countTime) {
  waittillframeend;

  level endon("match_forfeit_timer_beginning");

  SetOmnvar("ui_match_countdown_title", 3);
  SetOmnvar("ui_match_countdown_toggle", 1);

  while(countTime > 0 && !level.gameEnded && !level.forfeit_aborted && !level.inGracePeriod) {
    SetOmnvar("ui_match_countdown", countTime);
    wait(1);
    countTime--;
  }
}

matchForfeitTimer(duration) {
  level notify("match_forfeit_timer_beginning");
  countTime = int(duration);
  matchForfeitTimer_Internal(countTime);
  SetOmnvar("ui_match_countdown", 0);
  SetOmnvar("ui_match_countdown_title", 0);
  SetOmnvar("ui_match_countdown_toggle", 0);
}

default_onDeadEvent(team) {
  level.finalKillCam_winner = "none";

  if(team == "allies") {
    logString("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    level.finalKillCam_winner = "axis";
    thread endGame("axis", game["end_reason"]["allies_eliminated"]);
  } else if(team == "axis") {
    logString("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    level.finalKillCam_winner = "allies";
    thread endGame("allies", game["end_reason"]["axis_eliminated"]);
  } else {
    logString("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    level.finalKillCam_winner = "none";
    if(level.teamBased) {
      thread endGame("tie", game["end_reason"]["tie"]);
    } else {
      thread endGame(undefined, game["end_reason"]["tie"]);
    }
  }
}

default_onOneLeftEvent(team) {
  if(level.teamBased) {
    assert(team == "allies" || team == "axis");

    lastPlayer = getLastLivingPlayer(team);
    lastPlayer thread giveLastOnTeamWarning();
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
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.finalKillCam_winner = "axis";
      winner = "axis";
    } else {
      level.finalKillCam_winner = "allies";
      winner = "allies";
    }

    if(practiceRoundGame()) {
      winner = "none";
    }

    logString("time limit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    winner = maps\mp\gametypes\_gamescore::getHighestScoringPlayer();

    if(isDefined(winner)) {
      logString("time limit, win: " + winner.name);
    } else {
      logString("time limit, tie");
    }
  }

  thread endGame(winner, game["end_reason"]["time_limit_reached"]);
}

default_onHalfTime(reason) {
  winner = undefined;

  level.finalKillCam_winner = "none";
  thread endGame("halftime", game["end_reason"][reason]);
}

forceEnd() {
  if(level.hostForcedEnd || level.forcedEnd) {
    return;
  }

  winner = undefined;
  level.finalKillCam_winner = "none";

  if(level.teamBased) {
    if(isDefined(level.isHorde)) {
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
    } else {
      logString("host ended game, tie");
    }
  }

  level.forcedEnd = true;
  level.hostForcedEnd = true;

  if(level.splitscreen) {
    endString = game["end_reason"]["ended_game"];
  } else {
    endString = game["end_reason"]["host_ended_game"];
  }

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
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
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
    } else {
      logString("scorelimit, tie");
    }
  }

  thread endGame(winner, scoreText);
  return true;
}

updateGameEvents() {
  if(matchMakingGame() && !level.inGracePeriod && !getdvarint("force_ranking") && (!isDefined(level.disableForfeit) || !level.disableForfeit)) {
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
      return [[level.onDeadEvent]]("all");
    }

    if(!level.aliveCount["allies"] && !livesCount["allies"]) {
      return [[level.onDeadEvent]]("allies");
    }

    if(!level.aliveCount["axis"] && !livesCount["axis"]) {
      return [[level.onDeadEvent]]("axis");
    }

    one_ally_left = (level.aliveCount["allies"] == 1 && !livesCount["allies"]);
    one_axis_left = (level.aliveCount["axis"] == 1 && !livesCount["axis"]);
    if((one_ally_left || one_axis_left) && !isDefined(level.bot_spawn_from_devgui_in_progress)) {
      return_val = undefined;
      if(one_ally_left && !isDefined(level.oneLeftTime["allies"])) {
        level.oneLeftTime["allies"] = getTime();
        ally_return_val = [[level.onOneLeftEvent]]("allies");
        if(isDefined(ally_return_val)) {
          if(!isDefined(return_val)) {
            return_val = ally_return_val;
          }
          return_val = return_val || ally_return_val;
        }
      }

      if(one_axis_left && !isDefined(level.oneLeftTime["axis"])) {
        level.oneLeftTime["axis"] = getTime();
        axis_return_val = [[level.onOneLeftEvent]]("axis");
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
      return [[level.onDeadEvent]]("all");
    }

    livePlayers = getPotentialLivingPlayers();

    if(livePlayers.size == 1) {
      return [[level.onOneLeftEvent]]("all");
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
  } else {
    minTime = 0;
  }

  numToWaitFor = (level.connectingPlayers / 3);

  blurFade = false;

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
    level.waitingForPlayers = true;
    matchStartTimerWaitForPlayers();
    level.waitingForPlayers = false;
  } else {
    matchStartTimerSkip();
  }

  for(index = 0; index < level.players.size; index++) {
    level.players[index] freezeControlsWrapper(false);
    level.players[index] enableWeapons();
    level.players[index] EnableAmmoGeneration();

    hintMessage = getObjectiveHintText(level.players[index].pers["team"]);
    if(!isDefined(hintMessage) || !level.players[index].hasSpawned) {
      continue;
    }

    level.players[index] thread maps\mp\gametypes\_hud_message::hintMessage(hintMessage);
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

  level thread updateGameEvents();
}

setHasDoneCombat(player, newHasDoneCombat) {
  player.hasDoneCombat = newHasDoneCombat;

  player notify("hasDoneCombat");

  wasFalse = (!isDefined(player.hasDoneAnyCombat) || !player.hasDoneAnyCombat);
  if(wasFalse && newHasDoneCombat) {
    player.hasDoneAnyCombat = true;

    if(isDefined(player.pers["hasMatchLoss"]) && player.pers["hasMatchLoss"]) {
      return;
    }

    maps\mp\gametypes\_gamelogic::updateLossStats(player);
  }
}

updateWinStats(winner) {
  if(!winner rankingEnabled()) {
    return;
  }

  if((!isDefined(winner.hasDoneAnyCombat) || !winner.hasDoneAnyCombat) && !(level.gameType == "infect")) {
    return;
  }

  winner maps\mp\gametypes\_persistence::statAdd("losses", -1);

  println("setting winner: " + winner maps\mp\gametypes\_persistence::statGet("wins"));
  winner maps\mp\gametypes\_persistence::statAdd("wins", 1);
  winner updatePersRatio("winLossRatio", "wins", "losses");
  winner maps\mp\gametypes\_persistence::statAdd("currentWinStreak", 1);

  cur_win_streak = winner maps\mp\gametypes\_persistence::statGet("currentWinStreak");
  if(cur_win_streak > winner maps\mp\gametypes\_persistence::statGet("winStreak")) {
    winner maps\mp\gametypes\_persistence::statSet("winStreak", cur_win_streak);
  }

  winner maps\mp\gametypes\_persistence::statSetChild("round", "win", true);
  winner maps\mp\gametypes\_persistence::statSetChild("round", "loss", false);
  winner maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_wins");
  winner.combatRecordWin = true;

  winner maps\mp\gametypes\_missions::processChallengeDaily(25, undefined, undefined);
  winner maps\mp\gametypes\_missions::processChallengeDaily(26, undefined, undefined);
  winner maps\mp\gametypes\_missions::processChallengeDaily(27, undefined, undefined);
  winner maps\mp\gametypes\_missions::processChallengeDaily(28, undefined, undefined);
  winner maps\mp\gametypes\_missions::processChallengeDaily(29, undefined, undefined);
  winner maps\mp\gametypes\_missions::processChallengeDaily(30, undefined, undefined);

  if(level.players.size > 5) {
    superStarChallenge(winner);

    switch (level.gametype) {
      case "war":
        if(game["teamScores"][winner.team] >= (game["teamScores"][getOtherTeam(winner.team)] + 20)) {
          winner maps\mp\gametypes\_missions::processChallenge("ch_war_crushing");
        }
        break;
      case "hp":
        if(game["teamScores"][winner.team] >= (game["teamScores"][getOtherTeam(winner.team)] + 70)) {
          winner maps\mp\gametypes\_missions::processChallenge("ch_hp_crushing");
        }
        break;
      case "conf":
        if(game["teamScores"][winner.team] >= (game["teamScores"][getOtherTeam(winner.team)] + 15)) {
          winner maps\mp\gametypes\_missions::processChallenge("ch_conf_crushing");
        }
        break;
      case "ball":
        if(game["teamScores"][winner.team] >= (game["teamScores"][getOtherTeam(winner.team)] + 7)) {
          winner maps\mp\gametypes\_missions::processChallenge("ch_ball_crushing");
        }
        break;
      case "infect":
        if(winner.team == "allies") {
          if(game["teamScores"][winner.team] >= 4) {
            winner maps\mp\gametypes\_missions::processChallenge("ch_infect_crushing");
          }

          if(game["teamScores"][getOtherTeam(winner.team)] == 1) {
            winner maps\mp\gametypes\_missions::processChallenge("ch_infect_cleanup");
          }
        }
        break;
      case "dm":
        if(isDefined(level.placement["all"][0])) {
          match_winner = level.placement["all"][0];
          smallest_score_offset = 9999;
          if(winner == match_winner) {
            foreach(contestent in level.players) {
              if(winner == contestent) {
                continue;
              }

              score_offset = (winner.score - contestent.score);
              if(score_offset < smallest_score_offset) {
                smallest_score_offset = score_offset;
              }
            }

            if(smallest_score_offset >= 7) {
              winner maps\mp\gametypes\_missions::processChallenge("ch_dm_crushing");
            }
          }
        }
        break;
      case "gun":
        foreach(player in level.players) {
          if(winner == player) {
            continue;
          }

          if(winner.score < (player.score + 5)) {
            break;
          }
        }
        winner maps\mp\gametypes\_missions::processChallenge("ch_gun_crushing");
        break;
      case "ctf":
      case "twar":
        if(game["shut_out"][winner.team]) {
          winner maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_crushing");
        }
        break;
    }
  }
}

superStarChallenge(winner) {
  most_kills = 0;
  least_deaths = 9999;

  foreach(player in level.players) {
    if(player.kills > most_kills) {
      most_kills = player.kills;
    }

    if(player.deaths < least_deaths) {
      least_deaths = player.deaths;
    }
  }

  if(winner.kills >= most_kills && winner.deaths <= least_deaths && winner.kills > 0 && !IsAI(winner)) {
    winner maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_star");
  }
}

checkGameEndChallenges() {
  if(level.gameType == "dom") {
    foreach(domFlag in level.domFlags) {
      if(!isDefined(domFlag.ownedTheEntireRound) || !domFlag.ownedTheEntireRound) {
        continue;
      }

      ownerTeam = domFlag maps\mp\gametypes\_gameobjects::getOwnerTeam();

      foreach(player in level.players) {
        if(player.team != ownerTeam) {
          continue;
        }

        switch (domFlag.label) {
          case "_a":
            player maps\mp\gametypes\_missions::processChallenge("ch_dom_alphalock");
            break;
          case "_b":
            player maps\mp\gametypes\_missions::processChallenge("ch_dom_bravolock");
            break;
          case "_c":
            player maps\mp\gametypes\_missions::processChallenge("ch_dom_charlielock");
            break;
        }
      }
    }
  }
}

updateLossStats(loser) {
  if(!loser rankingEnabled()) {
    return;
  }

  if(!isDefined(loser.hasDoneAnyCombat) || !loser.hasDoneAnyCombat) {
    return;
  }

  loser.pers["hasMatchLoss"] = true;

  loser maps\mp\gametypes\_persistence::statAdd("losses", 1);
  loser updatePersRatio("winLossRatio", "wins", "losses");
  loser maps\mp\gametypes\_persistence::statAdd("gamesPlayed", 1);
  loser maps\mp\gametypes\_persistence::statSetChild("round", "loss", true);
}

updateTieStats(loser) {
  if(!loser rankingEnabled()) {
    return;
  }

  if(!isDefined(loser.hasDoneAnyCombat) || !loser.hasDoneAnyCombat) {
    return;
  }

  loser maps\mp\gametypes\_persistence::statAdd("losses", -1);

  loser maps\mp\gametypes\_persistence::statAdd("ties", 1);
  loser updatePersRatio("winLossRatio", "wins", "losses");
  loser maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
  loser.combatRecordTie = true;
}

updateWinLossStats(winner) {
  if(privateMatch()) {
    return;
  }

  if(practiceRoundGame()) {
    return;
  }

  if(!isDefined(winner) || (isDefined(winner) && isString(winner) && winner == "tie")) {
    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }

      if(level.hostForcedEnd && player isHost()) {
        player maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
        continue;
      }

      updateTieStats(player);
    }
  } else if(isPlayer(winner)) {
    highestScoringPlayers[0] = winner;

    if(level.players.size > 5) {
      highestScoringPlayers = maps\mp\gametypes\_gamescore::getHighestScoringPlayersArray(3);
    }

    foreach(player in highestScoringPlayers) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }

      if(level.hostForcedEnd && player isHost()) {
        player maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
        continue;
      }

      updateWinStats(player);
    }
  } else if(isString(winner)) {
    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }

      if(level.hostForcedEnd && player isHost()) {
        player maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
        continue;
      }

      if(winner == "tie") {
        updateTieStats(player);
      } else if(player.pers["team"] == winner) {
        updateWinStats(player);
      } else {
        player maps\mp\gametypes\_persistence::statSet("currentWinStreak", 0);
      }
    }
  }

  if(level.players.size > 5) {
    highestScoringPlayers = maps\mp\gametypes\_gamescore::getHighestScoringPlayersArray(3);

    for(i = 0; i < highestScoringPlayers.size; i++) {
      if(i == 0) {
        highestScoringPlayers[i] maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_mvp");
      }

      highestScoringPlayers[i] maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_superior");
    }
  }
}

freezePlayerForRoundEnd(delay) {
  self endon("disconnect");
  self clearLowerMessages();

  if(!isDefined(delay)) {
    delay = 0.05;
  }

  self closepopupMenu();
  self closeInGameMenu();

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

  if(practiceRoundGame()) {
    return;
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
      setWinningTeam(winningTeam);
    }

    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }

      if(!player rankingEnabled()) {
        continue;
      }

      if((player.timePlayed["total"] < 1) || (player.pers["participation"] < 1)) {
        continue;
      }

      if(level.hostForcedEnd && player isHost()) {
        continue;
      }

      if(!isDefined(player.hasDoneAnyCombat) || !player.hasDoneAnyCombat) {
        continue;
      }

      playerScore = 0;

      if(winningTeam == "tie") {
        playerScore = maps\mp\gametypes\_rank::getScoreInfoValue("tie");;
        player.didTie = true;
        player.isWinner = false;
      } else if(isDefined(player.pers["team"]) && (player.pers["team"] == winningTeam)) {
        playerScore = maps\mp\gametypes\_rank::getScoreInfoValue("win");
        player.isWinner = true;
      } else if(isDefined(player.pers["team"]) && (player.pers["team"] == losingTeam)) {
        playerScore = maps\mp\gametypes\_rank::getScoreInfoValue("loss");
        player.isWinner = false;
      }

      player.matchBonus = int(playerScore);
    }
  } else {
    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame)) {
        continue;
      }

      if(!player rankingEnabled()) {
        continue;
      }

      if((player.timePlayed["total"] < 1) || (player.pers["participation"] < 1)) {
        continue;
      }

      if(level.hostForcedEnd && player isHost()) {
        continue;
      }

      if(!isDefined(player.hasDoneAnyCombat) || !player.hasDoneAnyCombat) {
        continue;
      }

      assert(!isDefined(player.isWinner));
      player.isWinner = false;

      for(pIdx = 0; pIdx < min(level.placement["all"].size, 3); pIdx++) {
        if(level.placement["all"][pIdx] != player) {
          continue;
        }

        player.isWinner = true;
      }

      playerScore = 0;

      if(player.isWinner) {
        playerScore = maps\mp\gametypes\_rank::getScoreInfoValue("win");
      } else {
        playerScore = maps\mp\gametypes\_rank::getScoreInfoValue("loss");
      }

      player.matchBonus = int(playerScore);
    }
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.isWinner)) {
      continue;
    }

    matchBonusType = "loss";

    if(player.isWinner) {
      matchBonusType = "win";
    }

    if(isDefined(player.didTie) && player.didTie) {
      matchBonusType = "tie";
    }

    player thread giveMatchBonus(matchBonusType, player.matchBonus);
  }
}

giveMatchBonus(scoreType, score) {
  self endon("disconnect");

  level waittill("give_match_bonus");

  self maps\mp\gametypes\_rank::giveRankXP(scoreType, score);

  self logXPGains();
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
    } else {
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

  if(getHalfTime() && game["status"] != "halftime") {
    setGameEndTime(getTime() + (int(timeLeft) - int(getTimeLimit() * 60 * 1000 * 0.5)));
  } else {
    setGameEndTime(getTime() + int(timeLeft));
  }

  if(timeLeft > 0) {
    if(getHalfTime() && checkHalfTime(prevTimePassed)) {
      [[level.onHalfTime]]("time_limit_reached");
    }

    return;
  }

  [[level.onTimeLimit]]();
}

checkHalfTimeScore() {
  if(!level.halfTimeOnScoreLimit) {
    return false;
  }

  if(!level.teamBased) {
    return false;
  }

  if(game["status"] != "normal") {
    return false;
  }

  scorelimit = getWatchedDvar("scorelimit");
  if(scorelimit) {
    if(game["teamScores"]["allies"] >= scorelimit || game["teamScores"]["axis"] >= scorelimit) {
      return false;
    }

    halfScore = int((scorelimit / 2) + 0.5);

    if(game["teamScores"]["allies"] >= halfScore || game["teamScores"]["axis"] >= halfScore) {
      game["roundMillisecondsAlreadyPassed"] = getTimePassed();
      game["round_time_to_beat"] = getMinutesPassed();
      return true;
    }
  }

  return false;
}

checkHalfTime(prevTimePassed) {
  if(!level.teamBased) {
    return false;
  }

  if(game["status"] != "normal") {
    return false;
  }

  if(getTimeLimit()) {
    halfTime = (getTimeLimit() * 60 * 1000) * 0.5;

    if(getTimePassed() >= halfTime && prevTimePassed < halfTime && prevTimePassed > 0) {
      game["roundMillisecondsAlreadyPassed"] = getTimePassed();
      return true;
    }
  }

  return false;
}

getTimeRemaining() {
  timePassed = getTimePassed();
  timeLimit = getTimeLimit() * 60 * 1000;

  if(getHalfTime() && (game["status"] == "halftime") && isDefined(level.firstHalfTimePassed)) {
    halfTimeLimit = timeLimit * 0.5;

    if(level.firstHalfTimePassed < halfTimeLimit) {
      if(level.halfTimeOnScoreLimit) {
        timePassed = (timeLimit - level.firstHalfTimePassed) + (timePassed - level.firstHalfTimePassed);
      } else {
        timePassed = timePassed + (halfTimeLimit - level.firstHalfTimePassed);
      }
    }
  }

  return timeLimit - timePassed;
}

checkTeamScoreLimitSoon(team) {
  assert(isDefined(team));

  if(getWatchedDvar("scorelimit") <= 0 || isObjectiveBased()) {
    return;
  }

  if(isDefined(level.scoreLimitOverride) && level.scoreLimitOverride) {
    return;
  }

  if(level.gameType == "conf") {
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

  if(getHalfTime() && checkHalfTimeScore()) {
    return [[level.onHalfTime]]("score_limit_reached");
  } else if(level.multiTeamBased) {
    limitReached = false;

    for(i = 0; i < level.teamNameList.size; i++) {
      if(game["teamScores"][level.teamNameList[i]] >= getWatchedDvar("scorelimit")) {
        limitReached = true;
      }
    }

    if(!limitReached) {
      return false;
    }
  } else if(level.teamBased) {
    if(game["teamScores"]["allies"] < getWatchedDvar("scorelimit") && game["teamScores"]["axis"] < getWatchedDvar("scorelimit")) {
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
  SetOmnvar("ui_match_countdown_title", 6);
  SetOmnvar("ui_match_countdown_toggle", 0);

  if(level.currentgen) {
    SetOmnvar("ui_cg_world_blur", 1);
  }

  waitForPlayers(level.prematchPeriod);

  if(level.prematchPeriodEnd > 0 && !isDefined(level.hostMigrationTimer)) {
    matchStartTimer(level.prematchPeriodEnd);
  }
}

matchStartTimer_Internal(countTime) {
  waittillframeend;

  level endon("match_start_timer_beginning");

  SetOmnvar("ui_match_countdown_title", 1);
  SetOmnvar("ui_match_countdown_toggle", 1);

  while((countTime > 0) && !level.gameEnded) {
    SetOmnvar("ui_match_countdown", countTime);
    countTime--;

    if(level.currentgen) {
      SetOmnvar("ui_cg_world_blur", 1);
    }

    wait(1);
  }

  if(level.currentgen) {
    SetOmnvar("ui_cg_world_blur_fade_out", 1);
  }

  if((level.xpScale > 1) && !(isDefined(level.isHorde) && level.isHorde) && !privateMatch() && !practiceRoundGame()) {
    foreach(player in level.players) {
      player thread maps\mp\gametypes\_hud_message::SplashNotify("double_xp");
    }
  }

  SetOmnvar("ui_match_countdown_toggle", 0);
  SetOmnvar("ui_match_countdown", 0);

  SetOmnvar("ui_match_countdown_title", 2);

  level endon("match_forfeit_timer_beginning");
  wait(1.5);
  SetOmnvar("ui_match_countdown_title", 0);
}

matchStartTimer(duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");

  level notify("match_start_timer_beginning");

  countTime = int(duration);

  if(countTime >= 2) {
    matchStartTimer_Internal(countTime);
    visionSetNaked("", 3.0);
  } else {
    if(level.currentgen) {
      SetOmnvar("ui_cg_world_blur_fade_out", 1);
    }

    if((level.xpScale > 1) && !(isDefined(level.isHorde) && level.isHorde) && !privateMatch() && !practiceRoundGame()) {
      foreach(player in level.players) {
        player thread maps\mp\gametypes\_hud_message::SplashNotify("double_xp");
      }
    }
    visionSetNaked("", 1.0);
  }
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
    }
    level.halftimeType = "overtime";
    game["dynamicEvent_Overtime"] = true;
  } else {
    level.halftimeType = "halftime";
    game["switchedsides"] = !game["switchedsides"];
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
  foreach(player in level.players) {
    player maps\mp\gametypes\_damage::streamFinalKillcam();
  }

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

    players = level.players;
    foreach(player in players) {
      player SetClientOmnvar("ui_round_end", 0);
    }
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

  players = level.players;
  foreach(player in players) {
    player SetClientOmnvar("ui_round_end", 0);
  }
  level notify("round_end_finished");
}

roundEndDOF(time) {
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}

Callback_StartGameType() {
  maps\mp\_load::main();

  levelFlagInit("round_over", false);
  levelFlagInit("game_over", false);
  levelFlagInit("block_notifies", false);

  level.prematchPeriod = 0;
  level.prematchPeriodEnd = 0;
  level.postGameNotifies = 0;

  level.intermission = false;

  SetDvar("bg_compassShowEnemies", getDvar("scr_game_forceuav"));

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;

    alliesCharSet = getMapCustom("allieschar");
    if((!isDefined(alliesCharSet) || alliesCharSet == "")) {
      if(!isDefined(game["allies"])) {
        alliesCharSet = "sentinel";
      } else {
        alliesCharSet = game["allies"];
      }
    }

    axisCharSet = getMapCustom("axischar");
    if((!isDefined(axisCharSet) || axisCharSet == "")) {
      if(!isDefined(game["axis"])) {
        axisCharSet = "atlas";
      } else {
        axisCharSet = game["axis"];
      }
    }

    if(level.multiTeamBased) {
      multiTeamDefaultCharacterSet = getMapCustom("allieschar");
      if((!isDefined(multiTeamDefaultCharacterSet) || multiTeamDefaultCharacterSet == "")) {
        multiTeamDefaultCharacterSet = "delta_multicam";
      }

      for(i = 0; i < level.teamNameList.size; i++) {
        game[level.teamNameList[i]] = multiTeamDefaultCharacterSet;
      }
    }

    game["allies"] = alliesCharSet;
    game["axis"] = axisCharSet;

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

    if(level.teamBased) {
      game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_TEAMS";
      game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
    } else {
      game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_MORE_PLAYERS";
      game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
    }

    game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
    game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
    game["strings"]["match_resuming_in"] = &"MP_MATCH_RESUMING_IN";
    game["strings"]["waiting_for_players"] = &"MP_WAITING_FOR_PLAYERS";
    game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
    game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
    game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";

    game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
    game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["change_class_cancel"] = &"MP_CHANGE_CLASS_CANCEL";
    game["strings"]["change_class_wait"] = &"MP_CHANGE_CLASS_WAIT";
    game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
    game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
    game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";

    game["colors"]["blue"] = (0.25, 0.25, 0.75);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["white"] = (1.0, 1.0, 1.0);
    game["colors"]["black"] = (0.0, 0.0, 0.0);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0.0);
    game["colors"]["orange"] = (1.0, 0.45, 0.0);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);

    game["strings"]["allies_name"] = maps\mp\gametypes\_teams::getTeamName("allies");
    game["icons"]["allies"] = maps\mp\gametypes\_teams::getTeamIcon("allies");
    game["colors"]["allies"] = maps\mp\gametypes\_teams::getTeamColor("allies");

    game["strings"]["axis_name"] = maps\mp\gametypes\_teams::getTeamName("axis");
    game["icons"]["axis"] = maps\mp\gametypes\_teams::getTeamIcon("axis");
    game["colors"]["axis"] = maps\mp\gametypes\_teams::getTeamColor("axis");

    if(game["colors"]["allies"] == (0, 0, 0)) {
      game["colors"]["allies"] = (0.5, 0.5, 0.5);
    }

    if(game["colors"]["axis"] == (0, 0, 0)) {
      game["colors"]["axis"] = (0.5, 0.5, 0.5);
    }

    [[level.onPrecacheGameType]]();

    SetDvarIfUninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        if(IsDedicatedServer()) {
          level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "graceperiod_ds");
        } else {
          level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "graceperiod");
        }

        level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "matchstarttime");
      }
    } else {
      if(IsDedicatedServer()) {
        level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "playerwaittime_ds");
      } else {
        level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue("game", "playerwaittime");
      }

      level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "matchstarttime");
    }
  } else {
    SetDvarIfUninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        level.prematchPeriod = 5;
        level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "roundstarttime");
      }
    } else {
      level.prematchPeriod = 5;
      level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue("game", "roundstarttime");
    }
  }

  if(!isDefined(game["status"])) {
    game["status"] = "normal";
  }

  if(game["status"] != "overtime" && game["status"] != "halftime" && game["status"] != "overtime_halftime") {
    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;

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
  SetOmnvar("ui_current_round", game["roundsPlayed"] + 1);

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

  level.hardcoreMode = getDvarInt("g_hardcore");
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

  if(!isDefined(level.isZombieGame)) {
    level.isZombieGame = false;
  }

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

  level.basePlayerMoveScale = 1;

  level.maxAllowedTeamKills = 2;

  thread maps\mp\_teleport::main();
  thread maps\mp\gametypes\_persistence::init();
  thread maps\mp\gametypes\_menus::init();
  thread maps\mp\gametypes\_hud::init();
  thread maps\mp\gametypes\_serversettings::init();
  thread maps\mp\gametypes\_teams::init();
  thread maps\mp\gametypes\_weapons::init();
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
  thread maps\mp\gametypes\_music_and_dialog::init();
  thread maps\mp\gametypes\_high_jump_mp::init();
  thread maps\mp\_grappling_hook::init();
  thread maps\mp\_matchdata::init();
  thread maps\mp\_awards::init();
  thread maps\mp\_areas::init();
  if(!InVirtualLobby()) {
    thread maps\mp\killstreaks\_killstreaks_init::init();
  }
  thread maps\mp\perks\_perks::init();
  thread maps\mp\_events::init();
  thread maps\mp\gametypes\_damage::initFinalKillCam();
  thread maps\mp\_threatdetection::init();
  thread maps\mp\_exo_suit::init();
  thread maps\mp\_reinforcements::init();
  thread maps\mp\_snd_common_mp::init();

  thread buildAttachmentMaps();

  if(level.teamBased) {
    thread maps\mp\gametypes\_friendicons::init();
  }

  thread maps\mp\gametypes\_hud_message::init();

  thread maps\mp\gametypes\_divisions::init();

  foreach(locString in game["strings"]) {
    precacheString(locString);
  }

  foreach(icon in game["icons"]) {
    precacheShader(icon);
  }

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
  } else {
    setdvar("g_deadChat", 1);
  }

  waveDelay = getDvarFloat("scr_" + level.gameType + "_waverespawndelay");
  if(waveDelay > 0) {
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

  /$
  thread maps\mp\gametypes\_dev::init();
  $ /

    if((!level.console) && ((getDvar("dedicated") == "dedicated LAN server") || (getDvar("dedicated") == "dedicated internet server"))) {
      thread verifyDedicatedConfiguration();
    }

  SetAttackingTeam();

  thread startGame();

  level thread updateWatchedDvars();
  level thread timeLimitThread();
  level thread maps\mp\gametypes\_damage::doFinalKillcam();
}

SetAttackingTeam() {
  if(game["attackers"] == "axis") {
    team = 1;
  } else if(game["attackers"] == "allies") {
    team = 2;
  } else {
    team = 0;
  }

  SetOmnvar("ui_attacking_team", team);
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

      halfTimeLimit = int(getTimeLimit() * 60 * 0.5);

      if(getHalfTime() && timeLeftInt > halfTimeLimit) {
        timeLeftInt -= halfTimeLimit;
      }

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
  level.matchDurationStartTime = getTime();

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.startTime -= game["roundMillisecondsAlreadyPassed"];
    level.firstHalfTimePassed = game["roundMillisecondsAlreadyPassed"];
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

  SetDvar("ui_inprematch", 1);
  prematchPeriod();
  gameFlagSet("prematch_done");
  level notify("prematch_over");
  SetDvar("ui_inprematch", 0);

  level.prematch_done_time = GetTime();

  UpdateTimerPausedness();

  thread timeLimitClock();
  thread gracePeriod();

  thread maps\mp\gametypes\_missions::roundBegin();

  thread maps\mp\_matchdata::matchStarted();

  if(isDefined(level.isHorde) && level.isHorde) {
    thread updateGameDuration();
  }

  lootServiceOnStartGame();
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
  score["allies"] = 0;
  score["axis"] = 0;
  kills["allies"] = 0;
  kills["axis"] = 0;
  deaths["allies"] = 0;
  deaths["axis"] = 0;

  foreach(player in level.players) {
    team = player.pers["team"];
    if(isDefined(team) && (team == "allies" || team == "axis")) {
      score[team] += player.score;
      kills[team] += player.kills;
      deaths[team] += player.deaths;
    }
  }

  if(score["allies"] > score["axis"]) {
    return "allies";
  } else if(score["axis"] > score["allies"]) {
    return "axis";
  }

  if(kills["allies"] > kills["axis"]) {
    return "allies";
  } else if(kills["axis"] > kills["allies"]) {
    return "axis";
  }

  if(deaths["allies"] < deaths["axis"]) {
    return "allies";
  } else if(deaths["axis"] < deaths["allies"]) {
    return "axis";
  }

  if(randomint(2) == 0) {
    return "allies";
  }
  return "axis";
}

rankedMatchUpdates(winner) {
  if(!wasLastRound()) {
    return;
  }

  winner = getGameWinner(winner, false);

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
  if(!practiceRoundGame()) {
    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
        continue;
      }

      if(level.teamBased) {
        player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, true, endReasonText);
      } else {
        player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
      }
    }
  }

  if(!wasLastRound()) {
    level notify("round_win", winner);
  }

  if(wasLastRound()) {
    roundEndWait(level.roundEndDelay, false);
  } else {
    roundEndWait(level.roundEndDelay, true);
  }
}

displayGameEnd(winner, endReasonText) {
  if(!practiceRoundGame()) {
    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
        continue;
      }

      if(level.teamBased) {
        player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, false, endReasonText, true);
      } else {
        player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
      }
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
      } else {
        switchType = "intermission";
      }
    } else if(getWatchedDvar("winlimit")) {
      if(game["roundsPlayed"] == (getWatchedDvar("winlimit") - 1)) {
        switchType = "halftime";
      } else {
        switchType = "intermission";
      }
    } else {
      switchType = "intermission";
    }
  }

  level notify("round_switch", switchType);

  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }

    player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(switchType, true, game["end_reason"]["switching_sides"]);
  }

  roundEndWait(level.halftimeRoundEndDelay, false);
}

freezeAllPlayers(delay, resetFov) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  foreach(player in level.players) {
    player DisableAmmoGeneration();
    player thread freezePlayerForRoundEnd(delay);
    player thread roundEndDoF(4.0);

    player freeGameplayHudElems();

    if(isDefined(resetFov) && resetFov) {
      player setClientDvars("cg_everyoneHearsEveryone", 1, "cg_fovScale", 1);
      player SetClientOmnvar("fov_scale", 1);
    } else {
      player setClientDvars("cg_everyoneHearsEveryone", 1);
    }
  }

  if(isDefined(level.agentArray)) {
    foreach(agent in level.agentArray) {
      agent freezeControlsWrapper(true);
    }
  }
}

endGameOvertime(winner, endReasonText) {
  SetDvar("bg_compassShowEnemies", 0);

  freezeAllPlayers(1.0, true);

  foreach(player in level.players) {
    player.pers["stats"] = player.stats;
    player.pers["segments"] = player.segments;
  }

  level notify("round_switch", "overtime");

  isRoundBased = false;
  showSecondMessage = (winner == "overtime");

  if(level.gameType == "ctf") {
    winner = "tie";
    isRoundBased = true;

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      winner = "allies";
    }
  }

  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }

    if(level.teamBased) {
      player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, isRoundBased, endReasonText);
    } else {
      player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
    }
  }

  roundEndWait(level.roundEndDelay, false);

  if(level.gameType == "ctf") {
    winner = "overtime_halftime";
  }

  if(isDefined(level.finalKillCam_winner) && showSecondMessage) {
    level.finalKillCam_timeGameEnded[level.finalKillCam_winner] = getSecondsPassed();

    foreach(player in level.players) {
      player notify("reset_outcome");
    }

    level notify("game_cleanup");

    waittillFinalKillcamDone();

    if(level.gameType == "ctf") {
      winner = "overtime";
      endReasonText = game["end_reason"]["tie"];
    }

    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
        continue;
      }

      if(level.teamBased) {
        player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, false, endReasonText);
      } else {
        player thread maps\mp\gametypes\_hud_message::outcomeNotify(winner, endReasonText);
      }
    }

    roundEndWait(level.halftimeRoundEndDelay, false);
  }

  game["status"] = winner;
  level notify("restarting");
  game["state"] = "playing";
  SetDvar("ui_game_state", game["state"]);
  map_restart(true);
}

endGameHalfTime(endReasonText) {
  SetDvar("bg_compassShowEnemies", 0);

  winner = "halftime";

  shouldSwitchSides = true;
  if(isDefined(level.halftime_switch_sides) && !level.halftime_switch_sides) {
    shouldSwitchSides = false;
  }

  if(shouldSwitchSides) {
    game["switchedsides"] = !game["switchedsides"];
    endReason = game["end_reason"]["switching_sides"];
  } else {
    endReason = endReasonText;
  }

  freezeAllPlayers(1.0, true);

  if(level.gameType == "ctf") {
    endReason = endReasonText;
    winner = "tie";

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      winner = "axis";
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      winner = "allies";
    }
  }

  foreach(player in level.players) {
    player.pers["stats"] = player.stats;
    player.pers["segments"] = player.segments;
  }

  level notify("round_switch", "halftime");

  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
      continue;
    }

    player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify(winner, true, endReason);
  }

  roundEndWait(level.roundEndDelay, false);

  if(isDefined(level.finalKillCam_winner)) {
    level.finalKillCam_timeGameEnded[level.finalKillCam_winner] = getSecondsPassed();

    foreach(player in level.players) {
      player notify("reset_outcome");
    }

    level notify("game_cleanup");

    waittillFinalKillcamDone();

    endReasonFinal = game["end_reason"]["switching_sides"];
    if(!shouldSwitchSides) {
      endReasonFinal = endReason;
    }

    foreach(player in level.players) {
      if(isDefined(player.connectedPostGame) || (player.pers["team"] == "spectator" && !player IsMLGSpectator())) {
        continue;
      }

      player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify("halftime", true, endReasonFinal);
    }

    roundEndWait(level.halftimeRoundEndDelay, false);
  }

  game["status"] = "halftime";
  level notify("restarting");
  game["state"] = "playing";
  SetDvar("ui_game_state", game["state"]);
  map_restart(true);
}

updateGameDuration() {
  level endon("game_ended");

  while(true) {
    gameLengthSeconds = getGameDuration();

    SetOmnvar("ui_game_duration", gameLengthSeconds * 1000);

    wait 1.0;
  }
}

getGameDuration() {
  gameLengthSeconds = getGameTimePassedSeconds();

  if(isDefined(level.isHorde) && level.isHorde) {
    gameLengthSeconds = gameDurationClamp(gameLengthSeconds);
  }

  return gameLengthSeconds;
}

gameDurationClamp(seconds) {
  if(seconds > 86399) {
    return 86399;
  }

  return seconds;
}

endGame(winner, endReasonText, nukeDetonated) {
  if(!isDefined(nukeDetonated)) {
    nukeDetonated = false;
  }

  if(game["state"] == "postgame" || level.gameEnded) {
    return;
  }

  game["state"] = "postgame";
  SetDvar("ui_game_state", "postgame");

  level.gameEndTime = getTime();
  level.gameEnded = true;
  level.inGracePeriod = false;
  level notify("game_ended", winner);
  levelFlagSet("game_over");
  levelFlagSet("block_notifies");

  gameLengthSeconds = getGameDuration();

  SetOmnvar("ui_game_duration", gameLengthSeconds * 1000);

  waitframe();

  setGameEndTime(0);

  setMatchData("gameLengthSeconds", gameLengthSeconds);
  setMatchData("endTimeUTC", getSystemTime());

  checkGameEndChallenges();

  if(isDefined(winner) && isString(winner) && isOvertimeText(winner)) {
    level.finalKillCam_winner = "none";
    endGameOvertime(winner, endReasonText);
    return;
  }

  if(isDefined(winner) && isString(winner) && (winner == "halftime")) {
    level.finalKillCam_winner = "none";
    endGameHalfTime(endReasonText);
    return;
  }

  if(isDefined(level.finalKillCam_winner)) {
    level.finalKillCam_timeGameEnded[level.finalKillCam_winner] = getSecondsPassed();
  }

  game["roundsPlayed"]++;
  SetOmnvar("ui_current_round", game["roundsPlayed"]);

  if(level.teamBased) {
    if((winner == "axis" || winner == "allies") && (level.gameType != "ctf")) {
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
      player maps\mp\killstreaks\_killstreaks::clearKillstreaks(true);
    }
  }

  setDvar("g_deadChat", 1);
  setDvar("ui_allow_teamchange", 0);
  SetDvar("bg_compassShowEnemies", 0);

  freezeAllPlayers(1.0, true);

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
        player.pers["segments"] = player.segments;
      }

      level notify("restarting");
      game["state"] = "playing";
      SetDvar("ui_game_state", "playing");
      map_restart(true);
      return;
    }

    if(!level.forcedEnd) {
      endReasonText = updateEndReasonText(winner);
    }
  }

  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp/clientmatchdata.def";
    setClientMatchDataDef(game["clientMatchDataDef"]);
  }

  maps\mp\gametypes\_missions::roundEnd(winner);

  winner = getGameWinner(winner, true);

  if(level.teamBased) {
    SetOmnvar("ui_game_victor", 0);
    if(winner == "allies") {
      SetOmnvar("ui_game_victor", 2);
    } else if(winner == "axis") {
      SetOmnvar("ui_game_victor", 1);
    }
  }

  displayGameEnd(winner, endReasonText);

  gameTime = getTime();

  if(isDefined(level.finalKillCam_winner) && wasOnlyRound()) {
    foreach(player in level.players) {
      player notify("reset_outcome");
    }

    level notify("game_cleanup");

    waittillFinalKillcamDone();
  }

  levelFlagClear("block_notifies");

  level.intermission = true;

  level notify("spawning_intermission");

  foreach(player in level.players) {
    player closepopupMenu();
    player closeInGameMenu();
    player notify("reset_outcome");
    player thread maps\mp\gametypes\_playerlogic::spawnIntermission();
  }

  processLobbyData();

  wait(1.0);

  checkForPersonalBests();

  updateCombatRecord();

  if(level.teamBased) {
    if(winner == "axis" || winner == "allies") {
      setMatchData("victor", winner);
    } else {
      setMatchData("victor", "none");
    }

    setMatchData("alliesScore", game["teamScores"]["allies"]);
    setMatchData("axisScore", game["teamScores"]["axis"]);

    tournamentreportwinningteam(winner);
  } else {
    setMatchData("victor", "none");
  }

  level maps\mp\_matchdata::endOfGameSummaryLogger();

  foreach(player in level.players) {
    if(player rankingEnabled()) {
      player maps\mp\_matchdata::logFinalStats();
    }
    player maps\mp\gametypes\_playerlogic::logPlayerStats();
  }

  setMatchData("host", maps\mp\gametypes\_playerlogic::truncatePlayername(level.hostname));

  if(MatchMakingGame()) {
    setMatchData("playlistVersion", getPlaylistVersion());
    setMatchData("playlistID", getPlaylistID());
    setMatchData("isDedicated", isDedicatedServer());
  }

  setMatchData("levelMaxClients", level.maxclients);

  sendMatchData();

  foreach(player in level.players) {
    player.pers["stats"] = player.stats;
    player.pers["segments"] = player.segments;
  }

  tournamentreportendofgame();

  roundEndExtraTime = 0;
  if(practiceRoundGame()) {
    roundEndExtraTime = 5.0;
  }
  if(!nukeDetonated && !level.postGameNotifies) {
    if(!wasOnlyRound()) {
      wait 6.0 + roundEndExtraTime;
    } else {
      wait(min(10.0, 4.0 + roundEndExtraTime + level.postGameNotifies));
    }
  } else {
    wait(min(10.0, 4.0 + roundEndExtraTime + level.postGameNotifies));
  }

  script_file = "_gamelogic.gsc";
  match_winner = "all";

  if(level.teamBased && isDefined(winner)) {
    match_winner = winner;
  }

  win_reason = "undefined";
  if(isDefined(endReasonText)) {
    switch (endReasonText) {
      case 1:
        win_reason = "MP_SCORE_LIMIT_REACHED";
        break;
      case 2:
        win_reason = "MP_TIME_LIMIT_REACHED";
        break;
      case 3:
        win_reason = "MP_PLAYERS_FORFEITED";
        break;
      case 4:
        win_reason = "MP_TARGET_DESTROYED";
        break;
      case 5:
        win_reason = "MP_BOMB_DEFUSED";
        break;
      case 6:
        win_reason = "MP_GHOSTS_ELIMINATED";
        break;
      case 7:
        win_reason = "MP_FEDERATION_ELIMINATED";
        break;
      case 8:
        win_reason = "MP_GHOSTS_FORFEITED";
        break;
      case 9:
        win_reason = "MP_FEDERATION_FORFEITED";
        break;
      case 10:
        win_reason = "MP_ENEMIES_ELIMINATED";
        break;
      case 11:
        win_reason = "MP_MATCH_TIE";
        break;
      case 12:
        win_reason = "GAME_OBJECTIVECOMPLETED";
        break;
      case 13:
        win_reason = "GAME_OBJECTIVEFAILED";
        break;
      case 14:
        win_reason = "MP_SWITCHING_SIDES";
        break;
      case 15:
        win_reason = "MP_ROUND_LIMIT_REACHED";
        break;
      case 16:
        win_reason = "MP_ENDED_GAME";
        break;
      case 17:
        win_reason = "MP_HOST_ENDED_GAME";
        break;
      default:
        break;
    }
  }

  if(!isDefined(gameTime)) {
    gameTime = -1;
  }

  CONST_match_logging_version = 13;
  version = CONST_match_logging_version;

  joinCount = getMatchData("playerCount");
  spawnCount = getMatchData("lifeCount");

  if(!isDefined(level.matchData)) {
    botJoinCount = 0;
    deathCount = 0;
    badSpawnDiedTooFastCount = 0;
    badSpawnKilledTooFastCount = 0;
    badSpawnDmgDealtCount = 0;
    badSpawnDmgReceivedCount = 0;
    badSpawnByAnyMeansCount = 0;
  } else {
    if(isDefined(level.matchData["botJoinCount"])) {
      botJoinCount = level.matchData["botJoinCount"];
    } else {
      botJoinCount = 0;
    }

    if(isDefined(level.matchData["deathCount"])) {
      deathCount = level.matchData["deathCount"];
    } else {
      deathCount = 0;
    }

    if(isDefined(level.matchData["badSpawnDiedTooFastCount"])) {
      badSpawnDiedTooFastCount = level.matchData["badSpawnDiedTooFastCount"];
    } else {
      badSpawnDiedTooFastCount = 0;
    }

    if(isDefined(level.matchData["badSpawnKilledTooFastCount"])) {
      badSpawnKilledTooFastCount = level.matchData["badSpawnKilledTooFastCount"];
    } else {
      badSpawnKilledTooFastCount = 0;
    }

    if(isDefined(level.matchData["badSpawnDmgDealtCount"])) {
      badSpawnDmgDealtCount = level.matchData["badSpawnDmgDealtCount"];
    } else {
      badSpawnDmgDealtCount = 0;
    }

    if(isDefined(level.matchData["badSpawnDmgReceivedCount"])) {
      badSpawnDmgReceivedCount = level.matchData["badSpawnDmgReceivedCount"];
    } else {
      badSpawnDmgReceivedCount = 0;
    }

    if(isDefined(level.matchData["badSpawnByAnyMeansCount"])) {
      badSpawnByAnyMeansCount = level.matchData["badSpawnByAnyMeansCount"];
    } else {
      badSpawnByAnyMeansCount = 0;
    }
  }

  ReconEvent("script_mp_match_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, badSpawnDiedTooFastCount %d, badSpawnKilledTooFastCount %d, badSpawnDmgDealtCount %d, badSpawnDmgReceivedCount %d, badSpawnByAnyMeansCount %d", script_file, gameTime, match_winner, win_reason, version, joinCount, botJoinCount, spawnCount, deathCount, badSpawnDiedTooFastCount, badSpawnKilledTooFastCount, badSpawnDmgDealtCount, badSpawnDmgReceivedCount, badSpawnByAnyMeansCount);

  if(isDefined(level.isHorde) && level.isHorde) {
    if(isDefined(level.zombiesCompleted) && level.zombiesCompleted) {
      SetDvar("cg_drawCrosshair", true);
    }
  }

  level notify("exitLevel_called");
  exitLevel(false);
}

getGameWinner(finalRoundWinner, bSetKillCam) {
  if(!IsString(finalRoundWinner)) {
    return finalRoundWinner;
  }

  gameWinner = finalRoundWinner;

  if(level.teamBased && (isRoundBased() || level.gameType == "ctf") && level.gameEnded) {
    winEvent = "roundsWon";

    if(isDefined(level.winByCaptures) && level.winByCaptures) {
      winEvent = "teamScores";
    }

    if(game[winEvent]["allies"] == game[winEvent]["axis"]) {
      gameWinner = "tie";
    } else if(game[winEvent]["axis"] > game[winEvent]["allies"]) {
      gameWinner = "axis";
    } else {
      gameWinner = "allies";
    }
  }

  if(bSetKillCam && ((gameWinner == "allies") || (gameWinner == "axis"))) {
    level.finalKillCam_winner = gameWinner;
  }

  return gameWinner;
}

updateEndReasonText(winner) {
  if(!level.teamBased) {
    return true;
  }

  if(hitRoundLimit()) {
    return game["end_reason"]["round_limit_reached"];
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
  } else {
    scorePerMinute = getTeamScore(team) / minutesPassed;
  }

  return scorePerMinute;
}

getScoreRemaining(team) {
  assert(isPlayer(self) || isDefined(team));

  scoreLimit = getWatchedDvar("scorelimit");

  if(isPlayer(self)) {
    scoreRemaining = scoreLimit - self.score;
  } else {
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

  if(level.multiTeamBased) {
    foreach(teamname in level.teamNameList) {
      if(self.pers["team"] != teamname) {
        thread teamPlayerCardSplash("callout_lastenemyalive", self, teamname);
      }
    }
  } else {
    otherTeam = getOtherTeam(self.pers["team"]);
    thread teamPlayerCardSplash("callout_lastenemyalive", self, otherTeam);
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

    setClientMatchData("players", player.clientMatchDataId, "name", maps\mp\gametypes\_playerlogic::truncatePlayername(player.name));
    setClientMatchData("players", player.clientMatchDataId, "xuid", player.xuid);
  }

  maps\mp\_awards::assignAwards();
  maps\mp\_scoreboard::processLobbyScoreboards();

  sendClientMatchData();

  lootServiceOnEndGame();
}

trackLeaderBoardDeathStats(sWeapon, sMeansOfDeath) {
  self thread threadedSetWeaponStatByName(sWeapon, 1, "deaths");
}

trackAttackerLeaderBoardDeathStats(sWeapon, sMeansOfDeath, eInflictor) {
  if(isDefined(self) && isplayer(self)) {
    if(sMeansOfDeath != "MOD_FALLING") {
      if(isMeleeMOD(sMeansOfDeath) && IsSubStr(sWeapon, "tactical")) {
        return;
      }

      if(isMeleeMOD(sMeansOfDeath) && !IsSubStr(sWeapon, "riotshield") && !IsSubStr(sWeapon, "combatknife")) {
        return;
      }

      self thread threadedSetWeaponStatByName(sWeapon, 1, "kills");

      adsRatio = 0;

      if(isDefined(eInflictor) && isDefined(eInflictor.firedAds)) {
        adsRatio = eInflictor.firedAds;
      } else {
        adsRatio = self PlayerAds();
      }

      if(adsRatio < 0.2) {
        self thread threadedSetWeaponStatByName(sWeapon, 1, "hipfirekills");
      }

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

  if(weaponClass == "killstreak" || weaponClass == "other") {
    return;
  }

  if(isEnvironmentWeapon(name)) {
    return;
  }

  if(isBombSiteWeapon(name)) {
    return;
  }

  if(weaponClass == "weapon_grenade" || weaponClass == "weapon_explosive") {
    weaponName = maps\mp\_utility::strip_suffix(name, "_lefthand");
    weaponName = maps\mp\_utility::strip_suffix(weaponName, "_mp");
    self maps\mp\gametypes\_persistence::incrementWeaponStat(weaponName, statName, incValue);
    self maps\mp\_matchdata::logWeaponStat(weaponName, statName, incValue);
    return;
  }

  isProjectile = maps\mp\gametypes\_weapons::isPrimaryOrSecondaryProjectileWeapon(name);

  if((statName != "timeInUse") && (statName != "deaths") && (!isProjectile)) {
    oldName = name;
    name = self getCurrentWeapon();

    if(name != oldName && isKillstreakWeapon(name)) {
      return;
    }
  }

  if(!isDefined(self.trackingWeaponName)) {
    self.trackingWeaponName = name;
  }

  if(name != self.trackingWeaponName) {
    self maps\mp\gametypes\_persistence::updateWeaponBufferedStats();
    self.trackingWeaponName = name;

    self.currentFirefightShots = 0;
  }

  switch (statName) {
    case "shots":
      self.trackingWeaponShots++;
      self.currentFirefightShots++;
      break;
    case "hits":
      self.trackingWeaponHits++;
      break;
    case "headShots":
      self.trackingWeaponHeadShots++;
      self.trackingWeaponHits++;
      break;
    case "kills":
      self.trackingWeaponKills++;
      break;
    case "hipfirekills":
      self.trackingWeaponHipFireKills++;
      break;
    case "timeInUse":
      self.trackingWeaponUseTime += incValue;
      break;
  }

  if(statName == "deaths") {
    if(getDvarInt("g_debugDamage")) {
      println("wrote deaths");
    }

    weaponBaseName = getBaseWeaponName(name);

    if(!isCACPrimaryWeapon(weaponBaseName) && !isCACSecondaryWeapon(weaponBaseName)) {
      return;
    }

    attachments = getWeaponAttachmentsBaseNames(name);

    self maps\mp\gametypes\_persistence::incrementWeaponStat(weaponBaseName, statName, incValue);
    self maps\mp\_matchdata::logWeaponStat(weaponBaseName, "deaths", incValue);

    foreach(attachment in attachments) {
      self maps\mp\gametypes\_persistence::incrementAttachmentStat(attachment, statName, incValue);
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
      roundScore = player.score;
      roundAccuracy = getRoundAccuracy(player);

      bestKills = player getRankedPlayerData("bestKills");
      mostDeaths = player getRankedPlayerData("mostDeaths");
      mostXp = player getRankedPlayerData("mostXp");
      bestScore = player getRankedPlayerData("bestScore");
      bestAccuracy = player getRankedPlayerData("bestAccuracy");

      if(roundKills > bestKills) {
        player setRankedPlayerData("bestKills", roundKills);
      }

      if(roundXP > mostXp) {
        player setRankedPlayerData("mostXp", roundXP);
      }

      if(roundDeaths > mostDeaths) {
        player setRankedPlayerData("mostDeaths", roundDeaths);
      }

      if(roundScore > bestScore) {
        player setRankedPlayerData("bestScore", roundScore);
      }

      if(roundAccuracy > bestAccuracy) {
        player setRankedPlayerData("bestAccuracy", roundAccuracy);
      }

      player checkForBestWeapon();
      player maps\mp\_matchdata::logPlayerXP(roundXP, "totalXp");
      player maps\mp\_matchdata::logPlayerXP(player.pers["summary"]["score"], "scoreXp");
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

getRoundAccuracy(player) {
  shotsThisGame = float(player getRankedPlayerData("totalShots") - player.pers["previous_shots"]);

  if(shotsThisGame == 0) {
    return 0;
  }

  hitsThisGame = float(player getRankedPlayerData("hits") - player.pers["previous_hits"]);

  roundAccuracy = Clamp(hitsThisGame / shotsThisGame, 0.0, 1.0) * 10000.0;

  return int(roundAccuracy);
}

checkForBestWeapon() {
  baseWeaponList = maps\mp\_matchdata::buildBaseWeaponList();

  for(i = 0; i < baseWeaponList.size; i++) {
    weaponName = baseWeaponList[i];

    weaponName = getBaseWeaponName(weaponName);

    weaponClass = getWeaponClass(weaponName);

    if(!isKillstreakWeapon(weaponName) && weaponClass != "killstreak" && weaponClass != "other") {
      bestWeaponKills = self getRankedPlayerData("bestWeapon", "kills");

      weaponKills = 0;

      if(isDefined(self.pers["mpWeaponStats"][weaponName]) &&
        isDefined(self.pers["mpWeaponStats"][weaponName]["kills"])) {
        weaponKills = self.pers["mpWeaponStats"][weaponName]["kills"];

        if(weaponKills > bestWeaponKills) {
          self setRankedPlayerData("bestWeapon", "kills", weaponKills);

          weaponShots = 0;
          if(isDefined(self.pers["mpWeaponStats"][weaponName]["shots"])) {
            weaponShots = self.pers["mpWeaponStats"][weaponName]["shots"];
          }

          weaponHeadShots = 0;
          if(isDefined(self.pers["mpWeaponStats"][weaponName]["headShots"])) {
            weaponHeadShots = self.pers["mpWeaponStats"][weaponName]["headShots"];
          }

          weaponHits = 0;
          if(isDefined(self.pers["mpWeaponStats"][weaponName]["hits"])) {
            weaponHits = self.pers["mpWeaponStats"][weaponName]["hits"];
          }

          weaponDeaths = 0;
          if(isDefined(self.pers["mpWeaponStats"][weaponName]["deaths"])) {
            weaponDeaths = self.pers["mpWeaponStats"][weaponName]["deaths"];
          }

          self setRankedPlayerData("bestWeapon", "shots", weaponShots);
          self setRankedPlayerData("bestWeapon", "headShots", weaponHeadShots);
          self setRankedPlayerData("bestWeapon", "hits", weaponHits);
          self setRankedPlayerData("bestWeapon", "deaths", weaponDeaths);

          statsTableIdx = int(TableLookup("mp/statstable.csv", 4, weaponName, 0));
          self setRankedPlayerData("bestWeaponIndex", statsTableIdx);
        }
      }
    }
  }
}

updateCombatRecordForPlayerTrends() {
  TrendsCount = 5;

  numTrends = self getRankedPlayerData("combatRecord", "numTrends");

  numTrends++;
  if(numTrends > TrendsCount) {
    numTrends = TrendsCount;

    if(TrendsCount > 1) {
      for(i = 0; i < (TrendsCount - 1); i++) {
        timestamp = self getRankedPlayerData("combatRecord", "trend", i + 1, "timestamp");
        kills = self getRankedPlayerData("combatRecord", "trend", i + 1, "kills");
        deaths = self getRankedPlayerData("combatRecord", "trend", i + 1, "deaths");
        self setRankedPlayerData("combatRecord", "trend", i, "timestamp", timestamp);
        self setRankedPlayerData("combatRecord", "trend", i, "kills", kills);
        self setRankedPlayerData("combatRecord", "trend", i, "deaths", deaths);
      }
    }
  }

  timestamp = GetTimeUTC();
  kills = self.kills;
  deaths = self.deaths;
  self setRankedPlayerData("combatRecord", "trend", numTrends - 1, "timestamp", timestamp);
  self setRankedPlayerData("combatRecord", "trend", numTrends - 1, "kills", kills);
  self setRankedPlayerData("combatRecord", "trend", numTrends - 1, "deaths", deaths);

  self setRankedPlayerData("combatRecord", "numTrends", numTrends);
}

updateCombatRecordCommonData() {
  currentTimestamp = GetTimeUTC();
  setCombatRecordStat("timeStampLastGame", currentTimestamp);

  incrementCombatRecordStat("numMatches", 1);
  incrementCombatRecordStat("timePlayed", self.timePlayed["total"]);
  incrementCombatRecordStat("kills", self.kills);
  incrementCombatRecordStat("deaths", self.deaths);
  incrementCombatRecordStat("xpEarned", self.pers["summary"]["xp"]);

  if(isDefined(self.combatRecordWin)) {
    incrementCombatRecordStat("wins", 1);
  }

  if(isDefined(self.combatRecordTie)) {
    incrementCombatRecordStat("ties", 1);
  }

  stored_firstTimeStamp = self getRankedPlayerData("combatRecord", level.gametype, "timeStampFirstGame");

  if(stored_firstTimeStamp == 0) {
    setCombatRecordStat("timeStampFirstGame", currentTimestamp);
  }
}

incrementCombatRecordStat(statName, incementValue) {
  storedValue = self getRankedPlayerData("combatRecord", level.gametype, statName);
  storedValue += incementValue;

  self setRankedPlayerData("combatRecord", level.gametype, statName, storedValue);
}

setCombatRecordStat(statName, newValue) {
  self setRankedPlayerData("combatRecord", level.gametype, statName, newValue);
}

setCombatRecordStatIfGreater(statName, newValue) {
  storedValue = self getRankedPlayerData("combatRecord", level.gametype, statName);

  if(newValue > storedValue) {
    setCombatRecordStat(statName, newValue);
  }
}

updateCombatRecordForPlayerGameModes() {
  if((level.gametype == "war") || (level.gametype == "dm")) {
    updateCombatRecordCommonData();

    deaths = self.deaths;

    if(deaths == 0) {
      deaths = 1;
    }

    kdratio = int(self.kills / deaths) * 1000;

    setCombatRecordStatIfGreater("mostkills", self.kills);
    setCombatRecordStatIfGreater("bestkdr", kdratio);
  } else if(level.gametype == "ctf") {
    updateCombatRecordCommonData();

    captures = getPersStat("captures");
    returns = getPersStat("returns");

    incrementCombatRecordStat("captures", captures);
    incrementCombatRecordStat("returns", returns);
    setCombatRecordStatIfGreater("mostcaptures", captures);
    setCombatRecordStatIfGreater("mostreturns", returns);
  } else if(level.gametype == "dom") {
    updateCombatRecordCommonData();

    captures = getPersStat("captures");
    defends = getPersStat("defends");

    incrementCombatRecordStat("captures", captures);
    incrementCombatRecordStat("defends", defends);
    setCombatRecordStatIfGreater("mostcaptures", captures);
    setCombatRecordStatIfGreater("mostdefends", defends);
  } else if(level.gametype == "conf") {
    updateCombatRecordCommonData();

    confirms = getPersStat("confirmed");
    denies = getPersStat("denied");

    incrementCombatRecordStat("confirms", confirms);
    incrementCombatRecordStat("denies", denies);
    setCombatRecordStatIfGreater("mostconfirms", confirms);
    setCombatRecordStatIfGreater("mostdenies", denies);
  } else if(level.gametype == "sd") {
    updateCombatRecordCommonData();

    plants = getPersStat("plants");
    defuses = getPersStat("defuses");
    detonates = getPersStat("destructions");

    incrementCombatRecordStat("plants", plants);
    incrementCombatRecordStat("defuses", defuses);
    incrementCombatRecordStat("detonates", detonates);
    setCombatRecordStatIfGreater("mostplants", plants);
    setCombatRecordStatIfGreater("mostdefuses", defuses);
    setCombatRecordStatIfGreater("mostdetonates", detonates);
  } else if(level.gametype == "hp") {
    updateCombatRecordCommonData();

    captures = getPersStat("captures");
    defends = getPersStat("defends");

    incrementCombatRecordStat("captures", captures);
    incrementCombatRecordStat("defends", defends);
    setCombatRecordStatIfGreater("mostcaptures", captures);
    setCombatRecordStatIfGreater("mostdefends", defends);
  } else if(level.gametype == "sr") {
    updateCombatRecordCommonData();

    plants = getPersStat("plants");
    defuses = getPersStat("defuses");
    detonates = getPersStat("destructions");
    confirms = getPersStat("confirmed");
    denies = getPersStat("denied");

    incrementCombatRecordStat("plants", plants);
    incrementCombatRecordStat("defuses", defuses);
    incrementCombatRecordStat("detonates", detonates);
    incrementCombatRecordStat("confirms", confirms);
    incrementCombatRecordStat("denies", denies);
    setCombatRecordStatIfGreater("mostplants", plants);
    setCombatRecordStatIfGreater("mostdefuses", defuses);
    setCombatRecordStatIfGreater("mostdetonates", detonates);
    setCombatRecordStatIfGreater("mostconfirms", confirms);
    setCombatRecordStatIfGreater("mostdenies", denies);
  } else if(level.gametype == "infect") {
    updateCombatRecordCommonData();

    survivorKills = getPlayerStat("contagious");
    infectedKills = self.kills - survivorKills;

    incrementCombatRecordStat("infectedKills", infectedKills);
    incrementCombatRecordStat("survivorKills", survivorKills);
    setCombatRecordStatIfGreater("mostInfectedKills", infectedKills);
    setCombatRecordStatIfGreater("mostSurvivorKills", survivorKills);
  } else if(level.gametype == "gun") {
    updateCombatRecordCommonData();

    gunPromotions = getPlayerStat("levelup");
    stabs = getPlayerStat("humiliation");

    incrementCombatRecordStat("gunPromotions", gunPromotions);
    incrementCombatRecordStat("stabs", stabs);
    setCombatRecordStatIfGreater("mostGunPromotions", gunPromotions);
    setCombatRecordStatIfGreater("mostStabs", stabs);
  } else if(level.gametype == "ball") {
    updateCombatRecordCommonData();

    pointsScored = getPlayerStat("fieldgoal") + (getPlayerStat("touchdown") * 2);
    killedBallCarrier = getPlayerStat("killedBallCarrier");

    incrementCombatRecordStat("pointsScored", pointsScored);
    incrementCombatRecordStat("killedBallCarrier", killedBallCarrier);
    setCombatRecordStatIfGreater("mostPointsScored", pointsScored);
    setCombatRecordStatIfGreater("mostKilledBallCarrier", killedBallCarrier);
  } else if(level.gametype == "twar") {
    updateCombatRecordCommonData();

    captures = getPersStat("captures");
    killWhileCaptures = getPlayerStat("kill_while_capture");

    incrementCombatRecordStat("captures", captures);
    incrementCombatRecordStat("killWhileCaptures", killWhileCaptures);
    setCombatRecordStatIfGreater("mostCaptures", captures);
    setCombatRecordStatIfGreater("mostKillWhileCaptures", killWhileCaptures);
  }
}

updateCombatRecordForPlayer() {
  self updateCombatRecordForPlayerTrends();
  self updateCombatRecordForPlayerGameModes();
}

updateCombatRecord() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player rankingEnabled()) {
      player updateCombatRecordForPlayer();
    }
    level maps\mp\gametypes\_playerlogic::writeSegmentData(player);

    if(practiceRoundGame()) {
      level maps\mp\gametypes\_playerlogic::checkPracticeRoundLockout(player);
    }
  }
}