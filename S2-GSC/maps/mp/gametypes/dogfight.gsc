/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dogfight.gsc
*********************************************/

func_00F9() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 5);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 35);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_873B(1);
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "tdm_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  maps\mp\gametypes\dogfight_common::dogfightinit();
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_dogfight_roundswitch", 0);
  maps\mp\_utility::func_7BF8("dogfight", 0, 0, 9);
  setdynamicdvar("scr_dogfight_roundlimit", 1);
  maps\mp\_utility::func_7BF7("dogfight", 1);
  setdynamicdvar("scr_dogfight_winlimit", 1);
  maps\mp\_utility::func_7C04("dogfight", 1);
  setdynamicdvar("scr_dogfight_halftime", 0);
  maps\mp\_utility::func_7BE5("dogfight", 0);
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

  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_WAR");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_WAR");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_WAR");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_WAR_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_WAR_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_WAR_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_WAR_HINT");
  maps\mp\gametypes\dogfight_common::ondogfightstart();
}

func_6B5C(param_00, param_01, param_02) {
  level maps\mp\gametypes\_gamescore::func_47BD(param_01.var_012C["team"], 1, 1);
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