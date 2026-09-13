/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1890117db8723f9a.gsc
***********************************************/

_id_EA8FD298FEA1851E(asmname, statename, params) {
  self._blackboard._id_A7FAECD16F0E230A = 0;
}

_id_3DB167E32D7AB948(asmname, statename, params) {
  return istrue(self._blackboard._id_A7FAECD16F0E230A);
}

_id_22003E29EAA208E6(asmname, statename, params) {
  self._id_44C80D2697DCE15B = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_1517FE416C05EE1A(asmname, statename, params, self._id_44C80D2697DCE15B);
}

_id_1517FE416C05EE1A(asmname, statename, params, _id_2C8936D08F85C5C1) {
  self endon(statename + "_finished");
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  origin = self._id_83585377F202EB80.origin;
  angles = invertangles(self._id_83585377F202EB80.angles);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  self _meth_802C56A3DF8C7797(origin, angles, 0.66);
  _id_4E1D4DD23699A8A4::_id_49835F1C23C89361(asmname, statename);
}

_id_4508FDC5ED182000(asmname, statename, params) {
  level._id_E2958F412A7425C0.disablearrivals = 0;
  level._id_E2958F412A7425C0._id_83585377F202EB80 = undefined;
}