/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\see1_art.gsc
***************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "3200");
  setDvar("scr_fog_exp_halfheight", "1360");
  setDvar("scr_fog_nearplane", "1100");
  setDvar("scr_fog_red", "0.62");
  setDvar("scr_fog_green", "0.59");
  setDvar("scr_fog_blue", "0.52");
  setDvar("scr_fog_baseheight", "-448");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "0.25");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "0.125");
  setDvar("visionstore_glowTweakBloomIntensity1", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "0");

  level thread fog_settings();
  level thread maps\_utility::set_all_players_visionset("see1", 0.1);
}

fog_settings() {
  start_dist = 1100;
  halfway_dist = 3200;
  halfway_height = 1360;
  base_height = -448;
  red = 0.62;
  green = 0.59;
  blue = 0.52;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 3000;
    halfway_dist = 250;
    halfway_height = 0;
    cull_dist = 6000;

    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}