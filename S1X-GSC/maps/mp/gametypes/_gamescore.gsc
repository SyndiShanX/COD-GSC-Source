/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gamescore.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

getHighestScoringPlayer() {
  updatePlacement();

  if(!level.placement["all"].size) {
    return (undefined);
  } else {
    return (level.placement["all"][0]);
  }
}

getHighestScoringPlayersArray(number) {
  highestScoringPlayers = [];

  if(number < 0) {
    return highestScoringPlayers;
  }

  updatePlacement();

  for(i = 0; i < number; i++) {
    if(level.placement["all"].size == i) {
      break;
    }

    highestScoringPlayers[i] = level.placement["all"][i];
  }

  return highestScoringPlayers;
}

getLosingPlayers() {
  updatePlacement();

  players = level.placement["all"];
  losingPlayers = [];

  foreach(player in players) {
    if(player == level.placement["all"][0]) {
      continue;
    }

    losingPlayers[losingPlayers.size] = player;
  }

  return losingPlayers;
}

updateScoreStatsFFA(player, score_change) {
  if(level.teambased) {
    return;
  }

  player maps\mp\gametypes\_persistence::statSetChild("round", "score", player.extraScore0);
  player maps\mp\gametypes\_persistence::statAdd("score", score_change);

  if(score_change > 0) {
    player maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_veteran", score_change);
  }
}

givePlayerScore(event, player, victim) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  if(!isPlayer(player)) {
    return;
  }

  player maps\mp\killstreaks\_killstreaks::giveAdrenaline(event);

  prevScore = player.pers["score"];
  onPlayerScore(event, player, victim);
  score_change = (player.pers["score"] - prevScore);

  if(score_change == 0) {
    return;
  }

  if(player.pers["score"] < 65535) {
    player.score = player.pers["score"];
  }

  if(level.teambased) {
    player maps\mp\gametypes\_persistence::statSetChild("round", "score", player.score);
    player maps\mp\gametypes\_persistence::statAdd("score", score_change);

    if(score_change > 0) {
      player maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_veteran", score_change);
    }
  }

  if(!level.teambased) {
    level thread sendUpdatedDMScores();
    player maps\mp\gametypes\_gamelogic::checkPlayerScoreLimitSoon();
  }

  player maps\mp\gametypes\_gamelogic::checkScoreLimit();
}

onPlayerScore(event, player, victim) {
  score = undefined;

  if(isDefined(level.onPlayerScore)) {
    score = [[level.onPlayerScore]](event, player, victim);
  }

  if(!isDefined(score)) {
    score = maps\mp\gametypes\_rank::getScoreInfoValue(event);
  }

  assert(isDefined(score));

  player.pers["score"] += score * level.objectivePointsMod;
}

_setPlayerScore(player, score) {
  if(score == player.pers["score"]) {
    return;
  }

  player.pers["score"] = score;
  player.score = player.pers["score"];

  player thread maps\mp\gametypes\_gamelogic::checkScoreLimit();
}

_getPlayerScore(player) {
  return player.pers["score"];
}

giveTeamScoreForObjective(team, score) {
  score *= level.objectivePointsMod;

  _setTeamScore(team, _getTeamScore(team) + score);

  level notify("update_team_score", team, _getTeamScore(team));

  thread giveTeamScoreForObjectiveEndOfFrame();
}

giveTeamScoreForObjectiveEndOfFrame() {
  level endon("update_team_score");
  level endon("game_ended");

  waittillframeend;

  isWinning = getWinningTeam();
  if(!level.splitScreen && isWinning != "none" && isWinning != level.wasWinning && getTime() - level.lastStatusTime > 5000 && getScoreLimit() != 1) {
    level.lastStatusTime = getTime();
    leaderDialog("lead_taken", isWinning, "status");
    if(level.wasWinning != "none") {
      leaderDialog("lead_lost", level.wasWinning, "status");
    }
  }

  if(isWinning != "none") {
    level.wasWinning = isWinning;

    teamScore = _getTeamScore(isWinning);
    scoreLimit = getWatchedDvar("scorelimit");

    if(teamScore == 0 || scoreLimit == 0) {
      return;
    }

    scorePercentage = (teamScore / scoreLimit) * 100;

    if(scorePercentage > level.scorePercentageCutOff) {
      SetNoJIPScore(true);
    }
  }

}

