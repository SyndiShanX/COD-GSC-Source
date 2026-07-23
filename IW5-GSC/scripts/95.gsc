/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\95.gsc
**************************************/

init_vehicles() {
  if(isDefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }
  level.heli_default_decel = 10;
  init_helicopter_list();
  init_airplane_list();
  setup_dvars();
  setup_levelvars();
  setup_vehicle_spawners();
  common_scripts\utility::array_thread(getEntArray("truckjunk", "targetname"), ::truckjunk);
  common_scripts\utility::array_thread(getEntArray("truckjunk", "script_noteworthy"), ::truckjunk);
  common_scripts\utility::array_thread(common_scripts\utility::getStructArray("truckjunk", "targetname"), ::truckjunk);
  common_scripts\utility::array_thread(common_scripts\utility::getStructArray("truckjunk", "script_noteworthy"), ::truckjunk);
  setup_ai();
  setup_triggers();
  var_0 = precache_scripts();
  setup_vehicles(var_0);
  common_scripts\utility::array_levelthread(level.vehicle_processtriggers, ::trigger_process, var_0);
  common_scripts\utility::array_thread(common_scripts\utility::getStructArray("gag_stage_littlebird_unload", "script_noteworthy"), ::setup_gag_stage_littlebird_unload);
  common_scripts\utility::array_thread(common_scripts\utility::getStructArray("gag_stage_littlebird_load", "script_noteworthy"), ::setup_gag_stage_littlebird_load);
  level.vehicle_processtriggers = undefined;
  init_level_has_vehicles();
  maps\_utility::add_hint_string("invulerable_frags", &"SCRIPT_INVULERABLE_FRAGS", undefined);
  maps\_utility::add_hint_string("invulerable_bullets", &"SCRIPT_INVULERABLE_BULLETS", undefined);
}

init_helicopter_list() {
  level.helicopter_list = [];
  level.helicopter_list["blackhawk"] = 1;
  level.helicopter_list["blackhawk_minigun"] = 1;
  level.helicopter_list["apache"] = 1;
  level.helicopter_list["seaknight"] = 1;
  level.helicopter_list["seaknight_airlift"] = 1;
  level.helicopter_list["hind"] = 1;
  level.helicopter_list["ny_harbor_hind"] = 1;
  level.helicopter_list["ny_harbor_blackhawk"] = 1;
  level.helicopter_list["mi17"] = 1;
  level.helicopter_list["mi17_noai"] = 1;
  level.helicopter_list["cobra"] = 1;
  level.helicopter_list["cobra_player"] = 1;
  level.helicopter_list["viper"] = 1;
  level.helicopter_list["littlebird_player"] = 1;
  level.helicopter_list["littlebird"] = 1;
  level.helicopter_list["mi28"] = 1;
  level.helicopter_list["pavelow"] = 1;
  level.helicopter_list["pavelow_noai"] = 1;
  level.helicopter_list["harrier"] = 1;
  level.helicopter_list["lynx"] = 1;
  level.helicopter_list["blackhawk_so"] = 1;
  level.helicopter_list["blackhawk_minigun_so"] = 1;
  level.helicopter_list["blackhawk_minigun_so_ac130"] = 1;
  level.helicopter_list["cobra_so"] = 1;
  level.helicopter_list["mi17_so"] = 1;
  level.helicopter_list["mi17_so_takes_damage"] = 1;
  level.helicopter_list["littlebird_so"] = 1;
}

init_airplane_list() {
  level.airplane_list = [];
  level.airplane_list["mig29"] = 1;
  level.airplane_list["b2"] = 1;
  level.airplane_list["a10_warthog"] = 1;
  level.airplane_list["osprey"] = 1;
}

init_level_has_vehicles() {
  level.levelhasvehicles = 0;
  var_0 = getEntArray("script_vehicle", "code_classname");

  if(var_0.size > 0) {
    level.levelhasvehicles = 1;
  }
}

trigger_getlinkmap(var_0) {
  var_1 = [];

  if(isDefined(var_0.script_linkto)) {
    var_2 = strtok(var_0.script_linkto, " ");

    foreach(var_4 in var_2) {}
    var_1[var_4] = 1;

    var_2 = undefined;
  }

  return var_1;
}

setup_script_gatetrigger(var_0) {
  var_1 = [];

  if(isDefined(var_0.script_gatetrigger)) {
    return level.vehicle_gatetrigger[var_0.script_gatetrigger];
  }
  return var_1;
}

setup_script_vehiclespawngroup(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0.script_vehiclespawngroup)) {
    var_2 = 1;
  }
  return var_2;
}

setup_vehicle_spawners() {
  var_0 = _getvehiclespawnerarray();

  foreach(var_2 in var_0) {}
  var_2 thread vehicle_spawn_think();
}

vehicle_spawn_think() {
  if(isDefined(self.script_kill_vehicle_spawner)) {
    var_0 = self.script_kill_vehicle_spawner;

    if(!isDefined(level.vehicle_killspawn_groups[var_0])) {
      level.vehicle_killspawn_groups[var_0] = [];
    }
    level.vehicle_killspawn_groups[var_0][level.vehicle_killspawn_groups[var_0].size] = self;
  }

  if(isDefined(self.script_deathflag)) {
    thread maps\_spawner::vehicle_spawner_deathflag();
  }
  thread vehicle_linked_entities_think();
  self.count = 1;
  self.spawn_functions = [];

  for(;;) {
    var_1 = undefined;
    self waittill("spawned", var_1);
    self.count--;

    if(!isDefined(var_1)) {
      continue;
    }
    var_1.spawn_funcs = self.spawn_functions;
    var_1.spawner = self;
    var_1 thread maps\_spawner::run_spawn_functions();
  }
}

vehicle_linked_entities_think() {
  if(!isDefined(self.script_vehiclecargo)) {
    return;
  }
  if(!isDefined(self.script_linkto)) {
    return;
  }
  var_0 = getEntArray(self.script_linkto, "script_linkname");

  if(var_0.size == 0) {
    return;
  }
  var_1 = var_0[0].targetname;
  var_0 = getEntArray(var_1, "targetname");
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.classname == "script_origin") {
      var_2 = var_4;
    }
    var_4 hide();
  }

  foreach(var_4 in var_0) {
    if(var_4 != var_2) {
      var_4 linkTo(var_2);
    }
  }

  self waittill("spawned", var_8);

  foreach(var_4 in var_0) {
    var_4 show();

    if(var_4 != var_2) {
      var_4 linkTo(var_8);
    }
  }

  var_8 waittill("death");

  foreach(var_4 in var_0) {}
  var_4 delete();
}

is_trigger_once() {
  if(!isDefined(self.classname)) {
    return 0;
  }
  if(self.classname == "trigger_multiple") {
    return 1;
  }
  if(self.classname == "trigger_radius") {
    return 1;
  }
  if(self.classname == "trigger_lookat") {
    return 1;
  }
  return self.classname == "trigger_disk";
}

trigger_process(var_0, var_1) {
  var_2 = var_0 is_trigger_once();
  var_0.processed_trigger = undefined;

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "trigger_multiple") {
    var_2 = 0;
  }
  var_3 = setup_script_gatetrigger(var_0);
  var_4 = isDefined(var_0.script_vehiclespawngroup);
  var_5 = isDefined(var_0.script_vehicledetour) && (is_node_script_origin(var_0) || is_node_script_struct(var_0));
  var_6 = isDefined(var_0.detoured) && !(is_node_script_origin(var_0) || is_node_script_struct(var_0));
  var_7 = 1;
  var_1 = undefined;

  while(var_7) {
    var_0 waittill("trigger", var_8);

    if(isDefined(var_0.script_vehicletriggergroup)) {
      if(!isDefined(var_8.script_vehicletriggergroup)) {
        continue;
      }
      if(var_8.script_vehicletriggergroup != var_0.script_vehicletriggergroup) {
        continue;
      }
    }

    if(isDefined(var_0.enabled) && !var_0.enabled) {
      var_0 waittill("enable");
    }
    if(isDefined(var_0.script_flag_set)) {
      if(isDefined(var_8.vehicle_flags)) {
        var_8.vehicle_flags[var_0.script_flag_set] = 1;
      }
      var_8 notify("vehicle_flag_arrived", var_0.script_flag_set);
      common_scripts\utility::flag_set(var_0.script_flag_set);
    }

    if(isDefined(var_0.script_flag_clear)) {
      if(isDefined(var_8.vehicle_flags)) {
        var_8.vehicle_flags[var_0.script_flag_clear] = 0;
      }
      common_scripts\utility::flag_clear(var_0.script_flag_clear);
    }

    if(var_5) {
      var_8 thread path_detour_script_origin(var_0);
    } else if(var_6 && isDefined(var_8)) {
      var_8 thread path_detour(var_0);
    }
    var_0 maps\_utility::script_delay();

    if(var_2) {
      var_7 = 0;
    }
    if(isDefined(var_0.script_vehiclegroupdelete)) {
      if(!isDefined(level.vehicle_deletegroup[var_0.script_vehiclegroupdelete])) {
        level.vehicle_deletegroup[var_0.script_vehiclegroupdelete] = [];
      }
      common_scripts\utility::array_levelthread(level.vehicle_deletegroup[var_0.script_vehiclegroupdelete], maps\_utility::deleteent);
    }

    if(var_4) {
      scripted_spawn(var_0.script_vehiclespawngroup);
    }
    if(var_3.size > 0 && var_2) {
      common_scripts\utility::array_levelthread(var_3, ::path_gate_open);
    }
    if(isDefined(var_0.script_vehiclestartmove)) {
      if(!isDefined(level.vehicle_startmovegroup[var_0.script_vehiclestartmove])) {
        return;
      }
      common_scripts\utility::array_levelthread(level.vehicle_startmovegroup[var_0.script_vehiclestartmove], ::gopath);
    }
  }
}

path_detour_get_detourpath(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.vehicle_detourpaths[var_0.script_vehicledetour]) {
    if(var_3 != var_0) {
      if(!islastnode(var_3)) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

path_detour_script_origin(var_0) {
  var_1 = path_detour_get_detourpath(var_0);

  if(isDefined(var_1)) {
    thread vehicle_paths(var_1);
  }
}

crash_detour_check(var_0) {
  return (isDefined(self.deaddriver) || self.health < self.healthbuffer || var_0.script_crashtype == "forced") && (!isDefined(var_0.derailed) || var_0.script_crashtype == "plane");
}

crash_derailed_check(var_0) {
  return isDefined(var_0.derailed) && var_0.derailed;
}

path_detour(var_0) {
  var_1 = getvehiclenode(var_0.target, "targetname");
  var_2 = path_detour_get_detourpath(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_0.detoured && !isDefined(var_2.script_vehicledetourgroup)) {
    return;
  }
  if(isDefined(var_2.script_crashtype)) {
    if(!crash_detour_check(var_2)) {
      return;
    }
    self notify("crashpath", var_2);
    var_2.derailed = 1;
    self notify("newpath");
    _setswitchnode(var_0, var_2);
    return;
  } else {
    if(crash_derailed_check(var_2)) {
      return;
    }
    if(isDefined(var_2.script_vehicledetourgroup)) {
      if(!isDefined(self.script_vehicledetourgroup)) {
        return;
      }
      if(var_2.script_vehicledetourgroup != self.script_vehicledetourgroup) {
        return;
      }
    }

    self notify("newpath");
    _setswitchnode(var_1, var_2);
    thread detour_flag(var_2);

    if(!islastnode(var_1) && !(isDefined(var_0.scriptdetour_persist) && var_0.scriptdetour_persist)) {
      var_0.detoured = 1;
    }
    self.attachedpath = var_2;
    thread vehicle_paths();

    if(self isphysveh() && isDefined(var_1.script_transmission)) {
      thread reverse_node(var_1);
    }
    return;
  }
}

reverse_node(var_0) {
  self endon("death");
  var_0 waittillmatch("trigger", self);
  self.veh_transmission = var_0.script_transmission;

  if(self.veh_transmission == "forward") {
    vehicle_wheels_forward();
  } else {
    vehicle_wheels_backward();
  }
}

_setswitchnode(var_0, var_1) {
  self setswitchnode(var_0, var_1);
}

detour_flag(var_0) {
  self endon("death");
  self.detouringpath = var_0;
  var_0 waittillmatch("trigger", self);
  self.detouringpath = undefined;
}

vehicle_levelstuff(var_0, var_1) {
  if(isDefined(var_0.script_linkname)) {
    level.vehicle_link = array_2dadd(level.vehicle_link, var_0.script_linkname, var_0);
  }
  if(isDefined(var_0.script_vehiclestartmove)) {
    level.vehicle_startmovegroup = array_2dadd(level.vehicle_startmovegroup, var_0.script_vehiclestartmove, var_0);
  }
  if(isDefined(var_0.script_vehiclegroupdelete)) {
    level.vehicle_deletegroup = array_2dadd(level.vehicle_deletegroup, var_0.script_vehiclegroupdelete, var_0);
  }
}

spawn_array(var_0) {
  var_1 = [];
  var_2 = maps\_utility::ent_flag_exist("no_riders_until_unload");

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = 0;

    if(isDefined(var_4.script_drone)) {
      var_5 = 1;
      var_6 = maps\_utility::dronespawn_bodyonly(var_4);
      var_6 maps\_drone::drone_give_soul();
    } else {
      var_7 = isDefined(var_4.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

      if(isDefined(var_4.script_forcespawn) || var_2) {
        var_6 = var_4 stalingradspawn(var_7);
      } else {
        var_6 = var_4 dospawn(var_7);
      }
    }

    if(!var_5 && !isalive(var_6)) {
      continue;
    }
    var_1[var_1.size] = var_6;
  }

  var_1 = remove_non_riders_from_array(var_1);
  return var_1;
}

remove_non_riders_from_array(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!ai_should_be_added(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

ai_should_be_added(var_0) {
  if(isalive(var_0)) {
    return 1;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_0.classname)) {
    return 0;
  }
  return var_0.classname == "script_model";
}

get_vehicle_ai_spawners() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = getEntArray(self.target, "targetname");

    foreach(var_3 in var_1) {
      if(!issubstr(var_3.code_classname, "actor")) {
        continue;
      }
      if(!(var_3.spawnflags & 1)) {
        continue;
      }
      if(isDefined(var_3.dont_auto_ride)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }
  }

  if(!isDefined(self.script_vehicleride)) {
    return var_0;
  }
  if(isDefined(level.vehicle_ridespawners[self.script_vehicleride])) {
    var_0 = common_scripts\utility::array_combine(var_0, level.vehicle_ridespawners[self.script_vehicleride]);
  }
  return var_0;
}

get_vehicle_ai_riders() {
  if(!isDefined(self.script_vehicleride)) {
    return [];
  }
  if(!isDefined(level.vehicle_rideai[self.script_vehicleride])) {
    return [];
  }
  return level.vehicle_rideai[self.script_vehicleride];
}

spawn_group() {
  if(maps\_utility::ent_flag_exist("no_riders_until_unload") && !maps\_utility::ent_flag("no_riders_until_unload")) {
    return [];
  }
  var_0 = get_vehicle_ai_spawners();

  if(!var_0.size) {
    return [];
  }
  var_1 = [];
  var_2 = spawn_array(var_0);
  var_2 = common_scripts\utility::array_combine(var_2, get_vehicle_ai_riders());
  var_2 = sort_by_startingpos(var_2);

  foreach(var_4 in var_2) {}
  thread maps\_vehicle_aianim::guy_enter(var_4);

  return var_2;
}

spawn_unload_group(var_0) {
  if(!isDefined(var_0)) {
    return spawn_group();
  }
  var_1 = get_vehicle_ai_spawners();

  if(!var_1.size) {
    return [];
  }
  var_2 = [];
  var_3 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_3 = self.vehicletype;
  }
  if(isDefined(level.vehicle_unloadgroups[var_3]) && isDefined(level.vehicle_unloadgroups[var_3][var_0])) {
    var_4 = level.vehicle_unloadgroups[var_3][var_0];

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_6 = var_4[var_5];
      var_2[var_2.size] = var_1[var_6];
    }

    var_7 = spawn_array(var_2);

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_7[var_5].script_startingposition = var_4[var_5];
    }
    var_7 = common_scripts\utility::array_combine(var_7, get_vehicle_ai_riders());
    var_7 = sort_by_startingpos(var_7);

    foreach(var_9 in var_7) {}
    thread maps\_vehicle_aianim::guy_enter(var_9);

    return var_7;
  } else {
    return spawn_group();
  }
}

sort_by_startingpos(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_startingposition)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return common_scripts\utility::array_combine(var_1, var_2);
}

vehicle_rider_walk_setup(var_0) {
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
  var_1 = getnode(self.target, "targetname");

  if(isDefined(var_1)) {
    self.nodeaftervehiclewalk = var_1;
  }
}

runtovehicle(var_0) {
  var_1 = [];
  var_2 = self.climbnode;
  var_3 = self.climbanim;
  var_4 = var_2[0];
  var_5 = 5000;
  var_6 = undefined;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_8 = self gettagorigin(var_2[var_7]);
    var_9 = self gettagangles(var_2[var_7]);
    var_10 = getstartorigin(var_8, var_9, var_3[var_7]);
    var_11 = distance(var_0.origin, var_8);

    if(var_11 < var_5) {
      var_5 = var_11;
      var_4 = var_2[var_7];
      var_6 = var_7;
    }
  }

  var_9 = undefined;
  var_8 = undefined;
  thread runtovehicle_setgoal(var_0);

  while(!var_0.vehicle_goal) {
    var_8 = self gettagorigin(var_2[var_6]);
    var_9 = self gettagangles(var_2[var_6]);
    var_10 = getstartorigin(var_8, var_9, var_3[var_6]);
    var_0 maps\_utility::set_forcegoal();
    var_0 setgoalpos(var_10);
    var_0.goalradius = 64;
    wait 0.25;
  }

  var_0 maps\_utility::unset_forcegoal();

  if(self vehicle_getspeed() < 1) {
    var_0 linkTo(self);
    var_0 animScripted("hopinend", var_8, var_9, var_3[var_6]);
    var_0 waittillmatch("hopinend", "end");
    maps\_utility::guy_enter_vehicle(var_0);
  }
}

runtovehicle_setgoal(var_0) {
  var_0.vehicle_goal = 0;
  self endon("death");
  var_0 endon("death");
  var_0 waittill("goal");
  var_0.vehicle_goal = 1;
}

setup_groundnode_detour(var_0) {
  var_1 = getvehiclenode(var_0.targetname, "target");

  if(!isDefined(var_1)) {
    return;
  }
  var_1.detoured = 0;
  add_proccess_trigger(var_1);
}

turn_unloading_drones_to_ai() {
  var_0 = maps\_vehicle_aianim::get_unload_group();

  foreach(var_3, var_2 in self.riders) {
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(var_0[var_2.vehicle_position])) {
      self.riders[var_3] = maps\_vehicle_aianim::guy_becomes_real_ai(var_2, var_2.vehicle_position);
    }
  }
}

add_proccess_trigger(var_0) {
  if(isDefined(var_0.processed_trigger)) {
    return;
  }
  level.vehicle_processtriggers[level.vehicle_processtriggers.size] = var_0;
  var_0.processed_trigger = 1;
}

islastnode(var_0) {
  if(!isDefined(var_0.target)) {
    return 1;
  }
  if(!isDefined(getvehiclenode(var_0.target, "targetname")) && !isDefined(get_vehiclenode_any_dynamic(var_0.target))) {
    return 1;
  }
  return 0;
}

get_path_getfunc(var_0) {
  var_1 = ::get_from_vehicle_node;

  if(ishelicopter() && isDefined(var_0.target)) {
    if(isDefined(get_from_entity(var_0.target))) {
      var_1 = ::get_from_entity;
    }
    if(isDefined(get_from_spawnstruct(var_0.target))) {
      var_1 = ::get_from_spawnstruct;
    }
  }

  return var_1;
}

path_array_setup(var_0) {
  var_1 = ::get_from_vehicle_node;

  if(ishelicopter() && isDefined(var_0.target)) {
    if(isDefined(get_from_entity(var_0.target))) {
      var_1 = ::get_from_entity;
    }
    if(isDefined(get_from_spawnstruct(var_0.target))) {
      var_1 = ::get_from_spawnstruct;
    }
  }

  var_2 = 0;
  var_3 = [];

  while(isDefined(var_0)) {
    var_3[var_2] = var_0;
    var_2++;

    if(isDefined(var_0.target)) {
      var_0 = [[var_1]](var_0.target);
      continue;
    }

    break;
  }

  return var_3;
}

node_wait(var_0, var_1) {
  if(self.attachedpath == var_0) {
    waittillframeend;
    return;
  }

  var_0 waittillmatch("trigger", self);
}

vehicle_paths(var_0, var_1) {
  if(ishelicopter()) {
    vehicle_paths_helicopter(var_0, var_1);
  } else {
    vehicle_paths_non_heli(var_0);
  }
}

