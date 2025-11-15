/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_plunger.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_plunger;

function autoexec __init__sytem__() {
  system::register("plunger_knife", & __init__, & __main__, undefined);
}

function private __init__() {}

function private __main__() {
  cost = 3000;
  zm_melee_weapon::init("knife_plunger", "zombie_plunger_flourish", undefined, undefined, cost, "bowie_upgrade", & "ZMWEAPON_NONE", "plunger", undefined);
  zm_melee_weapon::set_fallback_weapon("knife_plunger", "zombie_fists_plunger");
}

function init() {}