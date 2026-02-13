/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ball.gsc
*************************************************/

main() {
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
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 20);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 5);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
  }

  level._id_32D6 = 100;
  _id_FC7D();
  level.teambased = 1;
  level._id_A8D4 = 0;
  level._id_4A82 = 1;
  level._id_AB7F = ::_id_AB7F;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_9FE8 = ::_id_ABA4;
  level._id_E32D = "mp_ball_spawn";
  level._id_21B0 = 1;
  level._id_CC05 = 0;
  level._id_21AF = 0;
  game["dialog"]["gametype"] = "uplink";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["drone_reset"] = "ul_obj_respawned";
  game["dialog"]["you_own_drone"] = "ally_own_drone";
  game["dialog"]["ally_own_drone"] = "ally_own_drone";
  game["dialog"]["enemy_own_drone"] = "enemy_own_drone";
  game["dialog"]["ally_throw_score"] = "ally_throw_score";
  game["dialog"]["ally_carry_score"] = "ally_carry_score";
  game["dialog"]["enemy_throw_score"] = "enemy_throw_score";
  game["dialog"]["enemy_carry_score"] = "enemy_carry_score";
  game["dialog"]["pass_complete"] = "friendly_pass";
  game["dialog"]["pass_intercepted"] = "pass_intercepted";
  game["dialog"]["ally_drop_drone"] = "ally_drop_drone";
  game["dialog"]["enemy_drop_drone"] = "enemy_drop_drone";
  game["dialog"]["ally_drone_half"] = "halfway_enemy";
  game["dialog"]["enemy_drone_half"] = "halfway_friendly";
  game["dialog"]["offense_obj"] = "capture_obj";
  game["dialog"]["defense_obj"] = "capture_obj";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x355de335e1d911164", getmatchrulesdata("ballData", "scoreCarry"));
  setdynamicdvar("#x372d9449ecd08f30b", getmatchrulesdata("ballData", "scoreThrow"));
  setdynamicdvar("#x3415448d5b5d5d5b5", getmatchrulesdata("ballData", "satelliteCount"));
  setdynamicdvar("#x331e5086b945322d7", getmatchrulesdata("ballData", "practiceMode"));
  setdynamicdvar("#x376663c7ad750e58b", getmatchrulesdata("ballCommonData", "possessionResetCondition"));
  setdynamicdvar("#x399a1c8b9bda09d37", getmatchrulesdata("ballCommonData", "possessionResetTime"));
  setdynamicdvar("#x3ae95511afda2856c", getmatchrulesdata("ballCommonData", "explodeOnExpire"));
  setdynamicdvar("#x3aa05e5cadcd938a4", getmatchrulesdata("ballCommonData", "armorMod"));
  setdynamicdvar("#x3885565e7d5cc4d68", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("#x31c590040dbf46867", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("#x37825cf7a7520fe6f", 0);
}

_id_AB7F() {}

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

  if(game["switchedsides"]) {
    var_3 = game["attackers"];
    var_4 = game["defenders"];
    game["attackers"] = var_4;
    game["defenders"] = var_3;
  }

  foreach(var_6 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_6, &"OBJECTIVES/BALL");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_6, &"OBJECTIVES/BALL");
    } else {
      scripts\mp\utility\game::_id_D61A(var_6, &"OBJECTIVES/BALL_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_6, &"OBJECTIVES/BALL_HINT");
  }

  setclientnamemode("auto_change");
  scripts\mp\gametypes\obj_ball::_id_211A();
  level thread _id_C9B3();

  if(level._id_BA10 != 0) {
    scripts\mp\gametypes\obj_ball::_id_8145();
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_CBF6 = scripts\mp\utility\dvars::_id_509C("scoreCarry", 2, 1, 9);
  level._id_CC23 = scripts\mp\utility\dvars::_id_509C("scoreThrow", 1, 1, 9);
  level._id_CB2A = scripts\mp\utility\dvars::_id_509C("satelliteCount", 1, 1, 5);
  level._id_BB2C = scripts\mp\utility\dvars::_id_509C("practiceMode", 0, 0, 1);
  level._id_BA10 = scripts\mp\utility\dvars::_id_509C("possessionResetCondition", 0, 0, 2);
  level._id_BA11 = scripts\mp\utility\dvars::_id_509A("possessionResetTime", 0, 0, 150);
  level._id_57B9 = scripts\mp\utility\dvars::_id_509C("explodeOnExpire", 0, 0, 1);
  level._id_7CD0 = scripts\mp\utility\dvars::_id_509A("idleResetTime", 15, 0, 60);
  level._id_1B59 = scripts\mp\utility\dvars::_id_509A("armorMod", 1, 0, 2);
  level._id_DCA0 = scripts\mp\utility\dvars::_id_509C("showEnemyCarrier", 5, 0, 6);
  level._id_32D6 = int(level._id_32D6 * level._id_1B59);
}

_id_212D() {
  foreach(var_2, var_1 in level._id_212E) {
    var_1.trigger = spawn("trigger_radius", var_1.origin - (0, 0, var_1._id_0359), 0, var_1._id_0359, var_1._id_0359 * 2);
    var_1._id_FE92 = _id_07D6::_id_406E(var_2, var_1.trigger, [], (0, 0, var_1._id_0359 * 2.1));
    var_1._id_FE92._id_01FA = var_1;
    var_1._id_FE92 _id_07D6::_id_D61B("waypoint_blitz_defend", "waypoint_blitz_goal");
    var_1._id_FE92 _id_07D6::_id_D8E0("any");
    var_1._id_FE92 _id_07D6::_id_15DF("enemy");
    var_1._id_FE92 _id_07D6::_id_D5C5(level._id_21B2);
    var_1._id_FE92 _id_07D6::_id_D8D2(0);
    var_1._id_FE92 _id_07D6::_id_316A(1);
    var_1._id_FE92._id_ABCB = ::_id_2112;
    var_1._id_FE92._id_3207 = ::_id_2128;
    var_1._id_FE92._id_AA8D = ::_id_2129;
    var_1._id_FE92._id_ABC7 = ::_id_212C;
    var_1.killcament = spawn("script_model", var_1.origin + (0, 0, 20));
    var_1.killcament _meth_8375("explosive");
  }
}

_id_2125(var_0, var_1) {
  if(_id_0817::_id_8974()) {
    var_2 = _func_00C4(var_0, var_1, 999999);

    if(isDefined(var_2) && var_2 >= 0) {
      return var_2;
    }
  }

  return distance(var_0, var_1);
}

_id_212A() {
  foreach(var_2, var_1 in level._id_212E) {
    var_1._id_CBEC["friendly"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_friendly"), var_1.origin, (1, 0, 0));
    var_1._id_CBEC["enemy"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_enemy"), var_1.origin, (1, 0, 0));
  }

  level thread _id_214A();

  foreach(var_4 in level.players) {
    _id_212B(var_4);
  }

  thread _id_7081();
}

onplayerconnect(var_0) {
  level endon("game_ended");
  thread onplayerspawned(var_0);

  if(istrue(level._id_BB2C) && var_0 ishost()) {
    var_0 thread scripts\mp\gametypes\obj_ball::_id_BB2D();
    var_0 thread scripts\mp\gametypes\obj_ball::_id_A224();
  }
}

onplayerspawned(var_0) {
  var_0 waittill("spawned");
  var_0 scripts\mp\utility\stats::_id_D550(0);

  if(isDefined(var_0.pers["touchdowns"])) {
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["touchdowns"]);
  }

  var_0 scripts\mp\utility\stats::_id_D551(0);

  if(isDefined(var_0.pers["fieldgoals"])) {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["fieldgoals"]);
  }
}

_id_8294() {
  _id_0817::_id_D461("Uplink", "Crit_Default");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_ball_spawn_allies_start");
  _id_0817::_id_113A("mp_ball_spawn_axis_start");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  var_0 = _id_0817::_id_6D4E(level._id_E32D);
  var_1 = _id_0817::_id_6D4E(level._id_E32D + "_secondary");
  var_2 = _id_1D26(var_0);
  var_3 = _id_1D26(var_1);
  _id_0817::_id_C2B8("allies", var_2["allies"]);
  _id_0817::_id_C2B8("allies", var_3["allies"], 1);
  _id_0817::_id_C2B8("axis", var_2["axis"]);
  _id_0817::_id_C2B8("axis", var_3["axis"], 1);
  _id_0817::_id_0EE5();
}

_id_1D26(var_0) {
  var_1 = [];
  var_1["allies"] = [];
  var_1["axis"] = [];

  if(!isDefined(level._id_9CA2)) {
    level._id_9CA2 = [];
    level._id_9CA2["allies"] = 0;
    level._id_9CA2["axis"] = 0;
  }

  var_2 = level._id_212E["allies"].origin;
  var_3 = level._id_212E["axis"].origin;

  foreach(var_5 in var_0) {
    var_6 = _id_6D4F(var_5, var_2);
    var_7 = _id_6D4F(var_5, var_3);
    var_5._id_4BBD = [];
    var_5._id_4BBD["allies"] = var_6;
    var_5._id_4BBD["axis"] = var_7;
    var_8 = max(var_6, var_7);
    var_9 = min(var_6, var_7);

    if(abs(var_8 - var_9) / var_8 < 0.2) {
      var_1["allies"][var_1["allies"].size] = var_5;
      var_1["axis"][var_1["axis"].size] = var_5;
    } else if(var_7 < var_6)
      var_1["axis"][var_1["axis"].size] = var_5;
    else {
      var_1["allies"][var_1["allies"].size] = var_5;
    }

    if(var_6 > level._id_9CA2["allies"]) {
      level._id_9CA2["allies"] = var_6;
    }

    if(var_7 > level._id_9CA2["axis"]) {
      level._id_9CA2["axis"] = var_7;
    }
  }

  return var_1;
}

_id_6D4F(var_0, var_1) {
  var_2 = _func_00C4(var_0.origin, var_1, 16000);

  if(var_2 < 0) {
    var_2 = distance(var_0.origin, var_1);
  }

  return var_2;
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(_id_0817::_id_DC06()) {
    if(game["switchedsides"]) {
      var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
    }

    var_1 = _id_0817::_id_6D4E(level._id_E32D + "_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
  } else {
    var_1 = _id_0817::_id_6DDD(var_0);
    var_3 = _id_0817::_id_6DCD(var_0);
    var_4 = [];
    var_5["homeBaseTeam"] = var_0;
    var_5["maxDistToHomeBase"] = level._id_9CA2[var_0];
    var_2 = undefined;
  }

  return var_2;
}

_id_C9B3() {
  level._id_2156 = [];
  level._id_21B2 = [];
  level._id_2193 = [];
  _id_2119("allies");
  _id_2119("axis");
  level thread _id_2116();
  scripts\mp\gametypes\obj_ball::_id_2131();
  scripts\mp\gametypes\obj_ball::_id_2117();

  for(var_0 = 0; var_0 < level._id_CB2A; var_0++) {
    scripts\mp\gametypes\obj_ball::_id_2155(var_0);
  }

  _id_212D();
  _id_212A();
  _id_8294();
  thread _id_C53B();
  thread _id_B17D();
  level._id_210A = level._id_21B2[0];
}

_id_211F(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self._id_71A7 = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

_id_2119(var_0) {
  var_1 = var_0;

  if(game["switchedsides"]) {
    var_1 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  }

  var_2 = scripts\engine\utility::getstruct("ball_goal_" + var_1, "targetname");

  if(isDefined(var_2)) {
    var_2 = _id_354F(var_2, var_0);
    var_2 _id_211F();
  } else {
    var_2 = spawnStruct();

    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_2.origin)) {
      var_2.origin = level._id_456E[var_0];
    }

    var_2 _id_211F();
  }

  if(istrue(scripts\cp_mp\utility\game_utility::_id_89EC())) {
    var_2.origin = var_2._id_71A7 + (0, 0, 130);
  } else {
    var_2.origin = var_2._id_71A7 + (0, 0, 130);
  }

  var_2._id_0359 = 60;
  var_2.team = var_0;
  var_2._id_2130 = 0;
  var_2._id_7930 = 0;
  level._id_212E[var_0] = var_2;
}

_id_354F(var_0, var_1) {
  if(level.mapname == "mp_metropolis") {
    if(!game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (-2039, -1464, 123);
    } else if(game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (-2039, -1464, 123);
    }
  }

  if(level.mapname == "mp_fallen") {
    if(!game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (2752, 1429, 988);
    } else if(game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (2752, 1429, 988);
    }

    if(!game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (-1866, 1698, 988);
    } else if(game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (-1866, 1698, 988);
    }
  }

  return var_0;
}

_id_2116() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread scripts\mp\gametypes\obj_ball::_id_214D();
  }
}

