/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_strategy.gsc
***********************************************/

function bot_defend_get_random_entrance_point_for_current_area() {
  var_0 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isDefined(var_0) && var_0.size > 0) {
    return scripts\engine\utility::random(var_0).origin;
  }

  return undefined;
}

function bot_defend_get_precalc_entrances_for_current_area(var_0, var_1) {
  if(isDefined(self.defend_entrance_index)) {
    return scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(var_0, self.defend_entrance_index, var_1);
  }

  return [];
}

function bot_get_ambush_trap_item(var_0, var_1, var_2) {
  if(self botgetdifficultysetting("allowGrenades") == 0) {
    return undefined;
  }

  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, var_0);
}

function bot_set_ambush_trap(var_0, var_1, var_2, var_3, var_4) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(var_0)) {
    return false;
  }

  var_5 = undefined;

  if(!isDefined(var_4) && isDefined(var_1) && var_1.size > 0) {
    if(!isDefined(var_2)) {
      return false;
    }

    var_6 = [];
    var_7 = undefined;

    if(isDefined(var_3)) {
      var_7 = anglesToForward((0, var_3, 0));
    }

    foreach(var_9 in var_1) {
      if(!isDefined(var_7)) {
        var_6 = var_9;
        continue;
      }

      if(distancesquared(var_9.origin, var_2.origin) > 90000) {
        if(vectordot(var_7, vectorNormalize(var_9.origin - var_2.origin)) < 0.4) {
          var_6 = var_9;
        }
      }
    }

    if(var_6.size > 0) {
      var_5 = scripts\engine\utility::random(var_6);
      var_11 = getnodesinradius(var_5.origin, 300, 50);
      var_12 = [];

      foreach(var_14 in var_11) {
        if(!isDefined(var_14.bot_ambush_end)) {
          var_12 = var_14;
        }
      }

      var_11 = var_12;
      var_4 = self botnodepick(var_11, min(var_11.size, 3), "node_trap", var_2, var_5);
    }
  }

  if(isDefined(var_4)) {
    var_16 = undefined;

    if(var_0["purpose"] == "trap_directional" && isDefined(var_5)) {
      var_17 = vectortoangles(var_5.origin - var_4.origin);
      var_16 = var_17[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical") {
      self botclearscriptgoal();
    }

    var_18 = self botsetscriptgoalnode(var_4, "guard", var_16);

    if(var_18) {
      var_19 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_19 == "goal") {
        thread scripts\mp\bots\bots_util::bot_force_stance_for_time("stand", 4);

        if(!isDefined(self.enemy) || !self botcanseeentity(self.enemy)) {
          thread scripts\mp\bots\bots_util::damage_func(4);
          var_20 = (0, 0, 0);

          if(issubstr(var_0["weap_name"].basename, "claymore")) {
            var_20 = (0, 0, 55);
          }

          if(isDefined(var_16)) {
            self botlookatpoint(var_5.origin + var_20, 3, "script_forced");
          } else {
            self botlookatpoint(self.origin + var_20 + anglesToForward(self getplayerangles()) * 50, 3, "script_forced");
          }

          if(!isDefined(var_0["item_action"])) {
            var_0 = bot_get_ambush_trap_item("trap_directional", "trap");
          }

          if(isDefined(var_0["item_action"])) {
            debug_chopper_boss(var_0["item_action"]);
          }

          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("grenade_fire");
          thread bot_set_ambush_trap_wait_fire("missile_fire");
          var_21 = scripts\engine\utility::ter_op(isDefined(var_0["purpose"]) && var_0["purpose"] == "tacticalinsertion", 6, 3);
          scripts\engine\utility::ref_143ba(var_21, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");

          if(isDefined(self.ambush_trap_ent) && isDefined(var_0["purpose"]) && var_0["purpose"] == "c4") {
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

function debug_chopper_boss(var_0) {
  self endon("grenade_pullback");

  for(;;) {
    self botpressbutton(var_0);
    wait 0.5;
  }
}

function bot_set_ambush_trap_wait_fire(var_0) {
  self endon("death_or_disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(var_0, var_1);
  self.ambush_trap_ent = var_1;
}

function bot_watch_manual_detonate(var_0, var_1) {
  self endon("death_or_disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_2 = var_1 * var_1;

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) > var_2) {
      var_3 = self getclosestenemysqdist(var_0.origin, 1);

      if(var_3 < var_2) {
        self botpressbutton("use", 0.25);
        wait 0.5;
        self botpressbutton("use", 0.25);
        return;
      }
    }

    wait randomfloatrange(0.25, 1);
  }
}

function bot_capture_point(var_0, var_1, var_2) {
  thread bot_defend_think(var_0, var_1, "capture", var_2);
}

function bot_capture_zone(var_0, var_1, var_2, var_3) {
  GscBinSkip0(0x2e, "capture_trigger", var_2);
}

function bot_protect_point(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 12);
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 18);
  }

  thread bot_defend_think(var_0, var_1, "protect", var_2);
}

function bot_protect_zone(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || !isDefined(var_3["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 12);
  }

  if(!isDefined(var_3) || !isDefined(var_3["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 18);
  }

  if(!isDefined(var_3) || !isDefined(var_3["random_stance"])) {
    GscBinSkip0(0x2e, "random_stance", 1);
  }

  GscBinSkip0(0x2e, "uniqueID", var_2);
}

function bot_patrol_area(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 0);
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 0.01);
  }

  thread bot_defend_think(var_0, var_1, "patrol", var_2);
}

function bot_guard_player(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 15);
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 20);
  }

  thread bot_defend_think(var_0, var_1, "bodyguard", var_2);
}

