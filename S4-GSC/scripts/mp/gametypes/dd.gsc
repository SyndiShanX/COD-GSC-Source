/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dd.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "dd_bombzone";
  var_0[2] = "blocker";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 180);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_D635(180);
  }

  _id_FC7D();
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_AB7F = ::_id_AB7F;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AAA3 = ::_id_AAA3;
  level._id_ABC0 = ::_id_ABC0;
  level._id_AB3F = ::_id_AB3F;
  level._id_60D0 = scripts\mp\utility\game::_id_899A;
  level._id_C650 = scripts\mp\gametypes\obj_bombzone::_id_C650;
  level._id_4369 = 1;
  level._id_267E = 0;
  level._id_436B = [];
  level._id_19B0 = 0;
  level._id_29EA = 0;
  scripts\mp\gametypes\obj_bombzone::_id_D4A0();
  game["dialog"]["gametype"] = "gametype_demo";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["bomb_achieve"] = "bomb_achieve";
  game["dialog"]["bomb_taken"] = "bomb_taken";
  game["dialog"]["bomb_lost"] = "bomb_enemyowns";
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["bomb_planted"] = "bomb_planted";
  game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
  game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
  game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
  game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";

  if(!isDefined(game["roundsPlayed"])) {
    var_1 = "boost_demoattack";
    var_2 = "boost_demodefend";
  } else if(game["roundsPlayed"] == 2) {
    var_1 = "boost_demo_ot";
    var_2 = "boost_demo_ot";
  } else {
    var_1 = "boost_demoattack_short";
    var_2 = "boost_demodefend_short";
  }

  game["dialog"]["offense_obj"] = var_1;
  game["dialog"]["defense_obj"] = var_2;
  return isDefined(game["status"]) && game["status"] == "overtime";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  setomnvar("ui_bomb_interacting", 0);
  level._id_A5E0 = 1;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3593492d13768234b", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("#x3a2ee4408d81d9f92", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("#x3c04dd80aeda7a46d", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("#x3ba6041bc264426ec", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("#x3cfe8bf9d0a131cfd", getmatchrulesdata("demData", "extraTime"));
  setdynamicdvar("#x3f11401fff9ec423c", getmatchrulesdata("demData", "overtimeLimit"));
  setdynamicdvar("#x39a709d9493cd816a", 0);
  scripts\mp\utility\game::_id_C25D("dd", 0);
  setdynamicdvar("#x37af1ac80a8a2e31a", 0);
}

_id_AB7F() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

_id_ABAD() {
  if(game["roundsPlayed"] == 2) {
    game["status"] = "overtime";
    setDvar("#x31da92e2adcc4dee0", 1);
  }

  if(scripts\mp\utility\game::_id_82D1()) {
    setomnvar("ui_round_hint_override_attackers", 1);
    setomnvar("ui_round_hint_override_defenders", 1);
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  level._id_FED4 = 1;
  setclientnamemode("manual_change");

  if(scripts\mp\utility\game::_id_82D1()) {
    game["dialog"]["defense_obj"] = "obj_destroy";
  }

  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::_id_D61C(game["attackers"], &"OBJECTIVES/DD_ATTACKER");
  scripts\mp\utility\game::_id_D61C(game["defenders"], &"OBJECTIVES/DD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/DD_ATTACKER");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/DD_DEFENDER");
  } else {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/DD_ATTACKER_SCORE");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/DD_DEFENDER_SCORE");
  }

  if(scripts\mp\utility\game::_id_82D1()) {
    scripts\mp\utility\game::_id_D615(game["attackers"], &"OBJECTIVES/DD_OVERTIME_HINT");
    scripts\mp\utility\game::_id_D615(game["defenders"], &"OBJECTIVES/DD_OVERTIME_HINT");
  } else {
    scripts\mp\utility\game::_id_D615(game["attackers"], &"OBJECTIVES/DD_ATTACKER_HINT");
    scripts\mp\utility\game::_id_D615(game["defenders"], &"OBJECTIVES/DD_DEFENDER_HINT");
  }

  thread _id_10976();
  _id_D897();
  thread _id_267A();
}

