/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_bgate_art.gsc
**********************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "1750");
  setDvar("scr_fog_exp_halfheight", "0");
  setDvar("scr_fog_nearplane", "300");
  setDvar("scr_fog_red", "0.28");
  setDvar("scr_fog_green", "0.36");
  setDvar("scr_fog_blue", "0.4");
  setDvar("scr_fog_baseheight", "60");

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

  setVolFog(1100, 620, 675, 60, 0.49, 0.55, 0.567, 0);
  VisionSetNaked("mp_bgate", 0);
}