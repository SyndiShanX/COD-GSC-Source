/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_strategy.gsc
*********************************************/

bot_defend_get_random_entrance_point_for_current_area() {
  var_0 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);
  if(isDefined(var_0) && var_0.size > 0) {
    return scripts\engine\utility::random(var_0).origin;
  }

  return undefined;
}

bot_defend_get_precalc_entrances_for_current_area(var_0) {
  if(isDefined(self.defend_entrance_index)) {
    return scripts\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index(var_0, self.defend_entrance_index);
  }

  return [];
}

bot_setup_bombzone_bottargets() {
  wait(1);
  bot_setup_bot_targets(level.bombzones);
  level.bot_set_bombzone_bottargets = 1;
}

bot_setup_objective_bottargets() {
  bot_setup_bot_targets(level.radios);
}

bot_setup_bot_targets(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.bottargets)) {
      var_2.bottargets = [];
      var_3 = getnodesintrigger(var_2.trigger);
      foreach(var_5 in var_3) {
        if(!var_5 getweaponbarsize()) {
          var_2.bottargets = scripts\engine\utility::array_add(var_2.bottargets, var_5);
        }
      }
    }
  }
}

bot_get_ambush_trap_item(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_4[var_4.size] = var_0;
  if(isDefined(var_1)) {
    var_4[var_4.size] = var_1;
  }

  if(isDefined(var_1)) {
    var_4[var_4.size] = var_2;
  }

  foreach(var_6 in var_4) {
    var_3["purpose"] = var_6;
    var_3["item_action"] = ::scripts\mp\bots\_bots_util::bot_get_grenade_for_purpose(var_6);
    if(isDefined(var_3["item_action"])) {
      return var_3;
    }
  }
}

bot_set_ambush_trap(var_0, var_1, var_2, var_3, var_4) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");
  if(!isDefined(var_0)) {
    return 0;
  }

  var_5 = undefined;
  if(!isDefined(var_4) && isDefined(var_1) && var_1.size > 0) {
    if(!isDefined(var_2)) {
      return 0;
    }

    var_6 = [];
    var_7 = undefined;
    if(isDefined(var_3)) {
      var_7 = anglesToForward((0, var_3, 0));
    }

    foreach(var_9 in var_1) {
      if(!isDefined(var_7)) {
        var_6[var_6.size] = var_9;
        continue;
      }

      if(distancesquared(var_9.origin, var_2.origin) > 90000) {
        if(vectordot(var_7, vectornormalize(var_9.origin - var_2.origin)) < 0.4) {
          var_6[var_6.size] = var_9;
        }
      }
    }

    if(var_6.size > 0) {
      var_5 = scripts\engine\utility::random(var_6);
      var_0B = getnodesinradius(var_5.origin, 300, 50);
      var_0C = [];
      foreach(var_0E in var_0B) {
        if(!isDefined(var_0E.bot_ambush_end)) {
          var_0C[var_0C.size] = var_0E;
        }
      }

      var_0B = var_0C;
      var_4 = self botnodepick(var_0B, min(var_0B.size, 3), "node_trap", var_2, var_5);
    }
  }

  if(isDefined(var_4)) {
    var_10 = undefined;
    if(var_0["purpose"] == "trap_directional" && isDefined(var_5)) {
      var_11 = vectortoangles(var_5.origin - var_4.origin);
      var_10 = var_11[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical") {
      self botclearscriptgoal();
    }

    var_12 = self botsetscriptgoalnode(var_4, "guard", var_10);
    if(var_12) {
      var_13 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
      if(var_13 == "goal") {
        thread scripts\mp\bots\_bots_util::bot_force_stance_for_time("stand", 5);
        if(!isDefined(self.isnodeoccupied) || 0 == self botcanseeentity(self.isnodeoccupied)) {
          if(isDefined(var_10)) {
            self getpreferreddompoints(var_5.origin, var_0["item_action"]);
          } else {
            self getpreferreddompoints(self.origin + anglesToForward(self.angles) * 50, var_0["item_action"]);
          }

          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("grenade_fire");
          thread bot_set_ambush_trap_wait_fire("missile_fire");
          var_14 = 3;
          if(var_0["purpose"] == "tacticalinsertion") {
            var_14 = 6;
          }

          scripts\engine\utility::waittill_any_timeout_1(var_14, "missile_fire", "grenade_fire");
          wait(0.05);
          self notify("ambush_trap_ent");
          if(isDefined(self.ambush_trap_ent) && var_0["purpose"] == "c4") {
            thread bot_watch_manual_detonate(self.ambush_trap_ent, var_0["item_action"], 300);
          }

          self.ambush_trap_ent = undefined;
          wait(randomfloat(0.25));
          self botsetstance("none");
        }
      }

      return 1;
    }
  }

  return 0;
}

bot_set_ambush_trap_wait_fire(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(var_0, var_1);
  self.ambush_trap_ent = var_1;
}

bot_watch_manual_detonate(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_3 = var_2 * var_2;
  for(;;) {
    if(distancesquared(self.origin, var_0.origin) > var_3) {
      var_4 = self getclosestenemysqdist(var_0.origin, 1);
      if(var_4 < var_3) {
        self botpressbutton(var_1);
        return;
      }
    }

    wait(randomfloatrange(0.25, 1));
  }
}

