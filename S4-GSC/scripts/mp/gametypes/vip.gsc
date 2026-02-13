/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\vip.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "sd";
  var_0[2] = "bombzone";
  var_0[3] = "dom";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 3);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  level.teambased = 1;
  level._id_A8D4 = 1;
  _id_FC7D();
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB3F = ::_id_AB3F;
  level._id_AB70 = ::_id_AB70;
  level._id_AAA3 = ::_id_AAA3;
  game["dialog"]["gametype"] = "gametype_defender";
  game["dialog"]["offense_obj"] = "hint_killall";
  game["dialog"]["defense_obj"] = "hint_killall";
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3f980a54acf5d345", 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("#x3482a7930fb7f6b6b", 0);
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
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

  scripts\mp\utility\game::_id_D61C("allies", &"OBJECTIVES/VIP");
  scripts\mp\utility\game::_id_D61C("axis", &"OBJECTIVES/VIP");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/VIP");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/VIP");
  } else {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/VIP_SCORE");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/VIP_SCORE");
  }

  scripts\mp\utility\game::_id_D615("allies", &"OBJECTIVES/VIP_HINT");
  scripts\mp\utility\game::_id_D615("axis", &"OBJECTIVES/VIP_HINT");
  _id_8294();
  level._id_7A9D = [];
  level._id_7A8B = [];
  _id_D5AD();
  thread _id_10976();
  level thread _id_106B3();
}

_id_10976() {
  level endon("game_end");
  level endon("waitSkipped");
  level thread _id_583C();
  level thread _id_E3A5();
  level thread _id_4064();
  _id_07D1::_id_60C2("prematch_done");
  _id_07D1::_id_60C2("graceperiod_done");
  self notify("graceComplete");
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_sd_spawn_attacker");
  _id_0817::_id_113A("mp_sd_spawn_defender");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = "mp_sd_spawn_defender";

  if(self.pers["team"] == game["attackers"]) {
    var_0 = "mp_sd_spawn_attacker";
  }

  var_1 = _id_0817::_id_6D4E(var_0);
  var_2 = _id_0817::_id_6D4D(var_1);
  return var_2;
}

_id_D5AD() {
  level._id_7C80 = "waypoint_recover_vip";
  level._id_7C55 = "waypoint_escort_vip";
  level._id_7C58 = "waypoint_extract_vip";
  level._id_7C89 = "waypoint_taking_extract";
  level._id_7C71 = "waypoint_losing_extract";
  level._id_7C4A = "waypoint_contesting_extract";
  level._id_7C4D = "waypoint_defend_extract";
  level._id_7C44 = "waypoint_capture_extract";
  level._id_7C85 = "waypoint_stopping_extract";
}

