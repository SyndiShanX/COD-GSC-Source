/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_scoreboard.gsc
*********************************************/

func_7759() {
  if(maps\mp\_utility::func_585F()) {
    setclientmatchdata("scoreboardPlayerCount", 0);
  }

  foreach(var_01 in level.placement["all"]) {
    var_01 func_8701();
  }

  if(maps\mp\_utility::func_585F()) {
    func_1D5A("neutral");
    foreach(var_01 in level.players) {
      var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "scoreboardType", "neutral");
    }

    setclientmatchdata("alliesScore", level.var_A980);
    setclientmatchdata("axisScore", getomnvar("ui_game_duration"));
  } else if(level.multiteambased) {
    func_1D5A("multiteam");
    foreach(var_01 in level.players) {
      var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "scoreboardType", "multiteam");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
  } else if(level.teambased) {
    var_07 = getteamscore("allies");
    var_08 = getteamscore("axis");
    if(var_07 == var_08) {
      var_09 = "tied";
    } else if(var_08 > var_09) {
      var_09 = "allies";
    } else {
      var_09 = "axis";
    }

    setclientmatchdata("alliesScore", var_07);
    setclientmatchdata("axisScore", var_08);
    if(var_09 == "tied") {
      func_1D5A("allies");
      func_1D5A("axis");
      foreach(var_01 in level.players) {
        var_0B = var_01.pers["team"];
        if(!isDefined(var_0B)) {
          continue;
        }

        if(var_0B == "spectator") {
          var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "scoreboardType", "allies");
          continue;
        }

        var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "scoreboardType", var_0B);
      }
    } else {
      func_1D5A(var_09);
      foreach(var_01 in level.players) {
        var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "scoreboardType", var_09);
      }
    }
  } else {
    func_1D5A("neutral");
    foreach(var_01 in level.players) {
      var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "scoreboardType", "neutral");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
  }

  foreach(var_01 in level.players) {
    var_12 = 0;
    var_13 = 0;
    if(maps\mp\_utility::func_585F()) {
      var_12 = var_01.var_AB46["xp"] - var_01.var_AB46["totalXP"];
      if(maps\mp\_utility::iszombiegameshattermode()) {
        var_13 = var_01.var_AB46["shotgunXP"] - var_01.var_AB46["preShotgunXP"];
      }
    } else if(!var_01 maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame()) {
      var_12 = var_01.pers["summary"]["xp"];
    } else {
      var_12 = var_01 method_8507() - var_01.pers["summary"]["matchStartXp"];
    }

    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "totalXp", var_12);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "totalShotgunXp", var_13);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "scoreXp", var_01.pers["summary"]["score"]);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "challengeXp", var_01.pers["summary"]["challenge"]);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "matchXp", var_01.pers["summary"]["match"]);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "miscXp", var_01.pers["summary"]["misc"]);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "entitlementXp", var_01.pers["summary"]["entitlementXP"]);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "clanWarsXp", var_01.pers["summary"]["clanWarsXP"]);
    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "doubleXp", var_01.pers["summary"]["doubleXp"]);
  }
}

func_8701() {
  var_00 = getclientmatchdata("scoreboardPlayerCount");
  if(var_00 <= 48) {
    setclientmatchdata("players", self.var_241A, "score", self.pers["score"]);
    if(isai(self)) {
      var_01 = self botgetdifficulty();
      var_02 = "bot_rank_" + var_01;
      var_03 = self.pers[var_02];
      setclientmatchdata("players", self.var_241A, "experience", var_03);
    } else {
      var_04 = self method_8507();
      setclientmatchdata("players", self.var_241A, "experience", var_04);
    }

    var_05 = self method_8508();
    setclientmatchdata("players", self.var_241A, "clanTag", var_05);
    if(isai(self)) {
      var_01 = self botgetdifficulty();
      var_06 = "bot_prestige_" + var_01;
      var_07 = self.pers[var_06];
      setclientmatchdata("players", self.var_241A, "prestige", var_07);
    } else {
      var_07 = self.pers["prestige"];
      setclientmatchdata("players", self.var_241A, "prestige", var_07);
    }

    var_08 = self.pers["kills"];
    setclientmatchdata("players", self.var_241A, "kills", var_08);
    if(level.gametype == "ctf" || level.gametype == "sr" || level.gametype == "gun") {
      var_09 = self.assists;
    } else {
      var_09 = self.pers["assists"];
    }

    setclientmatchdata("players", self.var_241A, "assists", var_09);
    var_0A = self.pers["deaths"];
    setclientmatchdata("players", self.var_241A, "deaths", var_0A);
    var_0B = self.pers["headshots"];
    setclientmatchdata("players", self.var_241A, "headshots", var_0B);
    var_0C = self.pers["team"];
    setclientmatchdata("players", self.var_241A, "team", var_0C);
    var_0D = game[self.pers["team"]];
    setclientmatchdata("players", self.var_241A, "faction", var_0D);
    var_0E = self.pers["extrascore0"];
    setclientmatchdata("players", self.var_241A, "extrascore0", var_0E);
    var_0F = self.pers["extrascore1"];
    setclientmatchdata("players", self.var_241A, "extrascore1", var_0F);
    var_10 = 0;
    if(isDefined(self.pers["division"]) && isDefined(self.pers["division"]["index"])) {
      var_10 = self.pers["division"]["index"];
    }

    setclientmatchdata("players", self.var_241A, "division", var_10);
    var_00++;
    setclientmatchdata("scoreboardPlayerCount", var_00);
    if(function_03AF()) {
      var_11 = function_03B5();
      var_12 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_11, "mmr_current");
      setclientmatchdata("players", self.var_241A, "mmr_current", var_12);
      var_13 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_11, "ranked_games_total");
      setclientmatchdata("players", self.var_241A, "ranked_games_total", var_13);
      var_14 = !self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_11, "mmr_was_adjusted");
      setclientmatchdata("players", self.var_241A, "ranked_placement_enabled", var_14);
      return;
    }
  }
}

func_1D5A(param_00) {
  if(param_00 == "multiteam") {
    var_01 = 0;
    foreach(var_03 in level.teamnamelist) {
      foreach(var_05 in level.placement[var_03]) {
        setclientmatchdata("scoreboards", "multiteam", "scoreboard", var_01, var_05.var_241A);
        var_01++;
      }
    }

    return;
  }

  if(var_05 == "neutral") {
    var_01 = 0;
    foreach(var_05 in level.placement["all"]) {
      setclientmatchdata("scoreboards", param_00, "scoreboard", var_01, var_05.var_241A);
      var_01++;
    }

    return;
  }

  var_0A = maps\mp\_utility::getotherteam(var_05);
  var_01 = 0;
  foreach(var_05 in level.placement[param_00]) {
    setclientmatchdata("scoreboards", param_00, "scoreboard", var_01, var_05.var_241A);
    var_01++;
  }

  foreach(var_05 in level.placement[var_0A]) {
    setclientmatchdata("scoreboards", param_00, "scoreboard", var_01, var_05.var_241A);
    var_01++;
  }
}