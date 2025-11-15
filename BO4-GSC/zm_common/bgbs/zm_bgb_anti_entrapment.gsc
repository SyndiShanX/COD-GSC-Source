/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_anti_entrapment.gsc
*****************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_anti_entrapment;

autoexec __init__system__() {
  system::register(#"zm_bgb_anti_entrapment", &__init__, undefined, "bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_anti_entrapment", "time", 30, &enable, &disable, undefined, undefined);
  bgb::function_1fee6b3(#"zm_bgb_anti_entrapment", 11);
}

enable() {}

disable() {}