_id_2149() {
  var_0 = self._id_10430[0];
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    _id_2157(var_0);
  }
}

_id_213F() {
  var_0 = self._id_10430[0];
  self endon("pass_end");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    _id_2157(var_0);
  }
}

_id_2157(var_0) {
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");

  for(;;) {
    foreach(var_5, var_2 in level._id_212E) {
      if(self._id_8FA9 == var_5) {
        continue;
      }
      if(!var_2._id_FE92 _id_2128()) {
        continue;
      }
      var_3 = distance(var_0.origin, var_2.origin);

      if(var_3 <= var_2._id_0359) {
        thread _id_2158(var_2);
        var_0 notify("pass_end");
        return;
      }

      if(isDefined(var_0._id_AC7E)) {
        var_4 = _id_94DF(var_0._id_AC7E, var_0.origin, var_2.origin, var_2._id_0359);

        if(var_4) {
          thread _id_2158(var_2);
          var_0 notify("pass_end");
          return;
        }
      }
    }

    waitframe();
  }
}

_id_2128(var_0) {
  var_1 = self._id_01FA;

  if(var_1._id_2130) {
    return 0;
  }

  return 1;
}

_id_2129() {
  _id_218A();
}

_id_212C(var_0) {
  _id_7082();
}

_id_2112(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_32EC)) {
    return;
  }
  if(isDefined(level._id_CC05) && level._id_CC05 > gettime()) {
    return;
  }
  if(_id_8AA3()) {
    return;
  }
  if(level.gameended) {
    return;
  }
  var_0 notify("goal_scored");
  var_1 = level._id_CBF6;
  var_0 thread _id_07B1::_id_6FB9("mode_uplink_dunk");
  _id_2113(var_0, 1);
  var_0 scripts\mp\utility\stats::_id_7DAE("touchdowns", 1);
  var_0 scripts\mp\persistence::_id_E770("round", "touchdowns", var_0.pers["touchdowns"]);

  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["touchdowns"]);
    var_2 = spawnStruct();
    var_2.player = var_0;
    var_2._id_56B9 = "dunk";
    var_2._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_2);
  }

  var_3 = self._id_01FA.team;
  var_4 = scripts\mp\utility\game::_id_6BE2(var_3)[0];
  _id_0A8D::_id_E775("enemy_carry_score", var_3, 1);
  _id_0A8D::_id_E775("ally_carry_score", var_4, 1);
  _id_214C(self._id_01FA);
  _id_2151(var_4, 1);
  var_5 = var_0._id_32EC;
  var_5._id_8FA8 = 1;
  var_5 scripts\mp\gametypes\obj_ball::_id_2152(1, self.trigger.origin, 1);
  var_5 thread _id_2150(self._id_01FA);
  _id_2127(var_4, var_1);
}

