/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_drum_art.gsc
*********************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "857");
  setDvar("scr_fog_exp_halfheight", "691");
  setDvar("scr_fog_nearplane", "480");
  setDvar("scr_fog_red", "0.5");
  setDvar("scr_fog_green", "0.5");
  setDvar("scr_fog_blue", "0.5");
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

  setVolFog(260, 1348, 1250, 80, 0.80, 0.80, 0.76, 0);
  VisionSetNaked("mp_drum", 0);
}