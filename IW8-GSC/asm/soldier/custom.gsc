/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\custom.gsc
***********************************************/

shouldstartcustomidle(var_0, var_1, var_2, var_3) {
  return isDefined(self.asm.customdata.idlestate);
}

shouldcustomexit(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self.asm.customdata.exitstate);
}

shouldstopcustomidle(var_0, var_1, var_2, var_3) {
  return !isDefined(self.asm.customdata.idlestate);
}

chooseanim_customidle(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_getrandomanim(var_0, self.asm.customdata.idlestate);
}