_id_ABA4() {
  self._id_8AFD = 0;
  self._id_FF12 = undefined;
  level notify("spawned_player");
  self setclientomnvar("ui_match_status_hint_text", -1);
  self _meth_8390(self.team);
  thread _id_FCC2();

  if(isDefined(level._id_103EE)) {
    level._id_103EE.trigger _meth_80E0(self);
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\rank::getscoreinfovalue("kill");
  var_7 = var_0.team;

  if(isDefined(var_0._id_8AFD) && var_0._id_8AFD) {
    level thread _id_103F2(game["attackers"], &"MP_ELIMINATED_VIP");
    var_1._id_5AA1 = 1;
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread _id_34DE();
}

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

_id_34DE() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::_id_6DCA(game["attackers"], "aliveCount")) {
    level._id_E3E2[game["attackers"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::_id_6DCA(game["defenders"], "aliveCount")) {
    level._id_E3E2[game["defenders"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_081A::_id_FD35();
  }
}

_id_AAA3(var_0) {
  if(var_0 == game["attackers"]) {
    level thread _id_103F2(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(var_0 == game["defenders"]) {
    level thread _id_103F2(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
  }
}

_id_103F2(var_0, var_1) {
  thread scripts\mp\gamelogic::_id_52F7(var_0, var_1);
}

_id_583C() {
  var_0 = getEntArray("bombzone", "targetname");
  var_0 = scripts\mp\gametypes\sd::_id_C47C(var_0);
  level._id_A8E8 = [];
  var_1 = game["attackers"];

  foreach(var_3 in var_0) {
    var_4[0] = spawn("script_model", var_3.origin);
    var_4[0].angles = (0, 270, 0);
    var_4[0].team = var_1;
    var_4[0]._id_1041A = "any";
    var_4[0]._id_ADAE = var_1;
    var_4[0].type = "";
    var_5 = spawn("trigger_radius", var_3.origin, 0, 120, 80);
    var_5.team = var_1;
    var_6 = var_5.origin;
    var_7 = scripts\engine\trace::_id_3EE5(0, 1, 1, 0, 0, 1, 1);
    var_8 = [];
    var_9 = scripts\engine\trace::ray_trace(var_4[0].origin + (0, 0, 20), var_4[0].origin - (0, 0, 4000), var_8, var_7, 0);

    if(isPlayer(var_9["entity"])) {
      var_9["entity"] = undefined;
    }

    if(isDefined(var_9)) {
      var_10 = randomfloat(360);
      var_11 = var_9["position"];

      if(isDefined(self._id_1042D)) {
        var_11 = var_11 + self._id_1042D;
      }

      var_12 = (cos(var_10), sin(var_10), 0);
      var_12 = vectornormalize(var_12 - var_9["normal"] * vectordot(var_12, var_9["normal"]));
      var_13 = vectortoangles(var_12);
      var_4[0].origin = var_11;
      var_4[0] setModel("cop_marker_scriptable");
      var_4[0] setscriptablepartstate("marker", "red");
      var_4[0] playLoopSound("mp_flare_burn_lp");
    }

    level._id_5C3B = 0.05;

    if(isDefined(var_5._id_A8E1)) {
      var_14 = var_5._id_A8E1;
    } else {
      var_14 = var_5._id_CD99;
    }

    if(isDefined(var_5._id_7C73)) {
      var_15 = var_5._id_7C73;
    } else {
      var_15 = var_5._id_CD99;
    }

    var_5 = _id_07D6::_id_406E(var_1, var_5, var_4, (0, 0, 100));
    var_5.team = var_1;
    var_5._id_ADAE = game["defenders"];
    var_5._id_ADAF = 1;
    var_5.origin = var_5._id_4140;
    var_5 _id_07D6::_id_15DF("enemy");
    var_5 _id_07D6::_id_316A(1);
    var_5 _id_07D6::_id_D8D2(level._id_5C3B);
    var_5._id_ABCB = ::_id_584C;
    var_5._id_AA79 = ::_id_584D;
    var_5._id_AAC2 = ::_id_584E;
    var_5._id_AA8D = ::_id_584A;
    var_5._id_ABC7 = ::_id_584B;
    var_5 _id_07D6::_id_B0E7();
    var_5._id_7C8C = "domFlag";
    var_5._id_5832 = 0;
    var_5 _id_07D6::_id_D4B2("normal");
    var_5._id_A8E1 = var_14;
    var_5._id_7C73 = var_15;
    var_5 _id_07D6::_id_D8E0("any");
    var_5._id_E86E = ::_id_5850;
    var_5._id_A6C4 = 1;
    var_5._id_7C8C = "domFlag";
    var_5._id_37F3 = level._id_5C3B * 1000;
    var_5 _id_07D6::_id_D61B(level._id_7C4D, level._id_7C44);
    waitframe();
  }

  var_17 = getEntArray();

  foreach(var_19 in var_17) {
    var_20 = var_19._id_CD69;

    if(isDefined(var_20)) {
      if(var_20 == "bombzone") {
        var_19 delete();
      }
    }
  }
}

_id_584D(var_0) {
  var_0._id_87A3 = 1;
  level._id_31B5 = 0;
  var_1 = _id_07D6::_id_6C02();
  self._id_A436 = istrue(level._id_5C41) && var_1 != "neutral";

  if(!istrue(self._id_A435)) {
    self._id_497A = 0;
  }

  if(istrue(level._id_322C)) {
    thread _id_07D6::_id_FE93(var_0.team);
  }

  self._id_BC52 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
  scripts\mp\gametypes\obj_dom::_id_FC63(var_0.team);

  if(var_1 == game["attackers"]) {
    _id_07D6::_id_D61B(level._id_7C85, level._id_7C71);
  } else {
    _id_07D6::_id_D61B(level._id_7C71, level._id_7C89);
  }
}

_id_584E(var_0, var_1, var_2) {
  level._id_31B5 = 1;

  if(var_2) {
    _id_07F9::_id_A8C4(self._id_A908, 0);
  }

  if(isPlayer(var_1)) {
    var_1._id_87A3 = 0;
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90E = undefined;
  }

  if(!var_2) {
    self._id_A435 = 0;
    var_3 = _id_07D6::_id_6C02();

    if(var_3 == game["attackers"]) {
      if(self._id_5832) {
        _id_07D6::_id_D61B("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");
      } else {
        _id_07D6::_id_D61B("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
      }
    } else
      _id_07D6::_id_D61B(level._id_7C4D, level._id_7C44);
  }
}

_id_584C(var_0) {
  level._id_31B5 = 1;
  var_1 = var_0.team;
  var_2 = _id_07D6::_id_6C02();
  self._id_3235 = gettime();
  self._id_A435 = 0;
  _id_584F(var_1, var_0);

  if(!self._id_A435) {
    if(isDefined(level._id_AB42)) {
      [[level._id_AB42]]("dompoint", self._id_A8E1, var_0, var_1, var_2, self);
    }
  }

  if(var_1 == game["attackers"]) {
    playFXOnTag(level._effect["vfx_smk_signal"], self._id_10430[0], "tag_origin");
    _id_B35D(var_1, "extract_littlebird_start_a_friendly", 20);
    var_0 _id_1040A(self);
  } else {
    stopFXOnTag(level._effect["vfx_smk_signal"], self._id_10430[0], "tag_origin");
    self._id_5832 = 0;
  }
}

_id_584A() {
  _id_07D6::_id_D61B(level._id_7C4A);
  _id_07F9::_id_A8B6(self._id_A908, undefined);
}

_id_584B(var_0) {
  var_1 = _id_07D6::_id_6C02();

  if(self._id_ADAE == game["attackers"]) {
    if(self._id_5832) {
      _id_07D6::_id_D61B("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");
    } else {
      _id_07D6::_id_D61B("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
    }
  } else
    _id_07D6::_id_D61B(level._id_7C4D, level._id_7C44);
}

_id_584F(var_0, var_1) {
  _id_07D6::_id_D639(var_0);

  if(self._id_ADAE == game["attackers"]) {
    _id_07D6::_id_D8D2(5);
    _id_07D6::_id_D61B("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
  } else {
    _id_07D6::_id_D8D2(0.05);
    _id_07D6::_id_D61B(level._id_7C4D, level._id_7C44);

    foreach(var_3 in self._id_36B0) {
      var_3 notify("bugOut");
      var_3 notify("esc_littlebird_arrive");
      var_3 scripts\engine\utility::array_remove(self._id_36B0, var_3);
      self._id_36B0 = [];
      var_3 thread scripts\mp\gametypes\br_extract_chopper::_id_9592();
    }

    _id_B35D(game["attackers"], "extract_littlebird_leaving_a_friendly", 10);
  }

  self notify("capture", var_1);
  self notify("assault", var_1);
  self._id_A435 = 0;

  if(self._id_F396[var_0].size == 0) {
    self._id_F396 = self._id_AA3C;
  }

  thread _id_6F9A(self._id_F396[var_0], var_1);
  _id_07A9::_id_976A(self._id_176A, self._id_1769, self._id_10430[0].origin, -1, "captured_" + var_0);
}

_id_5850(var_0) {
  var_0 thread _id_07B1::_id_6FB9("mode_x_defend");
}

_id_694D() {
  var_0 = "normal";

  if(level._id_3236 == 2) {
    var_0 = "neutralize";
  } else if(level._id_3236 == 3) {
    var_0 = "persistent";
  }

  return var_0;
}

_id_6F9A(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_1;

  if(isDefined(var_2.owner)) {
    var_2 = var_2.owner;
  }

  level._id_8FA1 = gettime();

  if(isPlayer(var_2)) {
    level thread scripts\mp\hud_util::_id_EF8D("callout_securedposition", var_2);
    var_3 = spawnStruct();
    var_3.player = var_2;
    var_3._id_56B9 = "capture";
    var_3._id_033E = var_2.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_3);
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
    var_6 scripts\mp\utility\stats::_id_7DAE("captures", 1);
    var_6 scripts\mp\persistence::_id_E770("round", "captures", var_6.pers["captures"]);
    var_6 scripts\mp\utility\stats::_id_D550(var_6.pers["captures"]);
    var_6 thread _id_07B1::_id_6FB9("mode_dom_secure");
    wait 0.05;
  }
}

_id_1040A(var_0) {
  if(!isDefined(var_0._id_36B0)) {
    var_0._id_36B0 = [];
  }

  var_1 = anglesToForward(self getplayerangles(1));
  var_2 = getgroundposition(self getEye() + (0, 0, 60) + var_1 * 80, 60) + (0, 0, 8);
  var_3 = scripts\mp\gametypes\br_extract_chopper::_id_E2E3(var_0, var_0.origin);
  var_0._id_36B0[var_0._id_36B0.size] = var_3;
  self iprintlnbold("Extraction copter en route!");
  var_3._id_5849 = var_0;
  var_3._id_5844 = self.team;
  var_0._id_4140 = var_0.origin;
  var_0._id_A97E = (0, 0, 30);
  var_0 thread _id_5846(var_3);
}

_id_5846(var_0) {
  level endon("game_ended");
  var_0 endon("bugOut");
  var_0 waittill("esc_littlebird_arrive");
  self._id_5832 = 1;
  _id_B35D(var_0._id_5844, "extract_littlebird_close_a_friendly", 10);

  if(self._id_E57B) {
    _id_07D6::_id_D61B(level._id_7C4A);
  } else {
    _id_07D6::_id_D61B("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");
  }

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(!istrue(self._id_E57B)) {
      if(istrue(var_1._id_8736) && self._id_A79A[game["defenders"]] == 0) {
        level thread _id_103F2(var_1.team, game["end_reason"]["objective_completed"]);
        break;
      } else if(var_1.team == self.team && isDefined(var_1._id_32EC)) {
        level thread _id_103F2(var_1.team, game["end_reason"]["objective_completed"]);
        break;
      }
    }
  }
}

_id_4064() {
  waitframe();
  _func_004D("vip");

  foreach(var_1 in level._id_EF89) {
    _func_004D(var_1);
    _func_01DB(var_1, "vip");
  }
}

_id_E3A5() {
  level endon("game_ended");
  wait 2;
  var_0 = getent("sd_bomb_pickup_trig", "targetname");
  var_1 = undefined;
  var_2 = undefined;
  level._id_15BB = 1;

  while(!isDefined(var_1)) {
    var_1 = _id_0015::_id_3B84("player", game["attackers"]);

    if(isDefined(var_1)) {
      var_2 = var_0.origin;
      var_0 delete();
      var_1 thread[[var_1 _id_09EF::_id_1215("spawn")]](var_2, (0, 0, 0));
      var_3 = var_1 _meth_815E();
      var_1 setorigin(var_3.origin);
      var_1.team = game["attackers"];
      var_1 scripts\mp\bots\bots_util::_id_28C4("recruit");
      var_1._id_ACE5 = scripts\mp\utility\outline::_id_ACD2(var_1, var_1.team, "outline_nodepth_green", "lowest");
      var_1._id_A546 = 1;
      var_1._id_880D = 0;
      var_1._id_8736 = 1;
      var_4 = spawn("script_model", var_1.origin + (0, 0, 30));
      var_4.team = game["attackers"];
      var_4._id_4823 = var_1.origin;
      var_4 linkto(var_1);
      var_4 scripts\mp\utility\usability::_id_9A0F(var_4.team);
      var_4 sethintstring(&"MP/HOLD_TO_ESCORT_VIP");
      var_4 _meth_83A1(-300);
      var_1.trigger = var_4;
      var_1._id_ADAE = var_4.team;
      var_1._id_83B6 = "friendly";
      var_1._id_C589 = 1;
      var_1._id_56E2 = 0;
      var_1._id_4143 = 0;
      var_1._id_FEE7 = 0;
      var_1._id_FEB1 = 1;
      var_1._id_7C8C = "care_package";
      var_1._id_DDC9 = 1;
      var_1._id_ABCB = ::_id_11F9;
      var_1 thread _id_07D6::_id_FE97();
      var_1._id_F3FE = var_1 _id_07D6::_id_4069(var_1, (0, 0, 70));
      var_1._id_F3FE._id_A90C = 0;
      var_1._id_F3FE._id_A90B = 0;
      var_1._id_F3FE._id_A912 = 0.05;
      var_1._id_F3FE._id_1041A = "friendly";
      var_1._id_852E = 1;
      var_1._id_F3FE _id_07D6::_id_D61B(level._id_7C55);
      continue;
    }

    waitframe();
  }

  var_1 _meth_8390("vip");
  var_1 thread _id_7C1B(var_2);
  var_1 thread _id_7C1D();
  var_1 takeallweapons();
  waitframe();
  var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon("s4_me_fists_mp", undefined, undefined, 1);
  level._id_103EE = var_1;
}

_id_7C1B(var_0) {
  self _meth_8058(var_0, 20, "critical");
  var_1 = scripts\mp\bots\bots_util::_id_291C();

  while(!isDefined(self._id_F0E7)) {
    self _meth_8054("disable_movement", 1);
    wait 0.1;
  }
}

_id_11F9(var_0) {
  scripts\mp\utility\print::_id_BD0F("HVT is following " + var_0.name, var_0.team);
  self._id_5E29 = 1;
  self._id_FEE7 = 1000;
  thread _id_5E2E(var_0);
  var_0 thread _id_10BC3(self);
  self.trigger scripts\mp\utility\usability::_id_9A0F(self.team);
  self.trigger disableplayeruse(var_0);
}

_id_5E2E(var_0) {
  self endon("game_ended");
  self._id_F0E7 = var_0;
  level._id_F0E7 = var_0;
  self _meth_8054("disable_movement", 0);
  level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 11, 12, level._id_F0E7, 9);

  while(isDefined(self._id_F0E7)) {
    var_1 = self._id_F0E7 getstance();
    self _meth_805B(var_1);

    if(self._id_F0E7 issprinting()) {
      self _meth_8054("cautious", 0);
      self _meth_8054("force_sprint", 1);
    } else {
      self _meth_8054("force_sprint", 0);
      self _meth_8054("cautious", 1);
    }

    if(distance2dsquared(self._id_F0E7.origin, self.origin) < 10000) {
      level._id_10409 = distance2dsquared(self._id_F0E7.origin, self.origin);
    } else if(distance2dsquared(self._id_F0E7.origin, self.origin) > 10000) {
      level._id_10409 = distance2dsquared(self._id_F0E7.origin, self.origin);
      var_2 = _func_0020(self._id_F0E7.origin, 40, self);

      if(isDefined(var_2)) {
        self _meth_8055("sneak");
        self _meth_8058(var_2, 32, "tactical");
        var_3 = scripts\mp\bots\bots_util::_id_291C(3);

        if(var_3 == "goal") {}
      }
    }

    wait 0.15;
  }

  level._id_F0E7 = undefined;
}

_id_10BC3(var_0) {
  self endon("game_ended");
  var_0 endon("tether_swap");
  self waittill("death");
  var_0._id_5E29 = 0;
  var_0._id_FEE7 = 0;
  var_0._id_F0E7 = undefined;
  level._id_F0E7 = undefined;
  level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 10, 12);
}

_id_7C1D() {
  self endon("game_ended");
  self endon("hvt_timeout");
  self waittill("death");
  self._id_F3FE _id_07D6::_id_C300();
  self.trigger scripts\mp\utility\usability::_id_D46B();
  level._id_7A96[0] = ::scripts\mp\tac_ops\hostage_utility::_id_E2FE(self.origin, self.team, 1);
  level._id_7A96[0]._id_ACE5 = scripts\mp\utility\outline::_id_ACD2(level._id_7A96[0]._id_25CA, level._id_7A96[0].team, "outline_nodepth_cyan", "killstreak_personal");
}

_id_FCC2() {
  level endon("game_ended");
  level _id_07D1::_id_60C2("prematch_done");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level._id_103EE)) {
    if(isDefined(level._id_F0E7)) {
      if(isDefined(level._id_F0E7.team) && level._id_F0E7.team == self.team) {
        if(level._id_F0E7 == self) {
          self setclientomnvar("ui_match_status_hint_text", 9);
        } else {
          self setclientomnvar("ui_match_status_hint_text", 11);
        }
      } else
        self setclientomnvar("ui_match_status_hint_text", 12);
    } else if(isDefined(self.team) && level._id_103EE.team == self.team)
      self setclientomnvar("ui_match_status_hint_text", 10);
    else {
      self setclientomnvar("ui_match_status_hint_text", 12);
    }
  } else if(isDefined(level._id_7A8A)) {
    if(level._id_7A8A.team == self.team) {
      if(level._id_7A8A == self) {
        self setclientomnvar("ui_match_status_hint_text", 13);
      } else {
        self setclientomnvar("ui_match_status_hint_text", 11);
      }
    } else
      self setclientomnvar("ui_match_status_hint_text", 12);
  } else if(level._id_7A96[0].team == self.team)
    self setclientomnvar("ui_match_status_hint_text", 10);
  else {
    self setclientomnvar("ui_match_status_hint_text", 12);
  }
}

_id_B35D(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = "ustl";
  var_4 = "dx_mpa_" + var_3 + "_" + var_1 + "_" + var_2;

  if(_func_0205(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0) {
        var_6 _meth_8287(var_4, var_1, 2);
      }
    }
  }
}

_id_106B3() {
  level endon("game_ended");
  level waittill("match_ending_very_soon");
  _id_B35D(game["attackers"], "extract_littlebird_leaving_soon_a_friendly", 10);
}