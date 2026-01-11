/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gamescore.gsc
************************************/

gethighestscoringplayer() {
  updateplacement();
  if(!level.placement["all"].size) {
    return undefined;
  }

  return level.placement["all"][0];
}

ishighestscoringplayertied() {
  if(level.placement["all"].size > 1) {
    var_00 = _getplayerscore(level.placement["all"][0]);
    var_01 = _getplayerscore(level.placement["all"][1]);
    return var_00 == var_01;
  }

  return 0;
}

getlosingplayers() {
  updateplacement();
  var_00 = level.placement["all"];
  var_01 = [];
  foreach(var_03 in var_00) {
    if(var_03 == level.placement["all"][0]) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

giveplayerscore(param_00, param_01) {
  if(isDefined(level.ignorescoring) && !issubstr(param_00, "assist")) {
    return;
  }

  if(!level.teambased) {
    foreach(var_03 in level.players) {
      if(scripts\mp\utility::issimultaneouskillenabled()) {
        if(var_03 != self) {
          continue;
        }

        if(level.roundscorelimit > 1 && var_03.pers["score"] >= level.roundscorelimit) {
          return;
        }

        continue;
      }

      if(level.roundscorelimit > 1 && var_03.pers["score"] >= level.roundscorelimit) {
        return;
      }
    }
  }

  var_03 = self;
  if(isDefined(self.triggerportableradarping) && !isbot(self)) {
    var_03 = self.triggerportableradarping;
  }

  if(!isplayer(var_03)) {
    return;
  }

  var_05 = param_01;
  if(isDefined(level.onplayerscore)) {
    param_01 = [[level.onplayerscore]](param_00, var_03, param_01);
  }

  if(param_01 == 0) {
    return;
  }

  var_03.pers["score"] = int(max(var_03.pers["score"] + param_01, 0));
  var_03 scripts\mp\persistence::statadd("score", var_05);
  if(var_03.pers["score"] >= -536) {
    var_03.pers["score"] = -536;
  }

  var_03.destroynavrepulsor = var_03.pers["score"];
  var_06 = var_03.destroynavrepulsor;
  var_03 scripts\mp\persistence::statsetchild("round", "score", var_06);
  var_03 scripts\mp\gamelogic::checkplayerscorelimitsoon();
  thread scripts\mp\gamelogic::checkscorelimit();
  if(scripts\mp\utility::matchmakinggame() && isDefined(level.nojip) && !level.nojip && level.gametype != "infect") {
    var_03 checkffascorejip();
  }

  var_03 scripts\mp\utility::bufferednotify("earned_score_buffered", param_01);
  scripts\mp\analyticslog::logevent_reportgamescore(param_01, gettime(), scripts\mp\rank::getscoreinfocategory(param_00, "eventID"));
  var_03 scripts\mp\matchdata::func_AFD8(param_00);
}

_setplayerscore(param_00, param_01) {
  if(param_01 == param_00.pers["score"]) {
    return;
  }

  if(param_01 < 0) {
    return;
  }

  param_00.pers["score"] = param_01;
  param_00.destroynavrepulsor = param_00.pers["score"];
  thread scripts\mp\gamelogic::checkscorelimit();
}

_getplayerscore(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  return param_00.pers["score"];
}

checkffascorejip() {
  if(level.roundscorelimit > 0) {
    var_00 = self.destroynavrepulsor / level.roundscorelimit * 100;
    if(var_00 > level.var_EC3F) {
      setnojipscore(1);
      level.nojip = 1;
    }
  }
}

giveteamscoreforobjective(param_00, param_01, param_02) {
  if(scripts\mp\utility::cantiebysimultaneouskill()) {
    param_02 = 1;
  }

  if(isDefined(level.ignorescoring)) {
    return;
  }

  if(param_02) {
    if(level.roundscorelimit > 1 && game["teamScores"][param_00] >= level.roundscorelimit) {
      return;
    }
  } else if((level.roundscorelimit > 1 && game["teamScores"][param_00] >= level.roundscorelimit) || level.roundscorelimit > 1 && game["teamScores"][level.otherteam[param_00]] >= level.roundscorelimit) {
    return;
  }

  func_13D6(param_00, _getteamscore(param_00) + param_01, param_02);
  level notify("update_team_score", param_00, _getteamscore(param_00));
  var_03 = playlocalsound(param_02);
  if(!level.splitscreen && var_03 != "none" && var_03 != level.waswinning && gettime() - level.var_AA1E > 5000 && scripts\mp\utility::getscorelimit() != 1) {
    level.var_AA1E = gettime();
    scripts\mp\utility::leaderdialog("lead_taken", var_03, "status");
    if(level.waswinning != "none") {
      scripts\mp\utility::leaderdialog("lead_lost", level.waswinning, "status");
    }
  }

  if(var_03 != "none") {
    level.waswinning = var_03;
    var_04 = _getteamscore(var_03);
    var_05 = level.roundscorelimit;
    if(var_04 == 0 || var_05 == 0) {
      return;
    }

    var_06 = var_04 / var_05 * 100;
    if(!scripts\mp\utility::isroundbased() && isDefined(level.nojip) && !level.nojip) {
      if(var_06 > level.var_EC3F) {
        setnojipscore(1);
        level.nojip = 1;
        return;
      }
    }
  }
}

playlocalsound(param_00) {
  var_01 = level.teamnamelist;
  if(!isDefined(level.waswinning)) {
    level.waswinning = "none";
  }

  var_02 = "none";
  var_03 = 0;
  if(level.waswinning != "none") {
    var_02 = level.waswinning;
    var_03 = game["teamScores"][level.waswinning];
  }

  var_04 = 1;
  foreach(var_06 in var_01) {
    if(var_06 == level.waswinning) {
      continue;
    }

    if(game["teamScores"][var_06] > var_03) {
      var_02 = var_06;
      var_03 = game["teamScores"][var_06];
      var_04 = 1;
      continue;
    }

    if(game["teamScores"][var_06] == var_03) {
      var_04 = var_04 + 1;
      var_02 = "none";
    }
  }

  return var_02;
}

func_13D6(param_00, param_01, param_02) {
  if(param_01 < 0) {
    param_01 = 0;
  }

  if(param_01 == game["teamScores"][param_00]) {
    return;
  }

  game["teamScores"][param_00] = param_01;
  updateteamscore(param_00);
  thread scripts\mp\gamelogic::func_E75E(param_00, param_02);
}

updateteamscore(param_00) {
  var_01 = 0;
  if(!scripts\mp\utility::isroundbased() || !scripts\mp\utility::isobjectivebased() || scripts\mp\utility::ismoddedroundgame()) {
    var_01 = _getteamscore(param_00);
  } else {
    var_01 = game["roundsWon"][param_00];
  }

  setteamscore(param_00, int(var_01));
}

func_12F4A(param_00) {
  if(!isDefined(game["totalScore"])) {
    game["totalScore"] = [];
    game["totalScore"]["axis"] = 0;
    game["totalScore"]["allies"] = 0;
  }

  var_01 = scripts\mp\utility::getwingamebytype();
  switch (var_01) {
    case "roundsWon":
      game["teamScores"][param_00] = game["roundsWon"][param_00];
      break;

    case "teamScores":
      if(scripts\mp\utility::inovertime()) {
        game["teamScores"][param_00] = game["preOvertimeScore"][param_00] + game["overtimeScore"][param_00] + game["teamScores"][param_00];
      } else if(scripts\mp\utility::func_E269()) {
        game["totalScore"][param_00] = game["totalScore"][param_00] + game["teamScores"][param_00];
        game["teamScores"][param_00] = game["totalScore"][param_00];
      }
      break;
  }

  setteamscore(param_00, int(game["teamScores"][param_00]));
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

_getteamscore(param_00) {
  return int(game["teamScores"][param_00]);
}

removedisconnectedplayerfromplacement() {
  var_00 = 0;
  var_01 = level.placement["all"].size;
  var_02 = 0;
  for(var_03 = 0; var_03 < var_01; var_03++) {
    if(level.placement["all"][var_03] == self) {
      var_02 = 1;
    }

    if(var_02) {
      level.placement["all"][var_03] = level.placement["all"][var_03 + 1];
    }
  }

  if(!var_02) {
    return;
  }

  level.placement["all"][var_01 - 1] = undefined;
  if(level.multiteambased) {
    func_BD7B();
  }

  if(level.teambased) {
    updateteamplacement();
  }
}

updateplacement() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(isDefined(var_02.connectedpostgame)) {
      continue;
    }

    if(var_02.pers["team"] == "spectator" || var_02.pers["team"] == "none") {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  for(var_04 = 1; var_04 < var_00.size; var_04++) {
    var_02 = var_00[var_04];
    var_05 = var_02.destroynavrepulsor;
    for(var_06 = var_04 - 1; var_06 >= 0 && func_7E06(var_02, var_00[var_06]) == var_02; var_06--) {
      var_00[var_06 + 1] = var_00[var_06];
    }

    var_00[var_06 + 1] = var_02;
  }

  level.placement["all"] = var_00;
  if(level.multiteambased) {
    func_BD7B();
  } else if(level.teambased) {
    updateteamplacement();
  }
}

func_7E06(param_00, param_01) {
  if(param_00.destroynavrepulsor > param_01.destroynavrepulsor) {
    return param_00;
  }

  if(param_01.destroynavrepulsor > param_00.destroynavrepulsor) {
    return param_01;
  }

  if(param_00.var_E9 < param_01.var_E9) {
    return param_00;
  }

  if(param_01.var_E9 < param_00.var_E9) {
    return param_01;
  }

  if(scripts\engine\utility::cointoss()) {
    return param_00;
  }

  return param_01;
}

updateteamplacement() {
  var_00["allies"] = [];
  var_00["axis"] = [];
  var_00["spectator"] = [];
  var_01 = level.placement["all"];
  var_02 = var_01.size;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = var_01[var_03];
    var_05 = var_04.pers["team"];
    var_00[var_05][var_00[var_05].size] = var_04;
  }

  level.placement["allies"] = var_00["allies"];
  level.placement["axis"] = var_00["axis"];
}

func_BD7B() {
  var_00["spectator"] = [];
  foreach(var_02 in level.teamnamelist) {
    var_00[var_02] = [];
  }

  var_04 = level.placement["all"];
  var_05 = var_04.size;
  for(var_06 = 0; var_06 < var_05; var_06++) {
    var_07 = var_04[var_06];
    var_08 = var_07.pers["team"];
    var_00[var_08][var_00[var_08].size] = var_07;
  }

  foreach(var_02 in level.teamnamelist) {
    level.placement[var_02] = var_00[var_02];
  }
}

processassist(param_00, param_01, param_02) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processassist_regularmp(param_00, param_01, param_02);
}

processassist_regularmp(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 endon("disconnect");
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  if(isDefined(param_00.ismarkedtarget)) {
    var_04 = param_00.attackers;
    var_03 = 1;
  }

  if(isDefined(param_00.markedbyboomperk)) {
    var_05 = param_00.markedbyboomperk;
  }

  wait(0.05);
  scripts\mp\utility::func_13842();
  var_06 = self.pers["team"];
  if(var_06 != "axis" && var_06 != "allies") {
    return;
  }

  if(var_06 == param_00.pers["team"] && level.teambased) {
    return;
  }

  var_07 = undefined;
  var_08 = "assist";
  if(!level.teambased) {
    var_08 = "assist_ffa";
  }

  var_09 = scripts\mp\rank::getscoreinfovalue(var_08);
  if(!level.teambased) {
    if(param_02) {
      var_07 = var_09 + var_09;
    }

    thread scripts\mp\utility::giveunifiedpoints("assist_ffa", param_01, var_07);
  } else if(scripts\mp\utility::_hasperk("specialty_mark_targets") && isDefined(var_04) && scripts\engine\utility::array_contains(var_04, self)) {
    if(param_02) {
      var_0A = scripts\mp\rank::getscoreinfovalue("assistMarked");
      var_07 = var_09 + var_0A;
    }

    thread scripts\mp\utility::givestreakpointswithtext("assistMarked", param_01, var_07);
    giveplayerscore("assist", var_09);
  } else if(isDefined(var_05) && scripts\mp\utility::func_2287(var_05, scripts\mp\utility::getuniqueid())) {
    thread scripts\mp\utility::givestreakpointswithtext("assistPing", param_01, undefined);
  } else {
    if(param_02) {
      var_07 = var_09 + var_09;
    }

    thread scripts\mp\utility::giveunifiedpoints("assist", param_01, var_07);
  }

  if(level.teambased) {
    foreach(var_0C in level.players) {
      if(self.team != var_0C.team || self == var_0C) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_0C)) {
        continue;
      }

      if(distancesquared(self.origin, var_0C.origin) < 90000) {
        self.modifiers["buddy_kill"] = 1;
        break;
      }
    }
  }

  if(scripts\mp\utility::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      thread scripts\mp\utility::givestreakpointswithtext("assist_hardline", param_01, undefined);
    }

    self notify("assist_hardline");
  }

  scripts\mp\utility::incperstat("assists", 1);
  self.var_4D = scripts\mp\utility::getpersstat("assists");
  scripts\mp\persistence::statsetchild("round", "assists", self.var_4D);
  scripts\mp\utility::bufferednotify("assist_buffered", self.modifiers);
  thread scripts\mp\missions::func_D366(param_00);
  thread scripts\mp\intelchallenges::func_99B8(param_00);
  if(level.gameended) {
    scripts\mp\utility::setpersstat("streakPoints", scripts\engine\utility::ter_op(isDefined(self.streakpoints), self.streakpoints, 0));
  }
}

