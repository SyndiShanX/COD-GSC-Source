/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1343.gsc
*********************************************/

lib_053F::func_00D5() {
  common_scripts\utility::func_3C87("door_opened");
  if(!isDefined(level.var_328C)) {
    level.var_328C = [];
  }

  if(!isDefined(level.var_5E6E)) {
    level.var_5E6E = [];
  }

  level.var_AC1D = common_scripts\utility::func_46B7("door", "targetname");
  common_scripts\utility::func_0FB2(level.var_AC1D, ::lib_053F::func_51BE);
}

lib_053F::func_51BE() {
  self.var_3280 = self.var_0165;
  if(!isDefined(self.var_3280)) {
    self.var_3280 = "normal";
  }

  if(isDefined(self.var_0164) && issubstr(self.var_0164, "final_brute_closable")) {
    self.var_3280 = "closeable";
    self.var_0165 = "closeable";
  }

  if(isDefined(self.var_819A) && !common_scripts\utility::func_3C83(self.var_819A)) {
    common_scripts\utility::func_3C87(self.var_819A);
  }

  if(isDefined(self.var_81A1) && !common_scripts\utility::func_3C83(self.var_81A1)) {
    common_scripts\utility::func_3C87(self.var_81A1);
  }

  waittillframeend;
  switch (self.var_3280) {
    case "normal":
      thread lib_053F::func_51C1();
      break;

    case "closeable":
      thread lib_053F::func_51BF();
      break;

    case "safe_haven":
      thread lib_053F::func_51C2();
      break;

    default:
      break;
  }
}

lib_053F::func_327B(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 500;
  }

  self.var_267B = param_00;
}

lib_053F::func_51BF() {
  self.var_56AE = 1;
  lib_053F::func_51C1();
}

lib_053F::func_51C2() {
  self.var_57B4 = 1;
  self.var_56AE = 1;
  lib_053F::func_51C1();
}

lib_053F::func_51C1() {
  self.var_9DC2 = [];
  self.var_64C5 = [];
  self.var_17F0 = 0;
  if(!isDefined(self.var_01A2)) {
    lib_053F::func_325C("Door struct without any targets at " + self.var_0116 + ".");
    return;
  }

  self.var_8301 = function_021F(self.var_01A2, "targetname");
  var_00 = getEntArray(self.var_01A2, "targetname");
  foreach(var_02 in var_00) {
    var_03 = var_02.var_0165;
    if(!isDefined(var_03) && isDefined(var_02.var_003A)) {
      switch (var_02.var_003A) {
        case "script_brushmodel":
        case "script_model":
          var_03 = "mover";
          break;

        case "trigger_use":
        case "trigger_use_touch":
          var_03 = "trigger";
          break;
      }
    }

    if(!isDefined(var_03)) {
      continue;
    }

    switch (var_03) {
      case "trigger":
        if(lib_053F::func_51C3(var_02)) {
          self.var_9DC2[self.var_9DC2.size] = var_02;
        }
        break;

      case "mover":
        if(lib_053F::func_51C0(var_02)) {
          self.var_64C5[self.var_64C5.size] = var_02;
        }
        break;

      case "trap":
        self.var_9CFE = var_02;
        break;

      default:
        lib_053F::func_325C("Unknown ent type \'" + var_03 + "\' on entity at " + var_02.var_0116 + ".");
        break;
    }
  }

  if(isDefined(self.var_8301) && isDefined(self.var_8301[0])) {
    var_05 = self.var_8301[0] method_85CE();
    if(lib_0547::func_5565(var_05, "animated_zmb_door_bunker_entrance_2")) {
      foreach(var_07 in self.var_64C5) {
        if(var_07.var_8260 == "door_r") {
          var_07 linkto(self.var_8301[0], "door_R");
          continue;
        }

        if(var_07.var_8260 == "door_l") {
          var_07 linkto(self.var_8301[0], "door_L");
        }
      }
    }
  }

  if((self.var_9DC2.size || common_scripts\utility::func_562E(self.var_57B4)) && self.var_64C5.size || self.var_8301.size) {
    lib_053F::func_7F5C();
  }
}

lib_053F::func_51C3(param_00) {
  param_00.var_3276 = self;
  return 1;
}

