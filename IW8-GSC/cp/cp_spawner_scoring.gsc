/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_spawner_scoring.gsc
***********************************************/

spawner_scoring_init() {
  scripts\engine\utility::flag_init("_encstr_A17621231BA7C785D9C95F519DE881AFDE90ABCA468D57FBF0AF412E8BD0593B702852");
  level.current_spawn_scoring_index = 0;
  level.spawn_scoring_array = [];
  level.total_cluster_spawn_score = 13;
  level.total_veh_spawn_score = 3;
  level.total_spawn_score = 18;
  level.spawner_scoring_funcs = [];
  level.spawner_scoring_funcs["_encstr_847610EC5686D2C63659AFCD8358DD37AC39"] = ::vehicle_spawnpoint_scoring;
  level.spawner_scoring_funcs["_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E"] = ::cluster_spawnpoint_scoring;
  level.spawner_scoring_funcs["_encstr_88201196333AF5A941D330F1CF88C10F329F8E"] = ::standard_spawnpoint_scoring;
  level._id_1364A["_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E"] = 0;
  level.spawner_scoring_critical_factors = [];
  level.spawner_scoring_critical_factors["_encstr_847610EC5686D2C63659AFCD8358DD37AC39"] = ::vehicle_spawnpoint_valid;
  level.spawner_scoring_critical_factors["_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E"] = ::cluster_spawnpoint_valid;
  level.spawner_scoring_critical_factors["_encstr_88201196333AF5A941D330F1CF88C10F329F8E"] = ::standard_spawnpoint_valid;
  level.get_coverblown_alias = scripts\engine\trace::create_solid_ai_contents();
}

vehicle_spawnpoint_scoring(var_0, var_1, var_2, var_3) {
  if(calculate_ai_veh_spawner_score(var_0, level.current_spawn_scoring_index))
    return var_0;
  else
    return undefined;
}

vehicle_spawnpoint_valid(var_0, var_1) {
  if(istrue(var_1))
    return 0;
  else if(scripts\engine\utility::flag_exist("_encstr_8E8F19ABEB8E22524889C98BA14091DAE91BBF7F413F0B0618F0FF") && scripts\engine\utility::flag("_encstr_8E8F19ABEB8E22524889C98BA14091DAE91BBF7F413F0B0618F0FF"))
    return 0;
  else if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.attachedguys) && isDefined(var_0.vehicle.usedpositions)) {
    var_2 = var_0.vehicle.usedpositions.size;
    var_3 = scripts\cp\cp_vehicles::puzzle_mark_complete(self, var_0.vehicle.stop_all_ascend_anims);

    if(isDefined(var_3))
      var_2 = var_3;

    if(var_0.vehicle.attachedguys.size >= var_2) {
      return 0;
      return;
    }

    return 1;
    return;
  } else
    return 1;
}

helidestroyvehiclestouchnotify(var_0, var_1, var_2) {
  if(isDefined(var_0.child_spawners) && var_0.child_spawners.size > 0)
    var_3 = var_0.child_spawners;
  else
    var_3 = getnodesinradiussorted(var_0.origin, 2048, 0, 256, "_encstr_B68E06D8F6B3CA27");

  var_4 = 1;
  var_5 = undefined;

  if(var_4) {
    var_5 = score_ai_spawns(var_3, undefined, 1, var_2, 1);
    self._id_127ED = undefined;
  }

  var_0 scripts\cp\cp_modular_spawning::set_default_spawner_values();
  var_0.totalscore = undefined;
  var_0.playercinematicfadeout = undefined;

  if(isDefined(var_5)) {
    _id_13075(var_0);
    var_0 thread scripts\cp\cp_modular_spawning::parent_spawner_disable_after_count(self, var_5);
  }

  return var_5;
}

cluster_spawnpoint_scoring(var_0, var_1, var_2, var_3) {
  if(calculate_ai_cluster_spawner_score(var_0, level.current_spawn_scoring_index))
    return var_0;
  else
    return undefined;
}

cluster_spawnpoint_valid(var_0, var_1) {
  if(istrue(var_1))
    return 0;
  else
    return 1;
}

standard_spawnpoint_scoring(var_0, var_1, var_2, var_3) {
  if(calculate_ai_spawner_score(var_0, level.current_spawn_scoring_index, var_1, var_3))
    return var_0;

  return undefined;
}

quickdropremoverespawntokenfrominventory() {
  if(isDefined(self._id_14288) && self._id_14288.size > 0)
    return self._id_14288;

  return [];
}

