/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\ctf.gsc
*********************************************/

func_00F9() {
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BFA(level.var_3FDC, 5);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 3);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_86EB(5);
  if(isDefined(game["round_time_to_beat"])) {
    maps\mp\_utility::func_86EB(game["round_time_to_beat"]);
    game["round_time_to_beat"] = undefined;
  }

  func_872E();
  level.var_80A8 = 1;
  maps\mp\_utility::func_873B(1);
  level.var_6933 = 1;
  level.var_6CD1 = 1;
  level.var_6B54 = 1;
  level.var_6FEF = maps\mp\_utility::func_4529("scr_ping_carrier", 1);
  level.var_AA24 = maps\mp\_utility::func_4529("scr_ctf_win_by_captures", 0);
  level.var_6BAF = ::func_6BAF;
  level.var_6B7B = ::func_6B7B;
  level.var_6BB6 = ::func_6BB6;
  level.var_6B42 = ::func_6B42;
  if(!isDefined(game["shut_out"])) {
    game["shut_out"]["axis"] = 1;
    game["shut_out"]["allies"] = 1;
  }

  if(level.var_AA24) {
    setdynamicdvar("scr_ctf_scorelimit", 0);
  }

  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  level.var_3CC4 = maps\mp\_utility::func_4529("scr_ctf_returntime", 30);
  game["dialog"]["gametype"] = "ctf_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";
  thread func_6B6C();
  if(!isDefined(game["allies_side_caps"])) {
    game["allies_side_caps"] = 0;
  }

  if(!isDefined(game["axis_side_caps"])) {
    game["axis_side_caps"] = 0;
  }

  if(!isDefined(game["allies_side_pickups"])) {
    game["allies_side_pickups"] = 0;
  }

  if(!isDefined(game["axis_side_pickups"])) {
    game["axis_side_pickups"] = 0;
  }
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_ctf_roundlimit", 2);
  maps\mp\_utility::func_7BF7("ctf", 1);
  setdynamicdvar("scr_ctf_winlimit", 1);
  maps\mp\_utility::func_7C04("ctf", 1);
  setdynamicdvar("scr_ctf_halftime", 1);
  maps\mp\_utility::func_7BE5("ctf", 1);
  setdynamicdvar("scr_ctf_returntime", getmatchrulesdata("ctfData", "returnTime"));
  setdynamicdvar("scr_ping_carrier", getmatchrulesdata("ctfData", "enemyCarrierIcon"));
  setdynamicdvar("scr_ctf_win_by_captures", getmatchrulesdata("ctfData", "winByCaptures"));
  setdynamicdvar("scr_ctf_flag_pick_up_time_friendly", getmatchrulesdata("ctfData", "pickupTime"));
  setdynamicdvar("scr_ctf_flag_pick_up_time_enemy", getmatchrulesdata("ctfData", "pickupTime"));
  setdynamicdvar("scr_ctf_extratime", getmatchrulesdata("ctfData", "extraTime"));
}