_id_DAC5(var_0, var_1) {
  var_2 = scripts\mp\gamescore::_id_0C0F(var_0);
  var_3 = scripts\mp\gamescore::_id_0C0F(scripts\mp\utility\game::_id_6BE2(var_0)[0]);
  return var_2 + var_1 >= var_3;
}

_id_94DF(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = vectordot(var_4, var_0 - var_2);
  var_5 = var_5 * var_5;
  var_6 = var_0 - var_2;
  var_6 = var_6 * var_6;
  var_7 = var_3 * var_3;
  return var_5 - var_6 + var_7 >= 0;
}

_id_2158(var_0) {
  if(isDefined(level._id_CC05) && level._id_CC05 > gettime()) {
    return;
  }
  if(_id_8AA3()) {
    return;
  }
  if(level.gameended) {
    return;
  }
  _id_214C(var_0);
  var_1 = level._id_CC23;
  var_2 = var_0.team;
  var_3 = scripts\mp\utility\game::_id_6BE2(var_2)[0];
  _id_0A8D::_id_E775("enemy_throw_score", var_2, 1);
  _id_0A8D::_id_E775("ally_throw_score", var_3, 1);

  if(isDefined(self._id_8FA7)) {
    self._id_8FA8 = 1;
    self._id_8FA7 thread _id_07B1::_id_6FB9("mode_uplink_fieldgoal");
    _id_2113(self._id_8FA7, 0);
    self._id_8FA7 scripts\mp\utility\stats::_id_7DAE("fieldgoals", 1);
    self._id_8FA7 scripts\mp\persistence::_id_E770("round", "fieldgoals", self._id_8FA7.pers["fieldgoals"]);

    if(isPlayer(self._id_8FA7)) {
      self._id_8FA7 scripts\mp\utility\stats::_id_D551(self._id_8FA7.pers["fieldgoals"]);
      var_4 = spawnStruct();
      var_4.player = self._id_8FA7;
      var_4._id_56B9 = "fieldgoal";
      var_4._id_033E = self._id_8FA7.origin;
      _id_06E2::_id_4C2A("callback_on_game_event", var_4);
    }
  }

  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }

  _id_2151(var_3, 0);
  thread _id_2150(var_0);
  _id_2127(var_3, var_1);
}

