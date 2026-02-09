/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_jump_pad.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_jump_pad;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_moon_gravity;
#namespace zm_moon_jump_pad;

function init() {
  level._uses_jump_pads = 1;
  level moon_jump_pad_overrides();
  level thread moon_biodome_temptation_init();
  level thread moon_jump_pads_low_gravity();
  level thread moon_jump_pads_malfunctions();
  level thread moon_jump_pad_cushion_sound_init();
}

function moon_jump_pad_overrides() {
  level._jump_pad_override["biodome_logic"] = &moon_jump_pad_progression_end;
  level._jump_pad_override["low_grav"] = &moon_low_gravity_velocity;
  level._jump_pad_override["moon_vertical_jump"] = &moon_vertical_jump;
  level._jump_pad_poi_start_override = &moon_zombie_run_change;
  zm::register_player_damage_callback(&function_4b3d145d);
  level flag::init("pad_allow_anim_change");
  level._jump_pad_anim_change = [];
  level flag::set("pad_allow_anim_change");
}

function function_4b3d145d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(smeansofdeath === "MOD_FALLING") {
    if(isDefined(self._padded) && self._padded) {
      var_6f51be76 = arraygetclosest(self.origin, level.cushion_sound_triggers);
      if(self istouching(var_6f51be76)) {
        return 0;
      }
      var_f5f4e9cc = arraygetclosest(self.origin, getEntArray("trig_jump_pad", "targetname"));
      if(self istouching(var_f5f4e9cc)) {
        return 0;
      }
    }
    var_7493f254 = 100 / self.maxhealth;
    return int(idamage * var_7493f254);
  }
  return idamage;
}

function moon_jump_pad_progression_end(ent_player) {
  if(isDefined(self.start.script_string)) {
    ent_player.script_string = self.start.script_string;
  }
  if(isDefined(ent_player.script_string)) {
    end_spot_array = self.destination;
    end_spot_array = array::randomize(end_spot_array);
    for(i = 0; i < end_spot_array.size; i++) {
      if(isDefined(end_spot_array[i].script_string) && end_spot_array[i].script_string == ent_player.script_string) {
        end_point = end_spot_array[i];
        if(randomint(100) < 5 && !level._pad_powerup && isDefined(end_point.script_parameters)) {
          temptation_array = level._biodome_tempt_arrays[end_point.script_parameters];
        }
        return end_point;
      }
    }
  }
}

function moon_low_gravity_velocity(ent_start_point, struct_end_point) {
  end_point = struct_end_point;
  start_point = ent_start_point;
  z_velocity = undefined;
  z_dist = undefined;
  fling_this_way = undefined;
  world_gravity = getdvarint("bg_gravity");
  gravity_pulls = -13.3;
  top_velocity_sq = 810000;
  forward_scaling = 1;
  end_spot = struct_end_point.origin;
  if(!(isDefined(self.script_airspeed) && self.script_airspeed)) {
    rand_end = (randomfloatrange(0.1, 1.2), randomfloatrange(0.1, 1.2), 0);
    rand_scale = randomint(100);
    rand_spot = vectorscale(rand_end, rand_scale);
    end_spot = struct_end_point.origin + rand_spot;
  }
  pad_dist = distance(start_point.origin, end_spot);
  z_dist = end_spot[2] - start_point.origin[2];
  jump_velocity = end_spot - start_point.origin;
  if(z_dist > 40 && z_dist < 135) {
    z_dist = z_dist * 0.2;
    forward_scaling = 0.8;
    if(getdvarint("")) {
      z_dist = z_dist * getdvarfloat("");
      forward_scaling = getdvarfloat("");
    }
  } else {
    if(z_dist >= 135) {
      z_dist = z_dist * 0.2;
      forward_scaling = 0.7;
      if(getdvarint("")) {
        z_dist = z_dist * getdvarfloat("");
        forward_scaling = getdvarfloat("");
      }
    } else if(z_dist < 0) {
      z_dist = z_dist * 0.1;
      forward_scaling = 0.95;
      if(getdvarint("")) {
        z_dist = z_dist * getdvarfloat("");
        forward_scaling = getdvarfloat("");
      }
    }
  }
  n_reduction = 0.035;
  if(getdvarfloat("") > 0) {
    n_reduction = getdvarfloat("");
  }
  z_velocity = ((n_reduction * 0.75) * z_dist) * world_gravity;
  if(z_velocity < 0) {
    z_velocity = z_velocity * -1;
  }
  if(z_dist < 0) {
    z_dist = z_dist * -1;
  }
  jump_time = sqrt((2 * pad_dist) / world_gravity);
  jump_time_2 = sqrt(z_dist / world_gravity);
  jump_time = jump_time + jump_time_2;
  if(jump_time < 0) {
    jump_time = jump_time * -1;
  }
  x = (jump_velocity[0] * forward_scaling) / jump_time;
  y = (jump_velocity[1] * forward_scaling) / jump_time;
  z = z_velocity / jump_time;
  fling_this_way = (x, y, z);
  jump_info = [];
  jump_info[0] = fling_this_way;
  jump_info[1] = jump_time;
  return jump_info;
}

