/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ctf.gsc
*************************************************/

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  _id_5C08();
  var_0[0] = "ctf";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  }

  _id_FC7D();

  if(level._id_10E61) {
    level._id_10E4B = "teamScores";
  } else {
    level._id_10E4B = "roundsWon";
  }

  level.teambased = 1;
  level._id_A8D4 = 1;
  level._id_AD73 = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_9FE8 = ::_id_ABA4;
  level._id_E32D = "mp_ctf_spawn";
  game["dialog"]["gametype"] = "gametype_ctf";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_ctf";
  game["dialog"]["offense_obj"] = "boost_ctf";
  game["dialog"]["defense_obj"] = "boost_ctf";
  game["dialog"]["flag_taken"] = "ourflag_taken";
  game["dialog"]["flag_dropped"] = "ourflag_drop";
  game["dialog"]["flag_returned"] = "ourflag_return";
  game["dialog"]["flag_captured"] = "ourflag_capt";
  game["dialog"]["flag_getback"] = "ourflag_getback";
  game["dialog"]["enemy_flag_bringhome"] = "enemyflag_tobase";
  game["dialog"]["enemy_flag_taken"] = "enemyflag_taken";
  game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
  game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
  game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";
  setomnvar("ui_ctf_flag_axis", -2);
  setomnvar("ui_ctf_flag_allies", -2);
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x324e1ce57096e11fb", getmatchrulesdata("ctfData", "winRule"));
  setdynamicdvar("#x3714489bd0f30b76", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar("#x37bc25307a42ae742", getmatchrulesdata("ctfData", "returnTime"));
  setdynamicdvar("#x33991478f0f911eb0", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("#x362756ce81c63387f", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("#x3249330bc8d045730", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("#x356a438d6f8df67d9", 0);
  scripts\mp\utility\game::_id_C25D("ctf", 0);
}

_id_ABA4() {
  _id_FCC1();
}

_id_ABAD() {
  var_0 = scripts\mp\utility\game::_id_82D1();
  var_1 = game["overtimeRoundsPlayed"] == 0;
  var_2 = scripts\mp\utility\game::_id_8AA2();

  if(var_0) {
    if(var_1) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var_2) {
      setomnvar("ui_round_hint_override_attackers", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["attackers"], 2, 3));
      setomnvar("ui_round_hint_override_defenders", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["defenders"], 2, 3));
    } else {
      setomnvar("ui_round_hint_override_attackers", 4);
      setomnvar("ui_round_hint_override_defenders", 4);
    }
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(scripts\mp\utility\game::_id_82D1()) {
    setDvar("#x35fabbf5308a8b0cc", 0);
  } else if(game["switchedsides"]) {
    setDvar("#x35fabbf5308a8b0cc", 2);
  } else {
    setDvar("#x35fabbf5308a8b0cc", 1);
  }

  if(!isDefined(game["original_defenders"])) {
    game["original_defenders"] = game["defenders"];
  }

  if(game["switchedsides"]) {
    var_3 = game["attackers"];
    var_4 = game["defenders"];
    game["attackers"] = var_4;
    game["defenders"] = var_3;
  }

  setclientnamemode("auto_change");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::_id_D61C(game["attackers"], &"OBJECTIVES/CTF");
  scripts\mp\utility\game::_id_D61C(game["defenders"], &"OBJECTIVES/CTF");
  scripts\mp\utility\game::_id_D615(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  scripts\mp\utility\game::_id_D615(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  _id_5C1E();
  _id_3FCE();
  _id_8294();
  thread _id_C49E();
  thread _id_B167();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_10E61 = scripts\mp\utility\dvars::_id_509C("winRule", 0, 0, 1);
  level._id_DCA0 = scripts\mp\utility\dvars::_id_509C("showEnemyCarrier", 5, 0, 6);
  level._id_7CD0 = scripts\mp\utility\dvars::_id_509A("idleResetTime", 30, 0, 60);
  level._id_3228 = scripts\mp\utility\dvars::_id_509C("captureCondition", 0, 0, 1);
  level._id_B0B3 = scripts\mp\utility\dvars::_id_509A("pickupTime", 0, 0, 10);
  level._id_C79F = scripts\mp\utility\dvars::_id_509A("returnTime", 0, -1, 25);
}

_id_3FCE() {
  level._id_5C3F["allies"] = "ctf_game_flag_west";
  level._id_5C38["allies"] = "ctf_game_flag_base";
  level._id_32E6["allies"] = "prop_ctf_game_flag_west";
  level._id_5C3F["axis"] = "ctf_game_flag_east";
  level._id_5C38["axis"] = "ctf_game_flag_base";
  level._id_32E6["axis"] = "prop_ctf_game_flag_east";
  level._id_39D2 = [];
  level._id_39D2["allies"] = undefined;
  level._id_39D2["axis"] = undefined;
  _id_D8C5();
  level._id_7C55 = "waypoint_escort_flag";
  level._id_7C6A = "waypoint_ctf_kill";
  level._id_7C45 = "waypoint_take_flag";
  level._id_7C4E = "waypoint_defend_flag";
  level._id_7C82 = "waypoint_recover_flag";
  level._id_EF72[game["defenders"]] = _id_405E(game["defenders"], "axis");
  level._id_EF72[game["attackers"]] = _id_405E(game["attackers"], "allies");
  level._id_323A[game["defenders"]] = _id_3FA6(game["defenders"], "axis");
  level._id_323A[game["attackers"]] = _id_3FA6(game["attackers"], "allies");
  _id_07F9::_id_A8C1(level._id_323A[game["defenders"]]._id_A908, 1);
  _id_07F9::_id_A8C1(level._id_323A[game["attackers"]]._id_A908, 1);
}

_id_5C1E() {}

_id_8294() {
  _id_0817::_id_D461("AwayFromEnemies", "Crit_Default");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_ctf_spawn_allies_start");
  _id_0817::_id_113A("mp_ctf_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_ctf_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_ctf_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_ctf_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_ctf_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_ctf_spawn");
  _id_0817::_id_1136("axis", "mp_ctf_spawn");
  _id_1D26();
  level._id_411B["allies"] = "allies";
  level._id_411B["axis"] = "axis";
  _id_0817::_id_C2B9("allies", level._id_EFAB["allies"]);
  _id_0817::_id_C2B9("axis", level._id_EFAB["axis"]);
  _id_0817::_id_C2B9("neutral", level._id_EFAB["neutral"]);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_1D26() {
  var_0 = _id_0817::_id_6D4E(level._id_E32D);
  var_1 = _id_0817::_id_8974();
  level._id_EFAB["axis"] = [];
  level._id_EFAB["allies"] = [];
  level._id_EFAB["neutral"] = [];

  if(level._id_EF72.size == 2) {
    var_2 = level._id_EF72["allies"];
    var_3 = level._id_EF72["axis"];
    var_4 = (var_2._id_4140[0], var_2._id_4140[1], 0);
    var_5 = (var_3._id_4140[0], var_3._id_4140[1], 0);
    var_6 = var_5 - var_4;
    var_7 = _func_0133(var_6);

    foreach(var_9 in var_0) {
      var_10 = (var_9.origin[0], var_9.origin[1], 0);
      var_11 = var_10 - var_4;
      var_12 = vectordot(var_11, var_6);
      var_13 = var_12 / (var_7 * var_7);

      if(var_13 < 0.33) {
        var_9._id_EF64 = scripts\mp\utility\game::_id_6BE2(var_2._id_ADAE)[0];
        level._id_EFAB[var_9._id_EF64][level._id_EFAB[var_9._id_EF64].size] = var_9;
        continue;
      }

      if(var_13 > 0.67) {
        var_9._id_EF64 = scripts\mp\utility\game::_id_6BE2(var_3._id_ADAE)[0];
        level._id_EFAB[var_9._id_EF64][level._id_EFAB[var_9._id_EF64].size] = var_9;
        continue;
      }

      var_14 = undefined;
      var_15 = undefined;

      if(var_1) {
        var_14 = _func_00C4(var_9.origin, var_2._id_4140, 999999);
      }

      if(isDefined(var_14) && var_14 != -1) {
        var_15 = _func_00C4(var_9.origin, var_3._id_4140, 999999);
      }

      if(!isDefined(var_15) || var_15 == -1) {
        var_14 = distance2d(var_2._id_4140, var_9.origin);
        var_15 = distance2d(var_3._id_4140, var_9.origin);
      }

      var_16 = max(var_14, var_15);
      var_17 = min(var_14, var_15);
      var_18 = var_17 / var_16;

      if(var_18 > 0.5) {
        level._id_EFAB["neutral"][level._id_EFAB["neutral"].size] = var_9;
      }
    }
  } else {
    foreach(var_9 in var_0) {
      var_9._id_EF64 = _id_6B72(var_9);

      if(var_9._id_EF64 == "axis") {
        level._id_EFAB["axis"][level._id_EFAB["axis"].size] = var_9;
        continue;
      }

      level._id_EFAB["allies"][level._id_EFAB["allies"].size] = var_9;
    }
  }
}

_id_6B72(var_0) {
  var_1 = _id_0817::_id_8974();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_EF72) {
    var_6 = undefined;

    if(var_1) {
      var_6 = _func_00C4(var_0.origin, var_5._id_4140, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5._id_4140, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return scripts\mp\utility\game::_id_6BE2(var_2._id_ADAE)[0];
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else
    var_1 = _id_0817::_id_6D4A(self, var_0, level._id_411B[var_0], "neutral");

  return var_1;
}

_id_5C08() {
  level._id_456E = [];
  level._id_01C4 = getEntArray("flag_primary", "targetname");

  if(!isDefined(game["attackers"])) {
    game["attackers"] = "allies";
  }

  if(!isDefined(game["defenders"])) {
    game["defenders"] = "axis";
  }

  foreach(var_1 in level._id_01C4) {
    switch (var_1._id_CD99) {
      case "_a":
        level._id_456A[game["attackers"]] = var_1.origin;
        break;
      case "_c":
        level._id_456A[game["defenders"]] = var_1.origin;
        break;
    }
  }
}

_id_5C07(var_0) {
  var_1 = spawnStruct();

  switch (level.script) {
    default:
      break;
  }

  if(!isDefined(var_1.origin)) {
    var_1.origin = level._id_456A[var_0];
  }

  var_1 _id_5C0D();
  var_1.origin = var_1._id_71A7;
  var_1._id_0359 = 30;
  var_1.team = var_0;
  var_1._id_2130 = 0;
  var_1._id_7930 = 0;
  return var_1;
}

_id_5C0D(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self._id_71A7 = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

_id_DCAA(var_0, var_1, var_2) {
  if(isDefined(var_1._id_0BEB[var_0])) {
    var_1._id_0BEB[var_0] delete();
  }

  var_3 = undefined;
  var_4 = var_1.team;
  var_5 = var_1 _meth_81D3();

  if(var_5) {
    var_4 = var_1 _meth_8154();
  } else if(var_4 == "spectator") {
    var_4 = "allies";
  }

  if(var_4 == var_0) {
    var_6 = _func_020D(level._id_5C44["friendly"], var_2, var_1, (0, 0, 1));
    var_6 _meth_8322();
  } else {
    var_6 = _func_020D(level._id_5C44["enemy"], var_2, var_1, (0, 0, 1));
    var_6 _meth_8322();
  }

  var_1._id_0BEB[var_0] = var_6;
  triggerfx(var_6);
}

_id_DC89(var_0, var_1) {
  if(isDefined(var_1._id_0BEA[var_0])) {
    var_1._id_0BEA[var_0] delete();
  }

  var_2 = undefined;
  var_3 = var_1.team;
  var_4 = var_1 _meth_81D3();

  if(var_4) {
    var_3 = var_1 _meth_8154();
  } else if(var_3 == "spectator") {
    var_3 = "allies";
  }

  if(var_3 == var_0) {
    var_5 = _func_020D(level._id_5C39["friendly"], self.origin, var_1, self._id_22B6);
    var_5 _meth_8322();
  } else {
    var_5 = _func_020D(level._id_5C39["enemy"], self.origin, var_1, self._id_22B6);
    var_5 _meth_8322();
  }

  var_1._id_0BEA[var_0] = var_5;
  triggerfx(var_5);
}

_id_C4A1(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._id_0BEB[self.team])) {
      self._id_0BEB[self.team] delete();
    }
  } else if(isDefined(self._id_0BEB[scripts\mp\utility\game::_id_6BE2(self.team)[0]]))
    self._id_0BEB[scripts\mp\utility\game::_id_6BE2(self.team)[0]] delete();
}

_id_D713(var_0) {
  if(var_0 == "axis") {
    self _meth_85C4(1);
  } else if(var_0 == "allies") {
    self _meth_85C4(2);
  } else {
    self _meth_85C4(0);
  }
}

_id_B407(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._id_0BEA[self.team])) {
      self._id_0BEA[self.team] delete();
    }
  } else if(isDefined(self._id_0BEA[scripts\mp\utility\game::_id_6BE2(self.team)[0]]))
    self._id_0BEA[scripts\mp\utility\game::_id_6BE2(self.team)[0]] delete();
}

_id_6A43(var_0) {
  var_1 = getent("ctf_flag_" + var_0, "targetname");
  return var_1.origin;
}

_id_405E(var_0, var_1) {
  var_2 = 0;
  var_3 = getent("ctf_zone_" + var_1, "targetname");

  if(!isDefined(var_3)) {
    var_4 = _id_5C07(var_0);
    var_3 = spawn("trigger_radius", var_4.origin - (0, 0, var_4._id_0359 / 2), 0, var_4._id_0359, 80);
    var_3._id_A51C = 1;
    var_3._id_9514 = 1;
    var_3._id_2323 = var_3.origin;
    var_2 = 1;
    var_5[0] = spawn("script_model", var_4.origin);
    var_5[0] setasgametypeobjective();
    var_5[0] _id_D713(var_1);
  } else
    var_5[0] = getent("ctf_flag_" + var_1, "targetname");

  if(!isDefined(var_5[0])) {}

  if(!var_2) {
    var_6 = 15;

    if(level._id_B0B3 > 0 || level._id_C79F > 0) {
      var_6 = var_6 * 2;
    }

    var_7 = spawn("trigger_radius", var_3.origin, 0, var_6, var_3.height);
    var_3 = var_7;
  }

  if(level.mapname == "mp_m_speedball") {
    var_3 _id_5C0D();
    var_3.origin = var_3._id_71A7;
    var_5[0].origin = var_3._id_71A7 - (0, 0, 0.5);
  }

  var_5[0] setModel(level._id_5C3F[var_0]);
  var_5[0] setasgametypeobjective();
  var_5[0] _id_D713(var_1);
  var_8 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  var_9 = _id_07D6::_id_3FA8(var_8, var_3, var_5, (0, 0, 85));
  var_9 _id_07D6::_id_159C("friendly");
  var_9 _id_07D6::_id_D71A("friendly", level._id_B0B3);
  var_9 _id_07D6::_id_D71A("enemy", level._id_C79F);
  var_9 _id_07D6::_id_D8E0("none");
  var_9 _id_07D6::_id_D61B(level._id_7C55, level._id_7C6A);
  var_9 _id_07F9::_id_A8B1(var_9._id_A908, 0);
  var_9 _id_07F9::_id_A8B2(var_9._id_A908, 0);
  var_9 _id_07D6::_id_C245(::_id_5C43);
  var_9._id_15E2 = 1;
  var_9._id_AC90 = var_8;
  var_9._id_AB4D = ::_id_AB4D;
  var_9._id_AB4E = ::_id_AB4D;
  var_9._id_AAB9 = ::_id_AAB9;
  var_9._id_AB88 = ::_id_AB88;

  if(isDefined(level._id_DCA0)) {
    switch (level._id_DCA0) {
      case 0:
        var_9._id_A90C = 1;
        var_9._id_A90B = 0;
        var_9._id_A912 = 60.0;
        break;
      case 1:
        var_9._id_A90C = 0;
        var_9._id_A90B = 0;
        var_9._id_A912 = 0.05;
        break;
      case 2:
        var_9._id_A90C = 1;
        var_9._id_A90B = 0;
        var_9._id_A912 = 1.0;
        break;
      case 3:
        var_9._id_A90C = 1;
        var_9._id_A90B = 0;
        var_9._id_A912 = 1.5;
        break;
      case 4:
        var_9._id_A90C = 1;
        var_9._id_A90B = 0;
        var_9._id_A912 = 2.0;
        break;
      case 5:
        var_9._id_A90C = 1;
        var_9._id_A90B = 0;
        var_9._id_A912 = 3.0;
        break;
      case 6:
        var_9._id_A90C = 1;
        var_9._id_A90B = 0;
        var_9._id_A912 = 4.0;
        break;
    }

    var_10 = _id_07F9::_id_C57D(99);
    var_9._id_B0E1 = var_10;
    _id_07F9::_id_A867(var_10, "done", var_9.origin);
    _id_07F9::_id_A8B1(var_10, 0);
    _id_07F9::_id_A8B2(var_10, 0);
    var_9 _id_07D6::_id_D8E0("none", var_10);
    _func_0182(var_10, var_0);
    var_9 _id_07D6::_id_D61B(level._id_7C55, level._id_7C6A, var_10);
  } else {
    var_9._id_A90C = 1;
    var_9._id_A90B = 0;
    var_9._id_A912 = 3.0;
  }

  var_9._id_AA3B = var_3._id_0359;
  var_11 = var_3.origin + (0, 0, 32);
  var_12 = var_3.origin + (0, 0, -32);
  var_13 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_14 = [];
  var_15 = scripts\engine\trace::ray_trace(var_11, var_12, var_14, var_13);
  var_9._id_22B7 = var_9._id_10430[0].origin;
  var_16 = anglestoup(var_9._id_10430[0].angles);
  var_9._id_22B6 = anglesToForward(var_16);
  level._id_EF71[var_0] = _id_405F(var_0, var_9);
  return var_9;
}

_id_5C43(var_0) {
  return !var_0 scripts\cp_mp\utility\player_utility::isinvehicle();
}

_id_405F(var_0, var_1) {
  var_2 = var_1._id_10430[0].origin;
  var_3 = spawn("script_model", var_2);
  var_3 setModel(level._id_5C38[var_0]);
  var_3._id_ADAE = var_0;
  var_3 setasgametypeobjective();
  var_3 _id_D713(var_0);
  var_3._id_22B7 = var_2;
  var_4 = anglestoup(var_1._id_10430[0].angles);
  var_3._id_22B6 = anglesToForward(var_4);
  return var_3;
}

_id_3FA6(var_0, var_1) {
  var_2 = _id_5C07(var_0);
  var_3 = getent("ctf_zone_" + var_1, "targetname");

  if(!isDefined(var_3)) {
    var_3 = spawn("trigger_radius", var_2.origin - (0, 0, var_2._id_0359 / 2), 0, var_2._id_0359, 80);
    var_3._id_A51C = 1;
    var_3._id_9514 = 1;
    var_3._id_2323 = var_3.origin;
    var_3.height = 80;
  }

  var_4 = spawn("trigger_radius", var_3.origin, 0, 15, var_3.height);
  var_3 = var_4;
  var_5 = [];
  var_6 = _id_07D6::_id_406E(var_0, var_3, var_5, (0, 0, 85));
  var_6 _id_07D6::_id_15DF("friendly");
  var_6 _id_07D6::_id_D8E0("any");
  var_6 _id_07D6::_id_D61B(level._id_7C4E, level._id_7C45);
  var_6 _id_07D6::_id_D8D2(0);
  var_6 _id_07D6::_id_D5C5(level._id_EF72[scripts\mp\utility\game::_id_6BE2(var_0)[0]]);
  var_6._id_ABCB = ::_id_ABCB;
  var_6._id_AA80 = ::_id_AA80;
  var_7 = var_3.origin + (0, 0, 32);
  var_8 = var_3.origin + (0, 0, -32);
  var_9 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_10 = [];
  var_11 = scripts\engine\trace::ray_trace(var_7, var_8, var_10, var_9);
  var_12 = vectortoangles(var_11["normal"]);
  var_13 = anglesToForward(var_12);
  var_14 = anglestoright(var_12);
  return var_6;
}

_id_AA79(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == _id_07D6::_id_6C02()) {
    self.trigger._id_0359 = 1024;
  } else {
    self.trigger._id_0359 = self._id_AA3B;
  }
}

