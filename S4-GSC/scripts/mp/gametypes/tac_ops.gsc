/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tac_ops.gsc
*************************************************/

main() {
  if(!isDefined(level._id_ED22)) {
    _id_07DC::init();
    _id_07DC::_id_D854();
    level._id_ED22 = "tac_ops";
    level._id_41D2 = "tac_ops";
    level._id_AB4C = ::_id_AB4C;
    level._id_ED0D = "START";
  }

  level._id_ED1C = [];
  level._id_E43B = 0;
  level._id_1FE1 = 5;

  if(_func_0127()) {
    scripts\mp\utility\game::_id_D4E0();
  } else {
    scripts\mp\utility\game::_id_C2AA("tac_ops", 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1("tac_ops", 3);
    scripts\mp\utility\game::_id_C2AD("tac_ops", 0);
    scripts\mp\utility\game::_id_C2A9("tac_ops", 1);
    scripts\mp\utility\game::_id_C2D0("tac_ops", 1);
    scripts\mp\utility\game::_id_C27E("tac_ops", 0);
    scripts\mp\utility\game::_id_C25D("tac_ops", 0);
    scripts\mp\utility\game::_id_C250("tac_ops", 0);
    scripts\mp\utility\game::_id_D635(2);
  }

  scripts\mp\gametypes\common::_id_FC39();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_9FE8 = ::_id_ABA4;
}

_id_3AE4() {
  _id_0A75::_id_81D4();
  _id_AA78();
  thread _id_F21B();
  level._id_15BD = 0;
  level._id_8A88 = 1;
  _id_0A76::_id_827D();
  _id_081C::init();
  _id_8294();
}

_id_AB4C(var_0) {
  var_1 = 1;

  if(isDefined(var_0)) {
    level._id_90D0 = var_0;
  }

  if(isDefined(level._id_90D0)) {
    var_1 = level._id_90D0 == "allies";
  }

  level._id_9FE8 = ::_id_ABA4;
  level._id_ED23 = 0;
  setgameendtime(0);
  level._id_E72D = gettime();
  level._id_ED22 = "tac_ops";
  level._id_41D2 = "tac_ops";
  level._id_ED0D = _id_E751(level._id_ED0D, var_1);
  level thread _id_CA5C();
  setomnvar("ui_tac_ops_submode", level._id_41D2);
}

_id_B8EE(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");

  foreach(var_5 in var_3) {
    if(!isbot(var_5)) {
      var_5 playlocalsound(var_0, var_2);
    }
  }
}

_id_EF93(var_0, var_1) {
  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA("allies", "players")) {
    var_3 thread _id_F8D0(var_0, 5);
  }

  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA("axis", "players")) {
    var_3 thread _id_F8D0(var_1, 5);
  }
}

_id_F8D0(var_0, var_1) {
  self sethudtutorialmessage(var_0);
  wait(var_1);
  self clearhudtutorialmessage();
}

_id_E364() {
  var_0 = level._id_CB1A[0][0].origin;
  _id_0A76::_id_405A(5, var_0, "allies", 1);
  var_0 = level._id_CB1A[1][0].origin;
  _id_0A76::_id_405A(1, var_0, "allies", 1);
  var_0 = level._id_CB1A[2][0].origin;
  _id_0A76::_id_405A(3, var_0, "allies", 1);
  var_0 = level._id_CB1A[3][0].origin;
  _id_0A76::_id_405A(6, var_0, "allies", 1);
  var_0 = level._id_CB1A[4][0].origin;
  _id_0A76::_id_405A(2, var_0, "allies", 1);
  var_0 = level._id_CB1A[5][0].origin;
  _id_0A76::_id_405A(4, var_0, "allies", 1);
  var_0 = level._id_CB1A[6][0].origin;
  _id_0A76::_id_405A(1, var_0, "axis", 1);
  var_0 = level._id_CB1A[7][0].origin;
  _id_0A76::_id_405A(5, var_0, "axis", 1);
  var_0 = level._id_CB1A[8][0].origin;
  _id_0A76::_id_405A(10, var_0, "axis", 1);
  var_0 = level._id_CB1A[9][0].origin;
  _id_0A76::_id_405A(9, var_0, "axis", 1);
  var_0 = level._id_CB1A[10][0].origin;
  _id_0A76::_id_405A(6, var_0, "axis", 1);
  var_0 = level._id_CB1A[11][0].origin;
  _id_0A76::_id_405A(7, var_0, "axis", 1);
}

