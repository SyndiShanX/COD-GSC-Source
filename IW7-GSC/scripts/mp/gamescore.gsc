/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gamescore.gsc
*********************************************/

gethighestscoringplayer() {
  updateplacement();
  if(!level.placement["all"].size) {
    return undefined;
  }

  return level.placement["all"][0];
}

ishighestscoringplayertied() {
  if(level.placement["all"].size > 1) {
    var_0 = _getplayerscore(level.placement["all"][0]);
    var_1 = _getplayerscore(level.placement["all"][1]);
    return var_0 == var_1;
  }

  return 0;
}

getlosingplayers() {
  updateplacement();
  var_0 = level.placement["all"];
  var_1 = [];
  foreach(var_3 in var_0) {
    if(var_3 == level.placement["all"][0]) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

giveplayerscore(var_0, var_1) {
  if(isDefined(level.ignorescoring) && !issubstr(var_0, "assist")) {
    return;
  }

  if(!level.teambased) {
    foreach(var_3 in level.players) {
      if(scripts\mp\utility::issimultaneouskillenabled()) {
        if(var_3 != self) {
          continue;
        }

        if(level.roundscorelimit > 1 && var_3.pers["score"] >= level.roundscorelimit) {
          return;
        }

        continue;
      }

      if(level.roundscorelimit > 1 && var_3.pers["score"] >= level.roundscorelimit) {
        return;
      }
    }
  }

  var_3 = self;
  if(isDefined(self.owner) && !isbot(self)) {
    var_3 = self.owner;
  }

  if(!isplayer(var_3)) {
    return;
  }

  var_5 = var_1;
  if(isDefined(level.onplayerscore)) {
    var_1 = [[level.onplayerscore]](var_0, var_3, var_1);
  }

  if(var_1 == 0) {
    return;
  }

  var_3.pers["score"] = int(max(var_3.pers["score"] + var_1, 0));
  var_3 scripts\mp\persistence::statadd("score", var_5);
  if(var_3.pers["score"] >= -536) {
    var_3.pers["score"] = -536;
  }

  var_3.score = var_3.pers["score"];
  var_6 = var_3.score;
  var_3 scripts\mp\persistence::statsetchild("round", "score", var_6);
  var_3 scripts\mp\gamelogic::checkplayerscorelimitsoon();
  thread scripts\mp\gamelogic::checkscorelimit();
  if(scripts\mp\utility::matchmakinggame() && isDefined(level.nojip) && !level.nojip && level.gametype != "infect") {
    var_3 checkffascorejip();
  }

  var_3 scripts\mp\utility::bufferednotify("earned_score_buffered", var_1);
  scripts\mp\analyticslog::logevent_reportgamescore(var_1, gettime(), scripts\mp\rank::getscoreinfocategory(var_0, "eventID"));
  var_3 scripts\mp\matchdata::func_AFD8(var_0);
}

_setplayerscore(var_0, var_1) {
  if(var_1 == var_0.pers["score"]) {
    return;
  }

  if(var_1 < 0) {
    return;
  }

  var_0.pers["score"] = var_1;
  var_0.score = var_0.pers["score"];
  thread scripts\mp\gamelogic::checkscorelimit();
}

_getplayerscore(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  return var_0.pers["score"];
}

checkffascorejip() {
  if(level.roundscorelimit > 0) {
    var_0 = self.score / level.roundscorelimit * 100;
    if(var_0 > level.var_EC3F) {
      setnojipscore(1);
      level.nojip = 1;
    }
  }
}

giveteamscoreforobjective(var_0, var_1, var_2) {
  if(scripts\mp\utility::cantiebysimultaneouskill()) {
    var_2 = 1;
  }

  if(isDefined(level.ignorescoring)) {
    return;
  }

  if(var_2) {
    if(level.roundscorelimit > 1 && game["teamScores"][var_0] >= level.roundscorelimit) {
      return;
    }
  } else if((level.roundscorelimit > 1 && game["teamScores"][var_0] >= level.roundscorelimit) || level.roundscorelimit > 1 && game["teamScores"][level.otherteam[var_0]] >= level.roundscorelimit) {
    return;
  }

  func_13D6(var_0, _getteamscore(var_0) + var_1, var_2);
  level notify("update_team_score", var_0, _getteamscore(var_0));
  var_3 = playlocalsound(var_2);
  if(!level.splitscreen && var_3 != "none" && var_3 != level.waswinning && gettime() - level.var_AA1E > 5000 && scripts\mp\utility::getscorelimit() != 1) {
    level.var_AA1E = gettime();
    scripts\mp\utility::leaderdialog("lead_taken", var_3, "status");
    if(level.waswinning != "none") {
      scripts\mp\utility::leaderdialog("lead_lost", level.waswinning, "status");
    }
  }

  if(var_3 != "none") {
    level.waswinning = var_3;
    var_4 = _getteamscore(var_3);
    var_5 = level.roundscorelimit;
    if(var_4 == 0 || var_5 == 0) {
      return;
    }

    var_6 = var_4 / var_5 * 100;
    if(!scripts\mp\utility::isroundbased() && isDefined(level.nojip) && !level.nojip) {
      if(var_6 > level.var_EC3F) {
        setnojipscore(1);
        level.nojip = 1;
        return;
      }
    }
  }
}

playlocalsound(var_0) {
  var_1 = level.teamnamelist;
  if(!isDefined(level.waswinning)) {
    level.waswinning = "none";
  }

  var_2 = "none";
  var_3 = 0;
  if(level.waswinning != "none") {
    var_2 = level.waswinning;
    var_3 = game["teamScores"][level.waswinning];
  }

  var_4 = 1;
  foreach(var_6 in var_1) {
    if(var_6 == level.waswinning) {
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

func_13D6(var_0, var_1, var_2) {
  if(var_1 < 0) {
    var_1 = 0;
  }

  if(var_1 == game["teamScores"][var_0]) {
    return;
  }

  game["teamScores"][var_0] = var_1;
  updateteamscore(var_0);
  thread scripts\mp\gamelogic::func_E75E(var_0, var_2);
}

updateteamscore(var_0) {
  var_1 = 0;
  if(!scripts\mp\utility::isroundbased() || !scripts\mp\utility::isobjectivebased() || scripts\mp\utility::ismoddedroundgame()) {
    var_1 = _getteamscore(var_0);
  } else {
    var_1 = game["roundsWon"][var_0];
  }

  setteamscore(var_0, int(var_1));
}

func_12F4A(var_0) {
  if(!isDefined(game["totalScore"])) {
    game["totalScore"] = [];
    game["totalScore"]["axis"] = 0;
    game["totalScore"]["allies"] = 0;
  }

  var_1 = scripts\mp\utility::getwingamebytype();
  switch (var_1) {
    case "roundsWon":
      game["teamScores"][var_0] = game["roundsWon"][var_0];
      break;

    case "teamScores":
      if(scripts\mp\utility::inovertime()) {
        game["teamScores"][var_0] = game["preOvertimeScore"][var_0] + game["overtimeScore"][var_0] + game["teamScores"][var_0];
      } else if(scripts\mp\utility::func_E269()) {
        game["totalScore"][var_0] = game["totalScore"][var_0] + game["teamScores"][var_0];
        game["teamScores"][var_0] = game["totalScore"][var_0];
      }
      break;
  }

  setteamscore(var_0, int(game["teamScores"][var_0]));
}

func_12EE5() {
  if(game["overtimeRoundsPlayed"] == 0) {
    if(!isDefined(game["preOvertimeScore"])) {
      game["preOvertimeScore"] = [];
      game["preOvertimeScore"]["allies"] = 0;
      game["preOvertimeScore"]["axis"] = 0;
    }

    game["preOvertimeScore"]["allies"] = game["teamScores"]["allies"] + game["totalScore"]["allies"];
    game["preOvertimeScore"]["axis"] = game["teamScores"]["axis"] + game["totalScore"]["axis"];
  }

  if(!isDefined(game["overtimeScore"])) {
    game["overtimeScore"] = [];
    game["overtimeScore"]["allies"] = 0;
    game["overtimeScore"]["axis"] = 0;
  }

  game["overtimeScore"]["allies"] = game["overtimeScore"]["allies"] + game["teamScores"]["allies"] - game["preOvertimeScore"]["allies"];
  game["overtimeScore"]["axis"] = game["overtimeScore"]["axis"] + game["teamScores"]["axis"] - game["preOvertimeScore"]["axis"];
  if(!scripts\mp\utility::iswinbytworulegametype()) {
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
    if(scripts\mp\utility::istimetobeatvalid() && game["timeToBeatTeam"] == game["attackers"]) {
      game["teamScores"][game["attackers"]] = game["timeToBeatScore"];
      updateteamscore(game["attackers"]);
      game["overtimeScore"][game["attackers"]] = game["overtimeScore"][game["attackers"]] - game["timeToBeatScore"];
    }

    if(scripts\mp\utility::istimetobeatvalid() && game["timeToBeatTeam"] == game["defenders"]) {
      game["teamScores"][game["defenders"]] = game["timeToBeatScore"];
      updateteamscore(game["defenders"]);
      game["overtimeScore"][game["defenders"]] = game["overtimeScore"][game["defenders"]] - game["timeToBeatScore"];
    }
  }
}

_getteamscore(var_0) {
  return int(game["teamScores"][var_0]);
}

removedisconnectedplayerfromplacement() {
  var_0 = 0;
  var_1 = level.placement["all"].size;
  var_2 = 0;
  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(level.placement["all"][var_3] == self) {
      var_2 = 1;
    }

    if(var_2) {
      level.placement["all"][var_3] = level.placement["all"][var_3 + 1];
    }
  }

  if(!var_2) {
    return;
  }

  level.placement["all"][var_1 - 1] = undefined;
  if(level.multiteambased) {
    func_BD7B();
  }

  if(level.teambased) {
    updateteamplacement();
  }
}

updateplacement() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(isDefined(var_2.connectedpostgame)) {
      continue;
    }

    if(var_2.pers["team"] == "spectator" || var_2.pers["team"] == "none") {
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_2 = var_0[var_4];
    var_5 = var_2.score;
    for(var_6 = var_4 - 1; var_6 >= 0 && func_7E06(var_2, var_0[var_6]) == var_2; var_6--) {
      var_0[var_6 + 1] = var_0[var_6];
    }

    var_0[var_6 + 1] = var_2;
  }

  level.placement["all"] = var_0;
  if(level.multiteambased) {
    func_BD7B();
  } else if(level.teambased) {
    updateteamplacement();
  }
}

func_7E06(var_0, var_1) {
  if(var_0.score > var_1.score) {
    return var_0;
  }

  if(var_1.score > var_0.score) {
    return var_1;
  }

  if(var_0.var_E9 < var_1.var_E9) {
    return var_0;
  }

  if(var_1.var_E9 < var_0.var_E9) {
    return var_1;
  }

  if(scripts\engine\utility::cointoss()) {
    return var_0;
  }

  return var_1;
}

updateteamplacement() {
  var_0["allies"] = [];
  var_0["axis"] = [];
  var_0["spectator"] = [];
  var_1 = level.placement["all"];
  var_2 = var_1.size;
  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1[var_3];
    var_5 = var_4.pers["team"];
    var_0[var_5][var_0[var_5].size] = var_4;
  }

  level.placement["allies"] = var_0["allies"];
  level.placement["axis"] = var_0["axis"];
}

func_BD7B() {
  var_0["spectator"] = [];
  foreach(var_2 in level.teamnamelist) {
    var_0[var_2] = [];
  }

  var_4 = level.placement["all"];
  var_5 = var_4.size;
  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = var_4[var_6];
    var_8 = var_7.pers["team"];
    var_0[var_8][var_0[var_8].size] = var_7;
  }

  foreach(var_2 in level.teamnamelist) {
    level.placement[var_2] = var_0[var_2];
  }
}

processassist(var_0, var_1, var_2) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processassist_regularmp(var_0, var_1, var_2);
}

