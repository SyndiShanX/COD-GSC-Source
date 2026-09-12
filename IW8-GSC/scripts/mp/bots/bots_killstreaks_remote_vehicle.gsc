/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_killstreaks_remote_vehicle.gsc
***************************************************************/

function remote_vehicle_setup() {
  while(!isDefined(level.bot_variables_initialized)) {
    wait 0.05;
  }

  if(isDefined(level.bot_initialized_remote_vehicles)) {
    return;
  }

  level.bot_ks_heli_offset["heli_pilot"] = (0, 0, 350);
  level.bot_ks_heli_offset["heli_sniper"] = (0, 0, 228);
  level.bot_ks_funcs["isUsing"]["odin_assault"] = &scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["odin_support"] = &scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["heli_pilot"] = &scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["switchblade_cluster"] = &scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["vanguard"] = &isusingvanguard;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_pilot"] = &heli_pilot_waittill_initial_goal;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_sniper"] = &heli_sniper_waittill_initial_goal;
  level.bot_ks_funcs["control_aiming"]["heli_pilot"] = &heli_pilot_control_heli_aiming;
  level.bot_ks_funcs["control_aiming"]["heli_sniper"] = &scripts\engine\utility::empty_init_func;
  level.bot_ks_funcs["control_aiming"]["vanguard"] = &vanguard_control_aiming;
  level.bot_ks_funcs["control_other"]["heli_pilot"] = &heli_pilot_monitor_flares;
  level.bot_ks_funcs["heli_pick_node"]["heli_pilot"] = &heli_pilot_pick_node;
  level.bot_ks_funcs["heli_pick_node"]["heli_sniper"] = &heli_sniper_pick_node;
  level.bot_ks_funcs["heli_pick_node"]["vanguard"] = &vanguard_pick_node;
  level.bot_ks_funcs["heli_node_get_origin"]["heli_pilot"] = &heli_get_node_origin;
  level.bot_ks_funcs["heli_node_get_origin"]["heli_sniper"] = &heli_get_node_origin;
  level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] = &vanguard_get_node_origin;
  level.bot_ks_funcs["odin_perform_action"]["odin_assault"] = &odin_assault_perform_action;
  level.bot_ks_funcs["odin_perform_action"]["odin_support"] = &odin_support_perform_action;
  level.bot_ks_funcs["odin_get_target"]["odin_assault"] = &odin_assault_get_target;
  level.bot_ks_funcs["odin_get_target"]["odin_support"] = &odin_support_get_target;
  var_0 = scripts\engine\utility::getStructArray("so_chopper_boss_path_struct", "script_noteworthy");
  level.bot_heli_nodes = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_linkname)) {
      level.bot_heli_nodes = scripts\engine\utility::array_add(level.bot_heli_nodes, var_2);
    }
  }

  level.bot_heli_pilot_traceoffset = scripts\mp\utility\killstreak::gethelipilottraceoffset();

  foreach(var_5 in level.bot_heli_nodes) {
    var_5.vanguard_origin = var_5.origin;
    var_6 = var_5.origin + (0, 0, 50);
    var_5.valid_for_vanguard = 1;

    if(var_6[2] <= var_5.origin[2] - 1000) {
      var_5.valid_for_vanguard = 0;
    }

    var_6 -= (0, 0, 50);
    var_5.vanguard_origin = var_6;
  }

  var_8 = -99999999;

  foreach(var_5 in level.bot_heli_nodes) {
    var_8 = max(var_8, var_5.origin[2]);
  }

  level.bot_vanguard_height_trace_size = var_8 - level.bot_map_min_z + 100;
  level.heli_pilot_missile_radius = getdvarfloat("bg_bulletExplRadius");

  while(!isDefined(level.odin_marking_flash_radius_max) || !isDefined(level.odin_marking_flash_radius_min)) {
    wait 0.05;
  }

  level.odin_flash_radius = (level.odin_marking_flash_radius_max + level.odin_marking_flash_radius_min) / 2;
  level.outside_zones = [];

  if(isDefined(level.teleportgetactivepathnodezonesfunc)) {
    var_11 = [[level.teleportgetactivepathnodezonesfunc]]();
  } else {
    var_11 = [];

    for(var_12 = 0; var_12 < level.zonecount; var_12++) {
      var_11 = var_12;
    }
  }

  foreach(var_14 in var_11) {
    if(botzonegetindoorpercent(var_14) < 0.25) {
      level.outside_zones = scripts\engine\utility::array_add(level.outside_zones, var_14);
    }
  }

  level.bot_odin_time_to_move["recruit"] = 1;
  level.bot_odin_time_to_move["regular"] = 0.7;
  level.bot_odin_time_to_move["hardened"] = 0.4;
  level.bot_odin_time_to_move["veteran"] = 0.05;
  level.bot_initialized_remote_vehicles = 1;
}

