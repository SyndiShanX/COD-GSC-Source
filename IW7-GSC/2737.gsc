/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2737.gsc
***************************************/

gethighestscoringplayer() {
  updateplacement();

  if(!level.placement["all"].size) {
    return undefined;
  }
  else {
    return level.placement["all"][0];
  }
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
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

giveplayerscore(var_00, var_01) {
  if(isDefined(level.ignorescoring) && !issubstr(var_00, "assist")) {
    return;
  }
  if(!level.teambased) {
    foreach(var_03 in level.players) {
      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(var_03 != self) {
          continue;
        }
        if(level.roundscorelimit > 1 && var_3.pers["score"] >= level.roundscorelimit) {
          return;
        }
      } else if(level.roundscorelimit > 1 && var_3.pers["score"] >= level.roundscorelimit)
        return;
    }
  }

  var_03 = self;

  if(isDefined(self.owner) && !isbot(self)) {
    var_03 = self.owner;
  }

  if(!isplayer(var_03)) {
    return;
  }
  var_05 = var_01;

  if(isDefined(level.onplayerscore)) {
    var_01 = [[level.onplayerscore]](var_00, var_03, var_01);
  }

  if(var_01 == 0) {
    return;
  }
  var_3.pers["score"] = int(max(var_3.pers["score"] + var_01, 0));
  var_03 scripts\mp\persistence::statadd("score", var_05);

  if(var_3.pers["score"] >= 65000) {
    var_3.pers["score"] = 65000;
  }

  var_3.score = var_3.pers["score"];
  var_06 = var_3.score;
  var_03 scripts\mp\persistence::statsetchild("round", "score", var_06);
  var_03 scripts\mp\gamelogic::checkplayerscorelimitsoon();
  thread scripts\mp\gamelogic::checkscorelimit();

  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level.nojip) && !level.nojip && level.gametype != "infect") {
    var_03 checkffascorejip();
  }

  var_03 scripts\mp\utility\game::bufferednotify("earned_score_buffered", var_01);
  scripts\mp\analyticslog::logevent_reportgamescore(var_01, gettime(), scripts\mp\rank::getscoreinfocategory(var_00, "eventID"));
  var_03 scripts\mp\matchdata::func_AFD8(var_00);
}

_setplayerscore(var_00, var_01) {
  if(var_01 == var_0.pers["score"]) {
    return;
  }
  if(var_01 < 0) {
    return;
  }
  var_0.pers["score"] = var_01;
  var_0.score = var_0.pers["score"];
  thread scripts\mp\gamelogic::checkscorelimit();
}

_getplayerscore(var_00) {
  if(!isDefined(var_00)) {
    var_00 = self;
  }

  return var_0.pers["score"];
}

checkffascorejip() {
  if(level.roundscorelimit > 0) {
    var_00 = self.score / level.roundscorelimit * 100;

    if(var_00 > level.func_EC3F) {
      setnojipscore(1);
      level.nojip = 1;
    }
  }
}

giveteamscoreforobjective(var_00, var_01, var_02) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill()) {
    var_02 = 1;
  }

  if(isDefined(level.ignorescoring)) {
    return;
  }
  if(var_02) {
    if(level.roundscorelimit > 1 && game["teamScores"][var_00] >= level.roundscorelimit) {
      return;
    }
  } else if(level.roundscorelimit > 1 && game["teamScores"][var_00] >= level.roundscorelimit || level.roundscorelimit > 1 && game["teamScores"][level.otherteam[var_00]] >= level.roundscorelimit) {
    return;
  }
  func_13D6(var_00, _getteamscore(var_00) + var_01, var_02);
  level notify("update_team_score", var_00, _getteamscore(var_00));
  var_03 = playlocalsound(var_02);

  if(!level.splitscreen && var_03 != "none" && var_03 != level.waswinning && gettime() - level.func_AA1E > 5000 && scripts\mp\utility\game::getscorelimit() != 1) {
    level.func_AA1E = gettime();
    scripts\mp\utility\game::leaderdialog("lead_taken", var_03, "status");

    if(level.waswinning != "none") {
      scripts\mp\utility\game::leaderdialog("lead_lost", level.waswinning, "status");
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

    if(!scripts\mp\utility\game::isroundbased() && isDefined(level.nojip) && !level.nojip) {
      if(var_06 > level.func_EC3F) {
        setnojipscore(1);
        level.nojip = 1;
      }
    }
  }
}

