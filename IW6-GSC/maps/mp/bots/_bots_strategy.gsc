/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_strategy.gsc
*******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots_util;

bot_defend_get_random_entrance_point_for_current_area() {
  all_cached_entrances = self bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isDefined(all_cached_entrances) && all_cached_entrances.size > 0) {
    return random(all_cached_entrances).origin;
  }

  return undefined;
}

bot_defend_get_precalc_entrances_for_current_area(stance) {
  if(isDefined(self.defend_entrance_index)) {
    return bot_get_entrances_for_stance_and_index(stance, self.defend_entrance_index);
  }

  return [];
}

bot_setup_bombzone_bottargets() {
  wait(1.0);

  bot_setup_bot_targets(level.bombZones);
  level.bot_set_bombzone_bottargets = true;
}

bot_setup_radio_bottargets() {
  bot_setup_bot_targets(level.radios);
}

bot_setup_bot_targets(array) {
  foreach(element in array) {
    if(!isDefined(element.botTargets)) {
      element.botTargets = [];
      nodes_in_trigger = GetNodesInTrigger(element.trigger);
      foreach(node in nodes_in_trigger) {
        if(!node NodeIsDisconnected()) {
          element.botTargets = array_add(element.botTargets, node);
        }
      }
    }
  }
}

bot_get_ambush_trap_item(purposePriority1, purposePriority2, purposePriority3) {
  result = [];

  purpose_priority = [];
  purpose_priority[purpose_priority.size] = purposePriority1;
  if(isDefined(purposePriority2)) {
    purpose_priority[purpose_priority.size] = purposePriority2;
  }
  if(isDefined(purposePriority2)) {
    purpose_priority[purpose_priority.size] = purposePriority3;
  }

  foreach(purpose in purpose_priority) {
    result["purpose"] = purpose;
    result["item_action"] = self bot_get_grenade_for_purpose(purpose);
    if(isDefined(result["item_action"])) {
      return result;
    }
  }
}

bot_set_ambush_trap(trap_item, ambush_entrances, ambush_node, ambush_yaw, trap_node) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(trap_item)) {
    return false;
  }

  chosen_entrance = undefined;

  if(!isDefined(trap_node) && isDefined(ambush_entrances) && ambush_entrances.size > 0) {
    if(!isDefined(ambush_node)) {
      return false;
    }

    choose_set = [];

    fwd = undefined;
    if(isDefined(ambush_yaw)) {
      fwd = anglesToForward((0, ambush_yaw, 0));
    }

    foreach(entrance in ambush_entrances) {
      if(!isDefined(fwd)) {
        choose_set[choose_set.size] = entrance;
      } else if(DistanceSquared(entrance.origin, ambush_node.origin) > 300 * 300) {
        if(VectorDot(fwd, VectorNormalize(entrance.origin - ambush_node.origin)) < 0.4) {
          choose_set[choose_set.size] = entrance;
        }
      }
    }

    if(choose_set.size > 0) {
      chosen_entrance = Random(choose_set);
      trap_choices = GetNodesInRadius(chosen_entrance.origin, 300, 50);

      tempChoices = [];
      foreach(node in trap_choices) {
        if(!isDefined(node.bot_ambush_end)) {
          tempChoices[tempChoices.size] = node;
        }
      }
      trap_choices = tempChoices;

      trap_node = self BotNodePick(trap_choices, min(trap_choices.size, 3), "node_trap", ambush_node, chosen_entrance);
    }
  }

  if(isDefined(trap_node)) {
    yaw = undefined;
    if(trap_item["purpose"] == "trap_directional" && isDefined(chosen_entrance)) {
      placeAngles = VectorToAngles(chosen_entrance.origin - trap_node.origin);
      yaw = placeAngles[1];
    }

    if((self BotHasScriptGoal()) && (self BotGetScriptGoalType() != "critical") && (self BotGetScriptGoalType() != "tactical")) {
      self BotClearScriptGoal();
    }

    goal_succeeded = self BotSetScriptGoalNode(trap_node, "guard", yaw);

    if(goal_succeeded) {
      result = self bot_waittill_goal_or_fail();

      if(result == "goal") {
        self thread bot_force_stance_for_time("stand", 5.0);

        if(!isDefined(self.enemy) || (false == (self BotCanSeeEntity(self.enemy)))) {
          if(isDefined(yaw)) {
            self BotThrowGrenade(chosen_entrance.origin, trap_item["item_action"]);
          } else {
            self BotThrowGrenade(self.origin + (anglesToForward(self.angles) * 50), trap_item["item_action"]);
          }
          self.ambush_trap_ent = undefined;
          self thread bot_set_ambush_trap_wait_fire("grenade_fire");
          self thread bot_set_ambush_trap_wait_fire("missile_fire");
          timeToWait = 3.0;
          if(trap_item["purpose"] == "tacticalinsertion") {
            timeToWait = 6.0;
          }
          self waittill_any_timeout(timeToWait, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");
          if(isDefined(self.ambush_trap_ent) && trap_item["purpose"] == "c4") {
            self thread bot_watch_manual_detonate(self.ambush_trap_ent, trap_item["item_action"], 300);
          }
          self.ambush_trap_ent = undefined;
          wait RandomFloat(0.25);
          self BotSetStance("none");
        }
      }

      return true;
    }
  }

  return false;
}

