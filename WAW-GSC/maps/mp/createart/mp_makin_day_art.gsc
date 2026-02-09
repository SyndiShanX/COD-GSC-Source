//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  //* Fog section *

  setDvar("scr_fog_exp_halfplane", "1053");
  setDvar("scr_fog_exp_halfheight", "243");
  setDvar("scr_fog_nearplane", "2869");
  setDvar("scr_fog_red", "0.52");
  setDvar("scr_fog_green", "0.62");
  setDvar("scr_fog_blue", "0.52");
  setDvar("scr_fog_baseheight", "167.563");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  setVolFog(2869, 1053, 243, 243, 0.52, 0.54, 0.52, 0);

  VisionSetNaked("mp_makin_day", 0);

  SetCullDist(10000);
}

// setVolFog(<startDist>, <halfwayDist>, <halfwayHeight>, <baseHeight>, <red>, <green>, <blue>, <transition time>)