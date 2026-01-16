/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_dom.gsc
***********************************************/

main() {
  level.bot_ignore_precalc_paths = 0;

  if(level.currentgen)
    level.bot_ignore_precalc_paths = 1;

  setup_callbacks();
  setup_bot_dom();
  level thread maps\mp\bots\_bots_util::bot_monitor_enemy_camp_spots(maps\mp\bots\_bots_util::bot_valid_camp_assassin);
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_dom_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_dom;
  level.bot_funcs["leader_dialog"] = ::bot_dom_leader_dialog;

  if(!level.bot_ignore_precalc_paths)
    level.bot_funcs["get_watch_node_chance"] = ::bot_dom_get_node_chance;
}

crate_can_use(var_0) {
  if(isagent(self) && !isdefined(var_0.boxtype))
    return 0;

  if(!maps\mp\_utility::isteamparticipant(self))
    return 1;

  return maps\mp\bots\_bots_util::bot_is_protecting();
}

monitor_flag_control() {
  self notify("monitor_flag_control");
  self endon("monitor_flag_control");
  self endon("death");
  level endon("game_ended");

  for (;;) {
    wait 1;
    var_0 = maps\mp\gametypes\dom::getflagteam();

    if(var_0 != "neutral") {
      var_1 = getzonenearest(self.origin);

      if(isdefined(var_1))
        botzonesetteam(var_1, var_0);
    }
  }
}

monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var_0 = maps\mp\gametypes\dom::getflagteam();

  for (;;) {
    var_1 = maps\mp\gametypes\dom::getflagteam();

    if(var_1 != var_0)
      level notify("flag_changed_ownership");

    var_0 = var_1;
    wait 0.05;
  }
}

setup_bot_dom() {
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
  var_0 = bot_get_all_possible_flags();

  if(var_0.size > 3) {
    while (!isdefined(level.teleport_dom_finished_initializing))
      wait 0.05;

    var_1 = [];

    foreach(var_3 in var_0) {
      if(!isdefined(var_1[var_3.teleport_zone]))
        var_1[var_3.teleport_zone] = [];

      var_1[var_3.teleport_zone] = common_scripts\utility::array_add(var_1[var_3.teleport_zone], var_3);
    }

    foreach(var_7, var_6 in var_1) {
      level.entrance_points_finished_caching = 0;
      bot_cache_flag_distances(var_6);
      maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(var_6, var_7 + "_flag", level.bot_ignore_precalc_paths);
    }
  } else {
    maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(var_0, "flag", level.bot_ignore_precalc_paths);
    bot_cache_flag_distances(var_0);
    thread bot_wait_for_event_flag_swap(var_0);
  }

  foreach(var_3 in var_0) {
    var_3 thread monitor_flag_control();
    var_3 thread monitor_flag_ownership();

    if(var_3.script_label != "_a" && var_3.script_label != "_b" && var_3.script_label != "_c") {

    }

    var_3.nodes = maps\mp\bots\_bots_gametype_common::bot_get_valid_nodes_in_trigger(var_3);
    var_3.last_time_secured["allies"] = 0;
    var_3.last_time_secured["axis"] = 0;
  }

  level.bot_dom_override_flag_targets = [];
  level.bot_dom_override_flag_targets["axis"] = [];
  level.bot_dom_override_flag_targets["allies"] = [];
  level.bot_gametype_precaching_done = 1;
}

bot_wait_for_event_flag_swap(var_0) {
  level endon("game_ended");
  level waittill("dom_flags_moved");
  maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(var_0, "flag", level.bot_ignore_precalc_paths, 1);
  bot_cache_flag_distances(var_0);

  foreach(var_2 in var_0)
  var_2.nodes = maps\mp\bots\_bots_gametype_common::bot_get_valid_nodes_in_trigger(var_2);

  foreach(var_5 in level.participants) {
    if(maps\mp\_utility::isaiteamparticipant(var_5))
      var_5.force_new_goal = 1;
  }
}

