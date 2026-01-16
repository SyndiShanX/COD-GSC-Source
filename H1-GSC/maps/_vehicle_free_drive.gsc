/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_vehicle_free_drive.gsc
****************************************/

init_vehicle_free_path(var_0) {
  common_scripts\utility::create_dvar("vehicle_free_path_debug", 0);
  clean_up_vehicle_free_path(1);
  setup_default_level_vars();
  level.enemy_free_vehicles = [];
  level.drive_free_path_func = ::vehicle_drives_free_path;
  level.vehicle_free_path = setup_free_drive_path(var_0);
  common_scripts\utility::run_thread_on_targetname("enable_free_path", ::enable_free_path_think);
}

setup_default_level_vars() {
  if(!isdefined(level.freedrive_playermatch_farbehind_delete_dist))
    level.freedrive_playermatch_farbehind_delete_dist = -4000;

  if(!isdefined(level.freedrive_playermatch_catchup_ramp_start_dist))
    level.freedrive_playermatch_catchup_ramp_start_dist = -2000;

  if(!isdefined(level.freedrive_playermatch_catchup_ramp_end_dist))
    level.freedrive_playermatch_catchup_ramp_end_dist = 100;

  if(!isdefined(level.freedrive_playermatch_slowdown_ramp_start_dist))
    level.freedrive_playermatch_slowdown_ramp_start_dist = 650;

  if(!isdefined(level.freedrive_playermatch_slowdown_ramp_end_dist))
    level.freedrive_playermatch_slowdown_ramp_end_dist = 2000;

  if(!isdefined(level.freedrive_playermatch_farahead_delete_dist))
    level.freedrive_playermatch_farahead_delete_dist = 4000;

  if(!isdefined(level.freedrive_playermatch_matched_multiplier))
    level.freedrive_playermatch_matched_multiplier = 1.0;

  if(!isdefined(level.freedrive_playermatch_slowdown_multiplier))
    level.freedrive_playermatch_slowdown_multiplier = 0.6;

  if(!isdefined(level.freedrive_playermatch_catchup_multiplier))
    level.freedrive_playermatch_catchup_multiplier = 1.6;

  if(!isdefined(level.freedrive_progress_mod_default))
    level.freedrive_progress_mod_default = 200;

  if(!isdefined(level.freedrive_progress_mod_step))
    level.freedrive_progress_mod_step = 200;

  if(!isdefined(level.freedrive_vehicle_min_allowed_speed))
    level.freedrive_vehicle_min_allowed_speed = 25.0;

  if(!isdefined(level.freedrive_dodge_static_early_distance))
    level.freedrive_dodge_static_early_distance = 200;

  if(!isdefined(level.freedrive_stay_within_percent_of_edge))
    level.freedrive_stay_within_percent_of_edge = 0.9;
}

enable_free_path_think() {
  level endon("stop_vehicle_free_path");

  for (;;) {
    self waittill("trigger", var_0);
    var_0 notify("enable_free_path");
  }
}

clean_up_vehicle_free_path(var_0) {
  level notify("stop_vehicle_free_path");
  level.vehicle_free_path = undefined;
  level.moving_obstacles = undefined;

  if(var_0 && isdefined(level.enemy_free_vehicles)) {
    foreach(var_2 in level.enemy_free_vehicles) {
      if(!isremovedentity(var_2))
        var_2 delete();
    }
  }

  level.enemy_free_vehicles = undefined;

  if(isdefined(level.player.drivingvehicle) && isdefined(level.player.drivingvehicle.progress_node))
    level.player.drivingvehicle.progress_node = undefined;
}

spawn_vehicle_and_attach_to_free_path(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

  if(!isdefined(level.enemy_free_vehicles))
    level.enemy_free_vehicles = [];

  if(level.enemy_free_vehicles.size >= 8)
    return undefined;

  if(var_2 && var_3) {
    var_4 = getentarray(self.target, "targetname");
    var_5 = [];

    foreach(var_7 in var_4) {
      if(var_7.code_classname == "info_vehicle_node") {
        continue;
      }
      var_5[var_5.size] = var_7;
    }

    var_5 = common_scripts\utility::get_array_of_closest(self.origin, var_5);

    foreach(var_11, var_10 in var_5)
    var_10 thread maps\_utility::add_spawn_function(::guy_spawns_and_gets_in_vehicle, self, var_11);

    var_12 = maps\_utility::spawn_vehicle();
    var_12 waittill("guy_entered");
    wait 3;

    if(!self.riders.size)
      return undefined;
  } else
    var_12 = maps\_utility::spawn_vehicle();

  var_12.dontunloadonend = 1;
  var_12.has_riders = var_2;
  var_12 thread maps\_vehicle_code::vehicle_becomes_crashable();

  if(isdefined(var_0))
    var_12 vehphys_setspeed(var_0);

  if(var_1) {
    wait 0.15;
    var_12 leave_path_for_free_path(1, var_0);
  } else {
    var_12 thread leave_path_for_free_path(0, var_0);
    var_12 thread maps\_vehicle_code::_gopath(var_12);
  }

  return var_12;
}