lib_053F::func_51C0(param_00) {
  if(!isDefined(param_00.var_01A2)) {
    return 1;
  }

  param_00.var_2444 = param_00.var_0116;
  param_00.var_17F0 = [];
  param_00.var_64A9 = [];
  param_00.var_5DBD = [];
  var_01 = common_scripts\utility::func_46B7(param_00.var_01A2, "targetname");
  foreach(var_03 in var_01) {
    var_04 = var_03.var_0165;
    if(!isDefined(var_04)) {
      var_04 = "goal";
    }

    switch (var_04) {
      case "goal":
        param_00.var_64A9[param_00.var_64A9.size] = var_03;
        break;

      default:
        lib_053F::func_325C("Unknown door target struct type \'" + var_04 + "\' on struct at " + var_03.var_0116 + ".");
        break;
    }
  }

  var_06 = getEntArray(param_00.var_01A2, "targetname");
  foreach(var_03 in var_06) {
    var_04 = var_03.var_0165;
    if(!isDefined(var_04)) {
      var_04 = "link";
    }

    switch (var_04) {
      case "link_blood":
        param_00.var_17F0[param_00.var_17F0.size] = var_03;
        var_03 method_8511();
        var_03 linkto(param_00);
        break;

      case "link":
        var_03 linkto(param_00);
        param_00.var_5DBD[param_00.var_5DBD.size] = var_03;
        break;

      default:
        lib_053F::func_325C("Unknown door target ent type \'" + var_04 + "\' on ent at " + var_03.var_0116 + ".");
        break;
    }
  }

  if(param_00.var_64A9.size > 0) {
    return 1;
  }

  lib_053F::func_325C("Door mover at " + param_00.var_0116 + "doesn\'t have a goal stuct.");
  return 0;
}

lib_053F::func_0BCB() {
  foreach(var_01 in level.var_AC1D) {
    if(!isDefined(var_01.var_6BE1) && var_01.var_6BE1) {
      return 0;
    }
  }

  return 1;
}

lib_053F::func_7F5C() {
  if(1) {
    foreach(var_01 in self.var_9DC2) {
      if(!isDefined(var_01.var_7778)) {
        var_01.var_7778 = lib_0552::func_7BDD(var_01);
      }

      var_01.var_7778.var_2F74 = 0;
    }
  }

  if(!common_scripts\utility::func_562E(self.var_57B4)) {
    foreach(var_01 in self.var_9DC2) {
      thread lib_053F::func_7F61(var_01);
    }
  }

  var_05 = lib_053F::func_3278() && lib_053F::func_4B39();
  if(var_05) {
    foreach(var_07 in self.var_8301) {
      var_07 setscriptablepartstate("power_light", "power_off", 0);
    }

    thread lib_053F::func_9E96();
  }

  self waittill("open", var_09);
  foreach(var_01 in self.var_9DC2) {
    thread lib_053F::func_3677(var_01);
  }

  foreach(var_0D in self.var_64C5) {
    thread lib_053F::func_7F5E(var_0D);
  }

  lib_053F::func_82F2();
  self.var_6BE1 = 1;
  common_scripts\utility::func_3C8F("door_opened");
  if(level.var_A980 <= 20) {
    level.var_400E[level.var_400E.size] = ["mountain_man_set 0 -1", "all"];
    level.var_400E[level.var_400E.size] = ["mountain_man_set 1 -1", "all"];
  }

  if(isDefined(self.var_819A)) {
    common_scripts\utility::func_3C8F(self.var_819A, var_09);
    if(isDefined(level.var_3283[self.var_819A])) {
      level.var_3294 = level.var_3294 | level.var_3283[self.var_819A];
    }
  }

  var_0F = lib_0547::func_AC4B(self.var_0116, "door");
  var_0F lib_0547::func_AC47(var_09);
  var_0F lib_0547::func_AC48("script_flag", self.var_819A);
  var_0F lib_0547::func_AC44("cost", self.var_267B);
  var_0F lib_0547::func_AC4D();
  if(isDefined(var_09)) {
    var_09 maps\mp\zombies\_zombies_rank::func_AC23("gate");
    var_09.var_3295++;
    var_10 = "none";
    if(isDefined(self.var_819A)) {
      var_10 = self.var_819A;
    }

    lib_0547::func_4AE4(var_09, "doors", self.var_267B, "none", var_10);
  }

  if(!common_scripts\utility::func_562E(self.var_56AE)) {
    thread lib_053F::func_7F5F();
    return;
  }

  self waittill("close");
  thread lib_053F::func_82F1();
  self.var_6BE1 = 0;
  if(isDefined(self.var_819A)) {
    common_scripts\utility::func_3C7B(self.var_819A, var_09);
  }

  lib_053F::func_7F5C();
}

