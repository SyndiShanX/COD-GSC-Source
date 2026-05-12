/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1353.gsc
*********************************************/

lib_0549::func_00D5() {
  level.var_609C = 50;
  level.var_AAF0 = [];
  level.var_AAEF = [];
  if(!isDefined(level.var_0C11)) {
    level.var_0C11 = 1;
  }

  level.var_AAF0["boards"] = ::lib_0549::func_4F8F;
  level.var_AAEF["boards"] = ::lib_0549::func_4F8E;
  level.var_AAF0["drop_gate"] = ::lib_0549::func_4F91;
  level.var_AAEF["drop_gate"] = ::lib_0549::func_4F90;
  level.var_AAF1 = [];
  level.var_AAF1["drop_gate"] = ::lib_0549::func_345C;
  level.var_AAF2 = [];
  level.var_AAF2["drop_gate"] = ::lib_0549::func_345D;
  level.var_AA29 = getEntArray("zbarrier_window", "script_noteworthy");
  foreach(var_01 in level.var_AA29) {
    var_01 thread lib_0549::func_5288();
  }

  level.var_346F = common_scripts\utility::func_46B7("drop_gate", "script_noteworthy");
  foreach(var_04 in level.var_346F) {
    var_04 thread lib_0549::func_51C5();
  }
}

lib_0549::func_51C6() {
  level.var_3462 = [];
  level.var_3462[0] = "closed";
  level.var_3462[1] = "o1";
  level.var_3462[2] = "o2";
  level.var_3462[3] = "open";
  level.var_3455 = [];
  setdvarifuninitialized("drop_gate_debug", 0);
  level.var_3464 = [];
  level.var_3464[0] = 0;
  level.var_3464[1] = 1;
  level.var_3464[2] = 2;
  level.var_3464[3] = 3;
}

lib_0549::func_15CF() {
  self.var_17E9 = 1;
  foreach(var_01 in self.var_9D06) {
    nodesetscriptblocked(var_01, 1);
    var_01 notify("barricaded");
  }
}

lib_0549::func_15DA() {
  self.var_17E9 = 0;
  foreach(var_01 in self.var_9D06) {
    nodesetscriptblocked(var_01, 0);
  }
}

lib_0549::func_15D1() {
  self.var_17EC++;
  if(self.var_17EC == 1) {
    lib_0549::func_15CF();
  }
}

lib_0549::func_15D0() {
  self.var_17EC--;
  if(self.var_17EC == 0) {
    lib_0549::func_15DA();
  }
}

lib_0549::func_15DB(param_00) {
  if(common_scripts\utility::func_562E(self.var_2FAE) && common_scripts\utility::func_562E(param_00.var_2FDA)) {
    return undefined;
  }

  if(self.var_1178.size < 1) {
    return undefined;
  }

  self.var_1178 = common_scripts\utility::func_0F92(self.var_1178);
  var_01 = self.var_1178[self.var_1178.size - 1];
  self.var_1178[self.var_1178.size - 1] = undefined;
  self.var_1177 = common_scripts\utility::func_0F6F(self.var_1177, var_01);
  param_00.var_2308 = var_01;
  var_01.var_0117 = param_00;
  var_02 = level.var_AAF1[self.var_15D9];
  if(isDefined(var_02)) {
    self thread[[var_02]](param_00, var_01);
  }

  return var_01;
}

lib_0549::func_15DF(param_00) {
  self.var_1178[self.var_1178.size] = param_00.var_2308;
  self.var_1177 = common_scripts\utility::func_0F93(self.var_1177, param_00.var_2308);
  var_01 = param_00.var_2308;
  param_00.var_2308.var_0117 = undefined;
  param_00.var_2308 = undefined;
  var_02 = level.var_AAF2[self.var_15D9];
  if(isDefined(var_02)) {
    self thread[[var_02]](param_00, var_01);
  }
}

lib_0549::func_15DE() {
  return common_scripts\utility::func_7A33(self.var_1176).var_A6E6;
}

