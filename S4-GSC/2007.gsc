/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2007.gsc
*************************************************/

_id_6AA0() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level._id_EF89) {
    var_5 = game["teamScores"][var_4];

    if(!isDefined(var_1) || var_5 > var_0) {
      var_0 = var_5;
      var_1 = var_4;
      var_2 = 0;
      continue;
    }

    if(var_5 == var_0) {
      var_2 = 1;
    }
  }

  if(var_2) {
    return "tie";
  } else {
    return var_1;
  }
}

_id_6A9D(var_0) {
  var_1 = 0;
  var_2 = undefined;

  foreach(var_4 in level._id_EF89) {
    if(isDefined(var_0) && var_4 == var_0) {
      continue;
    }
    var_5 = game["teamScores"][var_4];

    if(!isDefined(var_2) || var_5 > var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return [var_2, game["teamScores"][var_2]];
}

_id_FD5C() {
  level notify("updateTeamScorePlacement");
  level endon("updateTeamScorePlacement");
  waittillframeend;
  var_0 = _func_0426(game["teamScores"], "down");
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = game["teamScores"][var_4];

    if(!isDefined(var_1) || var_5 < var_1) {
      var_1 = var_5;
      var_2++;
    }

    game["teamPlacements"][var_4] = var_2;
  }
}

_id_6DD9() {
  return game["teamPlacements"];
}

_id_3B03(var_0, var_1) {
  return var_0._id_038F > var_1._id_038F;
}

_id_6A9E() {
  _id_FCF2();

  if(!level._id_B16C["all"].size) {
    return undefined;
  } else {
    return level._id_B16C["all"][0];
  }
}

_id_88A2() {
  if(level._id_B16C["all"].size > 1) {
    var_0 = _id_0C06(level._id_B16C["all"][0]);
    var_1 = _id_0C06(level._id_B16C["all"][1]);
    return var_0 == var_1;
  }

  return 0;
}

_id_6B26() {
  _id_FCF2();
  var_0 = level._id_B16C["all"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 == level._id_B16C["all"][0]) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_6FCF(var_0, var_1, var_2) {
  if(istrue(level.ignorescoring) && !issubstr(var_0, "assist")) {
    var_3 = scripts\mp\utility\game::getgametype() == "br" && !_id_07D1::_id_60BE("prematch_done");

    if(!var_3) {
      return;
    }
  }

  if(!level.teambased) {
    foreach(var_5 in level.players) {
      if(scripts\mp\utility\game::_id_8A37()) {
        if(var_5 != self) {
          continue;
        }
        if(level._id_C948 > 1 && var_5.pers["score"] >= level._id_C948) {
          return;
        }
      } else if(level._id_C948 > 1 && var_5.pers["score"] >= level._id_C948)
        return;
    }
  }

  var_5 = self;

  if(isDefined(self.owner) && !isbot(self)) {
    var_5 = self.owner;
  }

  if(!isPlayer(var_5)) {
    return;
  }
  var_7 = var_1;

  if(isDefined(level._id_AB75)) {
    var_1 = [[level._id_AB75]](var_0, var_5, var_1, var_2);
  }

  if(var_1 == 0) {
    return;
  }
  var_5.pers["score"] = int(max(var_5.pers["score"] + var_1, 0));
  var_5 _id_0804::_id_116A(int(var_7), "matchStats", "score");

  if(var_5.pers["score"] >= 65000) {
    var_5.pers["score"] = 65000;
  }

  var_5._id_038F = var_5.pers["score"];
  var_8 = var_5._id_038F;
  var_5 scripts\mp\persistence::_id_E770("round", "score", var_8);
  var_5 scripts\mp\gamelogic::_id_3539();
  var_5 thread scripts\mp\gamelogic::_id_3557();
  var_5 scripts\mp\utility\script::_id_2C9F("earned_score_buffered", var_1);
  _id_07A9::_id_9780(var_1, gettime(), scripts\mp\rank::_id_6D0C(var_0, "eventID"));
  var_9 = spawnStruct();
  var_9.player = var_5;
  var_9.scoreevent = var_0;
  _id_06E2::_id_4C2A("callback_player_score_event", var_9);
  var_5 _id_0798::_id_1102(var_0, int(var_7));
}

_id_0CEE(var_0, var_1) {
  if(var_1 == var_0.pers["score"]) {
    return;
  }
  if(var_1 < 0) {
    return;
  }
  var_0.pers["score"] = var_1;
  var_0._id_038F = var_0.pers["score"];
  var_0 thread scripts\mp\gamelogic::_id_3557();
}

_id_0C06(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  return var_0.pers["score"];
}

_id_34FE() {
  if(level._id_C948 > 0) {
    var_0 = self._id_038F / level._id_C948 * 100;

    if(var_0 > level._id_CC10) {
      _func_01E6(1, 1);
      level._id_A593 = 1;
    }
  }
}

_id_7001(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\mp\utility\game::_id_31F6()) {
    var_2 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(istrue(level.gameended) && !var_2) {
    return;
  }
  if(istrue(level.ignorescoring)) {
    return;
  }
  if(istrue(level._id_4DA1) && _id_0C0F(var_0) >= level._id_CC09) {
    return;
  }
  if(var_2) {
    if(level._id_C948 > 1 && game["teamScores"][var_0] >= level._id_C948) {
      return;
    }
  } else if(level._id_C948 > 1 && !istrue(level._id_4DA1)) {
    foreach(var_7 in level._id_EF89) {
      if(game["teamScores"][var_7] >= level._id_C948) {
        return;
      }
    }
  }

  _id_0CF2(var_0, _id_0C0F(var_0) + var_1, var_2);
  level notify("update_team_score", var_0, _id_0C0F(var_0));

  if(isDefined(level._id_ABBE)) {
    [[level._id_ABBE]](var_0, _id_0C0F(var_0), var_3);
  }

  if(isDefined(var_5)) {
    var_9 = var_5;
  } else {
    var_9 = _id_2F03(var_2);
  }

  if(!istrue(var_4)) {
    _id_B8D0(var_9, var_2, level._id_10A24);
  }

  if(var_9 != "none") {
    level._id_10A24 = var_9;
    var_10 = _id_0C0F(var_9);
    var_11 = level._id_C948;

    if(var_10 == 0 || var_11 == 0) {
      return;
    }
    var_12 = var_10 / var_11 * 100;

    if(!scripts\mp\utility\game::isroundbased() && isDefined(level._id_A593) && !level._id_A593) {
      if(var_12 > level._id_CC10) {
        _func_01E6(1, 1);
        level._id_A593 = 1;
      }
    }
  }
}

_id_B8D0(var_0, var_1, var_2) {
  if(!level.splitscreen && var_0 != "none" && var_0 != var_2 && gettime() - level._id_903C > 5000 && scripts\mp\utility\game::_id_6D0E() != 1) {
    if(isDefined(level._id_46D0)) {
      level thread _id_B873(var_1);
    } else {
      level._id_903C = gettime();
      _id_0A8D::_id_9136("lead_taken", var_0, "status");

      if(var_2 != "none") {
        _id_0A8D::_id_9136("lead_lost", var_2, "status");
      }
    }
  }
}

_id_B873(var_0) {
  wait(level._id_46D0);
  level._id_903C = gettime();
  var_1 = _id_2F03(var_0);
  _id_0A8D::_id_9136("lead_taken", var_1, "status");

  foreach(var_3 in level._id_EF89) {
    if(var_3 != var_1) {
      _id_0A8D::_id_9136("lead_lost", var_3, "status");
    }
  }
}

_id_2F03(var_0) {
  var_1 = level._id_EF89;

  if(!isDefined(level._id_10A24)) {
    level._id_10A24 = "none";
  }

  var_2 = "none";
  var_3 = 0;

  if(level._id_10A24 != "none") {
    var_2 = level._id_10A24;
    var_3 = game["teamScores"][level._id_10A24];
  }

  var_4 = 1;

  foreach(var_6 in var_1) {
    if(var_6 == level._id_10A24) {
      continue;
    }
    if(game["teamScores"][var_6] > var_3) {
      var_2 = var_6;
      var_3 = game["teamScores"][var_6];
      var_4 = 1;
      continue;
    }

    if(game["teamScores"][var_6] == var_3) {
      var_4 = var_4 + 1;
      var_2 = "none";
    }
  }

  return var_2;
}

_id_0CF2(var_0, var_1, var_2) {
  if(var_1 < 0) {
    var_1 = 0;
  }

  if(var_1 == game["teamScores"][var_0]) {
    return;
  }
  game["teamScores"][var_0] = var_1;
  _id_FD5B(var_0);

  if(!istrue(level._id_4DA1)) {
    thread scripts\mp\gamelogic::_id_C93D(var_0, var_2);
  }
}

_id_FD5B(var_0) {
  var_1 = 0;

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::_id_8957() || scripts\mp\utility\game::_id_8935()) {
    var_1 = _id_0C0F(var_0);
  } else {
    var_1 = game["roundsWon"][var_0];
  }

  _func_01F8(var_0, int(var_1));
  level thread _id_FD5C();
}

_id_FD6B(var_0) {
  if(!isDefined(game["totalScore"])) {
    game["totalScore"] = [];

    foreach(var_2 in level._id_EF89) {
      game["totalScore"][var_2] = 0;
    }
  }

  var_4 = scripts\mp\utility\game::_id_6E99();

  switch (var_4) {
    case "roundsWon":
      game["teamScores"][var_0] = game["roundsWon"][var_0];
      break;
    case "teamScores":
      if(scripts\mp\utility\game::_id_82D1()) {
        game["teamScores"][var_0] = game["preOvertimeScore"][var_0] + game["overtimeScore"][var_0] + game["teamScores"][var_0];
      } else if(scripts\mp\utility\game::_id_C63F()) {
        game["totalScore"][var_0] = game["totalScore"][var_0] + game["teamScores"][var_0];
        game["teamScores"][var_0] = game["totalScore"][var_0];
      }

      break;
  }

  _func_01F8(var_0, int(game["teamScores"][var_0]));
}

_id_FCE3() {
  if(game["overtimeRoundsPlayed"] == 0) {
    if(!isDefined(game["preOvertimeScore"])) {
      game["preOvertimeScore"] = [];

      foreach(var_1 in level._id_EF89) {
        game["preOvertimeScore"][var_1] = 0;
      }
    }

    foreach(var_1 in level._id_EF89) {
      game["preOvertimeScore"][var_1] = game["teamScores"][var_1] + game["totalScore"][var_1];
    }
  }

  if(!isDefined(game["overtimeScore"])) {
    game["overtimeScore"] = [];

    foreach(var_1 in level._id_EF89) {
      game["overtimeScore"][var_1] = 0;
    }
  }

  foreach(var_1 in level._id_EF89) {
    game["overtimeScore"][var_1] = game["overtimeScore"][var_1] + (game["teamScores"][var_1] - game["preOvertimeScore"][var_1]);
  }

  if(!scripts\mp\utility\game::_id_8B13()) {
    game["teamScores"][game["attackers"]] = 0;
    _func_01F8(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    _func_01F8(game["defenders"], 0);

    if(scripts\mp\utility\game::_id_8AA2() && game["timeToBeatTeam"] == game["attackers"]) {
      game["teamScores"][game["attackers"]] = game["timeToBeatScore"];
      _id_FD5B(game["attackers"]);
      game["overtimeScore"][game["attackers"]] = game["overtimeScore"][game["attackers"]] - game["timeToBeatScore"];
    }

    if(scripts\mp\utility\game::_id_8AA2() && game["timeToBeatTeam"] == game["defenders"]) {
      game["teamScores"][game["defenders"]] = game["timeToBeatScore"];
      _id_FD5B(game["defenders"]);
      game["overtimeScore"][game["defenders"]] = game["overtimeScore"][game["defenders"]] - game["timeToBeatScore"];
    }
  }
}

_id_0C0F(var_0) {
  return int(game["teamScores"][var_0]);
}

_id_C490() {
  if(!isDefined(level._id_B16C) || !isDefined(level._id_B16C["all"])) {
    return;
  }
  var_0 = 0;
  var_1 = level._id_B16C["all"].size;
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(level._id_B16C["all"][var_3] == self) {
      var_2 = 1;
    }

    if(var_2) {
      level._id_B16C["all"][var_3] = level._id_B16C["all"][var_3 + 1];
    }
  }

  if(!var_2) {
    return;
  }
  level._id_B16C["all"][var_1 - 1] = undefined;

  if(level.teambased) {
    _id_FD58();
  }
}

_id_FCF2() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_3B82)) {
      continue;
    }
    if(var_2.pers["team"] == "spectator" || var_2.pers["team"] == "follower" || var_2.pers["team"] == "none") {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_2 = var_0[var_4];
    var_5 = var_2._id_038F;

    for(var_6 = var_4 - 1; var_6 >= 0 && _id_691E(var_2, var_0[var_6]) == var_2; var_6--) {
      var_0[var_6 + 1] = var_0[var_6];
    }

    var_0[var_6 + 1] = var_2;
  }

  level._id_B16C["all"] = var_0;

  if(level.teambased) {
    _id_FD58();
  }
}

