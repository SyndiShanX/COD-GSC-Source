/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawner_scoring.gsc
***********************************************/

function spawner_scoring_init() {
  scripts\engine\utility::flag_init("spawn_point_score_data_init_done");
  level.current_spawn_scoring_index = 0;
  level.spawn_scoring_array = [];
  level.total_cluster_spawn_score = 13;
  level.total_veh_spawn_score = 3;
  level.total_spawn_score = 18;
  level.spawner_scoring_funcs = [];
  level.spawner_scoring_funcs["vehicle_spawner"] = &vehicle_spawnpoint_scoring;
  level.spawner_scoring_funcs["cluster_spawner"] = &cluster_spawnpoint_scoring;
  level.spawner_scoring_funcs["standard_spawner"] = &standard_spawnpoint_scoring;
  level.ref_1364a["cluster_spawner"] = 0;
  level.spawner_scoring_critical_factors = [];
  level.spawner_scoring_critical_factors["vehicle_spawner"] = &vehicle_spawnpoint_valid;
  level.spawner_scoring_critical_factors["cluster_spawner"] = &cluster_spawnpoint_valid;
  level.spawner_scoring_critical_factors["standard_spawner"] = &standard_spawnpoint_valid;
  level.get_coverblown_alias = scripts\engine\trace::create_solid_ai_contents();
}

function vehicle_spawnpoint_scoring(var0, var1, var2, var3) {
  if(calculate_ai_veh_spawner_score(var0, level.current_spawn_scoring_index)) {
    return var0;
  }

  return undefined;
}

function vehicle_spawnpoint_valid(var0, var1) {
  if(istrue(var1)) {
    return 0;
  }

  if(scripts\engine\utility::flag_exist("disable_vehicle_spawning") && scripts\engine\utility::flag("disable_vehicle_spawning")) {
    return 0;
  }

  if(isDefined(var0.vehicle) && isDefined(var0.vehicle.attachedguys) && isDefined(var0.vehicle.usedpositions)) {
    var2 = var0.vehicle.usedpositions.size;
    var3 = scripts\cp\cp_vehicles::puzzle_mark_complete(self, var0.vehicle.stop_all_ascend_anims);

    if(isDefined(var3)) {
      var2 = var3;
    }

    if(var0.vehicle.attachedguys.size >= var2) {
      return 0;
    }

    return 1;
  }

  return 1;
}

function helidestroyvehiclestouchnotify(var0, var1, var2) {
  if(isDefined(var0.child_spawners) && var0.child_spawners.size > 0) {
    var3 = var0.child_spawners;
  } else {
    var3 = getnodesinradiussorted(var1.origin, 2048, 0, 256, "cover");
  }

  var4 = 1;
  var5 = undefined;

  if(var4) {
    var5 = score_ai_spawns(var3, undefined, 1, var3, 1);
    self.ref_127ed = undefined;
  }

  var1 scripts\cp\cp_modular_spawning::set_default_spawner_values();
  var1.totalscore = undefined;
  var1.playercinematicfadeout = undefined;

  if(isDefined(var5)) {
    ref_13075(var1);
    var1 thread scripts\cp\cp_modular_spawning::parent_spawner_disable_after_count(self, var5);
  }

  return var5;
}

function cluster_spawnpoint_scoring(var0, var1, var2, var3) {
  if(calculate_ai_cluster_spawner_score(var0, level.current_spawn_scoring_index)) {
    return var0;
  }

  return undefined;
}

function cluster_spawnpoint_valid(var0, var1) {
  if(istrue(var1)) {
    return 0;
  }

  return 1;
}

function standard_spawnpoint_scoring(var0, var1, var2, var3) {
  if(calculate_ai_spawner_score(var0, level.current_spawn_scoring_index, var1, var3)) {
    return var0;
  }

  return undefined;
}

function quickdropremoverespawntokenfrominventory() {
  if(isDefined(self.ref_14288) && self.ref_14288.size > 0) {
    return self.ref_14288;
  }

  return [];
}