_id_AAC2(var_0, var_1, var_2) {
  self.trigger._id_0359 = self._id_AA3B;
}

_id_AB4D(var_0, var_1, var_2) {
  self notify("picked_up");
  var_0 notify("obj_picked_up");
  var_3 = _id_07D6::_id_6C02();

  if(isDefined(self._id_504B)) {
    if(self._id_504B == var_0.team) {
      _id_07D6::_id_D639(self._id_504B);
      var_3 = self._id_504B;
    } else {
      _id_07D6::_id_D639(scripts\mp\utility\game::_id_6BE2(var_0.team)[0]);
      var_3 = self._id_504B;
    }

    self._id_504B = undefined;
  }

  var_4 = var_0.pers["team"];

  if(var_4 == "allies") {
    var_5 = "axis";
  } else {
    var_5 = "allies";
  }

  if(var_4 != var_3) {
    if(isDefined(level._id_39D2[var_0.team]) && level._id_39D2[var_0.team] == var_0) {
      var_0 thread _id_07B1::_id_6FB9("mode_ctf_nope");
    }

    level._id_39D2[var_0.team] = undefined;
    var_0 thread _id_0A9F::_id_7003("flag_return");
    thread _id_C793();
    var_6 = spawnStruct();
    var_6.player = var_0;
    var_6._id_56B9 = "obj_return";
    var_6._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_6);
    scripts\mp\utility\print::_id_BD0C(var_4, scripts\mp\utility\game::_id_6BE2(var_4)[0], undefined, undefined, "mp_obj_returned", "mp_obj_returned", var_0);
    _id_0A8D::_id_9136("enemy_flag_returned", var_5, "status");
    _id_0A8D::_id_9136("flag_returned", var_4, "status");
    scripts\mp\utility\game::_id_D5FA(18, var_0.team, var_0 getentitynumber());
    var_0 scripts\mp\utility\stats::_id_7DAE("returns", 1);
    var_0 scripts\mp\persistence::_id_E770("round", "returns", var_0.pers["returns"]);

    if(isPlayer(var_0)) {
      var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["returns"]);
    }

    if(self._id_AC90 == "allies") {
      setomnvar("ui_ctf_flag_axis", -2);
    } else {
      setomnvar("ui_ctf_flag_allies", -2);
    }
  } else {
    if(isDefined(level._id_4119) && isDefined(level._id_4119[var_4])) {
      var_0 thread _id_19D1();
    } else {
      var_0 _id_1D87();
    }

    var_0 scripts\mp\utility\stats::_id_7DAE("pickups", 1);
    level._id_39D2[var_5] = undefined;

    if(self._id_AC90 == "allies") {
      setomnvar("ui_ctf_flag_axis", var_0 getentitynumber());
    } else {
      setomnvar("ui_ctf_flag_allies", var_0 getentitynumber());
    }

    var_0 setclientomnvar("ui_ctf_flag_carrier", 1);

    if(isDefined(level._id_DCA0)) {
      if(level._id_DCA0 == 0) {
        _id_07D6::_id_D8E0("none");
      } else {
        _id_07D6::_id_D8E0("friendly");
        _func_016B(self._id_B0E1, "current");
        _id_07D6::_id_FC3A("enemy", self._id_B0E1);
        _func_015D(self._id_B0E1, "icon_waypoint_kill");
        _id_07F9::_id_A878(self._id_B0E1, 1);
      }
    }

    _id_07D6::_id_D61B(level._id_7C55, level._id_7C6A);

    if(level._id_3228 == 0) {
      level._id_323A[var_5] _id_07D6::_id_15DF("none");
    }

    level._id_323A[var_5] _id_07D6::_id_D8E0("none");
    scripts\mp\utility\print::_id_BD0C(var_4, var_5, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", var_0);
    _id_0A8D::_id_9136("enemy_flag_taken", var_4);
    _id_0A8D::_id_9136("flag_getback", var_5);
    thread scripts\mp\hud_util::_id_EF8D("callout_flagpickup", var_0);

    if(!isDefined(self._id_BC36) || self._id_BC36 != var_0) {
      var_0 thread _id_0A9F::_id_7003("flag_grab");
    }

    var_6 = spawnStruct();
    var_6.player = var_0;
    var_6._id_56B9 = "pickup";
    var_6._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_6);
    self._id_BC36 = var_0;

    if(level.codcasterenabled) {
      var_0 _meth_80CB(1);
    }

    var_0 thread _id_EB13();
  }
}

