/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\twar.gsc
*********************************************/

func_00F9() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 10);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 75);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_86EB(3);
  maps\mp\_utility::func_873B(1);
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  level.var_6BA7 = ::func_6BA7;
  level.var_6BB6 = ::func_6BB6;
  level.var_6B7B = ::func_6B7B;
  level.var_0AA1 = 1;
  level.var_62AD = ::func_6216;
  level.var_6A75 = ::func_6AA5;
  level.var_3CBA = loadfx("vfx/unique/vfx_flag_project_neutral");
  level.var_188C = loadfx("vfx/unique/vfx_marker_dom_white");
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "mom_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("311")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "mtm_alert";
  game["dialog"]["offense_obj"] = "mtm_alert";
  game["dialog"]["mtm_taking"] = "mtm_taking";
  game["dialog"]["mtm_etaking"] = "mtm_etaking";
  game["dialog"]["mtm_lastflg"] = "mtm_lastflg";
  game["dialog"]["mtm_elastflg"] = "mtm_elastflg";
  game["dialog"]["mtm_secured"] = "mtm_secured";
  game["dialog"]["mtm_captured"] = "mtm_captured";
  game["dialog"]["mtm_max"] = "mtm_max";
  game["dialog"]["mtm_gain"] = "mtm_gain";
  game["dialog"]["mtm_reset"] = "mtm_reset";
  game["dialog"]["mtm_clrd"] = "mtm_clrd";
  game["dialog"]["mtm_lost"] = "mtm_lost";
  if(!isDefined(game["shut_out"])) {
    game["shut_out"]["axis"] = 1;
    game["shut_out"]["allies"] = 1;
    game["max_meter"]["axis"] = 0;
    game["max_meter"]["allies"] = 0;
  }

  setDvar("5539", 1);
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_twar_roundswitch", 0);
  maps\mp\_utility::func_7BF8("twar", 0, 0, 9);
  setdynamicdvar("scr_twar_roundlimit", 1);
  maps\mp\_utility::func_7BF7("twar", 1);
  setdynamicdvar("scr_twar_winlimit", 1);
  maps\mp\_utility::func_7C04("twar", 1);
  setdynamicdvar("scr_twar_halftime", 0);
  maps\mp\_utility::func_7BE5("twar", 0);
  setdynamicdvar("scr_twar_halftime", 0);
  setdynamicdvar("scr_twar_minionsmax", getmatchrulesdata("twarData", "numMinions"));
  setdynamicdvar("scr_twar_capture_time", getmatchrulesdata("twarData", "captureTime"));
  setdynamicdvar("scr_twar_zone_count", getmatchrulesdata("twarData", "numFlags"));
  setdynamicdvar("scr_twar_ot_zone_count", getmatchrulesdata("twarData", "numOTFlags"));
  setdynamicdvar("scr_twar_min_capture_players", 1);
  setdynamicdvar("scr_twar_hud_momentum_bar", !getmatchrulesdata("twarData", "hideMomentumBar"));
}

func_6BAF() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_TWAR");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_TWAR");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_TWAR");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_TWAR");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_TWAR_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_TWAR_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_TWAR_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_TWAR_HINT");
  game["dialog"]["lockouts"]["mtm_taking"] = 5;
  game["dialog"]["lockouts"]["mtm_etaking"] = 5;
  lib_050D::func_10E4();
  var_02[0] = level.var_3FDC;
  maps\mp\gametypes\_gameobjects::func_00F9(var_02);
  level.var_AC8B = getdvarint("scr_twar_zone_radius", 150);
  level.var_AC87 = 60;
  level.var_62C4 = 3;
  func_3B87();
  func_2777();
  func_520A("allies");
  func_520A("axis");
  thread func_A89E();
  thread func_A139();
  thread func_A0AE();
}

func_A89E() {
  for(;;) {
    level waittill("joined_team");
    level notify("update_flag_outline");
    func_A0B1();
  }
}

func_6BB6() {
  level.var_3B5C = "none";
  if(game["status"] == "overtime") {
    var_00 = "tie";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_00 = "overtime";
    game["owned_flags"] = [];
    game["owned_flags"]["allies"] = 0;
    game["owned_flags"]["axis"] = 0;
    foreach(var_02 in level.var_9FC2) {
      if(var_02.var_0117 == "allies") {
        game["owned_flags"]["allies"]++;
        continue;
      }

      if(var_02.var_0117 == "axis") {
        game["owned_flags"]["axis"]++;
      }
    }
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level.var_3B5C = "axis";
    var_00 = "axis";
  } else {
    level.var_3B5C = "allies";
    var_00 = "allies";
  }

  if(maps\mp\_utility::func_761E()) {
    var_00 = "none";
  }

  thread maps\mp\gametypes\_gamelogic::func_36B9(var_00, game["end_reason"]["time_limit_reached"]);
}

func_8FA8(param_00) {
  var_01 = spawn("script_model", param_00);
  var_01 setModel("flag_holo_base_ground");
  return var_01;
}

func_2777() {
  var_00[0] = func_8FA8((0, 0, 0));
  var_01 = spawn("trigger_radius", (0, 0, 0), 0, level.var_AC8B, level.var_AC87);
  var_01.var_014F = level.var_AC8B;
  var_02 = getdvarfloat("scr_twar_capture_time", 20);
  var_03 = maps\mp\gametypes\_gameobjects::func_2837("neutral", var_01, var_00);
  var_03 maps\mp\gametypes\_gameobjects::func_0C30("any");
  var_03 maps\mp\gametypes\_gameobjects::func_8A5A(var_02);
  var_03 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_03.var_59DD = 1;
  var_03.var_681A = 1;
  var_03.var_502A = "twarZone";
  var_03.var_6ABC = ::func_6ABC;
  var_03.var_6BBF = ::func_6BBF;
  var_03.var_6AFA = ::func_6AFA;
  var_03.var_6BBE = ::func_6BBE;
  level.var_9FC0 = var_03;
  func_7D4C();
}

