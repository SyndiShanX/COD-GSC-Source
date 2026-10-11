/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_common.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace bots_gametype_common;

function bot_cache_entrances_to_bombzones() {
  assert(isDefined(level.objectives));
  entrance_origin_points = [];
  var_31ac0f14318b785f = [];
  index = 0;

  foreach(zone in level.objectives) {
    if(isDefined(zone.bottargets)) {
      if(zone.bottargets.size > 0) {
        if(isDefined(zone.objectivekey)) {
          entrance_origin_points[index] = random(zone.bottargets).origin;
          var_31ac0f14318b785f[index] = "zone" + zone.objectivekey;
          index++;
        } else {
          assertex(zone.objectivekey, "<dev string:x1c>");
        }
      } else {
        assertex(zone.bottargets.size > 0, "<dev string:x77>");
      }

      continue;
    }

    assertex(isDefined(zone.bottargets), "<dev string:xd2>");
  }

  bot_cache_entrances(entrance_origin_points, var_31ac0f14318b785f);
}

function bot_cache_entrances_to_gametype_array(array, label_prefix, ignore_paths, var_59d7820e096a5ff9) {
  assert(isDefined(array));

  if(game_utility::gettimepassed() < 5000) {
    wait 1;
  }

  entrance_origin_points = [];
  var_31ac0f14318b785f = [];
  var_e435228617b823e7 = 0;

  foreach(gameobject in array) {
    gameobjecttrigger = gameobject.trigger;

    if(isDefined(gameobjecttrigger.bottarget)) {
      entrance_origin_points[var_e435228617b823e7] = gameobjecttrigger.bottarget.origin;
    } else {
      gameobjecttrigger.nearest_node = getclosestnodeinsight(gameobjecttrigger.origin);

      if(!isDefined(gameobjecttrigger.nearest_node) || gameobjecttrigger.nearest_node nodeisdisconnected()) {
        nodes = getnodesinradiussorted(gameobjecttrigger.origin, 256, 0);

        if(nodes.size > 0) {
          gameobjecttrigger.nearest_node = nodes[0];
        }
      }

      if(!isDefined(gameobjecttrigger.nearest_node)) {
        assertmsg("<dev string:x12b>" + gameobjecttrigger.origin);
        continue;
      }

      if(distance(gameobjecttrigger.nearest_node.origin, gameobjecttrigger.origin) > 130) {
        assertmsg("<dev string:x168>" + gameobjecttrigger.origin + "<dev string:x183>" + gameobjecttrigger.nearest_node.origin);
        gameobjecttrigger.nearest_node = undefined;
        continue;
      }

      entrance_origin_points[var_e435228617b823e7] = gameobjecttrigger.nearest_node.origin;
    }

    var_31ac0f14318b785f[var_e435228617b823e7] = label_prefix + gameobject.objectivekey;
    var_e435228617b823e7++;
  }

  bot_cache_entrances(entrance_origin_points, var_31ac0f14318b785f, ignore_paths, var_59d7820e096a5ff9);
}