bot_capture_point(var_0, var_1, var_2) {
  thread bot_defend_think(var_0, var_1, "capture", var_2);
}

bot_capture_zone(var_0, var_1, var_2, var_3) {
  var_3["capture_trigger"] = var_2;
  thread bot_defend_think(var_0, var_1, "capture_zone", var_3);
}

bot_protect_point(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    var_2["min_goal_time"] = 12;
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    var_2["max_goal_time"] = 18;
  }

  thread bot_defend_think(var_0, var_1, "protect", var_2);
}

bot_patrol_area(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    var_2["min_goal_time"] = 0;
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    var_2["max_goal_time"] = 0.01;
  }

  thread bot_defend_think(var_0, var_1, "patrol", var_2);
}

bot_guard_player(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    var_2["min_goal_time"] = 15;
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    var_2["max_goal_time"] = 20;
  }

  thread bot_defend_think(var_0, var_1, "bodyguard", var_2);
}

bot_defend_think(var_0, var_1, var_2, var_3) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("defend_stop");
  thread defense_death_monitor();
  if(isDefined(self.bot_defending) || self botgetscriptgoaltype() == "camp") {
    self botclearscriptgoal();
  }

  self.bot_defending = 1;
  self.bot_defending_type = var_2;
  if(var_2 == "capture_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = var_1;
    self.bot_defending_trigger = var_3["capture_trigger"];
  } else {
    self.bot_defending_radius = var_1;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(scripts\mp\utility::isgameparticipant(var_0)) {
    self.bot_defend_player_guarding = var_0;
    childthread monitor_defend_player();
  } else {
    self.bot_defend_player_guarding = undefined;
    self.bot_defending_center = var_0;
  }

  self botsetstance("none");
  var_4 = undefined;
  var_5 = 6;
  var_6 = 10;
  if(isDefined(var_3)) {
    self.defend_entrance_index = var_3["entrance_points_index"];
    self.defense_score_flags = var_3["score_flags"];
    self.bot_defending_override_origin_node = var_3["override_origin_node"];
    if(isDefined(var_3["override_goal_type"])) {
      var_4 = var_3["override_goal_type"];
    }

    if(isDefined(var_3["min_goal_time"])) {
      var_5 = var_3["min_goal_time"];
    }

    if(isDefined(var_3["max_goal_time"])) {
      var_6 = var_3["max_goal_time"];
    }

    if(isDefined(var_3["override_entrances"]) && var_3["override_entrances"].size > 0) {
      self.defense_override_watch_nodes = var_3["override_entrances"];
      self.defend_entrance_index = self.name + " " + gettime();
      foreach(var_8 in self.defense_override_watch_nodes) {
        var_8.prone_visible_from[self.defend_entrance_index] = ::scripts\mp\bots\_bots_util::entrance_visible_from(var_8.origin, scripts\mp\bots\_bots_util::defend_valid_center(), "prone");
        wait(0.05);
        var_8.crouch_visible_from[self.defend_entrance_index] = ::scripts\mp\bots\_bots_util::entrance_visible_from(var_8.origin, scripts\mp\bots\_bots_util::defend_valid_center(), "crouch");
        wait(0.05);
      }
    }
  }

  if(!isDefined(self.bot_defend_player_guarding)) {
    var_0A = undefined;
    if(isDefined(var_3) && isDefined(var_3["nearest_node_to_center"])) {
      var_0A = var_3["nearest_node_to_center"];
    }

    if(!isDefined(var_0A) && isDefined(self.bot_defending_override_origin_node)) {
      var_0A = self.bot_defending_override_origin_node;
    }

    if(!isDefined(var_0A) && isDefined(self.bot_defending_trigger) && isDefined(self.bot_defending_trigger.nearest_node)) {
      var_0A = self.bot_defending_trigger.nearest_node;
    }

    if(!isDefined(var_0A)) {
      var_0A = getclosestnodeinsight(scripts\mp\bots\_bots_util::defend_valid_center());
    }

    if(!isDefined(var_0A)) {
      var_0B = self _meth_8533();
      var_0C = scripts\mp\bots\_bots_util::defend_valid_center();
      var_0D = getnodesinradiussorted(var_0C, 256, 0, 500, "path", var_0B);
      for(var_0E = 0; var_0E < var_0D.size; var_0E++) {
        var_0F = vectornormalize(var_0D[var_0E].origin - var_0C);
        var_10 = var_0C + var_0F * 15;
        if(sighttracepassed(var_10, var_0D[var_0E].origin, 0, undefined)) {
          var_0A = var_0D[var_0E];
          break;
        }

        wait(0.05);
        if(sighttracepassed(var_10 + (0, 0, 55), var_0D[var_0E].origin + (0, 0, 55), 0, undefined)) {
          var_0A = var_0D[var_0E];
          break;
        }

        wait(0.05);
      }
    }

    self.node_closest_to_defend_center = var_0A;
  }

  var_11 = level.bot_find_defend_node_func[var_2];
  if(!isDefined(var_4)) {
    var_4 = "guard";
    if(var_2 == "capture" || var_2 == "capture_zone") {
      var_4 = "objective";
    }
  }

  var_12 = scripts\mp\bots\_bots_util::bot_is_capturing();
  if(var_2 == "protect") {
    childthread protect_watch_allies();
  }

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.cur_defend_stance = calculate_defend_stance(var_12);
    var_13 = self botgetscriptgoaltype();
    var_14 = scripts\mp\bots\_bots_util::bot_goal_can_override(var_4, var_13);
    if(!var_14) {
      wait(0.25);
      continue;
    }

    var_15 = var_5;
    var_16 = var_6;
    var_17 = 1;
    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      var_17 = 0;
      var_15 = 1;
      var_16 = 2;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      self[[var_11]]();
    }

    self botclearscriptgoal();
    var_18 = "";
    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(var_17 && scripts\mp\bots\_bots_util::bot_is_protecting() && !isplayer(var_0) && isDefined(self.defend_entrance_index)) {
        var_19 = bot_get_ambush_trap_item("trap_directional", "trap", "c4");
        if(isDefined(var_19)) {
          var_1A = scripts\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(var_19, var_1A, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        var_1B = undefined;
        if(isDefined(self.cur_defend_angle_override)) {
          var_1B = self.cur_defend_angle_override[1];
        }

        self botsetscriptgoal(self.cur_defend_point_override, 0, var_4, var_1B);
      } else if(!isDefined(self.cur_defend_angle_override)) {
        self botsetscriptgoalnode(self.cur_defend_node, var_4);
      } else {
        self botsetscriptgoalnode(self.cur_defend_node, var_4, self.cur_defend_angle_override[1]);
      }

      if(var_12) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node) {
          self botsetstance("none");
        }
      }

      var_1C = self botgetscriptgoal();
      self notify("new_defend_goal");
      scripts\mp\bots\_bots_util::watch_nodes_stop();
      if(var_4 == "objective") {
        defense_cautious_approach();
        self botgetpathdist(1);
        self botsetflag("cautious", 0);
      }

      if(self bothasscriptgoal()) {
        var_1D = self botgetscriptgoal();
        if(scripts\mp\bots\_bots_util::bot_vectors_are_equal(var_1D, var_1C)) {
          var_18 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
        }
      }

      if(var_18 == "goal") {
        if(var_12) {
          self botsetstance(self.cur_defend_stance);
        }

        childthread defense_watch_entrances_at_goal();
      }
    }

    if(var_18 != "goal") {
      wait(0.25);
      continue;
    }

    var_1E = randomfloatrange(var_15, var_16);
    var_18 = scripts\engine\utility::waittill_any_timeout_1(var_1E, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");
    if((var_18 == "node_relinquished" || var_18 == "bad_path" || var_18 == "goal_changed" || var_18 == "script_goal_changed") && self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone") {
      self botsetstance("none");
    }
  }
}