_id_8AA3() {
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("timelimit");

  if(var_0 != 0) {
    var_1 = scripts\mp\gamelogic::_id_6DE8();

    if(var_1 <= 0) {
      return 1;
    }
  }

  return 0;
}

_id_2127(var_0, var_1) {
  level scripts\mp\gamescore::_id_7001(var_0, var_1, 0);
}

_id_2150(var_0) {
  level thread _id_CC04();
  self notify("score_event");

  if(istrue(level._id_BB2C)) {
    foreach(var_2 in level.players) {
      if(var_2 ishost()) {
        var_2 thread scripts\mp\gametypes\obj_ball::_id_A224();
        break;
      }
    }
  }

  self._id_7D6B = 1;
  var_0._id_2130 = 1;
  var_4 = self._id_10430[0];

  if(isDefined(self._id_BD9B)) {
    self._id_BD9B delete();
  }

  var_4 physicslaunchserver(var_4.origin, (0, 0, 0));
  var_4 _meth_8545();
  _id_07D6::_id_159C("none");
  scripts\mp\gametypes\obj_ball::_id_218F();
  var_5 = 0.4;
  var_6 = 1.2;
  var_7 = 1.0;
  var_8 = var_5 + var_7;
  var_9 = var_8 + var_6;
  var_4 moveto(var_0.origin, var_5, 0, var_5);
  var_4 rotatevelocity((1080, 1080, 0), var_9, var_9, 0);
  wait(var_8);
  var_4 movez(4000, var_6, var_6 * 0.1, 0);
  wait(var_6);
  var_0._id_2130 = 0;
  scripts\mp\gametypes\obj_ball::_id_214F(0, 0);
}