processshieldassist(param_00) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processshieldassist_regularmp(param_00);
}

processshieldassist_regularmp(param_00) {
  self endon("disconnect");
  param_00 endon("disconnect");
  wait(0.05);
  scripts\mp\utility::func_13842();
  if(self.pers["team"] != "axis" && self.pers["team"] != "allies") {
    return;
  }

  if(self.pers["team"] == param_00.pers["team"]) {
    return;
  }

  thread scripts\mp\utility::giveunifiedpoints("shield_assist");
  scripts\mp\utility::incperstat("assists", 1);
  self.var_4D = scripts\mp\utility::getpersstat("assists");
  scripts\mp\persistence::statsetchild("round", "assists", self.var_4D);
  thread scripts\mp\missions::func_D366(param_00);
}

func_97D2() {
  self.buffedbyplayers = [];
  self.debuffedbyplayers = [];
}

func_11ACE(param_00, param_01, param_02) {
  if(isplayer(param_01)) {
    if(!isDefined(param_01.debuffedbyplayers[param_02])) {
      param_01.debuffedbyplayers[param_02] = [];
    }

    param_01.debuffedbyplayers[param_02][param_00 getentitynumber()] = param_00;
  }
}

untrackdebuffassist(param_00, param_01, param_02) {
  if(isplayer(param_01) && isDefined(param_01.debuffedbyplayers[param_02])) {
    param_01.debuffedbyplayers[param_02][param_00 getentitynumber()] = undefined;
  }
}

