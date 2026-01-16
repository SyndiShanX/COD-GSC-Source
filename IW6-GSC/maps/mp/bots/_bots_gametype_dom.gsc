/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_dom.gsc
***********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;

main() {
  setup_callbacks();
  setup_bot_dom();

  level thread bot_monitor_enemy_camp_spots(::bot_valid_camp_assassin);

  thread bot_dom_debug();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_dom_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_dom;
  level.bot_funcs["leader_dialog"] = ::bot_dom_leader_dialog;
  level.bot_funcs["get_watch_node_chance"] = ::bot_dom_get_node_chance;
  level.bot_funcs["commander_gametype_tactics"] = ::bot_dom_apply_commander_tactics;
}

bot_is_assigned_location(origin) {
  distCheckSq = (300 * 300);

  if((self bot_is_defending()) && Distance2DSquared(origin, self.bot_defending_center) < distCheckSq)
    return true;

  if(self BotHasScriptGoal()) {
    scriptGoalOrigin = self BotGetScriptGoal();
    if(Distance2DSquared(origin, scriptGoalOrigin) < distCheckSq)
      return true;
  }

  return false;
}

crate_can_use_smartglass(crate) {
  if(IsAgent(self)) {
    if(!isDefined(level.smartglass_commander) || (self.owner != level.smartglass_commander))
      return crate_can_use();

    if(!isDefined(crate.boxType) && bot_crate_is_command_goal(crate))
      return self bot_is_assigned_location(crate.origin);

    return false;
  }

  return crate_can_use(crate);
}

crate_can_use(crate) {
  if(IsAgent(self) && !isDefined(crate.boxType))
    return false;

  if(!IsTeamParticipant(self))
    return true;

  return (self bot_is_protecting());
}

bot_dom_debug() {
  while(!isDefined(level.bot_gametype_precaching_done))
    wait(0.05);

  while(1) {
    if(GetDvar("bot_DrawDebugGametype") == "dom") {
      flags = bot_get_all_possible_flags();
      foreach(flag in flags) {
        if(flag.classname != "trigger_radius")
          BotDebugDrawTrigger(true, flag, (0, 1, 0), true);
        else
          bot_draw_cylinder(flag.origin, flag.radius, flag.height, 0.05, undefined, (0, 1, 0), true);

        foreach(node in flag.nodes)
        bot_draw_cylinder(node.origin, 10, 10, 0.05, undefined, (0, 1, 0), true, 4);
      }
    }

    wait(0.05);
  }
}

bot_dom_apply_commander_tactics(new_tactic) {
  reset_all_bots = false;
  switch (new_tactic) {
    case "tactic_none":
      level.bot_dom_override_flag_targets[self.team] = [];
      reset_all_bots = true;
      break;
    case "tactic_dom_holdA":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      reset_all_bots = true;
      break;
    case "tactic_dom_holdB":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("B");
      reset_all_bots = true;
      break;
    case "tactic_dom_holdC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("C");
      reset_all_bots = true;
      break;
    case "tactic_dom_holdAB":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("B");
      reset_all_bots = true;
      break;
    case "tactic_dom_holdBC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("B");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("C");
      reset_all_bots = true;
      break;
    case "tactic_dom_holdAC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("C");
      reset_all_bots = true;
      break;
    case "tactic_dom_holdABC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("B");
      level.bot_dom_override_flag_targets[self.team][2] = get_specific_flag("C");
      reset_all_bots = true;
      break;
  }

  if(reset_all_bots) {
    foreach(participant in level.participants) {
      if(!isDefined(participant.team)) {
        continue;
      }
      if(IsAITeamParticipant(participant) && participant.team == self.team)
        participant.force_new_goal = true;
    }
  }
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 1;
    team = self maps\mp\gametypes\dom::getFlagTeam();
    if(team != "neutral") {
      zone = GetZoneNearest(self.origin);
      if(isDefined(zone))
        BotZoneSetTeam(zone, team);
    }
  }
}

monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");

  prev_team = self maps\mp\gametypes\dom::getFlagTeam();
  for(;;) {
    current_team = self maps\mp\gametypes\dom::getFlagTeam();
    if(current_team != prev_team)
      level notify("flag_changed_ownership");
    prev_team = current_team;

    wait(0.05);
  }
}

