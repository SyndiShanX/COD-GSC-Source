/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_cleanup.gsc
*************************************************/

init() {
  level.zombie_cleanup = spawnStruct();
  level.zombie_cleanup.frame_processed = 0;
  level.zombie_cleanup.round_rollover = 0;
  level.zombie_cleanup.respawn_info = [];
  level.zombie_cleanup.respawn_count = 0;
  setdvarifuninitialized("#x3b65f65b5ba5e4de1", 0);
  register_zombie_cleanup_func_override("screamer", ::screamer_cleanup_teleport);
  register_zombie_cleanup_func_override("juggernaut", ::juggernaut_cleanup_teleport);
  register_zombie_cleanup_func_override("trickster", ::trickster_cleanup_teleport);
  level thread cleanup_main();
}

screamer_cleanup_teleport() {
  if(istrue(level.force_cleanup_all_zombies) || istrue(self.force_cleanup_zombie)) {
    return 0;
  }

  return 1;
}

juggernaut_cleanup_teleport() {
  if(istrue(level.force_cleanup_all_zombies)) {
    return 0;
  }

  self endon("death");
  var_0 = undefined;

  for(;;) {
    var_1 = _func_0204(scripts\cp\utility::_id_6C5C(), self.origin);

    foreach(var_3 in var_1) {
      if(scripts\cp\utility::_id_8677(var_3, 1)) {
        var_0 = var_3;
        break;
      }
    }

    if(isDefined(var_0)) {
      break;
    }

    waitframe();
  }

  var_5 = scripts\cp\zone_manager::get_active_zones();
  var_6 = scripts\cp\spawners\zone_spawner::get_spawn_locs_in_zones(var_5, "enemy_zombie_juggernaut_cp");

  if(var_6.size > 0) {
    var_7 = scripts\engine\utility::_id_6369(var_0.origin, var_6, undefined, undefined, undefined, 500);

    if(var_7.size > 0) {
      var_8 = var_7[var_7.size - 1];
      teleport_zombie_for_cleanup(var_8);
    }
  }

  return 1;
}

trickster_cleanup_teleport() {
  if(istrue(level.force_cleanup_all_zombies)) {
    return 0;
  }

  return 1;
}

teleport_zombie_for_cleanup(var_0) {
  if(isalive(self)) {
    self endon("death");
    self hide(1);

    while(istrue(self._id_86ED)) {
      waitframe();
    }

    self dontinterpolate();
    self _meth_80F9(var_0.origin, scripts\cp\utility::_id_459B(var_0.angles, self.angles), 10000);
    self show();
    self._id_E224 = gettime();
    thread scripts\cp\zone_manager::monitor_enter_playable_area();
  }
}

delay_cleanup_until(var_0) {
  level.zombie_cleanup.restart_time = var_0;

  if(!can_start_cleanup()) {
    level notify("delay_zombie_cleanup");
  }
}

can_start_cleanup() {
  if(isDefined(level.zombie_cleanup.restart_time)) {
    return gettime() >= level.zombie_cleanup.restart_time;
  } else {
    return 1;
  }
}

cleanup_main() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C24("introscreen_over");

  for(;;) {
    wait 3;

    if(can_start_cleanup()) {
      level.zombie_cleanup.restart_time = undefined;
    } else {
      continue;
    }

    var_0 = scripts\cp\utility::_id_A2B8(gettime() - level.round_start_time);

    if(level._id_11049 <= 5 && var_0 < 30) {
      continue;
    } else if(level._id_11049 > 5 && var_0 < 20) {
      continue;
    }
    var_1 = scripts\cp\zombies\zm_round_logic::get_round_enemies();

    if(level.zombie_spawn_count <= 0 && var_1.size < 3) {
      level process_all_zombies_cleanup(2250000);
      continue;
    }

    level process_all_zombies_cleanup();
  }
}

process_all_zombies_cleanup(var_0) {
  level endon("delay_zombie_cleanup");
  var_1 = _func_0070(level._id_11056);

  foreach(var_3 in var_1) {
    if(level.zombie_cleanup.frame_processed >= 1) {
      level.zombie_cleanup.frame_processed = 0;
      waitframe();
    }

    var_3 do_cleanup_check(var_0);
  }
}