_id_2113(var_0, var_1) {
  if(!isDefined(var_0._id_AEB5) || !isDefined(var_0._id_AEB2)) {
    return;
  }
  if(var_0._id_AEB5 + 3000 < gettime()) {
    return;
  }
  if(var_1) {
    var_0._id_AEB2 thread _id_07B1::_id_6FB9("mode_uplink_allyoop");
  }
}

_id_214C(var_0) {
  var_0._id_CBEC["friendly"] hide();
  var_0._id_CBEC["enemy"] hide();

  foreach(var_2 in level.players) {
    var_3 = _id_2126(var_2);

    if(var_3 == var_0.team) {
      var_0._id_CBEC["friendly"] showtoplayer(var_2);
      continue;
    }

    var_0._id_CBEC["enemy"] showtoplayer(var_2);
  }

  triggerfx(var_0._id_CBEC["friendly"]);
  triggerfx(var_0._id_CBEC["enemy"]);
}

_id_218E() {
  _id_07D6::_id_D61B("waypoint_reset_marker", "waypoint_reset_marker");
}

_id_218A() {
  _id_07D6::_id_D61B("waypoint_uplink_contested", "waypoint_uplink_contested");
}

_id_7082() {
  _id_07D6::_id_D61B("waypoint_blitz_defend", "waypoint_blitz_goal");
}

