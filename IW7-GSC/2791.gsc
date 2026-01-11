/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2791.gsc
***************************************/

func_D9AB() {
  foreach(var_01 in level.placement["all"]) {
    var_01 func_F7F8();
  }

  if(level.multiteambased) {
    func_3219("multiteam");

    foreach(var_01 in level.players) {
      var_01 setrankedplayerdata("common", "round", "scoreboardType", "multiteam");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
    setclientmatchdata("alliesKills", -1);
    setclientmatchdata("alliesDeaths", -1);
  } else if(level.teambased) {
    var_05 = getteamscore("allies");
    var_06 = getteamscore("axis");
    var_07 = 0;
    var_08 = 0;

    foreach(var_01 in level.players) {
      if(isDefined(var_1.pers["team"]) && var_1.pers["team"] == "allies") {
        var_07 = var_07 + var_1.pers["kills"];
        var_08 = var_08 + var_1.pers["deaths"];
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
    } else if(var_05 == var_06)
      var_11 = "tied";
    else if(var_05 > var_06) {
      var_11 = "allies";
    } else {
      var_11 = "axis";
    }

    setclientmatchdata("alliesScore", var_05);
    setclientmatchdata("axisScore", var_06);
    setclientmatchdata("alliesKills", var_07);
    setclientmatchdata("alliesDeaths", var_08);

    if(var_11 == "tied") {
      func_3219("allies");
      func_3219("axis");

      foreach(var_01 in level.players) {
        var_13 = var_1.pers["team"];

        if(!isDefined(var_13)) {
          continue;
        }
        if(var_13 == "spectator") {
          var_01 setrankedplayerdata("common", "round", "scoreboardType", "allies");
          continue;
        }

        var_01 setrankedplayerdata("common", "round", "scoreboardType", var_13);
      }
    } else {
      func_3219(var_11);

      foreach(var_01 in level.players) {
        var_01 setrankedplayerdata("common", "round", "scoreboardType", var_11);
      }
    }
  } else {
    func_3219("neutral");

    foreach(var_01 in level.players) {
      var_01 setrankedplayerdata("common", "round", "scoreboardType", "neutral");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
    setclientmatchdata("alliesKills", -1);
    setclientmatchdata("alliesDeaths", -1);
  }

  foreach(var_01 in level.players) {
    var_01 setrankedplayerdata("common", "round", "totalXp", var_1.pers["summary"]["xp"]);
    var_01 setrankedplayerdata("common", "round", "scoreXp", var_1.pers["summary"]["score"]);
    var_01 setrankedplayerdata("common", "round", "challengeXp", var_1.pers["summary"]["challenge"]);
    var_01 setrankedplayerdata("common", "round", "matchXp", var_1.pers["summary"]["match"]);
    var_01 setrankedplayerdata("common", "round", "miscXp", var_1.pers["summary"]["misc"]);
    var_01 setrankedplayerdata("common", "round", "medalXp", var_1.pers["summary"]["medal"]);
    var_01 setrankedplayerdata("common", "common_entitlement_xp", var_1.pers["summary"]["bonusXP"]);
  }
}

func_F7F8() {
  var_00 = getclientmatchdata("scoreboardPlayerCount");

  if(var_00 <= 24) {
    setclientmatchdata("players", self.clientmatchdataid, "score", self.pers["score"]);
    var_01 = self.pers["kills"];
    setclientmatchdata("players", self.clientmatchdataid, "kills", var_01);

    if(level.gametype == "dm" || level.gametype == "gun") {
      var_02 = self.assists;
    } else {
      var_02 = self.pers["assists"];
    }

    setclientmatchdata("players", self.clientmatchdataid, "assists", var_02);
    var_03 = self.pers["deaths"];
    setclientmatchdata("players", self.clientmatchdataid, "deaths", var_03);
    var_04 = self.pers["team"];
    setclientmatchdata("players", self.clientmatchdataid, "team", var_04);
    var_05 = game[self.pers["team"]];
    setclientmatchdata("players", self.clientmatchdataid, "faction", var_05);
    var_06 = self.pers["extrascore0"];
    setclientmatchdata("players", self.clientmatchdataid, "extrascore0", var_06);
    var_07 = self.pers["extrascore1"];
    setclientmatchdata("players", self.clientmatchdataid, "extrascore1", var_07);
    var_08 = self.timeplayed["total"];
    setclientmatchdata("players", self.clientmatchdataid, "timeplayed", var_08);
    var_09 = scripts\mp\rank::getrank();
    setclientmatchdata("players", self.clientmatchdataid, "rank", var_09);
    var_10 = scripts\mp\rank::detachshieldmodel();
    setclientmatchdata("players", self.clientmatchdataid, "prestige", var_10);
    var_0++;
    setclientmatchdata("scoreboardPlayerCount", var_00);
  } else {}
}

computescoreboardslot(var_00, var_01) {
  if(var_00 == "none") {
    return 0 + var_01;
  }

  if(var_00 == "neutral") {
    return 24 + var_01;
  }

  if(var_00 == "allies") {
    return 48 + var_01;
  }

  if(var_00 == "axis") {
    return 72 + var_01;
  }

  if(var_00 == "multiteam") {
    return 96 + var_01;
  }

  return 0;
}

func_3219(var_00) {
  if(var_00 == "multiteam") {
    var_01 = 0;

    foreach(var_03 in level.teamnamelist) {
      foreach(var_05 in level.placement[var_03]) {
        setclientmatchdata("scoreboards", computescoreboardslot("multiteam", var_01), var_5.clientmatchdataid);
        var_1++;
      }
    }
  } else if(var_00 == "neutral") {
    var_01 = 0;

    foreach(var_05 in level.placement["all"]) {
      setclientmatchdata("scoreboards", computescoreboardslot(var_00, var_01), var_5.clientmatchdataid);
      var_1++;
    }
  } else {
    var_10 = scripts\mp\utility\game::getotherteam(var_00);
    var_01 = 0;

    foreach(var_05 in level.placement[var_00]) {
      setclientmatchdata("scoreboards", computescoreboardslot(var_00, var_01), var_5.clientmatchdataid);
      var_1++;
    }

    foreach(var_05 in level.placement[var_10]) {
      setclientmatchdata("scoreboards", computescoreboardslot(var_00, var_01), var_5.clientmatchdataid);
      var_1++;
    }
  }
}