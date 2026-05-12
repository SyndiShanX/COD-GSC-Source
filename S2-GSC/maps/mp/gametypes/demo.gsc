/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\demo.gsc
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
    maps\mp\_utility::func_7BF8(level.var_3FDC, 1, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 5);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 3);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 2);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 1);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_86EB(2.5);
  level.var_2D64 = 1;
  maps\mp\_utility::func_873B(1);
  level.var_4959 = 0;
  level.var_6B86 = ::func_6B86;
  level.var_6BAF = ::func_6BAF;
  level.var_6BA7 = ::func_6BA7;
  level.var_6B7B = ::func_6B7B;
  level.var_6BB6 = ::func_6BB6;
  level.var_6B42 = ::func_6B42;
  level.var_6B5C = ::func_6B5C;
  level.var_3FC7 = ::func_5782;
  level.var_0C25 = 1;
  level.var_6876 = 0;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "demo_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "gbl_destroyobj";
  game["dialog"]["defense_obj"] = "gbl_defendobj";
  setomnvar("ui_bomb_a_timer_endtime", 0);
  setomnvar("ui_bomb_b_timer_endtime", 0);
}

func_5300() {
  maps\mp\_utility::func_8653();
  var_00 = getmatchrulesdata("demoData", "roundSwitch");
  setdynamicdvar("scr_demo_roundswitch", var_00);
  maps\mp\_utility::func_7BF8("demo", var_00, 0, 9);
  setdynamicdvar("scr_demo_bombtimer", getmatchrulesdata("demoData", "bombTimer"));
  setdynamicdvar("scr_demo_planttime", getmatchrulesdata("demoData", "plantTime"));
  setdynamicdvar("scr_demo_defusetime", getmatchrulesdata("demoData", "defuseTime"));
  setdynamicdvar("scr_demo_multibomb", getmatchrulesdata("demoData", "multiBomb"));
  setdynamicdvar("scr_demo_silentplant", getmatchrulesdata("demoData", "silentPlant"));
  setdynamicdvar("scr_demo_extratime", getmatchrulesdata("demoData", "extraTime"));
  setdynamicdvar("scr_demo_winlimit", 1);
  maps\mp\_utility::func_7C04("demo", 1);
  setdynamicdvar("scr_demo_roundlimit", 1);
  maps\mp\_utility::func_7BF7("demo", 1);
  setdynamicdvar("scr_demo_scorelimit", 3);
  maps\mp\_utility::func_7BF9("demo", 3);
  setdynamicdvar("scr_demo_halftime", 1);
  maps\mp\_utility::func_7BE5("demo", 1);
  setdynamicdvar("scr_demo_halftimeswitchsides", getmatchrulesdata("demoData", "halfTimeSwitchSides"));
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

  setomnvar("ui_war_attacker_team", maps\mp\_utility::func_46D4(game["attackers"]));
  if(game["status"] == "halftime") {
    setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    setomnvar("ui_current_round", 4);
  }

  setclientnamemode("manual_change");
  level.var_0611["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
  maps\mp\_utility::func_86DC(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  maps\mp\_utility::func_86DC(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    maps\mp\_utility::func_86DB(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    maps\mp\_utility::func_86DB(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    maps\mp\_utility::func_86DB(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }

  maps\mp\_utility::func_86D8(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  maps\mp\_utility::func_86D8(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
  lib_050D::func_10E4();
  var_02[0] = "blocker_demo";
  if(game["status"] == "overtime") {
    var_02[1] = "demo_bombzone_ot";
    level.demobombbteam = "exploded";
    foreach(var_04 in level.var_744A) {
      var_04 setclientomnvar("ui_demo_bomb_b_state", 2);
    }
  } else {
    var_02[1] = "demo_bombzone";
  }

  maps\mp\gametypes\_gameobjects::func_00F9(var_02);
  thread func_A121();
  thread func_18FD();
  level.var_4958 = maps\mp\_utility::func_3517("halftimeswitchsides", 1, 0, 1);
}

func_6BA7() {
  if(maps\mp\_utility::func_56FF(self)) {
    self.var_5777 = 0;
    self.var_56C2 = 0;
    self.var_568D = 1;
    self.var_0112 = 0;
  }

  if(isPlayer(self)) {
    if(level.var_6510 && self.var_012C["team"] == game["attackers"] || game["status"] == "overtime") {
      self setclientomnvar("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::func_9102("bomb_pickedup");
    } else {
      self setclientomnvar("ui_carrying_bomb", 0);
    }
  }

  maps\mp\_utility::func_867B(0);
  if(isDefined(self.var_012C["plants"])) {
    maps\mp\_utility::func_867B(self.var_012C["plants"]);
  }

  maps\mp\_utility::func_867C(0);
  if(isDefined(self.var_012C["defuses"])) {
    maps\mp\_utility::func_867C(self.var_012C["defuses"]);
  }

  if(!isDefined(level.demobombateam)) {
    self setclientomnvar("ui_demo_bomb_a_state", 0);
  } else if(level.demobombateam == "exploded") {
    self setclientomnvar("ui_demo_bomb_a_state", 2);
  } else if(level.demobombateam == self.var_01A7) {
    self setclientomnvar("ui_demo_bomb_a_state", 3);
  } else {
    self setclientomnvar("ui_demo_bomb_a_state", 1);
  }

  if(!isDefined(level.demobombbteam)) {
    self setclientomnvar("ui_demo_bomb_b_state", 0);
  } else if(level.demobombbteam == "exploded") {
    self setclientomnvar("ui_demo_bomb_b_state", 2);
  } else if(level.demobombbteam == self.var_01A7) {
    self setclientomnvar("ui_demo_bomb_b_state", 3);
  } else {
    self setclientomnvar("ui_demo_bomb_b_state", 1);
  }

  level notify("spawned_player");
}

func_6B86() {
  game["bomb_dropped_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_dropped_enemy_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_recovered_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_grabbed_sound"] = "mp_snd_bomb_pickup";
  game["bomb_planted_sound"] = "mp_obj_notify_pos_med";
  game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_med";
  game["bomb_disarm_sound"] = "mp_obj_notify_pos_lrg";
  game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_lrg";
}

func_A121() {
  level.var_7078 = maps\mp\_utility::func_3516("planttime", 5, 0, 20);
  level.var_2CA9 = maps\mp\_utility::func_3516("defusetime", 5, 0, 20);
  level.var_1909 = maps\mp\_utility::func_3516("bombtimer", 45, 1, 300);
  level.var_6510 = maps\mp\_utility::func_3517("multibomb", 0, 0, 1);
  level.var_8C56 = maps\mp\_utility::func_3517("silentplant", 0, 0, 1);
  level.var_3992 = maps\mp\_utility::func_3517("extraTime", 2, 0, 10);
}

func_5782(param_00) {
  if(isDefined(level.var_1913)) {
    foreach(var_02 in level.var_1913) {
      if(distancesquared(self.var_0116, var_02.var_9D65.var_0116) < 4096) {
        return 0;
      }
    }
  }

  return 1;
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

  var_0A = self;
  if(var_0A.var_5777 || var_0A.var_56C2) {
    param_01 thread maps\mp\_events::func_2C80(var_0A, param_09, param_04);
    param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
    if(var_0A.var_5777) {
      param_01 maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_interrupt");
    }

    if(var_0A.var_56C2) {
      param_01 maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_protector");
    }
  }
}

func_6B5C(param_00, param_01, param_02) {
  if(game["state"] == "postgame" && param_00.var_01A7 == game["defenders"] || !level.var_18F9) {
    param_01.var_3B4B = 1;
  }
}

func_18FD() {
  level.var_18F9 = 0;
  level.var_18D3 = 0;
  level.var_18EE = 0;
  level.icontarget = "waypoint_caster_target";
  level.var_1913 = [];
  level.var_2D65 = [];
  var_00 = getEntArray("demo_bombzone", "targetname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(game["status"] == "overtime") {
      level.demolition_site_mod = [];
      level.demolition_site_mod[var_01] = level.demolition_site_mod_ot;
      level.demolition_site_origins = [];
      level.demolition_site_origins[var_01] = level.demolition_site_origins_ot;
      level.demolition_site_angles = [];
      level.demolition_site_angles[var_01] = level.demolition_site_angles_ot;
    }

    var_02 = var_00[var_01];
    var_03 = getEntArray(var_00[var_01].var_01A2, "targetname");
    var_04 = [];
    var_05 = undefined;
    if(isDefined(level.demolition_site_mod) && isDefined(level.demolition_site_mod[var_01])) {
      var_04 = getEntArray("script_brushmodel", "classname");
      foreach(var_07 in var_04) {
        if(distance(var_07.var_0116, var_02.var_0116) <= 200 && isDefined(var_07.var_81BE) && ((game["status"] != "overtime" && var_07.var_81BE == "demo_bombzone") || game["status"] == "overtime" && var_07.var_81BE == "demo_bombzone_ot") && isDefined(var_07.var_81E8) && var_07.var_81E8 == level.demolition_site_mod[var_01]) {
          var_05 = var_07;
        }
      }
    }

    if(isDefined(level.demolition_site_origins) && isDefined(level.demolition_site_origins[var_01]) && isDefined(var_05)) {
      var_02.var_0116 = level.demolition_site_origins[var_01];
      var_03[0].var_0116 = level.demolition_site_origins[var_01];
      var_05.var_0116 = (0, 0, 26) + level.demolition_site_origins[var_01];
    }

    if(isDefined(level.demolition_site_angles) && isDefined(level.demolition_site_angles[var_01]) && isDefined(var_05)) {
      var_02.var_001D = level.demolition_site_angles[var_01];
      var_03[0].var_001D = (0, 270, 0) + level.demolition_site_angles[var_01];
      var_05.var_001D = level.demolition_site_angles[var_01];
    }

    if(game["status"] == "overtime") {
      var_09 = "any";
      var_0A = "any";
    } else {
      var_09 = game["defenders"];
      var_0A = "enemy";
    }

    var_0B = maps\mp\gametypes\_gameobjects::func_2837(var_09, var_02, var_03, (0, 0, 64));
    var_0B maps\mp\gametypes\_gameobjects::func_0C30(var_0A);
    var_0B maps\mp\gametypes\_gameobjects::func_8A5A(level.var_7078);
    var_0B maps\mp\gametypes\_gameobjects::func_8A57(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
    var_0C = var_0B maps\mp\gametypes\_gameobjects::func_454C();
    var_0B.var_00E5 = var_0C;
    if(game["status"] == "overtime") {
      var_0B maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_target" + var_0C);
      var_0B maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_target" + var_0C);
    } else {
      var_0B maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defend" + var_0C);
      var_0B maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defend" + var_0C);
    }

    var_0B maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_target" + var_0C);
    var_0B maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_target" + var_0C);
    var_0B maps\mp\gametypes\_gameobjects::func_8A60("any");
    maps\mp\_utility::func_863F(var_0B, level.icontarget + var_0C, 3);
    var_0B.var_6ABC = ::func_6ABE;
    var_0B.var_6AFA = ::func_6AFB;
    var_0B.var_681A = 1;
    var_0B.var_502A = "bombZone";
    var_0B.var_6BBF = ::func_6BC8;
    var_0B.var_6AC9 = ::func_6AC9;
    var_0B.var_A248 = "search_dstry_bomb_mp";
    var_0B.var_568E = 0;
    var_0B.var_18F9 = 0;
    for(var_0D = 0; var_0D < var_03.size; var_0D++) {
      if(isDefined(var_03[var_0D].var_8186)) {
        var_0B.var_3947 = var_03[var_0D].var_8186;
        var_03[var_0D] thread func_8A29(var_0B);
        break;
      }
    }

    level.var_1913[level.var_1913.size] = var_0B;
    var_0B.var_18D5 = getent(var_03[0].var_01A2, "targetname");
    var_0B.var_18D5.var_0116 = var_0B.var_18D5.var_0116 + (0, 0, -10000);
    var_0B.var_18D5.var_00E5 = var_0C;
    var_0B.var_18D5 usetriggertouchcheckstance(1);
  }

  for(var_01 = 0; var_01 < level.var_1913.size; var_01++) {
    var_0E = [];
    for(var_0F = 0; var_0F < level.var_1913.size; var_0F++) {
      if(var_0F != var_01) {
        var_0E[var_0E.size] = level.var_1913[var_0F];
      }
    }

    level.var_1913[var_01].var_6C61 = var_0E;
  }

  setomnvar("ui_broadcaster_game_mode_status_1", 0);
}

func_6BC8(param_00) {
  if(!maps\mp\gametypes\_gameobjects::func_56FB(param_00.var_012C["team"]) || game["status"] == "overtime") {
    level thread func_18F9(self, param_00);
    param_00 method_8617("mp_bomb_plant");
    param_00 notify("bomb_planted");
    param_00 thread maps\mp\_events::func_18FC();
    param_00 thread lib_0468::func_0A22("demoBombPlanted");
    maps\mp\_utility::func_5C39("bomb_planted");
    maps\mp\_utility::func_74D9(game["bomb_planted_sound"], game["attackers"]);
    maps\mp\_utility::func_74D9(game["bomb_planted_enemy_sound"], game["defenders"]);
    self.var_18F8 = param_00;
    self.var_18F9 = 1;
    param_00.var_18FB = gettime();
    return;
  }

  self.var_18F9 = 0;
}

func_7156(param_00) {
  var_01 = common_scripts\utility::func_0F93(level.var_744A, param_00);
  if(var_01.size) {
    param_00 maps\mp\_utility::func_74C3("snd_bomb_button_press_lp", undefined, var_01);
  }
}

func_93D6(param_00) {
  param_00 common_scripts\utility::func_93D5("snd_bomb_button_press_lp");
}

func_8A29(param_00) {
  var_01 = spawn("script_origin", self.var_0116);
  var_01.var_001D = self.var_001D;
  var_01 rotateyaw(-45, 0.05);
  wait 0.05;
  var_02 = self.var_0116 + (0, 0, 5);
  var_03 = self.var_0116 + anglesToForward(var_01.var_001D) * 100 + (0, 0, 128);
  var_04 = bulletTrace(var_02, var_03, 0, self);
  self.var_5A2C = spawn("script_model", var_04["position"]);
  self.var_5A2C setscriptmoverkillcam("explosive");
  param_00.var_5A2D = self.var_5A2C getentitynumber();
  var_01 delete();
}

func_6ABF(param_00) {
  param_00 method_812A(0);
  if(maps\mp\gametypes\_gameobjects::func_56FB(param_00.var_012C["team"])) {
    if(!level.var_8C56 && !param_00 maps\mp\_utility::func_0649("specialty_improvedobjectives")) {
      param_00 maps\mp\_utility::func_67F4("defuse");
      param_00 method_8617("mp_snd_bomb_disarming");
      level thread func_7156(param_00);
    }

    param_00.var_56C2 = 1;
    if(isDefined(self.var_2D65)) {
      self.var_2D65 method_805C();
    }
  }
}

func_6ABE(param_00) {
  param_00 method_812A(0);
  if(!level.var_8C56 && !param_00 maps\mp\_utility::func_0649("specialty_improvedobjectives")) {
    param_00 maps\mp\_utility::func_67F4("plant");
    param_00 method_8617("mp_snd_bomb_arming");
    level thread func_7156(param_00);
  }

  param_00.var_5777 = 1;
}

func_6AFB(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    return;
  }

  param_01 method_812A(1);
  param_01.var_5777 = 0;
  level thread func_93D6(param_01);
}

func_6AFC(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    return;
  }

  param_01 method_812A(1);
  param_01.var_56C2 = 0;
  level thread func_93D6(param_01);
  if(maps\mp\gametypes\_gameobjects::func_56FB(param_01.var_012C["team"])) {
    if(isDefined(self.var_2D65) && !param_02) {
      self.var_2D65 method_805B();
    }
  }
}

func_18FA(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 playerlinkto(param_01);
  while(param_00 getcurrentweapon() == self.var_A248) {
    wait 0.05;
  }

  param_00 unlink();
}

func_18F9(param_00, param_01) {
  level notify("bomb_planted", param_00);
  var_02 = "allies";
  if(isDefined(param_01) && isDefined(param_01.var_01A7)) {
    var_02 = param_01.var_01A7;
  }

  if(!isDefined(level.var_686C)) {
    level.var_686C = 1;
  } else {
    level.var_686C++;
  }

  if(game["status"] == "overtime") {
    param_00 maps\mp\gametypes\_gameobjects::func_86EC(var_02);
  }

  maps\mp\gametypes\_gamelogic::func_6F27();
  if(maps\mp\_utility::func_4502() && game["status"] != "halftime") {
    setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()) - int(maps\mp\_utility::func_46E2() * 60 * 1000 * 0.5), 1);
  } else {
    setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()), 1);
  }

  level.var_18F9 = 1;
  param_01.var_0112 = 0;
  if(isPlayer(param_01) && !level.var_6510) {
    param_01 setclientomnvar("ui_carrying_bomb", 0);
  }

  param_00.var_568E = 0;
  param_00.var_A582[0] thread maps\mp\gametypes\_gamelogic::func_74E5();
  level.var_99C0 = param_00.var_A582[0];
  param_00 maps\mp\gametypes\_gameobjects::func_0C30("none");
  param_00 maps\mp\gametypes\_gameobjects::func_8A60("none");
  param_00.var_2CA0 = int(gettime() + level.var_1909 * 1000);
  var_03 = param_00 maps\mp\gametypes\_gameobjects::func_454C();
  var_04 = spawn("script_model", param_01.var_0116);
  var_04.var_001D = param_01.var_001D;
  var_04 setModel("npc_gen_s_and_d_bomb");
  level.var_2D65[var_03] = var_04;
  if(var_03 == "_a") {
    level.demobombateam = var_02;
  } else if(var_03 == "_b") {
    level.demobombbteam = var_02;
  }

  foreach(var_06 in level.var_744A) {
    if(var_06.var_01A7 == var_02) {
      var_06 setclientomnvar("ui_demo_bomb" + var_03 + "_state", 3);
      continue;
    }

    var_06 setclientomnvar("ui_demo_bomb" + var_03 + "_state", 1);
  }

  param_00.var_18F9 = 1;
  var_08 = param_00.var_18D5;
  var_08.var_0116 = var_04.var_0116;
  var_08.var_7AC4 = undefined;
  var_09 = [];
  var_0A = maps\mp\gametypes\_gameobjects::func_2837(maps\mp\_utility::func_45DE(var_02), var_08, var_09, (0, 0, 32));
  var_0A maps\mp\gametypes\_gameobjects::func_0C30("friendly");
  var_0A maps\mp\gametypes\_gameobjects::func_8A5A(level.var_2CA9);
  var_0A maps\mp\gametypes\_gameobjects::func_8A57(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_0A maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_0A maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defuse" + var_03);
  var_0A maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_defend" + var_03);
  var_0A maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defuse" + var_03);
  var_0A maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_defend" + var_03);
  var_0A.var_00E5 = var_03;
  var_0A.var_6ABC = ::func_6ABF;
  var_0A.var_6AFA = ::func_6AFC;
  var_0A.var_6BBF = ::func_6BC3;
  var_0A.var_681A = 1;
  var_0A.var_502A = "defuseObject";
  var_0A.var_A248 = "search_dstry_bomb_defuse_mp";
  var_0A.var_190E = param_00;
  var_0A.var_2D65 = var_04;
  if(var_03 == "_a" || var_03 == "_A") {
    setomnvar("ui_broadcaster_game_mode_status_1", 1);
  } else if(var_03 == "_b" || var_03 == "_B") {
    setomnvar("ui_broadcaster_game_mode_status_1", 2);
  }

  maps\mp\_utility::func_74D8("mp_snd_bomb_planted", var_04.var_0116 + (0, 0, 1));
  param_00 func_190B(var_03);
  param_00.var_A582[0] maps\mp\gametypes\_gamelogic::func_9415();
  if(level.var_3F9D || param_00.var_568E) {
    return;
  }

  level.var_18EE = 1;
  setomnvar("ui_broadcaster_game_mode_status_1", 0);
  if(var_03 == "_a") {
    level.demobombateam = "exploded";
  } else if(var_03 == "_b") {
    level.demobombbteam = "exploded";
  }

  foreach(var_06 in level.var_744A) {
    var_06 setclientomnvar("ui_demo_bomb" + var_03 + "_state", 2);
  }

  var_0D = var_04.var_0116;
  var_0D = var_0D + (0, 0, 10);
  var_04 delete();
  param_00.var_18F9 = 0;
  if(isDefined(param_01)) {
    param_00.var_A582[0] entityradiusdamage(var_0D, 512, 300, 20, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
    param_01 thread maps\mp\_events::func_18D6();
  } else {
    param_00.var_A582[0] entityradiusdamage(var_0D, 512, 300, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  var_0E = "bomb_explosion";
  if(isDefined(param_00.var_9D65.var_359B)) {
    var_0E = param_00.var_9D65.var_359B;
  }

  var_0F = randomfloat(360);
  var_10 = var_0D + (0, 0, 50);
  var_11 = spawnfx(level.var_0611[var_0E], var_10 + (0, 0, 50), (0, 0, 1), (cos(var_0F), sin(var_0F), 0));
  triggerfx(var_11);
  physicsexplosionsphere(var_10, 200, 100, 3);
  function_01BB("grenade_rumble", var_0D);
  earthquake(0.75, 2, var_0D, 2000);
  thread maps\mp\_utility::func_74D8("mp_snd_bomb_detonated", var_0D);
  if(isDefined(param_00.var_3947)) {
    common_scripts\_exploder::func_392A(param_00.var_3947);
  }

  var_0A maps\mp\gametypes\_gameobjects::func_2F93();
  var_0A maps\mp\gametypes\_gameobjects::func_2D58();
  maps\mp\gametypes\_gamescore::func_47BD(var_02, 1, 1);
  if(!isDefined(level.var_6876)) {
    level.var_6876 = 1;
  } else {
    level.var_6876++;
  }

  if(level.var_6876 == 2) {
    func_2D63(var_02, game["end_reason"]["target_destroyed"]);
  }

  if(maps\mp\_utility::func_4502() && game["status"] != "halftime") {
    setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()) - int(maps\mp\_utility::func_46E2() * 60 * 1000 * 0.5), 1);
  } else {
    setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()), 1);
  }

  level.var_686C--;
  if(level.var_686C < 1) {
    maps\mp\gametypes\_gamelogic::func_7DFC();
    level.var_18F9 = 0;
  }
}

func_190B(param_00) {
  level endon("game_ended");
  self endon("bomb_defused");
  var_01 = int(level.var_1909 * 1000 + gettime());
  setomnvar("ui_bomb" + param_00 + "_timer_endtime", var_01);
  thread func_4ACC(param_00, var_01);
  maps\mp\gametypes\_hostmigration::func_A6F4(level.var_1909);
}

func_4ACC(param_00, param_01) {
  level endon("game_ended");
  level endon("game_ended");
  level endon("disconnect");
  self endon("bomb_defused");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb" + param_00 + "_timer_endtime", 0);
  var_02 = maps\mp\gametypes\_hostmigration::func_A782();
  if(var_02 > 0) {
    setomnvar("ui_bomb" + param_00 + "_timer_endtime", param_01 + var_02);
  }
}

func_6BC3(param_00) {
  param_00 notify("bomb_defused");
  thread func_18D3();
  level.var_686C--;
  if(level.var_686C < 1) {
    maps\mp\gametypes\_gamelogic::func_7DFC();
    if(maps\mp\_utility::func_4502() && game["status"] != "halftime") {
      setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()) - int(maps\mp\_utility::func_46E2() * 60 * 1000 * 0.5), 1);
    } else {
      setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()), 1);
    }

    level.var_18F9 = 0;
  }

  self.var_2D65 delete();
  self.var_190E.var_18F9 = 0;
  if(game["status"] == "overtime") {
    var_01 = "any";
  } else {
    var_01 = "enemy";
  }

  self.var_190E maps\mp\gametypes\_gameobjects::func_0C30(var_01);
  self.var_190E maps\mp\gametypes\_gameobjects::func_8A60("any");
  maps\mp\_utility::func_5C39("bomb_defused_attackers", game["attackers"]);
  maps\mp\_utility::func_5C39("bomb_defused_defenders", game["defenders"]);
  maps\mp\_utility::func_74D9(game["bomb_disarm_enemy_sound"], game["attackers"]);
  maps\mp\_utility::func_74D9(game["bomb_disarm_sound"], game["defenders"]);
  var_02 = "defuse";
  if(isDefined(self.var_190E.var_18F8) && maps\mp\_utility::func_57A0(self.var_190E.var_18F8) && self.var_190E.var_18F8.var_18FB + 6000 + level.var_2CA9 * 1000 > gettime()) {
    var_02 = "ninja_defuse";
  }

  param_00 thread maps\mp\_events::func_18D4(var_02);
  param_00 thread lib_0468::func_0A22("demoBombDefused");
  maps\mp\gametypes\_gameobjects::func_2F93();
  maps\mp\gametypes\_gameobjects::func_2D58();
}

