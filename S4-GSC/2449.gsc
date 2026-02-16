/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2449.gsc
*************************************************/

init(var_0) {
  level._id_E186 = [];
  level._id_0F2E = undefined;

  if(isDefined(level.alt_spawn_managers) && _func_0121(level.alt_spawn_managers)) {
    var_0 = level.alt_spawn_managers;
  }

  var_1 = _func_03BB(var_0);

  foreach(var_3 in var_1) {
    level._id_E186[var_3["name"]] = var_3;
  }

  level _id_06CB::_id_AA4A(::_id_0C78);
  init_spawn_manager_active_zombie_info(["enemy_base_zombie_cp", "enemy_zombie_screamer_cp", "enemy_zombie_juggernaut_cp"]);
}

setup_objective_zombie_speed_settings() {
  level.objective_zombie_speed_settings = [];
  level.objective_zombie_speed_settings["default"] = _func_0393("zmspeedsettings:cp_zod_objective_default_speed_settings");
  level.objective_zombie_speed_settings["orb_follow"] = _func_0393("zmspeedsettings:cp_zod_objective_orb_follow_speed_settings");
  level.objective_zombie_speed_settings["exfil"] = _func_0393("zmspeedsettings:cp_zod_objective_exfil_speed_settings");
  level.objective_zombie_speed_settings["soul_capture"] = _func_0393("zmspeedsettings:cp_zod_objective_soul_capture_speed_settings");
  level.objective_zombie_speed_settings["domination"] = [];
  level.objective_zombie_speed_settings["domination"][0] = _func_0393("zmspeedsettings:cp_zod_objective_domination_general_speed_settings");
  level.objective_zombie_speed_settings["domination"][1] = _func_0393("zmspeedsettings:cp_zod_objective_domination_final_1_speed_settings");
  level.objective_zombie_speed_settings["domination"][2] = _func_0393("zmspeedsettings:cp_zod_objective_domination_final_2_speed_settings");
  level.objective_zombie_speed_settings["domination"][3] = _func_0393("zmspeedsettings:cp_zod_objective_domination_final_3_speed_settings");
  level.objective_zombie_speed_settings["holdout"] = [];
  level.objective_zombie_speed_settings["holdout"][0] = _func_0393("zmspeedsettings:cp_zod_objective_holdout_speed_settings");
  level.objective_zombie_speed_settings["holdout"][1] = _func_0393("zmspeedsettings:cp_zod_objective_holdout_wave_1_speed_settings");
  level.objective_zombie_speed_settings["holdout"][2] = _func_0393("zmspeedsettings:cp_zod_objective_holdout_wave_2_speed_settings");
  level.objective_zombie_speed_settings["holdout"][3] = _func_0393("zmspeedsettings:cp_zod_objective_holdout_wave_3_speed_settings");
  level.objective_zombie_speed_settings["holdout"][4] = _func_0393("zmspeedsettings:cp_zod_objective_holdout_wave_4_speed_settings");
}

get_round_number_speed_settings(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!isDefined(level._id_11049)) {
    level._id_11049 = 1;
  }

  var_1 = level._id_11049;

  if(var_1 > 50) {
    var_1 = 50;
  }

  var_2 = var_0.roundspeedsetting;

  foreach(var_4 in var_2) {
    if(var_1 >= var_4.minround && var_1 <= var_4.maxround) {
      return var_4;
    }
  }

  return undefined;
}

get_objective_specific_round_number_speed_settings() {
  if(isDefined(level._id_3BE9._id_0F51)) {
    switch (level._id_3BE9._id_0F51._id_3BE5) {
      case "orb_follow":
        return get_round_number_speed_settings(level.objective_zombie_speed_settings["orb_follow"]);
      case "exfil":
        return get_round_number_speed_settings(level.objective_zombie_speed_settings["exfil"]);
      case "soul_capture":
        return get_round_number_speed_settings(level.objective_zombie_speed_settings["soul_capture"]);
      case "domination":
        return get_round_number_speed_settings(level.objective_zombie_speed_settings["domination"][0]);
      default:
        return get_round_number_speed_settings(level.objective_zombie_speed_settings["default"]);
    }
  }
}

