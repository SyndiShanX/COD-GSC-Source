/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3444.gsc
**************************************/

remote_vehicle_setup() {
  while(!isDefined(level.bot_variables_initialized)) {
    wait 0.05;
  }

  if(isDefined(level.bot_initialized_remote_vehicles)) {
    return;
  }
  level.bot_ks_heli_offset["heli_pilot"] = (0, 0, 350);
  level.bot_ks_heli_offset["heli_sniper"] = (0, 0, 228);
  level.bot_ks_funcs["isUsing"]["odin_assault"] = scripts\mp\utility\game::isusingremote;
  level.bot_ks_funcs["isUsing"]["odin_support"] = scripts\mp\utility\game::isusingremote;
  level.bot_ks_funcs["isUsing"]["heli_pilot"] = scripts\mp\utility\game::isusingremote;
  level.bot_ks_funcs["isUsing"]["heli_sniper"] = ::isusinggunship;
  level.bot_ks_funcs["isUsing"]["switchblade_cluster"] = scripts\mp\utility\game::isusingremote;
  level.bot_ks_funcs["isUsing"]["vanguard"] = ::isusingvanguard;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_pilot"] = ::heli_pilot_waittill_initial_goal;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_sniper"] = ::heli_sniper_waittill_initial_goal;
  level.bot_ks_funcs["control_aiming"]["heli_pilot"] = ::heli_pilot_control_heli_aiming;
  level.bot_ks_funcs["control_aiming"]["heli_sniper"] = scripts\engine\utility::empty_init_func;
  level.bot_ks_funcs["control_aiming"]["vanguard"] = ::vanguard_control_aiming;
  level.bot_ks_funcs["control_other"]["heli_pilot"] = ::heli_pilot_monitor_flares;
  level.bot_ks_funcs["heli_pick_node"]["heli_pilot"] = ::heli_pilot_pick_node;
  level.bot_ks_funcs["heli_pick_node"]["heli_sniper"] = ::heli_sniper_pick_node;
  level.bot_ks_funcs["heli_pick_node"]["vanguard"] = ::vanguard_pick_node;
  level.bot_ks_funcs["heli_node_get_origin"]["heli_pilot"] = ::heli_get_node_origin;
  level.bot_ks_funcs["heli_node_get_origin"]["heli_sniper"] = ::heli_get_node_origin;
  level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] = ::vanguard_get_node_origin;
  level.bot_ks_funcs["odin_perform_action"]["odin_assault"] = ::odin_assault_perform_action;
  level.bot_ks_funcs["odin_perform_action"]["odin_support"] = ::odin_support_perform_action;
  level.bot_ks_funcs["odin_get_target"]["odin_assault"] = ::odin_assault_get_target;
  level.bot_ks_funcs["odin_get_target"]["odin_support"] = ::odin_support_get_target;
  var_0 = scripts\engine\utility::getstructarray("so_chopper_boss_path_struct", "script_noteworthy");
  level.bot_heli_nodes = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_linkname)) {
      level.bot_heli_nodes = scripts\engine\utility::array_add(level.bot_heli_nodes, var_2);
    }
  }

  level.bot_heli_pilot_traceoffset = scripts\mp\utility\game::gethelipilottraceoffset();

  foreach(var_5 in level.bot_heli_nodes) {
    var_5.vanguard_origin = var_5.origin;
    var_6 = var_5.origin + (0, 0, 50);
    var_5.valid_for_vanguard = 1;

    if(var_6[2] <= var_5.origin[2] - 1000) {
      var_5.valid_for_vanguard = 0;
    }

    var_6 = var_6 - (0, 0, 50);
    var_5.vanguard_origin = var_6;
  }

  var_8 = -99999999;

  foreach(var_5 in level.bot_heli_nodes) {
    var_8 = max(var_8, var_5.origin[2]);
  }

  level.bot_vanguard_height_trace_size = var_8 - level.bot_map_min_z + 100;
  level.odin_large_rod_radius = getweaponexplosionradius("odin_projectile_large_rod_mp");
  level.odin_small_rod_radius = getweaponexplosionradius("odin_projectile_small_rod_mp");
  level.vanguard_missile_radius = getweaponexplosionradius("remote_tank_projectile_mp");
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
      var_11[var_11.size] = var_12;
    }
  }

  foreach(var_14 in var_11) {
    if(botzonegetindoorpercent(var_14) < 0.25) {
      level.outside_zones = scripts\engine\utility::array_add(level.outside_zones, var_14);
    }
  }

  level.var_2E35["recruit"] = 1.0;
  level.var_2E35["regular"] = 0.7;
  level.var_2E35["hardened"] = 0.4;
  level.var_2E35["veteran"] = 0.05;
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
    } else if(var_9 < squared(200))
      var_5 = 0;
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
          if(bullettracepassed(var_14.origin + (0, 0, 30), var_14.origin + (0, 0, 400), 0, self)) {
            var_7 = var_14;
            break;
          }

          wait 0.05;
        }
      } else if(var_11.size > 0)
        var_7 = self botnodepick(var_11, min(3, var_11.size), "node_hide");

      if(!isDefined(var_7)) {
        return 0;
      }

      self botsetscriptgoalnode(var_7, "tactical");
    }
  }

  if(var_6) {
    var_24 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

    if(var_24 != "goal") {
      try_clear_hide_goal(var_7);
      return 1;
    }
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    try_clear_hide_goal(var_7);
    return 0;
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
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

  scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
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

bot_control_switchblade_cluster() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  childthread handle_disable_rotation();
  var_0 = bot_waittill_using_vehicle("switchblade_cluster");

  if(!var_0) {
    self notify("control_func_done");
  }

  thread switchblade_handle_awareness();
  var_1 = find_cluster_rocket_for_bot(self);
  wait 0.1;
  self.oldmaxsightdistsqrd = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 256000000;
  thread watch_end_switchblade();
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = [];
  var_6 = undefined;
  var_7 = 0;
  var_8 = 0;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = 0;
  var_12 = is_indoor_map();

  while(self[[level.bot_ks_funcs["isUsing"]["switchblade_cluster"]]]() && isDefined(var_1)) {
    foreach(var_14 in level.rockets) {
      if(isDefined(var_14) && var_14.owner == self && var_14.weapon_name == "switch_blade_child_mp") {
        var_15 = 1;

        foreach(var_17 in var_5) {
          if(var_17.rocket == var_14) {
            var_15 = 0;
          }
        }

        if(var_15) {
          var_19 = spawnStruct();
          var_19.rocket = var_14;
          var_19.target = var_6;
          var_6 = undefined;
          var_5 = scripts\engine\utility::array_add(var_5, var_19);
        }
      }
    }

    for(var_21 = 0; var_21 < var_5.size; var_21++) {
      var_17 = var_5[var_21];

      if(isDefined(var_17) && isDefined(var_17.rocket) && !scripts\engine\utility::array_contains(level.rockets, var_17.rocket)) {
        var_5[var_21] = var_5[var_5.size - 1];
        var_5[var_5.size - 1] = undefined;
        var_21--;
      }
    }

    if(var_11) {
      wait 0.05;
      continue;
    }

    var_22 = undefined;

    if(isDefined(var_10)) {
      var_22 = var_10;

      if(!isalive(var_10) || !self botcanseeentity(var_22)) {
        if(!isalive(var_10)) {
          var_11 = 1;
        }

        wait 0.05;
        continue;
      }
    }

    var_23 = [];

    if(!isDefined(var_22)) {
      var_24 = bot_killstreak_get_all_outside_enemies(0);
      var_25 = [];

      foreach(var_17 in var_5) {
        if(isDefined(var_17.target)) {
          var_25 = scripts\engine\utility::array_add(var_25, var_17.target);
        }
      }

      var_24 = scripts\engine\utility::array_remove_array(var_24, var_25);

      foreach(var_29 in var_24) {
        if(var_29 scripts\mp\utility\game::_hasperk("specialty_noplayertarget")) {
          continue;
        }
        if(self botcanseeentity(var_29) || var_12 && scripts\engine\utility::within_fov(self getEye(), var_1.angles, var_29.origin, self botgetfovdot())) {
          if(!bot_body_is_dead() && distancesquared(var_29.origin, self.origin) < 40000) {
            continue;
          }
          var_23 = scripts\engine\utility::array_add(var_23, var_29);

          if(!isDefined(var_22)) {
            var_22 = var_29;
            continue;
          }

          var_30 = vectornormalize(var_22.origin - var_1.origin);
          var_31 = vectornormalize(var_29.origin - var_1.origin);
          var_32 = anglesToForward(var_1.angles);
          var_33 = vectordot(var_30, var_32);
          var_34 = vectordot(var_31, var_32);

          if(var_34 > var_33) {
            var_22 = var_29;
          }
        }
      }
    }

    if(isDefined(var_22)) {
      var_2 = undefined;
      var_36 = var_1.origin[2] - var_22.origin[2];
      var_37 = self botgetdifficulty();

      if(var_37 == "recruit") {
        var_9 = var_22.origin;
      } else if(var_36 < 5000) {
        var_9 = var_22.origin;
      } else if(length(var_22 getentityvelocity()) < 25) {
        var_9 = var_22.origin;
      } else if(gettime() - var_8 > 500) {
        var_8 = gettime();
        var_38 = 3.0;

        if(var_37 == "regular") {
          var_38 = 1.0;
        }

        var_9 = getpredictedentityposition(var_22, var_38);
      }

      var_39 = missile_get_desired_angles_to_target(var_1, var_9);
      var_40 = missile_get_distance_to_target(var_1, var_9);

      if(var_40 < 30) {
        var_41 = 0.0;
      } else if(var_40 < 100) {
        var_41 = 0.15;
      } else if(var_40 < 200) {
        var_41 = 0.3;
      } else if(var_40 < 400) {
        var_41 = 0.6;
      } else {
        var_41 = 1.0;
      }

      if(var_7) {
        var_41 = min(var_41 * 3, 1.0);
      }

      if(var_41 > 0) {
        self botsetscriptmove(var_39[1], 0.05, var_41, 1, 1);
      } else if(gettime() > var_4) {
        if(var_3 < 2) {
          self botpressbutton("attack");
          var_3++;
          var_4 = gettime() + 200;

          if(var_37 == "regular" && var_3 == 2 || var_37 == "hardened" || var_37 == "veteran") {
            var_42 = var_3 == 1 && var_23.size == 1;

            if(!var_42) {
              var_6 = var_22;
              var_4 = var_4 + 800;
            }
          }
        } else if(!var_7 && (var_36 < 5000 || var_37 == "recruit")) {
          var_7 = 1;
          self botpressbutton("attack");

          if(var_37 == "recruit") {
            var_10 = var_22;
          }
        }
      }
    } else {
      if(!isDefined(var_2)) {
        var_2 = scripts\engine\utility::random(level.outside_zones);
      }

      var_43 = getzonenodeforindex(var_2).origin;

      if(missile_get_distance_to_target(var_1, var_43) < 200) {
        var_2 = scripts\engine\utility::random(level.outside_zones);
        var_43 = getzonenodeforindex(var_2).origin;
      }

      var_39 = missile_get_desired_angles_to_target(var_1, var_43);
      self botsetscriptmove(var_39[1], 0.05, 0.75, 1, 1);
    }

    wait 0.05;
  }

  self notify("control_func_done");
}

