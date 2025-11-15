/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_dom.gsc
********************************************/

main() {
  setup_callbacks();
  setup_bot_dom();
  level thread scripts\mp\bots\_bots_util::bot_monitor_enemy_camp_spots(::scripts\mp\bots\_bots_util::bot_valid_camp_assassin);
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_dom_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_dom;
  level.bot_funcs["leader_dialog"] = ::bot_dom_leader_dialog;
  level.bot_funcs["get_watch_node_chance"] = ::bot_dom_get_node_chance;
  level.bot_funcs["commander_gametype_tactics"] = ::bot_dom_apply_commander_tactics;
}

bot_is_assigned_location(param_00) {
  var_01 = 90000;
  if(scripts\mp\bots\_bots_util::bot_is_defending() && distance2dsquared(param_00, self.bot_defending_center) < var_01) {
    return 1;
  }

  if(self bothasscriptgoal()) {
    var_02 = self botgetscriptgoal();
    if(distance2dsquared(param_00, var_02) < var_01) {
      return 1;
    }
  }

  return 0;
}

crate_can_use_smartglass(param_00) {
  if(isagent(self)) {
    if(!isDefined(level.smartglass_commander) || self.triggerportableradarping != level.smartglass_commander) {
      return crate_can_use();
    }

    if(!isDefined(param_00.boxtype) && scripts\mp\bots\_bots_util::bot_crate_is_command_goal(param_00)) {
      return bot_is_assigned_location(param_00.origin);
    }

    return 0;
  }

  return crate_can_use(param_00);
}