vehicle_paths_non_heli(var_0) {
  self notify("newpath");

  if(isDefined(var_0)) {
    self.attachedpath = var_0;
  }
  var_1 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_1)) {
    return;
  }
  self endon("newpath");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = get_path_getfunc(var_1);

  while(isDefined(var_4)) {
    node_wait(var_4, var_3);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = var_4;

    if(isDefined(var_4.gateopen) && !var_4.gateopen) {
      thread path_gate_wait_till_open(var_4);
    }
    if(isDefined(var_4.script_noteworthy)) {
      self notify(var_4.script_noteworthy);
      self notify("noteworthy", var_4.script_noteworthy);
    }

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_4.script_prefab_exploder)) {
      var_4.script_exploder = var_4.script_prefab_exploder;
      var_4.script_prefab_exploder = undefined;
    }

    if(isDefined(var_4.script_exploder)) {
      var_6 = var_4.script_exploder_delay;

      if(isDefined(var_6)) {
        level maps\_utility::delaythread(var_6, common_scripts\utility::exploder, var_4.script_exploder);
      } else {
        level common_scripts\utility::exploder(var_4.script_exploder);
      }
    }

    if(isDefined(var_4.script_flag_set)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[var_4.script_flag_set] = 1;
      }
      self notify("vehicle_flag_arrived", var_4.script_flag_set);
      common_scripts\utility::flag_set(var_4.script_flag_set);
    }

    if(isDefined(var_4.script_ent_flag_set)) {
      maps\_utility::ent_flag_set(var_4.script_ent_flag_set);
    }
    if(isDefined(var_4.script_ent_flag_clear)) {
      maps\_utility::ent_flag_clear(var_4.script_ent_flag_clear);
    }
    if(isDefined(var_4.script_flag_clear)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[var_4.script_flag_clear] = 0;
      }
      common_scripts\utility::flag_clear(var_4.script_flag_clear);
    }

    if(isDefined(var_4.script_noteworthy)) {
      if(var_4.script_noteworthy == "kill") {
        force_kill();
      }
      if(var_4.script_noteworthy == "godon") {
        godon();
      }
      if(var_4.script_noteworthy == "godoff") {
        godoff();
      }
      if(var_4.script_noteworthy == "deleteme") {
        level thread maps\_utility::deleteent(self);
        return;
      }
    }

    if(isDefined(var_4.script_crashtypeoverride)) {
      self.script_crashtypeoverride = var_4.script_crashtypeoverride;
    }
    if(isDefined(var_4.script_badplace)) {
      self.script_badplace = var_4.script_badplace;
    }
    if(isDefined(var_4.script_turretmg)) {
      self.script_turretmg = var_4.script_turretmg;
    }
    if(isDefined(var_4.script_team)) {
      self.script_team = var_4.script_team;
    }
    if(isDefined(var_4.script_turningdir)) {
      self notify("turning", var_4.script_turningdir);
    }
    if(isDefined(var_4.script_deathroll)) {
      if(var_4.script_deathroll == 0) {
        thread deathrolloff();
      } else {
        thread deathrollon();
      }
    }

    if(isDefined(var_4.script_vehicleaianim)) {
      if(isDefined(var_4.script_parameters) && var_4.script_parameters == "queue") {
        self.queueanim = 1;
      }
    }

    if(isDefined(var_4.script_wheeldirection)) {
      wheeldirectionchange(var_4.script_wheeldirection);
    }
    if(vehicle_should_unload(::node_wait, var_4)) {
      thread unload_node(var_4);
    }
    if(isDefined(var_4.script_transmission)) {
      self.veh_transmission = var_4.script_transmission;

      if(self.veh_transmission == "forward") {
        vehicle_wheels_forward();
      } else {
        vehicle_wheels_backward();
      }
    }

    if(isDefined(var_4.script_brake)) {
      self.veh_brake = var_4.script_brake;
    }
    if(isDefined(var_4.script_pathtype)) {
      self.veh_pathtype = var_4.script_pathtype;
    }
    if(isDefined(var_4.script_ent_flag_wait)) {
      var_7 = 35;

      if(isDefined(var_4.script_decel)) {
        var_7 = var_4.script_decel;
      }
      self vehicle_setspeed(0, var_7);
      maps\_utility::ent_flag_wait(var_4.script_ent_flag_wait);

      if(!isDefined(self)) {
        return;
      }
      var_8 = 60;

      if(isDefined(var_4.script_accel)) {
        var_8 = var_4.script_accel;
      }
      self resumespeed(var_8);
    }

    if(isDefined(var_4.script_delay)) {
      var_7 = 35;

      if(isDefined(var_4.script_decel)) {
        var_7 = var_4.script_decel;
      }
      self vehicle_setspeed(0, var_7);

      if(isDefined(var_4.target)) {
        thread overshoot_next_node([[var_5]](var_4.target));
      }
      var_4 maps\_utility::script_delay();
      self notify("delay_passed");
      var_8 = 60;

      if(isDefined(var_4.script_accel)) {
        var_8 = var_4.script_accel;
      }
      self resumespeed(var_8);
    }

    if(isDefined(var_4.script_flag_wait)) {
      if(!isDefined(self.vehicle_flags)) {
        self.vehicle_flags = [];
      }
      self.vehicle_flags[var_4.script_flag_wait] = 1;
      self notify("vehicle_flag_arrived", var_4.script_flag_wait);
      var_9 = 0;

      if(!common_scripts\utility::flag(var_4.script_flag_wait) || isDefined(var_4.script_delay_post)) {
        var_9 = 1;
        var_8 = 5;
        var_7 = 35;

        if(isDefined(var_4.script_accel)) {
          var_8 = var_4.script_accel;
        }
        if(isDefined(var_4.script_decel)) {
          var_7 = var_4.script_decel;
        }
        vehicle_stop_named("script_flag_wait_" + var_4.script_flag_wait, var_8, var_7);
        thread overshoot_next_node([[var_5]](var_4.target));
      }

      common_scripts\utility::flag_wait(var_4.script_flag_wait);

      if(!isDefined(self)) {
        return;
      }
      if(isDefined(var_4.script_delay_post)) {
        wait(var_4.script_delay_post);

        if(!isDefined(self)) {
          return;
        }
      }

      var_8 = 10;

      if(isDefined(var_4.script_accel)) {
        var_8 = var_4.script_accel;
      }
      if(var_9) {
        vehicle_resume_named("script_flag_wait_" + var_4.script_flag_wait);
      }
      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var_4.script_vehicle_lights_off)) {
      thread lights_off(var_4.script_vehicle_lights_off);
    }
    if(isDefined(var_4.script_vehicle_lights_on)) {
      thread lights_on(var_4.script_vehicle_lights_on);
    }
    if(isDefined(var_4.script_forcecolor)) {
      thread vehicle_script_forcecolor_riders(var_4.script_forcecolor);
    }
    var_3 = var_4;

    if(!isDefined(var_4.target)) {
      break;
    }

    var_4 = [[var_5]](var_4.target);

    if(!isDefined(var_4)) {
      var_4 = var_3;
      break;
    }
  }

  if(isDefined(self.script_turretmg)) {
    if(self.script_turretmg == 1) {
      mgon();
    } else {
      mgoff();
    }
  }

  if(isDefined(var_4.script_land)) {
    thread vehicle_landvehicle();
  }
  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    self notify("delete");
    self delete();
  }
}

vehicle_paths_helicopter(var_0, var_1) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(isDefined(var_0)) {
    self.attachedpath = var_0;
  }
  var_2 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_2;

  if(var_1) {
    self waittill("start_dynamicpath");
  }
  var_4 = undefined;
  var_5 = var_2;
  var_6 = get_path_getfunc(var_2);

  while(isDefined(var_5)) {
    if(isDefined(var_5.script_linkto)) {
      set_lookat_from_dest(var_5);
    }
    heli_wait_node(var_5, var_4);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = var_5;

    if(isDefined(var_5.gateopen) && !var_5.gateopen) {
      thread path_gate_wait_till_open(var_5);
    }
    var_5 notify("trigger", self);

    if(isDefined(var_5.script_helimove)) {
      self setyawspeedbyname(var_5.script_helimove);

      if(var_5.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(isDefined(var_5.script_noteworthy)) {
      self notify(var_5.script_noteworthy);
      self notify("noteworthy", var_5.script_noteworthy);
    }

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_5.script_prefab_exploder)) {
      var_5.script_exploder = var_5.script_prefab_exploder;
      var_5.script_prefab_exploder = undefined;
    }

    if(isDefined(var_5.script_exploder)) {
      var_7 = var_5.script_exploder_delay;

      if(isDefined(var_7)) {
        level maps\_utility::delaythread(var_7, common_scripts\utility::exploder, var_5.script_exploder);
      } else {
        level common_scripts\utility::exploder(var_5.script_exploder);
      }
    }

    if(isDefined(var_5.script_flag_set)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[var_5.script_flag_set] = 1;
      }
      self notify("vehicle_flag_arrived", var_5.script_flag_set);
      common_scripts\utility::flag_set(var_5.script_flag_set);
    }

    if(isDefined(var_5.script_ent_flag_set)) {
      maps\_utility::ent_flag_set(var_5.script_ent_flag_set);
    }
    if(isDefined(var_5.script_ent_flag_clear)) {
      maps\_utility::ent_flag_clear(var_5.script_ent_flag_clear);
    }
    if(isDefined(var_5.script_flag_clear)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[var_5.script_flag_clear] = 0;
      }
      common_scripts\utility::flag_clear(var_5.script_flag_clear);
    }

    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "kill") {
        force_kill();
      }
      if(var_5.script_noteworthy == "godon") {
        godon();
      }
      if(var_5.script_noteworthy == "godoff") {
        godoff();
      }
      if(var_5.script_noteworthy == "deleteme") {
        level thread maps\_utility::deleteent(self);
        return;
      }
    }

    if(isDefined(var_5.script_crashtypeoverride)) {
      self.script_crashtypeoverride = var_5.script_crashtypeoverride;
    }
    if(isDefined(var_5.script_badplace)) {
      self.script_badplace = var_5.script_badplace;
    }
    if(isDefined(var_5.script_turretmg)) {
      self.script_turretmg = var_5.script_turretmg;
    }
    if(isDefined(var_5.script_team)) {
      self.script_team = var_5.script_team;
    }
    if(isDefined(var_5.script_turningdir)) {
      self notify("turning", var_5.script_turningdir);
    }
    if(isDefined(var_5.script_deathroll)) {
      if(var_5.script_deathroll == 0) {
        thread deathrolloff();
      } else {
        thread deathrollon();
      }
    }

    if(isDefined(var_5.script_vehicleaianim)) {
      if(isDefined(var_5.script_parameters) && var_5.script_parameters == "queue") {
        self.queueanim = 1;
      }
    }

    if(isDefined(var_5.script_wheeldirection)) {
      wheeldirectionchange(var_5.script_wheeldirection);
    }
    if(vehicle_should_unload(::heli_wait_node, var_5)) {
      thread unload_node(var_5);
    }
    if(self isphysveh()) {
      if(isDefined(var_5.script_transmission)) {
        self.veh_transmission = var_5.script_transmission;

        if(self.veh_transmission == "forward") {
          vehicle_wheels_forward();
        } else {
          vehicle_wheels_backward();
        }
      }

      if(isDefined(var_5.script_pathtype)) {
        self.veh_pathtype = var_5.script_pathtype;
      }
    }

    if(isDefined(var_5.script_flag_wait)) {
      if(!isDefined(self.vehicle_flags)) {
        self.vehicle_flags = [];
      }
      self.vehicle_flags[var_5.script_flag_wait] = 1;
      self notify("vehicle_flag_arrived", var_5.script_flag_wait);
      common_scripts\utility::flag_wait(var_5.script_flag_wait);

      if(isDefined(var_5.script_delay_post)) {
        wait(var_5.script_delay_post);
      }
      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var_5.script_vehicle_lights_off)) {
      thread lights_off(var_5.script_vehicle_lights_off);
    }
    if(isDefined(var_5.script_vehicle_lights_on)) {
      thread lights_on(var_5.script_vehicle_lights_on);
    }
    if(isDefined(var_5.script_forcecolor)) {
      thread vehicle_script_forcecolor_riders(var_5.script_forcecolor);
    }
    var_4 = var_5;

    if(!isDefined(var_5.target)) {
      break;
    }

    var_5 = [[var_6]](var_5.target);

    if(!isDefined(var_5)) {
      var_5 = var_4;
      break;
    }
  }

  if(isDefined(self.script_turretmg)) {
    if(self.script_turretmg == 1) {
      mgon();
    } else {
      mgoff();
    }
  }

  if(isDefined(var_5.script_land)) {
    thread vehicle_landvehicle();
  }
  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    self delete();
  }
}

vehicle_should_unload(var_0, var_1) {
  if(isDefined(var_1.script_unload)) {
    return 1;
  }
  if(var_0 != ::node_wait) {
    return 0;
  }
  if(!islastnode(var_1)) {
    return 0;
  }
  if(isDefined(self.dontunloadonend)) {
    return 0;
  }
  if(self.vehicletype == "empty") {
    return 0;
  }
  return !is_script_vehicle_selfremove();
}

overshoot_next_node(var_0) {}

is_script_vehicle_selfremove() {
  if(!isDefined(self.script_vehicle_selfremove)) {
    return 0;
  }
  return self.script_vehicle_selfremove;
}

must_stop_at_next_point(var_0) {
  if(isDefined(var_0.script_unload)) {
    return 1;
  }
  if(isDefined(var_0.script_delay)) {
    return 1;
  }
  return isDefined(var_0.script_flag_wait) && !common_scripts\utility::flag(var_0.script_flag_wait);
}

heli_wait_node(var_0, var_1) {
  self endon("newpath");

  if(isDefined(var_0.script_unload) && isDefined(self.fastropeoffset)) {
    var_0.radius = 2;

    if(isDefined(var_0.ground_pos)) {
      var_0.origin = var_0.ground_pos + (0, 0, self.fastropeoffset);
    } else {
      var_2 = maps\_utility::groundpos(var_0.origin) + (0, 0, self.fastropeoffset);

      if(var_2[2] > var_0.origin[2] - 2000) {
        var_0.origin = maps\_utility::groundpos(var_0.origin) + (0, 0, self.fastropeoffset);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_3 = var_1.script_airresistance;
    var_4 = var_1.speed;
    var_5 = var_1.script_accel;
    var_6 = var_1.script_decel;
  } else {
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
  }

  var_7 = isDefined(var_0.script_stopnode) && var_0.script_stopnode;
  var_8 = isDefined(var_0.script_unload);
  var_9 = isDefined(var_0.script_flag_wait) && !common_scripts\utility::flag(var_0.script_flag_wait);
  var_10 = !isDefined(var_0.target);
  var_11 = isDefined(var_0.script_delay);

  if(isDefined(var_0.angles)) {
    var_12 = var_0.angles[1];
  } else {
    var_12 = 0;
  }
  if(self.health <= 0) {
    return;
  }
  var_13 = var_0.origin;

  if(maps\_utility::is_iw4_map_sp()) {
    if(isDefined(self.originheightoffset)) {
      var_13 = var_13 + (0, 0, self.originheightoffset);
    }
  }

  if(isDefined(self.heliheightoverride)) {
    var_13 = (var_13[0], var_13[1], self.heliheightoverride);
  }
  self vehicle_helisetai(var_13, var_4, var_5, var_6, var_0.script_goalyaw, var_0.script_anglevehicle, var_12, var_3, var_11, var_7, var_8, var_9, var_10);

  if(isDefined(var_0.radius)) {
    self setneargoalnotifydist(var_0.radius);
    common_scripts\utility::waittill_any("near_goal", "goal");
  } else {
    self waittill("goal");
  }
  if(isDefined(var_0.script_firelink)) {
    thread heli_firelink(var_0);
  }
  var_0 maps\_utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    maps\_utility::deletestruct_ref(var_0);
  }
}

heli_firelink(var_0) {
  var_1 = getEnt(var_0.script_linkto, "script_linkname");
  var_2 = !isDefined(var_1);

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::getStruct(var_0.script_linkto, "script_linkname");
  }
  var_3 = var_0.script_firelink;

  if(var_2) {
    var_1 = var_1 common_scripts\utility::spawn_tag_origin();
  }
  switch (var_3) {
    case "zippy_burst":
      wait 1;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.1;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.2;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.3;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.3;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      break;
    case "apache_zippy":
      var_4 = [0.1, 0.2, 0.3];
      wait 1;
      var_1.origin = var_1.origin + (0, 0, -150);
      var_1 moveTo(var_1.origin + (0, 0, 150), 0.6, 0, 0);

      foreach(var_6 in var_4) {
        if(!isDefined(self)) {
          continue;
        }
        maps\_helicopter_globals::fire_missile("apache_zippy", 1, var_1);
        wait(var_6);
      }

      break;
    case "hind_rpg":
      maps\_helicopter_globals::fire_missile("hind_rpg", 5, var_1, 0.3);
      break;
    default:
      if(self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500") {
        vehicle_scripts\_attack_heli::heli_fire_missiles(var_1, 2, 0.25);
      } else {
        maps\_helicopter_globals::fire_missile("hind_zippy", 5, var_1, 0.3);
      }
      break;
  }

  if(var_2) {
    var_1 delete();
  }
}

helipath(var_0, var_1, var_2) {
  self setairresistance(30);
  self vehicle_setspeed(var_1, var_2, level.heli_default_decel);
  vehicle_paths(common_scripts\utility::getStruct(var_0, "targetname"));
}

deathrollon() {
  if(self.health > 0) {
    self.rollingdeath = 1;
  }
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

getonpath(var_0) {
  var_1 = undefined;
  var_2 = self.vehicletype;

  if(isDefined(self.vehicle_spawner)) {
    if(isDefined(self.vehicle_spawner.dontgetonpath) && self.dontgetonpath) {
      return;
    }
  }

  if(isDefined(self.target)) {
    var_1 = getvehiclenode(self.target, "targetname");

    if(!isDefined(var_1)) {
      var_3 = getEntArray(self.target, "targetname");

      foreach(var_5 in var_3) {
        if(var_5.code_classname == "script_origin") {
          var_1 = var_5;
          break;
        }
      }
    }

    if(!isDefined(var_1)) {
      var_1 = common_scripts\utility::getStruct(self.target, "targetname");
    }
  }

  if(!isDefined(var_1)) {
    if(ishelicopter()) {
      self vehicle_setspeed(60, 20, level.heli_default_decel);
    }
    return;
  }

  self.attachedpath = var_1;

  if(!ishelicopter()) {
    self.origin = var_1.origin;

    if(!isDefined(var_0)) {
      self attachpath(var_1);
    }
  } else if(isDefined(self.speed)) {
    self vehicle_setspeedimmediate(self.speed, 20);
  } else if(isDefined(var_1.speed)) {
    var_7 = 20;
    var_8 = level.heli_default_decel;

    if(isDefined(var_1.script_accel)) {
      var_7 = var_1.script_accel;
    }
    if(isDefined(var_1.script_decel)) {
      var_7 = var_1.script_decel;
    }
    self vehicle_setspeedimmediate(var_1.speed, var_7, var_8);
  } else {
    self vehicle_setspeed(60, 20, level.heli_default_decel);
  }
  thread vehicle_paths(undefined, ishelicopter());
}

create_vehicle_from_spawngroup_and_gopath(var_0) {
  var_1 = scripted_spawn(var_0);

  foreach(var_3 in var_1) {}
  level thread gopath(var_3);

  return var_1;
}

gopath(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }
  if(isDefined(var_0.script_vehiclestartmove)) {
    level.vehicle_startmovegroup[var_0.script_vehiclestartmove] = common_scripts\utility::array_remove(level.vehicle_startmovegroup[var_0.script_vehiclestartmove], var_0);
  }
  var_0 endon("death");

  if(isDefined(var_0.hasstarted)) {
    return;
  } else {
    var_0.hasstarted = 1;
  }
  var_0 maps\_utility::script_delay();
  var_0 notify("start_vehiclepath");

  if(var_0 ishelicopter()) {
    var_0 notify("start_dynamicpath");
  } else {
    var_0 startpath();
  }
}

path_gate_open(var_0) {
  var_0.gateopen = 1;
  var_0 notify("gate opened");
}

path_gate_wait_till_open(var_0) {
  self endon("death");
  self.waitingforgate = 1;
  self notify("wait for gate");
  vehicle_setspeed_wrapper(0, 15, "path gate closed");
  var_0 waittill("gate opened");
  self.waitingforgate = 0;

  if(self.health > 0) {
    script_resumespeed("gate opened", level.vehicle_resumespeed);
  }
}

scripted_spawn(var_0) {
  var_1 = _getvehiclespawnerarray_by_spawngroup(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {}
  var_2[var_2.size] = vehicle_spawn(var_4);

  return var_2;
}

vehicle_spawn(var_0) {
  var_1 = var_0 dospawn();

  if(!isDefined(var_0.spawned_count)) {
    var_0.spawned_count = 0;
  }
  var_0.spawned_count++;
  var_0.vehicle_spawned_thisframe = var_1;
  var_0.last_spawned_vehicle = var_1;
  var_0 thread remove_vehicle_spawned_thisframe();
  var_1.vehicle_spawner = var_0;

  if(isDefined(var_0.truckjunk)) {
    var_1.truckjunk = var_0.truckjunk;
  }
  thread vehicle_init(var_1);
  var_0 notify("spawned", var_1);
  return var_1;
}

get_vehicle_spawned_from_spawner_with_targetname(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1.last_spawned_vehicle)) {
    return var_1.last_spawned_vehicle;
  }
  return undefined;
}

remove_vehicle_spawned_thisframe() {
  wait 0.05;
  self.vehicle_spawned_thisframe = undefined;
}

waittill_vehiclespawn(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1.vehicle_spawned_thisframe)) {
    return var_1.vehicle_spawned_thisframe;
  }
  var_1 waittill("spawned", var_2);
  return var_2;
}

waittill_vehiclespawn_noteworthy(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isspawner(var_4)) {
      var_2 = var_4;
      break;
    }
  }

  if(isDefined(var_2.vehicle_spawned_thisframe)) {
    return var_2.vehicle_spawned_thisframe;
  }
  var_2 = getEnt(var_0, "script_noteworthy");
  var_2 waittill("spawned", var_6);
  return var_6;
}

