/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\scoreboard.gsc
***********************************************/

function processlobbyscoreboards() {
  ref_128b0();

  foreach(var1 in level.players) {
    ref_128a8(var1);
  }
}

function ref_128b0() {
  if(level.multiteambased) {
    buildscoreboardtype("multiteam");

    foreach(var1 in level.players) {
      var1 setplayerdata("common", "round", "scoreboardType", "multiteam");
    }

    if(getdvarint("MTKSQRQLKN") != 0) {
      setclientmatchdata("alliesScore", -1);
      setclientmatchdata("axisScore", -1);
      setclientmatchdata("alliesKills", -1);
      setclientmatchdata("alliesDeaths", -1);
      return;
    }

    return;
  }

  if(level.teambased) {
    var3 = getteamscore("allies");
    var4 = getteamscore("axis");
    var5 = 0;
    var6 = 0;

    foreach(var1 in level.players) {
      if(isDefined(var1.pers["team"]) && var1.pers["team"] == "allies") {
        var5 += var1.pers["kills"];
        var6 += var1.pers["deaths"];
      }
    }

    var9 = "tie";

    if(scripts\mp\utility\game::inovertime()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        if(game["timeToBeatTeam"] == "none") {
          if(getdvarint("MTKSQRQLKN") != 0) {
            setclientmatchdata("alliesTTB", 0);
            setclientmatchdata("axisTTB", 0);
          }

          var9 = "tie";
        } else {
          if("allies" == game["timeToBeatTeam"]) {
            var3++;
          } else {
            var4++;
          }

          if(getdvarint("MTKSQRQLKN") != 0) {
            setclientmatchdata("alliesTTB", scripts\engine\utility::ter_op("allies" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
            setclientmatchdata("axisTTB", scripts\engine\utility::ter_op("axis" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          }

          var9 = game["timeToBeatTeam"];
        }
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {}
    } else if(var3 == var4) {
      var9 = "tie";
    } else if(var3 > var4) {
      var9 = "allies";
    } else {
      var9 = "axis";
    }

    if(getdvarint("MTKSQRQLKN") != 0) {
      setclientmatchdata("alliesScore", var3);
      setclientmatchdata("axisScore", var4);
      setclientmatchdata("alliesKills", var5);
      setclientmatchdata("alliesDeaths", var6);
    }

    if(var9 == "tie") {
      buildscoreboardtype("allies");
      buildscoreboardtype("axis");

      foreach(var1 in level.players) {
        var11 = var1.pers["team"];

        if(!isDefined(var11)) {
          continue;
        }

        if(var11 == "spectator" || var11 == "follower") {
          var1 setplayerdata("common", "round", "scoreboardType", "allies");
          continue;
        }

        var1 setplayerdata("common", "round", "scoreboardType", var11);
      }

      return;
    }

    buildscoreboardtype(var9);

    foreach(var1 in level.players) {
      var1 setplayerdata("common", "round", "scoreboardType", var9);
    }

    return;
  }

  buildscoreboardtype("neutral");

  foreach(var1 in level.players) {
    var1 setplayerdata("common", "round", "scoreboardType", "neutral");
  }

  if(getdvarint("MTKSQRQLKN") != 0) {
    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
    setclientmatchdata("alliesKills", -1);
    setclientmatchdata("alliesDeaths", -1);
    return;
  }
}

function ref_128a8(var0) {
  if(isDefined(var0.pers["summary"])) {
    var0 setplayerdata("common", "round", "totalXp", var0.pers["summary"]["xp"]);
    var0 setplayerdata("common", "round", "scoreXp", var0.pers["summary"]["score"]);
    var0 setplayerdata("common", "round", "challengeXp", var0.pers["summary"]["challenge"]);
    var0 setplayerdata("common", "round", "matchXp", var0.pers["summary"]["match"]);
    var0 setplayerdata("common", "round", "miscXp", var0.pers["summary"]["misc"]);
    var0 setplayerdata("common", "round", "medalXp", var0.pers["summary"]["medal"]);
    var0 setplayerdata("common", "common_entitlement_xp", var0.pers["summary"]["bonusXP"]);
    return;
  }
}

function setplayerscoreboardinfo() {
  if(getdvarint("MTKSQRQLKN") == 0) {
    return;
  }

  var0 = getclientmatchdata("scoreboardPlayerCount");

  if(var0 < 200) {
    if(isDefined(self.pers["score"])) {
      setclientmatchdata("players", self.clientmatchdataid, "score", self.pers["score"]);
    }

    if(isDefined(self.pers["kills"])) {
      var1 = self.pers["kills"];
      setclientmatchdata("players", self.clientmatchdataid, "kills", var1);
    }

    if(scripts\mp\utility\game::getgametype() == "dm" || scripts\mp\utility\game::getgametype() == "gun") {
      var2 = self.assists;
    } else if(isDefined(self.pers["assists"])) {
      var2 = self.pers["assists"];
    } else {
      var2 = 0;
    }

    setclientmatchdata("players", self.clientmatchdataid, "assists", var2);

    if(isDefined(self.pers["deaths"])) {
      var3 = self.pers["deaths"];
      setclientmatchdata("players", self.clientmatchdataid, "deaths", var3);
    }

    if(isDefined(self.pers["team"])) {
      var4 = self.pers["team"];
      setclientmatchdata("players", self.clientmatchdataid, "team", var4);

      if(isDefined(game[self.pers["team"]])) {
        var5 = game[self.pers["team"]];
        setclientmatchdata("players", self.clientmatchdataid, "faction", var5);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "br") {
      if(isDefined(self.playercardbackground)) {
        var6 = self.playercardbackground;
        setclientmatchdata("players", self.clientmatchdataid, "extrascore0", var6);
      }
    } else if(isDefined(self.pers["extrascore0"])) {
      var7 = self.pers["extrascore0"];
      setclientmatchdata("players", self.clientmatchdataid, "extrascore0", var7);
    }

    if(isDefined(self.pers["extrascore1"])) {
      var8 = self.pers["extrascore1"];
      setclientmatchdata("players", self.clientmatchdataid, "extrascore1", var8);
    }

    if(isDefined(self.timeplayed["total"])) {
      var9 = self.timeplayed["total"];
      setclientmatchdata("players", self.clientmatchdataid, "timeplayed", var9);
    }

    if(isDefined(self.pers["rank"]) && isDefined(self.pers["rankxp"])) {
      var10 = scripts\mp\rank::getrank();
      setclientmatchdata("players", self.clientmatchdataid, "rank", var10);
    }

    if(isDefined(self.pers["prestige"])) {
      var11 = scripts\mp\rank::getprestigelevel();
      setclientmatchdata("players", self.clientmatchdataid, "prestige", var11);
    }

    if(scripts\mp\utility\game::getgametype() == "br") {
      var12 = scripts\mp\gametypes\br::forest_barrel_damage_watch(self);

      for(var13 = 0; var13 < var12.size; var13++) {
        var14 = "extrascore" + var13;
        setclientmatchdata("players", self.clientmatchdataid, var14, var12[var13]);
      }

      var15 = scripts\mp\utility\game::round_vehicle_logic();

      if(var15 == "dmz" || var15 == "rat_race" || var15 == "risk" || var15 == "gold_war") {
        var16 = scripts\mp\gamescore::run_common_functions_stealth();
        var17 = var16[self.team];
        setclientmatchdata("players", self.clientmatchdataid, "placement", var17);
        var18 = scripts\mp\gametypes\br_gametype_dmz::ref_121b4();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var18);
        var19 = 0;

        if(isDefined(self.ref_11a01)) {
          var19 = self.ref_11a01;
        }

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", var19);
      } else if(var15 == "kingslayer") {
        var16 = scripts\mp\gamescore::run_common_functions_stealth();
        var17 = var16[self.team];
        setclientmatchdata("players", self.clientmatchdataid, "placement", var17);
        var18 = scripts\mp\gametypes\br_gametype_kingslayer::ref_121b4();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var18);
        var19 = 0;

        if(isDefined(self.ref_11a01)) {
          var19 = self.ref_11a01;
        }

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", var19);
      } else if(var15 == "treasure_hunt") {
        if(isDefined(self.ref_13ab8)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.ref_13ab8);
        }

        var18 = scripts\mp\gametypes\br_gametype_treasure_hunt::ref_121b2();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var18);
      } else if(var15 == "rebirth" || var15 == "rebirth_dbd") {
        if(isDefined(self.ref_13ab8)) {
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.ref_13ab8);
        }

        var18 = scripts\mp\gametypes\br_gametype_rebirth::end_health();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", var18);
      } else if(var15 == "rebirth_reverse" || var15 == "rebirth_dbd_reverse") {} else if(isDefined(self.ref_13ab8)) {
        setclientmatchdata("players", self.clientmatchdataid, "placement", self.ref_13ab8);
      }
    }

    var2++;
    setclientmatchdata("scoreboardPlayerCount", var2);
    return;
  }
}

