/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\oki2_art.gsc
*****************************************************/

main() {
  level.tweakfile = true;
  setdvar("scr_fog_exp_halfplane", "1496.71");
  setdvar("scr_fog_exp_halfheight", "384.096");
  setdvar("scr_fog_nearplane", "0");
  setdvar("scr_fog_red", "0.40");
  setdvar("scr_fog_green", "0.52");
  setdvar("scr_fog_blue", "0.60");
  setdvar("scr_fog_baseheight", "-932.654");
  setdvar("visionstore_glowTweakEnable", "1");
  setdvar("visionstore_glowTweakRadius0", "5");
  setdvar("visionstore_glowTweakRadius1", "0");
  setdvar("visionstore_glowTweakBloomCutoff", "0.260564");
  setdvar("visionstore_glowTweakBloomDesaturation", "0");
  setdvar("visionstore_glowTweakBloomIntensity0", "1.41192");
  setdvar("visionstore_glowTweakBloomIntensity1", "0");
  setdvar("visionstore_glowTweakSkyBleedIntensity0", "0");
  setdvar("visionstore_glowTweakSkyBleedIntensity1", "0");
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