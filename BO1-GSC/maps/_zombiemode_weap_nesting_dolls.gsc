/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_weap_nesting_dolls.gsc
***************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

init() {
  if(!nesting_dolls_exists()) {
    return;
  }
  level.nesting_dolls_launch_speed = 500;
  level.nesting_dolls_launch_angle = 45;
  level.nesting_dolls_too_close_dist = 100 * 100;
  level.nesting_dolls_det_time = 0.25;
  level.nesting_dolls_player_aim_dot = Cos(45 / 2);
  level.nesting_dolls_damage_radius = 180;
  gravity = getdvarfloat(#"bg_gravity");
  level.nesting_dolls_launch_peak_time = ((level.nesting_dolls_launch_speed * Sin(level.nesting_dolls_launch_angle)) / Abs(gravity)) * 0.5;
  level.nesting_dolls_max_ids = 10;
  setup_nesting_dolls_data();
  PreCacheItem("zombie_nesting_doll_single");
}

setup_nesting_dolls_data() {
  if(isDefined(level.nesting_dolls_override_setup)) {
    [
      [level.nesting_dolls_override_setup]
    ]();
    return;
  }
  level._effect["nesting_doll_trail_blue"] = loadFx("maps/zombie/fx_zmb_trail_doll_blue");
  level._effect["nesting_doll_trail_green"] = loadFx("maps/zombie/fx_zmb_trail_doll_green");
  level._effect["nesting_doll_trail_red"] = loadFx("maps/zombie/fx_zmb_trail_doll_red");
  level._effect["nesting_doll_trail_yellow"] = loadFx("maps/zombie/fx_zmb_trail_doll_yellow");
  level.nesting_dolls_data = [];
  level.nesting_dolls_data[0] = SpawnStruct();
  level.nesting_dolls_data[0].name = "dempsey";
  level.nesting_dolls_data[0].id = 16;
  level.nesting_dolls_data[0].trailFx = level._effect["nesting_doll_trail_blue"];
  level.nesting_dolls_data[1] = SpawnStruct();
  level.nesting_dolls_data[1].name = "nikolai";
  level.nesting_dolls_data[1].id = 17;
  level.nesting_dolls_data[1].trailFx = level._effect["nesting_doll_trail_red"];
  level.nesting_dolls_data[2] = SpawnStruct();
  level.nesting_dolls_data[2].name = "takeo";
  level.nesting_dolls_data[2].id = 18;
  level.nesting_dolls_data[2].trailFx = level._effect["nesting_doll_trail_green"];
  level.nesting_dolls_data[3] = SpawnStruct();
  level.nesting_dolls_data[3].name = "richtofen";
  level.nesting_dolls_data[3].id = 19;
  level.nesting_dolls_data[3].trailFx = level._effect["nesting_doll_trail_yellow"];
  PreCacheModel("t5_nesting_bomb_world_doll1_dempsey");
  PreCacheModel("t5_nesting_bomb_world_doll2_dempsey");
  PreCacheModel("t5_nesting_bomb_world_doll3_dempsey");
  PreCacheModel("t5_nesting_bomb_world_doll4_dempsey");
  PreCacheModel("t5_nesting_bomb_world_doll1_nikolai");
  PreCacheModel("t5_nesting_bomb_world_doll2_nikolai");
  PreCacheModel("t5_nesting_bomb_world_doll3_nikolai");
  PreCacheModel("t5_nesting_bomb_world_doll4_nikolai");
  PreCacheModel("t5_nesting_bomb_world_doll1_takeo");
  PreCacheModel("t5_nesting_bomb_world_doll2_takeo");
  PreCacheModel("t5_nesting_bomb_world_doll3_takeo");
  PreCacheModel("t5_nesting_bomb_world_doll4_takeo");
  PreCacheModel("t5_nesting_bomb_world_doll1_richtofen");
  PreCacheModel("t5_nesting_bomb_world_doll2_richtofen");
  PreCacheModel("t5_nesting_bomb_world_doll3_richtofen");
  PreCacheModel("t5_nesting_bomb_world_doll4_richtofen");
}

nesting_dolls_exists() {
  return isDefined(level.zombie_weapons["zombie_nesting_dolls"]);
}

player_give_nesting_dolls() {
  self nesting_dolls_create_randomized_indices(0);
  start_cammo = level.nesting_dolls_data[self.nesting_dolls_randomized_indices[0][0]].id;
  self giveweapon("zombie_nesting_dolls", 0, self CalcWeaponOptions(start_cammo));
  self set_player_tactical_grenade("zombie_nesting_dolls");
  self thread player_handle_nesting_dolls();
}

#using_animtree("zombie_cymbal_monkey");
player_handle_nesting_dolls() {
  self notify("starting_nesting_dolls");
  self endon("disconnect");
  self endon("starting_nesting_dolls");
  while(true) {
    grenade = get_thrown_nesting_dolls();
    if(isDefined(grenade)) {
      if(self maps\_laststand::player_is_in_laststand()) {
        grenade delete();
        continue;
      }
      self thread doll_spawner_cluster(grenade);
    }
    wait(0.05);
  }
}

doll_spawner(start_grenade) {
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
    grenade = self MagicGrenadeType("zombie_nesting_doll_single", origin, grenade_vel);
    grenade spawn_doll_model(self.doll_id, num_dolls, self);
    grenade thread doll_behavior_explode_when_stopped(self, self.doll_id, num_dolls);
    num_dolls++;
  }
}

