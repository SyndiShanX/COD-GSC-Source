/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_ks_remote_vehicle.gsc
****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_ks;

remote_vehicle_setup() {
  while(!isDefined(level.bot_variables_initialized)) {
    wait(0.05);
  }

  if(isDefined(level.bot_initialized_remote_vehicles)) {
    return;
  }
  level.bot_ks_heli_offset["heli_pilot"] = (0, 0, 350);
  level.bot_ks_heli_offset["heli_sniper"] = (0, 0, 228);

  level.bot_ks_funcs["isUsing"]["odin_assault"] = ::isUsingRemote;
  level.bot_ks_funcs["isUsing"]["odin_support"] = ::isUsingRemote;
  level.bot_ks_funcs["isUsing"]["heli_pilot"] = ::isUsingRemote;
  level.bot_ks_funcs["isUsing"]["heli_sniper"] = maps\mp\killstreaks\_killstreaks::isUsingHeliSniper;
  level.bot_ks_funcs["isUsing"]["switchblade_cluster"] = ::isUsingRemote;
  level.bot_ks_funcs["isUsing"]["vanguard"] = ::isUsingVanguard;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_pilot"] = ::heli_pilot_waittill_initial_goal;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_sniper"] = ::heli_sniper_waittill_initial_goal;
  level.bot_ks_funcs["control_aiming"]["heli_pilot"] = ::heli_pilot_control_heli_aiming;
  level.bot_ks_funcs["control_aiming"]["heli_sniper"] = ::empty_init_func;
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

  all_heli_nodes = GetStructArray("so_chopper_boss_path_struct", "script_noteworthy");
  level.bot_heli_nodes = [];
  foreach(heli_node in all_heli_nodes) {
    if(isDefined(heli_node.script_linkname)) {
      level.bot_heli_nodes = array_add(level.bot_heli_nodes, heli_node);
    }
  }

  level.bot_heli_pilot_traceOffset = getHeliPilotTraceOffset();

  thread bot_validate_heli_nodes(level.bot_heli_nodes);

  foreach(node in level.bot_heli_nodes) {
    node.vanguard_origin = node.origin;

    test_point = node.origin + (0, 0, 50);
    node.valid_for_vanguard = true;
    while(!origin_is_valid_for_vanguard(test_point) && test_point[2] > (node.origin[2] - 1000)) {
      test_point = test_point - (0, 0, 25);
    }

    if(test_point[2] <= (node.origin[2] - 1000)) {
      node.valid_for_vanguard = false;
    }

    test_point = test_point - (0, 0, 50);
    node.vanguard_origin = test_point;
  }

  bot_vehicle_node_highest_height_value = -99999999;
  foreach(node in level.bot_heli_nodes) {
    bot_vehicle_node_highest_height_value = max(bot_vehicle_node_highest_height_value, node.origin[2]);
  }
  level.bot_vanguard_height_trace_size = (bot_vehicle_node_highest_height_value - level.bot_map_min_z) + 100;

  level.odin_large_rod_radius = GetWeaponExplosionRadius("odin_projectile_large_rod_mp");
  level.odin_small_rod_radius = GetWeaponExplosionRadius("odin_projectile_small_rod_mp");
  level.vanguard_missile_radius = GetWeaponExplosionRadius("remote_tank_projectile_mp");
  level.heli_pilot_missile_radius = GetDvarFloat("bg_bulletExplRadius");

  while(!isDefined(level.odin_marking_flash_radius_max) || !isDefined(level.odin_marking_flash_radius_min)) {
    wait(0.05);
  }

  level.odin_flash_radius = (level.odin_marking_flash_radius_max + level.odin_marking_flash_radius_min) / 2;

  level.outside_zones = [];
  if(isDefined(level.teleportGetActivePathnodeZonesFunc)) {
    all_zones = [[level.teleportGetActivePathnodeZonesFunc]]();
  } else {
    all_zones = [];
    for(i = 0; i < level.zoneCount; i++) {
      all_zones[all_zones.size] = i;
    }
  }

  foreach(z in all_zones) {
    if(BotZoneGetIndoorPercent(z) < 0.25) {
      level.outside_zones = array_add(level.outside_zones, z);
    }
  }

  level.bot_odin_time_to_move["recruit"] = 1.0;
  level.bot_odin_time_to_move["regular"] = 0.70;
  level.bot_odin_time_to_move["hardened"] = 0.40;
  level.bot_odin_time_to_move["veteran"] = 0.05;

  level.bot_initialized_remote_vehicles = true;
}

bot_validate_heli_nodes(nodes) {
  wait(5.0);
  bot_waittill_bots_enabled(true);

  AssertEx(nodes.size > 2, "Level needs more than 2 heli nodes");

  heli_pilot_mesh_offset = getHeliPilotMeshOffset();
  bot_heli_pilot_trace_offset = level.bot_heli_pilot_traceOffset;

  foreach(heli_node in nodes) {
    traceStart = (heli_node.origin) + (heli_pilot_mesh_offset + bot_heli_pilot_trace_offset);
    traceEnd = (heli_node.origin) + (heli_pilot_mesh_offset - bot_heli_pilot_trace_offset);
    traceResult = bulletTrace(traceStart, traceEnd, false, undefined, false, false, true);
    AssertEx(isDefined(traceResult["entity"]), "Unable to find heli mesh above or below heli_node at " + heli_node.origin);
    wait(0.05);
  }

  thread bot_draw_debug_heli_nodes(nodes);
}

bot_draw_debug_heli_nodes(nodes) {
  self notify("bot_draw_debug_heli_nodes");
  self endon("bot_draw_debug_heli_nodes");
  level endon("teleport_to_zone");

  while(1) {
    draw_debug_heli_nodes = GetDvar("bot_DrawDebugSpecial") == "heli_nodes";
    draw_debug_heli_nodes_with_vanguard_info = GetDvar("bot_DrawDebugSpecial") == "heli_nodes_vanguard_info";
    if(draw_debug_heli_nodes || draw_debug_heli_nodes_with_vanguard_info) {
      current_nodes = nodes;
      for(i = 0; i < current_nodes.size; i++) {
        node_color = (0, 1, 1);
        if(draw_debug_heli_nodes_with_vanguard_info) {
          if(!current_nodes[i].valid_for_vanguard) {
            node_color = (1, 0, 0);
          } else if(!bot_vectors_are_equal(current_nodes[i].origin, current_nodes[i].vanguard_origin)) {
            node_color = (1, 0, 0);
            line(current_nodes[i].origin, current_nodes[i].vanguard_origin, (1, 0, 0), 1.0, true);
            bot_draw_cylinder(current_nodes[i].vanguard_origin - (0, 0, 5), 10, 12, 0.05, undefined, (0, 1, 1), true, 4);
          }
        }

        bot_draw_cylinder(current_nodes[i].origin - (0, 0, 5), 10, 12, 0.05, undefined, node_color, true, 4);

        foreach(neighbor_node in current_nodes[i].neighbors) {
          if(isDefined(neighbor_node.script_linkname) && array_contains(current_nodes, neighbor_node)) {
            link_color = (0, 1, 1);
            if(draw_debug_heli_nodes_with_vanguard_info) {
              if(current_nodes[i].valid_for_vanguard && neighbor_node.valid_for_vanguard) {
                if(!bot_vectors_are_equal(current_nodes[i].origin, current_nodes[i].vanguard_origin) ||
                  !bot_vectors_are_equal(neighbor_node.origin, neighbor_node.vanguard_origin)) {
                  line(current_nodes[i].vanguard_origin, neighbor_node.vanguard_origin, link_color, 1.0, true);
                  link_color = (1, 0, 0);
                }
              } else {
                link_color = (1, 0, 0);
              }
            }
            line(current_nodes[i].origin, neighbor_node.origin, link_color, 1.0, true);
          }
        }

        current_nodes[i] = current_nodes[current_nodes.size - 1];
        current_nodes[current_nodes.size - 1] = undefined;
        i--;
      }
    }

    wait(0.05);
  }
}

