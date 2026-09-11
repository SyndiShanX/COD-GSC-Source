/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\custom.gsc
***********************************************/

function shouldstartcustomidle(var0, var1, var2, var3) {
  return isDefined(self.asm.customdata.idlestate);
}

function shouldcustomexit(var0, var1, var2, var3) {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self.asm.customdata.exitstate);
}

function shouldstopcustomidle(var0, var1, var2, var3) {
  return !isDefined(self.asm.customdata.idlestate);
}

function chooseanim_customidle(var0, var1, var2) {
  return scripts\asm\asm::asm_getrandomanim(var0, self.asm.customdata.idlestate);
}