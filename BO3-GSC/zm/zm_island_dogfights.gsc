/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_dogfights.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace zm_island_dogfights;

function init() {
  clientfield::register("world", "play_dogfight_scenes", 9000, 3, "int");
}

function main() {
  if(getdvarint("splitscreen_playerCount") >= 3) {
    return;
  }
  level waittill("hash_5574fd9b");
  level thread function_5daf587e();
  level thread function_2737bcd8();
  level thread function_99236d51();
  level thread function_b9d547c();
  level clientfield::set("play_dogfight_scenes", 0);
  level clientfield::set("play_dogfight_scenes", 5);
}

function function_5daf587e() {
  wait(4);
  level clientfield::set("play_dogfight_scenes", 1);
}

function function_2737bcd8() {
  level flag::wait_till_any(array("connect_swamp_to_swamp_lab", "connect_swamp_lab_to_bunker_exterior"));
  level clientfield::set("play_dogfight_scenes", 2);
}

function function_99236d51() {
  level flag::wait_till_any(array("connect_jungle_to_jungle_lab", "connect_jungle_lab_to_bunker_exterior"));
  wait(2);
  level clientfield::set("play_dogfight_scenes", 3);
}

function function_b9d547c() {
  level flag::wait_till("connect_bunker_interior_to_bunker_upper");
  wait(2);
  level clientfield::set("play_dogfight_scenes", 4);
}