/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_crash_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setdevdvar("scr_fog_disable", "0");

  setExpFog(500, 3500, 0.501961, 0.501961, 0.45098, 1, 0);
  VisionSetNaked("mp_crash", 0);
}