func_6BAF() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(maps\mp\_utility::func_576C(game["status"])) {
    game["switchedsides"] = !game["switchedsides"];
  }

  if(game["status"] == "halftime") {
    setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    setomnvar("ui_current_round", 4);
  }

  if(!isDefined(game["original_defenders"])) {
    game["original_defenders"] = game["defenders"];
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  if(!level.var_AA24) {
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
  }

  setclientnamemode("auto_change");
  var_02 = getmapcustom("allieschar");
  if(!isDefined(var_02) || var_02 == "") {
    var_02 = "allies";
  }

  var_03 = getmapcustom("axischar");
  if(!isDefined(var_03) || var_03 == "") {
    var_03 = "axis";
  }

  level.var_3CB5[var_02][0] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level.var_3CB5[var_02][1] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level.var_3CB5[var_02][2] = loadfx("vfx/unique/vfx_marker_ctf_allies_blue");
  level.var_3CB5[var_02][3] = loadfx("vfx/unique/vfx_marker_ctf_allies_blue");
  level.var_3CB5[var_02][4] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level.var_3CB5[var_03][0] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");
  level.var_3CB5[var_03][1] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");
  level.var_3CB5[var_03][2] = loadfx("vfx/unique/vfx_marker_ctf_axis_blue");
  level.var_3CB5[var_03][3] = loadfx("vfx/unique/vfx_marker_ctf_axis_blue");
  level.var_3CB5[var_03][4] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    maps\mp\_utility::func_86DB(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    maps\mp\_utility::func_86DB(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    maps\mp\_utility::func_86DB(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  maps\mp\_utility::func_86DC(game["attackers"], &"OBJECTIVES_CTF");
  maps\mp\_utility::func_86DC(game["defenders"], &"OBJECTIVES_CTF");
  maps\mp\_utility::func_86D8(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  maps\mp\_utility::func_86D8(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  var_04[0] = "ctf";
  var_04[1] = "blocker_ctf";
  maps\mp\gametypes\_gameobjects::func_00F9(var_04);
  level.var_3992 = maps\mp\_utility::func_3517("extraTime", maps\mp\_utility::func_4529("scr_ctf_extratime", 1), 0, 3);
  level.var_289F = 0;
  level thread func_2896();
  level thread func_A15F();
}

func_A15F() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_A0F1();
    var_00 thread func_A15B();
    var_00 thread func_A108();
  }
}

func_A0F1() {
  waittillframeend;
  maps\mp\_utility::func_867B(self.var_012C["captures"]);
}

func_A15B() {
  waittillframeend;
  self.var_0021 = self.var_012C["returns"];
}

func_A108() {
  waittillframeend;
  maps\mp\_utility::func_867C(self.var_012C["defends"]);
}

func_2896() {
  level.var_3CBF["allies"]["allies"] = "usa_ctf_flag_physics_placed";
  level.var_3CBF["allies"]["axis"] = "usa_ctf_flag_physics_placed_red";
  level.var_2013["allies"]["allies"] = spawn("script_model", (0, 0, 0));
  level.var_2013["allies"]["allies"] setModel("usa_ctf_flag_physics_attach");
  level.var_2013["allies"]["axis"] = spawn("script_model", (0, 0, 0));
  level.var_2013["allies"]["axis"] setModel("usa_ctf_flag_physics_attach_red");
  level.var_2013["allies"]["allies"] method_805C();
  level.var_2013["allies"]["axis"] method_805C();
  level.var_3CBF["axis"]["axis"] = "ger_ctf_flag_physics_placed_blue";
  level.var_3CBF["axis"]["allies"] = "ger_ctf_flag_physics_placed";
  level.var_2013["axis"]["axis"] = spawn("script_model", (0, 0, 0));
  level.var_2013["axis"]["axis"] setModel("ger_ctf_flag_physics_attach_blue");
  level.var_2013["axis"]["allies"] = spawn("script_model", (0, 0, 0));
  level.var_2013["axis"]["allies"] setModel("ger_ctf_flag_physics_attach");
  level.var_2013["axis"]["axis"] method_805C();
  level.var_2013["axis"]["allies"] method_805C();
  level.var_5012 = "waypoint_escort_flag";
  level.var_5011 = "waypoint_escort_flag";
  level.var_5015 = "waypoint_kill";
  level.var_5014 = "waypoint_kill";
  level.var_4FFC = "waypoint_allies_flag_friendly";
  level.var_4FFB = "waypoint_allies_flag_friendly";
  level.var_4FFA = "waypoint_allies_flag_enemy";
  level.var_4FF9 = "waypoint_allies_flag_enemy";
  level.var_5002 = "waypoint_axis_flag_friendly";
  level.var_5001 = "waypoint_axis_flag_friendly";
  level.var_5000 = "waypoint_axis_flag_enemy";
  level.var_4FFF = "waypoint_axis_flag_enemy";
  level.var_5021 = "waypoint_return_flag";
  level.var_5020 = "waypoint_return_flag";
  level.var_5029 = "waypoint_waitfor_flag";
  level.var_5028 = "waypoint_waitfor_flag";
  level.var_4FFE = "waypoint_caster_flag_taken";
  level.var_500E = "waypoint_caster_flag_dropped";
  level.var_4FFD = "waypoint_caster_flag";
  level.var_5018 = "waypoint_caster_flag_missing";
  level.var_9853[game["defenders"]] = func_282E(game["defenders"], level.var_6C63["allies"]);
  level.var_9853[game["attackers"]] = func_282E(game["attackers"], "allies");
  level.var_1FC6[game["defenders"]] = func_27D2(game["defenders"], level.var_6C63["allies"]);
  level.var_1FC6[game["attackers"]] = func_27D2(game["attackers"], "allies");
  level.var_1FC6["allies"].var_487A = level.var_1FC6["allies"].var_28D4;
  level.var_1FC6["axis"].var_487A = level.var_1FC6["axis"].var_28D4;
  lib_050D::func_10E4();
  lib_050D::func_908D(level.var_1FC6["allies"], level.var_1FC6["axis"]);
  level thread func_289C();
  func_6B94("allies");
  func_6B94("axis");
}

func_289C() {
  level endon("game_ended");
  var_00 = level.var_9853["allies"];
  var_01 = level.var_9853["axis"];
  for(;;) {
    var_02 = gettime();
    var_03 = var_00.var_2006;
    var_04 = var_01.var_2006;
    var_05 = undefined;
    var_06 = undefined;
    if(!isDefined(var_03)) {
      var_07 = "none";
      var_05 = var_00.var_0116;
    } else {
      var_07 = var_03.var_0109;
      var_05 = var_03.var_0116;
    }

    if(!isDefined(var_04)) {
      var_08 = "none";
      var_06 = var_01.var_0116;
    } else {
      var_08 = var_04.var_0109;
      var_06 = var_04.var_0116;
    }

    function_00F5("script_mp_ctf: gameTime %d, allies_flag_loc %v, axis_flag_loc %v, allies_carrier %s, axis_carrier %s", var_02, var_05, var_06, var_07, var_08);
    wait(0.2);
  }
}

func_6B94(param_00) {
  if(param_00 == "allies") {
    level.var_0BF7 = 0;
    level.var_0BF6 = -1;
  } else {
    level.var_147E = 0;
    level.var_147D = -1;
  }

  level notify("update_flag_status");
}

func_6B64(param_00) {
  var_01 = param_00.var_012C["team"];
  if(var_01 == "allies") {
    param_00.var_0112 = 1;
    level.var_147E = 2;
    level.var_147D = param_00 getentitynumber();
  } else {
    param_00.var_0112 = 2;
    level.var_0BF7 = 2;
    level.var_0BF6 = param_00 getentitynumber();
  }

  level notify("update_flag_status");
}

func_6AF0(param_00) {
  if(param_00 == "allies") {
    level.var_0BF7 = 1;
    level.var_0BF6 = -1;
  } else {
    level.var_147E = 1;
    level.var_147D = -1;
  }

  level notify("update_flag_status");
}

func_7482() {
  if(!isDefined(self.var_01A7) || !isDefined(level.var_0BF7)) {
    return;
  }

  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  setomnvar("ui_broadcaster_ctf_allies_status", level.var_0BF7);
  setomnvar("ui_broadcaster_ctf_allies_carrier_clientnum", level.var_0BF6);
  setomnvar("ui_broadcaster_ctf_axis_status", level.var_147E);
  setomnvar("ui_broadcaster_ctf_axis_carrier_clientnum", level.var_147D);
  if(self.var_01A7 == "allies" || self.var_01A7 == "spectator") {
    var_00 = level.var_0BF7;
    var_01 = level.var_0BF6;
    var_02 = level.var_147E;
    var_03 = level.var_147D;
  } else if(self.var_01A7 == "axis") {
    var_00 = level.var_147E;
    var_01 = level.var_147D;
    var_02 = level.var_0BF7;
    var_03 = level.var_0BF6;
  } else {
    return;
  }

  self setclientomnvar("ui_ctf_friendly_status", var_00);
  self setclientomnvar("ui_ctf_friendly_carrier_clientnum", var_01);
  self setclientomnvar("ui_ctf_enemy_status", var_02);
  self setclientomnvar("ui_ctf_enemy_carrier_clientnum", var_03);
  self setclientomnvar("ui_ctf_status_changed", 1);
}

func_7483() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("joined_team");
    func_7482();
  }
}

func_748E() {
  level endon("game_ended");
  self endon("disconnect");
  func_7482();
  thread func_7483();
  for(;;) {
    common_scripts\utility::func_A70C(level, "update_flag_status", self, "spawned_player");
    func_7482();
  }
}

func_4D0B(param_00) {
  level waittill("game_ended");
  if(isDefined(param_00)) {
    param_00.var_0018 = 0;
  }
}

func_282E(param_00, param_01) {
  var_02 = getent("ctf_zone_" + param_01, "targetname");
  if(!isDefined(var_02)) {
    common_scripts\utility::func_3809("No ctf_zone_" + param_01 + " trigger found in map.");
    return;
  }

  var_03[0] = getent("ctf_flag_" + param_01, "targetname");
  if(!isDefined(var_03[0])) {
    common_scripts\utility::func_3809("No ctf_flag_" + param_01 + " script_model found in map.");
    return;
  }

  var_04 = (0, 0, 0);
  if(param_01 == "allies") {
    if(isDefined(level.allies_ctf_flag_offset)) {
      var_04 = level.allies_ctf_flag_offset;
    }
  } else if(param_01 == "axis") {
    if(isDefined(level.axis_ctf_flag_offset)) {
      var_04 = level.axis_ctf_flag_offset;
    }
  }

  var_05 = spawn("trigger_radius", var_02.var_0116 + var_04, 0, 32, var_02.var_00BD);
  var_02 = var_05;
  var_03[0] setModel(level.var_3CBF[param_00][param_00]);
  var_03[0].var_6A55 = var_03[0] method_80B1();
  var_03[1] = spawn("script_model", var_03[0].var_0116);
  var_03[1] setModel(level.var_3CBF[param_00][maps\mp\_utility::func_45DE(param_00)]);
  var_03[1].var_6A55 = var_03[1] method_80B1();
  var_06 = var_03[0].var_0116 + (0, 0, 32) + var_04;
  var_07 = var_03[0].var_0116 + (0, 0, -32) + var_04;
  var_08 = bulletTrace(var_06, var_07, 0, undefined);
  var_03[0].var_0116 = var_08["position"];
  var_03[1].var_0116 = var_08["position"];
  var_03[1].var_001D = var_03[0].var_001D;
  var_09 = maps\mp\gametypes\_gameobjects::func_27D6(param_00, var_02, var_03, (0, 0, 85), 1, 0, 1);
  var_09 thread func_8BF8(param_00);
  var_0A = getdvarfloat("scr_ctf_flag_pick_up_time_friendly", 0);
  if(var_0A > 0) {
    var_09 maps\mp\gametypes\_gameobjects::func_8740("friendly", var_0A);
  }

  var_0B = getdvarfloat("scr_ctf_flag_pick_up_time_enemy", 0);
  if(var_0B > 0) {
    var_09 maps\mp\gametypes\_gameobjects::func_8740("enemy", var_0B);
  }

  var_09 maps\mp\gametypes\_gameobjects::func_873F("enemy", &"MP_GRABBING_FLAG");
  var_09 maps\mp\gametypes\_gameobjects::func_873F("friendly", &"MP_RETURNING_FLAG");
  var_09 maps\mp\gametypes\_gameobjects::func_0C1D("enemy");
  var_09 maps\mp\gametypes\_gameobjects::func_8A60("none");
  var_09 maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_5011);
  var_09 maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5012, undefined, 1);
  if(level.var_6FEF != 2) {
    var_09 maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5014);
    var_09 maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5015, undefined, 1);
  } else {
    var_09 maps\mp\gametypes\_gameobjects::func_860A("friendly", undefined);
    var_09 maps\mp\gametypes\_gameobjects::func_860E("friendly", undefined);
  }

  var_09.var_6990 = 1;
  var_09.var_0C33 = 1;
  var_09.var_7D25 = 1;
  var_09.var_6B62 = ::func_6B62;
  var_09.var_6B63 = ::func_6B62;
  var_09.var_6AEF = ::func_6AEF;
  var_09.var_6B93 = ::func_6B93;
  var_09.var_6A68 = var_02.var_014F;
  var_09.var_0116 = var_02.var_0116;
  if(level.var_6FEF == 0) {
    var_09.var_6990 = 0;
  }

  if(param_00 == "axis") {
    maps\mp\_utility::func_863F(var_09, level.var_4FFD, 1, 1);
    setomnvar("ui_broadcaster_game_mode_status_1", 0);
  } else {
    maps\mp\_utility::func_863F(var_09, level.var_4FFD, 2, 1);
    setomnvar("ui_broadcaster_game_mode_status_2", 0);
  }

  return var_09;
}

