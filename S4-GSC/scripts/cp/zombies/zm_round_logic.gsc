/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_round_logic.gsc
*************************************************/

init() {
  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    return;
  }
  level._id_11049 = 1;
  level.covenant_upgrade_rate_scale = 0.34;
  level thread init_round_spawning();
  level thread init_rounds();
  level thread scripts\cp\zombies\zm_cleanup::init();
}

register_ai_spawned(var_0, var_1, var_2, var_3, var_4) {
  self.a_ai_spawned[var_0] = [];
  self.a_n_attempts[var_0] = 0;
  self.a_n_chance_base[var_0] = var_1;
  self.a_n_chance_increment[var_0] = var_2;
  self.a_n_round_threshold[var_0] = var_3;
  self.a_n_cooldown[var_0] = var_4;
  self.a_b_cooldown[var_0] = 0;
}

register_round_spawn_instance(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.should_start_round = var_0;
  var_6._id_6315 = var_1;
  var_6._id_AA61 = var_2;
  var_6.on_round_complete = var_3;
  var_6.round_spawn_delay = var_4;
  var_6.get_total_spawn_count = var_5;
  var_6.a_ai_spawned = [];
  var_6.a_n_cooldown = [];
  var_6.a_b_cooldown = [];
  var_6 init_player_respawn_locations();

  if(!isDefined(level.a_round_spawn_instances)) {
    level.a_round_spawn_instance = [];
  }

  level.a_round_spawn_instances[level.a_round_spawn_instances.size] = var_6;
  return var_6;
}

unregister_round_spawn_instance(var_0) {
  if(!isDefined(level.a_round_spawn_instances)) {
    return;
  }
  level.a_round_spawn_instances = scripts\engine\utility::array_remove(level.a_round_spawn_instances, var_0);
}

on_round_last_ai_killed(var_0) {
  level.a_round_last_ai_killed_callbacks = scripts\cp\utility::_id_1B8C(level.a_round_last_ai_killed_callbacks, var_0);
}

remove_on_round_last_ai_killed(var_0) {
  if(!isDefined(level.a_round_last_ai_killed_callbacks)) {
    return;
  }
  level.a_round_last_ai_killed_callbacks = scripts\engine\utility::array_remove(level.a_round_last_ai_killed_callbacks, var_0);
}

init_round_spawning() {
  level.n_round_spawning_throttle = 0;
  level.a_s_round_templates = [];
  level.a_s_round_templates[0] = spawnStruct();
  level.a_s_round_templates[0].a_n_percentages = [0.75, 0.25];
  level.a_s_round_templates[0].a_n_quarters = [2, 2];
  level.a_s_round_templates[1] = spawnStruct();
  level.a_s_round_templates[1].a_n_percentages = [0.25, 0.25, 0.25, 0.25];
  level.a_s_round_templates[1].a_n_quarters = [1, 1, 1, 1];
  level register_ai_type("enemy_zombie_screamer_cp", ::get_max_screamer_spawns, 25);
  level register_ai_type("enemy_zombie_juggernaut_cp", ::get_max_juggernaut_spawns, 50, [2, 4], [2, 3]);
  level register_ai_type("enemy_zombie_trickster_cp", ::get_max_trickster_spawns, 100, [3, 4], [3, 4]);
  level schedule_ai_intro_round("enemy_zombie_screamer_cp", 5);
  var_0 = scripts\cp\utility::_id_459B(level.round_threshold_juggernaut_override, 20);
  var_1 = scripts\cp\utility::_id_459B(level.round_threshold_trickster_override, 15);
  level schedule_ai_intro_round("enemy_zombie_juggernaut_cp", var_0);
  level schedule_ai_intro_round("enemy_zombie_trickster_cp", var_1);
  level thread manage_ai_type_cooldown();
}

get_max_screamer_spawns(var_0, var_1) {
  var_2 = int(floor(var_1 / var_0.point_value));

  if(level._id_11049 < 20) {
    var_3 = 0.02;
  } else if(level._id_11049 < 30) {
    var_3 = 0.03;
  } else {
    var_3 = 0.04;
  }

  var_4 = min(var_2, int(_func_0037(level.zombie_spawn_count * var_3)));
  return var_4;
}

get_max_juggernaut_spawns(var_0, var_1) {
  if(isDefined(var_0.n_next_round) && level._id_11049 < var_0.n_next_round) {
    return 0;
  }

  var_2 = get_number_of_players();

  if(var_2 == 1) {
    switch (var_0.n_spawned_rounds) {
      case 2:
      case 1:
      case 0:
        var_3 = 1;
        var_4 = 1;
        break;
      default:
        var_3 = 1;
        var_4 = 2;
    }
  } else {
    switch (var_0.n_spawned_rounds) {
      case 1:
      case 0:
        var_3 = 1;
        var_4 = 1;
        break;
      case 3:
      case 2:
        var_3 = 2;
        var_4 = 2;
        break;
      default:
        var_3 = 3;
        var_4 = 3;
    }
  }

  return randomintrange(var_3, var_4 + 1);
}

get_max_trickster_spawns(var_0, var_1) {
  if(isDefined(var_0.n_next_round) && level._id_11049 < var_0.n_next_round) {
    return 0;
  }

  var_2 = _id_06FE::_id_6322();

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4._id_110B0, "trickster")) {
      if(!isDefined(var_0.n_next_round)) {
        var_0.n_next_round = level._id_11049 + 9999;
      }

      return 0;
    }
  }

  var_0.n_next_round = level._id_11049 + 9999;
  return 1;
}

