/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_weap_riotshield_tomb.csc
*****************************************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_fx;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zombies\_zm_weapons;

init() {
  if(getdvar(#"createfx") == "on") {
    return;
  }
  if(!clientscripts\mp\zombies\_zm_weapons::is_weapon_included("tomb_shield_zm")) {
    return;
  }
  level thread player_init();
}

player_init() {
  waitforclient(0);
  players = getlocalplayers();

  for(i = 0; i < players.size; i++)
    player = players[i];
}