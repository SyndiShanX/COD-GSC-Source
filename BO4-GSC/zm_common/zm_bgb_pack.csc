/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_bgb_pack.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\load;

#namespace bgb_pack;

autoexec __init__system__() {
  system::register(#"bgb_pack", &__init__, &__main__, undefined);
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  clientfield::register("clientuimodel", "zmhud.bgb_carousel.global_cooldown", 1, 5, "float", undefined, 0, 0);

  for(i = 0; i < 4; i++) {
    clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".state", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".gum_idx", 1, 7, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".cooldown_perc", 1, 5, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".lockdown", 1, 1, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".unavailable", 1, 1, "float", undefined, 0, 0);
  }
}

private __main__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
}