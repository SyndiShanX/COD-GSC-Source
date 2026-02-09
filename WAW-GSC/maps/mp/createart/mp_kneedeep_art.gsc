//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  // *Fog section*

  setDvar("scr_fog_exp_halfplane", "2560");
  setDvar("scr_fog_exp_halfheight", "520");
  setDvar("scr_fog_nearplane", "940");
  setDvar("scr_fog_red", "0.7");
  setDvar("scr_fog_green", "0.62");
  setDvar("scr_fog_blue", "0.52");
  setDvar("scr_fog_baseheight", "-55");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "2");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "0.9");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  setVolFog(600, 580, 270, 170, 0.25, 0.28, 0.29, 0);
  VisionSetNaked("mp_kneedeep", 0);
}

// setVolFog(<startDist>, <halfwayDist>, <halfwayHeight>, <baseHeight>, <red>, <green>, <blue>, <transition time>)