function bot_killstreak_remote_control(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    return false;
  }

  var_5 = 1;
  var_6 = 1;
  var_7 = undefined;

  if(isDefined(self.node_ambushing_from)) {
    var_8 = self botgetscriptgoalRadius();
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
              var_11 = scripts\engine\utility::array_add(var_11, var_14);
            }
          }
        }
      }

      if(var_10) {
        var_21 = self botnodescoremultiple(var_11, "node_exposed");

        foreach(var_14 in var_21) {
          if(scripts\engine\trace::_bullet_trace_passed(var_14.origin + (0, 0, 30), var_14.origin + (0, 0, 400), 0, self)) {
            var_7 = var_14;
            break;
          }

          wait 0.05;
        }
      } else if(var_11.size > 0) {
        var_7 = self botnodepick(var_11, min(3, var_11.size), "node_hide");
      }

      if(!isDefined(var_7)) {
        return false;
      }

      self botsetscriptgoalnode(var_7, "tactical");
    }
  }

  if(var_6) {
    var_24 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

    if(var_24 != "goal") {
      try_clear_hide_goal(var_7);
      return true;
    }
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    try_clear_hide_goal(var_7);
    return false;
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    try_clear_hide_goal(var_7);
    return true;
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

  scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  self.vehicle_controlling = undefined;
  self thread[[var_3]]();
  thread bot_end_control_on_respawn();
  thread bot_end_control_watcher(var_7);
  self waittill("control_func_done");
  return true;
}

function bot_end_control_on_respawn() {
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self waittill("spawned_player");
  self notify("control_func_done");
}

function bot_end_control_watcher(var_0) {
  self endon("disconnect");
  self waittill("control_func_done");
  try_clear_hide_goal(var_0);
  self botsetstance("none");
  self botsetscriptmove(0, 0);
  self botsetflag("disable_movement", 0);
  self botsetflag("disable_rotation", 0);
  self.vehicle_controlling = undefined;
}

function try_clear_hide_goal(var_0) {
  if(isDefined(var_0) && self bothasscriptgoal() && isDefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == var_0) {
    self botclearscriptgoal();
    return;
  }
}

function bot_end_control_on_vehicle_death(var_0) {
  var_0 waittill("death");
  self notify("control_func_done");
}

function bot_waittill_using_vehicle(var_0) {
  var_1 = gettime();

  while(!self[[level.bot_ks_funcs["isUsing"][var_0]]]()) {
    wait 0.05;

    if(gettime() - var_1 > 5000) {
      return false;
    }
  }

  return true;
}

function bot_control_switchblade_cluster() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  GscBinSkip4(0x35);
}

function missile_get_desired_angles_to_target(var_0, var_1) {
  var_2 = missile_find_ground_target(var_0, var_1[2]);
  var_3 = vectorNormalize(var_1 - var_2);
  return vectortoangles(var_3);
}

function missile_get_distance_to_target(var_0, var_1) {
  var_2 = missile_find_ground_target(var_0, var_1[2]);
  return distance(var_2, var_1);
}

function handle_disable_rotation() {
  self botsetflag("disable_rotation", 1);
  self botsetflag("disable_movement", 1);
  find_cluster_rocket_for_bot(self);
  self botsetflag("disable_rotation", 0);
  self botsetflag("disable_movement", 0);
}

function switchblade_handle_awareness() {
  self endon("disconnect");
  self botsetawareness(2.5);
  self waittill("control_func_done");
  self botsetawareness(1);
}

function missile_find_ground_target(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = (var_1 - var_0.origin[2]) / var_2[2];
  var_4 = var_0.origin + var_2 * var_3;
  return var_4;
}

function watch_end_switchblade() {
  self endon("disconnect");
  self waittill("control_func_done");
  self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

function find_cluster_rocket_for_bot(var_0) {
  for(;;) {
    foreach(var_2 in level.rockets) {
      if(isDefined(var_2) && var_2.owner == var_0) {
        return var_2;
      }
    }

    wait 0.05;
  }
}

function vanguard_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed()) {
    return false;
  }

  if(scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots("vanguard")) {
    return false;
  }

  return true;
}

function bot_killstreak_vanguard_start(var_0, var_1, var_2, var_3) {
  bot_killstreak_remote_control(var_0, var_1, var_2, var_3, 1);
}

