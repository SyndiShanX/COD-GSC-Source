/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\vehicles.gsc
***********************************************/

#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_wave_spawning;
#using scripts\cp\damage;
#using scripts\cp\damagefeedback;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\persistence;
#using scripts\cp\points;
#using scripts\cp\spawner_scoring;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\cp\vehicles\vehicle_cp;
#using scripts\cp\vo;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_anim;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace vehicles;

function vehicles_init() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 1) {
    return;
  }

  if(getDvar(@ "hash_742caa13b3c2e685") == "1") {
    return;
  }

  level endon("game_ended");
  level thread scripts\cp_mp\vehicles\vehicle::vehicle_init();

  if(isDefined(level.vehicles_init)) {
    [[level.vehicles_init]]();
  }

  if(!isDefined(level.unloading_func)) {
    level.unloading_func = [];
  }

  if(!isDefined(level.unloaded_func)) {
    level.unloaded_func = [];
  }

  if(!isDefined(level.vehicle_builds)) {
    level.vehicle_builds = [];
  }

  setDvar(@ "hash_b77d72f69452a294", 1);
  level thread init_vehicle_spawning();
  scripts\cp_mp\vehicles\vehicle_anim::init_vehicles();
  create_func_ref("vehicle_damage_modifier", &cp_vehicle_damage_monitor);
  create_func_ref("anim_placeweaponon", &scripts\anim\shared::placeweaponon);
  level._effect["helidown_rpghit"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx");
  level._effect["helidown_tailfire"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_fire_fire_trail.vfx");
  level._effect["helidown_groundexp"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_chopper_ground_exp.vfx");

  flag_wait("<dev string:x1c>");
  cmd = "<dev string:x35>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x89>";
  addentrytodevgui(cmd);
  cmd = "<dev string:xf4>";
  addentrytodevgui(cmd);
  create_func_ref("<dev string:x15b>", &setup_player_vehicles);
  level thread debug_activation(@ "hash_67d581853aa8906d", &cp_vehicle_debug);
}

function unset_bullet_shields() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.bullet_shield)) {
        keys = getarraykeys(level.vehicle.templates.bullet_shield);

        for(i = 0; i < keys.size; i++) {
          level.vehicle.templates.bullet_shield[keys[i]] = 0;
        }
      }
    }
  }
}

function create_passengers_unload_groups() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.unloadgroups)) {
        keys = getarraykeys(level.vehicle.templates.unloadgroups);

        for(i = 0; i < keys.size; i++) {
          key = keys[i];
          passenger_size = level.vehicle.templates.aianims[keys[i]].size;

          if(!isDefined(level.vehicle.templates.unloadgroups[key])) {
            level.vehicle.templates.unloadgroups[key] = [];
          }

          if(isDefined(level.vehicle.templates.unloadgroups[key]["passengers"])) {
            continue;
          }

          if(passenger_size > 1) {
            for(j = 1; j < passenger_size; j++) {
              if(isDefined(level.vehicle.templates.aianims[key][j])) {
                seat = level.vehicle.templates.aianims[key][j];

                if(isDefined(seat.getout)) {
                  if(!isDefined(level.vehicle.templates.unloadgroups[key]["passengers"])) {
                    level.vehicle.templates.unloadgroups[key]["passengers"] = [];
                  }

                  level.vehicle.templates.unloadgroups[key]["passengers"][level.vehicle.templates.unloadgroups[key]["passengers"].size] = j;
                }
              }
            }
          }
        }
      }
    }
  }
}

function set_vehicle_templates_script_team() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.team)) {
        keys = getarraykeys(level.vehicle.templates.team);

        for(i = 0; i < keys.size; i++) {
          level.vehicle.templates.team[keys[i]] = "axis";
        }
      }
    }
  }
}

function vehiclefollowstructpathsplines(path_start, pathing_array, var_6f3f0d19b9577e15) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");

  if(pathing_array.size == 0) {
    assertmsg("Pathing_array.size == 0");
    return;
  }

  if(!isDefined(path_start)) {
    assertmsg("path_start is undefined");
    return;
  }

  while(pathing_array.size < 4) {
    var_f17000b1738727b3 = create_extra_structpath(1, pathing_array[pathing_array.size - 1].origin, pathing_array[pathing_array.size - 2].origin);
    pathing_array[pathing_array.size] = var_f17000b1738727b3;
  }

  var_865de0e45fd72eda = [];
  durations = [];
  amount = pathing_array.size;
  currentpoint = undefined;
  last_point = self.origin;
  vel = 15;

  for(i = 0; i < amount; i++) {
    if(isDefined(pathing_array[i + 1])) {
      currentpoint = pathing_array[i + 1].origin;
    }

    if(i == 0) {
      var_865de0e45fd72eda[var_865de0e45fd72eda.size] = self.origin;
    } else {
      var_865de0e45fd72eda[var_865de0e45fd72eda.size] = pathing_array[i].origin;
    }

    path_speed = 300;

    if((!isDefined(self.convoy) || istrue(self.convoy.settings.use_path_speeds)) && isDefined(pathing_array[i].speed)) {
      path_speed = 300 * pathing_array[i].speed / 15;
    }

    var_d530f6290fec0a8c = get_duration_between_points(last_point, currentpoint, ter_op(isDefined(self.cp_speed), self.cp_speed, path_speed));
    durations[durations.size] = var_d530f6290fec0a8c;
    last_point = currentpoint;
  }

  if(vehicle_on_last_pathing_array(self)) {
    self startpathnodes(var_865de0e45fd72eda, durations);
  } else {
    self startpathnodes(var_865de0e45fd72eda, durations, 0, 0.5, 0.5, 0, 0, 0);
  }

  thread vehicle_process_node_when_at_goal(var_6f3f0d19b9577e15);
  self notify("startpathnodes");

  for(i = 0; i < durations.size; i++) {
    while(function_cb612f9367051ea2(i > 0 && durations[i] > 1)) {
      wait 0.25;
    }

    wait durations[i];
  }

  if(vehicle_on_last_pathing_array(self)) {
    self.on_last_pathing_array = undefined;

    if(isDefined(self.convoy) && !istrue(self.convoy.settings.roaming) || !isDefined(self.convoy)) {
      thread finish_spline_path();
    }
  }

  if(istrue(self.looping_path)) {
    vehiclefollowstructpathsplines(self.pathing_array[0], self.pathing_array, 1);
  }
}

function vehicle_process_node_when_at_goal(var_6f3f0d19b9577e15) {
  level endon("game_ended");
  self endon("death");
  self notify("vehicle_process_node_when_at_goal");
  self endon("vehicle_process_node_when_at_goal");
  dist_sq = 62500;
  node_index = 1;
  nextpoint = self.pathing_array[node_index];
  lastpoint = self.pathing_array[node_index];
  level.vehicle_tracker = self;

  if(istrue(var_6f3f0d19b9577e15)) {
    thread process_nextpoint_after_struct_wait(nextpoint, dist_sq);
  }

  while(true) {
    self waittill("trigger", completed_ratio, param1, param2, param3);

    if(isint(completed_ratio)) {
      if(node_index < completed_ratio + 1) {
        if(isDefined(self.path_gobbler)) {
          deletestruct_ref(nextpoint);
        }

        node_index = completed_ratio + 1;
        nextpoint = get_next_node_on_spline(node_index);

        if(isDefined(nextpoint)) {
          lastpoint = nextpoint;
          self notify("new_next_point");

          if(istrue(var_6f3f0d19b9577e15)) {
            thread process_nextpoint_after_struct_wait(nextpoint, dist_sq);
          }

          continue;
        }

        break;
      }
    }
  }
}

function process_nextpoint_after_struct_wait(nextpoint, dist_sq) {
  self notify("process_nextPoint_after_struct_wait");
  self endon("process_nextPoint_after_struct_wait");
  self endon("death");

  while(distancesquared(self.origin, nextpoint.origin) > dist_sq) {
    wait 0.1;
  }

  process_vehicle_struct_node(nextpoint);
}

function process_vehicle_struct_node(nextpoint) {
  self endon("newpath");
  self endon("death");
  get_func = get_path_getfunc(nextpoint);
  lastpoint = undefined;
  self.currentnode = nextpoint;
  trigger_process_node(nextpoint);

  if(vehicle_should_unload(&node_wait, nextpoint)) {
    self vehicle_setspeedimmediate(0, 1, 1);
    struct_path_unload_node(nextpoint);
    wait 0.25;

    if(isDefined(level.vehicle.var_9442d439c225c3fe)) {
      if([[level.vehicle.var_9442d439c225c3fe]](self)) {
        return;
      }
    }

    if(!isDefined(self.riders) || self.riders.size < 1) {
      self notify("vehicle_process_node_when_at_goal");
      self notify("stop_follow_path");
      return;
    }

    self resumespeed(20);
  }
}

function struct_path_unload_node(node) {
  self endon("death");

  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["prep_unload"]) && ent_flag("prep_unload")) {
    return;
  }

  if(!isDefined(node.script_flag_wait) && !isDefined(node.script_delay)) {}

  assert(isDefined(self));
  pathnode = getnode(node.targetname, "target");

  if(isDefined(pathnode) && self.riders.size) {
    foreach(rider in self.riders) {
      if(isai(rider)) {
        rider thread script_func("go_to_node", pathnode);
      }
    }
  } else if(self.riders.size) {
    foreach(rider in self.riders) {
      if(!isDefined(rider.spawnpoint)) {
        continue;
      }

      if(isDefined(rider.spawnpoint.target) || isDefined(rider.spawnpoint.script_linkto)) {
        rider thread scripts\cp\spawning::go_to_node(rider.spawnpoint scripts\cp\spawning::get_next_node_array());
      }
    }
  }

  if(scripts\common\vehicle::ishelicopter()) {
    self sethoverparams(0, 0, 0);
    waittill_stable(node);
  }

  if(isDefined(node.script_noteworthy)) {
    if(node.script_noteworthy == "wait_for_flag") {
      flag_wait(node.script_flag);
    }
  }

  if(isDefined(node.script_unload)) {
    if(node.script_unload == "1") {
      node.script_unload = "default";
    }
  }

  _vehicle_unload(node.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(node.script_unload)) {
    self waittill("unloaded");
  }

  if(isDefined(node.script_flag_wait) || isDefined(node.script_delay)) {
    return;
  }
}

function get_next_node_on_spline(node_index) {
  if(!isDefined(node_index)) {
    return undefined;
  }

  if(!isDefined(self.pathing_array)) {
    return undefined;
  }

  if(isDefined(self.pathing_array[node_index])) {
    return self.pathing_array[node_index];
  }

  return undefined;
}

function function_cb612f9367051ea2(started_path) {
  return self issuspendedvehicle() || started_path && self vehicle_getspeed() < 1;
}

function vehicle_on_last_pathing_array(vehicle) {
  if(istrue(vehicle.looping_path)) {
    return false;
  }

  if(isDefined(vehicle.pathing_arrays)) {
    if(istrue(vehicle.on_last_pathing_array)) {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function create_extra_structpath(after_toggle, first_position, second_position) {
  if(!isDefined(second_position)) {
    second_position = (first_position - self.origin) / 2;
  }

  last_oldpos = first_position;
  var_e0a5fd5c9513b506 = second_position;
  avg = (var_e0a5fd5c9513b506 + last_oldpos) / 2;
  var_a20aa2636ccbfa4 = avg - var_e0a5fd5c9513b506;
  var_f17000b1738727b3 = spawnStruct();
  var_f17000b1738727b3.origin = last_oldpos + var_a20aa2636ccbfa4;
  return var_f17000b1738727b3;
}

function vehiclefollowstructpath(path_start, var_6f3f0d19b9577e15) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");
  self.on_last_pathing_array = undefined;
  var_e32861b33e4343fd = undefined;

  if(isDefined(self.pathing_arrays) && self.pathing_arrays.size > 0) {
    for(i = 0; i < self.pathing_arrays.size; i++) {
      if(!isDefined(self.pathing_arrays) || self.pathing_arrays.size == 0) {
        return;
      }

      if(i == self.pathing_arrays.size - 1) {
        self.on_last_pathing_array = 1;
      }

      vehiclefollowstructpathsplines(path_start, self.pathing_arrays[i], var_6f3f0d19b9577e15);
    }

    return;
  }

  if(isDefined(self.pathing_array) && self.pathing_array.size > 0) {
    self.on_last_pathing_array = 1;
    vehiclefollowstructpathsplines(path_start, self.pathing_array, var_6f3f0d19b9577e15);
  }
}

function finish_spline_path() {
  self endon("death");

  if(isDefined(self.convoy)) {
    if(!isDefined(self.convoy.settings) || istrue(self.convoy.settings.unload_at_target)) {
      if(isDefined(level.vehicle_all_stop_func)) {
        self[[level.vehicle_all_stop_func]](0);
      }

      self notify("unload_guys");
    }

    if(isDefined(self.convoy.settings) && isDefined(self.convoy.settings.target)) {
      self notify("unload_guys");
    }
  }

  self stoppath(1);
  self notify("stop_follow_path");
  final_node = self.pathing_array[self.pathing_array.size - 1];

  if(isDefined(final_node)) {
    struct_path_unload_node(final_node);
    wait 0.25;

    if(isDefined(level.vehicle.var_9442d439c225c3fe)) {
      if([[level.vehicle.var_9442d439c225c3fe]](self)) {
        return;
      }
    }
  }
}

function cp_vehicle_damage_monitor(damage_data) {
  idamage = undefined;

  if(isDefined(damage_data)) {
    if(isDefined(damage_data.damage)) {
      idamage = damage_data.damage;
    }

    if(isDefined(damage_data.attacker) && isPlayer(damage_data.attacker) && isDefined(idamage)) {
      if(isDefined(damage_data.attacker.team) && isDefined(self.team) && damage_data.attacker.team != self.team) {
        if(isDefined(damage_data.objweapon) && isDefined(damage_data.objweapon.basename)) {
          if(damage_data.objweapon.basename == "emp_drone_player_mp") {
            idamage = 10000;
          }
        }
      }

      if(isDefined(damage_data.objweapon) && isDefined(damage_data.objweapon.basename)) {
        switch (damage_data.objweapon.basename) {
          case #"hash_85ea99fcbe4116a4":
          case #"hash_91a48ebfd2d03a40":
            if(isDefined(self.healthbuffer)) {
              self.health = self.healthbuffer - 100;
            } else {
              self.health = 0;
            }

            break;
        }

        if(isDefined(damage_data.meansofdeath)) {
          idamage = scripts\cp\damage::handleapdamage(damage_data.objweapon, damage_data.meansofdeath, idamage, damage_data.attacker);
        }
      }

      if(isDefined(self.var_f6a794b2d3dc63e7)) {
        idamage = self[[self.var_f6a794b2d3dc63e7]](damage_data);
      }

      if(isDefined(self.damage_multiplier)) {
        idamage *= self.damage_multiplier;
      }

      if(istrue(damage_data.attacker.damage_from_above)) {
        attacker_z = damage_data.attacker.origin[2];
        victim_z = self.origin[2];

        if(attacker_z >= victim_z) {
          difference = int(abs(attacker_z - victim_z));
          idamage_multiplier = int(difference / 64);

          if(idamage_multiplier > 0) {
            idamage *= 1 + 0.4 * idamage_multiplier;
          }
        }
      }

      if(damage_data.meansofdeath == "MOD_GRENADE_SPLASH" || damage_data.meansofdeath == "MOD_PROJECTILE_SPLASH" || damage_data.meansofdeath == "MOD_PROJECTILE" || damage_data.meansofdeath == "MOD_GRENADE") {
        idamage = function_869e06b0541def6d(idamage);
      }

      damage_data.attacker scripts\cp\damagefeedback::updatehitmarker("standard", 1, idamage, 0, 0);
      new_health = self.health - idamage;
      self.health = int(max(new_health, self.healthbuffer - 1));
    }
  }

  return idamage;
}

function function_869e06b0541def6d(amount) {
  return int(amount * 5);
}

function init_vehicle_spawning() {
  level.ai_spawn_vehicle_func = [];
  level.next_index = 0;
  level.all_ai_vehicle_infils = [];
  level.available_ai_vehicle_air_infils = [];
  level.available_ai_vehicle_ground_infils = [];
  level.path_points = [];
  level.invalid_path_points = [];
  level.heli_triggers = [];
  level.vehicle_ai_script_models = [];
  vehicle_registrations();
  level thread init_vehicles_after_flags();
  add_ai_air_infil("attack_heli");
  register_vehicle_spawn("attack_heli", undefined, undefined, undefined, "heli_spawner", undefined, "heli_infil_path", undefined, &spawn_enemy_chopper, "apache");
  register_vehicle_spawn("random_ground_vehicle_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_random_ground_vehicle_spawn);
  register_vehicle_spawn("random_air_vehicle_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_random_air_vehicle_spawn);
  register_vehicle_spawn("escalation_heli_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_escalation_air_vehicle_spawn);
}

function init_vehicles_after_flags() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  unset_bullet_shields();
  create_passengers_unload_groups();
  set_vehicle_templates_script_team();
  level.ground_vehicle_structs = getStructArray("ground_veh_infil_path", "targetname");

  if(isDefined(level.vehicle.helicopter_crash_locations)) {
    level.vehicle.helicopter_crash_locations = array_combine(level.vehicle.helicopter_crash_locations, getstructarray_delete("helicopter_crash_location", "targetname"));
    level.vehicle.helicopter_crash_locations = array_combine(level.vehicle.helicopter_crash_locations, getStructArray("heli_exit", "targetname"));
    return;
  }

  level.vehicle.helicopter_crash_locations = getStructArray("heli_exit", "targetname");
}

function vehicle_ai_spawn_funcs() {}

function register_spawner_script_function(func_name, func, specs, wait_for_notify) {
  if(istrue(wait_for_notify)) {
    level waittill(func_name);
  }

  if(isDefined(level.spawner_script_funcs[func_name])) {
    struct = level.spawner_script_funcs[func_name];
  } else {
    struct = spawnStruct();
  }

  struct.script_function = func;
  struct.specs = specs;
  level.spawner_script_funcs[func_name] = struct;
}

function create_ai_plr_vehicle(veh_spawn_point, vehicle_type) {
  copy_vehicle_build_to_spawnpoint(vehicle_type, veh_spawn_point);
  vehicle = scripts\common\vehicle::vehicle_spawn(veh_spawn_point);
  vehicle.cannotbesuspended = 1;

  if(isDefined(veh_spawn_point.vehiclename)) {
    vehicle.vehiclename = veh_spawn_point.vehiclename;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "axis");
    vehicle makeunusable();
    vehicle setCanDamage(1);
    vehicle.maxhealth = 999999;
    vehicle.health = vehicle.maxhealth;
    vehicle scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
    vehicle scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(vehicle, undefined, undefined);
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(vehicle, undefined);
    var_e9ad534890b3b83e = &scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
    [[var_e9ad534890b3b83e]](vehicle, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
    var_cfde26882efc85e = &scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
    [[var_cfde26882efc85e]](vehicle, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
    vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
  }

  return vehicle;
}

function register_vehicle_build(vehicle_type, model, type, classname, var_35c134fe54c9a072) {
  struct = spawnStruct();
  struct.model = model;
  struct.vehicletype = type;
  struct.classname_mp = classname;
  level.vehicle_builds[vehicle_type] = struct;
}

function register_vehicle_as_ambient(vehicle_type, wait_for_notify) {
  if(istrue(wait_for_notify)) {
    level waittill(vehicle_type);
  }

  struct = level.vehicle_builds[vehicle_type];

  if(isDefined(struct)) {
    struct.is_ambient = 1;
    struct.allow_deleteme_path = 1;
  }
}

function vehicle_is_ambient(vehicle_type) {
  return istrue(level.vehicle_builds[vehicle_type].is_ambient);
}

function create_ambient_vehicle(vehicle_type, model, type, classname) {
  level thread register_vehicle_max_ai(vehicle_type, model, type, classname, undefined, 1, 1);
  level thread register_vehicle_as_ambient(vehicle_type, 1);
  level thread register_vehicle_spawn_drivers(vehicle_type, 1, random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  level thread register_vehicle_spawn_override(vehicle_type, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined);
}

function register_vehicle_max_ai(vehicle_type, model, type, classname, var_35c134fe54c9a072, override, wait_for_notify) {
  if(istrue(wait_for_notify)) {
    level waittill(vehicle_type);
  }

  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.aianims)) {
        if(isDefined(level.vehicle.templates.aianims[classname])) {
          if(isDefined(level.ai_spawn_vehicle_func[vehicle_type]) && isDefined(level.ai_spawn_vehicle_func[vehicle_type].max_ai)) {
            if(isDefined(override)) {
              level.vehicle_builds[vehicle_type].max_ai = override;
            } else {
              level.vehicle_builds[vehicle_type].max_ai = level.ai_spawn_vehicle_func[vehicle_type].max_ai;
            }

            return;
          }

          if(isDefined(override)) {
            level.vehicle_builds[vehicle_type].max_ai = override;
            return;
          }

          var_339e16780e986b27 = level.vehicle.templates.aianims[classname];
          level.vehicle_builds[vehicle_type].max_ai = var_339e16780e986b27.size;
        }
      }
    }
  }
}

function get_max_ai_from_infil_name(module_struct, vehicle_type) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[vehicle_type]) && isDefined(level.vehicle_builds[vehicle_type].max_ai)) {
    invalid_seats = scripts\cp\vehicles::get_invalid_seats_from_module_struct(module_struct, vehicle_type);

    if(isDefined(invalid_seats)) {
      count = 0;

      for(i = 0; i < self.usedpositions.size; i++) {
        found_seat = 1;

        for(j = 0; j < invalid_seats.size; j++) {
          if(invalid_seats[j] == i) {
            found_seat = 0;
            break;
          }
        }

        if(found_seat) {
          count++;
        }
      }

      return int(min(count, level.vehicle_builds[vehicle_type].max_ai));
    } else {
      return level.vehicle_builds[vehicle_type].max_ai;
    }

    return;
  }

  return undefined;
}