_id_2151(var_0, var_1) {
  if(var_1) {
    scripts\mp\gametypes\obj_ball::_id_214B(var_0, "mp_uplink_goal_carried_friendly", "mp_uplink_goal_carried_enemy");
  } else {
    scripts\mp\gametypes\obj_ball::_id_214B(var_0, "mp_uplink_goal_friendly", "mp_uplink_goal_enemy");
  }
}

_id_CC04() {
  level endon("game_ended");
  level._id_CC05 = gettime() + 10000;

  foreach(var_1 in level._id_212E) {
    var_1 thread _id_4CCD();
  }
}

_id_4CCD() {
  self._id_FE92 _id_218E();
  level scripts\engine\utility::_id_108A7(10, "goal_ready");
  self._id_FE92 _id_7082();
}

_id_2135() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_212A = [];
    var_0 thread _id_B566();
  }
}

_id_B566() {
  self waittill("disconnect");
  _id_B406();
}

_id_212B(var_0) {
  var_1 = _id_2126(var_0);
  var_0 _id_B406();

  foreach(var_6, var_3 in level._id_212E) {
    var_4 = scripts\engine\utility::ter_op(var_6 == var_1, "ball_goal_friendly", "ball_goal_enemy");
    var_5 = _func_020D(scripts\engine\utility::getfx(var_4), var_3.origin, var_0, (1, 0, 0));
    var_5 _meth_8322();
    var_0._id_212A[var_4] = var_5;
    triggerfx(var_5);
  }
}

_id_2126(var_0) {
  var_1 = var_0.team;

  if(var_1 != "allies" && var_1 != "axis") {
    if(var_0 _meth_81D3()) {
      var_1 = var_0 _meth_8154();
    } else {
      var_1 = "allies";
    }
  }

  return var_1;
}

_id_B406() {
  if(isDefined(self._id_212A)) {
    foreach(var_1 in self._id_212A) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

_id_7081() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    var_1 _id_B406();
  }
}

