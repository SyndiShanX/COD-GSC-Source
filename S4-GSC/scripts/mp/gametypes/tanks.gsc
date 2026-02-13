/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tanks.gsc
*************************************************/

main() {
  if(getDvar("#x323906ee9566aeee9") == "mp_background") {
    return;
  }
  setDvar("#x39af27e2257d7e1b3", 1);
  setDvar("#x31caa12dcca574ef9", 2);
  setDvar("#x3e824dc1df2efc7bb", 4);
  setDvar("#x3970dbd5a800e5996", 4);
  _id_07DC::init();
  _id_07DC::_id_D854();

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    level._id_9BEB = 0;
    level._id_9BF0 = 0;
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;

  if(level._id_9BEB || level._id_9BF0) {
    level._id_A00B = _id_07C3::_id_60D1;
  }

  game["dialog"]["gametype"] = "gametype_tdm";

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
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3d6ccba87107eb70a", 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("#x33f7f987edc36b03a", 0);
}

_id_ABAD() {
  level._id_2AD5 = spawnStruct();
  level._id_2AD5._id_102F9 = "veh_bradley_tanks_mp";
  level._id_EE49["remote_tank"].vehicleinfo = "veh_pac_sentry_tanks_mp";
  level._id_EE49["remote_tank"]._id_577F = ::_id_EE47;
  level._id_2AD8 = ::_id_EE47;

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  scripts\mp\utility\game::_id_D61C("allies", &"OBJECTIVES/TANKS");
  scripts\mp\utility\game::_id_D61C("axis", &"OBJECTIVES/TANKS");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/TANKS");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/TANKS");
  } else {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/TANKS_SCORE");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/TANKS_SCORE");
  }

  scripts\mp\utility\game::_id_D615("allies", &"OBJECTIVES/TANKS_HINT");
  scripts\mp\utility\game::_id_D615("axis", &"OBJECTIVES/TANKS_HINT");
  _id_8294();
  var_2[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_2);
}

_id_FC7D() {}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("Default", "Crit_Default");
  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);

  if(getdvarint("#x3aba4510bd2f94d91")) {
    _func_0384("mp_tdm_spawn");
  }

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
  } else if(getdvarint("#x3aba4510bd2f94d91"))
    var_2 = self _meth_862B();
  else {
    var_1 = _id_0817::_id_6DDD(var_0);
    var_3 = _id_0817::_id_6DCD(var_0);
    var_2 = _id_0818::_id_6D4B(var_1, var_3);
  }

  return var_2;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4) {}

_id_ABC0() {
  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_0 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    var_0 = "axis";
  } else {
    var_0 = "allies";
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_E26C(var_0, var_1, var_2, var_3) {}

_id_E26D(var_0) {
  _id_E26C(var_0.origin + (0, 0, 50), var_0.angles, var_0.team, var_0);
}

_id_ABA4() {
  thread _id_10B57();
}

_id_10B57() {
  self waittill("spawned_player");
  var_0 = getdvarint("#x3624820655359c4db", 1);

  if(var_0) {
    _id_E35B(self);
  } else {
    _id_E26D(self);
  }
}

_id_E35B(var_0) {
  var_1 = spawnStruct();
  _id_09D6::_id_93D9(var_1);
  var_1._id_E325 = "place_at_position_unsafe";
  var_1._id_587C = 1;
  var_1._id_3151 = 1;
  var_1._id_3152 = 1;
  var_1.team = var_0.team;
  var_1.owner = var_0;
  var_1.spawntype = "killstreak";
  var_1.origin = var_0.origin;
  var_1._id_31F7 = 0;
  var_1._id_31F8 = 0;

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0) == 1) {
    var_1._id_FE22 = 1;
  }

  var_2 = spawnStruct();
  var_3 = _id_09D6::_id_941A(var_1, var_2);

  if(!_func_03DA(self)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_3, "driver", self, undefined, 1);
  }
}

_id_B6D9() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 playerhide();
  var_0 waittill("killstreakExit");
  var_0 playershow();
}

_id_EE47(var_0, var_1) {}