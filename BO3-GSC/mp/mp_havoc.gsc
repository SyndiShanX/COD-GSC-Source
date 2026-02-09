/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_havoc.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_havoc_fx;
#using scripts\mp\mp_havoc_sound;
#using scripts\shared\_oob;
#using scripts\shared\compass;
#using scripts\shared\util_shared;
#namespace mp_havoc;

function main() {
  trigger = spawn("trigger_radius_out_of_bounds", (1957.05, 1538.25, -112.32), 0, 125, 350);
  trigger thread oob::run_oob_trigger();
  precache();
  mp_havoc_fx::main();
  mp_havoc_sound::main();
  load::main();
  compass::setupminimap("compass_map_mp_havoc");
  setDvar("compassmaxrange", "2100");
  level.cleandepositpoints = array((1.29624, -584.847, 136.125), (-1513.77, -791.715, 8.125), (419.803, 1107.09, 8.93066), (300.251, -1300.87, 8.125));
}

function precache() {}