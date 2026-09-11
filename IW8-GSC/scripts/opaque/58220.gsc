/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58220.gsc
***********************************************/

function ref_1413f() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle", &scripts\cp\vehicles\damage_cp::set_weapon_class_mod_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPerkModDamage", &scripts\cp\vehicles\damage_cp::set_perk_mod_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageData", &scripts\cp\vehicles\damage_cp::set_weapon_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle", &scripts\cp\vehicles\damage_cp::set_weapon_hit_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageData", &scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon", &scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data_for_weapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPreModDamageCallback", &scripts\cp\vehicles\damage_cp::set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPostModDamageCallback", &scripts\cp\vehicles\damage_cp::set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setDeathCallback", &scripts\cp\vehicles\damage_cp::set_death_callback);
}