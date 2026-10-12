/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\throwing_knife_cp.gsc
******************************************************/



#using scripts\common\utility;
#using scripts\cp\damagefeedback;
#using scripts\cp\pickups;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;
#namespace throwing_knife_cp;

function throwing_knife_cp_init() {
  scripts\engine\utility::registersharedfunc("throwing_knife", "tryToPickup", &throwing_knife_cp_trytopickup);
}

function function_e12d03bb90954276(equipmentref) {
  if(scripts\cp_mp\equipment::hasequipment("equip_throwing_knife")) {
    equipment_name = "equip_throwing_knife";
  } else if(scripts\cp_mp\equipment::hasequipment("equip_throwing_knife_fire")) {
    equipment_name = "equip_throwing_knife_fire";
  } else {
    return false;
  }

  var_caf75c2ba47b7261 = scripts\cp_mp\equipment::getequipmentammo(equipment_name);
  var_9b4fb988b660eb30 = scripts\cp_mp\equipment::getequipmentmaxammo(equipment_name);

  if(var_caf75c2ba47b7261 + 1 > var_9b4fb988b660eb30) {
    return false;
  }

  var_caf75c2ba47b7261 = int(min(var_caf75c2ba47b7261 + 1, var_9b4fb988b660eb30));
  scripts\cp_mp\equipment::setequipmentammo(equipment_name, var_caf75c2ba47b7261);
  scripts\cp\damagefeedback::hudicontype("throwingknife");
  return true;
}

function throwing_knife_cp_trytopickup(equipmentref) {
  if(scripts\cp_mp\equipment::hasequipment(equipmentref) && scripts\cp_mp\equipment::getequipmentammo(equipmentref) < scripts\cp_mp\equipment::getequipmentmaxammo(equipmentref)) {
    scripts\cp_mp\equipment::incrementequipmentammo(equipmentref);
  } else if(scripts\cp\pickups::isbackpackinventoryenabled() && scripts\cp\pickups::function_8a160d9935d47f5e(equipmentref, "equipment", 1)) {
    scripts\cp\pickups::additemtobackpackbyref(equipmentref, "equipment", 1);
  } else {
    return false;
  }

  if(equipmentref == "equip_throwing_knife_fire") {
    scripts\cp_mp\damagefeedback::hudicontype("throwingknife_fire");
  } else {
    scripts\cp_mp\damagefeedback::hudicontype("throwingknife");
  }

  return true;
}