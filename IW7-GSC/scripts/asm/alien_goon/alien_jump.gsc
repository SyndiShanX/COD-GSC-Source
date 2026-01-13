/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\alien_goon\alien_jump.gsc
*************************************************/

setjumpattackanimstates(var_0, var_1) {
  var_1.var_A7C6 = "attack_leap_swipe";
  var_1.var_A7C4 = scripts\mp\agents\_scriptedagents::getrandomanimentry("attack_leap_swipe");
}

choosejumpattackarrival(var_0, var_1) {
  var_2 = 0.707;
  if(isDefined(self.curmeleetarget) && isalive(self.curmeleetarget)) {
    var_3 = vectornormalize(self.curmeleetarget.origin - var_0.var_A843);
    var_4 = anglesToForward(var_0.var_630B);
    var_5 = vectordot(var_3, var_4);
    if(var_5 > var_2) {
      return;
    }

    var_6 = anglestoright(var_0.var_630B);
    var_7 = vectordot(var_3, var_6);
    if(var_7 > var_2) {
      var_1.var_A7C6 = "attack_leap_swipe_right";
      var_1.var_A7C4 = scripts\mp\agents\_scriptedagents::getrandomanimentry("attack_leap_swipe_right");
      return;
    }

    if(var_7 < var_2 * -1) {
      var_1.var_A7C6 = "attack_leap_swipe_left";
      var_1.var_A7C4 = scripts\mp\agents\_scriptedagents::getrandomanimentry("attack_leap_swipe_left");
      return;
    }
  }
}

jumpattack(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.var_71CD = ::setjumpattackanimstates;
  var_3.var_71BB = ::choosejumpattackarrival;
  self.var_B59D = 1;
  func_A4C3(var_0, var_1, self.origin, self.angles, var_2, self.curmeleetarget.angles, undefined, var_3);
  self.var_B59D = 0;
}

func_A4C3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self ghosthover();
  func_A4E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  func_A4DA(var_9, var_5);
}

func_A4DA(var_0, var_1) {
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
  } else {
    self scragentsetanimscale(1, 1);
  }

  self ghostskullstimestart(var_0);
  self gib_fx_override("gravity");
  self.trajectorycanattemptaccuratejump = 0;
  self.ignoreme = 0;
}