func_11ACF(param_00, param_01, param_02, param_03) {
  param_01 endon("spawned_player");
  param_01 endon("disconnect");
  param_00 endon("disconnect");
  level endon("game_ended");
  func_11ACE(param_00, param_01, param_02);
  wait(param_03);
  untrackdebuffassist(param_00, param_01, param_02);
}

func_8BE1(param_00, param_01) {
  if(isDefined(param_00.debuffedbyplayers[param_01])) {
    param_00.debuffedbyplayers[param_01] = ::scripts\engine\utility::array_removeundefined(param_00.debuffedbyplayers[param_01]);
    return param_00.debuffedbyplayers[param_01].size > 0;
  }

  return 0;
}

getdebuffattackersbyweapon(param_00, param_01) {
  if(isDefined(param_00.debuffedbyplayers[param_01])) {
    param_00.debuffedbyplayers[param_01] = ::scripts\engine\utility::array_removeundefined(param_00.debuffedbyplayers[param_01]);
    if(param_00.debuffedbyplayers[param_01].size > 0) {
      return param_00.debuffedbyplayers[param_01];
    }
  }

  return undefined;
}

trackbuffassist(param_00, param_01, param_02) {
  if(param_00 != param_01) {
    var_03 = param_01.buffedbyplayers[param_02];
    if(!isDefined(param_01.buffedbyplayers[param_02])) {
      param_01.buffedbyplayers[param_02] = [];
    }

    param_01.buffedbyplayers[param_02][param_00 getentitynumber()] = param_00;
  }
}