_id_CA5C() {
  _id_AA78();

  switch (level._id_ED0D) {
    case "START":
      wait 5;
      break;
    case "ROUND_1":
      _id_0A75::_id_BEC1("dx_mpb_us1_phase1_infila2", "allies");
      _id_0A75::_id_BEC1("dx_mpb_aqcm_phase1_infilb", "axis");
      wait 6;
      _id_0A75::_id_BEC1("dx_mpb_chem_phase1_safehouse", "axis");
      scripts\mp\gametypes\to_dd::_id_997A();
      break;
    case "TRANSFER_1_2A":
      level notify("dd_phase_ended");
      _id_0A75::_id_BEC1("dx_mpb_chem_phase1_hvtgrab", "allies");
      _id_0A75::_id_BEC1("dx_mpb_us1_phase1_wina", "allies");
      _id_0A75::_id_BEC1("dx_mpb_aqcm_phase1_losingb", "axis");
      _id_E364();
      level._id_ED0D = _id_E751(level._id_ED0D, 1);
      level thread _id_CA5C();
      break;
    case "TRANSFER_1_2B":
      level notify("dd_phase_ended");
      _id_E364();
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_DD_END_1B", &"MISC_MESSAGES_MP/TO_AXIS_DD_END_1B");
      wait 6;
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_DD_END_1C", &"MISC_MESSAGES_MP/TO_AXIS_DD_END_1C");
      wait 6;
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_PRE_1B");
      wait 6;
      level._id_ED0D = _id_E751(level._id_ED0D, 0);
      level thread _id_CA5C();
      break;
    case "ROUND_2B":
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_AIR_START_1", &"MISC_MESSAGES_MP/TO_AXIS_AIR_START_1");
      break;
    case "ROUND_2A":
      level scripts\mp\gametypes\to_hstg::_id_997A();
      level scripts\mp\gametypes\to_hstg::_id_0EFE();
      wait 6;
      _id_0A75::_id_BEC1("dx_mpb_ovl_phase1_wina", "allies");
      _id_0A75::_id_BEC1("dx_mpb_aqcm_phase2_introb", "axis");
      wait 6;
      _id_0A75::_id_BEC1("dx_mpb_ovl_phase2_introa1", "allies");
      wait 6;
      _id_0A75::_id_BEC1("dx_mpb_us1_phase2_introa2", "allies");
      break;
    case "TRANSFER_2A_3AA":
      _id_0A75::_id_BEC1("dx_mpb_aqcm_phase2_lossb", "axis");
      level notify("hostage_phase_ended");
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2A", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2A");
      wait 6;
      thread scripts\mp\gamelogic::_id_52F7("none", 0);
      return;
    case "TRANSFER_2A_3AB":
      level notify("hostage_phase_ended");
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2B", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2B");
      wait 6;
      thread scripts\mp\gamelogic::_id_52F7("none", 0);
      return;
    case "TRANSFER_2B_3BA":
      level notify("hostage_phase_ended");
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2A", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2A");
      wait 6;
      thread scripts\mp\gamelogic::_id_52F7("none", 0);
      return;
    case "TRANSFER_2B_3BB":
      level notify("hostage_phase_ended");
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2B", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2B");
      wait 6;
      thread scripts\mp\gamelogic::_id_52F7("none", 0);
      return;
    case "ROUND_3AA":
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_WMD_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_WMD_PRE_1");
      wait 6;
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_WMD_START_1", &"MISC_MESSAGES_MP/TO_AXIS_WMD_START_1");
      level scripts\mp\gametypes\to_wmd::_id_997A();
      level scripts\mp\gametypes\to_wmd::_id_0EFE();
      break;
    case "ROUND_3AB":
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_BHD_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_BHD_PRE_1");
      wait 6;
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_BHD_START_1", &"MISC_MESSAGES_MP/TO_AXIS_BHD_START_1");
      level scripts\mp\gametypes\to_bhd::_id_997A();
      level scripts\mp\gametypes\to_bhd::_id_0EFE();
      break;
    case "ROUND_3BA":
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_SAM_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_SAM_PRE_1");
      wait 6;
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_SAM_START_1", &"MISC_MESSAGES_MP/TO_AXIS_SAM_START_1");
      level scripts\mp\gametypes\to_sam::_id_997A();
      level scripts\mp\gametypes\to_sam::_id_0EFE();
      break;
    case "ROUND_3BB":
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_BLITZ_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_BLITZ_PRE_1");
      wait 6;
      _id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_BLITZ_START_1", &"MISC_MESSAGES_MP/TO_AXIS_BLITZ_START_1");
      level scripts\mp\gametypes\to_blitz::_id_997A();
      level scripts\mp\gametypes\to_blitz::_id_0EFE();
      break;
    case "FINALE_3BBA":
    case "FINALE_3ABB":
    case "FINALE_3AAB":
    case "FINALE_3BBB":
    case "FINALE_3ABA":
    case "FINALE_3BAB":
    case "FINALE_3BAA":
    case "END":
    case "FINALE_3AAA":
      thread scripts\mp\gamelogic::_id_52F7("none", 0);
      break;
  }
}

