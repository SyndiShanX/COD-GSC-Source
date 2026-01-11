/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 10.gsc
***************************************/

func_197F(var_00, var_01) {
  self.behaviortreeasset = var_00;
  scripts\aitypes\bt_util::bt_init();
  scripts\asm\asm_mp::func_234D(var_01);
  thread func_19F7();
}

registernotetracks() {
  anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
}

notetrackfootstep(var_00, var_01) {
  var_02 = issubstr(var_00, "left");
  var_03 = issubstr(var_00, "large");
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

func_89A9(var_00, var_01, var_02) {
  if(isDefined(anim.notetracks[var_00])) {
    return [[anim.notetracks[var_00]]](var_00, var_01);
  }

  return undefined;
}

func_0219(var_00, var_01) {
  if(isDefined(self.onenteranimstate)) {
    self[[self.onenteranimstate]](var_00, var_01);
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
    scripts\aitypes\bt_util::bt_tick();
    scripts\asm\asm::func_2314();

    if(isDefined(self.asm.func_10E23)) {
      scripts\asm\asm::asm_clearevents(self.asm.func_10E23);
      self.asm.func_10E23 = undefined;
    }

    scripts\asm\asm::func_2389();
    wait 0.05;
  }
}

func_CED9(var_00, var_01, var_02, var_03) {
  func_CED5(var_00, 0, var_01, var_02, var_03);
}

func_CED5(var_00, var_01, var_02, var_03, var_04) {
  self setanimstate(var_00, var_01);

  if(!isDefined(var_03)) {
    var_03 = "end";
  }

  func_1384C(var_02, var_03, var_00, var_01, var_04);
}

func_CED2(var_00, var_01, var_02, var_03, var_04, var_05) {
  self setanimstate(var_00, var_01, var_02);

  if(!isDefined(var_04)) {
    var_04 = "end";
  }

  func_1384C(var_03, var_04, var_00, var_01, var_05);
}

func_1384A(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = undefined;

  if(isDefined(var_05)) {
    var_07 = (gettime() - var_06) * 0.001 / var_05;
  }

  func_89A9(var_00, var_02, var_04);

  if(isDefined(var_02) && isDefined(self.asm)) {
    scripts\asm\asm_mp::func_2345(var_00, var_02, var_03, var_07);
  }

  if(!isDefined(var_05) || var_07 > 0) {
    if(var_00 == var_01 || var_00 == "end" || var_00 == "anim_will_finish" || var_00 == "finish") {
      return 1;
    }
  }

  if(isDefined(var_04)) {
    [[var_04]](var_00, var_02, var_03, var_07);
  }

  return 0;
}

func_1384C(var_00, var_01, var_02, var_03, var_04) {
  var_05 = gettime();
  var_06 = undefined;

  if(isDefined(var_02) && isDefined(var_03)) {
    var_06 = getanimlength(self getanimentry(var_02, var_03));
  }

  var_07 = 0;

  while(!var_07) {
    self waittill(var_00, var_08);

    if(isarray(var_08)) {
      foreach(var_10 in var_08) {
        if(func_1384A(var_10, var_01, var_02, var_03, var_04, var_06, var_05)) {
          var_07 = 1;
        }
      }

      continue;
    }

    var_07 = func_1384A(var_08, var_01, var_02, var_03, var_04, var_06, var_05);
  }
}

func_CED0(var_00, var_01) {
  func_CED4(var_00, 0, var_01);
}

func_CED4(var_00, var_01, var_02) {
  self setanimstate(var_00, var_01);
  wait(var_02);
}

playanimnwithnotetracksfortime(var_00, var_01, var_02, var_03, var_04) {
  self setanimstate(var_00, var_01);
  thread playanimnwithnotetracksfortime_helper(var_00, var_01, var_02, var_04);
  wait(var_03);
  self notify(var_00 + var_01);
}

playanimnwithnotetracksfortime_helper(var_00, var_01, var_02, var_03) {
  self notify(var_00 + var_01);
  self endon(var_00 + var_01);
  var_04 = 0;
  var_05 = self getanimentry(var_00, var_01);
  var_06 = getanimlength(var_05);
  var_07 = gettime();

  while(!var_04) {
    self waittill(var_02, var_08);

    if(!isarray(var_08)) {
      var_08 = [var_08];
    }

    foreach(var_10 in var_08) {
      if(func_1384A(var_10, "end", var_00, var_01, var_03, var_06, var_07)) {
        var_04 = 1;
      }
    }
  }
}

func_CED1(var_00, var_01, var_02, var_03) {
  self setanimstate(var_00, var_01, var_02);
  wait(var_03);
}

func_7DC9(var_00, var_01, var_02) {
  var_03 = length2d(var_00);
  var_04 = var_0[2];
  var_05 = length2d(var_01);
  var_06 = var_1[2];
  var_07 = 1;
  var_08 = 1;

  if(isDefined(var_02) && var_02) {
    var_09 = (var_1[0], var_1[1], 0);
    var_10 = vectornormalize(var_09);

    if(vectordot(var_10, var_00) < 0) {
      var_07 = 0;
    }
    else if(var_05 > 0) {
      var_07 = var_03 / var_05;
    }
  } else if(var_05 > 0)
    var_07 = var_03 / var_05;

  if(abs(var_06) > 0.001 && var_06 * var_04 >= 0) {
    var_08 = var_04 / var_06;
  }

  var_11 = spawnStruct();
  var_11.func_13E2B = var_07;
  var_11.z = var_08;
  return var_11;
}

func_5D51(var_00, var_01) {
  var_02 = 15;
  var_03 = 45;

  if(isDefined(self.radius)) {
    var_02 = self.radius;
  }

  if(isDefined(self.height)) {
    var_03 = self.height;
  }

  if(!isDefined(var_01)) {
    var_01 = 18;
  }

  var_04 = var_00 + (0, 0, var_01);
  var_05 = var_00 + (0, 0, var_01 * -1);
  var_06 = self aiphysicstrace(var_04, var_05, self.radius, self.height, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_06;
}

func_38D0(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02)) {
    var_02 = 6;
  }

  if(!isDefined(var_03)) {
    var_03 = self.radius;
  }

  var_04 = (0, 0, 1) * var_02;
  var_05 = var_00 + var_04;
  var_06 = var_01 + var_04;
  return self aiphysicstracepassed(var_05, var_06, var_03, self.height - var_02, 1);
}