bot_get_all_possible_flags() {
  if(isdefined(level.all_dom_flags))
    return level.all_dom_flags;
  else
    return level.flags;
}

bot_cache_flag_distances(var_0) {
  if(!isdefined(level.flag_distances))
    level.flag_distances = [];

  for (var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for (var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
      var_3 = distance(var_0[var_1].origin, var_0[var_2].origin);
      var_4 = get_flag_label(var_0[var_1]);
      var_5 = get_flag_label(var_0[var_2]);
      level.flag_distances[var_4][var_5] = var_3;
      level.flag_distances[var_5][var_4] = var_3;
    }
  }
}

should_start_cautious_approach_dom(var_0) {
  if(var_0) {
    if(self.current_flag maps\mp\gametypes\dom::getflagteam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      var_1 = get_closest_flag(self.lastspawnpoint.origin);

      if(var_1 == self.current_flag)
        return 0;
      else {
        var_2 = get_other_flag(var_1, self.current_flag);
        var_3 = distancesquared(var_1.origin, self.current_flag.origin);
        var_4 = distancesquared(var_2.origin, self.current_flag.origin);

        if(var_3 < var_4)
          return 0;
      }
    }
  }

  return maps\mp\bots\_bots_strategy::should_start_cautious_approach_default(var_0);
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

  while (!isdefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);

  for (;;) {
    maps\mp\bots\_bots_util::bot_update_camp_assassin();
    var_0 = gettime();

    if(var_0 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(var_0 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision())
        self.new_goal_time = var_0 + 5000;
      else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var_0 + randomintrange(30000, 45000);
      }
    }

    common_scripts\utility::waittill_notify_or_timeout("needs_new_flag_goal", 1.0);
  }
}