crate_can_use(param_00) {
  if(isagent(self) && !isDefined(param_00.boxtype)) {
    return 0;
  }

  if(isDefined(param_00.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(param_00.cratetype)) {
    return 0;
  }

  if(!scripts\mp\utility::isteamparticipant(self)) {
    return 1;
  }

  return scripts\mp\bots\_bots_util::bot_is_protecting();
}

bot_dom_apply_commander_tactics(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "tactic_none":
      level.bot_dom_override_flag_targets[self.team] = [];
      var_01 = 1;
      break;

    case "tactic_dom_holdA":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      var_01 = 1;
      break;

    case "tactic_dom_holdB":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("B");
      var_01 = 1;
      break;

    case "tactic_dom_holdC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("C");
      var_01 = 1;
      break;

    case "tactic_dom_holdAB":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("B");
      var_01 = 1;
      break;

    case "tactic_dom_holdBC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("B");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("C");
      var_01 = 1;
      break;

    case "tactic_dom_holdAC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("C");
      var_01 = 1;
      break;

    case "tactic_dom_holdABC":
      level.bot_dom_override_flag_targets[self.team] = [];
      level.bot_dom_override_flag_targets[self.team][0] = get_specific_flag("A");
      level.bot_dom_override_flag_targets[self.team][1] = get_specific_flag("B");
      level.bot_dom_override_flag_targets[self.team][2] = get_specific_flag("C");
      var_01 = 1;
      break;
  }

  if(var_01) {
    foreach(var_03 in level.participants) {
      if(!isDefined(var_03.team)) {
        continue;
      }

      if(scripts\mp\utility::isaiteamparticipant(var_03) && var_03.team == self.team) {
        var_03.force_new_goal = 1;
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
    var_00 = self.useobj scripts\mp\gameobjects::getownerteam();
    if(var_00 != "neutral") {
      var_01 = getzonenearest(self.origin);
      if(isDefined(var_01)) {
        botzonesetteam(var_01, var_00);
      }
    }
  }
}

monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var_00 = self.useobj scripts\mp\gameobjects::getownerteam();
  for(;;) {
    var_01 = self.useobj scripts\mp\gameobjects::getownerteam();
    if(var_01 != var_00) {
      level notify("flag_changed_ownership");
    }

    var_00 = var_01;
    wait(0.05);
  }
}

setup_bot_dom() {
  var_00 = bot_get_all_possible_flags();
  if(var_00.size > 3) {
    while(!isDefined(level.teleport_dom_finished_initializing)) {
      wait(0.05);
    }

    var_01 = [];
    foreach(var_03 in var_00) {
      if(!isDefined(var_01[var_03.teleport_zone])) {
        var_01[var_03.teleport_zone] = [];
      }

      var_01[var_03.teleport_zone] = scripts\engine\utility::array_add(var_01[var_03.teleport_zone], var_03);
    }

    foreach(var_07, var_06 in var_01) {
      level.entrance_points_finished_caching = 0;
      bot_cache_flag_distances(var_06);
      scripts\mp\bots\_bots_util::bot_cache_entrances_to_flags_or_radios(var_06, var_07 + "_flag");
    }
  } else {
    scripts\mp\bots\_bots_util::bot_cache_entrances_to_flags_or_radios(var_00, "flag");
    bot_cache_flag_distances(var_00);
  }

  foreach(var_03 in var_00) {
    var_03 thread monitor_zone_control();
    var_03 thread monitor_flag_ownership();
    if(var_03.script_label != "_a" && var_03.script_label != "_b" && var_03.script_label != "_c") {}

    var_03.nodes = getnodesintrigger(var_03);
    add_missing_nodes(var_03);
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

bot_cache_flag_distances(param_00) {
  if(!isDefined(level.flag_distances)) {
    level.flag_distances = [];
  }

  for(var_01 = 0; var_01 < param_00.size - 1; var_01++) {
    for(var_02 = var_01 + 1; var_02 < param_00.size; var_02++) {
      var_03 = distance(param_00[var_01].origin, param_00[var_02].origin);
      var_04 = get_flag_label(param_00[var_01]);
      var_05 = get_flag_label(param_00[var_02]);
      level.flag_distances[var_04][var_05] = var_03;
      level.flag_distances[var_05][var_04] = var_03;
    }
  }
}

add_missing_nodes(param_00) {
  if(param_00.classname == "trigger_radius") {
    var_01 = getnodesinradius(param_00.origin, param_00.fgetarg, 0, 100);
    var_02 = scripts\engine\utility::array_remove_array(var_01, param_00.nodes);
    if(var_02.size > 0) {
      param_00.nodes = scripts\engine\utility::array_combine(param_00.nodes, var_02);
      return;
    }

    return;
  }

  if(param_00.classname == "trigger_multiple") {
    var_03[0] = param_00 getpointinbounds(1, 1, 1);
    var_03[1] = param_00 getpointinbounds(1, 1, -1);
    var_03[2] = param_00 getpointinbounds(1, -1, 1);
    var_03[3] = param_00 getpointinbounds(1, -1, -1);
    var_03[4] = param_00 getpointinbounds(-1, 1, 1);
    var_03[5] = param_00 getpointinbounds(-1, 1, -1);
    var_03[6] = param_00 getpointinbounds(-1, -1, 1);
    var_03[7] = param_00 getpointinbounds(-1, -1, -1);
    var_04 = 0;
    foreach(var_06 in var_03) {
      var_07 = distance(var_06, param_00.origin);
      if(var_07 > var_04) {
        var_04 = var_07;
      }
    }

    var_01 = getnodesinradius(param_00.origin, var_04, 0, 100);
    foreach(var_0A in var_01) {
      if(!ispointinvolume(var_0A.origin, param_00)) {
        if(ispointinvolume(var_0A.origin + (0, 0, 40), param_00) || ispointinvolume(var_0A.origin + (0, 0, 80), param_00) || ispointinvolume(var_0A.origin + (0, 0, 120), param_00)) {
          param_00.nodes = scripts\engine\utility::array_add(param_00.nodes, var_0A);
        }
      }
    }
  }
}

should_start_cautious_approach_dom(param_00) {
  if(param_00) {
    if(self.current_flag.useobj scripts\mp\gameobjects::getownerteam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      var_01 = get_closest_flag(self.lastspawnpoint.origin);
      if(var_01 == self.current_flag) {
        return 0;
      } else {
        var_02 = get_other_flag(var_01, self.current_flag);
        var_03 = distancesquared(var_01.origin, self.current_flag.origin);
        var_04 = distancesquared(var_02.origin, self.current_flag.origin);
        if(var_03 < var_04) {
          return 0;
        }
      }
    }
  }

  return scripts\mp\bots\_bots_strategy::should_start_cautious_approach_default(param_00);
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
    var_00 = gettime();
    if(var_00 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(var_00 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision()) {
        self.new_goal_time = var_00 + 5000;
      } else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var_00 + randomintrange(30000, -20536);
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

  var_00 = get_flag_capture_radius();
  if(distancesquared(self.origin, self.current_flag.origin) < var_00 * 2 * var_00 * 2) {
    var_01 = get_ally_flags(self.team);
    if(var_01.size == 2 && !scripts\engine\utility::array_contains(var_01, self.current_flag) && !bot_allowed_to_3_cap()) {
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
  var_00 = get_override_flag_targets();
  return var_00.size > 0;
}

flag_has_been_captured_before(param_00) {
  return !flag_has_never_been_captured(param_00);
}

flag_has_never_been_captured(param_00) {
  return param_00.useobj.firstcapture;
}

bot_choose_flag() {
  var_00 = undefined;
  var_01 = [];
  var_02 = [];
  var_03 = 1;
  var_04 = get_override_flag_targets();
  if(var_04.size > 0) {
    var_05 = var_04;
  } else {
    var_05 = level.magicbullet;
  }

  for(var_06 = 0; var_06 < var_05.size; var_06++) {
    var_07 = var_05[var_06].useobj scripts\mp\gameobjects::getownerteam();
    if(var_03) {
      if(flag_has_been_captured_before(var_05[var_06])) {
        var_03 = 0;
      } else {}
    }

    if(var_07 != self.team) {
      var_01[var_01.size] = var_05[var_06];
      continue;
    }

    var_02[var_02.size] = var_05[var_06];
  }

  var_08 = undefined;
  if(var_01.size == 3) {
    var_08 = 1;
  } else if(var_01.size == 2) {
    if(var_02.size == 1) {
      if(!bot_should_defend_flag(var_02[0], 1)) {
        var_08 = 1;
      } else {
        var_08 = !bot_should_defend(0.34);
      }
    } else if(var_02.size == 0) {
      var_08 = 1;
    }
  } else if(var_01.size == 1) {
    if(var_02.size == 2) {
      if(bot_allowed_to_3_cap()) {
        if(!bot_should_defend_flag(var_02[0], 2) && !bot_should_defend_flag(var_02[1], 2)) {
          var_08 = 1;
        } else if(self.strategy_level == 0) {
          var_08 = !bot_should_defend(0.34);
        } else {
          var_08 = !bot_should_defend(0.5);
        }
      } else {
        var_08 = 0;
      }
    } else if(var_02.size == 1) {
      if(!bot_should_defend_flag(var_02[0], 1)) {
        var_08 = 1;
      } else {
        var_08 = !bot_should_defend(0.34);
      }
    } else if(var_02.size == 0) {
      var_08 = 1;
    }
  } else if(var_01.size == 0) {
    var_08 = 0;
  }

  if(var_08) {
    if(var_01.size > 1) {
      var_09 = scripts\engine\utility::get_array_of_closest(self.origin, var_01);
    } else {
      var_09 = var_02;
    }

    if(var_03 && !has_override_flag_targets()) {
      var_0A = get_num_allies_capturing_flag(var_09[0], 1);
      if(var_0A < 2) {
        var_0B = 0;
      } else {
        var_0C = 20;
        var_0D = 65;
        var_0E = 15;
        if(self.strategy_level == 0) {
          var_0C = 50;
          var_0D = 25;
          var_0E = 25;
        }

        var_0F = randomint(100);
        if(var_0F < var_0C) {
          var_0B = 0;
        } else if(var_0F < var_0C + var_0D) {
          var_0B = 1;
        } else {
          var_0B = 2;
        }
      }

      var_10 = undefined;
      if(var_0B == 0) {
        var_10 = "critical";
      }

      capture_flag(var_09[var_0B], var_10);
      return;
    }

    if(var_10.size == 1) {
      var_03 = var_10[0];
    } else if(distancesquared(var_10[0].origin, self.origin) < 102400) {
      var_03 = var_10[0];
    } else {
      var_11 = [];
      var_12 = [];
      for(var_09 = 0; var_09 < var_10.size; var_09++) {
        var_13 = distance(var_10[var_09].origin, self.origin);
        var_12[var_09] = var_13;
        var_11[var_09] = var_13;
      }

      if(var_05.size == 1) {
        var_14 = 1.5;
        for(var_09 = 0; var_09 < var_11.size; var_09++) {
          var_11[var_09] = var_11[var_09] + level.flag_distances[get_flag_label(var_10[var_09])][get_flag_label(var_05[0])] * var_14;
        }
      }

      if(self.strategy_level == 0) {
        var_0F = randomint(100);
        if(var_0F < 50) {
          var_03 = var_10[0];
        } else if(var_0F < 50 + 50 / var_10.size - 1) {
          var_03 = var_10[1];
        } else {
          var_03 = var_10[2];
        }
      } else if(var_11.size == 2) {
        var_15[0] = 50;
        var_15[1] = 50;
        for(var_09 = 0; var_09 < var_10.size; var_09++) {
          if(var_11[var_09] < var_11[1 - var_09]) {
            var_15[var_09] = var_15[var_09] + 20;
            var_15[1 - var_09] = var_15[1 - var_09] - 20;
          }

          if(var_12[var_09] < 640) {
            var_15[var_09] = var_15[var_09] + 15;
            var_15[1 - var_09] = var_15[1 - var_09] - 15;
          }

          if(var_10[var_09].useobj scripts\mp\gameobjects::getownerteam() == "neutral") {
            var_15[var_09] = var_15[var_09] + 15;
            var_15[1 - var_09] = var_15[1 - var_09] - 15;
          }
        }

        var_0F = randomint(100);
        if(var_0F < var_15[0]) {
          var_03 = var_10[0];
        } else {
          var_03 = var_10[1];
        }
      } else if(var_11.size == 3) {
        var_15[0] = 34;
        var_15[1] = 33;
        var_15[2] = 33;
        for(var_09 = 0; var_09 < var_10.size; var_09++) {
          var_16 = var_09 + 1 % 3;
          var_17 = var_09 + 2 % 3;
          if(var_11[var_09] < var_11[var_16] && var_11[var_09] < var_11[var_17]) {
            var_15[var_09] = var_15[var_09] + 36;
            var_15[var_16] = var_15[var_16] - 18;
            var_15[var_17] = var_15[var_17] - 18;
          }

          if(var_12[var_09] < 640) {
            var_15[var_09] = var_15[var_09] + 15;
            var_15[var_16] = var_15[var_16] - 7;
            var_15[var_17] = var_15[var_17] - 8;
          }

          if(var_10[var_09].useobj scripts\mp\gameobjects::getownerteam() == "neutral") {
            var_15[var_09] = var_15[var_09] + 15;
            var_15[var_16] = var_15[var_16] - 7;
            var_15[var_17] = var_15[var_17] - 8;
          }
        }

        var_0F = randomint(100);
        if(var_0F < var_15[0]) {
          var_03 = var_10[0];
        } else if(var_0F < var_15[0] + var_15[1]) {
          var_03 = var_10[1];
        } else {
          var_03 = var_10[2];
        }
      }
    }
  } else {
    if(var_05.size > 1) {
      var_18 = scripts\engine\utility::get_array_of_closest(self.origin, var_05);
    } else {
      var_18 = var_06;
    }

    foreach(var_1A in var_18) {
      if(bot_should_defend_flag(var_1A, var_05.size)) {
        var_03 = var_1A;
        break;
      }
    }

    if(!isDefined(var_03)) {
      if(self.strategy_level == 0) {
        var_03 = var_05[0];
      } else if(var_18.size == 2) {
        var_1C = get_other_flag(var_18[0], var_18[1]);
        var_1D = scripts\engine\utility::get_array_of_closest(var_1C.origin, var_18);
        var_0F = randomint(100);
        if(var_0F < 70) {
          var_03 = var_1D[0];
        } else {
          var_03 = var_1D[1];
        }
      } else {
        var_03 = var_18[0];
      }
    }
  }

  if(var_0B) {
    capture_flag(var_03);
    return;
  }

  defend_flag(var_03);
}

bot_allowed_to_3_cap() {
  if(self.strategy_level == 0) {
    return 1;
  }

  var_00 = get_override_flag_targets();
  if(var_00.size == 3) {
    return 1;
  }

  var_01 = scripts\mp\gamescore::_getteamscore(scripts\engine\utility::get_enemy_team(self.team));
  var_02 = scripts\mp\gamescore::_getteamscore(self.team);
  var_03 = 200 - var_01;
  var_04 = 200 - var_02;
  var_05 = var_04 * 0.5 > var_03;
  return var_05;
}

bot_should_defend(param_00) {
  if(randomfloat(1) < param_00) {
    return 1;
  }

  var_01 = level.bot_personality_type[self.personality];
  if(var_01 == "stationary") {
    return 1;
  } else if(var_01 == "active") {
    return 0;
  }
}

capture_flag(param_00, param_01, param_02) {
  self.current_flag = param_00;
  if(bot_dom_debug_should_protect_all()) {
    var_03["override_goal_type"] = param_01;
    var_03["entrance_points_index"] = get_flag_label(param_00);
    scripts\mp\bots\_bots_strategy::bot_protect_point(param_00.origin, get_flag_protect_radius(), var_03);
  } else {
    param_00["override_goal_type"] = param_02;
    var_03["entrance_points_index"] = get_flag_label(param_00);
    scripts\mp\bots\_bots_strategy::bot_capture_zone(param_00.origin, param_00.nodes, param_00, var_03);
  }

  if(!isDefined(param_02) || !param_02) {
    thread monitor_flag_status(param_00);
  }
}

defend_flag(param_00) {
  self.current_flag = param_00;
  if(bot_dom_debug_should_capture_all()) {
    var_01["entrance_points_index"] = get_flag_label(param_00);
    scripts\mp\bots\_bots_strategy::bot_capture_zone(param_00.origin, param_00.nodes, param_00, var_01);
  } else {
    param_00["entrance_points_index"] = get_flag_label(var_01);
    var_01["nearest_node"] = param_00.nearest_node;
    scripts\mp\bots\_bots_strategy::bot_protect_point(param_00.origin, get_flag_protect_radius(), var_01);
  }

  thread monitor_flag_status(param_00);
}

get_flag_capture_radius() {
  if(!isDefined(level.capture_radius)) {
    level.capture_radius = 158;
  }

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    var_00 = self botgetworldsize();
    var_01 = var_00[0] + var_00[1] / 2;
    level.protect_radius = min(1000, var_01 / 3.5);
  }

  return level.protect_radius;
}

bot_dom_leader_dialog(param_00, param_01) {
  if(issubstr(param_00, "losing")) {
    var_02 = getsubstr(param_00, param_00.size - 2);
    var_03 = undefined;
    for(var_04 = 0; var_04 < level.magicbullet.size; var_04++) {
      if(var_02 == level.magicbullet[var_04].script_label) {
        var_03 = level.magicbullet[var_04];
      }
    }

    if(isDefined(var_03) && bot_allow_to_capture_flag(var_03)) {
      self botmemoryevent("known_enemy", undefined, var_03.origin);
      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\_bots_util::bot_is_protecting()) {
          if(distancesquared(self.origin, var_03.origin) < 490000) {
            capture_flag(var_03);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  }

  scripts\mp\bots\_bots_util::bot_leader_dialog(param_00, param_01);
}

bot_allow_to_capture_flag(param_00) {
  var_01 = get_override_flag_targets();
  if(var_01.size == 0) {
    return 1;
  }

  if(scripts\engine\utility::array_contains(var_01, param_00)) {
    return 1;
  }

  return 0;
}

monitor_flag_status(param_00) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_01 = get_num_ally_flags(self.team);
  var_02 = get_flag_capture_radius() * get_flag_capture_radius();
  var_03 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
  var_04 = 1;
  while(var_04) {
    var_05 = 0;
    var_06 = param_00.useobj scripts\mp\gameobjects::getownerteam();
    var_07 = get_num_ally_flags(self.team);
    var_08 = get_enemy_flags(self.team);
    if(scripts\mp\bots\_bots_util::bot_is_capturing()) {
      if(var_06 == self.team && param_00.useobj.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all()) {
          var_05 = 1;
        }
      }

      if(var_07 == 2 && var_06 != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, param_00.origin) > var_02) {
          var_05 = 1;
        }
      }

      foreach(var_0A in var_08) {
        if(var_0A != param_00 && bot_allow_to_capture_flag(var_0A)) {
          if(distancesquared(self.origin, var_0A.origin) < var_03) {
            var_05 = 1;
          }
        }
      }

      if(self istouching(param_00) && param_00.useobj.userate <= 0) {
        if(self bothasscriptgoal()) {
          var_0C = self botgetscriptgoal();
          var_0D = self botgetscriptgoalradius();
          if(distancesquared(self.origin, var_0C) < squared(var_0D)) {
            var_0E = self getnearestnode();
            if(isDefined(var_0E)) {
              var_0F = undefined;
              foreach(var_11 in param_00.nodes) {
                if(!nodesvisible(var_11, var_0E)) {
                  var_0F = var_11.origin;
                  break;
                }
              }

              if(isDefined(var_0F)) {
                self.defense_investigate_specific_point = var_0F;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\_bots_util::bot_is_protecting()) {
      if(var_06 != self.team) {
        if(!bot_dom_debug_should_protect_all()) {
          var_05 = 1;
        }
      } else if(var_07 == 1 && var_01 > 1) {
        var_05 = 1;
      }
    }

    var_01 = var_07;
    if(var_05) {
      self.force_new_goal = 1;
      var_04 = 0;
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

bot_dom_get_node_chance(param_00) {
  if(param_00 == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!isDefined(self.current_flag)) {
    return 1;
  }

  var_01 = 0;
  var_02 = get_flag_label(self.current_flag);
  var_03 = get_ally_flags(self.team);
  foreach(var_05 in var_03) {
    if(var_05 != self.current_flag) {
      var_01 = param_00 scripts\mp\bots\_bots_util::node_is_on_path_from_labels(var_02, get_flag_label(var_05));
      if(var_01) {
        var_06 = get_other_flag(self.current_flag, var_05);
        var_07 = var_06.useobj scripts\mp\gameobjects::getownerteam();
        if(var_07 != self.team) {
          if(param_00 scripts\mp\bots\_bots_util::node_is_on_path_from_labels(var_02, get_flag_label(var_06))) {
            var_01 = 0;
          }
        }
      }
    }
  }

  if(var_01) {
    return 0.2;
  }

  return 1;
}

get_flag_label(param_00) {
  var_01 = "";
  if(isDefined(param_00.teleport_zone)) {
    var_01 = var_01 + param_00.teleport_zone + "_";
  }

  var_01 = var_01 + "flag" + param_00.script_label;
  return var_01;
}

get_other_flag(param_00, param_01) {
  for(var_02 = 0; var_02 < level.magicbullet.size; var_02++) {
    if(level.magicbullet[var_02] != param_00 && level.magicbullet[var_02] != param_01) {
      return level.magicbullet[var_02];
    }
  }
}

get_specific_flag(param_00) {
  param_00 = "_" + tolower(param_00);
  for(var_01 = 0; var_01 < level.magicbullet.size; var_01++) {
    if(level.magicbullet[var_01].script_label == param_00) {
      return level.magicbullet[var_01];
    }
  }
}

get_closest_flag(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in level.magicbullet) {
    var_05 = distancesquared(var_04.origin, param_00);
    if(!isDefined(var_02) || var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

get_num_allies_capturing_flag(param_00, param_01) {
  var_02 = 0;
  var_03 = get_flag_capture_radius();
  foreach(var_05 in level.participants) {
    if(!isDefined(var_05.team)) {
      continue;
    }

    if(var_05.team == self.team && var_05 != self && scripts\mp\utility::isteamparticipant(var_05)) {
      if(isai(var_05)) {
        if(var_05 bot_is_capturing_flag(param_00)) {
          var_02++;
        }

        continue;
      }

      if(!isDefined(param_01) || !param_01) {
        if(var_05 istouching(param_00)) {
          var_02++;
        }
      }
    }
  }

  return var_02;
}

bot_is_capturing_flag(param_00) {
  if(!scripts\mp\bots\_bots_util::bot_is_capturing()) {
    return 0;
  }

  return bot_target_is_flag(param_00);
}

bot_is_protecting_flag(param_00) {
  if(!scripts\mp\bots\_bots_util::bot_is_protecting()) {
    return 0;
  }

  return bot_target_is_flag(param_00);
}

bot_target_is_flag(param_00) {
  return isDefined(self.current_flag) && self.current_flag == param_00;
}

get_num_ally_flags(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.magicbullet.size; var_02++) {
    var_03 = level.magicbullet[var_02].useobj scripts\mp\gameobjects::getownerteam();
    if(var_03 == param_00) {
      var_01++;
    }
  }

  return var_01;
}

get_enemy_flags(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.magicbullet.size; var_02++) {
    var_03 = level.magicbullet[var_02].useobj scripts\mp\gameobjects::getownerteam();
    if(var_03 == scripts\engine\utility::get_enemy_team(param_00)) {
      var_01 = scripts\engine\utility::array_add(var_01, level.magicbullet[var_02]);
    }
  }

  return var_01;
}

get_ally_flags(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.magicbullet.size; var_02++) {
    var_03 = level.magicbullet[var_02].useobj scripts\mp\gameobjects::getownerteam();
    if(var_03 == param_00) {
      var_01 = scripts\engine\utility::array_add(var_01, level.magicbullet[var_02]);
    }
  }

  return var_01;
}

bot_should_defend_flag(param_00, param_01) {
  if(param_01 == 1) {
    var_02 = 1;
  } else {
    var_02 = 2;
  }

  var_03 = get_bots_defending_flag(param_00);
  return var_03.size < var_02;
}

get_bots_defending_flag(param_00) {
  var_01 = get_flag_protect_radius();
  var_02 = [];
  foreach(var_04 in level.participants) {
    if(!isDefined(var_04.team)) {
      continue;
    }

    if(var_04.team == self.team && var_04 != self && scripts\mp\utility::isteamparticipant(var_04)) {
      if(isai(var_04)) {
        if(var_04 bot_is_protecting_flag(param_00)) {
          var_02 = scripts\engine\utility::array_add(var_02, var_04);
        }

        continue;
      }

      if(distancesquared(param_00.origin, var_04.origin) < var_01 * var_01) {
        var_02 = scripts\engine\utility::array_add(var_02, var_04);
      }
    }
  }

  return var_02;
}