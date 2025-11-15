/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\nicaragua_art.gsc
********************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 15);
  set_default_visionset();
  run_thread_on_targetname("vision_trigger", ::vision_set_trigger_think);
}

vision_set_trigger_think() {
  self endon("death");

  while(true) {
    self waittill("trigger");

    if(level.nicaragua_vision != self.script_string) {
      vision_set_change(self.script_string);
      level.player thread change_back_to_default_visionset(self);
    }

    wait 0.05;
  }
}

vision_set_change(str_vision_set) {
  switch (str_vision_set) {
    case "sp_nicaragua_josephina":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 1);
      break;
    case "sp_nicaragua_stables":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      break;
    case "sp_nicaragua_cocainebunker":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
      break;
  }

  visionsetnaked(str_vision_set, 2);
  level.nicaragua_vision = str_vision_set;
}

change_back_to_default_visionset(e_touching) {
  level notify("another_visionset_triggered");
  level endon("another_visionset_triggered");
  self wait_while_player_touching_ent(e_touching);
  wait 0.25;
  set_default_visionset();
}

set_default_visionset() {
  visionsetnaked("sp_nicaragua_default", 2);
  level.nicaragua_vision = "sp_nicaragua_default";
}

wait_while_player_touching_ent(e_touching) {
  while(self istouching(e_touching))
    wait 0.05;
}

bunker_exposure_scale() {
  level endon("player_left_bunker");

  while(true) {
    level waittill("mason_bunker_fake_mortar");
    n_iterations = randomintrange(2, 5);
    clientnotify("bunker_01_flicker");

    for(i = 0; i < n_iterations; i++) {
      n_blend_time = randomfloatrange(0.1, 0.5);
      blend_exposure_over_time(1.6, n_blend_time);
      wait(randomfloatrange(0.1, 0.25));
      n_blend_time = randomfloatrange(0.1, 0.5);
      blend_exposure_over_time(2.2, n_blend_time);
      wait(randomfloatrange(0.1, 0.25));
    }

    clientnotify("bunker_01_flicker");
  }
}

blend_exposure_over_time(n_exposure_final, n_time) {
  n_frames = int(n_time * 20);
  n_exposure_current = getdvarfloat(#"r_exposureValue");
  n_exposure_change_total = n_exposure_final - n_exposure_current;
  n_exposure_change_per_frame = n_exposure_change_total / n_frames;
  setdvar("r_exposureTweak", 1);

  for(i = 0; i < n_frames; i++) {
    setdvar("r_exposureValue", n_exposure_current + n_exposure_change_per_frame * i);
    wait 0.05;
  }

  setdvar("r_exposureValue", n_exposure_final);
  setdvar("r_exposureTweak", 0);
}

bunker_lights_flicker() {
  level endon("player_left_bunker");

  while(true) {
    level waittill("mason_bunker_fake_mortar");
    clientnotify("bunker_01_flicker");
    wait(randomfloatrange(1.0, 3.0));
    clientnotify("bunker_01_flicker");
  }
}

dof_mirror() {
  n_near_start = 0.8;
  n_near_end = 25;
  n_far_start = 100;
  n_far_end = 620;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_mirror");
}

dof_pendant() {
  n_near_start = 0.8;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 620;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_pendant");
}

dof_josefina() {
  n_near_start = 0.8;
  n_near_end = 10;
  n_far_start = 11664;
  n_far_end = 11991;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_josefina");
}

dof_door_guy() {
  n_near_start = 0.8;
  n_near_end = 10;
  n_far_start = 11664;
  n_far_end = 11991;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_door_guy");
}

dof_struggle() {
  n_near_start = 1;
  n_near_end = 11;
  n_far_start = 59;
  n_far_end = 272;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_struggle");
}

dof_leader() {
  n_near_start = 1;
  n_near_end = 11;
  n_far_start = 59;
  n_far_end = 272;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_leader");
}

dof_josefina_struggle() {
  n_near_start = 1;
  n_near_end = 11;
  n_far_start = 59;
  n_far_end = 272;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_josefina_struggle");
}

dof_stab() {
  n_near_start = 1;
  n_near_end = 11;
  n_far_start = 59;
  n_far_end = 272;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_stab");
}

dof_syringe() {
  n_near_start = 1;
  n_near_end = 11;
  n_far_start = 59;
  n_far_end = 272;
  n_near_blur = 1;
  n_far_blur = 0.5;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_syringe");

  level.player depth_of_field_off(3);
}

dof_rubble() {
  n_near_start = 0.8;
  n_near_end = 25;
  n_far_start = 100;
  n_far_end = 620;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_rubble");
}

dof_woods1() {
  n_near_start = 0.8;
  n_near_end = 25;
  n_far_start = 100;
  n_far_end = 620;
  n_near_blur = 1;
  n_far_blur = 0.8;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_woods1");
}

dof_body() {
  n_near_start = 1;
  n_near_end = 7;
  n_far_start = 96;
  n_far_end = 372;
  n_near_blur = 0.1;
  n_far_blur = 0.2;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_body");
}

dof_woods2() {
  n_near_start = 1;
  n_near_end = 7;
  n_far_start = 96;
  n_far_end = 372;
  n_near_blur = 0.1;
  n_far_blur = 0.2;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_woods2");
}

dof_convo() {
  n_near_start = 0.8;
  n_near_end = 25;
  n_far_start = 100;
  n_far_end = 620;
  n_near_blur = 1;
  n_far_blur = 0.2;
  n_time = 0.2;
  level.player thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);

  iprintlnbold("DOF:dof_convo");
}