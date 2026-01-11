/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_util.gsc
***************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_strategy;

bot_get_nodes_in_cone(max_dist, vector_dot, only_visible_nodes) {
  nodes_around_bot = GetNodesInRadius(self.origin, max_dist, 0);
  nodes_in_cone = [];

  nearest_node_to_bot = self GetNearestNode();
  bot_dir = anglesToForward(self GetPlayerAngles());
  bot_dir_norm = VectorNormalize(bot_dir * (1, 1, 0));

  foreach(node in nodes_around_bot) {
    bot_to_node_norm = VectorNormalize((node.origin - self.origin) * (1, 1, 0));
    dot = VectorDot(bot_to_node_norm, bot_dir_norm);
    if(dot > vector_dot) {
      if(!only_visible_nodes || (isDefined(nearest_node_to_bot) && NodesVisible(node, nearest_node_to_bot, true))) {
        nodes_in_cone = array_add(nodes_in_cone, node);
      }
    }
  }

  return nodes_in_cone;
}

bot_goal_can_override(goal_type_1, goal_type_2) {
  if(goal_type_1 == "none") {
    return (goal_type_2 == "none");
  } else if(goal_type_1 == "hunt") {
    return (goal_type_2 == "hunt" || goal_type_2 == "none");
  } else if(goal_type_1 == "guard") {
    return (goal_type_2 == "guard" || goal_type_2 == "hunt" || goal_type_2 == "none");
  } else if(goal_type_1 == "objective") {
    return (goal_type_2 == "objective" || goal_type_2 == "guard" || goal_type_2 == "hunt" || goal_type_2 == "none");
  } else if(goal_type_1 == "critical") {
    return (goal_type_2 == "critical" || goal_type_2 == "objective" || goal_type_2 == "guard" || goal_type_2 == "hunt" || goal_type_2 == "none");
  } else if(goal_type_1 == "tactical") {
    return true;
  }

  AssertEx(false, "Unsupported parameter <goal_type_1> passed in to bot_goal_can_override()");
}

bot_set_personality(personality) {
  self BotSetPersonality(personality);
  self bot_assign_personality_functions();
  self BotClearScriptGoal();
}

bot_set_difficulty(difficulty) {
  assert(IsAI(self));

  if(IsTeamParticipant(self)) {
    debugDifficulty = GetDvar("bot_DebugDifficulty");
    if(debugDifficulty != "default") {
      difficulty = debugDifficulty;
    }
  }

  if(difficulty == "default") {
    difficulty = self bot_choose_difficulty_for_default();
  }

  self BotSetDifficulty(difficulty);

  if(IsPlayer(self)) {
    self.pers["rankxp"] = self get_rank_xp_for_bot();
    self maps\mp\gametypes\_rank::playerUpdateRank();
  }
}

bot_choose_difficulty_for_default() {
  if(!isDefined(level.bot_difficulty_defaults)) {
    level.bot_difficulty_defaults = [];
    level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "recruit";
    level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "regular";
    level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hardened";
  }

  difficulty = self.bot_chosen_difficulty;

  if(!isDefined(difficulty)) {
    inUseCount = [];

    team = self.team;
    if(!isDefined(team)) {
      team = self.bot_team;
    }
    if(!isDefined(team)) {
      team = self.pers["team"];
    }

    if(!isDefined(team)) {
      team = "allies";
    }

    foreach(player in level.players) {
      if(player == self) {
        continue;
      }
      if(!isAI(player)) {
        continue;
      }
      usedDifficulty = player BotGetDifficulty();
      if(usedDifficulty == "default") {
        continue;
      }
      otherTeam = player.team;
      if(!isDefined(otherTeam)) {
        otherTeam = player.bot_team;
      }
      if(!isDefined(otherTeam)) {
        otherTeam = player.pers["team"];
      }

      if(!isDefined(otherTeam)) {
        continue;
      }
      if(!isDefined(inUseCount[otherTeam])) {
        inUseCount[otherTeam] = [];
      }

      if(!isDefined(inUseCount[otherTeam][usedDifficulty])) {
        inUseCount[otherTeam][usedDifficulty] = 1;
      } else {
        inUseCount[otherTeam][usedDifficulty]++;
      }
    }

    lowest = -1;

    foreach(choice in level.bot_difficulty_defaults) {
      if(!isDefined(inUseCount[team]) || !isDefined(inUseCount[team][choice])) {
        difficulty = choice;
        break;
      } else if(lowest == -1 || inUseCount[team][choice] < lowest) {
        lowest = inUseCount[team][choice];
        difficulty = choice;
      }
    }
  }

  if(isDefined(difficulty)) {
    self.bot_chosen_difficulty = difficulty;
  }

  return difficulty;
}

bot_is_capturing() {
  if(self bot_is_defending()) {
    if(self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone") {
      return true;
    }
  }

  return false;
}

bot_is_patrolling() {
  if(self bot_is_defending()) {
    if(self.bot_defending_type == "patrol") {
      return true;
    }
  }

  return false;
}

bot_is_protecting() {
  if(self bot_is_defending()) {
    if(self.bot_defending_type == "protect") {
      return true;
    }
  }

  return false;
}

bot_is_bodyguarding() {
  if(self bot_is_defending()) {
    if(self.bot_defending_type == "bodyguard") {
      return true;
    }
  }

  return false;
}

bot_is_defending() {
  return (isDefined(self.bot_defending));
}

bot_is_defending_point(point) {
  if(self bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, point)) {
      return true;
    }
  }

  return false;
}

bot_is_guarding_player(player) {
  if(self bot_is_bodyguarding() && self.bot_defend_player_guarding == player) {
    return true;
  }

  return false;
}

bot_cache_entrances_to_bombzones() {
  assert(isDefined(level.bombZones));

  entrance_origin_points = [];
  entrance_labels = [];

  index = 0;
  foreach(zone in level.bombZones) {
    entrance_origin_points[index] = Random(zone.botTargets).origin;
    entrance_labels[index] = "zone" + zone.label;
    index++;
  }

  bot_cache_entrances(entrance_origin_points, entrance_labels);
}

