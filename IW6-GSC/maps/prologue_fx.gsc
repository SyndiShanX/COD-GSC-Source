/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\prologue_fx.gsc
*****************************************************/

main() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    maps\createfx\prologue_fx::main();
    maps\createfx\prologue_sound::main();
  }
}