bot_killstreak_remote_control(killstreak_info, killstreaks_array, canUseFunc, controlFunc, prefer_place_outside) {
  if(!isDefined(controlFunc)) {
    return false;
  }

  needs_new_hide_goal = true;
  needs_to_reach_hide_goal = true;
  hideNode = undefined;
  if(isDefined(self.node_ambushing_from)) {
    script_goal_radius = self BotGetScriptGoalRadius();

    dist_sq_to_camp_goal = DistanceSquared(self.origin, self.node_ambushing_from.origin);
    if(dist_sq_to_camp_goal < squared(script_goal_radius)) {
      needs_new_hide_goal = false;
      needs_to_reach_hide_goal = false;
    } else if(dist_sq_to_camp_goal < squared(200)) {
      needs_new_hide_goal = false;
    }
  }

  is_vanguard_in_inside_map = (killstreak_info.streakName == "vanguard" && is_indoor_map());
  if(is_vanguard_in_inside_map || needs_new_hide_goal) {
    nodesAroundMe = GetNodesInRadius(self.origin, 500, 0, 512);
    if(isDefined(nodesAroundMe) && nodesAroundMe.size > 0) {
      if(isDefined(prefer_place_outside) && prefer_place_outside) {
        nodesAroundMeOld = nodesAroundMe;
        nodesAroundMe = [];
        foreach(node in nodesAroundMeOld) {
          if(NodeExposedToSky(node)) {
            linked_nodes = GetLinkedNodes(node);
            num_linked_nodes_exposed = 0;
            foreach(linked_node in linked_nodes) {
              if(NodeExposedToSky(linked_node)) {
                num_linked_nodes_exposed++;
              }
            }

            if(num_linked_nodes_exposed / linked_nodes.size > 0.5) {
              nodesAroundMe = array_add(nodesAroundMe, node);
            }
          }
        }
      }

      if(is_vanguard_in_inside_map) {
        nodes = self BotNodeScoreMultiple(nodesAroundMe, "node_exposed");
        foreach(node in nodes) {
          if(BulletTracePassed(node.origin + (0, 0, 30), node.origin + (0, 0, 400), false, self)) {
            hideNode = node;
            break;
          }

          wait(0.05);
        }
      } else if(nodesAroundMe.size > 0) {
        hideNode = self BotNodePick(nodesAroundMe, min(3, nodesAroundMe.size), "node_hide");
      }

      if(!isDefined(hideNode)) {
        return false;
      }
      self BotSetScriptGoalNode(hideNode, "tactical");
    }
  }

  if(needs_to_reach_hide_goal) {
    result = self bot_waittill_goal_or_fail();
    if(result != "goal") {
      self try_clear_hide_goal(hideNode);
      return true;
    }
  }

  if(isDefined(canUseFunc) && !self[[canUseFunc]]()) {
    self try_clear_hide_goal(hideNode);
    return false;
  }

  if(!self bot_allowed_to_use_killstreaks()) {
    self try_clear_hide_goal(hideNode);
    return true;
  }

  if(!isDefined(hideNode)) {
    if(self GetStance() == "prone") {
      self BotSetStance("prone");
    }
    else if(self GetStance() == "crouch") {
      self BotSetStance("crouch");
    }
  } else if(self BotGetDifficultySetting("strategyLevel") > 0) {
    if(RandomInt(100) > 50) {
      self BotSetStance("prone");
    }
    else {
      self BotSetStance("crouch");
    }
  }

  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);

  self.vehicle_controlling = undefined;
  self thread[[controlFunc]]();
  self thread bot_end_control_on_respawn();
  self thread bot_end_control_watcher(hideNode);
  self waittill("control_func_done");

  return true;
}

bot_end_control_on_respawn() {
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");

  self waittill("spawned_player");
  self notify("control_func_done");
}

bot_end_control_watcher(hideNode) {
  self endon("disconnect");
  self waittill("control_func_done");

  self try_clear_hide_goal(hideNode);
  self BotSetStance("none");
  self BotSetScriptMove(0, 0);
  self BotSetFlag("disable_movement", false);
  self BotSetFlag("disable_rotation", false);
  self.vehicle_controlling = undefined;
}

try_clear_hide_goal(hideNode) {
  if(isDefined(hideNode) && self BotHasScriptGoal() && isDefined(self BotGetScriptGoalNode()) && self BotGetScriptGoalNode() == hideNode) {
    self BotClearScriptGoal();
  }
}

bot_end_control_on_vehicle_death(vehicle) {
  vehicle waittill("death");
  self notify("control_func_done");
}

bot_waittill_using_vehicle(type) {
  time_started = GetTime();
  while(!self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    wait(0.05);
    if(GetTime() - time_started > 5000) {
      return false;
    }
  }

  return true;
}

bot_control_switchblade_cluster() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");

  self childthread handle_disable_rotation();

  result = self bot_waittill_using_vehicle("switchblade_cluster");
  if(!result) {
    self notify("control_func_done");
  }

  self thread switchblade_handle_awareness();

  current_rocket = find_cluster_rocket_for_bot(self);
  wait(0.1);

  self.oldmaxsightdistsqrd = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 16000 * 16000;
  self thread watch_end_switchblade();

  current_random_zone_target = undefined;
  num_mini_missiles_fired = 0;
  next_missile_time = 0;
  mini_missiles = [];
  next_mini_missile_target = undefined;
  has_boosted = false;
  last_predict_enemy_time = 0;
  target_loc = undefined;
  locked_target = undefined;
  lock_movement_permanently = false;
  map_is_mostly_indoor = is_indoor_map();

  while(self[[level.bot_ks_funcs["isUsing"]["switchblade_cluster"]]]() && isDefined(current_rocket)) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket) && rocket.owner == self && rocket.weapon_name == "switch_blade_child_mp") {
        should_add = true;
        foreach(missile_struct in mini_missiles) {
          if(missile_struct.rocket == rocket) {
            should_add = false;
          }
        }

        if(should_add) {
          new_missile_struct = spawnStruct();
          new_missile_struct.rocket = rocket;
          new_missile_struct.target = next_mini_missile_target;
          next_mini_missile_target = undefined;
          mini_missiles = array_add(mini_missiles, new_missile_struct);
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

    if(lock_movement_permanently) {
      wait(0.05);
      continue;
    }

    best_target = undefined;
    if(isDefined(locked_target)) {
      best_target = locked_target;
      if(!IsAlive(locked_target) || !self BotCanSeeEntity(best_target)) {
        if(!IsAlive(locked_target)) {
          lock_movement_permanently = true;
        }
        wait(0.05);
        continue;
      }
    }

    visible_enemies = [];
    if(!isDefined(best_target)) {
      enemies = bot_killstreak_get_all_outside_enemies(false);
      current_missile_targets = [];
      foreach(missile_struct in mini_missiles) {
        if(isDefined(missile_struct.target)) {
          current_missile_targets = array_add(current_missile_targets, missile_struct.target);
        }
      }
      enemies = array_remove_array(enemies, current_missile_targets);
      foreach(enemy in enemies) {
        if(enemy _hasPerk("specialty_noplayertarget")) {
          continue;
        }
        if(self BotCanSeeEntity(enemy) || (map_is_mostly_indoor && within_fov(self getEye(), current_rocket.angles, enemy.origin, self BotGetFovDot()))) {
          if(!self bot_body_is_dead() && DistanceSquared(enemy.origin, self.origin) < 200 * 200) {
            continue;
          }
          visible_enemies = array_add(visible_enemies, enemy);
          if(!isDefined(best_target)) {
            best_target = enemy;
          } else {
            rocket_to_best_target = VectorNormalize(best_target.origin - current_rocket.origin);
            rocket_to_enemy = VectorNormalize(enemy.origin - current_rocket.origin);
            rocket_orientation = anglesToForward(current_rocket.angles);

            dot_to_best_target = VectorDot(rocket_to_best_target, rocket_orientation);
            dot_to_enemy = VectorDot(rocket_to_enemy, rocket_orientation);

            if(dot_to_enemy > dot_to_best_target) {
              best_target = enemy;
            }
          }
        }
      }
    }

    if(isDefined(best_target)) {
      current_random_zone_target = undefined;
      dist_above_target = current_rocket.origin[2] - best_target.origin[2];

      bot_difficulty = self BotGetDifficulty();
      if(bot_difficulty == "recruit") {
        target_loc = best_target.origin;
      } else {
        if(dist_above_target < 5000) {
          target_loc = best_target.origin;
        } else if(Length(best_target GetEntityVelocity()) < 25) {
          target_loc = best_target.origin;
        } else if(GetTime() - last_predict_enemy_time > 500) {
          last_predict_enemy_time = GetTime();
          predict_ahead_time = 3.0;
          if(bot_difficulty == "regular") {
            predict_ahead_time = 1.0;
          }
          target_loc = GetPredictedEntityPosition(best_target, predict_ahead_time);
        }
      }

      desired_angles = missile_get_desired_angles_to_target(current_rocket, target_loc);

      dist_current_to_desired = missile_get_distance_to_target(current_rocket, target_loc);
      if(dist_current_to_desired < 30) {
        speed = 0.00;
      }
      else if(dist_current_to_desired < 100) {
        speed = 0.15;
      }
      else if(dist_current_to_desired < 200) {
        speed = 0.30;
      }
      else if(dist_current_to_desired < 400) {
        speed = 0.60;
      }
      else {
        speed = 1.0;
      }

      if(has_boosted) {
        speed = min(speed * 3, 1.0);
      }

      if(speed > 0) {
        self BotSetScriptMove(desired_angles[1], 0.05, speed, true, true);
      } else if(GetTime() > next_missile_time) {
        if(num_mini_missiles_fired < 2) {
          self BotPressButton("attack");
          num_mini_missiles_fired++;
          next_missile_time = GetTime() + 200;
          if((bot_difficulty == "regular" && num_mini_missiles_fired == 2) || bot_difficulty == "hardened" || bot_difficulty == "veteran") {
            should_stay_on_target = (num_mini_missiles_fired == 1) && (visible_enemies.size == 1);
            if(!should_stay_on_target) {
              next_mini_missile_target = best_target;
              next_missile_time += 800;
            }
          }
        } else if(!has_boosted && (dist_above_target < 5000 || bot_difficulty == "recruit")) {
          has_boosted = true;
          self BotPressButton("attack");
          if(bot_difficulty == "recruit") {
            locked_target = best_target;
          }
        }
      }
    } else {
      if(!isDefined(current_random_zone_target)) {
        current_random_zone_target = Random(level.outside_zones);
      }

      zone_origin = GetZoneNodeForIndex(current_random_zone_target).origin;
      if(missile_get_distance_to_target(current_rocket, zone_origin) < 200) {
        current_random_zone_target = Random(level.outside_zones);
        zone_origin = GetZoneNodeForIndex(current_random_zone_target).origin;
      }

      desired_angles = missile_get_desired_angles_to_target(current_rocket, zone_origin);
      self BotSetScriptMove(desired_angles[1], 0.05, 0.75, true, true);
    }

    wait(0.05);
  }

  self notify("control_func_done");
}

