/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_widows_wine.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_widows_wine;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_widows_wine", &__init__, undefined, undefined);
}

__init__() {
  zm_perks::register_perk_clientfields(#"specialty_mod_widowswine", &function_905840b3, &function_a3102f04);
  zm_perks::register_perk_init_thread(#"specialty_mod_widowswine", &function_eb36b57e);
}

function_eb36b57e() {}

function_905840b3() {}

function_a3102f04() {}