should_delay_flag_decision() {
  if(self.force_new_goal)
    return 0;

  if(!maps\mp\bots\_bots_util::bot_is_capturing())
    return 0;

  if(self.current_flag maps\mp\gametypes\dom::getflagteam() == self.team)
    return 0;

  var_0 = get_flag_capture_radius();

  if(distancesquared(self.origin, self.current_flag.origin) < var_0 * 2 * (var_0 * 2)) {
    var_1 = get_ally_flags(self.team);

    if(var_1.size == 2 && !common_scripts\utility::array_contains(var_1, self.current_flag) && !bot_allowed_to_3_cap())
      return 0;

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

  if(var_4.size > 0)
    var_5 = var_4;
  else
    var_5 = level.flags;

  for (var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6] maps\mp\gametypes\dom::getflagteam();

    if(var_3) {
      if(flag_has_been_captured_before(var_5[var_6]))
        var_3 = 0;
      else {

      }
    }

    if(var_7 != self.team) {
      var_1[var_1.size] = var_5[var_6];
      continue;
    }

    var_2[var_2.size] = var_5[var_6];
  }

  var_8 = undefined;

  if(var_1.size == 3)
    var_8 = 1;
  else if(var_1.size == 2) {
    if(var_2.size == 1) {
      if(!bot_should_defend_flag(var_2[0], 1))
        var_8 = 1;
      else
        var_8 = !bot_should_defend(0.34);

      if(maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team) == 1)
        var_8 = 1;
    } else if(var_2.size == 0)
      var_8 = 1;
  } else if(var_1.size == 1) {
    if(var_2.size == 2) {
      if(bot_allowed_to_3_cap()) {
        if(!bot_should_defend_flag(var_2[0], 2) && !bot_should_defend_flag(var_2[1], 2))
          var_8 = 1;
        else if(self.strategy_level == 0)
          var_8 = !bot_should_defend(0.34);
        else
          var_8 = !bot_should_defend(0.5);
      } else
        var_8 = 0;
    } else if(var_2.size == 1) {
      if(!bot_should_defend_flag(var_2[0], 1))
        var_8 = 1;
      else
        var_8 = !bot_should_defend(0.34);
    } else if(var_2.size == 0)
      var_8 = 1;
  } else if(var_1.size == 0)
    var_8 = 0;

  if(var_8) {
    if(var_1.size > 1)
      var_9 = common_scripts\utility::get_array_of_closest(self.origin, var_1);
    else
      var_9 = var_1;

    if(var_3 && !has_override_flag_targets()) {
      var_10 = get_num_allies_capturing_flag(var_9[0], 1);

      if(var_10 < min_num_bots_assaulting_first_flag())
        var_11 = 0;
      else {
        var_12 = 20;
        var_13 = 65;
        var_14 = 15;

        if(self.strategy_level == 0) {
          var_12 = 50;
          var_13 = 25;
          var_14 = 25;
        } else if(self.strategy_level == 1) {
          var_12 = 40;
          var_13 = 40;
          var_14 = 20;
        }

        var_15 = randomint(100);

        if(var_15 < var_12)
          var_11 = 0;
        else if(var_15 < var_12 + var_13)
          var_11 = 1;
        else
          var_11 = 2;
      }

      var_16 = undefined;

      if(var_11 == 0)
        var_16 = "critical";

      capture_flag(var_9[var_11], var_16);
      return;
    }

    if(var_9.size == 1)
      var_0 = var_9[0];
    else if(distancesquared(var_9[0].origin, self.origin) < 102400)
      var_0 = var_9[0];
    else {
      var_17 = [];
      var_18 = [];

      for (var_6 = 0; var_6 < var_9.size; var_6++) {
        var_19 = distance(var_9[var_6].origin, self.origin);
        var_18[var_6] = var_19;
        var_17[var_6] = var_19;
      }

      if(var_2.size == 1) {
        var_20 = 1.5;

        for (var_6 = 0; var_6 < var_17.size; var_6++)
          var_17[var_6] = var_17[var_6] + level.flag_distances[get_flag_label(var_9[var_6])][get_flag_label(var_2[0])] * var_20;
      }

      if(self.strategy_level == 0) {
        var_15 = randomint(100);

        if(var_15 < 50)
          var_0 = var_9[0];
        else if(var_15 < 50 + 50 / (var_9.size - 1))
          var_0 = var_9[1];
        else
          var_0 = var_9[2];
      } else if(var_17.size == 2) {
        var_21[0] = 50;
        var_21[1] = 50;

        for (var_6 = 0; var_6 < var_9.size; var_6++) {
          if(var_17[var_6] < var_17[1 - var_6]) {
            var_21[var_6] = var_21[var_6] + 20;
            var_21[1 - var_6] = var_21[1 - var_6] - 20;
          }

          if(var_18[var_6] < 640) {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[1 - var_6] = var_21[1 - var_6] - 15;
          }

          if(var_9[var_6] maps\mp\gametypes\dom::getflagteam() == "neutral") {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[1 - var_6] = var_21[1 - var_6] - 15;
          }
        }

        var_15 = randomint(100);

        if(var_15 < var_21[0])
          var_0 = var_9[0];
        else
          var_0 = var_9[1];
      } else if(var_17.size == 3) {
        var_21[0] = 34;
        var_21[1] = 33;
        var_21[2] = 33;

        for (var_6 = 0; var_6 < var_9.size; var_6++) {
          var_22 = (var_6 + 1) % 3;
          var_23 = (var_6 + 2) % 3;

          if(var_17[var_6] < var_17[var_22] && var_17[var_6] < var_17[var_23]) {
            var_21[var_6] = var_21[var_6] + 36;
            var_21[var_22] = var_21[var_22] - 18;
            var_21[var_23] = var_21[var_23] - 18;
          }

          if(var_18[var_6] < 640) {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[var_22] = var_21[var_22] - 7;
            var_21[var_23] = var_21[var_23] - 8;
          }

          if(var_9[var_6] maps\mp\gametypes\dom::getflagteam() == "neutral") {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[var_22] = var_21[var_22] - 7;
            var_21[var_23] = var_21[var_23] - 8;
          }
        }

        var_15 = randomint(100);

        if(var_15 < var_21[0])
          var_0 = var_9[0];
        else if(var_15 < var_21[0] + var_21[1])
          var_0 = var_9[1];
        else
          var_0 = var_9[2];
      }
    }
  } else {
    if(var_2.size > 1)
      var_24 = common_scripts\utility::get_array_of_closest(self.origin, var_2);
    else
      var_24 = var_2;

    foreach(var_26 in var_24) {
      if(bot_should_defend_flag(var_26, var_2.size)) {
        var_0 = var_26;
        break;
      }
    }

    if(!isdefined(var_0)) {
      if(self.strategy_level == 0)
        var_0 = var_2[0];
      else if(var_24.size == 2) {
        var_28 = get_other_flag(var_24[0], var_24[1]);
        var_29 = common_scripts\utility::get_array_of_closest(var_28.origin, var_24);
        var_15 = randomint(100);

        if(var_15 < 70)
          var_0 = var_29[0];
        else
          var_0 = var_29[1];
      } else
        var_0 = var_24[0];
    }
  }

  if(var_8)
    capture_flag(var_0);
  else
    defend_flag(var_0);
}

