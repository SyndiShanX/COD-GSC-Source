/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pel2.csc
*****************************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();
  clientscripts\_truck::main("vehicle_jap_wheeled_type94", "model94");
  clientscripts\_sherman::main("vehicle_usa_tracked_shermanm4a3_green");
  clientscripts\_type97::main("vehicle_jap_tracked_type97shinhoto");
  clientscripts\_triple25::main("artillery_jap_triple25mm");
  clientscripts\_artillery::main("artillery_jap_47mm", "at47");
  clientscripts\pel2_fx::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\pel2_amb::main();
  clientscripts\_vehicle::build_treadfx("corsair");
  thread waitforclient(0);
  println("*** Client : pel2 running...");
}