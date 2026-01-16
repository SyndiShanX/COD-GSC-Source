/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_staminup.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_staminup;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_staminup", &__init__, undefined, undefined);
}

__init__() {
  enable_mod_staminup_perk_for_level();
}

enable_mod_staminup_perk_for_level() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_staminup", "mod_marathon", #"perk_staminup", #"specialty_staminup", 2500);
  zm_perks::function_2ae97a14(#"specialty_mod_staminup", array(#"specialty_unlimitedsprint", #"specialty_sprintfire"));
}