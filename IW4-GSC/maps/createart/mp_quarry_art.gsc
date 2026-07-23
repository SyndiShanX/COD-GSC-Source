/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_quarry_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(913.205, 5270.28, 0.631373, 0.631373, 0.662745, 0.279516, 0);
  VisionSetNaked("mp_quarry", 0);
}