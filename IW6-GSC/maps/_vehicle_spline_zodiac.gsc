/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle_spline_zodiac.gsc
*******************************************/

init_vehicle_splines() {
  common_scripts\utility::create_dvar("vehicle_spline_debug", 0);
  level.spline_min_progress = -2000;
  level.enemy_snowmobiles_max = 6;
  level.player_ent = spawn("script_origin", level.player.origin + (0, 0, 88));
  level.player_ent linkto(level.player);
  level.snowmobile_path = make_road_path();
  common_scripts\utility::flag_init("ai_snowmobiles_ram_player");
  common_scripts\utility::flag_set("ai_snowmobiles_ram_player");
  var_0 = getEntArray("enable_spline_path", "targetname");
  common_scripts\utility::array_thread(var_0, ::enable_spline_path_think);
}

enable_spline_path_think() {
  for(;;) {
    self waittill("trigger", var_0);
    var_0 notify("enable_spline_path");
  }
}

make_road_path() {
  level.drive_spline_path_fun = ::bike_drives_path;
  var_0 = process_path();
  common_scripts\utility::flag_init("race_complete");
  level.player_view_org = spawn("script_model", (0, 0, 0));
  level.player_view_org setModel("tag_origin");
  level.enemy_snowmobiles = [];
  level.bike_score = 0;
  level.player thread bike_death_score();
  return var_0;
}

bike_death_score() {
  self waittill("death");
}

get_guy_from_spawner() {
  var_0 = getent("spawner", "targetname");
  var_0.count = 1;
  var_0.origin = self.origin;
  var_0.angles = (0, self.angles[1], 0);
  return var_0 stalingradspawn();
}

orient_dir(var_0) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    self orientmode("face angle", var_0);
    wait 0.05;
  }
}

process_path() {
  var_0 = create_path();
  level.snowmobile_path = var_0;
  add_collision_to_path(var_0);
  return var_0;
}

droppedline(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 = common_scripts\utility::drop_to_ground(var_0);
  var_1 = common_scripts\utility::drop_to_ground(var_1);
  thread maps\_debug::linedraw(var_0, var_1, var_2, var_3, var_4, var_5);
}

droppedlinez(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = (var_1[0], var_1[1], var_0);
  var_1 = common_scripts\utility::drop_to_ground(var_1);
  var_2 = (var_2[0], var_2[1], var_0);
  var_2 = common_scripts\utility::drop_to_ground(var_2);
  thread maps\_debug::linedraw(var_1, var_2, var_3, var_4, var_5, var_6);
}

draw_path(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = vectortoangles(var_4.next_node.midpoint - var_4.midpoint);
    var_6 = anglesToForward(var_5) * var_4.dist_to_next_targ;
    var_7 = var_4.road_width * 0.5;
    var_8 = get_position_from_spline(var_4, 0, var_7);
    var_9 = get_position_from_spline(var_4, var_4.dist_to_next_targ, var_7);
    droppedlinez(var_4.z, var_8, var_9, (0, 0.5, 1), 1, 1, 50000);
    var_10 = get_position_from_spline(var_4, 0, var_7 * -1);
    var_11 = get_position_from_spline(var_4, var_4.dist_to_next_targ, var_7 * -1);
    droppedlinez(var_4.z, var_10, var_11, (0, 0.5, 1), 1, 1, 50000);
    droppedlinez(var_4.z, var_8, var_10, (0, 0.5, 1), 1, 1, 50000);
    droppedlinez(var_4.z, var_9, var_11, (0, 0.5, 1), 1, 1, 50000);

    foreach(var_13 in var_4.col_volumes)
    var_4 draw_col_vol(var_4.z, var_13);

    foreach(var_16 in var_4.col_lines) {
      var_17 = var_16.origin;
      var_18 = var_16.other_col_point.origin;
      droppedlinez(var_4.z, var_17, var_18, (1, 0, 0), 1, 1, 50000);
    }
  }
}