lib_0549::func_42E9() {
  var_00 = common_scripts\utility::func_0F92(self.var_188E);
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.var_0117) && var_02.var_188A == 2) {
      return var_02;
    }
  }

  return undefined;
}

lib_0549::func_42E4() {
  var_00 = common_scripts\utility::func_0F92(self.var_1890);
  foreach(var_02 in var_00) {
    if(var_02.var_188A == 0) {
      return var_02;
    }
  }

  return undefined;
}

lib_0549::func_15DC(param_00) {
  var_01 = lib_0549::func_42E9();
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_01.var_0117 = param_00;
  param_00.var_2309 = var_01;
  return var_01;
}

lib_0549::func_15E0(param_00) {
  param_00.var_2309.var_0117 = undefined;
  param_00.var_2309 = undefined;
}

lib_0549::func_15D3(param_00) {
  lib_0549::func_15D8(param_00);
  lib_0549::func_15D0();
  wait(1.13);
  lib_0549::func_15D7(param_00);
  if(self.var_1890.size == 1) {
    common_scripts\utility::func_9DA3();
  }
}

lib_0549::func_15D8(param_00) {
  var_01 = self.var_188D[param_00];
  var_01.var_188A = 3;
  self.var_82EF setscriptablepartstate(lib_0549::func_1889(var_01), "opening");
}

lib_0549::func_15D7(param_00, param_01) {
  var_02 = self.var_188D[param_00];
  self.var_1890[self.var_1890.size] = var_02;
  if(!common_scripts\utility::func_562E(param_01)) {
    self.var_188E = common_scripts\utility::func_0F93(self.var_188E, var_02);
  }

  var_02.var_188A = 0;
  self.var_82EF setscriptablepartstate(lib_0549::func_1889(var_02), "open");
}

lib_0549::func_15D4(param_00) {
  if(self.var_1890.size == 1) {
    common_scripts\utility::func_9D9F();
  }

  lib_0549::func_15D6(param_00);
  lib_0549::func_15D1();
  wait(1.13);
  lib_0549::func_15D5(param_00);
}

lib_0549::func_15D6(param_00) {
  var_01 = self.var_188D[param_00];
  self.var_1890 = common_scripts\utility::func_0F93(self.var_1890, var_01);
  var_01.var_188A = 1;
  self.var_82EF setscriptablepartstate(lib_0549::func_1889(var_01), "closing");
}

lib_0549::func_1889(param_00) {
  return "board" + param_00.var_1887 + 1;
}

lib_0549::func_15D5(param_00, param_01) {
  var_02 = self.var_188D[param_00];
  self.var_188E[self.var_188E.size] = var_02;
  var_02.var_188A = 2;
  self.var_82EF setscriptablepartstate(lib_0549::func_1889(var_02), "closed");
}

lib_0549::func_4F8F(param_00) {
  var_01 = lib_053C::func_4F89();
  if(isDefined(var_01)) {
    thread lib_053C::func_4F83(var_01);
    return 1;
  }

  var_02 = param_00 lib_0549::func_15DC(self);
  if(isDefined(var_02)) {
    thread lib_053C::func_4F99(param_00, var_02);
    return 1;
  }

  return 0;
}

lib_0549::func_4F8E(param_00) {
  self notify("board_pull_interrupted");
  if(isDefined(self.var_15D2)) {
    if(self.var_15D2 == "pulling_board") {
      param_00 lib_0549::func_15E0(self);
      self.var_15D2 = undefined;
      if(isalive(self)) {
        self scragentsetscripted(0);
        self method_839D("gravity");
        return;
      }

      return;
    }

    if(self.var_15D2 == "attacking_through_boards") {
      self.var_15D2 = undefined;
      return;
    }

    return;
  }
}

lib_0549::func_15DD(param_00) {
  var_01 = 3600;
  foreach(var_03 in level.var_744A) {
    if(maps\mp\_utility::func_57A0(var_03) && distancesquared(param_00.var_0116, var_03.var_0116) < var_01) {
      return var_03;
    }
  }

  var_05 = 500;
  if(isDefined(self.var_5B42) && gettime() - self.var_5B42 < var_05) {
    return self.var_5B41;
  }

  return undefined;
}

