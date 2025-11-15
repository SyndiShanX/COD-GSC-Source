/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_ffotd.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#namespace zm_stalingrad_ffotd;

function main_start() {
  spawncollision("collision_player_wall_256x256x10", "collider", (988, 3524, 380), vectorscale((0, 1, 0), 90));
  spawncollision("collision_player_wall_256x256x10", "collider", (988, 3524, 636), vectorscale((0, 1, 0), 90));
  spawncollision("collision_player_64x64x128", "collider", (-1184, 2947, 224), vectorscale((0, -1, 0), 45));
  spawncollision("collision_player_64x64x128", "collider", (-1224, 2971, 224), vectorscale((0, -1, 0), 17));
}

function main_end() {
  level function_30409839();
}

function function_30409839() {
  var_5d655ddb = struct::get_array("intermission", "targetname");
  foreach(var_13e6937b in var_5d655ddb) {
    if(var_13e6937b.origin == (-3106, 2242, 653)) {
      var_13e6937b struct::delete();
      return;
    }
  }
}