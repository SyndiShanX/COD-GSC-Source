/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_shrine_art.gsc
***********************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "900");
  setDvar("scr_fog_exp_halfheight", "400");
  setDvar("scr_fog_nearplane", "500");
  setDvar("scr_fog_red", "0.5");
  setDvar("scr_fog_green", "0.5");
  setDvar("scr_fog_blue", "0.5");
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

  setVolFog(0, 4400, 1400, 0, 0.552, 0.682, 0.71, 0);
}