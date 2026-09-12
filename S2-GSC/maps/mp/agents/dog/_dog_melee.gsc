/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_melee.gsc
*********************************************/

main() {
  self endon("death");
  self endon("killanimscript");
  self.var_28D2 endon("disconnect");
  var_00 = self.var_28D2.origin - self.origin;
  var_01 = length(var_00);
  var_02 = 1;
  if(var_01 < self.var_11AB) {
    var_03 = self.origin;
    var_02 = 0;
  } else {
    var_01 = var_01 / var_02;
    var_03 = self.var_28D2.origin - var_01 * self.var_11AB;
  }

  var_04 = 0;
  var_05 = self.origin + (0, 0, 30);
  var_06 = self.var_28D2.origin + (0, 0, 30);
  var_07 = physicstrace(var_05, var_06);
  if(distancesquared(var_07, var_06) > 1) {
    func_60E7();
    return;
  }

  if(var_02) {
    var_08 = maps / mp / agents / _scriptedagents::func_1F5B(self.origin, var_03);
  } else {
    var_08 = 1;
  }

  var_09 = undefined;
  if(!var_08) {
    var_0A = 0;
  } else {
    var_0A = func_8B8E(self.var_28D2);
    var_0A = isDefined(var_0A);
  }

  self.var_17E8 = 1;
  func_32AF(var_03, var_08);
}

func_0085() {
  self method_839A(1, 1);
  self.var_17E8 = 0;
}

func_457D() {
  return "attack_run_and_jump";
}

func_8B8E(param_00) {
  if(!self.var_3658) {
    return undefined;
  }

  var_01 = 4;
  if(!maps\mp\_utility::func_56FF(param_00)) {
    return undefined;
  }

  if(func_5797(param_00)) {
    return undefined;
  }

  var_02 = self.origin - param_00.origin;
  if(abs(var_02[2]) > var_01) {
    return undefined;
  }

  var_03 = vectorNormalize((var_02[0], var_02[1], 0));
  var_04 = anglesToForward(param_00.angles);
  var_05 = vectordot(var_04, var_03);
  if(var_05 > 0.707) {
    var_06 = 0;
    var_07 = rotatevector((1, 0, 0), param_00.angles);
  } else if(var_07 < -0.707) {
    var_06 = 1;
    var_07 = rotatevector((-1, 0, 0), var_01.angles);
  } else {
    var_08 = maps / mp / agents / dog / _dog_think::func_285C(var_04, var_06);
    if(var_08 > 0) {
      var_06 = 3;
      var_07 = rotatevector((0, -1, 0), param_00.angles);
    } else {
      var_06 = 2;
      var_07 = rotatevector((0, 1, 0), param_00.angles);
    }
  }

  if(var_06 == 1) {
    var_09 = 128;
  } else {
    var_09 = 96;
  }

  var_0A = param_00.origin - var_09 * var_07;
  var_0B = maps / mp / agents / _scriptedagents::func_34A6(var_0A);
  if(!isDefined(var_0B)) {
    return undefined;
  }

  if(abs(var_0B[2] - var_0A[2]) > var_01) {
    return undefined;
  }

  if(!self method_83EC(param_00.origin + (0, 0, 4), var_0B + (0, 0, 4), self.var_14F, self.height)) {
    return undefined;
  }

  return var_06;
}

func_3156(param_00) {
  var_01 = "attack_extended";
  func_3210(self.var_28D2, self.var_28D2.health, "MOD_MELEE_DOG");
  var_02 = self method_83D8(var_01, param_00);
  thread func_397B(var_02, self.var_28D2.origin, self.var_28D2.angles);
  maps / mp / agents / _scriptedagents::func_71FC(var_01, param_00, "attack", "end");
  self notify("kill_stick");
  self.var_28D2 = undefined;
  self method_839C("anim deltas");
  self unlink();
}

