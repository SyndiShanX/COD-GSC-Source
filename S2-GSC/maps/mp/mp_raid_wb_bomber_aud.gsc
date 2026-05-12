/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_wb_bomber_aud.gsc
*********************************************/

func_00F9() {
  thread func_257F();
  func_5260();
  func_51D8();
  maps\mp\_audio_submixes::func_524C();
  func_5C22();
  func_5C18();
  func_27A3();
  func_7649();
  func_7BD2();
  lib_02F0::func_8014("sndentity");
}

func_257F() {}

func_5260() {}

init_plane_data() {
  self.var_11CB = spawnStruct();
  self.var_11CB.var_CAC = 0;
  self.var_11CB.var_863 = 0;
  self.var_11CB.p47_throttle_pitch = 1;
  self.var_11CB.p47_throttle_on = 0;
  self.var_11CB.p47_brake_on = 0;
  self.var_11CB.var_AA3E = 0;
  self.var_11CB.acceleration_vol_boost = 0;
  self.var_11CB.acceleration_start_sounds_on = 1;
}

func_51D8() {
  level.var_9B88 = 0;
  level.var_14CB = ["bulge_b17_death_01", "bulge_b17_death_02", "bulge_b17_death_03", "bulge_b17_death_04", "bulge_b17_death_05"];
  level.var_14CC = ["bulge_b17_death_by_01", "bulge_b17_death_by_02", "bulge_b17_death_by_03", "bulge_b17_death_by_04", "bulge_b17_death_by_05"];
  level.var_7252 = ["bulge_player_death_spin_close_1", "bulge_player_death_spin_close_2", "bulge_player_death_spin_close_3", "bulge_player_death_spin_close_4"];
  level.var_72F7 = ["blg_player_p47_collision1", "blg_player_p47_collision2", "blg_player_p47_collision3", "blg_player_p47_collision4", "blg_player_p47_collision5"];
}

func_5C22() {}

func_5C18() {}

func_27A3() {
  level.var_11CB.var_37EE = [];
  level.var_11CB.var_37EE["example_envelop"] = [[0, 0], [0.082, 0.426], [0.238, 0.736], [0.408, 0.844], [0.756, 0.953], [1, 1]];
}

func_7649() {}

func_7BD2() {}

func_65B0(param_00, param_01) {
  thread func_65B2(param_00, param_01);
}

func_65B2(param_00, param_01) {}

func_6DD0() {}

func_6DD1() {}

func_6DBE() {
  var_00 = self method_8251();
  if(!isDefined(var_00)) {
    return;
  }

  self endon("death");
  var_00 endon("death");
  thread func_62E3();
  var_01 = -80000;
  var_02 = (0, 50, 0);
  var_03 = maps\mp\_audio_submixes::func_8004("blg_p47_engine_plr_lp", "stop_p47_sounds", 0.5, 0.5, 0, var_02, "prop");
  var_04 = maps\mp\_audio_submixes::func_8004("blg_p47_dive_tone_lp", "stop_p47_sounds", 0.5, 0.5, 0, var_02, "prop");
  var_05 = maps\mp\_audio_submixes::func_8004("blg_p47_wind_tail_lp", "stop_p47_sounds", 0.5, 0.5, 0, var_02, "prop");
  var_06 = 1;
  var_04 thread func_31E3("diving");
  var_03 thread func_31E3("normal");
  var_05 thread func_AA26();
  thread func_31CE();
  thread func_6DCD();
  thread func_1585();
  thread func_AA3E();
  thread func_31D8();
  self notify("aud_throttle_start");
}

func_AA26() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self getlinkedparent();
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = var_00 method_8251();
  if(!isDefined(var_01)) {
    return;
  }

  self endon("stop_p47_sounds");
  self endon("death");
  var_02 = 0.05;
  while(isDefined(var_00) == 1) {
    var_03 = var_00.var_1D[0];
    if(var_03 > 180) {
      var_03 = abs(var_03 - 360);
    }

    var_04 = lib_02EF::func_8086(var_03, 40, 70, 0, 1);
    if(var_00.var_11CB.p47_throttle_on) {
      var_04 = var_04 + 0.5;
    }

    var_04 = clamp(var_04, 0, 1);
    lib_02EF::func_8AAF(var_04, var_02, "easeinout");
    wait(var_02);
  }
}

