/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicle_shared.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_death_shared;
#include scripts\core_common\vehicleriders_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\heatseekingmissile;

#namespace vehicle;

autoexec __init__system__() {
  system::register(#"vehicle_shared", &__init__, &__main__, undefined);
}

__init__() {
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
  clientfield::register("vehicle", "toggle_force_driver_taillights", 1, 1, "int");
  clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int");
  clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int");
  clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int");
  clientfield::register("vehicle", "toggle_control_bone_group1", 1, 1, "int");
  clientfield::register("vehicle", "toggle_control_bone_group2", 1, 1, "int");
  clientfield::register("vehicle", "toggle_control_bone_group3", 1, 1, "int");
  clientfield::register("vehicle", "toggle_control_bone_group4", 1, 1, "int");
  clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int");
  clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int");
  clientfield::register("vehicle", "deathfx", 1, 2, "int");
  clientfield::register("vehicle", "stopallfx", 1, 1, "int");
  clientfield::register("vehicle", "flickerlights", 1, 2, "int");
  clientfield::register("vehicle", "alert_level", 1, 2, "int");
  clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int");
  clientfield::register("vehicle", "stun", 1, 1, "int");
  clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int");
  clientfield::register("vehicle", "damage_level", 1, 3, "int");
  clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int");
  clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int");
  clientfield::register("vehicle", "toggle_horn_sound", 1, 1, "int");
  clientfield::register("vehicle", "update_malfunction", 1, 2, "int");

  if(!sessionmodeiszombiesgame() && !(isDefined(level.var_7b05c4b5) && level.var_7b05c4b5)) {
    clientfield::register_clientuimodel("vehicle.ammoCount", 1, 10, "int", 0);
    clientfield::register_clientuimodel("vehicle.ammoReloading", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.ammoLow", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.rocketAmmo", 1, 2, "int", 0);
    clientfield::register_clientuimodel("vehicle.ammo2Count", 1, 10, "int", 0);
    clientfield::register_clientuimodel("vehicle.ammo2Reloading", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.ammo2Low", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.collisionWarning", 1, 2, "int", 0);
    clientfield::register_clientuimodel("vehicle.enemyInReticle", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.missileRepulsed", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.incomingMissile", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.missileLock", 1, 2, "int", 0);
    clientfield::register_clientuimodel("vehicle.malfunction", 1, 2, "int", 0);
    clientfield::register_clientuimodel("vehicle.showHoldToExitPrompt", 1, 1, "int", 0);
    clientfield::register_clientuimodel("vehicle.holdToExitProgress", 1, 5, "float", 0);
    clientfield::register_clientuimodel("vehicle.vehicleAttackMode", 1, 3, "int", 0);
    clientfield::register_clientuimodel("vehicle.invalidLanding", 1, 1, "int", 0);

    for(i = 0; i < 3; i++) {
      clientfield::register_clientuimodel("vehicle.bindingCooldown" + i + ".cooldown", 1, 5, "float", 0);
    }
  }

  clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int");
  clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int");
  clientfield::register("toplayer", "static_postfx", 1, 1, "int");
  clientfield::register("vehicle", "vehUseMaterialPhysics", 1, 1, "int");
  clientfield::register("scriptmover", "play_flare_fx", 1, 1, "int");
  clientfield::register("scriptmover", "play_flare_hit_fx", 1, 1, "int");

  if(isDefined(level.bypassvehiclescripts)) {
    return;
  }

  level.heli_default_decel = 10;
  setup_dvars();
  setup_level_vars();
  setup_triggers();
  setup_nodes();
  level array::thread_all_ents(level.vehicle_processtriggers, &trigger_process);
  level.vehicle_processtriggers = undefined;
  level.vehicle_enemy_tanks = [];
  level.vehicle_enemy_tanks[#"vehicle_ger_tracked_king_tiger"] = 1;
  level thread _watch_for_hijacked_vehicles();
  level.var_16e6c35e = &function_16e6c35e;
}

__main__() {
  a_all_spawners = getvehiclespawnerarray();
  setup_spawners(a_all_spawners);

  level thread vehicle_spawner_tool();
  level thread spline_debug();
}

setup_script_gatetrigger(trigger) {
  gates = [];

  if(isDefined(trigger.script_gatetrigger)) {
    return level.vehicle_gatetrigger[trigger.script_gatetrigger];
  }

  return gates;
}

trigger_process(trigger) {
  if(isDefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat" || trigger.classname == "trigger_box" || trigger.classname == "trigger_multiple_new" || trigger.classname == "trigger_radius_new" || trigger.classname == "trigger_lookat_new" || trigger.classname == "trigger_box_new")) {
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
  detoured = isDefined(trigger.detoured) && !(is_node_script_origin(trigger) || is_node_script_struct(trigger));
  gotrigger = 1;

  while(gotrigger) {
    trigger trigger::wait_till();
    other = trigger.who;

    if(isDefined(trigger.enabled) && !trigger.enabled) {
      trigger waittill(#"enable");
    }

    if(isDefined(trigger.script_flag_set)) {
      if(isDefined(other) && isDefined(other.vehicle_flags)) {
        other.vehicle_flags[trigger.script_flag_set] = 1;
      }

      if(isDefined(other)) {
        other notify(#"vehicle_flag_arrived", {
          #is_set: trigger.script_flag_set
        });
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
        println("<dev string:x38>", trigger.script_vehiclegroupdelete);
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
        println("<dev string:x8a>", trigger.script_vehiclestartmove);
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

path_detour_get_detourpath(a_nd_detour) {
  if(!isDefined(a_nd_detour)) {
    a_nd_detour = [];
  } else if(!isarray(a_nd_detour)) {
    a_nd_detour = array(a_nd_detour);
  }

  a_nd_detour_real = [];

  foreach(nd in a_nd_detour) {
    if(isDefined(nd.script_vehicledetour)) {
      if(!isDefined(a_nd_detour_real)) {
        a_nd_detour_real = [];
      } else if(!isarray(a_nd_detour_real)) {
        a_nd_detour_real = array(a_nd_detour_real);
      }

      a_nd_detour_real[a_nd_detour_real.size] = nd;
    }
  }

  a_nd_detour_real = array::randomize(a_nd_detour_real);

  for(i = 0; i < a_nd_detour_real.size; i++) {
    if(!islastnode(a_nd_detour_real[i])) {
      return a_nd_detour_real[i];
    }
  }

  return undefined;
}

path_detour_script_origin(detournode) {
  detourpath = path_detour_get_detourpath(detournode);

  if(isDefined(detourpath)) {
    self thread paths(detourpath);
  }
}

crash_detour_check(detourpath) {
  return isDefined(detourpath.script_crashtype) && (isDefined(self.deaddriver) || self.health <= 0 || detourpath.script_crashtype == "forced") && (!isDefined(detourpath.derailed) || isDefined(detourpath.script_crashtype) && detourpath.script_crashtype == "plane");
}

crash_derailed_check(detourpath) {
  return isDefined(detourpath.derailed) && detourpath.derailed;
}

path_detour(node) {
  a_nd_detour = getvehiclenodearray(node.target2, "targetname");
  detourpath = path_detour_get_detourpath(a_nd_detour);

  if(!isDefined(detourpath)) {
    return;
  }

  if(node.detoured && !isDefined(detourpath.script_vehicledetourgroup)) {
    return;
  }

  if(crash_detour_check(detourpath)) {
    if(isDefined(self.script_crashtypeoverride) && self.script_crashtypeoverride === "ground_vehicle_on_spline") {
      self.nd_crash_path = detourpath;
      self thread vehicle_death::ground_vehicle_crash();
      return;
    }

    self notify(#"crashpath", detourpath);
    detourpath.derailed = 1;
    self notify(#"newpath");
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

levelstuff(vehicle) {
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

_spawn_array(spawners) {
  ai = _remove_non_riders_from_array(spawner::simple_spawn(spawners));
  return ai;
}

_remove_non_riders_from_array(ai) {
  living_ai = [];

  for(i = 0; i < ai.size; i++) {
    if(!ai_should_be_added(ai[i])) {
      continue;
    }

    living_ai[living_ai.size] = ai[i];
  }

  return living_ai;
}

ai_should_be_added(ai) {
  if(isalive(ai)) {
    return true;
  }

  if(!isDefined(ai)) {
    return false;
  }

  if(!isDefined(ai.classname)) {
    return false;
  }

  return ai.classname == "script_model";
}

sort_by_startingpos(guysarray) {
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

rider_walk_setup(vehicle) {
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

setup_groundnode_detour(node) {
  a_nd_realdetour = getvehiclenodearray(node.targetname, "target2");

  if(!a_nd_realdetour.size) {
    return;
  }

  foreach(nd_detour in a_nd_realdetour) {
    nd_detour.detoured = 0;
    add_proccess_trigger(nd_detour);
  }
}

add_proccess_trigger(trigger) {
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

islastnode(node) {
  if(!isDefined(node.target)) {
    return true;
  }

  if(!isDefined(getvehiclenode(node.target, "targetname")) && !isDefined(get_vehiclenode_any_dynamic(node.target))) {
    return true;
  }

  return false;
}

paths(node) {
  assert(isDefined(node) || isDefined(self.attachedpath), "<dev string:xa9>");
  self notify(#"endpath");
  self endon(#"endpath");
  self notify(#"newpath");
  self endon(#"death", #"newpath");

  if(isDefined(node)) {
    self.attachedpath = node;
  }

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }

  self thread debug_vehicle_paths();

  currentpoint = pathstart;

  while(isDefined(currentpoint)) {
    waitresult = self waittill(#"reached_node");
    currentpoint = waitresult.node;
    currentpoint enable_turrets(self);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = currentpoint;
    self.nextnode = isDefined(currentpoint.target) ? getvehiclenode(currentpoint.target, "targetname") : undefined;

    if(isDefined(currentpoint.gateopen) && !currentpoint.gateopen) {
      self thread path_gate_wait_till_open(currentpoint);
    }

    currentpoint notify(#"trigger", {
      #activator: self
    });

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

      self notify(#"drop_bombs", {
        #amount: amount, 
        #delay: delay, 
        #delay_trace: delaytrace
      });
    }

    if(isDefined(currentpoint.script_noteworthy)) {
      self notify(currentpoint.script_noteworthy);
      self notify(#"noteworthy", {
        #noteworthy: currentpoint.script_noteworthy
      });
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

      self delete();
      return;
    }

    if(isDefined(currentpoint.script_sound)) {
      self playSound(currentpoint.script_sound);
    }

    if(isDefined(currentpoint.script_noteworthy)) {
      if(currentpoint.script_noteworthy == "godon") {
        self god_on();
      } else if(currentpoint.script_noteworthy == "godoff") {
        self god_off();
      } else if(currentpoint.script_noteworthy == "drivepath") {
        self drivepath();
      } else if(currentpoint.script_noteworthy == "lockpath") {
        self startpath();
      } else if(currentpoint.script_noteworthy == "brake") {
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
      self notify(#"turning", {
        #direction: currentpoint.script_turningdir
      });
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

      self notify(#"vehicle_flag_arrived", {
        #is_set: currentpoint.script_flag_set
      });
      level flag::set(currentpoint.script_flag_set);
    }

    if(isDefined(currentpoint.script_flag_clear)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[currentpoint.script_flag_clear] = 0;
      }

      level flag::clear(currentpoint.script_flag_clear);
    }

    if(self.vehicleclass === "helicopter" && isDefined(self.drivepath) && self.drivepath == 1) {
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
      self notify(#"vehicle_flag_arrived", {
        #is_set: currentpoint.script_flag_wait
      });
      self flag::set("waiting_for_flag");

      if(!level flag::get(currentpoint.script_flag_wait)) {
        pause_path();
        level flag::wait_till(currentpoint.script_flag_wait);
      }

      self flag::clear("waiting_for_flag");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self vehclearlookat();
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

    if(isDefined(self.vehicle_paused) && self.vehicle_paused) {
      resume_path();
    }
  }

  self notify(#"reached_dynamic_path_end");
  self.attachedpath = undefined;

  if(isai(self)) {
    self function_af0fc980();
  }

  if(isDefined(self.var_cc1f9488) && self.var_cc1f9488) {
    self function_d4c687c9();
  }

  if(isDefined(self.script_delete)) {
    self delete();
  }
}

pause_path() {
  if(!(isDefined(self.vehicle_paused) && self.vehicle_paused)) {
    if(self.isphysicsvehicle) {
      self setbrake(1);
    }

    if(self.vehicleclass === "helicopter") {
      if(isDefined(self.drivepath) && self.drivepath) {
        self function_a57c34b7(self.origin, 1);
      } else {
        self setspeed(0, 100, 100);
      }
    } else {
      self setspeed(0, 35, 35);
    }

    self.vehicle_paused = 1;
  }
}

resume_path() {
  if(isDefined(self.vehicle_paused) && self.vehicle_paused) {
    if(self.isphysicsvehicle) {
      self setbrake(0);
    }

    if(self.vehicleclass === "helicopter") {
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

get_on_path(path_start, str_key = "targetname", distance = 0) {
  if(!isDefined(self)) {
    assert(0, "<dev string:xd0>");
    return;
  }

  if(isstring(path_start)) {
    path_start = getvehiclenode(path_start, str_key);
  }

  if(!isDefined(path_start)) {
    if(isDefined(self.targetname)) {
      assertmsg("<dev string:xfb>" + self.targetname);
      return;
    }

    assertmsg("<dev string:x122>");
    return;
  }

  if(isDefined(self.hasstarted)) {
    self.hasstarted = undefined;
  }

  self.attachedpath = path_start;

  if(!(isDefined(self.drivepath) && self.drivepath)) {
    self attachpath(path_start);
  } else if(distance != 0) {
    self function_ded6dd2e(path_start, distance);
    self.var_ef0d9bf7 = 1;
  }

  if(self.disconnectpathonstop === 1 && !issentient(self)) {
    self disconnect_paths(self.disconnectpathdetail);
  }

  if(isDefined(self.isphysicsvehicle) && self.isphysicsvehicle) {
    self setbrake(1);
  }

  if(isai(self)) {
    self vehicle_ai::set_state("spline");
  }

  self thread paths();
}

function_af0fc980() {
  assert(isDefined(isai(self)) && isai(self));
  state = self vehicle_ai::get_previous_state();

  if(!isDefined(state)) {
    state = "off";
  }

  self vehicle_ai::set_state(state);
}

get_off_path() {
  self cancelaimove();
  self function_d4c687c9();

  if(isai(self)) {
    function_af0fc980();
  }
}

create_from_spawngroup_and_go_path(spawngroup) {
  vehiclearray = _scripted_spawn(spawngroup);

  for(i = 0; i < vehiclearray.size; i++) {
    if(isDefined(vehiclearray[i])) {
      vehiclearray[i] thread go_path();
    }
  }

  return vehiclearray;
}

get_on_and_go_path(path_start, distance = 0) {
  self get_on_path(path_start, "targetname", distance);
  self go_path();
}

go_path() {
  self endon(#"death", #"stop path");

  if(self.isphysicsvehicle) {
    self setbrake(0);
  }

  if(isDefined(self.script_vehiclestartmove)) {
    arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
  }

  if(isDefined(self.hasstarted)) {
    println("<dev string:x147>");
    return;
  } else {
    self.hasstarted = 1;
  }

  self util::script_delay();
  self notify(#"start_vehiclepath");

  if(isDefined(self.var_ef0d9bf7) && self.var_ef0d9bf7) {
    self drivepath();
  } else if(isDefined(self.drivepath) && self.drivepath) {
    self drivepath(self.attachedpath);
  } else {
    self startpath();
  }

  waitframe(1);
  self connect_paths();
  self waittill(#"reached_end_node");

  if(self.disconnectpathonstop === 1 && !issentient(self)) {
    self disconnect_paths(self.disconnectpathdetail);
  }

  if(isDefined(self.currentnode) && isDefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme") {
    return;
  }
}

path_gate_open(node) {
  node.gateopen = 1;
  node notify(#"gate opened");
}

path_gate_wait_till_open(pathspot) {
  self endon(#"death");
  self.waitingforgate = 1;
  self set_speed(0, 15, "path gate closed");
  pathspot waittill(#"gate opened");
  self.waitingforgate = 0;

  if(self.health > 0) {
    script_resume_speed("gate opened", level.vehicle_resumespeed);
  }
}

_spawn_group(spawngroup) {
  while(true) {
    level waittill("spawnvehiclegroup" + spawngroup);
    spawned_vehicles = [];

    for(i = 0; i < level.vehicle_spawners[spawngroup].size; i++) {
      spawned_vehicles[spawned_vehicles.size] = _vehicle_spawn(level.vehicle_spawners[spawngroup][i]);
    }

    level notify("vehiclegroup spawned" + spawngroup, {
      #vehicles: spawned_vehicles
    });
  }
}

_scripted_spawn(group) {
  thread _scripted_spawn_go(group);
  waitresult = level waittill("vehiclegroup spawned" + group);
  return waitresult.vehicles;
}

_scripted_spawn_go(group) {
  waittillframeend();
  level notify("spawnvehiclegroup" + group);
}

set_variables(vehicle) {}

_vehicle_spawn(vspawner) {
  if(!isDefined(vspawner) || !vspawner.count) {
    return;
  }

  spawner::global_spawn_throttle();

  if(!isDefined(vspawner) || !vspawner.count) {
    return;
  }

  vehicle = vspawner spawnfromspawner(isDefined(vspawner.targetname) ? vspawner.targetname : undefined, 1);

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
    level notify("new_vehicle_spawned" + vehicle.targetname, {
      #vehicle: vehicle
    });
  }

  if(isDefined(vehicle.script_noteworthy)) {
    level notify("new_vehicle_spawned" + vehicle.script_noteworthy, {
      #vehicle: vehicle
    });
  }

  if(isDefined(vehicle.script_animname)) {
    vehicle.animname = vehicle.script_animname;
  }

  if(isDefined(vehicle.script_animscripted)) {
    vehicle.supportsanimscripted = vehicle.script_animscripted;
  }

  return vehicle;
}

init(vehicle) {
  callback::callback(#"on_vehicle_spawned");
  vehicle useanimtree("generic");

  if(isDefined(vehicle.e_dyn_path)) {
    vehicle.e_dyn_path linkto(vehicle);
  }

  vehicle flag::init("waiting_for_flag");

  if(isDefined(vehicle.script_godmode) && vehicle.script_godmode) {
    vehicle val::set(#"script_godmode", "takedamage", 0);
  }

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
      if(settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on === 1 && !(isDefined(settings.var_1eaaada1) && settings.var_1eaaada1)) {
        vehicle toggle_lights_group(1, 1);
      }

      if(settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on === 1 && !(isDefined(settings.var_97369f73) && settings.var_97369f73)) {
        vehicle toggle_lights_group(2, 1);
      }

      if(settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on === 1 && !(isDefined(settings.var_acd5533) && settings.var_acd5533)) {
        vehicle toggle_lights_group(3, 1);
      }

      if(settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on === 1 && !(isDefined(settings.var_bcb4ccd1) && settings.var_bcb4ccd1)) {
        vehicle toggle_lights_group(4, 1);
      }
    }

    if(isDefined(settings) && isDefined(settings.var_22b9bee1)) {
      vehicle.var_22b9bee1 = 1;
    }
  }

  if(!vehicle is_cheap()) {
    vehicle friendly_fire_shield();
  }

  if(isDefined(vehicle.script_physicsjolt) && vehicle.script_physicsjolt) {}

  levelstuff(vehicle);
  vehicle.disconnectpathdetail = 0;

  if(vehicle.vehicleclass === "artillery") {
    vehicle.disconnectpathonstop = undefined;
    self disconnect_paths(0);
  } else if(vehicle.isplayervehicle && !sessionmodeiswarzonegame()) {
    vehicle.disconnectpathonstop = 1;
    vehicle.disconnectpathdetail = 2;
  } else {
    vehicle.disconnectpathonstop = self.script_disconnectpaths;
  }

  if(isDefined(self.script_disconnectpath_detail)) {
    vehicle.disconnectpathdetail = self.script_disconnectpath_detail;
  }

  if(!vehicle is_cheap() && !(vehicle.vehicleclass === "plane") && !(vehicle.vehicleclass === "artillery")) {
    vehicle thread _disconnect_paths_when_stopped();
  }

  if(!isDefined(vehicle.script_nonmovingvehicle)) {
    path_start = get_target(vehicle);

    if(isDefined(path_start) && isvehiclenode(path_start)) {
      vehicle thread get_on_path(path_start);
    }
  }

  if(isDefined(vehicle.script_vehicleattackgroup)) {
    vehicle thread attack_group_think();
  }

  if(isDefined(vehicle.script_recordent) && vehicle.script_recordent) {
    recordent(vehicle);
  }

  vehicle thread debug_vehicle();

  if(!vehicle vehicle_ai::function_6c17ee49()) {
    vehicle thread vehicle_death::main();
  }

  if(isDefined(vehicle.script_targetset) && vehicle.script_targetset == 1) {
    offset = (0, 0, 0);

    if(isDefined(vehicle.script_targetoffset)) {
      offset = vehicle.script_targetoffset;
    }

    make_targetable(vehicle, offset);
  }

  if(isDefined(vehicle.script_vehicleavoidance) && vehicle.script_vehicleavoidance) {
    vehicle setvehicleavoidance(1);
  }

  vehicle enable_turrets();

  if(isDefined(level.vehiclespawncallbackthread)) {
    level thread[[level.vehiclespawncallbackthread]](vehicle);
  }

  heatseekingmissile::initlockfield(vehicle);
}

make_targetable(vehicle, offset = (0, 0, 0)) {
  target_set(vehicle, offset);
}

function_e2a44ff1(vehicle) {
  subtargets = target_getpotentialsubtargets(vehicle);

  if(subtargets.size > 1) {
    foreach(subtarget in subtargets) {
      if(subtarget) {
        thread subtarget_watch(vehicle, subtarget);
      }
    }
  }
}

subtarget_watch(vehicle, subtarget) {
  vehicle endon(#"death");
  target_set(vehicle, (0, 0, 0), subtarget);

  while(true) {
    waitresult = vehicle waittill(#"subtarget_broken");

    if(waitresult.subtarget === subtarget) {
      break;
    }
  }

  if(target_istarget(vehicle, subtarget)) {
    target_remove(vehicle, subtarget);
  }
}

get_settings() {
  settings = getscriptbundle(self.scriptbundlesettings);
  return settings;
}

detach_getoutrigs() {
  if(!isDefined(self.getoutrig)) {
    return;
  }

  if(!self.getoutrig.size) {
    return;
  }

  foreach(v in self.getoutrig) {
    v unlink();
  }
}

enable_turrets(veh = self) {
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

_disconnect_paths_when_stopped() {
  if(ispathfinder(self) && !(isDefined(self.disconnectpathonstop) && self.disconnectpathonstop)) {
    return;
  }

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    self.disconnectpathonstop = 0;
    return;
  }

  self function_d733412a(1);
}

set_speed(speed, rate, msg) {
  if(self getspeedmph() == 0 && speed == 0) {
    return;
  }

  self thread debug_set_speed(speed, rate, msg);

  self setspeed(speed, rate);
}

debug_set_speed(speed, rate, msg) {
  self notify(#"new debug_vehiclesetspeed");
  self endon(#"new debug_vehiclesetspeed", #"resuming speed", #"death");

  while(true) {
    while(getdvarstring(#"debug_vehiclesetspeed") != "<dev string:x180>") {
      print3d(self.origin + (0, 0, 192), "<dev string:x186>" + msg, (1, 1, 1), 1, 3);
      waitframe(1);
    }

    wait 0.5;
  }
}

script_resume_speed(msg, rate) {
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

  self notify(#"resuming speed");

  self thread debug_resume(msg + "<dev string:x19b>" + type);
}

debug_resume(msg) {
  if(getdvarstring(#"debug_vehicleresume") == "<dev string:x180>") {
    return;
  }

  self endon(#"death");
  number = self.resumemsgs.size;
  self.resumemsgs[number] = msg;
  self thread print_resume_speed(gettime() + int(3 * 1000));
  wait 3;
  newarray = [];

  for(i = 0; i < self.resumemsgs.size; i++) {
    if(i != number) {
      newarray[newarray.size] = self.resumemsgs[i];
    }
  }

  self.resumemsgs = newarray;
}

print_resume_speed(timer) {
  self notify(#"newresumespeedmsag");
  self endon(#"newresumespeedmsag", #"death");

  while(gettime() < timer && isDefined(self.resumemsgs)) {
    if(self.resumemsgs.size > 6) {
      start = self.resumemsgs.size - 5;
    } else {
      start = 0;
    }

    for(i = start; i < self.resumemsgs.size; i++) {
      position = i * 32;

      print3d(self.origin + (0, 0, position), "<dev string:x1a0>" + self.resumemsgs[i], (0, 1, 0), 1, 3);

    }

    waitframe(1);
  }
}

god_on() {
  self val::set(#"vehicle_god_on", "takedamage", 0);
}

god_off() {
  self val::reset(#"vehicle_god_on", "takedamage");
}

get_normal_anim_time(animation) {
  animtime = self getanimtime(animation);
  animlength = getanimlength(animation);

  if(animtime == 0) {
    return 0;
  }

  return self getanimtime(animation) / getanimlength(animation);
}

setup_dynamic_detour(pathnode, get_func) {
  prevnode = [[get_func]](pathnode.targetname);
  assert(isDefined(prevnode), "<dev string:x1b3>");
  prevnode.detoured = 0;
}

array_2d_add(array, firstelem, newelem) {
  if(!isDefined(array[firstelem])) {
    array[firstelem] = [];
  }

  array[firstelem][array[firstelem].size] = newelem;
  return array;
}

is_node_script_origin(pathnode) {
  return isDefined(pathnode.classname) && pathnode.classname == "script_origin";
}

node_trigger_process() {
  processtrigger = 0;

  if(isDefined(self.spawnflags) && (self.spawnflags&1) == 1) {
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
      println("<dev string:x1d3>", self.script_vehicledetour);
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

setup_triggers() {
  level.vehicle_processtriggers = [];
  triggers = [];
  triggers = arraycombine(getallvehiclenodes(), getEntArray("script_origin", "classname"), 1, 0);
  triggers = arraycombine(triggers, level.struct, 1, 0);
  triggers = arraycombine(triggers, trigger::get_all(), 1, 0);
  array::thread_all(triggers, &node_trigger_process);
}

setup_nodes() {
  a_nodes = getallvehiclenodes();

  foreach(node in a_nodes) {
    if(isDefined(node.script_flag_set)) {
      if(!level flag::exists(node.script_flag_set)) {
        level flag::init(node.script_flag_set);
      }
    }
  }
}

is_node_script_struct(node) {
  if(!isDefined(node.targetname)) {
    return false;
  }

  return isDefined(struct::get(node.targetname, "targetname"));
}

setup_spawners(a_veh_spawners) {
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

_vehicle_life() {
  if(isDefined(self.destructibledef)) {
    self.health = 99999;
    return;
  }

  type = self.vehicletype;

  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
    return;
  }

  if(!self.var_dd74f4a9) {
    return;
  }

  self.health = self.healthdefault;
}

_vehicle_load_assets() {}

is_cheap() {
  if(!isDefined(self.script_cheap)) {
    return false;
  }

  if(!self.script_cheap) {
    return false;
  }

  return true;
}

play_looped_fx_on_tag(effect, durration, tag) {
  emodel = get_dummy();
  effectorigin = spawn("script_origin", emodel.origin);
  self endon(#"fire_extinguish");
  thread _play_looped_fx_on_tag_origin_update(tag, effectorigin);

  while(true) {
    playFX(effect, effectorigin.origin, effectorigin.upvec);
    wait durration;
  }
}

_play_looped_fx_on_tag_origin_update(tag, effectorigin) {
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
    waitframe(1);
  }
}

setup_dvars() {
  if(getdvarstring(#"debug_vehicleresume") == "<dev string:x212>") {
    setdvar(#"debug_vehicleresume", "<dev string:x180>");
  }

  if(getdvarstring(#"debug_vehiclesetspeed") == "<dev string:x212>") {
    setdvar(#"debug_vehiclesetspeed", "<dev string:x180>");
  }

}

setup_level_vars() {
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
  level.a_str_vehicle_spawn_custom_keys = [];
  level.vehicle_walkercount = [];
  level.helicopter_crash_locations = getEntArray("helicopter_crash_location", "targetname");
  level.playervehicle = spawn("script_origin", (0, 0, 0));
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

attacker_is_on_my_team(attacker) {
  if(isDefined(attacker) && isDefined(attacker.team) && isDefined(self.team) && !util::function_fbce7263(attacker.team, self.team)) {
    return 1;
  }

  return 0;
}

bullet_shielded(type) {
  if(!isDefined(self.script_bulletshield)) {
    return 0;
  }

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "bullet")) {
    return 0;
  }

  if(self.script_bulletshield) {
    return 1;
  }

  return 0;
}

friendly_fire_shield() {
  if(isDefined(level.vehicle_bulletshield[self.vehicletype]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
  }
}

_vehicle_bad_place() {
  self endon(#"kill_badplace_forever", #"death", #"delete");

  if(isDefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }

  hasturret = isDefined(self.turretweapon) && self.turretweapon != level.weaponnone;

  while(true) {
    if(!self.script_badplace) {
      while(!self.script_badplace) {
        wait 0.5;
      }
    }

    speed = self getspeedmph();

    if(speed <= 0) {
      wait 0.5;
      continue;
    }

    if(speed < 5) {
      bp_radius = 200;
    } else if(speed > 5 && speed < 8) {
      bp_radius = 350;
    } else {
      bp_radius = 500;
    }

    if(isDefined(self.badplacemodifier)) {
      bp_radius *= self.badplacemodifier;
    }

    v_turret_angles = self gettagangles("tag_turret");

    if(hasturret && isDefined(v_turret_angles)) {
      bp_direction = anglesToForward(v_turret_angles);
    } else {
      bp_direction = anglesToForward(self.angles);
    }

    wait 0.5 + 0.05;
  }
}

get_vehiclenode_any_dynamic(target) {
  path_start = getvehiclenode(target, "targetname");

  if(!isDefined(path_start)) {
    path_start = getent(target, "targetname");
  } else if(self.vehicleclass === "plane") {
    println("<dev string:x215>" + path_start.targetname);
    println("<dev string:x234>" + self.vehicletype);

    assertmsg("<dev string:x244>");
  }

  if(!isDefined(path_start)) {
    path_start = struct::get(target, "targetname");
  }

  return path_start;
}

resume_path_vehicle() {
  if(isDefined(self.currentnode.target)) {
    node = get_vehiclenode_any_dynamic(self.currentnode.target);
  }

  if(isDefined(node)) {
    self resumespeed(35);
    paths(node);
  }
}

land() {
  self setneargoalnotifydist(2);
  self sethoverparams(0, 0, 10);
  self cleargoalyaw();
  self settargetyaw((0, self.angles[1], 0)[1]);
  self set_goal_pos(groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"], 1);
  self waittill(#"goal");
}

set_goal_pos(origin, bstop) {
  if(self.health <= 0) {
    return;
  }

  if(isDefined(self.originheightoffset)) {
    origin += (0, 0, self.originheightoffset);
  }

  self function_a57c34b7(origin, bstop);
}

liftoff(height = 512) {
  dest = self.origin + (0, 0, height);
  self setneargoalnotifydist(10);
  self set_goal_pos(dest, 1);
  self waittill(#"goal");
}

wait_till_stable() {
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

    waitframe(1);
  }
}

unload_node(node) {
  if(isDefined(self.custom_unload_function)) {
    [[self.custom_unload_function]]();
    return;
  }

  pause_path();

  if(self.vehicleclass === "plane") {
    wait_till_stable();
  } else if(self.vehicleclass === "helicopter") {
    self sethoverparams(0, 0, 10);
    wait_till_stable();
  }

  if(node is_unload_node()) {
    unload(node.script_unload);
  }
}

is_unload_node() {
  return isDefined(self.script_unload) && self.script_unload != "none";
}

unload_node_helicopter(node) {
  if(isDefined(self.custom_unload_function)) {
    self thread[[self.custom_unload_function]]();
  }

  self sethoverparams(0, 0, 10);
  goal = self.nextnode.origin;
  start = self.nextnode.origin;
  end = start - (0, 0, 10000);
  trace = bulletTrace(start, end, 0, undefined);

  if(trace[#"fraction"] <= 1) {
    goal = (trace[#"position"][0], trace[#"position"][1], trace[#"position"][2] + self.fastropeoffset);
  }

  drop_offset_tag = "tag_fastrope_ri";

  if(isDefined(self.drop_offset_tag)) {
    drop_offset_tag = self.drop_offset_tag;
  }

  drop_offset = self gettagorigin("tag_origin") - self gettagorigin(drop_offset_tag);
  goal += (drop_offset[0], drop_offset[1], 0);
  self function_a57c34b7(goal, 1);
  self waittill(#"goal");
  self notify(#"unload", {
    #who: self.nextnode.script_unload
  });
  self waittill(#"unloaded");
}

detach_path() {
  self.attachedpath = undefined;
  self notify(#"newpath");

  if(isvehicle(self)) {
    speed = self getgoalspeedmph();

    if(speed == 0) {
      self setspeed(0.01);
    }

    self setgoalyaw((0, self.angles[1], 0)[1]);
    self function_a57c34b7(self.origin + (0, 0, 4), 1);
  }
}

simple_spawn(name_or_spawners, b_supress_assert = 0) {
  a_spawners = [];

  if(isstring(name_or_spawners)) {
    a_spawners = getvehiclespawnerarray(name_or_spawners, "targetname");
    assert(a_spawners.size || b_supress_assert, "<dev string:x279>" + name_or_spawners + "<dev string:x298>");
  } else {
    if(!isDefined(name_or_spawners)) {
      name_or_spawners = [];
    } else if(!isarray(name_or_spawners)) {
      name_or_spawners = array(name_or_spawners);
    }

    a_spawners = name_or_spawners;
  }

  a_vehicles = [];

  foreach(sp in a_spawners) {
    vh = _vehicle_spawn(sp);

    if(!isDefined(a_vehicles)) {
      a_vehicles = [];
    } else if(!isarray(a_vehicles)) {
      a_vehicles = array(a_vehicles);
    }

    a_vehicles[a_vehicles.size] = vh;
  }

  return a_vehicles;
}

simple_spawn_single(name, b_supress_assert = 0) {
  vehicle_array = simple_spawn(name, b_supress_assert);
  assert(b_supress_assert || vehicle_array.size == 1, "<dev string:x2a2>" + name + "<dev string:x2ce>" + vehicle_array.size + "<dev string:x2e2>");

  if(vehicle_array.size > 0) {
    return vehicle_array[0];
  }
}

simple_spawn_single_and_drive(name) {
  vehiclearray = simple_spawn(name);
  assert(vehiclearray.size == 1, "<dev string:x2a2>" + name + "<dev string:x2ce>" + vehiclearray.size + "<dev string:x2e2>");
  vehiclearray[0] thread go_path();
  return vehiclearray[0];
}

simple_spawn_and_drive(name) {
  vehiclearray = simple_spawn(name);

  for(i = 0; i < vehiclearray.size; i++) {
    vehiclearray[i] thread go_path();
  }

  return vehiclearray;
}

spawn(modelname, targetname, vehicletype, origin, angles, destructibledef) {
  assert(isDefined(targetname));
  assert(isDefined(vehicletype));
  assert(isDefined(origin));
  assert(isDefined(angles));
  return spawnvehicle(vehicletype, origin, angles, targetname, destructibledef);
}

impact_fx(fxname, surfacetypes) {
  if(isDefined(fxname)) {
    body = self gettagorigin("tag_body");

    if(!isDefined(body)) {
      body = self.origin + (0, 0, 10);
    }

    trace = bulletTrace(body, body - (0, 0, 2 * self.radius), 0, self);

    if(trace[#"fraction"] < 1 && !isDefined(trace[#"entity"]) && (!isDefined(surfacetypes) || array::contains(surfacetypes, trace[#"surfacetype"]))) {
      pos = 0.5 * (self.origin + trace[#"position"]);
      up = 0.5 * (trace[#"normal"] + anglestoup(self.angles));
      forward = anglesToForward(self.angles);
      playFX(fxname, pos, up, forward);
    }
  }
}

maingun_fx() {
  if(!isDefined(level.vehicle_deckdust[self.model])) {
    return;
  }

  self endon(#"death");

  while(true) {
    self waittill(#"weapon_fired");
    playFXOnTag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
    barrel_origin = self gettagorigin("tag_flash");
    ground = physicstrace(barrel_origin, barrel_origin + (0, 0, -128));
    physicsexplosionsphere(ground, 192, 100, 1);
  }
}

toggle_force_driver_taillights(on) {
  bit = 1;

  if(!on) {
    bit = 0;
  }

  self clientfield::set("toggle_force_driver_taillights", bit);
}

toggle_lights_group(groupid, on) {
  bit = 1;

  if(!on) {
    bit = 0;
  }

  self clientfield::set("toggle_lights_group" + groupid, bit);
}

control_lights_groups(on) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(!isDefined(settings) || !isDefined(settings.lightgroups_numgroups)) {
    return;
  }

  if(settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on !== 1 && !(isDefined(level.var_f1997f07) && level.var_f1997f07)) {
    toggle_lights_group(1, on);
  }

  if(settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on !== 1) {
    toggle_lights_group(2, on);
  }

  if(settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on !== 1) {
    toggle_lights_group(3, on);
  }

  if(settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on !== 1) {
    toggle_lights_group(4, on);
  }
}

lights_on(team) {
  if(isDefined(team)) {
    if(team == #"allies") {
      self clientfield::set("toggle_lights", 2);
    } else if(team == #"axis") {
      self clientfield::set("toggle_lights", 3);
    }
  } else {
    self clientfield::set("toggle_lights", 0);
  }

  control_lights_groups(1);
}

lights_off() {
  self clientfield::set("toggle_lights", 1);
  control_lights_groups(0);
}

toggle_ambient_anim_group(groupid, on) {
  bit = 1;

  if(!on) {
    bit = 0;
  }

  self clientfield::set("toggle_ambient_anim_group" + groupid, bit);
}

toggle_control_bone_group(groupid, on) {
  bit = 1;

  if(!on) {
    bit = 0;
  }

  self clientfield::set("toggle_control_bone_group" + groupid, bit);
}

do_death_fx() {
  deathfxtype = self.died_by_emp === 1 ? 2 : 1;
  self clientfield::set("deathfx", deathfxtype);
  self stopsounds();
}

toggle_emp_fx(on) {
  self clientfield::set("toggle_emp_fx", on);
}

toggle_burn_fx(on) {
  self clientfield::set("toggle_burn_fx", on);
}

do_death_dynents(special_status = 1) {
  assert(special_status >= 0 && special_status <= 3);
  self clientfield::set("spawn_death_dynents", special_status);
}

do_gib_dynents() {
  self clientfield::set("spawn_gib_dynents", 1);
  numdynents = 2;

  for(i = 0; i < numdynents; i++) {
    hidetag = self.settings.("servo_gib_tag" + i);

    if(isDefined(hidetag)) {
      self hidepart(hidetag, "", 1);
    }
  }
}

set_alert_fx_level(alert_level) {
  self clientfield::set("alert_level", alert_level);
}

should_update_damage_fx_level(currenthealth, damage, maxhealth) {
  if(!isDefined(self.scriptbundlesettings)) {
    return 0;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(!isDefined(settings)) {
    return 0;
  }

  currentratio = math::clamp(float(currenthealth) / float(maxhealth), 0, 1);
  afterdamageratio = math::clamp(float(currenthealth - damage) / float(maxhealth), 0, 1);
  currentlevel = undefined;
  afterdamagelevel = undefined;

  switch (isDefined(settings.damagestate_numstates) ? settings.damagestate_numstates : 0) {
    case 6:
      if(settings.damagestate_lv6_ratio >= afterdamageratio) {
        afterdamagelevel = 6;
        currentlevel = 6;

        if(settings.damagestate_lv6_ratio < currentratio) {
          currentlevel = 5;
        }

        break;
      }
    case 5:
      if(settings.damagestate_lv5_ratio >= afterdamageratio) {
        afterdamagelevel = 5;
        currentlevel = 5;

        if(settings.damagestate_lv5_ratio < currentratio) {
          currentlevel = 4;
        }

        break;
      }
    case 4:
      if(settings.damagestate_lv4_ratio >= afterdamageratio) {
        afterdamagelevel = 4;
        currentlevel = 4;

        if(settings.damagestate_lv4_ratio < currentratio) {
          currentlevel = 3;
        }

        break;
      }
    case 3:
      if(settings.damagestate_lv3_ratio >= afterdamageratio) {
        afterdamagelevel = 3;
        currentlevel = 3;

        if(settings.damagestate_lv3_ratio < currentratio) {
          currentlevel = 2;
        }

        break;
      }
    case 2:
      if(settings.damagestate_lv2_ratio >= afterdamageratio) {
        afterdamagelevel = 2;
        currentlevel = 2;

        if(settings.damagestate_lv2_ratio < currentratio) {
          currentlevel = 1;
        }

        break;
      }
    case 1:
      if(settings.damagestate_lv1_ratio >= afterdamageratio) {
        afterdamagelevel = 1;
        currentlevel = 1;

        if(settings.damagestate_lv1_ratio < currentratio) {
          currentlevel = 0;
        }

        break;
      }
    default:
      break;
  }

  if(!isDefined(currentlevel) || !isDefined(afterdamagelevel)) {
    return 0;
  }

  if(currentlevel != afterdamagelevel) {
    return afterdamagelevel;
  }

  return 0;
}

update_damage_fx_level(currenthealth, damage, maxhealth) {
  newdamagelevel = should_update_damage_fx_level(currenthealth, damage, maxhealth);

  if(newdamagelevel > 0) {
    self set_damage_fx_level(newdamagelevel);
    return true;
  }

  return false;
}

set_damage_fx_level(damage_level) {
  self clientfield::set("damage_level", damage_level);
}

build_drive(forward, reverse, normalspeed = 10, rate) {
  level.vehicle_driveidle[self.model] = forward;

  if(isDefined(reverse)) {
    level.vehicle_driveidle_r[self.model] = reverse;
  }

  level.vehicle_driveidle_normal_speed[self.model] = normalspeed;

  if(isDefined(rate)) {
    level.vehicle_driveidle_animrate[self.model] = rate;
  }
}

function_ea56e00e(vehicle) {
  target = get_target(vehicle);

  if(!isDefined(target)) {
    vehicle setgoal(vehicle.origin, 0, vehicle.goalradius, vehicle.goalheight);
    return;
  }

  vehicle setgoal(target.origin, 1);
}

get_target(vehicle) {
  target = undefined;

  if(isDefined(vehicle.target)) {
    target = getvehiclenode(vehicle.target, "targetname");

    if(!isDefined(target)) {
      target = get_from_entity(vehicle.target);

      if(!isDefined(target)) {
        target = get_from_spawnStruct(vehicle.target);
      }
    }
  }

  return target;
}

get_from_spawnStruct(target) {
  return struct::get(target, "targetname");
}

get_from_entity(target) {
  return getent(target, "targetname");
}

get_from_spawnstruct_target(target) {
  return struct::get(target, "target");
}

get_from_entity_target(target) {
  return getent(target, "target");
}

is_destructible() {
  return isDefined(self.destructible_type);
}

attack_group_think() {
  self endon(#"death", #"switch group", #"killed all targets");

  if(isDefined(self.script_vehicleattackgroupwait)) {
    wait self.script_vehicleattackgroupwait;
  }

  for(;;) {
    group = getEntArray("script_vehicle", "classname");
    valid_targets = [];

    for(i = 0; i < group.size; i++) {
      if(!isDefined(group[i].script_vehiclespawngroup)) {
        continue;
      }

      if(group[i].script_vehiclespawngroup == self.script_vehicleattackgroup) {
        if(util::function_fbce7263(group[i].team, self.team)) {
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
      wait 0.5;
      continue;
    }

    for(;;) {
      current_target = undefined;

      if(valid_targets.size != 0) {
        current_target = self get_nearest_target(valid_targets);
      } else {
        self notify(#"killed all targets");
      }

      if(current_target.health <= 0) {
        arrayremovevalue(valid_targets, current_target);
        continue;
      }

      self turretsettarget(0, current_target, (0, 0, 50));

      if(isDefined(self.fire_delay_min) && isDefined(self.fire_delay_max)) {
        if(self.fire_delay_max < self.fire_delay_min) {
          self.fire_delay_max = self.fire_delay_min;
        }

        wait randomintrange(self.fire_delay_min, self.fire_delay_max);
      } else {
        wait randomintrange(4, 6);
      }

      self fireweapon();
    }
  }
}

get_nearest_target(valid_targets) {
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

debug_vehicle() {
  self endon(#"death");

  if(getdvarstring(#"debug_vehicle_health") == "<dev string:x212>") {
    setdvar(#"debug_vehicle_health", 0);
  }

  while(true) {
    if(getdvarint(#"debug_vehicle_health", 0) > 0) {
      print3d(self.origin, "<dev string:x2fc>" + self.health, (1, 1, 1), 1, 3);
    }

    waitframe(1);
  }
}

debug_vehicle_paths() {
  self endon(#"death", #"newpath", #"endpath", #"reached_dynamic_path_end");

  for(nextnode = self.currentnode; true; nextnode = self.nextnode) {
    if(getdvarint(#"debug_vehicle_paths", 0) > 0) {
      recordline(self.origin, self.currentnode.origin, (1, 0, 0), "<dev string:x307>", self);
      recordline(self.origin, nextnode.origin, (0, 1, 0), "<dev string:x307>", self);
      recordline(self.currentnode.origin, nextnode.origin, (1, 1, 1), "<dev string:x307>", self);
    }

    waitframe(1);

    if(isDefined(self.nextnode) && self.nextnode != nextnode) {}
  }
}

get_dummy() {
  if(isDefined(self.modeldummyon) && self.modeldummyon) {
    emodel = self.modeldummy;
  } else {
    emodel = self;
  }

  return emodel;
}

add_main_callback(vehicletype, main) {
  if(!isDefined(level.vehicle_main_callback)) {
    level.vehicle_main_callback = [];
  }

  if(isDefined(level.vehicle_main_callback[vehicletype])) {
    println("<dev string:x310>" + vehicletype + "<dev string:x33f>");
  }

  level.vehicle_main_callback[vehicletype] = main;
}

vehicle_get_occupant_team() {
  occupants = self getvehoccupants();

  if(occupants.size != 0) {
    occupant = occupants[0];

    if(isplayer(occupant)) {
      return occupant.team;
    }
  }

  return self.team;
}

toggle_exhaust_fx(on) {
  if(!on) {
    self clientfield::set("toggle_exhaustfx", 1);
    return;
  }

  self clientfield::set("toggle_exhaustfx", 0);
}

toggle_tread_fx(on) {
  if(on) {
    self clientfield::set("toggle_treadfx", 1);
    return;
  }

  self clientfield::set("toggle_treadfx", 0);
}

toggle_sounds(on) {
  if(!on) {
    self clientfield::set("toggle_sounds", 1);
    return;
  }

  self clientfield::set("toggle_sounds", 0);
}

function_bbc1d940(on) {
  if(isDefined(self.emped) && self.emped || isDefined(self.isjammed) && self.isjammed) {
    on = 0;
  }

  if(on) {
    self clientfield::set("toggle_horn_sound", 1);
  } else {
    self clientfield::set("toggle_horn_sound", 0);
  }

  self callback::callback(#"hash_6e388f6a0df7bdac", {
    #var_d8ceeba3: on
  });
}

event_handler[event_9430cf9f] function_c8effed1(eventstruct) {
  if(isvehicle(eventstruct.vehicle)) {
    if(!isDefined(eventstruct.vehicle.var_18a9fdc) || self[[eventstruct.vehicle.var_18a9fdc]](eventstruct.vehicle)) {
      if(isDefined(eventstruct.vehicle.var_304cf9da) && eventstruct.vehicle.var_304cf9da) {
        if(eventstruct.vehicle clientfield::get("toggle_horn_sound")) {
          eventstruct.vehicle function_bbc1d940(0);
        } else {
          eventstruct.vehicle function_bbc1d940(1);
        }

        return;
      }

      eventstruct.vehicle function_bbc1d940(1);
    }
  }
}

event_handler[event_1e1c81ae] function_7e40b597(eventstruct) {
  if(isvehicle(eventstruct.vehicle)) {
    if(!(isDefined(eventstruct.vehicle.var_304cf9da) && eventstruct.vehicle.var_304cf9da)) {
      eventstruct.vehicle function_bbc1d940(0);
    }
  }
}

event_handler[vehicle_collision] function_5b65d9ec(eventstruct) {
  callback::callback(#"veh_collision", eventstruct);
}

function_fa4236af(params) {
  self endon(#"death", #"exit_vehicle");
  driver = self getseatoccupant(0);

  if(!isplayer(driver)) {
    self toggle_sounds(1);
    return;
  }

  driver endon(#"death", #"disconnect");

  if(isDefined(self.var_42cfec27) && self.var_42cfec27 != "") {
    var_b0c85051 = soundgetplaybacktime(self.var_42cfec27) * 0.001;
    var_b0c85051 -= 0.5;

    if(var_b0c85051 > 0) {
      var_b0c85051 = math::clamp(var_b0c85051, 0.25, 1.5);
      self takeplayercontrol();
      self playSound(self.var_42cfec27);
      wait var_b0c85051;

      if(!(isDefined(params.var_30a04b16) && params.var_30a04b16)) {
        self returnplayercontrol();
      }
    }
  }

  self toggle_sounds(1);

  if(isDefined(params.var_32a85fa1)) {
    self takeplayercontrol();
    wait params.var_32a85fa1;

    if(!(isDefined(params.var_30a04b16) && params.var_30a04b16)) {
      self returnplayercontrol();
    }
  }
}

function_7f0bbde3() {
  if(isDefined(self.var_ae271c0b) && self.var_ae271c0b != "") {
    self playSound(self.var_ae271c0b);
  }
}

is_corpse(veh) {
  if(isDefined(veh)) {
    if(isDefined(veh.isacorpse) && veh.isacorpse) {
      return true;
    } else if(isDefined(veh.classname) && veh.classname == "script_vehicle_corpse") {
      return true;
    }
  }

  return false;
}

is_on(vehicle) {
  if(!isDefined(self.viewlockedentity)) {
    return false;
  } else if(self.viewlockedentity == vehicle) {
    return true;
  }

  if(!isDefined(self.groundentity)) {
    return false;
  } else if(self.groundentity == vehicle) {
    return true;
  }

  return false;
}

add_spawn_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
  add_spawn_function_group(veh_targetname, "targetname", spawn_func, param1, param2, param3, param4);
}

add_spawn_function_group(str_value, str_key, spawn_func, param1, param2, param3, param4) {
  func = [];
  func[#"function"] = spawn_func;
  func[#"param1"] = param1;
  func[#"param2"] = param2;
  func[#"param3"] = param3;
  func[#"param4"] = param4;

  if(!isDefined(level.a_str_vehicle_spawn_custom_keys)) {
    level.a_str_vehicle_spawn_custom_keys = [];
  }

  if(!isDefined(level.("a_str_vehicle_spawn_key_" + str_key))) {
    level.("a_str_vehicle_spawn_key_" + str_key) = [];
  }

  a_key_spawn_funcs = level.("a_str_vehicle_spawn_key_" + str_key);

  if(!isDefined(level.a_str_vehicle_spawn_custom_keys)) {
    level.a_str_vehicle_spawn_custom_keys = [];
  } else if(!isarray(level.a_str_vehicle_spawn_custom_keys)) {
    level.a_str_vehicle_spawn_custom_keys = array(level.a_str_vehicle_spawn_custom_keys);
  }

  if(!isinarray(level.a_str_vehicle_spawn_custom_keys, str_key)) {
    level.a_str_vehicle_spawn_custom_keys[level.a_str_vehicle_spawn_custom_keys.size] = str_key;
  }

  if(!isDefined(a_key_spawn_funcs[str_value])) {
    a_key_spawn_funcs[str_value] = [];
  } else if(!isarray(a_key_spawn_funcs[str_value])) {
    a_key_spawn_funcs[str_value] = array(a_key_spawn_funcs[str_value]);
  }

  a_key_spawn_funcs[str_value][a_key_spawn_funcs[str_value].size] = func;
}

add_spawn_function_by_type(veh_type, spawn_func, param1, param2, param3, param4) {
  add_spawn_function_group(veh_type, "vehicletype", spawn_func, param1, param2, param3, param4);
}

add_hijack_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
  func = [];
  func[#"function"] = spawn_func;
  func[#"param1"] = param1;
  func[#"param2"] = param2;
  func[#"param3"] = param3;
  func[#"param4"] = param4;

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

private _watch_for_hijacked_vehicles() {
  while(true) {
    waitresult = level waittill(#"clonedentity");
    str_targetname = waitresult.clone.targetname;
    waittillframeend();

    if(isDefined(str_targetname) && isDefined(level.a_vehicle_hijack_targetnames) && isDefined(level.a_vehicle_hijack_targetnames[str_targetname])) {
      foreach(func in level.a_vehicle_hijack_targetnames[str_targetname]) {
        util::single_thread(waitresult.clone, func[#"function"], func[#"param1"], func[#"param2"], func[#"param3"], func[#"param4"]);
      }
    }
  }
}

disconnect_paths(detail_level = 2, move_allowed = 1) {
  self disconnectpaths(detail_level, move_allowed);
  self enableobstacle(0);
}

connect_paths() {
  self connectpaths();
  self enableobstacle(1);
}

init_target_group() {
  self.target_group = [];
}

add_to_target_group(target_ent) {
  assert(isDefined(self.target_group), "<dev string:x36b>");

  if(!isDefined(self.target_group)) {
    self.target_group = [];
  } else if(!isarray(self.target_group)) {
    self.target_group = array(self.target_group);
  }

  self.target_group[self.target_group.size] = target_ent;
}

remove_from_target_group(target_ent) {
  assert(isDefined(self.target_group), "<dev string:x36b>");
  arrayremovevalue(self.target_group, target_ent);
}

monitor_missiles_locked_on_to_me(player, wait_time = 0.1) {
  monitored_entity = self;
  monitored_entity endon(#"death");
  assert(isDefined(monitored_entity.target_group), "<dev string:x36b>");
  player endon(#"stop_monitor_missile_locked_on_to_me", #"disconnect", #"joined_team");

  while(true) {
    closest_attacker = player get_closest_attacker_with_missile_locked_on_to_me(monitored_entity);
    player setvehiclelockedonbyent(closest_attacker);
    wait wait_time;
  }
}

watch_freeze_on_flash(duration) {
  veh = self;

  if(veh flag::exists("watch_freeze_on_flash")) {
    return;
  }

  veh flag::init("watch_freeze_on_flash", 1);

  if(isDefined(veh.owner)) {
    veh.owner clientfield::set_to_player("static_postfx", 0);
  }

  veh clientfield::set("stun", 0);

  while(true) {
    waitresult = veh waittill(#"damage", #"death");

    if(waitresult._notify == "death") {
      return;
    }

    weapon = waitresult.weapon;
    mod = waitresult.mod;
    owner = veh.owner;
    controlled = isDefined(veh.controlled) && veh.controlled;

    if(!(isDefined(veh.isstunned) && veh.isstunned)) {
      if(weapon.dostun && mod == "MOD_GRENADE_SPLASH") {
        veh.isstunned = 1;
        veh.noshoot = 1;
        veh notify(#"fire_stop");
        veh cancelaimove();

        if(issentient(veh)) {
          veh clearentitytarget();
        }

        veh function_d4c687c9();
        veh vehclearlookat();
        veh disablegunnerfiring(0, 1);
        angles = veh function_bc2f1cb8(0);
        veh turretsettargetangles(0, angles + (50, 0, 0));

        if(controlled && isDefined(owner)) {
          owner val::set(#"veh", "freezecontrols", 1);
          owner clientfield::set_to_player("static_postfx", 1);
        }

        veh clientfield::set("stun", 1);
        waitresult = veh waittilltimeout(duration, #"death");

        if(controlled && isDefined(owner)) {
          owner clientfield::set_to_player("static_postfx", 0);
          owner val::reset(#"veh", "freezecontrols");
        }

        if(!isDefined(veh)) {
          return;
        }

        veh clientfield::set("stun", 0);
        isalive = isalive(veh);

        if(isalive) {
          veh turretcleartarget(0);
          veh disablegunnerfiring(0, 0);
          veh.noshoot = undefined;
          veh.isstunned = undefined;
        }

        if(waitresult._notify == "death") {
          return;
        }
      }
    }
  }
}

stop_monitor_missiles_locked_on_to_me() {
  self notify(#"stop_monitor_missile_locked_on_to_me");
}

get_closest_attacker_with_missile_locked_on_to_me(monitored_entity) {
  assert(isDefined(monitored_entity.target_group), "<dev string:x36b>");
  player = self;
  closest_attacker = undefined;
  closest_attacker_dot = -999;
  view_origin = player getplayercamerapos();
  view_forward = anglesToForward(player getplayerangles());
  remaining_locked_on_flags = 0;

  foreach(target_ent in monitored_entity.target_group) {
    if(isDefined(target_ent) && isDefined(target_ent.locked_on)) {
      remaining_locked_on_flags |= target_ent.locked_on;
    }
  }

  for(i = 0; remaining_locked_on_flags && i < level.players.size; i++) {
    attacker = level.players[i];

    if(isDefined(attacker)) {
      client_flag = 1 << attacker getentitynumber();

      if(client_flag&remaining_locked_on_flags) {
        to_attacker = vectornormalize(attacker.origin - view_origin);
        attacker_dot = vectordot(view_forward, to_attacker);

        if(attacker_dot > closest_attacker_dot) {
          closest_attacker = attacker;
          closest_attacker_dot = attacker_dot;
        }

        remaining_locked_on_flags &= ~client_flag;
      }
    }
  }

  return closest_attacker;
}

set_vehicle_drivable_time_starting_now(duration_ms) {
  end_time_ms = gettime() + duration_ms;
  set_vehicle_drivable_time(duration_ms, end_time_ms);
  return end_time_ms;
}

set_vehicle_drivable_time(duration_ms, end_time_ms) {
  self setvehicledrivableduration(duration_ms);
  self setvehicledrivableendtime(end_time_ms);
}

update_damage_as_occupant(damage_taken, max_health) {
  damage_taken_normalized = math::clamp(damage_taken / max_health, 0, 1);
  self setvehicledamagemeter(damage_taken_normalized);
}

stop_monitor_damage_as_occupant() {
  self notify(#"stop_monitor_damage_as_occupant");
}

monitor_damage_as_occupant(player) {
  player notify(#"stop_monitor_damage_as_occupant");
  player endon(#"stop_monitor_damage_as_occupant", #"disconnect");
  self endon(#"death");

  if(!isDefined(self.maxhealth)) {
    self.maxhealth = self.healthdefault;
  }

  wait 0.1;
  player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);

  while(true) {
    self waittill(#"damage");
    waittillframeend();
    player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
  }
}

kill_vehicle(attackingplayer, weapon = level.weaponnone) {
  damageorigin = self.origin + (0, 0, 1);
  self finishvehicleradiusdamage(attackingplayer, attackingplayer, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", weapon, damageorigin, 400, -1, (0, 0, 1), 0);
}

function_eb183ffe(attackingplayer, weapon) {
  kill_vehicle(attackingplayer, weapon);
}

player_is_driver() {
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

laser_death_watcher() {
  self notify(#"laser_death_thread_stop");
  self endon(#"laser_death_thread_stop");
  self waittill(#"death");

  if(isDefined(self)) {
    self laseroff();
  }
}

enable_laser(b_enable, n_index) {
  if(b_enable) {
    self laseron();
    self thread laser_death_watcher();
    return;
  }

  self laseroff();
  self notify(#"laser_death_thread_stop");
}

vehicle_spawner_tool() {
  vehicleassets = function_951b4205();

  if(vehicleassets.size == 0) {
    return;
  }

  type_index = 0;

  while(true) {
    if(getdvarint(#"debug_vehicle_spawn", 0) > 0) {
      player = getplayers()[0];
      dynamic_spawn_hud = newdebughudelem(player);
      dynamic_spawn_hud.alignx = "<dev string:x38d>";
      dynamic_spawn_hud.x = 20;
      dynamic_spawn_hud.y = 395;
      dynamic_spawn_hud.fontscale = 1;
      dynamic_spawn_dummy_model = spawn("<dev string:x394>", (0, 0, 0));

      while(getdvarint(#"debug_vehicle_spawn", 0) > 0) {
        origin = player.origin + anglesToForward(player getplayerangles()) * 270;
        origin += (0, 0, 40);

        if(player usebuttonpressed()) {
          dynamic_spawn_dummy_model hide();
          vehicle = spawnvehicle(vehicleassets[type_index].name, origin, player.angles, "<dev string:x3a3>");
          vehicle makevehicleusable();

          if(getdvarint(#"debug_vehicle_spawn", 0) == 1) {
            setdvar(#"debug_vehicle_spawn", 0);
            continue;
          }

          wait 0.3;
        }

        if(player buttonpressed("<dev string:x3b9>")) {
          dynamic_spawn_dummy_model hide();
          type_index++;

          if(type_index >= vehicleassets.size) {
            type_index = 0;
          }

          wait 0.3;
        }

        if(player buttonpressed("<dev string:x3c6>")) {
          dynamic_spawn_dummy_model hide();
          type_index--;

          if(type_index < 0) {
            type_index = vehicleassets.size - 1;
          }

          wait 0.3;
        }

        dynamic_spawn_hud settext("<dev string:x3d2>" + function_9e72a96(vehicleassets[type_index].name));
        dynamic_spawn_dummy_model setModel(vehicleassets[type_index].model);
        dynamic_spawn_dummy_model show();
        dynamic_spawn_dummy_model notsolid();
        dynamic_spawn_dummy_model.origin = origin;
        dynamic_spawn_dummy_model.angles = player.angles;
        waitframe(1);
      }

      dynamic_spawn_hud destroy();
      dynamic_spawn_dummy_model delete();
    }

    wait 2;
  }
}

spline_debug() {
  level flag::init("<dev string:x3f3>");
  level thread _spline_debug();

  while(true) {
    if(flag::exists("<dev string:x3f3>")) {
      level flag::set_val("<dev string:x3f3>", getdvarint(#"g_vehicledrawsplines", 0));
    }

    waitframe(1);
  }
}

_spline_debug() {
  while(true) {
    level flag::wait_till("<dev string:x3f3>");

    foreach(nd in getallvehiclenodes()) {
      nd show_node_debug_info();
    }

    waitframe(1);
  }
}

show_node_debug_info() {
  self.n_debug_display_count = 0;

  if(is_unload_node()) {
    print_debug_info("<dev string:x40b>" + self.script_unload + "<dev string:x417>");
  }

  if(isDefined(self.script_notify)) {
    print_debug_info("<dev string:x41b>" + self.script_notify + "<dev string:x417>");
  }

  if(isDefined(self.script_delete) && self.script_delete) {
    print_debug_info("<dev string:x427>");
  }
}

print_debug_info(str_info) {
  self.n_debug_display_count++;
  print3d(self.origin - (0, 0, self.n_debug_display_count * 20), str_info, (0, 0, 1), 1, 1);
}

function_96b5f1c3(vh_target, n_seat) {
  if(isbot(self) && isDefined(vh_target.var_3a60b519) && vh_target.var_3a60b519) {
    return false;
  }

  if(isDefined(vh_target) && isalive(self) && !self laststand::player_is_in_laststand() && isDefined(vh_target function_dcef0ba1(n_seat)) && vh_target function_dcef0ba1(n_seat) && !vh_target isvehicleseatoccupied(n_seat)) {
    return true;
  }

  return false;
}

private function_bbd487c2() {
  e_player = self.owner;

  if(!isDefined(e_player)) {
    self thread util::auto_delete();
    return;
  }

  self endon(#"death", #"enter_vehicle");
  e_player endon(#"disconnect");
  level endon(#"game_ended");

  for(b_do_delete = 0; !b_do_delete; b_do_delete = 1) {
    wait 5;
    dist = distance2d(self.origin, e_player.origin);

    if(isalive(e_player) && dist > 3000) {}
  }

  self thread util::auto_delete();
}

function_93844822(e_player, b_skip_scene, b_enter = 1) {
  var_40a72df6 = "";

  if(!b_enter) {
    s_info = self function_831cd622(e_player);
  }

  if(!b_skip_scene) {
    if(b_enter) {
      debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");

      if(debug_scene != "") {
        str_scene = debug_scene;
      } else if(isDefined(self.script_vh_entrance)) {
        str_scene = self.script_vh_entrance;
      } else if(isDefined(self.settings) && isDefined(self.settings.var_fbbdbf11)) {
        str_scene = self.settings.var_fbbdbf11;

        if(!isDefined(e_player.companion)) {
          var_3966de80 = str_scene;
          var_3966de80 += "_solo";
          scene = getscriptbundle(var_3966de80);

          if(isDefined(scene)) {
            str_scene = var_3966de80;
          }
        }

        var_9d0b2a04 = vectordot(anglestoright(self.angles), vectornormalize(self.origin - e_player.origin));

        if(var_9d0b2a04 > 0) {
          var_664b49b8 = "left";
        } else {
          var_664b49b8 = "right";
        }

        str_shot = var_664b49b8 + var_40a72df6;
      }
    } else {
      debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");

      if(debug_scene != "") {
        str_scene = debug_scene;
      } else if(isDefined(self.var_a5fbf4c5)) {
        str_scene = self.var_a5fbf4c5;
      } else if(isDefined(self.settings) && isDefined(self.settings.var_ffbed7fd)) {
        str_scene = self.settings.var_ffbed7fd;

        if(!isDefined(e_player.companion)) {
          var_3966de80 = str_scene;
          var_3966de80 += "_solo";
          scene = getscriptbundle(var_3966de80);

          if(isDefined(scene)) {
            str_scene = var_3966de80;
          }
        }

        var_664b49b8 = s_info.var_664b49b8;
        str_shot = var_664b49b8 + var_40a72df6;
      }
    }

    if(isDefined(str_scene) && str_scene != "") {
      if(isDefined(e_player.companion) && e_player.companion isplayinganimscripted()) {
        e_player.companion stopanimscripted();
        util::wait_network_frame();
      }

      self notify(#"hash_376d57a458a131df");
      a_ents = array(e_player);

      if(isalive(e_player.companion) && scene::function_d1dd6e60(str_scene) > 0) {
        if(!isDefined(a_ents)) {
          a_ents = [];
        } else if(!isarray(a_ents)) {
          a_ents = array(a_ents);
        }

        a_ents[a_ents.size] = e_player.companion;
      }

      if(scene::get_vehicle_count(str_scene) > 0) {
        if(!isDefined(a_ents)) {
          a_ents = [];
        } else if(!isarray(a_ents)) {
          a_ents = array(a_ents);
        }

        a_ents[a_ents.size] = self;
      }

      if(isDefined(str_shot)) {
        self thread scene::play(str_scene, str_shot, a_ents);
      } else {
        self thread scene::play(str_scene, a_ents);
      }

      e_player flagsys::wait_till_clear("scene");
      self notify(#"vehicle_scene_done");
    }

    if(!b_enter) {
      if(isDefined(s_info.v_teleport_pos)) {
        e_player setorigin(s_info.v_teleport_pos);
      }

      if(isDefined(s_info.v_teleport_angles)) {
        e_player setplayerangles(s_info.v_teleport_angles);
      }

      if(isDefined(s_info.var_ad3d636d)) {
        e_player.companion setorigin(s_info.var_ad3d636d);
      }
    }
  }
}

private function_831cd622(e_player) {
  s_info = {};
  v_movement = e_player getnormalizedmovement();

  if(self.archetype === #"fav") {
    var_d526c0e4 = self.origin + anglestoright(self.angles) * 115;
    var_c1af71a1 = self.origin + anglestoright(self.angles) * -125;
    var_b44997b4 = self.origin + anglesToForward(self.angles) * -110;

    if(v_movement[1] < 0 && ispointonnavmesh(var_c1af71a1) && bullettracepassed(self.origin + (0, 0, 75), var_c1af71a1 + (0, 0, 5), 1, self)) {
      s_info.var_664b49b8 = "left";
    } else if(ispointonnavmesh(var_d526c0e4) && bullettracepassed(self.origin + (0, 0, 75), var_d526c0e4 + (0, 0, 5), 1, self)) {
      s_info.var_664b49b8 = "right";
    } else {
      s_info.var_664b49b8 = "left";
      s_info.v_teleport_pos = getclosestpointonnavmesh(self.origin, 256, 16);
    }

    if(!ispointonnavmesh(var_b44997b4) || !bullettracepassed(self.origin + (0, 0, 75), var_b44997b4 + (0, 0, 75), 1, self)) {
      s_info.var_ad3d636d = getclosestpointonnavmesh(self.origin, 256, 16);
    }
  } else if(self.archetype === #"quad") {
    var_d526c0e4 = self.origin + anglestoright(self.angles) * 85;
    var_c1af71a1 = self.origin + anglestoright(self.angles) * -85;

    if(v_movement[1] < 0 && ispointonnavmesh(var_c1af71a1)) {
      s_info.var_664b49b8 = "left";
      s_info.v_teleport_pos = getclosestpointonnavmesh(var_c1af71a1, 256, 16);
    } else {
      s_info.var_664b49b8 = "right";
      s_info.v_teleport_pos = getclosestpointonnavmesh(var_d526c0e4, 256, 16);
    }

    s_info.v_teleport_angles = (0, self.angles[1], 0);
  } else if(v_movement[1] < 0) {
    s_info.var_664b49b8 = "left";
  } else {
    s_info.var_664b49b8 = "right";
  }

  return s_info;
}

function_19bd94a1(var_3051fdcd, b_one_shot = 0) {
  level endon(#"game_ended");
  a_vehicles = self;

  if(!isarray(a_vehicles)) {
    if(!isDefined(a_vehicles)) {
      a_vehicles = [];
    } else if(!isarray(a_vehicles)) {
      a_vehicles = array(a_vehicles);
    }
  }

  foreach(vh in a_vehicles) {
    vh.script_vh_entrance = var_3051fdcd;
  }

  if(b_one_shot) {
    array::wait_till(a_vehicles, "vehicle_scene_done");

    foreach(vh in a_vehicles) {
      if(isDefined(vh)) {
        vh.script_vh_entrance = undefined;
      }
    }
  }
}

function_1e82f829(var_35304872, b_one_shot = 0) {
  level endon(#"game_ended");
  a_vehicles = self;

  if(!isarray(a_vehicles)) {
    if(!isDefined(a_vehicles)) {
      a_vehicles = [];
    } else if(!isarray(a_vehicles)) {
      a_vehicles = array(a_vehicles);
    }
  }

  foreach(vh in a_vehicles) {
    vh.var_a5fbf4c5 = var_35304872;
  }

  if(b_one_shot) {
    array::wait_any(a_vehicles, "vehicle_scene_done");

    foreach(vh in a_vehicles) {
      if(isDefined(vh)) {
        vh.var_a5fbf4c5 = undefined;
      }
    }
  }
}

event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(isvehicle(eventstruct.vehicle)) {
    if(!isDefined(eventstruct.seat_index)) {
      return;
    }

    var_fd110a27 = eventstruct.vehicle function_a3f90231(eventstruct.seat_index);

    if(!isDefined(var_fd110a27)) {
      return;
    }

    var_8730ee3e = getscriptbundle(var_fd110a27);

    if(isDefined(var_8730ee3e)) {
      if(isDefined(var_8730ee3e.zmenhancedstatejukeinit) && var_8730ee3e.zmenhancedstatejukeinit) {
        if(!isDefined(eventstruct.vehicle.t_sarah_foy_objective__indicator_)) {
          eventstruct.vehicle.t_sarah_foy_objective__indicator_ = [];
        }

        if(isDefined(eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index]) && eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index]) {
          return;
        }

        eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index] = 1;
      }

      rightvecdot = vectordot(anglestoright(eventstruct.vehicle.angles), vectornormalize(self.origin - eventstruct.vehicle.origin));

      if(rightvecdot > 0) {
        animation = var_8730ee3e.var_9b47c071;
      } else {
        animation = var_8730ee3e.var_9323d5c1;
      }

      if(isDefined(animation)) {
        self animscripted("vehicle_enter_anim", eventstruct.vehicle function_5051cc0c(eventstruct.seat_index), eventstruct.vehicle function_90d45d34(eventstruct.seat_index), animation, "server script", undefined, 1, undefined, undefined, undefined, 1);
      }

      vehicleanim = var_8730ee3e.vehicleenteranim;

      if(isDefined(vehicleanim)) {
        eventstruct.vehicle setanimknobrestart(vehicleanim, 1, 0, 1);
      }
    }
  }
}

event_handler[change_seat] function_124469f4(eventstruct) {
  if(isvehicle(eventstruct.vehicle)) {
    if(!isDefined(eventstruct.seat_index)) {
      return;
    }

    var_fd110a27 = eventstruct.vehicle function_a3f90231(eventstruct.seat_index);

    if(!isDefined(var_fd110a27)) {
      return;
    }

    var_8730ee3e = getscriptbundle(var_fd110a27);

    if(isDefined(var_8730ee3e)) {
      if(!(isDefined(var_8730ee3e.var_8d496bb1) && var_8730ee3e.var_8d496bb1)) {
        return;
      }

      if(isDefined(var_8730ee3e.zmenhancedstatejukeinit) && var_8730ee3e.zmenhancedstatejukeinit) {
        if(!isDefined(eventstruct.vehicle.t_sarah_foy_objective__indicator_)) {
          eventstruct.vehicle.t_sarah_foy_objective__indicator_ = [];
        }

        if(isDefined(eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index]) && eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index]) {
          return;
        }

        eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index] = 1;
      }

      rightvecdot = vectordot(anglestoright(eventstruct.vehicle.angles), vectornormalize(self.origin - eventstruct.vehicle.origin));

      if(rightvecdot > 0) {
        animation = var_8730ee3e.var_9b47c071;
      } else {
        animation = var_8730ee3e.var_9323d5c1;
      }

      if(isDefined(animation)) {
        self animscripted("vehicle_enter_anim", eventstruct.vehicle function_5051cc0c(eventstruct.seat_index), eventstruct.vehicle function_90d45d34(eventstruct.seat_index), animation, "server script", undefined, 1, undefined, undefined, undefined, 1);
      }

      vehicleanim = var_8730ee3e.vehicleenteranim;

      if(isDefined(vehicleanim)) {
        eventstruct.vehicle setanimknobrestart(vehicleanim, 1, 0, 1);
      }
    }
  }
}

function_fa8ced6e(v_origin, v_angles, str_vehicle = undefined) {
  if(self isinvehicle()) {
    return self getvehicleoccupied();
  }

  assert(isDefined(str_vehicle), "<dev string:x430>");
  var_80730518 = spawnvehicle(str_vehicle, v_origin, v_angles, "player_spawned_vehicle");
  var_80730518 usevehicle(self, 0);
  return var_80730518;
}

function_715433be(vehicle, bot, n_seat) {
  if(isbot(bot) && n_seat == 0) {
    if(vehicle vehicle_ai::has_state("off")) {
      vehicle vehicle_ai::set_state("off");
    }
  }
}

function_a29610b6(x, k) {
  if(x < -1) {
    x = -1;
  } else if(x > 1) {
    x = 1;
  }

  if(k < -1) {
    k = -1;
  } else if(k > 1) {
    k = 1;
  }

  numerator = x - x * k;
  denominator = k - abs(x) * 2 * k + 1;
  result = numerator / denominator;
  return result;
}

update_flare_ability(player, var_55716d54, active_time = 5, cooldown_time = 10, flare_tag = undefined) {
  var_a86d6798 = "update_flare_ability";
  self notify(var_a86d6798);
  self endon(#"death", var_a86d6798);
  var_bca5c6c1 = active_time;
  flarecooldown = cooldown_time;

  if(!self flag::exists("flares_available")) {
    self flag::init("flares_available", 1);
  } else {
    self flag::set("flares_available");
  }

  player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 1);

  while(isDefined(player.vh_vehicle) && player function_e01d381a()) {
    waitframe(1);
  }

  self.var_40d7d1f2 = 0;

  while(isDefined(player) && (isDefined(player.vh_vehicle) || self.var_40d7d1f2)) {
    assert(!(isDefined(self.var_40d7d1f2) && self.var_40d7d1f2));

    if(player function_e01d381a()) {
      self flag::clear("flares_available");
      self.var_40d7d1f2 = 1;
      player playsoundtoplayer(#"hash_35af2f72517d10ab", player);
      self fire_flares(player, flare_tag, active_time);
      player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 0);
      wait var_bca5c6c1;
      self.var_40d7d1f2 = 0;
      level thread function_1bb979ca(flarecooldown, player, var_55716d54);
      player playsoundtoplayer(#"hash_62742dd7b6e513e", player);
      self flag::set("flares_available");
    }

    waitframe(1);
  }
}

function_8aab5d53(player, var_55716d54) {
  self endon(#"death");
  player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 0);

  while(isDefined(player) && isDefined(player.vh_vehicle)) {
    var_42775dfe = 0;

    if(player function_b835102b()) {
      var_42775dfe = player function_dd63190a();
    } else {
      var_759ec838 = player getvehicleboosttime();
      boosttimeleft = player getvehicleboosttimeleft();

      if(var_759ec838 > 0) {
        var_42775dfe = boosttimeleft / var_759ec838;
      }
    }

    player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", var_42775dfe);
    wait 0.05;
  }
}

private function_1eab63e3(flare_lifetime = undefined) {
  if(!isDefined(flare_lifetime)) {
    flare_lifetime = 3;
  }

  lifetimes = [];

  for(var_b2814b11 = 0; var_b2814b11 < 4; var_b2814b11++) {
    if(!isDefined(lifetimes)) {
      lifetimes = [];
    } else if(!isarray(lifetimes)) {
      lifetimes = array(lifetimes);
    }

    lifetimes[lifetimes.size] = flare_lifetime - var_b2814b11 * 0.3;
  }

  lifetimes = array::randomize(lifetimes);

  foreach(key, value in lifetimes) {
    if(value == flare_lifetime) {
      lifetimes[key] += key * 0.15;
    }
  }

  return lifetimes;
}

fire_flares(player, flare_tag = undefined, flare_lifetime = undefined) {
  var_f9a2afb9 = function_1eab63e3(flare_lifetime);

  for(var_558d81a6 = 0; var_558d81a6 < 4; var_558d81a6++) {
    model = "tag_origin";

    if(!isDefined(flare_tag)) {
      self.var_70eddc3b = !(isDefined(self.var_70eddc3b) && self.var_70eddc3b);
      start_tag = self.var_70eddc3b ? "tag_fx_flare_left" : "tag_fx_flare_right";
      start_origin = self gettagorigin(start_tag);
    } else {
      start_origin = self gettagorigin(flare_tag);
    }

    if(!isDefined(start_origin)) {
      start_origin = self gettagorigin("tag_origin") + (0, 0, 128);
    }

    if(isDefined(flare_tag)) {
      var_ac3aef54 = self gettagangles(flare_tag);
    }

    if(!isDefined(var_ac3aef54)) {
      var_ac3aef54 = self.angles;
    }

    flare = util::spawn_model(model, start_origin, var_ac3aef54);
    flare clientfield::set("play_flare_fx", 1);
    flare_lifetime = max(var_f9a2afb9[var_558d81a6] - var_558d81a6 * 0.15, 0.5);
    flare thread move_flare(self, (0, 0, -200), 0.5, 0.25, flare_lifetime, flare_tag);
    flare thread function_9ff1a886(self);
    wait 0.15;
  }
}

function_e863c9af(owner, var_8fbb46cd, var_abfdfad5) {
  ownerforward = anglesToForward(owner.angles);

  if(!var_abfdfad5) {
    var_538c5a93 = vectornormalize((ownerforward[0], ownerforward[1], 0));
    velocity = var_538c5a93 * 1000;
    var_43fa4fb6 = vectornormalize((var_8fbb46cd[0], var_8fbb46cd[1], 0));
    velocity += function_7786cb5e(var_43fa4fb6, owner getvelocity()) * 1.2;
  } else {
    ownerforward = vectornormalize(ownerforward);
    velocity = ownerforward * 1000;
    var_8fbb46cd = vectornormalize(var_8fbb46cd);
    velocity += owner getvelocity() * 1.2;
  }

  velocity += (0, 0, 1) * 275;
  return velocity;
}

function_7786cb5e(var_95d2171d, vector) {
  vector2d = (vector[0], vector[1], 0);
  dot = vectordot(var_95d2171d, vector2d);

  if(dot < 0) {
    vector2d -= var_95d2171d * dot;
  }

  return vector2d;
}

move_flare(owner, gravity, var_2434a7ac, var_2d0d8b66, max_time, flare_tag = undefined) {
  self endon(#"death");
  start_time = gettime();
  var_6de53efa = start_time + var_2434a7ac * 1000;
  end_time = start_time + max_time * 1000;

  if(isDefined(flare_tag)) {
    var_4626a28f = owner gettagangles(flare_tag);
    var_abfdfad5 = 1;
  } else {
    var_4626a28f = owner.angles;
    var_abfdfad5 = 0;
  }

  velocity = function_e863c9af(owner, anglesToForward(var_4626a28f), var_abfdfad5);
  var_c1ad7c79 = vectornormalize(velocity);

  while(gettime() < end_time) {
    if(gettime() > var_6de53efa) {
      newvelocity = velocity * (1 - (gettime() - var_6de53efa) / 1000 / (max_time - var_2434a7ac));
    } else {
      velocity = self getvelocity();
      var_c18f874c = vectornormalize(velocity);
      var_40a3c87d = function_e863c9af(owner, var_c18f874c, var_abfdfad5);
      velocity = lerpvector(velocity, var_40a3c87d, 0.5);
      newvelocity = velocity;
    }

    newvelocity += gravity * (gettime() - start_time) / 1000;
    movetopos = self.origin + newvelocity * var_2d0d8b66;
    traceresult = bulletTrace(self.origin, movetopos, 0, owner, 0, 0, self);

    if(traceresult[#"fraction"] < 1) {
      if(traceresult[#"fraction"] > 0) {
        movetopos = traceresult[#"position"] + traceresult[#"normal"] * 0.1;
        var_2d0d8b66 *= traceresult[#"fraction"];
        self moveto(movetopos, var_2d0d8b66);
        self waittill(#"movedone");
      }

      break;
    }

    self moveto(movetopos, var_2d0d8b66);
    wait var_2d0d8b66;
  }

  if(gettime() < end_time) {
    wait(end_time - gettime()) / 1000;
  }

  self delete();
}

function_b5f1f39(missile) {
  self endon(#"death");
  self thread heatseekingmissile::missiletarget_proximitydetonate(missile, missile.owner, missile.weapon, "death");
  missile waittill(#"death");
  self clientfield::set("play_flare_fx", 0);
  self clientfield::set("play_flare_hit_fx", 1);
  util::wait_network_frame();
  self delete();
}

function_d6c00549(owner, var_cc6abdaa) {
  if(isDefined(var_cc6abdaa) && isDefined(var_cc6abdaa.weapon)) {
    if(var_cc6abdaa.weapon.guidedmissiletype === "HeatSeeking" && var_cc6abdaa missile_gettarget() === owner) {
      self thread function_b5f1f39(var_cc6abdaa);
      return true;
    }
  } else {
    foreach(missile in level.missileentities) {
      if(!isDefined(missile) || !isDefined(missile.weapon)) {
        continue;
      }

      if(missile.weapon.guidedmissiletype !== "HeatSeeking") {
        continue;
      }

      if(missile missile_gettarget() === owner) {
        self thread function_b5f1f39(missile);
        return true;
      }
    }
  }

  return false;
}

function_9ff1a886(owner) {
  self endon(#"death");
  owner endon(#"death");
  self.var_8dfaef6b = 0;

  while(!self.var_8dfaef6b) {
    self.var_8dfaef6b = self function_d6c00549(owner);
    waitresult = owner waittill(#"stinger_fired_at_me");
    self.var_8dfaef6b = self function_d6c00549(owner, waitresult.projectile);
  }
}

function_ae93aef2(usephysics) {
  clientfield::set("vehUseMaterialPhysics", usephysics);
}

function_1bb979ca(n_cooldown_time, e_player, var_a18a512) {
  e_player endon(#"death");
  var_e41dced6 = 0;
  var_d969828b = n_cooldown_time / 0.05;

  while(var_e41dced6 <= var_d969828b) {
    var_50d0d640 = mapfloat(0, var_d969828b, 0, 1, var_e41dced6);
    e_player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_a18a512 + ".cooldown", var_50d0d640);
    var_e41dced6++;
    wait 0.05;
  }
}

function_78cfd053() {
  self endon(#"death");
  var_c56865cf = self.healthdefault;
  var_c96543ab = self.var_7812fce8;
  var_70fdf0cb = self.healthpoolsize;
  var_8ac0fa8 = [];

  for(n = 0; n < var_c96543ab; n++) {
    if(n == 0) {
      var_8ac0fa8[n] = var_c56865cf;
      continue;
    }

    var_8ac0fa8[n] = var_c56865cf - var_70fdf0cb * n;
  }

  var_8ac0fa8[var_8ac0fa8.size] = 0;

  while(true) {
    self waittill(#"damage");

    foreach(keys, n_health_threshold in var_8ac0fa8) {
      if(self.health > n_health_threshold) {
        break;
      }
    }

    self thread function_f2fa0421(var_8ac0fa8[keys - 1]);
  }
}

function_f2fa0421(n_health) {
  self notify(#"hash_7d33424c72addcf1");
  self endon(#"death", #"hash_7d33424c72addcf1");

  if(isDefined(level.playerhealth_regularregendelay)) {
    wait float(level.playerhealth_regularregendelay) / 1000;
  } else {
    wait 3;
  }

  var_ab73d707 = int(self.healthdefault * 0.0083);

  while(self.health < n_health) {
    self.health += var_ab73d707;

    if(self.health >= n_health) {
      self.health = n_health;
    }

    a_occupants = self getvehoccupants();

    foreach(e_occupant in a_occupants) {
      if(isplayer(e_occupant)) {
        e_occupant update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
      }
    }

    wait 0.1;
  }
}

function_ff77beb1(otherplayer = undefined) {
  if(!isDefined(self)) {
    return;
  }

  player = self;

  if(isDefined(player.var_19bc935c)) {
    player swap_character(player.var_19bc935c);
    player weapons::force_stowed_weapon_update();
    player.var_19bc935c = undefined;

    if(isDefined(otherplayer) && isDefined(otherplayer.var_19bc935c)) {
      otherplayer swap_character(otherplayer.var_19bc935c);
      otherplayer weapons::force_stowed_weapon_update();
      otherplayer.var_19bc935c = undefined;
    }

    return;
  }

  if(isDefined(otherplayer)) {
    var_9db4bbbe = spawnStruct();
    var_9db4bbbe.tag_stowed_back_weapon = player.tag_stowed_back;
    var_9db4bbbe.var_b6233805 = player.tag_stowed_hip;
    var_9db4bbbe.stowed_weapon = player getstowedweapon();
    var_9db4bbbe.bodytype = player getcharacterbodytype();
    var_9db4bbbe.outfit = player getcharacteroutfit();
    var_d8d89950 = spawnStruct();
    var_d8d89950.tag_stowed_back_weapon = otherplayer.tag_stowed_back;
    var_d8d89950.var_b6233805 = otherplayer.tag_stowed_hip;
    var_d8d89950.stowed_weapon = otherplayer getstowedweapon();
    var_d8d89950.bodytype = otherplayer getcharacterbodytype();
    var_d8d89950.outfit = otherplayer getcharacteroutfit();

    if(!isDefined(player.var_19bc935c)) {
      player.var_19bc935c = var_9db4bbbe;
    }

    if(!isDefined(otherplayer.var_19bc935c)) {
      otherplayer.var_19bc935c = var_d8d89950;
    }

    otherplayer swap_character(var_9db4bbbe);
    otherplayer function_269b4eca(var_9db4bbbe);
    player swap_character(var_d8d89950);
    player function_269b4eca(var_d8d89950);
  }
}

swap_character(var_19bc935c) {
  player = self;
  player setcharacterbodytype(var_19bc935c.bodytype);
  player setcharacteroutfit(var_19bc935c.outfit);
}

function_269b4eca(var_19bc935c) {
  player = self;
  player weapons::detach_all_weapons();
  player.tag_stowed_back = var_19bc935c.tag_stowed_back_weapon;

  if(isDefined(player.tag_stowed_back)) {
    player attach(player.tag_stowed_back, "tag_stowed_back", 1);
  } else if(level.weaponnone != var_19bc935c.stowed_weapon) {
    player setstowedweapon(var_19bc935c.stowed_weapon);
  }

  player.tag_stowed_hip = var_19bc935c.tag_stowed_back_weapon;

  if(isDefined(player.tag_stowed_hip)) {
    player attach(player.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
  }
}

function_16e6c35e(vehicle, player, seatindex) {
  if(isDefined(level.var_2513e40c)) {
    return [[level.var_2513e40c]](vehicle, player, seatindex);
  }

  return 1;
}