_id_AB4E(var_0) {
  return;
}

_id_C793() {
  _id_07D6::_id_C797();
}

_id_AAB9(var_0) {
  if(isDefined(var_0._id_916E)) {
    self._id_504B = var_0._id_916E;
    var_0._id_916E = undefined;
  } else if(!isDefined(var_0))
    self._id_504B = self._id_AC90;
  else {
    self._id_504B = var_0.team;
  }

  var_0 _id_FCC1();
  _id_07D6::_id_D639(scripts\mp\utility\game::_id_6BE2(self._id_504B)[0]);
  var_1 = self._id_504B;
  var_2 = scripts\mp\utility\game::_id_6BE2(self._id_504B)[0];
  _id_07D6::_id_159C("any");
  _id_07D6::_id_D8E0("any");
  _func_016B(self._id_B0E1, "done");

  if(level._id_C79F >= 0) {
    _id_07D6::_id_D61B(level._id_7C82, level._id_7C45);
  } else {
    _id_07D6::_id_D61B(level._id_7C4E, level._id_7C45);
    _id_07F9::_id_A878(self._id_A908, 1);
  }

  if(self._id_AC90 == "allies") {
    setomnvar("ui_ctf_flag_axis", -1);
  } else {
    setomnvar("ui_ctf_flag_allies", -1);
  }

  if(isDefined(var_0)) {
    var_0 setclientomnvar("ui_ctf_flag_carrier", 0);
  }

  var_3 = self._id_10430[0] gettagorigin("tag_origin");

  if(isDefined(var_0)) {
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      var_0._id_32EC._id_BC36 = undefined;
    }

    if(isDefined(var_0._id_32E6)) {
      var_0 _id_488A();
    }

    scripts\mp\utility\print::_id_BD0C(var_2, "none", undefined, undefined, "mp_war_objective_lost", "", var_0);

    if(level.codcasterenabled) {
      var_0 _meth_80CB(0);
    }
  } else
    _id_0AA2::_id_B8F1("mp_war_objective_lost", var_2);

  _id_0A8D::_id_9136("enemy_flag_dropped", self._id_AC90, "status");
  _id_0A8D::_id_9136("flag_dropped", scripts\mp\utility\game::_id_6BE2(self._id_AC90)[0], "status");

  if(level._id_7CD0 > 0) {
    thread _id_C790();
  }
}

