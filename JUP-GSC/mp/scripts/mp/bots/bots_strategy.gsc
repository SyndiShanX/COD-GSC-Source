/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_strategy.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_util;
#using scripts\mp\utility\entity;
#namespace bots_strategy;

function bot_defend_get_random_entrance_point_for_current_area() {
  var_d5b76d1e2cc71b6b = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isDefined(var_d5b76d1e2cc71b6b) && var_d5b76d1e2cc71b6b.size > 0) {
    return random(var_d5b76d1e2cc71b6b).origin;
  }

  return undefined;
}

function bot_defend_get_precalc_entrances_for_current_area(stance, var_fecd5903478d0482) {
  if(isDefined(self.defend_entrance_index)) {
    return bot_get_entrances_for_stance_and_index(stance, self.defend_entrance_index, var_fecd5903478d0482);
  }

  return [];
}

function bot_get_ambush_trap_item(var_d5160e708615340, var_d5163e7086159d9, var_d5162e7086157a6) {
  if(getdvarint(@ "bot_disableattack") == 1) {
    return undefined;
  }

  if(self botgetdifficultysetting("allowGrenades") == 0) {
    return undefined;
  }

  var_dbf63e06b8ca889a = [];
  var_dbf63e06b8ca889a[var_dbf63e06b8ca889a.size] = var_d5160e708615340;

  if(isDefined(var_d5163e7086159d9)) {
    var_dbf63e06b8ca889a[var_dbf63e06b8ca889a.size] = var_d5163e7086159d9;
  }

  if(isDefined(var_d5163e7086159d9)) {
    var_dbf63e06b8ca889a[var_dbf63e06b8ca889a.size] = var_d5162e7086157a6;
  }

  if(var_dbf63e06b8ca889a.size == 0) {
    return undefined;
  }

  items = self getweaponslistall();
  var_68939db9f7b6d3c4 = [];

  foreach(item in items) {
    if(self getweaponammoclip(item) > 0 || self getweaponammostock(item) > 0) {
      var_68939db9f7b6d3c4[var_68939db9f7b6d3c4.size] = item;
    }
  }

  if(var_68939db9f7b6d3c4.size <= 0) {
    return undefined;
  }

  foreach(purpose in var_dbf63e06b8ca889a) {
    foreach(item in var_68939db9f7b6d3c4) {
      if(bot_item_matches_purpose(purpose, item)) {
        result["purpose"] = purpose;
        bot_lethal = self botfirstavailablegrenade("lethal");

        if(isDefined(bot_lethal) && item == bot_lethal) {
          result["item_action"] = "lethal";
        }

        bot_tactical = self botfirstavailablegrenade("tactical");

        if(isDefined(bot_tactical) && item == bot_tactical) {
          result["item_action"] = "tactical";
        }

        result["weap_name"] = item;
        return result;
      }
    }
  }
}

function bot_set_ambush_trap(trap_item, ambush_entrances, ambush_node, ambush_yaw, trap_node) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(trap_item)) {
    return false;
  }

  var_65277efb57bfef86 = undefined;

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
        continue;
      }

      if(distancesquared(entrance.origin, ambush_node.origin) > 90000) {
        if(vectordot(fwd, vectorNormalize(entrance.origin - ambush_node.origin)) < 0.4) {
          choose_set[choose_set.size] = entrance;
        }
      }
    }

    if(choose_set.size > 0) {
      var_65277efb57bfef86 = random(choose_set);
      var_94e232e9ae9b3161 = getnodesinradius(var_65277efb57bfef86.origin, 300, 50);
      var_43f671c1b889e061 = [];

      foreach(node in var_94e232e9ae9b3161) {
        if(!isDefined(node.bot_ambush_end)) {
          var_43f671c1b889e061[var_43f671c1b889e061.size] = node;
        }
      }

      var_94e232e9ae9b3161 = var_43f671c1b889e061;
      trap_node = self botnodepick(var_94e232e9ae9b3161, min(var_94e232e9ae9b3161.size, 3), "node_trap", ambush_node, var_65277efb57bfef86);
    }
  }

  if(isDefined(trap_node)) {
    yaw = undefined;

    if(trap_item["purpose"] == "trap_directional" && isDefined(var_65277efb57bfef86)) {
      var_f5798034f8d40700 = vectortoangles(var_65277efb57bfef86.origin - trap_node.origin);
      yaw = var_f5798034f8d40700[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical") {
      self botclearscriptgoal();
    }

    goal_succeeded = self botsetscriptgoalnode(trap_node, "guard", yaw);

    if(goal_succeeded) {
      result = bot_waittill_goal_or_fail();

      if(result == "goal") {
        thread bot_force_stance_for_time("stand", 4);

        if(!isDefined(self.enemy) || !self botcanseeentity(self.enemy)) {
          thread bot_disable_movement_for_time(4);
          offset = (0, 0, 0);

          if(issubstr(trap_item["weap_name"].basename, "claymore")) {
            offset = (0, 0, 55);
          }

          if(isDefined(yaw)) {
            self botlookatpoint(var_65277efb57bfef86.origin + offset, 3, "script_forced");
          } else {
            self botlookatpoint(self.origin + offset + anglesToForward(self getplayerangles()) * 50, 3, "script_forced");
          }

          if(!isDefined(trap_item["item_action"])) {
            trap_item = bot_get_ambush_trap_item("trap_directional", "trap");
          }

          if(isDefined(trap_item["item_action"])) {
            bot_try_use_ambush_item(trap_item["item_action"]);
          }

          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("grenade_fire");
          thread bot_set_ambush_trap_wait_fire("missile_fire");
          timetowait = ter_op(isDefined(trap_item["purpose"]) && trap_item["purpose"] == "tacticalinsertion", 6, 3);
          waittill_any_timeout_2(timetowait, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");

          if(isDefined(self.ambush_trap_ent) && isDefined(trap_item["purpose"]) && trap_item["purpose"] == "c4") {
            thread bot_watch_manual_detonate(self.ambush_trap_ent, 300);
          }

          self.ambush_trap_ent = undefined;
          wait randomfloat(0.25);
          self notify("bot_force_stance_for_time");
          self botsetstance("none");
          self switchtoweapon("none");
          self notify("bot_disable_movement_for_time");
          self botsetflag("disable_movement", 0);
          self botlookatpoint(undefined);
        }
      }

      return true;
    }
  }

  return false;
}

function bot_try_use_ambush_item(button) {
  self endon("grenade_pullback");

  while(true) {
    self botpressbutton(button);
    wait 0.5;
  }
}

function bot_set_ambush_trap_wait_fire(waitingfor) {
  self endon("death_or_disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(waitingfor, ent);
  self.ambush_trap_ent = ent;
}

function bot_watch_manual_detonate(grenade, range) {
  self endon("death_or_disconnect");
  grenade endon("death");
  level endon("game_ended");
  rangesq = range * range;

  while(true) {
    if(distancesquared(self.origin, grenade.origin) > rangesq) {
      closestenemysq = self getclosestenemysqdist(grenade.origin, 1);

      if(closestenemysq < rangesq) {
        self botpressbutton("use", 0.25);
        wait 0.5;
        self botpressbutton("use", 0.25);
        return;
      }
    }

    wait randomfloatrange(0.25, 1);
  }
}

function bot_capture_point(point, radius, optional_params) {
  thread bot_defend_think(point, radius, "capture", optional_params);
}

function bot_capture_zone(point, nodes, capture_trigger, optional_params) {
  assert(isDefined(nodes) && nodes.size > 0);
  assert(isDefined(capture_trigger));

  if(!isDefined(nodes) || nodes.size == 0 || !isDefined(capture_trigger)) {
    return;
  }

  optional_params["capture_trigger"] = capture_trigger;
  thread bot_defend_think(point, nodes, "capture_zone", optional_params);
}

function bot_protect_point(point, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"])) {
    optional_params["min_goal_time"] = 12;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"])) {
    optional_params["max_goal_time"] = 18;
  }

  thread bot_defend_think(point, radius, "protect", optional_params);
}

function bot_protect_zone(nodes, defend_point, uniqueid, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"])) {
    optional_params["min_goal_time"] = 12;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"])) {
    optional_params["max_goal_time"] = 18;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["random_stance"])) {
    optional_params["random_stance"] = 1;
  }

  optional_params["uniqueID"] = uniqueid;
  thread bot_defend_think(defend_point, nodes, "protect_zone", optional_params);
}

