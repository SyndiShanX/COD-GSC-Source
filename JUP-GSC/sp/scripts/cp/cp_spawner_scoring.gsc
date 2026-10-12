/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawner_scoring.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_outline;
#using scripts\cp\cp_spawn_factor;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_spawner_scoring;

function spawner_scoring_init() {
  flag_init("spawn_point_score_data_init_done");
  level.current_spawn_scoring_index = 0;
  level.spawn_scoring_array = [];
  level.total_cluster_spawn_score = 13;
  level.total_veh_spawn_score = 3;
  level.total_spawn_score = 18;
  level.spawner_scoring_funcs = [];
  level.spawner_scoring_funcs["vehicle_spawner"] = &vehicle_spawnpoint_scoring;
  level.spawner_scoring_funcs["cluster_spawner"] = &cluster_spawnpoint_scoring;
  level.spawner_scoring_funcs["standard_spawner"] = &standard_spawnpoint_scoring;
  level.spawner_scoring_allow_early_out["cluster_spawner"] = 0;
  level.spawner_scoring_critical_factors = [];
  level.spawner_scoring_critical_factors["vehicle_spawner"] = &vehicle_spawnpoint_valid;
  level.spawner_scoring_critical_factors["cluster_spawner"] = &cluster_spawnpoint_valid;
  level.spawner_scoring_critical_factors["standard_spawner"] = &standard_spawnpoint_valid;
  level.capsule_contents = scripts\engine\trace::create_solid_ai_contents();

  setdvarifuninitialized(@ "hash_b050be7de75cd841", 0);
  setdvarifuninitialized(@ "hash_bf3eae56edffb7f", 0);
  setdvarifuninitialized(@ "hash_1a1d72de65f6faf8", 0);
  setdvarifuninitialized(@ "hash_df6e9696bdacd06b", 0);
  setdvarifuninitialized(@ "hash_97d7e5b326302869", 0);
  cmd = "<dev string:x1c>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x84>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x122>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x19a>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x1f4>";
  addentrytodevgui(cmd);
  createprintchannel("<dev string:x25b>");
}

function vehicle_spawnpoint_scoring(spawnpoint, debug, respawn_ent, spawnpoints) {
  if(calculate_ai_veh_spawner_score(spawnpoint, level.current_spawn_scoring_index)) {
    return spawnpoint;
  }

  return undefined;
}

function vehicle_spawnpoint_valid(spawnpoint, respawn) {
  if(istrue(respawn)) {
    return 0;
  }

  if(flag_exist("disable_vehicle_spawning") && flag("disable_vehicle_spawning")) {
    return 0;
  }

  if(isDefined(spawnpoint.vehicle) && isDefined(spawnpoint.vehicle.attachedguys) && isDefined(spawnpoint.vehicle.usedpositions)) {
    max_guys = spawnpoint.vehicle.usedpositions.size;
    override = scripts\cp\vehicles::get_max_ai_from_infil_name(self, spawnpoint.vehicle.infil_name);

    if(isDefined(override)) {
      max_guys = override;
    }

    if(spawnpoint.vehicle.attachedguys.size >= max_guys) {
      return 0;
    } else {
      return 1;
    }

    return;
  }

  return 1;
}

function cluster_child_spawnpoint_scoring(cluster_spawner, debug, respawn_ent) {
  if(isDefined(cluster_spawner.child_spawners) && cluster_spawner.child_spawners.size > 0) {
    var_fad1d4e8291840ec = cluster_spawner.child_spawners;
  } else {
    var_fad1d4e8291840ec = getnodesinradiussorted(cluster_spawner.origin, 2048, 0, 256, "cover");
  }

  normal_scoring = 1;
  spawnpoint = undefined;

  if(istrue(debug)) {
    normal_scoring = 0;
    spawnpoint = function_3e387272180982a5(var_fad1d4e8291840ec, 1, respawn_ent);
    self.position_ref = undefined;
  }

  if(normal_scoring) {
    spawnpoint = score_ai_spawns(var_fad1d4e8291840ec, undefined, 1, respawn_ent, 1);
    self.position_ref = undefined;
  }

  cluster_spawner scripts\cp\spawning::function_ec648f2c89ea1c91();
  cluster_spawner.totalscore = undefined;
  cluster_spawner.fnchildscorefunc = undefined;

  if(isDefined(spawnpoint)) {
    set_chosen_spawner_from_uid(cluster_spawner);
    cluster_spawner thread scripts\cp\spawning::parent_spawner_disable_after_count(self, spawnpoint);
  }

  return spawnpoint;
}

function cluster_spawnpoint_scoring(cluster_spawner, debug, respawn_ent, spawnpoints) {
  if(calculate_ai_cluster_spawner_score(cluster_spawner, level.current_spawn_scoring_index)) {
    return cluster_spawner;
  }

  return undefined;
}

function cluster_spawnpoint_valid(spawnpoint, respawn) {
  if(istrue(respawn)) {
    return 0;
  }

  return 1;
}

function standard_spawnpoint_scoring(spawnpoint, debug, respawn_ent, spawnpoints) {
  if(calculate_ai_spawner_score(spawnpoint, level.current_spawn_scoring_index, debug, spawnpoints)) {
    return spawnpoint;
  }

  return undefined;
}

function get_player_velo_array() {
  if(isDefined(self.velo_forward_memory) && self.velo_forward_memory.size > 0) {
    return self.velo_forward_memory;
  }

  return [];
}

function standard_spawnpoint_valid(spawnpoint, respawn) {
  if(!spawnpoint scripts\cp\spawning::spawner_flags_check(32)) {
    trace_pos = spawnpoint.origin + (0, 0, 6);
    trace_results = scripts\engine\trace::capsule_trace_get_all_results(trace_pos, trace_pos + (0, 0, 1), 16, 32, undefined, undefined, level.capsule_contents);
    spawnpoint scripts\cp\spawning::add_to_spawner_flags(32);

    if(isDefined(trace_results) && isDefined(trace_results[0])) {
      for(i = 0; i < trace_results.size; i++) {
        if(isDefined(trace_results[i])) {
          trace = trace_results[i];

          if(is_equal(trace["hittype"], "hittype_world")) {
            spawnpoint scripts\cp\spawning::disable_spawner();
            return false;
          }
        }
      }
    }
  }

  message = undefined;
  var_78babf35878bcd24 = undefined;
  failed_message = undefined;
  print_critical = 0;

  var_78babf35878bcd24 = "<dev string:x269>" + spawnpoint get_spawn_scoring_type() + "<dev string:x26c>" + spawnpoint.origin;
  failed_message = "<dev string:x26f>" + var_78babf35878bcd24;
  print_critical = getdvarint(@ "hash_df6e9696bdacd06b", 0);

  if(isnode(spawnpoint) && !spawnpoint nodeisactivated()) {
    add_to_score_message(failed_message, "^1CRITICAL^0: Node Spawner disconnected", undefined, undefined, 1, spawnpoint);
    spawnpoint scripts\cp\spawning::disable_spawner();
    return false;
  }

  spawnpoint scripts\cp\spawning::spawner_init();

  if(!spawner_invalid_due_to_recently_used(spawnpoint)) {
    if(print_critical) {
      if(spawnpoint scripts\cp\spawning::spawner_flags_check(64)) {
        add_to_score_message(failed_message, "<dev string:x27a>", undefined, undefined, 1, spawnpoint);
      } else {
        add_to_score_message(failed_message, "<dev string:x290>", undefined, undefined, 1, spawnpoint);
      }
    }

    return false;
  }

  if(critical_factor(&has_tac_vis, spawnpoint)) {
    skip = 0;

    if(getdvarint(@ "hash_97d7e5b326302869", 0)) {
      skip = 1;
    }

    if(!skip) {
      spawnpoint scripts\cp\spawning::add_to_spawner_flags(64);
      spawnpoint.lastspawntime = self.current_time + 10000;
    }
  } else {
    spawnpoint scripts\cp\spawning::remove_from_spawner_flags(64);
  }

  if(getdvarint(@ "hash_c2facf64f58f632b", 1) && !istrue(spawnpoint.script_forcespawn)) {
    dist = get_close_distance_var();

    if(!isDefined(spawnpoint.script_parent)) {
      if(isDefined(spawnpoint.script_dist_only)) {
        dist = spawnpoint.script_dist_only;
      }
    }

    nearby_players = utility::playersincylinder(spawnpoint.origin, dist);

    if(nearby_players.size > 0) {
      if(isDefined(spawnpoint.script_dist_only)) {
        spawnpoint thread scripts\cp\spawning::disable_spawn_point(spawnpoint, undefined, self);
      } else {
        spawnpoint.lastspawntime = self.current_time;
      }

      if(print_critical) {
        add_to_score_message(failed_message, "<dev string:x2ac>", undefined, undefined, 1, spawnpoint);
      }

      return false;
    }
  }

  if(isDefined(level.spawner_poison_structs) && level.spawner_poison_structs.size > 0) {
    poison_structs = sortbydistancecullbyradius(level.spawner_poison_structs, spawnpoint.origin, 5000);

    for(i = 0; i < poison_structs.size; i++) {
      if(distance2dsquared(spawnpoint.origin, poison_structs[i].origin) < squared(poison_structs[i].radius)) {
        add_to_score_message(failed_message, "^1CRITICAL^0: Poisoned", undefined, undefined, 1, spawnpoint);
        return false;
      }
    }
  }

  if(isDefined(self.position_ref)) {
    var_e5970392fa9be29c = get_too_far_dist_sq(spawnpoint);
    dist_sq = distancesquared(self.position_ref, spawnpoint.origin);
    dist = undefined;

    dist = sqrt(dist_sq);

    if(dist_sq >= var_e5970392fa9be29c) {
      spawnpoint.dist_sq_to_ref = dist_sq;

      add_to_score_message(failed_message, "^1CRITICAL^0: Too Far", undefined, undefined, 1, spawnpoint);
      return false;
    } else {
      spawnpoint.dist_sq_to_ref = dist_sq;
    }
  }

  return true;
}