_id_C9FC(var_0, var_1, var_2, var_3) {
  _id_E8E2();

  if(!isDefined(level.objective_default_zombie_speed_settings)) {
    setup_objective_zombie_speed_settings();
  }

  level.current_objective_round_speed_settings = get_objective_specific_round_number_speed_settings();
  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4._id_455D = level._id_E186[var_0];
  var_4._id_9C03 = 0;
  var_4.check_max_active_against_all = var_3;

  if(isDefined(level._id_11049) && isDefined(var_4._id_455D["zombieRoundMaxActive"])) {
    var_5 = level.players.size;
    var_6 = level._id_11049 - 1;

    if(var_6 > var_4._id_455D["zombieRoundMaxActive"][0]["onep"].size - 1) {
      var_6 = var_4._id_455D["zombieRoundMaxActive"][0]["onep"].size - 1;
    }

    switch (var_5) {
      case 1:
        var_4._id_9C03 = var_4._id_455D["zombieRoundMaxActive"][0]["onep"][var_6];
        break;
      case 2:
        var_4._id_9C03 = var_4._id_455D["zombieRoundMaxActive"][0]["twop"][var_6];
        break;
      case 3:
        var_4._id_9C03 = var_4._id_455D["zombieRoundMaxActive"][0]["threep"][var_6];
        break;
      case 4:
        var_4._id_9C03 = var_4._id_455D["zombieRoundMaxActive"][0]["fourp"][var_6];
        break;
      default:
        break;
    }
  }

  var_4._id_9C02 = _id_0BF9(var_4._id_455D["maxActive"]) + var_4._id_9C03;
  var_4._id_F35D = 0;
  var_4._id_0F1A = 0;
  var_4._id_8D76 = 0;
  var_4._id_9EA9 = 0;
  var_4._id_3848 = 1;
  var_4._id_1461 = [];
  var_4._id_A483 = -1;
  var_4._id_E1CF = [];
  var_4._id_E2DA = [];

  if(!isDefined(var_2)) {
    var_7 = scripts\engine\utility::getStructArray(var_1, "targetname");
  } else {
    var_7 = var_2;
  }

  foreach(var_9 in var_7) {
    if(isDefined(var_9._id_039B) && var_9._id_039B == "spawn_manager_spawner") {
      var_4._id_E2DA[var_4._id_E2DA.size] = var_9;
    }
  }

  var_4._id_10CB7 = [];

  for(var_11 = 0; var_11 < var_4._id_455D["waves"].size; var_11++) {
    var_12 = var_4._id_455D["waves"][var_11];
    var_13 = spawnStruct();
    var_13._id_455D = var_12;
    var_13._id_10C97 = var_11;
    var_13._id_E69C = 0;
    var_13._id_5B15 = 0;
    var_13._id_E658 = -1;
    var_13._id_F35D = 0;
    var_13._id_0F1A = 0;
    var_13._id_8D76 = 0;
    var_13._id_12FA = [];
    var_14 = var_12["aiTypes"].size;

    foreach(var_16 in var_13._id_455D["aiTypes"]) {
      var_17 = spawnStruct();
      var_17._id_455D = var_16;
      var_17._id_9C02 = _id_0BF9(var_16["maxActive"]);
      var_17._id_F35D = _get_difficulty_scaled_total_count(var_16);
      var_17._id_0F1A = 0;
      var_17._id_8D76 = 0;
      var_4._id_F35D = var_4._id_F35D + var_17._id_F35D;
      var_13._id_F35D = var_13._id_F35D + var_17._id_F35D;
      var_13._id_12FA[var_13._id_12FA.size] = var_17;
    }

    var_13._id_E134 = [];

    foreach(var_20 in var_13._id_455D["spawnEventTriggers"]) {
      var_21 = spawnStruct();
      var_21._id_455D = var_20;
      var_21._id_F35D = _id_0BF8(var_20["count"]);
      var_21._id_0F1A = 0;
      var_21._id_8D76 = 0;
      var_21.distance_check = var_20["distance_check"];
      var_4._id_F35D = var_4._id_F35D + var_21._id_F35D;
      var_13._id_F35D = var_13._id_F35D + var_21._id_F35D;
      var_21._id_F615 = 0;
      var_21._id_3B6E = [];

      foreach(var_23 in var_20["conditions"]) {
        var_24 = spawnStruct();
        var_24._id_455D = var_23;
        var_24._id_F615 = 0;

        if(var_24._id_455D["type"] == "elapsedTime") {
          var_24._id_CFEF = _id_0BF9(var_23["seconds"]);
        } else if(var_24._id_455D["type"] == "aiKilled") {
          var_24._id_011A = _id_0BF9(var_23["count"]);
        }

        var_21._id_3B6E[var_21._id_3B6E.size] = var_24;
      }

      var_13._id_E134[var_13._id_E134.size] = var_21;
    }

    if(isDefined(var_13._id_455D["nextWave"])) {
      var_13._id_A48E = spawnStruct();
      var_13._id_A48E._id_455D = var_13._id_455D["nextWave"];
      var_13._id_A48E._id_F615 = 0;
      var_13._id_A48E._id_3B6E = [];

      foreach(var_23 in var_13._id_455D["nextWave"]["conditions"]) {
        var_24 = spawnStruct();
        var_24._id_455D = var_23;
        var_24._id_F615 = 0;

        if(var_24._id_455D["type"] == "elapsedTime") {
          var_24._id_CFEF = _id_0BF9(var_23["seconds"]);
        } else if(var_24._id_455D["type"] == "aiLeftInWave") {
          var_24._id_011A = _id_0BF9(var_23["count"]);
        }

        var_13._id_A48E._id_3B6E[var_13._id_A48E._id_3B6E.size] = var_24;
      }
    }

    var_4._id_10CB7[var_4._id_10CB7.size] = var_13;
  }

  level._id_0F2E = var_4;
  level._id_0F2E thread _id_0D7B();
  level.xp_per_round_active_player_count = level.players.size;
}

