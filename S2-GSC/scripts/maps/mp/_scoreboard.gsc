/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_scoreboard.gsc
*******************************************/

processlobbyscoreboards() {
  if(maps\mp\_utility::_id_585F()) {
    _setclientmatchdata("scoreboardPlayerCount", 0);
  }

  foreach(var_1 in level.placement["all"]) {
    var_1 setplayerscoreboardinfo();
  }

  if(maps\mp\_utility::_id_585F()) {
    buildscoreboardtype("neutral");

    foreach(var_1 in level.players) {
      var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "scoreboardType", "neutral");
    }

    _setclientmatchdata("alliesScore", level.wavecounter);
    _setclientmatchdata("axisScore", _getomnvar("ui_game_duration"));
  } else if(level.multiteambased) {
    buildscoreboardtype("multiteam");

    foreach(var_1 in level.players) {
      var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "scoreboardType", "multiteam");
    }

    _setclientmatchdata("alliesScore", -1);
    _setclientmatchdata("axisScore", -1);
  } else if(level.teambased) {
    var_7 = _getteamscore("allies");
    var_8 = _getteamscore("axis");

    if(var_7 == var_8) {
      var_9 = "tied";
    } else if(var_7 > var_8) {
      var_9 = "allies";
    } else {
      var_9 = "axis";
    }

    _setclientmatchdata("alliesScore", var_7);
    _setclientmatchdata("axisScore", var_8);

    if(var_9 == "tied") {
      buildscoreboardtype("allies");
      buildscoreboardtype("axis");

      foreach(var_1 in level.players) {
        var_11 = var_1.pers["team"];

        if(!isDefined(var_11)) {
          continue;
        }
        if(var_11 == "spectator") {
          var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "scoreboardType", "allies");
          continue;
        }

        var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "scoreboardType", var_11);
      }
    } else {
      buildscoreboardtype(var_9);

      foreach(var_1 in level.players) {
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "scoreboardType", var_9);
      }
    }
  } else {
    buildscoreboardtype("neutral");

    foreach(var_1 in level.players) {
      var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "scoreboardType", "neutral");
    }

    _setclientmatchdata("alliesScore", -1);
    _setclientmatchdata("axisScore", -1);
  }

  foreach(var_1 in level.players) {
    var_18 = 0;
    var_19 = 0;

    if(maps\mp\_utility::_id_585F()) {
      var_18 = var_1._id_AB46["xp"] - var_1._id_AB46["totalXP"];

      if(maps\mp\_utility::iszombiegameshattermode()) {
        var_19 = var_1._id_AB46["shotgunXP"] - var_1._id_AB46["preShotgunXP"];
      }
    } else if(!var_1 maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame())
      var_18 = var_1.pers["summary"]["xp"];
    else {
      var_18 = var_1 gettotalmpxp() - var_1.pers["summary"]["matchStartXp"];
    }

    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "totalXp", var_18);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "totalShotgunXp", var_19);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "scoreXp", var_1.pers["summary"]["score"]);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "challengeXp", var_1.pers["summary"]["challenge"]);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "matchXp", var_1.pers["summary"]["match"]);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "miscXp", var_1.pers["summary"]["misc"]);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "entitlementXp", var_1.pers["summary"]["entitlementXP"]);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "clanWarsXp", var_1.pers["summary"]["clanWarsXP"]);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "doubleXp", var_1.pers["summary"]["doubleXp"]);
  }
}