bot_set_ambush_trap_wait_fire(waitingfor) {
  self endon("death");
  self endon("disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");

  self waittill(waitingFor, ent);

  self.ambush_trap_ent = ent;
}

bot_watch_manual_detonate(grenade, item_action, range) {
  self endon("death");
  self endon("disconnect");
  grenade endon("death");
  level endon("game_ended");

  rangeSq = range * range;

  while(1) {
    if(isDefined(grenade.origin) && DistanceSquared(self.origin, grenade.origin) > rangeSq) {
      closestEnemySq = self GetClosestEnemySqDist(grenade.origin, 1.0);
      if(closestEnemySq < rangeSq) {
        self BotPressButton(item_action);
        return;
      }
    }

    wait RandomFloatRange(0.25, 1.0);
  }
}

bot_capture_point(point, radius, optional_params) {
  self thread bot_defend_think(point, radius, "capture", optional_params);
}

bot_capture_zone(point, nodes, capture_trigger, optional_params) {
  Assert(isDefined(nodes) && nodes.size > 0);

  if(!isDefined(nodes) || nodes.size == 0) {
    return;
  }
  optional_params["capture_trigger"] = capture_trigger;
  self thread bot_defend_think(point, nodes, "capture_zone", optional_params);
}

bot_protect_point(point, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"])) {
    optional_params["min_goal_time"] = 12;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"])) {
    optional_params["max_goal_time"] = 18;
  }

  self thread bot_defend_think(point, radius, "protect", optional_params);
}

bot_patrol_area(point, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"])) {
    optional_params["min_goal_time"] = 0.00;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"])) {
    optional_params["max_goal_time"] = 0.01;
  }

  self thread bot_defend_think(point, radius, "patrol", optional_params);
}

bot_guard_player(player, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"])) {
    optional_params["min_goal_time"] = 15;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"])) {
    optional_params["max_goal_time"] = 20;
  }

  self thread bot_defend_think(player, radius, "bodyguard", optional_params);
}

