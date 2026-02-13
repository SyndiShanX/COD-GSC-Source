/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2706.gsc
*************************************************/

_id_6BE2(var_0) {
  return scripts\mp\utility\teams::_id_6A01(var_0);
}

_id_6DE6() {
  if(!isDefined(level._id_E72D) || !isDefined(level._id_4B0D)) {
    return 0;
  }

  if(level._id_F262) {
    return level._id_F25E - level._id_E72D - level._id_4B0D - level._id_AD75;
  } else {
    return gettime() - level._id_E72D - level._id_4B0D - level._id_AD75;
  }
}

gettimepassedwithpauses() {
  return gettime() - level._id_E72D - level._id_AD75;
}

_id_6DE7() {
  var_0 = _id_6DE5();

  if(var_0 == 0) {
    return 0;
  }

  return _id_6DE6() / (_id_6DE5() * 1000) * 100;
}

_id_6D1C() {
  return _id_6DE6() / 1000;
}

_id_6B5F() {
  return _id_6D1C() / 60;
}

_id_D73A(var_0, var_1) {
  self endon("disconnect");

  if(istrue(level._id_A731)) {
    return;
  }
  if(!isDefined(self._id_58B3)) {
    self._id_58B3 = 0.0;
  }

  if(self._id_58B3 == var_0) {
    return;
  }
  if(isDefined(var_1)) {
    wait(var_1);
  }

  self notify("setUIPostGameFade");
  self endon("setUIPostGameFade");

  if(self._id_58B3 < var_0) {
    self._id_58B3 = clamp(self._id_58B3 + 0.5 * abs(self._id_58B3 - var_0), 0.0, 1.0);
  } else {
    self._id_58B3 = clamp(self._id_58B3 - 0.5 * abs(self._id_58B3 - var_0), 0.0, 1.0);
  }

  self setclientomnvar("ui_total_fade", self._id_58B3);
  wait 0.1;
  self._id_58B3 = var_0;
  self setclientomnvar("ui_total_fade", self._id_58B3);
}

_id_C2AA(var_0, var_1, var_2, var_3) {
  scripts\mp\utility\dvars::_id_C2CB("roundswitch", var_1);
  var_0 = _func_0483("#x3ecead486797add6d", var_0, "_roundswitch");
  level._id_C94A = var_0;
  level._id_C94C = var_2;
  level._id_C94B = var_3;
  level._id_C949 = getdvarint(var_0, var_1);

  if(level._id_C949 < var_2) {
    level._id_C949 = var_2;
  } else if(level._id_C949 > var_3) {
    level._id_C949 = var_3;
  }
}

_id_C2A9(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("roundlimit", var_1);
}

_id_C280(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("numTeams", var_1);
}

_id_C2D0(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("winlimit", var_1);
}

_id_C2CE(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("winbytwoenabled", var_1);
}

_id_C2CF(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("winbytwomaxrounds", var_1);
}

_id_C250(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("dogtags", var_1);
}

_id_C2AD(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("scorelimit", var_1);
}

_id_C2C1(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CA("timelimit", var_1);
  setDvar("#x3104db9210faa6c71", _id_6DE5());
}

_id_C25D(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("halftime", var_1);
  setDvar("#x39012b36ea0ddda7", _id_6A8D());
}

_id_C27E(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("numlives", var_1);
}

_id_C27F(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("numrevives", var_1);
}

_id_D635(var_0) {
  setDvar("#x37e4e50d48ecc6215", var_0);
}

_id_C26C(var_0) {
  scripts\mp\utility\dvars::_id_C2CB("lastStandHealth", var_0);
}

_id_C26F(var_0) {
  scripts\mp\utility\dvars::_id_C2CB("lastStandReviveHealth", var_0);
}

_id_C272(var_0) {
  scripts\mp\utility\dvars::_id_C2CA("lastStandTimer", var_0);
}

_id_C270(var_0) {
  scripts\mp\utility\dvars::_id_C2CA("lastStandReviveTimer", var_0);
}

_id_C274(var_0) {
  scripts\mp\utility\dvars::_id_C2C9("lastStandWeapon", var_0);
}

_id_C273(var_0) {
  scripts\mp\utility\dvars::_id_C2CA("lastStandWeaponDelay", var_0);
}

_id_C271(var_0) {
  scripts\mp\utility\dvars::_id_C2CA("lastStandSuicideTimer", var_0);
}

_id_C26D(var_0) {
  scripts\mp\utility\dvars::_id_C2CA("lastStandInvulnTimer", var_0);
}

_id_C26E(var_0) {
  scripts\mp\utility\dvars::_id_C2CA("lastStandReviveDecayScale", var_0);
}

isroundbased() {
  if(!level.teambased) {
    return 0;
  }

  if(level._id_10E52 != 1 && level._id_C943 != 1) {
    return 1;
  }

  if(getgametype() == "sr" || getgametype() == "sd" || getgametype() == "siege" || getgametype() == "cyber" || getgametype() == "mtmc" || getgametype() == "control") {
    return 1;
  }

  return 0;
}

_id_885C() {
  if(!level.teambased) {
    return 1;
  }

  if(game["roundsPlayed"] == 0) {
    return 1;
  }

  return 0;
}

_id_A4CD() {
  if(level._id_5E90) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(level._id_C943 > 1 && game["roundsPlayed"] >= level._id_C943 - 1 && !_id_8AA1() && !_id_8A16()) {
    return 1;
  }

  if(_id_896C() && (_id_79B4() || _id_79C3())) {
    if(_id_DBBD() && _id_8904()) {
      return 1;
    } else if(_id_8AA1() || _id_8A16()) {
      if(game["overtimeRoundsPlayed"] == 1) {
        return 1;
      }
    } else if(!level._id_B8A9)
      return 1;
  }

  var_0 = 0;

  foreach(var_2 in level._id_EF89) {
    var_3 = _id_6CFE(var_2);

    if(var_3 == level._id_10E52 - 1) {
      var_0 = 1;
      break;
    }
  }

  var_5 = level._id_10E52 > 0 && var_0;

  if(var_5 && _id_15F1()) {
    if(_id_896C()) {
      return 0;
    } else {
      return 1;
    }
  }

  return 0;
}

