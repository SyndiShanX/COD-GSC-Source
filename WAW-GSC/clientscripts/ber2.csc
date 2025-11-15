/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\ber2.csc
*****************************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();
  clientscripts\ber2_fx::main();
  clientscripts\_t34::main("vehicle_rus_tracked_t34", "t34_wet");
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\ber2_amb::main();
  thread waitforclient(0);
  println("*** Client : ber2 running...");
}