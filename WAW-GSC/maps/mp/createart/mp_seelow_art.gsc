/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_seelow_art.gsc
***********************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "1028");
  setDvar("scr_fog_exp_halfheight", "1360");
  setDvar("scr_fog_nearplane", "512");
  setDvar("scr_fog_red", "0.3828");
  setDvar("scr_fog_green", "0.445");
  setDvar("scr_fog_blue", "0.5859");
  setDvar("scr_fog_baseheight", "-448");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "1.25");
  setDvar("visionstore_glowTweakBloomCutoff", "0.17");
  setDvar("visionstore_glowTweakBloomDesaturation", "0.27");
  setDvar("visionstore_glowTweakBloomIntensity0", "0.88");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0.29");
  setDvar("visionstore_glowRayExpansion", ".5");
  setDvar("visionstore_glowRayIntensity", "0.25");
  setDvar("visionstore_filmEnable", "1");
  setDvar("visionstore_filmContrast", "1.2");
  setDvar("visionstore_filmBrightness", "0.16");
  setDvar("visionstore_filmDesaturation", "0");

  setDvar("visionstore_filmInvert", "0");
  setDvar("visionstore_filmLightTint", "1.37 1.6 1.2");
  setDvar("visionstore_filmDarkTint", "0.44 0.15 0.24");

  setVolFog(0, 4000, 1400, -450, 0.72, 0.76, 0.96, 0);
}