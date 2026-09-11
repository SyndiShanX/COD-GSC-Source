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

function crate_can_use(var0) {
  if(isagent(self) && !isDefined(var0.boxtype)) {
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
    var0 = scripts\mp\gametypes\dom::getflagteam();

    if(var0 != "neutral") {
      var1 = getzonenearest(self.trigger.origin);

      if(isDefined(var1)) {
        botzonesetteam(var1, var0);
      }
    }
  }
}

function monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var0 = scripts\mp\gametypes\dom::getflagteam();

  for(;;) {
    var1 = scripts\mp\gametypes\dom::getflagteam();

    if(var1 != var0) {
      level notify("flag_changed_ownership");
    }

    var0 = var1;
    wait 0.05;
  }
}

function setup_bot_dom(var0, var1) {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var2 = bot_get_all_possible_flags();

  if(var2.size > 3) {
    while(!isDefined(level.teleport_dom_finished_initializing)) {
      wait 0.05;
    }

    var3 = [];

    foreach(var5 in var2) {
      if(!isDefined(var3[var5.teleport_zone])) {
        var3 = [];
      }

      var3 = scripts\engine\utility::array_add(var3[var5.teleport_zone], var5);
    }

    foreach(var8 in var3) {
      level.entrance_points_finished_caching = 0;
      bot_cache_flag_distances(var8);
      scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(var8, var9 + "_flag", level.bot_ignore_precalc_paths);
    }
  } else {
    scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(var2, "flag", level.bot_ignore_precalc_paths);
    bot_cache_flag_distances(var2);
    thread bot_wait_for_event_flag_swap(var2);
  }

  foreach(var5 in var2) {
    thread monitor_flag_control();
    thread monitor_flag_ownership();

    if(var5.objectivekey != "_a" && var5.objectivekey != "_b" && var5.objectivekey != "_c") {}

    var5.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var5.trigger);
    var5.last_time_secured["allies"] = 0;
    var5.last_time_secured["axis"] = 0;
  }

  level.bot_dom_override_flag_targets = [];
  level.bot_dom_override_flag_targets["axis"] = [];
  level.bot_dom_override_flag_targets["allies"] = [];
  level.bot_gametype_precaching_done = 1;
}

function bot_wait_for_event_flag_swap(var0) {
  level endon("game_ended");
  level waittill("dom_flags_moved");
  scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(var0, "flag", level.bot_ignore_precalc_paths, 1);
  bot_cache_flag_distances(var0);

  foreach(var2 in var0) {
    var2.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var2);
  }

  foreach(var5 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var5)) {
      var5.force_new_goal = 1;
    }
  }
}

function bot_get_all_possible_flags() {
  if(isDefined(level.all_dom_flags)) {
    return level.all_dom_flags;
  }

  return level.objectives;
}

function bot_cache_flag_distances(var0) {
  if(!isDefined(level.flag_distances)) {
    level.flag_distances = [];
  }

  var1 = [];
  var2 = 0;

  foreach(var4 in var0) {
    var1 = var4;
    var2++;
  }

  for(var2 = 0; var2 < var1.size - 1; var2++) {
    for(var6 = var2 + 1; var6 < var1.size; var6++) {
      var7 = distance(var1[var2].trigger.origin, var1[var6].trigger.origin);
      var8 = get_flag_label(var1[var2]);
      var9 = get_flag_label(var1[var6]);
      level.flag_distances[var8][var9] = var7;
      level.flag_distances[var9][var8] = var7;
    }
  }
}

