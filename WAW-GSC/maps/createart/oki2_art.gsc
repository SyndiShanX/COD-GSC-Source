/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\oki2_art.gsc
***************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "1496.71");
  setDvar("scr_fog_exp_halfheight", "384.096");
  setDvar("scr_fog_nearplane", "0");
  setDvar("scr_fog_red", "0.40");
  setDvar("scr_fog_green", "0.52");
  setDvar("scr_fog_blue", "0.60");
  setDvar("scr_fog_baseheight", "-932.654");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "0");
  setDvar("visionstore_glowTweakBloomCutoff", "0.260564");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1.41192");
  setDvar("visionstore_glowTweakBloomIntensity1", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "0");

  level thread fog_settings();

  level thread maps\_utility::set_all_players_visionset("oki2", 0.1);
}

fog_settings() {
  start_dist = 0;
  halfway_dist = 1496;
  halfway_height = 384;
  base_height = -932;
  red = 0.40;
  green = 0.52;
  blue = 0.60;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 1500;
    halfway_dist = 200;
    halfway_height = 0;
    cull_dist = 4000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}