draw_col_vol(var_0, var_1) {
  var_2 = get_position_from_spline(self, var_1["min"], var_1["left_offset"]);
  var_3 = get_position_from_spline(self, var_1["max"], var_1["left_offset"]);
  droppedlinez(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
  var_2 = get_position_from_spline(self, var_1["min"], var_1["right_offset"]);
  var_3 = get_position_from_spline(self, var_1["max"], var_1["right_offset"]);
  droppedlinez(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
  var_2 = get_position_from_spline(self, var_1["min"], var_1["right_offset"]);
  var_3 = get_position_from_spline(self, var_1["min"], var_1["left_offset"]);
  droppedlinez(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
  var_2 = get_position_from_spline(self, var_1["max"], var_1["right_offset"]);
  var_3 = get_position_from_spline(self, var_1["max"], var_1["left_offset"]);
  droppedlinez(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
}

draw_col_vol_offset(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = get_position_from_spline(var_5, var_1["min"], var_1[var_2]);
  var_7 = get_position_from_spline(var_5, var_1["max"], var_1[var_2]);
  droppedlinez(var_0, var_6, var_7, (0.5, 0, 1), 1, 1, 50000);
}

create_path() {
  var_0 = common_scripts\utility::getstruct("road_path_left", "targetname");
  var_1 = [];
  var_0.origin = (var_0.origin[0], var_0.origin[1], 0);
  var_2 = 0;
  var_3 = var_0;

  for(;;) {
    var_4 = var_0;

    if(isDefined(var_0.target))
      var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");

    var_4.origin = (var_4.origin[0], var_4.origin[1], 0);
    var_1[var_1.size] = var_0;
    var_0.next_node = var_4;
    var_0.prev_node = var_3;
    var_4.previous_node = var_0;
    var_0.col_lines = [];
    var_0.col_volumes = [];
    var_0.col_radiuses = [];
    var_0.origins = [];
    var_0.dist_to_next_targs = [];
    var_0.origins["left"] = var_0.origin;
    var_0.index = var_2;
    var_2++;

    if(var_0 == var_4) {
      break;
    }

    var_3 = var_0;
    var_0 = var_4;
  }

  var_0 = common_scripts\utility::getstruct("road_path_right", "targetname");
  var_0.origin = (var_0.origin[0], var_0.origin[1], 0);
  var_5 = 0;

  for(;;) {
    var_4 = var_0;

    if(isDefined(var_0.target))
      var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");

    var_4.origin = (var_4.origin[0], var_4.origin[1], 0);
    var_6 = var_1[var_5];
    var_6.origins["right"] = var_0.origin;
    var_6.road_width = distance(var_6.origins["right"], var_6.origins["left"]);
    var_5++;

    if(var_0 == var_4) {
      break;
    }

    var_0 = var_4;
  }

  foreach(var_8 in var_1)
  var_8.midpoint = (var_8.origins["left"] + var_8.origins["right"]) * 0.5;

  foreach(var_8 in var_1) {
    var_11 = var_8.midpoint;
    var_12 = var_8.next_node.midpoint;
    var_13 = vectortoangles(var_11 - var_12);
    var_14 = anglestoright(var_13);
    var_15 = var_8.road_width * 0.5;
    var_8.origins["left"] = var_8.midpoint + var_14 * var_15;
    var_8.origins["right"] = var_8.midpoint + var_14 * var_15 * -1;
  }

  var_8 = var_1[var_1.size - 1].next_node;
  var_8.midpoint = (var_8.origins["left"] + var_8.origins["right"]) * 0.5;

  foreach(var_8 in var_1) {
    var_8.dist_to_next_targ = distance(var_8.midpoint, var_8.next_node.midpoint);
    var_8.dist_to_next_targs["left"] = distance(var_8.origins["left"], var_8.next_node.origins["left"]);
    var_8.dist_to_next_targs["right"] = distance(var_8.origins["right"], var_8.next_node.origins["right"]);
  }

  return var_1;
}

drop_path_to_ground(var_0) {
  var_1 = self;

  foreach(var_3 in var_0) {
    var_3.origin = var_3.origin + (0, 0, 20);
    var_4 = physicstrace(var_3.origin, var_3.origin + (0, 0, -100));
    var_3.origin = var_4;
  }
}

add_collision_to_path(var_0) {
  var_1 = common_scripts\utility::getstructarray("moto_line", "targetname");

  foreach(var_3 in var_1) {
    var_3.origin = (var_3.origin[0], var_3.origin[1], 0);
    var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
    var_3.other_col_point = var_4;
    var_4.other_col_point = var_3;
  }

  foreach(var_3 in var_1) {}

  var_8 = self;

  foreach(var_10 in var_0) {
    foreach(var_3 in var_1)
    add_collision_to_path_ent(var_10, var_3);
  }

  var_14 = getEntArray("moto_collision", "targetname");

  foreach(var_16 in var_14) {
    var_17 = common_scripts\utility::get_array_of_closest(var_16.origin, var_0, undefined, 2);

    foreach(var_10 in var_17)
    var_10.col_radiuses[var_10.col_radiuses.size] = var_16;
  }
}

get_offset_percent(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0.midpoint, var_1.midpoint);
  var_5 = 1 - var_2 / var_4;
  var_6 = "left";

  if(var_3 > 0)
    var_6 = "right";

  var_7 = var_0.origins[var_6];
  var_8 = var_1.origins[var_6];
  var_9 = var_7 * var_5 + var_8 * (1 - var_5);
  var_10 = var_0.midpoint;
  var_11 = var_1.midpoint;
  var_12 = var_10 * var_5 + var_11 * (1 - var_5);
  var_13 = distance(var_12, var_9);
  return var_3 / var_13;
}

add_collision_to_path_ent(var_0, var_1) {
  if(var_0 == var_0.next_node) {
    return;
  }
  var_2 = var_0.road_width;

  if(var_0.dist_to_next_targ > var_2)
    var_2 = var_0.dist_to_next_targ;

  if(distance(var_1.origin, var_0.next_node.midpoint) > var_2 * 1.5) {
    return;
  }
  var_3 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_4 = get_progression_between_points(var_1.origin, var_0.midpoint, var_0.next_node.midpoint);
  var_5 = var_4["progress"];
  var_6 = get_progression_between_points(var_3.origin, var_0.midpoint, var_0.next_node.midpoint);
  var_7 = var_6["progress"];

  if(var_5 < 0 || var_7 < 0) {
    return;
  }
  if(var_5 > var_0.dist_to_next_targ && var_7 > var_0.dist_to_next_targ) {
    return;
  }
  var_1.claimed = 1;
  var_3.claimed = 1;
  var_1.progress = var_5;
  var_1.offset = var_4["offset"];
  var_1.offset_percent = get_offset_percent(var_0, var_0.next_node, var_5, var_4["offset"]);
  var_3.progress = var_7;
  var_3.offset = var_6["offset"];
  var_3.offset_percent = get_offset_percent(var_0, var_0.next_node, var_7, var_6["offset"]);
  var_1.origin = (var_1.origin[0], var_1.origin[1], var_0.midpoint[2] + 40);
  var_3.origin = (var_3.origin[0], var_3.origin[1], var_0.midpoint[2] + 40);

  if(var_5 < var_7) {
    add_collision_offsets_to_path_ent(var_0, var_1, var_3);
    var_0.col_lines[var_0.col_lines.size] = var_1;
  } else {
    add_collision_offsets_to_path_ent(var_0, var_3, var_1);
    var_0.col_lines[var_0.col_lines.size] = var_3;
  }
}

add_collision_offsets_to_path_ent(var_0, var_1, var_2) {
  var_3 = var_2.progress + 200;
  var_4 = var_1.progress - level.dodge_distance;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  if(var_2.offset > var_1.offset) {
    var_5 = var_2.offset;
    var_6 = var_1.offset;
    var_7 = var_2.offset_percent;
    var_8 = var_1.offset_percent;
  } else {
    var_5 = var_1.offset;
    var_6 = var_2.offset;
    var_7 = var_1.offset_percent;
    var_8 = var_2.offset_percent;
  }

  var_9 = var_0;
  var_10 = var_3;
  var_11 = var_4;

  for(;;) {
    add_vol_to_node(var_0, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_0.next_node)) {
      break;
    }

    if(var_0.dist_to_next_targ >= var_3) {
      break;
    }

    var_3 = var_3 - var_0.dist_to_next_targ;
    var_0 = var_0.next_node;
    var_4 = 0;
  }

  var_0 = var_9;
  var_3 = var_10;
  var_4 = var_11;

  for(;;) {
    if(!isDefined(var_0.previous_node)) {
      break;
    }

    if(var_4 > 0) {
      break;
    }

    var_0 = var_0.previous_node;
    var_3 = var_0.dist_to_next_targ;
    var_4 = var_0.dist_to_next_targ + var_4;
    add_vol_to_node(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

add_vol_to_node(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_7["max"] = var_1;

  if(var_7["max"] > var_0.dist_to_next_targ)
    var_7["max"] = var_0.dist_to_next_targ;

  var_7["min"] = var_2;

  if(var_7["min"] < 0)
    var_7["min"] = 0;

  var_7["left_offset"] = var_4;
  var_7["right_offset"] = var_3;
  var_7["left_offset_percent"] = var_6;
  var_7["right_offset_percent"] = var_5;
  var_7["mid_offset"] = (var_3 + var_4) * 0.5;
  var_7["mid_offset_percent"] = (var_5 + var_6) * 0.5;
  var_0.col_volumes[var_0.col_volumes.size] = var_7;
}

get_progression_between_points(var_0, var_1, var_2) {
  var_1 = (var_1[0], var_1[1], 0);
  var_2 = (var_2[0], var_2[1], 0);
  var_0 = (var_0[0], var_0[1], 0);
  var_3 = [];
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = anglesToForward(var_4);
  var_6 = var_1;
  var_7 = vectornormalize(var_6 - var_0);
  var_8 = vectordot(var_5, var_7);
  var_9 = vectornormalize(var_2 - var_1);
  var_10 = var_0 - var_1;
  var_11 = vectordot(var_10, var_9);
  var_12 = var_1 + var_5 * var_11;
  var_3["progress"] = var_11;
  var_3["offset"] = distance(var_12, var_0);
  var_13 = anglestoright(var_4);
  var_7 = vectornormalize(var_12 - var_0);
  var_8 = vectordot(var_13, var_7);
  var_3["dot"] = var_8;

  if(var_8 > 0)
    var_3["offset"] = var_3["offset"] * -1;

  return var_3;
}

wipe_out(var_0) {
  foreach(var_2 in self.targ.col_radiuses) {
    var_3 = (self.origin[0], self.origin[1], 0);

    if(distance((var_2.origin[0], var_2.origin[1], 0), var_3) < var_2.radius)
      return 1;
  }

  if(var_0.health >= 100)
    return 0;

  level.bike_score++;
  return 1;
}

vehicle_line(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;)
    wait 0.05;
}

spawner_random_team() {
  waittillframeend;

  if(!isDefined(self.riders)) {
    return;
  }
  var_0 = "axis";

  if(common_scripts\utility::cointoss())
    var_0 = "allies";

  foreach(var_2 in self.riders)
  var_2.team = var_0;
}

get_spawn_position(var_0, var_1) {
  var_2 = move_to_correct_segment(var_0, var_1);
  var_3 = var_2.progress;
  var_4 = var_2.targ;
  var_5 = var_4.road_width * 0.5;
  var_6 = undefined;

  if(isDefined(level.player.nooffset))
    var_6 = 0;
  else if(isDefined(level.player.offset)) {
    var_7 = 500;

    if(common_scripts\utility::cointoss())
      var_7 = var_7 * -1;

    var_6 = level.player.offset + var_7;
  } else
    var_6 = randomfloatrange(var_5 * -1, var_5);

  var_8 = get_obstacle_dodge_amount(var_4, var_3, var_6);

  if(isDefined(var_8["dodge"]))
    var_6 = var_8["dodge"];

  var_9 = get_position_from_spline_unlimited(var_4, var_3, var_6);
  var_10 = [];
  var_10["spawn_pos"] = var_9;
  var_10["progress"] = var_3;
  var_10["targ"] = var_4;
  var_10["offset"] = var_6;
  return var_10;
}

debug_enemy_vehicles() {}

debug_enemy_vehicles_line() {
  self endon("death");
  level endon("stop_debugging_enemy_vehicles");

  for(;;)
    wait 0.05;
}

spawn_enemy_bike() {
  if(level.enemy_snowmobiles.size >= level.enemy_snowmobiles_max) {
    return;
  }
  var_0 = get_player_targ();
  var_1 = get_player_progress();
  var_2 = "forward";
  var_3 = get_spawn_position(var_0, var_1 - 1000 - level.pos_lookahead_dist);
  var_4 = var_3["spawn_pos"];
  var_5 = common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_4, 0);

  if(distance(var_4, level.player.origin) < 140) {
    return;
  }
  if(var_5) {
    var_3 = get_spawn_position(var_0, var_1 + 1000);
    var_4 = var_3["spawn_pos"];
    var_2 = "backward";
    var_5 = common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_4, 0);

    if(var_5)
      return;
  }

  var_4 = common_scripts\utility::drop_to_ground(var_4);
  var_6 = getent("snowmobile_spawner", "targetname");
  var_7 = var_3["targ"];
  var_6.origin = var_4;
  var_6.angles = vectortoangles(var_7.next_node.midpoint - var_7.midpoint);
  var_8 = var_6 maps\_vehicle_code::get_vehicle_ai_spawners();

  foreach(var_10 in var_8)
  var_10.origin = var_6.origin;

  var_12 = maps\_vehicle::vehicle_spawn(var_6);
  var_12.offset_percent = var_3["offset"];
  var_12 vehphys_setspeed(90);
  var_12 thread crash_detection();
  var_12.left_spline_path_time = gettime() - 3000;
  var_7 bike_drives_path(var_12);
}

crash_detection() {
  self waittill("veh_collision", var_0, var_1);
  wipeout("collision!");
}

rider_death_detection(var_0) {
  if(self.vehicle_position != 0) {
    return;
  }
  self waittill("death");

  if(isDefined(var_0))
    var_0 wipeout("driver died!");
}

wipeout(var_0) {
  self.wipeout = 1;
}

update_bike_player_avoidance(var_0) {
  var_1 = [];

  foreach(var_3 in level.enemy_snowmobiles) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3.wipeout) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  level.enemy_snowmobiles = var_1;

  if(isalive(var_0) && !var_0.wipeout) {
    var_5 = 0;

    foreach(var_3 in level.enemy_snowmobiles) {
      if(var_3 == var_0) {
        var_5 = 1;
        continue;
      }
    }

    if(!var_5)
      level.enemy_snowmobiles[level.enemy_snowmobiles.size] = var_0;
  }

  var_8 = 0;

  foreach(var_3 in level.enemy_snowmobiles) {
    var_3.bike_avoidance_offset = var_8;
    var_8 = var_8 + 120;
  }
}

bike_drives_path(var_0) {
  if(!isDefined(var_0.left_spline_path_time))
    var_0.left_spline_path_time = gettime();

  if(!isDefined(var_0.wipeout))
    var_0.wipeout = 0;

  var_0.bike_avoidance_offset = 0;
  update_bike_player_avoidance(var_0);

  if(!isDefined(var_0.player_offset))
    var_0.player_offset = 250;

  var_0.steering = 0;
  var_1 = randomfloatrange(0, 1);

  if(!isDefined(var_0.offset_percent))
    var_0.offset_percent = var_1 * 2 - 1;

  var_2 = self;
  var_3 = spawnStruct();
  var_3.origin = self.midpoint;
  var_3.progress = 0;
  var_3.tilt_vel = 0;
  var_3.speed = 100;
  var_3 maps\_utility::ent_flag_init("biker_reaches_path_end");
  var_0 maps\_utility::ent_flag_init("dialog_six");
  var_0 notify("enable_spline_path");
  common_scripts\utility::array_thread(var_0.riders, ::rider_death_detection, var_0);
  var_3.bike = var_0;
  var_0.health = 100;
  var_4 = 0;
  var_3 thread bike_ent_wipe_out_check(var_0);
  var_0.progress_targ = var_2;
  var_0.offset_modifier = 0;
  var_0.fails = 0;
  var_0.direction = "forward";
  var_0.old_pos = var_0.origin;

  for(;;) {
    if(!isalive(var_0)) {
      break;
    }

    set_bike_position(var_3);

    if(!isalive(var_0)) {
      break;
    }

    if(abs(var_0.progress_dif) > 6000 && gettime() > var_0.left_spline_path_time + 4000)
      var_0 wipeout("left behind!");

    waittillframeend;

    if(var_0.wipeout) {
      if(isDefined(var_0.hero)) {
        continue;
      }
      var_0 vehicle_setspeed(0, 5, 5);
      var_0 common_scripts\utility::delaycall(randomfloatrange(0.25, 1), ::vehphys_crash);

      foreach(var_6 in var_0.riders) {
        if(isai(var_6) && isalive(var_6)) {
          var_6 kill();
          continue;
        }

        if(isDefined(var_6)) {
          var_6 startragdoll();
          var_6 notify("newanime");
        }
      }

      wait 5;

      if(isDefined(var_0))
        var_0 delete();

      update_bike_player_avoidance();
      return;
    }

    if(var_3 maps\_utility::ent_flag("biker_reaches_path_end") || common_scripts\utility::flag("race_complete")) {
      break;
    }
  }

  update_bike_player_avoidance();
  var_3 notify("stop_bike");
  level notify("biker_dies");

  if(isalive(var_0) && var_0.wipeout && !common_scripts\utility::flag("race_complete"))
    wait 5;

  var_3 maps\_utility::ent_flag_clear("biker_reaches_path_end");
}

get_obstacle_dodge_amount(var_0, var_1, var_2) {
  var_3["near_obstacle"] = 0;

  foreach(var_5 in var_0.col_volumes) {
    if(var_1 < var_5["min"]) {
      continue;
    }
    if(var_1 > var_5["max"]) {
      continue;
    }
    var_3["near_obstacle"] = 1;

    if(var_2 < var_5["left_offset"]) {
      continue;
    }
    if(var_2 > var_5["right_offset"]) {
      continue;
    }
    var_6 = (var_0.midpoint + var_0.next_node.midpoint) * 0.5;

    if(var_2 > var_5["mid_offset"])
      var_3["dodge"] = var_5["right_offset"];
    else
      var_3["dodge"] = var_5["left_offset"];

    break;
  }

  return var_3;
}

sweep_tells_vehicles_to_get_off_path() {
  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(var_0.script_noteworthy)) {
      continue;
    }
    if(var_0.script_noteworthy != "sweepable") {
      continue;
    }
    var_1 = randomfloatrange(0, 1);
    var_0 thread maps\_utility::notify_delay("enable_spline_path", var_1);
  }
}