_id_AA78() {
  level._id_E72D = gettime();
  level._id_ED23 = 0;
  level._id_AF72 = 0;
  level._id_AF77 = 0;
}

_id_D0C4() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(isDefined(level._id_ED1C[var_1])) {
      if(level._id_ED1C[var_1] == "tie" || level._id_ED1C[var_1] == "allies") {
        var_0 = var_0 + int(_func_01A6(10, var_1) * 1);
        continue;
      }

      var_0 = var_0 + int(_func_01A6(10, var_1) * 2);
    }
  }

  _func_01EA("ui_tac_ops_results", var_0);
}

_id_C93A() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\utility\game::_id_D73A(0.0);
  }

  scripts\mp\utility\player::_id_0DC2("", 0);
  _func_0266("", 0.75);
  wait 5.0;
  visionsetnaked("", 0.75);
}

_id_E751(var_0, var_1) {
  switch (var_0) {
    case "START":
      var_0 = "ROUND_1";
      break;
    case "ROUND_1":
      if(var_1) {
        var_0 = "TRANSFER_1_2A";
      } else {
        var_0 = "END";
      }

      break;
    case "TRANSFER_1_2A":
      var_0 = "ROUND_2A";
      break;
    case "TRANSFER_1_2B":
      var_0 = "END";
      break;
    case "ROUND_2A":
      if(var_1) {
        var_0 = "TRANSFER_2A_3AA";
      } else {
        var_0 = "END";
      }

      break;
    case "ROUND_2B":
      if(var_1) {
        var_0 = "TRANSFER_2B_3BA";
      } else {
        var_0 = "TRANSFER_2B_3BB";
      }

      break;
    case "TRANSFER_2A_3AA":
      var_0 = "ROUND_3AA";
      break;
    case "TRANSFER_2A_3AB":
      var_0 = "ROUND_3AB";
      break;
    case "TRANSFER_2B_3BA":
      var_0 = "ROUND_3AB";
      break;
    case "TRANSFER_2B_3BB":
      var_0 = "ROUND_3BB";
      break;
    case "ROUND_3AA":
      if(var_1) {
        var_0 = "FINALE_3AAA";
      } else {
        var_0 = "FINALE_3AAB";
      }

      break;
    case "ROUND_3BB":
      if(var_1) {
        var_0 = "FINALE_3BBA";
      } else {
        var_0 = "FINALE_3BBB";
      }

      break;
    case "ROUND_3AB":
      if(var_1) {
        var_0 = "FINALE_3ABA";
      } else {
        var_0 = "FINALE_3ABB";
      }

      break;
    case "ROUND_3BA":
      if(var_1) {
        var_0 = "FINALE_3BAA";
      } else {
        var_0 = "FINALE_3BAB";
      }

      break;
    case "FINALE_3BBA":
    case "FINALE_3ABB":
    case "FINALE_3AAB":
    case "FINALE_3BBB":
    case "FINALE_3ABA":
    case "FINALE_3BAB":
    case "FINALE_3BAA":
    case "FINALE_3AAA":
      var_0 = "END";
      break;
  }

  return var_0;
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  scripts\mp\utility\game::_id_D61C("allies", &"OBJECTIVES/WAR");
  scripts\mp\utility\game::_id_D61C("axis", &"OBJECTIVES/WAR");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/WAR");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/WAR");
  } else {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/WAR_SCORE");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/WAR_SCORE");
  }

  scripts\mp\utility\game::_id_D615("allies", &"OBJECTIVES/WAR_HINT");
  scripts\mp\utility\game::_id_D615("axis", &"OBJECTIVES/WAR_HINT");
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");
  var_1[0] = "dd";
  var_1[1] = "dd_bombzone";
  var_1[2] = "blocker";
  var_1[3] = "grind";
  var_1[4] = "dom";
  var_1[5] = "conf";
  var_1[6] = "tac_ops";
  var_1[7] = "barrier_checkpoint";
  _id_07D6::main(var_1);
  _id_3AE4();
  scripts\mp\gametypes\to_dd::_id_0EFE();
  level thread _id_5BD8();
  _id_8280();
  _id_E364();
  _id_0A76::_id_526F(level._id_ED20);
}