_id_E8E2(var_0) {
  if(isDefined(level._id_0F2E)) {
    level._id_0F2E._id_3848 = var_0;
    level._id_0F2E notify("stop_spawn_manager");
  }
}

_id_0C78(var_0) {
  if(isDefined(self._id_E16D)) {
    decrement_global_active_count_value(self._id_E16D.type);
    var_1 = self._id_E16D;
    var_1._id_9E6A._id_8D76++;
    var_1._id_9E6A._id_0F1A--;
    var_1._id_10C60._id_8D76++;
    var_1._id_10C60._id_0F1A--;

    if(isDefined(var_1._id_12F9)) {
      var_1._id_12F9._id_8D76++;
      var_1._id_12F9._id_0F1A--;
    }

    if(isDefined(var_1._id_E133)) {
      var_1._id_E133._id_8D76++;
      var_1._id_E133._id_0F1A--;
    }

    var_1._id_9E6A._id_1461 = scripts\engine\utility::array_remove(var_1._id_9E6A._id_1461, self);
  }
}

_id_0BF8(var_0) {
  var_1 = level.players.size;
  var_2 = undefined;

  if(isDefined(var_0) && isDefined(var_0[0])) {
    var_2 = var_0[0];
  }

  switch (var_1) {
    case 1:
      if(isDefined(var_2)) {
        return _id_0BF9(var_2["onep"]);
      }

      break;
    case 2:
      if(isDefined(var_2)) {
        return _id_0BF9(var_2["twop"]);
      }

      break;
    case 3:
      if(isDefined(var_2)) {
        return _id_0BF9(var_2["threep"]);
      }

      break;
    case 4:
      if(isDefined(var_2)) {
        return _id_0BF9(var_2["fourp"]);
      }

      break;
    default:
      if(isDefined(var_2)) {
        return _id_0BF9(var_2["fourp"]);
      } else {
        return _id_0BF9(var_2);
      }

      break;
  }
}

_get_difficulty_scaled_total_count(var_0) {
  var_1 = level.players.size;
  var_2 = int(_get_difficulty_rating());

  if(var_2 > 0) {
    var_2 = var_2 - 1;
  }

  var_3 = undefined;

  if(_func_0107(var_0["difficulty_scaling_count"])) {
    var_3 = var_0["difficulty_scaling_count"][0];
  }

  var_4 = undefined;

  if(isDefined(var_3)) {
    switch (var_1) {
      case 1:
        var_4 = var_3["onep"][var_2];
        break;
      case 2:
        var_4 = var_3["twop"][var_2];
        break;
      case 3:
        var_4 = var_3["threep"][var_2];
        break;
      case 4:
        var_4 = var_3["fourp"][var_2];
        break;
      default:
        var_4 = var_3["fourp"][var_2];
        break;
    }
  }

  if(isDefined(var_4)) {
    return var_4;
  } else {
    return _id_0BF9(var_0["count"]);
  }
}

