/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\hub.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  setDvar("4014", 1);
  maps\mp\gametypes\_globallogic::init();
  lib_01DD::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  level.rankedmatch = 0;
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 0);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setteammode("hub");
  maps\mp\_utility::func_873B(1);
  level.callbackplayerconnect = ::onhubplayerconnect;
  level.var_746E = function_02EE();
  level.var_6BAF = ::func_6BAF;
  level.onnormaldeath = ::onnormaldeath;
  level.var_4696 = ::func_4696;
  level.var_2F85 = 1;
  level.var_1B3E = 1;
  level.var_1385 = ::func_4F48;
  level.var_6BA7 = ::func_6BA7;
  level.var_1DEA = ::hubclass;
  level.var_2FAB = 1;
  level.disabledivisionstats = 1;
  level.var_2F8B = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
}

onhubplayerconnect() {
  self method_8506(0);
  [[::maps\mp\gametypes\_playerlogic::callback_playerconnect]]();
}

func_4F48() {
  if(!isDefined(self.pers["team"])) {
    if(function_02EE() == "axis") {
      thread maps\mp\gametypes\_menus::func_873A("axis");
      self.sessionteam = "axis";
      return;
    }

    thread maps\mp\gametypes\_menus::func_873A("allies");
    self.sessionteam = "allies";
  }
}

func_6BA7() {
  if(isDefined(level.var_A592)) {
    self[[level.var_A592]]();
  }
}

hubclass() {
  self.var_294D = maps\mp\gametypes\_class::func_1E05();
  self.class = "custom" + self.var_294D + 1;
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_hub_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("hub", 0, 0, 9);
  setdynamicdvar("scr_hub_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("war", 1);
  setdynamicdvar("scr_hub_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("hub", 1);
  setdynamicdvar("scr_hub_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("hub", 0);
}

onnormaldeath(param_00, param_01, param_02) {
  level maps\mp\gametypes\_gamescore::func_47BD(param_01.pers["team"], 1, 0);
  if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.var_6C63[param_01.team]]) {
    param_01.finalkill = 1;
  }
}

func_6BB6() {
  level.var_3B5C = "none";
  if(game["status"] == "overtime") {
    var_00 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_00 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level.var_3B5C = "axis";
    var_00 = "axis";
  } else {
    level.var_3B5C = "allies";
    var_00 = "allies";
  }

  if(maps\mp\_utility::practiceroundgame()) {
    var_00 = "none";
  }

  thread maps\mp\gametypes\_gamelogic::endgame(var_00, game["end_reason"]["time_limit_reached"]);
}

func_6BAF() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_HUB");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_HUB");
  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_HUB");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_HUB");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_HUB_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_HUB_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR_HINT");
  lib_050D::func_10E4();
  var_02[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_02);
}

func_4696() {
  if(isDefined(level.var_A7A2)) {
    [[level.var_A7A2]]("mp_hub_spawn_5_tr");
  }

  while(!isDefined(level.var_5FEB)) {
    wait 0.05;
  }

  var_00 = self;
  if(isDefined(var_00.var_572A) && var_00.var_572A && isDefined(var_00.var_6B25)) {
    return [[var_00.var_6B25]](var_00);
  }

  if(isDefined(level.var_13AC)) {
    return [[level.var_13AC]](var_00);
  }

  if(getdvarint("986", 0) == 1 && isDefined(level.var_A5A0)) {
    return [[level.var_A5A0]](var_00);
  }

  var_01 = lib_050D::func_46A0();
  var_02 = var_00 getentitynumber();
  var_02 = var_02 % var_01.size;
  return var_01[var_02];
}