/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_traverse.gsc
************************************************/

func_00F9() {
  self endon("killanimscript");
  if(!isDefined(level.var_31FA)) {
    func_52AE();
  }

  var_00 = self method_8198();
  var_01 = self method_8199();
  if(var_00.var_001E == "bot_walk_forward") {
    var_02 = var_01.var_0116 - var_00.var_0116;
    var_03 = length(var_02) / 256;
    var_04 = (var_02[0], var_02[1], 0);
    var_05 = vectortoangles(var_04);
    self scragentsetorientmode("face angle abs", var_05);
    self method_83A4(var_00.var_0116, var_01.var_0116, var_03);
    self method_839D("noclip");
    maps\mp\agents\_scriptedagents::func_71F7("run", var_03);
    return;
  }

  var_06 = undefined;
  var_06 = level.var_31FA[var_00.var_001E];
  if(!isDefined(var_06)) {
    return;
  }

  self.var_17E8 = 1;
  var_02 = var_01.var_0116 - var_00.var_0116;
  var_04 = (var_02[0], var_02[1], 0);
  var_05 = vectortoangles(var_04);
  self scragentsetorientmode("face angle abs", var_05);
  self method_839C("anim deltas");
  var_07 = self method_83D8(var_06, 0);
  var_08 = getnotetracktimes(var_07, "code_move");
  if(var_08.size > 0) {
    var_09 = getmovedelta(var_07, 0, var_08[0]);
  } else {
    var_09 = getmovedelta(var_08, 0, 1);
  }

  var_0A = maps\mp\agents\_scriptedagents::func_441C(var_02, var_09);
  self method_839D("noclip");
  if(var_02[2] > 0) {
    if(var_09[2] > 0) {
      var_0B = getnotetracktimes(var_07, "traverse_jump_start");
      if(var_0B.size > 0) {
        var_0C = 1;
        var_0D = 1;
        if(length2dsquared(var_04) < 0.64 * length2dsquared(var_09)) {
          var_0C = 0.4;
        }

        if(var_02[2] < 0.75 * var_09[2]) {
          var_0D = 0.5;
        }

        self method_839A(var_0C, var_0D);
        maps\mp\agents\_scriptedagents::func_71FC(var_06, 0, "traverse", "traverse_jump_start");
        var_0E = getnotetracktimes(var_07, "traverse_jump_end");
        var_0F = getmovedelta(var_07, 0, var_0B[0]);
        var_10 = getmovedelta(var_07, 0, var_0E[0]);
        var_0C = 1;
        var_0D = 1;
        var_11 = var_01.var_0116 - self.var_0116;
        var_12 = var_09 - var_0F;
        if(length2dsquared(var_11) < 0.5625 * length2dsquared(var_12)) {
          var_0C = 0.75;
        }

        if(var_11[2] < 0.75 * var_12[2]) {
          var_0D = 0.75;
        }

        var_13 = var_09 - var_10;
        var_14 = (var_13[0] * var_0C, var_13[1] * var_0C, var_13[2] * var_0D);
        var_15 = rotatevector(var_14, var_05);
        var_16 = var_01.var_0116 - var_15;
        var_17 = var_10 - var_0F;
        var_18 = rotatevector(var_17, var_05);
        var_19 = var_16 - self.var_0116;
        var_0A = maps\mp\agents\_scriptedagents::func_441C(var_19, var_18, 1);
        self method_839A(var_0A.var_AAE3, var_0A.var_01D9);
        maps\mp\agents\_scriptedagents::func_A79E("traverse", "traverse_jump_end");
        self method_839A(var_0C, var_0D);
        maps\mp\agents\_scriptedagents::func_A79E("traverse", "code_move");
        return;
      }

      self method_839A(var_0A.var_AAE3, var_0A.var_01D9);
      maps\mp\agents\_scriptedagents::func_71FC(var_06, 0, "traverse");
      return;
    }

    var_1A = getnotetracktimes(var_07, "gravity on");
    if(var_1A.size > 0) {
      var_1B = var_00 func_46BF();
      if(isDefined(var_1B)) {
        var_1C = var_1B - self.var_0116;
        var_1D = var_01.var_0116 - var_1B;
        var_1E = getmovedelta(var_07, 0, var_1A[0]);
        var_0A = maps\mp\agents\_scriptedagents::func_441C(var_1C, var_1E);
        self method_839A(var_0A.var_AAE3, var_0A.var_01D9);
        maps\mp\agents\_scriptedagents::func_71FC(var_06, 0, "traverse", "gravity on");
        var_1F = getmovedelta(var_07, var_1A[0], 1);
        var_0A = maps\mp\agents\_scriptedagents::func_441C(var_1D, var_1F);
        self method_839A(var_0A.var_AAE3, var_0A.var_01D9);
        maps\mp\agents\_scriptedagents::func_A79E("traverse", "code_move");
        return;
      }
    }

    var_20 = getanimlength(var_07);
    self method_83A4(var_00.var_0116, var_01.var_0116, var_20);
    maps\mp\agents\_scriptedagents::func_71FC(var_06, 0, "traverse");
    return;
  }

  var_1A = getnotetracktimes(var_07, "gravity on");
  if(var_1A.size > 0) {
    self method_839A(var_0A.var_AAE3, 1);
    maps\mp\agents\_scriptedagents::func_71FC(var_06, 0, "traverse", "gravity on");
    var_21 = getmovedelta(var_07, 0, var_1A[0]);
    var_22 = var_21[2] - var_09[2];
    if(abs(var_22) > 0) {
      var_23 = self.var_0116[2] - var_01.var_0116[2];
      var_0D = var_23 / var_22;
      self method_839A(var_0A.var_AAE3, var_0D);
      var_24 = clamp(2 / var_0D, 0.5, 1);
      var_25 = var_06 + "_norestart";
      self method_83D7(var_25, 0, var_24);
    }

    maps\mp\agents\_scriptedagents::func_A79E("traverse", "code_move");
  } else {
    self method_839A(var_0A.var_AAE3, var_0A.var_01D9);
    var_24 = clamp(2 / var_0A.var_01D9, 0.5, 1);
    var_0E = getnotetracktimes(var_07, "traverse_jump_end");
    if(var_0E.size > 0) {
      maps\mp\agents\_scriptedagents::func_71F9(var_06, 0, var_24, "traverse", "traverse_jump_end");
      var_25 = var_06 + "_norestart";
      self method_83D7(var_25, 0, 1);
      maps\mp\agents\_scriptedagents::func_A79E("traverse", "code_move");
    } else {
      maps\mp\agents\_scriptedagents::func_71FC(var_06, 0, "traverse");
    }
  }

  self method_839A(1, 1);
}

