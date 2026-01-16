/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_common.gsc
**************************************************/

bot_cache_entrances_to_bombzones() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.bombzones) {
    var_0[var_2] = common_scripts\utility::random(var_4.bottargets).origin;
    var_1[var_2] = "zone" + var_4.label;
    var_2++;
  }

  bot_cache_entrances(var_0, var_1);
}

bot_cache_entrances_to_gametype_array(var_0, var_1, var_2, var_3) {
  wait 1.0;
  var_4 = [];
  var_5 = [];
  var_6 = 0;

  foreach(var_10, var_8 in var_0) {
    if(isdefined(var_0[var_10].bottarget))
      var_4[var_6] = var_0[var_10].bottarget.origin;
    else {
      var_0[var_10].nearest_node = getclosestnodeinsight(var_0[var_10].origin);

      if(!isdefined(var_0[var_10].nearest_node)) {
        var_9 = getnodesinradiussorted(var_0[var_10].origin, 256, 0);

        if(var_9.size > 0)
          var_0[var_10].nearest_node = var_9[0];
      }

      if(!isdefined(var_0[var_10].nearest_node)) {
        continue;
      }
      if(distance(var_0[var_10].nearest_node.origin, var_0[var_10].origin) > 128) {
        var_0[var_10].nearest_node = undefined;
        continue;
      }

      var_4[var_6] = var_0[var_10].nearest_node.origin;
    }

    var_5[var_6] = var_1 + var_0[var_10].script_label;
    var_6++;
  }

  bot_cache_entrances(var_4, var_5, var_2, var_3);
}

bot_cache_entrances(var_0, var_1, var_2, var_3) {
  var_4 = !isdefined(var_2) || !var_2;
  var_5 = isdefined(var_3) && var_3;
  wait 0.1;

  if(var_5 && var_4) {
    var_6 = getallnodes();

    foreach(var_8 in var_6)
    var_8.on_path_from = undefined;
  }

  var_10 = [];

  for (var_11 = 0; var_11 < var_0.size; var_11++) {
    var_12 = var_1[var_11];
    var_10[var_12] = findentrances(var_0[var_11]);
    wait 0.05;

    for (var_13 = 0; var_13 < var_10[var_12].size; var_13++) {
      var_14 = var_10[var_12][var_13];
      var_14.is_precalculated_entrance = 1;
      var_14.prone_visible_from[var_12] = maps\mp\bots\_bots_util::entrance_visible_from(var_14.origin, var_0[var_11], "prone");
      wait 0.05;
      var_14.crouch_visible_from[var_12] = maps\mp\bots\_bots_util::entrance_visible_from(var_14.origin, var_0[var_11], "crouch");
      wait 0.05;
    }
  }

  var_15 = [];

  if(var_4) {
    for (var_11 = 0; var_11 < var_0.size; var_11++) {
      for (var_13 = var_11 + 1; var_13 < var_0.size; var_13++) {
        var_16 = maps\mp\bots\_bots_util::get_extended_path(var_0[var_11], var_0[var_13]);

        foreach(var_8 in var_16)
        var_8.on_path_from[var_1[var_11]][var_1[var_13]] = 1;
      }
    }
  }

  if(!isdefined(level.entrance_origin_points))
    level.entrance_origin_points = [];

  if(!isdefined(level.entrance_indices))
    level.entrance_indices = [];

  if(!isdefined(level.entrance_points))
    level.entrance_points = [];

  if(var_5) {
    level.entrance_origin_points = var_0;
    level.entrance_indices = var_1;
    level.entrance_points = var_10;
  } else {
    level.entrance_origin_points = common_scripts\utility::array_combine(level.entrance_origin_points, var_0);
    level.entrance_indices = common_scripts\utility::array_combine(level.entrance_indices, var_1);
    level.entrance_points = common_scripts\utility::array_combine_non_integer_indices(level.entrance_points, var_10);
  }

  level.entrance_points_finished_caching = 1;
}

