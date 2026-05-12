/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_move.gsc
*********************************************/

func_00F9() {
  self endon("killanimscript");
  self.var_17E8 = 0;
  self method_839D("gravity");
  func_92E9();
  func_2603();
}

func_0085() {
  self.var_17E8 = 0;
  func_1F39(undefined);
  self method_839A(1, 1);
}

func_8A30() {
  thread func_A6C2();
  thread func_A6C4();
  thread func_A6C7();
}

func_2603() {
  func_8A30();
  self method_839C("code_move");
  self scragentsetorientmode("face motion");
  self method_839A(1, 1);
  func_86CF(self.var_0108);
}

func_86CF(param_00) {
  self method_83D7(param_00);
}

func_A6C2() {
  self endon("dogmove_endwait_runwalk");
  self endon("death");
  var_00 = self.var_0108;
  for(;;) {
    if(var_00 != self.var_0108) {
      func_86CF(self.var_0108);
      var_00 = self.var_0108;
    }

    wait(0.1);
  }
}

func_32A8(param_00) {
  var_01 = vectortoangles(param_00);
  var_02 = angleclamp180(var_01[1] - self.var_001D[1]);
  var_03 = maps\mp\agents\_scriptedagents::func_4414(var_02);
  if(var_03 == 4) {
    func_2603();
    return;
  }

  var_04 = "sharp_turn";
  var_05 = self method_83D8(var_04, var_03);
  var_06 = getangledelta(var_05);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", (0, angleclamp180(var_01[1] - var_06), 0));
  maps\mp\agents\_scriptedagents::func_71FC(var_04, var_03, "sharp_turn");
  func_2603();
}

func_A6C4() {
  self endon("dogmove_endwait_sharpturn");
  self endon("death");
  self waittill("path_dir_change", var_00);
  func_1F39("sharpturn");
  func_32A8(var_00);
}

func_A6C7() {
  self endon("dogmove_endwait_stop");
  self endon("death");
  self waittill("stop_soon");
  if(isDefined(self.var_15E1) && !self.var_15E1) {
    thread func_A6C7();
    return;
  }

  var_00 = func_46B1();
  var_01 = self method_83D8(var_00.var_931A, var_00.var_00D4);
  var_02 = getmovedelta(var_01);
  var_03 = getangledelta(var_01);
  var_04 = self method_83E7();
  var_05 = var_04 - self.var_0116;
  if(length(var_05) + 12 < length(var_02)) {
    thread func_A6C7();
    return;
  }

  var_06 = func_46B2();
  var_07 = func_1E40(var_06.var_7584, var_06.var_001D[1], var_02, var_03);
  var_08 = maps\mp\agents\_scriptedagents::func_34A6(var_07);
  if(!isDefined(var_08)) {
    thread func_A6C7();
    return;
  }

  if(!maps\mp\agents\_scriptedagents::func_1F5B(var_06.var_7584, var_08)) {
    thread func_A6C7();
    return;
  }

  func_1F39("stop");
  thread func_A6B2();
  thread func_A6C5();
  if(distancesquared(var_07, self.var_0116) > 4) {
    self method_8394(var_07);
    thread func_A693();
    self waittill("waypoint_reached");
    self notify("dogmove_endwait_blockedwhilestopping");
  }

  var_09 = var_04 - self.var_0116;
  var_0A = vectortoangles(var_09);
  var_0B = (0, var_0A[1] - var_03, 0);
  var_0C = maps\mp\agents\_scriptedagents::func_441C(var_04 - self.var_0116, var_02);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", var_0B, (0, var_0A[1], 0));
  self method_839A(var_0C.var_AAE3, var_0C.var_01D9);
  maps\mp\agents\_scriptedagents::func_71FC(var_00.var_931A, var_00.var_00D4, "move_stop");
  self method_8395(self.var_0116);
}

func_A6B2() {
  self endon("killanimscript");
  self endon("dogmove_endwait_pathsetwhilestopping");
  var_00 = self method_8396();
  self waittill("path_set");
  var_01 = self method_8396();
  if(distancesquared(var_00, var_01) < 1) {
    thread func_A6B2();
    return;
  }

  self notify("dogmove_endwait_stop");
  self notify("dogmove_endwait_sharpturnwhilestopping");
  func_2603();
}

func_A6C5() {
  self endon("killanimscript");
  self endon("dogmove_endwait_sharpturnwhilestopping");
  self waittill("path_dir_change", var_00);
  self notify("dogmove_endwait_pathsetwhilestopping");
  self notify("dogmove_endwait_stop");
  func_32A8(var_00);
}

func_A693() {
  self endon("killanimscript");
  self endon("dogmove_endwait_blockedwhilestopping");
  self waittill("path_blocked");
  self notify("dogmove_endwait_stop");
  self method_8394(undefined);
}

func_A6C8() {
  self endon("killanimscript");
  self endon("dogmove_endwait_stopearly");
  var_00 = self method_83D8("move_stop_4", 0);
  var_01 = getmovedelta(var_00);
  var_02 = length(var_01);
  var_03 = self.var_7673 + var_02;
  var_04 = var_03 * var_03;
  if(distancesquared(self.var_0116, self.var_0117.var_0116) <= var_04) {
    return;
  }

  for(;;) {
    if(!isDefined(self.var_0117)) {
      break;
    }

    if(distancesquared(self.var_0116, self.var_0117.var_0116) < var_04) {
      var_05 = self localtoworldcoords(var_01);
      self method_8395(var_05);
      break;
    }

    wait(0.1);
  }
}

