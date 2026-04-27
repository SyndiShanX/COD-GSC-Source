/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_vehicle_spline.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_debug;
#include maps\_vehicle;
#include maps\_anim;

ANG_LOOKAHEAD_DIST = 800;
AHEAD_DISTANCE = 500;
WHITE = (1, 1, 1);
RED = (1, 0, 0);
GREEN = (0, 1, 0);
BLUE = (0, 0, 1);

init_vehicle_splines() {
  create_dvar("vehicle_spline_debug", 0);

  level.SPLINE_MIN_PROGRESS = -2000;
  level.enemy_snowmobiles_max = 6;
  level.player_ent = spawn("script_origin", level.player.origin + (0, 0, 88));
  level.player_ent linkto(level.player);
  level.snowmobile_path = make_road_path();
  flag_init("ai_snowmobiles_ram_player");
  flag_set("ai_snowmobiles_ram_player");

  enable_spline_paths = getEntArray("enable_spline_path", "targetname");
  array_thread(enable_spline_paths, ::enable_spline_path_think);
}

enable_spline_path_think() {
  for(;;) {
    self waittill("trigger", other);
    other notify("enable_spline_path");
  }
}

make_road_path() {
  level.drive_spline_path_fun = ::bike_drives_path;

  path = process_path();
  flag_init("race_complete");
  level.player_view_org = spawn("script_model", (0, 0, 0));
  level.player_view_org setModel("tag_origin");

  level.enemy_snowmobiles = [];
  level.bike_score = 0;
  level.player thread bike_death_score();
  return path;
}

bike_death_score() {
  self waittill("death");
}

get_guy_from_spawner() {
  spawner = getent("spawner", "targetname");
  spawner.count = 1;
  spawner.origin = self.origin;
  spawner.angles = (0, self.angles[1], 0);
  return spawner stalingradspawn();
}

#using_animtree("generic_human");
orient_dir(yaw) {
  for(;;) {
    if(!isDefined(self))
      return;
    self OrientMode("face angle", yaw);
    wait(0.05);
  }
}

process_path() {
  path = create_path();
  level.snowmobile_path = path;

  add_collision_to_path(path);

  if(getdebugdvarint("vehicle_spline_debug"))
    thread draw_path(path);

  return path;
}

droppedLine(start, end, color, depth, cull, timer) {
  start = drop_to_ground(start);
  end = drop_to_ground(end);
  thread linedraw(start, end, color, depth, cull, timer);
}

droppedLineZ(z, start, end, color, depth, cull, timer) {
  start = (start[0], start[1], z);
  start = drop_to_ground(start);

  end = (end[0], end[1], z);
  end = drop_to_ground(end);
  thread linedraw(start, end, color, depth, cull, timer);
}

draw_path(path) {
  old_left_node = undefined;
  old_right_node = undefined;

  for(i = 0; i < path.size; i++) {
    node = path[i];
    angles = vectortoangles(node.next_node.midpoint - node.midpoint);
    forward = anglesToForward(angles) * node.dist_to_next_targ;

    width = node.road_width * 0.5;
    start1 = get_position_from_spline(node, 0, width);
    end1 = get_position_from_spline(node, node.dist_to_next_targ, width);
    droppedLineZ(node.z, start1, end1, (0, 0.5, 1), 1, 1, 50000);

    start2 = get_position_from_spline(node, 0, width * -1);
    end2 = get_position_from_spline(node, node.dist_to_next_targ, width * -1);
    droppedLineZ(node.z, start2, end2, (0, 0.5, 1), 1, 1, 50000);

    droppedLineZ(node.z, start1, start2, (0, 0.5, 1), 1, 1, 50000);
    droppedLineZ(node.z, end1, end2, (0, 0.5, 1), 1, 1, 50000);

    foreach(col_volume in node.col_volumes) {
      node draw_col_vol(node.z, col_volume);
    }

    foreach(col_line in node.col_lines) {
      start = col_line.origin;
      end = col_line.other_col_point.origin;
      droppedlineZ(node.z, start, end, (1, 0, 0), 1, 1, 50000);
    }
  }
}

draw_col_vol(z, vol) {
  start = get_position_from_spline(self, vol["min"], vol["left_offset"]);
  end = get_position_from_spline(self, vol["max"], vol["left_offset"]);
  droppedLineZ(z, start, end, (0.5, 0, 1), 1, 1, 50000);

  start = get_position_from_spline(self, vol["min"], vol["right_offset"]);
  end = get_position_from_spline(self, vol["max"], vol["right_offset"]);
  droppedLineZ(z, start, end, (0.5, 0, 1), 1, 1, 50000);

  start = get_position_from_spline(self, vol["min"], vol["right_offset"]);
  end = get_position_from_spline(self, vol["min"], vol["left_offset"]);
  droppedLineZ(z, start, end, (0.5, 0, 1), 1, 1, 50000);

  start = get_position_from_spline(self, vol["max"], vol["right_offset"]);
  end = get_position_from_spline(self, vol["max"], vol["left_offset"]);
  droppedLineZ(z, start, end, (0.5, 0, 1), 1, 1, 50000);
}

