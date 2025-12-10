/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_fav_tropical_art.gsc
**************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(800, 4000, 0.63, 0.66, 0.66, 0.07, 0);
  VisionSetNaked("mp_fav_tropical", 0);
}