lib_0549::func_51C5() {
  self.var_2F0F = [];
  self.var_9D06 = [];
  self.var_15D9 = "drop_gate";
  self.var_3FFE = undefined;
  self.var_17EB = undefined;
  self.var_8310 = undefined;
  self.var_830F = undefined;
  self.var_9553 = [];
  var_00 = common_scripts\utility::func_41EE();
  var_01 = common_scripts\utility::func_46B7(self.var_01A2, "targetname");
  var_02 = getEntArray(self.var_01A2, "targetname");
  var_03 = common_scripts\utility::func_41ED();
  foreach(var_05 in var_02) {
    switch (var_05.var_003A) {
      case "script_model":
        if(isDefined(var_05.var_0165) && var_05.var_0165 == "gate_model") {
          self.var_3FFE = var_05;
        }

        break;

      case "trigger_use_touch":
        if(isDefined(var_05.var_0165) && var_05.var_0165 == "gate_trigger") {
          self.var_2F0F[self.var_2F0F.size] = var_05;
        }
        break;

      case "script_brushmodel":
        if(isDefined(var_05.var_0165) && var_05.var_0165 == "gate_blocking_clip") {
          self.var_17EB = var_05;
        }
        break;

      case "script_origin":
        if(isDefined(var_05.var_0165)) {
          switch (var_05.var_0165) {
            case "scripted_node":
              self.var_8310 = var_05.var_0116;
              self.var_830F = var_05.var_001D;
              break;

            default:
              break;
          }
        }
        break;

      default:
        break;
    }
  }

  foreach(var_05 in var_03) {
    switch (var_05.var_003A) {
      case "script_model":
        if(isDefined(var_05.var_0165) && var_05.var_0165 == "drop_gate_switch") {
          self.var_9553[self.var_9553.size] = var_05;
        }

        break;
    }
  }

  foreach(var_0A in self.var_2F0F) {
    var_0A.var_15CC = self;
    var_0A.var_15D9 = "drop_gate";
    var_0A.var_17D8 = 0;
    var_0A.var_7E4A = isDefined(var_0A.var_81E1) && var_0A.var_81E1 == 1;
    var_0A.var_8310 = self.var_8310;
    var_0A.var_830F = self.var_830F;
    if(var_0A.var_7E4A) {
      var_0A.var_830F = combineangles(var_0A.var_830F, (0, 180, 0));
    }

    var_0B = common_scripts\utility::func_44BE(var_0A.var_01A2, "targetname");
    var_0C = getnodearray(var_0A.var_01A2, "targetname");
    var_0A lib_0549::func_5289(var_0B);
    foreach(var_0E in var_0A.var_1176) {
      var_0E.var_92DE = var_0E.var_0116;
      var_0E.var_92DC = var_0E.var_001D;
    }

    var_0A.var_9D06 = var_0C;
    self.var_9D06[self.var_9D06.size] = var_0A.var_9D03;
    var_0A.var_9D06[0].var_15CB = var_0A;
    nodesetscriptblocked(var_0A.var_9D06[0], 1);
    var_0A thread lib_0549::func_3468();
  }

  thread lib_0549::func_3466();
}