function spawner_critical_factors(spawnpoint, respawn, respawn_ent) {
  message = undefined;
  var_78babf35878bcd24 = undefined;
  failed_message = undefined;
  print_critical = 0;

  var_78babf35878bcd24 = "<dev string:x269>" + spawnpoint get_spawn_scoring_type() + "<dev string:x26c>" + spawnpoint.origin;
  failed_message = "<dev string:x26f>" + var_78babf35878bcd24;
  print_critical = getdvarint(@ "hash_df6e9696bdacd06b", 0);

  if(istrue(level.pause_spawner_scoring)) {
    if(print_critical) {
      add_to_score_message(failed_message, "<dev string:x2c4>", undefined, undefined, 1, spawnpoint);
    }

    return 0;
  } else if(critical_factor(&is_spawner_disabled, spawnpoint)) {
    if(print_critical) {
      add_to_score_message(failed_message, "<dev string:x2d9>", undefined, undefined, 1, spawnpoint);
    }

    return 0;
  }

  if(istrue(respawn)) {
    if(critical_factor(&invalid_for_teleport, spawnpoint)) {
      if(print_critical) {
        add_to_score_message(failed_message, "<dev string:x2f0>", undefined, undefined, 1, spawnpoint);
      }

      return 0;
    } else if(istrue(spawnpoint.is_on_platform) || isDefined(spawnpoint.noteleport)) {
      if(istrue(spawnpoint.is_on_platform)) {
        if(print_critical) {
          add_to_score_message(failed_message, "<dev string:x30f>", undefined, undefined, 1, spawnpoint);
        }
      } else if(isDefined(spawnpoint.noteleport)) {
        if(print_critical) {
          add_to_score_message(failed_message, "<dev string:x329>", undefined, undefined, 1, spawnpoint);
        }
      }

      return 0;
    } else if(critical_factor(&is_valid_respawn_spawnpoint, spawnpoint)) {
      if(print_critical) {
        add_to_score_message(failed_message, "<dev string:x348>", undefined, undefined, 1, spawnpoint);
      }

      return 0;
    }
  }

  if(critical_factor(&is_level_escalation_sufficient, spawnpoint)) {
    if(print_critical) {
      add_to_score_message(failed_message, "<dev string:x368>", undefined, undefined, 1, spawnpoint);
    }

    return 0;
  }

  if(critical_factor(&are_weapons_free, spawnpoint)) {
    if(print_critical) {
      add_to_score_message(failed_message, "<dev string:x381>", undefined, undefined, 1, spawnpoint);
    }

    return 0;
  }

  if(!critical_factor(&avoidtelefrag, spawnpoint)) {
    if(print_critical) {
      add_to_score_message(failed_message, "<dev string:x3a7>", undefined, undefined, 1, spawnpoint);
    }

    return 0;
  }

  if(!critical_factor(level.spawner_scoring_critical_factors[spawnpoint get_spawn_scoring_type()], spawnpoint)) {
    return 0;
  }

  return 1;
}

function get_spawn_scoring_type() {
  if(isDefined(self.spawner_flags)) {
    if(self.spawner_flags & 2) {
      return "vehicle_spawner";
    } else if(self.spawner_flags & 4) {
      return "cluster_spawner";
    } else {
      return "standard_spawner";
    }

    return;
  }

  return "standard_spawner";
}

function is_valid_respawn_spawnpoint(spawnpoint) {
  spawner_type = spawnpoint get_spawn_scoring_type();

  if(isDefined(spawner_type)) {
    switch (spawner_type) {
      case #"hash_89eb9062c8daa874":
        return true;
      case #"hash_abe4b0e0b6ed2786":
        return false;
      case #"hash_e92af8a8ba9ca0df":
        return false;
    }
  }

  return false;
}

function can_path_to_target(spawnpoint) {
  if(isDefined(self.group) && isDefined(self.group.position_ref)) {
    if(!self maymovefrompointtopoint(spawnpoint.origin, self.group.position_ref)) {
      level thread draw_capsule(spawnpoint.origin, 16, 32, undefined, (1, 0, 0), undefined, 1000);
      spawnpoint scripts\cp\spawning::add_to_spawner_flags(512);
      return 0;
    } else {
      return 1;
    }

    return;
  }

  return 1;
}

function has_tac_vis(spawnpoint) {
  if(!istrue(spawnpoint.script_forcespawn)) {
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] hastacvis(spawnpoint.origin, 0, 64, 1)) {
        return true;
      }
    }
  }

  return false;
}

