/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_sd.gsc
**********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;

main() {
  setup_callbacks();
  bot_sd_start();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_sd_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_sd;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;
}

bot_sd_start() {
  thread bot_sd_debug();

  setup_bot_sd();
}

crate_can_use(crate) {
  if(IsAgent(self) && !isDefined(crate.boxType))
    return false;

  if(!IsTeamParticipant(self))
    return true;

  if(!isDefined(self.role))
    return false;

  switch (self.role) {
    case "atk_bomber":
    case "bomb_defuser":
    case "investigate_someone_using_bomb":
      return false;
  }

  return true;
}

setup_bot_sd() {
  level.bots_disable_team_switching = true;
  level.initial_pickup_wait_time = 3000;

  bot_setup_bombzone_bottargets();

  bot_waittill_bots_enabled(true);

  level.bot_sd_override_zone_targets = [];
  level.bot_sd_override_zone_targets["axis"] = [];
  level.bot_sd_override_zone_targets["allies"] = [];

  level.bot_default_sd_role_behavior["atk_bomber"] = ::atk_bomber_update;
  level.bot_default_sd_role_behavior["clear_target_zone"] = ::clear_target_zone_update;
  level.bot_default_sd_role_behavior["defend_planted_bomb"] = ::defend_planted_bomb_update;
  level.bot_default_sd_role_behavior["bomb_defuser"] = ::bomb_defuser_update;
  level.bot_default_sd_role_behavior["investigate_someone_using_bomb"] = ::investigate_someone_using_bomb_update;
  level.bot_default_sd_role_behavior["camp_bomb"] = ::camp_bomb_update;
  level.bot_default_sd_role_behavior["defender"] = ::defender_update;
  level.bot_default_sd_role_behavior["backstabber"] = ::backstabber_update;
  level.bot_default_sd_role_behavior["random_killer"] = ::random_killer_update;

  sd_has_fatal_error = false;
  foreach(bombZone in level.bombZones) {
    zone = GetZoneNearest(bombZone.curorigin);
    if(isDefined(zone))
      BotZoneSetTeam(zone, game["defenders"]);

    if(bombZone.botTargets.size < 3) {
      wait(5);
      assertmsg("Bombzone '" + bombZone.label + "' at location " + bombZone.curorigin + " needs at least 3 nodes in its trigger_use_touch");

      if(bombZone.botTargets.size < 1)
        sd_has_fatal_error = true;
    }

    if(bombZone.label != "_a" && bombZone.label != "_b") {
      wait(5);
      assertmsg("S&D BombZones need a label of'_a'or'_b'");
    }
  }

  if(!sd_has_fatal_error) {
    bot_cache_entrances_to_bombzones();
    thread bot_sd_ai_director_update();
    level.bot_gametype_precaching_done = true;
  }
}

bot_sd_debug() {
  while(!isDefined(level.bot_set_bombzone_bottargets))
    wait(0.05);

  while(1) {
    if(getDvar("bot_DrawDebugGametype") == "sd") {
      foreach(bombZone in level.bombZones) {
        foreach(node in bombZone.botTargets) {
          bot_draw_cylinder(node.origin, 8, 10, 0.05, undefined, (0, 1, 0), 1, 4);
        }
      }
    }

    wait(0.05);
  }
}

