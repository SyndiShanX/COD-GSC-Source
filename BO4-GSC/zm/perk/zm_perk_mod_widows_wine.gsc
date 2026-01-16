/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_widows_wine.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_widows_wine;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_widows_wine", &__init__, undefined, undefined);
}

__init__() {
  enable_widows_wine_perk_for_level();
}

enable_widows_wine_perk_for_level() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_widowswine", "mod_widows_wine", #"perk_widows_wine", #"specialty_widowswine", 4500);
  zm_perks::register_perk_threads(#"specialty_mod_widowswine", &widows_wine_perk_activate, &widows_wine_perk_lost);
}

widows_wine_perk_activate() {
  self.var_a33a5a37++;
}

widows_wine_perk_lost(b_pause, str_perk, str_result, n_slot) {
  self notify(#"hash_4fa1f45a60444ddc");
}