min_num_bots_assaulting_first_flag() {
  var_0 = maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team);
  return ceil(var_0 / 3);
}

bot_allowed_to_3_cap() {
  if(self.strategy_level == 0)
    return 1;

  var_0 = get_override_flag_targets();

  if(var_0.size == 3)
    return 1;

  var_1 = maps\mp\gametypes\_gamescore::_getteamscore(common_scripts\utility::get_enemy_team(self.team));
  var_2 = maps\mp\gametypes\_gamescore::_getteamscore(self.team);
  var_3 = 200 - var_1;
  var_4 = 200 - var_2;
  var_5 = var_4 * 0.5 > var_3;
  return var_5;
}

bot_should_defend(var_0) {
  if(randomfloat(1) < var_0)
    return 1;

  var_1 = level.bot_personality_type[self.personality];

  if(var_1 == "stationary")
    return 1;
  else if(var_1 == "active")
    return 0;
}

capture_flag(var_0, var_1, var_2) {
  self.current_flag = var_0;

  if(bot_dom_debug_should_protect_all()) {
    var_3["override_goal_type"] = var_1;
    var_3["entrance_points_index"] = get_flag_label(var_0);
    maps\mp\bots\_bots_strategy::bot_protect_point(var_0.origin, get_flag_protect_radius(), var_3);
  } else {
    var_3["override_goal_type"] = var_1;
    var_3["entrance_points_index"] = get_flag_label(var_0);
    maps\mp\bots\_bots_strategy::bot_capture_zone(var_0.origin, var_0.nodes, var_0, var_3);
  }

  if(!isdefined(var_2) || !var_2)
    thread monitor_flag_status(var_0);
}

defend_flag(var_0) {
  self.current_flag = var_0;

  if(bot_dom_debug_should_capture_all()) {
    var_1["entrance_points_index"] = get_flag_label(var_0);
    maps\mp\bots\_bots_strategy::bot_capture_zone(var_0.origin, var_0.nodes, var_0, var_1);
  } else {
    var_1["entrance_points_index"] = get_flag_label(var_0);
    var_1["nearest_node_to_center"] = var_0.nearest_node;
    maps\mp\bots\_bots_strategy::bot_protect_point(var_0.origin, get_flag_protect_radius(), var_1);
  }

  thread monitor_flag_status(var_0);
}

get_flag_capture_radius() {
  if(!isdefined(level.capture_radius))
    level.capture_radius = 158;

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isdefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = min(1000, var_1 / 3.5);
  }

  return level.protect_radius;
}

