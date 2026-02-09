/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\zombie_cod5_prototype_art.gsc
********************************************************/

main() {
  level.tweakfile = true;
  level thread fog_settings();
  VisionSetNaked("zombie_prototype", 0);
  SetSavedDvar("r_lightGridEnableTweaks", 1);
  SetSavedDvar("r_lightGridIntensity", 1.45);
  SetSavedDvar("r_lightGridContrast", .15);
}
fog_settings() {
  start_dist = 220;
  half_dist = 948.75;
  half_height = 154.636;
  base_height = 75;
  fog_r = 0.501961;
  fog_g = 0.501961;
  fog_b = 0.501961;
  fog_scale = 3.02824;
  sun_col_r = 0.501961;
  sun_col_g = 0.501961;
  sun_col_b = 0.501961;
  sun_dir_x = 0;
  sun_dir_y = 0;
  sun_dir_z = 0;
  sun_start_ang = 0;
  sun_stop_ang = 0;
  time = 0;
  max_fog_opacity = 1;
  setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
}