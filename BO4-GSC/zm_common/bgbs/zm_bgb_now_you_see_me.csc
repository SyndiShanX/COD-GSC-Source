/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_now_you_see_me.csc
****************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_now_you_see_me;

autoexec __init__system__() {
  system::register(#"zm_bgb_now_you_see_me", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_now_you_see_me", "activated");
  visionset_mgr::register_visionset_info("zm_bgb_now_you_see_me", 1, 31, undefined, "zm_bgb_in_plain_sight");
  clientfield::register("toplayer", "" + #"hash_18be2b4b3936ee1f", 1, 1, "int", &function_387d8f36, 0, 0);
}

function_387d8f36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"hash_129cb5a3537b76f4");

    if(!isDefined(self.var_ab7bde88)) {
      self playSound(localclientnum, #"hash_7b2800dd9e263794");
      self.var_ab7bde88 = self playLoopSound(#"hash_3045ef348e47e6b4");
    }

    return;
  }

  self postfx::stoppostfxbundle(#"hash_129cb5a3537b76f4");

  if(isDefined(self.var_ab7bde88)) {
    self stoploopsound(self.var_ab7bde88);
    self playSound(localclientnum, #"hash_15703d934c79add1");
  }
}