_id_691E(var_0, var_1) {
  if(isDefined(level._id_902C)) {
    return level._id_902C;
  }

  if(var_0._id_038F > var_1._id_038F) {
    return var_0;
  }

  if(var_1._id_038F > var_0._id_038F) {
    return var_1;
  }

  if(var_0._id_0157 < var_1._id_0157) {
    return var_0;
  }

  if(var_1._id_0157 < var_0._id_0157) {
    return var_1;
  }

  if(scripts\engine\utility::cointoss()) {
    return var_0;
  } else {
    return var_1;
  }
}

_id_FD58() {
  var_0 = level._id_B16C["all"];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.pers["team"];

    if(!isDefined(var_1[var_4])) {
      var_1[var_4] = [];
    }

    var_1[var_4][var_1[var_4].size] = var_3;
  }

  foreach(var_7 in level._id_EF89) {
    if(isDefined(var_1[var_7])) {
      level._id_B16C[var_7] = var_1[var_7];
      continue;
    }

    level._id_B16C[var_7] = [];
  }
}

_id_BD5D(var_0, var_1, var_2) {
  if(isDefined(level._id_1D2C)) {
    return;
  }
  if(_id_07BC::challengesenabledforplayer()) {
    thread _id_07BC::createeliminationchallengeevent(self, var_0, self._id_9FFB, var_1);
  }

  _id_BD5F(var_0, var_1, var_2);
}

