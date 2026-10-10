/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6e2cd47141f9745b.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\astar;
#using scripts\cp\cp_gameskill;
#using scripts\cp\damagefeedback;
#using scripts\cp\laststand;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_891f3a6761758942;

function init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level._effect["drone_swarm_light_danger"] = loadfx("vfx/iw8_cp/raid/vfx_raid_wheelson_flashlight_npc.vfx");
  level._effect["drone_swarm_light_alert"] = loadfx("vfx/iw8_cp/raid/vfx_raid_wheelson_flashlight_npc_calm.vfx");

  if(!isDefined(level.drone_turrets)) {
    level.drone_turrets = [];
  }

  level.var_ef94125f71754b2f = [];
  level.var_f753d22ae87b557b = 1;
  level thread function_f0eac5e558857c84();
}

function function_cb2c1df00bd5e191(spawnpoint, var_f716273270785091, swarm_id) {
  return function_305ec846c77281f6(spawnpoint, "axis", var_f716273270785091, swarm_id);
}

function function_bca2ae187983e50a(spawnpoint, var_f716273270785091, swarm_id) {
  return function_305ec846c77281f6(spawnpoint, "allies", var_f716273270785091, swarm_id);
}

function function_305ec846c77281f6(spawnpoint, drone_team, var_f716273270785091, swarm_id) {
  if(level.drone_turrets.size >= 32) {
    announcement("<dev string:x1c>");

    return;
  }

  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  dronemodel = "veh8_mil_air_tuniform_c4_ai";
  drone = spawnVehicle(dronemodel, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = drone_team;
  drone.spawnpoint = spawnpoint;
  drone.spawntime = gettime();
  drone.swarm_id = swarm_id;
  drone function_98fbc01ff1e11fd8();
  malfa_clip = getEnt("malfa_clip", "targetname");
  drone.clip = spawn("script_model", malfa_clip.origin);
  drone.clip.angles = malfa_clip.angles;
  drone.clip clonebrushmodeltoscriptmodel(malfa_clip);
  drone.clip.origin = drone.origin;
  drone.clip.angles = drone.angles;
  drone.clip linkTo(drone, "j_body", (0, 0, 0), (0, 0, 0));
  drone.clip enableaimassist();
  drone.clip setCanDamage(1);
  drone.clip makeentitysentient(drone_team, 1, 1);
  drone.clip.var_d1f953c063dff1eb = 1;
  drone thread damage_feedback_watch();
  drone thread function_5e52ae7fc7833e15();
  drone thread patrol_think(spawnpoint, var_f716273270785091);
  drone thread watch_for_death();
  drone thread function_53747f8ce3d99087();
  drone thread function_d222480796864019();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone setturningability(0.6);
  drone setmaxpitchroll(10, 10);
  drone setairresistance(20);

  if(!isDefined(level.vehicle_ai_script_models)) {
    level.vehicle_ai_script_models = [];
  }

  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = drone;
  level.drone_turrets[level.drone_turrets.size] = drone;
  return drone;
}

function function_98fbc01ff1e11fd8() {
  if(!isDefined(level.var_ef94125f71754b2f[self.swarm_id])) {
    level.var_ef94125f71754b2f[self.swarm_id] = spawnStruct();
  }

  var_db46c7d01ee9223f = level.var_ef94125f71754b2f[self.swarm_id];

  if(!isDefined(var_db46c7d01ee9223f.drones)) {
    var_db46c7d01ee9223f.drones = [];
  }

  if(!isDefined(var_db46c7d01ee9223f.headicons)) {
    var_db46c7d01ee9223f.headicons = [];
  }

  var_db46c7d01ee9223f.drones[var_db46c7d01ee9223f.drones.size] = self;

  if(!isDefined(var_db46c7d01ee9223f.id)) {
    var_db46c7d01ee9223f.id = self.swarm_id;
  }

  self.var_db46c7d01ee9223f = var_db46c7d01ee9223f;
  thread function_7fef88fa109a4a01();
}

function function_7fef88fa109a4a01() {
  level endon("game_ended");
  var_db46c7d01ee9223f = self.var_db46c7d01ee9223f;
  self waittill("death");
  var_db46c7d01ee9223f.drones = array_remove(var_db46c7d01ee9223f.drones, self);

  if(isDefined(self.headicon)) {
    var_db46c7d01ee9223f.headicons = array_remove(var_db46c7d01ee9223f.headicons, self.headicon);
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  }
}

function function_34a36f44dd3b1ea9(refs) {
  wait 3;

  foreach(ref in refs) {
    if(isDefined(ref) && isent(ref)) {
      ref notify("death");
      ref delete();
    }
  }
}

function function_f0eac5e558857c84() {
  self endon("death");

  while(true) {
    wait 0.25;

    if(!isDefined(level.drone_turrets) || level.drone_turrets.size == 0) {
      wait 1;
      continue;
    }

    foreach(var_d9d444d1b3160ba1 in level.var_ef94125f71754b2f) {
      if(!isDefined(var_d9d444d1b3160ba1.leader)) {
        if(var_d9d444d1b3160ba1.drones.size > 0) {
          bestdrone = undefined;
          var_72b9c1ca84591923 = function_ba16debf946dba5a();
          var_631d8b7b8cdb163 = function_3693638f97674c98();
          var_7f004b9bafbafa4a = var_d9d444d1b3160ba1.drones function_46ad4cb259b30031();
          closestplayer = var_7f004b9bafbafa4a get_closest_living_player();

          foreach(drone in var_d9d444d1b3160ba1.drones) {
            if(!drone function_4149e78c6beb0d0e(var_72b9c1ca84591923, var_631d8b7b8cdb163)) {
              wait 0.05;
              continue;
            }

            if(!isDefined(bestdrone)) {
              bestdrone = drone;
              continue;
            }

            if(isDefined(closestplayer)) {
              var_d32e4c561742e237 = distancesquared(drone.origin, closestplayer.origin);
              var_c7e71d59c1c42de7 = distancesquared(drone.origin, closestplayer.origin);

              if(var_d32e4c561742e237 < var_c7e71d59c1c42de7) {
                bestdrone = drone;
              }
            }
          }

          if(isDefined(bestdrone)) {
            bestdrone thread function_21045a0d241029a();
          }

          continue;
        }
      }

      if(!isent(var_d9d444d1b3160ba1.leader) || !isalive(var_d9d444d1b3160ba1.leader)) {
        var_d9d444d1b3160ba1.leader = undefined;
      }

      wait 0.05;
    }
  }
}

function function_21045a0d241029a() {
  self.var_db46c7d01ee9223f.leader = self;
  self.var_db46c7d01ee9223f notify("group_new_leader", self);
  thread function_721cc43274bb86af("alert");
  thread function_8e8fd2eb99ba5b39();

  if(istrue(level.var_77d9637a0fc5a67e)) {
    announcement("<dev string:x2a>" + self getentitynumber());
  }

  foreach(drone in self.var_db46c7d01ee9223f.drones) {
    if(drone == self) {
      continue;
    }

    drone.var_3aec9a4ec140655a = undefined;
    drone.re_path = undefined;
    drone thread function_721cc43274bb86af("off");
  }
}

function function_ba16debf946dba5a() {
  ignore = undefined;

  if(level.drone_turrets.size > 0) {
    ignore = [];

    for(i = 0; i < level.drone_turrets.size; i++) {
      ignore[ignore.size] = level.drone_turrets[i];
      ignore[ignore.size] = level.drone_turrets[i].clip;
    }
  }

  return ignore;
}

function function_3693638f97674c98() {
  contents = scripts\engine\trace::create_contents(0, 0, 0, 1, 1, 1, 0, 1);
  return contents;
}

function function_4149e78c6beb0d0e(ignore, contents) {
  radius = 16;

  if(!isDefined(self) || !isDefined(self.origin)) {
    return 0;
  }

  endpoint = self.origin;

  if(isDefined(self.var_2b16fd690b342c8e) && self.var_f1c32ac23baf6a5 > gettime() - 3000) {
    endpoint = self.var_2b16fd690b342c8e;
  }

  spheretrace = scripts\engine\trace::sphere_trace_passed(self.origin, endpoint, radius, ignore, contents);
  return spheretrace;
}

function function_46ad4cb259b30031() {
  pos = undefined;
  num = 0;

  foreach(drone in self) {
    if(!isDefined(pos)) {
      pos = drone.origin;
    } else {
      pos += drone.origin;
    }

    num++;
  }

  struct = spawnStruct();
  struct.origin = pos / num;
  return struct;
}

function function_8e8fd2eb99ba5b39() {
  self waittill("death");
  self.var_db46c7d01ee9223f notify("group_leader_death");

  if(isDefined(self.headicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  }
}

function function_77f1c6a83258ceb9() {
  if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader == self) {
    return true;
  }

  return false;
}

function patrol_think(spawnpoint, var_f716273270785091) {
  self endon("death");

  if(isDefined(spawnpoint.script_parameters)) {
    self waittill(spawnpoint.script_parameters);
  }

  thread play_loop_sound_on_entity("recondrone_eng_high");
  thread play_loop_sound_on_entity("emt_drone_proximity_lp");

  while(true) {
    if(!isDefined(self.var_db46c7d01ee9223f.leader) || !isalive(self.var_db46c7d01ee9223f.leader)) {
      function_c7a29d92e0ee715b(spawnpoint, var_f716273270785091);
    }

    if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader == self) {
      function_8cf7f8b74219ac94(spawnpoint, var_f716273270785091);
      continue;
    }

    if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader != self) {
      function_327ce98e7384e9ff(spawnpoint, var_f716273270785091);
    }
  }
}

