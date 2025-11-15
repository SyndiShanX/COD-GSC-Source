/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_arsenal_accelerator.gsc
*********************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_arsenal_accelerator;

autoexec __init__system__() {
  system::register(#"zm_bgb_arsenal_accelerator", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_arsenal_accelerator", "time", 120, &enable, &disable, undefined);
  bgb::function_1fee6b3(#"zm_bgb_arsenal_accelerator", 23);
}

enable() {}

disable() {}