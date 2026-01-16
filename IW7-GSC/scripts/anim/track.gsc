/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\track.gsc
*********************************************/

func_11B07() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  func_11AF8( % aim_2, % aim_4, % aim_6, % aim_8);
}

func_11AF8(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = 1;
  var_9 = 0;
  var_10 = 0;
  var_11 = 10;
  var_12 = (0, 0, 0);
  if(self.type == "dog") {
    var_13 = 0;
    self.var_FE9E = self.enemy;
  } else {
    var_13 = 1;
    var_14 = 0;
    var_15 = 0;
    if(isDefined(self.var_4716)) {
      var_14 = level.covercrouchleanpitch;
    }

    var_10 = self.script;
    if((var_10 == "cover_left" || var_10 == "cover_right") && isDefined(self.a.var_4667) && self.a.var_4667 == "lean") {
      var_15 = self.covernode.angles[1] - self.angles[1];
    }

    var_12 = (var_14, var_15, 0);
  }

  for(;;) {
    func_93E2();
    var_11 = scripts\anim\shared::func_811C();
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

    var_7 = self getrunningforwarddeathanim(var_11, var_15, var_14, var_12, var_16, opcode::OP_SetNewLocalVariableFieldCached0, var_13);
    opcode::OP_EvalSelfFieldVariable = var_7[0];
    opcode::OP_Return = var_7[1];
    var_7 = undefined;
    if(scripts\engine\utility::actor_is3d()) {
      opcode::OP_CallBuiltin0 = self.angles[2] * -1;
      opcode::OP_CallBuiltin1 = opcode::OP_EvalSelfFieldVariable * cos(opcode::OP_CallBuiltin0) - opcode::OP_Return * sin(opcode::OP_CallBuiltin0);
      opcode::OP_CallBuiltin2 = opcode::OP_EvalSelfFieldVariable * sin(opcode::OP_CallBuiltin0) + opcode::OP_Return * cos(opcode::OP_CallBuiltin0);
      opcode::OP_EvalSelfFieldVariable = opcode::OP_CallBuiltin1;
      opcode::OP_Return = opcode::OP_CallBuiltin2;
      opcode::OP_EvalSelfFieldVariable = clamp(opcode::OP_EvalSelfFieldVariable, self.upaimlimit, self.downaimlimit);
      opcode::OP_Return = clamp(opcode::OP_Return, self.setdevdvar, self.setmatchdatadef);
    }

    if(var_10 > 0) {
      var_10 = var_10 - 1;
      var_11 = max(10, var_11 - 5);
    } else if(self.line && self.line != var_9) {
      var_10 = 2;
      var_11 = 30;
    } else {
      var_11 = 10;
    }

    opcode::OP_CallBuiltin3 = squared(var_11);
    var_9 = self.line;
    opcode::OP_CallBuiltin4 = self.synctransients != "stop" || !var_8;
    if(opcode::OP_CallBuiltin4) {
      opcode::OP_CallBuiltin5 = opcode::OP_Return - var_5;
      if(squared(opcode::OP_CallBuiltin5) > opcode::OP_CallBuiltin3) {
        opcode::OP_Return = var_5 + clamp(opcode::OP_CallBuiltin5, -1 * var_11, var_11);
        opcode::OP_Return = clamp(opcode::OP_Return, self.setdevdvar, self.setmatchdatadef);
      }

      opcode::OP_CallBuiltin = opcode::OP_EvalSelfFieldVariable - var_6;
      if(squared(opcode::OP_CallBuiltin) > opcode::OP_CallBuiltin3) {
        opcode::OP_EvalSelfFieldVariable = var_6 + clamp(opcode::OP_CallBuiltin, -1 * var_11, var_11);
        opcode::OP_EvalSelfFieldVariable = clamp(opcode::OP_EvalSelfFieldVariable, self.upaimlimit, self.downaimlimit);
      }
    }

    var_8 = 0;
    var_5 = opcode::OP_Return;
    var_6 = opcode::OP_EvalSelfFieldVariable;
    func_11AFE(var_0, var_1, var_2, var_3, var_4, opcode::OP_EvalSelfFieldVariable, opcode::OP_Return);
    wait(0.05);
  }
}

func_11AFB(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);
  if(isDefined(self.var_4792)) {
    var_1 = self.var_4792 getshootatpos();
    if(isDefined(self.var_4796)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643) {
      var_1 = undefined;
    }
  }

  if(!isDefined(var_1) && isDefined(self.var_478F)) {
    var_1 = self.var_478F;
    if(isDefined(self.var_4795)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643) {
      var_1 = undefined;
    }
  }

  return var_1;
}

