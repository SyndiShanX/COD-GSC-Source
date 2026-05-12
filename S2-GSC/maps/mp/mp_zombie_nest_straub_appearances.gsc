/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_straub_appearances.gsc
*********************************************************/

func_00F9() {
  level.var_943B = spawnStruct();
  level.var_943B.var_5049 = [];
  level.var_943B.var_5049["s2_zom_straub_window_gaze_idle"] = % s2_zom_straub_window_gaze_idle;
  level.var_943B.var_5049["s2_zom_straub_radio_idle"] = % s2_zom_straub_radio_idle;
  level.var_943B.var_5049["s2_zom_straub_table_cleaver_idle"] = % s2_zom_straub_table_cleaver_idle;
  level.var_943B.var_5049["s2_zom_straub_table_hacksaw_idle"] = % s2_zom_straub_table_hacksaw_idle;
  level.var_943B.var_38E6 = [];
  level.var_943B.var_38E6["s2_zom_straub_window_gaze_exit_1"] = % s2_zom_straub_window_gaze_exit_1;
  level.var_943B.var_38E6["s2_zom_straub_window_gaze_exit_2"] = % s2_zom_straub_window_gaze_exit_2;
  level.var_943B.var_38E6["s2_zom_straub_window_gaze_exit_4"] = % s2_zom_straub_window_gaze_exit_4;
  level.var_943B.var_38E6["s2_zom_straub_window_gaze_exit_6"] = % s2_zom_straub_window_gaze_exit_6;
  level.var_943B.var_38E6["s2_zom_straub_table_cleaver_exit_4"] = % s2_zom_straub_table_cleaver_exit_4;
  level.var_943B.var_38E6["s2_zom_straub_table_cleaver_exit_6"] = % s2_zom_straub_table_cleaver_exit_6;
  level.var_943B.var_38E6["s2_zom_straub_table_hacksaw_exit_6"] = % s2_zom_straub_table_hacksaw_exit_6;
  level.var_943B.var_241F = getent("straub_bullet_clip", "targetname");
  level.var_0611["temp_straub_radius"] = loadfx("vfx/weaponimpact/zmb_straub_impact");
  level.var_943B.var_9097 = func_9442();
  if(!isDefined(level.var_943B.var_9097) || level.var_943B.var_9097.size <= 0) {
    return;
  }

  level.var_943B.var_5B51 = undefined;
  level.var_943B.var_50D6 = 0;
  thread func_9447();
  thread func_9445();
}

func_9445() {
  level endon("stop_straub");
  level waittill("player_spawned");
  common_scripts\utility::func_3CA2("gallows_to_com", "med_to_underground", "riverside_to_rooftops");
  thread func_943D();
  while(level.var_943B.var_9097.size > 0) {
    var_00 = func_9446();
    if(!isDefined(var_00)) {
      wait(5);
      continue;
    }

    level.var_943B.var_50D6 = 1;
    level.var_943B.var_2913 = var_00;
    var_00 func_9448();
    level.var_943B.var_50D6 = 0;
    level.var_943B.var_2913 = undefined;
    var_01 = 300;
    var_02 = 420;
    wait(randomfloatrange(var_01, var_02));
  }
}

func_943D(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    lib_0557::func_7870("8B final boss", "final boss battle part 1");
  }

  level notify("stop_straub");
  if(isDefined(level.var_943B)) {
    if(isDefined(level.var_943B.var_241F)) {
      level.var_943B.var_241F delete();
    }

    if(isDefined(level.var_943B.var_2913)) {
      if(isDefined(level.var_943B.var_2913.var_00B9)) {
        level.var_943B.var_2913.var_00B9 delete();
      }

      if(isDefined(level.var_943B.var_2913.var_9A8E)) {
        level.var_943B.var_2913.var_9A8E delete();
      }

      if(isDefined(level.var_943B.var_2913.var_18A8)) {
        killfxontag(common_scripts\utility::func_44F5("temp_straub_radius"), level.var_943B.var_2913.var_18A8, "J_MainRoot");
        level.var_943B.var_2913.var_18A8 delete();
      }
    }

    level.var_943B.var_50D6 = 0;
  }
}

func_9446() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = level.var_943B.var_9097;
  while(!var_00) {
    var_03 = common_scripts\utility::func_7A33(var_02);
    var_04 = func_943C(var_03);
    if(!var_04) {
      var_01 = var_03;
      level.var_943B.var_9097 = common_scripts\utility::func_0F93(level.var_943B.var_9097, var_03);
      var_00 = 1;
      continue;
    }

    var_02 = common_scripts\utility::func_0F93(var_02, var_03);
    if(var_02.size <= 0) {
      break;
    }
  }

  return var_01;
}

