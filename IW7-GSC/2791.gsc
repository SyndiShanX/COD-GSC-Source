/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2791.gsc
**************************************/

func_D9AB() {
  foreach(var_1 in level.placement["all"]) {
    var_1 func_F7F8();
  }

  if(level.multiteambased) {
    func_3219("multiteam");

    foreach(var_1 in level.players) {
      var_1 setrankedplayerdata("common", "round", "scoreboardType", "multiteam");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
    setclientmatchdata("alliesKills", -1);
    setclientmatchdata("alliesDeaths", -1);
  } else if(level.teambased) {
    var_5 = getteamscore("allies");
    var_6 = getteamscore("axis");
    var_7 = 0;
    var_8 = 0;

    foreach(var_1 in level.players) {
      if(isDefined(var_1.pers["team"]) && var_1.pers["team"] == "allies") {
        var_7 = var_7 + var_1.pers["kills"];
        var_8 = var_8 + var_1.pers["deaths"];
      }
    }

    var_11 = "tied";

    if(scripts\mp\utility\game::inovertime() && scripts\mp\utility\game::istimetobeatrulegametype()) {
      if(game["timeToBeatTeam"] == "none") {
        setclientmatchdata("alliesTTB", 0);
        setclientmatchdata("axisTTB", 0);
        var_11 = "tied";
      } else {
        if("allies" == game["timeToBeatTeam"]) {
          var_5++;
        } else {
          var_6++;
        }

        setclientmatchdata("alliesTTB", scripts\engine\utility::ter_op("allies" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        setclientmatchdata("axisTTB", scripts\engine\utility::ter_op("axis" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        var_11 = game["timeToBeatTeam"];
      }
    } else if(var_5 == var_6) {
      var_11 = "tied";
    } else if(var_5 > var_6) {
      var_11 = "allies";
    } else {
      var_11 = "axis";
    }

    setclientmatchdata("alliesScore", var_5);
    setclientmatchdata("axisScore", var_6);
    setclientmatchdata("alliesKills", var_7);
    setclientmatchdata("alliesDeaths", var_8);

    if(var_11 == "tied") {
      func_3219("allies");
      func_3219("axis");

      foreach(var_1 in level.players) {
        var_13 = var_1.pers["team"];

        if(!isDefined(var_13)) {
          continue;
        }
        if(var_13 == "spectator") {
          var_1 setrankedplayerdata("common", "round", "scoreboardType", "allies");
          continue;
        }

        var_1 setrankedplayerdata("common", "round", "scoreboardType", var_13);
      }
    } else {
      func_3219(var_11);

      foreach(var_1 in level.players) {
        var_1 setrankedplayerdata("common", "round", "scoreboardType", var_11);
      }
    }
  } else {
    func_3219("neutral");

    foreach(var_1 in level.players) {
      var_1 setrankedplayerdata("common", "round", "scoreboardType", "neutral");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
    setclientmatchdata("alliesKills", -1);
    setclientmatchdata("alliesDeaths", -1);
  }

  foreach(var_1 in level.players) {
    var_1 setrankedplayerdata("common", "round", "totalXp", var_1.pers["summary"]["xp"]);
    var_1 setrankedplayerdata("common", "round", "scoreXp", var_1.pers["summary"]["score"]);
    var_1 setrankedplayerdata("common", "round", "challengeXp", var_1.pers["summary"]["challenge"]);
    var_1 setrankedplayerdata("common", "round", "matchXp", var_1.pers["summary"]["match"]);
    var_1 setrankedplayerdata("common", "round", "miscXp", var_1.pers["summary"]["misc"]);
    var_1 setrankedplayerdata("common", "round", "medalXp", var_1.pers["summary"]["medal"]);
    var_1 setrankedplayerdata("common", "common_entitlement_xp", var_1.pers["summary"]["bonusXP"]);
  }
}

func_F7F8() {
  var_0 = getclientmatchdata("scoreboardPlayerCount");

  if(var_0 <= 24) {
    setclientmatchdata("players", self.clientmatchdataid, "score", self.pers["score"]);
    var_1 = self.pers["kills"];
    setclientmatchdata("players", self.clientmatchdataid, "kills", var_1);

    if(level.gametype == "dm" || level.gametype == "gun") {
      var_2 = self.assists;
    } else {
      var_2 = self.pers["assists"];
    }

    setclientmatchdata("players", self.clientmatchdataid, "assists", var_2);
    var_3 = self.pers["deaths"];
    setclientmatchdata("players", self.clientmatchdataid, "deaths", var_3);
    var_4 = self.pers["team"];
    setclientmatchdata("players", self.clientmatchdataid, "team", var_4);
    var_5 = game[self.pers["team"]];
    setclientmatchdata("players", self.clientmatchdataid, "faction", var_5);
    var_6 = self.pers["extrascore0"];
    setclientmatchdata("players", self.clientmatchdataid, "extrascore0", var_6);
    var_7 = self.pers["extrascore1"];
    setclientmatchdata("players", self.clientmatchdataid, "extrascore1", var_7);
    var_8 = self.timeplayed["total"];
    setclientmatchdata("players", self.clientmatchdataid, "timeplayed", var_8);
    var_9 = scripts\mp\rank::getrank();
    setclientmatchdata("players", self.clientmatchdataid, "rank", var_9);
    var_10 = scripts\mp\rank::detachshieldmodel();
    setclientmatchdata("players", self.clientmatchdataid, "prestige", var_10);
    var_0++;
    setclientmatchdata("scoreboardPlayerCount", var_0);
  }
}

computescoreboardslot(var_0, var_1) {
  if(var_0 == "none") {
    return 0 + var_1;
  }

  if(var_0 == "neutral") {
    return 24 + var_1;
  }

  if(var_0 == "allies") {
    return 48 + var_1;
  }

  if(var_0 == "axis") {
    return 72 + var_1;
  }

  if(var_0 == "multiteam") {
    return 96 + var_1;
  }

  return 0;
}

func_3219(var_0) {
  if(var_0 == "multiteam") {
    var_1 = 0;

    foreach(var_3 in level.teamnamelist) {
      foreach(var_5 in level.placement[var_3]) {
        setclientmatchdata("scoreboards", computescoreboardslot("multiteam", var_1), var_5.clientmatchdataid);
        var_1++;
      }
    }
  } else if(var_0 == "neutral") {
    var_1 = 0;

    foreach(var_5 in level.placement["all"]) {
      setclientmatchdata("scoreboards", computescoreboardslot(var_0, var_1), var_5.clientmatchdataid);
      var_1++;
    }
  } else {
    var_10 = scripts\mp\utility\game::getotherteam(var_0);
    var_1 = 0;

    foreach(var_5 in level.placement[var_0]) {
      setclientmatchdata("scoreboards", computescoreboardslot(var_0, var_1), var_5.clientmatchdataid);
      var_1++;
    }

    foreach(var_5 in level.placement[var_10]) {
      setclientmatchdata("scoreboards", computescoreboardslot(var_0, var_1), var_5.clientmatchdataid);
      var_1++;
    }
  }
}