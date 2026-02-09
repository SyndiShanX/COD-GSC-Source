/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_chopperboss.gsc
*****************************************************/

init() {
  common_scripts\utility::create_lock("chopperboss_trace");
  common_scripts\utility::create_lock("chopperboss_aggro_trace");
  maps\_chopperboss_utility::build_chopperboss_defaults();
}

chopper_boss_locs_populate(var_0, var_1) {
  var_2 = getent("heli_nav_optimizer", "targetname");

  if(isDefined(var_2))
    thread chopper_boss_locs_populate_thread_optimized(var_0, var_1, var_2);
  else
    thread chopper_boss_locs_populate_thread(var_0, var_1);
}

chopper_boss_locs_populate_thread(var_0, var_1) {
  level.chopper_boss_locs = common_scripts\utility::getstructarray(var_1, var_0);
  var_2 = 0;

  foreach(var_4 in level.chopper_boss_locs) {
    var_4.neighbors = var_4 maps\_utility::get_linked_structs();

    foreach(var_6 in level.chopper_boss_locs) {
      if(var_4 == var_6) {
        continue;
      }
      if(!common_scripts\utility::array_contains(var_4.neighbors, var_6) && common_scripts\utility::array_contains(var_6 maps\_utility::get_linked_structs(), var_4))
        var_4.neighbors[var_4.neighbors.size] = var_6;

      var_2++;
      var_2 = var_2 % 2000;

      if(var_2 == 0)
        wait 0.05;
    }

    foreach(var_9 in var_4.neighbors) {
      if(isDefined(var_9.script_ignoreme) && var_9.script_ignoreme)
        var_4.neighbors = common_scripts\utility::array_remove(var_4.neighbors, var_9);
    }
  }

  level.chopper_boss_locs_populated = 1;
}

chopper_boss_locs_populate_thread_optimized(var_0, var_1, var_2) {
  level.chopper_boss_locs = common_scripts\utility::getstructarray(var_1, var_0);
  var_3 = [];

  for(var_4 = var_2; isDefined(var_4); var_4 = getent(var_4.target, "targetname")) {
    var_3[var_3.size] = var_4;
    var_4.boss_locs = [];

    foreach(var_6 in level.chopper_boss_locs) {
      if(ispointinvolume(var_6.origin, var_4))
        var_4.boss_locs[var_4.boss_locs.size] = var_6;
    }

    if(!isDefined(var_4.target)) {
      break;
    }
  }

  foreach(var_6 in level.chopper_boss_locs)
  var_6.neighbors = var_6 maps\_utility::get_linked_structs();

  var_4 = var_2;
  var_10 = getent(var_4.target, "targetname");

  for(var_11 = undefined; isDefined(var_4); var_4 = var_10) {
    if(isDefined(var_4.target))
      var_10 = getent(var_4.target, "targetname");
    else
      var_10 = undefined;

    foreach(var_6 in var_4.boss_locs) {
      var_6 add_back_links_for_neighbors(var_4.boss_locs);

      if(isDefined(var_10))
        var_6 add_back_links_for_neighbors(var_10.boss_locs);

      if(isDefined(var_11))
        var_6 add_back_links_for_neighbors(var_11.boss_locs);
    }

    var_11 = var_4;
  }

  foreach(var_6 in level.chopper_boss_locs) {
    foreach(var_16 in var_6.neighbors) {
      if(isDefined(var_16.script_ignoreme) && var_16.script_ignoreme)
        var_6.neighbors = common_scripts\utility::array_remove(var_6.neighbors, var_16);
    }
  }

  maps\_utility::array_delete(var_3);
  level.chopper_boss_locs_populated = 1;
}

add_back_links_for_neighbors(var_0) {
  foreach(var_2 in var_0) {
    if(self == var_2) {
      continue;
    }
    if(!common_scripts\utility::array_contains(self.neighbors, var_2) && common_scripts\utility::array_contains(var_2 maps\_utility::get_linked_structs(), self))
      self.neighbors[self.neighbors.size] = var_2;
  }
}

