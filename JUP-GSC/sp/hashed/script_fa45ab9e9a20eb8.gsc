/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_fa45ab9e9a20eb8.gsc
************************************************/

#using script_5e60754c97311cd;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_b57ef5f52663f435;

function main() {
  level._effect["vfx_resort_igc_water_surface_ripples"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_igc_water_surface_ripples.vfx");
  level._effect["vfx_resort_igc_water_splash_screen"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_igc_water_splash_screen.vfx");
  level._effect["vfx_resort_igc_soap_water_drips"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_igc_soap_water_drips.vfx");
  level._effect["vfx_resort_drone_light_danger"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_drone_light_danger.vfx");
  level._effect["vfx_resort_drone_light_alert"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_drone_light_alert.vfx");
  level._effect["vfx_jup_resort_candle_flame_1"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_jup_resort_candle_flame_1.vfx");
  level._effect["vfx_resort_fireplace_fire_02"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_fireplace_fire_02.vfx");
  level._effect["vfx_resort_water_drip_01"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_water_drip_01.vfx");
  level._effect["vfx_jup_resort_splash_diver_01"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_jup_resort_splash_diver_01.vfx");
  level._effect["vfx_resort_boat_wake_01_ch"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_boat_wake_01_ch.vfx");
  thread function_b9e130d444d299c9("beach_exploder", "beach_zone");
  thread function_b9e130d444d299c9("beach_alt_exploder", "beach_alt_zone");
  thread function_b9e130d444d299c9("mid_exploder", "mid_zone");
  thread function_b9e130d444d299c9("ocean_exploder", "ocean_zone");
  thread function_b9e130d444d299c9("upper_exploder", "upper_zone");
  thread function_b9e130d444d299c9("patio_exploder", "patio_zone");
  thread function_b9e130d444d299c9("cave_exploder", "cave_zone");
  thread function_b9e130d444d299c9("main_exploder", "main_zone");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}

  level._effect["vfx_marina_gaz_right_wrist_splashes_mantle_72"] = loadfx("vfx/iw9/level/marina/vfx_marina_gaz_right_wrist_splashes_mantle_72.vfx");
  level._effect["vfx_marina_gaz_right_elbow_splashes_mantle_72"] = loadfx("vfx/iw9/level/marina/vfx_marina_gaz_right_elbow_splashes_mantle_72.vfx");
  level._effect["vfx_resort_boat_wake_01"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_boat_wake_01.vfx");
}