init_rounds() {
  level endon("game_ended");
  level.a_round_spawn_instances = [];
  level.rbz_normal = spawnStruct();
  level.rbz_normal set_use_zone_spawns(1);
  level.rbz_normal init_player_respawn_locations();
  level.rbz_normal register_ai_spawned("enemy_zombie_trickster_cp", 1, 1, 15, [80, 60, 40, 20]);
  level.rbz_normal register_ai_spawned("enemy_zombie_juggernaut_cp", 1, 2, 20, [60, 45, 30, 15]);
  level.rbz_normal register_ai_spawned("enemy_zombie_screamer_cp", 5, 2, 5, [10, 8, 6, 4]);
  level.rbz = level.rbz_normal;
  _id_06CB::on_ai_spawned(::on_ai_spawned);
  _id_06CB::_id_AA4A(::_id_AA4A);
  wait 5;
  scripts\cp\spawners\agent_spawner::_id_5222("zone");
  level thread start_zombie_spawning();
  level thread rounds_think(level.rbz);
}

init_player_respawn_locations() {
  self.respawn_locations = [];
  var_0 = scripts\engine\utility::getStructArray("player_respawn_location", "targetname");

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      var_3 = var_2.target;
      self.respawn_locations[var_3] = ::scripts\engine\utility::_id_1B8D(self.respawn_locations[var_3], var_2);
    }

    self.set_respawn_location = ::set_zone_respawn_location;
  } else
    self.set_respawn_location = ::set_default_respawn_location;
}

get_valid_respawn_locations() {
  var_0 = [];

  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    if(var_2 scripts\cp\utility::_id_8708()) {
      var_3 = var_2 scripts\cp\zone_manager::_id_642F();

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3._id_A924.size > 1) {
        var_0 = [var_3.script_zone_name];
        break;
      } else
        var_0[var_0.size] = var_3.script_zone_name;
    }
  }

  if(var_0.size == 0 && isDefined(level.default_respawn_zone)) {
    var_0[0] = level.default_respawn_zone;
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    var_8 = self.respawn_locations[var_7];
    var_9 = scripts\cp\zone_manager::get_zone_occupants(var_7);

    foreach(var_11 in var_8) {
      var_12 = 0;

      foreach(var_14 in var_9) {
        if(distancesquared(var_11.origin, var_14.origin) < 1024) {
          var_12 = 1;
          break;
        }

        if(_func_01A5(var_11.origin)) {
          var_12 = 1;
          break;
        }
      }

      if(!var_12) {
        var_5 = scripts\engine\utility::array_add(var_5, var_11);
      }
    }
  }

  var_5 = scripts\engine\utility::array_randomize(var_5);
  return var_5;
}

set_zone_respawn_location(var_0) {
  var_1 = var_0[0];
  self._id_5EC7 = var_1.origin;
  self._id_5EC2 = var_1.angles;

  if(var_0.size > 1) {
    return scripts\engine\utility::array_remove(var_0, var_1);
  } else {
    return var_0;
  }
}

set_default_respawn_location(var_0) {
  var_1 = scripts\cp\gametypes\zombie::_id_1102A(self);
  self._id_5EC7 = var_1.origin;
  self._id_5EC2 = var_1.angles;
  return var_0;
}

start_zombie_spawning() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  wait 5;
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
}

set_use_zone_spawns(var_0) {
  self.use_zone_spawns = var_0;
}

give_round_complete_rewards() {
  if(level._id_11049 % 6 == 0 && level._id_11049 >= 6) {
    foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
      var_1 milestone_scrap_reward_rbz(level._id_11049);
    }
  }

  var_3 = scripts\cp\utility::_id_6C5C();

  foreach(var_1 in var_3) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(level._id_11049 % 3 == 0) {
      var_1 scripts\cp\cp_sacrificial_heart::giveplayersacrificialheart();
      var_1 thread scripts\cp\cp_hud_message::showsplash("cp_rbz_heart_collected", 1);
      var_1 notify("give_player_sacrificial_heart");
    }

    var_1 _id_0717::on_objective_complete();
  }
}

milestone_scrap_reward_rbz(var_0) {
  var_1 = get_scrap_modifier(var_0);
  var_2 = int(var_1 * 100);
  var_2 = clamp(var_2, 0, 500);
  thread scripts\cp\cp_hud_message::showsplash("cp_rbz_scrap_milestone_reward", 3);
  _id_075A::_id_6FCE(var_2, "Objective");
}

get_scrap_modifier(var_0) {
  switch (var_0) {
    case 6:
      return 1;
    case 12:
      return 2;
    case 18:
      return 3;
    case 24:
      return 4;
    default:
      return 5;
  }
}

rounds_think(var_0) {
  level endon("game_ended");
  level endon("stop_round_spawn");

  for(;;) {
    var_0 = level.rbz_normal;
    level.rbz = level.rbz_normal;

    foreach(var_2 in level.a_round_spawn_instances) {
      if([[var_2.should_start_round]](var_2)) {
        var_0 = var_2;
        level.rbz = var_2;
        break;
      }
    }

    var_0 scripts\engine\utility::_id_5470("all_killed");
    var_0 scripts\engine\utility::_id_5470("round_timeout");
    level scripts\engine\utility::_id_5C04("zombie_spawn_count_set");
    level.round_start_time = gettime();

    if(!istrue(level.b_disable_round_timeout)) {
      var_0 childthread watch_round_timeout();
    }

    level notify("round_start");

    if(isDefined(var_0._id_AA61)) {
      var_0[[var_0._id_AA61]]();
    } else if(level._id_11049 != 1) {
      if(isDefined(level.round_start_music_states)) {
        var_4 = scripts\engine\utility::random(level.round_start_music_states);
        _func_01E3(var_4);
      }
    }

    level childthread spawns_think(var_0);
    var_0 scripts\engine\utility::_id_5478("all_killed", "round_timeout");
    var_5 = respawn_players(var_0);

    if(var_5) {
      waitframe();
    }

    level._id_11049++;
    level thread setjiprulesbyround();
    level thread _id_0987::update_round_tracker_hud(1);
    _id_072A::setperroundxp("forever_blitz", level._id_11049);
    level thread play_round_end_vo(var_0);
    var_0 notify("round_complete");
    level notify("round_complete");
    level thread _id_070F::createroundcompeletedevent();

    if(isDefined(var_0.on_round_complete)) {
      var_0[[var_0.on_round_complete]]();
    } else if(isDefined(level.round_end_music_states)) {
      var_6 = scripts\engine\utility::random(level.round_end_music_states);
      _func_01E3(var_6);
    }

    level give_round_complete_rewards();

    if(isDefined(level.override_zombie_round_delay)) {
      var_7 = [[level.override_zombie_round_delay]]();
      continue;
    }

    wait 15;
  }
}