_get_difficulty_rating() {
  if(isDefined(level._id_11049)) {
    return _func_0037(level._id_11049 / 3);
  } else {
    return 1;
  }
}

_id_0BF9(var_0) {
  if(_func_0107(var_0)) {
    return randomintrange(var_0[0], var_0[1] + 1);
  } else {
    return var_0;
  }
}

_id_0D7B() {
  level endon("game_ended");
  _id_0D83(0);

  for(;;) {
    foreach(var_1 in self._id_10CB7) {
      if(var_1._id_E69C && !var_1._id_5B15) {
        var_1 _id_0DA5(self);
      }
    }

    if(self._id_E1CF.size > 0 && _id_0C3C()) {
      _id_0BC3(self._id_E1CF[0]);
      self._id_E1CF = scripts\engine\utility::array_remove_index(self._id_E1CF, 0);
    }

    var_3 = scripts\engine\utility::_id_108A7(self._id_455D["updateInterval"], "stop_spawn_manager");
    var_4 = 1;

    foreach(var_1 in self._id_10CB7) {
      if(!var_1._id_5B15) {
        var_4 = 0;
        break;
      }
    }

    if(var_3 == "stop_spawn_manager" || var_4) {
      break;
    }
  }

  _id_0D7A();
}

_id_0D7A() {
  foreach(var_1 in self._id_1461) {
    var_1._id_E16D = undefined;
  }

  if(isDefined(self._id_3848) && self._id_3848) {
    var_3 = self._id_1461;

    foreach(var_1 in var_3) {
      var_1.spawn_manager_cleanup = 1;
      var_1 _meth_81FA();
    }

    level thread reset_spawn_manager_active_zombie_info();
  }

  level._id_0F2E = undefined;
}

_id_0D83(var_0) {
  var_1 = self._id_10CB7[var_0];

  if(istrue(var_1._id_E69C)) {
    return;
  }
  var_2 = level.players.size;
  var_3 = undefined;

  if(isDefined(var_1._id_455D["maxActive"]) && isDefined(var_1._id_455D["maxActive"][0])) {
    var_3 = var_1._id_455D["maxActive"][0];
  }

  self._id_9EA9 = self._id_455D["minTimeBetweenSpawns"];
  var_4 = undefined;

  if(isDefined(var_1._id_455D["minTimeBetweenSpawns"]) && isDefined(var_1._id_455D["minTimeBetweenSpawns"][0])) {
    var_4 = var_1._id_455D["minTimeBetweenSpawns"][0];
  }

  switch (var_2) {
    case 1:
      if(isDefined(var_3)) {
        self._id_9C02 = _id_0BF9(var_3["onep"]) + self._id_9C03;
      }

      if(isDefined(var_4)) {
        self._id_9EA9 = var_4["onep"];
      }

      break;
    case 2:
      if(isDefined(var_3)) {
        self._id_9C02 = _id_0BF9(var_3["twop"]) + self._id_9C03;
      }

      if(isDefined(var_4)) {
        self._id_9EA9 = var_4["twop"];
      }

      break;
    case 3:
      if(isDefined(var_3)) {
        self._id_9C02 = _id_0BF9(var_3["threep"]) + self._id_9C03;
      }

      if(isDefined(var_4)) {
        self._id_9EA9 = var_4["threep"];
      }

      break;
    case 4:
      if(isDefined(var_3)) {
        self._id_9C02 = _id_0BF9(var_3["fourp"]) + self._id_9C03;
      }

      if(isDefined(var_4)) {
        self._id_9EA9 = var_4["fourp"];
      }

      break;
    default:
      if(isDefined(var_3)) {
        self._id_9C02 = _id_0BF9(var_3["fourp"]) + self._id_9C03;
      }

      if(isDefined(var_4)) {
        self._id_9EA9 = var_4["fourp"];
      }

      break;
  }

  var_1._id_E69C = 1;
  var_1._id_E658 = gettime();
}

