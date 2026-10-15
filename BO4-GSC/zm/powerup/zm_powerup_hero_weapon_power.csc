/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_hero_weapon_power.csc
*******************************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_powerups;

#namespace zm_powerup_hero_weapon_power;

autoexec __init__system__() {
  system::register(#"zm_powerup_hero_weapon_power", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::include_zombie_powerup("hero_weapon_power");
  zm_powerups::add_zombie_powerup("hero_weapon_power");
}