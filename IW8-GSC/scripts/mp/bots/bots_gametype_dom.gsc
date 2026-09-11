/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_dom.gsc
*************************************************/

function main() {
  if(scripts\common\utility::is_map_using_locales_only()) {
    return;
  }

  level.bot_ignore_precalc_paths = 0;
  setup_callbacks();
  setup_bot_dom(3, 5);
  level thread scripts\mp\bots\bots_util::bot_monitor_enemy_camp_spots(&scripts\mp\bots\bots_util::bot_valid_camp_assassin);
}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_dom_think;
  level.bot_funcs["should_start_cautious_approach"] = &should_start_cautious_approach_dom;
  level.bot_funcs["leader_dialog"] = &bot_dom_leader_dialog;

  if(!level.bot_ignore_precalc_paths) {
    level.bot_funcs["get_watch_node_chance"] = &bot_dom_get_node_chance;
    return;
  }
}

function crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(!scripts\mp\utility\entity::isteamparticipant(self)) {
    return 1;
  }

  return scripts\mp\bots\bots_util::bot_is_protecting();
}

function monitor_flag_control() {
  self notify("monitor_flag_control");
  self endon("monitor_flag_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 1;
    var_0 = scripts\mp\gametypes\dom::getflagteam();

    if(var_0 != "neutral") {
      var_1 = getzonenearest(self.trigger.origin);

      if(isDefined(var_1)) {
        botzonesetteam(var_1, var_0);
      }
    }
  }
}

function monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var_0 = scripts\mp\gametypes\dom::getflagteam();

  for(;;) {
    var_1 = scripts\mp\gametypes\dom::getflagteam();

    if(var_1 != var_0) {
      level notify("flag_changed_ownership");
    }

    var_0 = var_1;
    wait 0.05;
  }
}

function setup_bot_dom(var_0, var_1) {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_2 = bot_get_all_possible_flags();

  if(var_2.size > 3) {
    while(!isDefined(level.teleport_dom_finished_initializing)) {
      wait 0.05;
    }

    var_3 = [];

    foreach(var_5 in var_2) {
      if(!isDefined(var_3[var_5.teleport_zone])) {
        var_3 = [];
      }

      var_3 = scripts\engine\utility::array_add(var_3[var_5.teleport_zone], var_5);
    }

    foreach(var_8 in var_3) {
      level.entrance_points_finished_caching = 0;
      bot_cache_flag_distances(var_8);
      scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(var_8, var_9 + "_flag", level.bot_ignore_precalc_paths);
    }
  } else {
    scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(var_2, "flag", level.bot_ignore_precalc_paths);
    bot_cache_flag_distances(var_2);
    thread bot_wait_for_event_flag_swap(var_2);
  }

  foreach(var_5 in var_2) {
    thread monitor_flag_control();
    thread monitor_flag_ownership();

    if(var_5.objectivekey != "_a" && var_5.objectivekey != "_b" && var_5.objectivekey != "_c") {}

    var_5.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var_5.trigger);
    var_5.last_time_secured["allies"] = 0;
    var_5.last_time_secured["axis"] = 0;
  }

  level.bot_dom_override_flag_targets = [];
  level.bot_dom_override_flag_targets["axis"] = [];
  level.bot_dom_override_flag_targets["allies"] = [];
  level.bot_gametype_precaching_done = 1;
}

function bot_wait_for_event_flag_swap(var_0) {
  level endon("game_ended");
  level waittill("dom_flags_moved");
  scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(var_0, "flag", level.bot_ignore_precalc_paths, 1);
  bot_cache_flag_distances(var_0);

  foreach(var_2 in var_0) {
    var_2.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var_2);
  }

  foreach(var_5 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var_5)) {
      var_5.force_new_goal = 1;
    }
  }
}

function bot_get_all_possible_flags() {
  if(isDefined(level.all_dom_flags)) {
    return level.all_dom_flags;
  }

  return level.objectives;
}

function bot_cache_flag_distances(var_0) {
  if(!isDefined(level.flag_distances)) {
    level.flag_distances = [];
  }

  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_1 = var_4;
    var_2++;
  }

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    for(var_6 = var_2 + 1; var_6 < var_1.size; var_6++) {
      var_7 = distance(var_1[var_2].trigger.origin, var_1[var_6].trigger.origin);
      var_8 = get_flag_label(var_1[var_2]);
      var_9 = get_flag_label(var_1[var_6]);
      level.flag_distances[var_8][var_9] = var_7;
      level.flag_distances[var_9][var_8] = var_7;
    }
  }
}

