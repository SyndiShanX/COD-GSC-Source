/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_magic_box.gsc
********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

magic_box_init() {
  level thread _update_magic_box_indicators();
  level thread _watch_fire_sale();
}

_update_magic_box_indicators() {
  wait_for_all_players();
  while(true) {
    flag_wait("moving_chest_now");
    while(flag("moving_chest_now")) {
      wait(0.1);
    }
  }
}

_watch_fire_sale() {
  while(1) {
    level waittill("powerup fire sale");
    level waittill("fire_sale_off");
  }
}

_get_current_chest() {
  return level.chests[level.chest_index].script_noteworthy;
}