func_9442() {
  var_00 = common_scripts\utility::func_46B7("Straub", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      if(!isDefined(var_05.var_0165)) {
        var_02.var_65F8 = var_05;
        var_02.var_65F8.var_565E = 0;
        continue;
      }

      switch (var_05.var_0165) {
        case "straub_trig":
          var_02.var_65F8 = var_05;
          var_02.var_65F8.var_565E = 0;
          break;

        case "straub_look_origin":
          var_02.var_5EB4 = var_05.var_0116;
          break;
      }
    }

    var_02.var_4B56 = 0;
    var_02.var_9A8E = undefined;
    var_02.var_5046 = var_02.var_0165;
    var_02.var_38E4 = var_02.var_0EA4;
    var_02.var_38E5 = var_02.var_819A;
    if(!isDefined(var_02.var_5EB4)) {
      var_02.var_5EB4 = var_02.var_0116;
    }
  }

  return var_00;
}

func_9448() {
  level endon("stop_straub");
  childthread func_944A();
  self.var_18A8 = spawn("script_model", self.var_0116);
  self.var_18A8.var_001D = self.var_001D;
  self.var_18A8 setModel("zom_hero_straub_wholebody");
  self.var_00B9 = spawn("script_model", self.var_0116);
  self.var_00B9 setModel("zom_head_kier_org1");
  self.var_00B9 linkto(self.var_18A8, "j_spineupper", (0, 0, 0), (0, 0, 0));
  if(isDefined(level.var_943B.var_241F)) {
    thread func_943F();
  }

  var_00 = undefined;
  var_01 = undefined;
  if(self.var_5046 == "s2_zom_straub_table_hacksaw_idle") {
    var_00 = "npc_zom_ger_med_saw_01";
    var_01 = "s2_zom_straub_medical_props_hacksaw_idle";
  } else if(self.var_5046 == "s2_zom_straub_table_cleaver_idle") {
    var_00 = "npc_zom_med_knife_02";
    var_01 = "s2_zom_straub_medical_props_cleaver_idle";
  }

  if(isDefined(var_00)) {
    self.var_9A8E = spawn("script_model", self.var_0116);
    self.var_9A8E setModel(var_00);
    self.var_9A8E linkto(self.var_18A8, "TAG_WEAPON_RIGHT", (0, 0, 0), (0, 0, 0));
  }

  while(!self.var_65F8.var_565E) {
    self.var_18A8 method_8278(self.var_5046);
    self.var_00B9 method_8278(self.var_5046);
    wait(getanimlength(level.var_943B.var_5049[self.var_5046]));
  }

  level.var_943B.var_5B51 = gettime();
  self.var_18A8 method_8278(self.var_38E4);
  self.var_00B9 method_8278(self.var_38E4);
  var_02 = 0;
  if(isDefined(self.var_9A8E)) {
    var_03 = getnotetracktimes(level.var_943B.var_38E6[self.var_38E4], "drop_tool");
    var_04 = getanimlength(level.var_943B.var_38E6[self.var_38E4]);
    var_02 = var_03[0] * var_04;
    wait(var_02);
    self.var_9A8E unlink();
  }

  if(isDefined(self.var_38E5)) {
    wait(lib_0547::func_9470(self.var_38E5) - var_02);
    if(isDefined(level.var_943B.var_241F)) {
      level.var_943B.var_241F unlink();
    }

    killfxontag(common_scripts\utility::func_44F5("temp_straub_radius"), self.var_18A8, "J_MainRoot");
    self.var_00B9 delete();
    if(isDefined(self.var_9A8E)) {
      self.var_9A8E delete();
    }

    self.var_18A8 delete();
    self notify("straub_destroyed");
  }
}

func_943F() {
  self endon("straub_destroyed");
  level.var_943B.var_241F.var_0116 = self.var_18A8.var_0116;
  level.var_943B.var_241F linkto(self.var_18A8, "tag_origin", (0, 0, 32), (0, 0, 0));
  level.var_943B.var_241F setCanDamage(1);
  level.var_943B.var_241F thread maps\mp\gametypes\_damage::func_8676(1, undefined, ::func_9440, ::func_943E);
}

func_943E(param_00, param_01, param_02, param_03) {
  thread func_9449();
  if(isDefined(param_00) && isPlayer(param_00)) {
    param_00 maps\mp\gametypes\zombies::func_47C8("ZM_STRAUB");
  }

  return 0;
}

func_9449() {
  if(!common_scripts\utility::func_562E(self.var_299E)) {
    playFX(common_scripts\utility::func_44F5("temp_straub_radius"), self.var_0116 + (0, 0, 32));
    self.var_299E = 1;
    wait(0.25);
    self.var_299E = 0;
  }
}

func_9440(param_00, param_01, param_02, param_03) {
  playFX(common_scripts\utility::func_44F5("temp_straub_radius"), self.var_0116 + (0, 0, 48));
}

