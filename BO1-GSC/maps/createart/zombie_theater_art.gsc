/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\zombie_theater_art.gsc
*************************************************/

main() {
  level.tweakfile = true;
  VisionSetNaked("zombie_theater", 0);
  SetSavedDvar("sm_sunSampleSizeNear", "0.93");
  SetSavedDvar("r_lightGridEnableTweaks", 1);
  SetSavedDvar("r_lightGridIntensity", 1.45);
  SetSavedDvar("r_lightGridContrast", 0.15);
  SetSavedDvar("r_lightTweakSunLight", 22);
}