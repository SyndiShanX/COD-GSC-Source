/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_apartments.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\mp_apartments_amb;
#using scripts\mp\mp_apartments_fx;
#using scripts\mp\mp_apartments_lighting;
#using scripts\shared\util_shared;
#namespace mp_apartments;

function main() {
  load::main();
  mp_apartments_fx::main();
  thread mp_apartments_amb::main();
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_apartments";
  setDvar("phys_buoyancy", 1);
  setDvar("phys_ragdoll_buoyancy", 1);
  println("");
}