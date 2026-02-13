/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2748.gsc
*************************************************/

_id_1005F() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle", _id_0AAF::_id_D445);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPerkModDamage", _id_0AAF::_id_D30A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageData", _id_0AAF::_id_D446);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle", _id_0AAF::_id_D447);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageData", _id_0AAF::_id_D42B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon", _id_0AAF::_id_D42C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPreModDamageCallback", _id_0AAF::_id_D35F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setPostModDamageCallback", _id_0AAF::_id_D35C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "setDeathCallback", _id_0AAF::_id_D1AC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "giveScore", ::_id_10048);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "giveAward", ::_id_10047);
}

_id_10048(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    scripts\mp\rank::_id_CC00(var_0);
  } else {
    _id_0A9F::_id_7003(var_0, var_1);
  }
}

_id_10047(var_0, var_1, var_2) {
  thread _id_07CE::_id_8D83(var_0);

  if(!istrue(var_2)) {
    _id_07B1::_id_6FB9(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
  }
}