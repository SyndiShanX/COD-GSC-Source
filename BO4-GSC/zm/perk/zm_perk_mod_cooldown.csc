/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_cooldown.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_cooldown;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_cooldown", &__init__, undefined, undefined);
}

__init__() {
  function_7299c39e();
}

function_7299c39e() {
  zm_perks::register_perk_clientfields(#"specialty_mod_cooldown", &function_2e843bb7, &function_dbcec7de);
  zm_perks::register_perk_init_thread(#"specialty_mod_cooldown", &function_d5042d74);
}

function_d5042d74() {}

function_2e843bb7() {}

function_dbcec7de() {}