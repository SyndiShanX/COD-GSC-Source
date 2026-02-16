/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\pel1a_art.gsc
****************************************/

main() {
  level.tweakfile = true;

  setDvar("scr_fog_exp_halfplane", "2787");
  setDvar("scr_fog_exp_halfheight", "2000");
  setDvar("scr_fog_nearplane", "1000");
  setDvar("scr_fog_red", "0.525");
  setDvar("scr_fog_green", "0.545");
  setDvar("scr_fog_blue", "0.63");
  setDvar("scr_fog_baseheight", "0");

  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.1");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");
  setDvar("visionstore_filmTweakEnable", "0");
  setDvar("visionstore_filmTweakContrast", "1.4");
  setDvar("visionstore_filmTweakBrightness", "0");
  setDvar("visionstore_filmTweakDesaturation", "0.2");
  setDvar("visionstore_filmTweakInvert", "1");
  setDvar("visionstore_filmTweakLightTint", "1.1 1.05 0.85");
  setDvar("visionstore_filmTweakDarkTint", "0.7 0.85 1");

  level thread fog_settings();

  level thread maps\_utility::set_all_players_visionset("pel1a", 0.1);
}

fog_settings() {
  start_dist = 1000;
  halfway_dist = 2787;
  halfway_height = 2000;
  base_height = 0;
  red = 0.525;
  green = 0.545;
  blue = 0.63;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 1500;
    halfway_dist = 150;
    halfway_height = 0;
    cull_dist = 3000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}