function should_start_cautious_approach_dom(var0) {
  if(var0) {
    if(self.current_flag scripts\mp\gametypes\dom::getflagteam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      var1 = get_closest_flag(self.lastspawnpoint.origin);

      if(var1 == self.current_flag) {
        return 0;
      } else {
        var2 = get_other_flag(var1, self.current_flag);
        var3 = distancesquared(var1.trigger.origin, self.current_flag.trigger.origin);
        var4 = distancesquared(var2.trigger.origin, self.current_flag.trigger.origin);

        if(var3 < var4) {
          return 0;
        }
      }
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var0);
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
    var0 = gettime();

    if(var0 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(var0 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision()) {
        self.new_goal_time = var0 + 5000;
      } else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var0 + randomintrange(30000, 45000);
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

  var0 = get_flag_capture_radius();

  if(distancesquared(self.origin, self.current_flag.trigger.origin) < var0 * 2 * var0 * 2) {
    var1 = get_ally_flags(self.team);

    if(var1.size == 2 && !scripts\engine\utility::array_contains(var1, self.current_flag) && !bot_allowed_to_3_cap()) {
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
  var0 = get_override_flag_targets();
  return var0.size > 0;
}

function flag_has_been_captured_before(var0) {
  return !flag_has_never_been_captured(var0);
}

function flag_has_never_been_captured(var0) {
  return var0.firstcapture;
}

function bot_choose_flag() {
  var0 = undefined;
  var1 = [];
  var2 = [];
  var3 = !istrue(level.precappoints);
  var4 = get_override_flag_targets();

  if(var4.size > 0) {
    var5 = var4;
  } else {
    var5 = level.objectives;
  }

  foreach(var8, var1 in var5) {
    var7 = var1 scripts\mp\gametypes\dom::getflagteam();

    if(var4) {
      if(flag_has_been_captured_before(var1)) {
        var4 = 0;
      }
    }

    if(var7 != self.team) {
      var2 = var1;
      continue;
    }

    var3 = var1;
  }

  var9 = undefined;

  if(var2.size == 3) {
    var9 = 1;
  } else if(var2.size == 2) {
    if(var3.size == 1) {
      if(!bot_should_defend_flag(var3[0], 1)) {
        var9 = 1;
      } else {
        var9 = !bot_should_defend(0.34);
      }

      if(scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team) == 1) {
        var9 = 1;
      }
    } else if(var3.size == 0) {
      var9 = 1;
    }
  } else if(var2.size == 1) {
    if(var3.size == 2) {
      if(bot_allowed_to_3_cap()) {
        if(!bot_should_defend_flag(var3[0], 2) && !bot_should_defend_flag(var3[1], 2)) {
          var9 = 1;
        } else if(self.strategy_level == 0) {
          var9 = !bot_should_defend(0.34);
        } else {
          var9 = !bot_should_defend(0.5);
        }
      } else {
        var9 = 0;
      }
    } else if(var3.size == 1) {
      if(!bot_should_defend_flag(var3[0], 1)) {
        var9 = 1;
      } else {
        var9 = !bot_should_defend(0.34);
      }
    } else if(var3.size == 0) {
      var9 = 1;
    }
  } else if(var2.size == 0) {
    var9 = 0;
  }

  if(var9) {
    if(var2.size > 1) {
      var10 = [];

      foreach(var12 in var2) {
        var10 = var12.trigger;
      }

      var14 = scripts\engine\utility::get_array_of_closest(self.origin, var10);
      var15 = [];

      foreach(var17 in var14) {
        foreach(var19 in level.objectives) {
          if(var19.trigger == var17) {
            var15 = var19;
          }
        }
      }

      var14 = var15;
    } else {
      var14 = var3;
    }

    if(var5 && !has_override_flag_targets()) {
      var22 = get_num_allies_capturing_flag(var14[0], 1);
      jumpiffalse(var22 < min_num_bots_assaulting_first_flag()) LOC_0000029f;
      var23 = 0;
      goto LOC_00000309;
    }

    if(var28.size == 1) {
      var5 = var28[0];
    } else if(distancesquared(var28[0].trigger.origin, self.origin) < 102400) {
      var5 = var28[0];
    } else {
      var29 = [];
      var30 = [];

      for(var31 = 0; var31 < var28.size; var31++) {
        var32 = distance(var28[var31].trigger.origin, self.origin);
        var30 = var32;
        var29 = var32;
      }

      if(var7.size == 1) {
        var33 = 1.5;

        for(var31 = 0; var31 < var29.size; var31++) {
          var29 = var29[var31] + level.flag_distances[get_flag_label(var28[var31])][get_flag_label(var7[0])] * var33;
        }
      }

      if(self.strategy_level == 0) {
        var27 = randomint(100);

        if(var27 < 50) {
          var5 = var28[0];
        } else if(var27 < 50 + 50 / (var28.size - 1)) {
          var5 = var28[1];
        } else {
          var5 = var28[2];
        }
      } else {
        if(var29.size == 2) {
          GscBinSkip1(0x45, 0, 50);
        }

        if(var29.size == 3) {
          GscBinSkip1(0x45, 0, 34);
        }
      }
    }
  } else {
    if(var7.size > 1) {
      var10 = [];

      foreach(var38 in var7) {
        var10 = var38.trigger;
      }

      var40 = scripts\engine\utility::get_array_of_closest(self.origin, var10);
      var15 = [];

      foreach(var17 in var40) {
        foreach(var19 in level.objectives) {
          if(var19.trigger == var17) {
            var15 = var19;
          }
        }
      }

      var40 = var15;
    } else {
      var40 = var8;
    }

    foreach(var46 in var40) {
      if(bot_should_defend_flag(var46, var8.size)) {
        var6 = var46;
        break;
      }
    }

    if(!isDefined(var6)) {
      if(self.strategy_level == 0) {
        var6 = var8[0];
      } else if(var40.size == 2) {
        var48 = get_other_flag(var40[0], var40[1]);
        var10 = [];

        foreach(var50 in var40) {
          var10 = var50.trigger;
        }

        var52 = scripts\engine\utility::get_array_of_closest(var48.trigger.origin, var10);
        var15 = [];

        foreach(var17 in var52) {
          foreach(var19 in level.objectives) {
            if(var19.trigger == var17) {
              var15 = var19;
            }
          }
        }

        var52 = var15;
        var27 = randomint(100);

        if(var27 < 70) {
          var6 = var52[0];
        } else {
          var6 = var52[1];
        }
      } else {
        var6 = var40[0];
      }
    }
  }

  if(var40) {
    capture_flag(var6);
    return;
  }

  defend_flag(var6);
}

function min_num_bots_assaulting_first_flag() {
  var0 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
  return ceil(var0 / 3);
}

function bot_allowed_to_3_cap() {
  if(self.strategy_level == 0) {
    return 1;
  }

  var0 = get_override_flag_targets();

  if(var0.size == 3) {
    return 1;
  }

  var1 = scripts\mp\gamescore::_getteamscore(scripts\engine\utility::get_enemy_team(self.team));
  var2 = scripts\mp\gamescore::_getteamscore(self.team);
  var3 = 200 - var1;
  var4 = 200 - var2;
  var5 = var4 * 0.5 > var3;
  return var5;
}

function bot_should_defend(var0) {
  if(randomfloat(1) < var0) {
    return 1;
  }

  var1 = level.bot_personality_type[self.personality];

  if(var1 == "stationary") {
    return 1;
  }

  if(var1 == "active") {
    return 0;
  }
}

function capture_flag(var0, var1, var2) {
  self.current_flag = var0;

  if(bot_dom_debug_should_protect_all()) {
    GscBinSkip1(0x45, "override_goal_type", var1);
  }

  GscBinSkip1(0x45, "override_goal_type", var1);
}

function defend_flag(var0) {
  self.current_flag = var0;

  if(bot_dom_debug_should_capture_all()) {
    GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var0));
  }

  GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var0));
}

