/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\nazi_zombie_asylum_art.gsc
*****************************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "416");
  setDvar("scr_fog_exp_halfheight", "200");
  setDvar("scr_fog_nearplane", "167");
  setDvar("scr_fog_red", "0.5");
  setDvar("scr_fog_green", "0.5");
  setDvar("scr_fog_blue", "0.5");
  setDvar("scr_fog_baseheight", "124");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "5");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "2");
  setDvar("visionstore_glowTweakBloomIntensity1", "2");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0.29");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "0.29");

  level thread fog_settings();

  level thread maps\_utility::set_all_players_visionset("zombie_asylum", 0.1);
}

fog_settings() {
  start_dist = 167;
  halfway_dist = 416;
  halfway_height = 200;
  base_height = 124;
  red = 0.46;
  green = 0.38;
  blue = 0.29;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 112;
    halfway_dist = 835;
    halfway_height = 100;
    cull_dist = 4000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}