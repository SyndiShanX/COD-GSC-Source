/****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_assaultdrone_ai.gsc
****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\_aerial_pathnodes;

SCR_CONST_PATH_TIMEOUT_TIME_AIR = 7.5;
SCR_CONST_REACHED_NODE_RADIUS = 24.0;
SCR_CONST_ENEMY_MOVED_FAR_FROM_GOAL_DIST = 128.0;
SCR_CONST_WEAPON_RADAR_PING_TIME = 3.0;
SCR_CONST_ENEMY_TOO_CLOSE_FOR_ROCKETS_DIST_SQ = 132 * 132;
SCR_CONST_ENEMY_TARGET_OFFSET = (0, 0, 40);

SCR_CONST_ALWAYS_SHOW_VEHICLE_PATH_DEBUG = false;
SCR_CONST_SHOW_AI_TARGET = false;
SCR_CONST_ONLY_ASCEND_NO_ADDITIONAL_MOVEMENT = false;

assault_vehicle_ai_init() {
  thread maps\mp\_aerial_pathnodes::calculate_aerial_pathnodes();
}

AIStartUsingAssaultVehicle(AssaultVehicle) {
  self thread assault_vehicle_ai_end_on_owner_disconnect(AssaultVehicle);

  wait(2.0);

  waittill_aerial_pathnodes_calculated();

  if(isDefined(AssaultVehicle)) {
    AssaultVehicle.enemy_target_last_vis_time = 0;
    AssaultVehicle.enemy_target_visible = false;

    AssaultVehicle thread assault_vehicle_ai_aerial_movement();

    AssaultVehicle thread assault_vehicle_ai_threat();
    AssaultVehicle thread assault_vehicle_ai_weapons(!AssaultVehicle.hasTurret);

    if(isDefined(level.isHorde) && level.isHorde) {
      self.aerialAssaultDrone = AssaultVehicle;
      AssaultVehicle.isAerialAssaultDrone = true;
      AssaultVehicle thread assault_vehicle_horde_monitor_death(self);
    }
  }
}

assault_vehicle_horde_monitor_death(player) {
  self waittill("death");
  self.aerialAssaultDrone = undefined;
}

assault_vehicle_ai_end_on_owner_disconnect(AssaultVehicle) {
  AssaultVehicle endon("death");

  self waittill("disconnect");
  AssaultVehicle notify("death");
}

assault_vehicle_ai_aerial_movement() {
  self notify("assault_vehicle_ai_aerial_movement");
  self endon("assault_vehicle_ai_aerial_movement");
  self endon("death");

  speed = self Vehicle_GetTopSpeed();
  self Vehicle_SetSpeed(speed, 8, 60);
  self SetHoverParams(0, 0, 0);

  path = undefined;
  nearest_node_to_vehicle = assault_vehicle_ai_get_nearest_node();
  if(!isDefined(nearest_node_to_vehicle)) {
    AssertMsg("AI Aerial Assault Vehicle unable to find nearby node near pos " + self.origin);
    return;
  }

  valid_close_aerial_node = nearest_node_to_vehicle;
  if(!node_is_aerial(valid_close_aerial_node)) {
    node = get_ent_closest_aerial_node(64, 0);
    if(isDefined(node)) {
      valid_close_aerial_node = node;
    }
  }

  if(node_is_aerial(valid_close_aerial_node)) {
    path = GetNodesOnPath(self.origin, valid_close_aerial_node.origin, true, nearest_node_to_vehicle);
  }

  if(!isDefined(path)) {
    max_dist_search = 1500;
    min_dist_search = 0;

    while(!isDefined(path) && min_dist_search < max_dist_search) {
      nearest_node = get_ent_closest_aerial_node(max_dist_search, min_dist_search);
      if(isDefined(nearest_node)) {
        path = GetNodesOnPath(self.origin, nearest_node.origin, true, nearest_node_to_vehicle);
        if(!isDefined(path)) {
          min_dist_search = Distance(self.origin, nearest_node.origin) + 1;
        }
      } else {
        min_dist_search = max_dist_search + 1;
      }
    }

    if(min_dist_search > max_dist_search) {
      AssertMsg("AI Aerial Assault Vehicle unable to find any nearby aerial nodes near pos " + self.origin);
      return;
    }
  }

  end_node = assault_vehicle_ai_aerial_follow_path_outside(path);

  assault_vehicle_ai_move_to_aerial_node(end_node);
  wait(0.85);

  should_aerial_move = true;

  if(SCR_CONST_ONLY_ASCEND_NO_ADDITIONAL_MOVEMENT) {
    should_aerial_move = false;
  }

  if(should_aerial_move) {
    self notify("in_air");
    self assault_vehicle_ai_aerial_pathing_turret(end_node);
  }
}

assault_vehicle_ai_aerial_follow_path_outside(path) {
  node_offset = (0, 0, 40);

  for(i = 0; i < path.size; i++) {
    next_node = path[i];
    self assault_vehicle_ai_air_movement_func(next_node.origin + node_offset);
    drive_time = 0;

    while(Distance2DSquared(next_node.origin, self.origin) > squared(SCR_CONST_REACHED_NODE_RADIUS)) {
      /#			
      self assault_vehicle_ai_draw_debug_path(path, i, node_offset);

      drive_time += 0.05;
      if(drive_time > self assault_vehicle_ai_path_timeout_time()) {
        return;
      }

      wait(0.05);
    }

    if(node_is_aerial(next_node)) {
      return next_node;
    }
  }

  return path[path.size - 1];
}

assault_vehicle_ai_move_to_aerial_node(node) {
  Assert(node_is_aerial(node));

  current_node_origin = node.origin + get_aerial_offset();
  self assault_vehicle_ai_air_movement_func(current_node_origin);
  while(DistanceSquared(self.origin, current_node_origin) > SCR_CONST_REACHED_NODE_RADIUS * SCR_CONST_REACHED_NODE_RADIUS) {
    /#		
    if(GetDvarInt("ai_showpaths") == 1 || SCR_CONST_ALWAYS_SHOW_VEHICLE_PATH_DEBUG) {
      line(self.origin, current_node_origin, (0, 0, 1), 1.0, false, 4);
    }

    wait(0.05);
  }
}

assault_vehicle_ai_aerial_pathing_turret(start_node) {
  Assert(node_is_aerial(start_node));

  current_aerial_node = start_node;
  visited_nodes = [];
  visited_nodes[current_aerial_node GetNodeNumber()] = 1;

  while(1) {
    current_aerial_node = assault_vehicle_ai_pick_aerial_node(current_aerial_node, visited_nodes);

    assault_vehicle_ai_move_to_aerial_node(current_aerial_node);

    current_node_number = current_aerial_node GetNodeNumber();
    if(!isDefined(visited_nodes[current_node_number])) {
      visited_nodes[current_node_number] = 0;
    }
    visited_nodes[current_node_number]++;

    wait(RandomFloatRange(0.05, 2.0));
  }
}

assault_vehicle_ai_aerial_pathing_c4() {
  while(1) {
    node_goal = undefined;
    if(self assault_vehicle_ai_enemy_exists_and_is_alive()) {
      node_goal = self.enemy_target get_ent_closest_aerial_node();
    }

    if(!isDefined(node_goal)) {
      node_goal = Random(level.aerial_pathnodes);
    }

    start_node = self get_ent_closest_aerial_node();
    path = find_path_between_aerial_nodes(start_node, node_goal);
    if(isDefined(path)) {
      assault_vehicle_ai_follow_path(path, ::assault_vehicle_ai_air_movement_func, ::assault_vehicle_ai_enemy_moved_air, get_aerial_offset()[2]);
    }

    if(self assault_vehicle_ai_enemy_exists_and_is_alive()) {
      if(!self assault_vehicle_ai_enemy_moved_air(node_goal) || Distance2DSquared(self.origin, self.enemy_target.origin) < squared(200)) {
        ground_target_origin = self.enemy_target.origin + SCR_CONST_ENEMY_TARGET_OFFSET;
        self SetVehGoalPos(ground_target_origin, true);
        while(self assault_vehicle_ai_enemy_exists_and_is_alive() && DistanceSquared(ground_target_origin, self.origin) > squared(SCR_CONST_REACHED_NODE_RADIUS)) {
          wait(0.05);
        }
        wait(0.8);

        self assault_vehicle_ai_ground_movement(::assault_vehicle_ai_air_movement_func, ::assault_vehicle_ai_enemy_moved_ground);
      }
    }

    wait(0.05);
  }
}

assault_vehicle_ai_pick_aerial_node(current_node, visited_nodes) {
  best_node = undefined;
  best_node_visits = 9999;
  neighbors_randomized = array_randomize(current_node.aerial_neighbors);
  foreach(neighbor_node in neighbors_randomized) {
    neighbor_node_num = neighbor_node GetNodeNumber();
    neighbor_node_visits = visited_nodes[neighbor_node_num];
    if(!isDefined(neighbor_node_visits)) {
      return neighbor_node;
    }

    if(neighbor_node_visits < best_node_visits) {
      best_node = neighbor_node;
      best_node_visits = neighbor_node_visits;
    }
  }

  Assert(isDefined(best_node));
  return best_node;
}

assault_vehicle_ai_get_nearest_node() {
  nearest_node_to_vehicle = GetClosestNodeInSight(self.origin, true);
  if(!isDefined(nearest_node_to_vehicle)) {
    nodes_near_vehicle_sorted = GetNodesInRadiusSorted(self.origin, 1000, 0);
    if(nodes_near_vehicle_sorted.size > 0) {
      nearest_node_to_vehicle = nodes_near_vehicle_sorted[0];
    }
  }

  return nearest_node_to_vehicle;
}

assault_vehicle_ai_ground_movement(movement_func, enemy_moved_func) {
  self endon("death");

  nearest_node_to_vehicle = assault_vehicle_ai_get_nearest_node();
  if(!isDefined(nearest_node_to_vehicle)) {
    AssertMsg("AI Ground Assault Vehicle unable to find nearby node near pos " + self.origin);
    return;
  }

  while(1) {
    self childthread assault_vehicle_ai_ground_movement_loop(movement_func, enemy_moved_func);
    self waittill_any("enemy");
  }
}

assault_vehicle_ai_ground_movement_loop(movement_func, enemy_moved_func) {
  self notify("assault_vehicle_ai_ground_movement_loop");
  self endon("assault_vehicle_ai_ground_movement_loop");

  unreachable_nodes = [];

  while(1) {
    randomNode = undefined;
    goal_pos = undefined;
    if(self assault_vehicle_ai_enemy_exists_and_is_alive()) {
      goal_pos = self.enemy_target.origin;
    } else {
      count = 0;
      while(!isDefined(randomNode) && count < 20) {
        randomNode = GetRandomNodeDestination(self.origin, self.angles);
        if(isDefined(randomNode)) {
          if(array_contains(unreachable_nodes, randomNode)) {
            randomNode = undefined;
          } else {
            goal_pos = randomNode.origin;
          }
        }

        count++;
        wait(0.05);
      }
    }

    if(isDefined(goal_pos)) {
      start_node = assault_vehicle_ai_get_nearest_node();
      if(!isDefined(start_node)) {
        AssertMsg("AI Ground Assault Vehicle unable to find nearby node near pos " + self.origin);
        return;
      }

      path = GetNodesOnPath(self.origin, goal_pos, false, start_node);
      if(isDefined(path)) {
        assault_vehicle_ai_follow_path(path, movement_func, enemy_moved_func);
      } else {
        unreachable_nodes[unreachable_nodes.size] = randomNode;
      }
    }

    wait(0.05);
  }
}

assault_vehicle_ai_get_camera_position() {
  camera_offset = self VehicleGet3PCameraOffset();
  camera_position = self.origin + RotateVector(camera_offset, self.angles);
  return camera_position;
}

assault_vehicle_ai_threat() {
  self endon("death");
  /#	
  self childthread assault_vehicle_ai_debug_threat_lines();

  while(1) {
    known_enemies = [];
    wait_this_frame = false;

    if(isDefined(self.enemy_target) && !IsAlive(self.enemy_target)) {
      last_inflictor = self.enemy_target.lastInflictor;
      if(isDefined(last_inflictor)) {
        if(last_inflictor == self || (isDefined(last_inflictor.tank) && last_inflictor.tank == self)) {
          self.fire_at_dead_time = GetTime() + 1000;
          wait(1.0);
        }
      }
    }

    foreach(character in level.characters) {
      if(IsAlive(character) && !IsAlliedSentient(self, character) && self.owner != character) {
        if(character _hasPerk("specialty_blindeye")) {
          continue;
        }

        is_position_known = false;

        trace_start = self assault_vehicle_ai_get_camera_position();
        trace_end = character.origin + SCR_CONST_ENEMY_TARGET_OFFSET;

        if(self.hasARHud) {
          is_position_known = true;
        }
        if(isDefined(character.lastshotfiredtime) && GetTime() - character.lastshotfiredtime < SCR_CONST_WEAPON_RADAR_PING_TIME) {
          is_position_known = true;
        } else if(GetTeamRadarStrength(self.team) > GetUAVStrengthLevelNeutral()) {
          is_position_known = true;
        } else if(SightTracePassed(trace_start, trace_end, false, self, character)) {
          is_position_known = true;
        }

        if(is_position_known && self.hasTurret) {
          pitch_max = self VehicleGet3PPitchClamp();

          vec_to_target = trace_end - trace_start;
          angles_to_target = VectorToAngles(vec_to_target);
          pitch = AngleClamp180(angles_to_target[0]);

          if(pitch > pitch_max || pitch < -1 * pitch_max) {
            is_position_known = false;
          }
        }

        if(is_position_known) {
          known_enemies[known_enemies.size] = character;
        }

        if(wait_this_frame) {
          wait(0.05);
        }
        wait_this_frame = !wait_this_frame;
      }
    }

    if(isDefined(level.isHorde) && level.isHorde) {
      foreach(drone in level.flying_attack_drones) {
        is_position_known = false;

        trace_start = self assault_vehicle_ai_get_camera_position();
        trace_end = (0, 0, 0);
        if(isDefined(drone.origin)) {
          trace_end = drone.origin;
          if(SightTracePassed(trace_start, trace_end, false, self, drone)) {
            is_position_known = true;
          }
        }

        if(is_position_known) {
          pitch_max = self VehicleGet3PPitchClamp();

          vec_to_target = trace_end - trace_start;
          angles_to_target = VectorToAngles(vec_to_target);
          pitch = AngleClamp180(angles_to_target[0]);

          if(pitch > pitch_max || pitch < -1 * pitch_max) {
            is_position_known = false;
          }
        }

        if(is_position_known) {
          known_enemies[known_enemies.size] = drone;
        }

        if(wait_this_frame) {
          waitframe;
        }
        wait_this_frame = !wait_this_frame;
      }

      foreach(sentry in level.hordeSentryArray) {
        is_position_known = false;

        trace_start = self assault_vehicle_ai_get_camera_position();
        trace_end = (0, 0, 0);

        if(isDefined(sentry.origin)) {
          trace_end = sentry.origin + SCR_CONST_ENEMY_TARGET_OFFSET;
          if(SightTracePassed(trace_start, trace_end, false, self, sentry)) {
            is_position_known = true;
          }
        }

        if(is_position_known) {
          pitch_max = self VehicleGet3PPitchClamp();

          vec_to_target = trace_end - trace_start;
          angles_to_target = VectorToAngles(vec_to_target);
          pitch = AngleClamp180(angles_to_target[0]);

          if(pitch > pitch_max || pitch < -1 * pitch_max) {
            is_position_known = false;
          }
        }

        if(is_position_known) {
          known_enemies[known_enemies.size] = sentry;
        }

        if(wait_this_frame) {
          waitframe;
        }
        wait_this_frame = !wait_this_frame;
      }

      removeTheseGuys = [];

      foreach(guy in known_enemies) {
        if(!isDefined(guy)) {
          removeTheseGuys[removeTheseGuys.size] = guy;
        } else if((isDefined(guy.ishordedrone) && guy.ishordedrone)) {
          if(!isDefined(guy.damageTaken) || !isDefined(guy.maxHealth) || (guy.damageTaken > guy.maxHealth)) {
            removeTheseGuys[removeTheseGuys.size] = guy;
          }
        } else if(isDefined(guy.ishordeenemysentry) && guy.ishordeenemysentry) {
          if(!guy.isAlive) {
            removeTheseGuys[removeTheseGuys.size] = guy;
          }
        }
      }
      foreach(guy in removeTheseGuys) {
        known_enemies = array_remove(known_enemies, guy);
      }
    }

    if(known_enemies.size > 0) {
      known_enemies_sorted = get_array_of_closest(self.origin, known_enemies);
      old_enemy = self.enemy_target;
      self.enemy_target = known_enemies_sorted[0];

      if(!isDefined(old_enemy) || old_enemy != self.enemy_target) {
        self notify("enemy");
      }
    } else if(isDefined(self.enemy_target)) {
      self.enemy_target = undefined;
    }

    wait(0.05);
  }
}

assault_vehicle_ai_debug_threat_lines() {
  while(1) {
    if(SCR_CONST_SHOW_AI_TARGET) {
      if(self assault_vehicle_ai_enemy_exists_and_is_alive()) {
        debug_line_color = (0, 1, 0);
        if(self assault_vehicle_ai_can_see_living_enemy()) {
          debug_line_color = (1, 0, 0);
        }

        if(isDefined(level.isHorde) && level.isHorde) {
          if((isDefined(self.enemy_target.ishordedrone) && self.enemy_target.ishordedrone)) {
            line(self.origin, self.enemy_target.origin, debug_line_color, 1.0, false);
          } else {
            line(self.origin, self.enemy_target.origin + SCR_CONST_ENEMY_TARGET_OFFSET, debug_line_color, 1.0, false);
          }
        } else {
          line(self.origin, self.enemy_target.origin + SCR_CONST_ENEMY_TARGET_OFFSET, debug_line_color, 1.0, false);
        }
      }

      if(isDefined(self.TargetEnt)) {
        line(self.origin, self.TargetEnt.origin, (0, 0, 1), 1.0, false);
      }
    }

    wait(0.05);
  }
}

assault_vehicle_ai_weapons(wait_till_in_air) {
  self endon("death");

  if(wait_till_in_air) {
    self waittill("in_air");
  }

  self.last_rocket_time = 0;
  self.initial_enemy_target = true;
  c4_radius_sq = squared(maps\mp\killstreaks\_drone_assault::GetAssaultVehicleC4Radius() * 0.75);

  while(1) {
    if(isDefined(self.TargetEnt)) {
      if(self assault_vehicle_ai_enemy_exists_and_is_alive()) {
        if(self assault_vehicle_ai_can_see_living_enemy()) {
          if(isDefined(level.isHorde) && level.isHorde) {
            if((isDefined(self.enemy_target.ishordedrone) && self.enemy_target.ishordedrone)) {
              self.TargetEnt.origin = self.enemy_target.origin;
            } else {
              self.TargetEnt.origin = self.enemy_target.origin + SCR_CONST_ENEMY_TARGET_OFFSET;
            }
          } else {
            if(self.hasTurret) {
              self.TargetEnt.origin = self.enemy_target.origin + SCR_CONST_ENEMY_TARGET_OFFSET;
            } else {
              self.TargetEnt.origin = self.enemy_target.origin + (anglesToForward(self.enemy_target.angles) * 100);
            }
          }

          desired_angles = VectorToAngles(self.TargetEnt.origin - self.origin);
          yaw_change = desired_angles[1] - self.angles[1];
          while(yaw_change > 180) {
            yaw_change -= 360;
          }
          while(yaw_change < -180) {
            yaw_change += 360;
          }

          yaw_change_per_frame = 10;
          if(abs(yaw_change) < yaw_change_per_frame) {
            new_yaw = desired_angles[1];
          } else {
            new_yaw = self.angles[1] + yaw_change_per_frame * (yaw_change / abs(yaw_change));
          }
          self Vehicle_Teleport(self.origin, (desired_angles[0], new_yaw, self.angles[2]), true, true);

          if(self.initial_enemy_target) {
            wait(0.1);
            self.initial_enemy_target = false;
            if(!self assault_vehicle_ai_can_see_living_enemy()) {
              continue;
            }
          }

          should_use_rockets = self.hasRockets && self.RocketAmmo > 0;
          if(self.hasTurret) {
            attack_start_loc = self.mgTurret GetTagOrigin("tag_flash");
          } else {
            attack_start_loc = self.origin;
          }
          if(should_use_rockets) {
            should_use_rockets = DistanceSquared(attack_start_loc, self.enemy_target.origin) > SCR_CONST_ENEMY_TOO_CLOSE_FOR_ROCKETS_DIST_SQ;
          }

          vec_to_target = (self.TargetEnt.origin - attack_start_loc);
          angles_to_target = VectorToAngles(vec_to_target);
          pitch_max = self VehicleGet3PPitchClamp();
          pitch_to_target = AngleClamp180(angles_to_target[0]);
          is_within_pitch_limitations = pitch_to_target < pitch_max && pitch_to_target > -1 * pitch_max;

          vehicle_forward_2d = VectorNormalize(anglesToForward(self.angles) * (1, 1, 0));
          vec_to_target_2d = VectorNormalize(vec_to_target * (1, 1, 0));
          is_in_front_of_vehicle = VectorDot(vehicle_forward_2d, vec_to_target_2d) > 0.90;

          if(is_within_pitch_limitations && is_in_front_of_vehicle) {
            if(self.hasRockets && should_use_rockets) {
              if(GetTime() > self.last_rocket_time + 1000) {
                if(self.hasMG) {
                  self notify("FireSecondaryWeapon");
                } else {
                  self notify("FirePrimaryWeapon");
                }
                self.last_rocket_time = GetTime();
              }
            } else if(self.hasMG) {
              self.mgTurret ShootTurret();
            } else if(!self.hasTurret) {
              if(SightTracePassed(attack_start_loc, self.TargetEnt.origin, false, self, self.enemy_target)) {
                self notify("FirePrimaryWeapon");
              }
            }
          }
        } else {
          self.initial_enemy_target = true;
        }
      } else if(isDefined(self.enemy_target) && !IsAlive(self.enemy_target)) {
        if(self.hasMG) {
          if(isDefined(self.fire_at_dead_time) && GetTime() < self.fire_at_dead_time) {
            self.mgTurret ShootTurret();
          }
        }
      }
    }

    if(self.hasCloak && !maps\mp\killstreaks\_drone_common::droneIsCloaked(self)) {
      if(!isDefined(self.CloakCooldown) || self.CloakCooldown == 0) {
        self notify("Cloak");
      }
    }

    wait(0.05);
  }
}

assault_vehicle_ai_enemy_exists_and_is_alive() {
  if(isDefined(level.isHorde) && level.isHorde) {
    if(isDefined(self.enemy_target) && isDefined(self.enemy_target.ishordeenemysentry) && self.enemy_target.ishordeenemysentry) {
      return self.enemy_target.isAlive;
    } else {
      return (isDefined(self.enemy_target) && IsAlive(self.enemy_target));
    }
  } else {
    return (isDefined(self.enemy_target) && IsAlive(self.enemy_target));
  }
}

assault_vehicle_ai_can_see_living_enemy() {
  if(!self assault_vehicle_ai_enemy_exists_and_is_alive()) {
    return false;
  }

  if(GetTime() > self.enemy_target_last_vis_time) {
    self.enemy_target_last_vis_time = GetTime();

    if(isDefined(level.isHorde) && level.isHorde) {
      if(isDefined(self.enemy_target.ishordedrone) && self.enemy_target.ishordedrone) {
        self.enemy_target_visible = SightTracePassed(self assault_vehicle_ai_get_camera_position(), self.enemy_target.origin, false, self, self.enemy_target);
      } else {
        self.enemy_target_visible = SightTracePassed(self assault_vehicle_ai_get_camera_position(), self.enemy_target.origin + SCR_CONST_ENEMY_TARGET_OFFSET, false, self, self.enemy_target);
      }
    } else {
      self.enemy_target_visible = SightTracePassed(self assault_vehicle_ai_get_camera_position(), self.enemy_target.origin, false, self, self.enemy_target);
    }
  }

  return self.enemy_target_visible;
}

assault_vehicle_ai_follow_path(path, movement_func, enemy_moved_func, node_z_offset) {
  if(!isDefined(node_z_offset)) {
    node_z_offset = 0;
  }
  node_offset = (0, 0, node_z_offset);

  for(i = 0; i < path.size; i++) {
    next_node = path[i];
    self[[movement_func]](next_node.origin + node_offset);
    drive_time = 0;

    while(Distance2DSquared(next_node.origin, self.origin) > squared(SCR_CONST_REACHED_NODE_RADIUS)) {
      /#			
      self assault_vehicle_ai_draw_debug_path(path, i, node_offset);

      drive_time += 0.05;
      needs_new_path = (drive_time > self assault_vehicle_ai_path_timeout_time());

      if(!needs_new_path && self assault_vehicle_ai_enemy_exists_and_is_alive()) {
        needs_new_path = self[[enemy_moved_func]](path[path.size - 1]);
      }

      if(needs_new_path) {
        return;
      }

      if(self.hasTurret && self assault_vehicle_ai_can_see_living_enemy()) {
        self[[movement_func]](self.origin);
        while(self assault_vehicle_ai_can_see_living_enemy()) {
          wait(0.05);
        }

        self[[movement_func]](next_node.origin);
      }

      wait(0.05);
    }
  }
}

assault_vehicle_ai_enemy_moved_air(path_end_node) {
  enemy_nearest_aerial_node = self.enemy_target get_ent_closest_aerial_node();
  return (enemy_nearest_aerial_node != path_end_node);
}

assault_vehicle_ai_enemy_moved_ground(path_end_node) {
  return DistanceSquared(path_end_node.origin, self.enemy_target.origin) > squared(SCR_CONST_ENEMY_MOVED_FAR_FROM_GOAL_DIST);
}

assault_vehicle_ai_draw_debug_path(path, start_index, node_offset) {
  if(GetDvarInt("ai_showpaths") == 1 || SCR_CONST_ALWAYS_SHOW_VEHICLE_PATH_DEBUG) {
    line(self.origin + (0, 0, 10), path[start_index].origin + (0, 0, 10) + node_offset, (0, 0, 1), 1.0, false, 4);
    for(j = start_index; j < path.size - 1; j++) {
      line(path[j].origin + (0, 0, 10) + node_offset, path[j + 1].origin + (0, 0, 10) + node_offset, (0, 0, 1), 1.0, false, 4);
    }
  }
}

assault_vehicle_ai_path_timeout_time() {
  return SCR_CONST_PATH_TIMEOUT_TIME_AIR;
}

assault_vehicle_ai_air_movement_func(dest) {
  self SetVehGoalPos(dest, true);
}