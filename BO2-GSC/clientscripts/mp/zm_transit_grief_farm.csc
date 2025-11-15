/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zm_transit_grief_farm.csc
*******************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_weapons;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zombies\_zm;
#include clientscripts\mp\zombies\_zm_game_mode_objects;

main() {
  level thread clientscripts\mp\zombies\_zm::init_perk_machines_fx();
  clientscripts\mp\zombies\_zm_game_mode_objects::gamemode_common_setup("grief", "farm", "zm_transit_farm_ext", 1);
}