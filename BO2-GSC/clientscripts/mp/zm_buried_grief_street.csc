/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zm_buried_grief_street.csc
*********************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_weapons;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zm_buried_buildables;
#include clientscripts\mp\zombies\_zm;
#include clientscripts\mp\zombies\_zm_game_mode_objects;

premain() {
  griefbuildables = array("chalk", "turbine", "springpad_zm", "subwoofer_zm");
  clientscripts\mp\zm_buried_buildables::include_buildables(griefbuildables);
  clientscripts\mp\zm_buried_buildables::init_buildables(griefbuildables);
}

main() {
  level thread clientscripts\mp\zombies\_zm::init_perk_machines_fx();
  clientscripts\mp\zombies\_zm_game_mode_objects::gamemode_common_setup("grief", "street", "zone_street", 1);
}