lib_053F::func_9E96() {
  common_scripts\utility::func_3C9F(self.var_81A1);
  foreach(var_01 in self.var_8301) {
    var_01 setscriptablepartstate("power_light", "power_on", 0);
  }
}

lib_053F::func_4B39() {
  return isDefined(self.var_819E) && self.var_819E == "has_power_light";
}

lib_053F::func_82F2() {
  self endon("scriptable_door_close");
  self notify("scriptable_door_open");
  foreach(var_01 in self.var_8301) {
    var_01 setscriptablepartstate("gate", "opening", 0);
  }

  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = self.var_8301[0] method_85CE();
  var_07 = 0;
  switch (var_06) {
    case "animated_zmb_door_bunker":
      var_03 = getanimlength(%salt_mine_door_02_open);
      var_04 = 1.2;
      break;

    case "animated_zmb_salt_mine_door":
      var_03 = getanimlength(%salt_mine_door_01_open);
      var_04 = 3.233333;
      break;

    case "animated_zmb_gate_electric_01_snow":
    case "animated_zmb_gate_electric_01":
      var_03 = getanimlength(%s2_zmb_electric_gate_open);
      var_04 = 0.8;
      break;

    case "animated_zmb_elec_gate_barn_01":
      var_03 = getanimlength(%s2_zmb_elec_gate_barn_01_open);
      var_04 = 0.8;
      break;

    case "animated_zmb_gate_01":
      var_03 = getanimlength(%zmb_gate_01_open);
      var_04 = 0.9;
      break;

    case "animated_zmb_door_bunker_entrance":
      var_03 = 14.66667;
      var_04 = 7;
      break;

    case "animated_zmb_door_bunker_entrance_2":
      var_03 = getanimlength(%s2_zmb_bumker_gate_open);
      var_04 = 14;
      var_05 = 7.5;
      break;

    case "animated_zmi_bar_gate_01_powered":
    case "animated_zmi_bar_gate_01":
      var_03 = 1.533333;
      var_04 = 1;
      break;

    case "animated_zbr_drop_pod":
      self.var_8301[0] setscriptablepartstate("light", "green", 0);
      var_03 = getanimlength(%s2_zom_drop_pod_open);
      var_04 = 0.5;
      break;

    case "animated_zbr_ger_mil_door":
      self.var_8301[0] setscriptablepartstate("light", "green", 0);
      var_03 = getanimlength(%s2_zom_ger_mil_door_open);
      var_04 = 0.5;
      break;

    case "animated_zbr_zep_interior_bar_gate_01":
      self.var_8301[0] setscriptablepartstate("light", "green", 0);
      var_03 = getanimlength(%s2_zom_zep_bar_gate_open);
      var_04 = 0.5;
      break;

    case "animated_zmf_basalt_door":
      var_03 = getanimlength(%s2_zmf_basalt_door_open);
      var_04 = 0.9;
      break;

    case "animated_zmf_basalt_door_single_first":
    case "animated_zmf_basalt_door_single":
      var_03 = getanimlength(%s2_zmf_basalt_door_blockers_open);
      var_04 = 0.9;
      break;

    default:
      break;
  }

  if(var_05 > 0) {
    wait(var_05);
    foreach(var_09 in self.var_64C5) {
      if(isDefined(var_09.var_01A2)) {
        continue;
      }

      var_09 method_8060();
    }

    var_04 = var_04 - var_05;
  }

  wait(var_04);
  if(var_07) {
    self.var_8301[0] method_805C();
  }

  foreach(var_09 in self.var_64C5) {
    if(isDefined(var_09.var_01A2)) {
      continue;
    }

    var_09 notsolid();
    if(var_05 == 0) {
      var_09 method_8060();
    }

    var_09 method_805C();
    self.var_1F73 = 0;
  }

  thread lib_053F::func_82F3(var_03 - var_04);
}

lib_053F::func_82F3(param_00) {
  if(isDefined(param_00) && param_00 > 0) {
    wait(param_00);
  }

  foreach(var_02 in self.var_8301) {
    var_02 setscriptablepartstate("gate", "opened", 0);
  }
}