function moon_vertical_jump(ent_start_point, struct_end_point) {
  end_point = struct_end_point;
  start_point = ent_start_point;
  z_velocity = undefined;
  z_dist = undefined;
  fling_this_way = undefined;
  world_gravity = getdvarint("bg_gravity");
  gravity_pulls = -13.3;
  top_velocity_sq = 810000;
  forward_scaling = 0.9;
  end_random_scale = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
  vel_random = (randomintrange(2, 6), randomintrange(2, 6), 0);
  pad_dist = distance(start_point.origin, end_point.origin);
  jump_velocity = end_point.origin - start_point.origin;
  z_dist = end_point.origin[2] - start_point.origin[2];
  z_dist = z_dist * 1.5;
  z_velocity = ((0.0012 * 2) * z_dist) * world_gravity;
  if(z_velocity < 0) {
    z_velocity = z_velocity * -1;
  }
  if(z_dist < 0) {
    z_dist = z_dist * -1;
  }
  jump_time = sqrt((2 * pad_dist) / world_gravity);
  jump_time_2 = sqrt((2 * z_dist) / world_gravity);
  jump_time = jump_time + jump_time_2;
  if(jump_time < 0) {
    jump_time = jump_time * -1;
  }
  x = (jump_velocity[0] * forward_scaling) / jump_time;
  y = (jump_velocity[1] * forward_scaling) / jump_time;
  z = z_velocity / jump_time;
  fling_vel = (x, y, z) + vel_random;
  fling_this_way = (x, y, z);
  jump_info = [];
  jump_info[0] = fling_this_way;
  jump_info[1] = jump_time;
  return jump_info;
}

function moon_biodome_temptation_init() {
  level._biodome_tempt_arrays = [];
  level._biodome_tempt_arrays["struct_tempt_left_medium_start"] = struct::get_array("struct_tempt_left_medium_start", "targetname");
  level._biodome_tempt_arrays["struct_tempt_right_medium_start"] = struct::get_array("struct_tempt_right_medium_start", "targetname");
  level._biodome_tempt_arrays["struct_tempt_left_tall"] = struct::get_array("struct_tempt_left_tall", "targetname");
  level._biodome_tempt_arrays["struct_tempt_middle_tall"] = struct::get_array("struct_tempt_middle_tall", "targetname");
  level._biodome_tempt_arrays["struct_tempt_right_tall"] = struct::get_array("struct_tempt_right_tall", "targetname");
  level._biodome_tempt_arrays["struct_tempt_left_medium_end"] = struct::get_array("struct_tempt_left_medium_end", "targetname");
  level._biodome_tempt_arrays["struct_tempt_right_medium_end"] = struct::get_array("struct_tempt_right_medium_end", "targetname");
  level._pad_powerup = 0;
  level flag::wait_till("start_zombie_round_logic");
  level thread moon_biodome_random_pad_temptation();
}