_id_C790() {
  self endon("picked_up");
  var_0 = 0.0;

  while(var_0 < level._id_7CD0) {
    waitframe();

    if(self._id_37F6 == "none") {
      var_0 = var_0 + level._id_5F3A;
    }
  }

  var_1 = _id_07D6::_id_6C02();
  var_2 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  _id_0AA2::_id_B8F1("mp_war_objective_taken", var_1);
  _id_0AA2::_id_B8F1("mp_war_objective_lost", var_2);
  _id_07D6::_id_C797();
}

_id_AB88() {
  if(isDefined(self._id_504B)) {
    _id_07D6::_id_D639(self._id_504B);
  }

  var_0 = _id_07D6::_id_6C02();
  var_1 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  self._id_504B = undefined;
  _id_07D6::_id_159C("friendly");
  _id_07D6::_id_D8E0("none");
  _id_07D6::_id_D61B(level._id_7C55, level._id_7C6A);

  if(self._id_AC90 == "allies") {
    setomnvar("ui_ctf_flag_axis", -2);
  } else {
    setomnvar("ui_ctf_flag_allies", -2);
  }

  level._id_323A[var_1] _id_07D6::_id_15DF("friendly");
  level._id_323A[var_1] _id_07D6::_id_D8E0("any");
  level._id_323A[var_1] _id_07D6::_id_D61B(level._id_7C4E, level._id_7C45);
  self._id_BC36 = undefined;
}

