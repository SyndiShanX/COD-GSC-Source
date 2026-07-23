/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_highrise_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(5000, 20000, 0.368627, 0.341176, 0.270588, 0.41, 0);
  VisionSetNaked("mp_highrise", 0);
}