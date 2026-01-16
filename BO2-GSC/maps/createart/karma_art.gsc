/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\karma_art.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 15);
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
    case "sp_karma_flyin_desat":
      n_vs_time = 0.0;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      setsaveddvar("sm_sunSampleSizeNear", 0.5);
      setsaveddvar("sm_sunAlwaysCastsShadow", 1);
      break;
    case "sp_karma_flyin":
      n_vs_time = 3;
      break;
    case "sp_karma_intro":
      n_vs_time = 3;
      setdvar("r_rimIntensity_debug", 2);
      setdvar("r_rimIntensity", 15);
      setsaveddvar("sm_sunAlwaysCastsShadow", 0);
      wait 5;
      break;
    case "sp_karma_IntroGlassesTint":
      n_vs_time = 0.8;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      break;
    case "sp_karma_IntroGlassesOn":
      n_vs_time = 4;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      break;
    case "sp_karma_security":
      n_vs_time = 3;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 6);
      break;
    case "sp_karma_elevators":
      n_vs_time = 2;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 6);
      break;
    case "sp_karma_vista":
      n_vs_time = 3;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 6);
      break;
    case "sp_karma_lobby":
      n_vs_time = 3;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 6);
      break;
    case "sp_karma_elevator_atrium":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 4);
      break;
    case "sp_karma_entertainmentdeck01":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 4.5);
      setsaveddvar("sm_sunSampleSizeNear", 0.5);
      break;
    case "sp_karma_ClubMain":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 50);
      break;
    case "sp_karma_construction":
      n_vs_time = 3;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 3);
      break;
    case "sp_karma_crc":
      n_vs_time = 3;
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 3);
      break;
    case "sp_karma_crc_screens":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 1);
      break;
    case "sp_karma_office":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 3);
      break;
  }

  visionsetnaked(str_vision_set, n_vs_time);
  level.karma_vision = str_vision_set;

  if(isDefined(n_near_start) && isDefined(n_time))
    self thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  else
    self depth_of_field_off(0.05);
}

karma_fog_sunset() {
  visionsetnaked("karma_sunset", 2);
}

defalco_encounter_dof01() {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 73;
  n_far_end = 80;
  n_near_blur = 0.8;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:encounter_01");
}

defalco_encounter_dof02() {
  n_near_start = 1;
  n_near_end = 86;
  n_far_start = 128.7;
  n_far_end = 844;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:encounter_02");
}

defalco_encounter_dof03() {
  n_near_start = 1;
  n_near_end = 120;
  n_far_start = 215;
  n_far_end = 844;
  n_near_blur = 0.5;
  n_far_blur = 0.8;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:encounter_03");
}

defalco_encounter_dof04() {
  n_near_start = 1;
  n_near_end = 120;
  n_far_start = 215;
  n_far_end = 930;
  n_near_blur = 0.5;
  n_far_blur = 0.3;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:encounter_04");
}

defalco_encounter_dof05() {
  n_near_start = 1;
  n_near_end = 27.7;
  n_far_start = 215;
  n_far_end = 276;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.7;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:encounter_05");
}

defalco_encounter_dof06() {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 1031;
  n_far_end = 2118;
  n_near_blur = 0.1;
  n_far_blur = 0.1;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

vtol_dof_1(ent) {
}

vtol_dof_2(ent) {
  visionsetnaked("sp_karma_vtol_interior", 0.5);
  n_vs_time = 1.5;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 6);
}

vtol_dof_3(ent) {
  visionsetnaked("sp_karma_flyin", 0.5);
}

vtol_dof_4(ent) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 2156;
  n_far_end = 3012;
  n_near_blur = 1;
  n_far_blur = 0.2;
  n_time = 5;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1;
  level.player depth_of_field_off(3);
}

spiderbot_general_dof() {
  setsaveddvar("cg_dof_useDefaultForVehicle", 0);
  n_near_start = 1;
  n_near_end = 10;
  n_far_start = 30;
  n_far_end = 150;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  level.player depth_of_field_off(0.05);
  visionsetnaked("karma_spiderbot", 0.0);
  setsaveddvar("vc_LUT", 4);
}

spiderbot_security_dof() {
  visionsetnaked("karma_spiderbot_tazer_dude", 2);
}

dof_vent() {
  n_near_start = 1;
  n_near_end = 159;
  n_far_start = 264;
  n_far_end = 318;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_vent");
}

starts_slow() {
  n_near_start = 1;
  n_near_end = 57;
  n_far_start = 60;
  n_far_end = 76;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_guard() {
  n_near_start = 1;
  n_near_end = 57;
  n_far_start = 60;
  n_far_end = 76;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_guard");
}

dof_guardfallen() {
  n_near_start = 1;
  n_near_end = 57;
  n_far_start = 60;
  n_far_end = 76;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_guardfallen");
}

dof_eyescan() {
  n_near_start = 1;
  n_near_end = 57;
  n_far_start = 60;
  n_far_end = 76;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_eyescan");

  level.player depth_of_field_off(0.05);
}

start_scan() {
  n_near_start = 0;
  n_near_end = 0;
  n_far_start = 0;
  n_far_end = 0;
  n_near_blur = 0;
  n_far_blur = 0;
  n_time = 0;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_scan");

  level.player depth_of_field_off(0.05);
}

dof_caught() {
  n_near_start = 1;
  n_near_end = 57;
  n_far_start = 60;
  n_far_end = 76;
  n_near_blur = 0;
  n_far_blur = 0;
  n_time = 0.1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_caught");
}

dof_stomp() {
  n_near_start = 1;
  n_near_end = 57;
  n_far_start = 60;
  n_far_end = 76;
  n_near_blur = 0;
  n_far_blur = 0;
  n_time = 0.1;
  wait 1;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_stomp");

  level.player depth_of_field_off(0.05);
  setsaveddvar("vc_LUT", 0);
}