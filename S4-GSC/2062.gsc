/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2062.gsc
*************************************************/

_id_BD75() {
  if(level._id_A2FC) {
    _id_2D0A("multiteam");

    foreach(var_1 in level.players) {
      var_1 setplayerdata("common", "round", "scoreboardType", "multiteam");
    }

    if(getdvarint("#x36325d0d09e7e5310") != 0) {
      setclientmatchdata("alliesScore", -1);
      setclientmatchdata("axisScore", -1);
      setclientmatchdata("alliesKills", -1);
      setclientmatchdata("alliesDeaths", -1);
    }
  } else if(level.teambased) {
    var_3 = _func_00DB("allies");
    var_4 = _func_00DB("axis");
    var_5 = 0;
    var_6 = 0;

    foreach(var_1 in level.players) {
      if(isDefined(var_1.pers["team"]) && var_1.pers["team"] == "allies") {
        var_5 = var_5 + var_1.pers["kills"];
        var_6 = var_6 + var_1.pers["deaths"];
      }
    }

    var_9 = "tie";

    if(scripts\mp\utility\game::_id_82D1()) {
      if(scripts\mp\utility\game::_id_8AA1()) {
        if(game["timeToBeatTeam"] == "none") {
          if(getdvarint("#x36325d0d09e7e5310") != 0) {
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

          if(getdvarint("#x36325d0d09e7e5310") != 0) {
            setclientmatchdata("alliesTTB", scripts\engine\utility::ter_op("allies" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
            setclientmatchdata("axisTTB", scripts\engine\utility::ter_op("axis" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          }

          var_9 = game["timeToBeatTeam"];
        }
      } else if(scripts\mp\utility\game::_id_8A16()) {}
    } else if(var_3 == var_4)
      var_9 = "tie";
    else if(var_3 > var_4) {
      var_9 = "allies";
    } else {
      var_9 = "axis";
    }

    if(getdvarint("#x36325d0d09e7e5310") != 0) {
      setclientmatchdata("alliesScore", var_3);
      setclientmatchdata("axisScore", var_4);
      setclientmatchdata("alliesKills", var_5);
      setclientmatchdata("alliesDeaths", var_6);
    }

    if(var_9 == "tie") {
      _id_2D0A("allies");
      _id_2D0A("axis");

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
    } else {
      _id_2D0A(var_9);

      foreach(var_1 in level.players) {
        var_1 setplayerdata("common", "round", "scoreboardType", var_9);
      }
    }
  } else {
    _id_2D0A("neutral");

    foreach(var_1 in level.players) {
      var_1 setplayerdata("common", "round", "scoreboardType", "neutral");
    }

    if(getdvarint("#x36325d0d09e7e5310") != 0) {
      setclientmatchdata("alliesScore", -1);
      setclientmatchdata("axisScore", -1);
      setclientmatchdata("alliesKills", -1);
      setclientmatchdata("alliesDeaths", -1);
    }
  }

  if(getdvarint("#x36325d0d09e7e5310") != 0) {
    setclientmatchdata("maxClients", level._id_9C5D);
  }

  foreach(var_1 in level.players) {
    if(isDefined(var_1.pers["summary"])) {
      var_1 setplayerdata("common", "round", "totalXp", var_1.pers["summary"]["xp"]);
      var_1 setplayerdata("common", "round", "scoreXp", var_1.pers["summary"]["score"]);
      var_1 setplayerdata("common", "round", "challengeXp", var_1.pers["summary"]["challenge"]);
      var_1 setplayerdata("common", "round", "matchXp", var_1.pers["summary"]["match"]);
      var_1 setplayerdata("common", "round", "miscXp", var_1.pers["summary"]["misc"]);
      var_1 setplayerdata("common", "round", "medalXp", var_1.pers["summary"]["medal"]);
      var_1 setplayerdata("common", "common_entitlement_xp", var_1.pers["summary"]["bonusXP"]);
    }
  }
}

_id_D66F() {
  if(getdvarint("#x36325d0d09e7e5310") == 0) {
    return;
  }
  var_0 = _func_007F("scoreboardPlayerCount");

  if(var_0 < 200) {
    if(isDefined(self.pers["score"])) {
      setclientmatchdata("players", self._id_39A2, "score", self.pers["score"]);
    }

    if(isDefined(self.pers["kills"])) {
      var_1 = self.pers["kills"];
      setclientmatchdata("players", self._id_39A2, "kills", var_1);
    }

    if(scripts\mp\utility\game::getgametype() == "dm" || scripts\mp\utility\game::getgametype() == "gun") {
      var_2 = self._id_006F;
    } else if(isDefined(self.pers["assists"])) {
      var_2 = self.pers["assists"];
    } else {
      var_2 = 0;
    }

    setclientmatchdata("players", self._id_39A2, "assists", var_2);

    if(isDefined(self.pers["deaths"])) {
      var_3 = self.pers["deaths"];
      setclientmatchdata("players", self._id_39A2, "deaths", var_3);
    }

    if(isDefined(self.pers["team"])) {
      var_4 = self.pers["team"];
      setclientmatchdata("players", self._id_39A2, "team", var_4);

      if(isDefined(game[self.pers["team"]])) {
        var_5 = game[self.pers["team"]];
        setclientmatchdata("players", self._id_39A2, "faction", var_5);
      }
    }

    if(isDefined(self.pers["extrascore0"])) {
      var_6 = self.pers["extrascore0"];
      setclientmatchdata("players", self._id_39A2, "extrascore0", var_6);
    }

    if(isDefined(self.pers["extrascore1"])) {
      var_7 = self.pers["extrascore1"];
      setclientmatchdata("players", self._id_39A2, "extrascore1", var_7);
    }

    if(isDefined(self._id_F242["total"])) {
      var_8 = self._id_F242["total"];
      setclientmatchdata("players", self._id_39A2, "timeplayed", var_8);
    }

    if(isDefined(self.pers["rank"]) && isDefined(self.pers["rankxp"])) {
      var_9 = scripts\mp\rank::getrank();
      setclientmatchdata("players", self._id_39A2, "rank", var_9);
    }

    if(isDefined(self.pers["prestige"])) {
      var_10 = scripts\mp\rank::_id_6C89();
      setclientmatchdata("players", self._id_39A2, "prestige", var_10);
    }

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_11 = scripts\mp\gametypes\br::_id_2EE1(self);

      for(var_12 = 0; var_12 < var_11.size; var_12++) {
        var_13 = "extrascore" + var_12;
        setclientmatchdata("players", self._id_39A2, var_13, var_11[var_12]);
      }

      if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
        var_14 = scripts\mp\gamescore::_id_6DD9();
        var_15 = var_14[self.team];
        setclientmatchdata("players", self._id_39A2, "placement", var_15);
        var_16 = scripts\mp\gametypes\br_gametype_dmz::_id_ADC9();
        setclientmatchdata("players", self._id_39A2, "extrascore4", var_16);
        var_17 = 0;

        if(isDefined(self._id_9868)) {
          var_17 = self._id_9868;
        }

        setclientmatchdata("players", self._id_39A2, "extrascore5", var_17);
      } else if(isDefined(self._id_EF8C))
        setclientmatchdata("players", self._id_39A2, "placement", self._id_EF8C);
    }

    if(isDefined(self.pers["summary"]["xp"])) {
      var_18 = self.pers["summary"]["xp"];
      setclientmatchdata("players", self._id_39A2, "totalXp", var_18);
    }

    if(isDefined(self.pers["summary"]["match"])) {
      var_19 = self.pers["summary"]["match"];
      setclientmatchdata("players", self._id_39A2, "matchXp", var_19);
    }

    if(isDefined(self.pers["summary"]["medal"])) {
      var_20 = self.pers["summary"]["medal"];
      setclientmatchdata("players", self._id_39A2, "medalXp", var_20);
    }

    if(isDefined(self.pers["summary"]["bonusXP"])) {
      var_21 = self.pers["summary"]["bonusXP"];
      setclientmatchdata("players", self._id_39A2, "bonusXp", var_21);
    }

    if(isDefined(self.pers["summary"]["misc"])) {
      var_22 = self.pers["summary"]["misc"];
      setclientmatchdata("players", self._id_39A2, "miscXp", var_22);
    }

    if(isDefined(self.pers["summary"]["accolade"])) {
      var_23 = self.pers["summary"]["accolade"];
      setclientmatchdata("players", self._id_39A2, "accoladeXp", var_23);
    }

    var_0++;
    setclientmatchdata("scoreboardPlayerCount", var_0);
  } else {}
}

_id_2D0A(var_0) {
  if(getdvarint("#x36325d0d09e7e5310") == 0) {
    return;
  }
  if(var_0 == "multiteam") {
    var_1 = 0;

    foreach(var_3 in level._id_EF89) {
      foreach(var_5 in level._id_B16C[var_3]) {
        setclientmatchdata("scoreboards", var_1, var_5._id_39A2);
        var_1++;
      }
    }
  } else if(var_0 == "neutral") {
    var_1 = 0;

    foreach(var_5 in level._id_B16C["all"]) {
      setclientmatchdata("scoreboards", var_1, var_5._id_39A2);
      var_1++;
    }
  } else {
    var_10 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
    var_1 = 0;

    foreach(var_5 in level._id_B16C[var_0]) {
      setclientmatchdata("scoreboards", var_1, var_5._id_39A2);
      var_1++;
    }

    foreach(var_5 in level._id_B16C[var_10]) {
      setclientmatchdata("scoreboards", var_1, var_5._id_39A2);
      var_1++;
    }
  }
}