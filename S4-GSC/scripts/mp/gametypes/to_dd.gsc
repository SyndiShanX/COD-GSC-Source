/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_dd.gsc
*************************************************/

main() {
  _id_997B();
  _id_07DC::init();
  _id_07DC::_id_D854();

  if(_func_0127()) {
    scripts\mp\utility\game::_id_D4E0();
  }

  _id_997C();
  level._id_E6A1 = 0;
  level._id_ABAD = ::_id_ABAD;
}

_id_997A() {
  _id_997B();
  _id_997C();
  level._id_E6A1 = 1;
  _id_ABAD(1);
}

_id_997B() {
  level._id_ED22 = "to_dd";
  level._id_41D2 = "to_dd";
  setomnvar("ui_tac_ops_submode", level._id_41D2);
}

_id_997C() {
  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA("to_dd", 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1("to_dd", 3);
    scripts\mp\utility\game::_id_C2AD("to_dd", 0);
    scripts\mp\utility\game::_id_C2A9("to_dd", 1);
    scripts\mp\utility\game::_id_C2D0("to_dd", 1);
    scripts\mp\utility\game::_id_C27E("to_dd", 0);
    scripts\mp\utility\game::_id_C25D("to_dd", 0);
    scripts\mp\utility\game::_id_C250("to_dd", 0);
    scripts\mp\utility\game::_id_D635(2);
    level._id_9BEB = 0;
    level._id_9BF0 = 0;
  }

  _id_FC7D();
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_AB7F = ::_id_AB7F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AAA3 = ::_id_AAA3;
  level._id_ABC0 = ::_id_ABC0;
  level._id_60D0 = scripts\mp\utility\game::_id_899A;

  if(level._id_9BEB || level._id_9BF0) {
    level._id_A00B = _id_07C3::_id_60D1;
  }

  level._id_4369 = 1;
  level._id_267E = 0;
  level._id_436B = [];
  level._id_19B0 = 0;
  level._id_29EA = 0;
  level._id_15BB = 0;
  level._id_7C20 = 0;
  level._id_265D = 0;
  scripts\mp\gametypes\obj_bombzone::_id_D4A0();
  game["dialog"]["gametype"] = "manhunt";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x39c9a489fe1103246")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "";
  game["dialog"]["defense_obj"] = "";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  scripts\mp\utility\dvars::_id_D633("timelimit", 6);
  setdynamicdvar("#x3b801865e0e480f4c", 20);
  setdynamicdvar("#x3e3191c88d2d23718", 20);
  setdynamicdvar("#x3efddbf611a74bfd7", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("#x3233d7816f190aec6", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("#x3a79d19d0ce158d69", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("#x3e5917c13845c1808", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("#x355d670551051c749", getmatchrulesdata("demData", "extraTime"));
  setdynamicdvar("#x37f0649dd12a3e028", getmatchrulesdata("demData", "overtimeLimit"));
  setdynamicdvar("#x355947c1cc987cc2e", 0);
  scripts\mp\utility\game::_id_C25D("to_dd", 0);
  setdynamicdvar("#x39c9a489fe1103246", 0);
  setdynamicdvar("#x3a79d19d0ce158d69", 5);
  setdynamicdvar("#x355d670551051c749", 1);
}

_id_AB7F() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

_id_ABAD(var_0) {
  scripts\cp_mp\utility\game_utility::_id_6B2D();
  _id_D5AD();

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level._id_FED4 = 1;
  level._id_F2AB = 1;
  setclientnamemode("manual_change");

  if(scripts\mp\utility\game::_id_82D1()) {
    game["dialog"]["defense_obj"] = "obj_destroy";
  }

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

  thread _id_1080D();

  if(!istrue(var_0)) {
    scripts\mp\gametypes\tac_ops::_id_3AE4();
    _id_0EFE();
  }

  var_1 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");
  var_2[0] = "dd";
  var_2[1] = "dd_bombzone";
  var_2[2] = "blocker";
  var_2[3] = "grind";
  var_2[4] = "dom";
  var_2[5] = "conf";
  _id_07D6::main(var_2);
  level._id_ED23 = 1;
  var_3 = randomfloat(1.0);

  if(var_3 < 0.5) {
    level._id_7C22 = "_a";
  } else {
    level._id_7C22 = "_b";
  }

  var_4 = "veh_jackal_mp";
  var_5 = "veh8_mil_air_ahotel64_ks";
  level thread _id_106B5();
  _id_8150();
  thread _id_3F9D();
}

_id_3F9D() {
  var_0 = getent("to_dd_bridge_flag", "targetname");

  if(!isDefined(level._id_A8E8)) {
    level._id_A8E8 = [];
  }

  level._id_2BD0 = level._id_A8E8.size;
  level._id_A8E8[level._id_2BD0] = var_0;
  var_1 = scripts\mp\gametypes\obj_dom::_id_D896(level._id_A8E8[level._id_2BD0]);
  scripts\engine\utility::delaythread(3.0, ::_id_46DA);
  var_1._id_ABCB = ::_id_2BCF;
  level._id_A8E8[level._id_2BD0] = var_1;
  level._id_5C3B = 10.0;
  level._id_5C41 = 0;
  waitframe();
  var_1 _id_07D6::_id_D639("neutral");
  var_1 _id_07D6::_id_D8E0("any");
  var_1 _id_07D6::_id_15DF("enemy");
  var_1 _id_07D6::_id_316A(1);
  var_1 _id_07D6::_id_D61B(level._id_7C4B, level._id_7C5F);
}

_id_46DA() {
  level._id_A8E8[level._id_2BD0] _id_07D6::_id_D639("axis");
  level._id_A8E8[level._id_2BD0] _id_07D6::_id_15DF("enemy");
  level._id_A8E8[level._id_2BD0] scripts\mp\gametypes\obj_dom::_id_FC64("axis", 0);
  level._id_A8E8[level._id_2BD0] _id_07D6::_id_D61B(level._id_7C4B, level._id_7C5F);
}

_id_2BCF(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);

  if(var_0.team == "allies") {
    level._id_A8E8[level._id_2BD0]._id_ABCB = scripts\mp\gametypes\obj_dom::_id_4D4F;
    level._id_A8E8[level._id_2BD0] _id_07D6::_id_D5C5(undefined);
    level._id_A8E8[level._id_2BD0] _id_07D6::_id_D8E0("any");
    level._id_A8E8[level._id_2BD0] _id_07D6::_id_15DF("enemy");
    _id_E682();
  }
}

_id_E682() {
  level._id_AB3F = ::_id_AB3F;
  iprintlnbold("Bridge Captured");
  level._id_A8E8[level._id_2BD0] _id_07D6::_id_D5FD(0);
  level._id_A8E8[level._id_2BD0] _id_07D6::_id_4AD1();
  level._id_A8E8[level._id_2BD0]._id_03A9 setscriptablepartstate("flag", "off");
  level._id_F2AB = 0;
  _id_081C::_id_D45F("to_dd", "allies");
  thread _id_267A();
}

_id_106B5() {
  wait 10;
  _id_0A75::_id_BEC1("dx_mpb_us1_phase1_enemya", "allies");
  _id_0A75::_id_BEC1("dx_mpb_aq1_phase1_enemyb", "axis");
  scripts\mp\gametypes\tac_ops::_id_ED14(30);
  _id_0A75::_id_BEC1("dx_mpb_us1_phase1_lesstimea", "allies");
  _id_0A75::_id_BEC1("dx_mpb_aqcm_phase2_lesstime", "axis");
}

_id_8294() {
  var_0 = level._id_ED1E;
  var_0._id_F2AC = [];
  var_0._id_F2AC["allies_start"] = _id_0817::_id_6D4E("mp_todd_spawn_allies_start");
  var_0._id_F2AC["axis_start"] = _id_0817::_id_6D4E("mp_todd_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_todd_spawn_allies");
  var_0._id_F2AC["allies"] = _id_0817::_id_6D4E("mp_todd_spawn_allies");
  _id_0817::_id_1136("axis", "mp_todd_spawn_axis");
  var_0._id_F2AC["axis"] = _id_0817::_id_6D4E("mp_todd_spawn_axis");
  _id_0817::_id_1136("allies_bridge", "mp_toddbridge_spawn_allies");
  var_0._id_F2AC["allies_bridge"] = _id_0817::_id_6D4E("mp_toddbridge_spawn_allies");
  _id_0817::_id_1136("axis_bridge", "mp_toddbridge_spawn_axis");
  var_0._id_F2AC["axis_bridge"] = _id_0817::_id_6D4E("mp_toddbridge_spawn_axis");
}

_id_6D4F(var_0, var_1) {
  var_2 = _func_00C4(var_0.origin, var_1, 16000);

  if(var_2 < 0) {
    var_2 = distance(var_0.origin, var_1);
  }

  return var_2;
}

_id_6D4A() {
  var_0 = level._id_ED1E;
  var_1 = self.pers["team"];

  if(level._id_FED4 && !isDefined(self._id_ED18)) {
    var_2 = _id_0817::_id_6D4D(var_0._id_F2AC[var_1 + "_start"]);
  } else if(istrue(level._id_F2AB)) {
    var_3 = var_1 + "_bridge";
    var_4 = var_0._id_F2AC[var_3];
    var_4 = _id_081C::_id_5A54(var_4);
    var_2 = undefined;
  } else {
    var_4 = var_0._id_F2AC[var_1];
    var_4 = _id_081C::_id_5A54(var_4);
    var_2 = undefined;
  }

  return var_2;
}

_id_0EFE() {
  _id_0817::_id_D461("TDM");
  thread _id_FEDA();
  level._id_6D4A = ::_id_6D4A;
}

_id_FEDA() {
  _id_07D1::_id_60C2("prematch_done");
  _id_081C::_id_D45F("to_dd", "axis");
  _id_081C::_id_D45F("dirttown_allies_bridge", "allies");
}

_id_10809() {
  level endon("dd_phase_ended");
  level endon("game_end");
  scripts\mp\gametypes\tac_ops::_id_ED14(45);
  scripts\mp\gametypes\tac_ops::_id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_DD_ESCAPE_1", &"MISC_MESSAGES_MP/TO_AXIS_DD_ESCAPE_1");

  if(level._id_7C22 == "_a") {
    level._id_5839 = scripts\engine\utility::getstructarray("hostage_extraction_a", "targetname")[0].origin;
  } else {
    level._id_5839 = scripts\engine\utility::getstructarray("hostage_extraction_b", "targetname")[0].origin;
  }

  level._id_436C = spawn("trigger_radius", level._id_5839, 0, 90, 128);
  level._id_436C.angles = (0, 0, 0);
  level._id_21CD = scripts\mp\utility\dvars::_id_509C("bankCaptureTime", 0, 0, 10);
  level._id_436C._id_FE90 = scripts\mp\gametypes\obj_grindzone::_id_D896(0, "allies", level._id_436C);
  level._id_436C.team = "allies";
  level._id_436C._id_ADAE = "allies";
  level._id_436C._id_1041A = "any";
  level._id_436C._id_FE90 scripts\mp\gametypes\to_hstg::_id_FC62();
  level._id_436C._id_FE90 _id_07D6::_id_D8E0("none");
  level._id_436C._id_A97E = (0, 0, 16);
  scripts\mp\gametypes\to_hstg::_id_99FA(level._id_436C);
  level._id_436C._id_96CF = level._id_5839;

  if(scripts\mp\utility\teams::_id_6DCA("axis", "teamCount")) {
    level._id_F348 = scripts\engine\utility::_id_1BD6(scripts\mp\utility\teams::_id_6DCA("axis", "players"), ::_id_3AF6);
    var_0 = level._id_F348[0] scripts\mp\gametypes\to_hstg::_id_E2E3(level._id_436C, 30);
    level._id_436C thread scripts\mp\gametypes\to_hstg::_id_5848();
    var_0 thread _id_107EB();
  }
}

_id_3AF6(var_0, var_1) {
  return var_0._id_038F >= var_1._id_038F;
}

_id_107EB() {
  level endon("dd_phase_ended");
  scripts\mp\gametypes\tac_ops::_id_ED14(15);
  scripts\mp\gametypes\tac_ops::_id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_DD_ESCAPE_2", &"MISC_MESSAGES_MP/TO_AXIS_DD_ESCAPE_2");

  foreach(var_1 in level._id_A8E8) {
    _id_C493(var_1._id_A8E1);
  }

  foreach(var_1 in level._id_A8E8) {
    if(isDefined(var_1._id_AAB5)) {
      var_1[[var_1._id_AAB5]]();
    }
  }

  level._id_F2AD._id_852E = 0;
  level._id_F2AD thread _id_7C26();
  scripts\mp\gametypes\tac_ops::_id_ED14(1);

  if(isDefined(level._id_F2AD)) {
    _id_0A74::_id_7C1A(level._id_F2AD);
  }

  level._id_436C scripts\mp\gametypes\to_hstg::_id_3893();
  self notify("extract_hostages");
}

_id_7C26() {
  level endon("dd_phase_ended");
  level endon("game_end");
  self endon("death");
  self _meth_8058(level._id_5839, 20, "critical");
  var_0 = scripts\mp\bots\bots_util::_id_291C();
}

_id_1080D() {
  level endon("game_end");
  _id_07D1::_id_60C2("prematch_done");
  level._id_FED4 = 0;
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
  var_0 = 0;

  if(self.team == "allies") {
    var_0 = 1;
  } else if(self.team == "axis") {
    var_0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var_0);

  if(!isagent(self)) {
    scripts\mp\playerlogic::_id_7DE8(self.team);
  }

  _id_0A76::_id_8E2C();
}

_id_436A(var_0, var_1) {
  thread scripts\mp\gamelogic::_id_52F7(var_0, var_1);
}

_id_AAA3(var_0) {
  if(level._id_265C > 0 || level._id_2635) {
    return;
  }
  if(var_0 == "all") {
    if(level._id_2663) {
      _id_436A(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    } else {
      _id_436A(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    }
  } else if(var_0 == game["attackers"]) {
    if(level._id_2663) {
      return;
    }
    level thread _id_436A(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread _id_436A(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4);
  var_5 = var_0.team;

  if(var_0._id_8986) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  } else if(var_0._id_87F7) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  }

  scripts\mp\gametypes\obj_bombzone::_id_2685(var_1, var_0);

  if(!isagent(var_0)) {
    if(!isDefined(var_0._id_EC33)) {
      var_0 scripts\mp\playerlogic::_id_4554(var_0.team);
    }
  }
}

_id_ABC0() {
  foreach(var_1 in level._id_A8E8) {
    if(isDefined(var_1._id_AAB5)) {
      var_1[[var_1._id_AAB5]]();
    }
  }

  if(isDefined(level._id_AB4C)) {
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    [[level._id_AB4C]]("axis");
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_B1DA = scripts\mp\utility\dvars::_id_509A("planttime", 5, 0, 20);
  level._id_4644 = scripts\mp\utility\dvars::_id_509A("defusetime", 5, 0, 20);
  level._id_2682 = scripts\mp\utility\dvars::_id_509C("bombtimer", 30, 1, 300);
  level._id_436D = scripts\mp\utility\dvars::_id_509A("extraTime", 2, 0, 5);
  level._id_AD6F = scripts\mp\utility\dvars::_id_509A("overtimeLimit", 1, 0, 5);
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

_id_8150() {
  level._id_2663 = 0;
  level._id_2635 = 0;
  level._id_265C = 0;
  level._id_A2F7 = 1;
  level._id_A8E8 = [];
}

_id_267A() {
  var_0 = getEntArray("dd_bombzone", "targetname");

  if(var_0.size == 0) {
    return;
  }
  wait 0.5;
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = scripts\mp\gametypes\obj_bombzone::_id_D896(var_3);
    var_4._id_AA79 = ::_id_AA79;
    var_4._id_AAC2 = ::_id_AAC2;
    var_4._id_ABCB = ::_id_ABD2;
    var_4._id_AAB5 = ::_id_268D;
    level._id_A8E8[var_4._id_A8E1] = var_4;
  }
}

_id_AA79(var_0) {
  scripts\mp\gametypes\obj_bombzone::_id_268A(var_0);
}

_id_AAC2(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::_id_268F(var_0, var_1, var_2);
}

_id_ABD2(var_0) {
  scripts\mp\gametypes\obj_bombzone::_id_2691(var_0);
}

_id_C606() {
  if(scripts\mp\utility\game::_id_82D1()) {
    _id_07D6::_id_D639("neutral");
    _id_07D6::_id_15DF("any");
    var_0 = "waypoint_target_b";
    var_1 = "waypoint_target_b";
  } else {
    _id_07D6::_id_15DF("enemy");
    var_0 = "waypoint_defend" + self.label;
    var_1 = "waypoint_target" + self.label;
  }

  self._id_7C8C = "bomb_zone";
  _id_07D6::_id_D8D2(level._id_B1DA);
  _id_07D6::_id_D8D1(&"MP/PLANTING_EXPLOSIVE");
  _id_07D6::_id_D8D0(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  _id_07D6::_id_D61B(var_0, var_1);
  _id_07D6::_id_D8E0("any");
  self.useweapon = makeweapon("briefcase_bomb_mp");
  self._id_265C = undefined;
}

_id_265E(var_0, var_1, var_2) {
  level._id_267E = level._id_267E - 1;

  if(self.label == "_a") {
    level._id_19B0 = 0;
  } else {
    level._id_29EA = 0;
  }

  scripts\mp\gametypes\obj_bombzone::_id_D4A0();

  if(level.gameended) {
    return;
  }
  if(var_1 == "explode") {
    self._id_265C = 1;
    _id_0A8D::_id_E775("enemy_ident", game["defenders"], 1);
    _id_0A8D::_id_E775("target_ident", game["attackers"], 1);

    foreach(var_4 in level._id_A8E8) {
      _id_C493(var_4._id_A8E1);

      if(isDefined(var_4._id_AAB5)) {
        var_4[[var_4._id_AAB5]]();
      }
    }

    wait 2;
    _id_C6E3();

    if(level._id_436D > 0) {
      level thread scripts\mp\hud_util::_id_EF8D("callout_time_added", var_0);
    }

    waitframe();
    level._id_265D++;

    if(level._id_267E == 1) {
      level notify("bombs_canceled");
    }

    _id_C6E3();
    level._id_267E = level._id_267E - 1;
    setomnvar("ui_bomb_planted_a", 0);
    setomnvar("ui_bomb_planted_b", 0);
    scripts\mp\gametypes\tac_ops::_id_57FA(30000);

    if(isDefined(level._id_AB4C) && level._id_265D == 1) {
      [[level._id_AB4C]]("allies");
      return;
    }
  } else {
    _id_C6E3();
    var_0 notify("bomb_defused" + self.label);
    self notify("defused");
    _id_C606();
  }
}

_id_C493(var_0) {
  var_1 = getent("dd_bombzone_clip" + var_0, "targetname");
  var_1 delete();
}

_id_C6E3() {
  scripts\mp\gametypes\tac_ops::_id_C731();

  if(level._id_267E <= 0) {
    level._id_F21A = 0;
  }
}

_id_268D() {
  _id_07D6::_id_4AD1();
  _id_07D6::_id_15DF("none");
}

_id_D5AD() {
  level._id_7C8A = "waypoint_hardpoint_target";
  level._id_7C74 = "koth_neutral";
  level._id_7C42 = "koth_enemy";
  level._id_7C4B = "koth_friendly";
  level._id_7C48 = "waypoint_hardpoint_contested";
  level._id_7C87 = "waypoint_taking_chevron";
  level._id_7C6F = "waypoint_hardpoint_losing";
  level._id_7C40 = "waypoint_target";
  level._id_7C41 = "waypoint_defend";
  level._id_7C55 = "waypoint_escort";
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