func_397B(param_00, param_01, param_02) {
  self endon("death");
  self endon("killanimscript");
  self endon("kill_stick");
  wait 0.05;
  if(isalive(self.var_28D2)) {
    return;
  }

  var_03 = self.var_28D2 getcorpseentity();
  if(!isDefined(var_03)) {
    return;
  }

  self linkTo(var_03);
  self method_8625(param_00, param_01, param_02);
}

func_32AF(param_00, param_01) {
  var_02 = func_457D();
  var_03 = 0;
  if(!param_01) {
    if(self agentcanseesentient(self.var_28D2)) {
      var_04 = maps / mp / agents / _scriptedagents::func_34A6(self.var_28D2.origin);
      if(isDefined(var_04)) {
        var_03 = 1;
        param_00 = var_04;
      } else {
        func_60E7();
        return;
      }
    } else {
      func_60E7();
      return;
    }
  }

  self.var_5BBE = undefined;
  self.var_5BBF = undefined;
  var_05 = self method_83D8(var_02, 0);
  var_06 = getanimlength(var_05);
  var_07 = getnotetracktimes(var_05, "dog_melee");
  if(var_07.size > 0) {
    var_08 = var_07[0] * var_06;
  } else {
    var_08 = var_07;
  }

  self method_83A4(self.origin, param_00, var_08);
  thread func_A12D(self.var_28D2, var_08, param_01);
  maps / mp / agents / _scriptedagents::func_71FC(var_02, 0, "attack", "dog_melee");
  self notify("cancel_updatelerppos");
  var_09 = 0;
  if(isDefined(self.var_28D2)) {
    var_09 = 50;
  }

  if(isDefined(self.var_60E2)) {
    var_09 = self.var_60E2;
  }

  if(isDefined(self.var_28D2)) {
    func_3210(self.var_28D2, var_09, "MOD_IMPACT");
  }

  self.var_28D2 = undefined;
  if(var_03) {
    self method_839A(0, 1);
  } else {
    self method_839A(1, 1);
  }

  self method_839D("gravity");
  self method_839C("anim deltas");
  maps / mp / agents / _scriptedagents::func_A79E("attack", "end");
}

func_A12D(param_00, param_01, param_02) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  param_00 endon("disconnect");
  param_00 endon("death");
  var_03 = param_01;
  var_04 = 0.05;
  for(;;) {
    wait(var_04);
    var_03 = var_03 - var_04;
    if(var_03 <= 0) {
      break;
    }

    var_05 = func_4707(param_00, param_02);
    if(!isDefined(var_05)) {
      break;
    }

    self method_83A4(self.origin, var_05, var_03);
  }
}

func_4707(param_00, param_01) {
  if(!param_01) {
    var_02 = maps / mp / agents / _scriptedagents::func_34A6(param_00.origin);
    return var_02;
  }

  var_03 = param_01.origin - self.origin;
  var_04 = length(var_03);
  if(var_04 < self.var_11AB) {
    return self.origin;
  }

  var_03 = var_03 / var_04;
  var_05 = param_01.origin - var_03 * self.var_11AB;
  if(maps / mp / agents / _scriptedagents::func_1F5B(self.origin, var_05)) {
    return var_05;
  }

  return undefined;
}

func_5797(param_00) {
  if(param_00 maps\mp\_riotshield::hasriotshieldequipped()) {
    var_01 = self.origin - param_00.origin;
    var_02 = vectorNormalize((var_01[0], var_01[1], 0));
    var_03 = anglesToForward(param_00.angles);
    var_04 = vectordot(var_03, var_01);
    if(param_00 maps\mp\_riotshield::func_4B8D()) {
      if(var_04 > 0.766) {
        return 1;
      }
    } else if(var_04 < -0.766) {
      return 1;
    }
  }

  return 0;
}

func_3210(param_00, param_01, param_02) {
  if(func_5797(param_00)) {
    return;
  }

  param_00 dodamage(param_01, self.origin, self, self, param_02);
}

func_60E7() {
  self.var_5BBE = self.origin;
  self.var_5BBF = self.var_28D2.origin;
}