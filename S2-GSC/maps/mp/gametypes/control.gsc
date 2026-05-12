/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\control.gsc
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
    maps\mp\_utility::func_7BFA(level.var_3FDC, 30);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 100);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 0);
    maps\mp\_utility::func_7C04(level.var_3FDC, 2);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_873B(1);
  level.var_0C27 = 0;
  level.var_6BAF = ::func_6BAF;
  level.var_6B7B = ::func_6B7B;
  level.var_6BA7 = ::func_6BA7;
  level.var_260B = gettime();
  level.var_2606 = 5;
  level.var_0BDB["axis"]["time"] = 0;
  level.var_0BDB["axis"]["awarded"] = 0;
  level.var_0BDB["allies"]["time"] = 0;
  level.var_0BDB["allies"]["awarded"] = 0;
  level.var_0BF4 = [];
  level.var_147A = [];
  level.var_3208 = spawnStruct();
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "dom_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";
  level.var_501B = "waypoint_captureneutral";
  level.var_501A = "waypoint_captureneutral";
  level.var_5004 = "waypoint_capture";
  level.var_5003 = "waypoint_capture";
  level.var_500B = "waypoint_defend";
  level.var_500A = "waypoint_defend";
  level.var_5008 = "waypoint_contested";
  level.var_5007 = "waypoint_contested";
  level.var_5025 = "waypoint_taking";
  level.var_5026 = "waypoint_taking";
  level.var_5016 = "waypoint_losing";
  level.var_5017 = "waypoint_losing";
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_control_roundlimit", 0);
  maps\mp\_utility::func_7BF7("control", 0);
  setdynamicdvar("scr_control_winlimit", 2);
  maps\mp\_utility::func_7C04("control", 1);
  setdynamicdvar("scr_control_halftime", 0);
  maps\mp\_utility::func_7BE5("control", 0);
  setdynamicdvar("scr_dom_allowNeutral", 0);
  setdynamicdvar("scr_dom_halftimeswitchsides", 0);
}

func_6BAF() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  if(game["status"] == "halftime") {
    setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    setomnvar("ui_current_round", 4);
  }

  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_DOM");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_DOM");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DOM");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DOM");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DOM_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DOM_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_DOM_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_DOM_HINT");
  setclientnamemode("auto_change");
  func_5353();
  func_7651();
  var_02[0] = "control";
  maps\mp\gametypes\_gameobjects::func_00F9(var_02);
  setomnvar("ui_broadcaster_game_mode_status_1", 0);
  setomnvar("ui_broadcaster_game_mode_status_2", 0);
  setomnvar("ui_broadcaster_game_mode_status_3", 0);
  level thread func_3211();
  level thread func_A109();
  level thread func_A160();
  level.var_4958 = maps\mp\_utility::func_3517("halftimeswitchsides", 1, 0, 1);
  level.var_0C27 = maps\mp\_utility::func_3517("allowNeutral", 0, 0, 1);
}

func_A160() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_A0F1();
    var_00 thread func_A108();
  }
}

func_A0F1() {
  waittillframeend;
  maps\mp\_utility::func_867B(self.var_012C["captures"]);
}

func_A108() {
  waittillframeend;
  maps\mp\_utility::func_867C(self.var_012C["defends"]);
}

