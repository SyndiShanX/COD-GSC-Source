/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_dying_wish.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_dying_wish;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_dying_wish", &__init__, undefined, undefined);
}

__init__() {
  function_7186a3aa();
}

function_7186a3aa() {
  zm_perks::register_perk_clientfields(#"specialty_mod_berserker", &function_974d4ee2, &function_992358e3);
  zm_perks::register_perk_init_thread(#"specialty_mod_berserker", &function_4e184775);
}

function_4e184775() {}

function_974d4ee2() {}

function_992358e3() {}