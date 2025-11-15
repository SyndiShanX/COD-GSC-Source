/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_cooldown.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_cooldown;

autoexec __init__system__() {
  system::register(#"zm_perk_cooldown", &__init__, undefined, undefined);
}

__init__() {
  enable_cooldown_perk_for_level();
}

enable_cooldown_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_cooldown", &function_683242be, &function_20945b84);
  zm_perks::register_perk_effects(#"specialty_cooldown", "divetonuke_light");
  zm_perks::register_perk_init_thread(#"specialty_cooldown", &init_cooldown);
  zm_perks::function_b60f4a9f(#"specialty_cooldown", #"p8_zm_vapor_altar_icon_01_timeslip", "zombie/fx8_perk_altar_symbol_ambient_timeslip", #"zmperkscooldown");
  zm_perks::function_f3c80d73("zombie_perk_bottle_cooldown", "zombie_perk_totem_timeslip");
}

init_cooldown() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
  }
}

function_683242be() {}

function_20945b84() {}