func_A4E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  self.var_11B2F = 0;
  var_9 = spawnStruct();
  var_0A = func_7F2B(var_2, var_3, var_4, var_5, var_6);
  func_7F28(var_0A, var_9);
  if(isDefined(var_7) && isDefined(var_7.var_71CD)) {
    self[[var_7.var_71CD]](var_0A, var_9);
  }

  var_0B = func_7F2F(var_2, var_3, var_4);
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_0B);
  var_0C = 0;
  var_0D = self getsafecircleorigin(var_9.var_AAA5, var_9.var_AAA4);
  var_0E = self getsafecircleorigin(var_9.var_A7C6, var_9.var_A7C4);
  var_0F = getnotetracktimes(var_0E, "finish");
  if(var_0F.size > 0) {
    var_10 = var_0F[0] * getanimlength(var_0E);
  } else {
    var_10 = getanimlength(var_0F);
  }

  var_11 = var_10 / var_9.var_CEE4;
  var_12 = floor(var_11 * 20);
  var_13 = var_12 / 20 / var_11;
  var_14 = getnotetracktimes(var_0E, "stop_teleport");
  if(var_14.size > 0) {
    var_15 = var_14[0] * var_11;
    var_16 = ceil(var_15 * 20);
    opcode::OP_SetNewLocalVariableFieldCached0 = var_16 / 20 / var_11;
    opcode::OP_EvalSelfFieldVariable = getmovedelta(var_0E, opcode::OP_SetNewLocalVariableFieldCached0, var_13);
  } else {
    var_15 = 0.8 * var_15;
    var_16 = ceil(opcode::OP_EvalSelfFieldVariable * 20);
    opcode::OP_SetNewLocalVariableFieldCached0 = opcode::OP_EvalSelfFieldVariable / 20 / var_13;
    opcode::OP_EvalSelfFieldVariable = getmovedelta(var_0F, opcode::OP_EvalSelfFieldVariable, var_14);
  }

  var_5 = func_7F29(var_2, var_4, var_5);
  opcode::OP_Return = rotatevector(opcode::OP_EvalSelfFieldVariable, var_5);
  opcode::OP_CallBuiltin0 = var_4 - opcode::OP_Return;
  self ghostlaunched("anim deltas");
  self playsoundonmovingent(func_7A62());
  if(animhasnotetrack(var_0D, "start_teleport")) {
    scripts\mp\agents\_scriptedagents::func_CED2(var_9.var_AAA5, var_9.var_AAA4, var_9.var_CEE4, "jump_launch", "start_teleport");
  } else {
    scripts\mp\agents\_scriptedagents::func_CED1(var_9.var_AAA5, var_9.var_AAA4, var_9.var_CE9E, 0.5 * getanimlength(var_0D) / var_9.var_CEE4);
  }

  opcode::OP_CallBuiltin1 = gettime();
  var_0C = self ghostexplosionradiusdamage(self.origin, opcode::OP_CallBuiltin0, var_0A.var_A4EB);
  self.var_11B2F = 1;
  self notify("jump_launching");
  opcode::OP_CallBuiltin2 = self ghosthover();
  thread func_A4E9(var_0A, var_5, opcode::OP_CallBuiltin2, var_0C);
  scripts\mp\agents\_scriptedagents::func_1384C("jump_launch", "end");
  opcode::OP_CallBuiltin3 = gettime() - opcode::OP_CallBuiltin1 / 1000;
  if(scripts\engine\utility::istrue(self.bteleporting)) {
    if(level.totalphantomsjumping < level.totalphantomsallowedtojump) {
      level.totalphantomsjumping++;
      thread play_teleport_start();
      self.bteleporting = 0;
    } else {
      self.bteleporting = 0;
    }
  }

  opcode::OP_CallBuiltin4 = var_0C - opcode::OP_CallBuiltin3 - var_15;
  if(opcode::OP_CallBuiltin4 > 0) {
    scripts\mp\agents\_scriptedagents::func_CED1(var_9.var_93B3, var_9.var_93B2, var_9.var_CEE4, opcode::OP_CallBuiltin4);
  }

  if(isDefined(var_7) && isDefined(var_7.var_71BB)) {
    self[[var_7.var_71BB]](var_0A, var_9);
  }

  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self setanimstate(var_9.var_A7C6, var_9.var_A7C4, 0.2);
  } else {
    self setanimstate(var_9.var_A7C6, var_9.var_A7C4, var_9.var_CEE4);
  }

  opcode::OP_CallBuiltin5 = scripts\asm\asm::func_2341(var_0, var_1);
  thread handlejumpnotetracks("jump_land", "end", var_9.var_A7C6, var_9.var_A7C4, opcode::OP_CallBuiltin5);
  self waittill("traverse_complete");
  self.var_11B2F = 0;
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
  } else {
    self scragentsetanimscale(1, 0);
  }

  self ghostskullstimestart(20.28318);
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", var_5);
  scripts\mp\agents\_scriptedagents::func_1384C("jump_land", "end");
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
  } else {
    self scragentsetanimscale(1, 1);
  }

  self setorigin(var_4, 0);
}

play_teleport_start() {
  self setscriptablepartstate("teleport_fx", "teleport_start");
  scripts\engine\utility::waitframe();
  self setethereal(1);
}

handlejumpnotetracks(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_2 + "_finished");
  scripts\mp\agents\_scriptedagents::func_1384C(var_0, var_1, var_2, var_3, var_4);
}