function get_random_available_air_ai_infil() {
  return random(level.available_ai_vehicle_air_infils);
}

function get_random_available_ground_ai_infil() {
  return random(level.available_ai_vehicle_ground_infils);
}

function attempt_ai_ground_infil_cooldown(infil_name) {
  if(level.ai_spawn_vehicle_func[infil_name].max_num <= level.ai_spawn_vehicle_func[infil_name].count) {
    level thread remove_ai_ground_infil_for_time(infil_name);
  }
}

function attempt_ai_air_infil_cooldown(infil_name) {
  if(level.ai_spawn_vehicle_func[infil_name].max_num <= level.ai_spawn_vehicle_func[infil_name].count) {
    level thread remove_ai_air_infil_for_time(infil_name);
  }
}

function remove_ai_ground_infil_for_time(infil_name) {
  level.available_ai_vehicle_ground_infils = array_remove(level.available_ai_vehicle_ground_infils, infil_name);

  if(isDefined(level.ai_spawn_vehicle_func[infil_name].cooldown)) {
    delaythread(level.ai_spawn_vehicle_func[infil_name].cooldown, &add_ai_ground_infil, infil_name);
  }
}

function remove_ai_air_infil_for_time(infil_name) {
  level.available_ai_vehicle_air_infils = array_remove(level.available_ai_vehicle_air_infils, infil_name);

  if(isDefined(level.ai_spawn_vehicle_func[infil_name].cooldown)) {
    delaythread(level.ai_spawn_vehicle_func[infil_name].cooldown, &add_ai_air_infil, infil_name);
  }
}

function add_ai_air_infil(infil_name) {
  level.available_ai_vehicle_air_infils[infil_name] = infil_name;
}

function add_ai_ground_infil(infil_name) {
  level.available_ai_vehicle_ground_infils[infil_name] = infil_name;
}

function register_vehicle_spawn_override(spawn_type, max_num, cooldown, max_wait_for_infil, spawn_points, exit_points, path_start_points, max_ai, vehicle_spawn_func, vehicle_build) {
  level waittill(spawn_type);

  if(isDefined(level.ai_spawn_vehicle_func[spawn_type])) {
    flag_wait("level_ready_for_script");
    struct = level.ai_spawn_vehicle_func[spawn_type];

    if(isDefined(spawn_type)) {
      struct.spawn_type = spawn_type;
    }

    if(isDefined(max_num)) {
      struct.max_num = max_num;
    }

    if(isDefined(cooldown)) {
      struct.cooldown = cooldown;
    }

    if(isDefined(max_wait_for_infil)) {
      struct.max_wait_for_infil = max_wait_for_infil;
    }

    if(isDefined(spawn_points)) {
      struct.spawn_points = spawn_points;
    }

    if(isDefined(exit_points)) {
      struct.exit_points = exit_points;
    }

    if(isDefined(path_start_points)) {
      struct.path_start_points = path_start_points;
    }

    if(isDefined(vehicle_spawn_func)) {
      struct.vehicle_spawn_func = vehicle_spawn_func;
    }

    if(isDefined(vehicle_build)) {
      struct.vehicle_build = vehicle_build;
    }

    level.ai_spawn_vehicle_func[spawn_type] = struct;

    if(isDefined(path_start_points)) {
      level thread get_path_points(spawn_type, path_start_points);
    }
  }

  if(isDefined(max_ai)) {
    if(isDefined(level.vehicle_builds[spawn_type]) && isDefined(level.vehicle_builds[spawn_type].max_ai)) {
      level.vehicle_builds[spawn_type].max_ai = max_ai;
    }
  }
}

function register_vehicle_spawn(spawn_type, max_num, cooldown, max_wait_for_infil, spawn_points, exit_points, path_start_points, max_ai, vehicle_spawn_func, vehicle_build) {
  level.all_ai_vehicle_infils[level.all_ai_vehicle_infils.size] = spawn_type;
  struct = spawnStruct();
  struct.spawn_type = spawn_type;
  struct.max_num = max_num;
  struct.cooldown = cooldown;
  struct.max_wait_for_infil = max_wait_for_infil;
  struct.spawn_points = spawn_points;
  struct.exit_points = exit_points;
  struct.path_start_points = path_start_points;
  struct.vehicle_spawn_func = vehicle_spawn_func;
  struct.count = 0;
  struct.max_ai = max_ai;
  struct.vehicle_build = vehicle_build;
  struct.cpvehiclename = spawn_type;
  level.ai_spawn_vehicle_func[spawn_type] = struct;

  if(isDefined(path_start_points)) {
    level thread get_path_points(spawn_type, path_start_points);
  }
}

function get_path_points(spawn_type, path_start_points) {
  level endon("game_ended");
  level.path_points[spawn_type] = getStructArray(path_start_points, "targetname");
}

function register_vehicle_spawn_drivers(spawn_type, num_script_models, driver_models, wait_for_notify) {
  if(istrue(wait_for_notify)) {
    level waittill(spawn_type);
  }

  if(isDefined(level.ai_spawn_vehicle_func[spawn_type])) {
    struct = level.ai_spawn_vehicle_func[spawn_type];
    struct.num_script_models = num_script_models;
    struct.driver_models = driver_models;
    level.ai_spawn_vehicle_func[spawn_type] = struct;
  }
}

function choose_random_ground_vehicle_spawn(group, spawn_point, param3) {
  if(isDefined(spawn_point.ai_infil_type)) {
    random_infil = spawn_point.ai_infil_type;
  } else {
    random_infil = get_random_available_ground_ai_infil();
  }

  if(isDefined(random_infil)) {
    spawn_point.og_script_function = spawn_point.script_function;
    spawn_point.script_function = random_infil;

    if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[random_infil].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[random_infil].vehicle_spawn_func]](group, spawn_point, random_infil)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(spawn_point.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[random_infil].script_function]](group, spawn_point, random_infil);
    thread attempt_ai_ground_infil_cooldown(random_infil);
    return;
  }

  return 0;
}

function decrement_wave_veh_count(random_infil) {
  if(isDefined(self.valid_vehicles) && isDefined(self.valid_vehicles[random_infil])) {
    self.valid_vehicles[random_infil]--;

    if(self.valid_vehicles[random_infil] < 1) {
      self.valid_vehicles[random_infil] = undefined;
    }
  }
}

function choose_escalation_air_vehicle_spawn(group, spawn_point, param3) {
  random_infil = undefined;
  current_wave_ref = group scripts\cp\cp_wave_spawning::get_current_wave_ref();

  if(isDefined(current_wave_ref)) {
    allowed_vehicles = group scripts\cp\spawning::get_allowed_vehicle_types_from_wave();

    if(istrue(group.use_only_veh_spawners) && (!isDefined(allowed_vehicles) || allowed_vehicles.size < 1)) {
      return 0;
    }

    allowed_vehicles = spawn_point scripts\cp\spawning::get_allowed_vehicle_types_from_spawnpoint(allowed_vehicles);

    if(isDefined(allowed_vehicles) && allowed_vehicles.size > 0) {
      random_infil = random(allowed_vehicles);

      if(scripts\cp\spawning::has_vehicle_type_exceeded_module_cap(group, random_infil)) {
        return 0;
      }
    }
  } else if(isDefined(group.valid_vehicles) && array_sum(group.valid_vehicles) > 0) {
    allowed_vehicles = group scripts\cp\spawning::get_allowed_vehicle_types_from_wave();
    allowed_vehicles = spawn_point scripts\cp\spawning::get_allowed_vehicle_types_from_spawnpoint(allowed_vehicles);

    if(isDefined(allowed_vehicles) && allowed_vehicles.size > 0) {
      random_infil = random(allowed_vehicles);

      if(scripts\cp\spawning::has_vehicle_type_exceeded_module_cap(group, random_infil)) {
        return 0;
      }
    }
  } else {
    random_infil = get_random_available_air_ai_infil();
  }

  if(isDefined(random_infil)) {
    if(scripts\cp\spawning::has_vehicle_type_exceeded_module_cap(group, random_infil)) {
      return 0;
    }

    spawn_point.og_script_function = spawn_point.script_function;
    spawn_point.script_function = random_infil;

    if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[random_infil].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[random_infil].vehicle_spawn_func]](group, spawn_point, random_infil)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(spawn_point.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[random_infil].script_function]](group, spawn_point, random_infil);
    return;
  }

  return 0;
}

function choose_random_air_vehicle_spawn(group, spawn_point, param3) {
  if(isDefined(spawn_point.ai_infil_type)) {
    random_infil = spawn_point.ai_infil_type;
  } else {
    random_infil = get_random_available_air_ai_infil();
  }

  if(isDefined(random_infil)) {
    spawn_point.og_script_function = spawn_point.script_function;
    spawn_point.script_function = random_infil;

    if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[random_infil].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[random_infil].vehicle_spawn_func]](group, spawn_point, random_infil)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(spawn_point.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[random_infil].script_function]](group, spawn_point, random_infil);
    thread attempt_ai_air_infil_cooldown(random_infil);
    return;
  }

  return 0;
}

function ai_ground_veh_spawn(module_struct, spawn_point, infil_name) {
  if(isDefined(spawn_point.vehicle)) {
    self.vehicle = spawn_point.vehicle;
    self.vehicle thread thread_on_notify("unloaded", &clear_kill_off_flags, self, undefined, self, self, "death");
    thread delay_enter_vehicle(module_struct, spawn_point, spawn_point.vehicle, infil_name);
    spawn_point.vehicle thread allow_infil_after_full_or_timeout(module_struct, infil_name);
  }
}

function function_64f6b6424352bc68(group, spawn_point, infil_name) {
  if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[infil_name].vehicle_spawn_func)) {
    if([[level.ai_spawn_vehicle_func[infil_name].vehicle_spawn_func]](group, spawn_point, infil_name)) {
      thread ai_enter_vehicle(group, spawn_point, infil_name);
    }

    return;
  }

  thread ai_enter_vehicle(group, spawn_point, infil_name);
}

function ai_enter_vehicle(module_struct, spawn_point, infil_name) {
  if(isDefined(spawn_point.vehicle)) {
    thread clear_kill_off_flags_after_unload(spawn_point.vehicle);
    thread delay_enter_vehicle(module_struct, spawn_point, spawn_point.vehicle, infil_name);
    spawn_point.vehicle thread allow_infil_after_full_or_timeout(module_struct, infil_name);

    if(isDefined(spawn_point.script_demeanor)) {
      scripts\cp\spawning::set_demeanor_from_unittype(spawn_point.script_demeanor);
    }
  }
}

function clear_kill_off_flags_after_unload(vehicle) {
  self endon("death");
  clear_kill_off_flags_after_unload_wait(vehicle);
  thread clear_kill_off_flags(self);
}

function clear_kill_off_flags_after_unload_wait(vehicle) {
  self endon("unload");
  self endon("death");
  vehicle endon("death");
  self waittill("forever");
}

function delay_enter_vehicle(module_struct, spawn_point, vehicle, infil_name) {
  if(isDefined(self.spawnpoint.pos_override_struct) && self.spawnpoint.pos_override_struct != vehicle) {
    vehicle thread add_to_vehicle_queue(self);
    return;
  }

  thread_on_notify("loaded", &disable_canshootinvehicle);
  self hide();

  if(isDefined(spawn_point.script_demeanor)) {
    scripts\cp\spawning::set_demeanor_from_unittype(spawn_point.script_demeanor);
  }

  forced_seat = vehicle get_valid_seats(module_struct, infil_name);

  if(!isDefined(self.forced_startingposition) && isDefined(forced_seat) && int(forced_seat) >= 0) {
    self.forced_startingposition = forced_seat;
  }

  self dontinterpolate();
  vehicle thread scripts\common\vehicle_aianim::guy_enter(self);
}

function disable_canshootinvehicle() {
  self show();

  if(istrue(level.vehicle_ai_can_shoot_after_reload)) {
    return;
  }

  self.canshootinvehicle = 0;
}

function add_to_vehicle_queue(ai) {
  self notify("add_to_vehicle_queue");
  self.load_queue[self.load_queue.size] = ai;
  ai thread_on_notify_no_endon_death("death", &remove_from_vehicle_queue, self);
}

function remove_from_vehicle_queue(vehicle) {
  if(isDefined(vehicle) && isDefined(vehicle.load_queue) && vehicle.load_queue.size > 0) {
    if(array_contains(vehicle.load_queue, self)) {
      vehicle.load_queue = array_remove(vehicle.load_queue, self);
    }
  }
}

function veh_ground_veh_spawn(group, spawn_point, infil_name) {
  data_struct = level.ai_spawn_vehicle_func[infil_name];
  var_1317c822798f0c26 = data_struct get_vehicle_spawn_points(spawn_point);

  if(var_1317c822798f0c26.size > 0) {
    foreach(veh_spawn_point in var_1317c822798f0c26) {
      if(istrue(veh_spawn_point.in_use)) {
        continue;
      }

      vehicle = create_ai_plr_vehicle(veh_spawn_point, infil_name);

      if(isDefined(vehicle)) {
        vehicle init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name);
        vehicle thread veh_ping_vehicle_location_to_players();
        vehicle thread waittill_full_or_timeout(infil_name, group);
        vehicle post_spawn_vehicle_init(group, spawn_point, infil_name, veh_spawn_point);
        vehicle thread init_ground_vehicle(group, infil_name);

        if(vehicle_is_ambient(infil_name) || getdvarint(@ "hash_9ba0d5f78c98373e", 0)) {
          vehicle thread spawn_script_model_driver_and_passengers(vehicle, infil_name);
        }

        clear_vehicle_build_to_spawnpoint(veh_spawn_point);
        return 1;
      }

      clear_vehicle_build_to_spawnpoint(veh_spawn_point);
      return 0;
    }

    return 0;
  }

  return 0;
}

function veh_ping_vehicle_location_to_players() {
  self endon("death");
  self endon("unloading");

  while(true) {
    pinglocationenemyteams(self.origin, "axis");
    wait 2;
  }
}

function post_spawn_vehicle_init(group, spawn_point, infil_name, veh_spawn_point) {
  level.ai_spawn_vehicle_func[infil_name].count++;
  self.load_queue = [];
  self.group = group;
  self.vehicle_skipdeathmodel = 1;
  self.veh_spawn_point = veh_spawn_point;
  spawn_point.ai_infil_type = infil_name;
  veh_spawn_point.in_use = 1;
  spawn_point.specs = level.spawner_script_funcs[infil_name].specs;
  spawn_point.vehicle = self;
  self.spawn_point = spawn_point;
}

