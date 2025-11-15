/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\zombie_pentagon_art.gsc
**************************************************/

main() {
  level.tweakfile = true;
  setdvar("scr_fog_exp_halfplane", "3759.28");
  setdvar("scr_fog_exp_halfheight", "243.735");
  setdvar("scr_fog_nearplane", "601.593");
  setdvar("scr_fog_red", "0.806694");
  setdvar("scr_fog_green", "0.962521");
  setdvar("scr_fog_blue", "0.9624");
  setdvar("scr_fog_baseheight", "-475.268");
  start_dist = 433.577;
  half_dist = 482.154;
  half_height = 30960.7;
  base_height = -701.494;
  fog_r = 0.317647;
  fog_g = 0.501961;
  fog_b = 0.501961;
  fog_scale = 1;
  sun_col_r = 0.501961;
  sun_col_g = 0.501961;
  sun_col_b = 0.501961;
  sun_dir_x = -0.333915;
  sun_dir_y = 0.941655;
  sun_dir_z = -0.0422678;
  sun_start_ang = 0;
  sun_stop_ang = 0;
  time = 0;
  max_fog_opacity = 0.881155;
  setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
    sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
    sun_stop_ang, time, max_fog_opacity);
  visionSetNaked("zombie_pentagon", 0);
  SetSavedDvar("r_lightGridEnableTweaks", 1);
  SetSavedDvar("r_lightGridIntensity", 1.3);
  SetSavedDvar("r_lightGridContrast", .15);
}