func_27D2(param_00, param_01) {
  var_02 = getent("ctf_zone_" + param_01, "targetname");
  var_03 = (0, 0, 0);
  if(param_01 == "allies") {
    if(isDefined(level.allies_ctf_flag_offset)) {
      var_03 = level.allies_ctf_flag_offset;
    }
  } else if(param_01 == "axis") {
    if(isDefined(level.axis_ctf_flag_offset)) {
      var_03 = level.axis_ctf_flag_offset;
    }
  }

  var_04 = spawn("trigger_radius", var_02.var_0116 + var_03, 0, 32, var_02.var_00BD);
  var_02 = var_04;
  var_05 = [];
  var_06 = maps\mp\gametypes\_gameobjects::func_2837(param_00, var_02, var_05, (0, 0, 85));
  var_06 maps\mp\gametypes\_gameobjects::func_0C30("friendly");
  var_06 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_06 maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_500C);
  var_06 maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_500D, undefined, 1);
  var_06 maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_5005);
  var_06 maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5006, undefined, 1);
  if(param_00 == "allies") {
    var_06 maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_4FFB);
    var_06 maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_4FFC, undefined, 1);
    var_06 maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_4FF9);
    var_06 maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_4FFA, undefined, 1);
  } else {
    var_06 maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5001);
    var_06 maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5002, undefined, 1);
    var_06 maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_4FFF);
    var_06 maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5000, undefined, 1);
  }

  var_06 maps\mp\gametypes\_gameobjects::func_8A5A(0);
  var_06 maps\mp\gametypes\_gameobjects::func_86B5(level.var_9853[maps\mp\_utility::func_45DE(param_00)]);
  var_06.var_6BBF = ::func_6BBF;
  var_06.var_6AC9 = ::func_6AC9;
  var_07 = var_02.var_0116 + (0, 0, 32);
  var_08 = var_02.var_0116 + (0, 0, -32);
  var_09 = bulletTrace(var_07, var_08, 0, undefined);
  var_06.var_15FA = var_09["position"];
  var_06.var_15F9 = var_09["normal"];
  var_06 thread func_1FC4();
  var_06.var_4D3F = 0;
  var_06.var_645F = -1;
  return var_06;
}