function bot_defend_requires_center(var_0) {
  if(var_0 == "protect_zone") {
    return false;
  }

  return true;
}

function bot_defend_think(var_0, var_1, var_2, var_3) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death_or_disconnect");
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
  } else if(var_2 == "protect_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = var_1;
    self.bot_defending_zone_id = var_3["uniqueID"];
  } else {
    self.bot_defending_radius = var_1;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(scripts\mp\utility\entity::isgameparticipant(var_0)) {
    self.bot_defend_player_guarding = var_0;
    GscBinSkip4(0x35);
  }

  self.bot_defend_player_guarding = undefined;
  self.bot_defending_center = var_0;
  self botsetstance("none");
  var_4 = undefined;
  var_5 = 6;
  var_6 = 10;
  self.defense_score_flags = [];

  if(isDefined(var_3)) {
    self.defend_entrance_index = var_3["entrance_points_index"];
    self.bot_defending_override_origin_node = var_3["override_origin_node"];

    if(isDefined(var_3["score_flags"])) {
      if(isarray(var_3["score_flags"])) {
        self.defense_score_flags = var_3["score_flags"];
      } else {
        self.defense_score_flags[0] = var_3["score_flags"];
      }
    }

    if(isDefined(var_3["override_goal_type"])) {
      var_4 = var_3["override_goal_type"];
    }

    if(isDefined(var_3["min_goal_time"])) {
      var_5 = var_3["min_goal_time"];
    }

    if(isDefined(var_3["max_goal_time"])) {
      var_6 = var_3["max_goal_time"];
    }

    if(isDefined(var_3["override_watch_nodes"]) && var_3["override_watch_nodes"].size > 0) {
      self.defense_override_watch_nodes = var_3["override_watch_nodes"];
    }

    self.defend_objective_radius = var_3["objective_radius"];
  }

  if(!isDefined(self.bot_defend_player_guarding) && bot_defend_requires_center(var_2)) {
    var_7 = undefined;

    if(isDefined(var_3) && isDefined(var_3["nearest_node_to_center"])) {
      var_7 = var_3["nearest_node_to_center"];
    }

    if(!isDefined(var_7) && isDefined(self.bot_defending_override_origin_node)) {
      var_7 = self.bot_defending_override_origin_node;
    }

    if(!isDefined(var_7) && isDefined(self.bot_defending_trigger) && isDefined(self.bot_defending_trigger.nearest_node)) {
      var_7 = self.bot_defending_trigger.nearest_node;
    }

    if(!isDefined(var_7)) {
      var_7 = getclosestnodeinsight(scripts\mp\bots\bots_util::defend_valid_center());
    }

    if(!isDefined(var_7)) {
      var_8 = scripts\mp\bots\bots_util::defend_valid_center();
      var_9 = getnodesinradiussorted(var_8, 256, 0);

      for(var_10 = 0; var_10 < var_9.size; var_10++) {
        var_11 = vectorNormalize(var_9[var_10].origin - var_8);
        var_12 = var_8 + var_11 * 15;

        if(sighttracepassed(var_12, var_9[var_10].origin, 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        wait 0.05;

        if(sighttracepassed(var_12 + (0, 0, 55), var_9[var_10].origin + (0, 0, 55), 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        wait 0.05;
      }
    }

    self.node_closest_to_defend_center = var_7;
  } else if(isDefined(var_3) && isDefined(var_3["nearest_node_to_center"])) {
    self.node_closest_to_defend_center = var_3["nearest_node_to_center"];
  }

  var_13 = level.bot_find_defend_node_func[var_2];

  if(!isDefined(var_4)) {
    var_4 = "guard";

    if(var_2 == "capture" || var_2 == "capture_zone") {
      var_4 = "objective";
    }
  }

  var_14 = 0;
  var_15 = 0;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var_14 = 1;
    var_15 = isDefined(var_3) && isDefined(var_3["entrance_points_index"]) && isarray(var_3["entrance_points_index"]);
  } else if(isDefined(var_3) && istrue(var_3["random_stance"])) {
    var_14 = 1;
    var_15 = 1;
  }

  var_16 = 1;

  if(isDefined(var_3) && istrue(var_3["dont_leave_goal_during_combat"])) {
    var_16 = 0;
  }

  jumpiffalse(var_2 == "protect") LOC_000003a9;
  GscBinSkip4(0x35);

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.cur_defend_stance = calculate_defend_stance(var_14, var_15);
    var_17 = self botgetscriptgoaltype();
    var_18 = scripts\mp\bots\bots_util::bot_goal_can_override(var_4, var_17);

    if(!var_18) {
      wait 0.25;
      continue;
    }

    var_19 = var_5;
    var_20 = var_6;
    var_21 = 1;

    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      var_21 = 0;
      var_19 = 1;
      var_20 = 2;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      if(isDefined(level.aerial_danger_exists_for) && level.aerial_danger_exists_for[self.team]) {
        if(!scripts\engine\utility::array_contains(self.defense_score_flags, "avoid_aerial_enemies")) {
          self.defense_score_flags[self.defense_score_flags.size] = "avoid_aerial_enemies";
        }
      }

      self[[var_13]]();
    }

    self botclearscriptgoal();
    var_22 = "";

    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(var_21 && scripts\mp\bots\bots_util::bot_is_protecting() && !isPlayer(var_0) && isDefined(self.defend_entrance_index)) {
        var_23 = bot_get_ambush_trap_item("trap_directional", "trap", "c4");

        if(isDefined(var_23)) {
          var_24 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(var_23, var_24, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        var_25 = undefined;

        if(isDefined(self.cur_defend_angle_override)) {
          var_25 = self.cur_defend_angle_override[1];
        }

        self botsetscriptgoal(self.cur_defend_point_override, 0, var_4, var_25, self.defend_objective_radius);
      } else if(!isDefined(self.cur_defend_angle_override)) {
        self botsetscriptgoalnode(self.cur_defend_node, var_4, undefined, self.defend_objective_radius);
      } else {
        self botsetscriptgoalnode(self.cur_defend_node, var_4, self.cur_defend_angle_override[1], self.defend_objective_radius);
      }

      if(var_14) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node) {
          self botsetstance("none");
        }
      }

      var_26 = self botgetscriptgoal();
      self notify("new_defend_goal");
      scripts\mp\bots\bots_util::watch_nodes_stop();

      if(var_4 == "objective") {
        defense_cautious_approach();
        self botsetawareness(1);
        self botsetflag("cautious", 0);
      }

      if(self bothasscriptgoal()) {
        var_27 = self botgetscriptgoal();

        if(scripts\mp\bots\bots_util::bot_vectors_are_equal(var_27, var_26)) {
          var_22 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
        }
      }

      if(var_22 == "goal") {
        if(var_14) {
          self botsetstance(self.cur_defend_stance);
        }

        GscBinSkip4(0x35);
      }
    }

    if(var_22 != "goal") {
      var_28 = 0.25;

      if(var_22 == "no_path" && isDefined(self.defend_wait_time_when_no_path)) {
        var_28 = self.defend_wait_time_when_no_path;
      }

      wait var_28;
      continue;
    }

    var_29 = randomfloatrange(var_19, var_20);
    var_22 = scripts\engine\utility::ref_143bd(var_29, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((var_22 == "node_relinquished" || var_22 == "bad_path" || var_22 == "goal_changed" || var_22 == "script_goal_changed") && (self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone")) {
      self botsetstance("none");
    }

    if(var_22 == "timeout" && !var_16) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time();
    }
  }
}

function calculate_defend_stance(var_0, var_1) {
  var_2 = "stand";

  if(var_0) {
    var_3 = 100;
    var_4 = 0;
    var_5 = 0;
    var_6 = self botgetdifficultysetting("strategyLevel");

    if(var_6 == 1) {
      var_3 = 20;
      var_4 = 25;
      var_5 = 55;
    } else if(var_6 >= 2) {
      var_3 = 10;
      var_4 = 20;
      var_5 = 70;
    }

    var_7 = randomint(100);

    if(var_7 < var_4) {
      var_2 = "crouch";
    } else if(var_7 < var_4 + var_5) {
      var_2 = "prone";
    }

    var_8 = !isDefined(var_1) || !var_1;

    if(var_8 && var_2 == "prone") {
      var_9 = bot_defend_get_precalc_entrances_for_current_area("prone");
      var_10 = defend_get_ally_bots_at_zone_for_stance("prone");

      if(var_10.size >= var_9.size) {
        var_2 = "crouch";
      }
    }

    if(var_8 && var_2 == "crouch") {
      var_11 = bot_defend_get_precalc_entrances_for_current_area("crouch");
      var_12 = defend_get_ally_bots_at_zone_for_stance("crouch");

      if(var_12.size >= var_11.size) {
        var_2 = "stand";
      }
    }
  }

  return var_2;
}

function should_start_cautious_approach_default(var_0) {
  var_1 = 1250;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      return 0;
    }

    if(self.bot_defending_type == "capture_zone" && self istouching(self.bot_defending_trigger)) {
      return 0;
    }

    return (distancesquared(self.origin, self.bot_defending_center) > var_2 * 0.75 * 0.75);
  }

  if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < var_2) {
    var_3 = self botgetpathdist();
    return (0 <= var_3 && var_3 <= var_1);
  }

  return 0;
}

