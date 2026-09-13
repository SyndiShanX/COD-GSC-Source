/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\throwing_knife_cp.gsc
******************************************************/

throwing_knife_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "tryToPickup", ::throwing_knife_cp_trytopickup);
}

_id_E12D03BB90954276(equipmentref) {
  if(_id_7EF95BBA57DC4B82::hasequipment("equip_throwing_knife"))
    _id_019CD48B2DAF2547 = "equip_throwing_knife";
  else if(_id_7EF95BBA57DC4B82::hasequipment("equip_throwing_knife_fire"))
    _id_019CD48B2DAF2547 = "equip_throwing_knife_fire";
  else
    return 0;

  _id_CAF75C2BA47B7261 = _id_7EF95BBA57DC4B82::getequipmentammo(_id_019CD48B2DAF2547);
  _id_9B4FB988B660EB30 = _id_7EF95BBA57DC4B82::getequipmentmaxammo(_id_019CD48B2DAF2547);

  if(_id_CAF75C2BA47B7261 + 1 > _id_9B4FB988B660EB30)
    return 0;

  _id_CAF75C2BA47B7261 = int(min(_id_CAF75C2BA47B7261 + 1, _id_9B4FB988B660EB30));
  _id_7EF95BBA57DC4B82::setequipmentammo(_id_019CD48B2DAF2547, _id_CAF75C2BA47B7261);
  _id_354C862768CFE202::hudicontype("throwingknife");
  return 1;
}

throwing_knife_cp_trytopickup(equipmentref) {
  if(_id_7EF95BBA57DC4B82::hasequipment(equipmentref) && _id_7EF95BBA57DC4B82::getequipmentammo(equipmentref) < _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipmentref))
    _id_7EF95BBA57DC4B82::incrementequipmentammo(equipmentref);
  else if(_id_66122A002AFF5D57::_id_8B121DD10A442DD2() && _id_66122A002AFF5D57::_id_8A160D9935D47F5E(equipmentref, "equipment", 1))
    _id_66122A002AFF5D57::_id_9D094FAC5AE6454E(equipmentref, "equipment", 1);
  else
    return 0;

  if(equipmentref == "equip_throwing_knife_fire")
    _id_5762AC2F22202BA2::hudicontype("throwingknife_fire");
  else
    _id_5762AC2F22202BA2::hudicontype("throwingknife");

  return 1;
}