func_AC8E() {
  maps\mp\gametypes\_gameobjects::func_86EC("neutral");
  maps\mp\gametypes\_gameobjects::func_0C30("none");
  var_00 = "waypoint_waitfor_flag_neutral";
  maps\mp\gametypes\_gameobjects::func_860A("friendly", var_00);
  maps\mp\gametypes\_gameobjects::func_860E("friendly", var_00);
  maps\mp\gametypes\_gameobjects::func_860A("enemy", var_00);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", var_00);
  maps\mp\_utility::func_863F(self, "waypoint_waitfor_flag_neutral", 3);
  self.var_A6E5 = 1;
  setomnvar("ui_twar_capture_team", 3);
}

func_A0AA(param_00, param_01) {
  if(isDefined(self.var_A6E5)) {
    return;
  }

  if(param_00 > 0 && param_01 > 0) {
    var_02 = "waypoint_contested";
    maps\mp\gametypes\_gameobjects::func_860A("friendly", var_02);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", var_02);
    maps\mp\gametypes\_gameobjects::func_860A("enemy", var_02);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", var_02);
    maps\mp\_utility::func_863F(self, "waypoint_contested", 3);
    return;
  }

  if(param_00 == 0 && param_01 == 0) {
    var_02 = "waypoint_captureneutral";
    maps\mp\gametypes\_gameobjects::func_860A("friendly", var_02);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", var_02);
    maps\mp\gametypes\_gameobjects::func_860A("enemy", var_02);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", var_02);
    maps\mp\_utility::func_863F(self, "waypoint_captureneutral", 3);
    return;
  }

  maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_losing");
  maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_losing");
  maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_taking");
  maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_taking");
  if(self.var_230F == "allies") {
    maps\mp\_utility::func_863F(self, "waypoint_esports_taking_blue", 1);
    return;
  }

  maps\mp\_utility::func_863F(self, "waypoint_esports_taking_red", 2);
}

func_AC8C() {
  maps\mp\gametypes\_gameobjects::func_86EC("neutral");
  maps\mp\gametypes\_gameobjects::func_0C30("any");
  self.var_A6E5 = undefined;
  setomnvar("ui_twar_capture_team", 0);
  func_A0AA(0, 0);
}

func_AC82() {
  func_AC83();
  var_00 = level.var_9FC0.var_A582[0];
  self.var_3CB9 = spawnlinkedfx(level.var_3CBA, var_00, "tag_fx_flag");
  function_014E(self.var_3CB9, 1);
  triggerfx(self.var_3CB9);
}

func_AC83() {
  if(isDefined(self.var_3CB9)) {
    self.var_3CB9 delete();
  }
}

func_AC7D() {
  func_AC7E();
  var_00 = level.var_9FC0.var_A582[0];
  self.var_188B = spawnfx(level.var_188C, var_00.var_0116, anglestoup(var_00.var_001D));
  function_014E(self.var_188B, 1);
  triggerfx(self.var_188B);
}

func_AC7E() {
  if(isDefined(self.var_188B)) {
    self.var_188B delete();
  }
}

func_AC8D(param_00) {
  maps\mp\gametypes\_gameobjects::func_86EC(param_00);
  maps\mp\gametypes\_gameobjects::func_0C30("any");
}

func_A0A5() {
  for(;;) {
    level waittill("update_flag_outline");
    var_00 = getdvarint("scr_twar_flag_outline_color_friendly", -1);
    var_01 = getdvarint("scr_twar_flag_outline_color_enemy", -1);
    var_02 = getdvarint("scr_twar_flag_outline_color_neutral", -1);
    var_03 = getdvarint("scr_twar_flag_outline_depth", 0);
    self hudoutlinedisableforclients(level.var_744A);
    var_04 = level.var_9FC0 maps\mp\gametypes\_gameobjects::func_445B();
    var_05 = [];
    var_06 = [];
    var_07 = [];
    foreach(var_09 in level.var_744A) {
      if((var_04 == "allies" || var_04 == "axis") && var_09.var_01A7 == "allies" || var_09.var_01A7 == "axis") {
        if(var_04 == var_09.var_01A7) {
          var_05[var_05.size] = var_09;
        } else {
          var_06[var_06.size] = var_09;
        }

        continue;
      }

      var_07[var_07.size] = var_09;
    }

    if(var_05.size && var_00 >= 0) {
      self hudoutlineenableforclients(var_05, var_00, var_03);
    }

    if(var_06.size && var_01 >= 0) {
      self hudoutlineenableforclients(var_06, var_01, var_03);
    }

    if(var_07.size && var_02 >= 0) {
      self hudoutlineenableforclients(var_07, var_02, var_03);
    }
  }
}

func_7D4C() {
  var_00 = int(level.var_9FC2.size / 2);
  foreach(var_03, var_02 in level.var_9FC2) {
    if(var_03 < var_00) {
      var_02.var_0117 = "allies";
      continue;
    }

    if(var_03 > var_00) {
      var_02.var_0117 = "axis";
      continue;
    }

    var_02.var_0117 = "none";
  }

  func_843F(level.var_9FC2[var_00]);
}

func_6ABC(param_00) {
  var_01 = param_00.var_01A7;
  var_02 = maps\mp\_utility::func_45DE(var_01);
  func_AC8D(var_01);
  maps\mp\_utility::func_5C39("mtm_taking", var_01);
  maps\mp\_utility::func_5C39("mtm_etaking", var_02);
  level notify("update_flag_outline");
}