function bot_patrol_area(point, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"])) {
    optional_params["min_goal_time"] = 0;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"])) {
    optional_params["max_goal_time"] = 0.01;
  }

  thread bot_defend_think(point, radius, "patrol", optional_params);
}

function bot_guard_player(player, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"])) {
    optional_params["min_goal_time"] = 15;
  }

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"])) {
    optional_params["max_goal_time"] = 20;
  }

  thread bot_defend_think(player, radius, "bodyguard", optional_params);
}

function bot_defend_requires_center(defense_type) {
  if(defense_type == "protect_zone") {
    return false;
  }

  return true;
}

function bot_defend_think(defendcenter, defendradius, defense_type, optional_params) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("defend_stop");

  if(!scripts\cp_mp\utility\game_utility::isaigameparticipant(self)) {
    assertmsg("<dev string:x1c>" + self.classname + "<dev string:x30>");
    return;
  }

  thread defense_death_monitor();

  if(isDefined(self.bot_defending) || self botgetscriptgoaltype() == "camp") {
    self botclearscriptgoal();
  }

  self.bot_defending = 1;
  self.bot_defending_type = defense_type;

  if(defense_type == "capture_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = defendradius;
    self.bot_defending_trigger = optional_params["capture_trigger"];
    assert(isDefined(self.bot_defending_nodes) && self.bot_defending_nodes.size > 0);

    if(!isDefined(self.bot_defending_nodes) || self.bot_defending_nodes.size == 0) {
      bot_defend_stop();
    }
  } else if(defense_type == "protect_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = defendradius;
    self.bot_defending_zone_id = optional_params["uniqueID"];
    assert(isDefined(self.bot_defending_zone_id));
    assert(isDefined(self.bot_defending_nodes) && self.bot_defending_nodes.size > 0);

    if(!isDefined(self.bot_defending_nodes) || self.bot_defending_nodes.size == 0) {
      bot_defend_stop();
    }
  } else {
    if(isDefined(optional_params)) {
      assertex(!isDefined(optional_params["<dev string:xa1>"]), "<dev string:xb4>");
    }

    self.bot_defending_radius = defendradius;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(bot_defend_requires_center(defense_type) && !isDefined(defendcenter)) {
    assertmsg("<dev string:x105>");
    bot_defend_stop();
  }

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(defendcenter)) {
    self.bot_defend_player_guarding = defendcenter;
    childthread monitor_defend_player();
  } else {
    self.bot_defend_player_guarding = undefined;
    self.bot_defending_center = defendcenter;
  }

  if(self.bot_defending_type == "<dev string:x143>") {
    if(!isDefined(self.bot_defend_player_guarding) || !scripts\cp_mp\utility\game_utility::isgameparticipant(self.bot_defend_player_guarding)) {
      assertmsg("<dev string:x150>" + self.name + "<dev string:x159>");
    }
  }

  self botsetstance("none");
  goal_type = undefined;
  min_goal_time = 6;
  max_goal_time = 10;
  self.defense_score_flags = [];

  if(isDefined(optional_params)) {
    self.defend_entrance_index = optional_params["entrance_points_index"];
    self.bot_defending_override_origin_node = optional_params["override_origin_node"];

    if(isDefined(optional_params["score_flags"])) {
      if(isarray(optional_params["score_flags"])) {
        self.defense_score_flags = optional_params["score_flags"];
      } else {
        self.defense_score_flags[0] = optional_params["score_flags"];
      }
    }

    if(isDefined(optional_params["override_goal_type"])) {
      goal_type = optional_params["override_goal_type"];
    }

    if(isDefined(optional_params["min_goal_time"])) {
      min_goal_time = optional_params["min_goal_time"];
    }

    if(isDefined(optional_params["max_goal_time"])) {
      max_goal_time = optional_params["max_goal_time"];
    }

    if(isDefined(optional_params["override_watch_nodes"]) && optional_params["override_watch_nodes"].size > 0) {
      self.defense_override_watch_nodes = optional_params["override_watch_nodes"];
    }

    self.defend_objective_radius = optional_params["objective_radius"];
  }

  if(!isDefined(self.bot_defend_player_guarding) && bot_defend_requires_center(defense_type)) {
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
      nearest_node = getclosestnodeinsight(defend_valid_center());
    }

    if(!isDefined(nearest_node)) {
      defend_center = defend_valid_center();
      nodes = getnodesinradiussorted(defend_center, 256, 0);

      for(i = 0; i < nodes.size; i++) {
        var_594f44744fb80561 = vectorNormalize(nodes[i].origin - defend_center);
        trace_start = defend_center + var_594f44744fb80561 * 15;

        if(sighttracepassed(trace_start, nodes[i].origin, 0, undefined)) {
          nearest_node = nodes[i];
          break;
        }

        wait 0.05;

        if(sighttracepassed(trace_start + (0, 0, 55), nodes[i].origin + (0, 0, 55), 0, undefined)) {
          nearest_node = nodes[i];
          break;
        }

        wait 0.05;
      }
    }

    self.node_closest_to_defend_center = nearest_node;
    assertex(isDefined(self.node_closest_to_defend_center), "<dev string:x182>" + defend_valid_center());
  } else if(isDefined(optional_params) && isDefined(optional_params["nearest_node_to_center"])) {
    self.node_closest_to_defend_center = optional_params["nearest_node_to_center"];
  }

  assertex(min_goal_time < max_goal_time, "<dev string:x1d0>");
  var_339f8ba30bfe82bc = level.bot_find_defend_node_func[defense_type];

  if(!isDefined(goal_type)) {
    goal_type = "guard";

    if(defense_type == "capture" || defense_type == "capture_zone") {
      goal_type = "objective";
    }
  }

  var_81a934c1f7d7e976 = 0;
  var_33b8d7005a8510ca = 0;

  if(bot_is_capturing()) {
    var_81a934c1f7d7e976 = 1;
    var_33b8d7005a8510ca = isDefined(optional_params) && isDefined(optional_params["entrance_points_index"]) && isarray(optional_params["entrance_points_index"]);
  } else if(isDefined(optional_params) && istrue(optional_params["random_stance"])) {
    var_81a934c1f7d7e976 = 1;
    var_33b8d7005a8510ca = 1;
  }

  var_f5096f93a28105b8 = 1;

  if(isDefined(optional_params) && istrue(optional_params["dont_leave_goal_during_combat"])) {
    var_f5096f93a28105b8 = 0;
  }

  if(defense_type == "protect") {
    childthread protect_watch_allies();
  }

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.cur_defend_stance = calculate_defend_stance(var_81a934c1f7d7e976, var_33b8d7005a8510ca);
    var_e7073093c8c51701 = self botgetscriptgoaltype();
    var_33c1cc1033245f18 = bot_goal_can_override(goal_type, var_e7073093c8c51701);

    if(!var_33c1cc1033245f18) {
      wait 0.25;
      continue;
    }

    var_6462f213110d0c30 = min_goal_time;
    var_9f09525e6f9a8906 = max_goal_time;
    var_78a174eab45c6c23 = 1;

    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      var_78a174eab45c6c23 = 0;
      var_6462f213110d0c30 = 1;
      var_9f09525e6f9a8906 = 2;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      if(isDefined(level.aerial_danger_exists_for) && level.aerial_danger_exists_for[self.team]) {
        if(!array_contains(self.defense_score_flags, "avoid_aerial_enemies")) {
          self.defense_score_flags[self.defense_score_flags.size] = "avoid_aerial_enemies";
        }
      }

      self[[var_339f8ba30bfe82bc]]();
    }

    self botclearscriptgoal();
    result = "";

    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(var_78a174eab45c6c23 && bot_is_protecting() && !isPlayer(defendcenter) && isDefined(self.defend_entrance_index)) {
        trap_item = bot_get_ambush_trap_item("trap_directional", "trap", "c4");

        if(isDefined(trap_item)) {
          entrances = bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(trap_item, entrances, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        yaw = undefined;

        if(isDefined(self.cur_defend_angle_override)) {
          yaw = self.cur_defend_angle_override[1];
        }

        self botsetscriptgoal(self.cur_defend_point_override, 0, goal_type, yaw, self.defend_objective_radius);
      } else if(!isDefined(self.cur_defend_angle_override)) {
        self botsetscriptgoalnode(self.cur_defend_node, goal_type, undefined, self.defend_objective_radius);
      } else {
        self botsetscriptgoalnode(self.cur_defend_node, goal_type, self.cur_defend_angle_override[1], self.defend_objective_radius);
      }

      if(var_81a934c1f7d7e976) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node) {
          self botsetstance("none");
        }
      }

      previous_goal = self botgetscriptgoal();
      self notify("new_defend_goal");
      watch_nodes_stop();

      if(goal_type == "objective") {
        defense_cautious_approach();
        self botsetawareness(1);
        self botsetflag("cautious", 0);
      }

      if(self bothasscriptgoal()) {
        current_goal = self botgetscriptgoal();

        if(bot_vectors_are_equal(current_goal, previous_goal)) {
          result = bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
        }
      }

      if(result == "goal") {
        if(var_81a934c1f7d7e976) {
          self botsetstance(self.cur_defend_stance);
        }

        childthread defense_watch_entrances_at_goal();

        if(var_78a174eab45c6c23 && bot_is_protecting() && !isPlayer(defendcenter) && isDefined(self.defend_entrance_index)) {
          scripts\mp\bots\bots_personality::bot_try_trap_follower();
        }
      }
    }

    if(result != "goal") {
      time = 0.25;

      if(result == "no_path" && isDefined(self.defend_wait_time_when_no_path)) {
        time = self.defend_wait_time_when_no_path;
      }

      wait time;
      continue;
    }

    wait_time = randomfloatrange(var_6462f213110d0c30, var_9f09525e6f9a8906);
    result = waittill_any_timeout_5(wait_time, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((result == "node_relinquished" || result == "bad_path" || result == "goal_changed" || result == "script_goal_changed") && (self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone")) {
      self botsetstance("none");
    }

    if(result == "timeout" && !var_f5096f93a28105b8) {
      bot_waittill_out_of_combat_or_time();
    }
  }
}

