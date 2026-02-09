/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicle_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicleriders_shared;
#using scripts\shared\vehicles\_auto_turret;
#using_animtree("generic");
#namespace vehicle;

function autoexec __init__sytem__() {
  system::register("vehicle_shared", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("vehicle", "toggle_lockon", 1, 1, "int");
  clientfield::register("vehicle", "toggle_sounds", 1, 1, "int");
  clientfield::register("vehicle", "use_engine_damage_sounds", 1, 2, "int");
  clientfield::register("vehicle", "toggle_treadfx", 1, 1, "int");
  clientfield::register("vehicle", "toggle_exhaustfx", 1, 1, "int");
  clientfield::register("vehicle", "toggle_lights", 1, 2, "int");
  clientfield::register("vehicle", "toggle_lights_group1", 1, 1, "int");
  clientfield::register("vehicle", "toggle_lights_group2", 1, 1, "int");
  clientfield::register("vehicle", "toggle_lights_group3", 1, 1, "int");
  clientfield::register("vehicle", "toggle_lights_group4", 1, 1, "int");
  clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int");
  clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int");
  clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int");
  clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int");
  clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int");
  clientfield::register("vehicle", "deathfx", 1, 2, "int");
  clientfield::register("vehicle", "alert_level", 1, 2, "int");
  clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int");
  clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int");
  clientfield::register("vehicle", "damage_level", 1, 3, "int");
  clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int");
  clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int");
  clientfield::register("helicopter", "toggle_lockon", 1, 1, "int");
  clientfield::register("helicopter", "toggle_sounds", 1, 1, "int");
  clientfield::register("helicopter", "use_engine_damage_sounds", 1, 2, "int");
  clientfield::register("helicopter", "toggle_treadfx", 1, 1, "int");
  clientfield::register("helicopter", "toggle_exhaustfx", 1, 1, "int");
  clientfield::register("helicopter", "toggle_lights", 1, 2, "int");
  clientfield::register("helicopter", "toggle_lights_group1", 1, 1, "int");
  clientfield::register("helicopter", "toggle_lights_group2", 1, 1, "int");
  clientfield::register("helicopter", "toggle_lights_group3", 1, 1, "int");
  clientfield::register("helicopter", "toggle_lights_group4", 1, 1, "int");
  clientfield::register("helicopter", "toggle_ambient_anim_group1", 1, 1, "int");
  clientfield::register("helicopter", "toggle_ambient_anim_group2", 1, 1, "int");
  clientfield::register("helicopter", "toggle_ambient_anim_group3", 1, 1, "int");
  clientfield::register("helicopter", "toggle_emp_fx", 1, 1, "int");
  clientfield::register("helicopter", "toggle_burn_fx", 1, 1, "int");
  clientfield::register("helicopter", "deathfx", 1, 1, "int");
  clientfield::register("helicopter", "alert_level", 1, 2, "int");
  clientfield::register("helicopter", "set_lighting_ent", 1, 1, "int");
  clientfield::register("helicopter", "use_lighting_ent", 1, 1, "int");
  clientfield::register("helicopter", "damage_level", 1, 3, "int");
  clientfield::register("helicopter", "spawn_death_dynents", 1, 2, "int");
  clientfield::register("helicopter", "spawn_gib_dynents", 1, 1, "int");
  clientfield::register("plane", "toggle_treadfx", 1, 1, "int");
  clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int");
  clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int");
  clientfield::register("toplayer", "static_postfx", 1, 1, "int");
  if(isDefined(level.bypassvehiclescripts)) {
    return;
  }
  level.heli_default_decel = 10;
  setup_targetname_spawners();
  setup_dvars();
  setup_level_vars();
  setup_triggers();
  setup_nodes();
  level array::thread_all_ents(level.vehicle_processtriggers, &trigger_process);
  level.vehicle_processtriggers = undefined;
  level.vehicle_enemy_tanks = [];
  level.vehicle_enemy_tanks["vehicle_ger_tracked_king_tiger"] = 1;
  level thread _watch_for_hijacked_vehicles();
}

function __main__() {
  a_all_spawners = getvehiclespawnerarray();
  setup_spawners(a_all_spawners);
  level thread vehicle_spawner_tool();
  level thread spline_debug();
}

function setup_script_gatetrigger(trigger) {
  gates = [];
  if(isDefined(trigger.script_gatetrigger)) {
    return level.vehicle_gatetrigger[trigger.script_gatetrigger];
  }
  return gates;
}

function trigger_process(trigger) {
  if(isDefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat" || trigger.classname == "trigger_box")) {
    btriggeronce = 1;
  } else {
    btriggeronce = 0;
  }
  if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple") {
    btriggeronce = 0;
  }
  trigger.processed_trigger = undefined;
  gates = setup_script_gatetrigger(trigger);
  script_vehicledetour = isDefined(trigger.script_vehicledetour) && (is_node_script_origin(trigger) || is_node_script_struct(trigger));
  detoured = isDefined(trigger.detoured) && (!(is_node_script_origin(trigger) || is_node_script_struct(trigger)));
  gotrigger = 1;
  while(gotrigger) {
    trigger trigger::wait_till();
    other = trigger.who;
    if(isDefined(trigger.enabled) && !trigger.enabled) {
      trigger waittill("enable");
    }
    if(isDefined(trigger.script_flag_set)) {
      if(isDefined(other) && isDefined(other.vehicle_flags)) {
        other.vehicle_flags[trigger.script_flag_set] = 1;
      }
      if(isDefined(other)) {
        other notify("vehicle_flag_arrived", trigger.script_flag_set);
      }
      level flag::set(trigger.script_flag_set);
    }
    if(isDefined(trigger.script_flag_clear)) {
      if(isDefined(other) && isDefined(other.vehicle_flags)) {
        other.vehicle_flags[trigger.script_flag_clear] = 0;
      }
      level flag::clear(trigger.script_flag_clear);
    }
    if(isDefined(other) && script_vehicledetour) {
      other thread path_detour_script_origin(trigger);
    } else if(detoured && isDefined(other)) {
      other thread path_detour(trigger);
    }
    trigger util::script_delay();
    if(btriggeronce) {
      gotrigger = 0;
    }
    if(isDefined(trigger.script_vehiclegroupdelete)) {
      if(!isDefined(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete])) {
        println("", trigger.script_vehiclegroupdelete);
        level.vehicle_deletegroup[trigger.script_vehiclegroupdelete] = [];
      }
      array::delete_all(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete]);
    }
    if(isDefined(trigger.script_vehiclespawngroup)) {
      level notify("spawnvehiclegroup" + trigger.script_vehiclespawngroup);
      level waittill("vehiclegroup spawned" + trigger.script_vehiclespawngroup);
    }
    if(gates.size > 0 && btriggeronce) {
      level array::thread_all_ents(gates, &path_gate_open);
    }
    if(isDefined(trigger) && isDefined(trigger.script_vehiclestartmove)) {
      if(!isDefined(level.vehicle_startmovegroup[trigger.script_vehiclestartmove])) {
        println("", trigger.script_vehiclestartmove);
        return;
      }
      foreach(vehicle in arraycopy(level.vehicle_startmovegroup[trigger.script_vehiclestartmove])) {
        if(isDefined(vehicle)) {
          vehicle thread go_path();
        }
      }
    }
  }
}

function path_detour_get_detourpath(detournode) {
  detourpath = undefined;
  for(j = 0; j < level.vehicle_detourpaths[detournode.script_vehicledetour].size; j++) {
    if(level.vehicle_detourpaths[detournode.script_vehicledetour][j] != detournode) {
      if(!islastnode(level.vehicle_detourpaths[detournode.script_vehicledetour][j])) {
        detourpath = level.vehicle_detourpaths[detournode.script_vehicledetour][j];
      }
    }
  }
  return detourpath;
}

function path_detour_script_origin(detournode) {
  detourpath = path_detour_get_detourpath(detournode);
  if(isDefined(detourpath)) {
    self thread paths(detourpath);
  }
}

function crash_detour_check(detourpath) {
  return isDefined(detourpath.script_crashtype) && (isDefined(self.deaddriver) || self.health <= 0 || detourpath.script_crashtype == "forced") && (!isDefined(detourpath.derailed) || (isDefined(detourpath.script_crashtype) && detourpath.script_crashtype == "plane"));
}

function crash_derailed_check(detourpath) {
  return isDefined(detourpath.derailed) && detourpath.derailed;
}

function path_detour(node) {
  detournode = getvehiclenode(node.target, "targetname");
  detourpath = path_detour_get_detourpath(detournode);
  if(!isDefined(detourpath)) {
    return;
  }
  if(node.detoured && !isDefined(detourpath.script_vehicledetourgroup)) {
    return;
  }
  if(crash_detour_check(detourpath)) {
    self notify("crashpath", detourpath);
    detourpath.derailed = 1;
    self notify("newpath");
    self setswitchnode(node, detourpath);
    return;
  }
  if(crash_derailed_check(detourpath)) {
    return;
  }
  if(isDefined(detourpath.script_vehicledetourgroup)) {
    if(!isDefined(self.script_vehicledetourgroup)) {
      return;
    }
    if(detourpath.script_vehicledetourgroup != self.script_vehicledetourgroup) {
      return;
    }
  }
}