func_6BBF(param_00) {
  var_01 = param_00.var_01A7;
  var_02 = maps\mp\_utility::func_45DE(var_01);
  var_03 = self.var_AC7C;
  var_03.var_0117 = var_01;
  var_04 = var_03.var_00D4;
  if(var_01 == "allies") {
    var_04++;
  } else if(var_01 == "axis") {
    var_04--;
  }

  game["shut_out"][var_02] = 0;
  if(getdvarint("scr_twar_momentum_clear_friendly_on_capture", 0)) {
    func_23C3(var_01);
  } else {
    func_0909(var_01);
  }

  if(getdvarint("scr_twar_momentum_clear_enemy_on_capture", 0)) {
    func_23C3(var_02);
  } else {
    func_0908(var_02);
  }

  param_00 thread maps\mp\_audio::func_8DAE("mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
  thread func_47C9(self.var_9AC3[var_01]);
  if(var_04 < 0 || var_04 >= level.var_6878) {
    func_AC83();
    func_AC7E();
    level maps\mp\gametypes\_gamescore::func_47BD(var_01, 1, 1);
    maps\mp\_utility::func_5C39("mtm_secured", var_01);
    if(level.var_3F9D) {
      maps\mp\gametypes\_gameobjects::func_2F93();
    } else {
      func_7D4C();
    }
  } else {
    func_843F(level.var_9FC2[var_04]);
    if(var_04 == 0 || var_04 == level.var_6878 - 1) {
      func_5C48("mtm_lastflg", var_02);
      func_5C48("mtm_elastflg", var_01);
    } else {
      func_5C48("mtm_secured", var_01);
    }
  }

  self.var_66D5 = gettime() + 50;
}

func_5C48(param_00, param_01) {
  thread func_0671(param_00, param_01);
}

func_0671(param_00, param_01) {
  wait 0.05;
  maps\mp\_utility::func_5C39(param_00, param_01);
}

func_47C9(param_00) {
  level endon("game_ended");
  var_01 = maps\mp\gametypes\_gameobjects::func_44AF();
  if(isDefined(var_01.var_0117)) {
    var_01 = var_01.var_0117;
  }

  if(isPlayer(var_01)) {
    level thread maps\mp\_utility::func_9863("callout_securedposition", var_01);
  }

  var_02 = getarraykeys(param_00);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_01 = param_00[var_02[var_03]].var_721C;
    if(isDefined(var_01.var_0117)) {
      var_01 = var_01.var_0117;
    }

    if(!isPlayer(var_01)) {
      continue;
    }

    var_01 thread maps\mp\_events::func_320C(0);
    wait 0.05;
  }
}

func_6AFA(param_00, param_01, param_02) {
  func_AC8C();
  level notify("update_flag_outline");
}

func_6BBE() {
  var_00 = self.var_A22B;
  var_01 = 0;
  var_02 = 0;
  var_03 = maps\mp\_utility::func_45DE(self.var_230F);
  foreach(var_05 in self.var_9AC3[var_03]) {
    var_06 = var_05.var_721C;
    if(!isDefined(var_06)) {
      continue;
    }

    if(var_06.var_012C["team"] != var_03) {
      continue;
    }

    var_02++;
  }

  var_08 = getdvarint("scr_twar_capture_players_max", 3);
  foreach(var_05 in self.var_9AC3[self.var_230F]) {
    var_06 = var_05.var_721C;
    if(!isDefined(var_06)) {
      continue;
    }

    if(var_06.var_012C["team"] != self.var_230F) {
      continue;
    }

    var_01++;
    if(var_01 >= var_08) {
      break;
    }
  }

  self.var_A22B = 0;
  self.var_915C = var_01 && var_02;
  var_0B = getdvarint("scr_twar_min_capture_players", 1);
  if(var_01 && !var_02 && var_01 >= var_0B) {
    var_0C = level.var_9FBF[self.var_230F];
    self.var_A22B = var_01 * var_0C;
  }

  var_0D = getdvarint("scr_twar_capture_rate_max", 9);
  self.var_A22B = min(self.var_A22B, var_0D);
  if(self.var_59DD && self.var_5B82 != self.var_230F) {
    self.var_A22B = self.var_A22B * -1;
  }

  func_A0AA(var_01, var_02);
}

func_843F(param_00) {
  param_00.var_0117 = "none";
  level.var_9FC0.var_AC7C = param_00;
  level.var_9FC0 maps\mp\gametypes\_gameobjects::func_6497(param_00.var_0116, (0, 0, 100));
  foreach(var_02 in level.var_9FC2) {
    if(var_02 != param_00) {
      var_02.var_776E method_805B();
      continue;
    }

    var_02.var_776E method_805C();
  }

  if(level.var_9FC0.var_59DD) {
    level.var_9FC0.var_5B82 = "none";
  }

  level thread func_8440(5);
  func_10D9();
}

func_8440(param_00) {
  waittillframeend;
  level.var_9FC0 func_AC83();
  level.var_9FC0 func_AC7D();
  level.var_9FC0 func_AC8E();
  wait(param_00);
  level.var_9FC0 func_AC82();
  level.var_9FC0 func_AC8C();
}

