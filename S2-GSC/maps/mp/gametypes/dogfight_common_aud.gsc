/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dogfight_common_aud.gsc
*****************************************************/

init_dogfight_audio() {
  lib_02F0::func_7FE7();
  func_51D8();
  maps\mp\_audio_submixes::func_524C();
  func_5C22();
  func_7BD2();
  lib_02F0::func_8014("sndentity");
}

init_plane_data() {
  self.var_11CB = spawnStruct();
  self.var_11CB.var_0CAC = 0;
  self.var_11CB.var_0863 = 0;
  self.var_11CB.p47_throttle_pitch = 1;
  self.var_11CB.p47_throttle_on = 0;
  self.var_11CB.p47_brake_on = 0;
  self.var_11CB.acceleration_vol_boost = 0;
}

func_51D8() {
  level.var_9B88 = 0;
}

func_5C22() {
  level thread init_dogfight_submix();
}

func_7BD2() {
  lib_0378::func_8DC7("aud_figher_spawn", ::fighter_spawn);
  lib_0378::func_8DC7("p47_turret_plr", ::func_6DD0);
  lib_0378::func_8DC7("aud_fighter_start_death", ::fighter_start_death);
  lib_0378::func_8DC7("aud_fighter_final_explosion", ::fighter_final_explosion);
  lib_0378::func_8DC7("aud_fighter_damage_state_change", ::fighter_damage_state_change);
}

init_dogfight_submix() {
  lib_0380::func_6840("amb_mp_husky_ext_dog_fight", undefined, 7);
}

fighter_spawn() {
  var_00 = self method_8251();
  var_00 maps\mp\_audio_submixes::func_8A9D("mp_dogfight");
  self.var_11CB = spawnStruct();
  self.var_11CB.var_0CAC = 0;
  self.var_11CB.var_0863 = 0;
  self.var_11CB.p47_throttle_pitch = 1;
  self.var_11CB.p47_throttle_on = 0;
  self.var_11CB.p47_brake_on = 0;
  self.var_11CB.acceleration_vol_boost = 0;
  self.var_11CB.hard_bank = 0;
  self.var_11CB.pitching = 0;
  common_scripts\utility::func_3C87("damage_state_1");
  common_scripts\utility::func_3C87("damage_state_2");
  thread func_6DBE();
}

p47_watch_game_end(param_00, param_01) {
  level waittill("game_ended");
  param_00 endon("death");
  param_01 endon("death");
  param_01 notify("stop_p47_sounds");
}

func_6DBE() {
  wait(0.4);
  var_00 = self method_8251();
  if(!isDefined(var_00)) {
    return;
  }

  self endon("death");
  var_00 endon("death");
  self notify("stop_p47_sounds");
  var_01 = lib_0380::func_6847("blg_p47_engine_plr_lp", undefined, self, 1, 1, 0.5, self, "stop_p47_sounds");
  var_02 = lib_0380::func_6847("blg_p47_turn_lp", var_00, self, 1, 1, 0.5, self, "stop_p47_sounds");
  var_03 = lib_0380::func_6847("blg_p47_rattle_lp", var_00, self, 1, 1, 0.5, self, "stop_p47_sounds");
  var_04 = lib_0380::func_6847("blg_wind_lp", var_00, self, 1, 1, 0.5, self, "stop_p47_sounds");
  thread main_engine_loop(var_01);
  thread func_1585(var_02, var_03);
  thread func_AA25(var_04);
  var_00 thread raid_flyby_watcher(var_00.var_01A7);
  thread dogfight_close_loop(var_00, var_00.var_01A7);
  thread p47_watch_game_end(var_00, self);
}