lib_0549::func_3466() {
  self.var_4C0F = 3;
  self.var_4C11 = 0;
  self.var_4C15 = 1;
  self.var_6C05 = 0;
  self.var_931A = 3;
  self.var_5CCB = 0;
  self.var_5CCC = 0;
  self.var_5CCD = undefined;
  thread common_scripts\utility::func_2CB4(3, ::lib_0549::func_3469);
  for(;;) {
    switch (self.var_931A) {
      case 3:
        self notify("gate_open");
        self.var_5CCB = 0;
        self.var_4C11 = 0;
        lib_0549::func_7127("s2_zom_gate_lift_drop_open_idle_gate", 0);
        lib_0549::func_3469();
        self waittill("gate_purchase");
        thread lib_0549::func_3461(0);
        thread lib_0549::func_3460(1);
        lib_0549::func_3456();
        lib_0378::func_8D74("drop_gate", "drop", self.var_8310);
        lib_0549::func_7127("s2_zom_gate_lift_drop_gate", 1);
        lib_0549::func_84AE(0);
        break;

      case 0:
        self.var_4C11 = self.var_4C11 + self.var_4C0F;
        lib_0549::func_3457();
        lib_0549::func_7127("s2_zom_gate_lift_mount_idle_gate", 0);
        thread lib_0549::func_3467();
        self waittill("pull_state_change");
        self.var_5CCB = 1;
        lib_0378::func_8D74("drop_gate", "pos1", self.var_8310);
        thread lib_0549::func_3458();
        lib_0549::func_7127("s2_zom_gate_lift_position_1_gate", 1);
        lib_0549::func_84AE(1);
        break;

      case 1:
        self.var_5CCB = 0;
        self.var_4C11 = self.var_4C11 + self.var_4C0F;
        lib_0549::func_346A();
        lib_0549::func_7127("s2_zom_gate_lift_position_1_idle_gate", 0);
        thread lib_0549::func_3467();
        self waittill("pull_state_change");
        self.var_5CCB = 1;
        lib_0378::func_8D74("drop_gate", "pos2", self.var_8310);
        thread lib_0549::func_3458();
        lib_0549::func_7127("s2_zom_gate_lift_position_2_gate", 1);
        lib_0549::func_84AE(2);
        break;

      case 2:
        self.var_5CCB = 0;
        self.var_4C11 = self.var_4C11 + self.var_4C0F;
        lib_0549::func_7127("s2_zom_gate_lift_position_2_idle_gate", 0);
        thread lib_0549::func_3467();
        self waittill("pull_state_change");
        self.var_5CCB = 1;
        lib_0378::func_8D74("drop_gate", "pos3", self.var_8310);
        thread lib_0549::func_3458();
        lib_0549::func_7127("s2_zom_gate_lift_position_3_gate", 1, ::lib_0549::func_3FFF);
        lib_0549::func_84AE(3);
        wait(5);
        thread lib_0549::func_3461(1);
        thread lib_0549::func_3460(0);
        break;
    }
  }
}

lib_0549::func_3460(param_00) {
  if(param_00 && !common_scripts\utility::func_562E(self.var_9554)) {
    foreach(var_02 in self.var_9553) {
      var_02 thread lib_0549::func_3465();
    }

    self.var_9554 = 1;
    return;
  }

  if(!param_00) {
    foreach(var_02 in self.var_9553) {
      var_02 scriptmodelplayanim("s2_gj_zom_drop_gate_lever_up_idle");
    }

    self.var_9554 = 0;
  }
}

lib_0549::func_3461(param_00) {
  foreach(var_02 in self.var_2F0F) {
    if(param_00) {
      var_02 common_scripts\utility::func_9DA3();
      continue;
    }

    var_02 common_scripts\utility::func_9D9F();
  }
}

lib_0549::func_3465() {
  self scriptmodelplayanim("s2_gj_zom_drop_gate_lever_move_down");
  wait(1);
  self scriptmodelplayanim("s2_gj_zom_drop_gate_lever_down_idle");
}

lib_0549::func_3458() {
  self.var_5CCC = 1;
  wait 0.05;
  self.var_5CCC = 0;
}

lib_0549::func_3457() {
  self.var_2FAE = 1;
  foreach(var_01 in self.var_2F0F) {
    var_01.var_2FAE = 1;
  }
}

lib_0549::func_346A() {
  self.var_2FAE = undefined;
  foreach(var_01 in self.var_2F0F) {
    var_01.var_2FAE = undefined;
  }
}

lib_0549::func_3FFF() {
  self endon("gate_state_changed");
  for(;;) {
    self.var_3FFE waittill("drop_gate", var_00);
    if(var_00 == "unblock") {
      lib_0549::func_3469();
    }
  }
}

