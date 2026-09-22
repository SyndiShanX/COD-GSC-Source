/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\dogfight.gsc
**************************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 35);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  game["dialog"]["gametype"] = "tdm_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  maps\mp\gametypes\dogfight_common::dogfightinit();
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _setdynamicdvar("scr_dogfight_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("dogfight", 0, 0, 9);
  _setdynamicdvar("scr_dogfight_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("dogfight", 1);
  _setdynamicdvar("scr_dogfight_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("dogfight", 1);
  _setdynamicdvar("scr_dogfight_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("dogfight", 0);
}

_id_6BAF() {
  _setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
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
  maps\mp\gametypes\dogfight_common::ondogfightstart();
}

_id_6B5C(var_0, var_1, var_2) {
  level _id_04D2::_id_47BD(var_1.pers["team"], 1, 1);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._id_6C63[var_1.team]]) {
    var_1._id_3B4B = 1;
  }
}

_id_6BB6() {
  level._id_3B5C = "none";

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_0 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level._id_3B5C = "axis";
    var_0 = "axis";
  } else {
    level._id_3B5C = "allies";
    var_0 = "allies";
  }

  if(maps\mp\_utility::_id_761E()) {
    var_0 = "none";
  }

  thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, game["end_reason"]["time_limit_reached"]);
}