function should_start_cautious_approach_dom(var_0) {
  if(var_0) {
    if(self.current_flag scripts\mp\gametypes\dom::getflagteam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      var_1 = get_closest_flag(self.lastspawnpoint.origin);

      if(var_1 == self.current_flag) {
        return 0;
      } else {
        var_2 = get_other_flag(var_1, self.current_flag);
        var_3 = distancesquared(var_1.trigger.origin, self.current_flag.trigger.origin);
        var_4 = distancesquared(var_2.trigger.origin, self.current_flag.trigger.origin);

        if(var_3 < var_4) {
          return 0;
        }
      }
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var_0);
}

function bot_dom_debug_should_capture_all() {
  return false;
}

function bot_dom_debug_should_protect_all() {
  return false;
}

function bot_dom_think() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    scripts\mp\bots\bots_util::bot_update_camp_assassin();
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
        self.new_goal_time = var_0 + randomintrange(30000, 45000);
      }
    }

    scripts\engine\utility::waittill_notify_or_timeout("needs_new_flag_goal", 1);
  }
}

function should_delay_flag_decision() {
  if(self.force_new_goal) {
    return false;
  }

  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return false;
  }

  if(self.current_flag scripts\mp\gametypes\dom::getflagteam() == self.team) {
    return false;
  }

  var_0 = get_flag_capture_radius();

  if(distancesquared(self.origin, self.current_flag.trigger.origin) < var_0 * 2 * var_0 * 2) {
    var_1 = get_ally_flags(self.team);

    if(var_1.size == 2 && !scripts\engine\utility::array_contains(var_1, self.current_flag) && !bot_allowed_to_3_cap()) {
      return false;
    }

    return true;
  }

  return false;
}

function get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

function has_override_flag_targets() {
  var_0 = get_override_flag_targets();
  return var_0.size > 0;
}

function flag_has_been_captured_before(var_0) {
  return !flag_has_never_been_captured(var_0);
}

function flag_has_never_been_captured(var_0) {
  return var_0.firstcapture;
}

function bot_choose_flag() {
  var_0 = undefined;
  var_1 = [];
  var_2 = [];
  var_3 = !istrue(level.precappoints);
  var_4 = get_override_flag_targets();

  if(var_4.size > 0) {
    var_5 = var_4;
  } else {
    var_5 = level.objectives;
  }

  foreach(var_8, var_1 in var_5) {
    var_7 = var_1 scripts\mp\gametypes\dom::getflagteam();

    if(var_4) {
      if(flag_has_been_captured_before(var_1)) {
        var_4 = 0;
      }
    }

    if(var_7 != self.team) {
      var_2 = var_1;
      continue;
    }

    var_3 = var_1;
  }

  var_9 = undefined;

  if(var_2.size == 3) {
    var_9 = 1;
  } else if(var_2.size == 2) {
    if(var_3.size == 1) {
      if(!bot_should_defend_flag(var_3[0], 1)) {
        var_9 = 1;
      } else {
        var_9 = !bot_should_defend(0.34);
      }

      if(scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team) == 1) {
        var_9 = 1;
      }
    } else if(var_3.size == 0) {
      var_9 = 1;
    }
  } else if(var_2.size == 1) {
    if(var_3.size == 2) {
      if(bot_allowed_to_3_cap()) {
        if(!bot_should_defend_flag(var_3[0], 2) && !bot_should_defend_flag(var_3[1], 2)) {
          var_9 = 1;
        } else if(self.strategy_level == 0) {
          var_9 = !bot_should_defend(0.34);
        } else {
          var_9 = !bot_should_defend(0.5);
        }
      } else {
        var_9 = 0;
      }
    } else if(var_3.size == 1) {
      if(!bot_should_defend_flag(var_3[0], 1)) {
        var_9 = 1;
      } else {
        var_9 = !bot_should_defend(0.34);
      }
    } else if(var_3.size == 0) {
      var_9 = 1;
    }
  } else if(var_2.size == 0) {
    var_9 = 0;
  }

  if(var_9) {
    if(var_2.size > 1) {
      var_10 = [];

      foreach(var_12 in var_2) {
        var_10 = var_12.trigger;
      }

      var_14 = scripts\engine\utility::get_array_of_closest(self.origin, var_10);
      var_15 = [];

      foreach(var_17 in var_14) {
        foreach(var_19 in level.objectives) {
          if(var_19.trigger == var_17) {
            var_15 = var_19;
          }
        }
      }

      var_14 = var_15;
    } else {
      var_14 = var_3;
    }

    if(var_5 && !has_override_flag_targets()) {
      var_22 = get_num_allies_capturing_flag(var_14[0], 1);
      jumpiffalse(var_22 < min_num_bots_assaulting_first_flag()) LOC_0000029f;
      var_23 = 0;
      goto LOC_00000309;
    }

    if(var_28.size == 1) {
      var_5 = var_28[0];
    } else if(distancesquared(var_28[0].trigger.origin, self.origin) < 102400) {
      var_5 = var_28[0];
    } else {
      var_29 = [];
      var_30 = [];

      for(var_31 = 0; var_31 < var_28.size; var_31++) {
        var_32 = distance(var_28[var_31].trigger.origin, self.origin);
        var_30 = var_32;
        var_29 = var_32;
      }

      if(var_7.size == 1) {
        var_33 = 1.5;

        for(var_31 = 0; var_31 < var_29.size; var_31++) {
          var_29 = var_29[var_31] + level.flag_distances[get_flag_label(var_28[var_31])][get_flag_label(var_7[0])] * var_33;
        }
      }

      if(self.strategy_level == 0) {
        var_27 = randomint(100);

        if(var_27 < 50) {
          var_5 = var_28[0];
        } else if(var_27 < 50 + 50 / (var_28.size - 1)) {
          var_5 = var_28[1];
        } else {
          var_5 = var_28[2];
        }
      } else {
        if(var_29.size == 2) {
          GscBinSkip1(0x45, 0, 50);
        }

        if(var_29.size == 3) {
          GscBinSkip1(0x45, 0, 34);
        }
      }
    }
  } else {
    if(var_7.size > 1) {
      var_10 = [];

      foreach(var_38 in var_7) {
        var_10 = var_38.trigger;
      }

      var_40 = scripts\engine\utility::get_array_of_closest(self.origin, var_10);
      var_15 = [];

      foreach(var_17 in var_40) {
        foreach(var_19 in level.objectives) {
          if(var_19.trigger == var_17) {
            var_15 = var_19;
          }
        }
      }

      var_40 = var_15;
    } else {
      var_40 = var_8;
    }

    foreach(var_46 in var_40) {
      if(bot_should_defend_flag(var_46, var_8.size)) {
        var_6 = var_46;
        break;
      }
    }

    if(!isDefined(var_6)) {
      if(self.strategy_level == 0) {
        var_6 = var_8[0];
      } else if(var_40.size == 2) {
        var_48 = get_other_flag(var_40[0], var_40[1]);
        var_10 = [];

        foreach(var_50 in var_40) {
          var_10 = var_50.trigger;
        }

        var_52 = scripts\engine\utility::get_array_of_closest(var_48.trigger.origin, var_10);
        var_15 = [];

        foreach(var_17 in var_52) {
          foreach(var_19 in level.objectives) {
            if(var_19.trigger == var_17) {
              var_15 = var_19;
            }
          }
        }

        var_52 = var_15;
        var_27 = randomint(100);

        if(var_27 < 70) {
          var_6 = var_52[0];
        } else {
          var_6 = var_52[1];
        }
      } else {
        var_6 = var_40[0];
      }
    }
  }

  if(var_40) {
    capture_flag(var_6);
    return;
  }

  defend_flag(var_6);
}

