/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_zurich_newworld_util.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\cp\cp_mi_zurich_newworld_util;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace newworld_util;

function autoexec __init__sytem__() {
  system::register("newworld_util", & __init__, undefined, undefined);
}

function __init__() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("actor", "derez_ai_deaths", 1, 1, "int", & callback_derez_fx, 0, 0);
  clientfield::register("actor", "cs_rez_in_fx", 1, 2, "counter", & function_9b9abce4, 0, 0);
  clientfield::register("actor", "cs_rez_out_fx", 1, 2, "counter", & function_be66c05b, 0, 0);
  clientfield::register("actor", "chase_suspect_fx", 1, 1, "int", & function_6e7d0ca2, 0, 0);
  clientfield::register("actor", "wall_run_fx", 1, 1, "int", & function_752d4412, 0, 0);
  clientfield::register("scriptmover", "derez_ai_deaths", 1, 1, "int", & callback_derez_fx, 0, 0);
  clientfield::register("scriptmover", "truck_explosion_fx", 1, 1, "int", & function_258012a1, 0, 0);
  clientfield::register("scriptmover", "derez_model_deaths", 1, 1, "int", & callback_derez_fx, 0, 0);
  clientfield::register("scriptmover", "emp_door_fx", 1, 1, "int", & function_ddee6a4e, 0, 0);
  clientfield::register("scriptmover", "smoke_grenade_fx", 1, 1, "int", & function_ce461171, 0, 0);
  clientfield::register("scriptmover", "frag_grenade_fx", 1, 1, "int", & function_1e4e8925, 0, 0);
  clientfield::register("scriptmover", "wall_break_fx", 1, 1, "int", & function_c8c87ed0, 0, 0);
  clientfield::register("scriptmover", "train_explosion_fx", 1, 1, "int", & function_8d759480, 0, 0);
  clientfield::register("scriptmover", "wasp_hack_fx", 1, 1, "int", & function_ec9960ef, 0, 0);
  clientfield::register("vehicle", "wasp_hack_fx", 1, 1, "int", & function_ec9960ef, 0, 0);
  clientfield::register("vehicle", "emp_vehicles_fx", 1, 1, "int", & function_ddee6a4e, 0, 0);
  clientfield::register("world", "player_snow_fx", 1, 4, "int", & callback_player_snow_fx, 0, 0);
  clientfield::register("allplayers", "player_spawn_fx", 1, 1, "int", & callback_ally_spawn_fx, 0, 0);
  clientfield::register("scriptmover", "emp_generator_fx", 1, 1, "int", & function_aad321ae, 0, 0);
  clientfield::register("scriptmover", "train_fx_occlude", 1, 1, "int", & function_73c10276, 0, 0);
  clientfield::register("world", "waterplant_rotate_fans", 1, 1, "int", & function_1e2a542f, 0, 0);
  clientfield::register("world", "train_main_fx_occlude", 1, 1, "int", & function_4f8cc662, 0, 0);
  clientfield::register("toplayer", "train_rumble_loop", 1, 1, "int", & function_b45c2459, 0, 0);
  clientfield::register("toplayer", "postfx_futz", 1, 1, "counter", & postfx_futz, 0, 0);
}

function callback_derez_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1 && isdefined(localclientnum)) {
    self playsound(0, "evt_ai_derez");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_elbow_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_shoulder_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_elbow_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_shoulder_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_head_clean", "j_head");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_left_clean", "j_hip_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_right_clean", "j_hip_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_left_clean", "j_knee_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_right_clean", "j_knee_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_torso_clean", "j_spine4");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_waist_clean", "j_spinelower");
  }
}

function callback_player_snow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayer(localclientnum);
  if(newval == 1) {
    player thread function_120f324e(localclientnum, 1);
  } else {
    if(newval == 2) {
      player thread function_120f324e(localclientnum, 0.5);
    } else {
      if(newval == 3) {
        player thread function_120f324e(localclientnum, 0.25);
      } else {
        if(newval == 4) {
          player notify("stop_snow_fx");
          player function_5677f0fa(localclientnum);
        } else {
          player notify("stop_snow_fx");
          player function_97cc38a5(localclientnum);
        }
      }
    }
  }
}