standard_spawnpoint_valid(var_0, var_1) {
  if(!var_0 scripts\cp\cp_modular_spawning::spawner_flags_check(32)) {
    var_2 = var_0.origin + (0, 0, 6);
    var_3 = scripts\engine\trace::capsule_trace_get_all_results(var_2, var_2 + (0, 0, 1), 16, 32, undefined, undefined, level.get_coverblown_alias);
    var_0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(32);

    if(isDefined(var_3) && isDefined(var_3[0])) {
      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        if(isDefined(var_3[var_4])) {
          var_5 = var_3[var_4];

          if(scripts\engine\utility::is_equal(var_5["_encstr_AA1C0886968EA32FE056"], "_encstr_9B0C0ED05AE8D15EC1B2F5BBBD93C632")) {
            var_0 scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
            return 0;
          }
        }
      }
    }
  }

  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = 0;

  if(isnode(var_0) && !var_0 nodeisactivated()) {
    barelem(var_8, "_encstr_8EF828B173F6130CC1FB333919799A4ABF743A9A41EF5F3A30BF06E57DB2D74FBE49B282481547F338F1", undefined, undefined, 1, var_0);
    var_0 scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
    return 0;
  }

  var_0 scripts\cp\cp_modular_spawning::spawner_init();

  if(!_id_13646(var_0))
    return 0;

  if(scripts\cp\cp_spawn_factor::critical_factor(::shot_start_offset, var_0)) {
    var_10 = 0;

    if(!var_10) {
      var_0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(64);
      var_0.lastspawntime = self.current_time + 10000;
    }
  } else
    var_0 scripts\cp\cp_modular_spawning::remove_from_spawner_flags(64);

  if(getdvarint("_encstr_B8EB1A5780D3FF93411F2DA777359AB79B18AFEB78883F994327365E", 1) && !istrue(var_0.script_forcespawn)) {
    var_11 = get_close_distance_var();

    if(!isDefined(var_0.script_parent)) {
      if(isDefined(var_0.script_dist_only))
        var_11 = var_0.script_dist_only;
    }

    var_12 = scripts\common\utility::playersincylinder(var_0.origin, var_11);

    if(var_12.size > 0) {
      if(isDefined(var_0.script_dist_only))
        var_0 thread scripts\cp\cp_modular_spawning::disable_spawn_point(var_0, undefined, self);
      else
        var_0.lastspawntime = self.current_time;

      return 0;
    }
  }

  if(isDefined(level._id_13648) && level._id_13648.size > 0) {
    var_13 = incrementpersistentstat(level._id_13648, var_0.origin, 5000);

    for(var_4 = 0; var_4 < var_13.size; var_4++) {
      if(distance2dsquared(var_0.origin, var_13[var_4].origin) < squared(var_13[var_4].radius)) {
        barelem(var_8, "_encstr_BA40174E97654354A9B1C0F88165C22AB18FF7E1CE88EB67E1", undefined, undefined, 1, var_0);
        return 0;
      }
    }
  }

  if(isDefined(self._id_127ED)) {
    var_14 = recentunresolvedcollision(var_0);
    var_15 = distancesquared(self._id_127ED, var_0.origin);
    var_11 = undefined;

    if(var_15 >= var_14) {
      barelem(var_8, "_encstr_887C16799886494A2A4A6814C47960E80145ED7B10190B39", undefined, undefined, 1, var_0);
      return 0;
    } else
      var_0.loopsound_origin = var_15;
  }

  return 1;
}

spawner_critical_factors(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  if(istrue(level.pause_spawner_scoring))
    return 0;
  else if(scripts\cp\cp_spawn_factor::critical_factor(::is_spawner_disabled, var_0))
    return 0;

  if(istrue(var_1)) {
    if(scripts\cp\cp_spawn_factor::critical_factor(::trial_target_follow_dummy, var_0))
      return 0;
    else if(istrue(var_0.is_on_platform) || isDefined(var_0.noteleport)) {
      if(istrue(var_0.is_on_platform)) {} else if(isDefined(var_0.noteleport)) {}

      return 0;
    } else if(scripts\cp\cp_spawn_factor::critical_factor(::is_valid_respawn_spawnpoint, var_0))
      return 0;
  }

  if(scripts\cp\cp_spawn_factor::critical_factor(::is_level_escalation_sufficient, var_0))
    return 0;
  else if(scripts\cp\cp_spawn_factor::critical_factor(::are_weapons_free, var_0))
    return 0;
  else if(!scripts\cp\cp_spawn_factor::critical_factor(scripts\cp\cp_spawn_factor::avoidtelefrag, var_0))
    return 0;
  else if(!scripts\cp\cp_spawn_factor::critical_factor(level.spawner_scoring_critical_factors[var_0 get_spawn_scoring_type()], var_0))
    return 0;
  else
    return 1;
}

get_spawn_scoring_type() {
  if(isDefined(self.spawner_flags)) {
    if(self.spawner_flags & 2)
      return "_encstr_847610EC5686D2C63659AFCD8358DD37AC39";
    else if(self.spawner_flags & 4)
      return "_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E";
    else
      return "_encstr_88201196333AF5A941D330F1CF88C10F329F8E";
  } else
    return "_encstr_88201196333AF5A941D330F1CF88C10F329F8E";
}

is_valid_respawn_spawnpoint(var_0) {
  var_1 = var_0 get_spawn_scoring_type();

  if(isDefined(var_1)) {
    switch (var_1) {
      case "_encstr_847610EC5686D2C63659AFCD8358DD37AC39":
        return 1;
      case "_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E":
        return 0;
      case "_encstr_88201196333AF5A941D330F1CF88C10F329F8E":
        return 0;
    }
  }

  return 0;
}

gate_flares_think(var_0) {
  if(isDefined(self.group) && isDefined(self.group._id_127ED)) {
    if(!self maymovefrompointtopoint(var_0.origin, self.group._id_127ED)) {
      level thread scripts\engine\utility::draw_capsule(var_0.origin, 16, 32, undefined, (1, 0, 0), undefined, 1000);
      var_0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(512);
      return 0;
    } else
      return 1;
  } else
    return 1;
}

shot_start_offset(var_0) {
  if(!istrue(var_0.script_forcespawn)) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(level.players[var_1] hastacvis(var_0.origin, 0, 64, 1))
        return 1;
    }
  }

  return 0;
}

is_level_escalation_sufficient(var_0) {
  if(isDefined(var_0.script_escalation_level) && isDefined(level.escalation_level)) {
    if(int(var_0.script_escalation_level) > int(level.escalation_level))
      return 1;
    else
      return 0;
  } else
    return 0;
}

are_weapons_free(var_0) {
  if(scripts\engine\utility::ent_flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && scripts\engine\utility::ent_flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0")) {
    if(isDefined(var_0.script_animation_type))
      return 1;
  }

  return 0;
}

trial_target_follow_dummy(var_0) {
  if(var_0 scripts\cp\cp_modular_spawning::spawner_flags_check(512))
    return 1;

  if(istrue(var_0.is_on_platform)) {
    var_0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(512);
    return 1;
  }

  var_1 = self._id_127ED;

  if(!isvector(var_1))
    var_1 = self._id_127ED.origin;

  if(!navtrace(var_0.origin, var_1)) {
    var_0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(512);
    return 1;
  }

  return 0;
}

