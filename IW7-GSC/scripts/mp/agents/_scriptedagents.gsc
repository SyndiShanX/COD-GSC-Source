/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\_scriptedagents.gsc
*************************************************/

func_197F(var_0, var_1) {
  self.behaviortreeasset = var_0;
  scripts\aitypes\bt_util::func_77();
  scripts\asm\asm_mp::func_234D(var_1);
  thread func_19F7();
}

registernotetracks() {
  level.notetracks["footstep_right_large"] = ::notetrackfootstep;
  level.notetracks["footstep_right_small"] = ::notetrackfootstep;
  level.notetracks["footstep_left_large"] = ::notetrackfootstep;
  level.notetracks["footstep_left_small"] = ::notetrackfootstep;
}

notetrackfootstep(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  var_4 = "right";
  if(var_2) {
    var_4 = "left";
  }

  if(var_3) {
    self notify("large_footstep");
  }

  self.asm.footsteps.foot = var_4;
  self.asm.footsteps.time = gettime();
}

func_89A9(var_0, var_1, var_2) {
  if(isDefined(level.notetracks[var_0])) {
    return [[level.notetracks[var_0]]](var_0, var_1);
  }

  return undefined;
}

func_0219(var_0, var_1) {
  if(isDefined(self.onenteranimstate)) {
    self[[self.onenteranimstate]](var_0, var_1);
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

func_CED9(var_0, var_1, var_2, var_3) {
  func_CED5(var_0, 0, var_1, var_2, var_3);
}

func_CED5(var_0, var_1, var_2, var_3, var_4) {
  self setanimstate(var_0, var_1);
  if(!isDefined(var_3)) {
    var_3 = "end";
  }

  func_1384C(var_2, var_3, var_0, var_1, var_4);
}

func_CED2(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);
  if(!isDefined(var_4)) {
    var_4 = "end";
  }

  func_1384C(var_3, var_4, var_0, var_1, var_5);
}

func_1384A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  if(isDefined(var_5)) {
    var_7 = gettime() - var_6 * 0.001 / var_5;
  }

  func_89A9(var_0, var_2, var_4);
  if(isDefined(var_2) && isDefined(self.asm)) {
    scripts\asm\asm_mp::func_2345(var_0, var_2, var_3, var_7);
  }

  if(!isDefined(var_5) || var_7 > 0) {
    if(var_0 == var_1 || var_0 == "end" || var_0 == "anim_will_finish" || var_0 == "finish") {
      return 1;
    }
  }

  if(isDefined(var_4)) {
    [[var_4]](var_0, var_2, var_3, var_7);
  }

  return 0;
}

func_1384C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();
  var_6 = undefined;
  if(isDefined(var_2) && isDefined(var_3)) {
    var_6 = getanimlength(self getsafecircleorigin(var_2, var_3));
  }

  for(var_7 = 0; !var_7; var_7 = func_1384A(var_8, var_1, var_2, var_3, var_4, var_6, var_5)) {
    self waittill(var_0, var_8);
    if(isarray(var_8)) {
      foreach(var_10 in var_8) {
        if(func_1384A(var_10, var_1, var_2, var_3, var_4, var_6, var_5)) {
          var_7 = 1;
        }
      }

      continue;
    }
  }
}

func_CED0(var_0, var_1) {
  func_CED4(var_0, 0, var_1);
}

func_CED4(var_0, var_1, var_2) {
  self setanimstate(var_0, var_1);
  wait(var_2);
}

playanimnwithnotetracksfortime(var_0, var_1, var_2, var_3, var_4) {
  self setanimstate(var_0, var_1);
  thread playanimnwithnotetracksfortime_helper(var_0, var_1, var_2, var_4);
  wait(var_3);
  self notify(var_0 + var_1);
}

playanimnwithnotetracksfortime_helper(var_0, var_1, var_2, var_3) {
  self notify(var_0 + var_1);
  self endon(var_0 + var_1);
  var_4 = 0;
  var_5 = self getsafecircleorigin(var_0, var_1);
  var_6 = getanimlength(var_5);
  var_7 = gettime();
  while(!var_4) {
    self waittill(var_2, var_8);
    if(!isarray(var_8)) {
      var_8 = [var_8];
    }

    foreach(var_10 in var_8) {
      if(func_1384A(var_10, "end", var_0, var_1, var_3, var_6, var_7)) {
        var_4 = 1;
      }
    }
  }
}

func_CED1(var_0, var_1, var_2, var_3) {
  self setanimstate(var_0, var_1, var_2);
  wait(var_3);
}

func_7DC9(var_0, var_1, var_2) {
  var_3 = length2d(var_0);
  var_4 = var_0[2];
  var_5 = length2d(var_1);
  var_6 = var_1[2];
  var_7 = 1;
  var_8 = 1;
  if(isDefined(var_2) && var_2) {
    var_9 = (var_1[0], var_1[1], 0);
    var_10 = vectornormalize(var_9);
    if(vectordot(var_10, var_0) < 0) {
      var_7 = 0;
    } else if(var_5 > 0) {
      var_7 = var_3 / var_5;
    }
  } else if(var_5 > 0) {
    var_7 = var_3 / var_5;
  }

  if(abs(var_6) > 0.001 && var_6 * var_4 >= 0) {
    var_8 = var_4 / var_6;
  }

  var_11 = spawnStruct();
  var_11.var_13E2B = var_7;
  var_11.var_3A6 = var_8;
  return var_11;
}

func_5D51(var_0, var_1) {
  var_2 = 15;
  var_3 = 45;
  if(isDefined(self.fgetarg)) {
    var_2 = self.fgetarg;
  }

  if(isDefined(self.height)) {
    var_3 = self.height;
  }

  if(!isDefined(var_1)) {
    var_1 = 18;
  }

  var_4 = var_0 + (0, 0, var_1);
  var_5 = var_0 + (0, 0, var_1 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, self.fgetarg, self.height, 1);
  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_6;
}