setup_bot_dom() {
  SetDevDvarIfUninitialized("bot_dom_debug_capture_all", 0);
  SetDevDvarIfUninitialized("bot_dom_debug_protect_all", 0);

  flags = bot_get_all_possible_flags();
  if(flags.size > 3) {
    while(!isDefined(level.teleport_dom_finished_initializing))
      wait(0.05);

    Assert(flags.size % 3 == 0);
    flags_in_zone = [];
    foreach(flag in flags) {
      Assert(isDefined(flag.teleport_zone));
      if(!isDefined(flags_in_zone[flag.teleport_zone]))
        flags_in_zone[flag.teleport_zone] = [];

      flags_in_zone[flag.teleport_zone] = array_add(flags_in_zone[flag.teleport_zone], flag);
    }

    foreach(teleport_zone, teleport_zone_flag_set in flags_in_zone) {
      level.entrance_points_finished_caching = false;
      bot_cache_flag_distances(teleport_zone_flag_set);
      bot_cache_entrances_to_flags_or_radios(teleport_zone_flag_set, teleport_zone + "_flag");
    }
  } else {
    Assert(flags.size == 3);
    bot_cache_entrances_to_flags_or_radios(flags, "flag");
    bot_cache_flag_distances(flags);
  }

  foreach(flag in flags) {
    flag thread monitor_zone_control();
    flag thread monitor_flag_ownership();
    if(flag.script_label != "_a" && flag.script_label != "_b" && flag.script_label != "_c")
      assertmsg("Domination flag at location " + flag.origin + " needs a script_label of'_a''_b'or'_c'");
    flag.nodes = GetNodesInTrigger(flag);
    add_missing_nodes(flag);
  }

  level.bot_dom_override_flag_targets = [];
  level.bot_dom_override_flag_targets["axis"] = [];
  level.bot_dom_override_flag_targets["allies"] = [];

  level.bot_gametype_precaching_done = true;
}

bot_get_all_possible_flags() {
  if(isDefined(level.all_dom_flags))
    return level.all_dom_flags;
  else
    return level.flags;
}

bot_cache_flag_distances(flags) {
  if(!isDefined(level.flag_distances))
    level.flag_distances = [];

  for(i = 0; i < flags.size - 1; i++) {
    for(j = i + 1; j < flags.size; j++) {
      distance_i_to_j = Distance(flags[i].origin, flags[j].origin);
      i_label = get_flag_label(flags[i]);
      j_label = get_flag_label(flags[j]);
      level.flag_distances[i_label][j_label] = distance_i_to_j;
      level.flag_distances[j_label][i_label] = distance_i_to_j;
    }
  }
}

add_missing_nodes(flag) {
  if(flag.classname == "trigger_radius") {
    test_nodes_in_radius = GetNodesInRadius(flag.origin, flag.radius, 0, 100);
    nodes_in_radius_not_in_volume = array_remove_array(test_nodes_in_radius, flag.nodes);
    if(nodes_in_radius_not_in_volume.size > 0)
      flag.nodes = array_combine(flag.nodes, nodes_in_radius_not_in_volume);
  } else if(flag.classname == "trigger_multiple") {
    bound_points[0] = flag GetPointInBounds(1, 1, 1);
    bound_points[1] = flag GetPointInBounds(1, 1, -1);
    bound_points[2] = flag GetPointInBounds(1, -1, 1);
    bound_points[3] = flag GetPointInBounds(1, -1, -1);
    bound_points[4] = flag GetPointInBounds(-1, 1, 1);
    bound_points[5] = flag GetPointInBounds(-1, 1, -1);
    bound_points[6] = flag GetPointInBounds(-1, -1, 1);
    bound_points[7] = flag GetPointInBounds(-1, -1, -1);

    farthest_dist = 0;
    foreach(point in bound_points) {
      dist = Distance(point, flag.origin);
      if(dist > farthest_dist)
        farthest_dist = dist;
    }

    test_nodes_in_radius = GetNodesInRadius(flag.origin, farthest_dist, 0, 100);
    foreach(node in test_nodes_in_radius) {
      if(!IsPointInVolume(node.origin, flag)) {
        if(IsPointInVolume(node.origin + (0, 0, 40), flag) || IsPointInVolume(node.origin + (0, 0, 80), flag) || IsPointInVolume(node.origin + (0, 0, 120), flag)) {
          flag.nodes = array_add(flag.nodes, node);
        }
      }
    }
  }
}

