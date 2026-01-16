/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_dom.gsc
*********************************************/

main() {
  setup_callbacks();
  setup_bot_dom();
  level thread scripts\mp\bots\_bots_util::bot_monitor_enemy_camp_spots(scripts\mp\bots\_bots_util::bot_valid_camp_assassin);
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_dom_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_dom;
  level.bot_funcs["leader_dialog"] = ::bot_dom_leader_dialog;
  level.bot_funcs["get_watch_node_chance"] = ::bot_dom_get_node_chance;
  level.bot_funcs["commander_gametype_tactics"] = ::bot_dom_apply_commander_tactics;
}

bot_is_assigned_location(var_0) {
  var_1 = 90000;
  if(scripts\mp\bots\_bots_util::bot_is_defending() && distance2dsquared(var_0, self.bot_defending_center) < var_1) {
    return 1;
  }

  if(self bothasscriptgoal()) {
    var_2 = self botgetscriptgoal();
    if(distance2dsquared(var_0, var_2) < var_1) {
      return 1;
    }
  }

  return 0;
}

crate_can_use_smartglass(var_0) {
  if(isagent(self)) {
    if(!isDefined(level.smartglass_commander) || self.owner != level.smartglass_commander) {
      return crate_can_use();
    }

    if(!isDefined(var_0.boxtype) && scripts\mp\bots\_bots_util::bot_crate_is_command_goal(var_0)) {
      return bot_is_assigned_location(var_0.origin);
    }

    return 0;
  }

  return crate_can_use(var_0);
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return 0;
  }

  if(!scripts\mp\utility::isteamparticipant(self)) {
    return 1;
  }

  return scripts\mp\bots\_bots_util::bot_is_protecting();
}

bot_dom_apply_commander_tactics(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "tactic_none":
      level.bot_dom_override_flag_targets[self.team] = [];
      var_1 = 1;
      break;

    case "tactic_dom_holdA":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      var_1 = 1;
      break;

    case "tactic_dom_holdB":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("B");
      var_1 = 1;
      break;

    case "tactic_dom_holdC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("C");
      var_1 = 1;
      break;

    case "tactic_dom_holdAB":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("B");
      var_1 = 1;
      break;

    case "tactic_dom_holdBC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("B");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("C");
      var_1 = 1;
      break;

    case "tactic_dom_holdAC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("C");
      var_1 = 1;
      break;

    case "tactic_dom_holdABC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("B");
      level.bot_dom_override_flag_targets[self.team][2] = get_specific_flag("C");
      var_1 = 1;
      break;
  }

  if(var_1) {
    foreach(var_3 in level.participants) {
      if(!isDefined(var_3.team)) {
        continue;
      }

      if(scripts\mp\utility::isaiteamparticipant(var_3) && var_3.team == self.team) {
        var_3.force_new_goal = 1;
      }
    }
  }
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(1);
    var_0 = self.useobj scripts\mp\gameobjects::getownerteam();
    if(var_0 != "neutral") {
      var_1 = getzonenearest(self.origin);
      if(isDefined(var_1)) {
        botzonesetteam(var_1, var_0);
      }
    }
  }
}

monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var_0 = self.useobj scripts\mp\gameobjects::getownerteam();
  for(;;) {
    var_1 = self.useobj scripts\mp\gameobjects::getownerteam();
    if(var_1 != var_0) {
      level notify("flag_changed_ownership");
    }

    var_0 = var_1;
    wait(0.05);
  }
}