lib_053F::func_82F1() {
  self endon("scriptable_door_open");
  self notify("scriptable_door_close");
  foreach(var_01 in self.var_8301) {
    var_01 setscriptablepartstate("gate", "closing", 0);
  }

  wait(2);
  foreach(var_01 in self.var_8301) {
    var_01 setscriptablepartstate("gate", "closed", 0);
  }

  foreach(var_06 in self.var_64C5) {
    if(isDefined(var_06.var_01A2)) {
      continue;
    }

    var_06 method_805B();
    var_06 solid();
    var_06 method_805F();
  }
}

lib_053F::func_7F61(param_00) {
  self endon("open");
  lib_053F::func_327B(self.var_8140);
  thread lib_053F::func_7F5D(param_00);
  for(;;) {
    var_01 = param_00 lib_0547::func_A795();
    var_02 = var_01[0];
    var_03 = var_01[1];
    if(!lib_053F::func_3262()) {
      continue;
    }

    if(var_03 == "token") {
      var_02 maps\mp\gametypes\zombies::func_90F6(param_00.var_9A84);
      break;
    } else {
      var_04 = self.var_267B;
      var_05 = var_02 lib_0577::func_4687();
      var_04 = int(var_04 * var_05);
      var_06 = undefined;
      if(var_02 maps\mp\gametypes\zombies::func_11C2(var_04)) {
        break;
      }
    }

    var_02 thread lib_054E::func_0695("needmoney");
  }

  var_02 lib_0577::func_A236();
  self notify("open", var_02);
}

lib_053F::func_7F5F() {
  if(!isDefined(self.var_9CFE)) {
    return;
  }

  if(isDefined(self.var_9CFE.var_01A2)) {
    var_00 = common_scripts\utility::func_46B5(self.var_9CFE.var_01A2, "targetname");
    if(isDefined(var_00)) {
      self.var_9CF7 = anglesToForward(var_00.var_001D);
    }
  }

  foreach(var_02 in self.var_64C5) {
    var_02.var_A049 = 1;
    var_02.var_A045 = ::lib_053F::func_327F;
    var_02.var_6E74 = self;
  }

  self.var_9CF5 = 0;
  thread lib_053F::func_7F60();
  for(;;) {
    self waittill("trap_trigger", var_04, var_05);
    self.var_9CFA = var_04;
    self.var_9CF5 = 1;
    thread lib_053F::func_327E(var_05);
  }
}

lib_053F::func_327E(param_00) {
  self notify("door_trap_end");
  self endon("door_trap_end");
  wait(param_00);
  self.var_9CF5 = 0;
}

lib_053F::func_7F60() {
  var_00 = 0.1;
  for(;;) {
    self.var_9CFE waittill("trigger", var_01);
    if(!self.var_9CF5) {
      continue;
    }

    if(isPlayer(var_01)) {
      continue;
    }

    if(var_01 lib_0547::func_56CF()) {
      continue;
    }

    if(lib_053F::func_5532(self.var_9CFE)) {
      continue;
    }

    if(isDefined(self.var_9CF7)) {
      var_02 = var_01 getvelocity();
      var_03 = var_01.var_0116 - self.var_9CFE.var_0116;
      var_04 = var_01.var_0116 + var_02 * var_00 - self.var_9CFE.var_0116;
      var_03 = (var_03[0], var_03[1], 0);
      var_04 = (var_04[0], var_04[1], 0);
      var_05 = vectordot(self.var_9CF7, var_03);
      var_06 = vectordot(self.var_9CF7, var_04);
      if(var_05 * var_06 > 0) {
        continue;
      }
    }

    foreach(var_08 in self.var_64C5) {
      var_08 moveto(var_08.var_2444, var_00, var_00);
      var_08 method_8617("trap_security_door_slam");
    }

    wait(var_00);
    earthquake(0.2, 0.5, self.var_9CFE.var_0116, 500);
    wait(0.1);
    var_0A = 1;
    foreach(var_08 in self.var_64C5) {
      var_08 moveto(var_08.var_6BF0, var_0A);
      var_08 method_8617("trap_security_door_reset");
    }

    wait(var_0A);
    wait(0.5);
  }
}

lib_053F::func_327F(param_00) {
  if(!isDefined(param_00) || isPlayer(param_00)) {
    return;
  }

  if(param_00 lib_0547::func_56CF()) {
    return;
  }

  self.var_6E74 lib_053F::func_3256();
  param_00 dodamage(param_00.var_00BC, param_00.var_0116, self.var_6E74.var_9CFA, self, "MOD_CRUSH", "trap_zm_mp", "torso_upper");
}

