/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_vehicle_code.gsc
********************************/

setup_script_gatetrigger(var_0) {
  var_1 = [];

  if(isdefined(var_0.script_gatetrigger))
    return level.vehicle_gatetrigger[var_0.script_gatetrigger];

  return var_1;
}

setup_vehicle_spawners() {
  var_0 = _getvehiclespawnerarray();

  foreach(var_2 in var_0)
  var_2 thread vehicle_spawn_think();
}

vehicle_spawn_think() {
  self endon("entitydeleted");

  if(isdefined(self.script_kill_vehicle_spawner)) {
    var_0 = self.script_kill_vehicle_spawner;

    if(!isdefined(level.vehicle_killspawn_groups[var_0]))
      level.vehicle_killspawn_groups[var_0] = [];

    level.vehicle_killspawn_groups[var_0][level.vehicle_killspawn_groups[var_0].size] = self;
  }

  if(isdefined(self.script_deathflag))
    thread maps\_spawner::vehicle_spawner_deathflag();

  thread vehicle_linked_entities_think();
  self.count = 1;
  self.spawn_functions = [];

  for (;;) {
    var_1 = undefined;
    self waittill("spawned", var_1);
    self.count--;

    if(!isdefined(var_1)) {
      continue;
    }
    var_1.spawn_funcs = self.spawn_functions;
    var_1.spawner = self;
    var_1 thread maps\_spawner::run_spawn_functions();
  }
}

vehicle_linked_entities_think() {
  if(!isdefined(self.script_vehiclecargo)) {
    return;
  }
  if(!isdefined(self.script_linkto)) {
    return;
  }
  var_0 = getentarray(self.script_linkto, "script_linkname");

  if(var_0.size == 0) {
    return;
  }
  var_1 = var_0[0].targetname;
  var_0 = getentarray(var_1, "targetname");
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.classname == "script_origin")
      var_2 = var_4;

    var_4 hide();
  }

  foreach(var_4 in var_0) {
    if(var_4 != var_2)
      var_4 linkto(var_2);
  }

  self waittill("spawned", var_8);

  foreach(var_4 in var_0) {
    var_4 show();

    if(var_4 != var_2)
      var_4 linkto(var_8);
  }

  var_8 waittill("death");
  common_scripts\utility::array_call(var_0, ::delete);
}

is_trigger_once() {
  if(!isdefined(self.classname))
    return 0;

  if(self.classname == "trigger_multiple")
    return 1;

  if(self.classname == "trigger_radius")
    return 1;

  if(self.classname == "trigger_lookat")
    return 1;

  return self.classname == "trigger_disk";
}

trigger_process(var_0) {
  var_1 = var_0 is_trigger_once();
  var_0.processed_trigger = undefined;

  if(isdefined(var_0.script_noteworthy) && var_0.script_noteworthy == "trigger_multiple")
    var_1 = 0;

  var_2 = setup_script_gatetrigger(var_0);
  var_3 = isdefined(var_0.script_vehiclespawngroup);
  var_4 = isdefined(var_0.script_vehicledetour) && (is_node_script_origin(var_0) || is_node_script_struct(var_0));
  var_5 = isdefined(var_0.detoured) && !(is_node_script_origin(var_0) || is_node_script_struct(var_0));
  var_6 = 1;

  while (var_6) {
    var_0 waittill("trigger", var_7);

    if(isdefined(var_0.script_vehicletriggergroup)) {
      if(!isdefined(var_7.script_vehicletriggergroup)) {
        continue;
      }
      if(var_7.script_vehicletriggergroup != var_0.script_vehicletriggergroup)
        continue;
    }

    if(isdefined(var_0.enabled) && !var_0.enabled)
      var_0 waittill("enable");

    if(isdefined(var_0.script_flag_set))
      common_scripts\utility::flag_set(var_0.script_flag_set);

    if(isdefined(var_0.script_flag_clear))
      common_scripts\utility::flag_clear(var_0.script_flag_clear);

    if(var_4)
      var_7 thread path_detour_script_origin(var_0);
    else if(var_5 && isdefined(var_7))
      var_7 thread path_detour(var_0);

    var_0 maps\_utility::script_delay();

    if(var_1)
      var_6 = 0;

    if(isdefined(var_0.script_vehiclegroupdelete)) {
      if(!isdefined(level.vehicle_deletegroup[var_0.script_vehiclegroupdelete]))
        level.vehicle_deletegroup[var_0.script_vehiclegroupdelete] = [];

      common_scripts\utility::array_levelthread(level.vehicle_deletegroup[var_0.script_vehiclegroupdelete], maps\_utility::deleteent);
    }

    if(var_3)
      _scripted_spawn(var_0.script_vehiclespawngroup);

    if(var_2.size > 0 && var_1)
      common_scripts\utility::array_levelthread(var_2, ::path_gate_open);

    if(isdefined(var_0.script_vehiclestartmove)) {
      if(!isdefined(level.vehicle_startmovegroup[var_0.script_vehiclestartmove])) {
        return;
      }
      common_scripts\utility::array_levelthread(level.vehicle_startmovegroup[var_0.script_vehiclestartmove], ::_gopath);
    }
  }
}

trigger_process_optimized(var_0, var_1) {
  var_2 = var_0 is_trigger_once();
  var_0.processed_trigger = undefined;

  if(isdefined(var_0.script_noteworthy) && var_0.script_noteworthy == "trigger_multiple")
    var_2 = 0;

  var_3 = setup_script_gatetrigger(var_0);
  var_4 = isdefined(var_0.script_vehiclespawngroup);
  var_5 = isdefined(var_0.script_vehicledetour) && (is_node_script_origin(var_0) || is_node_script_struct(var_0));
  var_6 = isdefined(var_0.detoured) && !(is_node_script_origin(var_0) || is_node_script_struct(var_0));
  var_7 = 1;

  if(isdefined(var_0.script_vehicletriggergroup)) {
    if(!isdefined(var_1.script_vehicletriggergroup)) {
      return;
    }
    if(var_1.script_vehicletriggergroup != var_0.script_vehicletriggergroup)
      return;
  }

  if(isdefined(var_0.enabled) && !var_0.enabled)
    var_0 waittill("enable");

  if(isdefined(var_0.script_flag_set))
    common_scripts\utility::flag_set(var_0.script_flag_set);

  if(isdefined(var_0.script_flag_clear))
    common_scripts\utility::flag_clear(var_0.script_flag_clear);

  if(var_5)
    var_1 thread path_detour_script_origin(var_0);
  else if(var_6 && isdefined(var_1))
    var_1 thread path_detour(var_0);

  var_0 maps\_utility::script_delay();

  if(var_2)
    var_7 = 0;

  if(isdefined(var_0.script_vehiclegroupdelete)) {
    if(!isdefined(level.vehicle_deletegroup[var_0.script_vehiclegroupdelete]))
      level.vehicle_deletegroup[var_0.script_vehiclegroupdelete] = [];

    common_scripts\utility::array_levelthread(level.vehicle_deletegroup[var_0.script_vehiclegroupdelete], maps\_utility::deleteent);
  }

  if(var_4)
    _scripted_spawn(var_0.script_vehiclespawngroup);

  if(var_3.size > 0 && var_2)
    common_scripts\utility::array_levelthread(var_3, ::path_gate_open);

  if(isdefined(var_0.script_vehiclestartmove)) {
    if(!isdefined(level.vehicle_startmovegroup[var_0.script_vehiclestartmove])) {
      return;
    }
    common_scripts\utility::array_levelthread(level.vehicle_startmovegroup[var_0.script_vehiclestartmove], ::_gopath);
  }
}

path_detour_get_detourpath(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.vehicle_detourpaths[var_0.script_vehicledetour]) {
    if(var_3 != var_0) {
      if(!islastnode(var_3))
        var_1 = var_3;
    }
  }

  return var_1;
}

path_detour_script_origin(var_0) {
  var_1 = path_detour_get_detourpath(var_0);

  if(isdefined(var_1))
    thread _vehicle_paths(var_1);
}

crash_detour_check(var_0) {
  return (isdefined(self.deaddriver) || self.health < self.healthbuffer || var_0.script_crashtype == "forced") && (!isdefined(var_0.derailed) || var_0.script_crashtype == "plane");
}

crash_derailed_check(var_0) {
  return isdefined(var_0.derailed) && var_0.derailed;
}

path_detour(var_0) {
  var_1 = getvehiclenode(var_0.target, "targetname");
  var_2 = path_detour_get_detourpath(var_1);

  if(!isdefined(var_2)) {
    return;
  }
  if(var_0.detoured && !isdefined(var_2.script_vehicledetourgroup)) {
    return;
  }
  if(isdefined(var_2.script_crashtype)) {
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
    if(isdefined(var_2.script_vehicledetourgroup)) {
      if(!isdefined(self.script_vehicledetourgroup)) {
        return;
      }
      if(var_2.script_vehicledetourgroup != self.script_vehicledetourgroup)
        return;
    }

    self notify("newpath");
    _setswitchnode(var_1, var_2);
    thread detour_flag(var_2);

    if(!islastnode(var_1) && !(isdefined(var_0.scriptdetour_persist) && var_0.scriptdetour_persist))
      var_0.detoured = 1;

    self.attachedpath = var_2;
    thread _vehicle_paths();

    if(self vehicle_isphysveh() && isdefined(var_1.script_transmission))
      thread reverse_node(var_1);

    return;
  }
}

reverse_node(var_0) {
  self endon("death");
  var_0 waittillmatch("trigger", self);
  self.veh_transmission = var_0.script_transmission;

  if(self.veh_transmission == "forward")
    wheeldirectionchange(1);
  else
    wheeldirectionchange(0);
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
  if(isdefined(var_0.script_linkname))
    level.vehicle_link = array_2dadd(level.vehicle_link, var_0.script_linkname, var_0);

  if(isdefined(var_0.script_vehiclestartmove))
    level.vehicle_startmovegroup = array_2dadd(level.vehicle_startmovegroup, var_0.script_vehiclestartmove, var_0);

  if(isdefined(var_0.script_vehiclegroupdelete))
    level.vehicle_deletegroup = array_2dadd(level.vehicle_deletegroup, var_0.script_vehiclegroupdelete, var_0);
}