doll_spawner_cluster(start_grenade) {
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
    grenade = self MagicGrenadeType("zombie_nesting_doll_single", origin, grenade_vel);
    grenade spawn_doll_model(self.doll_id, num_dolls, self);
    grenade PlaySound("wpn_nesting_pop_npc");
    grenade thread doll_behavior_explode_when_stopped(self, self.doll_id, num_dolls);
    num_dolls++;
    wait(0.25);
  }
}

doll_do_damage(origin, owner, id, index) {
  self waittill("explode");
  zombies = GetAiSpeciesArray("axis", "all");
  if(zombies.size == 0) {
    return;
  }
  zombie_sort = get_array_of_closest(origin, zombies, undefined, undefined, level.nesting_dolls_damage_radius);
  for(i = 0; i < zombie_sort.size; i++) {
    if(IsAlive(zombie_sort[i])) {
      if(zombie_sort[i] DamageConeTrace(origin, owner) == 1) {
        owner.nesting_dolls_tracker[id][index] = owner.nesting_dolls_tracker[id][index] + 1;
      }
    }
  }
  RadiusDamage(origin, level.nesting_dolls_damage_radius, 95000, 95000, owner, "MOD_GRENADE_SPLASH", "zombie_nesting_doll_single");
}

randomize_angles(angles) {
  random_yaw = RandomIntRange(-45, 45);
  random_pitch = RandomIntRange(-45, -35);
  random = (random_pitch, random_yaw, 0);
  return_angles = angles + random;
  return return_angles;
}

get_random_launch_velocity(doll_origin, angles) {
  angles = randomize_angles(angles);
  trace_dist = level.nesting_dolls_launch_speed * level.nesting_dolls_launch_peak_time;
  for(i = 0; i < 4; i++) {
    dir = AnglesToForward(angles);
    if(BulletTracePassed(doll_origin, doll_origin + dir * trace_dist, false, undefined)) {
      grenade_vel = dir * level.nesting_dolls_launch_speed;
      return grenade_vel;
    } else {
      angles = angles + (0, 90, 0);
    }
  }
  return (0, 0, level.nesting_dolls_launch_speed);
}

get_cluster_launch_velocity(angles, index) {
  random_pitch = RandomIntRange(-45, -35);
  offsets = array(45, 0, -45);
  angles = angles + (random_pitch, offsets[index - 1], 0);
  dir = AnglesToForward(angles);
  grenade_vel = dir * level.nesting_dolls_launch_speed;
  return grenade_vel;
}

