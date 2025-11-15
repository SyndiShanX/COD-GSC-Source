/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\_scriptedagents.gsc
*************************************************/

func_197F(param_00, param_01) {
  self.behaviortreeasset = param_00;
  scripts\aitypes\bt_util::func_77();
  scripts\asm\asm_mp::func_234D(param_01);
  thread func_19F7();
}

registernotetracks() {
  level.notetracks["footstep_right_large"] = ::notetrackfootstep;
  level.notetracks["footstep_right_small"] = ::notetrackfootstep;
  level.notetracks["footstep_left_large"] = ::notetrackfootstep;
  level.notetracks["footstep_left_small"] = ::notetrackfootstep;
}

notetrackfootstep(param_00, param_01) {
  var_02 = issubstr(param_00, "left");
  var_03 = issubstr(param_00, "large");
  var_04 = "right";
  if(var_02) {
    var_04 = "left";
  }

  if(var_03) {
    self notify("large_footstep");
  }

  self.asm.footsteps.foot = var_04;
  self.asm.footsteps.time = gettime();
}

func_89A9(param_00, param_01, param_02) {
  if(isDefined(level.notetracks[param_00])) {
    return [[level.notetracks[param_00]]](param_00, param_01);
  }

  return undefined;
}

func_0219(param_00, param_01) {
  if(isDefined(self.onenteranimstate)) {
    self[[self.onenteranimstate]](param_00, param_01);
  }
}

func_0218() {
  self notify("killanimscript");
  self notify("terminate_ai_threads");
}

func_19F7() {
  self endon("terminate_ai_threads");
  thread scripts\asm\asm_mp::func_C878();
  thread scripts\asm\asm_mp::traversehandler();
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    scripts\aitypes\bt_util::func_90();
    scripts\asm\asm::func_2314();
    if(isDefined(self.asm.var_10E23)) {
      scripts\asm\asm::asm_clearevents(self.asm.var_10E23);
      self.asm.var_10E23 = undefined;
    }

    scripts\asm\asm::func_2389();
    wait(0.05);
  }
}

func_CED9(param_00, param_01, param_02, param_03) {
  func_CED5(param_00, 0, param_01, param_02, param_03);
}

func_CED5(param_00, param_01, param_02, param_03, param_04) {
  self setanimstate(param_00, param_01);
  if(!isDefined(param_03)) {
    param_03 = "end";
  }

  func_1384C(param_02, param_03, param_00, param_01, param_04);
}

func_CED2(param_00, param_01, param_02, param_03, param_04, param_05) {
  self setanimstate(param_00, param_01, param_02);
  if(!isDefined(param_04)) {
    param_04 = "end";
  }

  func_1384C(param_03, param_04, param_00, param_01, param_05);
}

func_1384A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = undefined;
  if(isDefined(param_05)) {
    var_07 = gettime() - param_06 * 0.001 / param_05;
  }

  func_89A9(param_00, param_02, param_04);
  if(isDefined(param_02) && isDefined(self.asm)) {
    scripts\asm\asm_mp::func_2345(param_00, param_02, param_03, var_07);
  }

  if(!isDefined(param_05) || var_07 > 0) {
    if(param_00 == param_01 || param_00 == "end" || param_00 == "anim_will_finish" || param_00 == "finish") {
      return 1;
    }
  }

  if(isDefined(param_04)) {
    [[param_04]](param_00, param_02, param_03, var_07);
  }

  return 0;
}

func_1384C(param_00, param_01, param_02, param_03, param_04) {
  var_05 = gettime();
  var_06 = undefined;
  if(isDefined(param_02) && isDefined(param_03)) {
    var_06 = getanimlength(self getsafecircleorigin(param_02, param_03));
  }

  for(var_07 = 0; !var_07; var_07 = func_1384A(var_08, param_01, param_02, param_03, param_04, var_06, var_05)) {
    self waittill(param_00, var_08);
    if(isarray(var_08)) {
      foreach(var_0A in var_08) {
        if(func_1384A(var_0A, param_01, param_02, param_03, param_04, var_06, var_05)) {
          var_07 = 1;
        }
      }

      continue;
    }
  }
}

func_CED0(param_00, param_01) {
  func_CED4(param_00, 0, param_01);
}

func_CED4(param_00, param_01, param_02) {
  self setanimstate(param_00, param_01);
  wait(param_02);
}

