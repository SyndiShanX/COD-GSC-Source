/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weapon.gsc
***********************************************/

_id_E83615F8A92E4378(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0) {
  if(_id_2B7981CBC7CA24B4(_id_AB501F397D3CD312)) {
    return;
  }
  return _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0);
}

_id_2B7981CBC7CA24B4(_id_9A924E440AD63299) {
  if(getdvarint("dvar_0216DA3534A88C00", 0))
    return 0;

  if(getsubstr(_id_9A924E440AD63299, 0, 4) == "iw8_")
    return 1;

  return 0;
}

has_weapon_variation(weapon) {
  _id_BC002676438672C9 = self getweaponslistall();
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  foreach(primaryweapon in _id_BC002676438672C9) {
    baseweapon = scripts\cp\utility::getrawbaseweaponname(weaponname);
    _id_442713EFDF839B74 = scripts\cp\utility::getrawbaseweaponname(primaryweapon);

    if(baseweapon == _id_442713EFDF839B74)
      return 1;
  }

  return 0;
}

get_weapon_level(weapon) {
  if(!isPlayer(self))
    return int(1);

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(isDefined(self.pap[weaponname]))
    return self.pap[weaponname].lvl;

  _id_9211CDAADB7BCA55 = scripts\cp\utility::getrawbaseweaponname(weaponname);

  if(isDefined(self.pap[_id_9211CDAADB7BCA55]))
    return self.pap[_id_9211CDAADB7BCA55].lvl;

  return int(1);
}

debug_line(start, end, duration, color) {
  if(!isDefined(color))
    color = (1, 1, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < duration * 20; _id_AC0E594AC96AA3A8++)
    wait 0.05;
}