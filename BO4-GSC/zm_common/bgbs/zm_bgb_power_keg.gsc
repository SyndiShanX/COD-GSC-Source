/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_power_keg.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_power_keg;

autoexec __init__system__() {
  system::register(#"zm_bgb_power_keg", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_power_keg", "activated", 1, undefined, undefined, &validation, &activation);
}

activation() {
  self thread bgb::function_c6cd71d5("hero_weapon_power", undefined, 96);
}

validation() {
  return self bgb::function_9d8118f5();
}