func_7ED5() {}

func_6FFF() {}

func_1585() {
  var_00 = self method_8251();
  if(!isDefined(var_00)) {
    return;
  }

  if(function_01EF(var_00)) {
    return;
  }

  self endon("stop_p47_sounds");
  self endon("death");
  var_01 = 0.05;
  var_02 = 0;
  var_03 = 0;
  var_04 = 5;
  var_05 = 20;
  var_06 = 4;
  var_07 = 19;
  var_08 = 45;
  var_09 = 40;
  var_0A = 40;
  var_0B = 100;
  var_0C = 100;
  var_0D = 0;
  var_0E = 0;
  var_0F = 0;
  var_10 = undefined;
  var_11 = ["blg_p47_banking1", "blg_p47_banking2", "blg_p47_banking3", "blg_p47_banking4"];
  var_12 = ["blg_p47_banking_end1", "blg_p47_banking_end2", "blg_p47_banking_end3", "blg_p47_banking_end4", "blg_p47_banking_end5"];
  while(isDefined(self) == 1) {
    var_13 = abs(self.var_1D[2]);
    var_14 = abs(self.var_1D[0]);
    var_15 = var_00 getnormalizedmovement()[0];
    if(var_14 > 180) {
      var_14 = abs(var_14 - 360);
    }

    var_16 = lib_02EF::func_8086(var_13, var_04, var_09, 0, 1);
    var_17 = lib_02EF::func_8086(var_14, var_05, var_0A, 0, 1);
    var_18 = max(var_16, var_17);
    var_19 = lib_02EF::func_8086(var_18, 0, 1, 1, 1.25992);
    if(var_13 >= var_04 && var_02 == 0 && self.var_11CB.var_863 == 0) {
      var_1A = lib_02EF::func_42DD(var_11, "rolling_aliases", 2);
      self.var_11CB.var_5C4 = maps\mp\_audio_submixes::func_8001(var_1A, "stop_rolling_sound", 0, 1);
      thread func_7ED5();
      var_02 = 1;
      var_0C = 0;
    } else if(var_13 < var_06 && var_02 == 1) {
      var_02 = 0;
      self notify("stop_rolling_sound");
    }

    if(var_13 > var_08 && var_15 <= -0.9) {
      var_0F = 1;
      var_0D = 0;
      var_00 maps\mp\_audio_submixes::func_8A9D("bulge_dogfight_hard_bank");
    } else if(var_13 <= var_08 && var_0F == 1) {
      var_1B = lib_02EF::func_42DD(var_12, "rolling_end_aliases", 3);
      var_10 = maps\mp\_audio_submixes::func_8001(var_1B, "stop_rolling_end_sound");
      var_0F = 0;
      var_00 maps\mp\_audio_submixes::func_8A9F("bulge_dogfight_hard_bank");
    }

    var_0D++;
    var_0C++;
    if(var_0C > 90) {}

    if(var_14 >= var_05 && var_03 == 0 && self.var_11CB.var_863 == 0) {
      var_1C = lib_02EF::func_42DD(var_11, "pitching_aliases", 2);
      self.var_11CB.var_5C3 = maps\mp\_audio_submixes::func_8001(var_1C, "stop_pitching_sound", 0, 1);
      thread func_6FFF();
      self notify("stop_accelerate_sound");
      var_03 = 1;
      var_0B = 0;
      var_00 maps\mp\_audio_submixes::func_8A9D("bulge_dogfight_pitching", 0.6);
    } else if(var_14 < var_07 && var_03 == 1) {
      var_03 = 0;
      self notify("stop_pitching_sound");
      var_00 maps\mp\_audio_submixes::func_8A9F("bulge_dogfight_pitching", 0.6);
    }

    var_0B++;
    if(var_0B > 90) {}

    if(isDefined(self.var_11CB.var_5C4)) {
      self.var_11CB.var_5C4 lib_02EF::func_8AAF(var_16, var_01, "easein");
      self.var_11CB.var_5C4 lib_02EF::func_8AAC(var_19, var_01, "easein");
      if(var_16 == 0) {
        self notify("stop_rolling_sound");
        var_02 = 0;
      }
    }

    if(isDefined(self.var_11CB.var_5C3)) {
      self.var_11CB.var_5C3 lib_02EF::func_8AAF(var_17, var_01, "easein");
      self.var_11CB.var_5C3 lib_02EF::func_8AAC(var_19, var_01, "easein");
      if(var_17 == 0) {
        self notify("stop_pitching_sound");
        var_00 maps\mp\_audio_submixes::func_8A9F("bulge_dogfight_pitching", 0.6);
        var_03 = 0;
      }
    }

    if(self.var_11CB.var_863 == 1) {
      self notify("stop_pitching_sound");
      self notify("stop_rolling_sound");
    }

    wait(var_01);
  }
}