func_A0AE() {
  for(;;) {
    waittillframeend;
    var_00 = 0;
    foreach(var_02 in level.var_9FC2) {
      if(var_02.var_0117 == "allies") {
        var_00++;
      }
    }

    setomnvar("ui_twar_ally_flag_count", var_00);
    var_04 = 0;
    var_05 = "";
    if(level.var_9FC0.var_59DD) {
      var_05 = level.var_9FC0.var_5B82;
    } else {
      var_05 = level.var_9FC0.var_230F;
    }

    if(var_05 == "axis") {
      var_04 = 1;
    } else if(var_05 == "allies") {
      var_04 = 2;
    }

    var_06 = getdvarint("scr_twar_hud_momentum_bar", 1);
    setomnvar("ui_twar_momentum_bar_visible", var_06);
    if(getomnvar("ui_twar_capture_team") != 3) {
      setomnvar("ui_twar_capture_team", var_04);
    }

    var_07 = 0;
    if(var_05 != "none") {
      var_07 = level.var_9FC0.var_28D5 / level.var_9FC0.var_A23F;
    }

    setomnvar("ui_twar_capture_progress", var_07);
    foreach(var_04 in level.var_985B) {
      var_09 = 0;
      if(level.var_9FC0.var_5412 == "any") {
        var_09 = level.var_9FC0.var_689F[var_04];
      }

      setomnvar("ui_twar_touching_" + var_04, var_09);
    }

    wait 0.05;
  }
}

func_55B5(param_00) {
  return level.var_9FBF[param_00] == level.var_62C4;
}

func_8520(param_00, param_01) {
  thread func_23C1(param_00, param_01);
  func_8527(param_00, 0);
  setomnvar("ui_twar_momentum_maxed_time", param_01);
  setomnvar("ui_twar_momentum_end_time_" + param_00, gettime() + int(1000 * param_01));
}

func_23C1(param_00, param_01) {
  level endon("clear_max_momentum_" + param_00);
  wait(param_01);
  thread func_23C2(param_00);
}

func_23C2(param_00) {
  level notify("clear_max_momentum_" + param_00);
  if(!func_55B5(param_00)) {
    return;
  }

  func_8527(param_00, 0);
  func_8528(param_00, level.var_62C4 - 1);
  setomnvar("ui_twar_momentum_end_time_" + param_00, 0);
}

func_23C3(param_00) {
  if(level.var_9FBF[param_00] == 1) {
    maps\mp\_utility::func_5C39("mtm_clrd", param_00, "momentum_down");
  } else {
    maps\mp\_utility::func_5C39("mtm_reset", param_00, "momentum_down");
  }

  func_23C2(param_00);
  var_01 = level.var_9FBE[param_00] + level.var_9FBF[param_00] - 1;
  func_0941(param_00, -1 * var_01);
}

func_0941(param_00, param_01, param_02) {
  if(param_01 == 0) {
    return;
  }

  if(level.var_62C4 <= 1) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!param_02 && func_55B5(param_00)) {
    return;
  }

  var_03 = level.var_9FBE[param_00];
  var_04 = level.var_9FBF[param_00];
  var_05 = 0;
  var_03 = var_03 + param_01;
  while(var_03 <= 0 && var_04 > 1) {
    var_03 = var_03 + 1;
    var_04--;
    var_05 = 1;
  }

  if(!var_05) {
    while(var_03 >= 1 && var_04 < level.var_62C4) {
      var_03 = var_03 - 1;
      var_04++;
      var_05 = 1;
    }
  }

  func_8527(param_00, var_03);
  if(var_05) {
    func_8528(param_00, var_04);
  }

  if(func_55B5(param_00)) {
    var_06 = getdvarfloat("scr_twar_maxed_time", 20);
    func_8520(param_00, var_06);
    return;
  }

  setomnvar("ui_twar_momentum_" + param_00, level.var_9FBE[param_00]);
}

func_8527(param_00, param_01) {
  param_01 = clamp(param_01, 0, 1);
  level.var_9FBE[param_00] = param_01;
  setomnvar("ui_twar_momentum_" + param_00, level.var_9FBE[param_00]);
}

func_8528(param_00, param_01) {
  var_02 = level.var_9FBF[param_00];
  level.var_9FBF[param_00] = param_01;
  if(var_02 != param_01) {
    setomnvar("ui_twar_momentum_scale_" + param_00, param_01);
    level.var_9FC0 maps\mp\gametypes\_gameobjects::func_A18F();
    if(var_02 > param_01) {
      if(var_02 != level.var_62C4) {
        maps\mp\_utility::func_5C39("mtm_lost", param_00, "momentum_down");
        return;
      }

      return;
    }

    if(func_55B5(param_00)) {
      maps\mp\_utility::func_5C39("mtm_max", param_00);
      if(!game["max_meter"][param_00]) {
        game["max_meter"][param_00] = 1;
        foreach(var_04 in level.var_744A) {
          if(var_04.var_01A7 != param_00) {
            continue;
          }

          var_04 maps\mp\gametypes\_missions::func_7750("ch_twar_blitzkrieg");
        }

        return;
      }

      return;
    }

    maps\mp\_utility::func_5C39("mtm_gain", param_00);
    return;
  }
}

func_093D(param_00) {
  var_01 = getdvarfloat("scr_twar_momentum_kill_enemy", 0.1);
  func_0941(param_00, var_01);
}

func_093F(param_00) {
  var_01 = getdvarfloat("scr_twar_momentum_kill_friendly", -0.1);
  func_0941(param_00, var_01);
}

func_0909(param_00) {
  var_01 = getdvarfloat("scr_twar_momentum_capture_friendly", 0.2);
  func_0941(param_00, var_01);
}

func_0908(param_00) {
  var_01 = getdvarfloat("scr_twar_momentum_capture_enemy", -0.2);
  func_0941(param_00, var_01);
}

