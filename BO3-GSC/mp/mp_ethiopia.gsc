/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_ethiopia.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_ethiopia_fx;
#using scripts\mp\mp_ethiopia_sound;
#using scripts\shared\compass;
#using scripts\shared\util_shared;
#namespace mp_ethiopia;

function main() {
  precache();
  mp_ethiopia_fx::main();
  mp_ethiopia_sound::main();
  level.add_raps_drop_locations = & add_raps_drop_locations;
  load::main();
  compass::setupminimap("compass_map_mp_ethiopia");
  setdvar("compassmaxrange", "2100");
  spawncollision("collision_clip_256x256x256", "collider", (-129.888, -1884.61, 661.629), vectorscale((0, -1, 0), 7));
  spawncollision("collision_clip_256x256x256", "collider", (-129.888, -1875.59, 827.62), vectorscale((0, -1, 0), 7));
  spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 611.5), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 733.5), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 857), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 979), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 611.5), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 733.5), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 857), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 979), (0, 0, 0));
  spawncollision("collision_nosight_wall_512x512x10", "collider", (1953.84, -762.342, 16), vectorscale((0, 1, 0), 12));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-1040, -1338.5, 73.5), (4, 10, 0));
  setdvar("bot_maxmantleheight", 135);
  level.cleandepositpoints = array((301.869, 278.255, -218.677), (241.91, -1226.31, 37.6831), (1353.01, -116.183, -66.9346), (-294.319, -2288.04, 10.5979));
  level spawnkilltrigger();
}

function precache() {}

function add_raps_drop_locations( & drop_candidate_array) {
  if(!isDefined(drop_candidate_array)) {
    drop_candidate_array = [];
  } else if(!isarray(drop_candidate_array)) {
    drop_candidate_array = array(drop_candidate_array);
  }
  drop_candidate_array[drop_candidate_array.size] = (350, 650, -222);
  if(!isDefined(drop_candidate_array)) {
    drop_candidate_array = [];
  } else if(!isarray(drop_candidate_array)) {
    drop_candidate_array = array(drop_candidate_array);
  }
  drop_candidate_array[drop_candidate_array.size] = (-100, 420, -223);
  if(!isDefined(drop_candidate_array)) {
    drop_candidate_array = [];
  } else if(!isarray(drop_candidate_array)) {
    drop_candidate_array = array(drop_candidate_array);
  }
  drop_candidate_array[drop_candidate_array.size] = (2900, -140, -23);
  if(!isDefined(drop_candidate_array)) {
    drop_candidate_array = [];
  } else if(!isarray(drop_candidate_array)) {
    drop_candidate_array = array(drop_candidate_array);
  }
  drop_candidate_array[drop_candidate_array.size] = (-690, -850, 26);
}

function spawnkilltrigger() {
  trigger = spawn("trigger_radius", (-993.5, -1327.5, 0.5), 0, 50, 300);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (1824, -250, -236), 0, 32, 496);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (1742, -346, -236), 0, 128, 496);
  trigger thread watchkilltrigger();
}

function watchkilltrigger() {
  level endon("game_ended");
  trigger = self;
  while(true) {
    trigger waittill("trigger", player);
    player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
  }
}