_id_8280() {
  var_0 = "radar_drone";
  var_1 = "precision_airstrike";
  level._id_CB1A = [];
  level._id_CB1B = [];
  level._id_CB1A[0] = ::scripts\engine\utility::getStructArray("tac_advantage_a", "targetname");
  level._id_CB1B[0] = var_0;
  level._id_CB1A[1] = ::scripts\engine\utility::getStructArray("tac_advantage_b", "targetname");
  level._id_CB1B[1] = var_0;
  level._id_CB1A[2] = ::scripts\engine\utility::getStructArray("tac_advantage_c", "targetname");
  level._id_CB1B[2] = var_1;
  level._id_CB1A[3] = ::scripts\engine\utility::getStructArray("tac_advantage_d", "targetname");
  level._id_CB1B[3] = var_1;
  level._id_CB1A[4] = ::scripts\engine\utility::getStructArray("tac_advantage_e", "targetname");
  level._id_CB1B[4] = var_0;
  level._id_CB1A[5] = ::scripts\engine\utility::getStructArray("tac_advantage_f", "targetname");
  level._id_CB1B[5] = var_1;
  level._id_CB1A[6] = ::scripts\engine\utility::getStructArray("tac_advantage_h", "targetname");
  level._id_CB1B[6] = var_1;
  level._id_CB1A[7] = ::scripts\engine\utility::getStructArray("tac_advantage_i", "targetname");
  level._id_CB1B[7] = var_0;
  level._id_CB1A[8] = ::scripts\engine\utility::getStructArray("tac_advantage_j", "targetname");
  level._id_CB1B[8] = var_1;
  level._id_CB1A[9] = ::scripts\engine\utility::getStructArray("tac_advantage_k", "targetname");
  level._id_CB1B[9] = var_1;
  level._id_CB1A[10] = ::scripts\engine\utility::getStructArray("tac_advantage_l", "targetname");
  level._id_CB1B[10] = var_1;
  level._id_CB1A[11] = ::scripts\engine\utility::getStructArray("tac_advantage_m", "targetname");
  level._id_CB1B[11] = var_1;
}