func_520A(param_00) {
  level.var_9FBF[param_00] = 1;
  level.var_9FBE[param_00] = 0;
  setomnvar("ui_twar_momentum_end_time_" + param_00, 0);
  setomnvar("ui_twar_momentum_" + param_00, level.var_9FBE[param_00]);
  setomnvar("ui_twar_momentum_scale_" + param_00, level.var_9FBF[param_00]);
  if(level.var_62C4 <= 1) {
    return;
  }

  level thread func_522D(param_00);
}

func_522D(param_00) {
  maps\mp\_utility::func_3FA5("prematch_done");
  if(game["status"] == "overtime") {
    var_01 = 0;
    var_02 = game["owned_flags"][param_00];
    if(var_02 == 4) {
      var_01 = 2;
    } else if(var_02 == 3) {
      var_01 = 1;
    }

    func_0941(param_00, var_01);
  }
}

func_4484() {
  return level.var_9FC0.var_AC7C;
}

func_6B5C(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    func_093D(param_01.var_01A7);
  }

  if(isDefined(param_00.var_01A7)) {
    func_093F(param_00.var_01A7);
  }
}

func_434B(param_00) {
  var_01 = [];
  var_02 = ["allies", "axis"];
  var_03 = [];
  foreach(var_05 in var_02) {
    var_03[var_05] = lib_050D::func_46A0(var_05);
  }

  foreach(var_05 in var_02) {
    var_08 = (0, 0, 0);
    foreach(var_0A in var_03[var_05]) {
      var_08 = var_08 + var_0A.var_0116;
    }

    var_08 = var_08 / var_03[var_05].size;
    var_01[var_05] = var_08;
  }

  if(param_00) {
    var_0D = getallnodes();
    foreach(var_05, var_08 in var_01) {
      var_0F = 0;
      for(var_10 = 0; var_10 < 10 && var_10 < var_0D.size; var_10++) {
        var_11 = getpathdist(var_08, var_0D[var_10].var_0116, 99999, 1);
        if(var_11 > 0) {
          var_0F = 1;
          break;
        }
      }

      if(!var_0F) {
        var_01[var_05] = var_03[var_05][0].var_0116;
      }
    }
  }

  return var_01;
}

func_3B87() {
  if(!isDefined(game["zone_origins"]) || game["status"] == "overtime") {
    game["zone_origins"] = func_43F5();
  }

  var_00 = 5;
  level.var_6878 = getdvarint("scr_twar_zone_count", var_00);
  if(level.var_6878 <= 0) {
    level.var_6878 = var_00;
  }

  if(game["status"] == "overtime") {
    level.var_6878 = getdvarint("scr_twar_ot_zone_count", 3);
  }

  if(game["zone_origins"].size > level.var_6878) {
    var_01 = int(game["zone_origins"].size - level.var_6878 / 2);
    var_02 = [];
    for(var_03 = var_01; var_03 <= game["zone_origins"].size - 1 - var_01; var_03++) {
      var_02[var_02.size] = game["zone_origins"][var_03];
    }

    game["zone_origins"] = var_02;
  }

  setomnvar("ui_twar_flag_count", level.var_6878);
  level.var_9FC2 = [];
  foreach(var_03, var_05 in game["zone_origins"]) {
    var_06 = func_9FC1(var_03, var_05.var_0116, var_05.var_001D, func_24E8(var_03));
    level.var_9FC2[var_03] = var_06;
  }
}

func_43F5() {
  var_00 = [];
  var_01 = common_scripts\utility::func_46B7("twar_zone", "targetname");
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.var_81E1)) {
      return var_00;
    }
  }

  if(var_01.size < 3 || var_01.size > 7) {
    return var_00;
  }

  var_01 = common_scripts\utility::func_7897(var_01, ::func_789A);
  foreach(var_03 in var_01) {
    var_06 = func_9FC3(var_03);
    var_07 = spawnStruct();
    var_07.var_0116 = var_03.var_0116;
    if(isDefined(var_06)) {
      var_07.var_001D = var_06;
    } else {
      var_07.var_001D = var_03.var_8107;
    }

    var_00[var_00.size] = var_07;
  }

  level.var_6878 = var_00.size;
  return var_00;
}

func_9FC3(param_00) {
  var_01 = maps\mp\_utility::func_4571();
  var_02 = undefined;
  var_03 = param_00.var_81E1;
  switch (var_01) {
    case "mp_detroit":
      if(var_03 == 5) {
        var_02 = (0, 215, 0);
      }

      if(var_03 == 1) {
        var_02 = (0, 245, 0);
      }
      break;

    case "mp_instinct":
      if(var_03 == 1) {
        var_02 = (0, 190, 0);
      }

      if(var_03 == 2) {
        var_02 = (0, 285, 0);
      }

      if(var_03 == 4) {
        var_02 = (0, 340, 0);
      }

      if(var_03 == 5) {
        var_02 = (0, 350, 0);
      }
      break;

    default:
      break;
  }

  return var_02;
}

func_789A(param_00, param_01) {
  return param_00.var_81E1 <= param_01.var_81E1;
}

