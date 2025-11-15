/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3451.gsc
***************************************/

bot_defend_get_random_entrance_point_for_current_area() {
  var_00 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isDefined(var_00) && var_0.size > 0)
    return scripts\engine\utility::random(var_00).origin;

  return undefined;
}

bot_defend_get_precalc_entrances_for_current_area(var_00) {
  if(isDefined(self.defend_entrance_index))
    return scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(var_00, self.defend_entrance_index);

  return [];
}

bot_setup_bombzone_bottargets() {
  wait 1.0;
  bot_setup_bot_targets(level.bombzones);
  level.bot_set_bombzone_bottargets = 1;
}

bot_setup_objective_bottargets() {
  bot_setup_bot_targets(level.radios);
}

bot_setup_bot_targets(var_00) {
  foreach(var_02 in var_00) {
    if(!isDefined(var_2.bottargets)) {
      var_2.bottargets = [];
      var_03 = getnodesintrigger(var_2.trigger);

      foreach(var_05 in var_03) {
        if(!var_05 nodeisdisconnected())
          var_2.bottargets = scripts\engine\utility::array_add(var_2.bottargets, var_05);
      }
    }
  }
}

bot_get_ambush_trap_item(var_00, var_01, var_02) {
  var_03 = [];
  var_04 = [];
  var_4[var_4.size] = var_00;

  if(isDefined(var_01))
    var_4[var_4.size] = var_01;

  if(isDefined(var_01))
    var_4[var_4.size] = var_02;

  foreach(var_06 in var_04) {
    var_3["purpose"] = var_06;
    var_3["item_action"] = scripts\mp\bots\bots_util::bot_get_grenade_for_purpose(var_06);

    if(isDefined(var_3["item_action"]))
      return var_03;
  }
}

