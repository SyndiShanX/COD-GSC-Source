/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\common_sd_sr.gsc
**********************************************/

func_4CB0(param_00, param_01) {
  var_02 = 0;
  if(param_00 == "_a") {
    var_02 = var_02 | 1;
  } else {
    var_02 = var_02 | 2;
  }

  if(isDefined(param_01)) {
    if(param_01 == "ninja_defuse") {
      var_02 = var_02 | 4;
    } else if(param_01 == "last_man_defuse") {
      var_02 = var_02 | 8;
    }
  }

  return var_02;
}

func_6B86() {
  game["bomb_dropped_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_dropped_enemy_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_recovered_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_grabbed_sound"] = "mp_snd_bomb_pickup";
  game["bomb_planted_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_disarm_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_sml";
}

func_A121() {
  level.var_7078 = maps\mp\_utility::func_3516("planttime", 5, 0, 20);
  level.var_2CA9 = maps\mp\_utility::func_3516("defusetime", 5, 0, 20);
  level.var_1909 = maps\mp\_utility::func_3516("bombtimer", 45, 1, 300);
  level.var_6510 = maps\mp\_utility::func_3517("multibomb", 0, 0, 1);
  level.var_8C56 = maps\mp\_utility::func_3517("silentplant", 0, 0, 1);
}

func_872D() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", game["attackers"], "defaultClass", 5, "class", "inUse")) {
    level.var_832B[game["attackers"]] = maps\mp\_utility::func_4573(game["attackers"], 5);
  }
}

func_5782(param_00) {
  if(isDefined(level.var_1913)) {
    foreach(var_02 in level.var_1913) {
      if(distancesquared(self.var_0116, var_02.var_9D65.var_0116) < 16384) {
        return 0;
      }
    }
  }

  if(isDefined(level.var_832F)) {
    if(distancesquared(self.var_0116, level.var_832F.var_9D65.var_0116) < 16384) {
      return 0;
    }
  }

  return 1;
}

func_6B5C(param_00, param_01, param_02) {
  if(game["state"] == "postgame" && param_00.var_01A7 == game["defenders"] || !level.var_18F9) {
    param_01.var_3B4B = 1;
  }

  if(func_A870(param_00, param_01)) {
    var_03 = func_5742(param_01);
    param_01 thread maps\mp\_events::func_35D2(var_03, param_00);
  }
}

func_254C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isPlayer(param_01)) {
    return;
  }

  if(isDefined(self.var_568D) && self.var_568D) {
    self.var_568D = 0;
    if(self.var_01A7 == game["attackers"]) {
      var_0A = 0;
      foreach(var_0C in level.var_744A) {
        if(var_0C != self && var_0C.var_01A7 == self.var_01A7 && isalive(var_0C)) {
          var_0A++;
        }
      }

      if(var_0A > 0) {
        maps\mp\_utility::func_5C39("bomb_lost", self.var_01A7);
      }
    }
  }

  if(maps\mp\gametypes\_damage::func_56FA(self, param_01)) {
    return;
  }

  if(param_01 == self) {
    return;
  }

  var_0E = self;
  if(var_0E.var_5777 || var_0E.var_56C2) {
    param_01 thread maps\mp\_events::func_2C80(var_0E, param_09, param_04);
    param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
    if(var_0E.var_5777) {
      param_01 maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_interrupt");
    }

    if(var_0E.var_56C2) {
      param_01 maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_protector");
      maps\mp\_utility::func_863E(13, param_01.var_01A7, param_01 getentitynumber());
    }
  }
}

func_A870(param_00, param_01) {
  if(maps\mp\gametypes\_damage::func_56FA(param_00, param_01)) {
    return 0;
  }

  if(param_00 maps\mp\gametypes\_playerlogic::func_60B2()) {
    return 0;
  }

  return 1;
}

