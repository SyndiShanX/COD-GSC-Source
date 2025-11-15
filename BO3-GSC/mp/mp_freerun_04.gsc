/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_freerun_04.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_freerun_04_fx;
#using scripts\mp\mp_freerun_04_sound;
#using scripts\shared\util_shared;
#namespace namespace_d7e71261;

function main() {
  precache();
  namespace_c68b7fb6::main();
  namespace_8a3acb29::main();
  load::main();
  setdvar("glassMinVelocityToBreakFromJump", "380");
  setdvar("glassMinVelocityToBreakFromWallRun", "180");
  setdvar("compassmaxrange", "2100");
}

function precache() {}