lib_0549::func_7127(param_00, param_01, param_02) {
  var_03 = level.var_3455[param_00];
  self notify("notetrack_timeout");
  if(!isDefined(var_03)) {
    return;
  }

  var_04 = getanimlength(var_03);
  var_05 = animhasnotetrack(var_03, "unblock");
  self.var_3FFE method_8495(param_00, self.var_8310, self.var_830F, "drop_gate");
  if(isDefined(param_02)) {
    thread lib_0549::func_4A2C(param_02, var_04);
  }

  if(param_01) {
    wait(var_04);
  }
}

lib_0549::func_4A2C(param_00, param_01) {
  self endon("notetrack_timeout");
  thread common_scripts\utility::func_67EC(param_01, "notetrack_timeout");
  [[param_00]]();
}

lib_0549::func_84AE(param_00) {
  self notify("gate_state_changed");
  self.var_931A = param_00;
}

lib_0549::func_A1E0(param_00) {
  var_01 = self.var_3FFE.var_0116;
  self.var_3FFE.var_0116 = (var_01[0], var_01[1], param_00.var_0116[2]);
}

lib_0549::func_3456() {
  self.var_17EB solid();
  self.var_17EB method_805B();
  self.var_17EB method_805F();
  self.var_17E9 = 1;
  foreach(var_01 in self.var_2F0F) {
    var_01.var_17E9 = 1;
    foreach(var_03 in var_01.var_9D06) {
      setnavlinkenabled(var_03, 1);
    }
  }
}

lib_0549::func_3469() {
  self.var_17EB notsolid();
  self.var_17EB method_805C();
  self.var_17EB method_8060();
  self.var_17E9 = 0;
  foreach(var_01 in self.var_2F0F) {
    var_01.var_17E9 = 0;
    foreach(var_03 in var_01.var_9D06) {
      setnavlinkenabled(var_03, 0);
    }
  }
}

lib_0549::func_4F91(param_00) {
  var_01 = param_00.var_15CC;
  if(common_scripts\utility::func_562E(self.var_2FDA)) {
    thread lib_053C::func_4F86(param_00);
    return 1;
  } else if(var_01 lib_0549::func_3459()) {
    thread lib_053C::func_4F92(param_00);
    return 1;
  }

  return 0;
}

lib_0549::func_4F90(param_00) {
  self notify("drop_gate_interact_interrupt");
  if(isDefined(self.var_15D2) && isalive(self)) {
    if(isDefined(self.var_92C9)) {
      lib_0549::func_346D();
    }

    self.var_15D2 = undefined;
    self scragentsetscripted(0);
    self method_839D("gravity");
  }
}

lib_0549::func_345A() {
  self notify("adjust_speed");
  self.var_6C05 = 0;
  self.var_6C06 = gettime();
  self.var_4C09 = 0;
}

lib_0549::func_3454(param_00) {
  self.var_6C05 = self.var_6C05 + param_00;
  thread lib_0549::func_346B();
}

lib_0549::func_346B() {
  self notify("update_struggle_sound");
  self endon("update_struggle_sound");
  waittillframeend;
  var_00 = 0.15;
  if(isDefined(self.var_5B26)) {
    var_01 = self.var_5B26 + var_00 * 1000 - gettime();
    if(var_01 > 0) {
      wait(var_01 / 1000);
    }
  }

  var_02 = 0;
  var_03 = self.var_6C05;
  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  for(var_04 = level.var_3464.size - 1; var_04 > -1; var_04--) {
    if(var_03 >= level.var_3464[var_04]) {
      var_02 = var_04;
      break;
    }
  }

  lib_0378::func_8D74("drop_gate_pull_level", self.var_8310, var_02);
  self.var_5B26 = gettime();
}

lib_0549::func_3467() {
  self endon("gate_state_changed");
  self endon("pull_state_change");
  var_00 = 0;
  var_01 = 0.05;
  for(;;) {
    var_00 = var_00 + self.var_6C05 * var_01;
    if(var_00 > 1) {
      var_00 = var_00 - 1;
      lib_0549::func_345E(1);
    }

    wait(var_01);
  }
}

lib_0549::func_346E(param_00) {
  self.var_92C9 = 1;
  param_00 lib_0549::func_3454(param_00.var_4C15);
  param_00 endon("gate_open");
  common_scripts\utility::func_A70A("drop_gate_interact_interrupt", "stop_gate_pull");
  param_00 lib_0549::func_3454(0 - param_00.var_4C15);
}

