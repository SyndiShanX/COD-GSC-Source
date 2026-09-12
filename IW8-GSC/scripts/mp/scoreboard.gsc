/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\scoreboard.gsc
***********************************************/

function processlobbyscoreboards() {
  ref_128B0();

  foreach(var_1 in level.players) {
    ref_128A8(var_1);
  }
}

function ref_128B0() {
  if(level.multiteambased) {
    buildscoreboardtype("multiteam");

    foreach(var_1 in level.players) {
      var_1 setplayerdata("common", "round", "scoreboardType", "multiteam");
    }

    if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
      setclientmatchdata("alliesScore", -1);
      setclientmatchdata("axisScore", -1);
      setclientmatchdata("alliesKills", -1);
      setclientmatchdata("alliesDeaths", -1);
      return;
    }

    return;
  }

  if(level.teambased) {
    var_3 = getteamscore("allies");
    var_4 = getteamscore("axis");
    var_5 = 0;
    var_6 = 0;

    foreach(var_1 in level.players) {
      if(isDefined(var_1.pers["team"]) && var_1.pers["team"] == "allies") {
        var_5 += var_1.pers["kills"];
        var_6 += var_1.pers["deaths"];
      }
    }

    var_9 = "tie";

    if(scripts\mp\utility\game::inovertime()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        if(game["timeToBeatTeam"] == "none") {
          if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
            setclientmatchdata("alliesTTB", 0);
            setclientmatchdata("axisTTB", 0);
          }

          var_9 = "tie";
        } else {
          if("allies" == game["timeToBeatTeam"]) {
            var_3++;
          } else {
            var_4++;
          }

          if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
            setclientmatchdata("alliesTTB", scripts\engine\utility::ter_op("allies" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
            setclientmatchdata("axisTTB", scripts\engine\utility::ter_op("axis" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          }

          var_9 = game["timeToBeatTeam"];
        }
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {}
    } else if(var_3 == var_4) {
      var_9 = "tie";
    } else if(var_3 > var_4) {
      var_9 = "allies";
    } else {
      var_9 = "axis";
    }

    if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
      setclientmatchdata("alliesScore", var_3);
      setclientmatchdata("axisScore", var_4);
      setclientmatchdata("alliesKills", var_5);
      setclientmatchdata("alliesDeaths", var_6);
    }

    if(var_9 == "tie") {
      buildscoreboardtype("allies");
      buildscoreboardtype("axis");

      foreach(var_1 in level.players) {
        var_11 = var_1.pers["team"];

        if(!isDefined(var_11)) {
          continue;
        }

        if(var_11 == "spectator" || var_11 == "follower") {
          var_1 setplayerdata("common", "round", "scoreboardType", "allies");
          continue;
        }

        var_1 setplayerdata("common", "round", "scoreboardType", var_11);
      }

      return;
    }

    buildscoreboardtype(var_9);

    foreach(var_1 in level.players) {
      var_1 setplayerdata("common", "round", "scoreboardType", var_9);
    }

    return;
  }

  buildscoreboardtype("neutral");

  foreach(var_1 in level.players) {
    var_1 setplayerdata("common", "round", "scoreboardType", "neutral");
  }

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
    setclientmatchdata("alliesKills", -1);
    setclientmatchdata("alliesDeaths", -1);
    return;
  }
}

function ref_128A8(var_0) {
  if(isDefined(var_0.pers["summary"])) {
    var_0 setplayerdata("common", "round", "totalXp", var_0.pers["summary"]["xp"]);
    var_0 setplayerdata("common", "round", "scoreXp", var_0.pers["summary"]["score"]);
    var_0 setplayerdata("common", "round", "challengeXp", var_0.pers["summary"]["challenge"]);
    var_0 setplayerdata("common", "round", "matchXp", var_0.pers["summary"]["match"]);
    var_0 setplayerdata("common", "round", "miscXp", var_0.pers["summary"]["misc"]);
    var_0 setplayerdata("common", "round", "medalXp", var_0.pers["summary"]["medal"]);
    var_0 setplayerdata("common", "common_entitlement_xp", var_0.pers["summary"]["bonusXP"]);
    return;
  }
}

