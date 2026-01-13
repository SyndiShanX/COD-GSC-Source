/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3130.gsc
*********************************************/

func_D55D(var_0, var_1, var_2, var_3) {}

func_D566(var_0, var_1, var_2, var_3) {
  func_D564(var_0, var_1, var_2);
}

func_D560(var_0, var_1, var_2, var_3) {
  func_D563(var_0, var_1, var_2, var_3);
}

func_D55E(var_0, var_1, var_2, var_3) {}

func_D563(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self getspectatepoint();
  var_5 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_4.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_6 = var_5 - var_4.origin;
  var_7 = self getsafecircleorigin(var_1, 0);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7);
  var_0A = length(var_9);
  var_0B = length(var_5 - self.origin);
  var_0C = var_8 * var_0B / var_0A;
  self ghostexplode(self.origin, var_5, var_0C);
  self setanimstate(var_1, 0);
  wait(var_0C);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(var_0, var_1);
}

playtraverseanim_gravity(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self getspectatepoint();
  var_5 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_4.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_6 = self getsafecircleorigin(var_1, 0);
  var_7 = getanimlength(var_6);
  thread lib_0F3C::func_CEA8(var_0, var_1, var_2);
  wait(var_7 * 0.4);
  self gib_fx_override("gravity");
  wait(var_7 * 0.6);
  self notify("traverse_end");
  func_11701(var_0, var_1);
}

func_D564(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self getspectatepoint();
  var_5 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_4.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_6 = self getsafecircleorigin(var_1, 0);
  lib_0F3C::func_CEA8(var_0, var_1, var_2);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(var_0, var_1);
}

func_D55C(var_0, var_1, var_2, var_3) {
  func_D564(var_0, var_1, var_2, var_3);
}

func_11701(var_0, var_1) {
  var_2 = level.asm[var_0].states[var_1];
  var_3 = undefined;
  if(isarray(var_2.var_116FB)) {
    var_3 = var_2.var_116FB[0];
  } else {
    var_3 = var_2.var_116FB;
  }

  scripts\asm\asm::func_2388(var_0, var_1, var_2, var_2.var_116FB);
  scripts\asm\asm::func_238A(var_0, var_3, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_11661(var_0) {}

func_11662(var_0, var_1, var_2, var_3) {}

func_89F8(var_0) {}

func_89F6() {}

func_89F5() {}

func_89F7() {}

func_6CE5(var_0) {}

func_126D2(var_0, var_1, var_2) {
  self unlink();
  self.var_DC1A = undefined;
}

func_D565(var_0, var_1, var_2, var_3) {}