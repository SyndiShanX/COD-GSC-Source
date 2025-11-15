/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_weapon_utils.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace weapon_utils;

function getbaseweaponparam(weapon) {
  return (weapon.rootweapon.altweapon != level.weaponnone ? weapon.rootweapon.altweapon.rootweapon : weapon.rootweapon);
}