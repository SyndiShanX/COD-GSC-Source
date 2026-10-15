/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_combat_efficiency.csc
**********************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace gadget_combat_efficiency;

autoexec __init__system__() {
  system::register(#"gadget_combat_efficiency", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("clientuimodel", "hudItems.combatEfficiencyActive", 1, 1, "int", &function_24a1439f, 0, 0);
}

function_24a1439f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(newval) && newval > 0) {
    if(newval != oldval) {
      self playSound(localclientnum, #"hash_3eea09f794eb0577");
    }

    if(!isDefined(self.var_8db0b9f5)) {
      self.var_8db0b9f5 = self playLoopSound(#"hash_1a6eca90431e5c64");
    }

    return;
  }

  if(isDefined(self.var_8db0b9f5)) {
    self stoploopsound(self.var_8db0b9f5);
    self playSound(localclientnum, #"hash_529910b20b42ef5b");
    self.var_8db0b9f5 = undefined;
  }
}