function setup_investigate_location(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_1)) {
    var_2.origin = var_1;
  } else {
    var_2.origin = var_0.origin;
  }

  var_2.node = var_0;
  var_2.frames_visible = 0;
  return var_2;
}

function defense_cautious_approach() {
  self notify("defense_cautious_approach");
  self endon("defense_cautious_approach");
  level endon("game_ended");
  self endon("defend_force_node_recalculation");
  self endon("death_or_disconnect");
  self endon("defend_stop");
  self endon("started_bot_defend_think");

  if(![[level.bot_funcs["should_start_cautious_approach"]]](1)) {
    return;
  }

  var_0 = self botgetscriptgoal();
  var_1 = self botgetscriptgoalnode();
  var_2 = 1;
  var_3 = 0.2;
  var_4 = 0;

  while(var_2) {
    wait 0.25;
    var_4 += 0.25;

    if(!self bothasscriptgoal()) {
      return;
    }

    var_5 = self botgetscriptgoal();

    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(var_0, var_5)) {
      return;
    }

    if(var_4 >= 1) {
      var_6 = self botgetnodesonpath();

      if(var_6.size == 0) {
        self botclearscriptgoal();
        return;
      }
    }

    var_3 += 0.25;

    if(var_3 >= 0.5) {
      var_3 = 0;

      if([[level.bot_funcs["should_start_cautious_approach"]]](0)) {
        var_2 = 0;
      }
    }
  }

  self botsetawareness(1.8);
  self botsetflag("cautious", 1);
  var_7 = self botgetnodesonpath();

  if(!isDefined(var_7) || var_7.size <= 2) {
    return;
  }

  self.locations_to_investigate = [];
  var_8 = 1000;

  if(isDefined(level.protect_radius)) {
    var_8 = level.protect_radius;
  }

  var_9 = var_8 * var_8;
  var_10 = getnodesinradius(self.bot_defending_center, var_8, 0, 500);

  if(var_10.size <= 0) {
    return;
  }

  var_11 = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  var_12 = int(min(var_11, var_10.size));
  var_13 = self botnodepickmultiple(var_10, 15, var_12, "node_protect", scripts\mp\bots\bots_util::defend_valid_center(), "ignore_occupancy");

  for(var_14 = 0; var_14 < var_13.size; var_14++) {
    var_15 = setup_investigate_location(var_13[var_14]);
    self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_15);
  }

  var_16 = botgetmemoryevents(0, gettime() - 60000, 1, "death", 0, self);

  foreach(var_18 in var_16) {
    if(distancesquared(var_18, self.bot_defending_center) < var_9) {
      var_19 = getclosestnodeinsight(var_18);

      if(isDefined(var_19)) {
        var_15 = setup_investigate_location(var_19, var_18);
        self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_15);
      }
    }
  }

  if(isDefined(self.defend_entrance_index)) {
    var_21 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index("stand", self.defend_entrance_index);

    for(var_14 = 0; var_14 < var_21.size; var_14++) {
      var_15 = setup_investigate_location(var_21[var_14]);
      self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_15);
    }
  }

  if(self.locations_to_investigate.size == 0) {
    return;
  }

  GscBinSkip4(0x35);
}

