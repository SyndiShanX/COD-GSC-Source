/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_strategy.gsc
*******************************************/

bot_defend_get_random_entrance_point_for_current_area() {
  var_0 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isdefined(var_0) && var_0.size > 0)
    return common_scripts\utility::random(var_0).origin;

  return undefined;
}

bot_defend_get_precalc_entrances_for_current_area(var_0, var_1) {
  if(isdefined(self.defend_entrance_index))
    return maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index(var_0, self.defend_entrance_index, var_1);

  return [];
}

bot_get_ambush_trap_item(var_0, var_1, var_2) {
  if(self botgetdifficultysetting("allowGrenades") == 0)
    return undefined;

  var_3 = [];
  var_3[var_3.size] = var_0;

  if(isdefined(var_1))
    var_3[var_3.size] = var_1;

  if(isdefined(var_1))
    var_3[var_3.size] = var_2;

  if(var_3.size == 0)
    return undefined;

  var_4 = self getweaponslistitems();
  var_5 = [];

  foreach(var_7 in var_4) {
    if(self getweaponammoclip(var_7) > 0 || self getweaponammostock(var_7) > 0)
      var_5[var_5.size] = var_7;
  }

  if(var_5.size <= 0)
    return undefined;

  foreach(var_10 in var_3) {
    foreach(var_7 in var_5) {
      if(maps\mp\bots\_bots_util::bot_item_matches_purpose(var_10, var_7)) {
        var_12["purpose"] = var_10;

        if(isweaponmanuallydetonatedbyemptythrow(var_7) || isweaponmanuallydetonatedbydoubletap(var_7))
          var_12["item_action"] = "throw";
        else
          var_12["item_action"] = "attack";

        var_12["weap_name"] = var_7;
        return var_12;
      }
    }
  }
}