setjiprulesbyround() {
  if(level._id_11049 > 9) {
    _func_01E6(1, 1);
  }
}

respawn_players(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_2 = [];

    foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
      if(scripts\engine\utility::is_equal(var_4.sessionstate, "spectator") || istrue(var_4.inlaststand)) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
      }
    }

    if(var_2.size > 0) {
      var_6 = var_0 get_valid_respawn_locations();

      foreach(var_4 in var_2) {
        var_6 = var_4[[var_0.set_respawn_location]](var_6);
        var_1 = 1;
        var_4 notify("auto_respawn");
      }
    }
  }

  return var_1;
}

on_forced_respawn(var_0) {
  if(!isDefined(var_0.on_initializing)) {
    var_0._id_E6BF = var_0 _id_074E::_id_666A();
    var_0 scripts\cp\cp_sacrificial_heart::initplayersacrificialheart();
    var_1 = var_0 _id_075A::_id_6C5D();

    if(level._id_11049 >= 10) {
      var_1 = max(var_1, 250);
    }

    var_0.starting_salvage_after_revived_from_spectator = var_1;
    _id_0707::armorinitonrevival(var_0);
  }

  var_2 = undefined;

  if(isDefined(self._id_3D58) && isDefined(level.no_restoration_weapon_func)) {
    var_2 = self[[level.no_restoration_weapon_func]]();
  }

  if(isDefined(self._id_3D58) && isDefined(self.respawnclassindex) && self._id_45A9 != self.respawnclassindex) {
    self.switch_loadout = 1;

    if(!istrue(var_2)) {
      self._id_3D58 = scripts\engine\utility::array_remove_index(self._id_3D58, 0);
    }
  } else
    self.last_super = self._id_EB09;

  var_0 scripts\cp\zombies\perks\zm_perks::remove_all_perks();
  scripts\cp\gametypes\zombie::_id_ED83(var_0);
  _id_0994::_id_F70B(var_0);
  var_0 thread watch_player_spawn();
}

watch_player_spawn() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(isDefined(self._id_3D58)) {
    if(istrue(self.switch_loadout)) {
      scripts\cp\utility::_id_C706(self getweaponslistall(), 1, 0);
      self.switch_loadout = undefined;
    } else {
      scripts\cp\utility::_id_C706(undefined, 1, 0);

      if(isDefined(self.last_super)) {
        _id_0766::givesuper(self.last_super._id_E76B._id_C189, 0, 0);
        self.last_super = undefined;
      }
    }
  }

  self._id_5EC7 = undefined;
  self._id_5EC2 = undefined;
  self.s_round_respawn = undefined;
}

play_round_end_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 notify("playing_round_end_vo");
  var_0 endon("playing_round_end_vo");
  wait 15;
  level play_round_increase_vo(var_0);
}

play_round_increase_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
}

get_round() {
  var_0 = 1;

  if(isDefined(level._id_11049)) {
    var_0 = level._id_11049;
  }

  return var_0;
}

get_round_enemies() {
  var_0 = [];
  var_1 = _func_0070(level._id_11056);

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }
    if(istrue(var_3.ignore_enemy_count)) {
      continue;
    }
    var_0 = scripts\engine\utility::array_add(var_0, var_3);
  }

  return var_0;
}

get_total_spawn_count() {
  var_0 = get_number_of_players();
  var_1 = 24;

  if(var_0 == 1) {
    var_2 = 29;
    var_3 = 0.84;
    var_4 = 0.5;
  } else {
    var_2 = 20;
    var_3 = 0.6;
    var_4 = 0.5 + var_0 / 2.0;
  }

  var_5 = get_round();

  if(var_5 < var_2) {
    var_3 = 0.15;
    var_6 = var_5 / 5;

    if(var_6 < 1) {
      var_6 = 1;
    }

    var_6 = var_6 * (var_5 * var_3);
  } else
    var_6 = var_5 * var_3;

  var_1 = var_1 + int(var_4 * 6 * var_6);
  var_7 = [6, 8, 11, 14];
  var_8 = [9, 11, 14, 18];
  var_9 = [13, 15, 20, 25];
  var_10 = [18, 20, 25, 33];
  var_11 = [24, 25, 32, 42];

  switch (var_5) {
    case 1:
      var_1 = var_7[var_0 - 1];
      break;
    case 2:
      var_1 = var_8[var_0 - 1];
      break;
    case 3:
      var_1 = var_9[var_0 - 1];
      break;
    case 4:
      var_1 = var_10[var_0 - 1];
      break;
    case 5:
      var_1 = var_11[var_0 - 1];
      break;
  }

  return var_1;
}

get_spawn_delay() {
  var_0 = get_round();

  if(var_0 > 60) {
    var_0 = 60;
  }

  var_1 = get_number_of_players();
  var_2 = 2;

  switch (var_1) {
    case 2:
      var_2 = var_2 * 0.75;
      break;
    case 3:
      var_2 = var_2 * 0.445;
      break;
    case 4:
      var_2 = var_2 * 0.335;
      break;
  }

  for(var_3 = 1; var_3 < var_0; var_3++) {
    var_2 = var_2 * 0.95;

    if(var_2 <= 0.1) {
      var_2 = 0.1;
      break;
    }
  }

  return var_2;
}

