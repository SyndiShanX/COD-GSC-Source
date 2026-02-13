/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\siege.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "dom";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 3, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2CE(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2CF(scripts\mp\utility\game::getgametype(), 4);
  }

  _id_FC7D();
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_A543 = 1;
  level._id_60C5 = 0;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_AB63 = ::_id_AB63;
  level._id_AB6B = ::_id_AB6B;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = ::_id_AB70;
  level._id_AAA3 = ::_id_AAA3;
  level._id_AB47 = ::_id_AB47;
  level._id_ABC0 = ::_id_ABC0;
  level._id_8FA1 = gettime();
  level._id_1515 = 0;
  level._id_1FEC = 0;
  level._id_15BE = 0;
  level._id_60EE = 0;
  level._id_CA84 = "none";
  level._id_DD2B = [];
  game["canScoreOnTie"] = 1;
  game["dialog"]["gametype"] = "gametype_siege";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_siege";
  game["dialog"]["offense_obj"] = "boost_siege";
  game["dialog"]["defense_obj"] = "boost_siege";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["secured_a"] = "secure_a";
  game["dialog"]["secured_b"] = "secure_b";
  game["dialog"]["secured_c"] = "secure_c";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
  game["dialog"]["enemy_captured_2"] = "siege_enemy_captured_2";
  game["dialog"]["friendly_captured_2"] = "siege_friendly_captured_2";
  game["dialog"]["lastalive_zones"] = "lastalive_zones";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3e17fe24137a2af2c", getmatchrulesdata("siegeData", "rushTimer"));
  setdynamicdvar("#x33b58debea5e50640", getmatchrulesdata("siegeData", "rushTimerAmount"));
  setdynamicdvar("#x35ae854befaeb2f33", getmatchrulesdata("siegeData", "sharedRushTimer"));
  setdynamicdvar("#x32d3a305e71b5d8b5", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("#x3b7270cf2124ecc45", getmatchrulesdata("siegeData", "capRate"));
  setdynamicdvar("#x3cff65d130e27b4b9", 0);
  scripts\mp\utility\game::_id_C25D("siege", 0);
}

_id_D5AD() {
  level._id_7C74 = "waypoint_captureneutral";
  level._id_7C42 = "waypoint_capture";
  level._id_7C4B = "waypoint_defend";
  level._id_7C50 = "waypoint_defending";
  level._id_7C48 = "waypoint_contested";
  level._id_7C87 = "waypoint_taking";
  level._id_7C6F = "waypoint_losing";
}

_id_ABAD() {
  _id_D5AD();

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
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/DOM_HINT");
  }

  _id_8294();
  thread _id_10974();
  thread _id_4D2B();
  thread _id_10AEA();
  thread _id_10B67();

  if(scripts\mp\utility\game::matchmakinggame()) {
    thread _id_10B66();
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_CA82 = scripts\mp\utility\dvars::_id_509C("rushTimer", 1, 0, 1);
  level._id_CA83 = scripts\mp\utility\dvars::_id_509A("rushTimerAmount", 45.0, 30.0, 120);
  level._id_D9B8 = scripts\mp\utility\dvars::_id_509A("sharedRushTimer", 0, 0, 1);
  level._id_BB6F = scripts\mp\utility\dvars::_id_509C("preCapPoints", 0, 0, 1);
  level._id_3213 = scripts\mp\utility\dvars::_id_509A("capRate", 7.5, 1, 10);
}

_id_10974() {
  _id_07D1::_id_60C2("prematch_done");
  level._id_AD53 = 1;
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_dom_spawn_allies_start");
  _id_0817::_id_113A("mp_dom_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_dom_spawn");
  _id_0817::_id_1136("allies", "mp_dom_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_dom_spawn");
  _id_0817::_id_1136("axis", "mp_dom_spawn_secondary", 1, 1);
  var_0 = _id_0817::_id_6D4E("mp_dom_spawn");
  var_1 = _id_0817::_id_6D4E("mp_dom_spawn_secondary");
  _id_0817::_id_C2B9("dom", var_0);
  _id_0817::_id_C2B9("dom_fallback", var_1);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  if(level._id_FED4) {
    _id_0817::_id_D461("StartSpawn", "Crit_Default");

    if(game["switchedsides"]) {
      var_2 = _id_0817::_id_6D4E("mp_dom_spawn_" + var_1 + "_start");
      var_3 = _id_0817::_id_6D4D(var_2);
    } else {
      var_2 = _id_0817::_id_6D4E("mp_dom_spawn_" + var_0 + "_start");
      var_3 = _id_0817::_id_6D4D(var_2);
    }
  } else {
    _id_0817::_id_D461("Domination", "Crit_Default");
    var_4 = _id_6DCB(var_0);
    var_5 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
    var_6 = _id_6DCB(var_5);
    var_7 = scripts\mp\gametypes\dom::_id_6C84(var_4, var_6, var_0, var_1);
    var_8 = [];
    var_8["preferredDomPoints"] = var_7["preferred"];
    var_8["secondaryDomPoints"] = var_7["secondary"];
    var_3 = _id_0817::_id_6D4A(self, var_0, "dom", "dom_fallback", undefined, var_8);
  }

  return var_3;
}

