/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_tortoise.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_tortoise;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_tortoise", &__init__, &__main__, undefined);
}

__init__() {
  function_dfb8db6a();
}

__main__() {}

function_dfb8db6a() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_shield", "mod_tortoise", #"perk_tortoise", #"specialty_shield", 3500);
  zm_perks::register_perk_threads(#"specialty_mod_shield", &function_f2b55850, &function_844bdb66);
}

function_f2b55850() {}

function_844bdb66(b_pause, str_perk, str_result, n_slot) {}