processassist_regularmp(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("disconnect");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  if(isDefined(var_0.ismarkedtarget)) {
    var_4 = var_0.attackers;
    var_3 = 1;
  }

  if(isDefined(var_0.markedbyboomperk)) {
    var_5 = var_0.markedbyboomperk;
  }

  wait(0.05);
  scripts\mp\utility::func_13842();
  var_6 = self.pers["team"];
  if(var_6 != "axis" && var_6 != "allies") {
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
    if(var_2) {
      var_7 = var_9 + var_9;
    }

    thread scripts\mp\utility::giveunifiedpoints("assist_ffa", var_1, var_7);
  } else if(scripts\mp\utility::_hasperk("specialty_mark_targets") && isDefined(var_4) && scripts\engine\utility::array_contains(var_4, self)) {
    if(var_2) {
      var_10 = scripts\mp\rank::getscoreinfovalue("assistMarked");
      var_7 = var_9 + var_10;
    }

    thread scripts\mp\utility::givestreakpointswithtext("assistMarked", var_1, var_7);
    giveplayerscore("assist", var_9);
  } else if(isDefined(var_5) && scripts\mp\utility::func_2287(var_5, scripts\mp\utility::getuniqueid())) {
    thread scripts\mp\utility::givestreakpointswithtext("assistPing", var_1, undefined);
  } else {
    if(var_2) {
      var_7 = var_9 + var_9;
    }

    thread scripts\mp\utility::giveunifiedpoints("assist", var_1, var_7);
  }

  if(level.teambased) {
    foreach(var_12 in level.players) {
      if(self.team != var_12.team || self == var_12) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_12)) {
        continue;
      }

      if(distancesquared(self.origin, var_12.origin) < 90000) {
        self.modifiers["buddy_kill"] = 1;
        break;
      }
    }
  }

  if(scripts\mp\utility::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      thread scripts\mp\utility::givestreakpointswithtext("assist_hardline", var_1, undefined);
    }

    self notify("assist_hardline");
  }

  scripts\mp\utility::incperstat("assists", 1);
  self.var_4D = scripts\mp\utility::getpersstat("assists");
  scripts\mp\persistence::statsetchild("round", "assists", self.var_4D);
  scripts\mp\utility::bufferednotify("assist_buffered", self.modifiers);
  thread scripts\mp\missions::func_D366(var_0);
  thread scripts\mp\intelchallenges::func_99B8(var_0);
  if(level.gameended) {
    scripts\mp\utility::setpersstat("streakPoints", scripts\engine\utility::ter_op(isDefined(self.streakpoints), self.streakpoints, 0));
  }
}

