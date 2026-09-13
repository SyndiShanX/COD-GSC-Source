/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\custom.gsc
***********************************************/

shouldstartcustomidle(asmname, statename, _id_F2B19B25D457C2A6, params) {
  self notify("cap_custom_arrival");
  return isDefined(self._id_85ECBBE4FAE7C0AE);
}

shouldcustomexit(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self._id_57E1B0C4AD45DB70);
}

shouldstopcustomidle(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !isDefined(self._id_85ECBBE4FAE7C0AE);
}

chooseanim_customidle(asmname, statename, params) {
  return scripts\asm\asm::asm_getrandomanim(asmname, self._id_85ECBBE4FAE7C0AE);
}

_id_C929D0A507D24467(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._id_DDAD29BBDECD1671);
}

_id_A08C428057E0222A(asmname, statename, params) {
  self[[self._id_DDAD29BBDECD1671]]();
}