func_A0EA() {
  level endon("game_ended");
  for(;;) {
    foreach(var_01 in level.var_744A) {
      var_01.var_0112 = 0;
      foreach(var_03 in level.var_3211) {
        if(var_01 istouching(var_03.var_5CBA)) {
          if(var_03.var_689F["axis"] * var_03.var_689F["allies"] > 0) {
            var_01.var_0112 = 1;
          } else if(var_03.var_6DB2 == "neutral") {
            if(var_01.var_01A7 == "allies") {
              var_01.var_0112 = 2;
            } else {
              var_01.var_0112 = 3;
            }
          } else if(var_03.var_6DB2 == "allies") {
            if(var_01.var_01A7 == "allies") {
              var_01.var_0112 = 4;
            } else {
              var_01.var_0112 = 5;
            }
          } else if(var_03.var_6DB2 == "axis") {
            if(var_01.var_01A7 == "axis") {
              var_01.var_0112 = 6;
            } else {
              var_01.var_0112 = 7;
            }
          }

          if(var_01.var_0112 > 0) {
            if(var_03.var_00E5 == "_b") {
              var_01.var_0112 = var_01.var_0112 + 7;
              continue;
            }

            if(var_03.var_00E5 == "_c") {
              var_01.var_0112 = var_01.var_0112 + 14;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

func_7651() {
  game["neutral"] = "neutral";
  level.var_188C[getmapcustom("allieschar")]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level.var_188C[getmapcustom("allieschar")]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level.var_188C[getmapcustom("axischar")]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level.var_188C[getmapcustom("axischar")]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level.var_188C["neutral"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom_white");
  level.var_188C["neutral"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_white");
}

func_5353() {
  lib_050D::func_10E4();
}

func_46C8(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_3211) {
    if(var_03.var_6DB2 == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

func_454E() {
  return "_c";
}

func_45DB() {
  return "_b";
}

func_3211() {
  level.var_5BFF["allies"] = 0;
  level.var_5BFF["axis"] = 0;
  var_00 = 1;
  var_01 = getEntArray("control_zone", "targetname");
  foreach(var_03 in var_01) {
    var_03.var_ACB1 = getent(var_03.var_01A2, "targetname");
    var_03.var_ACB1 method_805C();
  }

  if(!isDefined(game["controlPointOrder"])) {
    game["controlPointOrder"] = ["_a", "_b", "_c"];
    game["controlPointOrder"] = common_scripts\utility::func_0F92(game["controlPointOrder"]);
    game["controlRoundNum"] = 0;
  }

  for(var_05 = 0; var_05 < var_01.size; var_05++) {
    if(var_01[var_05].var_81E8 == game["controlPointOrder"][game["controlRoundNum"]]) {
      level.var_2609 = var_01[var_05];
      level.var_AC7C = level.var_2609;
      break;
    }
  }

  game["controlRoundNum"]++;
  level.var_3211 = [];
  var_06[0] = getent(level.var_2609.var_ACB1.var_01A2, "targetname");
  var_06[1] = getent(var_06[0].var_01A2, "targetname");
  var_06[1] scriptmodelplayanim("ctf_flag_flap");
  var_06[0].var_0116 = var_06[0].var_0116 + (0, 0, -10000);
  var_06[1].var_0116 = var_06[1].var_0116 + (0, 0, -10000);
  level.var_2609.var_ACB1 method_805B();
  var_07 = maps\mp\gametypes\_gameobjects::func_2837("neutral", level.var_2609, var_06, (0, 0, 0));
  var_07 maps\mp\gametypes\_gameobjects::func_8A5A(level.var_2606);
  var_07 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_SECURING_POSITION");
  var_08 = var_07 maps\mp\gametypes\_gameobjects::func_454C();
  var_07.var_00E5 = var_08;
  var_07 maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_500A);
  var_07 maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_500B);
  var_07 maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_501A);
  var_07 maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_501B);
  var_07 maps\mp\gametypes\_gameobjects::func_860A("broadcaster", "waypoint_esports_dom_white" + var_08);
  var_07 maps\mp\gametypes\_gameobjects::func_860E("broadcaster", "waypoint_esports_dom_white" + var_08, 3);
  var_07 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_07.var_6BBF = ::func_6BBF;
  var_07.var_6ABC = ::func_6ABC;
  var_07.var_6BCB = ::func_6BCB;
  var_07.var_6AFA = ::func_6AFA;
  var_07.var_681A = 1;
  var_07.var_502A = "domFlag";
  var_07.var_4B25 = 0;
  var_07.var_3C66 = 1;
  var_09 = var_06[0].var_0116 + (0, 0, 32);
  var_0A = var_06[0].var_0116 + (0, 0, -32);
  var_0B = bulletTrace(var_09, var_0A, 0, var_06[0]);
  var_0C = vectortoangles(var_0B["normal"]);
  var_07.var_15F9 = anglesToForward(var_0C);
  var_07.var_15FB = anglestoright(var_0C);
  var_07.var_15FA = var_0B["position"];
  var_06[0].var_0116 = var_0B["position"];
  var_07 thread func_A192(1);
  level.var_2609.var_A222 = var_07;
  var_07.var_5CBA = level.var_2609;
  level.var_3211[level.var_3211.size] = var_07;
  var_0D = lib_050D::func_46A0("axis");
  var_0E = lib_050D::func_46A0("allies");
  level.var_92FA["allies"] = var_0E[0].var_0116;
  level.var_92FA["axis"] = var_0D[0].var_0116;
  func_3CC7();
  wait(1);
  var_0F = gettime();
  for(var_10 = 0; var_10 < level.var_3211.size; var_10++) {
    function_00F6(level.var_3211[var_10].var_A582[0].var_0116, "script_mp_captures: team %s, gameTime %d", "neutral", var_0F);
    function_00F6(level.var_3211[var_10].var_A582[0].var_0116, "script_mp_dom: gameTime %d, label %s, owner %s", var_0F, level.var_3211[var_10].var_00E5, level.var_3211[var_10].var_6DB2);
  }

  thread func_260A(var_07);
}

func_260A(param_00) {
  maps\mp\_utility::func_3FA5("prematch_done");
  setomnvar("ui_control_countdown_time", gettime() + 30000);
  maps\mp\gametypes\_hostmigration::func_A6F5(30);
  param_00 maps\mp\gametypes\_gameobjects::func_0C30("enemy");
  setomnvar("ui_control_countdown_time", 1);
  wait(2);
  setomnvar("ui_control_countdown_time", 0);
}

func_6ABC(param_00) {
  var_01 = maps\mp\gametypes\_gameobjects::func_45F7();
  self.var_2EE9 = 0;
  maps\mp\gametypes\_gameobjects::func_8A5A(level.var_2606);
  if(var_01 == "neutral") {
    func_933E("securing" + self.var_00E5, param_00.var_01A7);
    if(self.var_3C66 || self.var_28D5 == 0) {
      maps\mp\gametypes\_gameobjects::func_8A5A(level.var_2606);
    }

    return;
  }

  if(var_01 == "allies") {
    level.var_0BF4[level.var_0BF4.size] = self.var_00E5;
    var_02 = "axis";
    return;
  }

  level.var_147A[level.var_147A.size] = self.var_00E5;
  var_02 = "allies";
}

func_6BCB(param_00, param_01, param_02) {
  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  if(param_01 > 0.05 && param_02 && !self.var_2EE9) {
    if(var_03 == "neutral") {
      func_933E("securing" + self.var_00E5, param_00);
      if(param_00 == "allies") {
        maps\mp\gametypes\_gameobjects::func_860A("broadcaster", "waypoint_esports_dom_blue_taking" + self.var_00E5);
        maps\mp\gametypes\_gameobjects::func_860E("broadcaster", "waypoint_esports_dom_blue_taking" + self.var_00E5, 3);
      } else {
        maps\mp\gametypes\_gameobjects::func_860A("broadcaster", "waypoint_esports_dom_red_taking" + self.var_00E5);
        maps\mp\gametypes\_gameobjects::func_860E("broadcaster", "waypoint_esports_dom_red_taking" + self.var_00E5, 3);
      }
    } else {
      func_933E("losing" + self.var_00E5, var_03, 1);
      func_933E("securing" + self.var_00E5, param_00);
      if(var_03 == "allies") {
        maps\mp\gametypes\_gameobjects::func_860A("broadcaster", "waypoint_esports_dom_blue_losing" + self.var_00E5);
        maps\mp\gametypes\_gameobjects::func_860E("broadcaster", "waypoint_esports_dom_blue_losing" + self.var_00E5, 3);
      } else {
        maps\mp\gametypes\_gameobjects::func_860A("broadcaster", "waypoint_esports_dom_red_losing" + self.var_00E5);
        maps\mp\gametypes\_gameobjects::func_860E("broadcaster", "waypoint_esports_dom_red_losing" + self.var_00E5, 3);
      }
    }

    maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_5025);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5026);
    maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5016);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5017);
    self.var_2EE9 = 1;
    return;
  }

  if(level.var_0C27 && param_01 > 0.49 && param_02 && self.var_2EE9 && var_03 != "neutral") {
    var_04 = maps\mp\gametypes\_gameobjects::func_44AF();
    var_05 = gettime();
    function_00F6(self.var_A582[0].var_0116, "script_mp_captures: player_name %s, life_id %d, team %s, gameTime %d", var_04.var_0109, var_04.var_5CC6, "neutral", var_05);
    maps\mp\gametypes\_gameobjects::func_86EC("neutral");
    func_A192();
    func_933E("lost" + self.var_00E5, var_03, 1);
    level thread maps\mp\_utility::func_74D9("mp_obj_notify_pos_lrg", param_00);
    level thread maps\mp\_utility::func_74D9("mp_obj_notify_neg_lrg", var_03);
    func_A189(self.var_00E5, "neutral");
    thread func_4787(self.var_9AC3[param_00]);
  }
}

func_933E(param_00, param_01, param_02) {
  var_03 = gettime();
  if(gettime() < level.var_5BFF[param_01] + 5000 && !isDefined(param_02) || !param_02) {
    return;
  }

  thread func_2CDB(param_00, param_01);
  level.var_5BFF[param_01] = gettime();
}

func_6AFA(param_00, param_01, param_02) {
  if(isPlayer(param_01)) {
    param_01 setclientomnvar("ui_capture_icon", 0);
  }

  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  if(var_03 != "neutral") {
    maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_5003);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5004);
    maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_500A);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_500B);
  } else {
    maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_501A);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_501B);
    maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_501A);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_501B);
  }

  if(param_00 == "allies") {
    common_scripts\utility::func_0F93(level.var_0BF4, self.var_00E5);
    return;
  }

  common_scripts\utility::func_0F93(level.var_0BF4, self.var_00E5);
}

