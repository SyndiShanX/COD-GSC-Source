/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_invasion_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(650, 2544, 0.63, 0.64, 0.65, 0.21, 0);
  VisionSetNaked("mp_invasion", 0);
}