_id_6DCB(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    if(var_3._id_ADAE == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_6DEA(var_0) {
  return gettime() - var_0._id_3235;
}

onplayerconnect(var_0) {
  var_0._id_0BC6 = [];
  var_0._id_0BC7 = [];
  var_0._id_F90E = undefined;
  var_0._id_F90F = undefined;
  var_0 thread onplayerspawned();
  var_0 thread scripts\mp\gametypes\obj_dom::_id_AAB6();
  var_0._id_DD2D = 1;
}

_id_AB63(var_0) {
  for(;;) {
    var_0 waittill("disconnect");

    foreach(var_2 in var_0._id_0BC6) {
      if(isDefined(var_2)) {
        var_2 delete();
      }
    }
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::_id_D550(0);

    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility\stats::_id_D550(self.pers["captures"]);
    }

    scripts\mp\utility\stats::_id_D551(0);

    if(isDefined(self.pers["rescues"])) {
      scripts\mp\utility\stats::_id_D551(self.pers["rescues"]);
    }
  }
}

_id_AB6B(var_0) {
  if(scripts\mp\utility\game::_id_60C5()) {
    var_0._id_DD2D = 1;
  }
}

_id_ABA4() {
  level notify("spawned_player");
  thread scripts\mp\gametypes\dom::_id_FCC2();
}

_id_34DE() {
  if(level._id_CA84 == "none") {
    return;
  }
  if(!scripts\mp\utility\teams::_id_6DCA(level._id_CA84, "aliveCount")) {
    level._id_E3E2[level._id_CA84]._id_15B5 = 1;
    _id_081A::_id_FD35();
  }
}

_id_4D2B() {
  level endon("game_ended");
  var_0 = getEntArray("flag_primary", "targetname");
  var_1 = getEntArray("flag_secondary", "targetname");

  if(var_0.size + var_1.size < 2) {
    return;
  }
  var_2 = "mp/siegeFlagPos.csv";
  var_3 = scripts\cp_mp\utility\game_utility::_id_6B2D();
  var_4 = 1;

  for(var_5 = 2; var_5 < 11; var_5++) {
    var_6 = _func_0222(var_2, var_4, var_3, var_5);

    if(var_6 != "") {
      _id_D561(var_5, float(var_6));
    }
  }

  var_7 = [];

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_7[var_7.size] = var_0[var_8];
  }

  for(var_8 = 0; var_8 < var_1.size; var_8++) {
    var_7[var_7.size] = var_1[var_8];
  }

  level._id_33E1 = 3;
  setomnvar("ui_num_dom_flags", level._id_33E1);

  if(level._id_33E1 == 3) {
    foreach(var_10 in var_0) {
      var_10 scripts\mp\gametypes\dom::_id_C324();
    }
  }

  level._id_A8E8 = [];

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_10 = var_7[var_8];

    if(level._id_33E1 == 3) {
      if(var_10._id_CD99 == "_d" || var_10._id_CD99 == "_e") {
        continue;
      }
    }

    var_10.origin = _id_6A43(var_10._id_CD99, var_10.origin);

    if(isDefined(var_10.target)) {
      var_12[0] = getent(var_10.target, "targetname");
    } else {
      var_12[0] = spawn("script_model", var_10.origin);
      var_12[0].angles = var_10.angles;
    }

    var_13 = _id_07D6::_id_406E("neutral", var_10, var_12, (0, 0, 100), 1, 1);
    var_13 _id_07D6::_id_15DF("enemy");
    var_13 _id_07D6::_id_D8D2(level._id_3213);

    if(isDefined(var_10._id_A8E1)) {
      var_13._id_A8E1 = var_10._id_A8E1;
    } else {
      var_13._id_A8E1 = var_13 _id_07D6::_id_6AF1();
    }

    if(isDefined(var_10._id_7C73)) {
      var_13._id_7C73 = var_10._id_7C73;
    } else {
      var_13._id_7C73 = var_13 _id_07D6::_id_6AF1();
    }

    var_13 _id_07D6::_id_316A(1);
    var_13._id_A6C4 = 1;
    var_13._id_7C8C = "domFlag";
    var_13._id_5BC6 = 1;
    var_13._id_BC66 = "neutral";
    var_13._id_5C3A = 0;
    var_13._id_B7D8 = 0;
    var_13._id_37F3 = level._id_3213 * 1000;
    var_13 _id_07D6::_id_B0E7();
    var_14 = var_12[0].origin + (0, 0, 32);
    var_15 = var_12[0].origin + (0, 0, -32);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, undefined, scripts\engine\trace::_id_3EF6(1));
    var_17 = scripts\mp\gametypes\obj_dom::_id_3529(var_13);
    var_13._id_22B7 = var_16["position"] + var_17;
    var_18 = vectortoangles(var_16["normal"]);
    var_19 = scripts\mp\gametypes\obj_dom::_id_3528(var_13, var_18);
    var_13._id_22B6 = anglesToForward(var_19);
    var_13._id_A5D5 = 1;
    var_13._id_5C3F = spawn("script_model", var_13._id_22B7);
    var_13._id_5C3F setModel("military_dom_flag_neutral");
    level._id_A8E8[var_13._id_A8E1] = var_13;
  }

  var_20 = _id_0817::_id_6D4E("mp_dom_spawn_axis_start");
  var_21 = _id_0817::_id_6D4E("mp_dom_spawn_allies_start");
  level._id_0405["allies"] = var_21[0].origin;
  level._id_0405["axis"] = var_20[0].origin;
  level._id_24D4 = [];
  level._id_24D4["allies"] = ::scripts\mp\gametypes\obj_dom::_id_6E25("allies", undefined);
  level._id_24D4["axis"] = ::scripts\mp\gametypes\obj_dom::_id_6E25("axis", level._id_24D4["allies"]);
  scripts\mp\gametypes\dom::_id_5C46();

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  foreach(var_23 in level._id_A8E8) {
    var_24 = scripts\mp\gametypes\obj_dom::_id_6CED(var_23._id_A8E1);
    var_23 _id_07D6::_id_C579(1, 1, var_24);
    var_23._id_ABCB = ::_id_ABCB;
    var_23._id_AA79 = ::_id_AA79;
    var_23._id_ABD4 = ::_id_ABD4;
    var_23._id_AAC2 = ::_id_AAC2;
    var_23._id_AA8D = ::_id_AA8D;
    var_23._id_ABC7 = ::_id_ABC7;
    var_23._id_ABC8 = ::_id_ABC8;
    var_23._id_AB54 = ::_id_AB54;
    var_23._id_ABC9 = ::_id_ABC9;
    var_23._id_E86C = ::_id_ABAF;
    var_23._id_E86E = ::_id_E86E;
    var_23 _id_07D6::_id_D61B("waypoint_defend", "waypoint_target");
    var_23 _id_07D6::_id_D8E0("any");
    var_23 scripts\mp\gametypes\obj_dom::_id_4D27();
  }

  if(level._id_BB6F) {
    scripts\mp\gametypes\obj_dom::_id_BB6E();
  }
}

