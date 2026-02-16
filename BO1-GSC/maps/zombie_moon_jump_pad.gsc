/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_moon_jump_pad.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#using_animtree("generic_human");

init() {
  level._uses_jump_pads = true;
  level.scr_anim["zombie"]["low_g_super_sprint"] = % ai_zombie_supersprint_lowg;
  level.scr_anim["zombie"]["crawl_super_sprint"] = % ai_zombie_crawl_supersprint;
  level.scr_anim["zombie"]["crawl_low_g_super_sprint"] = % ai_zombie_crawl_supersprint_lowg;
  level.scr_anim["quad_zombie"]["super_sprint"] = % ai_zombie_quad_supersprint;
  level.scr_anim["quad_zombie"]["low_g_super_sprint"] = % ai_zombie_quad_supersprint_lowg;
  level maps\_zombiemode_jump_pad::init();
  level moon_jump_pad_overrides();
  level thread moon_biodome_temptation_init();
  level thread moon_jump_pads_low_gravity();
  level thread moon_jump_pads_malfunctions();
  level thread moon_jump_pad_cushion_sound_init();
}
moon_jump_pad_overrides() {
  level._jump_pad_override["biodome_logic"] = ::moon_jump_pad_progression_end;
  level._jump_pad_override["low_grav"] = ::moon_low_gravity_velocity;
  level._jump_pad_override["moon_vertical_jump"] = ::moon_vertical_jump;
  level._jump_pad_poi_start_override = ::moon_zombie_run_change;
  flag_init("pad_allow_anim_change");
  level._jump_pad_anim_change = [];
  flag_set("pad_allow_anim_change");
  level thread jump_pad_throttle_anim_changes();
}
moon_jump_pad_progression_end(ent_player) {
  if(isDefined(self.start.script_string)) {
    ent_player.script_string = self.start.script_string;
  }
  if(isDefined(ent_player.script_string)) {
    end_spot_array = self.destination;
    end_spot_array = array_randomize(end_spot_array);
    for(i = 0; i < end_spot_array.size; i++) {
      if(isDefined(end_spot_array[i].script_string) && end_spot_array[i].script_string == ent_player.script_string) {
        end_point = end_spot_array[i];
        if(RandomInt(100) < 5 && !level._pad_powerup && isDefined(end_point.script_parameters)) {
          temptation_array = level._biodome_tempt_arrays[end_point.script_parameters];
          if(isDefined(temptation_array)) {}
        }
        return end_point;
      }
    }
  }
}
moon_low_gravity_velocity(ent_start_point, struct_end_point) {
  end_point = struct_end_point;
  start_point = ent_start_point;
  z_velocity = undefined;
  z_dist = undefined;
  fling_this_way = undefined;
  world_gravity = GetDvarInt("bg_gravity");
  gravity_pulls = 13.3 * -1;
  top_velocity_sq = 900 * 900;
  forward_scaling = 1.0;
  end_spot = struct_end_point.origin;
  if(!is_true(self.script_airspeed)) {
    rand_end = (RandomFloat(0.1, 1.2), RandomFloat(0.1, 1.2), 0);
    rand_scale = RandomInt(100);
    rand_spot = vector_scale(rand_end, rand_scale);
    end_spot = struct_end_point.origin + rand_spot;
  }
  pad_dist = Distance(start_point.origin, end_spot);
  z_dist = end_spot[2] - start_point.origin[2];
  jump_velocity = end_spot - start_point.origin;
  if(z_dist > 40 && z_dist < 135) {
    z_dist *= 0.05;
    forward_scaling = 0.8;
  } else if(z_dist >= 135) {
    z_dist *= 0.2;
    forward_scaling = 0.7;
  } else if(z_dist < 0) {
    z_dist *= 0.1;
    forward_scaling = 0.95;
  }
  z_velocity = 0.75 * z_dist * world_gravity;
  if(z_velocity < 0) {
    z_velocity *= -1;
  }
  if(z_dist < 0) {
    z_dist *= -1;
  }
  jump_time = Sqrt(2 * pad_dist / world_gravity);
  jump_time_2 = Sqrt(z_dist / world_gravity);
  jump_time = jump_time + jump_time_2;
  if(jump_time < 0) {
    jump_time *= -1;
  }
  x = jump_velocity[0] * forward_scaling / jump_time;
  y = jump_velocity[1] * forward_scaling / jump_time;
  z = z_velocity / jump_time;
  fling_this_way = (x, y, z);
  jump_info = [];
  jump_info[0] = fling_this_way;
  jump_info[1] = jump_time;
  return jump_info;
}
moon_vertical_jump(ent_start_point, struct_end_point) {
  end_point = struct_end_point;
  start_point = ent_start_point;
  z_velocity = undefined;
  z_dist = undefined;
  fling_this_way = undefined;
  world_gravity = GetDvarInt("bg_gravity");
  gravity_pulls = 13.3 * -1;
  top_velocity_sq = 900 * 900;
  forward_scaling = 0.9;
  end_random_scale = (RandomFloatRange(-1, 1), RandomFloatRange(-1, 1), 0);
  vel_random = (RandomIntRange(2, 6), RandomIntRange(2, 6), 0);
  pad_dist = Distance(start_point.origin, end_point.origin);
  jump_velocity = end_point.origin - start_point.origin;
  z_dist = end_point.origin[2] - start_point.origin[2];
  z_dist *= 1.5;
  z_velocity = 2 * z_dist * world_gravity;
  if(z_velocity < 0) {
    z_velocity *= -1;
  }
  if(z_dist < 0) {
    z_dist *= -1;
  }
  jump_time = Sqrt(2 * pad_dist / world_gravity);
  jump_time_2 = Sqrt(2 * z_dist / world_gravity);
  jump_time = jump_time + jump_time_2;
  if(jump_time < 0) {
    jump_time *= -1;
  }
  x = jump_velocity[0] * forward_scaling / jump_time;
  y = jump_velocity[1] * forward_scaling / jump_time;
  z = z_velocity / jump_time;
  fling_vel = (x, y, z) + vel_random;
  fling_this_way = (x, y, z);
  jump_info = [];
  jump_info[0] = fling_this_way;
  jump_info[1] = jump_time;
  return jump_info;
}
moon_biodome_temptation_init() {
  level._biodome_tempt_arrays = [];
  level._biodome_tempt_arrays["struct_tempt_left_medium_start"] = getStructArray("struct_tempt_left_medium_start", "targetname");
  level._biodome_tempt_arrays["struct_tempt_right_medium_start"] = getStructArray("struct_tempt_right_medium_start", "targetname");
  level._biodome_tempt_arrays["struct_tempt_left_tall"] = getStructArray("struct_tempt_left_tall", "targetname");
  level._biodome_tempt_arrays["struct_tempt_middle_tall"] = getStructArray("struct_tempt_middle_tall", "targetname");
  level._biodome_tempt_arrays["struct_tempt_right_tall"] = getStructArray("struct_tempt_right_tall", "targetname");
  level._biodome_tempt_arrays["struct_tempt_left_medium_end"] = getStructArray("struct_tempt_left_medium_end", "targetname");
  level._biodome_tempt_arrays["struct_tempt_right_medium_end"] = getStructArray("struct_tempt_right_medium_end", "targetname");
  level._pad_powerup = false;
  flag_wait("all_players_connected");
  level thread moon_biodome_random_pad_temptation();
}
moon_biodome_random_pad_temptation() {
  level endon("end_game");
  structs = getStructArray("struct_biodome_temptation", "script_noteworthy");
  while(true) {
    rand = RandomInt(structs.size);
    if(isDefined(level._biodome_tempt_arrays[structs[rand].targetname])) {
      tempt_array = level._biodome_tempt_arrays[structs[rand].targetname];
      tempt_array = array_randomize(tempt_array);
      if(isDefined(level.zones["forest_zone"]) && is_true(level.zones["forest_zone"].is_enabled) && !level._pad_powerup) {
        level thread moon_biodome_powerup_temptation(tempt_array);
      }
    }
    wait(RandomIntRange(60, 180));
  }
}
moon_biodome_powerup_temptation(struct_array) {
  powerup = spawn("script_model", struct_array[0].origin);
  level thread moon_biodome_temptation_active(powerup);
  powerup endon("powerup_grabbed");
  powerup endon("powerup_timedout");
  temptation_array = array("fire_sale", "insta_kill", "nuke", "double_points", "carpenter");
  temptation_index = 0;
  spot_index = 0;
  first_time = true;
  struct = undefined;
  rotation = 0;
  temptation_array = array_randomize(temptation_array);
  while(isDefined(powerup)) {
    if(temptation_array[temptation_index] == "fire_sale" &&
      (level.zombie_vars["zombie_powerup_fire_sale_on"] == true || level.chest_moves == 0)) {
      temptation_index++;
      if(temptation_index >= temptation_array.size) {
        temptation_index = 0;
      }
      powerup maps\_zombiemode_powerups::powerup_setup(temptation_array[temptation_index]);
    } else {
      powerup maps\_zombiemode_powerups::powerup_setup(temptation_array[temptation_index]);
    }
    if(first_time) {
      powerup thread maps\_zombiemode_powerups::powerup_timeout();
      powerup thread maps\_zombiemode_powerups::powerup_wobble();
      powerup thread maps\_zombiemode_powerups::powerup_grab();
      first_time = false;
    }
    powerup.origin = struct_array[spot_index].origin;
    if(rotation == 0) {
      wait(15.0);
      rotation++;
    } else if(rotation == 1) {
      wait(7.5);
      rotation++;
    } else if(rotation == 2) {
      wait(2.5);
      rotation++;
    } else {
      wait(1.5);
      rotation++;
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
moon_biodome_temptation_active(ent_powerup) {
  level._pad_powerup = true;
  while(isDefined(ent_powerup)) {
    wait(0.1);
  }
  level._pad_powerup = false;
}
moon_jump_pads_low_gravity() {
  level endon("end_game");
  biodome_pads = getEntArray("biodome_pads", "script_noteworthy");
  biodome_compromised = false;
  while(!biodome_compromised) {
    level waittill("digger_arm_smash", digger, zone);
    if(digger == "biodome" && IsArray(zone) && zone[0] == "forest_zone") {
      biodome_compromised = true;
    }
  }
  for(i = 0; i < biodome_pads.size; i++) {
    biodome_pads[i].script_string = "low_grav";
  }
}
moon_jump_pads_malfunctions() {
  level endon("end_game");
  jump_pad_triggers = getEntArray("trig_jump_pad", "targetname");
  flag_wait("all_players_connected");
  wait(2.0);
  level._dome_malfunction_pads = [];
  for(i = 0; i < jump_pad_triggers.size; i++) {
    pad = jump_pad_triggers[i];
    if(isDefined(pad.script_label)) {
      if(pad.script_label == "pad_labs_low") {
        level._dome_malfunction_pads = add_to_array(level._dome_malfunction_pads, pad, false);
      } else if(pad.script_label == "pad_magic_box_low") {
        level._dome_malfunction_pads = add_to_array(level._dome_malfunction_pads, pad, false);
      } else if(pad.script_label == "pad_teleporter_low") {
        level._dome_malfunction_pads = add_to_array(level._dome_malfunction_pads, pad, false);
      }
    }
  }
  flag_wait("power_on");
  for(i = 0; i < level._dome_malfunction_pads.size; i++) {
    level._dome_malfunction_pads[i] thread moon_pad_malfunction_think();
  }
}
moon_pad_malfunction_think() {
  level endon("end_game");
  pad_hook = spawn("script_model", self.origin);
  pad_hook setModel("tag_origin");
  while(isDefined(self)) {
    wait(RandomIntRange(30, 60));
    pad_hook playSound("zmb_turret_down");
    pad_hook SetClientFlag(level._CLIENTFLAG_SCRIPTMOVER_DOME_MALFUNCTION_PAD);
    wait_network_frame();
    self trigger_off();
    wait(RandomIntRange(10, 30));
    pad_hook playSound("zmb_turret_startup");
    pad_hook ClearClientFlag(level._CLIENTFLAG_SCRIPTMOVER_DOME_MALFUNCTION_PAD);
    wait_network_frame();
    self trigger_on();
  }
}
moon_zombie_run_change(ent_poi) {
  self endon("death");
  if(is_true(self._pad_chase)) {
    return;
  }
  if(isDefined(self.animname) && self.animname == "astro_zombie") {
    return;
  }
  if(isDefined(self.script_string) && self.script_string == "riser") {
    while(is_true(self.in_the_ground)) {
      wait(0.05);
    }
  }
  if(!isDefined(self.ent_flag) || !isDefined(self.ent_flag["pad_anim_change"])) {
    self ent_flag_init("pad_anim_change");
  }
  self._pre_pad_run = self jump_pad_store_movement_anim();
  self._pad_chase = 1;
  low_grav = 0;
  chase_anim = undefined;
  flag_wait("pad_allow_anim_change");
  level._jump_pad_anim_change = add_to_array(level._jump_pad_anim_change, self, false);
  self ent_flag_wait("pad_anim_change");
  curr_zone = self get_current_zone();
  if(!isDefined(curr_zone) && isDefined(self.zone_name)) {
    curr_zone = self.zone_name;
  }
  if(isDefined(curr_zone) && isDefined(level.zones[curr_zone].volumes[0].script_string) &&
    level.zones[curr_zone].volumes[0].script_string == "lowgravity") {
    low_grav = 1;
  }
  if(self.animname == "zombie") {
    if(self.has_legs) {
      if(low_grav) {
        chase_anim = "low_g_super_sprint";
      } else {
        chase_anim = "sprint6";
      }
    } else {
      if(low_grav) {
        chase_anim = "crawl_low_g_super_sprint";
      } else {
        chase_anim = "crawl_super_sprint";
      }
    }
  } else if(self.animname == "quad_zombie") {
    if(low_grav) {
      chase_anim = "low_g_super_sprint";
    } else {
      chase_anim = "super_sprint";
    }
  } else if(self.animname == "astro_zombie") {}
  self moon_jump_pad_run_switch(chase_anim);
  self thread moon_stop_running_to_catch();
}
jump_pad_store_movement_anim() {
  self endon("death");
  current_anim = self.run_combatanim;
  anim_keys = GetArrayKeys(level.scr_anim[self.animname]);
  for(j = 0; j < anim_keys.size; j++) {
    if(level.scr_anim[self.animname][anim_keys[j]] == current_anim) {
      return anim_keys[j];
    }
  }
}
moon_stop_running_to_catch() {
  self endon("death");
  if(!is_true(self._pad_chase)) {
    return;
  }
  if(isDefined(self.animname) && self.animname == "astro_zombie") {
    return;
  }
  while(is_true(self._pad_follow)) {
    wait(0.05);
  }
  flag_wait("pad_allow_anim_change");
  level._jump_pad_anim_change = add_to_array(level._jump_pad_anim_change, self, false);
  self ent_flag_wait("pad_anim_change");
  low_grav = 0;
  curr_zone = self get_current_zone();
  if(isDefined(curr_zone) && isDefined(level.zones[curr_zone].volumes[0].script_string) &&
    level.zones[curr_zone].volumes[0].script_string == "lowgravity") {
    low_grav = 1;
  }
  anim_set = undefined;
  switch (self.zombie_move_speed) {
    case "walk":
      if(low_grav) {
        if(self.has_legs) {
          var = RandomIntRange(1, level.num_anim[self.animname]["walk"] + 1);
          anim_set = "walk_moon" + var;
          break;
        } else {
          var = RandomIntRange(1, level.num_anim[self.animname]["crawl"] + 1);
          anim_set = "crawl_moon" + var;
          break;
        }
      } else {
        if(self.has_legs) {
          var = RandomIntRange(1, 9);
          anim_set = "walk" + var;
          break;
        } else {
          var = RandomIntRange(1, 7);
          anim_set = "crawl" + var;
          break;
        }
      }
    case "run":
      if(low_grav) {
        if(self.has_legs) {
          var = RandomIntRange(1, level.num_anim[self.animname]["run"] + 1);
          anim_set = "run_moon" + var;
          break;
        } else {
          var = RandomIntRange(1, level.num_anim[self.animname]["crawl"] + 1);
          anim_set = "crawl_moon" + var;
          break;
        }
      } else {
        if(self.has_legs) {
          var = RandomIntRange(1, 7);
          anim_set = "run" + var;
          break;
        } else {
          var = RandomIntRange(1, 3);
          anim_set = "crawl_hand_" + var;
          break;
        }
      }
    case "sprint":
      if(low_grav) {
        if(self.has_legs) {
          var = RandomIntRange(1, level.num_anim[self.animname]["sprint"] + 1);
          anim_set = "sprint_moon" + var;
          break;
        } else {
          var = RandomIntRange(1, level.num_anim[self.animname]["crawl"] + 1);
          anim_set = "crawl_moon" + var;
          break;
        }
      } else {
        if(self.has_legs) {
          var = RandomIntRange(1, 5);
          anim_set = "sprint" + var;
          break;
        } else {
          var = RandomIntRange(1, 4);
          anim_set = "crawl_sprint" + var;
          break;
        }
      }
  }
  self moon_jump_pad_run_switch(anim_set);
  self._pad_chase = 0;
}
jump_pad_throttle_anim_changes() {
  if(!isDefined(level._jump_pad_anim_change)) {
    level._jump_pad_anim_change = [];
  }
  int_max_num_zombies_per_frame = 7;
  array_zombies_allowed_to_switch = [];
  while(isDefined(level._jump_pad_anim_change)) {
    if(level._jump_pad_anim_change.size == 0) {
      wait(0.1);
      continue;
    }
    array_zombies_allowed_to_switch = level._jump_pad_anim_change;
    for(i = 0; i < array_zombies_allowed_to_switch.size; i++) {
      if(!IsAlive(array_zombies_allowed_to_switch[i])) {
        continue;
      }
      array_zombies_allowed_to_switch[i] ent_flag_set("pad_anim_change");
      if(i >= int_max_num_zombies_per_frame) {
        break;
      }
    }
    flag_clear("pad_allow_anim_change");
    wait(0.05);
    for(i = 0; i < array_zombies_allowed_to_switch.size; i++) {
      zmb = array_zombies_allowed_to_switch[i];
      if(!IsAlive(zmb) || !isDefined(zmb)) {
        continue;
      }
      if(zmb ent_flag("pad_anim_change")) {
        level._jump_pad_anim_change = array_remove(level._jump_pad_anim_change, zmb);
        zmb ent_flag_clear("pad_anim_change");
      }
    }
    level._jump_pad_anim_change = array_removedead(level._jump_pad_anim_change);
    level._jump_pad_anim_change = array_removeundefined(level._jump_pad_anim_change);
    flag_set("pad_allow_anim_change");
    wait(0.1);
  }
}
moon_jump_pad_run_switch(str_anim_key) {
  self endon("death");
  self.a.runBlendTime = 0.9;
  self clear_run_anim();
  self.needs_run_update = true;
  self set_run_anim(str_anim_key);
  self.run_combatanim = level.scr_anim[self.animname][str_anim_key];
  self.crouchRunAnim = level.scr_anim[self.animname][str_anim_key];
  self.crouchrun_combatanim = level.scr_anim[self.animname][str_anim_key];
}
moon_jump_pad_cushion_sound_init() {
  flag_wait("all_players_connected");
  cushion_sound_triggers = getEntArray("trig_cushion_sound", "targetname");
  if(!isDefined(cushion_sound_triggers) || cushion_sound_triggers.size == 0) {
    return;
  }
  for(i = 0; i < cushion_sound_triggers.size; i++) {
    cushion_sound_triggers[i] thread moon_jump_pad_cushion_play_sound();
  }
}
moon_jump_pad_cushion_play_sound() {
  while(isDefined(self)) {
    self waittill("trigger", who);
    if(isPlayer(who) && is_true(who._padded)) {
      self playSound("evt_jump_pad_land");
    }
  }
}