bot_cache_entrances_to_flags_or_radios(array, label_prefix) {
  assert(isDefined(array));

  wait(1.0);

  entrance_origin_points = [];
  entrance_labels = [];

  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i].botTarget)) {
      entrance_origin_points[i] = array[i].botTarget.origin;
    } else {
      array[i].nearest_node = GetClosestNodeInSight(array[i].origin);

      AssertEx(isDefined(array[i].nearest_node), "Could not calculate nearest node to flag origin " + array[i].origin);
      dist_node_to_origin = Distance(array[i].nearest_node.origin, array[i].origin);
      AssertEx(dist_node_to_origin < 128, "Flag origin " + array[i].origin + " is too far away from the nearest pathnode, at origin " + array[i].nearest_node.origin);

      entrance_origin_points[i] = array[i].nearest_node.origin;
    }
    entrance_labels[i] = label_prefix + array[i].script_label;
  }

  bot_cache_entrances(entrance_origin_points, entrance_labels);
}

entrance_visible_from(entrance_origin, from_origin, stance) {
  assert((stance == "stand") || (stance == "crouch") || stance == ("prone"));

  prone_offset = (0, 0, 11);
  crouch_offset = (0, 0, 40);

  offset = undefined;
  if(stance == "stand") {
    return true;
  } else if(stance == "crouch") {
    offset = crouch_offset;
  } else if(stance == "prone") {
    offset = prone_offset;
  }

  return SightTracePassed(from_origin + offset, entrance_origin + offset, false, undefined);
}

bot_cache_entrances(origin_array, label_array) {
  assert(isDefined(origin_array));
  assert(isDefined(label_array));
  assert(origin_array.size > 0);
  assert(label_array.size > 0);
  assert(origin_array.size == label_array.size);

  wait(0.1);

  entrance_points = [];

  for(i = 0; i < origin_array.size; i++) {
    index = label_array[i];
    entrance_points[index] = FindEntrances(origin_array[i]);
    AssertEx(entrance_points[index].size > 0, "Entrance points for " + index + " at location " + origin_array[i] + " could not be calculated.Check pathgrid around that area");
    wait(0.05);

    for(j = 0; j < entrance_points[index].size; j++) {
      entrance = entrance_points[index][j];

      entrance.is_precalculated_entrance = true;

      entrance.prone_visible_from[index] = entrance_visible_from(entrance.origin, origin_array[i], "prone");
      wait(0.05);

      entrance.crouch_visible_from[index] = entrance_visible_from(entrance.origin, origin_array[i], "crouch");
      wait(0.05);

      for(k = 0; k < label_array.size; k++) {
        for(l = k + 1; l < label_array.size; l++) {
          entrance.on_path_from[label_array[k]][label_array[l]] = 0;
          entrance.on_path_from[label_array[l]][label_array[k]] = 0;
        }
      }
    }
  }

  precalculated_paths = [];
  for(i = 0; i < origin_array.size; i++) {
    for(j = i + 1; j < origin_array.size; j++) {
      path = get_extended_path(origin_array[i], origin_array[j]);
      AssertEx(isDefined(path), "Error calculating path from " + label_array[i] + " " + origin_array[i] + " to " + label_array[j] + " " + origin_array[j] + ". Check pathgrid around those areas");

      if(!isDefined(path)) {
        continue;
      }
      precalculated_paths[label_array[i]][label_array[j]] = path;
      precalculated_paths[label_array[j]][label_array[i]] = path;
      foreach(node in path) {
        node.on_path_from[label_array[i]][label_array[j]] = true;
        node.on_path_from[label_array[j]][label_array[i]] = true;
      }
    }
  }

  if(!isDefined(level.precalculated_paths)) {
    level.precalculated_paths = [];
  }

  if(!isDefined(level.entrance_origin_points)) {
    level.entrance_origin_points = [];
  }

  if(!isDefined(level.entrance_indices)) {
    level.entrance_indices = [];
  }

  if(!isDefined(level.entrance_points)) {
    level.entrance_points = [];
  }

  level.precalculated_paths = array_combine_non_integer_indices(level.precalculated_paths, precalculated_paths);
  level.entrance_origin_points = array_combine(level.entrance_origin_points, origin_array);
  level.entrance_indices = array_combine(level.entrance_indices, label_array);
  level.entrance_points = array_combine_non_integer_indices(level.entrance_points, entrance_points);

  level.entrance_points_finished_caching = true;
}

get_extended_path(start, end) {
  path = func_get_nodes_on_path(start, end);
  if(isDefined(path)) {
    path = remove_ends_from_path(path);
    path = get_all_connected_nodes(path);
  }

  return path;
}

func_get_path_dist(start, end) {
  return GetPathDist(start, end);
}

func_get_nodes_on_path(start, end) {
  return GetNodesOnPath(start, end);
}

func_bot_get_closest_navigable_point(origin, radius, entity) {
  return BotGetClosestNavigablePoint(origin, radius, entity);
}

node_is_on_path_from_labels(label1, label2) {
  if(!isDefined(self.on_path_from) || !isDefined(self.on_path_from[label1]) || !isDefined(self.on_path_from[label1][label2])) {
    return false;
  }

  return self.on_path_from[label1][label2];
}

get_all_connected_nodes(nodes) {
  all_nodes = nodes;

  for(i = 0; i < nodes.size; i++) {
    linked_nodes = GetLinkedNodes(nodes[i]);
    for(j = 0; j < linked_nodes.size; j++) {
      if(!array_contains(all_nodes, linked_nodes[j])) {
        all_nodes = array_add(all_nodes, linked_nodes[j]);

      }
    }
  }

  return all_nodes;
}

get_visible_nodes_array(nodes, node_from) {
  visible_nodes = [];

  foreach(node in nodes) {
    if(NodesVisible(node, node_from, true)) {
      visible_nodes = array_add(visible_nodes, node);
    }
  }

  return visible_nodes;
}