_id_BD5F(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("disconnect");

  if(isDefined(var_1) && var_1.basename == "s4_firebombing_run_mp") {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_0._id_8921)) {
    var_4 = var_0._id_1DDE;
    var_3 = 1;
  }

  if(isDefined(var_0._id_9B35)) {
    var_5 = var_0._id_9B35;
  }

  wait 0.05;
  scripts\mp\utility\script::_id_1096C();
  var_6 = self.pers["team"];

  if(!scripts\mp\utility\teams::_id_8878(var_6)) {
    return;
  }
  if(var_6 == var_0.pers["team"] && level.teambased) {
    return;
  }
  var_7 = undefined;
  var_8 = "assist";

  if(!level.teambased) {
    var_8 = "assist_ffa";
  }

  var_9 = scripts\mp\rank::getscoreinfovalue(var_8);

  if(!level.teambased) {
    var_7 = var_9 + var_9 * var_2;
    thread _id_0A9F::_id_7003("assist_ffa", var_1);
  } else if(isDefined(var_5) && scripts\engine\utility::_id_1BA1(var_5, scripts\mp\utility\player::getuniqueid()))
    thread _id_0A9F::_id_6FF6("assist_ping", var_1, undefined);
  else {
    var_7 = var_9 + var_9 * var_2;
    thread _id_0A9F::_id_7003("assist", var_1);
  }

  if(level.teambased) {
    var_10 = scripts\common\utility::_id_B7BF(self.origin, 300);

    foreach(var_12 in var_10) {
      if(self.team != var_12.team || self == var_12) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_12)) {
        continue;
      }
      self._id_9FFB["buddy_kill"] = 1;
      break;
    }
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_hardline") && isDefined(self._id_74C6)) {
    if(self._id_74C6["assists"] == 1) {
      if(!scripts\mp\utility\weapon::_id_88F6(var_1) && !scripts\mp\utility\weapon::_id_8A7D(var_1)) {
        thread _id_0A9F::_id_6FF6("assist_hardline", var_1, 1);
      }
    }

    self notify("assist_hardline");
  }

  _id_0804::_id_116A(1, "combatStats", "assists");

  if(self.pers["assists"] < 998) {
    scripts\mp\utility\stats::_id_7DAE("assists", 1);
    self._id_006F = scripts\mp\utility\stats::_id_6C29("assists");
    scripts\mp\persistence::_id_E770("round", "assists", self._id_006F);
  }

  scripts\mp\utility\script::_id_2C9F("assist_buffered", self._id_9FFB);
  thread _id_07BC::_id_AB6E(var_0);
}

