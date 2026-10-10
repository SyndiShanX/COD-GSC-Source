/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\scoreboard.gsc
***********************************************/

#using script_3f8889c16399185c;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace scoreboard;

function processlobbyscoreboards() {
  processmatchscoreboardinfo();

  foreach(player in level.players) {
    processcommonplayerdataforplayer(player);
  }
}

function processmatchscoreboardinfo() {
  if(level.multiteambased) {
    buildscoreboardtype("multiteam");

    foreach(player in level.players) {
      player setplayerdata("common", "round", "scoreboardType", "multiteam");
    }

    alliesscore = getteamscore("allies");
    axisscore = getteamscore("axis");
    team3score = getteamscore("team_three");

    if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
      setclientmatchdata("alliesScore", alliesscore);
      setclientmatchdata("axisScore", axisscore);
      setclientmatchdata("team3Score", team3score);
      setclientmatchdata("scoreProgressLimit", getomnvar("ui_scorelimit"));
      setclientmatchdata("alliesKills", -1);
      setclientmatchdata("alliesDeaths", -1);
    }

    return;
  }

  if(level.teambased) {
    alliesscore = getteamscore("allies");
    axisscore = getteamscore("axis");
    kills = 0;
    deaths = 0;

    foreach(player in level.players) {
      if(isDefined(player scripts\mp\utility\stats::getpersstat("team")) && player scripts\mp\utility\stats::getpersstat("team") == "allies") {
        kills += player scripts\mp\utility\stats::getpersstat("kills");
        deaths += player scripts\mp\utility\stats::getpersstat("deaths");
      }
    }

    winner = "tie";

    if(inovertime()) {
      if(istimetobeatrulegametype()) {
        if(game["timeToBeatTeam"] == "none") {
          if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
            setclientmatchdata("alliesTTB", 0);
            setclientmatchdata("axisTTB", 0);
          }

          winner = "tie";
        } else {
          if("allies" == game["timeToBeatTeam"]) {
            alliesscore++;
          } else {
            axisscore++;
          }

          if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
            setclientmatchdata("alliesTTB", ter_op("allies" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
            setclientmatchdata("axisTTB", ter_op("axis" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          }

          winner = game["timeToBeatTeam"];
        }
      } else if(isscoretobeatrulegametype()) {}
    } else if(alliesscore == axisscore) {
      winner = "tie";
    } else if(alliesscore > axisscore) {
      winner = "allies";
    } else {
      winner = "axis";
    }

    if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
      setclientmatchdata("alliesScore", alliesscore);
      setclientmatchdata("axisScore", axisscore);
      setclientmatchdata("scoreProgressLimit", getomnvar("ui_scorelimit"));
      setclientmatchdata("alliesKills", kills);
      setclientmatchdata("alliesDeaths", deaths);
    }

    if(winner == "tie") {
      buildscoreboardtype("allies");
      buildscoreboardtype("axis");

      foreach(player in level.players) {
        var_e59c38a3a9665cfb = player scripts\mp\utility\stats::getpersstat("team");

        if(!isDefined(var_e59c38a3a9665cfb)) {
          continue;
        }

        if(var_e59c38a3a9665cfb == "spectator" || var_e59c38a3a9665cfb == "codcaster") {
          player setplayerdata("common", "round", "scoreboardType", "allies");
          continue;
        }

        player setplayerdata("common", "round", "scoreboardType", var_e59c38a3a9665cfb);
      }
    } else {
      buildscoreboardtype(winner);

      foreach(player in level.players) {
        player setplayerdata("common", "round", "scoreboardType", winner);
      }
    }

    return;
  }

  buildscoreboardtype("neutral");

  foreach(player in level.players) {
    player setplayerdata("common", "round", "scoreboardType", "neutral");
  }

  if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
    setclientmatchdata("scoreProgressLimit", getomnvar("ui_scorelimit"));
    setclientmatchdata("alliesKills", -1);
    setclientmatchdata("alliesDeaths", -1);
  }
}

function processcommonplayerdataforplayer(player) {
  var_851e1b97814c1a58 = player scripts\mp\utility\stats::getpersstat("summary");

  if(isDefined(var_851e1b97814c1a58)) {
    player setplayerdata("common", "round", "totalXp", var_851e1b97814c1a58["xp"]);
    player setplayerdata("common", "round", "scoreXp", var_851e1b97814c1a58["score"]);
    player setplayerdata("common", "round", "challengeXp", var_851e1b97814c1a58["challenge"]);
    player setplayerdata("common", "round", "matchXp", var_851e1b97814c1a58["match"]);
    player setplayerdata("common", "round", "miscXp", var_851e1b97814c1a58["misc"]);
    player setplayerdata("common", "round", "medalXp", var_851e1b97814c1a58["medal"]);
    player setplayerdata("common", "common_entitlement_xp", var_851e1b97814c1a58["bonusXP"]);
  }

  var_97b1e872968f2e54 = player scripts\mp\utility\stats::getpersstat("aarData");

  if(isDefined(var_97b1e872968f2e54)) {
    player setplayerdata("common", "round", "aarData", "combat_xp", var_97b1e872968f2e54["combat_xp"]);
    player setplayerdata("common", "round", "aarData", "support_xp", var_97b1e872968f2e54["support_xp"]);
    player setplayerdata("common", "round", "aarData", "strategy_xp", var_97b1e872968f2e54["strategy_xp"]);
    player setplayerdata("common", "round", "aarData", "logistics_xp", var_97b1e872968f2e54["logistics_xp"]);
    player setplayerdata("common", "round", "aarData", "recon_xp", var_97b1e872968f2e54["recon_xp"]);
    player setplayerdata("common", "round", "aarData", "use_featured_operator_skin_xp", var_97b1e872968f2e54["use_featured_operator_skin_xp"]);
  }
}