getWinningTeam() {
  if(practiceRoundGame()) {
    return "none";
  }

  assert(level.teamBased == true);
  teams_list = level.teamNameList;

  winning_team = teams_list[0];
  winning_score = game["teamScores"][teams_list[0]];
  num_teams_tied_for_winning = 1;
  for(i = 1; i < teams_list.size; i++) {
    if(game["teamScores"][teams_list[i]] > winning_score) {
      winning_team = teams_list[i];
      winning_score = game["teamScores"][teams_list[i]];
      num_teams_tied_for_winning = 1;
    } else if(game["teamScores"][teams_list[i]] == winning_score) {
      num_teams_tied_for_winning = num_teams_tied_for_winning + 1;
      winning_team = "none";
    }
  }

  return (winning_team);
}

_setTeamScore(team, teamScore) {
  if(teamScore == game["teamScores"][team]) {
    return;
  }

  game["teamScores"][team] = teamScore;

  updateTeamScore(team);

  if(inOvertime() && !isDefined(level.overtimeScoreWinOverride) || (isDefined(level.overtimeScoreWinOverride) && !level.overtimeScoreWinOverride)) {
    thread maps\mp\gametypes\_gamelogic::onScoreLimit();
  } else {
    thread maps\mp\gametypes\_gamelogic::checkTeamScoreLimitSoon(team);
    thread maps\mp\gametypes\_gamelogic::checkScoreLimit();
  }
}

updateTeamScore(team) {
  assert(level.teamBased);

  teamScore = 0;
  if(!isRoundBased() || !isObjectiveBased()) {
    teamScore = _getTeamScore(team);
  } else {
    teamScore = game["roundsWon"][team];
  }

  setTeamScore(team, teamScore);
}

_getTeamScore(team) {
  return game["teamScores"][team];
}

sendUpdatedTeamScores() {
  level notify("updating_scores");
  level endon("updating_scores");
  wait .05;

  WaitTillSlowProcessAllowed();

  foreach(player in level.players) {
    player updateScores();
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

  if(level.multiTeamBased) {
    MTDM_updateTeamPlacement();
  }
  if(level.teamBased) {
    updateTeamPlacement();
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

  placementAll = [];
  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame)) {
      continue;
    }

    if(player.pers["team"] == "spectator" || player.pers["team"] == "none") {
      continue;
    }

    placementAll[placementAll.size] = player;
  }

  for(i = 1; i < placementAll.size; i++) {
    player = placementAll[i];
    playerScore = player.score;

    if(!level.teamBased) {
      playerScore = player.extrascore0;
    }

    for(j = i - 1; j >= 0 && getBetterPlayer(player, placementAll[j]) == player; j--) {
      placementAll[j + 1] = placementAll[j];
    }
    placementAll[j + 1] = player;
  }

  level.placement["all"] = placementAll;

  if(level.multiTeamBased) {
    MTDM_updateTeamPlacement();
  } else if(level.teamBased) {
    updateTeamPlacement();
  }

  prof_end("updatePlacement");
}

getBetterPlayer(playerA, playerB) {
  if(playerA.score > playerB.score) {
    return playerA;
  }

  if(playerB.score > playerA.score) {
    return playerB;
  }

  if(playerA.deaths < playerB.deaths) {
    return playerA;
  }

  if(playerB.deaths < playerA.deaths) {
    return playerB;
  }

  if(cointoss()) {
    return playerA;
  } else {
    return playerB;
  }
}

updateTeamPlacement() {
  placement["allies"] = [];
  placement["axis"] = [];
  placement["spectator"] = [];

  assert(level.teamBased);

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

MTDM_updateTeamPlacement() {
  placement["spectator"] = [];

  foreach(teamname in level.teamNameList) {
    placement[teamname] = [];
  }

  assert(level.multiTeamBased);

  placementAll = level.placement["all"];
  placementAllSize = placementAll.size;

  for(i = 0; i < placementAllSize; i++) {
    player = placementAll[i];
    team = player.pers["team"];

    placement[team][placement[team].size] = player;
  }

  foreach(teamname in level.teamNameList) {
    level.placement[teamname] = placement[teamname];
  }
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