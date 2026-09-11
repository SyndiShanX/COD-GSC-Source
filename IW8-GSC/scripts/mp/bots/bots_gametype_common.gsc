/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_common.gsc
****************************************************/

function bot_cache_entrances_to_bombzones() {
  var0 = [];
  var1 = [];
  var2 = 0;

  foreach(var4 in level.objectives) {
    var0 = scripts\engine\utility::random(var4.bottargets).origin;
    var1 = "zone" + var4.objectivekey;
    var2++;
  }

  bot_cache_entrances(var0, var1);
}

function bot_cache_entrances_to_gametype_array(var0, var1, var2, var3) {
  wait 1;
  var4 = [];
  var5 = [];
  var6 = 0;

  foreach(var8 in var0) {
    var9 = var8.trigger;

    if(isDefined(var9.bottarget)) {
      var4 = var9.bottarget.origin;
    } else {
      var9.nearest_node = getclosestnodeinsight(var9.origin);

      if(!isDefined(var9.nearest_node) || var9.nearest_node nodeisdisconnected()) {
        var10 = getnodesinradiussorted(var9.origin, 256, 0);

        if(var10.size > 0) {
          var9.nearest_node = var10[0];
        }
      }

      if(!isDefined(var9.nearest_node)) {
        continue;
      }

      if(distance(var9.nearest_node.origin, var9.origin) > 130) {
        var9.nearest_node = undefined;
        continue;
      }

      var4 = var9.nearest_node.origin;
    }

    var5 = var1 + var8.objectivekey;
    var6++;
  }

  bot_cache_entrances(var4, var5, var2, var3);
}