_id_0C3C() {
  if(_id_07F7::_id_6A57() == 0) {
    return 0;
  }

  if(_func_0072() >= 32) {
    return 0;
  }

  if(istrue(self.check_max_active_against_all)) {
    var_0 = _func_0070("axis");

    if(var_0.size >= self._id_9C02) {
      return 0;
    }
  }

  if(self._id_1461.size >= self._id_9C02) {
    return 0;
  }

  if(self._id_A483 != -1 && gettime() < self._id_A483) {
    return 0;
  }

  if(level scripts\engine\utility::_id_5C0C("spawn_zombies") && !level scripts\engine\utility::_id_5C00("spawn_zombies")) {
    return 0;
  }

  return 1;
}

_id_0CAB(var_0, var_1, var_2, var_3, var_4) {
  if(!_is_round_threshold_ignored(var_3) && scripts\engine\utility::is_equal(_check_ai_spawn_round_threshold(var_0), 0)) {
    return;
  }
  var_5 = spawnStruct();
  var_5._id_9E6A = self;
  var_5.type = var_0;
  var_5._id_10C60 = var_1;
  var_5._id_E231 = var_2;
  var_5.distance_check = var_4;

  if(var_2 == "normal") {
    var_5._id_12F9 = var_3;
    self._id_E1CF[self._id_E1CF.size] = var_5;
  } else {
    var_5._id_E133 = var_3;
    self._id_E1CF = _id_0B1C(var_5, self._id_E1CF);
  }

  var_5._id_9E6A._id_0F1A++;
  var_5._id_10C60._id_0F1A++;

  if(isDefined(var_5._id_12F9)) {
    var_5._id_12F9._id_0F1A++;
  }

  if(isDefined(var_5._id_E133)) {
    var_5._id_E133._id_0F1A++;
  }
}

_id_0B1C(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2[var_3 + 1] = var_1[var_3];
  }

  var_2[0] = var_0;
  return var_2;
}

_is_round_threshold_ignored(var_0) {
  var_1 = var_0._id_455D["force_appear_round"];

  if(isDefined(var_1) && isDefined(level._id_11049)) {
    if(var_1 <= level._id_11049) {
      return 1;
    }
  }

  return 0;
}

_check_ai_spawn_round_threshold(var_0) {
  if(!isDefined(level._id_11049)) {
    return 1;
  }

  var_1 = level._id_11049;

  if(isDefined(level.zombie_round_override)) {
    var_1 = level.zombie_round_override;
  }

  var_2 = 1;

  switch (var_0) {
    case "enemy_zombie_juggernaut_cp":
      if(var_1 < 5) {
        var_2 = 0;
      }

      break;
    case "enemy_zombie_screamer_cp":
      if(var_1 < 3) {
        var_2 = 0;
      }

      break;
    case "enemy_zombie_trickster_cp":
      if(!scripts\cp\utility::is_season_live(2)) {
        var_2 = 0;
      } else if(var_1 < 6) {
        var_2 = 0;
      }

      break;
    default:
      var_2 = 1;
      break;
  }

  return var_2;
}

_get_spawner_array_by_distance(var_0) {
  if(isDefined(self.spawner_distance_check_time) && self.spawner_distance_check_time < gettime() - 3000) {
    if(self.a_valid_spawners_by_distance.size > 0) {
      var_1 = randomint(self.a_valid_spawners_by_distance.size);
      return self.a_valid_spawners_by_distance[var_1]._id_03E9;
    } else
      return self.a_backup_spawners_by_distance[0]._id_03E9;
  }

  var_2 = [];
  var_3 = [];
  var_4 = undefined;

  foreach(var_6 in self._id_E2DA) {
    var_7 = spawnStruct();
    var_7._id_03E9 = var_6;
    var_7.delta_distance = 0;
    var_7.player_nearby = 0;

    foreach(var_9 in level.players) {
      var_10 = distance(var_9.origin, var_6.origin);
      var_7.delta_distance = var_7.delta_distance + var_10;

      if(var_10 < 500) {
        var_7.player_nearby = 1;
      }
    }

    if(var_7.player_nearby != 1) {
      var_2[var_2.size] = var_7;
    }

    var_3[var_3.size] = var_7;
  }

  self.a_valid_spawners_by_distance = scripts\engine\utility::_id_1BD6(var_2, ::sort_spawners_by_delta_distance);
  self.a_backup_spawners_by_distance = scripts\engine\utility::_id_1BD6(var_3, ::sort_spawners_by_delta_distance);
  self.spawner_distance_check_time = gettime();

  if(self.a_valid_spawners_by_distance.size > 0) {
    var_1 = randomint(self.a_valid_spawners_by_distance.size);
    return self.a_valid_spawners_by_distance[var_1]._id_03E9;
  } else
    return self.a_backup_spawners_by_distance[0]._id_03E9;
}