_id_BD7E(var_0) {
  if(isDefined(level._id_1D2C)) {
    return;
  }
  _id_BD7F(var_0);
}

_id_BD7F(var_0) {
  self endon("disconnect");
  var_0 endon("disconnect");
  wait 0.05;
  scripts\mp\utility\script::_id_1096C();

  if(!scripts\mp\utility\teams::_id_8878(self.pers["team"])) {
    return;
  }
  if(self.pers["team"] == var_0.pers["team"]) {
    return;
  }
  thread _id_0A9F::_id_7003("shield_assist");
  _id_0804::_id_116A(1, "combatStats", "assists");

  if(self.pers["assists"] < 998) {
    scripts\mp\utility\stats::_id_7DAE("assists", 1);
    self._id_006F = scripts\mp\utility\stats::_id_6C29("assists");
    scripts\mp\persistence::_id_E770("round", "assists", self._id_006F);
  }

  thread _id_07BC::_id_AB6E(var_0);
}

_id_8142() {
  self notify("initAssistTrackers");
  self._id_2C98 = [];
  self._id_4427 = [];
}

_id_F3FA(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(!isDefined(var_1._id_4427[var_2])) {
    var_1._id_4427[var_2] = [];
  }

  if(!isDefined(var_1._id_4427[var_2][var_0 getentitynumber()])) {
    var_1._id_4427[var_2][var_0 getentitynumber()] = 0;
  }

  var_1._id_4427[var_2][var_0 getentitynumber()]++;
}