draw_col_vol_offset(Z, vol, offset, forward, right) {
  targ = self;

  start = get_position_from_spline(targ, vol["min"], vol[offset]);
  end = get_position_from_spline(targ, vol["max"], vol[offset]);
  droppedLineZ(z, start, end, (0.5, 0, 1), 1, 1, 50000);
}

create_path() {
  targ = getstruct("road_path_left", "targetname");
  assert(isDefined(targ));

  path = [];

  targ.z = targ.origin[2];

  targ.origin = (targ.origin[0], targ.origin[1], 0);

  count = 0;
  prev_targ = targ;
  for(;;) {
    next_targ = targ;
    if(isDefined(targ.target))
      next_targ = getstruct(targ.target, "targetname");

    if(!isDefined(next_targ.z))
      next_targ.z = next_targ.origin[2];

    next_targ.origin = (next_targ.origin[0], next_targ.origin[1], 0);

    path[path.size] = targ;
    targ.next_node = next_targ;
    targ.prev_node = prev_targ;
    next_targ.previous_node = targ;
    targ.col_lines = [];
    targ.col_volumes = [];
    targ.col_radiuses = [];
    targ.origins = [];
    targ.dist_to_next_targs = [];
    targ.origins["left"] = targ.origin;

    targ.index = count;
    count++;

    if(targ == next_targ) {
      break;
    }
    prev_targ = targ;
    targ = next_targ;
  }

  targ = getstruct("road_path_right", "targetname");

  targ.z = targ.origin[2];

  targ.origin = (targ.origin[0], targ.origin[1], 0);

  new_count = 0;
  for(;;) {
    next_targ = targ;
    if(isDefined(targ.target))
      next_targ = getstruct(targ.target, "targetname");

    if(!isDefined(next_targ.z))
      next_targ.z = next_targ.origin[2];

    next_targ.origin = (next_targ.origin[0], next_targ.origin[1], 0);

    assertex(count >= new_count, "Had more right road nodes than left road nodes.");

    parent = path[new_count];
    assertex(isDefined(parent), "Had more left road nodes than right road nodes.");
    parent.origins["right"] = targ.origin;
    parent.road_width = distance(parent.origins["right"], parent.origins["left"]);

    new_count++;

    if(targ == next_targ) {
      break;
    }

    targ = next_targ;
  }

  assertex(count == new_count, "Had more left road nodes than right road nodes.");

  foreach(node in path) {
    node.midpoint = (node.origins["left"] + node.origins["right"]) * 0.5;
  }

  foreach(node in path) {
    midpoint1 = node.midpoint;
    midpoint2 = node.next_node.midpoint;

    angles = vectortoangles(midpoint1 - midpoint2);
    right = anglestoright(angles);
    road_half_width = node.road_width * 0.5;
    node.origins["left"] = node.midpoint + right * road_half_width;
    node.origins["right"] = node.midpoint + right * road_half_width * -1;
  }

  node = path[path.size - 1].next_node;
  node.midpoint = (node.origins["left"] + node.origins["right"]) * 0.5;

  foreach(node in path) {
    node.dist_to_next_targ = distance(node.midpoint, node.next_node.midpoint);
    node.dist_to_next_targs["left"] = distance(node.origins["left"], node.next_node.origins["left"]);
    node.dist_to_next_targs["right"] = distance(node.origins["right"], node.next_node.origins["right"]);
  }

  return path;
}

drop_path_to_ground(path) {
  targ = self;
  foreach(node in path) {
    node.origin += (0, 0, 20);
    endpos = PhysicsTrace(node.origin, node.origin + (0, 0, -100));
    node.origin = endpos;
  }
}

add_collision_to_path(path) {
  collision_lines = getStructArray("moto_line", "targetname");
  foreach(collision_line in collision_lines) {
    collision_line.origin = (collision_line.origin[0], collision_line.origin[1], 0);
    next_line = getstruct(collision_line.target, "targetname");

    collision_line.other_col_point = next_line;
    next_line.other_col_point = collision_line;
  }

  foreach(collision_line in collision_lines) {}

  targ = self;
  foreach(node in path) {
    foreach(collision_line in collision_lines) {
      add_collision_to_path_ent(node, collision_line);
    }
  }

  moto_collision = getEntArray("moto_collision", "targetname");
  foreach(col_radius in moto_collision) {
    closest_nodes = get_array_of_closest(col_radius.origin, path, undefined, 2);
    foreach(node in closest_nodes) {
      node.col_radiuses[node.col_radiuses.size] = col_radius;
    }
  }
}

get_offset_percent(targ, next_targ, progress, offset) {
  dist = distance(targ.midpoint, next_targ.midpoint);

  progress_percent = 1 - (progress / dist);

  offset_side = "left";
  if(offset > 0) {
    offset_side = "right";
  }

  bumper_start = targ.origins[offset_side];
  bumper_end = next_targ.origins[offset_side];

  bumper_org = bumper_start * progress_percent + bumper_end * (1 - progress_percent);

  center_start = targ.midpoint;
  center_end = next_targ.midpoint;

  center_org = center_start * progress_percent + center_end * (1 - progress_percent);

  track_width = distance(center_org, bumper_org);

  return offset / track_width;
}