func_A4E9(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = (0, 0, 1);
  var_5 = 0.85;
  var_6 = scripts\cp\utility::is_normal_upright(var_0.var_10E05);
  var_7 = scripts\cp\utility::is_normal_upright(var_0.var_6397);
  if(var_6 && !var_7) {
    var_8 = 0.5;
    var_9 = 1;
  } else if(!var_8 && var_9) {
    var_8 = 0;
    var_9 = 0.5;
  } else {
    var_8 = 0;
    var_9 = 1;
  }

  var_0A = var_9 - var_8;
  if(var_8 > 0) {
    wait(var_3 * var_8);
  }

  var_0B = 1;
  if(distancesquared(self.angles, var_1) > var_0B) {
    var_0C = anglesdelta(self.angles, var_1);
    var_0D = var_0C / var_3 * var_0A;
    var_0D = var_0D * 3.141593 / 180;
    var_0D = var_0D / 20;
    self ghostskullstimestart(var_0D);
  }

  self orientmode("face angle abs", var_1);
}

func_7F2B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_6 = var_2 - var_0;
  var_7 = var_6 * (1, 1, 0);
  var_7 = vectornormalize(var_7);
  var_5.var_AAB4 = var_0 + var_7 * level.var_1BBA.var_A4E6;
  var_5.var_A843 = var_2;
  var_5.var_A4F8 = var_5.var_A843 - var_5.var_AAB4;
  var_5.var_A4F7 = var_5.var_A4F8 * (1, 1, 0);
  var_5.var_A4DC = length(var_5.var_A4F7);
  var_5.var_A4DB = var_5.var_A4F7 / var_5.var_A4DC;
  if(isDefined(var_4)) {
    var_5.var_A844 = var_4 - var_2;
  } else if(isDefined(self.curmeleetarget)) {
    var_5.var_A844 = self.curmeleetarget.origin - var_2;
  } else {
    var_5.var_A844 = anglesToForward(self.angles);
  }

  var_5.var_10D6D = func_7F27(var_5.var_A4F8, anglestoup(var_1));
  var_5.var_630B = func_7F27(var_5.var_A4F8, anglestoup(var_3));
  var_5.var_10E05 = anglestoup(var_5.var_10D6D);
  var_5.var_6397 = anglestoup(var_5.var_630B);
  func_7F30(var_5);
  return var_5;
}

func_DA68(var_0, var_1) {
  var_2 = vectordot(var_0, var_1);
  var_3 = var_0 - var_1 * var_2;
  return var_3;
}

func_7F27(var_0, var_1) {
  var_2 = func_DA68(var_0, var_1);
  var_3 = vectorcross(var_2, var_1);
  var_4 = axistoangles(var_2, var_3, var_1);
  return var_4;
}

func_7F30(var_0) {
  var_1 = var_0.var_A4DC;
  var_2 = var_0.var_A4F8[2];
  var_3 = !scripts\cp\utility::is_normal_upright(var_0.var_6397);
  var_4 = func_7F2A(var_3);
  var_5 = 1.01;
  var_6 = trajectorycalculateminimumvelocity(var_0.var_AAB4, var_0.var_A843, var_4);
  var_7 = func_7F2E(var_3);
  var_8 = var_6 * var_5 * var_7;
  var_9 = trajectorycalculateexitangle(var_8, var_4, var_1, var_2);
  var_0A = cos(var_9);
  var_0.var_A4ED = var_0.var_A4DC / var_8 * var_0A;
  var_0B = var_4 * (0, 0, -1);
  var_0.launchvelocity2d = trajectorycalculateinitialvelocity(var_0.var_AAB4, var_0.var_A843, var_0B, var_0.var_A4ED);
  var_0.launchvelocity = var_0.launchvelocity2d * (1, 1, 0);
  var_0.var_A4EB = length(var_0.launchvelocity);
}

func_7F2E(var_0) {
  if(isDefined(self.var_B59D) && self.var_B59D) {
    return level.var_1B74;
  }

  if(var_0) {
    return getdvarfloat("agent_jumpWallSpeed");
  }

  return getdvarfloat("agent_jumpSpeed");
}