waittill_vehiclespawn_noteworthy_array(var_0) {
  var_1 = spawnStruct();
  var_1.array_count = 0;
  var_1.vehicles = [];
  var_2 = [];
  var_3 = getEntArray(var_0, "script_noteworthy");

  foreach(var_5 in var_3) {
    if(isspawner(var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  common_scripts\utility::array_levelthread(var_2, ::waittill_vehiclespawn_noteworthy_array_countdown, var_1);
  var_1 waittill("all_vehicles_spawned");
  return var_1.vehicles;
}

waittill_vehiclespawn_noteworthy_array_countdown(var_0, var_1) {
  var_1.array_count++;

  if(!isDefined(var_0.vehicle_spawned_thisframe)) {
    var_0 waittill("spawned", var_2);
  } else {
    var_2 = var_0.vehicle_spawned_thisframe;
  }
  var_1.array_count--;
  var_1.vehicles[var_1.vehicles.size] = var_2;

  if(!var_1.array_count) {
    var_1 notify("all_vehicles_spawned");
  }
}

vehicle_init(var_0) {
  var_1 = var_0.classname;

  if(isDefined(level.vehicle_hide_list[var_1])) {
    foreach(var_3 in level.vehicle_hide_list[var_1]) {}
    var_0 hidepart(var_3);
  }

  if(var_0.vehicletype == "empty") {
    var_0 thread getonpath();
    return;
  }

  if(var_0.vehicletype == "bog_mortar") {
    return;
  }
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "playervehicle") {
    return;
  }
  var_0 maps\_utility::set_ai_number();
  var_0.zerospeed = 1;

  if(!isDefined(var_0.modeldummyon)) {
    var_0.modeldummyon = 0;
  }
  var_5 = var_0.vehicletype;

  if(maps\_utility::is_iw4_map_sp()) {
    var_1 = var_0.vehicletype;
  }
  var_0 vehicle_life();
  var_0 vehicle_setteam();

  if(maps\_utility::is_iw4_map_sp()) {
    if(!isDefined(level.vehicleinitthread[var_0.vehicletype][var_0.model])) {}

    var_0 thread[[level.vehicleinitthread[var_0.vehicletype][var_0.model]]]();
  } else {
    if(!isDefined(level.vehicleinitthread[var_0.vehicletype][var_0.classname])) {}

    var_0 thread[[level.vehicleinitthread[var_0.vehicletype][var_0.classname]]]();
  }

  var_0 thread maingun_fx();
  var_0 thread playtankexhaust();

  if(!isDefined(var_0.script_avoidplayer)) {
    var_0.script_avoidplayer = 0;
  }
  if(isDefined(level.vehicle_draw_thermal)) {
    if(level.vehicle_draw_thermal) {
      var_0 thermaldrawenable();
    }
  }

  var_0 maps\_utility::ent_flag_init("unloaded");
  var_0 maps\_utility::ent_flag_init("loaded");
  var_0.riders = [];
  var_0.unloadque = [];
  var_0.unload_group = "default";
  var_0.fastroperig = [];

  if(isDefined(level.vehicle_attachedmodels) && isDefined(level.vehicle_attachedmodels[var_1])) {
    var_6 = level.vehicle_attachedmodels[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0.fastroperig[var_9] = undefined;
      var_0.fastroperiganimating[var_9] = 0;
    }
  }

  var_0 thread vehicle_badplace();

  if(isDefined(var_0.script_vehicle_lights_on)) {
    var_0 thread lights_on(var_0.script_vehicle_lights_on);
  }
  if(isDefined(var_0.script_godmode)) {
    var_0 godon();
  }
  var_0.damage_functions = [];

  if(!var_0 ischeap() || var_0 ischeapshieldenabled()) {
    var_0 thread friendlyfire_shield();
  }
  var_0 thread maps\_vehicle_aianim::handle_attached_guys();

  if(isDefined(var_0.script_friendname)) {
    var_0 setvehiclelookattext(var_0.script_friendname, &"");
  }
  if(!var_0 ischeap()) {
    var_0 thread vehicle_handleunloadevent();
  }
  if(isDefined(var_0.script_dontunloadonend)) {
    var_0.dontunloadonend = 1;
  }
  if(!var_0 ischeap()) {
    var_0 thread vehicle_shoot_shock();
  }
  var_0 thread vehicle_rumble();

  if(isDefined(var_0.script_physicsjolt) && var_0.script_physicsjolt) {
    var_0 thread maps\_utility::physicsjolt_proximity();
  }
  var_0 thread vehicle_treads();
  var_0 thread idle_animations();
  var_0 thread animate_drive_idle();

  if(isDefined(var_0.script_deathflag)) {
    var_0 thread maps\_spawner::vehicle_deathflag();
  }
  if(!var_0 ischeap()) {
    var_0 thread mginit();
  }
  if(isDefined(level.vehiclespawncallbackthread)) {
    level thread[[level.vehiclespawncallbackthread]](var_0);
  }
  vehicle_levelstuff(var_0);

  if(isDefined(var_0.script_team)) {
    var_0 setvehicleteam(var_0.script_team);
  }
  if(!var_0 ischeap()) {
    var_0 thread disconnect_paths_whenstopped();
  }
  var_0 thread getonpath();

  if(var_0 hashelicopterdustkickup()) {
    var_0 thread aircraft_dust_kickup();
  }
  if(var_0 isphysveh()) {
    if(!isDefined(var_0.script_pathtype)) {} else {
      var_0.veh_pathtype = var_0.script_pathtype;
    }
  }

  var_0 spawn_group();
  var_0 thread vehicle_kill();
  var_0 apply_truckjunk();
}

ischeapshieldenabled() {
  return isDefined(level.cheap_vehicles_have_shields) && level.cheap_vehicles_have_shields;
}

kill_damage(var_0) {
  if(!isDefined(level.vehicle_death_radiusdamage) || !isDefined(level.vehicle_death_radiusdamage[var_0])) {
    return;
  }
  if(isDefined(self.deathdamage_max)) {
    var_1 = self.deathdamage_max;
  } else {
    var_1 = level.vehicle_death_radiusdamage[var_0].maxdamage;
  }
  if(isDefined(self.deathdamage_min)) {
    var_2 = self.deathdamage_min;
  } else {
    var_2 = level.vehicle_death_radiusdamage[var_0].mindamage;
  }
  if(isDefined(level.vehicle_death_radiusdamage[var_0].delay)) {
    wait(level.vehicle_death_radiusdamage[var_0].delay);
  }
  if(!isDefined(self)) {
    return;
  }
  if(level.vehicle_death_radiusdamage[var_0].bkillplayer) {
    level.player enablehealthshield(0);
  }
  self radiusdamage(self.origin + level.vehicle_death_radiusdamage[var_0].offset, level.vehicle_death_radiusdamage[var_0].range, var_1, var_2, self);

  if(level.vehicle_death_radiusdamage[var_0].bkillplayer) {
    level.player enablehealthshield(1);
  }
}

vehicle_kill() {
  self endon("nodeath_thread");
  var_0 = self.vehicletype;
  var_1 = self.classname;
  var_2 = self.model;
  var_3 = self.targetname;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;

  for(;;) {
    if(isDefined(self)) {
      self waittill("death", var_4, var_5, var_6);
    }
    if(!var_7) {
      var_7 = 1;

      if(isDefined(var_4) && isDefined(var_5)) {
        var_4 maps\_player_stats::register_kill(self, var_5, var_6);

        if(isDefined(self.damage_type)) {
          self.damage_type = undefined;
        }
      }

      if(maps\_utility::is_specialop() && !maps\_utility::is_survival() && isDefined(var_4) && isPlayer(var_4)) {
        if(var_4.team != self.script_team) {
          var_4 thread maps\_utility::givexp("kill", 500);
        }
        if(isDefined(self.riders)) {
          foreach(var_9 in self.riders) {
            if(isalive(var_9) && isai(var_9)) {
              var_4 thread maps\_utility::givexp("kill");
            }
          }
        }
      }

      thread helicopter_death_achievement(var_4, var_5, var_6);
    }

    self notify("clear_c4");

    if(isDefined(self.rumbletrigger)) {
      self.rumbletrigger delete();
    }
    if(isDefined(self.mgturret)) {
      common_scripts\utility::array_levelthread(self.mgturret, ::turret_deleteme);
      self.mgturret = undefined;
    }

    if(isDefined(self.script_team)) {
      level.vehicles[self.script_team] = common_scripts\utility::array_remove(level.vehicles[self.script_team], self);
    }
    if(isDefined(self.script_linkname)) {
      level.vehicle_link[self.script_linkname] = common_scripts\utility::array_remove(level.vehicle_link[self.script_linkname], self);
    }
    if(isDefined(self.script_vehiclestartmove)) {
      level.vehicle_startmovegroup[self.script_vehiclestartmove] = common_scripts\utility::array_remove(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
    }
    if(isDefined(self.script_vehiclegroupdelete)) {
      level.vehicle_deletegroup[self.script_vehiclegroupdelete] = common_scripts\utility::array_remove(level.vehicle_deletegroup[self.script_vehiclegroupdelete], self);
    }
    if(!isDefined(self) || is_corpse()) {
      if(isDefined(self.riders)) {
        foreach(var_9 in self.riders) {
          if(isDefined(var_9)) {
            var_9 delete();
          }
        }
      }

      if(is_corpse()) {
        self.riders = [];
        continue;
      }

      self notify("delete_destructible");
      return;
    }

    var_13 = undefined;

    if(isDefined(self.vehicle_rumble_unique)) {
      var_13 = self.vehicle_rumble_unique;
    } else if(isDefined(level.vehicle_rumble_override) && isDefined(level.vehicle_rumble_override[var_1])) {
      var_13 = level.vehicle_rumble_override;
    } else if(isDefined(level.vehicle_rumble[var_1])) {
      var_13 = level.vehicle_rumble[var_1];
    }
    if(isDefined(var_13)) {
      self stoprumble(var_13.rumble);
    }
    if(isDefined(level.vehicle_death_thread[var_0])) {
      thread[[level.vehicle_death_thread[var_0]]]();
    }
    common_scripts\utility::array_levelthread(self.riders, maps\_vehicle_aianim::guy_vehicle_death, var_4, var_0);
    thread kill_damage(var_1);

    if(maps\_utility::is_iw4_map_sp()) {
      thread kill_badplace(var_0);
    } else {
      thread kill_badplace(var_1);
    }
    kill_lights(get_light_model(var_2, var_1));
    maps\_vehicle_aianim::delete_corpses_around_vehicle();

    if(isDefined(level.vehicle_deathmodel[var_1])) {
      thread set_death_model(level.vehicle_deathmodel[var_1], level.vehicle_deathmodel_delay[var_1]);
    } else if(isDefined(level.vehicle_deathmodel[var_2])) {
      thread set_death_model(level.vehicle_deathmodel[var_2], level.vehicle_deathmodel_delay[var_2]);
    }
    var_14 = vehicle_should_do_rocket_death(var_2, var_4, var_5);
    var_15 = self.origin;
    thread kill_fx(var_2, var_14);

    if(self.code_classname == "script_vehicle") {
      if(maps\_utility::is_iw4_map_sp()) {
        thread kill_jolt(var_0);
      } else {
        thread kill_jolt(var_1);
      }
    }

    if(isDefined(self.delete_on_death)) {
      wait 0.05;

      if(!isDefined(self.dontdisconnectpaths) && !self isphysveh()) {
        self disconnectPaths();
      }
      _freevehicle();
      wait 0.05;
      vehicle_finish_death(var_2);
      self delete();
      continue;
    }

    if(isDefined(self.free_on_death)) {
      self notify("newpath");

      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
      }
      vehicle_kill_badplace_forever();
      _freevehicle();
      return;
    }

    vehicle_do_crash(var_2, var_4, var_5);

    if(!isDefined(self)) {
      return;
    }
    if(!var_14) {
      var_15 = self.origin;
    }
    if(isDefined(level.vehicle_death_earthquake[var_1])) {
      earthquake(level.vehicle_death_earthquake[var_1].scale, level.vehicle_death_earthquake[var_1].duration, var_15, level.vehicle_death_earthquake[var_1].radius);
    }
    wait 0.5;

    if(is_corpse()) {
      continue;
    }
    if(isDefined(self)) {
      while(isDefined(self.dontfreeme) && isDefined(self)) {
        wait 0.05;
      }
      if(!isDefined(self)) {
        continue;
      }
      if(self isphysveh()) {
        while(isDefined(self) && self.veh_speed != 0) {
          wait 1;
        }
        if(!isDefined(self)) {
          return;
        }
        self disconnectPaths();
        self notify("kill_badplace_forever");
        self kill();
        self notify("newpath");
        self vehicle_turnengineoff();
        return;
      } else {
        _freevehicle();
      }
      if(self.modeldummyon) {
        self hide();
      }
    }

    if(vehicle_is_crashing()) {
      self delete();
      continue;
    }
  }
}

helicopter_death_achievement(var_0, var_1, var_2) {
  if(maps\_utility::is_survival() && isDefined(self) && ishelicopter() && isPlayer(var_0)) {
    if(!isDefined(var_0.achieve_birdie)) {
      var_0.achieve_birdie = 1;
    } else {
      var_0.achieve_birdie++;
    }
    if(var_0.achieve_birdie == 2) {
      var_0 maps\_utility::player_giveachievement_wrapper("BIRDIE");
    }
    var_0 waittill("damage");
    var_0.achieve_birdie = undefined;
  }
}

_freevehicle() {
  self freevehicle();

  if(!isDefined(level.extra_vehicle_cleanup)) {
    return;
  }
  maps\_utility::delaythread(0.05, ::extra_vehicle_cleanup);
}

extra_vehicle_cleanup() {
  self notify("newpath");
  self.accuracy = undefined;
  self.attachedguys = undefined;
  self.attackback = undefined;
  self.badshot = undefined;
  self.badshotcount = undefined;
  self.currenthealth = undefined;
  self.currentnode = undefined;
  self.damage_functions = undefined;
  self.delayer = undefined;
  self.fastroperig = undefined;
  self.getinorgs = undefined;
  self.hasstarted = undefined;
  self.healthbuffer = undefined;
  self.offsetone = undefined;
  self.offsetrange = undefined;
  self.rocket_destroyed_for_achievement = undefined;
  self.rumble_basetime = undefined;
  self.rumble_duration = undefined;
  self.rumble_radius = undefined;
  self.script_attackai = undefined;
  self.script_avoidplayer = undefined;
  self.script_attackai = undefined;
  self.script_avoidplayer = undefined;
  self.script_bulletshield = undefined;
  self.script_disconnectpaths = undefined;
  self.script_linkname = undefined;
  self.script_mp_style_helicopter = undefined;
  self.script_team = undefined;
  self.script_turret = undefined;
  self.script_turretmg = undefined;
  self.script_vehicleride = undefined;
  self.script_vehiclespawngroup = undefined;
  self.script_vehiclestartmove = undefined;
  self.shotcount = undefined;
  self.shotsatzerospeed = undefined;
  self.spawn_funcs = undefined;
  self.spawn_functions = undefined;
  self.tank_queue = undefined;
  self.target = undefined;
  self.target_min_range = undefined;
  self.troop_cache = undefined;
  self.troop_cache = undefined;
  self.troop_cache_update_next = undefined;
  self.turret_damage_max = undefined;
  self.turret_damage_min = undefined;
  self.turret_damage_range = undefined;
  self.badplacemodifier = undefined;
  self.attachedpath = undefined;
  self.badplacemodifier = undefined;
  self.rumble_randomaditionaltime = undefined;
  self.rumble_scale = undefined;
  self.rumbleon = undefined;
  self.rumbletrigger = undefined;
  self.runningtovehicle = undefined;
  self.script_nomg = undefined;
  self.script_startinghealth = undefined;
  self.teleported_to_path_section = undefined;
  self.turret_damage_range = undefined;
  self.turretaccmaxs = undefined;
  self.turretaccmins = undefined;
  self.turretfiretimer = undefined;
  self.turretonvistarg = undefined;
  self.turretonvistarg_failed = undefined;
  self.unique_id = undefined;
  self.unload_group = undefined;
  self.unloadque = undefined;
  self.usedpositions = undefined;
  self.vehicle_spawner = undefined;
  self.waitingforgate = undefined;
  self.water_splash_function = undefined;
  self.water_splash_reset_function = undefined;
  self.offsetzero = undefined;
  self.script_accuracy = undefined;
  self.water_splash_reset_function = undefined;
  self.wheeldir = undefined;
  self.zerospeed = undefined;
  self.dontunloadonend = undefined;
  self.dontdisconnectpaths = undefined;
  self.script_godmode = undefined;
  self.ent_flag = undefined;
  self.ent_flag_lock = undefined;
  self.export = undefined;
  self.godmode = undefined;
  self.vehicletype = undefined;
  self.vehicle_stop_named = undefined;
  self.enable_rocket_death = undefined;
  self.touching_trigger_ent = undefined;
  self.default_target_vec = undefined;
  self.script_badplace = undefined;
  self.water_splash_info = undefined;
}

#using_animtree("vehicles");

vehicle_finish_death(var_0) {
  self notify("death_finished");

  if(!isDefined(self)) {
    return;
  }
  self useanimtree(#animtree);

  if(isDefined(level.vehicle_driveidle[var_0])) {
    self clearanim(level.vehicle_driveidle[var_0], 0);
  }
  if(isDefined(level.vehicle_driveidle_r[var_0])) {
    self clearanim(level.vehicle_driveidle_r[var_0], 0);
  }
}

vehicle_should_do_rocket_death(var_0, var_1, var_2) {
  if(isDefined(self.enablerocketdeath) && self.enablerocketdeath == 0) {
    return 0;
  }
  if(!isDefined(var_2)) {
    return 0;
  }
  if(!(var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH")) {
    return 0;
  }
  return vehicle_has_rocket_death(var_0);
}

vehicle_has_rocket_death(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    return isDefined(level.vehicle_death_fx["rocket_death" + self.vehicletype + var_0]) && isDefined(self.enablerocketdeath) && self.enablerocketdeath == 1;
  } else {
    return isDefined(level.vehicle_death_fx["rocket_death" + self.classname]) && isDefined(self.enablerocketdeath) && self.enablerocketdeath == 1;
  }
}

vehicle_is_crashing() {
  return isDefined(self.crashing) && self.crashing == 1;
}

vehicle_do_crash(var_0, var_1, var_2) {
  var_3 = "tank";

  if(self isphysveh()) {
    var_3 = "physics";
  } else if(isDefined(self.script_crashtypeoverride)) {
    var_3 = self.script_crashtypeoverride;
  } else if(ishelicopter()) {
    var_3 = "helicopter";
  } else if(isDefined(self.currentnode) && crash_path_check(self.currentnode)) {
    var_3 = "none";
  }
  switch (var_3) {
    case "helicopter":
      thread helicopter_crash(var_1, var_2);
      break;
    case "tank":
      if(!isDefined(self.rollingdeath)) {
        vehicle_setspeed_wrapper(0, 25, "Dead");
      } else {
        vehicle_setspeed_wrapper(8, 25, "Dead rolling out of path intersection");
        self waittill("deathrolloff");
        vehicle_setspeed_wrapper(0, 25, "Dead, finished path intersection");
      }

      self notify("deadstop");

      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
      }
      if(isDefined(self.tankgetout) && self.tankgetout > 0) {
        self waittill("animsdone");
      }
      break;
    case "physics":
      self phys_crash();
      self notify("deadstop");

      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
      }
      if(isDefined(self.tankgetout) && self.tankgetout > 0) {
        self waittill("animsdone");
      }
      break;
  }

  if(isDefined(level.vehicle_hasmainturret[var_0]) && level.vehicle_hasmainturret[var_0]) {
    self clearturrettarget();
  }
  if(ishelicopter()) {
    if(isDefined(self.crashing) && self.crashing == 1) {
      self waittill("crash_done");
    }
  } else {
    while(!is_corpse() && isDefined(self) && self vehicle_getspeed() > 0) {
      wait 0.1;
    }
  }

  self notify("stop_looping_death_fx");
  vehicle_finish_death(var_0);
}

is_corpse() {
  var_0 = 0;

  if(isDefined(self) && self.classname == "script_vehicle_corpse") {
    var_0 = 1;
  }
  return var_0;
}

set_death_model(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }
  if(!isDefined(self)) {
    return;
  }
  var_2 = get_dummy();

  if(isDefined(self.clear_anims_on_death)) {
    var_2 clearanim(%root, 0);
  }
  if(isDefined(self)) {
    var_2 setModel(var_0);
  }
}

helicopter_crash(var_0, var_1) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    self.achievement_attacker = var_0;
  }
  self.crashing = 1;

  if(!isDefined(self)) {
    return;
  }
  thread helicopter_crash_move(var_0, var_1);
}

_hasweapon(var_0) {
  var_1 = self getweaponslistall();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(issubstr(var_1[var_2], var_0)) {
      return 1;
    }
  }

  return 0;
}

