/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_death_perception.csc
****************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_death_perception;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_death_perception", &__init__, undefined, undefined);
}

__init__() {
  function_bc420db4();
}

function_bc420db4() {
  zm_perks::register_perk_clientfields(#"specialty_mod_awareness", &function_2d4709d2, &function_998aa3ea);
  zm_perks::register_perk_init_thread(#"specialty_mod_awareness", &function_6c6f6b97);
}

function_6c6f6b97() {}

function_2d4709d2() {}

function_998aa3ea() {}