spawns_think(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 scripts\engine\utility::_id_546E("all_killed") || var_0 scripts\engine\utility::_id_546E("round_timeout")) {
    return;
  }
  level endon("game_ended");
  var_0 endon("all_killed");
  var_0 endon("round_timeout");

  if(isDefined(var_0.get_total_spawn_count)) {
    level.zombie_spawn_count = [[var_0.get_total_spawn_count]](var_0);
  } else {
    level.zombie_spawn_count = get_total_spawn_count();
  }

  level.n_zombie_spawns = level.zombie_spawn_count;
  level.n_zombie_rollover = 0;
  var_1 = get_spawn_delay();

  if(isDefined(level.zombie_cleanup)) {
    level.zombie_spawn_count = level.zombie_spawn_count + level.zombie_cleanup.round_rollover;
    level.zombie_cleanup.respawn_count = level.zombie_cleanup.round_rollover;

    if(level.zombie_cleanup.respawn_count == 0) {
      level.zombie_cleanup.respawn_info = [];
    }

    level.n_zombie_rollover = level.zombie_cleanup.round_rollover;
    level.zombie_cleanup.round_rollover = 0;
  }

  level scripts\engine\utility::_id_5C1B("zombie_spawn_count_set");
  var_2 = istrue(var_0.b_is_special_round);

  if(var_2) {
    reset_all_ai_roll_attempts(var_0);
  } else {
    construct_round_spawns();
  }

  for(;;) {
    scripts\engine\utility::_id_5C24("round_spawn_zombies");
    var_3 = scripts\cp\utility::_id_636E();

    if(var_3.size <= 0) {
      wait 0.1;
      continue;
    }

    if(level.zombie_spawn_count <= 0) {
      wait 0.1;
      continue;
    } else {
      if(_func_0072(level._id_11056, "all") < 24) {
        if(istrue(var_0.use_zone_spawns)) {
          level scripts\cp\spawners\agent_spawner::_id_5222("zone");
        } else {
          level scripts\cp\spawners\agent_spawner::_id_5222("procedural");
        }

        if(var_2) {
          var_4 = "enemy_base_zombie_cp";

          if(isDefined(var_0._id_6315)) {
            var_4 = [[var_0._id_6315]](var_0);
          } else {
            var_4 = _id_6315(var_0);
          }
        } else {
          var_5 = get_special_ai_type_to_spawn();

          if(scripts\engine\utility::is_equal(var_5, "enemy_zombie_trickster_cp") && check_has_alive_trickster()) {
            var_4 = "enemy_base_zombie_cp";
          } else if((scripts\engine\utility::is_equal(var_5, "enemy_zombie_juggernaut_cp") || scripts\engine\utility::is_equal(var_5, "enemy_zombie_screamer_cp")) && check_should_override_zombie_type_spawn()) {
            var_4 = "enemy_base_zombie_cp";
          } else {
            var_4 = scripts\cp\utility::_id_459B(var_5, "enemy_base_zombie_cp");
          }
        }

        var_6 = scripts\cp\spawners\agent_spawner::_id_E0AC(var_4);

        if(isDefined(var_6)) {
          if(scripts\engine\utility::is_equal(var_4, "enemy_zombie_trickster_cp")) {
            var_6.is_round_spawned = 1;
          }

          var_6 scripts\cp\zombies\zm_cleanup::check_zombie_cleanup_respawn();
          var_6 thread scripts\cp\zone_manager::monitor_enter_playable_area();

          if(isDefined(level.override_zombie_speed_set)) {
            var_6 thread[[level.override_zombie_speed_set]]();
          }

          if(isDefined(level.zombie_cleanup)) {
            if(level.zombie_cleanup.respawn_count > 0) {
              level.zombie_cleanup.respawn_count--;
            }
          }

          level.zombie_spawn_count--;

          if(var_4 != "enemy_base_zombie_cp" && isDefined(var_0.a_ai_spawned[var_4])) {
            var_0.a_ai_spawned[var_4] = ::scripts\engine\utility::_id_1BCE(var_0.a_ai_spawned[var_4]);
            var_0.a_ai_spawned[var_4] = ::scripts\engine\utility::array_add(var_0.a_ai_spawned[var_4], var_6);

            if(var_2) {
              level thread start_ai_type_cooldown(var_0, var_4);
            }
          }
        }
      }

      if(isDefined(level.zombie_cleanup)) {
        if(level.zombie_cleanup.respawn_count > 0) {
          wait 0.1;
          continue;
        }
      }

      if(isDefined(level.override_zombie_spawn_delay)) {
        var_1 = [[level.override_zombie_spawn_delay]]();
        wait(var_1);
        continue;
      }

      if(isDefined(var_0.round_spawn_delay)) {
        var_0[[var_0.round_spawn_delay]]();
        continue;
      }

      wait(var_1);
    }
  }
}

check_has_alive_trickster() {
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2._id_1210, "actor_enemy_zombie_trickster_cp")) {
      return 1;
    }
  }

  return 0;
}

check_should_override_zombie_type_spawn() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && scripts\engine\utility::is_equal(var_1.activate_gauntlet, "take_no_damage")) {
      return 1;
    }
  }

  return 0;
}

get_number_of_players() {
  return int(clamp(scripts\cp\utility::_id_6C5C().size, 1, 4));
}

get_spawned_ai_of_type(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_ai_spawned) && isDefined(var_0.a_ai_spawned[var_1])) {
    var_0.a_ai_spawned[var_1] = ::scripts\engine\utility::_id_1BCE(var_0.a_ai_spawned[var_1]);
    var_2 = var_0.a_ai_spawned[var_1];
  }

  return var_2;
}

increment_ai_roll_attempts(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_attempts[var_1])) {
    var_0.a_n_attempts[var_1]++;
  }
}

get_ai_roll_attempts(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_attempts[var_1])) {
    var_2 = var_0.a_n_attempts[var_1];
  }

  return var_2;
}