remove_ends_from_path(path) {
  path[path.size - 1] = undefined;
  path[0] = undefined;

  return array_removeUndefined(path);
}

bot_waittill_bots_enabled(only_team_participants) {
  keep_looping = true;
  while(!bot_bots_enabled_or_added(only_team_participants)) {
    wait(0.5);
  }
}

bot_bots_enabled_or_added(only_team_participants) {
  if(BotAutoConnectEnabled()) {
    return true;
  }

  if(bots_exist(only_team_participants)) {
    return true;
  }

  return false;
}

bot_waittill_out_of_combat_or_time(time) {
  start_time = GetTime();

  while(1) {
    if(isDefined(time)) {
      if(GetTime() > start_time + time) {
        return;
      }
    }

    if(!isDefined(self.enemy)) {
      return;
    } else {
      if(!self bot_in_combat()) {
        return;
      }
    }

    wait(0.05);
  }
}

bot_in_combat(optional_time) {
  time_since_last_saw_enemy = GetTime() - self.last_enemy_sight_time;

  check_time = level.bot_out_of_combat_time;
  if(isDefined(optional_time)) {
    check_time = optional_time;
  }

  return (time_since_last_saw_enemy < check_time);
}

bot_waittill_goal_or_fail(optional_time, optional_param_1, optional_param_2) {
  if(!isDefined(optional_param_1) && isDefined(optional_param_2)) {
    AssertEx(false, "Error: Calling bot_waittill_goal_or_fail needs to define param 1 if using param 2");
  }

  wait_array = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];
  if(isDefined(optional_param_1)) {
    wait_array[wait_array.size] = optional_param_1;
  }
  if(isDefined(optional_param_2)) {
    wait_array[wait_array.size] = optional_param_2;
  }

  if(isDefined(optional_time)) {
    result = self waittill_any_in_array_or_timeout(wait_array, optional_time);
  } else {
    result = self waittill_any_in_array_return(wait_array);
  }

  return result;
}