function calculate_defend_stance(var_81a934c1f7d7e976, var_97df6ee9f2fe6188) {
  stance = "stand";

  if(var_81a934c1f7d7e976) {
    var_55bb9ec645ada05c = 100;
    var_b42989b458b54982 = 0;
    var_8e7073e75873765a = 0;
    strategy_level = self botgetdifficultysetting("strategyLevel");

    if(strategy_level == 1) {
      var_55bb9ec645ada05c = 20;
      var_b42989b458b54982 = 25;
      var_8e7073e75873765a = 55;
    } else if(strategy_level >= 2) {
      var_55bb9ec645ada05c = 10;
      var_b42989b458b54982 = 20;
      var_8e7073e75873765a = 70;
    }

    choice = randomint(100);

    if(choice < var_b42989b458b54982) {
      stance = "crouch";
    } else if(choice < var_b42989b458b54982 + var_8e7073e75873765a) {
      stance = "prone";
    }

    var_f218c8e9e8858c5e = !isDefined(var_97df6ee9f2fe6188) || !var_97df6ee9f2fe6188;

    if(var_f218c8e9e8858c5e && stance == "prone") {
      var_5fa45bb134aebc31 = bot_defend_get_precalc_entrances_for_current_area("prone");
      var_e10e66576540c59e = defend_get_ally_bots_at_zone_for_stance("prone");

      if(var_e10e66576540c59e.size >= var_5fa45bb134aebc31.size) {
        stance = "crouch";
      }
    }

    if(var_f218c8e9e8858c5e && stance == "crouch") {
      var_297c1279113e2757 = bot_defend_get_precalc_entrances_for_current_area("crouch");
      var_a4439bf074b564e5 = defend_get_ally_bots_at_zone_for_stance("crouch");

      if(var_a4439bf074b564e5.size >= var_297c1279113e2757.size) {
        stance = "stand";
      }
    }
  }

  return stance;
}

function should_start_cautious_approach_default(firstcheck) {
  var_8fa07dc6dc122490 = 1250;
  var_334d85f434992401 = var_8fa07dc6dc122490 * var_8fa07dc6dc122490;

  if(firstcheck) {
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      return 0;
    }

    if(self.bot_defending_type == "capture_zone" && isDefined(self.bot_defending_trigger) && self istouching(self.bot_defending_trigger)) {
      return 0;
    }

    return (distancesquared(self.origin, self.bot_defending_center) > var_334d85f434992401 * 0.75 * 0.75);
  }

  if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < var_334d85f434992401) {
    var_647b4bb147d18201 = self botgetpathdist();
    return (0 <= var_647b4bb147d18201 && var_647b4bb147d18201 <= var_8fa07dc6dc122490);
  }

  return 0;
}

function setup_investigate_location(node, optional_location) {
  new_location = spawnStruct();

  if(isDefined(optional_location)) {
    new_location.origin = optional_location;
  } else {
    new_location.origin = node.origin;
  }

  assertex(isDefined(node), "<dev string:x217>" + new_location.origin + "<dev string:x236>");
  new_location.node = node;
  new_location.frames_visible = 0;
  return new_location;
}