function isusingvanguard() {
  return scripts\mp\utility\player::isusingremote() && self.usingremote == "vanguard" && isDefined(self.remoteuav);
}

function bot_control_vanguard() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_0 = bot_waittill_using_vehicle("vanguard");

  if(!var_0) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.remoteuav;
  GscBinSkip4(0x35, self.vehicle_controlling);
}

function pos_is_valid_outside_for_vanguard(var_0) {
  var_1 = getclosestnodeinsight(var_0);

  if(isDefined(var_1)) {
    return node_is_valid_outside_for_vanguard(var_1);
  }

  return 0;
}

function node_is_valid_outside_for_vanguard(var_0) {
  if(nodeexposedtosky(var_0)) {
    return pos_passes_sky_trace(var_0.origin);
  }

  return 0;
}

function pos_passes_sky_trace(var_0) {
  var_1 = var_0;
  var_2 = var_0 + (0, 0, level.bot_vanguard_height_trace_size);

  if(var_2[2] <= var_1[2]) {
    return 0;
  }

  var_3 = scripts\engine\trace::_bullet_trace_passed(var_1, var_2, 0, undefined);
  return var_3;
}

function vanguard_is_outside() {
  var_0 = getclosestnodeinsight(self.origin);

  if(isDefined(var_0) && !nodeexposedtosky(var_0)) {
    return false;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (18, 0, 25))) {
    return false;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (-18, 0, 25))) {
    return false;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, 18, 25))) {
    return false;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, -18, 25))) {
    return false;
  }

  return true;
}

function vanguard_control_aiming() {
  self notify("vanguard_control_aiming");
  self endon("vanguard_control_aiming");
  var_0 = undefined;
  var_1 = 0;
  var_2 = gettime();
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["vanguard"]]]()) {
    var_6 = undefined;
    var_7 = self getEye();
    var_8 = self getplayerangles();
    var_9 = self botgetfovdot();

    if(isalive(self.enemy) && self botcanseeentity(self.enemy)) {
      var_10 = 1;
      var_6 = self.enemy;
      var_5 = 0;
    } else if(var_5 < 10) {
      foreach(var_12 in level.characters) {
        if(var_12 == self || !isalive(var_12)) {
          continue;
        }

        if(var_12 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
          continue;
        }

        if(!isDefined(var_12.team)) {
          continue;
        }

        if(!level.teambased || self.team != var_12.team) {
          if(scripts\engine\utility::within_fov(var_7, var_8, var_12.origin, var_9)) {
            var_5 += 0.05;

            if(isDefined(var_6)) {
              var_13 = distancesquared(self.vehicle_controlling.origin, var_6.origin);
              var_14 = distancesquared(self.vehicle_controlling.origin, var_12.origin);

              if(var_14 < var_13) {
                var_6 = var_12;
              }

              continue;
            }

            var_6 = var_12;
          }
        }
      }
    }

    if(isDefined(var_6)) {
      if((isai(var_6) || isPlayer(var_6)) && length(var_6 getentityvelocity()) < 25) {
        var_0 = var_6.origin;
      } else if(gettime() - var_3 < 500) {
        if(var_4 != var_6) {
          var_0 = var_6.origin;
        }
      } else if(gettime() - var_3 > 500) {
        var_3 = gettime();
        var_0 = getpredictedentityposition(var_6, 3);
        var_4 = var_6;
      }

      var_16 = 165;

      if(gettime() - var_2 > 10000) {
        var_16 = 200;
      }

      if(distancesquared(self.vehicle_controlling.attackarrow.origin, var_0) < level.vanguard_missile_radius * level.vanguard_missile_radius) {
        if(bot_body_is_dead() || distancesquared(self.vehicle_controlling.attackarrow.origin, self.origin) > level.vanguard_missile_radius * level.vanguard_missile_radius) {
          var_2 = gettime();
          self botpressbutton("attack");
        }
      }
    } else if(gettime() > var_1) {
      var_1 = gettime() + randomintrange(1000, 2000);
      var_0 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    if(length(var_0) == 0) {
      var_0 = (0, 0, 10);
    }

    self botlookatpoint(var_0, 0.2, "script_forced");
    wait 0.05;
  }
}

