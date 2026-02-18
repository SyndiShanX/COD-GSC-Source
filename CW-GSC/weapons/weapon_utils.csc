/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\weapon_utils.csc
***********************************************/

#namespace weapons;

function ispistol(weapon) {
  return weapon.weapclass === # "pistol";
}

function isflashorstunweapon(weapon) {
  return weapon.isflash || weapon.isstun;
}

function ispunch(weapon) {
  return weapon.type == "melee" && weapon.statname == # "bare_hands";
}

function isknife(weapon) {
  return weapon.type == "melee" && (weapon.rootweapon.name == # "knife_loadout" || weapon.rootweapon.name == # "knife_held");
}

function isnonbarehandsmelee(weapon) {
  return weapon.type == "melee" && weapon.rootweapon.name != # "bare_hands";
}