bot_sd_think() {
  self notify("bot_sd_think");
  self endon("bot_sd_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait(0.05);

  self BotSetFlag("separation", 0);
  self BotSetFlag("grenade_objectives", 1);
  self BotSetFlag("use_obj_path_style", true);
  attacker_team = game["attackers"];

  should_clear_role = true;
  if(isDefined(level.sdBomb) && isDefined(level.sdBomb.carrier) && level.sdBomb.carrier == self && isDefined(self.role) && self.role == "atk_bomber") {
    should_clear_role = false;
  }

  if(should_clear_role)
    self.role = undefined;

  self.suspend_sd_role = undefined;
  self.has_started_thinking = false;
  self.atk_bomber_no_path_to_bomb_count = 0;
  self.scripted_path_style = undefined;
  self.defender_set_script_pathstyle = undefined;
  self.defuser_bad_path_counter = 0;

  if(!isDefined(level.initial_bomb_location) && !level.multiBomb) {
    level.initial_bomb_location = level.sdBomb.curorigin;
    level.initial_bomb_location_nearest_node = GetClosestNodeInSight(level.sdBomb.curorigin);
  }

  if(self.team == attacker_team && !isDefined(level.can_pickup_bomb_time)) {
    should_wait_to_pickup_bomb = false;
    if(!level.multiBomb) {
      players = get_living_players_on_team(attacker_team);
      foreach(player in players) {
        if(!IsAI(player))
          should_wait_to_pickup_bomb = true;
      }
    }

    if(should_wait_to_pickup_bomb) {
      time = 6000;
      level.can_pickup_bomb_time = GetTime() + time;
      BadPlace_Cylinder("bomb", time / 1000, level.sdBomb.curorigin, 75, 300, attacker_team);
    }
  }

  while(1) {
    wait(RandomIntRange(1, 3) * 0.05);

    if(self.health <= 0) {
      continue;
    }
    self.has_started_thinking = true;

    if(!isDefined(self.role))
      self initialize_sd_role();

    if(isDefined(self.suspend_sd_role)) {
      continue;
    }
    if(self.team == attacker_team) {
      if(!level.multiBomb && isDefined(level.can_pickup_bomb_time) && GetTime() < level.can_pickup_bomb_time && !isDefined(level.sdBomb.carrier)) {
        if(!self bot_is_defending_point(level.sdBomb.curOrigin)) {
          closest_node_to_bomb = GetClosestNodeInSight(level.sdBomb.curorigin);
          if(isDefined(closest_node_to_bomb)) {
            optional_params["nearest_node_to_center"] = closest_node_to_bomb;
            self bot_protect_point(level.sdBomb.curOrigin, 900, optional_params);
          } else {
            level.can_pickup_bomb_time = GetTime();
          }
        }
      } else {
        self[[level.bot_default_sd_role_behavior[self.role]]]();
      }
    } else {
      if(level.bombPlanted) {
        if(DistanceSquared(self.origin, level.sdBombModel.origin) > squared(level.protect_radius * 2)) {
          if(!isDefined(self.defender_set_script_pathstyle)) {
            self.defender_set_script_pathstyle = true;
            self BotSetPathingStyle("scripted");
          }
        } else if(isDefined(self.defender_set_script_pathstyle) && !isDefined(self.scripted_path_style)) {
          self.defender_set_script_pathstyle = undefined;
          self BotSetPathingStyle(undefined);
        }
      }

      if(level.bombPlanted && isDefined(level.bomb_defuser) && self.role != "bomb_defuser") {
        if(!self bot_is_defending_point(level.sdBombModel.origin)) {
          self BotClearScriptGoal();
          self bot_protect_point(level.sdBombModel.origin, level.protect_radius);
        }
      } else {
        self[[level.bot_default_sd_role_behavior[self.role]]]();
      }
    }
  }
}

atk_bomber_update() {
  self endon("new_role");

  Assert(level.atk_bomber == self);

  if(self bot_is_defending())
    self bot_defend_stop();

  if(isDefined(level.sdBomb) && isDefined(level.sdBomb.carrier) && IsAlive(level.sdBomb.carrier) && level.sdBomb.carrier != self) {
    wait(0.50 + 0.15 + 0.05);

    if(IsAlive(level.sdBomb.carrier) && level.sdBomb.carrier != self) {
      println("Current self role is " + self.role);
      println("level.sdBomb.carrier is " + level.sdBomb.carrier.name);
      println("level.sdBomb.carrier.role is " + ter_op(isDefined(level.sdBomb.carrier.role), level.sdBomb.carrier.role, "undefined"));
      AssertMsg("bot " + self.name + " still processing atk_bomber script, even though bomb was stolen from him.See console log");
    }
  }

  if(!self.isBombCarrier && !level.multiBomb) {
    Assert(!level.bombPlanted);

    if(isDefined(level.sdBomb)) {
      if(!isDefined(self.last_bomb_location))
        self.last_bomb_location = level.sdBomb.curOrigin;

      if(DistanceSquared(self.last_bomb_location, level.sdBomb.curOrigin) > 2 * 2) {
        self BotClearScriptGoal();
        self.last_bomb_location = level.sdBomb.curOrigin;
      }
    }

    if(self BotHasScriptGoal()) {
      goal = self BotGetScriptGoal();
      if(DistanceSquared(goal, self.origin) < 10 * 10) {
        if(!isDefined(self.bot_warned_no_pickup) || (DistanceSquared(self.bot_warned_no_pickup, goal) >= 10 * 10))
          AssertMsg("Bot is supposed to grab the bomb and yet is stuck at a goal somewhere - this should not happen.Goal was " + goal + " and bomb is at " + level.sdBomb.curOrigin);
        self.bot_warned_no_pickup = goal;
      }
    }

    if(self.atk_bomber_no_path_to_bomb_count >= 2) {
      nodes = GetNodesInRadiusSorted(level.sdBomb.curOrigin, 512, 0);
      best_node = undefined;
      foreach(node in nodes) {
        if(!node NodeIsDisconnected()) {
          best_node = node;
          break;
        }
      }

      if(isDefined(best_node)) {
        self BotSetScriptGoal(best_node.origin, 20, "critical");
        self bot_waittill_goal_or_fail();

        if(isDefined(level.sdBomb) && !isDefined(level.sdBomb.carrier))
          level.sdBomb maps\mp\gametypes\_gameobjects::setPickedUp(self);
      } else {
        AssertMsg("Could not find any nodes around the bomb at location " + level.sdBomb.curOrigin);
      }

      return;
    }

    if(!self BotHasScriptGoal()) {
      bot_radius = 15;
      bomb_radius = 32;

      valid_point_near_bomb = bot_queued_process("BotGetClosestNavigablePoint", ::func_bot_get_closest_navigable_point, level.sdBomb.curOrigin, (bot_radius + bomb_radius), self);
      if(isDefined(valid_point_near_bomb)) {
        set_goal = self BotSetScriptGoal(level.sdBomb.curOrigin, 0, "critical");
        if(set_goal)
          self childthread bomber_monitor_no_path();
      } else {
        nodes = GetNodesInRadiusSorted(level.sdBomb.curOrigin, 512, 0);
        if(nodes.size > 0) {
          self BotSetScriptGoal(nodes[0].origin, 0, "critical");
          self bot_waittill_goal_or_fail();
        }

        if(isDefined(level.sdBomb) && !isDefined(level.sdBomb.carrier)) {
          valid_point_near_bomb = bot_queued_process("BotGetClosestNavigablePoint", ::func_bot_get_closest_navigable_point, level.sdBomb.curOrigin, (bot_radius + bomb_radius), self);
          if(!isDefined(valid_point_near_bomb)) {
            level.sdBomb maps\mp\gametypes\_gameobjects::setPickedUp(self);
          }
        }
      }
    }
  } else {
    Assert(isDefined(self.carryObject) || level.multiBomb);
    if(isDefined(self.dont_plant_until_time) && GetTime() < self.dont_plant_until_time) {
      return;
    }
    if(!isDefined(level.bomb_zone_assaulting)) {
      level.bomb_zone_assaulting = level.bombZones[RandomInt(level.bombZones.size)];
    }

    bombZoneGoal = level.bomb_zone_assaulting;
    self.bombZoneGoal = bombZoneGoal;

    if(!isDefined(level.initial_bomb_pickup_time) || GetTime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time) {
      level.initial_bomb_pickup_time = GetTime() + level.initial_pickup_wait_time;
      self BotClearScriptGoal();
      self BotSetScriptGoal(self.origin, 0, "tactical");
      wait(level.initial_pickup_wait_time / 1000);
    }

    self BotClearScriptGoal();

    if(level.attack_behavior == "rush") {
      self BotSetPathingStyle("scripted");

      Assert(bombZoneGoal.botTargets.size >= 2);

      botTargets_sorted = self BotNodeScoreMultiple(bombZoneGoal.botTargets, "node_exposed");

      chance_plant_most_exposed_node = (self BotGetDifficultySetting("strategyLevel")) * 0.45;
      chance_plant_second_most_exposed_node = (self BotGetDifficultySetting("strategyLevel") + 1) * 0.15;

      foreach(node in bombZoneGoal.botTargets) {
        if(!array_contains(botTargets_sorted, node))
          botTargets_sorted[botTargets_sorted.size] = node;
      }

      Assert(botTargets_sorted.size >= 2);

      if(RandomFloat(1.0) < chance_plant_most_exposed_node)
        best_botTarget = botTargets_sorted[0];
      else if(RandomFloat(1.0) < chance_plant_second_most_exposed_node)
        best_botTarget = botTargets_sorted[1];
      else
        best_botTarget = Random(botTargets_sorted);

      self BotSetScriptGoal(best_botTarget.origin, 0, "critical");
    }

    pathResult = self bot_waittill_goal_or_fail();
    if(pathResult == "goal") {
      time_left = get_round_end_time() - GetTime();
      time_till_last_chance_to_plant = time_left - (level.plantTime * 2) * 1000;
      last_chance_to_plant = GetTime() + time_till_last_chance_to_plant;
      if(time_till_last_chance_to_plant > 0) {
        self bot_waittill_out_of_combat_or_time(time_till_last_chance_to_plant);
      }

      emergency_plant = (GetTime() >= last_chance_to_plant);
      succeeded = self sd_press_use(level.plantTime + 2, "bomb_planted", emergency_plant);
      self BotClearScriptGoal();
      if(succeeded) {
        Assert(level.bombPlanted);
        self bot_enable_tactical_goals();
        self bot_set_role("defend_planted_bomb");
      } else {
        Assert(!level.bombPlanted);
        if(time_till_last_chance_to_plant > 5000)
          self.dont_plant_until_time = GetTime() + 5000;
      }
    }
  }
}

get_round_end_time() {
  if(level.bombPlanted) {
    return level.defuseEndTime;
  } else {
    return (GetTime() + maps\mp\gametypes\_gamelogic::getTimeRemaining());
  }
}

bomber_monitor_no_path() {
  self notify("bomber_monitor_no_path");

  self endon("death");
  self endon("disconnect");
  self endon("goal");
  self endon("bomber_monitor_no_path");

  level.sdBomb endon("pickup_object");

  while(1) {
    self waittill("no_path");
    self.atk_bomber_no_path_to_bomb_count++;
  }
}

clear_target_zone_update() {
  self endon("new_role");

  if(isDefined(level.atk_bomber)) {
    if(level.attack_behavior == "rush") {
      if(!isDefined(self.set_initial_rush_goal)) {
        if(!level.multiBomb) {
          optional_params["nearest_node_to_center"] = level.initial_bomb_location_nearest_node;
          self bot_protect_point(level.initial_bomb_location, 900, optional_params);
          wait(RandomFloatRange(0.0, 4.0));
          self bot_defend_stop();
        }
        self.set_initial_rush_goal = true;
      }

      if(self BotGetDifficultySetting("strategyLevel") > 0)
        self set_force_sprint();

      if(IsAI(level.atk_bomber) && isDefined(level.atk_bomber.bombZoneGoal))
        bombZoneTarget = level.atk_bomber.bombZoneGoal;
      else if(isDefined(level.bomb_zone_assaulting))
        bombZoneTarget = level.bomb_zone_assaulting;
      else
        bombZoneTarget = find_closest_bombzone_to_player(level.atk_bomber);

      if(!self bot_is_defending_point(bombZoneTarget.curorigin)) {
        optional_params["min_goal_time"] = 2;
        optional_params["max_goal_time"] = 4;
        optional_params["override_origin_node"] = Random(bombZoneTarget.botTargets);
        self bot_protect_point(bombZoneTarget.curorigin, level.protect_radius, optional_params);
      }
    }
  }
}

defend_planted_bomb_update() {
  self endon("new_role");

  if(level.bombPlanted) {
    if(level.attack_behavior == "rush")
      self disable_force_sprint();

    if(!self bot_is_defending_point(level.sdBombModel.origin))
      self bot_protect_point(level.sdBombModel.origin, level.protect_radius);
  }
}

SCR_CONST_BOT_DEFUSE_FALLBACK_COUNT = 4;

bomb_defuser_update() {
  self endon("new_role");

  if(level.bombdefused) {
    return;
  }
  zone = find_ticking_bomb();
  if(!isDefined(zone)) {
    return;
  }
  bot_targets_sorted = get_array_of_closest(level.sdBombModel.origin, zone.botTargets);
  defuse_target_origin = (level.sdBombModel.origin[0], level.sdBombModel.origin[1], bot_targets_sorted[0].origin[2]);

  set_final_defuse_goal = self cautious_approach_till_close(defuse_target_origin, undefined);
  if(!set_final_defuse_goal) {
    return;
  }
  pathResult = self bot_waittill_goal_or_fail();

  if(pathResult == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= SCR_CONST_BOT_DEFUSE_FALLBACK_COUNT) {
      while(1) {
        nodes = GetNodesInRadiusSorted(defuse_target_origin, 50, 0);
        potential_index = (self.defuser_bad_path_counter - SCR_CONST_BOT_DEFUSE_FALLBACK_COUNT);
        if(nodes.size <= potential_index) {
          break;
        }

        self BotSetScriptGoal(nodes[potential_index].origin, 20, "critical");
        pathResult = self bot_waittill_goal_or_fail();
        if(pathResult == "bad_path")
          self.defuser_bad_path_counter++;
        else
          break;
      }
    }
  }

  if(pathResult == "goal") {
    time_left = get_round_end_time() - GetTime();
    time_till_last_chance_to_defuse = time_left - (level.defuseTime * 2) * 1000;
    last_chance_to_defuse = GetTime() + time_till_last_chance_to_defuse;
    if(time_till_last_chance_to_defuse > 0) {
      self bot_waittill_out_of_combat_or_time(time_till_last_chance_to_defuse);
    }

    emergency_defuse = (GetTime() >= last_chance_to_defuse);
    self sd_press_use(level.defuseTime + 2, "bomb_defused", emergency_defuse);
    self BotClearScriptGoal();
    self bot_enable_tactical_goals();
  }
}

