/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_additionalprimaryweapon.csc
*******************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_additionalprimaryweapon;

autoexec __init__system__() {
  system::register(#"zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

__init__() {
  enable_additional_primary_weapon_perk_for_level();
  zm_perks::function_f3c80d73("zombie_perk_bottle_additionalprimaryweapon", "zombie_perk_totem_mule_kick");
}

enable_additional_primary_weapon_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_additionalprimaryweapon", &additional_primary_weapon_client_field_func, &additional_primary_weapon_code_callback_func);
  zm_perks::register_perk_effects(#"specialty_additionalprimaryweapon", "additionalprimaryweapon_light");
  zm_perks::register_perk_init_thread(#"specialty_additionalprimaryweapon", &init_additional_primary_weapon);
  zm_perks::function_b60f4a9f(#"specialty_additionalprimaryweapon", #"p8_zm_vapor_altar_icon_01_mulekick", "zombie/fx8_perk_altar_symbol_ambient_mule_kick", #"zmperksmulekick");
}

init_additional_primary_weapon() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect[#"additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
  }
}

additional_primary_weapon_client_field_func() {
  clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int", undefined, 0, 1);
}

additional_primary_weapon_code_callback_func() {}