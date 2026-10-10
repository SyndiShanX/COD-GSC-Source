/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_21787630bbee2a4.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\astar;
#using scripts\cp\damagefeedback;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_eff40ded0b5d29fd;

function init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level.drone_turrets = [];
}

function function_cb2c1df00bd5e191(spawnpoint, var_f716273270785091) {
  return function_87dd7cfa8068c008(spawnpoint, "axis", var_f716273270785091);
}

function function_bca2ae187983e50a(spawnpoint) {
  function_87dd7cfa8068c008(spawnpoint, "allies");
}

function function_87dd7cfa8068c008(spawnpoint, drone_team, var_f716273270785091) {
  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  dronemodel = "veh8_mil_air_tuniform_c4_ai";
  drone = spawnVehicle(dronemodel, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = drone_team;
  drone.spawnpoint = spawnpoint;
  drone makeentitysentient(drone_team);
  drone thread damage_feedback_watch();
  drone thread function_5e52ae7fc7833e15();
  drone thread patrol_think(spawnpoint, var_f716273270785091);
  drone thread watch_for_death();
  drone thread function_94d8111112ffc480();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone enableaimassist();

  if(!isDefined(level.vehicle_ai_script_models)) {
    level.vehicle_ai_script_models = [];
  }

  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = drone;
  level.drone_turrets[level.drone_turrets.size] = drone;
  return drone;
}

function patrol_think(spawnpoint, var_f716273270785091) {
  self endon("death");
  node = spawnpoint;

  if(isDefined(spawnpoint.script_parameters)) {
    self waittill(spawnpoint.script_parameters);
  }

  grid_size = 500;
  dist = 100;

  if(isDefined(level.var_42f0b59a6cec2e6a)) {
    grid_size = level.var_42f0b59a6cec2e6a;
  }

  var_18f689e5445d1645 = dist * dist;

  if(isDefined(var_f716273270785091) && isstring(var_f716273270785091)) {
    self.node_grid = getStructArray(var_f716273270785091, "script_noteworthy");
  } else {
    self.node_grid = getStructArray("drone_grid", "script_noteworthy");
  }

  end_pos = self.origin;
  node_index = 0;
  self.cur_state = "spawn";
  attack_dist = 500;

  if(isDefined(level.var_b3f7b3933168c3ef)) {
    attack_dist = level.var_b3f7b3933168c3ef;
  }

  var_950028441ba5facb = attack_dist * attack_dist;
  thread play_loop_sound_on_entity("recondrone_eng_high");

  while(true) {
    enemy_target = get_enemy();

    if(!isDefined(enemy_target)) {
      if(!isDefined(self.var_3aec9a4ec140655a)) {
        end_pos = self.origin + (randomintrange(-1000, 1000), randomintrange(-1000, 1000), 0);
      } else {
        end_pos = self.var_3aec9a4ec140655a;
      }

      if(self.cur_state != "no_target") {
        if(getdvarint(@ "astar_debug", 0)) {
          level thread drawsphere(end_pos, 5, 10, (1, 1, 1));
        }

        start_pos = self.origin;
        exclude = self;
        dyn_node = spawnStruct();
        dyn_node.origin = self.origin;
        self.path_data = scripts\cp\astar::astar_get_path(self.node_grid, start_pos, end_pos, exclude, dyn_node, grid_size);

        if(!isDefined(self.path_data)) {
          wait 0.5;
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
    } else if(!istrue(self.re_path) && distancesquared(self.origin, enemy_target.origin) < var_950028441ba5facb) {
      target_list = function_eac4117ecb82b75e();
      target_list = sortbydistancecullbyradius(target_list, enemy_target.origin, 200);
      attack_sequence(enemy_target, target_list);
      self notify("stop_beep");
      self.re_path = 1;
    } else if(istrue(self.re_path)) {
      node_grid = self.node_grid;
      self.re_path = undefined;

      foreach(drone in level.drone_turrets) {
        if(drone == self) {
          continue;
        }

        if(isDefined(drone.current_node)) {
          node_grid = array_remove(node_grid, drone.current_node);
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
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0))) {
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
      self.path_data = scripts\cp\astar::astar_get_path(node_grid, start_pos, var_e14ac44f6f147496, exclude, dyn_node, grid_size);

      if(!isDefined(self.path_data)) {
        wait 0.5;
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

      if(self.cur_state != "re_path") {
        node_index = 0;
        self.cur_state = "re_path";
      }
    } else if(distancesquared(enemy_target.origin, end_pos) > var_18f689e5445d1645) {
      node_grid = self.node_grid;
      start_pos = self.origin;
      end_pos = enemy_target.origin;
      var_e14ac44f6f147496 = enemy_target.origin;
      node_array = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(node_array.size > 0) {
        var_e8e4ed22f3d730b4 = [];

        foreach(node in node_array) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0))) {
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
      self.path_data = scripts\cp\astar::astar_get_path(node_grid, start_pos, var_e14ac44f6f147496, exclude, dyn_node, grid_size);

      if(!isDefined(self.path_data)) {
        wait 0.5;
        continue;
      }

      if(getdvarint(@ "astar_debug", 0)) {
        for(i = 0; i < self.path_data.path.size; i++) {
          if(isDefined(self.path_data.path[i]) && isDefined(self.path_data.path[i + 1])) {
            line(self.path_data.path[i].origin, self.path_data.path[i + 1].origin, (0, 1, 0), 1, 0, 20);
          }
        }

        clr = (0, 1, 1);
        level thread drawsphere(var_e14ac44f6f147496, 5, 20, clr);
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
      wait 0.5;
      function_9d76b32cac3b3ec();
      continue;
    }

    if(!isDefined(self.path_data.path[node_index])) {
      if(node_index >= self.path_data.path.size) {
        self.cur_state = "path_done";
        function_9d76b32cac3b3ec();
      }

      wait 0.5;
      continue;
    }

    if(istrue(self.re_path)) {
      wait 0.5;
      continue;
    }

    next_node = self.path_data.path[node_index];
    delay_movement = 0;

    foreach(drone in level.drone_turrets) {
      if(drone == self) {
        continue;
      }

      if(isDefined(drone.current_node) && next_node == drone.current_node) {
        delay_movement = 1;
      }

      if(isDefined(drone.next_node) && next_node == drone.next_node) {
        delay_movement = 1;
      }
    }

    if(delay_movement) {
      self.re_path = 1;
      wait 0.5;
      continue;
    }

    if(isDefined(enemy_target) && isPlayer(enemy_target) && isalive(enemy_target)) {
      if(soundexists("breach_warning_beep_03")) {
        enemy_target playlocalsound("breach_warning_beep_03");
      }
    }

    move_to_new_node(next_node, node_index);
    node_index++;
    wait 0.1;
  }
}

function attack_sequence(enemy_target, target_list) {
  foreach(guy in target_list) {
    thread function_eb8bbc754779b523(guy);
  }

  move_to_new_node(enemy_target, 0, (0, 0, 50), 20, 0.25);
}

function function_eb8bbc754779b523(guy) {
  self endon("death");
  self endon("stop_beep");

  if(soundexists("breach_warning_beep_03")) {
    guy playlocalsound("breach_warning_beep_03");
  }

  wait 0.5;

  if(soundexists("breach_warning_beep_04")) {
    guy playlocalsound("breach_warning_beep_04");
  }

  wait 0.25;

  if(soundexists("breach_warning_beep_05")) {
    guy playlocalsound("breach_warning_beep_05");
  }

  while(true) {
    wait 0.1;

    if(soundexists("breach_warning_beep_05")) {
      guy playlocalsound("breach_warning_beep_05");
    }
  }
}

function drone_turret_canseetarget(target, offset) {
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  icansee = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  tracepoints = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];
  ignore = undefined;

  if(isent(self)) {
    ignore = self;
  }

  for(i = 0; i < tracepoints.size; i++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin + offset, tracepoints[i], ignore, contents)) {
      continue;
    }

    icansee = 1;
    break;
  }

  return icansee;
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

  if(isDefined(self.last_damaged_by)) {
    if(isDefined(self.last_damaged_time)) {
      if(gettime() - self.last_damaged_time < 5000) {
        enemy_target = self.last_damaged_by;
      }
    }
  }

  if(isDefined(self.targeted_enemy)) {
    if(isPlayer(self.targeted_enemy)) {
      enemy_target = self.targeted_enemy;
    }
  }

  if(isDefined(enemy_target)) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset)) {
      self.var_3aec9a4ec140655a = enemy_target.origin;
      self.var_87babc8a58bc3639 = gettime();
      return enemy_target;
    }
  }

  if(isDefined(self.var_3aec9a4ec140655a)) {
    if(self.var_87babc8a58bc3639 + 5000 < gettime()) {
      self.var_3aec9a4ec140655a = undefined;
    }
  }

  var_5bf33998853d38ae = function_eac4117ecb82b75e();

  if(var_5bf33998853d38ae.size < 1) {
    return enemy_target;
  }

  var_5bf33998853d38ae = sortbydistance(var_5bf33998853d38ae, self.origin);

  foreach(enemy_target in var_5bf33998853d38ae) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset)) {
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

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  dist = distance(self.origin, node.origin);

  if(!isDefined(node.angles)) {
    node.angles = (0, 0, 0);
  }

  if(getdvarint(@ "astar_debug", 0)) {
    clr = (1, 0, 1);

    if(self.cur_state == "<dev string:x1c>") {
      clr = (0, 1, 0);
    } else if(self.cur_state == "<dev string:x26>") {
      clr = (1, 0, 0);
    } else if(self.cur_state == "<dev string:x35>") {
      clr = (0, 0, 1);
    }

    level thread drawsphere(node.origin, 5, 10, clr);
  }

  if(dist > 1) {
    self.next_node = node;
    speed = 10;

    if(isDefined(speed_override)) {
      speed = speed_override;
    }

    if(path_index + 1 >= self.path_data.path.size) {
      speed = 5;
    }

    self.move_speed = speed;
    self vehicle_setspeed(speed, 10, 10);
    thread update_goal_pos(node, offset, update_time);
    waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
    self notify("stop_tracking");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
    return;
  }

  wait 0.1;
}