function vanguard_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](var_0);
  var_2 = bot_vanguard_find_unvisited_nodes(var_0);
  var_3 = var_2;
  var_2 = [];

  foreach(var_5 in var_3) {
    if(var_5.valid_for_vanguard) {
      if(var_0.origin[2] != var_0.vanguard_origin[2] || var_5.origin[2] != var_5.vanguard_origin[2]) {
        var_6 = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](var_5);
        var_7 = playerphysicstrace(var_1, var_6);

        if(distancesquared(var_7, var_6) < 1) {
          var_2 = scripts\engine\utility::array_add(var_2, var_5);
        }

        wait 0.05;
        continue;
      }

      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  if(var_2.size == 0 && var_3.size > 0) {
    foreach(var_5 in var_3) {
      var_5.bot_visited_times[self.entity_number]++;
    }
  }

  return heli_pick_node_furthest_from_center(var_2, "vanguard");
}

function bot_vanguard_find_unvisited_nodes(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0.neighbors) {
    if(isDefined(var_4.script_linkname) && var_4.valid_for_vanguard) {
      var_5 = var_4.bot_visited_times[self.entity_number];

      if(var_5 < var_1) {
        var_2 = [];
        var_2 = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1) {
        var_2 = var_4;
      }
    }
  }

  return var_2;
}

function vanguard_get_node_origin(var_0) {
  return var_0.vanguard_origin;
}

function origin_is_valid_for_vanguard(var_0) {
  var_1 = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2 delete();
  return var_1;
}

function heli_sniper_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed()) {
    return false;
  }

  return true;
}

function heli_sniper_waittill_initial_goal() {
  self.vehicle_controlling waittill("near_goal");
}

function bot_control_heli_sniper() {
  thread heli_sniper_clear_script_goal_on_ride();
  bot_control_heli("heli_sniper");
}

function heli_sniper_clear_script_goal_on_ride() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self botclearscriptgoal();
}

function heli_sniper_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = bot_heli_find_unvisited_nodes(var_0);
  return heli_pick_node_furthest_from_center(var_1, "heli_sniper");
}

function heli_pilot_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed()) {
    return false;
  }

  if(scripts\mp\killstreaks\helicopter_pilot::exceededmaxhelipilots(self.team)) {
    return false;
  }

  return true;
}

function heli_pilot_waittill_initial_goal() {
  self.vehicle_controlling waittill("goal_reached");
}

function bot_control_heli_pilot() {
  bot_control_heli("heli_pilot");
}

function heli_pilot_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = bot_heli_find_unvisited_nodes(var_0);
  var_2 = scripts\engine\utility::random(var_1);
  return var_2;
}

function heli_pilot_monitor_flares() {
  self notify("heli_pilot_monitor_flares");
  self endon("heli_pilot_monitor_flares");
  var_0 = [];

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    self.vehicle_controlling waittill("targeted_by_incoming_missile", var_1);

    if(!scripts\mp\killstreaks\flares::flares_areavailable(self.vehicle_controlling)) {
      break;
    }

    var_2 = 1;

    foreach(var_4 in var_1) {
      if(isDefined(var_4) && !scripts\engine\utility::array_contains(var_0, var_4)) {
        var_2 = 0;
      }
    }

    if(!var_2) {
      var_6 = clamp(0.34 * self botgetdifficultysetting("strategyLevel"), 0, 1);

      if(randomfloat(1) < var_6) {
        self notify("manual_flare_popped");
      }

      var_0 = scripts\engine\utility::array_combine(var_0, var_1);
      var_0 = scripts\engine\utility::array_removeundefined(var_0);
      wait 3;
    }
  }
}

function heli_pilot_control_heli_aiming() {
  self notify("heli_pilot_control_heli_aiming");
  self endon("heli_pilot_control_heli_aiming");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  var_7 = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    var_8 = 0;
    var_9 = 0;

    if(isDefined(var_1) && var_1.health <= 0 && gettime() - var_1.deathtime < 2000) {
      var_8 = 1;
      var_9 = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var_8 = 1;
      var_1 = self.enemy;
      var_0 = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var_7 = 0;
        var_9 = 1;
        var_10 = gettime();
      } else {
        var_7 += 0.05;

        if(var_7 > 5) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      var_2 = var_0 - (0, 0, 50);

      if(var_9 && (bot_body_is_dead() || distancesquared(var_2, self.origin) > level.heli_pilot_missile_radius * level.heli_pilot_missile_radius)) {
        self botpressbutton("attack");
      }

      if(gettime() > var_4 + 500) {
        var_11 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_12 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_13 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_5 = (150 * var_11, 150 * var_12, 150 * var_13);
        var_4 = gettime();
      }

      var_2 += var_5;
      var_14 = self.vehicle_controlling gettagorigin("tag_player");
      var_15 = vectorNormalize(var_2 - var_14);
      var_16 = anglesToForward(self getplayerangles());
      var_17 = vectordot(var_15, var_16);

      if(var_17 > 0.5) {
        self botpressbutton("ads", 0.1);
      }
    } else if(gettime() > var_3) {
      var_3 = gettime() + randomintrange(1000, 2000);
      var_2 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    var_18 = var_2 - self.vehicle_controlling.origin;
    var_19 = length(var_18);
    var_20 = vectortoangles(var_18);
    var_21 = angleclamp(self.vehicle_controlling.angles[0]);
    var_22 = angleclamp(var_20[0]);
    var_23 = int(var_21 - var_22) % 360;

    if(var_23 > 180) {
      var_23 = 360 - var_23;
    } else if(var_23 < -180) {
      var_23 = -360 + var_23;
    }

    if(var_23 > 15) {
      var_22 = var_21 - 15;
    } else if(var_23 < -15) {
      var_22 = var_21 + 15;
    }

    var_20 = (var_22, var_20[1], var_20[2]);
    var_18 = anglesToForward(var_20);
    var_2 = self.vehicle_controlling.origin + var_18 * var_19;

    if(length(var_2) == 0) {
      var_2 = (0, 0, 10);
    }

    self botlookatpoint(var_2, 0.2, "script_forced");
    wait 0.05;
  }
}

