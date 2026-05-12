/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_vehicle_code.gsc
***********************************************/

func_A346(param_00) {
  var_01 = param_00.var_3A;
  param_00.var_299C = [];
  if(!isDefined(level.var_A3F5[param_00.var_1C8][param_00.var_3A])) {}

  param_00 thread[[level.var_A3F5[param_00.var_1C8][param_00.var_3A]]]();
  if(isDefined(param_00.var_82D2)) {
    param_00 thread func_5D77(param_00.var_82D2);
  }

  param_00 thread func_3EC8();
  param_00 thread func_A351();
  if(isDefined(level.var_A2EC) && isDefined(level.var_A2EC[param_00.var_3A])) {
    param_00.var_299C[param_00.var_299C.size] = ::func_29C9;
  }
}

func_A353(param_00, param_01) {
  var_02 = self.var_1C8;
  var_03 = self.var_3A;
  var_04 = self.var_106;
  var_05 = self.var_1A5;
  thread func_5A12(var_03);
  if(isDefined(level.var_A2F8[var_03])) {
    thread func_8458(level.var_A2F8[var_03], level.var_A2F9[var_03]);
  } else if(isDefined(level.var_A2F8[var_04])) {
    thread func_8458(level.var_A2F8[var_04], level.var_A2F9[var_04]);
  }

  var_06 = 0;
  thread func_066A(var_04, var_06);
  return var_06;
}

func_A351() {
  self endon("nodeath_thread");
  var_00 = self.var_1C8;
  var_01 = self.var_3A;
  var_02 = self.var_106;
  var_03 = self.var_1A5;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = 0;
  if(isDefined(self)) {
    self waittill("death", var_04, var_05, var_06);
    if(!isDefined(var_05)) {
      var_05 = "none";
    }
  }

  var_08 = undefined;
  if(isDefined(self.var_A3A3)) {
    var_08 = self.var_A3A3;
  } else if(isDefined(level.var_A3A2) && isDefined(level.var_A3A2[var_01])) {
    var_08 = level.var_A3A2;
  } else if(isDefined(level.var_A3A1[var_01])) {
    var_08 = level.var_A3A1[var_01];
  }

  var_09 = func_A353(var_04, var_05);
  if(isDefined(level.var_A2F0[var_01])) {
    earthquake(level.var_A2F0[var_01].var_807E, level.var_A2F0[var_01].var_3511, self.var_116, level.var_A2F0[var_01].var_14F);
  }

  wait(0.5);
}

func_8458(param_00, param_01) {
  if(isDefined(self.var_8C88) && self.var_8C88) {
    return;
  }

  if(isDefined(param_01) && param_01 > 0) {
    wait(param_01);
  }

  if(!isDefined(self)) {
    return;
  }

  var_02 = func_0630();
  if(0) {}

  if(isDefined(self)) {
    var_02 setModel(param_00);
  }
}

func_5D77(param_00, param_01) {
  var_02 = strtok(param_00, " ");
  common_scripts\utility::func_F8A(var_02, ::func_5D78, param_01);
}

func_4890(param_00, param_01, param_02) {
  if(!isDefined(level.var_A363)) {
    level.var_A363 = [];
  }

  if(!isDefined(level.var_A363[param_00])) {
    level.var_A363[param_00] = [];
  }

  if(!isDefined(level.var_A363[param_00][param_02])) {
    level.var_A363[param_00][param_02] = [];
  }

  foreach(var_04 in level.var_A363[param_00][param_02]) {
    if(param_01 == var_04) {
      return;
    }
  }

  level.var_A363[param_00][param_02][level.var_A363[param_00][param_02].size] = param_01;
}

func_5D74() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");
  if(!isDefined(level.var_3F6C)) {
    level.var_3F6C = 0;
  }

  level.var_3F6C = level.var_3F6C + randomfloatrange(0.2, 0.4);
  if(level.var_3F6C > 2) {
    level.var_3F6C = 0;
  }

  wait 0.05;
  level.var_3F6C = undefined;
}