function defense_cautious_approach() {
  self notify("defense_cautious_approach");
  self endon("defense_cautious_approach");
  level endon("game_ended");
  self endon("defend_force_node_recalculation");
  self endon("death_or_disconnect");
  self endon("defend_stop");
  self endon("started_bot_defend_think");

  if(true) {
    return;
  }

  if(![[level.bot_funcs["should_start_cautious_approach"]]](1)) {
    return;
  }

  var_92230fb89972f06a = self botgetscriptgoal();
  var_4c3d0077fa7d56ef = self botgetscriptgoalnode();

  if(isDefined(var_4c3d0077fa7d56ef)) {
    assert(self.cur_defend_node == var_4c3d0077fa7d56ef);
  } else {
    assert(isDefined(self.cur_defend_point_override));
    assert(bot_vectors_are_equal(var_92230fb89972f06a, self.cur_defend_point_override));
  }

  var_45c020be05608172 = 1;
  var_cb0da3ae63287098 = 0.2;
  var_eeb18c09526831f4 = 0;

  while(var_45c020be05608172) {
    wait 0.25;
    var_eeb18c09526831f4 += 0.25;

    if(!self bothasscriptgoal()) {
      return;
    }

    var_b2a9a67eb5732e9a = self botgetscriptgoal();

    if(!bot_vectors_are_equal(var_92230fb89972f06a, var_b2a9a67eb5732e9a)) {
      return;
    }

    if(var_eeb18c09526831f4 >= 1) {
      current_path = self botgetnodesonpath();

      if(current_path.size == 0) {
        self botclearscriptgoal();
        return;
      }
    }

    var_cb0da3ae63287098 += 0.25;

    if(var_cb0da3ae63287098 >= 0.5) {
      var_cb0da3ae63287098 = 0;

      if([[level.bot_funcs["should_start_cautious_approach"]]](0)) {
        var_45c020be05608172 = 0;
      }
    }
  }

  self botsetawareness(1.8);
  self botsetflag("cautious", 1);
  var_55d2448dd14fbb1e = self botgetnodesonpath();

  if(!isDefined(var_55d2448dd14fbb1e) || var_55d2448dd14fbb1e.size <= 2) {
    return;
  }

  self.locations_to_investigate = [];
  radius_around_point = 1000;

  if(isDefined(level.protect_radius)) {
    radius_around_point = level.protect_radius;
  }

  var_51ca426712b96df5 = radius_around_point * radius_around_point;
  var_b3464eeebef71679 = getnodesinradius(self.bot_defending_center, radius_around_point, 0, 500);

  if(var_b3464eeebef71679.size <= 0) {
    return;
  }

  var_8529e9f32cf6579c = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  var_f570f5d5d761c173 = int(min(var_8529e9f32cf6579c, var_b3464eeebef71679.size));
  var_b784196cf6d9c696 = self botnodepickmultiple(var_b3464eeebef71679, 15, var_f570f5d5d761c173, "node_protect", defend_valid_center(), "ignore_occupancy");

  for(i = 0; i < var_b784196cf6d9c696.size; i++) {
    new_location = setup_investigate_location(var_b784196cf6d9c696[i]);
    self.locations_to_investigate = array_add(self.locations_to_investigate, new_location);
  }

  killer_locations = botgetmemoryevents(0, gettime() - 60000, 1, "death", 0, self);

  foreach(location in killer_locations) {
    if(distancesquared(location, self.bot_defending_center) < var_51ca426712b96df5) {
      var_ba8a43c132fa515a = getclosestnodeinsight(location);

      if(isDefined(var_ba8a43c132fa515a)) {
        new_location = setup_investigate_location(var_ba8a43c132fa515a, location);
        self.locations_to_investigate = array_add(self.locations_to_investigate, new_location);
      }
    }
  }

  if(isDefined(self.defend_entrance_index)) {
    var_77eeca99c75956f8 = bot_get_entrances_for_stance_and_index("stand", self.defend_entrance_index);

    for(i = 0; i < var_77eeca99c75956f8.size; i++) {
      new_location = setup_investigate_location(var_77eeca99c75956f8[i]);
      self.locations_to_investigate = array_add(self.locations_to_investigate, new_location);
    }
  }

  if(self.locations_to_investigate.size == 0) {
    return;
  }

  childthread monitor_cautious_approach_dangerous_locations();
  goal_type = self botgetscriptgoaltype();
  var_c8f6aca9ea35b446 = self botgetscriptgoalRadius();
  var_1da81e91aab37a9b = self botgetscriptgoalyaw();
  wait 0.05;

  for(var_f51c48051ffca680 = 1; var_f51c48051ffca680 < var_55d2448dd14fbb1e.size - 2; var_f51c48051ffca680++) {
    bot_waittill_out_of_combat_or_time();
    var_906d6b682a625fdc = getlinkednodes(var_55d2448dd14fbb1e[var_f51c48051ffca680]);

    if(var_906d6b682a625fdc.size == 0) {
      continue;
    }

    var_8594aeb2834c5d66 = [];

    for(i = 0; i < var_906d6b682a625fdc.size; i++) {
      if(!within_fov(self.origin, self getplayerangles(), var_906d6b682a625fdc[i].origin, 0)) {
        continue;
      }

      for(j = 0; j < self.locations_to_investigate.size; j++) {
        location = self.locations_to_investigate[j];

        if(nodesvisible(location.node, var_906d6b682a625fdc[i], 1)) {
          var_8594aeb2834c5d66 = array_add(var_8594aeb2834c5d66, var_906d6b682a625fdc[i]);
          j = self.locations_to_investigate.size;
        }
      }
    }

    if(var_8594aeb2834c5d66.size == 0) {
      continue;
    }

    hide_node = self botnodepick(var_8594aeb2834c5d66, 1 + var_8594aeb2834c5d66.size * 0.15, "node_hide");

    if(isDefined(hide_node)) {
      var_724c1907987840a4 = [];

      for(i = 0; i < self.locations_to_investigate.size; i++) {
        if(nodesvisible(self.locations_to_investigate[i].node, hide_node, 1)) {
          if(distance2dsquared(self.locations_to_investigate[i].origin, hide_node.origin) > 3600) {
            var_724c1907987840a4 = array_add(var_724c1907987840a4, self.locations_to_investigate[i]);
          }
        }
      }

      self botclearscriptgoal();
      self botsetscriptgoalnode(hide_node, "critical");
      childthread monitor_cautious_approach_early_out();
      result = bot_waittill_goal_or_fail(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");

      if(result == "cautious_approach_early_out") {
        break;
      }

      if(result == "goal") {
        for(i = 0; i < var_724c1907987840a4.size; i++) {
          if(distance2dsquared(self.origin, var_724c1907987840a4[i].origin) < 1600) {
            continue;
          }

          var_eeb18c09526831f4 = 0;

          while(var_724c1907987840a4[i].frames_visible < 18 && var_eeb18c09526831f4 < 3.6) {
            self botlookatpoint(var_724c1907987840a4[i].origin + (0, 0, self getplayerviewheight()), 0.25, "script_search");
            wait 0.25;
            var_eeb18c09526831f4 += 0.25;
          }
        }
      }
    }

    wait 0.05;
  }

  self notify("stop_location_monitoring");
  self botclearscriptgoal();

  if(isDefined(var_4c3d0077fa7d56ef)) {
    self botsetscriptgoalnode(var_4c3d0077fa7d56ef, goal_type, var_1da81e91aab37a9b);
    return;
  }

  self botsetscriptgoal(self.cur_defend_point_override, var_c8f6aca9ea35b446, goal_type, var_1da81e91aab37a9b);
}

function monitor_cautious_approach_early_out() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_82fe1c44f0e59dd5 = undefined;

  if(isDefined(self.bot_defending_radius)) {
    var_82fe1c44f0e59dd5 = self.bot_defending_radius * self.bot_defending_radius;
  } else if(isDefined(self.bot_defending_nodes)) {
    var_3432c95d4c01bbfb = bot_capture_zone_get_furthest_distance();
    var_82fe1c44f0e59dd5 = var_3432c95d4c01bbfb * var_3432c95d4c01bbfb;
  }

  wait 0.05;

  while(true) {
    if(distancesquared(self.origin, self.bot_defending_center) < var_82fe1c44f0e59dd5) {
      self notify("cautious_approach_early_out");
    }

    wait 0.05;
  }
}