add_collision_to_path_ent(targ, col_org) {
  if(targ == targ.next_node) {
    return;
  }
  max_dist = targ.road_width;
  if(targ.dist_to_next_targ > max_dist)
    max_dist = targ.dist_to_next_targ;

  if(distance(col_org.origin, targ.next_node.midpoint) > max_dist * 1.5) {
    return;
  }
  next_org = getstruct(col_org.target, "targetname");

  prog1 = get_progression_between_points(col_org.origin, targ.midpoint, targ.next_node.midpoint);
  progress1 = prog1["progress"];

  prog2 = get_progression_between_points(next_org.origin, targ.midpoint, targ.next_node.midpoint);
  progress2 = prog2["progress"];

  if(progress1 < 0 || progress2 < 0)
    return;
  if(progress1 > targ.dist_to_next_targ && progress2 > targ.dist_to_next_targ) {
    return;
  }
  assertex(progress1 >= 0, "Negative progress");
  assertex(progress2 >= 0, "Negative progress");

  col_org.claimed = true;
  next_org.claimed = true;

  col_org.progress = progress1;
  col_org.offset = prog1["offset"];
  col_org.offset_percent = get_offset_percent(targ, targ.next_node, progress1, prog1["offset"]);

  next_org.progress = progress2;
  next_org.offset = prog2["offset"];
  next_org.offset_percent = get_offset_percent(targ, targ.next_node, progress2, prog2["offset"]);

  col_org.origin = (col_org.origin[0], col_org.origin[1], targ.midpoint[2] + 40);
  next_org.origin = (next_org.origin[0], next_org.origin[1], targ.midpoint[2] + 40);

  if(progress1 < progress2) {
    add_collision_offsets_to_path_ent(targ, col_org, next_org);
    targ.col_lines[targ.col_lines.size] = col_org;
  } else {
    add_collision_offsets_to_path_ent(targ, next_org, col_org);
    targ.col_lines[targ.col_lines.size] = next_org;
  }
}

add_collision_offsets_to_path_ent(targ, close_org, far_org) {
  max_progress = far_org.progress + AHEAD_DISTANCE;
  min_progress = close_org.progress - level.DODGE_DISTANCE;

  right_offset = undefined;
  left_offset = undefined;
  right_offset_percent = undefined;
  left_offset_percent = undefined;

  if(far_org.offset > close_org.offset) {
    right_offset = far_org.offset;
    left_offset = close_org.offset;
    right_offset_percent = far_org.offset_percent;
    left_offset_percent = close_org.offset_percent;
  } else {
    right_offset = close_org.offset;
    left_offset = far_org.offset;
    right_offset_percent = close_org.offset_percent;
    left_offset_percent = far_org.offset_percent;
  }

  start_targ = targ;
  start_max_progress = max_progress;
  start_min_progress = min_progress;

  for(;;) {
    add_vol_to_node(targ, max_progress, min_progress, right_offset, left_offset, right_offset_percent, left_offset_percent);
    if(!isDefined(targ.next_node)) {
      break;
    }
    if(targ.dist_to_next_targ >= max_progress) {
      break;
    }

    max_progress -= targ.dist_to_next_targ;
    targ = targ.next_node;
    min_progress = 0;
  }

  targ = start_targ;
  max_progress = start_max_progress;
  min_progress = start_min_progress;

  for(;;) {
    if(!isDefined(targ.previous_node)) {
      break;
    }
    if(min_progress > 0) {
      break;
    }

    targ = targ.previous_node;
    max_progress = targ.dist_to_next_targ;
    min_progress = targ.dist_to_next_targ + min_progress;
    add_vol_to_node(targ, max_progress, min_progress, right_offset, left_offset, right_offset_percent, left_offset_percent);
  }
}

add_vol_to_node(targ, max_col_progress, min_col_progress, right_offset, left_offset, right_offset_percent, left_offset_percent) {
  colvol = [];
  colvol["max"] = max_col_progress;
  if(colvol["max"] > targ.dist_to_next_targ)
    colvol["max"] = targ.dist_to_next_targ;

  colvol["min"] = min_col_progress;
  if(colvol["min"] < 0)
    colvol["min"] = 0;

  assert(colvol["min"] < colvol["max"]);

  colvol["left_offset"] = left_offset;
  colvol["right_offset"] = right_offset;

  colvol["left_offset_percent"] = left_offset_percent;
  colvol["right_offset_percent"] = right_offset_percent;

  colvol["mid_offset"] = (right_offset + left_offset) * 0.5;
  colvol["mid_offset_percent"] = (right_offset_percent + left_offset_percent) * 0.5;

  targ.col_volumes[targ.col_volumes.size] = colvol;
}

get_progression_between_points(start, first_point, second_point) {
  first_point = (first_point[0], first_point[1], 0);
  second_point = (second_point[0], second_point[1], 0);
  start = (start[0], start[1], 0);

  prog = [];

  angles = vectortoangles(second_point - first_point);
  forward = anglesToForward(angles);

  end = first_point;
  difference = vectornormalize(end - start);
  dot = vectordot(forward, difference);

  normal = vectorNormalize(second_point - first_point);
  vec = start - first_point;
  progress = vectorDot(vec, normal);

  offset_org = first_point + forward * progress;

  prog["progress"] = progress;
  prog["offset"] = distance(offset_org, start);

  right = anglestoright(angles);
  difference = vectornormalize(offset_org - start);
  dot = vectordot(right, difference);
  prog["dot"] = dot;
  if(dot > 0)
    prog["offset"] *= -1;

  return prog;
}

