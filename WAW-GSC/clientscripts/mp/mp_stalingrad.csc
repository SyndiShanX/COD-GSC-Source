/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_stalingrad.csc
*****************************************************/

#include clientscripts\mp\_utility;

main() {
  level.allies_team = "russian";
  level.axis_team = "german";
  setdvarbool("r_watersim_enabled", 0);
  clientscripts\mp\_load::main();
  clientscripts\mp\mp_stalingrad_fx::main();
  thread clientscripts\mp\_fx::fx_init(0);
  thread clientscripts\mp\_audio::audio_init(0);
  thread clientscripts\mp\mp_stalingrad_amb::main();
  thread waitforclient(0);
  println("*** Client : mp_stalingrad running...");
}