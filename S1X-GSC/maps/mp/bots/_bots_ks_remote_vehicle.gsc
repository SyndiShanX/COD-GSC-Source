/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_ks_remote_vehicle.gsc
****************************************************/

remote_vehicle_setup() {
  while(!isDefined(level.bot_variables_initialized)) {
    wait 0.05;
  }

  if(isDefined(level.bot_initialized_remote_vehicles)) {
    return;
  }
  level.outside_zones = [];

  if(isDefined(level.teleportgetactivepathnodezonesfunc)) {
    var_0 = [[level.teleportgetactivepathnodezonesfunc]]();
  } else {
    var_0 = [];

    for(var_1 = 0; var_1 < level.zonecount; var_1++) {
      var_0[var_0.size] = var_1;
    }
  }

  foreach(var_3 in var_0) {
    if(botzonegetindoorpercent(var_3) < 0.25) {
      level.outside_zones = common_scripts\utility::array_add(level.outside_zones, var_3);
    }
  }

  level.bot_initialized_remote_vehicles = 1;
}

bot_killstreak_remote_control(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    return 0;
  }

  var_5 = 1;
  var_6 = 1;
  var_7 = undefined;

  if(isDefined(self.node_ambushing_from)) {
    var_8 = self botgetscriptgoalradius();
    var_9 = distancesquared(self.origin, self.node_ambushing_from.origin);

    if(var_9 < squared(var_8)) {
      var_5 = 0;
      var_6 = 0;
    } else if(var_9 < squared(200)) {
      var_5 = 0;
    }
  }

  var_10 = var_0.streakname == "vanguard" && is_indoor_map();

  if(var_10 || var_5) {
    var_11 = getnodesinradius(self.origin, 500, 0, 512);

    if(isDefined(var_11) && var_11.size > 0) {
      if(isDefined(var_4) && var_4) {
        var_12 = var_11;
        var_11 = [];

        foreach(var_14 in var_12) {
          if(nodeexposedtosky(var_14)) {
            var_15 = getlinkednodes(var_14);
            var_16 = 0;

            foreach(var_18 in var_15) {
              if(nodeexposedtosky(var_18)) {
                var_16++;
              }
            }

            if(var_16 / var_15.size > 0.5) {
              var_11 = common_scripts\utility::array_add(var_11, var_14);
            }
          }
        }
      }

      if(var_10) {
        var_21 = self botnodescoremultiple(var_11, "node_exposed");

        foreach(var_14 in var_21) {
          if(bullettracepassed(var_14.origin + (0, 0, 30), var_14.origin + (0, 0, 400), 0, self)) {
            var_7 = var_14;
            break;
          }

          wait 0.05;
        }
      } else if(var_11.size > 0) {
        var_7 = self botnodepick(var_11, min(3, var_11.size), "node_hide");
      }

      if(!isDefined(var_7)) {
        return 0;
      }

      self botsetscriptgoalnode(var_7, "tactical");
    }
  }

  if(var_6) {
    var_24 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

    if(var_24 != "goal") {
      try_clear_hide_goal(var_7);
      return 1;
    }
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    try_clear_hide_goal(var_7);
    return 0;
  }

  if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    try_clear_hide_goal(var_7);
    return 1;
  }

  if(!isDefined(var_7)) {
    if(self getstance() == "prone") {
      self botsetstance("prone");
    } else if(self getstance() == "crouch") {
      self botsetstance("crouch");
    }
  } else if(self botgetdifficultysetting("strategyLevel") > 0) {
    if(randomint(100) > 50) {
      self botsetstance("prone");
    } else {
      self botsetstance("crouch");
    }
  }

  maps\mp\bots\_bots_ks::bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  self.vehicle_controlling = undefined;
  self thread[[var_3]]();
  thread bot_end_control_on_respawn();
  thread bot_end_control_watcher(var_7);
  self waittill("control_func_done");
  return 1;
}

bot_end_control_on_respawn() {
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self waittill("spawned_player");
  self notify("control_func_done");
}

bot_end_control_watcher(var_0) {
  self endon("disconnect");
  self waittill("control_func_done");
  try_clear_hide_goal(var_0);
  self botsetstance("none");
  self botsetscriptmove(0, 0);
  self botsetflag("disable_movement", 0);
  self botsetflag("disable_rotation", 0);
  self.vehicle_controlling = undefined;
}

try_clear_hide_goal(var_0) {
  if(isDefined(var_0) && self bothasscriptgoal() && isDefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == var_0) {
    self botclearscriptgoal();
  }
}

