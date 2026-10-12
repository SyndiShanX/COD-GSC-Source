/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\throwstar_mp.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\weapon;
#namespace throwstar_mp;

function function_12d7ca3ff609caba() {
  registersharedfunc("throwStar", "onGive", &function_e7715ffb329c1b40);
  registersharedfunc("throwStar", "onTake", &function_92e126d1a5d3fb2);
  registersharedfunc("throwstar", "tryToPickup", &function_94dcdd399513b2ce);
}

function function_e7715ffb329c1b40(equipmentref, equipmentslot, variantid) {}

function function_92e126d1a5d3fb2(equipmentref, equipmentslot) {}

function function_94dcdd399513b2ce(equipmentref) {
  if(!isDefined(equipmentref)) {
    self iprintlnbold("<dev string:x1c>");

    return false;
  }

  if(scripts\mp\equipment::hasequipment(equipmentref) && scripts\mp\equipment::getequipmentammo(equipmentref) < scripts\mp\equipment::getequipmentmaxammo(equipmentref)) {
    scripts\mp\equipment::incrementequipmentammo(equipmentref);
  } else if(namespace_aead94004cf4c147::function_7e103028c464ab9a(scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(equipmentref)) && namespace_aead94004cf4c147::function_8a160d9935d47f5e(equipmentref, "equipment", 1)) {
    namespace_aead94004cf4c147::additemtobackpackbyref(equipmentref, "equipment", 1);
  } else {
    return false;
  }

  hudicontype("throwstar");
  return true;
}