function setplayerscoreboardinfo() {
  if(getdvarint(@ "online_mp_clientmatchdata_enabled") == 0) {
    return;
  }

  scoreboardplayercount = getclientmatchdata("scoreboardPlayerCount");

  if(scoreboardplayercount < 200) {
    if(isDefined(scripts\mp\utility\stats::getpersstat("score"))) {
      setclientmatchdata("players", self.clientmatchdataid, "score", scripts\mp\utility\stats::getpersstat("score"));
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x32>" + scripts\mp\utility\stats::getpersstat("<dev string:x41>"));
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("kills"))) {
      kills = scripts\mp\utility\stats::getpersstat("kills");
      setclientmatchdata("players", self.clientmatchdataid, "kills", kills);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x4a>" + kills);
    }

    if(getgametype() == "dm" || getgametype() == "gun") {
      assists = self.assists;
    } else if(isDefined(scripts\mp\utility\stats::getpersstat("assists"))) {
      assists = scripts\mp\utility\stats::getpersstat("assists");
    } else {
      assists = 0;
    }

    setclientmatchdata("players", self.clientmatchdataid, "assists", assists);
    println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x59>" + assists);

    if(isDefined(scripts\mp\utility\stats::getpersstat("deaths"))) {
      deaths = scripts\mp\utility\stats::getpersstat("deaths");
      setclientmatchdata("players", self.clientmatchdataid, "deaths", deaths);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x6a>" + deaths);
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("team"))) {
      team = scripts\mp\utility\stats::getpersstat("team");
      setclientmatchdata("players", self.clientmatchdataid, "team", team);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x7a>" + team);

      if(isDefined(game[team])) {
        faction = game[team];
        setclientmatchdata("players", self.clientmatchdataid, "faction", faction);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x88>" + faction);
      }
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("extrascore0"))) {
      extrascore0 = scripts\mp\utility\stats::getpersstat("extrascore0");
      setclientmatchdata("players", self.clientmatchdataid, "extrascore0", extrascore0);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x99>" + extrascore0);
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("extrascore1"))) {
      extrascore1 = scripts\mp\utility\stats::getpersstat("extrascore1");
      setclientmatchdata("players", self.clientmatchdataid, "extrascore1", extrascore1);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:xae>" + extrascore1);
    }

    if(isDefined(self.timeplayed["total"])) {
      timeplayed = self.timeplayed["total"];
      setclientmatchdata("players", self.clientmatchdataid, "timeplayed", timeplayed);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:xc3>" + timeplayed);
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("rank")) && isDefined(scripts\mp\utility\stats::getpersstat("rankxp"))) {
      rank = getrank();
      setclientmatchdata("players", self.clientmatchdataid, "rank", rank);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:xd7>" + rank);
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("prestige"))) {
      prestige = scripts\mp\rank::getprestigelevel();
      setclientmatchdata("players", self.clientmatchdataid, "prestige", prestige);
      println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:xe5>" + prestige);
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      var_7746ca3b56c9afd3 = scripts\mp\gametypes\br::calculateclientmatchdataextrainfopayload(self);
      assert(var_7746ca3b56c9afd3.size < 5);

      for(i = 0; i < var_7746ca3b56c9afd3.size; i++) {
        var_1abc650bb92e6e04 = "extrascore" + i;
        setclientmatchdata("players", self.clientmatchdataid, var_1abc650bb92e6e04, var_7746ca3b56c9afd3[i]);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:xf7>" + var_1abc650bb92e6e04 + "<dev string:xfe>" + var_7746ca3b56c9afd3[i]);
      }

      if(getsubgametype() == "risk" || getsubgametype() == "plunder") {
        placements = scripts\mp\gamescore::getteamscoreplacements();
        placement = placements[self.team];
        assert(isDefined(placement), "<dev string:x105>" + self.team);

        if(isDefined(placement)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", placement);
        }

        packedvalue = [[scripts\engine\utility::getsharedfunc("plunder", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", packedvalue);
        lootcachesopened = 0;

        if(isDefined(self.lootcachesopened)) {
          lootcachesopened = self.lootcachesopened;
        }

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", lootcachesopened);
      } else if(getsubgametype() == "kingslayer") {
        placements = scripts\mp\gamescore::getteamscoreplacements();
        placement = placements[self.team];
        setclientmatchdata("players", self.clientmatchdataid, "placement", placement);
        packedvalue = [[scripts\engine\utility::getsharedfunc("kingslayer", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", packedvalue);
        lootcachesopened = 0;

        if(isDefined(self.lootcachesopened)) {
          lootcachesopened = self.lootcachesopened;
        }

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", lootcachesopened);
      } else if(getsubgametype() == "resurgence") {
        if(isDefined(self.teamplacement)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);
        }

        packedvalue = [[scripts\engine\utility::getsharedfunc("resurgence", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", packedvalue);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x12f>" + packedvalue);
      } else if(getsubgametype() == "resurgence_mgl") {
        if(isDefined(self.teamplacement)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);
        }

        packedvalue = [[scripts\engine\utility::getsharedfunc("resurgence_mgl", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", packedvalue);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x12f>" + packedvalue);
      } else if(getsubgametype() == "champion") {
        if(isDefined(self.teamplacement)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);
        }

        packedvalue = [[scripts\engine\utility::getsharedfunc("champion", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", packedvalue);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x12f>" + packedvalue);
      } else if(getsubgametype() == "zonecontrol") {
        if(isDefined(self.teamplacement)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);
        }

        packedvalue = [[scripts\engine\utility::getsharedfunc("zonecontrol", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", packedvalue[0]);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x12f>" + packedvalue[0]);
        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", packedvalue[1]);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x146>" + packedvalue[1]);
      } else {
        if(isDefined(self.teamplacement)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);
        }

        packedvalue = [[scripts\engine\utility::getsharedfunc("br", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", packedvalue);
        println("<dev string:x1c>" + self.name + "<dev string:x2d>" + self.clientmatchdataid + "<dev string:x12f>" + packedvalue);
      }
    }

    println("<dev string:x15d>" + scoreboardplayercount);
    scoreboardplayercount++;
    setclientmatchdata("scoreboardPlayerCount", scoreboardplayercount);
    println("<dev string:x187>" + scoreboardplayercount);
    maxplayercount = getdvarint(@ "party_maxplayers", 0);
    setclientmatchdata("maxPlayerCount", maxplayercount);
    return;
  }

  println("<dev string:x1b1>" + scoreboardplayercount + "<dev string:x1eb>");
}

function computescoreboardslot(team, index) {
  if(team == "none") {
    return (0 + index);
  }

  if(team == "neutral") {
    return (200 + index);
  }

  if(team == "allies") {
    return (400 + index);
  }

  if(team == "axis") {
    return (600 + index);
  }

  if(team == "multiteam") {
    return (800 + index);
  }

  return 0;
}

function buildscoreboardtype(team) {
  if(getdvarint(@ "online_mp_clientmatchdata_enabled") == 0) {
    return;
  }

  assert(team == "<dev string:x1f0>" || team == "<dev string:x1fa>" || team == "<dev string:x202>" || team == "<dev string:x20d>");
  println("<dev string:x21a>" + team + "<dev string:x1eb>");

  if(team == "multiteam" || getsubgametype() == "rumble_mgl") {
    index = 0;

    foreach(teamname in level.teamnamelist) {
      teammembers = undefined;

      if(isDefined(level.placement)) {
        teammembers = level.placement[teamname];
      }

      if(!isDefined(teammembers)) {
        teammembers = scripts\mp\utility\teams::getteamdata(teamname, "players");
      }

      foreach(player in teammembers) {
        scripts\mp\gamelogic::assignclientmatchdataid(player);
        setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
        println("<dev string:x23f>" + team + "<dev string:x25d>" + index + "<dev string:x25d>" + player.clientmatchdataid + "<dev string:x263>");
        index++;
      }
    }

    return;
  }

  if(team == "neutral") {
    index = 0;

    foreach(player in level.placement["all"]) {
      setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
      println("<dev string:x23f>" + team + "<dev string:x25d>" + index + "<dev string:x25d>" + player.clientmatchdataid + "<dev string:x263>");
      index++;
    }

    return;
  }

  otherteam = getotherteam(team)[0];
  index = 0;

  foreach(player in level.placement[team]) {
    setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
    println("<dev string:x23f>" + team + "<dev string:x25d>" + index + "<dev string:x25d>" + player.name + "<dev string:x2d>" + player.clientmatchdataid + "<dev string:x268>");
    index++;
  }

  foreach(player in level.placement[otherteam]) {
    setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
    println("<dev string:x23f>" + team + "<dev string:x25d>" + index + "<dev string:x25d>" + player.name + "<dev string:x2d>" + player.clientmatchdataid + "<dev string:x268>");
    index++;
  }
}