function function_8cf7f8b74219ac94(spawnpoint, var_f716273270785091) {
  self endon("death");
  self.turningability = 0.8;
  self setturningability(self.turningability);
  offset = undefined;
  speed = 10;

  if(isDefined(level.var_3e81a9fcedd1021d)) {
    speed = level.var_3e81a9fcedd1021d;
  }

  speed *= 0.75;
  grid_size = 500;
  self.repath_dist = squared(250);
  self.var_9896fa8b6e050049 = squared(900);

  if(isDefined(var_f716273270785091) && isstring(var_f716273270785091)) {
    self.node_grid = getStructArray(var_f716273270785091, "script_noteworthy");
  } else {
    self.node_grid = getStructArray("drone_grid", "script_noteworthy");
  }

  end_pos = self.origin;
  node_index = 0;
  self.cur_state = "spawn";
  self.attack_dist = 800;
  self.var_950028441ba5facb = self.attack_dist * self.attack_dist;
  node = spawnpoint;

  while(true) {
    enemy_target = get_enemy();

    if(!isDefined(enemy_target)) {
      if(!isDefined(self.var_3aec9a4ec140655a)) {
        function_9ab4de075453475b();
      } else {
        end_pos = self.var_3aec9a4ec140655a;
      }

      if(self.cur_state != "no_target") {
        if(getdvarint(@ "astar_debug", 0)) {
          level thread drawsphere(end_pos, 5, 1, (1, 1, 1));
        }

        start_pos = self.origin;
        exclude = self;
        dyn_node = spawnStruct();
        dyn_node.origin = self.origin;
        self.path_data = scripts\cp\astar::function_845fd743c0fadc39(self.node_grid, start_pos, end_pos, exclude, dyn_node, grid_size);

        if(!isDefined(self.path_data)) {
          wait 0.5;
          function_9ab4de075453475b();
          continue;
        }

        if(getdvarint(@ "astar_debug", 0)) {
          for(i = 0; i < self.path_data.path.size; i++) {
            if(isDefined(self.path_data.path[i]) && isDefined(self.path_data.path[i + 1])) {
              line(self.path_data.path[i].origin, self.path_data.path[i + 1].origin, (0, 1, 0), 1, 0, 20);
            }
          }
        }

        node_index = 0;
        next_node = self.path_data.start_node;
        self.cur_state = "no_target";
      }
    } else if(function_9ada223f5f41e90(enemy_target)) {
      self.var_565ae80d9fecf7ca = enemy_target;
      self.var_8d8144287647fbc5 = 1;
      function_eb38987b1c34b60f(enemy_target);
      self notify("stop_dive_bomb");
      self.re_path = 1;
      self.var_8d8144287647fbc5 = undefined;
    } else if(istrue(self.re_path)) {
      node_grid = self.node_grid;
      self.re_path = undefined;

      foreach(drone in level.drone_turrets) {
        if(drone == self) {
          continue;
        }

        if(isDefined(drone.next_node)) {
          node_grid = array_remove(node_grid, drone.next_node);
        }
      }

      start_pos = self.origin;
      end_pos = enemy_target.origin;
      var_e14ac44f6f147496 = enemy_target.origin;
      node_array = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(node_array.size > 0) {
        var_e8e4ed22f3d730b4 = [];

        foreach(node in node_array) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0), self)) {
            var_e8e4ed22f3d730b4[var_e8e4ed22f3d730b4.size] = node;
          }
        }

        if(var_e8e4ed22f3d730b4.size > 0) {
          var_e14ac44f6f147496 = var_e8e4ed22f3d730b4[randomintrange(0, int(min(3, var_e8e4ed22f3d730b4.size)))];
          var_e14ac44f6f147496 = var_e14ac44f6f147496.origin;
        } else {
          if(istrue(level.var_77d9637a0fc5a67e)) {
            announcement("<dev string:x37>");
          }

          function_9ab4de075453475b();
          var_e14ac44f6f147496 = self.var_3aec9a4ec140655a;
        }
      }

      exclude = [self, self.clip];

      if(level.drone_turrets.size > 0) {
        exclude = [];

        for(i = 0; i < level.drone_turrets.size; i++) {
          exclude[exclude.size] = level.drone_turrets[i];
          exclude[exclude.size] = level.drone_turrets[i].clip;
        }
      }

      dyn_node = spawnStruct();
      dyn_node.origin = self.origin;
      self.path_data = scripts\cp\astar::function_845fd743c0fadc39(node_grid, start_pos, var_e14ac44f6f147496, exclude, dyn_node, grid_size);

      if(!isDefined(self.path_data)) {
        wait 0.1;
        continue;
      }

      if(getdvarint(@ "astar_debug", 0)) {
        for(i = 0; i < self.path_data.path.size; i++) {
          if(isDefined(self.path_data.path[i]) && isDefined(self.path_data.path[i + 1])) {
            line(self.path_data.path[i].origin, self.path_data.path[i + 1].origin, (0, 1, 0), 1, 0, 20);
          }
        }
      }

      next_node = self.path_data.start_node;
      node_index = 0;

      if(self.cur_state != "re_path") {
        self.cur_state = "re_path";
      }
    } else if(function_9c77fa5e9c0c9a98(enemy_target, end_pos)) {
      node_grid = self.node_grid;
      start_pos = self.origin;
      end_pos = enemy_target.origin;
      var_e14ac44f6f147496 = enemy_target.origin;
      node_array = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(node_array.size > 0) {
        var_e8e4ed22f3d730b4 = [];

        foreach(node in node_array) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0), self)) {
            var_e8e4ed22f3d730b4[var_e8e4ed22f3d730b4.size] = node;
          }
        }

        if(var_e8e4ed22f3d730b4.size > 0) {
          var_e14ac44f6f147496 = var_e8e4ed22f3d730b4[randomintrange(0, int(min(3, var_e8e4ed22f3d730b4.size)))];
          var_e14ac44f6f147496 = var_e14ac44f6f147496.origin;
        }
      }

      exclude = self;
      dyn_node = spawnStruct();
      dyn_node.origin = self.origin;
      self.path_data = scripts\cp\astar::function_845fd743c0fadc39(node_grid, start_pos, var_e14ac44f6f147496, exclude, dyn_node, grid_size);

      if(!isDefined(self.path_data)) {
        wait 0.1;
        continue;
      }

      if(getdvarint(@ "astar_debug", 0)) {
        for(i = 0; i < self.path_data.path.size; i++) {
          if(isDefined(self.path_data.path[i]) && isDefined(self.path_data.path[i + 1])) {
            line(self.path_data.path[i].origin, self.path_data.path[i + 1].origin, (0, 1, 0), 1, 0, 20);
          }
        }

        clr = (0, 1, 1);
        level thread drawsphere(var_e14ac44f6f147496, 5, 1, clr);
      }

      next_node = self.path_data.start_node;

      if(self.cur_state != "new_target_loc") {
        node_index = 0;
        self.cur_state = "new_target_loc";
      }
    } else if(self.cur_state != "hunt_target") {
      self.cur_state = "hunt_target";
    }

    if(!isDefined(self.path_data)) {
      wait 0.1;
      function_9d76b32cac3b3ec();
      continue;
    }

    if(!isDefined(self.path_data.path[node_index])) {
      if(node_index >= self.path_data.path.size) {
        self.cur_state = "path_done";
        function_9d76b32cac3b3ec();
      }

      wait 0.1;
      continue;
    }

    if(istrue(self.re_path)) {
      if(function_baad9bb95a202b57()) {
        function_4b94d0301d662c36();
        continue;
      }
    }

    next_node = self.path_data.path[node_index];

    if(function_baad9bb95a202b57()) {
      self.re_path = 1;
      function_4b94d0301d662c36();
      continue;
    }

    self playsoundonmovingent("cp_bomb_drone_pause");

    if(!drone_turret_canseetarget(next_node, (0, 0, 0), self)) {
      if(isDefined(level.var_77d9637a0fc5a67e)) {
        announcement("drone tried to path through a wall?");
      }

      if(gettime() - self.spawntime > 10000) {
        self.re_path = 1;
        wait 0.1;
        continue;
      }
    }

    move_to_new_node(next_node, node_index, offset, speed);
    node_index++;
    wait 0.1;
  }
}