func_62E3() {
  self endon("stop_p47_sounds");
  self endon("death");
  var_00 = self.var_116[2];
  while(isDefined(self) == 1) {
    var_01 = self.var_116[2];
    self.var_11CB.var_CAC = var_01 - var_00;
    var_00 = var_01;
    wait 0.05;
  }
}

getnormalizedcameramovement_hack() {
  if(!isDefined(self.eyeangles_prev_timestamp) || gettime() == self.eyeangles_prev_timestamp) {
    self.eyeangles_prev_timestamp = gettime();
    self.eyeangles_prev = self geteyeangles();
  }

  var_00 = self geteyeangles() - self.eyeangles_prev;
  return var_00;
}

func_31E3(param_00) {
  if(!isDefined(self)) {
    return;
  }

  var_01 = self getlinkedparent();
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = var_01 method_8251();
  if(!isDefined(var_02)) {
    return;
  }

  if(function_01EF(var_02)) {
    return;
  }

  self endon("stop_p47_sounds");
  self endon("death");
  var_03 = 0.05;
  var_04 = 1;
  var_05 = [0, 0, 0, 0];
  var_06 = [0.01, 0.08, 0.03, 0.08];
  var_07 = 0;
  var_08 = 1;
  var_09 = 0.01;
  var_0A = 0;
  while(isDefined(var_01) == 1) {
    var_0B = var_02 getnormalizedcameramovement_hack()[0];
    var_0C = var_02 getnormalizedcameramovement_hack()[1];
    for(var_0D = 0; var_0D < 2; var_0D++) {
      if(var_05[var_0D] < var_0B) {
        var_05[var_0D] = var_05[var_0D] + var_06[var_0D];
        continue;
      }

      if(var_05[var_0D] > var_0B) {
        var_05[var_0D] = var_05[var_0D] - var_06[var_0D];
      }
    }

    var_0E = abs(abs(var_05[0]) - abs(var_05[1]));
    if(var_0E < var_09) {
      var_0E = 0;
    }

    for(var_0D = 2; var_0D < 4; var_0D++) {
      if(var_05[var_0D] < var_0C) {
        var_05[var_0D] = var_05[var_0D] + var_06[var_0D];
        continue;
      }

      if(var_05[var_0D] > var_0C) {
        var_05[var_0D] = var_05[var_0D] - var_06[var_0D];
      }
    }

    var_0F = abs(abs(var_05[2]) - abs(var_05[3]));
    if(var_0F < var_09) {
      var_0F = 0;
    }

    var_07 = clamp(var_0E + var_0F, 0, 1);
    var_07 = lib_02EF::func_8086(var_07, 0, 1, 0.4, 0.6);
    var_10 = lib_02EF::func_8086(abs(var_01.var_1D[2]), 0, 100, 0, 1);
    var_10 = clamp(var_10, 0, 1);
    if(param_00 == "diving") {
      var_0A = lib_02EF::func_8086(var_01.var_11CB.var_CAC, -120, 0, 1, -0.5);
      var_10 = 0;
    }

    var_11 = lib_02EF::func_8086(var_07 + var_0A + var_10, 0, 1, 0.2, 1);
    var_08 = lib_02EF::func_8086(var_07, 0.3, 1, 0, -0.1);
    var_12 = lib_02EF::func_8086(var_01.var_11CB.var_CAC, -300, 300, 1.3, -0.2) + var_08 + var_01.var_11CB.p47_throttle_pitch;
    var_11 = clamp(var_11, 0, 1);
    var_12 = clamp(var_12, 0.5, 2);
    lib_02EF::func_8AAF(var_11, var_03);
    lib_02EF::func_8AAC(var_12, var_03);
    wait(var_03);
  }
}