missile_get_desired_angles_to_target(missile, target_origin) {
  current_target = missile_find_ground_target(missile, target_origin[2]);
  missile_target_to_desired_target = VectorNormalize(target_origin - current_target);
  return VectorToAngles(missile_target_to_desired_target);
}

missile_get_distance_to_target(missile, target_origin) {
  current_target = missile_find_ground_target(missile, target_origin[2]);
  return Distance(current_target, target_origin);
}

handle_disable_rotation() {
  self BotSetFlag("disable_rotation", true);
  self BotSetFlag("disable_movement", true);

  find_cluster_rocket_for_bot(self);

  self BotSetFlag("disable_rotation", false);
  self BotSetFlag("disable_movement", false);
}

switchblade_handle_awareness() {
  self endon("disconnect");
  self BotSetAwareness(2.5);

  self waittill("control_func_done");

  self BotSetAwareness(1.0);
}

missile_find_ground_target(missile, desired_target_height) {
  missile_dir = anglesToForward(missile.angles);
  vec_to_ground_size = (desired_target_height - missile.origin[2]) / missile_dir[2];

  pt_on_ground = missile.origin + missile_dir * vec_to_ground_size;

  return pt_on_ground;
}

watch_end_switchblade() {
  self endon("disconnect");
  self waittill("control_func_done");

  self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

find_cluster_rocket_for_bot(bot) {
  while(1) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket) && rocket.owner == bot) {
        return rocket;
      }
    }

    wait(0.05);
  }
}

vanguard_allowed() {
  if(!self aerial_vehicle_allowed()) {
    return false;
  }

  if(maps\mp\killstreaks\_vanguard::exceededMaxVanguards(self.team) || (level.littleBirds.size >= 4)) {
    return false;
  }

  if(isKillstreakBlockedForBots("vanguard")) {
    return false;
  }

  return true;
}

bot_killstreak_vanguard_start(killstreak_info, killstreaks_array, canUseFunc, controlFunc) {
  bot_killstreak_remote_control(killstreak_info, killstreaks_array, canUseFunc, controlFunc, true);
}

isUsingVanguard() {
  return (self isUsingRemote() && self.usingRemote == "vanguard" && isDefined(self.remoteUAV));
}

SCR_CONST_vanguard_desired_path_height = 64;

bot_control_vanguard() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");

  result = self bot_waittill_using_vehicle("vanguard");
  if(!result) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.remoteUAV;
  self childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);

  self childthread vanguard_assert_on_range(self.vehicle_controlling);

  self.vehicle_controlling endon("death");
  wait(0.5);

  /#		
  if(!self.vehicle_controlling maps\mp\killstreaks\_vanguard::vanguard_in_range()) {
    AssertMsg("Vanguard at location " + self.vehicle_controlling.origin + " spawned in an invalid area for the Vanguard.Spawned by bot at location " + self.origin);
    self BotPressButton("use", 4.0);
    wait(4.0);
  }

  total_time_waited = 0;
  try_to_get_outside = !self.vehicle_controlling vanguard_is_outside();
  outside_target = undefined;
  attempts_to_find_outside_target = 0;
  map_is_mostly_indoor = is_indoor_map();
  while(try_to_get_outside && !map_is_mostly_indoor) {
    nodes = GetNodesInRadiusSorted(self.vehicle_controlling.origin, 1024, 64, 512, "path");
    if(isDefined(outside_target)) {
      nodes = array_remove(nodes, outside_target);
    }
    foreach(potential_target in nodes) {
      if(node_is_valid_outside_for_vanguard(potential_target)) {
        outside_target = potential_target;
        break;
      }

      wait(0.05);
      total_time_waited += 0.05;
    }

    if(total_time_waited < 1.0) {
      wait(1.0 - total_time_waited);
    }

    if(!isDefined(outside_target)) {
      AssertMsg("Bot tried to use Vanguard from location " + self.origin + " but couldn't find an outside node within a 1024 unit radius");
      self BotPressButton("use", 4.0);
      wait(4.0);
    }

    path = bot_queued_process("GetNodesOnPathVanguard", ::func_get_nodes_on_path, self.vehicle_controlling.origin, outside_target.origin);

    if(!isDefined(path)) {
      if(attempts_to_find_outside_target == 0) {
        attempts_to_find_outside_target++;
        wait(0.05);
        continue;
      } else {
        self BotPressButton("use", 4.0);
        wait(4.0);
      }
    }

    for(i = 0; i < path.size; i++) {
      next_node = path[i];

      if(i == 0 && DistanceSquared(self.origin, next_node.origin) < 40 * 40) {
        continue;
      }

      dist_wanted = 32;
      if(i == path.size - 1) {
        dist_wanted = 16;
      }

      last_pos = self.vehicle_controlling.origin;
      next_stuck_check_time = GetTime() + 2500;
      while(Distance2DSquared(next_node.origin, self.vehicle_controlling.origin) > dist_wanted * dist_wanted) {
        if(self.vehicle_controlling vanguard_is_outside()) {
          i = path.size;
          break;
        }

        if(GetTime() > next_stuck_check_time) {
          next_stuck_check_time = GetTime() + 2500;

          dist_to_last_pos = DistanceSquared(self.vehicle_controlling.origin, last_pos);
          if(dist_to_last_pos < 1.0) {
            i++;
            break;
          }

          last_pos = self.vehicle_controlling.origin;
        }

        dir_to_next_node = VectorNormalize(next_node.origin - self.vehicle_controlling.origin);
        self BotSetScriptMove(VectorToAngles(dir_to_next_node)[1], 0.20);
        self BotLookAtPoint(next_node.origin, 0.20, "script_forced");

        desired_height = next_node.origin[2] + SCR_CONST_vanguard_desired_path_height;
        height_difference = desired_height - self.vehicle_controlling.origin[2];
        if(height_difference > 10) {
          self BotPressButton("lethal");
        }
        else if(height_difference < -10) {
          self BotPressButton("tactical");
        }
        /#				
        if(GetDvarInt("ai_showpaths") == 1) {
          line(self.vehicle_controlling.origin, path[i].origin + (0, 0, SCR_CONST_vanguard_desired_path_height), (0, 0, 1), 1.0, false, 4);
          for(j = i; j < path.size - 1; j++) {
            line(path[j].origin + (0, 0, SCR_CONST_vanguard_desired_path_height), path[j + 1].origin + (0, 0, SCR_CONST_vanguard_desired_path_height), (0, 0, 1), 1.0, false, 4);
          }
        }

        wait(0.05);
      }
    }

    try_to_get_outside = false;
    if(!self.vehicle_controlling vanguard_is_outside()) {
      try_to_get_outside = true;
    }
  }

  self BotSetScriptMove(0, 0);
  self BotLookAtPoint(undefined);

  self childthread[[level.bot_ks_funcs["control_aiming"]["vanguard"]]]();

  last_height = self.vehicle_controlling.origin[2];
  sideways_dir = undefined;
  next_sideways_check = GetTime() + 2000;
  possible_directions = [];
  possible_directions[0] = (1, 0, 0);
  possible_directions[1] = (-1, 0, 0);
  possible_directions[2] = (0, 1, 0);
  possible_directions[3] = (0, -1, 0);
  possible_directions[4] = (1, 1, 0);
  possible_directions[5] = (1, -1, 0);
  possible_directions[6] = (-1, 1, 0);
  possible_directions[7] = (-1, -1, 0);
  closest_heli_node = find_closest_heli_node_2D(self.vehicle_controlling.origin, "vanguard");
  while((closest_heli_node.vanguard_origin[2] - self.vehicle_controlling.origin[2]) > 20) {
    if(!self.vehicle_controlling maps\mp\killstreaks\_vanguard::vanguard_in_range()) {
      break;
    }

    if(GetTime() > next_sideways_check) {
      next_sideways_check = GetTime() + 2000;
      if(isDefined(sideways_dir)) {
        sideways_dir = undefined;
      } else {
        height_difference = self.vehicle_controlling.origin[2] - last_height;
        if(height_difference < 20 && !map_is_mostly_indoor) {
          directions = array_randomize(possible_directions);
          foreach(direction in directions) {
            if(pos_passes_sky_trace(self.vehicle_controlling.origin + direction * 64)) {
              if(!BulletTracePassed(self.vehicle_controlling.origin, self.vehicle_controlling.origin + direction * 64, false, self.vehicle_controlling)) {
                wait(0.05);
                continue;
              }

              sideways_dir = direction;
              break;
            }
            wait(0.05);
          }
        }
      }

      last_height = self.vehicle_controlling.origin[2];
    }

    if(isDefined(sideways_dir)) {
      if(GetDvarInt("ai_showpaths") == 1) {
        line(self.vehicle_controlling.origin, self.vehicle_controlling.origin + sideways_dir * 64, (0, 1, 0), 1.0, true);
      }

      self BotSetScriptMove(VectorToAngles(sideways_dir)[1], 0.05);
      if(cointoss()) {
        self BotPressButton("tactical");
      }
    } else {
      self BotPressButton("lethal");
    }
    wait(0.05);
  }

  wait(1.0);
  while(!self.vehicle_controlling maps\mp\killstreaks\_vanguard::vanguard_in_range()) {
    self BotPressButton("tactical");
    wait(0.1);
  }
  wait(1.0);

  self BotSetFlag("disable_movement", false);
  self bot_control_heli_main_move_loop("vanguard", false);

  self notify("control_func_done");
}