get_launch_velocity(doll_origin, range) {
  velocity = (0, 0, 0);
  target = get_doll_best_doll_target(doll_origin, range);
  if(isDefined(target)) {
    target_origin = target get_target_leading_pos();
    dir = VectorToAngles(target_origin - doll_origin);
    dir = (dir[0] - level.nesting_dolls_launch_angle, dir[1], dir[2]);
    dir = AnglesToForward(dir);
    velocity = dir * level.nesting_dolls_launch_speed;
  }
  return velocity;
}

get_target_leading_pos() {
  position = self.origin;
  return position;
}

spawn_doll_model(id, index, parent) {
  self hide();
  self.doll_model = spawn("script_model", self.origin);
  data_index = parent.nesting_dolls_randomized_indices[id][index];
  name = level.nesting_dolls_data[data_index].name;
  model_index = index + 1;
  model_name = "t5_nesting_bomb_world_doll" + model_index + "_" + name;
  self.doll_model setModel(model_name);
  self.doll_model UseAnimTree(#animtree);
  self.doll_model LinkTo(self);
  self.doll_model.angles = self.angles;
  PlayFxOnTag(level.nesting_dolls_data[data_index].trailFx, self.doll_model, "tag_origin");
  self.doll_model thread nesting_dolls_cleanup(self);
}

doll_behavior_explode_when_stopped(parent, doll_id, index) {
  velocitySq = 10000 * 10000;
  oldPos = self.origin;
  while(velocitySq != 0) {
    wait(0.1);
    if(!isDefined(self)) {
      break;
    }
    velocitySq = distanceSquared(self.origin, oldPos);
    oldPos = self.origin;
  }
  if(isDefined(self)) {
    self.doll_model unlink();
    self.doll_model.origin = self.origin;
    self.doll_model.angles = self.angles;
    parent notify("spawn_doll", self.origin, self.angles);
    self thread doll_do_damage(self.origin, parent, doll_id, index);
    self ResetMissileDetonationTime(level.nesting_dolls_det_time);
    if(isDefined(index) && index == 3) {
      parent thread nesting_dolls_end_achievement_tracking(doll_id);
    }
  }
}

nesting_dolls_end_achievement_tracking(doll_id) {
  wait(level.nesting_dolls_det_time + 0.1);
  self notify("end_achievement_tracker" + doll_id);
}

get_player_aim_best_doll_target(range) {
  view_pos = self GetWeaponMuzzlePoint();
  zombies = get_array_of_closest(view_pos, GetAiSpeciesArray("axis", "all"), undefined, undefined, (range * 1.1));
  if(!isDefined(zombies)) {
    return;
  }
  range_squared = range * range;
  forward_view_angles = self GetWeaponForwardDir();
  end_pos = view_pos + vector_scale(forward_view_angles, range);
  best_dot = -999.0;
  best_target = undefined;
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || !IsAlive(zombies[i])) {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distanceSquared(view_pos, test_origin);
    if(test_range_squared > range_squared) {
      return;
    }
    normal = VectorNormalize(test_origin - view_pos);
    dot = VectorDot(forward_view_angles, normal);
    if(dot < 0) {
      continue;
    }
    if(dot < level.nesting_dolls_player_aim_dot) {
      continue;
    }
    if(0 == zombies[i] DamageConeTrace(view_pos, self)) {
      continue;
    }
    if(dot > best_dot) {
      best_dot = dot;
      best_target = zombies[i];
    }
  }
  return best_target;
}

