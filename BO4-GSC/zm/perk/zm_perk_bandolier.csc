/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_bandolier.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_bandolier;

autoexec __init__system__() {
  system::register(#"zm_perk_bandolier", &__init__, undefined, undefined);
}

__init__() {
  function_27473e44();
  zm_perks::function_f3c80d73("zombie_perk_bottle_bandolier", "zombie_perk_totem_bandolier");
}

function_27473e44() {
  zm_perks::register_perk_clientfields(#"specialty_extraammo", &function_12161a30, &function_b10a7225);
  zm_perks::register_perk_effects(#"specialty_extraammo", "sleight_light");
  zm_perks::register_perk_init_thread(#"specialty_extraammo", &init_perk);
  zm_perks::function_b60f4a9f(#"specialty_extraammo", #"p8_zm_vapor_altar_icon_01_bandolierbandit", "zombie/fx8_perk_altar_symbol_ambient_bandolier", #"zmperksbandolier");
}

init_perk() {
  if(isDefined(level.enable_magic) && level.enable_magic) {}
}

function_12161a30() {}

function_b10a7225() {}