leave_path_for_free_path(var_0, var_1) {
  self endon("death");
  self endon("script_crash_vehicle");

  if(!var_0) {
    level endon("stop_vehicle_free_path");
    common_scripts\utility::waittill_either("enable_free_path", "reached_end_node");
  }

  var_2 = get_my_free_path_node(self.origin);

  if(isdefined(level.drive_free_path_func))
    var_2 thread[[level.drive_free_path_func]](self, var_1);

  thread vehicle_crash_detection();
}

get_my_free_path_node(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = common_scripts\utility::get_array_of_closest(var_0, level.vehicle_free_path, undefined, 3);
  var_2 = var_1[0];
  var_3 = var_2.index;

  if(var_1[1].index < var_3) {
    var_2 = var_1[1];
    var_3 = var_2.index;
  }

  if(var_1[2].index < var_3)
    var_2 = var_1[2];

  return var_2;
}

guy_spawns_and_gets_in_vehicle(var_0, var_1) {
  maps\_vehicle_code::_mount_snowmobile(var_0, var_1);
}

setup_free_drive_path(var_0) {
  var_1 = create_path(var_0);
  add_collision_to_path(var_1);
  return var_1;
}

create_path(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_2 = [];
  var_3 = 0;
  var_4 = var_1;

  for (;;) {
    var_5 = var_1;

    if(isdefined(var_1.target))
      var_5 = common_scripts\utility::getstruct(var_1.target, "targetname");

    var_1.origin = drop_point_to_ground(var_1.origin);
    var_2[var_2.size] = var_1;
    var_1.next_node = var_5;
    var_1.prev_node = var_4;
    var_1.col_lines = [];
    var_1.col_volumes = [];
    var_1.col_moving_volumes = [];
    var_1.origins = [];
    var_1.origins["left"] = var_1.origin;
    var_6 = common_scripts\utility::getstruct(var_1.script_linkto, "script_linkname");
    var_6.origin = drop_point_to_ground(var_6.origin);
    var_1.origins["right"] = var_6.origin;
    var_1.road_width = distance(var_1.origins["right"], var_1.origins["left"]);
    var_1.midpoint = (var_1.origins["left"] + var_1.origins["right"]) * 0.5;
    var_1.index = var_3;
    var_3++;

    if(var_1 == var_5) {
      break;
    }

    var_4 = var_1;
    var_1 = var_5;
  }

  foreach(var_8 in var_2) {
    if(var_8.next_node == var_8) {
      continue;
    }
    var_9 = var_8.midpoint;
    var_10 = var_8.next_node.midpoint;
    var_11 = vectortoangles(var_9 - var_10);
    var_12 = anglestoright(var_11);
    var_13 = var_8.road_width * 0.5;
    var_8.origins["left"] = var_8.midpoint + var_12 * var_13;
    var_8.origins["left_warning"] = var_8.midpoint + var_12 * var_13 * level.freedrive_stay_within_percent_of_edge;
    var_8.origins["right"] = var_8.midpoint + var_12 * var_13 * -1;
    var_8.origins["right_warning"] = var_8.midpoint + var_12 * var_13 * -1 * level.freedrive_stay_within_percent_of_edge;
  }

  foreach(var_8 in var_2)
  var_8.dist_to_next_node = distance(var_8.midpoint, var_8.next_node.midpoint);

  return var_2;
}

add_collision_to_path(var_0) {
  var_1 = common_scripts\utility::getstructarray("road_path_col", "targetname");

  foreach(var_3 in var_1) {
    var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
    var_3.origin = drop_point_to_ground(var_3.origin);
    var_4.origin = drop_point_to_ground(var_4.origin);
    var_3.other_col_point = var_4;
    var_4.other_col_point = var_3;
  }

  foreach(var_7 in var_0) {
    foreach(var_3 in var_1) {
      if(!isdefined(var_3.line_claimed))
        add_collision_to_path_node(var_7, var_3);
    }
  }
}

add_collision_to_path_node(var_0, var_1) {
  if(var_0 == var_0.next_node) {
    return;
  }
  if(!test_col_points_in_segment(var_0, var_1)) {
    return;
  }
  var_2 = var_1.other_col_point;
  var_3 = get_progression_between_points(var_1.origin, var_0.midpoint, var_0.next_node.midpoint);
  var_4 = get_progression_between_points(var_2.origin, var_0.midpoint, var_0.next_node.midpoint);
  var_1.progress = var_3["progress"];
  var_1.offset = var_3["offset"];
  var_2.progress = var_4["progress"];
  var_2.offset = var_4["offset"];

  if(var_3["progress"] < var_4["progress"]) {
    add_collision_offsets_to_path_ent(var_0, var_1, var_2);
    var_0.col_lines[var_0.col_lines.size] = var_1;
    var_1.line_claimed = 1;
  } else {
    add_collision_offsets_to_path_ent(var_0, var_2, var_1);
    var_0.col_lines[var_0.col_lines.size] = var_2;
    var_1.line_claimed = 1;
  }
}