main_engine_loop(param_00) {
  var_01 = self method_8251();
  if(!isDefined(var_01)) {
    return;
  }

  self endon("stop_p47_sounds");
  self endon("death");
  var_02 = ["blg_p47_accelerate_start1", "blg_p47_accelerate_start2", "blg_p47_accelerate_start3"];
  var_03 = ["blg_p47_brake1", "blg_p47_brake2", "blg_p47_brake3"];
  self.var_11CB.engine_pitch_multiplier = 1;
  self.var_11CB.engine_vol_multiplier = 0.5;
  var_04 = 0.5;
  var_05 = 0;
  while(isDefined(self) == 1) {
    var_06 = var_01 getnormalizedmovementx();
    if(var_06 <= -0.5 && self.var_11CB.pitching == 0) {
      if(self.var_11CB.p47_brake_on == 0) {
        self.var_11CB.p47_brake_on = 1;
        self notify("stop_accelerate_sound");
        var_07 = lib_02EF::func_42DD(var_03, "brake_aliases", 3);
        var_08 = lib_0380::func_6844(var_07, var_01, self, 0, 1);
      }

      self.var_11CB.engine_pitch_multiplier = self.var_11CB.engine_pitch_multiplier * 0.99;
      if(self.var_11CB.engine_pitch_multiplier < 0.8) {
        self.var_11CB.engine_pitch_multiplier = 0.85;
      }

      self.var_11CB.engine_vol_multiplier = self.var_11CB.engine_vol_multiplier * 1.1;
      if(self.var_11CB.engine_vol_multiplier > 1) {
        self.var_11CB.engine_vol_multiplier = 1;
      }
    } else if(var_06 < 0.5 && var_06 >= 0 && self.var_11CB.pitching == 0) {
      if(self.var_11CB.p47_throttle_on == 1 || self.var_11CB.p47_brake_on == 1) {
        self.var_11CB.p47_throttle_on = 0;
        self.var_11CB.p47_brake_on = 0;
      }

      if(self.var_11CB.engine_pitch_multiplier > 1) {
        self.var_11CB.engine_pitch_multiplier = self.var_11CB.engine_pitch_multiplier * 0.99;
      } else if(self.var_11CB.engine_pitch_multiplier < 1) {
        self.var_11CB.engine_pitch_multiplier = self.var_11CB.engine_pitch_multiplier * 1.01;
      }

      if(self.var_11CB.engine_vol_multiplier > var_04) {
        self.var_11CB.engine_vol_multiplier = self.var_11CB.engine_vol_multiplier * 0.99;
      } else if(self.var_11CB.engine_vol_multiplier < var_04) {
        self.var_11CB.engine_vol_multiplier = self.var_11CB.engine_vol_multiplier * 1.01;
      }
    } else if(var_06 >= 0.5 || self.var_11CB.pitching == 1) {
      if(self.var_11CB.p47_throttle_on == 0) {
        self.var_11CB.p47_throttle_on = 1;
        var_09 = lib_02EF::func_42DD(var_02, "accelerate_start_aliases", 4);
        var_0A = lib_0380::func_6844(var_09, var_01, self, 0, 1);
      }

      self.var_11CB.engine_pitch_multiplier = self.var_11CB.engine_pitch_multiplier * 1.01;
      if(self.var_11CB.engine_pitch_multiplier > 1.4) {
        self.var_11CB.engine_pitch_multiplier = self.var_11CB.engine_pitch_multiplier * 0.998;
      }

      if(self.var_11CB.engine_pitch_multiplier > 1.6) {
        self.var_11CB.engine_pitch_multiplier = 1.6;
      }

      self.var_11CB.engine_vol_multiplier = self.var_11CB.engine_vol_multiplier * 1.1;
      if(self.var_11CB.engine_vol_multiplier > 1) {
        self.var_11CB.engine_vol_multiplier = 1;
      }
    }

    lib_0380::func_684D(param_00, self.var_11CB.engine_pitch_multiplier, 0.05);
    if(isDefined(self.var_11CB.duck_engine_for_turn) && self.var_11CB.duck_engine_for_turn == 1) {
      self.var_11CB.engine_vol_multiplier = self.var_11CB.engine_vol_multiplier * 0.98;
      if(self.var_11CB.engine_vol_multiplier < 0.1) {
        self.var_11CB.engine_vol_multiplier = 0.1;
      }
    }

    if(isDefined(self.var_11CB.duck_engine_for_turn) && self.var_11CB.duck_engine_for_turn == 0) {
      if(self.var_11CB.engine_vol_multiplier < var_04) {
        self.var_11CB.engine_vol_multiplier = self.var_11CB.engine_vol_multiplier + 0.1;
      }
    }

    if(self.var_11CB.engine_vol_multiplier > 1) {
      self.var_11CB.engine_vol_multiplier = 1;
    }

    lib_0380::func_684E(param_00, self.var_11CB.engine_vol_multiplier, 0.05);
    wait 0.05;
  }
}