function standard_spawnpoint_valid(var0, var1) {
  if(!var0 scripts\cp\cp_modular_spawning::spawner_flags_check(32)) {
    var2 = var0.origin + (0, 0, 6);
    var3 = scripts\engine\trace::capsule_trace_get_all_results(var2, var2 + (0, 0, 1), 16, 32, undefined, undefined, level.get_coverblown_alias);
    var0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(32);

    if(isDefined(var3) && isDefined(var3[0])) {
      for(var4 = 0; var4 < var3.size; var4++) {
        if(isDefined(var3[var4])) {
          var5 = var3[var4];

          if(scripts\engine\utility::is_equal(var5["hittype"], "hittype_world")) {
            var0 scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
            return false;
          }
        }
      }
    }
  }

  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = 0;

  if(isnode(var0) && !var0 nodeisactivated()) {
    barelem(var8, "^1CRITICAL^0: Node Spawner disconnected", undefined, undefined, 1, var0);
    var0 scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
    return false;
  }

  var0 scripts\cp\cp_modular_spawning::spawner_init();

  if(!ref_13646(var0)) {
    return false;
  }

  if(scripts\cp\cp_spawn_factor::critical_factor(&shot_start_offset, var0)) {
    var10 = 0;

    if(!var10) {
      var0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(64);
      var0.lastspawntime = self.current_time + 10000;
    }
  } else {
    var0 scripts\cp\cp_modular_spawning::remove_from_spawner_flags(64);
  }

  if(getdvarint("scr_standard_scoring_aabb", 1) && !istrue(var0.script_forcespawn)) {
    var11 = get_close_distance_var();

    if(!isDefined(var0.script_parent)) {
      if(isDefined(var0.script_dist_only)) {
        var11 = var0.script_dist_only;
      }
    }

    var12 = scripts\common\utility::playersincylinder(var0.origin, var11);

    if(var12.size > 0) {
      if(isDefined(var0.script_dist_only)) {
        var0 thread scripts\cp\cp_modular_spawning::disable_spawn_point(var0, undefined, self);
      } else {
        var0.lastspawntime = self.current_time;
      }

      return false;
    }
  }

  if(isDefined(level.ref_13648) && level.ref_13648.size > 0) {
    var13 = incrementpersistentstat(level.ref_13648, var0.origin, 5000);

    for(var4 = 0; var4 < var13.size; var4++) {
      if(distance2dsquared(var0.origin, var13[var4].origin) < squared(var13[var4].radius)) {
        barelem(var8, "^1CRITICAL^0: Poisoned", undefined, undefined, 1, var0);
        return false;
      }
    }
  }

  if(isDefined(self.ref_127ed)) {
    var14 = recentunresolvedcollision(var0);
    var15 = distancesquared(self.ref_127ed, var0.origin);
    var11 = undefined;

    if(var15 >= var14) {
      barelem(var8, "^1CRITICAL^0: Too Far", undefined, undefined, 1, var0);
      return false;
    } else {
      var0.loopsound_origin = var15;
    }
  }

  return true;
}

function spawner_critical_factors(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = 0;

  if(istrue(level.pause_spawner_scoring)) {
    return 0;
  } else if(scripts\cp\cp_spawn_factor::critical_factor(&is_spawner_disabled, var0)) {
    return 0;
  }

  if(istrue(var1)) {
    if(scripts\cp\cp_spawn_factor::critical_factor(&trial_target_follow_dummy, var0)) {
      return 0;
    } else if(istrue(var0.is_on_platform) || isDefined(var0.noteleport)) {
      if(istrue(var0.is_on_platform)) {} else if(isDefined(var0.noteleport)) {}

      return 0;
    } else if(scripts\cp\cp_spawn_factor::critical_factor(&is_valid_respawn_spawnpoint, var0)) {
      return 0;
    }
  }

  if(scripts\cp\cp_spawn_factor::critical_factor(&is_level_escalation_sufficient, var0)) {
    return 0;
  }

  if(scripts\cp\cp_spawn_factor::critical_factor(&are_weapons_free, var0)) {
    return 0;
  }

  if(!scripts\cp\cp_spawn_factor::critical_factor(&scripts\cp\cp_spawn_factor::avoidtelefrag, var0)) {
    return 0;
  }

  if(!scripts\cp\cp_spawn_factor::critical_factor(level.spawner_scoring_critical_factors[get_spawn_scoring_type(var0)], var0)) {
    return 0;
  }

  return 1;
}

function get_spawn_scoring_type() {
  if(isDefined(self.spawner_flags)) {
    if(self.spawner_flags & 2) {
      return "vehicle_spawner";
    }

    if(self.spawner_flags & 4) {
      return "cluster_spawner";
    }

    return "standard_spawner";
  }

  return "standard_spawner";
}

function is_valid_respawn_spawnpoint(var0) {
  var1 = get_spawn_scoring_type(var0);

  if(isDefined(var1)) {
    switch (var1) {
      case "vehicle_spawner":
        return true;
      case "cluster_spawner":
        return false;
      case "standard_spawner":
        return false;
    }
  }

  return false;
}

function gate_flares_think(var0) {
  if(isDefined(self.group) && isDefined(self.group.ref_127ed)) {
    if(!self maymovefrompointtopoint(var0.origin, self.group.ref_127ed)) {
      level thread scripts\engine\utility::draw_capsule(var0.origin, 16, 32, undefined, (1, 0, 0), undefined, 1000);
      var0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(512);
      return 0;
    }

    return 1;
  }

  return 1;
}

function shot_start_offset(var0) {
  if(!istrue(var0.script_forcespawn)) {
    for(var1 = 0; var1 < level.players.size; var1++) {
      if(level.players[var1] hastacvis(var0.origin, 0, 64, 1)) {
        return true;
      }
    }
  }

  return false;
}

function is_level_escalation_sufficient(var0) {
  if(isDefined(var0.script_escalation_level) && isDefined(level.escalation_level)) {
    if(int(var0.script_escalation_level) > int(level.escalation_level)) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function are_weapons_free(var0) {
  if(scripts\engine\utility::ent_flag_exist("weapons_free") && scripts\engine\utility::ent_flag("weapons_free")) {
    if(isDefined(var0.script_animation_type)) {
      return true;
    }
  }

  return false;
}

function trial_target_follow_dummy(var0) {
  if(var0 scripts\cp\cp_modular_spawning::spawner_flags_check(512)) {
    return true;
  }

  if(istrue(var0.is_on_platform)) {
    var0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(512);
    return true;
  }

  var1 = self.ref_127ed;

  if(!isvector(var1)) {
    var1 = self.ref_127ed.origin;
  }

  if(!navtrace(var0.origin, var1)) {
    var0 scripts\cp\cp_modular_spawning::add_to_spawner_flags(512);
    return true;
  }

  return false;
}

function is_spawner_disabled(var0) {
  if(var0 scripts\cp\cp_modular_spawning::spawner_flags_check(1024)) {
    return 1;
  }

  return 0;
}

function score_factor_ai(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var4)) {
    var6 = [[var1]](var2, var3, var4);
  } else if(isDefined(var4)) {
    var6 = [[var2]](var3, var4);
  } else {
    var6 = [[var3]](var4);
  }

  if(!isDefined(var6)) {
    return undefined;
  }

  if(!isDefined(var6)) {
    var6 = 1000;
  }

  var7 = var6 * var2;
  var6 = clamp(var6 * var2, 0, var7);
  return var6;
}