_id_D607() {
  if(_id_07D6::_id_6C02() == "neutral") {
    thread scripts\mp\gametypes\obj_dom::_id_FC64("idle", 0);
  }
}

_id_D561(var_0, var_1) {
  switch (var_0) {
    case 2:
      level._id_DD1D = var_1;
      break;
    case 3:
      level._id_DD1E = var_1;
      break;
    case 4:
      level._id_DD1F = var_1;
      break;
    case 5:
      level._id_DD21 = var_1;
      break;
    case 6:
      level._id_DD22 = var_1;
      break;
    case 7:
      level._id_DD23 = var_1;
      break;
    case 8:
      level._id_DD27 = var_1;
      break;
    case 9:
      level._id_DD28 = var_1;
      break;
    case 10:
      level._id_DD29 = var_1;
      break;
  }
}

_id_6A43(var_0, var_1) {
  var_2 = var_1;

  if(var_0 == "_a") {
    if(isDefined(level._id_DD1D) && isDefined(level._id_DD1E) && isDefined(level._id_DD1F)) {
      var_2 = (level._id_DD1D, level._id_DD1E, level._id_DD1F);
    }
  } else if(var_0 == "_b") {
    if(isDefined(level._id_DD21) && isDefined(level._id_DD22) && isDefined(level._id_DD23)) {
      var_2 = (level._id_DD21, level._id_DD22, level._id_DD23);
    }
  } else if(isDefined(level._id_DD27) && isDefined(level._id_DD28) && isDefined(level._id_DD29))
    var_2 = (level._id_DD27, level._id_DD28, level._id_DD29);

  return var_2;
}

