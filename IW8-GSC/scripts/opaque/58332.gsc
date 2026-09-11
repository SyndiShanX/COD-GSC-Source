/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58332.gsc
***********************************************/

function ref_14161() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle", &scripts\mp\vehicles\damage::set_weapon_class_mod_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPerkModDamage", &scripts\mp\vehicles\damage::set_perk_mod_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageData", &scripts\mp\vehicles\damage::set_weapon_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle", &scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageData", &scripts\mp\vehicles\damage::set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon", &scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPreModDamageCallback", &scripts\mp\vehicles\damage::set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPostModDamageCallback", &scripts\mp\vehicles\damage::set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setDeathCallback", &scripts\mp\vehicles\damage::set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "giveScore", &ref_14154);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "giveAward", &ref_14153);
}

function ref_14154(var0, var1, var2) {
  if(istrue(var2)) {
    scripts\mp\rank::scoreeventpopup(var0);
    return;
  }

  scripts\mp\utility\points::giveunifiedpoints(var0, var1);
}

function ref_14153(var0, var1, var2) {
  thread scripts\mp\events::killeventtextpopup(var0);

  if(!istrue(var2)) {
    scripts\mp\awards::givemidmatchaward(var0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var1);
    return;
  }
}