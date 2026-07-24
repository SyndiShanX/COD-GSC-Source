/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3167.gsc
**************************************/

_id_10097(var_0, var_1, var_2, var_3) {
  return isDefined(self.asm._id_4C86._id_92FA) && scripts\asm\asm::_id_232B(var_1, "end");
}

_id_FFDE(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self.asm._id_4C86._id_697F);
}

_id_1009B(var_0, var_1, var_2, var_3) {
  return !isDefined(self.asm._id_4C86._id_92FA);
}

_id_3E9C(var_0, var_1, var_2) {
  var_3 = _id_0A1E::_id_235D(self.asm._id_4C86._id_92FA);
  return scripts\asm\asm::asm_lookupanimfromalias(self.asm._id_4C86._id_92FA, var_3);
}