test_col_points_in_segment(var_0, var_1) {
  var_2[0] = var_0.origins["left"];
  var_2[1] = var_0.origins["right"];
  var_2[2] = var_0.next_node.origins["right"];
  var_2[3] = var_0.next_node.origins["left"];
  var_3[0] = var_1.origin;
  var_3[1] = var_1.other_col_point.origin;

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = 0;
    var_6 = 0;

    for (var_7 = var_2.size - 1; var_6 < var_2.size; var_6++) {
      if(var_2[var_6][1] > var_3[var_4][1] != var_2[var_7][1] > var_3[var_4][1] && var_3[var_4][0] < (var_2[var_7][0] - var_2[var_6][0]) * (var_3[var_4][1] - var_2[var_6][1]) / (var_2[var_7][1] - var_2[var_6][1]) + var_2[var_6][0])
        var_5 = !var_5;

      var_7 = var_6;
    }

    if(var_5)
      return 1;
  }

  return 0;
}

add_collision_offsets_to_path_ent(var_0, var_1, var_2) {
  var_3 = var_2.progress + 200;
  var_4 = var_1.progress - level.freedrive_dodge_static_early_distance;
  var_5 = undefined;
  var_6 = undefined;

  if(var_2.offset > var_1.offset) {
    var_5 = var_2.offset;
    var_6 = var_1.offset;
  } else {
    var_5 = var_1.offset;
    var_6 = var_2.offset;
  }

  var_7 = var_0;
  var_8 = var_3;
  var_9 = var_4;
  var_10 = var_5;
  var_11 = var_6;

  for (;;) {
    var_12 = get_segment_max_progress_at_offset(var_0, var_5);
    var_13 = get_segment_max_progress_at_offset(var_0, var_6);
    var_14 = max(var_12, var_13);
    var_15 = min(var_3, var_14);
    add_vol_to_node(var_0, var_15, var_4, var_5, var_6);

    if(!isdefined(var_0.next_node) || var_0 == var_0.next_node) {
      break;
    }

    var_3 = var_3 - var_14;
    var_4 = 0;

    if(var_3 <= 0) {
      break;
    }

    var_16 = get_position_from_spline(var_0, var_12, var_5);
    var_17 = get_position_from_spline(var_0, var_13, var_6);
    var_0 = var_0.next_node;
    var_18 = get_progression_between_points(var_16, var_0.midpoint, var_0.next_node.midpoint);
    var_5 = var_18["offset"];
    var_19 = get_progression_between_points(var_17, var_0.midpoint, var_0.next_node.midpoint);
    var_6 = var_19["offset"];
  }

  var_0 = var_7;
  var_3 = var_8;
  var_4 = var_9;
  var_5 = var_10;
  var_6 = var_11;

  for (;;) {
    if(!isdefined(var_0.prev_node) || var_0 == var_0.prev_node) {
      break;
    }

    if(var_4 > 0) {
      break;
    }

    var_16 = get_position_from_spline(var_0, 0, var_5);
    var_17 = get_position_from_spline(var_0, 0, var_6);
    var_0 = var_0.prev_node;
    var_18 = get_progression_between_points(var_16, var_0.midpoint, var_0.next_node.midpoint);
    var_5 = var_18["offset"];
    var_19 = get_progression_between_points(var_17, var_0.midpoint, var_0.next_node.midpoint);
    var_6 = var_19["offset"];
    var_3 = max(var_18["progress"], var_19["progress"]);
    var_4 = var_4 + var_3;
    add_vol_to_node(var_0, var_3, var_4, var_5, var_6);
  }
}

add_vol_to_node(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnstruct();
  var_5.colvol = [];
  var_5.colvol["max"] = var_1;
  var_5.colvol["min"] = var_2;

  if(var_5.colvol["min"] < 0)
    var_5.colvol["min"] = 0;

  if(isdefined(var_0.next_node) && var_0 != var_0.next_node) {}

  var_5.colvol["left_offset"] = var_4;
  var_5.colvol["right_offset"] = var_3;
  var_5.colvol["mid_offset"] = (var_3 + var_4) * 0.5;
  var_0.col_volumes[var_0.col_volumes.size] = var_5;
}

add_moving_obstacle(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.ent = self;
  var_2.bounds = var_0;

  if(isdefined(var_1) && var_1 == 1)
    var_2 thread remove_moving_obstacle_on_death();

  var_2 thread update_moving_object_volume();
}

remove_moving_obstacle_on_death() {
  level endon("stop_vehicle_free_path");
  self.ent endon("moving_obstacle_removed");
  self.ent waittill("death");
  remove_moving_obstacle();
}

remove_moving_obstacle() {
  unregister_moving_collision_on_nodes();
  self.ent notify("moving_obstacle_removed");
}

update_moving_object_volume() {
  level endon("stop_vehicle_free_path");
  self.ent endon("moving_obstacle_removed");
  self.ent endon("death");
  self.node = self.ent get_my_free_path_node(self.ent.origin);
  var_0 = self.ent get_progression_between_points(self.ent.origin, self.node.midpoint, self.node.next_node.midpoint);
  var_1 = self.ent move_to_correct_node(self.node, var_0["progress"], var_0["offset"]);
  self.node = var_1.node;

  for (;;) {
    var_0 = self.ent get_progression_between_points(self.ent.origin, self.node.midpoint, self.node.next_node.midpoint);
    var_1 = self.ent move_to_correct_node(self.node, var_0["progress"], var_0["offset"]);

    if(self.node != var_1.node)
      self.node = var_1.node;

    update_moving_collision_on_node();
    wait 0.1;
  }
}