chopper_path_release(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = strtok(var_1, " ");

    foreach(var_4 in var_2)
    self endon(var_4);
  }

  var_6 = strtok(var_0, " ");

  switch (var_6.size) {
    case 1:
      self waittill(var_6[0]);
      break;
    case 2:
      common_scripts\utility::waittill_either(var_6[0], var_6[1]);
      break;
    case 3:
      common_scripts\utility::waittill_any(var_6[0], var_6[1], var_6[2]);
      break;
    case 4:
      common_scripts\utility::waittill_any(var_6[0], var_6[1], var_6[2], var_6[3]);
      break;
    default:
      break;
  }

  if(isDefined(self.loc_current))
    self.loc_current.in_use = undefined;
}

chopper_boss_think(var_0, var_1) {
  self endon("death");
  self endon("deathspin");
  level endon("special_op_terminated");
  maps\_chopperboss_utility::chopper_boss_wait_populate();
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0);
  self.loc_current = var_0;
  self.loc_current.in_use = 1;
  thread chopper_path_release("death deathspin");
  self.fired_weapons = 0;

  for(;;) {
    if(!isDefined(self.chopper_boss_agro))
      self.heli_target = undefined;

    if(pause_action()) {
      continue;
    }
    if(var_1) {
      self setneargoalnotifydist(2048);
      var_2 = chopper_boss_get_closest_target_2d();

      if(isDefined(var_2)) {
        var_3 = chopper_boss_get_closest_neighbor_2d(var_2);

        if(isDefined(var_3) && !chopper_boss_in_range(var_2.origin, var_3.origin)) {
          self.request_move = undefined;
          self[[maps\_chopperboss_utility::get_chopperboss_data("pre_move_func")]]();
          thread chopper_boss_move(var_3);
          var_4 = common_scripts\utility::waittill_any_return("reached_dynamic_path_end", "near_goal", "request_move_update");
          self thread[[maps\_chopperboss_utility::get_chopperboss_data("post_move_func")]]();
          continue;
        }
      }
    }

    var_5 = isDefined(self.request_move) && self.request_move || self.fired_weapons;

    while(isDefined(level.chopper_boss_finding_target))
      wait 0.05;

    var_6 = chopper_boss_get_best_location_and_target(var_5);

    if(pause_action()) {
      continue;
    }
    if(isDefined(var_6) && self.loc_current != var_6) {
      self[[maps\_chopperboss_utility::get_chopperboss_data("pre_move_func")]]();
      self.request_move = undefined;
      thread chopper_boss_move(var_6);

      if(!isDefined(self.chopper_boss_agro))
        self waittill("reached_dynamic_path_end");
      else
        common_scripts\utility::waittill_any("near_goal", "request_move_update");

      self thread[[maps\_chopperboss_utility::get_chopperboss_data("post_move_func")]]();
    }

    if(!isDefined(self.chopper_boss_agro) || !self.chopper_boss_agro)
      self[[maps\_chopperboss_utility::get_chopperboss_data("stop_func")]]();

    wait 0.1;
  }
}

