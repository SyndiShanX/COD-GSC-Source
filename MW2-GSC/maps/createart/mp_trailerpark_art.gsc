/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_trailerpark_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(657.722, 19514.7, 0.489979, 0.573826, 0.668153, 0.0819582, 0);
  VisionSetNaked("mp_trailerpark", 0);
}