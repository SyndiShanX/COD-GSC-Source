/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_slider.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_slider;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_slider", &__init__, undefined, undefined);
}

__init__() {
  function_bf3cfde4();
}

function_bf3cfde4() {
  zm_perks::register_perk_clientfields(#"specialty_mod_phdflopper", &function_59383c4e, &function_613ff0da);
  zm_perks::register_perk_init_thread(#"specialty_mod_phdflopper", &function_58cb6bff);
}

function_58cb6bff() {}

function_59383c4e() {}

function_613ff0da() {}