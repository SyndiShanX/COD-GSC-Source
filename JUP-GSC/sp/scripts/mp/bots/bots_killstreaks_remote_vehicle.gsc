/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_killstreaks_remote_vehicle.gsc
***************************************************************/



#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_killstreaks;
#using scripts\mp\bots\bots_util;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\killstreaks\helicopter_pilot;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace bots_killstreaks_remote_vehicle;

function remote_vehicle_setup() {
  while(!isDefined(level.bot_variables_initialized)) {
    wait 0.05;
  }

  if(isDefined(level.bot_initialized_remote_vehicles)) {
    return;
  }

  level.bot_ks_heli_offset["heli_pilot"] = (0, 0, 350);
  level.bot_ks_heli_offset["heli_sniper"] = (0, 0, 228);
  level.bot_ks_funcs["isUsing"]["odin_assault"] = &isusingremote;
  level.bot_ks_funcs["isUsing"]["odin_support"] = &isusingremote;
  level.bot_ks_funcs["isUsing"]["heli_pilot"] = &isusingremote;
  level.bot_ks_funcs["isUsing"]["switchblade_cluster"] = &isusingremote;
  level.bot_ks_funcs["isUsing"]["vanguard"] = &isusingvanguard;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_pilot"] = &heli_pilot_waittill_initial_goal;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_sniper"] = &heli_sniper_waittill_initial_goal;
  level.bot_ks_funcs["control_aiming"]["heli_pilot"] = &heli_pilot_control_heli_aiming;
  level.bot_ks_funcs["control_aiming"]["heli_sniper"] = &empty_init_func;
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
  var_8f50e25425117ebb = getStructArray("so_chopper_boss_path_struct", "script_noteworthy");
  level.bot_heli_nodes = [];

  foreach(heli_node in var_8f50e25425117ebb) {
    if(isDefined(heli_node.script_linkname)) {
      level.bot_heli_nodes = array_add(level.bot_heli_nodes, heli_node);
    }
  }

  level.bot_heli_pilot_traceoffset = gethelipilottraceoffset();

  if(!isDefined(level.var_ff63f8885446f880) || level.var_ff63f8885446f880 == 0) {
    thread function_afae965b7274c594(level.bot_heli_nodes);
  }

  foreach(node in level.bot_heli_nodes) {
    node.vanguard_origin = node.origin;
    test_point = node.origin + (0, 0, 50);
    node.valid_for_vanguard = 1;

    if(test_point[2] <= node.origin[2] - 1000) {
      node.valid_for_vanguard = 0;
    }

    test_point -= (0, 0, 50);
    node.vanguard_origin = test_point;
  }

  var_2c5952770e2c04c7 = -99999999;

  foreach(node in level.bot_heli_nodes) {
    var_2c5952770e2c04c7 = max(var_2c5952770e2c04c7, node.origin[2]);
  }

  level.bot_vanguard_height_trace_size = var_2c5952770e2c04c7 - level.bot_map_min_z + 100;
  level.heli_pilot_missile_radius = getdvarfloat(@ "hash_d2076b53b3ed5d25");

  while(!isDefined(level.odin_marking_flash_radius_max) || !isDefined(level.odin_marking_flash_radius_min)) {
    wait 0.05;
  }

  level.odin_flash_radius = (level.odin_marking_flash_radius_max + level.odin_marking_flash_radius_min) / 2;
  level.outside_zones = [];

  if(isDefined(level.teleportgetactivepathnodezonesfunc)) {
    all_zones = [[level.teleportgetactivepathnodezonesfunc]]();
  } else {
    all_zones = [];

    for(i = 0; i < level.zonecount; i++) {
      all_zones[all_zones.size] = i;
    }
  }

  foreach(z in all_zones) {
    if(botzonegetindoorpercent(z) < 0.25) {
      level.outside_zones = array_add(level.outside_zones, z);
    }
  }

  level.bot_odin_time_to_move["recruit"] = 1;
  level.bot_odin_time_to_move["regular"] = 0.7;
  level.bot_odin_time_to_move["hardened"] = 0.4;
  level.bot_odin_time_to_move["veteran"] = 0.05;
  level.bot_initialized_remote_vehicles = 1;
}

function function_afae965b7274c594(nodes) {
  wait 5;
  bot_waittill_bots_enabled(1);
  assertex(nodes.size > 2, "<dev string:x1c>");
  var_9da54672706d7f6 = gethelipilotmeshoffset();
  var_1a5872d69399180a = level.bot_heli_pilot_traceoffset;

  foreach(heli_node in nodes) {
    tracestart = heli_node.origin + var_9da54672706d7f6 + var_1a5872d69399180a;
    traceend = heli_node.origin + var_9da54672706d7f6 - var_1a5872d69399180a;
    traceresult = scripts\engine\trace::_bullet_trace(tracestart, traceend, 0, undefined, 0, 0, 1);
    assertex(isDefined(traceresult["<dev string:x3f>"]), "<dev string:x46>" + heli_node.origin);
    wait 0.05;
  }

  thread bot_draw_debug_heli_nodes(nodes);
}

function bot_draw_debug_heli_nodes(nodes) {
  self notify("<dev string:x7c>");
  self endon("<dev string:x7c>");
  level endon("<dev string:x96>");

  while(true) {
    var_a36233594d4132b2 = getDvar(@ "hash_2113a3b9387cd9f0") == "<dev string:xa7>";
    var_524cf965d318bd67 = getDvar(@ "hash_2113a3b9387cd9f0") == "<dev string:xb2>";

    if(var_a36233594d4132b2 || var_524cf965d318bd67) {
      current_nodes = nodes;

      for(i = 0; i < current_nodes.size; i++) {
        node_color = (0, 1, 1);

        if(var_524cf965d318bd67) {
          if(!current_nodes[i].valid_for_vanguard) {
            node_color = (1, 0, 0);
          } else if(!bot_vectors_are_equal(current_nodes[i].origin, current_nodes[i].vanguard_origin)) {
            node_color = (1, 0, 0);
            line(current_nodes[i].origin, current_nodes[i].vanguard_origin, (1, 0, 0), 1, 1);
            bot_draw_cylinder(current_nodes[i].vanguard_origin - (0, 0, 5), 10, 12, 0.05, undefined, (0, 1, 1), 1, 4);
          }
        }

        bot_draw_cylinder(current_nodes[i].origin - (0, 0, 5), 10, 12, 0.05, undefined, node_color, 1, 4);

        foreach(neighbor_node in current_nodes[i].neighbors) {
          if(isDefined(neighbor_node.script_linkname) && array_contains(current_nodes, neighbor_node)) {
            link_color = (0, 1, 1);

            if(var_524cf965d318bd67) {
              if(current_nodes[i].valid_for_vanguard && neighbor_node.valid_for_vanguard) {
                if(!bot_vectors_are_equal(current_nodes[i].origin, current_nodes[i].vanguard_origin) || !bot_vectors_are_equal(neighbor_node.origin, neighbor_node.vanguard_origin)) {
                  line(current_nodes[i].vanguard_origin, neighbor_node.vanguard_origin, link_color, 1, 1);
                  link_color = (1, 0, 0);
                }
              } else {
                link_color = (1, 0, 0);
              }
            }

            line(current_nodes[i].origin, neighbor_node.origin, link_color, 1, 1);
          }
        }

        current_nodes[i] = current_nodes[current_nodes.size - 1];
        current_nodes[current_nodes.size - 1] = undefined;
        i--;
      }
    }

    wait 0.05;
  }
}

