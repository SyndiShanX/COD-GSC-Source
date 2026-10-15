/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_zombshell.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_zombshell;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_zombshell", &__init__, undefined, undefined);
}

__init__() {
  enable_zombshell_perk_for_level();
}

enable_zombshell_perk_for_level() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_zombshell", "mod_zombshell", #"perk_zombshell", #"specialty_zombshell", 5500);
  zm_perks::register_perk_threads(#"specialty_mod_zombshell", &function_58d94d9, &function_bf7ca4a7);
}

function_58d94d9() {}

function_bf7ca4a7(b_pause, str_perk, str_result, n_slot) {}