function bot_cache_entrances(var0, var1, var2, var3) {
  var4 = !isDefined(var2) || !var2;
  var5 = isDefined(var3) && var3;
  wait 0.1;

  if(var5 && var4) {
    var6 = getallnodes();

    foreach(var8 in var6) {
      var8.on_path_from = undefined;
    }
  }

  var10 = [];

  for(var11 = 0; var11 < var0.size; var11++) {
    var12 = var1[var11];
    var10 = findentrances(var0[var11]);
    wait 0.05;

    for(var13 = 0; var13 < var10[var12].size; var13++) {
      var14 = var10[var12][var13];
      var14.is_precalculated_entrance = 1;
      var14.prone_visible_from[var12] = scripts\mp\bots\bots_util::entrance_visible_from(var14.origin, var0[var11], "prone");
      wait 0.05;
      var14.crouch_visible_from[var12] = scripts\mp\bots\bots_util::entrance_visible_from(var14.origin, var0[var11], "crouch");
      wait 0.05;
    }
  }

  var15 = [];

  if(var4) {
    for(var11 = 0; var11 < var0.size; var11++) {
      for(var13 = var11 + 1; var13 < var0.size; var13++) {
        var16 = scripts\mp\bots\bots_util::get_extended_path(var0[var11], var0[var13]);

        foreach(var8 in var16) {
          var8.on_path_from[var1[var11]][var1[var13]] = 1;
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

  if(var5) {
    level.entrance_origin_points = var0;
    level.entrance_indices = var1;
    level.entrance_points = var10;
  } else {
    level.entrance_origin_points = scripts\engine\utility::array_combine(level.entrance_origin_points, var0);
    level.entrance_indices = scripts\engine\utility::array_combine(level.entrance_indices, var1);
    level.entrance_points = scripts\engine\utility::array_combine_non_integer_indices(level.entrance_points, var10);
  }

  level.entrance_points_finished_caching = 1;
}

function bot_add_missing_nodes(var0, var1) {
  if(var1.classname == "trigger_radius") {
    var2 = getnodesinradius(var1.origin, var1.radius, 0, 100);
    var3 = scripts\engine\utility::array_remove_array(var2, var0);

    if(var3.size > 0) {
      var0 = scripts\engine\utility::array_combine(var0, var3);
    }
  } else if(var1.classname == "trigger_multiple" || var1.classname == "trigger_use_touch") {
    GscBinSkip1(0x45, 0, var1 getpointinbounds(1, 1, 1));
  }

  return var0;
}

function bot_setup_objective_bottargets() {
  wait 1;
  bot_setup_bot_targets(level.objectives);
  level.bot_set_objective_bottargets = 1;
}

function bot_setup_bot_targets(var0) {
  foreach(var2 in var0) {
    if(!isDefined(var2.bottargets)) {
      var2.bottargets = bot_get_valid_nodes_in_trigger(var2.trigger);
    }
  }
}

function damagedisabledfeedback(var0) {
  var1 = 0;

  foreach(var3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var3) && isDefined(var3.team) && var3.team == var0) {
      var1++;
    }
  }

  return var1;
}

function damageby(var0, var1, var2) {
  var3 = damageendtime("attacker", var0);

  foreach(var5 in level.players) {
    if(!isai(var5) && isDefined(var5.team) && var5.team == var0) {
      if(damagefactorhigh(var5) || distancesquared(var1, var5.origin) > squared(var2)) {
        var3 = scripts\engine\utility::array_add(var3, var5);
      }
    }
  }

  return var3;
}

function damageclonewatch(var0, var1, var2) {
  var3 = damageendtime("defender", var0);

  foreach(var5 in level.players) {
    if(!isai(var5) && isDefined(var5.team) && var5.team == var0) {
      if(damagefactorlow(var5) || distancesquared(var1, var5.origin) <= squared(var2)) {
        var3 = scripts\engine\utility::array_add(var3, var5);
      }
    }
  }

  return var3;
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

function damagepercentlow(var0) {
  self.role = var0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

function damageendtime(var0, var1) {
  var2 = [];

  foreach(var4 in level.participants) {
    if(isDefined(var4.team) && isalive(var4) && scripts\mp\utility\entity::isteamparticipant(var4) && var4.team == var1 && isDefined(var4.role) && var4.role == var0) {
      var2 = var4;
    }
  }

  return var2;
}

function damagepercent() {
  var0 = [[level.damage_players_on_blades]](self.team);
  var1 = [[level.damage_players_on_bottom]](self.team);
  var2 = [[level.damage_stage_final_watcher]](self.team);
  var3 = [[level.damage_taken]](self.team);
  var4 = level.bot_personality_type[self.personality];

  if(var4 == "active") {
    if(var0.size >= var2) {
      var5 = 0;

      foreach(var7 in var0) {
        if(isai(var7) && level.bot_personality_type[var7.personality] == "stationary" && custom_death_active(var7)) {
          var7.role = undefined;
          var5 = 1;
          break;
        }
      }

      if(var5) {
        damagepercentlow("attacker");
        return;
      }

      damagepercentlow("defender");
      return;
    }

    damagepercentlow("attacker");
    return;
  }

  if(var4 == "stationary") {
    if(var1.size >= var3) {
      var5 = 0;

      foreach(var10 in var1) {
        if(isai(var10) && level.bot_personality_type[var10.personality] == "active" && custom_damageshield_cooldown(var10)) {
          var10.role = undefined;
          var5 = 1;
          break;
        }
      }

      if(var5) {
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
  var0 = ["allies", "axis"];
  var1 = gettime() + 2000;

  for(;;) {
    if(gettime() > var1) {
      var1 = gettime() + 1000;

      foreach(var3 in var0) {
        var4 = [[level.damage_players_on_blades]](var3);
        var5 = [[level.damage_players_on_bottom]](var3);
        var6 = [[level.damage_stage_final_watcher]](var3);
        var7 = [[level.damage_taken]](var3);

        if(var4.size > var6) {
          var8 = [];
          var9 = 0;

          foreach(var11 in var4) {
            if(isai(var11) && custom_death_active(var11)) {
              if(level.bot_personality_type[var11.personality] == "stationary") {
                damagepercentlow(var11, "defender");
                var9 = 1;
                break;
              }

              var8 = scripts\engine\utility::array_add(var8, var11);
            }
          }

          if(!var9 && var8.size > 0) {
            damagepercentlow(scripts\engine\utility::random(var8), "defender");
          }
        }

        if(var5.size > var7) {
          var13 = [];
          var14 = 0;

          foreach(var16 in var5) {
            if(isai(var16) && custom_damageshield_cooldown(var16)) {
              if(level.bot_personality_type[var16.personality] == "active") {
                damagepercentlow(var16, "attacker");
                var14 = 1;
                break;
              }

              var13 = scripts\engine\utility::array_add(var13, var16);
            }
          }

          if(!var14 && var13.size > 0) {
            damagepercentlow(scripts\engine\utility::random(var13), "attacker");
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

function debug_consoles(var0) {
  var1 = 0;

  foreach(var3 in level.objectives) {}

  if(!var1) {
    bot_cache_entrances_to_bombzones();
  }

  return !var1;
}

function bot_get_valid_nodes_in_trigger(var0) {
  var1 = getnodesintrigger(var0, 1);
  var2 = [];

  foreach(var4 in var1) {
    if(!var4 nodeisdisconnected() && !scripts\engine\utility::isnode3d(var4) && var4.type != "Begin" && var4.type != "End") {
      var2 = var4;
    }
  }

  return var2;
}

function custom_damageshield(var0) {
  var1 = [];
  var2 = [];
  var3 = 0;

  foreach(var5 in var0) {
    var6 = 0;
    var5.entrance_indices = [];
    var5.ref_14713 = forcejumpnearobjective(var5);
    var5.get_wave_targetname = ref_14717(var5, 0, 0);
    var7 = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];

    foreach(var9 in var7) {
      var10 = ref_14717(var5, var9[0], var9[1]);
      var1 = var10.origin;
      var11 = var5.objectivekey + "_" + var6;
      var2 = var11;
      var5.entrance_indices[var5.entrance_indices.size] = var11;
      var3++;
      var6++;
    }
  }

  bot_cache_entrances(var1, var2, 1);
}

function forcejumpnearobjective(var0) {
  var1 = spawnStruct();
  var1.ref_11bed = (999999, 999999, 999999);
  var1.ref_11b4b = (-999999, -999999, -999999);

  foreach(var3 in var0.nodes) {
    var1.ref_11bed = (min(var3.origin[0], var1.ref_11bed[0]), min(var3.origin[1], var1.ref_11bed[1]), min(var3.origin[2], var1.ref_11bed[2]));
    var1.ref_11b4b = (max(var3.origin[0], var1.ref_11b4b[0]), max(var3.origin[1], var1.ref_11b4b[1]), max(var3.origin[2], var1.ref_11b4b[2]));
  }

  var1.center = ((var1.ref_11bed[0] + var1.ref_11b4b[0]) / 2, (var1.ref_11bed[1] + var1.ref_11b4b[1]) / 2, (var1.ref_11bed[2] + var1.ref_11b4b[2]) / 2);
  var1.setplacementxpshare = (var1.ref_11b4b[0] - var1.center[0], var1.ref_11b4b[1] - var1.center[1], var1.ref_11b4b[2] - var1.center[2]);
  var1.radius = max(var1.setplacementxpshare[0], var1.setplacementxpshare[1]);
  return var1;
}

function ref_14717(var0, var1, var2) {
  var3 = (var0.ref_14713.center[0] + var1 * var0.ref_14713.setplacementxpshare[0], var0.ref_14713.center[1] + var2 * var0.ref_14713.setplacementxpshare[1], 0);
  var4 = undefined;
  var5 = 9999999;

  foreach(var7 in var0.nodes) {
    var8 = distance2dsquared(var7.origin, var3);

    if(var8 < var5) {
      var5 = var8;
      var4 = var7;
    }
  }

  return var4;
}

function monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  var0 = self.origin;

  if(!isDefined(var0)) {
    var0 = self.curorigin;
  }

  var1 = getzonenearest(var0);

  for(;;) {
    var2 = "none";

    if(isDefined(self.gameobject)) {
      var2 = self.gameobject scripts\mp\gameobjects::getownerteam();
    }

    if(var2 == "neutral" || var2 == "none") {
      botzonesetteam(var1, "free");
    } else {
      botzonesetteam(var1, var2);
    }

    wait 1;
  }
}

function monitor_bombzone_control() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  var0 = getzonenearest(self.curorigin);

  for(;;) {
    if(self.bombplanted) {
      var1 = scripts\engine\utility::get_enemy_team(self.ownerteam);
    } else {
      var1 = self.ownerteam;
    }

    if(var1 == "neutral" || var1 == "any") {
      var1 = "free";
    }

    botzonesetteam(var0, var1);
    wait 1;
  }
}

function find_closest_bombzone_to_player(var0) {
  var1 = undefined;
  var2 = 999999999;

  foreach(var4 in level.objectives) {
    var5 = distancesquared(var4.curorigin, var0.origin);

    if(var5 < var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  return var1;
}

function get_living_players_on_team(var0, var1) {
  var2 = [];

  foreach(var4 in level.participants) {
    if(!isDefined(var4.team)) {
      continue;
    }

    if(scripts\mp\utility\player::isreallyalive(var4) && scripts\mp\utility\entity::isteamparticipant(var4) && var4.team == var0) {
      if(!isDefined(var1) || var1 && isai(var4) && isDefined(var4.role)) {
        var2 = var4;
      }
    }
  }

  return var2;
}

function process_should_do_pain(var0, var1) {
  if(var0.bottargets.size >= 2) {
    if(var1) {
      var2 = self botnodescoremultiple(var0.bottargets, "node_exposed");
    } else {
      var2 = self botnodescoremultiple(var1.bottargets, "node_hide_anywhere", "ignore_occupancy");
    }

    var3 = self botgetdifficultysetting("strategyLevel") * 0.3;
    var4 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    var5 = scripts\engine\utility::array_randomize(var1.bottargets);

    foreach(var7 in var5) {
      if(!scripts\engine\utility::array_contains(var2, var7)) {
        var2 = var7;
      }
    }

    if(randomfloat(1) < var3) {
      return var2[0];
    }

    if(randomfloat(1) < var4) {
      return var2[1];
    }

    return scripts\engine\utility::random(var2);
  }

  return var1.bottargets[0];
}

function process_players_inside_subway_car(var0) {
  var1 = self botnodescoremultiple(var0.bottargets, "node_hide_anywhere", "ignore_occupancy");
  var2 = self botgetdifficultysetting("strategyLevel") * 0.3;
  var3 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
  var4 = scripts\engine\utility::array_randomize(var0.bottargets);

  foreach(var6 in var4) {
    if(!scripts\engine\utility::array_contains(var1, var6)) {
      var1 = var6;
    }
  }

  if(randomfloat(1) < var2) {
    return var1[0];
  }

  if(randomfloat(1) < var3) {
    return var1[1];
  }

  return scripts\engine\utility::random(var1);
}

function current_respawn_point_override(var0, var1, var2, var3) {
  var4 = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var4 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var4 = 80;
  }

  if(randomint(100) < var4 && !(isDefined(var3) && var3)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var2) {
    GscBinSkip4(0x35);
  }

  self botpressbutton("use", var0);
  var5 = scripts\mp\bots\bots_util::bot_usebutton_wait(var0, var1, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  var6 = var5 == var1;
  return var6;
}

function ref_11ec7() {
  self endon("stop_usebutton_watcher");
  var0 = find_closest_bombzone_to_player(self);
  self waittill("bulletwhizby", var1);

  if(!isDefined(var1.team) || var1.team != self.team) {
    var2 = var0.usetime - var0.curprogress;

    if(var2 > 1000) {
      self notify("use_interrupted");
      return;
    }

    return;
  }
}

function ref_11ec6() {
  self endon("stop_usebutton_watcher");
  self waittill("damage", var0, var1);

  if(!isDefined(var1.team) || var1.team != self.team) {
    self notify("use_interrupted");
    return;
  }
}

function prematchinitx1blueprintloadouts(var0) {
  var1 = [];

  if(!istrue(level.silentplant)) {
    var2 = get_living_players_on_team(scripts\engine\utility::get_enemy_team(self.team));

    foreach(var4 in var2) {
      if(!isai(var4)) {
        continue;
      }

      var5 = 0;

      if(var0 == "plant") {
        var5 = 300 + var4 botgetdifficultysetting("strategyLevel") * 100;
      } else if(var0 == "defuse") {
        var5 = 500 + var4 botgetdifficultysetting("strategyLevel") * 500;
      }

      if(distancesquared(var4.origin, self.origin) < squared(var5)) {
        var1 = var4;
      }
    }
  }

  return var1;
}