function function_327ce98e7384e9ff(spawnpoint, var_f716273270785091) {
  self.var_db46c7d01ee9223f endon("group_leader_death");
  self.var_db46c7d01ee9223f endon("group_new_leader");
  self endon("death");
  var_ae447f3203e2aadb = randomfloatrange(0.05, 0.2);
  var_67168602b0241e34 = randomintrange(14, 40);
  var_daa711e95f6ebfee = var_67168602b0241e34 * -1;
  speed = 10;

  if(isDefined(level.var_3e81a9fcedd1021d)) {
    speed = level.var_3e81a9fcedd1021d;
  }

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self.turningability = 1;
  self setturningability(self.turningability);

  if(isDefined(var_f716273270785091) && isstring(var_f716273270785091)) {
    self.node_grid = getStructArray(var_f716273270785091, "script_noteworthy");
  } else {
    self.node_grid = getStructArray("drone_grid", "script_noteworthy");
  }

  while(true) {
    leader = self.var_db46c7d01ee9223f.leader;
    offset = (randomfloatrange(var_daa711e95f6ebfee, var_67168602b0241e34), randomfloatrange(var_daa711e95f6ebfee, var_67168602b0241e34), randomfloatrange(var_daa711e95f6ebfee, var_67168602b0241e34));
    thread update_goal_pos(leader.origin, offset);
    self.var_2b16fd690b342c8e = leader.origin;
    self.var_f1c32ac23baf6a5 = gettime();
    self.current_node = undefined;
    wait var_ae447f3203e2aadb;
  }
}

function function_c7a29d92e0ee715b(spawnpoint, var_f716273270785091) {
  self.var_db46c7d01ee9223f endon("group_leader_death");
  self.var_db46c7d01ee9223f endon("group_new_leader");
  self endon("death");
  speed = 10;

  if(isDefined(level.var_3e81a9fcedd1021d)) {
    speed = level.var_3e81a9fcedd1021d;
  }

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self.turningability = 1;
  self setturningability(self.turningability);
  availablenodes = [];

  if(isDefined(var_f716273270785091) && isstring(var_f716273270785091)) {
    self.node_grid = getStructArray(var_f716273270785091, "script_noteworthy");
  } else {
    self.node_grid = getStructArray("drone_grid", "script_noteworthy");
  }

  availablenodes = self.node_grid;

  while(true) {
    closestnode = getclosest(self.origin, availablenodes);
    disttonode = distance(self.origin, closestnode.origin);

    if(disttonode < 16) {
      availablenodes = array_remove(availablenodes, closestnode);
      closestnode = undefined;
    }

    if(isDefined(closestnode)) {
      thread update_goal_pos(closestnode.origin, (0, 0, 0));
    }

    wait 0.25;
  }
}