_id_10AEA() {
  level endon("game_ended");

  for(;;) {
    level waittill("flag_capturing", var_0);

    if(level._id_CA82) {
      if(var_0._id_BC66 != "neutral") {
        var_1 = scripts\mp\utility\game::_id_6BE2(var_0._id_BC66)[0];

        if(isDefined(level._id_DD2F) && level._id_DD2F != "pause" && !_id_8B14(var_1)) {
          level._id_60EE = 0;
          level._id_DD2F = "pause";
          _id_AF68();

          if(!_id_5C42(var_0._id_BC66)) {
            _id_D8F1(var_1, tolower(game[var_0._id_BC66]) + "_eliminated");
          }
        }
      }
    }
  }
}

_id_8B14(var_0) {
  var_1 = 0;
  var_2 = _id_6A42(var_0);

  if(var_2 == 2) {
    var_1 = 1;
  }

  return var_1;
}

_id_5C42(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_AE7C) {
    if(isDefined(var_3) && var_3.team == var_0 && (scripts\mp\utility\player::isreallyalive(var_3) || var_3.pers["lives"] > 0)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_AF68() {
  if(!level._id_F263) {
    var_0 = level._id_CA83;

    if(isDefined(level._id_DD2E)) {
      var_0 = level._id_DD2E;
    }

    var_1 = int(gettime() + var_0 * 1000);
    scripts\mp\gamelogic::pausetimer(var_1);
  }

  level notify("siege_timer_paused");
}

_id_C72E(var_0) {
  var_1 = level._id_CA83;

  if(level._id_F263) {
    if(isDefined(level._id_DD2E)) {
      var_1 = level._id_DD2E;
    }

    var_2 = int(gettime() + var_1 * 1000);
    setgameendtime(var_2);
    scripts\mp\gamelogic::resumetimer(var_2);

    if(!isDefined(level._id_DD2F) || level._id_DD2F == "pause") {
      level._id_DD2F = "start";
    }

    thread _id_10B68(var_1);

    if(istrue(var_0)) {
      if(level._id_DD2B.size > 0) {
        level notify("flag_capturing", self);
      }
    }
  }
}

_id_10AE9(var_0) {
  level endon("game_ended");
  var_1 = 0;
  var_2 = 0;
  var_3 = level._id_CA84;
  var_1 = _id_6A42("allies");
  var_2 = _id_6A42("axis");

  if(level._id_CA82 && level._id_CA84 != "none") {
    if(level._id_D9B8 || var_1 == 1 && var_2 == 1) {
      level._id_DD2F = "start";
      _id_A6AB("siege_timer_start");
      _id_C72E(1);
      return;
    }
  }

  if(var_1 == 2 || var_2 == 2) {
    level._id_CA84 = scripts\engine\utility::ter_op(var_1 > var_2, "allies", "axis");

    if(var_3 != level._id_CA84) {
      if(level._id_CA82) {
        if(isDefined(level._id_DD2F) && level._id_DD2F != "reset") {
          level._id_60EE = 0;
          level._id_DD2E = undefined;
          level._id_DD2F = "reset";
          _id_A6AB("siege_timer_reset");
        }

        if(!isDefined(level._id_DD2F) || level._id_DD2F != "start") {
          var_4 = level._id_CA83;

          if(isDefined(level._id_DD2E)) {
            var_4 = level._id_DD2E;
          }

          var_5 = int(gettime() + var_4 * 1000);
          level._id_F21A = 1;
          scripts\mp\gamelogic::pausetimer(var_5);
          setgameendtime(var_5);
          scripts\mp\gamelogic::resumetimer(var_5);

          if(!isDefined(level._id_DD2F) || level._id_DD2F == "pause") {
            level._id_DD2F = "start";
            _id_A6AB("siege_timer_start");
          }

          if(!level._id_60EE) {
            thread _id_10B68(var_4);
          }
        }
      }
    } else if(var_3 == level._id_CA84 && var_1 == 1 || var_3 == level._id_CA84 && var_2 == 1)
      _id_C72E(1);
    else if(level._id_CA82) {
      level._id_60EE = 0;
      level._id_DD2E = undefined;
      level._id_DD2F = "reset";
      _id_A6AB("siege_timer_reset");
      _id_C72E(1);
    }
  } else if(var_1 == 3)
    _id_D8F1("allies", "siege_allflags_win", "siege_allflags_loss");
  else if(var_2 == 3) {
    _id_D8F1("axis", "siege_allflags_win", "siege_allflags_loss");
  }

  self._id_BC66 = self._id_ADAE;
}

_id_10B66() {
  level endon("game_ended");
  level endon("flag_capturing");
  var_0 = getdvarfloat("#x38ecbcc722fb92d9b");

  if(var_0 > 0) {
    var_1 = var_0 - 1;

    while(var_1 > 0) {
      var_1 = var_1 - 1;
      wait 1;
    }

    level._id_DD2C = 1;
  }
}

_id_10B67() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  while(!_id_75D2()) {
    waitframe();
  }

  level._id_60C5 = 1;
}

_id_75D2() {
  if(level.teambased) {
    foreach(var_1 in level._id_EF89) {
      if(!scripts\mp\utility\teams::_id_6DCA(var_1, "hasSpawned")) {
        return 0;
      }
    }

    return 1;
  }

  return level._id_9C91 > 1;
}

_id_10B68(var_0) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");
  var_1 = var_0;
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 hide();
  level._id_60EE = 1;

  while(var_1 > 0) {
    var_1 = var_1 - 1;
    level._id_DD2E = var_1;

    if(var_1 <= 30) {
      if(var_1 != 0) {
        var_2 playSound("ui_mp_timer_countdown");
      }
    }

    wait 1;
  }

  _id_ABC0();
}