function computescoreboardslot(var0, var1) {
  if(var0 == "none") {
    return (0 + var1);
  }

  if(var0 == "neutral") {
    return (200 + var1);
  }

  if(var0 == "allies") {
    return (400 + var1);
  }

  if(var0 == "axis") {
    return (600 + var1);
  }

  if(var0 == "multiteam") {
    return (800 + var1);
  }

  return 0;
}

function buildscoreboardtype(var0) {
  if(getdvarint("MTKSQRQLKN") == 0) {
    return;
  }

  if(var0 == "multiteam") {
    var1 = 0;

    foreach(var3 in level.teamnamelist) {
      if(scripts\mp\menus::shouldmodesetsquads()) {
        foreach(var5 in level.squaddata[var3]) {
          if(!var5.inuse) {
            continue;
          }

          var6 = undefined;

          if(isDefined(level.placement) && isDefined(level.placement[var3])) {
            var6 = level.placement[var3][var5.index];
          }

          if(!isDefined(var6)) {
            var6 = var5.players;
          }

          foreach(var8 in var5.players) {
            scripts\mp\gamelogic::cargo_truck_mg_explode(var8);
            setclientmatchdata("scoreboards", computescoreboardslot("multiteam", var1), var8.clientmatchdataid);
            var1++;
          }
        }

        continue;
      }

      var6 = undefined;

      if(isDefined(level.placement)) {
        var6 = level.placement[var3];
      }

      if(!isDefined(var6)) {
        var6 = scripts\mp\utility\teams::getteamdata(var3, "players");
      }

      foreach(var8 in var6) {
        scripts\mp\gamelogic::cargo_truck_mg_explode(var8);
        setclientmatchdata("scoreboards", computescoreboardslot("multiteam", var1), var8.clientmatchdataid);
        var1++;
      }
    }

    return;
  }

  jumpiffalse(var8 == "neutral") LOC_000001e1;
  var1 = 0;

  foreach(var8 in level.placement["all"]) {
    setclientmatchdata("scoreboards", computescoreboardslot(var8, var1), var8.clientmatchdataid);
    var1++;
  }

  return;
}