lib_053F::func_3256() {
  if(self.var_17F0) {
    return;
  }

  self.var_17F0 = 1;
  foreach(var_01 in self.var_64C5) {
    foreach(var_03 in var_01.var_17F0) {
      var_03 method_805B();
    }
  }
}

lib_053F::func_5532(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 istouching(param_00)) {
      return 1;
    }
  }

  return 0;
}

lib_053F::func_415D(param_00) {
  var_01 = lib_0547::func_4474(self.var_267B);
  return var_01;
}

lib_053F::func_7F5D(param_00) {
  self endon("open");
  for(;;) {
    if(lib_053F::func_3278()) {
      for(;;) {
        if(!lib_053F::func_3262()) {
          if(0) {
            param_00 sethintstring(lib_053F::func_4565(param_00));
            param_00 setsecondaryhintstring("");
            param_00 lib_0547::func_9A85(0);
          }

          if(1) {
            param_00.var_7778.var_3264 = lib_053F::func_4564(param_00);
            param_00.var_7778.var_3259 = 0;
            param_00.var_7778.interact_disabled = 1;
            param_00.var_7778.var_6642 = 1;
          }

          common_scripts\utility::func_3C9F(self.var_81A1);
        }

        if(0) {
          param_00 sethintstring(lib_053F::func_450D(param_00));
          param_00 setsecondaryhintstring(lib_053F::func_415D(self.var_267B));
          param_00 lib_0547::func_9A85(1);
        }

        if(1) {
          param_00.var_7778.var_3264 = lib_053F::func_450C(param_00);
          param_00.var_7778.var_3259 = self.var_267B;
          param_00.var_7778.interact_disabled = 0;
          param_00.var_7778.var_6642 = 1;
        }

        common_scripts\utility::func_3CA9(self.var_81A1);
      }
    } else {
      if(0) {
        param_00 sethintstring(lib_053F::func_450D(param_00));
        param_00 setsecondaryhintstring(lib_053F::func_415D(self.var_267B));
        param_00 lib_0547::func_9A85(1);
      }

      if(1) {
        param_00.var_7778.var_3264 = lib_053F::func_450C(param_00);
        param_00.var_7778.var_3259 = self.var_267B;
        param_00.var_7778.interact_disabled = 0;
        param_00.var_7778.var_6642 = 1;
      }
    }

    self waittill("cost_change");
  }
}

lib_053F::func_8477(param_00) {
  self.var_267B = param_00;
  self notify("cost_change");
}

lib_053F::func_3278() {
  return isDefined(self.var_81A1);
}

lib_053F::func_3262() {
  if(lib_053F::func_3278()) {
    return common_scripts\utility::func_3C77(self.var_81A1);
  }

  return 1;
}

lib_053F::func_3677(param_00) {
  if(0) {
    param_00 sethintstring("");
    param_00 setsecondaryhintstring("");
    param_00 lib_0547::func_9A85(0);
  }

  if(1) {
    param_00.var_7778.var_3264 = 0;
    param_00.var_7778.var_6642 = 1;
    param_00.var_7778.var_2F74 = 1;
  }
}

lib_053F::func_7F5E(param_00) {
  if(!isDefined(param_00.var_01A2)) {
    return;
  }

  param_00.var_5B37 = param_00.var_0116;
  param_00.var_5B12 = param_00.var_001D;
  var_01 = common_scripts\utility::func_7A33(param_00.var_64A9);
  param_00 moveto(var_01.var_0116, 1);
  if(param_00.var_003A == "script_model") {
    param_00 rotateto(var_01.var_001D, 1);
  }

  param_00.var_6BF0 = var_01.var_0116;
  var_02 = "interact_door";
  if(isDefined(param_00.var_8260)) {
    if(function_0344(param_00.var_8260)) {
      var_02 = param_00.var_8260;
    }
  }

  if(function_0344(var_02)) {
    param_00 method_8617(var_02);
  }

  if(param_00 maps\mp\_movers::func_8221()) {
    param_00 method_8060();
  }

  foreach(var_04 in param_00.var_5DBD) {
    if(var_04 maps\mp\_movers::func_8221()) {
      var_04 method_8060();
    }
  }
}

