/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_stronghold.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_stronghold;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_stronghold", &__init__, undefined, undefined);
}

__init__() {
  function_8afdc221();
}

function_8afdc221() {
  zm_perks::register_perk_clientfields(#"specialty_mod_camper", &function_46f52747, &function_d2d66071);
  zm_perks::register_perk_init_thread(#"specialty_mod_camper", &function_e630abb2);
}

function_e630abb2() {}

function_46f52747() {}

function_d2d66071() {}