sort_spawners_by_delta_distance(var_0, var_1) {
  if(var_0.delta_distance > var_1.delta_distance) {
    return 1;
  }

  return 0;
}

get_global_max_zombie_count_by_type(var_0) {
  switch (var_0) {
    case "enemy_zombie_screamer_cp":
      switch (level.players.size) {
        case 1:
          return 2;
        case 2:
          return 3;
        case 3:
          return 4;
        default:
          return 4;
      }
    case "enemy_zombie_juggernaut_cp":
      return 2 * level.players.size;
    case "enemy_zombie_trickster_cp":
      return 1;
    default:
      return -1;
  }
}

init_spawn_manager_active_zombie_info(var_0) {
  level.spawn_manager_active_zombie_count = scripts\cp\utility::_id_459B(level.spawn_manager_active_zombie_count, []);

  foreach(var_2 in var_0) {
    level.spawn_manager_active_zombie_count[var_2] = 0;
  }
}

decrement_global_active_count_value(var_0) {
  if(!isDefined(level.spawn_manager_active_zombie_count[var_0])) {
    return;
  }
  if(level.spawn_manager_active_zombie_count[var_0] <= 0) {
    return;
  }
  level.spawn_manager_active_zombie_count[var_0]--;
}

reset_spawn_manager_active_zombie_info() {
  var_0 = getarraykeys(level.spawn_manager_active_zombie_count);

  foreach(var_2 in var_0) {
    level.spawn_manager_active_zombie_count[var_2] = 0;
  }
}

is_type_globally_capped(var_0) {
  var_1 = get_global_max_zombie_count_by_type(var_0);

  if(isDefined(level.spawn_manager_active_zombie_count) && isDefined(level.spawn_manager_active_zombie_count[var_0]) && level.spawn_manager_active_zombie_count[var_0] >= 0 && var_1 > 0 && level.spawn_manager_active_zombie_count[var_0] >= var_1) {
    return 1;
  }

  return 0;
}

_id_0BC3(var_0) {
  if(is_type_globally_capped(var_0.type)) {
    return;
  }
  var_1 = undefined;

  if(scripts\engine\utility::is_equal(var_0.type, "enemy_base_zombie_cp") && _func_0107(level.zm_spawn_manager_spawn_struct_array_override) && level.zm_spawn_manager_spawn_struct_array_override.size > 0) {
    var_2 = randomintrange(0, level.zm_spawn_manager_spawn_struct_array_override.size);
    var_3 = level.zm_spawn_manager_spawn_struct_array_override[var_2].spawn_struct;
    var_1 = level.zm_spawn_manager_spawn_struct_array_override[var_2];
    level.zm_spawn_manager_spawn_struct_array_override = scripts\engine\utility::array_remove_index(level.zm_spawn_manager_spawn_struct_array_override, var_2);
  } else if(isDefined(var_0.distance_check) && var_0.distance_check == 1 || scripts\engine\utility::is_equal(var_0.type, "enemy_zombie_screamer_cp"))
    var_3 = _get_spawner_array_by_distance(var_0);
  else {
    var_2 = randomintrange(0, self._id_E2DA.size);
    var_3 = self._id_E2DA[var_2];
  }

  var_4 = _func_02AB(var_3.origin);
  var_5 = _id_09A4::_id_110AD(var_0.type, var_3.origin, var_3.angles, var_3, undefined, undefined, _id_09A4::get_ltm_spawner_model_from_type(var_0.type));

  if(!isDefined(var_5)) {
    return;
  }
  var_5._id_DB73 = 1;
  var_5._id_E16D = var_0;
  var_5._id_0481 = "objective_zombie";

  if(isDefined(var_1)) {
    var_5.override_spawn_info = var_1;
  }

  if(istrue(var_3.script_num)) {
    var_5.is_in_playspace = 1;
  }

  if(should_set_zombie_movement_speed()) {
    var_5 thread set_zombie_movement_speed();
  }

  level.spawn_manager_active_zombie_count[var_0.type] = ::scripts\cp\utility::_id_459B(level.spawn_manager_active_zombie_count[var_0.type], 0);
  level.spawn_manager_active_zombie_count[var_0.type]++;
  var_6 = spawnStruct();
  var_6._id_122C = var_5;
  var_6._id_82FC = level._id_3BE9._id_0F51;

  if(isDefined(var_3._id_CE18)) {
    var_6._id_CE18 = var_3._id_CE18;
  }

  _id_06CB::_id_2F23("zm_spawn_manager_zombie_spawned", var_6);
  self._id_1461[self._id_1461.size] = var_5;
  self._id_A483 = gettime() + self._id_9EA9 * 1000;
}