function bot_cache_entrances(origin_array, label_array, ignore_paths, var_59d7820e096a5ff9) {
  assert(isDefined(origin_array));
  assert(isDefined(label_array));
  assert(origin_array.size > 0);
  assert(label_array.size > 0);
  assert(origin_array.size == label_array.size);
  calculate_paths = !isDefined(ignore_paths) || !ignore_paths;
  var_129f7bac538976fc = isDefined(var_59d7820e096a5ff9) && var_59d7820e096a5ff9;
  wait 0.1;

  if(var_129f7bac538976fc && calculate_paths) {
    nodes = getallnodes();

    foreach(node in nodes) {
      node.on_path_from = undefined;
    }
  }

  entrance_points = [];

  for(i = 0; i < origin_array.size; i++) {
    index = label_array[i];
    entrance_points[index] = findentrances(origin_array[i]);
    wait 0.05;
    var_e20df846c8700ef = 0;
    var_9b944e0aa5fad8cb = 1;

    if(game_utility::gettimepassed() >= 5000) {
      var_9b944e0aa5fad8cb = 4;
    }

    for(j = 0; j < entrance_points[index].size; j++) {
      entrance = entrance_points[index][j];
      entrance.is_precalculated_entrance = 1;
      entrance.prone_visible_from[index] = entrance_visible_from(entrance.origin, origin_array[i], "prone");
      var_e20df846c8700ef++;

      if(var_e20df846c8700ef >= var_9b944e0aa5fad8cb) {
        var_e20df846c8700ef = 0;
        wait 0.05;
      }

      entrance.crouch_visible_from[index] = entrance_visible_from(entrance.origin, origin_array[i], "crouch");
      var_e20df846c8700ef++;

      if(var_e20df846c8700ef >= var_9b944e0aa5fad8cb) {
        var_e20df846c8700ef = 0;
        wait 0.05;
      }
    }
  }

  precalculated_paths = [];

  if(calculate_paths) {
    for(i = 0; i < origin_array.size; i++) {
      for(j = i + 1; j < origin_array.size; j++) {
        path = get_extended_path(origin_array[i], origin_array[j]);
        assertex(isDefined(path), "<dev string:x1bd>" + label_array[i] + "<dev string:x1dd>" + origin_array[i] + "<dev string:x1e2>" + label_array[j] + "<dev string:x1dd>" + origin_array[j] + "<dev string:x1ea>");

        if(!isDefined(path)) {
          continue;
        }

        precalculated_paths[label_array[i]][label_array[j]] = path;
        precalculated_paths[label_array[j]][label_array[i]] = path;

        foreach(node in path) {
          node.on_path_from[label_array[i]][label_array[j]] = 1;
        }
      }
    }
  }

  if(calculate_paths) {
    if(!isDefined(level.precalculated_paths)) {
      level.precalculated_paths = [];
    }
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

  if(calculate_paths) {
    if(var_129f7bac538976fc) {
      level.precalculated_paths = precalculated_paths;
    } else {
      level.precalculated_paths = array_combine_non_integer_indices(level.precalculated_paths, precalculated_paths);
    }
  }

  if(var_129f7bac538976fc) {
    level.entrance_origin_points = origin_array;
    level.entrance_indices = label_array;
    level.entrance_points = entrance_points;
  } else {
    level.entrance_origin_points = array_combine(level.entrance_origin_points, origin_array);
    level.entrance_indices = array_combine(level.entrance_indices, label_array);
    level.entrance_points = array_combine_non_integer_indices(level.entrance_points, entrance_points);
  }

  level.entrance_points_finished_caching = 1;
}

function bot_add_missing_nodes(nodes, trigger) {
  assert(isDefined(nodes) && isDefined(trigger));

  if(trigger.classname == "trigger_radius") {
    var_d2d0bf810cf372e = getnodesinradius(trigger.origin, trigger.radius, 0, 100);
    var_7c3babd4364b03c4 = array_remove_array(var_d2d0bf810cf372e, nodes);

    if(var_7c3babd4364b03c4.size > 0) {
      nodes = array_combine(nodes, var_7c3babd4364b03c4);
    }
  } else if(trigger.classname == "trigger_multiple" || trigger.classname == "trigger_use_touch") {
    bound_points[0] = trigger getpointinbounds(1, 1, 1);
    bound_points[1] = trigger getpointinbounds(1, 1, -1);
    bound_points[2] = trigger getpointinbounds(1, -1, 1);
    bound_points[3] = trigger getpointinbounds(1, -1, -1);
    bound_points[4] = trigger getpointinbounds(-1, 1, 1);
    bound_points[5] = trigger getpointinbounds(-1, 1, -1);
    bound_points[6] = trigger getpointinbounds(-1, -1, 1);
    bound_points[7] = trigger getpointinbounds(-1, -1, -1);
    farthest_dist = 0;

    foreach(point in bound_points) {
      dist = distance(point, trigger.origin);

      if(dist > farthest_dist) {
        farthest_dist = dist;
      }
    }

    var_d2d0bf810cf372e = getnodesinradius(trigger.origin, farthest_dist, 0, 200);

    foreach(node in var_d2d0bf810cf372e) {
      if(!ispointinvolume(node.origin, trigger)) {
        if(ispointinvolume(node.origin + (0, 0, 40), trigger) || ispointinvolume(node.origin + (0, 0, 80), trigger) || ispointinvolume(node.origin + (0, 0, 120), trigger)) {
          nodes = array_add(nodes, node);
        }
      }
    }
  }

  return nodes;
}

function bot_setup_objective_bottargets() {
  wait 1;
  bot_setup_bot_targets(level.objectives);
  level.bot_set_objective_bottargets = 1;
}

function bot_setup_bot_targets(array) {
  foreach(element in array) {
    if(!isDefined(element.bottargets)) {
      element.bottargets = bot_get_valid_nodes_in_trigger(element.trigger);
    }
  }
}

function function_5c7085cb60319b4() {
  return isDefined(level.var_5c7085cb60319b4) && level.var_5c7085cb60319b4;
}

function bot_gametype_get_num_players_on_team(team) {
  var_35b2ace44b93c013 = 0;

  foreach(player in level.participants) {
    if(isteamparticipant(player) && isDefined(player.team) && player.team == team) {
      if(function_5c7085cb60319b4() && !isai(player)) {
        continue;
      }

      var_35b2ace44b93c013++;
    }
  }

  return var_35b2ace44b93c013;
}

function bot_gametype_get_allied_attackers_for_team(team, defend_origin, defend_radius) {
  attackers = bot_gametype_get_players_by_role("attacker", team);

  foreach(player in level.players) {
    if(!isai(player) && isDefined(player.team) && player.team == team) {
      if(function_5c7085cb60319b4()) {
        continue;
      }

      if(player bot_gametype_human_player_always_considered_attacker() || distancesquared(defend_origin, player.origin) > squared(defend_radius)) {
        attackers = array_add(attackers, player);
      }
    }
  }

  return attackers;
}

function bot_gametype_get_allied_defenders_for_team(team, defend_origin, defend_radius) {
  defenders = bot_gametype_get_players_by_role("defender", team);

  foreach(player in level.players) {
    if(!isai(player) && isDefined(player.team) && player.team == team) {
      if(function_5c7085cb60319b4()) {
        continue;
      }

      if(player bot_gametype_human_player_always_considered_defender() || distancesquared(defend_origin, player.origin) <= squared(defend_radius)) {
        defenders = array_add(defenders, player);
      }
    }
  }

  return defenders;
}

function bot_gametype_human_player_always_considered_attacker() {
  if(isDefined(level.bot_gametype_human_player_always_attacker)) {
    return self[[level.bot_gametype_human_player_always_attacker]]();
  }

  return 0;
}

function bot_gametype_human_player_always_considered_defender() {
  if(isDefined(level.bot_gametype_human_player_always_defender)) {
    return self[[level.bot_gametype_human_player_always_defender]]();
  }

  return 0;
}

function bot_gametype_set_role(new_role) {
  self.role = new_role;
  self botclearscriptgoal();
  bot_defend_stop();
}

function bot_gametype_get_players_by_role(role, team) {
  players = [];

  foreach(player in level.participants) {
    if(isDefined(player.team) && isalive(player) && isteamparticipant(player) && player.team == team && isDefined(player.role) && player.role == role) {
      players[players.size] = player;
    }
  }

  return players;
}

function bot_gametype_initialize_attacker_defender_role() {
  attackers = [[level.bot_gametype_allied_attackers_for_team]](self.team);
  defenders = [[level.bot_gametype_allied_defenders_for_team]](self.team);
  attacker_limit = [[level.bot_gametype_attacker_limit_for_team]](self.team);
  defender_limit = [[level.bot_gametype_defender_limit_for_team]](self.team);
  personality_type = level.bot_personality_type[self.personality];

  if(personality_type == "active") {
    if(attackers.size >= attacker_limit) {
      var_8668b3fa2350c9b3 = 0;

      foreach(attacker in attackers) {
        if(isai(attacker) && level.bot_personality_type[attacker.personality] == "stationary" && attacker bot_can_switch_to_defender()) {
          attacker.role = undefined;
          var_8668b3fa2350c9b3 = 1;
          break;
        }
      }

      if(var_8668b3fa2350c9b3) {
        bot_gametype_set_role("attacker");
      } else {
        bot_gametype_set_role("defender");
      }
    } else {
      bot_gametype_set_role("attacker");
    }

    return;
  }

  if(personality_type == "stationary") {
    if(defenders.size >= defender_limit) {
      var_8668b3fa2350c9b3 = 0;

      foreach(defender in defenders) {
        if(isai(defender) && level.bot_personality_type[defender.personality] == "active" && defender bot_can_switch_to_attacker()) {
          defender.role = undefined;
          var_8668b3fa2350c9b3 = 1;
          break;
        }
      }

      if(var_8668b3fa2350c9b3) {
        bot_gametype_set_role("defender");
      } else {
        bot_gametype_set_role("attacker");
      }

      return;
    }

    bot_gametype_set_role("defender");
  }
}

function bot_gametype_attacker_defender_ai_director_update() {
  level notify("bot_gametype_attacker_defender_ai_director_update");
  level endon("bot_gametype_attacker_defender_ai_director_update");
  level endon("game_ended");
  teams = ["allies", "axis"];
  var_2e28f7108faa95fc = gettime() + 2000;

  while(true) {
    if(gettime() > var_2e28f7108faa95fc) {
      var_2e28f7108faa95fc = gettime() + 1000;

      foreach(team in teams) {
        attackers = [[level.bot_gametype_allied_attackers_for_team]](team);
        defenders = [[level.bot_gametype_allied_defenders_for_team]](team);
        attacker_limit = [[level.bot_gametype_attacker_limit_for_team]](team);
        defender_limit = [[level.bot_gametype_defender_limit_for_team]](team);

        if(attackers.size > attacker_limit) {
          ai_attackers = [];
          removed_attacker = 0;

          foreach(attacker in attackers) {
            if(isai(attacker) && attacker bot_can_switch_to_defender()) {
              if(level.bot_personality_type[attacker.personality] == "stationary") {
                attacker bot_gametype_set_role("defender");
                removed_attacker = 1;
                break;
              }

              ai_attackers = array_add(ai_attackers, attacker);
            }
          }

          if(!removed_attacker && ai_attackers.size > 0) {
            random(ai_attackers) bot_gametype_set_role("defender");
          }
        }

        if(defenders.size > defender_limit) {
          ai_defenders = [];
          removed_defender = 0;

          foreach(defender in defenders) {
            if(isai(defender) && defender bot_can_switch_to_attacker()) {
              if(level.bot_personality_type[defender.personality] == "active") {
                defender bot_gametype_set_role("attacker");
                removed_defender = 1;
                break;
              }

              ai_defenders = array_add(ai_defenders, defender);
            }
          }

          if(!removed_defender && ai_defenders.size > 0) {
            random(ai_defenders) bot_gametype_set_role("attacker");
          }
        }
      }
    }

    wait 0.05;
  }
}

function bot_can_switch_to_attacker() {
  if(isDefined(level.bot_gametype_allowed_to_switch_to_attacker)) {
    return self[[level.bot_gametype_allowed_to_switch_to_attacker]]();
  }

  return 1;
}

function bot_can_switch_to_defender() {
  if(isDefined(level.bot_gametype_allowed_to_switch_to_defender)) {
    return self[[level.bot_gametype_allowed_to_switch_to_defender]]();
  }

  return 1;
}

function bot_verify_and_cache_bombzones(var_d36a7e987347e24d) {
  var_99e49ced1b12ab57 = 0;

  foreach(bombzone in level.objectives) {
    wait_time = 1;

    if(gettime() < 5000) {
      wait_time = max(1, 5 - gettime() / 1000);
    }

    if(!isDefined(bombzone.objectivekey) || !array_contains(var_d36a7e987347e24d, bombzone.objectivekey)) {
      wait wait_time;
      msg = "<dev string:x211>";

      foreach(objectivekey in var_d36a7e987347e24d) {
        msg += "<dev string:x242>" + objectivekey + "<dev string:x248>";
      }

      assertmsg(msg);
      return false;
    }

    if(bombzone.bottargets.size < 3) {
      wait wait_time;
      assertmsg("<dev string:x24d>" + bombzone.objectivekey + "<dev string:x25b>" + bombzone.curorigin + "<dev string:x26d>");

      if(bombzone.bottargets.size < 1) {
        var_99e49ced1b12ab57 = 1;
      }
    }
  }

  if(!var_99e49ced1b12ab57) {
    bot_cache_entrances_to_bombzones();
  }

  return !var_99e49ced1b12ab57;
}

function bot_get_valid_nodes_in_trigger(trigger) {
  nodes = getnodesintrigger(trigger, 1);
  valid_nodes = [];

  foreach(node in nodes) {
    if(!node nodeisdisconnected() && !isnode3d(node) && node.type != "Begin" && node.type != "End") {
      valid_nodes[valid_nodes.size] = node;
    }
  }

  return valid_nodes;
}

function bot_cache_entrances_to_zones(zones) {
  entrance_origin_points = [];
  var_31ac0f14318b785f = [];
  global_index = 0;

  foreach(zone in zones) {
    var_19cf496cab075bec = 0;
    zone.entrance_indices = [];
    zone.zone_bounds = calculate_zone_node_extents(zone);
    zone.center_node = zone_get_node_nearest_2d_bounds(zone, 0, 0);
    combinations = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];

    foreach(bound in combinations) {
      node = zone_get_node_nearest_2d_bounds(zone, bound[0], bound[1]);
      entrance_origin_points[global_index] = node.origin;
      var_1d52185a4e4dee51 = zone.objectivekey + "_" + var_19cf496cab075bec;
      var_31ac0f14318b785f[global_index] = var_1d52185a4e4dee51;
      zone.entrance_indices[zone.entrance_indices.size] = var_1d52185a4e4dee51;
      global_index++;
      var_19cf496cab075bec++;
    }
  }

  bot_cache_entrances(entrance_origin_points, var_31ac0f14318b785f, 1);
}