drawmyoff() {
  for(;;) {
    if(isDefined(level.player.vehicle)) {
      var_0 = self vehicle_getspeed();
      var_1 = level.player.vehicle vehicle_getspeed();
      level.difference = var_0 - var_1;
    }

    wait 0.05;
  }
}

priceliner() {}

update_position_on_spline() {
  self.targ = maps\_vehicle_code::get_my_spline_node(self.origin);
  var_0 = self.origin;

  for(;;) {
    wait 0.05;
    var_1 = self.targ;

    if(var_1 == var_1.next_node) {
      return;
    }
    var_2 = get_progression_between_points(self.origin, self.targ.midpoint, self.targ.next_node.midpoint);
    var_3 = var_2["progress"];
    var_4 = distance(self.origin, var_0);
    var_3 = var_3 + var_4;
    var_0 = self.origin;
    var_5 = move_to_correct_segment(self.targ, var_3);
    var_3 = var_5.progress;
    self.targ = var_5.targ;
    self.progress = var_3;
  }
}

modulate_speed_based_on_progress() {
  thread priceliner();
  self.targ = maps\_vehicle_code::get_my_spline_node(self.origin);
  self.min_speed = 1;
  self endon("stop_modulating_speed");
  var_0 = undefined;

  for(;;) {
    wait 0.05;
    var_1 = self.targ;

    if(var_1 == var_1.next_node) {
      return;
    }
    var_2 = get_progression_between_points(self.origin, self.targ.midpoint, self.targ.next_node.midpoint);
    var_3 = var_2["progress"];
    var_3 = var_3 + level.pos_lookahead_dist;
    var_4 = move_to_correct_segment(self.targ, var_3);
    var_3 = var_4.progress;
    self.targ = var_4.targ;
    self.progress = var_3;
    var_5 = get_player_targ();
    var_6 = get_player_progress();
    var_7 = progress_dif(self.targ, self.progress, var_5, var_6);
    level.progress_dif = var_7;

    if(!isDefined(level.player.vehicle)) {
      self vehicle_setspeed(65, 1, 1);
      continue;
    }

    if(abs(var_7 > 3500)) {
      var_8 = 65;
      var_7 = var_7 * -1;
      var_7 = var_7 + 750;
      var_8 = level.player.vehicle.veh_speed + var_7 * 0.05;
      var_9 = level.player.vehicle.veh_speed;

      if(var_9 < 100)
        var_9 = 100;

      if(var_8 > var_9)
        var_8 = var_9;
      else if(var_8 < self.min_speed)
        var_8 = self.min_speed;

      level.desired_speed = var_8;
      self vehicle_setspeed(var_8, 90, 20);
      continue;
    }

    price_match_player_speed(10, 10);
  }
}