bot_usebutton_wait(time, self_notify_1, self_notify_2) {
  level endon("game_ended");

  self childthread use_button_stopped_notify();

  result = self waittill_any_timeout(time, self_notify_1, self_notify_2, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return result;
}

use_button_stopped_notify(self_notify_1, self_notify_2) {
  self endon("stop_usebutton_watcher");

  wait(0.05);
  while(self UseButtonPressed()) {
    wait(0.05);
  }
  self notify("use_button_no_longer_pressed");
}

bots_exist(only_team_participants) {
  foreach(player in level.participants) {
    if(IsAI(player)) {
      if(isDefined(only_team_participants) && only_team_participants) {
        if(!IsTeamParticipant(player)) {
          continue;
        }
      }

      return true;
    }
  }

  return false;
}

bot_get_entrances_for_stance_and_index(stance, index) {
  assert(!isDefined(stance) || (stance == "stand") || (stance == "crouch") || stance == ("prone"));

  if(!isDefined(level.entrance_points_finished_caching) && !isDefined(self.defense_override_entrances)) {
    return undefined;
  }

  assert(isDefined(index));
  assert((isDefined(level.entrance_points) && isDefined(level.entrance_points[index])) || isDefined(self.defense_override_entrances));

  entrances = [];
  if(isDefined(self.defense_override_entrances)) {
    entrances = self.defense_override_entrances;
  } else {
    entrances = level.entrance_points[index];
  }

  if(!isDefined(stance) || (stance == "stand")) {
    return entrances;
  } else if(stance == "crouch") {
    acceptable_nodes = [];
    foreach(node in entrances) {
      if(node.crouch_visible_from[index]) {
        acceptable_nodes = array_add(acceptable_nodes, node);
      }
    }

    return acceptable_nodes;
  } else if(stance == "prone") {
    acceptable_nodes = [];
    foreach(node in entrances) {
      if(node.prone_visible_from[index]) {
        acceptable_nodes = array_add(acceptable_nodes, node);
      }
    }

    return acceptable_nodes;
  }

  return undefined;
}

SCR_CONST_GUARD_NODE_TOO_CLOSE_DIST_SQ = 100 * 100;

bot_find_node_to_guard_player(center_of_search, radius, opposide_side_of_player) {
  result = undefined;

  player_guarding_velocity = self.bot_defend_player_guarding GetVelocity();
  if(LengthSquared(player_guarding_velocity) > 100) {
    all_nodes_raw = GetNodesInRadius(center_of_search, radius * 1.75, radius * 0.5, 500);

    all_nodes = [];
    normalized_velocity = VectorNormalize(player_guarding_velocity);
    for(i = 0; i < all_nodes_raw.size; i++) {
      player_to_node = VectorNormalize(all_nodes_raw[i].origin - self.bot_defend_player_guarding.origin);
      if(VectorDot(player_to_node, normalized_velocity) > 0.1) {
        all_nodes[all_nodes.size] = all_nodes_raw[i];
      }
    }
  } else {
    all_nodes = GetNodesInRadius(center_of_search, radius, 0, 500);
  }

  if(isDefined(opposide_side_of_player) && opposide_side_of_player) {
    bot_to_player = VectorNormalize(self.bot_defend_player_guarding.origin - self.origin);
    all_nodes_old = all_nodes;
    all_nodes = [];
    foreach(node in all_nodes_old) {
      player_to_node = VectorNormalize(node.origin - self.bot_defend_player_guarding.origin);
      if(VectorDot(bot_to_player, player_to_node) > 0.2) {
        all_nodes[all_nodes.size] = node;
      }
    }
  }

  nodes_not_close = [];
  nodes_same_elevation = [];
  nodes_not_close_same_elevation = [];
  for(i = 0; i < all_nodes.size; i++) {
    add_to_nodes_not_close_array = DistanceSquared(all_nodes[i].origin, center_of_search) > SCR_CONST_GUARD_NODE_TOO_CLOSE_DIST_SQ;
    add_to_same_elevation_array = abs(all_nodes[i].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;

    if(add_to_nodes_not_close_array) {
      nodes_not_close[nodes_not_close.size] = all_nodes[i];
    }

    if(add_to_same_elevation_array) {
      nodes_same_elevation[nodes_same_elevation.size] = all_nodes[i];
    }

    if(add_to_nodes_not_close_array && add_to_same_elevation_array) {
      nodes_not_close_same_elevation[nodes_not_close_same_elevation.size] = all_nodes[i];
    }

    if(i % 100 == 99) {
      wait(0.05);
    }
  }

  if(nodes_not_close_same_elevation.size > 0) {
    result = self BotNodePick(nodes_not_close_same_elevation, nodes_not_close_same_elevation.size * 0.15, "node_capture", center_of_search, undefined, self.defense_score_flags);
  }

  if(!isDefined(result)) {
    wait(0.05);
    if(nodes_same_elevation.size > 0) {
      result = self BotNodePick(nodes_same_elevation, nodes_same_elevation.size * 0.15, "node_capture", center_of_search, undefined, self.defense_score_flags);
    }

    if(!isDefined(result) && nodes_not_close.size > 0) {
      wait(0.05);
      result = self BotNodePick(nodes_not_close, nodes_not_close.size * 0.15, "node_capture", center_of_search, undefined, self.defense_score_flags);
    }
  }

  return result;
}

bot_find_node_to_capture_point(center_of_search, radius, point_to_face) {
  result = undefined;

  all_nodes = GetNodesInRadius(center_of_search, radius, 0, 500);
  if(all_nodes.size > 0) {
    result = self BotNodePick(all_nodes, all_nodes.size * 0.15, "node_capture", center_of_search, point_to_face, self.defense_score_flags);
  }

  return result;
}

bot_find_node_to_capture_zone(nodes, point_to_face) {
  result = undefined;

  if(nodes.size > 0) {
    result = self BotNodePick(nodes, nodes.size * 0.15, "node_capture", undefined, point_to_face, self.defense_score_flags);
  }

  return result;
}

bot_find_node_that_protects_point(center_of_search, radius) {
  result = undefined;

  all_nodes = GetNodesInRadius(center_of_search, radius, 0, 500);
  if(all_nodes.size > 0) {
    result = self BotNodePick(all_nodes, all_nodes.size * 0.15, "node_protect", center_of_search, self.defense_score_flags);
  }

  return result;
}

bot_pick_random_point_in_radius(center_point, node_radius, point_test_func, close_dist, far_dist) {
  point_picked = undefined;

  nodes = GetNodesInRadius(center_point, node_radius, 0, 500);
  if(isDefined(nodes) && nodes.size >= 2) {
    point_picked = bot_find_random_midpoint(nodes, point_test_func);
  }

  if(!isDefined(point_picked)) {
    if(!isDefined(close_dist)) {
      close_dist = 0;
    }
    if(!isDefined(far_dist)) {
      far_dist = 1;
    }

    rand_dist = RandomFloatRange(self.bot_defending_radius * close_dist, self.bot_defending_radius * far_dist);
    rand_dir = anglesToForward((0, RandomInt(360), 0));
    point_picked = center_point + rand_dir * rand_dist;
  }

  return point_picked;
}

bot_pick_random_point_from_set(center_point, node_set, point_test_func) {
  point_picked = undefined;

  if(node_set.size >= 2) {
    point_picked = bot_find_random_midpoint(node_set, point_test_func);
  }

  if(!isDefined(point_picked)) {
    rand_node_picked = Random(node_set);
    vec_to_rand_node = rand_node_picked.origin - center_point;

    point_picked = center_point + VectorNormalize(vec_to_rand_node) * Length(vec_to_rand_node) * RandomFloat(1.0);
  }

  return point_picked;
}

bot_find_random_midpoint(nodes, point_test_func) {
  point_picked = undefined;
  nodes_randomized = array_randomize(nodes);

  for(i = 0; i < nodes_randomized.size; i++) {
    for(j = i + 1; j < nodes_randomized.size; j++) {
      node1 = nodes_randomized[i];
      node2 = nodes_randomized[j];
      if(NodesVisible(node1, node2, true)) {
        point_picked = ((node1.origin[0] + node2.origin[0]) * 0.5, (node1.origin[1] + node2.origin[1]) * 0.5, (node1.origin[2] + node2.origin[2]) * 0.5);
        if(isDefined(point_test_func) && (self[[point_test_func]](point_picked) == true)) {
          return point_picked;
        }
      }
    }
  }

  return point_picked;
}

defend_valid_center() {
  if(isDefined(self.bot_defending_override_origin_node)) {
    return self.bot_defending_override_origin_node.origin;
  } else if(isDefined(self.bot_defending_center)) {
    return self.bot_defending_center;
  }

  return undefined;
}

bot_allowed_to_use_killstreaks() {
  Assert(IsAlive(self));

  if(bot_is_fireteam_mode()) {
    if(isDefined(self.sidelinedByCommander) && self.sidelinedByCommander == true) {
      return false;
    }
  }

  if(self isKillstreakDenied()) {
    return false;
  }

  if(self bot_is_remote_or_linked()) {
    return false;
  }

  if(self isUsingTurret()) {
    return false;
  }

  if(isDefined(level.nukeIncoming)) {
    return false;
  }

  if(isDefined(self.underWater) && self.underWater) {
    return false;
  }

  if(isDefined(self.controlsFrozen) && self.controlsFrozen) {
    return false;
  }

  if(self IsOffhandWeaponReadyToThrow()) {
    return false;
  }

  if(!self bot_in_combat(500)) {
    return true;
  }

  if(!IsAlive(self.enemy)) {
    return true;
  }

  return false;
}

bot_recent_point_of_interest() {
  result = undefined;

  deathExcludeFlags = BotMemoryFlags("investigated", "killer_died");
  killExcludeFlags = BotMemoryFlags("investigated");

  memoryHotSpot = random(BotGetMemoryEvents(0, GetTime() - 10000, 1, "death", deathExcludeFlags, self));
  if(isDefined(memoryHotSpot)) {
    result = memoryHotSpot;
    self.bot_memory_goal_time = 10000;
  } else {
    curScriptGoal = undefined;

    if(self BotGetScriptGoalType() != "none") {
      curScriptGoal = self BotGetScriptGoal();
    }

    bot_killed_someone_from = BotGetMemoryEvents(0, GetTime() - 45000, 1, "kill", killExcludeFlags, self);
    bot_was_killed_from = BotGetMemoryEvents(0, GetTime() - 45000, 1, "death", deathExcludeFlags, self);
    memoryHotSpot = random(array_combine(bot_killed_someone_from, bot_was_killed_from));
    if(isDefined(memoryHotSpot) > 0 && (!isDefined(curScriptGoal) || DistanceSquared(curScriptGoal, memoryHotSpot) > (1000 * 1000))) {
      result = memoryHotSpot;
      self.bot_memory_goal_time = 45000;
    }
  }

  if(isDefined(result)) {
    hotSpotZone = GetZoneNearest(result);
    myZone = GetZoneNearest(self.origin);
    if(isDefined(hotSpotZone) && isDefined(myZone) && myZone != hotSpotZone) {
      activity = BotZoneGetCount(hotSpotZone, self.team, "ally") + BotZoneGetCount(hotSpotZone, self.team, "path_ally");
      if(activity > 1) {
        result = undefined;
      }
    }
  }

  if(isDefined(result)) {
    self.bot_memory_goal = result;
  }

  return result;
}

bot_draw_cylinder(pos, rad, height, duration, stop_notify, color, depthTest, sides) {
  if(!isDefined(duration)) {
    duration = 0;
  }

  level thread bot_draw_cylinder_think(pos, rad, height, duration, stop_notify, color, depthTest, sides);
}

bot_draw_cylinder_think(pos, rad, height, seconds, stop_notify, color, depthTest, sides) {
  if(isDefined(stop_notify)) {
    level endon(stop_notify);
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(depthTest)) {
    depthTest = false;
  }

  if(!isDefined(sides)) {
    sides = 20;
  }

  stop_time = GetTime() + (seconds * 1000);

  currad = rad;
  curheight = height;

  for(;;) {
    if(seconds > 0 && stop_time <= GetTime()) {
      return;
    }

    for(r = 0; r < sides; r++) {
      theta = r / sides * 360;
      theta2 = (r + 1) / sides * 360;

      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, 1.0, depthTest);
      line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, 1.0, depthTest);
      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, 1.0, depthTest);
    }

    wait(0.05);
  }

}

