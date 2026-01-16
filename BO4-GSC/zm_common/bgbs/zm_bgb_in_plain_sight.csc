/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_in_plain_sight.csc
****************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_in_plain_sight;

autoexec __init__system__() {
  system::register(#"zm_bgb_in_plain_sight", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_in_plain_sight", "activated");
  visionset_mgr::register_visionset_info("zm_bgb_in_plain_sight", 1, 31, undefined, "zm_bgb_in_plain_sight");
  clientfield::register("toplayer", "" + #"hash_321b58d22755af74", 1, 1, "int", &function_8b05d1ce, 0, 0);
}

function_8b05d1ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"hash_1e8cc5b28385a579");

    if(!isDefined(self.var_6fc0e881)) {
      self playSound(localclientnum, #"hash_766f7e280a750ba8");
      self.var_6fc0e881 = self playLoopSound(#"hash_38ea108cd6442868");
    }

    return;
  }

  self postfx::stoppostfxbundle(#"hash_1e8cc5b28385a579");

  if(isDefined(self.var_6fc0e881)) {
    self playSound(localclientnum, #"hash_5d65ef28d3f9dc1d");
    self stoploopsound(self.var_6fc0e881);
  }
}