get_unused_crash_locations() {
  var_0 = [];
  level.helicopter_crash_locations = common_scripts\utility::array_removeundefined(level.helicopter_crash_locations);

  foreach(var_2 in level.helicopter_crash_locations) {
    if(isDefined(var_2.claimed)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

detach_getoutrigs() {
  if(!isDefined(self.fastroperig)) {
    return;
  }
  if(!self.fastroperig.size) {
    return;
  }
  var_0 = getarraykeys(self.fastroperig);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    self.fastroperig[var_0[var_1]] unlink();
  }
}

helicopter_crash_move(var_0, var_1) {
  self endon("in_air_explosion");

  if(isDefined(self.perferred_crash_location)) {
    var_2 = self.perferred_crash_location;
  } else {
    var_3 = get_unused_crash_locations();
    var_2 = maps\_utility::getclosest(self.origin, var_3);
  }

  var_2.claimed = 1;
  detach_getoutrigs();
  self notify("newpath");
  self notify("deathspin");
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_2.script_parameters) && var_2.script_parameters == "direct") {
    var_5 = 1;
  }
  if(isDefined(self.heli_crash_indirect_zoff)) {
    var_5 = 0;
    var_4 = self.heli_crash_indirect_zoff;
  }

  if(var_5) {
    var_6 = 60;
    self vehicle_setspeed(var_6, 15, 10);
    self setneargoalnotifydist(var_2.radius);
    self setvehgoalpos(var_2.origin, 0);
    thread helicopter_crash_flavor(var_2.origin, var_6);
    common_scripts\utility::waittill_any("goal", "near_goal");
  } else {
    var_7 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_4);

    if(isDefined(self.heli_crash_lead)) {
      var_7 = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
      var_7 = (var_7[0], var_7[1], var_7[2] + var_4);
    }

    self vehicle_setspeed(40, 10, 10);
    self setneargoalnotifydist(300);
    self setvehgoalpos(var_7, 1);
    thread helicopter_crash_flavor(var_7, 40);
    var_8 = "blank";

    while(var_8 != "death") {
      var_8 = common_scripts\utility::waittill_any("goal", "near_goal", "death");

      if(!isDefined(var_8) && !isDefined(self)) {
        var_2.claimed = undefined;
        self notify("crash_done");
        return;
      } else {
        var_8 = "death";
      }
    }

    self setvehgoalpos(var_2.origin, 0);
    self waittill("goal");
  }

  var_2.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("crash_done");
}

helicopter_crash_flavor(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
  var_2 = 0;

  if(isDefined(self.preferred_crash_style)) {
    var_2 = self.preferred_crash_style;

    if(self.preferred_crash_style < 0) {
      var_3 = [1, 2, 2];
      var_4 = 5;
      var_5 = randomint(var_4);
      var_6 = 0;

      foreach(var_9, var_8 in var_3) {
        var_6 = var_6 + var_8;

        if(var_5 < var_6) {
          var_2 = var_9;
          break;
        }
      }
    }
  }

  switch (var_2) {
    case 1:
      thread helicopter_crash_zigzag();
      break;
    case 2:
      thread helicopter_crash_directed(var_0, var_1);
      break;
    case 3:
      thread helicopter_in_air_explosion();
      break;
    case 0:
    default:
      thread helicopter_crash_rotate();
      break;
  }
}

helicopter_in_air_explosion() {
  self notify("crash_done");
  self notify("in_air_explosion");
}

helicopter_crash_directed(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_2 = 90 * randomintrange(-2, 3);

  for(;;) {
    var_3 = var_0 - self.origin;
    var_4 = vectortoyaw(var_3);
    var_4 = var_4 + var_2;
    self settargetyaw(var_4);
    wait 0.1;
  }
}

helicopter_crash_zigzag() {
  self endon("crash_done");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  var_0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_1 = randomintrange(20, 120);

    if(var_0) {
      self settargetyaw(self.angles[1] + var_1);
    } else {
      self settargetyaw(self.angles[1] - var_1);
    }
    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1.0);
    wait(var_2);
  }
}

helicopter_crash_rotate() {
  self endon("crash_done");
  self clearlookatent();
  self setyawspeed(400, 100, 100);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_0 = randomintrange(90, 120);
    self settargetyaw(self.angles[1] + var_0);
    wait 0.5;
  }
}

crash_path_check(var_0) {
  var_1 = var_0;

  while(isDefined(var_1)) {
    if(isDefined(var_1.detoured) && var_1.detoured == 0) {
      var_2 = path_detour_get_detourpath(getvehiclenode(var_1.target, "targetname"));

      if(isDefined(var_2) && isDefined(var_2.script_crashtype)) {
        return 1;
      }
    }

    if(isDefined(var_1.target)) {
      var_1 = getvehiclenode(var_1.target, "targetname");
      continue;
    }

    var_1 = undefined;
  }

  return 0;
}

death_firesound(var_0) {
  thread maps\_utility::play_loop_sound_on_tag(var_0, undefined, 0);
  common_scripts\utility::waittill_any("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + var_0);
}

kill_fx(var_0, var_1) {
  if(common_scripts\utility::isdestructible()) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);

  if(isDefined(self.ignore_death_fx) && self.ignore_death_fx) {
    return;
  }
  var_2 = self.vehicletype;
  var_3 = is_corpse();
  var_4 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_4 = var_2 + var_0;
  }
  if(var_1) {
    var_4 = "rocket_death" + var_4;
  }
  for(var_5 = 0; var_5 < level.vehicle_death_fx[var_4].size; var_5++) {
    var_6 = level.vehicle_death_fx[var_4][var_5];
    thread kill_fx_thread(var_0, var_6, var_2);
  }
}

vehicle_flag_arrived(var_0) {
  if(!isDefined(self.vehicle_flags)) {
    self.vehicle_flags = [];
  }
  while(!isDefined(self.vehicle_flags[var_0])) {
    self waittill("vehicle_flag_arrived", var_1);

    if(var_0 == var_1) {
      return;
    }
  }
}

kill_fx_thread(var_0, var_1, var_2) {
  if(isDefined(var_1.waitdelay)) {
    if(var_1.waitdelay >= 0) {
      wait(var_1.waitdelay);
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1.notifystring)) {
    self notify(var_1.notifystring);
  }
  var_3 = get_dummy();

  if(isDefined(var_1.selfdeletedelay)) {
    common_scripts\utility::delaycall(var_1.selfdeletedelay, ::delete);
  }
  if(isDefined(var_1.effect)) {
    if(var_1.beffectlooping && !isDefined(self.delete_on_death)) {
      if(isDefined(var_1.tag)) {
        if(isDefined(var_1.stayontag) && var_1.stayontag == 1) {
          thread loop_fx_on_vehicle_tag(var_1.effect, var_1.delay, var_1.tag);
        } else {
          thread playloopedfxontag(var_1.effect, var_1.delay, var_1.tag);
        }
      } else {
        var_4 = var_3.origin + (0, 0, 100) - var_3.origin;
        playFX(var_1.effect, var_3.origin, var_4);
      }
    } else if(isDefined(var_1.tag)) {
      playFXOnTag(var_1.effect, deathfx_ent(), var_1.tag);

      if(isDefined(var_1.remove_deathfx_entity_delay)) {
        deathfx_ent() common_scripts\utility::delaycall(var_1.remove_deathfx_entity_delay, ::delete);
      }
    } else {
      var_4 = var_3.origin + (0, 0, 100) - var_3.origin;
      playFX(var_1.effect, var_3.origin, var_4);
    }
  }

  if(isDefined(var_1.sound) && !isDefined(self.delete_on_death)) {
    if(var_1.bsoundlooping) {
      thread death_firesound(var_1.sound);
    } else {
      common_scripts\utility::play_sound_in_space(var_1.sound);
    }
  }
}

loop_fx_on_vehicle_tag(var_0, var_1, var_2) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var_0, deathfx_ent(), var_2);
    wait(var_1);
  }
}

build_radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle_death_radiusdamage)) {
    level.vehicle_death_radiusdamage = [];
  }
  if(!isDefined(var_4)) {
    var_4 = 0;
  }
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }
  var_6 = spawnStruct();
  var_6.offset = var_0;
  var_6.range = var_1;
  var_6.maxdamage = var_2;
  var_6.mindamage = var_3;
  var_6.bkillplayer = var_4;
  var_6.delay = var_5;
  level.vehicle_death_radiusdamage[level.vtclassname] = var_6;
}

build_rumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle_rumble)) {
    level.vehicle_rumble = [];
  }
  var_6 = build_quake(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6.rumble = var_0;
  level.vehicle_rumble[level.vtclassname] = var_6;
}

build_rumble_override(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.vehicle_rumble_override)) {
    level.vehicle_rumble_override = [];
  }
  var_7 = build_quake(var_2, var_3, var_4, var_5, var_6);
  precacherumble(var_1);
  var_7.rumble = var_1;
  level.vehicle_rumble_override[var_0] = var_7;
}

build_rumble_unique(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = build_quake(var_1, var_2, var_3, var_4, var_5);
  var_6.rumble = var_0;
  self.vehicle_rumble_unique = var_6;
  vehicle_kill_rumble_forever();
  thread vehicle_rumble();
}

build_deathquake(var_0, var_1, var_2) {
  var_3 = level.vtclassname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_3 = level.vttype;
  }
  if(!isDefined(level.vehicle_death_earthquake)) {
    level.vehicle_death_earthquake = [];
  }
  level.vehicle_death_earthquake[var_3] = build_quake(var_0, var_1, var_2);
}

build_quake(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.scale = var_0;
  var_5.duration = var_1;
  var_5.radius = var_2;

  if(isDefined(var_3)) {
    var_5.basetime = var_3;
  }
  if(isDefined(var_4)) {
    var_5.randomaditionaltime = var_4;
  }
  return var_5;
}

build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_5)) {
    var_5 = 0;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  if(!isDefined(var_4)) {
    var_4 = 1;
  }
  var_11 = spawnStruct();
  var_11.effect = common_scripts\utility::_loadfx(var_0);
  var_11.tag = var_1;
  var_11.sound = var_2;
  var_11.bsoundlooping = var_5;
  var_11.delay = var_4;
  var_11.waitdelay = var_6;
  var_11.stayontag = var_7;
  var_11.notifystring = var_8;
  var_11.beffectlooping = var_3;
  var_11.selfdeletedelay = var_9;
  var_11.remove_deathfx_entity_delay = var_10;
  return var_11;
}

build_deathfx_override(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
  level.vttype = var_1;
  level.vtmodel = var_2;
  level.vtoverride = 1;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = var_1 + var_2;
  } else {}

  level.vtclassname = var_0;

  if(!isDefined(level.vehicle_death_fx)) {
    level.vehicle_death_fx = [];
  }
  if(!is_overrode(var_0)) {
    level.vehicle_death_fx[var_0] = [];
  }
  level.vehicle_death_fx_override[var_0] = 1;

  if(!isDefined(level.vehicle_death_fx[var_0])) {
    level.vehicle_death_fx[var_0] = [];
  }
  level.vehicle_death_fx[var_0][level.vehicle_death_fx[var_0].size] = build_fx(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  level.vtoverride = undefined;
}

build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level.vtclassname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_11 = level.vttype + level.vtmodel;
  }
  if(is_overrode(var_11)) {
    return;
  }
  if(!isDefined(level.vehicle_death_fx[var_11])) {
    level.vehicle_death_fx[var_11] = [];
  }
  level.vehicle_death_fx[var_11][level.vehicle_death_fx[var_11].size] = build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

is_overrode(var_0) {
  if(!isDefined(level.vehicle_death_fx_override)) {
    return 0;
  }
  if(!isDefined(level.vehicle_death_fx_override[var_0])) {
    return 0;
  }
  if(isDefined(level.vtoverride)) {
    return 1;
  }
  return level.vehicle_death_fx_override[var_0];
}

build_rocket_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(maps\_utility::is_iw4_map_sp()) {
    var_11 = level.vttype;
    level.vttype = "rocket_death" + var_11;
    build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    level.vttype = var_11;
  } else {
    var_12 = level.vtclassname;
    level.vtclassname = "rocket_death" + var_12;
    build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    level.vtclassname = var_12;
  }
}

precache_scripts() {
  var_0 = [];
  var_1 = getEntArray("script_vehicle", "code_classname");
  level.needsprecaching = [];
  var_2 = [];
  var_0 = [];

  if(!isDefined(level.vehicleinitthread)) {
    level.vehicleinitthread = [];
  }
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3].vehicletype = tolower(var_1[var_3].vehicletype);

    if(var_1[var_3].vehicletype == "bog_mortar" || var_1[var_3].vehicletype == "empty") {
      continue;
    }
    if(isDefined(var_1[var_3].spawnflags) && var_1[var_3].spawnflags & 1) {
      var_2[var_2.size] = var_1[var_3];
    }
    var_0[var_0.size] = var_1[var_3];

    if(!isDefined(level.vehicleinitthread[var_1[var_3].vehicletype])) {
      level.vehicleinitthread[var_1[var_3].vehicletype] = [];
    }
    if(maps\_utility::is_iw4_map_sp()) {
      var_4 = "maps\\_" + var_1[var_3].vehicletype + "::main( \"" + var_1[var_3].model + "\" );";
    } else {
      var_4 = "classname: " + var_1[var_3].classname;
    }
    precachesetup(var_4, var_1[var_3]);
  }

  if(level.needsprecaching.size > 0) {
    for(var_3 = 0; var_3 < level.needsprecaching.size; var_3++) {}

    level waittill("never");
  }

  return var_0;
}

precachesetup(var_0, var_1) {
  if(maps\_utility::is_iw4_map_sp()) {
    if(isDefined(level.vehicleinitthread[var_1.vehicletype][var_1.model])) {
      return;
    }
  } else {
    if(isDefined(level.vehicleinitthread[var_1.vehicletype][var_1.classname])) {
      return;
    }
    if(var_1.classname == "script_vehicle") {
      return;
    }
  }

  var_2 = 0;

  for(var_3 = 0; var_3 < level.needsprecaching.size; var_3++) {
    if(level.needsprecaching[var_3] == var_0) {
      var_2 = 1;
    }
  }

  if(!var_2) {
    level.needsprecaching[level.needsprecaching.size] = var_0;
  }
}

vehicle_kill_disconnect_paths_forever() {
  self notify("kill_disconnect_paths_forever");
}

disconnect_paths_whenstopped() {
  self endon("death");
  var_0 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    var_0 = 1;
  }
  if(var_0) {
    self.dontdisconnectpaths = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
      } else {}

      self notify("speed_zero_path_disconnect");

      while(self vehicle_getspeed() < 1) {
        wait 0.05;
      }
    }

    self connectpaths();
    wait 1;
  }
}

vehicle_setspeed_wrapper(var_0, var_1, var_2) {
  if(self vehicle_getspeed() == 0 && var_0 == 0) {
    return;
  }
  self vehicle_setspeed(var_0, var_1);
}

debug_vehiclesetspeed(var_0, var_1, var_2) {}

script_resumespeed(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = "resumespeed";

  if(!isDefined(self.resumemsgs)) {
    self.resumemsgs = [];
  }
  if(isDefined(self.waitingforgate) && self.waitingforgate) {
    return;
  }
  if(isDefined(self.attacking)) {
    if(self.attacking) {
      var_2 = self.attackspeed;
      var_3 = "setspeed";
    }
  }

  self.zerospeed = 0;

  if(var_2 == 0) {
    self.zerospeed = 1;
  }
  if(var_3 == "resumespeed") {
    self resumespeed(var_1);
  } else if(var_3 == "setspeed") {
    vehicle_setspeed_wrapper(var_2, 15, "resume setspeed from attack");
  }
  self notify("resuming speed");
}

print_resumespeed(var_0) {
  self notify("newresumespeedmsag");
  self endon("newresumespeedmsag");
  self endon("death");

  while(gettime() < var_0 && isDefined(self.resumemsgs)) {
    if(self.resumemsgs.size > 6) {
      var_1 = self.resumemsgs.size - 5;
    } else {
      var_1 = 0;
    }
    for(var_2 = var_1; var_2 < self.resumemsgs.size; var_2++) {
      var_3 = var_2 * 32;
    }
    wait 0.05;
  }
}

force_kill() {
  if(common_scripts\utility::isdestructible()) {
    common_scripts\_destructible::force_explosion();
  } else {
    self kill();
  }
}

godon() {
  self.godmode = 1;
}

godoff() {
  self.godmode = 0;
}

setturretfireondrones(var_0) {
  if(isDefined(self.mgturret) && self.mgturret.size) {
    for(var_1 = 0; var_1 < self.mgturret.size; var_1++) {
      self.mgturret[var_1].script_fireondrones = var_0;
    }
  }
}

getnormalanimtime(var_0) {
  var_1 = self getanimtime(var_0);
  var_2 = getanimlength(var_0);

  if(var_1 == 0) {
    return 0;
  }
  return self getanimtime(var_0) / getanimlength(var_0);
}

rotor_anim() {
  var_0 = getanimlength(maps\_utility::getanim("rotors"));

  for(;;) {
    self setanim(maps\_utility::getanim("rotors"), 1, 0, 1);
    wait(var_0);
  }
}

suspend_drive_anims() {
  self notify("suspend_drive_anims");
  var_0 = self.model;
  self clearanim(level.vehicle_driveidle[var_0], 0);
  self clearanim(level.vehicle_driveidle_r[var_0], 0);
}

idle_animations() {
  self useanimtree(#animtree);

  if(!isDefined(level.vehicle_idleanim[self.model])) {
    return;
  }
  foreach(var_1 in level.vehicle_idleanim[self.model]) {}
  self setanim(var_1);
}

animate_drive_idle() {
  self endon("suspend_drive_anims");

  if(!isDefined(self.wheeldir)) {
    self.wheeldir = 1;
  }
  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;
  self useanimtree(#animtree);

  if(!isDefined(level.vehicle_driveidle[var_0])) {
    return;
  }
  if(!isDefined(level.vehicle_driveidle_r[var_0])) {
    level.vehicle_driveidle_r[var_0] = level.vehicle_driveidle[var_0];
  }
  self endon("death");
  var_3 = level.vehicle_driveidle_normal_speed[var_0];
  var_4 = 1.0;

  if(isDefined(level.vehicle_driveidle_animrate) && isDefined(level.vehicle_driveidle_animrate[var_0])) {
    var_4 = level.vehicle_driveidle_animrate[var_0];
  }
  var_5 = self.wheeldir;
  var_6 = self;
  var_7 = level.vehicle_driveidle[var_0];

  for(;;) {
    if(isDefined(level.animate_drive_idle_on_dummies)) {
      var_6 = get_dummy();
    }
    if(!var_3) {
      if(isDefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      var_6 setanim(level.vehicle_driveidle[var_0], 1, 0.2, var_4);
      return;
    }

    var_8 = self vehicle_getspeed();

    if(is_dummy() && isDefined(self.dummyspeed)) {
      var_8 = self.dummyspeed;
    }
    if(var_5 != self.wheeldir) {
      var_9 = 0;

      if(self.wheeldir) {
        var_7 = level.vehicle_driveidle[var_0];
        var_9 = 1 - var_6 getnormalanimtime(level.vehicle_driveidle_r[var_0]);
        var_6 clearanim(level.vehicle_driveidle_r[var_0], 0);
      } else {
        var_7 = level.vehicle_driveidle_r[var_0];
        var_9 = 1 - var_6 getnormalanimtime(level.vehicle_driveidle[var_0]);
        var_6 clearanim(level.vehicle_driveidle[var_0], 0);
      }

      var_2 = 0.01;

      if(var_2 >= 1 || var_2 == 0) {
        var_2 = 0.01;
      }
      var_5 = self.wheeldir;
    }

    var_10 = var_8 / var_3;

    if(var_10 != var_1) {
      var_6 setanim(var_7, 1, 0.05, var_10);
      var_1 = var_10;
    }

    if(isDefined(var_2)) {
      var_6 setanimtime(var_7, var_2);
      var_2 = undefined;
    }

    wait 0.05;
  }
}

setup_dynamic_detour(var_0, var_1) {
  var_2 = [[var_1]](var_0.targetname);
  var_2.detoured = 0;
}

setup_ai() {
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].script_vehicleride)) {
      level.vehicle_rideai = array_2dadd(level.vehicle_rideai, var_0[var_1].script_vehicleride, var_0[var_1]);
      continue;
    }

    if(isDefined(var_0[var_1].script_vehiclewalk)) {
      level.vehicle_walkai = array_2dadd(level.vehicle_walkai, var_0[var_1].script_vehiclewalk, var_0[var_1]);
    }
  }

  var_0 = getspawnerarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].script_vehicleride)) {
      level.vehicle_ridespawners = array_2dadd(level.vehicle_ridespawners, var_0[var_1].script_vehicleride, var_0[var_1]);
    }
    if(isDefined(var_0[var_1].script_vehiclewalk)) {
      level.vehicle_walkspawners = array_2dadd(level.vehicle_walkspawners, var_0[var_1].script_vehiclewalk, var_0[var_1]);
    }
  }
}

array_2dadd(var_0, var_1, var_2) {
  if(!isDefined(var_0[var_1])) {
    var_0[var_1] = [];
  }
  var_0[var_1][var_0[var_1].size] = var_2;
  return var_0;
}

is_node_script_origin(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "script_origin";
}