_id_6A42(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_A8E8) {
    if(var_3._id_ADAE == var_0 && !_id_877D(var_3)) {
      var_1 = var_1 + 1;
    }
  }

  return var_1;
}

_id_877D(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(level._id_DD2B.size > 0) {
      foreach(var_3 in level._id_DD2B) {
        if(var_0._id_A8E1 == var_3) {
          var_1 = 1;
        }
      }
    }
  }

  return var_1;
}

_id_D8F1(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_4 setclientomnvar("ui_objective_state", 0);
    }
  }

  if(isDefined(var_2)) {
    thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"][var_1], game["end_reason"][var_2]);
  } else {
    thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"][var_1]);
  }
}

_id_AA79(var_0) {
  if(!scripts\engine\utility::array_contains(level._id_DD2B, self._id_A8E1)) {
    level._id_DD2B[level._id_DD2B.size] = self._id_A8E1;
    var_1 = _id_07D6::_id_6C02();
    var_0 setclientomnvar("ui_objective_state", 1);
    self._id_497A = 0;
    _id_07D6::_id_D8D2(level._id_3213);
  }

  level notify("flag_capturing", self);
}

_id_ABCB(var_0) {
  self._id_497A = 0;
  var_1 = var_0.team;
  var_2 = _id_07D6::_id_6C02();
  var_3 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  self._id_3235 = gettime();
  _id_07F9::_id_A8B4(self._id_A908, 0);
  _id_07F9::_id_A8C4(self._id_A908, 0);
  thread scripts\mp\gametypes\obj_dom::_id_FC64(var_1, 0, var_1);
  scripts\mp\gametypes\obj_dom::_id_D560(var_1, var_2, var_0);
  level._id_FED4 = 0;

  if(var_2 == "neutral") {
    var_4 = scripts\mp\gametypes\obj_dom::_id_6DCE(var_1);

    if(var_4 < level._id_A8E8.size) {
      if(var_4 == 2) {
        _id_0A8D::_id_E775("friendly_captured_2", var_1);
        _id_0A8D::_id_E775("enemy_captured_2", var_3, 1);
      } else {
        _id_0A8D::_id_E775("secured" + self._id_A8E1, var_1);
        _id_0A8D::_id_E775("lost" + self._id_A8E1, var_3, 1);
      }
    }
  }

  if(scripts\mp\gametypes\obj_dom::_id_6DCE(var_1) == level._id_A8E8.size) {
    var_5 = "mp_dom_flag_captured_all";
  } else {
    var_5 = "mp_dom_flag_captured";
  }

  thread scripts\mp\utility\print::_id_BD0C(var_1, var_3, undefined, undefined, var_5, "mp_dom_flag_lost", var_0);
  thread _id_6F9A(self._id_F396[var_1], var_2, var_0);
  self._id_5BC6 = 0;

  if(scripts\mp\utility\teams::_id_8878(var_1)) {
    if(level._id_EF6A[var_1]["aliveCount"] < level._id_EF6A[var_1]["players"].size) {
      foreach(var_7 in level._id_EF6A[var_1]["players"]) {
        var_7 playlocalsound("mp_bodycount_tick_positive");
      }

      var_9 = scripts\mp\utility\teams::_id_69FD(var_1);

      foreach(var_7 in var_9) {
        var_7 playlocalsound("mp_bodycount_tick_negative");
      }
    }
  }
}

