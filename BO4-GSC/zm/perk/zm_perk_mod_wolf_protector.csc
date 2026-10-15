/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_wolf_protector.csc
**************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;

#namespace zm_perk_mod_wolf_protector;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_wolf_protector", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarint(#"hash_4e1190045ef3588b", 0)) {
    function_27473e44();
  }
}

function_27473e44() {
  zm_perks::register_perk_clientfields(#"specialty_mod_wolf_protector", &client_field_func, &code_callback_func);
  zm_perks::register_perk_init_thread(#"specialty_mod_wolf_protector", &init);
  zm_perks::function_b60f4a9f(#"specialty_mod_wolf_protector", #"p8_zm_vapor_altar_icon_01_bloodwolf", "zombie/fx8_perk_altar_symbol_ambient_blood_wolf", #"zmperkswolfprotector");
  zm_powerups::include_zombie_powerup("wolf_bonus_points");
  zm_powerups::add_zombie_powerup("wolf_bonus_points");
}

init() {}

client_field_func() {}

code_callback_func() {}