missile_get_desired_angles_to_target(var_0, var_1) {
  var_2 = missile_find_ground_target(var_0, var_1[2]);
  var_3 = vectornormalize(var_1 - var_2);
  return vectortoangles(var_3);
}

missile_get_distance_to_target(var_0, var_1) {
  var_2 = missile_find_ground_target(var_0, var_1[2]);
  return distance(var_2, var_1);
}

handle_disable_rotation() {
  self botsetflag("disable_rotation", 1);
  self botsetflag("disable_movement", 1);
  find_cluster_rocket_for_bot(self);
  self botsetflag("disable_rotation", 0);
  self botsetflag("disable_movement", 0);
}

switchblade_handle_awareness() {
  self endon("disconnect");
  self botsetawareness(2.5);
  self waittill("control_func_done");
  self botsetawareness(1.0);
}

missile_find_ground_target(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = (var_1 - var_0.origin[2]) / var_2[2];
  var_4 = var_0.origin + var_2 * var_3;
  return var_4;
}

watch_end_switchblade() {
  self endon("disconnect");
  self waittill("control_func_done");
  self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

find_cluster_rocket_for_bot(var_0) {
  for(;;) {
    foreach(var_2 in level.rockets) {
      if(isDefined(var_2) && var_2.owner == var_0) {
        return var_2;
      }
    }

    wait 0.05;
  }
}

vanguard_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed()) {
    return 0;
  }

  if(scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots("vanguard")) {
    return 0;
  }

  return 1;
}