_id_5BD8() {
  if(level._id_BBAD > 0) {
    _id_07D1::_id_60C2("prematch_done");
  } else {
    wait 15;
  }

  _id_AB4C(level._id_90D0);
}

_id_ABA4() {
  scripts\mp\playerlogic::_id_7DE8(self.team);
  self._id_8986 = 0;
  self._id_87F7 = 0;
}

onplayerconnect(var_0) {
  var_0 setclientomnvar("ui_hp_callout_id", 2);
  var_0._id_8A17 = 0;
  setomnvar("ui_tac_ops_submode", level._id_41D2);
  var_0 thread _id_A11C();
}

_id_A11C() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    scripts\mp\supers::_id_3987();
    _id_0A76::_id_90D2();
  }
}

_id_8294() {
  _id_0817::_id_D461("TDM");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  var_0 = spawnStruct();
  level._id_ED1E = var_0;
  scripts\mp\gametypes\to_air::_id_8294();
  scripts\mp\gametypes\to_bhd::_id_8294();
  scripts\mp\gametypes\to_blitz::_id_8294();
  scripts\mp\gametypes\to_dd::_id_8294();
  scripts\mp\gametypes\to_hstg::_id_8294();
  scripts\mp\gametypes\to_sam::_id_8294();
  scripts\mp\gametypes\to_wmd::_id_8294();
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_081C::_id_D8B3();
  _id_0817::_id_0EE5();
}

_id_ABB3(var_0) {}

_id_AB3F(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_0._id_EC33)) {
    var_0 scripts\mp\playerlogic::_id_4554(var_0.team);
  }
}

_id_F21B() {
  level endon("game_ended");
  var_0 = _id_6DAE();

  for(;;) {
    thread _id_3565(var_0);
    var_0 = _id_6DAE();

    if(isDefined(level._id_E72D)) {
      if(_id_6DAF() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

_id_57FA(var_0) {
  level._id_232B = _id_6DAD() + var_0;
}

_id_C17F(var_0) {
  level._id_232B = _id_6DAD() - var_0;
}

_id_3565(var_0) {
  var_1 = _id_6DAF();
  setgameendtime(gettime() + int(var_1));

  if(level._id_ED23 == 0) {
    setgameendtime(0);
    return;
  }

  if(var_1 > 0) {
    return;
  }
  setgameendtime(0);
  [[level._id_ABC0]]();
}

_id_6DAE() {
  if(isDefined(level._id_AF73)) {
    return level._id_AF73;
  }

  return gettime() - level._id_E72D;
}

_id_6DAD() {
  if(!isDefined(level._id_232B)) {
    level._id_232B = scripts\mp\utility\dvars::getwatcheddvar("timelimit") * 60 * 1000;
  }

  return level._id_232B;
}

_id_6DAC() {
  return level._id_232B - scripts\mp\utility\dvars::getwatcheddvar("timelimit") * 60 * 1000 + level._id_AF77;
}

_id_6DAF() {
  return _id_6DAD() - _id_6DAE();
}

_id_AF74() {
  if(level._id_AF72 == 0) {
    level._id_AF73 = _id_6DAE();
    level._id_AF75 = gettime();
  }

  level._id_AF72++;
}

_id_C731() {
  level._id_AF72--;

  if(level._id_AF72 < 0) {
    level._id_AF72 = 0;
  }

  if(level._id_AF72 == 0) {
    if(!isDefined(level._id_AF73)) {
      level._id_AF73 = 0;
    }

    if(!isDefined(level._id_AF75)) {
      level._id_AF75 = 0;
    }

    level._id_E72D = gettime() - level._id_AF73;

    if(!isDefined(level._id_AF77)) {
      level._id_AF77 = 0;
    }

    level._id_AF77 = level._id_AF77 + (gettime() - level._id_AF75);
    level._id_AF73 = undefined;
    level._id_AF75 = undefined;
  }
}

_id_ED14(var_0) {
  var_1 = _id_6DAF() / 1000 - var_0;
  wait(var_1);
  var_2 = _id_6DAC() / 1000;
  wait(var_2);
}