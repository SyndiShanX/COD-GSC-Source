/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\track.gsc
**********************************/

func_11B07() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  func_11AF8( % aim_2, % aim_4, % aim_6, % aim_8);
}

func_11AF8(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  var_06 = 0;
  var_07 = (0, 0, 0);
  var_08 = 1;
  var_09 = 0;
  var_0A = 0;
  var_0B = 10;
  var_0C = (0, 0, 0);
  if(self.type == "dog") {
    var_0D = 0;
    self.var_FE9E = self.isnodeoccupied;
  } else {
    var_0D = 1;
    var_0E = 0;
    var_0F = 0;
    if(isDefined(self.var_4716)) {
      var_0E = level.covercrouchleanpitch;
    }

    var_10 = self.script;
    if((var_10 == "cover_left" || var_10 == "cover_right") && isDefined(self.a.var_4667) && self.a.var_4667 == "lean") {
      var_0F = self.covernode.angles[1] - self.angles[1];
    }

    var_0C = (var_0E, var_0F, 0);
  }

  for(;;) {
    func_93E2();
    var_11 = scripts\anim\shared::_meth_811C();
    var_12 = self.var_FECF;
    if(isDefined(self.var_FE9E)) {
      var_12 = self.var_FE9E getshootatpos();
    }

    if(!isDefined(var_12) && scripts\anim\utility::func_FFDB()) {
      var_12 = func_11AFB(var_11);
    }

    var_13 = isDefined(self.var_C59B) || isDefined(self.onatv);
    var_14 = isDefined(var_12);
    var_15 = (0, 0, 0);
    if(var_14) {
      var_15 = var_12;
    }

    var_16 = 0;
    opcode::OP_SetNewLocalVariableFieldCached0 = isDefined(self.var_10F8C);
    if(opcode::OP_SetNewLocalVariableFieldCached0) {
      var_16 = self.var_10F8C;
    }

    var_07 = self getrunningforwarddeathanim(var_11, var_15, var_14, var_0C, var_16, opcode::OP_SetNewLocalVariableFieldCached0, var_13);
    opcode::OP_EvalSelfFieldVariable = var_07[0];
    opcode::OP_Return = var_07[1];
    var_07 = undefined;
    if(scripts\engine\utility::actor_is3d()) {
      opcode::OP_CallBuiltin0 = self.angles[2] * -1;
      opcode::OP_CallBuiltin1 = opcode::OP_EvalSelfFieldVariable * cos(opcode::OP_CallBuiltin0) - opcode::OP_Return * sin(opcode::OP_CallBuiltin0);
      opcode::OP_CallBuiltin2 = opcode::OP_EvalSelfFieldVariable * sin(opcode::OP_CallBuiltin0) + opcode::OP_Return * cos(opcode::OP_CallBuiltin0);
      opcode::OP_EvalSelfFieldVariable = opcode::OP_CallBuiltin1;
      opcode::OP_Return = opcode::OP_CallBuiltin2;
      opcode::OP_EvalSelfFieldVariable = clamp(opcode::OP_EvalSelfFieldVariable, self.var_368, self.isbot);
      opcode::OP_Return = clamp(opcode::OP_Return, self.setdevdvar, self.setmatchdatadef);
    }

    if(var_0A > 0) {
      var_0A = var_0A - 1;
      var_0B = max(10, var_0B - 5);
    } else if(self.line && self.line != var_09) {
      var_0A = 2;
      var_0B = 30;
    } else {
      var_0B = 10;
    }

    opcode::OP_CallBuiltin3 = squared(var_0B);
    var_09 = self.line;
    opcode::OP_CallBuiltin4 = self.synctransients != "stop" || !var_08;
    if(opcode::OP_CallBuiltin4) {
      opcode::OP_CallBuiltin5 = opcode::OP_Return - var_05;
      if(squared(opcode::OP_CallBuiltin5) > opcode::OP_CallBuiltin3) {
        opcode::OP_Return = var_05 + clamp(opcode::OP_CallBuiltin5, -1 * var_0B, var_0B);
        opcode::OP_Return = clamp(opcode::OP_Return, self.setdevdvar, self.setmatchdatadef);
      }

      opcode::OP_CallBuiltin = opcode::OP_EvalSelfFieldVariable - var_06;
      if(squared(opcode::OP_CallBuiltin) > opcode::OP_CallBuiltin3) {
        opcode::OP_EvalSelfFieldVariable = var_06 + clamp(opcode::OP_CallBuiltin, -1 * var_0B, var_0B);
        opcode::OP_EvalSelfFieldVariable = clamp(opcode::OP_EvalSelfFieldVariable, self.var_368, self.isbot);
      }
    }

    var_08 = 0;
    var_05 = opcode::OP_Return;
    var_06 = opcode::OP_EvalSelfFieldVariable;
    func_11AFE(param_00, param_01, param_02, param_03, param_04, opcode::OP_EvalSelfFieldVariable, opcode::OP_Return);
    wait(0.05);
  }
}