wipe_out(bike) {
  foreach(col_radius in self.targ.col_radiuses) {
    crashPoint = (self.origin[0], self.origin[1], 0);

    if(distance((col_radius.origin[0], col_radius.origin[1], 0), crashPoint) < col_radius.radius)
      return true;
  }

  if(bike.health >= 100)
    return false;

  level.bike_score++;

  return true;
}

vehicle_line(bike) {
  self endon("death");
  bike endon("death");
  for(;;) {
    line(self.origin, bike.origin, (0.2, 0.8, 0.3), 1, 0);
    wait(0.05);
  }
}

spawner_random_team() {
  waittillframeend;
  if(!isDefined(self.riders))
    return;
  team = "axis";
  if(cointoss())
    team = "allies";
  foreach(guy in self.riders) {
    guy.team = team;
  }
}

get_spawn_position(player_targ, my_progress) {
  ent = move_to_correct_segment(player_targ, my_progress);
  progress = ent.progress;
  targ = ent.targ;

  half_road_width = targ.road_width * 0.5;
  offset = undefined;
  if(isDefined(level.player.offset)) {
    random_offset = 500;
    if(cointoss())
      random_offset *= -1;
    offset = level.player.offset + random_offset;
  } else {
    offset = randomfloatrange(half_road_width * -1, half_road_width);
  }

  obstacle_array = get_obstacle_dodge_amount(targ, progress, offset);
  if(isDefined(obstacle_array["dodge"]))
    offset = obstacle_array["dodge"];

  spawn_pos = get_position_from_spline_unlimited(targ, progress, offset);
  array = [];
  array["spawn_pos"] = spawn_pos;
  array["progress"] = progress;
  array["targ"] = targ;
  array["offset"] = offset;
  return array;
}

debug_enemy_vehicles() {
  if(!getdebugdvarint("vehicle_spline_debug")) {
    return;
  }
  level notify("stop_debugging_enemy_vehicles");
  array_thread(level.enemy_snowmobiles, ::debug_enemy_vehicles_line);
}

debug_enemy_vehicles_line() {
  self endon("death");
  level endon("stop_debugging_enemy_vehicles");
  for(;;) {
    line(self.origin, level.player.origin, (1, 0.5, 0));
    wait(0.05);
  }
}

spawn_enemy_bike() {
  assertex(isDefined(level.enemy_snowmobiles), "Please add maps\_vehicle_spline::init_vehicle_splines(); to the beginning of your script");

  debug_enemy_vehicles();

  if(level.enemy_snowmobiles.size >= level.enemy_snowmobiles_max) {
    return;
  }
  player_targ = get_player_targ();
  player_progress = get_player_progress();
  my_direction = "forward";

  spawn_array = get_spawn_position(player_targ, player_progress - 1000 - level.POS_LOOKAHEAD_DIST);
  spawn_pos = spawn_array["spawn_pos"];
  player_sees_me_spawn = within_fov(level.player.origin, level.player.angles, spawn_pos, 0);

  if(player_sees_me_spawn) {
    spawn_array = get_spawn_position(player_targ, player_progress + 1000);
    spawn_pos = spawn_array["spawn_pos"];
    my_direction = "backward";
    player_sees_me_spawn = within_fov(level.player.origin, level.player.angles, spawn_pos, 0);
    if(player_sees_me_spawn) {
      return;
    }
  }

  spawn_pos = drop_to_ground(spawn_pos);

  snowmobile_spawner = getent("snowmobile_spawner", "targetname");
  assertEx(isDefined(snowmobile_spawner), "Need a snowmobile spawner with targetname snowmobile_spawner in the level");
  targ = spawn_array["targ"];

  snowmobile_spawner.origin = spawn_pos;

  snowmobile_spawner.angles = vectortoangles(targ.next_node.midpoint - targ.midpoint);

  ai_spawners = snowmobile_spawner get_vehicle_ai_spawners();
  foreach(spawner in ai_spawners) {
    spawner.origin = snowmobile_spawner.origin;
  }

  bike = vehicle_spawn(snowmobile_spawner);
  bike.offset_percent = spawn_array["offset"];
  bike VehPhys_SetSpeed(90);

  bike thread crash_detection();
  bike.left_spline_path_time = gettime() - 3000;
  waittillframeend;
  if(!isalive(bike)) {
    return;
  }
  targ bike_drives_path(bike);
}

crash_detection() {
  self waittill("veh_collision", velocity, collisionNormal);

  self wipeout("collision!");
}

rider_death_detection(bike) {
  self waittill("death");
  if(isDefined(bike)) {
    bike wipeout("driver died!");
  }
}

wipeout(msg) {
  if(!self.wipeout) {
    if(getdebugdvarint("vehicle_spline_debug"))
      Print3d(self.origin, msg, (1, 0.25, 0), 1, 1.5, 400);
  }

  self.wipeout = true;
}

