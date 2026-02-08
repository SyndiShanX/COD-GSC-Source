/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pel1a.csc
**************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();

  clientscripts\pel1a_fx::main();
  thread clientscripts\_audio::audio_init(0);

  thread clientscripts\pel1a_amb::main();

  clientscripts\_vehicle::build_treadfx("corsair");

  thread waitforclient(0);

  println("*** Client : pel1a running...");
}