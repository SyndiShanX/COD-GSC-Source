/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_41a75e0d79b62736.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;

#namespace namespace_f2050961;

init() {
  clientfield::register("toplayer", "" + #"hash_686e5c0d7af86361", 16000, 1, "int", &function_be33348b, 0, 0);
}

function_be33348b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self postfx::playpostfxbundle(#"pstfx_blood_wash");
    self postfx::playpostfxbundle(#"pstfx_zm_acid_dmg");
    self postfx::playpostfxbundle(#"hash_25c3aa91c32db43c");
    self.var_431ddde9 = self playLoopSound(#"hash_341a3fa00975f232");
    return;
  }

  self postfx::exitpostfxbundle(#"pstfx_blood_wash");
  self postfx::exitpostfxbundle(#"pstfx_zm_acid_dmg");
  self postfx::exitpostfxbundle(#"hash_25c3aa91c32db43c");

  if(isDefined(self.var_431ddde9)) {
    self stoploopsound(self.var_431ddde9);
  }
}