function bot_killstreak_remote_control(killstreak_info, killstreaks_array, canusefunc, controlfunc, var_b66780ccc01efb67) {
  if(!isDefined(controlfunc)) {
    return false;
  }

  var_dbb558d52b4c440a = 1;
  var_7cea91ce15f22cfb = 1;
  hidenode = undefined;

  if(isDefined(self.node_ambushing_from)) {
    script_goal_radius = self botgetscriptgoalRadius();
    var_fb39425801b89150 = distancesquared(self.origin, self.node_ambushing_from.origin);

    if(var_fb39425801b89150 < squared(script_goal_radius)) {
      var_dbb558d52b4c440a = 0;
      var_7cea91ce15f22cfb = 0;
    } else if(var_fb39425801b89150 < squared(200)) {
      var_dbb558d52b4c440a = 0;
    }
  }

  var_c5d3a24c7d4a692a = killstreak_info.streakname == "vanguard" && is_indoor_map();

  if(var_c5d3a24c7d4a692a || var_dbb558d52b4c440a) {
    var_c49a42fa6b3f0e0d = getnodesinradius(self.origin, 500, 0, 512);

    if(isDefined(var_c49a42fa6b3f0e0d) && var_c49a42fa6b3f0e0d.size > 0) {
      if(isDefined(var_b66780ccc01efb67) && var_b66780ccc01efb67) {
        var_1e5601905a854ce = var_c49a42fa6b3f0e0d;
        var_c49a42fa6b3f0e0d = [];

        foreach(node in var_1e5601905a854ce) {
          if(nodeexposedtosky(node)) {
            linked_nodes = getlinkednodes(node);
            var_39a704609da1c730 = 0;

            foreach(linked_node in linked_nodes) {
              if(nodeexposedtosky(linked_node)) {
                var_39a704609da1c730++;
              }
            }

            if(var_39a704609da1c730 / linked_nodes.size > 0.5) {
              var_c49a42fa6b3f0e0d = array_add(var_c49a42fa6b3f0e0d, node);
            }
          }
        }
      }

      if(var_c5d3a24c7d4a692a) {
        nodes = self botnodescoremultiple(var_c49a42fa6b3f0e0d, "node_exposed");

        foreach(node in nodes) {
          if(scripts\engine\trace::_bullet_trace_passed(node.origin + (0, 0, 30), node.origin + (0, 0, 400), 0, self)) {
            hidenode = node;
            break;
          }

          wait 0.05;
        }
      } else if(var_c49a42fa6b3f0e0d.size > 0) {
        hidenode = self botnodepick(var_c49a42fa6b3f0e0d, min(3, var_c49a42fa6b3f0e0d.size), "node_hide");
      }

      if(!isDefined(hidenode)) {
        return false;
      }

      self botsetscriptgoalnode(hidenode, "tactical");
    }
  }

  if(var_7cea91ce15f22cfb) {
    result = bot_waittill_goal_or_fail();

    if(result != "goal") {
      try_clear_hide_goal(hidenode);
      return true;
    }
  }

  if(isDefined(canusefunc) && !self[[canusefunc]]()) {
    try_clear_hide_goal(hidenode);
    return false;
  }

  if(!bot_allowed_to_use_killstreaks()) {
    try_clear_hide_goal(hidenode);
    return true;
  }

  if(!isDefined(hidenode)) {
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

  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
  self.vehicle_controlling = undefined;
  self thread[[controlfunc]]();
  thread bot_end_control_on_respawn();
  thread bot_end_control_watcher(hidenode);
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

function bot_end_control_watcher(hidenode) {
  self endon("disconnect");
  self waittill("control_func_done");
  try_clear_hide_goal(hidenode);
  self botsetstance("none");
  self botsetscriptmove(0, 0);
  self botsetflag("disable_movement", 0);
  self botsetflag("disable_rotation", 0);
  self.vehicle_controlling = undefined;
}

function try_clear_hide_goal(hidenode) {
  if(isDefined(hidenode) && self bothasscriptgoal() && isDefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == hidenode) {
    self botclearscriptgoal();
  }
}

function bot_end_control_on_vehicle_death(vehicle) {
  vehicle waittill("death");
  self notify("control_func_done");
}

function bot_waittill_using_vehicle(type) {
  time_started = gettime();

  while(!self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    wait 0.05;

    if(gettime() - time_started > 5000) {
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
  childthread handle_disable_rotation();
  result = bot_waittill_using_vehicle("switchblade_cluster");

  if(!result) {
    self notify("control_func_done");
  }

  thread switchblade_handle_awareness();
  current_rocket = find_cluster_rocket_for_bot(self);
  wait 0.1;
  self.oldmaxsightdistsqrd = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 256000000;
  thread watch_end_switchblade();
  var_e90afab3a285b685 = undefined;
  var_794601ee02db5f4e = 0;
  var_170b960d75247aa1 = 0;
  mini_missiles = [];
  var_2412210e2e3096bf = undefined;
  has_boosted = 0;
  var_8791a8af9c5e338 = 0;
  target_loc = undefined;
  locked_target = undefined;
  var_aed9dfefe5515810 = 0;
  var_9473dcb5d22dc5b = is_indoor_map();

  while(self[[level.bot_ks_funcs["isUsing"]["switchblade_cluster"]]]() && isDefined(current_rocket)) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket) && rocket.owner == self && rocket.weapon_name == "switch_blade_child_mp") {
        should_add = 1;

        foreach(missile_struct in mini_missiles) {
          if(missile_struct.rocket == rocket) {
            should_add = 0;
          }
        }

        if(should_add) {
          var_4043b25178528dc6 = spawnStruct();
          var_4043b25178528dc6.rocket = rocket;
          var_4043b25178528dc6.target = var_2412210e2e3096bf;
          var_2412210e2e3096bf = undefined;
          mini_missiles = array_add(mini_missiles, var_4043b25178528dc6);
        }
      }
    }

    for(i = 0; i < mini_missiles.size; i++) {
      missile_struct = mini_missiles[i];

      if(isDefined(missile_struct) && isDefined(missile_struct.rocket) && !array_contains(level.rockets, missile_struct.rocket)) {
        mini_missiles[i] = mini_missiles[mini_missiles.size - 1];
        mini_missiles[mini_missiles.size - 1] = undefined;
        i--;
      }
    }

    if(var_aed9dfefe5515810) {
      wait 0.05;
      continue;
    }

    best_target = undefined;

    if(isDefined(locked_target)) {
      best_target = locked_target;

      if(!isalive(locked_target) || !self botcanseeentity(best_target)) {
        if(!isalive(locked_target)) {
          var_aed9dfefe5515810 = 1;
        }

        wait 0.05;
        continue;
      }
    }

    visible_enemies = [];

    if(!isDefined(best_target)) {
      enemies = bot_killstreak_get_all_outside_enemies(0);
      var_d7a0a05144ceb764 = [];

      foreach(missile_struct in mini_missiles) {
        if(isDefined(missile_struct.target)) {
          var_d7a0a05144ceb764 = array_add(var_d7a0a05144ceb764, missile_struct.target);
        }
      }

      enemies = array_remove_array(enemies, var_d7a0a05144ceb764);

      foreach(enemy in enemies) {
        if(enemy _hasperk("specialty_noplayertarget")) {
          continue;
        }

        if(self botcanseeentity(enemy) || var_9473dcb5d22dc5b && within_fov(self getEye(), current_rocket.angles, enemy.origin, self botgetfovdot())) {
          if(!bot_body_is_dead() && distancesquared(enemy.origin, self.origin) < 40000) {
            continue;
          }

          visible_enemies = array_add(visible_enemies, enemy);

          if(!isDefined(best_target)) {
            best_target = enemy;
            continue;
          }

          var_bc34c62bee0e91fe = vectorNormalize(best_target.origin - current_rocket.origin);
          var_c16733d994283f04 = vectorNormalize(enemy.origin - current_rocket.origin);
          rocket_orientation = anglesToForward(current_rocket.angles);
          var_24b6e3ea8f396ba1 = vectordot(var_bc34c62bee0e91fe, rocket_orientation);
          var_df6e6d84fb19825b = vectordot(var_c16733d994283f04, rocket_orientation);

          if(var_df6e6d84fb19825b > var_24b6e3ea8f396ba1) {
            best_target = enemy;
          }
        }
      }
    }

    if(isDefined(best_target)) {
      var_e90afab3a285b685 = undefined;
      var_798c31d3a6fe9e79 = current_rocket.origin[2] - best_target.origin[2];
      bot_difficulty = self botgetdifficulty();

      if(bot_difficulty == "recruit") {
        target_loc = best_target.origin;
      } else if(var_798c31d3a6fe9e79 < 5000) {
        target_loc = best_target.origin;
      } else if(length(best_target getentityvelocity()) < 25) {
        target_loc = best_target.origin;
      } else if(gettime() - var_8791a8af9c5e338 > 500) {
        var_8791a8af9c5e338 = gettime();
        var_e7d4a44eb0a17fa4 = 3;

        if(bot_difficulty == "regular") {
          var_e7d4a44eb0a17fa4 = 1;
        }

        target_loc = getpredictedentityposition(best_target, var_e7d4a44eb0a17fa4);
      }

      desired_angles = missile_get_desired_angles_to_target(current_rocket, target_loc);
      var_f7fac0901f2d27d8 = missile_get_distance_to_target(current_rocket, target_loc);

      if(var_f7fac0901f2d27d8 < 30) {
        speed = 0;
      } else if(var_f7fac0901f2d27d8 < 100) {
        speed = 0.15;
      } else if(var_f7fac0901f2d27d8 < 200) {
        speed = 0.3;
      } else if(var_f7fac0901f2d27d8 < 400) {
        speed = 0.6;
      } else {
        speed = 1;
      }

      if(has_boosted) {
        speed = min(speed * 3, 1);
      }

      if(speed > 0) {
        self botsetscriptmove(desired_angles[1], 0.05, speed, 1, 1);
      } else if(gettime() > var_170b960d75247aa1) {
        if(var_794601ee02db5f4e < 2) {
          self botpressbutton("attack");
          var_794601ee02db5f4e++;
          var_170b960d75247aa1 = gettime() + 200;

          if(bot_difficulty == "regular" && var_794601ee02db5f4e == 2 || bot_difficulty == "hardened" || bot_difficulty == "veteran") {
            var_dcac7cd909bf4f2a = var_794601ee02db5f4e == 1 && visible_enemies.size == 1;

            if(!var_dcac7cd909bf4f2a) {
              var_2412210e2e3096bf = best_target;
              var_170b960d75247aa1 += 800;
            }
          }
        } else if(!has_boosted && (var_798c31d3a6fe9e79 < 5000 || bot_difficulty == "recruit")) {
          has_boosted = 1;
          self botpressbutton("attack");

          if(bot_difficulty == "recruit") {
            locked_target = best_target;
          }
        }
      }
    } else {
      if(!isDefined(var_e90afab3a285b685)) {
        var_e90afab3a285b685 = random(level.outside_zones);
      }

      zone_origin = getzonenodeforindex(var_e90afab3a285b685).origin;

      if(missile_get_distance_to_target(current_rocket, zone_origin) < 200) {
        var_e90afab3a285b685 = random(level.outside_zones);
        zone_origin = getzonenodeforindex(var_e90afab3a285b685).origin;
      }

      desired_angles = missile_get_desired_angles_to_target(current_rocket, zone_origin);
      self botsetscriptmove(desired_angles[1], 0.05, 0.75, 1, 1);
    }

    wait 0.05;
  }

  self notify("control_func_done");
}