function function_6374f2634771c899() {
  if(isDefined(self.var_db46c7d01ee9223f.leader)) {
    if(isent(self.var_db46c7d01ee9223f.leader) && isalive(self.var_db46c7d01ee9223f.leader)) {
      end_pos = self.var_db46c7d01ee9223f.leader.origin;
      self.var_3aec9a4ec140655a = end_pos;
      self.var_87babc8a58bc3639 = gettime();
    }
  }
}

function function_9ab4de075453475b() {
  closestnode = getclosest(self.origin, self.node_grid);
  self.var_3aec9a4ec140655a = closestnode.origin;
  self.var_87babc8a58bc3639 = gettime();
  speed = 10;

  if(isDefined(level.var_3e81a9fcedd1021d)) {
    speed = level.var_3e81a9fcedd1021d;
  }

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self.turningability = 1;
  self setturningability(self.turningability);
  self.current_node = closestnode;
  thread update_goal_pos(closestnode.origin, (0, 0, 0));
  wait 2;
}

function function_baad9bb95a202b57() {
  delay_movement = 0;

  if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader != self) {
    if(distance(self.var_db46c7d01ee9223f.leader.origin, self.origin) < 64) {
      foreach(other_drone in self.var_db46c7d01ee9223f.drones) {
        if(other_drone == self) {
          continue;
        }

        if(distance(other_drone.origin, self.origin) < 48) {
          delay_movement = 1;
        }
      }
    }
  }

  return delay_movement;
}

function function_4b94d0301d662c36() {
  wait 0.05;
}

function function_9ada223f5f41e90(enemy_target) {
  if(isstruct(enemy_target)) {
    return false;
  }

  if(gettime() - self.spawntime < 3000) {
    return false;
  }

  if(distancesquared(self.origin, enemy_target.origin) > self.var_950028441ba5facb) {
    return false;
  }

  if(istrue(self.re_path)) {
    return false;
  }

  var_445cecbefd8dc42d = enemy_target isswimunderwater() && function_3ff5fa5cffdd0aa8(enemy_target);

  if(var_445cecbefd8dc42d) {
    return true;
  }

  canseetarget = drone_turret_canseetarget(enemy_target, (0, 0, 0), self);

  if(canseetarget) {
    return true;
  }

  if(distancesquared(self.origin, enemy_target.origin) < self.repath_dist) {
    canseetarget = drone_turret_canseetarget(enemy_target, (0, 0, 0), self, 2, 1);

    if(canseetarget) {
      return true;
    }
  }

  return false;
}

function function_eb38987b1c34b60f(enemy_target) {
  if(isstruct(enemy_target)) {
    move_to_new_node(enemy_target, 0, (0, 0, 50), 33, 0.3);
    return;
  }

  target_list = function_eac4117ecb82b75e();
  target_list = sortbydistancecullbyradius(target_list, enemy_target.origin, self.attack_dist);
  thread function_40c75443a87ef6c5();
  self setturningability(0.95);
  self setlookatent(enemy_target);
  lookangle = vectortoangles(enemy_target.origin - self.origin);
  self setgoalyaw(lookangle[1]);
  self setyawspeed(500, 300, 270, 0.3);
  thread function_eb8bbc754779b523();
  thread function_721cc43274bb86af("danger");
  thread function_94d8111112ffc480();
  move_to_new_node(enemy_target, 0, (0, 0, 50), 33, 0.3);
}

function function_390147c3b3fff1cb(target_list) {
  var_1ee5d92113c13508 = &scripts\cp_mp\entityheadicons::setheadicon_singleimage;
  dist = self.attack_dist * 1.1;
  self.headicon = self thread[[var_1ee5d92113c13508]](target_list, "icon_ping_warning", 32, 1, dist, 256, undefined, 0, 1);
  self.var_db46c7d01ee9223f.headicons[self.var_db46c7d01ee9223f.headicons.size] = self.headicon;
}

function function_40c75443a87ef6c5() {
  self endon("death");
  self endon("stop_dive_bomb");

  while(true) {
    playrumbleonposition("cp_wheelson_rumble", self.origin);
    wait 0.25;
  }
}

function function_eb8bbc754779b523() {
  self endon("death");
  self endon("stop_dive_bomb");

  while(true) {
    self playsoundonmovingent("cp_bomb_drone_warning");
    wait 0.5;
  }
}

function function_9c77fa5e9c0c9a98(enemy_target, end_pos) {
  if(!isDefined(self.path_data) || self.cur_state == "path_done") {
    return true;
  }

  if(distancesquared(enemy_target.origin, end_pos) > self.repath_dist) {
    if(distancesquared(self.origin, enemy_target.origin) > self.var_9896fa8b6e050049 && distancesquared(self.origin, end_pos) > self.var_9896fa8b6e050049) {
      return false;
    }

    return true;
  }

  return false;
}

function drone_turret_canseetarget(target, offset, drone, radius_override, var_726b4bf92cac7d7b) {
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  icansee = 0;
  contents = scripts\engine\trace::create_contents(0, 0, 0, 1, 1, 1, 0, 1);

  if(!isstruct(target)) {
    tracepoints = [target gettagorigin("j_head"), target gettagorigin("j_mainroot")];
  } else {
    tracepoints = [target.origin];
  }

  radius = 16;

  if(isDefined(level.astar_node_radius_override)) {
    radius = level.astar_node_radius_override;
  }

  if(isDefined(radius_override)) {
    radius = radius_override;
  }

  ignore = undefined;
  start = self;
  fov = cos(100);

  if(level.drone_turrets.size > 0) {
    ignore = [];

    for(i = 0; i < level.drone_turrets.size; i++) {
      ignore[ignore.size] = level.drone_turrets[i];
      ignore[ignore.size] = level.drone_turrets[i].clip;
    }
  }

  for(i = 0; i < tracepoints.size; i++) {
    checktrace = scripts\engine\trace::sphere_trace(start.origin + offset, tracepoints[i], radius, ignore, contents);

    if(checktrace["fraction"] < 1) {
      continue;
    }

    if(isDefined(drone)) {
      if(!isstruct(target)) {
        if(target isswimunderwater() && !drone function_3ff5fa5cffdd0aa8(target)) {
          continue;
        }

        if(!istrue(var_726b4bf92cac7d7b)) {
          if(!within_fov(start.origin + offset, drone.angles, tracepoints[i], fov)) {
            continue;
          }
        }
      }
    }

    icansee = 1;
    break;
  }

  if(istrue(level.var_77d9637a0fc5a67e)) {
    if(icansee == 0 && !isstruct(target)) {
      announcement("<dev string:x5a>");
    }

    foreach(trace in tracepoints) {
      var_73c481a20cb5f570 = trace - self.origin;
      line(self.origin, trace, (1, 1, 0.5), 1, 0, 60);
      print3d(trace, "<dev string:x5c>", (1, 1, 0.1), 1, 1, 60, 1);
    }
  }

  return icansee;
}

