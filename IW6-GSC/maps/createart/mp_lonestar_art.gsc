/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_lonestar_art.gsc
**********************************************/

main() {
  level.tweakfile = true;
  level.parse_fog_func = maps\createart\mp_lonestar_fog::main;

  setDevDvar("scr_fog_disable", "0");

  VisionSetNaked("mp_lonestar", 0);
}