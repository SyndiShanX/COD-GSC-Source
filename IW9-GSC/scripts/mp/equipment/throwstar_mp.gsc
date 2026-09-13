/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\throwstar_mp.gsc
*************************************************/

_id_12D7CA3FF609CABA() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwStar", "onGive", ::_id_E7715FFB329C1B40);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwStar", "onTake", ::_id_092E126D1A5D3FB2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwstar", "tryToPickup", ::_id_94DCDD399513B2CE);
}

_id_E7715FFB329C1B40(equipmentref, _id_CBB2B3D05E48BD27, variantid) {}

_id_092E126D1A5D3FB2(equipmentref, _id_CBB2B3D05E48BD27) {}

_id_94DCDD399513B2CE(equipmentref) {
  if(!isDefined(equipmentref))
    return 0;

  if(scripts\mp\equipment::hasequipment(equipmentref) && scripts\mp\equipment::getequipmentammo(equipmentref) < scripts\mp\equipment::getequipmentmaxammo(equipmentref))
    scripts\mp\equipment::incrementequipmentammo(equipmentref);
  else if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(_id_600B944A95C3A7BF::_id_B88CFB4893CEEDAC(equipmentref)) && _id_2D9D24F7C63AC143::_id_8A160D9935D47F5E(equipmentref, "equipment", 1))
    _id_2D9D24F7C63AC143::_id_9D094FAC5AE6454E(equipmentref, "equipment", 1);
  else
    return 0;

  _id_5762AC2F22202BA2::hudicontype("throwstar");
  return 1;
}