function function_3ff5fa5cffdd0aa8(target) {
  if(!isPlayer(target)) {
    return true;
  }

  for(i = 0; i < self.var_db46c7d01ee9223f.drones.size; i++) {
    var_a38bcb54e21b2f5f = self.var_db46c7d01ee9223f.drones[i];

    if(isDefined(var_a38bcb54e21b2f5f.last_damaged_by) && var_a38bcb54e21b2f5f.last_damaged_by == target) {
      return true;
    }
  }

  return false;
}

function function_de436db710384fe2() {
  numdrones = self.var_db46c7d01ee9223f.drones.size;

  if(numdrones < 4.2) {
    return true;
  }

  return false;
}

function function_337ec551928c6aa1() {
  self endon("death");
  self.mgturret endon("death");

  while(true) {
    roll_amount = randomintrange(-5, 6);
    self rotateroll(roll_amount, 1);
    self waittill("rotatedone");
    wait 0.1;
    self rotateroll(roll_amount * -1, 1);
    self waittill("rotatedone");
  }
}

function get_enemy() {
  enemy_target = undefined;

  if(isDefined(self.var_3aec9a4ec140655a)) {
    if(self.var_87babc8a58bc3639 + 2000 < gettime()) {
      self.var_3aec9a4ec140655a = undefined;
    }
  }

  if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader != self) {
    return enemy_target;
  }

  if(isDefined(enemy_target)) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self.var_3aec9a4ec140655a = enemy_target.origin;
      self.var_87babc8a58bc3639 = gettime();
      return enemy_target;
    }
  }

  var_5bf33998853d38ae = function_eac4117ecb82b75e();

  if(var_5bf33998853d38ae.size < 1) {
    return enemy_target;
  }

  if(isDefined(self.origin)) {
    var_5bf33998853d38ae = sortbydistance(var_5bf33998853d38ae, self.origin);
  }

  var_f76842485babee15 = 160000;

  if(function_de436db710384fe2()) {
    var_f76842485babee15 = 1440000;
  }

  foreach(enemy_target in var_5bf33998853d38ae) {
    if(distancesquared(enemy_target.origin, self.origin) > var_f76842485babee15) {
      continue;
    }

    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self.var_3aec9a4ec140655a = enemy_target.origin;
      self.var_87babc8a58bc3639 = gettime();
      function_76b97d7b11066363();
      return enemy_target;
    }
  }

  if(istrue(level.var_7ae7ccff11823a4b)) {
    if(!isDefined(level.var_44a584edfeb159a2)) {
      level.var_44a584edfeb159a2 = [];
      var_d5257e0c17926bd4 = "drones_path_stealth";

      if(isDefined(level.var_43d6260ec0484e29)) {
        var_d5257e0c17926bd4 = level.var_43d6260ec0484e29;
      }

      var_9c6f15fa4f485d2f = getStruct(var_d5257e0c17926bd4, "targetname");
      level.var_44a584edfeb159a2[level.var_44a584edfeb159a2.size] = var_9c6f15fa4f485d2f;

      if(!isDefined(var_9c6f15fa4f485d2f)) {
        return enemy_target;
      }

      while(isDefined(var_9c6f15fa4f485d2f.target)) {
        var_9c6f15fa4f485d2f = getStruct(var_9c6f15fa4f485d2f.target, "targetname");
        level.var_44a584edfeb159a2[level.var_44a584edfeb159a2.size] = var_9c6f15fa4f485d2f;
      }
    }

    if(level.var_44a584edfeb159a2.size == 0) {
      return enemy_target;
    }

    if(!isDefined(self.var_27ed911e8764d33a)) {
      self.var_27ed911e8764d33a = 0;
    }

    target_struct = level.var_44a584edfeb159a2[self.var_27ed911e8764d33a];

    if(distancesquared(self.origin, target_struct.origin) < 90000) {
      self.var_27ed911e8764d33a++;

      if(self.var_27ed911e8764d33a >= level.var_44a584edfeb159a2.size) {
        self.var_27ed911e8764d33a = 0;
      }

      target_struct = level.var_44a584edfeb159a2[self.var_27ed911e8764d33a];
      self.current_node = target_struct;
    }

    if(!isDefined(self.path_data)) {
      self.re_path = 1;
    }

    self.var_3aec9a4ec140655a = target_struct.origin;
    self.var_87babc8a58bc3639 = gettime();
    return target_struct;
  }

  if(isDefined(level.var_8d1cb2f62ce55c8a)) {
    foreach(enemy in var_5bf33998853d38ae) {
      if(enemy == level.var_8d1cb2f62ce55c8a) {
        if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader == self) {
          self.var_3aec9a4ec140655a = enemy.origin;
          self.var_87babc8a58bc3639 = gettime();
          return enemy;
        }
      }
    }
  }

  foreach(enemy_target in var_5bf33998853d38ae) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self.var_3aec9a4ec140655a = enemy_target.origin;
      self.var_87babc8a58bc3639 = gettime();
      return enemy_target;
    }
  }

  for(i = 0; i < var_5bf33998853d38ae.size; i++) {
    enemy_target = var_5bf33998853d38ae[i];

    if(isalive(enemy_target) && !istrue(enemy_target.inlaststand)) {
      return enemy_target;
    }
  }

  return enemy_target;
}

function move_to_new_node(node, path_index, offset, speed_override, update_time) {
  self endon("death");
  self notify("move_to_new_node");
  self endon("move_to_new_node");

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  dist = distance(self.origin, node.origin);

  if(!isDefined(node.angles)) {
    node.angles = (0, 0, 0);
  }

  if(getdvarint(@ "astar_debug", 0)) {
    clr = (1, 0, 1);

    if(self.cur_state == "<dev string:x5e>") {
      clr = (0, 1, 0);
    } else if(self.cur_state == "<dev string:x68>") {
      clr = (1, 0, 0);
    } else if(self.cur_state == "<dev string:x77>") {
      clr = (0, 0, 1);
    }

    level thread drawsphere(node.origin, 5, 1, clr);
  }

  if(dist > 1) {
    self.next_node = node;
    speed = 10;

    if(isDefined(speed_override)) {
      speed = speed_override;
    }

    if(isDefined(level.var_3e81a9fcedd1021d)) {
      if(isDefined(level.var_95fd31d093a7b7aa) && level.var_95fd31d093a7b7aa != self) {
        speed = level.var_3e81a9fcedd1021d;
      } else if(self.var_db46c7d01ee9223f.drones.size > 1) {
        speed = level.var_3e81a9fcedd1021d * 0.8;
      } else {
        speed = level.var_3e81a9fcedd1021d;
      }
    }

    self.move_speed = speed;
    self vehicle_setspeed(speed, speed * 0.2, speed * 0.95);
    lookangle = vectortoangles(node.origin - self.origin);
    self setgoalyaw(lookangle[1]);
    self setyawspeed(400, 300, 270, 0.3);
    thread update_goal_pos(node, offset, update_time);
    waittill_any_timeout_2(15, "near_goal", "stop_tracking");
    self notify("stop_tracking");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
    self vehicle_setspeedimmediate(1, 12, 12);
    return;
  }

  wait 0.1;
}