_id_0DA5(var_0) {
  _id_0B96(var_0);
  _id_0B93(var_0);
  _id_0B94(var_0);
  _id_0B95(var_0);
}

_id_0B96(var_0) {
  if(!var_0 _id_0C3C()) {
    return;
  }
  var_1 = [];

  foreach(var_3 in self._id_12FA) {
    if(isDefined(var_3._id_455D["incremental_spawn_chance"])) {
      var_4 = randomfloat(1);

      if(var_4 < var_3._id_455D["incremental_spawn_chance"]) {
        var_3._id_455D["incremental_spawn_chance"] = var_3._id_455D["base_spawn_chance"];
      } else {
        var_3._id_455D["incremental_spawn_chance"] = var_3._id_455D["incremental_spawn_chance"] + var_3._id_455D["spawn_chance_increment"];
        continue;
      }
    }

    var_5 = var_3._id_0F1A + var_3._id_8D76;

    if(var_5 >= var_3._id_F35D) {
      continue;
    }
    if(isDefined(var_3._id_9C02) && var_3._id_0F1A >= var_3._id_9C02) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  if(var_1.size > 0) {
    var_3 = _force_spawn_chance_ai_type(var_1);

    if(!isDefined(var_3)) {
      var_7 = randomintrange(0, var_1.size);
      var_3 = var_1[var_7];

      if(_is_ai_type_skippable(var_3)) {
        var_3 = var_1[0];
      }
    }

    var_0 _id_0CAB(var_3._id_455D["type"], self, "normal", var_3);
  }
}

_force_spawn_chance_ai_type(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = var_5._id_455D["force_spawn_chance"];

    if(!isDefined(var_6)) {
      continue;
    }
    if(_is_ai_type_skippable(var_5)) {
      continue;
    }
    if(!isDefined(var_2)) {
      var_2 = randomfloat(1);
    }

    if(var_2 < var_6 && var_6 >= var_3) {
      var_1 = var_5;
      var_3 = var_6;
    }
  }

  return var_1;
}

_is_ai_type_skippable(var_0) {
  if(is_type_globally_capped(var_0._id_455D["type"])) {
    return 1;
  }

  if(!_is_round_threshold_ignored(var_0) && scripts\engine\utility::is_equal(_check_ai_spawn_round_threshold(var_0._id_455D["type"]), 0)) {
    return 1;
  }

  return 0;
}

_id_0B93(var_0) {
  var_1 = gettime();

  foreach(var_3 in self._id_E134) {
    if(!var_3._id_F615) {
      var_4 = 0;

      foreach(var_6 in var_3._id_3B6E) {
        if(var_6._id_455D["type"] == "elapsedTime") {
          var_7 = var_6._id_CFEF * 1000;

          if(self._id_E658 != -1 && var_1 - self._id_E658 > var_7) {
            var_4 = 1;
            var_6._id_F615 = 1;
            break;
          }

          continue;
        }

        if(var_6._id_455D["type"] == "aiKilled") {
          if(self._id_8D76 >= var_6._id_011A) {
            var_4 = 1;
            var_6._id_F615 = 1;
            break;
          }
        }
      }

      if(var_4) {
        for(var_9 = 0; var_9 < var_3._id_F35D; var_9++) {
          var_0 _id_0CAB(var_3._id_455D["type"], self, "eventTrigger", var_3, var_3.distance_check);
        }

        var_3._id_F615 = 1;
      }
    }
  }
}