func_A192(param_00) {
  if(isDefined(param_00) && param_00) {
    waittillframeend;
  }

  if(!function_0279(self.var_A582[0])) {
    var_01 = self.var_A582[0];
    func_3EC2(var_01.var_0116, anglestoup(var_01.var_001D));
  }
}

func_3EC2(param_00, param_01) {
  var_02 = self.var_6DB2;
  if(var_02 == "allies") {
    self.var_A582[1] setModel("usa_ctf_flag_anim");
  } else if(var_02 == "axis") {
    self.var_A582[1] setModel("ger_ctf_flag_anim");
  }

  var_03 = gettime();
  function_00F6(self.var_A582[0].var_0116, "script_mp_dom: gameTime %d, label %s, owner %s", var_03, self.var_00E5, self.var_6DB2);
}

func_3EC3() {
  if(isDefined(self.var_3ED3)) {
    self.var_3ED3 delete();
  }

  if(isDefined(self.var_3EBE)) {
    self.var_3EBE delete();
  }

  if(isDefined(self.var_1C94)) {
    self.var_1C94 delete();
  }

  if(isDefined(self.var_1C90)) {
    self.var_1C90 delete();
  }

  if(isDefined(self.var_3768)) {
    self.var_3768 delete();
  }

  if(isDefined(self.var_3766)) {
    self.var_3766 delete();
  }
}