node_trigger_process() {
  var_0 = 0;

  if(isDefined(self.spawnflags) && self.spawnflags & 1) {
    if(isDefined(self.script_crashtype)) {
      level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;
    }
    level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
  }

  if(isDefined(self.script_vehicledetour) && isDefined(self.targetname)) {
    var_1 = undefined;

    if(isDefined(get_from_entity(self.targetname))) {
      var_1 = ::get_from_entity_target;
    }
    if(isDefined(get_from_spawnstruct(self.targetname))) {
      var_1 = ::get_from_spawnstruct_target;
    }
    if(isDefined(var_1)) {
      setup_dynamic_detour(self, var_1);
      var_0 = 1;
    } else {
      setup_groundnode_detour(self);
    }
    level.vehicle_detourpaths = array_2dadd(level.vehicle_detourpaths, self.script_vehicledetour, self);

    if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2) {}
  }

  if(isDefined(self.script_gatetrigger)) {
    level.vehicle_gatetrigger = array_2dadd(level.vehicle_gatetrigger, self.script_gatetrigger, self);
    self.gateopen = 0;
  }

  if(isDefined(self.script_flag_set)) {
    if(!isDefined(level.flag[self.script_flag_set])) {
      common_scripts\utility::flag_init(self.script_flag_set);
    }
  }

  if(isDefined(self.script_flag_clear)) {
    if(!isDefined(level.flag[self.script_flag_clear])) {
      common_scripts\utility::flag_init(self.script_flag_clear);
    }
  }

  if(isDefined(self.script_flag_wait)) {
    if(!isDefined(level.flag[self.script_flag_wait])) {
      common_scripts\utility::flag_init(self.script_flag_wait);
    }
  }

  if(isDefined(self.script_vehiclespawngroup) || isDefined(self.script_vehiclestartmove) || isDefined(self.script_gatetrigger) || isDefined(self.script_vehiclegroupdelete)) {
    var_0 = 1;
  }
  if(var_0) {
    add_proccess_trigger(self);
  }
}

setup_triggers() {
  level.vehicle_processtriggers = [];
  var_0 = [];
  var_0 = common_scripts\utility::array_combine(getallvehiclenodes(), getEntArray("script_origin", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, level.struct);
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_radius", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_disk", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_multiple", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_lookat", "code_classname"));
  common_scripts\utility::array_thread(var_0, ::node_trigger_process);
}

is_node_script_struct(var_0) {
  if(!isDefined(var_0.targetname)) {
    return 0;
  }
  return isDefined(common_scripts\utility::getStruct(var_0.targetname, "targetname"));
}

setup_vehicles(var_0) {
  var_1 = [];
  level.failed_spawnvehicles = [];

  foreach(var_3 in var_0) {
    var_3 setup_gags();

    if(var_3 check_spawn_group_isspawner()) {
      continue;
    } else {
      var_1[var_1.size] = var_3;
    }
  }

  check_failed_spawn_groups();

  foreach(var_6 in var_1) {}
  thread vehicle_init(var_6);
}

check_failed_spawn_groups() {
  if(!level.failed_spawnvehicles.size) {
    level.failed_spawnvehicles = undefined;
    return;
  }

  foreach(var_1 in level.failed_spawnvehicles) {}
}

check_spawn_group_isspawner() {
  if(isDefined(self.script_vehiclespawngroup) && !isspawner(self)) {
    level.failed_spawnvehicles[level.failed_spawnvehicles.size] = self;
    return 1;
  }

  return isspawner(self);
}

vehicle_life() {
  var_0 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = self.vehicletype;
  }
  if(!isDefined(level.vehicle_life) || !isDefined(level.vehicle_life[var_0])) {
    wait 2;
  }
  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
  } else if(level.vehicle_life[var_0] == -1) {
    return;
  } else if(isDefined(level.vehicle_life_range_low[var_0]) && isDefined(level.vehicle_life_range_high[var_0])) {
    self.health = randomint(level.vehicle_life_range_high[var_0] - level.vehicle_life_range_low[var_0]) + level.vehicle_life_range_low[var_0];
  } else {
    self.health = level.vehicle_life[var_0];
  }
  if(isDefined(level.destructible_model[self.model])) {
    self.health = 2000;
    self.destructible_type = level.destructible_model[self.model];
    common_scripts\_destructible::setup_destructibles(1);
  }
}

mginit() {
  var_0 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = self.vehicletype + self.model;
  }
  if(isDefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }
  if(!isDefined(level.vehicle_mgturret[var_0])) {
    return;
  }
  var_1 = 0;

  if(isDefined(self.script_mg_angle)) {
    var_1 = self.script_mg_angle;
  }
  var_2 = level.vehicle_mgturret[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = isDefined(self.script_noteworthy) && self.script_noteworthy == "onemg";

  foreach(var_7, var_5 in var_2) {
    var_6 = spawnturret("misc_turret", (0, 0, 0), var_5.info);

    if(isDefined(var_5.offset_tag)) {
      var_6 linkTo(self, var_5.tag, var_5.offset_tag, (0, -1 * var_1, 0));
    } else {
      var_6 linkTo(self, var_5.tag, (0, 0, 0), (0, -1 * var_1, 0));
    }
    var_6 setModel(var_5.model);
    var_6.angles = self.angles;
    var_6.isvehicleattached = 1;
    var_6.ownervehicle = self;
    var_6.script_team = self.script_team;
    var_6 thread maps\_mgturret::burst_fire_unmanned();
    var_6 makeunusable();
    set_turret_team(var_6);
    level thread maps\_mgturret::mg42_setdifficulty(var_6, maps\_utility::getdifficulty());

    if(isDefined(self.script_fireondrones)) {
      var_6.script_fireondrones = self.script_fireondrones;
    }
    if(isDefined(var_5.deletedelay)) {
      var_6.deletedelay = var_5.deletedelay;
    }
    if(isDefined(var_5.maxrange)) {
      var_6.maxrange = var_5.maxrange;
    }
    if(isDefined(var_5.defaultdroppitch)) {
      var_6 setdefaultdroppitch(var_5.defaultdroppitch);
    }
    self.mgturret[var_7] = var_6;

    if(var_3) {
      break;
    }
  }

  foreach(var_10, var_6 in self.mgturret) {
    var_9 = level.vehicle_mgturret[var_0][var_10].defaultonmode;

    if(isDefined(var_9)) {
      var_6 turret_set_default_on_mode(var_9);
    }
  }

  if(!isDefined(self.script_turretmg)) {
    self.script_turretmg = 1;
  }
  if(isDefined(self.script_turretmg) && self.script_turretmg == 0) {
    thread mgoff();
  } else {
    self.script_turretmg = 1;
    thread mgon();
  }

  thread mgtoggle();
}

mgtoggle() {
  if(isDefined(level.vehicles_ignore_mg_toggle) && level.vehicles_ignore_mg_toggle) {
    return;
  }
  self endon("death");

  if(self.script_turretmg) {
    var_0 = 1;
  } else {
    var_0 = 0;
  }
  for(;;) {
    if(var_0 != self.script_turretmg) {
      var_0 = self.script_turretmg;

      if(self.script_turretmg) {
        thread mgon();
      } else {
        thread mgoff();
      }
    }

    wait 0.5;
  }
}

mgoff() {
  self.script_turretmg = 0;

  if(ishelicopter() && hashelicopterturret()) {
    thread chopper_turret_off();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_2, var_1 in self.mgturret) {
    if(isDefined(var_1.script_fireondrones)) {
      var_1.script_fireondrones = 0;
    }
    var_1 setmode("manual");
  }
}

mgon() {
  self.script_turretmg = 1;

  if(ishelicopter() && hashelicopterturret()) {
    thread chopper_turret_on();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_1 in self.mgturret) {
    var_1 show();

    if(isDefined(var_1.script_fireondrones)) {
      var_1.script_fireondrones = 1;
    }
    if(isDefined(var_1.defaultonmode)) {
      if(var_1.defaultonmode != "sentry") {
        var_1 setmode(var_1.defaultonmode);
      }
    } else {
      var_1 setmode("auto_nonai");
    }
    set_turret_team(var_1);
  }
}

set_turret_team(var_0) {
  switch (self.script_team) {
    case "friendly":
    case "allies":
      var_0 setturretteam("allies");
      break;
    case "enemy":
    case "axis":
      var_0 setturretteam("axis");
      break;
    case "team3":
      var_0 setturretteam("team3");
      break;
    default:
      break;
  }
}

turret_set_default_on_mode(var_0) {
  self.defaultonmode = var_0;
}

ishelicopter() {
  return isDefined(level.helicopter_list[self.vehicletype]);
}

isairplane() {
  return isDefined(level.airplane_list[self.vehicletype]);
}

ischeap() {
  if(!isDefined(self.script_cheap)) {
    return 0;
  }
  if(!self.script_cheap) {
    return 0;
  }
  return 1;
}

hashelicopterdustkickup() {
  if(!ishelicopter() && !isairplane()) {
    return 0;
  }
  if(ischeap()) {
    return 0;
  }
  return 1;
}

hashelicopterturret() {
  if(!isDefined(self.vehicletype)) {
    return 0;
  }
  if(ischeap()) {
    return 0;
  }
  if(self.vehicletype == "cobra") {
    return 1;
  }
  if(self.vehicletype == "cobra_player") {
    return 1;
  }
  if(self.vehicletype == "viper") {
    return 1;
  }
  return 0;
}

chopper_turret_on() {
  self endon("death");
  self endon("mg_off");
  var_0 = cos(55);

  while(self.health > 0) {
    var_1 = maps\_helicopter_globals::getenemytarget(16000, var_0, 1, 1);

    if(isDefined(var_1)) {
      thread maps\_helicopter_globals::shootenemytarget_bullets(var_1);
    }
    wait 2;
  }
}

chopper_turret_off() {
  self notify("mg_off");
}

playloopedfxontag(var_0, var_1, var_2) {
  var_3 = get_dummy();
  var_4 = spawn("script_origin", var_3.origin);
  self endon("fire_extinguish");
  thread playloopedfxontag_originupdate(var_2, var_4);

  for(;;) {
    playFX(var_0, var_4.origin, var_4.upvec);
    wait(var_1);
  }
}

playloopedfxontag_originupdate(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1.forwardvec = anglesToForward(var_1.angles);
  var_1.upvec = anglestoup(var_1.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var_2 = get_dummy();
    var_1.angles = var_2 gettagangles(var_0);
    var_1.origin = var_2 gettagorigin(var_0);
    var_1.forwardvec = anglesToForward(var_1.angles);
    var_1.upvec = anglestoup(var_1.angles);
    wait 0.05;
  }
}

build_turret(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.vehicle_mgturret)) {
    level.vehicle_mgturret = [];
  }
  var_9 = level.vtclassname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_9 = level.vttype + level.vtmodel;
  }
  if(!isDefined(level.vehicle_mgturret[var_9])) {
    level.vehicle_mgturret[var_9] = [];
  }
  precachemodel(var_2);
  precacheturret(var_0);
  var_10 = spawnStruct();
  var_10.info = var_0;
  var_10.tag = var_1;
  var_10.model = var_2;
  var_10.maxrange = var_3;
  var_10.defaultonmode = var_4;
  var_10.deletedelay = var_5;
  var_10.defaultdroppitch = var_6;
  var_10.defaultdropyaw = var_7;

  if(isDefined(var_8)) {
    var_10.offset_tag = var_8;
  }
  level.vehicle_mgturret[var_9][level.vehicle_mgturret[var_9].size] = var_10;
}

setup_dvars() {}

empty_var(var_0) {}

setup_levelvars() {
  level.vehicle_resumespeed = 5;
  level.vehicle_deletegroup = [];
  level.vehicle_startmovegroup = [];
  level.vehicle_rideai = [];
  level.vehicle_walkai = [];
  level.vehicle_deathswitch = [];
  level.vehicle_ridespawners = [];
  level.vehicle_walkspawners = [];
  level.vehicle_gatetrigger = [];
  level.vehicle_crashpaths = [];
  level.vehicle_link = [];
  level.vehicle_detourpaths = [];
  level.vehicle_startnodes = [];
  level.vehicle_killspawn_groups = [];

  if(!isDefined(level.drive_spline_path_fun)) {
    level.drive_spline_path_fun = ::empty_var;
  }
  level.helicopter_crash_locations = getEntArray("helicopter_crash_location", "targetname");
  level.helicopter_crash_locations = common_scripts\utility::array_combine(level.helicopter_crash_locations, maps\_utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  level.playervehicle = spawn("script_origin", (0, 0, 0));
  level.playervehiclenone = level.playervehicle;
  level.vehicles = [];
  level.vehicles["allies"] = [];
  level.vehicles["axis"] = [];
  level.vehicles["neutral"] = [];
  level.vehicles["team3"] = [];

  if(!isDefined(level.vehicle_team)) {
    level.vehicle_team = [];
  }
  if(!isDefined(level.vehicle_deathmodel)) {
    level.vehicle_deathmodel = [];
  }
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
  if(!isDefined(level.vehicle_rumble)) {
    level.vehicle_rumble = [];
  }
  if(!isDefined(level.vehicle_rumble_override)) {
    level.vehicle_rumble_override = [];
  }
  if(!isDefined(level.vehicle_mgturret)) {
    level.vehicle_mgturret = [];
  }
  if(!isDefined(level.vehicle_isstationary)) {
    level.vehicle_isstationary = [];
  }
  if(!isDefined(level.vehicle_death_earthquake)) {
    level.vehicle_death_earthquake = [];
  }
  if(!isDefined(level.vehicle_treads)) {
    level.vehicle_treads = [];
  }
  if(!isDefined(level.vehicle_unloadgroups)) {
    level.vehicle_unloadgroups = [];
  }
  if(!isDefined(level.vehicle_aianims)) {
    level.vehicle_aianims = [];
  }
  if(!isDefined(level.vehicle_unloadwhenattacked)) {
    level.vehicle_unloadwhenattacked = [];
  }
  if(!isDefined(level.vehicle_exhaust)) {
    level.vehicle_exhaust = [];
  }
  if(!isDefined(level.vehicle_deckdust)) {
    level.vehicle_deckdust = [];
  }
  if(!isDefined(level.vehicle_shoot_shock)) {
    level.vehicle_shoot_shock = [];
  }
  if(!isDefined(level.vehicle_hide_list)) {
    level.vehicle_hide_list = [];
  }
  if(!isDefined(level.vehicle_frontarmor)) {
    level.vehicle_frontarmor = [];
  }
  if(!isDefined(level.destructible_model)) {
    level.destructible_model = [];
  }
  if(!isDefined(level.vehicle_types)) {
    level.vehicle_types = [];
  }
  if(!isDefined(level.vehicle_grenadeshield)) {
    level.vehicle_grenadeshield = [];
  }
  if(!isDefined(level.vehicle_bulletshield)) {
    level.vehicle_bulletshield = [];
  }
  if(!isDefined(level.vehicle_death_jolt)) {
    level.vehicle_death_jolt = [];
  }
  if(!isDefined(level.vehicle_death_badplace)) {
    level.vehicle_death_badplace = [];
  }
  if(!isDefined(level.vehicle_idleanim)) {
    level.vehicle_idleanim = [];
  }
  maps\_vehicle_aianim::setup_aianimthreads();
}

attacker_isonmyteam(var_0) {
  if(isDefined(var_0) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team) {
    return 1;
  } else {
    return 0;
  }
}

is_invulnerable_from_ai(var_0) {
  if(!isDefined(self.script_ai_invulnerable)) {
    return 0;
  }
  if(isDefined(var_0) && isai(var_0) && self.script_ai_invulnerable == 1) {
    return 1;
  } else {
    return 0;
  }
}

is_godmode() {
  if(isDefined(self.godmode) && self.godmode) {
    return 1;
  } else {
    return 0;
  }
}

attacker_troop_isonmyteam(var_0) {
  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(var_0) && isPlayer(var_0)) {
    return 1;
  } else if(isai(var_0) && var_0.team == self.script_team) {
    return 1;
  } else {
    return 0;
  }
}

has_frontarmor() {
  return isDefined(level.vehicle_frontarmor[self.vehicletype]);
}

grenadeshielded(var_0) {
  if(!isDefined(self.script_grenadeshield)) {
    return 0;
  }
  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "grenade")) {
    return 0;
  }
  if(self.script_grenadeshield) {
    return 1;
  } else {
    return 0;
  }
}

bulletshielded(var_0) {
  if(!isDefined(self.script_bulletshield)) {
    return 0;
  }
  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "bullet") || issubstr(var_0, "explosive")) {
    return 0;
  }
  if(self.script_bulletshield) {
    return 1;
  } else {
    return 0;
  }
}

explosive_bulletshielded(var_0) {
  if(!isDefined(self.script_explosive_bullet_shield)) {
    return 0;
  }
  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "explosive")) {
    return 0;
  }
  if(self.script_explosive_bullet_shield) {
    return 1;
  } else {
    return 0;
  }
}

vehicle_should_regenerate(var_0, var_1) {
  return !isDefined(var_0) && self.script_team != "neutral" || attacker_isonmyteam(var_0) || attacker_troop_isonmyteam(var_0) || common_scripts\utility::isdestructible() || is_invulnerable_from_ai(var_0) || bulletshielded(var_1) || explosive_bulletshielded(var_1) || grenadeshielded(var_1) || var_1 == "MOD_MELEE";
}

friendlyfire_shield() {
  self endon("death");

  if(!isDefined(level.unstoppable_friendly_fire_shield)) {
    self endon("stop_friendlyfire_shield");
  }
  var_0 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = self.vehicletype;
  }
  if(isDefined(level.vehicle_bulletshield[var_0]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle_bulletshield[var_0];
  }
  if(isDefined(level.vehicle_grenadeshield[var_0]) && !isDefined(self.script_grenadeshield)) {
    self.script_grenadeshield = level.vehicle_bulletshield[var_0];
  }
  if(isDefined(self.script_mp_style_helicopter)) {
    self.script_mp_style_helicopter = 1;
    self.bullet_armor = 5000;
    self.health = 350;
  } else {
    self.script_mp_style_helicopter = 0;
  }
  self.healthbuffer = 20000;
  self.health = self.health + self.healthbuffer;
  self.currenthealth = self.health;
  var_1 = undefined;
  var_2 = undefined;

  for(var_3 = undefined; self.health > 0; var_3 = undefined) {
    self waittill("damage", var_4, var_1, var_5, var_6, var_2, var_7, var_8, var_9, var_10, var_3);

    foreach(var_12 in self.damage_functions) {}
    thread[[var_12]](var_4, var_1, var_5, var_6, var_2, var_7, var_8);

    if(isDefined(var_1)) {
      var_1 maps\_player_stats::register_shot_hit();
    }
    if(vehicle_should_regenerate(var_1, var_2) || is_godmode()) {
      self.health = self.currenthealth;
    } else if(has_frontarmor()) {
      regen_front_armor(var_1, var_4);
      self.currenthealth = self.health;
    } else if(hit_bullet_armor(var_2)) {
      self.health = self.currenthealth;
      self.bullet_armor = self.bullet_armor - var_4;
    } else {
      self.currenthealth = self.health;
    }
    if(common_scripts\_destructible::getdamagetype(var_2) == "splash") {
      self.rocket_destroyed_for_achievement = 1;
    } else {
      self.rocket_destroyed_for_achievement = undefined;
    }
    if(self.health < self.healthbuffer && !isDefined(self.vehicle_stays_alive)) {
      break;
    }

    var_4 = undefined;
    var_1 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_2 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
  }

  self notify("death", var_1, var_2, var_3);
}

hit_bullet_armor(var_0) {
  if(!self.script_mp_style_helicopter) {
    return 0;
  }
  if(self.bullet_armor <= 0) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!issubstr(var_0, "BULLET")) {
    return 0;
  } else {
    return 1;
  }
}

regen_front_armor(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(var_0.origin - self.origin);

  if(vectordot(var_2, var_3) > 0.86) {
    self.health = self.health + int(var_1 * level.vehicle_frontarmor[self.vehicletype]);
  }
}

vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

vehicle_rumble() {
  self endon("kill_rumble_forever");
  var_0 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = self.vehicletype;
  }
  var_1 = undefined;

  if(isDefined(self.vehicle_rumble_unique)) {
    var_1 = self.vehicle_rumble_unique;
  } else if(isDefined(level.vehicle_rumble_override) && isDefined(level.vehicle_rumble_override[var_0])) {
    var_1 = level.vehicle_rumble_override;
  } else if(isDefined(level.vehicle_rumble[var_0])) {
    var_1 = level.vehicle_rumble[var_0];
  }
  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 enablelinkTo();
  var_4 linkTo(self);
  self.rumbletrigger = var_4;
  self endon("death");

  if(!isDefined(self.rumbleon)) {
    self.rumbleon = 1;
  }
  if(isDefined(var_1.scale)) {
    self.rumble_scale = var_1.scale;
  } else {
    self.rumble_scale = 0.15;
  }
  if(isDefined(var_1.duration)) {
    self.rumble_duration = var_1.duration;
  } else {
    self.rumble_duration = 4.5;
  }
  if(isDefined(var_1.radius)) {
    self.rumble_radius = var_1.radius;
  } else {
    self.rumble_radius = 600;
  }
  if(isDefined(var_1.basetime)) {
    self.rumble_basetime = var_1.basetime;
  } else {
    self.rumble_basetime = 1;
  }
  if(isDefined(var_1.randomaditionaltime)) {
    self.rumble_randomaditionaltime = var_1.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }
  var_4.radius = self.rumble_radius;

  for(;;) {
    var_4 waittill("trigger");

    if(self vehicle_getspeed() == 0 || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(var_1.rumble);

    while(level.player istouching(var_4) && self.rumbleon && self vehicle_getspeed() > 0) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
    }

    self stoprumble(var_1.rumble);
  }
}

vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

