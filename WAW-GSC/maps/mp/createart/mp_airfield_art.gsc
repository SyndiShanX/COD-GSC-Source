//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  //* Fog section *

  setDvar("scr_fog_exp_halfplane", "808.57");
  setDvar("scr_fog_exp_halfheight", "100");
  setDvar("scr_fog_nearplane", "400");
  setDvar("scr_fog_red", "0.52");
  setDvar("scr_fog_green", "0.49");
  setDvar("scr_fog_blue", "0.384");
  setDvar("scr_fog_baseheight", "50");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  setVolFog(400, 1600.57, 100, 50, 0.50, 0.49, 0.421, 0);
}

// setVolFog(<startDist>, <halfwayDist>, <halfwayHeight>, <baseHeight>, <red>, <green>, <blue>, <transition time>)