function get_best_scoring_target(var0) {
  var1 = get_spawn_scoring_array();
  var2 = get_current_spawn_score_player_index(var1, var0);
  level.current_spawn_scoring_index = var2;

  if(isDefined(level.current_spawn_scoring_index)) {
    return var1[level.current_spawn_scoring_index];
  }

  return level.current_spawn_scoring_index;
}

function get_score_target_override(var0) {
  if(isDefined(level.stack_patch_waittill_leaf)) {
    if(scripts\engine\utility::array_contains(level.stack_patch_waittill_leaf, self.group_name)) {
      return undefined;
    }
  }

  if(isDefined(level.spawn_scoring_pois) && level.spawn_scoring_pois.size > 0) {
    var1 = undefined;

    if(level.spawn_scoring_pois.size > 1) {
      var2 = sortbydistance(level.spawn_scoring_pois, var0);
    } else {
      var2 = level.spawn_scoring_pois;
    }

    for(var3 = 0; var3 < var2.size; var3++) {
      if(distance2dsquared(var1, var2[var3].origin) < var2[var3].activation_radius_sq) {
        return var2[var3];
      }
    }
  }

  return undefined;
}

function get_score_target_pos(var0) {
  if(isPlayer(var0)) {
    jumpiffalse(isDefined(var0.velo_forward) && ref_132e4(var0)) LOC_0000002d;
    var1 = var0.velo_forward;
    goto LOC_0000004c;
  } else {
    var1 = var1.origin;
  }

  return var1;
}

function project_to_line(var0, var1, var2) {
  if(!isarray(var1)) {
    return var1;
  }

  if(isDefined(var2)) {
    return incrementpersistentstat(var1, var0, var2);
  }

  return sortbydistance(var1, var0);
}

function get_array_of_valid_spawnpoints(var0, var1, var2, var3) {
  var4 = [];
  var5 = 10;

  if(isarray(var0)) {
    self.ref_127ed = self.spawn_ref_point;
    var0 = project_to_line(self.ref_127ed, var0);

    for(var6 = 0; var6 < var0.size; var6++) {
      var7 = var0[var6];
      var7 scripts\cp\cp_modular_spawning::spawner_init();

      if(spawner_critical_factors(var7, var1, var3)) {
        var4 = var7;
      }

      if(var4.size >= var5) {
        break;
      }
    }
  } else {
    var4 = var0;
  }

  return var4;
}

function get_current_spawn_score_player_index(var0, var1) {
  if(!isDefined(var0)) {
    var0 = get_spawn_scoring_array();
  }

  var2 = var0.size;

  if(var2 <= 1) {
    return 0;
  }

  var3 = undefined;
  var4 = scripts\engine\utility::array_sort_with_func(var0, &ref_134d0);
  var5 = 0;

  while(var5 < var4.size) {
    var6 = var4[var5];
    var7 = 0;

    while(var7 < 2) {
      if(var7 || istrue(var6.spectating) && !istrue(var6.inlaststand) && !istrue(var6.ignoreme)) {
        for(var8 = 0; var8 < var0.size; var8++) {
          if(var0[var8] == var6) {
            var3 = var8;

            if(isPlayer(var6)) {
              self.cargo_truck_mg_init = var3;
            } else {
              self.cargo_truck_mg_init = undefined;
            }

            break;
          }
        }

        if(isDefined(var3)) {
          break;
        }
      }

      var6++;
    }

    if(isDefined(var2)) {
      break;
    }

    var4++;
  }

  if(!isDefined(var2)) {
    return randomint(level.players.size);
  }

  return var2;
}

function get_next_player_index(var0, var1) {
  var2 = get_spawn_scoring_array();
  var3 = var0;

  if(!istrue(var1)) {
    var3 = var0 + 1;
  }

  if(isDefined(var2[var3])) {
    return var3;
  }

  var3++;

  for(var4 = 0; var4 < var2.size; var4++) {
    if(isDefined(var2[var3])) {
      return var3;
    }

    if(var3 >= var2.size) {
      var3 = 0;
      continue;
    }

    var3++;
  }

  return 0;
}