_id_ABD4(var_0, var_1, var_2, var_3) {
  var_4 = _id_07D6::_id_6C02();

  if(var_1 < 1.0 && !level.gameended) {
    _id_B21A(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !self._id_497A) {
    if(var_4 == "neutral") {
      _id_0A8D::_id_E775("securing" + self._id_A8E1, var_0);
      self._id_BC52 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
    } else {
      _id_0A8D::_id_E775("losing" + self._id_A8E1, var_4, 1);
      _id_0A8D::_id_E775("securing" + self._id_A8E1, var_0);
    }

    if(!isagent(var_3)) {
      scripts\mp\gametypes\obj_dom::_id_FC63(var_0);
    }

    _id_07D6::_id_D61B(level._id_7C6F, level._id_7C87);
    self._id_497A = 1;
  }

  level notify("flag_capturing", self);
}

_id_B21A(var_0, var_1) {
  if(!isDefined(self._id_903F)) {
    self._id_903F = gettime();
  }

  if(self._id_903F + 995 < gettime()) {
    self._id_903F = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self._id_10430[0] playsoundtoteam(var_2, var_1);
  }
}

_id_AAC2(var_0, var_1, var_2) {
  self._id_497A = 0;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90E = undefined;
  }

  if(var_2) {
    self._id_5C3A = 1;
  } else {
    self._id_5C3A = 0;
    _id_C72E();
  }

  var_3 = _id_07D6::_id_6C02();

  if(var_3 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C74);
    scripts\mp\gametypes\obj_dom::_id_FC64("idle", 0);
  } else {
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
    scripts\mp\gametypes\obj_dom::_id_FC64(var_3, 0);
  }

  level._id_DD2B = scripts\engine\utility::array_remove(level._id_DD2B, self._id_A8E1);
  thread _id_10866();
}

_id_10866() {
  waitframe();
  _id_34F9();
}

_id_AA8D() {
  _id_07D6::_id_D61B(level._id_7C48);
  _id_07F9::_id_A8B6(self._id_A908, undefined);
  scripts\mp\gametypes\obj_dom::_id_FC64("contested", 0);

  if(level._id_CA84 == self._id_ADAE) {
    _id_C72E();
  }
}

_id_ABC7(var_0) {
  _id_34F9();
  var_1 = _id_07D6::_id_6C02();

  if(var_1 == "neutral") {
    if(var_0 != "none") {
      _id_07F9::_id_A8B6(self._id_A908, var_0);
    } else {
      _id_07F9::_id_A8B6(self._id_A908, undefined);
    }
  } else
    _id_07F9::_id_A8B6(self._id_A908, scripts\mp\utility\game::_id_6BE2(var_1)[0]);

  if(var_0 == "none" || var_1 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C74);
    self._id_497A = 0;
  } else
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  scripts\mp\gametypes\obj_dom::_id_FC64(var_2, 0);
}

_id_ABC8() {
  var_0 = _id_07D6::_id_6C02();

  if(var_0 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C74);
    self._id_497A = 0;
  } else
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
}

_id_AB54(var_0) {
  if(self._id_ADAE != "neutral" && self._id_A79A[self._id_ADAE] && !self._id_E57B) {
    _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
  }
}

_id_ABC9(var_0) {
  if(self._id_ADAE != "neutral" && !self._id_A79A[self._id_ADAE] && !self._id_E57B) {
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  }
}