reset_all_ai_roll_attempts(var_0) {
  if(isDefined(var_0) && isDefined(var_0.a_n_attempts)) {
    foreach(var_2 in getarraykeys(var_0.a_n_attempts)) {
      reset_ai_roll_attempts(var_0, var_2);
    }
  }
}

reset_ai_roll_attempts(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_attempts[var_1])) {
    var_0.a_n_attempts[var_1] = 0;
  }
}

should_spawn_ai_type(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    if(var_1 == "enemy_base_zombie_cp") {
      var_3 = 1;
    } else if(!istrue(is_ai_type_on_cooldown(var_0, var_1))) {
      var_4 = var_0.a_n_round_threshold[var_1];

      if(isDefined(var_4) && get_round() >= var_4) {
        var_5 = _id_0991::get_global_max_zombie_count_by_type(var_1);

        if(get_spawned_ai_of_type(var_0, var_1).size < var_5) {
          var_6 = var_0.a_n_chance_base[var_1];
          var_7 = var_0.a_n_chance_increment[var_1];

          if(isDefined(var_6) && isDefined(var_7)) {
            var_8 = var_6 + var_7 * get_ai_roll_attempts(var_0, var_1);

            if(var_2 <= var_8) {
              var_3 = 1;
              reset_ai_roll_attempts(var_0, var_1);
            } else
              increment_ai_roll_attempts(var_0, var_1);
          }
        }
      }
    }
  }

  return var_3;
}

is_ai_type_on_cooldown(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && istrue(var_0.a_b_cooldown[var_1])) {
    var_2 = 1;
  }

  return var_2;
}

get_ai_type_cooldown_duration(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_cooldown[var_1])) {
    var_3 = var_0.a_n_cooldown[var_1];
    var_4 = get_number_of_players();
    var_2 = var_3[var_4 - 1];
  }

  return var_2;
}

start_ai_type_cooldown(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level endon("game_ended");
  var_2 = get_ai_type_cooldown_duration(var_0, var_1);

  if(var_2 > 0) {
    var_0.a_b_cooldown[var_1] = 1;
    wait(var_2);
  }

  var_0.a_b_cooldown[var_1] = 0;
}

_id_6315(var_0) {
  var_1 = "enemy_base_zombie_cp";

  if(isDefined(var_0)) {
    var_2 = randomint(100);

    foreach(var_5, var_4 in var_0.a_ai_spawned) {
      if(should_spawn_ai_type(var_0, var_5, var_2)) {
        var_1 = var_5;
        break;
      }
    }
  }

  return var_1;
}

manage_ai_type_cooldown() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_spawns_constructed");

    foreach(var_2, var_1 in level.a_o_ai_spawn_params_by_type) {
      if(!var_1.m_b_introduced) {
        continue;
      }
      if(scripts\cp\utility::_id_88B7(level.a_str_round_ai_types, var_2)) {
        var_1.n_spawned_rounds++;

        if(var_2 == "enemy_zombie_trickster_cp") {
          continue;
        }
        update_ai_spawn_params_cooldown(var_1);
      }
    }
  }
}

update_ai_spawn_params_cooldown(var_0) {
  var_1 = get_number_of_players();

  if(var_1 == 1) {
    if(_func_0107(var_0.solo_spawn_intervals)) {
      var_2 = var_0.solo_spawn_intervals[0];
      var_3 = var_0.solo_spawn_intervals[1];
      var_0.n_next_round = level._id_11049 + randomintrange(var_2, var_3 + 1);
    } else
      var_0.n_next_round = level._id_11049 + int(var_0.solo_spawn_intervals);
  } else if(_func_0107(var_0.coop_spawn_intervals)) {
    var_2 = var_0.coop_spawn_intervals[0];
    var_3 = var_0.coop_spawn_intervals[1];
    var_0.n_next_round = level._id_11049 + randomintrange(var_2, var_3 + 1);
  } else
    var_0.n_next_round = level._id_11049 + int(var_0.coop_spawn_intervals);
}

update_specific_ai_type_cooldown(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3, var_2 in level.a_o_ai_spawn_params_by_type) {
    if(!var_2.m_b_introduced) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_3, var_0)) {
      update_ai_spawn_params_cooldown(var_2);
      return;
    }
  }
}

distribute_points() {
  var_0 = calculate_point_allocation();

  if(var_0 == 0) {
    return 0;
  }

  var_1 = scripts\engine\utility::array_random(level.a_s_round_templates);
  var_2 = scripts\engine\utility::array_randomize([0, 1, 2, 3]);
  var_3 = var_1.a_n_percentages;
  var_4 = var_1.a_n_quarters;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = [];

    for(var_7 = 0; var_7 < var_4[var_5]; var_7++) {
      var_8 = var_2[0];
      var_2 = scripts\engine\utility::array_remove_index(var_2, 0, 0);
      var_6 = scripts\engine\utility::array_add(var_6, var_8);
    }

    assign_points_to_quarters(int(var_0 * var_3[var_5]), var_6);
  }

  return var_0;
}

calculate_point_allocation() {
  if(level._id_11049 >= 20) {
    return level._id_11049 * level._id_11049 * 2;
  }

  switch (level._id_11049) {
    case 1:
      return 5;
    case 2:
      return 10;
    case 3:
      return 15;
    case 4:
      return 20;
    case 7:
    case 6:
    case 5:
      return 25;
    case 9:
    case 8:
      return 50;
    case 11:
    case 10:
      return 100;
    case 14:
    case 13:
    case 12:
      return 150 + 50 * (level._id_11049 - 12);
    default:
      return 300 + 100 * (level._id_11049 - 15);
  }
}

assign_points_to_quarters(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_2 == var_1.size - 1) {
      level.a_n_quarter_points[var_1[var_2]] = var_0;
      continue;
    }

    if(var_0 < 5) {
      var_3 = var_0;
    } else {
      var_4 = var_0 - 5;

      if(var_4 > 5) {
        var_3 = randomintrange(5, var_4 + 1);
      } else {
        var_3 = randomintrange(var_4, 6);
      }
    }

    level.a_n_quarter_points[var_1[var_2]] = var_3;
    var_0 = var_0 - var_3;
  }
}