_id_ABCB(var_0) {
  if(!level.gameended) {
    if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return;
    }
    var_1 = var_0.pers["team"];

    if(var_1 == "allies") {
      var_2 = "axis";
    } else {
      var_2 = "allies";
    }

    var_0 setclientomnvar("ui_ctf_flag_carrier", 0);
    _id_0A8D::_id_9136("enemy_flag_captured", var_1, "status");
    _id_0A8D::_id_9136("flag_captured", var_2, "status");
    scripts\mp\utility\game::_id_D5FA(17, var_0.team, var_0 getentitynumber());
    _func_016B(level._id_EF72[var_2]._id_B0E1, "done");
    var_0 _id_FCC1();
    thread scripts\mp\hud_util::_id_EF8D("callout_flagcapture", var_0);
    var_0 thread scripts\mp\rank::_id_CC00("flag_capture");
    var_0 thread _id_07B1::_id_6FB9("mode_ctf_cap");
    var_0 notify("objective", "captured");
    var_3 = spawnStruct();
    var_3.player = var_0;
    var_3._id_56B9 = "capture";
    var_3._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_3);

    if(level.codcasterenabled) {
      var_0 _meth_80CB(0);
    }

    var_0 scripts\mp\utility\stats::_id_7DAE("captures", 1);
    var_0 scripts\mp\persistence::_id_E770("round", "captures", var_0.pers["captures"]);

    if(isPlayer(var_0)) {
      var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["captures"]);
    }

    scripts\mp\utility\print::_id_BD0C(var_1, var_2, undefined, undefined, "mp_obj_captured", "mp_enemy_obj_captured", var_0);

    if(isDefined(var_0._id_32E6)) {
      var_0 _id_488A();
    }

    if(isDefined(level._id_4119) && isDefined(level._id_4119[var_1])) {
      var_0 thread _id_C49F();
    }

    level._id_39D2[var_1] = undefined;
    level._id_39D2[var_2] = undefined;
    level._id_EF72[var_2] _id_C793();
    level scripts\mp\gamescore::_id_7001(var_1, 1, 0);
    var_0 _id_07BC::_id_AA81();
  }
}