func_6ABC(param_00) {
  var_01 = param_00.var_012C["team"];
  if(var_01 == maps\mp\gametypes\_gameobjects::func_45F7()) {
    self.var_9D65.var_014F = 1024;
    return;
  }

  self.var_9D65.var_014F = self.var_6A68;
}

func_6AFA(param_00, param_01, param_02) {
  self.var_9D65.var_014F = self.var_6A68;
}

func_6B62(param_00) {
  self notify("picked_up");
  var_01 = param_00.var_012C["team"];
  if(var_01 == "allies") {
    var_02 = "axis";
  } else {
    var_02 = "allies";
  }

  if(var_01 == maps\mp\gametypes\_gameobjects::func_45F7()) {
    maps\mp\_utility::func_863E(11, param_00.var_01A7, param_00 getentitynumber());
    thread func_7E2F(0);
    maps\mp\_utility::func_5C39("flag_returned", var_01, "status");
    maps\mp\_utility::func_74D9("mp_obj_notify_pos_med", var_01);
    maps\mp\_utility::func_5C39("enemy_flag_returned", var_02, "status");
    maps\mp\_utility::func_74D9("mp_obj_notify_neg_med", var_02);
    param_00 thread maps\mp\_events::func_3CC3();
    func_6B94(var_01);
    return;
  }

  if(isDefined(level.var_2899) && isDefined(level.var_2899[var_01])) {
    param_00 thread func_0F32(self);
  } else {
    param_00 func_1148(self);
  }

  var_03 = 0;
  if(param_00 maps\mp\_utility::func_0649("specialty_improvedobjectives")) {
    var_03 = 20;
    self.var_6993 = 7.5;
  } else {
    self.var_6993 = 5;
  }

  if(var_03 > 0) {
    param_00 thread maps\mp\perks\_perkfunctions::func_86BB(var_03);
  } else {
    param_00 thread maps\mp\perks\_perkfunctions::func_A06E();
  }

  maps\mp\_utility::func_863E(8, param_00.var_01A7, param_00 getentitynumber());
  thread func_1C82(param_00, var_01);
  thread func_44DF(var_02);
  func_6B64(param_00);
  maps\mp\gametypes\_gameobjects::func_8A60("any");
  maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_5011);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5012, undefined, 1);
  if(level.var_6FEF != 2) {
    maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5014);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5015, undefined, 1);
  } else {
    maps\mp\gametypes\_gameobjects::func_860A("friendly", undefined);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", undefined);
  }

  level.var_1FC6[var_02] maps\mp\gametypes\_gameobjects::func_0C30("none");
  level.var_1FC6[var_02] maps\mp\gametypes\_gameobjects::func_8A60("friendly");
  level.var_1FC6[var_02] maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5028);
  level.var_1FC6[var_02] maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5029, undefined, 1);
  var_04 = [param_00];
  maps\mp\_utility::func_5C39("enemy_flag_taken", var_01, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_pos_sml", var_01, var_04);
  param_00 method_8615("mp_ctf_flag_pickup");
  maps\mp\_utility::func_5C39("flag_taken", var_02, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_neg_sml", var_02);
  if(maps\mp\gametypes\_gameobjects::func_45F7() == "axis") {
    maps\mp\_utility::func_863F(level.var_1FC6[var_02], level.var_5018, 1, 1);
    maps\mp\_utility::func_863F(self, level.var_4FFE, 1, 1);
    setomnvar("ui_broadcaster_game_mode_status_1", param_00 getentitynumber());
  } else {
    maps\mp\_utility::func_863F(level.var_1FC6[var_02], level.var_5018, 2, 1);
    maps\mp\_utility::func_863F(self, level.var_4FFE, 2, 1);
    setomnvar("ui_broadcaster_game_mode_status_2", param_00 getentitynumber());
  }

  param_00 setgametypevip(1);
  param_00 thread maps\mp\_events::func_3CC1();
  if(var_01 == game["attackers"]) {
    game["allies_side_pickups"]++;
    return;
  }

  if(var_01 == game["defenders"]) {
    game["axis_side_pickups"]++;
    return;
  }
}

func_1C82(param_00, param_01) {
  level endon("game_ended");
  self endon("reset");
  param_00 endon("death");
  param_00 endon("disconnect");
  for(;;) {
    wait(15);
    if(level.var_9853[param_01] maps\mp\gametypes\_gameobjects::func_5715()) {
      param_00 maps\mp\_utility::func_5C43("enemy_flag_bringhome", "status");
    }
  }
}

func_44DF(param_00) {
  level endon("game_ended");
  self endon("reset");
  var_01 = func_44E2(param_00);
  if(var_01 == 1) {
    return;
  }

  for(;;) {
    wait(15);
    maps\mp\_utility::func_5C39("flag_getback", param_00, "status");
  }
}

func_44E2(param_00) {
  if(param_00 == "allies") {
    return level.var_0BF7;
  }

  if(param_00 == "axis") {
    return level.var_147E;
  }
}

func_7E2F(param_00) {
  if(!param_00) {
    maps\mp\_utility::func_863E(11, maps\mp\gametypes\_gameobjects::func_45F7());
  }

  maps\mp\gametypes\_gameobjects::func_7E30();
  if(level.var_289F) {
    var_01 = func_44E2("allies");
    var_02 = func_44E2("axis");
    if(var_01 == 0 && var_02 == 0) {
      func_6BB6();
    }
  }
}

func_6AEF(param_00) {
  var_01 = maps\mp\gametypes\_gameobjects::func_45F7();
  var_02 = level.var_6C63[var_01];
  maps\mp\gametypes\_gameobjects::func_0C1D("any");
  maps\mp\gametypes\_gameobjects::func_8A60("any");
  maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5020);
  maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5021, undefined, 1);
  if(var_01 == "allies") {
    maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_4FF9);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_4FFA, undefined, 1);
  } else {
    maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_4FFF);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5000, undefined, 1);
  }

  self.var_A582[0] func_8BF9(var_01);
  self.var_A582[1] func_8BF9(maps\mp\_utility::func_45DE(var_01));
  func_6AF0(var_01);
  if(var_01 == "axis") {
    maps\mp\_utility::func_863F(self, level.var_500E, 1, 1);
    setomnvar("ui_broadcaster_game_mode_status_1", 0 - level.var_3CC4);
  } else {
    maps\mp\_utility::func_863F(self, level.var_500E, 2, 1);
    setomnvar("ui_broadcaster_game_mode_status_2", 0 - level.var_3CC4);
  }

  if(isDefined(param_00)) {
    param_00.var_0112 = 0;
    if(isDefined(param_00.var_2013)) {
      param_00 func_2E40();
    }

    param_00 setgametypevip(0);
    param_00 thread maps\mp\perks\_perkfunctions::func_A06E();
  }

  maps\mp\_utility::func_5C39("flag_dropped", var_01, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_neg_sml", var_01);
  maps\mp\_utility::func_5C39("enemy_flag_dropped", var_02, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_pos_sml", var_02);
  thread func_7E2C();
}

func_7E2C() {
  self endon("picked_up");
  self endon("reset");
  wait(level.var_3CC4);
  var_00 = maps\mp\gametypes\_gameobjects::func_45F7();
  var_01 = level.var_6C63[var_00];
  maps\mp\_utility::func_5C39("flag_returned", var_00, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_pos_med", var_00);
  maps\mp\_utility::func_5C39("enemy_flag_returned", var_01, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_neg_med", var_01);
  maps\mp\_utility::func_863E(11, maps\mp\gametypes\_gameobjects::func_45F7());
  thread func_7E2F(0);
}

func_6B93() {
  var_00 = maps\mp\gametypes\_gameobjects::func_45F7();
  var_01 = level.var_6C63[var_00];
  maps\mp\gametypes\_gameobjects::func_0C1D("enemy");
  maps\mp\gametypes\_gameobjects::func_8A60("none");
  maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_5011);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5012, undefined, 1);
  if(level.var_6FEF != 2) {
    maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5014);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5015, undefined, 1);
  } else {
    maps\mp\gametypes\_gameobjects::func_860A("friendly", undefined);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", undefined);
  }

  func_6B94(var_00);
  level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_0C30("friendly");
  level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_8A60("any");
  if(var_00 == "allies") {
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_4FFB);
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_4FFC, undefined, 1);
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_4FF9);
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_4FFA, undefined, 1);
    maps\mp\_utility::func_863F(level.var_1FC6[var_00], undefined);
    maps\mp\_utility::func_863F(self, level.var_4FFD, 2, 1);
    setomnvar("ui_broadcaster_game_mode_status_1", 0);
  } else {
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860A("friendly", level.var_5001);
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860E("friendly", level.var_5002, undefined, 1);
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860A("enemy", level.var_4FFF);
    level.var_1FC6[var_00] maps\mp\gametypes\_gameobjects::func_860E("enemy", level.var_5000, undefined, 1);
    maps\mp\_utility::func_863F(level.var_1FC6[var_00], undefined);
    maps\mp\_utility::func_863F(self, level.var_4FFD, 1, 1);
    setomnvar("ui_broadcaster_game_mode_status_2", 0);
  }

  self.var_A582[0] func_8BF9(var_00);
  self.var_A582[1] func_8BF9(maps\mp\_utility::func_45DE(var_00));
}

