/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zm_transit_turned_diner.csc
***********************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_weapons;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zombies\_zm_game_mode_objects;

main() {
  level thread clientscripts\mp\zombies\_zm_game_mode_objects::init_game_mode_objects("turned", "diner");
  setdvar("aim_target_player_enabled", 1);
}