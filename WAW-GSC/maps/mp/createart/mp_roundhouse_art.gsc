//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  // *Fog section*

  setDvar("scr_fog_exp_halfplane", "3316");
  setDvar("scr_fog_exp_halfheight", "512");
  setDvar("scr_fog_nearplane", "512");
  setDvar("scr_fog_red", "0.47");
  setDvar("scr_fog_green", "0.52");
  setDvar("scr_fog_blue", "0.47");
  setDvar("scr_fog_baseheight", "0");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1.7");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0.49");
  setDvar("visionstore_glowRayExpansion", ".7");
  setDvar("visionstore_glowRayIntensity", "0.5");
  setDvar("visionstore_filmEnable", "1");
  setDvar("visionstore_filmContrast", "1.4");
  setDvar("visionstore_filmBrightness", "0.18");
  setDvar("visionstore_filmDesaturation", "0");

  setDvar("visionstore_filmInvert", "0");
  setDvar("visionstore_filmLightTint", "0.98 1.1 1.1");
  setDvar("visionstore_filmDarkTint", "0.87 1.06 1.06");

  setVolFog(512, 3316, 512, 0, .47, 0.52, 0.47, 0);
  VisionSetNaked("mp_roundhouse", 0);
}