func_0085() {
  self method_839A(1, 1);
  self.var_17E8 = 0;
}

func_46BF() {
  if(isDefined(self.var_9829)) {
    return self.var_9829;
  }

  var_00 = getent(self.var_01A2, "targetname");
  if(!isDefined(var_00)) {
    return undefined;
  }

  self.var_9829 = var_00.var_0116;
  var_00 delete();
  return self.var_9829;
}

func_52AE() {
  level.var_31FA = [];
  level.var_31FA["hjk_tree_hop"] = "traverse_jump_over_24";
  level.var_31FA["jump_across_72"] = "traverse_jump_over_24";
  level.var_31FA["wall_hop"] = "traverse_jump_over_36";
  level.var_31FA["window_2"] = "traverse_jump_over_36";
  level.var_31FA["wall_over_40"] = "traverse_jump_over_36";
  level.var_31FA["wall_over"] = "traverse_jump_over_36";
  level.var_31FA["window_divethrough_36"] = "traverse_jump_over_36";
  level.var_31FA["window_over_40"] = "traverse_jump_over_36";
  level.var_31FA["window_over_quick"] = "traverse_jump_over_36";
  level.var_31FA["jump_up_80"] = "traverse_jump_up_70";
  level.var_31FA["jump_standing_80"] = "traverse_jump_up_70";
  level.var_31FA["jump_down_80"] = "traverse_jump_down_70";
  level.var_31FA["jumpdown_96"] = "traverse_jump_down_70";
  level.var_31FA["jump_up_40"] = "traverse_jump_up_40";
  level.var_31FA["jump_down_40"] = "traverse_jump_down_40";
  level.var_31FA["step_up"] = "traverse_jump_up_24";
  level.var_31FA["step_up_24"] = "traverse_jump_up_24";
  level.var_31FA["step_down"] = "traverse_jump_down_24";
  level.var_31FA["jump_down"] = "traverse_jump_down_24";
  level.var_31FA["jump_across"] = "traverse_jump_over_36";
  level.var_31FA["jump_across_100"] = "traverse_jump_over_36";
}