func_31CE() {
  var_00 = self method_8251();
  if(!isDefined(var_00)) {
    return;
  }

  if(function_01EF(var_00)) {
    return;
  }

  self endon("stop_p47_sounds");
  self endon("death");
  var_01 = ["blg_p47_accelerate_start1", "blg_p47_accelerate_start2", "blg_p47_accelerate_start3", "blg_p47_accelerate_start4", "blg_p47_accelerate_start5", "blg_p47_accelerate_start6", "blg_p47_accelerate_start7", "blg_p47_accelerate_start8"];
  var_02 = ["blg_p47_accelerate1", "blg_p47_accelerate2", "blg_p47_accelerate3"];
  var_03 = ["blg_p47_banking_end1", "blg_p47_banking_end2", "blg_p47_banking_end3", "blg_p47_banking_end4", "blg_p47_banking_end5"];
  var_04 = 0.05;
  var_05 = 0;
  var_06 = 0;
  while(isDefined(self) == 1) {
    var_07 = var_00 getnormalizedmovement()[0];
    var_08 = self method_8283();
    var_08 = lib_02EF::func_8086(var_08, 130, 260, 0, 1);
    if(self.var_11CB.p47_brake_on == 0 && var_07 <= -0.5) {
      self.var_11CB.p47_brake_on = 1;
      self.var_11CB.acceleration_vol_boost = 0;
      self notify("stop_accelerate_sound");
      var_09 = lib_02EF::func_42DD(var_03, "brake_aliases", 3);
      var_0A = maps\mp\_audio_submixes::func_8001(var_09, "stop_brake_sound", 0, 0.5);
    } else if(var_07 < 0.5 && var_07 >= 0 && self.var_11CB.p47_throttle_on == 1 || self.var_11CB.p47_brake_on == 1) {
      self.var_11CB.p47_throttle_on = 0;
      self.var_11CB.p47_brake_on = 0;
      var_00 maps\mp\_audio_submixes::func_8A9F("bulge_dogfight_accelerate_hold", 0.5);
      self notify("stop_accelerate_sound");
    } else if(self.var_11CB.p47_throttle_on == 0 && var_07 >= 0.5) {
      self.var_11CB.p47_throttle_on = 1;
      thread maps\mp\_audio_submixes::func_6262("bulge_dogfight_accelerate_start", 1, 1.2, 2.5);
      thread maps\mp\_audio_submixes::func_6262("bulge_dogfight_accelerate_start_wind", 1, 2, 2, 0.5);
      var_00 maps\mp\_audio_submixes::func_8A9D("bulge_dogfight_accelerate_hold", 0.6);
      if(self.var_11CB.acceleration_start_sounds_on) {
        var_0B = lib_02EF::func_8086(var_05, 0, 40, 0, 1);
        var_0C = lib_02EF::func_42DD(var_01, "accelerate_start_aliases", 4);
        var_0D = maps\mp\_audio_submixes::func_8001(var_0C, "stop_accelerate_sound", 0, 0.5, var_0B);
        var_05 = 0;
        var_0E = lib_02EF::func_42DD(var_02, "accelerate_aliases", 2);
        var_0F = maps\mp\_audio_submixes::func_8001(var_0E, "stop_accelerate_sound", 0.05, 0.5);
        var_0F lib_02EF::func_8AAC(1.6, 6);
      }
    }

    wait(var_04);
    var_05++;
  }
}

