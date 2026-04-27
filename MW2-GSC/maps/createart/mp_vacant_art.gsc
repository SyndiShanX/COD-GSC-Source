/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_vacant_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(1300, 3500, 0.517647, 0.501961, 0.407843, 0.500819, 0);
  VisionSetNaked("mp_vacant", 0);
}