function is_level_escalation_sufficient(spawnpoint) {
  if(isDefined(spawnpoint.script_escalation_level) && isDefined(level.escalation_level)) {
    if(int(spawnpoint.script_escalation_level) > int(level.escalation_level)) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function are_weapons_free(spawnpoint) {
  if(ent_flag_exist("weapons_free") && ent_flag("weapons_free")) {
    if(isDefined(spawnpoint.script_animation_type)) {
      return true;
    }
  }

  return false;
}

function invalid_for_teleport(spawnpoint) {
  if(spawnpoint scripts\cp\spawning::spawner_flags_check(512)) {
    return true;
  }

  if(istrue(spawnpoint.is_on_platform)) {
    spawnpoint scripts\cp\spawning::add_to_spawner_flags(512);
    return true;
  }

  pos_ref = self.position_ref;

  if(!isvector(pos_ref)) {
    pos_ref = self.position_ref.origin;
  }

  if(!navtrace(spawnpoint.origin, pos_ref)) {
    spawnpoint scripts\cp\spawning::add_to_spawner_flags(512);
    return true;
  }

  return false;
}

function is_spawner_disabled(spawnpoint) {
  if(spawnpoint scripts\cp\spawning::spawner_flags_check(1024)) {
    return 1;
  }

  return 0;
}

function score_factor_ai(weight, var_e2cadc5bf4175e47, spawnpoint, var_394138cf0a48bdd1, var_394135cf0a48b738, max_score) {
  if(isDefined(var_394135cf0a48b738)) {
    scorefactor = [[var_e2cadc5bf4175e47]](spawnpoint, var_394138cf0a48bdd1, var_394135cf0a48b738);
  } else if(isDefined(var_394138cf0a48bdd1)) {
    scorefactor = [[var_e2cadc5bf4175e47]](spawnpoint, var_394138cf0a48bdd1);
  } else {
    scorefactor = [[var_e2cadc5bf4175e47]](spawnpoint);
  }

  if(!isDefined(scorefactor)) {
    return undefined;
  }

  if(!isDefined(max_score)) {
    max_score = 1000;
  }

  var_4ddb8606cd43d154 = max_score * weight;
  scorefactor = clamp(scorefactor * weight, 0, var_4ddb8606cd43d154);
  return scorefactor;
}

function get_best_scoring_target(var_bdf059129bdd23a3) {
  scoring_array = get_spawn_scoring_array();
  result = get_current_spawn_score_player_index(scoring_array, var_bdf059129bdd23a3);
  level.current_spawn_scoring_index = result;

  if(isDefined(level.current_spawn_scoring_index)) {
    return scoring_array[level.current_spawn_scoring_index];
  }

  return level.current_spawn_scoring_index;
}

function get_score_target_override(pos) {
  if(isDefined(level.ignore_spawn_scoring_pois)) {
    if(array_contains(level.ignore_spawn_scoring_pois, self.group_name)) {
      return undefined;
    }
  }

  if(isDefined(level.spawn_scoring_pois) && level.spawn_scoring_pois.size > 0) {
    poi = undefined;

    if(level.spawn_scoring_pois.size > 1) {
      var_a719fca40c4a6e2c = sortbydistance(level.spawn_scoring_pois, pos);
    } else {
      var_a719fca40c4a6e2c = level.spawn_scoring_pois;
    }

    for(i = 0; i < var_a719fca40c4a6e2c.size; i++) {
      if(distance2dsquared(pos, var_a719fca40c4a6e2c[i].origin) < var_a719fca40c4a6e2c[i].activation_radius_sq) {
        return var_a719fca40c4a6e2c[i];
      }
    }
  }

  return undefined;
}

function get_score_target_pos(score_target) {
  if(isPlayer(score_target)) {
    if(isDefined(score_target.velo_forward) && score_target should_use_velo_forward()) {
      pos = score_target.velo_forward;
    } else {
      forward = anglesToForward(score_target.angles);
      pos = score_target.origin + forward * 1024;
    }
  } else {
    pos = score_target.origin;
  }

  return pos;
}

function function_c0f307cf69beb25e(spawnpoints, validspawnpoints, respawn) {
  self notify("<dev string:x3c3>");
  self endon("<dev string:x3c3>");
  self endon("<dev string:x3e5>");
  level.players[0] endon("<dev string:x3eb>");
  level.players[0] endon("<dev string:x3f6>");
  level.players[0] notifyonplayercommand("<dev string:x3f6>", "<dev string:x3fa>");
  level.players[0] notifyonplayercommand("<dev string:x3f6>", "<dev string:x405>");

  if(!isDefined(level.spawner_model)) {
    level.spawner_model = spawn("<dev string:x40f>", (0, 0, 0));
  }

  last_spawner = undefined;
  new_spawner = 0;
  self.var_d2a78b73684031d9 = [];

  while(true) {
    validspawnpoints = [];

    for(i = 0; i < spawnpoints.size; i++) {
      if(level.players[0] within_fov(level.players[0] getEye(), level.players[0] getplayerangles(1), spawnpoints[i].origin, cos(55)) && spawner_critical_factors(spawnpoints[i], respawn)) {
        validspawnpoints[validspawnpoints.size] = spawnpoints[i];
      }
    }

    if(isDefined(validspawnpoints) && validspawnpoints.size > 0) {
      validspawnpoints = sortbydistance(validspawnpoints, level.players[0].origin);

      if(!isDefined(last_spawner)) {
        new_spawner = 1;
        last_spawner = validspawnpoints[0];
      } else if(!is_equal(validspawnpoints[0], last_spawner)) {
        new_spawner = 1;
        last_spawner = validspawnpoints[0];
      } else {
        new_spawner = 0;
      }

      if(new_spawner) {
        spawn_scoring_type = last_spawner get_spawn_scoring_type();
        level.spawner_model dontinterpolate();
        level.spawner_model.origin = last_spawner.origin;

        if(isDefined(last_spawner.angles)) {
          level.spawner_model.angles = last_spawner.angles;
        }

        switch (spawn_scoring_type) {
          case #"hash_89eb9062c8daa874":
            level.spawner_model setModel("<dev string:x42c>");
            break;
          case #"hash_abe4b0e0b6ed2786":
            level.spawner_model setModel("<dev string:x465>");
            break;
          default:
            level.spawner_model setModel("<dev string:x474>");
            break;
        }

        if(istrue(last_spawner.var_5c66d2472e564b8f)) {
          scripts\cp\cp_outline::enable_outline_for_players(level.spawner_model, level.players, "<dev string:x48b>");
        } else {
          scripts\cp\cp_outline::enable_outline_for_players(level.spawner_model, level.players, "<dev string:x49f>");
        }
      }

      self.var_d2a78b73684031d9 = [last_spawner];
    } else {
      scripts\cp\cp_outline::disable_outline_for_players(level.spawner_model, level.players);
      self.var_d2a78b73684031d9 = [];
      last_spawner = undefined;
      level.spawner_model setModel("<dev string:x4b5>");
      level.spawner_model dontinterpolate();
      level.spawner_model.origin = (0, 0, 0);
    }

    wait 0.1;
  }
}

function get_closest_spawns(origin, spawnpoints, radius) {
  if(!isarray(spawnpoints)) {
    return spawnpoints;
  }

  if(isDefined(radius)) {
    return sortbydistancecullbyradius(spawnpoints, origin, radius);
  }

  return sortbydistance(spawnpoints, origin);
}

function get_array_of_valid_spawnpoints(spawnpoints, respawn, debug, respawn_ent) {
  validspawnpoints = [];
  var_9bc1f4eb3b98248d = 10;

  if(istrue(debug)) {}

  if(getdvarint(@ "hash_97d7e5b326302869", 0)) {
    if(isDefined(self.spawn_ref_point_override)) {
      self.position_ref = self.spawn_ref_point_override;
    } else {
      self.position_ref = self.spawn_ref_point;
    }

    for(i = 0; i < spawnpoints.size; i++) {
      spawnpoints[i] scripts\cp\spawning::spawner_init();
    }

    validspawnpoints = function_c0f307cf69beb25e(spawnpoints, validspawnpoints, respawn);
    validspawnpoints = self.var_d2a78b73684031d9;
    self.var_d2a78b73684031d9 = undefined;
    self.spawn_ref_point_override = undefined;

    if(validspawnpoints.size > 0) {
      validspawnpoints[0].var_5c66d2472e564b8f = 1;
      return [validspawnpoints[0]];
    } else {
      return [];
    }
  }

  if(isarray(spawnpoints)) {
    self.position_ref = self.spawn_ref_point;
    spawnpoints = get_closest_spawns(self.position_ref, spawnpoints);

    for(i = 0; i < spawnpoints.size; i++) {
      spawnpoint = spawnpoints[i];
      spawnpoint scripts\cp\spawning::spawner_init();

      if(spawner_critical_factors(spawnpoint, respawn, respawn_ent)) {
        validspawnpoints[validspawnpoints.size] = spawnpoint;
      }

      if(validspawnpoints.size >= var_9bc1f4eb3b98248d) {
        break;
      }
    }
  } else {
    validspawnpoints[0] = spawnpoints;
  }

  return validspawnpoints;
}

function get_current_spawn_score_player_index(scoring_array, var_bdf059129bdd23a3) {
  if(!isDefined(scoring_array)) {
    scoring_array = get_spawn_scoring_array();
  }

  total_players = scoring_array.size;

  if(total_players <= 1) {
    return 0;
  }

  new_index = undefined;
  var_6686ffcf922e1b7c = array_sort_with_func(scoring_array, &sort_by_ai_assigned);

  for(i = 0; i < var_6686ffcf922e1b7c.size; i++) {
    player = var_6686ffcf922e1b7c[i];

    for(allow_invalid = 0; allow_invalid < 2; allow_invalid++) {
      if(allow_invalid || istrue(player.spectating) && !istrue(player.inlaststand) && !istrue(player.ignoreme)) {
        for(k = 0; k < scoring_array.size; k++) {
          if(scoring_array[k] == player) {
            new_index = k;

            if(isPlayer(player)) {
              self.assigned_ai_index = new_index;
            } else {
              self.assigned_ai_index = undefined;
            }

            break;
          }
        }

        if(isDefined(new_index)) {
          break;
        }
      }
    }

    if(isDefined(new_index)) {
      break;
    }
  }

  if(!isDefined(new_index)) {
    return randomint(level.players.size);
  }

  return new_index;
}

function get_next_player_index(index, var_bdf059129bdd23a3) {
  scoring_array = get_spawn_scoring_array();
  new_index = index;

  if(!istrue(var_bdf059129bdd23a3)) {
    new_index = index + 1;
  }

  if(isDefined(scoring_array[new_index])) {
    return new_index;
  }

  new_index++;

  for(num_checked = 0; num_checked < scoring_array.size; num_checked++) {
    if(isDefined(scoring_array[new_index])) {
      return new_index;
    }

    if(new_index >= scoring_array.size) {
      new_index = 0;
      continue;
    }

    new_index++;
  }

  return 0;
}

function score_ai_spawns(spawnpoints, respawn, var_c62b3b643f30bddf, respawn_ent, var_bdf059129bdd23a3) {
  bestspawn = undefined;
  score_target = get_best_scoring_target(var_bdf059129bdd23a3);
  self.skip_forward_score_factor = undefined;

  if(!isDefined(score_target)) {
    return undefined;
  }

  if(istrue(self.use_respawn_rules)) {
    respawn = 1;
  }

  self.current_time = gettime();
  score_target_pos = get_score_target_pos(score_target);
  score_target_override = get_score_target_override(score_target_pos);
  self.spawn_ref_point = score_target_pos;
  self.spawn_ref_point_override = score_target_override;
  valid_spawnpoints = get_array_of_valid_spawnpoints(spawnpoints, respawn, undefined, respawn_ent);

  if(valid_spawnpoints.size < 1) {
    return undefined;
  }

  self.current_time = gettime();
  var_6cb3b2286c446e9 = 1;

  if(getdvarint(@ "hash_97d7e5b326302869", 0)) {
    var_6cb3b2286c446e9 = 0;
  }

  if(var_6cb3b2286c446e9) {
    var_2d2ff52e5d86488d = score_valid_spawnpoints(valid_spawnpoints, var_c62b3b643f30bddf, respawn_ent, spawnpoints);
  } else {
    var_2d2ff52e5d86488d = [valid_spawnpoints[0]];
  }

  if(var_2d2ff52e5d86488d.size < 1) {
    return undefined;
  }

  random_num = undefined;

  if(var_2d2ff52e5d86488d.size > 0) {
    bestspawn = var_2d2ff52e5d86488d[randomint(var_2d2ff52e5d86488d.size)];
  }

  if(isDefined(bestspawn)) {
    if(istrue(bestspawn.script_forcespawn) || bestspawn passes_forward_check(self) && bestspawn passes_final_capsule_check() && avoids_recently_cleared_area(bestspawn)) {
      return bestspawn;
    } else {
      added_time = 10000;

      if(isDefined(level.seen_recently_spawner_time)) {
        added_time = level.seen_recently_spawner_time;
      }

      bestspawn.lastspawntime = self.current_time + added_time;
      level notify("update_spawnpoint_debug_prints");
      return undefined;
    }

    return;
  }

  level notify("update_spawnpoint_debug_prints");
  return undefined;
}

function passes_final_capsule_check() {
  return capsuletracepassed(self.origin + (0, 0, 6), 16, 32, undefined, 1, 1);
}

function avoids_recently_cleared_area(spawnpoint) {
  if(istrue(level.skip_player_pos_memory)) {
    return true;
  }

  message = undefined;
  var_78babf35878bcd24 = undefined;
  failed_message = undefined;

  var_78babf35878bcd24 = "<dev string:x269>" + spawnpoint get_spawn_scoring_type() + "<dev string:x26c>" + spawnpoint.origin;
  failed_message = "<dev string:x26f>" + var_78babf35878bcd24;

  for(i = 0; i < level.players.size; i++) {
    array = level.players[i] get_player_velo_array();

    if(isDefined(array) && array.size > 0) {
      for(j = 0; j < array.size; j++) {
        if(distance2dsquared(array[j], spawnpoint.origin) <= 65536) {
          add_to_score_message(failed_message, "Player Cleared", undefined, undefined, 1, spawnpoint);
          return false;
        }
      }
    }
  }

  return true;
}

function set_spawner_chosen_nearby() {
  self.spawner_chosen_nearby = 1;
  wait 2.5;
  self.spawner_chosen_nearby = undefined;
}

function score_valid_spawnpoints(valid_spawnpoints, var_c62b3b643f30bddf, respawn_ent, spawnpoints) {
  var_2d2ff52e5d86488d = [];
  bestspawn = undefined;
  bestspawn_score = 0;
  var_27e45d4285530c95 = [];
  var_e97bd95f1f9771e1 = 0;
  var_23ffd71550b6dc5f = 1;

  for(i = 0; i < valid_spawnpoints.size; i++) {
    spawn_scoring_type = valid_spawnpoints[i] get_spawn_scoring_type();

    if(isDefined(level.spawner_scoring_allow_early_out[spawn_scoring_type]) && !level.spawner_scoring_allow_early_out[spawn_scoring_type]) {
      var_23ffd71550b6dc5f = 0;
      break;
    }
  }

  for(i = 0; i < valid_spawnpoints.size; i++) {
    spawn_scoring_type = valid_spawnpoints[i] get_spawn_scoring_type();
    result = [[level.spawner_scoring_funcs[spawn_scoring_type]]](valid_spawnpoints[i], undefined, respawn_ent, spawnpoints);

    if(isDefined(result)) {
      if(!isDefined(bestspawn) || isDefined(bestspawn_score) && isDefined(result.totalscore) && result.totalscore > bestspawn_score) {
        bestspawn = result;
        bestspawn_score = result.totalscore;
      }

      var_e97bd95f1f9771e1 = isDefined(result.fnchildscorefunc);

      if(var_e97bd95f1f9771e1) {
        var_27e45d4285530c95[var_27e45d4285530c95.size] = result;
      }

      if(var_23ffd71550b6dc5f && result.totalscore >= 950) {
        if(!istrue(var_c62b3b643f30bddf)) {
          result.totalscore = undefined;
        }

        return [result];
      }

      if(result.totalscore > 500) {
        if(!var_e97bd95f1f9771e1) {
          var_2d2ff52e5d86488d[var_2d2ff52e5d86488d.size] = result;
        }

        if(var_23ffd71550b6dc5f) {
          if(istrue(var_c62b3b643f30bddf)) {
            if(var_2d2ff52e5d86488d.size >= 5) {
              return var_2d2ff52e5d86488d;
            }

            continue;
          }

          result.totalscore = undefined;
        }
      }
    }
  }

  if(var_27e45d4285530c95.size > 0) {
    var_dfdb346fd48d6faf = undefined;
    bestscore = -99999;
    var_35ea3cd053db31f = undefined;

    for(i = 0; i < var_27e45d4285530c95.size; i++) {
      var_70159d1f6cc7b7fd = var_27e45d4285530c95[i];

      if(isDefined(var_70159d1f6cc7b7fd.totalscore) && var_70159d1f6cc7b7fd.totalscore > bestscore) {
        bestscore = var_70159d1f6cc7b7fd.totalscore;
        var_dfdb346fd48d6faf = var_70159d1f6cc7b7fd;
        var_35ea3cd053db31f = var_70159d1f6cc7b7fd.fnchildscorefunc;
      }

      if(!istrue(var_c62b3b643f30bddf)) {
        var_70159d1f6cc7b7fd.totalscore = undefined;
        var_70159d1f6cc7b7fd.fnchildscorefunc = undefined;
      }
    }

    if(isDefined(var_dfdb346fd48d6faf)) {
      var_168e835cf3a0dff0 = [[var_35ea3cd053db31f]](var_dfdb346fd48d6faf, undefined, respawn_ent);

      if(isDefined(var_168e835cf3a0dff0)) {
        if(isarray(var_168e835cf3a0dff0)) {
          for(var_1d86078f33bafc19 = 0; var_1d86078f33bafc19 < var_168e835cf3a0dff0.size; var_1d86078f33bafc19++) {
            if(var_168e835cf3a0dff0[var_1d86078f33bafc19].totalscore > 500) {
              var_2d2ff52e5d86488d[var_2d2ff52e5d86488d.size] = var_168e835cf3a0dff0[var_1d86078f33bafc19];
            }
          }
        } else if(var_168e835cf3a0dff0.totalscore > 500) {
          var_2d2ff52e5d86488d[var_2d2ff52e5d86488d.size] = var_168e835cf3a0dff0;
        }
      }
    }
  }

  if(var_2d2ff52e5d86488d.size > 0) {
    return var_2d2ff52e5d86488d;
  }

  if(isDefined(bestspawn)) {
    spawn_scoring_type = bestspawn get_spawn_scoring_type();

    if(spawn_scoring_type == "cluster_spawner") {
      return [];
    } else {
      return [bestspawn];
    }

    return;
  }

  return [];
}

function print_spawnpoint_debug(reason, color, waittill_notify) {
  self notify("print_spawnpoint_debug");
  self endon("print_spawnpoint_debug");
  radius = 16;
  height = 16;
  spawn_scoring_type = get_spawn_scoring_type();

  if(spawn_scoring_type == "vehicle_spawner") {
    radius = 48;
    height = 48;
  }

  if(istrue(level.spawnpoint_debug)) {
    if(isDefined(waittill_notify)) {
      level waittill(waittill_notify);
    }

    level endon("update_spawnpoint_debug_prints");
    level endon("end_spawnpoint_debug");

    while(true) {
      print3d(self.origin, spawn_scoring_type + "<dev string:x4c0>" + reason, color, 1, 1, 1, 0);

      thread draw_capsule(self.origin, radius, height, (0, 0, 0), color, 0, 1);
      waitframe();
    }
  }
}

function passes_forward_check(group_struct) {
  if(isDefined(self) && !isvector(self)) {
    if(isDefined(self.script_dot)) {
      compare = int(self.script_dot) == 1;

      for(j = 0; j < level.players.size; j++) {
        if(scripts\cp\cp_spawning_util::cp_is_point_in_front(level.players[j].origin) == compare) {
          if(isDefined(self.script_dist_only)) {
            if(distancesquared(level.players[j].origin, self.origin) <= int(self.script_dist_only)) {
              thread scripts\cp\spawning::disable_spawn_point(self, undefined, group_struct);
              return false;
            }

            continue;
          }

          thread scripts\cp\spawning::disable_spawn_point(self, undefined, group_struct);
          return false;
        }
      }
    } else if(isDefined(self.script_dist_only)) {
      for(p = 0; p < level.players.size; p++) {
        if(distancesquared(level.players[p].origin, self.origin) <= int(self.script_dist_only)) {
          thread scripts\cp\spawning::disable_spawn_point(self, undefined, group_struct);
          return false;
        }
      }
    }
  }

  return true;
}

function calculate_ai_cluster_spawner_score(spawnpoint, player_index) {
  message = undefined;
  var_78babf35878bcd24 = undefined;
  failed_message = undefined;

  var_78babf35878bcd24 = "<dev string:x269>" + spawnpoint get_spawn_scoring_type() + "<dev string:x26c>" + spawnpoint.origin;
  failed_message = "<dev string:x26f>" + var_78babf35878bcd24;
  message = add_to_score_message(var_78babf35878bcd24, undefined, undefined, 0, 0, spawnpoint);

  totalscore = level.total_cluster_spawn_score;
  finalscore = 0;
  weight = 8;
  scorefactor = score_factor_ai(weight / totalscore, &is_cluster_spawner_ideal_distance, spawnpoint, player_index);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x4c4>", undefined, undefined, 1, spawnpoint);

    return false;
  }

  message = add_to_score_message(message, "<dev string:x4cd>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  var_2653f927df4a0bf4 = 5;
  var_8766534be41302a9 = score_factor_ai(var_2653f927df4a0bf4 / totalscore, &is_spawner_towards_objective, spawnpoint, player_index);

  if(!isDefined(var_8766534be41302a9)) {
    message = add_to_score_message(failed_message, "<dev string:x4d8>", undefined, undefined, 1, spawnpoint);

    return false;
  }

  message = add_to_score_message(message, "<dev string:x4ea>", var_8766534be41302a9, 0, 0, spawnpoint);

  finalscore += var_8766534be41302a9;

  message = add_to_score_message(message, "<dev string:x4fe>", "<dev string:x508>" + finalscore, 0, 1, spawnpoint);

  spawnpoint.totalscore = int(finalscore);
  spawnpoint.fnchildscorefunc = &cluster_child_spawnpoint_scoring;
  return true;
}

function calculate_ai_veh_spawner_score(spawnpoint, player_index) {
  message = undefined;
  var_78babf35878bcd24 = undefined;
  failed_message = undefined;

  var_78babf35878bcd24 = "<dev string:x269>" + spawnpoint get_spawn_scoring_type() + "<dev string:x26c>" + spawnpoint.origin;
  failed_message = "<dev string:x26f>" + var_78babf35878bcd24;
  message = add_to_score_message(var_78babf35878bcd24, undefined, undefined, 0, 0, spawnpoint);

  totalscore = level.total_veh_spawn_score;
  finalscore = 0;
  weight = 2;
  scorefactor = score_factor_ai(weight / totalscore, &is_vehicle_spawner_ideal_distance, spawnpoint, player_index, undefined, 1250);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x4c4>", undefined, undefined, 1, spawnpoint);

    return false;
  }

  message = add_to_score_message(message, "<dev string:x4cd>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  weight = 1;
  scorefactor = score_factor_ai(weight / totalscore, &is_spawner_towards_objective, spawnpoint, player_index);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x4d8>", undefined, undefined, 1, spawnpoint);

    return false;
  }

  finalscore += scorefactor;

  message = add_to_score_message(message, "<dev string:x4ea>", scorefactor, 0, 0, spawnpoint);

  spawnpoint.totalscore = int(finalscore);

  message = add_to_score_message(message, "<dev string:x4fe>", "<dev string:x508>" + finalscore, 0, 1, spawnpoint);

  return true;
}

function calculate_ai_spawner_score(spawnpoint, player_index, debug, spawnpoints) {
  message = undefined;
  var_78babf35878bcd24 = undefined;
  failed_message = undefined;

  var_78babf35878bcd24 = "<dev string:x269>" + spawnpoint get_spawn_scoring_type() + "<dev string:x26c>" + spawnpoint.origin;
  failed_message = "<dev string:x26f>" + var_78babf35878bcd24;
  message = add_to_score_message(var_78babf35878bcd24, undefined, undefined, 0, 0, spawnpoint);

  totalscore = level.total_spawn_score;
  finalscore = 0;
  weight = 4;
  scorefactor = score_factor_ai(weight / totalscore, &is_spawner_ideal_distance, spawnpoint, player_index);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x4c4>", undefined, undefined, 1, spawnpoint);

    if(istrue(debug)) {
      scorefactor = -10000;
    } else {
      return false;
    }
  }

  message = add_to_score_message(message, "<dev string:x4cd>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  weight = 4;
  scorefactor = score_factor_ai(weight / totalscore, &avoid_recently_used_spawns, spawnpoint);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x50b>", undefined, undefined, 1, spawnpoint);

    if(istrue(debug)) {
      scorefactor = -10000;
    } else {
      return false;
    }
  }

  message = add_to_score_message(message, "<dev string:x519>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  weight = 0;
  scorefactor = score_factor_ai(weight / totalscore, &avoid_players_vision, spawnpoint);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x529>", undefined, undefined, 1, spawnpoint);

    if(istrue(debug)) {
      scorefactor = -10000;
    } else {
      return false;
    }
  }

  message = add_to_score_message(message, "<dev string:x530>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  weight = 5;
  scorefactor = score_factor_ai(weight / totalscore, &is_spawner_towards_objective, spawnpoint, player_index);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x4d8>", undefined, undefined, 1, spawnpoint);

    if(istrue(debug)) {
      scorefactor = -10000;
    } else {
      return false;
    }
  }

  message = add_to_score_message(message, "<dev string:x4ea>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  weight = 5;
  scorefactor = score_factor_ai(weight / totalscore, &weight_spawners_closest_to_forward, spawnpoint);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x539>", undefined, undefined, 1, spawnpoint);

    return false;
  }

  message = add_to_score_message(message, "<dev string:x541>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  weight = 5;
  scorefactor = score_factor_ai(weight / totalscore, &has_spawner_chosen_nearby_flag, spawnpoint);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x54b>", undefined, undefined, 1, spawnpoint);

    if(istrue(debug)) {
      scorefactor = -10000;
    } else {
      return false;
    }
  }

  message = add_to_score_message(message, "<dev string:x552>", scorefactor, 0, 0, spawnpoint);

  finalscore += scorefactor;
  weight = 2;
  scorefactor = score_factor_ai(weight / totalscore, &is_close_to_player_z, spawnpoint, player_index);

  if(!isDefined(scorefactor)) {
    message = add_to_score_message(failed_message, "<dev string:x562>", undefined, undefined, 1, spawnpoint);

    if(istrue(debug)) {
      scorefactor = -10000;
    } else {
      return false;
    }
  }

  finalscore += scorefactor;

  message = add_to_score_message(message, "<dev string:x56a>", scorefactor, 0, 0, spawnpoint);
  message = add_to_score_message(message, "<dev string:x4fe>", "<dev string:x508>" + finalscore, 0, 1, spawnpoint);

  spawnpoint.totalscore = int(finalscore);
  return true;
}