bot_draw_circle(center, radius, color, depthTest, segments) {
  if(!isDefined(segments)) {
    segments = 16;
  }

  angleFrac = 360 / segments;
  circlepoints = [];

  for(i = 0; i < segments; i++) {
    angle = (angleFrac * i);
    xAdd = cos(angle) * radius;
    yAdd = sin(angle) * radius;
    x = center[0] + xAdd;
    y = center[1] + yAdd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }

  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];
    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    line(start, end, color, 1.0, depthTest);
  }

}

bot_get_total_gun_ammo() {
  total_ammo = 0;

  weapon_list = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    weapon_list = self.weaponlist;
  } else {
    weapon_list = self GetWeaponsListPrimaries();
  }

  foreach(weapon in weapon_list) {
    total_ammo += self GetWeaponAmmoClip(weapon);
    total_ammo += self GetWeaponAmmoStock(weapon);
  }

  return total_ammo;
}

bot_out_of_ammo() {
  if(self isJuggernaut()) {
    if(isDefined(self.isJuggernautManiac) || isDefined(self.isJuggernautLevelCustom)) {
      if(self.personality != "run_and_gun") {
        self.prev_personality = self.personality;
        self bot_set_personality("run_and_gun");
      }
      return true;
    }
  }

  weapon_list = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    weapon_list = self.weaponlist;
  } else {
    weapon_list = self GetWeaponsListPrimaries();
  }

  foreach(weapon in weapon_list) {
    if(self GetWeaponAmmoClip(weapon) > 0) {
      return false;
    }

    if(self GetWeaponAmmoStock(weapon) > 0) {
      return false;
    }
  }

  return true;
}

bot_get_grenade_ammo() {
  total_grenades = 0;

  offhand_list = self GetWeaponsListOffhands();

  foreach(weapon in offhand_list) {
    total_grenades += self GetWeaponAmmoStock(weapon);
  }

  return total_grenades;
}

bot_grenade_matches_purpose(purpose, grenade) {
  if(!isDefined(grenade)) {
    return false;
  }

  switch (purpose) {
    case "trap_directional":
      switch (grenade) {
        case "claymore_mp":
          return true;
      }
      break;
    case "trap":
      switch (grenade) {
        case "proximity_explosive_mp":
        case "motion_sensor_mp":
        case "trophy_mp":
          return true;
      }
      break;
    case "c4":
      switch (grenade) {
        case "c4_mp":
          return true;
      }
      break;
    case "tacticalinsertion":
      switch (grenade) {
        case "flare_mp":
          return true;
      }
      break;
  }

  return false;
}

bot_get_grenade_for_purpose(purpose) {
  if(self BotGetDifficultySetting("allowGrenades") != 0) {
    grenade = self BotFirstAvailableGrenade("lethal");
    if(bot_grenade_matches_purpose(purpose, grenade)) {
      return "lethal";
    }

    grenade = self BotFirstAvailableGrenade("tactical");
    if(bot_grenade_matches_purpose(purpose, grenade)) {
      return "tactical";
    }
  }
}