setup_bot_dom() {
  var_0 = bot_get_all_possible_flags();
  if(var_0.size > 3) {
    while(!isDefined(level.teleport_dom_finished_initializing)) {
      wait(0.05);
    }

    var_1 = [];
    foreach(var_3 in var_0) {
      if(!isDefined(var_1[var_3.teleport_zone])) {
        var_1[var_3.teleport_zone] = [];
      }

      var_1[var_3.teleport_zone] = ::scripts\engine\utility::array_add(var_1[var_3.teleport_zone], var_3);
    }

    foreach(var_7, var_6 in var_1) {
      level.entrance_points_finished_caching = 0;
      bot_cache_flag_distances(var_6);
      scripts\mp\bots\_bots_util::bot_cache_entrances_to_flags_or_radios(var_6, var_7 + "_flag");
    }
  } else {
    scripts\mp\bots\_bots_util::bot_cache_entrances_to_flags_or_radios(var_0, "flag");
    bot_cache_flag_distances(var_0);
  }

  foreach(var_3 in var_0) {
    var_3 thread monitor_zone_control();
    var_3 thread monitor_flag_ownership();
    if(var_3.script_label != "_a" && var_3.script_label != "_b" && var_3.script_label != "_c") {}

    var_3.nodes = getnodesintrigger(var_3);
    add_missing_nodes(var_3);
  }

  level.bot_dom_override_flag_targets = [];
  level.bot_dom_override_flag_targets["axis"] = [];
  level.bot_dom_override_flag_targets["allies"] = [];
  level.bot_gametype_precaching_done = 1;
}

bot_get_all_possible_flags() {
  if(isDefined(level.all_dom_flags)) {
    return level.all_dom_flags;
  }

  return level.magicbullet;
}

bot_cache_flag_distances(var_0) {
  if(!isDefined(level.flag_distances)) {
    level.flag_distances = [];
  }

  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for(var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
      var_3 = distance(var_0[var_1].origin, var_0[var_2].origin);
      var_4 = get_flag_label(var_0[var_1]);
      var_5 = get_flag_label(var_0[var_2]);
      level.flag_distances[var_4][var_5] = var_3;
      level.flag_distances[var_5][var_4] = var_3;
    }
  }
}

add_missing_nodes(var_0) {
  if(var_0.classname == "trigger_radius") {
    var_1 = getnodesinradius(var_0.origin, var_0.fgetarg, 0, 100);
    var_2 = scripts\engine\utility::array_remove_array(var_1, var_0.nodes);
    if(var_2.size > 0) {
      var_0.nodes = scripts\engine\utility::array_combine(var_0.nodes, var_2);
      return;
    }

    return;
  }

  if(var_0.classname == "trigger_multiple") {
    var_3[0] = var_0 getpointinbounds(1, 1, 1);
    var_3[1] = var_0 getpointinbounds(1, 1, -1);
    var_3[2] = var_0 getpointinbounds(1, -1, 1);
    var_3[3] = var_0 getpointinbounds(1, -1, -1);
    var_3[4] = var_0 getpointinbounds(-1, 1, 1);
    var_3[5] = var_0 getpointinbounds(-1, 1, -1);
    var_3[6] = var_0 getpointinbounds(-1, -1, 1);
    var_3[7] = var_0 getpointinbounds(-1, -1, -1);
    var_4 = 0;
    foreach(var_6 in var_3) {
      var_7 = distance(var_6, var_0.origin);
      if(var_7 > var_4) {
        var_4 = var_7;
      }
    }

    var_1 = getnodesinradius(var_0.origin, var_4, 0, 100);
    foreach(var_10 in var_1) {
      if(!ispointinvolume(var_10.origin, var_0)) {
        if(ispointinvolume(var_10.origin + (0, 0, 40), var_0) || ispointinvolume(var_10.origin + (0, 0, 80), var_0) || ispointinvolume(var_10.origin + (0, 0, 120), var_0)) {
          var_0.nodes = scripts\engine\utility::array_add(var_0.nodes, var_10);
        }
      }
    }
  }
}