function moon_biodome_random_pad_temptation() {
  level endon("end_game");
  structs = struct::get_array("struct_biodome_temptation", "script_noteworthy");
  while(true) {
    rand = randomint(structs.size);
    if(isDefined(level._biodome_tempt_arrays[structs[rand].targetname])) {
      tempt_array = level._biodome_tempt_arrays[structs[rand].targetname];
      tempt_array = array::randomize(tempt_array);
      if(isDefined(level.zones["forest_zone"]) && (isDefined(level.zones["forest_zone"].is_enabled) && level.zones["forest_zone"].is_enabled) && !level._pad_powerup) {
        level thread moon_biodome_powerup_temptation(tempt_array);
      }
    }
    wait(randomintrange(60, 180));
  }
}

function moon_biodome_powerup_temptation(struct_array) {
  powerup = spawn("script_model", struct_array[0].origin);
  level thread moon_biodome_temptation_active(powerup);
  powerup endon("powerup_grabbed");
  powerup endon("powerup_timedout");
  temptation_array = array("fire_sale", "insta_kill", "nuke", "double_points", "carpenter");
  temptation_index = 0;
  spot_index = 0;
  first_time = 1;
  struct = undefined;
  rotation = 0;
  temptation_array = array::randomize(temptation_array);
  while(isDefined(powerup)) {
    if(temptation_array[temptation_index] == "fire_sale" && (level.zombie_vars["zombie_powerup_fire_sale_on"] == 1 || level.chest_moves == 0)) {
      temptation_index++;
      if(temptation_index >= temptation_array.size) {
        temptation_index = 0;
      }
      powerup zm_powerups::powerup_setup(temptation_array[temptation_index]);
    } else {
      powerup zm_powerups::powerup_setup(temptation_array[temptation_index]);
    }
    if(first_time) {
      powerup thread zm_powerups::powerup_timeout();
      powerup thread zm_powerups::powerup_wobble();
      powerup thread zm_powerups::powerup_grab();
      first_time = 0;
    }
    powerup.origin = struct_array[spot_index].origin;
    if(rotation == 0) {
      wait(15);
      rotation++;
    } else {
      if(rotation == 1) {
        wait(7.5);
        rotation++;
      } else {
        if(rotation == 2) {
          wait(2.5);
          rotation++;
        } else {
          wait(1.5);
          rotation++;
        }
      }
    }
    temptation_index++;
    if(temptation_index >= temptation_array.size) {
      temptation_index = 0;
    }
    spot_index++;
    if(spot_index >= struct_array.size) {
      spot_index = 0;
    }
  }
}

function moon_biodome_temptation_active(ent_powerup) {
  level._pad_powerup = 1;
  while(isDefined(ent_powerup)) {
    wait(0.1);
  }
  level._pad_powerup = 0;
}

function moon_jump_pads_low_gravity() {
  level endon("end_game");
  biodome_pads = getEntArray("biodome_pads", "script_noteworthy");
  biodome_compromised = 0;
  while(!biodome_compromised) {
    level waittill("digger_arm_smash", digger, zone);
    if(digger == "biodome" && isarray(zone) && zone[0] == "forest_zone") {
      biodome_compromised = 1;
    }
  }
  for(i = 0; i < biodome_pads.size; i++) {
    biodome_pads[i].script_string = "low_grav";
  }
}

function moon_jump_pads_malfunctions() {
  level endon("end_game");
  jump_pad_triggers = getEntArray("trig_jump_pad", "targetname");
  level flag::wait_till("start_zombie_round_logic");
  wait(2);
  level._dome_malfunction_pads = [];
  for(i = 0; i < jump_pad_triggers.size; i++) {
    pad = jump_pad_triggers[i];
    if(isDefined(pad.script_label)) {
      if(pad.script_label == "pad_labs_low") {
        array::add(level._dome_malfunction_pads, pad, 0);
        continue;
      }
      if(pad.script_label == "pad_magic_box_low") {
        array::add(level._dome_malfunction_pads, pad, 0);
        continue;
      }
      if(pad.script_label == "pad_teleporter_low") {
        array::add(level._dome_malfunction_pads, pad, 0);
      }
    }
  }
  if(level._dome_malfunction_pads.size == 0) {
    println("");
    return;
  }
  level flag::wait_till("power_on");
  for(i = 0; i < level._dome_malfunction_pads.size; i++) {
    level._dome_malfunction_pads[i] thread moon_pad_malfunction_think();
  }
}