bot_watch_nodes(nodes, yaw, yaw_fov, end_time, end1, end2, end3, end4) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");
  self endon("death");

  wait(1.0);
  keep_waiting = true;
  while(keep_waiting) {
    if(self BotHasScriptGoal() && self BotPursuingScriptGoal()) {
      if(DistanceSquared(self BotGetScriptGoal(), self.origin) < 16) {
        keep_waiting = false;
      }
    }

    if(keep_waiting) {
      wait(0.05);
    }
  }

  origin_when_calculating = self.origin;

  if(isDefined(nodes)) {
    self.watch_nodes = [];
    foreach(node in nodes) {
      node_invalid = false;

      if(Distance2DSquared(self.origin, node.origin) <= 10) {
        node_invalid = true;
      }

      self_eye = self getEye();
      dot_to_node = VectorDot((0, 0, 1), VectorNormalize(node.origin - self_eye));
      if(abs(dot_to_node) > 0.92) {
        node_invalid = true;
        AssertEx(abs(node.origin[2] - self_eye[2]) < 1000, "bot_watch_nodes() error - Bot with eyes at location " + self_eye + " trying to watch invalid point " + node.origin);
      }

      if(!node_invalid) {
        self.watch_nodes[self.watch_nodes.size] = node;
      }
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }
  if(isDefined(end1)) {
    self endon(end1);
  }
  if(isDefined(end2)) {
    self endon(end2);
  }
  if(isDefined(end3)) {
    self endon(end3);
  }
  if(isDefined(end4)) {
    self endon(end4);
  }

  self thread watch_nodes_aborted();

  self.watch_nodes = array_randomize(self.watch_nodes);

  foreach(node in self.watch_nodes) {
    node.watch_node_chance[self.entity_number] = 1.0;
  }

  startTime = GetTime();
  nextLookTime = startTime;
  node_vis_times = [];

  yawAngles = undefined;
  if(isDefined(yaw)) {
    yawAngles = (0, yaw, 0);
  }
  has_yaw_angles_and_fov = isDefined(yawAngles) && isDefined(yaw_fov);

  lookingAtNode = undefined;

  for(;;) {
    now = GetTime();
    self notify("still_watching_nodes");
    bot_fov = self BotGetFovDot();

    if(isDefined(end_time) && (now >= end_time)) {
      return;
    }
    if(self bot_has_tactical_goal()) {
      self BotLookAtPoint(undefined);
      wait(0.2);
      continue;
    }

    if(!self BotHasScriptGoal() || !self BotPursuingScriptGoal()) {
      wait(0.2);
      continue;
    }

    if(isDefined(lookingAtNode) && lookingAtNode.watch_node_chance[self.entity_number] == 0.0) {
      nextLookTime = now;
    }

    if(self.watch_nodes.size > 0) {
      lookingTowardEnemy = false;

      if(isDefined(self.enemy)) {
        enemyKnownPos = self LastKnownPos(self.enemy);
        enemyKnownTime = self LastKnownTime(self.enemy);
        if(enemyKnownTime && ((now - enemyKnownTime) < 5000)) {
          dirEnemy = VectorNormalize(enemyKnownPos - self.origin);
          maxDot = 0;
          for(i = 0; i < self.watch_nodes.size; i++) {
            dirNode = VectorNormalize(self.watch_nodes[i].origin - self.origin);
            dot = VectorDot(dirEnemy, dirNode);

            if(dot > maxDot) {
              maxDot = dot;
              lookingAtNode = self.watch_nodes[i];
              lookingTowardEnemy = true;
            }
          }
        }
      }

      if(!lookingTowardEnemy && (now >= nextLookTime)) {
        watch_nodes_oldest_to_newest = [];
        for(i = 0; i < self.watch_nodes.size; i++) {
          node = self.watch_nodes[i];
          node_num = node GetNodeNumber();

          if(has_yaw_angles_and_fov && !within_fov(self.origin, yawAngles, node.origin, yaw_fov)) {
            continue;
          }

          if(!isDefined(node_vis_times[node_num])) {
            node_vis_times[node_num] = 0;
          }

          if(within_fov(self.origin, self.angles, node.origin, bot_fov)) {
            node_vis_times[node_num] = now;
          }

          index = 0;
          for(; index < watch_nodes_oldest_to_newest.size; index++) {
            if(node_vis_times[watch_nodes_oldest_to_newest[index] GetNodeNumber()] > node_vis_times[node_num]) {
              break;
            }
          }

          watch_nodes_oldest_to_newest = array_insert(watch_nodes_oldest_to_newest, node, index);
        }

        lookingAtNode = undefined;
        for(i = 0; i < watch_nodes_oldest_to_newest.size; i++) {
          if(RandomFloat(1) > watch_nodes_oldest_to_newest[i].watch_node_chance[self.entity_number]) {
            continue;
          }
          lookingAtNode = watch_nodes_oldest_to_newest[i];
          nextLookTime = now + RandomIntRange(3000, 5000);
          break;
        }
      }

      if(isDefined(lookingAtNode)) {
        node_offset = (0, 0, self GetPlayerViewHeight());
        look_at_point = lookingAtNode.origin + node_offset;

        eyePos = self.origin + (0, 0, 55);
        botToPoint = VectorNormalize(look_at_point - eyePos);
        vecUp = (0, 0, 1);

        if(VectorDot(vecUp, botToPoint) > 0.92) {
          self BotLookAtPoint(look_at_point, 0.4, "script_search");
        }
      }
    }

    wait(0.2);
  }
}

watch_nodes_stop() {
  self notify("bot_watch_nodes_stop");
  self.watch_nodes = undefined;
}

watch_nodes_aborted() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");

  while(1) {
    msg = self waittill_any_timeout(0.5, "still_watching_nodes");
    if(!isDefined(msg) || msg != "still_watching_nodes") {
      self watch_nodes_stop();
      return;
    }
  }
}

bot_leader_dialog(dialog, location) {
  if(isDefined(location) && (location != (0, 0, 0))) {
    Assert(isDefined(self));
    Assert(isDefined(self.origin));

    if(!within_fov(self.origin, self.angles, location, self BotGetFovDot())) {
      lookAtLoc = self BotPredictSeePoint(location);
      if(isDefined(lookAtLoc)) {
        self BotLookAtPoint(lookAtLoc + (0, 0, 40), 1.0, "script_seek");
      }
    }

    self BotMemoryEvent("known_enemy", undefined, location);
  }
}

