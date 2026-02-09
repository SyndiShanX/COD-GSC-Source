/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_countdown_art.gsc
***********************************************/

//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "8193");
  setDvar("scr_fog_nearplane", "0");
  setDvar("scr_fog_red", "0.169863");
  setDvar("scr_fog_green", "0.168938");
  setDvar("scr_fog_blue", "0.244047");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "12");
  setDvar("visionstore_glowTweakBloomCutoff", "0.9");
  setDvar("visionstore_glowTweakBloomDesaturation", "0.75");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "1");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0.5");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "0");
  setDvar("visionstore_filmTweakEnable", "0");
  setDvar("visionstore_filmTweakContrast", "1.4");
  setDvar("visionstore_filmTweakBrightness", "0");
  setDvar("visionstore_filmTweakDesaturation", "0.2");
  setDvar("visionstore_filmTweakInvert", "0");
  setDvar("visionstore_filmTweakLightTint", "1.1 1.05 0.85");
  setDvar("visionstore_filmTweakDarkTint", "0.7 0.85 1");

  setExpFog(0, 8193, 0.169863, 0.168938, 0.244047, 1.0, 0);
  VisionSetNaked("launchfacility_a", 0);
}