update_moving_collision_on_node() {
  var_0 = anglestoforward(self.ent.angles);
  var_1 = anglestoright(self.ent.angles);
  self.corners = [];
  self.corners[0] = drop_point_to_ground(self.ent.origin + -1 * self.bounds["width"] / 2 * var_1 + self.bounds["length"] / 2 * var_0);
  self.corners[1] = drop_point_to_ground(self.ent.origin + self.bounds["width"] / 2 * var_1 + self.bounds["length"] / 2 * var_0);
  self.corners[2] = drop_point_to_ground(self.ent.origin + -1 * self.bounds["width"] / 2 * var_1 + -1 * self.bounds["length"] / 2 * var_0);
  self.corners[3] = drop_point_to_ground(self.ent.origin + self.bounds["width"] / 2 * var_1 + -1 * self.bounds["length"] / 2 * var_0);
  var_2 = [];
  var_2[0] = get_progression_between_points(self.corners[0], self.node.midpoint, self.node.next_node.midpoint);
  var_2[1] = get_progression_between_points(self.corners[1], self.node.midpoint, self.node.next_node.midpoint);
  var_2[2] = get_progression_between_points(self.corners[2], self.node.midpoint, self.node.next_node.midpoint);
  var_2[3] = get_progression_between_points(self.corners[3], self.node.midpoint, self.node.next_node.midpoint);
  var_3 = var_2[0]["offset"];
  var_4 = var_3;
  var_5 = var_2[0]["progress"];
  var_6 = var_5;

  for (var_7 = 1; var_7 < var_2.size; var_7++) {
    if(var_2[var_7]["offset"] < var_3)
      var_3 = var_2[var_7]["offset"];

    if(var_2[var_7]["offset"] > var_4)
      var_4 = var_2[var_7]["offset"];

    if(var_2[var_7]["progress"] < var_5)
      var_5 = var_2[var_7]["progress"];

    if(var_2[var_7]["progress"] > var_6)
      var_6 = var_2[var_7]["progress"];
  }

  var_6 = var_6 + 200;
  var_5 = var_5 - 200;
  unregister_moving_collision_on_nodes();
  register_moving_collision_on_nodes(var_6, var_5, var_4, var_3);
}

register_moving_collision_on_nodes(var_0, var_1, var_2, var_3) {
  var_4 = var_0;
  var_5 = var_1;
  var_6 = var_2;
  var_7 = var_3;
  var_8 = self.node;
  var_9 = var_8;

  for (;;) {
    var_10 = get_segment_max_progress_at_offset(var_9, var_2);
    var_11 = get_segment_max_progress_at_offset(var_9, var_3);
    var_12 = max(max(var_10, var_11), 0);
    var_13 = min(var_0, var_12);

    if(var_13 <= 0) {
      break;
    }

    add_moving_vol_to_node(var_9, var_13, var_1, var_2, var_3);

    if(!isdefined(var_9.next_node) || var_9 == var_9.next_node) {
      break;
    }

    var_0 = var_0 - var_12;
    var_1 = 0;

    if(var_0 <= 0) {
      break;
    }

    var_14 = get_position_from_spline(var_9, var_10, var_2);
    var_15 = get_position_from_spline(var_9, var_11, var_3);
    var_9 = var_9.next_node;
    var_16 = get_progression_between_points(var_14, var_9.midpoint, var_9.next_node.midpoint);
    var_2 = var_16["offset"];
    var_17 = get_progression_between_points(var_15, var_9.midpoint, var_9.next_node.midpoint);
    var_3 = var_17["offset"];
  }

  var_9 = var_8;
  var_0 = var_4;
  var_1 = var_5;
  var_2 = var_6;
  var_3 = var_7;

  for (;;) {
    if(!isdefined(var_9.prev_node) || var_9 == var_9.prev_node) {
      break;
    }

    if(var_1 > 0) {
      break;
    }

    var_14 = get_position_from_spline(var_9, 0, var_2);
    var_15 = get_position_from_spline(var_9, 0, var_3);
    var_9 = var_9.prev_node;
    var_16 = get_progression_between_points(var_14, var_9.midpoint, var_9.next_node.midpoint);
    var_2 = var_16["offset"];
    var_17 = get_progression_between_points(var_15, var_9.midpoint, var_9.next_node.midpoint);
    var_3 = var_17["offset"];
    var_0 = max(var_16["progress"], var_17["progress"]);
    var_1 = var_1 + var_0;

    if(var_0 <= 0) {
      break;
    }

    add_moving_vol_to_node(var_9, var_0, var_1, var_2, var_3);
  }
}