func_38D0(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  if(!isDefined(var_3)) {
    var_3 = self.fgetarg;
  }

  var_4 = (0, 0, 1) * var_2;
  var_5 = var_0 + var_4;
  var_6 = var_1 + var_4;
  return self getnumactiveagents(var_5, var_6, var_3, self.height - var_2, 1);
}

getvalidplayersinteam(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return self aiphysicstrace(var_4, var_5, self.fgetarg + 4, self.height - var_2, 1);
}

getsafecircleradius(var_0) {
  var_1 = getmovedelta(var_0);
  var_2 = self gettweakablevalue(var_1);
  var_3 = getvalidplayersinteam(self.origin, var_2);
  var_4 = distance(self.origin, var_3);
  var_5 = distance(self.origin, var_2);
  return min(1, var_4 / var_5);
}

func_EA25(var_0, var_1, var_2, var_3) {
  var_4 = getrandomanimentry(var_0);
  func_EA24(var_0, var_4, var_1, var_2, var_3);
}

func_EA22(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getrandomanimentry(var_0);
  func_EA23(var_0, var_5, var_1, var_2, var_3, var_4);
}

func_EA23(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);
  func_EA24(var_0, var_1, var_3, var_4, var_5);
}

func_EA24(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self getsafecircleorigin(var_0, var_1);
  var_6 = getsafecircleradius(var_5);
  self scragentsetanimscale(var_6, 1);
  func_CED5(var_0, var_1, var_2, var_3, var_4);
  self scragentsetanimscale(1, 1);
}

getrandomanimentry(var_0) {
  var_1 = self getanimentrycount(var_0);
  return randomint(var_1);
}

func_7DBD(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = angleclamp180(var_1[1] - self.angles[1]);
  return getangleindex(var_2);
}

func_F2B1(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self setanimstate(var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1)) {
    self setanimstate(var_0, var_1);
    return;
  }

  self setanimstate(var_0);
}

isstatelocked() {
  if(!isDefined(self.projectileintercept)) {
    return 0;
  }

  return self.projectileintercept;
}

setstatelocked(var_0, var_1) {
  self.projectileintercept = var_0;
}

func_CED6(var_0, var_1, var_2, var_3, var_4) {
  func_CED3(var_0, var_1, 1, var_2, var_3, var_4);
}

func_1384D(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");
  if(isDefined(var_2)) {
    childthread func_C0E0(var_0, var_2, var_1);
  }

  func_1384C(var_0, var_1);
  self notify("Notetrack_Timeout");
}

func_CED3(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");
  self endon("death");
  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_6 = getanimlength(self getsafecircleorigin(var_0, var_1));
    } else {
      var_6 = getanimlength(self getsafecircleorigin(var_1, 0));
    }

    childthread func_C0E0(var_3, var_6 * 1 / var_2, var_4);
  }

  func_CED2(var_0, var_1, var_2, var_3, var_4, var_5);
  self notify("Notetrack_Timeout");
}

func_C0E0(var_0, var_1, var_2) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  var_1 = max(0.05, var_1);
  wait(var_1);
  if(isDefined(var_2)) {
    self notify(var_0, var_2);
    return;
  }

  self notify(var_0, "end");
}

func_5AC1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_4 != "highest_point") {
    func_CED5(var_0, var_1, var_3, var_4, var_7);
  }

  if(var_6) {
    var_8 = self.endnode_pos;
    var_9 = 1;
  } else {
    var_8 = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
    var_9 = var_9.origin;
    var_10 = getnotetracktimes(var_3, "highest_point");
    var_9 = var_10[0];
  }

  func_5AC2(var_0, var_1, var_3, var_2, var_4, var_5, var_8, var_9, var_7);
}

func_5AC2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = abs(self.origin[2] - var_6[2]);
  var_10 = getnotetracktimes(var_3, var_4);
  var_11 = var_10[0];
  var_12 = var_11;
  var_13 = getnotetracktimes(var_3, var_5);
  var_14 = var_13[0];
  var_7 = var_14;
  var_15 = "flex_height_up_top";
  var_10 = getnotetracktimes(var_3, var_15);
  var_11 = "flex_height_down_top";
  var_12 = getnotetracktimes(var_3, var_11);
  var_13 = "flex_height_down_bottom";
  var_14 = getnotetracktimes(var_3, var_13);
  if(var_4 == "flex_height_up_start" && var_10.size > 0) {
    var_7 = var_10[0];
  }

  if(var_4 == "flex_height_down_start") {
    if(var_12.size > 0) {
      var_12 = var_10[0];
    }

    if(var_14.size > 0) {
      var_7 = var_14[0];
    }
  }

  var_15 = getmovedelta(var_3, var_12, var_7);
  var_16 = abs(var_15[2]);
  var_18 = getmovedelta(var_3, var_11, var_14);
  var_19 = abs(var_18[2]);
  if(var_19 < 1) {
    var_1A = 1;
  } else {
    var_1B = var_18 - var_1A;
    if(var_9 <= var_1B) {
      var_1A = var_1B - var_9 / var_19;
    } else {
      var_1A = var_9 - var_1B / var_19;
    }
  }

  self scragentsetanimscale(1, var_1A);
  if(var_11 != 0) {
    var_1C = self getscoreinfocategory(var_3);
    if(var_1C < var_11) {
      func_CED2(var_0, var_1, 1, var_2, var_4, var_8);
    }
  }

  var_1D = clamp(1 / var_1A, 0.33, 3);
  func_CED2(var_0, var_1, var_1D, var_2, var_5, var_8);
}