/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_hp.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_gametype_common;

main() {
  setup_callbacks();
  setup_bot_hp();

  thread bot_hp_debug();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_hp_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_hp;
}

setup_bot_hp() {
  bot_waittill_bots_enabled();

  for(i = 0; i < level.all_hp_zones.size; i++) {
    zone = level.all_hp_zones[i];
    zone.script_label = "zone_" + i;
    zone thread monitor_zone_control();

    was_off = false;
    if(isDefined(zone.trig.trigger_off) && zone.trig.trigger_off) {
      zone.trig trigger_on();
      was_off = true;
    }

    zone.nodes = GetNodesInTrigger(zone.trig);

    bot_add_missing_nodes(zone, zone.trig);

    if(was_off) {
      zone.trig trigger_off();
    }

    if(zone.nodes.size < 3) {
      wait(5);
      assertmsg("Zone " + i + " at location " + zone.origin + " needs at least 3 nodes in its trigger_multiple");
      return;
    }
  }

  bot_cache_entrances_to_hardpoints(true);

  level.bot_hp_allow_predictive_capping = true;

  level.bot_gametype_precaching_done = true;

  thread bot_cache_entrances_to_hardpoints(false);
}

bot_cache_entrances_to_hardpoints(only_initial_active_zone) {
  entrance_origin_points = [];
  entrance_labels = [];
  global_index = 0;

  foreach(zone in level.all_hp_zones) {
    if((only_initial_active_zone && zone != level.zone) || (!only_initial_active_zone && zone == level.zone)) {
      continue;
    }

    per_zone_index = 0;
    zone.entrance_indices = [];
    zone.zone_bounds = calculate_zone_node_extents(zone);
    zone.center_node = zone_get_node_nearest_2d_bounds(zone, 0, 0);

    combinations = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];
    foreach(bound in combinations) {
      node = zone_get_node_nearest_2d_bounds(zone, bound[0], bound[1]);
      entrance_origin_points[global_index] = node.origin;
      label_for_entrance_and_zone = zone.script_label + "_" + per_zone_index;
      entrance_labels[global_index] = label_for_entrance_and_zone;
      zone.entrance_indices[zone.entrance_indices.size] = label_for_entrance_and_zone;
      global_index++;
      per_zone_index++;
    }
  }

  bot_cache_entrances(entrance_origin_points, entrance_labels, true);
}

calculate_zone_node_extents(zone) {
  Assert(isDefined(zone.nodes));

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

zone_get_node_nearest_2d_bounds(zone, bounds_x_desired, bounds_y_desired) {
  Assert(bounds_x_desired >= -1 && bounds_x_desired <= 1);
  Assert(bounds_y_desired >= -1 && bounds_y_desired <= 1);

  bounds_point = (zone.zone_bounds.center[0] + bounds_x_desired * zone.zone_bounds.half_size[0], zone.zone_bounds.center[1] + bounds_y_desired * zone.zone_bounds.half_size[1], 0);

  closest_node = undefined;
  closest_dist_sq = 9999999;
  foreach(node in zone.nodes) {
    dist_sq = Distance2DSquared(node.origin, bounds_point);
    if(dist_sq < closest_dist_sq) {
      closest_dist_sq = dist_sq;
      closest_node = node;
    }
  }

  Assert(isDefined(closest_node));
  return closest_node;
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    team = self.gameobject maps\mp\gametypes\_gameobjects::getOwnerTeam();
    if(team != "neutral" && team != "none") {
      zone = GetZoneNearest(self.origin);
      if(isDefined(zone)) {
        BotZoneSetTeam(zone, team);
      }
    }

    wait(1.0);
  }
}

bot_hp_debug() {
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  was_on = false;
  while(1) {
    if(GetDvarInt("bot_DrawDebugGametype") == 1) {
      was_on = true;
      foreach(zone in level.zones) {
        color = (0, 1, 0);
        if(zone == level.zone) {
          color = (1, 0, 0);
        }

        if(isDefined(zone.trig.trigger_off) && zone.trig.trigger_off) {
          zone.trig trigger_on();
        }

        if(zone.trig.classname == "trigger_radius") {
          bot_draw_cylinder(zone.trig.origin, zone.trig.radius, zone.trig.height, 0.05, undefined, color, true);
        } else {
          BotDebugDrawTrigger(true, zone.trig, color, true);
        }

        foreach(node in zone.nodes) {
          bot_draw_cylinder(node.origin, 10, 10, 0.05, undefined, color, true, 4);
        }
      }
    } else if(was_on) {
      was_on = false;
      foreach(zone in level.zones) {
        BotDebugDrawTrigger(false, zone.trig);
      }
    }

    wait(0.05);
  }
}