bot_add_missing_nodes(var_0, var_1) {
  if(var_1.classname == "trigger_radius") {
    var_2 = getnodesinradius(var_1.origin, var_1.radius, 0, 100);
    var_3 = common_scripts\utility::array_remove_array(var_2, var_0);

    if(var_3.size > 0)
      var_0 = common_scripts\utility::array_combine(var_0, var_3);
  } else if(var_1.classname == "trigger_multiple" || var_1.classname == "trigger_use_touch") {
    var_4[0] = var_1 getpointinbounds(1, 1, 1);
    var_4[1] = var_1 getpointinbounds(1, 1, -1);
    var_4[2] = var_1 getpointinbounds(1, -1, 1);
    var_4[3] = var_1 getpointinbounds(1, -1, -1);
    var_4[4] = var_1 getpointinbounds(-1, 1, 1);
    var_4[5] = var_1 getpointinbounds(-1, 1, -1);
    var_4[6] = var_1 getpointinbounds(-1, -1, 1);
    var_4[7] = var_1 getpointinbounds(-1, -1, -1);
    var_5 = 0;

    foreach(var_7 in var_4) {
      var_8 = distance(var_7, var_1.origin);

      if(var_8 > var_5)
        var_5 = var_8;
    }

    var_2 = getnodesinradius(var_1.origin, var_5, 0, 200);

    foreach(var_11 in var_2) {
      if(!ispointinvolume(var_11.origin, var_1)) {
        if(ispointinvolume(var_11.origin + (0, 0, 40), var_1) || ispointinvolume(var_11.origin + (0, 0, 80), var_1) || ispointinvolume(var_11.origin + (0, 0, 120), var_1)) {
          if(var_11.type != "Begin" && var_11.type != "End")
            var_0 = common_scripts\utility::array_add(var_0, var_11);
        }
      }
    }
  }

  return var_0;
}

bot_setup_bombzone_bottargets() {
  wait 1.0;
  bot_setup_bot_targets(level.bombzones);
  level.bot_set_bombzone_bottargets = 1;
}

bot_setup_bot_targets(var_0) {
  foreach(var_2 in var_0) {
    if(!isdefined(var_2.bottargets))
      var_2.bottargets = bot_get_valid_nodes_in_trigger(var_2.trigger);
  }
}

bot_gametype_get_num_players_on_team(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(maps\mp\_utility::isteamparticipant(var_3) && isdefined(var_3.team) && var_3.team == var_0)
      var_1++;
  }

  return var_1;
}

bot_gametype_get_allied_attackers_for_team(var_0, var_1, var_2) {
  var_3 = bot_gametype_get_players_by_role("attacker", var_0);

  foreach(var_5 in level.players) {
    if(!isai(var_5) && isdefined(var_5.team) && var_5.team == var_0) {
      if(var_5 bot_gametype_human_player_always_considered_attacker() || distancesquared(var_1, var_5.origin) > squared(var_2))
        var_3 = common_scripts\utility::array_add(var_3, var_5);
    }
  }

  return var_3;
}

bot_gametype_get_allied_defenders_for_team(var_0, var_1, var_2) {
  var_3 = bot_gametype_get_players_by_role("defender", var_0);

  foreach(var_5 in level.players) {
    if(!isai(var_5) && isdefined(var_5.team) && var_5.team == var_0) {
      if(var_5 bot_gametype_human_player_always_considered_defender() || distancesquared(var_1, var_5.origin) <= squared(var_2))
        var_3 = common_scripts\utility::array_add(var_3, var_5);
    }
  }

  return var_3;
}

bot_gametype_human_player_always_considered_attacker() {
  if(isdefined(level.bot_gametype_human_player_always_attacker))
    return self[[level.bot_gametype_human_player_always_attacker]]();

  return 0;
}

bot_gametype_human_player_always_considered_defender() {
  if(isdefined(level.bot_gametype_human_player_always_defender))
    return self[[level.bot_gametype_human_player_always_defender]]();

  return 0;
}