update_bike_player_avoidance(my_bike) {
  bikes = [];
  foreach(bike in level.enemy_snowmobiles) {
    if(!isalive(bike)) {
      continue;
    }
    if(bike.wipeout) {
      continue;
    }
    bikes[bikes.size] = bike;
  }
  level.enemy_snowmobiles = bikes;

  if(isalive(my_bike) && !my_bike.wipeout) {
    found_bike = false;
    foreach(bike in level.enemy_snowmobiles) {
      if(bike == my_bike) {
        found_bike = true;
        continue;
      }
    }

    if(!found_bike) {
      level.enemy_snowmobiles[level.enemy_snowmobiles.size] = my_bike;
    }
  }

  offset = 0;
  foreach(bike in level.enemy_snowmobiles) {
    bike.bike_avoidance_offset = offset;
    offset += 75;
  }
}

bike_drives_path(bike) {
  if(!isDefined(bike.left_spline_path_time))
    bike.left_spline_path_time = gettime();

  bike.wipeout = false;
  update_bike_player_avoidance(bike);

  if(!isDefined(bike.player_offset))
    bike.player_offset = 250;

  bike.steering = 0;
  offset = randomfloatrange(0, 1);
  if(!isDefined(bike.offset_percent))
    bike.offset_percent = offset * 2 - 1;

  targ = self;
  ent = spawnStruct();
  ent.origin = self.midpoint;
  ent.progress = 0;
  ent.tilt_vel = 0;
  ent.speed = 100;
  ent ent_flag_init("biker_reaches_path_end");

  bike notify("enable_spline_path");

  if(!bike.riders.size) {
    bike VehPhys_Crash();
    return;
  }

  array_thread(bike.riders, ::rider_death_detection, bike);

  ent.bike = bike;

  bike.health = 100;

  wipeout = false;
  ent thread bike_ent_wipe_out_check(bike);

  bike.progress_targ = targ;
  bike.offset_modifier = 0;
  bike.fails = 0;
  bike.direction = "forward";

  bike.old_pos = bike.origin;

  for(;;) {
    if(getdebugdvarint("vehicle_spline_debug"))
      bike debug_bike_line();

    if(!isalive(bike)) {
      break;
    }

    set_bike_position(ent);

    if(!isalive(bike)) {
      break;
    }
    if(abs(bike.progress_dif) > 6000 && gettime() > bike.left_spline_path_time + 4000) {
      bike wipeout("left behind!");
    }

    waittillframeend;
    if(bike.wipeout) {
      if(isDefined(bike.hero)) {
        continue;
      }
      bike VehPhys_Crash();
      foreach(rider in bike.riders) {
        if(isalive(rider)) {
          rider kill();
        }
      }
      wait(5);
      if(isDefined(bike)) {
        bike delete();
      }

      update_bike_player_avoidance();
      return;
    }

    if(ent ent_flag("biker_reaches_path_end") || flag("race_complete")) {
      break;
    }
  }

  update_bike_player_avoidance();

  ent notify("stop_bike");
  level notify("biker_dies");
  if(bike.wipeout && !flag("race_complete"))
    wait(5);

  ent ent_flag_clear("biker_reaches_path_end");
}

get_obstacle_dodge_amount(targ, progress, offset) {
  array["near_obstacle"] = false;
  foreach(vol in targ.col_volumes) {
    if(progress < vol["min"])
      continue;
    if(progress > vol["max"])
      continue;
    array["near_obstacle"] = true;
    if(offset < vol["left_offset"])
      continue;
    if(offset > vol["right_offset"]) {
      continue;
    }
    org = (targ.midpoint + targ.next_node.midpoint) * 0.5;

    if(offset > vol["mid_offset"])
      array["dodge"] = vol["right_offset"];
    else
      array["dodge"] = vol["left_offset"];
    break;
  }
  return array;
}

sweep_tells_vehicles_to_get_off_path() {
  for(;;) {
    self waittill("trigger", other);
    if(!isDefined(other.script_noteworthy))
      continue;
    if(other.script_noteworthy != "sweepable")
      continue;
    timer = randomfloatrange(0, 1);
    other thread notify_delay("enable_spline_path", timer);
  }
}

drawmyoff() {
  for(;;) {
    if(isDefined(level.player.vehicle)) {
      my_speed = self vehicle_getSpeed();
      p_speed = level.player.vehicle vehicle_getSpeed();
      Print3d(self.origin + (0, 0, 64), my_speed - p_speed, (1, 0, 0.2), 1, 1.2);
      level.difference = my_speed - p_speed;

      Line(self.origin, level.player.origin, (1, 0, 0.2));
    }
    wait(0.05);
  }
}

priceliner() {
  create_dvar("price_line", 0);
  for(;;) {
    if(!isDefined(level.player.vehicle)) {
      return;
    }
    forward = anglesToForward(level.player.vehicle.angles);
    forward *= -150;
    if(getdebugdvarint("price_line"))
      Line(level.player.origin + forward, self.origin, (1, 0, 0));
    wait(0.05);
  }
}