compare_point_values(var_0, var_1) {
  return var_0 > var_1;
}

assign_ai_spawns(var_0) {
  var_1 = [];

  foreach(var_3 in level.a_o_ai_spawn_params_by_type) {
    calculate_ai_maximum_for_round(var_3, var_0);
    var_3.m_n_round_assignments = 0;
    var_1[var_3.m_ai_type] = 0;
  }

  var_5 = scripts\engine\utility::_id_1BD6(getarraykeys(level.a_a_o_ai_spawn_params), ::compare_point_values);

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];
    var_8 = 0;

    while(var_7 <= var_0 && !var_8) {
      var_8 = 1;

      foreach(var_3 in level.a_a_o_ai_spawn_params[var_7]) {
        if(var_1[var_3.m_ai_type] == var_3.m_n_max_this_round) {
          continue;
        }
        if(var_7 > var_0) {
          break;
        }

        var_1[var_3.m_ai_type]++;
        level.a_str_round_ai_types = scripts\cp\utility::_id_1B8C(level.a_str_round_ai_types, var_3.m_ai_type);
        var_0 = var_0 - var_7;
        var_8 = 0;
      }

      spawn_calculation_throttle();
    }
  }

  if(isDefined(level.a_func_ai_round_count_adjustments)) {
    foreach(var_12 in level.a_func_ai_round_count_adjustments) {
      var_1 = level[[var_12]](var_1);
    }
  }

  var_14 = 0;

  foreach(var_3 in level.a_o_ai_spawn_params_by_type) {
    var_3.m_n_round_assignments = var_1[var_3.m_ai_type];
    var_14 = var_14 + var_1[var_3.m_ai_type];
  }

  var_17 = 5 + level.n_zombie_rollover;
  var_18 = level.zombie_spawn_count - var_17 - 10;

  if(var_18 < var_14) {
    var_18 = var_14;
    var_17 = 0;
  }

  var_19 = int(floor(var_18 / 4));
  var_20 = [var_19, var_19, var_19, var_19];

  for(var_6 = 0; var_6 < var_18 % 4; var_6++) {
    var_20[var_6]++;
  }

  var_21 = [[], [], [], []];

  foreach(var_7 in var_5) {
    foreach(var_3 in level.a_a_o_ai_spawn_params[var_7]) {
      if(var_3.m_n_round_assignments == 0) {
        continue;
      }
      var_24 = 1;
      var_25 = 1;

      while(var_24) {
        if(var_25) {
          var_26 = scripts\engine\utility::array_randomize(getarraykeys(level.a_n_quarter_points));
          var_25 = 0;

          foreach(var_28 in var_26) {
            if(level.a_n_quarter_points[var_28] >= var_7 && var_21[var_28].size < var_20[var_28]) {
              var_21[var_28] = ::scripts\engine\utility::array_add(var_21[var_28], var_3.m_ai_type);
              level.a_n_quarter_points[var_28] = level.a_n_quarter_points[var_28] - var_7;
              var_3.m_n_round_assignments--;
              var_25 = 1;
            }

            if(var_3.m_n_round_assignments == 0) {
              var_24 = 0;
              break;
            }
          }

          spawn_calculation_throttle();
          continue;
        }

        for(;;) {
          var_28 = get_valid_quarter_with_most_points(var_21, var_20);

          if(!isDefined(var_28)) {
            var_24 = 0;
            break;
          }

          var_21[var_28] = ::scripts\engine\utility::array_add(var_21[var_28], var_3.m_ai_type);
          level.a_n_quarter_points[var_28] = level.a_n_quarter_points[var_28] - var_7;
          var_3.m_n_round_assignments--;
          spawn_calculation_throttle();

          if(var_3.m_n_round_assignments == 0) {
            var_24 = 0;
            break;
          }
        }
      }

      waitframe();
    }
  }

  foreach(var_34, var_33 in var_21) {
    var_21[var_34] = ::scripts\engine\utility::array_randomize(var_33);
  }

  var_35 = var_17;

  for(var_6 = 0; var_6 < 4; var_6++) {
    var_36 = var_35;

    if(isDefined(var_21[var_6]) && var_21[var_6].size) {
      var_37 = int(max(floor(var_20[var_6] / var_21[var_6].size), 1));

      foreach(var_39 in var_21[var_6]) {
        var_36 = var_36 + var_37;
        level.a_str_special_ai_spawns[var_36] = var_39;
        spawn_calculation_throttle();
      }
    }

    var_35 = var_35 + var_20[var_6];
  }
}

calculate_ai_maximum_for_round(var_0, var_1) {
  if(var_0.m_b_introduced) {
    var_2 = [[var_0.max_spawns_func]](var_0, var_1);

    if(var_0.m_a_func_max_spawn_override.size) {
      var_3 = undefined;

      foreach(var_5 in var_0.m_a_func_max_spawn_override) {
        var_6 = [[var_5]](var_2);

        if(!isDefined(var_3) || var_6 < var_3) {
          var_3 = var_6;
        }
      }

      var_2 = var_3;
    }

    var_0.m_n_max_this_round = var_2;
  } else
    var_0.m_n_max_this_round = 0;
}

get_valid_quarter_with_most_points(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  for(var_4 = 0; var_4 < 4; var_4++) {
    if(var_0[var_4].size < var_1[var_4]) {
      if(level.a_n_quarter_points[var_4] > var_3) {
        var_2 = var_4;
        var_3 = level.a_n_quarter_points[var_4];
        continue;
      }

      if(level.a_n_quarter_points[var_4] == var_3 && scripts\engine\utility::cointoss()) {
        var_2 = var_4;
      }
    }
  }

  return var_2;
}