processshieldassist(var_0) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processshieldassist_regularmp(var_0);
}

processshieldassist_regularmp(var_0) {
  self endon("disconnect");
  var_0 endon("disconnect");
  wait(0.05);
  scripts\mp\utility::func_13842();
  if(self.pers["team"] != "axis" && self.pers["team"] != "allies") {
    return;
  }

  if(self.pers["team"] == var_0.pers["team"]) {
    return;
  }

  thread scripts\mp\utility::giveunifiedpoints("shield_assist");
  scripts\mp\utility::incperstat("assists", 1);
  self.var_4D = scripts\mp\utility::getpersstat("assists");
  scripts\mp\persistence::statsetchild("round", "assists", self.var_4D);
  thread scripts\mp\missions::func_D366(var_0);
}

func_97D2() {
  self.buffedbyplayers = [];
  self.debuffedbyplayers = [];
}

func_11ACE(var_0, var_1, var_2) {
  if(isplayer(var_1)) {
    if(!isDefined(var_1.debuffedbyplayers[var_2])) {
      var_1.debuffedbyplayers[var_2] = [];
    }

    var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] = var_0;
  }
}

untrackdebuffassist(var_0, var_1, var_2) {
  if(isplayer(var_1) && isDefined(var_1.debuffedbyplayers[var_2])) {
    var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] = undefined;
  }
}