unregister_moving_collision_on_nodes() {
  foreach(var_1 in level.vehicle_free_path) {
    foreach(var_3 in var_1.col_moving_volumes) {
      if(var_3.owner == self)
        var_1.col_moving_volumes = common_scripts\utility::array_remove(var_1.col_moving_volumes, var_3);
    }
  }
}

add_moving_vol_to_node(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnstruct();
  var_5.colvol = [];
  var_5.owner = self;
  var_5.colvol["max"] = var_1;
  var_5.colvol["min"] = var_2;

  if(var_5.colvol["min"] < 0)
    var_5.colvol["min"] = 0;

  if(var_0.index != 0) {} else if(var_5.colvol["min"] < var_5.colvol["max"]) {
    return;
  }
  var_5.colvol["left_offset"] = var_4;
  var_5.colvol["right_offset"] = var_3;
  var_5.colvol["mid_offset"] = (var_3 + var_4) * 0.5;
  var_0.col_moving_volumes[var_0.col_moving_volumes.size] = var_5;
}

vehicle_drives_free_path(var_0, var_1) {
  level endon("stop_vehicle_free_path");
  var_0 endon("death");
  var_0 notify("enable_free_path");

  if(var_0.has_riders && !var_0.riders.size) {
    var_0 vehphys_crash();
    return;
  }

  var_2 = self;

  if(isdefined(var_1))
    var_0.starting_speed = var_1;
  else
    var_0.starting_speed = var_0 vehicle_getspeed();

  var_0.wipeout = 0;
  var_0.progress_node = var_2;
  var_0.progress = 0;
  var_0.endpos = var_0.origin;
  var_0.extra_lookahead = 0;
  var_0.move_fails = 0;
  var_0.path_timeout = gettime();
  common_scripts\utility::array_thread(var_0.riders, ::rider_death_detection, var_0);
  var_0 thread vehicle_death_watcher();
  update_vehicle_status(var_0);

  for (;;) {
    if(!isalive(var_0)) {
      break;
    }

    if(var_0.wipeout) {
      var_0 vehphys_crash();

      foreach(var_4 in var_0.riders) {
        if(isalive(var_4))
          var_4 kill();
      }

      var_0 kill();
      wait 5;

      if(isdefined(var_0))
        var_0 delete();

      update_vehicle_status();
      return;
    }

    if(!var_0.wipeout && var_0 vehicle_getspeed() < 2) {
      var_0.move_fails++;

      if(var_0.move_fails > 5)
        var_0 wipeout("move fail!");
    } else
      var_0.move_fails = 0;

    var_0 set_vehicle_goal_position();
    wait 0.05;
  }
}

set_vehicle_goal_position() {
  var_0 = self;
  var_1 = var_0.progress_node;

  if(var_1 == var_1.next_node) {
    return;
  }
  var_2 = get_progression_between_points(var_0.origin, var_1.midpoint, var_1.next_node.midpoint);
  var_3 = var_2["offset"];
  var_4 = var_1.road_width;
  var_5 = move_to_correct_node(var_1, var_2["progress"], var_3);
  var_6 = var_5.progress;
  var_7 = var_5.offset;
  var_1 = var_5.node;
  var_0.progress_node = var_1;
  var_0.progress = var_6;

  if(var_1 == var_1.next_node) {
    return;
  }
  var_8 = move_to_correct_node(var_1, var_6 + var_0.extra_lookahead, var_7);
  var_9 = var_8.progress;
  var_10 = var_8.offset;
  var_11 = var_8.node;
  var_12 = get_edge_offset_bounds_at_progress(var_11, var_9);
  var_13 = get_obstacle_dodge_amount(var_11, var_9, var_10, 1);
  var_14 = 0;

  if(isdefined(var_13["dodge1"])) {
    var_10 = var_13["dodge1"];
    var_14 = 1;

    if(isdefined(var_12["right"]) && var_10 > var_12["right"])
      var_10 = var_13["dodge2"];

    if(isdefined(var_12["left"]) && var_10 < var_12["left"])
      var_10 = var_13["dodge2"];
  }

  if(isdefined(var_12["right"]) && var_10 > var_12["right"]) {
    var_10 = var_12["right"];
    var_14 = 1;
  }

  if(isdefined(var_12["left"]) && var_10 < var_12["left"]) {
    var_10 = var_12["left"];
    var_14 = 1;
  }

  var_15 = 0;
  var_0.endpos = var_0 get_vehicle_pos_from_spline(var_11, var_9, var_10, var_15);
  var_16 = maps\_utility::get_dot(var_0.origin, var_0.angles, var_0.endpos);
  var_17 = 1.0;

  if(var_16 > 0.9659)
    var_17 = 1.0;
  else if(var_16 > 0.866)
    var_17 = 0.85;
  else if(var_16 > 0.7071)
    var_17 = 0.65;
  else if(var_16 > 0.5)
    var_17 = 0.4;
  else
    var_17 = 0.1;

  var_18 = max(var_0.starting_speed * var_17, level.freedrive_vehicle_min_allowed_speed);
  var_0 vehicledriveto(var_0.endpos, var_18);

  if(isdefined(level.player.drivingvehicle))
    var_0 match_player_speed(var_17);
}

