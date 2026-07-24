/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3121.gsc
**************************************/

_id_D4FF(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.asm.bpowereddown = 1;
  self clearanim(_id_0A1E::_id_2342(), var_2);
  self _meth_82A2(var_4, 1, var_2, 1);
}

_id_697A(var_0, var_1, var_2) {
  self.asm.bpowereddown = undefined;
}