function missile_get_desired_angles_to_target(missile, target_origin) {
  current_target = missile_find_ground_target(missile, target_origin[2]);
  var_322abd791d0ad262 = vectorNormalize(target_origin - current_target);
  return vectortoangles(var_322abd791d0ad262);
}

function missile_get_distance_to_target(missile, target_origin) {
  current_target = missile_find_ground_target(missile, target_origin[2]);
  return distance(current_target, target_origin);
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

function missile_find_ground_target(missile, var_8099cdf91fa07077) {
  missile_dir = anglesToForward(missile.angles);
  var_ab276aabf08e332d = (var_8099cdf91fa07077 - missile.origin[2]) / missile_dir[2];
  var_6d4eaa166902b863 = missile.origin + missile_dir * var_ab276aabf08e332d;
  return var_6d4eaa166902b863;
}

function watch_end_switchblade() {
  self endon("disconnect");
  self waittill("control_func_done");
  self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

function find_cluster_rocket_for_bot(bot) {
  while(true) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket) && rocket.owner == bot) {
        return rocket;
      }
    }

    wait 0.05;
  }
}

function vanguard_allowed() {
  if(!aerial_vehicle_allowed()) {
    return false;
  }

  return true;
}

function bot_killstreak_vanguard_start(killstreak_info, killstreaks_array, canusefunc, controlfunc) {
  bot_killstreak_remote_control(killstreak_info, killstreaks_array, canusefunc, controlfunc, 1);
}

function isusingvanguard() {
  return isusingremote() && self.usingremote == "vanguard" && isDefined(self.remoteuav);
}

