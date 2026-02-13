/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 8.gsc
*************************************************/

init() {
  if(isDefined(level._id_0B73)) {
    return;
  }
  level._id_0B73 = [];
  anim._id_58E3 = 0;
  anim._id_EACB = 1;
  anim._id_CA5F = 2;
  anim._id_84F1 = 3;
  anim._id_0E09 = 3;
}

_id_00AC() {
  self._id_2C5E = spawnStruct();

  if(isDefined(self._id_24BD)) {
    self _meth_84E0(self._id_24BD);
  }

  self._id_2C5E._id_82FD = [];
  thread _id_00A6();
}

_id_2C65(var_0) {
  self _meth_84E1();

  if(isDefined(var_0)) {
    self._id_24BD = var_0;
    self _meth_84E0(self._id_24BD);
  }
}

_id_00AA(var_0, var_1) {
  return level._id_0B73[var_0]._id_0E8A[var_1];
}

_id_00A6() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("ai_notify", var_0, var_1);
    _id_0009::_id_1C52("ai_notify", var_0, var_1);
  }
}

_id_00C5() {
  if(isDefined(self._id_24BD)) {
    self _meth_84E2();
  }
}