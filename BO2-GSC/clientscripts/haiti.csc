/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\haiti.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_glasses;
#include clientscripts\haiti_fx;
#include clientscripts\_load;
#include clientscripts\_claw_grenade;
#include clientscripts\_fire_direction;
#include clientscripts\haiti_amb;
#include clientscripts\_audio;

main() {
  clientscripts\haiti_fx::main();
  clientscripts\_load::main();
  clientscripts\_claw_grenade::main();
  thread clientscripts\_fire_direction::init();
  clientscripts\haiti_amb::snd_create_randoms();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\haiti_amb::main();
  register_clientflag_callback("actor", 12, ::toggle_camo_suit);
  register_clientflag_callback("scriptmover", 6, ::set_sky_fog);
  init_lighting_pairs();
  waitforclient(0);

  println("*** Client : haiti running...");

  setup_fullscreen_postfx();
  level thread reset_fov();
  level thread scenarios_fov();
  level thread helmet_crack_sound();
  level thread walkway_bridge_pieces();
}

setup_fullscreen_postfx() {
  init_filter_oxygenmask(level.localplayers[0]);
  set_filter_oxygenmask_amount(level.localplayers[0], 0, 1.0);
  set_filter_oxygenmask_smoke_amount(level.localplayers[0], 0, 0.0);
  set_filter_oxygenmask_radialblur_amount(level.localplayers[0], 0, 0.0);
  set_filter_oxygenmask_condensation_amount(level.localplayers[0], 1, 0.0);
  level.mask_crack_stage = 1;
  level.mask_smoke_amount = 0;
}

put_on_oxygen_mask() {
  enable_filter_oxygenmask(level.localplayers[0], 0, 1, 0, 1);
}

take_off_oxygen_mask() {
  disable_filter_oxygenmask(level.localplayers[0], 0, 1, 0);
}

oxygen_mask_crack() {
  level.mask_crack_stage = level.mask_crack_stage + 1;
  level.mask_crack_stage = min(level.mask_crack_stage, 4);
  level notify("h_crk");
  set_filter_oxygenmask_crack_state(level.localplayers[0], 0, level.mask_crack_stage);
}

helmet_crack_sound() {
  while(true) {
    level waittill("h_crk");
    playsound(0, "veh_jetwing_helmet_crack");
  }
}

oxygen_mask_smoke() {
  level endon("mask_smoke_clear");
  level notify("mask_smoke");

  while(level.mask_smoke_amount < 1) {
    level.mask_smoke_amount = level.mask_smoke_amount + 1 * 0.05;

    if(level.mask_smoke_amount > 1)
      level.mask_smoke_amount = 1;

    set_filter_oxygenmask_smoke_amount(level.localplayers[0], 0, level.mask_smoke_amount);
    wait 0.05;
  }
}

oxygen_mask_smoke_clear() {
  level endon("mask_smoke");
  level notify("mask_smoke_clear");

  while(level.mask_smoke_amount > 0) {
    level.mask_smoke_amount = level.mask_smoke_amount - 1 * 0.05;

    if(level.mask_smoke_amount < 0)
      level.mask_smoke_amount = 0;

    set_filter_oxygenmask_smoke_amount(level.localplayers[0], 0, level.mask_smoke_amount);
    wait 0.05;
  }
}

oxygen_mask_blur() {
  set_filter_oxygenmask_radialblur_amount(level.localplayers[0], 0, 0.35);
}

set_intro_fog() {
  setworldfogactivebank(0, 1);
  set_filter_oxygenmask_condensation_amount(level.localplayers[0], 1, 0.0);
}

set_cloud_fog() {
  setworldfogactivebank(0, 2);
  set_filter_oxygenmask_condensation_amount(level.localplayers[0], 1, 1.0);
}

walkway_bridge_pieces() {
  a_n_piece_index[0] = findstaticmodelindex((-9086.79, 7458.75, 490.92));
  a_n_piece_index[1] = findstaticmodelindex((-8311.01, 7409.58, 333.43));
  a_n_piece_index[2] = findstaticmodelindex((-7686.81, 7519.54, 454.5));

  foreach(n_index in a_n_piece_index) {
    if(isDefined(n_index))
      hidestaticmodel(n_index);
  }

  level waittill("unhide_debris");

  foreach(n_index in a_n_piece_index) {
    if(isDefined(n_index))
      unhidestaticmodel(n_index);
  }
}

toggle_camo_suit(localclientnum, set, newent) {
  self endon("entityshutdown");
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  s_timer = new_timer();

  if(set) {
    println("**** AI at origin " + self.origin + " camo suit turned off****");

    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0, 1, n_current_time / 3);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 3);
  } else {
    println("**** AI at origin " + self.origin + " camo suit turned on****");

    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0, n_current_time / 3);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 3);
  }
}

set_sky_fog(localclientnum, set, newent) {
  self endon("entityshutdown");
  self mapshaderconstant(localclientnum, 0, "ScriptVector0", 0, 0, 0, 0);
  s_timer = new_timer();

  if(set) {
    println("**** AI at origin " + self.origin + " camo suit turned off****");

    self mapshaderconstant(localclientnum, 0, "ScriptVector0", 0, 0, 0, 0);

    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0, 1, n_current_time / 1);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 1);
  } else {
    self mapshaderconstant(localclientnum, 0, "ScriptVector0", 1, 0, 0, 0);

    println("**** AI at origin " + self.origin + " camo suit turned on****");

    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0, n_current_time / 0.5);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 0.5);
  }
}

reset_fov() {
  level waittill("fov_reset");
  lerp_fov_overtime(1.0, getdvarfloat(#"cg_fov_default"));
}

scenarios_fov() {
  level waittill("fov_change_1_start");
  lerp_fov_overtime(2.0, 26);
  level waittill("fov_change_1");
  lerp_fov_overtime(0.5, 45);
  level waittill("fov_change_2");
  lerp_fov_overtime(1.5, 35);
  level waittill("fov_change_3");
  lerp_fov_overtime(1.0, getdvarfloat(#"cg_fov_default"));
}

lerp_fov_overtime(time, dest) {
  basefov = getdvarfloat(#"cg_fov");
  incs = int(time / 0.05);
  incfov = (dest - basefov) / incs;
  currentfov = basefov;

  if(incfov == 0) {
    return;
  }
  for(i = 0; i < incs; i++) {
    currentfov = currentfov + incfov;
    setclientdvar("cg_fov", currentfov);
    wait 0.05;
  }

  setclientdvar("cg_fov", dest);
}

screen_flash() {
  playsound(0, "evt_smashcut_flash", (0, 0, 0));
  screen_flash_visionset();
}

screen_flash_dvar() {
  n_exposure = getdvarfloat(#"r_exposureValue");
  setdvar("r_exposureTweak", 1);
  setdvarfloat("r_exposureValue", -6);
  wait(frames(3));
  lerp_dvar("r_exposureValue", -6, n_exposure, frames(2.5 - 1.5), 0);
  setdvar("r_exposureTweak", 0);
}

screen_flash_visionset() {
  str_vision_set = getvisionsetnaked(0);
  visionsetnaked(0, "camera_flash", 0);
  wait(frames(3));
  visionsetnaked(0, str_vision_set, frames(2.5 - 1.5));
}

frames(n_frame_count) {
  return n_frame_count * 0.01666;
}