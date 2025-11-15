/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_sentinel_drone;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_raz;
#using scripts\zm\_zm_ai_sentinel_drone;
#using scripts\zm\_zm_behavior;
#using scripts\zm\_zm_elemental_zombies;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_stalingrad_zombie;

function autoexec init() {
  initzmstalingradbehaviorsandasm();
  level.zombie_init_done = & stalingrad_zombie_init_done;
  setdvar("scr_zm_use_code_enemy_selection", 0);
  level.closest_player_override = & stalingrad_closest_player;
  level.closest_player_targets_override = & function_6d4522d4;
  level.is_valid_player_for_sentinel_drone = & function_5915f3d5;
  level.pathdist_type = 2;
  level thread update_closest_player();
  level thread function_cec23cbf();
  level thread function_9b4d9341();
  spawner::add_archetype_spawn_function("zombie", & function_7854f310);
  spawner::add_archetype_spawn_function("sentinel_drone", & function_b10a912a);
  spawner::add_archetype_spawn_function("raz", & function_ec1b37df);
  level.var_dc87592f = 0;
  level.var_44d3a45c = struct::get("sentinel_back_door_goto", "targetname");
  level.var_ca793258 = struct::get("sentinel_back_door_teleport", "targetname");
}

function private initzmstalingradbehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("ZmStalingradAttackableObjectService", & zmstalingradattackableobjectservice);
}

function private zmstalingradattackableobjectservice(entity) {
  if(!(isDefined(entity.completed_emerging_into_playable_area) && entity.completed_emerging_into_playable_area)) {
    if(!(isDefined(entity.var_9d6ece1a) && entity.var_9d6ece1a)) {
      entity.attackable = undefined;
      return false;
    }
  }
  zm_behavior::zombieattackableobjectservice(entity);
}

function private function_7854f310() {
  self ai::set_behavior_attribute("use_attackable", 1);
  self.cant_move_cb = & function_c2866c1b;
  self thread function_72fad482();
  self.attackable_goal_radius = 8;
}

function private function_72fad482() {
  self endon("death");
  while(true) {
    if(isDefined(self.zone_name)) {
      if(self.zone_name == "pavlovs_A_zone" || self.zone_name == "pavlovs_B_zone") {
        self.var_edfdda83 = 1;
        return;
      }
    }
    wait(randomfloatrange(0.25, 0.5));
  }
}

function private function_c2866c1b() {
  if(isDefined(self.attackable)) {
    if(isDefined(self.attackable.is_active) && self.attackable.is_active) {
      self pushactors(0);
      self.enablepushtime = gettime() + 1000;
    }
  }
}

function private function_a796c73f(player) {
  var_c3cc60d3 = 0;
  var_4d53d2ae = 0;
  if(isDefined(player.zone_name)) {
    if(player.zone_name == "pavlovs_A_zone" || player.zone_name == "pavlovs_B_zone" || player.zone_name == "pavlovs_C_zone") {
      var_c3cc60d3 = 1;
    }
  }
  if(isDefined(self.zone_name)) {
    if(self.zone_name == "pavlovs_A_zone" || self.zone_name == "pavlovs_B_zone" || self.zone_name == "pavlovs_C_zone") {
      var_4d53d2ae = 1;
    }
  }
  if(isDefined(self.var_edfdda83) && self.var_edfdda83) {
    var_4d53d2ae = 1;
  }
  if(var_c3cc60d3 != var_4d53d2ae) {
    return false;
  }
  return true;
}

function stalingrad_zombie_init_done() {
  self pushactors(0);
}

function private stalingrad_validate_last_closest_player(players) {
  if(isDefined(self.last_closest_player) && (isDefined(self.last_closest_player.am_i_valid) && self.last_closest_player.am_i_valid)) {
    return;
  }
  self.need_closest_player = 1;
  foreach(player in players) {
    if(self function_a796c73f(player)) {
      self.last_closest_player = player;
      return;
    }
  }
  self.last_closest_player = undefined;
}

function private function_6d4522d4() {
  targets = getplayers();
  for(i = 0; i < targets.size; i++) {
    if(!function_a796c73f(targets[i])) {
      arrayremovevalue(targets, targets[i]);
    }
  }
  return targets;
}