function is_close_to_player_z(spawnpoint, player_index) {
  player = level.players[player_index];

  if(isDefined(level.var_d9821974c80a684a)) {
    player = random(level.var_d9821974c80a684a);
  }

  if(isDefined(self.spawn_ref_point)) {
    ref_point = self.spawn_ref_point[2];
  } else {
    ref_point = player.origin[2];
  }

  if(isvector(spawnpoint)) {
    z_diff = int(abs(spawnpoint[2] - ref_point));
  } else {
    z_diff = int(abs(spawnpoint.origin[2] - ref_point));
  }

  if(z_diff <= 128) {
    return 1000;
  }

  return 1000 / int(z_diff / 32);
}

function score_spawner_relative_to_objective(refpos, objpos, var_1f810c7df46ffb0e, var_a299bae2b12aa472) {
  bestscore = 1000;
  bestdot = 0.707;
  var_935ba925e6fc497c = -0.5;
  var_38f868494486fd60 = bestscore * 0.5;
  var_244a6693d35086e1 = 0;
  var_528c2ba90b381005 = 1024;
  var_88a5204c5dee932e = 262144;
  var_e1f1195815227fe0 = objpos - refpos;
  var_e1f1195815227fe0 = (var_e1f1195815227fe0[0], var_e1f1195815227fe0[1], 0);
  var_f0fd166c750fac7c = length(var_e1f1195815227fe0);

  if(var_f0fd166c750fac7c > 0) {
    var_e1f1195815227fe0 /= var_f0fd166c750fac7c;
  }

  dot = vectordot(var_1f810c7df46ffb0e, var_e1f1195815227fe0);

  if(var_f0fd166c750fac7c > var_528c2ba90b381005) {
    self.allow_forward_factor = 1;

    if(dot < var_244a6693d35086e1) {
      return 0;
    } else if(dot * var_a299bae2b12aa472 > var_f0fd166c750fac7c) {
      return 0;
    } else if(dot < bestdot) {
      f = 1 - (bestdot - dot) / (bestdot - var_244a6693d35086e1);
      return (bestscore * f);
    } else {
      return bestscore;
    }
  } else {
    self.allow_forward_factor = 0;

    if(dot > var_244a6693d35086e1) {
      return 0;
    } else if(dot > var_935ba925e6fc497c) {
      f = 1 - (var_935ba925e6fc497c - dot) / (var_935ba925e6fc497c - var_244a6693d35086e1);
      return (bestscore * f);
    } else {
      return bestscore;
    }
  }

  return 0;
}