should_start_cautious_approach_dom(firstCheck) {
  if(firstCheck) {
    if(self.current_flag maps\mp\gametypes\dom::getFlagTeam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      my_spawn_flag = get_closest_flag(self.lastspawnpoint.origin);
      if(my_spawn_flag == self.current_flag) {
        return false;
      } else {
        enemy_spawn_flag = get_other_flag(my_spawn_flag, self.current_flag);
        dist_my_spawn_to_target_sq = DistanceSquared(my_spawn_flag.origin, self.current_flag.origin);
        dist_enemy_spawn_to_target_sq = DistanceSquared(enemy_spawn_flag.origin, self.current_flag.origin);

        if(dist_my_spawn_to_target_sq < dist_enemy_spawn_to_target_sq)
          return false;
      }
    }
  }

  return should_start_cautious_approach_default(firstCheck);
}

bot_dom_debug_should_capture_all() {
  if(GetDvar("bot_dom_debug_capture_all") == "1")
    return true;

  return false;
}

bot_dom_debug_should_protect_all() {
  if(GetDvar("bot_dom_debug_protect_all") == "1")
    return true;

  return false;
}

bot_dom_think() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait(0.05);

  self.force_new_goal = false;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self BotSetFlag("separation", 0);
  self BotSetFlag("grenade_objectives", 1);
  self BotSetFlag("use_obj_path_style", true);

  for(;;) {
    self bot_update_camp_assassin();

    cur_time = GetTime();
    if(cur_time > self.next_strat_level_check) {
      self.next_strat_level_check = GetTime() + 10000;
      self.strategy_level = self BotGetDifficultySetting("strategyLevel");
    }

    if(cur_time > self.new_goal_time || self.force_new_goal) {
      if(self should_delay_flag_decision()) {
        self.new_goal_time = cur_time + 5000;
      } else {
        self.force_new_goal = false;
        self bot_choose_flag();
        self.new_goal_time = cur_time + RandomIntRange(30000, 45000);
      }
    }

    waittill_notify_or_timeout("needs_new_flag_goal", 1.0);
  }
}

should_delay_flag_decision() {
  if(self.force_new_goal)
    return false;

  if(!self bot_is_capturing())
    return false;

  if(self.current_flag maps\mp\gametypes\dom::getFlagTeam() == self.team)
    return false;

  flag_capture_radius = get_flag_capture_radius();
  if(DistanceSquared(self.origin, self.current_flag.origin) < (flag_capture_radius * 2) * (flag_capture_radius * 2)) {
    ally_flags = get_ally_flags(self.team);
    if(ally_flags.size == 2 && !array_contains(ally_flags, self.current_flag) && !self bot_allowed_to_3_cap())
      return false;

    return true;
  }

  return false;
}

get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

has_override_flag_targets() {
  override_targets = self get_override_flag_targets();
  return (override_targets.size > 0);
}

flag_has_been_captured_before(flag) {
  return !flag_has_never_been_captured(flag);
}

flag_has_never_been_captured(flag) {
  return flag.useObj.firstCapture;
}