function update_goal_pos(node, offset, update_time) {
  self endon("death");
  self endon("stop_tracking");
  self setvehgoalpos(node.origin + offset, 0);

  if(istrue(update_time)) {
    thread function_a953e534ff89430a(3);

    while(true) {
      wait update_time;
      self setvehgoalpos(node.origin + offset, 0);
    }
  }
}

function function_a953e534ff89430a(timer) {
  self endon("death");
  self endon("stop_tracking");
  wait timer;
  self notify("stop_tracking");
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
    print3d(org, "<dev string:x3d>" + self.health + "<dev string:x54>" + self.maxhealth, (1, 1, 1), 1, 1, frames, 1);

    print3d(org + (0, 0, 10), "<dev string:x56>" + self.heatlevel, (1, 1, 1), 1, 1, frames, 1);

    wait interval;
  }
}

function damage_feedback_watch() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(1);
  self.health = 100000;
  self.fake_health = 40;
  is_axis = self.team == "axis";

  if(!is_axis) {
    self.fake_health = 200;
  }

  while(true) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);

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

    thread function_25586d738b30af98(eattacker);

    if(scripts\cp\agent_damage::should_get_currency_from_kill(einflictor, eattacker, objweapon)) {
      if(idamage < self.fake_health) {
        eattacker scripts\cp\persistence::give_player_currency(10, "large");
      } else {
        eattacker scripts\cp\persistence::give_player_currency(100, "large");
      }
    }

    self.fake_health -= idamage;
    self.health = 100000;
    scripts\cp\damagefeedback::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, spartname, undefined, self);
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
    if(self.fake_health <= 0) {
      thread kill_drone();
    }

    wait 0.1;
  }
}