_id_FB2C(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(isDefined(var_0)) {
    if(isDefined(var_1._id_4427[var_2]) && isDefined(var_1._id_4427[var_2][var_0 getentitynumber()])) {
      var_1._id_4427[var_2][var_0 getentitynumber()]--;
      var_3 = 1;

      foreach(var_6, var_5 in var_1._id_4427[var_2]) {
        if(var_5 > 0) {
          var_3 = 0;
          break;
        }
      }

      if(var_3 && isDefined(var_2) && isDefined(var_1._id_4427)) {
        var_1._id_4427[var_2] = undefined;
        return;
      }
    } else {}
  }
}

_id_F3FB(var_0, var_1, var_2, var_3) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  var_1 endon("initAssistTrackers");
  var_1 endon("disconnect");
  var_0 endon("disconnect");
  level endon("game_ended");
  _id_F3FA(var_0, var_1, var_2);
  wait(var_3);
  _id_FB2C(var_0, var_1, var_2);
}

_id_87F3(var_0, var_1) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return 0;
  }

  if(isDefined(var_0._id_4427[var_1])) {
    foreach(var_4, var_3 in var_0._id_4427[var_1]) {
      if(var_3 <= 0) {
        continue;
      }
      if(!isDefined(level._id_B78E[var_4])) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

_id_87F4(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return 0;
  }

  if(!isDefined(var_1._id_4427[var_2])) {
    return 0;
  }

  if(!isDefined(var_1._id_4427[var_2][var_0 getentitynumber()])) {
    return 0;
  }

  if(var_1._id_4427[var_2][var_0 getentitynumber()] <= 0) {
    return 0;
  }

  return 1;
}

_id_69CD(var_0, var_1) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return undefined;
  }

  var_2 = [];

  if(isPlayer(var_0)) {
    if(isDefined(var_0._id_4427[var_1])) {
      foreach(var_5, var_4 in var_0._id_4427[var_1]) {
        if(var_4 <= 0) {
          continue;
        }
        if(!isDefined(level._id_B78E[var_5])) {
          continue;
        }
        var_2[var_2.size] = level._id_B78E[var_5];
      }
    }
  }

  return var_2;
}