bot_choose_flag() {
  flag = undefined;
  flags_to_take = [];
  flags_to_defend = [];
  no_flags_captured_yet = true;

  override_targets = self get_override_flag_targets();
  if(override_targets.size > 0)
    all_possible_flags = override_targets;
  else
    all_possible_flags = level.flags;

  for(i = 0; i < all_possible_flags.size; i++) {
    team = all_possible_flags[i] maps\mp\gametypes\dom::getFlagTeam();

    if(no_flags_captured_yet) {
      if(flag_has_been_captured_before(all_possible_flags[i]))
        no_flags_captured_yet = false;
      else
        Assert(team == "neutral");
    }

    if(team != self.team)
      flags_to_take[flags_to_take.size] = all_possible_flags[i];
    else
      flags_to_defend[flags_to_defend.size] = all_possible_flags[i];
  }
  assert(self has_override_flag_targets() || (flags_to_take.size + flags_to_defend.size == 3));

  attacking = undefined;
  if(flags_to_take.size == 3) {
    assert(flags_to_defend.size == 0);

    attacking = true;
  } else if(flags_to_take.size == 2) {
    assert(flags_to_defend.size <= 1);

    if(flags_to_defend.size == 1) {
      if(!self bot_should_defend_flag(flags_to_defend[0], 1)) {
        attacking = true;
      } else {
        attacking = !self bot_should_defend(0.34);
      }
    } else if(flags_to_defend.size == 0) {
      attacking = true;
    }
  } else if(flags_to_take.size == 1) {
    assert(flags_to_defend.size <= 2);

    if(flags_to_defend.size == 2) {
      if(self bot_allowed_to_3_cap()) {
        if(!self bot_should_defend_flag(flags_to_defend[0], 2) && !self bot_should_defend_flag(flags_to_defend[1], 2)) {
          attacking = true;
        } else {
          if(self.strategy_level == 0) {
            attacking = !self bot_should_defend(0.34);
          } else {
            attacking = !self bot_should_defend(0.50);
          }
        }
      } else {
        attacking = false;
      }
    } else if(flags_to_defend.size == 1) {
      if(!self bot_should_defend_flag(flags_to_defend[0], 1)) {
        attacking = true;
      } else {
        attacking = !self bot_should_defend(0.34);
      }
    } else if(flags_to_defend.size == 0) {
      attacking = true;
    }
  } else if(flags_to_take.size == 0) {
    assert(flags_to_defend.size <= 3);

    attacking = false;
  }

  assert(isDefined(attacking));

  if(attacking) {
    assert(flags_to_take.size >= 1 && flags_to_take.size <= 3);

    if(flags_to_take.size > 1)
      flags_to_take_sorted = get_array_of_closest(self.origin, flags_to_take);
    else
      flags_to_take_sorted = flags_to_take;

    if(no_flags_captured_yet && !self has_override_flag_targets()) {
      Assert(flags_to_take_sorted.size == 3);

      allies_capturing_closest = self get_num_allies_capturing_flag(flags_to_take_sorted[0], true);
      if(allies_capturing_closest < 2) {
        flag_num = 0;
      } else {
        chance_to_take_closest = 20;
        chance_to_take_middle = 65;
        chance_to_take_farthest = 15;

        if(self.strategy_level == 0) {
          chance_to_take_closest = 50;
          chance_to_take_middle = 25;
          chance_to_take_farthest = 25;
        }

        random_roll = RandomInt(100);
        if(random_roll < chance_to_take_closest)
          flag_num = 0;
        else if(random_roll < chance_to_take_closest + chance_to_take_middle)
          flag_num = 1;
        else
          flag_num = 2;

      }

      goal_type = undefined;
      if(flag_num == 0)
        goal_type = "critical";

      self capture_flag(flags_to_take_sorted[flag_num], goal_type);
      return;
    }

    if(flags_to_take_sorted.size == 1) {
      flag = flags_to_take_sorted[0];
    } else {
      if(DistanceSquared(flags_to_take_sorted[0].origin, self.origin) < 320 * 320) {
        flag = flags_to_take_sorted[0];
      } else {
        Assert(flags_to_take_sorted.size >= 2 && flags_to_take_sorted.size <= 3);

        flag_combined_dist = [];
        dist_to_flags_to_take_sorted = [];
        for(i = 0; i < flags_to_take_sorted.size; i++) {
          dist = Distance(flags_to_take_sorted[i].origin, self.origin);
          dist_to_flags_to_take_sorted[i] = dist;
          flag_combined_dist[i] = dist;
        }

        if(flags_to_defend.size == 1) {
          weight_close_to_flag = 1.5;
          for(i = 0; i < flag_combined_dist.size; i++)
            flag_combined_dist[i] += (level.flag_distances[get_flag_label(flags_to_take_sorted[i])][get_flag_label(flags_to_defend[0])] * weight_close_to_flag);
        }

        if(self.strategy_level == 0) {
          random_roll = RandomInt(100);
          if(random_roll < 50) {
            flag = flags_to_take_sorted[0];
          } else {
            if(random_roll < 50 + (50 / (flags_to_take_sorted.size - 1)))
              flag = flags_to_take_sorted[1];
            else
              flag = flags_to_take_sorted[2];
          }
        } else if(flag_combined_dist.size == 2) {
          chance_to_take_flag[0] = 50;
          chance_to_take_flag[1] = 50;

          for(i = 0; i < flags_to_take_sorted.size; i++) {
            if(flag_combined_dist[i] < flag_combined_dist[1 - i]) {
              chance_to_take_flag[i] += 20;
              chance_to_take_flag[1 - i] -= 20;
            }

            if(dist_to_flags_to_take_sorted[i] < 640) {
              chance_to_take_flag[i] += 15;
              chance_to_take_flag[1 - i] -= 15;
            }

            if(flags_to_take_sorted[i] maps\mp\gametypes\dom::getFlagTeam() == "neutral") {
              chance_to_take_flag[i] += 15;
              chance_to_take_flag[1 - i] -= 15;
            }
          }

          random_roll = RandomInt(100);
          if(random_roll < chance_to_take_flag[0])
            flag = flags_to_take_sorted[0];
          else
            flag = flags_to_take_sorted[1];
        } else if(flag_combined_dist.size == 3) {
          chance_to_take_flag[0] = 34;
          chance_to_take_flag[1] = 33;
          chance_to_take_flag[2] = 33;

          for(i = 0; i < flags_to_take_sorted.size; i++) {
            other_index_1 = (i + 1) % 3;
            other_index_2 = (i + 2) % 3;
            if(flag_combined_dist[i] < flag_combined_dist[other_index_1] && flag_combined_dist[i] < flag_combined_dist[other_index_2]) {
              chance_to_take_flag[i] += 36;
              chance_to_take_flag[other_index_1] -= 18;
              chance_to_take_flag[other_index_2] -= 18;
            }

            if(dist_to_flags_to_take_sorted[i] < 640) {
              chance_to_take_flag[i] += 15;
              chance_to_take_flag[other_index_1] -= 7;
              chance_to_take_flag[other_index_2] -= 8;
            }

            if(flags_to_take_sorted[i] maps\mp\gametypes\dom::getFlagTeam() == "neutral") {
              chance_to_take_flag[i] += 15;
              chance_to_take_flag[other_index_1] -= 7;
              chance_to_take_flag[other_index_2] -= 8;
            }
          }

          random_roll = RandomInt(100);
          if(random_roll < chance_to_take_flag[0])
            flag = flags_to_take_sorted[0];
          else if(random_roll < chance_to_take_flag[0] + chance_to_take_flag[1])
            flag = flags_to_take_sorted[1];
          else
            flag = flags_to_take_sorted[2];
        }
      }
    }
  } else {
    assert(flags_to_defend.size > 0);

    if(flags_to_defend.size > 1)
      flags_to_defend_sorted = get_array_of_closest(self.origin, flags_to_defend);
    else
      flags_to_defend_sorted = flags_to_defend;

    foreach(test_flag in flags_to_defend_sorted) {
      if(self bot_should_defend_flag(test_flag, flags_to_defend.size)) {
        flag = test_flag;
        break;
      }
    }

    if(!isDefined(flag)) {
      assert(flags_to_defend_sorted.size > 0);
      if(self.strategy_level == 0) {
        flag = flags_to_defend[0];
      } else if(flags_to_defend_sorted.size == 2) {
        third_flag = get_other_flag(flags_to_defend_sorted[0], flags_to_defend_sorted[1]);
        flags_to_defend_sorted_to_third_flag = get_array_of_closest(third_flag.origin, flags_to_defend_sorted);

        random_roll = RandomInt(100);
        if(random_roll < 70)
          flag = flags_to_defend_sorted_to_third_flag[0];
        else
          flag = flags_to_defend_sorted_to_third_flag[1];
      } else {
        assert(flags_to_defend_sorted.size == 1 || flags_to_defend_sorted.size == 3);

        flag = flags_to_defend_sorted[0];
      }
    }
  }

  if(attacking) {
    self capture_flag(flag);
  } else {
    self defend_flag(flag);
  }
}

