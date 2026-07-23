/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_rust_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(172.376, 1707.07, 0.548461, 0.468579, 0.381201, 0.658073, 0);
  VisionSetNaked("mp_rust", 0);
}