calculate_defend_stance(var_0) {
  var_1 = "stand";
  if(var_0) {
    var_2 = 100;
    var_3 = 0;
    var_4 = 0;
    var_5 = self botgetdifficultysetting("strategyLevel");
    if(var_5 == 1) {
      var_2 = 20;
      var_3 = 25;
      var_4 = 55;
    } else if(var_5 >= 2) {
      var_2 = 10;
      var_3 = 20;
      var_4 = 70;
    }

    var_6 = self.loadoutarchetype;
    if(isDefined(var_6) && var_6 == "archetype_heavy") {
      var_4 = 0;
    }

    var_7 = randomint(100);
    if(var_7 < var_3) {
      var_1 = "crouch";
    } else if(var_7 < var_3 + var_4) {
      var_1 = "prone";
    }

    if(var_1 == "prone") {
      var_8 = bot_defend_get_precalc_entrances_for_current_area("prone");
      var_9 = defend_get_ally_bots_at_zone_for_stance("prone");
      if(var_9.size >= var_8.size) {
        var_1 = "crouch";
      }
    }

    if(var_1 == "crouch") {
      var_0A = bot_defend_get_precalc_entrances_for_current_area("crouch");
      var_0B = defend_get_ally_bots_at_zone_for_stance("crouch");
      if(var_0B.size >= var_0A.size) {
        var_1 = "stand";
      }
    }
  }

  return var_1;
}

should_start_cautious_approach_default(var_0) {
  var_1 = 1250;
  var_2 = var_1 * var_1;
  if(var_0) {
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      return 0;
    }

    if(self.bot_defending_type == "capture_zone" && self istouching(self.bot_defending_trigger)) {
      return 0;
    }

    return distancesquared(self.origin, self.bot_defending_center) > var_2 * 0.75 * 0.75;
  }

  if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < var_2) {
    var_3 = self botgetpathdist();
    return 0 <= var_3 && var_3 <= var_1;
  }

  return 0;
}