vanguard_assert_on_range(vehicle) {
  vehicle waittill("death", reason);
  if(isDefined(reason)) {
    AssertEx(reason != "range_death", "Bot drove vanguard out of range in " + getdvar("mapname"));
  }
}

pos_is_valid_outside_for_vanguard(pos) {
  nearest_node = GetClosestNodeInSight(pos);
  if(isDefined(nearest_node)) {
    return node_is_valid_outside_for_vanguard(nearest_node);
  }

  return false;
}

node_is_valid_outside_for_vanguard(node) {
  if(NodeExposedToSky(node)) {
    return pos_passes_sky_trace(node.origin);
  }

  return false;
}

pos_passes_sky_trace(pos) {
  start = pos;
  end = pos + (0, 0, level.bot_vanguard_height_trace_size);

  while(!origin_is_valid_for_vanguard(end) && end[2] > start[2]) {
    end = end - (0, 0, 50);
  }

  if(end[2] <= start[2]) {
    return false;
  }

  result = BulletTracePassed(start, end, false, undefined);

  return result;
}

SCR_CONST_VANGUARD_RADIUS = 18.0;

vanguard_is_outside() {
  nearest_node = GetClosestNodeInSight(self.origin);
  if(isDefined(nearest_node) && !NodeExposedToSky(nearest_node)) {
    return false;
  }

  wait(0.05);
  if(!pos_passes_sky_trace(self.origin + (SCR_CONST_VANGUARD_RADIUS, 0, 25))) {
    return false;
  }

  wait(0.05);
  if(!pos_passes_sky_trace(self.origin + (-1 * SCR_CONST_VANGUARD_RADIUS, 0, 25))) {
    return false;
  }

  wait(0.05);
  if(!pos_passes_sky_trace(self.origin + (0, SCR_CONST_VANGUARD_RADIUS, 25))) {
    return false;
  }

  wait(0.05);
  if(!pos_passes_sky_trace(self.origin + (0, -1 * SCR_CONST_VANGUARD_RADIUS, 25))) {
    return false;
  }

  return true;
}

vanguard_control_aiming() {
  self notify("vanguard_control_aiming");
  self endon("vanguard_control_aiming");

  target_loc = undefined;
  next_random_node_time = 0;
  last_time_fired = GetTime();
  last_predict_enemy_time = 0;
  last_enemy_predicted = undefined;
  time_following_red_boxes = 0;
  while(self[[level.bot_ks_funcs["isUsing"]["vanguard"]]]()) {
    enemy_chosen = undefined;
    eye_pos = self getEye();
    eye_angles = self GetPlayerAngles();
    bot_fov = self BotGetFovDot();

    if(IsAlive(self.enemy) && self BotCanSeeEntity(self.enemy)) {
      should_target_enemy = true;
      enemy_chosen = self.enemy;
      time_following_red_boxes = 0;
    } else if(time_following_red_boxes < 10.0) {
      foreach(character in level.characters) {
        if(character == self || !IsAlive(character)) {
          continue;
        }
        if(character _hasPerk("specialty_noplayertarget")) {
          continue;
        }
        if(!isDefined(character.team)) {
          continue;
        }
        if(!level.teamBased || (self.team != character.team)) {
          if(within_fov(eye_pos, eye_angles, character.origin, bot_fov)) {
            time_following_red_boxes += 0.05;
            if(isDefined(enemy_chosen)) {
              dist_vanguard_to_enemy_chosen_sq = DistanceSquared(self.vehicle_controlling.origin, enemy_chosen.origin);
              dist_vanguard_to_this_character = DistanceSquared(self.vehicle_controlling.origin, character.origin);
              if(dist_vanguard_to_this_character < dist_vanguard_to_enemy_chosen_sq) {
                enemy_chosen = character;
              }
            } else {
              enemy_chosen = character;
            }
          }
        }
      }
    }

    if(isDefined(enemy_chosen)) {
      if((IsAI(enemy_chosen) || IsPlayer(enemy_chosen)) && Length(enemy_chosen GetEntityVelocity()) < 25) {
        target_loc = enemy_chosen.origin;
      } else if(GetTime() - last_predict_enemy_time < 500) {
        if(last_enemy_predicted != enemy_chosen) {
          target_loc = enemy_chosen.origin;
        }
      } else if(GetTime() - last_predict_enemy_time > 500) {
        last_predict_enemy_time = GetTime();
        target_loc = GetPredictedEntityPosition(enemy_chosen, 3.0);
        last_enemy_predicted = enemy_chosen;
      }

      allowable_dist = 165;
      if(GetTime() - last_time_fired > 10000) {
        allowable_dist = 200;
      }

      if(DistanceSquared(self.vehicle_controlling.attackArrow.origin, target_loc) < level.vanguard_missile_radius * level.vanguard_missile_radius) {
        if(self bot_body_is_dead() || DistanceSquared(self.vehicle_controlling.attackArrow.origin, self.origin) > level.vanguard_missile_radius * level.vanguard_missile_radius) {
          last_time_fired = GetTime();
          self BotPressButton("attack");
        }
      }

    } else if(GetTime() > next_random_node_time) {
      next_random_node_time = GetTime() + RandomIntRange(1000, 2000);
      target_loc = get_random_outside_target();
      self.next_goal_time = GetTime();
    }

    if(Length(target_loc) == 0) {
      target_loc = (0, 0, 10);
    }
    self BotLookAtPoint(target_loc, 0.2, "script_forced");
    wait(0.05);
  }
}

vanguard_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;
  current_node_origin = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](current_node);

  best_nodes = bot_vanguard_find_unvisited_nodes(current_node);

  best_nodes_old = best_nodes;
  best_nodes = [];
  foreach(node in best_nodes_old) {
    if(node.valid_for_vanguard) {
      if(current_node.origin[2] != current_node.vanguard_origin[2] || node.origin[2] != node.vanguard_origin[2]) {
        node_origin = [
          [level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]
        ](node);

        hitPos = PlayerPhysicsTrace(current_node_origin, node_origin);
        if(DistanceSquared(hitPos, node_origin) < 1) {
          best_nodes = array_add(best_nodes, node);
        }

        wait(0.05);
      } else {
        best_nodes = array_add(best_nodes, node);
      }
    }
  }

  if(best_nodes.size == 0 && best_nodes_old.size > 0) {
    foreach(node in best_nodes_old) {
    node.bot_visited_times[self.entity_number]++;
    }
  }

  return heli_pick_node_furthest_from_center(best_nodes, "vanguard");
}