onplayerconnect(var_0) {
  var_0._id_0BEA = [];
  var_0._id_0BEB = [];
  var_0 thread onplayerspawned();
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    self setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility\stats::_id_D550(0);

    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility\stats::_id_D550(self.pers["captures"]);
    }

    scripts\mp\utility\stats::_id_D551(0);

    if(isDefined(self.pers["returns"])) {
      scripts\mp\utility\stats::_id_D551(self.pers["returns"]);
    }
  }
}

_id_19D1() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level._id_4119[self.team];
  _id_0A18::_id_E346(self.origin, self.angles);
  self._id_60C7 = self.class;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self._id_8FAF = "gamemode";
  self notify("faux_spawn");
  self._id_60D9 = 1;
  self._id_59DF = self getstance();
  thread scripts\mp\playerlogic::_id_E337(1);
  thread _id_107E1();
}

_id_EB13() {
  self notify("superWatcher");
  self endon("superWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("drop_object");
  var_0 = self.pers["team"];

  if(var_0 == "allies") {
    var_1 = "axis";
  } else {
    var_1 = "allies";
  }

  level._id_EF72[var_1] endon("reset");

  for(;;) {
    self waittill("super_started");
    var_2 = level._id_EF72[var_1];

    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = self._id_EB09;

    switch (var_3._id_E76B._id_C189) {
      case "super_rewind":
        scripts\engine\utility::waittill_any_2("teleport_success", "rewind_success");
        var_2 thread _id_07D6::_id_D537();
        return;
    }
  }
}

_id_107E1() {
  level endon("game_ende");
  self endon("death_or_disconnect");
  self waittill("spawned_player");
  _id_1D87();
}

_id_C49F() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = undefined;
  _id_0A18::_id_E346(self.origin, self.angles);
  self notify("faux_spawn");
  self._id_59DF = self getstance();
  thread scripts\mp\playerlogic::_id_E337(1);
}