function bot_control_vanguard() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  result = bot_waittill_using_vehicle("vanguard");

  if(!result) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.remoteuav;
  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);

  childthread function_dd40097206fb80bc(self.vehicle_controlling);

  self.vehicle_controlling endon("death");
  wait 0.5;
  var_eeb18c09526831f4 = 0;
  var_e41c6322cb5a215 = !self.vehicle_controlling vanguard_is_outside();
  outside_target = undefined;
  var_44ee720d1b6f774f = 0;
  var_9473dcb5d22dc5b = is_indoor_map();

  while(var_e41c6322cb5a215 && !var_9473dcb5d22dc5b) {
    nodes = getnodesinradiussorted(self.vehicle_controlling.origin, 1024, 64, 512, "path");

    if(isDefined(outside_target)) {
      nodes = array_remove(nodes, outside_target);
    }

    foreach(potential_target in nodes) {
      if(node_is_valid_outside_for_vanguard(potential_target)) {
        outside_target = potential_target;
        break;
      }

      wait 0.05;
      var_eeb18c09526831f4 += 0.05;
    }

    if(var_eeb18c09526831f4 < 1) {
      wait 1 - var_eeb18c09526831f4;
    }

    if(!isDefined(outside_target)) {
      assertmsg("Bot tried to use Vanguard from location " + self.origin + " but couldn't find an outside node within a 1024 unit radius");
      self botpressbutton("use", 4);
      wait 4;
    }

    path = bot_queued_process("GetNodesOnPathVanguard", &func_get_nodes_on_path, self.vehicle_controlling.origin, outside_target.origin);

    if(!isDefined(path)) {
      if(var_44ee720d1b6f774f == 0) {
        var_44ee720d1b6f774f++;
        wait 0.05;
        continue;
      } else {
        self botpressbutton("use", 4);
        wait 4;
      }
    }

    for(i = 0; i < path.size; i++) {
      next_node = path[i];

      if(i == 0 && distancesquared(self.origin, next_node.origin) < 1600) {
        continue;
      }

      var_4a38ab365344a40d = 32;

      if(i == path.size - 1) {
        var_4a38ab365344a40d = 16;
      }

      last_pos = self.vehicle_controlling.origin;
      var_94699e558d940f9c = gettime() + 2500;

      while(distance2dsquared(next_node.origin, self.vehicle_controlling.origin) > var_4a38ab365344a40d * var_4a38ab365344a40d) {
        if(self.vehicle_controlling vanguard_is_outside()) {
          i = path.size;
          break;
        }

        if(gettime() > var_94699e558d940f9c) {
          var_94699e558d940f9c = gettime() + 2500;
          var_3c36fa26dca3c9d5 = distancesquared(self.vehicle_controlling.origin, last_pos);

          if(var_3c36fa26dca3c9d5 < 1) {
            i++;
            break;
          }

          last_pos = self.vehicle_controlling.origin;
        }

        var_91d0ac94ff8ebc89 = vectorNormalize(next_node.origin - self.vehicle_controlling.origin);
        self botsetscriptmove(vectortoangles(var_91d0ac94ff8ebc89)[1], 0.2);
        self botlookatpoint(next_node.origin, 0.2, "script_forced");
        desired_height = next_node.origin[2] + 64;
        height_difference = desired_height - self.vehicle_controlling.origin[2];

        if(height_difference > 10) {
          self botpressbutton("lethal");
        } else if(height_difference < -10) {
          self botpressbutton("tactical");
        }

        if(getdvarint(@ "ai_showpaths") == 1) {
          line(self.vehicle_controlling.origin, path[i].origin + (0, 0, 64), (0, 0, 1), 1, 0, 4);

          for(j = i; j < path.size - 1; j++) {
            line(path[j].origin + (0, 0, 64), path[j + 1].origin + (0, 0, 64), (0, 0, 1), 1, 0, 4);
          }
        }

        wait 0.05;
      }
    }

    var_e41c6322cb5a215 = 0;

    if(!self.vehicle_controlling vanguard_is_outside()) {
      var_e41c6322cb5a215 = 1;
    }
  }

  self botsetscriptmove(0, 0);
  self botlookatpoint(undefined);
  self childthread[[level.bot_ks_funcs["control_aiming"]["vanguard"]]]();
  last_height = self.vehicle_controlling.origin[2];
  var_bf6d8f35cb3b4b6a = undefined;
  var_6ba1a69e97d56e55 = gettime() + 2000;
  possible_directions = [];
  possible_directions[0] = (1, 0, 0);
  possible_directions[1] = (-1, 0, 0);
  possible_directions[2] = (0, 1, 0);
  possible_directions[3] = (0, -1, 0);
  possible_directions[4] = (1, 1, 0);
  possible_directions[5] = (1, -1, 0);
  possible_directions[6] = (-1, 1, 0);
  possible_directions[7] = (-1, -1, 0);
  var_71f05487c401c762 = find_closest_heli_node_2d(self.vehicle_controlling.origin, "vanguard");

  while(var_71f05487c401c762.vanguard_origin[2] - self.vehicle_controlling.origin[2] > 20) {
    if(gettime() > var_6ba1a69e97d56e55) {
      var_6ba1a69e97d56e55 = gettime() + 2000;

      if(isDefined(var_bf6d8f35cb3b4b6a)) {
        var_bf6d8f35cb3b4b6a = undefined;
      } else {
        height_difference = self.vehicle_controlling.origin[2] - last_height;

        if(height_difference < 20 && !var_9473dcb5d22dc5b) {
          directions = array_randomize(possible_directions);

          foreach(direction in directions) {
            if(pos_passes_sky_trace(self.vehicle_controlling.origin + direction * 64)) {
              if(!scripts\engine\trace::_bullet_trace_passed(self.vehicle_controlling.origin, self.vehicle_controlling.origin + direction * 64, 0, self.vehicle_controlling)) {
                wait 0.05;
                continue;
              }

              var_bf6d8f35cb3b4b6a = direction;
              break;
            }

            wait 0.05;
          }
        }
      }

      last_height = self.vehicle_controlling.origin[2];
    }

    if(isDefined(var_bf6d8f35cb3b4b6a)) {
      if(getdvarint(@ "ai_showpaths") == 1) {
        line(self.vehicle_controlling.origin, self.vehicle_controlling.origin + var_bf6d8f35cb3b4b6a * 64, (0, 1, 0), 1, 1);
      }

      self botsetscriptmove(vectortoangles(var_bf6d8f35cb3b4b6a)[1], 0.05);

      if(cointoss()) {
        self botpressbutton("tactical");
      }
    } else {
      self botpressbutton("lethal");
    }

    wait 0.05;
  }

  wait 1;
  wait 1;
  self botsetflag("disable_movement", 0);
  bot_control_heli_main_move_loop("vanguard", 0);
  self notify("control_func_done");
}

function function_dd40097206fb80bc(vehicle) {
  vehicle waittill("<dev string:xcb>", reason);

  if(isDefined(reason)) {
    assertex(reason != "<dev string:xd1>", "<dev string:xdd>" + getDvar(@ "g_mapname"));
  }
}

function pos_is_valid_outside_for_vanguard(pos) {
  nearest_node = getclosestnodeinsight(pos);

  if(isDefined(nearest_node)) {
    return node_is_valid_outside_for_vanguard(nearest_node);
  }

  return 0;
}

function node_is_valid_outside_for_vanguard(node) {
  if(nodeexposedtosky(node)) {
    return pos_passes_sky_trace(node.origin);
  }

  return 0;
}

function pos_passes_sky_trace(pos) {
  start = pos;
  end = pos + (0, 0, level.bot_vanguard_height_trace_size);

  if(end[2] <= start[2]) {
    return 0;
  }

  result = scripts\engine\trace::_bullet_trace_passed(start, end, 0, undefined);
  return result;
}

function vanguard_is_outside() {
  nearest_node = getclosestnodeinsight(self.origin);

  if(isDefined(nearest_node) && !nodeexposedtosky(nearest_node)) {
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
  target_loc = undefined;
  var_befbf47bff2227bd = 0;
  var_d9084b43307ecda8 = gettime();
  var_8791a8af9c5e338 = 0;
  var_5ecf1d67365182c1 = undefined;
  var_46219a6a94dc3f7e = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["vanguard"]]]()) {
    var_47eca5045634214a = undefined;
    eye_pos = self getEye();
    eye_angles = self getplayerangles();
    bot_fov = self botgetfovdot();

    if(isalive(self.enemy) && self botcanseeentity(self.enemy)) {
      var_776ba3f458aa7ee9 = 1;
      var_47eca5045634214a = self.enemy;
      var_46219a6a94dc3f7e = 0;
    } else if(var_46219a6a94dc3f7e < 10) {
      foreach(character in level.characters) {
        if(character == self || !isalive(character)) {
          continue;
        }

        if(character _hasperk("specialty_noplayertarget")) {
          continue;
        }

        if(!isDefined(character.team)) {
          continue;
        }

        if(!level.teambased || self.team != character.team) {
          if(within_fov(eye_pos, eye_angles, character.origin, bot_fov)) {
            var_46219a6a94dc3f7e += 0.05;

            if(isDefined(var_47eca5045634214a)) {
              var_95290e32a23b47f3 = distancesquared(self.vehicle_controlling.origin, var_47eca5045634214a.origin);
              var_1b19c0b9ce3c8aed = distancesquared(self.vehicle_controlling.origin, character.origin);

              if(var_1b19c0b9ce3c8aed < var_95290e32a23b47f3) {
                var_47eca5045634214a = character;
              }

              continue;
            }

            var_47eca5045634214a = character;
          }
        }
      }
    }

    if(isDefined(var_47eca5045634214a)) {
      if((isai(var_47eca5045634214a) || isPlayer(var_47eca5045634214a)) && length(var_47eca5045634214a getentityvelocity()) < 25) {
        target_loc = var_47eca5045634214a.origin;
      } else if(gettime() - var_8791a8af9c5e338 < 500) {
        if(var_5ecf1d67365182c1 != var_47eca5045634214a) {
          target_loc = var_47eca5045634214a.origin;
        }
      } else if(gettime() - var_8791a8af9c5e338 > 500) {
        var_8791a8af9c5e338 = gettime();
        target_loc = getpredictedentityposition(var_47eca5045634214a, 3);
        var_5ecf1d67365182c1 = var_47eca5045634214a;
      }

      var_91d341c821bd4d3f = 165;

      if(gettime() - var_d9084b43307ecda8 > 10000) {
        var_91d341c821bd4d3f = 200;
      }

      if(distancesquared(self.vehicle_controlling.attackarrow.origin, target_loc) < level.vanguard_missile_radius * level.vanguard_missile_radius) {
        if(bot_body_is_dead() || distancesquared(self.vehicle_controlling.attackarrow.origin, self.origin) > level.vanguard_missile_radius * level.vanguard_missile_radius) {
          var_d9084b43307ecda8 = gettime();
          self botpressbutton("attack");
        }
      }
    } else if(gettime() > var_befbf47bff2227bd) {
      var_befbf47bff2227bd = gettime() + randomintrange(1000, 2000);
      target_loc = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    if(length(target_loc) == 0) {
      target_loc = (0, 0, 10);
    }

    self botlookatpoint(target_loc, 0.2, "script_forced");
    wait 0.05;
  }
}