function update_goal_pos(node, offset, update_time) {
  self endon("death");
  self endon("stop_tracking");
  self notify("update_goal_pos");
  self endon("update_goal_pos");
  pos = undefined;

  if(isvector(node)) {
    pos = node;
  } else if(isDefined(node.origin)) {
    pos = node.origin;
  }

  if(!isDefined(pos)) {
    announcement("<dev string:x7f>");

    return;
  }

  if(istrue(level.var_77d9637a0fc5a67e)) {
    var_af4a7323e71b404 = 0;
    vec = pos - self.origin;
    var_96020f25b789accf = length(vec);

    if(var_96020f25b789accf > 2) {
      ignore = [self, self.clip];
      collisioncontents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
      start = var_96020f25b789accf * 0.25;
      i = start;

      while(i < var_96020f25b789accf) {
        tracepos = self.origin + vectorNormalize(vec) * i;
        var_da461b632fc8e9de = tracepos + (0, 0, 150);
        passed = scripts\engine\trace::sphere_trace_passed(tracepos, var_da461b632fc8e9de, 8, ignore, collisioncontents);

        if(passed) {
          line(tracepos, var_da461b632fc8e9de, (0.1, 0.7, 0.7), 1, 0, 150);

          var_af4a7323e71b404++;
        } else {
          line(tracepos, var_da461b632fc8e9de, (0.7, 0.2, 0.2), 1, 0, 40);
        }

        i *= 1.1;
      }
    }

    if(var_af4a7323e71b404 > 10) {
      announcement("Wallcheck!");
    }
  }

  self setvehgoalpos(pos + offset, 0);

  if(isDefined(level.var_903f92904b8791e0)) {
    self setneargoalnotifydist(level.var_903f92904b8791e0);
  }

  if(isDefined(update_time) && update_time > 0) {
    var_2bc7779d8637c25d = 0;
    thread function_a953e534ff89430a(12);

    while(true) {
      wait update_time;

      if(isDefined(node.origin)) {
        pos = node.origin;
      }

      self setvehgoalpos(pos + offset, 0);

      if(isDefined(self.var_3589a53ab80793c7)) {
        continue;
      }

      if(!drone_turret_canseetarget(node, offset, self)) {
        if(distancesquared(self.origin, pos + offset) > 22500) {
          self notify("stop_tracking");
          continue;
        }

        ignore = [];

        if(level.drone_turrets.size > 0) {
          for(i = 0; i < level.drone_turrets.size; i++) {
            ignore[ignore.size] = level.drone_turrets[i];
            ignore[ignore.size] = level.drone_turrets[i].clip;
          }
        }

        contents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
        checktrace = scripts\engine\trace::ray_trace(self.origin, node.origin, ignore, contents);
        self.var_3589a53ab80793c7 = spawnStruct();
        self.var_3589a53ab80793c7.origin = checktrace["position"];
        node = self.var_3589a53ab80793c7;
      }
    }
  }
}

function function_a953e534ff89430a(timer) {
  self endon("death");
  self endon("stop_tracking");
  thread function_f0794596985dcdb4();
  wait timer;
  self notify("stop_tracking");
}

function function_f0794596985dcdb4() {
  self endon("death");
  self waittill("stop_tracking");
  thread function_721cc43274bb86af("alert");
  self setturningability(self.turningability);
}

function function_9d76b32cac3b3ec() {
  self.move_speed = 0;
  self vehicle_setspeed(0, 12, 12);
}

function function_5e52ae7fc7833e15() {
  self endon("death");

  while(true) {
    self waittill("pause_move");
    self vehicle_setspeedimmediate(0, 15, 15);
    wait 0.5;
    self vehicle_setspeed(self.move_speed, 12, 12);
  }
}

function enemy_sentry_debug() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  org = self.origin;
  interval = 0.05;
  frames = int(interval * 20);

  while(true) {
    print3d(org, "<dev string:x8c>" + self.health + "<dev string:xa3>" + self.maxhealth, (1, 1, 1), 1, 1, frames, 1);

    print3d(org + (0, 0, 10), "<dev string:xa5>" + self.heatlevel, (1, 1, 1), 1, 1, frames, 1);

    wait interval;
  }
}

function function_721cc43274bb86af(state, only_leader) {
  if(!isDefined(self.light_fx_tag)) {
    self.light_fx_tag = "tag_camera_fx";
  }

  self.var_34a833cf8e285177 = self.light_state;
  self.light_state = state;
  function_9fda1f9dca69810c();

  if(self.light_state == "danger") {
    playFXOnTag(level._effect["drone_swarm_light_danger"], self, self.light_fx_tag);
    return;
  }

  if(self.light_state == "alert") {
    playFXOnTag(level._effect["drone_swarm_light_alert"], self, self.light_fx_tag);
  }
}

function function_9fda1f9dca69810c() {
  if(!isDefined(self.var_34a833cf8e285177)) {
    return;
  }

  if(self.var_34a833cf8e285177 == "alert") {
    stopFXOnTag(level._effect["drone_swarm_light_alert"], self, self.light_fx_tag);
    return;
  }

  if(self.var_34a833cf8e285177 == "danger") {
    stopFXOnTag(level._effect["drone_swarm_light_danger"], self, self.light_fx_tag);
  }
}

function function_27b2b1f4f6013d20() {
  self endon("death");

  if(!isDefined(self.var_dddcf6433ffa5aaa) && function_77f1c6a83258ceb9()) {
    self.var_dddcf6433ffa5aaa = 1;
    drop_location = self.origin;
    velocity = (0, 0, -10);

    if(isDefined(self.var_565ae80d9fecf7ca)) {
      drop_location = self.var_565ae80d9fecf7ca.origin;
    }

    magicgrenademanual("smoke_grenade_mp", drop_location, velocity, 0.05);
    thread play_sound_in_space("smoke_grenade_expl_trans", self.origin);
  }
}