bot_set_ambush_trap(var_00, var_01, var_02, var_03, var_04) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(var_00))
    return 0;

  var_05 = undefined;

  if(!isDefined(var_04) && isDefined(var_01) && var_1.size > 0) {
    if(!isDefined(var_02))
      return 0;

    var_06 = [];
    var_07 = undefined;

    if(isDefined(var_03))
      var_07 = anglesToForward((0, var_03, 0));

    foreach(var_09 in var_01) {
      if(!isDefined(var_07)) {
        var_6[var_6.size] = var_09;
        continue;
      }

      if(distancesquared(var_9.origin, var_2.origin) > 90000) {
        if(vectordot(var_07, vectornormalize(var_9.origin - var_2.origin)) < 0.4)
          var_6[var_6.size] = var_09;
      }
    }

    if(var_6.size > 0) {
      var_05 = scripts\engine\utility::random(var_06);
      var_11 = getnodesinradius(var_5.origin, 300, 50);
      var_12 = [];

      foreach(var_14 in var_11) {
        if(!isDefined(var_14.bot_ambush_end))
          var_12[var_12.size] = var_14;
      }

      var_11 = var_12;
      var_04 = self botnodepick(var_11, min(var_11.size, 3), "node_trap", var_02, var_05);
    }
  }

  if(isDefined(var_04)) {
    var_16 = undefined;

    if(var_0["purpose"] == "trap_directional" && isDefined(var_05)) {
      var_17 = vectortoangles(var_5.origin - var_4.origin);
      var_16 = var_17[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical")
      self botclearscriptgoal();

    var_18 = self botsetscriptgoalnode(var_04, "guard", var_16);

    if(var_18) {
      var_19 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_19 == "goal") {
        thread scripts\mp\bots\bots_util::bot_force_stance_for_time("stand", 5.0);

        if(!isDefined(self.enemy) || 0 == self botcanseeentity(self.enemy)) {
          if(isDefined(var_16))
            self botthrowgrenade(var_5.origin, var_0["item_action"]);
          else
            self botthrowgrenade(self.origin + anglesToForward(self.angles) * 50, var_0["item_action"]);

          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("grenade_fire");
          thread bot_set_ambush_trap_wait_fire("missile_fire");
          var_20 = 3.0;

          if(var_0["purpose"] == "tacticalinsertion")
            var_20 = 6.0;

          scripts\engine\utility::waittill_any_timeout(var_20, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");

          if(isDefined(self.ambush_trap_ent) && var_0["purpose"] == "c4")
            thread bot_watch_manual_detonate(self.ambush_trap_ent, var_0["item_action"], 300);

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

bot_set_ambush_trap_wait_fire(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(var_00, var_01);
  self.ambush_trap_ent = var_01;
}

bot_watch_manual_detonate(var_00, var_01, var_02) {
  self endon("death");
  self endon("disconnect");
  var_00 endon("death");
  level endon("game_ended");
  var_03 = var_02 * var_02;

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) > var_03) {
      var_04 = self getclosestenemysqdist(var_0.origin, 1.0);

      if(var_04 < var_03) {
        self botpressbutton(var_01);
        return;
      }
    }

    wait(randomfloatrange(0.25, 1.0));
  }
}

bot_capture_point(var_00, var_01, var_02) {
  thread bot_defend_think(var_00, var_01, "capture", var_02);
}

bot_capture_zone(var_00, var_01, var_02, var_03) {
  var_3["capture_trigger"] = var_02;
  thread bot_defend_think(var_00, var_01, "capture_zone", var_03);
}

bot_protect_point(var_00, var_01, var_02) {
  if(!isDefined(var_02) || !isDefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 12;

  if(!isDefined(var_02) || !isDefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 18;

  thread bot_defend_think(var_00, var_01, "protect", var_02);
}

bot_patrol_area(var_00, var_01, var_02) {
  if(!isDefined(var_02) || !isDefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 0.0;

  if(!isDefined(var_02) || !isDefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 0.01;

  thread bot_defend_think(var_00, var_01, "patrol", var_02);
}

bot_guard_player(var_00, var_01, var_02) {
  if(!isDefined(var_02) || !isDefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 15;

  if(!isDefined(var_02) || !isDefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 20;

  thread bot_defend_think(var_00, var_01, "bodyguard", var_02);
}

bot_defend_think(var_00, var_01, var_02, var_03) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("defend_stop");
  thread defense_death_monitor();

  if(isDefined(self.bot_defending) || self botgetscriptgoaltype() == "camp")
    self botclearscriptgoal();

  self.bot_defending = 1;
  self.bot_defending_type = var_02;

  if(var_02 == "capture_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = var_01;
    self.bot_defending_trigger = var_3["capture_trigger"];
  } else {
    self.bot_defending_radius = var_01;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(scripts\mp\utility\game::isgameparticipant(var_00)) {
    self.bot_defend_player_guarding = var_00;
    childthread monitor_defend_player();
  } else {
    self.bot_defend_player_guarding = undefined;
    self.bot_defending_center = var_00;
  }

  self botsetstance("none");
  var_04 = undefined;
  var_05 = 6;
  var_06 = 10;

  if(isDefined(var_03)) {
    self.defend_entrance_index = var_3["entrance_points_index"];
    self.defense_score_flags = var_3["score_flags"];
    self.bot_defending_override_origin_node = var_3["override_origin_node"];

    if(isDefined(var_3["override_goal_type"]))
      var_04 = var_3["override_goal_type"];

    if(isDefined(var_3["min_goal_time"]))
      var_05 = var_3["min_goal_time"];

    if(isDefined(var_3["max_goal_time"]))
      var_06 = var_3["max_goal_time"];

    if(isDefined(var_3["override_entrances"]) && var_3["override_entrances"].size > 0) {
      self.defense_override_watch_nodes = var_3["override_entrances"];
      self.defend_entrance_index = self.name + " " + gettime();

      foreach(var_08 in self.defense_override_watch_nodes) {
        var_8.prone_visible_from[self.defend_entrance_index] = scripts\mp\bots\bots_util::entrance_visible_from(var_8.origin, scripts\mp\bots\bots_util::defend_valid_center(), "prone");
        wait 0.05;
        var_8.crouch_visible_from[self.defend_entrance_index] = scripts\mp\bots\bots_util::entrance_visible_from(var_8.origin, scripts\mp\bots\bots_util::defend_valid_center(), "crouch");
        wait 0.05;
      }
    }
  }

  if(!isDefined(self.bot_defend_player_guarding)) {
    var_10 = undefined;

    if(isDefined(var_03) && isDefined(var_3["nearest_node_to_center"]))
      var_10 = var_3["nearest_node_to_center"];

    if(!isDefined(var_10) && isDefined(self.bot_defending_override_origin_node))
      var_10 = self.bot_defending_override_origin_node;

    if(!isDefined(var_10) && isDefined(self.bot_defending_trigger) && isDefined(self.bot_defending_trigger.nearest_node))
      var_10 = self.bot_defending_trigger.nearest_node;

    if(!isDefined(var_10))
      var_10 = getclosestnodeinsight(scripts\mp\bots\bots_util::defend_valid_center());

    if(!isDefined(var_10)) {
      var_11 = self _meth_8533();
      var_12 = scripts\mp\bots\bots_util::defend_valid_center();
      var_13 = getnodesinradiussorted(var_12, 256, 0, 500, "path", var_11);

      for(var_14 = 0; var_14 < var_13.size; var_14++) {
        var_15 = vectornormalize(var_13[var_14].origin - var_12);
        var_16 = var_12 + var_15 * 15;

        if(sighttracepassed(var_16, var_13[var_14].origin, 0, undefined)) {
          var_10 = var_13[var_14];
          break;
        }

        wait 0.05;

        if(sighttracepassed(var_16 + (0, 0, 55), var_13[var_14].origin + (0, 0, 55), 0, undefined)) {
          var_10 = var_13[var_14];
          break;
        }

        wait 0.05;
      }
    }

    self.node_closest_to_defend_center = var_10;
  }

  var_17 = level.bot_find_defend_node_func[var_02];

  if(!isDefined(var_04)) {
    var_04 = "guard";

    if(var_02 == "capture" || var_02 == "capture_zone")
      var_04 = "objective";
  }

  var_18 = scripts\mp\bots\bots_util::bot_is_capturing();

  if(var_02 == "protect")
    childthread protect_watch_allies();

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.cur_defend_stance = calculate_defend_stance(var_18);
    var_19 = self botgetscriptgoaltype();
    var_20 = scripts\mp\bots\bots_util::bot_goal_can_override(var_04, var_19);

    if(!var_20) {
      wait 0.25;
      continue;
    }

    var_21 = var_05;
    var_22 = var_06;
    var_23 = 1;

    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      var_23 = 0;
      var_21 = 1.0;
      var_22 = 2.0;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else
      self[[var_17]]();

    self botclearscriptgoal();
    var_24 = "";

    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(var_23 && scripts\mp\bots\bots_util::bot_is_protecting() && !isplayer(var_00) && isDefined(self.defend_entrance_index)) {
        var_25 = bot_get_ambush_trap_item("trap_directional", "trap", "c4");

        if(isDefined(var_25)) {
          var_26 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(var_25, var_26, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        var_27 = undefined;

        if(isDefined(self.cur_defend_angle_override))
          var_27 = self.cur_defend_angle_override[1];

        self botsetscriptgoal(self.cur_defend_point_override, 0, var_04, var_27);
      } else if(!isDefined(self.cur_defend_angle_override))
        self botsetscriptgoalnode(self.cur_defend_node, var_04);
      else
        self botsetscriptgoalnode(self.cur_defend_node, var_04, self.cur_defend_angle_override[1]);

      if(var_18) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node)
          self botsetstance("none");
      }

      var_28 = self botgetscriptgoal();
      self notify("new_defend_goal");
      scripts\mp\bots\bots_util::watch_nodes_stop();

      if(var_04 == "objective") {
        defense_cautious_approach();
        self botsetawareness(1.0);
        self botsetflag("cautious", 0);
      }

      if(self bothasscriptgoal()) {
        var_29 = self botgetscriptgoal();

        if(scripts\mp\bots\bots_util::bot_vectors_are_equal(var_29, var_28))
          var_24 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
      }

      if(var_24 == "goal") {
        if(var_18)
          self botsetstance(self.cur_defend_stance);

        childthread defense_watch_entrances_at_goal();
      }
    }

    if(var_24 != "goal") {
      wait 0.25;
      continue;
    }

    var_30 = randomfloatrange(var_21, var_22);
    var_24 = scripts\engine\utility::waittill_any_timeout(var_30, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((var_24 == "node_relinquished" || var_24 == "bad_path" || var_24 == "goal_changed" || var_24 == "script_goal_changed") && (self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone"))
      self botsetstance("none");
  }
}

calculate_defend_stance(var_00) {
  var_01 = "stand";

  if(var_00) {
    var_02 = 100;
    var_03 = 0;
    var_04 = 0;
    var_05 = self botgetdifficultysetting("strategyLevel");

    if(var_05 == 1) {
      var_02 = 20;
      var_03 = 25;
      var_04 = 55;
    } else if(var_05 >= 2) {
      var_02 = 10;
      var_03 = 20;
      var_04 = 70;
    }

    var_06 = self.loadoutarchetype;

    if(isDefined(var_06) && var_06 == "archetype_heavy")
      var_04 = 0;

    var_07 = randomint(100);

    if(var_07 < var_03)
      var_01 = "crouch";
    else if(var_07 < var_03 + var_04)
      var_01 = "prone";

    if(var_01 == "prone") {
      var_08 = bot_defend_get_precalc_entrances_for_current_area("prone");
      var_09 = defend_get_ally_bots_at_zone_for_stance("prone");

      if(var_9.size >= var_8.size)
        var_01 = "crouch";
    }

    if(var_01 == "crouch") {
      var_10 = bot_defend_get_precalc_entrances_for_current_area("crouch");
      var_11 = defend_get_ally_bots_at_zone_for_stance("crouch");

      if(var_11.size >= var_10.size)
        var_01 = "stand";
    }
  }

  return var_01;
}

should_start_cautious_approach_default(var_00) {
  var_01 = 1250;
  var_02 = var_01 * var_01;

  if(var_00) {
    if(self botgetdifficultysetting("strategyLevel") == 0)
      return 0;

    if(self.bot_defending_type == "capture_zone" && self istouching(self.bot_defending_trigger))
      return 0;

    return distancesquared(self.origin, self.bot_defending_center) > var_02 * 0.75 * 0.75;
  } else if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < var_02) {
    var_03 = self botgetpathdist();
    return 0 <= var_03 && var_03 <= var_01;
  } else
    return 0;
}

setup_investigate_location(var_00, var_01) {
  var_02 = spawnStruct();

  if(isDefined(var_01))
    var_2.origin = var_01;
  else
    var_2.origin = var_0.origin;

  var_2.node = var_00;
  var_2.frames_visible = 0;
  return var_02;
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
  var_00 = self botgetscriptgoal();
  var_01 = self botgetscriptgoalnode();
  var_02 = 1;
  var_03 = 0.2;

  while(var_02) {
    wait 0.25;

    if(!self bothasscriptgoal()) {
      return;
    }
    var_04 = self botgetscriptgoal();

    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(var_00, var_04)) {
      return;
    }
    var_03 = var_03 + 0.25;

    if(var_03 >= 0.5) {
      var_03 = 0.0;

      if([
          [level.bot_funcs["should_start_cautious_approach"]]
        ](0))
        var_02 = 0;
    }
  }

  self botsetawareness(1.8);
  self botsetflag("cautious", 1);
  var_05 = self botgetnodesonpath();

  if(!isDefined(var_05) || var_5.size <= 2) {
    return;
  }
  self.locations_to_investigate = [];
  var_06 = 1000;

  if(isDefined(level.protect_radius))
    var_06 = level.protect_radius;

  var_07 = var_06 * var_06;
  var_08 = self _meth_8533();
  var_09 = getnodesinradius(self.bot_defending_center, var_06, 0, 500, "path", var_08);

  if(var_9.size <= 0) {
    return;
  }
  var_10 = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  var_11 = int(min(var_10, var_9.size));
  var_12 = self botnodepickmultiple(var_09, 15, var_11, "node_protect", scripts\mp\bots\bots_util::defend_valid_center(), "ignore_occupancy");

  for(var_13 = 0; var_13 < var_12.size; var_13++) {
    var_14 = setup_investigate_location(var_12[var_13]);
    self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_14);
  }

  var_15 = botgetmemoryevents(0, gettime() - 60000, 1, "death", 0, self);

  foreach(var_17 in var_15) {
    if(distancesquared(var_17, self.bot_defending_center) < var_07) {
      var_18 = getclosestnodeinsight(var_17);

      if(isDefined(var_18)) {
        var_14 = setup_investigate_location(var_18, var_17);
        self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_14);
      }
    }
  }

  if(isDefined(self.defend_entrance_index)) {
    var_20 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index("stand", self.defend_entrance_index);

    for(var_13 = 0; var_13 < var_20.size; var_13++) {
      var_14 = setup_investigate_location(var_20[var_13]);
      self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_14);
    }
  }

  if(self.locations_to_investigate.size == 0) {
    return;
  }
  childthread monitor_cautious_approach_dangerous_locations();
  var_21 = self botgetscriptgoaltype();
  var_22 = self botgetscriptgoalradius();
  var_23 = self botgetscriptgoalyaw();
  wait 0.05;

  for(var_24 = 1; var_24 < var_5.size - 2; var_24++) {
    scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time();
    var_25 = getlinkednodes(var_5[var_24]);

    if(var_25.size == 0) {
      continue;
    }
    var_26 = [];

    for(var_13 = 0; var_13 < var_25.size; var_13++) {
      if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_25[var_13].origin, 0)) {
        continue;
      }
      for(var_27 = 0; var_27 < self.locations_to_investigate.size; var_27++) {
        var_17 = self.locations_to_investigate[var_27];

        if(nodesvisible(var_17.node, var_25[var_13], 1)) {
          var_26 = scripts\engine\utility::array_add(var_26, var_25[var_13]);
          var_27 = self.locations_to_investigate.size;
        }
      }
    }

    if(var_26.size == 0) {
      continue;
    }
    var_28 = self botnodepick(var_26, 1 + var_26.size * 0.15, "node_hide");

    if(isDefined(var_28)) {
      var_29 = [];

      for(var_13 = 0; var_13 < self.locations_to_investigate.size; var_13++) {
        if(nodesvisible(self.locations_to_investigate[var_13].node, var_28, 1))
          var_29 = scripts\engine\utility::array_add(var_29, self.locations_to_investigate[var_13]);
      }

      self botclearscriptgoal();
      self botsetscriptgoalnode(var_28, "critical");
      childthread monitor_cautious_approach_early_out();
      var_30 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");

      if(var_30 == "cautious_approach_early_out") {
        break;
      }
      if(var_30 == "goal") {
        for(var_13 = 0; var_13 < var_29.size; var_13++) {
          for(var_31 = 0; var_29[var_13].frames_visible < 18 && var_31 < 3.6; var_31 = var_31 + 0.25) {
            self botlookatpoint(var_29[var_13].origin + (0, 0, self _meth_8157()), 0.25, "script_search");
            wait 0.25;
          }
        }
      }
    }

    wait 0.05;
  }

  self notify("stop_location_monitoring");
  self botclearscriptgoal();

  if(isDefined(var_01))
    self botsetscriptgoalnode(var_01, var_21, var_23);
  else
    self botsetscriptgoal(self.cur_defend_point_override, var_22, var_21, var_23);
}

monitor_cautious_approach_early_out() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_00 = undefined;

  if(isDefined(self.bot_defending_radius))
    var_00 = self.bot_defending_radius * self.bot_defending_radius;
  else if(isDefined(self.bot_defending_nodes)) {
    var_01 = func_2D2D();
    var_00 = var_01 * var_01;
  }

  wait 0.05;

  for(;;) {
    if(distancesquared(self.origin, self.bot_defending_center) < var_00)
      self notify("cautious_approach_early_out");

    wait 0.05;
  }
}

monitor_cautious_approach_dangerous_locations() {
  self endon("stop_location_monitoring");
  var_00 = 10000;

  for(;;) {
    var_01 = self getnearestnode();

    if(isDefined(var_01)) {
      var_02 = self botgetfovdot();

      for(var_03 = 0; var_03 < self.locations_to_investigate.size; var_3++) {
        if(nodesvisible(var_01, self.locations_to_investigate[var_03].node, 1)) {
          var_04 = scripts\engine\utility::within_fov(self.origin, self.angles, self.locations_to_investigate[var_03].origin, var_02);
          var_05 = !var_04 || self.locations_to_investigate[var_03].frames_visible < 17;

          if(var_05 && distancesquared(self.origin, self.locations_to_investigate[var_03].origin) < var_00) {
            var_04 = 1;
            self.locations_to_investigate[var_03].frames_visible = 18;
          }

          if(var_04) {
            self.locations_to_investigate[var_03].frames_visible++;

            if(self.locations_to_investigate[var_03].frames_visible >= 18) {
              self.locations_to_investigate[var_03] = self.locations_to_investigate[self.locations_to_investigate.size - 1];
              self.locations_to_investigate[self.locations_to_investigate.size - 1] = undefined;
              var_3--;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

protect_watch_allies() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_00 = [];
  var_01 = 1050;
  var_02 = var_01 * var_01;
  var_03 = 900;

  if(isDefined(level.protect_radius))
    var_03 = level.protect_radius;

  for(;;) {
    var_04 = gettime();
    var_05 = bot_get_teammates_in_radius(self.bot_defending_center, var_03);

    foreach(var_07 in var_05) {
      var_08 = var_7.entity_number;

      if(!isDefined(var_08))
        var_08 = var_07 getentitynumber();

      if(!isDefined(var_0[var_08]))
        var_0[var_08] = var_04 - 1;

      if(!isDefined(var_7.last_investigation_time))
        var_7.last_investigation_time = var_04 - 10001;

      if(var_7.health == 0 && isDefined(var_7.deathtime) && var_04 - var_7.deathtime < 5000) {
        if(var_04 - var_7.last_investigation_time > 10000 && var_04 > var_0[var_08]) {
          if(isDefined(var_7.lastattacker) && isDefined(var_7.lastattacker.team) && var_7.lastattacker.team == scripts\engine\utility::get_enemy_team(self.team)) {
            if(distancesquared(var_7.origin, self.origin) < var_02) {
              self botgetimperfectenemyinfo(var_7.lastattacker, var_7.origin);
              var_09 = getclosestnodeinsight(var_7.origin);

              if(isDefined(var_09)) {
                self.defense_investigate_specific_point = var_9.origin;
                self notify("defend_force_node_recalculation");
              }

              var_7.last_investigation_time = var_04;
            }

            var_0[var_08] = var_04 + 10000;
          }
        }
      }
    }

    wait((randomint(5) + 1) * 0.05);
  }
}

defense_get_initial_entrances() {
  if(isDefined(self.defense_override_watch_nodes))
    return self.defense_override_watch_nodes;
  else if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var_00 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

    if(var_0.size == 0 && !isDefined(self.defend_entrance_index))
      var_00 = findentrances(self.origin);

    return var_00;
  } else if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    var_00 = findentrances(self.origin);
    return var_00;
  }
}

defense_watch_entrances_at_goal() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var_00 = self getnearestnode();
  var_01 = undefined;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var_02 = defense_get_initial_entrances();
    var_01 = [];

    if(isDefined(var_00)) {
      foreach(var_04 in var_02) {
        if(nodesvisible(var_00, var_04, 1))
          var_01 = scripts\engine\utility::array_add(var_01, var_04);
      }
    }
  } else if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    var_01 = defense_get_initial_entrances();

    if(isDefined(var_00) && !issubstr(self getcurrentweapon(), "riotshield")) {
      if(!scripts\mp\utility\game::istrue(var_0.ishacknode) && !scripts\mp\utility\game::istrue(self.node_closest_to_defend_center.ishacknode)) {
        if(nodesvisible(var_00, self.node_closest_to_defend_center, 1))
          var_01 = scripts\engine\utility::array_add(var_01, self.node_closest_to_defend_center);
      }
    }
  }

  if(isDefined(var_01)) {
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(var_01);

    if(scripts\mp\bots\bots_util::bot_is_bodyguarding())
      childthread bot_monitor_watch_entrances_bodyguard();
    else
      childthread bot_monitor_watch_entrances_at_goal();
  }
}

bot_monitor_watch_entrances_at_goal() {
  self notify("bot_monitor_watch_entrances_at_goal");
  self endon("bot_monitor_watch_entrances_at_goal");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  var_00 = level.bot_funcs["get_watch_node_chance"];

  for(;;) {
    foreach(var_02 in self.watch_nodes) {
      if(var_02 == self.node_closest_to_defend_center) {
        var_2.watch_node_chance[self.entity_number] = 0.8;
        continue;
      }

      var_2.watch_node_chance[self.entity_number] = 1.0;
    }

    var_04 = isDefined(var_00);

    if(!var_04)
      prioritize_watch_nodes_toward_enemies(0.5);

    foreach(var_02 in self.watch_nodes) {
      if(var_04) {
        var_06 = self[[var_00]](var_02);
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * var_06;
      }

      if(entrance_watched_by_ally(var_02))
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_monitor_watch_entrances_bodyguard() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  for(;;) {
    var_00 = anglesToForward(self.bot_defend_player_guarding.angles) * (1, 1, 0);
    var_00 = vectornormalize(var_00);

    foreach(var_02 in self.watch_nodes) {
      var_2.watch_node_chance[self.entity_number] = 1.0;
      var_03 = var_2.origin - self.bot_defend_player_guarding.origin;
      var_03 = vectornormalize(var_03);
      var_04 = vectordot(var_00, var_03);

      if(var_04 > 0.6)
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.33;
      else if(var_04 > 0)
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.66;

      if(!entrance_to_enemy_zone(var_02))
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

entrance_to_enemy_zone(var_00) {
  var_01 = getnodezone(var_00);
  var_02 = vectornormalize(var_0.origin - self.origin);

  for(var_03 = 0; var_03 < level.zonecount; var_3++) {
    if(botzonegetcount(var_03, self.team, "enemy_predict") > 0) {
      if(isDefined(var_01) && var_03 == var_01)
        return 1;
      else {
        var_04 = vectornormalize(getzoneorigin(var_03) - self.origin);
        var_05 = vectordot(var_02, var_04);

        if(var_05 > 0.2)
          return 1;
      }
    }
  }

  return 0;
}

prioritize_watch_nodes_toward_enemies(var_00) {
  if(self.watch_nodes.size <= 0) {
    return;
  }
  var_01 = self.watch_nodes;

  for(var_02 = 0; var_02 < level.zonecount; var_2++) {
    if(botzonegetcount(var_02, self.team, "enemy_predict") <= 0) {
      continue;
    }
    if(var_1.size == 0) {
      break;
    }
    var_03 = vectornormalize(getzoneorigin(var_02) - self.origin);

    for(var_04 = 0; var_04 < var_1.size; var_4++) {
      var_05 = getnodezone(var_1[var_04]);
      var_06 = 0;

      if(isDefined(var_05) && var_02 == var_05)
        var_06 = 1;
      else {
        var_07 = vectornormalize(var_1[var_04].origin - self.origin);
        var_08 = vectordot(var_07, var_03);

        if(var_08 > 0.2)
          var_06 = 1;
      }

      if(var_06) {
        var_1[var_04].watch_node_chance[self.entity_number] = var_1[var_04].watch_node_chance[self.entity_number] * var_00;
        var_1[var_04] = var_1[var_1.size - 1];
        var_1[var_1.size - 1] = undefined;
        var_4--;
      }
    }
  }
}

entrance_watched_by_ally(var_00) {
  var_01 = bot_get_teammates_currently_defending_point(self.bot_defending_center);

  foreach(var_03 in var_01) {
    if(entrance_watched_by_player(var_03, var_00))
      return 1;
  }

  return 0;
}

entrance_watched_by_player(var_00, var_01) {
  var_02 = anglesToForward(var_0.angles);
  var_03 = vectornormalize(var_1.origin - var_0.origin);
  var_04 = vectordot(var_02, var_03);

  if(var_04 > 0.6)
    return 1;

  return 0;
}

bot_get_teammates_currently_defending_point(var_00, var_01) {
  if(!isDefined(var_01)) {
    if(isDefined(level.protect_radius))
      var_01 = level.protect_radius;
    else
      var_01 = 900;
  }

  var_02 = [];
  var_03 = bot_get_teammates_in_radius(var_00, var_01);

  foreach(var_05 in var_03) {
    if(!isai(var_05) || var_05 scripts\mp\bots\bots_util::bot_is_defending_point(var_00))
      var_02 = scripts\engine\utility::array_add(var_02, var_05);
  }

  return var_02;
}

bot_get_teammates_in_radius(var_00, var_01) {
  var_02 = var_01 * var_01;
  var_03 = [];

  for(var_04 = 0; var_04 < level.participants.size; var_4++) {
    var_05 = level.participants[var_04];

    if(var_05 != self && isDefined(var_5.team) && var_5.team == self.team && scripts\mp\utility\game::isteamparticipant(var_05)) {
      if(distancesquared(var_00, var_5.origin) < var_02)
        var_03 = scripts\engine\utility::array_add(var_03, var_05);
    }
  }

  return var_03;
}

defense_death_monitor() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self))
    thread bot_defend_stop();
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

defend_get_ally_bots_at_zone_for_stance(var_00) {
  var_01 = [];

  foreach(var_03 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_03 != self && isai(var_03) && var_03 scripts\mp\bots\bots_util::bot_is_defending() && var_3.cur_defend_stance == var_00) {
      if(var_3.bot_defending_type == self.bot_defending_type && scripts\mp\bots\bots_util::bot_is_defending_point(var_3.bot_defending_center))
        var_01 = scripts\engine\utility::array_add(var_01, var_03);
    }
  }

  return var_01;
}

monitor_defend_player() {
  var_00 = 0;
  var_01 = 175;
  var_02 = self.bot_defend_player_guarding.origin;
  var_03 = 0;
  var_04 = 0;

  for(;;) {
    if(!isDefined(self.bot_defend_player_guarding))
      thread bot_defend_stop();

    self.bot_defending_center = self.bot_defend_player_guarding.origin;
    self.node_closest_to_defend_center = self.bot_defend_player_guarding getnearestnode();

    if(!isDefined(self.node_closest_to_defend_center))
      self.node_closest_to_defend_center = self getnearestnode();

    if(self botgetscriptgoaltype() != "none") {
      var_05 = self botgetscriptgoal();
      var_06 = self.bot_defend_player_guarding getvelocity();
      var_07 = lengthsquared(var_06);

      if(var_07 > 100) {
        var_00 = 0;

        if(distancesquared(var_02, self.bot_defend_player_guarding.origin) > var_01 * var_01) {
          var_02 = self.bot_defend_player_guarding.origin;
          var_04 = 1;
          var_08 = vectornormalize(var_05 - self.bot_defend_player_guarding.origin);
          var_09 = vectornormalize(var_06);

          if(vectordot(var_08, var_09) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      } else {
        var_00 = var_00 + 0.05;

        if(var_03 > 100 && var_04) {
          var_02 = self.bot_defend_player_guarding.origin;
          var_04 = 0;
        }

        if(var_00 > 0.5) {
          var_10 = distancesquared(var_05, self.bot_defending_center);

          if(var_10 > self.bot_defending_radius * self.bot_defending_radius) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      }

      var_03 = var_07;

      if(abs(self.bot_defend_player_guarding.origin[2] - var_5[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait 0.25;
      }
    }

    wait 0.05;
  }
}

find_defend_node_capture() {
  var_00 = bot_defend_get_random_entrance_point_for_current_area();
  var_01 = scripts\mp\bots\bots_util::bot_find_node_to_capture_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, var_00);

  if(isDefined(var_01)) {
    if(isDefined(var_00)) {
      var_02 = vectornormalize(var_00 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_02);
    } else {
      var_03 = vectornormalize(var_1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_03);
    }

    self.cur_defend_node = var_01;
  } else if(isDefined(var_00))
    bot_handle_no_valid_defense_node(var_00, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

find_defend_node_capture_zone() {
  var_00 = bot_defend_get_random_entrance_point_for_current_area();
  var_01 = scripts\mp\bots\bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes, var_00);

  if(isDefined(var_01)) {
    if(isDefined(var_00)) {
      var_02 = vectornormalize(var_00 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_02);
    } else {
      var_03 = vectornormalize(var_1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_03);
    }

    self.cur_defend_node = var_01;
  } else if(isDefined(var_00))
    bot_handle_no_valid_defense_node(var_00, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

find_defend_node_protect() {
  var_00 = scripts\mp\bots\bots_util::bot_find_node_that_protects_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(var_00)) {
    var_01 = vectornormalize(scripts\mp\bots\bots_util::defend_valid_center() - var_0.origin);
    self.cur_defend_angle_override = vectortoangles(var_01);
    self.cur_defend_node = var_00;
  } else
    bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

find_defend_node_bodyguard() {
  var_00 = scripts\mp\bots\bots_util::bot_find_node_to_guard_player(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(var_00))
    self.cur_defend_node = var_00;
  else {
    var_01 = self getnearestnode();

    if(isDefined(var_01))
      self.cur_defend_node = var_01;
    else
      self.cur_defend_point_override = self.origin;
  }
}

find_defend_node_patrol() {
  var_00 = undefined;
  var_01 = self _meth_8533();
  var_02 = getnodesinradius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, 0, 520, "path", var_01);

  if(isDefined(var_02) && var_2.size > 0)
    var_00 = self botnodepick(var_02, 1 + var_2.size * 0.5, "node_traffic");

  if(isDefined(var_00))
    self.cur_defend_node = var_00;
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

bot_handle_no_valid_defense_node(var_00, var_01) {
  if(self.bot_defending_type == "capture_zone")
    self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_from_set(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_nodes, ::func_2D2A);
  else
    self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_in_radius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, ::func_2D2A, 0.15, 0.9);

  if(isDefined(var_00)) {
    var_02 = vectornormalize(var_00 - self.cur_defend_point_override);
    self.cur_defend_angle_override = vectortoangles(var_02);
  } else if(isDefined(var_01)) {
    var_02 = vectornormalize(self.cur_defend_point_override - var_01);
    self.cur_defend_angle_override = vectortoangles(var_02);
  }
}

func_2D2A(var_00) {
  if(func_2D2F(var_00, 1, 1, 1))
    return 0;

  return 1;
}

func_2D2F(var_00, var_01, var_02, var_03) {
  for(var_04 = 0; var_04 < level.participants.size; var_4++) {
    var_05 = level.participants[var_04];

    if(var_5.team == self.team && var_05 != self) {
      if(isai(var_05)) {
        if(var_02) {
          if(distancesquared(var_00, var_5.origin) < 441)
            return 1;
        }

        if(var_03 && var_05 bothasscriptgoal()) {
          var_06 = var_05 botgetscriptgoal();

          if(distancesquared(var_00, var_06) < 441)
            return 1;
        }

        continue;
      }

      if(var_01) {
        if(distancesquared(var_00, var_5.origin) < 441)
          return 1;
      }
    }
  }

  return 0;
}

func_2D2D() {
  var_00 = 0;

  if(isDefined(self.bot_defending_nodes)) {
    foreach(var_02 in self.bot_defending_nodes) {
      var_03 = distance(self.bot_defending_center, var_2.origin);
      var_00 = max(var_03, var_00);
    }
  }

  return var_00;
}

bot_think_tactical_goals() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.tactical_goals = [];

  for(;;) {
    if(self.tactical_goals.size > 0 && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      var_00 = self.tactical_goals[0];

      if(!isDefined(var_0.abort)) {
        self notify("start_tactical_goal");

        if(isDefined(var_0.start_thread))
          self[[var_0.start_thread]](var_00);

        childthread watch_goal_aborted(var_00);
        var_01 = "tactical";

        if(isDefined(var_0.goal_type))
          var_01 = var_0.goal_type;

        self botsetscriptgoal(var_0.goal_position, var_0.goal_radius, var_01, var_0.goal_yaw, var_0.objective_radius);
        var_02 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");

        if(var_02 == "goal") {
          if(isDefined(var_0.action_thread))
            self[[var_0.action_thread]](var_00);
        }

        if(var_02 != "script_goal_changed")
          self botclearscriptgoal();

        if(isDefined(var_0.end_thread))
          self[[var_0.end_thread]](var_00);
      }

      self.tactical_goals = scripts\engine\utility::array_remove(self.tactical_goals, var_00);
    }

    wait 0.05;
  }
}

watch_goal_aborted(var_00) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;

  for(;;) {
    if(isDefined(var_0.abort) || isDefined(var_0.should_abort) && self[[var_0.should_abort]](var_00))
      self notify("stop_tactical_goal");

    wait 0.05;
  }
}

bot_new_tactical_goal(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  var_4.type = var_00;
  var_4.goal_position = var_01;

  if(isDefined(self.only_allowable_tactical_goals)) {
    if(!scripts\engine\utility::array_contains(self.only_allowable_tactical_goals, var_00))
      return;
  }

  var_4.priority = var_02;
  var_4.object = var_3.object;
  var_4.goal_type = var_3.script_goal_type;
  var_4.goal_yaw = var_3.script_goal_yaw;
  var_4.goal_radius = 0;

  if(isDefined(var_3.script_goal_radius))
    var_4.goal_radius = var_3.script_goal_radius;

  var_4.start_thread = var_3.start_thread;
  var_4.end_thread = var_3.end_thread;
  var_4.should_abort = var_3.should_abort;
  var_4.action_thread = var_3.action_thread;
  var_4.objective_radius = var_3.objective_radius;

  for(var_05 = 0; var_05 < self.tactical_goals.size; var_5++) {
    if(var_4.priority > self.tactical_goals[var_05].priority) {
      break;
    }
  }

  for(var_06 = self.tactical_goals.size - 1; var_06 >= var_05; var_6--)
    self.tactical_goals[var_06 + 1] = self.tactical_goals[var_06];

  self.tactical_goals[var_05] = var_04;
}

bot_has_tactical_goal(var_00, var_01) {
  if(!isDefined(self.tactical_goals))
    return 0;

  if(isDefined(var_00)) {
    foreach(var_03 in self.tactical_goals) {
      if(var_3.type == var_00) {
        if(isDefined(var_01) && isDefined(var_3.object))
          return var_3.object == var_01;
        else
          return 1;
      }
    }

    return 0;
  } else
    return self.tactical_goals.size > 0;
}

bot_abort_tactical_goal(var_00, var_01) {
  if(!isDefined(self.tactical_goals)) {
    return;
  }
  foreach(var_03 in self.tactical_goals) {
    if(var_3.type == var_00) {
      if(isDefined(var_01)) {
        if(isDefined(var_3.object) && var_3.object == var_01)
          var_3.abort = 1;

        continue;
      }

      var_3.abort = 1;
    }
  }
}

bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "map_interactive_object";

  foreach(var_01 in self.tactical_goals) {
    if(var_1.type != "map_interactive_object")
      var_1.abort = 1;
  }
}

bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

bot_melee_tactical_insertion_check() {
  var_00 = gettime();

  if(!isDefined(self.last_melee_ti_check) || var_00 - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = var_00;
    var_01 = bot_get_ambush_trap_item("tacticalinsertion");

    if(!isDefined(var_01))
      return 0;

    if(isDefined(self.enemy) && self botcanseeentity(self.enemy))
      return 0;

    var_02 = getzonenearest(self.origin);

    if(!isDefined(var_02))
      return 0;

    var_03 = botzonenearestcount(var_02, self.team, 1, "enemy_predict", ">", 0);

    if(!isDefined(var_03))
      return 0;

    var_04 = self _meth_8533();
    var_05 = getnodesinradius(self.origin, 500, 0, 999, "path", var_04);

    if(var_5.size <= 0)
      return 0;

    var_06 = self botnodepick(var_05, var_5.size * 0.15, "node_hide");

    if(!isDefined(var_06))
      return 0;

    return bot_set_ambush_trap(var_01, undefined, undefined, undefined, var_06);
  }

  return 0;
}