/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1243911b5893214a.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace namespace_cd4551f405e67268;

function function_da956b9ed2ec5b85(state_name) {
  assert(isstring(state_name));
  self.melee_state = state_name;
}

function function_e725cd043cf58ebb() {
  if(istrue(self.var_a7a6441b0e218a8a)) {
    return;
  }

  self.var_a7a6441b0e218a8a = 1;

  if(istrue(self.zombieaisettings.var_96a98119d705d6c2)) {
    function_ac90fa5cc0a80298("explode_in");
    return;
  }

  function_ac90fa5cc0a80298(default_to(self.melee_state, "melee_in"));
}