function levelstuff(vehicle) {
  if(isDefined(vehicle.script_linkname)) {
    level.vehicle_link = array_2d_add(level.vehicle_link, vehicle.script_linkname, vehicle);
  }
  if(isDefined(vehicle.script_vehiclespawngroup)) {
    level.vehicle_spawngroup = array_2d_add(level.vehicle_spawngroup, vehicle.script_vehiclespawngroup, vehicle);
  }
  if(isDefined(vehicle.script_vehiclestartmove)) {
    level.vehicle_startmovegroup = array_2d_add(level.vehicle_startmovegroup, vehicle.script_vehiclestartmove, vehicle);
  }
  if(isDefined(vehicle.script_vehiclegroupdelete)) {
    level.vehicle_deletegroup = array_2d_add(level.vehicle_deletegroup, vehicle.script_vehiclegroupdelete, vehicle);
  }
}

function _spawn_array(spawners) {
  ai = _remove_non_riders_from_array(spawner::simple_spawn(spawners));
  return ai;
}

function _remove_non_riders_from_array(ai) {
  living_ai = [];
  for(i = 0; i < ai.size; i++) {
    if(!ai_should_be_added(ai[i])) {
      continue;
    }
    living_ai[living_ai.size] = ai[i];
  }
  return living_ai;
}

function ai_should_be_added(ai) {
  if(isalive(ai)) {
    return 1;
  }
  if(!isDefined(ai)) {
    return 0;
  }
  if(!isDefined(ai.classname)) {
    return 0;
  }
  return ai.classname == "script_model";
}

function sort_by_startingpos(guysarray) {
  firstarray = [];
  secondarray = [];
  for(i = 0; i < guysarray.size; i++) {
    if(isDefined(guysarray[i].script_startingposition)) {
      firstarray[firstarray.size] = guysarray[i];
      continue;
    }
    secondarray[secondarray.size] = guysarray[i];
  }
  return arraycombine(firstarray, secondarray, 1, 0);
}

function rider_walk_setup(vehicle) {
  if(!isDefined(self.script_vehiclewalk)) {
    return;
  }
  if(isDefined(self.script_followmode)) {
    self.followmode = self.script_followmode;
  } else {
    self.followmode = "cover nodes";
  }
  if(!isDefined(self.target)) {
    return;
  }
  node = getnode(self.target, "targetname");
  if(isDefined(node)) {
    self.nodeaftervehiclewalk = node;
  }
}

function setup_groundnode_detour(node) {
  realdetournode = getvehiclenode(node.targetname, "target");
  if(!isDefined(realdetournode)) {
    return;
  }
  realdetournode.detoured = 0;
  add_proccess_trigger(realdetournode);
}

function add_proccess_trigger(trigger) {
  if(isDefined(trigger.processed_trigger)) {
    return;
  }
  if(!isDefined(level.vehicle_processtriggers)) {
    level.vehicle_processtriggers = [];
  } else if(!isarray(level.vehicle_processtriggers)) {
    level.vehicle_processtriggers = array(level.vehicle_processtriggers);
  }
  level.vehicle_processtriggers[level.vehicle_processtriggers.size] = trigger;
  trigger.processed_trigger = 1;
}

function islastnode(node) {
  if(!isDefined(node.target)) {
    return true;
  }
  if(!isDefined(getvehiclenode(node.target, "targetname")) && !isDefined(get_vehiclenode_any_dynamic(node.target))) {
    return true;
  }
  return false;
}

function paths(node) {
  self endon("death");
  assert(isDefined(node) || isDefined(self.attachedpath), "");
  self notify("newpath");
  if(isDefined(node)) {
    self.attachedpath = node;
  }
  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;
  if(!isDefined(pathstart)) {
    return;
  }
  self thread debug_vehicle_paths();
  self endon("newpath");
  currentpoint = pathstart;
  while(isDefined(currentpoint)) {
    self waittill("reached_node", currentpoint);
    currentpoint enable_turrets(self);
    if(!isDefined(self)) {
      return;
    }
    self.currentnode = currentpoint;
    self.nextnode = (isDefined(currentpoint.target) ? getvehiclenode(currentpoint.target, "targetname") : undefined);
    if(isDefined(currentpoint.gateopen) && !currentpoint.gateopen) {
      self thread path_gate_wait_till_open(currentpoint);
    }
    currentpoint notify("trigger", self);
    if(isDefined(currentpoint.script_dropbombs) && currentpoint.script_dropbombs > 0) {
      amount = currentpoint.script_dropbombs;
      delay = 0;
      delaytrace = 0;
      if(isDefined(currentpoint.script_dropbombs_delay) && currentpoint.script_dropbombs_delay > 0) {
        delay = currentpoint.script_dropbombs_delay;
      }
      if(isDefined(currentpoint.script_dropbombs_delaytrace) && currentpoint.script_dropbombs_delaytrace > 0) {
        delaytrace = currentpoint.script_dropbombs_delaytrace;
      }
      self notify("drop_bombs", amount, delay, delaytrace);
    }
    if(isDefined(currentpoint.script_noteworthy)) {
      self notify(currentpoint.script_noteworthy);
      self notify("noteworthy", currentpoint.script_noteworthy);
    }
    if(isDefined(currentpoint.script_notify)) {
      self notify(currentpoint.script_notify);
      level notify(currentpoint.script_notify);
    }
    waittillframeend();
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(currentpoint.script_delete) && currentpoint.script_delete) {
      if(isDefined(self.riders) && self.riders.size > 0) {
        array::delete_all(self.riders);
      }
      self.delete_on_death = 1;
      self notify("death");
      if(!isalive(self)) {
        self delete();
      }
      return;
    }
    if(isDefined(currentpoint.script_sound)) {
      self playSound(currentpoint.script_sound);
    }
    if(isDefined(currentpoint.script_noteworthy)) {
      if(currentpoint.script_noteworthy == "godon") {
        self god_on();
      } else {
        if(currentpoint.script_noteworthy == "godoff") {
          self god_off();
        } else {
          if(currentpoint.script_noteworthy == "drivepath") {
            self drivepath();
          } else {
            if(currentpoint.script_noteworthy == "lockpath") {
              self startpath();
            } else {
              if(currentpoint.script_noteworthy == "brake") {
                if(self.isphysicsvehicle) {
                  self setbrake(1);
                }
                self setspeed(0, 60, 60);
              } else if(currentpoint.script_noteworthy == "resumespeed") {
                accel = 30;
                if(isDefined(currentpoint.script_float)) {
                  accel = currentpoint.script_float;
                }
                self resumespeed(accel);
              }
            }
          }
        }
      }
    }
    if(isDefined(currentpoint.script_crashtypeoverride)) {
      self.script_crashtypeoverride = currentpoint.script_crashtypeoverride;
    }
    if(isDefined(currentpoint.script_badplace)) {
      self.script_badplace = currentpoint.script_badplace;
    }
    if(isDefined(currentpoint.script_team)) {
      self.team = currentpoint.script_team;
    }
    if(isDefined(currentpoint.script_turningdir)) {
      self notify("turning", currentpoint.script_turningdir);
    }
    if(isDefined(currentpoint.script_deathroll)) {
      if(currentpoint.script_deathroll == 0) {
        self thread vehicle_death::deathrolloff();
      } else {
        self thread vehicle_death::deathrollon();
      }
    }
    if(isDefined(currentpoint.script_exploder)) {
      exploder::exploder(currentpoint.script_exploder);
    }
    if(isDefined(currentpoint.script_flag_set)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[currentpoint.script_flag_set] = 1;
      }
      self notify("vehicle_flag_arrived", currentpoint.script_flag_set);
      level flag::set(currentpoint.script_flag_set);
    }
    if(isDefined(currentpoint.script_flag_clear)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[currentpoint.script_flag_clear] = 0;
      }
      level flag::clear(currentpoint.script_flag_clear);
    }
    if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter" && isDefined(self.drivepath) && self.drivepath == 1) {
      if(isDefined(self.nextnode) && self.nextnode is_unload_node()) {
        unload_node_helicopter(undefined);
        self.attachedpath = self.nextnode;
        self drivepath(self.attachedpath);
      }
    } else if(currentpoint is_unload_node()) {
      unload_node(currentpoint);
    }
    if(isDefined(currentpoint.script_wait)) {
      pause_path();
      currentpoint util::script_wait();
    }
    if(isDefined(currentpoint.script_waittill)) {
      pause_path();
      util::waittill_any_ents(self, currentpoint.script_waittill, level, currentpoint.script_waittill);
    }
    if(isDefined(currentpoint.script_flag_wait)) {
      if(!isDefined(self.vehicle_flags)) {
        self.vehicle_flags = [];
      }
      self.vehicle_flags[currentpoint.script_flag_wait] = 1;
      self notify("vehicle_flag_arrived", currentpoint.script_flag_wait);
      self flag::set("waiting_for_flag");
      if(!level flag::get(currentpoint.script_flag_wait)) {
        pause_path();
        level flag::wait_till(currentpoint.script_flag_wait);
      }
      self flag::clear("waiting_for_flag");
    }
    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }
    if(isDefined(currentpoint.script_lights_on)) {
      if(currentpoint.script_lights_on) {
        self lights_on();
      } else {
        self lights_off();
      }
    }
    if(isDefined(currentpoint.script_stopnode)) {
      self set_goal_pos(currentpoint.origin, 1);
    }
    if(isDefined(self.switchnode)) {
      if(currentpoint == self.switchnode) {
        self.switchnode = undefined;
      }
    } else if(!isDefined(currentpoint.target)) {
      break;
    }
    resume_path();
  }
  self notify("reached_dynamic_path_end");
  if(isDefined(self.script_delete)) {
    self delete();
  }
}

function pause_path() {
  if(!(isDefined(self.vehicle_paused) && self.vehicle_paused)) {
    if(self.isphysicsvehicle) {
      self setbrake(1);
    }
    if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
      if(isDefined(self.drivepath) && self.drivepath) {
        self setvehgoalpos(self.origin, 1);
      } else {
        self setspeed(0, 100, 100);
      }
    } else {
      self setspeed(0, 35, 35);
    }
    self.vehicle_paused = 1;
  }
}