lib_0549::func_346D(param_00) {
  self.var_92C9 = undefined;
  self notify("stop_gate_pull");
}

lib_0549::func_345E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  self.var_4C11 = self.var_4C11 - param_00;
  if(self.var_4C11 <= 0) {
    self notify("pull_state_change");
  }
}

lib_0549::func_3459() {
  return self.var_931A != 3;
}

lib_0549::func_3463() {
  return self.var_931A == 0;
}

lib_0549::func_345B(param_00, param_01) {
  var_02 = level.var_3462[self.var_931A];
  if(param_01 == "mount") {
    var_02 = level.var_3462[0];
  }

  return "lift_gate_" + param_01 + "_" + param_00.var_2308.var_0EA5 + "_" + var_02;
}

lib_0549::func_345C(param_00, param_01) {
  var_02 = self.var_15CC;
  var_03 = var_02 lib_0549::func_345B(param_00, "mount");
  var_04 = param_00 maps\mp\agents\_scripted_agent_anim_util::func_434D(var_03);
  var_05 = param_00 method_83D8(var_04, 0);
  param_01.var_0116 = getstartorigin(self.var_8310, self.var_830F, var_05);
  param_01.var_001D = getstartangles(self.var_8310, self.var_830F, var_05);
  if(getdvarint("drop_gate_debug", 0) != 0) {}
}

lib_0549::func_345D(param_00, param_01) {
  param_01.var_0116 = param_01.var_92DE;
  param_01.var_001D = param_01.var_92DC;
}

lib_0549::func_5288() {
  self.var_38EB = undefined;
  self.var_188D = [];
  self.var_1890 = [];
  self.var_188E = [];
  self.var_17EC = 0;
  self.var_17E9 = 0;
  self.var_6044 = 6;
  self.var_7D0A = 1;
  self.var_9D06 = [];
  self.var_15D9 = "boards";
  var_00 = common_scripts\utility::func_44BE(self.var_01A2, "targetname");
  var_01 = common_scripts\utility::func_41EE();
  var_02 = common_scripts\utility::func_41F0();
  lib_0549::func_5289(var_00);
  var_03 = function_021F(self.var_01A2, "targetname");
  self.var_82EF = var_03[0];
  for(var_04 = 0; var_04 < 6; var_04++) {
    var_05 = spawnStruct();
    self.var_188D[var_04] = var_05;
    var_05.var_1887 = var_04;
  }

  self.var_188F = self.var_188D;
  foreach(var_07 in var_00) {
    if(isDefined(var_07.var_0165)) {
      switch (var_07.var_0165) {
        case "exit_point":
          self.var_38EB = var_07;
          break;
      }
    }
  }

  var_09 = [];
  if(isDefined(self.var_0164)) {
    foreach(var_0B in var_01) {
      if(lib_0549::func_553A(var_0B)) {
        var_09[var_09.size] = var_0B;
      }
    }
  } else if(isDefined(self.var_38EB)) {
    var_0D = 60;
    var_0E = 20;
    var_0F = getnodesinradius(self.var_0116, var_0D, 0, 180);
    if(isDefined(var_0F)) {
      foreach(var_0B in var_0F) {
        if(lib_0549::func_553A(var_0B)) {
          var_11 = anglesdelta(var_0B.var_001D, self.var_38EB.var_001D);
          if(var_11 < var_0E) {
            var_09[var_09.size] = var_0B;
          }
        }
      }
    }
  }

  foreach(var_0B in var_09) {
    self.var_9D06[self.var_9D06.size] = var_0B;
    var_0B.var_15CB = self;
  }

  lib_0549::func_885D();
  thread lib_0549::func_AA28();
}