bot_vanguard_find_unvisited_nodes(current_node) {
  lowest_visted_num = 99;
  best_nodes = [];
  foreach(node in current_node.neighbors) {
    if(isDefined(node.script_linkname) && node.valid_for_vanguard) {
      times_visited_this_node = node.bot_visited_times[self.entity_number];
      if(times_visited_this_node < lowest_visted_num) {
        best_nodes = [];
        best_nodes[0] = node;
        lowest_visted_num = times_visited_this_node;
      } else if(times_visited_this_node == lowest_visted_num) {
        best_nodes[best_nodes.size] = node;
      }
    }
  }

  return best_nodes;
}

vanguard_get_node_origin(node) {
  return node.vanguard_origin;
}

origin_is_valid_for_vanguard(origin) {
  test_script_origin = spawn_tag_origin();
  test_script_origin.origin = origin;
  result = test_script_origin maps\mp\killstreaks\_vanguard::vanguard_in_range();
  test_script_origin delete();
  return result;
}

heli_sniper_allowed() {
  if(!self aerial_vehicle_allowed()) {
    return false;
  }

  if(maps\mp\killstreaks\_heliSniper::exceededMaxHeliSnipers()) {
    return false;
  }

  return true;
}

heli_sniper_waittill_initial_goal() {
  self.vehicle_controlling waittill("near_goal");
}

bot_control_heli_sniper() {
  self thread heli_sniper_clear_script_goal_on_ride();

  bot_control_heli("heli_sniper");
}

heli_sniper_clear_script_goal_on_ride() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");

  while(!(self maps\mp\killstreaks\_killstreaks::isUsingHeliSniper() && self IsLinked())) {
    wait(0.05);
  }

  self BotClearScriptGoal();
}

heli_sniper_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;

  best_nodes = bot_heli_find_unvisited_nodes(current_node);

  return heli_pick_node_furthest_from_center(best_nodes, "heli_sniper");
}

heli_pilot_allowed() {
  if(!self aerial_vehicle_allowed()) {
    return false;
  }

  if(maps\mp\killstreaks\_helicopter_pilot::exceededMaxHeliPilots(self.team)) {
    return false;
  }

  return true;
}

heli_pilot_waittill_initial_goal() {
  self.vehicle_controlling waittill("goal_reached");
}

bot_control_heli_pilot() {
  bot_control_heli("heli_pilot");
}

heli_pilot_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;

  best_nodes = bot_heli_find_unvisited_nodes(current_node);

  node_picked = Random(best_nodes);
  return node_picked;
}

heli_pilot_monitor_flares() {
  self notify("heli_pilot_monitor_flares");
  self endon("heli_pilot_monitor_flares");

  missiles_checked = [];
  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    self.vehicle_controlling waittill("targeted_by_incoming_missile", missiles);

    if(!maps\mp\killstreaks\_flares::flares_areAvailable(self.vehicle_controlling)) {
      break;
    }

    all_missiles_have_been_checked = true;
    foreach(missile in missiles) {
      if(isDefined(missile) && !array_contains(missiles_checked, missile)) {
        all_missiles_have_been_checked = false;
      }
    }

    if(!all_missiles_have_been_checked) {
      chance_to_use_flare = Clamp(0.34 * self BotGetDifficultySetting("strategyLevel"), 0.0, 1.0);
      if(RandomFloat(1.0) < chance_to_use_flare) {
        self notify("manual_flare_popped");
      }

      missiles_checked = array_combine(missiles_checked, missiles);
      missiles_checked = array_removeUndefined(missiles_checked);

      wait(3.0);
    }
  }
}

heli_pilot_control_heli_aiming() {
  self notify("heli_pilot_control_heli_aiming");
  self endon("heli_pilot_control_heli_aiming");

  last_enemy_loc = undefined;
  last_enemy_seen = undefined;
  target_loc = undefined;
  next_random_node_time = 0;
  last_inaccuracy_check = 0;
  inaccuracy_vector = undefined;
  bot_inaccuracy = (self BotGetDifficultySetting("minInaccuracy") + self BotGetDifficultySetting("maxInaccuracy")) / 2;
  time_following_outlines = 0;
  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    should_aim_at_enemy = false;
    should_fire_at_enemy = false;

    if(isDefined(last_enemy_seen) && last_enemy_seen.health <= 0 && GetTime() - last_enemy_seen.deathtime < 2000) {
      should_aim_at_enemy = true;
      should_fire_at_enemy = true;
    } else if(IsAlive(self.enemy) && (self BotCanSeeEntity(self.enemy) || (GetTime() - self LastKnownTime(self.enemy)) <= 300)) {
      should_aim_at_enemy = true;
      last_enemy_seen = self.enemy;
      last_enemy_loc = self.enemy.origin;

      if(self BotCanSeeEntity(self.enemy)) {
        time_following_outlines = 0;
        should_fire_at_enemy = true;
        last_time_actually_saw_enemy = GetTime();
      } else {
        time_following_outlines += 0.05;

        if(time_following_outlines > 5.0) {
          should_aim_at_enemy = false;
        }
      }
    }

    if(should_aim_at_enemy) {
      target_loc = last_enemy_loc - (0, 0, 50);

      if(should_fire_at_enemy && (self bot_body_is_dead() || DistanceSquared(target_loc, self.origin) > level.heli_pilot_missile_radius * level.heli_pilot_missile_radius)) {
        self BotPressButton("attack");
      }

      if(GetTime() > last_inaccuracy_check + 500) {
        random_x = RandomFloatRange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        random_y = RandomFloatRange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        random_z = RandomFloatRange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        inaccuracy_vector = (150 * random_x, 150 * random_y, 150 * random_z);
        last_inaccuracy_check = GetTime();
      }
      target_loc = target_loc + inaccuracy_vector;

      heli_eye_pos = self.vehicle_controlling GetTagOrigin("tag_player");
      heli_eye_to_enemy_norm = VectorNormalize(target_loc - heli_eye_pos);
      player_angles = anglesToForward(self GetPlayerAngles());
      dot = VectorDot(heli_eye_to_enemy_norm, player_angles);
      if(dot > 0.5) {
        self BotPressButton("ads", 0.1);
      }
    } else if(GetTime() > next_random_node_time) {
      next_random_node_time = GetTime() + RandomIntRange(1000, 2000);
      target_loc = get_random_outside_target();
      self.next_goal_time = GetTime();
    }

    heli_to_lookat = target_loc - self.vehicle_controlling.origin;
    dist_heli_to_lookat = Length(heli_to_lookat);
    heli_to_lookat_angles = VectorToAngles(heli_to_lookat);

    vehicle_pitch = AngleClamp(self.vehicle_controlling.angles[0]);
    heli_lookat_pitch = AngleClamp(heli_to_lookat_angles[0]);

    dist = int(vehicle_pitch - heli_lookat_pitch) % 360;
    if(dist > 180) {
      dist = 360 - dist;
    }
    else if(dist < -180) {
      dist = -360 + dist;
    }

    if(dist > 15) {
      heli_lookat_pitch = vehicle_pitch - 15;
    }
    else if(dist < -15) {
      heli_lookat_pitch = vehicle_pitch + 15;
    }

    heli_to_lookat_angles = (heli_lookat_pitch, heli_to_lookat_angles[1], heli_to_lookat_angles[2]);
    heli_to_lookat = anglesToForward(heli_to_lookat_angles);
    target_loc = self.vehicle_controlling.origin + heli_to_lookat * dist_heli_to_lookat;

    if(Length(target_loc) == 0) {
      target_loc = (0, 0, 10);
    }
    self BotLookAtPoint(target_loc, 0.2, "script_forced");
    wait(0.05);
  }
}

bot_control_odin_assault() {
  bot_control_odin("odin_assault");
}

odin_assault_perform_action() {
  if(self bot_odin_try_spawn_juggernaut()) {
    return true;
  }

  if(self bot_odin_try_rods()) {
    return true;
  }

  if(self bot_odin_try_airdrop()) {
    return true;
  }

  return false;
}

odin_assault_get_target() {
  return self bot_odin_find_target_for_rods();
}

bot_odin_find_target_for_rods() {
  player_to_ignore = undefined;
  if(isDefined(self.last_large_rod_target) && GetTime() - self.last_large_rod_time < 5000) {
    player_to_ignore = self.last_large_rod_target;
  }

  return bot_odin_get_closest_visible_outside_player("enemy", true, player_to_ignore);
}