func_1F39(param_00) {
  var_01 = ["runwalk", "sharpturn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "sharpturnwhilestopping", "stopearly"];
  var_02 = isDefined(param_00);
  foreach(var_04 in var_01) {
    if(var_02 && var_04 == param_00) {
      continue;
    }

    self notify("dogmove_endwait_" + var_04);
  }
}

func_92E9() {
  var_00 = self method_8198();
  if(isDefined(var_00)) {
    var_01 = var_00.var_0116;
  } else {
    var_01 = self method_83E7();
  }

  if(distancesquared(var_01, self.var_0116) < 10000) {
    return;
  }

  var_02 = self method_83E6();
  var_03 = vectortoangles(var_02);
  var_04 = self getvelocity();
  if(length2dsquared(var_04) > 16) {
    var_04 = vectornormalize(var_04);
    if(vectordot(var_04, var_02) > 0.707) {
      return;
    }
  }

  var_05 = angleclamp180(var_03[1] - self.var_001D[1]);
  var_06 = maps\mp\agents\_scriptedagents::func_4414(var_05);
  var_07 = self method_83D8("move_start", var_06);
  var_08 = getmovedelta(var_07);
  var_09 = rotatevector(var_08, self.var_001D) + self.var_0116;
  if(!maps\mp\agents\_scriptedagents::func_1F5B(self.var_0116, var_09)) {
    return;
  }

  var_0A = getangledelta3d(var_07);
  self method_839C("anim deltas");
  if(3 <= var_06 && var_06 <= 5) {
    self scragentsetorientmode("face angle abs", (0, angleclamp180(var_03[1] - var_0A[1]), 0));
  } else {
    self scragentsetorientmode("face angle abs", self.var_001D);
  }

  self.var_17E8 = 1;
  maps\mp\agents\_scriptedagents::func_71FC("move_start", var_06, "move_start");
  self.var_17E8 = 0;
}

func_46B2() {
  var_00 = spawnStruct();
  if(isDefined(self.var_010D)) {
    var_00.var_7584 = self.var_010D.var_0116;
    var_00.var_001D = self.var_010D.var_001D;
  } else {
    var_01 = self method_83E7();
    var_00.var_7584 = var_01;
    var_00.var_001D = vectortoangles(self method_83E6());
  }

  return var_00;
}

func_46B1(param_00) {
  if(isDefined(self.var_010D)) {
    var_01 = self.var_010D.var_001D[1] - self.var_001D[1];
    var_02 = maps\mp\agents\_scriptedagents::func_4414(var_01);
  } else {
    var_02 = 4;
  }

  var_03 = spawnStruct();
  var_03.var_931A = "move_stop";
  var_03.var_00D4 = var_02;
  return var_03;
}

func_1E40(param_00, param_01, param_02, param_03) {
  var_04 = param_01 - param_03;
  var_05 = (0, var_04, 0);
  var_06 = anglesToForward(var_05);
  var_07 = anglestoright(var_05);
  var_08 = var_06 * param_02[0];
  var_09 = var_07 * param_02[1];
  return param_00 - var_08 + var_09;
}

func_3191() {
  var_00 = clamp(self.var_00E9 / 25, -1, 1);
  if(var_00 > 0) {}
}

func_4AC2(param_00, param_01, param_02, param_03) {
  if(1) {
    return 0;
  }

  switch (param_00) {
    case "footstep_back_right_large":
    case "footstep_back_left_large":
    case "footstep_front_right_large":
    case "footstep_front_left_large":
    case "footstep_back_right_small":
    case "footstep_back_left_small":
    case "footstep_front_right_small":
    case "footstep_front_left_small":
      var_04 = undefined;
      if(isDefined(self.var_019C)) {
        var_04 = self.var_019C;
        self.var_5C01 = var_04;
      } else if(isDefined(self.var_5C01)) {
        var_04 = self.var_5C01;
      } else {
        var_04 = "dirt";
      }

      if(var_04 != "dirt" && var_04 != "concrete" && var_04 != "wood" && var_04 != "metal") {
        var_04 = "dirt";
      }

      if(var_04 == "concrete") {
        var_04 = "cement";
      }

      if(self.var_0BA4 == "traverse") {
        var_05 = "land";
      } else if(self.var_0108 == "sprint") {
        var_05 = "sprint";
      } else if(self.var_0108 == "fastwalk") {
        var_05 = "walk";
      } else {
        var_05 = "run";
      }

      self playsoundonmovingent("dogstep_" + var_05 + "_" + var_04);
      if(issubstr(param_00, "front_left")) {
        var_06 = "anml_dog_mvmt_accent";
        var_07 = "anml_dog_mvmt_vest";
        if(var_05 == "walk") {
          var_08 = "_npc";
        } else {
          var_08 = "_run_npc";
        }

        self playsoundonmovingent(var_06 + var_08);
        self playsoundonmovingent(var_07 + var_08);
      }
      return 1;
  }

  return 0;
}

func_31FC(param_00) {
  func_1F39(undefined);
  self.var_17E8 = 1;
  self.var_018F = 1;
  var_01 = angleclamp180(param_00 - self.var_001D[1]);
  if(var_01 > 0) {
    var_02 = 1;
  } else {
    var_02 = 0;
  }

  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_001D);
  maps\mp\agents\_scriptedagents::func_71FC("run_pain", var_02, "run_pain");
  self.var_17E8 = 0;
  self.var_018F = 0;
  func_2603();
}

func_6ADB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(self.var_018F) {
    return;
  }

  var_0A = vectortoangles(param_07);
  var_0B = var_0A[1] - 180;
  func_31FC(var_0B);
}

func_6B3B(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(self.var_018F) {
    return;
  }

  func_31FC(self.var_001D[1] + 180);
}