is_spawner_disabled(var_0) {
  if(var_0 scripts\cp\cp_modular_spawning::spawner_flags_check(1024))
    return 1;
  else
    return 0;
}

score_factor_ai(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4))
    var_6 = [[var_1]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    var_6 = [[var_1]](var_2, var_3);
  else
    var_6 = [[var_1]](var_2);

  if(!isDefined(var_6))
    return undefined;

  if(!isDefined(var_5))
    var_5 = 1000;

  var_7 = var_5 * var_0;
  var_6 = clamp(var_6 * var_0, 0, var_7);
  return var_6;
}

get_best_scoring_target(var_0) {
  var_1 = get_spawn_scoring_array();
  var_2 = get_current_spawn_score_player_index(var_1, var_0);
  level.current_spawn_scoring_index = var_2;

  if(isDefined(level.current_spawn_scoring_index))
    return var_1[level.current_spawn_scoring_index];
  else
    return level.current_spawn_scoring_index;
}

get_score_target_override(var_0) {
  if(isDefined(level.stack_patch_waittill_leaf)) {
    if(scripts\engine\utility::array_contains(level.stack_patch_waittill_leaf, self.group_name))
      return undefined;
  }

  if(isDefined(level.spawn_scoring_pois) && level.spawn_scoring_pois.size > 0) {
    var_1 = undefined;

    if(level.spawn_scoring_pois.size > 1)
      var_2 = sortbydistance(level.spawn_scoring_pois, var_0);
    else
      var_2 = level.spawn_scoring_pois;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(distance2dsquared(var_0, var_2[var_3].origin) < var_2[var_3].activation_radius_sq)
        return var_2[var_3];
    }
  }

  return undefined;
}

get_score_target_pos(var_0) {
  if(isPlayer(var_0)) {
    if(isDefined(var_0.velo_forward) && var_0 _id_132E4())
      var_1 = var_0.velo_forward;
    else {
      var_2 = anglesToForward(var_0.angles);
      var_1 = var_0.origin + var_2 * 1024;
    }
  } else
    var_1 = var_0.origin;

  return var_1;
}

project_to_line(var_0, var_1, var_2) {
  if(!isarray(var_1))
    return var_1;

  if(isDefined(var_2))
    return incrementpersistentstat(var_1, var_0, var_2);

  return sortbydistance(var_1, var_0);
}

get_array_of_valid_spawnpoints(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 10;

  if(isarray(var_0)) {
    self._id_127ED = self.spawn_ref_point;
    var_0 = project_to_line(self._id_127ED, var_0);

    for(var_6 = 0; var_6 < var_0.size; var_6++) {
      var_7 = var_0[var_6];
      var_7 scripts\cp\cp_modular_spawning::spawner_init();

      if(spawner_critical_factors(var_7, var_1, var_3))
        var_4[var_4.size] = var_7;

      if(var_4.size >= var_5) {
        break;
      }
    }
  } else
    var_4[0] = var_0;

  return var_4;
}

get_current_spawn_score_player_index(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = get_spawn_scoring_array();

  var_2 = var_0.size;

  if(var_2 <= 1)
    return 0;

  var_3 = undefined;
  var_4 = scripts\engine\utility::array_sort_with_func(var_0, ::_id_134D0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];

    for(var_7 = 0; var_7 < 2; var_7++) {
      if(var_7 || istrue(var_6.spectating) && !istrue(var_6.inlaststand) && !istrue(var_6.ignoreme)) {
        for(var_8 = 0; var_8 < var_0.size; var_8++) {
          if(var_0[var_8] == var_6) {
            var_3 = var_8;

            if(isPlayer(var_6))
              self.cargo_truck_mg_init = var_3;
            else
              self.cargo_truck_mg_init = undefined;

            break;
          }
        }

        if(isDefined(var_3)) {
          break;
        }
      }
    }

    if(isDefined(var_3)) {
      break;
    }
  }

  if(!isDefined(var_3))
    return randomint(level.players.size);
  else
    return var_3;
}

get_next_player_index(var_0, var_1) {
  var_2 = get_spawn_scoring_array();
  var_3 = var_0;

  if(!istrue(var_1))
    var_3 = var_0 + 1;

  if(isDefined(var_2[var_3]))
    return var_3;
  else {
    var_3++;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      if(isDefined(var_2[var_3]))
        return var_3;

      if(var_3 >= var_2.size) {
        var_3 = 0;
        continue;
      }

      var_3++;
    }

    return 0;
  }
}

score_ai_spawns(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = get_best_scoring_target(var_4);
  self._id_133B8 = undefined;

  if(!isDefined(var_6))
    return undefined;

  if(istrue(self._id_1405A))
    var_1 = 1;

  self.current_time = gettime();
  var_7 = get_score_target_pos(var_6);
  var_8 = get_score_target_override(var_7);
  self.spawn_ref_point = var_7;
  self.spawn_ref_point_override = var_8;
  var_9 = get_array_of_valid_spawnpoints(var_0, var_1, undefined, var_3);

  if(var_9.size < 1)
    return undefined;

  self.current_time = gettime();
  var_10 = 1;

  if(var_10)
    var_11 = score_valid_spawnpoints(var_9, var_2, var_3, var_0);
  else
    var_11 = [var_9[0]];

  if(var_11.size < 1)
    return undefined;

  var_12 = undefined;

  if(var_11.size > 0)
    var_5 = var_11[randomint(var_11.size)];

  if(isDefined(var_5)) {
    if(var_5 passes_forward_check(self) && var_5 _id_121E8() && checkyellowmassacre(var_5)) {
      for(var_13 = 0; var_13 < var_9.size; var_13++) {
        if(var_5 != var_9[var_13])
          var_9[var_13] thread set_spawner_chosen_nearby();
      }

      return var_5;
    } else {
      var_14 = 10000;

      if(isDefined(level._id_12FC3))
        var_14 = level._id_12FC3;

      var_5.lastspawntime = self.current_time + var_14;
      level notify("_encstr_91211FC3101C11216F59BB70EA74EDE8CF631655275F0FC2372777D043AA9D5B53");
      return undefined;
    }
  } else {
    level notify("_encstr_91211FC3101C11216F59BB70EA74EDE8CF631655275F0FC2372777D043AA9D5B53");
    return undefined;
  }
}

