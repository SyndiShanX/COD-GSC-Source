/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3121.gsc
************************/

func_D4FF(param_00, param_01, param_02, param_03) {
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self.asm.bpowereddown = 1;
  self clearanim(lib_0A1E::func_2342(), param_02);
  self give_attacker_kill_rewards(var_04, 1, param_02, 1);
}

func_697A(param_00, param_01, param_02) {
  self.asm.bpowereddown = undefined;
}