setup_investigate_location(var_0, var_1) {
  var_2 = spawnStruct();
  if(isDefined(var_1)) {
    var_2.origin = var_1;
  } else {
    var_2.origin = var_0.origin;
  }

  var_2.target_getindexoftarget = var_0;
  var_2.frames_visible = 0;
  return var_2;
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
  if(![[level.bot_funcs["should_start_cautious_approach"]]](1)) {
    return;
  }

  var_0 = self botgetscriptgoal();
  var_1 = self botgetscriptgoalnode();
  var_2 = 1;
  var_3 = 0.2;
  while(var_2) {
    wait(0.25);
    if(!self bothasscriptgoal()) {
      return;
    }

    var_4 = self botgetscriptgoal();
    if(!scripts\mp\bots\_bots_util::bot_vectors_are_equal(var_0, var_4)) {
      return;
    }

    var_3 = var_3 + 0.25;
    if(var_3 >= 0.5) {
      var_3 = 0;
      if([[level.bot_funcs["should_start_cautious_approach"]]](0)) {
        var_2 = 0;
      }
    }
  }

  self botgetpathdist(1.8);
  self botsetflag("cautious", 1);
  var_5 = self botgetnodesonpath();
  if(!isDefined(var_5) || var_5.size <= 2) {
    return;
  }

  self.locations_to_investigate = [];
  var_6 = 1000;
  if(isDefined(level.protect_radius)) {
    var_6 = level.protect_radius;
  }

  var_7 = var_6 * var_6;
  var_8 = self _meth_8533();
  var_9 = getnodesinradius(self.bot_defending_center, var_6, 0, 500, "path", var_8);
  if(var_9.size <= 0) {
    return;
  }

  var_0A = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  var_0B = int(min(var_0A, var_9.size));
  var_0C = self botnodepickmultiple(var_9, 15, var_0B, "node_protect", scripts\mp\bots\_bots_util::defend_valid_center(), "ignore_occupancy");
  for(var_0D = 0; var_0D < var_0C.size; var_0D++) {
    var_0E = setup_investigate_location(var_0C[var_0D]);
    self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_0E);
  }

  var_0F = botgetmemoryevents(0, gettime() - -5536, 1, "death", 0, self);
  foreach(var_11 in var_0F) {
    if(distancesquared(var_11, self.bot_defending_center) < var_7) {
      var_12 = getclosestnodeinsight(var_11);
      if(isDefined(var_12)) {
        var_0E = setup_investigate_location(var_12, var_11);
        self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_0E);
      }
    }
  }

  if(isDefined(self.defend_entrance_index)) {
    var_14 = scripts\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index("stand", self.defend_entrance_index);
    for(var_0D = 0; var_0D < var_14.size; var_0D++) {
      var_0E = setup_investigate_location(var_14[var_0D]);
      self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_0E);
    }
  }

  if(self.locations_to_investigate.size == 0) {
    return;
  }

  childthread monitor_cautious_approach_dangerous_locations();
  var_15 = self botgetscriptgoaltype();
  var_16 = self botgetscriptgoalradius();
  var_17 = self botgetscriptgoalyaw();
  wait(0.05);
  for(var_18 = 1; var_18 < var_5.size - 2; var_18++) {
    scripts\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time();
    var_19 = getlinkednodes(var_5[var_18]);
    if(var_19.size == 0) {
      continue;
    }

    var_1A = [];
    for(var_0D = 0; var_0D < var_19.size; var_0D++) {
      if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_19[var_0D].origin, 0)) {
        continue;
      }

      for(var_1B = 0; var_1B < self.locations_to_investigate.size; var_1B++) {
        var_11 = self.locations_to_investigate[var_1B];
        if(nodesvisible(var_11.target_getindexoftarget, var_19[var_0D], 1)) {
          var_1A = scripts\engine\utility::array_add(var_1A, var_19[var_0D]);
          var_1B = self.locations_to_investigate.size;
        }
      }
    }

    if(var_1A.size == 0) {
      continue;
    }

    var_1C = self botnodepick(var_1A, 1 + var_1A.size * 0.15, "node_hide");
    if(isDefined(var_1C)) {
      var_1D = [];
      for(var_0D = 0; var_0D < self.locations_to_investigate.size; var_0D++) {
        if(nodesvisible(self.locations_to_investigate[var_0D].target_getindexoftarget, var_1C, 1)) {
          var_1D = scripts\engine\utility::array_add(var_1D, self.locations_to_investigate[var_0D]);
        }
      }

      self botclearscriptgoal();
      self botsetscriptgoalnode(var_1C, "critical");
      childthread monitor_cautious_approach_early_out();
      var_1E = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");
      if(var_1E == "cautious_approach_early_out") {
        break;
      }

      if(var_1E == "goal") {
        for(var_0D = 0; var_0D < var_1D.size; var_0D++) {
          var_1F = 0;
          while(var_1D[var_0D].frames_visible < 18 && var_1F < 3.6) {
            self botlookatpoint(var_1D[var_0D].origin + (0, 0, self getplayerviewheight()), 0.25, "script_search");
            wait(0.25);
            var_1F = var_1F + 0.25;
          }
        }
      }
    }

    wait(0.05);
  }

  self notify("stop_location_monitoring");
  self botclearscriptgoal();
  if(isDefined(var_1)) {
    self botsetscriptgoalnode(var_1, var_15, var_17);
    return;
  }

  self botsetscriptgoal(self.cur_defend_point_override, var_16, var_15, var_17);
}

monitor_cautious_approach_early_out() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_0 = undefined;
  if(isDefined(self.bot_defending_radius)) {
    var_0 = self.bot_defending_radius * self.bot_defending_radius;
  } else if(isDefined(self.bot_defending_nodes)) {
    var_1 = func_2D2D();
    var_0 = var_1 * var_1;
  }

  wait(0.05);
  for(;;) {
    if(distancesquared(self.origin, self.bot_defending_center) < var_0) {
      self notify("cautious_approach_early_out");
    }

    wait(0.05);
  }
}

