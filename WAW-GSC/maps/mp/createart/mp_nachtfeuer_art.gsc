/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_nachtfeuer_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "264.344");
  setDvar("scr_fog_exp_halfheight", "431.442");
  setDvar("scr_fog_nearplane", "128.162");
  setDvar("scr_fog_red", "0.791");
  setDvar("scr_fog_green", "0.514");
  setDvar("scr_fog_blue", "0.152");
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

  setVolFog(600, 870, 220, 1232, 0.55, 0.47, 0.357, 0);
}