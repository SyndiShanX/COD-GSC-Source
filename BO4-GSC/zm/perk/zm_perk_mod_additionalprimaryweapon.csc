/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_additionalprimaryweapon.csc
***********************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_additionalprimaryweapon;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_additionalprimaryweapon", &__init__, undefined, undefined);
}

__init__() {
  function_c0deb38d();
}

function_c0deb38d() {
  zm_perks::register_perk_clientfields(#"specialty_mod_additionalprimaryweapon", &function_40cb6d31, &function_90e7d3be);
  zm_perks::register_perk_init_thread(#"specialty_mod_additionalprimaryweapon", &function_a850540);
}

function_a850540() {}

function_40cb6d31() {}

function_90e7d3be() {}