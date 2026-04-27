/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\estate_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(1337.47, 11266.1, 0.402438, 0.550553, 0.651895, 0.154667, 0);
  maps\_utility::set_vision_set("estate", 0);
}