/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_drum.csc
****************************************/

#include clientscripts\mp\_utility;

main() {
  clientscripts\mp\_load::main();
  clientscripts\mp\mp_drum_fx::main();
  thread clientscripts\mp\_fx::fx_init(0);

  thread clientscripts\mp\_audio::audio_init(0);
  thread clientscripts\mp\mp_drum_amb::main();

  thread waitforclient(0);

  println("*** Client : mp_drum running...");
}