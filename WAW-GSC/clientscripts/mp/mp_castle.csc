/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_castle.csc
******************************************/

#include clientscripts\mp\_utility;

main() {
  level.allies_team = "marines";
  level.axis_team = "japanese";

  clientscripts\mp\_load::main();

  clientscripts\mp\mp_castle_fx::main();

  thread clientscripts\mp\_fx::fx_init(0);
  thread clientscripts\mp\_audio::audio_init(0);

  thread clientscripts\mp\mp_castle_amb::main();

  thread waitforclient(0);

  println("*** Client : mp_castle running...");
}