do_cleanup_check(var_0) {
  if(!isalive(self)) {
    return;
  }
  if(istrue(self.b_ignore_cleanup)) {
    return;
  }
  if(isDefined(self.ignore_cleanup_func)) {
    if(istrue(self[[self.ignore_cleanup_func]]())) {
      return;
    }
  }

  var_1 = gettime() - self._id_E224;

  if(var_1 < 5000) {
    return;
  }
  if(istrue(self._in_delete_zombie_noone_looking)) {
    return;
  }
  if(isDefined(self._id_3B1C) && !self._id_3B1C) {
    if(var_1 < 45000) {
      return;
    }
  }

  var_2 = scripts\cp\zone_manager::_id_642F();

  if(!isDefined(var_2)) {
    self.force_cleanup_zombie = 1;
    cleanup_zombie(1);
    return;
  }

  var_3 = isDefined(var_2) && istrue(var_2.is_active);

  if(istrue(level.b_cleanup_zombies_outside_player_zones) || istrue(self.b_cleanup_zombies_outside_player_zones)) {
    if(isDefined(var_2) && _func_0107(var_2._id_A924) && var_2._id_A924.size == 0) {
      var_3 = 0;
    }
  }

  level.zombie_cleanup.frame_processed++;

  if(!var_3) {
    var_4 = undefined;
    var_5 = undefined;

    foreach(var_7 in scripts\cp\utility::_id_6C5C()) {
      if(!scripts\cp\utility::_id_8677(var_7, 0, 1)) {
        continue;
      }
      var_8 = distancesquared(self.origin, var_7.origin);

      if(!isDefined(var_4) || var_8 < var_4) {
        var_4 = var_8;
        var_5 = var_7;
      }
    }

    if(isDefined(var_0)) {
      var_10 = var_0;
    } else if(isDefined(var_5) && player_ahead_of_me(var_5)) {
      if(self._id_91A3._id_02D6 == "walk") {
        var_10 = scripts\cp\utility::_id_459B(level.n_cleanup_dist_sq_min_override, 250000);
      } else {
        var_10 = scripts\cp\utility::_id_459B(level.n_cleanup_dist_sq_min_aggressive_override, 189225);
      }
    } else
      var_10 = scripts\cp\utility::_id_459B(level.n_cleanup_dist_sq_min_override, 250000);

    if(isDefined(var_4) && var_4 >= var_10) {
      thread delete_zombie_noone_looking_wrapper();
    }
  }
}

delete_zombie_noone_looking_wrapper() {
  self._in_delete_zombie_noone_looking = 1;
  delete_zombie_noone_looking();

  if(isDefined(self)) {
    self._in_delete_zombie_noone_looking = undefined;
  }
}

player_can_see(var_0) {
  if(isagent(var_0) && var_0 tagexists("j_spine4")) {
    var_1 = var_0 gettagorigin("j_spine4");
  } else {
    var_1 = var_0.origin;
  }

  if(!scripts\engine\math::_id_B9AB(var_1, undefined, 1)) {
    return 0;
  }

  var_2 = self getEye();
  var_3 = [self, var_0];

  if(getdvarint("#x3b65f65b5ba5e4de1", 0)) {
    return scripts\engine\trace::ray_trace_passed(var_2, var_1, var_3);
  } else {
    var_4 = scripts\engine\trace::ray_trace_passed(var_2, var_1, var_3);

    if(!var_4) {
      var_5 = vectornormalize(var_1 - var_2);
      var_6 = _func_025B(var_5, (0, 0, 1));
      var_7 = var_1 - 32 * var_6;
      var_4 = scripts\engine\trace::ray_trace_passed(var_2, var_7, var_3);

      if(!var_4) {
        var_8 = var_1 + 32 * var_6;
        var_4 = scripts\engine\trace::ray_trace_passed(var_2, var_8, var_3);
      }
    }

    return var_4;
  }
}

delete_zombie_noone_looking() {
  if(istrue(self._id_7D7D)) {
    return;
  }
  if(istrue(self._id_992D)) {
    return;
  }
  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "spectator") {
      continue;
    }
    if(var_1 player_can_see(self)) {
      return;
    }
  }

  cleanup_zombie();
}