function spawn_script_model_driver_and_passengers(vehicle, infil_name) {
  vehicle_struct = level.ai_spawn_vehicle_func[infil_name];

  if(isDefined(vehicle_struct) && isDefined(vehicle_struct.num_script_models)) {
    fake_guys = [];

    for(i = 0; i < vehicle_struct.num_script_models; i++) {
      struct = level.vehicle.templates.aianims[vehicle.classname_mp][i];
      tag = struct.sittag;
      fake_guy = vehicle scripts\cp\vehicles\vehicle_cp::spawn_script_model_at_pos(i, tag, struct.idle_anim, struct.idle, vehicle_struct.driver_models);
      fake_guys[fake_guys.size] = fake_guy;
      level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = fake_guy;
      vehicle thread cleanup_fake_ai_on_death(fake_guys);

      if(i <= 1 && is_wave_gametype()) {
        vehicle thread script_model_pilot_kill_watch(fake_guy);
      }
    }
  }

  if(isDefined(level.vehicle_builds[infil_name]) && isDefined(level.vehicle_builds[infil_name].max_ai)) {
    max_guys = int(min(level.vehicle_builds[infil_name].max_ai, vehicle.usedpositions.size));
  } else {
    max_guys = vehicle.usedpositions.size;
  }

  if(vehicle.attachedguys.size >= max_guys) {
    vehicle notify("spawning_done");
    return;
  }
}

function script_model_pilot_kill_watch(var_c2f1ca305ee16808) {
  self endon("death");
  var_c2f1ca305ee16808 endon("death");

  if(!isDefined(self) || !isDefined(var_c2f1ca305ee16808)) {
    return;
  }

  health_amount = 250;

  while(true) {
    self waittill("damage", amount, attacker, unused, point);

    if(isDefined(attacker) && isPlayer(attacker) && isDefined(amount) && amount > 0 && isDefined(point)) {
      if(var_c2f1ca305ee16808 tagexists("j_head")) {
        head_pos = var_c2f1ca305ee16808 gettagorigin("j_head");
      } else {
        head_pos = var_c2f1ca305ee16808.origin + (0, 0, 50);
      }

      head_pos += (0, 0, -20);
      start_point = attacker getEye();
      vec_shot = vectorNormalize(point - start_point);
      vec_head = vectorNormalize(head_pos - start_point);
      hit_dot = vectordot(vec_shot, vec_head);
      veh_dot = vectordot(vectorNormalize(anglesToForward(self.angles)), vectorNormalize(point - self.origin));
      seat_pos = var_c2f1ca305ee16808.origin + (0, 0, 18);

      if(hit_dot > 0.99975 && veh_dot > 0.73 && point[2] > seat_pos[2]) {
        health_amount -= amount;

        if(health_amount <= 0) {
          self notify("death", attacker);
        }
      }
    }
  }
}

function cleanup_fake_ai_on_death(fake_guys) {
  self waittill("death");

  if(isDefined(fake_guys)) {
    for(i = 0; i < fake_guys.size; i++) {
      fake_guys[i] remove_fake_guy_from_list();
    }
  }
}

function remove_fake_guy_from_list() {
  if(array_contains(level.vehicle_ai_script_models, self)) {
    level.vehicle_ai_script_models = array_remove(level.vehicle_ai_script_models, self);

    if(isDefined(self)) {
      self delete();
    }
  }
}

function get_vehicle_spawn_points(spawn_point) {
  if(istrue(spawn_point.veh_model_spawner)) {
    return [spawn_point];
  }

  potential_structs = getStructArray(self.spawn_points, "targetname");
  return_array = [];

  if(isDefined(spawn_point.script_linkname)) {
    for(i = 0; i < potential_structs.size; i++) {
      if(is_linked_struct(potential_structs[i], spawn_point)) {
        return_array[return_array.size] = potential_structs[i];
      }
    }

    if(return_array.size < 1) {
      return array_randomize(potential_structs);
    } else {
      returned_struct = random(return_array);
      return [returned_struct];
    }

    return;
  }

  return array_randomize(potential_structs);
}

function veh_heli_spawn(group, spawn_point, infil_name) {
  data_struct = level.ai_spawn_vehicle_func[infil_name];
  var_1317c822798f0c26 = data_struct get_vehicle_spawn_points(spawn_point);

  if(var_1317c822798f0c26.size > 0) {
    foreach(veh_spawn_point in var_1317c822798f0c26) {
      if(istrue(veh_spawn_point.in_use)) {
        continue;
      }

      if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
        thread draw_capsule(veh_spawn_point.origin, 64, 64, (0, 0, 0), (0, 1, 0), 0, 1000);
      }

      copy_vehicle_build_to_spawnpoint(infil_name, veh_spawn_point);
      angle_ref = vectortoangles(spawn_point.origin - veh_spawn_point.origin);
      veh_spawn_point.angles = (0, angle_ref[1], 0);
      vehicle = scripts\common\vehicle::vehicle_spawn(veh_spawn_point);

      if(isDefined(vehicle)) {
        vehicle init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name);
        veh_spawn_point toggle_in_use(1);

        if(veh_spawn_point scripts\common\vehicle::ishelicopter()) {
          vehicle init_helicopter(group, infil_name);
        }

        if(isDefined(group)) {
          group.vehicle = vehicle;
        }

        vehicle.veh_spawn_point = veh_spawn_point;
        vehicle.path_gobbler = 1;
        spawn_point.specs = level.spawner_script_funcs[infil_name].specs;
        spawn_point.ai_infil_type = infil_name;
        vehicle thread veh_ping_vehicle_location_to_players();
        vehicle thread heli_waittill_full_or_timeout(infil_name, group);

        if(vehicle_is_ambient(infil_name) || getdvarint(@ "hash_9ba0d5f78c98373e", 0) || is_wave_gametype()) {
          vehicle thread spawn_script_model_driver_and_passengers(vehicle, infil_name);
        }

        clear_vehicle_build_to_spawnpoint(veh_spawn_point);
        return 1;
      }

      clear_vehicle_build_to_spawnpoint(veh_spawn_point);
      return 0;
    }

    return 0;
  }

  return 0;
}

function init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name) {
  self.load_queue = [];
  self.spawn_point = spawn_point;
  self.infil_name = infil_name;

  if(isDefined(group)) {
    self.group = group;
    group.vehicle = self;
    group.recently_spawned_vehicle = 1;
    group thread decrement_wave_veh_count(infil_name);
  }

  spawn_point.vehicle = self;
  spawn_point.veh_spawn_point = veh_spawn_point;
  self.veh_spawn_point = veh_spawn_point;
  self.dontdisconnectpaths = 1;
  self setCanDamage(1);
  scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  thread destroy_vehicle_if_driver_dies();
  self vehicle_turnengineon();
}

function destroy_vehicle_if_driver_dies() {
  self endon("death");
  guy = watch_for_driver_spawned();

  if(isDefined(guy) && isai(guy)) {
    guy.health = 500;
    guy.maxhealth = 500;

    if(scripts\common\vehicle::ishelicopter()) {
      thread destroy_vehicle_on_pilot_death(guy);
      return;
    }

    thread stop_vehicle_on_pilot_death(guy);
  }
}

function function_fe2167fe1376f914() {
  level endon("game_ended");
  self endon("death_finished");
  self endon("death");

  if(getdvarint(@ "hash_a474fdc25ad6ab13", 0)) {
    self waittill("landing_found");

    if(isDefined(self.aidriver)) {
      self.aidriver.invulnerable = 1;
    }

    self notify("vehicle_OnDriverDeath_early");
  }

  if(isDefined(self.aidriver)) {
    self.aidriver.ignoreme = 1;
  }
}

function destroy_vehicle_on_pilot_death(guy) {
  level endon("game_ended");
  self endon("death_finished");
  self endon("death");
  guy endon("unload");
  guy waittill("death", attacker, test, test2, test3);
  self notify("death", attacker);
}

function stop_vehicle_on_pilot_death(guy) {
  level endon("game_ended");
  self endon("death");
  guy endon("unload");
  guy waittill("death", attacker, test, test2, test3);
  self notify("watch_for_all_passengers_dead");
  self stoppath(1);
  self notify("stop_follow_path");
  self vehicle_setspeedimmediate(0, 1, 1);
  scripts\common\vehicle::vehicle_unload();
  wait 0.25;

  if(isDefined(level.vehicle.var_9442d439c225c3fe)) {
    if([[level.vehicle.var_9442d439c225c3fe]](self)) {
      return;
    }
  }
}

function watch_for_driver_spawned() {
  level endon("game_ended");
  self endon("death");
  self endon("unloading");

  while(true) {
    self waittill("guy_entered", guy, pos);

    if(isDefined(guy)) {
      if(is_equal(self.driver, guy)) {
        return guy;
      }
    }
  }

  return undefined;
}

function toggle_in_use(bool) {
  if(istrue(bool)) {
    self.in_use = bool;
    return;
  }

  self.in_use = undefined;
}

function clear_vehicle_build_to_spawnpoint(veh_spawn_point) {
  veh_spawn_point.classname_mp = undefined;
  veh_spawn_point.vehicletype = undefined;
  veh_spawn_point.vehiclename = undefined;
}

function copy_vehicle_build_to_spawnpoint(infil_name, veh_spawn_point) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[infil_name])) {
    data_struct = level.vehicle_builds[infil_name];

    if(isDefined(data_struct.classname_mp)) {
      veh_spawn_point.classname_mp = data_struct.classname_mp;
    }

    if(isDefined(data_struct.vehicletype)) {
      veh_spawn_point.vehicletype = data_struct.vehicletype;
    }

    if(isDefined(data_struct.vehiclename)) {
      veh_spawn_point.vehiclename = data_struct.vehiclename;
    }
  }
}

function waittill_full_or_timeout(infil_name, group) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(infil_name, group);
  thread watch_for_all_passengers_dead(infil_name, group);

  if(self vehicle_isphysveh()) {
    if(getdvarint(@ "hash_b77d72f69452a294", 0)) {
      self vehicle_cleardrivingstate();
    }

    self.veh_brake = 1;
  }

  self waittill("spawning_done");
  self.spawn_point scripts\cp\spawning::disable_spawner();
  thread_on_notify_no_endon_death("unloading", &check_for_unloading_func, infil_name, undefined, undefined);

  if(!isDefined(self.group.successful_vehicle_spawns)) {
    self.group.successful_vehicle_spawns = 1;
  } else {
    self.group.successful_vehicle_spawns++;
  }

  self.group.vehicle = undefined;
  self.spawn_point.pos_override_struct = undefined;

  if(self.load_queue.size > 0) {
    thread scripts\common\vehicle::vehicle_load_ai(self.load_queue);
    ent_flag_wait("loaded");
  } else {
    wait 1;
  }

  start_path = create_vehicle_path(infil_name);

  if(self vehicle_isphysveh()) {
    self.veh_brake = 0;
  }

  self notify("ai_vehicle_pathing_started");

  if(!self vehicle_isphysveh()) {
    if(isDefined(self.target)) {
      start_node = getvehiclenode(self.target, "targetname");
      self attachpath(start_node);
      self startpath();
    } else {
      self notify("stop_vehicle_watchers");
    }

    return;
  }

  self notify("newpath");

  if(isDefined(self.target)) {
    start_node = getvehiclenode(self.target, "targetname");

    if(isDefined(start_node)) {
      self attachpath(start_node);
      self startpath();
      return;
    }
  }

  if(getdvarint(@ "hash_b77d72f69452a294", 0) && self.pathing_array.size >= 1) {
    self.spawn_point.vehicle = undefined;
    vehiclefollowstructpath(self.pathing_array[0], 1);
    return;
  }

  self.spawn_point.vehicle = undefined;
  thread scripts\common\vehicle_paths::getonpath();
}

function get_duration_between_points(startpos, endpos, speed, convert) {
  dist = distance(startpos, endpos);

  if(istrue(convert)) {
    dist *= 0.0568182;
  }

  moverate = dist / speed;

  if(moverate < 0.05) {
    moverate = 0.05;
  }

  return moverate;
}

function heli_waittill_full_or_timeout(infil_name, group) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(infil_name, group);
  thread heli_watch_for_fly_away(infil_name);
  self waittill("spawning_done");
  self.spawn_point scripts\cp\spawning::disable_spawner();

  if(isDefined(group)) {
    self.group.vehicle = undefined;
  }

  thread_on_notify_no_endon_death("unloading", &check_for_unloading_func, infil_name, undefined, undefined);
  thread_on_notify_no_endon_death("unloaded", &delete_nav_obstacle, undefined, undefined, undefined);

  if(isDefined(self.spawn_point.heli_path_func)) {
    start_path = self[[self.spawn_point.heli_path_func]](infil_name);
  } else {
    start_path = create_direct_heli_path(infil_name);
  }

  self.spawn_point.vehicle = undefined;
}

function check_for_unloading_func(infil_name) {
  if(isDefined(level.unloading_func[infil_name])) {
    self thread[[level.unloading_func[infil_name]]]();
  }
}

function watch_for_all_passengers_dead(infil_name, group) {
  self notify("watch_for_all_passengers_dead");
  self endon("watch_for_all_passengers_dead");
  self endon("death");
  self endon("unloading");
  self waittill("guy_entered");
  self waittill("spawning_done");

  while(true) {
    var_67b4a6e5752b260f = get_vehicle_riders(1);

    if(var_67b4a6e5752b260f <= 0) {
      delete_nav_obstacle();
      self notify("all_passengers_dead");
      self notify("newpath");
      self vehicle_setspeedimmediate(0, 30, 30);
      thread convert_remaining_to_ai(group);
      break;
    }

    wait 0.2;
  }
}

function convert_remaining_to_ai(group, var_c02e57df860f2d41) {
  temp_array = self.riders;

  if(isDefined(var_c02e57df860f2d41)) {
    temp_array = var_c02e57df860f2d41;
  }

  for(i = 0; i < temp_array.size; i++) {
    rider = temp_array[i];

    if(!isent(rider) || isagent(rider)) {
      continue;
    }

    var_78543f1a37928429 = spawnStruct();
    var_78543f1a37928429.origin = rider.origin;
    var_78543f1a37928429.angles = rider.angles;
    var_78543f1a37928429.vehicle_position = rider.vehicle_position;
    var_78543f1a37928429.specs = rider.specs;

    if(isDefined(self.convoy)) {
      level deposit_from_compromised_convoy_delayed(self);
    }

    rider remove_fake_guy_from_list();
    new_seat = var_78543f1a37928429.vehicle_position;
    var_78543f1a37928429.vehicle_position = undefined;
    var_78543f1a37928429.specs = "vehicle_ai";
    soldier = scripts\cp\spawning::function_4441d2c30537ec6b(group, var_78543f1a37928429, 0, "vehicle_ai", undefined, 1);

    if(isDefined(soldier)) {
      soldier.forced_startingposition = new_seat;

      if(istrue(self.stealth_enabled)) {
        soldier.ignoreall = 0;
        soldier.sightmaxdistance = 2200;
        soldier thread scripts\cp\coop_stealth::run_common_functions(soldier, 1, 1, 60, 160000);
      }

      thread scripts\common\vehicle_aianim::guy_enter(soldier);
    }

    if(isent(rider)) {
      rider delete();
    }
  }

  scripts\common\vehicle::vehicle_unload();
}

function deposit_from_compromised_convoy_delayed(vehicle) {
  level endon("game_ended");

  if(!isDefined(vehicle.convoy)) {
    return;
  }

  vehicle.convoy endon("event_convoy_delete");
  vehicle.convoy endon("death");
  vehicle endon("death");
  convoy = vehicle.convoy;

  if(istrue(convoy.delayed_depositing)) {
    vehicle thread deposit_from_compromised_convoy_delayed_failsafe();

    while(istrue(convoy.delayed_depositing)) {
      wait 0.5;
    }

    return;
  }

  maxaicount = 28;

  if(getaiarray("axis").size > maxaicount) {
    convoy.delayed_depositing = 1;
    scripts\cp\spawning::pause_group_by_group_name("wave_spawning");

    while(getaiarray("axis").size > maxaicount) {
      wait 0.5;
    }

    convoy.delayed_depositing = undefined;
    convoy notify("delayed_depositing_undefined");
    scripts\cp\spawning::unpause_group_by_group_name("wave_spawning");
  }
}

function deposit_from_compromised_convoy_delayed_failsafe() {
  level endon("game_ended");
  self.convoy endon("delayed_depositing_undefined");
  self waittill("death");

  if(isDefined(self.convoy)) {
    self.convoy.delayed_depositing = undefined;
  }
}

function heli_watch_for_fly_away(infil_name) {
  self notify("heli_watch_for_fly_away");
  self endon("heli_watch_for_fly_away");
  self endon("death");
  self waittill("guy_entered");
  self waittill("spawning_done");
  thread waittill_all_valid_ai_are_gone(infil_name);
  thread waittill_unload_complete(infil_name);
}

function waittill_unload_complete(infil_name) {
  self notify("waittill_unload_complete");
  self endon("waittill_unload_complete");
  self endon("death");
  self endon("all_valid_passengers_are_gone");
  self waittill("unloaded");

  if(isDefined(self.spawn_point) && isDefined(self.spawn_point.leaveforplayer)) {
    if(isDefined(level.heli_convertforplayerfunc)) {
      [[level.heli_convertforplayerfunc]](self);
    }

    return;
  }

  self notify("newpath");
  delete_nav_obstacle();
  thread get_to_z_and_fly_off(infil_name);
  self notify("all_valid_passengers_are_gone");
}

function waittill_all_valid_ai_are_gone(infil_name) {
  self notify("waittill_all_valid_ai_are_gone");
  self endon("waittill_all_valid_ai_are_gone");
  self endon("death");
  self endon("unloaded");

  while(true) {
    num_riders = get_vehicle_riders();
    var_67b4a6e5752b260f = get_vehicle_riders(1);
    var_f268752392ac42d1 = get_vehicle_unloadable_riders(1);

    if(var_67b4a6e5752b260f <= 0 || var_f268752392ac42d1 <= 0) {
      if(isDefined(self.spawn_point) && isDefined(self.spawn_point.leaveforplayer)) {
        if(isDefined(level.heli_convertforplayerfunc)) {
          [[level.heli_convertforplayerfunc]](self);
        }

        return;
      }

      thread get_to_z_and_fly_off(infil_name);
      self notify("newpath");
      delete_nav_obstacle();
      self notify("all_valid_passengers_are_gone");
      break;
    }

    wait 0.2;
  }
}

