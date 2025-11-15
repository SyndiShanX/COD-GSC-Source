/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\see1.csc
*****************************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();
  clientscripts\_halftrack::main("vehicle_ger_tracked_halftrack");
  clientscripts\_truck::main("vehicle_ger_wheeled_opel_blitz", "opel");
  clientscripts\_t34::main("vehicle_rus_tracked_t34");
  clientscripts\_tiger::main("vehicle_ger_tracked_king_tiger");
  clientscripts\see1_fx::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\see1_amb::main();
  thread waitforclient(0);
  println("*** Client : see1 running...");
}