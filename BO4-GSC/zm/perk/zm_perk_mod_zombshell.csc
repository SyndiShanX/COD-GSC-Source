/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_zombshell.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_zombshell;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_zombshell", &__init__, undefined, undefined);
}

__init__() {
  zm_perks::register_perk_clientfields(#"specialty_mod_zombshell", &function_5eadb2fd, &function_fbae967f);
  zm_perks::register_perk_init_thread(#"specialty_mod_zombshell", &function_793d9032);
}

function_793d9032() {}

function_5eadb2fd() {}

function_fbae967f() {}