func_6B62(param_00) {
  param_00.var_568D = 1;
  if(param_00.var_01A7 == "allies") {
    param_00.var_0112 = 1;
  } else {
    param_00.var_0112 = 2;
  }

  if(isPlayer(param_00)) {
    param_00 thread maps\mp\_matchdata::func_5E93("pickup", param_00.var_0116);
    param_00 setclientomnvar("ui_carrying_bomb", 1);
    param_00 thread maps\mp\gametypes\_hud_message::func_9102("bomb_pickedup");
    maps\mp\_utility::func_863E(15, param_00.var_01A7, param_00 getentitynumber());
  }

  maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_escort");
  maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_escort", undefined, 1);
  if(isDefined(level.var_832B) && isDefined(level.var_832B[param_00.var_01A7])) {
    param_00.var_57A7 = 1;
    param_00 thread func_0F2F();
  }

  if(!level.var_18D3) {
    maps\mp\_utility::func_9863("callout_bombtaken", param_00, param_00.var_01A7);
    maps\mp\_utility::func_5C39("bomb_taken", param_00.var_012C["team"]);
  }

  maps\mp\_utility::func_74D9(game["bomb_recovered_sound"], game["attackers"]);
  param_00 method_8615(game["bomb_grabbed_sound"]);
  param_00 setgametypevip(1);
}

func_18FD() {
  level.var_18F9 = 0;
  level.var_18D3 = 0;
  level.var_18EE = 0;
  level.var_7069 = undefined;
  level.iconbomb = "waypoint_caster_bomb";
  level.icontarget = "waypoint_caster_target";
  level.icondefuse = "waypoint_caster_defuse";
  var_00 = getent("sd_bomb_pickup_trig", "targetname");
  if(!isDefined(var_00)) {
    common_scripts\utility::func_3809("No sd_bomb_pickup_trig trigger found in map.");
    return;
  }

  var_01[0] = getent("sd_bomb", "targetname");
  if(!isDefined(var_01[0])) {
    common_scripts\utility::func_3809("No sd_bomb script_model found in map.");
    return;
  }

  var_01[0] setModel("npc_gen_s_and_d_bomb");
  if(!level.var_6510) {
    level.var_832F = maps\mp\gametypes\_gameobjects::func_27D6(game["attackers"], var_00, var_01, (0, 0, 32), 0, 0, 1);
    level.var_832F maps\mp\gametypes\_gameobjects::func_0C1D("friendly");
    level.var_832F maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_bomb");
    level.var_832F maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_bomb", undefined, 1);
    level.var_832F maps\mp\gametypes\_gameobjects::func_8A60("friendly");
    if(game["attackers"] == "axis") {
      maps\mp\_utility::func_863F(level.var_832F, level.iconbomb, 1, 1);
    } else {
      maps\mp\_utility::func_863F(level.var_832F, level.iconbomb, 2, 1);
    }

    level.var_832F.var_0C33 = 1;
    level.var_832F.var_6B62 = ::func_6B62;
    level.var_832F.var_6AEF = ::func_6AEF;
    level.var_832F.var_1F84 = ::func_1F79;
  } else {
    var_00 delete();
    var_01[0] delete();
  }

  level.var_1913 = [];
  var_02 = getEntArray("bombzone", "targetname");
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_00 = var_02[var_03];
    var_01 = getEntArray(var_02[var_03].var_01A2, "targetname");
    var_04 = maps\mp\gametypes\_gameobjects::func_2837(game["defenders"], var_00, var_01, (0, 0, 64));
    var_04 maps\mp\gametypes\_gameobjects::func_0C30("enemy");
    var_04 maps\mp\gametypes\_gameobjects::func_8A5A(level.var_7078);
    var_04 maps\mp\gametypes\_gameobjects::func_8A57(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
    if(!level.var_6510) {
      var_04 maps\mp\gametypes\_gameobjects::func_86B5(level.var_832F);
    }

    var_05 = var_04 maps\mp\gametypes\_gameobjects::func_454C();
    var_04.var_00E5 = var_05;
    var_04 maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defend" + var_05);
    var_04 maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defend" + var_05, undefined, 1);
    var_04 maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_target" + var_05);
    var_04 maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_target" + var_05, undefined, 1);
    var_04 maps\mp\gametypes\_gameobjects::func_8A60("any");
    if(game["attackers"] == "axis") {
      maps\mp\_utility::func_863F(var_04, level.icontarget + var_05, 2, 1);
    } else {
      maps\mp\_utility::func_863F(var_04, level.icontarget + var_05, 1, 1);
    }

    var_04.var_6ABC = ::func_6ABC;
    var_04.var_6AFA = ::func_6AFA;
    var_04.var_681A = 1;
    var_04.var_502A = "bombZone";
    var_04.var_6BBF = ::func_6BC8;
    var_04.var_6AC9 = ::func_6AC9;
    var_04.var_A248 = "search_dstry_bomb_mp";
    var_04.var_18F9 = 0;
    for(var_06 = 0; var_06 < var_01.size; var_06++) {
      if(isDefined(var_01[var_06].var_8186)) {
        var_04.var_3947 = var_01[var_06].var_8186;
        var_01[var_06] thread func_8A29(var_04);
        break;
      }
    }

    level.var_1913[level.var_1913.size] = var_04;
    var_04.var_18D5 = getent(var_01[0].var_01A2, "targetname");
    var_04.var_18D5.var_0116 = var_04.var_18D5.var_0116 + (0, 0, -10000);
    var_04.var_18D5.var_00E5 = var_05;
    var_04.var_18D5 usetriggertouchcheckstance(1);
  }

  for(var_03 = 0; var_03 < level.var_1913.size; var_03++) {
    var_07 = [];
    for(var_08 = 0; var_08 < level.var_1913.size; var_08++) {
      if(var_08 != var_03) {
        var_07[var_07.size] = level.var_1913[var_08];
      }
    }

    level.var_1913[var_03].var_6C61 = var_07;
  }

  setomnvar("ui_broadcaster_game_mode_status_1", 0);
}