function monitor_cautious_approach_dangerous_locations() {
  self endon("stop_location_monitoring");
  var_f3edcefbabc5a8f0 = 10000;

  while(true) {
    var_f6cbde8cc73449c9 = self getnearestnode();

    if(isDefined(var_f6cbde8cc73449c9)) {
      bot_fov = self botgetfovdot();

      for(i = 0; i < self.locations_to_investigate.size; i++) {
        if(nodesvisible(var_f6cbde8cc73449c9, self.locations_to_investigate[i].node, 1)) {
          node_within_fov = within_fov(self.origin, self getplayerangles(), self.locations_to_investigate[i].origin, bot_fov);
          var_c9f1df8d1fd67fda = !node_within_fov || self.locations_to_investigate[i].frames_visible < 17;

          if(var_c9f1df8d1fd67fda && distancesquared(self.origin, self.locations_to_investigate[i].origin) < var_f3edcefbabc5a8f0) {
            node_within_fov = 1;
            self.locations_to_investigate[i].frames_visible = 18;
          }

          if(node_within_fov) {
            self.locations_to_investigate[i].frames_visible++;

            if(self.locations_to_investigate[i].frames_visible >= 18) {
              self.locations_to_investigate[i] = self.locations_to_investigate[self.locations_to_investigate.size - 1];
              self.locations_to_investigate[self.locations_to_investigate.size - 1] = undefined;
              i--;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

function protect_watch_allies() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_cf1dc37d165e2f3 = [];
  minimap_radius = 1050;
  var_f5b7c9d0d13192e4 = minimap_radius * minimap_radius;
  radius_around_point = 900;

  if(isDefined(level.protect_radius)) {
    radius_around_point = level.protect_radius;
  }

  while(true) {
    cur_time = gettime();
    var_a2fde156132cad23 = bot_get_teammates_in_radius(self.bot_defending_center, radius_around_point);

    foreach(teammate in var_a2fde156132cad23) {
      var_96a7043372f6f04e = teammate.entity_number;

      if(!isDefined(var_96a7043372f6f04e)) {
        var_96a7043372f6f04e = teammate getentitynumber();
      }

      if(!isDefined(var_cf1dc37d165e2f3[var_96a7043372f6f04e])) {
        var_cf1dc37d165e2f3[var_96a7043372f6f04e] = cur_time - 1;
      }

      if(!isDefined(teammate.last_investigation_time)) {
        teammate.last_investigation_time = cur_time - 10001;
      }

      if(teammate.health == 0 && isDefined(teammate.deathtime) && cur_time - teammate.deathtime < 5000) {
        if(cur_time - teammate.last_investigation_time > 10000 && cur_time > var_cf1dc37d165e2f3[var_96a7043372f6f04e]) {
          if(isDefined(teammate.lastattacker) && isDefined(teammate.lastattacker.team) && teammate.lastattacker.team == get_enemy_team(self.team)) {
            if(distancesquared(teammate.body.origin, self.origin) < var_f5b7c9d0d13192e4) {
              self botgetimperfectenemyinfo(teammate.lastattacker, teammate.body.origin);
              var_56681ccff326541b = getclosestnodeinsight(teammate.body.origin);

              if(isDefined(var_56681ccff326541b)) {
                self.defense_investigate_specific_point = var_56681ccff326541b.origin;
                self notify("defend_force_node_recalculation");
              }

              teammate.last_investigation_time = cur_time;
            }

            var_cf1dc37d165e2f3[var_96a7043372f6f04e] = cur_time + 10000;
          }
        }
      }
    }

    wait(randomint(5) + 1) * 0.05;
  }
}

function defense_get_initial_entrances() {
  if(isDefined(self.defense_override_watch_nodes)) {
    return self.defense_override_watch_nodes;
  }

  if(bot_is_capturing()) {
    return bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance, 1);
  }

  if(bot_is_protecting() || bot_is_bodyguarding()) {
    entrances = findentrances(self.origin);

    if(isDefined(self getnearestnode()) && !(isDefined(level.var_a4e60ff6b2b0e717) && level.var_a4e60ff6b2b0e717)) {
      assertex(entrances.size > 0, "<dev string:x246>" + self.origin + "<dev string:x26e>");
    }

    return entrances;
  }
}

function defense_watch_entrances_at_goal() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var_170e87a3a1e8af42 = self getnearestnode();
  var_77eeca99c75956f8 = undefined;

  if(bot_is_capturing()) {
    var_3c31225bf8caa5ea = defense_get_initial_entrances();
    var_77eeca99c75956f8 = [];

    if(isDefined(var_170e87a3a1e8af42)) {
      foreach(entrance in var_3c31225bf8caa5ea) {
        if(nodesvisible(var_170e87a3a1e8af42, entrance, 1)) {
          var_77eeca99c75956f8 = array_add(var_77eeca99c75956f8, entrance);
        }
      }
    }

    if(var_77eeca99c75956f8.size == 0) {
      var_77eeca99c75956f8 = findentrances(self.origin);
    }
  } else if(bot_is_protecting() || bot_is_bodyguarding()) {
    var_77eeca99c75956f8 = defense_get_initial_entrances();
    currentweapon = self getcurrentweapon();

    if(isDefined(var_170e87a3a1e8af42) && !issubstr(currentweapon.basename, "riotshield") && isDefined(self.node_closest_to_defend_center)) {
      if(nodesvisible(var_170e87a3a1e8af42, self.node_closest_to_defend_center, 1)) {
        var_77eeca99c75956f8 = array_add(var_77eeca99c75956f8, self.node_closest_to_defend_center);
      }
    }
  }

  if(isDefined(var_77eeca99c75956f8)) {
    childthread bot_watch_nodes(var_77eeca99c75956f8);

    if(bot_is_bodyguarding()) {
      childthread bot_monitor_watch_entrances_bodyguard();
      return;
    }

    if(isDefined(level.bot_funcs["bot_entrance_update"])) {
      self childthread[[level.bot_funcs["bot_entrance_update"]]]();
      return;
    }

    childthread bot_monitor_watch_entrances_at_goal();
  }
}

function bot_monitor_watch_entrances_at_goal() {
  self notify("bot_monitor_watch_entrances_at_goal");
  self endon("bot_monitor_watch_entrances_at_goal");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");

  while(!isDefined(self.watch_nodes)) {
    wait 0.05;
  }

  var_16da7e3afe815065 = level.bot_funcs["get_watch_node_chance"];

  while(true) {
    assert(isDefined(self.watch_nodes));
    center_chance = 0.8;
    var_8fad49fea979715d = 1;

    if(array_contains(self.defense_score_flags, "strict_los")) {
      center_chance = 1;
      var_8fad49fea979715d = 0.5;
    }

    if(isDefined(self.node_closest_to_defend_center)) {
      foreach(node in self.watch_nodes) {
        if(node == self.node_closest_to_defend_center) {
          node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number] * center_chance;
          continue;
        }

        node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number] * var_8fad49fea979715d;
      }
    }

    var_9bc4f8e26f7a0ac4 = isDefined(var_16da7e3afe815065);

    if(!var_9bc4f8e26f7a0ac4) {
      prioritize_watch_nodes_toward_enemies(0.5);
    }

    foreach(node in self.watch_nodes) {
      if(var_9bc4f8e26f7a0ac4) {
        gametype_scalar = self[[var_16da7e3afe815065]](node);
        node.watch_node_chance[self.entity_number] *= gametype_scalar;
      }

      if(entrance_watched_by_ally(node)) {
        node.watch_node_chance[self.entity_number] *= 0.5;
      }
    }

    wait randomfloatrange(0.5, 0.75);
  }
}

function bot_monitor_watch_entrances_bodyguard() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");

  while(!isDefined(self.watch_nodes)) {
    wait 0.05;
  }

  while(true) {
    var_fe3d6fb608e9eed8 = anglesToForward(self.bot_defend_player_guarding getplayerangles()) * (1, 1, 0);
    var_fe3d6fb608e9eed8 = vectorNormalize(var_fe3d6fb608e9eed8);

    foreach(node in self.watch_nodes) {
      node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number];
      player_to_node = node.origin - self.bot_defend_player_guarding.origin;
      player_to_node = vectorNormalize(player_to_node);
      var_a1cd126b61eabd2 = vectordot(var_fe3d6fb608e9eed8, player_to_node);

      if(var_a1cd126b61eabd2 > 0.6) {
        node.watch_node_chance[self.entity_number] *= 0.33;
      } else if(var_a1cd126b61eabd2 > 0) {
        node.watch_node_chance[self.entity_number] *= 0.66;
      }

      if(!entrance_to_enemy_zone(node)) {
        node.watch_node_chance[self.entity_number] *= 0.5;
      }
    }

    wait randomfloatrange(0.4, 0.6);
  }
}

