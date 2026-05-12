/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\hub.gsc
*********************************************/

func_00F9() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  setDvar("4014", 1);
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  level.var_7A67 = 0;
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 0);
    maps\mp\_utility::func_7C04(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setteammode("hub");
  maps\mp\_utility::func_873B(1);
  level.var_1E77 = ::onhubplayerconnect;
  level.var_746E = function_02EE();
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
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
  [[::maps\mp\gametypes\_playerlogic::func_1E67]]();
}

func_4F48() {
  if(!isDefined(self.var_012C["team"])) {
    if(function_02EE() == "axis") {
      thread maps\mp\gametypes\_menus::func_873A("axis");
      self.var_0179 = "axis";
      return;
    }

    thread maps\mp\gametypes\_menus::func_873A("allies");
    self.var_0179 = "allies";
  }
}

func_6BA7() {
  if(isDefined(level.var_A592)) {
    self[[level.var_A592]]();
  }
}

hubclass() {
  self.var_294D = maps\mp\gametypes\_class::func_1E05();
  self.var_2319 = "custom" + self.var_294D + 1;
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_hub_roundswitch", 0);
  maps\mp\_utility::func_7BF8("hub", 0, 0, 9);
  setdynamicdvar("scr_hub_roundlimit", 1);
  maps\mp\_utility::func_7BF7("war", 1);
  setdynamicdvar("scr_hub_winlimit", 1);
  maps\mp\_utility::func_7C04("hub", 1);
  setdynamicdvar("scr_hub_halftime", 0);
  maps\mp\_utility::func_7BE5("hub", 0);
}

func_6B5C(param_00, param_01, param_02) {
  level maps\mp\gametypes\_gamescore::func_47BD(param_01.var_012C["team"], 1, 0);
  if(game["state"] == "postgame" && game["teamScores"][param_01.var_01A7] > game["teamScores"][level.var_6C63[param_01.var_01A7]]) {
    param_01.var_3B4B = 1;
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

  if(maps\mp\_utility::func_761E()) {
    var_00 = "none";
  }

  thread maps\mp\gametypes\_gamelogic::func_36B9(var_00, game["end_reason"]["time_limit_reached"]);
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

  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_HUB");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_HUB");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_HUB");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_HUB");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_HUB_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_HUB_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_WAR_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_WAR_HINT");
  lib_050D::func_10E4();
  var_02[0] = level.var_3FDC;
  maps\mp\gametypes\_gameobjects::func_00F9(var_02);
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