playanimnwithnotetracksfortime(param_00, param_01, param_02, param_03, param_04) {
  self setanimstate(param_00, param_01);
  thread playanimnwithnotetracksfortime_helper(param_00, param_01, param_02, param_04);
  wait(param_03);
  self notify(param_00 + param_01);
}

playanimnwithnotetracksfortime_helper(param_00, param_01, param_02, param_03) {
  self notify(param_00 + param_01);
  self endon(param_00 + param_01);
  var_04 = 0;
  var_05 = self getsafecircleorigin(param_00, param_01);
  var_06 = getanimlength(var_05);
  var_07 = gettime();
  while(!var_04) {
    self waittill(param_02, var_08);
    if(!isarray(var_08)) {
      var_08 = [var_08];
    }

    foreach(var_0A in var_08) {
      if(func_1384A(var_0A, "end", param_00, param_01, param_03, var_06, var_07)) {
        var_04 = 1;
      }
    }
  }
}

func_CED1(param_00, param_01, param_02, param_03) {
  self setanimstate(param_00, param_01, param_02);
  wait(param_03);
}

func_7DC9(param_00, param_01, param_02) {
  var_03 = length2d(param_00);
  var_04 = param_00[2];
  var_05 = length2d(param_01);
  var_06 = param_01[2];
  var_07 = 1;
  var_08 = 1;
  if(isDefined(param_02) && param_02) {
    var_09 = (param_01[0], param_01[1], 0);
    var_0A = vectornormalize(var_09);
    if(vectordot(var_0A, param_00) < 0) {
      var_07 = 0;
    } else if(var_05 > 0) {
      var_07 = var_03 / var_05;
    }
  } else if(var_05 > 0) {
    var_07 = var_03 / var_05;
  }

  if(abs(var_06) > 0.001 && var_06 * var_04 >= 0) {
    var_08 = var_04 / var_06;
  }

  var_0B = spawnStruct();
  var_0B.var_13E2B = var_07;
  var_0B.var_3A6 = var_08;
  return var_0B;
}

func_5D51(param_00, param_01) {
  var_02 = 15;
  var_03 = 45;
  if(isDefined(self.fgetarg)) {
    var_02 = self.fgetarg;
  }

  if(isDefined(self.height)) {
    var_03 = self.height;
  }

  if(!isDefined(param_01)) {
    param_01 = 18;
  }

  var_04 = param_00 + (0, 0, param_01);
  var_05 = param_00 + (0, 0, param_01 * -1);
  var_06 = self aiphysicstrace(var_04, var_05, self.fgetarg, self.height, 1);
  if(abs(var_06[2] - var_04[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_06[2] - var_05[2]) < 0.1) {
    return undefined;
  }

  return var_06;
}

func_38D0(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 6;
  }

  if(!isDefined(param_03)) {
    param_03 = self.fgetarg;
  }

  var_04 = (0, 0, 1) * param_02;
  var_05 = param_00 + var_04;
  var_06 = param_01 + var_04;
  return self getnumactiveagents(var_05, var_06, param_03, self.height - param_02, 1);
}

getvalidplayersinteam(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 6;
  }

  var_03 = (0, 0, 1) * param_02;
  var_04 = param_00 + var_03;
  var_05 = param_01 + var_03;
  return self aiphysicstrace(var_04, var_05, self.fgetarg + 4, self.height - param_02, 1);
}

getsafecircleradius(param_00) {
  var_01 = getmovedelta(param_00);
  var_02 = self gettweakablevalue(var_01);
  var_03 = getvalidplayersinteam(self.origin, var_02);
  var_04 = distance(self.origin, var_03);
  var_05 = distance(self.origin, var_02);
  return min(1, var_04 / var_05);
}

func_EA25(param_00, param_01, param_02, param_03) {
  var_04 = getrandomanimentry(param_00);
  func_EA24(param_00, var_04, param_01, param_02, param_03);
}

func_EA22(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getrandomanimentry(param_00);
  func_EA23(param_00, var_05, param_01, param_02, param_03, param_04);
}

func_EA23(param_00, param_01, param_02, param_03, param_04, param_05) {
  self setanimstate(param_00, param_01, param_02);
  func_EA24(param_00, param_01, param_03, param_04, param_05);
}

func_EA24(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self getsafecircleorigin(param_00, param_01);
  var_06 = getsafecircleradius(var_05);
  self scragentsetanimscale(var_06, 1);
  func_CED5(param_00, param_01, param_02, param_03, param_04);
  self scragentsetanimscale(1, 1);
}

