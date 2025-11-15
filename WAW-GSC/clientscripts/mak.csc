/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mak.csc
*****************************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();
  clientscripts\mak_fx::main();
  clientscripts\_treadfx::main("rubber_raft");
  clientscripts\_treadfx::main("type94");
  level.vehicle_treads["rubber_raft"] = true;
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\mak_amb::main();
  thread waitforclient(0);
  println("*** Client : mak running...");
}