function is_spawner_towards_objective(spawnpoint, player_index) {
  if(!isDefined(level.activequests) || level.activequests.size < 1) {
    self.skip_forward_score_factor = undefined;
    return 1000;
  } else {
    player = level.players[player_index];

    if(isDefined(level.var_d9821974c80a684a)) {
      player = random(level.var_d9821974c80a684a);
    }

    ref_point = player.origin;
    spawnpoint_pos = spawnpoint.origin;
    var_17756a44a05002de = spawnpoint_pos - ref_point;
    var_17756a44a05002de = (var_17756a44a05002de[0], var_17756a44a05002de[1], 0);
    var_311c45d876a94904 = length(var_17756a44a05002de);

    if(var_311c45d876a94904 > 0) {
      var_17756a44a05002de /= var_311c45d876a94904;
    }

    bestscore = undefined;

    for(i = 0; i < level.activequests.size; i++) {
      quest = level.activequests[i];

      if(isDefined(quest.objectivelocations) && quest.objectivelocations.size > 0) {
        for(j = 0; j < quest.objectivelocations.size; j++) {
          var_3ed87ea90882333 = quest.objectivelocations[j];
          score = score_spawner_relative_to_objective(ref_point, var_3ed87ea90882333, var_17756a44a05002de, var_311c45d876a94904);

          if(!isDefined(bestscore) || score > bestscore) {
            if(istrue(self.allow_forward_factor)) {
              self.skip_forward_score_factor = 1;
            } else {
              self.skip_forward_score_factor = undefined;
            }

            bestscore = score;
          }

          self.allow_forward_factor = undefined;
        }
      }
    }

    if(isDefined(bestscore)) {
      return bestscore;
    }
  }

  self.skip_forward_score_factor = undefined;
  return 1000;
}

