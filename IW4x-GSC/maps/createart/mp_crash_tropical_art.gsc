/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_crash_tropical_art.gsc
****************************************************/

main() {
  level.tweakfile = true;



  setdevdvar("scr_fog_disable", "0");

  setExpFog(1400, 3500, 0.401961, 0.401961, 0.43098, 0.35, 0);
  VisionSetNaked("mp_crash_tropical", 0);
}