playlocalsound(var_00) {
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

func_13D6(var_00, var_01, var_02) {
  if(var_01 < 0) {
    var_01 = 0;
  }

  if(var_01 == game["teamScores"][var_00]) {
    return;
  }
  game["teamScores"][var_00] = var_01;
  updateteamscore(var_00);
  thread scripts\mp\gamelogic::func_E75E(var_00, var_02);
}

updateteamscore(var_00) {
  var_01 = 0;

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    var_01 = _getteamscore(var_00);
  }
  else {
    var_01 = game["roundsWon"][var_00];
  }

  setteamscore(var_00, int(var_01));
}

func_12F4A(var_00) {
  if(!isDefined(game["totalScore"])) {
    game["totalScore"] = [];
    game["totalScore"]["axis"] = 0;
    game["totalScore"]["allies"] = 0;
  }

  var_01 = scripts\mp\utility\game::getwingamebytype();

  switch (var_01) {
    case "roundsWon":
      game["teamScores"][var_00] = game["roundsWon"][var_00];
      break;
    case "teamScores":
      if(scripts\mp\utility\game::inovertime()) {
        game["teamScores"][var_00] = game["preOvertimeScore"][var_00] + game["overtimeScore"][var_00] + game["teamScores"][var_00];
      }
      else if(scripts\mp\utility\game::func_E269()) {
        game["totalScore"][var_00] = game["totalScore"][var_00] + game["teamScores"][var_00];
        game["teamScores"][var_00] = game["totalScore"][var_00];
      }

      break;
  }

  setteamscore(var_00, int(game["teamScores"][var_00]));
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

  game["overtimeScore"]["allies"] = game["overtimeScore"]["allies"] + (game["teamScores"]["allies"] - game["preOvertimeScore"]["allies"]);
  game["overtimeScore"]["axis"] = game["overtimeScore"]["axis"] + (game["teamScores"]["axis"] - game["preOvertimeScore"]["axis"]);

  if(!scripts\mp\utility\game::iswinbytworulegametype()) {
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);

    if(scripts\mp\utility\game::istimetobeatvalid() && game["timeToBeatTeam"] == game["attackers"]) {
      game["teamScores"][game["attackers"]] = game["timeToBeatScore"];
      updateteamscore(game["attackers"]);
      game["overtimeScore"][game["attackers"]] = game["overtimeScore"][game["attackers"]] - game["timeToBeatScore"];
    }

    if(scripts\mp\utility\game::istimetobeatvalid() && game["timeToBeatTeam"] == game["defenders"]) {
      game["teamScores"][game["defenders"]] = game["timeToBeatScore"];
      updateteamscore(game["defenders"]);
      game["overtimeScore"][game["defenders"]] = game["overtimeScore"][game["defenders"]] - game["timeToBeatScore"];
    }
  }
}

_getteamscore(var_00) {
  return int(game["teamScores"][var_00]);
}

removedisconnectedplayerfromplacement() {
  var_00 = 0;
  var_01 = level.placement["all"].size;
  var_02 = 0;

  for(var_03 = 0; var_03 < var_01; var_3++) {
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
    return;
  }
}

updateplacement() {
  var_00 = [];

  foreach(var_02 in level.players) {
    if(isDefined(var_2.connectedpostgame)) {
      continue;
    }
    if(var_2.pers["team"] == "spectator" || var_2.pers["team"] == "none") {
      continue;
    }
    var_0[var_0.size] = var_02;
  }

  for(var_04 = 1; var_04 < var_0.size; var_4++) {
    var_02 = var_0[var_04];
    var_05 = var_2.score;

    for(var_06 = var_04 - 1; var_06 >= 0 && func_7E06(var_02, var_0[var_06]) == var_02; var_6--) {
      var_0[var_06 + 1] = var_0[var_06];
    }

    var_0[var_06 + 1] = var_02;
  }

  level.placement["all"] = var_00;

  if(level.multiteambased) {
    func_BD7B();
  }
  else if(level.teambased) {
    updateteamplacement();
  }
}

func_7E06(var_00, var_01) {
  if(var_0.score > var_1.score) {
    return var_00;
  }

  if(var_1.score > var_0.score) {
    return var_01;
  }

  if(var_0.deaths < var_1.deaths) {
    return var_00;
  }

  if(var_1.deaths < var_0.deaths) {
    return var_01;
  }

  if(scripts\engine\utility::cointoss()) {
    return var_00;
  }
  else {
    return var_01;
  }
}

