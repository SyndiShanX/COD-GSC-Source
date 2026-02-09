//_createart generated.modify at your own risk. Changing values should be fine.
main()

{
  level.tweakfile = true;

  // *Fog section*

  setDvar("scr_fog_exp_halfplane", "1242.13");
  setDvar("scr_fog_exp_halfheight", "603.62");
  setDvar("scr_fog_nearplane", "927.119");
  setDvar("scr_fog_red", "1");
  setDvar("scr_fog_green", "0");
  setDvar("scr_fog_blue", "0");
  setDvar("scr_fog_baseheight", "0.5743");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1.7");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0.49");

  setDvar("visionstore_filmInvert", "0");
  setDvar("visionstore_filmLightTint", "1.2865 1.03479 1.04204");
  setDvar("visionstore_filmDarkTint", "0.696813 0.889778 1.00089");

  setVolFog(600, 1000, 603, 28, 0.4705, 0.539379, 0.574387, 0);
  // VisionSetNaked( "mp_docks", 0 );


}
// setVolFog(<startDist>, <halfwayDist>, <halfwayHeight>, <baseHeight>, <red>, <green>, <blue>, <transition time>)