bot_defend_think(defendCenter, defendRadius, defense_type, optional_params) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self endon("defend_stop");

  if(!IsAIGameParticipant(self)) {
    AssertMsg("Entity of type <" + self.classname + "> is calling bot_defend_think and is not an entity that can perform this (needs to be a bot or humanoid agent");
    return;
  }

  self thread defense_death_monitor();

  if(isDefined(self.bot_defending) || self BotGetScriptGoalType() == "camp") {
    self BotClearScriptGoal();
  }

  self.bot_defending = true;
  self.bot_defending_type = defense_type;

  if(defense_type == "capture_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = defendRadius;
    self.bot_defending_trigger = optional_params["capture_trigger"];
    Assert(isDefined(self.bot_defending_nodes) && self.bot_defending_nodes.size > 0);

    if(!isDefined(self.bot_defending_nodes) || self.bot_defending_nodes.size == 0) {
      self bot_defend_stop();
    }

  } else {
    if(isDefined(optional_params)) {
      AssertEx(!isDefined(optional_params["capture_trigger"]), "Only a defense of type 'capture_zone' should have a 'capture_trigger' defined");
    }

    self.bot_defending_radius = defendRadius;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(!isDefined(defendCenter)) {
    AssertMsg("Starting bot_defend_think with an undefined <defendCenter>");
    self bot_defend_stop();
  }

  if(IsGameParticipant(defendCenter)) {
    self.bot_defend_player_guarding = defendCenter;
    self childthread monitor_defend_player();
  } else {
    self.bot_defend_player_guarding = undefined;
    self.bot_defending_center = defendCenter;
  }

  if(self.bot_defending_type == "bodyguard") {
    if(!isDefined(self.bot_defend_player_guarding) || !IsGameParticipant(self.bot_defend_player_guarding)) {
      AssertMsg("Bot <" + self.name + "> was told to guard an invalid player");
    }
  }

  self BotSetStance("none");

  goal_type = undefined;
  min_goal_time = 6;
  max_goal_time = 10;
  if(isDefined(optional_params)) {
    self.defend_entrance_index = optional_params["entrance_points_index"];
    self.defense_score_flags = optional_params["score_flags"];
    self.bot_defending_override_origin_node = optional_params["override_origin_node"];

    if(isDefined(optional_params["override_goal_type"])) {
      goal_type = optional_params["override_goal_type"];
    }

    if(isDefined(optional_params["min_goal_time"])) {
      min_goal_time = optional_params["min_goal_time"];
    }

    if(isDefined(optional_params["max_goal_time"])) {
      max_goal_time = optional_params["max_goal_time"];
    }

    if(isDefined(optional_params["override_entrances"]) && optional_params["override_entrances"].size > 0) {
      self.defense_override_entrances = optional_params["override_entrances"];

      self.defend_entrance_index = self.name + " " + GetTime();

      foreach(entrance in self.defense_override_entrances) {
        entrance.prone_visible_from[self.defend_entrance_index] = entrance_visible_from(entrance.origin, self defend_valid_center(), "prone");
        wait(0.05);
        entrance.crouch_visible_from[self.defend_entrance_index] = entrance_visible_from(entrance.origin, self defend_valid_center(), "crouch");
        wait(0.05);
      }
    }
  }

  if(!isDefined(self.bot_defend_player_guarding)) {
    nearest_node = undefined;

    if(isDefined(optional_params) && isDefined(optional_params["nearest_node_to_center"])) {
      nearest_node = optional_params["nearest_node_to_center"];
    }

    if(!isDefined(nearest_node) && isDefined(self.bot_defending_override_origin_node)) {
      nearest_node = self.bot_defending_override_origin_node;
    }

    if(!isDefined(nearest_node) && isDefined(self.bot_defending_trigger) && isDefined(self.bot_defending_trigger.nearest_node)) {
      nearest_node = self.bot_defending_trigger.nearest_node;
    }

    if(!isDefined(nearest_node)) {
      nearest_node = GetClosestNodeInSight(self defend_valid_center());
    }

    if(!isDefined(nearest_node)) {
      defend_center = self defend_valid_center();
      nodes = GetNodesInRadiusSorted(defend_center, 256, 0);
      for(i = 0; i < nodes.size; i++) {
        center_to_node = VectorNormalize(nodes[i].origin - defend_center);
        trace_start = defend_center + center_to_node * 15;
        if(SightTracePassed(trace_start, nodes[i].origin, false, undefined)) {
          nearest_node = nodes[i];
          break;
        }

        wait(0.05);

        if(SightTracePassed(trace_start + (0, 0, 55), nodes[i].origin + (0, 0, 55), false, undefined)) {
          nearest_node = nodes[i];
          break;
        }

        wait(0.05);
      }
    }

    self.node_closest_to_defend_center = nearest_node;
    AssertEx(isDefined(self.node_closest_to_defend_center), "bot_defend_think: Could not calculate a nearest node to defense at origin " + self defend_valid_center());
  }

  AssertEx(min_goal_time < max_goal_time, "bot_defend_think: <min_goal_time> must be less than <max_goal_time>");

  find_node_function = level.bot_find_defend_node_func[defense_type];

  if(!isDefined(goal_type)) {
    goal_type = "guard";
    if(defense_type == "capture" || defense_type == "capture_zone") {
      goal_type = "objective";
    }
  }

  random_stance_at_pathnode_dest = (self bot_is_capturing());

  if(defense_type == "protect") {
    self childthread protect_watch_allies();
  }

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;

    self.cur_defend_stance = calculate_defend_stance(random_stance_at_pathnode_dest);

    current_goal_type = self BotGetScriptGoalType();
    can_override_goal = bot_goal_can_override(goal_type, current_goal_type);
    if(!can_override_goal) {
      wait(0.25);
      continue;
    }

    cur_min_goal_time = min_goal_time;
    cur_max_goal_time = max_goal_time;
    can_plant_trap = true;

    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      can_plant_trap = false;
      cur_min_goal_time = 1.0;
      cur_max_goal_time = 2.0;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      self[[find_node_function]]();
    }

    self BotClearScriptGoal();

    result = "";
    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(can_plant_trap && (self bot_is_protecting()) && !IsPlayer(defendCenter) && isDefined(self.defend_entrance_index)) {
        trap_item = self bot_get_ambush_trap_item("trap_directional", "trap", "c4");
        if(isDefined(trap_item)) {
          entrances = self bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          self bot_set_ambush_trap(trap_item, entrances, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        yaw = undefined;
        if(isDefined(self.cur_defend_angle_override)) {
          yaw = self.cur_defend_angle_override[1];
        }

        self BotSetScriptGoal(self.cur_defend_point_override, 0, goal_type, yaw);
      } else if(!isDefined(self.cur_defend_angle_override)) {
        self BotSetScriptGoalNode(self.cur_defend_node, goal_type);
      } else {
        self BotSetScriptGoalNode(self.cur_defend_node, goal_type, self.cur_defend_angle_override[1]);
      }

      if(random_stance_at_pathnode_dest) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || (self.prev_defend_node != self.cur_defend_node)) {
          self BotSetStance("none");
        }
      }

      previous_goal = self BotGetScriptGoal();
      self notify("new_defend_goal");
      self watch_nodes_stop();

      if(goal_type == "objective") {
        self defense_cautious_approach();
        self BotSetAwareness(1.0);
        self BotSetFlag("cautious", false);
      }

      if(self BotHasScriptGoal()) {
        current_goal = self BotGetScriptGoal();
        if(bot_vectors_are_equal(current_goal, previous_goal)) {
          result = self bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
        }
      }

      if(result == "goal") {
        if(random_stance_at_pathnode_dest) {
          self BotSetStance(self.cur_defend_stance);
        }

        self childthread defense_watch_entrances_at_goal();
      }
    }

    if(result != "goal") {
      wait 0.25;
    } else {
      wait_time = RandomFloatRange(cur_min_goal_time, cur_max_goal_time);
      result = self waittill_any_timeout(wait_time, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");
      if((result == "node_relinquished" || result == "bad_path" || result == "goal_changed" || result == "script_goal_changed") &&
        (self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone")) {
        self BotSetStance("none");
      }
    }
  }
}

