/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_stronghold.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_stronghold_doors;
#using scripts\mp\mp_stronghold_fx;
#using scripts\mp\mp_stronghold_sound;
#using scripts\shared\compass;
#using scripts\shared\util_shared;
#namespace mp_stronghold;

function main() {
  precache();
  mp_stronghold_fx::main();
  mp_stronghold_sound::main();
  load::main();
  compass::setupminimap("compass_map_mp_stronghold");
  setdvar("compassmaxrange", "2100");
  spawncollision("collision_clip_wall_128x128x10", "collider", (-1072.79, -2008.87, 259.646), (340, 278, 0));
  spawncollision("collision_clip_cylinder_32x256", "collider", (831.371, -3700.67, 66.1907), (0, 0, 0));
  spawncollision("collision_clip_cylinder_32x256", "collider", (831.371, -3700.67, 217.442), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1562.71, 212.542), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1562.71, 336.31), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1562.71, 461.593), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1562.71, 585.862), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1685.79, 212.542), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1685.79, 336.31), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1685.79, 461.593), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (101.551, -1685.79, 585.862), (0, 0, 0));
  level.cleandepositpoints = array((630.863, -76.7291, -33.875), (1509.06, 742.346, 80.125), (-475.4, -272.565, -32.7665), (153.632, -2163.82, 0.222555));
  level spawnkilltrigger();
}

function precache() {}

function spawnkilltrigger() {
  trigger = spawn("trigger_radius", (-1287.41, 620.422, -252.879), 0, 128, 128);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (502.075, -3770.46, -318.012), 0, 128, 128);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (-675.645, -4010.54, -444.147), 0, 250, 128);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (-653.153, 585.412, -316.459), 0, 100, 150);
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