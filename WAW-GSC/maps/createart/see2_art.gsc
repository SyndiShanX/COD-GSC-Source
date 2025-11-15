/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\see2_art.gsc
*****************************************************/

main() {
  level.tweakfile = true;
  setdvar("scr_fog_exp_halfplane", "2400");
  setdvar("scr_fog_exp_halfheight", "1800");
  setdvar("scr_fog_nearplane", "600");
  setdvar("scr_fog_red", "0.53");
  setdvar("scr_fog_green", "0.514");
  setdvar("scr_fog_blue", "0.4662");
  setdvar("scr_fog_baseheight", "-86");
  setdvar("visionstore_glowTweakEnable", "0");
  setdvar("visionstore_glowTweakRadius0", "5");
  setdvar("visionstore_glowTweakRadius1", "0");
  setdvar("visionstore_glowTweakBloomCutoff", "0.5");
  setdvar("visionstore_glowTweakBloomDesaturation", "0");
  setdvar("visionstore_glowTweakBloomIntensity0", "1");
  setdvar("visionstore_glowTweakBloomIntensity1", "0");
  setdvar("visionstore_glowTweakSkyBleedIntensity0", "0.29");
  setdvar("visionstore_glowTweakSkyBleedIntensity1", "0.29");
  level thread fog_settings();
  SetSavedDvar("sm_sunSampleSizeNear", "0.7");
  level thread maps\_utility::set_all_players_visionset("see2", 0.1);
}

fog_settings() {
  start_dist = 600;
  halfway_dist = 2400;
  halfway_height = 1800;
  base_height = -86;
  red = 0.53;
  green = 0.514;
  blue = 0.4662;
  trans_time = 0;
  if(IsSplitScreen()) {
    start_dist = 4000;
    halfway_dist = 200;
    halfway_height = 0;
    cull_dist = 8000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}