getvalidplayersinteam(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 6;
  }

  var_03 = (0, 0, 1) * var_02;
  var_04 = var_00 + var_03;
  var_05 = var_01 + var_03;
  return self aiphysicstrace(var_04, var_05, self.radius + 4, self.height - var_02, 1);
}

getsafecircleradius(var_00) {
  var_01 = getmovedelta(var_00);
  var_02 = self localtoworldcoords(var_01);
  var_03 = getvalidplayersinteam(self.origin, var_02);
  var_04 = distance(self.origin, var_03);
  var_05 = distance(self.origin, var_02);
  return min(1.0, var_04 / var_05);
}

func_EA25(var_00, var_01, var_02, var_03) {
  var_04 = getrandomanimentry(var_00);
  func_EA24(var_00, var_04, var_01, var_02, var_03);
}

func_EA22(var_00, var_01, var_02, var_03, var_04) {
  var_05 = getrandomanimentry(var_00);
  func_EA23(var_00, var_05, var_01, var_02, var_03, var_04);
}

func_EA23(var_00, var_01, var_02, var_03, var_04, var_05) {
  self setanimstate(var_00, var_01, var_02);
  func_EA24(var_00, var_01, var_03, var_04, var_05);
}

func_EA24(var_00, var_01, var_02, var_03, var_04) {
  var_05 = self getanimentry(var_00, var_01);
  var_06 = getsafecircleradius(var_05);
  self scragentsetanimscale(var_06, 1.0);
  func_CED5(var_00, var_01, var_02, var_03, var_04);
  self scragentsetanimscale(1.0, 1.0);
}

getrandomanimentry(var_00) {
  var_01 = self getanimentrycount(var_00);
  return randomint(var_01);
}

func_7DBD(var_00) {
  var_01 = vectortoangles(var_00);
  var_02 = angleclamp180(var_1[1] - self.angles[1]);
  return getangleindex(var_02);
}