func_11ACF(var_0, var_1, var_2, var_3) {
  var_1 endon("spawned_player");
  var_1 endon("disconnect");
  var_0 endon("disconnect");
  level endon("game_ended");
  func_11ACE(var_0, var_1, var_2);
  wait(var_3);
  untrackdebuffassist(var_0, var_1, var_2);
}

func_8BE1(var_0, var_1) {
  if(isDefined(var_0.debuffedbyplayers[var_1])) {
    var_0.debuffedbyplayers[var_1] = ::scripts\engine\utility::array_removeundefined(var_0.debuffedbyplayers[var_1]);
    return var_0.debuffedbyplayers[var_1].size > 0;
  }

  return 0;
}

getdebuffattackersbyweapon(var_0, var_1) {
  if(isDefined(var_0.debuffedbyplayers[var_1])) {
    var_0.debuffedbyplayers[var_1] = ::scripts\engine\utility::array_removeundefined(var_0.debuffedbyplayers[var_1]);
    if(var_0.debuffedbyplayers[var_1].size > 0) {
      return var_0.debuffedbyplayers[var_1];
    }
  }

  return undefined;
}

trackbuffassist(var_0, var_1, var_2) {
  if(var_0 != var_1) {
    var_3 = var_1.buffedbyplayers[var_2];
    if(!isDefined(var_1.buffedbyplayers[var_2])) {
      var_1.buffedbyplayers[var_2] = [];
    }

    var_1.buffedbyplayers[var_2][var_0 getentitynumber()] = var_0;
  }
}