function score_ai_spawns(var0, var1, var2, var3, var4) {
  var5 = undefined;
  var6 = get_best_scoring_target(var4);
  self.ref_133b8 = undefined;

  if(!isDefined(var6)) {
    return undefined;
  }

  if(istrue(self.ref_1405a)) {
    var1 = 1;
  }

  self.current_time = gettime();
  var7 = get_score_target_pos(var6);
  var8 = get_score_target_override(var7);
  self.spawn_ref_point = var7;
  self.spawn_ref_point_override = var8;
  var9 = get_array_of_valid_spawnpoints(var0, var1, undefined, var3);

  if(var9.size < 1) {
    return undefined;
  }

  self.current_time = gettime();
  var10 = 1;

  if(var10) {
    var11 = score_valid_spawnpoints(var9, var2, var3, var0);
  } else {
    var11 = [var10[0]];
  }

  if(var11.size < 1) {
    return undefined;
  }

  var12 = undefined;

  if(var11.size > 0) {
    var6 = var11[randomint(var11.size)];
  }

  if(isDefined(var6)) {
    if(passes_forward_check(var6, self) && ref_121e8(var6) && checkyellowmassacre(var6)) {
      for(var13 = 0; var13 < var10.size; var13++) {
        if(var6 != var10[var13]) {
          thread set_spawner_chosen_nearby();
        }
      }

      return var6;
    }

    var14 = 10000;

    if(isDefined(level.ref_12fc3)) {
      var14 = level.ref_12fc3;
    }

    var7.lastspawntime = self.current_time + var14;
    level notify("update_spawnpoint_debug_prints");
    return undefined;
  }

  level notify("update_spawnpoint_debug_prints");
  return undefined;
}

function ref_121e8() {
  return capsuletracepassed(self.origin + (0, 0, 6), 16, 32, undefined, 1, 1);
}