_id_121E8() {
  return capsuletracepassed(self.origin + (0, 0, 6), 16, 32, undefined, 1, 1);
}

checkyellowmassacre(var_0) {
  if(istrue(level._id_133BD))
    return 1;

  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = level.players[var_4] quickdropremoverespawntokenfrominventory();

    if(isDefined(var_5) && var_5.size > 0) {
      for(var_6 = 0; var_6 < var_5.size; var_6++) {
        if(distance2dsquared(var_5[var_6], var_0.origin) <= 65536) {
          barelem(var_3, "_encstr_8D5F0F058D58BCAC3902D063B22C4ECA19", undefined, undefined, 1, var_0);
          return 0;
        }
      }
    }
  }

  return 1;
}

set_spawner_chosen_nearby() {
  self.spawner_chosen_nearby = 1;
  wait 2.5;
  self.spawner_chosen_nearby = undefined;
}

score_valid_spawnpoints(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = undefined;
  var_6 = 0;
  var_7 = [];
  var_8 = 0;
  var_9 = 1;

  for(var_10 = 0; var_10 < var_0.size; var_10++) {
    var_11 = var_0[var_10] get_spawn_scoring_type();

    if(isDefined(level._id_1364A[var_11]) && !level._id_1364A[var_11]) {
      var_9 = 0;
      break;
    }
  }

  for(var_10 = 0; var_10 < var_0.size; var_10++) {
    var_11 = var_0[var_10] get_spawn_scoring_type();
    var_12 = [[level.spawner_scoring_funcs[var_11]]](var_0[var_10], undefined, var_2, var_3);

    if(isDefined(var_12)) {
      if(!isDefined(var_5) || isDefined(var_6) && isDefined(var_12.totalscore) && var_12.totalscore > var_6) {
        var_5 = var_12;
        var_6 = var_12.totalscore;
      }

      var_8 = isDefined(var_12.playercinematicfadeout);

      if(var_8)
        var_7[var_7.size] = var_12;

      if(var_9 && var_12.totalscore >= 950.0) {
        if(!istrue(var_1))
          var_12.totalscore = undefined;

        return [var_12];
      } else if(var_12.totalscore > 500.0) {
        if(!var_8)
          var_4[var_4.size] = var_12;

        if(var_9) {
          if(istrue(var_1)) {
            if(var_4.size >= 5)
              return var_4;
          } else
            var_12.totalscore = undefined;
        }
      }
    }
  }

  if(var_7.size > 0) {
    var_13 = undefined;
    var_14 = -99999;
    var_15 = undefined;

    for(var_10 = 0; var_10 < var_7.size; var_10++) {
      var_16 = var_7[var_10];

      if(isDefined(var_16.totalscore) && var_16.totalscore > var_14) {
        var_14 = var_16.totalscore;
        var_13 = var_16;
        var_15 = var_16.playercinematicfadeout;
      }

      if(!istrue(var_1)) {
        var_16.totalscore = undefined;
        var_16.playercinematicfadeout = undefined;
      }
    }

    if(isDefined(var_13)) {
      var_17 = [[var_15]](var_13, undefined, var_2);

      if(isDefined(var_17)) {
        if(isarray(var_17)) {
          for(var_18 = 0; var_18 < var_17.size; var_18++) {
            if(var_17[var_18].totalscore > 500.0)
              var_4[var_4.size] = var_17[var_18];
          }
        } else if(var_17.totalscore > 500.0)
          var_4[var_4.size] = var_17;
      }
    }
  }

  if(var_4.size > 0)
    return var_4;
  else if(isDefined(var_5)) {
    var_11 = var_5 get_spawn_scoring_type();

    if(var_11 == "_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E")
      return [];
    else
      return [var_5];
  } else
    return [];
}

print_spawnpoint_debug(var_0, var_1, var_2) {
  self notify("_encstr_83151760C8BBC32D7E0AFB5A9750289F087D4381597BE9235F");
  self endon("_encstr_83151760C8BBC32D7E0AFB5A9750289F087D4381597BE9235F");
  var_3 = 16;
  var_4 = 16;
  var_5 = get_spawn_scoring_type();

  if(var_5 == "_encstr_847610EC5686D2C63659AFCD8358DD37AC39") {
    var_3 = 48;
    var_4 = 48;
  }

  if(istrue(level.spawnpoint_debug)) {
    if(isDefined(var_2))
      level waittill(var_2);

    level endon("_encstr_91211FC3101C11216F59BB70EA74EDE8CF631655275F0FC2372777D043AA9D5B53");
    level endon("_encstr_82F415A203F1B95F23668B6EC8B07C50EBB97285B0B7AA");

    for(;;) {
      thread scripts\engine\utility::draw_capsule(self.origin, var_3, var_4, (0, 0, 0), var_1, 0, 1);
      waitframe();
    }
  }
}

