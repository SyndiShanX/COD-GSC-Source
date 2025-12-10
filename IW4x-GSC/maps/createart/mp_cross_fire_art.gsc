/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_cross_fire_art.gsc
************************************************/

main() {
  level.tweakfile = true;

  setdvar("scr_fog_disable", "0");

  setExpFog(2315.28, 3009.05, 0.627317, 0.611552, 0.501961, 0.35, 0);
  VisionSetNaked("mp_cross_fire", 0);
}