function resume_path() {
  if(isDefined(self.vehicle_paused) && self.vehicle_paused) {
    if(self.isphysicsvehicle) {
      self setbrake(0);
    }
    if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
      if(isDefined(self.drivepath) && self.drivepath) {
        self drivepath(self.currentnode);
      }
      self resumespeed(100);
    } else {
      self resumespeed(35);
    }
    self.vehicle_paused = undefined;
  }
}

function get_on_path(path_start, str_key = "targetname") {
  if(isstring(path_start)) {
    path_start = getvehiclenode(path_start, str_key);
  }
  if(!isDefined(path_start)) {
    if(isDefined(self.targetname)) {
      assertmsg("" + self.targetname);
    } else {
      assertmsg("" + self.targetname);
    }
  }
  if(isDefined(self.hasstarted)) {
    self.hasstarted = undefined;
  }
  self.attachedpath = path_start;
  if(!(isDefined(self.drivepath) && self.drivepath)) {
    self attachpath(path_start);
  }
  if(self.disconnectpathonstop === 1 && !issentient(self)) {
    self disconnect_paths(self.disconnectpathdetail);
  }
  if(isDefined(self.isphysicsvehicle) && self.isphysicsvehicle) {
    self setbrake(1);
  }
  self thread paths();
}

function get_off_path() {
  self cancelaimove();
  self clearvehgoalpos();
}

function create_from_spawngroup_and_go_path(spawngroup) {
  vehiclearray = _scripted_spawn(spawngroup);
  for(i = 0; i < vehiclearray.size; i++) {
    if(isDefined(vehiclearray[i])) {
      vehiclearray[i] thread go_path();
    }
  }
  return vehiclearray;
}

function get_on_and_go_path(path_start) {
  self get_on_path(path_start);
  self go_path();
}

function go_path() {
  self endon("death");
  self endon("hash_117fe2f2");
  if(self.isphysicsvehicle) {
    self setbrake(0);
  }
  if(isDefined(self.script_vehiclestartmove)) {
    arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
  }
  if(isDefined(self.hasstarted)) {
    println("");
    return;
  }
  self.hasstarted = 1;
  self util::script_delay();
  self notify("start_vehiclepath");
  if(isDefined(self.drivepath) && self.drivepath) {
    self drivepath(self.attachedpath);
  } else {
    self startpath();
  }
  wait(0.05);
  self connect_paths();
  self waittill("reached_end_node");
  if(self.disconnectpathonstop === 1 && !issentient(self)) {
    self disconnect_paths(self.disconnectpathdetail);
  }
  if(isDefined(self.currentnode) && isDefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme") {
    return;
  }
}

function path_gate_open(node) {
  node.gateopen = 1;
  node notify("hash_91ff5153");
}

function path_gate_wait_till_open(pathspot) {
  self endon("death");
  self.waitingforgate = 1;
  self set_speed(0, 15, "path gate closed");
  pathspot waittill("hash_91ff5153");
  self.waitingforgate = 0;
  if(self.health > 0) {
    script_resume_speed("gate opened", level.vehicle_resumespeed);
  }
}

function _spawn_group(spawngroup) {
  while(true) {
    level waittill("spawnvehiclegroup" + spawngroup);
    spawned_vehicles = [];
    for(i = 0; i < level.vehicle_spawners[spawngroup].size; i++) {
      spawned_vehicles[spawned_vehicles.size] = _vehicle_spawn(level.vehicle_spawners[spawngroup][i]);
    }
    level notify("vehiclegroup spawned" + spawngroup, spawned_vehicles);
  }
}

function _scripted_spawn(group) {
  thread _scripted_spawn_go(group);
  level waittill("vehiclegroup spawned" + group, vehicles);
  return vehicles;
}

function _scripted_spawn_go(group) {
  waittillframeend();
  level notify("spawnvehiclegroup" + group);
}

function set_variables(vehicle) {
  if(isDefined(vehicle.script_deathflag)) {
    if(!level flag::exists(vehicle.script_deathflag)) {
      level flag::init(vehicle.script_deathflag);
    }
  }
}

function _vehicle_spawn(vspawner, from) {
  if(!isDefined(vspawner) || !vspawner.count) {
    return;
  }
  str_targetname = undefined;
  if(isDefined(vspawner.targetname)) {
    str_targetname = vspawner.targetname + "_vh";
  }
  spawner::global_spawn_throttle(1);
  if(!isDefined(vspawner) || !vspawner.count) {
    return;
  }
  vehicle = vspawner spawnfromspawner(str_targetname, 1);
  if(!isDefined(vehicle)) {
    return;
  }
  if(isDefined(vspawner.script_team)) {
    vehicle setteam(vspawner.script_team);
  }
  if(isDefined(vehicle.lockheliheight)) {
    vehicle setheliheightlock(vehicle.lockheliheight);
  }
  if(isDefined(vehicle.targetname)) {
    level notify("new_vehicle_spawned" + vehicle.targetname, vehicle);
  }
  if(isDefined(vehicle.script_noteworthy)) {
    level notify("new_vehicle_spawned" + vehicle.script_noteworthy, vehicle);
  }
  if(isDefined(vehicle.script_animname)) {
    vehicle.animname = vehicle.script_animname;
  }
  if(isDefined(vehicle.script_animscripted)) {
    vehicle.supportsanimscripted = vehicle.script_animscripted;
  }
  return vehicle;
}

function init(vehicle) {
  callback::callback("hash_bae82b92");
  vehicle useanimtree($generic);
  if(isDefined(vehicle.e_dyn_path)) {
    vehicle.e_dyn_path linkto(vehicle);
  }
  vehicle flag::init("waiting_for_flag");
  vehicle.takedamage = !(isDefined(vehicle.script_godmode) && vehicle.script_godmode);
  vehicle.zerospeed = 1;
  if(!isDefined(vehicle.modeldummyon)) {
    vehicle.modeldummyon = 0;
  }
  if(isDefined(vehicle.isphysicsvehicle) && vehicle.isphysicsvehicle) {
    if(isDefined(vehicle.script_brake) && vehicle.script_brake) {
      vehicle setbrake(1);
    }
  }
  type = vehicle.vehicletype;
  vehicle _vehicle_life();
  vehicle thread maingun_fx();
  vehicle.getoutrig = [];
  if(isDefined(level.vehicle_attachedmodels) && isDefined(level.vehicle_attachedmodels[type])) {
    rigs = level.vehicle_attachedmodels[type];
    strings = getarraykeys(rigs);
    for(i = 0; i < strings.size; i++) {
      vehicle.getoutrig[strings[i]] = undefined;
      vehicle.getoutriganimating[strings[i]] = 0;
    }
  }
  if(isDefined(self.script_badplace)) {
    vehicle thread _vehicle_bad_place();
  }
  if(isDefined(vehicle.scriptbundlesettings)) {
    settings = struct::get_script_bundle("vehiclecustomsettings", vehicle.scriptbundlesettings);
    if(isDefined(settings) && isDefined(settings.lightgroups_numgroups)) {
      if(settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on === 1) {
        vehicle toggle_lights_group(1, 1);
      }
      if(settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on === 1) {
        vehicle toggle_lights_group(2, 1);
      }
      if(settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on === 1) {
        vehicle toggle_lights_group(3, 1);
      }
      if(settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on === 1) {
        vehicle toggle_lights_group(4, 1);
      }
    }
  }
  if(!vehicle is_cheap()) {
    vehicle friendly_fire_shield();
  }
  levelstuff(vehicle);
  if(isDefined(vehicle.vehicleclass) && vehicle.vehicleclass == "artillery") {
    vehicle.disconnectpathonstop = undefined;
    self disconnect_paths(0);
  } else {
    vehicle.disconnectpathonstop = self.script_disconnectpaths;
  }
  vehicle.disconnectpathdetail = self.script_disconnectpath_detail;
  if(!isDefined(vehicle.disconnectpathdetail)) {
    vehicle.disconnectpathdetail = 0;
  }
  if(!vehicle is_cheap() && (!(isDefined(vehicle.vehicleclass) && vehicle.vehicleclass == "plane")) && (!(isDefined(vehicle.vehicleclass) && vehicle.vehicleclass == "artillery"))) {
    vehicle thread _disconnect_paths_when_stopped();
  }
  if(!isDefined(vehicle.script_nonmovingvehicle)) {
    if(isDefined(vehicle.target)) {
      path_start = getvehiclenode(vehicle.target, "targetname");
      if(!isDefined(path_start)) {
        path_start = getent(vehicle.target, "targetname");
        if(!isDefined(path_start)) {
          path_start = struct::get(vehicle.target, "targetname");
        }
      }
    }
    if(isDefined(path_start) && vehicle.vehicletype != "inc_base_jump_spotlight") {
      vehicle thread get_on_path(path_start);
    }
  }
  if(isDefined(vehicle.script_vehicleattackgroup)) {
    vehicle thread attack_group_think();
  }
  if(isDefined(vehicle.script_recordent) && vehicle.script_recordent) {
    recordent(vehicle);
  }
  if(vehicle has_helicopter_dust_kickup()) {
    if(!level.clientscripts) {
      vehicle thread aircraft_dust_kickup();
    }
  }
  vehicle thread debug_vehicle();
  vehicle thread vehicle_death::main();
  if(isDefined(vehicle.script_targetset) && vehicle.script_targetset == 1) {
    offset = (0, 0, 0);
    if(isDefined(vehicle.script_targetoffset)) {
      offset = vehicle.script_targetoffset;
    }
    target_set(vehicle, offset);
  }
  if(isDefined(vehicle.script_vehicleavoidance) && vehicle.script_vehicleavoidance) {
    vehicle setvehicleavoidance(1);
  }
  vehicle enable_turrets();
  if(isDefined(level.vehiclespawncallbackthread)) {
    level thread[[level.vehiclespawncallbackthread]](vehicle);
  }
}