func_A189(param_00, param_01) {
  var_02 = "ui_broadcaster_game_mode_status_1";
  if(param_00 == "_b") {
    var_02 = "ui_broadcaster_game_mode_status_2";
  }

  if(param_00 == "_c") {
    var_02 = "ui_broadcaster_game_mode_status_3";
  }

  if(param_01 == "allies") {
    setomnvar(var_02, -1);
    return;
  }

  if(param_01 == "axis") {
    setomnvar(var_02, 1);
    return;
  }

  setomnvar(var_02, 0);
}

func_6BBF(param_00) {
  var_01 = gettime();
  var_02 = param_00.var_01A7;
  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  var_04 = 0;
  var_05 = 0;
  if(self.var_3C66 && self.var_00E5 == func_45DB()) {
    var_04 = 1;
  } else if(self.var_3C66 && self.var_00E5 != func_45DB()) {
    var_05 = 1;
  }

  self.var_1FC1 = gettime();
  self.var_3C66 = 0;
  self.var_4B25 = 1;
  if(isDefined(self.var_6DA9)) {
    self.var_6DA9 = 0;
  } else {
    self.var_6DA9 = 1;
  }

  function_00F6(self.var_A582[0].var_0116, "script_mp_captures: player_name %s, life_id %d, team %s, gameTime %d", param_00.var_0109, param_00.var_5CC6, var_02, var_01);
  maps\mp\gametypes\_gameobjects::func_86EC(var_02);
  maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_5003);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5004);
  maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_500A);
  maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_500B);
  func_A192();
  level.var_A239 = 0;
  if(var_03 == "neutral") {
    var_06 = maps\mp\_utility::func_45DE(var_02);
    func_933E("secured" + self.var_00E5, var_02, 1);
    func_933E("enemy_has" + self.var_00E5, var_06, 1);
    level thread maps\mp\_utility::func_74D9("mp_obj_notify_pos_lrg", var_02);
  } else {
    func_933E("secured" + self.var_00E5, var_02, 1);
    func_933E("lost" + self.var_00E5, var_03, 1);
    level thread maps\mp\_utility::func_74D9("mp_obj_notify_pos_lrg", var_02);
    level thread maps\mp\_utility::func_74D9("mp_obj_notify_neg_lrg", var_03);
    level.var_1731[var_03] = self.var_5CBA;
  }

  func_A189(self.var_00E5, var_02);
  param_00 thread maps\mp\_audio::func_8DAE("mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
  thread func_4786(self.var_9AC3[var_02], var_04, var_05);
}

