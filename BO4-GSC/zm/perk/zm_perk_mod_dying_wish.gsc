/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_dying_wish.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_dying_wish;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_dying_wish", &__init__, &__main__, undefined);
}

__init__() {
  function_7186a3aa();
}

__main__() {}

function_7186a3aa() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_berserker", "mod_dying_wish", #"perk_dying_wish", #"specialty_berserker", 5000);
  zm_perks::register_perk_threads(#"specialty_mod_berserker", &function_fb91d1a, &function_63f21c1e);
}

function_fb91d1a() {}

function_63f21c1e(b_pause, str_perk, str_result, n_slot) {}