function detach_getoutrigs() {
  if(!isDefined(self.getoutrig)) {
    return;
  }
  if(!self.getoutrig.size) {
    return;
  }
  keys = getarraykeys(self.getoutrig);
  for(i = 0; i < keys.size; i++) {
    self.getoutrig[keys[i]] unlink();
  }
}

function enable_turrets(veh = self) {
  if(isDefined(self.script_enable_turret0) && self.script_enable_turret0) {
    veh turret::enable(0);
  }
  if(isDefined(self.script_enable_turret1) && self.script_enable_turret1) {
    veh turret::enable(1);
  }
  if(isDefined(self.script_enable_turret2) && self.script_enable_turret2) {
    veh turret::enable(2);
  }
  if(isDefined(self.script_enable_turret3) && self.script_enable_turret3) {
    veh turret::enable(3);
  }
  if(isDefined(self.script_enable_turret4) && self.script_enable_turret4) {
    veh turret::enable(4);
  }
  if(isDefined(self.script_enable_turret0) && !self.script_enable_turret0) {
    veh turret::disable(0);
  }
  if(isDefined(self.script_enable_turret1) && !self.script_enable_turret1) {
    veh turret::disable(1);
  }
  if(isDefined(self.script_enable_turret2) && !self.script_enable_turret2) {
    veh turret::disable(2);
  }
  if(isDefined(self.script_enable_turret3) && !self.script_enable_turret3) {
    veh turret::disable(3);
  }
  if(isDefined(self.script_enable_turret4) && !self.script_enable_turret4) {
    veh turret::disable(4);
  }
}

function enable_auto_disconnect_path() {
  self notify("kill_disconnect_paths_forever");
  self.disconnectpathonstop = 0;
  self thread _disconnect_paths_when_stopped();
}

function _disconnect_paths_when_stopped() {
  if(ispathfinder(self)) {
    self.disconnectpathonstop = 0;
    return;
  }
  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    self.disconnectpathonstop = 0;
    return;
  }
  self endon("death");
  self endon("kill_disconnect_paths_forever");
  wait(1);
  threshold = 3;
  while(isDefined(self)) {
    if(lengthsquared(self.velocity) < (threshold * threshold)) {
      if(self.disconnectpathonstop === 1) {
        self disconnect_paths(self.disconnectpathdetail);
        self notify("speed_zero_path_disconnect");
      }
      while(lengthsquared(self.velocity) < (threshold * threshold)) {
        wait(0.05);
      }
    }
    self connect_paths();
    while(lengthsquared(self.velocity) >= (threshold * threshold)) {
      wait(0.05);
    }
  }
}

function set_speed(speed, rate, msg) {
  if(self getspeedmph() == 0 && speed == 0) {
    return;
  }
  self thread debug_set_speed(speed, rate, msg);
  self setspeed(speed, rate);
}

function debug_set_speed(speed, rate, msg) {
  self notify("hash_3790d3c8");
  self endon("hash_3790d3c8");
  self endon("hash_eeaec2a0");
  self endon("death");
  while(true) {
    while(getdvarstring("") != "") {
      print3d(self.origin + vectorscale((0, 0, 1), 192), "" + msg, (1, 1, 1), 1, 3);
      wait(0.05);
    }
    wait(0.5);
  }
}

function script_resume_speed(msg, rate) {
  self endon("death");
  fsetspeed = 0;
  type = "resumespeed";
  if(!isDefined(self.resumemsgs)) {
    self.resumemsgs = [];
  }
  if(isDefined(self.waitingforgate) && self.waitingforgate) {
    return;
  }
  if(isDefined(self.attacking) && self.attacking) {
    fsetspeed = self.attackspeed;
    type = "setspeed";
  }
  self.zerospeed = 0;
  if(fsetspeed == 0) {
    self.zerospeed = 1;
  }
  if(type == "resumespeed") {
    self resumespeed(rate);
  } else if(type == "setspeed") {
    self set_speed(fsetspeed, 15, "resume setspeed from attack");
  }
  self notify("hash_eeaec2a0");
  self thread debug_resume((msg + "") + type);
}

function debug_resume(msg) {
  if(getdvarstring("") == "") {
    return;
  }
  self endon("death");
  number = self.resumemsgs.size;
  self.resumemsgs[number] = msg;
  self thread print_resume_speed(gettime() + (3 * 1000));
  wait(3);
  newarray = [];
  for(i = 0; i < self.resumemsgs.size; i++) {
    if(i != number) {
      newarray[newarray.size] = self.resumemsgs[i];
    }
  }
  self.resumemsgs = newarray;
}

function print_resume_speed(timer) {
  self notify("newresumespeedmsag");
  self endon("newresumespeedmsag");
  self endon("death");
  while(gettime() < timer && isDefined(self.resumemsgs)) {
    if(self.resumemsgs.size > 6) {
      start = self.resumemsgs.size - 5;
    } else {
      start = 0;
    }
    for(i = start; i < self.resumemsgs.size; i++) {
      position = i * 32;
      print3d(self.origin + (0, 0, position), "" + self.resumemsgs[i], (0, 1, 0), 1, 3);
    }
    wait(0.05);
  }
}

function god_on() {
  self.takedamage = 0;
}

function god_off() {
  self.takedamage = 1;
}

function get_normal_anim_time(animation) {
  animtime = self getanimtime(animation);
  animlength = getanimlength(animation);
  if(animtime == 0) {
    return 0;
  }
  return self getanimtime(animation) / getanimlength(animation);
}

function setup_dynamic_detour(pathnode, get_func) {
  prevnode = [[get_func]](pathnode.targetname);
  assert(isDefined(prevnode), "");
  prevnode.detoured = 0;
}

function array_2d_add(array, firstelem, newelem) {
  if(!isDefined(array[firstelem])) {
    array[firstelem] = [];
  }
  array[firstelem][array[firstelem].size] = newelem;
  return array;
}

function is_node_script_origin(pathnode) {
  return isDefined(pathnode.classname) && pathnode.classname == "script_origin";
}

function node_trigger_process() {
  processtrigger = 0;
  if(isDefined(self.spawnflags) && (self.spawnflags & 1) == 1) {
    if(isDefined(self.script_crashtype)) {
      level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;
    }
    level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
  }
  if(isDefined(self.script_vehicledetour) && isDefined(self.targetname)) {
    get_func = undefined;
    if(isDefined(get_from_entity(self.targetname))) {
      get_func = &get_from_entity_target;
    }
    if(isDefined(get_from_spawnStruct(self.targetname))) {
      get_func = &get_from_spawnstruct_target;
    }
    if(isDefined(get_func)) {
      setup_dynamic_detour(self, get_func);
      processtrigger = 1;
    } else {
      setup_groundnode_detour(self);
    }
    level.vehicle_detourpaths = array_2d_add(level.vehicle_detourpaths, self.script_vehicledetour, self);
    if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2) {
      println("", self.script_vehicledetour);
    }
  }
  if(isDefined(self.script_gatetrigger)) {
    level.vehicle_gatetrigger = array_2d_add(level.vehicle_gatetrigger, self.script_gatetrigger, self);
    self.gateopen = 0;
  }
  if(isDefined(self.script_flag_set)) {
    if(!isDefined(level.flag) || !isDefined(level.flag[self.script_flag_set])) {
      level flag::init(self.script_flag_set);
    }
  }
  if(isDefined(self.script_flag_clear)) {
    if(!level flag::exists(self.script_flag_clear)) {
      level flag::init(self.script_flag_clear);
    }
  }
  if(isDefined(self.script_flag_wait)) {
    if(!level flag::exists(self.script_flag_wait)) {
      level flag::init(self.script_flag_wait);
    }
  }
  if(isDefined(self.script_vehiclespawngroup) || isDefined(self.script_vehiclestartmove) || isDefined(self.script_gatetrigger) || isDefined(self.script_vehiclegroupdelete)) {
    processtrigger = 1;
  }
  if(processtrigger) {
    add_proccess_trigger(self);
  }
}

function setup_triggers() {
  level.vehicle_processtriggers = [];
  triggers = [];
  triggers = arraycombine(getallvehiclenodes(), getEntArray("script_origin", "classname"), 1, 0);
  triggers = arraycombine(triggers, level.struct, 1, 0);
  triggers = arraycombine(triggers, trigger::get_all(), 1, 0);
  array::thread_all(triggers, &node_trigger_process);
}

function setup_nodes() {
  a_nodes = getallvehiclenodes();
  foreach(node in a_nodes) {
    if(isDefined(node.script_flag_set)) {
      if(!level flag::exists(node.script_flag_set)) {
        level flag::init(node.script_flag_set);
      }
    }
  }
}

function is_node_script_struct(node) {
  if(!isDefined(node.targetname)) {
    return 0;
  }
  return isDefined(struct::get(node.targetname, "targetname"));
}

