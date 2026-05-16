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
  clientfield::register("toplayer", "" + #"zm_bgb_now_you_see_me_postfx", 1, 1, "int", &function_387d8f36, 0, 0);
}

function_387d8f36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"pstfx_zm_bgb_now_you_see_me");

    if(!isDefined(self.var_ab7bde88)) {
      self playSound(localclientnum, #"zmb_bgb_nysm_start_plr");
      self.var_ab7bde88 = self playLoopSound(#"zmb_bgb_nysm_loop_plr");
    }

    return;
  }

  self postfx::stoppostfxbundle(#"pstfx_zm_bgb_now_you_see_me");

  if(isDefined(self.var_ab7bde88)) {
    self stoploopsound(self.var_ab7bde88);
    self playSound(localclientnum, #"zmb_bgb_nysm_end_plr");
  }
}