vehicle_badplace() {
  if(!isDefined(self.script_badplace)) {
    return;
  }
  self endon("kill_badplace_forever");

  if(!self isphysveh()) {
    self endon("death");
  }
  self endon("delete");

  if(isDefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }

  var_0 = isDefined(level.vehicle_hasmainturret[self.model]) && level.vehicle_hasmainturret[self.model];
  var_1 = 0.5;
  var_2 = 17;
  var_3 = 17;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self.script_badplace) || !self.script_badplace) {
      while(isDefined(self) && (!isDefined(self.script_badplace) || !self.script_badplace)) {
        wait 0.5;
      }
      if(!isDefined(self)) {
        return;
      }
    }

    var_4 = self vehicle_getspeed();

    if(var_4 <= 0) {
      wait(var_1);
      continue;
    }

    if(var_4 < 5) {
      var_5 = 200;
    } else if(var_4 > 5 && var_4 < 8) {
      var_5 = 350;
    } else {
      var_5 = 500;
    }
    if(isDefined(self.badplacemodifier)) {
      var_5 = var_5 * self.badplacemodifier;
    }
    if(var_0) {
      var_6 = anglesToForward(self gettagangles("tag_turret"));
    } else {
      var_6 = anglesToForward(self.angles);
    }
    badplace_arc(self.unique_id + "arc", var_1, self.origin, var_5 * 1.9, 300, var_6, var_2, var_3, "axis", "team3", "allies");
    badplace_cylinder(self.unique_id + "cyl", var_1, self.origin, 200, 300, "axis", "team3", "allies");
    wait(var_1 + 0.05);
  }
}

no_treads() {
  if(ishelicopter()) {
    return 1;
  }
  if(isairplane()) {
    return 1;
  }
  return 0;
}

vehicle_treads() {
  var_0 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = self.vehicletype;
  }
  if(!isDefined(level.vehicle_treads[var_0])) {
    return;
  }
  if(no_treads()) {
    return;
  }
  if(isDefined(level.tread_override_thread)) {
    self thread[[level.tread_override_thread]]("tag_origin", "back_left", (160, 0, 0));
  } else {
    var_1[0] = "snowmobile";
    var_1[1] = "snowmobile_friendly";
    var_1[2] = "snowmobile_player";
    var_1[3] = "motorcycle";

    if(maps\_utility::is_in_array(var_1, self.vehicletype)) {
      thread do_single_tread();
      return;
    }

    thread do_multiple_treads();
  }
}

do_single_tread() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = tread_wait();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    var_1 = get_dummy();
    var_1 tread(var_1, var_0, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}

do_multiple_treads() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = tread_wait();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    var_1 = get_dummy();
    tread(var_1, var_0, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    tread(var_1, var_0, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

vehicle_kill_treads_forever() {
  self notify("kill_treads_forever");
}

tread_wait() {
  var_0 = self vehicle_getspeed();

  if(!var_0) {
    return -1;
  }
  var_0 = var_0 * 17.6;
  var_1 = 1 / var_0;
  var_1 = clamp(var_1 * 35, 0.1, 0.3);

  if(isDefined(self.treadfx_freq_scale)) {
    var_1 = var_1 * self.treadfx_freq_scale;
  }
  wait(var_1);
  return var_1;
}

tread(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = treadget(self, var_3);

  if(var_6 == -1) {
    return;
  }
  var_7 = var_0 gettagangles(var_2);
  var_8 = anglesToForward(var_7);
  var_9 = self gettagorigin(var_2);

  if(var_4) {
    var_10 = self gettagorigin(var_5);
    var_9 = (var_9 + var_10) / 2;
  }

  playFX(var_6, var_9, anglestoup(var_7), var_8 * var_1);
}

treadget(var_0, var_1) {
  var_2 = self getwheelsurface(var_1);

  if(!isDefined(var_0.vehicletype)) {
    var_3 = -1;
    return var_3;
  }

  var_4 = var_0.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_4 = var_0.vehicletype;
  }
  if(!isDefined(level._vehicle_effect[var_4])) {
    wait 1;
    return -1;
  }

  var_3 = level._vehicle_effect[var_4][var_2];

  if(!isDefined(var_3)) {
    var_3 = -1;
  }
  return var_3;
}

isstationary() {
  var_0 = self.vehicletype;

  if(isDefined(level.vehicle_isstationary[var_0]) && level.vehicle_isstationary[var_0]) {
    return 1;
  } else {
    return 0;
  }
}

vehicle_shoot_shock() {
  if(!isDefined(level.vehicle_shoot_shock[self.classname])) {
    return;
  }
  if(getDvar("disable_tank_shock_minspec") == "1") {
    return;
  }
  self endon("death");

  if(!isDefined(level.vehicle_shoot_shock_overlay)) {
    level.vehicle_shoot_shock_overlay = newhudelem();
    level.vehicle_shoot_shock_overlay.x = 0;
    level.vehicle_shoot_shock_overlay.y = 0;
    level.vehicle_shoot_shock_overlay setshader("black", 640, 480);
    level.vehicle_shoot_shock_overlay.alignx = "left";
    level.vehicle_shoot_shock_overlay.aligny = "top";
    level.vehicle_shoot_shock_overlay.horzalign = "fullscreen";
    level.vehicle_shoot_shock_overlay.vertalign = "fullscreen";
    level.vehicle_shoot_shock_overlay.alpha = 0;
  }

  self endon("stop_vehicle_shoot_shock");

  for(;;) {
    self waittill("weapon_fired");

    if(isDefined(self.shock_distance)) {
      var_0 = self.shock_distance;
    } else {
      var_0 = 400;
    }
    if(isDefined(self.black_distance)) {
      var_1 = self.black_distance;
    } else {
      var_1 = 800;
    }
    var_2 = distance(self.origin, level.player.origin);

    if(var_2 > var_1) {
      continue;
    }
    level.vehicle_shoot_shock_overlay.alpha = 0.5;
    level.vehicle_shoot_shock_overlay fadeovertime(0.2);
    level.vehicle_shoot_shock_overlay.alpha = 0;

    if(var_2 > var_0) {
      continue;
    }
    if(isDefined(level.player.flashendtime) && level.player.flashendtime - gettime() > 200) {
      continue;
    }
    if(isDefined(self.shellshock_audio_disabled) && self.shellshock_audio_disabled) {
      continue;
    }
    var_3 = var_2 / var_0;
    var_4 = 4 - 3 * var_3;
    level.player shellshock(level.vehicle_shoot_shock[self.classname], var_4);
  }
}

vehicle_setteam() {
  var_0 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = self.vehicletype;
  }
  if(!isDefined(self.script_team) && isDefined(level.vehicle_team[var_0])) {
    self.script_team = level.vehicle_team[var_0];
  }
  level.vehicles[self.script_team] = maps\_utility::array_add(level.vehicles[self.script_team], self);
}

vehicle_handleunloadevent() {
  self endon("death");
  var_0 = self.vehicletype;

  if(!maps\_utility::ent_flag_exist("unloaded")) {
    maps\_utility::ent_flag_init("unloaded");
  }
}

get_vehiclenode_any_dynamic(var_0) {
  var_1 = getvehiclenode(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getEnt(var_0, "targetname");
  } else if(ishelicopter()) {}

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::getStruct(var_0, "targetname");
  }
  return var_1;
}

vehicle_resumepathvehicle() {
  if(!ishelicopter()) {
    self resumespeed(35);
    return;
  }

  var_0 = undefined;

  if(isDefined(self.currentnode.target)) {
    var_0 = get_vehiclenode_any_dynamic(self.currentnode.target);
  }
  if(!isDefined(var_0)) {
    return;
  }
  vehicle_paths(var_0);
}

setvehgoalpos_wrap(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.originheightoffset)) {
    var_0 = var_0 + (0, 0, self.originheightoffset);
  }
  self setvehgoalpos(var_0, var_1);
}

vehicle_liftoffvehicle(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 512;
  }
  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(var_1, 1);
  self waittill("goal");
}

waittill_stable() {
  var_0 = 12;
  var_1 = 400;
  var_2 = gettime() + var_1;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_0) {
      var_2 = gettime() + var_1;
    }
    if(abs(self.angles[2]) > var_0) {
      var_2 = gettime() + var_1;
    }
    if(gettime() > var_2) {
      break;
    }

    wait 0.05;
  }
}

littlebird_landing() {
  self endon("death");
  maps\_utility::ent_flag_init("prep_unload");
  maps\_utility::ent_flag_wait("prep_unload");
  turn_unloading_drones_to_ai();
  var_0 = get_landing_node();
  var_0 littlebird_lands_and_unloads(self);
  vehicle_paths(var_0);
}

get_landing_node() {
  var_0 = self.currentnode;

  for(;;) {
    var_1 = maps\_utility::getent_or_struct(var_0.target, "targetname");

    if(isDefined(var_1.script_unload)) {
      return var_1;
    }
    var_0 = var_1;
  }
}

unload_node(var_0) {
  self endon("death");

  if(isDefined(self.ent_flag["prep_unload"]) && maps\_utility::ent_flag("prep_unload")) {
    return;
  }
  if(issubstr(self.classname, "snowmobile")) {
    while(self.veh_speed > 15) {
      wait 0.05;
    }
  }

  if(!isDefined(var_0.script_flag_wait) && !isDefined(var_0.script_delay)) {
    self notify("newpath");
  }
  var_1 = getnode(var_0.targetname, "target");

  if(isDefined(var_1) && self.riders.size) {
    foreach(var_3 in self.riders) {
      if(isai(var_3)) {
        var_3 thread maps\_spawner::go_to_node(var_1);
      }
    }
  }

  if(ishelicopter()) {
    self sethoverparams(0, 0, 0);
    waittill_stable();
  } else {
    self vehicle_setspeed(0, 35);
  }
  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "wait_for_flag") {
      common_scripts\utility::flag_wait(var_0.script_flag);
    }
  }

  vehicle_unload(var_0.script_unload);

  if(maps\_vehicle_aianim::riders_unloadable(var_0.script_unload)) {
    self waittill("unloaded");
  }
  if(isDefined(var_0.script_flag_wait) || isDefined(var_0.script_delay)) {
    return;
  }
  if(isDefined(self)) {
    thread vehicle_resumepathvehicle();
  }
}

move_turrets_here(var_0) {
  var_1 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_1 = self.vehicletype + self.model;
  }
  if(!isDefined(self.mgturret)) {
    return;
  }
  if(self.mgturret.size == 0) {
    return;
  }
  foreach(var_4, var_3 in self.mgturret) {
    var_3 unlink();
    var_3 linkTo(var_0, level.vehicle_mgturret[var_1][var_4].tag, (0, 0, 0), (0, 0, 0));
  }
}

vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");
  self setgoalyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

vehicle_to_dummy() {
  self.modeldummy = spawn("script_model", self.origin);
  self.modeldummy setModel(self.model);
  self.modeldummy.origin = self.origin;
  self.modeldummy.angles = self.angles;
  self.modeldummy useanimtree(#animtree);
  self hide();
  thread model_dummy_death();
  move_riders_here(self.modeldummy);
  move_turrets_here(self.modeldummy);
  move_truck_junk_here(self.modeldummy);
  thread move_lights_here(self.modeldummy);
  move_effects_ent_here(self.modeldummy);
  copy_destructable_attachments(self.modeldummy);
  self.modeldummyon = 1;

  if(hashelicopterdustkickup()) {
    self notify("stop_kicking_up_dust");
    thread aircraft_dust_kickup(self.modeldummy);
  }

  return self.modeldummy;
}

move_effects_ent_here(var_0) {
  var_1 = deathfx_ent();
  var_1 unlink();
  var_1 linkTo(var_0);
}

model_dummy_death() {
  var_0 = self.modeldummy;
  var_0 endon("death");
  var_0 endon("stop_model_dummy_death");

  while(isDefined(self)) {
    self waittill("death");
    waittillframeend;
  }

  var_0 delete();
}

move_lights_here(var_0, var_1) {
  var_0 lights_on_internal("all", self.classname);
  wait 0.3;
  thread vehicle_lights_off("all", self.classname);
}

move_truck_junk_here(var_0) {
  if(!isDefined(self.truckjunk)) {
    return;
  }
  foreach(var_2 in self.truckjunk) {
    if(var_2 == var_0) {
      continue;
    }
    var_2 unlink();

    if(isDefined(var_2.script_ghettotag)) {
      var_2 linkTo(var_0, var_2.script_ghettotag, var_2.base_origin, var_2.base_angles);
      continue;
    }

    var_2 linkTo(var_0);
  }
}

dummy_to_vehicle() {
  if(ishelicopter()) {
    self.modeldummy.origin = self gettagorigin("tag_ground");
  } else {
    self.modeldummy.origin = self.origin;
    self.modeldummy.angles = self.angles;
  }

  self show();
  move_riders_here(self);
  move_turrets_here(self);
  thread move_lights_here(self);
  move_effects_ent_here(self);
  self.modeldummyon = 0;
  self.modeldummy delete();
  self.modeldummy = undefined;

  if(hashelicopterdustkickup()) {
    self notify("stop_kicking_up_dust");
    thread aircraft_dust_kickup();
  }

  return self.modeldummy;
}

move_riders_here(var_0) {
  if(!isDefined(self.riders)) {
    return;
  }
  var_1 = self.riders;

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = maps\_vehicle_aianim::anim_pos(self, var_3.vehicle_position);

    if(isDefined(var_4.passenger_2_turret_func)) {
      continue;
    }
    var_3 unlink();
    var_3 linkTo(var_0, var_4.sittag, (0, 0, 0), (0, 0, 0));

    if(isai(var_3)) {
      var_3 forceteleport(var_0 gettagorigin(var_4.sittag));
      continue;
    }

    var_3.origin = var_0 gettagorigin(var_4.sittag);
  }
}

spawn_vehicles_from_targetname_newstyle(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.code_classname) || var_5.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(var_5)) {
      var_1[var_1.size] = vehicle_spawn(var_5);
    }
  }

  return var_1;
}

spawn_vehicles_from_targetname(var_0) {
  var_1 = [];
  var_1 = spawn_vehicles_from_targetname_newstyle(var_0);
  return var_1;
}

spawn_vehicle_from_targetname(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  return var_1[0];
}

spawn_vehicle_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  thread gopath(var_1[0]);
  return var_1[0];
}

spawn_vehicles_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);

  foreach(var_3 in var_1) {}
  thread gopath(var_3);

  return var_1;
}

aircraft_dust_kickup(var_0) {
  self endon("death_finished");
  self endon("stop_kicking_up_dust");
  var_1 = 1200;

  if(isDefined(level.treadfx_maxheight)) {
    var_1 = level.treadfx_maxheight;
  }
  var_2 = 350;
  var_3 = 0.15;
  var_4 = 0.05;
  var_5 = 3;
  var_6 = var_5;
  var_7 = 1.0;

  if(isairplane()) {
    var_7 = 0.15;
  }
  var_8 = var_7;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = self;

  if(isDefined(var_0)) {
    var_11 = var_0;
  }
  if(isDefined(level.treadfx_immediate)) {
    var_8 = 0.1;
    var_6 = 1;
  }

  while(isDefined(self)) {
    if(isDefined(level.skip_treadfx)) {
      return 1;
    }
    if(var_8 <= 0) {
      var_8 = var_7;
    }
    wait(var_8);

    if(!isDefined(self)) {
      return;
    }
    var_6--;

    if(var_6 <= 0) {
      var_6 = var_5;
      var_9 = bulletTrace(var_11.origin, var_11.origin - (0, 0, 100000), 0, var_11);
      var_10 = distance(var_11.origin, var_9["position"]);
      var_8 = (var_10 - var_2) / (var_1 - var_2) * (var_3 - var_4) + var_4;
    }

    if(!isDefined(var_9)) {
      continue;
    }
    if(var_10 > var_1) {
      var_8 = var_7;
      continue;
    }

    if(isDefined(var_9["entity"])) {
      var_8 = var_7;
      continue;
    }

    if(!isDefined(var_9["position"])) {
      var_8 = var_7;
      continue;
    }

    if(!isDefined(var_9["surfacetype"])) {
      var_9["surfacetype"] = "dirt";
    }
    var_12 = self.classname;

    if(maps\_utility::is_iw4_map_sp()) {
      var_12 = self.vehicletype;
    }
    if(level._vehicle_effect[var_12][var_9["surfacetype"]] != -1) {
      playFX(level._vehicle_effect[var_12][var_9["surfacetype"]], var_9["position"]);
      continue;
    }
  }
}

tank_crush(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = 1;
  }
  var_7 = vehicle_to_dummy();
  self vehicle_setspeed(7 * var_6, 5, 5);
  var_8 = getanimlength(var_2) / var_6;
  var_9 = var_8 / 3;
  var_10 = var_8 / 3;
  var_11 = var_0.origin;
  var_12 = var_0.angles;
  var_13 = anglesToForward(var_12);
  var_14 = anglestoup(var_12);
  var_15 = anglestoright(var_12);
  var_16 = getstartorigin(var_11, var_12, var_2);
  var_17 = getstartangles(var_11, var_12, var_2);
  var_18 = anglesToForward(var_17);
  var_19 = anglestoup(var_17);
  var_20 = anglestoright(var_17);
  var_21 = anglesToForward(var_7.angles);
  var_22 = anglestoup(var_7.angles);
  var_23 = anglestoright(var_7.angles);
  var_24 = var_11 - var_16;
  var_25 = vectordot(var_24, var_18);
  var_26 = vectordot(var_24, var_19);
  var_27 = vectordot(var_24, var_20);
  var_28 = spawn("script_origin", var_7.origin);
  var_28.origin = var_28.origin + var_21 * var_25;
  var_28.origin = var_28.origin + var_22 * var_26;
  var_28.origin = var_28.origin + var_23 * var_27;
  var_24 = anglesToForward(var_12);
  var_25 = vectordot(var_24, var_18);
  var_26 = vectordot(var_24, var_19);
  var_27 = vectordot(var_24, var_20);
  var_29 = var_21 * var_25;
  var_29 = var_29 + var_22 * var_26;
  var_29 = var_29 + var_23 * var_27;
  var_28.angles = vectortoangles(var_29);

  if(isDefined(var_5)) {
    level thread common_scripts\utility::play_sound_in_space(var_5, var_11);
  }
  var_7 linkTo(var_28);
  var_0 useanimtree(var_4);
  var_7 useanimtree(var_4);
  var_0 thread tank_crush_fx_on_tag("tag_window_left_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.2);
  var_0 thread tank_crush_fx_on_tag("tag_window_right_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.4);
  var_0 thread tank_crush_fx_on_tag("tag_windshield_back_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 0.7);
  var_0 thread tank_crush_fx_on_tag("tag_windshield_front_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 1.5);
  var_0 animScripted("tank_crush_anim", var_11, var_12, var_3);
  var_7 animScripted("tank_crush_anim", var_28.origin, var_28.angles, var_2);

  if(var_6 != 1) {
    var_0 setflaggedanim("tank_crush_anim", var_3, 1, 0, var_6);
    var_7 setflaggedanim("tank_crush_anim", var_2, 1, 0, var_6);
  }

  var_28 moveTo(var_11, var_9, var_9 / 2, var_9 / 2);
  var_28 rotateTo(var_12, var_9, var_9 / 2, var_9 / 2);
  wait(var_9);
  var_8 = var_8 - var_9;
  var_8 = var_8 - var_10;
  wait(var_8);
  var_30 = spawn("script_model", var_16);
  var_30.angles = var_17;
  var_31 = var_30 localtoworldcoords(getmovedelta(var_2, 0, 1));
  var_32 = var_17 + (0, getangledelta(var_2, 0, 1), 0);
  var_30 delete();
  var_33 = anglesToForward(var_32);
  var_34 = anglestoup(var_32);
  var_35 = anglestoright(var_32);
  var_36 = self getattachpos(var_1);
  var_21 = anglesToForward(var_36[1]);
  var_22 = anglestoup(var_36[1]);
  var_23 = anglestoright(var_36[1]);
  var_24 = var_11 - var_31;
  var_25 = vectordot(var_24, var_33);
  var_26 = vectordot(var_24, var_34);
  var_27 = vectordot(var_24, var_35);
  var_28.final_origin = var_36[0];
  var_28.final_origin = var_28.final_origin + var_21 * var_25;
  var_28.final_origin = var_28.final_origin + var_22 * var_26;
  var_28.final_origin = var_28.final_origin + var_23 * var_27;
  var_24 = anglesToForward(var_12);
  var_25 = vectordot(var_24, var_33);
  var_26 = vectordot(var_24, var_34);
  var_27 = vectordot(var_24, var_35);
  var_29 = var_21 * var_25;
  var_29 = var_29 + var_22 * var_26;
  var_29 = var_29 + var_23 * var_27;
  var_28.final_angles = vectortoangles(var_29);

  if(getDvar("debug_tankcrush") == "1") {
    thread maps\_utility::draw_line_from_ent_for_time(level.player, self.origin, 1, 0, 0, var_8 / 2);
    thread maps\_utility::draw_line_from_ent_for_time(level.player, var_31, 0, 1, 0, var_8 / 2);
    thread maps\_utility::draw_line_from_ent_to_ent_for_time(level.player, var_28, 0, 0, 1, var_8 / 2);
  }

  var_28 moveTo(var_28.final_origin, var_10, var_10 / 2, var_10 / 2);
  var_28 rotateTo(var_28.final_angles, var_10, var_10 / 2, var_10 / 2);
  wait(var_10);
  self attachpath(var_1);
  common_scripts\utility::waitframe();
  dummy_to_vehicle();
}

tank_crush_fx_on_tag(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    wait(var_3);
  }
  playFXOnTag(var_1, self, var_0);

  if(isDefined(var_2)) {
    thread maps\_utility::play_sound_on_tag(var_2, var_0);
  }
}

loadplayer(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_2 = undefined;

  foreach(var_4 in self.riders) {
    if(var_4.vehicle_position == var_0) {
      var_2 = var_4;
      var_2.drone_delete_on_unload = 1;
      var_2.playerpiggyback = 1;
      break;
    }
  }

  thread show_rigs(var_0);
  var_6 = maps\_vehicle_aianim::anim_pos(self, var_0);
  var_2 notify("newanim");
  var_2 detachall();
  var_2 setModel("fastrope_arms");
  var_2 useanimtree(var_6.player_animtree);
  thread maps\_vehicle_aianim::guy_idle(var_2, var_0);
  level.player playerlinktodelta(var_2, "tag_player", 1.0, 40, 18, 30, 30);
  var_2 hide();
  var_7 = getanimlength(var_6.getout);
  var_7 = var_7 - var_1;
  self waittill("unloading");
  level.player disableweapons();
  var_2 notsolid();
  wait(var_7);
  level.player unlink();
  level.player enableweapons();
}

show_rigs(var_0) {
  wait 0.01;
  thread maps\_vehicle_aianim::getout_rigspawn(self, var_0);

  if(!self.riders.size) {
    return;
  }
  foreach(var_2 in self.riders) {}
  thread maps\_vehicle_aianim::getout_rigspawn(self, var_2.vehicle_position);
}

turret_deleteme(var_0) {
  if(isDefined(self)) {
    if(isDefined(var_0.deletedelay)) {
      wait(var_0.deletedelay);
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

vehicle_wheels_forward() {
  wheeldirectionchange(1);
}

vehicle_wheels_backward() {
  wheeldirectionchange(0);
}

wheeldirectionchange(var_0) {
  if(var_0 <= 0) {
    self.wheeldir = 0;
  } else {
    self.wheeldir = 1;
  }
}

maingun_fx() {
  if(isDefined(level.maingun_fx_override)) {
    thread[[level.maingun_fx_override]]();
    return;
  }

  var_0 = self.model;

  if(!isDefined(level.vehicle_deckdust[var_0])) {
    return;
  }
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    playFXOnTag(level.vehicle_deckdust[var_0], self, "tag_engine_exhaust");
    var_1 = self gettagorigin("tag_flash");
    var_2 = physicstrace(var_1, var_1 + (0, 0, -128));
    physicsexplosionsphere(var_2, 192, 100, 1);
  }
}

playtankexhaust() {
  self endon("death");
  var_0 = self.model;

  if(!isDefined(level.vehicle_exhaust[var_0])) {
    return;
  }
  var_1 = 0.1;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    playFXOnTag(level.vehicle_exhaust[var_0], get_dummy(), "tag_engine_exhaust");
    wait(var_1);
  }
}

build_light(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle_lights)) {
    level.vehicle_lights = [];
  }
  if(!isDefined(level.vehicle_lights_group_override)) {
    level.vehicle_lights_group_override = [];
  }
  if(isDefined(level.vehicle_lights_group_override[var_4]) && !level.vtoverride) {
    return;
  }
  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.tag = var_2;
  var_6.delay = var_5;
  var_6.effect = common_scripts\utility::_loadfx(var_3);
  level.vehicle_lights[var_0][var_1] = var_6;
  group_light(var_0, var_1, "all");

  if(isDefined(var_4)) {
    group_light(var_0, var_1, var_4);
  }
}

build_light_override(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
  level.vtclassname = var_0;
  build_light(var_0, var_1, var_2, var_3, var_4, var_5);
  level.vtoverride = 0;
  level.vehicle_lights_group_override[var_4] = 1;
}

group_light(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle_lights_group)) {
    level.vehicle_lights_group = [];
  }
  if(!isDefined(level.vehicle_lights_group[var_0])) {
    level.vehicle_lights_group[var_0] = [];
  }
  if(!isDefined(level.vehicle_lights_group[var_0][var_2])) {
    level.vehicle_lights_group[var_0][var_2] = [];
  }
  foreach(var_4 in level.vehicle_lights_group[var_0][var_2]) {
    if(var_1 == var_4) {
      return;
    }
  }

  level.vehicle_lights_group[var_0][var_2][level.vehicle_lights_group[var_0][var_2].size] = var_1;
}