function function_5677f0fa(localclientnum) {
  if(!isdefined(level.player_snow_fx)) {
    level.player_snow_fx = [];
  }
  self function_97cc38a5();
  n_index = self getentitynumber();
  level.player_snow_fx[n_index] = util::spawn_model(localclientnum, "tag_origin", self.origin);
  level.player_snow_fx[n_index] linkto(self);
  level.player_snow_fx[n_index] thread function_7683b584(self);
  playfxontag(localclientnum, "weather/fx_snow_player_os_nworld", level.player_snow_fx[n_index], "tag_origin");
}

function function_97cc38a5(localclientnum) {
  if(!isdefined(level.player_snow_fx)) {
    level.player_snow_fx = [];
  }
  n_index = self getentitynumber();
  if(isdefined(level.player_snow_fx[n_index])) {
    level.player_snow_fx[n_index] delete();
  }
}

function function_7683b584(player) {
  self endon("death");
  player waittill("death");
  self delete();
}

function function_120f324e(localclientnum, n_delay) {
  self notify("stop_snow_fx");
  self endon("stop_snow_fx");
  self function_97cc38a5(localclientnum);
  while (isdefined(self)) {
    playfxontag(localclientnum, "weather/fx_snow_player_slow_os_nworld", self, "none");
    wait(n_delay);
  }
}

function function_ff1b6796(localclientnum) {
  if(isdefined(self.var_f3f44e9)) {
    return;
  }
  v_offset = (0, 0, 0);
  str_fx = "snow/fx_snow_train_flap_sm";
  if(self.model == "p7_zur_train_car_brake_flap_36") {
    v_offset = vectorscale((1, 0, 0), 36);
    str_fx = "snow/fx_snow_train_flap";
  } else {
    if(self.model == "p7_zur_train_car_brake_flap_48") {
      v_offset = vectorscale((1, 0, 0), 48);
      str_fx = "snow/fx_snow_train_flap_sm";
    } else if(self.model == "p7_zur_train_car_brake_flap_48_yellow") {
      v_offset = vectorscale((1, 0, 0), 48);
      str_fx = "snow/fx_snow_train_flap_sm";
    }
  }
  e_origin = util::spawn_model(localclientnum, "tag_origin", self.origin + v_offset, self.angles);
  e_origin linkto(self);
  self.var_f3f44e9 = e_origin;
  e_origin fx_play_on_tag(localclientnum, "brake_flap_snow", str_fx, "tag_origin");
}

function function_52bc98a1(localclientnum) {
  self fx_play_on_tag(localclientnum, "robot_snow_impact", "snow/fx_snow_train_robot_fall_impact", "tag_origin", 0);
}

function callback_ally_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self fx_play_on_tag(localclientnum, "objective_light", "player/fx_ai_dni_rez_in_hero_clean");
  } else {
    self fx_clear(localclientnum, "objective_light", "player/fx_ai_dni_rez_in_hero_clean");
  }
}

function function_9b9abce4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_left_clean", "j_elbow_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_left_clean", "j_shoulder_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_right_clean", "j_elbow_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_right_clean", "j_shoulder_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_head_clean", "j_head");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_hip_left_clean", "j_hip_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_hip_right_clean", "j_hip_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_leg_left_clean", "j_knee_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_leg_right_clean", "j_knee_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_torso_clean", "j_spine4");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_waist_clean", "j_spinelower");
  if(newval == 2) {
    self thread function_1c2b3dda(localclientnum, 1);
  }
}

