/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\pakistan_2_art.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 5);
  wait 1;
  setsaveddvar("r_lightTweakSunLight", 1);
  visionsetnaked("sp_pakistan_2_default", 2);
}

set_water_dvars_street() {
  setdvar("r_waterwavespeed", "0.470637 0.247217 1 1");
  setdvar("r_waterwaveamplitude", "2.8911 0 0 0");
  setdvar("r_waterwavewavelength", "9.71035 3.4 1 1");
  setdvar("r_waterwaveangle", "56.75 237.203 0 0");
  setdvar("r_waterwavephase", "0 2.6 0 0");
  setdvar("r_waterwavesteepness", "0 0 0 0");
  setdvar("r_waterwavelength", "9.71035 3.40359 1 1");
}

set_water_dvars_flatten_surface() {
  setdvar("r_waterwaveamplitude", "0 0 0 0");
}

turn_on_claw_vision() {
  visionsetnaked("sp_pakistan2_claw", 0);
  setsaveddvar("r_lightTweakSunLight", 2);
}

turn_off_claw_vision() {
  visionsetnaked("sp_pakistan_2_default", 0);
}

turn_on_trainyard_vision() {
  visionsetnaked("sp_pakistan_2_trainyard", 2);
}

turn_off_trainyard_vision() {
  visionsetnaked("sp_pakistan_2_default", 0);
}

underground_fire_fx_vision() {
  visionsetnaked("sp_pakistan2_underground_fire", 2);
}

above_water_fire_vision() {
  visionsetnaked("sp_pakistan2_underground_fire_abovewater", 2);
}

turn_back_to_default() {
  visionsetnaked("sp_pakistan_2_default", 2);
}

vision_underwater_swimming() {
  visionsetnaked("sp_pakistan2_swimming", 2);
}

vision_underwater_explosion() {
  visionsetnaked("sp_pakistan2_explosion", 1);
}

vision_torture_room() {
  visionsetnaked("sp_pakistan2_torture_room", 1);
}

vision_millibar_room() {
  visionsetnaked("sp_pakistan2_grenade_preblast", 1);
  setsaveddvar("r_lightTweakSunLight", 8);
  setsunlight(0.96, 0.85, 0.78);
  setsaveddvar("r_sky_intensity_factor0", 1.5);
}

vision_jiffylube_room() {
  visionsetnaked("sp_pakistan2_jiffylube", 1);
  setsaveddvar("r_lightTweakSunLight", 8);
  setsunlight(0.96, 0.85, 0.78);
  setsaveddvar("r_sky_intensity_factor0", 1.5);
}