bot_end_control_on_vehicle_death(var_0) {
  var_0 waittill("death");
  self notify("control_func_done");
}

bot_waittill_using_vehicle(var_0) {
  var_1 = gettime();

  while(!self[[level.bot_ks_funcs["isUsing"][var_0]]]()) {
    wait 0.05;

    if(gettime() - var_1 > 5000) {
      return 0;
    }
  }

  return 1;
}

is_indoor_map() {
  return level.script == "mp_sovereign";
}

bot_body_is_dead() {
  return isDefined(self.fauxdead) && self.fauxdead;
}

heli_pick_node_furthest_from_center(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = distancesquared(level.bot_map_center, [[level.bot_ks_funcs["heli_node_get_origin"][var_1]]](var_5));

    if(var_6 > var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    return var_2;
  } else {
    return common_scripts\utility::random(var_0);
  }
}

heli_get_node_origin(var_0) {
  return var_0.origin;
}

find_closest_heli_node_2d(var_0, var_1) {
  var_2 = undefined;
  var_3 = 99999999;

  foreach(var_5 in level.bot_heli_nodes) {
    var_6 = distance2dsquared(var_0, [[level.bot_ks_funcs["heli_node_get_origin"][var_1]]](var_5));

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2;
}

bot_killstreak_get_zone_allies_outside(var_0) {
  var_1 = bot_killstreak_get_all_outside_allies(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level.zonecount; var_3++) {
    var_2[var_3] = [];
  }

  foreach(var_5 in var_1) {
    var_6 = var_5 getnearestnode();
    var_7 = getnodezone(var_6);

    if(isDefined(var_7)) {
      var_2[var_7] = common_scripts\utility::array_add(var_2[var_7], var_5);
    }
  }

  return var_2;
}

bot_killstreak_get_zone_enemies_outside(var_0) {
  var_1 = bot_killstreak_get_all_outside_enemies(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level.zonecount; var_3++) {
    var_2[var_3] = [];
  }

  foreach(var_5 in var_1) {
    var_6 = var_5 getnearestnode();
    var_7 = getnodezone(var_6);
    var_2[var_7] = common_scripts\utility::array_add(var_2[var_7], var_5);
  }

  return var_2;
}

bot_killstreak_get_all_outside_enemies(var_0) {
  return bot_killstreak_get_outside_players(self.team, "enemy", var_0);
}

bot_killstreak_get_all_outside_allies(var_0) {
  return bot_killstreak_get_outside_players(self.team, "ally", var_0);
}

bot_killstreak_get_outside_players(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = level.participants;

  if(isDefined(var_2) && var_2) {
    var_4 = level.players;
  }

  foreach(var_6 in var_4) {
    if(var_6 == self || !isalive(var_6)) {
      continue;
    }
    var_7 = 0;

    if(var_1 == "ally") {
      var_7 = level.teambased && var_0 == var_6.team;
    } else if(var_1 == "enemy") {
      var_7 = !level.teambased || var_0 != var_6.team;
    }

    if(var_7) {
      var_8 = var_6 getnearestnode();

      if(isDefined(var_8) && nodeexposedtosky(var_8)) {
        var_3 = common_scripts\utility::array_add(var_3, var_6);
      }
    }
  }

  var_3 = common_scripts\utility::array_remove(var_3, self);
  return var_3;
}

bot_heli_find_unvisited_nodes(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0.neighbors) {
    if(isDefined(var_4.script_linkname)) {
      var_5 = var_4.bot_visited_times[self.entity_number];

      if(var_5 < var_1) {
        var_2 = [];
        var_2[0] = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

bot_control_heli(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_1 = bot_waittill_using_vehicle(var_0);

  if(!var_1) {
    self notify("control_func_done");
  }

  foreach(var_3 in level.littlebirds) {
    if(var_3.owner == self) {
      self.vehicle_controlling = var_3;
    }
  }

  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("death");

  if(isDefined(level.bot_ks_funcs["control_other"][var_0])) {
    self childthread[[level.bot_ks_funcs["control_other"][var_0]]]();
  }

  self[[level.bot_ks_funcs["waittill_initial_goal"][var_0]]]();
  self childthread[[level.bot_ks_funcs["control_aiming"][var_0]]]();
  bot_control_heli_main_move_loop(var_0, 1);
  self notify("control_func_done");
}

bot_get_heli_goal_dist_sq(var_0) {
  if(var_0) {
    return squared(100);
  } else {
    return squared(30);
  }
}

bot_get_heli_slowdown_dist_sq(var_0) {
  if(var_0) {
    return squared(300);
  } else {
    return squared(90);
  }
}

bot_control_heli_main_move_loop(var_0, var_1) {
  foreach(var_3 in level.bot_heli_nodes) {
    var_3.bot_visited_times[self.entity_number] = 0;
  }

  var_5 = find_closest_heli_node_2d(self.vehicle_controlling.origin, var_0);
  var_6 = undefined;
  self.next_goal_time = 0;
  var_7 = "needs_new_goal";
  var_8 = undefined;
  var_9 = self.vehicle_controlling.origin;
  var_10 = 3.0;
  var_11 = 0.05;

  while(self[[level.bot_ks_funcs["isUsing"][var_0]]]()) {
    if(gettime() > self.next_goal_time && var_7 == "needs_new_goal") {
      var_12 = var_5;
      var_5 = [[level.bot_ks_funcs["heli_pick_node"][var_0]]](var_5);
      var_6 = undefined;

      if(isDefined(var_5)) {
        var_13 = [[level.bot_ks_funcs["heli_node_get_origin"][var_0]]](var_5);

        if(var_1) {
          var_14 = var_5.origin + (maps\mp\_utility::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset);
          var_15 = var_5.origin + (maps\mp\_utility::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset);
          var_16 = bulletTrace(var_14, var_15, 0, undefined, 0, 0, 1);
          var_6 = var_16["position"] - maps\mp\_utility::gethelipilotmeshoffset() + level.bot_ks_heli_offset[var_0];
        } else {
          var_6 = var_13;
        }
      }

      if(isDefined(var_6)) {
        self botsetflag("disable_movement", 0);
        var_7 = "waiting_till_goal";
        var_10 = 3.0;
        var_9 = self.vehicle_controlling.origin;
      } else {
        var_5 = var_12;
        self.next_goal_time = gettime() + 2000;
      }
    } else if(var_7 == "waiting_till_goal") {
      if(!var_1) {
        var_17 = var_6[2] - self.vehicle_controlling.origin[2];

        if(var_17 > 10) {
          self botpressbutton("lethal");
        } else if(var_17 < -10) {
          self botpressbutton("tactical");
        }
      }

      var_18 = var_6 - self.vehicle_controlling.origin;

      if(var_1) {
        var_8 = length2dsquared(var_18);
      } else {
        var_8 = lengthsquared(var_18);
      }

      if(var_8 < bot_get_heli_goal_dist_sq(var_1)) {
        self botsetscriptmove(0, 0);
        self botsetflag("disable_movement", 1);

        if(self botgetdifficulty() == "recruit") {
          self.next_goal_time = gettime() + randomintrange(5000, 7000);
        } else {
          self.next_goal_time = gettime() + randomintrange(3000, 5000);
        }

        var_7 = "needs_new_goal";
      } else {
        var_18 = var_6 - self.vehicle_controlling.origin;
        var_19 = vectortoangles(var_18);
        var_20 = common_scripts\utility::ter_op(var_8 < bot_get_heli_slowdown_dist_sq(var_1), 0.5, 1.0);
        self botsetscriptmove(var_19[1], var_11, var_20);
        var_10 = var_10 - var_11;

        if(var_10 <= 0.0) {
          if(distancesquared(self.vehicle_controlling.origin, var_9) < 225) {
            var_5.bot_visited_times[self.entity_number]++;
            var_7 = "needs_new_goal";
          }

          var_9 = self.vehicle_controlling.origin;
          var_10 = 3.0;
        }
      }
    }

    wait(var_11);
  }
}

get_random_outside_target() {
  var_0 = [];

  foreach(var_2 in level.outside_zones) {
    var_3 = botzonegetcount(var_2, self.team, "enemy_predict");

    if(var_3 > 0) {
      var_0 = common_scripts\utility::array_add(var_0, var_2);
    }
  }

  var_5 = undefined;

  if(var_0.size > 0) {
    var_6 = common_scripts\utility::random(var_0);
    var_7 = common_scripts\utility::random(getzonenodes(var_6));
    var_5 = var_7.origin;
  } else {
    if(isDefined(level.teleportgetactivenodesfunc)) {
      var_8 = [[level.teleportgetactivenodesfunc]]();
    } else {
      var_8 = getallnodes();
    }

    var_9 = 0;

    while(var_9 < 10) {
      var_9++;
      var_10 = var_8[randomint(var_8.size)];
      var_5 = var_10.origin;

      if(nodeexposedtosky(var_10) && distance2dsquared(var_10.origin, self.vehicle_controlling.origin) > 62500) {
        break;
      }
    }
  }

  return var_5;
}