function checkyellowmassacre(var0) {
  if(istrue(level.ref_133bd)) {
    return true;
  }

  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  for(var4 = 0; var4 < level.players.size; var4++) {
    var5 = quickdropremoverespawntokenfrominventory(level.players[var4]);

    if(isDefined(var5) && var5.size > 0) {
      for(var6 = 0; var6 < var5.size; var6++) {
        if(distance2dsquared(var5[var6], var0.origin) <= 65536) {
          barelem(var3, "Player Cleared", undefined, undefined, 1, var0);
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

function score_valid_spawnpoints(var0, var1, var2, var3) {
  var4 = [];
  var5 = undefined;
  var6 = 0;
  var7 = [];
  var8 = 0;
  var9 = 1;

  for(var10 = 0; var10 < var0.size; var10++) {
    var11 = get_spawn_scoring_type(var0[var10]);

    if(isDefined(level.ref_1364a[var11]) && !level.ref_1364a[var11]) {
      var9 = 0;
      break;
    }
  }

  for(var10 = 0; var10 < var0.size; var10++) {
    var11 = get_spawn_scoring_type(var0[var10]);
    var12 = [[level.spawner_scoring_funcs[var11]]](var0[var10], undefined, var2, var3);

    if(isDefined(var12)) {
      if(!isDefined(var5) || isDefined(var6) && isDefined(var12.totalscore) && var12.totalscore > var6) {
        var5 = var12;
        var6 = var12.totalscore;
      }

      var8 = isDefined(var12.playercinematicfadeout);

      if(var8) {
        var7 = var12;
      }

      if(var9 && var12.totalscore >= 950) {
        if(!istrue(var1)) {
          var12.totalscore = undefined;
        }

        return [var12];
      }

      if(var12.totalscore > 500) {
        if(!var8) {
          var4 = var12;
        }

        if(var9) {
          if(istrue(var1)) {
            if(var4.size >= 5) {
              return var4;
            }

            continue;
          }

          var12.totalscore = undefined;
        }
      }
    }
  }

  if(var7.size > 0) {
    var13 = undefined;
    var14 = -99999;
    var15 = undefined;

    for(var10 = 0; var10 < var7.size; var10++) {
      var16 = var7[var10];

      if(isDefined(var16.totalscore) && var16.totalscore > var14) {
        var14 = var16.totalscore;
        var13 = var16;
        var15 = var16.playercinematicfadeout;
      }

      if(!istrue(var1)) {
        var16.totalscore = undefined;
        var16.playercinematicfadeout = undefined;
      }
    }

    if(isDefined(var13)) {
      var17 = [[var15]](var13, undefined, var2);

      if(isDefined(var17)) {
        if(isarray(var17)) {
          for(var18 = 0; var18 < var17.size; var18++) {
            if(var17[var18].totalscore > 500) {
              var4 = var17[var18];
            }
          }
        } else if(var17.totalscore > 500) {
          var4 = var17;
        }
      }
    }
  }

  if(var4.size > 0) {
    return var4;
  }

  if(isDefined(var5)) {
    var11 = get_spawn_scoring_type(var5);

    if(var11 == "cluster_spawner") {
      return [];
    }

    return [var5];
  }

  return [];
}

function print_spawnpoint_debug(var0, var1, var2) {
  self notify("print_spawnpoint_debug");
  self endon("print_spawnpoint_debug");
  var3 = 16;
  var4 = 16;
  var5 = get_spawn_scoring_type();

  if(var5 == "vehicle_spawner") {
    var3 = 48;
    var4 = 48;
  }

  if(istrue(level.spawnpoint_debug)) {
    if(isDefined(var2)) {
      level waittill(var2);
    }

    level endon("update_spawnpoint_debug_prints");
    level endon("end_spawnpoint_debug");

    for(;;) {
      thread scripts\engine\utility::draw_capsule(self.origin, var3, var4, (0, 0, 0), var1, 0, 1);
      waitframe();
    }

    return;
  }
}

function passes_forward_check(var0) {
  if(isDefined(self) && !isvector(self)) {
    if(isDefined(self.script_dot)) {
      var1 = int(self.script_dot) == 1;

      for(var2 = 0; var2 < level.players.size; var2++) {
        if(scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(level.players[var2].origin) == var1) {
          if(isDefined(self.script_dist_only)) {
            if(distancesquared(level.players[var2].origin, self.origin) <= int(self.script_dist_only)) {
              thread scripts\cp\cp_modular_spawning::disable_spawn_point(self, undefined, var0);
              return false;
            }

            continue;
          }

          thread scripts\cp\cp_modular_spawning::disable_spawn_point(self, undefined, var0);
          return false;
        }
      }
    } else if(isDefined(self.script_dist_only)) {
      for(var3 = 0; var3 < level.players.size; var3++) {
        if(distancesquared(level.players[var3].origin, self.origin) <= int(self.script_dist_only)) {
          thread scripts\cp\cp_modular_spawning::disable_spawn_point(self, undefined, var0);
          return false;
        }
      }
    }
  }

  return true;
}

function calculate_ai_cluster_spawner_score(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = level.total_cluster_spawn_score;
  var6 = 0;
  var7 = 8;
  var8 = score_factor_ai(var7 / var5, &is_cluster_spawner_ideal_distance, var0, var1);

  if(!isDefined(var8)) {
    return false;
  }

  var6 += var8;
  var9 = 5;
  var10 = score_factor_ai(var9 / var5, &is_spawner_towards_objective, var0, var1);

  if(!isDefined(var10)) {
    return false;
  }

  var6 += var10;
  var0.totalscore = int(var6);
  var0.playercinematicfadeout = &helidestroyvehiclestouchnotify;
  return true;
}

function calculate_ai_veh_spawner_score(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = level.total_veh_spawn_score;
  var6 = 0;
  var7 = 2;
  var8 = score_factor_ai(var7 / var5, &is_vehicle_spawner_ideal_distance, var0, var1, undefined, 1250);

  if(!isDefined(var8)) {
    return false;
  }

  var6 += var8;
  var7 = 1;
  var8 = score_factor_ai(var7 / var5, &is_spawner_towards_objective, var0, var1);

  if(!isDefined(var8)) {
    return false;
  }

  var6 += var8;
  var0.totalscore = int(var6);
  return true;
}

function calculate_ai_spawner_score(var0, var1, var2, var3) {
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = level.total_spawn_score;
  var8 = 0;
  var9 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 5, 4);
  var10 = score_factor_ai(var9 / var7, &is_spawner_ideal_distance, var0, var1);

  if(!isDefined(var10)) {
    if(istrue(var2)) {
      var10 = -10000;
    } else {
      return false;
    }
  }

  var8 += var10;
  var9 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 10, 4);
  var10 = score_factor_ai(var9 / var7, &avoid_recently_used_spawns, var0);

  if(!isDefined(var10)) {
    if(istrue(var2)) {
      var10 = -10000;
    } else {
      return false;
    }
  }

  var8 += var10;
  var9 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 10, 0);
  var10 = score_factor_ai(var9 / var7, &avoid_players_vision, var0);

  if(!isDefined(var10)) {
    if(istrue(var2)) {
      var10 = -10000;
    } else {
      return false;
    }
  }

  var8 += var10;
  var9 = 5;
  var10 = score_factor_ai(var9 / var7, &is_spawner_towards_objective, var0, var1);

  if(!isDefined(var10)) {
    if(istrue(var2)) {
      var10 = -10000;
    } else {
      return false;
    }
  }

  var8 += var10;
  var9 = 5;
  var10 = score_factor_ai(var9 / var7, &ref_145a9, var0);

  if(!isDefined(var10)) {
    return false;
  }

  var8 += var10;
  var9 = 5;
  var10 = score_factor_ai(var9 / var7, &has_spawner_chosen_nearby_flag, var0);

  if(!isDefined(var10)) {
    if(istrue(var2)) {
      var10 = -10000;
    } else {
      return false;
    }
  }

  var8 += var10;
  var9 = 2;
  var10 = score_factor_ai(var9 / var7, &is_close_to_player_z, var0, var1);

  if(!isDefined(var10)) {
    if(istrue(var2)) {
      var10 = -10000;
    } else {
      return false;
    }
  }

  var8 += var10;
  var0.totalscore = int(var8);
  return true;
}

function is_close_to_player_z(var0, var1) {
  var2 = level.players[var1];

  if(isDefined(self.spawn_ref_point)) {
    var3 = self.spawn_ref_point[2];
  } else {
    var3 = var3.origin[2];
  }

  if(isvector(var1)) {
    var4 = int(abs(var1[2] - var3));
  } else {
    var4 = int(abs(var2.origin[2] - var4));
  }

  if(var4 <= 128) {
    return 1000;
  }

  return 1000 / int(var4 / 32);
}

function ref_12f0a(var0, var1, var2, var3) {
  var4 = 1000;
  var5 = 0.707;
  var6 = -0.5;
  var7 = var4 * 0.5;
  var8 = 0;
  var9 = 1024;
  var10 = 262144;
  var11 = var1 - var0;
  var11 = (var11[0], var11[1], 0);
  var12 = length(var11);

  if(var12 > 0) {
    var11 /= var12;
  }

  var13 = vectordot(var2, var11);

  if(var12 > var9) {
    self.brjugg_managedeliveries = 1;

    if(var13 < var8) {
      return 0;
    } else if(var13 * var3 > var12) {
      return 0;
    } else if(var13 < var5) {
      var14 = 1 - (var5 - var13) / (var5 - var8);
      return (var4 * var14);
    } else {
      return var5;
    }
  } else {
    self.brjugg_managedeliveries = 0;

    if(var14 > var9) {
      return 0;
    } else if(var14 > var7) {
      var14 = 1 - (var7 - var14) / (var7 - var9);
      return (var5 * var14);
    } else {
      return var6;
    }
  }

  return 0;
}

function is_spawner_towards_objective(var0, var1) {
  if(!isDefined(level.activequests) || level.activequests.size < 1) {
    self.ref_133b8 = undefined;
    return 1000;
  } else {
    var2 = level.players[var1];
    var3 = var2.origin;
    var4 = var0.origin;
    var5 = var4 - var3;
    var5 = (var5[0], var5[1], 0);
    var6 = length(var5);

    if(var6 > 0) {
      var5 /= var6;
    }

    var7 = undefined;

    for(var8 = 0; var8 < level.activequests.size; var8++) {
      var9 = level.activequests[var8];

      if(isDefined(var9.ref_11f8d) && var9.ref_11f8d.size > 0) {
        for(var10 = 0; var10 < var9.ref_11f8d.size; var10++) {
          var11 = var9.ref_11f8d[var10];
          var12 = ref_12f0a(var3, var11, var5, var6);

          if(!isDefined(var7) || var12 > var7) {
            if(istrue(self.brjugg_managedeliveries)) {
              self.ref_133b8 = 1;
            } else {
              self.ref_133b8 = undefined;
            }

            var7 = var12;
          }

          self.brjugg_managedeliveries = undefined;
        }
      }
    }

    if(isDefined(var7)) {
      return var7;
    }
  }

  self.ref_133b8 = undefined;
  return 1000;
}

function has_spawner_chosen_nearby_flag(var0) {
  if(istrue(var0.spawner_chosen_nearby)) {
    return 1000;
  }

  return 0;
}

function avoid_players_vision(var0) {
  if(isDefined(var0.script_parent) || istrue(var0.script_forcespawn) || istrue(var0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint()) || !isDefined(level.players) || level.players.size < 1) {
    return 1000;
  }

  var1 = 1000 / level.players.size;
  var2 = undefined;
  var3 = quickdropcleanupcache();

  if(ref_12ddf(&ref_13682, 1, var0)) {
    var0.lastspawntime = self.current_time;
    return undefined;
  }

  return var1;
}

function ref_132e4() {
  var0 = self.velo_forward - self.origin;
  var0 = (var0[0], var0[1], 0);
  var1 = length(var0);

  if(var1 > 0) {
    return 1;
  }

  return 0;
}

function ref_145a9(var0, var1) {
  var2 = 1000;

  if(isDefined(var0.script_parent) || istrue(var0.script_forcespawn) || istrue(var0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint()) || !isDefined(level.players) || istrue(self.ref_133b8) || level.players.size < 1) {
    return var2;
  }

  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = quickdropcleanupcache();

  for(var7 = 0; var7 < var6.size; var7++) {
    if(isPlayer(var6[var7])) {
      var8 = var6[var7] getplayerangles();

      if(isDefined(var6[var7].velo_forward) && ref_132e4(var6[var7])) {
        var8 = vectortoangles(var6[var7].velo_forward - var6[var7].origin);
      }

      var3 += scripts\engine\math::get_dot(var6[var7].origin, var8, var0.origin);
    } else {
      var8 = var6[var7].angles;
      var3 += scripts\engine\math::get_dot(var6[var7].origin, var8, var0.origin);
    }

    var5++;
  }

  if(var5 == 0) {
    return var2;
  }

  var4 = var3 / var5;
  return var2 * var4;
}

function ref_12ddf(var0, var1, var2, var3) {
  for(var4 = 0; var4 < level.players.size; var4++) {
    var5 = level.players[var4][[var0]](var2, var3);

    if(isDefined(var1) && isDefined(var5) && scripts\engine\utility::is_equal(var1, var5)) {
      return true;
    }
  }

  return false;
}

function ref_13682(var0, var1) {
  if(isPlayer(self) && !scripts\cp\utility::is_valid_player(1)) {
    return 0;
  }

  var2 = register_invalid_seats_for_module_by_seat();
  var3 = self getEye();
  var4 = var0.origin + (0, 0, 56);
  var5 = scripts\engine\utility::within_fov(var3, var2, var4, cos(65)) && sighttracepassed(var3, var4, 0, undefined, 1);
  return var5;
}

function ref_12c5b(var0, var1, var2) {
  for(var3 = 0; var3 < var1.size; var3++) {
    var1[var3].lastspawntime = var2;
  }
}

function register_invalid_seats_for_module_by_seat() {
  return self getplayerangles();
}

function is_vehicle_spawner_ideal_distance(var0, var1) {
  var2 = level.players;
  var3 = level.players[var1];
  var4 = var3.origin;
  var5 = 0;
  var6 = 1250;
  var7 = 1250;
  var8 = 1562500;
  var9 = 4000;
  var10 = 16000000;
  var11 = 30000;
  var12 = 900000000;
  var13 = 0.25;

  if(isDefined(var0.script_maxdist)) {
    var11 = int(var0.script_maxdist);
    var12 = squared(var11);
  }

  var14 = distancesquared(var4, var0.origin);

  if(var14 >= var12) {
    return undefined;
  }

  if(var14 <= var8) {
    return var6;
  } else if(var14 <= var10) {
    var15 = var9 - var7;
    var16 = sqrt(var14) - var7;
    var17 = 1 - var16 / var15;
    return (var6 * var17);
  } else if(var17 >= var13) {
    var15 = var14 - var12;
    var16 = sqrt(var17) - var12;
    var17 = 1 - var16 / var15;
    return (var9 * var17 * var16);
  }

  return var11;
}

function is_cluster_spawner_ideal_distance(var0, var1) {
  var2 = level.players;

  if(isDefined(self.spawn_ref_point)) {
    var3 = self.spawn_ref_point;
  } else {
    var3 = scripts\cp\utility::get_center_point_of_array(var3);
  }

  var4 = undefined;
  var5 = 1024;
  var6 = 1048576;
  var7 = 0;
  var8 = 1000 / level.players.size;
  var9 = 20;
  var10 = 4194304;
  var11 = 2048;
  var12 = 4096;
  var13 = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    var14 = level.spawn_scoring_overrides;
    var5 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.close_dist, var5);
    var6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.close_dist_sq, var6);
    var9 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.far_score, var9);
    var10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.far_dist_sq, var10);
    var11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.far_dist, var11);
    var12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.ref_13bdb, var12);
    var13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.too_far_dist_sq, var13);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    var14 = self.spawn_scoring_overrides;
    var5 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.close_dist, var5);
    var6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.close_dist_sq, var6);
    var9 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.far_score, var9);
    var10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.far_dist_sq, var10);
    var11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.far_dist, var11);
    var12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.ref_13bdb, var12);
    var13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var14.too_far_dist_sq, var13);
  }

  var15 = 0.5;

  if(isDefined(var1.script_maxdist)) {
    var12 = int(var1.script_maxdist);
    var13 = squared(var12);
  }

  var16 = distance2dsquared(var3, var1.origin);

  if(var16 >= var13) {
    return undefined;
  } else if(var16 <= var10 && var16 >= var6) {
    var4 = var8;
  } else if(var16 >= var10) {
    var17 = 1 + var16 / var10;
    var18 = var9 / var17;
    var4 = var18;
  } else {
    var18 = var9 * var16;
    var5 = var18;
  }

  return var5;
}