func_6BBF(param_00) {
  var_01 = param_00.var_012C["team"];
  if(var_01 == "allies") {
    var_02 = "axis";
  } else {
    var_02 = "allies";
  }

  maps\mp\_utility::func_5C39("enemy_flag_captured", var_01, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_pos_lrg", var_01);
  maps\mp\_utility::func_5C39("flag_captured", var_02, "status");
  maps\mp\_utility::func_74D9("mp_obj_notify_neg_lrg", var_02);
  param_00 thread maps\mp\perks\_perkfunctions::func_A06E();
  param_00 thread maps\mp\_events::func_3CB7();
  param_00 notify("ch_capture", self);
  maps\mp\gametypes\_gamescore::func_47BD(var_01, 1, 1);
  if(var_01 == game["attackers"]) {
    game["allies_side_caps"]++;
  } else if(var_01 == game["defenders"]) {
    game["axis_side_caps"]++;
  }

  game["shut_out"][var_02] = 0;
  maps\mp\_utility::func_863E(9, var_01, param_00 getentitynumber());
  if(maps\mp\gametypes\_gameobjects::func_45F7() == "allies") {
    setomnvar("ui_broadcaster_game_mode_status_1", 0);
  } else {
    setomnvar("ui_broadcaster_game_mode_status_2", 0);
  }

  level thread func_21E2(var_01);
  if(isDefined(param_00)) {
    param_00.var_0112 = 0;
    if(isDefined(param_00.var_2013)) {
      param_00 func_2E40();
    }

    param_00 setgametypevip(0);
  }

  if(isDefined(level.var_2899) && isDefined(level.var_2899[var_01])) {
    param_00 thread func_7CDB();
  }

  level.var_9853[var_02] func_7E2F(1);
}

func_21E2(param_00) {
  var_01 = "roundsWon";
  if(level.var_AA24) {
    var_01 = "teamScores";
  }

  if(maps\mp\_utility::func_5380()) {
    func_A15D(param_00);
    if(game["status"] == "overtime") {
      game["round_time_to_beat"] = maps\mp\_utility::func_4589();
      level thread maps\mp\gametypes\_gamelogic::func_36B9("overtime_halftime", game["end_reason"]["score_limit_reached"]);
      return;
    }

    if(game["status"] == "overtime_halftime") {
      if(game["roundsWon"]["axis"] == game["roundsWon"]["allies"]) {
        func_A15D(param_00);
      }

      if(game["teamScores"]["axis"] == game["teamScores"]["allies"]) {
        game["teamScores"][param_00]++;
      }

      if(param_00 == "allies" || param_00 == "axis" || param_00 == "tie") {
        function_00F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", param_00, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
      }

      level thread maps\mp\gametypes\_gamelogic::func_36B9(param_00, game["end_reason"]["score_limit_reached"]);
      return;
    }

    return;
  }

  if(game["teamScores"][param_00] == maps\mp\_utility::func_471A("scorelimit")) {
    func_A15D(param_00);
    if(game["status"] == "normal") {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::func_46E3();
      level thread maps\mp\gametypes\_gamelogic::func_36B9("halftime", game["end_reason"]["score_limit_reached"]);
      return;
    }

    if(game["status"] == "halftime") {
      var_02 = param_00;
      if(game[var_01]["axis"] == game[var_01]["allies"]) {
        var_02 = "overtime";
        level.var_3B5C = "none";
      }

      if(var_02 == "allies" || var_02 == "axis") {
        function_00F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_02, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
      }

      level thread maps\mp\gametypes\_gamelogic::func_36B9(var_02, game["end_reason"]["switching_sides"]);
      return;
    }

    return;
  }
}

func_A15D(param_00) {
  level.var_3B5C = param_00;
  game["roundsWon"][param_00]++;
}

func_6B42(param_00) {
  func_6BB6();
}

func_6BB6() {
  level.var_3B5C = "none";
  var_00 = "roundsWon";
  if(level.var_AA24) {
    var_00 = "teamScores";
  }

  if(maps\mp\_utility::func_5380()) {
    if(game["status"] == "overtime") {
      level thread maps\mp\gametypes\_gamelogic::func_36B9("overtime_halftime", game["end_reason"]["time_limit_reached"]);
      return;
    }

    if(game["status"] == "overtime_halftime") {
      var_01 = "tie";
      if(game[var_00]["axis"] > game[var_00]["allies"]) {
        var_01 = "axis";
      }

      if(game[var_00]["allies"] > game[var_00]["axis"]) {
        var_01 = "allies";
      }

      function_00F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_01, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
      level thread maps\mp\gametypes\_gamelogic::func_36B9(var_01, game["end_reason"]["time_limit_reached"]);
      return;
    }

    return;
  }

  if(game["status"] == "halftime") {
    if(level.var_3992 > 0 && level.var_289F == 0) {
      var_02 = 0;
      var_03 = func_44E2("allies");
      var_04 = func_44E2("axis");
      var_05 = game[var_00]["allies"];
      var_06 = game[var_00]["axis"];
      var_07 = game["teamScores"]["allies"];
      var_08 = game["teamScores"]["axis"];
      var_09 = var_08 - var_07 <= 1 && var_08 - var_07 >= 0;
      var_0A = var_07 - var_08 <= 1 && var_07 - var_08 >= 0;
      var_0B = var_06 - var_05 <= 1 && var_06 - var_05 >= 0;
      var_0C = var_05 - var_06 <= 1 && var_05 - var_06 >= 0;
      if((var_0C && var_03 != 0) || var_0B && var_04 != 0) {
        if(level.var_AA24) {
          var_02 = 1;
        } else if((var_0A && var_03 != 0) || var_09 && var_04 != 0) {
          var_02 = 1;
        }
      }

      if(var_02) {
        level.var_289F = 1;
        foreach(var_0E in level.var_744A) {
          var_0E thread maps\mp\gametypes\_hud_message::func_9102("ctf_extratime");
        }

        return;
      }
    }

    var_01 = "tie";
    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_01 = "axis";
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      var_01 = "allies";
    }

    if(var_01 == "axis" || var_01 == "allies") {
      func_A15D(var_01);
    }

    if(game[var_0C]["axis"] == game[var_0C]["allies"]) {
      var_01 = "overtime";
    }

    if(var_01 == "allies" || var_01 == "axis" || var_01 == "tie") {
      function_00F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_01, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
    }

    level thread maps\mp\gametypes\_gamelogic::func_36B9(var_01, game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(level.var_3992 > 0 && level.var_289F == 0) {
    var_02 = 0;
    var_03 = func_44E2("allies");
    var_04 = func_44E2("axis");
    var_07 = game["teamScores"]["allies"];
    var_08 = game["teamScores"]["axis"];
    var_10 = var_08 - var_07 <= 1 && var_08 - var_07 >= 0;
    var_11 = var_07 - var_08 <= 1 && var_07 - var_08 >= 0;
    if(var_03 != 0 || var_04 != 0) {
      if(level.var_AA24) {
        var_02 = 1;
      } else if((var_11 && var_03 != 0) || var_10 && var_04 != 0) {
        var_02 = 1;
      }
    }

    if(var_02) {
      level.var_289F = 1;
      foreach(var_0E in level.var_744A) {
        var_0E thread maps\mp\gametypes\_hud_message::func_9102("ctf_extratime");
      }

      return;
    }
  }

  if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    func_A15D("axis");
  }

  if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
    func_A15D("allies");
  }

  level thread maps\mp\gametypes\_gamelogic::func_36B9("halftime", game["end_reason"]["time_limit_reached"]);
}