price_match_player_speed(var_0, var_1) {
  var_2 = self.angles;
  var_2 = (0, var_2[1], 0);
  var_3 = anglesToForward(var_2);
  var_4 = get_progression_between_points(level.player.vehicle.origin, self.origin + var_3 * 1, self.origin - var_3 * 1);
  var_5 = var_4["progress"];

  if(var_5 > 4000)
    self vehicle_setspeed(0, 90, 20);
  else {
    var_6 = maps\_utility::get_dot(self.origin, self.angles, level.player.origin);
    var_7 = 1;

    if(var_5 > 0)
      var_7 = 1;
    else {
      if(var_5 > -500)
        var_7 = 1.25;

      if(var_7 > 0.95 && var_6 > 0.97)
        var_7 = 0.95;
    }

    var_8 = 70 * var_7;

    if(var_8 < self.min_speed)
      var_8 = self.min_speed;

    if(var_8 < 25)
      var_8 = 25;

    level.price_desired_speed = var_8;
    self vehicle_setspeed(var_8, var_0, var_1);
  }
}

match_player_speed(var_0, var_1) {
  var_2 = self.angles;
  var_2 = (0, var_2[1], 0);
  var_3 = anglesToForward(var_2);
  var_4 = get_progression_between_points(level.player.vehicle.origin, self.origin + var_3 * 1, self.origin - var_3 * 1);
  var_5 = var_4["progress"];

  if(var_5 > 4000)
    self vehicle_setspeed(0, 90, 20);
  else {
    if(var_5 < level.spline_min_progress && gettime() > self.left_spline_path_time + 4000)
      wipeout("low progress!");

    var_5 = var_5 - 750;
    var_5 = var_5 + self.bike_avoidance_offset;
    var_6 = 1;

    if(var_5 > 150)
      var_6 = 0.6;
    else if(var_5 > 100)
      var_6 = 1.0;
    else if(var_5 < -100) {
      if(!maps\_utility::ent_flag("dialog_six")) {
        maps\_utility::ent_flag_set("dialog_six");
        maps\_utility::delaythread(12, maps\_utility::ent_flag_clear, "dialog_six");
        level notify("dialog_six");
      }

      var_6 = 1.5;
    }

    if(isDefined(level.player.offset)) {
      if(var_5 > 250) {}
    }

    var_7 = level.player.vehicle.veh_speed * var_6;

    if(var_7 < 25)
      var_7 = 25;

    self vehicle_setspeed(var_7, var_0, var_1);
  }
}