func_6DCD() {
  var_00 = self method_8251();
  if(function_01EF(var_00)) {
    return;
  }

  self endon("stop_p47_sounds");
  self endon("death");
  self waittill("aud_throttle_start");
  for(;;) {
    if(self.var_11CB.p47_throttle_on && self.var_11CB.p47_throttle_pitch <= 1.5) {
      self.var_11CB.p47_throttle_pitch = self.var_11CB.p47_throttle_pitch * 1.01;
    } else if(self.var_11CB.p47_brake_on && self.var_11CB.p47_throttle_pitch > 0.707) {
      self.var_11CB.p47_throttle_pitch = self.var_11CB.p47_throttle_pitch * 0.99;
    } else if(!self.var_11CB.p47_throttle_on && self.var_11CB.p47_throttle_pitch > 1) {
      self.var_11CB.p47_throttle_pitch = self.var_11CB.p47_throttle_pitch * 0.99;
    } else if(!self.var_11CB.p47_brake_on && self.var_11CB.p47_throttle_pitch < 1) {
      self.var_11CB.p47_throttle_pitch = self.var_11CB.p47_throttle_pitch * 1.01;
    }

    wait 0.05;
  }
}

func_14D7() {
  self endon("death");
  var_00 = ["blg_b17_plane_bullet_impact_1", "blg_b17_plane_bullet_impact_2", "blg_b17_plane_bullet_impact_3", "blg_b17_plane_bullet_impact_4", "blg_b17_plane_bullet_impact_5", "blg_b17_plane_bullet_impact_6", "blg_b17_plane_bullet_impact_7", "blg_b17_plane_bullet_impact_8", "blg_b17_plane_bullet_impact_9", "blg_b17_plane_bullet_impact_10", "blg_b17_plane_bullet_impact_11", "blg_b17_plane_bullet_impact_12", "blg_b17_plane_bullet_impact_13", "blg_b17_plane_bullet_impact_14", "blg_b17_plane_bullet_impact_15"];
  while(isDefined(self)) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05);
    if(!isDefined(var_04)) {
      continue;
    }

    var_06 = 0;
    if(isDefined(var_02)) {
      if(var_02 == self) {
        continue;
      }

      var_07 = lib_02EF::func_42DD(var_00, "b17_plane_impact_aliases", 7);
      maps\mp\_audio_submixes::func_7FFA(var_07, self.var_116);
      maps\mp\_audio_submixes::func_7FFA("blg_17_plane_bullet_impact_close", self.var_116);
    }
  }
}

func_14CE() {
  thread func_14CF();
  thread func_14CD();
}

func_31DA() {
  var_00 = self method_8251();
  var_01 = var_00 getentitynumber();
  var_02 = lib_02EF::func_42DD(level.var_7252, "player_death_spin_aliases", 2);
  maps\mp\_audio_submixes::func_7FF9(var_02, "player_death_spin_stop" + var_01, 0, 2, undefined, [var_00]);
  maps\mp\_audio_submixes::func_7FF9("blg_player_p47_death_propeller", "player_death_spin_stop" + var_01, 0, 0.2, undefined, [var_00]);
  maps\mp\_audio_submixes::func_7FF9("blg_player_p47_death_fire", "player_death_spin_stop" + var_01, undefined, undefined, undefined, [var_00]);
}

func_31DB(param_00) {
  maps\mp\_audio_submixes::func_7FFA("bulge_plane_destruct_exp_vclose", self.var_116);
  maps\mp\_audio_submixes::func_7FFA("bulge_plane_destruct_trans", self.var_116);
  maps\mp\_audio_submixes::func_7FFA("bulge_plane_destruct_sub", self.var_116);
  maps\mp\_audio_submixes::func_7FFA("bulge_plane_destruct_metal", self.var_116);
  level notify("player_death_spin_stop" + param_00);
  level notify("shut_off_cockpit_alarm" + param_00);
}