chopper_boss_get_closest_target_2d() {
  var_0 = [[maps\_chopperboss_utility::get_chopperboss_data("get_targets_func")]]();

  if(!var_0.size)
    return undefined;

  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(!isDefined(var_1)) {
      var_1 = var_4;
      var_2 = distance2d(self.origin, var_4.origin);
      continue;
    }

    var_5 = distance2d(self.origin, var_4.origin);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

chopper_boss_get_closest_neighbor_2d(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in self.loc_current.neighbors) {
    if(isDefined(var_4.in_use) || isDefined(var_4.disabled)) {
      continue;
    }
    if(!isDefined(var_1)) {
      var_1 = var_4;
      var_2 = distance2d(var_4.origin, var_0.origin);
      continue;
    }

    var_5 = distance2d(var_4.origin, var_0.origin);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

chopper_boss_in_range(var_0, var_1, var_2) {
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, self.origin);
  var_3 = distance2d(var_1, var_0);
  var_4 = maps\_chopperboss_utility::get_chopperboss_data("min_target_dist2d");
  var_5 = undefined;

  if(isDefined(var_2) && var_2)
    var_5 = 90000;
  else
    var_5 = maps\_chopperboss_utility::get_chopperboss_data("max_target_dist2d");

  return var_3 >= var_4 && var_3 <= var_5;
}

chopper_boss_set_target(var_0) {
  if(isDefined(var_0))
    self.heli_target = var_0;
  else if(isDefined(self.chopper_boss_agro) && self.chopper_boss_agro)
    self.heli_target = undefined;
}

chopper_boss_attempt_firing(var_0, var_1) {
  self endon("deathspin");
  self endon("death");
  var_2 = 0;
  var_3 = maps\_chopperboss_utility::chopper_boss_forced_target_get();
  var_4 = 0;

  if(isDefined(var_0) || isDefined(var_3)) {
    if(isDefined(var_3)) {
      var_0 = var_3;
      var_4 = 1;
    } else {
      var_5 = 0;

      if(isDefined(var_0.heli_shooting))
        var_5 = var_0.heli_shooting;

      if(var_5 < maps\_chopperboss_utility::get_chopperboss_data("heli_shoot_limit") && chopper_boss_in_range(var_0.origin, undefined, isDefined(var_1)))
        var_4 = 1;
    }
  }

  if(var_4) {
    thread chopper_boss_manage_shooting_flag(var_0);
    var_6 = pause_action();
    self setlookatent(var_0);
    var_7 = chopper_boss_wait_face_target(var_0, maps\_chopperboss_utility::get_chopperboss_data("face_target_timeout"));

    if(isDefined(var_0)) {
      if(isDefined(var_7) && var_7) {
        var_2 = self[[maps\_chopperboss_utility::get_chopperboss_data("fire_func")]](var_0);
        var_2 = common_scripts\utility::ter_op(isDefined(var_2), var_2, 1);
      }
    }

    self notify("chopper_done_shooting");
  }

  return var_2;
}

chopper_boss_manage_shooting_flag(var_0) {
  if(!isDefined(var_0.heli_shooting))
    var_0.heli_shooting = 0;

  var_0.heli_shooting++;
  common_scripts\utility::waittill_any("death", "deathspin", "chopper_done_shooting");

  if(isDefined(var_0))
    var_0.heli_shooting--;
}

chopper_boss_wait_face_target(var_0, var_1) {
  self endon("death");
  self endon("deathspin");
  var_0 endon("death");
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = gettime() + var_1 * 1000;

  while(isDefined(var_0)) {
    if(maps\_utility::within_fov_2d(self.origin, self.angles, var_0.origin, 0.766))
      return 1;

    if(isDefined(var_2) && gettime() >= var_2)
      return 0;

    wait 0.25;
  }
}

chopper_boss_manage_targeting_flag() {
  level.chopper_boss_finding_target = self;
  common_scripts\utility::waittill_any("death", "deathspin", "chopper_done_targeting");
  level.chopper_boss_finding_target = undefined;
}

chopper_boss_get_best_location_and_target(var_0) {
  self endon("death");
  var_1 = self.loc_current.neighbors;

  if(!isDefined(var_0) || var_0 == 0)
    var_1[var_1.size] = self.loc_current;

  if(isDefined(level.chopper_boss_hangout))
    var_1 = level.chopper_boss_hangout;

  var_2 = chopper_boss_get_target();
  return [[maps\_chopperboss_utility::get_chopperboss_data("next_loc_func")]](var_1, var_2);
}

chopper_boss_get_target() {
  var_0 = undefined;

  if(isDefined(maps\_chopperboss_utility::chopper_boss_forced_target_get()))
    var_0 = [maps\_chopperboss_utility::chopper_boss_forced_target_get()];
  else
    var_0 = [[maps\_chopperboss_utility::get_chopperboss_data("get_targets_func")]]();

  return var_0;
}

chopper_boss_get_best_location_and_target_proc(var_0, var_1) {
  var_2 = maps\_chopperboss_utility::get_chopperboss_data("tracecheck_func");
  thread chopper_boss_manage_targeting_flag();
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(var_6 != self.loc_current && isDefined(var_6.in_use)) {
      continue;
    }
    if(isDefined(var_6.disabled)) {
      continue;
    }
    var_6.heli_target = undefined;
    var_6.dist2d = undefined;
    var_7 = undefined;
    common_scripts\utility::lock("chopperboss_trace");

    foreach(var_9 in var_1) {
      common_scripts\utility::unlock_wait("chopperboss_trace");
      common_scripts\utility::lock("chopperboss_trace");

      if(!isDefined(var_9)) {
        continue;
      }
      if(chopper_boss_in_range(var_9.origin, var_6.origin) == 0) {
        continue;
      }
      var_10 = var_9.origin + (0, 0, 64);

      if(isai(var_9) || isPlayer(var_9))
        var_10 = var_9 getEye();

      if(self[[var_2]](var_6.origin, var_10)) {
        if(!isDefined(var_6.heli_target)) {
          var_3[var_3.size] = var_6;
          var_6.heli_target = var_9;
          var_7 = distance2d(var_6.origin, var_9.origin);
          continue;
        }

        var_11 = distance2d(var_6.origin, var_9.origin);

        if(var_11 < var_7) {
          var_6.heli_target = var_9;
          var_7 = var_11;
        }
      }
    }

    common_scripts\utility::unlock_wait("chopperboss_trace");
  }

  if(var_3.size) {
    var_14 = [];

    foreach(var_6 in var_3) {
      if(isDefined(var_6.heli_target) && !isDefined(var_6.in_use) && !isDefined(var_6.disabled))
        var_14[var_14.size] = var_6;
    }

    var_3 = var_14;
  }

  if(!var_3.size) {
    foreach(var_6 in var_0) {
      if(var_6 != self.loc_current && isDefined(var_6.in_use)) {
        continue;
      }
      if(isDefined(var_6.disabled)) {
        continue;
      }
      var_18 = undefined;

      foreach(var_9 in var_1) {
        if(!isDefined(var_9)) {
          continue;
        }
        if(!isDefined(var_18)) {
          var_18 = var_9;
          var_6.dist2d = distance2d(var_6.origin, var_9.origin);
          continue;
        }

        var_20 = distance2d(var_6.origin, var_9.origin);

        if(var_20 < var_6.dist2d) {
          var_18 = var_9;
          var_6.dist2d = var_20;
        }
      }

      if(isDefined(var_6.dist2d))
        var_3[var_3.size] = var_6;
    }
  } else {
    foreach(var_6 in var_3)
    var_6.dist2d = distance2d(var_6.heli_target.origin, var_6.origin);
  }

  var_25 = common_scripts\utility::array_sort_by_handler(var_3, ::chopper_boss_loc_compare);
  var_26 = undefined;

  foreach(var_6 in var_25) {
    var_28 = maps\_chopperboss_utility::get_chopperboss_data("min_target_dist2d");
    var_29 = maps\_chopperboss_utility::get_chopperboss_data("max_target_dist2d");

    if(var_6.dist2d >= var_28 && var_6.dist2d <= var_29) {
      var_26 = var_6;
      break;
    }
  }

  if(!isDefined(var_26) && var_25.size)
    var_26 = var_25[0];

  if(isDefined(var_26) && isDefined(var_26.heli_target))
    chopper_boss_set_target(var_26.heli_target);

  self notify("chopper_done_targeting");

  if(isDefined(var_26) && var_26 != self.loc_current)
    return var_26;
  else
    return undefined;
}