function function_be66c05b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_elbow_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_shoulder_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_elbow_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_shoulder_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_head_clean", "j_head");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_left_clean", "j_hip_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_right_clean", "j_hip_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_left_clean", "j_knee_le");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_right_clean", "j_knee_ri");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_torso_clean", "j_spine4");
  function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_waist_clean", "j_spinelower");
  if(newval == 2) {
    self thread function_1c2b3dda(localclientnum, 0);
  }
}

function function_1c2b3dda(localclientnum, var_21082827 = 1) {
  self endon("entityshutdown");
  start_time = gettime();
  if(!var_21082827) {
    self mapshaderconstant(0, 0, "scriptVector0", 0, 0, 0);
  } else {
    self mapshaderconstant(0, 0, "scriptVector0", 1, 0, 0);
  }
  b_is_updating = 1;
  while (b_is_updating) {
    time = gettime();
    time_in_seconds = (time - start_time) / 1000;
    if(time_in_seconds >= 0.5) {
      time_in_seconds = 0.5;
      b_is_updating = 0;
    }
    if(!var_21082827) {
      n_opacity = 1 - (time_in_seconds / 0.5);
    } else {
      n_opacity = time_in_seconds / 0.5;
    }
    self mapshaderconstant(0, 0, "scriptVector0", n_opacity, 0, 0);
    wait(0.01);
  }
  wait(0.05);
  self mapshaderconstant(0, 0, "scriptVector0", 0, 0, 0);
}

function function_bd23b431(localclientnum, str_fx, str_tag) {
  n_fx_id = playfxontag(localclientnum, str_fx, self, str_tag);
  setfxignorepause(localclientnum, n_fx_id, 1);
}

function function_6e7d0ca2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self fx_play_on_tag(localclientnum, "suspect_trail", "player/fx_plyr_ghost_trail_nworld", "tag_origin");
    self fx_play_on_tag(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_LE");
    self fx_play_on_tag(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_RI");
  } else {
    self fx_clear(localclientnum, "suspect_trail", "player/fx_plyr_ghost_trail_nworld");
    self fx_clear(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld");
    self fx_clear(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld");
  }
}

function function_752d4412(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self fx_play_on_tag(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_LE");
    self fx_play_on_tag(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_RI");
  } else {
    self fx_clear(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld");
    self fx_clear(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld");
  }
}

function function_ec9960ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self fx_play_on_tag(localclientnum, "wasp_hack", "vehicle/fx_light_wasp_friendly_hacked", "tag_origin");
  } else {
    self fx_clear(localclientnum, "wasp_hack", "vehicle/fx_light_wasp_friendly_hacked");
  }
}

function function_258012a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self fx_play_on_tag(localclientnum, "truck_explosion", "explosions/fx_exp_truck_slomo_nworld", "tag_fx_front");
  } else {
    self fx_clear(localclientnum, "truck_explosion", "explosions/fx_exp_truck_slomo_nworld");
  }
}

function function_aad321ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playfx(localclientnum, "explosions/fx_exp_emp_lg_nworld", self.origin);
  }
}

function function_73c10276(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.mdl_tag = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    self.mdl_tag linkto(self);
    self.var_c604c399 = addboltedfxexclusionvolume(localclientnum, self.mdl_tag, "tag_origin", (1300 / 2, 450 / 2, 500 / 2));
  } else if(isdefined(self.var_c604c399)) {
    removefxexclusionvolume(localclientnum, self.var_c604c399);
    self.mdl_tag delete();
  }
}