function calculate_zone_node_extents(zone) {
  assert(isDefined(zone.nodes));
  bounds = spawnStruct();
  bounds.min_pt = (999999, 999999, 999999);
  bounds.max_pt = (-999999, -999999, -999999);

  foreach(node in zone.nodes) {
    bounds.min_pt = (min(node.origin[0], bounds.min_pt[0]), min(node.origin[1], bounds.min_pt[1]), min(node.origin[2], bounds.min_pt[2]));
    bounds.max_pt = (max(node.origin[0], bounds.max_pt[0]), max(node.origin[1], bounds.max_pt[1]), max(node.origin[2], bounds.max_pt[2]));
  }

  bounds.center = ((bounds.min_pt[0] + bounds.max_pt[0]) / 2, (bounds.min_pt[1] + bounds.max_pt[1]) / 2, (bounds.min_pt[2] + bounds.max_pt[2]) / 2);
  bounds.half_size = (bounds.max_pt[0] - bounds.center[0], bounds.max_pt[1] - bounds.center[1], bounds.max_pt[2] - bounds.center[2]);
  bounds.radius = max(bounds.half_size[0], bounds.half_size[1]);
  return bounds;
}

function zone_get_node_nearest_2d_bounds(zone, var_d83e63db6c0197b6, var_3653eb9930616b55) {
  assert(var_d83e63db6c0197b6 >= -1 && var_d83e63db6c0197b6 <= 1);
  assert(var_3653eb9930616b55 >= -1 && var_3653eb9930616b55 <= 1);
  bounds_point = (zone.zone_bounds.center[0] + var_d83e63db6c0197b6 * zone.zone_bounds.half_size[0], zone.zone_bounds.center[1] + var_3653eb9930616b55 * zone.zone_bounds.half_size[1], 0);
  closest_node = undefined;
  closest_dist_sq = 9999999;

  foreach(node in zone.nodes) {
    dist_sq = distance2dsquared(node.origin, bounds_point);

    if(dist_sq < closest_dist_sq) {
      closest_dist_sq = dist_sq;
      closest_node = node;
    }
  }

  assert(isDefined(closest_node));
  return closest_node;
}

function monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");

  if(getdvarint(@ "hash_a4149c16169203e5", 0) != 0) {
    return;
  }

  objectiveorigin = self.origin;

  if(!isDefined(objectiveorigin)) {
    objectiveorigin = self.curorigin;
  }

  zone = getzonenearest(objectiveorigin);
  assertex(isDefined(zone), "<dev string:x2a1>" + objectiveorigin + "<dev string:x2b4>");

  for(;;) {
    team = "none";

    if(isDefined(self.gameobject)) {
      team = self.gameobject scripts\mp\gameobjects::getownerteam();
    }

    if(team == "neutral" || team == "none") {
      botzonesetteam(zone, "free");
    } else {
      botzonesetteam(zone, team);
    }

    wait 1;
  }
}

function monitor_bombzone_control() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  zone = getzonenearest(self.curorigin);

  if(!isDefined(zone)) {
    assertmsg("<dev string:x2d2>" + self.curorigin + "<dev string:x2b4>");
    return;
  }

  for(;;) {
    if(self.bombplanted) {
      zoneteam = get_enemy_team(self.ownerteam);
    } else {
      zoneteam = self.ownerteam;
    }

    if(zoneteam == "neutral" || zoneteam == "any") {
      zoneteam = "free";
    }

    botzonesetteam(zone, zoneteam);
    wait 1;
  }
}