bot_get_known_attacker(attacker, inflictor) {
  if(isDefined(inflictor) && isDefined(inflictor.classname)) {
    if(inflictor.classname == "grenade") {
      if(!bot_ent_is_anonymous_mine(inflictor)) {
        return attacker;
      }
    } else if(inflictor.classname == "rocket") {
      if(isDefined(inflictor.vehicle_fired_from)) {
        return inflictor.vehicle_fired_from;
      }
      if(isDefined(inflictor.type) && (inflictor.type == "remote" || inflictor.type == "odin")) {
        return inflictor;
      }

      if(isDefined(inflictor.owner)) {
        return inflictor.owner;
      }
    } else if(inflictor.classname == "worldspawn" || inflictor.classname == "trigger_hurt") {
      return undefined;
    }

    return inflictor;
  }

  return attacker;
}

bot_ent_is_anonymous_mine(ent) {
  if(!isDefined(ent.weapon_name)) {
    return false;
  }

  if(ent.weapon_name == "c4_mp") {
    return true;
  }

  if(ent.weapon_name == "proximity_explosive_mp") {
    return true;
  }

  return false;
}

bot_vectors_are_equal(vec1, vec2) {
  return (vec1[0] == vec2[0] && vec1[1] == vec2[1] && vec1[2] == vec2[2]);
}

bot_add_to_bot_level_targets(target_to_add) {
  target_to_add.high_priority_for = [];

  if(target_to_add.bot_interaction_type == "use") {
    bot_add_to_bot_use_targets(target_to_add);
  } else if(target_to_add.bot_interaction_type == "damage") {
    bot_add_to_bot_damage_targets(target_to_add);
  } else {
    AssertMsg("bot_add_to_bot_level_targets needs a trigger with bot_interaction_type set");
  }
}

bot_remove_from_bot_level_targets(target_to_remove) {
  target_to_remove.already_used = true;
  level.level_specific_bot_targets = array_remove(level.level_specific_bot_targets, target_to_remove);
}

bot_add_to_bot_use_targets(new_use_target) {
  if(!IsSubStr(new_use_target.code_classname, "trigger_use")) {
    AssertMsg("bot_add_to_bot_use_targets can only be used with a trigger_use");
    return;
  }

  if(!isDefined(new_use_target.target)) {
    AssertMsg("bot_add_to_bot_use_targets needs a trigger with a target");
    return;
  }

  if(isDefined(new_use_target.bot_target)) {
    AssertMsg("bot_add_to_bot_use_targets has already been processed for this trigger");
    return;
  }

  if(!isDefined(new_use_target.use_time)) {
    AssertMsg("bot_add_to_bot_use_targets needs .use_time set");
    return;
  }

  use_trigger_targets = GetNodeArray(new_use_target.target, "targetname");
  if(use_trigger_targets.size != 1) {
    AssertMsg("bot_add_to_bot_use_targets needs to target exactly one node");
    return;
  }

  new_use_target.bot_target = use_trigger_targets[0];

  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = array_add(level.level_specific_bot_targets, new_use_target);
}

bot_add_to_bot_damage_targets(new_damage_target) {
  if(!IsSubStr(new_damage_target.code_classname, "trigger_damage")) {
    AssertMsg("bot_add_to_bot_damage_targets can only be used with a trigger_damage");
    return;
  }

  damage_trigger_targets = GetNodeArray(new_damage_target.target, "targetname");
  if(damage_trigger_targets.size != 2) {
    AssertMsg("bot_add_to_bot_use_targets needs to target exactly two nodes");
    return;
  }

  new_damage_target.bot_targets = damage_trigger_targets;

  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = array_add(level.level_specific_bot_targets, new_damage_target);
}

bot_get_string_index_for_integer(array, integer_index) {
  current_index = 0;
  foreach(string_index, array_value in array) {
    if(current_index == integer_index) {
      return string_index;
    }
    current_index++;
  }

  return undefined;
}

bot_get_zones_within_dist(target_zone_index, max_dist) {
  for(z = 0; z < level.zoneCount; z++) {
    zone_node = GetZoneNodeForIndex(z);
    zone_node.visited = false;
  }

  target_zone_node = GetZoneNodeForIndex(target_zone_index);
  return bot_get_zones_within_dist_recurs(target_zone_node, max_dist);
}

bot_get_zones_within_dist_recurs(target_zone_node, max_dist) {
  all_zones = [];
  all_zones[0] = GetNodeZone(target_zone_node);

  target_zone_node.visited = true;
  target_zone_linked_nodes = GetLinkedNodes(target_zone_node);

  foreach(node in target_zone_linked_nodes) {
    if(!node.visited) {
      distance_to_zone = Distance(target_zone_node.origin, node.origin);
      if(distance_to_zone < max_dist) {
        new_zones = bot_get_zones_within_dist_recurs(node, (max_dist - distance_to_zone));
        all_zones = array_combine(new_zones, all_zones);
      }
    }
  }

  return all_zones;
}

bot_crate_is_command_goal(crate) {
  return (isDefined(crate) && isDefined(crate.command_goal) && crate.command_goal);
}