track_player_progress(var_0) {
  self.targ = maps\_vehicle_code::get_my_spline_node(var_0);
  self.progress = 0;
  var_1 = getent("player_sweep_trigger", "targetname");
  var_2 = isDefined(var_1);

  if(var_2)
    var_1 thread sweep_tells_vehicles_to_get_off_path();

  for(;;) {
    if(self.targ == self.targ.next_node) {
      return;
    }
    var_3 = get_progression_between_points(self.origin, self.targ.midpoint, self.targ.next_node.midpoint);
    var_4 = var_3["progress"];
    var_4 = var_4 + level.pos_lookahead_dist;
    var_5 = move_to_correct_segment(self.targ, var_4);
    var_4 = var_5.progress;
    self.targ = var_5.targ;
    self.progress = var_4;
    self.offset = var_3["offset"];

    if(var_2) {
      var_6 = get_position_from_spline_unlimited(self.targ, var_4 + 2000, 0);
      var_6 = (var_6[0], var_6[1], self.origin[2] - 500);
      var_1.origin = var_6;
      var_7 = get_position_from_spline_unlimited(self.targ, var_4 + 3000, 0);
      var_8 = vectortoangles(var_1.origin - var_7);
      var_1.angles = (0, var_8[1], 0);
    }

    if(common_scripts\utility::flag("ai_snowmobiles_ram_player")) {
      level.enemy_snowmobiles = maps\_utility::array_removedead(level.enemy_snowmobiles);
      level.closest_enemy_snowmobile_to_player = common_scripts\utility::getclosest(self.origin, level.enemy_snowmobiles);
    } else
      level.closest_enemy_snowmobile_to_player = undefined;

    wait 0.05;
  }
}

