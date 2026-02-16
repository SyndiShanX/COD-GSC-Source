/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_downfall_art.gsc
*************************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "500");
  setDvar("scr_fog_exp_halfheight", "500");
  setDvar("scr_fog_nearplane", "0");
  setDvar("scr_fog_red", "1");
  setDvar("scr_fog_green", "1");
  setDvar("scr_fog_blue", "1");
  setDvar("scr_fog_baseheight", "0");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  setVolFog(759.379, 4196, 276, 358.969, 0.49, 0.56, 0.6, 0.0);
  VisionSetNaked("mp_downfall", 0);
}