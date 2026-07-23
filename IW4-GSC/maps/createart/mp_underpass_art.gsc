/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_underpass_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(328.324, 3700.49, 0.74902, 0.768628, 0.815686, 0.530078, 0);
  VisionSetNaked("mp_underpass", 0);
}