func_5A12(param_00) {
  func_5D76("all", param_00);
}

func_5D76(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    param_01 = param_02;
  } else if(!isDefined(param_01)) {
    param_01 = self.var_3A;
  }

  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  if(!isDefined(self.var_5D72)) {
    return;
  }

  if(!isDefined(level.var_A363[param_01][param_00])) {
    return;
  }

  var_03 = level.var_A363[param_01][param_00];
  var_04 = 0;
  var_05 = 2;
  if(isDefined(self.var_608A)) {
    var_05 = self.var_608A;
  }

  foreach(var_07 in var_03) {
    var_08 = level.var_A362[param_01][var_07];
    if(self method_8445(var_08.var_95A6) > -1) {
      stopFXOnTag(var_08.var_359B, self, var_08.var_95A6);
    }

    var_04++;
    if(var_04 >= var_05) {
      var_04 = 0;
      wait 0.05;
    }

    if(!isDefined(self)) {
      return;
    }

    self.var_5D72[var_07] = undefined;
  }
}

func_5D78(param_00, param_01) {
  level.var_5BB9 = gettime();
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  if(!isDefined(param_01)) {
    param_01 = self.var_3A;
  }

  if(!isDefined(level.var_A363)) {
    return;
  }

  if(!isDefined(level.var_A363[param_01]) || !isDefined(level.var_A363[param_01][param_00])) {
    return;
  }

  thread func_5D74();
  if(!isDefined(self.var_5D72)) {
    self.var_5D72 = [];
  }

  var_02 = level.var_A363[param_01][param_00];
  var_03 = 0;
  var_04 = [];
  foreach(var_06 in var_02) {
    if(isDefined(self.var_5D72[var_06])) {
      continue;
    }

    var_07 = level.var_A362[param_01][var_06];
    if(isDefined(var_07.var_2CAC)) {
      var_08 = var_07.var_2CAC;
    } else {
      var_08 = 0;
    }

    var_08 = var_08 + level.var_3F6C;
    while(isDefined(var_04["" + var_08])) {
      var_08 = var_08 + 0.05;
    }

    var_04["" + var_08] = 1;
    self endon("death");
    childthread common_scripts\utility::func_6755(::playfxontag, var_08, var_07.var_359B, self, var_07.var_95A6);
    self.var_5D72[var_06] = 1;
    if(!isDefined(self)) {
      break;
    }
  }

  level.var_3F6C = 0;
}

func_0630() {
  if(isDefined(self.var_6297) && self.var_6297) {
    var_00 = self.var_6296;
  } else {
    var_00 = self;
  }

  return var_00;
}

func_066A(param_00, param_01) {
  if(common_scripts\utility::func_56C3() || isDefined(self.var_5531) && self.var_5531) {
    return;
  }

  level notify("vehicle_explosion", self.var_116);
  self notify("explode", self.var_116);
  if(isDefined(self.var_508C) && self.var_508C) {
    return;
  }

  var_02 = self.var_1C8;
  var_03 = self.var_3A;
  if(param_01) {
    var_03 = "rocket_death" + var_03;
  }

  foreach(var_05 in level.var_A2F1[var_03]) {
    thread func_5A0A(param_00, var_05, var_02);
  }
}