function bot_control_odin_assault() {
  bot_control_odin("odin_assault");
}

function odin_assault_perform_action() {
  if(bot_odin_try_spawn_juggernaut()) {
    return true;
  }

  if(bot_odin_try_rods()) {
    return true;
  }

  if(bot_odin_try_airdrop()) {
    return true;
  }

  return false;
}

function odin_assault_get_target() {
  return bot_odin_find_target_for_rods();
}

function bot_odin_find_target_for_rods() {
  var_0 = undefined;

  if(isDefined(self.last_large_rod_target) && gettime() - self.last_large_rod_time < 5000) {
    var_0 = self.last_large_rod_target;
  }

  return bot_odin_get_closest_visible_outside_player("enemy", 1, var_0);
}

function bot_odin_try_rods() {
  var_0 = bot_odin_should_fire_rod_at_marker();

  if(var_0 == "large") {
    self notify("large_rod_action");
    return true;
  }

  if(var_0 == "small") {
    self notify("small_rod_action");
    return true;
  }

  return false;
}

function bot_odin_should_fire_rod_at_marker() {
  var_0 = gettime() >= self.odin.odin_largerodusetime;
  var_1 = gettime() >= self.odin.odin_smallrodusetime;

  if(var_0 || var_1) {
    var_2 = bot_odin_get_visible_outside_players("enemy", 0);
    var_3 = [];
    var_4 = distancesquared(self.origin, self.odin.targeting_marker.origin);

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      var_6 = bot_odin_get_player_target_point(var_2[var_5]);
      var_3 = distancesquared(self.odin.targeting_marker.origin, var_6);
    }

    if(var_0) {
      if(!bot_body_is_dead() && var_4 < level.odin_large_rod_radius * level.odin_large_rod_radius) {
        return "none";
      }

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_3[var_5] < squared(level.odin_large_rod_radius)) {
          self.last_large_rod_target = var_2[var_5];
          self.last_large_rod_time = gettime();
          return "large";
        }
      }
    }

    if(var_1) {
      if(!bot_body_is_dead() && var_4 < level.odin_small_rod_radius * level.odin_small_rod_radius) {
        return "none";
      }

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_3[var_5] < squared(level.odin_small_rod_radius)) {
          if(isDefined(self.last_large_rod_target) && self.last_large_rod_target == var_2[var_5] && gettime() - self.last_large_rod_time < 5000) {
            continue;
          }

          return "small";
        }
      }
    }
  }

  return "none";
}

function bot_control_odin_support() {
  bot_control_odin("odin_support");
}

function odin_support_perform_action() {
  if(bot_odin_try_spawn_juggernaut()) {
    return true;
  }

  if(bot_odin_try_airdrop()) {
    return true;
  }

  if(bot_odin_try_smoke()) {
    return true;
  }

  if(bot_odin_try_flash()) {
    return true;
  }

  return false;
}

function bot_odin_try_flash() {
  if(bot_odin_should_fire_flash_at_marker()) {
    self notify("marking_action");
    return true;
  }

  return false;
}

function bot_odin_should_fire_flash_at_marker() {
  if(gettime() < self.odin.odin_markingusetime) {
    return false;
  }

  var_0 = bot_odin_get_visible_outside_players("enemy", 0);
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = bot_odin_get_player_target_point(var_0[var_2]);
    var_1 = distancesquared(self.odin.targeting_marker.origin, var_3);

    if(var_1[var_2] < squared(level.odin_flash_radius / 2)) {
      return true;
    }
  }

  return false;
}