should_start_cautious_approach_dom(var_0) {
  if(var_0) {
    if(self.current_flag.useobj scripts\mp\gameobjects::getownerteam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      var_1 = get_closest_flag(self.lastspawnpoint.origin);
      if(var_1 == self.current_flag) {
        return 0;
      } else {
        var_2 = get_other_flag(var_1, self.current_flag);
        var_3 = distancesquared(var_1.origin, self.current_flag.origin);
        var_4 = distancesquared(var_2.origin, self.current_flag.origin);
        if(var_3 < var_4) {
          return 0;
        }
      }
    }
  }

  return scripts\mp\bots\_bots_strategy::should_start_cautious_approach_default(var_0);
}

bot_dom_debug_should_capture_all() {
  return 0;
}

bot_dom_debug_should_protect_all() {
  return 0;
}

bot_dom_think() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  for(;;) {
    scripts\mp\bots\_bots_util::bot_update_camp_assassin();
    var_0 = gettime();
    if(var_0 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(var_0 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision()) {
        self.new_goal_time = var_0 + 5000;
      } else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var_0 + randomintrange(30000, -20536);
      }
    }

    scripts\engine\utility::waittill_notify_or_timeout("needs_new_flag_goal", 1);
  }
}

should_delay_flag_decision() {
  if(self.force_new_goal) {
    return 0;
  }

  if(!scripts\mp\bots\_bots_util::bot_is_capturing()) {
    return 0;
  }

  if(self.current_flag.useobj scripts\mp\gameobjects::getownerteam() == self.team) {
    return 0;
  }

  var_0 = get_flag_capture_radius();
  if(distancesquared(self.origin, self.current_flag.origin) < var_0 * 2 * var_0 * 2) {
    var_1 = get_ally_flags(self.team);
    if(var_1.size == 2 && !scripts\engine\utility::array_contains(var_1, self.current_flag) && !bot_allowed_to_3_cap()) {
      return 0;
    }

    return 1;
  }

  return 0;
}

get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

has_override_flag_targets() {
  var_0 = get_override_flag_targets();
  return var_0.size > 0;
}

flag_has_been_captured_before(var_0) {
  return !flag_has_never_been_captured(var_0);
}

flag_has_never_been_captured(var_0) {
  return var_0.useobj.firstcapture;
}

