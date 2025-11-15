/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_health_regen.csc
*****************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace gadget_health_regen;

autoexec __init__system__() {
  system::register(#"gadget_health_regen", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "healthregen", 1, 1, "int", &function_31f57700, 0, 1);
  clientfield::register("clientuimodel", "hudItems.healingActive", 1, 1, "int", undefined, 0, 1);
  clientfield::register("clientuimodel", "hudItems.numHealthPickups", 1, 2, "int", undefined, 0, 1);
}

function_31f57700(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    if(newval) {
      if(!(isDefined(self.var_b072e263) && self.var_b072e263)) {
        self.var_e5996046 = self playLoopSound(#"hash_390aa7d4252c46b5", 0.25);
        self.var_b072e263 = 1;
        self postfx::playpostfxbundle("pstfx_health_regen");
      }

      return;
    }

    if(isDefined(self.var_b072e263) && self.var_b072e263) {
      self stoploopsound(self.var_e5996046);
      self.var_b072e263 = undefined;
      self postfx::exitpostfxbundle("pstfx_health_regen");
    }
  }
}