spawn_array(var_0) {
  var_1 = [];
  var_2 = maps\_utility::ent_flag_exist("no_riders_until_unload");

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = 0;

    if(isdefined(var_4.script_drone)) {
      var_5 = 1;
      var_6 = maps\_utility::dronespawn_bodyonly(var_4);
    } else {
      var_7 = isdefined(var_4.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
      var_8 = var_4;

      if(isdefined(var_4.script_spawn_pool))
        var_8 = maps\_spawner::get_spawner_from_pool(var_4, 1);

      if(isdefined(var_4.script_forcespawn) || var_2)
        var_6 = var_8 stalingradspawn(var_7);
      else
        var_6 = var_8 dospawn(var_7);

      if(isdefined(var_4.script_spawn_pool)) {
        if(isdefined(var_4.script_startingposition))
          var_6.script_startingposition = var_4.script_startingposition;
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
  if(isalive(var_0))
    return 1;

  if(!isdefined(var_0))
    return 0;

  if(!isdefined(var_0.classname))
    return 0;

  return var_0.classname == "script_model";
}

spawn_group() {
  if(maps\_utility::ent_flag_exist("no_riders_until_unload") && !maps\_utility::ent_flag("no_riders_until_unload"))
    return [];

  var_0 = get_vehicle_ai_spawners();

  if(!var_0.size)
    return [];

  var_1 = [];
  var_2 = spawn_array(var_0);
  var_2 = common_scripts\utility::array_combine(var_2, get_vehicle_ai_riders());
  var_2 = sort_by_startingpos(var_2);

  foreach(var_4 in var_2)
  thread maps\_vehicle_aianim::guy_enter(var_4);

  return var_2;
}

spawn_unload_group(var_0) {
  if(!isdefined(var_0))
    return spawn_group();

  var_1 = get_vehicle_ai_spawners();

  if(!var_1.size)
    return [];

  var_2 = [];
  var_3 = self.classname;

  if(isdefined(level.vehicle_unloadgroups[var_3]) && isdefined(level.vehicle_unloadgroups[var_3][var_0])) {
    var_4 = level.vehicle_unloadgroups[var_3][var_0];

    foreach(var_6 in var_4)
    var_2[var_2.size] = var_1[var_6];

    var_8 = spawn_array(var_2);

    for (var_9 = 0; var_9 < var_4.size; var_9++)
      var_8[var_9].script_startingposition = var_4[var_9];

    var_8 = common_scripts\utility::array_combine(var_8, get_vehicle_ai_riders());
    var_8 = sort_by_startingpos(var_8);

    foreach(var_11 in var_8)
    thread maps\_vehicle_aianim::guy_enter(var_11);

    return var_8;
  } else
    return spawn_group();
}

sort_by_startingpos(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isdefined(var_4.script_startingposition)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  if(getdvarint("enableMW1GetArrayKeysAndForEach") != 0)
    return common_scripts\utility::array_combine(var_1, var_2);

  return common_scripts\utility::array_combine_reverse_keys(var_1, var_2);
}

setup_groundnode_detour(var_0) {
  var_1 = getvehiclenode(var_0.targetname, "target");

  if(!isdefined(var_1)) {
    return;
  }
  var_1.detoured = 0;

  if(common_scripts\utility::flag_exist("ca_blockout") && !common_scripts\utility::flag("ca_blockout")) {}

  add_proccess_trigger(var_1);
}

turn_unloading_drones_to_ai() {
  var_0 = maps\_vehicle_aianim::get_unload_group();

  foreach(var_3, var_2 in self.riders) {
    if(!isalive(var_2)) {
      continue;
    }
    if(isdefined(var_0[var_2.vehicle_position]))
      self.riders[var_3] = maps\_vehicle_aianim::guy_becomes_real_ai(var_2, var_2.vehicle_position);
  }
}

add_proccess_trigger(var_0) {
  if(isdefined(var_0.processed_trigger)) {
    return;
  }
  level.vehicle_processtriggers[level.vehicle_processtriggers.size] = var_0;
  var_0.processed_trigger = 1;
}

islastnode(var_0) {
  if(!isdefined(var_0.target))
    return 1;

  if(!isdefined(getvehiclenode(var_0.target, "targetname")) && !isdefined(get_vehiclenode_any_dynamic(var_0.target)))
    return 1;

  return 0;
}

get_path_getfunc(var_0) {
  var_1 = ::get_from_vehicle_node;

  if(_ishelicopter() && isdefined(var_0.target)) {
    if(isdefined(get_from_entity(var_0.target)))
      var_1 = ::get_from_entity;

    if(isdefined(get_from_spawnstruct(var_0.target)))
      var_1 = ::get_from_spawnstruct;
  }

  return var_1;
}

node_wait(var_0, var_1, var_2) {
  if(self.attachedpath == var_0) {
    waittillframeend;
    return;
  }

  self setwaitnode(var_0);
  self waittill("reached_wait_node");
}

wait_til_node_wait_triggered(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  for (var_5 = var_2; isdefined(var_2) && var_4 < 3; var_2 = [
      [var_3]
    ](var_2.target)) {
    var_4++;
    thread node_wait_triggered(var_0, var_1, var_2);

    if(!isdefined(var_2.target))
      return;
  }
}

node_wait_triggered(var_0, var_1, var_2) {
  self endon("newpath");
  self endon("death");
  var_0 endon(var_1);
  var_2 waittill("trigger");
  var_2.triggered_time = gettime();
  waittillframeend;
  var_0 notify(var_1);
}

vehicle_paths_non_heli(var_0) {
  self notify("newpath");

  if(isdefined(var_0))
    self.attachedpath = var_0;

  var_1 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isdefined(var_1)) {
    return;
  }
  self endon("newpath");
  self endon("death");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = get_path_getfunc(var_1);

  while (isdefined(var_4)) {
    if(isdefined(var_4.vehicles_anims))
      prepare_vehicle_play_anim_from_node();

    node_wait(var_4, var_3, var_5);

    if(!isdefined(self)) {
      return;
    }
    if(isdefined(var_4.optimized_process_trigger))
      level thread trigger_process_optimized(var_4, self);

    self.currentnode = var_4;

    if(isdefined(var_4.vehicles_anims)) {
      vehicle_play_anim_from_node(var_4);
      break;
    }

    if(isdefined(var_4.gateopen) && !var_4.gateopen)
      thread path_gate_wait_till_open(var_4);

    if(isdefined(var_4.script_volumedown))
      thread maps\_vehicle::volume_down(var_4.script_volumedown);

    if(isdefined(var_4.script_volumeup))
      thread maps\_vehicle::volume_up(var_4.script_volumeup);

    if(isdefined(var_4.script_noteworthy)) {
      self notify(var_4.script_noteworthy);
      self notify("noteworthy", var_4.script_noteworthy);
    }

    waittillframeend;

    if(!isdefined(self)) {
      return;
    }
    if(isdefined(var_4.script_prefab_exploder)) {
      var_4.script_exploder = var_4.script_prefab_exploder;
      var_4.script_prefab_exploder = undefined;
    }

    if(isdefined(var_4.script_exploder)) {
      var_6 = var_4.script_exploder_delay;

      if(isdefined(var_6))
        level maps\_utility::delaythread(var_6, common_scripts\_exploder::exploder, var_4.script_exploder);
      else
        level common_scripts\_exploder::exploder(var_4.script_exploder);
    }

    if(isdefined(var_4.script_flag_set)) {
      if(isdefined(self.vehicle_flags))
        self.vehicle_flags[var_4.script_flag_set] = 1;

      self notify("vehicle_flag_arrived", var_4.script_flag_set);
      common_scripts\utility::flag_set(var_4.script_flag_set);
    }

    if(isdefined(var_4.script_ent_flag_set))
      maps\_utility::ent_flag_set(var_4.script_ent_flag_set);

    if(isdefined(var_4.script_ent_flag_clear))
      maps\_utility::ent_flag_clear(var_4.script_ent_flag_clear);

    if(isdefined(var_4.script_flag_clear))
      common_scripts\utility::flag_clear(var_4.script_flag_clear);

    if(isdefined(var_4.script_noteworthy)) {
      if(var_4.script_noteworthy == "kill" || var_4.script_noteworthy == "forcekill")
        _force_kill();

      if(var_4.script_noteworthy == "godon")
        self.godmode = 1;

      if(var_4.script_noteworthy == "godoff")
        self.godmode = 0;

      if(var_4.script_noteworthy == "deleteme") {
        level thread maps\_utility::deleteent(self);
        return;
      }

      if(var_4.script_noteworthy == "engineoff")
        self vehicle_turnengineoff();
    }

    if(isdefined(var_4.script_crashtypeoverride))
      self.script_crashtypeoverride = var_4.script_crashtypeoverride;

    if(isdefined(var_4.script_badplace))
      self.script_badplace = var_4.script_badplace;

    if(isdefined(var_4.script_turretmg)) {
      if(var_4.script_turretmg)
        _mgon();
      else
        _mgoff();
    }

    if(isdefined(var_4.script_team))
      self.script_team = var_4.script_team;

    if(isdefined(var_4.script_turningdir))
      self notify("turning", var_4.script_turningdir);

    if(isdefined(var_4.script_deathroll)) {
      if(var_4.script_deathroll == 0)
        thread deathrolloff();
      else
        thread deathrollon();
    }

    if(isdefined(var_4.script_vehicleaianim)) {
      if(isdefined(var_4.script_parameters) && var_4.script_parameters == "queue")
        self.queueanim = 1;

      if(isdefined(var_4.script_startingposition))
        self.groupedanim_pos = var_4.script_startingposition;

      thread maps\_vehicle::vehicle_ai_event(var_4.script_vehicleaianim);
    }

    if(isdefined(var_4.script_wheeldirection))
      wheeldirectionchange(var_4.script_wheeldirection);

    if(vehicle_should_unload(::node_wait, var_4))
      thread unload_node(var_4);

    if(isdefined(var_4.script_transmission)) {
      self.veh_transmission = var_4.script_transmission;

      if(self.veh_transmission == "forward")
        wheeldirectionchange(1);
      else
        wheeldirectionchange(0);
    }

    if(isdefined(var_4.script_brake))
      self.veh_brake = var_4.script_brake;

    if(isdefined(var_4.script_pathtype))
      self.veh_pathtype = var_4.script_pathtype;

    if(isdefined(var_4.script_ent_flag_wait)) {
      var_7 = 35;

      if(isdefined(var_4.script_decel))
        var_7 = var_4.script_decel;

      self vehicle_setspeed(0, var_7);
      maps\_utility::ent_flag_wait(var_4.script_ent_flag_wait);

      if(!isdefined(self)) {
        return;
      }
      var_8 = 60;

      if(isdefined(var_4.script_accel))
        var_8 = var_4.script_accel;

      self resumespeed(var_8);
    }

    if(isdefined(var_4.script_delay)) {
      var_7 = 35;

      if(isdefined(var_4.script_decel))
        var_7 = var_4.script_decel;

      self vehicle_setspeed(0, var_7);

      if(isdefined(var_4.target))
        thread overshoot_next_node([
          [var_5]
        ](var_4.target));

      var_4 maps\_utility::script_delay();
      self notify("delay_passed");
      var_8 = 60;

      if(isdefined(var_4.script_accel))
        var_8 = var_4.script_accel;

      self resumespeed(var_8);
    }

    if(isdefined(var_4.script_flag_wait)) {
      if(!isdefined(self.vehicle_flags))
        self.vehicle_flags = [];

      self.vehicle_flags[var_4.script_flag_wait] = 1;
      self notify("vehicle_flag_arrived", var_4.script_flag_wait);

      if(!common_scripts\utility::flag(var_4.script_flag_wait))
        self vehicle_setspeed(0, 35);

      common_scripts\utility::flag_wait(var_4.script_flag_wait);
      self resumespeed(10);
    }

    if(isdefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isdefined(var_4.script_vehicle_lights_off))
      thread lights_off(var_4.script_vehicle_lights_off);

    if(isdefined(var_4.script_vehicle_lights_on))
      thread lights_on(var_4.script_vehicle_lights_on);

    if(isdefined(var_4.script_forcecolor))
      thread vehicle_script_forcecolor_riders(var_4.script_forcecolor);

    var_3 = var_4;

    if(!isdefined(var_4.target)) {
      break;
    }

    var_4 = [
      [var_5]
    ](var_4.target);

    if(!isdefined(var_4)) {
      var_4 = var_3;
      break;
    } else if(islastnode(var_4) || isdefined(var_4.script_unload)) {
      var_9 = max(0.01, length(self vehicle_getvelocity()));
      var_10 = distance(self.origin, var_4.origin);
      var_11 = max(0.01, var_10 / var_9);
      self notify("about_to_stop", var_11);
    }
  }

  if(isdefined(var_4.script_land))
    thread _vehicle_landvehicle();

  self notify("reached_dynamic_path_end");

  if(isdefined(self.script_vehicle_selfremove)) {
    self notify("delete");
    self delete();
  }
}

vehicle_paths_helicopter(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isdefined(var_1))
    var_1 = 0;

  if(isdefined(var_0))
    self.attachedpath = var_0;

  var_3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isdefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1)
    self waittill("start_dynamicpath");

  if(isdefined(var_2)) {
    var_5 = spawnstruct();
    var_5.origin = maps\_utility::add_z(self.origin, var_2);
    heli_wait_node(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = get_path_getfunc(var_3);

  while (isdefined(var_7)) {
    if(isdefined(var_7.script_linkto))
      set_lookat_from_dest(var_7);

    heli_wait_node(var_7, var_6);

    if(!isdefined(self)) {
      return;
    }
    self.currentnode = var_7;

    if(isdefined(var_7.gateopen) && !var_7.gateopen)
      thread path_gate_wait_till_open(var_7);

    var_7 notify("trigger", self);

    if(isdefined(var_7.script_volumedown))
      thread maps\_vehicle::volume_down(var_7.script_volumedown);

    if(isdefined(var_7.script_volumeup))
      thread maps\_vehicle::volume_up(var_7.script_volumeup);

    if(isdefined(var_7.script_helimove)) {
      self setyawspeedbyname(var_7.script_helimove);

      if(var_7.script_helimove == "faster")
        self setmaxpitchroll(25, 50);
    }

    if(isdefined(var_7.script_noteworthy)) {
      self notify(var_7.script_noteworthy);
      self notify("noteworthy", var_7.script_noteworthy);
    }

    waittillframeend;

    if(!isdefined(self)) {
      return;
    }
    if(isdefined(var_7.script_prefab_exploder)) {
      var_7.script_exploder = var_7.script_prefab_exploder;
      var_7.script_prefab_exploder = undefined;
    }

    if(isdefined(var_7.script_exploder)) {
      var_9 = var_7.script_exploder_delay;

      if(isdefined(var_9))
        level maps\_utility::delaythread(var_9, common_scripts\_exploder::exploder, var_7.script_exploder);
      else
        level common_scripts\_exploder::exploder(var_7.script_exploder);
    }

    if(isdefined(var_7.script_flag_set)) {
      if(isdefined(self.vehicle_flags))
        self.vehicle_flags[var_7.script_flag_set] = 1;

      self notify("vehicle_flag_arrived", var_7.script_flag_set);
      common_scripts\utility::flag_set(var_7.script_flag_set);
    }

    if(isdefined(var_7.script_ent_flag_set))
      maps\_utility::ent_flag_set(var_7.script_ent_flag_set);

    if(isdefined(var_7.script_ent_flag_clear))
      maps\_utility::ent_flag_clear(var_7.script_ent_flag_clear);

    if(isdefined(var_7.script_flag_clear))
      common_scripts\utility::flag_clear(var_7.script_flag_clear);

    if(isdefined(var_7.script_noteworthy)) {
      if(var_7.script_noteworthy == "kill" || var_7.script_noteworthy == "forcekill")
        _force_kill();

      if(var_7.script_noteworthy == "godon")
        self.godmode = 1;

      if(var_7.script_noteworthy == "godoff")
        self.godmode = 0;

      if(var_7.script_noteworthy == "deleteme") {
        level thread maps\_utility::deleteent(self);
        return;
      }

      if(var_7.script_noteworthy == "engineoff")
        self vehicle_turnengineoff();
    }

    if(isdefined(var_7.script_crashtypeoverride))
      self.script_crashtypeoverride = var_7.script_crashtypeoverride;

    if(isdefined(var_7.script_badplace))
      self.script_badplace = var_7.script_badplace;

    if(isdefined(var_7.script_turretmg)) {
      if(var_7.script_turretmg)
        _mgon();
      else
        _mgoff();
    }

    if(isdefined(var_7.script_team))
      self.script_team = var_7.script_team;

    if(isdefined(var_7.script_turningdir))
      self notify("turning", var_7.script_turningdir);

    if(isdefined(var_7.script_deathroll)) {
      if(var_7.script_deathroll == 0)
        thread deathrolloff();
      else
        thread deathrollon();
    }

    if(isdefined(var_7.script_vehicleaianim)) {
      if(isdefined(var_7.script_parameters) && var_7.script_parameters == "queue")
        self.queueanim = 1;

      if(isdefined(var_7.script_startingposition))
        self.groupedanim_pos = var_7.script_startingposition;

      thread maps\_vehicle::vehicle_ai_event(var_7.script_vehicleaianim);
    }

    if(isdefined(var_7.script_wheeldirection))
      wheeldirectionchange(var_7.script_wheeldirection);

    if(vehicle_should_unload(::heli_wait_node, var_7))
      thread unload_node(var_7);

    if(self vehicle_isphysveh()) {
      if(isdefined(var_7.script_transmission)) {
        self.veh_transmission = var_7.script_transmission;

        if(self.veh_transmission == "forward")
          wheeldirectionchange(1);
        else
          wheeldirectionchange(0);
      }

      if(isdefined(var_7.script_pathtype))
        self.veh_pathtype = var_7.script_pathtype;
    }

    if(isdefined(var_7.script_flag_wait)) {
      if(!isdefined(self.vehicle_flags))
        self.vehicle_flags = [];

      self.vehicle_flags[var_7.script_flag_wait] = 1;
      self notify("vehicle_flag_arrived", var_7.script_flag_wait);
      common_scripts\utility::flag_wait(var_7.script_flag_wait);

      if(isdefined(var_7.script_delay_post))
        wait(var_7.script_delay_post);

      self notify("delay_passed");
    }

    if(isdefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isdefined(var_7.script_vehicle_lights_off))
      thread lights_off(var_7.script_vehicle_lights_off);

    if(isdefined(var_7.script_vehicle_lights_on))
      thread lights_on(var_7.script_vehicle_lights_on);

    if(isdefined(var_7.script_forcecolor))
      thread vehicle_script_forcecolor_riders(var_7.script_forcecolor);

    var_6 = var_7;

    if(!isdefined(var_7.target)) {
      break;
    }

    var_7 = [
      [var_8]
    ](var_7.target);

    if(!isdefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  if(isdefined(var_7.script_land))
    thread _vehicle_landvehicle();

  self notify("reached_dynamic_path_end");

  if(isdefined(self.script_vehicle_selfremove))
    self delete();
}

vehicle_should_unload(var_0, var_1) {
  if(isdefined(var_1.script_unload))
    return 1;

  if(var_0 != ::node_wait)
    return 0;

  if(!islastnode(var_1))
    return 0;

  if(isdefined(self.dontunloadonend))
    return 0;

  if(self.vehicletype == "empty")
    return 0;

  return !is_script_vehicle_selfremove();
}

overshoot_next_node(var_0) {}

is_script_vehicle_selfremove() {
  if(!isdefined(self.script_vehicle_selfremove))
    return 0;

  return self.script_vehicle_selfremove;
}

must_stop_at_next_point(var_0) {
  if(isdefined(var_0.script_unload))
    return 1;

  return isdefined(var_0.script_flag_wait) && !common_scripts\utility::flag(var_0.script_flag_wait);
}

heli_wait_node(var_0, var_1) {
  self endon("newpath");

  if(isdefined(var_0.script_unload) && isdefined(self.fastropeoffset)) {
    var_0.radius = 2;
    var_2 = maps\_utility::groundpos(var_0.origin) + (0, 0, self.fastropeoffset);

    if(var_2[2] > var_0.origin[2] - 2000)
      var_0.origin = maps\_utility::groundpos(var_0.origin) + (0, 0, self.fastropeoffset);

    self sethoverparams(0, 0, 0);
  }

  if(isdefined(var_1)) {
    if(isdefined(var_1.speed)) {
      var_3 = var_1.speed;
      var_4 = 25;
      var_5 = undefined;

      if(isdefined(var_1.script_decel))
        var_5 = var_1.script_decel;
      else if(must_stop_at_next_point(var_0)) {

      }

      if(isdefined(var_1.script_accel))
        var_4 = var_1.script_accel;
      else {
        var_6 = var_3 / 4;

        if(var_4 > var_6)
          var_4 = var_6;
      }

      if(isdefined(var_5))
        self vehicle_setspeed(var_3, var_4, var_5);
      else
        self vehicle_setspeed(var_3, var_4);
    } else if(must_stop_at_next_point(var_0)) {

    }
  }

  setvehgoalnode(var_0);

  if(isdefined(var_0.radius)) {
    self setneargoalnotifydist(var_0.radius);
    common_scripts\utility::waittill_any("near_goal", "goal");
  } else
    self waittill("goal");

  if(isdefined(var_0.script_stopnode)) {
    if(var_0.script_stopnode)
      self notify("reached_stop_node");

    if(isdefined(var_0.script_delay))
      wait(var_0.script_delay);
  }
}

helipath(var_0, var_1, var_2) {
  self setairresistance(30);
  self vehicle_setspeed(var_1, var_2, 10);
  maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct(var_0, "targetname"));
}

setvehgoalnode(var_0) {
  self endon("death");
  var_1 = 0;

  if(!isdefined(var_1))
    var_1 = 1;

  if(isdefined(var_0.script_stopnode))
    var_1 = var_0.script_stopnode;

  if(isdefined(var_0.script_unload))
    var_1 = 1;

  var_2 = isdefined(var_0.script_anglevehicle) && var_0.script_anglevehicle;
  var_3 = isdefined(var_0.script_goalyaw) && var_0.script_goalyaw;

  if(isdefined(var_0.script_anglevehicle) || isdefined(var_0.script_goalyaw))
    forcetarget(var_0, var_3, var_2);
  else
    unforcetarget();

  if(isdefined(var_0.script_flag_wait)) {
    if(!common_scripts\utility::flag(var_0.script_flag_wait))
      var_1 = 1;
  }

  if(!isdefined(var_0.target))
    var_1 = 1;

  setvehgoalpos_wrap(var_0.origin, var_1);
}

forcetarget(var_0, var_1, var_2) {
  if(var_1) {
    self cleartargetyaw();
    self setgoalyaw(var_0.angles[1]);
  } else {
    self cleargoalyaw();
    self settargetyaw(var_0.angles[1]);
  }
}

unforcetarget() {
  self cleargoalyaw();
  self cleartargetyaw();
}

path_gate_open(var_0) {
  var_0.gateopen = 1;
  var_0 notify("gate opened");
}

path_gate_wait_till_open(var_0) {
  self endon("death");
  self.waitingforgate = 1;
  _vehicle_stop_named("path_gate_wait_till_open", 15, 15);
  var_0 waittill("gate opened");
  self.waitingforgate = 0;

  if(self.health > 0) {
    self endon("death");

    if(isdefined(self.waitingforgate) && self.waitingforgate) {
      return;
    }
    _vehicle_resume_named("path_gate_wait_till_open");
  }
}

remove_vehicle_spawned_thisframe() {
  wait 0.05;
  self.vehicle_spawned_thisframe = undefined;
}

vehicle_init(var_0) {
  var_1 = var_0.classname;

  if(isdefined(level.vehicle_hide_list[var_1])) {
    foreach(var_3 in level.vehicle_hide_list[var_1])
    var_0 hidepart(var_3);
  }

  if(var_0.vehicletype == "empty") {
    var_0 thread getonpath();
    return;
  }

  var_0 maps\_utility::set_ai_number();

  if(!isdefined(var_0.modeldummyon))
    var_0.modeldummyon = 0;

  var_5 = var_0.vehicletype;
  var_0 vehicle_life();
  var_0 vehicle_setteam();

  if(!isdefined(level.vehicleinitthread[var_0.vehicletype][var_0.classname])) {
    return;
  }
  var_0 thread[[level.vehicleinitthread[var_0.vehicletype][var_0.classname]]]();
  var_0 thread maingun_fx();
  var_0 thread playtankexhaust();

  if(!isdefined(var_0.script_avoidplayer))
    var_0.script_avoidplayer = 0;

  if(isdefined(level.vehicle_draw_thermal)) {
    if(level.vehicle_draw_thermal)
      var_0 thermaldrawenable();
  }

  var_0 maps\_utility::ent_flag_init("unloaded");
  var_0 maps\_utility::ent_flag_init("loaded");
  var_0.riders = [];
  var_0.unloadque = [];
  var_0.unload_group = "default";
  var_0.fastroperig = [];

  if(isdefined(level.vehicle_attachedmodels) && isdefined(level.vehicle_attachedmodels[var_1])) {
    var_6 = level.vehicle_attachedmodels[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0.fastroperig[var_9] = undefined;
      var_0.fastroperiganimating[var_9] = 0;
    }
  }

  var_0 thread vehicle_badplace();

  if(isdefined(var_0.script_vehicle_lights_on))
    var_0 thread lights_on(var_0.script_vehicle_lights_on);

  if(isdefined(var_0.script_godmode))
    var_0.godmode = 1;

  var_0.damage_functions = [];

  if(!var_0 ischeap() || var_0 ischeapshieldenabled())
    var_0 thread friendlyfire_shield();

  var_0 thread maps\_vehicle_aianim::handle_attached_guys();

  if(isdefined(var_0.script_friendname))
    var_0 setvehiclelookattext(var_0.script_friendname, & "");

  if(!var_0 ischeap())
    var_0 thread vehicle_handleunloadevent();

  if(isdefined(var_0.script_dontunloadonend))
    var_0.dontunloadonend = 1;

  if(!var_0 ischeap())
    var_0 thread vehicle_shoot_shock();

  var_0 thread vehicle_rumble();

  if(isdefined(var_0.script_physicsjolt) && var_0.script_physicsjolt)
    var_0 thread maps\_utility::physicsjolt_proximity();

  var_0 thread vehicle_treads();
  var_0 thread idle_animations();
  var_0 thread animate_drive_idle();

  if(isdefined(var_0.script_deathflag))
    var_0 thread maps\_spawner::vehicle_deathflag();

  if(!var_0 ischeap())
    var_0 thread mginit();

  if(isdefined(level.vehiclespawncallbackthread))
    level thread[[level.vehiclespawncallbackthread]](var_0);

  vehicle_levelstuff(var_0);

  if(isdefined(var_0.script_team))
    var_0 setvehicleteam(var_0.script_team);

  if(!var_0 ischeap())
    var_0 thread disconnect_paths_whenstopped();

  var_0 thread getonpath();

  if(isdefined(level.ignorewash))
    var_11 = level.ignorewash;
  else
    var_11 = 0;

  if(var_0 hashelicopterdustkickup() && !var_11)
    var_0 thread aircraft_wash_thread();

  if(var_0 vehicle_isphysveh()) {
    if(isdefined(var_0.script_pathtype))
      var_0.veh_pathtype = var_0.script_pathtype;
  }

  var_0 spawn_group();
  var_0 thread vehicle_kill();
  var_0 apply_truckjunk();
}

ischeapshieldenabled() {
  return isdefined(level.cheap_vehicles_have_shields) && level.cheap_vehicles_have_shields;
}

kill_damage(var_0) {
  if(!isdefined(level.vehicle_death_radiusdamage) || !isdefined(level.vehicle_death_radiusdamage[var_0])) {
    return;
  }
  if(isdefined(self.deathdamage_max))
    var_1 = self.deathdamage_max;
  else
    var_1 = level.vehicle_death_radiusdamage[var_0].maxdamage;

  if(isdefined(self.deathdamage_min))
    var_2 = self.deathdamage_min;
  else
    var_2 = level.vehicle_death_radiusdamage[var_0].mindamage;

  if(isdefined(level.vehicle_death_radiusdamage[var_0].delay))
    wait(level.vehicle_death_radiusdamage[var_0].delay);

  if(!isdefined(self)) {
    return;
  }
  if(level.vehicle_death_radiusdamage[var_0].bkillplayer)
    level.player enablehealthshield(0);

  self radiusdamage(self.origin + level.vehicle_death_radiusdamage[var_0].offset, level.vehicle_death_radiusdamage[var_0].range, var_1, var_2, self);

  if(level.vehicle_death_radiusdamage[var_0].bkillplayer)
    level.player enablehealthshield(1);
}

vehicle_kill_common(var_0, var_1) {
  var_2 = self.vehicletype;
  var_3 = self.classname;
  var_4 = self.model;
  var_5 = self.targetname;
  thread kill_damage(var_3);
  thread kill_badplace(var_3);
  thread kill_lights(var_3);
  maps\_vehicle_aianim::delete_corpses_around_vehicle();
  var_6 = get_deathanim_info(var_3);

  if(isdefined(var_6) && isdefined(var_6.need_dummy) && var_6.need_dummy) {
    var_7 = "body_animate_jnt";
    maps\_vehicle::vehicle_to_dummy(var_7, 0);
  }

  if(isdefined(level.vehicle_deathmodel[var_3]))
    thread set_death_model(level.vehicle_deathmodel[var_3], level.vehicle_deathmodel_delay[var_3]);
  else if(isdefined(level.vehicle_deathmodel[var_4]))
    thread set_death_model(level.vehicle_deathmodel[var_4], level.vehicle_deathmodel_delay[var_4]);

  var_8 = vehicle_should_do_rocket_death(var_4, var_0, var_1);
  thread kill_deathanim_thread(var_3, var_0);
  thread _kill_fx(var_4, var_8);

  if(self.code_classname == "script_vehicle")
    thread kill_jolt(var_3);

  return var_8;
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

  for (;;) {
    if(isdefined(self))
      self waittill("death", var_4, var_5, var_6);

    if(isdefined(self.custom_death_script))
      self thread[[self.custom_death_script]]();

    if(!var_7) {
      var_7 = 1;

      if(isdefined(var_4) && isdefined(var_5)) {
        var_4 maps\_player_stats::register_kill(self, var_5, var_6);

        if(isdefined(self.damage_type))
          self.damage_type = undefined;
      }

      if(maps\_utility::is_specialop() && !maps\_utility::is_survival() && isdefined(var_4) && isplayer(var_4)) {
        if(var_4.team != self.script_team)
          var_4 thread maps\_utility::givexp("kill", 500);

        if(isdefined(self.riders)) {
          foreach(var_9 in self.riders) {
            if(isalive(var_9) && isai(var_9))
              var_4 thread maps\_utility::givexp("kill");
          }
        }
      }
    }

    self notify("clear_c4");

    if(isdefined(self.rumbletrigger))
      self.rumbletrigger delete();

    if(isdefined(self.mgturret)) {
      common_scripts\utility::array_levelthread(self.mgturret, ::turret_deleteme);
      self.mgturret = undefined;
    }

    if(isdefined(self.script_team))
      level.vehicles[self.script_team] = common_scripts\utility::array_remove(level.vehicles[self.script_team], self);

    if(isdefined(self.script_linkname))
      level.vehicle_link[self.script_linkname] = common_scripts\utility::array_remove(level.vehicle_link[self.script_linkname], self);

    if(isdefined(self.script_vehiclestartmove))
      level.vehicle_startmovegroup[self.script_vehiclestartmove] = common_scripts\utility::array_remove(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);

    if(isdefined(self.script_vehiclegroupdelete))
      level.vehicle_deletegroup[self.script_vehiclegroupdelete] = common_scripts\utility::array_remove(level.vehicle_deletegroup[self.script_vehiclegroupdelete], self);

    if(isdefined(self.modeldummy))
      self.modeldummy thread lights_off("all", var_1);

    if(!isdefined(self) || is_corpse()) {
      if(isdefined(self.riders)) {
        foreach(var_9 in self.riders) {
          if(isdefined(var_9))
            var_9 delete();
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

    if(isdefined(self.vehicle_rumble_unique))
      var_13 = self.vehicle_rumble_unique;
    else if(isdefined(level.vehicle_rumble_override) && isdefined(level.vehicle_rumble_override[var_1]))
      var_13 = level.vehicle_rumble_override;
    else if(isdefined(level.vehicle_rumble[var_1]))
      var_13 = level.vehicle_rumble[var_1];

    if(isdefined(var_13))
      self stoprumble(var_13.rumble);

    if(isdefined(level.vehicle_death_thread) && isdefined(var_0) && isdefined(level.vehicle_death_thread[var_0]))
      thread[[level.vehicle_death_thread[var_0]]]();

    if(isdefined(var_0) && isdefined(maps\_vehicle_aianim::guy_vehicle_death) && isdefined(self.riders))
      common_scripts\utility::array_levelthread(self.riders, maps\_vehicle_aianim::guy_vehicle_death, var_4, var_0);

    var_14 = vehicle_kill_common(var_4, var_5);

    if(isdefined(self.delete_on_death)) {
      wait 0.05;

      if(!isdefined(self.dontdisconnectpaths) && !self vehicle_isphysveh())
        self disconnectpaths();

      _freevehicle();
      wait 0.05;
      vehicle_finish_death(var_2);
      self delete();
      continue;
    }

    if(isdefined(self.free_on_death)) {
      self notify("newpath");

      if(!isdefined(self.dontdisconnectpaths))
        self disconnectpaths();

      vehicle_kill_badplace_forever();
      _freevehicle();
      return;
    }

    vehicle_do_crash(var_2, var_4, var_5, var_14);

    if(!isdefined(self)) {
      return;
    }
    if(isdefined(level.vehicle_death_earthquake[var_1]))
      earthquake(level.vehicle_death_earthquake[var_1].scale, level.vehicle_death_earthquake[var_1].duration, self.origin, level.vehicle_death_earthquake[var_1].radius);

    wait 0.5;

    if(is_corpse()) {
      continue;
    }
    if(isdefined(self)) {
      while (isdefined(self.dontfreeme) && isdefined(self))
        wait 0.05;

      if(!isdefined(self)) {
        continue;
      }
      if(self vehicle_isphysveh()) {
        while (isdefined(self) && self.veh_speed != 0)
          wait 1;

        if(!isdefined(self)) {
          return;
        }
        self disconnectpaths();
        self notify("kill_badplace_forever");
        self kill();
        self notify("newpath");
        self vehicle_turnengineoff();
        return;
      } else
        _freevehicle();

      if(self.modeldummyon)
        self hide();
    }

    if(_vehicle_is_crashing()) {
      self delete();
      continue;
    }
  }
}

_freevehicle() {
  self notify("newpath");
  self freevehicle();
  maps\_utility::delaythread(0.05, ::extra_vehicle_cleanup);
}

extra_vehicle_cleanup() {
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
  self.dontunloadonend = undefined;
  self.dontdisconnectpaths = undefined;
  self.script_godmode = undefined;
  self.ent_flag = undefined;
  self.export = undefined;
  self.godmode = undefined;
  self.vehicletype = undefined;
  self.vehicle_stop_named = undefined;
  self.enable_rocket_death = undefined;
  self.touching_trigger_ent = undefined;
  self.default_target_vec = undefined;
  self.script_badplace = undefined;
  self.water_splash_info = undefined;
  self.treadsoundfxisalreadyplaying = undefined;
  self.oldtreadsoundfx = undefined;
}

_vehicle_is_crashing() {
  return isdefined(self.crashing) && self.crashing == 1;
}

#using_animtree("vehicles");

vehicle_finish_death(var_0) {
  if(isdefined(self.dont_finish_death) && self.dont_finish_death) {
    return;
  }
  self notify("death_finished");

  if(!isdefined(self)) {
    return;
  }
  self useanimtree(#animtree);

  if(isdefined(level.vehicle_driveidle[var_0]))
    self clearanim(level.vehicle_driveidle[var_0], 0);

  if(isdefined(level.vehicle_driveidle_r[var_0]))
    self clearanim(level.vehicle_driveidle_r[var_0], 0);
}

vehicle_should_do_rocket_death(var_0, var_1, var_2) {
  if(!isdefined(self.alwaysrocketdeath) || self.alwaysrocketdeath == 0) {
    if(isdefined(self.enablerocketdeath) && self.enablerocketdeath == 0)
      return 0;

    if(!isdefined(var_2))
      return 0;

    if(!(var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH"))
      return 0;
  }

  if(isdefined(self.is_anim_based_death) && self.is_anim_based_death)
    return 1;

  return vehicle_has_rocket_death(var_0);
}

vehicle_has_rocket_death(var_0) {
  return isdefined(level.vehicle_death_fx["rocket_death" + self.classname]) && isdefined(self.enablerocketdeath) && self.enablerocketdeath == 1;
}

vehicle_do_crash(var_0, var_1, var_2, var_3) {
  var_4 = "tank";

  if(isdefined(self.script_crashtypeoverride))
    var_4 = self.script_crashtypeoverride;
  else if(self vehicle_isphysveh())
    var_4 = "physics";
  else if(_ishelicopter())
    var_4 = "helicopter";
  else if(isdefined(self.currentnode) && crash_path_check(self.currentnode))
    var_4 = "none";

  switch (var_4) {
    case "helicopter":
      vehicle_do_crash_helicopter(var_1, var_2, var_3);
      break;
    case "tank":
      vehicle_do_crash_tank();
      break;
    case "diveboat":
      vehicle_do_crash_diveboat();
      break;
    case "physics":
      vehicle_do_crash_physics();
      break;
  }

  if(isdefined(level.vehicle_hasmainturret[var_0]) && level.vehicle_hasmainturret[var_0])
    self clearturrettarget();

  if(_ishelicopter()) {
    if(isdefined(self.crashing) && self.crashing == 1)
      self waittill("crash_done");
  } else {
    while (!is_corpse() && isdefined(self) && self vehicle_getspeed() > 0)
      wait 0.1;
  }

  self notify("stop_looping_death_fx");
  vehicle_finish_death(var_0);
}

vehicle_do_crash_hold_and_check_should_end() {
  if(maps\_utility::ent_flag_exist("kill_deathanim_active"))
    maps\_utility::ent_flag_waitopen("kill_deathanim_active");

  if(maps\_utility::ent_flag_exist("kill_deathanim_force_crash_end"))
    return maps\_utility::ent_flag("kill_deathanim_force_crash_end");

  return 0;
}

vehicle_do_crash_helicopter(var_0, var_1, var_2) {
  if(isdefined(var_0) && isplayer(var_0)) {
    self.achievement_attacker = var_0;
    thread maps\_utility::arcademode_kill(self.origin, "explosive", 1000);
  }

  self.crashing = 1;

  if(!isdefined(self)) {
    return;
  }
  detach_getoutrigs();

  if(isdefined(var_0) && var_0 == level.player && isdefined(self.rocket_destroyed_for_achievement) && level.player _hasweapon("rpg"))
    maps\_utility::giveachievement_wrapper("BIRD_ON_THE_GROUND");

  if(vehicle_do_crash_hold_and_check_should_end()) {
    self.crashing = 0;
    self notify("crash_done");
    return;
  }

  if(var_2) {
    return;
  }
  thread helicopter_crash_move(var_0, var_1);
}

vehicle_do_crash_tank() {
  if(vehicle_do_crash_hold_and_check_should_end()) {
    return;
  }
  if(!isdefined(self.rollingdeath))
    self vehicle_setspeed(0, 25);
  else {
    self vehicle_setspeed(8, 25);
    self waittill("deathrolloff");
    self vehicle_setspeed(0, 25);
  }

  self notify("deadstop");

  if(!isdefined(self.dontdisconnectpaths))
    self disconnectpaths();

  if(isdefined(self.tankgetout) && self.tankgetout > 0)
    self waittill("animsdone");
}

vehicle_do_crash_diveboat() {
  if(vehicle_do_crash_hold_and_check_should_end()) {
    return;
  }
  if(!isdefined(self.dontdisconnectpaths))
    self disconnectpaths();
}

vehicle_do_crash_physics() {
  if(vehicle_do_crash_hold_and_check_should_end()) {
    return;
  }
  self vehphys_crash();
  self notify("deadstop");

  if(!isdefined(self.dontdisconnectpaths))
    self disconnectpaths();

  if(isdefined(self.tankgetout) && self.tankgetout > 0)
    self waittill("animsdone");
}

is_corpse() {
  var_0 = 0;

  if(isdefined(self) && self.classname == "script_vehicle_corpse")
    var_0 = 1;

  return var_0;
}

set_death_model(var_0, var_1) {
  if(isdefined(self.skipmodelswapdeath) && self.skipmodelswapdeath) {
    return;
  }
  if(isdefined(var_1) && var_1 > 0)
    wait(var_1);

  if(!isdefined(self)) {
    return;
  }
  var_2 = _get_dummy();

  if(isdefined(self.clear_anims_on_death))
    var_2 clearanim( % root, 0);

  if(isdefined(self))
    var_2 setmodel(var_0);
}

_hasweapon(var_0) {
  var_1 = self getweaponslistall();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(issubstr(var_1[var_2], var_0))
      return 1;
  }

  return 0;
}

kill_riders(var_0) {
  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    if(!isdefined(var_2.ridingvehicle) && !isdefined(var_2.drivingvehicle)) {
      continue;
    }
    if(isdefined(var_2.magic_bullet_shield))
      var_2 maps\_utility::stop_magic_bullet_shield();

    var_2 kill();
  }
}

vehicle_rider_death_detection(var_0, var_1) {
  if(isdefined(self.vehicle_position) && self.vehicle_position != 0) {
    return;
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
  self endon("enable_free_path");
  waittillframeend;
  self.riders = maps\_utility::remove_dead_from_array(self.riders);

  if(self.has_riders && self.riders.size) {
    common_scripts\utility::array_thread(self.riders, ::vehicle_rider_death_detection, self, self.riders);
    common_scripts\utility::waittill_either("veh_collision", "driver_died");
    kill_riders(self.riders);
    wait 0.25;
  } else {
    self waittill("veh_collision");
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self vehphys_crash();
}

_vehicle_landvehicle(var_0, var_1) {
  self notify("newpath");

  if(!isdefined(var_0))
    var_0 = 2;

  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  _setvehgoalpos_wrap(maps\_utility::groundpos(self.origin), 1);
  self waittill("goal");
}

lights_on(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  common_scripts\utility::array_levelthread(var_2, ::lights_on_internal, var_1);
}

group_light(var_0, var_1, var_2) {
  if(!isdefined(level.vehicle_lights_group))
    level.vehicle_lights_group = [];

  if(!isdefined(level.vehicle_lights_group[var_0]))
    level.vehicle_lights_group[var_0] = [];

  if(!isdefined(level.vehicle_lights_group[var_0][var_2]))
    level.vehicle_lights_group[var_0][var_2] = [];

  foreach(var_4 in level.vehicle_lights_group[var_0][var_2]) {
    if(var_1 == var_4)
      return;
  }

  level.vehicle_lights_group[var_0][var_2][level.vehicle_lights_group[var_0][var_2].size] = var_1;
}

lights_delayfxforframe() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");

  if(!isdefined(level.fxdelay))
    level.fxdelay = 0;

  level.fxdelay = level.fxdelay + randomfloatrange(0.2, 0.4);

  if(level.fxdelay > 2)
    level.fxdelay = 0;

  wait 0.05;
  level.fxdelay = undefined;
}

kill_lights(var_0) {
  lights_off_internal("all", var_0);
}

vehicle_aim_turret_at_angle(var_0) {
  self endon("death");
  var_1 = anglestoforward(self.angles + (0, var_0, 0));
  var_1 = var_1 * 10000;
  var_1 = var_1 + (0, 0, 70);
  self setturrettargetvec(var_1);
}

vehicle_landvehicle(var_0, var_1) {
  return _vehicle_landvehicle(var_0, var_1);
}

_mount_snowmobile(var_0, var_1) {
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

  var_9 = common_scripts\utility::drop_to_ground(var_9);
  self.goalradius = 8;
  self.disablearrivals = 1;
  self setgoalpos(var_9);
  self waittill("goal");
  var_0 maps\_anim::anim_generic(self, var_8, var_5);
  var_0 thread maps\_vehicle_aianim::guy_enter(self);
  self.disablearrivals = 0;
}

waittill_stable(var_0) {
  var_1 = 12;
  var_2 = 400;
  var_3 = gettime() + var_2;

  if(isdefined(self.dropoff_height)) {
    var_4 = maps\_utility::groundpos(var_0.origin) + (0, 0, self.dropoff_height);
    self settargetyaw(var_0.angles[1]);
    self setvehgoalpos(var_4, 1);
    self waittill("goal");
  }

  while (isdefined(self)) {
    if(abs(self.angles[0]) > var_1 || abs(self.angles[2]) > var_1)
      var_3 = gettime() + var_2;

    if(gettime() > var_3) {
      break;
    }

    wait 0.05;
  }
}

_vehicle_badplace() {
  if(!isdefined(self.script_badplace)) {
    return;
  }
  self endon("kill_badplace_forever");

  if(!self vehicle_isphysveh())
    self endon("death");

  self endon("delete");

  if(isdefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }

  if(isdefined(self.custombadplacethread)) {
    self thread[[self.custombadplacethread]]();
    return;
  }

  var_0 = isdefined(level.vehicle_hasmainturret[self.model]) && level.vehicle_hasmainturret[self.model];
  var_1 = 0.5;
  var_2 = 17;
  var_3 = 17;

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    if(!isdefined(self.script_badplace) || !self.script_badplace) {
      while (isdefined(self) && (!isdefined(self.script_badplace) || !self.script_badplace))
        wait 0.5;

      if(!isdefined(self))
        return;
    }

    var_4 = self vehicle_getspeed();

    if(var_4 <= 0) {
      wait(var_1);
      continue;
    }

    if(var_4 < 5)
      var_5 = 200;
    else if(var_4 > 5 && var_4 < 8)
      var_5 = 350;
    else
      var_5 = 500;

    if(isdefined(self.badplacemodifier))
      var_5 = var_5 * self.badplacemodifier;

    if(var_0)
      var_6 = anglestoforward(self gettagangles("tag_turret"));
    else
      var_6 = anglestoforward(self.angles);

    badplace_arc(self.unique_id + "arc", var_1, self.origin, var_5 * 1.9, 300, var_6, var_2, var_3, "axis", "team3", "allies");
    badplace_cylinder(self.unique_id + "cyl", var_1, self.origin, 200, 300, "axis", "team3", "allies");
    wait(var_1 + 0.05);
  }
}

_vehicle_unload(var_0) {
  self notify("unloading");
  var_1 = [];

  if(maps\_utility::ent_flag_exist("no_riders_until_unload")) {
    maps\_utility::ent_flag_set("no_riders_until_unload");
    var_1 = spawn_unload_group(var_0);

    foreach(var_3 in var_1)
    maps\_utility::spawn_failed(var_3);
  }

  if(isdefined(var_0))
    self.unload_group = var_0;

  foreach(var_6 in self.riders) {
    if(isalive(var_6))
      var_6 notify("unload");
  }

  var_1 = maps\_vehicle_aianim::animate_guys("unload");
  var_8 = level.vehicle_unloadgroups[self.classname];

  if(isdefined(var_8)) {
    var_1 = [];
    var_9 = maps\_vehicle_aianim::get_unload_group();

    foreach(var_12, var_11 in self.riders) {
      if(isdefined(var_11) && isdefined(var_11.vehicle_position) && isdefined(var_9[var_11.vehicle_position]))
        var_1[var_1.size] = var_11;
    }
  }

  return var_1;
}

lights_off_internal(var_0, var_1, var_2) {
  if(isdefined(var_2))
    var_1 = var_2;
  else if(!isdefined(var_1))
    var_1 = self.classname;

  if(!isdefined(var_0))
    var_0 = "all";

  if(!isdefined(self.lights)) {
    return;
  }
  if(!isdefined(level.vehicle_lights_group[var_1][var_0])) {
    return;
  }
  var_3 = level.vehicle_lights_group[var_1][var_0];
  var_4 = 0;
  var_5 = 2;

  if(isdefined(self.maxlightstopsperframe))
    var_5 = self.maxlightstopsperframe;

  foreach(var_7 in var_3) {
    var_8 = level.vehicle_lights[var_1][var_7];

    if(maps\_utility::hastag(self.model, var_8.tag))
      stopfxontag(var_8.effect, self, var_8.tag);

    var_4++;

    if(var_4 >= var_5) {
      var_4 = 0;
      wait 0.05;
    }

    if(!isdefined(self)) {
      return;
    }
    self.lights[var_7] = undefined;
  }
}

lights_on_internal(var_0, var_1) {
  level.lastlighttime = gettime();

  if(!isdefined(var_0))
    var_0 = "all";

  if(!isdefined(var_1))
    var_1 = self.classname;

  if(!isdefined(level.vehicle_lights_group)) {
    return;
  }
  if(!isdefined(level.vehicle_lights_group[var_1]) || !isdefined(level.vehicle_lights_group[var_1][var_0])) {
    return;
  }
  thread lights_delayfxforframe();

  if(!isdefined(self.lights))
    self.lights = [];

  var_2 = level.vehicle_lights_group[var_1][var_0];
  var_3 = 0;
  var_4 = [];

  foreach(var_6 in var_2) {
    if(isdefined(self.lights[var_6])) {
      continue;
    }
    var_7 = level.vehicle_lights[var_1][var_6];

    if(isdefined(var_7.delay))
      var_8 = var_7.delay;
    else
      var_8 = 0;

    for (var_8 = var_8 + level.fxdelay; isdefined(var_4["" + var_8]); var_8 = var_8 + 0.05) {

    }

    var_4["" + var_8] = 1;
    self endon("death");
    childthread common_scripts\utility::noself_delaycall_proc(::playfxontag, var_8, var_7.effect, self, var_7.tag);
    self.lights[var_6] = 1;

    if(!isdefined(self)) {
      break;
    }
  }

  level.fxdelay = 0;
}

_setvehgoalpos_wrap(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }
  if(isdefined(self.originheightoffset))
    var_0 = var_0 + (0, 0, self.originheightoffset);

  self setvehgoalpos(var_0, var_1);
}

helicopter_crash_move(var_0, var_1) {
  self endon("in_air_explosion");

  if(isdefined(self.perferred_crash_location))
    var_2 = self.perferred_crash_location;
  else {
    var_3 = get_unused_crash_locations();
    var_2 = common_scripts\utility::getclosest(self.origin, var_3);
  }

  var_2.claimed = 1;
  self notify("newpath");
  self notify("deathspin");
  var_4 = 0;
  var_5 = 0;

  if(isdefined(var_2.script_parameters) && var_2.script_parameters == "direct")
    var_5 = 1;

  if(isdefined(self.heli_crash_indirect_zoff)) {
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
    helicopter_crash_path(var_2);
  } else {
    var_7 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_4);

    if(isdefined(self.heli_crash_lead)) {
      var_7 = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
      var_7 = (var_7[0], var_7[1], var_7[2] + var_4);
    }

    self vehicle_setspeed(40, 10, 10);
    self setneargoalnotifydist(300);
    self setvehgoalpos(var_7, 1);
    thread helicopter_crash_flavor(var_7, 40);
    var_8 = "blank";

    while (var_8 != "death") {
      var_8 = common_scripts\utility::waittill_any("goal", "near_goal", "death");

      if(!isdefined(var_8) && !isdefined(self)) {
        var_2.claimed = undefined;
        self notify("crash_done");
        return;
      } else
        var_8 = "death";
    }

    self setvehgoalpos(var_2.origin, 0);
    self waittill("goal");
    helicopter_crash_path(var_2);
  }

  var_2.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("crash_done");
}

helicopter_crash_path(var_0) {
  self endon("death");

  while (isdefined(var_0.target)) {
    var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_1 = 56;

    if(isdefined(var_0.radius))
      var_1 = var_0.radius;

    self setneargoalnotifydist(var_1);
    self setvehgoalpos(var_0.origin, 0);
    common_scripts\utility::waittill_any("goal", "near_goal");
  }
}

helicopter_crash_flavor(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
  var_2 = 0;

  if(isdefined(self.preferred_crash_style)) {
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
  self notify("in_air_explosion");
  wait 0.05;
  self notify("crash_done");
}

helicopter_crash_directed(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_2 = 90 * randomintrange(-2, 3);

  for (;;) {
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

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    var_1 = randomintrange(20, 120);

    if(var_0)
      self settargetyaw(self.angles[1] + var_1);
    else
      self settargetyaw(self.angles[1] - var_1);

    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1.0);
    wait(var_2);
  }
}

helicopter_crash_rotate() {
  self endon("crash_done");
  self clearlookatent();
  self setyawspeed(400, 100, 100);

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    var_0 = randomintrange(90, 120);
    self settargetyaw(self.angles[1] + var_0);
    wait 0.5;
  }
}

get_unused_crash_locations() {
  var_0 = [];
  level.helicopter_crash_locations = common_scripts\utility::array_removeundefined(level.helicopter_crash_locations);

  foreach(var_2 in level.helicopter_crash_locations) {
    if(isdefined(var_2.claimed)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

detach_getoutrigs() {
  if(!isdefined(self.fastroperig)) {
    return;
  }
  if(!self.fastroperig.size) {
    return;
  }
  var_0 = getarraykeys(self.fastroperig);

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    self.fastroperig[var_0[var_1]] unlink();
}

_get_dummy() {
  if(isdefined(self.modeldummyon) && self.modeldummyon)
    var_0 = self.modeldummy;
  else
    var_0 = self;

  return var_0;
}

crash_path_check(var_0) {
  var_1 = var_0;
  var_2 = [];

  while (isdefined(var_1)) {
    if(isdefined(var_1.detoured) && var_1.detoured == 0) {
      var_3 = path_detour_get_detourpath(getvehiclenode(var_1.target, "targetname"));

      if(isdefined(var_3) && isdefined(var_3.script_crashtype))
        return 1;
    }

    var_2[var_2.size] = var_1;

    if(isdefined(var_1.target))
      var_1 = getvehiclenode(var_1.target, "targetname");
    else
      var_1 = undefined;

    if(isdefined(var_1) && common_scripts\utility::array_contains(var_2, var_1)) {
      break;
    }
  }

  return 0;
}

vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

kill_jolt(var_0) {
  if(isdefined(level.vehicle_death_jolt[var_0])) {
    self.dontfreeme = 1;
    wait(level.vehicle_death_jolt[var_0].delay);
  }

  if(!isdefined(self)) {
    return;
  }
  self joltbody(self.origin + (23, 33, 64), 3);
  wait 2;

  if(!isdefined(self)) {
    return;
  }
  self.dontfreeme = undefined;
}

_kill_fx(var_0, var_1) {
  if(common_scripts\utility::isdestructible() || isdefined(self.is_anim_based_death) && self.is_anim_based_death) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);

  if(isdefined(self.ignore_death_fx) && self.ignore_death_fx) {
    return;
  }
  var_2 = self.vehicletype;
  var_3 = self.classname;

  if(var_1)
    var_3 = "rocket_death" + var_3;

  var_4 = 0;

  foreach(var_6 in level.vehicle_death_fx[var_3]) {
    if((!isdefined(var_6.waitdelay) || var_6.waitdelay == 0) && var_0 == "vehicle_bm21_mobile_cover" && level.script == "hunted")
      var_6.waitdelay = int(var_4 / 2) * 0.05 + 0.05;

    thread kill_fx_thread(var_0, var_6, var_2);
    var_4++;
  }
}

kill_fx_thread(var_0, var_1, var_2) {
  if(isdefined(var_1.waitdelay)) {
    if(var_1.waitdelay >= 0)
      wait(var_1.waitdelay);
    else
      self waittill("death_finished");
  }

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(var_1.notifystring))
    self notify(var_1.notifystring);

  var_3 = _get_dummy();

  if(isdefined(var_1.selfdeletedelay))
    common_scripts\utility::delaycall(var_1.selfdeletedelay, ::delete);

  if(isdefined(var_1.effect)) {
    if(var_1.beffectlooping && !isdefined(self.delete_on_death)) {
      if(isdefined(var_1.tag)) {
        if(isdefined(var_1.stayontag) && var_1.stayontag == 1)
          thread loop_fx_on_vehicle_tag(var_1.effect, var_1.delay, var_1.tag);
        else
          thread playloopedfxontag(var_1.effect, var_1.delay, var_1.tag);
      } else {
        var_4 = var_3.origin + (0, 0, 100) - var_3.origin;
        playfx(var_1.effect, var_3.origin, var_4);
      }
    } else if(isdefined(var_1.tag)) {
      playfxontag(var_1.effect, deathfx_ent(), var_1.tag);

      if(isdefined(var_1.remove_deathfx_entity_delay))
        deathfx_ent() common_scripts\utility::delaycall(var_1.remove_deathfx_entity_delay, ::delete);
    } else {
      var_4 = var_3.origin + (0, 0, 100) - var_3.origin;
      playfx(var_1.effect, var_3.origin, var_4);
    }
  }

  if(isdefined(var_1.sound) && !isdefined(self.delete_on_death)) {
    if(var_1.bsoundlooping)
      thread death_firesound(var_1.sound);
    else
      common_scripts\utility::play_sound_in_space(var_1.sound);
  }
}

loop_fx_on_vehicle_tag(var_0, var_1, var_2) {
  self endon("stop_looping_death_fx");

  while (isdefined(self)) {
    playfxontag(var_0, deathfx_ent(), var_2);
    wait(var_1);
  }
}

death_firesound(var_0) {
  thread maps\_utility::play_loop_sound_on_tag(var_0, undefined, 0, 1);
  common_scripts\utility::waittill_any("fire_extinguish", "stop_crash_loop_sound");

  if(!isdefined(self)) {
    iprintln("^1DEBUG: Infinite looping sound for a vehicle could be happening right now...");
    return;
  }

  self notify("stop sound" + var_0);
}

deathfx_ent() {
  if(isdefined(self.death_fx_on_self) && self.death_fx_on_self)
    return self;

  if(!isdefined(self.deathfx_ent)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_1 = _get_dummy();
    var_0 setmodel(self.model);
    var_0.origin = var_1.origin;
    var_0.angles = var_1.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkto(var_1);
    self.deathfx_ent = var_0;
  } else
    self.deathfx_ent setmodel(self.model);

  return self.deathfx_ent;
}

playloopedfxontag(var_0, var_1, var_2) {
  var_3 = _get_dummy();
  var_4 = spawn("script_origin", var_3.origin);
  self endon("fire_extinguish");
  thread playloopedfxontag_originupdate(var_2, var_4);

  for (;;) {
    playfx(var_0, var_4.origin, var_4.upvec);
    wait(var_1);
  }
}

playloopedfxontag_originupdate(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1.forwardvec = anglestoforward(var_1.angles);
  var_1.upvec = anglestoup(var_1.angles);

  while (isdefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var_2 = _get_dummy();
    var_1.angles = var_2 gettagangles(var_0);
    var_1.origin = var_2 gettagorigin(var_0);
    var_1.forwardvec = anglestoforward(var_1.angles);
    var_1.upvec = anglestoup(var_1.angles);
    wait 0.05;
  }
}

kill_badplace(var_0) {
  if(!isdefined(level.vehicle_death_badplace[var_0])) {
    return;
  }
  var_1 = level.vehicle_death_badplace[var_0];

  if(isdefined(var_1.delay))
    wait(var_1.delay);

  if(!isdefined(self)) {
    return;
  }
  badplace_cylinder("vehicle_kill_badplace", var_1.duration, self.origin, var_1.radius, var_1.height, var_1.team1, var_1.team2);
}

turret_deleteme(var_0) {
  if(isdefined(self)) {
    if(isdefined(var_0.deletedelay))
      wait(var_0.deletedelay);
  }

  if(isdefined(var_0))
    var_0 delete();
}

apply_truckjunk() {
  if(!isdefined(self.truckjunk)) {
    return;
  }
  var_0 = self.truckjunk;
  self.truckjunk = [];

  foreach(var_2 in var_0) {
    if(isdefined(var_2.spawner)) {
      var_3 = common_scripts\utility::spawn_tag_origin();
      var_3.spawner = var_2.spawner;
    } else {
      var_3 = spawn("script_model", self.origin);
      var_3 setmodel(var_2.model);
    }

    var_4 = "tag_body";

    if(isdefined(var_2.script_ghettotag)) {
      var_3.script_ghettotag = var_2.script_ghettotag;
      var_3.base_origin = var_2.origin;
      var_3.base_angles = var_2.angles;
      var_4 = var_2.script_ghettotag;
    }

    if(isdefined(var_2.destroyefx))
      var_2 thread truckjunk_dyn(var_3);

    if(isdefined(var_2.script_noteworthy))
      var_3.script_noteworthy = var_2.script_noteworthy;

    if(isdefined(var_2.script_parameters))
      var_3.script_parameters = var_2.script_parameters;

    var_3 linkto(self, var_4, var_2.origin, var_2.angles);

    if(isdefined(var_2.destructible_type)) {
      var_3.destructible_type = var_2.destructible_type;
      var_3 common_scripts\_destructible::setup_destructibles(1);
    }

    self.truckjunk[self.truckjunk.size] = var_3;
  }
}

truckjunk_dyn(var_0) {
  var_0 endon("death");
  var_0 setcandamage(1);
  var_0.health = 8000;
  var_0 waittill("damage");
  var_0 hide();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 linkto(var_0);
  playfxontag(self.destroyefx, var_1, "tag_origin");
}

truckjunk() {
  var_0 = getent(self.target, "targetname");
  var_1 = ghetto_tag_create(var_0);

  if(isspawner(self))
    var_1.spawner = self;

  if(isdefined(self.targetname)) {
    var_2 = getent(self.targetname, "target");

    if(isspawner(var_2))
      var_1.spawner = var_2;
  }

  if(isdefined(self.script_noteworthy))
    var_1.script_noteworthy = self.script_noteworthy;

  if(isdefined(self.script_parameters))
    var_1.script_parameters = self.script_parameters;

  if(isdefined(self.script_fxid))
    var_1.destroyefx = common_scripts\utility::getfx(self.script_fxid);

  if(!isdefined(var_0.truckjunk))
    var_0.truckjunk = [];

  if(isdefined(self.script_startingposition))
    var_1.script_startingposition = self.script_startingposition;

  if(isdefined(self.destructible_type)) {
    maps\_utility::precache_destructible(self.destructible_type);
    var_1.destructible_type = self.destructible_type;
  }

  var_0.truckjunk[var_0.truckjunk.size] = var_1;

  if(!isdefined(self.classname)) {
    return;
  }
  if(isspawner(self)) {
    return;
  }
  self delete();
}

ghetto_tag_create(var_0) {
  var_1 = spawnstruct();
  var_2 = "tag_body";

  if(isdefined(self.script_ghettotag)) {
    var_2 = self.script_ghettotag;
    var_1.script_ghettotag = self.script_ghettotag;
  }

  var_1.origin = self.origin - var_0 gettagorigin(var_2);

  if(!isdefined(self.angles))
    var_3 = (0, 0, 0);
  else
    var_3 = self.angles;

  var_1.angles = var_3 - var_0 gettagangles(var_2);
  var_1.model = self.model;

  if(isdefined(self.script_modelname)) {
    precachemodel(self.script_modelname);
    var_1.model = self.script_modelname;
  }

  if(isdefined(var_1.targetname))
    level.struct_class_names["targetname"][var_1.targetname] = undefined;

  if(isdefined(var_1.target))
    level.struct_class_names["target"][var_1.target] = undefined;

  return var_1;
}

_getvehiclespawnerarray(var_0) {
  var_1 = getentarray("script_vehicle", "code_classname");

  if(isdefined(var_0)) {
    var_2 = [];

    foreach(var_4 in var_1) {
      if(!isdefined(var_4.targetname)) {
        continue;
      }
      if(var_4.targetname == var_0)
        var_2 = common_scripts\utility::array_add(var_2, var_4);
    }

    var_1 = var_2;
  }

  var_6 = [];

  foreach(var_4 in var_1) {
    if(isspawner(var_4))
      var_6[var_6.size] = var_4;
  }

  return var_6;
}

_getvehiclespawnerarray_by_spawngroup(var_0) {
  var_1 = _getvehiclespawnerarray();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isdefined(var_4.script_vehiclespawngroup) && var_4.script_vehiclespawngroup == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

manual_tag_linkto(var_0, var_1) {
  for (;;) {
    if(!isdefined(self)) {
      break;
    }

    if(!isdefined(var_0)) {
      break;
    }

    var_2 = var_0 gettagorigin(var_1);
    var_3 = var_0 gettagangles(var_1);
    self.origin = var_2;
    self.angles = var_3;
    wait 0.05;
  }
}

humvee_antenna_animates(var_0) {
  self useanimtree(#animtree);
  humvee_antenna_animates_until_death(var_0);

  if(!isdefined(self)) {
    return;
  }
  self clearanim(var_0["idle"], 0);
  self clearanim(var_0["rot_l"], 0);
  self clearanim(var_0["rot_r"], 0);
}

humvee_antenna_animates_until_death(var_0) {
  self endon("death");

  for (;;) {
    var_1 = self.veh_speed / 18;

    if(var_1 <= 0.0001)
      var_1 = 0.0001;

    var_2 = randomfloatrange(0.3, 0.7);
    self setanim(var_0["idle"], var_1, 0, var_2);
    var_2 = randomfloatrange(0.1, 0.8);
    self setanim(var_0["rot_l"], 1, 0, var_2);
    var_2 = randomfloatrange(0.1, 0.8);
    self setanim(var_0["rot_r"], 1, 0, var_2);
    wait 0.5;
  }
}

vehicle_script_forcecolor_riders(var_0) {
  foreach(var_2 in self.riders) {
    if(isai(var_2)) {
      var_2 maps\_utility::set_force_color(var_0);
      continue;
    }

    if(isdefined(var_2.spawner)) {
      var_2.spawner.script_forcecolor = var_0;
      continue;
    }
  }
}

update_steering(var_0) {
  if(var_0.update_time == gettime())
    return var_0.steering;

  var_0.update_time = gettime();

  if(var_0.steering_enable) {
    var_1 = clamp(0 - var_0.angles[2], 0 - var_0.steering_maxroll, var_0.steering_maxroll) / var_0.steering_maxroll;

    if(isdefined(var_0.leanasitturns) && var_0.leanasitturns) {
      var_2 = var_0 vehicle_getsteering();
      var_2 = var_2 * -1.0;
      var_1 = var_1 + var_2;

      if(var_1 != 0) {
        var_3 = 1.0 / abs(var_1);

        if(var_3 < 1)
          var_1 = var_1 * var_3;
      }
    }

    var_4 = var_1 - var_0.steering;

    if(var_4 != 0) {
      var_5 = var_0.steering_maxdelta / abs(var_4);

      if(var_5 < 1)
        var_4 = var_4 * var_5;

      var_0.steering = var_0.steering + var_4;
    }
  } else
    var_0.steering = 0;

  return var_0.steering;
}

get_from_spawnstruct(var_0) {
  return common_scripts\utility::getstruct(var_0, "targetname");
}

get_from_entity(var_0) {
  var_1 = getentarray(var_0, "targetname");

  if(isdefined(var_1) && var_1.size > 0)
    return var_1[randomint(var_1.size)];

  return undefined;
}

get_from_spawnstruct_target(var_0) {
  return common_scripts\utility::getstruct(var_0, "target");
}

get_from_entity_target(var_0) {
  return getent(var_0, "target");
}

get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "targetname");
}

set_lookat_from_dest(var_0) {
  var_1 = getent(var_0.script_linkto, "script_linkname");

  if(!isdefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

damage_hint_bullet_only() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while (isdefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isplayer(var_1)) {
      continue;
    }
    if(isdefined(self.has_semtex_on_it)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.armordamagehints) {
          if(isdefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          var_1 maps\_utility::display_hint("invulerable_bullets");
          wait 4;
          level.armordamagehints = 0;

          if(isdefined(self))
            self.displayingdamagehints = 0;

          break;
        }
    }
  }
}

damage_hints() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while (isdefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isplayer(var_1)) {
      continue;
    }
    if(isdefined(self.has_semtex_on_it)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
      case "mod_grenade_splash":
      case "mod_grenade":
        if(!level.armordamagehints) {
          if(isdefined(level.hintelement)) {
            break;
          }

          if(isdefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          maps\_utility::display_hint("armor_damage");
          wait 8;
          level.armordamagehints = 0;

          if(isdefined(self))
            self.displayingdamagehints = 0;

          break;
        }
    }
  }
}

damage_hints_cleanup() {
  self waittill("death");

  if(self.displayingdamagehints)
    level.armordamagehints = 0;
}

copy_attachments(var_0) {
  var_1 = self getattachsize();
  var_2 = [];

  for (var_3 = 0; var_3 < var_1; var_3++)
    var_2[var_3] = tolower(self getattachmodelname(var_3));

  for (var_3 = 0; var_3 < var_2.size; var_3++)
    var_0 attach(var_2[var_3], tolower(self getattachtagname(var_3)));
}

lights_off(var_0, var_1, var_2) {
  var_3 = strtok(var_0, " ", var_1);
  common_scripts\utility::array_levelthread(var_3, ::lights_off_internal, var_1, var_2);
}

aircraft_wash_thread(var_0, var_1) {
  if(!isdefined(var_1)) {
    self notify("stop_kicking_up_dust");

    if(isdefined(level._vehicle_effect_custom_param) && isdefined(level._vehicle_effect_custom_param[self.classname]) && isdefined(level._vehicle_effect_custom_param[self.classname].tags)) {
      foreach(var_3 in level._vehicle_effect_custom_param[self.classname].tags)
      thread aircraft_wash_thread(var_0, var_3);

      return;
    }
  } else {
    self notify("stop_kicking_up_dust" + var_1);
    self endon("stop_kicking_up_dust" + var_1);
  }

  self endon("death");
  self endon("death_finished");
  self endon("stop_kicking_up_dust");
  var_5 = 350;
  var_6 = 1200;

  if(isdefined(level.treadfx_maxheight))
    var_6 = level.treadfx_maxheight;

  var_7 = 100 / var_6;
  var_8 = 0.15;
  var_9 = 0.05;
  var_10 = 4500;

  if(isdefined(level.treadsfx_max_distance))
    var_10 = level.treadsfx_max_distance;

  var_11 = 1.0;
  var_12 = var_11;
  var_13 = 3;
  var_14 = var_13;
  var_15 = _isairplane();

  if(var_15)
    var_12 = 0.15;

  var_16 = undefined;
  var_17 = undefined;
  var_18 = self;

  if(isdefined(var_0))
    var_18 = var_0;

  var_19 = 30;
  self.soundisalreadyplaying = 0;
  self.oldtreadsoundfx = undefined;

  for (;;) {
    wait(var_12);

    if(isdefined(var_1)) {
      var_20 = var_18 gettagorigin(var_1);
      var_21 = var_18 gettagangles(var_1);
      var_21 = combineangles(var_21, (-90, 0, 0));
    } else {
      var_20 = var_18.origin;
      var_21 = var_18.angles;
    }

    var_22 = anglestoup(var_21) * -1;
    var_14++;

    if(var_14 > var_13) {
      var_14 = var_13;
      var_16 = bullettrace(var_20, var_20 + var_22 * var_6, 0, var_18, 0, 0, 0, 0, 0, 1, 0, 1);
    }

    var_23 = distance(var_20, level.player.origin);

    if(var_23 > var_10)
      stop_tread_audio_loop();

    if(!isdefined(var_16)) {
      stop_tread_audio_loop();
      continue;
    }

    if(var_16["fraction"] == 1) {
      continue;
    }
    var_24 = distance(var_20, var_16["position"]);
    var_25 = get_wash_info(self, var_16, var_22, var_1);
    var_26 = get_wash_fx(var_25, var_1);

    if(!isdefined(var_26)) {
      stop_tread_audio_loop();
      continue;
    }

    var_27 = get_wash_soundfx(var_25, var_1);

    if(tread_audio_should_stop_loop(var_27, self.oldtreadsoundfx))
      stop_tread_audio_loop();

    if(var_16["fraction"] < var_7) {
      if(isdefined(level._heli_landed_fx) && isdefined(level._heli_landed_fx[var_26]))
        var_26 = level._heli_landed_fx[var_26];
    }

    if(var_24 > var_6) {
      var_12 = var_11;
      continue;
    }

    if(isdefined(var_16["entity"])) {
      var_12 = var_11;
      continue;
    }

    if(!isdefined(var_16["position"])) {
      var_12 = var_11;
      continue;
    }

    var_12 = (var_24 - var_5) / (var_6 - var_5) * (var_8 - var_9) + var_9;
    var_12 = max(var_12, var_9);
    var_28 = var_16["position"];
    var_29 = var_16["normal"];
    var_24 = vectordot(var_28 - var_20, var_29);
    var_30 = var_20 + (0, 0, var_24);
    var_31 = var_28 - var_30;

    if(var_29[2] < -0.99) {
      continue;
    }
    var_32 = vectortoangles(var_29);

    if(angleclamp180(var_32[0]) > -90 + var_19)
      var_29 = anglestoforward((-90 + var_19, var_32[1], 0));

    if(length(var_31) < 1)
      var_31 = anglestoforward(var_21 + (0, 180, 0));

    if(abs(vectordot(vectornormalize(var_31), var_29)) > 0.999) {
      continue;
    }
    playfx(var_26, var_28, var_29, var_31);

    if(isdefined(var_27) && !self.soundisalreadyplaying && var_23 < var_10) {
      thread maps\_utility::play_loop_sound_on_tag(var_27, var_1, 1, 1);
      self.soundisalreadyplaying = 1;
      self.oldtreadsoundfx = var_27;
    }
  }
}

debug_draw_arrow(var_0, var_1, var_2) {}

get_wash_info(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4.surface = var_1["surfacetype"];
  var_4.bank = undefined;
  var_5 = vectordot((0, 0, -1), var_2);

  if(var_5 >= 0.97)
    var_4.bank = undefined;
  else if(var_5 >= 0.92)
    var_4.bank = "_bank";
  else
    var_4.bank = "_bank_lg";

  var_4.vehicleclass = var_0.classname;

  if(!issubstr(var_0.classname, "vehicle") && isdefined(var_0.vehicletype))
    var_4.vehicleclass = "script_vehicle_" + var_0.vehicletype;

  if(isdefined(level._vehicle_effect_custom_param) && isdefined(level._vehicle_effect_custom_param[var_4.vehicleclass]) && isdefined(level._vehicle_effect_custom_param[var_4.vehicleclass].get_surface_override_function))
    var_4.surface = var_0[[level._vehicle_effect_custom_param[var_4.vehicleclass].get_surface_override_function]](var_4.surface, var_3);

  return var_4;
}

get_wash_fx(var_0, var_1) {
  return get_wash_effect(var_0.vehicleclass, var_0.surface, var_0.bank);
}

get_wash_soundfx(var_0, var_1) {
  return get_wash_sound_effect(var_0.vehicleclass, var_0.surface, var_0.bank);
}

get_wash_effect(var_0, var_1, var_2) {
  if(isdefined(var_2)) {
    var_3 = var_1 + var_2;

    if(isdefined(level._vehicle_effect[var_0][var_3]))
      return level._vehicle_effect[var_0][var_3];
  }

  return get_vehicle_effect(var_0, var_1);
}

get_wash_sound_effect(var_0, var_1, var_2) {
  if(isdefined(var_2)) {
    var_3 = var_1 + var_2;

    if(isdefined(level._vehicle_sound_effect[var_0][var_3]))
      return level._vehicle_sound_effect[var_0][var_3];
  }

  return get_vehicle_sound_effect(var_0, var_1);
}

get_vehicle_effect(var_0, var_1) {
  if(!isdefined(level._vehicle_effect[var_0]))
    return undefined;

  if(!isdefined(level._vehicle_effect[var_0][var_1]) && var_1 != "default" && var_1 != "default_script_model")
    return get_vehicle_effect(var_0, "default");

  return level._vehicle_effect[var_0][var_1];
}

get_vehicle_sound_effect(var_0, var_1) {
  if(!isdefined(level._vehicle_sound_effect[var_0]))
    return undefined;

  if(!isdefined(level._vehicle_sound_effect[var_0][var_1]) && var_1 != "default" && var_1 != "default_script_model")
    return get_vehicle_sound_effect(var_0, "default");

  return level._vehicle_sound_effect[var_0][var_1];
}

no_treads() {
  return _ishelicopter() || _isairplane();
}

vehicle_treads() {
  var_0 = self.classname;

  if(!isdefined(level._vehicle_effect[var_0])) {
    return;
  }
  if(no_treads()) {
    return;
  }
  if(isdefined(level.tread_override_thread))
    self thread[[level.tread_override_thread]]("tag_origin", "back_left", (160, 0, 0));
  else {
    if(isdefined(level.vehicle_single_tread_list) && isdefined(level.vehicle_single_tread_list[self.vehicletype])) {
      thread do_single_tread();
      return;
    }

    thread do_multiple_treads();
  }
}

do_multiple_treads() {
  self endon("death");
  self endon("kill_treads_forever");

  for (;;) {
    var_0 = tread_wait();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    tread(_get_dummy(), var_0, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    tread(_get_dummy(), var_0, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

tread_wait() {
  var_0 = self vehicle_getspeed();

  if(!var_0)
    return -1;

  if(isdefined(self.vehicle_treadfx_min_speed) && var_0 < self.vehicle_treadfx_min_speed)
    return -1;

  var_0 = var_0 * 17.6;
  var_1 = 1 / var_0;
  var_1 = clamp(var_1 * 35, 0.1, 0.3);

  if(isdefined(self.treadfx_freq_scale))
    var_1 = var_1 * self.treadfx_freq_scale;

  wait(var_1);
  return var_1;
}

tread(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_treadfx(self, var_3);

  if(!isdefined(var_6)) {
    return;
  }
  var_7 = var_0 gettagangles(var_2);
  var_8 = anglestoforward(var_7);
  var_9 = self gettagorigin(var_2);

  if(var_4) {
    var_10 = self gettagorigin(var_5);
    var_9 = (var_9 + var_10) / 2;
  }

  playfx(var_6, var_9, anglestoup(var_7), var_8 * var_1);
}

get_treadfx(var_0, var_1) {
  var_2 = self getwheelsurface(var_1);

  if(!isdefined(var_0.vehicletype)) {
    var_3 = -1;
    return var_3;
  }

  var_4 = var_0.classname;
  return get_vehicle_effect(var_4, var_2);
}

get_treadsfx(var_0, var_1) {
  var_2 = self getwheelsurface(var_1);

  if(!isdefined(var_0.vehicletype)) {
    var_3 = -1;
    return var_3;
  }

  var_4 = var_0.classname;
  return get_vehicle_sound_effect(var_4, var_2);
}

do_single_tread() {
  self endon("death");
  self endon("kill_treads_forever");

  for (;;) {
    var_0 = tread_wait();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    var_1 = _get_dummy();
    var_1 tread(var_1, var_0, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}

_ishelicopter() {
  return isdefined(level.helicopter_list[self.vehicletype]);
}

_isairplane() {
  return isdefined(level.airplane_list[self.vehicletype]);
}

ischeap() {
  if(!isdefined(self.script_cheap))
    return 0;

  if(!self.script_cheap)
    return 0;

  return 1;
}

hashelicopterdustkickup() {
  if(!_ishelicopter() && !_isairplane())
    return 0;

  if(ischeap())
    return 0;

  return 1;
}

hashelicopterturret() {
  if(!isdefined(self.vehicletype))
    return 0;

  if(ischeap())
    return 0;

  if(self.vehicletype == "cobra")
    return 1;

  if(self.vehicletype == "cobra_player")
    return 1;

  if(self.vehicletype == "viper")
    return 1;

  return 0;
}

vehicle_kill_disconnect_paths_forever() {
  self notify("kill_disconnect_paths_forever");
}

disconnect_paths_whenstopped() {
  self endon("death");
  self endon("kill_disconnect_paths_forever");
  var_0 = 0;

  if(isdefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
    var_0 = 1;

  if(var_0) {
    self.dontdisconnectpaths = 1;
    return;
  }

  wait(randomfloat(1));

  while (isdefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isdefined(self.dontdisconnectpaths))
        self disconnectpaths();
      else {

      }

      self notify("speed_zero_path_disconnect");

      while (self vehicle_getspeed() < 1)
        wait 0.05;
    }

    self connectpaths();
    wait 1;
  }
}

mginit() {
  var_0 = self.classname;

  if(isdefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }
  if(!isdefined(level.vehicle_mgturret[var_0])) {
    return;
  }
  var_1 = 0;

  if(isdefined(self.script_mg_angle))
    var_1 = self.script_mg_angle;

  var_2 = level.vehicle_mgturret[var_0];

  if(!isdefined(var_2)) {
    return;
  }
  var_3 = isdefined(self.script_noteworthy) && self.script_noteworthy == "onemg";

  foreach(var_7, var_5 in var_2) {
    var_6 = spawnturret("misc_turret", (0, 0, 0), var_5.info);

    if(isdefined(var_5.offset_tag))
      var_6 linkto(self, var_5.tag, var_5.offset_tag, (0, -1 * var_1, 0));
    else
      var_6 linkto(self, var_5.tag, (0, 0, 0), (0, -1 * var_1, 0));

    var_6 setmodel(var_5.model);
    var_6.angles = self.angles;
    var_6.isvehicleattached = 1;
    var_6.ownervehicle = self;
    var_6.script_team = self.script_team;
    var_6 thread maps\_mgturret::burst_fire_unmanned();
    var_6 makeunusable();
    set_turret_team(var_6);
    level thread maps\_mgturret::mg42_setdifficulty(var_6, maps\_utility::getdifficulty());

    if(isdefined(self.script_fireondrones))
      var_6.script_fireondrones = self.script_fireondrones;

    if(isdefined(var_5.deletedelay))
      var_6.deletedelay = var_5.deletedelay;

    if(isdefined(var_5.maxrange))
      var_6.maxrange = var_5.maxrange;

    if(isdefined(var_5.defaultdroppitch))
      var_6 setdefaultdroppitch(var_5.defaultdroppitch);

    self.mgturret[var_7] = var_6;

    if(var_3) {
      break;
    }
  }

  foreach(var_10, var_6 in self.mgturret) {
    var_9 = level.vehicle_mgturret[var_0][var_10].defaultonmode;

    if(isdefined(var_9))
      var_6 turret_set_default_on_mode(var_9);
  }

  if(!isdefined(self.script_turretmg))
    self.script_turretmg = 1;

  if(self.script_turretmg == 0)
    thread _mgoff();
  else {
    self.script_turretmg = 1;
    thread _mgon();
  }
}

turret_set_default_on_mode(var_0) {
  self.defaultonmode = var_0;
}

set_turret_team(var_0) {
  switch (self.script_team) {
    case "allies":
    case "friendly":
      var_0 setturretteam("allies");
      break;
    case "axis":
    case "enemy":
      var_0 setturretteam("axis");
      break;
    case "team3":
      var_0 setturretteam("team3");
      break;
    default:
      break;
  }
}

animate_drive_idle() {
  self endon("suspend_drive_anims");

  if(!isdefined(self.wheeldir))
    self.wheeldir = 1;

  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;
  self useanimtree(#animtree);

  if(!isdefined(level.vehicle_driveidle[var_0])) {
    return;
  }
  if(!isdefined(level.vehicle_driveidle_r[var_0]))
    level.vehicle_driveidle_r[var_0] = level.vehicle_driveidle[var_0];

  self endon("death");
  var_3 = level.vehicle_driveidle_normal_speed[var_0];
  var_4 = 1.0;

  if(isdefined(level.vehicle_driveidle_animrate) && isdefined(level.vehicle_driveidle_animrate[var_0]))
    var_4 = level.vehicle_driveidle_animrate[var_0];

  var_5 = self.wheeldir;
  var_6 = self;
  var_7 = level.vehicle_driveidle[var_0];

  for (;;) {
    if(isdefined(level.animate_drive_idle_on_dummies))
      var_6 = _get_dummy();

    if(!var_3) {
      if(isdefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      var_6 setanim(level.vehicle_driveidle[var_0], 1, 0.2, var_4);
      return;
    }

    var_8 = self vehicle_getspeed();

    if(self.modeldummyon && isdefined(self.dummyspeed))
      var_8 = self.dummyspeed;

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

      if(var_2 >= 1 || var_2 == 0)
        var_2 = 0.01;

      var_5 = self.wheeldir;
    }

    var_10 = var_8 / var_3;

    if(var_10 != var_1) {
      var_6 setanim(var_7, 1, 0.05, var_10);
      var_1 = var_10;
    }

    if(isdefined(var_2)) {
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
  foreach(var_1 in getaiarray()) {
    if(isdefined(var_1.script_vehicleride))
      level.vehicle_rideai = array_2dadd(level.vehicle_rideai, var_1.script_vehicleride, var_1);
  }

  foreach(var_1 in getspawnerarray()) {
    if(isdefined(var_1.script_vehicleride))
      level.vehicle_ridespawners = array_2dadd(level.vehicle_ridespawners, var_1.script_vehicleride, var_1);
  }

  if(isdefined(level.spawn_pool_enabled)) {
    foreach(var_6 in level.struct) {
      if(isdefined(var_6.script_vehicleride) && isdefined(var_6.script_spawn_pool))
        level.vehicle_ridespawners = array_2dadd(level.vehicle_ridespawners, var_6.script_vehicleride, var_6);
    }
  }
}

array_2dadd(var_0, var_1, var_2) {
  if(!isdefined(var_0[var_1]))
    var_0[var_1] = [];

  var_0[var_1][var_0[var_1].size] = var_2;
  return var_0;
}

is_node_script_origin(var_0) {
  return isdefined(var_0.classname) && var_0.classname == "script_origin";
}

node_trigger_process() {
  var_0 = 0;

  if(isdefined(self.spawnflags) && self.spawnflags & 1) {
    if(isdefined(self.script_crashtype))
      level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;

    level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
  }

  if(isdefined(self.script_vehicledetour) && isdefined(self.targetname)) {
    var_1 = undefined;

    if(isdefined(get_from_entity(self.targetname)))
      var_1 = ::get_from_entity_target;

    if(isdefined(get_from_spawnstruct(self.targetname)))
      var_1 = ::get_from_spawnstruct_target;

    if(isdefined(var_1)) {
      setup_dynamic_detour(self, var_1);
      var_0 = 1;
    } else
      setup_groundnode_detour(self);

    level.vehicle_detourpaths = array_2dadd(level.vehicle_detourpaths, self.script_vehicledetour, self);

    if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2) {

    }
  }

  if(isdefined(self.script_gatetrigger)) {
    level.vehicle_gatetrigger = array_2dadd(level.vehicle_gatetrigger, self.script_gatetrigger, self);
    self.gateopen = 0;
  }

  if(isdefined(self.script_flag_set)) {
    if(!isdefined(level.flag[self.script_flag_set]))
      common_scripts\utility::flag_init(self.script_flag_set);
  }

  if(isdefined(self.script_flag_clear)) {
    if(!isdefined(level.flag[self.script_flag_clear]))
      common_scripts\utility::flag_init(self.script_flag_clear);
  }

  if(isdefined(self.script_flag_wait)) {
    if(!isdefined(level.flag[self.script_flag_wait]))
      common_scripts\utility::flag_init(self.script_flag_wait);
  }

  if(isdefined(self.script_vehiclespawngroup) || isdefined(self.script_vehiclestartmove) || isdefined(self.script_gatetrigger) || isdefined(self.script_vehiclegroupdelete))
    var_0 = 1;

  if(var_0)
    add_proccess_trigger(self);
}

setup_triggers() {
  level.vehicle_processtriggers = [];
  var_0 = [];
  var_0 = common_scripts\utility::array_combine(getallvehiclenodes(), getentarray("script_origin", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, level.struct);
  var_0 = common_scripts\utility::array_combine(var_0, getentarray("trigger_radius", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getentarray("trigger_disk", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getentarray("trigger_multiple", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getentarray("trigger_lookat", "code_classname"));
  common_scripts\utility::array_thread(var_0, ::node_trigger_process);
}

is_node_script_struct(var_0) {
  if(!isdefined(var_0.targetname))
    return 0;

  return isdefined(common_scripts\utility::getstruct(var_0.targetname, "targetname"));
}

setup_vehicles(var_0) {
  var_1 = [];
  level.failed_spawnvehicles = [];

  foreach(var_3 in var_0) {
    if(var_3 check_spawn_group_isspawner())
      continue;
    else
      var_1[var_1.size] = var_3;
  }

  check_failed_spawn_groups();

  foreach(var_6 in var_1)
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
  if(isdefined(self.script_vehiclespawngroup) && !isspawner(self)) {
    level.failed_spawnvehicles[level.failed_spawnvehicles.size] = self;
    return 1;
  }

  return isspawner(self);
}

vehicle_life() {
  var_0 = self.classname;

  if(!isdefined(level.vehicle_life) || !isdefined(level.vehicle_life[var_0]))
    wait 2;

  if(isdefined(self.script_startinghealth))
    self.health = self.script_startinghealth;
  else if(level.vehicle_life[var_0] == -1)
    return;
  else if(isdefined(level.vehicle_life_range_low[var_0]) && isdefined(level.vehicle_life_range_high[var_0]))
    self.health = randomint(level.vehicle_life_range_high[var_0] - level.vehicle_life_range_low[var_0]) + level.vehicle_life_range_low[var_0];
  else
    self.health = level.vehicle_life[var_0];

  if(isdefined(level.destructible_model[self.model])) {
    self.health = 2000;
    self.destructible_type = level.destructible_model[self.model];
    common_scripts\_destructible::setup_destructibles(1);
  }
}

setturretfireondrones(var_0) {
  if(isdefined(self.mgturret) && self.mgturret.size) {
    foreach(var_2 in self.mgturret)
    var_2.script_fireondrones = var_0;
  }
}

getnormalanimtime(var_0) {
  var_1 = self getanimtime(var_0);
  var_2 = getanimlength(var_0);

  if(var_1 == 0)
    return 0;

  return self getanimtime(var_0) / getanimlength(var_0);
}

rotor_anim() {
  var_0 = getanimlength(maps\_utility::getanim("rotors"));

  for (;;) {
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

  if(!isdefined(level.vehicle_idleanim[self.model])) {
    return;
  }
  foreach(var_1 in level.vehicle_idleanim[self.model])
  self setanim(var_1);
}

vehicle_rumble() {
  self endon("kill_rumble_forever");
  var_0 = self.classname;
  var_1 = undefined;

  if(isdefined(self.vehicle_rumble_unique))
    var_1 = self.vehicle_rumble_unique;
  else if(isdefined(level.vehicle_rumble_override) && isdefined(level.vehicle_rumble_override[var_0]))
    var_1 = level.vehicle_rumble_override;
  else if(isdefined(level.vehicle_rumble[var_0]))
    var_1 = level.vehicle_rumble[var_0];

  if(!isdefined(var_1)) {
    return;
  }
  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 enablelinkto();
  var_4 linkto(self);
  self.rumbletrigger = var_4;
  self endon("death");

  if(!isdefined(self.rumbleon))
    self.rumbleon = 1;

  if(isdefined(var_1.scale))
    self.rumble_scale = var_1.scale;
  else
    self.rumble_scale = 0.15;

  if(isdefined(var_1.duration))
    self.rumble_duration = var_1.duration;
  else
    self.rumble_duration = 4.5;

  if(isdefined(var_1.radius))
    self.rumble_radius = var_1.radius;
  else
    self.rumble_radius = 600;

  if(isdefined(var_1.basetime))
    self.rumble_basetime = var_1.basetime;
  else
    self.rumble_basetime = 1;

  if(isdefined(var_1.randomaditionaltime))
    self.rumble_randomaditionaltime = var_1.randomaditionaltime;
  else
    self.rumble_randomaditionaltime = 1;

  var_4.radius = self.rumble_radius;

  for (;;) {
    var_4 waittill("trigger");

    if(self vehicle_getspeed() == 0 || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(var_1.rumble);

    while (level.player istouching(var_4) && self.rumbleon && self vehicle_getspeed() > 0) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
    }

    self stoprumble(var_1.rumble);
  }
}

vehicle_kill_treads_forever() {
  self notify("kill_treads_forever");
}

isstationary() {
  var_0 = self.vehicletype;

  if(isdefined(level.vehicle_isstationary[var_0]) && level.vehicle_isstationary[var_0])
    return 1;
  else
    return 0;
}

vehicle_shoot_shock() {
  if(!isdefined(level.vehicle_shoot_shock[self.classname])) {
    return;
  }
  if(getdvar("disable_tank_shock_minspec") == "1") {
    return;
  }
  self endon("death");
  self endon("stop_vehicle_shoot_shock");

  for (;;) {
    self waittill("weapon_fired");

    if(isdefined(self.shock_distance))
      var_0 = self.shock_distance;
    else
      var_0 = 400;

    var_1 = distance(self.origin, level.player.origin);

    if(var_1 > var_0) {
      continue;
    }
    if(isdefined(level.player.flashendtime) && level.player.flashendtime - gettime() > 200) {
      continue;
    }
    if(isdefined(self.shellshock_audio_disabled) && self.shellshock_audio_disabled) {
      continue;
    }
    if(isdefined(self.shellshock_time))
      var_2 = self.shellshock_time;
    else {
      var_3 = var_1 / var_0;
      var_2 = 4 - 3 * var_3;
    }

    level.player shellshock(level.vehicle_shoot_shock[self.classname], var_2);
    soundscripts\_snd::snd_message("start_vehicle_shell_shock", var_2);
  }
}

vehicle_setteam() {
  var_0 = self.classname;

  if(!isdefined(self.script_team) && isdefined(level.vehicle_team[var_0]))
    self.script_team = level.vehicle_team[var_0];

  level.vehicles[self.script_team] = common_scripts\utility::array_add(level.vehicles[self.script_team], self);
}

vehicle_handleunloadevent() {
  self endon("death");
  var_0 = self.vehicletype;

  if(!maps\_utility::ent_flag_exist("unloaded"))
    maps\_utility::ent_flag_init("unloaded");

  for (;;) {
    self waittill("unload", var_1);

    if(isdefined(var_1))
      self.unload_group = var_1;

    maps\_vehicle::vehicle_unload(var_1);
  }
}

get_vehiclenode_any_dynamic(var_0) {
  var_1 = getvehiclenode(var_0, "targetname");

  if(!isdefined(var_1))
    var_1 = getent(var_0, "targetname");
  else if(_ishelicopter()) {}

  if(!isdefined(var_1)) {
    var_2 = common_scripts\utility::getstructarray(var_0, "targetname");
    var_3 = [];

    if(isdefined(var_2)) {
      foreach(var_5 in var_2) {
        if(isdefined(var_5.script_unloadtype)) {
          continue;
        }
        var_3[var_3.size] = var_5;
      }
    }

    if(var_3.size == 1)
      var_1 = var_3[0];
    else
      var_1 = undefined;
  }

  return var_1;
}

vehicle_resumepathvehicle() {
  if(!_ishelicopter()) {
    self resumespeed(35);
    return;
  }

  var_0 = undefined;

  if(isdefined(self.currentnode.target))
    var_0 = get_vehiclenode_any_dynamic(self.currentnode.target);

  if(!isdefined(var_0)) {
    return;
  }
  _vehicle_paths(var_0);
}

has_frontarmor() {
  return isdefined(level.vehicle_frontarmor[self.classname]);
}

grenadeshielded(var_0) {
  if(!isdefined(self.script_grenadeshield))
    return 0;

  var_0 = tolower(var_0);

  if(!isdefined(var_0) || !issubstr(var_0, "grenade"))
    return 0;

  if(self.script_grenadeshield)
    return 1;
  else
    return 0;
}

bulletshielded(var_0) {
  if(!isdefined(self.script_bulletshield))
    return 0;

  var_0 = tolower(var_0);

  if(!isdefined(var_0) || !issubstr(var_0, "bullet") || issubstr(var_0, "explosive"))
    return 0;

  if(self.script_bulletshield)
    return 1;
  else
    return 0;
}

explosive_bulletshielded(var_0) {
  if(!isdefined(self.script_explosive_bullet_shield))
    return 0;

  var_0 = tolower(var_0);

  if(!isdefined(var_0) || !issubstr(var_0, "explosive"))
    return 0;

  if(self.script_explosive_bullet_shield)
    return 1;
  else
    return 0;
}

vehicle_should_regenerate(var_0, var_1) {
  return !isdefined(var_0) && self.script_team != "neutral" || attacker_isonmyteam(var_0) || attacker_troop_isonmyteam(var_0) || common_scripts\utility::isdestructible() || is_invulnerable_from_ai(var_0) || bulletshielded(var_1) || explosive_bulletshielded(var_1) || grenadeshielded(var_1) || var_1 == "MOD_MELEE" || var_1 == "MOD_MELEE_ALT";
}

friendlyfire_shield() {
  self endon("death");

  if(!isdefined(level.unstoppable_friendly_fire_shield))
    self endon("stop_friendlyfire_shield");

  var_0 = self.classname;

  if(isdefined(level.vehicle_bulletshield[var_0]) && !isdefined(self.script_bulletshield))
    self.script_bulletshield = level.vehicle_bulletshield[var_0];

  if(isdefined(level.vehicle_grenadeshield[var_0]) && !isdefined(self.script_grenadeshield))
    self.script_grenadeshield = level.vehicle_grenadeshield[var_0];

  if(isdefined(self.script_mp_style_helicopter)) {
    self.script_mp_style_helicopter = 1;
    self.bullet_armor = 5000;
    self.health = 350;
  } else
    self.script_mp_style_helicopter = 0;

  self.healthbuffer = 20000;
  self.health = self.health + self.healthbuffer;
  self.currenthealth = self.health;
  var_1 = undefined;
  var_2 = undefined;

  for (var_3 = undefined; self.health > 0; var_3 = undefined) {
    self waittill("damage", var_4, var_1, var_5, var_6, var_2, var_7, var_8, var_9, var_10, var_3);

    foreach(var_12 in self.damage_functions)
    thread[[var_12]](var_4, var_1, var_5, var_6, var_2, var_7, var_8);

    if(isdefined(var_1))
      var_1 maps\_player_stats::register_shot_hit();

    if(vehicle_should_regenerate(var_1, var_2) || _is_godmode())
      self.health = self.currenthealth;
    else if(has_frontarmor()) {
      regen_front_armor(var_1, var_4);
      self.currenthealth = self.health;
    } else if(hit_bullet_armor(var_2)) {
      self.health = self.currenthealth;
      self.bullet_armor = self.bullet_armor - var_4;
    } else
      self.currenthealth = self.health;

    if(common_scripts\_destructible::getdamagetype(var_2) == "splash")
      self.rocket_destroyed_for_achievement = 1;
    else
      self.rocket_destroyed_for_achievement = undefined;

    if(self.health < self.healthbuffer && !isdefined(self.vehicle_stays_alive)) {
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
  if(!self.script_mp_style_helicopter)
    return 0;

  if(self.bullet_armor <= 0)
    return 0;

  if(!isdefined(var_0))
    return 0;

  if(!issubstr(var_0, "BULLET"))
    return 0;
  else
    return 1;
}

regen_front_armor(var_0, var_1) {
  var_2 = anglestoforward(self.angles);
  var_3 = vectornormalize(var_0.origin - self.origin);

  if(vectordot(var_2, var_3) > 0.86)
    self.health = self.health + int(var_1 * level.vehicle_frontarmor[self.classname]);
}

_is_godmode() {
  if(isdefined(self.godmode) && self.godmode)
    return 1;
  else
    return 0;
}

is_invulnerable_from_ai(var_0) {
  if(!isdefined(self.script_ai_invulnerable))
    return 0;

  if(isdefined(var_0) && isai(var_0) && self.script_ai_invulnerable == 1)
    return 1;
  else
    return 0;
}

attacker_troop_isonmyteam(var_0) {
  if(isdefined(self.script_team) && self.script_team == "allies" && isdefined(var_0) && isplayer(var_0))
    return 1;
  else if(isai(var_0) && var_0.team == self.script_team)
    return 1;
  else
    return 0;
}

attacker_isonmyteam(var_0) {
  if(isdefined(var_0) && isdefined(var_0.script_team) && isdefined(self.script_team) && var_0.script_team == self.script_team)
    return 1;

  return 0;
}

vehicle_badplace() {
  return _vehicle_badplace();
}

wheeldirectionchange(var_0) {
  self.wheeldir = common_scripts\utility::ter_op(var_0 <= 0, 0, 1);
}

maingun_fx() {
  if(isdefined(level.maingun_fx_override)) {
    thread[[level.maingun_fx_override]]();
    return;
  }

  var_0 = self.model;

  if(!isdefined(level.vehicle_deckdust[var_0])) {
    return;
  }
  self endon("death");

  for (;;) {
    self waittill("weapon_fired");
    playfxontag(level.vehicle_deckdust[var_0], self, "tag_engine_exhaust");
    var_1 = self gettagorigin("tag_flash");
    var_2 = physicstrace(var_1, var_1 + (0, 0, -128));
    physicsexplosionsphere(var_2, 192, 100, 1);
  }
}

playtankexhaust() {
  self endon("death");
  var_0 = self.model;

  if(!isdefined(level.vehicle_exhaust[var_0])) {
    return;
  }
  var_1 = 0.1;

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    playfxontag(level.vehicle_exhaust[var_0], _get_dummy(), "tag_engine_exhaust");
    wait(var_1);
  }
}

getonpath(var_0) {
  var_1 = undefined;
  var_2 = self.vehicletype;

  if(isdefined(self.vehicle_spawner)) {
    if(isdefined(self.vehicle_spawner.dontgetonpath) && self.dontgetonpath)
      return;
  }

  if(isdefined(self.target)) {
    var_1 = getvehiclenode(self.target, "targetname");

    if(!isdefined(var_1)) {
      var_3 = getentarray(self.target, "targetname");

      foreach(var_5 in var_3) {
        if(var_5.code_classname == "script_origin") {
          var_1 = var_5;
          break;
        }
      }
    }

    if(!isdefined(var_1))
      var_1 = common_scripts\utility::getstruct(self.target, "targetname");
  }

  if(!isdefined(var_1)) {
    if(_ishelicopter()) {
      if(isdefined(self.vehicle_heli_default_path_speeds))
        self[[self.vehicle_heli_default_path_speeds]]();
      else
        self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self.attachedpath = var_1;

  if(!_ishelicopter()) {
    self.origin = var_1.origin;

    if(!isdefined(var_0))
      self attachpath(var_1);
  } else if(isdefined(self.speed))
    self vehicle_setspeedimmediate(self.speed, 20);
  else if(isdefined(var_1.speed)) {
    if(isdefined(self.vehicle_heli_default_path_speeds))
      self[[self.vehicle_heli_default_path_speeds]](var_1.speed, var_1.script_accel, var_1.script_decel);
    else
      self vehicle_setspeed(var_1.speed, 20, 10);
  } else if(isdefined(self.vehicle_heli_default_path_speeds))
    self[[self.vehicle_heli_default_path_speeds]]();
  else
    self vehicle_setspeed(60, 20, 10);

  thread _vehicle_paths(undefined, _ishelicopter());
}

_vehicle_resume_named(var_0) {
  var_1 = self.vehicle_stop_named[var_0];
  self.vehicle_stop_named[var_0] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }
  self resumespeed(var_1);
}

_vehicle_stop_named(var_0, var_1, var_2) {
  if(!isdefined(self.vehicle_stop_named))
    self.vehicle_stop_named = [];

  self vehicle_setspeed(0, var_1, var_2);
  self.vehicle_stop_named[var_0] = var_1;
}

unload_node(var_0) {
  self endon("death");

  if(isdefined(self.ent_flag["prep_unload"]) && maps\_utility::ent_flag("prep_unload")) {
    return;
  }
  if(issubstr(self.classname, "snowmobile")) {
    while (self.veh_speed > 15)
      wait 0.05;
  }

  if(!isdefined(var_0.script_flag_wait) && !isdefined(var_0.script_delay))
    self notify("newpath");

  var_1 = getnode(var_0.targetname, "target");

  if(isdefined(var_1) && self.riders.size) {
    foreach(var_3 in self.riders) {
      if(isai(var_3))
        var_3 thread maps\_spawner::go_to_node(var_1);
    }
  }

  if(_ishelicopter()) {
    if(isdefined(self.parachute_unload)) {
      self setmaxpitchroll(0, 0);
      waittill_dropoff_height();
      common_scripts\utility::delaycall(5, ::setmaxpitchroll, 15, 15);
    } else {
      self sethoverparams(0);
      waittill_stable(var_0);
    }
  } else if(!isdefined(self.moving_unload) || !self.moving_unload)
    self vehicle_setspeed(0, 35);

  if(isdefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "wait_for_flag")
      common_scripts\utility::flag_wait(var_0.script_flag);
  }

  kill_deathanim_set_state("unloading");
  _vehicle_unload(var_0.script_unload);

  if(maps\_vehicle_aianim::riders_unloadable(var_0.script_unload)) {
    if(isdefined(self.parachute_unload)) {
      if(isdefined(var_0.script_noteworthy)) {
        if(var_0.script_noteworthy == "para_unload_stop")
          self waittill("unloaded");
      }
    } else
      self waittill("unloaded");
  }

  if(isdefined(var_0.script_flag_wait) || isdefined(var_0.script_delay)) {
    return;
  }
  if(isdefined(self))
    thread vehicle_resumepathvehicle();

  kill_deathanim_set_state("unloaded");
}

move_turrets_here(var_0) {
  var_1 = self.classname;

  if(!isdefined(self.mgturret)) {
    return;
  }
  if(self.mgturret.size == 0) {
    return;
  }
  foreach(var_4, var_3 in self.mgturret) {
    var_3 unlink();
    var_3 linkto(var_0, level.vehicle_mgturret[var_1][var_4].tag, (0, 0, 0), (0, 0, 0));
  }
}

vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");
  self setgoalyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

waittill_dropoff_height() {
  var_0 = 4;
  var_1 = 400;
  var_2 = gettime() + var_1;

  while (isdefined(self)) {
    var_3 = self.origin[2] - self.currentnode.origin[2];

    if(abs(var_3) <= var_0)
      return;
    else
      var_2 = gettime() + var_1;

    if(gettime() > var_2) {
      iprintln("Chopper parachute unload: waittill_dropoff_height timed out!");
      break;
    }

    wait 0.05;
  }
}

deathrollon() {
  if(self.health > 0)
    self.rollingdeath = 1;
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

_mgoff() {
  self.script_turretmg = 0;

  if(_ishelicopter() && hashelicopterturret()) {
    if(isdefined(level.chopperturretfunc)) {
      self thread[[level.chopperturretofffunc]]();
      return;
    }
  }

  if(!isdefined(self.mgturret)) {
    return;
  }
  foreach(var_2, var_1 in self.mgturret) {
    if(isdefined(var_1.script_fireondrones))
      var_1.script_fireondrones = 0;

    var_1 setmode("manual");
  }
}

_mgon() {
  self.script_turretmg = 1;

  if(_ishelicopter() && hashelicopterturret()) {
    self thread[[level.chopperturretonfunc]]();
    return;
  }

  if(!isdefined(self.mgturret)) {
    return;
  }
  foreach(var_1 in self.mgturret) {
    var_1 show();

    if(isdefined(var_1.script_fireondrones))
      var_1.script_fireondrones = 1;

    if(isdefined(var_1.defaultonmode)) {
      if(var_1.defaultonmode != "sentry")
        var_1 setmode(var_1.defaultonmode);
    } else
      var_1 setmode("auto_nonai");

    set_turret_team(var_1);
  }
}

_force_kill() {
  if(common_scripts\utility::isdestructible())
    common_scripts\_destructible::force_explosion();
  else {
    self kill();
    self setcandamage(0);
  }
}

get_vehicle_ai_riders() {
  if(!isdefined(self.script_vehicleride))
    return [];

  if(!isdefined(level.vehicle_rideai[self.script_vehicleride]))
    return [];

  return level.vehicle_rideai[self.script_vehicleride];
}

get_vehicle_ai_spawners() {
  var_0 = [];

  if(isdefined(self.target)) {
    var_1 = getentarray(self.target, "targetname");

    foreach(var_3 in var_1) {
      if(!issubstr(var_3.code_classname, "actor")) {
        continue;
      }
      if(!(var_3.spawnflags & 1)) {
        continue;
      }
      if(isdefined(var_3.dont_auto_ride)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    if(isdefined(level.spawn_pool_enabled)) {
      var_1 = common_scripts\utility::getstructarray(self.target, "targetname");

      foreach(var_3 in var_1) {
        if(isdefined(var_3.script_spawn_pool))
          var_0[var_0.size] = var_3;
      }
    }
  }

  if(!isdefined(self.script_vehicleride))
    return var_0;

  if(isdefined(level.vehicle_ridespawners[self.script_vehicleride]))
    var_0 = common_scripts\utility::array_combine(var_0, level.vehicle_ridespawners[self.script_vehicleride]);

  return var_0;
}

_vehicle_paths(var_0, var_1, var_2) {
  if(_ishelicopter())
    vehicle_paths_helicopter(var_0, var_1, var_2);
  else
    vehicle_paths_non_heli(var_0);
}

_gopath(var_0) {
  if(!isdefined(var_0))
    var_0 = self;

  if(isdefined(var_0.script_vehiclestartmove))
    level.vehicle_startmovegroup[var_0.script_vehiclestartmove] = common_scripts\utility::array_remove(level.vehicle_startmovegroup[var_0.script_vehiclestartmove], var_0);

  var_0 endon("death");

  if(isdefined(var_0.hasstarted))
    return;
  else
    var_0.hasstarted = 1;

  var_0 maps\_utility::script_delay();
  var_0 notify("start_vehiclepath");

  if(var_0 _ishelicopter())
    var_0 notify("start_dynamicpath");
  else {
    var_1 = getvehiclenode(var_0.target, "targetname");

    if(isdefined(var_1))
      var_0 thread _vehicle_paths(var_1);

    var_0 startpath();
  }
}

_scripted_spawn(var_0) {
  var_1 = _getvehiclespawnerarray_by_spawngroup(var_0);
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_2.size] = _vehicle_spawn(var_4);

  level notify("vehiclegroup spawned" + var_0, var_2);
  return var_2;
}

_vehicle_spawn(var_0) {
  if(!isspawner(var_0)) {
    return;
  }
  var_1 = var_0 vehicle_dospawn();

  if(!isdefined(var_0.spawned_count))
    var_0.spawned_count = 0;

  var_0.spawned_count++;
  var_0.vehicle_spawned_thisframe = var_1;
  var_0.last_spawned_vehicle = var_1;
  var_0 thread remove_vehicle_spawned_thisframe();
  var_1.vehicle_spawner = var_0;

  if(isdefined(var_0.truckjunk))
    var_1.truckjunk = var_0.truckjunk;

  thread vehicle_init(var_1);
  var_0 notify("spawned", var_1);

  if(isdefined(var_1.script_noteworthy))
    level notify("new_vehicle_spawned" + var_1.script_noteworthy, var_1);

  return var_1;
}

kill_vehicle_spawner(var_0) {
  var_0 waittill("trigger");
  maps\_utility::array_delete(level.vehicle_killspawn_groups[var_0.script_kill_vehicle_spawner]);
  level.vehicle_killspawn_groups[var_0.script_kill_vehicle_spawner] = [];
}

precache_scripts() {
  var_0 = [];
  var_1 = getentarray("script_vehicle", "code_classname");
  level.needsprecaching = [];
  var_2 = [];
  var_0 = [];

  if(!isdefined(level.vehicleinitthread))
    level.vehicleinitthread = [];

  foreach(var_4 in var_1) {
    var_4.vehicletype = tolower(var_4.vehicletype);

    if(var_4.vehicletype == "empty") {
      continue;
    }
    if(isdefined(var_4.spawnflags) && var_4.spawnflags & 1)
      var_2[var_2.size] = var_4;

    var_0[var_0.size] = var_4;

    if(!isdefined(level.vehicleinitthread[var_4.vehicletype]))
      level.vehicleinitthread[var_4.vehicletype] = [];

    var_5 = "classname: " + var_4.classname;
    precachesetup(var_5, var_4);
  }

  if(level.needsprecaching.size > 0) {
    foreach(var_8 in level.needsprecaching) {

    }

    level waittill("never");
  }

  return var_0;
}

precachesetup(var_0, var_1) {
  if(isdefined(level.vehicleinitthread[var_1.vehicletype][var_1.classname])) {
    return;
  }
  if(var_1.classname == "script_vehicle") {
    return;
  }
  var_2 = 0;

  foreach(var_4 in level.needsprecaching) {
    if(var_4 == var_0)
      var_2 = 1;
  }

  if(!var_2)
    level.needsprecaching[level.needsprecaching.size] = var_0;
}

setup_levelvars() {
  if(isdefined(level.vehicle_setup_levelvars)) {
    return;
  }
  level.vehicle_setup_levelvars = 1;
  level.vehicle_deletegroup = [];
  level.vehicle_startmovegroup = [];
  level.vehicle_rideai = [];
  level.vehicle_deathswitch = [];
  level.vehicle_ridespawners = [];
  level.vehicle_gatetrigger = [];
  level.vehicle_crashpaths = [];
  level.vehicle_link = [];
  level.vehicle_detourpaths = [];
  level.vehicle_startnodes = [];
  level.vehicle_killspawn_groups = [];
  level.helicopter_crash_locations = getentarray("helicopter_crash_location", "targetname");
  level.helicopter_crash_locations = common_scripts\utility::array_combine(level.helicopter_crash_locations, maps\_utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  level.playervehicle = spawn("script_origin", (0, 0, 0));
  level.playervehiclenone = level.playervehicle;
  level.vehicles = [];
  level.vehicles["allies"] = [];
  level.vehicles["axis"] = [];
  level.vehicles["neutral"] = [];
  level.vehicles["team3"] = [];

  if(!isdefined(level.vehicle_team))
    level.vehicle_team = [];

  if(!isdefined(level.vehicle_deathmodel))
    level.vehicle_deathmodel = [];

  if(!isdefined(level.vehicle_death_thread))
    level.vehicle_death_thread = [];

  if(!isdefined(level.vehicle_driveidle))
    level.vehicle_driveidle = [];

  if(!isdefined(level.vehicle_driveidle_r))
    level.vehicle_driveidle_r = [];

  if(!isdefined(level.attack_origin_condition_threadd))
    level.attack_origin_condition_threadd = [];

  if(!isdefined(level.vehiclefireanim))
    level.vehiclefireanim = [];

  if(!isdefined(level.vehiclefireanim_settle))
    level.vehiclefireanim_settle = [];

  if(!isdefined(level.vehicle_hasname))
    level.vehicle_hasname = [];

  if(!isdefined(level.vehicle_turret_requiresrider))
    level.vehicle_turret_requiresrider = [];

  if(!isdefined(level.vehicle_rumble))
    level.vehicle_rumble = [];

  if(!isdefined(level.vehicle_rumble_override))
    level.vehicle_rumble_override = [];

  if(!isdefined(level.vehicle_mgturret))
    level.vehicle_mgturret = [];

  if(!isdefined(level.vehicle_isstationary))
    level.vehicle_isstationary = [];

  if(!isdefined(level.vehicle_death_earthquake))
    level.vehicle_death_earthquake = [];

  if(!isdefined(level._vehicle_effect))
    level._vehicle_effect = [];

  if(!isdefined(level.vehicle_unloadgroups))
    level.vehicle_unloadgroups = [];

  if(!isdefined(level.vehicle_aianims))
    level.vehicle_aianims = [];

  if(!isdefined(level.vehicle_unloadwhenattacked))
    level.vehicle_unloadwhenattacked = [];

  if(!isdefined(level.vehicle_exhaust))
    level.vehicle_exhaust = [];

  if(!isdefined(level.vehicle_deckdust))
    level.vehicle_deckdust = [];

  if(!isdefined(level.vehicle_shoot_shock))
    level.vehicle_shoot_shock = [];

  if(!isdefined(level.vehicle_hide_list))
    level.vehicle_hide_list = [];

  if(!isdefined(level.vehicle_frontarmor))
    level.vehicle_frontarmor = [];

  if(!isdefined(level.destructible_model))
    level.destructible_model = [];

  if(!isdefined(level.vehicle_types))
    level.vehicle_types = [];

  if(!isdefined(level.vehicle_grenadeshield))
    level.vehicle_grenadeshield = [];

  if(!isdefined(level.vehicle_bulletshield))
    level.vehicle_bulletshield = [];

  if(!isdefined(level.vehicle_death_jolt))
    level.vehicle_death_jolt = [];

  if(!isdefined(level.vehicle_death_badplace))
    level.vehicle_death_badplace = [];

  if(!isdefined(level.vehicle_idleanim))
    level.vehicle_idleanim = [];

  if(!isdefined(level.helicopter_list))
    level.helicopter_list = [];

  if(!isdefined(level.airplane_list))
    level.airplane_list = [];

  if(!isdefined(level.vehicle_single_tread_list))
    level.vehicle_single_tread_list = [];

  if(!isdefined(level.vehicle_deathanim))
    level.vehicle_deathanim = [];

  maps\_vehicle_aianim::setup_aianimthreads();
}

setvehgoalpos_wrap(var_0, var_1) {
  return _setvehgoalpos_wrap(var_0, var_1);
}

vehicle_liftoffvehicle(var_0) {
  if(!isdefined(var_0))
    var_0 = 512;

  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(var_1, 1);
  self waittill("goal");
}

move_effects_ent_here(var_0, var_1) {
  var_2 = deathfx_ent();
  var_2 unlink();

  if(isdefined(var_1))
    var_2 linkto(var_0, var_1);
  else
    var_2 linkto(var_0);
}

model_dummy_death() {
  var_0 = self.modeldummy;
  var_0 endon("death");
  var_0 endon("stop_model_dummy_death");

  while (isdefined(self)) {
    self waittill("death");
    waittillframeend;
  }

  var_0 delete();
}

move_lights_here(var_0, var_1) {
  if(!isdefined(self.lights)) {
    return;
  }
  if(self.lights.size == 0) {
    return;
  }
  var_2 = get_light_on_groups();

  if(!isdefined(var_2)) {
    return;
  }
  foreach(var_4 in var_2) {
    var_0 lights_on_internal(var_4, self.classname);
    thread lights_off(var_4, self.classname);
  }
}

get_light_on_groups() {
  if(!isdefined(level.vehicle_lights_group[self.classname])) {
    return;
  }
  if(!isdefined(self.lights)) {
    return;
  }
  var_0 = [];
  var_1 = getarraykeys(self.lights);
  var_2 = getarraykeys(level.vehicle_lights_group[self.classname]);

  foreach(var_4 in var_2) {
    if(var_4 == "all") {
      continue;
    }
    foreach(var_6 in var_1) {
      if(common_scripts\utility::array_contains(level.vehicle_lights_group[self.classname][var_4], var_6)) {
        var_0[var_0.size] = var_4;
        break;
      }
    }
  }

  return var_0;
}

spawn_vehicles_from_targetname_newstyle(var_0) {
  var_1 = [];
  var_2 = getentarray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isdefined(var_5.code_classname) || var_5.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(var_5))
      var_1[var_1.size] = _vehicle_spawn(var_5);
  }

  return var_1;
}

kill_deathanim_thread(var_0, var_1) {
  if(isdefined(self.skipanimbaseddeath) && self.skipanimbaseddeath) {
    return;
  }
  var_2 = get_deathanim_info(var_0);

  if(!isdefined(var_2)) {
    return;
  }
  var_3 = get_deathanim(var_2, var_1);
  kill_deathanim_play(var_3, var_2);
}

get_deathanim_info(var_0) {
  if(isdefined(self.vehicle_deathanim))
    return self.vehicle_deathanim;

  if(isdefined(self.vehicle_deathanim_state)) {
    var_1 = var_0 + "_" + self.vehicle_deathanim_state;

    if(isdefined(level.vehicle_deathanim[var_1]))
      return level.vehicle_deathanim[var_1];
  }

  if(isdefined(level.vehicle_deathanim[var_0]))
    return level.vehicle_deathanim[var_0];

  return undefined;
}

get_deathanim(var_0, var_1) {
  if(isdefined(self.preferred_deathanim))
    return self.preferred_deathanim;

  if(var_0.is_directional)
    return get_directional_deathanim(var_0, var_1);

  return common_scripts\utility::random(var_0.anims);
}

get_directional_deathanim(var_0, var_1) {
  if(!isdefined(var_1))
    return common_scripts\utility::random(var_0.anims);

  var_2 = get_attacker_direction(var_1);

  if(!isarray(var_0.anims[var_2]))
    return var_0.anims[var_2];

  return common_scripts\utility::random(var_0.anims[var_2]);
}

get_attacker_direction(var_0) {
  var_1 = vectornormalize(anglestoforward(self.angles));
  var_2 = vectortoangles(var_1);
  var_3 = vectortoangles(var_0.origin - self.origin);
  var_4 = var_2[1] - var_3[1];
  var_4 = var_4 + 360;
  var_4 = int(var_4) % 360;

  if(var_4 > 315 || var_4 < 45)
    return "front";
  else if(var_4 < 135)
    return "right";
  else if(var_4 < 225)
    return "rear";

  return "left";
}

kill_deathanim_play(var_0, var_1) {
  self endon("death");
  maps\_utility::ent_flag_init("kill_deathanim_active");
  maps\_utility::ent_flag_set("kill_deathanim_active");
  self notify("kill_deathanim", var_0);

  if(isdefined(var_1.death_fx_on_self) && var_1.death_fx_on_self)
    self.death_fx_on_self = 1;

  maps\_utility::ent_flag_init("kill_deathanim_force_crash_end");

  if(isdefined(var_1.delay_crash_force_end) && var_1.delay_crash_force_end)
    maps\_utility::ent_flag_set("kill_deathanim_force_crash_end");

  self setcandamage(var_1.can_damage);
  thread kill_deathanim_delete(var_1.delete_time, var_0);

  if(isdefined(var_1.notetrack_notifies)) {
    foreach(var_3 in var_1.notetrack_notifies)
    kill_deathanim_notify(var_0, var_3);
  }

  if(var_1.turn_off_engine)
    self vehicle_turnengineoff();

  if(var_1.alter_velocity)
    self vehicle_setspeed(var_1.alter_velocity_speed, var_1.alter_velocity_accel, var_1.alter_velocity_decel);

  self useanimtree(#animtree);

  if(var_1.clear_anims)
    self clearanim( % root, var_1.clear_anims_time);

  var_5 = _get_dummy();
  var_5 setanim(var_0, 1, 0, 1);
  kill_deathanim_crash_delay(var_0, var_1);
  maps\_utility::ent_flag_clear("kill_deathanim_active");
}

kill_deathanim_crash_delay(var_0, var_1) {
  self endon("death");

  if(!var_1.delay_crash) {
    return;
  }
  var_2 = 0;

  if(animhasnotetrack(var_0, "stop_deathanim_crash_delay")) {
    var_3 = getanimlength(var_0);
    var_4 = getnotetracktimes(var_0, "stop_deathanim_crash_delay");
    var_2 = var_3 * var_4[0];
  } else if(var_1.delay_crash_time > 0)
    var_2 = var_1.delay_crash_time;
  else
    var_2 = getanimlength(var_0);

  wait(var_2);
}

kill_deathanim_delete(var_0, var_1) {
  if(maps\_utility::ent_flag("kill_deathanim_force_crash_end"))
    self waittill("death_finished");
  else {
    if(var_0 < 0) {
      return;
    }
    if(var_0 == 0)
      var_0 = getanimlength(var_1);

    wait(var_0);
  }

  if(isdefined(self) && !isremovedentity(self))
    self delete();
}

kill_deathanim_notify(var_0, var_1) {
  self endon("death");

  if(!animhasnotetrack(var_0, var_1)) {
    return;
  }
  var_2 = getanimlength(var_0);
  var_3 = getnotetracktimes(var_0, var_1);
  var_4 = 0;

  foreach(var_6 in var_3) {
    var_7 = var_2 * var_6;
    wait(var_7 - var_4);
    level notify(var_1, self);
    var_4 = var_4 + var_7;
  }
}

kill_deathanim_set_state(var_0) {
  self.vehicle_deathanim_state = var_0;
}

unmatched_death_rig_light_waits_for_lights_off() {
  if(!isdefined(self.has_unmatching_deathmodel_rig)) {
    return;
  }
  while (isdefined(self.lights) && self.lights.size)
    wait 0.05;
}

tread_audio_should_stop_loop(var_0, var_1) {
  if(isdefined(var_0) && isdefined(var_1)) {
    if(var_1 != var_0)
      return 1;
  } else if(!isdefined(var_0))
    return 1;

  return 0;
}

stop_tread_audio_loop() {
  if(isdefined(self.oldtreadsoundfx) && isdefined(self.soundisalreadyplaying) && self.soundisalreadyplaying == 1) {
    self notify("stop sound" + self.oldtreadsoundfx);
    self.soundisalreadyplaying = 0;
    self.oldtreadsoundfx = undefined;
  }
}

prepare_vehicle_play_anim_from_node() {
  self.modeldummy = spawn("script_model", self.origin);
  self.modeldummy setmodel(self.model);
  self.modeldummy.origin = self.origin;
  self.modeldummy.angles = self.angles;
  self.modeldummy useanimtree(#animtree);
  self.modeldummy hide();
  self.modeldummy linkto(self);
}

vehicle_play_anim_from_node(var_0) {
  var_1 = "vehicles";

  if(isdefined(self.animname))
    var_1 = var_1;

  var_2 = strtok(var_0.vehicles_anims, ":;, ");
  var_3 = var_2[0];

  if(!isdefined(level.scr_anim[var_1][var_3])) {
    return;
  }
  var_4 = "body_animate_jnt";
  maps\_vehicle::vehicle_to_dummy(var_4, 1);
  vehicle_dummy_add_collison(var_4);
  self vehicle_removebrushmodelcollision();
  self makevehiclenotcollidewithplayers(1);
  self setcontents(0);
  var_5 = self vehicle_getvelocity();
  self vehicle_setspeedimmediate(0, 3000, 3000);
  self.modeldummy maps\_utility::assign_animtree(var_1);
  var_6 = self.modeldummy;

  if(var_2.size > 1) {
    var_7 = common_scripts\utility::get_target_ent(var_2[1]);

    if(isdefined(var_7))
      var_6 = var_7;
  }

  if(var_6 != self.modeldummy) {
    var_8 = length(var_5);
    var_9 = distance(self.origin, var_6.origin);
    var_10 = var_9 / var_8;
    self.modeldummy moveto(var_6.origin, var_10);
    self.modeldummy rotateto(var_6.angles, var_10);
    var_11 = int(var_10 / 0.05) * 0.05;

    if(var_11 >= 0.05)
      wait(var_11);
  }

  var_6 maps\_anim::anim_single_solo(self.modeldummy, var_3);
}

vehicle_dummy_add_collison(var_0) {
  if(isdefined(var_0)) {
    self.modeldummycoll = spawn("script_model", self.origin);
    self.modeldummycoll setmodel(self.model);
    thread model_dummycoll_death();
    var_1 = self.modeldummy.origin - self.modeldummy gettagorigin(var_0);
    var_2 = self.modeldummy.angles - self.modeldummy gettagangles(var_0);
    self.modeldummycoll linkto(self.modeldummy, var_0, var_1, var_2);
    self.modeldummycoll vehicle_assignbrushmodelcollision();
    self.modeldummycoll hide();
    self.modeldummycoll dontinterpolate();
    self.modeldummy notsolid();
  } else
    self.modeldummy vehicle_assignbrushmodelcollision();
}

model_dummycoll_death() {
  var_0 = self.modeldummycoll;
  var_0 endon("death");
  var_0 endon("stop_model_dummy_death");

  while (isdefined(self)) {
    self waittill("death");
    waittillframeend;
  }

  var_0 delete();
}