bot_gametype_set_role(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  maps\mp\bots\_bots_strategy::bot_defend_stop();
}

bot_gametype_get_players_by_role(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(isdefined(var_4.team) && isalive(var_4) && maps\mp\_utility::isteamparticipant(var_4) && var_4.team == var_1 && isdefined(var_4.role) && var_4.role == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

bot_gametype_initialize_attacker_defender_role() {
  var_0 = [[level.bot_gametype_allied_attackers_for_team]](self.team);
  var_1 = [[level.bot_gametype_allied_defenders_for_team]](self.team);
  var_2 = [[level.bot_gametype_attacker_limit_for_team]](self.team);
  var_3 = [[level.bot_gametype_defender_limit_for_team]](self.team);
  var_4 = level.bot_personality_type[self.personality];

  if(var_4 == "active") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level.bot_personality_type[var_7.personality] == "stationary" && var_7 bot_can_switch_to_defender()) {
          var_7.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        bot_gametype_set_role("attacker");
        return;
      }

      bot_gametype_set_role("defender");
      return;
    } else
      bot_gametype_set_role("attacker");
  } else if(var_4 == "stationary") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level.bot_personality_type[var_10.personality] == "active" && var_10 bot_can_switch_to_attacker()) {
          var_10.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        bot_gametype_set_role("defender");
        return;
      }

      bot_gametype_set_role("attacker");
      return;
    } else
      bot_gametype_set_role("defender");
  }
}

bot_gametype_attacker_defender_ai_director_update() {
  level notify("bot_gametype_attacker_defender_ai_director_update");
  level endon("bot_gametype_attacker_defender_ai_director_update");
  level endon("game_ended");
  var_0 = ["allies", "axis"];
  var_1 = gettime() + 2000;

  for (;;) {
    if(gettime() > var_1) {
      var_1 = gettime() + 1000;

      foreach(var_3 in var_0) {
        var_4 = [
          [level.bot_gametype_allied_attackers_for_team]
        ](var_3);
        var_5 = [
          [level.bot_gametype_allied_defenders_for_team]
        ](var_3);
        var_6 = [
          [level.bot_gametype_attacker_limit_for_team]
        ](var_3);
        var_7 = [
          [level.bot_gametype_defender_limit_for_team]
        ](var_3);

        if(var_4.size > var_6) {
          var_8 = [];
          var_9 = 0;

          foreach(var_11 in var_4) {
            if(isai(var_11) && var_11 bot_can_switch_to_defender()) {
              if(level.bot_personality_type[var_11.personality] == "stationary") {
                var_11 bot_gametype_set_role("defender");
                var_9 = 1;
                break;
              } else
                var_8 = common_scripts\utility::array_add(var_8, var_11);
            }
          }

          if(!var_9 && var_8.size > 0)
            common_scripts\utility::random(var_8) bot_gametype_set_role("defender");
        }

        if(var_5.size > var_7) {
          var_13 = [];
          var_14 = 0;

          foreach(var_16 in var_5) {
            if(isai(var_16) && var_16 bot_can_switch_to_attacker()) {
              if(level.bot_personality_type[var_16.personality] == "active") {
                var_16 bot_gametype_set_role("attacker");
                var_14 = 1;
                break;
              } else
                var_13 = common_scripts\utility::array_add(var_13, var_16);
            }
          }

          if(!var_14 && var_13.size > 0)
            common_scripts\utility::random(var_13) bot_gametype_set_role("attacker");
        }
      }
    }

    wait 0.05;
  }
}

bot_can_switch_to_attacker() {
  if(isdefined(level.bot_gametype_allowed_to_switch_to_attacker))
    return self[[level.bot_gametype_allowed_to_switch_to_attacker]]();

  return 1;
}

bot_can_switch_to_defender() {
  if(isdefined(level.bot_gametype_allowed_to_switch_to_defender))
    return self[[level.bot_gametype_allowed_to_switch_to_defender]]();

  return 1;
}

