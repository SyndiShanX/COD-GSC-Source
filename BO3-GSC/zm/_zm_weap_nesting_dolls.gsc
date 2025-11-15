/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_nesting_dolls.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_utility;
#using_animtree("zombie_cymbal_monkey");
#namespace _zm_weap_nesting_dolls;

function autoexec __init__sytem__() {
  system::register("zm_weap_nesting_dolls", & __init__, undefined, undefined);
}

function __init__() {
  level.w_nesting_dolls = getweapon("nesting_dolls");
  level.var_3a1d655b = getweapon("nesting_dolls_single");
  level.nesting_dolls_launch_speed = 500;
  level.nesting_dolls_launch_angle = 45;
  level.nesting_dolls_too_close_dist = 10000;
  level.nesting_dolls_det_time = 0.25;
  level.nesting_dolls_player_aim_dot = cos(22.5);
  level.nesting_dolls_damage_radius = 180;
  gravity = getdvarfloat("bg_gravity");
  level.nesting_dolls_launch_peak_time = (level.nesting_dolls_launch_speed * sin(level.nesting_dolls_launch_angle)) / abs(gravity) * 0.5;
  level.nesting_dolls_max_ids = 10;
  level.zombiemode_devgui_nesting_dolls_give = & player_give_nesting_dolls;
  setup_nesting_dolls_data();
}

