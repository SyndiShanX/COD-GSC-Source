/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3130.gsc
**************************************/

_id_D55D(var_0, var_1, var_2, var_3) {}

_id_D566(var_0, var_1, var_2, var_3) {
  _id_D564(var_0, var_1, var_2);
}

_id_D560(var_0, var_1, var_2, var_3) {
  _id_D563(var_0, var_1, var_2, var_3);
}

_id_D55E(var_0, var_1, var_2, var_3) {}

_id_D563(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self _meth_8148();
  var_5 = self _meth_8146();
  self scragentsetphysicsmode("noclip");
  self orientmode("face angle abs", var_4.angles);
  self _meth_8281("anim deltas");
  self scragentsetanimscale(1.0, 1.0);
  var_6 = var_5 - var_4.origin;
  var_7 = self getanimentry(var_1, 0);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7);
  var_10 = length(var_9);
  var_11 = length(var_5 - self.origin);
  var_12 = var_8 * (var_11 / var_10);
  self _meth_827B(self.origin, var_5, var_12);
  self setanimstate(var_1, 0);
  wait(var_12);
  self scragentsetphysicsmode("gravity");
  self notify("traverse_end");
  _id_11701(var_0, var_1);
}

playtraverseanim_gravity(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self _meth_8148();
  var_5 = self _meth_8146();
  self scragentsetphysicsmode("noclip");
  self orientmode("face angle abs", var_4.angles);
  self _meth_8281("anim deltas");
  self scragentsetanimscale(1.0, 1.0);
  var_6 = self getanimentry(var_1, 0);
  var_7 = getanimlength(var_6);
  thread _id_0F3C::_id_CEA8(var_0, var_1, var_2);
  wait(var_7 * 0.4);
  self scragentsetphysicsmode("gravity");
  wait(var_7 * 0.6);
  self notify("traverse_end");
  _id_11701(var_0, var_1);
}

_id_D564(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self _meth_8148();
  var_5 = self _meth_8146();
  self scragentsetphysicsmode("noclip");
  self orientmode("face angle abs", var_4.angles);
  self _meth_8281("anim deltas");
  self scragentsetanimscale(1.0, 1.0);
  var_6 = self getanimentry(var_1, 0);
  _id_0F3C::_id_CEA8(var_0, var_1, var_2);
  self scragentsetphysicsmode("gravity");
  self notify("traverse_end");
  _id_11701(var_0, var_1);
}

_id_D55C(var_0, var_1, var_2, var_3) {
  _id_D564(var_0, var_1, var_2, var_3);
}

_id_11701(var_0, var_1) {
  var_2 = anim.asm[var_0].states[var_1];
  var_3 = undefined;

  if(isarray(var_2._id_116FB)) {
    var_3 = var_2._id_116FB[0];
  } else {
    var_3 = var_2._id_116FB;
  }

  scripts\asm\asm::_id_2388(var_0, var_1, var_2, var_2._id_116FB);
  scripts\asm\asm::_id_238A(var_0, var_3, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

_id_11661(var_0) {}

_id_11662(var_0, var_1, var_2, var_3) {}

_id_89F8(var_0) {}

_id_89F6() {}

_id_89F5() {}

_id_89F7() {}

_id_6CE5(var_0) {}

_id_126D2(var_0, var_1, var_2) {
  self unlink();
  self._id_DC1A = undefined;
}

_id_D565(var_0, var_1, var_2, var_3) {}