bot_verify_and_cache_bombzones(var_0) {
  var_1 = 0;

  foreach(var_3 in level.bombzones) {}

  if(!var_1)
    bot_cache_entrances_to_bombzones();

  return !var_1;
}

bot_get_valid_nodes_in_trigger(var_0) {
  var_1 = getnodesintrigger(var_0);
  var_1 = bot_add_missing_nodes(var_1, var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!var_4 nodeisdisconnected() && var_4.type != "Begin" && var_4.type != "End")
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

bot_cache_entrances_to_zones(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = 0;
    var_5.entrance_indices = [];
    var_5.zone_bounds = calculate_zone_node_extents(var_5);
    var_5.center_node = zone_get_node_nearest_2d_bounds(var_5, 0, 0);
    var_7 = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];

    foreach(var_9 in var_7) {
      var_10 = zone_get_node_nearest_2d_bounds(var_5, var_9[0], var_9[1]);
      var_1[var_3] = var_10.origin;
      var_11 = var_5.script_label + "_" + var_6;
      var_2[var_3] = var_11;
      var_5.entrance_indices[var_5.entrance_indices.size] = var_11;
      var_3++;
      var_6++;
    }
  }

  bot_cache_entrances(var_1, var_2, 1);
}

calculate_zone_node_extents(var_0) {
  var_1 = spawnstruct();
  var_1.min_pt = (999999, 999999, 999999);
  var_1.max_pt = (-999999, -999999, -999999);

  foreach(var_3 in var_0.nodes) {
    var_1.min_pt = (min(var_3.origin[0], var_1.min_pt[0]), min(var_3.origin[1], var_1.min_pt[1]), min(var_3.origin[2], var_1.min_pt[2]));
    var_1.max_pt = (max(var_3.origin[0], var_1.max_pt[0]), max(var_3.origin[1], var_1.max_pt[1]), max(var_3.origin[2], var_1.max_pt[2]));
  }

  var_1.center = ((var_1.min_pt[0] + var_1.max_pt[0]) / 2, (var_1.min_pt[1] + var_1.max_pt[1]) / 2, (var_1.min_pt[2] + var_1.max_pt[2]) / 2);
  var_1.half_size = (var_1.max_pt[0] - var_1.center[0], var_1.max_pt[1] - var_1.center[1], var_1.max_pt[2] - var_1.center[2]);
  var_1.radius = max(var_1.half_size[0], var_1.half_size[1]);
  return var_1;
}

zone_get_node_nearest_2d_bounds(var_0, var_1, var_2) {
  var_3 = (var_0.zone_bounds.center[0] + var_1 * var_0.zone_bounds.half_size[0], var_0.zone_bounds.center[1] + var_2 * var_0.zone_bounds.half_size[1], 0);
  var_4 = undefined;
  var_5 = 9999999;

  foreach(var_7 in var_0.nodes) {
    var_8 = distance2dsquared(var_7.origin, var_3);

    if(var_8 < var_5) {
      var_5 = var_8;
      var_4 = var_7;
    }
  }

  return var_4;
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = getzonenearest(self.origin);

  for (;;) {
    var_1 = "none";

    if(isdefined(self.gameobject))
      var_1 = self.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

    if(var_1 == "neutral" || var_1 == "none")
      botzonesetteam(var_0, "free");
    else
      botzonesetteam(var_0, var_1);

    wait 1.0;
  }
}

monitor_bombzone_control() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = getzonenearest(self.curorigin);

  for (;;) {
    if(self.bombplantedon)
      var_1 = common_scripts\utility::get_enemy_team(self.ownerteam);
    else
      var_1 = self.ownerteam;

    if(var_1 == "neutral")
      var_1 = "free";

    botzonesetteam(var_0, var_1);
    wait 1.0;
  }
}