func_43F6() {
  level.var_6878 = getdvarint("scr_twar_zone_count", 5);
  var_00 = func_434B(1);
  var_01 = ["allies", "axis"];
  var_02 = getallnodes();
  var_03 = level.var_6878;
  var_04 = getdvarfloat("scr_twar_auto_zone_spacing", 0.15);
  var_05 = getdvarfloat("scr_twar_auto_zone_zig_zag", 0.1);
  var_06 = getdvarint("scr_twar_auto_zone_allow_traversals", 0);
  var_07 = getdvarint("scr_twar_auto_zone_sky_only", 1);
  var_08 = [];
  for(var_09 = 0; var_09 < level.var_6878; var_09++) {
    var_0A = var_09 + 1 / level.var_6878 + 1 - var_09 + 1;
    var_0B = 2 * var_09 + 1 - 1 / 2 * level.var_6878 + 1 - var_09 + 1 + 1;
    var_0C = 2 * var_09 + 1 + 1 / 2 * level.var_6878 + 1 - var_09 + 1 - 1;
    var_08[var_09]["min"] = var_0A - var_04 * var_0A - var_0B;
    var_08[var_09]["max"] = var_0A + var_04 * var_0C - var_0A;
  }

  var_0D = [];
  for(var_09 = 0; var_09 < var_08.size; var_09++) {
    var_0D[var_09] = [];
  }

  foreach(var_0F in var_02) {
    if(var_07 && !nodeexposedtosky(var_0F, 1)) {
      continue;
    }

    var_10 = [];
    foreach(var_12 in var_01) {
      var_10[var_12] = getpathdist(var_00[var_12], var_0F.var_0116, 99999, var_06);
    }

    if(var_10["allies"] <= 0 || var_10["axis"] <= 0) {
      continue;
    }

    var_14 = var_10["allies"] / var_10["axis"];
    for(var_09 = 0; var_09 < var_08.size; var_09++) {
      if(var_14 > var_08[var_09]["min"] && var_14 < var_08[var_09]["max"]) {
        var_0D[var_09][var_0D[var_09].size] = var_0F;
      }
    }
  }

  var_16 = [];
  var_17 = var_00["allies"];
  foreach(var_09, var_19 in var_0D) {
    var_19 = function_01AC(var_19, var_17);
    var_1A = int(clamp(2 * var_19.size * var_05 - var_19.size, 0, var_19.size));
    var_1B = int(clamp(2 * var_19.size * var_05, 0, var_19.size));
    if(var_1A < var_1B) {
      var_1C = randomintrange(var_1A, var_1B);
    } else {
      var_1C = int(clamp(var_1A, 0, var_19.size - 1));
    }

    var_1D = spawnStruct();
    var_1D.var_0116 = var_19[var_1C].var_0116;
    var_16[var_09] = var_1D;
    var_17 = var_19[var_1C].var_0116;
  }

  return var_16;
}

func_24E8(param_00) {
  return (param_00 & 4, param_00 & 2, param_00 & 1);
}

func_9FC1(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_05 = param_01 + (0, 0, 32);
  var_06 = param_01 + (0, 0, -64);
  var_07 = bulletTrace(var_05, var_06, 0, undefined);
  var_04.var_0116 = var_07["position"];
  var_04.var_0117 = "none";
  var_04.var_00D4 = param_00;
  var_04.var_001D = param_02;
  var_04.var_2AC6 = param_03;
  var_04.var_776E = func_8FA8(var_04.var_0116);
  return var_04;
}

func_33C8(param_00, param_01, param_02) {
  level endon(param_02);
  var_03 = anglesToForward(param_00.var_001D);
  level thread maps\mp\_utility::func_33C0(param_00.var_0116, param_00.var_0116 + var_03 * 50, param_01, param_02);
  param_00.var_2AD0 = 1;
  wait 0.05;
}

func_43F3(param_00) {
  if(isDefined(param_00.var_001D)) {
    return anglesToForward(param_00.var_001D);
  }

  var_01 = func_434B(0);
  var_02 = var_01["axis"] - var_01["allies"];
  var_02 = (var_02[0], var_02[1], 0);
  return vectornormalize(var_02);
}

func_10D9() {
  var_00 = lib_050D::func_448A();
  foreach(var_02 in var_00) {
    var_02.var_9849 = undefined;
  }

  var_04 = func_4484();
  var_04.var_2F0C = func_43F3(var_04);
  var_05 = 9;
  var_06 = func_459F(var_04, 24, level.var_AC8B * 3, 0);
  foreach(var_02 in var_06) {
    var_08 = vectornormalize(var_04.var_0116 - var_02.var_0116);
    var_02.var_32B1 = vectordot(var_08, var_04.var_2F0C);
  }

  var_06 = common_scripts\utility::func_7897(var_06, ::func_9FBD);
  var_0A["allies"] = 0;
  var_0A["axis"] = 0;
  for(var_0B = 0; var_0B < var_06.size; var_0B++) {
    var_0C = int(var_0B / 2);
    var_0D = "axis";
    if(var_0B % 2 == 1) {
      var_0C = var_06.size - int(var_0B + 1 / 2);
      var_0D = "allies";
    }

    var_0E = undefined;
    var_02 = var_06[var_0C];
    if(var_0A[var_0D] < var_05) {
      var_0E = var_0D;
    } else if(var_02.var_32B1 > 0) {
      var_0E = "allies";
    } else {
      var_0E = "axis";
    }

    if(isDefined(var_0E)) {
      var_02.var_9849 = var_0E;
      var_02.var_984B = var_0A[var_0E];
      var_0A[var_0E]++;
    }
  }

  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_9849)) {
      var_02.var_984A = var_0A[var_02.var_9849];
    }
  }
}

func_9FBB(param_00, param_01) {
  var_02 = lib_050D::func_5770();
  var_03 = -1;
  if(var_02) {
    var_03 = getpathdist(param_00, param_01, 999999);
  }

  if(var_03 == -1) {
    var_03 = distance(param_00, param_01);
  }

  return var_03;
}