progress_dif(var_0, var_1, var_2, var_3) {
  while(var_0.index > var_2.index) {
    var_0 = var_0.prev_node;
    var_1 = var_1 + var_0.dist_to_next_targ;
  }

  while(var_2.index > var_0.index) {
    var_2 = var_2.prev_node;
    var_3 = var_3 + var_2.dist_to_next_targ;
  }

  return var_1 - var_3;
}

set_bike_position(var_0) {
  var_1 = var_0.bike;
  var_2 = 0.1;
  var_3 = 0;
  var_4 = 0;
  var_5 = var_1.progress_targ;

  if(var_5 == var_5.next_node) {
    var_1 delete();
    return;
  }

  var_6 = get_progression_between_points(var_1.origin, var_5.midpoint, var_5.next_node.midpoint);
  var_7 = get_progression_between_points(var_1.origin, var_5.next_node.midpoint, var_5.next_node.next_node.midpoint);

  if(var_7["progress"] > 0 && var_7["progress"] < var_5.next_node.dist_to_next_targ) {
    var_6 = var_7;
    var_5 = var_5.next_node;
  }

  var_4 = var_6["offset"];
  var_8 = 0;
  var_3 = var_6["progress"];
  var_1.progress = var_3;
  var_9 = get_obstacle_dodge_amount(var_5, var_3, var_4);
  var_10 = var_9["near_obstacle"];
  var_11 = progress_dif(var_5, var_3, get_player_targ(), get_player_progress());
  var_1.progress_dif = var_11;

  if(var_1.direction == "forward")
    var_3 = var_3 + level.pos_lookahead_dist;
  else {
    var_3 = var_3 - level.pos_lookahead_dist;

    if(var_11 < 500)
      var_1.direction = "forward";
  }

  var_12 = 60;
  var_13 = 90;
  var_14 = 100;
  var_15 = 200;

  if(var_11 > var_15)
    var_16 = var_12;
  else if(var_11 < var_14)
    var_16 = var_13;
  else {
    var_17 = var_15 - var_14;
    var_18 = var_13 - var_12;
    var_16 = var_11 - var_14;
    var_16 = var_17 - var_16;
    var_16 = var_16 * (var_18 / var_17);
    var_16 = var_16 + var_12;
  }

  if(var_16 > 0) {
    if(var_1 vehicle_getspeed() < 2) {
      var_1.fails++;

      if(var_1.fails > 10) {
        var_1 wipeout("move fail!");
        return;
      }
    } else
      var_1.fails = 0;
  } else
    var_1.fails = 0;

  var_19 = randomfloatrange(0, 100);
  var_19 = var_19 * 0.001;
  var_20 = 0;
  var_21 = var_5.road_width;
  var_0 = move_to_correct_segment(var_5, var_3);
  var_3 = var_0.progress;
  var_5 = var_0.targ;
  var_22 = (var_5.midpoint + var_5.next_node.midpoint) * 0.5;
  var_4 = var_4 * var_5.road_width / var_21;
  var_9 = get_obstacle_dodge_amount(var_5, var_3, var_4);

  if(isDefined(var_9["dodge"]))
    var_4 = var_9["dodge"];
  else if(isDefined(var_1.preferred_offset))
    var_4 = var_1.preferred_offset;

  var_23 = 0.95;
  var_24 = var_5.road_width * 0.5;
  var_24 = var_24 - 50;

  if(var_4 > var_24)
    var_4 = var_24;
  else if(var_4 < -1 * var_24)
    var_4 = -1 * var_24;

  if(var_5 != var_5.next_node) {
    var_25 = var_1 get_bike_pos_from_spline(var_5, var_3, var_4, var_1.origin[2]);
    var_26 = maps\_utility::get_dot(var_1.origin, var_1.angles, var_25);

    if(var_26 < 0.97)
      var_16 = 50;
    else if(var_26 < 0.96)
      var_16 = 25;
    else if(var_26 < 0.95)
      var_16 = 15;

    var_1 vehicledriveto(var_25, var_16);

    if(!isDefined(level.player.vehicle))
      var_1 vehicle_setspeed(65, 1, 1);
    else {
      var_1.veh_topspeed = level.player.vehicle.veh_topspeed * 1.3;
      var_1 match_player_speed(45, 30);
    }
  }

  var_1.progress_targ = var_5;
  var_1.offset = var_4;
  wait(var_2);
}