bot_allowed_to_3_cap() {
  if(self.strategy_level == 0)
    return true;

  override_targets = self get_override_flag_targets();
  if(override_targets.size == 3)
    return true;

  enemy_score = maps\mp\gametypes\_gamescore::_getteamscore(get_enemy_team(self.team));
  my_score = maps\mp\gametypes\_gamescore::_getteamscore(self.team);

  enemy_team_score_needed_to_win = 200 - enemy_score;
  my_team_score_needed_to_win = 200 - my_score;

  need_three_flags_to_win = (my_team_score_needed_to_win * 0.5 > enemy_team_score_needed_to_win);
  return need_three_flags_to_win;
}

bot_should_defend(chance_to_override_personality_and_defend) {
  Assert(chance_to_override_personality_and_defend >= 0 && chance_to_override_personality_and_defend <= 1);
  if(RandomFloat(1) < chance_to_override_personality_and_defend)
    return true;

  personality_type = level.bot_personality_type[self.personality];
  if(personality_type == "stationary")
    return true;
  else if(personality_type == "active")
    return false;

  AssertMsg("unreachable");
}

capture_flag(flag_to_capture, override_goal_type, dont_monitor_status) {
  Assert(isDefined(flag_to_capture));
  self.current_flag = flag_to_capture;

  if(bot_dom_debug_should_protect_all()) {
    optional_params["override_goal_type"] = override_goal_type;
    optional_params["entrance_points_index"] = get_flag_label(flag_to_capture);
    self bot_protect_point(flag_to_capture.origin, get_flag_protect_radius(), optional_params);
  } else {
    optional_params["override_goal_type"] = override_goal_type;
    optional_params["entrance_points_index"] = get_flag_label(flag_to_capture);
    self bot_capture_zone(flag_to_capture.origin, flag_to_capture.nodes, flag_to_capture, optional_params);
  }

  if(!isDefined(dont_monitor_status) || !dont_monitor_status)
    self thread monitor_flag_status(flag_to_capture);
}