spawn_calculation_throttle() {
  level.n_round_spawning_throttle++;

  if(level.n_round_spawning_throttle > 20) {
    waitframe();
    level.n_round_spawning_throttle = 0;
  }
}

validate_round_scheduling(var_0) {
  level.a_n_round_spawning_schedule = scripts\cp\utility::_id_459B(level.a_n_round_spawning_schedule, []);

  if(scripts\cp\utility::_id_88B7(level.a_n_round_spawning_schedule, var_0)) {
    return;
  }
  level.a_n_round_spawning_schedule = scripts\engine\utility::array_add(level.a_n_round_spawning_schedule, var_0);
}

register_ai_type(var_0, var_1, var_2, var_3, var_4) {
  level.a_a_o_ai_spawn_params = scripts\cp\utility::_id_459B(level.a_a_o_ai_spawn_params, []);
  level.a_o_ai_spawn_params_by_type = scripts\cp\utility::_id_459B(level.a_o_ai_spawn_params_by_type, []);
  var_3 = scripts\cp\utility::_id_459B(var_3, 1);
  var_4 = scripts\cp\utility::_id_459B(var_4, var_3);
  var_5 = spawnStruct();
  var_5.m_ai_type = var_0;
  var_5.max_spawns_func = var_1;
  var_5.point_value = var_2;
  var_5.solo_spawn_intervals = var_3;
  var_5.coop_spawn_intervals = var_4;
  var_5.m_n_max_this_round = 0;
  var_5.m_n_round_assignments = 0;
  var_5.m_a_func_max_spawn_override = [];
  var_5.m_b_introduced = 0;
  var_5.n_spawned_rounds = 0;
  level.a_a_o_ai_spawn_params[var_2] = ::scripts\cp\utility::_id_1B8C(level.a_a_o_ai_spawn_params[var_2], var_5);
  level.a_o_ai_spawn_params_by_type[var_0] = var_5;
}

schedule_ai_intro_round(var_0, var_1) {
  validate_round_scheduling(var_1);
  level.a_ai_type_intro_rounds = scripts\cp\utility::_id_459B(level.a_ai_type_intro_rounds, []);
  level.a_ai_type_intro_rounds[var_1] = var_0;
}

ai_type_intro_round(var_0) {
  level.a_str_round_ai_types = scripts\cp\utility::_id_1B8C(level.a_str_round_ai_types, var_0);
  var_1 = randomintrange(6, int(min(10, level.zombie_spawn_count)) + 1);
  level.a_str_special_ai_spawns[var_1] = var_0;
}

should_do_intro_round() {
  var_0 = 0;

  if(isDefined(level.a_ai_type_intro_rounds)) {
    var_1 = getarraykeys(level.a_ai_type_intro_rounds);

    foreach(var_3 in var_1) {
      if(var_3 <= level._id_11049) {
        var_4 = level.a_ai_type_intro_rounds[var_3];
        level.a_o_ai_spawn_params_by_type[var_4].m_b_introduced = 1;
        level.a_ai_type_intro_rounds = scripts\engine\utility::array_remove_index(level.a_ai_type_intro_rounds, var_3, 1);

        if(var_3 == level._id_11049) {
          var_0 = 1;
          ai_type_intro_round(var_4);
        }
      }
    }

    if(level.a_ai_type_intro_rounds.size == 0) {
      level.a_ai_type_intro_rounds = undefined;
    }
  }

  return var_0;
}

construct_round_spawns() {
  if(!isDefined(level.a_a_o_ai_spawn_params)) {
    return;
  }
  level.a_n_quarter_points = [0, 0, 0, 0];
  level.a_str_special_ai_spawns = [];
  level.a_str_round_ai_types = [];
  level.n_infinite_zombies_remaining = undefined;
  level.n_previous_zombie_spawn = 0;

  if(!level should_do_intro_round()) {
    var_0 = distribute_points();

    if(var_0 > 0) {
      assign_ai_spawns(var_0);
    }
  }

  level notify("round_spawns_constructed");
}

get_special_ai_type_to_spawn() {
  if(!isDefined(level.a_a_o_ai_spawn_params)) {
    return undefined;
  }

  var_0 = undefined;

  if(level.a_str_special_ai_spawns.size) {
    var_1 = level.zombie_spawn_count;
    var_2 = 1 + (level.n_zombie_spawns - var_1);

    if(var_2 > level.n_previous_zombie_spawn && isDefined(level.a_str_special_ai_spawns[var_2])) {
      var_0 = level.a_str_special_ai_spawns[var_2];
    }

    if(var_2 > level.n_previous_zombie_spawn) {
      level.n_previous_zombie_spawn = var_2;
    }
  }

  return var_0;
}

on_ai_spawned() {
  self endon("death");
  self._id_DB73 = 1;
  scripts\aitypes\zombie_common\awareness::set_aware();
  waitframe();

  if(self._id_110B0 == "base" && isDefined(self._id_D603)) {
    self thread[[self._id_D603]](get_move_speed());
  }
}

_id_AA4A(var_0) {
  var_1 = get_round_enemies();

  if(level scripts\engine\utility::_id_5C00("zombie_spawn_count_set") && level.zombie_spawn_count <= 0 && var_1.size == 0) {
    if(isDefined(level.a_round_last_ai_killed_callbacks)) {
      foreach(var_3 in level.a_round_last_ai_killed_callbacks) {
        self thread[[var_3]](var_0);
      }
    }

    level.rbz scripts\engine\utility::_id_5474("all_killed");
  }

  if(scripts\engine\utility::is_equal(self._id_110B0, "trickster") && istrue(self.is_round_spawned)) {
    var_5 = 1;
    var_6 = _id_06FE::_id_6322();

    foreach(var_8 in var_6) {
      if(scripts\engine\utility::is_equal(var_8._id_110B0, "trickster")) {
        var_5 = 0;
        break;
      }
    }

    if(var_5) {
      update_specific_ai_type_cooldown("enemy_zombie_trickster_cp");
    }
  }
}

