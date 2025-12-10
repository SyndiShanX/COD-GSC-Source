/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_backlot_art.gsc
*********************************************/

main() {
  level.tweakfile = true;

  setdvar("scr_fog_disable", "0");

  setExpFog(901.718, 2200, 0.631373, 0.568627, 0.34902, 1.0, 0);
  VisionSetNaked("mp_backlot", 0);
}