/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_dome_art.gsc
*********************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "3759.28");
  setDvar("scr_fog_exp_halfheight", "243.735");
  setDvar("scr_fog_nearplane", "601.593");
  setDvar("scr_fog_red", "0");
  setDvar("scr_fog_green", "1");
  setDvar("scr_fog_blue", "0");
  setDvar("scr_fog_baseheight", "55");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  setVolFog(0, 190, 215, -1600, 0.375, 0.375, 0.350, 0);
}