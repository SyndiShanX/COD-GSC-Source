/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_makin_art.gsc
**********************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "3759.28");
  setDvar("scr_fog_exp_halfheight", "243.735");
  setDvar("scr_fog_nearplane", "601.593");
  setDvar("scr_fog_red", "0.806694");
  setDvar("scr_fog_green", "0.962521");
  setDvar("scr_fog_blue", "0.9624");
  setDvar("scr_fog_baseheight", "-475.268");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  setVolFog(700, 2000, 350, 0, 0.115, 0.123, 0.141, 0);
}