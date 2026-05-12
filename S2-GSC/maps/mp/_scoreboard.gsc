/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_scoreboard.gsc
*********************************************/

func_7759() {
  if(maps\mp\_utility::func_585F()) {
    setclientmatchdata("scoreboardPlayerCount", 0);
  }

  foreach(var_01 in level.var_7006["all"]) {
    var_01 func_8701();
  }

  if(maps\mp\_utility::func_585F()) {
    func_1D5A("neutral");
    foreach(var_01 in level.var_744A) {
      var_01 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "scoreboardType", "neutral");
    }

    setclientmatchdata("alliesScore", level.var_A980);
    setclientmatchdata("axisScore", getomnvar("ui_game_duration"));
  } else if(level.var_6520) {
    func_1D5A("multiteam");
    foreach(var_01 in level.var_744A) {
      var_01 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "scoreboardType", "multiteam");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
  } else if(level.var_984D) {
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
      foreach(var_01 in level.var_744A) {
        var_0B = var_01.var_012C["team"];
        if(!isDefined(var_0B)) {
          continue;
        }

        if(var_0B == "spectator") {
          var_01 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "scoreboardType", "allies");
          continue;
        }

        var_01 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "scoreboardType", var_0B);
      }
    } else {
      func_1D5A(var_09);
      foreach(var_01 in level.var_744A) {
        var_01 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "scoreboardType", var_09);
      }
    }
  } else {
    func_1D5A("neutral");
    foreach(var_08 in level.var_744A) {
      var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "scoreboardType", "neutral");
    }

    setclientmatchdata("alliesScore", -1);
    setclientmatchdata("axisScore", -1);
  }

  foreach(var_08 in level.var_744A) {
    var_12 = 0;
    var_13 = 0;
    if(maps\mp\_utility::func_585F()) {
      var_12 = var_08.var_AB46["xp"] - var_08.var_AB46["totalXP"];
      if(maps\mp\_utility::iszombiegameshattermode()) {
        var_13 = var_08.var_AB46["shotgunXP"] - var_08.var_AB46["preShotgunXP"];
      }
    } else if(!var_08 maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
      var_12 = var_08.var_012C["summary"]["xp"];
    } else {
      var_12 = var_08 method_8507() - var_08.var_012C["summary"]["matchStartXp"];
    }

    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "totalXp", var_12);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "totalShotgunXp", var_13);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "scoreXp", var_08.var_012C["summary"]["score"]);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "challengeXp", var_08.var_012C["summary"]["challenge"]);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "matchXp", var_08.var_012C["summary"]["match"]);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "miscXp", var_08.var_012C["summary"]["misc"]);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "entitlementXp", var_08.var_012C["summary"]["entitlementXP"]);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "clanWarsXp", var_08.var_012C["summary"]["clanWarsXP"]);
    var_08 setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "doubleXp", var_08.var_012C["summary"]["doubleXp"]);
  }
}

func_8701() {
  var_00 = getclientmatchdata("scoreboardPlayerCount");
  if(var_00 <= 48) {
    setclientmatchdata("players", self.var_241A, "score", self.var_012C["score"]);
    if(isai(self)) {
      var_01 = self botgetdifficulty();
      var_02 = "bot_rank_" + var_01;
      var_03 = self.var_012C[var_02];
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
      var_07 = self.var_012C[var_06];
      setclientmatchdata("players", self.var_241A, "prestige", var_07);
    } else {
      var_07 = self.var_012C["prestige"];
      setclientmatchdata("players", self.var_241A, "prestige", var_07);
    }

    var_08 = self.var_012C["kills"];
    setclientmatchdata("players", self.var_241A, "kills", var_08);
    if(level.var_3FDC == "ctf" || level.var_3FDC == "sr" || level.var_3FDC == "gun") {
      var_09 = self.var_0021;
    } else {
      var_09 = self.var_012C["assists"];
    }

    setclientmatchdata("players", self.var_241A, "assists", var_09);
    var_0A = self.var_012C["deaths"];
    setclientmatchdata("players", self.var_241A, "deaths", var_0A);
    var_0B = self.var_012C["headshots"];
    setclientmatchdata("players", self.var_241A, "headshots", var_0B);
    var_0C = self.var_012C["team"];
    setclientmatchdata("players", self.var_241A, "team", var_0C);
    var_0D = game[self.var_012C["team"]];
    setclientmatchdata("players", self.var_241A, "faction", var_0D);
    var_0E = self.var_012C["extrascore0"];
    setclientmatchdata("players", self.var_241A, "extrascore0", var_0E);
    var_0F = self.var_012C["extrascore1"];
    setclientmatchdata("players", self.var_241A, "extrascore1", var_0F);
    var_10 = 0;
    if(isDefined(self.var_012C["division"]) && isDefined(self.var_012C["division"]["index"])) {
      var_10 = self.var_012C["division"]["index"];
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
    foreach(var_03 in level.var_985B) {
      foreach(var_05 in level.var_7006[var_03]) {
        setclientmatchdata("scoreboards", "multiteam", "scoreboard", var_01, var_05.var_241A);
        var_01++;
      }
    }

    return;
  }

  if(param_00 == "neutral") {
    var_01 = 0;
    foreach(var_05 in level.var_7006["all"]) {
      setclientmatchdata("scoreboards", param_00, "scoreboard", var_01, var_05.var_241A);
      var_01++;
    }

    return;
  }

  var_0A = maps\mp\_utility::func_45DE(param_00);
  var_01 = 0;
  foreach(var_05 in level.var_7006[param_00]) {
    setclientmatchdata("scoreboards", param_00, "scoreboard", var_01, var_05.var_241A);
    var_01++;
  }

  foreach(var_05 in level.var_7006[var_0A]) {
    setclientmatchdata("scoreboards", param_00, "scoreboard", var_01, var_05.var_241A);
    var_01++;
  }
}