function function_4f8cc662(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    var_c828a8ed = struct::get("train_main_occluder", "targetname");
    var_c828a8ed.var_44fe3058 = util::spawn_model(localclientnum, "tag_origin", var_c828a8ed.origin, var_c828a8ed.angles);
    var_c828a8ed.var_c604c399 = addboltedfxexclusionvolume(localclientnum, var_c828a8ed.var_44fe3058, "tag_origin", (10240 / 2, 400 / 2, 288 / 2));
    var_30cb37a9 = struct::get("train_end_occluder", "targetname");
    var_30cb37a9.var_44fe3058 = util::spawn_model(localclientnum, "tag_origin", var_30cb37a9.origin, var_30cb37a9.angles);
    var_30cb37a9.var_c604c399 = addboltedfxexclusionvolume(localclientnum, var_30cb37a9.var_44fe3058, "tag_origin", (2928 / 2, 400 / 2, 288 / 2));
    var_5987da1 = struct::get_array("train_double_decker_occluder", "targetname");
    foreach(s_org in var_5987da1) {
      s_org.var_44fe3058 = util::spawn_model(localclientnum, "tag_origin", s_org.origin, s_org.angles);
      s_org.var_c604c399 = addboltedfxexclusionvolume(localclientnum, s_org.var_44fe3058, "tag_origin", (1300 / 2, 600 / 2, 680 / 2));
    }
  }
}

function function_ce461171(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.smoke_fx = playfxontag(localclientnum, "explosions/fx_exp_grenade_smoke_nworld", self, "tag_origin");
  } else if(isdefined(self.smoke_fx)) {
    stopfx(localclientnum, self.smoke_fx);
  }
}

function function_1e4e8925(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    e_origin = util::spawn_model(localclientnum, "tag_origin", self.origin);
    e_origin util::delay(30, undefined, & delete);
    e_origin fx_play_on_tag(localclientnum, "frag_grenade", "explosions/fx_exp_grenade_default", "tag_origin");
  } else {
    self fx_clear(localclientnum, "frag_grenade", "explosions/fx_exp_grenade_default");
  }
}

function function_c8c87ed0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    e_origin = util::spawn_model(localclientnum, "tag_origin", self.origin);
    e_origin util::delay(5, undefined, & delete);
    e_origin fx_play_on_tag(localclientnum, "wall_break", "destruct/fx_dest_wall_nworld", "tag_origin");
  } else {
    self fx_clear(localclientnum, "wall_break", "destruct/fx_dest_wall_nworld");
  }
}

function function_8d759480(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self fx_play_on_tag(localclientnum, "train_explosion", "explosions/fx_exp_train_car_nworld", "fx_01_jnt");
  } else {
    self fx_clear(localclientnum, "train_explosion", "explosions/fx_exp_train_car_nworld");
  }
}

function function_ddee6a4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self fx_play_on_tag(localclientnum, "emp_vehicles", "electric/fx_elec_emp_machines_nworld", "tag_origin");
  } else {
    self fx_clear(localclientnum, "emp_vehicles", "electric/fx_elec_emp_machines_nworld");
  }
}

function function_b45c2459(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_dd551c54(localclientnum);
  } else {
    self notify("hash_2608c3ca");
  }
}

function function_dd551c54(localclientnum) {
  self endon("death");
  self endon("entityshutdown");
  self endon("hash_2608c3ca");
  while (true) {
    n_rand_wait = randomfloatrange(2, 7.5);
    wait(n_rand_wait);
    eqtype = randomint(5) + 1;
    v_source = self.origin;
    switch (eqtype) {
      case 1: {
        self thread function_bfff202d(localclientnum, 4);
        break;
      }
      case 2: {
        self thread function_bfff202d(localclientnum, 3.5);
        break;
      }
      case 3: {
        self thread function_bfff202d(localclientnum, 3);
        break;
      }
      case 4: {
        self thread function_bfff202d(localclientnum, 2.5);
        break;
      }
      case 5: {
        self thread function_bfff202d(localclientnum, 2);
        break;
      }
      default: {
        break;
      }
    }
  }
}

function function_bfff202d(localclientnum, n_duration) {
  self endon("death");
  self endon("entityshutdown");
  self endon("hash_2608c3ca");
  if(isdefined(n_duration)) {
    __s = spawnstruct();
    __s endon("timeout");
    __s util::delay_notify(n_duration, "timeout");
  }
  while (true) {
    self playrumbleonentity(localclientnum, "cp_newworld_rumble_train_roof_loop");
    wait(0.185);
  }
}

