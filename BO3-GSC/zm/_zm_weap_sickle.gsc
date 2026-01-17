/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_sickle.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_sickle;

function autoexec __init__sytem__() {
  system::register("sickle", &__init__, &__main__, undefined);
}

function private __init__() {}

function private __main__() {
  if(isDefined(level.var_c81f7742)) {
    cost = level.var_c81f7742;
  } else {
    cost = 3000;
  }
  prompt = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
  if(!(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)) {
    prompt = &"DLC5_WEAPON_SICKLE_BUY";
  }
  zm_melee_weapon::init("sickle_knife", "sickle_flourish", "knife_ballistic_sickle", "knife_ballistic_sickle_upgraded", cost, "sickle_upgrade", prompt, "sickle", undefined);
  zm_melee_weapon::set_fallback_weapon("sickle_knife", "zombie_fists_sickle");
  zm_weapons::add_retrievable_knife_init_name("knife_ballistic_sickle");
  zm_weapons::add_retrievable_knife_init_name("knife_ballistic_sickle_upgraded");
}

function init() {}