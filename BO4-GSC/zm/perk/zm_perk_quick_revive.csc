/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_quick_revive.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_quick_revive;

autoexec __init__system__() {
  system::register(#"zm_perk_quick_revive", &__init__, undefined, undefined);
}

__init__() {
  enable_quick_revive_perk_for_level();
}

enable_quick_revive_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
  zm_perks::register_perk_effects(#"specialty_quickrevive", "revive_light");
  zm_perks::register_perk_init_thread(#"specialty_quickrevive", &init_quick_revive);
  zm_perks::function_b60f4a9f(#"specialty_quickrevive", #"p8_zm_vapor_altar_icon_01_quickrevive", "zombie/fx8_perk_altar_symbol_ambient_quick_revive", #"zmperksquickrevive");
  zm_perks::function_f3c80d73("zombie_perk_bottle_revive", "zombie_perk_totem_quick_revive");
}

init_quick_revive() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect[#"revive_light"] = #"zombie/fx_perk_quick_revive_zmb";
  }
}

quick_revive_client_field_func() {}

quick_revive_callback_func() {}