func_6BC8(param_00) {
  if(!maps\mp\gametypes\_gameobjects::func_56FB(param_00.var_012C["team"])) {
    level thread func_18F9(self, param_00);
    if(isDefined(param_00.var_568D) && param_00.var_568D) {
      param_00.var_568D = 0;
    }

    for(var_01 = 0; var_01 < level.var_1913.size; var_01++) {
      if(level.var_1913[var_01] == self) {
        var_02 = level.var_1913[var_01] maps\mp\gametypes\_gameobjects::func_454C();
        if(game["attackers"] == "axis") {
          maps\mp\_utility::func_863F(level.var_1913[var_01], level.icondefuse, 1, 1);
        } else {
          maps\mp\_utility::func_863F(level.var_1913[var_01], level.icondefuse, 2, 1);
        }

        continue;
      }

      level.var_1913[var_01] maps\mp\gametypes\_gameobjects::func_2F93();
      maps\mp\_utility::func_863F(level.var_1913[var_01], undefined, undefined, 1);
    }

    self.var_18F9 = 1;
    param_00 notify("bomb_planted");
    var_03 = 2;
    if(self.var_00E5 == "_a") {
      var_03 = 1;
    }

    maps\mp\_utility::func_863E(3, param_00.var_01A7, param_00 getentitynumber(), var_03);
    var_04 = func_4CB0(self.var_00E5);
    param_00 thread maps\mp\_events::func_18FC(var_04);
    maps\mp\_utility::func_5C39("bomb_planted");
    maps\mp\_utility::func_74D9(game["bomb_planted_sound"], game["attackers"]);
    maps\mp\_utility::func_74D9(game["bomb_planted_enemy_sound"], game["defenders"]);
    if(isDefined(level.var_832B) && isDefined(level.var_832B[param_00.var_01A7])) {
      param_00 thread func_7CD2();
    }

    level.var_18F8 = param_00;
    param_00.var_18FB = gettime();
    return;
  }

  self.var_18F9 = 0;
}

func_7156(param_00) {
  var_01 = common_scripts\utility::func_0F93(level.var_744A, param_00);
  if(var_01.size) {
    param_00 maps\mp\_utility::func_74C3("snd_bomb_wheels_lp", undefined, var_01);
  }
}