function has_spawner_chosen_nearby_flag(spawnpoint) {
  if(istrue(spawnpoint.spawner_chosen_nearby)) {
    return 1000;
  }

  return 0;
}

function avoid_players_vision(spawnpoint) {
  if(isDefined(spawnpoint.script_parent) || istrue(spawnpoint.script_forcespawn) || istrue(spawnpoint scripts\cp\vehicles::is_vehicle_spawnpoint()) || !isDefined(level.players) || level.players.size < 1) {
    return 1000;
  }

  max_score = 1000 / level.players.size;
  var_4f86bf5be5e42647 = undefined;
  player_array = get_player_array();

  if(run_func_on_each_player(&spawnpoint_is_within_sight, 1, spawnpoint)) {
    spawnpoint.var_52b39a5c627585de = 1;

    spawnpoint.lastspawntime = self.current_time;
    return undefined;
  }

  spawnpoint.var_52b39a5c627585de = undefined;

  return max_score;
}

function should_use_velo_forward() {
  var_dd6fbb1ff2a513c9 = self.velo_forward - self.origin;
  var_dd6fbb1ff2a513c9 = (var_dd6fbb1ff2a513c9[0], var_dd6fbb1ff2a513c9[1], 0);
  var_13b97a8da9dfea88 = length(var_dd6fbb1ff2a513c9);

  if(var_13b97a8da9dfea88 > 0) {
    return 1;
  }

  return 0;
}

function weight_spawners_closest_to_forward(spawnpoint, spawnpoints) {
  max_score = 1000;

  if(isDefined(spawnpoint.script_parent) || istrue(spawnpoint.script_forcespawn) || istrue(spawnpoint scripts\cp\vehicles::is_vehicle_spawnpoint()) || !isDefined(level.players) || istrue(self.skip_forward_score_factor) || level.players.size < 1) {
    return max_score;
  }

  cumulative_dot = 0;
  average_dot = 0;
  dot_count = 0;
  player_array = get_player_array();

  for(i = 0; i < player_array.size; i++) {
    if(isPlayer(player_array[i])) {
      angles = player_array[i] getplayerangles();

      if(isDefined(player_array[i].velo_forward) && player_array[i] should_use_velo_forward()) {
        angles = vectortoangles(player_array[i].velo_forward - player_array[i].origin);
      }

      cumulative_dot += math::get_dot(player_array[i].origin, angles, spawnpoint.origin);
    } else {
      angles = player_array[i].angles;
      cumulative_dot += math::get_dot(player_array[i].origin, angles, spawnpoint.origin);
    }

    dot_count++;
  }

  if(dot_count == 0) {
    return max_score;
  }

  average_dot = cumulative_dot / dot_count;
  return max_score * average_dot;
}

function run_func_on_each_player(func, return_bool, optional_param1, optional_param2) {
  for(i = 0; i < level.players.size; i++) {
    bool = level.players[i][[func]](optional_param1, optional_param2);

    if(isDefined(return_bool) && isDefined(bool) && is_equal(return_bool, bool)) {
      return true;
    }
  }

  return false;
}

function spawnpoint_is_within_sight(spawnpoint, optional_param2) {
  if(isPlayer(self) && !is_valid_player(1)) {
    return 0;
  }

  angles = get_within_sight_angles();
  trace_start = self getEye();
  var_c869f57096afa5ee = spawnpoint.origin + (0, 0, 56);
  trace_results = within_fov(trace_start, angles, var_c869f57096afa5ee, cos(65)) && sighttracepassed(trace_start, var_c869f57096afa5ee, 0, undefined, 1);
  return trace_results;
}

function reset_nearby_spawn_times(spawnpoint, spawnpoints, time) {
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i].lastspawntime = time;
  }
}

function get_within_sight_angles() {
  return self getplayerangles();
}

function is_vehicle_spawner_ideal_distance(spawnpoint, player_index) {
  player_array = level.players;

  if(isDefined(level.var_d9821974c80a684a)) {
    player_array = level.var_d9821974c80a684a;
  }

  player = level.players[player_index];

  if(isDefined(level.var_d9821974c80a684a)) {
    player = random(level.var_d9821974c80a684a);
  }

  ref_point = player.origin;
  min_score = 0;
  max_score = 1250;
  close_dist = 1250;
  close_dist_sq = 1562500;
  far_dist = 4000;
  far_dist_sq = 16000000;
  too_far_dist = 30000;
  too_far_dist_sq = 900000000;
  var_e20df67bc043c785 = 0.25;

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  var_58e1b8850df3b5c4 = distancesquared(ref_point, spawnpoint.origin);

  if(var_58e1b8850df3b5c4 >= too_far_dist_sq) {
    return undefined;
  }

  if(var_58e1b8850df3b5c4 <= close_dist_sq) {
    return max_score;
  } else if(var_58e1b8850df3b5c4 <= far_dist_sq) {
    dist_delta = far_dist - close_dist;
    start_dist = sqrt(var_58e1b8850df3b5c4) - close_dist;
    var_a61f687a770146f2 = 1 - start_dist / dist_delta;
    return (max_score * var_a61f687a770146f2);
  } else if(var_58e1b8850df3b5c4 >= far_dist_sq) {
    dist_delta = too_far_dist - far_dist;
    start_dist = sqrt(var_58e1b8850df3b5c4) - far_dist;
    var_a61f687a770146f2 = 1 - start_dist / dist_delta;
    return (max_score * var_a61f687a770146f2 * var_e20df67bc043c785);
  }

  return min_score;
}

