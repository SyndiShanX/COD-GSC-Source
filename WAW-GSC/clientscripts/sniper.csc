/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\sniper.csc
**************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();

  clientscripts\sniper_fx::main();
  thread clientscripts\_audio::audio_init(0);

  thread clientscripts\sniper_amb::main();

  clientscripts\_truck::main("vehicle_ger_wheeled_opel_blitz", "opel");
  clientscripts\_halftrack::main("vehicle_ger_tracked_halftrack", "halftrack");
  clientscripts\_panzeriv::main("vehicle_ger_tracked_panzer4v1", "panzeriv");
  clientscripts\_jeep::main("vehicle_ger_wheeled_horch1a_backseat", "horch");

  thread waitforclient(0);
}