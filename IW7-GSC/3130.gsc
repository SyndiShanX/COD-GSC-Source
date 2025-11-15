/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3130.gsc
************************/

func_D55D(param_00, param_01, param_02, param_03) {}

func_D566(param_00, param_01, param_02, param_03) {
  func_D564(param_00, param_01, param_02);
}

func_D560(param_00, param_01, param_02, param_03) {
  func_D563(param_00, param_01, param_02, param_03);
}

func_D55E(param_00, param_01, param_02, param_03) {}

func_D563(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_04.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_06 = var_05 - var_04.origin;
  var_07 = self getsafecircleorigin(param_01, 0);
  var_08 = getanimlength(var_07);
  var_09 = getmovedelta(var_07);
  var_0A = length(var_09);
  var_0B = length(var_05 - self.origin);
  var_0C = var_08 * var_0B / var_0A;
  self ghostexplode(self.origin, var_05, var_0C);
  self setanimstate(param_01, 0);
  wait(var_0C);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(param_00, param_01);
}

playtraverseanim_gravity(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_04.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_06 = self getsafecircleorigin(param_01, 0);
  var_07 = getanimlength(var_06);
  thread lib_0F3C::func_CEA8(param_00, param_01, param_02);
  wait(var_07 * 0.4);
  self gib_fx_override("gravity");
  wait(var_07 * 0.6);
  self notify("traverse_end");
  func_11701(param_00, param_01);
}

func_D564(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_04.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_06 = self getsafecircleorigin(param_01, 0);
  lib_0F3C::func_CEA8(param_00, param_01, param_02);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(param_00, param_01);
}

func_D55C(param_00, param_01, param_02, param_03) {
  func_D564(param_00, param_01, param_02, param_03);
}

func_11701(param_00, param_01) {
  var_02 = level.asm[param_00].states[param_01];
  var_03 = undefined;
  if(isarray(var_02.var_116FB)) {
    var_03 = var_02.var_116FB[0];
  } else {
    var_03 = var_02.var_116FB;
  }

  scripts\asm\asm::func_2388(param_00, param_01, var_02, var_02.var_116FB);
  scripts\asm\asm::func_238A(param_00, var_03, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_11661(param_00) {}

func_11662(param_00, param_01, param_02, param_03) {}

func_89F8(param_00) {}

func_89F6() {}

func_89F5() {}

func_89F7() {}

func_6CE5(param_00) {}

func_126D2(param_00, param_01, param_02) {
  self unlink();
  self.var_DC1A = undefined;
}

func_D565(param_00, param_01, param_02, param_03) {}