watch_for_health_restore(param_00) {
  level endon("shut_off_cockpit_alarm" + param_00);
  for(;;) {
    if(self.var_BC > self.var_FB * 0.4) {
      level notify("shut_off_cockpit_alarm" + param_00);
      return;
    }

    wait 0.05;
  }
}

func_31D8() {
  var_00 = self method_8251();
  level endon("outro_continueVO");
  self endon("death");
  var_01 = var_00 getentitynumber();
  while(self.var_BC > self.var_FB * 0.4) {
    wait(0.1);
  }

  lib_0378::func_8D74("dogfight_player_collision_burning");
  childthread watch_for_health_restore(var_01);
  var_02 = maps\mp\_audio_submixes::func_8002("blg_player_p47_cockpit_alarm_lp", "shut_off_cockpit_alarm" + var_01, 0, 0.1, undefined, [var_00]);
  wait(1);
  var_02 lib_02EF::func_8AAF(0.251, 4);
}

func_14CF() {
  self endon("b17_remove");
  self endon("death");
  self waittill("b17_death_sound");
  var_00 = undefined;
  var_01 = "stop_b17_death_sound_" + lib_0378::func_8D86();
  var_02 = lib_02EF::func_42DD(level.var_14CB, "b17_death_aliases", 2);
  var_03 = maps\mp\_audio_submixes::func_8001(var_02, var_01, 0, 1, 1, var_00, "body_animate_jnt");
  wait 0.05;
  self waittill("stop_b17_death_sound");
  self notify(var_01);
}

func_14CD() {
  self endon("b17_remove");
  self endon("death");
  self waittill("b17_death_sound");
  wait(0.8);
  var_00 = undefined;
  var_01 = 0;
  var_02 = 50;
  for(;;) {
    var_03 = self gettagorigin("body_animate_jnt");
    if(var_02 < 50) {
      if(var_01 == 0 && var_02 >= 50) {
        var_01 = 1;
        var_02 = 0;
        var_04 = lib_02EF::func_42DD(level.var_14CC, "b17_death_by_aliases", 2);
        var_05 = maps\mp\_audio_submixes::func_8001(var_04, var_00, 0, 1, 1, var_00, "body_animate_jnt");
      } else if(var_02 < 50) {
        var_01 = 0;
        var_02 = var_02 + 1;
      }
    } else {
      var_01 = 0;
    }

    wait 0.05;
  }
}

func_AA3E() {
  var_00 = self method_8251();
  level endon("death");
  self endon("stop_p47_sounds");
  self endon("death");
  var_01 = 35;
  var_02 = 35;
  var_03 = 0;
  while(isDefined(self)) {
    var_04 = self.var_1D;
    var_05 = var_04[2];
    if((var_05 > var_01 && var_05 < 360 - var_01) || var_05 < -1 * var_01 && var_05 > -1 * 360 - var_01) {
      var_03 = 1;
    } else {
      var_03 = 0;
    }

    if(isDefined(self) && self.var_11CB.var_AA3E == 0 && var_03 == 1) {
      self.var_11CB.var_AA3E = 1;
      var_06 = maps\mp\_audio_submixes::func_8004("blg_wing_vapor_lp", "aud_stop_wing_vapor", 0.25, 1.5);
      var_07 = maps\mp\_audio_submixes::func_8004("blg_wing_vibration_lp", "aud_stop_wing_vibration", 2, 0.5);
      var_00 maps\mp\_audio_submixes::func_8A9D("bulge_dogfight_vapor", 2);
      continue;
    }

    if(self.var_11CB.var_AA3E == 1 && var_03 == 0) {
      self notify("aud_stop_wing_vapor");
      self notify("aud_stop_wing_vibration");
      self.var_11CB.var_AA3E = 0;
      var_00 maps\mp\_audio_submixes::func_8A9F("bulge_dogfight_vapor", 0.7);
    }

    wait 0.05;
  }
}