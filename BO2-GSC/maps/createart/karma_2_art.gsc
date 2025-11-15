/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\karma_2_art.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 15);
  setsaveddvar("r_lightGridEnableTweaks", 1);
  setsaveddvar("r_lightGridIntensity", 1.2);
  setsaveddvar("r_lightGridContrast", 0.6);
}

vision_set_trigger_think() {
  self endon("death");

  while(true) {
    self waittill("trigger");

    if(level.karma_vision != self.script_string)
      level.player vision_set_change(self.script_string);

    wait 0.1;
  }
}

vision_set_change(str_vision_set) {
  n_vs_time = 2;
  n_near_start = undefined;
  n_near_end = undefined;
  n_far_start = undefined;
  n_far_end = undefined;
  n_near_blur = undefined;
  n_far_blur = undefined;
  n_time = undefined;

  switch (str_vision_set) {
    case "sp_karma2_mall_interior":
      n_vs_time = 2;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 10);
      break;
    case "sp_karma2_clubexit":
      n_vs_time = 2;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 4);
      break;
    case "sp_karma2_sundeck":
      n_vs_time = 2;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      break;
    case "sp_karma2_defalco_walk":
      n_vs_time = 2;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      setsaveddvar("r_lightTweakSunLight", 15);
      break;
    case "sp_karma2_end":
      n_vs_time = 2;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      break;
  }

  visionsetnaked(str_vision_set, n_vs_time);
  level.karma_vision = str_vision_set;

  if(isDefined(n_near_start) && isDefined(n_time))
    self thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  else
    self depth_of_field_off(0.05);
}

dof_harper_pushdoor() {
  n_near_start = 2;
  n_near_end = 50;
  n_far_start = 72;
  n_far_end = 614;
  n_near_blur = 4;
  n_far_blur = 1.5;
  n_time = 5;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_take_gun");
}

dof_salazar_1() {
  n_near_start = 1.2;
  n_near_end = 30;
  n_far_start = 114;
  n_far_end = 938;
  n_near_blur = 0.05;
  n_far_blur = 0.01;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_salazar");
}

dof_rubble_2() {
  n_near_start = 8.6;
  n_near_end = 10;
  n_far_start = 114;
  n_far_end = 938;
  n_near_blur = 0.8;
  n_far_blur = 1.2;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_rubble");
}

dof_civilian_3() {
  n_near_start = 8.6;
  n_near_end = 30;
  n_far_start = 223;
  n_far_end = 1200;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_civ");
}

dof_guard_4() {
  n_near_start = 1.6;
  n_near_end = 20;
  n_far_start = 233;
  n_far_end = 1664;
  n_near_blur = 1.3;
  n_far_blur = 1.2;
  n_time = 1.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1.5;
  level.player depth_of_field_off(0.05);

  iprintlnbold("DOF:dof_guard");
}

dof_gatepull() {
  n_near_start = 1;
  n_near_end = 1.8;
  n_far_start = 72;
  n_far_end = 400;
  n_near_blur = 0.05;
  n_far_blur = 0.05;
  n_time = 0.5;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 5;

  iprintlnbold("DOF:dof_gate_pull");
}

dof_civs() {
  n_near_start = 1;
  n_near_end = 1.8;
  n_far_start = 72;
  n_far_end = 400;
  n_near_blur = 0.1;
  n_far_blur = 0.2;
  n_time = 0.5;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 4;

  iprintlnbold("DOF:dof_civs");

  level.player depth_of_field_off(0.05);
}