function setup_nesting_dolls_data() {
  if(isDefined(level.nesting_dolls_override_setup)) {
    [[level.nesting_dolls_override_setup]]();
    return;
  }
  level._effect["nesting_doll_trail_blue"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_blue";
  level._effect["nesting_doll_trail_green"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_green";
  level._effect["nesting_doll_trail_red"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_red";
  level._effect["nesting_doll_trail_yellow"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_yellow";
  level.nesting_dolls_data = [];
  level.nesting_dolls_data[0] = spawnStruct();
  level.nesting_dolls_data[0].name = "dempsey";
  level.nesting_dolls_data[0].id = 127;
  level.nesting_dolls_data[0].trailfx = level._effect["nesting_doll_trail_blue"];
  level.nesting_dolls_data[1] = spawnStruct();
  level.nesting_dolls_data[1].name = "nikolai";
  level.nesting_dolls_data[1].id = 128;
  level.nesting_dolls_data[1].trailfx = level._effect["nesting_doll_trail_red"];
  level.nesting_dolls_data[2] = spawnStruct();
  level.nesting_dolls_data[2].name = "takeo";
  level.nesting_dolls_data[2].id = 130;
  level.nesting_dolls_data[2].trailfx = level._effect["nesting_doll_trail_green"];
  level.nesting_dolls_data[3] = spawnStruct();
  level.nesting_dolls_data[3].name = "richtofen";
  level.nesting_dolls_data[3].id = 129;
  level.nesting_dolls_data[3].trailfx = level._effect["nesting_doll_trail_yellow"];
}

function nesting_dolls_exists() {
  return isDefined(level.zombie_weapons["nesting_dolls"]);
}

function player_give_nesting_dolls() {
  self nesting_dolls_create_randomized_indices(0);
  var_1c3c9c82 = level.nesting_dolls_data[self.nesting_dolls_randomized_indices[0][0]].id;
  weapon_options = self calcweaponoptions(var_1c3c9c82, 0, 0);
  if(self hasweapon(level.w_nesting_dolls)) {
    self updateweaponoptions(level.w_nesting_dolls, weapon_options);
  } else {
    self giveweapon(level.w_nesting_dolls, weapon_options);
  }
  self zm_utility::set_player_tactical_grenade(level.w_nesting_dolls);
  self thread player_handle_nesting_dolls();
}

function player_handle_nesting_dolls() {
  self notify("starting_nesting_dolls");
  self endon("disconnect");
  self endon("starting_nesting_dolls");
  while(true) {
    grenade = get_thrown_nesting_dolls();
    if(isDefined(grenade)) {
      if(self laststand::player_is_in_laststand()) {
        grenade delete();
        continue;
      }
      self thread doll_spawner_cluster(grenade);
    }
    wait(0.05);
  }
}

function doll_spawner(start_grenade) {
  self endon("disconnect");
  self endon("death");
  num_dolls = 1;
  max_dolls = 4;
  self nesting_dolls_set_id();
  self thread nesting_dolls_setup_next_doll_throw();
  if(isDefined(start_grenade)) {
    start_grenade spawn_doll_model(self.doll_id, 0, self);
    start_grenade thread doll_behavior_explode_when_stopped(self, self.doll_id, 0);
  }
  while(num_dolls < max_dolls) {
    self waittill("spawn_doll", origin, angles);
    grenade_vel = self get_launch_velocity(origin, 2000);
    if(grenade_vel == (0, 0, 0)) {
      grenade_vel = self get_random_launch_velocity(origin, angles);
    }
    grenade = self magicgrenadetype(level.var_3a1d655b, origin, grenade_vel);
    grenade spawn_doll_model(self.doll_id, num_dolls, self);
    grenade thread doll_behavior_explode_when_stopped(self, self.doll_id, num_dolls);
    num_dolls++;
  }
}

function doll_spawner_cluster(start_grenade) {
  self endon("disconnect");
  self endon("death");
  num_dolls = 1;
  max_dolls = 4;
  self nesting_dolls_set_id();
  self thread nesting_dolls_setup_next_doll_throw();
  self thread nesting_dolls_track_achievement(self.doll_id);
  self thread nesting_dolls_check_achievement(self.doll_id);
  if(isDefined(start_grenade)) {
    start_grenade spawn_doll_model(self.doll_id, 0, self);
    start_grenade thread doll_behavior_explode_when_stopped(self, self.doll_id, 0);
  }
  self waittill("spawn_doll", origin, angles);
  while(num_dolls < max_dolls) {
    grenade_vel = self get_cluster_launch_velocity(angles, num_dolls);
    grenade = self magicgrenadetype(level.var_3a1d655b, origin, grenade_vel);
    grenade spawn_doll_model(self.doll_id, num_dolls, self);
    grenade playSound("wpn_nesting_pop_npc");
    grenade thread doll_behavior_explode_when_stopped(self, self.doll_id, num_dolls);
    num_dolls++;
    wait(0.25);
  }
}

function doll_do_damage(origin, owner, id, index) {
  self waittill("explode");
  zombies = zombie_utility::get_round_enemy_array();
  if(zombies.size == 0) {
    return;
  }
  zombie_sort = util::get_array_of_closest(origin, zombies, undefined, undefined, level.nesting_dolls_damage_radius);
  for(i = 0; i < zombie_sort.size; i++) {
    if(isalive(zombie_sort[i])) {
      if(zombie_sort[i] damageconetrace(origin, owner) == 1) {
        owner.nesting_dolls_tracker[id][index] = owner.nesting_dolls_tracker[id][index] + 1;
      }
    }
  }
  radiusdamage(origin, level.nesting_dolls_damage_radius, 95000, 95000, owner, "MOD_GRENADE_SPLASH", level.var_3a1d655b);
}

function randomize_angles(angles) {
  random_yaw = randomintrange(-45, 45);
  random_pitch = randomintrange(-45, -35);
  random = (random_pitch, random_yaw, 0);
  return_angles = angles + random;
  return return_angles;
}

function get_random_launch_velocity(doll_origin, angles) {
  angles = randomize_angles(angles);
  trace_dist = level.nesting_dolls_launch_speed * level.nesting_dolls_launch_peak_time;
  for(i = 0; i < 4; i++) {
    dir = anglesToForward(angles);
    if(bullettracepassed(doll_origin, doll_origin + (dir * trace_dist), 0, undefined)) {
      grenade_vel = dir * level.nesting_dolls_launch_speed;
      return grenade_vel;
    }
    angles = angles + vectorscale((0, 1, 0), 90);
  }
  return (0, 0, level.nesting_dolls_launch_speed);
}

function get_cluster_launch_velocity(angles, index) {
  random_pitch = randomintrange(-45, -35);
  offsets = array(45, 0, -45);
  angles = angles + (random_pitch, offsets[index - 1], 0);
  dir = anglesToForward(angles);
  grenade_vel = dir * level.nesting_dolls_launch_speed;
  return grenade_vel;
}

function get_launch_velocity(doll_origin, range) {
  velocity = (0, 0, 0);
  target = get_doll_best_doll_target(doll_origin, range);
  if(isDefined(target)) {
    target_origin = target get_target_leading_pos();
    dir = vectortoangles(target_origin - doll_origin);
    dir = (dir[0] - level.nesting_dolls_launch_angle, dir[1], dir[2]);
    dir = anglesToForward(dir);
    velocity = dir * level.nesting_dolls_launch_speed;
  }
  return velocity;
}

function get_target_leading_pos() {
  position = self.origin;
  return position;
}

function spawn_doll_model(id, index, parent) {
  self hide();
  self.doll_model = spawn("script_model", self.origin);
  data_index = parent.nesting_dolls_randomized_indices[id][index];
  name = level.nesting_dolls_data[data_index].name;
  model_index = index + 1;
  model_name = ((("wpn_t7_zmb_hd_nesting_dolls_" + name) + "_doll") + model_index) + "_world";
  self.doll_model setModel(model_name);
  self.doll_model useanimtree($zombie_cymbal_monkey);
  self.doll_model linkto(self);
  self.doll_model.angles = self.angles;
  self.doll_model thread nesting_dolls_cleanup(self);
  wait(0.1);
  playFXOnTag(level.nesting_dolls_data[data_index].trailfx, self.doll_model, "tag_origin");
}

function doll_behavior_explode_when_stopped(parent, doll_id, index) {
  velocitysq = 100000000;
  oldpos = self.origin;
  while(velocitysq != 0) {
    wait(0.1);
    if(!isDefined(self)) {
      break;
    }
    velocitysq = distancesquared(self.origin, oldpos);
    oldpos = self.origin;
  }
  if(isDefined(self)) {
    self.doll_model unlink();
    self.doll_model.origin = self.origin;
    self.doll_model.angles = self.angles;
    parent notify("spawn_doll", self.origin, self.angles);
    self thread doll_do_damage(self.origin, parent, doll_id, index);
    self resetmissiledetonationtime(level.nesting_dolls_det_time);
    if(isDefined(index) && index == 3) {
      parent thread nesting_dolls_end_achievement_tracking(doll_id);
    }
  }
}

function nesting_dolls_end_achievement_tracking(doll_id) {
  wait(level.nesting_dolls_det_time + 0.1);
  self notify("end_achievement_tracker" + doll_id);
}

function get_player_aim_best_doll_target(range) {
  view_pos = self getweaponmuzzlepoint();
  zombies = util::get_array_of_closest(view_pos, zombie_utility::get_round_enemy_array(), undefined, undefined, range * 1.1);
  if(!isDefined(zombies)) {
    return;
  }
  range_squared = range * range;
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + vectorscale(forward_view_angles, range);
  best_dot = -999;
  best_target = undefined;
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || !isalive(zombies[i])) {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distancesquared(view_pos, test_origin);
    if(test_range_squared > range_squared) {
      return;
    }
    normal = vectornormalize(test_origin - view_pos);
    dot = vectordot(forward_view_angles, normal);
    if(dot < 0) {
      continue;
    }
    if(dot < level.nesting_dolls_player_aim_dot) {
      continue;
    }
    if(0 == zombies[i] damageconetrace(view_pos, self)) {
      continue;
    }
    if(dot > best_dot) {
      best_dot = dot;
      best_target = zombies[i];
    }
  }
  return best_target;
}

function get_doll_best_doll_target(origin, range) {
  zombies = getaiarray(level.zombie_team);
  if(zombies.size > 0) {
    zombie_sort = util::get_array_of_closest(origin, zombies, undefined, undefined, range);
    for(i = 0; i < zombie_sort.size; i++) {
      if(isDefined(zombie_sort[i]) && isalive(zombie_sort[i])) {
        centroid = zombie_sort[i] getcentroid();
        if(bullettracepassed(origin, centroid, 0, undefined)) {
          return zombie_sort[i];
        }
      }
    }
  }
  return undefined;
}

function nesting_dolls_cleanup(parent) {
  while(true) {
    if(!isDefined(parent)) {
      zm_utility::self_delete();
      return;
    }
    wait(0.05);
  }
}

function do_nesting_dolls_sound(model, info) {
  monk_scream_vox = 0;
  if(level.music_override == 0) {
    monk_scream_vox = 0;
    self playSound("zmb_monkey_song");
  }
  self waittill("explode", position);
}

function get_thrown_nesting_dolls() {
  self endon("disconnect");
  self endon("starting_nesting_dolls");
  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    if(weapon == level.w_nesting_dolls) {
      return grenade;
    }
    wait(0.05);
  }
}

function nesting_dolls_debug_print(msg, color) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  print3d(self.origin + vectorscale((0, 0, 1), 60), msg, color, 1, 1, 40);
}

function nesting_dolls_set_id() {
  if(!isDefined(self.doll_id)) {
    self.doll_id = 0;
    return;
  }
  self.doll_id = self.doll_id + 1;
  if(self.doll_id >= level.nesting_dolls_max_ids) {
    self.doll_id = 0;
  }
}

function nesting_dolls_track_achievement(doll_id) {
  self endon("end_achievement_tracker" + doll_id);
  if(!isDefined(self.nesting_dolls_tracker)) {
    self.nesting_dolls_tracker = [];
    for(i = 0; i < level.nesting_dolls_max_ids; i++) {
      self.nesting_dolls_tracker[i] = [];
    }
  }
  for(i = 0; i < 4; i++) {
    self.nesting_dolls_tracker[doll_id][i] = 0;
  }
}

function nesting_dolls_check_achievement(doll_id) {
  self waittill("end_achievement_tracker" + doll_id);
  min_kills_per_doll = 1;
  for(i = 0; i < 4; i++) {
    if(self.nesting_dolls_tracker[doll_id][i] < min_kills_per_doll) {
      return;
    }
  }
}

function nesting_dolls_create_randomized_indices(id) {
  if(!isDefined(self.nesting_dolls_randomized_indices)) {
    self.nesting_dolls_randomized_indices = [];
  }
  base_indices = array(0, 1, 2, 3);
  self.nesting_dolls_randomized_indices[id] = array::randomize(base_indices);
}

function nesting_dolls_setup_next_doll_throw() {
  self endon("death");
  self endon("disconnect");
  wait(0.5);
  next_id = self.doll_id + 1;
  if(next_id >= level.nesting_dolls_max_ids) {
    next_id = 0;
  }
  self nesting_dolls_create_randomized_indices(next_id);
  if(self hasweapon(level.w_nesting_dolls)) {
    cammo = level.nesting_dolls_data[self.nesting_dolls_randomized_indices[next_id][0]].id;
    self updateweaponoptions(level.w_nesting_dolls, self calcweaponoptions(cammo, 0, 0));
  }
}