function get_flag_capture_radius() {
  if(!isDefined(level.capture_radius)) {
    level.capture_radius = 158;
  }

  return level.capture_radius;
}

function get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    var0 = self botgetworldsize();
    var1 = (var0[0] + var0[1]) / 2;
    level.protect_radius = min(1000, var1 / 3.5);
  }

  return level.protect_radius;
}

function bot_dom_leader_dialog(var0, var1) {
  if(issubstr(var0, "losing") && var0 != "losing_score" && var0 != "losing_time" && var0 != "gamestate_domlosing") {
    var2 = getsubstr(var0, var0.size - 2);
    var3 = get_specific_flag_by_label(var2);

    if(isDefined(var3) && bot_allow_to_capture_flag(var3)) {
      self botmemoryevent("known_enemy", undefined, var3.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          var4 = distancesquared(self.origin, var3.trigger.origin) < 490000;
          var5 = bot_is_protecting_flag(var3);

          if(var4 || var5) {
            capture_flag(var3);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(var0, "secured")) {
    var2 = getsubstr(var0, var0.size - 2);
    var6 = get_specific_flag_by_label(var2);
    var6.last_time_secured[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::bot_leader_dialog(var0, var1);
}

function bot_allow_to_capture_flag(var0) {
  var1 = get_override_flag_targets();

  if(var1.size == 0) {
    return true;
  }

  if(scripts\engine\utility::array_contains(var1, var0)) {
    return true;
  }

  return false;
}

function monitor_flag_status(var0) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var1 = get_num_ally_flags(self.team);
  var2 = get_flag_capture_radius() * get_flag_capture_radius();
  var3 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
  var4 = 1;

  while(var4) {
    var5 = 0;
    var6 = var0 scripts\mp\gametypes\dom::getflagteam();
    var7 = get_num_ally_flags(self.team);
    var8 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(var6 == self.team && var0.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all()) {
          var5 = 1;
        }
      }

      if(var7 == 2 && var6 != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, var0.trigger.origin) > var2) {
          var5 = 1;
        }
      }

      foreach(var10 in var8) {
        if(var10 != var0 && bot_allow_to_capture_flag(var10)) {
          if(distancesquared(self.origin, var10.trigger.origin) < var3) {
            var5 = 1;
          }
        }
      }

      if(self istouching(var0.trigger) && var0.userate <= 0) {
        if(self bothasscriptgoal()) {
          var12 = self botgetscriptgoal();
          var13 = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, var12) < squared(var13)) {
            var14 = self getnearestnode();

            if(isDefined(var14)) {
              var15 = undefined;

              foreach(var17 in var0.nodes) {
                if(!nodesvisible(var17, var14, 1)) {
                  var15 = var17.origin;
                  break;
                }
              }

              if(isDefined(var15)) {
                self.defense_investigate_specific_point = var15;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
      if(var6 != self.team) {
        if(!bot_dom_debug_should_protect_all()) {
          var5 = 1;
        }
      } else if(var7 == 1 && var1 > 1) {
        var5 = 1;
      }
    }

    var1 = var7;

    if(var5) {
      self.force_new_goal = 1;
      var4 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var19 = level scripts\engine\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    var20 = isDefined(var19) && var19 == "timeout";

    if(!var20) {
      var21 = max((3 - self.strategy_level) * 1 + randomfloatrange(-0.5, 0.5), 0);
      wait var21;
    }
  }
}

function bot_dom_get_node_chance(var0) {
  if(var0 == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!isDefined(self.current_flag)) {
    return 1;
  }

  var1 = 0;
  var2 = get_flag_label(self.current_flag);
  var3 = get_ally_flags(self.team);

  foreach(var5 in var3) {
    if(var5 != self.current_flag) {
      var1 = var0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var2, get_flag_label(var5));

      if(var1) {
        var6 = get_other_flag(self.current_flag, var5);
        var7 = var6 scripts\mp\gametypes\dom::getflagteam();

        if(var7 != self.team) {
          if(var0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var2, get_flag_label(var6))) {
            var1 = 0;
          }
        }
      }
    }
  }

  if(var1) {
    return 0.2;
  }

  return 1;
}

function get_flag_label(var0) {
  var1 = "";

  if(isDefined(var0.teleport_zone)) {
    var1 += var0.teleport_zone + "_";
  }

  var1 += "flag" + var0.objectivekey;
  return var1;
}

function get_other_flag(var0, var1) {
  foreach(var3 in level.objectives) {
    if(var3 != var0 && var3 != var1) {
      return var3;
    }
  }
}

function get_specific_flag_by_letter(var0) {
  var1 = "_" + tolower(var0);
  return get_specific_flag_by_label(var1);
}

function get_specific_flag_by_label(var0) {
  foreach(var2 in level.objectives) {
    if(var2.objectivekey == var0) {
      return var2;
    }
  }
}

function get_closest_flag(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in level.objectives) {
    var5 = distancesquared(var4.trigger.origin, var0);

    if(!isDefined(var2) || var5 < var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  return var1;
}

function get_num_allies_capturing_flag(var0, var1) {
  var2 = 0;
  var3 = get_flag_capture_radius();

  foreach(var5 in level.participants) {
    if(!isDefined(var5.team)) {
      continue;
    }

    if(var5.team == self.team && var5 != self && scripts\mp\utility\entity::isteamparticipant(var5)) {
      if(isai(var5)) {
        if(bot_is_capturing_flag(var5, var0)) {
          var2++;
        }

        continue;
      }

      if(!isDefined(var1) || !var1) {
        if(var5 istouching(var0)) {
          var2++;
        }
      }
    }
  }

  return var2;
}

function bot_is_capturing_flag(var0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return 0;
  }

  return bot_target_is_flag(var0);
}

function bot_is_protecting_flag(var0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting()) {
    return 0;
  }

  return bot_target_is_flag(var0);
}

function bot_target_is_flag(var0) {
  return self.current_flag == var0;
}

function get_num_ally_flags(var0) {
  var1 = 0;

  foreach(var3 in level.objectives) {
    var4 = var3 scripts\mp\gametypes\dom::getflagteam();

    if(var4 == var0) {
      var1++;
    }
  }

  return var1;
}

function get_enemy_flags(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    var4 = var3 scripts\mp\gametypes\dom::getflagteam();

    if(var4 == scripts\engine\utility::get_enemy_team(var0)) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  return var1;
}

function get_ally_flags(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    var4 = var3 scripts\mp\gametypes\dom::getflagteam();

    if(var4 == var0) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  return var1;
}

function bot_should_defend_flag(var0, var1) {
  var2 = get_max_num_defenders_wanted_per_flag(var1);
  var3 = get_players_defending_flag(var0);
  return var3.size < var2;
}

function get_max_num_defenders_wanted_per_flag(var0) {
  var1 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(var0 == 1) {
    return ceil(var1 / 6);
  }

  return ceil(var1 / 3);
}

function get_players_defending_flag(var0) {
  var1 = get_flag_protect_radius();
  var2 = [];

  foreach(var4 in level.participants) {
    if(!isDefined(var4.team)) {
      continue;
    }

    if(var4.team == self.team && var4 != self && scripts\mp\utility\entity::isteamparticipant(var4)) {
      if(isai(var4)) {
        if(bot_is_protecting_flag(var4, var0)) {
          var2 = scripts\engine\utility::array_add(var2, var4);
        }

        continue;
      }

      var5 = gettime() - var0.last_time_secured[self.team];

      if(var5 < 10000) {
        continue;
      }

      if(distancesquared(var0.trigger.origin, var4.origin) < var1 * var1) {
        var2 = scripts\engine\utility::array_add(var2, var4);
      }
    }
  }

  return var2;
}