_id_A4CE() {
  if(level._id_5E90) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(level._id_C943 > 1 && game["roundsPlayed"] >= level._id_C943 - 1 && !_id_8AA1() && !_id_8A16()) {
    return 1;
  }

  if(_id_896C() && (_id_79B4() || _id_79C3())) {
    if(_id_DBBD() && _id_8904()) {
      return 1;
    } else if(_id_8AA1() || _id_8A16()) {
      if(game["overtimeRoundsPlayed"] == 1) {
        return 1;
      }
    } else if(!level._id_B8A9)
      return 1;
  }

  var_0 = 0;

  foreach(var_2 in level._id_EF89) {
    var_3 = _id_6CFE(var_2);

    if(var_3 == level._id_10E52 - 1) {
      return 1;
    }
  }

  return 0;
}

_id_10A1B() {
  if(level._id_B8A9) {
    return 0;
  }

  if(!level.teambased) {
    return 1;
  }

  if(isDefined(level._id_AB36)) {
    return 0;
  }

  if(level._id_10E52 == 1 && _id_79C3()) {
    return 1;
  }

  if(level._id_C943 == 1) {
    return 1;
  }

  return 0;
}

_id_10A16() {
  if(level._id_5E90) {
    return 1;
  }

  if(istrue(level._id_411A)) {
    return 1;
  }

  if(_id_10A1B()) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(_id_79B4() || _id_79C3()) {
    return !level._id_B8A9;
  }

  return 0;
}

_id_8B13() {
  switch (getgametype()) {
    case "arena_evo":
    case "arena":
    case "siege":
    case "sr":
    case "sd":
      return getdvarint(_func_0483("#x3ecead486797add6d", getgametype(), "_winByTwoEnabled"), 0) == 1;
  }

  return 0;
}

_id_6B4E() {
  return getdvarint(_func_0483("#x3ecead486797add6d", getgametype(), "_winByTwoMaxRounds"), level._id_10E52);
}

_id_DBBD() {
  var_0 = game["roundsWon"]["allies"];
  var_1 = game["roundsWon"]["axis"];
  return _id_8B13() && abs(var_0 - var_1) < 2 && game["overtimeRoundsPlayed"] < _id_6B4E();
}

_id_8904() {
  return _id_DBBD() && game["overtimeRoundsPlayed"] == _id_6B4E() - 1;
}

_id_8AA1() {
  switch (getgametype()) {
    case "payload":
    case "ball":
    case "ctf":
      return 1;
  }

  return 0;
}

_id_8424() {
  return isDefined(game["status"]) && game["status"] == "recordTTB";
}

_id_D728(var_0) {
  if(!_id_8AA1()) {
    return 0;
  }

  var_1 = _id_6D1C();
  var_2 = scripts\mp\gamescore::_id_0C0F(var_0);

  if(!_id_8AA2() || var_1 < game["timeToBeat"] && var_2 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var_0) {
      game["timeToBeatOld"] = game["timeToBeat"];
    }

    game["timeToBeat"] = var_1;
    game["timeToBeatTeam"] = var_0;
    game["timeToBeatScore"] = var_2;
    return 1;
  }

  return 0;
}

_id_8AA2() {
  return game["timeToBeat"] != 0;
}

_id_DBBB() {
  return _id_8AA2() && game["overtimeRoundsPlayed"] == 1;
}

_id_8A16() {
  switch (getgametype()) {
    case "rush":
      return 1;
  }

  return 0;
}

_id_D6B6(var_0, var_1) {
  if(!_id_8A16()) {
    return 0;
  }

  var_2 = game["timeToBeatTeam"] != "none" && var_1 == game["timeToBeatScore"];

  if(var_1 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var_0) {
      game["timeToBeatScoreOld"] = game["timeToBeatScore"];
    }

    game["timeToBeatTeam"] = var_0;
    game["timeToBeatScore"] = var_1;
  }

  foreach(var_4 in level.players) {
    var_4 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_4.team == game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
    var_4 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_4.team != game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
  }

  if(var_2) {
    return "tie";
  } else {
    return game["timeToBeatTeam"];
  }
}

_id_DBAD() {
  return _id_8A16() && game["overtimeRoundsPlayed"] == 1;
}

_id_896C() {
  if(isgamebattlematch()) {
    return 1;
  }

  switch (getgametype()) {
    case "cmd":
    case "blitz":
    case "rush":
    case "payload":
    case "ball":
    case "ctf":
      return 1;
    case "dd":
    case "arena_evo":
    case "arena":
    case "siege":
    case "sr":
    case "sd":
      return _id_8B13();
  }

  return 0;
}

_id_6B42() {
  if(isgamebattlematch()) {
    return -1;
  }

  var_0 = 0;

  switch (getgametype()) {
    case "blitz":
    case "payload":
    case "ball":
    case "ctf":
    case "siege":
    case "sr":
    case "sd":
      var_0 = 2;
      break;
    case "cmd":
    case "dd":
      var_0 = 1;
      break;
  }

  if(isanymlgmatch() && !_id_8AA1()) {
    return -1;
  }

  return var_0;
}

_id_6E99() {
  if(!isDefined(level._id_10E4B)) {
    if(!isroundbased() || !_id_8957() || _id_8935()) {
      level._id_10E4B = "teamScores";
    } else {
      level._id_10E4B = "roundsWon";
    }
  }

  return level._id_10E4B;
}

_id_8A37() {
  if(!isDefined(level._id_DD51)) {
    level._id_DD51 = getdvarint("#x39d01ff793b8b9e26", 0) == 0;
  }

  return level._id_DD51;
}

_id_31F6() {
  if(!_id_8A37()) {
    return 0;
  }

  var_0 = 0;

  switch (getgametype()) {
    case "dm":
    case "war":
    case "gun":
    case "base":
    case "front":
    case "arm":
      var_0 = 1;
  }

  return var_0;
}

_id_DBA7() {
  if(!_id_79B4() && !_id_79C3()) {
    return 0;
  }

  if(!_id_896C()) {
    return 0;
  }

  var_0 = _id_15F1();

  if(var_0 && _id_82D1()) {
    var_1 = _id_6B42();
    var_0 = scripts\engine\utility::ter_op(var_1 == -1, 1, game["overtimeRoundsPlayed"] < var_1);
  }

  var_2 = _id_DBBD();
  var_3 = _id_DBBB();
  var_4 = _id_DBAD();
  return !level._id_5E90 && (var_0 || var_2 || var_3 || var_4);
}

_id_C63F() {
  if(istrue(level._id_C63F)) {
    return 1;
  }

  return (getgametype() == "ctf" || getgametype() == "blitz") && !_id_82D1() && _id_6E99() == "roundsWon";
}