bot_dom_leader_dialog(var_0, var_1) {
  if(issubstr(var_0, "losing") && var_0 != "losing_score" && var_0 != "losing_time") {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_3 = get_specific_flag_by_label(var_2);

    if(bot_allow_to_capture_flag(var_3)) {
      self botmemoryevent("known_enemy", undefined, var_3.origin);

      if(!isdefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(maps\mp\bots\_bots_util::bot_is_protecting()) {
          var_4 = distancesquared(self.origin, var_3.origin) < 490000;
          var_5 = bot_is_protecting_flag(var_3);

          if(var_4 || var_5) {
            capture_flag(var_3);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(var_0, "secured")) {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_6 = get_specific_flag_by_label(var_2);
    var_6.last_time_secured[self.team] = gettime();
  }

  maps\mp\bots\_bots_util::bot_leader_dialog(var_0, var_1);
}

bot_allow_to_capture_flag(var_0) {
  var_1 = get_override_flag_targets();

  if(var_1.size == 0)
    return 1;

  if(common_scripts\utility::array_contains(var_1, var_0))
    return 1;

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
  var_3 = get_flag_capture_radius() * 3 * (get_flag_capture_radius() * 3);
  var_4 = 1;

  while (var_4) {
    var_5 = 0;
    var_6 = var_0 maps\mp\gametypes\dom::getflagteam();
    var_7 = get_num_ally_flags(self.team);
    var_8 = get_enemy_flags(self.team);

    if(maps\mp\bots\_bots_util::bot_is_capturing()) {
      if(var_6 == self.team && var_0.useobj.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all())
          var_5 = 1;
      }

      if(var_7 == 2 && var_6 != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, var_0.origin) > var_2)
          var_5 = 1;
      }

      foreach(var_10 in var_8) {
        if(var_10 != var_0 && bot_allow_to_capture_flag(var_10)) {
          if(distancesquared(self.origin, var_10.origin) < var_3)
            var_5 = 1;
        }
      }

      if(self istouching(var_0) && var_0.useobj.userate <= 0) {
        if(self bothasscriptgoal()) {
          var_12 = self botgetscriptgoal();
          var_13 = self botgetscriptgoalradius();

          if(distancesquared(self.origin, var_12) < squared(var_13)) {
            var_14 = self getnearestnode();

            if(isdefined(var_14)) {
              var_15 = undefined;

              foreach(var_17 in var_0.nodes) {
                if(!nodesvisible(var_17, var_14, 1)) {
                  var_15 = var_17.origin;
                  break;
                }
              }

              if(isdefined(var_15)) {
                self.defense_investigate_specific_point = var_15;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(maps\mp\bots\_bots_util::bot_is_protecting()) {
      if(var_6 != self.team) {
        if(!bot_dom_debug_should_protect_all())
          var_5 = 1;
      } else if(var_7 == 1 && var_1 > 1)
        var_5 = 1;
    }

    var_1 = var_7;

    if(var_5) {
      self.force_new_goal = 1;
      var_4 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var_19 = level common_scripts\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));

    if(!(isdefined(var_19) && var_19 == "timeout")) {
      var_20 = max((3 - self.strategy_level) * 1.0 + randomfloatrange(-0.5, 0.5), 0);
      wait(var_20);
    }
  }
}

bot_dom_get_node_chance(var_0) {
  if(var_0 == self.node_closest_to_defend_center)
    return 1.0;

  if(!isdefined(self.current_flag))
    return 1.0;

  var_1 = 0;
  var_2 = get_flag_label(self.current_flag);
  var_3 = get_ally_flags(self.team);

  foreach(var_5 in var_3) {
    if(var_5 != self.current_flag) {
      var_1 = var_0 maps\mp\bots\_bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_5));

      if(var_1) {
        var_6 = get_other_flag(self.current_flag, var_5);
        var_7 = var_6 maps\mp\gametypes\dom::getflagteam();

        if(var_7 != self.team) {
          if(var_0 maps\mp\bots\_bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_6)))
            var_1 = 0;
        }
      }
    }
  }

  if(var_1)
    return 0.2;

  return 1.0;
}

get_flag_label(var_0) {
  var_1 = "";

  if(isdefined(var_0.teleport_zone))
    var_1 = var_1 + (var_0.teleport_zone + "_");

  var_1 = var_1 + ("flag" + var_0.script_label);
  return var_1;
}

get_other_flag(var_0, var_1) {
  for (var_2 = 0; var_2 < level.flags.size; var_2++) {
    if(level.flags[var_2] != var_0 && level.flags[var_2] != var_1)
      return level.flags[var_2];
  }
}

get_specific_flag_by_letter(var_0) {
  var_1 = "_" + tolower(var_0);
  return get_specific_flag_by_label(var_1);
}

get_specific_flag_by_label(var_0) {
  for (var_1 = 0; var_1 < level.flags.size; var_1++) {
    if(level.flags[var_1].script_label == var_0)
      return level.flags[var_1];
  }
}

get_closest_flag(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.flags) {
    var_5 = distancesquared(var_4.origin, var_0);

    if(!isdefined(var_2) || var_5 < var_2) {
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
    if(!isdefined(var_5.team)) {
      continue;
    }
    if(var_5.team == self.team && var_5 != self && maps\mp\_utility::isteamparticipant(var_5)) {
      if(isai(var_5)) {
        if(var_5 bot_is_capturing_flag(var_0))
          var_2++;

        continue;
      }

      if(!isdefined(var_1) || !var_1) {
        if(var_5 istouching(var_0))
          var_2++;
      }
    }
  }

  return var_2;
}

bot_is_capturing_flag(var_0) {
  if(!maps\mp\bots\_bots_util::bot_is_capturing())
    return 0;

  return bot_target_is_flag(var_0);
}

bot_is_protecting_flag(var_0) {
  if(!maps\mp\bots\_bots_util::bot_is_protecting())
    return 0;

  return bot_target_is_flag(var_0);
}

bot_target_is_flag(var_0) {
  return self.current_flag == var_0;
}

get_num_ally_flags(var_0) {
  var_1 = 0;

  for (var_2 = 0; var_2 < level.flags.size; var_2++) {
    var_3 = level.flags[var_2] maps\mp\gametypes\dom::getflagteam();

    if(var_3 == var_0)
      var_1++;
  }

  return var_1;
}

get_enemy_flags(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level.flags.size; var_2++) {
    var_3 = level.flags[var_2] maps\mp\gametypes\dom::getflagteam();

    if(var_3 == common_scripts\utility::get_enemy_team(var_0))
      var_1 = common_scripts\utility::array_add(var_1, level.flags[var_2]);
  }

  return var_1;
}

get_ally_flags(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level.flags.size; var_2++) {
    var_3 = level.flags[var_2] maps\mp\gametypes\dom::getflagteam();

    if(var_3 == var_0)
      var_1 = common_scripts\utility::array_add(var_1, level.flags[var_2]);
  }

  return var_1;
}

bot_should_defend_flag(var_0, var_1) {
  var_2 = get_max_num_defenders_wanted_per_flag(var_1);
  var_3 = get_players_defending_flag(var_0);
  return var_3.size < var_2;
}

get_max_num_defenders_wanted_per_flag(var_0) {
  var_1 = maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team);

  if(var_0 == 1)
    return ceil(var_1 / 6);
  else
    return ceil(var_1 / 3);
}

get_players_defending_flag(var_0) {
  var_1 = get_flag_protect_radius();
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isdefined(var_4.team)) {
      continue;
    }
    if(var_4.team == self.team && var_4 != self && maps\mp\_utility::isteamparticipant(var_4)) {
      if(isai(var_4)) {
        if(var_4 bot_is_protecting_flag(var_0))
          var_2 = common_scripts\utility::array_add(var_2, var_4);

        continue;
      }

      var_5 = gettime() - var_0.last_time_secured[self.team];

      if(var_5 < 10000) {
        continue;
      }
      if(distancesquared(var_0.origin, var_4.origin) < var_1 * var_1)
        var_2 = common_scripts\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}