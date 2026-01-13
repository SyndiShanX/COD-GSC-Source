/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3167.gsc
************************/

func_10097(var_0, var_1, var_2, var_3) {
  return isDefined(self.asm.var_4C86.var_92FA) && scripts\asm\asm::func_232B(var_1, "end");
}

func_FFDE(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self.asm.var_4C86.var_697F);
}

func_1009B(var_0, var_1, var_2, var_3) {
  return !isDefined(self.asm.var_4C86.var_92FA);
}

func_3E9C(var_0, var_1, var_2) {
  var_3 = lib_0A1E::func_235D(self.asm.var_4C86.var_92FA);
  return scripts\asm\asm::asm_lookupanimfromalias(self.asm.var_4C86.var_92FA, var_3);
}