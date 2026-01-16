/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_always_done_swiftly.gsc
*********************************************************/

#include scripts\core_common\perks;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_always_done_swiftly;

autoexec __init__system__() {
  system::register(#"zm_bgb_always_done_swiftly", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_always_done_swiftly", "time", 300, &enable, &disable, undefined);
}

enable() {
  self perks::perk_setperk("specialty_fastads");
  self perks::perk_setperk("specialty_stalker");
}

disable() {
  self perks::perk_unsetperk("specialty_fastads");
  self perks::perk_unsetperk("specialty_stalker");
}