function monitor_cautious_approach_early_out() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_0 = undefined;

  if(isDefined(self.bot_defending_radius)) {
    var_0 = self.bot_defending_radius * self.bot_defending_radius;
  } else if(isDefined(self.bot_defending_nodes)) {
    var_1 = bot_capture_zone_get_furthest_distance();
    var_0 = var_1 * var_1;
  }

  wait 0.05;

  for(;;) {
    if(distancesquared(self.origin, self.bot_defending_center) < var_0) {
      self notify("cautious_approach_early_out");
    }

    wait 0.05;
  }
}

function monitor_cautious_approach_dangerous_locations() {
  self endon("stop_location_monitoring");
  var_0 = 10000;

  for(;;) {
    var_1 = self getnearestnode();

    if(isDefined(var_1)) {
      var_2 = self botgetfovdot();

      for(var_3 = 0; var_3 < self.locations_to_investigate.size; var_3++) {
        if(nodesvisible(var_1, self.locations_to_investigate[var_3].node, 1)) {
          var_4 = scripts\engine\utility::within_fov(self.origin, self getplayerangles(), self.locations_to_investigate[var_3].origin, var_2);
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

    wait 0.05;
  }
}

function protect_watch_allies() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_0 = [];
  var_1 = 1050;
  var_2 = var_1 * var_1;
  var_3 = 900;
  jumpiffalse(isDefined(level.protect_radius)) LOC_00000031;
  var_3 = level.protect_radius;

  for(;;) {
    var_4 = gettime();
    var_5 = bot_get_teammates_in_radius(self.bot_defending_center, var_3);

    foreach(var_7 in var_5) {
      var_8 = var_7.entity_number;

      if(!isDefined(var_8)) {
        var_8 = var_7 getentitynumber();
      }

      if(!isDefined(var_0[var_8])) {
        var_0 = var_4 - 1;
      }

      if(!isDefined(var_7.last_investigation_time)) {
        var_7.last_investigation_time = var_4 - 10001;
      }

      if(var_7.health == 0 && isDefined(var_7.deathtime) && var_4 - var_7.deathtime < 5000) {
        if(var_4 - var_7.last_investigation_time > 10000 && var_4 > var_0[var_8]) {
          if(isDefined(var_7.lastattacker) && isDefined(var_7.lastattacker.team) && var_7.lastattacker.team == scripts\engine\utility::get_enemy_team(self.team)) {
            if(distancesquared(var_7.body.origin, self.origin) < var_2) {
              self botgetimperfectenemyinfo(var_7.lastattacker, var_7.body.origin);
              var_9 = getclosestnodeinsight(var_7.body.origin);

              if(isDefined(var_9)) {
                self.defense_investigate_specific_point = var_9.origin;
                self notify("defend_force_node_recalculation");
              }

              var_7.last_investigation_time = var_4;
            }

            var_0 = var_4 + 10000;
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

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    return bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance, 1);
  }

  if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    var_0 = findentrances(self.origin);
    return var_0;
  }
}

function defense_watch_entrances_at_goal() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var_0 = self getnearestnode();
  var_1 = undefined;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var_2 = defense_get_initial_entrances();
    var_1 = [];

    if(isDefined(var_0)) {
      foreach(var_4 in var_2) {
        if(nodesvisible(var_0, var_4, 1)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_4);
        }
      }
    }

    if(var_1.size == 0) {
      var_1 = findentrances(self.origin);
    }
  } else if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    var_1 = defense_get_initial_entrances();
    var_6 = self getcurrentweapon();

    if(isDefined(var_0) && !issubstr(var_6.basename, "riotshield") && isDefined(self.node_closest_to_defend_center)) {
      if(nodesvisible(var_0, self.node_closest_to_defend_center, 1)) {
        var_1 = scripts\engine\utility::array_add(var_1, self.node_closest_to_defend_center);
      }
    }
  }

  if(isDefined(var_1)) {
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(var_1);

    if(scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
      GscBinSkip4(0x35);
    }

    if(isDefined(level.bot_funcs["bot_entrance_update"])) {
      self childthread[[level.bot_funcs["bot_entrance_update"]]]();
      return;
    }

    GscBinSkip4(0x35);
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

  var_0 = level.bot_funcs["get_watch_node_chance"];

  for(;;) {
    var_1 = 0.8;
    var_2 = 1;

    if(scripts\engine\utility::array_contains(self.defense_score_flags, "strict_los")) {
      var_1 = 1;
      var_2 = 0.5;
    }

    if(isDefined(self.node_closest_to_defend_center)) {
      foreach(var_4 in self.watch_nodes) {
        if(var_4 == self.node_closest_to_defend_center) {
          var_4.watch_node_chance[self.entity_number] = var_4.watch_node_base_chance[self.entity_number] * var_1;
          continue;
        }

        var_4.watch_node_chance[self.entity_number] = var_4.watch_node_base_chance[self.entity_number] * var_2;
      }
    }

    var_6 = isDefined(var_0);

    if(!var_6) {
      prioritize_watch_nodes_toward_enemies(0.5);
    }

    foreach(var_4 in self.watch_nodes) {
      if(var_6) {
        var_8 = self[[var_0]](var_4);
        var_4.watch_node_chance[self.entity_number] *= var_8;
      }

      if(entrance_watched_by_ally(var_4)) {
        var_4.watch_node_chance[self.entity_number] *= 0.5;
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

  for(;;) {
    jumpiftrue(isDefined(self.watch_nodes)) LOC_00000031;
    wait 0.05;
  }

  for(;;) {
    var_0 = anglesToForward(self.bot_defend_player_guarding getplayerangles()) * (1, 1, 0);
    var_0 = vectorNormalize(var_0);

    foreach(var_2 in self.watch_nodes) {
      var_2.watch_node_chance[self.entity_number] = var_2.watch_node_base_chance[self.entity_number];
      var_3 = var_2.origin - self.bot_defend_player_guarding.origin;
      var_3 = vectorNormalize(var_3);
      var_4 = vectordot(var_0, var_3);

      if(var_4 > 0.6) {
        var_2.watch_node_chance[self.entity_number] *= 0.33;
      } else if(var_4 > 0) {
        var_2.watch_node_chance[self.entity_number] *= 0.66;
      }

      if(!entrance_to_enemy_zone(var_2)) {
        var_2.watch_node_chance[self.entity_number] *= 0.5;
      }
    }

    wait randomfloatrange(0.4, 0.6);
  }
}

function entrance_to_enemy_zone(var_0) {
  var_1 = getnodezone(var_0);
  var_2 = vectorNormalize(var_0.origin - self.origin);

  for(var_3 = 0; var_3 < level.zonecount; var_3++) {
    if(botzonegetcount(var_3, self.team, "enemy_predict") > 0) {
      if(isDefined(var_1) && var_3 == var_1) {
        return true;
      } else {
        var_4 = vectorNormalize(getzoneorigin(var_3) - self.origin);
        var_5 = vectordot(var_2, var_4);

        if(var_5 > 0.2) {
          return true;
        }
      }
    }
  }

  return false;
}

function prioritize_watch_nodes_toward_enemies(var_0) {
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

    var_3 = vectorNormalize(getzoneorigin(var_2) - self.origin);

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_5 = getnodezone(var_1[var_4]);
      var_6 = 0;

      if(isDefined(var_5) && var_2 == var_5) {
        var_6 = 1;
      } else {
        var_7 = vectorNormalize(var_1[var_4].origin - self.origin);
        var_8 = vectordot(var_7, var_3);

        if(var_8 > 0.2) {
          var_6 = 1;
        }
      }

      if(var_6) {
        var_1[var_4].watch_node_chance[self.entity_number] *= var_0;
        var_1 = var_1[var_1.size - 1];
        var_1[var_1.size - 1] = undefined;
        var_4--;
      }
    }
  }
}

function entrance_watched_by_ally(var_0) {
  if(self.bot_defending_type == "protect_zone") {
    var_1 = bot_get_teammates_currently_defending_zone(self.bot_defending_zone_id);
  } else {
    var_1 = bot_get_teammates_currently_defending_point(self.bot_defending_center);
  }

  foreach(var_3 in var_1) {
    if(entrance_watched_by_player(var_3, var_1)) {
      return true;
    }
  }

  return false;
}

function entrance_watched_by_player(var_0, var_1) {
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = vectorNormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.6) {
    return true;
  }

  return false;
}

function bot_get_teammates_currently_defending_zone(var_0) {
  var_1 = [];
  var_2 = bot_get_teammates_in_radius(self.origin, 1000);

  foreach(var_4 in var_2) {
    if(!isai(var_4) || var_4 scripts\mp\bots\bots_util::bot_is_defending() && var_4.bot_defending_zone_id == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  return var_1;
}

function bot_get_teammates_currently_defending_point(var_0, var_1) {
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
    if(!isai(var_5) || var_5 scripts\mp\bots\bots_util::bot_is_defending_point(var_0)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  return var_2;
}

function bot_get_teammates_in_radius(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = [];

  for(var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];

    if(var_5 != self && isDefined(var_5.team) && var_5.team == self.team && scripts\mp\utility\entity::isteamparticipant(var_5)) {
      if(distancesquared(var_0, var_5.origin) < var_2) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  return var_3;
}

function defense_death_monitor() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self)) {
    thread bot_defend_stop();
    return;
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

function defend_get_ally_bots_at_zone_for_stance(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }

    if(var_3.team == self.team && var_3 != self && isai(var_3) && var_3 scripts\mp\bots\bots_util::bot_is_defending() && isDefined(var_3.cur_defend_stance) && var_3.cur_defend_stance == var_0) {
      if(var_3.bot_defending_type == self.bot_defending_type && scripts\mp\bots\bots_util::bot_is_defending_point(var_3.bot_defending_center)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

function monitor_defend_player() {
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
          var_8 = vectorNormalize(var_5 - self.bot_defend_player_guarding.origin);
          var_9 = vectorNormalize(var_6);

          if(vectordot(var_8, var_9) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      } else {
        var_0 += 0.05;

        if(var_3 > 100 && var_4) {
          var_2 = self.bot_defend_player_guarding.origin;
          var_4 = 0;
        }

        if(var_0 > 0.5) {
          var_10 = distancesquared(var_5, self.bot_defending_center);

          if(var_10 > self.bot_defending_radius * self.bot_defending_radius) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      }

      var_3 = var_7;

      if(abs(self.bot_defend_player_guarding.origin[2] - var_5[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait 0.25;
      }
    }

    wait 0.05;
  }
}

function find_defend_node_capture() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = scripts\mp\bots\bots_util::bot_find_node_to_capture_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectorNormalize(var_1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
    return;
  }

  if(isDefined(var_0)) {
    bot_handle_no_valid_defense_node(var_0, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

function find_defend_node_capture_zone() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = scripts\mp\bots\bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectorNormalize(var_1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
    return;
  }

  if(isDefined(var_0)) {
    bot_handle_no_valid_defense_node(var_0, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

function find_defend_node_protect() {
  var_0 = scripts\mp\bots\bots_util::bot_find_node_that_protects_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(var_0)) {
    var_1 = vectorNormalize(scripts\mp\bots\bots_util::defend_valid_center() - var_0.origin);
    self.cur_defend_angle_override = vectortoangles(var_1);
    self.cur_defend_node = var_0;
    return;
  }

  bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

function find_defend_node_protect_zone() {
  var_0 = scripts\mp\bots\bots_util::bot_find_node_to_protect_zone(self.bot_defending_nodes, scripts\mp\bots\bots_util::defend_valid_center());

  if(isDefined(var_0)) {
    self.cur_defend_node = var_0;
    return;
  }

  bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

function find_defend_node_bodyguard() {
  var_0 = scripts\mp\bots\bots_util::bot_find_node_to_guard_player(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

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

function find_defend_node_patrol() {
  var_0 = undefined;
  var_1 = getnodesinradius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, 0);

  if(isDefined(var_1) && var_1.size > 0) {
    var_0 = self botnodepick(var_1, 1 + var_1.size * 0.5, "node_traffic");
  }

  if(isDefined(var_0)) {
    self.cur_defend_node = var_0;
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

function bot_handle_no_valid_defense_node(var_0, var_1) {
  if(self.bot_defending_type == "protect_zone") {
    self.cur_defend_point_override = scripts\engine\utility::random(self.bot_defending_nodes).origin;
    return;
  }

  if(self.bot_defending_type == "capture_zone") {
    self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_from_set(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_nodes, &bot_can_use_point_in_defend);
  } else {
    self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_in_radius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, &bot_can_use_point_in_defend, 0.15, 0.9);
  }

  if(isDefined(var_0)) {
    var_2 = vectorNormalize(var_0 - self.cur_defend_point_override);
    self.cur_defend_angle_override = vectortoangles(var_2);
    return;
  }

  if(isDefined(var_1)) {
    var_2 = vectorNormalize(self.cur_defend_point_override - var_1);
    self.cur_defend_angle_override = vectortoangles(var_2);
    return;
  }
}

function bot_can_use_point_in_defend(var_0) {
  if(bot_check_team_is_using_position(var_0, 1, 1, 1)) {
    return false;
  }

  return true;
}

function bot_check_team_is_using_position(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];

    if(isDefined(var_5.team) && var_5.team == self.team && var_5 != self) {
      if(isai(var_5)) {
        if(var_2) {
          if(distancesquared(var_0, var_5.origin) < 441) {
            return true;
          }
        }

        if(var_3 && var_5 bothasscriptgoal()) {
          var_6 = var_5 botgetscriptgoal();

          if(distancesquared(var_0, var_6) < 441) {
            return true;
          }
        }

        continue;
      }

      if(var_1) {
        if(distancesquared(var_0, var_5.origin) < 441) {
          return true;
        }
      }
    }
  }

  return false;
}

function bot_capture_zone_get_furthest_distance() {
  var_0 = 0;

  if(isDefined(self.bot_defending_nodes)) {
    foreach(var_2 in self.bot_defending_nodes) {
      var_3 = distance(self.bot_defending_center, var_2.origin);
      var_0 = max(var_3, var_0);
    }
  }

  return var_0;
}

function bot_think_tactical_goals() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.tactical_goals = [];
  self.ref_13a16 = 0;

  for(;;) {
    if(self.tactical_goals.size > 0 && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      var_0 = self.tactical_goals[0];

      if(!isDefined(var_0.abort)) {
        self notify("start_tactical_goal");

        if(isDefined(var_0.start_thread)) {
          self[[var_0.start_thread]](var_0);
        }

        GscBinSkip4(0x35, var_0);
      }

      self.tactical_goals = scripts\engine\utility::array_remove(self.tactical_goals, var_0);
    }

    wait 0.05;
  }
}

function watch_goal_aborted(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;

  for(;;) {
    if(isDefined(var_0.abort) || isDefined(var_0.should_abort) && self[[var_0.should_abort]](var_0)) {
      self notify("stop_tactical_goal");
    }

    wait 0.05;
  }
}

function bot_new_tactical_goal(var_0, var_1, var_2, var_3) {
  if(lengthsquared(var_1) == 0) {
    var_1 += (0, 0, 1);
  }

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
  var_4.goal_yaw = var_3.script_goal_yaw;
  var_4.goal_radius = 0;

  if(isDefined(var_3.script_goal_radius)) {
    var_4.goal_radius = var_3.script_goal_radius;
  }

  var_4.start_thread = var_3.start_thread;
  var_4.end_thread = var_3.end_thread;
  var_4.should_abort = var_3.should_abort;
  var_4.action_thread = var_3.action_thread;
  var_4.objective_radius = var_3.objective_radius;
  var_4.ref_132b7 = var_3.ref_132b7;
  var_4.ref_12139 = var_3.ref_12139;
  var_4.hastargetmarker = var_3.hastargetmarker;

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

function bot_has_tactical_goal(var_0, var_1) {
  if(!isDefined(self.tactical_goals)) {
    return 0;
  }

  if(isDefined(var_0)) {
    foreach(var_3 in self.tactical_goals) {
      if(var_3.type == var_0) {
        if(isDefined(var_1) && isDefined(var_3.object)) {
          return (var_3.object == var_1);
        }

        return 1;
      }
    }

    return 0;
  }

  return self.tactical_goals.size > 0;
}

function damageshield_cooldown(var_0) {
  var_1 = [];

  if(isDefined(self.tactical_goals)) {
    foreach(var_3 in self.tactical_goals) {
      if(!istrue(var_3.abort) && var_3.type == var_0) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function bot_abort_tactical_goal(var_0, var_1) {
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

function bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "map_interactive_object";

  foreach(var_1 in self.tactical_goals) {
    if(var_1.type != "map_interactive_object") {
      var_1.abort = 1;
    }
  }
}

function bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

function bot_melee_tactical_insertion_check() {
  var_0 = gettime();

  if(!isDefined(self.last_melee_ti_check) || var_0 - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = var_0;
    var_1 = bot_get_ambush_trap_item("tacticalinsertion");

    if(!isDefined(var_1)) {
      return false;
    }

    if(isDefined(self.enemy) && self botcanseeentity(self.enemy)) {
      return false;
    }

    var_2 = getzonenearest(self.origin);

    if(!isDefined(var_2)) {
      return false;
    }

    var_3 = botzonenearestcount(var_2, self.team, 1, "enemy_predict", ">", 0);

    if(!isDefined(var_3)) {
      return false;
    }

    var_4 = getnodesinradius(self.origin, 500, 0);

    if(var_4.size <= 0) {
      return false;
    }

    var_5 = self botnodepick(var_4, var_4.size * 0.15, "node_hide");

    if(!isDefined(var_5)) {
      return false;
    }

    return bot_set_ambush_trap(var_1, undefined, undefined, undefined, var_5);
  }

  return false;
}