bot_choose_flag() {
  var_0 = undefined;
  var_1 = [];
  var_2 = [];
  var_3 = 1;
  var_4 = get_override_flag_targets();
  if(var_4.size > 0) {
    var_5 = var_4;
  } else {
    var_5 = level.magicbullet;
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6].useobj scripts\mp\gameobjects::getownerteam();
    if(var_3) {
      if(flag_has_been_captured_before(var_5[var_6])) {
        var_3 = 0;
      }
    }

    if(var_7 != self.team) {
      var_1[var_1.size] = var_5[var_6];
      continue;
    }

    var_2[var_2.size] = var_5[var_6];
  }

  var_8 = undefined;
  if(var_1.size == 3) {
    var_8 = 1;
  } else if(var_1.size == 2) {
    if(var_2.size == 1) {
      if(!bot_should_defend_flag(var_2[0], 1)) {
        var_8 = 1;
      } else {
        var_8 = !bot_should_defend(0.34);
      }
    } else if(var_2.size == 0) {
      var_8 = 1;
    }
  } else if(var_1.size == 1) {
    if(var_2.size == 2) {
      if(bot_allowed_to_3_cap()) {
        if(!bot_should_defend_flag(var_2[0], 2) && !bot_should_defend_flag(var_2[1], 2)) {
          var_8 = 1;
        } else if(self.strategy_level == 0) {
          var_8 = !bot_should_defend(0.34);
        } else {
          var_8 = !bot_should_defend(0.5);
        }
      } else {
        var_8 = 0;
      }
    } else if(var_2.size == 1) {
      if(!bot_should_defend_flag(var_2[0], 1)) {
        var_8 = 1;
      } else {
        var_8 = !bot_should_defend(0.34);
      }
    } else if(var_2.size == 0) {
      var_8 = 1;
    }
  } else if(var_1.size == 0) {
    var_8 = 0;
  }

  if(var_8) {
    if(var_1.size > 1) {
      var_9 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);
    } else {
      var_9 = var_2;
    }

    if(var_3 && !has_override_flag_targets()) {
      var_10 = get_num_allies_capturing_flag(var_9[0], 1);
      if(var_10 < 2) {
        var_11 = 0;
      } else {
        var_12 = 20;
        var_13 = 65;
        var_14 = 15;
        if(self.strategy_level == 0) {
          var_12 = 50;
          var_13 = 25;
          var_14 = 25;
        }

        var_15 = randomint(100);
        if(var_15 < var_12) {
          var_11 = 0;
        } else if(var_15 < var_12 + var_13) {
          var_11 = 1;
        } else {
          var_11 = 2;
        }
      }

      var_10 = undefined;
      if(var_11 == 0) {
        var_10 = "critical";
      }

      capture_flag(var_9[var_11], var_10);
      return;
    }

    if(var_10.size == 1) {
      var_3 = var_10[0];
    } else if(distancesquared(var_10[0].origin, self.origin) < 102400) {
      var_3 = var_10[0];
    } else {
      var_11 = [];
      var_12 = [];
      for(var_9 = 0; var_9 < var_10.size; var_9++) {
        var_13 = distance(var_10[var_9].origin, self.origin);
        var_12[var_9] = var_13;
        var_11[var_9] = var_13;
      }

      if(var_5.size == 1) {
        var_14 = 1.5;
        for(var_9 = 0; var_9 < var_11.size; var_9++) {
          var_11[var_9] = var_11[var_9] + level.flag_distances[get_flag_label(var_10[var_9])][get_flag_label(var_5[0])] * var_14;
        }
      }

      if(self.strategy_level == 0) {
        var_15 = randomint(100);
        if(var_15 < 50) {
          var_3 = var_10[0];
        } else if(var_15 < 50 + 50 / var_10.size - 1) {
          var_3 = var_10[1];
        } else {
          var_3 = var_10[2];
        }
      } else if(var_11.size == 2) {
        var_15[0] = 50;
        var_15[1] = 50;
        for(var_9 = 0; var_9 < var_10.size; var_9++) {
          if(var_11[var_9] < var_11[1 - var_9]) {
            var_15[var_9] = var_15[var_9] + 20;
            var_15[1 - var_9] = var_15[1 - var_9] - 20;
          }

          if(var_12[var_9] < 640) {
            var_15[var_9] = var_15[var_9] + 15;
            var_15[1 - var_9] = var_15[1 - var_9] - 15;
          }

          if(var_10[var_9].useobj scripts\mp\gameobjects::getownerteam() == "neutral") {
            var_15[var_9] = var_15[var_9] + 15;
            var_15[1 - var_9] = var_15[1 - var_9] - 15;
          }
        }

        var_15 = randomint(100);
        if(var_15 < var_15[0]) {
          var_3 = var_10[0];
        } else {
          var_3 = var_10[1];
        }
      } else if(var_11.size == 3) {
        var_15[0] = 34;
        var_15[1] = 33;
        var_15[2] = 33;
        for(var_9 = 0; var_9 < var_10.size; var_9++) {
          var_16 = var_9 + 1 % 3;
          var_17 = var_9 + 2 % 3;
          if(var_11[var_9] < var_11[var_16] && var_11[var_9] < var_11[var_17]) {
            var_15[var_9] = var_15[var_9] + 36;
            var_15[var_16] = var_15[var_16] - 18;
            var_15[var_17] = var_15[var_17] - 18;
          }

          if(var_12[var_9] < 640) {
            var_15[var_9] = var_15[var_9] + 15;
            var_15[var_16] = var_15[var_16] - 7;
            var_15[var_17] = var_15[var_17] - 8;
          }

          if(var_10[var_9].useobj scripts\mp\gameobjects::getownerteam() == "neutral") {
            var_15[var_9] = var_15[var_9] + 15;
            var_15[var_16] = var_15[var_16] - 7;
            var_15[var_17] = var_15[var_17] - 8;
          }
        }

        var_15 = randomint(100);
        if(var_15 < var_15[0]) {
          var_3 = var_10[0];
        } else if(var_15 < var_15[0] + var_15[1]) {
          var_3 = var_10[1];
        } else {
          var_3 = var_10[2];
        }
      }
    }
  } else {
    if(var_5.size > 1) {
      var_18 = scripts\engine\utility::get_array_of_closest(self.origin, var_5);
    } else {
      var_18 = var_6;
    }

    foreach(var_1A in var_18) {
      if(bot_should_defend_flag(var_1A, var_5.size)) {
        var_3 = var_1A;
        break;
      }
    }

    if(!isDefined(var_3)) {
      if(self.strategy_level == 0) {
        var_3 = var_5[0];
      } else if(var_18.size == 2) {
        var_1C = get_other_flag(var_18[0], var_18[1]);
        var_1D = scripts\engine\utility::get_array_of_closest(var_1C.origin, var_18);
        var_15 = randomint(100);
        if(var_15 < 70) {
          var_3 = var_1D[0];
        } else {
          var_3 = var_1D[1];
        }
      } else {
        var_3 = var_18[0];
      }
    }
  }

  if(var_11) {
    capture_flag(var_3);
    return;
  }

  defend_flag(var_3);
}