passes_forward_check(var_0) {
  if(isDefined(self) && !isvector(self)) {
    if(isDefined(self.script_dot)) {
      var_1 = int(self.script_dot) == 1;

      for(var_2 = 0; var_2 < level.players.size; var_2++) {
        if(scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(level.players[var_2].origin) == var_1) {
          if(isDefined(self.script_dist_only)) {
            if(distancesquared(level.players[var_2].origin, self.origin) <= int(self.script_dist_only)) {
              thread scripts\cp\cp_modular_spawning::disable_spawn_point(self, undefined, var_0);
              return 0;
            }
          } else {
            thread scripts\cp\cp_modular_spawning::disable_spawn_point(self, undefined, var_0);
            return 0;
          }
        }
      }
    } else if(isDefined(self.script_dist_only)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        if(distancesquared(level.players[var_3].origin, self.origin) <= int(self.script_dist_only)) {
          thread scripts\cp\cp_modular_spawning::disable_spawn_point(self, undefined, var_0);
          return 0;
        }
      }
    }
  }

  return 1;
}

calculate_ai_cluster_spawner_score(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.total_cluster_spawn_score;
  var_6 = 0;
  var_7 = 8;
  var_8 = score_factor_ai(var_7 / var_5, ::is_cluster_spawner_ideal_distance, var_0, var_1);

  if(!isDefined(var_8))
    return 0;

  var_6 = var_6 + var_8;
  var_9 = 5;
  var_10 = score_factor_ai(var_9 / var_5, ::is_spawner_towards_objective, var_0, var_1);

  if(!isDefined(var_10))
    return 0;

  var_6 = var_6 + var_10;
  var_0.totalscore = int(var_6);
  var_0.playercinematicfadeout = ::helidestroyvehiclestouchnotify;
  return 1;
}

calculate_ai_veh_spawner_score(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.total_veh_spawn_score;
  var_6 = 0;
  var_7 = 2;
  var_8 = score_factor_ai(var_7 / var_5, ::is_vehicle_spawner_ideal_distance, var_0, var_1, undefined, 1250);

  if(!isDefined(var_8))
    return 0;

  var_6 = var_6 + var_8;
  var_7 = 1;
  var_8 = score_factor_ai(var_7 / var_5, ::is_spawner_towards_objective, var_0, var_1);

  if(!isDefined(var_8))
    return 0;

  var_6 = var_6 + var_8;
  var_0.totalscore = int(var_6);
  return 1;
}

