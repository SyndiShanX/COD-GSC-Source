/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_cleanup_mgr.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_elemental_zombies;
#using scripts\zm\_zm_light_zombie;
#using scripts\zm\_zm_shadow_zombie;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace genesis_cleanup;

function autoexec __init__sytem__() {
  system::register("genesis_cleanup", &__init__, &__main__, undefined);
}

function __init__() {
  level.n_cleanups_processed_this_frame = 0;
}

function __main__() {
  level thread cleanup_main();
  level.no_target_override = &no_target_override;
}

function force_check_now() {
  level notify("pump_distance_check");
}

function private cleanup_main() {
  n_next_eval = 0;
  while(true) {
    util::wait_network_frame();
    n_time = gettime();
    if(n_time < n_next_eval) {
      continue;
    }
    if(isDefined(level.n_cleanup_manager_restart_time)) {
      n_current_time = gettime() / 1000;
      n_delta_time = n_current_time - level.n_cleanup_manager_restart_time;
      if(n_delta_time < 0) {
        continue;
      }
      level.n_cleanup_manager_restart_time = undefined;
    }
    n_round_time = (n_time - level.round_start_time) / 1000;
    if(level.round_number <= 5 && n_round_time < 30) {
      continue;
    } else if(level.round_number > 5 && n_round_time < 20) {
      continue;
    }
    n_next_eval = n_next_eval + 3000;
    a_ai_enemies = getaiteamarray("axis");
    foreach(ai_enemy in a_ai_enemies) {
      if(level.n_cleanups_processed_this_frame >= 1) {
        level.n_cleanups_processed_this_frame = 0;
        util::wait_network_frame();
      }
      ai_enemy do_cleanup_check();
    }
  }
}

function private function_37a5b776() {
  var_a8951c29 = [];
  var_9e84b959 = array("start_island", "apothicon_island", "temple_island", "prototype_island", "asylum_island", "prison_island", "arena_island");
  for(i = 0; i < var_9e84b959.size; i++) {
    e_island = getent(var_9e84b959[i], "targetname");
    for(j = 0; j < level.activeplayers.size; j++) {
      if(!isalive(level.activeplayers[j])) {
        continue;
      }
      if(isDefined(level.activeplayers[j].is_flung) && level.activeplayers[j].is_flung) {
        return true;
      }
      if(level.activeplayers[j] istouching(e_island)) {
        array::add(var_a8951c29, e_island, 0);
      }
    }
  }
  if(!var_a8951c29.size) {
    return true;
  }
  for(k = 0; k < var_a8951c29.size; k++) {
    if(self istouching(var_a8951c29[k])) {
      return true;
    }
  }
  return false;
}

function do_cleanup_check() {
  if(!isalive(self)) {
    return;
  }
  if(self.archetype === "margwa" || self.archetype === "mechz") {
    return;
  }
  if(self.b_ignore_cleanup === 1) {
    return;
  }
  if(isDefined(self.b_teleporting) && self.b_teleporting) {
    return;
  }
  if(isDefined(self.traversal)) {
    return;
  }
  if(!self function_37a5b776()) {
    self thread function_b4d588f5();
    return;
  }
  if(isDefined(self.var_6d2a9142) && self.var_6d2a9142) {
    return;
  }
  n_time_alive = gettime() - self.spawn_time;
  if(n_time_alive < 5000) {
    return;
  }
  if(self.archetype === "zombie") {
    if(n_time_alive < 45000 && self.script_string !== "find_flesh" && self.completed_emerging_into_playable_area !== 1) {
      return;
    }
  }
  b_in_active_zone = self zm_zonemgr::entity_in_active_zone();
  level.n_cleanups_processed_this_frame++;
  if(!b_in_active_zone) {
    n_dist_sq_min = 10000000;
    e_closest_player = level.activeplayers[0];
    foreach(player in level.activeplayers) {
      n_dist_sq = distancesquared(self.origin, player.origin);
      if(n_dist_sq < n_dist_sq_min) {
        n_dist_sq_min = n_dist_sq;
        e_closest_player = player;
      }
    }
    if(isDefined(level.n_override_cleanup_dist_sq)) {
      n_cleanup_dist_sq = level.n_override_cleanup_dist_sq;
    } else {
      if(isDefined(e_closest_player) && player_ahead_of_me(e_closest_player)) {
        n_cleanup_dist_sq = 176400;
      } else {
        n_cleanup_dist_sq = 230400;
      }
    }
    if(n_dist_sq_min >= n_cleanup_dist_sq) {
      self thread delete_zombie_noone_looking();
    }
  }
}