investigate_someone_using_bomb_update() {
  self endon("new_role");

  if(self bot_is_defending())
    self bot_defend_stop();

  closest_bomb_zone = find_closest_bombzone_to_player(self);
  self BotSetScriptGoalNode(Random(closest_bomb_zone.botTargets), "guard");
  result = self bot_waittill_goal_or_fail();
  if(result == "goal") {
    wait(4);
    self bot_set_role(self.prev_role);
  }
}

camp_bomb_update() {
  self endon("new_role");

  if(isDefined(level.sdBomb.carrier)) {
    if(self.prev_role == "defender")
      self.defend_zone = find_closest_bombzone_to_player(self);
    self bot_set_role(self.prev_role);
  } else if(!self bot_is_defending_point(level.sdBomb.curorigin)) {
    optional_params["nearest_node_to_center"] = level.sdBomb.nearest_node_for_camping;
    self bot_protect_point(level.sdBomb.curorigin, level.protect_radius, optional_params);
  }
}

defender_update() {
  self endon("new_role");

  if(!self bot_is_defending_point(self.defend_zone.curorigin)) {
    optional_params["score_flags"] = "strict_los";
    optional_params["override_origin_node"] = Random(self.defend_zone.botTargets);
    self bot_protect_point(self.defend_zone.curorigin, level.protect_radius, optional_params);
  }
}