calculate_ai_spawner_score(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = level.total_spawn_score;
  var_8 = 0;
  var_9 = scripts\engine\utility::ter_op(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318", 5, 4);
  var_10 = score_factor_ai(var_9 / var_7, ::is_spawner_ideal_distance, var_0, var_1);

  if(!isDefined(var_10)) {
    if(istrue(var_2))
      var_10 = -10000;
    else
      return 0;
  }

  var_8 = var_8 + var_10;
  var_9 = scripts\engine\utility::ter_op(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318", 10, 4);
  var_10 = score_factor_ai(var_9 / var_7, ::avoid_recently_used_spawns, var_0);

  if(!isDefined(var_10)) {
    if(istrue(var_2))
      var_10 = -10000;
    else
      return 0;
  }

  var_8 = var_8 + var_10;
  var_9 = scripts\engine\utility::ter_op(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318", 10, 0);
  var_10 = score_factor_ai(var_9 / var_7, ::avoid_players_vision, var_0);

  if(!isDefined(var_10)) {
    if(istrue(var_2))
      var_10 = -10000;
    else
      return 0;
  }

  var_8 = var_8 + var_10;
  var_9 = 5;
  var_10 = score_factor_ai(var_9 / var_7, ::is_spawner_towards_objective, var_0, var_1);

  if(!isDefined(var_10)) {
    if(istrue(var_2))
      var_10 = -10000;
    else
      return 0;
  }

  var_8 = var_8 + var_10;
  var_9 = 5;
  var_10 = score_factor_ai(var_9 / var_7, ::_id_145A9, var_0);

  if(!isDefined(var_10))
    return 0;

  var_8 = var_8 + var_10;
  var_9 = 5;
  var_10 = score_factor_ai(var_9 / var_7, ::has_spawner_chosen_nearby_flag, var_0);

  if(!isDefined(var_10)) {
    if(istrue(var_2))
      var_10 = -10000;
    else
      return 0;
  }

  var_8 = var_8 + var_10;
  var_9 = 2;
  var_10 = score_factor_ai(var_9 / var_7, ::is_close_to_player_z, var_0, var_1);

  if(!isDefined(var_10)) {
    if(istrue(var_2))
      var_10 = -10000;
    else
      return 0;
  }

  var_8 = var_8 + var_10;
  var_0.totalscore = int(var_8);
  return 1;
}

is_close_to_player_z(var_0, var_1) {
  var_2 = level.players[var_1];

  if(isDefined(self.spawn_ref_point))
    var_3 = self.spawn_ref_point[2];
  else
    var_3 = var_2.origin[2];

  if(isvector(var_0))
    var_4 = int(abs(var_0[2] - var_3));
  else
    var_4 = int(abs(var_0.origin[2] - var_3));

  if(var_4 <= 128)
    return 1000;
  else
    return 1000 / int(var_4 / 32);
}

_id_12F0A(var_0, var_1, var_2, var_3) {
  var_4 = 1000;
  var_5 = 0.707;
  var_6 = -0.5;
  var_7 = var_4 * 0.5;
  var_8 = 0;
  var_9 = 1024;
  var_10 = 262144;
  var_11 = var_1 - var_0;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = length(var_11);

  if(var_12 > 0)
    var_11 = var_11 / var_12;

  var_13 = vectordot(var_2, var_11);

  if(var_12 > var_9) {
    self.brjugg_managedeliveries = 1;

    if(var_13 < var_8)
      return 0;
    else if(var_13 * var_3 > var_12)
      return 0;
    else if(var_13 < var_5) {
      var_14 = 1 - (var_5 - var_13) / (var_5 - var_8);
      return var_4 * var_14;
    } else
      return var_4;
  } else {
    self.brjugg_managedeliveries = 0;

    if(var_13 > var_8)
      return 0;
    else if(var_13 > var_6) {
      var_14 = 1 - (var_6 - var_13) / (var_6 - var_8);
      return var_4 * var_14;
    } else
      return var_4;
  }

  return 0;
}

is_spawner_towards_objective(var_0, var_1) {
  if(!isDefined(level.activequests) || level.activequests.size < 1) {
    self._id_133B8 = undefined;
    return 1000;
  } else {
    var_2 = level.players[var_1];
    var_3 = var_2.origin;
    var_4 = var_0.origin;
    var_5 = var_4 - var_3;
    var_5 = (var_5[0], var_5[1], 0);
    var_6 = length(var_5);

    if(var_6 > 0)
      var_5 = var_5 / var_6;

    var_7 = undefined;

    for(var_8 = 0; var_8 < level.activequests.size; var_8++) {
      var_9 = level.activequests[var_8];

      if(isDefined(var_9._id_11F8D) && var_9._id_11F8D.size > 0) {
        for(var_10 = 0; var_10 < var_9._id_11F8D.size; var_10++) {
          var_11 = var_9._id_11F8D[var_10];
          var_12 = _id_12F0A(var_3, var_11, var_5, var_6);

          if(!isDefined(var_7) || var_12 > var_7) {
            if(istrue(self.brjugg_managedeliveries))
              self._id_133B8 = 1;
            else
              self._id_133B8 = undefined;

            var_7 = var_12;
          }

          self.brjugg_managedeliveries = undefined;
        }
      }
    }

    if(isDefined(var_7))
      return var_7;
  }

  self._id_133B8 = undefined;
  return 1000;
}

has_spawner_chosen_nearby_flag(var_0) {
  if(istrue(var_0.spawner_chosen_nearby))
    return 1000;
  else
    return 0;
}

avoid_players_vision(var_0) {
  if(isDefined(var_0.script_parent) || istrue(var_0.script_forcespawn) || istrue(var_0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint()) || !isDefined(level.players) || level.players.size < 1)
    return 1000;

  var_1 = 1000 / level.players.size;
  var_2 = undefined;
  var_3 = quickdropcleanupcache();

  if(_id_12DDF(::_id_13682, 1, var_0)) {
    var_0.lastspawntime = self.current_time;
    return undefined;
  } else
    return var_1;
}

_id_132E4() {
  var_0 = self.velo_forward - self.origin;
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = length(var_0);

  if(var_1 > 0)
    return 1;
  else
    return 0;
}

_id_145A9(var_0, var_1) {
  var_2 = 1000;

  if(isDefined(var_0.script_parent) || istrue(var_0.script_forcespawn) || istrue(var_0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint()) || !isDefined(level.players) || istrue(self._id_133B8) || level.players.size < 1)
    return var_2;

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = quickdropcleanupcache();

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(isPlayer(var_6[var_7])) {
      var_8 = var_6[var_7] getplayerangles();

      if(isDefined(var_6[var_7].velo_forward) && var_6[var_7] _id_132E4())
        var_8 = vectortoangles(var_6[var_7].velo_forward - var_6[var_7].origin);

      var_3 = var_3 + scripts\engine\math::get_dot(var_6[var_7].origin, var_8, var_0.origin);
    } else {
      var_8 = var_6[var_7].angles;
      var_3 = var_3 + scripts\engine\math::get_dot(var_6[var_7].origin, var_8, var_0.origin);
    }

    var_5++;
  }

  if(var_5 == 0)
    return var_2;
  else {
    var_4 = var_3 / var_5;
    return var_2 * var_4;
  }
}

_id_12DDF(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = level.players[var_4][[var_0]](var_2, var_3);

    if(isDefined(var_1) && isDefined(var_5) && scripts\engine\utility::is_equal(var_1, var_5))
      return 1;
  }

  return 0;
}

_id_13682(var_0, var_1) {
  if(isPlayer(self) && !scripts\cp\utility::is_valid_player(1))
    return 0;

  var_2 = register_invalid_seats_for_module_by_seat();
  var_3 = self getEye();
  var_4 = var_0.origin + (0, 0, 56);
  var_5 = scripts\engine\utility::within_fov(var_3, var_2, var_4, cos(65)) && sighttracepassed(var_3, var_4, 0, undefined, 1);
  return var_5;
}

_id_12C5B(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_1[var_3].lastspawntime = var_2;
}

register_invalid_seats_for_module_by_seat() {
  return self getplayerangles();
}

is_vehicle_spawner_ideal_distance(var_0, var_1) {
  var_2 = level.players;
  var_3 = level.players[var_1];
  var_4 = var_3.origin;
  var_5 = 0;
  var_6 = 1250;
  var_7 = 1250;
  var_8 = 1562500;
  var_9 = 4000;
  var_10 = 16000000;
  var_11 = 30000;
  var_12 = 900000000;
  var_13 = 0.25;

  if(isDefined(var_0.script_maxdist)) {
    var_11 = int(var_0.script_maxdist);
    var_12 = squared(var_11);
  }

  var_14 = distancesquared(var_4, var_0.origin);

  if(var_14 >= var_12)
    return undefined;

  if(var_14 <= var_8)
    return var_6;
  else if(var_14 <= var_10) {
    var_15 = var_9 - var_7;
    var_16 = sqrt(var_14) - var_7;
    var_17 = 1 - var_16 / var_15;
    return var_6 * var_17;
  } else if(var_14 >= var_10) {
    var_15 = var_11 - var_9;
    var_16 = sqrt(var_14) - var_9;
    var_17 = 1 - var_16 / var_15;
    return var_6 * var_17 * var_13;
  }

  return var_5;
}

is_cluster_spawner_ideal_distance(var_0, var_1) {
  var_2 = level.players;

  if(isDefined(self.spawn_ref_point))
    var_3 = self.spawn_ref_point;
  else
    var_3 = scripts\cp\utility::get_center_point_of_array(var_2);

  var_4 = undefined;
  var_5 = 1024;
  var_6 = 1048576;
  var_7 = 0;
  var_8 = 1000 / level.players.size;
  var_9 = 20;
  var_10 = 4194304;
  var_11 = 2048;
  var_12 = 4096;
  var_13 = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    var_14 = level.spawn_scoring_overrides;
    var_5 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.close_dist, var_5);
    var_6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.close_dist_sq, var_6);
    var_9 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.far_score, var_9);
    var_10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.far_dist_sq, var_10);
    var_11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.far_dist, var_11);
    var_12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14._id_13BDB, var_12);
    var_13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.too_far_dist_sq, var_13);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    var_14 = self.spawn_scoring_overrides;
    var_5 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.close_dist, var_5);
    var_6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.close_dist_sq, var_6);
    var_9 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.far_score, var_9);
    var_10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.far_dist_sq, var_10);
    var_11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.far_dist, var_11);
    var_12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14._id_13BDB, var_12);
    var_13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_14.too_far_dist_sq, var_13);
  }

  var_15 = 0.5;

  if(isDefined(var_0.script_maxdist)) {
    var_12 = int(var_0.script_maxdist);
    var_13 = squared(var_12);
  }

  var_16 = distance2dsquared(var_3, var_0.origin);

  if(var_16 >= var_13)
    return undefined;
  else if(var_16 <= var_10 && var_16 >= var_6)
    var_4 = var_8;
  else if(var_16 >= var_10) {
    var_17 = 1 + var_16 / var_10;
    var_18 = var_9 / var_17;
    var_4 = var_18;
  } else {
    var_18 = var_8 * var_15;
    var_4 = var_18;
  }

  return var_4;
}

