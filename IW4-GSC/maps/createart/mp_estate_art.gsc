/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_estate_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(591.874, 8193, 0.319788, 0.39502, 0.519183, 0.529818, 0);
  VisionSetNaked("mp_estate", 0);
}