setplayerscoreboardinfo() {
  var_0 = _getclientmatchdata("scoreboardPlayerCount");

  if(var_0 <= 48) {
    _setclientmatchdata("players", self.clientmatchdataid, "score", self.pers["score"]);

    if(_isai(self)) {
      var_1 = self botgetdifficulty();
      var_2 = "bot_rank_" + var_1;
      var_3 = self.pers[var_2];
      _setclientmatchdata("players", self.clientmatchdataid, "experience", var_3);
    } else {
      var_4 = self gettotalmpxp();
      _setclientmatchdata("players", self.clientmatchdataid, "experience", var_4);
    }

    var_5 = self _meth_8508();
    _setclientmatchdata("players", self.clientmatchdataid, "clanTag", var_5);

    if(_isai(self)) {
      var_1 = self botgetdifficulty();
      var_6 = "bot_prestige_" + var_1;
      var_7 = self.pers[var_6];
      _setclientmatchdata("players", self.clientmatchdataid, "prestige", var_7);
    } else {
      var_7 = self.pers["prestige"];
      _setclientmatchdata("players", self.clientmatchdataid, "prestige", var_7);
    }

    var_8 = self.pers["kills"];
    _setclientmatchdata("players", self.clientmatchdataid, "kills", var_8);

    if(level.gametype == "ctf" || level.gametype == "sr" || level.gametype == "gun") {
      var_9 = self._id_0021;
    } else {
      var_9 = self.pers["assists"];
    }

    _setclientmatchdata("players", self.clientmatchdataid, "assists", var_9);
    var_10 = self.pers["deaths"];
    _setclientmatchdata("players", self.clientmatchdataid, "deaths", var_10);
    var_11 = self.pers["headshots"];
    _setclientmatchdata("players", self.clientmatchdataid, "headshots", var_11);
    var_12 = self.pers["team"];
    _setclientmatchdata("players", self.clientmatchdataid, "team", var_12);
    var_13 = game[self.pers["team"]];
    _setclientmatchdata("players", self.clientmatchdataid, "faction", var_13);
    var_14 = self.pers["extrascore0"];
    _setclientmatchdata("players", self.clientmatchdataid, "extrascore0", var_14);
    var_15 = self.pers["extrascore1"];
    _setclientmatchdata("players", self.clientmatchdataid, "extrascore1", var_15);
    var_16 = 0;

    if(isDefined(self.pers["division"]) && isDefined(self.pers["division"]["index"])) {
      var_16 = self.pers["division"]["index"];
    }

    _setclientmatchdata("players", self.clientmatchdataid, "division", var_16);
    var_0++;
    _setclientmatchdata("scoreboardPlayerCount", var_0);

    if(xmodelalias/alias_ger_heads_scarf_for_muddy_cheap()) {
      var_17 = xmodelalias/alias_ger_heads_ss_muddy_cheap();
      var_18 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "ranked_play_season_data", var_17, "mmr_current");
      _setclientmatchdata("players", self.clientmatchdataid, "mmr_current", var_18);
      var_19 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "ranked_play_season_data", var_17, "ranked_games_total");
      _setclientmatchdata("players", self.clientmatchdataid, "ranked_games_total", var_19);
      var_20 = !self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "ranked_play_season_data", var_17, "mmr_was_adjusted");
      _setclientmatchdata("players", self.clientmatchdataid, "ranked_placement_enabled", var_20);
      return;
    }
  } else {}
}

buildscoreboardtype(var_0) {
  if(var_0 == "multiteam") {
    var_1 = 0;

    foreach(var_3 in level.teamnamelist) {
      foreach(var_5 in level.placement[var_3]) {
        _setclientmatchdata("scoreboards", "multiteam", "scoreboard", var_1, var_5.clientmatchdataid);
        var_1++;
      }
    }
  } else if(var_0 == "neutral") {
    var_1 = 0;

    foreach(var_5 in level.placement["all"]) {
      _setclientmatchdata("scoreboards", var_0, "scoreboard", var_1, var_5.clientmatchdataid);
      var_1++;
    }
  } else {
    var_10 = maps\mp\_utility::getotherteam(var_0);
    var_1 = 0;

    foreach(var_5 in level.placement[var_0]) {
      _setclientmatchdata("scoreboards", var_0, "scoreboard", var_1, var_5.clientmatchdataid);
      var_1++;
    }

    foreach(var_5 in level.placement[var_10]) {
      _setclientmatchdata("scoreboards", var_0, "scoreboard", var_1, var_5.clientmatchdataid);
      var_1++;
    }
  }
}