/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_common.gsc
****************************************************/

function bot_cache_entrances_to_bombzones() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.objectives) {
    var_0 = scripts\engine\utility::random(var_4.bottargets).origin;
    var_1 = "zone" + var_4.objectivekey;
    var_2++;
  }

  bot_cache_entrances(var_0, var_1);
}

function bot_cache_entrances_to_gametype_array(var_0, var_1, var_2, var_3) {
  wait 1;
  var_4 = [];
  var_5 = [];
  var_6 = 0;

  foreach(var_8 in var_0) {
    var_9 = var_8.trigger;

    if(isDefined(var_9.bottarget)) {
      var_4 = var_9.bottarget.origin;
    } else {
      var_9.nearest_node = getclosestnodeinsight(var_9.origin);

      if(!isDefined(var_9.nearest_node) || var_9.nearest_node nodeisdisconnected()) {
        var_10 = getnodesinradiussorted(var_9.origin, 256, 0);

        if(var_10.size > 0) {
          var_9.nearest_node = var_10[0];
        }
      }

      if(!isDefined(var_9.nearest_node)) {
        continue;
      }

      if(distance(var_9.nearest_node.origin, var_9.origin) > 130) {
        var_9.nearest_node = undefined;
        continue;
      }

      var_4 = var_9.nearest_node.origin;
    }

    var_5 = var_1 + var_8.objectivekey;
    var_6++;
  }

  bot_cache_entrances(var_4, var_5, var_2, var_3);
}

function bot_cache_entrances(var_0, var_1, var_2, var_3) {
  var_4 = !isDefined(var_2) || !var_2;
  var_5 = isDefined(var_3) && var_3;
  wait 0.1;

  if(var_5 && var_4) {
    var_6 = getallnodes();

    foreach(var_8 in var_6) {
      var_8.on_path_from = undefined;
    }
  }

  var_10 = [];

  for(var_11 = 0; var_11 < var_0.size; var_11++) {
    var_12 = var_1[var_11];
    var_10 = findentrances(var_0[var_11]);
    wait 0.05;

    for(var_13 = 0; var_13 < var_10[var_12].size; var_13++) {
      var_14 = var_10[var_12][var_13];
      var_14.is_precalculated_entrance = 1;
      var_14.prone_visible_from[var_12] = scripts\mp\bots\bots_util::entrance_visible_from(var_14.origin, var_0[var_11], "prone");
      wait 0.05;
      var_14.crouch_visible_from[var_12] = scripts\mp\bots\bots_util::entrance_visible_from(var_14.origin, var_0[var_11], "crouch");
      wait 0.05;
    }
  }

  var_15 = [];

  if(var_4) {
    for(var_11 = 0; var_11 < var_0.size; var_11++) {
      for(var_13 = var_11 + 1; var_13 < var_0.size; var_13++) {
        var_16 = scripts\mp\bots\bots_util::get_extended_path(var_0[var_11], var_0[var_13]);

        foreach(var_8 in var_16) {
          var_8.on_path_from[var_1[var_11]][var_1[var_13]] = 1;
        }
      }
    }
  }

  if(!isDefined(level.entrance_origin_points)) {
    level.entrance_origin_points = [];
  }

  if(!isDefined(level.entrance_indices)) {
    level.entrance_indices = [];
  }

  if(!isDefined(level.entrance_points)) {
    level.entrance_points = [];
  }

  if(var_5) {
    level.entrance_origin_points = var_0;
    level.entrance_indices = var_1;
    level.entrance_points = var_10;
  } else {
    level.entrance_origin_points = scripts\engine\utility::array_combine(level.entrance_origin_points, var_0);
    level.entrance_indices = scripts\engine\utility::array_combine(level.entrance_indices, var_1);
    level.entrance_points = scripts\engine\utility::array_combine_non_integer_indices(level.entrance_points, var_10);
  }

  level.entrance_points_finished_caching = 1;
}

function bot_add_missing_nodes(var_0, var_1) {
  if(var_1.classname == "trigger_radius") {
    var_2 = getnodesinradius(var_1.origin, var_1.radius, 0, 100);
    var_3 = scripts\engine\utility::array_remove_array(var_2, var_0);

    if(var_3.size > 0) {
      var_0 = scripts\engine\utility::array_combine(var_0, var_3);
    }
  } else if(var_1.classname == "trigger_multiple" || var_1.classname == "trigger_use_touch") {
    GscBinSkip1(0x45, 0, var_1 getpointinbounds(1, 1, 1));
  }

  return var_0;
}