get_bike_pos_from_spline(var_0, var_1, var_2, var_3) {
  var_4 = get_position_from_spline(var_0, var_1, var_2);
  var_4 = maps\_utility::set_z(var_4, var_3);
  return physicstrace(var_4 + (0, 0, 200), var_4 + (0, 0, -200));
}

move_to_correct_segment(var_0, var_1) {
  var_2 = spawnStruct();

  for(;;) {
    if(var_0 == var_0.next_node) {
      break;
    }

    if(var_1 > var_0.dist_to_next_targ) {
      var_1 = var_1 - var_0.dist_to_next_targ;
      var_0 = var_0.next_node;
      continue;
    }

    if(var_1 < 0) {
      var_1 = var_1 + var_0.dist_to_next_targ;
      var_0 = var_0.prev_node;
      continue;
    }

    break;
  }

  var_2.targ = var_0;
  var_2.progress = var_1;
  return var_2;
}

get_position_from_spline_unlimited(var_0, var_1, var_2) {
  for(;;) {
    if(var_0 == var_0.next_node)
      return var_0.midpoint;

    if(var_1 > var_0.dist_to_next_targ) {
      var_1 = var_1 - var_0.dist_to_next_targ;
      var_0 = var_0.next_node;
      continue;
    }

    break;
  }

  return get_position_from_spline(var_0, var_1, var_2);
}