func_0F32(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.var_56A3) && self.var_56A3 == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  self.var_012C["gamemodeLoadout"] = level.var_2899[self.var_01A7];
  self.var_3FC5 = self.var_2319;
  self.var_3FC4 = 1;
  self.var_012C["class"] = "gamemode";
  self.var_012C["lastClass"] = "gamemode";
  self.var_2319 = "gamemode";
  self.var_5B84 = "gamemode";
  self notify("faux_spawn");
  maps\mp\gametypes\_class::func_4773(self.var_01A7, "gamemode");
  if(self.var_5DF6) {
    maps\mp\killstreaks\_killstreaks::func_A129(1);
  }

  func_7B84();
  thread func_A687(param_00);
}

func_7B84() {
  var_00 = self getweaponslistoffhands();
  foreach(var_02 in var_00) {
    self method_84AF(var_02);
  }
}

func_A687(param_00) {
  level endon("game_ende");
  self endon("disconnect");
  self endon("death");
  self waittill("spawned_player");
  func_1148(param_00);
}

func_7CDB() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.var_56A3) && self.var_56A3 == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  self.var_012C["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::func_4773(self.var_01A7, self.var_2319);
  if(self.var_5DF6) {
    maps\mp\killstreaks\_killstreaks::func_A129(1);
  }

  func_7B84();
}