modulate_speed_based_on_progress() {
  thread priceliner();
  self.targ = get_my_spline_node(self.origin);
  self.min_speed = 1;

  self endon("stop_modulating_speed");

  hud = undefined;

  hud = maps\_hud_util::createFontString("default", 1.5);
  hud maps\_hud_util::setPoint("MIDDLE", "MIDDLE", 0, 30);
  hud.color = (1, 1, 1);
  hud.alpha = 1;

  for(;;) {
    wait(0.05);

    targ = self.targ;
    if(targ == targ.next_node) {
      return;
    }

    array = get_progression_between_points(self.origin, self.targ.midpoint, self.targ.next_node.midpoint);
    progress = array["progress"];
    progress += level.POS_LOOKAHEAD_DIST;

    ent = move_to_correct_segment(self.targ, progress);
    progress = ent.progress;
    self.targ = ent.targ;
    self.progress = progress;

    player_targ = get_player_targ();
    player_progress = get_player_progress();
    dif = progress_dif(self.targ, self.progress, player_targ, player_progress);
    level.progress_dif = dif;

    if(!isDefined(level.player.vehicle)) {
      self Vehicle_SetSpeed(65, 1, 1);
      continue;
    }

    if(abs(dif > 3500)) {
      speed = 65;

      dif *= -1;
      dif += 750;
      speed = level.player.vehicle.veh_speed + dif * 0.05;
      max_speed = level.player.vehicle.veh_speed;
      if(max_speed < 100)
        max_speed = 100;

      if(speed > max_speed)
        speed = max_speed;
      else
      if(speed < self.min_speed)
        speed = self.min_speed;
      level.desired_speed = speed;

      self Vehicle_SetSpeed(speed, 90, 20);
    } else {
      price_match_player_speed(10, 10);
    }
  }
}

price_match_player_speed(maxaccell, maxdecel) {
  angles = self.angles;
  angles = (0, angles[1], 0);
  forward = anglesToForward(angles);

  array = get_progression_between_points(level.player.vehicle.origin, self.origin + forward * 1, self.origin - forward * 1);
  progress = array["progress"];

  if(progress > 4000)
    self Vehicle_SetSpeed(0, 90, 20);
  else {
    dot = get_dot(self.origin, self.angles, level.player.origin);
    multiplier = 1;

    if(progress > 0) {
      multiplier = 1;
    } else {
      if(progress > -500)
        multiplier = 1.25;

      if(multiplier > 0.95 && dot > 0.97) {
        multiplier = 0.95;
      }
    }

    my_speed = 70 * multiplier;
    if(my_speed < self.min_speed)
      my_speed = self.min_speed;
    if(my_speed < 25)
      my_speed = 25;

    level.price_desired_speed = my_speed;
    self Vehicle_SetSpeed(my_speed, maxaccell, maxdecel);
  }
}

match_player_speed(maxaccell, maxdecel) {
  angles = self.angles;
  angles = (0, angles[1], 0);
  forward = anglesToForward(angles);

  array = get_progression_between_points(level.player.vehicle.origin, self.origin + forward * 1, self.origin - forward * 1);
  progress = array["progress"];

  if(progress > 4000)
    self Vehicle_SetSpeed(0, 90, 20);
  else {
    if(progress < level.SPLINE_MIN_PROGRESS && gettime() > self.left_spline_path_time + 4000) {
      self wipeout("low progress!");
    }

    progress -= 750;
    progress += self.bike_avoidance_offset;

    multiplier = 1;

    if(progress > 150)
      multiplier = 0.6;
    else
    if(progress > 100)
      multiplier = 1.0;
    else
    if(progress < -100)
      multiplier = 1.5;

    if(isDefined(level.player.offset)) {
      if(progress > 250) {}
    }

    my_speed = level.player.vehicle.veh_speed * multiplier;
    if(my_speed < 25)
      my_speed = 25;

    self Vehicle_SetSpeed(my_speed, maxaccell, maxdecel);
  }
}

track_player_progress(org) {
  self notify("track_player_progress");
  self endon("track_player_progress");

  self.targ = get_my_spline_node(org);
  self.progress = 0;
  player_sweep_trigger = getent("player_sweep_trigger", "targetname");
  sweep_trigger = isDefined(player_sweep_trigger);
  if(sweep_trigger)
    player_sweep_trigger thread sweep_tells_vehicles_to_get_off_path();

  for(;;) {
    if(self.targ == self.targ.next_node) {
      return;
    }

    array = get_progression_between_points(self.origin, self.targ.midpoint, self.targ.next_node.midpoint);

    progress = array["progress"];
    progress += level.POS_LOOKAHEAD_DIST;

    ent = move_to_correct_segment(self.targ, progress);
    progress = ent.progress;
    self.targ = ent.targ;
    self.progress = progress;
    self.offset = array["offset"];

    if(sweep_trigger) {
      trigger_pos = get_position_from_spline_unlimited(self.targ, progress + 2000, 0);
      trigger_pos = (trigger_pos[0], trigger_pos[1], self.origin[2] - 500);
      player_sweep_trigger.origin = trigger_pos;
      lookahead_pos = get_position_from_spline_unlimited(self.targ, progress + 3000, 0);
      angles = vectortoangles(player_sweep_trigger.origin - lookahead_pos);
      player_sweep_trigger.angles = (0, angles[1], 0);
    }

    if(flag("ai_snowmobiles_ram_player")) {
      level.closest_enemy_snowmobile_to_player = getClosest(self.origin, level.enemy_snowmobiles);
    } else {
      level.closest_enemy_snowmobile_to_player = undefined;
    }

    wait(0.05);
  }
}