is_spawner_ideal_distance(var_0, var_1) {
  if(istrue(var_0.script_forcespawn))
    return 1000;

  var_2 = level.players;

  if(isDefined(self.spawn_ref_point))
    var_3 = self.spawn_ref_point;
  else
    var_3 = scripts\cp\utility::get_center_point_of_array(var_2);

  var_4 = level.players[var_1];
  var_5 = undefined;
  var_6 = 1024;
  var_7 = 1048576;
  var_8 = 0;
  var_9 = 1000 / level.players.size;
  var_10 = 20;
  var_11 = 4194304;
  var_12 = 2048;
  var_13 = 4096;
  var_14 = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    var_15 = level.spawn_scoring_overrides;
    var_6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.close_dist, var_6);
    var_7 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.close_dist_sq, var_7);
    var_10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.far_score, var_10);
    var_11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.far_dist_sq, var_11);
    var_12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.far_dist, var_12);
    var_13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15._id_13BDB, var_13);
    var_14 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.too_far_dist_sq, var_14);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    var_15 = self.spawn_scoring_overrides;
    var_6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.close_dist, var_6);
    var_7 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.close_dist_sq, var_7);
    var_10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.far_score, var_10);
    var_11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.far_dist_sq, var_11);
    var_12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.far_dist, var_12);
    var_13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15._id_13BDB, var_13);
    var_14 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_15.too_far_dist_sq, var_14);
  }

  var_16 = 0.5;

  if(isDefined(var_0.script_maxdist)) {
    var_13 = int(var_0.script_maxdist);
    var_14 = squared(var_13);
  }

  if(isDefined(var_13) && isDefined(var_0)) {
    var_17 = 0;

    if(isvector(var_0))
      var_17 = scripts\common\utility::playersnear(var_0, var_13);
    else
      var_17 = scripts\common\utility::playersnear(var_0.origin, var_13);

    if(var_17.size < 1)
      return undefined;
  }

  if(isDefined(var_0.ideal_dist)) {
    var_18 = var_0.ideal_dist;
    var_19 = var_0.ideal_dist * var_0.ideal_dist;
  } else {
    var_18 = (var_12 + var_6) / 2;
    var_19 = var_18 * var_18;
  }

  if(isDefined(var_0.loopsound_origin)) {
    var_20 = var_0.loopsound_origin;
    var_0.loopsound_origin = undefined;
  } else
    var_20 = distancesquared(var_3, var_0.origin);

  if(var_20 <= var_11 && var_20 >= var_7)
    return var_9;
  else if(var_20 >= var_11) {
    var_21 = 1 + var_20 / var_11;
    var_22 = var_10 / var_21;
    return var_22;
  } else {
    var_22 = var_9 * var_16;
    return var_22;
  }

  return var_8;
}

avoid_recently_used_spawns(var_0) {
  var_1 = 1000;

  if(isDefined(var_0.lastspawntime)) {
    var_2 = self.current_time - var_0.lastspawntime;
    var_3 = radialmonitor();

    if(var_2 > var_3)
      return var_1;

    var_4 = var_2 / var_3;
    return int(var_4 * var_1);
  }

  return var_1;
}

_id_13646(var_0, var_1) {
  if(!isDefined(var_0.lastspawntime)) {
    var_0.lastspawntime = self.current_time;
    return 1;
  }

  var_1 = self.current_time - var_0.lastspawntime;
  var_2 = radialmonitor();
  var_3 = var_1 / var_2;

  if(var_3 <= 0.5)
    return 0;
  else
    return 1;
}

radialmonitor() {
  if(isDefined(self._id_12A81))
    return self._id_12A81;
  else
    return 20000;
}

_id_134D0(var_0, var_1) {
  if(isDefined(var_0.cargo_truck_mg_gunnerdamagemodignorefunc) && isDefined(var_1.cargo_truck_mg_gunnerdamagemodignorefunc))
    return var_0.cargo_truck_mg_gunnerdamagemodignorefunc < var_1.cargo_truck_mg_gunnerdamagemodignorefunc;
  else
    return 0;
}

