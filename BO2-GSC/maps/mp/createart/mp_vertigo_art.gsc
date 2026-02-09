/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\createart\mp_vertigo_art.gsc
************************************************/

main() {
  level.tweakfile = 1;
  setDvar("scr_fog_exp_halfplane", "3759.28");
  setDvar("scr_fog_exp_halfheight", "243.735");
  setDvar("scr_fog_nearplane", "601.593");
  setDvar("scr_fog_red", "0.806694");
  setDvar("scr_fog_green", "0.962521");
  setDvar("scr_fog_blue", "0.9624");
  setDvar("scr_fog_baseheight", "-475.268");
  setDvar("visionstore_glowTweakEnable", "0");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "");
  setDvar("visionstore_glowTweakBloomCutoff", "0.5");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1");
  setDvar("visionstore_glowTweakBloomIntensity1", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "");
  start_dist = 11424.9;
  half_dist = 16020;
  half_height = 1164;
  base_height = -2675;
  fog_r = 0.372549;
  fog_g = 0.454902;
  fog_b = 0.447059;
  fog_scale = 1;
  sun_col_r = 1;
  sun_col_g = 0.686275;
  sun_col_b = 0.337255;
  sun_dir_x = -0.196011;
  sun_dir_y = 0.785122;
  sun_dir_z = 0.587506;
  sun_start_ang = 0;
  sun_stop_ang = 61.3208;
  time = 0;
  max_fog_opacity = 0.962;
  setvolfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  visionsetnaked("mp_la", 0);
}