_id_8294() {
  _id_0817::_id_D461("Default", "Crit_Default");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_dd_spawn_attacker_start");
  _id_0817::_id_113A("mp_dd_spawn_defender_start");
  _id_0817::_id_1136(game["attackers"], "mp_dd_spawn_attacker_start");
  _id_0817::_id_1136(game["defenders"], "mp_dd_spawn_defender_start");
  var_0 = _id_0817::_id_6D4E("mp_dd_spawn_attacker_start");
  var_1 = _id_0817::_id_6D4E("mp_dd_spawn_defender_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136(game["defenders"], "mp_dd_spawn_defender");
  _id_0817::_id_1136(game["defenders"], "mp_dd_spawn_defender_a", 1);
  _id_0817::_id_1136(game["defenders"], "mp_dd_spawn_defender_b", 1);
  _id_0817::_id_1136(game["attackers"], "mp_dd_spawn_attacker");
  _id_0817::_id_1136(game["attackers"], "mp_dd_spawn_attacker_a", 1);
  _id_0817::_id_1136(game["attackers"], "mp_dd_spawn_attacker_b", 1);
  _id_0817::_id_1136(game["attackers"], "mp_tdm_spawn");
  level._id_E112 = _id_0817::_id_6D4E("mp_dd_spawn_defender");
  _id_0817::_id_C2B9("dd_defenders", level._id_E112);
  level._id_E113 = _id_0817::_id_6D4E("mp_dd_spawn_defender_a");
  level._id_E113 = scripts\engine\utility::array_combine(level._id_E112, level._id_E113);
  _id_0817::_id_C2B9("dd_defenders_a", level._id_E113);
  level._id_E114 = _id_0817::_id_6D4E("mp_dd_spawn_defender_b");
  level._id_E114 = scripts\engine\utility::array_combine(level._id_E112, level._id_E114);
  _id_0817::_id_C2B9("dd_defenders_b", level._id_E114);
  level._id_E115 = scripts\engine\utility::array_combine(level._id_E112, level._id_E113, level._id_E114);
  _id_0817::_id_C2B9("dd_defenders_fallback", level._id_E115);
  level._id_E0D7 = _id_0817::_id_6D4E("mp_dd_spawn_attacker");
  _id_0817::_id_C2B9("dd_attackers", level._id_E0D7);
  level._id_E0D8 = _id_0817::_id_6D4E("mp_dd_spawn_attacker_a");
  level._id_E0D8 = scripts\engine\utility::array_combine(level._id_E0D7, level._id_E0D8);
  _id_0817::_id_C2B9("dd_attackers_a", level._id_E0D8);
  level._id_E0D9 = _id_0817::_id_6D4E("mp_dd_spawn_attacker_b");
  level._id_E0D9 = scripts\engine\utility::array_combine(level._id_E0D7, level._id_E0D9);
  _id_0817::_id_C2B9("dd_attackers_b", level._id_E0D9);
  level._id_E0DA = scripts\engine\utility::array_combine(level._id_E0D7, level._id_E0D8, level._id_E0D9);
  _id_0817::_id_C2B9("dd_attackers_fallback", level._id_E0DA);
  level._id_E116 = _id_0817::_id_6D4E("mp_dd_spawn_defender_start");
  level._id_E0DB = _id_0817::_id_6D4E("mp_dd_spawn_attacker_start");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4F(var_0, var_1) {
  var_2 = _func_00C4(var_0.origin, var_1, 16000);

  if(var_2 < 0) {
    var_2 = distance(var_0.origin, var_1);
  }

  return var_2;
}

_id_10976() {
  level endon("game_end");

  for(;;) {
    if(level._id_7EB0 == 0) {
      break;
    }

    waitframe();
  }

  level._id_FED4 = 0;
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else {
    var_2 = undefined;
    var_3 = undefined;

    if(var_0 == game["attackers"]) {
      if(scripts\mp\utility\game::_id_82D1()) {
        var_2 = "dd_attackers";
      } else if(!level._id_19B0 && !level._id_29EA) {
        var_2 = "dd_attackers";
      } else if(level._id_19B0 && !level._id_29EA) {
        var_2 = "dd_attackers_a";
      } else if(level._id_29EA && !level._id_19B0) {
        var_2 = "dd_attackers_b";
      } else {
        var_2 = "dd_attackers";
      }

      var_3 = "dd_attackers_fallback";
    } else {
      if(scripts\mp\utility\game::_id_82D1()) {
        var_2 = "dd_defenders";
      } else if(!level._id_19B0 && !level._id_29EA) {
        var_2 = "dd_defenders";
      } else if(level._id_19B0 && !level._id_29EA) {
        var_2 = "dd_defenders_a";
      } else if(level._id_29EA && !level._id_19B0) {
        var_2 = "dd_defenders_b";
      } else {
        var_2 = "dd_defenders";
      }

      var_3 = "dd_defenders_fallback";
    }

    var_1 = _id_0817::_id_6D4A(self, var_0, var_2, var_3);
  }

  return var_1;
}

_id_ABA4() {
  if(scripts\mp\utility\game::_id_82D1() || self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
    self._id_8986 = 0;
    self._id_87F7 = 0;
    self._id_8783 = 1;
  } else {
    self._id_8986 = 0;
    self._id_87F7 = 0;
    self._id_8783 = 0;
  }

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::_id_D550(self.pers["plants"]);
  } else {
    scripts\mp\utility\stats::_id_D550(0);
  }

  if(isDefined(self.pers["defuses"])) {
    scripts\mp\utility\stats::_id_D551(self.pers["defuses"]);
  } else {
    scripts\mp\utility\stats::_id_D551(0);
  }

  level notify("spawned_player");
}

_id_78F0() {
  self endon("disconnect");
  level waittill("game_ended");

  if(isDefined(self._id_32E7)) {
    self._id_32E7.alpha = 0;
  }
}

_id_436A(var_0, var_1) {
  setomnvar("ui_bomb_interacting", 0);
  thread scripts\mp\gamelogic::_id_52F7(var_0, var_1);
}

_id_AAA3(var_0) {
  if(level._id_265C > 0 || level._id_2635) {
    return;
  }
  if(var_0 == "all") {
    if(level._id_2663) {
      _id_436A(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
    } else {
      _id_436A(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    }
  } else if(var_0 == game["attackers"]) {
    if(level._id_2663) {
      return;
    }
    level thread _id_436A(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread _id_436A(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = var_0.team;

  if(var_0._id_8986) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  } else if(var_0._id_87F7) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  }

  scripts\mp\gametypes\obj_bombzone::_id_2685(var_1, var_0);
}

_id_ABC0() {
  if(scripts\mp\utility\game::_id_82D1()) {
    _id_436A("tie", game["end_reason"]["time_limit_reached"]);
  } else {
    _id_436A(game["defenders"], game["end_reason"]["time_limit_reached"]);
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_B1DA = scripts\mp\utility\dvars::_id_509A("planttime", 5, 0, 20);
  level._id_4644 = scripts\mp\utility\dvars::_id_509A("defusetime", 5, 0, 20);
  level._id_2682 = scripts\mp\utility\dvars::_id_509C("bombtimer", 45, 1, 300);
  level._id_436D = scripts\mp\utility\dvars::_id_509A("extraTime", 120, 0, 500);
  level._id_AD6F = scripts\mp\utility\dvars::_id_509A("overtimeLimit", 1, 0, 180);
  level._id_C63B = scripts\mp\utility\dvars::_id_509C("resetProgress", 1, 0, 1);
  scripts\mp\utility\game::_id_D635(level._id_AD6F);
  level._id_DD44 = scripts\mp\utility\dvars::_id_509C("silentPlant", 0, 0, 1);
}

_id_103A9(var_0) {
  var_1 = "";

  if(var_0.size != 3) {
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(issubstr(tolower(var_6._id_CD99), "a")) {
        var_2 = 1;
        continue;
      }

      if(issubstr(tolower(var_6._id_CD99), "b")) {
        var_3 = 1;
        continue;
      }

      if(issubstr(tolower(var_6._id_CD99), "c")) {
        var_4 = 1;
      }
    }

    if(!var_2) {
      var_1 = var_1 + " A ";
    }

    if(!var_3) {
      var_1 = var_1 + " B ";
    }

    if(!var_4) {
      var_1 = var_1 + " C ";
    }
  }

  if(var_1 != "") {
    return;
  }
}

_id_267A() {
  waittillframeend;
  level._id_2663 = 0;
  level._id_2635 = 0;
  level._id_265C = 0;
  level._id_A2F7 = 1;
  var_0 = getEntArray("dd_bombzone", "targetname");
  _id_103A9(var_0);
  level._id_A8E8 = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_bombzone::_id_D896(var_2, 1);

    if(isDefined(var_3)) {
      var_3._id_AA79 = ::_id_AA79;
      var_3._id_AAC2 = ::_id_AAC2;
      var_3._id_ABCB = ::_id_ABD2;
      level._id_A8E8[var_3._id_A8E1] = var_3;
    }
  }

  _id_8294();

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  foreach(var_3 in level._id_A8E8) {
    var_3 _id_07D6::_id_C579(1, 1);

    if(scripts\mp\utility\game::_id_82D1()) {
      var_3 _id_07D6::_id_D61B("waypoint_target_neutral");
    } else {
      var_3 _id_07D6::_id_D61B("waypoint_defend", "waypoint_target");
    }

    var_3 _id_07D6::_id_D8E0("any");
  }
}

_id_AA79(var_0) {
  scripts\mp\gametypes\obj_bombzone::_id_268A(var_0);
}

_id_AAC2(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::_id_268F(var_0, var_1, var_2);
}

_id_ABD2(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;
  level thread scripts\mp\hud_message::_id_A6B6("emp_planted", "emp_planted_enemy", var_0.team, var_1);
  var_0 thread scripts\mp\hud_message::showsplash("emp_planted", scripts\mp\rank::getscoreinfovalue("plant"));
  scripts\mp\gametypes\obj_bombzone::_id_2691(var_0);
}

_id_D886() {
  var_0 = spawn("script_origin", self.origin);
  var_0.angles = self.angles;
  var_0 rotateyaw(-45, 0.05);
  waitframe();
  var_1 = self.origin + (0, 0, 5);
  var_2 = self.origin + anglesToForward(var_0.angles) * 100 + (0, 0, 128);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, self, scripts\engine\trace::_id_3EF6(1));
  self.killcament = spawn("script_model", var_3["position"]);
  self.killcament _meth_8375("explosive");
  var_0 delete();
}

_id_C606(var_0) {
  if(scripts\mp\utility\game::_id_82D1()) {
    _id_07D6::_id_D639("neutral");
    _id_07D6::_id_D61B("waypoint_target");
  } else {
    _id_07D6::_id_D639(game["defenders"]);
    _id_07D6::_id_15DF("enemy");
    _id_07D6::_id_D61B("waypoint_defend", "waypoint_target");
  }

  _id_07D6::_id_D8D0(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  self._id_7C8C = "bomb_zone";
  _id_07D6::_id_D8D2(level._id_B1DA);
  _id_07D6::_id_D8E0("any");
  self.useweapon = makeweapon("briefcase_bomb_mp");
  self._id_265C = undefined;
}

_id_D872() {
  _id_07D6::_id_15DF("friendly");
  _id_07D6::_id_D8D2(level._id_4644);
  _id_07D6::_id_D5C5(undefined);
  _id_07D6::_id_D61B("waypoint_defuse", "waypoint_defend");
  _id_07D6::_id_D8E0("any");
}

_id_AA80(var_0) {
  var_0 iprintlnbold(&"MP/BOMBSITE_IN_USE");
}

_id_AB88() {}

_id_2663(var_0, var_1) {
  var_0 endon("defused");
  var_2 = var_1.team;
  level._id_267E = level._id_267E + 1;
  scripts\mp\gamelogic::pausetimer();
  level._id_F23D = gettime();
  level._id_F21A = 1;
  level._id_2663 = 1;
  level._id_484A = var_0;

  if(level._id_484A._id_A8E1 == "_a") {
    level._id_19B0 = 1;
  } else {
    level._id_29EA = 1;
  }

  level._id_484A._id_2663 = 1;
  level._id_F1DE = var_0._id_10430[0];
  _id_5011(var_1, var_0._id_A8E1);
  var_0._id_2635 = 0;
  var_0 _id_07D6::_id_15DF("none");
  var_0 _id_07D6::_id_D8E0("none");

  if(scripts\mp\utility\game::_id_82D1()) {
    var_0 _id_07D6::_id_D639(scripts\mp\utility\game::_id_6BE2(var_1.team)[0]);
  }

  var_0 _id_D872();
  var_0 _id_2683(var_0);
  var_0 thread _id_265E(var_1, "explode", var_2);
}

_id_265E(var_0, var_1, var_2) {
  level._id_267E = level._id_267E - 1;

  if(self._id_A8E1 == "_a") {
    level._id_19B0 = 0;
  } else {
    level._id_29EA = 0;
  }

  _id_C6E3();
  scripts\mp\gametypes\obj_bombzone::_id_D4A0();

  if(level.gameended) {
    return;
  }
  if(var_1 == "explode") {
    self._id_265C = 1;

    if(!scripts\mp\utility\game::_id_82D1() && level._id_265C < 2 && level._id_436D > 0) {
      level._id_5856 = level._id_265C * level._id_436D;
      var_3 = scripts\mp\gamelogic::_id_6DE8();
      setgameendtime(gettime() + int(var_3));
    }

    wait 2;

    if(scripts\mp\utility\game::_id_82D1() || level._id_265C > 1) {
      if(istrue(level._id_A737)) {
        return;
      }
      _id_436A(var_2, game["end_reason"]["target_destroyed"]);
    } else if(level._id_436D > 0)
      level thread scripts\mp\hud_message::_id_A6B6("callout_time_added", "callout_time_added", var_0.team);
  } else {
    var_0 notify("bomb_defused" + self._id_A8E1);
    self notify("defused");
    _id_C606(var_0);
  }
}

_id_5011(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 20), var_0.origin - (0, 0, 2000), var_0, scripts\engine\trace::_id_3EF6(1));
  var_3 = randomfloat(360);
  var_4 = (cos(var_3), sin(var_3), 0);
  var_4 = vectornormalize(var_4 - var_2["normal"] * vectordot(var_4, var_2["normal"]));
  var_5 = vectortoangles(var_4);
  level._id_436B[var_1] = spawn("script_model", var_2["position"]);
  level._id_436B[var_1].angles = var_5;
  level._id_436B[var_1] setModel("prop_suitcase_bomb");
}

_id_C6E3() {
  if(scripts\mp\utility\game::_id_82D1()) {
    if(level._id_265C == 1) {
      return;
    }
  } else if(level._id_265C > 1) {
    return;
  }
  if(level._id_267E <= 0) {
    scripts\mp\gamelogic::resumetimer();
    level._id_F23C = gettime() - level._id_F23D;
    level._id_F21A = 0;
  }
}

_id_2683(var_0) {
  level endon("game_ended");
  level endon("bomb_defused" + var_0._id_A8E1);

  if(scripts\mp\utility\game::_id_82D1()) {
    var_0._id_10971 = level._id_2682;
  } else {
    var_0._id_10971 = level._id_2682;
  }

  level thread _id_FBE3(var_0);

  while(var_0._id_10971 >= 0) {
    var_0._id_10971--;

    if(var_0._id_10971 >= 0) {
      wait 1;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_FBE3(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("bomb_defused" + var_0._id_A8E1);
  level endon("bomb_exploded" + var_0._id_A8E1);
  var_1 = var_0._id_10971 * 1000 + gettime();
  setDvar(_func_0483("#x3b04d5f30e847d208", var_0._id_A8E1), var_1);
  level waittill("host_migration_begin");
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 > 0) {
    setDvar(_func_0483("#x3b04d5f30e847d208", var_0._id_A8E1), var_1 + var_2);
  }
}

_id_2635(var_0) {
  level._id_F1DE scripts\mp\gamelogic::_id_E943();
  var_0._id_2635 = 1;
  level notify("bomb_defused" + var_0._id_A8E1);
}

_id_D897() {
  scripts\mp\gamelogic::_id_D8E5("waypoint_target_neutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0);
}