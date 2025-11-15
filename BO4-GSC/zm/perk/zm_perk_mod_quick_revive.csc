/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_quick_revive.csc
************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_quick_revive;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_quick_revive", &__init__, undefined, undefined);
}

__init__() {
  enable_quick_revive_perk_for_level();
}

enable_quick_revive_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_mod_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
}

quick_revive_client_field_func() {}

quick_revive_callback_func() {}