untrackbuffassist(param_00, param_01, param_02) {
  if(param_00 != param_01 && isDefined(param_01.buffedbyplayers[param_02])) {
    param_01.buffedbyplayers[param_02][param_00 getentitynumber()] = undefined;
  }
}

func_11ACA(param_00, param_01, param_02, param_03) {
  param_01 endon("spawned_player");
  param_01 endon("disconnect");
  level endon("game_ended");
  trackbuffassist(param_00, param_01, param_02);
  wait(param_03);
  untrackbuffassist(param_00, param_01, param_02);
}

awardbuffdebuffassists(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_01.debuffedbyplayers) {
    foreach(var_06 in var_04) {
      if(isDefined(var_06) && var_06.team != "spectator" && var_06 scripts\mp\utility::isenemy(param_01)) {
        var_07 = var_06.guid;
        if(!isDefined(var_02[var_07])) {
          var_02[var_07] = var_06;
        }
      }
    }
  }

  foreach(var_04 in param_00.buffedbyplayers) {
    foreach(var_06 in var_04) {
      if(isDefined(var_06) && var_06.team != "spectator" && var_06 scripts\mp\utility::isenemy(param_01)) {
        var_07 = var_06.guid;
        if(!isDefined(var_02[var_07])) {
          var_02[var_07] = var_06;
        }
      }
    }
  }

  foreach(var_06 in var_02) {
    if(!isDefined(param_01.attackerdata) || !isDefined(param_01.attackerdata[var_06.guid])) {
      scripts\mp\damage::addattacker(param_01, var_06, undefined, "none", 0, undefined, undefined, undefined, undefined, undefined);
    }
  }
}

gamemodeusesdeathmatchscoring(param_00) {
  return param_00 == "dm" || param_00 == "sotf_ffa";
}