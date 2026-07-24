/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3186.gsc
**************************************/

_id_566E() {}

_id_F6C8(var_0, var_1) {
  if(!isDefined(self._id_566C)) {
    self._id_566C = spawnStruct();
  }

  self._id_566C._id_2C19 = var_0;
  self._id_566C._id_8EE5 = var_1;
  scripts\asm\asm::asm_setstate("dismember");
}

_id_41A7() {
  if(isDefined(self._id_566C)) {
    self._id_566C._id_2C19 = undefined;
    self._id_566C._id_8EE5 = undefined;
    self._id_566C = undefined;
  }
}

_id_54B9() {
  if(self._id_566C._id_2C19 == 1) {
    return 1;
  }

  return 0;
}

_id_54B7() {
  if(self._id_566C._id_2C19 == 2) {
    return 1;
  }

  return 0;
}

_id_54BA() {
  if(self._id_566C._id_2C19 == 4) {
    return 1;
  }

  return 0;
}

_id_54B8() {
  if(self._id_566C._id_2C19 == 8) {
    return 1;
  }

  return 0;
}

_id_54B6() {
  if(self._id_566C._id_2C19 == 12) {
    return 1;
  }

  return 0;
}

_id_8C0D() {
  if(!isDefined(self._id_566C)) {
    return 0;
  }

  return 1;
}

_id_9E2E() {
  return self._id_566C._id_8EE5;
}

_id_9EDD(var_0) {
  if(!scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  return scripts\asm\asm_bb::bb_movetyperequested(var_0);
}

_id_CF1B(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  _id_5815(var_1, var_4);
  _id_41A7();
}

_id_5815(var_0, var_1) {
  self endon(var_0 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self scragentsetanimscale(1, 1);
  scripts\anim\notetracks_mp::_id_CED3(var_0, var_1, self._id_C081, "end");
}

_id_9EA5() {
  if(!isDefined(self._id_B8BA)) {
    return 0;
  }

  var_0 = self._id_B8BA & 1;
  return var_0 != 0;
}

_id_9EA4() {
  if(!isDefined(self._id_B8BA)) {
    return 0;
  }

  var_0 = self._id_B8BA & 2;
  return var_0 != 0;
}