/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_electric_cherry.csc
***************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_electric_cherry;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_electric_cherry", &__init__, undefined, undefined);
}

__init__() {
  zm_perks::register_perk_clientfields(#"specialty_mod_electriccherry", &function_a58eb885, &function_aa41af78);
  zm_perks::register_perk_init_thread(#"specialty_mod_electriccherry", &function_5aa2ffe6);
}

function_5aa2ffe6() {}

function_a58eb885() {}

function_aa41af78() {}