function bot_setup_objective_bottargets() {
  wait 1;
  bot_setup_bot_targets(level.objectives);
  level.bot_set_objective_bottargets = 1;
}

function bot_setup_bot_targets(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.bottargets)) {
      var_2.bottargets = bot_get_valid_nodes_in_trigger(var_2.trigger);
    }
  }
}

function damagedisabledfeedback(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function damageby(var_0, var_1, var_2) {
  var_3 = damageendtime("attacker", var_0);

  foreach(var_5 in level.players) {
    if(!isai(var_5) && isDefined(var_5.team) && var_5.team == var_0) {
      if(damagefactorhigh(var_5) || distancesquared(var_1, var_5.origin) > squared(var_2)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  return var_3;
}

function damageclonewatch(var_0, var_1, var_2) {
  var_3 = damageendtime("defender", var_0);

  foreach(var_5 in level.players) {
    if(!isai(var_5) && isDefined(var_5.team) && var_5.team == var_0) {
      if(damagefactorlow(var_5) || distancesquared(var_1, var_5.origin) <= squared(var_2)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  return var_3;
}

function damagefactorhigh() {
  if(isDefined(level.damagefactor)) {
    return self[[level.damagefactor]]();
  }

  return 0;
}

function damagefactorlow() {
  if(isDefined(level.damagefactormedium)) {
    return self[[level.damagefactormedium]]();
  }

  return 0;
}

function damagepercentlow(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

function damageendtime(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(isDefined(var_4.team) && isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && var_4.team == var_1 && isDefined(var_4.role) && var_4.role == var_0) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function damagepercent() {
  var_0 = [[level.damage_players_on_blades]](self.team);
  var_1 = [[level.damage_players_on_bottom]](self.team);
  var_2 = [[level.damage_stage_final_watcher]](self.team);
  var_3 = [[level.damage_taken]](self.team);
  var_4 = level.bot_personality_type[self.personality];

  if(var_4 == "active") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level.bot_personality_type[var_7.personality] == "stationary" && custom_death_active(var_7)) {
          var_7.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        damagepercentlow("attacker");
        return;
      }

      damagepercentlow("defender");
      return;
    }

    damagepercentlow("attacker");
    return;
  }

  if(var_4 == "stationary") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level.bot_personality_type[var_10.personality] == "active" && custom_damageshield_cooldown(var_10)) {
          var_10.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        damagepercentlow("defender");
        return;
      }

      damagepercentlow("attacker");
      return;
    }

    damagepercentlow("defender");
    return;
  }
}

function damage_shield_reduction() {
  level notify("bot_gametype_attacker_defender_ai_director_update");
  level endon("bot_gametype_attacker_defender_ai_director_update");
  level endon("game_ended");
  var_0 = ["allies", "axis"];
  var_1 = gettime() + 2000;

  for(;;) {
    if(gettime() > var_1) {
      var_1 = gettime() + 1000;

      foreach(var_3 in var_0) {
        var_4 = [[level.damage_players_on_blades]](var_3);
        var_5 = [[level.damage_players_on_bottom]](var_3);
        var_6 = [[level.damage_stage_final_watcher]](var_3);
        var_7 = [[level.damage_taken]](var_3);

        if(var_4.size > var_6) {
          var_8 = [];
          var_9 = 0;

          foreach(var_11 in var_4) {
            if(isai(var_11) && custom_death_active(var_11)) {
              if(level.bot_personality_type[var_11.personality] == "stationary") {
                damagepercentlow(var_11, "defender");
                var_9 = 1;
                break;
              }

              var_8 = scripts\engine\utility::array_add(var_8, var_11);
            }
          }

          if(!var_9 && var_8.size > 0) {
            damagepercentlow(scripts\engine\utility::random(var_8), "defender");
          }
        }

        if(var_5.size > var_7) {
          var_13 = [];
          var_14 = 0;

          foreach(var_16 in var_5) {
            if(isai(var_16) && custom_damageshield_cooldown(var_16)) {
              if(level.bot_personality_type[var_16.personality] == "active") {
                damagepercentlow(var_16, "attacker");
                var_14 = 1;
                break;
              }

              var_13 = scripts\engine\utility::array_add(var_13, var_16);
            }
          }

          if(!var_14 && var_13.size > 0) {
            damagepercentlow(scripts\engine\utility::random(var_13), "attacker");
          }
        }
      }
    }

    wait 0.05;
  }
}

function custom_damageshield_cooldown() {
  if(isDefined(level.damage_players_on_top)) {
    return self[[level.damage_players_on_top]]();
  }

  return 1;
}

function custom_death_active() {
  if(isDefined(level.damage_players_when_enter_trigger)) {
    return self[[level.damage_players_when_enter_trigger]]();
  }

  return 1;
}

function debug_consoles(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {}

  if(!var_1) {
    bot_cache_entrances_to_bombzones();
  }

  return !var_1;
}

function bot_get_valid_nodes_in_trigger(var_0) {
  var_1 = getnodesintrigger(var_0, 1);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!var_4 nodeisdisconnected() && !scripts\engine\utility::isnode3d(var_4) && var_4.type != "Begin" && var_4.type != "End") {
      var_2 = var_4;
    }
  }

  return var_2;
}

function custom_damageshield(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = 0;
    var_5.entrance_indices = [];
    var_5.ref_14713 = forcejumpnearobjective(var_5);
    var_5.get_wave_targetname = ref_14717(var_5, 0, 0);
    var_7 = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];

    foreach(var_9 in var_7) {
      var_10 = ref_14717(var_5, var_9[0], var_9[1]);
      var_1 = var_10.origin;
      var_11 = var_5.objectivekey + "_" + var_6;
      var_2 = var_11;
      var_5.entrance_indices[var_5.entrance_indices.size] = var_11;
      var_3++;
      var_6++;
    }
  }

  bot_cache_entrances(var_1, var_2, 1);
}