function get_to_z_and_fly_off(infil_name, var_61bec49fd0ba66b6) {
  self endon("death");
  thread mark_remaining_as_died_poorly();
  ground_pos = getgroundposition(self.origin, 1);

  if(distancesquared(self.origin, ground_pos) <= 2250000) {
    exit_path = spawnStruct();
    exit_path.origin = ground_pos + (0, 0, 1500);
    exit_path.angles = self.angles;
    exit_path.script_goalyaw = 1;
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(exit_path);
    self setneargoalnotifydist(512);
    waittill_any_2("near_goal", "goal");
  }

  if(!isDefined(var_61bec49fd0ba66b6)) {
    var_61bec49fd0ba66b6 = get_best_end_point(infil_name, self.spawn_point, self.angles);
  }

  if(!isDefined(var_61bec49fd0ba66b6)) {
    var_61bec49fd0ba66b6 = random(getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname"));
  }

  end_point = duplicate_struct(var_61bec49fd0ba66b6);
  forward = anglesToForward(vectortoangles(end_point.origin - self.origin)) * 10000;
  end_point.origin += (forward[0], forward[1], end_point.origin[2]);
  end_point.targetname = create_unique_kvp_string();
  self.end_point = end_point;
  path_start = end_point;

  if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
    thread draw_capsule(end_point.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
  }

  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(end_point);
}

function mark_remaining_as_died_poorly() {
  level endon("game_ended");
  self endon("death");
  wait 2;

  if(isDefined(self.riders) && self.riders.size > 0) {
    for(i = 0; i < self.riders.size; i++) {
      self.riders[i].never_unloaded_from_vehicle = 1;
    }
  }
}

function get_vehicle_riders(check_isalive) {
  count = 0;

  foreach(guy in self.riders) {
    if(istrue(check_isalive)) {
      if(isalive(guy)) {
        count++;
      }

      continue;
    }

    count++;
  }

  return count;
}

function get_vehicle_unloadable_riders(check_isalive, infil_name) {
  count = 0;

  if(isDefined(self.classname_mp)) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.templates) && isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(i = 0; i < self.riders.size; i++) {
        ai = self.riders[i];

        if(!isalive(ai)) {
          continue;
        }

        if(!isai(ai)) {
          continue;
        }

        if(!isDefined(ai.vehicle_position)) {
          continue;
        }

        if(scripts\common\vehicle_aianim::check_unloadgroup(ai.vehicle_position)) {
          seat = level.vehicle.templates.aianims[self.classname_mp][ai.vehicle_position];

          if(isDefined(seat.getout)) {
            count++;
          }
        }
      }
    }
  }

  return count;
}

function create_vehicle_path(infil_name) {
  level notify("create_vehicle_path");
  counter = level.next_index;
  level.next_index++;

  if(isDefined(self.spawn_point.veh_model_spawner)) {
    self.allow_unload_on_path = 1;
    start_point = create_path_to_delete_node(infil_name, counter);
    unload_struct = undefined;
    return start_point;
  } else {
    start_point = duplicate_struct(self.veh_spawn_point);
    add_targetname_kvps(start_point, undefined, infil_name + counter + "_start");
    self.currentnode = start_point;
    path_created = create_simple_path(self.currentnode, self.angles, counter, infil_name, "_end_node_pathing_", (1, 1, 0));

    if(path_created) {
      return start_point;
    }
  }

  unload_struct = duplicate_struct(self.spawn_point);
  var_4769a2cad76e31f = undefined;

  if(isDefined(unload_struct) && isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_linkto)) {
    linked_structs = self.veh_spawn_point get_veh_linked_structs();
    var_b1cf71f85043aea6 = -5;

    foreach(struct in linked_structs) {
      var_2c4faf696b6cfdca = math::get_dot(self.origin, self.angles, struct.origin);
      var_d305c3c2de1b97a = math::get_dot(self.origin, vectortoangles(unload_struct.origin - self.origin), struct.origin);
      dot_score = var_2c4faf696b6cfdca + var_d305c3c2de1b97a;

      if(dot_score > var_b1cf71f85043aea6) {
        var_b1cf71f85043aea6 = dot_score;
        var_4769a2cad76e31f = struct;
      }
    }
  }

  if(!isDefined(var_4769a2cad76e31f)) {
    var_54acc546493f0109 = getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "targetname");

    if(!isDefined(var_54acc546493f0109) || var_54acc546493f0109.size < 1) {
      var_54acc546493f0109 = getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "script_linkName");
    }

    if(!isDefined(var_54acc546493f0109) || var_54acc546493f0109.size < 1) {
      return;
    }

    var_4769a2cad76e31f = getclosest(self.origin, var_54acc546493f0109);
  }

  if(!isDefined(var_4769a2cad76e31f)) {
    return;
  }

  start_path = duplicate_struct(var_4769a2cad76e31f);
  start_path.angles = vectortoangles(start_path.origin - self.origin);

  if(false) {
    level thread draw_line_until_endons(self.spawn_point.origin, 1, 1, 1, "create_vehicle_path");
    level thread draw_line_until_endons(start_path.origin, 0, 1, 0, "create_vehicle_path");
    level thread draw_line_until_endons(unload_struct.origin, 1, 1, 0, "create_vehicle_path");
  }

  add_targetname_kvps(start_path, undefined, infil_name + counter + "_start");
  create_path_from_struct_to_struct(start_path, unload_struct, counter, infil_name, "_unload_pathing_", (1, 1, 1));
  thread_on_notify("unloaded", &create_path_to_delete_node, infil_name, counter, self);
  thread_on_notify_no_endon_death("death", &reset_spawn_point_targetname, self.spawn_point, undefined, self);
  self.disabled_nodes = undefined;
  return start_path;
}

function create_path_to_delete_node(infil_name, counter) {
  start_point = self.spawn_point;
  self.currentnode = start_point;
  path_created = create_simple_path(self.currentnode, self.angles, counter, infil_name, "_end_node_pathing_", (1, 1, 0));

  if(!path_created) {
    var_5bda6f0ecaf2f49 = get_best_end_point(infil_name, self.currentnode);
    end_point = duplicate_struct(var_5bda6f0ecaf2f49);
    self.path_gobbler = 1;
    self.end_point = end_point;

    if(false) {
      level thread draw_line_until_endons(end_point.origin, 1, 0, 0, "create_vehicle_path");
    }

    create_path_from_struct_to_struct(self.currentnode, end_point, counter, infil_name, "_end_node_pathing_", (1, 1, 0));
  }

  if(math::is_point_in_front(self.currentnode.origin) || self.spawn_point.origin == self.currentnode.origin) {
    self.target = self.pathing_array[1].targetname;
  } else if(!path_created) {
    self.target = self.pathing_array[1].targetname;
  } else {
    self.pathing_array = array_remove_index(self.pathing_array, 0);
  }

  self.disabled_nodes = undefined;
  return self.currentnode;
}

function create_simple_path(start_struct, comp_angles, counter, infil_name, kvp_string, color) {
  level endon("game_ended");
  self endon("death");
  found_links = 1;
  current_struct = start_struct;
  valid_dot = -0.3;
  self.pathing_array = [start_struct];

  if(false) {
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  if(isDefined(current_struct.script_linkto)) {
    start_point = duplicate_struct(current_struct);
    add_targetname_kvps(start_point, undefined, infil_name + counter + "_start");
    self.currentnode = start_point;
    current_struct = self.currentnode;
  }

  while(true) {
    if(false) {
      level.players[0] waittill("use");
    }

    if(isDefined(current_struct.script_linkto)) {
      linked_structs = current_struct get_veh_linked_structs();
      potential_structs = [];
      best_dot = -1;
      best_option = undefined;

      if(linked_structs.size == 1) {
        potential_structs[potential_structs.size] = linked_structs[0];
      } else {
        for(i = 0; i < linked_structs.size; i++) {
          linked_struct = linked_structs[i];

          if(!isDefined(best_option)) {
            best_option = linked_struct;
          }

          var_2c4faf696b6cfdca = math::get_dot(current_struct.origin, comp_angles, linked_struct.origin);

          if(var_2c4faf696b6cfdca >= valid_dot) {
            potential_structs[potential_structs.size] = linked_struct;
          }
        }
      }

      if(potential_structs.size < 1 && isDefined(best_option)) {
        potential_structs[potential_structs.size] = best_option;
      }

      if(potential_structs.size > 0) {
        selected_struct = random(potential_structs);
        selected_struct = duplicate_struct(selected_struct);
        self.path_gobbler = 1;
        self.pathing_array[self.pathing_array.size] = selected_struct;
        add_targetname_kvps(selected_struct, current_struct, infil_name + "_" + counter + "_simple_path_" + self.pathing_array.size);

        if(false) {
          level thread draw_line_until_endons(current_struct.origin, 1, 1, 1, "create_vehicle_path", selected_struct.origin);
        }

        current_struct = selected_struct;
      } else {
        break;
      }

      continue;
    }

    if(isDefined(current_struct.target)) {
      linked_structs = current_struct get_target_array();
      potential_structs = [];
      best_dot = -1;
      best_option = undefined;

      for(i = 0; i < linked_structs.size; i++) {
        linked_struct = linked_structs[i];
        var_2c4faf696b6cfdca = math::get_dot(current_struct.origin, comp_angles, linked_struct.origin);

        if(var_2c4faf696b6cfdca >= valid_dot) {
          potential_structs[potential_structs.size] = linked_struct;
          continue;
        }

        if(var_2c4faf696b6cfdca >= best_dot) {
          best_option = linked_structs[i];
        }
      }

      if(potential_structs.size < 1 && isDefined(best_option)) {
        potential_structs[potential_structs.size] = best_option;
      }

      if(potential_structs.size > 0) {
        selected_struct = random(potential_structs);

        if(array_contains(self.pathing_array, selected_struct)) {
          self.pathing_array[self.pathing_array.size] = selected_struct;
          self.looping_path = 1;
          break;
        }

        self.pathing_array[self.pathing_array.size] = selected_struct;

        if(false) {
          level thread draw_line_until_endons(current_struct.origin, 1, 1, 1, "create_vehicle_path", selected_struct.origin);
        }

        current_struct = selected_struct;
      } else {
        break;
      }

      continue;
    }

    break;
  }

  if(self.pathing_array.size > 27) {
    split_large_pathing_array();
  }

  if(self.pathing_array.size < 1) {
    return 0;
  }

  return 1;
}

function split_large_pathing_array() {
  self.pathing_arrays = [];
  var_2c437d6b6ebd8178 = [];
  var_51b313a230b35bce = undefined;

  for(i = 0; i < self.pathing_array.size; i++) {
    var_2c437d6b6ebd8178[var_2c437d6b6ebd8178.size] = self.pathing_array[i];
    var_51b313a230b35bce = self.pathing_array[i];

    if(i > 0 && i % 27 == 0) {
      self.pathing_arrays[self.pathing_arrays.size] = var_2c437d6b6ebd8178;
      var_2c437d6b6ebd8178 = [];
      var_2c437d6b6ebd8178[0] = var_51b313a230b35bce;
    }
  }

  if(var_2c437d6b6ebd8178.size == 1) {
    newstruct = spawnStruct();
    newstruct.origin = (var_2c437d6b6ebd8178[0].origin + var_51b313a230b35bce.origin) / 2;
    var_2c437d6b6ebd8178[var_2c437d6b6ebd8178.size] = var_2c437d6b6ebd8178[0];
    var_2c437d6b6ebd8178[0] = newstruct;
  }

  if(var_2c437d6b6ebd8178.size > 0) {
    self.pathing_arrays[self.pathing_arrays.size] = var_2c437d6b6ebd8178;
  }
}

function create_path_from_struct_to_struct(start_struct, goal_struct, counter, infil_name, kvp_string, color) {
  level endon("game_ended");
  self endon("death");
  last_struct = start_struct;
  last_struct.angles = self.angles;
  closest_struct = undefined;
  searching = 1;
  index = 0;
  start_struct.pathing_index = 0;

  if(isDefined(self.disabled_nodes)) {
    self.disabled_nodes = undefined;
  }

  if(isDefined(self.pathing_array)) {
    foreach(struct in self.pathing_array) {
      if(isDefined(struct)) {
        struct.previous_struct = undefined;
        struct.antepenultimate_struct = undefined;
      }
    }
  }

  self.pathing_array = [start_struct];

  if(false) {
    announcement("Waiting for player use");
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  while(true) {
    if(false) {
      level.players[0] waittill("use");
    }

    last_struct = find_closest_path_struct(last_struct, goal_struct, infil_name + counter + kvp_string + index, color, infil_name);

    if(isDefined(last_struct)) {
      if(!isDefined(last_struct.pathing_index)) {
        last_struct.pathing_index = self.pathing_array.size;
        self.pathing_array[self.pathing_array.size] = last_struct;

        if(false) {
          if(isDefined(last_struct.previous_struct)) {
            level thread draw_line_until_endons(last_struct.previous_struct.origin, color[0], color[1], color[2], ["create_vehicle_path", "kill_debug_" + last_struct.pathing_index], last_struct.origin);
          }
        }
      }

      if(last_struct.origin == goal_struct.origin) {
        break;
      }
    } else {
      break;
    }

    if(index > 1000) {
      self notify("no_good_path_found");
      break;
    }

    index++;
  }

  for(i = 0; i < self.pathing_array.size - 1; i++) {
    self.pathing_array[i].target = self.pathing_array[i + 1].targetname;
  }

  if(self.pathing_array.size > 27) {
    split_large_pathing_array();
  }
}

function find_closest_path_struct(last_struct, goal_struct, kvp_string, color, infil_name) {
  self notify("find_closest_path_struct");

  if(false) {
    level thread drawsphere(last_struct.origin, 24, 1, (1, 1, 1));
  }

  closest_struct = undefined;
  nearby_array = sortbydistance(last_struct get_veh_linked_structs(), goal_struct.origin);

  if(nearby_array.size < 1) {
    var_b077fdca28691bb5 = getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "targetname");

    if(!isDefined(var_b077fdca28691bb5) || var_b077fdca28691bb5.size < 1) {
      var_b077fdca28691bb5 = getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "script_linkName");
    }

    if(!isDefined(var_b077fdca28691bb5) || var_b077fdca28691bb5.size < 1) {
      return;
    }

    new_structs = get_array_of_closest(last_struct.origin, var_b077fdca28691bb5, [last_struct], 3);

    foreach(new_struct in new_structs) {
      nearby_array[nearby_array.size] = new_struct;
      nearby_array = array_combine(nearby_array, sortbydistance(new_struct get_veh_linked_structs(), new_struct.origin));
    }
  }

  sorted_paths = [];
  best_dot = -5;
  best_distance = 20000;
  backup_dot = -5;
  backup_struct = undefined;
  var_e79809bd510fbd33 = 0;

  foreach(new_struct in nearby_array) {
    add_struct = new_struct;

    foreach(saved_struct in self.pathing_array) {
      if(istrue(saved_struct.disabled) || new_struct.origin == saved_struct.origin) {
        add_struct = undefined;
        break;
      }
    }

    if(isDefined(add_struct)) {
      sorted_paths[sorted_paths.size] = add_struct;
    }
  }

  last_struct.rewinding_path = undefined;

  if(sorted_paths.size > 1) {
    if(istrue(0)) {
      print3d(self.pathing_array[self.pathing_array.size - 1].origin + (0, 0, 65), "<dev string:x171>", (0, 1, 0), 1, 1, 999, 1);
    }

    self.pathing_array[self.pathing_array.size - 1].was_branch = 1;
  }

  if(is_linked_struct(last_struct, goal_struct)) {
    closest_struct = goal_struct;
  } else if(sorted_paths.size > 0) {
    if(istrue(0)) {
      foreach(p_path in sorted_paths) {
        print3d(p_path.origin - (0, 0, 50), "<dev string:x179>", (0.7, 0.1, 0.3), 1, 3, 100, 1);
      }
    }

    closest_struct = calc_best_closest_struct(last_struct, goal_struct, sorted_paths);
  }

  if(!isDefined(closest_struct) && isDefined(backup_struct)) {
    closest_struct = backup_struct;
  }

  if(isDefined(closest_struct)) {
    closest_struct.angles = vectortoangles(closest_struct.origin - last_struct.origin);

    if(closest_struct.origin != goal_struct.origin) {
      closest_struct = duplicate_struct(closest_struct);
    }

    closest_struct.previous_struct = last_struct;

    if(isDefined(last_struct.previous_struct)) {
      closest_struct.antepenultimate_struct = last_struct.previous_struct;
    }

    add_targetname_kvps(closest_struct, last_struct, kvp_string);
    return closest_struct;
  }

  if(!isDefined(closest_struct)) {
    closest_struct = step_back_to_last_good_branch(last_struct, goal_struct);

    if(isDefined(closest_struct)) {
      add_targetname_kvps(closest_struct, last_struct, kvp_string);
    }
  }

  return closest_struct;
}

function is_linked_struct(linked_to, link_name) {
  if(isDefined(linked_to.script_linkto) && isDefined(link_name.script_linkname)) {
    linknames = linked_to get_links();

    foreach(linkname in linknames) {
      if(link_name.script_linkname == linkname) {
        return true;
      }
    }
  }

  return false;
}

function print_debug_info(struct, var_d305c3c2de1b97a, var_2c4faf696b6cfdca, comp_dist, total_score, endon_string) {
  self endon(endon_string);
  self endon("death");
  branch = istrue(self.pathing_array[self.pathing_array.size - 1].was_branch);

  while(true) {
    print3d(struct.origin + (0, 0, 24), "<dev string:x180>" + comp_dist, (1, 1, 0), 1, 1, 1);

    print3d(struct.origin + (0, 0, 36), "<dev string:x18b>" + var_2c4faf696b6cfdca, (1, 1, 1), 1, 1, 1);

    print3d(struct.origin + (0, 0, 48), "<dev string:x19c>" + var_d305c3c2de1b97a, (1, 1, 1), 1, 1, 1);

    print3d(struct.origin + (0, 0, 60), "<dev string:x1a9>" + total_score, (0, 1, 0), 1, 2, 1);

    waitframe();
  }
}