function bot_odin_try_smoke() {
  if(bot_odin_should_drop_smoke_at_marker()) {
    self notify("smoke_action");
    return true;
  }

  return false;
}

function bot_odin_should_drop_smoke_at_marker() {
  if(gettime() < self.odin.odin_smokeusetime) {
    return false;
  }

  var_0 = bot_odin_get_high_priority_smoke_locations();

  foreach(var_2 in var_0) {
    if(distancesquared(var_2, self.odin.targeting_marker.origin) < 2500) {
      return true;
    }
  }

  var_4 = undefined;

  if(isDefined(self.odin.targeting_marker.nearest_node)) {
    var_4 = getnodezone(self.odin.targeting_marker.nearest_node);
  }

  if(!isDefined(var_4)) {
    return false;
  }

  var_5 = bot_killstreak_get_zone_enemies_outside(1);
  var_6 = var_5[var_4].size;

  if(var_6 >= 2) {
    return true;
  }

  return false;
}

function bot_odin_get_high_priority_smoke_locations() {
  var_0 = [];

  if(gettime() < self.odin.odin_smokeusetime) {
    return var_0;
  }

  foreach(var_2 in level.carepackages) {
    if(scripts\mp\bots\bots::crate_landed_and_on_path_grid(var_2)) {
      GscBinSkip1(0x45, 0, self);
    }
  }

  var_6 = bot_odin_get_visible_outside_players("ally", 0);

  foreach(var_8 in var_6) {
    if(isai(var_8) && var_8 scripts\mp\bots\bots_util::bot_is_capturing()) {
      var_0 = scripts\engine\utility::array_add(var_0, var_8.origin);
    }
  }

  return var_0;
}

function odin_support_get_target() {
  var_0 = bot_odin_get_high_priority_smoke_locations();

  if(var_0.size > 0) {
    return var_0[0];
  }

  return bot_odin_get_closest_visible_outside_player("enemy", 1);
}

function monitor_odin_marker() {
  for(;;) {
    self.odin.targeting_marker.nearest_node = getclosestnodeinsight(self.odin.targeting_marker.origin);

    if(scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(self.odin.targeting_marker.origin, 200)) {
      self.odin.targeting_marker.nearest_point_on_pathgrid = self.odin.targeting_marker.origin;
    } else {
      self.odin.targeting_marker.nearest_point_on_pathgrid = undefined;
    }

    wait 0.25;
  }
}

function bot_control_odin(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_1 = bot_waittill_using_vehicle(var_0);

  if(!var_1) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.odin;
  GscBinSkip4(0x35, self.odin);
}

function bot_end_odin_watcher(var_0) {
  self endon("disconnect");
  self waittill("control_func_done");
  self.odin_predicted_loc_for_player = undefined;
  self.odin_predicted_loc_time_for_player = undefined;
  self.odin_last_predict_position_time = undefined;
  self botsetawareness(1);
}

function bot_odin_get_player_target_point(var_0) {
  if(level.teambased && self.team == var_0.team) {
    return var_0.origin;
  }

  if(length(var_0 getentityvelocity()) < 25) {
    return var_0.origin;
  }

  var_1 = var_0 getentitynumber();

  if(!isDefined(self.odin_predicted_loc_time_for_player[var_1])) {
    self.odin_predicted_loc_time_for_player[var_1] = 0;
  }

  var_2 = gettime();
  var_3 = var_2 - self.odin_predicted_loc_time_for_player[var_1];

  if(var_3 <= 400) {
    var_4 = vectorNormalize(var_0 getentityvelocity());
    var_5 = vectorNormalize(self.odin_predicted_loc_for_player[var_1] - var_0.origin);

    if(vectordot(var_4, var_5) < -0.5) {
      return var_0.origin;
    }
  }

  if(var_3 > 400) {
    if(var_2 == self.odin_last_predict_position_time) {
      if(var_3 > 1000) {
        return var_0.origin;
      }
    } else {
      self.odin_predicted_loc_for_player[var_1] = getpredictedentityposition(var_0, 1.5);
      self.odin_predicted_loc_time_for_player[var_1] = var_2;
      self.odin_last_predict_position_time = var_2;
    }
  }

  return self.odin_predicted_loc_for_player[var_1];
}

function bot_odin_get_closest_visible_outside_player(var_0, var_1, var_2) {
  var_3 = bot_odin_get_visible_outside_players(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = scripts\engine\utility::array_remove(var_3, var_2);
  }

  if(var_3.size > 0) {
    var_4 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_3);
    return var_4[0];
  }

  return undefined;
}