defend_flag(flag_to_defend) {
  Assert(isDefined(flag_to_defend));
  self.current_flag = flag_to_defend;

  if(bot_dom_debug_should_capture_all()) {
    optional_params["entrance_points_index"] = get_flag_label(flag_to_defend);
    self bot_capture_zone(flag_to_defend.origin, flag_to_defend.nodes, flag_to_defend, optional_params);
  } else {
    optional_params["entrance_points_index"] = get_flag_label(flag_to_defend);
    optional_params["nearest_node"] = flag_to_defend.nearest_node;
    self bot_protect_point(flag_to_defend.origin, get_flag_protect_radius(), optional_params);
  }

  self thread monitor_flag_status(flag_to_defend);
}

get_flag_capture_radius() {
  if(!isDefined(level.capture_radius)) {
    level.capture_radius = 158;
  }

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    worldBounds = self BotGetWorldSize();
    average_side = (worldBounds[0] + worldBounds[1]) / 2;
    level.protect_radius = min(1000, average_side / 3.5);
  }

  return level.protect_radius;
}

bot_dom_leader_dialog(dialog, location) {
  if(IsSubStr(dialog, "losing")) {
    flag_script_label = GetSubStr(dialog, dialog.size - 2);
    flag_losing = undefined;
    for(i = 0; i < level.flags.size; i++) {
      if(flag_script_label == level.flags[i].script_label) {
        flag_losing = level.flags[i];
      }
    }

    if(isDefined(flag_losing) && self bot_allow_to_capture_flag(flag_losing)) {
      self BotMemoryEvent("known_enemy", undefined, flag_losing.origin);

      if(!isDefined(self.last_losing_flag_react) || ((GetTime() - self.last_losing_flag_react) > 10000)) {
        if(self bot_is_protecting()) {
          if(DistanceSquared(self.origin, flag_losing.origin) < 700 * 700) {
            self capture_flag(flag_losing);
            self.last_losing_flag_react = GetTime();
          }
        }
      }
    }
  }

  bot_leader_dialog(dialog, location);
}

bot_allow_to_capture_flag(flag) {
  override_targets = self get_override_flag_targets();
  if(override_targets.size == 0)
    return true;

  if(array_contains(override_targets, flag))
    return true;

  return false;
}