function get_veh_linked_structs() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = get_links();

    for(i = 0; i < linknames.size; i++) {
      structs = getStructArray(linknames[i], "script_linkname");

      if(structs.size > 0) {
        array = array_combine(array, structs);
      }
    }
  }

  return array;
}

function calc_best_closest_struct(last_struct, goal_struct, enabled_paths) {
  var_c409751f6400ecc2 = 1000000;
  var_a743d2bf021f5457 = 360;
  best_score = -50;
  closest_struct = undefined;
  bonus = 0.5;

  for(i = 0; i < enabled_paths.size; i++) {
    if(enabled_paths[i].origin == last_struct.origin) {
      last_struct = last_struct.previous_struct;
    }
  }

  var_d31a2ee982e4801c = -5;
  var_d2d5f9260f458419 = distance(goal_struct.origin, last_struct.origin);

  foreach(potential_struct in enabled_paths) {
    var_95a0d262b22644 = 5;
    var_26bf31ac98d0a5d4 = 5;
    var_e79809bd510fbd33 = 0;
    dot = undefined;
    score = -5;

    if(potential_struct == last_struct) {
      continue;
    }

    if(potential_struct.origin == last_struct.origin) {
      continue;
    }

    if(isDefined(last_struct.previous_struct) && last_struct.previous_struct.origin == potential_struct.origin) {
      continue;
    }

    if(isDefined(last_struct.antepenultimate_struct) && last_struct.antepenultimate_struct.origin == potential_struct.origin) {
      continue;
    }

    if(isDefined(potential_struct.script_noteworthy) && potential_struct.script_noteworthy == "deleteme" && potential_struct.origin != goal_struct.origin) {
      continue;
    }

    if(!istrue(self.allow_unload_on_path) && isDefined(potential_struct.script_unload) && potential_struct.origin != goal_struct.origin) {
      continue;
    }

    if(istrue(potential_struct.disabled)) {
      continue;
    }

    if(check_all_previous_in_pathing(potential_struct, 30)) {
      continue;
    }

    if(istrue(struct_is_personally_disabled(potential_struct))) {
      continue;
    }

    comp_distance = distance(last_struct.origin, potential_struct.origin);

    if(potential_struct.origin == goal_struct.origin && comp_distance > 1250) {
      continue;
    }

    comp_distance = distance(goal_struct.origin, potential_struct.origin);
    var_fb156017c7455904 = vectortoangles(goal_struct.origin - last_struct.origin);

    if(!isDefined(last_struct.angles)) {
      last_struct.angles = (0, 0, 0);
    }

    var_2c4faf696b6cfdca = math::get_dot(last_struct.origin, last_struct.angles, potential_struct.origin);
    var_2c4faf696b6cfdca = math::normalize_value(-0.5, 0.8, var_2c4faf696b6cfdca);
    var_d305c3c2de1b97a = math::get_dot(last_struct.origin, var_fb156017c7455904, potential_struct.origin);
    var_d305c3c2de1b97a = math::normalize_value(-0.8, 0.8, var_d305c3c2de1b97a);
    var_ae9ece2d695c9009 = math::normalize_value(0, 2000, comp_distance);
    var_ae9ece2d695c9009 = 1 - var_ae9ece2d695c9009;
    score = var_2c4faf696b6cfdca + var_d305c3c2de1b97a + var_ae9ece2d695c9009;

    if(var_2c4faf696b6cfdca < 0.25) {
      score -= 10;
    }

    if(false) {
      thread print_debug_info(potential_struct, var_d305c3c2de1b97a, var_2c4faf696b6cfdca, comp_distance, score, "find_closest_path_struct");
    }

    if(score > best_score) {
      closest_struct = potential_struct;
      best_score = score;
    }
  }

  if(isDefined(closest_struct)) {}

  return closest_struct;
}

function get_best_end_point(infil_name, unload_struct, dot_angles) {
  if(isDefined(unload_struct.script_linkto)) {
    linkto_structs = unload_struct get_veh_linked_structs();

    for(i = 0; i < linkto_structs.size; i++) {
      if(is_equal(level.ai_spawn_vehicle_func[infil_name].exit_points, linkto_structs[i].targetname)) {
        return linkto_structs[i];
      }
    }
  }

  var_2b008b868cc6c2f7 = getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname");
  best_dot = -5;
  var_14bb0bb2b7d418d7 = undefined;
  sorted_structs = get_array_of_closest(unload_struct.origin, var_2b008b868cc6c2f7, [unload_struct]);

  if(isDefined(unload_struct.angles)) {
    dot_angles = unload_struct.angles;
  }

  foreach(struct in sorted_structs) {
    dot = math::get_dot(unload_struct.origin, dot_angles, struct.origin);

    if(dot > best_dot) {
      if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
        thread draw_capsule(struct.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }

      best_dot = dot;
      var_14bb0bb2b7d418d7 = struct;
    }
  }

  return var_14bb0bb2b7d418d7;
}

function check_all_previous_in_pathing(potential_struct, limit) {
  if(!isDefined(self.pathing_array)) {
    return false;
  }

  if(!isDefined(limit)) {
    limit = self.pathing_array.size;
  }

  for(i = 0; i < limit; i++) {
    if(isDefined(self.pathing_array[i]) && self.pathing_array[i].origin == potential_struct.origin) {
      return true;
    }
  }

  return false;
}

function struct_is_personally_disabled(potential_struct) {
  if(!isDefined(self.disabled_nodes)) {
    return false;
  }

  for(k = self.disabled_nodes.size - 1; k >= 0; k--) {
    if(self.disabled_nodes[k].origin == potential_struct.origin) {
      return true;
    }
  }

  return false;
}

function step_back_to_last_good_branch(last_struct, goal_struct) {
  closest_struct = undefined;
  var_bf3b8c90fdeeb414 = undefined;
  var_df17d2e0402832da = [];
  var_f5641ed3c3b1543 = 0;

  for(i = self.pathing_array.size - 1; i >= 0; i--) {
    if(var_f5641ed3c3b1543 > 0) {
      break;
    }

    if(istrue(self.pathing_array[i].was_branch)) {
      linkedto = self.pathing_array[i] get_veh_linked_structs();

      for(j = 0; j < linkedto.size; j++) {
        if(is_this_a_valid_node(linkedto[j])) {
          var_df17d2e0402832da[var_df17d2e0402832da.size] = linkedto[j];
        }
      }

      if(var_df17d2e0402832da.size > 0) {
        if(var_df17d2e0402832da.size == 1) {
          best_struct = var_df17d2e0402832da[0];
        } else {
          best_struct = calc_best_closest_struct(last_struct, goal_struct, var_df17d2e0402832da);
        }

        var_f5641ed3c3b1543 = i;
        var_bf3b8c90fdeeb414 = best_struct;

        if(istrue(0)) {
          print3d(self.pathing_array[i].origin + (0, 0, -90), "<dev string:x1b1>" + var_df17d2e0402832da.size, (0, 1, 1), 1, 5, 999, 1);
          print3d(best_struct.origin + (0, 0, -90), "<dev string:x1bc>", (0, 1, 1), 1, 5, 999, 1);
        }

        break;
      } else {
        disable_this_node_for_us(self.pathing_array[i]);
      }

      continue;
    }

    disable_this_node_for_us(self.pathing_array[i]);
  }

  if(isDefined(last_struct.previous_struct)) {
    if(isDefined(var_bf3b8c90fdeeb414)) {
      closest_struct = var_bf3b8c90fdeeb414;

      if(isDefined(self.pathing_array[var_f5641ed3c3b1543 - 1])) {
        closest_struct.previous_struct = self.pathing_array[var_f5641ed3c3b1543 - 1];
      }

      if(isDefined(self.pathing_array[var_f5641ed3c3b1543 - 2])) {
        closest_struct.antepenultimate_struct = self.pathing_array[var_f5641ed3c3b1543 - 2];
      }
    } else {
      closest_struct = self.pathing_array[0];
    }

    if(isDefined(closest_struct)) {
      closest_struct.rewinding_path = 1;
    }
  }

  if(!isDefined(closest_struct)) {
    announcement("<dev string:x1c2>");
  }

  return closest_struct;
}

function is_this_a_valid_node(node) {
  if(istrue(node.disabled)) {
    return false;
  }

  for(k = self.pathing_array.size - 1; k >= 0; k--) {
    if(self.pathing_array[k].origin == node.origin) {
      return false;
    }
  }

  for(k = self.disabled_nodes.size - 1; k >= 0; k--) {
    if(self.disabled_nodes[k].origin == node.origin) {
      return false;
    }
  }

  return true;
}

function disable_this_node_for_us(node) {
  if(!isDefined(node)) {
    return;
  }

  if(!isDefined(self.disabled_nodes)) {
    self.disabled_nodes = [];
  }

  if(array_contains(self.disabled_nodes, node)) {
    return;
  }

  self.disabled_nodes[self.disabled_nodes.size] = node;

  if(istrue(0)) {
    print3d(node.origin + (0, 0, 15), "<dev string:x1db>", (1, 0, 0), 1, 5, 999, 1);
  }

  level notify("kill_debug_" + node.pathing_index);
  self.pathing_array = array_remove(self.pathing_array, node);
}

function create_direct_heli_path(infil_name) {
  self endon("death");
  path_start = create_direct_path_from_landing_point(infil_name);
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path_start);
}

function adjust_angles_for_heli_path(linkto_path, landing_point) {
  for(i = 0; i < linkto_path.size; i++) {
    j = i + 1;

    if(isDefined(linkto_path[j])) {
      angles = vectortoangles(linkto_path[j].origin - linkto_path[i].origin);
      linkto_path[i].angles = (0, angles[1], 0);
      continue;
    }

    angles = vectortoangles(landing_point.origin - linkto_path[i].origin);
    linkto_path[i].angles = (0, angles[1], 0);

    if(!isDefined(landing_point.angles) || landing_point.angles == (0, 0, 0)) {
      landing_point.angles = (0, angles[1], 0);
    }

    break;
  }
}

function create_direct_path_from_landing_point(infil_name) {
  new_kvp = create_unique_kvp_string();
  target_kvp = new_kvp;
  landing_point = duplicate_struct(self.spawn_point);
  landing_point.targetname = new_kvp;
  addtostructarray("targetname", landing_point.targetname, landing_point);
  linkto_path = [];

  if(isDefined(landing_point.script_linkto)) {
    linkto_path = landing_point build_path_from_script_linkTo(infil_name);
  }

  if(linkto_path.size > 0) {
    adjust_angles_for_heli_path(linkto_path, landing_point);
    new_goal_pos = self.spawn_point.origin;

    for(i = 0; i < self.riders.size; i++) {
      if(isalive(self.riders[i]) && isai(self.riders[i])) {
        self.riders[i] scripts\cp\spawning::set_goal_pos(new_goal_pos);
      }
    }

    if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
      thread draw_line_for_time(self.veh_spawn_point.origin, linkto_path[0].origin, 1, 1, 1, 60);
    }

    return linkto_path[0];
  }

  if(isDefined(landing_point.script_linkname)) {
    path_array = [];
    potential_paths = getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "script_linkname");

    if(!isDefined(potential_paths) || potential_paths.size < 1) {
      potential_paths = getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "targetname");
    }

    if(!isDefined(potential_paths) || potential_paths.size < 1) {
      return;
    }

    linkname = landing_point.script_linkname;

    for(i = 0; i < potential_paths.size; i++) {
      if(is_equal(potential_paths[i].script_linkto, linkname)) {
        temp_array = [];
        new_struct = duplicate_struct(potential_paths[i]);
        new_struct.target = target_kvp;
        addtostructarray("target", target_kvp, new_struct);
        new_struct.targetname = create_unique_kvp_string();
        addtostructarray("targetname", new_struct.targetname, new_struct);
        temp_array = new_struct get_linkto_structs_return_to_array(temp_array, potential_paths);

        if(temp_array.size > 0) {
          path_array[path_array.size] = temp_array;
        }
      }
    }

    if(path_array.size > 0) {
      return_array = [];

      for(i = 0; i < path_array.size; i++) {
        thread cleanup_unused_paths(path_array[i], path_array[i][path_array[i].size - 1]);
        return_array[return_array.size] = path_array[i][path_array[i].size - 1];

        if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
          thread draw_capsule(path_array[i][path_array[i].size - 1].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
        }
      }

      mid_point = math::get_mid_point(landing_point.origin, self.origin);

      if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
        thread draw_capsule(self.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread draw_capsule(self.spawn_point.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread draw_capsule(mid_point, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
      }

      var_4769a2cad76e31f = getclosest(mid_point, return_array);

      if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
        thread draw_line_for_time(var_4769a2cad76e31f.origin, self.origin, 1, 0, 0, 10);
      }

      if(isDefined(var_4769a2cad76e31f.target)) {
        target_array = var_4769a2cad76e31f get_target_array();

        for(i = 0; i < target_array.size; i++) {
          if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
            thread draw_line_for_time(var_4769a2cad76e31f.origin, target_array[i].origin, 1, 0, 0, 12.5);
            thread draw_capsule(target_array[i].origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
          }

          if(i >= target_array.size - 1) {
            if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
              thread draw_line_for_time(landing_point.origin, target_array[i].origin, 1, 0, 0, 12.5);
            }
          }
        }
      }

      if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
        thread draw_capsule(var_4769a2cad76e31f.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
      }

      var_4769a2cad76e31f notify("path_chosen");
      self notify("path_chosen");
      return var_4769a2cad76e31f;
    } else {
      path_array = [];
      var_4769a2cad76e31f = create_entrance_points(landing_point);

      if(isDefined(var_4769a2cad76e31f)) {
        var_4769a2cad76e31f.target = target_kvp;
        addtostructarray("target", target_kvp, var_4769a2cad76e31f);
        var_4769a2cad76e31f.targetname = create_unique_kvp_string();
        addtostructarray("targetname", var_4769a2cad76e31f.targetname, var_4769a2cad76e31f);

        if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
          thread draw_capsule(var_4769a2cad76e31f.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
          thread draw_capsule(landing_point.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        }

        return var_4769a2cad76e31f;
      } else {
        return landing_point;
      }
    }

    return;
  }

  return landing_point;
}

function allow_deleteme_on_path(infil_name) {
  if(isDefined(level.vehicle_builds[infil_name])) {
    return istrue(level.vehicle_builds[infil_name].allow_deleteme_path);
  }

  return 0;
}

function build_path_from_script_linkTo(infil_name) {
  linkto_path = [];
  links = get_links();
  last_struct = undefined;

  for(i = 0; i < links.size; i++) {
    linkto_string = links[i];
    linkto_structs = getStructArray(linkto_string, "script_linkname");

    if(isDefined(linkto_structs) && linkto_structs.size > 0) {
      linkto_structs = array_randomize(linkto_structs);

      for(j = 0; j < linkto_structs.size; j++) {
        linkto_struct = linkto_structs[j];

        if(is_equal(linkto_struct.targetname, "heli_spawner")) {
          continue;
        }

        if(!allow_deleteme_on_path(infil_name)) {
          if(is_equal(linkto_struct.script_noteworthy, "deleteme")) {
            continue;
          }
        }

        linkto_struct = duplicate_struct(linkto_struct);
        linkto_path[linkto_path.size] = linkto_struct;
        linkto_struct.targetname = create_unique_kvp_string();
        addtostructarray("targetname", linkto_struct.targetname, linkto_struct);

        if(isDefined(last_struct)) {
          if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
            thread draw_line_for_time(last_struct.origin, linkto_struct.origin, 1, 1, 1, 60);
          }

          last_struct.target = linkto_struct.targetname;
          addtostructarray("target", last_struct.target, last_struct);
        }

        last_struct = linkto_struct;
        break;
      }
    }
  }

  if(linkto_path.size > 0) {
    linkto_path[linkto_path.size - 1].target = self.targetname;
    addtostructarray("target", linkto_path[linkto_path.size - 1].target, linkto_path[linkto_path.size - 1]);

    if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
      thread draw_line_for_time(linkto_path[linkto_path.size - 1].origin, self.origin, 1, 1, 1, 60);
    }
  }

  return linkto_path;
}