_id_31B1() {
  if(!isDefined(level._id_4971)) {
    level._id_4971 = 0;
  }

  if(level._id_4971) {
    return 0;
  }

  switch (getgametype()) {
    case "grnd":
    case "grind":
    case "dm":
    case "war":
    case "hq":
    case "pill":
    case "conf":
    case "tdef":
    case "koth":
    case "dd":
    case "ball":
    case "dom":
    case "infect":
    case "base":
    case "front":
    case "arm":
      return 1;
    case "mp_zomb":
    case "gun":
    case "ctf":
    case "siege":
    case "sr":
    case "sd":
      return 0;
    default:
      return 0;
  }
}

_id_79C1() {
  if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") <= 0) {
    return 0;
  }

  var_0 = scripts\mp\gamelogic::_id_6DE8();

  if(var_0 > 0) {
    return 0;
  }

  return 1;
}

_id_79B4() {
  if(level._id_C943 <= 0) {
    return 0;
  }

  return game["roundsPlayed"] >= level._id_C943;
}

_id_79B7() {
  if(_id_8957()) {
    return 0;
  }

  if(level._id_C948 <= 0) {
    return 0;
  }

  if(level.teambased) {
    foreach(var_1 in level._id_EF89) {
      if(game["teamScores"][var_1] >= level._id_C948) {
        return 1;
      }
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(isDefined(var_4._id_038F) && var_4._id_038F >= level._id_C948) {
        return 1;
      }
    }
  }

  return 0;
}

_id_79C3() {
  if(level._id_10E52 <= 0) {
    return 0;
  }

  if(!level.teambased) {
    return 1;
  }

  foreach(var_1 in level._id_EF89) {
    if(_id_6CFE(var_1) >= level._id_10E52) {
      return 1;
    }
  }

  return 0;
}

_id_6D0E() {
  if(isroundbased()) {
    if(level._id_C943) {
      return level._id_C943;
    } else {
      return level._id_10E52;
    }
  } else
    return level._id_C948;
}

_id_6CFE(var_0) {
  return game["roundsWon"][var_0];
}

_id_15F1() {
  var_0 = _id_6E99();
  var_1 = undefined;

  foreach(var_3 in level._id_EF89) {
    if(!isDefined(var_1)) {
      var_1 = game[var_0][var_3];
      continue;
    }

    if(var_1 != game[var_0][var_3]) {
      return 0;
    }
  }

  return 1;
}

_id_8957() {
  return level._id_A8D4;
}

_id_6DE5() {
  if(_id_82D1() && (!isDefined(game["inNukeOvertime"]) || !game["inNukeOvertime"])) {
    if(istrue(game["timeToBeat"])) {
      return game["timeToBeat"];
    } else {
      var_0 = getdvarfloat("#x37e4e50d48ecc6215");

      if(var_0 > 0) {
        return var_0;
      } else {
        return scripts\mp\utility\dvars::getwatcheddvar("timelimit");
      }
    }
  } else if(isDefined(level._id_5856) && level._id_5856 > 0)
    return scripts\mp\utility\dvars::getwatcheddvar("timelimit") + level._id_5856;
  else {
    return scripts\mp\utility\dvars::getwatcheddvar("timelimit");
  }
}

_id_6A8D() {
  if(_id_82D1()) {
    return 0;
  } else if(isDefined(game["inNukeOvertime"]) && game["inNukeOvertime"]) {
    return 0;
  } else {
    return scripts\mp\utility\dvars::getwatcheddvar("halftime");
  }
}

_id_82D1() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

_id_60C5() {
  if(isDefined(level._id_60C5)) {
    return level._id_60C5;
  }

  if(level.teambased) {
    foreach(var_1 in level._id_EF89) {
      if(scripts\mp\utility\teams::_id_6DCA(var_1, "hasSpawned")) {
        return 1;
      }
    }

    return 0;
  }

  return level._id_9C91 > 1;
}

_id_6B13(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(level.teambased && isDefined(var_0)) {
      if(var_0 == var_3.pers["team"]) {
        var_1[var_1.size] = var_3;
      }

      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

rankingenabled() {
  if(!isPlayer(self)) {
    return 0;
  }

  return level.rankedmatch && !self.usingonlinedataoffline;
}

onlinestatsenabled() {
  if(!isPlayer(self)) {
    return 0;
  }

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

privatematch() {
  return level.onlinegame && getdvarint("#x310c28bb5d64c8c6d");
}

_id_96B9() {
  return level.systemlink || privatematch() && getdvarint("#x35101132aac5ed425", 0) || _func_0474();
}

matchmakinggame() {
  return level.matchmakingmatch;
}

_id_6A65() {
  return scripts\mp\utility\dvars::getwatcheddvar("numlives");
}

_id_6AF7(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }
    if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() && !var_3 scripts\mp\playerlogic::_id_9CCD()) {
      continue;
    }
    if(isDefined(var_3._id_EC33) && var_3._id_EC33) {
      continue;
    }
    var_1 = var_3;
  }

  return var_1;
}

_id_F744() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive() && !var_2 scripts\mp\playerlogic::_id_9CCD()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(var_2 _meth_81D3()) {
        continue;
      }
    }

    if(isDefined(var_0)) {
      return undefined;
    } else {
      var_0 = var_2;
    }
  }

  if(isDefined(var_0)) {
    return var_0;
  } else {
    return undefined;
  }
}

_id_6C7B() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive() && !var_2 scripts\mp\playerlogic::_id_9CCD()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(var_2 _meth_81D3()) {
        continue;
      }
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_47C7() {
  if(!isbot(self) && !_func_03DA(self)) {
    if(isgamebattlematch()) {
      return 1;
    }

    if(_func_0394()) {
      return 1;
    }

    if(level.codcasterenabled) {
      return 0;
    }
  }

  if(getdvarint("#x3eef4e390f811e19", 0) > 0 && getgametype() != "arena_evo") {
    return 1;
  }

  return 0;
}

_id_15DB() {
  if(getgametype() == "br" || getgametype() == "cranked") {
    return level.teambased;
  }

  var_0 = _id_4C79();
  return var_0;
}

_id_4C79() {
  if(getgametype() == "gun" || getgametype() == "infect") {
    return 0;
  }

  var_0 = int(_func_0222("mp/gametypesTable.csv", 0, getgametype(), 4));
  return var_0 > 0;
}

_id_159D() {
  if(getDvar("#x3f59526763711edc4", "") == "dmz" && !scripts\mp\gametypes\br_public::_id_8805()) {
    return 1;
  }

  if(getdvarint("#x3eef4e390f811e19", 0) > 0 || _id_DDB2()) {
    return 0;
  }

  if(isDefined(level._id_159E)) {
    var_0 = self[[level._id_159E]]();

    if(isDefined(var_0)) {
      return var_0;
    }
  }

  if(_id_07D1::_id_60BE("infil_will_run") && isDefined(level._id_2DF4)) {
    return 0;
  }

  var_1 = int(_func_0222("mp/gametypesTable.csv", 0, getgametype(), 5));

  if(!isai(self) && istrue(level._id_47C6)) {
    return 0;
  }

  return var_1;
}