function setup_spawners(a_veh_spawners) {
  spawnvehicles = [];
  groups = [];
  foreach(spawner in a_veh_spawners) {
    if(isDefined(spawner.script_vehiclespawngroup)) {
      if(!isDefined(spawnvehicles[spawner.script_vehiclespawngroup])) {
        spawnvehicles[spawner.script_vehiclespawngroup] = [];
      } else if(!isarray(spawnvehicles[spawner.script_vehiclespawngroup])) {
        spawnvehicles[spawner.script_vehiclespawngroup] = array(spawnvehicles[spawner.script_vehiclespawngroup]);
      }
      spawnvehicles[spawner.script_vehiclespawngroup][spawnvehicles[spawner.script_vehiclespawngroup].size] = spawner;
      addgroup[0] = spawner.script_vehiclespawngroup;
      groups = arraycombine(groups, addgroup, 0, 0);
    }
  }
  waittillframeend();
  foreach(spawngroup in groups) {
    a_veh_spawners = spawnvehicles[spawngroup];
    level.vehicle_spawners[spawngroup] = [];
    foreach(sp in a_veh_spawners) {
      if(sp.count < 1) {
        sp.count = 1;
      }
      set_variables(sp);
      if(!isDefined(level.vehicle_spawners[spawngroup])) {
        level.vehicle_spawners[spawngroup] = [];
      } else if(!isarray(level.vehicle_spawners[spawngroup])) {
        level.vehicle_spawners[spawngroup] = array(level.vehicle_spawners[spawngroup]);
      }
      level.vehicle_spawners[spawngroup][level.vehicle_spawners[spawngroup].size] = sp;
    }
    level thread _spawn_group(spawngroup);
  }
}

function _vehicle_life() {
  if(isDefined(self.destructibledef)) {
    self.health = 99999;
  } else {
    type = self.vehicletype;
    if(isDefined(self.script_startinghealth)) {
      self.health = self.script_startinghealth;
    } else {
      if(self.healthdefault == -1) {
        return;
      }
      self.health = self.healthdefault;
    }
  }
}

function _vehicle_load_assets() {}

function is_cheap() {
  if(!isDefined(self.script_cheap)) {
    return false;
  }
  if(!self.script_cheap) {
    return false;
  }
  return true;
}

function has_helicopter_dust_kickup() {
  if(!(isDefined(self.vehicleclass) && self.vehicleclass == "plane")) {
    return false;
  }
  if(is_cheap()) {
    return false;
  }
  return true;
}

function play_looped_fx_on_tag(effect, durration, tag) {
  emodel = get_dummy();
  effectorigin = sys::spawn("script_origin", emodel.origin);
  self endon("fire_extinguish");
  thread _play_looped_fx_on_tag_origin_update(tag, effectorigin);
  while(true) {
    playFX(effect, effectorigin.origin, effectorigin.upvec);
    wait(durration);
  }
}

function _play_looped_fx_on_tag_origin_update(tag, effectorigin) {
  effectorigin.angles = self gettagangles(tag);
  effectorigin.origin = self gettagorigin(tag);
  effectorigin.forwardvec = anglesToForward(effectorigin.angles);
  effectorigin.upvec = anglestoup(effectorigin.angles);
  while(isDefined(self) && self.classname == "script_vehicle" && self getspeedmph() > 0) {
    emodel = get_dummy();
    effectorigin.angles = emodel gettagangles(tag);
    effectorigin.origin = emodel gettagorigin(tag);
    effectorigin.forwardvec = anglesToForward(effectorigin.angles);
    effectorigin.upvec = anglestoup(effectorigin.angles);
    wait(0.05);
  }
}

function setup_dvars() {
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
}

function setup_level_vars() {
  level.vehicle_resumespeed = 5;
  level.vehicle_deletegroup = [];
  level.vehicle_spawngroup = [];
  level.vehicle_startmovegroup = [];
  level.vehicle_deathswitch = [];
  level.vehicle_gatetrigger = [];
  level.vehicle_crashpaths = [];
  level.vehicle_link = [];
  level.vehicle_detourpaths = [];
  level.vehicle_startnodes = [];
  level.vehicle_spawners = [];
  level.a_vehicle_types = [];
  level.a_vehicle_targetnames = [];
  level.vehicle_walkercount = [];
  level.helicopter_crash_locations = getEntArray("helicopter_crash_location", "targetname");
  level.playervehicle = sys::spawn("script_origin", (0, 0, 0));
  level.playervehiclenone = level.playervehicle;
  if(!isDefined(level.vehicle_death_thread)) {
    level.vehicle_death_thread = [];
  }
  if(!isDefined(level.vehicle_driveidle)) {
    level.vehicle_driveidle = [];
  }
  if(!isDefined(level.vehicle_driveidle_r)) {
    level.vehicle_driveidle_r = [];
  }
  if(!isDefined(level.attack_origin_condition_threadd)) {
    level.attack_origin_condition_threadd = [];
  }
  if(!isDefined(level.vehiclefireanim)) {
    level.vehiclefireanim = [];
  }
  if(!isDefined(level.vehiclefireanim_settle)) {
    level.vehiclefireanim_settle = [];
  }
  if(!isDefined(level.vehicle_hasname)) {
    level.vehicle_hasname = [];
  }
  if(!isDefined(level.vehicle_turret_requiresrider)) {
    level.vehicle_turret_requiresrider = [];
  }
  if(!isDefined(level.vehicle_isstationary)) {
    level.vehicle_isstationary = [];
  }
  if(!isDefined(level.vehicle_compassicon)) {
    level.vehicle_compassicon = [];
  }
  if(!isDefined(level.vehicle_unloadgroups)) {
    level.vehicle_unloadgroups = [];
  }
  if(!isDefined(level.vehicle_unloadwhenattacked)) {
    level.vehicle_unloadwhenattacked = [];
  }
  if(!isDefined(level.vehicle_deckdust)) {
    level.vehicle_deckdust = [];
  }
  if(!isDefined(level.vehicle_types)) {
    level.vehicle_types = [];
  }
  if(!isDefined(level.vehicle_compass_types)) {
    level.vehicle_compass_types = [];
  }
  if(!isDefined(level.vehicle_bulletshield)) {
    level.vehicle_bulletshield = [];
  }
  if(!isDefined(level.vehicle_death_badplace)) {
    level.vehicle_death_badplace = [];
  }
}

function attacker_is_on_my_team(attacker) {
  if(isDefined(attacker) && isDefined(attacker.team) && isDefined(self.team) && attacker.team == self.team) {
    return true;
  }
  return false;
}

function attacker_troop_is_on_my_team(attacker) {
  if(isDefined(self.team) && self.team == "allies" && isDefined(attacker) && isDefined(level.player) && attacker == level.player) {
    return true;
  }
  if(isai(attacker) && attacker.team == self.team) {
    return true;
  }
  return false;
}

function bullet_shielded(type) {
  if(!isDefined(self.script_bulletshield)) {
    return false;
  }
  type = tolower(type);
  if(!isDefined(type) || !issubstr(type, "bullet")) {
    return false;
  }
  if(self.script_bulletshield) {
    return true;
  }
  return false;
}

function friendly_fire_shield() {
  self.friendlyfire_shield = 1;
  if(isDefined(level.vehicle_bulletshield[self.vehicletype]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
  }
}

function friendly_fire_shield_callback(attacker, amount, type) {
  if(!isDefined(self.friendlyfire_shield) || !self.friendlyfire_shield) {
    return false;
  }
  if(!isDefined(attacker) && self.team != "neutral" || attacker_is_on_my_team(attacker) || attacker_troop_is_on_my_team(attacker) || is_destructible() || bullet_shielded(type)) {
    return true;
  }
  return false;
}

function _vehicle_bad_place() {
  self endon("kill_badplace_forever");
  self endon("death");
  self endon("delete");
  if(isDefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }
  hasturret = isDefined(self.turretweapon) && self.turretweapon != level.weaponnone;
  while(true) {
    if(!self.script_badplace) {
      while(!self.script_badplace) {
        wait(0.5);
      }
    }
    speed = self getspeedmph();
    if(speed <= 0) {
      wait(0.5);
      continue;
    }
    if(speed < 5) {
      bp_radius = 200;
    } else {
      if(speed > 5 && speed < 8) {
        bp_radius = 350;
      } else {
        bp_radius = 500;
      }
    }
    if(isDefined(self.badplacemodifier)) {
      bp_radius = bp_radius * self.badplacemodifier;
    }
    v_turret_angles = self gettagangles("tag_turret");
    if(hasturret && isDefined(v_turret_angles)) {
      bp_direction = anglesToForward(v_turret_angles);
    } else {
      bp_direction = anglesToForward(self.angles);
    }
    wait(0.5 + 0.05);
  }
}

function get_vehiclenode_any_dynamic(target) {
  path_start = getvehiclenode(target, "targetname");
  if(!isDefined(path_start)) {
    path_start = getent(target, "targetname");
  } else if(isDefined(self.vehicleclass) && self.vehicleclass == "plane") {
    println("" + path_start.targetname);
    println("" + self.vehicletype);
    assertmsg("");
  }
  if(!isDefined(path_start)) {
    path_start = struct::get(target, "targetname");
  }
  return path_start;
}

function resume_path_vehicle() {
  if(isDefined(self.currentnode.target)) {
    node = get_vehiclenode_any_dynamic(self.currentnode.target);
  }
  if(isDefined(node)) {
    self resumespeed(35);
    paths(node);
  }
}

function land() {
  self setneargoalnotifydist(2);
  self sethoverparams(0, 0, 10);
  self cleargoalyaw();
  self settargetyaw((0, self.angles[1], 0)[1]);
  self set_goal_pos(bulletTrace(self.origin, self.origin + (vectorscale((0, 0, -1), 100000)), 0, self)["position"], 1);
  self waittill("goal");
}

function set_goal_pos(origin, bstop) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.originheightoffset)) {
    origin = origin + (0, 0, self.originheightoffset);
  }
  self setvehgoalpos(origin, bstop);
}

function liftoff(height = 512) {
  dest = self.origin + (0, 0, height);
  self setneargoalnotifydist(10);
  self set_goal_pos(dest, 1);
  self waittill("goal");
}