bot_hp_think() {
  self notify("bot_hp_think");
  self endon("bot_hp_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self BotSetFlag("separation", 0);
  self BotSetFlag("grenade_objectives", 1);

  should_force_capture_next_zone = undefined;
  last_recorded_zone = level.zone;

  while(true) {
    wait(0.05);

    if(self.health <= 0) {
      continue;
    }

    if(last_recorded_zone != level.zone) {
      should_force_capture_next_zone = undefined;
      last_recorded_zone = level.zone;
    }

    if(!isDefined(should_force_capture_next_zone) && level.randomZoneSpawn == 0 && level.bot_hp_allow_predictive_capping) {
      time_till_zone_change = level.zoneMoveTime - GetTime();
      if(time_till_zone_change > 0 && time_till_zone_change < 10000) {
        my_team_owns_zone = level.zone.gameobject maps\mp\gametypes\_gameobjects::getOwnerTeam() == self.team;
        if(!my_team_owns_zone) {
          dist_to_keep_trying_to_capture_cur_zone = level.zone.zone_bounds.radius * 6;
          if(time_till_zone_change < 5000) {
            dist_to_keep_trying_to_capture_cur_zone = level.zone.zone_bounds.radius * 3;
          }

          dist_to_cur_zone = Distance(level.zone.zone_bounds.center, self.origin);
          if(dist_to_cur_zone > dist_to_keep_trying_to_capture_cur_zone) {
            should_force_capture_next_zone = bot_should_cap_next_zone();
          }
        } else {
          team_limit = bot_get_max_players_on_team(self.team);
          num_bots_allowed_to_stay_at_zone = ceil(team_limit / 2);
          if(time_till_zone_change < 5000) {
            num_bots_allowed_to_stay_at_zone = ceil(team_limit / 3);
          }

          num_bots_currently_at_zone = bot_get_num_teammates_capturing_zone(level.zone);
          if(num_bots_currently_at_zone + 1 > num_bots_allowed_to_stay_at_zone) {
            should_force_capture_next_zone = bot_should_cap_next_zone();
          }
        }
      }
    }

    zone_to_capture = level.zone;
    if(isDefined(should_force_capture_next_zone) && should_force_capture_next_zone) {
      zone_to_capture = level.zones[(level.prevZoneIndex + 1) % level.zones.size];
    }

    if(!self bot_is_capturing_zone(zone_to_capture)) {
      self bot_capture_hp_zone(zone_to_capture);
    }
  }
}

bot_should_cap_next_zone() {
  if(level.randomZoneSpawn) {
    return false;
  } else {
    strategy_level = self BotGetDifficultySetting("strategyLevel");
    chance_to_cap_next_zone = 0;
    if(strategy_level == 1) {
      chance_to_cap_next_zone = 0.1;
    } else if(strategy_level == 2) {
      chance_to_cap_next_zone = 0.5;
    } else if(strategy_level == 3) {
      chance_to_cap_next_zone = 0.8;
    }
    return RandomFloat(1.0) < chance_to_cap_next_zone;
  }
}

bot_get_num_teammates_capturing_zone(zone) {
  return (self bot_get_teammates_capturing_zone(zone)).size;
}

bot_get_teammates_capturing_zone(zone) {
  teammates_capturing_zone = [];

  foreach(other_player in level.participants) {
    if(other_player != self && IsTeamParticipant(other_player) && IsAlliedSentient(self, other_player)) {
      if(other_player IsTouching(level.zone.trig)) {
        if(!IsAI(other_player) || other_player bot_is_capturing_zone(zone)) {
          teammates_capturing_zone[teammates_capturing_zone.size] = other_player;
        }
      }
    }
  }

  return teammates_capturing_zone;
}

bot_is_capturing_zone(zone) {
  if(!self bot_is_capturing()) {
    return false;
  }

  return (self.current_zone == zone);
}

bot_capture_hp_zone(zone) {
  self.current_zone = zone;

  optional_params["entrance_points_index"] = zone.entrance_indices;
  optional_params["override_origin_node"] = zone.center_node;
  self bot_capture_zone(zone.origin, zone.nodes, zone.trig, optional_params);
}

should_start_cautious_approach_hp(firstCheck) {
  if(firstCheck) {
    team = level.zone.gameobject maps\mp\gametypes\_gameobjects::getOwnerTeam();
    if(team == "neutral" || team == self.team) {
      return false;
    }
  }

  return should_start_cautious_approach_default(firstCheck);
}