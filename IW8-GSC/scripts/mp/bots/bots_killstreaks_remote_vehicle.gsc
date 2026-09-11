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
  var0 = scripts\engine\utility::getStructArray("so_chopper_boss_path_struct", "script_noteworthy");
  level.bot_heli_nodes = [];

  foreach(var2 in var0) {
    if(isDefined(var2.script_linkname)) {
      level.bot_heli_nodes = scripts\engine\utility::array_add(level.bot_heli_nodes, var2);
    }
  }

  level.bot_heli_pilot_traceoffset = scripts\mp\utility\killstreak::gethelipilottraceoffset();

  foreach(var5 in level.bot_heli_nodes) {
    var5.vanguard_origin = var5.origin;
    var6 = var5.origin + (0, 0, 50);
    var5.valid_for_vanguard = 1;

    if(var6[2] <= var5.origin[2] - 1000) {
      var5.valid_for_vanguard = 0;
    }

    var6 -= (0, 0, 50);
    var5.vanguard_origin = var6;
  }

  var8 = -99999999;

  foreach(var5 in level.bot_heli_nodes) {
    var8 = max(var8, var5.origin[2]);
  }

  level.bot_vanguard_height_trace_size = var8 - level.bot_map_min_z + 100;
  level.heli_pilot_missile_radius = getdvarfloat("OKMPLOMTNM");

  while(!isDefined(level.odin_marking_flash_radius_max) || !isDefined(level.odin_marking_flash_radius_min)) {
    wait 0.05;
  }

  level.odin_flash_radius = (level.odin_marking_flash_radius_max + level.odin_marking_flash_radius_min) / 2;
  level.outside_zones = [];

  if(isDefined(level.teleportgetactivepathnodezonesfunc)) {
    var11 = [[level.teleportgetactivepathnodezonesfunc]]();
  } else {
    var11 = [];

    for(var12 = 0; var12 < level.zonecount; var12++) {
      var11 = var12;
    }
  }

  foreach(var14 in var11) {
    if(botzonegetindoorpercent(var14) < 0.25) {
      level.outside_zones = scripts\engine\utility::array_add(level.outside_zones, var14);
    }
  }

  level.bot_odin_time_to_move["recruit"] = 1;
  level.bot_odin_time_to_move["regular"] = 0.7;
  level.bot_odin_time_to_move["hardened"] = 0.4;
  level.bot_odin_time_to_move["veteran"] = 0.05;
  level.bot_initialized_remote_vehicles = 1;
}

