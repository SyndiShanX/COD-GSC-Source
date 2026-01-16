/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_in_plain_sight.gsc
****************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;
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

  bgb::register(#"zm_bgb_in_plain_sight", "activated", 1, undefined, undefined, undefined, &activation);
  bgb::function_72469efe(#"zm_bgb_in_plain_sight", 1);
  bgb::function_8a5d8cfb(#"zm_bgb_in_plain_sight", 1);
  bgb::function_57eb02e(#"zm_bgb_in_plain_sight");

  if(!isDefined(level.vsmgr_prio_visionset_zm_bgb_in_plain_sight)) {
    level.vsmgr_prio_visionset_zm_bgb_in_plain_sight = 110;
  }

  visionset_mgr::register_info("visionset", "zm_bgb_in_plain_sight", 1, level.vsmgr_prio_visionset_zm_bgb_in_plain_sight, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
  clientfield::register("toplayer", "" + #"hash_321b58d22755af74", 1, 1, "int");
}

validation() {
  if(self bgb::get_active() || isDefined(self.var_800f306a) && self.var_800f306a) {
    return false;
  }

  return true;
}

activation() {
  self endon(#"disconnect");
  self val::set(#"bgb_in_plain_sight", "ignoreme");
  self.bgb_in_plain_sight_active = 1;
  self playSound(#"zmb_bgb_plainsight_start");
  self thread bgb::run_timer(10);
  self clientfield::set_to_player("" + #"hash_321b58d22755af74", 1);
  ret = self waittilltimeout(9.5, #"bgb_about_to_take_on_bled_out", #"end_game", #"bgb_update", #"disconnect", #"scene_igc_shot_started");
  self playSound(#"zmb_bgb_plainsight_end");
  self clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
  self val::reset(#"bgb_in_plain_sight", "ignoreme");
  self.bgb_in_plain_sight_active = undefined;
}