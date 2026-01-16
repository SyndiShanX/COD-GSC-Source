/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_wall_to_wall_clearance.gsc
************************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace zm_bgb_wall_to_wall_clearance;

autoexec __init__system__() {
  system::register(#"zm_bgb_wall_to_wall_clearance", &__init__, undefined, "bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_wall_to_wall_clearance", "time", 30, &enable, &disable, &validation, undefined);
}

enable() {
  zm_wallbuy::function_c047c228(&function_84832f40);
  zm_wallbuy::function_33023da5(&function_84832f40);
  zm_wallbuy::function_48f914bd(&override_ammo_cost);
}

disable() {
  zm_wallbuy::function_a6889c(&function_84832f40);
  zm_wallbuy::function_782e8955(&function_84832f40);
  zm_wallbuy::function_99911dae(&override_ammo_cost);
}

validation() {
  if(!zm_custom::function_901b751c(#"zmwallbuysenabled")) {
    return false;
  }

  return true;
}

function_84832f40(w_wallbuy, var_2b6f3563) {
  return 10;
}

override_ammo_cost(w_wallbuy, stub) {
  if(self zm_weapons::has_upgrade(w_wallbuy)) {
    return 500;
  }

  return 10;
}