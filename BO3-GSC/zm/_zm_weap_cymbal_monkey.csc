/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_cymbal_monkey.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_cymbal_monkey;

function init() {
  if(isdefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey) {
    level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
  } else {
    level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
  }
  if(!zm_weapons::is_weapon_included(getweapon("cymbal_monkey"))) {
    return;
  }
}