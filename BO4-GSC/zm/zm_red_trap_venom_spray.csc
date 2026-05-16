/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_trap_venom_spray.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#namespace zm_red_trap_venom_spray;

init() {
  clientfield::register("toplayer", "" + #"venom_spray_postfx", 16000, 1, "int", &venom_spray_postfx, 0, 0);
}

venom_spray_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self postfx::playpostfxbundle(#"pstfx_blood_wash");
    self postfx::playpostfxbundle(#"pstfx_zm_acid_dmg");
    self postfx::playpostfxbundle(#"pstfx_zm_acid_dmg_2");
    self.var_431ddde9 = self playLoopSound(#"zmb_trap_acid_loop_plr");
    return;
  }

  self postfx::exitpostfxbundle(#"pstfx_blood_wash");
  self postfx::exitpostfxbundle(#"pstfx_zm_acid_dmg");
  self postfx::exitpostfxbundle(#"pstfx_zm_acid_dmg_2");

  if(isDefined(self.var_431ddde9)) {
    self stoploopsound(self.var_431ddde9);
  }
}