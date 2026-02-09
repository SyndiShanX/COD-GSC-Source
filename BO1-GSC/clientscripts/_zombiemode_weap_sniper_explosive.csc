/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_weap_sniper_explosive\.csc
***************************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;

init() {
  if(getDvar(#"createfx") == "on") {
    return;
  }
  if(!clientscripts\_zombiemode_weapons::is_weapon_included("sniper_explosive_zm")) {
    return;
  }
  level._ZOMBIE_ACTOR_FLAG_SNIPER_EXPLOSIVE_DEATH = 13;
  register_clientflag_callback("actor", level._ZOMBIE_ACTOR_FLAG_SNIPER_EXPLOSIVE_DEATH, ::sniper_explosive_death_response);
  level._effect["sniper_explosive_death_mist"] = loadfx("maps/zombie/fx_zmb_coast_jackal_death");
  level thread player_init();
}
player_init() {
  waitforclient(0);
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
  }
}
sniper_explosive_death_response(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(!set) {
    return;
  }
  tag_pos = self gettagorigin("J_SpineLower");
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    self clientscripts\_zombiemode::deleteZombieEyes(i);
    playFX(i, level._effect["sniper_explosive_death_mist"], tag_pos);
  }
}