function wait_till_stable() {
  timer = gettime() + 400;
  while(isDefined(self)) {
    if(self.angles[0] > 12 || self.angles[0] < -1 * 12) {
      timer = gettime() + 400;
    }
    if(self.angles[2] > 12 || self.angles[2] < -1 * 12) {
      timer = gettime() + 400;
    }
    if(gettime() > timer) {
      break;
    }
    wait(0.05);
  }
}

function unload_node(node) {
  if(isDefined(self.custom_unload_function)) {
    [[self.custom_unload_function]]();
    return;
  }
  pause_path();
  if(isDefined(self.vehicleclass) && self.vehicleclass == "plane") {
    wait_till_stable();
  } else if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
    self sethoverparams(0, 0, 10);
    wait_till_stable();
  }
  if(node is_unload_node()) {
    unload(node.script_unload);
  }
}

function is_unload_node() {
  return isDefined(self.script_unload) && self.script_unload != "none";
}

function unload_node_helicopter(node) {
  if(isDefined(self.custom_unload_function)) {
    self thread[[self.custom_unload_function]]();
  }
  self sethoverparams(0, 0, 10);
  goal = self.nextnode.origin;
  start = self.nextnode.origin;
  end = start - vectorscale((0, 0, 1), 10000);
  trace = bulletTrace(start, end, 0, undefined, 1);
  if(trace["fraction"] <= 1) {
    goal = (trace["position"][0], trace["position"][1], trace["position"][2] + self.fastropeoffset);
  }
  drop_offset_tag = "tag_fastrope_ri";
  if(isDefined(self.drop_offset_tag)) {
    drop_offset_tag = self.drop_offset_tag;
  }
  drop_offset = self gettagorigin("tag_origin") - self gettagorigin(drop_offset_tag);
  goal = goal + (drop_offset[0], drop_offset[1], 0);
  self setvehgoalpos(goal, 1);
  self waittill("goal");
  self notify("unload", self.nextnode.script_unload);
  self waittill("unloaded");
}

function detach_path() {
  self.attachedpath = undefined;
  self notify("newpath");
  self setgoalyaw((0, self.angles[1], 0)[1]);
  self setvehgoalpos(self.origin + vectorscale((0, 0, 1), 4), 1);
}

function setup_targetname_spawners() {
  level.vehicle_targetname_array = [];
  vehicles = getEntArray("script_vehicle", "classname");
  n_highest_group = 0;
  foreach(vh in vehicles) {
    if(isDefined(vh.script_vehiclespawngroup)) {
      n_spawn_group = int(vh.script_vehiclespawngroup);
      if(n_spawn_group > n_highest_group) {
        n_highest_group = n_spawn_group;
      }
    }
  }
  for(i = 0; i < vehicles.size; i++) {
    vehicle = vehicles[i];
    if(isDefined(vehicle.targetname) && isvehiclespawner(vehicle)) {
      if(!isDefined(vehicle.script_vehiclespawngroup)) {
        n_highest_group++;
        vehicle.script_vehiclespawngroup = n_highest_group;
      }
      if(!isDefined(level.vehicle_targetname_array[vehicle.targetname])) {
        level.vehicle_targetname_array[vehicle.targetname] = [];
      }
      level.vehicle_targetname_array[vehicle.targetname][vehicle.script_vehiclespawngroup] = 1;
    }
  }
}

function simple_spawn(name, b_supress_assert = 0) {
  assert(b_supress_assert || isDefined(level.vehicle_targetname_array[name]), "" + name);
  vehicles = [];
  if(isDefined(level.vehicle_targetname_array[name])) {
    array = level.vehicle_targetname_array[name];
    if(array.size > 0) {
      keys = getarraykeys(array);
      foreach(key in keys) {
        vehicle_array = _scripted_spawn(key);
        vehicles = arraycombine(vehicles, vehicle_array, 1, 0);
      }
    }
  }
  return vehicles;
}

function simple_spawn_single(name, b_supress_assert = 0) {
  vehicle_array = simple_spawn(name, b_supress_assert);
  assert(b_supress_assert || vehicle_array.size == 1, ((("" + name) + "") + vehicle_array.size) + "");
  if(vehicle_array.size > 0) {
    return vehicle_array[0];
  }
}

function simple_spawn_single_and_drive(name) {
  vehiclearray = simple_spawn(name);
  assert(vehiclearray.size == 1, ((("" + name) + "") + vehiclearray.size) + "");
  vehiclearray[0] thread go_path();
  return vehiclearray[0];
}

function simple_spawn_and_drive(name) {
  vehiclearray = simple_spawn(name);
  for(i = 0; i < vehiclearray.size; i++) {
    vehiclearray[i] thread go_path();
  }
  return vehiclearray;
}

function spawn(modelname, targetname, vehicletype, origin, angles, destructibledef) {
  assert(isDefined(targetname));
  assert(isDefined(vehicletype));
  assert(isDefined(origin));
  assert(isDefined(angles));
  return spawnvehicle(vehicletype, origin, angles, targetname, destructibledef);
}

function aircraft_dust_kickup(model) {
  self endon("death");
  self endon("death_finished");
  self endon("stop_kicking_up_dust");
  assert(isDefined(self.vehicletype));
  dotracethisframe = 3;
  repeatrate = 1;
  trace = undefined;
  d = undefined;
  trace_ent = self;
  if(isDefined(model)) {
    trace_ent = model;
  }
  while(isDefined(self)) {
    if(repeatrate <= 0) {
      repeatrate = 1;
    }
    wait(repeatrate);
    if(!isDefined(self)) {
      return;
    }
    dotracethisframe--;
    if(dotracethisframe <= 0) {
      dotracethisframe = 3;
      trace = bulletTrace(trace_ent.origin, trace_ent.origin - vectorscale((0, 0, 1), 100000), 0, trace_ent);
      d = distance(trace_ent.origin, trace["position"]);
      repeatrate = (d - 350) / (1200 - 350) * (0.15 - 0.05) + 0.05;
    }
    if(!isDefined(trace)) {
      continue;
    }
    assert(isDefined(d));
    if(d > 1200) {
      repeatrate = 1;
      continue;
    }
    if(isDefined(trace["entity"])) {
      repeatrate = 1;
      continue;
    }
    if(!isDefined(trace["position"])) {
      repeatrate = 1;
      continue;
    }
    if(!isDefined(trace["surfacetype"])) {
      trace["surfacetype"] = "dirt";
    }
    assert(isDefined(level._vehicle_effect[self.vehicletype]), self.vehicletype + "");
    assert(isDefined(level._vehicle_effect[self.vehicletype][trace[""]]), "" + trace[""]);
    if(level._vehicle_effect[self.vehicletype][trace["surfacetype"]] != -1) {
      playFX(level._vehicle_effect[self.vehicletype][trace["surfacetype"]], trace["position"]);
    }
  }
}

function impact_fx(fxname, surfacetypes) {
  if(isDefined(fxname)) {
    body = self gettagorigin("tag_body");
    if(!isDefined(body)) {
      body = self.origin + vectorscale((0, 0, 1), 10);
    }
    trace = bulletTrace(body, body - (0, 0, 2 * self.radius), 0, self);
    if(trace["fraction"] < 1 && !isDefined(trace["entity"]) && (!isDefined(surfacetypes) || array::contains(surfacetypes, trace["surfacetype"]))) {
      pos = 0.5 * (self.origin + trace["position"]);
      up = 0.5 * (trace["normal"] + anglestoup(self.angles));
      forward = anglesToForward(self.angles);
      playFX(fxname, pos, up, forward);
    }
  }
}

function maingun_fx() {
  if(!isDefined(level.vehicle_deckdust[self.model])) {
    return;
  }
  self endon("death");
  while(true) {
    self waittill("weapon_fired");
    playFXOnTag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
    barrel_origin = self gettagorigin("tag_flash");
    ground = physicstrace(barrel_origin, barrel_origin + (vectorscale((0, 0, -1), 128)));
    physicsexplosionsphere(ground, 192, 100, 1);
  }
}

function lights_on(team) {
  if(isDefined(team)) {
    if(team == "allies") {
      self clientfield::set("toggle_lights", 2);
    } else if(team == "axis") {
      self clientfield::set("toggle_lights", 3);
    }
  } else {
    self clientfield::set("toggle_lights", 0);
  }
}

function lights_off() {
  self clientfield::set("toggle_lights", 1);
}

function toggle_lights_group(groupid, on) {
  bit = 1;
  if(!on) {
    bit = 0;
  }
  self clientfield::set("toggle_lights_group" + groupid, bit);
}

function toggle_ambient_anim_group(groupid, on) {
  bit = 1;
  if(!on) {
    bit = 0;
  }
  self clientfield::set("toggle_ambient_anim_group" + groupid, bit);
}

function do_death_fx() {
  deathfxtype = (self.died_by_emp === 1 ? 2 : 1);
  self clientfield::set("deathfx", deathfxtype);
  self stopsounds();
}

function toggle_emp_fx(on) {
  self clientfield::set("toggle_emp_fx", on);
}

function toggle_burn_fx(on) {
  self clientfield::set("toggle_burn_fx", on);
}

function do_death_dynents(special_status = 1) {
  assert(special_status >= 0 && special_status <= 3);
  self clientfield::set("spawn_death_dynents", special_status);
}

function do_gib_dynents() {
  self clientfield::set("spawn_gib_dynents", 1);
  numdynents = 2;
  for(i = 0; i < numdynents; i++) {
    hidetag = getstructfield(self.settings, "servo_gib_tag" + i);
    if(isDefined(hidetag)) {
      self hidepart(hidetag, "", 1);
    }
  }
}

function set_alert_fx_level(alert_level) {
  self clientfield::set("alert_level", alert_level);
}