function find_closest_bombzone_to_player(player) {
  closest_zone = undefined;
  var_f2194e18677893c8 = 999999999;

  foreach(zone in level.objectives) {
    distsq = distancesquared(zone.curorigin, player.origin);

    if(distsq < var_f2194e18677893c8) {
      closest_zone = zone;
      var_f2194e18677893c8 = distsq;
    }
  }

  return closest_zone;
}

function get_living_players_on_team(team, var_11739f6565c4bf01) {
  players = [];

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }

    if(isreallyalive(player) && isteamparticipant(player) && player.team == team) {
      if(!isDefined(var_11739f6565c4bf01) || var_11739f6565c4bf01 && isai(player) && isDefined(player.role)) {
        players[players.size] = player;
      }
    }
  }

  return players;
}

function get_bombzone_node_to_plant_on(bombzone, var_5a63f206b448f5bd) {
  if(bombzone.bottargets.size >= 2) {
    if(var_5a63f206b448f5bd) {
      var_dd2a0954ea29ea00 = self botnodescoremultiple(bombzone.bottargets, "node_exposed");
    } else {
      var_dd2a0954ea29ea00 = self botnodescoremultiple(bombzone.bottargets, "node_hide_anywhere", "ignore_occupancy");
    }

    var_e721ddcd54f8465 = self botgetdifficultysetting("strategyLevel") * 0.3;
    var_4cbe365d7f1699ea = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    var_82d7851272ca820d = array_randomize(bombzone.bottargets);

    foreach(node in var_82d7851272ca820d) {
      if(!array_contains(var_dd2a0954ea29ea00, node)) {
        var_dd2a0954ea29ea00[var_dd2a0954ea29ea00.size] = node;
      }
    }

    assert(var_dd2a0954ea29ea00.size >= 2);

    if(randomfloat(1) < var_e721ddcd54f8465) {
      return var_dd2a0954ea29ea00[0];
    } else if(randomfloat(1) < var_4cbe365d7f1699ea) {
      return var_dd2a0954ea29ea00[1];
    } else {
      return random(var_dd2a0954ea29ea00);
    }

    return;
  }

  assert(bombzone.bottargets.size == 1);
  return bombzone.bottargets[0];
}