func_18D3() {
  self.var_190E maps\mp\gametypes\_gamelogic::func_9415();
  self.var_190E.var_568E = 1;
  if(game["status"] == "overtime") {
    self.var_190E maps\mp\gametypes\_gameobjects::func_86EC("any");
  }

  if(self.var_00E5 == "_a") {
    level.demobombateam = undefined;
  } else if(self.var_00E5 == "_b") {
    level.demobombbteam = undefined;
  }

  foreach(var_01 in level.var_744A) {
    var_01 setclientomnvar("ui_demo_bomb" + self.var_00E5 + "_state", 0);
  }

  setomnvar("ui_bomb" + self.var_00E5 + "_timer_endtime", 0);
  setomnvar("ui_broadcaster_game_mode_status_1", 0);
  self.var_190E notify("bomb_defused");
}

func_6AC9(param_00) {
  param_00 iclientprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

func_6BB6() {
  if(game["teamScores"]["axis"] == game["teamScores"]["allies"]) {
    func_2D63("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(game["teamScores"][game["defenders"]] > game["teamScores"]["allies"]) {
    func_2D63(game["defenders"], game["end_reason"]["time_limit_reached"]);
    return;
  }

  func_2D63(game["attackers"], game["end_reason"]["time_limit_reached"]);
}

func_6B42(param_00) {
  func_2D63("halftime", game["end_reason"][param_00]);
}

func_2D63(param_00, param_01) {
  level.var_3B5C = param_00;
  if(param_01 == game["end_reason"]["target_destroyed"]) {
    var_02 = 1;
    foreach(var_04 in level.var_1913) {
      if(isDefined(level.var_3B52[param_00]) && level.var_3B52[param_00] == var_04.var_5A2D) {
        var_02 = 0;
        break;
      }
    }

    if(var_02) {
      maps\mp\gametypes\_final_killcam::func_3801();
    }
  }

  if(game["status"] == "normal") {
    if(param_01 == game["end_reason"]["target_destroyed"]) {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::func_471A("timelimit") * 60 * 1000 / 2;
    }

    param_00 = "halftime";
    param_01 = game["end_reason"]["switching_sides"];
  } else if(game["status"] == "halftime") {
    if(game["teamScores"]["axis"] == game["teamScores"]["allies"]) {
      param_00 = "overtime";
      param_01 = game["end_reason"]["switching_sides"];
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      param_00 = "axis";
    } else {
      param_00 = "allies";
    }
  }

  thread maps\mp\gametypes\_gamelogic::func_36B9(param_00, param_01);
}

func_21AB() {
  wait 0.05;
  var_00 = 0;
  if(!level.var_0BC3[game["attackers"]]) {
    level.var_90E2[game["attackers"]].var_0C22 = 1;
    var_00 = 1;
  }

  if(!level.var_0BC3[game["defenders"]]) {
    level.var_90E2[game["defenders"]].var_0C22 = 1;
    var_00 = 1;
  }

  if(var_00) {
    maps\mp\gametypes\_spectating::func_A16A();
  }
}