func_459F(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_04 = lib_050D::func_5770();
  var_05 = lib_050D::func_44F9();
  foreach(var_07 in var_05) {
    var_07.var_3018 = -1;
    if(var_04) {
      var_07.var_3018 = getpathdist(var_07.var_0116, param_00.var_0116, 999999);
    }

    if(var_07.var_3018 == -1) {
      var_07.var_3018 = distance(param_00.var_0116, var_07.var_0116);
    }
  }

  var_05 = common_scripts\utility::func_7897(var_05, ::func_9FBC);
  var_09 = maps\mp\_utility::func_4571();
  var_0A = game["status"] == "overtime";
  var_0B = param_00.var_00D4;
  if(var_0A) {
    var_0B = var_0B + 1;
  }

  var_0C = [];
  for(var_0D = 0; var_0D < var_05.size && var_0C.size < param_01; var_0D++) {
    var_07 = var_05[var_0D];
    if(var_07.var_3018 < param_02) {
      continue;
    }

    switch (var_09) {
      case "mp_instinct":
        if(var_0B == 0) {
          if(var_07.var_00D4 == 1) {
            break;
          }
        } else if(var_0B == 1) {
          if(var_07.var_00D4 == 14) {
            break;
          }
        } else if(var_0B == 3) {
          if(var_07.var_00D4 == 16) {
            break;
          }
        } else if(var_0B == 4) {
          if(var_07.var_00D4 == 16) {
            break;
          }
        }
        break;
    }

    var_0C[var_0C.size] = var_07;
  }

  return var_0C;
}

func_9FBD(param_00, param_01) {
  return param_00.var_32B1 <= param_01.var_32B1;
}

func_9FBC(param_00, param_01) {
  return param_00.var_3018 <= param_01.var_3018;
}

func_45A1(param_00) {
  var_01 = lib_050D::func_5770();
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in level.var_9FC2) {
    var_06 = undefined;
    if(var_01) {
      var_06 = getpathdist(param_00.var_0116, var_05.var_0116, 999999);
    }

    if(!isDefined(var_06) || var_06 == -1) {
      var_06 = distance(var_05.var_0116, param_00.var_0116);
    }

    if(!isDefined(var_02) || var_06 < var_03) {
      var_02 = var_05;
      var_03 = var_06;
    }
  }

  return var_02;
}

func_6BA7() {
  self.var_6219 = 0;
}

func_A139() {
  level endon("game_ended");
  while(!isDefined(level.var_0A4E)) {
    wait 0.05;
  }

  maps\mp\_utility::func_3FA5("prematch_done");
  var_00 = getdvarint("scr_twar_minionsmax", 18);
  if(var_00 <= 0) {
    return;
  }

  func_A0B1();
  var_01 = ["allies", "axis"];
  var_02 = getdvarfloat("scr_twar_minionspawndelay", 10);
  var_03 = [];
  var_04 = undefined;
  var_05 = undefined;
  var_06 = getdvarint("scr_twar_minionspawnhud", 0);
  if(var_06 > 0) {
    var_04 = func_6218();
    var_04 func_4F67();
    if(var_06 > 1) {
      var_05 = func_6217();
      foreach(var_08 in var_01) {
        foreach(var_0A in var_01) {
          var_03[var_08][var_0A] = func_6215(var_08, var_0A);
        }
      }
    }
  }

  while(!level.var_3F9D) {
    if(isDefined(var_04)) {
      var_04 settimer(var_02);
    }

    wait(var_02);
    maps\mp\gametypes\_hostmigration::func_A782();
    var_0D = func_4588();
    var_0E = level.var_6878 - 1;
    if(var_0D + var_0E < var_00) {
      var_0F = [];
      foreach(var_11 in var_01) {
        var_0F[var_11] = 0;
      }

      foreach(var_14 in level.var_9FC2) {
        var_11 = var_14.var_0117;
        if(var_11 != "allies" && var_11 != "axis") {
          continue;
        }

        var_15 = undefined;
        var_16 = undefined;
        var_17 = [[level.var_0A4D]]("player", var_11, "minion", var_15, var_16, undefined, 0, 0, "recruit");
        if(isDefined(var_17)) {
          var_17 takeallweapons();
          var_18 = getdvarint("scr_twar_minionweapon", 0);
          var_19 = "";
          switch (var_18) {
            case 2:
              var_19 = "thompson_mp";
              break;

            case 1:
              var_19 = "m1garand_mp";
              break;

            case 0:
            default:
              var_19 = "m1919_mp";
              break;
          }

          var_17 maps\mp\_utility::func_0642(var_19);
          var_17 switchtoweaponimmediate(var_19);
          var_17 maps\mp\_utility::func_47A2("specialty_minion");
          var_17.agentspeedscale = getdvarfloat("scr_twar_minionmovespeedscale", 0.85);
          var_17.var_29AA = getdvarfloat("scr_twar_miniondamagescale", 0.5);
          var_17.var_0009 = &"MP_MINION";
          var_17.var_672C = 1;
          var_17 thread func_6214();
          func_A0B1();
          var_17 detachall();
          var_17 setModel("kva_hazmat_body_infected_mp");
          var_17 attach("kva_hazmat_head_infected");
          var_17 method_83E1("cloth");
          var_1A = getdvarfloat("scr_twar_minionhealthscale", 0.75);
          var_17 maps\mp\agents\_agent_common::func_83FD(int(var_17.var_00BC * var_1A));
          var_0F[var_11]++;
        }
      }

      foreach(var_1D in var_03) {
        foreach(var_0A, var_1F in var_1D) {
          var_1F func_4F67();
          var_1F setvalue(var_0F[var_0A]);
          var_1F maps\mp\_utility::func_2CED(3, ::func_4F66);
        }
      }

      continue;
    }

    if(isDefined(var_05)) {
      var_05 func_4F67();
      var_05 maps\mp\_utility::func_2CED(3, ::func_4F66);
    }
  }
}

func_55B9() {
  return self hasperk("specialty_minion", 1);
}

func_4F67() {
  self.var_0018 = 1;
}

