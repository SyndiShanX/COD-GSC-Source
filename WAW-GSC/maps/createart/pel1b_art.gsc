/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\pel1b_art.gsc
****************************************/

main() {
    level.tweakfile = true;

    setDvar("scr_fog_exp_halfplane", "1764");
    setDvar("scr_fog_exp_halfheight", "541");
    setDvar("scr_fog_nearplane", "815");
    setDvar("scr_fog_red", "0.506");
    setDvar("scr_fog_green", "0.613");
    setDvar("scr_fog_blue", "0.657");
    setDvar("scr_fog_baseheight", "-451.65");

    setDvar("visionstore_glowTweakEnable", "0");
    setDvar("visionstore_glowTweakRadius0", "5");
    setDvar("visionstore_glowTweakRadius1", "");
    setDvar("visionstore_glowTweakBloomCutoff", "0.5");
    setDvar("visionstore_glowTweakBloomDesaturation", "0");
    setDvar("visionstore_glowTweakBloomIntensity0", "1");
    setDvar("visionstore_glowTweakBloomIntensity1", "");
    setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
    setDvar("visionstore_glowTweakSkyBleedIntensity1", "");

    /
    fog_settings() {
      start_dist = 2166;
      halfway_dist = 2600;
      halfway_height = 2649;
      base_height = 1320;
      red = 0.506;
      green = 0.613;
      blue = 0.657;
      trans_time = 0;

      if(IsSplitScreen()) {
        start_dist = 8000;
        halfway_dist = 7000;
        halfway_height = 10000;
        cull_dist = 10000;
        maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
      }
    }