func_93D6(param_00) {
  param_00 common_scripts\utility::func_93D5("snd_bomb_wheels_lp");
}

func_8A29(param_00) {
  var_01 = spawn("script_origin", self.var_0116);
  var_01.var_001D = self.var_001D;
  var_01 rotateyaw(-45, 0.05);
  wait 0.05;
  var_02 = self.var_0116 + (0, 0, 5);
  var_03 = self.var_0116 + anglesToForward(var_01.var_001D) * 100 + (0, 0, 160);
  var_04 = bulletTrace(var_02, var_03, 0, self);
  self.var_5A2C = spawn("script_model", var_04["position"]);
  self.var_5A2C setscriptmoverkillcam("explosive");
  param_00.var_5A2D = self.var_5A2C getentitynumber();
  var_01 delete();
}

func_6ABC(param_00) {
  param_00 method_812A(0);
  if(maps\mp\gametypes\_gameobjects::func_56FB(param_00.var_012C["team"])) {
    if(!level.var_8C56 && !param_00 maps\mp\_utility::func_0649("specialty_improvedobjectives")) {
      param_00 maps\mp\_utility::func_67F4("defuse");
      level thread func_7156(param_00);
    }

    param_00.var_56C2 = 1;
    var_01 = func_4CB0(self.var_00E5);
    param_00 thread maps\mp\_matchdata::func_5E93("bomb_defuse_start", param_00.var_0116, var_01);
    param_00 setgametypevip(1);
    maps\mp\_utility::func_863E(4, param_00.var_01A7, param_00 getentitynumber());
    if(isDefined(level.var_8330)) {
      level.var_8330 method_805C();
      stopFXOnTag(common_scripts\utility::func_44F5("search_dstry_bomb_arming_light"), level.var_8330, "tag_fx");
    }
  } else {
    var_02 = 2;
    if(self.var_00E5 == "_a") {
      var_02 = 1;
    }

    maps\mp\_utility::func_863E(14, param_00.var_01A7, param_00 getentitynumber(), var_02);
    if(!level.var_8C56 && !param_00 maps\mp\_utility::func_0649("specialty_improvedobjectives")) {
      param_00 maps\mp\_utility::func_67F4("plant");
      level thread func_7156(param_00);
    }

    param_00.var_5777 = 1;
    var_01 = func_4CB0(self.var_00E5);
    param_00 thread maps\mp\_matchdata::func_5E93("bomb_plant_start", param_00.var_0116, var_01);
    if(level.var_6510) {
      for(var_03 = 0; var_03 < self.var_6C61.size; var_03++) {
        self.var_6C61[var_03] maps\mp\gametypes\_gameobjects::func_0C30("none");
        self.var_6C61[var_03] maps\mp\gametypes\_gameobjects::func_8A60("friendly");
      }
    }
  }

  function_0226(&"broadcaster_start_use_bomb", 1, param_00 getentitynumber());
}

func_6AFA(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    return;
  }

  param_01 setgametypevip(0);
  param_01 method_812A(1);
  if(isalive(param_01)) {
    param_01.var_56C2 = 0;
    param_01.var_5777 = 0;
  }

  level thread func_93D6(param_01);
  if(maps\mp\gametypes\_gameobjects::func_56FB(param_01.var_012C["team"])) {
    if(isDefined(level.var_8330) && !param_02) {
      level.var_8330 thread common_scripts\utility::func_2CB7();
    }
  } else if(level.var_6510 && !param_02) {
    for(var_03 = 0; var_03 < self.var_6C61.size; var_03++) {
      self.var_6C61[var_03] maps\mp\gametypes\_gameobjects::func_0C30("enemy");
      self.var_6C61[var_03] maps\mp\gametypes\_gameobjects::func_8A60("any");
    }
  }

  function_0226(&"broadcaster_start_use_bomb", 1, -1);
}

func_18FA(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 playerlinkto(level.var_8330);
  while(param_00 getcurrentweapon() == self.var_A248) {
    wait 0.05;
  }

  param_00 unlink();
}