func_F2B1(var_00, var_01, var_02) {
  if(isDefined(var_02)) {
    self setanimstate(var_00, var_01, var_02);
  }
  else if(isDefined(var_01)) {
    self setanimstate(var_00, var_01);
  }
  else {
    self setanimstate(var_00);
  }
}

isstatelocked() {
  if(!isDefined(self.statelocked)) {
    return 0;
  }

  return self.statelocked;
}

setstatelocked(var_00, var_01) {
  self.statelocked = var_00;
}

func_CED6(var_00, var_01, var_02, var_03, var_04) {
  func_CED3(var_00, var_01, 1.0, var_02, var_03, var_04);
}

func_1384D(var_00, var_01, var_02) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_02)) {
    childthread func_C0E0(var_00, var_02, var_01);
  }

  func_1384C(var_00, var_01);
  self notify("Notetrack_Timeout");
}

func_CED3(var_00, var_01, var_02, var_03, var_04, var_05) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_00)) {
    if(isDefined(var_01)) {
      var_06 = getanimlength(self getanimentry(var_00, var_01));
    }
    else {
      var_06 = getanimlength(self getanimentry(var_00, 0));
    }

    childthread func_C0E0(var_03, var_06 * (1.0 / var_02), var_04);
  }

  func_CED2(var_00, var_01, var_02, var_03, var_04, var_05);
  self notify("Notetrack_Timeout");
}

func_C0E0(var_00, var_01, var_02) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  var_01 = max(0.05, var_01);
  wait(var_01);

  if(isDefined(var_02)) {
    self notify(var_00, var_02);
  }
  else {
    self notify(var_00, "end");
  }
}

func_5AC1(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(var_04 != "highest_point") {
    func_CED5(var_00, var_01, var_03, var_04, var_07);
  }

  if(var_06) {
    var_08 = self.endnode_pos;
    var_09 = 1;
  } else {
    var_08 = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
    var_08 = var_8.origin;
    var_10 = getnotetracktimes(var_02, "highest_point");
    var_09 = var_10[0];
  }

  func_5AC2(var_00, var_01, var_03, var_02, var_04, var_05, var_08, var_09, var_07);
}

func_5AC2(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = abs(self.origin[2] - var_6[2]);
  var_10 = getnotetracktimes(var_03, var_04);
  var_11 = var_10[0];
  var_12 = var_11;
  var_13 = getnotetracktimes(var_03, var_05);
  var_14 = var_13[0];
  var_07 = var_14;
  var_15 = "flex_height_up_top";
  var_16 = getnotetracktimes(var_03, var_15);
  var_17 = "flex_height_down_top";
  var_18 = getnotetracktimes(var_03, var_17);
  var_19 = "flex_height_down_bottom";
  var_20 = getnotetracktimes(var_03, var_19);

  if(var_04 == "flex_height_up_start" && var_16.size > 0) {
    var_07 = var_16[0];
  }

  if(var_04 == "flex_height_down_start") {
    if(var_18.size > 0) {
      var_12 = var_16[0];
    }

    if(var_20.size > 0) {
      var_07 = var_20[0];
    }
  }

  var_21 = getmovedelta(var_03, var_12, var_07);
  var_22 = abs(var_21[2]);
  var_24 = getmovedelta(var_03, var_11, var_14);
  var_25 = abs(var_24[2]);

  if(var_25 < 1) {
    var_26 = 1;
  }
  else {
    var_27 = var_22 - var_25;

    if(var_09 <= var_27) {
      var_26 = (var_27 - var_09) / var_25;
    }
    else {
      var_26 = (var_09 - var_27) / var_25;
    }
  }

  self scragentsetanimscale(1.0, var_26);

  if(var_11 != 0) {
    var_28 = self islegacyagent(var_03);

    if(var_28 < var_11) {
      func_CED2(var_00, var_01, 1.0, var_02, var_04, var_08);
    }
  }

  var_29 = clamp(1 / var_26, 0.33, 3.0);
  func_CED2(var_00, var_01, var_29, var_02, var_05, var_08);
}