function private function_5915f3d5(target) {
  distance = distance2dsquared(target.origin, self.origin);
  if(distance > (10000 * 10000)) {
    return false;
  }
  return true;
}

function private stalingrad_closest_player(origin, players) {
  if(isDefined(self.zombie_poi)) {
    return undefined;
  }
  done = 0;
  while(players.size && !done) {
    done = 1;
    for(i = 0; i < players.size; i++) {
      target = players[i];
      if(!zombie_utility::is_player_valid(target, 1, 1)) {
        arrayremovevalue(players, target);
        done = 0;
        break;
      }
    }
  }
  if(players.size == 0) {
    return undefined;
  }
  designated_target = 0;
  foreach(player in players) {
    if(isDefined(player.b_is_designated_target) && player.b_is_designated_target) {
      designated_target = 1;
      break;
    }
  }
  if(!designated_target) {
    if(isDefined(self.attackable) && self.attackable.is_active) {
      return undefined;
    }
  }
  if(players.size == 1) {
    if(self function_a796c73f(players[0])) {
      self.last_closest_player = players[0];
      return self.last_closest_player;
    }
    return undefined;
  }
  if(!isDefined(self.last_closest_player)) {
    self.last_closest_player = players[0];
  }
  if(!isDefined(self.need_closest_player)) {
    self.need_closest_player = 1;
  }
  if(isDefined(level.last_closest_time) && level.last_closest_time >= level.time) {
    self stalingrad_validate_last_closest_player(players);
    return self.last_closest_player;
  }
  if(isDefined(self.need_closest_player) && self.need_closest_player) {
    level.last_closest_time = level.time;
    self.need_closest_player = 0;
    closest = players[0];
    closest_dist = undefined;
    if(isDefined(players[0].am_i_valid) && players[0].am_i_valid && self function_a796c73f(players[0])) {
      if(isactor(self)) {
        closest_dist = self zm_utility::approximate_path_dist(closest);
      } else {
        closest_dist = distancesquared(self.origin, closest.origin);
      }
    }
    if(!isDefined(closest_dist)) {
      closest = undefined;
    }
    for(index = 1; index < players.size; index++) {
      dist = undefined;
      if(isDefined(players[index].am_i_valid) && players[index].am_i_valid && self function_a796c73f(players[index])) {
        if(isactor(self)) {
          dist = self zm_utility::approximate_path_dist(players[index]);
        } else {
          dist = distancesquared(self.origin, players[index].origin);
        }
      }
      if(isDefined(dist)) {
        if(isDefined(closest_dist)) {
          if(dist < closest_dist) {
            closest = players[index];
            closest_dist = dist;
          }
          continue;
        }
        closest = players[index];
        closest_dist = dist;
      }
    }
    self.last_closest_player = closest;
  }
  if(players.size > 1 && isDefined(closest)) {
    if(isactor(self)) {
      self zm_utility::approximate_path_dist(closest);
    }
  }
  self stalingrad_validate_last_closest_player(players);
  return self.last_closest_player;
}

function private update_closest_player() {
  level waittill("start_of_round");
  while(true) {
    reset_closest_player = 1;
    zombies = zombie_utility::get_round_enemy_array();
    foreach(zombie in zombies) {
      if(isDefined(zombie.need_closest_player) && zombie.need_closest_player) {
        reset_closest_player = 0;
        break;
      }
    }
    if(reset_closest_player) {
      foreach(zombie in zombies) {
        if(isDefined(zombie.need_closest_player)) {
          zombie.need_closest_player = 1;
        }
      }
    }
    wait(0.05);
  }
}

function function_b10a912a() {
  self endon("death");
  self waittill("completed_spawning");
  if(isDefined(self.s_spawn_loc) && issubstr(self.s_spawn_loc.targetname, "pavlov")) {
    self.should_buff_zombies = 1;
    if(self.var_c94972aa === 1) {
      self.var_98bec529 = 1;
    }
  }
}

function function_ec1b37df() {
  self thread zm::update_zone_name();
  self thread function_72fad482();
}