function is_cluster_spawner_ideal_distance(spawnpoint, player_index) {
  player_array = level.players;

  if(isDefined(level.var_d9821974c80a684a)) {
    player_array = level.var_d9821974c80a684a;
  }

  if(isDefined(self.spawn_ref_point)) {
    ref_point = self.spawn_ref_point;
  } else {
    ref_point = get_center_point_of_array(player_array);
  }

  var_4f86bf5be5e42647 = undefined;
  close_dist = 1024;
  close_dist_sq = 1048576;
  min_score = 0;
  max_score = 1000 / level.players.size;
  far_score = 20;
  far_dist_sq = 4194304;
  far_dist = 2048;
  too_far_dist = 4096;
  too_far_dist_sq = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    data = level.spawn_scoring_overrides;
    close_dist = scripts\cp\spawning::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = scripts\cp\spawning::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = scripts\cp\spawning::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    data = self.spawn_scoring_overrides;
    close_dist = scripts\cp\spawning::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = scripts\cp\spawning::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = scripts\cp\spawning::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  var_e20df67bc043c785 = 0.5;

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  var_58e1b8850df3b5c4 = distance2dsquared(ref_point, spawnpoint.origin);

  if(var_58e1b8850df3b5c4 >= too_far_dist_sq) {
    return undefined;
  } else if(var_58e1b8850df3b5c4 <= far_dist_sq && var_58e1b8850df3b5c4 >= close_dist_sq) {
    var_4f86bf5be5e42647 = max_score;
  } else if(var_58e1b8850df3b5c4 >= far_dist_sq) {
    multiplier = 1 + var_58e1b8850df3b5c4 / far_dist_sq;
    var_8586cacb3696dfe5 = far_score / multiplier;
    var_4f86bf5be5e42647 = var_8586cacb3696dfe5;
  } else {
    var_8586cacb3696dfe5 = max_score * var_e20df67bc043c785;
    var_4f86bf5be5e42647 = var_8586cacb3696dfe5;
  }

  return var_4f86bf5be5e42647;
}

function is_spawner_ideal_distance(spawnpoint, player_index) {
  if(istrue(spawnpoint.script_forcespawn)) {
    return 1000;
  }

  player_array = level.players;

  if(isDefined(level.var_d9821974c80a684a)) {
    player_array = level.var_d9821974c80a684a;
  }

  if(isDefined(self.spawn_ref_point)) {
    ref_point = self.spawn_ref_point;
  } else {
    ref_point = get_center_point_of_array(player_array);
  }

  player = level.players[player_index];

  if(isDefined(level.var_d9821974c80a684a)) {
    player = random(level.var_d9821974c80a684a);
  }

  var_4f86bf5be5e42647 = undefined;
  close_dist = 1024;
  close_dist_sq = 1048576;
  min_score = 0;
  max_score = 1000 / level.players.size;
  far_score = 20;
  far_dist_sq = 4194304;
  far_dist = 2048;
  too_far_dist = 4096;
  too_far_dist_sq = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    data = level.spawn_scoring_overrides;
    close_dist = scripts\cp\spawning::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = scripts\cp\spawning::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = scripts\cp\spawning::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    data = self.spawn_scoring_overrides;
    close_dist = scripts\cp\spawning::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = scripts\cp\spawning::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = scripts\cp\spawning::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  var_e20df67bc043c785 = 0.5;

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  if(isDefined(too_far_dist) && isDefined(spawnpoint)) {
    near_players = 0;

    if(isvector(spawnpoint)) {
      near_players = utility::playersnear(spawnpoint, too_far_dist);
    } else {
      near_players = utility::playersnear(spawnpoint.origin, too_far_dist);
    }

    if(near_players.size < 1) {
      return undefined;
    }
  }

  if(isDefined(spawnpoint.ideal_dist)) {
    p_dist = spawnpoint.ideal_dist;
    p_dist_sq = spawnpoint.ideal_dist * spawnpoint.ideal_dist;
  } else {
    p_dist = (far_dist + close_dist) / 2;
    p_dist_sq = p_dist * p_dist;
  }

  if(isDefined(spawnpoint.dist_sq_to_ref)) {
    var_58e1b8850df3b5c4 = spawnpoint.dist_sq_to_ref;
    spawnpoint.dist_sq_to_ref = undefined;
  } else {
    var_58e1b8850df3b5c4 = distancesquared(ref_point, spawnpoint.origin);
  }

  if(var_58e1b8850df3b5c4 <= far_dist_sq && var_58e1b8850df3b5c4 >= close_dist_sq) {
    return max_score;
  } else if(var_58e1b8850df3b5c4 >= far_dist_sq) {
    multiplier = 1 + var_58e1b8850df3b5c4 / far_dist_sq;
    var_8586cacb3696dfe5 = far_score / multiplier;
    return var_8586cacb3696dfe5;
  } else {
    var_8586cacb3696dfe5 = max_score * var_e20df67bc043c785;
    return var_8586cacb3696dfe5;
  }

  return min_score;
}

function avoid_recently_used_spawns(spawnpoint) {
  max_score = 1000;

  if(isDefined(spawnpoint.lastspawntime)) {
    timepassed = self.current_time - spawnpoint.lastspawntime;
    spawn_time_threshold = get_recent_spawn_time_threshold();

    if(timepassed > spawn_time_threshold) {
      return max_score;
    }

    var_4fee9fdc7bb80a41 = timepassed / spawn_time_threshold;

    return int(var_4fee9fdc7bb80a41 * max_score);
  }

  return max_score;
}

function spawner_invalid_due_to_recently_used(spawnpoint, timepassed) {
  if(!isDefined(spawnpoint.lastspawntime)) {
    spawnpoint.lastspawntime = self.current_time;
    return 1;
  }

  timepassed = self.current_time - spawnpoint.lastspawntime;
  spawn_time_threshold = get_recent_spawn_time_threshold();
  var_4fee9fdc7bb80a41 = timepassed / spawn_time_threshold;

  if(var_4fee9fdc7bb80a41 <= 0.5) {
    return 0;
  }

  return 1;
}

function get_recent_spawn_time_threshold() {
  if(isDefined(self.recent_spawn_threshold)) {
    return self.recent_spawn_threshold;
  }

  return 20000;
}

function sort_by_ai_assigned(a, b) {
  if(isDefined(a.assigned_ai) && isDefined(b.assigned_ai)) {
    return (a.assigned_ai < b.assigned_ai);
  }

  return 0;
}

function get_spawn_scoring_array() {
  if(isDefined(level.spawn_scoring_array) && level.spawn_scoring_array.size > 0) {
    return level.spawn_scoring_array;
  }

  if(isDefined(level.players) && level.players.size > 0) {
    return scripts\cp\utility::get_array_of_valid_players();
  }

  return [];
}

function get_close_distance_var(return_sq) {
  close_dist = 1024;
  close_dist_sq = 1048576;

  if(isDefined(self.spawn_scoring_overrides)) {
    if(istrue(return_sq)) {
      return scripts\cp\spawning::define_var_if_undefined(self.spawn_scoring_overrides.close_dist_sq, close_dist_sq);
    } else {
      return scripts\cp\spawning::define_var_if_undefined(self.spawn_scoring_overrides.close_dist, close_dist);
    }

    return;
  }

  if(isDefined(level.spawn_scoring_overrides)) {
    if(istrue(return_sq)) {
      return scripts\cp\spawning::define_var_if_undefined(level.spawn_scoring_overrides.close_dist_sq, close_dist_sq);
    } else {
      return scripts\cp\spawning::define_var_if_undefined(level.spawn_scoring_overrides.close_dist, close_dist);
    }

    return;
  }

  if(istrue(self.cqb_module)) {
    if(istrue(return_sq)) {
      return 110889;
    } else {
      return 333;
    }

    return;
  }

  if(istrue(return_sq)) {
    return close_dist_sq;
  }

  return close_dist;
}

function get_player_array() {
  player_array = level.players;

  if(isDefined(level.var_d9821974c80a684a)) {
    player_array = level.var_d9821974c80a684a;
  }

  return player_array;
}

function function_3e387272180982a5(spawnpoints, respawn, var_c62b3b643f30bddf) {
  bestspawn = undefined;
  score_target = get_best_scoring_target();

  if(!isDefined(score_target)) {
    return undefined;
  }

  self.current_time = gettime();
  score_target_pos = get_score_target_pos(score_target);
  score_target_override = get_score_target_override(score_target_pos);
  self.spawn_ref_point = score_target_pos;
  self.spawn_ref_point_override = score_target_override;
  valid_spawnpoints = get_array_of_valid_spawnpoints(spawnpoints, respawn, 1);

  if(valid_spawnpoints.size < 1) {
    return undefined;
  }

  self.current_time = gettime();
  var_2d2ff52e5d86488d = function_b7d0a51460fc8fb3(valid_spawnpoints, var_c62b3b643f30bddf);

  if(var_2d2ff52e5d86488d.size < 1) {
    return undefined;
  }

  random_num = undefined;

  if(var_2d2ff52e5d86488d.size > 0) {
    bestspawn = var_2d2ff52e5d86488d[randomint(var_2d2ff52e5d86488d.size)];
  }

  if(isDefined(bestspawn)) {
    if(bestspawn passes_forward_check(self)) {
      for(i = 0; i < valid_spawnpoints.size; i++) {
        if(bestspawn != valid_spawnpoints[i]) {
          valid_spawnpoints[i] thread set_spawner_chosen_nearby();
        }
      }

      return bestspawn;
    } else {
      level notify("<dev string:x5bc>");
      return undefined;
    }

    return;
  }

  level notify("<dev string:x5bc>");
  return undefined;
}

