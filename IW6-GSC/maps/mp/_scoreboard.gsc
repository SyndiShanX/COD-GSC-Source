/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_scoreboard.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

processLobbyScoreboards() {
  foreach(player in level.placement["all"])
  player setPlayerScoreboardInfo();

  if(level.multiTeamBased) {
    buildScoreboardType("multiteam");

    foreach(player in level.players)
    player setCommonPlayerData("round", "scoreboardType", "multiteam");

    setClientMatchData("alliesScore", -1);
    setClientMatchData("axisScore", -1);

    setClientMatchData("alliesKills", -1);
    setClientMatchData("alliesDeaths", -1);
  } else if(level.teamBased) {
    alliesScore = getTeamScore("allies");
    axisScore = getTeamScore("axis");

    kills = 0;
    deaths = 0;
    foreach(player in level.players) {
      if(isDefined(player.pers["team"]) && player.pers["team"] == "allies") {
        kills = kills + player.pers["kills"];
        deaths = deaths + player.pers["deaths"];
      }
    }

    setClientMatchData("alliesScore", alliesScore);
    setClientMatchData("axisScore", axisScore);

    setClientMatchData("alliesKills", kills);
    setClientMatchData("alliesDeaths", deaths);

    if(alliesScore == axisScore)
      winner = "tied";
    else if(alliesScore > axisScore)
      winner = "allies";
    else
      winner = "axis";

    if(winner == "tied") {
      buildScoreboardType("allies");
      buildScoreboardType("axis");

      foreach(player in level.players) {
        player_pers_team = player.pers["team"];
        if(!isDefined(player_pers_team)) {
          continue;
        }
        if(player_pers_team == "spectator")
          player setCommonPlayerData("round", "scoreboardType", "allies");
        else
          player setCommonPlayerData("round", "scoreboardType", player_pers_team);
      }
    } else {
      buildScoreboardType(winner);

      foreach(player in level.players)
      player setCommonPlayerData("round", "scoreboardType", winner);
    }
  } else {
    buildScoreboardType("neutral");

    foreach(player in level.players)
    player setCommonPlayerData("round", "scoreboardType", "neutral");

    setClientMatchData("alliesScore", -1);
    setClientMatchData("axisScore", -1);

    setClientMatchData("alliesKills", -1);
    setClientMatchData("alliesDeaths", -1);
  }

  foreach(player in level.players) {
    if(!isAi(player) && (privateMatch() || MatchMakingGame()))
      player setCommonPlayerData("round", "squadMemberIndex", player.pers["activeSquadMember"]);

    player setCommonPlayerData("round", "totalXp", player.pers["summary"]["xp"]);
    player setCommonPlayerData("round", "scoreXp", player.pers["summary"]["score"]);
    player setCommonPlayerData("round", "operationXp", player.pers["summary"]["operation"]);
    player setCommonPlayerData("round", "challengeXp", player.pers["summary"]["challenge"]);
    player setCommonPlayerData("round", "matchXp", player.pers["summary"]["match"]);
    player setCommonPlayerData("round", "miscXp", player.pers["summary"]["misc"]);
    player setCommonPlayerDataReservedInt("common_entitlement_xp", player.pers["summary"]["entitlementXP"]);
    player setCommonPlayerDataReservedInt("common_clan_wars_xp", player.pers["summary"]["clanWarsXP"]);
  }
}

setPlayerScoreboardInfo() {
  scoreboardPlayerCount = getClientMatchData("scoreboardPlayerCount");
  if(scoreboardPlayerCount <= 24) {
    setClientMatchData("players", self.clientMatchDataId, "score", self.pers["score"]);
    println("Scoreboard: [" + self.name + "(" + self.clientMatchDataId + ")][score]: " + self.pers["score"]);

    if(isDefined(level.isHorde)) {
      kills = self.pers["hordeKills"];
    } else {
      kills = self.pers["kills"];
    }
    setClientMatchData("players", self.clientMatchDataId, "kills", kills);
    println("Scoreboard: [" + self.name + "(" + self.clientMatchDataId + ")][kills]: " + kills);

    if(isDefined(level.isHorde)) {
      assists = self.pers["hordeRevives"];
    } else if(level.gameType == "dm" || level.gameType == "sotf_ffa" || level.gameType == "gun") {
      assists = self.assists;
    } else {
      assists = self.pers["assists"];
    }
    setClientMatchData("players", self.clientMatchDataId, "assists", assists);
    println("Scoreboard: [" + self.name + "(" + self.clientMatchDataId + ")][assists]: " + assists);

    deaths = self.pers["deaths"];
    setClientMatchData("players", self.clientMatchDataId, "deaths", deaths);
    println("Scoreboard: [" + self.name + "(" + self.clientMatchDataId + ")][deaths]: " + deaths);

    team = self.pers["team"];
    setClientMatchData("players", self.clientMatchDataId, "team", team);
    println("Scoreboard: [" + self.name + "(" + self.clientMatchDataId + ")][team]: " + team);

    faction = game[self.pers["team"]];
    setClientMatchData("players", self.clientMatchDataId, "faction", faction);
    println("Scoreboard: [" + self.name + "(" + self.clientMatchDataId + ")][faction]: " + faction);

    extrascore0 = self.pers["extrascore0"];
    setClientMatchData("players", self.clientMatchDataId, "extrascore0", extrascore0);
    println("Scoreboard: [" + self.name + "(" + self.clientMatchDataId + ")][extrascore0]: " + extrascore0);

    println("Scoreboard: scoreboardPlayerCount was " + scoreboardPlayerCount);
    scoreboardPlayerCount++;
    setClientMatchData("scoreboardPlayerCount", scoreboardPlayerCount);
    println("Scoreboard: scoreboardPlayerCount now " + scoreboardPlayerCount);
  } else {
    println("Scoreboard: scoreboardPlayerCount is greater than 24 (" + scoreboardPlayerCount + ")");
  }
}

buildScoreboardType(team) {
  assert(team == "allies" || team == "axis" || team == "neutral" || team == "multiteam");

  println("Scoreboard: Building scoreboard (" + team + ")");

  if(team == "multiteam") {
    index = 0;

    foreach(teamname in level.teamNameList) {
      foreach(player in level.placement[teamname]) {
        setClientMatchData("scoreboards", "multiteam", index, player.clientMatchDataId);
        println("Scoreboard: [scoreboards][" + team + "][" + index + "][" + player.clientMatchDataId + "]");
        index++;
      }
    }
  } else if(team == "neutral") {
    index = 0;
    foreach(player in level.placement["all"]) {
      setClientMatchData("scoreboards", team, index, player.clientMatchDataId);
      println("Scoreboard: [scoreboards][" + team + "][" + index + "][" + player.clientMatchDataId + "]");
      index++;
    }
  } else {
    otherTeam = getOtherTeam(team);

    index = 0;
    foreach(player in level.placement[team]) {
      setClientMatchData("scoreboards", team, index, player.clientMatchDataId);
      println("Scoreboard: [scoreboards][" + team + "][" + index + "][" + player.name + "(" + player.clientMatchDataId + ")]");
      index++;
    }

    foreach(player in level.placement[otherTeam]) {
      setClientMatchData("scoreboards", team, index, player.clientMatchDataId);
      println("Scoreboard: [scoreboards][" + team + "][" + index + "][" + player.name + "(" + player.clientMatchDataId + ")]");
      index++;
    }
  }
}