_id_ABAF(var_0) {
  if(level._id_CA84 == self._id_ADAE) {
    _id_C72E();
  } else {
    _id_C72E(1);
  }
}

_id_E86E(var_0) {
  var_0 thread scripts\mp\rank::_id_CC00("defend");
  var_0 thread _id_07B1::_id_6FB9("mode_x_defend");
  _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
}

_id_AAA3(var_0) {
  if(scripts\mp\utility\game::_id_60C5()) {
    if(var_0 == "all") {
      _id_ABC0();
    } else if(var_0 == game["attackers"]) {
      if(level._id_CA82 && _id_6A42(var_0) == 2) {
        return;
      }
      _id_D8F1(game["defenders"], tolower(game[game["attackers"]]) + "_eliminated");
    } else if(var_0 == game["defenders"]) {
      if(level._id_CA82 && _id_6A42(var_0) == 2) {
        return;
      }
      _id_D8F1(game["attackers"], tolower(game[game["defenders"]]) + "_eliminated");
    }
  }
}

_id_AB47(var_0) {
  var_1 = scripts\mp\utility\game::_id_6AF7(var_0);
  var_1 thread _id_6FAE();
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_10A12)) {
    self._id_10A12 = undefined;
  }

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(!_id_5C42(self.team) && scripts\mp\gametypes\obj_dom::_id_6DCE(self.team) == 2) {
    _id_0A8D::_id_E775("objs_capture", var_1.team, 1);
  }

  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.team;
  var_15 = var_13.origin;
  var_16 = var_1.team;
  var_17 = var_1.origin;
  var_18 = 0;

  if(isDefined(var_0)) {
    var_17 = var_0.origin;
    var_18 = var_0 == var_1;
  }

  foreach(var_20 in var_1._id_F398) {
    var_21 = undefined;

    foreach(var_23 in level._id_A8E8) {
      if(var_23.trigger == var_20) {
        var_21 = var_23;
        break;
      }
    }

    if(!isDefined(var_21)) {
      continue;
    }
    var_25 = var_21._id_ADAE;

    if(var_16 != var_25) {
      if(!var_10) {
        var_10 = 1;
      }

      continue;
    }
  }

  foreach(var_21 in level._id_A8E8) {
    var_20 = var_21.trigger;
    var_25 = var_21._id_ADAE;

    if(var_25 == "neutral") {
      var_28 = var_1 istouching(var_20);
      var_29 = var_13 istouching(var_20);

      if(var_28 || var_29) {
        if(var_21._id_37F6 == var_14) {
          if(!var_11) {
            if(var_10) {
              var_1 thread _id_0A9F::_id_7003("capture_kill");
            } else {
              var_1 thread scripts\mp\rank::_id_CC00("assault");
              var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
            }

            var_11 = 1;
            continue;
          }
        } else if(var_21._id_37F6 == var_16) {
          if(!var_12) {
            if(var_10) {
              var_1 thread _id_0A9F::_id_7003("capture_kill");
            } else {
              var_1 thread scripts\mp\rank::_id_CC00("defend");
              var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
            }

            var_12 = 1;
            var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
            var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
            continue;
          }
        }
      }
    } else if(var_25 != var_16) {
      if(!var_11) {
        var_30 = _id_4BBA(var_20, var_17, var_15);

        if(var_30) {
          if(var_10) {
            var_1 thread _id_0A9F::_id_7003("capture_kill");
          } else {
            var_1 thread scripts\mp\rank::_id_CC00("assault");
            var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
          }

          var_11 = 1;
          continue;
        }
      }
    } else if(!var_12) {
      var_31 = _id_4BBA(var_20, var_17, var_15);

      if(var_31) {
        if(var_10) {
          var_1 thread _id_0A9F::_id_7003("capture_kill");
        } else {
          var_1 thread scripts\mp\rank::_id_CC00("defend");
          var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
        }

        var_12 = 1;
        var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
        var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
        continue;
      }
    }
  }

  thread _id_34DE();
}

_id_4BBA(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0._id_9FF8)) {
      return 1;
    } else if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
      return 1;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_6FAE() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_id_10968(3);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "inform_last_one");
  var_0 = scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0];
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
}

_id_ABC0() {
  if(isDefined(level._id_DD2C)) {
    level thread scripts\mp\gamelogic::forceend();
  } else {
    var_0 = _id_6A42("allies");
    var_1 = _id_6A42("axis");

    if(var_0 > var_1) {
      _id_D8F1("allies", "siege_flag_win", "siege_flag_loss");
    } else if(var_1 > var_0) {
      _id_D8F1("axis", "siege_flag_win", "siege_flag_loss");
    } else {
      _id_D8F1("tie", "cyber_tie");
    }
  }
}