function entrance_to_enemy_zone(entrance) {
  var_405daa810191cba9 = getnodezone(entrance);
  var_f2ed0b797104fa5 = vectorNormalize(entrance.origin - self.origin);

  for(z = 0; z < level.zonecount; z++) {
    if(botzonegetcount(z, self.team, "enemy_predict") > 0) {
      if(isDefined(var_405daa810191cba9) && z == var_405daa810191cba9) {
        return true;
      }

      var_4aa6951b8641043d = vectorNormalize(getzoneorigin(z) - self.origin);
      dot = vectordot(var_f2ed0b797104fa5, var_4aa6951b8641043d);

      if(dot > 0.2) {
        return true;
      }
    }
  }

  return false;
}

function prioritize_watch_nodes_toward_enemies(scalar) {
  assert(isDefined(self.watch_nodes));

  if(self.watch_nodes.size <= 0) {
    return;
  }

  nodes_testing = self.watch_nodes;

  for(z = 0; z < level.zonecount; z++) {
    if(botzonegetcount(z, self.team, "enemy_predict") <= 0) {
      continue;
    }

    if(nodes_testing.size == 0) {
      break;
    }

    var_4aa6951b8641043d = vectorNormalize(getzoneorigin(z) - self.origin);

    for(i = 0; i < nodes_testing.size; i++) {
      var_e5dcbeec9029ae9f = getnodezone(nodes_testing[i]);
      var_a296921504813986 = 0;

      if(isDefined(var_e5dcbeec9029ae9f) && z == var_e5dcbeec9029ae9f) {
        var_a296921504813986 = 1;
      } else {
        var_a295c00559b01807 = vectorNormalize(nodes_testing[i].origin - self.origin);
        dot = vectordot(var_a295c00559b01807, var_4aa6951b8641043d);

        if(dot > 0.2) {
          var_a296921504813986 = 1;
        }
      }

      if(var_a296921504813986) {
        nodes_testing[i].watch_node_chance[self.entity_number] *= scalar;
        nodes_testing[i] = nodes_testing[nodes_testing.size - 1];
        nodes_testing[nodes_testing.size - 1] = undefined;
        i--;
      }
    }
  }
}

function entrance_watched_by_ally(entrance) {
  if(self.bot_defending_type == "protect_zone") {
    var_a2fde156132cad23 = bot_get_teammates_currently_defending_zone(self.bot_defending_zone_id);
  } else {
    var_a2fde156132cad23 = bot_get_teammates_currently_defending_point(self.bot_defending_center);
  }

  foreach(teammate in var_a2fde156132cad23) {
    if(entrance_watched_by_player(teammate, entrance)) {
      return true;
    }
  }

  return false;
}

function entrance_watched_by_player(player, entrance) {
  player_forward = anglesToForward(player getplayerangles());
  player_to_node = vectorNormalize(entrance.origin - player.origin);
  var_a1cd126b61eabd2 = vectordot(player_forward, player_to_node);

  if(var_a1cd126b61eabd2 > 0.6) {
    return true;
  }

  return false;
}

function bot_get_teammates_currently_defending_zone(zoneid) {
  var_33de4b46d339a890 = [];
  teammates_in_radius = bot_get_teammates_in_radius(self.origin, 1000);

  foreach(teammate in teammates_in_radius) {
    if(!isai(teammate) || teammate bot_is_defending() && teammate.bot_defending_zone_id == zoneid) {
      var_33de4b46d339a890 = array_add(var_33de4b46d339a890, teammate);
    }
  }

  return var_33de4b46d339a890;
}

function bot_get_teammates_currently_defending_point(point, radius_around_point) {
  if(!isDefined(radius_around_point)) {
    if(isDefined(level.protect_radius)) {
      radius_around_point = level.protect_radius;
    } else {
      radius_around_point = 900;
    }
  }

  var_33de4b46d339a890 = [];
  teammates_in_radius = bot_get_teammates_in_radius(point, radius_around_point);

  foreach(teammate in teammates_in_radius) {
    if(!isai(teammate) || teammate bot_is_defending_point(point)) {
      var_33de4b46d339a890 = array_add(var_33de4b46d339a890, teammate);
    }
  }

  return var_33de4b46d339a890;
}

function bot_get_teammates_in_radius(point, radius_around_point) {
  var_51ca426712b96df5 = radius_around_point * radius_around_point;
  teammates_in_radius = [];

  for(i = 0; i < level.participants.size; i++) {
    other_player = level.participants[i];

    if(other_player != self && isDefined(other_player.team) && other_player.team == self.team && isteamparticipant(other_player)) {
      if(distancesquared(point, other_player.origin) < var_51ca426712b96df5) {
        teammates_in_radius = array_add(teammates_in_radius, other_player);
      }
    }
  }

  return teammates_in_radius;
}

function defense_death_monitor() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self)) {
    thread bot_defend_stop();
  }
}

function bot_defend_stop() {
  self notify("defend_stop");
  self.bot_defending = undefined;
  self.bot_defending_center = undefined;
  self.bot_defending_radius = undefined;
  self.bot_defending_nodes = undefined;
  self.bot_defending_type = undefined;
  self.bot_defending_trigger = undefined;
  self.bot_defending_override_origin_node = undefined;
  self.bot_defend_player_guarding = undefined;
  self.bot_defending_zone_id = undefined;
  self.defense_score_flags = undefined;
  self.node_closest_to_defend_center = undefined;
  self.defense_investigate_specific_point = undefined;
  self.defense_force_next_node_goal = undefined;
  self.defend_objective_radius = undefined;
  self.prev_defend_node = undefined;
  self.cur_defend_node = undefined;
  self.cur_defend_angle_override = undefined;
  self.cur_defend_point_override = undefined;
  self.defend_entrance_index = undefined;
  self.defense_override_watch_nodes = undefined;
  self botclearscriptgoal();
  self botsetstance("none");
}

