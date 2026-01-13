/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3121.gsc
*********************************************/

func_D4FF(var_0, var_1, var_2, var_3) {
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.asm.bpowereddown = 1;
  self clearanim(lib_0A1E::func_2342(), var_2);
  self give_attacker_kill_rewards(var_4, 1, var_2, 1);
}

func_697A(var_0, var_1, var_2) {
  self.asm.bpowereddown = undefined;
}