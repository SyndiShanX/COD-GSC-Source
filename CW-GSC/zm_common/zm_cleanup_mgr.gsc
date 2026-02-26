/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_cleanup_mgr.gsc
***********************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_cleanup;

function preinit() {
  level.n_cleanups_processed_this_frame = 0;
  level.var_2125984b = 0;
  level.cleanup_zombie_func = &delete_zombie_noone_looking;
  level.var_fc73bad4 = [];
}

function postinit() {
  level thread cleanup_main();
}

function force_check_now() {
  level notify(#"pump_distance_check");
}

function function_949dc047(var_c2526fee) {
  level.n_cleanup_manager_restart_time = var_c2526fee;

  if(!function_7415d2e2()) {
    level notify(#"hash_15cc0436ec23c79c");
  }
}

function private function_7415d2e2() {
  if(isDefined(level.n_cleanup_manager_restart_time)) {
    n_current_time = gettime() / 1000;
    n_delta_time = level.n_cleanup_manager_restart_time - n_current_time;
    return (n_delta_time <= 0);
  }

  return 1;
}

function private cleanup_main() {
  level endon(#"end_game");
  n_next_eval = 0;

  while(true) {
    util::wait_network_frame();
    n_time = gettime();

    if(n_time < n_next_eval) {
      continue;
    }

    if(function_7415d2e2()) {
      level.n_cleanup_manager_restart_time = undefined;
    } else {
      continue;
    }

    n_round_time = (n_time - level.round_start_time) / 1000;

    if(level.round_number <= 5 && n_round_time < 30) {
      continue;
    } else if(level.round_number > 5 && n_round_time < 20) {
      continue;
    }

    profilestart();
    n_override_cleanup_dist_sq = undefined;

    if(level.zombie_total == 0 && zombie_utility::get_current_zombie_count() < 3 || zm_utility::function_c200446c()) {
      n_override_cleanup_dist_sq = 2250000;
    }

    profilestop();
    n_next_eval += 3000;
    level function_399d4af3(n_override_cleanup_dist_sq);
  }
}

function private function_399d4af3(n_override_cleanup_dist_sq) {
  level endon(#"hash_15cc0436ec23c79c");
  a_ai_enemies = getaiteamarray(#"axis");

  foreach(ai_enemy in a_ai_enemies) {
    if(level.n_cleanups_processed_this_frame >= 1) {
      level.n_cleanups_processed_this_frame = 0;
      util::wait_network_frame();
    }

    ai_enemy do_cleanup_check(n_override_cleanup_dist_sq);
  }
}

function function_5372feb8() {
  foreach(player in function_a1ef346b()) {
    if(!is_true(player.var_16735873) || isDefined(player zm_zonemgr::get_player_zone())) {
      return false;
    }
  }

  return true;
}

function do_cleanup_check(n_override_cleanup_dist) {
  if(!isalive(self)) {
    return;
  }

  if(self.b_ignore_cleanup === 1) {
    return;
  }

  if(isDefined(self.var_b0709fcc)) {
    if(is_true(self[[self.var_b0709fcc]]())) {
      return;
    }
  }

  n_time_alive = gettime() - self.spawn_time;

  if(n_time_alive < 5000) {
    return;
  }

  if(is_true(self.var_61c270)) {
    return;
  }

  if(n_time_alive < 45000 && self.completed_emerging_into_playable_area !== 1 && !is_true(self.var_357c108b)) {
    return;
  }

  if(level function_5372feb8()) {
    return;
  }

  b_in_active_zone = self zm_zonemgr::entity_in_active_zone();

  if(is_true(level.var_11f7a9af) || is_true(self.var_11f7a9af)) {
    var_22295e13 = self zm_zonemgr::get_zone_from_position(self.origin);

    if(isDefined(var_22295e13) && zm_zonemgr::get_players_in_zone(var_22295e13) == 0) {
      b_in_active_zone = 0;
    }
  }

  level.n_cleanups_processed_this_frame++;

  if(!b_in_active_zone) {
    n_dist_sq_min = 10000000;
    players = getplayers();
    e_closest_player = players[0];

    foreach(player in players) {
      if(!isalive(player)) {
        continue;
      }

      n_dist_sq = distancesquared(self.origin, player.origin);

      if(n_dist_sq < n_dist_sq_min) {
        n_dist_sq_min = n_dist_sq;
        e_closest_player = player;
      }
    }

    if(isDefined(n_override_cleanup_dist)) {
      n_cleanup_dist_sq = n_override_cleanup_dist;
    } else if(isDefined(e_closest_player) && player_ahead_of_me(e_closest_player)) {
      if(self.zombie_move_speed === "walk") {
        n_cleanup_dist_sq = isDefined(level.registertheater_fxanim_kill_trigger_centerterminatetraverse) ? level.registertheater_fxanim_kill_trigger_centerterminatetraverse : 250000;
      } else {
        n_cleanup_dist_sq = isDefined(level.var_18d20774) ? level.var_18d20774 : 189225;
      }
    } else {
      n_cleanup_dist_sq = isDefined(level.registertheater_fxanim_kill_trigger_centerterminatetraverse) ? level.registertheater_fxanim_kill_trigger_centerterminatetraverse : 250000;
    }

    if(n_dist_sq_min >= n_cleanup_dist_sq || isDefined(level.var_751675ab) && isDefined(self) && self[[level.var_751675ab]]()) {
      self thread function_96f7787d();
    }
  }
}

function private function_96f7787d() {
  self.var_61c270 = 1;
  self delete_zombie_noone_looking();

  if(isDefined(self)) {
    self.var_61c270 = undefined;
  }
}

function private delete_zombie_noone_looking() {
  if(is_true(self.in_the_ground)) {
    return;
  }

  if(!self.allowdeath) {
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

  self cleanup_zombie();
}

function function_cdf5a512(str_archetype, var_7e1eca2) {
  if(!isDefined(level.var_55a99841)) {
    level.var_55a99841 = [];
  } else if(!isarray(level.var_55a99841)) {
    level.var_55a99841 = array(level.var_55a99841);
  }

  level.var_55a99841[str_archetype] = var_7e1eca2;
}

function private override_cleanup() {
  if(!isDefined(level.var_55a99841)) {
    return 0;
  }

  if(isDefined(self.archetype) && isDefined(level.var_55a99841[self.archetype])) {
    var_914aeacb = self[[level.var_55a99841[self.archetype]]]();
    return is_true(var_914aeacb);
  }

  return 0;
}

function function_39553a7c(str_archetype, func) {
  if(!isDefined(level.var_f51ae00f)) {
    level.var_f51ae00f = [];
  }

  if(!isDefined(level.var_f51ae00f[str_archetype])) {
    level.var_f51ae00f[str_archetype] = [];
  } else if(!isarray(level.var_f51ae00f[str_archetype])) {
    level.var_f51ae00f[str_archetype] = array(level.var_f51ae00f[str_archetype]);
  }

  level.var_f51ae00f[str_archetype][level.var_f51ae00f[str_archetype].size] = func;
}

function private function_8327a85d(var_3a145c54) {
  if(isDefined(level.var_f51ae00f) && isDefined(level.var_f51ae00f[self.archetype])) {
    foreach(func in level.var_f51ae00f[self.archetype]) {
      self[[func]](var_3a145c54);
    }
  }
}

function cleanup_zombie(var_a75dcb5b = 0) {
  if(override_cleanup()) {
    return;
  }

  if(!isalive(self)) {
    println("<dev string:x38>");
    return;
  }

  self function_23621259();
  self zombie_utility::reset_attack_spot();
  self.var_c39323b5 = 1;
  self.var_e700d5e2 = 1;
  self.allowdeath = 1;
  self.var_98f1f37c = 1;
  self kill(undefined, undefined, undefined, undefined, undefined, 1);
  waitframe(1);

  if(isDefined(self) && !var_a75dcb5b) {
    if(is_true(level.var_bcb99e53)) {
      debugstar(self.origin, 1000, (1, 1, 1));
    }

    self delete();
  }
}

function player_can_see_me(player) {
  return !player function_80d68e4d(self, 0.766, 1);
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

function get_escape_position() {
  self endon(#"death");

  if(isDefined(self.zone_name)) {
    str_zone = self.zone_name;
  } else {
    str_zone = self zm_utility::get_current_zone();
  }

  if(isDefined(str_zone)) {
    a_zones = get_adjacencies_to_zone(str_zone);
    a_wait_locations = get_wait_locations_in_zones(a_zones);
    s_farthest = self get_farthest_wait_location(a_wait_locations);
  }

  return s_farthest;
}

function get_adjacencies_to_zone(str_zone) {
  a_adjacencies = [];

  if(isDefined(str_zone) && isDefined(level.zones[str_zone])) {
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
  }

  return a_adjacencies;
}

function private get_wait_locations_in_zones(a_zones) {
  a_wait_locations = [];

  foreach(zone in a_zones) {
    if(isDefined(level.zones[zone].a_loc_types) && isDefined(level.zones[zone].a_loc_types[#"wait_location"])) {
      a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types[#"wait_location"], 0, 0);
      continue;
    }

    str_zone = function_9e72a96(zone);
    println("<dev string:x88>" + str_zone + "<dev string:x9c>");
    iprintln("<dev string:x88>" + str_zone + "<dev string:x9c>");
  }

  return a_wait_locations;
}

function private get_farthest_wait_location(a_wait_locations) {
  if(!isDefined(a_wait_locations) || a_wait_locations.size == 0) {
    return undefined;
  }

  var_16db4a88 = arraysortclosest(a_wait_locations, self.origin);
  return var_16db4a88[var_16db4a88.size - 1];
}

function private get_wait_locations_in_zone(zone) {
  if(isDefined(level.zones[zone].a_loc_types[#"wait_location"])) {
    a_wait_locations = [];
    a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types[#"wait_location"], 0, 0);
    return a_wait_locations;
  }

  return undefined;
}

function get_escape_position_in_current_zone() {
  self endon(#"death");
  str_zone = self.zone_name;

  if(!isDefined(str_zone)) {
    str_zone = self.zone_name;
  }

  if(isDefined(str_zone)) {
    a_wait_locations = get_wait_locations_in_zone(str_zone);

    if(isDefined(a_wait_locations)) {
      s_farthest = self get_farthest_wait_location(a_wait_locations);
    }
  }

  return s_farthest;
}

function no_target_override(ai_zombie) {
  if(isDefined(self.var_6fd4da3a)) {
    position = [[self.var_6fd4da3a]]();

    if(isDefined(position)) {
      return position;
    }
  }

  if(!isDefined(ai_zombie.var_cc1c538e)) {
    ai_zombie.var_cc1c538e = ai_zombie get_escape_position();
    ai_zombie val::set(#"zm_cleanup_mgr", "ignoreall", 1);
  }

  if(isDefined(ai_zombie.var_cc1c538e)) {
    self setgoal(ai_zombie.var_cc1c538e.origin, 0, 32);
    return;
  }

  self setgoal(ai_zombie.origin, 0, 32);
}

function function_d22435d9(ai_zombie) {
  ai_zombie.var_cc1c538e = undefined;
  ai_zombie val::reset(#"zm_cleanup_mgr", "ignoreall");
}

function function_c6ad3003(b_timeout = 0) {
  a_ai_enemies = getaiteamarray(#"axis");

  foreach(ai_enemy in a_ai_enemies) {
    if(!isalive(ai_enemy)) {
      continue;
    } else if(b_timeout && is_true(ai_enemy.var_126d7bef)) {
      continue;
    } else if(!b_timeout && is_true(ai_enemy.b_ignore_cleanup)) {
      continue;
    }

    if(!ai_enemy.allowdeath) {
      continue;
    }

    ai_enemy function_23621259(1);
    ai_enemy zombie_utility::reset_attack_spot();
    ai_enemy.var_c39323b5 = 1;
    ai_enemy kill(undefined, undefined, undefined, undefined, undefined, 1);
    waitframe(1);
  }
}

function function_23621259(var_3a145c54 = 0) {
  if(isalive(self) && !is_true(self.exclude_cleanup_adding_to_total)) {
    if(var_3a145c54) {
      level.var_2125984b++;
    } else {
      level.zombie_total++;
      level.zombie_respawns++;
      level.zombie_total_subtract++;
    }

    if(!isDefined(self.maxhealth)) {
      self.maxhealth = self.health;
    }

    if(self.health < self.maxhealth || is_true(self.var_bd2c55ef)) {
      var_1a8c05ae = {
        #n_health: self.health, #var_e0d660f6: self.var_e0d660f6
      };

      if(!isDefined(level.var_fc73bad4[self.archetype])) {
        level.var_fc73bad4[self.archetype] = [];
      } else if(!isarray(level.var_fc73bad4[self.archetype])) {
        level.var_fc73bad4[self.archetype] = array(level.var_fc73bad4[self.archetype]);
      }

      level.var_fc73bad4[self.archetype][level.var_fc73bad4[self.archetype].size] = var_1a8c05ae;
    }

    self function_8327a85d(var_3a145c54);
  }
}

function function_aa5726f2() {
  if(isDefined(level.var_fc73bad4[self.archetype]) && level.var_fc73bad4[self.archetype].size > 0) {
    var_1a8c05ae = level.var_fc73bad4[self.archetype][0];
    self.health = var_1a8c05ae.n_health;

    if(isDefined(var_1a8c05ae.var_e0d660f6)) {
      foreach(var_40783d81 in var_1a8c05ae.var_e0d660f6) {
        self[[var_40783d81]]();
      }
    }

    arrayremovevalue(level.var_fc73bad4[self.archetype], var_1a8c05ae);
  }
}