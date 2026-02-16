/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\nazi_zombie_sumpf_art.gsc
****************************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "971.99");
  setDvar("scr_fog_exp_halfheight", "388.336");
  setDvar("scr_fog_nearplane", "729.34");
  setDvar("scr_fog_red", "0.58");
  setDvar("scr_fog_green", "0.60");
  setDvar("scr_fog_blue", "0.56");
  setDvar("scr_fog_baseheight", "-244.014");

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

  level thread maps\_utility::set_all_players_visionset("zombie_sumpf", 0.1);
}

fog_settings() {
  start_dist = 404.39;
  halfway_dist = 1543.52;
  halfway_height = 460.33;
  base_height = -244.014;
  red = 0.65;
  green = 0.84;
  blue = 0.79;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 404.39;
    halfway_dist = 1543.52;
    halfway_height = 460.3;
    cull_dist = 8500;
    red = 0.65;
    green = 0.84;
    blue = 0.79;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}