function create_entrance_points(landing_point) {
  var_e2c3188febed52f5 = [];
  start_pos = landing_point.origin;

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (1500, 0, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (1500, 0, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (-1500, 0, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (-1500, 0, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (0, -1500, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (0, -1500, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (0, 1500, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (0, 1500, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (-1500, 1500, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (-1500, 1500, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (-1500, -1500, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (-1500, -1500, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (1500, -1500, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (1500, -1500, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(start_pos + (1500, 1500, 1500), start_pos, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = start_pos + (1500, 1500, 1500);
    var_e2c3188febed52f5[var_e2c3188febed52f5.size] = struct;
  }

  mid_point = math::get_mid_point(landing_point.origin, self.origin);

  if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
    thread draw_capsule(mid_point, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
  }

  var_4769a2cad76e31f = getclosest(mid_point, var_e2c3188febed52f5);

  for(i = 0; i < var_e2c3188febed52f5.size; i++) {
    if(var_e2c3188febed52f5[i] != var_4769a2cad76e31f) {
      if(getdvarint(@ "hash_610414ecdfe9549f", 0)) {
        thread draw_capsule(var_e2c3188febed52f5[i].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }
    }
  }

  return var_4769a2cad76e31f;
}

function get_linkto_structs_return_to_array(var_57d82443e81dbd5a, struct_array) {
  var_57d82443e81dbd5a[var_57d82443e81dbd5a.size] = self;

  if(isDefined(self.script_linkname)) {
    linkname = self.script_linkname;

    for(i = 0; i < struct_array.size; i++) {
      if(struct_array[i].origin == self.origin) {
        continue;
      }

      if(is_equal(struct_array[i].script_linkto, linkname)) {
        next_struct = duplicate_struct(struct_array[i]);
        next_struct.target = self.targetname;
        addtostructarray("target", next_struct.target, next_struct);
        next_struct.targetname = create_unique_kvp_string();
        addtostructarray("targetname", next_struct.targetname, next_struct);
        var_57d82443e81dbd5a[var_57d82443e81dbd5a.size] = next_struct;
        var_57d82443e81dbd5a = next_struct get_linkto_structs_return_to_array(var_57d82443e81dbd5a, struct_array);
      }
    }
  }

  return var_57d82443e81dbd5a;
}

function cleanup_unused_paths(path_array, var_4769a2cad76e31f) {
  var_4769a2cad76e31f endon("path_chosen");
  self waittill("path_chosen");

  for(i = 0; i < path_array.size; i++) {
    deletestruct_ref(path_array[i]);
  }
}

function create_heli_path(infil_name) {
  self.veh_path = [];
  counter = level.next_index;
  level.next_index++;
  var_5bda6f0ecaf2f49 = random(getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname"));
  end_point = duplicate_struct(var_5bda6f0ecaf2f49);
  self.end_point = end_point;
  thread begin_searching_for_landing_loc(undefined, infil_name, counter);
  thread_on_notify_no_endon_death("death", &reset_spawn_point_targetname, self.spawn_point, undefined, self);
}

function begin_searching_for_landing_loc(start_path, infil_name, counter) {
  level endon("game_ended");
  self endon("death");
  self notify("begin_searching_for_landing_loc");
  self endon("begin_searching_for_landing_loc");
  self endon("all_passengers_dead");
  var_b1b8b417f4009bfd = undefined;
  landing_point = undefined;
  exit_path = undefined;
  last_point = undefined;

  while(true) {
    valid_players = get_array_of_valid_players();

    if(!valid_players.size) {
      wait 1;
      continue;
    }

    point = get_center_point_of_array(valid_players);

    if(!isDefined(point)) {
      point = self.origin;
    }

    if(isDefined(self.spawn_point)) {
      if(isDefined(self.spawn_point)) {}

      var_8a69b1ccdc99bf9a = [self.spawn_point];
    } else {
      var_8a69b1ccdc99bf9a = sortbydistance(level.valid_air_vehicle_spawn_points, point);
    }

    var_b1b8b417f4009bfd = undefined;
    search_radius = 2048;

    for(i = 0; i < var_8a69b1ccdc99bf9a.size; i++) {
      landing_spot = var_8a69b1ccdc99bf9a[i];

      if(isDefined(landing_spot.radius) && landing_spot.radius > search_radius) {
        search_radius = int(landing_spot.radius);
      }

      if(distance2dsquared(landing_spot.origin, point) <= search_radius * search_radius) {
        var_b1b8b417f4009bfd = landing_spot;
        break;
      }
    }

    if(isDefined(var_b1b8b417f4009bfd)) {
      search_radius = 2048;

      if(isDefined(var_b1b8b417f4009bfd.radius) && var_b1b8b417f4009bfd.radius > search_radius) {
        search_radius = int(var_b1b8b417f4009bfd.radius);
      }

      if(distance2dsquared(var_b1b8b417f4009bfd.origin, self.origin) <= search_radius * search_radius) {
        level.valid_air_vehicle_spawn_points = array_remove(level.valid_air_vehicle_spawn_points, var_b1b8b417f4009bfd);
        landing_point = duplicate_struct(var_b1b8b417f4009bfd);

        if(!isDefined(var_b1b8b417f4009bfd.script_noteworthy)) {
          landing_point.targetname = "arrived_at_node_" + counter;
        } else {
          landing_point.targetname = var_b1b8b417f4009bfd.script_noteworthy;
        }

        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(landing_point);
        self.landing_spot = landing_point;
        nav_box = (150, 150, 150);

        if(infil_name == "lbravo_ai_infil") {
          nav_box = (90, 90, 90);
        }

        self.nav_obstacle = createnavobstaclebybounds(landing_point.origin, nav_box, (0, 0, 0), "axis");
        thread delete_nav_obstacle_on_death();
        break;
      } else {
        var_5c3edfd13b3c67f0 = array_remove_array(level.path_points[infil_name], level.invalid_path_points);

        if(isDefined(last_point)) {
          var_5c3edfd13b3c67f0 = array_remove(level.path_points[infil_name], last_point);
        }

        var_cd529f062f8821f0 = get_best_hover_point(point, var_5c3edfd13b3c67f0);

        if(isDefined(var_cd529f062f8821f0)) {
          hover_point = duplicate_struct(var_cd529f062f8821f0);

          if(!isDefined(var_cd529f062f8821f0.script_noteworthy)) {
            hover_point.script_noteworthy = "arrived_at_node_" + counter;
          } else {
            hover_point.script_noteworthy = var_cd529f062f8821f0.script_noteworthy;
          }

          hover_point.radius = 512;

          if(!isDefined(last_point) || var_cd529f062f8821f0 != last_point) {
            thread scripts\common\vehicle_paths::vehicle_paths_helicopter(hover_point);
          }

          last_point = var_cd529f062f8821f0;
          level.invalid_path_points[level.invalid_path_points.size] = var_cd529f062f8821f0;
          result = waittill_any_timeout_1(2.5, hover_point.script_noteworthy);

          if(result == "timeout") {
            last_point = undefined;
          }

          deletestruct_ref(hover_point);
          level.invalid_path_points = array_remove(level.invalid_path_points, var_cd529f062f8821f0);
        } else {
          wait 1;
        }
      }

      continue;
    }

    var_5c3edfd13b3c67f0 = array_remove_array(level.path_points[infil_name], level.invalid_path_points);

    if(isDefined(last_point)) {
      var_5c3edfd13b3c67f0 = array_remove(level.path_points[infil_name], last_point);
    }

    var_cd529f062f8821f0 = get_best_hover_point(point, var_5c3edfd13b3c67f0);

    if(isDefined(var_cd529f062f8821f0)) {
      hover_point = duplicate_struct(var_cd529f062f8821f0);

      if(!isDefined(var_cd529f062f8821f0.script_noteworthy)) {
        hover_point.script_noteworthy = "arrived_at_node_" + counter;
      } else {
        hover_point.script_noteworthy = var_cd529f062f8821f0.script_noteworthy;
      }

      hover_point.radius = 512;

      if(!isDefined(last_point) || var_cd529f062f8821f0 != last_point) {
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(hover_point);
      }

      last_point = var_cd529f062f8821f0;
      level.invalid_path_points[level.invalid_path_points.size] = var_cd529f062f8821f0;
      result = waittill_any_timeout_1(2.5, hover_point.script_noteworthy);

      if(result == "timeout") {
        last_point = undefined;
      }

      deletestruct_ref(hover_point);
      level.invalid_path_points = array_remove(level.invalid_path_points, var_cd529f062f8821f0);
      continue;
    }

    wait 1;
  }

  self waittill("unloaded");

  if(!array_contains(level.valid_air_vehicle_spawn_points, var_b1b8b417f4009bfd)) {
    level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = var_b1b8b417f4009bfd;
  }

  if(isDefined(landing_point)) {
    exit_path = get_exit_route(landing_point, infil_name + counter + "_start");
  }

  var_5bda6f0ecaf2f49 = random(getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname"));
  end_point = duplicate_struct(var_5bda6f0ecaf2f49);

  if(isDefined(landing_point) && isDefined(exit_path) && exit_path != landing_point) {
    add_targetname_kvps(exit_path, landing_point, infil_name + counter + "_exit_path");
    add_targetname_kvps(end_point, exit_path, infil_name + counter + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(exit_path);
  } else {
    add_targetname_kvps(end_point, landing_point, infil_name + counter + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(end_point);
  }

  delete_nav_obstacle();
}

function create_unique_kvp_string() {
  targetname_index = get_next_free_num();
  return "unique_KVP_" + targetname_index;
}

function get_next_free_num() {
  counter = level.next_index;
  level.next_index++;
  return counter;
}

function get_best_hover_point(point, var_5c3edfd13b3c67f0) {
  var_5c3edfd13b3c67f0 = sortbydistance(var_5c3edfd13b3c67f0, point);
  best_dot = -5;
  best_point = undefined;

  foreach(path_point in var_5c3edfd13b3c67f0) {
    dot = math::get_dot(self.origin, self.angles, path_point.origin);

    if(dot > 0) {
      return path_point;
    }
  }

  return best_point;
}

function get_exit_route(starting_struct, kvp_string) {
  current_struct = starting_struct;

  if(isDefined(current_struct.script_linkto)) {
    for(counter = 0; isDefined(current_struct.script_linkto); counter++) {
      exit_path = random(current_struct get_veh_linked_structs());
      exit_path = duplicate_struct(exit_path);
      add_targetname_kvps(exit_path, starting_struct, kvp_string + "_exit_route_" + counter);
      current_struct = exit_path;
    }
  }

  return current_struct;
}

function add_targetname_kvps(targetstruct, var_8862e77985bbe111, string_add) {
  if(isDefined(targetstruct)) {
    targetstruct.targetname = string_add;
    addtostructarray("targetname", string_add, targetstruct);

    if(isDefined(self.veh_path)) {
      self.veh_path[self.veh_path.size] = targetstruct;
    }
  }

  if(isDefined(var_8862e77985bbe111)) {
    var_8862e77985bbe111.target = string_add;
    addtostructarray("target", string_add, var_8862e77985bbe111);

    if(isDefined(self.veh_path)) {
      self.veh_path[self.veh_path.size] = var_8862e77985bbe111;
    }
  }
}

function duplicate_struct(original_struct) {
  struct = spawnStruct();
  struct.path_gobbler = 1;
  struct.origin = original_struct.origin;

  if(isDefined(original_struct.angles)) {
    struct.angles = original_struct.angles;
  } else {
    struct.angles = (0, 0, 0);
  }

  if(isDefined(original_struct.script_unload)) {
    struct.script_unload = original_struct.script_unload;
  }

  if(isDefined(original_struct.lookahead)) {
    struct.lookahead = original_struct.lookahead;
  }

  if(isDefined(original_struct.speed)) {
    struct.speed = original_struct.speed;
  } else {
    struct.speed = 2000;
  }

  if(isDefined(original_struct.start_node)) {
    struct.start_node = original_struct.start_node;
  }

  if(isDefined(original_struct.script_noteworthy)) {
    struct.script_noteworthy = original_struct.script_noteworthy;
  }

  if(isDefined(original_struct.script_linkname)) {
    struct.script_linkname = original_struct.script_linkname;
  }

  if(isDefined(original_struct.script_linkto)) {
    struct.script_linkto = original_struct.script_linkto;
  }

  if(isDefined(original_struct.script_brake)) {
    struct.script_brake = original_struct.script_brake;
  }

  if(isDefined(original_struct.script_pathtype)) {
    struct.script_pathtype = original_struct.script_pathtype;
  }

  if(isDefined(original_struct.script_goalyaw)) {
    struct.script_goalyaw = original_struct.script_goalyaw;
  }

  if(isDefined(original_struct.script_anglevehicle)) {
    struct.script_anglevehicle = original_struct.script_anglevehicle;
  }

  if(isDefined(original_struct.radius)) {
    struct.radius = original_struct.radius;
  } else {
    struct.radius = 512;
  }

  return struct;
}

function delete_nav_obstacle() {
  if(isDefined(self.nav_obstacle)) {
    destroynavobstacle(self.nav_obstacle);
  }

  if(isDefined(self.spawn_point)) {
    self.spawn_point scripts\cp\spawning::function_ec648f2c89ea1c91();
  }
}

function activate_vehicle_spawner(veh_spawn_point, spawn_point, vehicle, group) {
  if(isDefined(group)) {
    group.recently_spawned_vehicle = undefined;
  }

  enable_spawners = 1;

  if(isDefined(vehicle)) {
    if(vehicle get_vehicle_riders() < 1) {
      enable_spawners = 0;
    }
  }

  if(isDefined(veh_spawn_point)) {
    veh_spawn_point toggle_in_use(0);
  }

  if(isDefined(spawn_point)) {
    if(enable_spawners) {
      spawn_point scripts\cp\spawning::enable_spawner();
    } else if(isDefined(vehicle)) {
      vehicle enable_spawner_after_vehicle_death(spawn_point);
    }
  }

  reset_spawn_point_targetname(spawn_point);

  if(isDefined(vehicle)) {
    if(isDefined(vehicle.veh_spawn_point)) {
      vehicle.veh_spawn_point = undefined;
    }
  }
}

function enable_spawner_after_vehicle_death(spawn_point) {
  self waittill("death");
  spawn_point scripts\cp\spawning::enable_spawner();
}

function delete_nav_obstacle_on_death() {
  self waittill("death");
  delete_nav_obstacle();
}

function decrement_vehicles_active(infil_name, group) {
  self notify("decrement_vehicles_active");
  self endon("decrement_vehicles_active");
  level endon("game_ended");
  veh_spawn_point = self.veh_spawn_point;
  spawn_point = self.spawn_point;
  result = waittill_any_return_2("death", "unloaded");
  level delaythread(5, &activate_vehicle_spawner, veh_spawn_point, spawn_point, self, group);
  level.all_spawned_vehicles = array_remove(level.all_spawned_vehicles, self);
  level.ai_spawn_vehicle_func[infil_name].count--;

  if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup)) {
    target_array = getStructArray(self.veh_spawn_point.script_vehiclegroup, "targetname");

    foreach(other_struct in target_array) {
      other_struct.disabled = undefined;
    }
  }

  if(isDefined(self.veh_spawn_point)) {
    self.veh_spawn_point.in_use = undefined;
  }

  self.veh_spawn_point = undefined;
}

function reset_spawn_point_targetname(spawn_point) {
  if(!isDefined(spawn_point) && isDefined(self.spawn_point)) {
    spawn_point = self.spawn_point;
  }

  if(isDefined(spawn_point)) {
    spawn_point.ai_infil_type = undefined;

    if(isDefined(spawn_point.og_script_function)) {
      spawn_point.script_function = spawn_point.og_script_function;
    }

    spawn_point = undefined;
  }

  if(isDefined(self) && isDefined(self.veh_path)) {
    deletestructarray_ref(self.veh_path);
  }

  if(isDefined(self) && isDefined(self.pathing_array)) {
    deletestructarray_ref(self.pathing_array);
  }
}

function clear_kill_off_flags(guy) {
  if(istrue(guy.skip_clear_kill_off_flag)) {
    return;
  }

  guy.killofftime = gettime() + 20000;
  guy.dontkilloff = undefined;
  guy.canshootinvehicle = 1;
  guy.ignoreall = 0;

  if(isDefined(guy.vehicle) && isDefined(guy.vehicle.landing_spot)) {
    guy scripts\cp\spawning::node_fields_pre_goal(guy.vehicle.landing_spot);
  }

  if(isDefined(guy.demeanoroverride) && guy.demeanoroverride == "casual") {
    guy scripts\cp\spawning::set_demeanor_from_unittype("patrol");
    guy scripts\cp\spawning::set_goal_pos(guy.origin);
    guy thread scripts\cp\spawning::start_patrol();
    return;
  }

  guy scripts\cp\spawning::set_goal_pos(guy.origin);
  closest_player = guy get_closest_living_player();

  if(isDefined(closest_player)) {
    guy scripts\cp\spawning::set_goal_pos(closest_player.origin);
  }

  guy scripts\cp\spawning::enter_combat();
}

function get_invalid_seats_from_module_struct(module_struct, infil_name) {
  if(isDefined(module_struct) && isDefined(infil_name)) {
    if(!isDefined(module_struct.vehicle_invalid_seats)) {
      return;
    }

    if(!isDefined(module_struct.vehicle_invalid_seats[infil_name])) {
      return;
    }

    return module_struct.vehicle_invalid_seats[infil_name];
  }

  return undefined;
}

function get_valid_seats(module_struct, infil_name) {
  if(isDefined(module_struct) && isDefined(infil_name)) {
    invalid_seats = get_invalid_seats_from_module_struct(module_struct, infil_name);

    if(!isDefined(invalid_seats)) {
      invalid_seats = [];
    }

    for(i = 0; i < self.usedpositions.size; i++) {
      if(self.usedpositions[i]) {
        continue;
      }

      found_seat = 1;

      for(j = 0; j < invalid_seats.size; j++) {
        if(invalid_seats[j] == i) {
          found_seat = 0;
          break;
        }
      }

      if(found_seat) {
        return i;
      }
    }
  }

  return -1;
}

function send_notify_after_player_tac_vis(var_ff5ccede2521cb13) {
  if(isDefined(var_ff5ccede2521cb13)) {
    return;
  }

  while(true) {
    for(i = 0; i < level.players.size; i++) {
      if(hastacvis(level.players[i] getEye(), self.origin + (0, 0, 56))) {
        break;
      }
    }

    wait 0.1;
  }

  self notify(var_ff5ccede2521cb13);
}

function allow_infil_after_full_or_timeout(module_struct, infil_name) {
  self notify("allow_infil_after_full_or_timeout");
  self endon("allow_infil_after_full_or_timeout");
  self endon("death");
  self endon("spawning_done");
  level endon("game_ended");
  max_ai = get_max_ai_from_infil_name(module_struct, infil_name);

  if(isDefined(level.ai_spawn_vehicle_func[infil_name].max_wait_for_infil)) {
    waittill_any_timeout_1(level.ai_spawn_vehicle_func[infil_name].max_wait_for_infil, "stop_waiting_for_spawns");
  }

  if(isDefined(max_ai)) {
    if(self.attachedguys.size == max_ai || isDefined(self.load_queue) && self.load_queue.size == max_ai) {
      self notify("spawning_done");
      return;
    } else {
      childthread send_notify_after_player_tac_vis("spawning_done");

      if(isDefined(self.group)) {
        self.group waittill_any_timeout_1(3, "death");
      } else {
        wait 3;
      }

      self notify("spawning_done");
    }
  }

  if(isDefined(self.load_queue) && self.load_queue.size > 0) {
    self notify("spawning_done");
    return;
  }

  if(self.attachedguys.size < 1) {
    scripts\common\vehicle_code::vehicle_deathcleanup();
    scripts\common\vehicle_paths::delete_riders();
    self notify("delete");
    self delete();
    return;
  }

  self notify("spawning_done");
}

function register_combined_vehicles(var_c7813bd63c9ba2e4, model, type, classname, mp_vehiclename, alias, build_alias) {
  [[var_c7813bd63c9ba2e4]](model, type, classname);
  level thread register_combined_vehicles_threaded(var_c7813bd63c9ba2e4, model, type, classname, mp_vehiclename, alias, build_alias);
}

function register_combined_vehicles_threaded(var_c7813bd63c9ba2e4, model, type, classname, mp_vehiclename, alias, build_alias, spec_override) {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  register_vehicle_build(build_alias, model, type, classname, build_alias);
  struct = spawnStruct();
  copy_vehicle_build_to_spawnpoint(alias, struct);

  if(struct scripts\common\vehicle::ishelicopter()) {
    add_ai_air_infil(alias);
    register_vehicle_spawn(alias, 10, 10, undefined, "heli_spawner", "heli_exit", "heli_infil_path", undefined, &veh_heli_spawn, build_alias);
    register_spawner_script_function(alias, &function_64f6b6424352bc68);
  } else {
    add_ai_ground_infil(alias);
    register_vehicle_spawn(alias, 10, 10, undefined, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, build_alias);
    register_spawner_script_function(alias, &ai_ground_veh_spawn);
  }

  register_vehicle_max_ai(build_alias, model, type, classname, mp_vehiclename);
  vehicle_build = level.vehicle.templates.aianims[classname];
  var_3c435505038f3d9c = 0;

  for(i = 0; i < vehicle_build.size; i++) {
    if(isDefined(vehicle_build[i].idle_anim)) {
      var_3c435505038f3d9c++;
    }
  }

  if(var_3c435505038f3d9c > 0) {
    register_vehicle_spawn_drivers(alias, var_3c435505038f3d9c, random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  }

  if(isDefined(mp_vehiclename) && getdvarint(@ "hash_ca67d9f39e1dd86f", 0)) {
    create_mp_version_of_vehicle(mp_vehiclename, classname, build_alias);
  }

  level notify(alias);
}

function create_mp_version_of_vehicle(mp_vehiclename, classname, build_alias) {
  if(!isDefined(mp_vehiclename)) {
    return;
  }

  if(!isDefined(level.vehicle)) {
    return;
  }

  struct = level.vehicle_builds[build_alias];
  struct.vehiclename = build_alias;
  create_vehicle_vehicledata(mp_vehiclename, classname, build_alias);
  create_vehicle_occupancy_data(mp_vehiclename, classname, build_alias);
  create_vehicle_interact(mp_vehiclename, classname, build_alias);
  create_vehicle_omnvars_data(mp_vehiclename, classname, build_alias);
}

function create_vehicle_interact(mp_vehiclename, classname, build_alias) {
  if(!isDefined(level.vehicle.interact)) {
    return;
  }

  if(!isDefined(level.vehicle.interact.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.interact.vehicledata[mp_vehiclename]) && !isDefined(level.vehicle.interact.vehicledata[build_alias])) {
    if(isDefined(level.vehicle.templates.aianims[classname])) {
      leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(build_alias, 1);

      for(i = 0; i < level.vehicle.templates.aianims[classname].size; i++) {
        struct = level.vehicle.templates.aianims[classname][i];
        sittag = tolower(struct.sittag);
        leveldataforvehicle.seatenterarrays[sittag] = [];
        leveldataforvehicle.seatenterarrays[sittag][leveldataforvehicle.seatenterarrays[sittag].size] = sittag;
        leveldataforseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(build_alias, sittag, 1);

        if(i == 0) {
          var_7432b7fb4c69781f = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(build_alias, 1);
          var_7432b7fb4c69781f.driverseatid = sittag;
        }
      }

      level.vehicle.interact.vehicledata[build_alias] = leveldataforvehicle;
    }
  }
}

function create_vehicle_vehicledata(mp_vehiclename, classname, build_alias) {
  if(!isDefined(level.vehicle.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.vehicledata[mp_vehiclename]) && !isDefined(level.vehicle.vehicledata[build_alias])) {
    leveldataforvehicle = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(build_alias);
    leveldataforvehicle.destroycallback = level.vehicle.vehicledata[mp_vehiclename].destroycallback;
    level.vehicle.vehicledata[build_alias] = leveldataforvehicle;
  }
}

function create_vehicle_omnvars_data(mp_vehiclename, classname, build_alias) {
  if(!isDefined(level.vehicle.omnvars.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.omnvars.vehicledata[mp_vehiclename]) && !isDefined(level.vehicle.omnvars.vehicledata[build_alias])) {
    leveldataforvehicle = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle(build_alias, 1);
    var_ee8a4198ec7e827c = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle(mp_vehiclename);
    leveldataforvehicle.ammoids = var_ee8a4198ec7e827c.ammoids;
    leveldataforvehicle.id = var_ee8a4198ec7e827c.id;
    leveldataforvehicle.rotationids = var_ee8a4198ec7e827c.rotationids;
    leveldataforvehicle.seatids = var_ee8a4198ec7e827c.seatids;
    leveldataforvehicle.warningbits = var_ee8a4198ec7e827c.warningbits;
    leveldataforvehicle.warningclearcallbacks = var_ee8a4198ec7e827c.warningclearcallbacks;
    leveldataforvehicle.warningendcallbacks = var_ee8a4198ec7e827c.warningendcallbacks;
    leveldataforvehicle.warningstartcallbacks = var_ee8a4198ec7e827c.warningstartcallbacks;
    level.vehicle.omnvars.vehicledata[build_alias] = leveldataforvehicle;
  }
}

function create_seatids_override(build_alias, seatids) {
  if(!isDefined(level.vehicle.omnvars.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.omnvars.vehicledata[build_alias])) {
    leveldataforvehicle = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle(build_alias, 1);
    var_7432b7fb4c69781f = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(build_alias);
    leveldataforvehicle.seatids = [];
    keys = getarraykeys(var_7432b7fb4c69781f.seatdata);

    for(i = 0; i < keys.size; i++) {
      leveldataforvehicle.seatids[keys[i]] = seatids[i];
    }

    level.vehicle.omnvars.vehicledata[build_alias] = leveldataforvehicle;
  }
}

function create_vehicle_occupancy_data(mp_vehiclename, classname, build_alias) {
  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.occupancy.vehicledata[mp_vehiclename]) && !isDefined(level.vehicle.occupancy.vehicledata[build_alias])) {
    leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(build_alias, 1);
    leveldataforvehicle.camera = level.vehicle.occupancy.vehicledata[mp_vehiclename].camera;
    leveldataforvehicle.damagefeedbackgroupheavy = level.vehicle.occupancy.vehicledata[mp_vehiclename].damagefeedbackgroupheavy;
    leveldataforvehicle.damagefeedbackgrouplight = level.vehicle.occupancy.vehicledata[mp_vehiclename].damagefeedbackgrouplight;
    leveldataforvehicle.damagemodifier = level.vehicle.occupancy.vehicledata[mp_vehiclename].damagemodifier;
    leveldataforvehicle.enterendcallback = level.vehicle.occupancy.vehicledata[mp_vehiclename].enterendcallback;
    leveldataforvehicle.enterstartcallback = level.vehicle.occupancy.vehicledata[mp_vehiclename].enterstartcallback;
    leveldataforvehicle.exitdirections = level.vehicle.occupancy.vehicledata[mp_vehiclename].exitdirections;
    leveldataforvehicle.exitendcallback = level.vehicle.occupancy.vehicledata[mp_vehiclename].exitendcallback;
    leveldataforvehicle.exitextents = level.vehicle.occupancy.vehicledata[mp_vehiclename].exitextents;
    leveldataforvehicle.exitoffsets = level.vehicle.occupancy.vehicledata[mp_vehiclename].exitoffsets;
    leveldataforvehicle.exitstartcallback = level.vehicle.occupancy.vehicledata[mp_vehiclename].exitstartcallback;
    leveldataforvehicle.restrictions = level.vehicle.occupancy.vehicledata[mp_vehiclename].restrictions;
    leveldataforvehicle.threatbiasgroup = level.vehicle.occupancy.vehicledata[mp_vehiclename].threatbiasgroup;
    level.vehicle.occupancy.vehicledata[build_alias] = leveldataforvehicle;
  }
}

function register_seat_data_for_vehicle(build_alias, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority) {
  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }

  if(!isDefined(!isDefined(level.vehicle.occupancy.vehicledata[build_alias]))) {
    return;
  }

  register_seat_data(build_alias, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority);
}

function register_seat_data(build_alias, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority) {
  leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(build_alias, 1);
  leveldataforseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(build_alias, seatid, 1);
  leveldataforseat.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(seatid, seatswitcharray);
  leveldataforseat.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  leveldataforseat.damagemodifier = 0.5;
  leveldataforseat.animtag = animtag;
  leveldataforseat.exitids = exitids;
  leveldataforvehicle.exitoffsets[seatid] = exitoffsets;
  leveldataforvehicle.exitdirections[seatid] = exitdirections;
  leveldataforseat.spawnpriority = 10;
}

function register_techo_seat_data(build_alias) {
  seatswitcharray = ["tag_driver", "tag_passenger", "tag_bed1", "tag_bed2", "tag_bed_center"];
  var_f079ddd1216d5051 = ["tag_seat_0", "tag_seat_2", "tag_seat_4", "tag_seat_4", "tag_seat_4", "tag_seat_3", "tag_seat_5"];
  var_f29d65b6397ba222 = seatswitcharray;
  exitids = [];
  exitoffsets = (5, 14, 55);
  exitdirections = "left";
  spawnpriority = 10;

  if(isDefined(level.vehicle.interact.vehicledata[build_alias]) && isDefined(isDefined(level.vehicle.interact.vehicledata[build_alias].seatenterarrays))) {
    keys = getarraykeys(level.vehicle.interact.vehicledata[build_alias].seatenterarrays);

    for(i = 0; i < level.vehicle.interact.vehicledata[build_alias].seatenterarrays.size; i++) {
      seatid = keys[i];
      exitids = array_add(var_f29d65b6397ba222, seatid);
      register_seat_data_for_vehicle(build_alias, seatid, seatswitcharray, var_f079ddd1216d5051[i], exitids, exitoffsets, exitdirections, spawnpriority);
    }
  }
}

function function_b7229e2dcb171037(positions) {
  return function_7e79f1b51303070f(positions);
}

#using_animtree("mp_vehicles_always_loaded");

function function_7e79f1b51303070f(positions) {
  for(i = 0; i < positions.size; i++) {
    positions[i].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return positions;
}

function vehicle_registrations(lbravo, blima, mindia8) {
  level.var_b7229e2dcb171037 = [];
  level.var_b7229e2dcb171037["blima"] = &function_b7229e2dcb171037;

  if(isDefined(level.vehicle_registration_func)) {
    [[level.vehicle_registration_func]]();
  }
}

function setup_player_vehicles(player, playername, ip1) {
  dash = "-";
  ampersand = "&";
  underscore = "_";
  keys = getarraykeys(level.var_a0b2c978ca57ffc5);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    name = key;

    if(string_starts_with(key, "veh9")) {
      name = getsubstr(name, 5, key.size);
    }

    cmd = "devgui_cmd \"CP Players:2 / " + playername + " / Spawn Vehicle / " + name + "\" \"set scr_vehicle_debug Spawn" + underscore + dash + ip1 + dash + ampersand + key + "\" \n";
    addentrytodevgui(cmd);
  }
}

function cp_vehicle_debug(itemref) {
  items = strtok(itemref, "_");
  playertoks = strtok(itemref, "-");
  params = strtok(itemref, "&");
  player = undefined;

  if(playertoks.size > 0) {
    playerint = int(playertoks[0]);
    player = level.players[playerint];
  }

  switch (items[0]) {
    case #"hash_819aac6f5ae2fb78":
    case #"hash_b5c4035792ad20d8":
      if(isDefined(params) && params.size > 1) {
        script_func(params[1], player);
      }

      break;
    default:
      break;
  }

  if(isDefined(player)) {
    player thread scripts\cp_mp\vehicles\vehicle::spawnplayerinvehicle(params[1]);
  }
}

function spawn_enemy_chopper(group, spawn_point, infil_name) {
  data_struct = level.ai_spawn_vehicle_func[infil_name];
  var_1317c822798f0c26 = data_struct get_vehicle_spawn_points(spawn_point);

  if(isDefined(level.attack_heli)) {
    return false;
  }

  if(var_1317c822798f0c26.size > 0) {
    foreach(veh_spawn_point in var_1317c822798f0c26) {
      if(istrue(veh_spawn_point.in_use)) {
        continue;
      }

      copy_vehicle_build_to_spawnpoint(infil_name, veh_spawn_point);
      angle_ref = vectortoangles(spawn_point.origin - veh_spawn_point.origin);
      veh_spawn_point.angles = (0, angle_ref[1], 0);
      helicopter = scripts\common\vehicle::vehicle_spawn(veh_spawn_point);

      if(isDefined(helicopter)) {
        veh_spawn_point.in_use = 1;
        level.attack_heli = helicopter;
        helicopter init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name);
        group.vehicle = undefined;
        spawn_point.vehicle = undefined;
        spawn_point.veh_spawn_point = undefined;
        group.recently_spawned_vehicle = undefined;
        helicopter init_helicopter(group, infil_name);
        helicopter.vehicle_forcerocketdeath = undefined;
        helicopter.death_fx_on_self = 1;
        helicopter.circle_radius = 2500;
        helicopter scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret");
        helicopter thread scripts\cp\helicopter\cp_helicopter::setup_pilot(1, undefined, undefined, undefined);
        helicopter setmaxpitchroll(15, 15);
        helicopter.health_remaining = 2250;
        level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(helicopter);
        helicopter sethoverparams(25, 15, 10);
        helicopter.headicon = createheadicon(helicopter);
        setheadiconimage(helicopter.headicon, "hud_icon_head_equipment_enemy");
        setheadiconmaxdistance(helicopter.headicon, 12000);
        setheadiconnaturaldistance(helicopter.headicon, 1500);
        setheadiconzoffset(helicopter.headicon, 10);
        setheadiconsnaptoedges(helicopter.headicon, 1);
        helicopter.bullets_can_damage = 1;
        helicopter.needs_to_evade = 0;
        level thread vo_boss_heli();
      }
    }
  }

  return false;
}

function vo_boss_heli() {
  snds = ["dx_cps_kama_callout_helicopter_attacking_10", "dx_cps_kama_callout_helicopter_attacking_20", "dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20"];
  level scripts\cp\vo::try_to_play_vo_on_team(random(snds), "allies");
}

function set_cp_vehicle_health_values(health) {
  if(isDefined(self.healthbuffer)) {
    self.health = self.healthbuffer + health;
    self.maxhealth = self.health;
    return;
  }

  self.health = health;
  self.maxhealth = self.health;
}

function init_helicopter(group, infil_name) {
  self.isheli = 1;
  self.borntime = gettime();

  switch (infil_name) {
    case #"hash_3ac34cdad8041c36":
    case #"hash_4f1ed711fc7ee2e7":
    case #"hash_6293ed64b1ab6691":
    case #"hash_68cb10ac5667e070":
      set_cp_vehicle_health_values(5000);
      break;
    case #"hash_6fbd504f237f8a9e":
      set_cp_vehicle_health_values(50000);
      break;
    default:
      set_cp_vehicle_health_values(1250);
      break;
  }

  thread damage_players_on_top();
  self.team = "axis";

  if(isDefined(self.script_team)) {
    self.team = self.script_team;
  }

  self setvehicleteam(self.team);

  if(isDefined(infil_name) && infil_name == "lbravo_carrier") {
    thread landing_damage_watcher();
  }

  if(self.team == "axis") {
    level thread scripts\cp\weapon::add_to_special_lockon_target_list(self);
    thread helicopter_death_lockon_clear();
  }

  self.dontdisconnectpaths = 1;
  self.vehicle_forcerocketdeath = 1;
  self.death_fx_on_self = 1;
  function_82a45e8aef44ce3f(&function_30a6caeaaa14c934);

  if(isDefined(infil_name)) {
    level.ai_spawn_vehicle_func[infil_name].count++;

    if(isDefined(group)) {
      scripts\cp\spawning::add_to_module_vehicles_list(group, infil_name);
    }
  }

  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

function function_30a6caeaaa14c934(attacker, meansofdeath, weaponobject) {
  if(istrue(self.nocrash)) {
    thread scripts\cp\helicopter\cp_helicopter::mid_air_explode(attacker);
  } else {
    thread scripts\cp\helicopter\cp_helicopter::do_heli_crash(attacker);
  }

  return true;
}

function helicopter_death_lockon_clear() {
  level endon("game_ended");
  waittill_any_2("death", "deleting_vehicle");
  level thread scripts\cp\weapon::remove_from_special_lockon_target_list(self);
}

function damage_players_on_top() {
  self endon("death");

  while(true) {
    players_near = utility::playersnear(self.origin, 256);

    for(i = 0; i < players_near.size; i++) {
      if(players_near[i].origin[2] > self.origin[2]) {
        if(players_near[i].origin[2] - self.origin[2] <= 32 && players_near[i] isonground()) {
          players_near[i] dodamage(players_near[i].health + 1000, self.origin, self, self, "MOD_CRUSH");
        }
      }
    }

    wait 0.25;
  }
}

function landing_damage_watcher() {
  self endon("death");
  self endon("unloaded");
  self notify("landing_damage_watcher");
  self endon("landing_damage_watcher");
  var_c03a5e83336294f5 = 256;
  var_5bef124e5f705d27 = 80;
  var_953d4a8f21434378 = 36;

  while(isDefined(self)) {
    if(isDefined(self.borntime) && gettime() - self.borntime < 5000) {
      wait 0.05;
      continue;
    }

    var_60c02c698578edb = self.origin + (0, 0, -140) + anglesToForward(self.angles) * 24;

    if(self.team == "axis") {
      foreach(player in level.players) {
        if(isDefined(player) && isalive(player) && is_point_in_cylinder(player.origin, var_60c02c698578edb, var_5bef124e5f705d27, var_953d4a8f21434378)) {
          player dodamage(player.health + 1000, self.origin, self, self, "MOD_CRUSH");
        }
      }
    }

    vehicles = vehicle_getarrayinradius(var_60c02c698578edb - (0, 0, 200), 400, 400);

    if(!isDefined(vehicles) || vehicles.size == 0) {
      wait 0.25;
      continue;
    }

    vehicles = sortbydistance(vehicles, self.origin);
    var_494e292fc76002c5 = undefined;

    for(i = 0; i < vehicles.size; i++) {
      vehicle = vehicles[i];

      if(!isDefined(vehicle) || vehicle == self) {
        continue;
      }

      if(vehicle vehicle_getspeed() > 1) {
        continue;
      }

      if(isent(vehicle) && is_point_in_cylinder(vehicle.origin, var_60c02c698578edb, var_c03a5e83336294f5 * 1.5, var_953d4a8f21434378)) {
        var_494e292fc76002c5 = vehicle;
        break;
      }
    }

    if(!isDefined(var_494e292fc76002c5)) {
      wait 0.05;
      continue;
    }

    ent = var_494e292fc76002c5;
    var_cb874df7c9e9edfc = 0;

    if(isDefined(ent.vehiclename) && ent.vehiclename == "little_bird") {
      var_cb874df7c9e9edfc = 1;
    }

    if(isDefined(ent.vehiclename) && ent.vehiclename == "little_bird_mg") {
      var_cb874df7c9e9edfc = 1;
    }

    if(isDefined(ent.infil_name) && ent.infil_name == "lbravo_carrier") {
      var_cb874df7c9e9edfc = 1;
    }

    if(isDefined(self.owner) && isPlayer(self.owner) && isDefined(ent.owner) && isPlayer(ent.owner)) {
      var_cb874df7c9e9edfc = 0;
    }

    if(is_helicopter_player_occupied() && ent is_helicopter_player_occupied()) {
      var_cb874df7c9e9edfc = 0;
    }

    if(var_cb874df7c9e9edfc) {
      dmg = ent.health + 1000;
      ent notify("landing_collision_damage", dmg, self);
      ent.disableheavystatedamagefloor = 1;
      ent dodamage(dmg, self.origin, undefined, undefined, "MOD_CRUSH");
    }

    wait 0.05;
  }
}

function is_point_in_cylinder(point, cylinder_org, cylinder_radius, cylinder_height) {
  if(distance_2d_squared(point, cylinder_org) > squared(cylinder_radius)) {
    return false;
  }

  if(point[2] < cylinder_org[2]) {
    return false;
  }

  if(point[2] > cylinder_org[2] + cylinder_height) {
    return false;
  }

  return true;
}

function is_helicopter_player_occupied() {
  if(isDefined(self.owner) && isPlayer(self.owner)) {
    return true;
  }

  if(isDefined(self.occupants)) {
    foreach(occupant in self.occupants) {
      if(isDefined(occupant) && isPlayer(occupant) && isalive(occupant)) {
        return true;
      }
    }
  }

  return false;
}

function init_ground_vehicle(group, infil_name) {
  switch (infil_name) {
    case #"hash_f80baf80c1494495":
      self.looping_path = 1;
      set_cp_vehicle_health_values(2500);
      break;
    case #"hash_36a654665ed22fb8":
    case #"hash_74a4c28ebce1f6c8":
    case #"hash_ed0943d77ef90562":
    case #"hash_f60027ccb20dde63":
      set_cp_vehicle_health_values(2500);
      break;
    default:
      set_cp_vehicle_health_values(1250);
      break;
  }

  self.vehicle_skipdeathcrash = 1;
  self.team = "axis";
  self setvehicleteam(self.team);

  if(isDefined(infil_name)) {
    level.ai_spawn_vehicle_func[infil_name].count++;

    if(isDefined(group)) {
      scripts\cp\spawning::add_to_module_vehicles_list(group, infil_name);
    }
  }

  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

function heli_think_default() {
  thread heli_damagemonitor();
  thread heli_check_players();
  thread heli_move();
  thread engage_target_think();
  thread rumble_nearby_players();
}

function heli_damagemonitor(var_227a4202bbfa2f79, starting_health) {
  self endon("death");
  snipes = 0;
  self.health = 1000000;

  if(!isDefined(starting_health)) {
    starting_health = 2500;
  }

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.health = 1000000;

    if(isDefined(attacker) && attacker == self) {
      continue;
    }

    if(isDefined(inflictor) && isDefined(inflictor.owner) && inflictor.owner == self) {
      continue;
    }

    if(isDefined(attacker) && isDefined(self.minigun) && attacker == self.minigun) {
      continue;
    }

    if(scripts\cp\helicopter\cp_helicopter::is_snipe_kill(attacker, dmgpoint, objweapon)) {
      snipes++;

      if(snipes == 1) {
        if(isDefined(self.headicon)) {
          deleteheadicon(self.headicon);
        }

        self.headicon = undefined;
        eventinfo = spawnStruct();
        eventinfo.isdestroyedkillstreak = 1;
        attacker thread scripts\cp\points::doscoreevent(#"hash_f88a0d21a577aa90", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo);
        attacker scripts\cp\persistence::give_player_currency(500, "large");
        playFX(level._effect["vfx_blima_explosion"], self.origin);
        attacker scripts\cp\damagefeedback::updatedamagefeedback("hitcritical", 1);
        level.all_spawned_vehicles = array_remove(level.all_spawned_vehicles, self);
        self.minigun delete();

        if(isDefined(self.pilot)) {
          self.pilot delete();
        }

        self notify("deleting_vehicle");
        self delete();
        return;
      }

      attacker.lasthitmarkertime = undefined;
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      attacker.lasthitmarkertime = undefined;
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitarmorheavy");
    } else {
      attacker.lasthitmarkertime = undefined;
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(objweapon) && isDefined(objweapon.basename)) {
        switch (objweapon.basename) {
          case #"hash_f59a8f678401aee2":
            break;
          case #"hash_c7ce3f77814f7950":
            amount = 1400;
            break;
          default:
            break;
        }
      } else if(amount < 700) {
        amount = 700;
      }

      if(isDefined(var_227a4202bbfa2f79) && flag_exist(var_227a4202bbfa2f79) && !flag(var_227a4202bbfa2f79)) {
        flag_set(var_227a4202bbfa2f79);
      } else {
        if(!istrue(self.needs_to_evade)) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining -= amount;

    if(self.health_remaining <= starting_health * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx = 1;
    } else if(self.health_remaining <= starting_health * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= starting_health * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon)) {
        deleteheadicon(self.headicon);
      }

      self.headicon = undefined;

      if(isDefined(attacker) && isPlayer(attacker)) {
        eventinfo = spawnStruct();
        eventinfo.isdestroyedkillstreak = 1;
        attacker thread scripts\cp\points::doscoreevent(#"hash_f88a0d21a577aa90", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo);
        attacker scripts\cp\persistence::give_player_currency(500, "large");
      }

      playFX(level._effect["vfx_blima_explosion"], self.origin);
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitcritical", 1);
      level.all_spawned_vehicles = array_remove(level.all_spawned_vehicles, self);
      self.minigun delete();

      if(isDefined(self.pilot)) {
        self.pilot delete();
      }

      self notify("deleting_vehicle");
      self delete();
      continue;
    }

    if(isDefined(attacker) && isPlayer(attacker)) {
      attacker scripts\cp\persistence::give_player_currency(10, "large");
    }
  }
}

function create_rocket_death_fx(classname) {
  level.vtclassname = classname;
}

function get_helicopter_path_positions(target_player) {
  self.path_positions = [];
  slices = 12;
  dist = 2048;
  angle_frac = 360 / slices;
  pos = self.origin;
  self.flight_pos = undefined;
  self.flight_pos_dot = undefined;

  if(isDefined(target_player)) {
    if(isvector(target_player)) {
      targetpos = target_player;
    } else {
      targetpos = target_player.origin;
    }
  } else {
    targetpos = get_center_point_of_array(level.players);
  }

  for(i = 0; i < slices; i++) {
    angle = angle_frac * i;
    xadd = cos(angle) * dist;
    yadd = sin(angle) * dist;
    x = pos[0] + xadd;
    y = pos[1] + yadd;
    z = pos[2];

    if(validate_pos((x, y, z), targetpos)) {
      self.path_positions[self.path_positions.size] = (x, y, z);
    }
  }
}

function validate_pos(targetpos, valid_target) {
  if(isDefined(valid_target)) {
    targetpos = (targetpos[0], targetpos[1], valid_target[2] + 1500);
  }

  if(isDefined(level.heli_triggers) && level.heli_triggers.size > 0) {
    temp_array = level.heli_triggers;

    for(t = 0; t < temp_array.size; t++) {
      if(!isDefined(temp_array[t])) {
        level.heli_triggers = array_remove(level.heli_triggers, temp_array[t]);
        continue;
      }

      if(isDefined(self.move_trigger) && self.move_trigger == temp_array[t]) {
        continue;
      }

      if(ispointinvolume(targetpos, temp_array[t])) {
        return 0;
      }
    }
  }

  if(scripts\engine\trace::capsule_trace_passed(self.origin, targetpos, 256, 512, self.angles, self)) {
    if(isDefined(valid_target)) {
      to_point = targetpos - self.origin;

      if(isvector(valid_target)) {
        var_4fe25eaeba81ec3 = vectortoangles(valid_target - self.origin);
      } else if(isDefined(valid_target.velo_forward)) {
        var_4fe25eaeba81ec3 = vectortoangles(valid_target.velo_forward - self.origin);
      } else {
        var_4fe25eaeba81ec3 = vectortoangles(valid_target.origin - self.origin);
      }

      forward = anglesToForward(var_4fe25eaeba81ec3);
      dot = vectordot(to_point, forward);

      if(isDefined(self.flight_pos)) {
        if(dot > self.flight_pos_dot) {
          self.flight_pos_dot = dot;
          self.flight_pos = targetpos;
        }
      } else {
        self.flight_pos_dot = dot;
        self.flight_pos = targetpos;
      }

      if(dot > 0.3) {
        return 1;
      } else {
        return 0;
      }
    } else if(math::is_point_in_front(targetpos)) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function heli_move() {
  level endon("game_ended");
  self endon("death");
  chopper_height = self.origin[2];
  self.chopper_height = chopper_height;
  targettimeout = 0;
  timeout = 5;
  self vehicle_setspeed(75, 30);

  while(true) {
    if(istrue(self.needs_to_evade)) {
      heli_evade((self.origin[0], self.origin[1], self.chopper_height));
      continue;
    }

    if(!isDefined(self.best_target)) {
      heli_go_search();
      continue;
    }

    if(should_move_to_target(self.minigun, self.best_target)) {
      heli_move_to_target(self.best_target);
      continue;
    }

    wait 1;
  }
}

function should_move_to_target(dist_ent, target) {
  var_47c3d9295106d6d0 = 6250000;

  if(isDefined(self.should_move_to_target_dist)) {
    var_47c3d9295106d6d0 = self.should_move_to_target_dist * self.should_move_to_target_dist;
  }

  if(istrue(self.landed)) {
    self.landed = undefined;
    return true;
  }

  if(distance2dsquared(dist_ent.origin, target.origin) > var_47c3d9295106d6d0 || isDefined(self.gotopos) && distance2dsquared(dist_ent.origin, self.gotopos) > var_47c3d9295106d6d0) {
    return true;
  }

  return false;
}

function heli_move_to_target(target) {
  self endon("death");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(target);

  if(isDefined(self.best_target)) {
    get_helicopter_path_positions(self.best_target);
  } else {
    get_helicopter_path_positions();
  }

  origin = undefined;

  if(isDefined(self.flight_pos)) {
    origin = self.flight_pos;
  } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
    origin = random(self.path_positions);
  }

  if(isDefined(origin)) {
    self setneargoalnotifydist(750);

    if(distance2dsquared(self.origin, origin) > 1440000) {
      self vehicle_setspeed(50, 30, 30);
      self setvehgoalpos(origin, 1);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(origin, 0);
    }

    waittill_any_timeout_1(15, "near_goal");
  }

  wait 5;
}

function heli_evade(target) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  rad = 5000;
  get_helicopter_path_positions();
  points = self.path_positions;

  if(isDefined(points) && points.size > 0) {
    start_index = 0;
    start_point = points[0];
    self cleargoalyaw();
    self cleartargetyaw();
    self clearlookatent();

    foreach(index, point in points) {
      if(isvector(point)) {
        end_pos = point;
      } else {
        end_pos = point.origin;
      }

      if(within_fov(self.origin, self.angles, end_pos, cos(25))) {
        start_point = point;
        start_index = index;
        break;
      }
    }

    if(isvector(points[start_index])) {
      self setvehgoalpos(points[start_index], 0);
    } else {
      self setvehgoalpos(points[start_index].origin, 0);
    }

    notify_dist = 1500;
    notify_dist *= rad / 5000;
    heli_speed = 100;
    heli_speed *= rad / 5000;
    self setneargoalnotifydist(1500);
    self vehicle_setspeed(100, 50, 50);
    numpoints = 0;
    index = start_index + 1;
    random_num = randomint(4);

    while(numpoints < points.size - 1) {
      if(index >= points.size) {
        index = 0;
      }

      if(isvector(points[index])) {
        self setvehgoalpos(points[index], 0);
      } else {
        self setvehgoalpos(points[index].origin, 0);
      }

      self waittill("near_goal");
      numpoints++;
      index++;

      if(numpoints == random_num) {
        break;
      }
    }
  }

  self.needs_to_evade = 0;
}

function rumble_nearby_players() {
  self endon("death");

  while(true) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.1;
  }
}

function heli_check_players() {
  self endon("death");
  self.best_target = undefined;
  reacquire_timer = 5;
  reacquire_counter = 0;

  while(true) {
    valid_target = heli_get_target();

    if(isDefined(valid_target)) {
      reacquire_counter = 0;
      self notify("target_found");
      self.best_target = valid_target;
    } else {
      self notify("target_lost");
      reacquire_counter += 0.25;

      if(reacquire_counter >= reacquire_timer) {
        reacquire_counter = 0;
        self.best_target = undefined;
      }
    }

    wait 0.25;
  }
}

function engage_target_think() {
  level endon("game_ended");
  self notify("engage_target_think");
  self endon("engage_target_think");
  self endon("death");
  self.minigun setmode("manual");
  self.nextfiretime = gettime() + 2000;

  while(true) {
    while(isDefined(self.best_target)) {
      self sethoverparams(150, 35, 35);

      if(istrue(self.has_rockets)) {
        wait 2;

        if(istrue(self.rockets_ready)) {
          scripts\cp\helicopter\cp_helicopter::hover_and_shoot_rockets(self.best_target);
        }
      } else {
        self.minigun settargetentity(self.best_target, (0, 0, 40));
        result = waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
        scripts\cp\helicopter\cp_helicopter::shoot_at_target();
      }

      self notify("target_engaged");
      self sethoverparams(0, 0, 0);
    }

    wait 1;
  }
}

function heli_get_target() {
  trace_pos = self.origin;
  closest = undefined;
  all_players = get_array_of_closest(trace_pos, level.players);

  for(i = 0; i < all_players.size; i++) {
    player = all_players[i];

    if(!player is_valid_player(undefined, 0) || istrue(player isinfreefall()) || istrue(player isskydiving()) || istrue(player isparachuting())) {
      continue;
    }

    trace_pos = (player.origin[0], player.origin[1], self.chopper_height);

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(trace_pos, player.origin + (0, 0, 10), [self, player])) {
        closest = player;
        self.gotopos = trace_pos;
      }
    }

    if(!isDefined(closest)) {
      r = anglestoright(player.angles);
      l = anglestoleft(player.angles);
      f = anglesToForward(player.angles);
      b = f * -1;
      tracepoints = [r, l, f, b];

      foreach(point in tracepoints) {
        if(isDefined(player.vehicle)) {
          ignore_array = [self, player, player.vehicle];
        } else {
          ignore_array = [self, player];
        }

        trace_pos = (player.origin[0], player.origin[1], 0) + (point[0], point[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(trace_pos, player.origin + (0, 0, 10), ignore_array)) {
          closest = player;
          self.gotopos = trace_pos;
          self.nocircle = 1;
          return closest;
        }
      }
    }

    if(isDefined(closest)) {
      break;
    }
  }

  return closest;
}

function heli_go_search() {
  level endon("game_ended");
  self endon("target_found");
  self endon("needs_to_evade");
  self endon("death");
  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun)) {
    self.minigun cleartargetentity();
  }

  self vehicle_setspeed(90, 15);
  self setneargoalnotifydist(1000);

  while(!isDefined(self.best_target)) {
    get_helicopter_path_positions();

    if(isDefined(self.flight_pos)) {
      origin = self.flight_pos;
      self setvehgoalpos(origin, 0);
    } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
      origin = random(self.path_positions);
      self setvehgoalpos(origin, 0);
    }

    self waittill("near_goal");
  }
}

function is_vehicle_spawnpoint() {
  return scripts\cp\spawner_scoring::get_spawn_scoring_type() == "vehicle_spawner";
}

function function_3458e37bbac2ff9a() {}

function function_f83786291b8efe6e() {
  self endon("death_or_disconnect");

  while(true) {
    self waittill("vehicle_enter");
    wait 1;
    self sethudtutorialmessage(&"COOP_GAME_PLAY/LEANOUT_TUTORIAL", 1);
    time = gettime() + 5000;

    while(gettime() < time) {
      if(self meleeButtonPressed()) {
        break;
      }

      if(!isDefined(self.vehicle)) {
        break;
      }

      wait 0.05;
    }

    self clearhudtutorialmessage();
  }
}

function register_invalid_seats_for_module_by_seat(var_46ff34890ecae00b, infil_name, invalid_seats) {
  if(isDefined(level.ambientgroups[var_46ff34890ecae00b])) {
    if(isarray(level.ambientgroups[var_46ff34890ecae00b])) {
      for(i = 0; i < level.ambientgroups[var_46ff34890ecae00b].size; i++) {
        if(!isDefined(level.ambientgroups[var_46ff34890ecae00b][i].vehicle_invalid_seats)) {
          level.ambientgroups[var_46ff34890ecae00b][i].vehicle_invalid_seats = [];
        }

        level.ambientgroups[var_46ff34890ecae00b][i].vehicle_invalid_seats[infil_name] = invalid_seats;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var_46ff34890ecae00b].vehicle_invalid_seats)) {
      level.ambientgroups[var_46ff34890ecae00b].vehicle_invalid_seats = [];
    }

    level.ambientgroups[var_46ff34890ecae00b].vehicle_invalid_seats[infil_name] = invalid_seats;
  }
}