get_trace_loc_for_target(var_0, var_1) {
  var_2 = var_0 maps\_chopperboss_utility::get_boundry_radius();
  var_3 = vectornormalize(self getcentroid() - var_0.origin) * var_2;
  return var_0.origin + var_3;
}

chopper_boss_get_best_target_proc(var_0) {
  var_1 = maps\_chopperboss_utility::get_chopperboss_data("tracecheck_func");
  var_2 = undefined;
  common_scripts\utility::lock("chopperboss_aggro_trace");
  var_3 = undefined;

  foreach(var_5 in var_0) {
    common_scripts\utility::unlock("chopperboss_aggro_trace");
    common_scripts\utility::lock("chopperboss_aggro_trace");

    if(!isDefined(var_5)) {
      continue;
    }
    if(isDefined(var_5.crashing) && var_5.crashing) {
      continue;
    }
    if(chopper_boss_in_range(var_5.origin, self.origin, 1) == 0) {
      continue;
    }
    var_6 = get_trace_loc_for_target(self, var_5 getcentroid());

    if(sillyboxtrace(var_6, var_5, self)) {
      var_3 = var_5;
      break;
    }
  }

  common_scripts\utility::unlock("chopperboss_aggro_trace");
  chopper_boss_set_target(var_3);
}

sillyboxtrace(var_0, var_1, var_2) {
  if(sighttracepassed(var_0, var_1 getpointinbounds(0, 0, 1), 0, var_2))
    return 1;

  if(sighttracepassed(var_0, var_1 getpointinbounds(0, 0, -1), 0, var_2))
    return 1;

  if(sighttracepassed(var_0, var_1 getpointinbounds(0, 1, 0), 0, var_2))
    return 1;

  if(sighttracepassed(var_0, var_1 getpointinbounds(0, -1, 0), 0, var_2))
    return 1;

  if(sighttracepassed(var_0, var_1 getpointinbounds(1, 0, 0), 0, var_2))
    return 1;

  if(sighttracepassed(var_0, var_1 getpointinbounds(-1, 0, 0), 0, var_2))
    return 1;

  return 0;
}