func_1585(param_00, param_01) {
  var_02 = self method_8251();
  if(!isDefined(var_02)) {
    return;
  }

  self endon("stop_p47_sounds");
  self endon("death");
  var_03 = 0.05;
  var_04 = 0;
  var_05 = 0;
  var_06 = 5;
  var_07 = 4;
  var_08 = 25;
  var_09 = 20;
  var_0A = 19;
  var_0B = undefined;
  var_0C = 0;
  var_0D = 0;
  var_0E = 0;
  var_0F = 0;
  var_10 = undefined;
  var_11 = 0;
  var_12 = 0;
  var_13 = 40;
  var_14 = 40;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0.1;
  var_18 = 1;
  var_19 = 0.1;
  while(isDefined(self) == 1) {
    var_1A = self.var_001D[2];
    var_1B = abs(var_1A);
    var_1C = abs(self.var_001D[0]);
    var_1D = var_02 getnormalizedmovementx();
    var_1E = lib_02EF::func_8086(var_1B, var_06, var_13, 0, 1);
    var_1F = var_1E;
    if(isDefined(var_10)) {
      var_11 = abs(var_1A - var_10);
    }

    if(isDefined(var_0B)) {
      var_0E = abs(var_1C - var_0B);
    }

    var_20 = lib_02EF::func_8086(var_0E, 0, 1.5, 0, 1);
    if(var_1B >= var_06) {
      if(var_11 > 8 && var_12 > 20) {
        var_04 = 1;
        var_12 = 0;
        if(isDefined(self.var_11CB.var_05C4)) {
          lib_0380::func_6850(self.var_11CB.var_05C4, 1);
        }

        self.var_11CB.var_05C4 = lib_0380::func_6844("blg_p47_banking", var_02, self);
      } else if(var_04 == 0) {
        var_04 = 1;
        var_12 = 0;
        if(isDefined(self.var_11CB.var_05C4)) {
          lib_0380::func_6850(self.var_11CB.var_05C4, 1);
        }

        self.var_11CB.var_05C4 = lib_0380::func_6844("blg_p47_banking", var_02, self);
      }

      if(var_19 < 1) {
        var_19 = var_19 + 0.03;
      }
    }

    var_12 = var_12 + 1;
    if(var_1B < var_07) {
      if(var_04 == 1) {
        var_04 = 0;
      }

      if(var_19 > 0.05) {
        var_19 = var_19 - 0.03;
        var_04 = 0;
      }
    }

    if(var_1B > var_08) {
      var_16 = var_16 + 1;
      if(var_16 > 55) {
        self.var_11CB.duck_engine_for_turn = 1;
        var_0F = 1;
        if(var_17 < 1) {
          var_17 = var_17 + 0.02;
        }

        if(var_18 < 1.6) {
          var_18 = var_18 + 0.004;
        }
      }
    } else {
      var_16 = 0;
      self.var_11CB.duck_engine_for_turn = 0;
      if(var_17 > 0) {
        var_17 = var_17 - 0.1;
      }

      if(var_18 > 1) {
        var_18 = var_18 - 0.01;
      }

      if(var_0F == 1) {
        var_0F = 0;
        lib_0380::func_6844("blg_p47_banking_end", var_02, self);
      }
    }

    if(var_0E > 1) {
      var_0C = var_0C + 1;
      if(var_0C > 3 && self.var_11CB.pitching == 0) {
        self.var_11CB.pitching = 1;
        var_0D = 0;
        if(var_04 == 0) {
          lib_0380::func_6844("blg_p47_pitching_start", var_02, self);
        }
      }
    } else {
      var_0D = var_0D + 1;
      if(var_0D > 3 && self.var_11CB.pitching == 1) {
        var_0C = 0;
        self.var_11CB.pitching = 0;
      }
    }

    if(var_1B > var_08 && var_1D <= -0.9) {
      self.var_11CB.hard_bank = 1;
    } else {
      self.var_11CB.hard_bank = 0;
    }

    if(isDefined(self.var_11CB.var_05C4)) {
      var_21 = lib_02EF::func_8086(var_1E, 0, 1, 0.05, 1);
      lib_0380::func_684E(self.var_11CB.var_05C4, var_21, 0.05);
      var_22 = lib_02EF::func_8086(self.var_11CB.engine_pitch_multiplier, 0.8, 1.6, 0.9, 1.3);
      lib_0380::func_684D(self.var_11CB.var_05C4, var_22, 0.05);
    }

    if(var_17 > 1) {
      var_17 = 1;
    }

    if(var_17 < 0) {
      var_17 = 0;
    }

    lib_0380::func_684E(param_00, var_17, 0.05);
    lib_0380::func_684D(param_00, var_18, 0.05);
    if(var_19 > 1) {
      var_19 = 1;
    }

    lib_0380::func_684E(param_01, var_19, 0.05);
    var_0B = var_1C;
    var_10 = var_1A;
    wait(var_03);
  }
}