untrackbuffassist(var_0, var_1, var_2) {
  if(var_0 != var_1 && isDefined(var_1.buffedbyplayers[var_2])) {
    var_1.buffedbyplayers[var_2][var_0 getentitynumber()] = undefined;
  }
}

func_11ACA(var_0, var_1, var_2, var_3) {
  var_1 endon("spawned_player");
  var_1 endon("disconnect");
  level endon("game_ended");
  trackbuffassist(var_0, var_1, var_2);
  wait(var_3);
  untrackbuffassist(var_0, var_1, var_2);
}

awardbuffdebuffassists(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_1.debuffedbyplayers) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6) && var_6.team != "spectator" && var_6 scripts\mp\utility::isenemy(var_1)) {
        var_7 = var_6.guid;
        if(!isDefined(var_2[var_7])) {
          var_2[var_7] = var_6;
        }
      }
    }
  }

  foreach(var_4 in var_0.buffedbyplayers) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6) && var_6.team != "spectator" && var_6 scripts\mp\utility::isenemy(var_1)) {
        var_7 = var_6.guid;
        if(!isDefined(var_2[var_7])) {
          var_2[var_7] = var_6;
        }
      }
    }
  }

  foreach(var_6 in var_2) {
    if(!isDefined(var_1.attackerdata) || !isDefined(var_1.attackerdata[var_6.guid])) {
      scripts\mp\damage::addattacker(var_1, var_6, undefined, "none", 0, undefined, undefined, undefined, undefined, undefined);
    }
  }
}

gamemodeusesdeathmatchscoring(var_0) {
  return var_0 == "dm" || var_0 == "sotf_ffa";
}