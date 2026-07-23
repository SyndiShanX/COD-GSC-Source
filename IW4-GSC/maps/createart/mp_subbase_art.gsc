/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_subbase_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(0, 2228.18, 0.894118, 0.8962, 0.929412, 0.776943, 0);
  VisionSetNaked("mp_subbase", 0);
}