_id_214A() {}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  var_11 = 0;

  if(!isDefined(var_1) || !isDefined(var_1.team) || !isDefined(var_10) || !isDefined(var_10.team)) {
    return;
  }
  if(var_1 == var_10) {
    return;
  }
  if(var_1.team == var_10.team) {
    return;
  }
  var_12 = var_1.origin;
  var_13 = 0;

  if(isDefined(var_0)) {
    var_12 = var_0.origin;
    var_13 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != var_10.pers["team"]) {
    if(isDefined(var_1._id_2110) && var_13) {
      var_11 = 1;
    }

    if(isDefined(var_10._id_2110)) {
      var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
      var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
      scripts\mp\gametypes\obj_ball::_id_FD66("neutral", 1, 0);
      var_11 = 1;
    }
  }

  if(!var_11) {
    var_14 = 0;

    foreach(var_16 in level._id_21B2) {
      var_14 = _id_4BBA(var_12, var_10.origin, var_16._id_4140);

      if(var_14 && var_1.team != var_10.team) {
        if(var_16._id_ADAE == var_10.team) {
          var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
        } else if(var_16._id_ADAE == var_1.team) {
          var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
        }

        break;
      }
    }

    if(!var_14) {
      foreach(var_21, var_19 in level._id_212E) {
        var_20 = _id_4BBA(var_12, var_10.origin, var_19.trigger.origin);

        if(var_20) {
          if(var_21 == var_10.team) {
            var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
            continue;
          }

          var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
        }
      }
    }
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

_id_ABA4() {
  self._id_F03B = 0;
}

_id_7902(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
  }
}

_id_C53B() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3806a10bc0145262", "") != "") {
      var_0 = getDvar("#x3806a10bc0145262", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      level._id_212E[var_1]._id_FE92 _id_07D6::_id_15DF("none");
      level._id_212E[var_1]._id_FE92.trigger = undefined;
      level._id_212E[var_1]._id_FE92 notify("deleted");

      foreach(var_3 in level.players) {
        var_3 _id_B406();
      }

      level._id_212E[var_1]._id_FE92._id_1041A = "none";
      level._id_212E[var_1]._id_FE92 _id_07D6::_id_D61B(undefined, undefined);
      setdynamicdvar("#x3806a10bc0145262", "");
    }

    wait 1;
  }
}

_id_B17D() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3dfcdef2d7e684127", "") != "") {
      var_0 = getDvar("#x3dfcdef2d7e684127", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      var_2 = spawnStruct();
      var_2.origin = level.players[0].origin;
      var_2.origin = var_2.origin + (0, 0, 190);
      var_2._id_0359 = 50;
      var_2.team = var_1;
      var_2._id_2130 = 0;
      var_2._id_7930 = 0;
      level._id_212E[var_1] = var_2;
      var_2.trigger = spawn("trigger_radius", var_2.origin - (0, 0, var_2._id_0359), 0, var_2._id_0359, var_2._id_0359 * 2);
      var_2._id_FE92 = _id_07D6::_id_406E(var_1, var_2.trigger, [], (0, 0, var_2._id_0359 * 2.1));
      var_2._id_FE92._id_01FA = var_2;
      var_2._id_FE92 _id_07D6::_id_D61B("waypoint_blitz_defend", "waypoint_blitz_goal");
      var_2._id_FE92 _id_07D6::_id_D8E0("any");
      var_2._id_FE92 _id_07D6::_id_15DF("enemy");
      var_2._id_FE92 _id_07D6::_id_D5C5(level._id_21B2);
      var_2._id_FE92 _id_07D6::_id_D8D2(0);
      var_2._id_FE92 _id_07D6::_id_316A(1);
      var_2._id_FE92._id_ABCB = ::_id_2112;
      var_2._id_FE92._id_3207 = ::_id_2128;
      var_2._id_FE92._id_AA8D = ::_id_2129;
      var_2._id_FE92._id_ABC7 = ::_id_212C;
      var_2.killcament = spawn("script_model", var_2.origin + (0, 0, 20));
      var_2.killcament _meth_8375("explosive");
      _id_212A();
      setdynamicdvar("#x3dfcdef2d7e684127", "");
    }

    wait 1;
  }
}