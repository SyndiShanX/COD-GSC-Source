/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_seelow.csc
*****************************************************/

#include clientscripts\mp\_utility;

main() {
  level.allies_team = "russian";
  level.axis_team = "german";
  clientscripts\mp\_panzeriv::main("vehicle_ger_tracked_panzer4_mp");
  clientscripts\mp\_t34::main("vehicle_rus_tracked_t34_mp");
  clientscripts\mp\_load::main();
  clientscripts\mp\mp_seelow_fx::main();
  thread clientscripts\mp\_fx::fx_init(0);
  thread clientscripts\mp\_audio::audio_init(0);
  thread clientscripts\mp\mp_seelow_amb::main();
  thread waitforclient(0);
  println("*** Client : mp_seelow running...");
}