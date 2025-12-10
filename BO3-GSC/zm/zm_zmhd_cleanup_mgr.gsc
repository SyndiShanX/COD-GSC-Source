/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zmhd_cleanup_mgr.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zmhd_cleanup;

function autoexec __init__sytem__() {
  system::register("zmhd_cleanup", &__init__, &__main__, undefined);
}

function __init__() {
  level.n_cleanups_processed_this_frame = 0;
  level.no_target_override = &no_target_override;
}

function __main__() {
  level thread cleanup_main();
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
    if(isDefined(level.ignore_distance_tracking) && level.ignore_distance_tracking) {
      continue;
    }
    n_override_cleanup_dist_sq = undefined;
    if(level.zombie_total == 0 && zombie_utility::get_current_zombie_count() < 3) {
      n_override_cleanup_dist_sq = 2250000;
    }
    n_next_eval = n_next_eval + 3000;
    a_ai_enemies = getaiteamarray("axis");
    foreach(ai_enemy in a_ai_enemies) {
      if(level.n_cleanups_processed_this_frame >= 1) {
        level.n_cleanups_processed_this_frame = 0;
        util::wait_network_frame();
      }
      if(isDefined(ai_enemy) && (!(isDefined(ai_enemy.ignore_cleanup_mgr) && ai_enemy.ignore_cleanup_mgr))) {
        ai_enemy do_cleanup_check(n_override_cleanup_dist_sq);
      }
    }
  }
}

function do_cleanup_check(n_override_cleanup_dist) {
  if(!isalive(self)) {
    return;
  }
  if(self.b_ignore_cleanup === 1) {
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
    if(isDefined(n_override_cleanup_dist)) {
      n_cleanup_dist_sq = n_override_cleanup_dist;
    } else {
      if(isDefined(e_closest_player) && player_ahead_of_me(e_closest_player)) {
        n_cleanup_dist_sq = 189225;
      } else {
        n_cleanup_dist_sq = 250000;
      }
    }
    if(n_dist_sq_min >= n_cleanup_dist_sq) {
      self thread delete_zombie_noone_looking();
    }
  }
  if(!isalive(self)) {
    return;
  }
}

function private delete_zombie_noone_looking() {
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
  if(!(isDefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
    level.zombie_total++;
    level.zombie_respawns++;
    if(self.health < self.maxhealth) {
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
  }
  self zombie_utility::reset_attack_spot();
  if(!(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)) {
    self kill();
    wait(0.05);
    if(isDefined(self)) {
      debugstar(self.origin, 1000, (1, 1, 1));
      self delete();
    }
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

function no_target_override(ai_zombie) {
  if(isDefined(self.b_zombie_path_bad) && self.b_zombie_path_bad) {
    return;
  }
  var_b52b26b9 = ai_zombie get_escape_position();
  ai_zombie thread function_dc683d01(var_b52b26b9);
}

function private get_escape_position() {
  self endon("death");
  str_zone = zm_zonemgr::get_zone_from_position(self.origin + vectorscale((0, 0, 1), 32), 1);
  if(!isDefined(str_zone)) {
    str_zone = self.zone_name;
  }
  if(isDefined(str_zone)) {
    a_zones = get_adjacencies_to_zone(str_zone);
    a_wait_locations = get_wait_locations_in_zones(a_zones);
    arraysortclosest(a_wait_locations, self.origin);
    a_wait_locations = array::reverse(a_wait_locations);
    for(i = 0; i < a_wait_locations.size; i++) {
      if(a_wait_locations[i] function_eadbcbdb()) {
        return a_wait_locations[i].origin;
      }
    }
  }
  return self.origin;
}

function private function_dc683d01(var_b52b26b9) {
  self endon("death");
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  self.ignoreall = 1;
  self.b_zombie_path_bad = 1;
  self thread check_player_available();
  self setgoal(var_b52b26b9);
  self util::waittill_any_timeout(30, "goal", "reaquire_player");
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
  a_players = getplayers();
  for(i = 0; i < a_players.size; i++) {
    if(!zombie_utility::is_player_valid(a_players[i]) || (isDefined(a_players[i].ignoreme) && a_players[i].ignoreme)) {
      continue;
    }
    if(self maymovetopoint(a_players[i].origin, 1)) {
      return 1;
    }
  }
  if(isDefined(level.var_7c29c50e)) {
    return self[[level.var_7c29c50e]]();
  }
  return 0;
}

function private get_wait_locations_in_zones(a_zones) {
  a_wait_locations = [];
  foreach(zone in a_zones) {
    if(isDefined(level.zones[zone].a_loc_types["wait_location"])) {
      a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
      continue;
    }
    iprintlnbold("" + zone);
  }
  return a_wait_locations;
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