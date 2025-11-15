/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_freerun_02.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_freerun_02_fx;
#using scripts\mp\mp_freerun_02_sound;
#using scripts\shared\util_shared;
#namespace namespace_bbf5f0d7;

function main() {
  namespace_97daed88::main();
  namespace_e89da2ff::main();
  setdvar("phys_buoyancy", 1);
  setdvar("phys_ragdoll_buoyancy", 1);
  load::main();
  util::waitforclient(0);
}