progress_dif(targ, progress, targ2, progress2) {
  while(targ.index > targ2.index) {
    targ = targ.prev_node;
    progress += targ.dist_to_next_targ;
  }
  while(targ2.index > targ.index) {
    targ2 = targ2.prev_node;
    progress2 += targ2.dist_to_next_targ;
  }

  return progress - progress2;
}

set_bike_position(ent) {
  bike = ent.bike;
  timer = 0.1;

  progress = 0;
  offset = 0;

  targ = bike.progress_targ;
  if(targ == targ.next_node) {
    bike delete();
    return;
  }

  array = get_progression_between_points(bike.origin, targ.midpoint, targ.next_node.midpoint);
  array_next = get_progression_between_points(bike.origin, targ.next_node.midpoint, targ.next_node.next_node.midpoint);

  if(array_next["progress"] > 0 && array_next["progress"] < targ.next_node.dist_to_next_targ) {
    array = array_next;
    targ = targ.next_node;
  }
  offset = array["offset"];
  player_progress = 0;
  progress = array["progress"];
  bike.progress = progress;

  obstacle_array = get_obstacle_dodge_amount(targ, progress, offset);
  crashing = obstacle_array["near_obstacle"];

  dif = progress_dif(targ, progress, get_player_targ(), get_player_progress());
  bike.progress_dif = dif;
  if(bike.direction == "forward") {
    progress += level.POS_LOOKAHEAD_DIST;
  } else {
    progress -= level.POS_LOOKAHEAD_DIST;
    if(dif < 500) {
      bike.direction = "forward";
    }
  }

  min_speed = 60;
  max_speed = 90;
  min_dist = 100;
  max_dist = 200;

  if(dif > max_dist) {
    speed = min_speed;
  } else
  if(dif < min_dist) {
    speed = max_speed;
  } else {
    dist_dif = max_dist - min_dist;
    speed_dif = max_speed - min_speed;
    speed = dif - min_dist;
    speed = dist_dif - speed;

    speed *= speed_dif / dist_dif;
    speed += min_speed;
    assert(speed >= min_speed && speed <= max_speed);
  }

  if(speed > 0) {
    if(bike vehicle_getspeed() < 2) {
      bike.fails++;
      if(bike.fails > 10) {
        bike wipeout("move fail!");
        return;
      }
    } else
      bike.fails = 0;
  } else
    bike.fails = 0;

  offset_modifier = randomfloatrange(0, 100);
  offset_modifier *= 0.001;

  chaseCam = false;

  if(getdvarint("chasecam")) {
    chasecam = true;
  }

  current_road_width = targ.road_width;

  ent = move_to_correct_segment(targ, progress);
  progress = ent.progress;
  targ = ent.targ;

  org = (targ.midpoint + targ.next_node.midpoint) * 0.5;

  offset = offset * targ.road_width / current_road_width;

  obstacle_array = get_obstacle_dodge_amount(targ, progress, offset);

  if(isDefined(obstacle_array["dodge"])) {
    offset = obstacle_array["dodge"];
  } else {
    if(isDefined(bike.preferred_offset)) {
      offset = bike.preferred_offset;
    }
  }

  offset_limit = 0.95;
  road_half_width = targ.road_width * 0.5;
  road_half_width -= 50;
  if(offset > road_half_width)
    offset = road_half_width;
  else
  if(offset < -1 * road_half_width)
    offset = -1 * road_half_width;

  if(targ != targ.next_node) {
    endpos = bike get_bike_pos_from_spline(targ, progress, offset, bike.origin[2]);

    dot = get_dot(bike.origin, bike.angles, endpos);

    if(dot < 0.97)
      speed = 50;
    else
    if(dot < 0.96)
      speed = 25;
    else
    if(dot < 0.95)
      speed = 15;

    bike vehicleDriveTo(endpos, speed);
    if(!isDefined(level.player.vehicle)) {
      bike Vehicle_SetSpeed(65, 1, 1);
    } else {
      bike.veh_topspeed = level.player.vehicle.veh_topspeed * 1.3;
      bike match_player_speed(45, 30);
    }

    if(getdebugdvarint("vehicle_spline_debug") && isDefined(level.player.vehicle))

      if(bike.veh_speed > level.player.vehicle.veh_speed)
        thread Linedraw(bike.origin, endpos, (0.9, 0.1, 0.3), 1, 0, timer);
      else
        thread Linedraw(bike.origin, endpos, (0.3, 0.1, 0.9), 1, 0, timer);
  }

  bike.progress_targ = targ;
  bike.offset = offset;
  wait(timer);
}

get_bike_pos_from_spline(targ, progress, offset, z) {
  bike_lookahead_pos = get_position_from_spline(targ, progress, offset);
  bike_lookahead_pos = set_z(bike_lookahead_pos, z);

  return PhysicsTrace(bike_lookahead_pos + (0, 0, 200), bike_lookahead_pos + (0, 0, -200));
}

move_to_correct_segment(targ, progress) {
  ent = spawnStruct();

  for(;;) {
    if(targ == targ.next_node) {
      break;
    }

    if(progress > targ.dist_to_next_targ) {
      progress -= targ.dist_to_next_targ;
      targ = targ.next_node;
      continue;
    }

    if(progress < 0) {
      progress += targ.dist_to_next_targ;
      targ = targ.prev_node;
      continue;
    }

    break;
  }

  ent.targ = targ;
  ent.progress = progress;
  return ent;
}