getrandomanimentry(param_00) {
  var_01 = self getanimentrycount(param_00);
  return randomint(var_01);
}

func_7DBD(param_00) {
  var_01 = vectortoangles(param_00);
  var_02 = angleclamp180(var_01[1] - self.angles[1]);
  return getangleindex(var_02);
}

func_F2B1(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    self setanimstate(param_00, param_01, param_02);
    return;
  }

  if(isDefined(param_01)) {
    self setanimstate(param_00, param_01);
    return;
  }

  self setanimstate(param_00);
}

isstatelocked() {
  if(!isDefined(self.projectileintercept)) {
    return 0;
  }

  return self.projectileintercept;
}

setstatelocked(param_00, param_01) {
  self.projectileintercept = param_00;
}

func_CED6(param_00, param_01, param_02, param_03, param_04) {
  func_CED3(param_00, param_01, 1, param_02, param_03, param_04);
}

func_1384D(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("death");
  if(isDefined(param_02)) {
    childthread func_C0E0(param_00, param_02, param_01);
  }

  func_1384C(param_00, param_01);
  self notify("Notetrack_Timeout");
}

func_CED3(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("disconnect");
  self endon("death");
  if(isDefined(param_00)) {
    if(isDefined(param_01)) {
      var_06 = getanimlength(self getsafecircleorigin(param_00, param_01));
    } else {
      var_06 = getanimlength(self getsafecircleorigin(param_01, 0));
    }

    childthread func_C0E0(param_03, var_06 * 1 / param_02, param_04);
  }

  func_CED2(param_00, param_01, param_02, param_03, param_04, param_05);
  self notify("Notetrack_Timeout");
}

func_C0E0(param_00, param_01, param_02) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  param_01 = max(0.05, param_01);
  wait(param_01);
  if(isDefined(param_02)) {
    self notify(param_00, param_02);
    return;
  }

  self notify(param_00, "end");
}

func_5AC1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_04 != "highest_point") {
    func_CED5(param_00, param_01, param_03, param_04, param_07);
  }

  if(param_06) {
    var_08 = self.endnode_pos;
    var_09 = 1;
  } else {
    var_08 = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
    var_09 = var_09.origin;
    var_0A = getnotetracktimes(param_03, "highest_point");
    var_09 = var_0A[0];
  }

  func_5AC2(param_00, param_01, param_03, param_02, param_04, param_05, var_08, var_09, param_07);
}

func_5AC2(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = abs(self.origin[2] - param_06[2]);
  var_0A = getnotetracktimes(param_03, param_04);
  var_0B = var_0A[0];
  var_0C = var_0B;
  var_0D = getnotetracktimes(param_03, param_05);
  var_0E = var_0D[0];
  param_07 = var_0E;
  var_0F = "flex_height_up_top";
  var_10 = getnotetracktimes(param_03, var_0F);
  var_11 = "flex_height_down_top";
  var_12 = getnotetracktimes(param_03, var_11);
  var_13 = "flex_height_down_bottom";
  var_14 = getnotetracktimes(param_03, var_13);
  if(param_04 == "flex_height_up_start" && var_10.size > 0) {
    param_07 = var_10[0];
  }

  if(param_04 == "flex_height_down_start") {
    if(var_12.size > 0) {
      var_0C = var_10[0];
    }

    if(var_14.size > 0) {
      param_07 = var_14[0];
    }
  }

  var_15 = getmovedelta(param_03, var_0C, param_07);
  var_16 = abs(var_15[2]);
  var_18 = getmovedelta(param_03, var_0B, var_0E);
  var_19 = abs(var_18[2]);
  if(var_19 < 1) {
    var_1A = 1;
  } else {
    var_1B = var_18 - var_1A;
    if(var_09 <= var_1B) {
      var_1A = var_1B - var_09 / var_19;
    } else {
      var_1A = var_09 - var_1B / var_19;
    }
  }

  self scragentsetanimscale(1, var_1A);
  if(var_0B != 0) {
    var_1C = self getscoreinfocategory(param_03);
    if(var_1C < var_0B) {
      func_CED2(param_00, param_01, 1, param_02, param_04, param_08);
    }
  }

  var_1D = clamp(1 / var_1A, 0.33, 3);
  func_CED2(param_00, param_01, var_1D, param_02, param_05, param_08);
}