lights_on(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  common_scripts\utility::array_levelthread(var_2, ::lights_on_internal, var_1);
}

lights_delayfxforframe() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");

  if(!isDefined(level.fxdelay)) {
    level.fxdelay = 0;
  }
  level.fxdelay = level.fxdelay + randomfloatrange(0.2, 0.4);

  if(level.fxdelay > 2) {
    level.fxdelay = 0;
  }
  wait 0.05;
  level.fxdelay = undefined;
}

lights_on_internal(var_0, var_1) {
  level.lastlighttime = gettime();

  if(!isDefined(var_0)) {
    var_0 = "all";
  }
  if(!isDefined(var_1)) {
    var_1 = self.classname;

    if(maps\_utility::is_iw4_map_sp() && level.script != "contingency" && level.script != "invasion") {
      var_1 = self.model;
    }
  }

  if(!isDefined(level.vehicle_lights_group)) {
    return;
  }
  if(!isDefined(level.vehicle_lights_group[var_1]) || !isDefined(level.vehicle_lights_group[var_1][var_0])) {
    return;
  }
  thread lights_delayfxforframe();

  if(!isDefined(self.lights)) {
    self.lights = [];
  }
  var_2 = level.vehicle_lights_group[var_1][var_0];
  var_3 = 0;
  var_4 = [];

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(isDefined(self.lights[var_2[var_5]])) {
      continue;
    }
    var_6 = level.vehicle_lights[var_1][var_2[var_5]];

    if(isDefined(var_6.delay)) {
      var_7 = var_6.delay;
    } else {
      var_7 = 0;
    }
    for(var_7 = var_7 + level.fxdelay; isDefined(var_4["" + var_7]); var_7 = var_7 + 0.05) {}

    var_4["" + var_7] = 1;
    self endon("death");
    childthread common_scripts\utility::noself_delaycall_proc(::playfxontag, var_7, var_6.effect, self, var_6.tag);
    self.lights[var_2[var_5]] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level.fxdelay = 0;
}

deathfx_ent() {
  if(!isDefined(self.deathfx_ent)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_1 = get_dummy();
    var_0 setModel(self.model);
    var_0.origin = var_1.origin;
    var_0.angles = var_1.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkTo(var_1);
    self.deathfx_ent = var_0;
  } else {
    self.deathfx_ent setModel(self.model);
  }
  return self.deathfx_ent;
}

lights_off(var_0, var_1, var_2) {
  var_3 = strtok(var_0, " ", var_1);
  common_scripts\utility::array_levelthread(var_3, ::lights_off_internal, var_1, var_2);
}

lights_off_internal(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_1 = var_2;
  } else if(!isDefined(var_1)) {
    if(maps\_utility::is_iw4_map_sp()) {
      var_1 = self.model;
    } else {
      var_1 = self.classname;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = "all";
  }
  if(!isDefined(self.lights)) {
    return;
  }
  if(!isDefined(level.vehicle_lights_group[var_1][var_0])) {
    return;
  }
  var_3 = level.vehicle_lights_group[var_1][var_0];
  var_4 = 0;
  var_5 = 2;

  if(isDefined(self.maxlightstopsperframe)) {
    var_5 = self.maxlightstopsperframe;
  }
  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = level.vehicle_lights[var_1][var_3[var_6]];
    stopFXOnTag(var_7.effect, self, var_7.tag);
    var_4++;

    if(var_4 >= var_5) {
      var_4 = 0;
      wait 0.05;
    }

    if(!isDefined(self)) {
      return;
    }
    self.lights[var_3[var_6]] = undefined;
  }
}

build_hideparts(var_0, var_1) {
  if(!isDefined(level.vehicle_hide_list)) {
    level.vehicle_hide_list = [];
  }
  level.vehicle_hide_list[var_0] = var_1;
}

build_deathmodel(var_0, var_1, var_2, var_3) {
  if(var_0 != level.vtmodel) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }
  precachemodel(var_0);
  precachemodel(var_1);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(!isDefined(var_3) || maps\_utility::is_iw4_map_sp()) {
    level.vehicle_deathmodel[var_0] = var_1;
    level.vehicle_deathmodel_delay[var_0] = var_2;
  } else {
    level.vehicle_deathmodel[var_3] = var_1;
    level.vehicle_deathmodel_delay[var_3] = var_2;
  }
}

build_shoot_shock(var_0) {
  precacheshader("black");
  precacheshellshock(var_0);
  level.vehicle_shoot_shock[level.vtclassname] = var_0;
}

build_idle(var_0) {
  if(!isDefined(level.vehicle_idleanim)) {
    level.vehicle_idleanim = [];
  }
  if(!isDefined(level.vehicle_idleanim[level.vtmodel])) {
    level.vehicle_idleanim[level.vtmodel] = [];
  }
  level.vehicle_idleanim[level.vtmodel][level.vehicle_idleanim[level.vtmodel].size] = var_0;
}

build_drive(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 10;
  }
  level.vehicle_driveidle[level.vtmodel] = var_0;

  if(isDefined(var_1)) {
    level.vehicle_driveidle_r[level.vtmodel] = var_1;
  }
  level.vehicle_driveidle_normal_speed[level.vtmodel] = var_2;

  if(isDefined(var_3)) {
    level.vehicle_driveidle_animrate[level.vtmodel] = var_3;
  }
}

build_template(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
  if(isDefined(var_2)) {
    var_0 = var_2;
  }
  if(maps\_utility::is_iw4_map_sp()) {
    var_3 = var_0 + var_1;
  } else {}

  precachevehicle(var_0);

  if(!isDefined(level.vehicle_death_fx)) {
    level.vehicle_death_fx = [];
  }
  if(!isDefined(level.vehicle_death_fx[var_3])) {
    level.vehicle_death_fx[var_3] = [];
  }
  level.vehicle_team[var_3] = "axis";
  level.vehicle_life[var_3] = 999;
  level.vehicle_hasmainturret[var_1] = 0;
  level.vehicle_mainturrets[var_1] = [];
  level.vtmodel = var_1;
  level.vttype = var_0;
  level.vtclassname = var_3;
}

build_exhaust(var_0) {
  level.vehicle_exhaust[level.vtmodel] = common_scripts\utility::_loadfx(var_0);
}

build_treadfx() {
  var_0 = level.vtclassname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_0 = level.vttype;
  }
  maps\_treadfx::main(var_0);
}

build_team(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_team[level.vttype] = var_0;
  } else {
    level.vehicle_team[level.vtclassname] = var_0;
  }
}

build_mainturret(var_0, var_1, var_2, var_3) {
  level.vehicle_hasmainturret[level.vtmodel] = 1;

  if(isDefined(var_0)) {
    level.vehicle_mainturrets[level.vtmodel][var_0] = 1;
  }
  if(isDefined(var_1)) {
    level.vehicle_mainturrets[level.vtmodel][var_1] = 1;
  }
  if(isDefined(var_2)) {
    level.vehicle_mainturrets[level.vtmodel][var_2] = 1;
  }
  if(isDefined(var_3)) {
    level.vehicle_mainturrets[level.vtmodel][var_3] = 1;
  }
}

build_bulletshield(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_bulletshield[level.vttype] = var_0;
  } else {
    level.vehicle_bulletshield[level.vtclassname] = var_0;
  }
}

build_grenadeshield(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_grenadeshield[level.vttype] = var_0;
  } else {
    level.vehicle_grenadeshield[level.vtclassname] = var_0;
  }
}

build_aianims(var_0, var_1) {
  var_2 = level.vtclassname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_2 = level.vttype;
  }
  level.vehicle_aianims[var_2] = [[var_0]]();

  if(isDefined(var_1)) {
    level.vehicle_aianims[var_2] = [[var_1]](level.vehicle_aianims[var_2]);
  }
}

build_frontarmor(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_frontarmor[level.vttype] = var_0;
  } else {
    level.vehicle_frontarmor[level.vtclassname] = var_0;
  }
}

build_attach_models(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_attachedmodels[level.vttype] = [[var_0]]();
  } else {
    level.vehicle_attachedmodels[level.vtclassname] = [[var_0]]();
  }
}

build_unload_groups(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_unloadgroups[level.vttype] = [[var_0]]();
  } else {
    level.vehicle_unloadgroups[level.vtclassname] = [[var_0]]();
  }
}

build_life(var_0, var_1, var_2) {
  var_3 = level.vtclassname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_3 = level.vttype;
  }
  level.vehicle_life[var_3] = var_0;
  level.vehicle_life_range_low[var_3] = var_1;
  level.vehicle_life_range_high[var_3] = var_2;
}

build_deckdust(var_0) {
  level.vehicle_deckdust[level.vtmodel] = common_scripts\utility::_loadfx(var_0);
}

build_destructible(var_0, var_1) {
  if(isDefined(level.vehicle_csv_export)) {
    return;
  }
  if(var_0 != level.vtmodel) {
    return;
  }
  var_2 = spawnStruct();
  var_2.model = var_0;
  var_2 maps\_utility::precache_destructible(var_1);
  level.destructible_model[level.vtmodel] = var_1;
}

build_localinit(var_0) {
  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicleinitthread[level.vttype][level.vtmodel] = var_0;
  } else {
    level.vehicleinitthread[level.vttype][level.vtclassname] = var_0;
  }
}

get_from_spawnstruct(var_0) {
  return common_scripts\utility::getStruct(var_0, "targetname");
}

get_from_entity(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }
  return undefined;
}

get_from_spawnstruct_target(var_0) {
  return common_scripts\utility::getStruct(var_0, "target");
}

get_from_entity_target(var_0) {
  return getEnt(var_0, "target");
}

get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "targetname");
}

set_lookat_from_dest(var_0) {
  var_1 = getEnt(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_1) || level.script == "hunted") {
    return;
  }
  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

get_deletegroups(var_0) {
  var_1 = [];
  var_2 = getEntArray("script_vehicle", "code_classname");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.script_vehiclegroupdelete) || var_4.script_vehiclegroupdelete != var_0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

damage_hint_bullet_only() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
      case "bullet":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          var_1 maps\_utility::display_hint("invulerable_bullets");
          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self)) {
            self.displayingdamagehints = 0;
          }
          break;
        }
    }
  }
}

damage_hints() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
      case "bullet":
      case "mod_grenade_splash":
      case "mod_grenade":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;

          if(var_4 == "mod_grenade" || var_4 == "mod_grenade_splash") {
            var_1 maps\_utility::display_hint("invulerable_frags");
          } else {
            var_1 maps\_utility::display_hint("invulerable_bullets");
          }
          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self)) {
            self.displayingdamagehints = 0;
          }
          break;
        }
    }
  }
}

damage_hints_cleanup() {
  self waittill("death");

  if(self.displayingdamagehints) {
    level.armordamagehints = 0;
  }
}

copy_destructable_attachments(var_0) {
  var_1 = self getattachsize();
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2[var_3] = tolower(self getattachmodelname(var_3));
  }
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_0 attach(var_2[var_3], tolower(self getattachtagname(var_3)));
  }
}

get_dummy() {
  if(self.modeldummyon) {
    var_0 = self.modeldummy;
  } else {
    var_0 = self;
  }
  return var_0;
}

is_dummy() {
  return self.modeldummyon;
}

apply_truckjunk() {
  if(!isDefined(self.truckjunk)) {
    return;
  }
  var_0 = self.truckjunk;
  self.truckjunk = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.spawner)) {
      var_3 = common_scripts\utility::spawn_tag_origin();
      var_3.spawner = var_2.spawner;
    } else {
      var_3 = spawn("script_model", self.origin);
      var_3 setModel(var_2.model);
    }

    var_4 = "tag_body";

    if(isDefined(var_2.script_ghettotag)) {
      var_3.script_ghettotag = var_2.script_ghettotag;
      var_3.base_origin = var_2.origin;
      var_3.base_angles = var_2.angles;
      var_4 = var_2.script_ghettotag;
    }

    if(isDefined(var_2.destroyefx)) {
      var_2 thread truckjunk_dyn(var_3);
    }
    if(isDefined(var_2.script_noteworthy)) {
      var_3.script_noteworthy = var_2.script_noteworthy;
    }
    if(isDefined(var_2.script_parameters)) {
      var_3.script_parameters = var_2.script_parameters;
    }
    var_3 linkTo(self, var_4, var_2.origin, var_2.angles);

    if(isDefined(var_2.destructible_type)) {
      var_3.destructible_type = var_2.destructible_type;
      var_3 common_scripts\_destructible::setup_destructibles(1);
    }

    self.truckjunk[self.truckjunk.size] = var_3;
  }
}

truckjunk_dyn(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 8000;
  var_0 waittill("damage");
  var_0 hide();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 linkTo(var_0);
  playFXOnTag(self.destroyefx, var_1, "tag_origin");
}

truckjunk() {
  var_0 = getEnt(self.target, "targetname");
  var_1 = ghetto_tag_create(var_0);

  if(isspawner(self)) {
    var_1.spawner = self;
  }
  if(isDefined(self.targetname)) {
    var_2 = getEnt(self.targetname, "target");

    if(isspawner(var_2)) {
      var_1.spawner = var_2;
    }
  }

  if(isDefined(self.script_noteworthy)) {
    var_1.script_noteworthy = self.script_noteworthy;
  }
  if(isDefined(self.script_parameters)) {
    var_1.script_parameters = self.script_parameters;
  }
  if(isDefined(self.script_fxid)) {
    var_1.destroyefx = common_scripts\utility::getfx(self.script_fxid);
  }
  if(!isDefined(var_0.truckjunk)) {
    var_0.truckjunk = [];
  }
  if(isDefined(self.script_startingposition)) {
    var_1.script_startingposition = self.script_startingposition;
  }
  if(isDefined(self.destructible_type)) {
    maps\_utility::precache_destructible(self.destructible_type);
    var_1.destructible_type = self.destructible_type;
  }

  var_0.truckjunk[var_0.truckjunk.size] = var_1;

  if(!isDefined(self.classname)) {
    return;
  }
  if(isspawner(self)) {
    return;
  }
  self delete();
}

ghetto_tag_create(var_0) {
  var_1 = spawnStruct();
  var_2 = "tag_body";

  if(isDefined(self.script_ghettotag)) {
    var_2 = self.script_ghettotag;
    var_1.script_ghettotag = self.script_ghettotag;
  }

  var_1.origin = self.origin - var_0 gettagorigin(var_2);

  if(!isDefined(self.angles)) {
    var_3 = (0, 0, 0);
  } else {
    var_3 = self.angles;
  }
  var_1.angles = var_3 - var_0 gettagangles(var_2);
  var_1.model = self.model;

  if(isDefined(self.script_modelname)) {
    precachemodel(self.script_modelname);
    var_1.model = self.script_modelname;
  }

  if(isDefined(var_1.targetname)) {
    level.struct_class_names["targetname"][var_1.targetname] = undefined;
  }
  if(isDefined(var_1.target)) {
    level.struct_class_names["target"][var_1.target] = undefined;
  }
  return var_1;
}

twobuttonspressed(var_0, var_1) {
  return level.player buttonPressed(var_0) && level.player buttonPressed(var_1);
}

vehicle_load_ai(var_0, var_1, var_2) {
  maps\_vehicle_aianim::load_ai(var_0, undefined, var_2);
}

vehicle_load_ai_single(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  maps\_vehicle_aianim::load_ai(var_3, var_1, var_2);
}

kill_badplace(var_0) {
  if(!isDefined(level.vehicle_death_badplace[var_0])) {
    return;
  }
  var_1 = level.vehicle_death_badplace[var_0];

  if(isDefined(var_1.delay)) {
    wait(var_1.delay);
  }
  if(!isDefined(self)) {
    return;
  }
  badplace_cylinder("vehicle_kill_badplace", var_1.duration, self.origin, var_1.radius, var_1.height, var_1.team1, var_1.team2);
}

build_death_badplace(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle_death_badplace)) {
    level.vehicle_death_badplace = [];
  }
  var_6 = spawnStruct();
  var_6.delay = var_0;
  var_6.duration = var_1;
  var_6.height = var_2;
  var_6.radius = var_3;
  var_6.team1 = var_4;
  var_6.team2 = var_5;

  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_death_badplace[level.vttype] = var_6;
  } else {
    level.vehicle_death_badplace[level.vtclassname] = var_6;
  }
}

build_death_jolt(var_0) {
  if(!isDefined(level.vehicle_death_jolt)) {
    level.vehicle_death_jolt = [];
  }
  var_1 = spawnStruct();
  var_1.delay = var_0;

  if(maps\_utility::is_iw4_map_sp()) {
    level.vehicle_death_jolt[level.vttype] = var_1;
  } else {
    level.vehicle_death_jolt[level.vtclassname] = var_1;
  }
}

kill_jolt(var_0) {
  if(isDefined(level.vehicle_death_jolt[var_0])) {
    self.dontfreeme = 1;
    wait(level.vehicle_death_jolt[var_0].delay);
  }

  if(!isDefined(self)) {
    return;
  }
  self joltbody(self.origin + (23, 33, 64), 3);
  wait 2;

  if(!isDefined(self)) {
    return;
  }
  self.dontfreeme = undefined;
}

heli_squashes_stuff(var_0) {
  self endon("death");
  level endon(var_0);

  for(;;) {
    self waittill("trigger", var_1);

    if(isalive(var_1)) {
      if(var_1.team == "allies" && !isPlayer(var_1)) {
        continue;
      }
      var_1 kill((0, 0, 0));
    }
  }
}