function defend_get_ally_bots_at_zone_for_stance(stance) {
  var_a59d5599d9e0ee09 = [];

  foreach(other_player in level.participants) {
    if(!isDefined(other_player.team)) {
      continue;
    }

    if(other_player.team == self.team && other_player != self && isai(other_player) && other_player bot_is_defending() && isDefined(other_player.cur_defend_stance) && other_player.cur_defend_stance == stance) {
      if(other_player.bot_defending_type == self.bot_defending_type && bot_is_defending_point(other_player.bot_defending_center)) {
        var_a59d5599d9e0ee09 = array_add(var_a59d5599d9e0ee09, other_player);
      }
    }
  }

  return var_a59d5599d9e0ee09;
}

function monitor_defend_player() {
  var_508cb9269d009e4f = 0;
  var_578d6afd11258520 = 175;
  var_8fcb33318bc2a8b2 = self.bot_defend_player_guarding.origin;
  var_54f4232ff5f8f4b6 = 0;
  var_77cc5c586fa6a28d = 0;

  while(true) {
    if(!isDefined(self.bot_defend_player_guarding)) {
      thread bot_defend_stop();
    }

    self.bot_defending_center = self.bot_defend_player_guarding.origin;
    self.node_closest_to_defend_center = self.bot_defend_player_guarding getnearestnode();

    if(!isDefined(self.node_closest_to_defend_center)) {
      self.node_closest_to_defend_center = self getnearestnode();
    }

    assert(isDefined(self.node_closest_to_defend_center));

    if(self botgetscriptgoaltype() != "none") {
      script_goal = self botgetscriptgoal();
      var_20d851954eae02c4 = self.bot_defend_player_guarding getvelocity();
      var_3519b2425797c239 = lengthsquared(var_20d851954eae02c4);

      if(var_3519b2425797c239 > 100) {
        var_508cb9269d009e4f = 0;

        if(distancesquared(var_8fcb33318bc2a8b2, self.bot_defend_player_guarding.origin) > var_578d6afd11258520 * var_578d6afd11258520) {
          var_8fcb33318bc2a8b2 = self.bot_defend_player_guarding.origin;
          var_77cc5c586fa6a28d = 1;
          var_3b619b88092c2ac0 = vectorNormalize(script_goal - self.bot_defend_player_guarding.origin);
          normalized_velocity = vectorNormalize(var_20d851954eae02c4);

          if(vectordot(var_3b619b88092c2ac0, normalized_velocity) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      } else {
        var_508cb9269d009e4f += 0.05;

        if(var_54f4232ff5f8f4b6 > 100 && var_77cc5c586fa6a28d) {
          var_8fcb33318bc2a8b2 = self.bot_defend_player_guarding.origin;
          var_77cc5c586fa6a28d = 0;
        }

        if(var_508cb9269d009e4f > 0.5) {
          distsq = distancesquared(script_goal, self.bot_defending_center);

          if(distsq > self.bot_defending_radius * self.bot_defending_radius) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      }

      var_54f4232ff5f8f4b6 = var_3519b2425797c239;

      if(abs(self.bot_defend_player_guarding.origin[2] - script_goal[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait 0.25;
      }
    }

    wait 0.05;
  }
}

function find_defend_node_capture() {
  entrance_point = bot_defend_get_random_entrance_point_for_current_area();
  node = bot_find_node_to_capture_point(defend_valid_center(), self.bot_defending_radius, entrance_point);

  if(isDefined(node)) {
    if(isDefined(entrance_point)) {
      var_d70b2c2c937442f6 = vectorNormalize(entrance_point - node.origin);
      self.cur_defend_angle_override = vectortoangles(var_d70b2c2c937442f6);
    } else {
      var_594f44744fb80561 = vectorNormalize(node.origin - defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_594f44744fb80561);
    }

    self.cur_defend_node = node;
    return;
  }

  if(isDefined(entrance_point)) {
    bot_handle_no_valid_defense_node(entrance_point, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, defend_valid_center());
}

function find_defend_node_capture_zone() {
  entrance_point = bot_defend_get_random_entrance_point_for_current_area();
  node = bot_find_node_to_capture_zone(self.bot_defending_nodes, entrance_point);

  if(isDefined(node)) {
    if(isDefined(entrance_point)) {
      var_d70b2c2c937442f6 = vectorNormalize(entrance_point - node.origin);
      self.cur_defend_angle_override = vectortoangles(var_d70b2c2c937442f6);
    } else {
      var_594f44744fb80561 = vectorNormalize(node.origin - defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_594f44744fb80561);
    }

    self.cur_defend_node = node;
    return;
  }

  if(isDefined(entrance_point)) {
    bot_handle_no_valid_defense_node(entrance_point, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, defend_valid_center());
}

function find_defend_node_protect() {
  node = bot_find_node_that_protects_point(defend_valid_center(), self.bot_defending_radius);

  if(isDefined(node)) {
    node_to_center = vectorNormalize(defend_valid_center() - node.origin);
    self.cur_defend_angle_override = vectortoangles(node_to_center);
    self.cur_defend_node = node;
    return;
  }

  bot_handle_no_valid_defense_node(defend_valid_center(), undefined);
}

function find_defend_node_protect_zone() {
  node = bot_find_node_to_protect_zone(self.bot_defending_nodes, defend_valid_center());

  if(isDefined(node)) {
    self.cur_defend_node = node;
    return;
  }

  bot_handle_no_valid_defense_node(defend_valid_center(), undefined);
}

function find_defend_node_bodyguard() {
  node = bot_find_node_to_guard_player(defend_valid_center(), self.bot_defending_radius);

  if(isDefined(node)) {
    self.cur_defend_node = node;
    return;
  }

  var_b6f1deb8e946e67c = self getnearestnode();

  if(isDefined(var_b6f1deb8e946e67c)) {
    self.cur_defend_node = var_b6f1deb8e946e67c;
    return;
  }

  self.cur_defend_point_override = self.origin;
}

function find_defend_node_patrol() {
  node = undefined;
  nodes = getnodesinradius(defend_valid_center(), self.bot_defending_radius, 0);

  if(isDefined(nodes) && nodes.size > 0) {
    node = self botnodepick(nodes, 1 + nodes.size * 0.5, "node_exposed");
  }

  if(isDefined(node)) {
    self.cur_defend_node = node;
    return;
  }

  bot_handle_no_valid_defense_node(undefined, defend_valid_center());
}

function bot_handle_no_valid_defense_node(var_b76b361d985e9efe, var_1dc58f0a2b0494cd) {
  if(self.bot_defending_type == "protect_zone") {
    self.cur_defend_point_override = random(self.bot_defending_nodes).origin;
    return;
  }

  assert(!isDefined(var_b76b361d985e9efe) && isDefined(var_1dc58f0a2b0494cd) || isDefined(var_b76b361d985e9efe) && !isDefined(var_1dc58f0a2b0494cd));

  if(self.bot_defending_type == "capture_zone") {
    self.cur_defend_point_override = bot_pick_random_point_from_set(defend_valid_center(), self.bot_defending_nodes, &bot_can_use_point_in_defend);
  } else {
    self.cur_defend_point_override = bot_pick_random_point_in_radius(defend_valid_center(), self.bot_defending_radius, &bot_can_use_point_in_defend, 0.15, 0.9);
  }

  if(isDefined(var_b76b361d985e9efe)) {
    angle_dir = vectorNormalize(var_b76b361d985e9efe - self.cur_defend_point_override);
    self.cur_defend_angle_override = vectortoangles(angle_dir);
    return;
  }

  if(isDefined(var_1dc58f0a2b0494cd)) {
    angle_dir = vectorNormalize(self.cur_defend_point_override - var_1dc58f0a2b0494cd);
    self.cur_defend_angle_override = vectortoangles(angle_dir);
  }
}

function bot_can_use_point_in_defend(point) {
  if(bot_check_team_is_using_position(point, 1, 1, 1)) {
    return false;
  }

  return true;
}

function bot_check_team_is_using_position(position, var_a7581d21ffa324d2, var_393caa83813956ee, var_2ad2d07831a9acd) {
  for(i = 0; i < level.participants.size; i++) {
    other_player = level.participants[i];

    if(isDefined(other_player.team) && other_player.team == self.team && other_player != self) {
      if(isai(other_player)) {
        if(var_393caa83813956ee) {
          if(distancesquared(position, other_player.origin) < 441) {
            return true;
          }
        }

        if(var_2ad2d07831a9acd && other_player bothasscriptgoal()) {
          bot_goal = other_player botgetscriptgoal();

          if(distancesquared(position, bot_goal) < 441) {
            return true;
          }
        }

        continue;
      }

      if(var_a7581d21ffa324d2) {
        if(distancesquared(position, other_player.origin) < 441) {
          return true;
        }
      }
    }
  }

  return false;
}

function bot_capture_zone_get_furthest_distance() {
  furthest_dist = 0;

  if(isDefined(self.bot_defending_nodes)) {
    foreach(node in self.bot_defending_nodes) {
      dist_to_node = distance(self.bot_defending_center, node.origin);
      furthest_dist = max(dist_to_node, furthest_dist);
    }
  }

  return furthest_dist;
}

function bot_think_tactical_goals() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.tactical_goals = [];
  self.tactical_goal_in_action_thread = 0;

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    if(self.tactical_goals.size > 0 && !bot_is_remote_or_linked()) {
      new_goal = self.tactical_goals[0];

      if(!isDefined(new_goal.abort)) {
        self notify("start_tactical_goal");

        if(isDefined(new_goal.start_thread)) {
          self[[new_goal.start_thread]](new_goal);
        }

        childthread watch_goal_aborted(new_goal);
        goal_type = "tactical";

        if(isDefined(new_goal.goal_type)) {
          goal_type = new_goal.goal_type;
        }

        if(istrue(new_goal.clear_prev_goal)) {
          self botclearscriptgoal();
        }

        self botsetscriptgoal(new_goal.goal_position, new_goal.goal_radius, goal_type, new_goal.goal_yaw, new_goal.objective_radius, new_goal.short_term_goal);
        result = bot_waittill_goal_or_fail(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");

        if(result == "goal") {
          if(isDefined(new_goal.action_thread)) {
            self.tactical_goal_in_action_thread = 1;
            self[[new_goal.action_thread]](new_goal);
            self.tactical_goal_in_action_thread = 0;
          }
        }

        if(result != "script_goal_changed") {
          self botclearscriptgoal();
        }

        if(isDefined(new_goal.end_thread)) {
          self[[new_goal.end_thread]](new_goal);
        }
      }

      self.tactical_goals = array_remove(self.tactical_goals, new_goal);
    }

    wait 0.05;
  }
}

function watch_goal_aborted(goal) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;

  while(true) {
    if(isDefined(goal.abort) || isDefined(goal.should_abort) && self[[goal.should_abort]](goal)) {
      self notify("stop_tactical_goal");
    }

    wait 0.05;
  }
}

function bot_new_tactical_goal(type, goal_position, priority, extra_params) {
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
  new_goal.short_term_goal = extra_params.short_term_goal;
  new_goal.optional_params = extra_params.optional_params;
  new_goal.clear_prev_goal = extra_params.clear_prev_goal;

  for(var_b5f8bf1c8eb1626e = 0; var_b5f8bf1c8eb1626e < self.tactical_goals.size; var_b5f8bf1c8eb1626e++) {
    if(new_goal.priority > self.tactical_goals[var_b5f8bf1c8eb1626e].priority) {
      break;
    }
  }

  for(i = self.tactical_goals.size - 1; i >= var_b5f8bf1c8eb1626e; i--) {
    self.tactical_goals[i + 1] = self.tactical_goals[i];
  }

  self.tactical_goals[var_b5f8bf1c8eb1626e] = new_goal;
}

function bot_has_tactical_goal(goal_type, object) {
  if(!isDefined(self.tactical_goals)) {
    return 0;
  }

  if(isDefined(goal_type)) {
    foreach(goal in self.tactical_goals) {
      if(goal.type == goal_type) {
        if(isDefined(object) && isDefined(goal.object)) {
          return (goal.object == object);
        }

        return 1;
      }
    }

    return 0;
  }

  return self.tactical_goals.size > 0;
}

function bot_get_active_tactical_goals_of_type(goal_type) {
  goals = [];

  if(isDefined(self.tactical_goals)) {
    foreach(goal in self.tactical_goals) {
      if(!istrue(goal.abort) && goal.type == goal_type) {
        goals[goals.size] = goal;
      }
    }
  }

  return goals;
}

function bot_abort_tactical_goal(goal_type, object) {
  assert(isDefined(goal_type));

  if(!isDefined(self.tactical_goals)) {
    return;
  }

  foreach(goal in self.tactical_goals) {
    if(goal.type == goal_type) {
      if(isDefined(object)) {
        if(isDefined(goal.object) && goal.object == object) {
          goal.abort = 1;
        }

        continue;
      }

      goal.abort = 1;
    }
  }
}

function bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "map_interactive_object";

  foreach(goal in self.tactical_goals) {
    if(goal.type != "map_interactive_object") {
      goal.abort = 1;
    }
  }
}

function bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

function bot_melee_tactical_insertion_check() {
  now = gettime();

  if(!isDefined(self.last_melee_ti_check) || now - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = now;
    trap_item = bot_get_ambush_trap_item("tacticalinsertion");

    if(!isDefined(trap_item)) {
      return false;
    }

    if(isDefined(self.enemy) && self botcanseeentity(self.enemy)) {
      return false;
    }

    myzone = getzonenearest(self.origin);

    if(!isDefined(myzone)) {
      return false;
    }

    var_c00c20554cb14554 = botzonenearestcount(myzone, self.team, 1, "enemy_predict", ">", 0);

    if(!isDefined(var_c00c20554cb14554)) {
      return false;
    }

    var_c49a42fa6b3f0e0d = getnodesinradius(self.origin, 500, 0);

    if(var_c49a42fa6b3f0e0d.size <= 0) {
      return false;
    }

    place_node = self botnodepick(var_c49a42fa6b3f0e0d, var_c49a42fa6b3f0e0d.size * 0.15, "node_hide");

    if(!isDefined(place_node)) {
      return false;
    }

    return bot_set_ambush_trap(trap_item, undefined, undefined, undefined, place_node);
  }

  return false;
}