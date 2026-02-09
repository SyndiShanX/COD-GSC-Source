/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_freerun_01.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_freerun_01_fx;
#using scripts\mp\mp_freerun_01_sound;
#using scripts\shared\util_shared;
#namespace namespace_49ee819c;

function main() {
  namespace_b046f355::main();
  namespace_db5bc658::main();
  setDvar("phys_buoyancy", 1);
  setDvar("phys_ragdoll_buoyancy", 1);
  load::main();
  util::waitforclient(0);
}