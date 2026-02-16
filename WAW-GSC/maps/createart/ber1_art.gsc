/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\ber1_art.gsc
***************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "2900");
  setDvar("scr_fog_exp_halfheight", "120");
  setDvar("scr_fog_nearplane", "340");
  setDvar("scr_fog_red", "0.485");
  setDvar("scr_fog_green", "0.485");
  setDvar("scr_fog_blue", "0.5");
  setDvar("scr_fog_baseheight", "-392");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "5.20299");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.365491");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "0.139647");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

  level thread fog_settings();
  level thread maps\_utility::set_all_players_visionset("ber1", 0.1);
}

fog_settings() {
  start_dist = 800;
  halfway_dist = 2900;
  halfway_height = 120;
  base_height = -392;
  red = 0.485;
  green = 0.485;
  blue = 0.55;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 2200;
    halfway_dist = 150;
    halfway_height = 0;
    cull_dist = 6000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}