updateteamplacement() {
  var_0["allies"] = [];
  var_0["axis"] = [];
  var_0["spectator"] = [];
  var_01 = level.placement["all"];
  var_02 = var_1.size;

  for(var_03 = 0; var_03 < var_02; var_3++) {
    var_04 = var_1[var_03];
    var_05 = var_4.pers["team"];
    var_0[var_05][var_0[var_05].size] = var_04;
  }

  level.placement["allies"] = var_0["allies"];
  level.placement["axis"] = var_0["axis"];
}

func_BD7B() {
  var_0["spectator"] = [];

  foreach(var_02 in level.teamnamelist) {
  var_0[var_02] = [];
  }

  var_04 = level.placement["all"];
  var_05 = var_4.size;

  for(var_06 = 0; var_06 < var_05; var_6++) {
    var_07 = var_4[var_06];
    var_08 = var_7.pers["team"];
    var_0[var_08][var_0[var_08].size] = var_07;
  }

  foreach(var_02 in level.teamnamelist) {
  level.placement[var_02] = var_0[var_02];
  }
}

processassist(var_00, var_01, var_02) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  processassist_regularmp(var_00, var_01, var_02);
}

processassist_regularmp(var_00, var_01, var_02) {
  self endon("disconnect");
  var_00 endon("disconnect");
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;

  if(isDefined(var_0.ismarkedtarget)) {
    var_04 = var_0.attackers;
    var_03 = 1;
  }

  if(isDefined(var_0.markedbyboomperk)) {
    var_05 = var_0.markedbyboomperk;
  }

  wait 0.05;
  scripts\mp\utility\game::func_13842();
  var_06 = self.pers["team"];

  if(var_06 != "axis" && var_06 != "allies") {
    return;
  }
  if(var_06 == var_0.pers["team"] && level.teambased) {
    return;
  }
  var_07 = undefined;
  var_08 = "assist";

  if(!level.teambased) {
    var_08 = "assist_ffa";
  }

  var_09 = scripts\mp\rank::getscoreinfovalue(var_08);

  if(!level.teambased) {
    if(var_02) {
      var_07 = var_09 + var_09;
    }

    thread scripts\mp\utility\game::giveunifiedpoints("assist_ffa", var_01, var_07);
  } else if(scripts\mp\utility\game::_hasperk("specialty_mark_targets") && (isDefined(var_04) && scripts\engine\utility::array_contains(var_04, self))) {
    if(var_02) {
      var_10 = scripts\mp\rank::getscoreinfovalue("assistMarked");
      var_07 = var_09 + var_10;
    }

    thread scripts\mp\utility\game::givestreakpointswithtext("assistMarked", var_01, var_07);
    giveplayerscore("assist", var_09);
  } else if(isDefined(var_05) && scripts\mp\utility\game::func_2287(var_05, scripts\mp\utility\game::getuniqueid()))
    thread scripts\mp\utility\game::givestreakpointswithtext("assistPing", var_01, undefined);
  else {
    if(var_02) {
      var_07 = var_09 + var_09;
    }

    thread scripts\mp\utility\game::giveunifiedpoints("assist", var_01, var_07);
  }

  if(level.teambased) {
    foreach(var_12 in level.players) {
      if(self.team != var_12.team || self == var_12) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_12)) {
        continue;
      }
      if(distancesquared(self.origin, var_12.origin) < 90000) {
        self.modifiers["buddy_kill"] = 1;
        break;
      }
    }
  }

  if(scripts\mp\utility\game::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      thread scripts\mp\utility\game::givestreakpointswithtext("assist_hardline", var_01, undefined);
    }

    self notify("assist_hardline");
  }

  scripts\mp\utility\game::incperstat("assists", 1);
  self.assists = scripts\mp\utility\game::getpersstat("assists");
  scripts\mp\persistence::statsetchild("round", "assists", self.assists);
  scripts\mp\utility\game::bufferednotify("assist_buffered", self.modifiers);
  thread scripts\mp\missions::func_D366(var_00);
  thread scripts\mp\intelchallenges::func_99B8(var_00);

  if(level.gameended) {
    scripts\mp\utility\game::func_F7DF("streakPoints", scripts\engine\utility::ter_op(isDefined(self.streakpoints), self.streakpoints, 0));
  }
}

processshieldassist(var_00) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  processshieldassist_regularmp(var_00);
}