bot_killstreak_vanguard_start(var_0, var_1, var_2, var_3) {
  bot_killstreak_remote_control(var_0, var_1, var_2, var_3, 1);
}

isusingvanguard() {
  return scripts\mp\utility\game::isusingremote() && self.usingremote == "vanguard" && isDefined(self.remoteuav);
}

bot_control_vanguard() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_0 = bot_waittill_using_vehicle("vanguard");

  if(!var_0) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.remoteuav;
  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("death");
  wait 0.5;
  var_1 = 0;
  var_2 = !self.vehicle_controlling vanguard_is_outside();
  var_3 = undefined;
  var_4 = 0;
  var_5 = is_indoor_map();

  while(var_2 && !var_5) {
    var_6 = getnodesinradiussorted(self.vehicle_controlling.origin, 1024, 64, 512, "path");

    if(isDefined(var_3)) {
      var_6 = scripts\engine\utility::array_remove(var_6, var_3);
    }

    foreach(var_8 in var_6) {
      if(node_is_valid_outside_for_vanguard(var_8)) {
        var_3 = var_8;
        break;
      }

      wait 0.05;
      var_1 = var_1 + 0.05;
    }

    if(var_1 < 1.0) {
      wait(1.0 - var_1);
    }

    if(!isDefined(var_3)) {
      self botpressbutton("use", 4.0);
      wait 4.0;
    }

    var_10 = scripts\mp\bots\bots_util::bot_queued_process("GetNodesOnPathVanguard", scripts\mp\bots\bots_util::func_get_nodes_on_path, self.vehicle_controlling.origin, var_3.origin);

    if(!isDefined(var_10)) {
      if(var_4 == 0) {
        var_4++;
        wait 0.05;
        continue;
      } else {
        self botpressbutton("use", 4.0);
        wait 4.0;
      }
    }

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      var_12 = var_10[var_11];

      if(var_11 == 0 && distancesquared(self.origin, var_12.origin) < 1600) {
        continue;
      }
      var_13 = 32;

      if(var_11 == var_10.size - 1) {
        var_13 = 16;
      }

      var_14 = self.vehicle_controlling.origin;
      var_15 = gettime() + 2500;

      while(distance2dsquared(var_12.origin, self.vehicle_controlling.origin) > var_13 * var_13) {
        if(self.vehicle_controlling vanguard_is_outside()) {
          var_11 = var_10.size;
          break;
        }

        if(gettime() > var_15) {
          var_15 = gettime() + 2500;
          var_16 = distancesquared(self.vehicle_controlling.origin, var_14);

          if(var_16 < 1.0) {
            var_11++;
            break;
          }

          var_14 = self.vehicle_controlling.origin;
        }

        var_17 = vectornormalize(var_12.origin - self.vehicle_controlling.origin);
        self botsetscriptmove(vectortoangles(var_17)[1], 0.2);
        self botlookatpoint(var_12.origin, 0.2, "script_forced");
        var_18 = var_12.origin[2] + 64;
        var_19 = var_18 - self.vehicle_controlling.origin[2];

        if(var_19 > 10) {
          self botpressbutton("lethal");
        } else if(var_19 < -10) {
          self botpressbutton("tactical");
        }

        wait 0.05;
      }
    }

    var_2 = 0;

    if(!self.vehicle_controlling vanguard_is_outside()) {
      var_2 = 1;
    }
  }

  self botsetscriptmove(0, 0);
  self botlookatpoint(undefined);
  self childthread[[level.bot_ks_funcs["control_aiming"]["vanguard"]]]();
  var_21 = self.vehicle_controlling.origin[2];
  var_22 = undefined;
  var_23 = gettime() + 2000;
  var_24 = [];
  var_24[0] = (1, 0, 0);
  var_24[1] = (-1, 0, 0);
  var_24[2] = (0, 1, 0);
  var_24[3] = (0, -1, 0);
  var_24[4] = (1, 1, 0);
  var_24[5] = (1, -1, 0);
  var_24[6] = (-1, 1, 0);
  var_24[7] = (-1, -1, 0);
  var_25 = find_closest_heli_node_2d(self.vehicle_controlling.origin, "vanguard");

  while(var_25.vanguard_origin[2] - self.vehicle_controlling.origin[2] > 20) {
    if(gettime() > var_23) {
      var_23 = gettime() + 2000;

      if(isDefined(var_22)) {
        var_22 = undefined;
      } else {
        var_19 = self.vehicle_controlling.origin[2] - var_21;

        if(var_19 < 20 && !var_5) {
          var_26 = scripts\engine\utility::array_randomize(var_24);

          foreach(var_28 in var_26) {
            if(pos_passes_sky_trace(self.vehicle_controlling.origin + var_28 * 64)) {
              if(!bullettracepassed(self.vehicle_controlling.origin, self.vehicle_controlling.origin + var_28 * 64, 0, self.vehicle_controlling)) {
                wait 0.05;
                continue;
              }

              var_22 = var_28;
              break;
            }

            wait 0.05;
          }
        }
      }

      var_21 = self.vehicle_controlling.origin[2];
    }

    if(isDefined(var_22)) {
      self botsetscriptmove(vectortoangles(var_22)[1], 0.05);

      if(scripts\engine\utility::cointoss()) {
        self botpressbutton("tactical");
      }
    } else
      self botpressbutton("lethal");

    wait 0.05;
  }

  wait 1.0;
  wait 1.0;
  self botsetflag("disable_movement", 0);
  bot_control_heli_main_move_loop("vanguard", 0);
  self notify("control_func_done");
}