function function_b7d0a51460fc8fb3(valid_spawnpoints, var_c62b3b643f30bddf) {
  var_2d2ff52e5d86488d = [];
  bestspawn = undefined;
  bestspawn_score = 0;

  for(i = 0; i < valid_spawnpoints.size; i++) {
    spawn_scoring_type = valid_spawnpoints[i] get_spawn_scoring_type();
    result = [[level.spawner_scoring_funcs[spawn_scoring_type]]](valid_spawnpoints[i], 1);

    if(isDefined(result) && !isDefined(result.spawner_debug_model)) {
      spawner_model = spawn("<dev string:x40f>", result.origin);
      spawn_scoring_type = result get_spawn_scoring_type();

      switch (spawn_scoring_type) {
        case #"hash_89eb9062c8daa874":
          spawner_model setModel("<dev string:x42c>");
          break;
        case #"hash_abe4b0e0b6ed2786":
          spawner_model setModel("<dev string:x465>");
          break;
        default:
          spawner_model setModel("<dev string:x474>");
          break;
      }

      if(isDefined(result.angles)) {
        spawner_model.angles = result.angles;
      }

      level.spawner_models[level.spawner_models.size] = spawner_model;
      result.spawner_debug_model = spawner_model;
      spawner_model.spawnpoint = result;
    }

    if(isDefined(result)) {
      result thread function_a4b51254c3c4dcc("<dev string:x5db>" + level.var_2e35b31b262b1d57 + 1);

      if(!isDefined(bestspawn) || isDefined(bestspawn_score) && isDefined(result.totalscore) && result.totalscore > bestspawn_score) {
        bestspawn = result;
        bestspawn_score = result.totalscore;
      }

      if(result.totalscore >= 750) {
        var_2d2ff52e5d86488d[var_2d2ff52e5d86488d.size] = result;
      }
    }
  }

  if(istrue(var_c62b3b643f30bddf)) {
    level notify("<dev string:x5db>" + level.var_2e35b31b262b1d57);
    level.var_2e35b31b262b1d57++;
  }

  if(var_2d2ff52e5d86488d.size > 0) {
    return var_2d2ff52e5d86488d;
  }

  if(isDefined(bestspawn)) {
    return [bestspawn];
  }

  return [];
}

function function_a4b51254c3c4dcc(waittill_notify) {
  self notify("<dev string:x5ef>");
  self endon("<dev string:x5ef>");
  level waittill_any_2(waittill_notify, "<dev string:x616>");

  if(isDefined(self.spawner_debug_model)) {
    if(array_contains(level.spawner_models, self.spawner_debug_model)) {
      level.spawner_models = array_remove(level.spawner_models, self.spawner_debug_model);
    }

    self.spawner_debug_model delete();
    self.spawner_debug_model = undefined;
  }

  self.totalscore = undefined;
}

function print_spawner_score_for_factor(spawnpoint) {
  if(isDefined(self.spawner_debug_model)) {
    for(i = 0; i < self.spawner_debug_model.size; i++) {
      if(isDefined(self.spawner_debug_model[i])) {
        self.spawner_debug_model[i] delete();
      }
    }
  }

  if(getdvarint(@ "hash_b050be7de75cd841", 0)) {
    if(isDefined(self.score_message)) {
      if(self.score_message.size > 1) {
        setprintchannel("<dev string:x25b>");
        chosen = undefined;

        if(isDefined(spawnpoint)) {
          set_chosen_spawner_from_uid(spawnpoint);

          if(isDefined(spawnpoint.uid)) {
            chosen = spawnpoint.uid;
          }
        }

        group_name = self.group_name;

        if(!isDefined(group_name)) {
          group_name = "<dev string:x62b>";
        }

        msg = "<dev string:x62c>" + group_name + "<dev string:x650>";
        add_to_score_message(undefined, msg, undefined, undefined, 1);
        keys = getarraykeys(self.score_message);
        last = getlastarraykey(self.score_message);

        for(i = 0; i < keys.size; i++) {
          if(isDefined(last) && keys[i] == last) {
            stop_here = 1;
          }

          if(isDefined(chosen)) {
            if(i >= keys.size - 1) {
              if(isDefined(self.score_message[chosen])) {
                if(isDefined(self.score_message_spawners[chosen])) {
                  self.score_message_spawners[chosen] create_debug_model_for_spawnpoint(self, "<dev string:x49f>");
                  self.score_message_spawners[chosen].chosen = undefined;
                }

                print(self.score_message[chosen] + "<dev string:x672>");
                chosen = undefined;
              }
            } else if(is_equal(chosen, keys[i])) {
              continue;
            }
          }

          if(isDefined(self.score_message[keys[i]])) {
            if(isDefined(self.score_message_spawners[keys[i]])) {
              if(istrue(self.score_message_spawners[keys[i]].chosen)) {
                self.score_message_spawners[keys[i]] create_debug_model_for_spawnpoint(self, "<dev string:x674>");
              } else {
                self.score_message_spawners[keys[i]] create_debug_model_for_spawnpoint(self, "<dev string:x689>");
              }

              self.score_message_spawners[keys[i]].chosen = undefined;
            }

            print(i + "<dev string:x69b>" + self.score_message[keys[i]] + "<dev string:x672>");
          }
        }
      }
    }
  }

  self.score_message = undefined;
}

function create_debug_model_for_spawnpoint(group, color) {
  if(getdvarint(@ "hash_bf3eae56edffb7f")) {
    spawn_scoring_type = get_spawn_scoring_type();

    if(spawn_scoring_type == "vehicle_spawner") {
      return;
    }

    spawner_model = spawn("script_model", self.origin);

    if(!isDefined(group.spawner_debug_model)) {
      group.spawner_debug_model = [];
    }

    group.spawner_debug_model[group.spawner_debug_model.size] = spawner_model;

    if(isDefined(self.angles)) {
      spawner_model.angles = self.angles;
    }

    switch (spawn_scoring_type) {
      case #"hash_abe4b0e0b6ed2786":
        spawner_model setModel("com_teddy_bear");
        break;
      default:
        spawner_model setModel("british_pilot_fullbody");
        break;
    }

    scripts\cp\cp_outline::enable_outline_for_players(spawner_model, level.players, color);
  }
}

function add_to_score_message(starting_message, message, scorefactor, override, should_add, spawnpoint) {
  if(getdvarint(@ "hash_b050be7de75cd841", 0)) {
    if(isDefined(spawnpoint)) {
      if(!isDefined(spawnpoint.uid)) {
        get_available_unique_id(spawnpoint);
      }

      uid = spawnpoint.uid;
    } else {
      uid = get_available_unique_id();
    }

    if(!isDefined(self.score_message)) {
      create_score_message();
    }

    self.score_message_spawners[uid] = spawnpoint;

    if(istrue(override) || !isDefined(starting_message)) {
      starting_message = "";
    }

    if(!isDefined(scorefactor)) {
      scorefactor = "";
    }

    if(!isDefined(message)) {
      message = "";
    }

    if(starting_message.size > 0 || message.size > 0) {
      message = "|" + message;
    }

    message = starting_message + "^0" + message + "^5" + scorefactor;

    if(istrue(should_add)) {
      self.score_message[uid] = message;
    }

    return message;
  }
}

function create_score_message() {
  if(getdvarint(@ "hash_b050be7de75cd841", 0)) {
    self.score_message = [];
    self.score_message_spawners = [];
    group_name = self.group_name;

    if(!isDefined(group_name)) {
      group_name = "";
    }

    msg = "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#^0" + group_name + "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#";
    add_to_score_message(undefined, msg, undefined, undefined, 1);
  }
}

function get_available_unique_id(spawnpoint) {
  if(!isDefined(self.current_uid)) {
    self.current_uid = 0;
  }

  if(isDefined(spawnpoint)) {
    spawnpoint.uid = self.current_uid;
  }

  return_id = self.current_uid;
  self.current_uid++;
  return return_id;
}

function get_unique_id() {
  if(isDefined(self.uid)) {
    return self.uid;
  }

  return undefined;
}

function set_chosen_spawner_from_uid(spawnpoint) {
  if(getdvarint(@ "hash_b050be7de75cd841", 0)) {
    uid = spawnpoint get_unique_id();
    spawnpoint.chosen = 1;

    if(isDefined(uid)) {
      msg = self.score_message[uid];

      if(isDefined(msg)) {
        msg = "^5CHOSEN: " + msg;
        self.score_message[uid] = msg;
      }
    }
  }
}

function get_too_far_dist_sq(spawnpoint) {
  too_far_dist_sq = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    data = level.spawn_scoring_overrides;
    too_far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  } else if(isDefined(self.spawn_scoring_overrides)) {
    data = self.spawn_scoring_overrides;
    too_far_dist_sq = scripts\cp\spawning::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  return too_far_dist_sq;
}