function is_spawner_ideal_distance(var0, var1) {
  if(istrue(var0.script_forcespawn)) {
    return 1000;
  }

  var2 = level.players;

  if(isDefined(self.spawn_ref_point)) {
    var3 = self.spawn_ref_point;
  } else {
    var3 = scripts\cp\utility::get_center_point_of_array(var3);
  }

  var4 = level.players[var2];
  var5 = undefined;
  var6 = 1024;
  var7 = 1048576;
  var8 = 0;
  var9 = 1000 / level.players.size;
  var10 = 20;
  var11 = 4194304;
  var12 = 2048;
  var13 = 4096;
  var14 = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    var15 = level.spawn_scoring_overrides;
    var6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.close_dist, var6);
    var7 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.close_dist_sq, var7);
    var10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.far_score, var10);
    var11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.far_dist_sq, var11);
    var12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.far_dist, var12);
    var13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.ref_13bdb, var13);
    var14 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.too_far_dist_sq, var14);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    var15 = self.spawn_scoring_overrides;
    var6 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.close_dist, var6);
    var7 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.close_dist_sq, var7);
    var10 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.far_score, var10);
    var11 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.far_dist_sq, var11);
    var12 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.far_dist, var12);
    var13 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.ref_13bdb, var13);
    var14 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var15.too_far_dist_sq, var14);
  }

  var16 = 0.5;

  if(isDefined(var1.script_maxdist)) {
    var13 = int(var1.script_maxdist);
    var14 = squared(var13);
  }

  if(isDefined(var13) && isDefined(var1)) {
    var17 = 0;

    if(isvector(var1)) {
      var17 = scripts\common\utility::playersnear(var1, var13);
    } else {
      var17 = scripts\common\utility::playersnear(var1.origin, var13);
    }

    if(var17.size < 1) {
      return undefined;
    }
  }

  if(isDefined(var1.ideal_dist)) {
    var18 = var1.ideal_dist;
    var19 = var1.ideal_dist * var1.ideal_dist;
  } else {
    var18 = (var14 + var8) / 2;
    var19 = var18 * var18;
  }

  if(isDefined(var3.loopsound_origin)) {
    var20 = var3.loopsound_origin;
    var3.loopsound_origin = undefined;
  } else {
    var20 = distancesquared(var6, var3.origin);
  }

  if(var20 <= var14 && var20 >= var10) {
    return var12;
  } else if(var20 >= var14) {
    var21 = 1 + var20 / var14;
    var22 = var13 / var21;
    return var22;
  } else {
    var22 = var14 * var20;
    return var22;
  }

  return var14;
}