get_position_from_spline(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_0.next_node.midpoint - var_0.midpoint);
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  return var_0.midpoint + var_4 * var_1 + var_5 * var_2;
}

get_position_from_progress(var_0, var_1) {
  var_2 = 1 - var_1 / var_0.dist_to_next_targ;
  return var_0.midpoint * var_2 + var_0.next_node.midpoint * (1 - var_2);
}

bike_ent_wipe_out_check(var_0) {
  self endon("stop_bike");

  for(;;) {
    self.wipeout = 0;

    if(self.wipeout) {
      break;
    }

    wait 0.05;
  }
}

draw_bike_debug() {
  for(;;) {
    waittillframeend;
    wait 0.05;
  }
}

track_progress() {
  self endon("stop_bike");

  for(;;) {
    var_0 = (self.origin[0], self.origin[1], 0);
    var_1 = (self.targ.midpoint[0], self.targ.midpoint[1], 0);
    var_2 = (self.next_targ.midpoint[0], self.next_targ.midpoint[1], 0);
    var_3 = vectornormalize(var_1 - var_0);
    var_4 = anglesToForward(self.angles);
    var_5 = vectordot(var_4, var_3);
    var_6 = vectornormalize(var_2 - var_1);
    var_7 = var_0 - var_1;
    self.progress = vectordot(var_7, var_6);
    wait 0.05;
  }
}

set_road_offset(var_0) {
  self.right_offset = var_0.road_width * 0.5;
  self.safe_offset = self.right_offset - 100;
}

bike_avoids_obstacles(var_0) {
  self endon("stop_bike");
  self endon("end_path");
  self.goal_dir = 0;
  thread bike_randomly_changes_lanes();
  bike_turns();
}

bike_randomly_changes_lanes() {
  self endon("stop_bike");
  self endon("end_path");

  for(;;) {
    if(self.targ.col_volumes.size == 0 && self.dodge_dir == 0) {
      if(common_scripts\utility::cointoss())
        self.goal_dir++;
      else
        self.goal_dir--;

      if(self.goal_dir > 1)
        self.goal_dir = self.goal_dir - 3;
      else if(self.goal_dir < -1)
        self.goal_dir = self.goal_dir + 3;
    }

    wait(randomfloatrange(1, 3));
  }
}

should_stabilize() {
  if(self.goal_dir == 0)
    return 1;

  if(self.goal_dir == 1 && self.offset > self.safe_offset)
    return 1;

  if(self.goal_dir == -1 && self.offset < self.safe_offset * -1)
    return 1;

  return 0;
}

bike_turns() {
  self.tilt_vel = 0;
  var_0 = 12;
  var_1 = 3;
  var_2 = 130;

  for(;;) {
    if(should_stabilize()) {
      if(self.tilt > 0)
        self.tilt_vel = self.tilt_vel - var_1;
      else if(self.tilt < 0)
        self.tilt_vel = self.tilt_vel + var_1;
    } else if(self.goal_dir == 1)
      self.tilt_vel = self.tilt_vel + var_1;
    else if(self.goal_dir == -1)
      self.tilt_vel = self.tilt_vel - var_1;

    if(self.tilt_vel > var_0)
      self.tilt_vel = var_0;
    else if(self.tilt_vel < -1 * var_0)
      self.tilt_vel = -1 * var_0;

    self.tilt = self.tilt + self.tilt_vel;

    if(self.tilt > var_2) {
      self.tilt = var_2;
      self.tilt_vel = 1;
    } else if(self.tilt < var_2 * -1) {
      self.tilt = var_2 * -1;
      self.tilt_vel = -1;
    }

    wait 0.05;
  }
}

stabalize(var_0, var_1) {
  if(self.tilt > 0)
    self.tilt = self.tilt - var_1;
  else
    self.tilt = self.tilt + var_1;

  if(abs(self.tilt) < var_1)
    self.tilt = var_1;
}

tilt_right(var_0, var_1) {
  if(self.offset >= self.safe_offset) {
    self.goal_dir = 0;
    return;
  }

  self.tilt = self.tilt + var_1;

  if(self.tilt >= var_0)
    self.tilt = var_0;
}

tilt_left(var_0, var_1) {
  if(self.offset < self.safe_offset * -1) {
    self.goal_dir = 0;
    return;
  }

  self.tilt = self.tilt - var_1;

  if(self.tilt < var_0 * -1)
    self.tilt = var_0 * -1;
}

get_player_progress() {
  if(isDefined(level.player.progress))
    return level.player.progress;

  return 0;
}

get_player_targ() {
  if(isDefined(level.player.targ))
    return level.player.targ;

  return level.snowmobile_path[0];
}

debug_bike_line() {
  var_0 = (0.2, 0.2, 1);

  if(isDefined(level.player.vehicle) && self.veh_speed > level.player.vehicle.veh_speed)
    var_0 = (1, 0.2, 0.2);

  self.old_pos = self.origin;
}