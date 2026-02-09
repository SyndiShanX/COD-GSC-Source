//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  // *Fog section*

  setDvar("scr_fog_exp_halfplane", "857");
  setDvar("scr_fog_exp_halfheight", "691");
  setDvar("scr_fog_nearplane", "480");
  setDvar("scr_fog_red", "0.495");
  setDvar("scr_fog_green", "0.62");
  setDvar("scr_fog_blue", "0.52");
  setDvar("scr_fog_baseheight", "337");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "2");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "0.9");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  setVolFog(480, 857, 691, 337, 0.65, 0.62, 0.56, 0);
  VisionSetNaked("mp_kwai", 0);
}

// setVolFog(<startDist>, <halfwayDist>, <halfwayHeight>, <baseHeight>, <red>, <green>, <blue>, <transition time>)