/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\throwing_knife_mp.gsc
*********************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace throwing_knife_mp;

function throwing_knife_mp_init() {
  registersharedfunc("throwing_knife", "onGive", &throwing_knife_mp_ongive);
  registersharedfunc("throwing_knife", "onTake", &throwing_knife_mp_ontake);
  registersharedfunc("throwing_knife", "tryToPickup", &throwing_knife_mp_trytopickup);
}

function throwing_knife_mp_ongive(equipmentref, equipmentslot, variantid) {
  if(_hasperk("specialty_equip_throwingKnife")) {
    scripts\mp\weapons::function_ec132c173d4532ee("specialty_equip_throwingKnife");
  }

  if(!isDefined(variantid) && isDefined(self.var_a6dd5c7e74106ce3) && isDefined(self.var_a6dd5c7e74106ce3[equipmentref])) {
    variantid = self.var_a6dd5c7e74106ce3[equipmentref];
  }

  if(equipmentref == "equip_shuriken") {
    return;
  }

  if(isDefined(variantid) && variantid > 0) {
    self.throwingknifemelee = scripts\cp_mp\weapon::buildweapon_blueprint("iw9_knifestab_mp", "none", "none", variantid);
  } else {
    self.throwingknifemelee = function_eeaa22f0cd1ff845("iw9_knifestab_mp");
  }

  scripts\mp\weapons::weapon_giveperk("specialty_equip_throwingKnife");
}

function throwing_knife_mp_ontake(equipmentref, equipmentslot) {
  if(scripts\mp\weapons::weapon_hasperk("specialty_equip_throwingKnife")) {
    scripts\mp\weapons::function_ec132c173d4532ee("specialty_equip_throwingKnife");
  }

  self.throwingknifemelee = undefined;
}

function throwing_knife_mp_trytopickup(equipmentref, variantid) {
  if(!isDefined(equipmentref)) {
    self iprintlnbold("<dev string:x1c>");

    return false;
  }

  if(scripts\mp\equipment::hasequipment(equipmentref) && scripts\mp\equipment::getequipmentammo(equipmentref) < scripts\mp\equipment::getequipmentmaxammo(equipmentref)) {
    scripts\mp\equipment::incrementequipmentammo(equipmentref, 1, undefined, 1);
    throwing_knife_mp_ongive(equipmentref, undefined, variantid);
  } else if(namespace_aead94004cf4c147::function_7e103028c464ab9a(scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(equipmentref)) && namespace_aead94004cf4c147::function_8a160d9935d47f5e(equipmentref, "equipment", 1)) {
    namespace_aead94004cf4c147::additemtobackpackbyref(equipmentref, "equipment", 1);
  } else {
    return false;
  }

  hudicontype("throwingknife");
  return true;
}

function function_4d6d6bc790611975(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_be4285b26ed99ab1, unmodifieddamage, partname, var_1da1a66b5c6a06a7) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  if(objweapon.basename == "jup_jp23_me_spear_mp") {
    var_1841e6c16aa6ce41 = spawnStruct();
    var_1841e6c16aa6ce41.var_947ae0321588cb2e = 1;
    var_1841e6c16aa6ce41.var_5e4f661ca09750d8 = 2;
    var_1841e6c16aa6ce41.var_65bf5b5f2601ced1 = 1;
    var_1841e6c16aa6ce41.var_a1d921d11e0991fd = 2;
    var_1841e6c16aa6ce41.var_fedb584266557d46 = 150;
  } else {
    var_1841e6c16aa6ce41 = einflictor.bundle;
  }

  healthdamage = 0;
  partname = scripts\cp_mp\utility\damage_utility::function_edefa1e693dd3c7d(partname);

  if(scripts\mp\utility\player::isinlaststand(victim)) {
    if(isDefined(victim.maxarmorhealth)) {
      idamage = victim.maxhealth + victim.maxarmorhealth;
    } else {
      idamage = victim.maxhealth;
    }
  } else if(function_b656251147d7d40b(partname) && istrue(var_1841e6c16aa6ce41.var_947ae0321588cb2e)) {
    idamage = int(var_1841e6c16aa6ce41.var_fedb584266557d46 * var_1841e6c16aa6ce41.var_5e4f661ca09750d8);
  } else if(function_dcdde2598f1bdfc0(partname) && istrue(var_1841e6c16aa6ce41.var_65bf5b5f2601ced1)) {
    idamage = int(var_1841e6c16aa6ce41.var_fedb584266557d46 * var_1841e6c16aa6ce41.var_a1d921d11e0991fd);
  } else {
    idamage = var_1841e6c16aa6ce41.var_fedb584266557d46;
  }

  if(victim.armorhealth > 0 && idamage <= victim.armorhealth) {
    var_1da1a66b5c6a06a7 = idamage;
  } else {
    healthdamage = idamage - var_1da1a66b5c6a06a7;
  }

  return [healthdamage, var_1da1a66b5c6a06a7];
}

function function_3ea0bf8465c74efc(victim, partname) {
  if(scripts\cp_mp\utility\damage_utility::function_b656251147d7d40b(partname)) {
    if(isDefined(victim)) {
      victim.var_21d6bd6b0d89a70c = 1;
    }

    return;
  }

  if(isDefined(victim)) {
    victim.var_21d6bd6b0d89a70c = undefined;
  }
}