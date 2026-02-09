/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_weapon_box.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  level.wepbox = GetEnt("weapon_box", "targetname");
  if(!isDefined(level.wepbox)) {
    return;
  }
  level.wepbox setHintString(&"ZOMBIE_WEAPON_BOX_OPEN");
  level.wepbox_players = [];
  for(i = 0; i < 4; i++) {
    level.wepbox_players[i] = "empty";
  }
  level.wepbox thread weapon_box_update();
}
weapon_box_update() {
  while(1) {
    self waittill("trigger", player);
    wait(1.0);
  }
}