func_7F2A(var_0) {
  if(isDefined(self.var_B59D) && self.var_B59D) {
    return level.var_1B73;
  }

  if(var_0) {
    return getdvarfloat("agent_jumpWallGravity");
  }

  return getdvarfloat("agent_jumpGravity");
}

func_7F2D(var_0, var_1) {
  var_2 = self getsafecircleorigin(var_1.var_AAA5, var_1.var_AAA4);
  var_3 = self getsafecircleorigin(var_1.var_93B3, var_1.var_93B2);
  var_4 = self getsafecircleorigin(var_1.var_A7C6, var_1.var_A7C4);
  var_5 = getanimlength(var_2);
  var_6 = var_5 * 0.5;
  var_7 = getnotetracktimes(var_2, "start_teleport");
  if(isDefined(var_7) && var_7.size > 0) {
    var_6 = var_5 - var_7[0] * var_5;
  }

  var_8 = getanimlength(var_4);
  var_9 = var_8 * 0.5;
  var_0A = getnotetracktimes(var_4, "stop_teleport");
  if(isDefined(var_0A) && var_0A.size > 0) {
    var_9 = var_0A[0] * var_8;
  }

  var_0B = getanimlength(var_3);
  var_0C = ceil(var_0.var_A4ED * 20);
  var_0D = var_0C / 20;
  var_0E = var_0B + var_6 + var_9;
  var_0F = var_0E / var_0D;
  var_10 = var_0B / var_0F + 0.1;
  var_11 = var_0B / var_10;
  return var_11;
}

func_7F28(var_0, var_1) {
  var_1.var_AAA5 = func_7F64(var_0);
  var_1.var_AAA4 = func_7F63(var_0, var_1.var_AAA5);
  var_1.var_A7C6 = getlaserstartpoint(var_0);
  var_1.var_A7C4 = getlaserdirection(var_0, var_1.var_A7C6);
  var_1.var_93B3 = func_7F17(var_0, var_1.var_AAA5, var_1.var_A7C6);
  var_1.var_93B2 = func_7F16(var_0, var_1.var_AAA5, var_1.var_A7C6);
  var_1.var_CEE4 = func_7F2D(var_0, var_1);
}

func_7F2F(var_0, var_1, var_2) {
  var_3 = anglestoup(var_1);
  var_4 = vectornormalize(var_2 - var_0);
  if(vectordot(var_3, var_4) > 0.98) {
    var_4 = (0, 0, 1);
  }

  var_5 = vectorcross(var_3, var_4);
  var_4 = vectorcross(var_5, var_3);
  return axistoangles(var_4, -1 * var_5, var_3);
}

func_7F64(var_0) {
  var_1 = 20;
  var_2 = cos(90 - var_1);
  var_3 = vectornormalize(var_0.var_A4F8);
  var_4 = vectordot(var_3, var_0.var_10E05);
  if(abs(var_4) <= var_2) {
    return "jump_launch_level";
  }

  if(var_4 > 0) {
    return "jump_launch_up";
  }

  if(var_4 < 0) {
    return "jump_launch_down";
  }
}

func_7F63(var_0, var_1) {
  var_2 = vectornormalize(var_0.launchvelocity2d);
  var_2 = rotatevector(var_2, var_0.var_10D6D);
  var_3 = self getanimentrycount(var_1);
  var_4 = 0;
  var_5 = vectordot(level.var_1BBA.var_A4E5[var_1][var_4], var_2);
  for(var_6 = 1; var_6 < var_3; var_6++) {
    var_7 = vectordot(level.var_1BBA.var_A4E5[var_1][var_6], var_2);
    if(var_7 > var_5) {
      var_4 = var_6;
      var_5 = var_7;
    }
  }

  return var_4;
}

func_7F17(var_0, var_1, var_2) {
  return "jump_in_air";
}

func_7F16(var_0, var_1, var_2) {
  return level.var_1BBA.var_93B2[var_1][var_2];
}