find_closest_bombzone_to_player(var_0) {
  var_1 = undefined;
  var_2 = 999999999;

  foreach(var_4 in level.bombzones) {
    var_5 = distancesquared(var_4.curorigin, var_0.origin);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

get_living_players_on_team(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isdefined(var_4.team)) {
      continue;
    }
    if(maps\mp\_utility::isreallyalive(var_4) && maps\mp\_utility::isteamparticipant(var_4) && var_4.team == var_0) {
      if(!isdefined(var_1) || var_1 && isai(var_4) && isdefined(var_4.role))
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

get_bombzone_node_to_plant_on(var_0, var_1) {
  if(var_0.bottargets.size >= 2) {
    if(var_1)
      var_2 = self botnodescoremultiple(var_0.bottargets, "node_exposed");
    else
      var_2 = self botnodescoremultiple(var_0.bottargets, "node_hide_anywhere", "ignore_occupancy");

    var_3 = self botgetdifficultysetting("strategyLevel") * 0.3;
    var_4 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    var_5 = common_scripts\utility::array_randomize(var_0.bottargets);

    foreach(var_7 in var_5) {
      if(!common_scripts\utility::array_contains(var_2, var_7))
        var_2[var_2.size] = var_7;
    }

    if(randomfloat(1.0) < var_3) {
      return var_2[0];
      return;
    }

    if(randomfloat(1.0) < var_4) {
      return var_2[1];
      return;
    }

    return common_scripts\utility::random(var_2);
    return;
    return;
  } else
    return var_0.bottargets[0];
}

get_bombzone_node_to_defuse_on(var_0) {
  var_1 = self botnodescoremultiple(var_0.bottargets, "node_hide_anywhere", "ignore_occupancy");
  var_2 = self botgetdifficultysetting("strategyLevel") * 0.3;
  var_3 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
  var_4 = common_scripts\utility::array_randomize(var_0.bottargets);

  foreach(var_6 in var_4) {
    if(!common_scripts\utility::array_contains(var_1, var_6))
      var_1[var_1.size] = var_6;
  }

  if(randomfloat(1.0) < var_2)
    return var_1[0];
  else if(randomfloat(1.0) < var_3)
    return var_1[1];
  else
    return common_scripts\utility::random(var_1);
}

bombzone_press_use(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1)
    var_4 = 40;
  else if(self botgetdifficultysetting("strategyLevel") >= 2)
    var_4 = 80;

  if(randomint(100) < var_4 && !(isdefined(var_3) && var_3)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var_2) {
    childthread notify_on_whizby();
    childthread notify_on_damage();
  }

  self botpressbutton("use", var_0);
  var_5 = maps\mp\bots\_bots_util::bot_usebutton_wait(var_0, var_1, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  var_6 = var_5 == var_1;
  return var_6;
}

notify_on_whizby() {
  var_0 = find_closest_bombzone_to_player(self);
  self waittill("bulletwhizby", var_1);

  if(!isdefined(var_1.team) || var_1.team != self.team) {
    var_2 = var_0.usetime - var_0.curprogress;

    if(var_2 > 1000)
      self notify("use_interrupted");
  }
}

notify_on_damage() {
  self waittill("damage", var_0, var_1);

  if(!isdefined(var_1.team) || var_1.team != self.team)
    self notify("use_interrupted");
}

get_ai_hearing_bomb_plant_sound(var_0) {
  var_1 = [];
  var_2 = get_living_players_on_team(common_scripts\utility::get_enemy_team(self.team));

  foreach(var_4 in var_2) {
    if(!isai(var_4)) {
      continue;
    }
    var_5 = 0;

    if(var_0 == "plant")
      var_5 = 300 + var_4 botgetdifficultysetting("strategyLevel") * 100;
    else if(var_0 == "defuse")
      var_5 = 500 + var_4 botgetdifficultysetting("strategyLevel") * 500;

    if(distancesquared(var_4.origin, self.origin) < squared(var_5))
      var_1[var_1.size] = var_4;
  }

  return var_1;
}