_id_F3F3(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(var_0 != var_1) {
    if(!isDefined(var_1._id_2C98[var_2])) {
      var_1._id_2C98[var_2] = [];
    }

    if(!isDefined(var_1._id_2C98[var_2][var_0 getentitynumber()])) {
      var_1._id_2C98[var_2][var_0 getentitynumber()] = 0;
    }

    var_1._id_2C98[var_2][var_0 getentitynumber()]++;
  }
}

_id_FB2B(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(isDefined(var_1)) {
    if(isDefined(var_1._id_2C98[var_2]) && isDefined(var_1._id_2C98[var_2][var_0 getentitynumber()])) {
      var_1._id_2C98[var_2][var_0 getentitynumber()]--;
    } else {}
  }
}

_id_F3F4(var_0, var_1, var_2, var_3) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  var_1 endon("initAssistTrackers");
  var_1 endon("disconnect");
  var_0 endon("disconnect");
  level endon("game_ended");
  _id_F3F3(var_0, var_1, var_2);
  wait(var_3);
  _id_FB2B(var_0, var_1, var_2);
}

_id_1FC3(var_0, var_1) {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  var_2 = [];

  foreach(var_10, var_4 in var_1._id_4427) {
    foreach(var_9, var_6 in var_4) {
      if(var_6 <= 0) {
        continue;
      }
      var_7 = level._id_B78E[var_9];

      if(isDefined(var_7) && var_7.team != "spectator" && var_7.team != "follower" && var_7 scripts\mp\utility\player::isenemy(var_1)) {
        var_8 = var_7.guid;

        if(!isDefined(var_2[var_8])) {
          var_2[var_8] = var_7;
        }
      }
    }
  }

  foreach(var_4 in var_0._id_2C98) {
    foreach(var_9, var_13 in var_4) {
      if(var_13 <= 0) {
        continue;
      }
      var_7 = level._id_B78E[var_9];

      if(isDefined(var_7) && var_7.team != "spectator" && var_7.team != "follower" && var_7 scripts\mp\utility\player::isenemy(var_1)) {
        var_8 = var_7.guid;

        if(!isDefined(var_2[var_8])) {
          var_2[var_8] = var_7;
        }
      }
    }
  }

  foreach(var_8, var_7 in var_2) {
    if(!isDefined(var_1._id_1DD4) || !isDefined(var_1._id_1DD4[var_7.guid])) {
      _id_07C3::_id_108F(var_1, var_7, undefined, _func_0375(), 0, undefined, undefined, undefined, undefined, undefined);
    }
  }
}

_id_60D7(var_0) {
  return var_0 == "dm" || var_0 == "sotf_ffa";
}