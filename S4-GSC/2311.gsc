/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2311.gsc
*************************************************/

_id_4B47() {}

_id_25EA(var_0) {
  switch (var_0) {
    case 1:
      return "zombie_missing_right_arm_animclass";
    case 2:
      return "zombie_missing_left_arm_animclass";
    case 4:
      return "zombie_missing_right_leg_animclass";
    case 8:
      return "zombie_missing_left_leg_animclass";
    case 12:
      return "zombie_crawl_animclass";
    case 0:
      return "zombie_asm_animclass";
    default:
      return undefined;
  }
}

_id_D513(var_0, var_1) {
  if(!isDefined(self._id_4B45)) {
    self._id_4B45 = spawnStruct();
  }

  self._id_4B45._id_25EB = var_0;
  self._id_4B45._id_7929 = var_1;
  _id_0009::_id_1CA1("dismember");
}

_id_3938() {
  if(isDefined(self._id_4B45)) {
    self._id_4B45._id_25EB = undefined;
    self._id_4B45._id_7929 = undefined;
    self._id_4B45 = undefined;
  }
}

_id_496D() {
  if(self._id_4B45._id_25EB == 1) {
    return 1;
  }

  return 0;
}

_id_496B() {
  if(self._id_4B45._id_25EB == 2) {
    return 1;
  }

  return 0;
}

_id_496E() {
  if(self._id_4B45._id_25EB == 4) {
    return 1;
  }

  return 0;
}

_id_496C() {
  if(self._id_4B45._id_25EB == 8) {
    return 1;
  }

  return 0;
}

_id_496A() {
  if(self._id_4B45._id_25EB == 12) {
    return 1;
  }

  return 0;
}

_id_7589() {
  if(!isDefined(self._id_4B45)) {
    return 0;
  }

  return 1;
}

_id_88A0() {
  return self._id_4B45._id_7929;
}

_id_8979(var_0) {
  if(!_id_06BD::_id_23E5()) {
    return 0;
  }

  return _id_06BD::_id_23E6(var_0);
}

_id_B38A(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  _id_4C69(var_1, var_3);
  _id_3938();
}

_id_4C69(var_0, var_1) {
  self endon(var_0 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");

  if(self _meth_85EC()) {
    self _meth_82BA(1, 1);
  }

  _id_0017::_id_B354(var_0, var_1, self._id_A5AC, "end");
}

_id_8931() {
  if(!isDefined(self._id_9F84)) {
    return 0;
  }

  var_0 = self._id_9F84 & 1;
  return var_0 != 0;
}

_id_8930() {
  if(!isDefined(self._id_9F84)) {
    return 0;
  }

  var_0 = self._id_9F84 & 2;
  return var_0 != 0;
}