_id_DDB2() {
  if(getgametype() == "dm") {
    return istrue(level._id_191E);
  } else if(_id_875E()) {
    return isDefined(level._id_1AB9) && !scripts\mp\gametypes\arena::_id_8950();
  }

  return 0;
}

_id_DCA8() {
  return 0;
}

_id_D559(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3 = [];

  if(var_2 != "s4_me_knife_mp") {
    var_3 = getweaponattachments(var_0);
  }

  if(isDefined(var_2)) {
    var_4 = tablelookuprownum("mp/statstable.csv", 4, var_2);
  } else {}

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = -1;

    if(isDefined(var_3[var_5])) {
      if(!scripts\mp\utility\weapon::_id_876D(var_0, var_3[var_5])) {
        var_6 = tablelookuprownum("mp/attachmenttable.csv", 4, var_3[var_5]);
      }
    }
  }
}

_id_D4E0(var_0) {
  var_1 = getmatchrulesdata("commonOption", "teamCount");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_teamcount"), var_1);
  var_2 = getmatchrulesdata("commonOption", "teamSize");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_teamsize"), var_2);
  var_3 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_timeLimit"), var_3);
  _id_C2C1(getgametype(), var_3);
  var_4 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_scoreLimit"), var_4);
  _id_C2AD(getgametype(), var_4);
  var_5 = getmatchrulesdata("commonOption", "winLimit");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_winLimit"), var_5);
  _id_C2D0(getgametype(), var_5);
  var_6 = getmatchrulesdata("commonOption", "roundLimit");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_roundLimit"), var_6);
  _id_C2A9(getgametype(), var_6);
  var_7 = getmatchrulesdata("commonOption", "roundSwitch");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_roundSwitch"), var_7);
  _id_C2AA(getgametype(), var_7, 0, 9);
  var_8 = getmatchrulesdata("commonOption", "winByTwoEnabled");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_winByTwoEnabled"), var_8);
  _id_C2CE(getgametype(), var_8);
  var_9 = getmatchrulesdata("commonOption", "winByTwoMaxRounds");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_winByTwoMaxRounds"), var_9);
  _id_C2CF(getgametype(), var_9);
  var_10 = getmatchrulesdata("commonOption", "dogTags");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_dogTags"), var_10);
  _id_C250(getgametype(), var_10);
  var_11 = getmatchrulesdata("commonOption", "spawnProtectionTimer");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_spawnProtectionTimer"), var_11);
  var_12 = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_numLives"), var_12);
  _id_C27E(getgametype(), var_12);
  var_13 = getmatchrulesdata("commonOption", "numRevives");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_numRevives"), var_13);
  _id_C27F(getgametype(), var_13);
  setdynamicdvar("#x3479ab28f2a947c0b", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("#x362b15ff47d91275", getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_healthregentime"), getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar("#x38a080e5753995a0e", getmatchrulesdata("commonOption", "disableSuperSprint"));
  setdynamicdvar("#x3284bff713458c19c", getmatchrulesdata("commonOption", "disableMount"));
  setdynamicdvar("#x389465c9e5fd57277", getmatchrulesdata("commonOption", "lastStand"));
  var_14 = getmatchrulesdata("commonOption", "lastStandHealth");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_lastStandHealth"), var_14);
  _id_C26C(var_14);
  var_15 = getmatchrulesdata("commonOption", "lastStandReviveHealth");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_lastStandReviveHealth"), var_15);
  _id_C26F(var_15);
  var_16 = getmatchrulesdata("commonOption", "lastStandTimer");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_lastStandTimer"), var_16);
  _id_C272(var_16);
  var_17 = getmatchrulesdata("commonOption", "lastStandReviveTimer");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_lastStandReviveTimer"), var_17);
  _id_C270(var_17);
  var_18 = getmatchrulesdata("commonOption", "lastStandSuicideTimer");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_lastStandSuicideTimer"), var_18);
  _id_C271(var_18);
  setdynamicdvar("#x3d0ea3eb869e01e13", getmatchrulesdata("commonOption", "reviveUseWeapon"));
  level._id_9BEB = 0;
  setdynamicdvar("#x3d6afcc65fe7f67aa", getmatchrulesdata("commonOption", "vampirism"));
  setdynamicdvar("#x3579f4929fab8a387", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar("#x3ce8d42bddf1541b4", getmatchrulesdata("commonOption", "showKillcam"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_killcamType"), getmatchrulesdata("commonOption", "killcamType"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_allow3rdspectate"), getmatchrulesdata("commonOption", "spectate3rdAllowed"));
  setdynamicdvar("#x31109f5b6dd29a6e6", getmatchrulesdata("commonOption", "enableMinimap"));
  setdynamicdvar("#x3a93070affbb9fe0d", getmatchrulesdata("commonOption", "radarAlwaysOn"));
  setdynamicdvar("#x32f81e060e8d0db85", getmatchrulesdata("commonOption", "radarHideShots"));
  setdynamicdvar("#x3c7468d1968d8d216", getmatchrulesdata("commonOption", "compassHideEnemy"));
  setdynamicdvar("#x3ead41b8a49a25c23", getmatchrulesdata("commonOption", "compassHidePings"));
  setdynamicdvar("#x341f25c791e305774", getmatchrulesdata("commonOption", "disableSpawnCamera"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_playerrespawndelay"), getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_suicidespawndelay"), getmatchrulesdata("commonOption", "suicideSpawnDelay"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_waverespawndelay"), getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_waverespawndelay_alt"), getmatchrulesdata("commonOption", "waveRespawnDelayAlt"));
  setdynamicdvar("#x388d06624940c1a88", getmatchrulesdata("commonOption", "forceRespawn"));
  level._id_9BEA = getmatchrulesdata("commonOption", "allowCustomClasses");
  level._id_EB9B = getmatchrulesdata("commonOption", "allowIntel");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_allowKillstreaks"), getmatchrulesdata("commonOption", "allowKillstreaks"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_allowPerks"), getmatchrulesdata("commonOption", "allowPerks"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_allowSupers"), getmatchrulesdata("commonOption", "allowSupers"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_ffPunishLimit"), getmatchrulesdata("commonOption", "ffPunishLimit"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_ffPunishDamageLimit"), getmatchrulesdata("commonOption", "ffPunishDamageLimit"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_ffKickKillLimit"), getmatchrulesdata("commonOption", "ffKickKillLimit"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_ffKickDamageLimit"), getmatchrulesdata("commonOption", "ffKickDamageLimit"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_roundRetainStreaks"), getmatchrulesdata("commonOption", "roundRetainStreaks"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_roundRetainStreakProg"), getmatchrulesdata("commonOption", "roundRetainStreakProg"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_deathRetainStreaks"), getmatchrulesdata("commonOption", "deathRetainStreaks"));
  setdynamicdvar("#x3432a8e2d2ff30b5c", getmatchrulesdata("commonOption", "casualScoreStreaks"));
  setdynamicdvar("#x3d8cdb2888c027343", getmatchrulesdata("commonOption", "superFastChargeRate"));
  setdynamicdvar("#x34b9531497edc4554", getmatchrulesdata("commonOption", "superPointsMod"));
  setdynamicdvar("#x3cb9a97ad46da0c11", getmatchrulesdata("commonOption", "spawnProtectionTimer"));
  setdynamicdvar("#x3b87c0767505c186d", getmatchrulesdata("commonOption", "equipmentDelay"));
  setdynamicdvar("#x3e417a96cc4b8ec0b", getmatchrulesdata("commonOption", "equipmentMSProtect"));
  setdynamicdvar("#x389cb40ede8807023", getmatchrulesdata("commonOption", "disableBattleChatter"));
  setdynamicdvar("#x33467774880efa057", getmatchrulesdata("commonOption", "disableAnnouncer"));
  setdynamicdvar("#x32e44d746af5106c7", getmatchrulesdata("commonOption", "inGameLoot"));
  setdynamicdvar("#x3a08e9b38f4c4fb5", !getmatchrulesdata("commonOption", "infilSkip"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_practiceRound"), getmatchrulesdata("commonOption", "practiceRound"));
  setdynamicdvar("#x3b079c8c024dfa5bc", getmatchrulesdata("commonOption", "postGameExfil"));
  setdynamicdvar("#x3716709b4bc793392", getmatchrulesdata("commonOption", "exfilExtractTimer"));
  setdynamicdvar("#x3cb457dcd5f272ca7", getmatchrulesdata("commonOption", "exfilActiveTimer"));
  setdynamicdvar("#x320bae50718405307", getmatchrulesdata("commonOption", "postGameExfilWeapon"));
  level._id_3E5B = getmatchrulesdata("commonOption", "crankedBombTimer");
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_crankedBombTimer"), level._id_3E5B);
  _id_07C1::_id_C24D(getgametype(), level._id_3E5B);
  setdynamicdvar("#x375eeee513fa18366", getmatchrulesdata("commonOption", "magCount"));
  setdynamicdvar("#x3ced75240913bc3ea", getmatchrulesdata("commonOption", "tacticalMode"));
  setdynamicdvar("#x39bbda22bdf02c2dd", getmatchrulesdata("commonOption", "headshotsOnly"));

  if(!isDefined(var_0)) {
    setdynamicdvar("#x3ee6d1b6a4d407071", getmatchrulesdata("commonOption", "friendlyFire"));
  }

  setDvar("#x3ca984a865792777", getdvarint("#x3a93070affbb9fe0d") == 1);
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_enemyDeathLoc"), getmatchrulesdata("commonOption", "enemyDeathLoc"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_pointsPerKill"), getmatchrulesdata("commonOption", "pointsPerKill"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_pointsPerDeath"), getmatchrulesdata("commonOption", "pointsPerDeath"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_pointsHeadshotBonus"), getmatchrulesdata("commonOption", "pointsHeadshotBonus"));
  setdynamicdvar(_func_0483("#x3ecead486797add6d", getgametype(), "_pointsPerKSKill"), getmatchrulesdata("commonOption", "pointsPerKSKill"));
  setdynamicdvar("#x39d926b5216be9575", 0);
  setdynamicdvar("#x3806a10bc0145262", "");
  setdynamicdvar("#x3dfcdef2d7e684127", "");
  level.dynamicmapelementsdisabled = getmatchrulesdata("commonOption", "dynamicMapElementsDisabled");
  setdynamicdvar("#x34fd987f51fc15bcf", level.dynamicmapelementsdisabled);

  if(privatematch() || level.systemlink || isanymlgmatch()) {
    level.codcasterenabled = getmatchrulesdata("commonOption", "codcasterEnabled");
    setDvar("#x32570320b7015b225", level.codcasterenabled);
    setdynamicdvar("#x34b4ccd29370ba1c9", getmatchrulesdata("commonOption", "interactiveMapDisabled"));
    setdynamicdvar("#x3d4e90ea01c7bc02a", getmatchrulesdata("commonOption", "matchStartTime"));
    setdynamicdvar("#x334b1a553207e33a5", getmatchrulesdata("commonOption", "roundStartTime"));
  }

  if(getdvarint("#x36d59e1875e0931f6", 0)) {
    level.killstreakcost = [];
    level.killstreakcost["intel"] = getmatchrulesdata("commonOption", "killstreakCost", "intel");
    level.killstreakcost["airdrop"] = getmatchrulesdata("commonOption", "killstreakCost", "airdrop");
    level.killstreakcost["uav"] = getmatchrulesdata("commonOption", "killstreakCost", "uav");
    level.killstreakcost["counter_spy_plane"] = getmatchrulesdata("commonOption", "killstreakCost", "counter_spy_plane");
    level.killstreakcost["glide_bomb"] = getmatchrulesdata("commonOption", "killstreakCost", "glide_bomb");
    level.killstreakcost["mortar_barrage"] = getmatchrulesdata("commonOption", "killstreakCost", "mortar_barrage");
    level.killstreakcost["warmachine"] = getmatchrulesdata("commonOption", "killstreakCost", "warmachine");
    level.killstreakcost["guard_dog"] = getmatchrulesdata("commonOption", "killstreakCost", "guard_dog");
    level.killstreakcost["precision_airstrike"] = getmatchrulesdata("commonOption", "killstreakCost", "precision_airstrike");
    level.killstreakcost["toma_strike"] = getmatchrulesdata("commonOption", "killstreakCost", "toma_strike");
    level.killstreakcost["lmg_streak"] = getmatchrulesdata("commonOption", "killstreakCost", "lmg_streak");
    level.killstreakcost["airdrop_multiple"] = getmatchrulesdata("commonOption", "killstreakCost", "airdrop_multiple");
    level.killstreakcost["juggernaut"] = getmatchrulesdata("commonOption", "killstreakCost", "juggernaut");
    level.killstreakcost["attack_dogs"] = getmatchrulesdata("commonOption", "killstreakCost", "attack_dogs");
    level.killstreakcost["white_phosphorus"] = getmatchrulesdata("commonOption", "killstreakCost", "white_phosphorus");
    level.killstreakcost["directional_uav"] = getmatchrulesdata("commonOption", "killstreakCost", "directional_uav");
    level.killstreakcost["ball_turret_gunner"] = getmatchrulesdata("commonOption", "killstreakCost", "ball_turret_gunner");
    level.killstreakcost["nuke"] = getmatchrulesdata("commonOption", "killstreakCost", "nuke");
  }

  if(getdvarint("#x393b122bef6f4094a", 0)) {
    setDvar("#x3a4ce86068e44cb1f", getmatchrulesdata("commonOption", "disableSuppressiveFire") == 0);
  }

  if(getdvarint("#x3f8ed31e0d3d1c5da", 0)) {
    setDvar("#x3ecbb52b8224db574", getmatchrulesdata("commonOption", "disableCombatFog"));
  }

  if(getdvarint("#x3c0c45396a0966888", 0)) {
    setDvar("#x36c05a3ff3ee5fdd8", getmatchrulesdata("commonOption", "removeDestructibleWalls"));
  }

  if(getdvarint("#x333f144ce358e4f88", 0)) {
    var_19 = getmatchrulesdata("commonOption", "removeDestructibleDoors");
    setDvar("#x3cd7e830922e3674e", var_19);

    if(var_19) {
      setdynamicdvar("#x3a08e9b38f4c4fb5", 0);
    }
  }

  if(getdvarint("#x33cf136dc36cbd985", 0)) {
    setDvar("#x32e749a3e3f8f6085", getmatchrulesdata("commonOption", "killstreakDelay"));
  }
}

_id_C2EB() {
  for(;;) {
    level waittill("host_migration_begin");
    [[level._id_81E5]]();
  }
}

_id_C2EC(var_0) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    var_0 endon("death");
  }

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self._id_90C4)) {
      self visionsetthermalforplayer(self._id_90C4, 0);
    }
  }
}