function get_bombzone_node_to_defuse_on(bombzone) {
  if(bombzone.bottargets.size >= 2) {
    var_dd2a0954ea29ea00 = self botnodescoremultiple(bombzone.bottargets, "node_hide_anywhere", "ignore_occupancy");
    var_199a6276b58ce0e0 = self botgetdifficultysetting("strategyLevel") * 0.3;
    var_fabe802612d28c15 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    var_82d7851272ca820d = array_randomize(bombzone.bottargets);

    foreach(node in var_82d7851272ca820d) {
      if(!array_contains(var_dd2a0954ea29ea00, node)) {
        var_dd2a0954ea29ea00[var_dd2a0954ea29ea00.size] = node;
      }
    }

    assert(var_dd2a0954ea29ea00.size >= 2);

    if(randomfloat(1) < var_199a6276b58ce0e0) {
      return var_dd2a0954ea29ea00[0];
    } else if(randomfloat(1) < var_fabe802612d28c15) {
      return var_dd2a0954ea29ea00[1];
    } else {
      return random(var_dd2a0954ea29ea00);
    }

    return;
  }

  assert(bombzone.bottargets.size == 1);
  return bombzone.bottargets[0];
}

function bombzone_press_use(time, var_206bf0ac411b2257, var_5b45d81d67839650, dont_prone) {
  var_8e7073e75873765a = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_8e7073e75873765a = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_8e7073e75873765a = 80;
  }

  if(randomint(100) < var_8e7073e75873765a && !(isDefined(dont_prone) && dont_prone)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var_5b45d81d67839650) {
    childthread notify_planter_on_whizby();
    childthread notify_planter_on_damage();
  }

  self botpressbutton("use", time);
  result = bot_usebutton_wait(time, var_206bf0ac411b2257, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  succeeded = result == var_206bf0ac411b2257;
  return succeeded;
}

function notify_planter_on_whizby() {
  self endon("stop_usebutton_watcher");
  this_bombzone = find_closest_bombzone_to_player(self);
  self waittill("bulletwhizby", shooter);

  if(!isDefined(shooter.team) || shooter.team != self.team) {
    time_left = this_bombzone.usetime - this_bombzone.curprogress;

    if(time_left > 1000) {
      self notify("use_interrupted");
    }
  }
}