lib_0549::func_5289(param_00) {
  self.var_1176 = [];
  self.var_1178 = [];
  self.var_1177 = [];
  foreach(var_02 in param_00) {
    if(isDefined(var_02.var_0165)) {
      switch (var_02.var_0165) {
        case "exit_point":
          self.var_38EB = var_02;
          break;

        case "attack_spot":
          var_03 = getclosestpointonnavmesh(var_02.var_0116);
          if(distance2d(var_02.var_0116, var_03) > 1) {
            break;
          }

          var_02.var_0116 = var_03;
          self.var_1176[self.var_1176.size] = var_02;
          var_02.var_1175 = 0;
          if(isDefined(var_02.var_81E1)) {
            switch (var_02.var_81E1) {
              case 0:
                var_02.var_0EA5 = "l";
                break;

              case 1:
                var_02.var_0EA5 = "m";
                break;

              case 2:
                var_02.var_0EA5 = "r";
                break;

              default:
                break;
            }
          }
          break;
      }
    }
  }

  foreach(var_06 in self.var_1176) {
    var_07 = var_06.var_0116 - anglesToForward(var_06.var_001D) * 36;
    var_08 = getclosestpointonnavmesh(var_07);
    if(distance2d(var_08, var_07) > 1 || !function_02DE(var_08, var_06.var_0116)) {
      var_06.var_A6E6 = var_06.var_0116;
      continue;
    }

    var_06.var_A6E6 = var_08;
  }

  self.var_1178 = self.var_1176;
}

lib_0549::func_885D() {
  var_00 = self.var_8140;
  if(!isDefined(var_00)) {
    var_00 = 6;
  }

  var_01 = common_scripts\utility::func_0F92(self.var_188D);
  if(var_00 == self.var_6044) {
    common_scripts\utility::func_9D9F();
  }

  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02].var_1887;
    if(var_02 < var_00) {
      lib_0549::func_15D5(var_03, 1);
      lib_0549::func_15D1();
      continue;
    }

    lib_0549::func_15D7(var_03, 1);
  }
}

lib_0549::func_563C(param_00) {
  if(!maps\mp\_utility::func_57A0(param_00)) {
    return 0;
  }

  var_01 = param_00 method_84D1();
  if(!isDefined(var_01) || var_01 != self) {
    return 0;
  }

  if(!param_00 useButtonPressed()) {
    return 0;
  }

  return 1;
}

lib_0549::func_3468() {
  self sethintstring(&"ZOMBIES_WALL_BUY_GENERIC");
  for(;;) {
    self waittill("trigger", var_00);
    if(!common_scripts\utility::func_562E(self.var_15CC.var_17E9)) {
      self.var_15CC notify("gate_purchase");
      continue;
    }
  }
}

lib_0549::func_345F() {
  self.var_17E9 = 1;
}

lib_0549::func_AA28() {
  self.var_A1F5 = 1;
  var_00 = undefined;
  if(!common_scripts\utility::func_562E(level.var_0C11)) {
    self makeunusable();
  }

  self sethintstring(&"ZOMBIES_REPAIR_BOARDS_HINT");
  for(;;) {
    var_01 = 0;
    if(!common_scripts\utility::func_562E(self.var_9D9F)) {
      foreach(var_03 in level.var_744A) {
        if(lib_0549::func_563C(var_03) && self istouching(var_03)) {
          var_00 = var_03;
          var_01 = 1;
          break;
        }
      }
    }

    if(!var_01) {
      self waittill("trigger", var_00);
    }

    var_05 = common_scripts\utility::func_0F92(self.var_1890);
    var_06 = var_05[0];
    thread lib_0549::func_15D4(var_06.var_1887);
    if(isDefined(var_00.var_7F11)) {
      var_00.var_7F11 = var_00.var_7F11 + 1;
    }

    if(var_00.var_7D10 < level.var_609C) {
      var_07 = min(level.var_609C - var_00.var_7D10, 10);
      var_00 maps\mp\gametypes\zombies::func_47AE("repair");
      var_00 thread lib_054E::func_62D9();
      var_00.var_7D10 = var_00.var_7D10 + var_07;
    }

    self.var_5B41 = var_00;
    self.var_5B42 = gettime();
    wait(1);
  }
}

lib_0549::func_553A(param_00) {
  return param_00.var_01B9 == "Begin" || param_00.var_01B9 == "Begin 3D";
}