func_7F29(var_0, var_1, var_2) {
  var_3 = anglestoup(var_2);
  var_4 = vectornormalize(var_1 - var_0);
  if(vectordot(var_3, var_4) > 0.98) {
    var_4 = (0, 0, 1);
  }

  var_5 = vectorcross(var_3, var_4);
  var_4 = vectorcross(var_5, var_3);
  return axistoangles(var_4, -1 * var_5, var_3);
}

getlaserstartpoint(var_0) {
  var_1 = length(var_0.var_A4F8);
  var_2 = 0.342;
  if(!scripts\cp\utility::is_normal_upright(var_0.var_6397)) {
    var_3 = (0, 0, 1);
    var_4 = vectordot(var_0.var_A4F8, var_3) / var_1;
    if(var_4 > var_2) {
      return "jump_land_sidewall_low";
    } else {
      return "jump_land_sidewall_high";
    }
  }

  var_4 = vectordot(var_0.var_A4F8, var_0.var_6397) / var_1;
  if(var_4 > var_2) {
    return "jump_land_down";
  }

  if(var_4 < var_2 * -1) {
    return "jump_land_up";
  }

  return "jump_land_level";
}

getlaserdirection(var_0, var_1) {
  var_2 = func_DA68(var_0.var_A4F8, var_0.var_6397);
  var_3 = func_DA68(var_0.var_A844, var_0.var_6397);
  var_4 = var_2 - var_3;
  var_5 = vectorcross(var_3, var_0.var_6397);
  var_6 = vectornormalize(func_DA68(var_5, var_0.var_6397)) * 100;
  var_7 = vectordot(var_2 * -1, var_6);
  var_8 = length(var_2);
  var_9 = length(var_3);
  var_0A = length(var_4);
  var_0B = 0.001;
  if(var_8 < var_0B || var_9 < var_0B) {
    return 1;
  }

  var_0C = var_8 * var_8 + var_9 * var_9 - var_0A * var_0A / 2 * var_8 * var_9;
  if(var_0C <= -1) {
    return 6;
  }

  if(var_0C >= 1) {
    return 1;
  }

  var_0D = acos(var_0C);
  if(var_7 > 0) {
    if(0 <= var_0D && var_0D < 22.5) {
      return 1;
    }

    if(22.5 <= var_0D && var_0D < 67.5) {
      return 2;
    }

    if(67.5 <= var_0D && var_0D < 112.5) {
      return 4;
    }

    if(112.5 <= var_0D && var_0D < 157.5) {
      return 7;
    }

    return 6;
  }

  if(0 <= var_0D && var_0D < 22.5) {
    return 1;
  }

  if(22.5 <= var_0D && var_0D < 67.5) {
    return 0;
  }

  if(67.5 <= var_0D && var_0D < 112.5) {
    return 3;
  }

  if(112.5 <= var_0D && var_0D < 157.5) {
    return 5;
  }

  return 6;
}

func_A4EA(var_0, var_1) {}

func_D4A2(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("killanimscript");
  self endon("jump_finished");
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self setanimstate(var_0, var_1, 0.2);
  } else {
    self setanimstate(var_0, var_1, 1);
  }

  var_4 = scripts\engine\utility::waittill_any_return("jump_pain", "traverse_complete");
  if(var_4 == "traverse_complete") {
    return;
  }

  var_5 = var_2 - gettime() * 0.001;
  if(var_5 > 0) {
    var_6 = 2;
    var_7 = func_7F2C(var_3);
    var_8 = self getsafecircleorigin(var_7, var_1);
    var_9 = getanimlength(var_8);
    var_0A = min(var_6, var_9 / var_5);
    if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
      self setanimstate(var_7, var_1, 0.2);
    } else {
      self setanimstate(var_7, var_1, var_0A);
    }
  }

  self waittill("traverse_complete");
}

func_7F2C(var_0) {
  return "jump_pain_idle_" + var_0;
}

func_7F11(var_0) {
  return "jump_impact_pain_" + var_0;
}

func_7A62() {
  return "alien_jump";
}