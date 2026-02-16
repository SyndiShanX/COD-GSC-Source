/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\oki3_art.gsc
***************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "3500");
  setDvar("scr_fog_exp_halfheight", "285");
  setDvar("scr_fog_nearplane", "2500");
  setDvar("scr_fog_red", "0.435");
  setDvar("scr_fog_green", "0.433");
  setDvar("scr_fog_blue", "0.409");
  setDvar("scr_fog_baseheight", "-380");

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "3.0");
  setDvar("visionstore_glowTweakRadius1", "0");
  setDvar("visionstore_glowTweakBloomCutoff", "0.2");
  setDvar("visionstore_glowTweakBloomDesaturation", "0.37");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "0");

  level thread fog_settings();

  level thread maps\_utility::set_all_players_visionset("oki3", 0.1);
}

fog_settings() {
  start_dist = 2500;
  halfway_dist = 3500;
  halfway_height = 285;
  base_height = -380;
  red = 0.435;
  green = 0.433;
  blue = 0.409;
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