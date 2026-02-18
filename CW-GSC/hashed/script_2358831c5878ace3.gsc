/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2358831c5878ace3.gsc
***********************************************/

#namespace weapons;

function function_251ec78c(weapon = level.weaponnone, var_a4bc20c2 = 1) {
  if(is_true(weapon.isaltmode)) {
    baseweapon = weapon.altweapon;
  } else if(is_true(weapon.var_bf0eb41)) {
    baseweapon = weapon.dualwieldweapon;
  } else if(var_a4bc20c2) {
    baseweapon = getweapon(weapon.statname, weapon.attachments);
  } else {
    baseweapon = getweapon(weapon.name, weapon.attachments);
  }

  if(level.weaponnone == baseweapon) {
    baseweapon = weapon;
  }

  baseweapon = function_eeddea9a(baseweapon, function_9f1cc9a9(weapon));
  return baseweapon;
}

function getbaseweapon(weapon) {
  baseweapon = function_251ec78c(weapon);
  return baseweapon.rootweapon;
}