function function_cec23cbf() {
  level waittill("start_of_round");
  n_current_time = gettime();
  var_36eeba73 = 0;
  var_c48f3f8a = 0;
  var_b8e747cf = 1;
  var_c9b19c0c = [];
  var_bb6abcd9 = [];
  var_bcfa504e = struct::get_array("pavlovs_B_spawn", "targetname");
  foreach(s_spawn in var_bcfa504e) {
    if(s_spawn.script_noteworthy == "raz_location") {
      if(!isDefined(var_c9b19c0c)) {
        var_c9b19c0c = [];
      } else if(!isarray(var_c9b19c0c)) {
        var_c9b19c0c = array(var_c9b19c0c);
      }
      var_c9b19c0c[var_c9b19c0c.size] = s_spawn;
    }
    if(s_spawn.script_noteworthy == "sentinel_location") {
      if(!isDefined(var_bb6abcd9)) {
        var_bb6abcd9 = [];
      } else if(!isarray(var_bb6abcd9)) {
        var_bb6abcd9 = array(var_bb6abcd9);
      }
      var_bb6abcd9[var_bb6abcd9.size] = s_spawn;
    }
  }
  while(true) {
    if(level flag::get("special_round")) {
      level flag::wait_till_clear("special_round");
      continue;
    }
    if(flag::exists("world_is_paused")) {
      level flag::wait_till_clear("world_is_paused");
    }
    if(!level flag::get("spawn_zombies")) {
      level waittill("spawn_zombies");
    }
    n_current_time = gettime();
    var_a62c1873 = 0;
    foreach(e_player in level.players) {
      if(zm_utility::is_player_valid(e_player)) {
        var_54bcb829 = zm_zonemgr::get_zone_from_position(e_player.origin + vectorscale((0, 0, 1), 32), 0);
        if(var_54bcb829 === "pavlovs_A_zone" || var_54bcb829 === "pavlovs_B_zone" || var_54bcb829 === "pavlovs_C_zone") {
          var_a62c1873++;
        }
      }
    }
    if(var_a62c1873 > 0) {
      if(var_b8e747cf) {
        n_current_time = gettime();
        var_36eeba73 = function_8caf1f25(var_a62c1873);
        var_c48f3f8a = n_current_time + 15000;
        var_b8e747cf = 0;
      }
      if(var_36eeba73 <= n_current_time) {
        if((zombie_utility::get_current_zombie_count() + level.zombie_total) > 5) {
          s_spawn_loc = array::random(var_c9b19c0c);
          if(zm_ai_raz::function_7ed6c714(1, undefined, 1, s_spawn_loc)) {
            level.zombie_total--;
            var_36eeba73 = function_8caf1f25(var_a62c1873);
          }
        }
      } else if(level.var_f73b438a > 1 && var_c48f3f8a <= n_current_time) {
        if(zm_ai_sentinel_drone::function_74ab7484() && (zombie_utility::get_current_zombie_count() + level.zombie_total) > 5) {
          s_spawn_loc = array::random(var_bb6abcd9);
          if(zm_ai_sentinel_drone::function_19d0b055(1, undefined, 1, s_spawn_loc)) {
            level.zombie_total--;
            level.var_bd1e3d02++;
            var_c48f3f8a = function_c7a940c4(var_a62c1873);
          }
        }
      }
    } else {
      level waittill("hash_9a634383");
      wait(5);
      var_b8e747cf = 1;
      continue;
    }
    wait(5);
  }
}

function function_8caf1f25(n_players) {
  n_current_time = gettime();
  if(n_players > 0 && n_players <= 2) {
    var_36eeba73 = n_current_time + 180000;
  } else {
    if(n_players == 3) {
      var_36eeba73 = n_current_time + 120000;
    } else if(n_players == 4) {
      var_36eeba73 = n_current_time + 90000;
    }
  }
  return var_36eeba73;
}

function function_c7a940c4(n_players) {
  n_current_time = gettime();
  if(n_players > 0 && n_players <= 2) {
    var_c48f3f8a = n_current_time + 180000;
  } else {
    if(n_players == 3) {
      var_c48f3f8a = n_current_time + 120000;
    } else if(n_players == 4) {
      var_c48f3f8a = n_current_time + 90000;
    }
  }
  return var_c48f3f8a;
}

