/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_kneedeep.csc
********************************************/

main() {
  clientscripts\mp\mp_kneedeep_fx::main();

  clientscripts\mp\_load::main();

  thread clientscripts\mp\_fx::fx_init(0);

  thread clientscripts\mp\_audio::audio_init(0);

  thread clientscripts\mp\mp_kneedeep_amb::main();

  println("*** Client : mp_kneedeep running...");
}