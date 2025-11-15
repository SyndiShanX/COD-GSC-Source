/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_makin_day.csc
*****************************************************/

#include clientscripts\mp\_utility;

main() {
  level.allies_team = "marines";
  level.axis_team = "japanese";
  clientscripts\mp\_load::main();
  clientscripts\mp\mp_makin_day_fx::main();
  thread clientscripts\mp\_fx::fx_init(0);
  thread clientscripts\mp\_audio::audio_init(0);
  thread clientscripts\mp\mp_makin_day_amb::main();
  thread waitforclient(0);
  println("*** Client : mp_makin_day running...");
}