function setplayerscoreboardinfo() {
  if(getdvarint("online_mp_clientmatchdata_enabled") == 0) {
    return;
  }

  var_0 = getclientmatchdata("scoreboardPlayerCount");

  if(var_0 < 200) {
    if(isDefined(self.pers["score"])) {
      setclientmatchdata("players", self.clientmatchdataid, "score", self.pers["score"]);
    }

    if(isDefined(self.pers["kills"])) {
      var_1 = self.pers["kills"];
      setclientmatchdata("players", self.clientmatchdataid, "kills", var_1);
    }

    if(scripts\mp\utility\game::getgametype() == "dm" || scripts\mp\utility\game::getgametype() == "gun") {
      var_2 = self.assists;
    } else if(isDefined(self.pers["assists"])) {
      var_2 = self.pers["assists"];
    } else {
      var_2 = 0;
    }

    setclientmatchdata("players", self.clientmatchdataid, "assists", var_2);

    if(isDefined(self.pers["deaths"])) {
      var_3 = self.pers["deaths"];
      setclientmatchdata("players", self.clientmatchdataid, "deaths", var_3);
    }

    if(isDefined(self.pers["team"])) {
      var_4 = self.pers["team"];
      setclientmatchdata("players", self.clientmatchdataid, "team", var_4);

      if(isDefined(game[self.pers["team"]])) {
        var_5 = game[self.pers["team"]];
        setclientmatchdata("players", self.clientmatchdataid, "faction", var_5);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "br") {
      if(isDefined(self.playercardbackground)) {
        var_6 = self.playercardbackground;
        setclientmatchdata("players", self.clientmatchdataid, "extrascore0", var_6);
      }
    } else if(isDefined(self.pers["extrascore0"])) {
      var_7 = self.pers["extrascore0"];
      setclientmatchdata("players", self.clientmatchdataid, "extrascore0", var_7);
    }

    if(isDefined(self.pers["extrascore1"])) {
      var_8 = self.pers["extrascore1"];
      setclientmatchdata("players", self.clientmatchdataid, "extrascore1", var_8);
    }

    if(isDefined(self.timeplayed["total"])) {
      var_9 = self.timeplayed["total"];
      setclientmatchdata("players", self.clientmatchdataid, "timeplayed", var_9);
    }

    if(isDefined(self.pers["rank"]) && isDefined(self.pers["rankxp"])) {
      var_10 = scripts\mp\rank::getrank();
      setclientmatchdata("players", self.clientmatchdataid, "rank", var_10);
    }

    if(isDefined(self.pers["prestige"])) {
      var_11 = scripts\mp\rank::getprestigelevel();
      setclientmatchdata("players", self.clientmatchdataid, "prestige", var_11);
    }

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_12 = scripts\mp\gametypes\br::forest_barrel_damage_watch(self);

      for(var_13 = 0; var_13 < var_12.size; var_13++) {
        var_14 = "extrascore" + var_13;
        setclientmatchdata("players", self.clientmatchdataid, var_14, var_12[var_13]);
      }

      var_15 = scripts\mp\utility\game::round_vehicle_logic();

      if(var_15 == "dmz" || var_15 == "rat_race" || var_15 == "risk" || var_15 == "gold_war") {
        var_16 = scripts\mp\gamescore::run_common_functions_stealth();
        var_17 = var_16[self.team];
        setclientmatchdata("players", self.clientmatchdataid, "placement", var_17);
        var_18 = scripts\mp\gametypes\br_gametype_dmz::ref_121B4();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var_18);
        var_19 = 0;

        if(isDefined(self.ref_11A01)) {
          var_19 = self.ref_11A01;
        }

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", var_19);
      } else if(var_15 == "kingslayer") {
        var_16 = scripts\mp\gamescore::run_common_functions_stealth();
        var_17 = var_16[self.team];
        setclientmatchdata("players", self.clientmatchdataid, "placement", var_17);
        var_18 = scripts\mp\gametypes\br_gametype_kingslayer::ref_121B4();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var_18);
        var_19 = 0;

        if(isDefined(self.ref_11A01)) {
          var_19 = self.ref_11A01;
        }

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", var_19);
      } else if(var_15 == "treasure_hunt") {
        if(isDefined(self.ref_13AB8)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.ref_13AB8);
        }

        var_18 = scripts\mp\gametypes\br_gametype_treasure_hunt::ref_121B2();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var_18);
      } else if(var_15 == "rebirth" || var_15 == "rebirth_dbd") {
        if(isDefined(self.ref_13AB8)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.ref_13AB8);
        }

        var_18 = scripts\mp\gametypes\br_gametype_rebirth::end_health();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var_18);
      } else if(var_15 == "rebirth_reverse" || var_15 == "rebirth_dbd_reverse") {} else if(isDefined(self.ref_13AB8)) {
        setclientmatchdata("players", self.clientmatchdataid, "placement", self.ref_13AB8);
      }
    }

    var_2++;
    setclientmatchdata("scoreboardPlayerCount", var_2);
    return;
  }
}

function computescoreboardslot(var_0, var_1) {
  if(var_0 == "none") {
    return (0 + var_1);
  }

  if(var_0 == "neutral") {
    return (200 + var_1);
  }

  if(var_0 == "allies") {
    return (400 + var_1);
  }

  if(var_0 == "axis") {
    return (600 + var_1);
  }

  if(var_0 == "multiteam") {
    return (800 + var_1);
  }

  return 0;
}

function buildscoreboardtype(var_0) {
  if(getdvarint("online_mp_clientmatchdata_enabled") == 0) {
    return;
  }

  if(var_0 == "multiteam") {
    var_1 = 0;

    foreach(var_3 in level.teamnamelist) {
      if(scripts\mp\menus::shouldmodesetsquads()) {
        foreach(var_5 in level.squaddata[var_3]) {
          if(!var_5.inuse) {
            continue;
          }

          var_6 = undefined;

          if(isDefined(level.placement) && isDefined(level.placement[var_3])) {
            var_6 = level.placement[var_3][var_5.index];
          }

          if(!isDefined(var_6)) {
            var_6 = var_5.players;
          }

          foreach(var_8 in var_5.players) {
            scripts\mp\gamelogic::cargo_truck_mg_explode(var_8);
            setclientmatchdata("scoreboards", computescoreboardslot("multiteam", var_1), var_8.clientmatchdataid);
            var_1++;
          }
        }

        continue;
      }

      var_6 = undefined;

      if(isDefined(level.placement)) {
        var_6 = level.placement[var_3];
      }

      if(!isDefined(var_6)) {
        var_6 = scripts\mp\utility\teams::getteamdata(var_3, "players");
      }

      foreach(var_8 in var_6) {
        scripts\mp\gamelogic::cargo_truck_mg_explode(var_8);
        setclientmatchdata("scoreboards", computescoreboardslot("multiteam", var_1), var_8.clientmatchdataid);
        var_1++;
      }
    }

    return;
  }

  jumpiffalse(var_8 == "neutral") LOC_000001e1;
  var_1 = 0;

  foreach(var_8 in level.placement["all"]) {
    setclientmatchdata("scoreboards", computescoreboardslot(var_8, var_1), var_8.clientmatchdataid);
    var_1++;
  }

  return;
}