func_6AC9(param_00) {}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_01) && isPlayer(param_01) && param_01.var_012C["team"] != self.var_012C["team"]) {
    if(isDefined(param_01.var_2013)) {
      param_01 thread maps\mp\_events::func_5A84(param_04);
    }

    if(isDefined(self.var_2013)) {
      param_01 thread maps\mp\_events::func_5A46(param_09);
      maps\mp\_utility::func_863E(10, param_01.var_01A7, param_01 getentitynumber());
      func_2E40();
      self.var_2EF1 = 1;
      return;
    } else {
      self.var_2EF1 = 0;
    }

    var_0A = 65536;
    foreach(var_0C in level.var_1FC6) {
      var_0D = distance2dsquared(param_01.var_0116, var_0C.var_28D4);
      var_0E = distance2dsquared(self.var_0116, var_0C.var_28D4);
      if(var_0E < var_0A) {
        param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
      }

      if(var_0C.var_6DB2 == param_01.var_01A7) {
        if(var_0D < var_0A || var_0E < var_0A) {
          param_01 thread maps\mp\_events::func_2C80(self, param_09, param_04);
          param_01 maps\mp\_utility::func_867C(param_01.var_012C["defends"]);
          param_01.var_62A1["defendObjective"] = var_0C;
        }
      }

      if(var_0C.var_6DB2 == self.var_01A7) {
        if(var_0D < var_0A || var_0E < var_0A) {
          param_01 thread maps\mp\_events::func_10BA(self, param_09, param_04);
          param_01.var_62A1["assaultObjective"] = var_0C;
        }
      }
    }

    return;
  }

  if(isDefined(self.var_2013)) {
    func_2E40();
  }
}

