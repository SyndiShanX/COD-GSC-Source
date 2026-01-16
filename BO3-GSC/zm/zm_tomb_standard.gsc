/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_standard.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_game_module;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\gametypes\_zm_gametype;
#namespace namespace_a026fc99;

function precache() {}

function main() {
  level flag::wait_till("initial_blackscreen_passed");
  level flag::set("power_on");
  zm_treasure_chest_init();
}

function zm_treasure_chest_init() {
  chest1 = struct::get("start_chest", "script_noteworthy");
  level.chests = [];
  if(!isdefined(level.chests)) {
    level.chests = [];
  } else if(!isarray(level.chests)) {
    level.chests = array(level.chests);
  }
  level.chests[level.chests.size] = chest1;
  zm_magicbox::treasure_chest_init("start_chest");
}