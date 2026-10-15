/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_power_vacuum.gsc
**************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_power_vacuum;

autoexec __init__system__() {
  system::register(#"zm_bgb_power_vacuum", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_power_vacuum", "time", 300, &enable, &disable, undefined);
}

enable() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");
  level.powerup_drop_count = 0;

  while(true) {
    level waittill(#"powerup_dropped");
    self bgb::do_one_shot_use();
    level.powerup_drop_count = 0;
  }
}

disable() {}