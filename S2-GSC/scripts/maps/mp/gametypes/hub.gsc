/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\hub.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  setDvar("4014", 1);
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();
  level.rankedmatch = 0;

  if(_func_133()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
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
  _func_153("hub");
  maps\mp\_utility::_id_873B(1);
  level.callbackplayerconnect = ::onhubplayerconnect;
  level._id_746E = _func_2EE();
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_4696 = ::_id_4696;
  level._id_2F85 = 1;
  level._id_1B3E = 1;
  level._id_1385 = ::_id_4F48;
  level._id_6BA7 = ::_id_6BA7;
  level._id_1DEA = ::hubclass;
  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
}

onhubplayerconnect() {
  self _meth_8506(0);
  [[maps\mp\gametypes\_playerlogic::callback_playerconnect]]();
}

_id_4F48() {
  if(!isDefined(self.pers["team"])) {
    if(_func_2EE() == "axis") {
      thread _id_04E8::_id_873A("axis");
      self._id_0179 = "axis";
    } else {
      thread _id_04E8::_id_873A("allies");
      self._id_0179 = "allies";
    }
  }
}

_id_6BA7() {
  if(isDefined(level._id_A592))
    self[[level._id_A592]]();
}

hubclass() {
  self._id_294D = maps\mp\gametypes\_class::_id_1E05();
  self.class = "custom" + (self._id_294D + 1);
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _func_035("scr_hub_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("hub", 0, 0, 9);
  _func_035("scr_hub_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("war", 1);
  _func_035("scr_hub_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("hub", 1);
  _func_035("scr_hub_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("hub", 0);
}

_id_6B5C(var_0, var_1, var_2) {
  level _id_04D2::_id_47BD(var_1.pers["team"], 1, 0);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._id_6C63[var_1.team]])
    var_1._id_3B4B = 1;
}

_id_6BB6() {
  level._id_3B5C = "none";

  if(game["status"] == "overtime")
    var_0 = "forfeit";
  else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
    var_0 = "overtime";
  else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level._id_3B5C = "axis";
    var_0 = "axis";
  } else {
    level._id_3B5C = "allies";
    var_0 = "allies";
  }

  if(maps\mp\_utility::_id_761E())
    var_0 = "none";

  thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_6BAF() {
  _func_157("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
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
  _id_050D::_id_10E4();
  var_2[0] = level.gametype;
  _id_04D1::main(var_2);
}

_id_4696() {
  if(isDefined(level._id_A7A2))
    [[level._id_A7A2]]("mp_hub_spawn_5_tr");

  while(!isDefined(level._id_5FEB))
    waitframe();

  var_0 = self;

  if(isDefined(var_0._id_572A) && var_0._id_572A && isDefined(var_0._id_6B25))
    return [[var_0._id_6B25]](var_0);

  if(isDefined(level._id_13AC))
    return [[level._id_13AC]](var_0);

  if(getdvarint("986", 0) == 1 && isDefined(level._id_A5A0))
    return [[level._id_A5A0]](var_0);

  var_1 = _id_050D::_id_46A0();
  var_2 = var_0 getentitynumber();
  var_2 = var_2 % var_1.size;
  return var_1[var_2];
}