func_4786(param_00, param_01, param_02) {
  level endon("game_ended");
  var_03 = maps\mp\gametypes\_gameobjects::func_44AF();
  if(isDefined(var_03.var_0117)) {
    var_03 = var_03.var_0117;
  }

  if(isPlayer(var_03)) {
    level thread maps\mp\_utility::func_9863("callout_securedposition" + self.var_00E5, var_03);
  }

  var_04 = getarraykeys(param_00);
  for(var_05 = 0; var_05 < var_04.size; var_05++) {
    var_03 = param_00[var_04[var_05]].var_721C;
    if(isDefined(var_03.var_0117)) {
      var_03 = var_03.var_0117;
    }

    if(!isPlayer(var_03)) {
      continue;
    }

    var_03 thread maps\mp\_events::func_320C(param_01, param_02);
    var_03 thread func_A101();
    wait 0.05;
  }
}

func_4787(param_00) {
  level endon("game_ended");
  var_01 = maps\mp\gametypes\_gameobjects::func_44AF();
  if(isDefined(var_01.var_0117)) {
    var_01 = var_01.var_0117;
  }

  if(isPlayer(var_01)) {
    level thread maps\mp\_utility::func_9863("callout_neutralized_position" + self.var_00E5, var_01);
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

    var_01 thread maps\mp\_events::func_3218();
    wait 0.05;
  }
}

func_2CDB(param_00, param_01) {
  level endon("game_ended");
  wait(0.1);
  maps\mp\_utility::func_A790();
  maps\mp\_utility::func_5C39(param_00, param_01);
}

func_2CDC(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  wait(0.1);
  maps\mp\_utility::func_A790();
  maps\mp\_utility::func_5C3E(param_00, param_01, param_02, param_03);
}

func_A109() {
  level endon("game_ended");
  while(!level.var_3F9D) {
    var_00 = func_45F5();
    if(var_00.size) {
      var_01 = undefined;
      var_02 = undefined;
      foreach(var_04 in var_00) {
        var_05 = var_04 maps\mp\gametypes\_gameobjects::func_45F7();
        maps\mp\gametypes\_gamescore::func_47BD(var_05, 1, 0);
        if(!isDefined(var_01) || var_01 < var_04.var_1FC1) {
          var_01 = var_04.var_1FC1;
        }

        if(!isDefined(var_02)) {
          var_02 = var_05;
        }

        if(var_02 != var_05) {
          var_02 = "none";
        }
      }

      if(level.var_3211.size == var_00.size && var_02 != "none" && level.var_744A.size > 5) {
        level.var_0BDB[var_02]["time"] = gettime() - var_01;
        level.var_0BDB[maps\mp\_utility::func_45DE(var_02)]["time"] = 0;
        if(level.var_0BDB[var_02]["time"] > -5536 && level.var_0BDB["axis"]["awarded"] == 0) {
          level.var_0BDB["axis"]["awarded"] = 1;
          foreach(var_08 in level.var_744A) {
            if(var_08.var_01A7 != var_02) {
              continue;
            }

            var_08 maps\mp\gametypes\_missions::func_7750("ch_dom_tripcap");
          }
        }
      } else {
        level.var_0BDB["axis"]["time"] = 0;
        level.var_0BDB["allies"]["time"] = 0;
      }
    }

    var_02 = 1;
    var_03 = func_454E();
    foreach(var_05 in level.var_3211) {
      if((var_05.var_00E5 == "_a" || var_05.var_00E5 == var_03) && var_05.var_4B25 == 0) {
        var_02 = 0;
        break;
      }
    }

    if(maps\mp\_utility::func_602B() && !level.var_0C27 && !var_02 && func_4473() > 120000 && !getdvarint("850")) {
      level.var_3B5C = "none";
      thread maps\mp\gametypes\_gamelogic::func_36B9("none", game["end_reason"]["time_limit_reached"]);
      return;
    }

    thread maps\mp\gametypes\_gamelogic::func_21E3();
    wait(1.5);
    maps\mp\gametypes\_hostmigration::func_A782();
  }
}