register_zombie_cleanup_func_override(var_0, var_1) {
  if(!_func_0107(level.zombie_cleanup.cleanup_func_overrides)) {
    level.zombie_cleanup.cleanup_func_overrides = [];
  }

  level.zombie_cleanup.cleanup_func_overrides[var_0] = var_1;
}

override_cleanup() {
  if(!isDefined(level.zombie_cleanup.cleanup_func_overrides)) {
    return 0;
  }

  if(isDefined(self._id_110B0) && isDefined(level.zombie_cleanup.cleanup_func_overrides[self._id_110B0])) {
    var_0 = self[[level.zombie_cleanup.cleanup_func_overrides[self._id_110B0]]]();
    return istrue(var_0);
  }

  return 0;
}

add_zombie_custom_cleanup_logic(var_0, var_1) {
  level.zombie_cleanup.custom_cleanup_funcs[var_0] = ::scripts\engine\utility::_id_1B8D(level.zombie_cleanup.custom_cleanup_funcs[var_0], var_1);
}

custom_cleanup_logic(var_0) {
  if(isDefined(level.zombie_cleanup.custom_cleanup_funcs) && isDefined(level.zombie_cleanup.custom_cleanup_funcs[self._id_110B0])) {
    foreach(var_2 in level.zombie_cleanup.custom_cleanup_funcs[self._id_110B0]) {
      self[[var_2]](var_0);
    }
  }
}

cleanup_zombie(var_0) {
  if(override_cleanup()) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  add_ai_back_to_round();
  self._id_2027 = 1;

  if(!istrue(var_0)) {
    self._id_A546 = 1;
  }

  self._id_4A75 = 1;

  if(istrue(self._id_992D)) {
    _id_06C5::_id_E8B9();
  }

  self _meth_81FA();
}

player_ahead_of_me(var_0) {
  var_1 = var_0 getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 _meth_8169() - self.origin;

  if(vectordot(var_2, var_3) < 0) {
    return 0;
  }

  return 1;
}

cleanup_zombies_into_next_round(var_0) {
  level endon("game_ended");
  var_0 = scripts\cp\utility::_id_459B(var_0, 0);
  var_1 = _func_0070(level._id_11056);

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    } else if(var_0 && istrue(var_3.ignore_round_timeout_cleanup)) {
      continue;
    } else if(!var_0 && istrue(var_3.b_ignore_cleanup)) {
      continue;
    }
    if(istrue(var_3._id_992D)) {
      continue;
    }
    var_3 add_ai_back_to_round(1);
    var_3._id_2027 = 1;
    var_3 _meth_81FA();
    waitframe();
  }
}

add_ai_back_to_round(var_0) {
  var_0 = scripts\cp\utility::_id_459B(var_0, 0);

  if(isalive(self) && !istrue(self.exclude_cleanup_adding_to_total)) {
    if(var_0) {
      level.zombie_cleanup.round_rollover++;
    } else {
      level.zombie_spawn_count++;
      level.zombie_cleanup.respawn_count++;
    }

    if(!isDefined(self.maxhealth)) {
      self.maxhealth = self.health;
    }

    if(self.health < self.maxhealth || istrue(self.b_save_health_on_cleanup)) {
      var_1 = spawnStruct();
      var_1.n_health = self.health;
      var_1.on_respawn_func = self.on_respawn_func;
      level.zombie_cleanup.respawn_info[self._id_110B0] = ::scripts\engine\utility::_id_1B8D(level.zombie_cleanup.respawn_info[self._id_110B0], var_1);
    }

    custom_cleanup_logic(var_0);
  }
}

check_zombie_cleanup_respawn() {
  if(isDefined(level.zombie_cleanup.respawn_info[self._id_110B0]) && level.zombie_cleanup.respawn_info[self._id_110B0].size > 0) {
    var_0 = level.zombie_cleanup.respawn_info[self._id_110B0][0];
    self.health = var_0.n_health;

    if(_func_0107(var_0.on_respawn_func)) {
      foreach(var_2 in var_0.on_respawn_func) {
        self[[var_2]]();
      }
    } else if(_func_03AC(var_0.on_respawn_func))
      self[[var_0.on_respawn_func]]();

    level.zombie_cleanup.respawn_info[self._id_110B0] = ::scripts\engine\utility::array_remove(level.zombie_cleanup.respawn_info[self._id_110B0], var_0);
  }
}