/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_damage_mp.gsc
*****************************************************/

vehicle_damage_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle", scripts\mp\vehicles\damage::set_weapon_class_mod_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPerkModDamage", scripts\mp\vehicles\damage::set_perk_mod_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageData", scripts\mp\vehicles\damage::set_weapon_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle", scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageData", scripts\mp\vehicles\damage::set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon", scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPreModDamageCallback", scripts\mp\vehicles\damage::set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPostModDamageCallback", scripts\mp\vehicles\damage::set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setDeathCallback", scripts\mp\vehicles\damage::set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "giveScore", ::vehicle_damage_givescore);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "giveAward", ::vehicle_damage_giveaward);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon", ::_id_3EBC636E964B34BE);
}

vehicle_damage_givescore(ref, objweapon, _id_0FC10BB0A0AA2990) {
  if(istrue(_id_0FC10BB0A0AA2990))
    scripts\mp\rank::scoreeventpopup(ref);
  else
    scripts\mp\utility\points::_id_0366980B6A8796AE(ref, objweapon);
}

vehicle_damage_giveaward(ref, objweapon, _id_0FC10BB0A0AA2990) {
  thread scripts\mp\events::killeventtextpopup(ref);

  if(!istrue(_id_0FC10BB0A0AA2990))
    scripts\mp\utility\points::_id_0366980B6A8796AE(ref, objweapon);
}

_id_3EBC636E964B34BE(weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, vehiclename) {
  if(isDefined(weaponhitsperattack))
    scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(weaponname, weaponhitsperattack, vehiclename);

  if(isDefined(_id_8B4500D6A881B7B2))
    scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(vehiclename, _id_8B4500D6A881B7B2, weaponname);
}