function bot_odin_try_spawn_juggernaut() {
  if(gettime() >= self.odin.odin_juggernautusetime) {
    if(!isDefined(self.odin.targeting_marker.nearest_node)) {
      return false;
    }
  }

  return false;
}

function bot_odin_find_target_for_airdrop() {
  return bot_odin_get_closest_visible_outside_player("ally", 0);
}

function bot_odin_try_airdrop() {
  if(bot_odin_should_airdrop_at_marker()) {
    self notify("airdrop_action");
    self notify("juggernaut_action");
    return true;
  }

  return false;
}

function bot_odin_should_airdrop_at_marker() {
  if(gettime() < self.odin.odin_airdropusetime) {
    return false;
  }

  if(!isDefined(self.odin.targeting_marker.nearest_node)) {
    return false;
  }

  if(bot_odin_get_num_valid_care_packages() > 2) {
    return false;
  }

  if(!isDefined(self.odin.targeting_marker.nearest_point_on_pathgrid)) {
    return false;
  }

  var_0 = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = bot_killstreak_get_zone_allies_outside(1);
  var_2 = var_1[var_0].size;
  var_3 = bot_killstreak_get_zone_enemies_outside(1);
  var_4 = var_3[var_0].size;

  if(var_2 == 0) {
    return false;
  }

  if(var_4 == 0) {
    var_5 = 0;
    var_6 = bot_odin_get_visible_outside_players("enemy", 1);

    foreach(var_8 in var_6) {
      if(distancesquared(var_8.origin, self.odin.targeting_marker.origin) < 14400) {
        var_5 = 1;
      }
    }

    if(!var_5) {
      return true;
    }
  }

  if(var_2 - var_4 >= 2) {
    var_10 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_1[var_0]);
    var_11 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_3[var_0]);
    var_12 = distance(self.odin.targeting_marker.origin, var_10[0].origin);
    var_13 = distance(self.odin.targeting_marker.origin, var_11[0].origin);

    if(var_12 + 120 < var_13) {
      return true;
    }
  }

  return false;
}

function bot_odin_get_num_valid_care_packages() {
  var_0 = 0;

  foreach(var_2 in level.carepackages) {
    if(isDefined(var_2) && scripts\mp\bots\bots::crate_landed_and_on_path_grid(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

function bot_odin_get_visible_outside_players(var_0, var_1, var_2) {
  var_3 = bot_killstreak_get_outside_players(self.team, var_0, var_1);
  var_4 = self botgetfovdot();
  var_5 = [];

  foreach(var_7 in var_3) {
    var_8 = 0;
    var_9 = var_4;

    if(var_0 == "enemy") {
      var_9 *= 0.9;
    }

    if(scripts\engine\utility::within_fov(self.vehicle_controlling.origin, self getplayerangles(), var_7.origin, var_9)) {
      if(!var_8 || self botcanseeentity(var_7)) {
        var_5 = scripts\engine\utility::array_add(var_5, var_7);
      }
    }
  }

  return var_5;
}

function is_indoor_map() {
  return level.script == "mp_sovereign";
}

function bot_body_is_dead() {
  return isDefined(self.fauxdead) && self.fauxdead;
}

function heli_pick_node_furthest_from_center(var_0, var_1) {
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
  }

  return scripts\engine\utility::random(var_0);
}

function heli_get_node_origin(var_0) {
  return var_0.origin;
}

function find_closest_heli_node_2d(var_0, var_1) {
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

function bot_killstreak_get_zone_allies_outside(var_0) {
  var_1 = bot_killstreak_get_all_outside_allies(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level.zonecount; var_3++) {
    var_2 = [];
  }

  foreach(var_5 in var_1) {
    var_6 = var_5 getnearestnode();
    var_7 = getnodezone(var_6);

    if(isDefined(var_7)) {
      var_2 = scripts\engine\utility::array_add(var_2[var_7], var_5);
    }
  }

  return var_2;
}

function bot_killstreak_get_zone_enemies_outside(var_0) {
  var_1 = bot_killstreak_get_all_outside_enemies(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level.zonecount; var_3++) {
    var_2 = [];
  }

  foreach(var_5 in var_1) {
    var_6 = var_5 getnearestnode();
    var_7 = getnodezone(var_6);
    var_2 = scripts\engine\utility::array_add(var_2[var_7], var_5);
  }

  return var_2;
}

function bot_killstreak_get_all_outside_enemies(var_0) {
  return bot_killstreak_get_outside_players(self.team, "enemy", var_0);
}

function bot_killstreak_get_all_outside_allies(var_0) {
  return bot_killstreak_get_outside_players(self.team, "ally", var_0);
}

function bot_killstreak_get_outside_players(var_0, var_1, var_2) {
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
        var_3 = scripts\engine\utility::array_add(var_3, var_6);
      }
    }
  }

  var_3 = scripts\engine\utility::array_remove(var_3, self);
  return var_3;
}

function bot_heli_find_unvisited_nodes(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0.neighbors) {
    if(isDefined(var_4.script_linkname)) {
      var_5 = var_4.bot_visited_times[self.entity_number];

      if(var_5 < var_1) {
        var_2 = [];
        var_2 = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1) {
        var_2 = var_4;
      }
    }
  }

  return var_2;
}