get_move_speed() {
  var_0 = "walk";
  var_1 = get_round() * 6;
  var_1 = randomintrange(var_1 - 35, var_1 + 35);

  if(var_1 > 236) {
    var_0 = "super_sprint";
  } else if(var_1 > 70) {
    var_0 = "sprint";
  } else if(var_1 > 35) {
    var_0 = "run";
  }

  return var_0;
}

watch_round_timeout() {
  self endon("round_complete");
  level endon("game_ended");
  level waittill("zombie_spawn_count_set");
  level.zombie_cleanup.round_rollover = 0;

  if(level._id_11049 < 6) {
    level scripts\engine\utility::_id_5C27("power_on", "enable_round_timeout");
  }

  while(level.zombie_spawn_count > 0) {
    wait 1;
  }

  var_0 = scripts\cp\utility::_id_459B(level.n_round_timeout_override, 600);
  var_1 = scripts\cp\utility::_id_459B(level.n_round_timeout_no_kill_override, 20);
  var_2 = undefined;

  while(var_0 > 0 && var_1 > 0) {
    var_3 = get_round_enemies();
    var_4 = var_2;
    var_2 = var_3.size;

    if(level._id_11049 >= 4 && var_2 <= 3) {
      foreach(var_6 in var_3) {
        var_6 last_zombie_speed_up();
      }
    }

    if(!level scripts\engine\utility::_id_5C00("pause_round_timeout")) {
      var_0--;

      if(istrue(level.b_round_timeout_on_no_kills)) {
        if(isDefined(var_4) && var_2 == var_4) {
          var_1--;
        } else {
          var_1 = scripts\cp\utility::_id_459B(level.n_round_timeout_no_kill_override, 20);
        }
      }
    }

    wait 1;
  }

  level scripts\engine\utility::_id_5C30("pause_round_timeout");
  level scripts\cp\zombies\zm_cleanup::cleanup_zombies_into_next_round(1);
  scripts\engine\utility::_id_5474("round_timeout");
}

last_zombie_speed_up() {
  if(istrue(self.b_last_zombie_speed_up) || !isalive(self)) {
    return;
  }
  if(self._id_110B0 == "base" && isDefined(self._id_D603)) {
    self thread[[self._id_D603]]("sprint");
  }
}

init_special_round() {
  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    return;
  }
  level.special_round_count = 1;
  level.next_special_round = 5;
  var_0 = register_round_spawn_instance(::should_start_special_round, ::get_special_round_ai_type, ::on_special_round_start, ::on_special_round_complete, ::do_special_round_spawn_delay, ::get_special_round_total_spawn_count);
  var_0.a_ai_spawned["enemy_zombie_screamer_cp"] = [];
  var_0.b_is_special_round = 1;
}

should_start_special_round(var_0) {
  if(scripts\engine\utility::_id_5C00("disallow_special_round")) {
    return 0;
  }

  return level._id_11049 >= level.next_special_round;
}

get_special_round_ai_type(var_0) {
  return "enemy_zombie_screamer_cp";
}

get_special_round_total_spawn_count(var_0) {
  var_1 = [6, 6, 8, 8, 8, 10];
  var_2 = get_number_of_players();
  var_3 = level.special_round_count - 1;

  if(var_3 >= var_1.size) {
    var_3 = var_1.size - 1;
  }

  return var_2 * var_1[var_3];
}

on_special_round_start() {
  scripts\engine\utility::_id_5C04("zombie_drop_powerups");
  scripts\engine\utility::_id_5C1B("in_special_round");
  scripts\engine\utility::_id_5C24("round_spawn_zombies");
  level.next_special_round = level._id_11049 + randomintrange(5, 8);
  on_round_last_ai_killed(::special_round_last_ai_killed);

  if(isDefined(level.special_round_vision_override)) {
    _func_0265(0, 5, level.special_round_vision_override);
  } else {
    _func_0265(0, 5, "cp_sumpf_special");
  }

  _func_01E3("dog_start");
  level thread watch_special_round_quit_midway();
  wait 5;
  level thread _id_0720::play_narration("zm_cmcp_cann_zann_asen");
  wait 3;
}

on_special_round_complete() {
  scripts\engine\utility::_id_5C1B("zombie_drop_powerups");
  scripts\engine\utility::_id_5C04("in_special_round");
  level.special_round_count++;
  remove_on_round_last_ai_killed(::special_round_last_ai_killed);
  _func_0265(-1, 5);
  _func_01E3("dog_end");
}

do_special_round_spawn_delay() {
  var_0 = 0;
  var_1 = 0;

  switch (scripts\cp\utility::_id_6C5C().size) {
    case 1:
      var_0 = 2.0;
      var_1 = 3.0;
      break;
    case 2:
      var_0 = 1.2;
      var_1 = 2.0;
      break;
    case 3:
      var_0 = 1.0;
      var_1 = 1.5;
      break;
    case 4:
      var_0 = 0.5;
      var_1 = 1.0;
      break;
    default:
      var_0 = 2.0;
      var_1 = 3.0;
      break;
  }

  wait(randomfloatrange(var_0, var_1));
  var_2 = [3, 5, 7, 10];

  for(;;) {
    var_3 = scripts\cp\utility::_id_6C5C().size;

    if(get_spawned_ai_of_type(self, "enemy_zombie_screamer_cp").size < var_2[var_3 - 1]) {
      break;
    }

    wait 0.2;
  }
}

special_round_last_ai_killed(var_0) {
  level scripts\engine\utility::_id_5C1B("zombie_drop_powerups");
  level._id_1103C = "full_ammo";
  scripts\cp\utility::_id_D458("zombie_drop_item", 1);
  thread _id_0990::_id_11020();
}

watch_special_round_quit_midway() {
  level endon("game_ended");
  level endon("round_complete");
  level waittill("stop_round_spawn");
  on_special_round_complete();
}