get_obstacle_dodge_amount(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3) && var_3 == 1) {
    foreach(var_5 in var_0.col_volumes)
    var_5.has_veh_collision = 0;

    foreach(var_5 in var_0.col_moving_volumes)
    var_5.has_veh_collision = 0;
  }

  var_9 = [];
  var_10 = common_scripts\utility::array_combine(var_0.col_volumes, var_0.col_moving_volumes);

  foreach(var_5 in var_10) {
    if(var_5.has_veh_collision == 1) {
      continue;
    }
    if(isdefined(var_5.owner) && isdefined(var_5.owner.ent) && var_5.owner.ent == self) {
      continue;
    }
    if(var_1 < var_5.colvol["min"]) {
      continue;
    }
    if(var_1 > var_5.colvol["max"]) {
      continue;
    }
    if(var_2 < var_5.colvol["left_offset"]) {
      continue;
    }
    if(var_2 > var_5.colvol["right_offset"]) {
      continue;
    }
    var_12 = var_5.colvol["right_offset"] + 50;
    var_13 = var_5.colvol["left_offset"] - 50;
    var_5.has_veh_collision = 1;
    var_14 = get_obstacle_dodge_amount(var_0, var_1, var_12);
    var_15 = get_obstacle_dodge_amount(var_0, var_1, var_13);

    if(var_14.size > 0) {
      if(var_14["dodge1"] > var_12)
        var_12 = var_14["dodge1"];

      if(var_14["dodge2"] > var_12)
        var_12 = var_14["dodge2"];

      if(var_14["dodge1"] < var_13)
        var_13 = var_14["dodge1"];

      if(var_14["dodge2"] < var_13)
        var_13 = var_14["dodge2"];
    }

    if(var_15.size > 0) {
      if(var_15["dodge1"] > var_12)
        var_12 = var_15["dodge1"];

      if(var_15["dodge2"] > var_12)
        var_12 = var_15["dodge2"];

      if(var_15["dodge1"] < var_13)
        var_13 = var_15["dodge1"];

      if(var_15["dodge2"] < var_13)
        var_13 = var_15["dodge2"];
    }

    var_16 = (var_12 + var_13) * 0.5;

    if(var_2 > var_16) {
      var_9["dodge1"] = var_12;
      var_9["dodge2"] = var_13;
    } else {
      var_9["dodge1"] = var_13;
      var_9["dodge2"] = var_12;
    }

    break;
  }

  return var_9;
}

update_vehicle_status(var_0) {
  var_1 = [];

  foreach(var_3 in level.enemy_free_vehicles) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3.wipeout) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  level.enemy_free_vehicles = var_1;

  if(isalive(var_0) && !var_0.wipeout) {
    if(!common_scripts\utility::array_contains(level.enemy_free_vehicles, var_0)) {
      level.enemy_free_vehicles[level.enemy_free_vehicles.size] = var_0;

      if(1)
        level.enemy_free_vehicles = common_scripts\utility::array_sort_by_handler(level.enemy_free_vehicles, ::get_total_distance2d_on_path);
    }
  }

  var_5 = level.freedrive_progress_mod_default;
  var_6 = 200;

  foreach(var_3 in level.enemy_free_vehicles) {
    var_3.player_chase_progress_mod = var_5;
    var_5 = var_5 + level.freedrive_progress_mod_step;
    var_3.extra_lookahead = var_6;
    var_6 = var_6 + 100;
  }
}

get_total_distance2d_on_path() {
  var_0 = 0;
  var_1 = 0;
  var_2 = self.progress_node;

  if(!isdefined(var_2) || !isdefined(self.progress))
    return 0;

  var_3 = maps\_utility::getent_or_struct(var_2.target, "targetname");
  var_0 = self.progress;

  for (;;) {
    if(!isdefined(var_2.targetname)) {
      break;
    }

    var_3 = var_2;
    var_2 = maps\_utility::getent_or_struct(var_2.targetname, "target");

    if(!isdefined(var_2)) {
      break;
    }

    var_1++;
    var_0 = var_0 + distance2d(var_3.origin, var_2.origin);
  }

  return var_0;
}

distance2d_to_player() {
  return distance2dsquared(self.origin, level.player.origin);
}

vehicle_death_watcher() {
  self waittill("death");
  waitframe();
  update_vehicle_status();
}

rider_death_detection(var_0) {
  self waittill("death");

  if(isdefined(var_0))
    var_0 wipeout("driver died!");
}

vehicle_crash_detection() {
  level endon("stop_vehicle_free_path");
  self endon("death");

  for (;;) {
    self waittill("veh_contact", var_0, var_1, var_2, var_3, var_4);

    if(isdefined(var_3)) {
      var_5 = length(var_3) / 63360.0 * 60.0 * 60.0;

      if(var_5 > 20.0)
        wipeout("crash");
    }
  }
}

wipeout(var_0) {
  self.wipeout = 1;
}