_id_6B33(var_0, var_1) {
  var_2 = [];
  var_2["loadoutPrimaryAttachment2"] = "none";
  var_2["loadoutSecondaryAttachment2"] = "none";
  var_3 = [];
  var_2["loadoutPrimary"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "weapon");
  var_2["loadoutPrimaryAttachment"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "attachmentSetup", 0, "attachment");
  var_2["loadoutPrimaryAttachment2"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "attachmentSetup", 1, "attachment");
  var_2["loadoutPrimaryCamo"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "camo");
  var_2["loadoutPrimaryReticle"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "reticle");
  var_2["loadoutSecondary"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "weapon");
  var_2["loadoutSecondaryAttachment"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "attachmentSetup", 0, "attachment");
  var_2["loadoutSecondaryAttachment2"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "attachmentSetup", 1, "attachment");
  var_2["loadoutSecondaryCamo"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "camo");
  var_2["loadoutSecondaryReticle"] = _id_6B32("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "reticle");
  var_2["loadoutPerks"] = var_3;
  var_2["loadoutKillstreak1"] = ::scripts\mp\class::_id_C111(var_0, var_1, 0);
  var_2["loadoutKillstreak2"] = ::scripts\mp\class::_id_C111(var_0, var_1, 1);
  var_2["loadoutKillstreak3"] = ::scripts\mp\class::_id_C111(var_0, var_1, 2);
  return var_2;
}

_id_899A(var_0) {
  if(isDefined(level._id_A8E8)) {
    foreach(var_2 in level._id_A8E8) {
      if(self istouching(var_2._id_A6C9)) {
        return 0;
      }
    }
  }

  return 1;
}

_id_60C4(var_0) {
  switch (var_0) {
    case "sotf":
    case "sotf_ffa":
      return 1;
    default:
      return 0;
  }
}

isanymlgmatch() {
  if(_func_0127()) {
    if(getdvarint("#x3b4ea11a56b3db121") == 0 && getmatchrulesdata("cwlRulesEnabled") == 1) {
      return 1;
    }
  }

  return getdvarint("#x3fca802e5beab0d71");
}

isanymlgmatchignoreafk() {
  var_0 = 0;

  if(isanymlgmatch()) {
    var_0 = 1;

    if(level.leagueplaymatch && getdvarint("#x3beeb43782742b93f") == 0) {
      var_0 = 0;
    }
  }

  return var_0;
}

_id_8934() {
  if(level.systemlink && getdvarint("#x3fca802e5beab0d71")) {
    return 1;
  }

  return 0;
}

_id_8933() {
  if(privatematch() && getdvarint("#x3fca802e5beab0d71")) {
    return 1;
  }

  return 0;
}

_id_8932() {
  if(_id_8934() || _id_8933()) {
    return 1;
  }

  return 0;
}

_id_D5FA(var_0, var_1, var_2, var_3) {
  if(var_1 == "axis") {
    var_0 = var_0 + 1000;
  } else if(var_1 == "allies") {
    var_0 = var_0 + 2000;
  }

  if(isDefined(var_2)) {
    var_0 = var_0 + (var_2 + 1) * 10000;
  }

  if(isDefined(var_3)) {
    if(_func_02B7(var_3)) {
      var_0 = var_0 + (var_3 + 1) * 1000000;
    } else {
      scripts\engine\utility::_id_5598("mlg announcement extra data supports numbers only. Invalid extra data: " + var_3);
    }
  }

  if(isDefined(var_0)) {
    setomnvar("ui_mlg_announcement", var_0);
  }
}

_id_8935() {
  if(getgametype() == "dom" || getgametype() == "ctf" || getgametype() == "rush" || getgametype() == "blitz") {
    return 1;
  }

  return 0;
}

_id_8AC8(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    if(_func_0127() && _id_6B32("defaultClasses", var_0, var_1, "class", "inUse")) {
      var_2 = 1;
    }
  } else {
    for(var_1 = 0; var_1 < 6; var_1++) {
      if(_func_0127() && _id_6B32("defaultClasses", var_0, var_1, "class", "inUse")) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

_id_6B32(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_1 == "axis") {
    var_2 = var_2 + 6;
  }

  if(isDefined(var_6)) {
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5);
  } else {
    return getmatchrulesdata(var_0, var_2, var_3, var_4);
  }
}

_id_8A48() {
  return gettime() < self._id_E393 + level._id_8DE7;
}

_id_8923() {
  return isDefined(level._id_E72D) && gettime() < level._id_E72D + level._id_555F;
}

_id_6C73() {
  var_0 = "";

  if(matchmakinggame()) {
    var_1 = _func_00C5();
    var_0 = _func_0445(var_1);
  }

  return var_0;
}

getgametype() {
  return level.gametype;
}

_id_60FA() {
  var_0 = getgametype();

  if(var_0 == "arena_evo" || var_0 == "base") {
    return 1;
  }

  return 0;
}

_id_6D9E() {
  var_0 = getgametype();

  if(var_0 == "br") {
    var_1 = getDvar("#x3f59526763711edc4", "");

    if(var_1 != "") {
      return var_1;
    }
  }

  return var_0;
}

_id_8A6F() {
  var_0 = getgametype();
  var_1 = _id_6D9E();
  return var_0 != var_1;
}

_id_98D3() {
  if(getdvarint("#x3547dc3fd835e6467") == 1) {
    return 1;
  }

  if(getdvarint("#x360c8b99288a05999", 0) == 1 && getgametype() == "base") {
    return 1;
  }

  if(getgametype() == "arm" || getgametype() == "br" || level.leanthread == 1) {
    return 1;
  }

  return 0;
}

_id_CA4B() {
  if(getdvarint("#x3547dc3fd835e6467") == 1) {
    return 1;
  }

  if(getgametype() == "br" || level.leanthread == 1) {
    return 1;
  }

  return 0;
}

_id_8A5F() {
  return getdvarint("#x3acded9dbd574bf5c", 0) > 1;
}

_id_60C3() {
  if(!isDefined(game["infil"])) {
    return 0;
  }

  var_0 = 1;

  foreach(var_2 in level._id_EF89) {
    if(!isDefined(game["infil"][var_2]) || !isDefined(game["infil"][var_2]["lanes"])) {
      var_0 = 0;
      break;
    }
  }

  return var_0;
}

_id_EF76(var_0) {
  return _id_60C3() && scripts\mp\utility\teams::_id_8878(var_0) && isDefined(game["infil"][var_0]["lanes"]);
}

_id_88EE() {
  return _id_078D::_id_85B3() || _id_873C();
}

_id_873C() {
  if(getdvarint("#x36f036f45f5e148b6", 0) == 1) {
    return 1;
  }

  if(self.team == "spectator") {
    return 0;
  }

  if(isDefined(level._id_136E) && istrue(level._id_136E[self.team])) {
    return 1;
  }

  return 0;
}

_id_6B41() {
  var_0 = level._id_AD0A;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("#x3d069d6df30e4aa2", 3));
    level._id_AD0A = var_0;
  }

  return var_0;
}