function forcejumpnearobjective(var_0) {
  var_1 = spawnStruct();
  var_1.ref_11BED = (999999, 999999, 999999);
  var_1.ref_11B4B = (-999999, -999999, -999999);

  foreach(var_3 in var_0.nodes) {
    var_1.ref_11BED = (min(var_3.origin[0], var_1.ref_11BED[0]), min(var_3.origin[1], var_1.ref_11BED[1]), min(var_3.origin[2], var_1.ref_11BED[2]));
    var_1.ref_11B4B = (max(var_3.origin[0], var_1.ref_11B4B[0]), max(var_3.origin[1], var_1.ref_11B4B[1]), max(var_3.origin[2], var_1.ref_11B4B[2]));
  }

  var_1.center = ((var_1.ref_11BED[0] + var_1.ref_11B4B[0]) / 2, (var_1.ref_11BED[1] + var_1.ref_11B4B[1]) / 2, (var_1.ref_11BED[2] + var_1.ref_11B4B[2]) / 2);
  var_1.setplacementxpshare = (var_1.ref_11B4B[0] - var_1.center[0], var_1.ref_11B4B[1] - var_1.center[1], var_1.ref_11B4B[2] - var_1.center[2]);
  var_1.radius = max(var_1.setplacementxpshare[0], var_1.setplacementxpshare[1]);
  return var_1;
}

function ref_14717(var_0, var_1, var_2) {
  var_3 = (var_0.ref_14713.center[0] + var_1 * var_0.ref_14713.setplacementxpshare[0], var_0.ref_14713.center[1] + var_2 * var_0.ref_14713.setplacementxpshare[1], 0);
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

function monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = self.origin;

  if(!isDefined(var_0)) {
    var_0 = self.curorigin;
  }

  var_1 = getzonenearest(var_0);

  for(;;) {
    var_2 = "none";

    if(isDefined(self.gameobject)) {
      var_2 = self.gameobject scripts\mp\gameobjects::getownerteam();
    }

    if(var_2 == "neutral" || var_2 == "none") {
      botzonesetteam(var_1, "free");
    } else {
      botzonesetteam(var_1, var_2);
    }

    wait 1;
  }
}