bot_allowed_to_3_cap() {
  if(self.strategy_level == 0) {
    return 1;
  }

  var_0 = get_override_flag_targets();
  if(var_0.size == 3) {
    return 1;
  }

  var_1 = scripts\mp\gamescore::_getteamscore(scripts\engine\utility::get_enemy_team(self.team));
  var_2 = scripts\mp\gamescore::_getteamscore(self.team);
  var_3 = 200 - var_1;
  var_4 = 200 - var_2;
  var_5 = var_4 * 0.5 > var_3;
  return var_5;
}

bot_should_defend(var_0) {
  if(randomfloat(1) < var_0) {
    return 1;
  }

  var_1 = level.bot_personality_type[self.personality];
  if(var_1 == "stationary") {
    return 1;
  } else if(var_1 == "active") {
    return 0;
  }
}

capture_flag(var_0, var_1, var_2) {
  self.current_flag = var_0;
  if(bot_dom_debug_should_protect_all()) {
    var_3["override_goal_type"] = var_1;
    var_3["entrance_points_index"] = get_flag_label(var_0);
    scripts\mp\bots\_bots_strategy::bot_protect_point(var_0.origin, get_flag_protect_radius(), var_3);
  } else {
    var_0["override_goal_type"] = var_2;
    var_3["entrance_points_index"] = get_flag_label(var_0);
    scripts\mp\bots\_bots_strategy::bot_capture_zone(var_0.origin, var_0.nodes, var_0, var_3);
  }

  if(!isDefined(var_2) || !var_2) {
    thread monitor_flag_status(var_0);
  }
}

defend_flag(var_0) {
  self.current_flag = var_0;
  if(bot_dom_debug_should_capture_all()) {
    var_1["entrance_points_index"] = get_flag_label(var_0);
    scripts\mp\bots\_bots_strategy::bot_capture_zone(var_0.origin, var_0.nodes, var_0, var_1);
  } else {
    var_0["entrance_points_index"] = get_flag_label(var_1);
    var_1["nearest_node"] = var_0.nearest_node;
    scripts\mp\bots\_bots_strategy::bot_protect_point(var_0.origin, get_flag_protect_radius(), var_1);
  }

  thread monitor_flag_status(var_0);
}

get_flag_capture_radius() {
  if(!isDefined(level.capture_radius)) {
    level.capture_radius = 158;
  }

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = var_0[0] + var_0[1] / 2;
    level.protect_radius = min(1000, var_1 / 3.5);
  }

  return level.protect_radius;
}