function should_update_damage_fx_level(currenthealth, damage, maxhealth) {
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(!isDefined(settings)) {
    return 0;
  }
  currentratio = math::clamp(float(currenthealth) / float(maxhealth), 0, 1);
  afterdamageratio = math::clamp((float(currenthealth - damage)) / float(maxhealth), 0, 1);
  currentlevel = undefined;
  afterdamagelevel = undefined;
  switch ((isDefined(settings.damagestate_numstates) ? settings.damagestate_numstates : 0)) {
    case 6: {
      if(settings.damagestate_lv6_ratio >= afterdamageratio) {
        afterdamagelevel = 6;
        currentlevel = 6;
        if(settings.damagestate_lv6_ratio < currentratio) {
          currentlevel = 5;
        }
        break;
      }
    }
    case 5: {
      if(settings.damagestate_lv5_ratio >= afterdamageratio) {
        afterdamagelevel = 5;
        currentlevel = 5;
        if(settings.damagestate_lv5_ratio < currentratio) {
          currentlevel = 4;
        }
        break;
      }
    }
    case 4: {
      if(settings.damagestate_lv4_ratio >= afterdamageratio) {
        afterdamagelevel = 4;
        currentlevel = 4;
        if(settings.damagestate_lv4_ratio < currentratio) {
          currentlevel = 3;
        }
        break;
      }
    }
    case 3: {
      if(settings.damagestate_lv3_ratio >= afterdamageratio) {
        afterdamagelevel = 3;
        currentlevel = 3;
        if(settings.damagestate_lv3_ratio < currentratio) {
          currentlevel = 2;
        }
        break;
      }
    }
    case 2: {
      if(settings.damagestate_lv2_ratio >= afterdamageratio) {
        afterdamagelevel = 2;
        currentlevel = 2;
        if(settings.damagestate_lv2_ratio < currentratio) {
          currentlevel = 1;
        }
        break;
      }
    }
    case 1: {
      if(settings.damagestate_lv1_ratio >= afterdamageratio) {
        afterdamagelevel = 1;
        currentlevel = 1;
        if(settings.damagestate_lv1_ratio < currentratio) {
          currentlevel = 0;
        }
        break;
      }
    }
    default: {}
  }
  if(!isDefined(currentlevel) || !isDefined(afterdamagelevel)) {
    return 0;
  }
  if(currentlevel != afterdamagelevel) {
    return afterdamagelevel;
  }
  return 0;
}

function update_damage_fx_level(currenthealth, damage, maxhealth) {
  newdamagelevel = should_update_damage_fx_level(currenthealth, damage, maxhealth);
  if(newdamagelevel > 0) {
    self set_damage_fx_level(newdamagelevel);
    return true;
  }
  return false;
}

function set_damage_fx_level(damage_level) {
  self clientfield::set("damage_level", damage_level);
}

function build_drive(forward, reverse, normalspeed = 10, rate) {
  level.vehicle_driveidle[self.model] = forward;
  if(isDefined(reverse)) {
    level.vehicle_driveidle_r[self.model] = reverse;
  }
  level.vehicle_driveidle_normal_speed[self.model] = normalspeed;
  if(isDefined(rate)) {
    level.vehicle_driveidle_animrate[self.model] = rate;
  }
}

function get_from_spawnStruct(target) {
  return struct::get(target, "targetname");
}

function get_from_entity(target) {
  return getent(target, "targetname");
}

function get_from_spawnstruct_target(target) {
  return struct::get(target, "target");
}

function get_from_entity_target(target) {
  return getent(target, "target");
}

function is_destructible() {
  return isDefined(self.destructible_type);
}

function attack_group_think() {
  self endon("death");
  self endon("hash_11675b4c");
  self endon("hash_9696a8ad");
  if(isDefined(self.script_vehicleattackgroupwait)) {
    wait(self.script_vehicleattackgroupwait);
  }
  for(;;) {
    group = getEntArray("script_vehicle", "classname");
    valid_targets = [];
    for(i = 0; i < group.size; i++) {
      if(!isDefined(group[i].script_vehiclespawngroup)) {
        continue;
      }
      if(group[i].script_vehiclespawngroup == self.script_vehicleattackgroup) {
        if(group[i].team != self.team) {
          if(!isDefined(valid_targets)) {
            valid_targets = [];
          } else if(!isarray(valid_targets)) {
            valid_targets = array(valid_targets);
          }
          valid_targets[valid_targets.size] = group[i];
        }
      }
    }
    if(valid_targets.size == 0) {
      wait(0.5);
      continue;
    }
    for(;;) {
      current_target = undefined;
      if(valid_targets.size != 0) {
        current_target = self get_nearest_target(valid_targets);
      } else {
        self notify("hash_9696a8ad");
      }
      if(current_target.health <= 0) {
        arrayremovevalue(valid_targets, current_target);
        continue;
        continue;
      }
      self setturrettargetent(current_target, vectorscale((0, 0, 1), 50));
      if(isDefined(self.fire_delay_min) && isDefined(self.fire_delay_max)) {
        if(self.fire_delay_max < self.fire_delay_min) {
          self.fire_delay_max = self.fire_delay_min;
        }
        wait(randomintrange(self.fire_delay_min, self.fire_delay_max));
      } else {
        wait(randomintrange(4, 6));
      }
      self fireweapon();
    }
  }
}

function get_nearest_target(valid_targets) {
  nearest_distsq = 99999999;
  nearest = undefined;
  for(i = 0; i < valid_targets.size; i++) {
    if(!isDefined(valid_targets[i])) {
      continue;
    }
    current_distsq = distancesquared(self.origin, valid_targets[i].origin);
    if(current_distsq < nearest_distsq) {
      nearest_distsq = current_distsq;
      nearest = valid_targets[i];
    }
  }
  return nearest;
}

function debug_vehicle() {
  self endon("death");
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  while(true) {
    if(getdvarint("") > 0) {
      print3d(self.origin, "" + self.health, (1, 1, 1), 1, 3);
    }
    wait(0.05);
  }
}

function debug_vehicle_paths() {
  self endon("death");
  self endon("newpath");
  self endon("reached_dynamic_path_end");
  nextnode = self.currentnode;
  while(true) {
    if(getdvarint("") > 0) {
      recordline(self.origin, self.currentnode.origin, (1, 0, 0), "", self);
      recordline(self.origin, nextnode.origin, (0, 1, 0), "", self);
      recordline(self.currentnode.origin, nextnode.origin, (1, 1, 1), "", self);
    }
    wait(0.05);
    if(isDefined(self.nextnode) && self.nextnode != nextnode) {
      nextnode = self.nextnode;
    }
  }
}

function get_dummy() {
  if(isDefined(self.modeldummyon) && self.modeldummyon) {
    emodel = self.modeldummy;
  } else {
    emodel = self;
  }
  return emodel;
}

function add_main_callback(vehicletype, main) {
  if(!isDefined(level.vehicle_main_callback)) {
    level.vehicle_main_callback = [];
  }
  if(isDefined(level.vehicle_main_callback[vehicletype])) {
    println(("" + vehicletype) + "");
  }
  level.vehicle_main_callback[vehicletype] = main;
}

function vehicle_get_occupant_team() {
  occupants = self getvehoccupants();
  if(occupants.size != 0) {
    occupant = occupants[0];
    if(isPlayer(occupant)) {
      return occupant.team;
    }
  }
  return self.team;
}

function toggle_exhaust_fx(on) {
  if(!on) {
    self clientfield::set("toggle_exhaustfx", 1);
  } else {
    self clientfield::set("toggle_exhaustfx", 0);
  }
}

function toggle_tread_fx(on) {
  if(on) {
    self clientfield::set("toggle_treadfx", 1);
  } else {
    self clientfield::set("toggle_treadfx", 0);
  }
}

function toggle_sounds(on) {
  if(!on) {
    self clientfield::set("toggle_sounds", 1);
  } else {
    self clientfield::set("toggle_sounds", 0);
  }
}

function is_corpse(veh) {
  if(isDefined(veh)) {
    if(isDefined(veh.isacorpse) && veh.isacorpse) {
      return true;
    }
    if(isDefined(veh.classname) && veh.classname == "script_vehicle_corpse") {
      return true;
    }
  }
  return false;
}

function is_on(vehicle) {
  if(!isDefined(self.viewlockedentity)) {
    return false;
  }
  if(self.viewlockedentity == vehicle) {
    return true;
  }
  if(!isDefined(self.groundentity)) {
    return false;
  }
  if(self.groundentity == vehicle) {
    return true;
  }
  return false;
}

function add_spawn_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
  func = [];
  func["function"] = spawn_func;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  if(!isDefined(level.a_vehicle_targetnames)) {
    level.a_vehicle_targetnames = [];
  }
  if(!isDefined(level.a_vehicle_targetnames[veh_targetname])) {
    level.a_vehicle_targetnames[veh_targetname] = [];
  } else if(!isarray(level.a_vehicle_targetnames[veh_targetname])) {
    level.a_vehicle_targetnames[veh_targetname] = array(level.a_vehicle_targetnames[veh_targetname]);
  }
  level.a_vehicle_targetnames[veh_targetname][level.a_vehicle_targetnames[veh_targetname].size] = func;
}

function add_spawn_function_by_type(veh_type, spawn_func, param1, param2, param3, param4) {
  func = [];
  func["function"] = spawn_func;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  if(!isDefined(level.a_vehicle_types)) {
    level.a_vehicle_types = [];
  }
  if(!isDefined(level.a_vehicle_types[veh_type])) {
    level.a_vehicle_types[veh_type] = [];
  } else if(!isarray(level.a_vehicle_types[veh_type])) {
    level.a_vehicle_types[veh_type] = array(level.a_vehicle_types[veh_type]);
  }
  level.a_vehicle_types[veh_type][level.a_vehicle_types[veh_type].size] = func;
}

