/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_airfield_art.gsc
*****************************************************/

main() {
  level.tweakfile = true;
  setdvar("scr_fog_exp_halfplane", "808.57");
  setdvar("scr_fog_exp_halfheight", "100");
  setdvar("scr_fog_nearplane", "400");
  setdvar("scr_fog_red", "0.52");
  setdvar("scr_fog_green", "0.49");
  setdvar("scr_fog_blue", "0.384");
  setdvar("scr_fog_baseheight", "50");
  setdvar("visionstore_glowTweakEnable", "0");
  setdvar("visionstore_glowTweakRadius0", "5");
  setdvar("visionstore_glowTweakRadius1", "");
  setdvar("visionstore_glowTweakBloomCutoff", "0.5");
  setdvar("visionstore_glowTweakBloomDesaturation", "0");
  setdvar("visionstore_glowTweakBloomIntensity0", "1");
  setdvar("visionstore_glowTweakBloomIntensity1", "");
  setdvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setdvar("visionstore_glowTweakSkyBleedIntensity1", "");
  setVolFog(400, 1600.57, 100, 50, 0.50, 0.49, 0.421, 0);
}