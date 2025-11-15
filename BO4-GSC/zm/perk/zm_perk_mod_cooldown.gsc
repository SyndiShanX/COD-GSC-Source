/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_cooldown.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_cooldown;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_cooldown", &__init__, &__main__, undefined);
}

__init__() {
  function_7299c39e();
}

__main__() {}

function_7299c39e() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_cooldown", "mod_cooldown", #"perk_cooldown", #"specialty_cooldown", 3500);
  zm_perks::register_perk_threads(#"specialty_mod_cooldown", &function_8d51d9a8, &function_754453a);
}

function_8d51d9a8() {}

function_754453a(b_pause, str_perk, str_result, n_slot) {}