bot_dom_leader_dialog(var_0, var_1) {
  if(issubstr(var_0, "losing")) {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_3 = undefined;
    for(var_4 = 0; var_4 < level.magicbullet.size; var_4++) {
      if(var_2 == level.magicbullet[var_4].script_label) {
        var_3 = level.magicbullet[var_4];
      }
    }

    if(isDefined(var_3) && bot_allow_to_capture_flag(var_3)) {
      self botmemoryevent("known_enemy", undefined, var_3.origin);
      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\_bots_util::bot_is_protecting()) {
          if(distancesquared(self.origin, var_3.origin) < 490000) {
            capture_flag(var_3);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  }

  scripts\mp\bots\_bots_util::bot_leader_dialog(var_0, var_1);
}

bot_allow_to_capture_flag(var_0) {
  var_1 = get_override_flag_targets();
  if(var_1.size == 0) {
    return 1;
  }

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 1;
  }

  return 0;
}

monitor_flag_status(var_0) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = get_num_ally_flags(self.team);
  var_2 = get_flag_capture_radius() * get_flag_capture_radius();
  var_3 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
  var_4 = 1;
  while(var_4) {
    var_5 = 0;
    var_6 = var_0.useobj scripts\mp\gameobjects::getownerteam();
    var_7 = get_num_ally_flags(self.team);
    var_8 = get_enemy_flags(self.team);
    if(scripts\mp\bots\_bots_util::bot_is_capturing()) {
      if(var_6 == self.team && var_0.useobj.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all()) {
          var_5 = 1;
        }
      }

      if(var_7 == 2 && var_6 != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, var_0.origin) > var_2) {
          var_5 = 1;
        }
      }

      foreach(var_10 in var_8) {
        if(var_10 != var_0 && bot_allow_to_capture_flag(var_10)) {
          if(distancesquared(self.origin, var_10.origin) < var_3) {
            var_5 = 1;
          }
        }
      }

      if(self istouching(var_0) && var_0.useobj.userate <= 0) {
        if(self bothasscriptgoal()) {
          var_12 = self botgetscriptgoal();
          var_13 = self botgetscriptgoalradius();
          if(distancesquared(self.origin, var_12) < squared(var_13)) {
            var_14 = self getnearestnode();
            if(isDefined(var_14)) {
              var_15 = undefined;
              foreach(var_11 in var_0.nodes) {
                if(!nodesvisible(var_11, var_14)) {
                  var_15 = var_11.origin;
                  break;
                }
              }

              if(isDefined(var_15)) {
                self.defense_investigate_specific_point = var_15;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\_bots_util::bot_is_protecting()) {
      if(var_6 != self.team) {
        if(!bot_dom_debug_should_protect_all()) {
          var_5 = 1;
        }
      } else if(var_7 == 1 && var_1 > 1) {
        var_5 = 1;
      }
    }

    var_1 = var_7;
    if(var_5) {
      self.force_new_goal = 1;
      var_4 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var_13 = level scripts\engine\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    if(!isDefined(var_13) && var_13 == "timeout") {
      var_14 = randomfloatrange(0.5, 1);
      wait(var_14);
    }
  }
}

bot_dom_get_node_chance(var_0) {
  if(var_0 == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!isDefined(self.current_flag)) {
    return 1;
  }

  var_1 = 0;
  var_2 = get_flag_label(self.current_flag);
  var_3 = get_ally_flags(self.team);
  foreach(var_5 in var_3) {
    if(var_5 != self.current_flag) {
      var_1 = var_0 scripts\mp\bots\_bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_5));
      if(var_1) {
        var_6 = get_other_flag(self.current_flag, var_5);
        var_7 = var_6.useobj scripts\mp\gameobjects::getownerteam();
        if(var_7 != self.team) {
          if(var_0 scripts\mp\bots\_bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_6))) {
            var_1 = 0;
          }
        }
      }
    }
  }

  if(var_1) {
    return 0.2;
  }

  return 1;
}