function delete_zombie_noone_looking() {
  if(isDefined(self.in_the_ground) && self.in_the_ground) {
    return;
  }
  foreach(player in level.players) {
    if(player.sessionstate == "spectator") {
      continue;
    }
    if(self player_can_see_me(player)) {
      return;
    }
  }
  self thread function_b4d588f5();
}

function private function_b4d588f5() {
  if(!(isDefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
    level.zombie_total++;
    level.zombie_respawns++;
    self.var_4d11bb60 = 1;
    if(isDefined(self.maxhealth) && self.health < self.maxhealth) {
      if(!isDefined(level.a_zombie_respawn_health[self.archetype])) {
        level.a_zombie_respawn_health[self.archetype] = [];
      }
      if(!isDefined(level.a_zombie_respawn_health[self.archetype])) {
        level.a_zombie_respawn_health[self.archetype] = [];
      } else if(!isarray(level.a_zombie_respawn_health[self.archetype])) {
        level.a_zombie_respawn_health[self.archetype] = array(level.a_zombie_respawn_health[self.archetype]);
      }
      level.a_zombie_respawn_health[self.archetype][level.a_zombie_respawn_health[self.archetype].size] = self.health;
    }
    if(isDefined(self.var_9a02a614)) {
      if(!isDefined(level.a_zombie_respawn_type[self.var_9a02a614])) {
        level.a_zombie_respawn_type[self.var_9a02a614] = 0;
      }
      level.a_zombie_respawn_type[self.var_9a02a614]++;
    } else {
      if(!isDefined(level.a_zombie_respawn_type[self.archetype])) {
        level.a_zombie_respawn_type[self.archetype] = 0;
      }
      level.a_zombie_respawn_type[self.archetype]++;
    }
  }
  self zombie_utility::reset_attack_spot();
  self kill();
  wait(0.05);
  if(isDefined(self)) {
    debugstar(self.origin, 1000, (1, 1, 1));
    self delete();
  }
}

function player_can_see_me(player) {
  v_player_angles = player getplayerangles();
  v_player_forward = anglesToForward(v_player_angles);
  v_player_to_self = self.origin - player getorigin();
  v_player_to_self = vectornormalize(v_player_to_self);
  n_dot = vectordot(v_player_forward, v_player_to_self);
  if(n_dot < 0.766) {
    return false;
  }
  return true;
}

function private player_ahead_of_me(player) {
  v_player_angles = player getplayerangles();
  v_player_forward = anglesToForward(v_player_angles);
  v_dir = player getorigin() - self.origin;
  n_dot = vectordot(v_player_forward, v_dir);
  if(n_dot < 0) {
    return false;
  }
  return true;
}

function get_adjacencies_to_zone(str_zone) {
  a_adjacencies = [];
  a_adjacencies[0] = str_zone;
  a_adjacent_zones = getarraykeys(level.zones[str_zone].adjacent_zones);
  for(i = 0; i < a_adjacent_zones.size; i++) {
    if(level.zones[str_zone].adjacent_zones[a_adjacent_zones[i]].is_connected) {
      if(!isDefined(a_adjacencies)) {
        a_adjacencies = [];
      } else if(!isarray(a_adjacencies)) {
        a_adjacencies = array(a_adjacencies);
      }
      a_adjacencies[a_adjacencies.size] = a_adjacent_zones[i];
    }
  }
  return a_adjacencies;
}

function private get_farthest_wait_location(var_aabb7ed9) {
  if(!isDefined(var_aabb7ed9) || var_aabb7ed9.size == 0) {
    return undefined;
  }
  n_farthest_index = 0;
  n_distance_farthest = 0;
  for(i = 0; i < var_aabb7ed9.size; i++) {
    n_distance_sq = distancesquared(self.origin, var_aabb7ed9[i].origin);
    if(n_distance_sq > n_distance_farthest) {
      n_distance_farthest = n_distance_sq;
      n_farthest_index = i;
    }
  }
  return var_aabb7ed9[n_farthest_index];
}

function private get_wait_locations_in_zone(zone) {
  if(isDefined(level.zones[zone].a_loc_types["wait_location"])) {
    var_aabb7ed9 = [];
    var_aabb7ed9 = arraycombine(var_aabb7ed9, level.zones[zone].a_loc_types["wait_location"], 0, 0);
    return var_aabb7ed9;
  }
  return undefined;
}

function get_escape_position_in_current_zone() {
  self endon("death");
  str_zone = self.zone_name;
  if(!isDefined(str_zone)) {
    str_zone = self.zone_name;
  }
  if(isDefined(str_zone)) {
    var_aabb7ed9 = get_wait_locations_in_zone(str_zone);
    if(isDefined(var_aabb7ed9)) {
      s_farthest = self get_farthest_wait_location(var_aabb7ed9);
    }
  }
  return s_farthest;
}

function no_target_override(ai_zombie) {
  if(isDefined(self.b_zombie_path_bad) && self.b_zombie_path_bad) {
    return;
  }
  var_b52b26b9 = ai_zombie get_escape_position();
  ai_zombie thread function_dc683d01(var_b52b26b9);
}

function private get_escape_position() {
  str_zone = zm_zonemgr::get_zone_from_position(self.origin + vectorscale((0, 0, 1), 32), 1);
  if(!isDefined(str_zone)) {
    str_zone = self.zone_name;
  }
  if(isDefined(str_zone)) {
    a_str_zones = get_adjacencies_to_zone(str_zone);
    var_aabb7ed9 = get_wait_locations_in_zones(a_str_zones);
    arraysortclosest(var_aabb7ed9, self.origin);
    var_aabb7ed9 = array::reverse(var_aabb7ed9);
    for(i = 0; i < var_aabb7ed9.size; i++) {
      if(var_aabb7ed9[i] function_eadbcbdb()) {
        return var_aabb7ed9[i].origin;
      }
    }
  }
  return self.origin;
}

function private get_wait_locations_in_zones(a_str_zones) {
  var_aabb7ed9 = [];
  foreach(str_zone in a_str_zones) {
    var_aabb7ed9 = arraycombine(var_aabb7ed9, level.zones[str_zone].a_loc_types["wait_location"], 0, 0);
  }
  return var_aabb7ed9;
}

function private function_eadbcbdb() {
  if(!isDefined(self)) {
    return false;
  }
  if(!ispointonnavmesh(self.origin) || !zm_utility::check_point_in_playable_area(self.origin)) {
    return false;
  }
  return true;
}

function private function_dc683d01(var_b52b26b9) {
  self endon("death");
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  self.ignoreall = 1;
  self.b_zombie_path_bad = 1;
  self thread check_player_available();
  self setgoal(var_b52b26b9);
  self util::waittill_any_timeout(30, "goal", "reaquire_player", "death");
  self.ai_state = "find_flesh";
  self.ignoreall = 0;
  self.b_zombie_path_bad = undefined;
}

function private check_player_available() {
  self endon("death");
  while(isDefined(self.b_zombie_path_bad) && self.b_zombie_path_bad) {
    wait(randomfloatrange(0.2, 0.5));
    if(self can_zombie_see_any_player()) {
      self.b_zombie_path_bad = undefined;
      self notify("reaquire_player");
      return;
    }
  }
}

function private can_zombie_see_any_player() {
  for(i = 0; i < level.activeplayers.size; i++) {
    if(zombie_utility::is_player_valid(level.activeplayers[i])) {
      if(self function_ca420408(level.activeplayers[i])) {
        return true;
      }
    }
    wait(0.1);
  }
  return false;
}

function function_ca420408(player) {
  var_334f2464 = undefined;
  str_player_zone = undefined;
  var_334f2464 = zm_zonemgr::get_zone_from_position(self.origin + vectorscale((0, 0, 1), 32), 1);
  if(isDefined(player.zone_name)) {
    a_str_zones = get_adjacencies_to_zone(player.zone_name);
    for(i = 0; i < a_str_zones.size; i++) {
      if(var_334f2464 === a_str_zones[i]) {
        return true;
      }
    }
  }
  return false;
}