match_player_speed(var_0) {
  if(!isdefined(level.player.drivingvehicle.progress_node))
    level.player.drivingvehicle.progress_node = get_my_free_path_node(level.player.drivingvehicle.origin);

  var_1 = get_progression_between_points(level.player.drivingvehicle.origin, level.player.drivingvehicle.progress_node.midpoint, level.player.drivingvehicle.progress_node.next_node.midpoint);
  var_2 = move_to_correct_node(level.player.drivingvehicle.progress_node, var_1["progress"], var_1["offset"]);
  var_3 = var_2.progress;
  var_4 = var_2.offset;
  level.player.drivingvehicle.progress_node = var_2.node;
  var_5 = progress_dif(self.progress_node, self.progress, var_2.node, var_2.progress);
  var_5 = var_5 - self.player_chase_progress_mod;

  if(var_5 < level.freedrive_playermatch_farbehind_delete_dist) {
    if(gettime() > self.path_timeout + 2000) {
      wipeout("too far behind");
      return;
    }
  } else if(var_5 > level.freedrive_playermatch_farahead_delete_dist) {
    if(gettime() > self.path_timeout + 2000) {
      wipeout("too far ahead");
      return;
    }
  } else
    self.path_timeout = gettime();

  if(var_0 < 0.6) {
    return;
  }
  var_6 = get_multiplier(var_5);
  var_7 = max(level.player.drivingvehicle vehicle_getspeed() * var_6, level.freedrive_vehicle_min_allowed_speed);

  if(self vehicle_isphysveh())
    self vehphys_setspeed(var_7);
  else
    self vehicle_setspeed(var_7);
}

get_multiplier(var_0) {
  var_1 = level.freedrive_playermatch_matched_multiplier;

  if(var_0 < level.freedrive_playermatch_catchup_ramp_start_dist)
    var_1 = level.freedrive_playermatch_catchup_multiplier;
  else if(var_0 > level.freedrive_playermatch_slowdown_ramp_end_dist)
    var_1 = level.freedrive_playermatch_slowdown_multiplier;
  else if(var_0 < level.freedrive_playermatch_catchup_ramp_end_dist) {
    var_2 = level.freedrive_playermatch_catchup_ramp_end_dist - level.freedrive_playermatch_catchup_ramp_start_dist;
    var_3 = (level.freedrive_playermatch_catchup_ramp_end_dist - var_0) / var_2;
    var_4 = level.freedrive_playermatch_catchup_multiplier - level.freedrive_playermatch_matched_multiplier;
    var_1 = var_3 * var_4 + level.freedrive_playermatch_matched_multiplier;
  } else if(var_0 > level.freedrive_playermatch_slowdown_ramp_start_dist) {
    var_2 = level.freedrive_playermatch_slowdown_ramp_end_dist - level.freedrive_playermatch_slowdown_ramp_start_dist;
    var_3 = (var_0 - level.freedrive_playermatch_slowdown_ramp_start_dist) / var_2;
    var_4 = level.freedrive_playermatch_slowdown_multiplier - level.freedrive_playermatch_matched_multiplier;
    var_1 = var_3 * var_4 + level.freedrive_playermatch_matched_multiplier;
  } else
    var_5 = level.freedrive_playermatch_matched_multiplier;

  return var_1;
}

progress_dif(var_0, var_1, var_2, var_3) {
  while (var_0.index > var_2.index) {
    var_0 = var_0.prev_node;
    var_1 = var_1 + var_0.dist_to_next_node;
  }

  while (var_2.index > var_0.index) {
    var_2 = var_2.prev_node;
    var_3 = var_3 + var_2.dist_to_next_node;
  }

  return var_1 - var_3;
}

get_progression_between_points(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = vectornormalize(var_2 - var_1);
  var_5 = var_0 - var_1;
  var_6 = vectordot(var_5, var_4);
  var_7 = var_1 + var_4 * var_6;
  var_3["progress"] = var_6;
  var_3["offset"] = distance2d(var_7, var_0);
  var_8 = anglestoright(vectortoangles(var_4));
  var_9 = vectornormalize(var_7 - var_0);
  var_10 = vectordot(var_8, var_9);
  var_3["side"] = "right";

  if(var_10 > 0) {
    var_3["offset"] = var_3["offset"] * -1;
    var_3["side"] = "left";
  }

  return var_3;
}

get_segment_max_progress_at_offset(var_0, var_1) {
  var_2 = var_0.dist_to_next_node;
  var_3 = undefined;

  if(var_1 > 0)
    var_3 = get_progression_between_points(var_0.next_node.origins["right"], var_0.midpoint, var_0.next_node.midpoint);
  else
    var_3 = get_progression_between_points(var_0.next_node.origins["left"], var_0.midpoint, var_0.next_node.midpoint);

  var_4 = var_1 / var_3["offset"];
  var_5 = (var_3["progress"] - var_2) * var_4;
  return var_5 + var_2;
}