func_1148(param_00) {
  var_01 = level.var_6C63[self.var_012C["team"]];
  level.var_2013[var_01][self.var_012C["team"]] method_8449(self, "J_spine4", (0, 0, 0), (0, 0, 0));
  self.var_2013 = level.var_2013[var_01][self.var_012C["team"]];
  level.var_2013[var_01][self.var_012C["team"]] func_8BF9(self.var_012C["team"]);
  level.var_2013[var_01][var_01] method_8449(self, "J_spine4", (0, 0, 0), (0, 0, 0));
  self.var_2014 = level.var_2013[var_01][var_01];
  level.var_2013[var_01][var_01] func_8BF9(var_01);
  thread func_2E41(self.var_2013, self.var_2014);
}

func_2E40() {
  self notify("lost_ctf_flag");
  self.var_2013 unlink();
  self.var_2013 method_805C();
  self.var_2013 = undefined;
  self.var_2014 unlink();
  self.var_2014 method_805C();
  self.var_2014 = undefined;
}

func_872E() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", "defaultClass", 5, "class", "inUse")) {
    level.var_2899["axis"] = maps\mp\_utility::func_4573("axis", 5);
  }

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", "defaultClass", 5, "class", "inUse")) {
    level.var_2899["allies"] = maps\mp\_utility::func_4573("allies", 5);
  }
}

func_1FC4() {
  waittillframeend;
  func_3EC2(level.var_3CB5, self.var_15FA, self.var_15F9);
}

func_3EC3() {
  if(isDefined(self.var_3ED4)) {
    self.var_3ED4 delete();
  }

  if(isDefined(self.var_3769)) {
    self.var_3769 delete();
  }

  if(isDefined(self.var_1C98)) {
    self.var_1C98 delete();
  }
}

func_3EC2(param_00, param_01, param_02) {
  var_03 = self.var_6DB2;
  var_04 = param_00[game[var_03]][2];
  var_05 = param_00[game[var_03]][0];
  if(game[var_03] == "allies") {
    var_06 = param_00[game[var_03]][3];
  } else {
    var_06 = param_01[game[var_04]][4];
  }

  func_3EC3();
  self.var_3ED4 = maps\mp\_utility::func_9067(var_04, var_03, param_01, param_02);
  self.var_3769 = maps\mp\_utility::func_9067(var_05, maps\mp\_utility::func_45DE(var_03), param_01, param_02);
  self.var_1C98 = maps\mp\_utility::func_9067(var_06, "broadcaster", param_01, param_02);
}

func_1FC3() {
  foreach(var_01 in level.var_9853) {
    if(var_01.var_A582.size) {
      var_02 = var_01.var_A582[0].var_0116 + (0, 0, 32);
      var_03 = var_01.var_A582[0].var_0116 + (0, 0, -32);
      var_04 = bulletTrace(var_02, var_03, 0, undefined);
      var_05 = vectortoangles(var_04["normal"]);
      var_01.var_15F9 = anglesToForward(var_05);
      var_01.var_15FA = var_04["position"];
      var_06 = level.var_1FC6[var_01.var_6DB2];
      var_06.var_15F9 = var_01.var_15F9;
      var_06.var_15FA = var_01.var_15FA;
      var_06 thread func_1FC4();
    }
  }
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_748E();
  }
}

func_8BF8(param_00) {
  var_01 = maps\mp\_utility::func_45DE(param_00);
  self.var_A582[0] method_805C();
  self.var_A582[1] method_805C();
  foreach(var_03 in level.var_744A) {
    if(var_03.var_01A7 == param_00) {
      self.var_A582[0] showtoclient(var_03);
    }

    if(var_03.var_01A7 == "spectator" && param_00 == "allies") {
      self.var_A582[0] showtoclient(var_03);
    }

    if(var_03.var_01A7 == var_01) {
      self.var_A582[1] showtoclient(var_03);
    }

    if(var_03.var_01A7 == "spectator" && var_01 == "allies") {
      self.var_A582[1] showtoclient(var_03);
    }
  }

  for(;;) {
    level waittill("joined_team");
    if(!isDefined(self.var_2006)) {
      self.var_A582[0] method_805C();
      self.var_A582[1] method_805C();
      foreach(var_03 in level.var_744A) {
        if(var_03.var_01A7 == param_00) {
          self.var_A582[0] showtoclient(var_03);
        }

        if(var_03.var_01A7 == "spectator" && param_00 == "allies") {
          self.var_A582[0] showtoclient(var_03);
        }

        if(var_03.var_01A7 == var_01) {
          self.var_A582[1] showtoclient(var_03);
        }

        if(var_03.var_01A7 == "spectator" && var_01 == "allies") {
          self.var_A582[1] showtoclient(var_03);
        }
      }

      continue;
    }

    var_07 = maps\mp\gametypes\_gameobjects::func_45F7();
    var_01 = maps\mp\_utility::func_45DE(var_07);
    level.var_2013[var_07][var_07] method_805C();
    level.var_2013[var_07][var_01] method_805C();
    foreach(var_03 in level.var_744A) {
      if(var_03.var_01A7 == "allies" || var_03.var_01A7 == "axis") {
        level.var_2013[var_07][var_03.var_01A7] showtoclient(var_03);
        continue;
      }

      if(var_03.var_01A7 == "spectator") {
        level.var_2013[var_07]["allies"] showtoclient(var_03);
      }
    }
  }
}

func_8BF9(param_00) {
  self method_805C();
  foreach(var_02 in level.var_744A) {
    if(var_02.var_01A7 == param_00) {
      self showtoclient(var_02);
    }

    if(var_02.var_01A7 == "spectator" && param_00 == "allies") {
      self showtoclient(var_02);
    }
  }
}

func_2E41(param_00, param_01) {
  level endon("game_ended");
  self endon("lost_ctf_flag");
  self waittill("disconnect");
  param_00 method_805C();
  param_01 method_805C();
}