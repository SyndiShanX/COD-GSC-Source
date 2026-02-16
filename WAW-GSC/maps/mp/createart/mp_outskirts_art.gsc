/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_outskirts_art.gsc
**************************************************/

main() {
  level.tweakfile = true;

  setVolFog(757.425, 1800, 465.087, -1600, 0.74903, 0.74903, 0.74903, 0);

  VisionSetNaked("mp_outskirts", 0);

  SetCullDist(6000);
}