function function_3de9d297() {
  var_eb1ae81f = 0;
  var_1916d2ed = getEntArray("zombie_sentinel", "targetname");
  foreach(var_663b2442 in var_1916d2ed) {
    str_zone = zm_zonemgr::get_zone_from_position(var_663b2442.origin + vectorscale((0, 0, 1), 32), 0);
    if(str_zone === "pavlovs_A_zone" || str_zone === "pavlovs_B_zone" || str_zone === "pavlovs_C_zone") {
      var_eb1ae81f++;
    }
  }
  return var_eb1ae81f;
}

function function_9b4d9341() {
  level waittill("start_of_round");
  while(true) {
    if(flag::exists("world_is_paused")) {
      level flag::wait_till_clear("world_is_paused");
    }
    var_a62c1873 = 0;
    var_110db1be = undefined;
    foreach(e_player in level.players) {
      if(zm_utility::is_player_valid(e_player)) {
        var_54bcb829 = zm_zonemgr::get_zone_from_position(e_player.origin + vectorscale((0, 0, 1), 32), 0);
        if(var_54bcb829 === "pavlovs_A_zone" || var_54bcb829 === "pavlovs_B_zone" || var_54bcb829 === "pavlovs_C_zone") {
          var_110db1be = e_player;
          var_a62c1873++;
        }
      }
    }
    if(var_a62c1873 > 0) {
      level.var_809d579e = & function_8b981aa0;
      level thread function_a442e988(var_110db1be);
    } else {
      level.var_809d579e = undefined;
      wait(15);
      continue;
    }
    wait(5);
  }
}

function function_8b981aa0() {
  var_eb1ae81f = function_3de9d297();
  if(var_eb1ae81f == 0) {
    a_s_spawn_locs = struct::get_array("pavlovs_A_spawn", "targetname");
    return array::random(a_s_spawn_locs);
  }
  return zm_ai_sentinel_drone::function_f9c9e7e0();
}

function function_a442e988(e_player) {
  if(level.var_dc87592f) {
    return;
  }
  var_1916d2ed = getEntArray("zombie_sentinel", "targetname");
  foreach(var_663b2442 in var_1916d2ed) {
    while(isDefined(var_663b2442) && !var_663b2442 flag::exists("completed_spawning")) {
      wait(0.05);
    }
    if(!isDefined(var_663b2442)) {
      continue;
    }
    var_663b2442 flag::wait_till("completed_spawning");
    str_zone = zm_zonemgr::get_zone_from_position(var_663b2442.origin + vectorscale((0, 0, 1), 32), 0);
    if(str_zone === "pavlovs_A_zone" || str_zone === "pavlovs_B_zone" || str_zone === "pavlovs_C_zone") {
      return;
    }
    if(distance2dsquared(var_663b2442.origin, e_player.origin) < 6250000 && distance2dsquared(var_663b2442.origin, level.var_ca793258.origin) > 250000) {
      if(var_663b2442.var_c94972aa === 1) {
        if(var_663b2442.var_7e04bb3 === 1) {
          continue;
        } else {
          var_663b2442 notify("hash_d600cb9a");
        }
      }
      var_d7b33d0c = var_663b2442;
      break;
    }
  }
  if(isDefined(var_d7b33d0c)) {
    level.var_dc87592f = 1;
    var_d7b33d0c thread function_f05eb36e();
    var_d7b33d0c endon("death");
    var_663b2442 flag::wait_till("completed_spawning");
    var_d7b33d0c sentinel_drone::sentinel_forcegoandstayinposition(1, level.var_44d3a45c.origin);
    var_d7b33d0c waittill("goal");
    var_d7b33d0c.origin = level.var_ca793258.origin;
    var_d7b33d0c sentinel_drone::sentinel_forcegoandstayinposition(0);
    var_d7b33d0c.should_buff_zombies = 0;
    if(var_d7b33d0c.var_c94972aa === 1) {
      var_d7b33d0c.var_98bec529 = 0;
      var_d7b33d0c thread zm_ai_sentinel_drone::function_d600cb9a();
    }
  }
}

function function_f05eb36e() {
  self waittill("death");
  level.var_dc87592f = 0;
}