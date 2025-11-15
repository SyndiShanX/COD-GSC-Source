/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pel1b.csc
*****************************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();
  clientscripts\_artillery::main("artillery_jap_47mm", "at47");
  clientscripts\_sherman::main("vehicle_usa_tracked_shermanm4a3_camo");
  clientscripts\_sherman::main("vehicle_usa_tracked_shermanm4a3_camo", "sherman_flame");
  clientscripts\pel1b_fx::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\pel1b_amb::main();
  thread waitforclient(0);
  println("*** Client : pel1b running...");
}