bot_get_team_limit() {
  return INT(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  maxPlayers = GetDvarInt("party_maxplayers", 0);
  maxPlayers = max(maxPlayers, GetDvarInt("party_maxPrivatePartyPlayers", 0));

  if(GetDvar("squad_vs_squad") == "1" || GetDvar("squad_use_hosts_squad") == "1" || GetDvar("squad_match") == "1") {
    maxPlayers = 12;
  }

  if(!level.teamBased) {
    maxPlayers = min(8, maxPlayers);
  }

  if(maxPlayers > level.maxClients) {
    return level.maxClients;
  }

  return maxPlayers;
}

bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");

  wait(0.05);

  while(1) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      process = level.bot_queued_process_queue[0];

      if(isDefined(process) && isDefined(process.owner)) {
        assert(isDefined(process.func));
        result = undefined;
        if(isDefined(process.parm4)) {
          result = process.owner[[process.func]](process.parm1, process.parm2, process.parm3, process.parm4);
        } else if(isDefined(process.parm3)) {
          result = process.owner[[process.func]](process.parm1, process.parm2, process.parm3);
        } else if(isDefined(process.parm2)) {
          result = process.owner[[process.func]](process.parm1, process.parm2);
        } else if(isDefined(process.parm1)) {
          result = process.owner[[process.func]](process.parm1);
        } else {
          result = process.owner[[process.func]]();
        }
        process.owner notify(process.name_complete, result);
      }

      new_queue = [];
      for(i = 1; i < level.bot_queued_process_queue.size; i++) {
        new_queue[i - 1] = level.bot_queued_process_queue[i];
      }
      level.bot_queued_process_queue = new_queue;
    }

    wait 0.05;
  }
}

bot_queued_process(process_name, process_func, optional_parm1, optional_parm2, optional_parm3, optional_parm4) {
  if(!isDefined(level.bot_queued_process_queue)) {
    level.bot_queued_process_queue = [];
  }

  foreach(index, process in level.bot_queued_process_queue) {
    if(process.owner == self && process.name == process_name) {
      self notify(process.name);
      level.bot_queued_process_queue[index] = undefined;
    }
  }

  process = spawnStruct();
  process.owner = self;
  process.name = process_name;
  process.name_complete = process.name + "_done";
  process.func = process_func;
  process.parm1 = optional_parm1;
  process.parm2 = optional_parm2;
  process.parm3 = optional_parm3;
  process.parm4 = optional_parm4;

  level.bot_queued_process_queue[level.bot_queued_process_queue.size] = process;

  if(!isDefined(level.bot_queued_process_level_thread_active)) {
    level.bot_queued_process_level_thread_active = true;
    level thread bot_queued_process_level_thread();
  }

  self waittill(process.name_complete, result);

  return result;
}

bot_is_remote_or_linked() {
  return (self isUsingRemote() || self IsLinked());
}

bot_get_low_on_ammo(minFrac) {
  weapon_list = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    weapon_list = self.weaponlist;
  } else {
    weapon_list = self GetWeaponsListPrimaries();
  }

  foreach(weapon in weapon_list) {
    max_clip_ammo = WeaponClipSize(weapon);
    stock_ammo = self GetWeaponAmmoStock(weapon);

    if(stock_ammo <= max_clip_ammo) {
      return true;
    }

    if(self GetFractionMaxAmmo(weapon) <= minFrac) {
      return true;
    }
  }

  return false;
}

bot_point_is_on_pathgrid(point, radius, height) {
  if(!isDefined(radius)) {
    radius = 256;
  }

  if(!isDefined(height)) {
    height = 50;
  }

  nodes = GetNodesInRadiusSorted(point, radius, 0, height, "Path");
  foreach(node in nodes) {
    start = point + (0, 0, 30);
    end = node.origin + (0, 0, 30);
    trace_end = PhysicsTrace(start, end);
    if(bot_vectors_are_equal(trace_end, end)) {
      return true;
    }

    wait(0.05);
  }

  return false;
}

bot_monitor_enemy_camp_spots(validateFunc) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");

  level.enemy_camp_spots = [];
  level.enemy_camp_assassin_goal = [];
  level.enemy_camp_assassin = [];

  while(1) {
    wait 1.0;

    updated = [];

    if(!isDefined(validateFunc)) {
      continue;
    }
    foreach(participant in level.participants) {
      if(!isDefined(participant.team)) {
        continue;
      }
      if(participant[[validateFunc]]() && !isDefined(updated[participant.team])) {
        level.enemy_camp_assassin[participant.team] = undefined;
        level.enemy_camp_spots[participant.team] = participant BotPredictEnemyCampSpots(true);

        if(isDefined(level.enemy_camp_spots[participant.team])) {
          if(!isDefined(level.enemy_camp_assassin_goal[participant.team]) ||
            !array_contains(level.enemy_camp_spots[participant.team], level.enemy_camp_assassin_goal[participant.team]))
            level.enemy_camp_assassin_goal[participant.team] = random(level.enemy_camp_spots[participant.team]);

          if(isDefined(level.enemy_camp_assassin_goal[participant.team])) {
            aiAllies = [];
            foreach(otherParticipant in level.participants) {
              if(!isDefined(otherParticipant.team)) {
                continue;
              }
              if(otherParticipant[[validateFunc]]() && (otherParticipant.team == participant.team)) {
                aiAllies[aiAllies.size] = otherParticipant;
              }
            }
            aiAllies = SortByDistance(aiAllies, level.enemy_camp_assassin_goal[participant.team]);

            if(aiAllies.size > 0) {
              level.enemy_camp_assassin[participant.team] = aiAllies[0];
            }
          }
        }

        updated[participant.team] = true;
      }
    }
  }
}

bot_valid_camp_assassin() {
  if(!isDefined(self)) {
    return false;
  }

  if(!isAI(self)) {
    return false;
  }

  if(!isDefined(self.team)) {
    return false;
  }

  if(self.team == "spectator") {
    return false;
  }

  if(!IsAlive(self)) {
    return false;
  }

  if(!IsAITeamParticipant(self)) {
    return false;
  }

  if(self.personality == "camper") {
    return false;
  }

  return true;
}

bot_update_camp_assassin() {
  if(!isDefined(level.enemy_camp_assassin)) {
    return;
  }
  if(!isDefined(level.enemy_camp_assassin[self.team])) {
    return;
  }
  if(level.enemy_camp_assassin[self.team] == self) {
    self bot_defend_stop();
    self BotSetScriptGoal(level.enemy_camp_assassin_goal[self.team], 128, "objective", undefined, 256);
    self bot_waittill_goal_or_fail();
  }
}

bot_force_stance_for_time(stance, seconds) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self BotSetStance(stance);
  wait seconds;
  self BotSetStance("none");
}