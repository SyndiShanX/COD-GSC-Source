/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_death_perception.gsc
****************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_death_perception;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_death_perception", &__init__, &__main__, undefined);
}

__init__() {
  function_bc420db4();
}

__main__() {}

function_bc420db4() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_awareness", "mod_death_perception", #"perk_death_perception", #"specialty_awareness", 3500);
  zm_perks::register_perk_threads(#"specialty_mod_awareness", &function_422ccf78, &function_f8f0703b);
}

function_422ccf78() {}

function_f8f0703b(b_pause, str_perk, str_result, n_slot) {}