func_944A() {
  for(;;) {
    self.var_65F8 waittill("trigger", var_00);
    if(!isPlayer(var_00)) {
      continue;
    }

    if(func_9444(var_00)) {
      self.var_65F8.var_565E = 1;
      self.var_4B56 = 1;
      break;
    }
  }
}

func_9444(param_00) {
  var_01 = func_9441(param_00);
  var_02 = func_9443(var_01);
  if(var_02) {
    var_02 = bullettracepassed(self.var_5EB4, param_00 getEye(), 0, self.var_18A8);
  }

  return var_02;
}

func_9441(param_00) {
  var_01 = self.var_5EB4 - param_00 getEye();
  var_02 = vectornormalize((var_01[0], var_01[1], 0));
  var_03 = anglesToForward(param_00.var_001D);
  var_04 = vectornormalize((var_03[0], var_03[1], 0));
  var_05 = vectordot(var_02, var_04);
  var_05 = clamp(var_05, -1, 1);
  var_06 = acos(var_05);
  return var_06;
}

func_9443(param_00) {
  var_01 = param_00 < 40;
  return var_01;
}

func_943C(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  foreach(var_02 in level.var_744A) {
    if(param_00 func_9444(var_02)) {
      return 1;
    }
  }

  return 0;
}

func_9447() {
  level.var_6DD4 = common_scripts\utility::func_46B7("pa_loudspeaker", "targetname");
  level.var_6DD5 = [];
  level.var_6DD7 = [];
  level.var_6DD6 = [];
  foreach(var_01 in level.var_6DD4) {
    if(!isDefined(var_01.var_0165)) {
      continue;
    }

    var_02 = var_01.var_0165;
    switch (var_02) {
      case "bunker_speaker":
        level.var_6DD5[level.var_6DD5.size] = var_01;
        if(lib_0547::func_5565(var_01.var_8260, "straub_office_speaker")) {
          level.var_6DD6[level.var_6DD6.size] = var_01;
        }
        break;

      case "village_speaker":
        level.var_6DD7[level.var_6DD7.size] = var_01;
        break;
    }
  }

  level.var_943B.var_90C2 = 0;
  level.var_943B.var_3C54 = 0;
  level.var_943B.var_7F00 = 0;
  level.var_943B.var_5D99 = [];
  level.var_943B.var_13B1 = [];
  level.var_943B func_09EF("intro", "zmb_nst01_stra_youmustbeklausfriendsthea", 14, undefined);
  level.var_943B func_09EF("breached", "zmb_nst01_stra_theyvealreadybreachedthel", 9, undefined);
  level.var_943B func_09EF("idiot", "zmb_nst01_stra_thatidiotrichterisstillbu", 10, undefined);
  level.var_943B func_09EF("attuned", "zmb_nst01_stra_iveattunedourelektroschna", 19, undefined);
  level.var_943B func_09EF("magnet", "zmb_nst01_vlogs_stra_log02_01", 15, undefined);
  level.var_943B func_09EF("untota_1", "zmb_nst01_vlogs_stra_log02_16", 31, "untota_2");
  level.var_943B func_09EF("untota_2", "zmb_nst01_vlogs_stra_log02_17", 26, undefined);
  level.var_943B func_09EF("dead_1", "zmb_nst01_vlogs_stra_log03_10", 29, undefined);
  level.var_943B func_09EF("foul_1", "zmb_nst01_vlogs_stra_log03_11", 18, "foul_2");
  level.var_943B func_09EF("foul_2", "zmb_nst01_vlogs_stra_log03_12", 11, undefined);
  level.var_943B func_09EF("protection_1", "zmb_nst01_vlogs_stra_log04_04", 12, "protection_2");
  level.var_943B func_09EF("protection_2", "zmb_nst01_vlogs_stra_log04_05", 14, undefined);
  level.var_943B func_09EF("sword_1", "zmb_nst01_vlogs_stra_log04_07", 26, "sword_2");
  level.var_943B func_09EF("sword_2", "zmb_nst01_vlogs_stra_log04_08", 29, undefined);
  level.var_943B func_09EF("mastery_1", "zmb_nst01_vlogs_stra_log04_10", 30, undefined);
}

func_09EF(param_00, param_01, param_02, param_03) {
  self.var_5D99[param_00] = spawnStruct();
  self.var_5D99[param_00].var_0BB4 = param_01;
  self.var_5D99[param_00].var_3511 = param_02;
  self.var_5D99[param_00].var_3DD3 = param_03;
  if(!issubstr(param_00, "_2") && !issubstr(param_00, "_3") && !issubstr(param_00, "_4")) {
    self.var_13B1[self.var_13B1.size] = param_00;
  }
}