_id_0B94(var_0) {
  var_1 = gettime();

  if(isDefined(self._id_A48E) && !self._id_A48E._id_F615) {
    var_2 = 0;

    foreach(var_4 in self._id_A48E._id_3B6E) {
      if(var_4._id_455D["type"] == "elapsedTime") {
        var_5 = var_4._id_CFEF * 1000;

        if(self._id_E658 != -1 && var_1 - self._id_E658 > var_5) {
          var_2 = 1;
          var_4._id_F615 = 1;
          break;
        }

        continue;
      }

      if(var_4._id_455D["type"] == "aiLeftInWave") {
        var_6 = self._id_F35D - self._id_8D76;

        if(var_6 <= var_4._id_011A) {
          var_2 = 1;
          var_4._id_F615 = 1;
          break;
        }
      }
    }

    var_8 = 0;
    var_9 = max(var_0._id_9C02 - var_0._id_0F1A, 0);

    if(var_9 >= self._id_A48E._id_455D["availableAiCount"]) {
      var_8 = 1;
    }

    if(var_2 && var_8) {
      self._id_A48E._id_F615 = 1;
      var_0 thread _id_0D83(self._id_10C97 + 1);
    }
  }
}

_id_0B95(var_0) {
  foreach(var_2 in self._id_12FA) {
    if(var_2._id_8D76 < var_2._id_F35D) {
      return;
    }
  }

  foreach(var_5 in self._id_E134) {
    if(var_5._id_8D76 < var_5._id_F35D) {
      return;
    }
  }

  foreach(var_8 in var_0._id_E1CF) {
    if(var_8._id_10C60 == self) {
      return;
    }
  }

  self._id_5B15 = 1;
}

should_set_zombie_movement_speed() {
  if(isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "holdout")) {
    return 0;
  }

  return 1;
}

set_zombie_movement_speed() {
  var_0 = self;
  var_1 = level.players.size;

  if(var_0._id_1210 == "actor_enemy_base_zombie_cp" || var_0._id_1210 == "actor_enemy_base_zombie_skorpion_cp" || var_0._id_1210 == "actor_enemy_base_zombie_sumpf_cp") {
    var_2 = level.players.size;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = level.current_objective_round_speed_settings;

    if(isDefined(var_6)) {
      if(var_2 == 1) {
        if(isDefined(var_6.oneprunchance)) {
          var_5 = var_6.oneprunchance;
        }

        if(isDefined(var_6.onepsprintchance)) {
          var_4 = var_6.onepsprintchance;
        }

        if(isDefined(var_6.onepsupersprintchance)) {
          var_3 = var_6.onepsupersprintchance;
        }
      } else if(var_2 == 2) {
        if(isDefined(var_6.twoprunchance)) {
          var_5 = var_6.twoprunchance;
        }

        if(isDefined(var_6.twopsprintchance)) {
          var_4 = var_6.twopsprintchance;
        }

        if(isDefined(var_6.twopsupersprintchance)) {
          var_3 = var_6.twopsupersprintchance;
        }
      } else if(var_2 == 3) {
        if(isDefined(var_6.threeprunchance)) {
          var_5 = var_6.threeprunchance;
        }

        if(isDefined(var_6.threepsprintchance)) {
          var_4 = var_6.threepsprintchance;
        }

        if(isDefined(var_6.threepsupersprintchance)) {
          var_3 = var_6.threepsupersprintchance;
        }
      } else {
        if(isDefined(var_6.fourprunchance)) {
          var_5 = var_6.fourprunchance;
        }

        if(isDefined(var_6.fourpsprintchance)) {
          var_4 = var_6.fourpsprintchance;
        }

        if(isDefined(var_6.fourpsupersprintchance)) {
          var_3 = var_6.fourpsupersprintchance;
        }
      }
    }

    var_7 = randomfloat(1);

    if(var_3 > 0 && var_7 <= var_3) {
      var_0[[var_0._id_D603]]("super_sprint");
    } else if(var_4 > 0 && var_7 <= var_4) {
      var_0[[var_0._id_D603]]("sprint");
    } else if(var_5 > 0 && var_7 <= var_5) {
      var_0[[var_0._id_D603]]("run");
    } else {
      var_0[[var_0._id_D603]]("walk");
    }
  }
}