func_4F66() {
  self.var_0018 = 0;
}

func_6217() {
  var_00 = maps\mp\gametypes\_hud_util::func_2829("hudbig", 1);
  var_00 maps\mp\gametypes\_hud_util::func_8707("BOTTOM", undefined, 0, -20);
  var_00.var_00E5 = &"MP_DOMAI_MINIONS_SPAWNED_MAX";
  var_00.var_0056 = (1, 0, 0);
  var_00.var_001F = 1;
  var_00.var_0180 = 1;
  var_00.var_0018 = 0;
  return var_00;
}

func_6215(param_00, param_01) {
  var_02 = maps\mp\gametypes\_hud_util::func_2829("hudbig", 1, param_00);
  var_02 maps\mp\gametypes\_hud_util::func_8707("BOTTOM", undefined, 0, common_scripts\utility::func_98E7(param_00 == param_01, -40, -20));
  var_02.var_00E5 = common_scripts\utility::func_98E7(param_00 == param_01, &"MP_DOMAI_MINIONS_SPAWNED_FRIENDLY", &"MP_DOMAI_MINIONS_SPAWNED_ENEMY");
  var_02.var_0056 = common_scripts\utility::func_98E7(param_00 == param_01, (0.157, 0.392, 0.784), (0.784, 0.49, 0.157));
  var_02.var_001F = 1;
  var_02.var_0180 = 1;
  var_02.var_0018 = 0;
  return var_02;
}

func_6218() {
  var_00 = maps\mp\gametypes\_hud_util::func_282B("hudbig", 1);
  var_00 maps\mp\gametypes\_hud_util::func_8707("BOTTOM", undefined, 0, -60);
  var_00.var_00E5 = &"MP_DOMAI_MINIONS_SPAWN_TIMER";
  var_00.var_0056 = (1, 1, 1);
  var_00.var_001F = 1;
  var_00.var_0180 = 1;
  return var_00;
}

func_A0B1() {
  var_00 = [];
  var_01 = [];
  var_02 = getdvarint("scr_twar_minionoutline", 0);
  foreach(var_04 in level.var_744A) {
    if(var_04.var_01A7 == "allies") {
      var_00[var_00.size] = var_04;
      continue;
    }

    var_01[var_01.size] = var_04;
  }

  foreach(var_07 in level.var_0A4E) {
    if(var_07 func_55B9()) {
      if(level.var_744A.size > 0) {
        var_07 hudoutlinedisableforclients(level.var_744A);
      }

      if(var_02) {
        if(var_00.size > 0) {
          var_07 hudoutlineenableforclients(var_00, common_scripts\utility::func_98E7(var_07.var_01A7 == "allies", 2, 3), 1);
        }

        if(var_01.size > 0) {
          var_07 hudoutlineenableforclients(var_01, common_scripts\utility::func_98E7(var_07.var_01A7 == "axis", 2, 3), 1);
        }
      }
    }
  }
}

func_6214() {
  self endon("death");
  for(;;) {
    if(isDefined(level.var_9FC0)) {
      var_00 = level.var_9FC0.var_9D65.var_0116;
      self botsetscriptgoal(var_00, level.var_AC8B * 0.9, "objective");
    }

    wait(0.1);
  }
}

func_4588() {
  var_00 = 0;
  foreach(var_02 in level.var_0A4E) {
    if(isDefined(var_02.var_565F) && var_02.var_565F && var_02.var_0A4B == "player" && var_02 func_55B9()) {
      var_00++;
    }
  }

  return var_00;
}

func_6216(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_02) && isDefined(param_02.var_29AA)) {
    param_03 = int(param_03 * param_02.var_29AA);
  }

  return param_03;
}

func_6AA5(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isPlayer(param_01) && func_55B9() && param_01.var_01A7 != self.var_01A7) {
    var_09 = getdvarfloat("scr_twar_score_kill_minion_multipler", 0);
    if(var_09 > 0) {
      var_0A = getdvarfloat("scr_twar_score_kill_minion_base", 10);
      var_0B = int(param_01.var_6219 * var_09 + var_0A);
      var_0B = min(var_0B, getdvarint("scr_twar_score_kill_minion_max", 150));
      setDvar("scr_twar_score_kill_minion", var_0B);
    }

    param_01.var_6219++;
    level thread maps\mp\gametypes\_rank::func_1457("kill_minion", param_01, param_04, self, param_03);
    if(isDefined(param_01)) {
      func_093C(param_01.var_01A7);
    }

    if(isDefined(self.var_01A7)) {
      func_093E(self.var_01A7);
    }
  }
}

func_093C(param_00) {
  var_01 = getdvarfloat("scr_twar_momentum_kill_enemy_minion", 0.1);
  func_0941(param_00, var_01);
}

func_093E(param_00) {
  var_01 = getdvarfloat("scr_twar_momentum_kill_friendly_minion", -0.1);
  func_0941(param_00, var_01);
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isPlayer(param_01)) {
    return;
  }

  if(maps\mp\gametypes\_damage::func_56FA(self, param_01)) {
    return;
  }

  if(param_01 == self) {
    return;
  }

  var_0A = 0;
  var_0B = self;
  foreach(var_0D in param_01.var_9AC5) {
    if(var_0D != level.var_9FC0.var_9D65) {
      continue;
    }

    param_01 thread maps\mp\_events::func_5A82(var_0B, param_09, param_04);
    var_0A = 1;
    break;
  }

  if(!var_0A) {
    foreach(var_0D in var_0B.var_9AC5) {
      if(var_0D != level.var_9FC0.var_9D65) {
        continue;
      }

      param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
      param_01 thread maps\mp\_events::func_10BA(self, param_09, param_04);
    }
  }
}