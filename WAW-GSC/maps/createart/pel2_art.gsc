/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\pel2_art.gsc
***************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "255");
  setDvar("scr_fog_exp_halfheight", "250");
  setDvar("scr_fog_nearplane", "790");
  setDvar("scr_fog_red", "0.44");
  setDvar("scr_fog_green", "0.40");
  setDvar("scr_fog_blue", "0.32");
  setDvar("scr_fog_baseheight", "-55");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "2");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "0.9");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  level thread fog_settings();

  level thread maps\_utility::set_all_players_visionset("pel2_2", 0.1);
}

fog_settings() {
  start_dist = 790;
  halfway_dist = 255;
  halfway_height = 250;
  base_height = -55;
  red = 0.44;
  green = 0.40;
  blue = 0.32;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 2500;
    halfway_dist = 150;
    halfway_height = 0;
    cull_dist = 8500;
    red = 0.7;
    green = 0.62;
    blue = 0.52;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}