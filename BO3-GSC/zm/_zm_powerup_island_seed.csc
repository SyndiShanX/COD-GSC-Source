/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_island_seed.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_powerup_island_seed;

function autoexec __init__sytem__() {
  system::register("zm_powerup_island_seed", &__init__, undefined, undefined);
}

function __init__() {
  register_clientfields();
  zm_powerups::include_zombie_powerup("island_seed");
  zm_powerups::add_zombie_powerup("island_seed");
}

function register_clientfields() {
  clientfield::register("toplayer", "has_island_seed", 1, 2, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_seed_parts", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "bucket_seed_01", 9000, 1, "int", &zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "bucket_seed_02", 9000, 1, "int", &zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "bucket_seed_03", 9000, 1, "int", &zm_utility::setinventoryuimodels, 0, 1);
}