backstabber_update() {
  self endon("new_role");

  if(self bot_is_defending())
    self bot_defend_stop();

  if(!isDefined(self.backstabber_stage))
    self.backstabber_stage = "1_move_to_midpoint";

  if(self.backstabber_stage == "1_move_to_midpoint") {
    bz_0_origin = level.bombZones[0].curorigin;
    bz_1_origin = level.bombZones[1].curorigin;
    midpoint = ((bz_0_origin[0] + bz_1_origin[0]) * 0.5, (bz_0_origin[1] + bz_1_origin[1]) * 0.5, (bz_0_origin[2] + bz_1_origin[2]) * 0.5);

    nodes = GetNodesInRadiusSorted(midpoint, 512, 0);
    if(nodes.size == 0) {
      self bot_set_role("random_killer");
      return;
    }

    node_picked = undefined;
    total_weights = INT((nodes.size) * (nodes.size + 1) * 0.5);
    random_num_picked = RandomInt(total_weights);
    for(i = 0; i < nodes.size; i++) {
      node_weight = (nodes.size - i);
      if(random_num_picked < node_weight) {
        node_picked = nodes[i];
        break;
      }
      random_num_picked -= node_weight;
    }

    self BotSetPathingStyle("scripted");
    set_goal = self BotSetScriptGoalNode(node_picked, "guard");
    if(set_goal) {
      pathResult = self bot_waittill_goal_or_fail();
      if(pathResult == "goal") {
        wait(RandomFloatRange(1.0, 4.0));
        self.backstabber_stage = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self.backstabber_stage == "2_move_to_enemy_spawn") {
    attacker_spawns = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_sd_spawn_attacker");
    spawn_target = Random(attacker_spawns);

    self BotSetPathingStyle("scripted");
    set_goal = self BotSetScriptGoal(spawn_target.origin, 250, "guard");
    if(set_goal) {
      pathResult = self bot_waittill_goal_or_fail();
      if(pathResult == "goal")
        self.backstabber_stage = "3_move_to_bombzone";
    }
  }

  if(self.backstabber_stage == "3_move_to_bombzone") {
    if(!isDefined(self.bombzone_num_picked))
      self.bombzone_num_picked = RandomInt(level.bombZones.size);

    self BotSetPathingStyle(undefined);
    set_goal = self BotSetScriptGoal(Random(level.bombZones[self.bombzone_num_picked].botTargets).origin, 160, "objective");
    if(set_goal) {
      pathResult = self bot_waittill_goal_or_fail();
      if(pathResult == "goal") {
        self BotClearScriptGoal();
        self.backstabber_stage = "2_move_to_enemy_spawn";
        self.bombzone_num_picked = 1 - self.bombzone_num_picked;
      }
    }
  }
}

random_killer_update() {
  self endon("new_role");

  if(self bot_is_defending())
    self bot_defend_stop();
  self[[self.personality_update_function]]();
}

set_force_sprint() {
  if(!isDefined(self.always_sprint)) {
    self BotSetFlag("force_sprint", true);
    self.always_sprint = true;
  }
}

disable_force_sprint() {
  if(isDefined(self.always_sprint)) {
    self BotSetFlag("force_sprint", false);
    self.always_sprint = undefined;
  }
}

set_scripted_pathing_style() {
  if(!isDefined(self.scripted_path_style)) {
    self BotSetPathingStyle("scripted");
    self.scripted_path_style = true;
  }
}

cautious_approach_till_close(target, label) {
  capture_radius = level.capture_radius;
  optional_params["entrance_points_index"] = label;
  self bot_capture_point(target, capture_radius, optional_params);

  wait(0.05);
  while(DistanceSquared(self.origin, target) > capture_radius * capture_radius && self bot_is_defending()) {
    if(get_round_end_time() - GetTime() < 20000) {
      self set_scripted_pathing_style();
      self set_force_sprint();
      break;
    }
    wait(0.05);
  }

  if(self bot_is_defending())
    self bot_defend_stop();
  return self BotSetScriptGoal(target, 20, "critical");
}

sd_press_use(time, self_end_notify, emergency_plant) {
  chance_to_prone = 0;
  if(self BotGetDifficultySetting("strategyLevel") == 1)
    chance_to_prone = 40;
  else if(self BotGetDifficultySetting("strategyLevel") >= 2)
    chance_to_prone = 80;

  if(RandomInt(100) < chance_to_prone) {
    self BotSetStance("prone");
    wait(0.2);
  }

  if(self BotGetDifficultySetting("strategyLevel") > 0 && !emergency_plant) {
    self thread notify_on_whizby();
    self thread notify_on_damage();
  }

  self BotPressButton("use", time);
  result = self bot_usebutton_wait(time, self_end_notify, "use_interrupted");
  self BotSetStance("none");
  self BotClearButton("use");

  succeeded = (result == self_end_notify);
  return succeeded;
}

notify_enemy_team_bomb_used(type) {
  players = get_living_players_on_team(get_enemy_team(self.team), true);
  foreach(player in players) {
    hearing_dist = 0;
    if(type == "plant")
      hearing_dist = 300 + (player BotGetDifficultySetting("strategyLevel") * 100);
    else if(type == "defuse")
      hearing_dist = 500 + (player BotGetDifficultySetting("strategyLevel") * 500);

    if(DistanceSquared(player.origin, self.origin) < squared(hearing_dist))
      player bot_set_role("investigate_someone_using_bomb");
  }
}

notify_on_whizby() {
  this_bombzone = find_closest_bombzone_to_player(self);
  self waittill("bulletwhizby", shooter);
  if(!isDefined(shooter.team) || shooter.team != self.team) {
    time_left = this_bombzone.useTime - this_bombzone.curProgress;
    if(time_left > 1000)
      self notify("use_interrupted");
  }
}

notify_on_damage() {
  self waittill("damage", amount, attacker);
  if(!isDefined(attacker.team) || attacker.team != self.team)
    self notify("use_interrupted");
}

should_start_cautious_approach_sd(firstCheck) {
  distance_start_cautiousness = 2000;
  distance_start_cautiousness_sq = distance_start_cautiousness * distance_start_cautiousness;

  if(firstCheck) {
    if(get_round_end_time() - GetTime() < 15000)
      return false;

    alive_enemies_exist = false;
    enemy_team = get_enemy_team(self.team);
    foreach(player in level.players) {
      if(!isDefined(player.team))
        continue;
      if(IsAlive(player) && player.team == enemy_team)
        alive_enemies_exist = true;
    }

    return alive_enemies_exist;
  } else {
    return (DistanceSquared(self.origin, self.bot_defending_center) <= distance_start_cautiousness_sq && self BotPursuingScriptGoal());
  }
}

find_closest_bombzone_to_player(player) {
  closest_zone = undefined;
  closest_zone_distSQ = 999999999;
  foreach(zone in level.bombZones) {
    distSQ = DistanceSquared(zone.curorigin, player.origin);
    if(distSQ < closest_zone_distSQ) {
      closest_zone = zone;
      closest_zone_distSQ = distSQ;
    }
  }

  return closest_zone;
}

get_players_defending_zone(zone) {
  actual_zone_defenders = [];
  possible_bomb_defenders = get_living_players_on_team(game["defenders"]);

  foreach(player in possible_bomb_defenders) {
    if(IsAI(player) && isDefined(player.role) && player.role == "defender") {
      if(isDefined(player.defend_zone) && player.defend_zone == zone)
        actual_zone_defenders = array_add(actual_zone_defenders, player);
    } else {
      if(DistanceSquared(player.origin, zone.curorigin) < level.protect_radius * level.protect_radius)
        actual_zone_defenders = array_add(actual_zone_defenders, player);
    }
  }

  return actual_zone_defenders;
}

find_ticking_bomb() {
  if(isDefined(level.tickingObject)) {
    foreach(zone in level.bombZones) {
      if(DistanceSquared(level.tickingObject.origin, zone.curorigin) < 300 * 300)
        return zone;
    }
  }

  return undefined;
}

get_specific_zone(zone_letter) {
  Assert(zone_letter == "A" || zone_letter == "B");
  zone_letter = "_" + ToLower(zone_letter);

  for(i = 0; i < level.bombZones.size; i++) {
    if(level.bombZones[i].label == zone_letter)
      return level.bombZones[i];
  }
}

bomber_wait_for_death() {
  self endon("stopped_being_bomb_carrier");
  self endon("new_role");

  self waittill_any("death", "disconnect");

  level.atk_bomber = undefined;
  level.last_atk_bomber_death_time = GetTime();

  if(isDefined(self))
    self.role = undefined;

  ai_attackers = get_living_players_on_team(game["attackers"], true);
  force_all_players_to_role(ai_attackers, undefined);
}

bomber_wait_for_bomb_reset() {
  self endon("death");
  self endon("disconnect");
  self endon("stopped_being_bomb_carrier");
  level.sdBomb endon("pickup_object");

  level.sdBomb waittill("reset");
  if(IsAITeamParticipant(self))
    self BotClearScriptGoal();
  self bot_set_role("atk_bomber");
}

set_new_bomber() {
  assert(IsTeamParticipant(self));

  level.atk_bomber = self;
  self bot_set_role("atk_bomber");
  self thread bomber_wait_for_death();
  if(!level.multiBomb)
    self thread bomber_wait_for_bomb_reset();

  if(IsAI(self)) {
    self bot_disable_tactical_goals();
    if(level.attack_behavior == "rush" && self BotGetDifficultySetting("strategyLevel") > 0)
      self set_force_sprint();
  }
}

initialize_sd_role() {
  if(self.team == game["attackers"]) {
    if(level.bombPlanted) {
      self bot_set_role("defend_planted_bomb");
    } else {
      if(!isDefined(level.atk_bomber)) {
        self set_new_bomber();
      } else {
        if(level.attack_behavior == "rush") {
          self bot_set_role("clear_target_zone");
        }
      }
    }
  } else {
    backstabbers = self get_players_by_role("backstabber");
    defenders = self get_players_by_role("defender");

    personality_type = level.bot_personality_type[self.personality];
    strategy_level = self BotGetDifficultySetting("strategyLevel");
    if(personality_type == "active") {
      if(!isDefined(self.role) && level.allow_backstabbers && strategy_level > 0) {
        if(backstabbers.size == 0) {
          self bot_set_role("backstabber");
        } else {
          all_backstabbers_are_stationary = true;
          foreach(stabber in backstabbers) {
            backstabber_pers_type = level.bot_personality_type[stabber.personality];
            if(backstabber_pers_type == "active") {
              all_backstabbers_are_stationary = false;
              break;
            }
          }

          if(all_backstabbers_are_stationary) {
            self bot_set_role("backstabber");
            backstabbers[0] bot_set_role(undefined);
          }
        }
      }

      if(!isDefined(self.role)) {
        if(defenders.size < 4)
          self bot_set_role("defender");
      }

      if(!isDefined(self.role)) {
        random_choice = RandomInt(4);
        if(random_choice == 3 && level.allow_random_killers && strategy_level > 0)
          self bot_set_role("random_killer");
        else if(random_choice == 2 && level.allow_backstabbers && strategy_level > 0)
          self bot_set_role("backstabber");
        else
          self bot_set_role("defender");
      }
    } else if(personality_type == "stationary") {
      if(!isDefined(self.role)) {
        if(defenders.size < 4) {
          self bot_set_role("defender");
        } else {
          foreach(defender in defenders) {
            defender_pers_type = level.bot_personality_type[defender.personality];
            if(defender_pers_type == "active") {
              self bot_set_role("defender");
              defender bot_set_role(undefined);
              break;
            }
          }
        }
      }

      if(!isDefined(self.role) && level.allow_backstabbers && strategy_level > 0) {
        if(backstabbers.size == 0)
          self bot_set_role("backstabber");
      }

      if(!isDefined(self.role)) {
        self bot_set_role("defender");
      }
    }

    if(self.role == "defender") {
      Assert(level.bombZones.size == 2);

      possible_zones = level.bombZones;
      if(has_override_zone_targets(self.team))
        possible_zones = get_override_zone_targets(self.team);

      if(possible_zones.size == 1) {
        self.defend_zone = possible_zones[0];
      } else {
        players_at_zone_0 = get_players_defending_zone(possible_zones[0]);
        players_at_zone_1 = get_players_defending_zone(possible_zones[1]);

        if(players_at_zone_0.size < players_at_zone_1.size)
          self.defend_zone = possible_zones[0];
        else if(players_at_zone_1.size < players_at_zone_0.size)
          self.defend_zone = possible_zones[1];
        else
          self.defend_zone = Random(possible_zones);
      }
    }
  }
}

bot_set_role(new_role) {
  if(IsAI(self)) {
    self bot_defend_stop();
    self BotSetPathingStyle(undefined);
  }
  self.prev_role = self.role;
  self.role = new_role;
  self notify("new_role");
}

bot_set_role_delayed(new_role, wait_time) {
  self endon("death");
  self endon("disconnect");
  self endon("new_role");

  wait(wait_time);
  self bot_set_role(new_role);
}

force_all_players_to_role(players, role, max_random_wait_time) {
  foreach(player in players) {
    if(isDefined(max_random_wait_time))
      player thread bot_set_role_delayed(role, RandomFloatRange(0.0, max_random_wait_time));
    else
      player thread bot_set_role(role);
  }
}

get_override_zone_targets(team) {
  return level.bot_sd_override_zone_targets[team];
}

has_override_zone_targets(team) {
  override_targets = get_override_zone_targets(team);
  return (override_targets.size > 0);
}

get_players_by_role(role) {
  players = [];
  foreach(player in level.participants) {
    if(IsAlive(player) && IsTeamParticipant(player) && isDefined(player.role) && player.role == role)
      players[players.size] = player;
  }

  return players;
}

get_living_players_on_team(team, only_ai_with_roles) {
  players = [];
  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(isReallyAlive(player) && IsTeamParticipant(player) && player.team == team) {
      if(!isDefined(only_ai_with_roles) || (only_ai_with_roles && IsAI(player) && isDefined(player.role)))
        players[players.size] = player;
    }
  }

  return players;
}

bot_sd_ai_director_update() {
  level notify("bot_sd_ai_director_update");
  level endon("bot_sd_ai_director_update");
  level endon("game_ended");

  level.allow_backstabbers = (RandomInt(3) <= 1);
  level.allow_random_killers = (RandomInt(3) <= 1);

  level.attack_behavior = "rush";

  level.protect_radius = 725;
  level.capture_radius = 140;

  while(1) {
    if(isDefined(level.sdBomb) && isDefined(level.sdBomb.carrier) && !IsAI(level.sdBomb.carrier)) {
      level.bomb_zone_assaulting = find_closest_bombzone_to_player(level.sdBomb.carrier);
    }

    set_new_bomber_this_update = false;
    if(!level.bombPlanted) {
      living_attackers = get_living_players_on_team(game["attackers"]);
      foreach(player in living_attackers) {
        if(player.isBombCarrier) {
          level.can_pickup_bomb_time = GetTime();
          if(!isDefined(level.atk_bomber) || player != level.atk_bomber) {
            if(isDefined(level.atk_bomber) && IsAlive(level.atk_bomber)) {
              level.atk_bomber bot_set_role(undefined);
              level.atk_bomber notify("stopped_being_bomb_carrier");
            }

            set_new_bomber_this_update = true;
            player set_new_bomber();
          }
        }
      }

      if(!level.multiBomb && !isDefined(level.sdBomb.carrier)) {
        node_nearest_bomb = GetClosestNodeInSight(level.sdBomb.curorigin);
        if(isDefined(node_nearest_bomb)) {
          level.sdBomb.nearest_node_for_camping = node_nearest_bomb;
          bomb_visible_to_defender = false;
          all_defending_ai = get_living_players_on_team(game["defenders"], true);
          foreach(ai in all_defending_ai) {
            nearest_node_bot = ai GetNearestNode();
            strategy_level = ai BotGetDifficultySetting("strategyLevel");
            if(strategy_level > 0 && ai.role != "camp_bomb" && isDefined(nearest_node_bot) && NodesVisible(node_nearest_bomb, nearest_node_bot, true)) {
              bot_fov = ai BotGetFovDot();
              if(within_fov(ai.origin, ai.angles, level.sdBomb.curorigin, bot_fov)) {
                if(strategy_level >= 2 || DistanceSquared(ai.origin, level.sdBomb.curorigin) < squared(700)) {
                  bomb_visible_to_defender = true;
                  break;
                }
              }
            }
          }

          if(bomb_visible_to_defender) {
            foreach(ai in all_defending_ai) {
              if(ai.role != "camp_bomb" && ai BotGetDifficultySetting("strategyLevel") > 0)
                ai bot_set_role("camp_bomb");
            }
          }
        }
      }

      possible_zones = level.bombZones;
      if(has_override_zone_targets(game["defenders"]))
        possible_zones = get_override_zone_targets(game["defenders"]);

      for(i = 0; i < possible_zones.size; i++) {
        for(j = 0; j < possible_zones.size; j++) {
          players_defending_i = get_players_defending_zone(possible_zones[i]);
          players_defending_j = get_players_defending_zone(possible_zones[j]);
          if(players_defending_i.size > players_defending_j.size + 1) {
            ai_players_defending_i = [];
            foreach(player in players_defending_i) {
              if(IsAI(player))
                ai_players_defending_i = array_add(ai_players_defending_i, player);
            }

            if(ai_players_defending_i.size > 0) {
              defender = Random(ai_players_defending_i);
              defender bot_defend_stop();
              defender.defend_zone = possible_zones[j];
            }
          }
        }
      }
    } else {
      if(isDefined(level.atk_bomber))
        level.atk_bomber = undefined;

      if(!isDefined(level.bomb_defuser) || !IsAlive(level.bomb_defuser)) {
        possible_defusers = [];
        defenders = self get_players_by_role("defender");
        backstabbers = self get_players_by_role("backstabber");
        random_killers = self get_players_by_role("random_killer");

        if(defenders.size > 0)
          possible_defusers = defenders;
        else if(backstabbers.size > 0)
          possible_defusers = backstabbers;
        else if(random_killers.size > 0)
          possible_defusers = random_killers;

        if(possible_defusers.size > 0) {
          possible_defusers_sorted = get_array_of_closest(level.sdBombModel.origin, possible_defusers);
          level.bomb_defuser = possible_defusers_sorted[0];
          level.bomb_defuser bot_set_role("bomb_defuser");
          level.bomb_defuser bot_disable_tactical_goals();
          level.bomb_defuser thread defuser_wait_for_death();
        }
      }

      if(!isDefined(level.sd_bomb_just_planted)) {
        level.sd_bomb_just_planted = true;

        attackers = get_living_players_on_team(game["attackers"]);
        foreach(player in attackers) {
          if(isDefined(player.role)) {
            if(player.role == "atk_bomber")
              player thread bot_set_role(undefined);
            else if(player.role != "defend_planted_bomb")
              player thread bot_set_role_delayed("defend_planted_bomb", RandomFloatRange(0.0, 3.0));
          }
        }
      }
    }

    if(!level.multiBomb && !level.bombPlanted && (!isDefined(level.last_atk_bomber_death_time) || GetTime() - level.last_atk_bomber_death_time > 300)) {
      attackers = get_living_players_on_team(game["attackers"]);
      if(attackers.size > 0) {
        carriers = [];
        atk_bomber_roles = [];
        should_check_role = false;
        foreach(player in attackers) {
          if(isDefined(player.has_started_thinking) && player.has_started_thinking)
            should_check_role = true;

          if(IsTeamParticipant(player)) {
            if(player.isBombCarrier)
              carriers[carriers.size] = player;

            if(isDefined(player.role) && player.role == "atk_bomber")
              atk_bomber_roles[atk_bomber_roles.size] = player;
          }
        }

        if(should_check_role) {
          if(atk_bomber_roles.size != 1)
            AssertMsg("No attackers chosen to plant bomb. atk_bomber_roles.size: " + atk_bomber_roles.size + ", Living Attackers: " + attackers.size);
          else
            Assert(atk_bomber_roles[0] == level.atk_bomber);
        }

        Assert(carriers.size <= 1);
        if(carriers.size == 1) {
          Assert(isDefined(atk_bomber_roles[0]));
          Assert(carriers[0] == level.sdBomb.carrier);
          Assert(carriers[0] == atk_bomber_roles[0]);
        }
      }
    }

    wait(0.5);
  }
}

defuser_wait_for_death() {
  self waittill_any("death", "disconnect");

  level.bomb_defuser = undefined;
}