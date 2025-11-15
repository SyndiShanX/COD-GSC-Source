/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\credits.csc
*****************************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\credits_amb::main();
  thread waitforclient(0);
  println("*** Client : credits running...");
}