function vanguard_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;
  var_fcec43ee4c57ab6e = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](current_node);
  best_nodes = bot_vanguard_find_unvisited_nodes(current_node);
  var_b09396f0b1b602bf = best_nodes;
  best_nodes = [];

  foreach(node in var_b09396f0b1b602bf) {
    if(node.valid_for_vanguard) {
      if(current_node.origin[2] != current_node.vanguard_origin[2] || node.origin[2] != node.vanguard_origin[2]) {
        node_origin = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](node);
        hitpos = playerphysicstrace(var_fcec43ee4c57ab6e, node_origin);

        if(distancesquared(hitpos, node_origin) < 1) {
          best_nodes = array_add(best_nodes, node);
        }

        wait 0.05;
        continue;
      }

      best_nodes = array_add(best_nodes, node);
    }
  }

  if(best_nodes.size == 0 && var_b09396f0b1b602bf.size > 0) {
    foreach(node in var_b09396f0b1b602bf) {
      node.bot_visited_times[self.entity_number]++;
    }
  }

  return heli_pick_node_furthest_from_center(best_nodes, "vanguard");
}

function bot_vanguard_find_unvisited_nodes(current_node) {
  var_dfb97cdfd9440698 = 99;
  best_nodes = [];

  foreach(node in current_node.neighbors) {
    if(isDefined(node.script_linkname) && node.valid_for_vanguard) {
      var_58c720ac2b13bfa6 = node.bot_visited_times[self.entity_number];

      if(var_58c720ac2b13bfa6 < var_dfb97cdfd9440698) {
        best_nodes = [];
        best_nodes[0] = node;
        var_dfb97cdfd9440698 = var_58c720ac2b13bfa6;
        continue;
      }

      if(var_58c720ac2b13bfa6 == var_dfb97cdfd9440698) {
        best_nodes[best_nodes.size] = node;
      }
    }
  }

  return best_nodes;
}

function vanguard_get_node_origin(node) {
  return node.vanguard_origin;
}

function origin_is_valid_for_vanguard(origin) {
  result = 1;
  var_350c03e8095bb7a4 = spawn_tag_origin();
  var_350c03e8095bb7a4.origin = origin;
  var_350c03e8095bb7a4 delete();
  return result;
}

