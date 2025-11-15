/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_staminup.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_staminup;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_staminup", &__init__, undefined, undefined);
}

__init__() {
  enable_mod_staminup_perk_for_level();
}

enable_mod_staminup_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_mod_staminup", &registermelee_leader_guntookpain, &function_170260ee);
  zm_perks::register_perk_init_thread(#"specialty_mod_staminup", &function_c24062a0);
}

function_c24062a0() {}

registermelee_leader_guntookpain() {}

function_170260ee() {}