func_7CFC(param_00) {
  if(!issubstr(param_00, "_2") && !issubstr(param_00, "_3") && !issubstr(param_00, "_4")) {
    level.var_943B.var_13B1 = common_scripts\utility::func_0F93(level.var_943B.var_13B1, param_00);
  }
}

func_46B3(param_00) {
  var_01 = level.var_943B.var_5D99[param_00].var_0BB4;
  var_02 = level.var_943B.var_5D99[param_00].var_3511;
  var_03 = undefined;
  if(isDefined(level.var_943B.var_5D99[param_00].var_3DD3)) {
    var_03 = level.var_943B.var_5D99[param_00].var_3DD3;
  }

  return [var_01, var_02, var_03];
}

func_74E1(param_00, param_01) {
  level endon("straub_taunt_force_stop");
  lib_0378::func_8D74("play_pa_dialog", param_00, level.var_6DD7, level.var_6DD5);
  wait(param_01);
}

func_93F6() {
  level notify("straub_taunt_force_stop");
  lib_0378::func_8D74("stop_pa_dialog");
}

func_74E2(param_00, param_01) {
  if(level.var_7F24 == 0) {
    return;
  }

  if(common_scripts\utility::func_562E(level.var_22F0)) {
    return;
  }

  if(common_scripts\utility::func_562E(level.blimpvoplaying)) {
    return;
  }

  if(level.var_943B.var_50D6) {
    if(isDefined(level.var_943B.var_2913)) {
      if(func_943C(level.var_943B.var_2913)) {
        return;
      } else if(isDefined(level.var_943B.var_2913.var_18A8)) {
        level.var_943B.var_2913.var_18A8 method_805C();
        level.var_943B.var_2913.var_00B9 method_805C();
        if(isDefined(level.var_943B.var_2913.var_9A8E)) {
          level.var_943B.var_2913.var_9A8E method_805C();
        }
      }
    }
  }

  var_02 = undefined;
  var_03 = undefined;
  var_04 = 0;
  var_05 = undefined;
  if(!level.var_943B.var_3C54) {
    var_02 = "intro";
    var_06 = func_46B3(var_02);
    var_03 = var_06[0];
    var_04 = var_06[1];
    var_05 = var_06[2];
    level.var_943B.var_90C2 = 1;
    lib_0378::func_8D74("snd_zmb_mus_stop_all_players", 4);
    wait(2);
    thread func_74E1(var_03, var_04);
    level.var_943B.var_3C54 = 1;
    wait(var_04);
    level.var_943B.var_90C2 = 0;
    func_7CFC(var_02);
  } else {
    if(level.var_943B.var_90C2) {
      return;
    }

    if(level.var_943B.var_13B1.size == 0) {
      return;
    }

    if(level.var_943B.var_7F00 < 3 && !common_scripts\utility::func_562E(param_00) && !common_scripts\utility::func_562E(param_01)) {
      level.var_943B.var_7F00++;
      return;
    }

    if((common_scripts\utility::func_24A6() || common_scripts\utility::func_562E(param_00)) && !common_scripts\utility::func_562E(param_01)) {
      level.var_943B.var_90C2 = 1;
      lib_0378::func_8D74("snd_zmb_mus_stop_all_players", 4);
      wait(2);
      var_02 = common_scripts\utility::func_7A33(level.var_943B.var_13B1);
      var_07 = func_46B3(var_02);
      var_03 = var_07[0];
      var_04 = var_07[1];
      var_05 = var_07[2];
      if(!isDefined(var_03)) {
        return;
      }

      if(!isDefined(var_05)) {
        func_74E1(var_03, var_04);
        func_7CFC(var_02);
      } else {
        for(;;) {
          func_74E1(var_03, var_04);
          func_7CFC(var_02);
          if(isDefined(var_05)) {
            var_02 = var_05;
            var_08 = func_46B3(var_02);
            var_03 = var_08[0];
            var_04 = var_08[1];
            var_05 = var_08[2];
            continue;
          }

          break;
        }
      }

      level.var_943B.var_90C2 = 0;
      level.var_943B.var_7F00 = 0;
    } else {
      lib_0378::func_8D74("snd_zmb_mus_stop_all_players", 4);
      lib_0378::func_8D74("play_pa_music", level.var_6DD6);
    }
  }

  if(level.var_943B.var_50D6) {
    if(isDefined(level.var_943B.var_2913) && isDefined(level.var_943B.var_2913.var_18A8)) {
      level.var_943B.var_2913.var_18A8 method_805B();
      level.var_943B.var_2913.var_00B9 method_805B();
      if(isDefined(level.var_943B.var_2913.var_9A8E)) {
        level.var_943B.var_2913.var_9A8E method_805B();
        return;
      }
    }
  }
}