_id_AA80(var_0) {}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = var_1.origin;
  var_12 = 0;

  if(isDefined(var_0)) {
    var_11 = var_0.origin;
    var_12 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != self.pers["team"]) {
    if(isDefined(var_1._id_32E6) && var_12) {
      var_1 thread scripts\mp\rank::_id_CC00("carrier_kill");
      var_1 thread _id_07B1::_id_6FB9("mode_ctf_kill_with_flag");
      var_10 = 1;
    }

    if(isDefined(self._id_32E6)) {
      var_13 = distancesquared(self.origin, level._id_323A[self.team].trigger.origin);

      if(var_13 < 90000) {
        level._id_39D2[var_1.team] = var_1;
      } else {
        level._id_39D2[var_1.team] = undefined;
      }

      var_1 thread _id_07B1::_id_6FB9("mode_ctf_kill_carrier");
      var_1 scripts\mp\utility\stats::_id_7DAE("carrierKills", 1);
      var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
      var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
      scripts\mp\utility\game::_id_D5FA(20, var_1.team, var_1 getentitynumber());
      var_10 = 1;
    }

    if(!var_10) {
      var_14 = 0;
      var_15 = 0;

      foreach(var_17 in level._id_EF72) {
        var_18 = _id_4BBA(var_11, self.origin, var_17._id_4140);

        if(var_18) {
          if(var_17._id_ADAE == self.team) {
            var_14 = 1;
            continue;
          }

          var_15 = 1;
        }
      }

      if(var_14) {
        var_1 thread scripts\mp\rank::_id_CC00("assault");
        var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
        var_1 scripts\mp\utility\stats::_id_7DAE("assaults", 1);
      } else if(var_15) {
        var_1 thread scripts\mp\rank::_id_CC00("defend");
        var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
        var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
        var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
      }
    }
  }

  if(isDefined(self._id_32E6)) {
    _id_488A();
  }
}

_id_4BBA(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  } else {
    return 0;
  }
}

_id_1D87() {
  _id_FCC0();
  var_0 = scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0];
  self attach(level._id_32E6[var_0], "J_spine4", 1);
  self._id_32E6 = level._id_32E6[var_0];
}

_id_488A() {
  self detach(self._id_32E6, "J_spine4");
  self._id_32E6 = undefined;
}

_id_D6E1() {
  if(_func_0127() && getmatchrulesdata("defaultClasses", "axis", 5, "class", "inUse")) {
    level._id_4119["axis"] = ::scripts\mp\utility\game::_id_6B33("axis", 5);
  }

  if(_func_0127() && getmatchrulesdata("defaultClasses", "allies", 5, "class", "inUse")) {
    level._id_4119["allies"] = ::scripts\mp\utility\game::_id_6B33("allies", 5);
  }
}

_id_C49E() {
  level endon("game_ended");

  for(;;) {
    if(getDvar("#x3806a10bc0145262", "") != "") {
      var_0 = getDvar("#x3806a10bc0145262", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          var_1 = game["defenders"];
        } else {
          var_1 = game["attackers"];
        }
      } else if(game["switchedsides"])
        var_1 = game["attackers"];
      else {
        var_1 = game["defenders"];
      }

      level._id_EF72[var_1].trigger notify("move_gameobject");
      level._id_EF72[var_1] _id_07D6::_id_15DF("none");
      level._id_EF72[var_1].trigger = undefined;
      level._id_EF72[var_1] notify("deleted");
      level._id_EF72[var_1]._id_10430[0] delete();
      level._id_EF71[var_1] delete();
      level._id_323A[var_1] _id_07D6::_id_15DF("none");
      level._id_323A[var_1].trigger = undefined;
      level._id_323A[var_1] notify("deleted");

      foreach(var_3 in level.players) {
        var_3 _id_B407(var_1);
      }

      level._id_EF72[var_1]._id_1041A = "none";
      level._id_EF72[var_1] _id_07D6::_id_D61B(undefined, undefined);
      level._id_323A[var_1]._id_1041A = "none";
      level._id_323A[var_1] _id_07D6::_id_D61B(undefined, undefined);
      level._id_EF72[var_1] = undefined;
      setdynamicdvar("#x3806a10bc0145262", "");
    }

    wait 1;
  }
}