function heli_sniper_allowed() {
  if(!aerial_vehicle_allowed()) {
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

function heli_sniper_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;
  best_nodes = bot_heli_find_unvisited_nodes(current_node);
  return heli_pick_node_furthest_from_center(best_nodes, "heli_sniper");
}

function heli_pilot_allowed() {
  if(!aerial_vehicle_allowed()) {
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

function heli_pilot_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;
  best_nodes = bot_heli_find_unvisited_nodes(current_node);
  node_picked = random(best_nodes);
  return node_picked;
}

function heli_pilot_monitor_flares() {
  self notify("heli_pilot_monitor_flares");
  self endon("heli_pilot_monitor_flares");
  missiles_checked = [];

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    self.vehicle_controlling waittill("targeted_by_incoming_missile", missiles);

    if(!scripts\mp\killstreaks\flares::flares_areavailable(self.vehicle_controlling)) {
      break;
    }

    var_cf626ef12d877f28 = 1;

    foreach(missile in missiles) {
      if(isDefined(missile) && !array_contains(missiles_checked, missile)) {
        var_cf626ef12d877f28 = 0;
      }
    }

    if(!var_cf626ef12d877f28) {
      var_8b686f26e9129e3c = clamp(0.34 * self botgetdifficultysetting("strategyLevel"), 0, 1);

      if(randomfloat(1) < var_8b686f26e9129e3c) {
        self notify("manual_flare_popped");
      }

      missiles_checked = array_combine(missiles_checked, missiles);
      missiles_checked = array_removeundefined(missiles_checked);
      wait 3;
    }
  }
}

function heli_pilot_control_heli_aiming() {
  self notify("heli_pilot_control_heli_aiming");
  self endon("heli_pilot_control_heli_aiming");
  var_4ac4b608421ecbbb = undefined;
  last_enemy_seen = undefined;
  target_loc = undefined;
  var_befbf47bff2227bd = 0;
  var_ea189b55de5c8fa7 = 0;
  inaccuracy_vector = undefined;
  bot_inaccuracy = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  var_def9c228381a493a = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    var_d430bcda6275a38b = 0;
    var_4b05a8497817406a = 0;

    if(isDefined(last_enemy_seen) && last_enemy_seen.health <= 0 && gettime() - last_enemy_seen.deathtime < 2000) {
      var_d430bcda6275a38b = 1;
      var_4b05a8497817406a = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var_d430bcda6275a38b = 1;
      last_enemy_seen = self.enemy;
      var_4ac4b608421ecbbb = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var_def9c228381a493a = 0;
        var_4b05a8497817406a = 1;
        var_b8cccb951e8a65c4 = gettime();
      } else {
        var_def9c228381a493a += 0.05;

        if(var_def9c228381a493a > 5) {
          var_d430bcda6275a38b = 0;
        }
      }
    }

    if(var_d430bcda6275a38b) {
      target_loc = var_4ac4b608421ecbbb - (0, 0, 50);

      if(var_4b05a8497817406a && (bot_body_is_dead() || distancesquared(target_loc, self.origin) > level.heli_pilot_missile_radius * level.heli_pilot_missile_radius)) {
        self botpressbutton("attack");
      }

      if(gettime() > var_ea189b55de5c8fa7 + 500) {
        random_x = randomfloatrange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        random_y = randomfloatrange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        random_z = randomfloatrange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        inaccuracy_vector = (150 * random_x, 150 * random_y, 150 * random_z);
        var_ea189b55de5c8fa7 = gettime();
      }

      target_loc += inaccuracy_vector;
      var_61ce3a6ebf0b28a6 = self.vehicle_controlling gettagorigin("tag_player");
      var_df61cd3f6f7e9f85 = vectorNormalize(target_loc - var_61ce3a6ebf0b28a6);
      player_angles = anglesToForward(self getplayerangles());
      dot = vectordot(var_df61cd3f6f7e9f85, player_angles);

      if(dot > 0.5) {
        self botpressbutton("ads", 0.1);
      }
    } else if(gettime() > var_befbf47bff2227bd) {
      var_befbf47bff2227bd = gettime() + randomintrange(1000, 2000);
      target_loc = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    var_a558729c23606f06 = target_loc - self.vehicle_controlling.origin;
    var_aafce4cbf21021ed = length(var_a558729c23606f06);
    var_e2bfebea4ace23db = vectortoangles(var_a558729c23606f06);
    vehicle_pitch = angleclamp(self.vehicle_controlling.angles[0]);
    var_f33538adaae5e75d = angleclamp(var_e2bfebea4ace23db[0]);
    dist = int(vehicle_pitch - var_f33538adaae5e75d) % 360;

    if(dist > 180) {
      dist = 360 - dist;
    } else if(dist < -180) {
      dist = -360 + dist;
    }

    if(dist > 15) {
      var_f33538adaae5e75d = vehicle_pitch - 15;
    } else if(dist < -15) {
      var_f33538adaae5e75d = vehicle_pitch + 15;
    }

    var_e2bfebea4ace23db = (var_f33538adaae5e75d, var_e2bfebea4ace23db[1], var_e2bfebea4ace23db[2]);
    var_a558729c23606f06 = anglesToForward(var_e2bfebea4ace23db);
    target_loc = self.vehicle_controlling.origin + var_a558729c23606f06 * var_aafce4cbf21021ed;

    if(length(target_loc) == 0) {
      target_loc = (0, 0, 10);
    }

    self botlookatpoint(target_loc, 0.2, "script_forced");
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
  var_d91860896d0a8573 = undefined;

  if(isDefined(self.last_large_rod_target) && gettime() - self.last_large_rod_time < 5000) {
    var_d91860896d0a8573 = self.last_large_rod_target;
  }

  return bot_odin_get_closest_visible_outside_player("enemy", 1, var_d91860896d0a8573);
}

function bot_odin_try_rods() {
  var_e74293c1e1d5f3e3 = bot_odin_should_fire_rod_at_marker();

  if(var_e74293c1e1d5f3e3 == "large") {
    self notify("large_rod_action");
    return true;
  }

  if(var_e74293c1e1d5f3e3 == "small") {
    self notify("small_rod_action");
    return true;
  }

  return false;
}

function bot_odin_should_fire_rod_at_marker() {
  var_c42a5a5477738232 = gettime() >= self.odin.odin_largerodusetime;
  var_6757435ad2fcad1a = gettime() >= self.odin.odin_smallrodusetime;

  if(var_c42a5a5477738232 || var_6757435ad2fcad1a) {
    outside_enemies = bot_odin_get_visible_outside_players("enemy", 0);
    var_124d8ff097468ad2 = [];
    var_3004663d1f820632 = distancesquared(self.origin, self.odin.targeting_marker.origin);

    for(i = 0; i < outside_enemies.size; i++) {
      var_e5207ee0fbb4d144 = bot_odin_get_player_target_point(outside_enemies[i]);
      var_124d8ff097468ad2[i] = distancesquared(self.odin.targeting_marker.origin, var_e5207ee0fbb4d144);
    }

    if(var_c42a5a5477738232) {
      if(!bot_body_is_dead() && var_3004663d1f820632 < level.odin_large_rod_radius * level.odin_large_rod_radius) {
        return "none";
      }

      for(i = 0; i < outside_enemies.size; i++) {
        if(var_124d8ff097468ad2[i] < squared(level.odin_large_rod_radius)) {
          self.last_large_rod_target = outside_enemies[i];
          self.last_large_rod_time = gettime();
          return "large";
        }
      }
    }

    if(var_6757435ad2fcad1a) {
      if(!bot_body_is_dead() && var_3004663d1f820632 < level.odin_small_rod_radius * level.odin_small_rod_radius) {
        return "none";
      }

      for(i = 0; i < outside_enemies.size; i++) {
        if(var_124d8ff097468ad2[i] < squared(level.odin_small_rod_radius)) {
          if(isDefined(self.last_large_rod_target) && self.last_large_rod_target == outside_enemies[i] && gettime() - self.last_large_rod_time < 5000) {
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

  outside_enemies = bot_odin_get_visible_outside_players("enemy", 0);
  var_124d8ff097468ad2 = [];

  for(i = 0; i < outside_enemies.size; i++) {
    var_e5207ee0fbb4d144 = bot_odin_get_player_target_point(outside_enemies[i]);
    var_124d8ff097468ad2[i] = distancesquared(self.odin.targeting_marker.origin, var_e5207ee0fbb4d144);

    if(var_124d8ff097468ad2[i] < squared(level.odin_flash_radius / 2)) {
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

  var_c8c8ff4b4d6f5a35 = bot_odin_get_high_priority_smoke_locations();

  foreach(location in var_c8c8ff4b4d6f5a35) {
    if(distancesquared(location, self.odin.targeting_marker.origin) < 2500) {
      return true;
    }
  }

  marker_zone = undefined;

  if(isDefined(self.odin.targeting_marker.nearest_node)) {
    marker_zone = getnodezone(self.odin.targeting_marker.nearest_node);
  }

  if(!isDefined(marker_zone)) {
    return false;
  }

  zone_enemies = bot_killstreak_get_zone_enemies_outside(1);
  var_e2d98fc247820509 = zone_enemies[marker_zone].size;

  if(var_e2d98fc247820509 >= 2) {
    return true;
  }

  return false;
}

function bot_odin_get_high_priority_smoke_locations() {
  desired_locations = [];

  if(gettime() < self.odin.odin_smokeusetime) {
    return desired_locations;
  }

  foreach(package in level.carepackages) {
    if(crate_landed_and_on_path_grid(package)) {
      excluders[0] = self;
      players_sorted = get_array_of_closest(package.origin, level.players, excluders);

      if(players_sorted.size > 0 && players_sorted[0].team == self.team) {
        desired_locations = array_add(desired_locations, package.origin);
      }
    }
  }

  outside_allies = bot_odin_get_visible_outside_players("ally", 0);

  foreach(ally in outside_allies) {
    if(isai(ally) && ally bot_is_capturing()) {
      desired_locations = array_add(desired_locations, ally.origin);
    }
  }

  return desired_locations;
}

function odin_support_get_target() {
  var_7f1ac86a3f1bbef6 = bot_odin_get_high_priority_smoke_locations();

  if(var_7f1ac86a3f1bbef6.size > 0) {
    return var_7f1ac86a3f1bbef6[0];
  }

  return bot_odin_get_closest_visible_outside_player("enemy", 1);
}

function monitor_odin_marker() {
  while(true) {
    self.odin.targeting_marker.nearest_node = getclosestnodeinsight(self.odin.targeting_marker.origin);

    if(bot_point_is_on_pathgrid(self.odin.targeting_marker.origin, 200)) {
      self.odin.targeting_marker.nearest_point_on_pathgrid = self.odin.targeting_marker.origin;
    } else {
      self.odin.targeting_marker.nearest_point_on_pathgrid = undefined;
    }

    wait 0.25;
  }
}

function bot_control_odin(type) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  result = bot_waittill_using_vehicle(type);

  if(!result) {
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
  var_e90afab3a285b685 = undefined;
  next_move_time = 0;
  move_loc = undefined;
  childthread monitor_odin_marker();
  var_ef47868ca10dcc01 = self.odin.targeting_marker.origin;
  var_fd9c9bcd1e914113 = gettime();

  while(self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    var_85eefbe482eaee42 = self[[level.bot_ks_funcs["odin_perform_action"][type]]]();

    if(gettime() > var_fd9c9bcd1e914113 + 2000) {
      var_fd9c9bcd1e914113 = gettime();
      marker_moved = distance(var_ef47868ca10dcc01, self.odin.targeting_marker.origin);
      var_ef47868ca10dcc01 = self.odin.targeting_marker.origin;

      if(marker_moved < 100) {
        move_loc = undefined;
        var_e90afab3a285b685 = undefined;
      }
    }

    if(gettime() > next_move_time || !isDefined(move_loc)) {
      time_to_move = level.bot_odin_time_to_move[self botgetdifficulty()];
      next_move_time = gettime() + time_to_move * 1000;
      desired_target = self[[level.bot_ks_funcs["odin_get_target"][type]]]();

      if(isDefined(desired_target)) {
        var_e90afab3a285b685 = undefined;

        if(isPlayer(desired_target)) {
          move_loc = bot_odin_get_player_target_point(desired_target);
        } else {
          move_loc = desired_target;
        }
      } else {
        if(!isDefined(var_e90afab3a285b685)) {
          var_e90afab3a285b685 = random(level.outside_zones);
        }

        zone_origin = getzonenodeforindex(var_e90afab3a285b685).origin;

        if(distance2dsquared(self.odin.targeting_marker.origin, zone_origin) < 10000) {
          var_e90afab3a285b685 = random(level.outside_zones);
          zone_origin = getzonenodeforindex(var_e90afab3a285b685).origin;
          var_fd9c9bcd1e914113 = gettime();
        }

        move_loc = zone_origin;
      }
    }

    var_437878fc8700d152 = move_loc - self.odin.targeting_marker.origin;

    if(lengthsquared(var_437878fc8700d152) > 100) {
      var_1b8e1fad87be8f97 = vectortoangles(var_437878fc8700d152);
      self botsetscriptmove(var_1b8e1fad87be8f97[1], 0.05);
      self botlookatpoint(move_loc, 0.1, "script_forced");
    } else {
      var_fd9c9bcd1e914113 = gettime();
    }

    wait 0.05;
  }

  self notify("control_func_done");
}

function bot_end_odin_watcher(hidenode) {
  self endon("disconnect");
  self waittill("control_func_done");
  self.odin_predicted_loc_for_player = undefined;
  self.odin_predicted_loc_time_for_player = undefined;
  self.odin_last_predict_position_time = undefined;
  self botsetawareness(1);
}

function bot_odin_get_player_target_point(player) {
  if(level.teambased && self.team == player.team) {
    return player.origin;
  }

  if(length(player getentityvelocity()) < 25) {
    return player.origin;
  }

  var_e6be2f834ce26751 = player getentitynumber();

  if(!isDefined(self.odin_predicted_loc_time_for_player[var_e6be2f834ce26751])) {
    self.odin_predicted_loc_time_for_player[var_e6be2f834ce26751] = 0;
  }

  cur_time = gettime();
  var_a7711337581db22e = cur_time - self.odin_predicted_loc_time_for_player[var_e6be2f834ce26751];

  if(var_a7711337581db22e <= 400) {
    player_velocity = vectorNormalize(player getentityvelocity());
    var_8bc6cf48c44d94ca = vectorNormalize(self.odin_predicted_loc_for_player[var_e6be2f834ce26751] - player.origin);

    if(vectordot(player_velocity, var_8bc6cf48c44d94ca) < -0.5) {
      return player.origin;
    }
  }

  if(var_a7711337581db22e > 400) {
    if(cur_time == self.odin_last_predict_position_time) {
      if(var_a7711337581db22e > 1000) {
        return player.origin;
      }
    } else {
      self.odin_predicted_loc_for_player[var_e6be2f834ce26751] = getpredictedentityposition(player, 1.5);
      self.odin_predicted_loc_time_for_player[var_e6be2f834ce26751] = cur_time;
      self.odin_last_predict_position_time = cur_time;
    }
  }

  return self.odin_predicted_loc_for_player[var_e6be2f834ce26751];
}

function bot_odin_get_closest_visible_outside_player(type, only_players, var_d91860896d0a8573) {
  visible_players = bot_odin_get_visible_outside_players(type, only_players);

  if(isDefined(var_d91860896d0a8573)) {
    visible_players = array_remove(visible_players, var_d91860896d0a8573);
  }

  if(visible_players.size > 0) {
    var_a7d47ac97d19d2e4 = get_array_of_closest(self.odin.targeting_marker.origin, visible_players);
    return var_a7d47ac97d19d2e4[0];
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

  marker_zone = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(marker_zone)) {
    return false;
  }

  zone_allies = bot_killstreak_get_zone_allies_outside(1);
  var_a891caa86bc4a7f7 = zone_allies[marker_zone].size;
  zone_enemies = bot_killstreak_get_zone_enemies_outside(1);
  var_e2d98fc247820509 = zone_enemies[marker_zone].size;

  if(var_a891caa86bc4a7f7 == 0) {
    return false;
  }

  if(var_e2d98fc247820509 == 0) {
    var_9ac378b966278a36 = 0;
    visible_enemies = bot_odin_get_visible_outside_players("enemy", 1);

    foreach(enemy in visible_enemies) {
      if(distancesquared(enemy.origin, self.odin.targeting_marker.origin) < 14400) {
        var_9ac378b966278a36 = 1;
      }
    }

    if(!var_9ac378b966278a36) {
      return true;
    }
  }

  if(var_a891caa86bc4a7f7 - var_e2d98fc247820509 >= 2) {
    allies_sorted = get_array_of_closest(self.odin.targeting_marker.origin, zone_allies[marker_zone]);
    enemies_sorted = get_array_of_closest(self.odin.targeting_marker.origin, zone_enemies[marker_zone]);
    closest_ally_dist = distance(self.odin.targeting_marker.origin, allies_sorted[0].origin);
    var_d512083e84b3ce24 = distance(self.odin.targeting_marker.origin, enemies_sorted[0].origin);

    if(closest_ally_dist + 120 < var_d512083e84b3ce24) {
      return true;
    }
  }

  return false;
}

function bot_odin_get_num_valid_care_packages() {
  count = 0;

  foreach(package in level.carepackages) {
    if(isDefined(package) && crate_landed_and_on_path_grid(package)) {
      count++;
    }
  }

  return count;
}

function bot_odin_get_visible_outside_players(type, only_players, var_885e7a840bdd3128) {
  outside_players = bot_killstreak_get_outside_players(self.team, type, only_players);
  var_3a7e2e5eb062a1d0 = self botgetfovdot();
  visible_outside_players = [];

  foreach(player in outside_players) {
    check_sight = 0;
    fov_dot = var_3a7e2e5eb062a1d0;

    if(type == "enemy") {
      fov_dot *= 0.9;
    }

    if(within_fov(self.vehicle_controlling.origin, self getplayerangles(), player.origin, fov_dot)) {
      if(!check_sight || self botcanseeentity(player)) {
        visible_outside_players = array_add(visible_outside_players, player);
      }
    }
  }

  return visible_outside_players;
}

function is_indoor_map() {
  return level.script == "mp_sovereign";
}

function bot_body_is_dead() {
  return isDefined(self.fauxdead) && self.fauxdead;
}

function heli_pick_node_furthest_from_center(nodes, type) {
  farthest_node = undefined;
  var_8e18414d09ac1595 = 0;

  foreach(node in nodes) {
    var_4c5056d533e11e6a = distancesquared(level.bot_map_center, [[level.bot_ks_funcs["heli_node_get_origin"][type]]](node));

    if(var_4c5056d533e11e6a > var_8e18414d09ac1595) {
      var_8e18414d09ac1595 = var_4c5056d533e11e6a;
      farthest_node = node;
    }
  }

  if(isDefined(farthest_node)) {
    return farthest_node;
  }

  return random(nodes);
}

function heli_get_node_origin(node) {
  return node.origin;
}

function find_closest_heli_node_2d(origin, type) {
  var_21d0b4a644efa190 = undefined;
  var_9106952186a9a611 = 99999999;

  foreach(node in level.bot_heli_nodes) {
    var_1dce2d1958040081 = distance2dsquared(origin, [[level.bot_ks_funcs["heli_node_get_origin"][type]]](node));

    if(var_1dce2d1958040081 < var_9106952186a9a611) {
      var_21d0b4a644efa190 = node;
      var_9106952186a9a611 = var_1dce2d1958040081;
    }
  }

  return var_21d0b4a644efa190;
}

function bot_killstreak_get_zone_allies_outside(only_players) {
  outside_allies = bot_killstreak_get_all_outside_allies(only_players);
  zone_allies = [];

  for(i = 0; i < level.zonecount; i++) {
    zone_allies[i] = [];
  }

  foreach(ally in outside_allies) {
    nearest_node = ally getnearestnode();
    zone = getnodezone(nearest_node);

    if(isDefined(zone)) {
      zone_allies[zone] = array_add(zone_allies[zone], ally);
    }
  }

  return zone_allies;
}

function bot_killstreak_get_zone_enemies_outside(only_players) {
  outside_enemies = bot_killstreak_get_all_outside_enemies(only_players);
  zone_enemies = [];

  for(i = 0; i < level.zonecount; i++) {
    zone_enemies[i] = [];
  }

  foreach(enemy in outside_enemies) {
    nearest_node = enemy getnearestnode();
    zone = getnodezone(nearest_node);
    zone_enemies[zone] = array_add(zone_enemies[zone], enemy);
  }

  return zone_enemies;
}

function bot_killstreak_get_all_outside_enemies(only_players) {
  return bot_killstreak_get_outside_players(self.team, "enemy", only_players);
}

function bot_killstreak_get_all_outside_allies(only_players) {
  return bot_killstreak_get_outside_players(self.team, "ally", only_players);
}

function bot_killstreak_get_outside_players(team, type, only_players) {
  outside_players = [];
  all_players = level.participants;

  if(isDefined(only_players) && only_players) {
    all_players = level.players;
  }

  foreach(player in all_players) {
    if(player == self || !isalive(player)) {
      continue;
    }

    is_valid_player = 0;

    if(type == "ally") {
      is_valid_player = level.teambased && team == player.team;
    } else if(type == "enemy") {
      is_valid_player = !level.teambased || team != player.team;
    }

    if(is_valid_player) {
      var_cf74bc7c70f92eb6 = player getnearestnode();

      if(isDefined(var_cf74bc7c70f92eb6) && nodeexposedtosky(var_cf74bc7c70f92eb6)) {
        outside_players = array_add(outside_players, player);
      }
    }
  }

  outside_players = array_remove(outside_players, self);
  return outside_players;
}

function bot_heli_find_unvisited_nodes(current_node) {
  var_dfb97cdfd9440698 = 99;
  best_nodes = [];

  foreach(node in current_node.neighbors) {
    if(isDefined(node.script_linkname)) {
      var_58c720ac2b13bfa6 = node.bot_visited_times[self.entity_number];

      if(var_58c720ac2b13bfa6 < var_dfb97cdfd9440698) {
        best_nodes = [];
        best_nodes[0] = node;
        var_dfb97cdfd9440698 = var_58c720ac2b13bfa6;
        continue;
      }

      if(var_58c720ac2b13bfa6 == var_dfb97cdfd9440698) {
        best_nodes[best_nodes.size] = node;
      }
    }
  }

  return best_nodes;
}

function bot_control_heli(type) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  result = bot_waittill_using_vehicle(type);

  if(!result) {
    self notify("control_func_done");
  }

  foreach(bird in level.littlebirds) {
    if(bird.owner == self) {
      self.vehicle_controlling = bird;
    }
  }

  assert(isDefined(self.vehicle_controlling));
  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("death");

  if(isDefined(level.bot_ks_funcs["control_other"][type])) {
    self childthread[[level.bot_ks_funcs["control_other"][type]]]();
  }

  self[[level.bot_ks_funcs["waittill_initial_goal"][type]]]();
  self childthread[[level.bot_ks_funcs["control_aiming"][type]]]();
  bot_control_heli_main_move_loop(type, 1);
  self notify("control_func_done");
}

function bot_get_heli_goal_dist_sq(var_c3edbf19a4808cd4) {
  if(var_c3edbf19a4808cd4) {
    return squared(100);
  }

  return squared(30);
}

function bot_get_heli_slowdown_dist_sq(var_c3edbf19a4808cd4) {
  if(var_c3edbf19a4808cd4) {
    return squared(300);
  }

  return squared(90);
}

function bot_control_heli_main_move_loop(type, var_c3edbf19a4808cd4) {
  foreach(node in level.bot_heli_nodes) {
    node.bot_visited_times[self.entity_number] = 0;
  }

  current_node = find_closest_heli_node_2d(self.vehicle_controlling.origin, type);
  current_target = undefined;
  self.next_goal_time = 0;
  state = "needs_new_goal";
  var_74207efe9ffc3778 = undefined;
  var_cadd32b7c5bf3fa9 = self.vehicle_controlling.origin;
  var_b7c52a7e2454a386 = 3;
  wait_time = 0.05;

  while(self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    if(gettime() > self.next_goal_time && state == "needs_new_goal") {
      prev_node = current_node;
      current_node = [[level.bot_ks_funcs["heli_pick_node"][type]]](current_node);
      current_target = undefined;

      if(isDefined(current_node)) {
        var_fcec43ee4c57ab6e = [[level.bot_ks_funcs["heli_node_get_origin"][type]]](current_node);

        if(var_c3edbf19a4808cd4) {
          tracestart = current_node.origin + gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset;
          traceend = current_node.origin + gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset;
          traceresult = scripts\engine\trace::_bullet_trace(tracestart, traceend, 0, undefined, 0, 0, 1);
          assertex(isDefined(traceresult["entity"]), "Unable to find heli mesh above or below heli_node at " + var_fcec43ee4c57ab6e);
          current_target = traceresult["position"] - gethelipilotmeshoffset() + level.bot_ks_heli_offset[type];
        } else {
          current_target = var_fcec43ee4c57ab6e;
        }
      }

      if(isDefined(current_target)) {
        self botsetflag("disable_movement", 0);
        state = "waiting_till_goal";
        var_b7c52a7e2454a386 = 3;
        var_cadd32b7c5bf3fa9 = self.vehicle_controlling.origin;
      } else {
        current_node = prev_node;
        self.next_goal_time = gettime() + 2000;
      }
    } else if(state == "waiting_till_goal") {
      if(!var_c3edbf19a4808cd4) {
        height_difference = current_target[2] - self.vehicle_controlling.origin[2];

        if(height_difference > 10) {
          self botpressbutton("lethal");
        } else if(height_difference < -10) {
          self botpressbutton("tactical");
        }
      }

      var_4957ac5feb2a6fcf = current_target - self.vehicle_controlling.origin;

      if(var_c3edbf19a4808cd4) {
        var_74207efe9ffc3778 = length2dsquared(var_4957ac5feb2a6fcf);
      } else {
        var_74207efe9ffc3778 = lengthsquared(var_4957ac5feb2a6fcf);
      }

      if(var_74207efe9ffc3778 < bot_get_heli_goal_dist_sq(var_c3edbf19a4808cd4)) {
        self botsetscriptmove(0, 0);
        self botsetflag("disable_movement", 1);

        if(self botgetdifficulty() == "recruit") {
          self.next_goal_time = gettime() + randomintrange(5000, 7000);
        } else {
          self.next_goal_time = gettime() + randomintrange(3000, 5000);
        }

        state = "needs_new_goal";
      } else {
        var_4957ac5feb2a6fcf = current_target - self.vehicle_controlling.origin;
        var_12e3256864ef7f70 = vectortoangles(var_4957ac5feb2a6fcf);
        stick_speed = ter_op(var_74207efe9ffc3778 < bot_get_heli_slowdown_dist_sq(var_c3edbf19a4808cd4), 0.5, 1);
        self botsetscriptmove(var_12e3256864ef7f70[1], wait_time, stick_speed);
        var_b7c52a7e2454a386 -= wait_time;

        if(var_b7c52a7e2454a386 <= 0) {
          if(distancesquared(self.vehicle_controlling.origin, var_cadd32b7c5bf3fa9) < 225) {
            current_node.bot_visited_times[self.entity_number]++;
            state = "needs_new_goal";
          }

          var_cadd32b7c5bf3fa9 = self.vehicle_controlling.origin;
          var_b7c52a7e2454a386 = 3;
        }
      }
    }

    if(getdvarint(@ "ai_showpaths") == 1) {
      if(isDefined(current_target)) {
        line(self.vehicle_controlling.origin, current_target, (0, 0, 1), 1, 0);
      }
    }

    wait wait_time;
  }
}

function get_random_outside_target() {
  possible_zones = [];

  foreach(z in level.outside_zones) {
    enemies_in_zone = botzonegetcount(z, self.team, "enemy_predict");

    if(enemies_in_zone > 0) {
      possible_zones = array_add(possible_zones, z);
    }
  }

  target_loc = undefined;

  if(possible_zones.size > 0) {
    random_zone = random(possible_zones);
    random_node = random(getzonenodes(random_zone));
    target_loc = random_node.origin;
  } else {
    var_91bf9dcd7b76676c = undefined;
    var_89db07cffe8425d6 = undefined;

    if(isDefined(level.teleportgetactivenodesfunc)) {
      var_91bf9dcd7b76676c = [[level.teleportgetactivenodesfunc]]();
    } else {
      var_89db07cffe8425d6 = getnodecount();
    }

    num_picked = 0;

    while(num_picked < 10) {
      num_picked++;
      node_picked = undefined;

      if(isDefined(var_91bf9dcd7b76676c)) {
        node_picked = random(var_91bf9dcd7b76676c);
      } else {
        assert(isDefined(var_89db07cffe8425d6));
        node_picked = getnodebyindex(randomint(var_89db07cffe8425d6));
      }

      if(isDefined(node_picked)) {
        target_loc = node_picked.origin;

        if(nodeexposedtosky(node_picked) && distance2dsquared(node_picked.origin, self.vehicle_controlling.origin) > 62500) {
          break;
        }
      }
    }
  }

  return target_loc;
}