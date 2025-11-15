/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_conflagration_liquidation.gsc
***************************************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_conflagration_liquidation;

autoexec __init__system__() {
  system::register(#"zm_bgb_conflagration_liquidation", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_conflagration_liquidation", "activated", 1, undefined, undefined, &function_fe4e9412, &activation);
}

activation() {
  self thread bgb::function_c6cd71d5("bonfire_sale", undefined, 96);
}

function_fe4e9412() {
  if(!level flag::get("pap_machine_active") || zombie_utility::get_zombie_var(#"zombie_powerup_bonfire_sale_on") === 1 || isDefined(level.var_56cb3d3a) && level.var_56cb3d3a || !self bgb::function_9d8118f5()) {
    return false;
  }

  return true;
}