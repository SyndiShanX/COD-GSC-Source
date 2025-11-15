/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_deadshot.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_deadshot;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_deadshot", &__init__, undefined, undefined);
}

__init__() {
  enable_mod_deadshot_perk_for_level();
}

enable_mod_deadshot_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_mod_deadshot", &function_7252aedc, &function_8357e1f3);
  zm_perks::register_perk_init_thread(#"specialty_mod_deadshot", &function_85402de1);
}

function_85402de1() {}

function_7252aedc() {}

function_8357e1f3() {}