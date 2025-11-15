/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_ethereal_razor.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_ethereal_razor;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_ethereal_razor", &__init__, undefined, undefined);
}

__init__() {
  enable_ethereal_razor_perk_for_level();
}

enable_ethereal_razor_perk_for_level() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_etherealrazor", "mod_ethereal_razor", #"perk_ethereal_razor", #"specialty_etherealrazor", 5500);
  zm_perks::register_perk_threads(#"specialty_mod_etherealrazor", &function_5b26f1e3, &function_98c3f271);
}

function_5b26f1e3() {}

function_98c3f271(b_pause, str_perk, str_result, n_slot) {}