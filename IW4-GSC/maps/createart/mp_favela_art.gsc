/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_favela_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(270, 11488, 0.65, 0.74, 0.85, 0.1, 0);
  VisionSetNaked("mp_favela", 0);
}