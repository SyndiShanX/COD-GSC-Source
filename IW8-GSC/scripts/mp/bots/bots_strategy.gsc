/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_strategy.gsc
***********************************************/

function bot_defend_get_random_entrance_point_for_current_area() {
  var0 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isDefined(var0) && var0.size > 0) {
    return scripts\engine\utility::random(var0).origin;
  }

  return undefined;
}

function bot_defend_get_precalc_entrances_for_current_area(var0, var1) {
  if(isDefined(self.defend_entrance_index)) {
    return scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(var0, self.defend_entrance_index, var1);
  }

  return [];
}

function bot_get_ambush_trap_item(var0, var1, var2) {
  if(self botgetdifficultysetting("allowGrenades") == 0) {
    return undefined;
  }

  var3 = [];
  GscBinSkip0(0x2e, var3.size, var0);
}

function bot_set_ambush_trap(var0, var1, var2, var3, var4) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(var0)) {
    return false;
  }

  var5 = undefined;

  if(!isDefined(var4) && isDefined(var1) && var1.size > 0) {
    if(!isDefined(var2)) {
      return false;
    }

    var6 = [];
    var7 = undefined;

    if(isDefined(var3)) {
      var7 = anglesToForward((0, var3, 0));
    }

    foreach(var9 in var1) {
      if(!isDefined(var7)) {
        var6 = var9;
        continue;
      }

      if(distancesquared(var9.origin, var2.origin) > 90000) {
        if(vectordot(var7, vectorNormalize(var9.origin - var2.origin)) < 0.4) {
          var6 = var9;
        }
      }
    }

    if(var6.size > 0) {
      var5 = scripts\engine\utility::random(var6);
      var11 = getnodesinradius(var5.origin, 300, 50);
      var12 = [];

      foreach(var14 in var11) {
        if(!isDefined(var14.bot_ambush_end)) {
          var12 = var14;
        }
      }

      var11 = var12;
      var4 = self botnodepick(var11, min(var11.size, 3), "node_trap", var2, var5);
    }
  }

  if(isDefined(var4)) {
    var16 = undefined;

    if(var0["purpose"] == "trap_directional" && isDefined(var5)) {
      var17 = vectortoangles(var5.origin - var4.origin);
      var16 = var17[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical") {
      self botclearscriptgoal();
    }

    var18 = self botsetscriptgoalnode(var4, "guard", var16);

    if(var18) {
      var19 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var19 == "goal") {
        thread scripts\mp\bots\bots_util::bot_force_stance_for_time("stand", 4);

        if(!isDefined(self.enemy) || !self botcanseeentity(self.enemy)) {
          thread scripts\mp\bots\bots_util::damage_func(4);
          var20 = (0, 0, 0);

          if(issubstr(var0["weap_name"].basename, "claymore")) {
            var20 = (0, 0, 55);
          }

          if(isDefined(var16)) {
            self botlookatpoint(var5.origin + var20, 3, "script_forced");
          } else {
            self botlookatpoint(self.origin + var20 + anglesToForward(self getplayerangles()) * 50, 3, "script_forced");
          }

          if(!isDefined(var0["item_action"])) {
            var0 = bot_get_ambush_trap_item("trap_directional", "trap");
          }

          if(isDefined(var0["item_action"])) {
            debug_chopper_boss(var0["item_action"]);
          }

          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("grenade_fire");
          thread bot_set_ambush_trap_wait_fire("missile_fire");
          var21 = scripts\engine\utility::ter_op(isDefined(var0["purpose"]) && var0["purpose"] == "tacticalinsertion", 6, 3);
          scripts\engine\utility::ref_143ba(var21, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");

          if(isDefined(self.ambush_trap_ent) && isDefined(var0["purpose"]) && var0["purpose"] == "c4") {
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

function debug_chopper_boss(var0) {
  self endon("grenade_pullback");

  for(;;) {
    self botpressbutton(var0);
    wait 0.5;
  }
}

function bot_set_ambush_trap_wait_fire(var0) {
  self endon("death_or_disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(var0, var1);
  self.ambush_trap_ent = var1;
}

function bot_watch_manual_detonate(var0, var1) {
  self endon("death_or_disconnect");
  var0 endon("death");
  level endon("game_ended");
  var2 = var1 * var1;

  for(;;) {
    if(distancesquared(self.origin, var0.origin) > var2) {
      var3 = self getclosestenemysqdist(var0.origin, 1);

      if(var3 < var2) {
        self botpressbutton("use", 0.25);
        wait 0.5;
        self botpressbutton("use", 0.25);
        return;
      }
    }

    wait randomfloatrange(0.25, 1);
  }
}

function bot_capture_point(var0, var1, var2) {
  thread bot_defend_think(var0, var1, "capture", var2);
}

function bot_capture_zone(var0, var1, var2, var3) {
  GscBinSkip0(0x2e, "capture_trigger", var2);
}

function bot_protect_point(var0, var1, var2) {
  if(!isDefined(var2) || !isDefined(var2["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 12);
  }

  if(!isDefined(var2) || !isDefined(var2["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 18);
  }

  thread bot_defend_think(var0, var1, "protect", var2);
}

function bot_protect_zone(var0, var1, var2, var3) {
  if(!isDefined(var3) || !isDefined(var3["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 12);
  }

  if(!isDefined(var3) || !isDefined(var3["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 18);
  }

  if(!isDefined(var3) || !isDefined(var3["random_stance"])) {
    GscBinSkip0(0x2e, "random_stance", 1);
  }

  GscBinSkip0(0x2e, "uniqueID", var2);
}

function bot_patrol_area(var0, var1, var2) {
  if(!isDefined(var2) || !isDefined(var2["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 0);
  }

  if(!isDefined(var2) || !isDefined(var2["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 0.01);
  }

  thread bot_defend_think(var0, var1, "patrol", var2);
}

function bot_guard_player(var0, var1, var2) {
  if(!isDefined(var2) || !isDefined(var2["min_goal_time"])) {
    GscBinSkip0(0x2e, "min_goal_time", 15);
  }

  if(!isDefined(var2) || !isDefined(var2["max_goal_time"])) {
    GscBinSkip0(0x2e, "max_goal_time", 20);
  }

  thread bot_defend_think(var0, var1, "bodyguard", var2);
}

function bot_defend_requires_center(var0) {
  if(var0 == "protect_zone") {
    return false;
  }

  return true;
}

function bot_defend_think(var0, var1, var2, var3) {
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
  self.bot_defending_type = var2;

  if(var2 == "capture_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = var1;
    self.bot_defending_trigger = var3["capture_trigger"];
  } else if(var2 == "protect_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = var1;
    self.bot_defending_zone_id = var3["uniqueID"];
  } else {
    self.bot_defending_radius = var1;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(scripts\mp\utility\entity::isgameparticipant(var0)) {
    self.bot_defend_player_guarding = var0;
    GscBinSkip4(0x35);
  }

  self.bot_defend_player_guarding = undefined;
  self.bot_defending_center = var0;
  self botsetstance("none");
  var4 = undefined;
  var5 = 6;
  var6 = 10;
  self.defense_score_flags = [];

  if(isDefined(var3)) {
    self.defend_entrance_index = var3["entrance_points_index"];
    self.bot_defending_override_origin_node = var3["override_origin_node"];

    if(isDefined(var3["score_flags"])) {
      if(isarray(var3["score_flags"])) {
        self.defense_score_flags = var3["score_flags"];
      } else {
        self.defense_score_flags[0] = var3["score_flags"];
      }
    }

    if(isDefined(var3["override_goal_type"])) {
      var4 = var3["override_goal_type"];
    }

    if(isDefined(var3["min_goal_time"])) {
      var5 = var3["min_goal_time"];
    }

    if(isDefined(var3["max_goal_time"])) {
      var6 = var3["max_goal_time"];
    }

    if(isDefined(var3["override_watch_nodes"]) && var3["override_watch_nodes"].size > 0) {
      self.defense_override_watch_nodes = var3["override_watch_nodes"];
    }

    self.defend_objective_radius = var3["objective_radius"];
  }

  if(!isDefined(self.bot_defend_player_guarding) && bot_defend_requires_center(var2)) {
    var7 = undefined;

    if(isDefined(var3) && isDefined(var3["nearest_node_to_center"])) {
      var7 = var3["nearest_node_to_center"];
    }

    if(!isDefined(var7) && isDefined(self.bot_defending_override_origin_node)) {
      var7 = self.bot_defending_override_origin_node;
    }

    if(!isDefined(var7) && isDefined(self.bot_defending_trigger) && isDefined(self.bot_defending_trigger.nearest_node)) {
      var7 = self.bot_defending_trigger.nearest_node;
    }

    if(!isDefined(var7)) {
      var7 = getclosestnodeinsight(scripts\mp\bots\bots_util::defend_valid_center());
    }

    if(!isDefined(var7)) {
      var8 = scripts\mp\bots\bots_util::defend_valid_center();
      var9 = getnodesinradiussorted(var8, 256, 0);

      for(var10 = 0; var10 < var9.size; var10++) {
        var11 = vectorNormalize(var9[var10].origin - var8);
        var12 = var8 + var11 * 15;

        if(sighttracepassed(var12, var9[var10].origin, 0, undefined)) {
          var7 = var9[var10];
          break;
        }

        wait 0.05;

        if(sighttracepassed(var12 + (0, 0, 55), var9[var10].origin + (0, 0, 55), 0, undefined)) {
          var7 = var9[var10];
          break;
        }

        wait 0.05;
      }
    }

    self.node_closest_to_defend_center = var7;
  } else if(isDefined(var3) && isDefined(var3["nearest_node_to_center"])) {
    self.node_closest_to_defend_center = var3["nearest_node_to_center"];
  }

  var13 = level.bot_find_defend_node_func[var2];

  if(!isDefined(var4)) {
    var4 = "guard";

    if(var2 == "capture" || var2 == "capture_zone") {
      var4 = "objective";
    }
  }

  var14 = 0;
  var15 = 0;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var14 = 1;
    var15 = isDefined(var3) && isDefined(var3["entrance_points_index"]) && isarray(var3["entrance_points_index"]);
  } else if(isDefined(var3) && istrue(var3["random_stance"])) {
    var14 = 1;
    var15 = 1;
  }

  var16 = 1;

  if(isDefined(var3) && istrue(var3["dont_leave_goal_during_combat"])) {
    var16 = 0;
  }

  jumpiffalse(var2 == "protect") LOC_000003a9;
  GscBinSkip4(0x35);

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.cur_defend_stance = calculate_defend_stance(var14, var15);
    var17 = self botgetscriptgoaltype();
    var18 = scripts\mp\bots\bots_util::bot_goal_can_override(var4, var17);

    if(!var18) {
      wait 0.25;
      continue;
    }

    var19 = var5;
    var20 = var6;
    var21 = 1;

    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      var21 = 0;
      var19 = 1;
      var20 = 2;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      if(isDefined(level.aerial_danger_exists_for) && level.aerial_danger_exists_for[self.team]) {
        if(!scripts\engine\utility::array_contains(self.defense_score_flags, "avoid_aerial_enemies")) {
          self.defense_score_flags[self.defense_score_flags.size] = "avoid_aerial_enemies";
        }
      }

      self[[var13]]();
    }

    self botclearscriptgoal();
    var22 = "";

    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(var21 && scripts\mp\bots\bots_util::bot_is_protecting() && !isPlayer(var0) && isDefined(self.defend_entrance_index)) {
        var23 = bot_get_ambush_trap_item("trap_directional", "trap", "c4");

        if(isDefined(var23)) {
          var24 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(var23, var24, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        var25 = undefined;

        if(isDefined(self.cur_defend_angle_override)) {
          var25 = self.cur_defend_angle_override[1];
        }

        self botsetscriptgoal(self.cur_defend_point_override, 0, var4, var25, self.defend_objective_radius);
      } else if(!isDefined(self.cur_defend_angle_override)) {
        self botsetscriptgoalnode(self.cur_defend_node, var4, undefined, self.defend_objective_radius);
      } else {
        self botsetscriptgoalnode(self.cur_defend_node, var4, self.cur_defend_angle_override[1], self.defend_objective_radius);
      }

      if(var14) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node) {
          self botsetstance("none");
        }
      }

      var26 = self botgetscriptgoal();
      self notify("new_defend_goal");
      scripts\mp\bots\bots_util::watch_nodes_stop();

      if(var4 == "objective") {
        defense_cautious_approach();
        self botsetawareness(1);
        self botsetflag("cautious", 0);
      }

      if(self bothasscriptgoal()) {
        var27 = self botgetscriptgoal();

        if(scripts\mp\bots\bots_util::bot_vectors_are_equal(var27, var26)) {
          var22 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
        }
      }

      if(var22 == "goal") {
        if(var14) {
          self botsetstance(self.cur_defend_stance);
        }

        GscBinSkip4(0x35);
      }
    }

    if(var22 != "goal") {
      var28 = 0.25;

      if(var22 == "no_path" && isDefined(self.defend_wait_time_when_no_path)) {
        var28 = self.defend_wait_time_when_no_path;
      }

      wait var28;
      continue;
    }

    var29 = randomfloatrange(var19, var20);
    var22 = scripts\engine\utility::ref_143bd(var29, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((var22 == "node_relinquished" || var22 == "bad_path" || var22 == "goal_changed" || var22 == "script_goal_changed") && (self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone")) {
      self botsetstance("none");
    }

    if(var22 == "timeout" && !var16) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time();
    }
  }
}

function calculate_defend_stance(var0, var1) {
  var2 = "stand";

  if(var0) {
    var3 = 100;
    var4 = 0;
    var5 = 0;
    var6 = self botgetdifficultysetting("strategyLevel");

    if(var6 == 1) {
      var3 = 20;
      var4 = 25;
      var5 = 55;
    } else if(var6 >= 2) {
      var3 = 10;
      var4 = 20;
      var5 = 70;
    }

    var7 = randomint(100);

    if(var7 < var4) {
      var2 = "crouch";
    } else if(var7 < var4 + var5) {
      var2 = "prone";
    }

    var8 = !isDefined(var1) || !var1;

    if(var8 && var2 == "prone") {
      var9 = bot_defend_get_precalc_entrances_for_current_area("prone");
      var10 = defend_get_ally_bots_at_zone_for_stance("prone");

      if(var10.size >= var9.size) {
        var2 = "crouch";
      }
    }

    if(var8 && var2 == "crouch") {
      var11 = bot_defend_get_precalc_entrances_for_current_area("crouch");
      var12 = defend_get_ally_bots_at_zone_for_stance("crouch");

      if(var12.size >= var11.size) {
        var2 = "stand";
      }
    }
  }

  return var2;
}

function should_start_cautious_approach_default(var0) {
  var1 = 1250;
  var2 = var1 * var1;

  if(var0) {
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      return 0;
    }

    if(self.bot_defending_type == "capture_zone" && self istouching(self.bot_defending_trigger)) {
      return 0;
    }

    return (distancesquared(self.origin, self.bot_defending_center) > var2 * 0.75 * 0.75);
  }

  if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < var2) {
    var3 = self botgetpathdist();
    return (0 <= var3 && var3 <= var1);
  }

  return 0;
}

function setup_investigate_location(var0, var1) {
  var2 = spawnStruct();

  if(isDefined(var1)) {
    var2.origin = var1;
  } else {
    var2.origin = var0.origin;
  }

  var2.node = var0;
  var2.frames_visible = 0;
  return var2;
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

  var0 = self botgetscriptgoal();
  var1 = self botgetscriptgoalnode();
  var2 = 1;
  var3 = 0.2;
  var4 = 0;

  while(var2) {
    wait 0.25;
    var4 += 0.25;

    if(!self bothasscriptgoal()) {
      return;
    }

    var5 = self botgetscriptgoal();

    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(var0, var5)) {
      return;
    }

    if(var4 >= 1) {
      var6 = self botgetnodesonpath();

      if(var6.size == 0) {
        self botclearscriptgoal();
        return;
      }
    }

    var3 += 0.25;

    if(var3 >= 0.5) {
      var3 = 0;

      if([[level.bot_funcs["should_start_cautious_approach"]]](0)) {
        var2 = 0;
      }
    }
  }

  self botsetawareness(1.8);
  self botsetflag("cautious", 1);
  var7 = self botgetnodesonpath();

  if(!isDefined(var7) || var7.size <= 2) {
    return;
  }

  self.locations_to_investigate = [];
  var8 = 1000;

  if(isDefined(level.protect_radius)) {
    var8 = level.protect_radius;
  }

  var9 = var8 * var8;
  var10 = getnodesinradius(self.bot_defending_center, var8, 0, 500);

  if(var10.size <= 0) {
    return;
  }

  var11 = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  var12 = int(min(var11, var10.size));
  var13 = self botnodepickmultiple(var10, 15, var12, "node_protect", scripts\mp\bots\bots_util::defend_valid_center(), "ignore_occupancy");

  for(var14 = 0; var14 < var13.size; var14++) {
    var15 = setup_investigate_location(var13[var14]);
    self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var15);
  }

  var16 = botgetmemoryevents(0, gettime() - 60000, 1, "death", 0, self);

  foreach(var18 in var16) {
    if(distancesquared(var18, self.bot_defending_center) < var9) {
      var19 = getclosestnodeinsight(var18);

      if(isDefined(var19)) {
        var15 = setup_investigate_location(var19, var18);
        self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var15);
      }
    }
  }

  if(isDefined(self.defend_entrance_index)) {
    var21 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index("stand", self.defend_entrance_index);

    for(var14 = 0; var14 < var21.size; var14++) {
      var15 = setup_investigate_location(var21[var14]);
      self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var15);
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
  var0 = undefined;

  if(isDefined(self.bot_defending_radius)) {
    var0 = self.bot_defending_radius * self.bot_defending_radius;
  } else if(isDefined(self.bot_defending_nodes)) {
    var1 = bot_capture_zone_get_furthest_distance();
    var0 = var1 * var1;
  }

  wait 0.05;

  for(;;) {
    if(distancesquared(self.origin, self.bot_defending_center) < var0) {
      self notify("cautious_approach_early_out");
    }

    wait 0.05;
  }
}

function monitor_cautious_approach_dangerous_locations() {
  self endon("stop_location_monitoring");
  var0 = 10000;

  for(;;) {
    var1 = self getnearestnode();

    if(isDefined(var1)) {
      var2 = self botgetfovdot();

      for(var3 = 0; var3 < self.locations_to_investigate.size; var3++) {
        if(nodesvisible(var1, self.locations_to_investigate[var3].node, 1)) {
          var4 = scripts\engine\utility::within_fov(self.origin, self getplayerangles(), self.locations_to_investigate[var3].origin, var2);
          var5 = !var4 || self.locations_to_investigate[var3].frames_visible < 17;

          if(var5 && distancesquared(self.origin, self.locations_to_investigate[var3].origin) < var0) {
            var4 = 1;
            self.locations_to_investigate[var3].frames_visible = 18;
          }

          if(var4) {
            self.locations_to_investigate[var3].frames_visible++;

            if(self.locations_to_investigate[var3].frames_visible >= 18) {
              self.locations_to_investigate[var3] = self.locations_to_investigate[self.locations_to_investigate.size - 1];
              self.locations_to_investigate[self.locations_to_investigate.size - 1] = undefined;
              var3--;
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
  var0 = [];
  var1 = 1050;
  var2 = var1 * var1;
  var3 = 900;
  jumpiffalse(isDefined(level.protect_radius)) LOC_00000031;
  var3 = level.protect_radius;

  for(;;) {
    var4 = gettime();
    var5 = bot_get_teammates_in_radius(self.bot_defending_center, var3);

    foreach(var7 in var5) {
      var8 = var7.entity_number;

      if(!isDefined(var8)) {
        var8 = var7 getentitynumber();
      }

      if(!isDefined(var0[var8])) {
        var0 = var4 - 1;
      }

      if(!isDefined(var7.last_investigation_time)) {
        var7.last_investigation_time = var4 - 10001;
      }

      if(var7.health == 0 && isDefined(var7.deathtime) && var4 - var7.deathtime < 5000) {
        if(var4 - var7.last_investigation_time > 10000 && var4 > var0[var8]) {
          if(isDefined(var7.lastattacker) && isDefined(var7.lastattacker.team) && var7.lastattacker.team == scripts\engine\utility::get_enemy_team(self.team)) {
            if(distancesquared(var7.body.origin, self.origin) < var2) {
              self botgetimperfectenemyinfo(var7.lastattacker, var7.body.origin);
              var9 = getclosestnodeinsight(var7.body.origin);

              if(isDefined(var9)) {
                self.defense_investigate_specific_point = var9.origin;
                self notify("defend_force_node_recalculation");
              }

              var7.last_investigation_time = var4;
            }

            var0 = var4 + 10000;
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
    var0 = findentrances(self.origin);
    return var0;
  }
}

function defense_watch_entrances_at_goal() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var0 = self getnearestnode();
  var1 = undefined;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var2 = defense_get_initial_entrances();
    var1 = [];

    if(isDefined(var0)) {
      foreach(var4 in var2) {
        if(nodesvisible(var0, var4, 1)) {
          var1 = scripts\engine\utility::array_add(var1, var4);
        }
      }
    }

    if(var1.size == 0) {
      var1 = findentrances(self.origin);
    }
  } else if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    var1 = defense_get_initial_entrances();
    var6 = self getcurrentweapon();

    if(isDefined(var0) && !issubstr(var6.basename, "riotshield") && isDefined(self.node_closest_to_defend_center)) {
      if(nodesvisible(var0, self.node_closest_to_defend_center, 1)) {
        var1 = scripts\engine\utility::array_add(var1, self.node_closest_to_defend_center);
      }
    }
  }

  if(isDefined(var1)) {
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(var1);

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

  var0 = level.bot_funcs["get_watch_node_chance"];

  for(;;) {
    var1 = 0.8;
    var2 = 1;

    if(scripts\engine\utility::array_contains(self.defense_score_flags, "strict_los")) {
      var1 = 1;
      var2 = 0.5;
    }

    if(isDefined(self.node_closest_to_defend_center)) {
      foreach(var4 in self.watch_nodes) {
        if(var4 == self.node_closest_to_defend_center) {
          var4.watch_node_chance[self.entity_number] = var4.watch_node_base_chance[self.entity_number] * var1;
          continue;
        }

        var4.watch_node_chance[self.entity_number] = var4.watch_node_base_chance[self.entity_number] * var2;
      }
    }

    var6 = isDefined(var0);

    if(!var6) {
      prioritize_watch_nodes_toward_enemies(0.5);
    }

    foreach(var4 in self.watch_nodes) {
      if(var6) {
        var8 = self[[var0]](var4);
        var4.watch_node_chance[self.entity_number] *= var8;
      }

      if(entrance_watched_by_ally(var4)) {
        var4.watch_node_chance[self.entity_number] *= 0.5;
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
    var0 = anglesToForward(self.bot_defend_player_guarding getplayerangles()) * (1, 1, 0);
    var0 = vectorNormalize(var0);

    foreach(var2 in self.watch_nodes) {
      var2.watch_node_chance[self.entity_number] = var2.watch_node_base_chance[self.entity_number];
      var3 = var2.origin - self.bot_defend_player_guarding.origin;
      var3 = vectorNormalize(var3);
      var4 = vectordot(var0, var3);

      if(var4 > 0.6) {
        var2.watch_node_chance[self.entity_number] *= 0.33;
      } else if(var4 > 0) {
        var2.watch_node_chance[self.entity_number] *= 0.66;
      }

      if(!entrance_to_enemy_zone(var2)) {
        var2.watch_node_chance[self.entity_number] *= 0.5;
      }
    }

    wait randomfloatrange(0.4, 0.6);
  }
}

function entrance_to_enemy_zone(var0) {
  var1 = getnodezone(var0);
  var2 = vectorNormalize(var0.origin - self.origin);

  for(var3 = 0; var3 < level.zonecount; var3++) {
    if(botzonegetcount(var3, self.team, "enemy_predict") > 0) {
      if(isDefined(var1) && var3 == var1) {
        return true;
      } else {
        var4 = vectorNormalize(getzoneorigin(var3) - self.origin);
        var5 = vectordot(var2, var4);

        if(var5 > 0.2) {
          return true;
        }
      }
    }
  }

  return false;
}

function prioritize_watch_nodes_toward_enemies(var0) {
  if(self.watch_nodes.size <= 0) {
    return;
  }

  var1 = self.watch_nodes;

  for(var2 = 0; var2 < level.zonecount; var2++) {
    if(botzonegetcount(var2, self.team, "enemy_predict") <= 0) {
      continue;
    }

    if(var1.size == 0) {
      break;
    }

    var3 = vectorNormalize(getzoneorigin(var2) - self.origin);

    for(var4 = 0; var4 < var1.size; var4++) {
      var5 = getnodezone(var1[var4]);
      var6 = 0;

      if(isDefined(var5) && var2 == var5) {
        var6 = 1;
      } else {
        var7 = vectorNormalize(var1[var4].origin - self.origin);
        var8 = vectordot(var7, var3);

        if(var8 > 0.2) {
          var6 = 1;
        }
      }

      if(var6) {
        var1[var4].watch_node_chance[self.entity_number] *= var0;
        var1 = var1[var1.size - 1];
        var1[var1.size - 1] = undefined;
        var4--;
      }
    }
  }
}

function entrance_watched_by_ally(var0) {
  if(self.bot_defending_type == "protect_zone") {
    var1 = bot_get_teammates_currently_defending_zone(self.bot_defending_zone_id);
  } else {
    var1 = bot_get_teammates_currently_defending_point(self.bot_defending_center);
  }

  foreach(var3 in var1) {
    if(entrance_watched_by_player(var3, var1)) {
      return true;
    }
  }

  return false;
}

function entrance_watched_by_player(var0, var1) {
  var2 = anglesToForward(var0 getplayerangles());
  var3 = vectorNormalize(var1.origin - var0.origin);
  var4 = vectordot(var2, var3);

  if(var4 > 0.6) {
    return true;
  }

  return false;
}

function bot_get_teammates_currently_defending_zone(var0) {
  var1 = [];
  var2 = bot_get_teammates_in_radius(self.origin, 1000);

  foreach(var4 in var2) {
    if(!isai(var4) || var4 scripts\mp\bots\bots_util::bot_is_defending() && var4.bot_defending_zone_id == var0) {
      var1 = scripts\engine\utility::array_add(var1, var4);
    }
  }

  return var1;
}

function bot_get_teammates_currently_defending_point(var0, var1) {
  if(!isDefined(var1)) {
    if(isDefined(level.protect_radius)) {
      var1 = level.protect_radius;
    } else {
      var1 = 900;
    }
  }

  var2 = [];
  var3 = bot_get_teammates_in_radius(var0, var1);

  foreach(var5 in var3) {
    if(!isai(var5) || var5 scripts\mp\bots\bots_util::bot_is_defending_point(var0)) {
      var2 = scripts\engine\utility::array_add(var2, var5);
    }
  }

  return var2;
}

function bot_get_teammates_in_radius(var0, var1) {
  var2 = var1 * var1;
  var3 = [];

  for(var4 = 0; var4 < level.participants.size; var4++) {
    var5 = level.participants[var4];

    if(var5 != self && isDefined(var5.team) && var5.team == self.team && scripts\mp\utility\entity::isteamparticipant(var5)) {
      if(distancesquared(var0, var5.origin) < var2) {
        var3 = scripts\engine\utility::array_add(var3, var5);
      }
    }
  }

  return var3;
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

function defend_get_ally_bots_at_zone_for_stance(var0) {
  var1 = [];

  foreach(var3 in level.participants) {
    if(!isDefined(var3.team)) {
      continue;
    }

    if(var3.team == self.team && var3 != self && isai(var3) && var3 scripts\mp\bots\bots_util::bot_is_defending() && isDefined(var3.cur_defend_stance) && var3.cur_defend_stance == var0) {
      if(var3.bot_defending_type == self.bot_defending_type && scripts\mp\bots\bots_util::bot_is_defending_point(var3.bot_defending_center)) {
        var1 = scripts\engine\utility::array_add(var1, var3);
      }
    }
  }

  return var1;
}

function monitor_defend_player() {
  var0 = 0;
  var1 = 175;
  var2 = self.bot_defend_player_guarding.origin;
  var3 = 0;
  var4 = 0;

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
      var5 = self botgetscriptgoal();
      var6 = self.bot_defend_player_guarding getvelocity();
      var7 = lengthsquared(var6);

      if(var7 > 100) {
        var0 = 0;

        if(distancesquared(var2, self.bot_defend_player_guarding.origin) > var1 * var1) {
          var2 = self.bot_defend_player_guarding.origin;
          var4 = 1;
          var8 = vectorNormalize(var5 - self.bot_defend_player_guarding.origin);
          var9 = vectorNormalize(var6);

          if(vectordot(var8, var9) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      } else {
        var0 += 0.05;

        if(var3 > 100 && var4) {
          var2 = self.bot_defend_player_guarding.origin;
          var4 = 0;
        }

        if(var0 > 0.5) {
          var10 = distancesquared(var5, self.bot_defending_center);

          if(var10 > self.bot_defending_radius * self.bot_defending_radius) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      }

      var3 = var7;

      if(abs(self.bot_defend_player_guarding.origin[2] - var5[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait 0.25;
      }
    }

    wait 0.05;
  }
}

function find_defend_node_capture() {
  var0 = bot_defend_get_random_entrance_point_for_current_area();
  var1 = scripts\mp\bots\bots_util::bot_find_node_to_capture_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, var0);

  if(isDefined(var1)) {
    if(isDefined(var0)) {
      var2 = vectorNormalize(var0 - var1.origin);
      self.cur_defend_angle_override = vectortoangles(var2);
    } else {
      var3 = vectorNormalize(var1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var3);
    }

    self.cur_defend_node = var1;
    return;
  }

  if(isDefined(var0)) {
    bot_handle_no_valid_defense_node(var0, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

function find_defend_node_capture_zone() {
  var0 = bot_defend_get_random_entrance_point_for_current_area();
  var1 = scripts\mp\bots\bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes, var0);

  if(isDefined(var1)) {
    if(isDefined(var0)) {
      var2 = vectorNormalize(var0 - var1.origin);
      self.cur_defend_angle_override = vectortoangles(var2);
    } else {
      var3 = vectorNormalize(var1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var3);
    }

    self.cur_defend_node = var1;
    return;
  }

  if(isDefined(var0)) {
    bot_handle_no_valid_defense_node(var0, undefined);
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

function find_defend_node_protect() {
  var0 = scripts\mp\bots\bots_util::bot_find_node_that_protects_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(var0)) {
    var1 = vectorNormalize(scripts\mp\bots\bots_util::defend_valid_center() - var0.origin);
    self.cur_defend_angle_override = vectortoangles(var1);
    self.cur_defend_node = var0;
    return;
  }

  bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

function find_defend_node_protect_zone() {
  var0 = scripts\mp\bots\bots_util::bot_find_node_to_protect_zone(self.bot_defending_nodes, scripts\mp\bots\bots_util::defend_valid_center());

  if(isDefined(var0)) {
    self.cur_defend_node = var0;
    return;
  }

  bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

function find_defend_node_bodyguard() {
  var0 = scripts\mp\bots\bots_util::bot_find_node_to_guard_player(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(var0)) {
    self.cur_defend_node = var0;
    return;
  }

  var1 = self getnearestnode();

  if(isDefined(var1)) {
    self.cur_defend_node = var1;
    return;
  }

  self.cur_defend_point_override = self.origin;
}

function find_defend_node_patrol() {
  var0 = undefined;
  var1 = getnodesinradius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, 0);

  if(isDefined(var1) && var1.size > 0) {
    var0 = self botnodepick(var1, 1 + var1.size * 0.5, "node_traffic");
  }

  if(isDefined(var0)) {
    self.cur_defend_node = var0;
    return;
  }

  bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

function bot_handle_no_valid_defense_node(var0, var1) {
  if(self.bot_defending_type == "protect_zone") {
    self.cur_defend_point_override = scripts\engine\utility::random(self.bot_defending_nodes).origin;
    return;
  }

  if(self.bot_defending_type == "capture_zone") {
    self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_from_set(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_nodes, &bot_can_use_point_in_defend);
  } else {
    self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_in_radius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, &bot_can_use_point_in_defend, 0.15, 0.9);
  }

  if(isDefined(var0)) {
    var2 = vectorNormalize(var0 - self.cur_defend_point_override);
    self.cur_defend_angle_override = vectortoangles(var2);
    return;
  }

  if(isDefined(var1)) {
    var2 = vectorNormalize(self.cur_defend_point_override - var1);
    self.cur_defend_angle_override = vectortoangles(var2);
    return;
  }
}

function bot_can_use_point_in_defend(var0) {
  if(bot_check_team_is_using_position(var0, 1, 1, 1)) {
    return false;
  }

  return true;
}

function bot_check_team_is_using_position(var0, var1, var2, var3) {
  for(var4 = 0; var4 < level.participants.size; var4++) {
    var5 = level.participants[var4];

    if(isDefined(var5.team) && var5.team == self.team && var5 != self) {
      if(isai(var5)) {
        if(var2) {
          if(distancesquared(var0, var5.origin) < 441) {
            return true;
          }
        }

        if(var3 && var5 bothasscriptgoal()) {
          var6 = var5 botgetscriptgoal();

          if(distancesquared(var0, var6) < 441) {
            return true;
          }
        }

        continue;
      }

      if(var1) {
        if(distancesquared(var0, var5.origin) < 441) {
          return true;
        }
      }
    }
  }

  return false;
}

function bot_capture_zone_get_furthest_distance() {
  var0 = 0;

  if(isDefined(self.bot_defending_nodes)) {
    foreach(var2 in self.bot_defending_nodes) {
      var3 = distance(self.bot_defending_center, var2.origin);
      var0 = max(var3, var0);
    }
  }

  return var0;
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
      var0 = self.tactical_goals[0];

      if(!isDefined(var0.abort)) {
        self notify("start_tactical_goal");

        if(isDefined(var0.start_thread)) {
          self[[var0.start_thread]](var0);
        }

        GscBinSkip4(0x35, var0);
      }

      self.tactical_goals = scripts\engine\utility::array_remove(self.tactical_goals, var0);
    }

    wait 0.05;
  }
}

function watch_goal_aborted(var0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;

  for(;;) {
    if(isDefined(var0.abort) || isDefined(var0.should_abort) && self[[var0.should_abort]](var0)) {
      self notify("stop_tactical_goal");
    }

    wait 0.05;
  }
}

function bot_new_tactical_goal(var0, var1, var2, var3) {
  if(lengthsquared(var1) == 0) {
    var1 += (0, 0, 1);
  }

  var4 = spawnStruct();
  var4.type = var0;
  var4.goal_position = var1;

  if(isDefined(self.only_allowable_tactical_goals)) {
    if(!scripts\engine\utility::array_contains(self.only_allowable_tactical_goals, var0)) {
      return;
    }
  }

  var4.priority = var2;
  var4.object = var3.object;
  var4.goal_type = var3.script_goal_type;
  var4.goal_yaw = var3.script_goal_yaw;
  var4.goal_radius = 0;

  if(isDefined(var3.script_goal_radius)) {
    var4.goal_radius = var3.script_goal_radius;
  }

  var4.start_thread = var3.start_thread;
  var4.end_thread = var3.end_thread;
  var4.should_abort = var3.should_abort;
  var4.action_thread = var3.action_thread;
  var4.objective_radius = var3.objective_radius;
  var4.ref_132b7 = var3.ref_132b7;
  var4.ref_12139 = var3.ref_12139;
  var4.hastargetmarker = var3.hastargetmarker;

  for(var5 = 0; var5 < self.tactical_goals.size; var5++) {
    if(var4.priority > self.tactical_goals[var5].priority) {
      break;
    }
  }

  for(var6 = self.tactical_goals.size - 1; var6 >= var5; var6--) {
    self.tactical_goals[var6 + 1] = self.tactical_goals[var6];
  }

  self.tactical_goals[var5] = var4;
}

function bot_has_tactical_goal(var0, var1) {
  if(!isDefined(self.tactical_goals)) {
    return 0;
  }

  if(isDefined(var0)) {
    foreach(var3 in self.tactical_goals) {
      if(var3.type == var0) {
        if(isDefined(var1) && isDefined(var3.object)) {
          return (var3.object == var1);
        }

        return 1;
      }
    }

    return 0;
  }

  return self.tactical_goals.size > 0;
}

function damageshield_cooldown(var0) {
  var1 = [];

  if(isDefined(self.tactical_goals)) {
    foreach(var3 in self.tactical_goals) {
      if(!istrue(var3.abort) && var3.type == var0) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function bot_abort_tactical_goal(var0, var1) {
  if(!isDefined(self.tactical_goals)) {
    return;
  }

  foreach(var3 in self.tactical_goals) {
    if(var3.type == var0) {
      if(isDefined(var1)) {
        if(isDefined(var3.object) && var3.object == var1) {
          var3.abort = 1;
        }

        continue;
      }

      var3.abort = 1;
    }
  }
}

function bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "map_interactive_object";

  foreach(var1 in self.tactical_goals) {
    if(var1.type != "map_interactive_object") {
      var1.abort = 1;
    }
  }
}

function bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

function bot_melee_tactical_insertion_check() {
  var0 = gettime();

  if(!isDefined(self.last_melee_ti_check) || var0 - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = var0;
    var1 = bot_get_ambush_trap_item("tacticalinsertion");

    if(!isDefined(var1)) {
      return false;
    }

    if(isDefined(self.enemy) && self botcanseeentity(self.enemy)) {
      return false;
    }

    var2 = getzonenearest(self.origin);

    if(!isDefined(var2)) {
      return false;
    }

    var3 = botzonenearestcount(var2, self.team, 1, "enemy_predict", ">", 0);

    if(!isDefined(var3)) {
      return false;
    }

    var4 = getnodesinradius(self.origin, 500, 0);

    if(var4.size <= 0) {
      return false;
    }

    var5 = self botnodepick(var4, var4.size * 0.15, "node_hide");

    if(!isDefined(var5)) {
      return false;
    }

    return bot_set_ambush_trap(var1, undefined, undefined, undefined, var5);
  }

  return false;
}