function min_num_bots_assaulting_first_flag() {
  var_0 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
  return ceil(var_0 / 3);
}

function bot_allowed_to_3_cap() {
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

function bot_should_defend(var_0) {
  if(randomfloat(1) < var_0) {
    return 1;
  }

  var_1 = level.bot_personality_type[self.personality];

  if(var_1 == "stationary") {
    return 1;
  }

  if(var_1 == "active") {
    return 0;
  }
}

function capture_flag(var_0, var_1, var_2) {
  self.current_flag = var_0;

  if(bot_dom_debug_should_protect_all()) {
    GscBinSkip1(0x45, "override_goal_type", var_1);
  }

  GscBinSkip1(0x45, "override_goal_type", var_1);
}

function defend_flag(var_0) {
  self.current_flag = var_0;

  if(bot_dom_debug_should_capture_all()) {
    GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var_0));
  }

  GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var_0));
}

function get_flag_capture_radius() {
  if(!isDefined(level.capture_radius)) {
    level.capture_radius = 158;
  }

  return level.capture_radius;
}

function get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = min(1000, var_1 / 3.5);
  }

  return level.protect_radius;
}

function bot_dom_leader_dialog(var_0, var_1) {
  if(issubstr(var_0, "losing") && var_0 != "losing_score" && var_0 != "losing_time" && var_0 != "gamestate_domlosing") {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_3 = get_specific_flag_by_label(var_2);

    if(isDefined(var_3) && bot_allow_to_capture_flag(var_3)) {
      self botmemoryevent("known_enemy", undefined, var_3.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          var_4 = distancesquared(self.origin, var_3.trigger.origin) < 490000;
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

  scripts\mp\bots\bots_util::bot_leader_dialog(var_0, var_1);
}

function bot_allow_to_capture_flag(var_0) {
  var_1 = get_override_flag_targets();

  if(var_1.size == 0) {
    return true;
  }

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return true;
  }

  return false;
}

function monitor_flag_status(var_0) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_1 = get_num_ally_flags(self.team);
  var_2 = get_flag_capture_radius() * get_flag_capture_radius();
  var_3 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
  var_4 = 1;

  while(var_4) {
    var_5 = 0;
    var_6 = var_0 scripts\mp\gametypes\dom::getflagteam();
    var_7 = get_num_ally_flags(self.team);
    var_8 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(var_6 == self.team && var_0.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all()) {
          var_5 = 1;
        }
      }

      if(var_7 == 2 && var_6 != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, var_0.trigger.origin) > var_2) {
          var_5 = 1;
        }
      }

      foreach(var_10 in var_8) {
        if(var_10 != var_0 && bot_allow_to_capture_flag(var_10)) {
          if(distancesquared(self.origin, var_10.trigger.origin) < var_3) {
            var_5 = 1;
          }
        }
      }

      if(self istouching(var_0.trigger) && var_0.userate <= 0) {
        if(self bothasscriptgoal()) {
          var_12 = self botgetscriptgoal();
          var_13 = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, var_12) < squared(var_13)) {
            var_14 = self getnearestnode();

            if(isDefined(var_14)) {
              var_15 = undefined;

              foreach(var_17 in var_0.nodes) {
                if(!nodesvisible(var_17, var_14, 1)) {
                  var_15 = var_17.origin;
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

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
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

    var_19 = level scripts\engine\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    var_20 = isDefined(var_19) && var_19 == "timeout";

    if(!var_20) {
      var_21 = max((3 - self.strategy_level) * 1 + randomfloatrange(-0.5, 0.5), 0);
      wait var_21;
    }
  }
}

function bot_dom_get_node_chance(var_0) {
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
      var_1 = var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_5));

      if(var_1) {
        var_6 = get_other_flag(self.current_flag, var_5);
        var_7 = var_6 scripts\mp\gametypes\dom::getflagteam();

        if(var_7 != self.team) {
          if(var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_6))) {
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

function get_flag_label(var_0) {
  var_1 = "";

  if(isDefined(var_0.teleport_zone)) {
    var_1 += var_0.teleport_zone + "_";
  }

  var_1 += "flag" + var_0.objectivekey;
  return var_1;
}

function get_other_flag(var_0, var_1) {
  foreach(var_3 in level.objectives) {
    if(var_3 != var_0 && var_3 != var_1) {
      return var_3;
    }
  }
}

function get_specific_flag_by_letter(var_0) {
  var_1 = "_" + tolower(var_0);
  return get_specific_flag_by_label(var_1);
}

function get_specific_flag_by_label(var_0) {
  foreach(var_2 in level.objectives) {
    if(var_2.objectivekey == var_0) {
      return var_2;
    }
  }
}

function get_closest_flag(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.objectives) {
    var_5 = distancesquared(var_4.trigger.origin, var_0);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

function get_num_allies_capturing_flag(var_0, var_1) {
  var_2 = 0;
  var_3 = get_flag_capture_radius();

  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }

    if(var_5.team == self.team && var_5 != self && scripts\mp\utility\entity::isteamparticipant(var_5)) {
      if(isai(var_5)) {
        if(bot_is_capturing_flag(var_5, var_0)) {
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

function bot_is_capturing_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return 0;
  }

  return bot_target_is_flag(var_0);
}

function bot_is_protecting_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting()) {
    return 0;
  }

  return bot_target_is_flag(var_0);
}

function bot_target_is_flag(var_0) {
  return self.current_flag == var_0;
}

function get_num_ally_flags(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gametypes\dom::getflagteam();

    if(var_4 == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function get_enemy_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gametypes\dom::getflagteam();

    if(var_4 == scripts\engine\utility::get_enemy_team(var_0)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

function get_ally_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gametypes\dom::getflagteam();

    if(var_4 == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

function bot_should_defend_flag(var_0, var_1) {
  var_2 = get_max_num_defenders_wanted_per_flag(var_1);
  var_3 = get_players_defending_flag(var_0);
  return var_3.size < var_2;
}

function get_max_num_defenders_wanted_per_flag(var_0) {
  var_1 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(var_0 == 1) {
    return ceil(var_1 / 6);
  }

  return ceil(var_1 / 3);
}

function get_players_defending_flag(var_0) {
  var_1 = get_flag_protect_radius();
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(var_4.team == self.team && var_4 != self && scripts\mp\utility\entity::isteamparticipant(var_4)) {
      if(isai(var_4)) {
        if(bot_is_protecting_flag(var_4, var_0)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_4);
        }

        continue;
      }

      var_5 = gettime() - var_0.last_time_secured[self.team];

      if(var_5 < 10000) {
        continue;
      }

      if(distancesquared(var_0.trigger.origin, var_4.origin) < var_1 * var_1) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
      }
    }
  }

  return var_2;
}