function notify_planter_on_damage() {
  self endon("stop_usebutton_watcher");
  self waittill("damage", amount, attacker);

  if(!isDefined(attacker.team) || attacker.team != self.team) {
    self notify("use_interrupted");
  }
}

function get_ai_hearing_bomb_plant_sound(type) {
  assert(isDefined(level.silentplant));
  var_c4c04e5085782b42 = [];

  if(!istrue(level.silentplant)) {
    players = get_living_players_on_team(get_enemy_team(self.team));

    foreach(player in players) {
      if(!isai(player)) {
        continue;
      }

      var_7609e1675a1f5bb8 = 0;

      if(type == "plant") {
        var_7609e1675a1f5bb8 = 300 + player botgetdifficultysetting("strategyLevel") * 100;
      } else if(type == "defuse") {
        var_7609e1675a1f5bb8 = 500 + player botgetdifficultysetting("strategyLevel") * 500;
      }

      if(distancesquared(player.origin, self.origin) < squared(var_7609e1675a1f5bb8)) {
        var_c4c04e5085782b42[var_c4c04e5085782b42.size] = player;
      }
    }
  }

  return var_c4c04e5085782b42;
}

function function_6cffc65203b4d521() {
  while(!isDefined(level.bot_set_objective_bottargets)) {
    wait 0.05;
  }

  while(true) {
    if(getdvarint(@ "hash_9cac85d6351e1df") == 1) {
      zones = level.objectives;

      if(isDefined(level.extra_bomb_zones)) {
        zones = array_combine(zones, level.extra_bomb_zones);
      }

      foreach(bombzone in zones) {
        foreach(node in bombzone.bottargets) {
          bot_draw_cylinder(node.origin, 8, 10, 0.05, undefined, (0, 1, 0), 1, 4);
        }
      }
    }

    wait 0.05;
  }
}

function function_7b6b2ac24a72824a() {
  return level.objectives;
}

function function_bdf33f81ff7efcf8() {
  return level.zone.trigger;
}

function function_63289ab47f52d209() {
  zone_array = function_7b6b2ac24a72824a();

  if(!isDefined(zone_array)) {
    wait 0.05;
  }

  foreach(zone in zone_array) {
    botdebugdrawtrigger(0, zone.trigger);
  }

  while(!isDefined(level.bot_set_zone_nodes)) {
    wait 0.05;
  }

  was_on = 0;

  while(true) {
    zone_array = function_7b6b2ac24a72824a();
    var_e6891b2d7b582e19 = function_bdf33f81ff7efcf8();

    if(getdvarint(@ "hash_9cac85d6351e1df") == 1) {
      setdevdvarifuninitialized(@ "hash_c08da04217f1024b", -1);
      was_on = 1;

      foreach(index, zone in zone_array) {
        var_c828eb1c0a63faf = getdvarint(@ "hash_c08da04217f1024b", -1);

        if(var_c828eb1c0a63faf >= zone_array.size) {
          setDvar(@ "hash_c08da04217f1024b", zone_array.size - 1);
        }

        if(var_c828eb1c0a63faf >= 0) {
          if(index != var_c828eb1c0a63faf) {
            botdebugdrawtrigger(0, zone.trigger);
            continue;
          }
        }

        color = (0, 1, 0);

        if(isDefined(var_e6891b2d7b582e19) && zone.trigger == var_e6891b2d7b582e19) {
          color = (1, 0, 0);
        }

        if(isDefined(zone.trigger.trigger_off) && zone.trigger.trigger_off) {
          zone.trigger trigger_on();
        }

        if(zone.trigger.classname == "<dev string:x2ea>") {
          bot_draw_cylinder(zone.trigger.origin, zone.trigger.radius, zone.trigger.height, 0.05, undefined, color, 1);
        } else {
          botdebugdrawtrigger(1, zone.trigger, color, 1);
        }

        foreach(node in zone.nodes) {
          bot_draw_cylinder(node.origin, 10, 10, 0.05, undefined, color, 1, 4);
        }
      }
    } else if(was_on) {
      was_on = 0;

      foreach(zone in zone_array) {
        botdebugdrawtrigger(0, zone.trigger);
      }
    }

    wait 0.05;
  }
}

# /