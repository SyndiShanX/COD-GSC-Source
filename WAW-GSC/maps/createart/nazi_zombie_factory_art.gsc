/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\nazi_zombie_factory_art.gsc
******************************************************/

main() {
  level.tweakfile = true;
  setdvar("scr_fog_exp_halfplane", "1763.99");
  setdvar("scr_fog_exp_halfheight", "541.494");
  setdvar("scr_fog_nearplane", "814.911");
  setdvar("scr_fog_red", "0.5");
  setdvar("scr_fog_green", "0.5");
  setdvar("scr_fog_blue", "0.55");
  setdvar("scr_fog_baseheight", "-451.652");
  setdvar("visionstore_glowTweakEnable", "0");
  setdvar("visionstore_glowTweakRadius0", "5");
  setdvar("visionstore_glowTweakRadius1", "");
  setdvar("visionstore_glowTweakBloomCutoff", "0.5");
  setdvar("visionstore_glowTweakBloomDesaturation", "0");
  setdvar("visionstore_glowTweakBloomIntensity0", "1");
  setdvar("visionstore_glowTweakBloomIntensity1", "");
  setdvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setdvar("visionstore_glowTweakSkyBleedIntensity1", "");
  level thread fog_settings();
  level thread maps\_utility::set_all_players_visionset("zombie_factory", 0.1);
}

fog_settings() {
  start_dist = 440;
  halfway_dist = 3200;
  halfway_height = 225;
  base_height = 64;
  red = 0.533;
  green = 0.717;
  blue = 1;
  trans_time = 0;
  if(IsSplitScreen()) {
    start_dist = 440;
    halfway_dist = 3200;
    halfway_height = 225;
    cull_dist = 4000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}