get_flag_label(var_0) {
  var_1 = "";
  if(isDefined(var_0.teleport_zone)) {
    var_1 = var_1 + var_0.teleport_zone + "_";
  }

  var_1 = var_1 + "flag" + var_0.script_label;
  return var_1;
}

get_other_flag(var_0, var_1) {
  for(var_2 = 0; var_2 < level.magicbullet.size; var_2++) {
    if(level.magicbullet[var_2] != var_0 && level.magicbullet[var_2] != var_1) {
      return level.magicbullet[var_2];
    }
  }
}

get_specific_flag(var_0) {
  var_0 = "_" + tolower(var_0);
  for(var_1 = 0; var_1 < level.magicbullet.size; var_1++) {
    if(level.magicbullet[var_1].script_label == var_0) {
      return level.magicbullet[var_1];
    }
  }
}

get_closest_flag(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  foreach(var_4 in level.magicbullet) {
    var_5 = distancesquared(var_4.origin, var_0);
    if(!isDefined(var_2) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

get_num_allies_capturing_flag(var_0, var_1) {
  var_2 = 0;
  var_3 = get_flag_capture_radius();
  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }

    if(var_5.team == self.team && var_5 != self && scripts\mp\utility::isteamparticipant(var_5)) {
      if(isai(var_5)) {
        if(var_5 bot_is_capturing_flag(var_0)) {
          var_2++;
        }

        continue;
      }

      if(!isDefined(var_1) || !var_1) {
        if(var_5 istouching(var_0)) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

bot_is_capturing_flag(var_0) {
  if(!scripts\mp\bots\_bots_util::bot_is_capturing()) {
    return 0;
  }

  return bot_target_is_flag(var_0);
}

bot_is_protecting_flag(var_0) {
  if(!scripts\mp\bots\_bots_util::bot_is_protecting()) {
    return 0;
  }

  return bot_target_is_flag(var_0);
}

bot_target_is_flag(var_0) {
  return isDefined(self.current_flag) && self.current_flag == var_0;
}

get_num_ally_flags(var_0) {
  var_1 = 0;
  for(var_2 = 0; var_2 < level.magicbullet.size; var_2++) {
    var_3 = level.magicbullet[var_2].useobj scripts\mp\gameobjects::getownerteam();
    if(var_3 == var_0) {
      var_1++;
    }
  }

  return var_1;
}

get_enemy_flags(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < level.magicbullet.size; var_2++) {
    var_3 = level.magicbullet[var_2].useobj scripts\mp\gameobjects::getownerteam();
    if(var_3 == scripts\engine\utility::get_enemy_team(var_0)) {
      var_1 = scripts\engine\utility::array_add(var_1, level.magicbullet[var_2]);
    }
  }

  return var_1;
}

get_ally_flags(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < level.magicbullet.size; var_2++) {
    var_3 = level.magicbullet[var_2].useobj scripts\mp\gameobjects::getownerteam();
    if(var_3 == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, level.magicbullet[var_2]);
    }
  }

  return var_1;
}

bot_should_defend_flag(var_0, var_1) {
  if(var_1 == 1) {
    var_2 = 1;
  } else {
    var_2 = 2;
  }

  var_3 = get_bots_defending_flag(var_0);
  return var_3.size < var_2;
}

get_bots_defending_flag(var_0) {
  var_1 = get_flag_protect_radius();
  var_2 = [];
  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(var_4.team == self.team && var_4 != self && scripts\mp\utility::isteamparticipant(var_4)) {
      if(isai(var_4)) {
        if(var_4 bot_is_protecting_flag(var_0)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_4);
        }

        continue;
      }

      if(distancesquared(var_0.origin, var_4.origin) < var_1 * var_1) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
      }
    }
  }

  return var_2;
}