bot_set_ambush_trap(var_0, var_1, var_2, var_3, var_4) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isdefined(var_0))
    return 0;

  var_5 = undefined;

  if(!isdefined(var_4) && isdefined(var_1) && var_1.size > 0) {
    if(!isdefined(var_2))
      return 0;

    var_6 = [];
    var_7 = undefined;

    if(isdefined(var_3))
      var_7 = anglestoforward((0, var_3, 0));

    foreach(var_9 in var_1) {
      if(!isdefined(var_7)) {
        var_6[var_6.size] = var_9;
        continue;
      }

      if(distancesquared(var_9.origin, var_2.origin) > 90000) {
        if(vectordot(var_7, vectornormalize(var_9.origin - var_2.origin)) < 0.4)
          var_6[var_6.size] = var_9;
      }
    }

    if(var_6.size > 0) {
      var_5 = common_scripts\utility::random(var_6);
      var_11 = getnodesinradius(var_5.origin, 300, 50);
      var_12 = [];

      foreach(var_14 in var_11) {
        if(!isdefined(var_14.bot_ambush_end))
          var_12[var_12.size] = var_14;
      }

      var_11 = var_12;
      var_4 = self botnodepick(var_11, min(var_11.size, 3), "node_trap", var_2, var_5);
    }
  }

  if(isdefined(var_4)) {
    var_16 = undefined;

    if(var_0["purpose"] == "trap_directional" && isdefined(var_5)) {
      var_17 = vectortoangles(var_5.origin - var_4.origin);
      var_16 = var_17[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical")
      self botclearscriptgoal();

    var_18 = self botsetscriptgoalnode(var_4, "guard", var_16);

    if(var_18) {
      var_19 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

      if(var_19 == "goal") {
        thread maps\mp\bots\_bots_util::bot_force_stance_for_time("stand", 4.0);

        if(!isdefined(self.enemy) || !self botcanseeentity(self.enemy)) {
          thread maps\mp\bots\_bots_util::bot_disable_movement_for_time(4.0);
          var_20 = (0, 0, 0);

          if(var_0["weap_name"] == "h1_claymore_mp")
            var_20 = (0, 0, 55);

          if(isdefined(var_16))
            self botlookatpoint(var_5.origin + var_20, 3.0, "script_forced");
          else
            self botlookatpoint(self.origin + var_20 + anglestoforward(self getplayerangles()) * 50, 3.0, "script_forced");

          self switchtoweapon(var_0["weap_name"]);

          while (self getcurrentweapon() != var_0["weap_name"])
            wait 0.05;

          bot_try_use_ambush_item(var_0["item_action"]);
          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("grenade_fire");
          thread bot_set_ambush_trap_wait_fire("missile_fire");
          var_21 = common_scripts\utility::ter_op(var_0["purpose"] == "tacticalinsertion", 6.0, 3.0);
          common_scripts\utility::waittill_any_timeout(var_21, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");

          if(isdefined(self.ambush_trap_ent) && var_0["purpose"] == "c4")
            thread bot_watch_c4_detonate(self.ambush_trap_ent, 300);

          self.ambush_trap_ent = undefined;
          wait(randomfloat(0.25));
          self notify("bot_force_stance_for_time");
          self botsetstance("none");
          self switchtoweapon("none");
          self notify("bot_disable_movement_for_time");
          self botsetflag("disable_movement", 0);
          self botlookatpoint(undefined);
        }
      }

      return 1;
    }
  }

  return 0;
}

bot_try_use_ambush_item(var_0) {
  self endon("grenade_pullback");

  for (;;) {
    self botpressbutton(var_0);
    wait 0.5;
  }
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

bot_watch_c4_detonate(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_2 = var_1 * var_1;

  for (;;) {
    if(distancesquared(self.origin, var_0.origin) > var_2) {
      var_3 = self getclosestenemysqdist(var_0.origin, 1.0);

      if(var_3 < var_2) {
        self botpressbutton("use", 0.25);
        wait 0.5;
        self botpressbutton("use", 0.25);
        return;
      }
    }

    wait(randomfloatrange(0.25, 1.0));
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
  if(!isdefined(var_2) || !isdefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 12;

  if(!isdefined(var_2) || !isdefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 18;

  thread bot_defend_think(var_0, var_1, "protect", var_2);
}

bot_patrol_area(var_0, var_1, var_2) {
  if(!isdefined(var_2) || !isdefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 0.0;

  if(!isdefined(var_2) || !isdefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 0.01;

  thread bot_defend_think(var_0, var_1, "patrol", var_2);
}

bot_guard_player(var_0, var_1, var_2) {
  if(!isdefined(var_2) || !isdefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 15;

  if(!isdefined(var_2) || !isdefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 20;

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

  if(isdefined(self.bot_defending) || self botgetscriptgoaltype() == "camp")
    self botclearscriptgoal();

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

  if(maps\mp\_utility::isgameparticipant(var_0)) {
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
  self.defense_score_flags = [];

  if(isdefined(var_3)) {
    self.defend_entrance_index = var_3["entrance_points_index"];
    self.bot_defending_override_origin_node = var_3["override_origin_node"];

    if(isdefined(var_3["score_flags"])) {
      if(isarray(var_3["score_flags"]))
        self.defense_score_flags = var_3["score_flags"];
      else
        self.defense_score_flags[0] = var_3["score_flags"];
    }

    if(isdefined(var_3["override_goal_type"]))
      var_4 = var_3["override_goal_type"];

    if(isdefined(var_3["min_goal_time"]))
      var_5 = var_3["min_goal_time"];

    if(isdefined(var_3["max_goal_time"]))
      var_6 = var_3["max_goal_time"];

    if(isdefined(var_3["override_entrances"]) && var_3["override_entrances"].size > 0) {
      self.defense_override_entrances = var_3["override_entrances"];
      self.defend_entrance_index = self.name + " " + gettime();

      foreach(var_8 in self.defense_override_entrances) {
        var_8.prone_visible_from[self.defend_entrance_index] = maps\mp\bots\_bots_util::entrance_visible_from(var_8.origin, maps\mp\bots\_bots_util::defend_valid_center(), "prone");
        wait 0.05;
        var_8.crouch_visible_from[self.defend_entrance_index] = maps\mp\bots\_bots_util::entrance_visible_from(var_8.origin, maps\mp\bots\_bots_util::defend_valid_center(), "crouch");
        wait 0.05;
      }
    }

    self.defend_objective_radius = var_3["objective_radius"];
  }

  if(!isdefined(self.bot_defend_player_guarding)) {
    var_10 = undefined;

    if(isdefined(var_3) && isdefined(var_3["nearest_node_to_center"]))
      var_10 = var_3["nearest_node_to_center"];

    if(!isdefined(var_10) && isdefined(self.bot_defending_override_origin_node))
      var_10 = self.bot_defending_override_origin_node;

    if(!isdefined(var_10) && isdefined(self.bot_defending_trigger) && isdefined(self.bot_defending_trigger.nearest_node))
      var_10 = self.bot_defending_trigger.nearest_node;

    if(!isdefined(var_10))
      var_10 = getclosestnodeinsight(maps\mp\bots\_bots_util::defend_valid_center());

    if(!isdefined(var_10)) {
      var_11 = maps\mp\bots\_bots_util::defend_valid_center();
      var_12 = getnodesinradiussorted(var_11, 256, 0);

      for (var_13 = 0; var_13 < var_12.size; var_13++) {
        var_14 = vectornormalize(var_12[var_13].origin - var_11);
        var_15 = var_11 + var_14 * 15;

        if(sighttracepassed(var_15, var_12[var_13].origin, 0, undefined)) {
          var_10 = var_12[var_13];
          break;
        }

        wait 0.05;

        if(sighttracepassed(var_15 + (0, 0, 55), var_12[var_13].origin + (0, 0, 55), 0, undefined)) {
          var_10 = var_12[var_13];
          break;
        }

        wait 0.05;
      }
    }

    self.node_closest_to_defend_center = var_10;
  }

  var_16 = level.bot_find_defend_node_func[var_2];

  if(!isdefined(var_4)) {
    var_4 = "guard";

    if(var_2 == "capture" || var_2 == "capture_zone")
      var_4 = "objective";
  }

  var_17 = maps\mp\bots\_bots_util::bot_is_capturing();

  if(var_2 == "protect")
    childthread protect_watch_allies();

  for (;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    var_18 = isdefined(var_3["entrance_points_index"]) && isarray(var_3["entrance_points_index"]);
    self.cur_defend_stance = calculate_defend_stance(var_17, var_18);
    var_19 = self botgetscriptgoaltype();
    var_20 = maps\mp\bots\_bots_util::bot_goal_can_override(var_4, var_19);

    if(!var_20) {
      wait 0.25;
      continue;
    }

    var_21 = var_5;
    var_22 = var_6;
    var_23 = 1;

    if(isdefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      var_23 = 0;
      var_21 = 1.0;
      var_22 = 2.0;
    } else if(isdefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      if(isdefined(level.aerial_danger_exists_for) && level.aerial_danger_exists_for[self.team]) {
        if(!common_scripts\utility::array_contains(self.defense_score_flags, "avoid_aerial_enemies"))
          self.defense_score_flags[self.defense_score_flags.size] = "avoid_aerial_enemies";
      }

      self[[var_16]]();
    }

    self botclearscriptgoal();
    var_24 = "";

    if(isdefined(self.cur_defend_node) || isdefined(self.cur_defend_point_override)) {
      if(var_23 && maps\mp\bots\_bots_util::bot_is_protecting() && !isplayer(var_0) && isdefined(self.defend_entrance_index)) {
        var_25 = bot_get_ambush_trap_item("trap_directional", "trap", "c4");

        if(isdefined(var_25)) {
          var_26 = maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(var_25, var_26, self.node_closest_to_defend_center);
        }
      }

      if(isdefined(self.cur_defend_point_override)) {
        var_27 = undefined;

        if(isdefined(self.cur_defend_angle_override))
          var_27 = self.cur_defend_angle_override[1];

        self botsetscriptgoal(self.cur_defend_point_override, 0, var_4, var_27, self.defend_objective_radius);
      } else if(!isdefined(self.cur_defend_angle_override))
        self botsetscriptgoalnode(self.cur_defend_node, var_4, undefined, self.defend_objective_radius);
      else
        self botsetscriptgoalnode(self.cur_defend_node, var_4, self.cur_defend_angle_override[1], self.defend_objective_radius);

      if(var_17) {
        if(!isdefined(self.prev_defend_node) || !isdefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node)
          self botsetstance("none");
      }

      var_28 = self botgetscriptgoal();
      self notify("new_defend_goal");
      maps\mp\bots\_bots_util::watch_nodes_stop();

      if(var_4 == "objective") {
        defense_cautious_approach();
        self botsetawareness(1.0);
        self botsetflag("cautious", 0);
      }

      if(self bothasscriptgoal()) {
        var_29 = self botgetscriptgoal();

        if(maps\mp\bots\_bots_util::bot_vectors_are_equal(var_29, var_28))
          var_24 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
      }

      if(var_24 == "goal") {
        if(var_17)
          self botsetstance(self.cur_defend_stance);

        childthread defense_watch_entrances_at_goal();
      }
    }

    if(var_24 != "goal") {
      wait 0.25;
      continue;
    }

    var_30 = randomfloatrange(var_21, var_22);
    var_24 = common_scripts\utility::waittill_any_timeout(var_30, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((var_24 == "node_relinquished" || var_24 == "bad_path" || var_24 == "goal_changed" || var_24 == "script_goal_changed") && (self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone"))
      self botsetstance("none");
  }
}

calculate_defend_stance(var_0, var_1) {
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

    if(var_7 < var_4)
      var_2 = "crouch";
    else if(var_7 < var_4 + var_5)
      var_2 = "prone";

    var_8 = !isdefined(var_1) || !var_1;

    if(var_8 && var_2 == "prone") {
      var_9 = bot_defend_get_precalc_entrances_for_current_area("prone");
      var_10 = defend_get_ally_bots_at_zone_for_stance("prone");

      if(var_10.size >= var_9.size)
        var_2 = "crouch";
    }

    if(var_8 && var_2 == "crouch") {
      var_11 = bot_defend_get_precalc_entrances_for_current_area("crouch");
      var_12 = defend_get_ally_bots_at_zone_for_stance("crouch");

      if(var_12.size >= var_11.size)
        var_2 = "stand";
    }
  }

  return var_2;
}

should_start_cautious_approach_default(var_0) {
  var_1 = 1250;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(self botgetdifficultysetting("strategyLevel") == 0)
      return 0;

    if(self.bot_defending_type == "capture_zone" && self istouching(self.bot_defending_trigger))
      return 0;

    return distancesquared(self.origin, self.bot_defending_center) > var_2 * 0.75 * 0.75;
  } else if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < var_2) {
    var_3 = self botgetpathdist();
    return 0 <= var_3 && var_3 <= var_1;
  } else
    return 0;
}

setup_investigate_location(var_0, var_1) {
  var_2 = spawnstruct();

  if(isdefined(var_1))
    var_2.origin = var_1;
  else
    var_2.origin = var_0.origin;

  var_2.node = var_0;
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

  if(![
      [level.bot_funcs["should_start_cautious_approach"]]
    ](1)) {
    return;
  }
  var_0 = self botgetscriptgoal();
  var_1 = self botgetscriptgoalnode();
  var_2 = 1;
  var_3 = 0.2;

  while (var_2) {
    wait 0.25;

    if(!self bothasscriptgoal()) {
      return;
    }
    var_4 = self botgetscriptgoal();

    if(!maps\mp\bots\_bots_util::bot_vectors_are_equal(var_0, var_4)) {
      return;
    }
    var_3 = var_3 + 0.25;

    if(var_3 >= 0.5) {
      var_3 = 0.0;

      if([
          [level.bot_funcs["should_start_cautious_approach"]]
        ](0))
        var_2 = 0;
    }
  }

  self botsetawareness(1.8);
  self botsetflag("cautious", 1);
  var_5 = self botgetnodesonpath();

  if(!isdefined(var_5) || var_5.size <= 2) {
    return;
  }
  self.locations_to_investigate = [];
  var_6 = 1000;

  if(isdefined(level.protect_radius))
    var_6 = level.protect_radius;

  var_7 = var_6 * var_6;
  var_8 = getnodesinradius(self.bot_defending_center, var_6, 0, 500);

  if(var_8.size <= 0) {
    return;
  }
  var_9 = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  var_10 = int(min(var_9, var_8.size));
  var_11 = self botnodepickmultiple(var_8, 15, var_10, "node_protect", maps\mp\bots\_bots_util::defend_valid_center(), "ignore_occupancy");

  for (var_12 = 0; var_12 < var_11.size; var_12++) {
    var_13 = setup_investigate_location(var_11[var_12]);
    self.locations_to_investigate = common_scripts\utility::array_add(self.locations_to_investigate, var_13);
  }

  var_14 = botgetmemoryevents(0, gettime() - 60000, 1, "death", 0, self);

  foreach(var_16 in var_14) {
    if(distancesquared(var_16, self.bot_defending_center) < var_7) {
      var_17 = getclosestnodeinsight(var_16);

      if(isdefined(var_17)) {
        var_13 = setup_investigate_location(var_17, var_16);
        self.locations_to_investigate = common_scripts\utility::array_add(self.locations_to_investigate, var_13);
      }
    }
  }

  if(isdefined(self.defend_entrance_index)) {
    var_19 = maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index("stand", self.defend_entrance_index);

    for (var_12 = 0; var_12 < var_19.size; var_12++) {
      var_13 = setup_investigate_location(var_19[var_12]);
      self.locations_to_investigate = common_scripts\utility::array_add(self.locations_to_investigate, var_13);
    }
  }

  if(self.locations_to_investigate.size == 0) {
    return;
  }
  childthread monitor_cautious_approach_dangerous_locations();
  var_20 = self botgetscriptgoaltype();
  var_21 = self botgetscriptgoalradius();
  var_22 = self botgetscriptgoalyaw();
  wait 0.05;

  for (var_23 = 1; var_23 < var_5.size - 2; var_23++) {
    maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time();
    var_24 = getlinkednodes(var_5[var_23]);

    if(var_24.size == 0) {
      continue;
    }
    var_25 = [];

    for (var_12 = 0; var_12 < var_24.size; var_12++) {
      if(!common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_24[var_12].origin, 0)) {
        continue;
      }
      for (var_26 = 0; var_26 < self.locations_to_investigate.size; var_26++) {
        var_16 = self.locations_to_investigate[var_26];

        if(nodesvisible(var_16.node, var_24[var_12], 1)) {
          var_25 = common_scripts\utility::array_add(var_25, var_24[var_12]);
          var_26 = self.locations_to_investigate.size;
        }
      }
    }

    if(var_25.size == 0) {
      continue;
    }
    var_27 = self botnodepick(var_25, 1 + var_25.size * 0.15, "node_hide");

    if(isdefined(var_27)) {
      var_28 = [];

      for (var_12 = 0; var_12 < self.locations_to_investigate.size; var_12++) {
        if(nodesvisible(self.locations_to_investigate[var_12].node, var_27, 1)) {
          if(distance2dsquared(self.locations_to_investigate[var_12].origin, var_27.origin) > 3600)
            var_28 = common_scripts\utility::array_add(var_28, self.locations_to_investigate[var_12]);
        }
      }

      self botclearscriptgoal();
      self botsetscriptgoalnode(var_27, "critical");
      childthread monitor_cautious_approach_early_out();
      var_29 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");

      if(var_29 == "cautious_approach_early_out") {
        break;
      }

      if(var_29 == "goal") {
        for (var_12 = 0; var_12 < var_28.size; var_12++) {
          if(distance2dsquared(self.origin, var_28[var_12].origin) < 1600) {
            continue;
          }
          for (var_30 = 0; var_28[var_12].frames_visible < 18 && var_30 < 3.6; var_30 = var_30 + 0.25) {
            self botlookatpoint(var_28[var_12].origin + (0, 0, self getplayerviewheight()), 0.25, "script_search");
            wait 0.25;
          }
        }
      }
    }

    wait 0.05;
  }

  self notify("stop_location_monitoring");
  self botclearscriptgoal();

  if(isdefined(var_1))
    self botsetscriptgoalnode(var_1, var_20, var_22);
  else
    self botsetscriptgoal(self.cur_defend_point_override, var_21, var_20, var_22);
}

monitor_cautious_approach_early_out() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_0 = undefined;

  if(isdefined(self.bot_defending_radius))
    var_0 = self.bot_defending_radius * self.bot_defending_radius;
  else if(isdefined(self.bot_defending_nodes)) {
    var_1 = bot_capture_zone_get_furthest_distance();
    var_0 = var_1 * var_1;
  }

  wait 0.05;

  for (;;) {
    if(distancesquared(self.origin, self.bot_defending_center) < var_0)
      self notify("cautious_approach_early_out");

    wait 0.05;
  }
}

monitor_cautious_approach_dangerous_locations() {
  self endon("stop_location_monitoring");
  var_0 = 10000;

  for (;;) {
    var_1 = self getnearestnode();

    if(isdefined(var_1)) {
      var_2 = self botgetfovdot();

      for (var_3 = 0; var_3 < self.locations_to_investigate.size; var_3++) {
        if(nodesvisible(var_1, self.locations_to_investigate[var_3].node, 1)) {
          var_4 = common_scripts\utility::within_fov(self.origin, self getplayerangles(), self.locations_to_investigate[var_3].origin, var_2);
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

protect_watch_allies() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_0 = [];
  var_1 = 1050;
  var_2 = var_1 * var_1;
  var_3 = 900;

  if(isdefined(level.protect_radius))
    var_3 = level.protect_radius;

  for (;;) {
    var_4 = gettime();
    var_5 = bot_get_teammates_in_radius(self.bot_defending_center, var_3);

    foreach(var_7 in var_5) {
      var_8 = var_7.entity_number;

      if(!isdefined(var_8))
        var_8 = var_7 getentitynumber();

      if(!isdefined(var_0[var_8]))
        var_0[var_8] = var_4 - 1;

      if(!isdefined(var_7.last_investigation_time))
        var_7.last_investigation_time = var_4 - 10001;

      if(var_7.health == 0 && isdefined(var_7.deathtime) && var_4 - var_7.deathtime < 5000) {
        if(var_4 - var_7.last_investigation_time > 10000 && var_4 > var_0[var_8]) {
          if(isdefined(var_7.lastattacker) && isdefined(var_7.lastattacker.team) && var_7.lastattacker.team == common_scripts\utility::get_enemy_team(self.team)) {
            if(distancesquared(var_7.body.origin, self.origin) < var_2) {
              self botgetimperfectenemyinfo(var_7.lastattacker, var_7.body.origin);
              var_9 = getclosestnodeinsight(var_7.body.origin);

              if(isdefined(var_9)) {
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

    wait((randomint(5) + 1) * 0.05);
  }
}

defense_get_initial_entrances() {
  if(isdefined(self.defense_override_entrances))
    return self.defense_override_entrances;
  else if(maps\mp\bots\_bots_util::bot_is_capturing())
    return bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance, 1);
  else if(maps\mp\bots\_bots_util::bot_is_protecting() || maps\mp\bots\_bots_util::bot_is_bodyguarding()) {
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

  if(maps\mp\bots\_bots_util::bot_is_capturing()) {
    var_2 = defense_get_initial_entrances();
    var_1 = [];

    if(isdefined(var_0)) {
      foreach(var_4 in var_2) {
        if(nodesvisible(var_0, var_4, 1))
          var_1 = common_scripts\utility::array_add(var_1, var_4);
      }
    }

    if(var_1.size == 0)
      var_1 = findentrances(self.origin);
  } else if(maps\mp\bots\_bots_util::bot_is_protecting() || maps\mp\bots\_bots_util::bot_is_bodyguarding()) {
    var_1 = defense_get_initial_entrances();

    if(isdefined(var_0) && !issubstr(self getcurrentweapon(), "riotshield")) {
      if(nodesvisible(var_0, self.node_closest_to_defend_center, 1))
        var_1 = common_scripts\utility::array_add(var_1, self.node_closest_to_defend_center);
    }
  }

  if(isdefined(var_1)) {
    childthread maps\mp\bots\_bots_util::bot_watch_nodes(var_1);

    if(maps\mp\bots\_bots_util::bot_is_bodyguarding())
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

  while (!isdefined(self.watch_nodes))
    wait 0.05;

  var_0 = level.bot_funcs["get_watch_node_chance"];

  for (;;) {
    var_1 = 0.8;
    var_2 = 1.0;

    if(common_scripts\utility::array_contains(self.defense_score_flags, "strict_los")) {
      var_1 = 1.0;
      var_2 = 0.5;
    }

    foreach(var_4 in self.watch_nodes) {
      if(var_4 == self.node_closest_to_defend_center) {
        var_4.watch_node_chance[self.entity_number] = var_1;
        continue;
      }

      var_4.watch_node_chance[self.entity_number] = var_2;
    }

    var_6 = isdefined(var_0);

    if(!var_6)
      prioritize_watch_nodes_toward_enemies(0.5);

    foreach(var_4 in self.watch_nodes) {
      if(var_6) {
        var_8 = self[[var_0]](var_4);
        var_4.watch_node_chance[self.entity_number] = var_4.watch_node_chance[self.entity_number] * var_8;
      }

      if(entrance_watched_by_ally(var_4))
        var_4.watch_node_chance[self.entity_number] = var_4.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_monitor_watch_entrances_bodyguard() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");

  while (!isdefined(self.watch_nodes))
    wait 0.05;

  for (;;) {
    var_0 = anglestoforward(self.bot_defend_player_guarding getplayerangles()) * (1, 1, 0);
    var_0 = vectornormalize(var_0);

    foreach(var_2 in self.watch_nodes) {
      var_2.watch_node_chance[self.entity_number] = 1.0;
      var_3 = var_2.origin - self.bot_defend_player_guarding.origin;
      var_3 = vectornormalize(var_3);
      var_4 = vectordot(var_0, var_3);

      if(var_4 > 0.6)
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.33;
      else if(var_4 > 0)
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.66;

      if(!entrance_to_enemy_zone(var_2))
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

entrance_to_enemy_zone(var_0) {
  var_1 = getnodezone(var_0);
  var_2 = vectornormalize(var_0.origin - self.origin);

  for (var_3 = 0; var_3 < level.zonecount; var_3++) {
    if(botzonegetcount(var_3, self.team, "enemy_predict") > 0) {
      if(isdefined(var_1) && var_3 == var_1)
        return 1;
      else {
        var_4 = vectornormalize(getzoneorigin(var_3) - self.origin);
        var_5 = vectordot(var_2, var_4);

        if(var_5 > 0.2)
          return 1;
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

  for (var_2 = 0; var_2 < level.zonecount; var_2++) {
    if(botzonegetcount(var_2, self.team, "enemy_predict") <= 0) {
      continue;
    }
    if(var_1.size == 0) {
      break;
    }

    var_3 = vectornormalize(getzoneorigin(var_2) - self.origin);

    for (var_4 = 0; var_4 < var_1.size; var_4++) {
      var_5 = getnodezone(var_1[var_4]);
      var_6 = 0;

      if(isdefined(var_5) && var_2 == var_5)
        var_6 = 1;
      else {
        var_7 = vectornormalize(var_1[var_4].origin - self.origin);
        var_8 = vectordot(var_7, var_3);

        if(var_8 > 0.2)
          var_6 = 1;
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
    if(entrance_watched_by_player(var_3, var_0))
      return 1;
  }

  return 0;
}

entrance_watched_by_player(var_0, var_1) {
  var_2 = anglestoforward(var_0 getplayerangles());
  var_3 = vectornormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.6)
    return 1;

  return 0;
}

bot_get_teammates_currently_defending_point(var_0, var_1) {
  if(!isdefined(var_1)) {
    if(isdefined(level.protect_radius))
      var_1 = level.protect_radius;
    else
      var_1 = 900;
  }

  var_2 = [];
  var_3 = bot_get_teammates_in_radius(var_0, var_1);

  foreach(var_5 in var_3) {
    if(!isai(var_5) || var_5 maps\mp\bots\_bots_util::bot_is_defending_point(var_0))
      var_2 = common_scripts\utility::array_add(var_2, var_5);
  }

  return var_2;
}

bot_get_teammates_in_radius(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = [];

  for (var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];

    if(var_5 != self && isdefined(var_5.team) && var_5.team == self.team && maps\mp\_utility::isteamparticipant(var_5)) {
      if(distancesquared(var_0, var_5.origin) < var_2)
        var_3 = common_scripts\utility::array_add(var_3, var_5);
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

  if(isdefined(self))
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
  self.defend_objective_radius = undefined;
  self.prev_defend_node = undefined;
  self.cur_defend_node = undefined;
  self.cur_defend_angle_override = undefined;
  self.cur_defend_point_override = undefined;
  self.defend_entrance_index = undefined;
  self.defense_override_entrances = undefined;
  self botclearscriptgoal();
  self botsetstance("none");
}

defend_get_ally_bots_at_zone_for_stance(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(!isdefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_3 != self && isai(var_3) && var_3 maps\mp\bots\_bots_util::bot_is_defending() && var_3.cur_defend_stance == var_0) {
      if(var_3.bot_defending_type == self.bot_defending_type && maps\mp\bots\_bots_util::bot_is_defending_point(var_3.bot_defending_center))
        var_1 = common_scripts\utility::array_add(var_1, var_3);
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

  for (;;) {
    if(!isdefined(self.bot_defend_player_guarding))
      thread bot_defend_stop();

    self.bot_defending_center = self.bot_defend_player_guarding.origin;
    self.node_closest_to_defend_center = self.bot_defend_player_guarding getnearestnode();

    if(!isdefined(self.node_closest_to_defend_center))
      self.node_closest_to_defend_center = self getnearestnode();

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
            wait 0.25;
          }
        }
      } else {
        var_0 = var_0 + 0.05;

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

find_defend_node_capture() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = maps\mp\bots\_bots_util::bot_find_node_to_capture_point(maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, var_0);

  if(isdefined(var_1)) {
    if(isdefined(var_0)) {
      var_2 = vectornormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectornormalize(var_1.origin - maps\mp\bots\_bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
  } else if(isdefined(var_0))
    bot_handle_no_valid_defense_node(var_0, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, maps\mp\bots\_bots_util::defend_valid_center());
}

find_defend_node_capture_zone() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = maps\mp\bots\_bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes, var_0);

  if(isdefined(var_1)) {
    if(isdefined(var_0)) {
      var_2 = vectornormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectornormalize(var_1.origin - maps\mp\bots\_bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
  } else if(isdefined(var_0))
    bot_handle_no_valid_defense_node(var_0, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, maps\mp\bots\_bots_util::defend_valid_center());
}

find_defend_node_protect() {
  var_0 = maps\mp\bots\_bots_util::bot_find_node_that_protects_point(maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isdefined(var_0)) {
    var_1 = vectornormalize(maps\mp\bots\_bots_util::defend_valid_center() - var_0.origin);
    self.cur_defend_angle_override = vectortoangles(var_1);
    self.cur_defend_node = var_0;
  } else
    bot_handle_no_valid_defense_node(maps\mp\bots\_bots_util::defend_valid_center(), undefined);
}

find_defend_node_bodyguard() {
  var_0 = maps\mp\bots\_bots_util::bot_find_node_to_guard_player(maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isdefined(var_0))
    self.cur_defend_node = var_0;
  else {
    var_1 = self getnearestnode();

    if(isdefined(var_1))
      self.cur_defend_node = var_1;
    else
      self.cur_defend_point_override = self.origin;
  }
}

find_defend_node_patrol() {
  var_0 = undefined;
  var_1 = getnodesinradius(maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, 0);

  if(isdefined(var_1) && var_1.size > 0)
    var_0 = self botnodepick(var_1, 1 + var_1.size * 0.5, "node_traffic");

  if(isdefined(var_0))
    self.cur_defend_node = var_0;
  else
    bot_handle_no_valid_defense_node(undefined, maps\mp\bots\_bots_util::defend_valid_center());
}

bot_handle_no_valid_defense_node(var_0, var_1) {
  if(self.bot_defending_type == "capture_zone")
    self.cur_defend_point_override = maps\mp\bots\_bots_util::bot_pick_random_point_from_set(maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_nodes, ::bot_can_use_point_in_defend);
  else
    self.cur_defend_point_override = maps\mp\bots\_bots_util::bot_pick_random_point_in_radius(maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, ::bot_can_use_point_in_defend, 0.15, 0.9);

  if(isdefined(var_0)) {
    var_2 = vectornormalize(var_0 - self.cur_defend_point_override);
    self.cur_defend_angle_override = vectortoangles(var_2);
  } else if(isdefined(var_1)) {
    var_2 = vectornormalize(self.cur_defend_point_override - var_1);
    self.cur_defend_angle_override = vectortoangles(var_2);
  }
}

bot_can_use_point_in_defend(var_0) {
  if(bot_check_team_is_using_position(var_0, 1, 1, 1))
    return 0;

  return 1;
}

bot_check_team_is_using_position(var_0, var_1, var_2, var_3) {
  for (var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];

    if(var_5.team == self.team && var_5 != self) {
      if(isai(var_5)) {
        if(var_2) {
          if(distancesquared(var_0, var_5.origin) < 441)
            return 1;
        }

        if(var_3 && var_5 bothasscriptgoal()) {
          var_6 = var_5 botgetscriptgoal();

          if(distancesquared(var_0, var_6) < 441)
            return 1;
        }

        continue;
      }

      if(var_1) {
        if(distancesquared(var_0, var_5.origin) < 441)
          return 1;
      }
    }
  }

  return 0;
}

bot_capture_zone_get_furthest_distance() {
  var_0 = 0;

  if(isdefined(self.bot_defending_nodes)) {
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
  self.tactical_goal_in_action_thread = 0;

  for (;;) {
    if(self.tactical_goals.size > 0 && !maps\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      var_0 = self.tactical_goals[0];

      if(!isdefined(var_0.abort)) {
        self notify("start_tactical_goal");

        if(isdefined(var_0.start_thread))
          self[[var_0.start_thread]](var_0);

        childthread watch_goal_aborted(var_0);
        var_1 = "tactical";

        if(isdefined(var_0.goal_type))
          var_1 = var_0.goal_type;

        if(maps\mp\_utility::is_true(var_0.clear_prev_goal))
          self botclearscriptgoal();

        self botsetscriptgoal(var_0.goal_position, var_0.goal_radius, var_1, var_0.goal_yaw, var_0.objective_radius, var_0.short_term_goal);
        var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");

        if(var_2 == "goal") {
          if(isdefined(var_0.action_thread)) {
            self.tactical_goal_in_action_thread = 1;
            self[[var_0.action_thread]](var_0);
            self.tactical_goal_in_action_thread = 0;
          }
        }

        if(var_2 != "script_goal_changed")
          self botclearscriptgoal();

        if(isdefined(var_0.end_thread))
          self[[var_0.end_thread]](var_0);
      }

      self.tactical_goals = common_scripts\utility::array_remove(self.tactical_goals, var_0);
    }

    wait 0.05;
  }
}

watch_goal_aborted(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;

  for (;;) {
    if(isdefined(var_0.abort) || isdefined(var_0.should_abort) && self[[var_0.should_abort]](var_0))
      self notify("stop_tactical_goal");

    wait 0.05;
  }
}

bot_new_tactical_goal(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4.type = var_0;
  var_4.goal_position = var_1;

  if(isdefined(self.only_allowable_tactical_goals)) {
    if(!common_scripts\utility::array_contains(self.only_allowable_tactical_goals, var_0))
      return;
  }

  var_4.priority = var_2;
  var_4.object = var_3.object;
  var_4.goal_type = var_3.script_goal_type;
  var_4.goal_yaw = var_3.script_goal_yaw;
  var_4.goal_radius = 0;

  if(isdefined(var_3.script_goal_radius))
    var_4.goal_radius = var_3.script_goal_radius;

  var_4.start_thread = var_3.start_thread;
  var_4.end_thread = var_3.end_thread;
  var_4.should_abort = var_3.should_abort;
  var_4.action_thread = var_3.action_thread;
  var_4.objective_radius = var_3.objective_radius;
  var_4.short_term_goal = var_3.short_term_goal;
  var_4.optional_params = var_3.optional_params;
  var_4.clear_prev_goal = var_3.clear_prev_goal;

  for (var_5 = 0; var_5 < self.tactical_goals.size; var_5++) {
    if(var_4.priority > self.tactical_goals[var_5].priority) {
      break;
    }
  }

  for (var_6 = self.tactical_goals.size - 1; var_6 >= var_5; var_6--)
    self.tactical_goals[var_6 + 1] = self.tactical_goals[var_6];

  self.tactical_goals[var_5] = var_4;
}

bot_has_tactical_goal(var_0, var_1) {
  if(!isdefined(self.tactical_goals))
    return 0;

  if(isdefined(var_0)) {
    foreach(var_3 in self.tactical_goals) {
      if(var_3.type == var_0) {
        if(isdefined(var_1) && isdefined(var_3.object))
          return var_3.object == var_1;
        else
          return 1;
      }
    }

    return 0;
  } else
    return self.tactical_goals.size > 0;
}

bot_get_active_tactical_goals_of_type(var_0) {
  var_1 = [];

  if(isdefined(self.tactical_goals)) {
    foreach(var_3 in self.tactical_goals) {
      if(!maps\mp\_utility::is_true(var_3.abort) && var_3.type == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

bot_abort_tactical_goal(var_0, var_1) {
  if(!isdefined(self.tactical_goals)) {
    return;
  }
  foreach(var_3 in self.tactical_goals) {
    if(var_3.type == var_0) {
      if(isdefined(var_1)) {
        if(isdefined(var_3.object) && var_3.object == var_1)
          var_3.abort = 1;

        continue;
      }

      var_3.abort = 1;
    }
  }
}

bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "map_interactive_object";

  foreach(var_1 in self.tactical_goals) {
    if(var_1.type != "map_interactive_object")
      var_1.abort = 1;
  }
}

bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

bot_melee_tactical_insertion_check() {
  var_0 = gettime();

  if(!isdefined(self.last_melee_ti_check) || var_0 - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = var_0;
    var_1 = bot_get_ambush_trap_item("tacticalinsertion");

    if(!isdefined(var_1))
      return 0;

    if(isdefined(self.enemy) && self botcanseeentity(self.enemy))
      return 0;

    var_2 = getzonenearest(self.origin);

    if(!isdefined(var_2))
      return 0;

    var_3 = botzonenearestcount(var_2, self.team, 1, "enemy_predict", ">", 0);

    if(!isdefined(var_3))
      return 0;

    var_4 = getnodesinradius(self.origin, 500, 0);

    if(var_4.size <= 0)
      return 0;

    var_5 = self botnodepick(var_4, var_4.size * 0.15, "node_hide");

    if(!isdefined(var_5))
      return 0;

    return bot_set_ambush_trap(var_1, undefined, undefined, undefined, var_5);
  }

  return 0;
}