calculate_defend_stance(random_stance_at_pathnode_dest) {
  stance = "stand";
  if(random_stance_at_pathnode_dest) {
    chance_to_stand = 100;
    chance_to_crouch = 0;
    chance_to_prone = 0;

    strategy_level = self BotGetDifficultySetting("strategyLevel");
    if(strategy_level == 1) {
      chance_to_stand = 20;
      chance_to_crouch = 25;
      chance_to_prone = 55;
    } else if(strategy_level >= 2) {
      chance_to_stand = 10;
      chance_to_crouch = 20;
      chance_to_prone = 70;
    }

    choice = RandomInt(100);
    if(choice < chance_to_crouch) {
      stance = "crouch";
    } else if(choice < chance_to_crouch + chance_to_prone) {
      stance = "prone";
    }

    if(stance == "prone") {
      entrances_to_this_zone_for_prone = self bot_defend_get_precalc_entrances_for_current_area("prone");

      bots_prone_at_this_zone = self defend_get_ally_bots_at_zone_for_stance("prone");

      if(bots_prone_at_this_zone.size >= entrances_to_this_zone_for_prone.size) {
        stance = "crouch";
      }
    }

    if(stance == "crouch") {
      entrances_to_this_zone_for_crouch = self bot_defend_get_precalc_entrances_for_current_area("crouch");

      bots_crouched_at_this_zone = self defend_get_ally_bots_at_zone_for_stance("crouch");

      if(bots_crouched_at_this_zone.size >= entrances_to_this_zone_for_crouch.size) {
        stance = "stand";
      }
    }
  }

  return stance;
}

SCR_CONST_frames_needed_visible = 18;

should_start_cautious_approach_default(firstCheck) {
  distance_start_cautiousness = 1250;
  distance_start_cautiousness_sq = distance_start_cautiousness * distance_start_cautiousness;

  if(firstCheck) {
    if(self BotGetDifficultySetting("strategyLevel") == 0) {
      return false;
    }

    if(self.bot_defending_type == "capture_zone" && self IsTouching(self.bot_defending_trigger)) {
      return false;
    }

    return (DistanceSquared(self.origin, self.bot_defending_center) > distance_start_cautiousness_sq * 0.75 * 0.75);
  } else {
    if(self BotPursuingScriptGoal() && DistanceSquared(self.origin, self.bot_defending_center) < distance_start_cautiousness_sq) {
      bot_path_dist = self BotGetPathDist();
      return (0 <= bot_path_dist && bot_path_dist <= distance_start_cautiousness);
    } else {
      return false;
    }
  }
}

