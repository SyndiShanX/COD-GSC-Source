/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3186.gsc
************************/

func_566E() {}

func_F6C8(param_00, param_01) {
  if(!isDefined(self.var_566C)) {
    self.var_566C = spawnStruct();
  }

  self.var_566C.var_2C19 = param_00;
  self.var_566C.var_8EE5 = param_01;
  scripts\asm\asm::asm_setstate("dismember");
}

func_41A7() {
  if(isDefined(self.var_566C)) {
    self.var_566C.var_2C19 = undefined;
    self.var_566C.var_8EE5 = undefined;
    self.var_566C = undefined;
  }
}

func_54B9() {
  if(self.var_566C.var_2C19 == 1) {
    return 1;
  }

  return 0;
}

func_54B7() {
  if(self.var_566C.var_2C19 == 2) {
    return 1;
  }

  return 0;
}

func_54BA() {
  if(self.var_566C.var_2C19 == 4) {
    return 1;
  }

  return 0;
}

func_54B8() {
  if(self.var_566C.var_2C19 == 8) {
    return 1;
  }

  return 0;
}

func_54B6() {
  if(self.var_566C.var_2C19 == 12) {
    return 1;
  }

  return 0;
}

func_8C0D() {
  if(!isDefined(self.var_566C)) {
    return 0;
  }

  return 1;
}

func_9E2E() {
  return self.var_566C.var_8EE5;
}

func_9EDD(param_00) {
  if(!scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  return scripts\asm\asm_bb::bb_movetyperequested(param_00);
}

func_CF1B(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  func_5815(param_01, var_04);
  func_41A7();
}

func_5815(param_00, param_01) {
  self endon(param_00 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::func_CED3(param_00, param_01, self.var_C081, "end");
}

func_9EA5() {
  if(!isDefined(self.var_B8BA)) {
    return 0;
  }

  var_00 = self.var_B8BA & 1;
  return var_00 != 0;
}

func_9EA4() {
  if(!isDefined(self.var_B8BA)) {
    return 0;
  }

  var_00 = self.var_B8BA & 2;
  return var_00 != 0;
}