function bot_killstreak_remote_control(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    return false;
  }

  var5 = 1;
  var6 = 1;
  var7 = undefined;

  if(isDefined(self.node_ambushing_from)) {
    var8 = self botgetscriptgoalRadius();
    var9 = distancesquared(self.origin, self.node_ambushing_from.origin);

    if(var9 < squared(var8)) {
      var5 = 0;
      var6 = 0;
    } else if(var9 < squared(200)) {
      var5 = 0;
    }
  }

  var10 = var0.streakname == "vanguard" && is_indoor_map();

  if(var10 || var5) {
    var11 = getnodesinradius(self.origin, 500, 0, 512);

    if(isDefined(var11) && var11.size > 0) {
      if(isDefined(var4) && var4) {
        var12 = var11;
        var11 = [];

        foreach(var14 in var12) {
          if(nodeexposedtosky(var14)) {
            var15 = getlinkednodes(var14);
            var16 = 0;

            foreach(var18 in var15) {
              if(nodeexposedtosky(var18)) {
                var16++;
              }
            }

            if(var16 / var15.size > 0.5) {
              var11 = scripts\engine\utility::array_add(var11, var14);
            }
          }
        }
      }

      if(var10) {
        var21 = self botnodescoremultiple(var11, "node_exposed");

        foreach(var14 in var21) {
          if(scripts\engine\trace::_bullet_trace_passed(var14.origin + (0, 0, 30), var14.origin + (0, 0, 400), 0, self)) {
            var7 = var14;
            break;
          }

          wait 0.05;
        }
      } else if(var11.size > 0) {
        var7 = self botnodepick(var11, min(3, var11.size), "node_hide");
      }

      if(!isDefined(var7)) {
        return false;
      }

      self botsetscriptgoalnode(var7, "tactical");
    }
  }

  if(var6) {
    var24 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

    if(var24 != "goal") {
      try_clear_hide_goal(var7);
      return true;
    }
  }

  if(isDefined(var2) && !self[[var2]]()) {
    try_clear_hide_goal(var7);
    return false;
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    try_clear_hide_goal(var7);
    return true;
  }

  if(!isDefined(var7)) {
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

  scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(var0, var1, var0.weapon);
  self.vehicle_controlling = undefined;
  self thread[[var3]]();
  thread bot_end_control_on_respawn();
  thread bot_end_control_watcher(var7);
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

function bot_end_control_watcher(var0) {
  self endon("disconnect");
  self waittill("control_func_done");
  try_clear_hide_goal(var0);
  self botsetstance("none");
  self botsetscriptmove(0, 0);
  self botsetflag("disable_movement", 0);
  self botsetflag("disable_rotation", 0);
  self.vehicle_controlling = undefined;
}

function try_clear_hide_goal(var0) {
  if(isDefined(var0) && self bothasscriptgoal() && isDefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == var0) {
    self botclearscriptgoal();
    return;
  }
}

function bot_end_control_on_vehicle_death(var0) {
  var0 waittill("death");
  self notify("control_func_done");
}

function bot_waittill_using_vehicle(var0) {
  var1 = gettime();

  while(!self[[level.bot_ks_funcs["isUsing"][var0]]]()) {
    wait 0.05;

    if(gettime() - var1 > 5000) {
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

function missile_get_desired_angles_to_target(var0, var1) {
  var2 = missile_find_ground_target(var0, var1[2]);
  var3 = vectorNormalize(var1 - var2);
  return vectortoangles(var3);
}

function missile_get_distance_to_target(var0, var1) {
  var2 = missile_find_ground_target(var0, var1[2]);
  return distance(var2, var1);
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

function missile_find_ground_target(var0, var1) {
  var2 = anglesToForward(var0.angles);
  var3 = (var1 - var0.origin[2]) / var2[2];
  var4 = var0.origin + var2 * var3;
  return var4;
}

function watch_end_switchblade() {
  self endon("disconnect");
  self waittill("control_func_done");
  self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

function find_cluster_rocket_for_bot(var0) {
  for(;;) {
    foreach(var2 in level.rockets) {
      if(isDefined(var2) && var2.owner == var0) {
        return var2;
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

function bot_killstreak_vanguard_start(var0, var1, var2, var3) {
  bot_killstreak_remote_control(var0, var1, var2, var3, 1);
}

function isusingvanguard() {
  return scripts\mp\utility\player::isusingremote() && self.usingremote == "vanguard" && isDefined(self.remoteuav);
}

function bot_control_vanguard() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var0 = bot_waittill_using_vehicle("vanguard");

  if(!var0) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.remoteuav;
  GscBinSkip4(0x35, self.vehicle_controlling);
}

function pos_is_valid_outside_for_vanguard(var0) {
  var1 = getclosestnodeinsight(var0);

  if(isDefined(var1)) {
    return node_is_valid_outside_for_vanguard(var1);
  }

  return 0;
}

function node_is_valid_outside_for_vanguard(var0) {
  if(nodeexposedtosky(var0)) {
    return pos_passes_sky_trace(var0.origin);
  }

  return 0;
}

function pos_passes_sky_trace(var0) {
  var1 = var0;
  var2 = var0 + (0, 0, level.bot_vanguard_height_trace_size);

  if(var2[2] <= var1[2]) {
    return 0;
  }

  var3 = scripts\engine\trace::_bullet_trace_passed(var1, var2, 0, undefined);
  return var3;
}

function vanguard_is_outside() {
  var0 = getclosestnodeinsight(self.origin);

  if(isDefined(var0) && !nodeexposedtosky(var0)) {
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
  var0 = undefined;
  var1 = 0;
  var2 = gettime();
  var3 = 0;
  var4 = undefined;
  var5 = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["vanguard"]]]()) {
    var6 = undefined;
    var7 = self getEye();
    var8 = self getplayerangles();
    var9 = self botgetfovdot();

    if(isalive(self.enemy) && self botcanseeentity(self.enemy)) {
      var10 = 1;
      var6 = self.enemy;
      var5 = 0;
    } else if(var5 < 10) {
      foreach(var12 in level.characters) {
        if(var12 == self || !isalive(var12)) {
          continue;
        }

        if(var12 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
          continue;
        }

        if(!isDefined(var12.team)) {
          continue;
        }

        if(!level.teambased || self.team != var12.team) {
          if(scripts\engine\utility::within_fov(var7, var8, var12.origin, var9)) {
            var5 += 0.05;

            if(isDefined(var6)) {
              var13 = distancesquared(self.vehicle_controlling.origin, var6.origin);
              var14 = distancesquared(self.vehicle_controlling.origin, var12.origin);

              if(var14 < var13) {
                var6 = var12;
              }

              continue;
            }

            var6 = var12;
          }
        }
      }
    }

    if(isDefined(var6)) {
      if((isai(var6) || isPlayer(var6)) && length(var6 getentityvelocity()) < 25) {
        var0 = var6.origin;
      } else if(gettime() - var3 < 500) {
        if(var4 != var6) {
          var0 = var6.origin;
        }
      } else if(gettime() - var3 > 500) {
        var3 = gettime();
        var0 = getpredictedentityposition(var6, 3);
        var4 = var6;
      }

      var16 = 165;

      if(gettime() - var2 > 10000) {
        var16 = 200;
      }

      if(distancesquared(self.vehicle_controlling.attackarrow.origin, var0) < level.vanguard_missile_radius * level.vanguard_missile_radius) {
        if(bot_body_is_dead() || distancesquared(self.vehicle_controlling.attackarrow.origin, self.origin) > level.vanguard_missile_radius * level.vanguard_missile_radius) {
          var2 = gettime();
          self botpressbutton("attack");
        }
      }
    } else if(gettime() > var1) {
      var1 = gettime() + randomintrange(1000, 2000);
      var0 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    if(length(var0) == 0) {
      var0 = (0, 0, 10);
    }

    self botlookatpoint(var0, 0.2, "script_forced");
    wait 0.05;
  }
}

function vanguard_pick_node(var0) {
  var0.bot_visited_times[self.entity_number]++;
  var1 = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](var0);
  var2 = bot_vanguard_find_unvisited_nodes(var0);
  var3 = var2;
  var2 = [];

  foreach(var5 in var3) {
    if(var5.valid_for_vanguard) {
      if(var0.origin[2] != var0.vanguard_origin[2] || var5.origin[2] != var5.vanguard_origin[2]) {
        var6 = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](var5);
        var7 = playerphysicstrace(var1, var6);

        if(distancesquared(var7, var6) < 1) {
          var2 = scripts\engine\utility::array_add(var2, var5);
        }

        wait 0.05;
        continue;
      }

      var2 = scripts\engine\utility::array_add(var2, var5);
    }
  }

  if(var2.size == 0 && var3.size > 0) {
    foreach(var5 in var3) {
      var5.bot_visited_times[self.entity_number]++;
    }
  }

  return heli_pick_node_furthest_from_center(var2, "vanguard");
}

function bot_vanguard_find_unvisited_nodes(var0) {
  var1 = 99;
  var2 = [];

  foreach(var4 in var0.neighbors) {
    if(isDefined(var4.script_linkname) && var4.valid_for_vanguard) {
      var5 = var4.bot_visited_times[self.entity_number];

      if(var5 < var1) {
        var2 = [];
        var2 = var4;
        var1 = var5;
      } else if(var5 == var1) {
        var2 = var4;
      }
    }
  }

  return var2;
}

function vanguard_get_node_origin(var0) {
  return var0.vanguard_origin;
}

function origin_is_valid_for_vanguard(var0) {
  var1 = 1;
  var2 = scripts\engine\utility::spawn_tag_origin();
  var2.origin = var0;
  var2 delete();
  return var1;
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

function heli_sniper_pick_node(var0) {
  var0.bot_visited_times[self.entity_number]++;
  var1 = bot_heli_find_unvisited_nodes(var0);
  return heli_pick_node_furthest_from_center(var1, "heli_sniper");
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

function heli_pilot_pick_node(var0) {
  var0.bot_visited_times[self.entity_number]++;
  var1 = bot_heli_find_unvisited_nodes(var0);
  var2 = scripts\engine\utility::random(var1);
  return var2;
}

function heli_pilot_monitor_flares() {
  self notify("heli_pilot_monitor_flares");
  self endon("heli_pilot_monitor_flares");
  var0 = [];

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    self.vehicle_controlling waittill("targeted_by_incoming_missile", var1);

    if(!scripts\mp\killstreaks\flares::flares_areavailable(self.vehicle_controlling)) {
      break;
    }

    var2 = 1;

    foreach(var4 in var1) {
      if(isDefined(var4) && !scripts\engine\utility::array_contains(var0, var4)) {
        var2 = 0;
      }
    }

    if(!var2) {
      var6 = clamp(0.34 * self botgetdifficultysetting("strategyLevel"), 0, 1);

      if(randomfloat(1) < var6) {
        self notify("manual_flare_popped");
      }

      var0 = scripts\engine\utility::array_combine(var0, var1);
      var0 = scripts\engine\utility::array_removeundefined(var0);
      wait 3;
    }
  }
}

function heli_pilot_control_heli_aiming() {
  self notify("heli_pilot_control_heli_aiming");
  self endon("heli_pilot_control_heli_aiming");
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = 0;
  var4 = 0;
  var5 = undefined;
  var6 = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  var7 = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    var8 = 0;
    var9 = 0;

    if(isDefined(var1) && var1.health <= 0 && gettime() - var1.deathtime < 2000) {
      var8 = 1;
      var9 = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var8 = 1;
      var1 = self.enemy;
      var0 = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var7 = 0;
        var9 = 1;
        var10 = gettime();
      } else {
        var7 += 0.05;

        if(var7 > 5) {
          var8 = 0;
        }
      }
    }

    if(var8) {
      var2 = var0 - (0, 0, 50);

      if(var9 && (bot_body_is_dead() || distancesquared(var2, self.origin) > level.heli_pilot_missile_radius * level.heli_pilot_missile_radius)) {
        self botpressbutton("attack");
      }

      if(gettime() > var4 + 500) {
        var11 = randomfloatrange(-1 * var6 / 2, var6 / 2);
        var12 = randomfloatrange(-1 * var6 / 2, var6 / 2);
        var13 = randomfloatrange(-1 * var6 / 2, var6 / 2);
        var5 = (150 * var11, 150 * var12, 150 * var13);
        var4 = gettime();
      }

      var2 += var5;
      var14 = self.vehicle_controlling gettagorigin("tag_player");
      var15 = vectorNormalize(var2 - var14);
      var16 = anglesToForward(self getplayerangles());
      var17 = vectordot(var15, var16);

      if(var17 > 0.5) {
        self botpressbutton("ads", 0.1);
      }
    } else if(gettime() > var3) {
      var3 = gettime() + randomintrange(1000, 2000);
      var2 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    var18 = var2 - self.vehicle_controlling.origin;
    var19 = length(var18);
    var20 = vectortoangles(var18);
    var21 = angleclamp(self.vehicle_controlling.angles[0]);
    var22 = angleclamp(var20[0]);
    var23 = int(var21 - var22) % 360;

    if(var23 > 180) {
      var23 = 360 - var23;
    } else if(var23 < -180) {
      var23 = -360 + var23;
    }

    if(var23 > 15) {
      var22 = var21 - 15;
    } else if(var23 < -15) {
      var22 = var21 + 15;
    }

    var20 = (var22, var20[1], var20[2]);
    var18 = anglesToForward(var20);
    var2 = self.vehicle_controlling.origin + var18 * var19;

    if(length(var2) == 0) {
      var2 = (0, 0, 10);
    }

    self botlookatpoint(var2, 0.2, "script_forced");
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
  var0 = undefined;

  if(isDefined(self.last_large_rod_target) && gettime() - self.last_large_rod_time < 5000) {
    var0 = self.last_large_rod_target;
  }

  return bot_odin_get_closest_visible_outside_player("enemy", 1, var0);
}

function bot_odin_try_rods() {
  var0 = bot_odin_should_fire_rod_at_marker();

  if(var0 == "large") {
    self notify("large_rod_action");
    return true;
  }

  if(var0 == "small") {
    self notify("small_rod_action");
    return true;
  }

  return false;
}

function bot_odin_should_fire_rod_at_marker() {
  var0 = gettime() >= self.odin.odin_largerodusetime;
  var1 = gettime() >= self.odin.odin_smallrodusetime;

  if(var0 || var1) {
    var2 = bot_odin_get_visible_outside_players("enemy", 0);
    var3 = [];
    var4 = distancesquared(self.origin, self.odin.targeting_marker.origin);

    for(var5 = 0; var5 < var2.size; var5++) {
      var6 = bot_odin_get_player_target_point(var2[var5]);
      var3 = distancesquared(self.odin.targeting_marker.origin, var6);
    }

    if(var0) {
      if(!bot_body_is_dead() && var4 < level.odin_large_rod_radius * level.odin_large_rod_radius) {
        return "none";
      }

      for(var5 = 0; var5 < var2.size; var5++) {
        if(var3[var5] < squared(level.odin_large_rod_radius)) {
          self.last_large_rod_target = var2[var5];
          self.last_large_rod_time = gettime();
          return "large";
        }
      }
    }

    if(var1) {
      if(!bot_body_is_dead() && var4 < level.odin_small_rod_radius * level.odin_small_rod_radius) {
        return "none";
      }

      for(var5 = 0; var5 < var2.size; var5++) {
        if(var3[var5] < squared(level.odin_small_rod_radius)) {
          if(isDefined(self.last_large_rod_target) && self.last_large_rod_target == var2[var5] && gettime() - self.last_large_rod_time < 5000) {
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

  var0 = bot_odin_get_visible_outside_players("enemy", 0);
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = bot_odin_get_player_target_point(var0[var2]);
    var1 = distancesquared(self.odin.targeting_marker.origin, var3);

    if(var1[var2] < squared(level.odin_flash_radius / 2)) {
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

  var0 = bot_odin_get_high_priority_smoke_locations();

  foreach(var2 in var0) {
    if(distancesquared(var2, self.odin.targeting_marker.origin) < 2500) {
      return true;
    }
  }

  var4 = undefined;

  if(isDefined(self.odin.targeting_marker.nearest_node)) {
    var4 = getnodezone(self.odin.targeting_marker.nearest_node);
  }

  if(!isDefined(var4)) {
    return false;
  }

  var5 = bot_killstreak_get_zone_enemies_outside(1);
  var6 = var5[var4].size;

  if(var6 >= 2) {
    return true;
  }

  return false;
}

function bot_odin_get_high_priority_smoke_locations() {
  var0 = [];

  if(gettime() < self.odin.odin_smokeusetime) {
    return var0;
  }

  foreach(var2 in level.carepackages) {
    if(scripts\mp\bots\bots::crate_landed_and_on_path_grid(var2)) {
      GscBinSkip1(0x45, 0, self);
    }
  }

  var6 = bot_odin_get_visible_outside_players("ally", 0);

  foreach(var8 in var6) {
    if(isai(var8) && var8 scripts\mp\bots\bots_util::bot_is_capturing()) {
      var0 = scripts\engine\utility::array_add(var0, var8.origin);
    }
  }

  return var0;
}

function odin_support_get_target() {
  var0 = bot_odin_get_high_priority_smoke_locations();

  if(var0.size > 0) {
    return var0[0];
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

function bot_control_odin(var0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var1 = bot_waittill_using_vehicle(var0);

  if(!var1) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.odin;
  GscBinSkip4(0x35, self.odin);
}

function bot_end_odin_watcher(var0) {
  self endon("disconnect");
  self waittill("control_func_done");
  self.odin_predicted_loc_for_player = undefined;
  self.odin_predicted_loc_time_for_player = undefined;
  self.odin_last_predict_position_time = undefined;
  self botsetawareness(1);
}

function bot_odin_get_player_target_point(var0) {
  if(level.teambased && self.team == var0.team) {
    return var0.origin;
  }

  if(length(var0 getentityvelocity()) < 25) {
    return var0.origin;
  }

  var1 = var0 getentitynumber();

  if(!isDefined(self.odin_predicted_loc_time_for_player[var1])) {
    self.odin_predicted_loc_time_for_player[var1] = 0;
  }

  var2 = gettime();
  var3 = var2 - self.odin_predicted_loc_time_for_player[var1];

  if(var3 <= 400) {
    var4 = vectorNormalize(var0 getentityvelocity());
    var5 = vectorNormalize(self.odin_predicted_loc_for_player[var1] - var0.origin);

    if(vectordot(var4, var5) < -0.5) {
      return var0.origin;
    }
  }

  if(var3 > 400) {
    if(var2 == self.odin_last_predict_position_time) {
      if(var3 > 1000) {
        return var0.origin;
      }
    } else {
      self.odin_predicted_loc_for_player[var1] = getpredictedentityposition(var0, 1.5);
      self.odin_predicted_loc_time_for_player[var1] = var2;
      self.odin_last_predict_position_time = var2;
    }
  }

  return self.odin_predicted_loc_for_player[var1];
}

function bot_odin_get_closest_visible_outside_player(var0, var1, var2) {
  var3 = bot_odin_get_visible_outside_players(var0, var1);

  if(isDefined(var2)) {
    var3 = scripts\engine\utility::array_remove(var3, var2);
  }

  if(var3.size > 0) {
    var4 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var3);
    return var4[0];
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

  var0 = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(var0)) {
    return false;
  }

  var1 = bot_killstreak_get_zone_allies_outside(1);
  var2 = var1[var0].size;
  var3 = bot_killstreak_get_zone_enemies_outside(1);
  var4 = var3[var0].size;

  if(var2 == 0) {
    return false;
  }

  if(var4 == 0) {
    var5 = 0;
    var6 = bot_odin_get_visible_outside_players("enemy", 1);

    foreach(var8 in var6) {
      if(distancesquared(var8.origin, self.odin.targeting_marker.origin) < 14400) {
        var5 = 1;
      }
    }

    if(!var5) {
      return true;
    }
  }

  if(var2 - var4 >= 2) {
    var10 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var1[var0]);
    var11 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var3[var0]);
    var12 = distance(self.odin.targeting_marker.origin, var10[0].origin);
    var13 = distance(self.odin.targeting_marker.origin, var11[0].origin);

    if(var12 + 120 < var13) {
      return true;
    }
  }

  return false;
}

function bot_odin_get_num_valid_care_packages() {
  var0 = 0;

  foreach(var2 in level.carepackages) {
    if(isDefined(var2) && scripts\mp\bots\bots::crate_landed_and_on_path_grid(var2)) {
      var0++;
    }
  }

  return var0;
}

function bot_odin_get_visible_outside_players(var0, var1, var2) {
  var3 = bot_killstreak_get_outside_players(self.team, var0, var1);
  var4 = self botgetfovdot();
  var5 = [];

  foreach(var7 in var3) {
    var8 = 0;
    var9 = var4;

    if(var0 == "enemy") {
      var9 *= 0.9;
    }

    if(scripts\engine\utility::within_fov(self.vehicle_controlling.origin, self getplayerangles(), var7.origin, var9)) {
      if(!var8 || self botcanseeentity(var7)) {
        var5 = scripts\engine\utility::array_add(var5, var7);
      }
    }
  }

  return var5;
}

function is_indoor_map() {
  return level.script == "mp_sovereign";
}

function bot_body_is_dead() {
  return isDefined(self.fauxdead) && self.fauxdead;
}

function heli_pick_node_furthest_from_center(var0, var1) {
  var2 = undefined;
  var3 = 0;

  foreach(var5 in var0) {
    var6 = distancesquared(level.bot_map_center, [[level.bot_ks_funcs["heli_node_get_origin"][var1]]](var5));

    if(var6 > var3) {
      var3 = var6;
      var2 = var5;
    }
  }

  if(isDefined(var2)) {
    return var2;
  }

  return scripts\engine\utility::random(var0);
}

function heli_get_node_origin(var0) {
  return var0.origin;
}

function find_closest_heli_node_2d(var0, var1) {
  var2 = undefined;
  var3 = 99999999;

  foreach(var5 in level.bot_heli_nodes) {
    var6 = distance2dsquared(var0, [[level.bot_ks_funcs["heli_node_get_origin"][var1]]](var5));

    if(var6 < var3) {
      var2 = var5;
      var3 = var6;
    }
  }

  return var2;
}

function bot_killstreak_get_zone_allies_outside(var0) {
  var1 = bot_killstreak_get_all_outside_allies(var0);
  var2 = [];

  for(var3 = 0; var3 < level.zonecount; var3++) {
    var2 = [];
  }

  foreach(var5 in var1) {
    var6 = var5 getnearestnode();
    var7 = getnodezone(var6);

    if(isDefined(var7)) {
      var2 = scripts\engine\utility::array_add(var2[var7], var5);
    }
  }

  return var2;
}

function bot_killstreak_get_zone_enemies_outside(var0) {
  var1 = bot_killstreak_get_all_outside_enemies(var0);
  var2 = [];

  for(var3 = 0; var3 < level.zonecount; var3++) {
    var2 = [];
  }

  foreach(var5 in var1) {
    var6 = var5 getnearestnode();
    var7 = getnodezone(var6);
    var2 = scripts\engine\utility::array_add(var2[var7], var5);
  }

  return var2;
}

function bot_killstreak_get_all_outside_enemies(var0) {
  return bot_killstreak_get_outside_players(self.team, "enemy", var0);
}

function bot_killstreak_get_all_outside_allies(var0) {
  return bot_killstreak_get_outside_players(self.team, "ally", var0);
}

function bot_killstreak_get_outside_players(var0, var1, var2) {
  var3 = [];
  var4 = level.participants;

  if(isDefined(var2) && var2) {
    var4 = level.players;
  }

  foreach(var6 in var4) {
    if(var6 == self || !isalive(var6)) {
      continue;
    }

    var7 = 0;

    if(var1 == "ally") {
      var7 = level.teambased && var0 == var6.team;
    } else if(var1 == "enemy") {
      var7 = !level.teambased || var0 != var6.team;
    }

    if(var7) {
      var8 = var6 getnearestnode();

      if(isDefined(var8) && nodeexposedtosky(var8)) {
        var3 = scripts\engine\utility::array_add(var3, var6);
      }
    }
  }

  var3 = scripts\engine\utility::array_remove(var3, self);
  return var3;
}

function bot_heli_find_unvisited_nodes(var0) {
  var1 = 99;
  var2 = [];

  foreach(var4 in var0.neighbors) {
    if(isDefined(var4.script_linkname)) {
      var5 = var4.bot_visited_times[self.entity_number];

      if(var5 < var1) {
        var2 = [];
        var2 = var4;
        var1 = var5;
      } else if(var5 == var1) {
        var2 = var4;
      }
    }
  }

  return var2;
}

function bot_control_heli(var0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var1 = bot_waittill_using_vehicle(var0);

  if(!var1) {
    self notify("control_func_done");
  }

  foreach(var3 in level.littlebirds) {
    if(var3.owner == self) {
      self.vehicle_controlling = var3;
    }
  }

  GscBinSkip4(0x35, self.vehicle_controlling);
}

function bot_get_heli_goal_dist_sq(var0) {
  if(var0) {
    return squared(100);
  }

  return squared(30);
}

function bot_get_heli_slowdown_dist_sq(var0) {
  if(var0) {
    return squared(300);
  }

  return squared(90);
}

function bot_control_heli_main_move_loop(var0, var1) {
  foreach(var3 in level.bot_heli_nodes) {
    var3.bot_visited_times[self.entity_number] = 0;
  }

  var5 = find_closest_heli_node_2d(self.vehicle_controlling.origin, var0);
  var6 = undefined;
  self.next_goal_time = 0;
  var7 = "needs_new_goal";
  var8 = undefined;
  var9 = self.vehicle_controlling.origin;
  var10 = 3;
  var11 = 0.05;

  while(self[[level.bot_ks_funcs["isUsing"][var0]]]()) {
    if(gettime() > self.next_goal_time && var7 == "needs_new_goal") {
      var12 = var5;
      var5 = [[level.bot_ks_funcs["heli_pick_node"][var0]]](var5);
      var6 = undefined;

      if(isDefined(var5)) {
        var13 = [[level.bot_ks_funcs["heli_node_get_origin"][var0]]](var5);

        if(var1) {
          var14 = var5.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset;
          var15 = var5.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset;
          var16 = scripts\engine\trace::_bullet_trace(var14, var15, 0, undefined, 0, 0, 1);
          var6 = var16["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_ks_heli_offset[var0];
        } else {
          var6 = var13;
        }
      }

      if(isDefined(var6)) {
        self botsetflag("disable_movement", 0);
        var7 = "waiting_till_goal";
        var10 = 3;
        var9 = self.vehicle_controlling.origin;
      } else {
        var5 = var12;
        self.next_goal_time = gettime() + 2000;
      }
    } else if(var7 == "waiting_till_goal") {
      if(!var1) {
        var17 = var6[2] - self.vehicle_controlling.origin[2];

        if(var17 > 10) {
          self botpressbutton("lethal");
        } else if(var17 < -10) {
          self botpressbutton("tactical");
        }
      }

      var18 = var6 - self.vehicle_controlling.origin;

      if(var1) {
        var8 = length2dsquared(var18);
      } else {
        var8 = lengthsquared(var18);
      }

      if(var8 < bot_get_heli_goal_dist_sq(var1)) {
        self botsetscriptmove(0, 0);
        self botsetflag("disable_movement", 1);

        if(self botgetdifficulty() == "recruit") {
          self.next_goal_time = gettime() + randomintrange(5000, 7000);
        } else {
          self.next_goal_time = gettime() + randomintrange(3000, 5000);
        }

        var7 = "needs_new_goal";
      } else {
        var18 = var6 - self.vehicle_controlling.origin;
        var19 = vectortoangles(var18);
        var20 = scripts\engine\utility::ter_op(var8 < bot_get_heli_slowdown_dist_sq(var1), 0.5, 1);
        self botsetscriptmove(var19[1], var11, var20);
        var10 -= var11;

        if(var10 <= 0) {
          if(distancesquared(self.vehicle_controlling.origin, var9) < 225) {
            var5.bot_visited_times[self.entity_number]++;
            var7 = "needs_new_goal";
          }

          var9 = self.vehicle_controlling.origin;
          var10 = 3;
        }
      }
    }

    wait var11;
  }
}

function get_random_outside_target() {
  var0 = [];

  foreach(var2 in level.outside_zones) {
    var3 = botzonegetcount(var2, self.team, "enemy_predict");

    if(var3 > 0) {
      var0 = scripts\engine\utility::array_add(var0, var2);
    }
  }

  var5 = undefined;

  if(var0.size > 0) {
    var6 = scripts\engine\utility::random(var0);
    var7 = scripts\engine\utility::random(getzonenodes(var6));
    var5 = var7.origin;
  } else {
    var8 = undefined;
    var9 = undefined;

    if(isDefined(level.teleportgetactivenodesfunc)) {
      var8 = [[level.teleportgetactivenodesfunc]]();
    } else {
      var9 = getsentientcounts();
    }

    var10 = 0;

    while(var10 < 10) {
      var10++;
      var11 = undefined;

      if(isDefined(var8)) {
        var11 = scripts\engine\utility::random(var8);
      } else {
        var11 = nvidiahighlightsrequestpermissions(randomint(var9));
      }

      if(isDefined(var11)) {
        var5 = var11.origin;

        if(nodeexposedtosky(var11) && distance2dsquared(var11.origin, self.vehicle_controlling.origin) > 62500) {
          break;
        }
      }
    }
  }

  return var5;
}