monitor_cautious_approach_dangerous_locations() {
  self endon("stop_location_monitoring");
  var_0 = 10000;
  for(;;) {
    var_1 = self getnearestnode();
    if(isDefined(var_1)) {
      var_2 = self botgetfovdot();
      for(var_3 = 0; var_3 < self.locations_to_investigate.size; var_3++) {
        if(nodesvisible(var_1, self.locations_to_investigate[var_3].target_getindexoftarget, 1)) {
          var_4 = scripts\engine\utility::within_fov(self.origin, self.angles, self.locations_to_investigate[var_3].origin, var_2);
          var_5 = !var_4 || self.locations_to_investigate[var_3].frames_visible < 17;
          if(var_5 && distancesquared(self.origin, self.locations_to_investigate[var_3].origin) < var_0) {
            var_4 = 1;
            self.locations_to_investigate[var_3].frames_visible = 18;
          }

          if(var_4) {
            self.locations_to_investigate[var_3].frames_visible++;
            if(self.locations_to_investigate[var_3].frames_visible >= 18) {
              self.locations_to_investigate[var_3] = self.locations_to_investigate[self.locations_to_investigate.size - 1];
              self.locations_to_investigate[self.locations_to_investigate.size - 1] = undefined;
              var_3--;
            }
          }
        }
      }
    }

    wait(0.05);
  }
}

protect_watch_allies() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_0 = [];
  var_1 = 1050;
  var_2 = var_1 * var_1;
  var_3 = 900;
  if(isDefined(level.protect_radius)) {
    var_3 = level.protect_radius;
  }

  for(;;) {
    var_4 = gettime();
    var_5 = bot_get_teammates_in_radius(self.bot_defending_center, var_3);
    foreach(var_7 in var_5) {
      var_8 = var_7.entity_number;
      if(!isDefined(var_8)) {
        var_8 = var_7 getentitynumber();
      }

      if(!isDefined(var_0[var_8])) {
        var_0[var_8] = var_4 - 1;
      }

      if(!isDefined(var_7.last_investigation_time)) {
        var_7.last_investigation_time = var_4 - 10001;
      }

      if(var_7.health == 0 && isDefined(var_7.deathtime) && var_4 - var_7.deathtime < 5000) {
        if(var_4 - var_7.last_investigation_time > 10000 && var_4 > var_0[var_8]) {
          if(isDefined(var_7.sethalfresparticles) && isDefined(var_7.sethalfresparticles.team) && var_7.sethalfresparticles.team == scripts\engine\utility::get_enemy_team(self.team)) {
            if(distancesquared(var_7.origin, self.origin) < var_2) {
              self botgetimperfectenemyinfo(var_7.sethalfresparticles, var_7.origin);
              var_9 = getclosestnodeinsight(var_7.origin);
              if(isDefined(var_9)) {
                self.defense_investigate_specific_point = var_9.origin;
                self notify("defend_force_node_recalculation");
              }

              var_7.last_investigation_time = var_4;
            }

            var_0[var_8] = var_4 + 10000;
          }
        }
      }
    }

    wait(randomint(5) + 1 * 0.05);
  }
}

defense_get_initial_entrances() {
  if(isDefined(self.defense_override_watch_nodes)) {
    return self.defense_override_watch_nodes;
  }

  if(scripts\mp\bots\_bots_util::bot_is_capturing()) {
    var_0 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);
    if(var_0.size == 0 && !isDefined(self.defend_entrance_index)) {
      var_0 = findentrances(self.origin);
    }

    return var_0;
  }

  if(scripts\mp\bots\_bots_util::bot_is_protecting() || scripts\mp\bots\_bots_util::bot_is_bodyguarding()) {
    var_0 = findentrances(self.origin);
    return var_0;
  }
}

defense_watch_entrances_at_goal() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var_0 = self getnearestnode();
  var_1 = undefined;
  if(scripts\mp\bots\_bots_util::bot_is_capturing()) {
    var_2 = defense_get_initial_entrances();
    var_1 = [];
    if(isDefined(var_0)) {
      foreach(var_4 in var_2) {
        if(nodesvisible(var_0, var_4, 1)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_4);
        }
      }
    }
  } else if(scripts\mp\bots\_bots_util::bot_is_protecting() || scripts\mp\bots\_bots_util::bot_is_bodyguarding()) {
    var_1 = defense_get_initial_entrances();
    if(isDefined(var_0) && !issubstr(self getcurrentweapon(), "riotshield")) {
      if(!scripts\mp\utility::istrue(var_0.ishacknode) && !scripts\mp\utility::istrue(self.node_closest_to_defend_center.ishacknode)) {
        if(nodesvisible(var_0, self.node_closest_to_defend_center, 1)) {
          var_1 = scripts\engine\utility::array_add(var_1, self.node_closest_to_defend_center);
        }
      }
    }
  }

  if(isDefined(var_1)) {
    childthread scripts\mp\bots\_bots_util::bot_watch_nodes(var_1);
    if(scripts\mp\bots\_bots_util::bot_is_bodyguarding()) {
      childthread bot_monitor_watch_entrances_bodyguard();
      return;
    }

    childthread bot_monitor_watch_entrances_at_goal();
  }
}