_getvehiclespawnerarray_by_spawngroup(var_0) {
  var_1 = _getvehiclespawnerarray();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_vehiclespawngroup) && var_4.script_vehiclespawngroup == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_getvehiclespawnerarray(var_0) {
  var_1 = getEntArray("script_vehicle", "code_classname");

  if(isDefined(var_0)) {
    var_2 = [];

    foreach(var_4 in var_1) {
      if(!isDefined(var_4.targetname)) {
        continue;
      }
      if(var_4.targetname == var_0) {
        var_2 = maps\_utility::array_add(var_2, var_4);
      }
    }

    var_1 = var_2;
  }

  var_6 = [];

  foreach(var_4 in var_1) {
    if(isspawner(var_4)) {
      var_6[var_6.size] = var_4;
    }
  }

  return var_6;
}

setup_gags() {
  if(!isDefined(self.script_parameters)) {
    return;
  }
  if(self.script_parameters == "gag_ride_in") {
    setup_gag_ride();
  }
}

setup_gag_ride() {
  var_0 = getEntArray(self.targetname, "target");
  self.script_vehicleride = auto_assign_ride_group();

  foreach(var_2 in var_0) {
    var_2.qsetgoalpos = 0;
    level.vehicle_ridespawners = array_2dadd(level.vehicle_ridespawners, self.script_vehicleride, var_2);
  }

  level.gag_heliride_spawner = self;
}

auto_assign_ride_group() {
  if(!isDefined(level.vehicle_group_autoasign)) {
    level.vehicle_group_autoasign = 1000;
  } else {
    level.vehicle_group_autoasign++;
  }
  return level.vehicle_group_autoasign;
}

vehicle_script_forcecolor_riders(var_0) {
  foreach(var_2 in self.riders) {
    if(isai(var_2)) {
      var_2 maps\_utility::set_force_color(var_0);
      continue;
    }

    if(isDefined(var_2.spawner)) {
      var_2.spawner.script_forcecolor = var_0;
      continue;
    }
  }
}

vehicle_spawn_group_limit_riders(var_0, var_1) {
  var_2 = sort_by_startingpos(level.vehicle_ridespawners[var_0]);
  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_3[var_3.size] = var_2[var_4];
  }
  level.vehicle_ridespawners[var_0] = var_3;
}

update_steering(var_0) {
  if(var_0.update_time != gettime()) {
    var_0.update_time = gettime();

    if(var_0.steering_enable) {
      var_1 = clamp(0 - var_0.angles[2], 0 - var_0.steering_maxroll, var_0.steering_maxroll) / var_0.steering_maxroll;

      if(isDefined(var_0.leanasitturns) && var_0.leanasitturns) {
        var_2 = var_0 vehicle_getsteering();
        var_2 = var_2 * -1.0;
        var_1 = var_1 + var_2;

        if(var_1 != 0) {
          var_3 = 1.0 / abs(var_1);

          if(var_3 < 1) {
            var_1 = var_1 * var_3;
          }
        }
      }

      var_4 = var_1 - var_0.steering;

      if(var_4 != 0) {
        var_5 = var_0.steering_maxdelta / abs(var_4);

        if(var_5 < 1) {
          var_4 = var_4 * var_5;
        }
        var_0.steering = var_0.steering + var_4;
      }
    } else {
      var_0.steering = 0;
    }
  }

  return var_0.steering;
}

mount_snowmobile(var_0, var_1) {
  self endon("death");
  self endon("long_death");

  if(maps\_utility::doinglongdeath()) {
    return;
  }
  var_2 = [];
  var_2[0] = "snowmobile_driver";
  var_2[1] = "snowmobile_passenger";
  var_3 = [];
  var_3["snowmobile_driver"] = "tag_driver";
  var_3["snowmobile_passenger"] = "tag_passenger";
  var_4 = var_2[var_1];
  var_5 = var_3[var_4];
  var_6 = var_0 gettagorigin(var_5);
  var_7 = var_0 gettagangles(var_5);
  var_8 = undefined;
  var_9 = undefined;
  var_10 = 9999999;

  foreach(var_16, var_12 in level.snowmobile_mount_anims[var_4]) {
    var_13 = maps\_utility::getanim_generic(var_16);
    var_14 = getstartorigin(var_6, var_7, var_13);
    var_15 = distance(self.origin, var_14);

    if(var_15 < var_10) {
      var_10 = var_15;
      var_9 = var_14;
      var_8 = var_16;
    }
  }

  var_9 = maps\_utility::drop_to_ground(var_9);
  self.goalradius = 8;
  self.disablearrivals = 1;
  self setgoalpos(var_9);
  self waittill("goal");
  var_0 maps\_anim::anim_generic(self, var_8, var_5);
  var_0 thread maps\_vehicle_aianim::guy_enter(self);
  self.disablearrivals = 0;
}

get_my_spline_node(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = maps\_utility::get_array_of_closest(var_0, level.snowmobile_path);
  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_2[var_3] = var_1[var_3];
  }
  for(var_3 = 0; var_3 < level.snowmobile_path.size; var_3++) {
    foreach(var_5 in var_2) {
      if(var_5 == level.snowmobile_path[var_3]) {
        return var_5;
      }
    }
  }
}

spawn_vehicle_and_attach_to_spline_path(var_0) {
  if(level.enemy_snowmobiles.size >= 8) {
    return;
  }
  var_1 = maps\_utility::spawn_vehicle();

  if(isDefined(var_0)) {
    var_1 phys_setspeed(var_0);
  }
  var_1 thread vehicle_becomes_crashable();
  var_1 endon("death");
  var_1.dontunloadonend = 1;
  var_1 gopath(var_1);
  var_1 leave_path_for_spline_path();
}

leave_path_for_spline_path() {
  self endon("script_crash_vehicle");
  common_scripts\utility::waittill_either("enable_spline_path", "reached_end_node");
  var_0 = get_my_spline_node(self.origin);
  var_0 thread[[level.drive_spline_path_fun]](self);
}

kill_vehicle_spawner(var_0) {
  var_0 waittill("trigger");

  foreach(var_2 in level.vehicle_killspawn_groups[var_0.script_kill_vehicle_spawner]) {}
  var_2 delete();

  level.vehicle_killspawn_groups[var_0.script_kill_vehicle_spawner] = [];
}

spawn_vehicle_and_gopath() {
  var_0 = maps\_utility::spawn_vehicle();

  if(isDefined(self.script_speed)) {
    if(!ishelicopter()) {
      var_0 phys_setspeed(self.script_speed);
    }
  }

  var_0 thread gopath(var_0);
  return var_0;
}

attach_vehicle_triggers() {
  var_0 = getEntArray("vehicle_touch_trigger", "targetname");
  var_1 = getEntArray("vehicle_use_trigger", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy == self.model) {
      var_2 = var_4.origin;
      break;
    }
  }

  var_6 = [];

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy != self.model) {
      continue;
    }
    if(var_4.origin != var_2) {
      continue;
    }
    var_6[var_6.size] = var_4;
  }

  self.vehicle_triggers = [];

  foreach(var_4 in var_6) {
    var_4.targetname = undefined;
    var_4 thread manual_tag_linkto(self, "tag_origin");

    if(!isDefined(self.vehicle_triggers[var_4.code_classname])) {
      self.vehicle_triggers[var_4.code_classname] = [];
    }
    self.vehicle_triggers[var_4.code_classname][self.vehicle_triggers[var_4.code_classname].size] = var_4;
  }
}

humvee_antenna_animates(var_0) {
  self useanimtree(#animtree);
  humvee_antenna_animates_until_death(var_0);

  if(!isDefined(self)) {
    return;
  }
  self clearanim(var_0["idle"], 0);
  self clearanim(var_0["rot_l"], 0);
  self clearanim(var_0["rot_r"], 0);
}

humvee_antenna_animates_until_death(var_0) {
  self endon("death");

  for(;;) {
    var_1 = self.veh_speed / 18;

    if(var_1 <= 0.0001) {
      var_1 = 0.0001;
    }
    var_2 = randomfloatrange(0.3, 0.7);
    self setanim(var_0["idle"], var_1, 0, var_2);
    var_2 = randomfloatrange(0.1, 0.8);
    self setanim(var_0["rot_l"], 1, 0, var_2);
    var_2 = randomfloatrange(0.1, 0.8);
    self setanim(var_0["rot_r"], 1, 0, var_2);
    wait 0.5;
  }
}

manual_tag_linkto(var_0, var_1) {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(var_0)) {
      break;
    }

    var_2 = var_0 gettagorigin(var_1);
    var_3 = var_0 gettagangles(var_1);
    self.origin = var_2;
    self.angles = var_3;
    wait 0.05;
  }
}

littlebird_lands_and_unloads(var_0) {
  var_0 setdeceleration(6);
  var_0 setacceleration(4);
  var_0 settargetyaw(self.angles[1]);
  var_0 vehicle_setspeed(20, 7, 7);

  while(distance(common_scripts\utility::flat_origin(var_0.origin), common_scripts\utility::flat_origin(self.origin)) > 512) {
    wait 0.05;
  }
  var_0 endon("death");
  var_1 = "landing" + randomint(99999);
  badplace_cylinder(var_1, 30, self.origin, 200, 300, "axis", "allies", "neutral", "team3");
  var_0 thread vehicle_land_beneath_node(424, self);
  var_0 waittill("near_goal");
  badplace_delete(var_1);
  badplace_cylinder(var_1, 30, self.origin, 200, 300, "axis", "allies", "neutral", "team3");
  var_0 notify("groupedanimevent", "pre_unload");
  var_0 thread vehicle_ai_event("pre_unload");
  var_0 vehicle_setspeed(20, 22, 7);
  var_0 notify("nearing_landing");

  if(isDefined(var_0.custom_landing)) {
    switch (var_0.custom_landing) {
      case "hover_then_land":
        var_0 vehicle_setspeed(10, 22, 7);
        var_0 thread vehicle_land_beneath_node(32, self, 64);
        var_0 waittill("near_goal");
        var_0 notify("hovering");
        wait 1;
        break;
      default:
        break;
    }
  }

  var_0 thread vehicle_land_beneath_node(16, self);
  var_0 waittill("near_goal");
  badplace_delete(var_1);
  maps\_utility::script_delay();
  var_0 vehicle_unload();
  var_0 waittill_stable();
  var_0 vehicle_setspeed(20, 8, 7);
  wait 0.2;
  var_0 notify("stable_for_unlink");
  wait 0.2;

  if(isDefined(self.script_flag_set)) {
    common_scripts\utility::flag_set(self.script_flag_set);
  }
  if(isDefined(self.script_flag_wait)) {
    common_scripts\utility::flag_wait(self.script_flag_wait);
  }
  var_0 notify("littlebird_liftoff");
}

setup_gag_stage_littlebird_unload() {
  for(;;) {
    self waittill("trigger", var_0);
    littlebird_lands_and_unloads(var_0);
  }
}

setup_gag_stage_littlebird_load() {
  for(;;) {
    self waittill("trigger", var_0);
    var_0 setdeceleration(6);
    var_0 setacceleration(4);
    var_0 settargetyaw(self.angles[1]);
    var_0 vehicle_setspeed(20, 7, 7);

    while(distance(common_scripts\utility::flat_origin(var_0.origin), common_scripts\utility::flat_origin(self.origin)) > 256) {
      wait 0.05;
    }
    var_0 endon("death");
    var_0 thread vehicle_land_beneath_node(220, self);
    var_0 waittill("near_goal");
    var_0 vehicle_setspeed(20, 22, 7);
    var_0 thread vehicle_land_beneath_node(16, self);
    var_0 waittill("near_goal");
    var_0 waittill_stable();
    var_0 notify("touch_down", self);
    var_0 vehicle_setspeed(20, 8, 7);
  }
}

vehicle_land_beneath_node(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  self notify("newpath");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }
  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(var_1.angles)[1]);
  setvehgoalpos_wrap(maps\_utility::groundpos(var_1.origin) + (0, 0, var_2), 1);
  self waittill("goal");
}

vehicle_landvehicle(var_0, var_1) {
  self notify("newpath");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }
  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  setvehgoalpos_wrap(maps\_utility::groundpos(self.origin), 1);
  self waittill("goal");
}

vehicle_get_riders_by_group(var_0) {
  var_1 = [];
  var_2 = self.classname;

  if(maps\_utility::is_iw4_map_sp()) {
    var_2 = self.vehicletype;
  }
  if(!isDefined(level.vehicle_unloadgroups[var_2])) {
    return var_1;
  }
  var_3 = level.vehicle_unloadgroups[var_2];

  if(!isDefined(var_0)) {
    return var_1;
  }
  foreach(var_5 in self.riders) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5.vehicle_position == var_7) {
        var_1[var_1.size] = var_5;
      }
    }
  }

  return var_1;
}

vehicle_ai_event(var_0) {
  return maps\_vehicle_aianim::animate_guys(var_0);
}

vehicle_unload(var_0) {
  self notify("unloading");
  var_1 = [];

  if(maps\_utility::ent_flag_exist("no_riders_until_unload")) {
    maps\_utility::ent_flag_set("no_riders_until_unload");
    var_1 = spawn_unload_group(var_0);

    foreach(var_3 in var_1) {}
    maps\_utility::spawn_failed(var_3);
  }

  if(isDefined(var_0)) {
    self.unload_group = var_0;
  }
  foreach(var_6 in self.riders) {
    if(isalive(var_6)) {
      var_6 notify("unload");
    }
  }

  var_1 = vehicle_ai_event("unload");

  if(maps\_utility::is_iw4_map_sp()) {
    var_8 = level.vehicle_unloadgroups[self.vehicletype];
  } else {
    var_8 = level.vehicle_unloadgroups[self.classname];
  }
  if(isDefined(var_8)) {
    var_1 = [];
    var_9 = maps\_vehicle_aianim::get_unload_group();

    foreach(var_12, var_11 in self.riders) {
      if(isDefined(var_9[var_11.vehicle_position])) {
        var_1[var_1.size] = var_11;
      }
    }
  }

  return var_1;
}

get_stage_nodes(var_0, var_1) {
  var_2 = getnodearray(var_0.target, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5.script_noteworthy == "stage_" + var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

set_stage(var_0, var_1, var_2) {
  if(!maps\_utility::ent_flag_exist("staged_guy_" + var_2)) {
    maps\_utility::ent_flag_init("staged_guy_" + var_2);
  } else {
    maps\_utility::ent_flag_clear("staged_guy_" + var_2);
  }
  if(!maps\_utility::ent_flag_exist("guy2_in_" + var_2)) {
    maps\_utility::ent_flag_init("guy2_in_" + var_2);
  } else {
    maps\_utility::ent_flag_clear("guy2_in_" + var_2);
  }
  var_3 = get_stage_nodes(var_0, var_2);
  var_4 = common_scripts\utility::getStruct(var_0.target, "targetname");
  var_5 = spawn("script_model", (0, 0, 0));
  var_5 setModel(self.model);

  if(isDefined(self.new_stage_heli_spawn)) {
    var_5.origin = self.origin;
  } else {
    var_5.origin = maps\_utility::drop_to_ground(var_4.origin) + (0, 0, self.originheightoffset);
  }
  var_5.angles = var_4.angles;
  var_5 hide();
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  foreach(var_10 in var_3) {
    var_11 = undefined;

    foreach(var_13 in var_1) {
      if(isDefined(var_13.script_startingposition) && var_13.script_startingposition == var_10.script_startingposition) {
        var_11 = var_13;
        break;
      }
    }

    if(!isDefined(var_11)) {
      var_11 = maps\_utility::getclosest(var_10.origin, var_1);
    }
    var_11.script_startingposition = var_10.script_startingposition;

    if(var_11.script_startingposition == 2 || var_11.script_startingposition == 5) {
      var_6 = var_11;
      var_11 maps\_spawner::go_to_node_set_goal_node(var_10);
    } else if(var_11.script_startingposition == 3 || var_11.script_startingposition == 6) {
      var_8 = var_11;
    } else if(var_11.script_startingposition == 4 || var_11.script_startingposition == 7) {
      var_7 = var_11;
      var_11 maps\_spawner::go_to_node_set_goal_node(var_10);
    }

    var_1 = common_scripts\utility::array_remove(var_1, var_11);
  }

  thread stage_guy(var_8, var_2, var_7, var_5);
  thread common_scripts\utility::delete_on_death(var_5);
}

load_side(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    if(var_6.script_startingposition == 2 || var_6.script_startingposition == 5) {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_startingposition == 3 || var_6.script_startingposition == 6) {
      var_4 = var_6;
      continue;
    }

    if(var_6.script_startingposition == 4 || var_6.script_startingposition == 7) {
      var_3 = var_6;
    }
  }

  maps\_utility::ent_flag_wait("staged_guy_" + var_0);
  thread vehicle_load_ai_single(var_2, undefined, var_0);
  var_2 waittill("boarding_vehicle");
  thread vehicle_load_ai_single(var_3, undefined, var_0);
  var_3 waittill("boarding_vehicle");
  maps\_utility::ent_flag_set("guy2_in_" + var_0);
}

stage_guy(var_0, var_1, var_2, var_3) {
  var_4 = "stage_littlebird_" + var_1;
  var_5 = [];
  var_5[0] = var_0;
  var_3 maps\_anim::anim_generic_reach(var_5[0], var_4, "tag_detach_" + var_1);
  var_3 maps\_anim::anim_generic(var_5[0], var_4, "tag_detach_" + var_1);
  maps\_utility::ent_flag_set("staged_guy_" + var_1);
  var_0 setgoalpos(maps\_utility::drop_to_ground(var_0.origin));
  var_0.goalradius = 16;
  maps\_utility::ent_flag_wait("guy2_in_" + var_1);
  thread vehicle_load_ai_single(var_0, undefined, var_1);
}

kill_riders(var_0) {
  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    if(!isDefined(var_2.ridingvehicle) && !isDefined(var_2.drivingvehicle)) {
      continue;
    }
    if(isDefined(var_2.magic_bullet_shield)) {
      var_2 maps\_utility::stop_magic_bullet_shield();
    }
    var_2 kill();
  }
}

vehicle_rider_death_detection(var_0, var_1) {
  if(level.script == "af_chase") {
    if(isDefined(self.vehicle_position) && self.vehicle_position != 0) {
      return;
    }
  }

  self.health = 1;
  var_0 endon("death");
  self.baseaccuracy = 0.15;
  self waittill("death");
  var_0 notify("driver_died");
  kill_riders(var_1);
}

vehicle_becomes_crashable() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend;
  self.riders = maps\_utility::remove_dead_from_array(self.riders);

  if(self.riders.size) {
    common_scripts\utility::array_thread(self.riders, ::vehicle_rider_death_detection, self, self.riders);
    common_scripts\utility::waittill_either("veh_collision", "driver_died");
    kill_riders(self.riders);
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self phys_crash();
}

vehicle_turret_scan_on() {
  self endon("death");
  self endon("stop_scanning_turret");
  var_0 = randomint(2);

  while(isDefined(self)) {
    if(common_scripts\utility::cointoss()) {
      vehicle_aim_turret_at_angle(0);
      wait(randomfloatrange(2, 10));
    }

    if(var_0 == 0) {
      var_1 = randomintrange(10, 30);
      var_0 = 1;
    } else {
      var_1 = randomintrange(-30, -10);
      var_0 = 0;
    }

    vehicle_aim_turret_at_angle(var_1);
    wait(randomfloatrange(2, 10));
  }
}

vehicle_turret_scan_off() {
  self notify("stop_scanning_turret");
}

vehicle_aim_turret_at_angle(var_0) {
  self endon("death");
  var_1 = anglesToForward(self.angles + (0, var_0, 0));
  var_1 = var_1 * 10000;
  var_1 = var_1 + (0, 0, 70);
  self setturrettargetvec(var_1);
}

vehicle_get_path_array() {
  self endon("death");
  var_0 = [];
  var_1 = self.attachedpath;

  if(!isDefined(self.attachedpath)) {
    return var_0;
  }
  var_2 = var_1;
  var_2.counted = 0;

  while(isDefined(var_2)) {
    if(isDefined(var_2.counted) && var_2.counted == 1) {
      break;
    }

    var_0 = maps\_utility::array_add(var_0, var_2);
    var_2.counted = 1;

    if(!isDefined(var_2.target)) {
      break;
    }

    if(!ishelicopter()) {
      var_2 = getvehiclenode(var_2.target, "targetname");
      continue;
    }

    var_2 = maps\_utility::getent_or_struct(var_2.target, "targetname");
  }

  return var_0;
}

kill_lights(var_0) {
  lights_off_internal("all", var_0);
}

vehicle_lights_on(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }
  lights_on(var_0, var_1);
}

vehicle_lights_off(var_0, var_1) {
  lights_off(var_0, var_1);
}

set_heli_move(var_0) {
  if(!maps\_utility::is_iw4_map_sp()) {}

  self setyawspeedbyname(var_0);

  if(var_0 == "faster") {
    self setmaxpitchroll(25, 50);
  }
}

get_light_model(var_0, var_1) {
  if(maps\_utility::is_iw4_map_sp() && !isDefined(var_1)) {
    return var_0;
  }
  return var_1;
}

vehicle_switch_paths(var_0, var_1) {
  self setswitchnode(var_0, var_1);
  self.attachedpath = var_1;
  thread vehicle_paths();
}

vehicle_stop_named(var_0, var_1, var_2) {
  if(!isDefined(self.vehicle_stop_named)) {
    self.vehicle_stop_named = [];
  }
  self vehicle_setspeed(0, var_1, var_2);
  self.vehicle_stop_named[var_0] = var_1;
}

vehicle_resume_named(var_0) {
  var_1 = self.vehicle_stop_named[var_0];
  self.vehicle_stop_named[var_0] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }
  self resumespeed(var_1);
}