/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5490321f01c7322e.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace namespace_3cd8443b4650c886;

function function_6c5371915054a3f9(state_name) {
  assert(isstring(state_name));
  self.bite_state = state_name;
}

function function_3ce3c307b88d4237() {
  if(istrue(self.var_4507177651176666)) {
    return;
  }

  self.var_4507177651176666 = 1;
  function_ac90fa5cc0a80298(default_to(self.bite_state, "bite_in"));
}