function damage_feedback_watch() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(0);
  self.health = 100000;
  self.clip setCanDamage(1);
  self.clip.health = 100000;
  self.clip.fake_health = 50;
  is_axis = self.team == "axis";

  if(!is_axis) {
    self.clip.fake_health = 200;
  }

  self.var_689d46e1e37cc5ad = &function_c5d04118503d4ea7;

  while(true) {
    self.clip waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.clip.fake_health -= idamage;
    self.clip.health = 100000;

    if(!isDefined(eattacker) || is_axis && !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }

    if(isDefined(self.mgturret)) {
      self notify("pause_move");
    } else if(isDefined(self.drone_base)) {
      self.drone_base notify("pause_move");
    }

    if(isDefined(objweapon.basename)) {
      if(issubstr(objweapon.basename, "emp_drone")) {}
    }

    function_76b97d7b11066363();
    thread function_25586d738b30af98(eattacker);

    if(scripts\cp\agent_damage::should_get_currency_from_kill(einflictor, eattacker, objweapon)) {
      if(idamage < self.clip.fake_health) {
        eattacker scripts\cp\persistence::give_player_currency(10, "large");
      } else {
        eattacker scripts\cp\persistence::give_player_currency(100, "large");
      }
    }

    if(self.clip.fake_health <= 0) {
      self.health = 1;
    }

    scripts\cp\damagefeedback::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, spartname, undefined, self);
  }
}

function function_c5d04118503d4ea7(idamage) {
  if(self.clip.fake_health <= 0) {
    return true;
  }

  return false;
}

function function_76b97d7b11066363() {
  if(istrue(level.var_7ae7ccff11823a4b)) {
    level.var_7ae7ccff11823a4b = 0;
  }
}

function function_25586d738b30af98(eattacker) {
  self notify("new_damage");
  self endon("new_damage");
  self.last_damaged_by = eattacker;
  self.last_damaged_time = gettime();
  wait 5;
  self.last_damaged_by = undefined;
  self.last_damaged_time = undefined;
}

function watch_for_death() {
  self endon("death");

  while(true) {
    if(self.clip.fake_health <= 0 || self.health <= 0) {
      if(istrue(level.var_f753d22ae87b557b) || istrue(self.var_8d8144287647fbc5)) {
        thread bomb_explode();
      } else {
        thread kill_drone();
      }
    }

    wait 0.1;
  }
}

function function_94d8111112ffc480() {
  self endon("death");
  self endon("stop_dive_bomb");
  dist = 100;
  dist_sq = dist * dist;

  while(true) {
    enemy_list = function_eac4117ecb82b75e();

    for(i = 0; i < enemy_list.size; i++) {
      if(isPlayer(enemy_list[i]) && enemy_list[i] isswimunderwater() && !function_3ff5fa5cffdd0aa8(enemy_list[i])) {
        continue;
      }

      if(isDefined(level.var_3b24acb8a1c0031d)) {
        if(gettime() < level.var_3b24acb8a1c0031d + 250) {
          continue;
        }
      }

      if(distancesquared(enemy_list[i].origin, self.origin) < dist_sq) {
        thread bomb_explode();
      }
    }

    wait 0.1;
  }
}

function bomb_explode() {
  level.var_3b24acb8a1c0031d = gettime();
  self.exploding = 1;
  self.var_cefcafdecc575902 = 1;
  player_range = 170;
  drone_range = 400;
  var_3c27a8da881baab2 = drone_range * drone_range;
  armorhealth = level.players[0].maxarmorhealth;
  min_dam = int(armorhealth * 0.05);
  med_dam = int(armorhealth * 0.125);
  max_dam = int(armorhealth * 0.3);

  if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    min_dam = int(armorhealth * 0.2);
    med_dam = int(armorhealth * 0.4);
    max_dam = int(armorhealth * 0.65);
  }

  weapon_name = "assault_drone_mp";
  type = "MOD_EXPLOSIVE";
  thread function_5eafe20e3889d3a9(var_3c27a8da881baab2);
  self radiusdamage(self.origin, player_range, max_dam, min_dam, self, type);
  level thread function_28cb88cb0ccbffed(self.origin, player_range);
  level thread function_f33c56cd33b96d7a(self.origin, player_range * 0.2, min_dam);
  var_e7a08f629e00c5b7 = self.origin;
  thread kill_drone();

  if(istrue(level.var_f753d22ae87b557b)) {
    var_3e3af5dc3694a80c = level.drone_turrets;
    var_3e3af5dc3694a80c = sortbydistance(var_3e3af5dc3694a80c, var_e7a08f629e00c5b7);

    foreach(other_drone in var_3e3af5dc3694a80c) {
      if(!isent(other_drone)) {
        continue;
      }

      if(other_drone == self) {
        continue;
      }

      if(istrue(other_drone.exploding)) {
        continue;
      }

      if(distancesquared(var_e7a08f629e00c5b7, other_drone.origin) > var_3c27a8da881baab2) {
        continue;
      }

      other_drone thread bomb_explode();
      wait 0.2;
    }
  }

  level notify("bomb_drone_explode", var_e7a08f629e00c5b7, player_range, min_dam, max_dam);
}

function function_5eafe20e3889d3a9(var_3c27a8da881baab2) {
  c4 = spawn("script_model", self.origin);
  c4 setModel("tag_origin_drone_explosion_cp");
  c4 setscriptablepartstate("effects", "explodeAir");
  wait 1;
  c4 delete();
}

function function_f33c56cd33b96d7a(origin, radius, damage) {
  players = [];

  if(isDefined(origin) && isDefined(radius)) {
    players = getplayersinradius(origin, radius, "allies");
  }

  foreach(player in players) {
    if(isDefined(player) && isPlayer(player) && isDefined(damage) && isDefined(origin)) {
      player dodamage(damage, origin);
    }
  }
}

function function_28cb88cb0ccbffed(origin, radius) {
  level endon("game_ended");
  radius += 500;
  players = give_all_players_nearby(origin, radius * radius);
  wait 3;

  foreach(player in players) {
    if(!isPlayer(player)) {
      continue;
    }

    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(scripts\cp\laststand::isinlaststand(player)) {
      continue;
    }

    player notify("force_regeneration");
  }
}

function kill_drone() {
  if(istrue(self.drone_dying)) {
    return;
  }

  self.drone_dying = 1;
  explode_fx();

  if(isDefined(self.clip.fake_health) && self.clip.fake_health > 0) {
    self.clip dodamage(9999, self.origin, self);
  }

  level.drone_turrets = array_remove(level.drone_turrets, self);
  level.vehicle_ai_script_models = array_remove(level.vehicle_ai_script_models, self);
  self.var_db46c7d01ee9223f.drones = array_remove(self.var_db46c7d01ee9223f.drones, self);
  self freeentitysentient();
  refs = [self.clip, self];
  level thread function_34a36f44dd3b1ea9(refs);

  if(isDefined(self.clip)) {
    if(issentient(self.clip)) {
      self.clip freeentitysentient();
    }

    self.clip notify("death");
    self.clip delete();
  }

  if(isDefined(self.node_grid)) {
    self.node_grid = undefined;
  }

  var_34a9757868bb0162 = self;

  if(isDefined(var_34a9757868bb0162) && isent(var_34a9757868bb0162)) {
    if(isDefined(var_34a9757868bb0162)) {
      var_34a9757868bb0162 delete();
    }
  }

  waitframe();

  if(isDefined(var_34a9757868bb0162) && isent(var_34a9757868bb0162)) {
    var_34a9757868bb0162 notify("death");
    var_34a9757868bb0162 delete();
  }
}

