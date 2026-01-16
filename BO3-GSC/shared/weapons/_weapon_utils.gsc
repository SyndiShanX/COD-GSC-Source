/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_weapon_utils.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace weapon_utils;

function ispistol(weapon) {
  return isdefined(level.side_arm_array[weapon]);
}

function isflashorstunweapon(weapon) {
  return weapon.isflash || weapon.isstun;
}

function isflashorstundamage(weapon, meansofdeath) {
  return isflashorstunweapon(weapon) && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GAS");
}

function ismeleemod(mod) {
  return mod == "MOD_MELEE" || mod == "MOD_MELEE_WEAPON_BUTT" || mod == "MOD_MELEE_ASSASSINATE";
}

function ispunch(weapon) {
  return weapon.type == "melee" && weapon.rootweapon.name == "bare_hands";
}

function isknife(weapon) {
  return weapon.type == "melee" && weapon.rootweapon.name == "knife_loadout";
}

function isnonbarehandsmelee(weapon) {
  return weapon.type == "melee" && weapon.rootweapon.name != "bare_hands" || weapon.isballisticknife;
}