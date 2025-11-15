/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\karma.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_glasses;
#include clientscripts\karma_utility;
#include clientscripts\_argus;
#include clientscripts\karma_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\karma_amb;
#include clientscripts\_driving_fx;
#include clientscripts\_spiderbot_ride;

main() {
  clientscripts\karma_fx::main();
  clientscripts\_load::main();
  level thread clientscripts\_audio::audio_init(0);
  level thread clientscripts\karma_amb::main();
  clientscripts\_driving_fx::init();
  clientscripts\_spiderbot_ride::init();
  register_clientflag_callback("scriptmover", 8, ::face_swap_init);
  register_clientflag_callback("scriptmover", 3, ::face_swap_other);
  register_clientflag_callback("scriptmover", 5, ::face_swap_player);
  init_lighting_pairs();
  level.onargusnotify = ::onargusnotify;
  waitforclient(0);

  println("*** Client : karma running...");

  level thread increase_lighting();
  level thread fov_listener("fov_zoom_e7_defalco_chase", 16);
  level thread fov_listener("fov_zoom", 10);
  level thread fov_listener("fov_zoom_hi", 3);
  level thread fov_listener("fov_normal", 70);
}

face_swap_init(localclientnum, set, newent) {
  a_n_layer_transparency[0] = 0;
  a_n_layer_transparency[1] = 1;
  a_n_layer_transparency[2] = 1;
  a_n_layer_transparency[3] = 0;
  a_n_layer_transparency[4] = 1;
  self thread face_swap(localclientnum, a_n_layer_transparency);
}

face_swap_other(localclientnum, set, newent) {
  if(set) {
    a_n_layer_transparency[0] = 0;
    a_n_layer_transparency[1] = 0;
    a_n_layer_transparency[2] = 1;
    a_n_layer_transparency[3] = 1;
    a_n_layer_transparency[4] = 1;
  } else {
    a_n_layer_transparency[0] = 0;
    a_n_layer_transparency[1] = 1;
    a_n_layer_transparency[2] = 1;
    a_n_layer_transparency[3] = 0;
    a_n_layer_transparency[4] = 1;
  }

  self thread face_swap(localclientnum, a_n_layer_transparency);
}

face_swap_player(localclientnum, set, newent) {
  if(set) {
    a_n_layer_transparency[0] = 0;
    a_n_layer_transparency[1] = 1;
    a_n_layer_transparency[2] = 0;
    a_n_layer_transparency[3] = 1;
    a_n_layer_transparency[4] = 1;
  } else {
    a_n_layer_transparency[0] = 0;
    a_n_layer_transparency[1] = 1;
    a_n_layer_transparency[2] = 1;
    a_n_layer_transparency[3] = 0;
    a_n_layer_transparency[4] = 1;
  }

  self thread face_swap(localclientnum, a_n_layer_transparency);
}

face_swap(localclientnum, a_n_target_val) {
  self notify("face_swap_end");
  self endon("face_swap_end");
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  self mapshaderconstant(localclientnum, 1, "ScriptVector1");

  if(!isDefined(self.n_layer_transparency)) {
    for(i = 0; i < a_n_target_val.size; i++)
      self.n_layer_transparency[i] = a_n_target_val[i];
  }

  a_n_step = [];

  for(i = 0; i < a_n_target_val.size; i++) {
    if(self.n_layer_transparency[i] < a_n_target_val[i]) {
      a_n_step[i] = 0.02;
      continue;
    }

    if(self.n_layer_transparency[i] > a_n_target_val[i]) {
      a_n_step[i] = -0.02;
      continue;
    }

    a_n_step[i] = 0;
  }

  n_step_time = 0.02;
  b_transitioning = 1;

  while(b_transitioning) {
    b_transitioning = 0;

    for(i = 0; i < self.n_layer_transparency.size; i++) {
      self.n_layer_transparency[i] = self.n_layer_transparency[i] + a_n_step[i];

      if(self.n_layer_transparency[i] != a_n_target_val[i]) {
        b_transitioning = 1;

        if(a_n_step[i] > 0 && self.n_layer_transparency[i] > a_n_target_val[i] || a_n_step[i] < 0 && self.n_layer_transparency[i] < a_n_target_val[i])
          self.n_layer_transparency[i] = a_n_target_val[i];
      }
    }

    self setshaderconstant(localclientnum, 0, self.n_layer_transparency[0], self.n_layer_transparency[1], self.n_layer_transparency[2], self.n_layer_transparency[3]);
    wait(n_step_time);
  }

  self setshaderconstant(localclientnum, 0, a_n_target_val[0], a_n_target_val[1], a_n_target_val[2], a_n_target_val[3]);
}

argusbuildui(localclientnum, usertag) {
  switch (usertag) {
    case "heli_vtol":
      return argusimageandtext2ui(localclientnum, "white", & "KARMA_ARGUS_HELI_VTOL", & "KARMA_ARGUS_HELI_VTOL_INFO");
    case "metal_storm":
      return argusimageandtext2ui(localclientnum, "white", & "KARMA_ARGUS_METAL_STORM", & "KARMA_ARGUS_METAL_STORM_INFO");
    case "al_jinan":
      return argusimageandtext2ui(localclientnum, "white", & "KARMA_ARGUS_AL_JINAN", & "KARMA_ARGUS_AL_JINAN_INFO");
    case "scanner":
      return argusimageandtext2ui(localclientnum, "white", & "KARMA_ARGUS_SCANNER", & "KARMA_ARGUS_SCANNER_INFO");
    case "heli_hip":
      return argusimageandtext2ui(localclientnum, "white", & "KARMA_ARGUS_HELI_HIP", & "KARMA_ARGUS_HELI_HIP_INFO");
  }
}

onargusnotify(localclientnum, argusid, usertag, message) {
  switch (message) {
    case "buildui":
      return argusbuildui(localclientnum, usertag);
    case "create":
      argussetbracket(argusid, "square_bound");

      switch (usertag) {
        case "heli_hip":
          argussetdistance(argusid, 20000);
          break;
        case "heli_vtol":
          argussetdistance(argusid, 20000);
          break;
        case "marked_target":
          argussetdistance(argusid, 2048);
          argusforcedrawbracket(argusid, 1);
          break;
        case "metal_storm":
          break;
      }

      break;
    case "in":
      break;
    case "active":
      break;
    case "out":
      break;
  }

  return 1;
}

increase_lighting() {
  setgenericscenevalue(0, 0, 0);
  level waittill("clon");
  n_light_current = 0.0;
  n_light_goal = 1.0;
  n_time = 1.0;
  n_step_time = 0.01;
  n_steps = n_time / n_step_time;
  n_step_value = (n_light_goal - n_light_current) / n_steps;

  for(i = 0; i < n_steps; i++) {
    n_light_current = n_light_current + n_step_value;
    setgenericscenevalue(0, 0, n_light_current);
    wait(n_step_time);
  }

  setgenericscenevalue(0, 0, n_light_goal);
}