lib_053F::func_2435(param_00) {
  param_00 moveto(param_00.var_5B37, 1);
  if(param_00.var_003A == "script_model") {
    param_00 rotateto(param_00.var_5B12, 1);
  }

  var_01 = "interact_door";
  if(isDefined(param_00.var_8260)) {
    if(function_0344(param_00.var_8260)) {
      var_01 = param_00.var_8260;
    }
  }

  if(function_0344(var_01)) {
    param_00 method_8617(var_01);
  }

  if(param_00 maps\mp\_movers::func_8221()) {
    param_00 method_805F();
  }

  if(isDefined(param_00.var_5DBD)) {
    foreach(var_03 in param_00.var_5DBD) {
      if(var_03 maps\mp\_movers::func_8221()) {
        var_03 method_805F();
      }
    }
  }
}

lib_053F::func_325C(param_00) {}

lib_053F::func_4485(param_00, param_01) {
  var_02 = undefined;
  if(isDefined(param_01)) {
    var_02 = tablelookup("mp/zombieCustomDoorInteract.csv", 1, param_01, 0);
  } else {
    var_03 = getlocalizedstringrefname(param_00);
    var_02 = tablelookup("mp/zombieCustomDoorInteract.csv", 2, var_03, 0);
  }

  return int(var_02);
}

lib_053F::func_7BE6(param_00, param_01, param_02, param_03) {
  if(0) {
    if(!isDefined(level.var_328C)) {
      level.var_328C = [];
    }

    if(!isDefined(level.var_328C[param_01])) {
      level.var_328C[param_01] = [];
    }

    level.var_328C[param_01][param_02] = param_00;
  }

  if(1) {
    var_04 = lib_053F::func_4485(param_00, param_03);
    if(!isDefined(level.var_328B)) {
      level.var_328B = [];
    }

    if(!isDefined(level.var_328B[param_01])) {
      level.var_328B[param_01] = [];
    }

    level.var_328B[param_01][param_02] = var_04;
  }
}

lib_053F::func_7BEB(param_00, param_01, param_02) {
  if(0) {
    level.var_5E6E[param_01] = param_00;
  }

  if(1) {
    var_03 = lib_053F::func_4485(param_00, param_02);
    if(!isDefined(level.var_5E6D)) {
      level.var_5E6D = [];
    }

    level.var_5E6D[param_01] = var_03;
  }
}

lib_053F::func_450C(param_00) {
  if(isDefined(level.var_328B)) {
    if(isDefined(param_00.var_819A) && isDefined(param_00.var_81E1)) {
      var_01 = level.var_328B[param_00.var_819A];
      if(isDefined(var_01) && isDefined(var_01[param_00.var_81E1])) {
        return var_01[param_00.var_81E1];
      }
    }
  }

  return lib_053F::func_4485("", "locked");
}

lib_053F::func_4564(param_00) {
  if(isDefined(param_00.var_81A1)) {
    if(isDefined(level.var_5E6D)) {
      var_01 = level.var_5E6D[param_00.var_81A1];
      if(isDefined(var_01)) {
        return var_01;
      }
    }
  }

  return lib_053F::func_4485("", "no_power");
}

lib_053F::func_450D(param_00) {
  if(isDefined(param_00.var_819A) && isDefined(param_00.var_81E1)) {
    var_01 = level.var_328C[param_00.var_819A];
    if(isDefined(var_01) && isDefined(var_01[param_00.var_81E1])) {
      return var_01[param_00.var_81E1];
    }
  }

  return &"ZOMBIES_DOOR_BUY";
}

lib_053F::func_4565(param_00) {
  if(isDefined(param_00.var_81A1)) {
    var_01 = level.var_5E6E[param_00.var_81A1];
    if(isDefined(var_01)) {
      return var_01;
    }
  }

  return &"ZOMBIES_REQUIRES_POWER";
}

lib_053F::func_328A() {
  return common_scripts\utility::func_3C83("door_opened") && common_scripts\utility::func_3C77("door_opened");
}

lib_053F::func_44A6(param_00) {
  var_01 = undefined;
  if(isDefined(level.var_AC1D) && isDefined(param_00)) {
    foreach(var_03 in level.var_AC1D) {
      if(lib_0547::func_5565(var_03.var_819A, param_00)) {
        var_01 = var_03;
      }
    }
  }

  return var_01;
}