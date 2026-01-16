/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_now_you_see_me.gsc
****************************************************/

#include scripts\core_common\clientfield_shared;
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

  bgb::register(#"zm_bgb_now_you_see_me", "activated", 1, undefined, undefined, undefined, &activation);
  bgb::function_57eb02e(#"zm_bgb_now_you_see_me");
  bgb::function_1fee6b3(#"zm_bgb_now_you_see_me", 19);

  if(!isDefined(level.vsmgr_prio_visionset_zm_bgb_now_you_see_me)) {
    level.vsmgr_prio_visionset_zm_bgb_now_you_see_me = 111;
  }

  visionset_mgr::register_info("visionset", "zm_bgb_now_you_see_me", 1, level.vsmgr_prio_visionset_zm_bgb_now_you_see_me, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
  clientfield::register("toplayer", "" + #"hash_18be2b4b3936ee1f", 1, 1, "int");
}

validation() {
  return !(isDefined(self bgb::get_active()) && self bgb::get_active());
}

activation() {
  self endon(#"disconnect");
  self.b_is_designated_target = 1;
  self thread bgb::run_timer(15);
  self playSound(#"zmb_bgb_nysm_start");
  self clientfield::set_to_player("" + #"hash_18be2b4b3936ee1f", 1);
  ret = self waittilltimeout(14.5, #"bgb_about_to_take_on_bled_out", #"end_game", #"bgb_update", #"disconnect");
  self playSound(#"zmb_bgb_nysm_end");

  if("timeout" != ret._notify) {
    visionset_mgr::deactivate("visionset", "zm_bgb_now_you_see_me", self);
  }

  self clientfield::set_to_player("" + #"hash_18be2b4b3936ee1f", 0);
  self.b_is_designated_target = 0;
}