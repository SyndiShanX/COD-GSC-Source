/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3167.gsc
************************/

func_10097(param_00, param_01, param_02, param_03) {
  return isDefined(self.asm.var_4C86.var_92FA) && scripts\asm\asm::func_232B(param_01, "end");
}

func_FFDE(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self.asm.var_4C86.var_697F);
}

func_1009B(param_00, param_01, param_02, param_03) {
  return !isDefined(self.asm.var_4C86.var_92FA);
}

func_3E9C(param_00, param_01, param_02) {
  var_03 = lib_0A1E::func_235D(self.asm.var_4C86.var_92FA);
  return scripts\asm\asm::asm_lookupanimfromalias(self.asm.var_4C86.var_92FA, var_03);
}