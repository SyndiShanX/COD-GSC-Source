/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\throwing_knife_mp.gsc
******************************************************/

throwing_knife_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "onGive", ::throwing_knife_mp_ongive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "onTake", ::throwing_knife_mp_ontake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "tryToPickup", ::throwing_knife_mp_trytopickup);
}

throwing_knife_mp_ongive(equipmentref, _id_CBB2B3D05E48BD27, variantid) {
  if(scripts\mp\utility\perk::_hasperk("specialty_equip_throwingKnife"))
    scripts\mp\weapons::_id_EC132C173D4532EE("specialty_equip_throwingKnife");

  if(!isDefined(variantid) && isDefined(self._id_A6DD5C7E74106CE3) && isDefined(self._id_A6DD5C7E74106CE3[equipmentref]))
    variantid = self._id_A6DD5C7E74106CE3[equipmentref];

  if(equipmentref == "equip_shuriken") {
    return;
  }
  if(isDefined(variantid) && variantid > 0)
    self.throwingknifemelee = _id_2669878CF5A1B6BC::buildweapon_blueprint("iw9_knifestab_mp", "none", "none", variantid);
  else
    self.throwingknifemelee = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845("iw9_knifestab_mp");

  scripts\mp\weapons::_id_DD1698252C31D637("specialty_equip_throwingKnife");
}

throwing_knife_mp_ontake(equipmentref, _id_CBB2B3D05E48BD27) {
  if(scripts\mp\weapons::_id_4C614E296B3A410A("specialty_equip_throwingKnife"))
    scripts\mp\weapons::_id_EC132C173D4532EE("specialty_equip_throwingKnife");

  self.throwingknifemelee = undefined;
}

throwing_knife_mp_trytopickup(equipmentref, variantid) {
  if(!isDefined(equipmentref))
    return 0;

  if(scripts\mp\equipment::hasequipment(equipmentref) && scripts\mp\equipment::getequipmentammo(equipmentref) < scripts\mp\equipment::getequipmentmaxammo(equipmentref)) {
    scripts\mp\equipment::incrementequipmentammo(equipmentref, 1, 1);
    throwing_knife_mp_ongive(equipmentref, undefined, variantid);
  } else if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(_id_600B944A95C3A7BF::_id_B88CFB4893CEEDAC(equipmentref)) && _id_2D9D24F7C63AC143::_id_8A160D9935D47F5E(equipmentref, "equipment", 1))
    _id_2D9D24F7C63AC143::_id_9D094FAC5AE6454E(equipmentref, "equipment", 1);
  else
    return 0;

  _id_5762AC2F22202BA2::hudicontype("throwingknife");
  return 1;
}