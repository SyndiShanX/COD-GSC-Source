/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_bowie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_bowie;

function autoexec __init__sytem__() {
  system::register("bowie_knife", & __init__, & __main__, undefined);
}

function private __init__() {}

function private __main__() {
  if(isDefined(level.bowie_cost)) {
    cost = level.bowie_cost;
  } else {
    cost = 3000;
  }
  prompt = & "ZOMBIE_WEAPONCOSTONLY_CFILL";
  if(!(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)) {
    prompt = & "ZOMBIE_WEAPON_BOWIE_BUY";
  }
  zm_melee_weapon::init("bowie_knife", "bowie_flourish", "knife_ballistic_bowie", "knife_ballistic_bowie_upgraded", cost, "bowie_upgrade", prompt, "bowie", undefined);
  zm_melee_weapon::set_fallback_weapon("bowie_knife", "zombie_fists_bowie");
  zm_weapons::add_retrievable_knife_init_name("knife_ballistic_bowie");
  zm_weapons::add_retrievable_knife_init_name("knife_ballistic_bowie_upgraded");
}

function init() {}