function avoid_recently_used_spawns(var0) {
  var1 = 1000;

  if(isDefined(var0.lastspawntime)) {
    var2 = self.current_time - var0.lastspawntime;
    var3 = radialmonitor();

    if(var2 > var3) {
      return var1;
    }

    var4 = var2 / var3;
    return int(var4 * var1);
  }

  return var4;
}

function ref_13646(var0, var1) {
  if(!isDefined(var0.lastspawntime)) {
    var0.lastspawntime = self.current_time;
    return 1;
  }

  var1 = self.current_time - var0.lastspawntime;
  var2 = radialmonitor();
  var3 = var1 / var2;

  if(var3 <= 0.5) {
    return 0;
  }

  return 1;
}

function radialmonitor() {
  if(isDefined(self.ref_12a81)) {
    return self.ref_12a81;
  }

  return 20000;
}

function ref_134d0(var0, var1) {
  if(isDefined(var0.cargo_truck_mg_gunnerdamagemodignorefunc) && isDefined(var1.cargo_truck_mg_gunnerdamagemodignorefunc)) {
    return (var0.cargo_truck_mg_gunnerdamagemodignorefunc < var1.cargo_truck_mg_gunnerdamagemodignorefunc);
  }

  return 0;
}

function get_spawn_scoring_array() {
  if(isDefined(level.players) && level.players.size > 0) {
    return scripts\cp\utility::get_array_of_valid_players();
  }

  return [];
}

