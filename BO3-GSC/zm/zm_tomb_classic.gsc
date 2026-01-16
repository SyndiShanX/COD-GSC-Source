/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_classic.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_game_module;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\gametypes\_zm_gametype;
#using scripts\zm\zm_tomb_craftables;
#namespace zm_tomb_classic;

function precache() {
  zm_craftables::init();
  zm_tomb_craftables::randomize_craftable_spawns();
  zm_tomb_craftables::include_craftables();
  zm_tomb_craftables::init_craftables();
}

function main() {
  zm_game_module::set_current_game_module(level.game_module_standard_index);
  level thread zm_craftables::think_craftables();
  level flag::wait_till("initial_blackscreen_passed");
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