_id_B167() {
  level endon("game_ended");

  for(;;) {
    if(getDvar("#x3dfcdef2d7e684127", "") != "") {
      var_0 = getDvar("#x3dfcdef2d7e684127", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          var_1 = game["defenders"];
        } else {
          var_1 = game["attackers"];
        }
      } else if(game["switchedsides"])
        var_1 = game["attackers"];
      else {
        var_1 = game["defenders"];
      }

      var_2 = undefined;
      var_2 = spawnStruct();
      var_2 _id_48D8();
      var_2.origin = var_2._id_71A7;
      var_2._id_0359 = 30;
      var_2.team = var_1;
      var_3 = spawn("trigger_radius", var_2.origin, 0, 30, 80);
      var_4[0] = spawn("script_model", var_2.origin);
      var_4[0] setModel(level._id_5C3F[var_1]);
      var_5 = _id_07D6::_id_3FA8(var_1, var_3, var_4, (0, 0, 85));
      var_5 _id_07D6::_id_D719("enemy", &"MP/GRABBING_FLAG");
      var_5 _id_07D6::_id_D719("friendly", &"MP/RETURNING_FLAG");
      var_5 _id_07D6::_id_159C("enemy");
      var_5 _id_07D6::_id_D8E0("none");
      var_5 _id_07D6::_id_D61B(level._id_7C55, level._id_7C6A);
      var_5._id_A90C = 1;
      var_5._id_15E2 = 1;
      var_5._id_AB4D = ::_id_AB4D;
      var_5._id_AB4E = ::_id_AB4D;
      var_5._id_AAB9 = ::_id_AAB9;
      var_5._id_AB88 = ::_id_AB88;
      var_5._id_AA3B = var_3._id_0359;
      var_5.origin = var_2.origin;
      var_5.label = var_1;
      var_5._id_BC36 = undefined;
      var_6 = var_3.origin + (0, 0, 32);
      var_7 = var_3.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_10 = scripts\engine\trace::ray_trace(var_6, var_7, var_9, var_8);
      var_5._id_22B7 = var_10["position"];
      var_11 = vectortoangles(var_10["normal"]);
      var_5._id_22B6 = anglesToForward(var_11);
      level._id_EF71[var_1] = _id_405F(var_1, var_5);

      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          level._id_EF72[game["defenders"]] = var_5;
        } else {
          level._id_EF72[game["attackers"]] = var_5;
        }
      } else if(game["switchedsides"])
        level._id_EF72[game["attackers"]] = var_5;
      else {
        level._id_EF72[game["defenders"]] = var_5;
      }

      var_4 = [];
      var_3 = spawn("trigger_radius", var_2.origin - (0, 0, var_2._id_0359 / 2), 0, var_2._id_0359, 80);
      var_3._id_A51C = 1;
      var_3._id_9514 = 1;
      var_3._id_2323 = var_3.origin;
      var_12 = _id_07D6::_id_406E(var_1, var_3, var_4, (0, 0, 115));
      var_12 _id_07D6::_id_15DF("friendly");
      var_12 _id_07D6::_id_D8E0("any");
      var_12 _id_07D6::_id_D61B(level._id_7C4E, level._id_7C45);
      var_12 _id_07D6::_id_D8D2(0);
      var_12 _id_07D6::_id_D5C5(level._id_EF72[scripts\mp\utility\game::_id_6BE2(var_1)[0]]);
      level._id_323A[scripts\mp\utility\game::_id_6BE2(var_1)[0]] _id_07D6::_id_D5C5(var_5);
      var_12._id_ABCB = ::_id_ABCB;
      var_12._id_AA80 = ::_id_AA80;
      var_6 = var_3.origin + (0, 0, 32);
      var_7 = var_3.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_10 = scripts\engine\trace::ray_trace(var_6, var_7, var_9, var_8);
      var_11 = vectortoangles(var_10["normal"]);
      var_13 = anglesToForward(var_11);
      var_14 = anglestoright(var_11);

      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          level._id_323A[game["defenders"]] = var_12;
        } else {
          level._id_323A[game["attackers"]] = var_12;
        }
      } else if(game["switchedsides"])
        level._id_323A[game["attackers"]] = var_12;
      else {
        level._id_323A[game["defenders"]] = var_12;
      }

      setdynamicdvar("#x3dfcdef2d7e684127", "");
    }

    wait 1;
  }
}

_id_48D8() {
  var_0 = level.players[0].origin + (0, 0, 32);
  var_1 = level.players[0].origin + (0, 0, -1000);
  var_2 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_3 = [];
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, var_3, var_2);
  self._id_71A7 = var_4["position"];
  return var_4["fraction"] != 0 && var_4["fraction"] != 1;
}

_id_D8C5() {
  scripts\mp\gamelogic::_id_D8E5("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_recover_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_take_flag", 2, "enemy", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defend_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
}

_id_FCC1() {
  self setclientomnvar("ui_match_status_hint_text", 37);
}

_id_FCC0() {
  self setclientomnvar("ui_match_status_hint_text", 38);
}