function get_close_distance_var(var0) {
  var1 = 1024;
  var2 = 1048576;

  if(isDefined(self.spawn_scoring_overrides)) {
    if(istrue(var0)) {
      return scripts\cp\cp_modular_spawning::define_var_if_undefined(self.spawn_scoring_overrides.close_dist_sq, var2);
    }

    return scripts\cp\cp_modular_spawning::define_var_if_undefined(self.spawn_scoring_overrides.close_dist, var1);
  }

  if(isDefined(level.spawn_scoring_overrides)) {
    if(istrue(var0)) {
      return scripts\cp\cp_modular_spawning::define_var_if_undefined(level.spawn_scoring_overrides.close_dist_sq, var2);
    }

    return scripts\cp\cp_modular_spawning::define_var_if_undefined(level.spawn_scoring_overrides.close_dist, var1);
  }

  if(istrue(self.cqb_module)) {
    if(istrue(var0)) {
      return 110889;
    }

    return 333;
  }

  if(istrue(var0)) {
    return var2;
  }

  return var1;
}

function quickdropcleanupcache() {
  var0 = level.players;
  return var0;
}

function ref_12891(var0) {
  self.ref_12f08 = undefined;
}

function init_createfx(var0, var1) {
  if(getdvarint("scr_spawner_score_show_models")) {
    var2 = get_spawn_scoring_type();

    if(var2 == "vehicle_spawner") {
      return;
    }

    var3 = spawn("script_model", self.origin);

    if(!isDefined(var0.ref_13643)) {
      var0.ref_13643 = [];
    }

    var0.ref_13643[var0.ref_13643.size] = var3;

    if(isDefined(self.angles)) {
      var3.angles = self.angles;
    }

    switch (var2) {
      case "cluster_spawner":
        var3 setModel("com_teddy_bear");
        break;
      default:
        var3 setModel("british_pilot_fullbody");
        break;
    }

    scripts\cp\cp_outline::enable_outline_for_players(var3, level.players, var1);
    return;
  }
}

function barelem(var0, var1, var2, var3, var4, var5) {
  if(getdvarint("scr_print_spawner_score_info", 0)) {
    if(isDefined(var5)) {
      if(!isDefined(var5.ref_13efb)) {
        previousplacements(var5);
      }

      var6 = var5.ref_13efb;
    } else {
      var6 = previousplacements();
    }

    if(!isDefined(self.ref_12f08)) {
      init_killstreak_data_for_challenges();
    }

    self.ref_12f09[var6] = var6;

    if(istrue(var4) || !isDefined(var1)) {
      var1 = "";
    }

    if(!isDefined(var3)) {
      var3 = "";
    }

    if(!isDefined(var2)) {
      var2 = "";
    }

    if(var1.size > 0 || var2.size > 0) {
      var2 = "|" + var2;
    }

    var2 = var1 + "^0" + var2 + "^5" + var3;

    if(istrue(var5)) {
      self.ref_12f08[var6] = var2;
    }

    return var2;
  }
}

function init_killstreak_data_for_challenges() {
  if(getdvarint("scr_print_spawner_score_info", 0)) {
    self.ref_12f08 = [];
    self.ref_12f09 = [];
    var0 = self.group_name;

    if(!isDefined(var0)) {
      var0 = "";
    }

    var1 = "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#^0" + var0 + "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#";
    barelem(undefined, var1, undefined, undefined, 1);
    return;
  }
}

function previousplacements(var0) {
  if(!isDefined(self.current_uid)) {
    self.current_uid = 0;
  }

  if(isDefined(var0)) {
    var0.ref_13efb = self.current_uid;
  }

  var1 = self.current_uid;
  self.current_uid++;
  return var1;
}

function redeployspawn() {
  if(isDefined(self.ref_13efb)) {
    return self.ref_13efb;
  }

  return undefined;
}

function ref_13075(var0) {
  if(getdvarint("scr_print_spawner_score_info", 0)) {
    var1 = redeployspawn(var0);
    var0.grenade_exploded_during_stealth_listener = 1;

    if(isDefined(var1)) {
      var2 = self.ref_12f08[var1];

      if(isDefined(var2)) {
        var2 = "^5CHOSEN: " + var2;
        self.ref_12f08[var1] = var2;
        return;
      }

      return;
    }

    return;
  }
}

function recentunresolvedcollision(var0) {
  var1 = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    var2 = level.spawn_scoring_overrides;
    var1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var2.too_far_dist_sq, var1);
  } else if(isDefined(self.spawn_scoring_overrides)) {
    var2 = self.spawn_scoring_overrides;
    var1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var2.too_far_dist_sq, var1);
  }

  if(isDefined(var0.script_maxdist)) {
    var3 = int(var0.script_maxdist);
    var1 = squared(var3);
  }

  return var1;
}