function function_94d8111112ffc480() {
  self endon("death");
  dist = 100;
  dist_sq = dist * dist;

  while(true) {
    enemy_list = function_eac4117ecb82b75e();

    foreach(guy in enemy_list) {
      if(distancesquared(guy.origin, self.origin) < dist_sq) {
        thread bomb_explode();
      }
    }

    wait 0.1;
  }
}

function bomb_explode() {
  self setscriptablepartstate("explode", "on", 0);
  range = 200;
  min_dam = 10000;
  max_dam = 10000;
  weapon_name = "assault_drone_mp";
  thread function_5eafe20e3889d3a9();

  if(isDefined(self.owner)) {
    self radiusdamage(self.origin, range, min_dam, max_dam, self.owner, "MOD_EXPLOSIVE", weapon_name);
  } else {
    self radiusdamage(self.origin, range, min_dam, max_dam, undefined, "MOD_EXPLOSIVE", weapon_name);
  }

  thread kill_drone();
}

function function_5eafe20e3889d3a9() {
  c4 = spawn("script_model", self.origin);
  c4 setModel("offhand_wm_c4_bomb");
  c4 setscriptablepartstate("effects", "explodeAir");
  wait 1;
  c4 delete();
}

function kill_drone() {
  explode_fx();
  level.drone_turrets = array_remove(level.drone_turrets, self);
  level.vehicle_ai_script_models = array_remove(level.vehicle_ai_script_models, self);
  waitframe();
  self notify("death");

  if(isDefined(self)) {
    self delete();
  }
}

function explode_fx() {
  playFX(getfx("drone_turret_explode"), self.origin);
  self playSound("cp_bomb_drone_death");
}

function function_eac4117ecb82b75e() {
  player_list = get_array_of_valid_players();

  if(self.team == "allies") {
    player_list = getaiarray("axis");
  }

  return player_list;
}