func_5A0A(param_00, param_01, param_02) {
  if(isDefined(param_01.var_A68B)) {
    if(param_01.var_A68B >= 0) {
      wait(param_01.var_A68B);
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(param_01.var_6810)) {
    self notify(param_01.var_6810);
  }

  var_03 = func_0630();
  if(isDefined(param_01.var_83C2)) {
    common_scripts\utility::func_2CBE(param_01.var_83C2, ::delete);
  }

  var_04 = level.var_A2EC[self.var_3A];
  if(var_04.var_2F3D) {
    func_233C(var_03);
  }

  if(isDefined(param_01.var_359B)) {
    if(param_01.var_16FE && !isDefined(self.var_2D18)) {
      if(isDefined(param_01.var_95A6)) {
        if(isDefined(param_01.var_9340) && param_01.var_9340 == 1) {
          thread func_5EDE(param_01.var_359B, param_01.var_2CAC, param_01.var_95A6);
          return;
        }

        thread func_74C1(param_01.var_359B, param_01.var_2CAC, param_01.var_95A6);
        return;
      }

      var_05 = var_03.var_116 + (0, 0, 100) - var_03.var_116;
      playFX(param_01.var_359B, var_03.var_116, var_05);
      return;
    }

    if(isDefined(param_02.var_95A6)) {
      if(0) {}

      playFXOnTag(param_02.var_359B, func_2AA4(), param_02.var_95A6);
      if(isDefined(param_02.var_7C80)) {
        func_2AA4() common_scripts\utility::func_2CBE(param_02.var_7C80, ::delete);
        return;
      }

      return;
    }

    var_05 = var_04.var_116 + (0, 0, 100) - var_04.var_116;
    playFX(param_01.var_359B, var_03.var_116, var_05);
    return;
  }
}

func_5EDE(param_00, param_01, param_02) {
  self endon("stop_looping_death_fx");
  while(isDefined(self)) {
    playFXOnTag(param_00, func_2AA4(), param_02);
    wait(param_01);
  }
}

func_2AA4() {
  if(isDefined(self.var_2A88) && self.var_2A88) {
    return self;
  }

  if(!isDefined(self.var_2AA4)) {
    var_00 = spawn("script_model", (0, 0, 0));
    var_01 = func_0630();
    var_00 setModel(self.var_106);
    var_00.var_116 = var_01.var_116;
    var_00.var_1D = var_01.var_1D;
    var_00 notsolid();
    var_00 method_805C();
    var_00 linkto(var_01);
    self.var_2AA4 = var_00;
  } else {
    self.var_2AA4 setModel(self.var_106);
  }

  return self.var_2AA4;
}

func_74C1(param_00, param_01, param_02) {
  var_03 = func_0630();
  var_04 = spawn("script_origin", var_03.var_116);
  self endon("fire_extinguish");
  thread func_74C2(param_02, var_04);
  for(;;) {
    playFX(param_00, var_04.var_116, var_04.var_A1C8);
    wait(param_01);
  }
}

func_74C2(param_00, param_01) {
  param_01.var_1D = self gettagangles(param_00);
  param_01.var_116 = self gettagorigin(param_00);
  param_01.var_3E40 = anglesToForward(param_01.var_1D);
  param_01.var_A1C8 = anglestoup(param_01.var_1D);
  while(isDefined(self) && self.var_3B == "script_vehicle" && self method_8283() > 0) {
    var_02 = func_0630();
    param_01.var_1D = var_02 gettagangles(param_00);
    param_01.var_116 = var_02 gettagorigin(param_00);
    param_01.var_3E40 = anglesToForward(param_01.var_1D);
    param_01.var_A1C8 = anglestoup(param_01.var_1D);
    wait 0.05;
  }
}

func_5D75(param_00, param_01, param_02) {
  var_03 = strtok(param_00, " ", param_01);
  common_scripts\utility::func_F8A(var_03, ::func_5D76, param_01, param_02);
}

func_3EC8() {
  var_00 = self.var_3A;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  var_04 = "damage";
  if(isDefined(self.var_29B5)) {
    var_04 = "damage_postcallback";
  }

  while(self.var_BC > 0) {
    self waittill(var_04, var_05, var_01, var_06, var_07, var_02, var_08, var_09, var_0A, var_0B, var_03);
    if(!isDefined(self)) {
      return;
    }

    foreach(var_0D in self.var_299C) {
      thread[[var_0D]](var_05, var_01, var_06, var_07, var_02, var_08, var_09);
    }

    var_05 = undefined;
    var_01 = undefined;
    var_06 = undefined;
    var_07 = undefined;
    var_02 = undefined;
    var_08 = undefined;
    var_09 = undefined;
    var_0A = undefined;
    var_0B = undefined;
    var_03 = undefined;
  }
}

func_233C(param_00) {
  self notify("clean_up_damagefx");
  var_01 = self;
  var_02 = level.var_A2EC[var_01.var_3A];
  foreach(var_06, var_04 in var_01.var_29C6) {
    var_05 = var_02.var_ACB6[var_06];
    if(var_04 >= 0) {
      wait 0.05;
      if(!isDefined(param_00)) {
        return;
      }

      if(0) {}

      stopFXOnTag(var_05[var_04], param_00, var_02.var_ACB7[var_06][0]);
      var_01.var_29C6[var_06] = undefined;
    }
  }
}

func_29C9(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("clean_up_damagefx");
  wait 0.05;
  if(!isDefined(self)) {
    return;
  }

  var_07 = self;
  var_08 = level.var_A2EC[var_07.var_3A];
  var_09 = func_0630();
  var_0A = var_07 maps\mp\gametypes\_vehicle::func_A320() / var_07 maps\mp\gametypes\_vehicle::func_A321();
  if(isDefined(var_07.var_F1C)) {
    var_0A = var_0A * var_07.var_F1C;
  }

  if(var_08.var_2F3D && var_0A <= 0) {
    return;
  }

  var_0A = clamp(var_0A, 0, 1);
  if(!isDefined(var_07.var_29C6)) {
    var_07.var_29C6 = [];
  }

  var_0B = -1;
  if(param_00 < var_08.var_29AE) {} else if(param_00 >= var_08.var_29AF) {
    var_0B = var_08.var_ACB7.size - 1;
  } else {
    var_0C = param_03;
    var_0D = 0;
    for(var_0E = 0; var_0E < var_08.var_ACB7.size; var_0E++) {
      if(!isDefined(var_08.var_ACB5[var_0E])) {
        var_0D = 1;
        break;
      }

      var_0F = var_08.var_ACB5[var_0E];
      var_0F = var_0F * var_0F;
      var_10 = var_08.var_ACB7[var_0E];
      for(var_11 = 0; var_11 < var_10.size; var_11++) {
        if(var_11 == 0) {
          continue;
        }

        var_12 = var_10[var_11];
        var_13 = var_07 gettagorigin(var_12);
        var_14 = var_0C - var_13;
        var_15 = lengthsquared(var_14);
        if(var_15 < var_0F) {
          var_0D = 1;
          break;
        }
      }

      if(var_0D) {
        break;
      }
    }

    if(var_0D) {
      var_0B = var_0E;
    }
  }

  if(var_0B >= 0) {
    if(!isDefined(var_07.var_29C6[var_0B])) {
      if(var_0A <= var_08.var_ACB4[var_0B][0]) {
        var_07.var_29C6[var_0B] = -1;
      }
    }
  }

  foreach(var_1B, var_17 in var_07.var_29C6) {
    var_18 = var_08.var_ACB6[var_1B];
    var_19 = var_08.var_ACB4[var_1B];
    for(var_1A = var_18.size - 1; var_1A >= 0; var_1A--) {
      if(var_0A <= var_19[var_1A]) {
        break;
      }
    }

    if(var_1A >= 0 && var_1A != var_17) {
      if(var_17 >= 0) {
        if(0) {}

        stopFXOnTag(var_18[var_17], var_09, var_08.var_ACB7[var_1B][0]);
        wait 0.05;
        if(!isDefined(self)) {
          return;
        }
      }

      if(0) {}

      playFXOnTag(var_18[var_1A], var_09, var_08.var_ACB7[var_1B][0]);
      var_07.var_29C6[var_1B] = var_1A;
    }
  }
}