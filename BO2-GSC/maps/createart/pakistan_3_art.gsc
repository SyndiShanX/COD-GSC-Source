/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\pakistan_3_art.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 2);
  visionsetnaked("sp_pakistan_3_default", 2);
}

debug_timer() {
  hud_debug_timer = get_debug_timer();
  hud_debug_timer settimerup(0);
}

get_debug_timer() {
  if(isDefined(level.hud_debug_timer))
    level.hud_debug_timer destroy();

  level.hud_debug_timer = newhudelem();
  level.hud_debug_timer.alignx = "left";
  level.hud_debug_timer.aligny = "bottom";
  level.hud_debug_timer.horzalign = "left";
  level.hud_debug_timer.vertalign = "bottom";
  level.hud_debug_timer.x = 0;
  level.hud_debug_timer.y = 0;
  level.hud_debug_timer.fontscale = 2.0;
  level.hud_debug_timer.color = (0.8, 1.0, 0.8);
  level.hud_debug_timer.font = "objective";
  level.hud_debug_timer.glowcolor = (0.3, 0.6, 0.3);
  level.hud_debug_timer.glowalpha = 1;
  level.hud_debug_timer.foreground = 1;
  level.hud_debug_timer.hidewheninmenu = 1;
  return level.hud_debug_timer;
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
  level.vision_set_preclaw = level.player getvisionsetnaked();
  level.player visionsetnaked("claw_base", 0);
}

turn_off_claw_vision() {
  if(!isDefined(level.vision_set_preclaw))
    level.vision_set_preclaw = "default";

  level.player visionsetnaked(level.vision_set_preclaw, 0);
}

soct_driving_visionset() {
  visionsetnaked("sp_pakistan_3_default", 0.1);
}

standoff() {
  visionsetnaked("sp_pakistan_3_default", 0.1);
}

standoff_dof_start() {
  setdvar("r_exposureTweak", 1);
  level thread lerp_dvar("r_exposureValue", 4.5, 1);
  debug_timer();

  iprintlnbold("DOF:standoff_dof_start");

  n_near_start = 10;
  n_near_end = 28;
  n_far_start = 250;
  n_far_end = 1000;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

standoff_zhao_turn() {
  iprintlnbold("DOF:standoff_zhao_turn");

  n_near_start = 10;
  n_near_end = 28;
  n_far_start = 80;
  n_far_end = 300;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

standoff_zhao_walk() {
  iprintlnbold("DOF:standoff_zhao_walk");

  n_near_start = 10;
  n_near_end = 4;
  n_far_start = 150;
  n_far_end = 300;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

standoff_dof_stop() {
  iprintlnbold("DOF:standoff_dof_stop");

  n_near_start = 10;
  n_near_end = 28;
  n_far_start = 60;
  n_far_end = 300;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

standoff_dof_closeup() {
  iprintlnbold("DOF:standoff_dof_closeup");

  n_near_start = 10;
  n_near_end = 28;
  n_far_start = 35;
  n_far_end = 100;
  n_near_blur = 4;
  n_far_blur = 1.8;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

standoff_dof_end() {
  iprintlnbold("DOF:standoff_dof_end");

  n_near_start = 10;
  n_near_end = 28;
  n_far_start = 60;
  n_far_end = 300;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}