/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_dome_ns_art.gsc
*********************************************/

main() {
  level.tweakfile = true;
  level.parse_fog_func = maps\createart\mp_dome_ns_fog::main;

  VisionSetNaked("mp_dome_ns", 0);
}