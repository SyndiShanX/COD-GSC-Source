/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\war.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::init();
  lib_01DD::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 75);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_873B(1);
  level.var_6BAF = ::func_6BAF;
  level.onnormaldeath = ::onnormaldeath;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "tdm_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
  if(level.var_7616) {
    game["dialog"]["gametype"] = "ptr_welcome";
    game["dialog"]["ptr_new_best"] = "ptr_new_best";
    game["dialog"]["ptr_assist"] = "ptr_assist";
    game["dialog"]["ptr_headshot"] = "ptr_headshot";
    game["dialog"]["ptr_greatshot"] = "ptr_greatshot";
  }
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_war_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("war", 0, 0, 9);
  setdynamicdvar("scr_war_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("war", 1);
  setdynamicdvar("scr_war_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("war", 1);
  setdynamicdvar("scr_war_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("war", 0);
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

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_WAR");
  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR_HINT");
  lib_050D::func_10E4();
  var_02[0] = level.gametype;
  var_02[1] = "blocker_war";
  maps\mp\gametypes\_gameobjects::main(var_02);
}

onnormaldeath(param_00, param_01, param_02) {
  level maps\mp\gametypes\_gamescore::func_47BD(param_01.pers["team"], 1, 1);
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