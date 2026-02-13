/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\asm\zombie_trickster\asm_trickster.gsc
**********************************************************/

zombietrickster_init(var_0, var_1, var_2) {
  self _meth_87CF(self._id_1C30._id_1A35);
  self._id_1C30._id_426A = spawnStruct();
  self._id_1C30._id_5E3A = spawnStruct();
  self._id_1C30._id_5E3A._id_5E36 = "invalid";
  self._id_1C30._id_5E3A._id_F1E8 = 0;
  self._id_1C30.movealias = [];
  self._id_5DC3 = ::_id_DBA8;
}

_id_DBA8() {
  return 0;
}

zombietrickster_shouldattack(var_0, var_1, var_2, var_3) {
  if(istrue(self.needs_to_attack)) {
    return 1;
  }

  return 0;
}

zombietrickster_shouldfastattack(var_0, var_1, var_2, var_3) {
  if(istrue(self.needs_fast_attack)) {
    return 1;
  }

  return 0;
}

choosebreakmaskanim(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, "break_mask_" + self.mask_num);
}

breakmaskterminate(var_0, var_1, var_2) {
  _id_0009::_id_1C52("breakMask", "end");
}