function monitor_bombzone_control() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = getzonenearest(self.curorigin);

  for(;;) {
    if(self.bombplanted) {
      var_1 = scripts\engine\utility::get_enemy_team(self.ownerteam);
    } else {
      var_1 = self.ownerteam;
    }

    if(var_1 == "neutral" || var_1 == "any") {
      var_1 = "free";
    }

    botzonesetteam(var_0, var_1);
    wait 1;
  }
}

function find_closest_bombzone_to_player(var_0) {
  var_1 = undefined;
  var_2 = 999999999;

  foreach(var_4 in level.objectives) {
    var_5 = distancesquared(var_4.curorigin, var_0.origin);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

function get_living_players_on_team(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(scripts\mp\utility\player::isreallyalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && var_4.team == var_0) {
      if(!isDefined(var_1) || var_1 && isai(var_4) && isDefined(var_4.role)) {
        var_2 = var_4;
      }
    }
  }

  return var_2;
}

function process_should_do_pain(var_0, var_1) {
  if(var_0.bottargets.size >= 2) {
    if(var_1) {
      var_2 = self botnodescoremultiple(var_0.bottargets, "node_exposed");
    } else {
      var_2 = self botnodescoremultiple(var_1.bottargets, "node_hide_anywhere", "ignore_occupancy");
    }

    var_3 = self botgetdifficultysetting("strategyLevel") * 0.3;
    var_4 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    var_5 = scripts\engine\utility::array_randomize(var_1.bottargets);

    foreach(var_7 in var_5) {
      if(!scripts\engine\utility::array_contains(var_2, var_7)) {
        var_2 = var_7;
      }
    }

    if(randomfloat(1) < var_3) {
      return var_2[0];
    }

    if(randomfloat(1) < var_4) {
      return var_2[1];
    }

    return scripts\engine\utility::random(var_2);
  }

  return var_1.bottargets[0];
}

function process_players_inside_subway_car(var_0) {
  var_1 = self botnodescoremultiple(var_0.bottargets, "node_hide_anywhere", "ignore_occupancy");
  var_2 = self botgetdifficultysetting("strategyLevel") * 0.3;
  var_3 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
  var_4 = scripts\engine\utility::array_randomize(var_0.bottargets);

  foreach(var_6 in var_4) {
    if(!scripts\engine\utility::array_contains(var_1, var_6)) {
      var_1 = var_6;
    }
  }

  if(randomfloat(1) < var_2) {
    return var_1[0];
  }

  if(randomfloat(1) < var_3) {
    return var_1[1];
  }

  return scripts\engine\utility::random(var_1);
}

function current_respawn_point_override(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_4 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_4 = 80;
  }

  if(randomint(100) < var_4 && !(isDefined(var_3) && var_3)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var_2) {
    GscBinSkip4(0x35);
  }

  self botpressbutton("use", var_0);
  var_5 = scripts\mp\bots\bots_util::bot_usebutton_wait(var_0, var_1, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  var_6 = var_5 == var_1;
  return var_6;
}

function ref_11EC7() {
  self endon("stop_usebutton_watcher");
  var_0 = find_closest_bombzone_to_player(self);
  self waittill("bulletwhizby", var_1);

  if(!isDefined(var_1.team) || var_1.team != self.team) {
    var_2 = var_0.usetime - var_0.curprogress;

    if(var_2 > 1000) {
      self notify("use_interrupted");
      return;
    }

    return;
  }
}

function ref_11EC6() {
  self endon("stop_usebutton_watcher");
  self waittill("damage", var_0, var_1);

  if(!isDefined(var_1.team) || var_1.team != self.team) {
    self notify("use_interrupted");
    return;
  }
}

function prematchinitx1blueprintloadouts(var_0) {
  var_1 = [];

  if(!istrue(level.silentplant)) {
    var_2 = get_living_players_on_team(scripts\engine\utility::get_enemy_team(self.team));

    foreach(var_4 in var_2) {
      if(!isai(var_4)) {
        continue;
      }

      var_5 = 0;

      if(var_0 == "plant") {
        var_5 = 300 + var_4 botgetdifficultysetting("strategyLevel") * 100;
      } else if(var_0 == "defuse") {
        var_5 = 500 + var_4 botgetdifficultysetting("strategyLevel") * 500;
      }

      if(distancesquared(var_4.origin, self.origin) < squared(var_5)) {
        var_1 = var_4;
      }
    }
  }

  return var_1;
}