func_18F9(param_00, param_01) {
  level notify("bomb_planted", param_00);
  maps\mp\gametypes\_gamelogic::func_6F27();
  level.var_18F9 = 1;
  level.var_7069 = param_00;
  param_01.var_0112 = 0;
  if(isPlayer(param_01)) {
    param_01 setclientomnvar("ui_carrying_bomb", 0);
  }

  param_00.var_A582[0] thread maps\mp\gametypes\_gamelogic::func_74E5();
  level.var_99C0 = param_00.var_A582[0];
  level.var_99F5 = 1;
  level.var_2CA0 = int(gettime() + level.var_1909 * 1000);
  setgameendtime(level.var_2CA0);
  if(!level.var_6510) {
    level.var_832F maps\mp\gametypes\_gameobjects::func_0C1D("none");
    level.var_832F maps\mp\gametypes\_gameobjects::func_8A60("none");
    maps\mp\_utility::func_863F(level.var_832F, undefined, undefined, 1);
    level.var_832F maps\mp\gametypes\_gameobjects::func_866E(0.6);
    level.var_8330 = level.var_832F.var_A582[0];
    param_01 lib_0468::func_0A22("sdPlant");
  } else {
    level.var_8330 = spawn("script_model", param_01.var_0116);
    level.var_8330.var_001D = param_01.var_001D;
    level.var_8330 setModel("npc_gen_s_and_d_bomb");
  }

  level.bomboutlineactive = 1;
  var_02 = maps\mp\_utility::func_46D4(game["attackers"]);
  level.var_8330 method_86CC(level.var_744A, var_02, 0);
  foreach(var_04 in level.broadcasters) {
    if(var_04.var_1E99.var_A4A8 == "third_person") {
      level.var_8330 hudoutlineenableforclient(var_04, var_02, 0);
      continue;
    }

    level.var_8330 hudoutlinedisableforclient(var_04);
  }

  playFXOnTag(common_scripts\utility::func_44F5("search_dstry_bomb_arming_light"), level.var_8330, "tag_fx");
  param_00 maps\mp\gametypes\_gameobjects::func_0C30("none");
  param_00 maps\mp\gametypes\_gameobjects::func_8A60("none");
  var_06 = param_00 maps\mp\gametypes\_gameobjects::func_454C();
  setomnvar("ui_bomb" + var_06 + "_state", 1);
  var_07 = param_00.var_18D5;
  var_07.var_0116 = level.var_8330.var_0116;
  var_08 = [];
  var_09 = maps\mp\gametypes\_gameobjects::func_2837(game["defenders"], var_07, var_08, (0, 0, 32));
  var_09 maps\mp\gametypes\_gameobjects::func_0C30("friendly");
  var_09 maps\mp\gametypes\_gameobjects::func_8A5A(level.var_2CA9);
  var_09 maps\mp\gametypes\_gameobjects::func_8A57(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_09 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_09 maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defuse" + var_06);
  var_09 maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_defend" + var_06);
  var_09 maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defuse" + var_06, undefined, 1);
  var_09 maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_defend" + var_06, undefined, 1);
  var_09.var_00E5 = var_06;
  var_09.var_6ABC = ::func_6ABC;
  var_09.var_6AFA = ::func_6AFA;
  var_09.var_6BBF = ::func_6BC3;
  var_09.var_681A = 1;
  var_09.var_502A = "defuseObject";
  var_09.var_A248 = "search_dstry_bomb_defuse_mp";
  if(var_06 == "_a" || var_06 == "_A") {
    setomnvar("ui_broadcaster_game_mode_status_1", 1);
  } else if(var_06 == "_b" || var_06 == "_B") {
    setomnvar("ui_broadcaster_game_mode_status_1", 2);
  }

  maps\mp\_utility::func_74D8("mp_snd_bomb_drop", level.var_8330.var_0116 + (0, 0, 1));
  func_190B(var_06);
  param_00.var_A582[0] maps\mp\gametypes\_gamelogic::func_9415();
  level.bomboutlineactive = 0;
  level.var_8330 hudoutlinedisable();
  if(level.var_3F9D || level.var_18D3) {
    return;
  }

  level.var_18EE = 1;
  setomnvar("ui_broadcaster_game_mode_status_1", 0);
  setomnvar("ui_bomb" + var_06 + "_state", 2);
  if(isDefined(level.var_832C)) {
    level thread[[level.var_832C]]();
  } else {
    var_0A = level.var_8330.var_0116;
    var_0B = var_0A;
    var_0A = var_0A + (0, 0, 10);
    level.var_8330 method_805C();
    stopFXOnTag(common_scripts\utility::func_44F5("search_dstry_bomb_arming_light"), level.var_8330, "tag_fx");
    if(isDefined(param_01)) {
      param_00.var_A582[0] entityradiusdamage(var_0A, 512, 300, 20, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
      param_00.var_A582[0] entityradiusdamage(param_00.var_A582[0].var_0116 + (0, 0, 75), 512, 300, 20, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_0C = func_4CB0(var_06);
      param_01 thread maps\mp\_events::func_18D6(var_0C);
    } else {
      param_00.var_A582[0] entityradiusdamage(var_0A, 512, 300, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
      param_00.var_A582[0] entityradiusdamage(param_00.var_A582[0].var_0116 + (0, 0, 75), 512, 300, 20, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    var_0D = "bomb_explosion";
    if(isDefined(param_00.var_9D65.var_359B)) {
      var_0D = param_00.var_9D65.var_359B;
    }

    var_0E = randomfloat(360);
    var_0F = spawnfx(level.var_0611[var_0D], var_0B, (0, 0, 1), (cos(var_0E), sin(var_0E), 0));
    triggerfx(var_0F);
    physicsexplosionsphere(var_0B, 200, 100, 3);
    function_01BB("grenade_rumble", var_0A);
    earthquake(0.75, 2, var_0A, 2000);
    thread maps\mp\_utility::func_74D8("mp_snd_bomb_detonated", var_0A);
    if(isDefined(param_00.var_3947)) {
      common_scripts\_exploder::func_392A(param_00.var_3947);
    }
  }

  for(var_10 = 0; var_10 < level.var_1913.size; var_10++) {
    level.var_1913[var_10] maps\mp\gametypes\_gameobjects::func_2F93();
  }

  var_0B maps\mp\gametypes\_gameobjects::func_2F93();
  setgameendtime(0);
  wait(3);
  if(common_scripts\utility::func_562E(level.var_5677)) {
    level.var_832F.var_9D65 notify("obj_complete");
    return;
  }

  func_832A(game["attackers"], game["end_reason"]["target_destroyed"]);
}

func_190B(param_00) {
  level endon("game_ended");
  level endon("bomb_defused");
  var_01 = int(level.var_1909 * 1000 + gettime());
  setomnvar("ui_bomb" + param_00 + "_timer_endtime", var_01);
  level thread func_4ACC(param_00, var_01);
  maps\mp\gametypes\_hostmigration::func_A6F4(level.var_1909);
}

func_4ACC(param_00, param_01) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb" + param_00 + "_timer_endtime", 0);
  var_02 = maps\mp\gametypes\_hostmigration::func_A782();
  if(var_02 > 0) {
    setomnvar("ui_bomb" + param_00 + "_timer_endtime", param_01 + var_02);
  }
}

func_6AEF(param_00) {
  if(isDefined(param_00)) {
    param_00 setgametypevip(0);
  }

  maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_bomb");
  maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_bomb", undefined, 1);
  maps\mp\_utility::func_74D9(game["bomb_dropped_sound"], game["attackers"]);
  maps\mp\_utility::func_74D9(game["bomb_dropped_enemy_sound"], game["defenders"]);
  if(isDefined(param_00) && isDefined(param_00.var_568D) && param_00.var_568D) {
    param_00.var_568D = 0;
  }
}

func_1F79(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  return 1;
}

func_6BC3(param_00) {
  param_00 notify("bomb_defused");
  level thread func_18D3();
  maps\mp\gametypes\_gameobjects::func_2F93();
  setomnvar("ui_bomb" + self.var_00E5 + "_state", 0);
  maps\mp\_utility::func_5C39("bomb_defused_attackers", game["attackers"]);
  maps\mp\_utility::func_5C39("bomb_defused_defenders", game["defenders"]);
  maps\mp\_utility::func_74D9(game["bomb_disarm_enemy_sound"], game["attackers"]);
  maps\mp\_utility::func_74D9(game["bomb_disarm_sound"], game["defenders"]);
  var_01 = "defuse";
  if(isDefined(level.var_18F8) && maps\mp\_utility::func_57A0(level.var_18F8)) {
    var_01 = "ninja_defuse";
  }

  if(func_5742(param_00) && isDefined(self) && isDefined(self.var_6DB2) && getteamplayersalive(maps\mp\_utility::func_45DE(self.var_6DB2)) > 0) {
    var_01 = "last_man_defuse";
  }

  var_02 = func_4CB0(self.var_00E5, var_01);
  param_00 thread maps\mp\_events::func_18D4(var_01, var_02);
}

func_5742(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00) {
      continue;
    }

    if(var_02.var_01A7 != param_00.var_01A7) {
      continue;
    }

    if(var_02 maps\mp\gametypes\_playerlogic::func_60B2()) {
      return 0;
    }

    if(maps\mp\_utility::func_57A0(var_02)) {
      return 0;
    }
  }

  return 1;
}

func_18D3() {
  level.var_99C0 maps\mp\gametypes\_gamelogic::func_9415();
  level.var_18D3 = 1;
  setomnvar("ui_broadcaster_game_mode_status_1", 0);
  level notify("bomb_defused");
  wait(1.5);
  setgameendtime(0);
  func_832A(game["defenders"], game["end_reason"]["bomb_defused"]);
}

func_6AC9(param_00) {
  param_00 iclientprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

func_6BB6() {
  func_832A(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

func_832A(param_00, param_01) {
  level.var_3B5C = param_00;
  if(param_01 == game["end_reason"]["target_destroyed"] || param_01 == game["end_reason"]["bomb_defused"]) {
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

  maps\mp\gametypes\_gamescore::func_47BD(param_00, 1, 1);
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

func_6AE2(param_00) {
  if(level.var_18EE || level.var_18D3) {
    return;
  }

  if(param_00 == "all") {
    if(level.var_18F9) {
      func_832A(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
      return;
    }

    func_832A(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    return;
  }

  if(param_00 == game["attackers"]) {
    if(level.var_18F9) {
      return;
    }

    level thread func_832A(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    return;
  }

  if(param_00 == game["defenders"]) {
    level thread func_832A(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    return;
  }
}

func_6B5E(param_00) {
  if(level.var_18EE || level.var_18D3) {
    return;
  }

  var_01 = maps\mp\_utility::func_454F(param_00);
  var_01 thread func_478F();
}

func_478F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::func_A78E(3);
  var_00 = maps\mp\_utility::func_45DE(self.var_012C["team"]);
  level thread maps\mp\_utility::func_9863("callout_lastteammemberalive", self, self.var_012C["team"]);
  level thread maps\mp\_utility::func_9863("callout_lastenemyalive", self, var_00);
  level notify("last_alive", self);
  maps\mp\_utility::func_863E(16, self.var_01A7, self getentitynumber());
  maps\mp\gametypes\_missions::func_5BBD();
}

func_6B93() {}

func_0F2F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.var_56A3) && self.var_56A3 == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  while(self method_82E4()) {
    wait 0.05;
  }

  while(!self isonground()) {
    wait 0.05;
  }

  self.var_012C["gamemodeLoadout"] = level.var_832B[self.var_01A7];
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
}

func_7B84() {
  var_00 = self getweaponslistoffhands();
  foreach(var_02 in var_00) {
    self method_84AF(var_02);
  }
}

func_7CD2() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.var_56A3) && self.var_56A3 == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  while(self method_82E4()) {
    wait 0.05;
  }

  while(!self isonground()) {
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