pos_is_valid_outside_for_vanguard(var_0) {
  var_1 = getclosestnodeinsight(var_0);

  if(isDefined(var_1)) {
    return node_is_valid_outside_for_vanguard(var_1);
  }

  return 0;
}

node_is_valid_outside_for_vanguard(var_0) {
  if(nodeexposedtosky(var_0)) {
    return pos_passes_sky_trace(var_0.origin);
  }

  return 0;
}

pos_passes_sky_trace(var_0) {
  var_1 = var_0;
  var_2 = var_0 + (0, 0, level.bot_vanguard_height_trace_size);

  if(var_2[2] <= var_1[2]) {
    return 0;
  }

  var_3 = bullettracepassed(var_1, var_2, 0, undefined);
  return var_3;
}

vanguard_is_outside() {
  var_0 = getclosestnodeinsight(self.origin);

  if(isDefined(var_0) && !nodeexposedtosky(var_0)) {
    return 0;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (18, 0, 25))) {
    return 0;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (-18, 0, 25))) {
    return 0;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, 18, 25))) {
    return 0;
  }

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, -18, 25))) {
    return 0;
  }

  return 1;
}

vanguard_control_aiming() {
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
    } else if(var_5 < 10.0) {
      foreach(var_12 in level.characters) {
        if(var_12 == self || !isalive(var_12)) {
          continue;
        }
        if(var_12 scripts\mp\utility\game::_hasperk("specialty_noplayertarget")) {
          continue;
        }
        if(!isDefined(var_12.team)) {
          continue;
        }
        if(!level.teambased || self.team != var_12.team) {
          if(scripts\engine\utility::within_fov(var_7, var_8, var_12.origin, var_9)) {
            var_5 = var_5 + 0.05;

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
      if((isai(var_6) || isplayer(var_6)) && length(var_6 getentityvelocity()) < 25) {
        var_0 = var_6.origin;
      } else if(gettime() - var_3 < 500) {
        if(var_4 != var_6) {
          var_0 = var_6.origin;
        }
      } else if(gettime() - var_3 > 500) {
        var_3 = gettime();
        var_0 = getpredictedentityposition(var_6, 3.0);
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

vanguard_pick_node(var_0) {
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

bot_vanguard_find_unvisited_nodes(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0.neighbors) {
    if(isDefined(var_4.script_linkname) && var_4.valid_for_vanguard) {
      var_5 = var_4.bot_visited_times[self.entity_number];

      if(var_5 < var_1) {
        var_2 = [];
        var_2[0] = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

vanguard_get_node_origin(var_0) {
  return var_0.vanguard_origin;
}

origin_is_valid_for_vanguard(var_0) {
  var_1 = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2 delete();
  return var_1;
}

heli_sniper_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed()) {
    return 0;
  }

  return 1;
}

heli_sniper_waittill_initial_goal() {
  self.vehicle_controlling waittill("near_goal");
}

bot_control_heli_sniper() {
  thread heli_sniper_clear_script_goal_on_ride();
  bot_control_heli("heli_sniper");
}

heli_sniper_clear_script_goal_on_ride() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self botclearscriptgoal();
}

heli_sniper_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = bot_heli_find_unvisited_nodes(var_0);
  return heli_pick_node_furthest_from_center(var_1, "heli_sniper");
}

heli_pilot_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed()) {
    return 0;
  }

  return 1;
}

heli_pilot_waittill_initial_goal() {
  self.vehicle_controlling waittill("goal_reached");
}

bot_control_heli_pilot() {
  bot_control_heli("heli_pilot");
}

heli_pilot_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = bot_heli_find_unvisited_nodes(var_0);
  var_2 = scripts\engine\utility::random(var_1);
  return var_2;
}

heli_pilot_monitor_flares() {
  self notify("heli_pilot_monitor_flares");
  self endon("heli_pilot_monitor_flares");
  var_0 = [];

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    self.vehicle_controlling waittill("targeted_by_incoming_missile", var_1);
    var_2 = 1;

    foreach(var_4 in var_1) {
      if(isDefined(var_4) && !scripts\engine\utility::array_contains(var_0, var_4)) {
        var_2 = 0;
      }
    }

    if(!var_2) {
      var_6 = clamp(0.34 * self botgetdifficultysetting("strategyLevel"), 0.0, 1.0);

      if(randomfloat(1.0) < var_6) {
        self notify("manual_flare_popped");
      }

      var_0 = scripts\engine\utility::array_combine(var_0, var_1);
      var_0 = scripts\engine\utility::array_removeundefined(var_0);
      wait 3.0;
    }
  }
}

heli_pilot_control_heli_aiming() {
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
        var_7 = var_7 + 0.05;

        if(var_7 > 5.0) {
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

      var_2 = var_2 + var_5;
      var_14 = self.vehicle_controlling gettagorigin("tag_player");
      var_15 = vectornormalize(var_2 - var_14);
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

bot_control_odin_assault() {
  bot_control_odin("odin_assault");
}

odin_assault_perform_action() {
  if(func_2E3A()) {
    return 1;
  }

  if(func_2E38()) {
    return 1;
  }

  if(func_2E36()) {
    return 1;
  }

  return 0;
}

odin_assault_get_target() {
  return func_2E2B();
}

func_2E2B() {
  var_0 = undefined;

  if(isDefined(self.last_large_rod_target) && gettime() - self.last_large_rod_time < 5000) {
    var_0 = self.last_large_rod_target;
  }

  return func_2E2C("enemy", 1, var_0);
}

func_2E38() {
  var_0 = func_2E34();

  if(var_0 == "large") {
    self notify("large_rod_action");
    return 1;
  }

  if(var_0 == "small") {
    self notify("small_rod_action");
    return 1;
  }

  return 0;
}

func_2E34() {
  var_0 = gettime() >= self.odin.odin_largerodusetime;
  var_1 = gettime() >= self.odin.odin_smallrodusetime;

  if(var_0 || var_1) {
    var_2 = func_2E30("enemy", 0);
    var_3 = [];
    var_4 = distancesquared(self.origin, self.odin.targeting_marker.origin);

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      var_6 = func_2E2F(var_2[var_5]);
      var_3[var_5] = distancesquared(self.odin.targeting_marker.origin, var_6);
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

bot_control_odin_support() {
  bot_control_odin("odin_support");
}

odin_support_perform_action() {
  if(func_2E3A()) {
    return 1;
  }

  if(func_2E36()) {
    return 1;
  }

  if(func_2E39()) {
    return 1;
  }

  if(func_2E37()) {
    return 1;
  }

  return 0;
}

func_2E37() {
  if(func_2E33()) {
    self notify("marking_action");
    return 1;
  }

  return 0;
}

func_2E33() {
  if(gettime() < self.odin.odin_markingusetime) {
    return 0;
  }

  var_0 = func_2E30("enemy", 0);
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = func_2E2F(var_0[var_2]);
    var_1[var_2] = distancesquared(self.odin.targeting_marker.origin, var_3);

    if(var_1[var_2] < squared(level.odin_flash_radius / 2)) {
      return 1;
    }
  }

  return 0;
}

func_2E39() {
  if(func_2E32()) {
    self notify("smoke_action");
    return 1;
  }

  return 0;
}

func_2E32() {
  if(gettime() < self.odin.odin_smokeusetime) {
    return 0;
  }

  var_0 = func_2E2D();

  foreach(var_2 in var_0) {
    if(distancesquared(var_2, self.odin.targeting_marker.origin) < 2500) {
      return 1;
    }
  }

  var_4 = undefined;

  if(isDefined(self.odin.targeting_marker.nearest_node)) {
    var_4 = getnodezone(self.odin.targeting_marker.nearest_node);
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = bot_killstreak_get_zone_enemies_outside(1);
  var_6 = var_5[var_4].size;

  if(var_6 >= 2) {
    return 1;
  }

  return 0;
}

func_2E2D() {
  var_0 = [];

  if(gettime() < self.odin.odin_smokeusetime) {
    return var_0;
  }

  foreach(var_2 in level.carepackages) {
    if(scripts\mp\bots\bots::crate_landed_and_on_path_grid(var_2)) {
      var_3[0] = self;
      var_4 = scripts\engine\utility::get_array_of_closest(var_2.origin, level.players, var_3);

      if(var_4.size > 0 && var_4[0].team == self.team) {
        var_0 = scripts\engine\utility::array_add(var_0, var_2.origin);
      }
    }
  }

  var_6 = func_2E30("ally", 0);

  foreach(var_8 in var_6) {
    if(isai(var_8) && var_8 scripts\mp\bots\bots_util::bot_is_capturing()) {
      var_0 = scripts\engine\utility::array_add(var_0, var_8.origin);
    }
  }

  return var_0;
}

odin_support_get_target() {
  var_0 = func_2E2D();

  if(var_0.size > 0) {
    return var_0[0];
  }

  return func_2E2C("enemy", 1);
}

monitor_odin_marker() {
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

bot_control_odin(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_1 = bot_waittill_using_vehicle(var_0);

  if(!var_1) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.odin;
  childthread bot_end_control_on_vehicle_death(self.odin);
  self.odin endon("death");
  wait 1.4;
  self botsetawareness(0.7);
  thread bot_end_odin_watcher();
  self.odin_predicted_loc_for_player = [];
  self.odin_predicted_loc_time_for_player = [];
  self.odin_last_predict_position_time = 0;
  var_2 = undefined;
  var_3 = 0;
  var_4 = undefined;
  childthread monitor_odin_marker();
  var_5 = self.odin.targeting_marker.origin;
  var_6 = gettime();

  while(self[[level.bot_ks_funcs["isUsing"][var_0]]]()) {
    var_7 = self[[level.bot_ks_funcs["odin_perform_action"][var_0]]]();

    if(gettime() > var_6 + 2000) {
      var_6 = gettime();
      var_8 = distance(var_5, self.odin.targeting_marker.origin);
      var_5 = self.odin.targeting_marker.origin;

      if(var_8 < 100) {
        var_4 = undefined;
        var_2 = undefined;
      }
    }

    if(gettime() > var_3 || !isDefined(var_4)) {
      var_9 = level.var_2E35[self botgetdifficulty()];
      var_3 = gettime() + var_9 * 1000;
      var_10 = self[[level.bot_ks_funcs["odin_get_target"][var_0]]]();

      if(isDefined(var_10)) {
        var_2 = undefined;

        if(isplayer(var_10)) {
          var_4 = func_2E2F(var_10);
        } else {
          var_4 = var_10;
        }
      } else {
        if(!isDefined(var_2)) {
          var_2 = scripts\engine\utility::random(level.outside_zones);
        }

        var_11 = getzonenodeforindex(var_2).origin;

        if(distance2dsquared(self.odin.targeting_marker.origin, var_11) < 10000) {
          var_2 = scripts\engine\utility::random(level.outside_zones);
          var_11 = getzonenodeforindex(var_2).origin;
          var_6 = gettime();
        }

        var_4 = var_11;
      }
    }

    var_12 = var_4 - self.odin.targeting_marker.origin;

    if(lengthsquared(var_12) > 100) {
      var_13 = vectortoangles(var_12);
      self botsetscriptmove(var_13[1], 0.05);
      self botlookatpoint(var_4, 0.1, "script_forced");
    } else
      var_6 = gettime();

    wait 0.05;
  }

  self notify("control_func_done");
}

bot_end_odin_watcher(var_0) {
  self endon("disconnect");
  self waittill("control_func_done");
  self.odin_predicted_loc_for_player = undefined;
  self.odin_predicted_loc_time_for_player = undefined;
  self.odin_last_predict_position_time = undefined;
  self botsetawareness(1.0);
}

func_2E2F(var_0) {
  if(level.teambased && self.team == var_0.team) {
    return var_0.origin;
  } else {
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
      var_4 = vectornormalize(var_0 getentityvelocity());
      var_5 = vectornormalize(self.odin_predicted_loc_for_player[var_1] - var_0.origin);

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
}

func_2E2C(var_0, var_1, var_2) {
  var_3 = func_2E30(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = scripts\engine\utility::array_remove(var_3, var_2);
  }

  if(var_3.size > 0) {
    var_4 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_3);
    return var_4[0];
  }

  return undefined;
}

func_2E3A() {
  if(gettime() >= self.odin.odin_juggernautusetime) {
    if(!isDefined(self.odin.targeting_marker.nearest_node)) {
      return 0;
    }
  }

  return 0;
}

func_2E2A() {
  return func_2E2C("ally", 0);
}

func_2E36() {
  if(func_2E31()) {
    self notify("airdrop_action");
    self notify("juggernaut_action");
    return 1;
  }

  return 0;
}

func_2E31() {
  if(gettime() < self.odin.odin_airdropusetime) {
    return 0;
  }

  if(!isDefined(self.odin.targeting_marker.nearest_node)) {
    return 0;
  }

  if(func_2E2E() > 2) {
    return 0;
  }

  if(!isDefined(self.odin.targeting_marker.nearest_point_on_pathgrid)) {
    return 0;
  }

  var_0 = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = bot_killstreak_get_zone_allies_outside(1);
  var_2 = var_1[var_0].size;
  var_3 = bot_killstreak_get_zone_enemies_outside(1);
  var_4 = var_3[var_0].size;

  if(var_2 == 0) {
    return 0;
  }

  if(var_4 == 0) {
    var_5 = 0;
    var_6 = func_2E30("enemy", 1);

    foreach(var_8 in var_6) {
      if(distancesquared(var_8.origin, self.odin.targeting_marker.origin) < 14400) {
        var_5 = 1;
      }
    }

    if(!var_5) {
      return 1;
    }
  }

  if(var_2 - var_4 >= 2) {
    var_10 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_1[var_0]);
    var_11 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_3[var_0]);
    var_12 = distance(self.odin.targeting_marker.origin, var_10[0].origin);
    var_13 = distance(self.odin.targeting_marker.origin, var_11[0].origin);

    if(var_12 + 120 < var_13) {
      return 1;
    }
  }

  return 0;
}

func_2E2E() {
  var_0 = 0;

  foreach(var_2 in level.carepackages) {
    if(isDefined(var_2) && scripts\mp\bots\bots::crate_landed_and_on_path_grid(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

func_2E30(var_0, var_1, var_2) {
  var_3 = bot_killstreak_get_outside_players(self.team, var_0, var_1);
  var_4 = self botgetfovdot();
  var_5 = [];

  foreach(var_7 in var_3) {
    var_8 = 0;
    var_9 = var_4;

    if(var_0 == "enemy") {
      var_9 = var_9 * 0.9;
    }

    if(scripts\engine\utility::within_fov(self.vehicle_controlling.origin, self getplayerangles(), var_7.origin, var_9)) {
      if(!var_8 || self botcanseeentity(var_7)) {
        var_5 = scripts\engine\utility::array_add(var_5, var_7);
      }
    }
  }

  return var_5;
}

is_indoor_map() {
  return level.script == "mp_sovereign";
}

bot_body_is_dead() {
  return isDefined(self.fauxdeath) && self.fauxdeath;
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
    return scripts\engine\utility::random(var_0);
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
      var_2[var_7] = scripts\engine\utility::array_add(var_2[var_7], var_5);
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
    var_2[var_7] = scripts\engine\utility::array_add(var_2[var_7], var_5);
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
        var_3 = scripts\engine\utility::array_add(var_3, var_6);
      }
    }
  }

  var_3 = scripts\engine\utility::array_remove(var_3, self);
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
      } else if(var_5 == var_1)
        var_2[var_2.size] = var_4;
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
      var_5 = [
        [level.bot_ks_funcs["heli_pick_node"][var_0]]
      ](var_5);
      var_6 = undefined;

      if(isDefined(var_5)) {
        var_13 = [[level.bot_ks_funcs["heli_node_get_origin"][var_0]]](var_5);

        if(var_1) {
          var_14 = var_5.origin + (scripts\mp\utility\game::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset);
          var_15 = var_5.origin + (scripts\mp\utility\game::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset);
          var_16 = bulletTrace(var_14, var_15, 0, undefined, 0, 0, 1);
          var_6 = var_16["position"] - scripts\mp\utility\game::gethelipilotmeshoffset() + level.bot_ks_heli_offset[var_0];
        } else
          var_6 = var_13;
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
        var_20 = scripts\engine\utility::ter_op(var_8 < bot_get_heli_slowdown_dist_sq(var_1), 0.5, 1.0);
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
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  var_5 = undefined;

  if(var_0.size > 0) {
    var_6 = scripts\engine\utility::random(var_0);
    var_7 = scripts\engine\utility::random(getzonenodes(var_6));
    var_5 = var_7.origin;
  } else {
    if(isDefined(level.teleportgetactivenodesfunc)) {
      var_8 = [
        }
        [level.teleportgetactivenodesfunc]]();
    else {
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

isusinggunship() {
  return isDefined(self.onhelisniper) && self.onhelisniper;
}