function fx_clear(localclientnum, str_type, str_fx) {
  if(!isdefined(self.a_fx)) {
    self.a_fx = [];
  }
  if(!isdefined(self.a_fx[localclientnum])) {
    self.a_fx[localclientnum] = [];
  }
  if(!isdefined(self.a_fx[localclientnum][str_type])) {
    self.a_fx[localclientnum][str_type] = [];
  }
  if(isdefined(str_fx) && isdefined(self.a_fx[localclientnum][str_type][str_fx])) {
    n_fx_id = self.a_fx[localclientnum][str_type][str_fx];
    deletefx(localclientnum, n_fx_id, 0);
    self.a_fx[localclientnum][str_type][str_fx] = undefined;
  }
}

function fx_delete_type(localclientnum, str_type, b_stop_immediately = 1) {
  if(isdefined(self.a_fx) && isdefined(self.a_fx[localclientnum]) && isdefined(self.a_fx[localclientnum][str_type])) {
    a_keys = getarraykeys(self.a_fx[localclientnum][str_type]);
    for (i = 0; i < a_keys.size; i++) {
      deletefx(localclientnum, self.a_fx[localclientnum][str_type][a_keys[i]], b_stop_immediately);
      self.a_fx[localclientnum][str_type][a_keys[i]] = undefined;
    }
  }
}

function fx_play_on_tag(localclientnum, str_type, str_fx, str_tag = "tag_origin", b_kill_fx_with_same_type = 1, var_ff19846d = 0) {
  self fx_clear(localclientnum, str_type, str_fx);
  if(b_kill_fx_with_same_type) {
    self fx_delete_type(localclientnum, str_type, 0);
  }
  n_fx_id = playfxontag(localclientnum, str_fx, self, str_tag);
  if(var_ff19846d == 1) {
    setfxignorepause(localclientnum, n_fx_id, var_ff19846d);
  }
  self.a_fx[localclientnum][str_type][str_fx] = n_fx_id;
}

function fx_play(localclientnum, str_type, str_fx, b_kill_fx_with_same_type = 1, v_pos, v_forward, v_up, var_ff19846d = 0) {
  self fx_clear(localclientnum, str_type, str_fx);
  if(b_kill_fx_with_same_type) {
    self fx_delete_type(localclientnum, str_type, 0);
  }
  if(isdefined(v_forward) && isdefined(v_up)) {
    n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward, v_up);
  } else {
    if(isdefined(v_forward)) {
      n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward);
    } else {
      n_fx_id = playfx(localclientnum, str_fx, v_pos);
    }
  }
  setfxignorepause(localclientnum, n_fx_id, var_ff19846d);
  self.a_fx[localclientnum][str_type][str_fx] = n_fx_id;
}

function postfx_futz(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self postfx::playpostfxbundle("pstfx_dni_screen_futz");
  }
}

function function_1e2a542f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_17287685 = getent(localclientnum, "wt_fan_01", "targetname");
  var_3d2af0ee = getent(localclientnum, "wt_fan_02", "targetname");
  var_632d6b57 = getent(localclientnum, "wt_fan_03", "targetname");
  var_591c1278 = getent(localclientnum, "wt_fan_04", "targetname");
  if(newval != oldval && newval == 1) {
    var_17287685 thread function_65012f08();
    wait(0.1);
    var_3d2af0ee thread function_65012f08();
    wait(0.1);
    var_632d6b57 thread function_65012f08();
    wait(0.1);
    var_591c1278 thread function_65012f08();
  }
  if(newval == 0) {
    level notify("hash_c78324b7");
    var_17287685 delete();
    var_3d2af0ee delete();
    var_632d6b57 delete();
    var_591c1278 delete();
  }
}

function function_65012f08() {
  self endon("hash_c78324b7");
  rotate_time = 3;
  while (true) {
    self rotateyaw(180, rotate_time);
    self waittill("rotatedone");
  }
}