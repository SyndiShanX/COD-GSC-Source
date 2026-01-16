/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_small_ammo.csc
************************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_powerups;

#namespace zm_powerup_small_ammo;

autoexec __init__system__() {
  system::register(#"zm_powerup_small_ammo", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::include_zombie_powerup("small_ammo");

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("small_ammo");
  }
}