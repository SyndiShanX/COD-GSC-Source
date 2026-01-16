/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_tortoise.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_tortoise;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_tortoise", &__init__, undefined, undefined);
}

__init__() {
  function_dfb8db6a();
}

function_dfb8db6a() {
  zm_perks::register_perk_clientfields(#"specialty_mod_shield", &function_7e8d1b34, &function_de73ba5c);
  zm_perks::register_perk_init_thread(#"specialty_mod_shield", &function_cdedb133);
}

function_cdedb133() {}

function_7e8d1b34() {}

function_de73ba5c() {}