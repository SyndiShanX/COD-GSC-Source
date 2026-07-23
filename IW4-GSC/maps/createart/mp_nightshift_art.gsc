/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_nightshift_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(1008.07, 2000.27, 0.223529, 0.337255, 0.258824, 0.119589, 0);
  VisionSetNaked("mp_nightshift", 0);
}