func_11AFB(param_00) {
  var_01 = undefined;
  var_02 = anglesToForward(self.angles);
  if(isDefined(self.var_4792)) {
    var_01 = self.var_4792 getshootatpos();
    if(isDefined(self.var_4796)) {
      if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.177) {
        var_01 = undefined;
      }
    } else if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.643) {
      var_01 = undefined;
    }
  }

  if(!isDefined(var_01) && isDefined(self.var_478F)) {
    var_01 = self.var_478F;
    if(isDefined(self.var_4795)) {
      if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.177) {
        var_01 = undefined;
      }
    } else if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.643) {
      var_01 = undefined;
    }
  }

  return var_01;
}

func_11AF9(param_00, param_01) {
  if(scripts\anim\utility_common::recentlysawenemy()) {
    var_02 = self.isnodeoccupied getshootatpos() - self.isnodeoccupied.origin;
    var_03 = self lastknownpos(self.isnodeoccupied) + var_02;
    return func_11AFC(var_03 - param_00, param_01);
  }

  var_04 = 0;
  var_05 = 0;
  if(isDefined(self.target_getindexoftarget) && isDefined(level.var_9D8E[self.target_getindexoftarget.type]) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 16) {
    var_05 = angleclamp180(self.target_getindexoftarget.angles[1] - self.angles[1]);
  } else {
    var_06 = self getsafeanimmovedeltapercentage();
    if(isDefined(var_06)) {
      var_05 = angleclamp180(var_06[1] - self.angles[1]);
      var_04 = angleclamp180(var_06[0]);
    }
  }

  return (var_04, var_05, 0);
}

func_11AFC(param_00, param_01) {
  var_02 = vectortoangles(param_00);
  var_03 = 0;
  var_04 = 0;
  if(self.getcsplinepointtargetname == "up") {
    var_03 = 40;
  } else if(self.getcsplinepointtargetname == "down") {
    var_03 = -40;
    var_04 = -12;
  }

  var_05 = var_02[0];
  var_05 = angleclamp180(var_05 + param_01[0] + var_03);
  if(isDefined(self.var_10F8C)) {
    var_06 = var_02[1] - self.var_10F8C;
  } else {
    var_07 = angleclamp180(self.var_EC - self.angles[1]) * 0.5;
    var_06 = var_02[1] - var_07 + self.angles[1];
  }

  var_06 = angleclamp180(var_06 + param_01[1] + var_04);
  return (var_05, var_06, 0);
}

func_11AFA(param_00, param_01, param_02) {
  if(isDefined(self.var_C59B) || isDefined(self.onatv)) {
    if(param_01 > self.setmatchdatadef || param_01 < self.setdevdvar) {
      param_01 = 0;
    }

    if(param_00 > self.isbot || param_00 < self.var_368) {
      param_00 = 0;
    }
  } else if(param_02 && abs(param_01) > level.var_B480 || abs(param_00) > level.var_B47F) {
    param_01 = 0;
    param_00 = 0;
  } else {
    if(self.physicsjitter) {
      param_01 = clamp(param_01, -10, 10);
    } else {
      param_01 = clamp(param_01, self.setdevdvar, self.setmatchdatadef);
    }

    param_00 = clamp(param_00, self.var_368, self.isbot);
  }

  return (param_00, param_01, 0);
}

func_11AFE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  var_0A = 0;
  var_0B = 0;
  if(param_06 < 0) {
    var_0A = param_06 / self.setdevdvar * self.a.var_1A4B;
    var_09 = 1;
  } else if(param_06 > 0) {
    var_08 = param_06 / self.setmatchdatadef * self.a.var_1A4B;
    var_09 = 1;
  }

  if(param_05 < 0) {
    var_0B = param_05 / self.var_368 * self.a.var_1A4B;
    var_09 = 1;
  } else if(param_05 > 0) {
    var_07 = param_05 / self.isbot * self.a.var_1A4B;
    var_09 = 1;
  }

  self _meth_82AC(param_00, var_07, 0.1, 1, 1);
  self _meth_82AC(param_01, var_08, 0.1, 1, 1);
  self _meth_82AC(param_02, var_0A, 0.1, 1, 1);
  self _meth_82AC(param_03, var_0B, 0.1, 1, 1);
  if(isDefined(param_04)) {
    self _meth_82AC(param_04, var_09, 0.1, 1, 1);
  }
}

func_F641(param_00, param_01) {
  if(!isDefined(param_01) || param_01 <= 0) {
    self.a.var_1A4B = param_00;
    self.a.var_1A4D = param_00;
    self.a.var_1A4C = param_00;
    self.a.var_1A4F = 0;
  } else {
    if(!isDefined(self.a.var_1A4B)) {
      self.a.var_1A4B = 0;
    }

    self.a.var_1A4D = self.a.var_1A4B;
    self.a.var_1A4C = param_00;
    self.a.var_1A4F = int(param_01 * 20);
  }

  self.a.var_1A4E = 0;
}

func_93E2() {
  if(self.a.var_1A4E < self.a.var_1A4F) {
    self.a.var_1A4E++;
    var_00 = 1 * self.a.var_1A4E / self.a.var_1A4F;
    self.a.var_1A4B = self.a.var_1A4D * 1 - var_00 + self.a.var_1A4C * var_00;
  }
}