function explode_fx() {
  playFX(getfx("drone_turret_explode"), self.origin);
  self playSound("cp_bomb_drone_death");
}

function function_eac4117ecb82b75e() {
  enemy_list = get_array_of_valid_players();

  if(self.team == "allies") {
    enemy_list = getaiarray("axis");
  }

  if(isDefined(self.var_3589a53ab80793c7)) {
    enemy_list[enemy_list.size] = self.var_3589a53ab80793c7;
  }

  return enemy_list;
}

function function_1ef2364d60a8af83(struct, radius_override) {
  level endon("game_ended");
  radius = 800;

  if(isDefined(radius_override)) {
    radius = radius_override;
  }

  radius_sq = radius * radius;

  if(!isDefined(struct)) {
    return;
  }

  while(true) {
    nearby_player = struct get_closest_living_player(radius_sq);

    if(isDefined(nearby_player)) {
      level.var_8d1cb2f62ce55c8a = nearby_player;
      wait randomfloatrange(3, 6);
    } else {
      level.var_8d1cb2f62ce55c8a = undefined;
    }

    wait 0.5;
  }
}

function function_9766cdb112671d7(targetname) {
  level.var_a7b6c38e3eb32646 = [];
  structs = getStructArray(targetname, "targetname");

  foreach(struct in structs) {
    height = ter_op(isDefined(struct.height), struct.height, "500");
    trigger = spawn("trigger_radius", struct.origin, 0, int(struct.radius), int(height));

    if(isDefined(struct.angles) && struct.angles != (0, 0, 0)) {
      trigger.angles = (-90, 0, 0) + struct.angles;
    }

    if(!isDefined(trigger.height)) {
      trigger.height = int(height);
    }

    if(!isDefined(trigger.radius)) {
      trigger.radius = int(struct.radius);
    }

    trigger thread function_d1965300901b62b7();
    level.var_a7b6c38e3eb32646 = array_add(level.var_a7b6c38e3eb32646, trigger);
  }
}

function function_d1965300901b62b7() {
  self endon("death");
  radius = squared(self.radius);

  while(true) {
    wait 1;

    if(!isDefined(level.drone_turrets)) {
      continue;
    }

    for(i = 0; i < level.drone_turrets.size; i++) {
      drone = level.drone_turrets[i];

      if(!isDefined(drone) || !isent(drone)) {
        continue;
      }

      if(!isDefined(drone.swarm_id)) {
        continue;
      }

      if(isDefined(drone.clip) && drone.clip.fake_health <= 0) {
        continue;
      }

      if(distance2dsquared(drone.origin, self.origin) < radius) {
        drone thread kill_drone();
      }
    }
  }
}

function function_18871f933340b91b(var_8d20a2cd0457e5b1) {
  if(!isDefined(level.drone_turrets)) {
    return;
  }

  var_f00f10160eacb571 = level.drone_turrets;

  for(i = 0; i < var_f00f10160eacb571.size; i++) {
    drone = var_f00f10160eacb571[i];

    if(!isDefined(drone) || !isent(drone)) {
      continue;
    }

    if(!isDefined(drone.swarm_id)) {
      continue;
    }

    if(isDefined(drone.clip) && drone.clip.fake_health <= 0) {
      continue;
    }

    if(isDefined(var_8d20a2cd0457e5b1)) {
      var_5c266234f3e3ad4e = 0;

      foreach(player in level.players) {
        if(distance(drone.origin, player.origin) < var_8d20a2cd0457e5b1) {
          var_5c266234f3e3ad4e = 1;
        }
      }

      if(var_5c266234f3e3ad4e) {
        continue;
      }
    }

    drone thread kill_drone();
  }
}

function function_53747f8ce3d99087() {
  self endon("death");
  var_a395b21f16f97ccf = 0;

  while(true) {
    if(isDefined(self.var_8534d2048fa254a3) && self.origin == self.var_8534d2048fa254a3) {
      var_a395b21f16f97ccf += 1;
    }

    self.var_8534d2048fa254a3 = self.origin;

    if(var_a395b21f16f97ccf == 2) {
      if(!isDefined(level.var_452ebc20a68aa0f0)) {
        level.var_452ebc20a68aa0f0 = 0;
      }

      level.var_452ebc20a68aa0f0++;

      if(isDefined(self.current_node)) {
        if(isDefined(self.current_node.target)) {
          target_struct = getStruct(self.current_node.target, "targetname");

          if(isDefined(target_struct) && isDefined(target_struct.open) && target_struct.open == 0) {
            target_struct.open = 1;
          }
        }
      }

      self.re_path = 1;
    }

    if(var_a395b21f16f97ccf > 6) {
      if(!isDefined(level.var_7e0160e361500662)) {
        level.var_7e0160e361500662 = 0;
      }

      level.var_7e0160e361500662++;

      thread kill_drone();
    }

    wait 2.5;
  }
}

function function_d222480796864019() {
  self endon("death");

  while(istrue(level.var_7ae7ccff11823a4b)) {
    wait 1;
  }

  var_a395b21f16f97ccf = 0;

  while(true) {
    if(isDefined(self.var_a0790d172d45f316) && isDefined(self.current_node) && isDefined(self.current_node.origin) && self.current_node.origin == self.var_a0790d172d45f316) {
      var_a395b21f16f97ccf += 1;
    }

    if(isDefined(self.current_node) && isDefined(self.current_node.origin)) {
      self.var_a0790d172d45f316 = self.current_node.origin;
    }

    if(!isDefined(self.current_node)) {
      if(isDefined(self.node_grid)) {
        closest_node = getclosest(self.origin, self.node_grid);
        self.current_node = closest_node;
      }
    }

    if(var_a395b21f16f97ccf > 12) {
      if(!isDefined(level.var_2bb6dd8f3f3f19a)) {
        level.var_2bb6dd8f3f3f19a = 0;
      }

      level.var_2bb6dd8f3f3f19a++;

      thread kill_drone();
    }

    wait 2.5;
  }
}

function function_8ebde019036d5c6d() {
  while(true) {
    wait 1;

    if(isDefined(level.drone_turrets) && level.drone_turrets.size > 0) {
      var_119c222ba451841 = 0;

      if(isDefined(level.var_ef94125f71754b2f)) {
        foreach(group in level.var_ef94125f71754b2f) {
          if(group.drones.size == 0) {
            var_119c222ba451841++;
          }
        }

        if(var_119c222ba451841 == level.var_ef94125f71754b2f.size) {
          foreach(drone in level.drone_turrets) {
            drone.clip dodamage(9999, drone.origin, level);
          }

          announcement("<dev string:xad>");

          wait 10;
        }
      }
    }
  }
}