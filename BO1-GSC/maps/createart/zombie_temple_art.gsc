/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\zombie_temple_art.gsc
************************************************/

main() {
  start_dist = 151.081;
  half_dist = 526.479;
  half_height = 461.457;
  base_height = -652.425;
  fog_r = 0.0196078;
  fog_g = 0.0705882;
  fog_b = 0.0862745;
  fog_scale = 5.97369;
  sun_col_r = 1;
  sun_col_g = 0.435294;
  sun_col_b = 0.152941;
  sun_dir_x = -0.893398;
  sun_dir_y = -0.219239;
  sun_dir_z = 0.392141;
  sun_start_ang = 11.4807;
  sun_stop_ang = 94.7812;
  time = 0;
  max_fog_opacity = 0.604413;
  setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
    sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
    sun_stop_ang, time, max_fog_opacity);
  visionSetNaked("zombie_temple", 0);
  SetSavedDvar("r_lightGridEnableTweaks", 1);
  SetSavedDvar("r_lightGridIntensity", 1.6);
  SetSavedDvar("r_lightGridContrast", 0.5);
  SetSavedDvar("sm_sunSampleSizeNear", .6);
}