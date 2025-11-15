/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_dig.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#namespace zm_tomb_dig;

function init() {
  clientfield::register("world", "player0hasItem", 15000, 2, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "player1hasItem", 15000, 2, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "player2hasItem", 15000, 2, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "player3hasItem", 15000, 2, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "player0wearableItem", 15000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "player1wearableItem", 15000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "player2wearableItem", 15000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "player3wearableItem", 15000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
}