_id_EF9C(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::_id_6DCA(var_1.team, "teamCount");

  if(!isDefined(var_1._id_C596)) {
    var_1._id_C596 = [];
  }

  foreach(var_4 in level._id_AE7C) {
    if(isDefined(var_4) && var_4.team == var_0 && !scripts\mp\utility\player::isreallyalive(var_4) && !scripts\engine\utility::array_contains(scripts\mp\utility\teams::_id_6A59(var_4.team, 1), var_4) && (!isDefined(var_4._id_10848) || !var_4._id_10848)) {
      if(isDefined(var_4._id_DD2D) && var_4._id_DD2D) {
        var_4._id_DD2D = 0;
      }

      if(!istrue(var_4.pers["teamKillPunish"])) {
        if(istrue(var_4._id_10A12)) {
          continue;
        }
        var_4._id_10A12 = 1;
        var_4 thread scripts\mp\playerlogic::_id_1094C(0);
        var_4 thread scripts\mp\rank::_id_CC00("revived");
        level notify("sr_player_respawned", var_4);
        var_4 _id_0A8D::_id_9137("revived");
      }

      var_1._id_C596[var_4.guid] = 1;
    }
  }

  self._id_B7D8 = var_1._id_C596.size;
}

_id_A6AB(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\hud_message::showsplash(var_0);
  }

  level notify("match_ending_soon", "time");
  level notify(var_0);
}

_id_6F9A(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = var_2;

  if(isDefined(var_3.owner)) {
    var_3 = var_3.owner;
  }

  level._id_8FA1 = gettime();

  if(isPlayer(var_3)) {
    level thread scripts\mp\hud_util::_id_EF8D("callout_securedposition" + self._id_A8E1, var_3);
    var_3 thread scripts\common\utility::_id_F73A(level._id_9BB3, "capture", var_3.origin);
  }

  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_0[var_4[var_5]].player;

    if(isDefined(var_6.owner)) {
      var_6 = var_6.owner;
    }

    if(!isPlayer(var_6)) {
      continue;
    }
    var_6 thread _id_FC41();

    if(var_6._id_3E28 > 3) {
      var_7 = 0;
      var_8 = 0;
    } else if(var_6._id_A775 > 5) {
      var_7 = 125;
      var_8 = 50;
    } else if(self._id_A8E1 == "_b" || var_1 != "neutral" || self._id_B7D8 > 0) {
      var_7 = undefined;
      var_8 = undefined;
    } else {
      var_7 = 125;
      var_8 = 50;
    }

    var_6 thread scripts\mp\rank::_id_CC00("capture");
    var_6 thread _id_07B1::_id_6FB9("mode_siege_secure", var_8, var_7);
    var_6 scripts\mp\utility\stats::_id_7DAE("captures", 1);
    var_6 scripts\mp\persistence::_id_E770("round", "captures", var_6.pers["captures"]);
    var_6 scripts\mp\utility\stats::_id_D550(var_6.pers["captures"]);
    var_6 scripts\mp\utility\stats::_id_7DAE("rescues", self._id_B7D8);
    var_6 scripts\mp\persistence::_id_E770("round", "rescues", var_6.pers["rescues"]);
    var_6 scripts\mp\utility\stats::_id_D551(var_6.pers["rescues"]);
    wait 0.05;
  }

  self._id_B7D8 = 0;
}

_id_694E() {
  if(self._id_3E28 < 4) {
    return 1;
  } else {
    return 0.25;
  }
}

_id_FC41() {
  if(!isDefined(self._id_3E28)) {
    self._id_A775 = 0;
    self._id_3E28 = 0;
  }

  self._id_A775++;

  if(scripts\mp\utility\game::_id_6B5F() < 1) {
    return;
  }
  self._id_3E28 = self._id_A775 / scripts\mp\utility\game::_id_6B5F();
}

_id_34F9() {
  var_0 = _id_6A42("allies");
  var_1 = _id_6A42("axis");

  if(var_0 == 3) {
    _id_D8F1("allies", "siege_allflags_win", "siege_allflags_loss");
  } else if(var_1 == 3) {
    _id_D8F1("axis", "siege_allflags_win", "siege_allflags_loss");
  }
}