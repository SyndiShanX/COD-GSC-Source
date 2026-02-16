/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\sniper_art.gsc
*****************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "4196");
  setDvar("scr_fog_exp_halfheight", "276");
  setDvar("scr_fog_nearplane", "759");
  setDvar("scr_fog_red", "0.49");
  setDvar("scr_fog_green", "0.56");
  setDvar("scr_fog_blue", "0.6");
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

  level thread fog_settings();
  level thread maps\_utility::set_all_players_visionset("sniper", 0.1);
  SetSavedDvar("sm_sunSampleSizeNear", "1.5");
}

fog_settings() {
  start_dist = 759;
  halfway_dist = 4196;
  halfway_height = 276;
  base_height = 358.96;
  red = 0.49;
  green = 0.56;
  blue = 0.6;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 1000;
    halfway_dist = 200;
    halfway_height = 0;
    cull_dist = 2000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}