_id_6B3E() {
  var_0 = level._id_AD09;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("#x329497bd766f81f0e", 3));
    level._id_AD09 = var_0;
  }

  return var_0;
}

_id_6B3F() {
  var_0 = level._id_AD0C;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("#x3785af42abd0629c3", 3));
    level._id_AD0C = var_0;
  }

  return var_0;
}

_id_6B40() {
  level._id_AD0D = 5;
  return level._id_AD0D;
}

_id_6B3D() {
  level._id_AD0B = 5;
  return level._id_AD0B;
}

getarmsraceoutofboundstime() {
  level.outofboundstimearmsrace = 3;
  return level.outofboundstimearmsrace;
}

_id_FCD2() {
  if(self.pers["team"] == "spectator") {
    self setclientdvar("#x3bc529cd1392d30f5", "");
  } else {
    if(level._id_C948 > 0 && !_id_8957()) {
      if(isDefined(_id_6BBF(self.pers["team"]))) {
        if(level.splitscreen) {
          self setclientdvar("#x3bc529cd1392d30f5", _id_6BBF(self.pers["team"]));
          return;
        }

        self setclientdvar("#x3bc529cd1392d30f5", _id_6BBF(self.pers["team"]), level._id_C948);
        return;
        return;
      }

      return;
    }

    if(isDefined(_id_6BC2(self.pers["team"]))) {
      self setclientdvar("#x3bc529cd1392d30f5", _id_6BC2(self.pers["team"]));
    }
  }
}