func_11AF9(var_0, var_1) {
  if(scripts\anim\utility_common::recentlysawenemy()) {
    var_2 = self.enemy getshootatpos() - self.enemy.origin;
    var_3 = self lastknownpos(self.enemy) + var_2;
    return func_11AFC(var_3 - var_0, var_1);
  }

  var_4 = 0;
  var_5 = 0;
  if(isDefined(self.node) && isDefined(level.var_9D8E[self.node.type]) && distancesquared(self.origin, self.node.origin) < 16) {
    var_5 = angleclamp180(self.node.angles[1] - self.angles[1]);
  } else {
    var_6 = self getsafeanimmovedeltapercentage();
    if(isDefined(var_6)) {
      var_5 = angleclamp180(var_6[1] - self.angles[1]);
      var_4 = angleclamp180(var_6[0]);
    }
  }

  return (var_4, var_5, 0);
}

func_11AFC(var_0, var_1) {
  var_2 = vectortoangles(var_0);
  var_3 = 0;
  var_4 = 0;
  if(self.getcsplinepointtargetname == "up") {
    var_3 = 40;
  } else if(self.getcsplinepointtargetname == "down") {
    var_3 = -40;
    var_4 = -12;
  }

  var_5 = var_2[0];
  var_5 = angleclamp180(var_5 + var_1[0] + var_3);
  if(isDefined(self.var_10F8C)) {
    var_6 = var_2[1] - self.var_10F8C;
  } else {
    var_7 = angleclamp180(self.desiredangle - self.angles[1]) * 0.5;
    var_6 = var_2[1] - var_7 + self.angles[1];
  }

  var_6 = angleclamp180(var_6 + var_1[1] + var_4);
  return (var_5, var_6, 0);
}

func_11AFA(var_0, var_1, var_2) {
  if(isDefined(self.var_C59B) || isDefined(self.onatv)) {
    if(var_1 > self.setmatchdatadef || var_1 < self.setdevdvar) {
      var_1 = 0;
    }

    if(var_0 > self.downaimlimit || var_0 < self.upaimlimit) {
      var_0 = 0;
    }
  } else if(var_2 && abs(var_1) > level.var_B480 || abs(var_0) > level.var_B47F) {
    var_1 = 0;
    var_0 = 0;
  } else {
    if(self.physicsjitter) {
      var_1 = clamp(var_1, -10, 10);
    } else {
      var_1 = clamp(var_1, self.setdevdvar, self.setmatchdatadef);
    }

    var_0 = clamp(var_0, self.upaimlimit, self.downaimlimit);
  }

  return (var_0, var_1, 0);
}

func_11AFE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  if(var_6 < 0) {
    var_10 = var_6 / self.setdevdvar * self.a.var_1A4B;
    var_9 = 1;
  } else if(var_6 > 0) {
    var_8 = var_6 / self.setmatchdatadef * self.a.var_1A4B;
    var_9 = 1;
  }

  if(var_5 < 0) {
    var_11 = var_5 / self.upaimlimit * self.a.var_1A4B;
    var_9 = 1;
  } else if(var_5 > 0) {
    var_7 = var_5 / self.downaimlimit * self.a.var_1A4B;
    var_9 = 1;
  }

  self func_82AC(var_0, var_7, 0.1, 1, 1);
  self func_82AC(var_1, var_8, 0.1, 1, 1);
  self func_82AC(var_2, var_10, 0.1, 1, 1);
  self func_82AC(var_3, var_11, 0.1, 1, 1);
  if(isDefined(var_4)) {
    self func_82AC(var_4, var_9, 0.1, 1, 1);
  }
}

func_F641(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a.var_1A4B = var_0;
    self.a.var_1A4D = var_0;
    self.a.var_1A4C = var_0;
    self.a.var_1A4F = 0;
  } else {
    if(!isDefined(self.a.var_1A4B)) {
      self.a.var_1A4B = 0;
    }

    self.a.var_1A4D = self.a.var_1A4B;
    self.a.var_1A4C = var_0;
    self.a.var_1A4F = int(var_1 * 20);
  }

  self.a.var_1A4E = 0;
}

func_93E2() {
  if(self.a.var_1A4E < self.a.var_1A4F) {
    self.a.var_1A4E++;
    var_0 = 1 * self.a.var_1A4E / self.a.var_1A4F;
    self.a.var_1A4B = self.a.var_1A4D * 1 - var_0 + self.a.var_1A4C * var_0;
  }
}