chopper_boss_loc_compare() {
  return self.dist2d;
}

chopper_boss_move(var_0, var_1) {
  self notify("chopper_boss_move");

  if(isDefined(self.loc_current))
    self.loc_current.in_use = undefined;

  self.loc_current = var_0;
  self.loc_current.in_use = 1;
  self clearlookatent();
  self cleartargetyaw();
  thread maps\_vehicle::vehicle_paths(var_0, undefined, var_1);
}

chopper_boss_agro_chopper() {
  self endon("stop_chopper_boss_agro_chopper");
  self endon("death");
  self endon("deathspin");
  self.chopper_boss_agro = 1;

  for(;;) {
    if(pause_action()) {
      continue;
    }
    var_0 = chopper_boss_get_target();
    chopper_boss_get_best_target_proc(var_0);

    if(pause_action()) {
      continue;
    }
    if(isDefined(self.heli_target))
      self.fired_weapons = chopper_boss_attempt_firing(self.heli_target, 1);
    else
      self.fired_weapons = 0;

    wait 0.05;
  }
}

stop_chopper_boss_agro_chopper() {
  self notify("stop_chopper_boss_agro_chopper");
}

chopper_boss_pause_path_finding() {
  self.chopper_boss_path_paused = 1;
}

chopper_boss_resume_path_finding() {
  self.chopper_boss_path_paused = 0;
}

pause_action() {
  var_0 = 0;

  for(;;) {
    if(!isDefined(self.chopper_boss_path_paused)) {
      break;
    }

    if(!self.chopper_boss_path_paused) {
      break;
    }

    var_0 = 1;
    wait 0.05;
  }

  return var_0;
}

request_move_now() {
  self.request_move = 1;
  self notify("request_move_update");
}