_id_D61C(var_0, var_1) {
  game["strings"]["objective_" + var_0] = var_1;
}

_id_D61A(var_0, var_1) {
  game["strings"]["objective_score_" + var_0] = var_1;
}

_id_D615(var_0, var_1) {
  game["strings"]["objective_hint_" + var_0] = var_1;
}

_id_6BC2(var_0) {
  return game["strings"]["objective_" + var_0];
}

_id_6BBF(var_0) {
  return game["strings"]["objective_score_" + var_0];
}

_id_6BBE(var_0) {
  return game["strings"]["objective_hint_" + var_0];
}

_id_F0D8(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || var_1 == "") {
    return 0;
  }

  return issubstr(var_0, var_1);
}

_id_8902() {
  return isDefined(level._id_0271) && level._id_0271 == 1;
}

_id_8A95() {
  return isDefined(level._id_0271) && level._id_0271 == 2;
}

_id_3551() {
  if(istrue(level._id_F0E0)) {
    if(!isDefined(self._id_89EC)) {
      if(scripts\engine\utility::cointoss()) {
        self setclientomnvar("ui_realism_hud", 1);
        self._id_89EC = 1;
      } else {
        self setclientomnvar("ui_realism_hud", 0);
        self._id_89EC = 0;
      }
    }
  } else if(scripts\cp_mp\utility\game_utility::_id_89EC())
    self setclientomnvar("ui_realism_hud", 1);
  else {
    self setclientomnvar("ui_realism_hud", 0);
  }
}