setup_investigate_location(node, optional_location) {
  new_location = spawnStruct();
  if(isDefined(optional_location)) {
    new_location.origin = optional_location;
  } else {
    new_location.origin = node.origin;
  }
  AssertEx(isDefined(node), "Bot Investigation Location " + new_location.origin + " has no node");
  new_location.node = node;
  new_location.frames_visible = 0;
  return new_location;
}

defense_cautious_approach() {
    self notify("defense_cautious_approach");
    self endon("defense_cautious_approach");

    level endon("game_ended");
    self endon("defend_force_node_recalculation");
    self endon("death");
    self endon("disconnect");
    self endon("defend_stop");
    self endon("started_bot_defend_think");

    if(![
        [level.bot_funcs["should_start_cautious_approach"]]
      ](true)) {
      return;
    }
    original_script_goal = self BotGetScriptGoal();
    original_script_goal_node = self BotGetScriptGoalNode();

    if(isDefined(original_script_goal_node)) {
      Assert(self.cur_defend_node == original_script_goal_node);
    } else {
      Assert(isDefined(self.cur_defend_point_override));
      Assert(bot_vectors_are_equal(original_script_goal, self.cur_defend_point_override));
    }

    should_continue_waiting = true;
    time_since_last_dist_check = 0.2;
    while(should_continue_waiting) {
      wait(0.25);

      if(!self BotHasScriptGoal()) {
        return;
      }

      current_script_goal = self BotGetScriptGoal();
      if(!bot_vectors_are_equal(original_script_goal, current_script_goal)) {
        return;
      }

      time_since_last_dist_check += 0.25;
      if(time_since_last_dist_check >= 0.5) {
        time_since_last_dist_check = 0.0;
        if([
            [level.bot_funcs["should_start_cautious_approach"]]
          ](false))
          should_continue_waiting = false;
      }
    }

    self BotSetAwareness(1.8);
    self BotSetFlag("cautious", true);

    /

    wait(0.05);

    for(current_path_section = 1; current_path_section < current_path_to_goal.size - 2; current_path_section++) {
      /
      bot_defend_stop() {
        self notify("defend_stop");
        self.bot_defending = undefined;
        self.bot_defending_center = undefined;
        self.bot_defending_radius = undefined;
        self.bot_defending_nodes = undefined;
        self.bot_defending_type = undefined;
        self.bot_defending_trigger = undefined;
        self.bot_defending_override_origin_node = undefined;
        self.bot_defend_player_guarding = undefined;
        self.defense_score_flags = undefined;
        self.node_closest_to_defend_center = undefined;
        self.defense_investigate_specific_point = undefined;
        self.defense_force_next_node_goal = undefined;

        self.prev_defend_node = undefined;
        self.cur_defend_node = undefined;
        self.cur_defend_angle_override = undefined;
        self.cur_defend_point_override = undefined;

        self.defend_entrance_index = undefined;
        self.defense_override_entrances = undefined;

        self BotClearScriptGoal();
        self BotSetStance("none");
      }

      defend_get_ally_bots_at_zone_for_stance(stance) {
        other_players_with_same_stance = [];

        foreach(other_player in level.participants) {
          if(!isDefined(other_player.team)) {
            continue;
          }
          if(other_player.team == self.team && other_player != self && IsAI(other_player) && other_player bot_is_defending() && other_player.cur_defend_stance == stance) {
            if(other_player.bot_defending_type == self.bot_defending_type && self bot_is_defending_point(other_player.bot_defending_center)) {
              other_players_with_same_stance = array_add(other_players_with_same_stance, other_player);
            }
          }
        }

        return other_players_with_same_stance;
      }

      monitor_defend_player() {
        player_not_moving_time = 0;
        new_goal_radius = 175;
        last_player_pos = self.bot_defend_player_guarding.origin;
        prev_player_velocity = 0;
        should_reset_player_base_pos_when_still = false;

        while(1) {
          if(!isDefined(self.bot_defend_player_guarding)) {
            self thread bot_defend_stop();
          }

          if(self.bot_defend_player_guarding IsLinked()) {
            wait(0.05);
            continue;
          }

          self.bot_defending_center = self.bot_defend_player_guarding.origin;
          self.node_closest_to_defend_center = self.bot_defend_player_guarding GetNearestNode();
          if(!isDefined(self.node_closest_to_defend_center)) {
            self.node_closest_to_defend_center = self GetNearestNode();
          }
          Assert(isDefined(self.node_closest_to_defend_center));

          if(self BotGetScriptGoalType() != "none") {
            script_goal = self BotGetScriptGoal();

            player_guarding_velocity = self.bot_defend_player_guarding GetVelocity();
            player_guarding_velocity_len_sq = LengthSquared(player_guarding_velocity);
            if(player_guarding_velocity_len_sq > (10 * 10)) {
              player_not_moving_time = 0;

              if(DistanceSquared(last_player_pos, self.bot_defend_player_guarding.origin) > (new_goal_radius * new_goal_radius)) {
                last_player_pos = self.bot_defend_player_guarding.origin;
                should_reset_player_base_pos_when_still = true;

                player_to_script_goal = VectorNormalize(script_goal - self.bot_defend_player_guarding.origin);
                normalized_velocity = VectorNormalize(player_guarding_velocity);
                if(VectorDot(player_to_script_goal, normalized_velocity) < 0.1) {
                  self notify("defend_force_node_recalculation");
                  wait(0.25);
                }
              }
            } else {
              player_not_moving_time += 0.05;

              if(prev_player_velocity > (10 * 10) && should_reset_player_base_pos_when_still) {
                last_player_pos = self.bot_defend_player_guarding.origin;
                should_reset_player_base_pos_when_still = false;
              }

              if(player_not_moving_time > 0.5) {
                distSQ = DistanceSquared(script_goal, self.bot_defending_center);
                if(distSQ > self.bot_defending_radius * self.bot_defending_radius) {
                  self notify("defend_force_node_recalculation");
                  wait(0.25);
                }
              }
            }

            prev_player_velocity = player_guarding_velocity_len_sq;

            if(abs(self.bot_defend_player_guarding.origin[2] - script_goal[2]) >= 50) {
              self notify("defend_force_node_recalculation");
              wait(0.25);
            }

          }

          wait(0.05);
        }
      }

      find_defend_node_capture() {
        entrance_point = self bot_defend_get_random_entrance_point_for_current_area();

        node = self bot_find_node_to_capture_point(self defend_valid_center(), self.bot_defending_radius, entrance_point);

        if(isDefined(node)) {
          if(isDefined(entrance_point)) {
            node_to_entrance = VectorNormalize(entrance_point - node.origin);
            self.cur_defend_angle_override = VectorToAngles(node_to_entrance);
          } else {
            center_to_node = VectorNormalize(node.origin - self defend_valid_center());
            self.cur_defend_angle_override = VectorToAngles(center_to_node);
          }
          self.cur_defend_node = node;
        } else {
          if(isDefined(entrance_point)) {
            self bot_handle_no_valid_defense_node(entrance_point, undefined);
          } else {
            self bot_handle_no_valid_defense_node(undefined, self defend_valid_center());
          }
        }
      }

      find_defend_node_capture_zone() {
        entrance_point = self bot_defend_get_random_entrance_point_for_current_area();

        node = self bot_find_node_to_capture_zone(self.bot_defending_nodes, entrance_point);

        if(isDefined(node)) {
          if(isDefined(entrance_point)) {
            node_to_entrance = VectorNormalize(entrance_point - node.origin);
            self.cur_defend_angle_override = VectorToAngles(node_to_entrance);
          } else {
            center_to_node = VectorNormalize(node.origin - self defend_valid_center());
            self.cur_defend_angle_override = VectorToAngles(center_to_node);
          }
          self.cur_defend_node = node;
        } else {
          if(isDefined(entrance_point)) {
            self bot_handle_no_valid_defense_node(entrance_point, undefined);
          } else {
            self bot_handle_no_valid_defense_node(undefined, self defend_valid_center());
          }
        }
      }

      find_defend_node_protect() {
        node = self bot_find_node_that_protects_point(self defend_valid_center(), self.bot_defending_radius);

        if(isDefined(node)) {
          node_to_center = VectorNormalize(self defend_valid_center() - node.origin);
          self.cur_defend_angle_override = VectorToAngles(node_to_center);
          self.cur_defend_node = node;
        } else {
          self bot_handle_no_valid_defense_node(self defend_valid_center(), undefined);
        }
      }

      find_defend_node_bodyguard() {
        node = self bot_find_node_to_guard_player(self defend_valid_center(), self.bot_defending_radius);

        if(isDefined(node)) {
          self.cur_defend_node = node;
        } else {
          nearest_node_bot = self GetNearestNode();
          if(isDefined(nearest_node_bot)) {
            self.cur_defend_node = nearest_node_bot;
          } else {
            self.cur_defend_point_override = self.origin;
          }
        }
      }

      find_defend_node_patrol() {
        node = undefined;
        nodes = GetNodesInRadius(self defend_valid_center(), self.bot_defending_radius, 0);
        if(isDefined(nodes) && nodes.size > 0) {
          node = self BotNodePick(nodes, 1 + (nodes.size * 0.5), "node_traffic");
        }

        if(isDefined(node)) {
          self.cur_defend_node = node;
        } else {
          self bot_handle_no_valid_defense_node(undefined, self defend_valid_center());
        }
      }

      bot_handle_no_valid_defense_node(face_towards_point, face_away_from_point) {
        assert((!isDefined(face_towards_point) && isDefined(face_away_from_point)) || (isDefined(face_towards_point) && !isDefined(face_away_from_point)));

        if(self.bot_defending_type == "capture_zone") {
          self.cur_defend_point_override = self bot_pick_random_point_from_set(self defend_valid_center(), self.bot_defending_nodes, ::bot_can_use_point_in_defend);
        } else {
          self.cur_defend_point_override = self bot_pick_random_point_in_radius(self defend_valid_center(), self.bot_defending_radius, ::bot_can_use_point_in_defend, 0.15, 0.9);
        }

        if(isDefined(face_towards_point)) {
          angle_dir = VectorNormalize(face_towards_point - self.cur_defend_point_override);
          self.cur_defend_angle_override = VectorToAngles(angle_dir);
        } else if(isDefined(face_away_from_point)) {
          angle_dir = VectorNormalize(self.cur_defend_point_override - face_away_from_point);
          self.cur_defend_angle_override = VectorToAngles(angle_dir);
        }
      }

      bot_can_use_point_in_defend(point) {
        if(self bot_check_team_is_using_position(point, true, true, true)) {
          return false;
        }

        return true;
      }

      SCR_CONST_player_close_dist = 21;
      SCR_CONST_player_close_dist_sq = SCR_CONST_player_close_dist * SCR_CONST_player_close_dist;

      bot_check_team_is_using_position(position, check_human_player_near, check_bot_player_near, check_bot_destination_near) {
        for(i = 0; i < level.participants.size; i++) {
          other_player = level.participants[i];
          if(other_player.team == self.team && other_player != self) {
            if(IsAI(other_player)) {
              if(check_bot_player_near) {
                if(DistanceSquared(position, other_player.origin) < SCR_CONST_player_close_dist_sq) {
                  return true;
                }
              }

              if(check_bot_destination_near && other_player BotHasScriptGoal()) {
                bot_goal = other_player BotGetScriptGoal();
                if(DistanceSquared(position, bot_goal) < SCR_CONST_player_close_dist_sq) {
                  return true;
                }
              }
            } else {
              if(check_human_player_near) {
                if(DistanceSquared(position, other_player.origin) < SCR_CONST_player_close_dist_sq) {
                  return true;
                }
              }
            }
          }
        }

        return false;
      }

      bot_capture_zone_get_furthest_distance() {
        furthest_dist = 0;
        if(isDefined(self.bot_defending_nodes)) {
          foreach(node in self.bot_defending_nodes) {
            dist_to_node = Distance(self.bot_defending_center, node.origin);
            furthest_dist = max(dist_to_node, furthest_dist);
          }
        }

        return furthest_dist;
      }

      bot_think_tactical_goals() {
        self notify("bot_think_tactical_goals");
        self endon("bot_think_tactical_goals");

        self endon("death");
        self endon("disconnect");
        level endon("game_ended");

        self.tactical_goals = [];
        while(1) {
          if(self.tactical_goals.size > 0 && !self bot_is_remote_or_linked()) {
            new_goal = self.tactical_goals[0];

            if(!isDefined(new_goal.abort)) {
              self notify("start_tactical_goal");

              if(isDefined(new_goal.start_thread)) {
                self[[new_goal.start_thread]](new_goal);
              }

              self childthread watch_goal_aborted(new_goal);

              goal_type = "tactical";
              if(isDefined(new_goal.goal_type)) {
                goal_type = new_goal.goal_type;
              }

              self BotSetScriptGoal(new_goal.goal_position, new_goal.goal_radius, goal_type, new_goal.goal_yaw, new_goal.objective_radius);

              result = self bot_waittill_goal_or_fail(undefined, "stop_tactical_goal");
              self notify("stop_goal_aborted_watch");

              if(result == "goal") {
                if(isDefined(new_goal.action_thread)) {
                  self[[new_goal.action_thread]](new_goal);
                }
              }

              if(result != "script_goal_changed") {
                self BotClearScriptGoal();
              }

              if(isDefined(new_goal.end_thread)) {
                self[[new_goal.end_thread]](new_goal);
              }
            }

            self.tactical_goals = array_remove(self.tactical_goals, new_goal);
          }

          wait(0.05);
        }
      }

      watch_goal_aborted(goal) {
        self endon("stop_tactical_goal");
        self endon("stop_goal_aborted_watch");

        wait(0.05);

        while(1) {
          if(isDefined(goal.abort) || (isDefined(goal.should_abort) && self[[goal.should_abort]](goal))) {
            self notify("stop_tactical_goal");
          }

          wait(0.05);
        }
      }

      bot_new_tactical_goal(type, goal_position, priority, extra_params) {
        new_goal = spawnStruct();
        new_goal.type = type;
        new_goal.goal_position = goal_position;

        if(isDefined(self.only_allowable_tactical_goals)) {
          if(!array_contains(self.only_allowable_tactical_goals, type)) {
            return;
          }
        }

        assert(priority >= 0 && priority <= 100);
        new_goal.priority = priority;

        new_goal.object = extra_params.object;

        new_goal.goal_type = extra_params.script_goal_type;
        new_goal.goal_yaw = extra_params.script_goal_yaw;
        new_goal.goal_radius = 0;
        if(isDefined(extra_params.script_goal_radius)) {
          new_goal.goal_radius = extra_params.script_goal_radius;
        }

        new_goal.start_thread = extra_params.start_thread;
        new_goal.end_thread = extra_params.end_thread;
        new_goal.should_abort = extra_params.should_abort;
        new_goal.action_thread = extra_params.action_thread;
        new_goal.objective_radius = extra_params.objective_radius;

        for(position_to_add = 0; position_to_add < self.tactical_goals.size; position_to_add++) {
          if(new_goal.priority > self.tactical_goals[position_to_add].priority) {
            break;
          }
        }

        for(i = self.tactical_goals.size - 1; i >= position_to_add; i--) {
          self.tactical_goals[i + 1] = self.tactical_goals[i];
        }

        self.tactical_goals[position_to_add] = new_goal;
      }

      bot_has_tactical_goal(goal_type, object) {
        if(!isDefined(self.tactical_goals)) {
          return false;
        }

        if(isDefined(goal_type)) {
          foreach(goal in self.tactical_goals) {
            if(goal.type == goal_type) {
              if(isDefined(object) && isDefined(goal.object)) {
                return (goal.object == object);
              } else {
                return true;
              }
            }
          }

          return false;
        } else {
          return (self.tactical_goals.size > 0);
        }
      }

      bot_abort_tactical_goal(goal_type, object) {
        assert(isDefined(goal_type));

        if(!isDefined(self.tactical_goals)) {
          return;
        }
        foreach(goal in self.tactical_goals) {
          if(goal.type == goal_type) {
            if(isDefined(object)) {
              if(isDefined(goal.object) && (goal.object == object)) {
                goal.abort = true;
              }
            } else {
              goal.abort = true;
            }
          }
        }
      }

      bot_disable_tactical_goals() {
        self.only_allowable_tactical_goals[0] = "map_interactive_object";
        foreach(goal in self.tactical_goals) {
          if(goal.type != "map_interactive_object") {
            goal.abort = true;
          }
        }
      }

      bot_enable_tactical_goals() {
        self.only_allowable_tactical_goals = undefined;
      }

      bot_melee_tactical_insertion_check() {
        now = GetTime();

        if(!isDefined(self.last_melee_ti_check) || (now - self.last_melee_ti_check) > 1000) {
          self.last_melee_ti_check = now;

          trap_item = self bot_get_ambush_trap_item("tacticalinsertion");

          if(!isDefined(trap_item)) {
            return false;
          }

          if(isDefined(self.enemy) && self BotCanSeeEntity(self.enemy)) {
            return false;
          }

          myZone = GetZoneNearest(self.origin);
          if(!isDefined(myZone)) {
            return false;
          }

          nearbyEnemyZone = BotZoneNearestCount(myZone, self.team, 1, "enemy_predict", ">", 0);
          if(!isDefined(nearbyEnemyZone)) {
            return false;
          }

          nodesAroundMe = GetNodesInRadius(self.origin, 500, 0);
          if(nodesAroundMe.size <= 0) {
            return false;
          }

          place_node = self BotNodePick(nodesAroundMe, nodesAroundMe.size * 0.15, "node_hide");
          if(!isDefined(place_node)) {
            return false;
          }

          return self bot_set_ambush_trap(trap_item, undefined, undefined, undefined, place_node);
        }

        return false;
      }