func_4473() {
  return gettime() - level.var_260B;
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
    var_0E = 0;
    if(var_0D == level.var_2609) {
      var_0E = 1;
      break;
    }

    if(!var_0E) {
      continue;
    }

    var_0F = var_0D.var_A222.var_6DB2;
    if(param_01.var_01A7 != var_0F) {
      param_01 thread maps\mp\_events::func_5A82(var_0B, param_09, param_04);
      var_0A = 1;
    }
  }

  var_11 = 90000;
  var_0F = level.var_2609.var_A222.var_6DB2;
  var_12 = distancesquared(level.var_2609.var_0116, var_0B.var_0116);
  var_13 = distancesquared(level.var_2609.var_0116, param_01.var_0116);
  if(var_12 < var_11) {
    param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
  }

  if(var_0F == param_01.var_01A7) {
    if(var_12 < var_11 || var_13 < var_11) {
      param_01 thread maps\mp\_events::func_2C80(var_0B, param_09, param_04);
      param_01 maps\mp\_utility::func_867C(param_01.var_012C["defends"]);
    }
  }

  if(var_0A) {
    return;
  }

  if(var_0F == var_0B.var_01A7) {
    if(var_13 < var_11 || var_12 < var_11) {
      param_01 thread maps\mp\_events::func_10BA(self, param_09, param_04);
    }
  }
}

func_45F5() {
  var_00 = [];
  foreach(var_02 in level.var_3211) {
    if(var_02 maps\mp\gametypes\_gameobjects::func_45F7() != "neutral" && isDefined(var_02.var_1FC1)) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

func_46CC(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.var_3211.size; var_02++) {
    if(level.var_3211[var_02] maps\mp\gametypes\_gameobjects::func_45F7() == param_00) {
      var_01++;
    }
  }

  return var_01;
}

func_44E3() {
  return self.var_A222 maps\mp\gametypes\_gameobjects::func_45F7();
}

func_3CC7() {
  var_00 = lib_050D::func_448A();
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_0165) && issubstr(var_02.var_0165, "_override")) {
      var_02.var_766F = "_" + getsubstr(var_02.var_0165, 0, 1);
      continue;
    }

    var_02.var_663E = func_459D(var_02);
    var_02.var_766F = var_02.var_663E.var_A222.var_00E5;
  }
}

func_459D(param_00) {
  var_01 = lib_050D::func_5770();
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in level.var_3211) {
    var_06 = undefined;
    if(var_01) {
      var_06 = getpathdist(param_00.var_0116, var_05.var_5CBA.var_0116, 999999);
    }

    if(!isDefined(var_06) || var_06 == -1) {
      var_06 = distancesquared(var_05.var_5CBA.var_0116, param_00.var_0116);
    }

    if(!isDefined(var_02) || var_06 < var_03) {
      var_02 = var_05;
      var_03 = var_06;
    }
  }

  return var_02.var_5CBA;
}

func_6BA7() {}

func_A101() {
  if(!isDefined(self.var_270D)) {
    self.var_6885 = 0;
    self.var_270D = 0;
  }

  self.var_6885++;
  if(maps\mp\_utility::func_4589() < 1) {
    return;
  }

  self.var_270D = self.var_6885 / maps\mp\_utility::func_4589();
}

func_444A() {
  if(self.var_270D < 4) {
    return 1;
  }

  return 0.25;
}