/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_extra_credit.gsc
**************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;

#namespace zm_bgb_extra_credit;

autoexec __init__system__() {
  system::register(#"zm_bgb_extra_credit", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_extra_credit", "activated", 1, undefined, undefined, &validation, &activation);
}

activation() {
  powerup_origin = self bgb::get_player_dropped_powerup_origin();
  self thread function_22f934e6(powerup_origin, 96);
}

function_22f934e6(origin, var_22a4c702) {
  self endon(#"disconnect", #"bled_out");
  e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", origin, undefined, 0.1, undefined, undefined, 1, 1, 1, 1);

  if(isDefined(level.var_5a2df97b)) {
    e_powerup thread[[level.var_5a2df97b]]();
  }

  e_powerup.bonus_points_powerup_override = &function_19e7d278;
}

function_19e7d278(player) {
  return 1250;
}

validation() {
  return self bgb::function_9d8118f5();
}