func_AA25(param_00) {
  wait 0.05;
  var_01 = 0.3;
  while(isDefined(self) == 1) {
    if(self.var_11CB.p47_throttle_on == 1 || self.var_11CB.hard_bank == 1) {
      var_01 = var_01 + 0.02;
    } else if(var_01 > 0.3) {
      var_01 = var_01 - 0.02;
    }

    if(var_01 > 1) {
      var_01 = 1;
    }

    lib_0380::func_684E(param_00, var_01, 0.05);
    wait 0.05;
  }
}

func_6DD0() {
  var_00 = self method_8251();
  if(function_01EF(var_00)) {
    return;
  }

  self notify("handle_p47_firing_loop");
  self endon("handle_p47_firing_loop");
  level endon("dogfight_done");
  var_00 endon("death");
  self endon("death");
  var_01 = 0;
  var_02 = undefined;
  var_03 = 1;
}

raid_flyby_watcher(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("stop_p47_sounds");
  level endon("dogfight_done");
  var_01 = 15000;
  var_02 = 200;
  var_03 = 150;
  var_04 = 9500;
  var_05 = 160;
  var_06 = 100;
  var_07 = 5000;
  var_08 = 80;
  var_09 = 120;
  var_0A = 75;
  var_0B = 1;
  var_0C = 0.75;
  var_0D = 0.3;
  var_0E = 1;
  self.plane_data = [];
  var_0F = ["husky_dogfight_flyby_close_02", "husky_dogfight_flyby_close_04", "husky_dogfight_flyby_close_07", "husky_dogfight_flyby_close_13", "husky_dogfight_flyby_close_15", "husky_dogfight_flyby_close_16", "husky_dogfight_flyby_close_23", "husky_dogfight_flyby_close_25", "husky_dogfight_flyby_close_26", "husky_dogfight_flyby_close_27", "husky_dogfight_flyby_close_28", "husky_dogfight_flyby_close_29", "husky_dogfight_flyby_close_30", "husky_dogfight_flyby_close_31", "husky_dogfight_flyby_close_32"];
  var_10 = ["blg_dogfight_flyby_swt1", "blg_dogfight_flyby_swt2", "blg_dogfight_flyby_swt3", "blg_dogfight_flyby_swt4", "blg_dogfight_flyby_swt5", "blg_dogfight_flyby_swt6"];
  var_11 = ["blg_dogfight_flyby_mid_01", "blg_dogfight_flyby_mid_02", "blg_dogfight_flyby_mid_03", "blg_dogfight_flyby_mid_04", "blg_dogfight_flyby_mid_05", "blg_dogfight_flyby_mid_06", "blg_dogfight_flyby_mid_07", "blg_dogfight_flyby_mid_08", "blg_dogfight_flyby_mid_09", "blg_dogfight_flyby_mid_10", "blg_dogfight_flyby_mid_11", "blg_dogfight_flyby_mid_12", "blg_dogfight_flyby_mid_13", "blg_dogfight_flyby_mid_14"];
  var_12 = ["blg_dogfight_flyby_far_01", "blg_dogfight_flyby_far_02", "blg_dogfight_flyby_far_03", "blg_dogfight_flyby_far_04", "blg_dogfight_flyby_far_05", "blg_dogfight_flyby_far_06", "blg_dogfight_flyby_far_07", "blg_dogfight_flyby_far_08", "blg_dogfight_flyby_far_09", "blg_dogfight_flyby_far_10", "blg_dogfight_flyby_far_11", "blg_dogfight_flyby_far_12", "blg_dogfight_flyby_far_13", "blg_dogfight_flyby_far_14", "blg_dogfight_flyby_far_15", "blg_dogfight_flyby_far_16", "blg_dogfight_flyby_far_17"];
  for(;;) {
    foreach(var_14 in level.var_744A) {
      var_15 = var_14.var_2418;
      var_16 = var_14 method_85E2();
      if(var_14 == self || !isDefined(var_16)) {
        continue;
      }

      if(var_14.var_01A7 == self.var_01A7) {
        var_0B = var_0C;
      } else {
        var_0B = 1;
      }

      if(!isDefined(self.plane_data[var_15])) {
        self.plane_data[var_15] = spawnStruct();
        self.plane_data[var_15].var_3018 = 20001;
        self.plane_data[var_15].distantloopstarted = 0;
        self.plane_data[var_15].closeloopstarted = 0;
        self.plane_data[var_15].closeoneshotstarted = 0;
        self.plane_data[var_15].midoneshotstarted = 0;
        self.plane_data[var_15].faroneshotstarted = 0;
        self.plane_data[var_15].closetimer = 200;
        self.plane_data[var_15].midtimer = 200;
        self.plane_data[var_15].fartimer = 200;
      }

      self.plane_data[var_15].lastdistance = self.plane_data[var_15].var_3018;
      self.plane_data[var_15].var_3018 = distance(self.var_0116, var_14.var_0116);
      self.plane_data[var_15].approachspeed = self.plane_data[var_15].lastdistance - self.plane_data[var_15].var_3018;
      if(self.plane_data[var_15].var_3018 < var_07) {
        if(self.plane_data[var_15].approachspeed > var_08 && self.plane_data[var_15].closeoneshotstarted == 0 && self.plane_data[var_15].closetimer >= var_0A) {
          self.plane_data[var_15].closeoneshotstarted = 1;
          self.plane_data[var_15].closetimer = 0;
          var_0E = common_scripts\utility::func_AA4A(self.var_0116, self.var_001D, var_16.var_0116, cos(45));
          if(isDefined(var_0E) && var_0E == 0) {
            var_0B = var_0B * var_0D;
          }

          var_17 = lib_02EF::func_42DD(var_0F, "dogfight_close_flybys", 7);
          self.plane_data[var_15].close_flybysound = lib_0380::func_288E(var_17, self, var_16, 0, var_0B, 3, "stop_damage_engine_loop");
        } else {
          self.plane_data[var_16].closeoneshotstarted = 0;
          self.plane_data[var_16].closetimer = self.plane_data[var_16].closetimer + 1;
          continue;
        }
      } else if(self.plane_data[var_15].closetimer < var_0A) {
        self.plane_data[var_15].closeoneshotstarted = 0;
        self.plane_data[var_15].closetimer = self.plane_data[var_15].closetimer + 1;
      }

      if(self.plane_data[var_15].var_3018 < var_04 && self.plane_data[var_15].closeoneshotstarted == 0) {
        if(self.plane_data[var_15].approachspeed > var_05 && self.plane_data[var_15].midoneshotstarted == 0 && self.plane_data[var_15].midtimer >= var_06) {
          self.plane_data[var_15].midoneshotstarted = 1;
          self.plane_data[var_15].midtimer = 0;
          var_18 = lib_02EF::func_42DD(var_11, "dogfight_mid_flybys", 7);
          self.plane_data[var_15].mid_flybysound = lib_0380::func_288E(var_18, self, var_16, 0, 1, 3, "stop_damage_engine_loop");
        } else {
          self.plane_data[var_16].midoneshotstarted = 0;
          self.plane_data[var_16].midtimer = self.plane_data[var_16].midtimer + 1;
          continue;
        }
      } else if(self.plane_data[var_15].midtimer < var_06) {
        self.plane_data[var_15].midoneshotstarted = 0;
        self.plane_data[var_15].midtimer = self.plane_data[var_15].midtimer + 1;
      }

      if(self.plane_data[var_15].var_3018 < var_01 && self.plane_data[var_15].closeoneshotstarted == 0 && self.plane_data[var_15].midoneshotstarted == 0) {
        if(self.plane_data[var_15].approachspeed > 120 && self.plane_data[var_15].faroneshotstarted == 0 && self.plane_data[var_15].fartimer >= var_03) {
          self.plane_data[var_15].faroneshotstarted = 1;
          self.plane_data[var_15].fartimer = 0;
          var_19 = lib_02EF::func_42DD(var_12, "dogfight_far_flybys", 9);
          self.plane_data[var_15].far_flybysound = lib_0380::func_288E(var_19, undefined, var_16, 0, 1, 3, "stop_damage_engine_loop");
        } else {
          self.plane_data[var_16].faroneshotstarted = 0;
          self.plane_data[var_16].fartimer = self.plane_data[var_16].fartimer + 1;
          continue;
        }

        continue;
      }

      if(self.plane_data[var_15].fartimer < var_03) {
        self.plane_data[var_15].faroneshotstarted = 0;
        self.plane_data[var_15].fartimer = self.plane_data[var_15].fartimer + 1;
      }
    }

    wait 0.05;
  }
}