function moon_pad_malfunction_think() {
  level endon("end_game");
  pad_hook = spawn("script_model", self.origin);
  pad_hook setModel("tag_origin");
  while(isDefined(self)) {
    wait(randomintrange(30, 60));
    println("");
    pad_hook playSound("zmb_turret_down");
    pad_hook clientfield::set("dome_malfunction_pad", 1);
    util::wait_network_frame();
    self triggerenable(0);
    wait(randomintrange(10, 30));
    pad_hook playSound("zmb_turret_startup");
    pad_hook clientfield::set("dome_malfunction_pad", 0);
    util::wait_network_frame();
    self triggerenable(1);
    println("");
  }
}

function moon_zombie_run_change(ent_poi) {
  self endon("death");
  if(isDefined(self._pad_chase) && self._pad_chase) {
    return;
  }
  if(isDefined(self.animname) && self.animname == "astro_zombie") {
    return;
  }
  if(isDefined(self.script_string) && self.script_string == "riser") {
    while(isDefined(self.in_the_ground) && self.in_the_ground) {
      wait(0.05);
    }
  }
  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return;
  }
  self._pad_chase = 1;
  low_grav = 0;
  chase_anim = undefined;
  curr_zone = self zm_utility::get_current_zone();
  if(!isDefined(curr_zone) && isDefined(self.zone_name)) {
    curr_zone = self.zone_name;
  }
  if(isDefined(curr_zone) && isDefined(level.zones[curr_zone].volumes[0].script_string) && level.zones[curr_zone].volumes[0].script_string == "lowgravity") {
    low_grav = 1;
  }
  self thread zm_moon_gravity::gravity_zombie_update(low_grav);
  if(self.animname == "zombie" || self.animname == "quad_zombie") {
    self.var_41a233b3 = self.zombie_move_speed;
    if(low_grav && self.zombie_move_speed != "jump_pad_super_sprint") {
      self zombie_utility::set_zombie_run_cycle("jump_pad_super_sprint");
    } else {
      self zombie_utility::set_zombie_run_cycle("super_sprint");
    }
  }
  self thread moon_stop_running_to_catch();
}

function jump_pad_store_movement_anim() {
  self endon("death");
  current_anim = self.run_combatanim;
  anim_keys = getarraykeys(level.scr_anim[self.animname]);
  for(j = 0; j < anim_keys.size; j++) {
    if(level.scr_anim[self.animname][anim_keys[j]] == current_anim) {
      return anim_keys[j];
    }
  }
  /
  #
  assertmsg("");
}

function moon_stop_running_to_catch() {
  self endon("death");
  if(!(isDefined(self._pad_chase) && self._pad_chase)) {
    return;
  }
  if(isDefined(self.animname) && self.animname == "astro_zombie") {
    return;
  }
  while(isDefined(self._pad_follow) && self._pad_follow) {
    wait(0.05);
  }
  low_grav = 0;
  curr_zone = self zm_utility::get_current_zone();
  if(isDefined(curr_zone) && isDefined(level.zones[curr_zone].volumes[0].script_string) && level.zones[curr_zone].volumes[0].script_string == "lowgravity") {
    low_grav = 1;
  }
  anim_set = undefined;
  self zombie_utility::set_zombie_run_cycle(self.var_41a233b3);
  self.var_41a233b3 = undefined;
  self._pad_chase = 0;
}

function moon_jump_pad_cushion_sound_init() {
  level flag::wait_till("start_zombie_round_logic");
  level.cushion_sound_triggers = getEntArray("trig_cushion_sound", "targetname");
  if(level.cushion_sound_triggers.size) {
    array::thread_all(level.cushion_sound_triggers, &moon_jump_pad_cushion_play_sound);
  }
}

function moon_jump_pad_cushion_play_sound() {
  while(isDefined(self)) {
    self waittill("trigger", who);
    if(isPlayer(who) && (isDefined(who._padded) && who._padded)) {
      self playSound("evt_jump_pad_land");
    }
  }
}

function function_d4f0f4fe() {
  if(isDefined(self.script_int)) {
    level clientfield::increment("jump_pad_pulse", self.script_int);
  } else {
    playFX(level._effect["jump_pad_jump"], self.origin);
  }
}