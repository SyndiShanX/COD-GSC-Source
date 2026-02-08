/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\oki3.csc
**************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();

  clientscripts\oki3_fx::main();
  thread clientscripts\_audio::audio_init(0);

  thread clientscripts\oki3_amb::main();

  thread waitforclient(0);

  println("*** Client : oki3 running...");
}