_id_87F6(var_0) {
  var_1 = 0;

  switch (getgametype()) {
    case "cyber":
      if(isDefined(level._id_429C._id_32D5) && self.team == level._id_429C._id_ADAE && self != level._id_429C._id_32D5) {
        var_2 = distancesquared(level._id_429C._id_32D5.origin, self.origin);
        var_3 = distancesquared(level._id_429C._id_32D5.origin, var_0.origin);

        if(var_2 < 90000 || var_3 < 90000) {
          var_1 = 1;
          break;
        }
      }

      foreach(var_5 in level._id_A8E8) {
        if(istrue(var_5.trigger._id_F5E0)) {
          continue;
        }
        var_6 = var_5._id_ADAE;

        if(var_6 == self.team) {
          var_2 = distancesquared(var_5.trigger.origin, self.origin);
          var_3 = distancesquared(var_5.trigger.origin, var_0.origin);

          if(var_2 < 90000 || var_3 < 90000) {
            var_1 = 1;
            break;
          }
        }
      }

      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team != game["defenders"]) {
        break;
      }

      foreach(var_9 in level._id_A8E8) {
        var_10 = distancesquared(var_9.trigger.origin, var_0.origin);

        if(var_10 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "grind":
    case "pill":
    case "siege":
    case "dom":
    case "base":
    case "arm":
      foreach(var_9 in level._id_A8E8) {
        if(self.team != var_9._id_ADAE) {
          continue;
        }
        var_13 = distancesquared(var_9._id_4140, self.origin);
        var_14 = distancesquared(var_9._id_4140, var_0.origin);

        if(var_13 < 90000 || var_14 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "grnd":
    case "mendota":
    case "kspoint":
    case "hq":
    case "koth":
    case "patrol":
      if(isDefined(level._id_110CF)) {
        var_1 = _func_011A(self.origin, level._id_110CF.trigger) || _func_011A(var_0.origin, level._id_110CF.trigger);
      }

      break;
  }

  return var_1;
}

_id_8768(var_0) {
  var_1 = 0;

  switch (getgametype()) {
    case "cyber":
      if(istrue(var_0._id_8783)) {
        var_1 = 1;
        break;
      }

      if(isDefined(level._id_429C._id_32D5) && self.team == level._id_429C._id_ADAE && self != level._id_429C._id_32D5) {
        var_2 = distancesquared(level._id_429C._id_32D5.origin, self.origin);
        var_3 = distancesquared(level._id_429C._id_32D5.origin, var_0.origin);

        if(var_2 < 90000 || var_3 < 90000) {
          var_1 = 1;
          break;
        }
      }

      foreach(var_5 in level._id_A8E8) {
        if(istrue(var_5.trigger._id_F5E0)) {
          continue;
        }
        var_6 = var_5._id_ADAE;

        if(var_6 != self.team) {
          var_7 = distancesquared(var_5.trigger.origin, self.origin);
          var_8 = distancesquared(var_5.trigger.origin, var_0.origin);

          if(var_7 < 90000 || var_8 < 90000) {
            var_1 = 1;
            break;
          }
        }
      }

      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team == game["defenders"]) {
        break;
      }

      foreach(var_11 in level._id_A8E8) {
        var_12 = distancesquared(var_11.trigger.origin, var_0.origin);

        if(var_12 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "grind":
    case "pill":
    case "siege":
    case "dom":
    case "base":
    case "arm":
      foreach(var_11 in level._id_A8E8) {
        if(self.team == var_11._id_ADAE) {
          continue;
        }
        var_7 = distancesquared(var_11._id_4140, self.origin);
        var_8 = distancesquared(var_11._id_4140, var_0.origin);

        if(var_7 < 90000 || var_8 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "grnd":
    case "hq":
    case "koth":
    case "patrol":
      if(isDefined(level._id_110CF)) {
        var_1 = _func_011A(self.origin, level._id_110CF.trigger) || _func_011A(var_0.origin, level._id_110CF.trigger);
      }

      break;
  }

  return var_1;
}

_id_60F7() {
  switch (getgametype()) {
    case "war":
    case "trial":
    case "infect":
    case "base":
    case "br":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

_id_9ACA() {
  switch (level.mapname) {
    case "mp_firingrange":
    case "mp_farms2":
    case "mp_br_mechanics":
    case "mp_boneyard_gw":
    case "mp_quarry2":
    case "mp_donetsk":
    case "mp_downtown_gw":
    case "mp_farms2_gw":
    case "mp_port2_gw":
    case "mp_locale_test":
      return 1;
    default:
      return 0;
  }
}

_id_875E() {
  switch (getgametype()) {
    case "arena":
      return 1;
    default:
      return 0;
  }
}

_id_875D() {
  switch (getgametype()) {
    case "arena_evo":
      return 1;
    default:
      return 0;
  }
}

isarmsracegametype() {
  switch (getgametype()) {
    case "base":
      return 1;
    default:
      return 0;
  }
}

_id_60F9() {
  if(!level.teambased) {
    return 0;
  }

  switch (getgametype()) {
    case "arena_evo":
    case "arena":
      return 0;
    default:
      return 1;
  }
}

gametypesupportss4infils() {
  if(isbasegametype() && !getdvarint("#x3a9194e61efd7e0fc", 0)) {
    return 0;
  }

  switch (getgametype()) {
    case "arena_evo":
    case "arena":
      return 0;
    default:
      return 1;
  }
}

gametypestopsclock() {
  switch (getgametype()) {
    case "grnd":
    case "kspoint":
    case "hq":
    case "koth":
    case "control":
    case "patrol":
      return 1;
    default:
      return 0;
  }
}

_id_8701() {
  return getdvarint("#x3356440afeaa4319", 0);
}

isbasegametype() {
  switch (getgametype()) {
    case "base":
      return 1;
    default:
      return 0;
  }
}

isholidayenabled(var_0) {
  if(isanymlgmatch()) {
    return 0;
  }

  return getdvarint("#x32180fa7fd65a3faa", 0) == var_0;
}

modesupportsloadoutsharing() {
  switch (getgametype()) {
    case "gun":
    case "infect":
    case "base":
      return 0;
    default:
      return 1;
  }
}

ismatchidunderthreshold(var_0) {
  var_1 = _func_048D();
  var_2 = int(_func_00D6(var_1, var_1.size - 2));
  return var_2 < var_0;
}

isrecentbadspawncriticalfactorenabled() {
  var_0 = getdvarint("#x312ca0b19e02bc647", 0);
  return ismatchidunderthreshold(var_0);
}

getexperimentaldvarsetnumber() {
  var_0 = getdvarint("#x362075248d18c02ef", 0);

  if(ismatchidunderthreshold(var_0)) {
    return 1;
  }

  var_1 = var_0 + getdvarint("#x363b7fbc5cf89e049", 0);

  if(ismatchidunderthreshold(var_1)) {
    return 2;
  }

  var_2 = var_1 + getdvarint("#x37e2e19b84ebaa633", 0);

  if(ismatchidunderthreshold(var_2)) {
    return 3;
  }

  var_3 = var_2 + getdvarint("#x3668bc5183d388cb5", 0);

  if(ismatchidunderthreshold(var_3)) {
    return 4;
  }

  var_4 = var_3 + getdvarint("#x373cae31acde46c45", 0);

  if(ismatchidunderthreshold(var_4)) {
    return 5;
  }

  return 0;
}