monitor_flag_status(flag) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  prev_num_ally_flags = get_num_ally_flags(self.team);
  capture_radius_SQ = get_flag_capture_radius() * get_flag_capture_radius();
  triple_capture_radius_SQ = (get_flag_capture_radius() * 3) * (get_flag_capture_radius() * 3);

  keep_monitoring = true;
  while(keep_monitoring) {
    needs_new_goal = false;
    current_flag_team = flag maps\mp\gametypes\dom::getFlagTeam();
    cur_num_ally_flags = get_num_ally_flags(self.team);
    enemy_flags = get_enemy_flags(self.team);

    if(self bot_is_capturing()) {
      if(current_flag_team == self.team && flag.useobj.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all())
          needs_new_goal = true;
      }

      if(cur_num_ally_flags == 2 && current_flag_team != self.team && !self bot_allowed_to_3_cap()) {
        if(DistanceSquared(self.origin, flag.origin) > capture_radius_SQ) {
          needs_new_goal = true;
        }
      }

      foreach(enemy_flag in enemy_flags) {
        if(enemy_flag != flag && self bot_allow_to_capture_flag(enemy_flag)) {
          if(DistanceSquared(self.origin, enemy_flag.origin) < triple_capture_radius_SQ) {
            needs_new_goal = true;
          }
        }
      }

      if(self IsTouching(flag) && flag.useObj.useRate <= 0) {
        if(self BotHasScriptGoal()) {
          script_goal = self BotGetScriptGoal();
          script_goal_radius = self BotGetScriptGoalRadius();
          if(DistanceSquared(self.origin, script_goal) < squared(script_goal_radius)) {
            nearest_node_bot = self GetNearestNode();
            if(isDefined(nearest_node_bot)) {
              seek_node_dest = undefined;
              foreach(defend_node in flag.nodes) {
                if(!NodesVisible(defend_node, nearest_node_bot)) {
                  seek_node_dest = defend_node.origin;
                  break;
                }
              }

              if(isDefined(seek_node_dest)) {
                self.defense_investigate_specific_point = seek_node_dest;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(self bot_is_protecting()) {
      if(current_flag_team != self.team) {
        if(!bot_dom_debug_should_protect_all())
          needs_new_goal = true;
      } else {
        if(cur_num_ally_flags == 1 && prev_num_ally_flags > 1) {
          needs_new_goal = true;
        }
      }
    }

    prev_num_ally_flags = cur_num_ally_flags;

    if(needs_new_goal) {
      self.force_new_goal = true;
      keep_monitoring = false;
      self notify("needs_new_flag_goal");
    } else {
      result = level waittill_notify_or_timeout_return("flag_changed_ownership", 1 + RandomFloatRange(0, 2));
      if(!(isDefined(result) && result == "timeout")) {
        Assert(self.strategy_level <= 3);
        wait_time = max((3 - self.strategy_level) * 1.0 + RandomFloatRange(-0.5, 0.5), 0);
        wait(wait_time);
      }
    }
  }
}

bot_dom_get_node_chance(node) {
  if(node == self.node_closest_to_defend_center) {
    return 1.0;
  }

  if(!isDefined(self.current_flag)) {
    return 1.0;
  }

  node_on_safe_path = false;

  self_current_flag_label = get_flag_label(self.current_flag);
  ally_flags = get_ally_flags(self.team);
  foreach(ally_flag in ally_flags) {
    if(ally_flag != self.current_flag) {
      node_on_safe_path = node node_is_on_path_from_labels(self_current_flag_label, get_flag_label(ally_flag));
      if(node_on_safe_path) {
        third_flag = get_other_flag(self.current_flag, ally_flag);
        third_flag_team = third_flag maps\mp\gametypes\dom::getFlagTeam();
        if(third_flag_team != self.team) {
          if(node node_is_on_path_from_labels(self_current_flag_label, get_flag_label(third_flag)))
            node_on_safe_path = false;
        }
      }
    }
  }

  if(node_on_safe_path) {
    return 0.2;
  }

  return 1.0;
}

get_flag_label(flag) {
  flag_label = "";
  if(isDefined(flag.teleport_zone))
    flag_label += (flag.teleport_zone + "_");
  flag_label += "flag" + flag.script_label;

  return flag_label;
}

get_other_flag(flag1, flag2) {
  Assert(level.flags.size == 3);
  for(i = 0; i < level.flags.size; i++) {
    if(level.flags[i] != flag1 && level.flags[i] != flag2)
      return level.flags[i];
  }
}

get_specific_flag(flag_letter) {
  Assert(flag_letter == "A" || flag_letter == "B" || flag_letter == "C");
  flag_letter = "_" + ToLower(flag_letter);

  for(i = 0; i < level.flags.size; i++) {
    if(level.flags[i].script_label == flag_letter)
      return level.flags[i];
  }
}

get_closest_flag(origin) {
  closest_flag = undefined;
  closest_flag_dist_sq = undefined;
  foreach(flag in level.flags) {
    dist_flag_to_origin_sq = DistanceSquared(flag.origin, origin);
    if(!isDefined(closest_flag_dist_sq) || dist_flag_to_origin_sq < closest_flag_dist_sq) {
      closest_flag = flag;
      closest_flag_dist_sq = dist_flag_to_origin_sq;
    }
  }

  return closest_flag;
}

get_num_allies_capturing_flag(flag, ignore_humans) {
  num_capturing_flag = 0;
  flag_capture_radius = get_flag_capture_radius();

  foreach(other_player in level.participants) {
    if(!isDefined(other_player.team)) {
      continue;
    }
    if(other_player.team == self.team && other_player != self && IsTeamParticipant(other_player)) {
      if(IsAI(other_player)) {
        if(other_player bot_is_capturing_flag(flag)) {
          num_capturing_flag++;
        }
      } else if(!isDefined(ignore_humans) || !ignore_humans) {
        if(other_player IsTouching(flag)) {
          num_capturing_flag++;
        }
      }
    }
  }

  return num_capturing_flag;
}

bot_is_capturing_flag(flag) {
  if(!self bot_is_capturing())
    return false;

  return self bot_target_is_flag(flag);
}

bot_is_protecting_flag(flag) {
  if(!self bot_is_protecting())
    return false;

  return self bot_target_is_flag(flag);
}

bot_target_is_flag(flag) {
  return (self.current_flag == flag);
}

get_num_ally_flags(team) {
  count = 0;
  for(i = 0; i < level.flags.size; i++) {
    flag_team = level.flags[i] maps\mp\gametypes\dom::getFlagTeam();
    if(flag_team == team) {
      count++;
    }
  }

  return count;
}

get_enemy_flags(team) {
  flags = [];
  for(i = 0; i < level.flags.size; i++) {
    flag_team = level.flags[i] maps\mp\gametypes\dom::getFlagTeam();
    if(flag_team == get_enemy_team(team)) {
      flags = array_add(flags, level.flags[i]);
    }
  }

  return flags;
}

get_ally_flags(team) {
  flags = [];
  for(i = 0; i < level.flags.size; i++) {
    flag_team = level.flags[i] maps\mp\gametypes\dom::getFlagTeam();
    if(flag_team == team) {
      flags = array_add(flags, level.flags[i]);
    }
  }

  return flags;
}

bot_should_defend_flag(flag, num_flags_defending) {
  if(num_flags_defending == 1)
    max_num_bots_defending_this_flag = 1;
  else
    max_num_bots_defending_this_flag = 2;

  bots_defending_flag = get_bots_defending_flag(flag);

  return (bots_defending_flag.size < max_num_bots_defending_this_flag);
}

get_bots_defending_flag(flag) {
  flag_protect_radius = get_flag_protect_radius();

  bots_defending = [];
  foreach(other_player in level.participants) {
    if(!isDefined(other_player.team)) {
      continue;
    }
    if(other_player.team == self.team && other_player != self && IsTeamParticipant(other_player)) {
      if(IsAI(other_player)) {
        if(other_player bot_is_protecting_flag(flag)) {
          bots_defending = array_add(bots_defending, other_player);
        }
      } else {
        if(DistanceSquared(flag.origin, other_player.origin) < flag_protect_radius * flag_protect_radius) {
          bots_defending = array_add(bots_defending, other_player);
        }
      }
    }
  }

  return bots_defending;
}