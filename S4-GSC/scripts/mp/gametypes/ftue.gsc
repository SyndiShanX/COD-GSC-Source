/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ftue.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  setdynamicdvar("#x3935295ffafedea42", 1);
  setdynamicdvar("#x3ebf64a18d581b6f5", 1);
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);
  scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);

  if(_func_0127()) {
    var_1 = getmatchrulesdata("commonOption", "timeLimit");
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timeLimit"), var_1);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), var_1);
  } else
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 0);

  _id_81E5();
  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  game["dialog"]["gametype"] = "gametype_ftue";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }
}

_id_81E5() {
  setdynamicdvar("#x378834da779bd40f2", 0);
  scripts\mp\utility\game::_id_C2AA("ftue", 0, 0, 9);
  setdynamicdvar("#x3597bc4697df7f8b9", 1);
  scripts\mp\utility\game::_id_C2A9("ftue", 1);
  setdynamicdvar("#x348ac42a725796a3f", 1);
  scripts\mp\utility\game::_id_C2D0("ftue", 1);
  setdynamicdvar("#x3fb17d9f1b2f26ff6", 0);
  scripts\mp\utility\game::_id_C25D("ftue", 0);
  setdynamicdvar("#x3dd8b7ce509c285ae", 0);
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
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/FTUE");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/FTUE");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/FTUE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/FTUE_HINT");
  }

  if(isDefined(level._id_8295)) {
    [[level._id_8295]]();
  } else {
    _id_8294();
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    _id_0817::_id_D461("BigTDM", "Crit_Frontline");
  } else {
    _id_0817::_id_D461("Default", "Crit_Frontline");
  }

  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_tdm_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");
  var_3 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  _id_0817::_id_C2B9("normal", var_2);
  _id_0817::_id_C2B9("fallback", var_3);

  if(istrue(level._id_F0E4)) {
    var_4 = getdvarfloat("#x3ab5edb4c02a50335", randomfloatrange(-4096, 4096));
    var_5 = getdvarfloat("#x3ab5eda4c02a50102", randomfloatrange(-4096, 4096));
    var_6 = getdvarfloat("#x3ab5ed94c02a4fecf", randomfloatrange(0, 512));
    level._id_9AAC = (var_4, var_5, var_6);
  } else {
    level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
    setmapcenter(level._id_9AAC);
  }

  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = undefined;

  if(istrue(level._id_F0E4)) {
    var_2 = level._id_EF39._id_1783 * randomfloatrange(level._id_EF38 * -1.0, level._id_EF38);
    var_3 = undefined;

    if(var_0 == "axis") {
      var_3 = level._id_EF39._id_1773 * level._id_EF36 * -1.0;
    } else {
      var_3 = level._id_EF39._id_1773 * level._id_EF36;
    }

    var_1 = spawnStruct();
    var_1.origin = level._id_9AAC + var_2 + var_3 + (0, 0, level._id_EF37);
    var_1.angles = (0, 0, 0);
    var_1.index = 1;
  } else if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else
    var_1 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

  return var_1;
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", 0);
  self setclientomnvar("ui_hide_minimap", 1);

  if(getdvarint("#x3e138924b10a94dfa") != 0) {
    thread scripts\mp\teams::_id_ACDA();
  }

  if(!istrue(level._id_F0E4)) {
    return;
  }
  self setplayerangles(vectortoangles(level._id_9AAC - self.origin));
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