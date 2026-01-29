/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gamescore.gsc
********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

getHighestScoringPlayer() {
  updatePlacement();

  if(!level.placement["all"].size)
    return (undefined);
  else
    return (level.placement["all"][0]);
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

givePlayerScore(event, player, victim, overrideCheckPlayerScoreLimitSoon, overridePointsPopup, bScaleDown) {
  if(is_aliens())
    return;
  else
    givePlayerScore_regularMP(event, player, victim, overrideCheckPlayerScoreLimitSoon, overridePointsPopup, bScaleDown);
}

givePlayerScore_regularMP(event, player, victim, overrideCheckPlayerScoreLimitSoon, overridePointsPopup, bScaleDown) {
  if(isDefined(player.owner) && !IsBot(player)) {
    player = player.owner;
  }

  if(!IsBot(player)) {
    if(isDefined(player.commanding_bot)) {
      player = player.commanding_bot;
    }
  }

  if(!IsPlayer(player)) {
    return;
  }
  if(!isDefined(overrideCheckPlayerScoreLimitSoon))
    overrideCheckPlayerScoreLimitSoon = false;

  if(!isDefined(overridePointsPopup))
    overridePointsPopup = false;

  if(!isDefined(bScaleDown))
    bScaleDown = false;

  prevScore = player.pers["score"];
  onPlayerScore(event, player, victim, bScaleDown);
  score_change = (player.pers["score"] - prevScore);

  if(score_change == 0) {
    return;
  }
  if(bScaleDown)
    score_change = int(score_change * 10);

  eventValue = maps\mp\gametypes\_rank::getScoreInfoValue(event);

  if(!player rankingEnabled() && !level.hardcoreMode && !overridePointsPopup) {
    if(gameModeUsesDeathmatchScoring(level.gameType))
      player thread maps\mp\gametypes\_rank::xpPointsPopup(eventValue);
    else
      player thread maps\mp\gametypes\_rank::xpPointsPopup(score_change);
  }

  if(gameModeUsesDeathmatchScoring(level.gameType))
    player maps\mp\gametypes\_persistence::statAdd("score", eventValue);
  else if(!IsSquadsMode())
    player maps\mp\gametypes\_persistence::statAdd("score", score_change);

  if(player.pers["score"] >= 65000)
    player.pers["score"] = 65000;

  player.score = player.pers["score"];
  scoreChildStat = player.score;

  if(bScaleDown)
    scoreChildStat = int(scoreChildStat * 10);

  if(gameModeUsesDeathmatchScoring(level.gameType))
    player maps\mp\gametypes\_persistence::statSetChild("round", "score", scoreChildStat * eventValue);
  else
    player maps\mp\gametypes\_persistence::statSetChild("round", "score", scoreChildStat);

  if(!level.teambased)
    thread sendUpdatedDMScores();

  if(!overrideCheckPlayerScoreLimitSoon)
    player maps\mp\gametypes\_gamelogic::checkPlayerScoreLimitSoon();

  scoreEndedMatch = player maps\mp\gametypes\_gamelogic::checkScoreLimit();
}

onPlayerScore(event, player, victim, bScaleDown) {
  score = undefined;
  if(isDefined(level.onPlayerScore)) {
    score = [[level.onPlayerScore]](event, player, victim);
  }
  if(!isDefined(score)) {
    score = maps\mp\gametypes\_rank::getScoreInfoValue(event);
  }

  score = score * level.objectivePointsMod;

  if(bScaleDown)
    score = int(score / 10);

  assert(isDefined(score));

  player.pers["score"] += score;
}

_setPlayerScore(player, score) {
  if(score == player.pers["score"]) {
    return;
  }
  if(score < 0) {
    return;
  }
  player.pers["score"] = score;
  player.score = player.pers["score"];

  player thread maps\mp\gametypes\_gamelogic::checkScoreLimit();
}

_getPlayerScore(player) {
  if(!isDefined(player))
    player = self;
  return player.pers["score"];
}

giveTeamScoreForObjective(team, score) {
  score *= level.objectivePointsMod;

  _setTeamScore(team, _getTeamScore(team) + score);

  level notify("update_team_score", team, _getTeamScore(team));

  isWinning = getWinningTeam();

  if(!level.splitScreen && isWinning != "none" && isWinning != level.wasWinning && getTime() - level.lastStatusTime > 5000 && getScoreLimit() != 1) {
    level.lastStatusTime = getTime();
    leaderDialog("lead_taken", isWinning, "status");
    if(level.wasWinning != "none")
      leaderDialog("lead_lost", level.wasWinning, "status");
  }

  if(isWinning != "none") {
    level.wasWinning = isWinning;

    teamScore = _getTeamScore(isWinning);
    scoreLimit = getWatchedDvar("scorelimit");

    if(teamScore == 0 || scoreLimit == 0) {
      return;
    }
    scorePercentage = (teamScore / scoreLimit) * 100;

    if(scorePercentage > level.scorePercentageCutOff)
      SetNoJIPScore(true);
  }
}

getWinningTeam() {
  assert(level.teamBased == true);
  teams_list = level.teamNameList;

  if(!isDefined(level.wasWinning))
    level.wasWinning = "none";

  winning_team = "none";
  winning_score = 0;
  if(level.wasWinning != "none") {
    winning_team = level.wasWinning;
    winning_score = game["teamScores"][level.wasWinning];
  }

  num_teams_tied_for_winning = 1;
  foreach(teamName in teams_list) {
    if(teamName == level.wasWinning) {
      continue;
    }
    if(game["teamScores"][teamName] > winning_score) {
      winning_team = teamName;
      winning_score = game["teamScores"][teamName];
      num_teams_tied_for_winning = 1;
    } else if(game["teamScores"][teamName] == winning_score) {
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

  if(game["status"] == "overtime" && !isDefined(level.overtimeScoreWinOverride) || (isDefined(level.overtimeScoreWinOverride) && !level.overtimeScoreWinOverride))
    thread maps\mp\gametypes\_gamelogic::onScoreLimit();
  else {
    thread maps\mp\gametypes\_gamelogic::checkTeamScoreLimitSoon(team);
    thread maps\mp\gametypes\_gamelogic::checkScoreLimit();
  }
}

updateTeamScore(team) {
  assert(level.teamBased);

  teamScore = 0;

  if(!isRoundBased() || !isObjectiveBased() || level.gameType == "blitz")
    teamScore = _getTeamScore(team);
  else
    teamScore = game["roundsWon"][team];

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

  foreach(player in level.players)
  player updateScores();
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
    if(level.placement["all"][i] == self)
      found = true;

    if(found)
      level.placement["all"][i] = level.placement["all"][i + 1];
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

    for(j = i - 1; j >= 0 && getBetterPlayer(player, placementAll[j]) == player; j--)
      placementAll[j + 1] = placementAll[j];
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
  if(playerA.score > playerB.score)
    return playerA;

  if(playerB.score > playerA.score)
    return playerB;

  if(playerA.deaths < playerB.deaths)
    return playerA;

  if(playerB.deaths < playerA.deaths)
    return playerB;

  if(cointoss())
    return playerA;
  else
    return playerB;
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

    if(!didAny)
      wait 3;
  }
}

processAssist(killedplayer) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  if(is_aliens())
    return;
  else
    processAssist_regularMP(killedplayer);
}

processAssist_regularMP(killedplayer) {
  self endon("disconnect");
  killedplayer endon("disconnect");

  wait .05;
  WaitTillSlowProcessAllowed();

  self_pers_team = self.pers["team"];
  if(self_pers_team != "axis" && self_pers_team != "allies") {
    return;
  }
  if(self_pers_team == killedplayer.pers["team"]) {
    return;
  }
  assistCreditTo = self;
  if(isDefined(self.commanding_bot)) {
    assistCreditTo = self.commanding_bot;
  }
  assistCreditTo thread[[level.onXPEvent]]("assist");
  assistCreditTo incPersStat("assists", 1);
  assistCreditTo.assists = assistCreditTo getPersStat("assists");
  assistCreditTo incPlayerStat("assists", 1);

  assistCreditTo maps\mp\gametypes\_persistence::statSetChild("round", "assists", assistCreditTo.assists);

  givePlayerScore("assist", self, killedplayer);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("assist");

  self thread maps\mp\gametypes\_missions::playerAssist(killedplayer);
}

processShieldAssist(killedPlayer) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  if(is_aliens())
    return;
  else
    processShieldAssist_regularMP(killedPlayer);
}

processShieldAssist_regularMP(killedPlayer) {
  self endon("disconnect");
  killedPlayer endon("disconnect");

  wait .05;
  WaitTillSlowProcessAllowed();

  if(self.pers["team"] != "axis" && self.pers["team"] != "allies") {
    return;
  }
  if(self.pers["team"] == killedplayer.pers["team"]) {
    return;
  }
  self thread[[level.onXPEvent]]("assist");
  self thread[[level.onXPEvent]]("assist");
  self incPersStat("assists", 1);
  self.assists = self getPersStat("assists");
  self incPlayerStat("assists", 1);

  self maps\mp\gametypes\_persistence::statSetChild("round", "assists", self.assists);

  givePlayerScore("assist", self, killedplayer);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed("shield_assist");

  self thread maps\mp\gametypes\_missions::playerAssist(killedPlayer);
}

gameModeUsesDeathmatchScoring(mode) {
  return (mode == "dm" || mode == "sotf_ffa");
}