bot_odin_try_rods() {
  rod_to_fire = bot_odin_should_fire_rod_at_marker();
  if(rod_to_fire == "large") {
    self notify("large_rod_action");
    return true;
  }

  if(rod_to_fire == "small") {
    self notify("small_rod_action");
    return true;
  }

  return false;
}

bot_odin_should_fire_rod_at_marker() {
  large_rod_available = GetTime() >= self.odin.odin_LargeRodUseTime;
  small_rod_available = GetTime() >= self.odin.odin_SmallRodUseTime;

  if(large_rod_available || small_rod_available) {
    outside_enemies = bot_odin_get_visible_outside_players("enemy", false);
    dist_enemy_to_marker_sq = [];
    dist_body_to_marker_sq = DistanceSquared(self.origin, self.odin.targeting_marker.origin);

    for(i = 0; i < outside_enemies.size; i++) {
      enemy_target_point = self bot_odin_get_player_target_point(outside_enemies[i]);
      dist_enemy_to_marker_sq[i] = DistanceSquared(self.odin.targeting_marker.origin, enemy_target_point);
    }

    if(large_rod_available) {
      if(!self bot_body_is_dead() && dist_body_to_marker_sq < level.odin_large_rod_radius * level.odin_large_rod_radius) {
        return "none";
      }

      for(i = 0; i < outside_enemies.size; i++) {
        if(dist_enemy_to_marker_sq[i] < squared(level.odin_large_rod_radius)) {
          self.last_large_rod_target = outside_enemies[i];
          self.last_large_rod_time = GetTime();
          return "large";
        }
      }
    }

    if(small_rod_available) {
      if(!self bot_body_is_dead() && dist_body_to_marker_sq < level.odin_small_rod_radius * level.odin_small_rod_radius) {
        return "none";
      }

      for(i = 0; i < outside_enemies.size; i++) {
        if(dist_enemy_to_marker_sq[i] < squared(level.odin_small_rod_radius)) {
          if(isDefined(self.last_large_rod_target) && self.last_large_rod_target == outside_enemies[i] && GetTime() - self.last_large_rod_time < 5000) {
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
  if(self bot_odin_try_spawn_juggernaut()) {
    return true;
  }

  if(self bot_odin_try_airdrop()) {
    return true;
  }

  if(self bot_odin_try_smoke()) {
    return true;
  }

  if(self bot_odin_try_flash()) {
    return true;
  }

  return false;
}

bot_odin_try_flash() {
  if(self bot_odin_should_fire_flash_at_marker()) {
    self notify("marking_action");
    return true;
  }

  return false;
}

bot_odin_should_fire_flash_at_marker() {
  if(GetTime() < self.odin.odin_markingUseTime) {
    return false;
  }

  outside_enemies = bot_odin_get_visible_outside_players("enemy", false);
  dist_enemy_to_marker_sq = [];

  for(i = 0; i < outside_enemies.size; i++) {
    enemy_target_point = self bot_odin_get_player_target_point(outside_enemies[i]);
    dist_enemy_to_marker_sq[i] = DistanceSquared(self.odin.targeting_marker.origin, enemy_target_point);

    if(dist_enemy_to_marker_sq[i] < squared(level.odin_flash_radius / 2)) {
      return true;
    }
  }

  return false;
}

bot_odin_try_smoke() {
  if(self bot_odin_should_drop_smoke_at_marker()) {
    self notify("smoke_action");
    return true;
  }

  return false;
}

bot_odin_should_drop_smoke_at_marker() {
  if(GetTime() < self.odin.odin_smokeUseTime) {
    return false;
  }

  high_priority_locations = self bot_odin_get_high_priority_smoke_locations();
  foreach(location in high_priority_locations) {
    if(DistanceSquared(location, self.odin.targeting_marker.origin) < 50 * 50) {
      return true;
    }
  }

  marker_zone = undefined;
  if(isDefined(self.odin.targeting_marker.nearest_node)) {
    marker_zone = GetNodeZone(self.odin.targeting_marker.nearest_node);
  }

  if(!isDefined(marker_zone)) {
    return false;
  }

  zone_enemies = self bot_killstreak_get_zone_enemies_outside(true);
  num_enemies_in_zone = zone_enemies[marker_zone].size;
  if(num_enemies_in_zone >= 2) {
    return true;
  }

  return false;
}

bot_odin_get_high_priority_smoke_locations() {
  desired_locations = [];
  if(GetTime() < self.odin.odin_smokeUseTime) {
    return desired_locations;
  }

  foreach(package in level.carePackages) {
    if(crate_landed_and_on_path_grid(package)) {
      excluders[0] = self;
      players_sorted = get_array_of_closest(package.origin, level.players, excluders);
      if(players_sorted.size > 0 && players_sorted[0].team == self.team) {
        desired_locations = array_add(desired_locations, package.origin);
      }
    }
  }

  outside_allies = bot_odin_get_visible_outside_players("ally", false);
  foreach(ally in outside_allies) {
    if(IsAI(ally) && ally bot_is_capturing()) {
      desired_locations = array_add(desired_locations, ally.origin);
    }
  }

  return desired_locations;
}

odin_support_get_target() {
  high_priority_smoke_locs = self bot_odin_get_high_priority_smoke_locations();
  if(high_priority_smoke_locs.size > 0) {
    return high_priority_smoke_locs[0];
  }

  return bot_odin_get_closest_visible_outside_player("enemy", true);
}

monitor_odin_marker() {
  while(1) {
    self.odin.targeting_marker.nearest_node = GetClosestNodeInSight(self.odin.targeting_marker.origin);

    if(bot_point_is_on_pathgrid(self.odin.targeting_marker.origin, 200)) {
      self.odin.targeting_marker.nearest_point_on_pathgrid = self.odin.targeting_marker.origin;
    }
    else {
      self.odin.targeting_marker.nearest_point_on_pathgrid = undefined;
    }

    wait(0.25);
  }
}

bot_control_odin(type) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");

  result = self bot_waittill_using_vehicle(type);
  if(!result) {
    self notify("control_func_done");
  }

  self.vehicle_controlling = self.odin;
  self childthread bot_end_control_on_vehicle_death(self.odin);
  self.odin endon("death");

  wait(1.4);

  self BotSetAwareness(0.7);
  self thread bot_end_odin_watcher();
  self.odin_predicted_loc_for_player = [];
  self.odin_predicted_loc_time_for_player = [];
  self.odin_last_predict_position_time = 0;
  current_random_zone_target = undefined;
  next_move_time = 0;
  move_loc = undefined;
  self childthread monitor_odin_marker();
  last_marker_loc = self.odin.targeting_marker.origin;
  last_marker_check = GetTime();
  while(self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    performed_action = self[[level.bot_ks_funcs["odin_perform_action"][type]]]();

    if(GetTime() > last_marker_check + 2000) {
      last_marker_check = GetTime();
      marker_moved = Distance(last_marker_loc, self.odin.targeting_marker.origin);
      last_marker_loc = self.odin.targeting_marker.origin;

      if(marker_moved < 100) {
        move_loc = undefined;
        current_random_zone_target = undefined;
      }
    }

    if(GetTime() > next_move_time || !isDefined(move_loc)) {
      time_to_move = level.bot_odin_time_to_move[self BotGetDifficulty()];
      next_move_time = GetTime() + time_to_move * 1000;

      desired_target = self[[level.bot_ks_funcs["odin_get_target"][type]]]();
      if(isDefined(desired_target)) {
        current_random_zone_target = undefined;
        if(IsPlayer(desired_target)) {
          move_loc = self bot_odin_get_player_target_point(desired_target);
        }
        else {
          move_loc = desired_target;
        }
      } else {
        if(!isDefined(current_random_zone_target)) {
          current_random_zone_target = Random(level.outside_zones);
        }

        zone_origin = GetZoneNodeForIndex(current_random_zone_target).origin;
        if(Distance2DSquared(self.odin.targeting_marker.origin, zone_origin) < 100 * 100) {
          current_random_zone_target = Random(level.outside_zones);
          zone_origin = GetZoneNodeForIndex(current_random_zone_target).origin;
          last_marker_check = GetTime();
        }

        move_loc = zone_origin;
      }

    }

    marker_to_move_loc = move_loc - self.odin.targeting_marker.origin;
    if(LengthSquared(marker_to_move_loc) > 100) {
      marker_to_move_loc_angles = VectorToAngles(marker_to_move_loc);
      self BotSetScriptMove(marker_to_move_loc_angles[1], 0.05);
      self BotLookAtPoint(move_loc, 0.1, "script_forced");
    } else {
      last_marker_check = GetTime();
    }

    wait(0.05);
  }

  self notify("control_func_done");
}

bot_end_odin_watcher(hideNode) {
  self endon("disconnect");
  self waittill("control_func_done");

  self.odin_predicted_loc_for_player = undefined;
  self.odin_predicted_loc_time_for_player = undefined;
  self.odin_last_predict_position_time = undefined;
  self BotSetAwareness(1.0);
}

SCR_CONST_PLAYER_PREDICT_UPDATE_TIME = 400;

bot_odin_get_player_target_point(player) {
  if(level.teamBased && self.team == player.team) {
    return player.origin;
  } else {
    if(Length(player GetEntityVelocity()) < 25) {
      return player.origin;
    }

    player_ent_num = player GetEntityNumber();
    if(!isDefined(self.odin_predicted_loc_time_for_player[player_ent_num])) {
      self.odin_predicted_loc_time_for_player[player_ent_num] = 0;
    }

    cur_time = GetTime();
    time_since_predicted = cur_time - self.odin_predicted_loc_time_for_player[player_ent_num];

    if(time_since_predicted <= SCR_CONST_PLAYER_PREDICT_UPDATE_TIME) {
      player_velocity = VectorNormalize(player GetEntityVelocity());
      player_to_predicted_loc = VectorNormalize(self.odin_predicted_loc_for_player[player_ent_num] - player.origin);
      if(VectorDot(player_velocity, player_to_predicted_loc) < -0.5) {
        return player.origin;
      }
    }

    if(time_since_predicted > SCR_CONST_PLAYER_PREDICT_UPDATE_TIME) {
      if(cur_time == self.odin_last_predict_position_time) {
        if(time_since_predicted > 1000) {
          return player.origin;
        }
      } else {
        self.odin_predicted_loc_for_player[player_ent_num] = GetPredictedEntityPosition(player, 1.5);
        self.odin_predicted_loc_time_for_player[player_ent_num] = cur_time;
        self.odin_last_predict_position_time = cur_time;
      }
    }

    return self.odin_predicted_loc_for_player[player_ent_num];
  }
}

bot_odin_get_closest_visible_outside_player(type, only_players, player_to_ignore) {
  visible_players = self bot_odin_get_visible_outside_players(type, only_players);

  if(isDefined(player_to_ignore)) {
    visible_players = array_remove(visible_players, player_to_ignore);
  }

  if(visible_players.size > 0) {
    visible_players_sorted = get_array_of_closest(self.odin.targeting_marker.origin, visible_players);
    return visible_players_sorted[0];
  }

  return undefined;
}

bot_odin_try_spawn_juggernaut() {
  if(GetTime() >= self.odin.odin_juggernautUseTime) {
    if(!isDefined(self.odin.targeting_marker.nearest_node)) {
      return false;
    }

    node_for_juggernaut = maps\mp\killstreaks\_odin::getJuggStartingPathNode(self.odin.targeting_marker.origin);
    if(isDefined(node_for_juggernaut)) {
      self notify("juggernaut_action");
      return true;
    }
  }

  return false;
}

bot_odin_find_target_for_airdrop() {
  return bot_odin_get_closest_visible_outside_player("ally", false);
}

bot_odin_try_airdrop() {
  if(self bot_odin_should_airdrop_at_marker()) {
    self notify("airdrop_action");
    self notify("juggernaut_action");
    return true;
  }

  return false;
}

bot_odin_should_airdrop_at_marker() {
  if(GetTime() < self.odin.odin_airdropUseTime) {
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

  marker_zone = GetNodeZone(self.odin.targeting_marker.nearest_node);
  if(!isDefined(marker_zone)) {
    return false;
  }

  zone_allies = self bot_killstreak_get_zone_allies_outside(true);
  num_allies_in_zone = zone_allies[marker_zone].size;

  zone_enemies = self bot_killstreak_get_zone_enemies_outside(true);
  num_enemies_in_zone = zone_enemies[marker_zone].size;

  if(num_allies_in_zone == 0) {
    return false;
  }

  if(num_enemies_in_zone == 0) {
    enemy_nearby_marker = false;
    visible_enemies = self bot_odin_get_visible_outside_players("enemy", true);
    foreach(enemy in visible_enemies) {
      if(DistanceSquared(enemy.origin, self.odin.targeting_marker.origin) < 120 * 120) {
        enemy_nearby_marker = true;
      }
    }

    if(!enemy_nearby_marker) {
      return true;
    }
  }

  if(num_allies_in_zone - num_enemies_in_zone >= 2) {
    allies_sorted = get_array_of_closest(self.odin.targeting_marker.origin, zone_allies[marker_zone]);
    enemies_sorted = get_array_of_closest(self.odin.targeting_marker.origin, zone_enemies[marker_zone]);

    closest_ally_dist = Distance(self.odin.targeting_marker.origin, allies_sorted[0].origin);
    closest_enemy_dist = Distance(self.odin.targeting_marker.origin, enemies_sorted[0].origin);

    if(closest_ally_dist + 120 < closest_enemy_dist) {
      return true;
    }
  }

  return false;
}

bot_odin_get_num_valid_care_packages() {
  count = 0;
  foreach(package in level.carePackages) {
    if(isDefined(package) && crate_landed_and_on_path_grid(package)) {
      count++;
    }
  }

  return count;
}

bot_odin_get_visible_outside_players(type, only_players, only_check_fov) {
  outside_players = self bot_killstreak_get_outside_players(self.team, type, only_players);

  fov_dot_base = self BotGetFovDot();
  visible_outside_players = [];
  foreach(player in outside_players) {
    check_sight = false;
    fov_dot = fov_dot_base;
    if(type == "enemy") {
      if(maps\mp\killstreaks\_odin::enemyNotAffectedByOdinOutline(player)) {
        check_sight = true;
      }
      else {
        fov_dot *= 0.9;
      }
    }

    if(within_fov(self.vehicle_controlling.origin, self GetPlayerAngles(), player.origin, fov_dot)) {
      if(!check_sight || self BotCanSeeEntity(player)) {
        visible_outside_players = array_add(visible_outside_players, player);
      }
    }
  }

  return visible_outside_players;
}

is_indoor_map() {
  return (level.script == "mp_sovereign");
}

bot_body_is_dead() {
  return (isDefined(self.fauxDead) && self.fauxDead);
}

heli_pick_node_furthest_from_center(nodes, type) {
  farthest_node = undefined;
  farthest_node_dist_sq = 0;
  foreach(node in nodes) {
    dist_to_center_sq = DistanceSquared(level.bot_map_center, [[level.bot_ks_funcs["heli_node_get_origin"][type]]](node));
    if(dist_to_center_sq > farthest_node_dist_sq) {
      farthest_node_dist_sq = dist_to_center_sq;
      farthest_node = node;
    }
  }

  if(isDefined(farthest_node)) {
    return farthest_node;
  }
  else {
    return Random(nodes);
  }
}

heli_get_node_origin(node) {
  return node.origin;
}

find_closest_heli_node_2D(origin, type) {
  closest_node_2D = undefined;
  closest_node_2D_dist = 99999999;
  foreach(node in level.bot_heli_nodes) {
    dist_2D_sq = Distance2DSquared(origin, [[level.bot_ks_funcs["heli_node_get_origin"][type]]](node));
    if(dist_2D_sq < closest_node_2D_dist) {
      closest_node_2D = node;
      closest_node_2D_dist = dist_2D_sq;
    }
  }

  return closest_node_2D;
}

bot_killstreak_get_zone_allies_outside(only_players) {
  outside_allies = self bot_killstreak_get_all_outside_allies(only_players);
  zone_allies = [];

  for(i = 0; i < level.zoneCount; i++) {
    zone_allies[i] = [];
  }

  foreach(ally in outside_allies) {
    nearest_node = ally GetNearestNode();
    zone = GetNodeZone(nearest_node);
    if(isDefined(zone)) {
      zone_allies[zone] = array_add(zone_allies[zone], ally);
    }
  }

  return zone_allies;
}

bot_killstreak_get_zone_enemies_outside(only_players) {
  outside_enemies = self bot_killstreak_get_all_outside_enemies(only_players);
  zone_enemies = [];

  for(i = 0; i < level.zoneCount; i++) {
    zone_enemies[i] = [];
  }

  foreach(enemy in outside_enemies) {
    nearest_node = enemy GetNearestNode();
    zone = GetNodeZone(nearest_node);
    zone_enemies[zone] = array_add(zone_enemies[zone], enemy);
  }

  return zone_enemies;
}

bot_killstreak_get_all_outside_enemies(only_players) {
  return self bot_killstreak_get_outside_players(self.team, "enemy", only_players);
}

bot_killstreak_get_all_outside_allies(only_players) {
  return self bot_killstreak_get_outside_players(self.team, "ally", only_players);
}

bot_killstreak_get_outside_players(team, type, only_players) {
  outside_players = [];
  all_players = level.participants;
  if(isDefined(only_players) && only_players) {
    all_players = level.players;
  }

  foreach(player in all_players) {
    if(player == self || !IsAlive(player)) {
      continue;
    }
    is_valid_player = false;
    if(type == "ally") {
      is_valid_player = level.teamBased && (team == player.team);
    }
    else if(type == "enemy") {
      is_valid_player = !level.teamBased || (team != player.team);
    }

    if(is_valid_player) {
      nearest_node_player = player GetNearestNode();
      if(isDefined(nearest_node_player) && NodeExposedToSky(nearest_node_player)) {
        outside_players = array_add(outside_players, player);
      }
    }
  }

  outside_players = array_remove(outside_players, self);
  return outside_players;
}

bot_heli_find_unvisited_nodes(current_node) {
  lowest_visted_num = 99;
  best_nodes = [];
  foreach(node in current_node.neighbors) {
    if(isDefined(node.script_linkname)) {
      times_visited_this_node = node.bot_visited_times[self.entity_number];
      if(times_visited_this_node < lowest_visted_num) {
        best_nodes = [];
        best_nodes[0] = node;
        lowest_visted_num = times_visited_this_node;
      } else if(times_visited_this_node == lowest_visted_num) {
        best_nodes[best_nodes.size] = node;
      }
    }
  }

  return best_nodes;
}

bot_control_heli(type) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");

  result = self bot_waittill_using_vehicle(type);
  if(!result) {
    self notify("control_func_done");
  }

  foreach(bird in level.littleBirds) {
    if(bird.owner == self) {
      self.vehicle_controlling = bird;
    }
  }
  Assert(isDefined(self.vehicle_controlling));

  self childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("death");

  if(isDefined(level.bot_ks_funcs["control_other"][type])) {
    self childthread[[level.bot_ks_funcs["control_other"][type]]]();
  }

  self[[level.bot_ks_funcs["waittill_initial_goal"][type]]]();

  self childthread[[level.bot_ks_funcs["control_aiming"][type]]]();

  self bot_control_heli_main_move_loop(type, true);

  self notify("control_func_done");
}

SCR_CONST_BOT_HELI_ON_MESH_GOAL_DIST = 100;
SCR_CONST_BOT_HELI_OFF_MESH_GOAL_DIST = 30;
SCR_CONST_BOT_HELI_SLOWDOWN_RANGE = 3;

bot_get_heli_goal_dist_sq(rides_on_mesh) {
  if(rides_on_mesh) {
    return squared(SCR_CONST_BOT_HELI_ON_MESH_GOAL_DIST);
  }
  else {
    return squared(SCR_CONST_BOT_HELI_OFF_MESH_GOAL_DIST);
  }
}

bot_get_heli_slowdown_dist_sq(rides_on_mesh) {
  if(rides_on_mesh) {
    return squared(SCR_CONST_BOT_HELI_ON_MESH_GOAL_DIST * SCR_CONST_BOT_HELI_SLOWDOWN_RANGE);
  }
  else {
    return squared(SCR_CONST_BOT_HELI_OFF_MESH_GOAL_DIST * SCR_CONST_BOT_HELI_SLOWDOWN_RANGE);
  }
}

SCR_CONST_BOT_VANGUARD_STUCK_TIME = 3.0;

bot_control_heli_main_move_loop(type, rides_on_mesh) {
  foreach(node in level.bot_heli_nodes) {
  node.bot_visited_times[self.entity_number] = 0;
  }
  current_node = find_closest_heli_node_2D(self.vehicle_controlling.origin, type);

  current_target = undefined;
  self.next_goal_time = 0;
  state = "needs_new_goal";
  dist_to_goal_sq = undefined;
  last_vehicle_origin = self.vehicle_controlling.origin;
  time_till_next_stuck_check = SCR_CONST_BOT_VANGUARD_STUCK_TIME;
  wait_time = 0.05;
  while(self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    if(GetTime() > self.next_goal_time && state == "needs_new_goal") {
      prev_node = current_node;
      current_node = [
        [level.bot_ks_funcs["heli_pick_node"][type]]
      ](current_node);
      current_target = undefined;
      if(isDefined(current_node)) {
        current_node_origin = [
          [level.bot_ks_funcs["heli_node_get_origin"][type]]
        ](current_node);

        if(rides_on_mesh) {
          traceStart = (current_node.origin) + (getHeliPilotMeshOffset() + level.bot_heli_pilot_traceOffset);
          traceEnd = (current_node.origin) + (getHeliPilotMeshOffset() - level.bot_heli_pilot_traceOffset);
          traceResult = bulletTrace(traceStart, traceEnd, false, undefined, false, false, true);
          AssertEx(isDefined(traceResult["entity"]), "Unable to find heli mesh above or below heli_node at " + current_node_origin);
          current_target = (traceResult["position"] - getHeliPilotMeshOffset()) + level.bot_ks_heli_offset[type];
        } else {
          current_target = current_node_origin;
        }
      }

      if(isDefined(current_target)) {
        self BotSetFlag("disable_movement", false);
        state = "waiting_till_goal";
        time_till_next_stuck_check = SCR_CONST_BOT_VANGUARD_STUCK_TIME;
        last_vehicle_origin = self.vehicle_controlling.origin;
      } else {
        current_node = prev_node;
        self.next_goal_time = GetTime() + 2000;
      }
    } else if(state == "waiting_till_goal") {
      if(!rides_on_mesh) {
        height_difference = current_target[2] - self.vehicle_controlling.origin[2];
        if(height_difference > 10) {
          self BotPressButton("lethal");
        }
        else if(height_difference < -10) {
          self BotPressButton("tactical");
        }
      }

      heli_to_current_target = (current_target - self.vehicle_controlling.origin);
      if(rides_on_mesh) {
        dist_to_goal_sq = Length2DSquared(heli_to_current_target);
      }
      else {
        dist_to_goal_sq = LengthSquared(heli_to_current_target);
      }

      if(dist_to_goal_sq < bot_get_heli_goal_dist_sq(rides_on_mesh)) {
        self BotSetScriptMove(0, 0);
        self BotSetFlag("disable_movement", true);
        if(self BotGetDifficulty() == "recruit") {
          self.next_goal_time = GetTime() + RandomIntRange(5000, 7000);
        }
        else {
          self.next_goal_time = GetTime() + RandomIntRange(3000, 5000);
        }
        state = "needs_new_goal";
      } else {
        heli_to_current_target = (current_target - self.vehicle_controlling.origin);
        heli_to_current_target_angles = VectorToAngles(heli_to_current_target);
        stick_speed = ter_op(dist_to_goal_sq < bot_get_heli_slowdown_dist_sq(rides_on_mesh), 0.5, 1.0);
        self BotSetScriptMove(heli_to_current_target_angles[1], wait_time, stick_speed);
        time_till_next_stuck_check -= wait_time;

        if(time_till_next_stuck_check <= 0.0) {
          if(DistanceSquared(self.vehicle_controlling.origin, last_vehicle_origin) < 15 * 15) {
            current_node.bot_visited_times[self.entity_number]++;
            state = "needs_new_goal";
          }

          last_vehicle_origin = self.vehicle_controlling.origin;
          time_till_next_stuck_check = SCR_CONST_BOT_VANGUARD_STUCK_TIME;
        }
      }
    }
    /#		
    if(GetDvarInt("ai_showpaths") == 1) {
      if(isDefined(current_target)) {
        Line(self.vehicle_controlling.origin, current_target, (0, 0, 1), 1.0, false);
      }
    }

    wait(wait_time);
  }
}

get_random_outside_target() {
  possible_zones = [];
  foreach(z in level.outside_zones) {
    enemies_in_zone = BotZoneGetCount(z, self.team, "enemy_predict");
    if(enemies_in_zone > 0) {
      possible_zones = array_add(possible_zones, z);
    }
  }

  target_loc = undefined;
  if(possible_zones.size > 0) {
    random_zone = Random(possible_zones);
    random_node = Random(GetZoneNodes(random_zone));
    target_loc = random_node.origin;
  } else {
    if(isDefined(level.teleportGetActiveNodesFunc)) {
      all_nodes = [
    }
        [level.teleportGetActiveNodesFunc]
      ]();
    else {
      all_nodes = GetAllNodes();
    }
    num_picked = 0;
    while(num_picked < 10) {
      num_picked++;
      node_picked = all_nodes[RandomInt(all_nodes.size)];
      target_loc = node_picked.origin;
      if(NodeExposedToSky(node_picked) && Distance2DSquared(node_picked.origin, self.vehicle_controlling.origin) > 250 * 250) {
        break;
      }
    }
  }

  return target_loc;
}