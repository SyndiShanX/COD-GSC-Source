/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\ber1.csc
**************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();

  clientscripts\_t34::main("vehicle_rus_tracked_t34_mg", "t34_ber1");

  clientscripts\ber1_fx::main();
  thread clientscripts\_audio::audio_init(0);

  thread clientscripts\ber1_amb::main();

  clientscripts\_vehicle::build_treadfx("il2");

  thread waitforclient(0);

  println("*** Client : ber1 running...");
}