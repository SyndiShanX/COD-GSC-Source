/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_wall_power.gsc
************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_wall_power;

autoexec __init__system__() {
  system::register(#"zm_bgb_wall_power", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_wall_power", "event", &event, undefined, undefined, &validation);
}

event() {
  self endon(#"disconnect", #"bgb_update");
  self waittill(#"zm_bgb_wall_power_used");
  self playsoundtoplayer(#"zmb_bgb_wall_power", self);
  self zm_stats::increment_challenge_stat(#"gum_gobbler_wall_power");
  self bgb::do_one_shot_use();
}

validation() {
  if(!zm_custom::function_901b751c(#"zmwallbuysenabled")) {
    return false;
  }

  return true;
}