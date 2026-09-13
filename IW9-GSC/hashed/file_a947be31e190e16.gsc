/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_a947be31e190e16.gsc
***********************************************/

_id_E6019A2D874F8C36(weaponname, _id_FC5B5CABB888A488, position, angles) {
  _id_E7CD53FCB3B3E346 = strtok(_id_FC5B5CABB888A488, "+");
  weaponobj = _id_2669878CF5A1B6BC::buildweapon(weaponname, _id_E7CD53FCB3B3E346, undefined, undefined, -1, undefined, undefined, undefined, 0);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(position, angles);
  _id_0CC708B3BF7C11ED = _id_7E52B56769FA7774::spawnpickup("brloot_weapon_generic_ar", _id_CB4FAD49263E20C4, 30, 1, weaponobj, 0, 0, 0);
  return _id_0CC708B3BF7C11ED;
}

_id_225BE5A2F4CAA3AF(weapon, position) {
  _id_811ABFDB6C33F17F = undefined;

  if(isweapon(weapon))
    _id_811ABFDB6C33F17F = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weapon);
  else if(isstring(weapon)) {
    weaponclass = scripts\mp\utility\weapon::getweapongroup(weapon);
    _id_811ABFDB6C33F17F = _id_724736FCF0FB6604::_id_A2FA56C4E1C77BA9(weaponclass);
  }

  if(!isDefined(_id_811ABFDB6C33F17F)) {
    return;
  }
  _id_9C6A94F2FB790C57 = spawnscriptable(_id_811ABFDB6C33F17F, position);
  _id_7E52B56769FA7774::registerscriptableinstance(_id_9C6A94F2FB790C57);
  return _id_9C6A94F2FB790C57;
}

_id_40F588E8C075F3A1(_id_C9F65801A0258B90) {
  weapon = level.player getcurrentweapon();
  _id_9C6A94F2FB790C57 = _id_225BE5A2F4CAA3AF(weapon, _id_C9F65801A0258B90);
  return _id_9C6A94F2FB790C57;
}

_id_198B77714911AE07(_id_2AB69F8ACCB95D4A) {
  self endon("death");
  self endon("disconnect");

  while(!self isreloading())
    waitframe();

  self[[_id_2AB69F8ACCB95D4A]]();
}

_id_D88D4F1F9CBB8512() {
  _id_7803C95645E637E1 = scripts\mp\utility\inventory::getfirstprimaryweapon();

  if(isDefined(_id_7803C95645E637E1) && _id_7803C95645E637E1.basename != "iw9_me_fists_mp")
    return 1;

  return 0;
}