bot_monitor_watch_entrances_at_goal() {
  self notify("bot_monitor_watch_entrances_at_goal");
  self endon("bot_monitor_watch_entrances_at_goal");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  while(!isDefined(self.watch_nodes)) {
    wait(0.05);
  }

  var_0 = level.bot_funcs["get_watch_node_chance"];
  for(;;) {
    foreach(var_2 in self.watch_nodes) {
      if(var_2 == self.node_closest_to_defend_center) {
        var_2.watch_node_chance[self.entity_number] = 0.8;
        continue;
      }

      var_2.watch_node_chance[self.entity_number] = 1;
    }

    var_4 = isDefined(var_0);
    if(!var_4) {
      prioritize_watch_nodes_toward_enemies(0.5);
    }

    foreach(var_2 in self.watch_nodes) {
      if(var_4) {
        var_6 = self[[var_0]](var_2);
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * var_6;
      }

      if(entrance_watched_by_ally(var_2)) {
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.5;
      }
    }

    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_monitor_watch_entrances_bodyguard() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  while(!isDefined(self.watch_nodes)) {
    wait(0.05);
  }

  for(;;) {
    var_0 = anglesToForward(self.bot_defend_player_guarding.angles) * (1, 1, 0);
    var_0 = vectornormalize(var_0);
    foreach(var_2 in self.watch_nodes) {
      var_2.watch_node_chance[self.entity_number] = 1;
      var_3 = var_2.origin - self.bot_defend_player_guarding.origin;
      var_3 = vectornormalize(var_3);
      var_4 = vectordot(var_0, var_3);
      if(var_4 > 0.6) {
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.33;
      } else if(var_4 > 0) {
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.66;
      }

      if(!entrance_to_enemy_zone(var_2)) {
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.5;
      }
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

entrance_to_enemy_zone(var_0) {
  var_1 = getnodezone(var_0);
  var_2 = vectornormalize(var_0.origin - self.origin);
  for(var_3 = 0; var_3 < level.zonecount; var_3++) {
    if(botzonegetcount(var_3, self.team, "enemy_predict") > 0) {
      if(isDefined(var_1) && var_3 == var_1) {
        return 1;
      } else {
        var_4 = vectornormalize(getzoneorigin(var_3) - self.origin);
        var_5 = vectordot(var_2, var_4);
        if(var_5 > 0.2) {
          return 1;
        }
      }
    }
  }

  return 0;
}

prioritize_watch_nodes_toward_enemies(var_0) {
  if(self.watch_nodes.size <= 0) {
    return;
  }

  var_1 = self.watch_nodes;
  for(var_2 = 0; var_2 < level.zonecount; var_2++) {
    if(botzonegetcount(var_2, self.team, "enemy_predict") <= 0) {
      continue;
    }

    if(var_1.size == 0) {
      break;
    }

    var_3 = vectornormalize(getzoneorigin(var_2) - self.origin);
    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_5 = getnodezone(var_1[var_4]);
      var_6 = 0;
      if(isDefined(var_5) && var_2 == var_5) {
        var_6 = 1;
      } else {
        var_7 = vectornormalize(var_1[var_4].origin - self.origin);
        var_8 = vectordot(var_7, var_3);
        if(var_8 > 0.2) {
          var_6 = 1;
        }
      }

      if(var_6) {
        var_1[var_4].watch_node_chance[self.entity_number] = var_1[var_4].watch_node_chance[self.entity_number] * var_0;
        var_1[var_4] = var_1[var_1.size - 1];
        var_1[var_1.size - 1] = undefined;
        var_4--;
      }
    }
  }
}

entrance_watched_by_ally(var_0) {
  var_1 = bot_get_teammates_currently_defending_point(self.bot_defending_center);
  foreach(var_3 in var_1) {
    if(entrance_watched_by_player(var_3, var_0)) {
      return 1;
    }
  }

  return 0;
}

entrance_watched_by_player(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = vectornormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);
  if(var_4 > 0.6) {
    return 1;
  }

  return 0;
}

bot_get_teammates_currently_defending_point(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(isDefined(level.protect_radius)) {
      var_1 = level.protect_radius;
    } else {
      var_1 = 900;
    }
  }

  var_2 = [];
  var_3 = bot_get_teammates_in_radius(var_0, var_1);
  foreach(var_5 in var_3) {
    if(!isai(var_5) || var_5 scripts\mp\bots\_bots_util::bot_is_defending_point(var_0)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  return var_2;
}

bot_get_teammates_in_radius(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = [];
  for(var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];
    if(var_5 != self && isDefined(var_5.team) && var_5.team == self.team && scripts\mp\utility::isteamparticipant(var_5)) {
      if(distancesquared(var_0, var_5.origin) < var_2) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  return var_3;
}

defense_death_monitor() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");
  if(isDefined(self)) {
    thread bot_defend_stop();
  }
}

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
  self.defense_override_watch_nodes = undefined;
  self botclearscriptgoal();
  self botsetstance("none");
}

defend_get_ally_bots_at_zone_for_stance(var_0) {
  var_1 = [];
  foreach(var_3 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }

    if(var_3.team == self.team && var_3 != self && isai(var_3) && var_3 scripts\mp\bots\_bots_util::bot_is_defending() && var_3.cur_defend_stance == var_0) {
      if(var_3.bot_defending_type == self.bot_defending_type && scripts\mp\bots\_bots_util::bot_is_defending_point(var_3.bot_defending_center)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

monitor_defend_player() {
  var_0 = 0;
  var_1 = 175;
  var_2 = self.bot_defend_player_guarding.origin;
  var_3 = 0;
  var_4 = 0;
  for(;;) {
    if(!isDefined(self.bot_defend_player_guarding)) {
      thread bot_defend_stop();
    }

    self.bot_defending_center = self.bot_defend_player_guarding.origin;
    self.node_closest_to_defend_center = self.bot_defend_player_guarding getnearestnode();
    if(!isDefined(self.node_closest_to_defend_center)) {
      self.node_closest_to_defend_center = self getnearestnode();
    }

    if(self botgetscriptgoaltype() != "none") {
      var_5 = self botgetscriptgoal();
      var_6 = self.bot_defend_player_guarding getvelocity();
      var_7 = lengthsquared(var_6);
      if(var_7 > 100) {
        var_0 = 0;
        if(distancesquared(var_2, self.bot_defend_player_guarding.origin) > var_1 * var_1) {
          var_2 = self.bot_defend_player_guarding.origin;
          var_4 = 1;
          var_8 = vectornormalize(var_5 - self.bot_defend_player_guarding.origin);
          var_9 = vectornormalize(var_6);
          if(vectordot(var_8, var_9) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait(0.25);
          }
        }
      } else {
        var_0 = var_0 + 0.05;
        if(var_3 > 100 && var_4) {
          var_2 = self.bot_defend_player_guarding.origin;
          var_4 = 0;
        }

        if(var_0 > 0.5) {
          var_0A = distancesquared(var_5, self.bot_defending_center);
          if(var_0A > self.bot_defending_radius * self.bot_defending_radius) {
            self notify("defend_force_node_recalculation");
            wait(0.25);
          }
        }
      }

      var_3 = var_7;
      if(abs(self.bot_defend_player_guarding.origin[2] - var_5[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait(0.25);
      }
    }

    wait(0.05);
  }
}

find_defend_node_capture() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = scripts\mp\bots\_bots_util::bot_find_node_to_capture_point(scripts\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, var_0);
  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectornormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectornormalize(var_1.origin - scripts\mp\bots\_bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
    return;
  }

  if(isDefined(var_0)) {
    bot_handle_no_valid_defense_node(var_0, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\_bots_util::defend_valid_center());
}

find_defend_node_capture_zone() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = scripts\mp\bots\_bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes, var_0);
  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectornormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectornormalize(var_1.origin - scripts\mp\bots\_bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
    return;
  }

  if(isDefined(var_0)) {
    bot_handle_no_valid_defense_node(var_0, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\_bots_util::defend_valid_center());
}

find_defend_node_protect() {
  var_0 = scripts\mp\bots\_bots_util::bot_find_node_that_protects_point(scripts\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius);
  if(isDefined(var_0)) {
    var_1 = vectornormalize(scripts\mp\bots\_bots_util::defend_valid_center() - var_0.origin);
    self.cur_defend_angle_override = vectortoangles(var_1);
    self.cur_defend_node = var_0;
    return;
  }

  bot_handle_no_valid_defense_node(scripts\mp\bots\_bots_util::defend_valid_center(), undefined);
}

find_defend_node_bodyguard() {
  var_0 = scripts\mp\bots\_bots_util::bot_find_node_to_guard_player(scripts\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius);
  if(isDefined(var_0)) {
    self.cur_defend_node = var_0;
    return;
  }

  var_1 = self getnearestnode();
  if(isDefined(var_1)) {
    self.cur_defend_node = var_1;
    return;
  }

  self.cur_defend_point_override = self.origin;
}

find_defend_node_patrol() {
  var_0 = undefined;
  var_1 = self _meth_8533();
  var_2 = getnodesinradius(scripts\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, 0, 520, "path", var_1);
  if(isDefined(var_2) && var_2.size > 0) {
    var_0 = self botnodepick(var_2, 1 + var_2.size * 0.5, "node_traffic");
  }

  if(isDefined(var_0)) {
    self.cur_defend_node = var_0;
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\_bots_util::defend_valid_center());
}

bot_handle_no_valid_defense_node(var_0, var_1) {
  if(self.bot_defending_type == "capture_zone") {
    self.cur_defend_point_override = scripts\mp\bots\_bots_util::bot_pick_random_point_from_set(scripts\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_nodes, ::func_2D2A);
  } else {
    self.cur_defend_point_override = scripts\mp\bots\_bots_util::bot_pick_random_point_in_radius(scripts\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, ::func_2D2A, 0.15, 0.9);
  }

  if(isDefined(var_0)) {
    var_2 = vectornormalize(var_0 - self.cur_defend_point_override);
    self.cur_defend_angle_override = vectortoangles(var_2);
    return;
  }

  if(isDefined(var_1)) {
    var_2 = vectornormalize(self.cur_defend_point_override - var_1);
    self.cur_defend_angle_override = vectortoangles(var_2);
  }
}

func_2D2A(var_0) {
  if(func_2D2F(var_0, 1, 1, 1)) {
    return 0;
  }

  return 1;
}

func_2D2F(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];
    if(var_5.team == self.team && var_5 != self) {
      if(isai(var_5)) {
        if(var_2) {
          if(distancesquared(var_0, var_5.origin) < 441) {
            return 1;
          }
        }

        if(var_3 && var_5 bothasscriptgoal()) {
          var_6 = var_5 botgetscriptgoal();
          if(distancesquared(var_0, var_6) < 441) {
            return 1;
          }
        }

        continue;
      }

      if(var_1) {
        if(distancesquared(var_0, var_5.origin) < 441) {
          return 1;
        }
      }
    }
  }

  return 0;
}

func_2D2D() {
  var_0 = 0;
  if(isDefined(self.bot_defending_nodes)) {
    foreach(var_2 in self.bot_defending_nodes) {
      var_3 = distance(self.bot_defending_center, var_2.origin);
      var_0 = max(var_3, var_0);
    }
  }

  return var_0;
}

bot_think_tactical_goals() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.tactical_goals = [];
  for(;;) {
    if(self.tactical_goals.size > 0 && !scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      var_0 = self.tactical_goals[0];
      if(!isDefined(var_0.abort)) {
        self notify("start_tactical_goal");
        if(isDefined(var_0.start_thread)) {
          self[[var_0.start_thread]](var_0);
        }

        childthread watch_goal_aborted(var_0);
        var_1 = "tactical";
        if(isDefined(var_0.goal_type)) {
          var_1 = var_0.goal_type;
        }

        self botsetscriptgoal(var_0.goal_position, var_0.goal_radius, var_1, var_0.objective_playerenemyteam, var_0.objective_radius);
        var_2 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");
        if(var_2 == "goal") {
          if(isDefined(var_0.action_thread)) {
            self[[var_0.action_thread]](var_0);
          }
        }

        if(var_2 != "script_goal_changed") {
          self botclearscriptgoal();
        }

        if(isDefined(var_0.end_thread)) {
          self[[var_0.end_thread]](var_0);
        }
      }

      self.tactical_goals = scripts\engine\utility::array_remove(self.tactical_goals, var_0);
    }

    wait(0.05);
  }
}

watch_goal_aborted(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait(0.05);
  for(;;) {
    if(isDefined(var_0.abort) || isDefined(var_0.should_abort) && self[[var_0.should_abort]](var_0)) {
      self notify("stop_tactical_goal");
    }

    wait(0.05);
  }
}

bot_new_tactical_goal(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4.goal_position = var_1;
  if(isDefined(self.only_allowable_tactical_goals)) {
    if(!scripts\engine\utility::array_contains(self.only_allowable_tactical_goals, var_0)) {
      return;
    }
  }

  var_4.priority = var_2;
  var_4.object = var_3.object;
  var_4.goal_type = var_3.script_goal_type;
  var_4.objective_playerenemyteam = var_3.script_goal_yaw;
  var_4.goal_radius = 0;
  if(isDefined(var_3.script_goal_radius)) {
    var_4.goal_radius = var_3.script_goal_radius;
  }

  var_4.start_thread = var_3.start_thread;
  var_4.end_thread = var_3.end_thread;
  var_4.should_abort = var_3.should_abort;
  var_4.action_thread = var_3.action_thread;
  var_4.objective_radius = var_3.objective_radius;
  for(var_5 = 0; var_5 < self.tactical_goals.size; var_5++) {
    if(var_4.priority > self.tactical_goals[var_5].priority) {
      break;
    }
  }

  for(var_6 = self.tactical_goals.size - 1; var_6 >= var_5; var_6--) {
    self.tactical_goals[var_6 + 1] = self.tactical_goals[var_6];
  }

  self.tactical_goals[var_5] = var_4;
}

bot_has_tactical_goal(var_0, var_1) {
  if(!isDefined(self.tactical_goals)) {
    return 0;
  }

  if(isDefined(var_0)) {
    foreach(var_3 in self.tactical_goals) {
      if(var_3.type == var_0) {
        if(isDefined(var_1) && isDefined(var_3.object)) {
          return var_3.object == var_1;
        } else {
          return 1;
        }
      }
    }

    return 0;
  }

  return self.tactical_goals.size > 0;
}

bot_abort_tactical_goal(var_0, var_1) {
  if(!isDefined(self.tactical_goals)) {
    return;
  }

  foreach(var_3 in self.tactical_goals) {
    if(var_3.type == var_0) {
      if(isDefined(var_1)) {
        if(isDefined(var_3.object) && var_3.object == var_1) {
          var_3.abort = 1;
        }

        continue;
      }

      var_3.abort = 1;
    }
  }
}

bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "map_interactive_object";
  foreach(var_1 in self.tactical_goals) {
    if(var_1.type != "map_interactive_object") {
      var_1.abort = 1;
    }
  }
}

bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

bot_melee_tactical_insertion_check() {
  var_0 = gettime();
  if(!isDefined(self.last_melee_ti_check) || var_0 - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = var_0;
    var_1 = bot_get_ambush_trap_item("tacticalinsertion");
    if(!isDefined(var_1)) {
      return 0;
    }

    if(isDefined(self.isnodeoccupied) && self botcanseeentity(self.isnodeoccupied)) {
      return 0;
    }

    var_2 = getzonenearest(self.origin);
    if(!isDefined(var_2)) {
      return 0;
    }

    var_3 = botzonenearestcount(var_2, self.team, 1, "enemy_predict", ">", 0);
    if(!isDefined(var_3)) {
      return 0;
    }

    var_4 = self _meth_8533();
    var_5 = getnodesinradius(self.origin, 500, 0, 999, "path", var_4);
    if(var_5.size <= 0) {
      return 0;
    }

    var_6 = self botnodepick(var_5, var_5.size * 0.15, "node_hide");
    if(!isDefined(var_6)) {
      return 0;
    }

    return bot_set_ambush_trap(var_1, undefined, undefined, undefined, var_6);
  }

  return 0;
}