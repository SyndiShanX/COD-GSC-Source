/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\lava.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_ABB3 = ::_id_ABB3;
  game["dialog"]["gametype"] = "tm_death";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["strings"]["overtime_hint"] = &"MP/FIRST_BLOOD";
  level thread _id_10BD4();
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3461c3e74fa669440", 0);
  scripts\mp\utility\game::_id_C2AA("lava", 0, 0, 9);
  setdynamicdvar("#x3963376e86e4afc47", 1);
  scripts\mp\utility\game::_id_C2A9("lava", 1);
  setdynamicdvar("#x36694d5c8cc374079", 1);
  scripts\mp\utility\game::_id_C2D0("lava", 1);
  setdynamicdvar("#x35cf43c3fd1ddde9c", 0);
  scripts\mp\utility\game::_id_C25D("lava", 0);
  setdynamicdvar("#x3d6b153255eed1ef8", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/LAVA");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/LAVA");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/LAVA_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/LAVA_HINT");
  }

  _id_8294();
}

_id_8294() {
  _id_0817::_id_D461("Default", "Crit_Frontline");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  }

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
  } else {
    var_1 = _id_0817::_id_6DDD(var_0);
    var_2 = undefined;
  }

  return var_2;
}

_id_ABB3(var_0) {
  var_1 = scripts\mp\rank::getscoreinfovalue("score_increment");
  level scripts\mp\gamescore::_id_7001(scripts\mp\utility\game::_id_6BE2(var_0.pers["team"])[0], var_1, 0);
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_ABC0() {
  var_0 = scripts\mp\gamescore::_id_6AA0();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if("tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_10BD4() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 _id_10BE3();
  }
}

_id_10BE3() {
  self endon("disconnect");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self)) {
      if(self isonground() &!self _meth_8498()) {
        self dodamage(8.0, self.origin, self, undefined, "MOD_SUICIDE");
        wait 1.0;
      }
    }

    waitframe();
  }
}