processshieldassist_regularmp(var_00) {
  self endon("disconnect");
  var_00 endon("disconnect");
  wait 0.05;
  scripts\mp\utility\game::func_13842();

  if(self.pers["team"] != "axis" && self.pers["team"] != "allies") {
    return;
  }
  if(self.pers["team"] == var_0.pers["team"]) {
    return;
  }
  thread scripts\mp\utility\game::giveunifiedpoints("shield_assist");
  scripts\mp\utility\game::incperstat("assists", 1);
  self.assists = scripts\mp\utility\game::getpersstat("assists");
  scripts\mp\persistence::statsetchild("round", "assists", self.assists);
  thread scripts\mp\missions::func_D366(var_00);
}

func_97D2() {
  self.buffedbyplayers = [];
  self.debuffedbyplayers = [];
}

func_11ACE(var_00, var_01, var_02) {
  if(isplayer(var_01)) {
    if(!isDefined(var_1.debuffedbyplayers[var_02])) {
      var_1.debuffedbyplayers[var_02] = [];
    }

    var_1.debuffedbyplayers[var_02][var_00 getentitynumber()] = var_00;
  }
}

untrackdebuffassist(var_00, var_01, var_02) {
  if(isplayer(var_01) && isDefined(var_1.debuffedbyplayers[var_02])) {
    var_1.debuffedbyplayers[var_02][var_00 getentitynumber()] = undefined;
  }
}

func_11ACF(var_00, var_01, var_02, var_03) {
  var_01 endon("spawned_player");
  var_01 endon("disconnect");
  var_00 endon("disconnect");
  level endon("game_ended");
  func_11ACE(var_00, var_01, var_02);
  wait(var_03);
  untrackdebuffassist(var_00, var_01, var_02);
}

func_8BE1(var_00, var_01) {
  if(isDefined(var_0.debuffedbyplayers[var_01])) {
    var_0.debuffedbyplayers[var_01] = ::scripts\engine\utility::array_removeundefined(var_0.debuffedbyplayers[var_01]);
    return var_0.debuffedbyplayers[var_01].size > 0;
  }

  return 0;
}

getdebuffattackersbyweapon(var_00, var_01) {
  if(isDefined(var_0.debuffedbyplayers[var_01])) {
    var_0.debuffedbyplayers[var_01] = ::scripts\engine\utility::array_removeundefined(var_0.debuffedbyplayers[var_01]);

    if(var_0.debuffedbyplayers[var_01].size > 0) {
      return var_0.debuffedbyplayers[var_01];
    }
  }

  return undefined;
}

trackbuffassist(var_00, var_01, var_02) {
  if(var_00 != var_01) {
    var_03 = var_1.buffedbyplayers[var_02];

    if(!isDefined(var_1.buffedbyplayers[var_02])) {
      var_1.buffedbyplayers[var_02] = [];
    }

    var_1.buffedbyplayers[var_02][var_00 getentitynumber()] = var_00;
  }
}

untrackbuffassist(var_00, var_01, var_02) {
  if(var_00 != var_01 && isDefined(var_1.buffedbyplayers[var_02])) {
    var_1.buffedbyplayers[var_02][var_00 getentitynumber()] = undefined;
  }
}

func_11ACA(var_00, var_01, var_02, var_03) {
  var_01 endon("spawned_player");
  var_01 endon("disconnect");
  level endon("game_ended");
  trackbuffassist(var_00, var_01, var_02);
  wait(var_03);
  untrackbuffassist(var_00, var_01, var_02);
}

awardbuffdebuffassists(var_00, var_01) {
  var_02 = [];

  foreach(var_09, var_04 in var_1.debuffedbyplayers) {
    foreach(var_08, var_06 in var_04) {
      if(isDefined(var_06) && var_6.team != "spectator" && var_06 scripts\mp\utility\game::isenemy(var_01)) {
        var_07 = var_6.guid;

        if(!isDefined(var_2[var_07])) {
          var_2[var_07] = var_06;
        }
      }
    }
  }

  foreach(var_04 in var_0.buffedbyplayers) {
    foreach(var_08, var_06 in var_04) {
      if(isDefined(var_06) && var_6.team != "spectator" && var_06 scripts\mp\utility\game::isenemy(var_01)) {
        var_07 = var_6.guid;

        if(!isDefined(var_2[var_07])) {
          var_2[var_07] = var_06;
        }
      }
    }
  }

  foreach(var_07, var_06 in var_02) {
    if(!isDefined(var_1.attackerdata) || !isDefined(var_1.attackerdata[var_6.guid])) {
      scripts\mp\damage::addattacker(var_01, var_06, undefined, "none", 0, undefined, undefined, undefined, undefined, undefined);
    }
  }
}

gamemodeusesdeathmatchscoring(var_00) {
  return var_00 == "dm" || var_00 == "sotf_ffa";
}