get_spawn_scoring_array() {
  if(isDefined(level.players) && level.players.size > 0)
    return scripts\cp\utility::get_array_of_valid_players();
  else
    return [];
}

get_close_distance_var(var_0) {
  var_1 = 1024;
  var_2 = 1048576;

  if(isDefined(self.spawn_scoring_overrides)) {
    if(istrue(var_0))
      return scripts\cp\cp_modular_spawning::define_var_if_undefined(self.spawn_scoring_overrides.close_dist_sq, var_2);
    else
      return scripts\cp\cp_modular_spawning::define_var_if_undefined(self.spawn_scoring_overrides.close_dist, var_1);
  } else if(isDefined(level.spawn_scoring_overrides)) {
    if(istrue(var_0))
      return scripts\cp\cp_modular_spawning::define_var_if_undefined(level.spawn_scoring_overrides.close_dist_sq, var_2);
    else
      return scripts\cp\cp_modular_spawning::define_var_if_undefined(level.spawn_scoring_overrides.close_dist, var_1);
  } else if(istrue(self.cqb_module)) {
    if(istrue(var_0))
      return 110889;
    else
      return 333;
  } else if(istrue(var_0))
    return var_2;
  else
    return var_1;
}

quickdropcleanupcache() {
  var_0 = level.players;
  return var_0;
}

_id_12891(var_0) {
  self._id_12F08 = undefined;
}

init_createfx(var_0, var_1) {
  if(getdvarint("_encstr_8E551ED07AD2EF3B9B01DC581D4B667F7E4250F8112AD9F0EF17E9C0F43F4807")) {
    var_2 = get_spawn_scoring_type();

    if(var_2 == "_encstr_847610EC5686D2C63659AFCD8358DD37AC39") {
      return;
    }
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);

    if(!isDefined(var_0._id_13643))
      var_0._id_13643 = [];

    var_0._id_13643[var_0._id_13643.size] = var_3;

    if(isDefined(self.angles))
      var_3.angles = self.angles;

    switch (var_2) {
      case "_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E":
        var_3 setModel("_encstr_8D9D0F8DDBD67DD1CA3246F27D4C2B8593");
        break;
      default:
        var_3 setModel("_encstr_951317DEBA8CD42FCFFCF7DAA7FB85D3B85F4BB88AA8984F30");
        break;
    }

    scripts\cp\cp_outline::enable_outline_for_players(var_3, level.players, var_1);
  }
}

barelem(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("_encstr_BE141D9B1B4EBE389396DC1D7DE61C2CEE7395397DB98DDB27567D4B9BCCDB", 0)) {
    if(isDefined(var_5)) {
      if(!isDefined(var_5._id_13EFB))
        previousplacements(var_5);

      var_6 = var_5._id_13EFB;
    } else
      var_6 = previousplacements();

    if(!isDefined(self._id_12F08))
      init_killstreak_data_for_challenges();

    self._id_12F09[var_6] = var_5;

    if(istrue(var_3) || !isDefined(var_0))
      var_0 = "_encstr_B40101";

    if(!isDefined(var_2))
      var_2 = "_encstr_B40101";

    if(!isDefined(var_1))
      var_1 = "_encstr_B40101";

    if(var_0.size > 0 || var_1.size > 0)
      var_1 = "_encstr_854C021F" + var_1;

    var_1 = var_0 + "_encstr_B60703498F" + var_1 + "_encstr_840703710E" + var_2;

    if(istrue(var_4))
      self._id_12F08[var_6] = var_1;

    return var_1;
  }
}

init_killstreak_data_for_challenges() {
  if(getdvarint("_encstr_BE141D9B1B4EBE389396DC1D7DE61C2CEE7395397DB98DDB27567D4B9BCCDB", 0)) {
    self._id_12F08 = [];
    self._id_12F09 = [];
    var_0 = self.group_name;

    if(!isDefined(var_0))
      var_0 = "_encstr_B40101";

    var_1 = "_encstr_85E624A61FE6727AD47B050F6AFE7A8EBA36B081764EBA820C530D0702C6A24612AE3839D9DA" + var_0 + "_encstr_B82222BCCD328A8C549154198A195419A264518C5419514651C8A29115C854648A468A91";
    barelem(undefined, var_1, undefined, undefined, 1);
  }
}

previousplacements(var_0) {
  if(!isDefined(self.current_uid))
    self.current_uid = 0;

  if(isDefined(var_0))
    var_0._id_13EFB = self.current_uid;

  var_1 = self.current_uid;
  self.current_uid++;
  return var_1;
}

redeployspawn() {
  if(isDefined(self._id_13EFB))
    return self._id_13EFB;
  else
    return undefined;
}

_id_13075(var_0) {
  if(getdvarint("_encstr_BE141D9B1B4EBE389396DC1D7DE61C2CEE7395397DB98DDB27567D4B9BCCDB", 0)) {
    var_1 = var_0 redeployspawn();
    var_0.grenade_exploded_during_stealth_listener = 1;

    if(isDefined(var_1)) {
      var_2 = self._id_12F08[var_1];

      if(isDefined(var_2)) {
        var_2 = "_encstr_A1C40B081D2724AFE268319A56" + var_2;
        self._id_12F08[var_1] = var_2;
      }
    }
  }
}

recentunresolvedcollision(var_0) {
  var_1 = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    var_2 = level.spawn_scoring_overrides;
    var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_2.too_far_dist_sq, var_1);
  } else if(isDefined(self.spawn_scoring_overrides)) {
    var_2 = self.spawn_scoring_overrides;
    var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_2.too_far_dist_sq, var_1);
  }

  if(isDefined(var_0.script_maxdist)) {
    var_3 = int(var_0.script_maxdist);
    var_1 = squared(var_3);
  }

  return var_1;
}