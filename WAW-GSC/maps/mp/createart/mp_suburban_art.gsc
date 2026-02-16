/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_suburban_art.gsc
*************************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "808.57");
  setDvar("scr_fog_exp_halfheight", "100");
  setDvar("scr_fog_nearplane", "400");
  setDvar("scr_fog_red", "0.52");
  setDvar("scr_fog_green", "0.49");
  setDvar("scr_fog_blue", "0.384");
  setDvar("scr_fog_baseheight", "50");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "0");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "0");

  setVolFog(178, 1454, 289, -480, 0.623, 0.620, 0.508, 0);
}