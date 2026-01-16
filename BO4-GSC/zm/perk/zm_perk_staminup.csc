/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_staminup.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_staminup;

autoexec __init__system__() {
  system::register(#"zm_perk_staminup", &__init__, undefined, undefined);
}

__init__() {
  enable_staminup_perk_for_level();
}

enable_staminup_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_staminup", &staminup_client_field_func, &staminup_callback_func);
  zm_perks::register_perk_effects(#"specialty_staminup", "marathon_light");
  zm_perks::register_perk_init_thread(#"specialty_staminup", &init_staminup);
  zm_perks::function_b60f4a9f(#"specialty_staminup", #"p8_zm_vapor_altar_icon_01_staminup", "zombie/fx8_perk_altar_symbol_ambient_staminup", #"zmperksstaminup");
  zm_perks::function_f3c80d73("zombie_perk_bottle_marathon", "zombie_perk_totem_staminup");
}

init_staminup() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect[#"marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
  }
}

staminup_client_field_func() {}

staminup_callback_func() {}