function bot_control_heli(var_0) {
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

  GscBinSkip4(0x35, self.vehicle_controlling);
}

function bot_get_heli_goal_dist_sq(var_0) {
  if(var_0) {
    return squared(100);
  }

  return squared(30);
}

function bot_get_heli_slowdown_dist_sq(var_0) {
  if(var_0) {
    return squared(300);
  }

  return squared(90);
}

function bot_control_heli_main_move_loop(var_0, var_1) {
  foreach(var_3 in level.bot_heli_nodes) {
    var_3.bot_visited_times[self.entity_number] = 0;
  }

  var_5 = find_closest_heli_node_2d(self.vehicle_controlling.origin, var_0);
  var_6 = undefined;
  self.next_goal_time = 0;
  var_7 = "needs_new_goal";
  var_8 = undefined;
  var_9 = self.vehicle_controlling.origin;
  var_10 = 3;
  var_11 = 0.05;

  while(self[[level.bot_ks_funcs["isUsing"][var_0]]]()) {
    if(gettime() > self.next_goal_time && var_7 == "needs_new_goal") {
      var_12 = var_5;
      var_5 = [[level.bot_ks_funcs["heli_pick_node"][var_0]]](var_5);
      var_6 = undefined;

      if(isDefined(var_5)) {
        var_13 = [[level.bot_ks_funcs["heli_node_get_origin"][var_0]]](var_5);

        if(var_1) {
          var_14 = var_5.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset;
          var_15 = var_5.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset;
          var_16 = scripts\engine\trace::_bullet_trace(var_14, var_15, 0, undefined, 0, 0, 1);
          var_6 = var_16["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_ks_heli_offset[var_0];
        } else {
          var_6 = var_13;
        }
      }

      if(isDefined(var_6)) {
        self botsetflag("disable_movement", 0);
        var_7 = "waiting_till_goal";
        var_10 = 3;
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
        var_20 = scripts\engine\utility::ter_op(var_8 < bot_get_heli_slowdown_dist_sq(var_1), 0.5, 1);
        self botsetscriptmove(var_19[1], var_11, var_20);
        var_10 -= var_11;

        if(var_10 <= 0) {
          if(distancesquared(self.vehicle_controlling.origin, var_9) < 225) {
            var_5.bot_visited_times[self.entity_number]++;
            var_7 = "needs_new_goal";
          }

          var_9 = self.vehicle_controlling.origin;
          var_10 = 3;
        }
      }
    }

    wait var_11;
  }
}

function get_random_outside_target() {
  var_0 = [];

  foreach(var_2 in level.outside_zones) {
    var_3 = botzonegetcount(var_2, self.team, "enemy_predict");

    if(var_3 > 0) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  var_5 = undefined;

  if(var_0.size > 0) {
    var_6 = scripts\engine\utility::random(var_0);
    var_7 = scripts\engine\utility::random(getzonenodes(var_6));
    var_5 = var_7.origin;
  } else {
    var_8 = undefined;
    var_9 = undefined;

    if(isDefined(level.teleportgetactivenodesfunc)) {
      var_8 = [[level.teleportgetactivenodesfunc]]();
    } else {
      var_9 = getsentientcounts();
    }

    var_10 = 0;

    while(var_10 < 10) {
      var_10++;
      var_11 = undefined;

      if(isDefined(var_8)) {
        var_11 = scripts\engine\utility::random(var_8);
      } else {
        var_11 = nvidiahighlightsrequestpermissions(randomint(var_9));
      }

      if(isDefined(var_11)) {
        var_5 = var_11.origin;

        if(nodeexposedtosky(var_11) && distance2dsquared(var_11.origin, self.vehicle_controlling.origin) > 62500) {
          break;
        }
      }
    }
  }

  return var_5;
}