function add_hijack_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
  func = [];
  func["function"] = spawn_func;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  if(!isDefined(level.a_vehicle_hijack_targetnames)) {
    level.a_vehicle_hijack_targetnames = [];
  }
  if(!isDefined(level.a_vehicle_hijack_targetnames[veh_targetname])) {
    level.a_vehicle_hijack_targetnames[veh_targetname] = [];
  } else if(!isarray(level.a_vehicle_hijack_targetnames[veh_targetname])) {
    level.a_vehicle_hijack_targetnames[veh_targetname] = array(level.a_vehicle_hijack_targetnames[veh_targetname]);
  }
  level.a_vehicle_hijack_targetnames[veh_targetname][level.a_vehicle_hijack_targetnames[veh_targetname].size] = func;
}

function private _watch_for_hijacked_vehicles() {
  while(true) {
    level waittill("clonedentity", clone);
    str_targetname = clone.targetname;
    if(isDefined(str_targetname) && strendswith(str_targetname, "_ai")) {
      str_targetname = getsubstr(str_targetname, 0, str_targetname.size - 3);
    }
    waittillframeend();
    if(isDefined(str_targetname) && isDefined(level.a_vehicle_hijack_targetnames) && isDefined(level.a_vehicle_hijack_targetnames[str_targetname])) {
      foreach(func in level.a_vehicle_hijack_targetnames[str_targetname]) {
        util::single_thread(clone, func["function"], func["param1"], func["param2"], func["param3"], func["param4"]);
      }
    }
  }
}

function disconnect_paths(detail_level = 2, move_allowed = 1) {
  self disconnectpaths(detail_level, move_allowed);
  self enableobstacle(0);
}

function connect_paths() {
  self connectpaths();
  self enableobstacle(1);
}

function init_target_group() {
  self.target_group = [];
}

function add_to_target_group(target_ent) {
  assert(isDefined(self.target_group), "");
  if(!isDefined(self.target_group)) {
    self.target_group = [];
  } else if(!isarray(self.target_group)) {
    self.target_group = array(self.target_group);
  }
  self.target_group[self.target_group.size] = target_ent;
}

function remove_from_target_group(target_ent) {
  assert(isDefined(self.target_group), "");
  arrayremovevalue(self.target_group, target_ent);
}

function monitor_missiles_locked_on_to_me(player, wait_time = 0.1) {
  monitored_entity = self;
  monitored_entity endon("death");
  assert(isDefined(monitored_entity.target_group), "");
  player endon("stop_monitor_missile_locked_on_to_me");
  player endon("disconnect");
  player endon("joined_team");
  while(true) {
    closest_attacker = player get_closest_attacker_with_missile_locked_on_to_me(monitored_entity);
    player setvehiclelockedonbyent(closest_attacker);
    wait(wait_time);
  }
}

function stop_monitor_missiles_locked_on_to_me() {
  self notify("stop_monitor_missile_locked_on_to_me");
}

function get_closest_attacker_with_missile_locked_on_to_me(monitored_entity) {
  assert(isDefined(monitored_entity.target_group), "");
  player = self;
  closest_attacker = undefined;
  closest_attacker_dot = -999;
  view_origin = player getplayercamerapos();
  view_forward = anglesToForward(player getplayerangles());
  remaining_locked_on_flags = 0;
  foreach(target_ent in monitored_entity.target_group) {
    if(isDefined(target_ent) && isDefined(target_ent.locked_on)) {
      remaining_locked_on_flags = remaining_locked_on_flags | target_ent.locked_on;
    }
  }
  for(i = 0; remaining_locked_on_flags && i < level.players.size; i++) {
    attacker = level.players[i];
    if(isDefined(attacker)) {
      client_flag = 1 << attacker getentitynumber();
      if(client_flag &remaining_locked_on_flags) {
        to_attacker = vectornormalize(attacker.origin - view_origin);
        attacker_dot = vectordot(view_forward, to_attacker);
        if(attacker_dot > closest_attacker_dot) {
          closest_attacker = attacker;
          closest_attacker_dot = attacker_dot;
        }
        remaining_locked_on_flags = remaining_locked_on_flags &(~client_flag);
      }
    }
  }
  return closest_attacker;
}

function set_vehicle_drivable_time_starting_now(duration_ms) {
  end_time_ms = gettime() + duration_ms;
  set_vehicle_drivable_time(duration_ms, end_time_ms);
  return end_time_ms;
}

function set_vehicle_drivable_time(duration_ms, end_time_ms) {
  self setvehicledrivableduration(duration_ms);
  self setvehicledrivableendtime(end_time_ms);
}

function update_damage_as_occupant(damage_taken, max_health) {
  damage_taken_normalized = math::clamp(damage_taken / max_health, 0, 1);
  self setvehicledamagemeter(damage_taken_normalized);
}

function stop_monitor_damage_as_occupant() {
  self notify("stop_monitor_damage_as_occupant");
}

function monitor_damage_as_occupant(player) {
  player endon("disconnect");
  player notify("stop_monitor_damage_as_occupant");
  player endon("stop_monitor_damage_as_occupant");
  self endon("death");
  if(!isDefined(self.maxhealth)) {
    self.maxhealth = self.healthdefault;
  }
  wait(0.1);
  player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
  while(true) {
    self waittill("damage");
    waittillframeend();
    player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
  }
}

function kill_vehicle(attacker) {
  damageorigin = self.origin + (0, 0, 1);
  self finishvehicleradiusdamage(attacker, attacker, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, (0, 0, 1), 0);
}

function player_is_driver() {
  if(!isalive(self)) {
    return false;
  }
  vehicle = self getvehicleoccupied();
  if(isDefined(vehicle)) {
    seat = vehicle getoccupantseat(self);
    if(isDefined(seat) && seat == 0) {
      return true;
    }
  }
  return false;
}

function vehicle_spawner_tool() {
  allvehicles = getEntArray("", "");
  vehicletypes = [];
  foreach(veh in allvehicles) {
    vehicletypes[veh.vehicletype] = veh.model;
  }
  if(isassetloaded("", "")) {
    veh = spawnvehicle("", vectorscale((0, 0, 1), 10000), (0, 0, 0), "");
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }
  if(isassetloaded("", "")) {
    veh = spawnvehicle("", vectorscale((0, 0, 1), 10000), (0, 0, 0), "");
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }
  if(isassetloaded("", "")) {
    veh = spawnvehicle("", vectorscale((0, 0, 1), 10000), (0, 0, 0), "");
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }
  if(isassetloaded("", "")) {
    veh = spawnvehicle("", vectorscale((0, 0, 1), 10000), (0, 0, 0), "");
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }
  if(isassetloaded("", "")) {
    veh = spawnvehicle("", vectorscale((0, 0, 1), 10000), (0, 0, 0), "");
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }
  types = getarraykeys(vehicletypes);
  if(types.size == 0) {
    return;
  }
  type_index = 0;
  while(true) {
    if(getdvarint("") > 0) {
      player = getplayers()[0];
      dynamic_spawn_hud = newclienthudelem(player);
      dynamic_spawn_hud.alignx = "";
      dynamic_spawn_hud.x = 20;
      dynamic_spawn_hud.y = 395;
      dynamic_spawn_hud.fontscale = 2;
      dynamic_spawn_dummy_model = sys::spawn("", (0, 0, 0));
      while(getdvarint("") > 0) {
        origin = player.origin + (anglesToForward(player getplayerangles()) * 270);
        origin = origin + vectorscale((0, 0, 1), 40);
        if(player usebuttonpressed()) {
          dynamic_spawn_dummy_model hide();
          vehicle = spawnvehicle(types[type_index], origin, player.angles, "");
          vehicle makevehicleusable();
          if(getdvarint("") == 1) {
            setDvar("", "");
            continue;
          }
          wait(0.3);
        }
        if(player buttonpressed("")) {
          dynamic_spawn_dummy_model hide();
          type_index++;
          if(type_index >= types.size) {
            type_index = 0;
          }
          wait(0.3);
        }
        if(player buttonpressed("")) {
          dynamic_spawn_dummy_model hide();
          type_index--;
          if(type_index < 0) {
            type_index = types.size - 1;
          }
          wait(0.3);
        }
        type = types[type_index];
        dynamic_spawn_hud settext("" + type);
        dynamic_spawn_dummy_model setModel(vehicletypes[type]);
        dynamic_spawn_dummy_model show();
        dynamic_spawn_dummy_model notsolid();
        dynamic_spawn_dummy_model.origin = origin;
        dynamic_spawn_dummy_model.angles = player.angles;
        wait(0.05);
      }
      dynamic_spawn_hud destroy();
      dynamic_spawn_dummy_model delete();
    }
    wait(2);
  }
}

function spline_debug() {
  level flag::init("");
  level thread _spline_debug();
  while(true) {
    level flag::set_val("", getdvarint(""));
    wait(0.05);
  }
}

function _spline_debug() {
  while(true) {
    level flag::wait_till("");
    foreach(nd in getallvehiclenodes()) {
      nd show_node_debug_info();
    }
    wait(0.05);
  }
}

function show_node_debug_info() {
  self.n_debug_display_count = 0;
  if(is_unload_node()) {
    print_debug_info(("" + self.script_unload) + "");
  }
  if(isDefined(self.script_notify)) {
    print_debug_info(("" + self.script_notify) + "");
  }
  if(isDefined(self.script_delete) && self.script_delete) {
    print_debug_info("");
  }
}

function print_debug_info(str_info) {
  self.n_debug_display_count++;
  print3d(self.origin - (0, 0, self.n_debug_display_count * 20), str_info, (0, 0, 1), 1, 1);
}