dogfight_close_loop(param_00, param_01) {
  var_02 = undefined;
  switch (param_01) {
    case "axis":
      var_02 = lib_0380::func_6845("blg_dogfight_axis_close_lp", undefined, param_00, self, 0.5);
      break;

    case "allies":
      var_02 = lib_0380::func_6845("blg_dogfight_ally_close_lp", undefined, param_00, self, 0.5);
      break;

    default:
      break;
  }

  close_loop_death_watcher(var_02);
}

close_loop_death_watcher(param_00) {
  common_scripts\utility::func_A70A("death", "stop_p47_sounds", "stop_damage_engine_loop");
  lib_0380::func_6850(param_00, 0.5);
  param_00 = undefined;
}

fighter_start_death(param_00) {
  self notify("stop_damage_engine_loop");
  param_00 maps\mp\_audio_submixes::func_8001("husky_player_death_pop");
  param_00 maps\mp\_audio_submixes::func_8001("husky_player_death_spin", "final_explosion");
}

fighter_final_explosion(param_00) {
  self notify("stop_damage_alarm_loop");
  self notify("stop_p47_sounds");
  maps\mp\_audio_submixes::func_7FFA("husky_plane_destruct_exp_close", param_00);
}

fighter_damage_state_change(param_00) {
  var_01 = self method_8251();
  if(param_00 == 0) {
    common_scripts\utility::func_3C7B("damage_state_1");
    self notify("stop_damage_engine_loop");
  }

  if(param_00 == 1) {
    if(!common_scripts\utility::func_3C77("damage_state_1")) {
      common_scripts\utility::func_3C8F("damage_state_1");
      maps\mp\_audio_submixes::func_8001("husky_player_damage_oneshot");
      self.var_11CB.engine_damage_loop = maps\mp\_audio_submixes::func_8004("blg_p47_engine_damage_plr_lp", "stop_damage_engine_loop", 0, 0);
    }

    if(common_scripts\utility::func_3C77("damage_state_2")) {
      common_scripts\utility::func_3C7B("damage_state_2");
      self notify("stop_damage_alarm_loop");
    }
  }

  if(param_00 == 2 && !common_scripts\utility::func_3C77("damage_state_2")) {
    common_scripts\utility::func_3C8F("damage_state_2");
    maps\mp\_audio_submixes::func_8001("husky_player_damage_oneshot");
  }
}

getnormalizedmovementx() {
  if(function_01EF(self)) {
    var_00 = self method_85E2();
    if(!isDefined(var_00)) {
      return 0;
    }

    var_01 = var_00 method_8283();
    if(!isDefined(self.mph_upper) || var_01 > self.mph_upper) {
      self.mph_upper = var_01;
    }

    if(!isDefined(self.mph_lower) || var_01 < self.mph_lower) {
      self.mph_lower = var_01;
    }

    var_02 = self.mph_upper - self.mph_lower;
    if(var_02 == 0) {
      return 0;
    }

    var_03 = self.mph_lower + var_02 * 0.5;
    var_04 = var_01 - var_03 / var_02 * 0.5;
    return var_04;
  }

  return self getnormalizedmovement()[0];
}