get_doll_best_doll_target(origin, range) {
  zombies = GetAIArray("axis");
  if(zombies.size > 0) {
    zombie_sort = get_array_of_closest(origin, zombies, undefined, undefined, range);
    for(i = 0; i < zombie_sort.size; i++) {
      if(isDefined(zombie_sort[i]) && IsAlive(zombie_sort[i])) {
        centroid = zombie_sort[i] GetCentroid();
        if(BulletTracePassed(origin, centroid, false, undefined)) {
          return zombie_sort[i];
        }
      }
    }
  }
  return undefined;
}

nesting_dolls_cleanup(parent) {
  while(true) {
    if(!isDefined(parent)) {
      self_delete();
      return;
    }
    wait(0.05);
  }
}

do_nesting_dolls_sound(model, info) {
  monk_scream_vox = false;
  if(level.music_override == false) {
    monk_scream_vox = false;
    self playsound("zmb_monkey_song");
  }
  self waittill("explode", position);
  if(isDefined(model)) {}
  if(!monk_scream_vox) {
    play_sound_in_space("zmb_vox_monkey_explode", position);
  }
}

get_thrown_nesting_dolls() {
  self endon("disconnect");
  self endon("starting_nesting_dolls");
  while(true) {
    self waittill("grenade_fire", grenade, weapName);
    if(weapName == "zombie_nesting_dolls") {
      return grenade;
    }
    wait(0.05);
  }
}

nesting_dolls_debug_print(msg, color) {}
nesting_dolls_tesla_nearby_zombies(doll) {
  wait(level.nesting_dolls_launch_peak_time);
  zombies = GetAiSpeciesArray("axis", "all");
  zombie_sort = get_array_of_closest(doll.origin, zombies, undefined, 15, 250);
  for(i = 0; i < zombie_sort.size; i++) {
    centroid = zombie_sort[i] GetCentroid();
    level thread nesting_dolls_play_tesla_bolt(doll.origin, centroid);
    zombie_sort[i] thread maps\_zombiemode_weap_tesla::tesla_damage_init("head", centroid, self);
  }
}

nesting_dolls_play_tesla_bolt(origin, target_origin) {
  fxOrg = spawn("script_model", origin);
  fxOrg setModel("tag_origin");
  fx = PlayFxOnTag(level._effect["tesla_bolt"], fxOrg, "tag_origin");
  playsoundatposition("wpn_tesla_bounce", fxOrg.origin);
  fxOrg moveTo(target_origin, 0.25);
  fxOrg waittill("movedone");
  fxOrg delete();
}

nesting_dolls_set_id() {
  if(!isDefined(self.doll_id)) {
    self.doll_id = 0;
    return;
  }
  self.doll_id = self.doll_id + 1;
  if(self.doll_id >= level.nesting_dolls_max_ids) {
    self.doll_id = 0;
  }
}

nesting_dolls_track_achievement(doll_id) {
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

nesting_dolls_check_achievement(doll_id) {
  self waittill("end_achievement_tracker" + doll_id);
  min_kills_per_doll = 1;
  for(i = 0; i < 4; i++) {
    if(self.nesting_dolls_tracker[doll_id][i] < min_kills_per_doll) {
      return;
    }
  }
}

nesting_dolls_create_randomized_indices(id) {
  if(!isDefined(self.nesting_dolls_randomized_indices)) {
    self.nesting_dolls_randomized_indices = [];
  }
  base_indices = array(0, 1, 2, 3);
  self.nesting_dolls_randomized_indices[id] = array_randomize(base_indices);
}

nesting_dolls_setup_next_doll_throw() {
  self endon("death");
  self endon("disconnect");
  wait(0.5);
  next_id = self.doll_id + 1;
  if(next_id >= level.nesting_dolls_max_ids) {
    next_id = 0;
  }
  self nesting_dolls_create_randomized_indices(next_id);
  if(self hasWeapon("zombie_nesting_dolls")) {
    cammo = level.nesting_dolls_data[self.nesting_dolls_randomized_indices[next_id][0]].id;
    self UpdateWeaponOptions("zombie_nesting_dolls", self CalcWeaponOptions(cammo));
  }
}