/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\pel1_art.gsc
***************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "1763.99");
  setDvar("scr_fog_exp_halfheight", "541.494");
  setDvar("scr_fog_nearplane", "814.911");
  setDvar("scr_fog_red", "0.5");
  setDvar("scr_fog_green", "0.5");
  setDvar("scr_fog_blue", "0.55");
  setDvar("scr_fog_baseheight", "-451.652");

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

  level thread maps\_utility::set_all_players_visionset("pel1_intro", 0.1);
}

fog_settings() {
  start_dist = 814;
  halfway_dist = 1763;
  halfway_height = 541;
  base_height = -451;
  red = 0.5;
  green = 0.5;
  blue = 0.55;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 1500;
    halfway_dist = 150;
    halfway_height = 0;
    cull_dist = 4000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}