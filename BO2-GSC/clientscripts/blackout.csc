/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\blackout.csc
**************************************/

#include clientscripts\_filter;
#include clientscripts\_glasses;
#include clientscripts\_utility;
#include clientscripts\blackout_fx;
#include clientscripts\_load;
#include clientscripts\_gasmask;
#include clientscripts\blackout_amb;
#include clientscripts\_audio;
#include clientscripts\_fire_direction;
#include clientscripts\_footsteps;

main() {
  clientscripts\blackout_fx::main();
  clientscripts\_load::main();
  clientscripts\_gasmask::init();
  clientscripts\blackout_amb::snd_create_randoms();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\blackout_amb::main();
  thread clientscripts\_fire_direction::init();
  thread sensitive_geo_fog();
  register_clientflag_callback("scriptmover", 13, ::toggle_holo_table);
  register_clientflag_callback("scriptmover", 11, ::run_extracam_primary);
  register_clientflag_callback("scriptmover", 14, ::run_extracam_secondary);
  register_clientflag_callback("actor", 12, ::blood_shoulder);
  register_clientflag_callback("actor", 0, ::karma_shot_blood);
  init_lighting_pairs();
  thread run_intro_cam();
  init_filter_massiah(level.localplayers[0]);
  waitforclient(0);

  println("*** Client : blackout running...");

  thread toggle_multi_extracam();
  clientscripts\_footsteps::registeraitypefootstepcb("Ally_SEAL_Pakistan_Bigdog", clientscripts\_footsteps::bigdogfootstepcbfunc);
}

sensitive_geo_fog() {
  level waittill("fog_level_increase");
  setworldfogactivebank(0, 1);
}

lerp_cam_fov(time_s, old_fov, new_fov) {
  frame_time_s = 0.0166667;
  n_lerp_frames = time_s / frame_time_s;

  for(n_frame = 1; n_frame <= n_lerp_frames; n_frame++) {
    pct = n_frame / n_lerp_frames;
    cur_fov = old_fov + pct * (new_fov - old_fov);
    setextracamfov(0, cur_fov);
    wait(frame_time_s);
  }

  setextracamfov(0, new_fov);
}

min_max(val, min, max) {
  if(val < min)
    return min;
  else if(val > max)
    return max;
  else
    return val;
}

extra_cam_mirror_fov() {
  level endon("mirror_off");
  frame_time_s = 0.0166667;
  dist_min = 0;
  dist_max = 512;
  fov_min = 70;
  fov_max = 40;
  player = getlocalplayers()[0];

  while(true) {
    cam_pos = player getcampos();
    dist = distance2d(self.origin, cam_pos);
    dist = min_max(dist, dist_min, dist_max);
    dist_pct = (dist - dist_min) / (dist_max - dist_min);
    fov = fov_min + (fov_max - fov_min) * dist_pct;
    setextracamfov(0, fov);
    wait(frame_time_s);
  }
}

run_extracam_primary(localclientnum, set, newent) {
  if(!isDefined(level.extra_cam_active_primary))
    level.extra_cam_active_primary = 0;

  if(!level.extra_cam_active_primary && set) {
    println("**** extra cam on - client****");

    level.extra_cam_active_primary = 1;
    self isextracam(localclientnum, 0);
    setextracamfov(0, 60, 0);
  } else if(level.extra_cam_active_primary && !set) {
    println("**** extra cam off - client****");

    stopextracam(localclientnum, 0);
    level.extra_cam_active_primary = 0;
  }
}

run_extracam_secondary(localclientnum, set, newent) {
  if(!isDefined(level.extra_cam_active_seconday)) {
    level.extra_cam_active_seconday = 0;
    level notify("mirror_off");
  }

  if(!level.extra_cam_active_seconday && set) {
    println("**** extra cam on - client****");

    level.extra_cam_active_seconday = 1;
    self isextracam(localclientnum, 1);
  } else if(level.extra_cam_active_seconday && !set) {
    println("**** extra cam off - client****");

    level notify("mirror_off");
    setextracamfov(0, 60, 1);
    stopextracam(localclientnum, 1);
    level.extra_cam_active_seconday = 0;
  }
}

run_intro_cam() {
  level endon("intro_cctv_complete");
  level waittill("intro_cctv_assigned");
  setextracamfov(0, 55);
  level waittill("intro_cctv_started");
  wait 3.0;
  lerp_cam_fov(3, 55, 57);
  wait 5.0;
  lerp_cam_fov(3, 57, 60);
}

blood_shoulder(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");

  println("**** starting blood shoulder - client****");

  unused = 0;
  n_transition_time = 5;
  s_timer = new_timer();

  do {
    wait 0.01;
    n_current_time = s_timer get_time_in_seconds();
    n_delta_val = lerpfloat(0, 0.8, n_current_time / n_transition_time);
    self setshaderconstant(localclientnum, 0, unused, n_delta_val, unused, unused);
  }
  while(n_current_time < n_transition_time);
}

toggle_holo_table(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  unused = 0;

  if(set)
    self setshaderconstant(localclientnum, 0, unused, unused, unused, 1);
  else
    self setshaderconstant(localclientnum, 0, unused, unused, unused, 0);
}

set_flag_messiah_mode(localclientnum, set, newent) {
  if(!isDefined(level.messiah_mode_on))
    level.messiah_mode_on = !set;

  if(set && !level.messiah_mode_on) {
    enable_filter_massiah(level.localplayers[0], 1);
    set_filter_massiah_amount(level.localplayers[0], 1, 1.0);
  } else if(!set && level.messiah_mode_on)
    disable_filter_massiah(level.localplayers[0], 1);

  level.messiah_mode_on = set;
}

play_swaying_lights() {
}

karma_shot_blood(localclientnum, set, newent) {
  n_frames = int(3 / 0.016);
  n_step_size = (0.82 - 0) / n_frames;
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");

  if(set) {
    for(i = 0; i < n_frames; i++) {
      n_value = 0 + n_step_size * i;
      self setshaderconstant(localclientnum, 0, 0, n_value, 0, 0);
      wait 0.016;
    }
  } else
    self setshaderconstant(localclientnum, 0, 0, 0, 0, 0);
}

toggle_multi_extracam() {
  while(true) {
    level waittill("start_multi_extracam");
    setmultiextracamactive(0, 1);
    level waittill("stop_multi_extracam");
    setmultiextracamactive(0, 0);
  }
}