get_edge_offset_bounds_at_progress(var_0, var_1) {
  var_2 = [];

  if(isdefined(var_0.next_node.origins["right_warning"])) {
    var_3 = get_progression_between_points(var_0.origins["right_warning"], var_0.midpoint, var_0.next_node.midpoint);
    var_4 = get_progression_between_points(var_0.next_node.origins["right_warning"], var_0.midpoint, var_0.next_node.midpoint);
    var_5 = var_1 / (var_4["progress"] - var_3["progress"]);
    var_2["right"] = var_3["offset"] + var_5 * (var_4["offset"] - var_3["offset"]);
  }

  if(isdefined(var_0.next_node.origins["left_warning"])) {
    var_3 = get_progression_between_points(var_0.origins["left_warning"], var_0.midpoint, var_0.next_node.midpoint);
    var_4 = get_progression_between_points(var_0.next_node.origins["left_warning"], var_0.midpoint, var_0.next_node.midpoint);
    var_5 = var_1 / (var_4["progress"] - var_3["progress"]);
    var_2["left"] = var_3["offset"] + var_5 * (var_4["offset"] - var_3["offset"]);
  }

  return var_2;
}

get_position_from_spline(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = 0;

  var_4 = vectortoangles(var_0.next_node.midpoint - var_0.midpoint);
  var_5 = anglestoforward(var_4);
  var_6 = anglestoright(var_4);
  return var_0.midpoint + var_5 * var_1 + var_6 * var_2;
}

get_vehicle_pos_from_spline(var_0, var_1, var_2, var_3) {
  var_4 = get_position_from_spline(var_0, var_1, var_2, var_3);
  return drop_point_to_ground(var_4);
}

drop_point_to_ground(var_0) {
  var_1 = physicstrace(var_0 + (0, 0, 100), var_0 + (0, 0, -100));

  if(var_1 == var_0 + (0, 0, -100)) {
    var_2 = bullettrace(var_0 + (0, 0, 100), var_0 + (0, 0, -100), 0, undefined, 0, 0, 1, 0, 0);

    if(var_2["position"] == var_1)
      return var_0;

    if(isdefined(var_2["surfacetype"]) && issubstr(var_2["surfacetype"], "water"))
      var_1 = var_2["position"];

    return var_0;
  }

  return var_1;
}

move_to_correct_node(var_0, var_1, var_2) {
  var_3 = spawnstruct();

  for (;;) {
    var_4 = var_0.dist_to_next_node;

    if(isdefined(var_2))
      var_4 = get_segment_max_progress_at_offset(var_0, var_2);

    if(var_1 > var_4) {
      if(var_0 == var_0.next_node) {
        break;
      }

      var_5 = get_position_from_spline(var_0, var_4, var_2);
      var_1 = var_1 - var_4;
      var_0 = var_0.next_node;
      var_6 = get_progression_between_points(var_5, var_0.midpoint, var_0.next_node.midpoint);
      var_2 = var_6["offset"];
      continue;
    }

    if(var_1 < 0) {
      if(var_0 == var_0.prev_node) {
        break;
      }

      var_5 = get_position_from_spline(var_0, 0, var_2);
      var_0 = var_0.prev_node;
      var_6 = get_progression_between_points(var_5, var_0.midpoint, var_0.next_node.midpoint);
      var_1 = var_1 + var_6["progress"];
      var_2 = var_6["offset"];
      continue;
    }

    break;
  }

  var_3.node = var_0;
  var_3.progress = var_1;
  var_3.offset = var_2;
  return var_3;
}

debug_free_path() {}

debug_draw_path() {
  level endon("stop_free_path_debug");
  iprintlnbold("!!!!DEBUG PATH!!!!");
  var_0 = undefined;
  var_1 = undefined;

  for (;;) {
    if(!isdefined(level.vehicle_free_path)) {
      wait 0.05;
      continue;
    }

    var_2 = level.vehicle_free_path;

    for (var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(isdefined(var_4.next_node.origins["left_warning"])) {

      }

      if(isdefined(var_4.next_node.origins["right_warning"])) {

      }

      foreach(var_6 in var_4.col_volumes)
      var_4 draw_col_vol(var_6.colvol, (0.5, 0, 1));

      foreach(var_6 in var_4.col_moving_volumes)
      var_4 draw_col_vol(var_6.colvol, (1, 0, 0.5));

      foreach(var_11 in var_4.col_lines) {
        var_12 = var_11.origin;
        var_13 = var_11.other_col_point.origin;
      }
    }

    wait 0.05;
  }
}

debug_bike_line(var_0) {
  var_1 = (0.2, 0.2, 1);

  if(var_0) {} else {}
}

draw_col_vol(var_0, var_1) {
  var_2 = get_position_from_spline(self, var_0["min"], var_0["left_offset"]);
  var_3 = get_position_from_spline(self, var_0["max"], var_0["left_offset"]);
  var_2 = get_position_from_spline(self, var_0["min"], var_0["right_offset"]);
  var_3 = get_position_from_spline(self, var_0["max"], var_0["right_offset"]);
  var_2 = get_position_from_spline(self, var_0["min"], var_0["right_offset"]);
  var_3 = get_position_from_spline(self, var_0["min"], var_0["left_offset"]);
  var_2 = get_position_from_spline(self, var_0["max"], var_0["right_offset"]);
  var_3 = get_position_from_spline(self, var_0["max"], var_0["left_offset"]);
}