get_position_from_spline_unlimited(targ, progress, offset) {
  for(;;) {
    if(targ == targ.next_node) {
      return targ.midpoint;
    }

    if(progress > targ.dist_to_next_targ) {
      progress -= targ.dist_to_next_targ;
      targ = targ.next_node;
      continue;
    }
    break;
  }

  return get_position_from_spline(targ, progress, offset);
}

get_position_from_spline(targ, progress, offset) {
  angles = vectortoangles(targ.next_node.midpoint - targ.midpoint);
  forward = anglesToForward(angles);
  right = anglesToRight(angles);
  return targ.midpoint + forward * progress + right * offset;
}

get_position_from_progress(targ, progress) {
  progress_percent = 1 - (progress / targ.dist_to_next_targ);
  return targ.midpoint * progress_percent + targ.next_node.midpoint * (1 - progress_percent);
}

bike_ent_wipe_out_check(bike) {
  self endon("stop_bike");
  for(;;) {
    self.wipeout = false;

    if(self.wipeout) {
      break;
    }
    wait(0.05);
  }
}

draw_bike_debug() {
  for(;;) {
    waittillframeend;
    Print3d(self.origin, self.goal_dir, (1, 1, 1), 2);
    wait(0.05);
  }
}

track_progress() {
  self endon("stop_bike");
  for(;;) {
    start = (self.origin[0], self.origin[1], 0);
    end = (self.targ.midpoint[0], self.targ.midpoint[1], 0);
    next_targ = (self.next_targ.midpoint[0], self.next_targ.midpoint[1], 0);

    difference = vectornormalize(end - start);
    forward = anglesToForward(self.angles);
    dot = vectordot(forward, difference);

    normal = vectorNormalize(next_targ - end);
    vec = start - end;
    self.progress = vectorDot(vec, normal);

    wait(0.05);
  }
}

set_road_offset(targ) {
  self.right_offset = targ.road_width * 0.5;
  self.safe_offset = self.right_offset - 100;
}

bike_avoids_obstacles(bike) {
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
      if(cointoss())
        self.goal_dir++;
      else
        self.goal_dir--;

      if(self.goal_dir > 1)
        self.goal_dir -= 3;
      else
      if(self.goal_dir < -1)
        self.goal_dir += 3;
    }
    wait(randomfloatrange(1, 3));
  }
}

should_stabilize() {
  if(self.goal_dir == 0)
    return true;

  if(self.goal_dir == 1 && self.offset > self.safe_offset)
    return true;

  if(self.goal_dir == -1 && self.offset < self.safe_offset * -1)
    return true;

  return false;
}

bike_turns() {
  self.tilt_vel = 0;
  tilt_vel_max = 12;
  tilt_rate = 3;
  max_turn_speed = 130;
  for(;;) {
    if(should_stabilize()) {
      if(self.tilt > 0) {
        self.tilt_vel -= tilt_rate;
      } else
      if(self.tilt < 0) {
        self.tilt_vel += tilt_rate;
      }
    } else
    if(self.goal_dir == 1) {
      self.tilt_vel += tilt_rate;
    } else
    if(self.goal_dir == -1) {
      self.tilt_vel -= tilt_rate;
    }

    if(self.tilt_vel > tilt_vel_max) {
      self.tilt_vel = tilt_vel_max;
    } else
    if(self.tilt_vel < -1 * tilt_vel_max) {
      self.tilt_vel = -1 * tilt_vel_max;
    }

    self.tilt += self.tilt_vel;
    if(self.tilt > max_turn_speed) {
      self.tilt = max_turn_speed;
      self.tilt_vel = 1;
    } else
    if(self.tilt < max_turn_speed * -1) {
      self.tilt = max_turn_speed * -1;
      self.tilt_vel = -1;
    }

    wait(0.05);
  }
}

stabalize(max_turn_speed, tilt_rate) {
  if(self.tilt > 0) {
    self.tilt -= tilt_rate;
  } else {
    self.tilt += tilt_rate;
  }

  if(abs(self.tilt) < tilt_rate)
    self.tilt = tilt_rate;
}

tilt_right(max_turn_speed, tilt_rate) {
  if(self.offset >= self.safe_offset) {
    self.goal_dir = 0;
    return;
  }

  self.tilt += tilt_rate;
  if(self.tilt >= max_turn_speed)
    self.tilt = max_turn_speed;
}

tilt_left(max_turn_speed, tilt_rate) {
  if(self.offset < self.safe_offset * -1) {
    self.goal_dir = 0;
    return;
  }

  self.tilt -= tilt_rate;
  if(self.tilt < max_turn_speed * -1)
    self.tilt = max_turn_speed * -1;
}

get_player_progress() {
  if(isDefined(level.player.progress)) {
    return level.player.progress;
  }

  return 0;
}

get_player_targ() {
  if(isDefined(level.player.targ))
    return level.player.targ;
  return level.snowmobile_path[0];
}

debug_bike_line() {
  color = (0.2, 0.2, 1.0);
  if(isDefined(level.player.vehicle) && self.veh_speed > level.player.vehicle.veh_speed)
    color = (1.0, 0.2, 0.2);

  Line(self.old_pos, self.origin, color, 1, 0, 50000);
  self.old_pos = self.origin;
}