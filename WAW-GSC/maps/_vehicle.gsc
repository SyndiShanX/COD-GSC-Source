/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#using_animtree("vehicles");

init_vehicles() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: _vehicle.gsc. Function: init_vehicles()\n");
  precachemodel("fx");
  if(isDefined(level.bypassVehicleScripts))
    return;
  level.heli_default_decel = 10;
  thread dump_handle();
  init_aircraft_list();
  init_boat_list();
  maps\_vehicletypes::setup_types();
  generate_colmaps_vehicles();
  setup_targetname_spawners();
  setup_dvars();
  setup_levelvars();
  array_thread(getentarray("truckjunk", "targetname"), ::truckjunk);
  vclogin_vehicles();
  setup_ai();
  setup_triggers();
  allvehiclesprespawn = precache_scripts();
  setup_vehicles(allvehiclesprespawn);
  array_levelthread(level.vehicle_processtriggers, ::trigger_process, allvehiclesprespawn);
  level.vehicle_processtriggers = undefined;
  init_level_has_vehicles();
  if(getdebugdvar("replay_debug") == "1")
    println("File: _vehicle.gsc. Function: init_vehicles() - COMPLETE\n");
  level.vehicle_enemy_tanks = [];
  level.vehicle_enemy_tanks["vehicle_ger_tracked_king_tiger"] = true;
  level.vehicle_enemy_tanks["vehicle_ger_tracked_panther"] = true;
  level.vehicle_enemy_tanks["vehicle_ger_tracked_panzer4"] = true;
  level.vehicle_enemy_tanks["vehicle_jap_tracked_type97shinhoto"] = true;
}

init_aircraft_list() {
  level.aircraft_list = [];
  level.aircraft_list["player_corsair"] = true;
  level.aircraft_list["rufe"] = true;
  level.aircraft_list["corsair"] = true;
  level.aircraft_list["zero"] = true;
  level.aircraft_list["pby"] = true;
  level.aircraft_list["pby_blackcat"] = true;
  level.aircraft_list["jap_gunboat"] = true;
  level.aircraft_list["il2"] = true;
}

init_boat_list() {
  level.boat_list = [];
  level.boat_list["rubber_raft"] = true;
  level.boat_list["jap_ptboat"] = true;
  level.boat_list["jap_shinyo"] = true;
  level.boat_list["jap_merchant_ship"] = true;
}

init_level_has_vehicles() {
  level.levelHasVehicles = false;
  if(level.vehicle_spawngroup.size > 0)
    level.levelHasVehicles = true;
  if(level.vehicle_spawners.size > 0)
    level.levelHasVehicles = true;
  if(level.vehicles["allies"].size > 0)
    level.levelHasVehicles = true;
  if(level.vehicles["axis"].size > 0)
    level.levelHasVehicles = true;
  if(level.vehicles["neutral"].size > 0)
    level.levelHasVehicles = true;
  classname = getentarray("script_vehicle", "classname");
  if(classname.size > 0)
    level.levelHasVehicles = true;
}

delete_group(vehicle, group) {
  println("delete group is just delete() now! please update your scripts");
  vehicle delete();
  return;
}

trigger_getlinkmap(trigger) {
  linkMap = [];
  if(isDefined(trigger.script_linkTo)) {
    links = strtok(trigger.script_linkTo, " ");
    for (i = 0; i < links.size; i++)
      linkMap[links[i]] = true;
    links = undefined;
  }
  return linkMap;
}

setup_script_gatetrigger(trigger) {
  gates = [];
  if(isDefined(trigger.script_gatetrigger))
    return level.vehicle_gatetrigger[trigger.script_gatetrigger];
  return gates;
}

setup_script_vehiclespawngroup(trigger, vehicles) {
  script_vehiclespawngroup = false;
  if(isDefined(trigger.script_vehiclespawngroup))
    script_vehiclespawngroup = true;
  return script_vehiclespawngroup;
}

trigger_process(trigger, vehicles) {
  if(isDefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat"))
    bTriggeronce = true;
  else
    bTriggeronce = false;
  trigger.processed_trigger = undefined;
  if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple")
    bTriggeronce = false;
  gates = setup_script_gatetrigger(trigger);
  script_vehiclespawngroup = isDefined(trigger.script_vehiclespawngroup);
  script_vehicledetour = isDefined(trigger.script_vehicledetour) && (is_node_script_origin(trigger) || is_node_script_struct(trigger));
  detoured = isDefined(trigger.detoured) && !(is_node_script_origin(trigger) || is_node_script_struct(trigger));
  gotrigger = true;
  vehicles = undefined;
  while (gotrigger) {
    trigger waittill("trigger", other);
    if(isDefined(trigger.script_vehicletriggergroup)) {
      if(!isDefined(other.script_vehicletriggergroup))
        continue;
      if(other.script_vehicletriggergroup != trigger.script_vehicletriggergroup)
        continue;
    }
    if(isDefined(trigger.enabled) && !trigger.enabled)
      trigger waittill("enable");
    if(isDefined(trigger.script_flag_set)) {
      if(isDefined(other.vehicle_flags))
        other.vehicle_flags[trigger.script_flag_set] = true;
      other notify("vehicle_flag_arrived", trigger.script_flag_set);
      flag_set(trigger.script_flag_set);
    }
    if(isDefined(trigger.script_flag_clear)) {
      if(isDefined(other.vehicle_flags))
        other.vehicle_flags[trigger.script_flag_clear] = false;
      flag_clear(trigger.script_flag_clear);
    }
    if(script_vehicledetour)
      other thread path_detour_script_origin(trigger);
    else if(detoured && isDefined(other))
      other thread path_detour(trigger);
    if(isDefined(trigger.script_delay))
      wait trigger.script_delay;
    targs = [];
    if(bTriggeronce) {
      if(isDefined(trigger.target) && isDefined(level.vehicle_target[trigger.target]))
        targs = level.vehicle_target[trigger.target];
      gotrigger = false;
    }
    if(isDefined(trigger.script_vehicleGroupDelete)) {
      if(!isDefined(level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete])) {
        println("failed to find deleteable vehicle with script_vehicleGroupDelete group number: ", trigger.script_vehicleGroupDelete);
        level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete] = [];
      }
      array_levelthread(level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete], ::deleteEnt);
    }
    if(script_vehiclespawngroup) {
      level notify("spawnvehiclegroup" + trigger.script_vehiclespawngroup);
      waittillframeend;
    }
    if(gates.size > 0 && bTriggeronce)
      array_levelthread(gates, ::path_gate_open);
    if(isDefined(trigger.script_VehicleStartMove)) {
      if(!isDefined(level.vehicle_StartMoveGroup[trigger.script_VehicleStartMove])) {
        println("^3Vehicle start trigger is: ", trigger.script_VehicleStartMove);
        return;
      }
      array_levelthread(level.vehicle_StartMoveGroup[trigger.script_VehicleStartMove], ::gopath);
    }
  }
}

path_detour_get_detourpath(detournode) {
  detourpath = undefined;
  for (j = 0; j < level.vehicle_detourpaths[detournode.script_vehicledetour].size; j++) {
    if(level.vehicle_detourpaths[detournode.script_vehicledetour][j] != detournode)
      if(!islastnode(level.vehicle_detourpaths[detournode.script_vehicledetour][j]))
        detourpath = level.vehicle_detourpaths[detournode.script_vehicledetour][j];
  }
  return detourpath;
}

path_detour_script_origin(detournode) {
  detourpath = path_detour_get_detourpath(detournode);
  if(isDefined(detourpath))
    self thread vehicle_paths(detourpath);
}

crash_detour_check(detourpath) {
  return (
    isDefined(detourpath.script_crashtype) &&
    (
      isDefined(self.deaddriver) ||
      self.health <= 0 ||
      detourpath.script_crashtype == "forced" ||
      (level.vclogin_vehicles)
    ) &&
    (
      !isDefined(detourpath.derailed) ||
      (isDefined(detourpath.script_crashtype) && detourpath.script_crashtype == "plane")
    )
  );
}

crash_derailed_check(detourpath) {
  return isDefined(detourpath.derailed) && detourpath.derailed;
}

path_detour(node) {
  detournode = getvehiclenode(node.target, "targetname");
  detourpath = path_detour_get_detourpath(detournode);
  if(!isDefined(detourpath))
    return;
  if(node.detoured && !isDefined(detourpath.script_vehicledetourgroup))
    return;
  if(crash_detour_check(detourpath)) {
    self notify("crashpath", detourpath);
    detourpath.derailed = 1;
    self notify("newpath");
    self setSwitchNode(node, detourpath);
    return;
  } else {
    if(crash_derailed_check(detourpath))
      return;
    if(isDefined(detourpath.script_vehicledetourgroup)) {
      if(!isDefined(self.script_vehicledetourgroup))
        return;
      if(detourpath.script_vehicledetourgroup != self.script_vehicledetourgroup)
        return;
    }
  }
}

detour_flag(detourpath) {
  self endon("death");
  self.detouringpath = detourpath;
  detourpath waittillmatch("trigger", self);
  self.detouringpath = undefined;
}

vehicle_Levelstuff(vehicle, trigger) {
  if(isDefined(vehicle.script_linkname))
    level.vehicle_link = array_2dadd(level.vehicle_link, vehicle.script_linkname, vehicle);
  if(isDefined(vehicle.targetname))
    level.vehicle_target = array_2dadd(level.vehicle_target, vehicle.targetname, vehicle);
  if(isDefined(vehicle.script_VehicleSpawngroup))
    level.vehicle_SpawnGroup = array_2dadd(level.vehicle_SpawnGroup, vehicle.script_VehicleSpawngroup, vehicle);
  if(isDefined(vehicle.script_VehicleStartMove))
    level.vehicle_StartMoveGroup = array_2dadd(level.vehicle_StartMoveGroup, vehicle.script_VehicleStartMove, vehicle);
  if(isDefined(vehicle.script_vehicleGroupDelete))
    level.vehicle_DeleteGroup = array_2dadd(level.vehicle_DeleteGroup, vehicle.script_vehicleGroupDelete, vehicle);
}

spawn_array(spawners) {
  ai = [];
  for (i = 0; i < spawners.size; i++) {
    spawners[i].count = 1;
    dronespawn = false;
    if(isDefined(spawners[i].script_drone)) {
      dronespawn = true;
      spawned = dronespawn(spawners[i]);
      assert(isDefined(spawned));
    } else if(isDefined(spawners[i].script_forcespawn))
      spawned = spawners[i] stalingradSpawn();
    else
      spawned = spawners[i] doSpawn();
    if(!dronespawn && !isalive(spawned))
      continue;
    assert(isDefined(spawned));
    ai[ai.size] = spawned;
  }
  ai = remove_non_riders_from_array(ai);
  return ai;
}

remove_non_riders_from_array(ai) {
  living_ai = [];
  for (i = 0; i < ai.size; i++) {
    if(!ai_should_be_added(ai[i]))
      continue;
    living_ai[living_ai.size] = ai[i];
  }
  return living_ai;
}

ai_should_be_added(ai) {
  if(isalive(ai))
    return true;
  if(!isDefined(ai))
    return false;
  if(!isDefined(ai.classname))
    return false;
  return ai.classname == "script_model";
}

spawn_group() {
  HasRiders = (isDefined(self.script_vehicleride));
  HasWalkers = (isDefined(self.script_vehiclewalk));
  if(!(HasRiders || HasWalkers)) {
    return;
  }
  spawners = [];
  riderspawners = [];
  walkerspawners = [];
  if(HasRiders)
    riderspawners = level.vehicle_RideSpawners[self.script_vehicleride];
  if(!isDefined(riderspawners))
    riderspawners = [];
  if(HasWalkers)
    walkerspawners = level.vehicle_walkspawners[self.script_vehiclewalk];
  if(!isDefined(walkerspawners))
    walkerspawners = [];
  spawners = array_combine(riderspawners, walkerspawners);
  startinvehicles = [];
  ai = spawn_array(spawners);
  if(HasRiders) {
    if(isDefined(level.vehicle_RideAI[self.script_vehicleride])) {
      ai = array_combine(ai, level.vehicle_RideAI[self.script_vehicleride]);
    }
  }
  if(HasWalkers) {
    if(isDefined(level.vehicle_WalkAI[self.script_vehiclewalk])) {
      ai = array_combine(ai, level.vehicle_WalkAI[self.script_vehiclewalk]);
      ai vehicle_rider_walk_setup(self);
    }
  }
  ai = sort_by_startingpos(ai);
  for (i = 0; i < ai.size; i++)
    self thread maps\_vehicle_aianim::guy_enter(ai[i], self);
}

sort_by_startingpos(guysarray) {
  firstarray = [];
  secondarray = [];
  for (i = 0; i < guysarray.size; i++) {
    if(isDefined(guysarray[i].script_startingposition))
      firstarray[firstarray.size] = guysarray[i];
    else
      secondarray[secondarray.size] = guysarray[i];
  }
  return array_combine(firstarray, secondarray);
}

vehicle_rider_walk_setup(vehicle) {
  if(!isDefined(self.script_vehiclewalk))
    return;
  if(isDefined(self.script_followmode))
    self.FollowMode = self.script_followmode;
  else
    self.FollowMode = "cover nodes";
  if(!isDefined(self.target))
    return;
  node = getnode(self.target, "targetname");
  if(isDefined(node))
    self.NodeAftervehicleWalk = node;
}

runtovehicle(guy) {
  guyarray = [];
  climbinnode = self.climbnode;
  climbinanim = self.climbanim;
  closenode = climbinnode[0];
  currentdist = 5000;
  thenode = undefined;
  for (i = 0; i < climbinnode.size; i++) {
    climborg = self gettagorigin(climbinnode[i]);
    climbang = self gettagangles(climbinnode[i]);
    org = getstartorigin(climborg, climbang, climbinanim[i]);
    distance = distance(guy.origin, climborg);
    if(distance < currentdist) {
      currentdist = distance;
      closenode = climbinnode[i];
      thenode = i;
    }
  }
  climbang = undefined;
  climborg = undefined;
  thread runtovehicle_setgoal(guy);
  while (!guy.vehicle_goal) {
    climborg = self gettagorigin(climbinnode[thenode]);
    climbang = self gettagangles(climbinnode[thenode]);
    org = getStartOrigin(climborg, climbang, climbinanim[thenode]);
    guy set_forcegoal();
    guy setgoalpos(org);
    guy.goalradius = 64;
    wait .25;
  }
  guy unset_forcegoal();
  if(self getspeedmph() < 1) {
    guy linkto(self);
    guy animscripted("hopinend", climborg, climbang, climbinanim[thenode]);
    guy waittillmatch("hopinend", "end");
    guy_enter_vehicle(guy, self);
  }
}

runtovehicle_setgoal(guy) {
  guy.vehicle_goal = false;
  self endon("death");
  guy endon("death");
  guy waittill("goal");
  guy.vehicle_goal = true;
}

setup_groundnode_detour(node) {
  realdetournode = getvehiclenode(node.targetname, "target");
  if(!isDefined(realdetournode))
    return;
  realdetournode.detoured = 0;
  add_proccess_trigger(realdetournode);
}

add_proccess_trigger(trigger) {
  if(isDefined(trigger.processed_trigger))
    return;
  level.vehicle_processtriggers[level.vehicle_processtriggers.size] = trigger;
  trigger.processed_trigger = true;
}

islastnode(node) {
  if(!isDefined(node.target))
    return true;
  if(!isDefined(getvehiclenode(node.target, "targetname")) && !isDefined(get_vehiclenode_any_dynamic(node.target)))
    return true;
  return false;
}

get_path_getfunc(pathpoint) {
  get_func = ::get_from_vehicle_node;
  if(is_aircraft() && isDefined(pathpoint.target)) {
    if(isDefined(get_from_entity(pathpoint.target)))
      get_func = ::get_from_entity;
    if(isDefined(get_from_spawnstruct(pathpoint.target)))
      get_func = ::get_from_spawnstruct;
  }
  return get_func;
}

path_array_setup(pathpoint) {
  get_func = ::get_from_vehicle_node;
  if(is_aircraft() && isDefined(pathpoint.target)) {
    if(isDefined(get_from_entity(pathpoint.target)))
      get_func = ::get_from_entity;
    if(isDefined(get_from_spawnstruct(pathpoint.target)))
      get_func = ::get_from_spawnstruct;
  }
  arraycount = 0;
  pathpoints = [];
  while (isDefined(pathpoint)) {
    pathpoints[arraycount] = pathpoint;
    arraycount++;
    if(isDefined(pathpoint.target))
      pathpoint = [
        [get_func]
      ](pathpoint.target);
    else
      break;
  }
  return pathpoints;
}

node_wait(nextpoint, lastpoint) {
  if(self.attachedpath == nextpoint) {
    waittillframeend;
    return;
  }
  if(!isDefined(self))
    return;
  self setWaitNode(nextpoint);
  self waittill("reached_wait_node");
}

vehicle_paths(node, baircraftwaitforstart) {
  assertex(isDefined(node) || isDefined(self.attachedpath), "vehicle_path() called without a path");
  self notify("newpath");
  if(!isDefined(baircraftwaitforstart))
    baircraftwaitforstart = false;
  if(isDefined(node))
    self.attachedpath = node;
  pathstart = self.attachedpath;
  self.currentNode = self.attachedpath;
  if(!isDefined(pathstart))
    return;
  self endon("newpath");
  pathpoint = pathstart;
  wait_func = ::node_wait;
  lastpoint = undefined;
  nextpoint = pathstart;
  get_func = get_path_getfunc(pathstart);
  while (isDefined(nextpoint)) {
    [
      [wait_func]
    ](nextpoint, lastpoint);
    if(!isDefined(self))
      return;
    self.currentNode = nextpoint;
    if(isDefined(nextpoint.gateopen) && !nextpoint.gateopen) {
      self thread path_gate_wait_till_open(nextpoint);
    }
    nextpoint notify("trigger", self);
    if(isDefined(nextpoint.script_dropbombs) && nextpoint.script_dropbombs > 0) {
      amount = nextpoint.script_dropbombs;
      delay = 0;
      delaytrace = 0;
      if(isDefined(nextpoint.script_dropbombs_delay) && nextpoint.script_dropbombs_delay > 0) {
        delay = nextpoint.script_dropbombs_delay;
      }
      if(isDefined(nextpoint.script_dropbombs_delaytrace) && nextpoint.script_dropbombs_delaytrace > 0) {
        delaytrace = nextpoint.script_dropbombs_delaytrace;
      }
      self notify("drop_bombs", amount, delay, delaytrace);
    }
    if(isDefined(nextpoint.script_volumedown)) {
      assertex(!isDefined(nextpoint.script_volumedown), "Tried to volume down while voluming up, or vice versa");
      self thread volume_down(nextpoint.script_volumedown);
    }
    if(isDefined(nextpoint.script_volumeup)) {
      assertex(!isDefined(nextpoint.script_volumeup), "Tried to volume down while voluming up, or vice versa");
      self thread volume_up(nextpoint.script_volumeup);
    }
    if(isDefined(nextpoint.script_noteworthy)) {
      self notify(nextpoint.script_noteworthy);
      self notify("noteworthy", nextpoint.script_noteworthy);
    }
    waittillframeend;
    if(!isDefined(self))
      return;
    if(isDefined(nextpoint.script_noteworthy)) {
      if(nextpoint.script_noteworthy == "godon")
        self godon();
      if(nextpoint.script_noteworthy == "godoff")
        self godoff();
      if(nextpoint.script_noteworthy == "deleteme")
        level thread deleteent(self);
    }
    if(isDefined(nextpoint.script_crashtypeoverride))
      self.script_crashtypeoverride = nextpoint.script_crashtypeoverride;
    if(isDefined(nextpoint.script_badplace))
      self.script_badplace = nextpoint.script_badplace;
    if(isDefined(nextpoint.script_turretmg))
      self.script_turretmg = nextpoint.script_turretmg;
    if(isDefined(nextpoint.script_team))
      self.script_team = nextpoint.script_team;
    if(isDefined(nextpoint.script_turningdir))
      self notify("turning", nextpoint.script_turningdir);
    if(isDefined(nextpoint.script_deathroll))
      if(nextpoint.script_deathroll == 0)
        self thread deathrolloff();
      else
        self thread deathrollon();
    if(isDefined(nextpoint.script_vehicleaianim)) {
      if(isDefined(nextpoint.script_parameters) && nextpoint.script_parameters == "queue")
        self.queueanim = true;
      if(isDefined(nextpoint.script_startingposition))
        self.groupedanim_pos = nextpoint.script_startingposition;
      self notify("groupedanimevent", nextpoint.script_vehicleaianim);
    }
    if(isDefined(nextpoint.script_wheeldirection))
      self wheeldirectionchange(nextpoint.script_wheeldirection);
    if(isDefined(nextpoint.script_exploder))
      level exploder(nextpoint.script_exploder);
    if(isDefined(nextpoint.script_flag_set)) {
      if(isDefined(self.vehicle_flags))
        self.vehicle_flags[nextpoint.script_flag_set] = true;
      self notify("vehicle_flag_arrived", nextpoint.script_flag_set);
      flag_set(nextpoint.script_flag_set);
    }
    if(isDefined(nextpoint.script_flag_clear)) {
      if(isDefined(self.vehicle_flags))
        self.vehicle_flags[nextpoint.script_flag_clear] = false;
      flag_clear(nextpoint.script_flag_clear);
    }
    if(isDefined(nextpoint.script_unload))
      self thread unload_node(nextpoint);
    if(isDefined(nextpoint.script_flag_wait)) {
      if(!isDefined(self.vehicle_flags)) {
        self.vehicle_flags = [];
      }
      self.vehicle_flags[nextpoint.script_flag_wait] = true;
      self notify("vehicle_flag_arrived", nextpoint.script_flag_wait);
      if(!flag(nextpoint.script_flag_wait)) {
        if(!is_aircraft())
          self setSpeed(0, 35);
      }
      flag_wait(nextpoint.script_flag_wait);
    }
    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearLookAtEnt();
    }
    if(isDefined(nextpoint.script_vehicle_lights_off))
      self thread lights_off(nextpoint.script_vehicle_lights_off);
    if(isDefined(nextpoint.script_vehicle_lights_on))
      self thread lights_on(nextpoint.script_vehicle_lights_on);
    lastpoint = nextpoint;
    if(!isDefined(nextpoint.target)) {
      break;
    }
    nextpoint = [
      [get_func]
    ](nextpoint.target);
  }
  self notify("reached_dynamic_path_end");
  if(isDefined(self.script_vehicle_selfremove))
    self delete();
}

must_stop_at_next_point(nextpoint) {
  if(isDefined(nextpoint.script_unload))
    return true;
  return isDefined(nextpoint.script_flag_wait) && !flag(nextpoint.script_flag_wait);
}

aircraft_wait_node(nextpoint, lastpoint) {
  self endon("newpath");
  if(isDefined(nextpoint.script_unload) && isDefined(self.fastropeoffset)) {
    nextpoint.radius = 2;
    neworg = groundpos(nextpoint.origin) + (0, 0, self.fastropeoffset);
    if(neworg[2] > nextpoint.origin[2] - 2000) {
      nextpoint.origin = groundpos(nextpoint.origin) + (0, 0, self.fastropeoffset);
    }
    self sethoverparams(0, 0, 0);
  }
  if(isDefined(lastpoint)) {
    if(isDefined(lastpoint.speed)) {
      speed = lastpoint.speed;
      accel = 25;
      decel = undefined;
      if(isDefined(lastpoint.script_decel)) {
        decel = lastpoint.script_decel;
      } else {
        if(must_stop_at_next_point(nextpoint)) {}
      }
      if(isDefined(lastpoint.script_accel)) {
        accel = lastpoint.script_accel;
      } else {
        max_accel = speed / 4;
        if(accel > max_accel) {
          accel = max_accel;
        }
      }
      if(isDefined(decel)) {
        self setSpeed(speed, accel, decel);
      } else {
        self setSpeed(speed, accel);
      }
    } else {
      if(must_stop_at_next_point(nextpoint)) {}
    }
  }
  self setvehgoalnode(nextpoint);
  if(isDefined(nextpoint.radius)) {
    self setNearGoalNotifyDist(nextpoint.radius);
    assertex(nextpoint.radius > 0, "radius: " + nextpoint.radius);
    self waittill_any("near_goal", "goal");
  } else {
    self waittill("goal");
  }
  if(isDefined(nextpoint.script_stopnode)) {
    if(nextpoint.script_stopnode)
      self notify("reached_stop_node");
    if(isDefined(nextpoint.script_delay))
      wait nextpoint.script_delay;
  }
}

helipath(msg, maxspeed, accel) {
  self setairresistance(30);
  self setSpeed(maxspeed, accel, level.heli_default_decel);
  vehicle_paths(getstruct(msg, "targetname"));
}

setvehgoalnode(node) {
  self endon("death");
  stop = false;
  if(!isDefined(stop))
    stop = true;
  if(isDefined(node.script_stopnode))
    stop = node.script_stopnode;
  if(isDefined(node.script_unload))
    stop = true;
  script_anglevehicle = isDefined(node.script_anglevehicle) && node.script_anglevehicle;
  script_goalyaw = isDefined(node.script_goalyaw) && node.script_goalyaw;
  if(isDefined(node.script_anglevehicle) || isDefined(node.script_goalyaw))
    self forcetarget(node, script_goalyaw, script_anglevehicle);
  else
    self unforcetarget();
  if(isDefined(node.script_flag_wait)) {
    if(!flag(node.script_flag_wait)) {
      stop = true;
    }
  }
  if(!isDefined(node.target)) {
    stop = true;
  }
  self setvehgoalpos_wrap(node.origin, stop);
}

forcetarget(node, script_goalyaw, script_anglevehicle) {
  if(script_goalyaw) {
    self cleartargetyaw();
    self setgoalyaw(node.angles[1]);
  } else {
    self cleargoalyaw();
    self settargetyaw(node.angles[1]);
  }
}

unforcetarget() {
  self cleargoalyaw();
  self cleartargetyaw();
}

deathrollon() {
  if(self.health > 0)
    self.rollingdeath = 1;
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

getonpath() {
  path_start = undefined;
  type = self.vehicletype;
  if(isDefined(self.target)) {
    path_start = getvehiclenode(self.target, "targetname");
    if(!isDefined(path_start)) {
      path_start = getent(self.target, "targetname");
    }
    if(!isDefined(path_start)) {
      path_start = getstruct(self.target, "targetname");
    }
  }
  if(!isDefined(path_start))
    return;
  self.attachedpath = path_start;
  self.origin = path_start.origin;
  if(!is_aircraft() || is_aircraft()) {
    self attachpath(path_start);
  } else {
    if(isDefined(self.speed)) {
      self setspeedimmediate(self.speed, 20);
    } else
    if(isDefined(path_start.speed)) {
      self setspeed(path_start.speed, 20, level.heli_default_decel);
    } else {
      self setspeed(150, 20, level.heli_default_decel);
    }
  }
  if(!isDefined(self.dontDisconnectPaths)) {
    self disconnectpaths();
  }
  self thread vehicle_paths(undefined, is_aircraft());
}

create_vehicle_from_spawngroup_and_gopath(spawnGroup) {
  vehicleArray = maps\_vehicle::scripted_spawn(spawnGroup);
  for (i = 0; i < vehicleArray.size; i++)
    level thread maps\_vehicle::gopath(vehicleArray[i]);
  return vehicleArray;
}

gopath(vehicle) {
  if(!isDefined(vehicle))
    println("go path called on non existant vehicle");
  if(isDefined(vehicle.script_vehiclestartmove))
    level.vehicle_StartMoveGroup[vehicle.script_vehiclestartmove] = array_remove(level.vehicle_StartMoveGroup[vehicle.script_vehiclestartmove], vehicle);
  vehicle endon("death");
  vehicle endon("stop path");
  if(isDefined(vehicle.hasstarted)) {
    println("vehicle already moving when triggered with a startmove");
    return;
  } else
    vehicle.hasstarted = true;
  if(isDefined(vehicle.script_delay))
    wait vehicle.script_delay;
  vehicle notify("start_vehiclepath");
  vehicle startpath();
  wait .05;
  vehicle connectpaths();
  vehicle waittill("reached_end_node");
  if(!isDefined(vehicle.dontDisconnectPaths))
    vehicle disconnectpaths();
  if(isDefined(vehicle.currentnode) && isDefined(vehicle.currentnode.script_noteworthy) && vehicle.currentnode.script_noteworthy == "deleteme")
    return;
  if(isDefined(vehicle.dontunloadonend))
    return;
  if(isDefined(vehicle.script_unloaddelay))
    vehicle thread dounload(vehicle.script_unloaddelay);
  else
    vehicle notify("unload");
}

dounload(delay) {
  self endon("unload");
  if(delay <= 0)
    return;
  wait delay;
  self notify("unload");
}

path_gate_open(node) {
  node.gateopen = true;
  node notify("gate opened");
}

path_gate_wait_till_open(pathspot) {
  self endon("death");
  self.waitingforgate = true;
  self vehicle_setspeed(0, 15, "path gate closed");
  pathspot waittill("gate opened");
  self.waitingforgate = false;
  if(self.health > 0)
    script_resumespeed("gate opened", level.vehicle_ResumeSpeed);
}

spawner_setup(vehicles, message, from) {
  script_vehiclespawngroup = message;
  if(!isDefined(level.vehicleSpawners))
    level.vehicleSpawners = [];
  level.vehicleSpawners[script_vehiclespawngroup] = [];
  vehicle = [];
  for (i = 0; i < vehicles.size; i++) {
    if(!isDefined(vehicle[script_vehiclespawngroup]))
      vehicle[script_vehiclespawngroup] = [];
    script_struct = spawnstruct();
    script_struct setspawnervariables(vehicles[i], from);
    vehicle[script_vehiclespawngroup][vehicle[script_vehiclespawngroup].size] = script_struct;
    level.vehicleSpawners[script_vehiclespawngroup][i] = script_struct;
  }
  while (1) {
    spawnedvehicles = [];
    level waittill("spawnvehiclegroup" + message);
    for (i = 0; i < vehicle[script_vehiclespawngroup].size; i++)
      spawnedvehicles[spawnedvehicles.size] = vehicle_spawn(vehicle[script_vehiclespawngroup][i]);
    level notify("vehiclegroup spawned" + message, spawnedvehicles);
  }
}

scripted_spawn(group) {
  thread scripted_spawn_go(group);
  level waittill("vehiclegroup spawned" + group, vehicles);
  return vehicles;
}

scripted_spawn_go(group) {
  waittillframeend;
  level notify("spawnvehiclegroup" + group);
}

setspawnervariables(vehicle, from) {
  self.spawnermodel = vehicle.model;
  self.angles = vehicle.angles;
  self.origin = vehicle.origin;
  if(isDefined(vehicle.script_delay))
    self.script_delay = vehicle.script_delay;
  if(isDefined(vehicle.script_noteworthy))
    self.script_noteworthy = vehicle.script_noteworthy;
  if(isDefined(vehicle.script_parameters))
    self.script_parameters = vehicle.script_parameters;
  if(isDefined(vehicle.script_team))
    self.script_team = vehicle.script_team;
  if(isDefined(vehicle.script_vehicleride))
    self.script_vehicleride = vehicle.script_vehicleride;
  if(isDefined(vehicle.target))
    self.target = vehicle.target;
  if(isDefined(vehicle.targetname))
    self.targetname = vehicle.targetname;
  else
    self.targetname = "notdefined";
  self.spawnedtargetname = self.targetname;
  self.targetname = self.targetname + "_vehiclespawner";
  if(isDefined(vehicle.triggeredthink))
    self.triggeredthink = vehicle.triggeredthink;
  if(isDefined(vehicle.script_sound))
    self.script_sound = vehicle.script_sound;
  if(isDefined(vehicle.script_turretmg))
    self.script_turretmg = vehicle.script_turretmg;
  if(isDefined(vehicle.script_startinghealth))
    self.script_startinghealth = vehicle.script_startinghealth;
  if(isDefined(vehicle.spawnerNum))
    self.spawnerNum = vehicle.spawnerNum;
  if(isDefined(vehicle.script_deathnotify))
    self.script_deathnotify = vehicle.script_deathnotify;
  if(isDefined(vehicle.script_turret))
    self.script_turret = vehicle.script_turret;
  if(isDefined(vehicle.script_linkTo))
    self.script_linkTo = vehicle.script_linkTo;
  if(isDefined(vehicle.script_VehicleSpawngroup))
    self.script_VehicleSpawngroup = vehicle.script_VehicleSpawngroup;
  if(isDefined(vehicle.script_VehicleStartMove))
    self.script_VehicleStartMove = vehicle.script_VehicleStartMove;
  if(isDefined(vehicle.script_vehicleGroupDelete))
    self.script_vehicleGroupDelete = vehicle.script_vehicleGroupDelete;
  if(isDefined(vehicle.script_vehicle_selfremove))
    self.script_vehicle_selfremove = vehicle.script_vehicle_selfremove;
  if(isDefined(vehicle.script_nomg))
    self.script_nomg = vehicle.script_nomg;
  if(isDefined(vehicle.script_badplace))
    self.script_badplace = vehicle.script_badplace;
  if(isDefined(vehicle.script_vehicleride))
    self.script_vehicleride = vehicle.script_vehicleride;
  if(isDefined(vehicle.script_vehiclewalk))
    self.script_vehiclewalk = vehicle.script_vehiclewalk;
  if(isDefined(vehicle.script_linkName))
    self.script_linkName = vehicle.script_linkName;
  if(isDefined(vehicle.script_crashtypeoverride))
    self.script_crashtypeoverride = vehicle.script_crashtypeoverride;
  if(isDefined(vehicle.script_unloaddelay))
    self.script_unloaddelay = vehicle.script_unloaddelay;
  if(isDefined(vehicle.script_unloadmgguy))
    self.script_unloadmgguy = vehicle.script_unloadmgguy;
  if(isDefined(vehicle.script_keepdriver))
    self.script_keepdriver = vehicle.script_keepdriver;
  if(isDefined(vehicle.script_fireondrones))
    self.script_fireondrones = vehicle.script_fireondrones;
  if(isDefined(vehicle.script_tankgroup))
    self.script_tankgroup = vehicle.script_tankgroup;
  if(isDefined(vehicle.script_avoidplayer))
    self.script_avoidplayer = vehicle.script_avoidplayer;
  if(isDefined(vehicle.script_playerconeradius))
    self.script_playerconeradius = vehicle.script_playerconeradius;
  if(isDefined(vehicle.script_cobratarget))
    self.script_cobratarget = vehicle.script_cobratarget;
  if(isDefined(vehicle.script_targettype))
    self.script_targettype = vehicle.script_targettype;
  if(isDefined(vehicle.script_targetoffset_z))
    self.script_targetoffset_z = vehicle.script_targetoffset_z;
  if(isDefined(vehicle.script_wingman))
    self.script_wingman = vehicle.script_wingman;
  if(isDefined(vehicle.script_mg_angle))
    self.script_mg_angle = vehicle.script_mg_angle;
  if(isDefined(vehicle.script_physicsjolt))
    self.script_physicsjolt = vehicle.script_physicsjolt;
  if(isDefined(vehicle.script_vehicle_lights_on))
    self.script_vehicle_lights_on = vehicle.script_vehicle_lights_on;
  if(isDefined(vehicle.script_light_toggle))
    self.script_light_toggle = vehicle.script_light_toggle;
  if(isDefined(vehicle.script_vehicledetourgroup))
    self.script_vehicledetourgroup = vehicle.script_vehicledetourgroup;
  if(isDefined(vehicle.speed))
    self.speed = vehicle.speed;
  if(isDefined(vehicle.script_vehicletriggergroup))
    self.script_vehicletriggergroup = vehicle.script_vehicletriggergroup;
  if(isDefined(vehicle.script_cheap))
    self.script_cheap = vehicle.script_cheap;
  if(isDefined(vehicle.script_volume))
    self.script_volume = vehicle.script_volume;
  if(isDefined(vehicle.script_flak88))
    self.script_flak88 = vehicle.script_flak88;
  if(isDefined(vehicle.script_nonmovingvehicle))
    self.script_nonmovingvehicle = vehicle.script_nonmovingvehicle;
  if(isDefined(vehicle.script_flag))
    self.script_flag = vehicle.script_flag;
  if(isDefined(vehicle.script_disconnectpaths))
    self.script_disconnectpaths = vehicle.script_disconnectpaths;
  if(isDefined(vehicle.script_bulletshield))
    self.script_bulletshield = vehicle.script_bulletshield;
  if(isDefined(vehicle.script_volumeramp))
    self.script_volumeramp = vehicle.script_volumeramp;
  if(isDefined(vehicle.script_godmode))
    self.script_godmode = vehicle.script_godmode;
  if(isDefined(vehicle.script_vehicleattackgroup)) {
    self.script_vehicleattackgroup = vehicle.script_vehicleattackgroup;
  }
  if(isDefined(vehicle.script_vehicleattackgroupwait)) {
    self.script_vehicleattackgroupwait = vehicle.script_vehicleattackgroupwait;
  }
  if(isDefined(vehicle.script_friendname)) {
    self.script_friendname = vehicle.script_friendname;
  }
  if(vehicle.count > 0)
    self.count = vehicle.count;
  else
    self.count = 1;
  if(isDefined(vehicle.vehicletype))
    self.vehicletype = vehicle.vehicletype;
  else
    self.vehicletype = maps\_vehicletypes::get_type(vehicle.model);
  if(isDefined(vehicle.script_numbombs)) {
    self.script_numbombs = vehicle.script_numbombs;
  }
  vehicle delete();
  id = vehicle_spawnidgenerate(self.origin);
  self.spawner_id = id;
  level.vehicle_spawners[id] = self;
}

vehicle_spawnidgenerate(origin) {
  return "spawnid" + int(origin[0]) + "a" + int(origin[1]) + "a" + int(origin[2]);
}

vehicleDamageAssist() {
  self endon("death");
  self.attackers = [];
  self.attackerData = [];
  while (true) {
    self waittill("damage", amount, attacker);
    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }
    if(!isDefined(self.attackerData[attacker getEntityNumber()])) {
      self.attackers[self.attackers.size] = attacker;
      self.attackerData[attacker getEntityNumber()] = false;
    }
  }
}

vehicle_spawn(vspawner, from) {
  if(!vspawner.count)
    return;
  vehicle = spawnVehicle(vspawner.spawnermodel, vspawner.spawnedtargetname, vspawner.vehicletype, vspawner.origin, vspawner.angles);
  if(isDefined(vspawner.script_delay))
    vehicle.script_delay = vspawner.script_delay;
  if(isDefined(vspawner.script_noteworthy))
    vehicle.script_noteworthy = vspawner.script_noteworthy;
  if(isDefined(vspawner.script_parameters))
    vehicle.script_parameters = vspawner.script_parameters;
  if(isDefined(vspawner.script_team))
    vehicle.script_team = vspawner.script_team;
  if(isDefined(vspawner.script_vehicleride))
    vehicle.script_vehicleride = vspawner.script_vehicleride;
  if(isDefined(vspawner.target))
    vehicle.target = vspawner.target;
  if(isDefined(vspawner.vehicletype))
    vehicle.vehicletype = vspawner.vehicletype;
  if(isDefined(vspawner.triggeredthink))
    vehicle.triggeredthink = vspawner.triggeredthink;
  if(isDefined(vspawner.script_sound))
    vehicle.script_sound = vspawner.script_sound;
  if(isDefined(vspawner.script_turretmg))
    vehicle.script_turretmg = vspawner.script_turretmg;
  if(isDefined(vspawner.script_startinghealth))
    vehicle.script_startinghealth = vspawner.script_startinghealth;
  if(isDefined(vspawner.script_deathnotify))
    vehicle.script_deathnotify = vspawner.script_deathnotify;
  if(isDefined(vspawner.script_turret))
    vehicle.script_turret = vspawner.script_turret;
  if(isDefined(vspawner.script_linkTo))
    vehicle.script_linkTo = vspawner.script_linkTo;
  if(isDefined(vspawner.script_VehicleSpawngroup))
    vehicle.script_VehicleSpawngroup = vspawner.script_VehicleSpawngroup;
  if(isDefined(vspawner.script_VehicleStartMove))
    vehicle.script_VehicleStartMove = vspawner.script_VehicleStartMove;
  if(isDefined(vspawner.script_vehicleGroupDelete))
    vehicle.script_vehicleGroupDelete = vspawner.script_vehicleGroupDelete;
  if(isDefined(vspawner.script_vehicle_selfremove))
    vehicle.script_vehicle_selfremove = vspawner.script_vehicle_selfremove;
  if(isDefined(vspawner.script_nomg))
    vehicle.script_nomg = vspawner.script_nomg;
  if(isDefined(vspawner.script_badplace))
    vehicle.script_badplace = vspawner.script_badplace;
  if(isDefined(vspawner.script_vehicleride))
    vehicle.script_vehicleride = vspawner.script_vehicleride;
  if(isDefined(vspawner.script_vehiclewalk))
    vehicle.script_vehiclewalk = vspawner.script_vehiclewalk;
  if(isDefined(vspawner.script_linkName))
    vehicle.script_linkName = vspawner.script_linkName;
  if(isDefined(vspawner.script_crashtypeoverride))
    vehicle.script_crashtypeoverride = vspawner.script_crashtypeoverride;
  if(isDefined(vspawner.script_unloaddelay))
    vehicle.script_unloaddelay = vspawner.script_unloaddelay;
  if(isDefined(vspawner.script_unloadmgguy))
    vehicle.script_unloadmgguy = vspawner.script_unloadmgguy;
  if(isDefined(vspawner.script_keepdriver))
    vehicle.script_keepdriver = vspawner.script_keepdriver;
  if(isDefined(vspawner.script_fireondrones))
    vehicle.script_fireondrones = vspawner.script_fireondrones;
  if(isDefined(vspawner.script_tankgroup))
    vehicle.script_tankgroup = vspawner.script_tankgroup;
  if(isDefined(vspawner.script_avoidplayer))
    vehicle.script_avoidplayer = vspawner.script_avoidplayer;
  if(isDefined(vspawner.script_playerconeradius))
    vehicle.script_playerconeradius = vspawner.script_playerconeradius;
  if(isDefined(vspawner.script_cobratarget))
    vehicle.script_cobratarget = vspawner.script_cobratarget;
  if(isDefined(vspawner.script_targettype))
    vehicle.script_targettype = vspawner.script_targettype;
  if(isDefined(vspawner.script_targetoffset_z))
    vehicle.script_targetoffset_z = vspawner.script_targetoffset_z;
  if(isDefined(vspawner.script_wingman))
    vehicle.script_wingman = vspawner.script_wingman;
  if(isDefined(vspawner.script_mg_angle))
    vehicle.script_mg_angle = vspawner.script_mg_angle;
  if(isDefined(vspawner.script_physicsjolt))
    vehicle.script_physicsjolt = vspawner.script_physicsjolt;
  if(isDefined(vspawner.script_cheap))
    vehicle.script_cheap = vspawner.script_cheap;
  if(isDefined(vspawner.script_flag))
    vehicle.script_flag = vspawner.script_flag;
  if(isDefined(vspawner.script_vehicle_lights_on))
    vehicle.script_vehicle_lights_on = vspawner.script_vehicle_lights_on;
  if(isDefined(vspawner.script_vehicledetourgroup))
    vehicle.script_vehicledetourgroup = vspawner.script_vehicledetourgroup;
  if(isDefined(vspawner.speed))
    vehicle.speed = vspawner.speed;
  if(isDefined(vspawner.script_volume))
    vehicle.script_volume = vspawner.script_volume;
  if(isDefined(vspawner.script_light_toggle))
    vehicle.script_light_toggle = vspawner.script_light_toggle;
  if(isDefined(vspawner.spawner_id))
    vehicle.spawner_id = vspawner.spawner_id;
  if(isDefined(vspawner.script_vehicletriggergroup))
    vehicle.script_vehicletriggergroup = vspawner.script_vehicletriggergroup;
  if(isDefined(vspawner.script_disconnectpaths))
    vehicle.script_disconnectpaths = vspawner.script_disconnectpaths;
  if(isDefined(vspawner.script_godmode))
    vehicle.godmode = vspawner.script_godmode;
  if(isDefined(vspawner.script_bulletshield))
    vehicle.script_bulletshield = vspawner.script_bulletshield;
  if(isDefined(vspawner.script_volumeramp))
    vehicle.script_volumeramp = vspawner.script_volumeramp;
  if(isDefined(vspawner.script_numbombs)) {
    vehicle.script_numbombs = vspawner.script_numbombs;
  }
  if(isDefined(vspawner.script_flak88)) {
    vehicle.script_flak88 = vspawner.script_flak88;
  }
  if(isDefined(vspawner.script_flag)) {
    vehicle.script_flag = vspawner.script_flag;
  }
  if(isDefined(vspawner.script_nonmovingvehicle)) {
    vehicle.script_nonmovingvehicle = vspawner.script_nonmovingvehicle;
  }
  if(isDefined(vspawner.script_vehicleattackgroup)) {
    vehicle.script_vehicleattackgroup = vspawner.script_vehicleattackgroup;
  }
  if(isDefined(vspawner.script_vehicleattackgroupwait)) {
    vehicle.script_vehicleattackgroupwait = vspawner.script_vehicleattackgroupwait;
  }
  if(isDefined(vspawner.script_friendname)) {
    vehicle.script_friendname = vspawner.script_friendname;
  }
  vehicle_init(vehicle);
  if(isDefined(vehicle.targetname))
    level notify("new_vehicle_spawned" + vehicle.targetname, vehicle);
  if(isDefined(vehicle.script_noteworthy))
    level notify("new_vehicle_spawned" + vehicle.script_noteworthy, vehicle);
  if(isDefined(vehicle.spawner_id))
    level notify("new_vehicle_spawned" + vehicle.spawner_id, vehicle);
  if(vehicle.script_team == "axis" && isDefined(level.vehicle_enemy_tanks[vspawner.spawnermodel])) {
    vehicle thread vehicleDamageAssist();
  }
  return vehicle;
}

waittill_vehiclespawn(targetname) {
  level waittill("new_vehicle_spawned" + targetname, vehicle);
  return vehicle;
}

waittill_vehiclespawn_noteworthy(noteworthy) {
  level waittill("new_vehicle_spawned" + noteworthy, vehicle);
  return vehicle;
}

waittill_vehiclespawn_spawner_id(spawner_id) {
  level waittill("new_vehicle_spawned" + spawner_id, vehicle);
  return vehicle;
}

wait_vehiclespawn(targetname) {
  println("wait_vehiclespawn() called; change to waittill_vehiclespawn()");
  level waittill("new_vehicle_spawned" + targetname, vehicle);
  return vehicle;
}

spawn_through(vehicle) {
  struct = spawnstruct();
  structsetspawnervariables(vehicle);
  return vehicle_spawn(struct);
}

vehicle_init(vehicle) {
  if(vehicle.classname == "script_model") {
    vehicle = spawn_through(vehicle);
    return;
  }
  if(vehicle.vehicletype == "bog_mortar")
    return;
  if((isDefined(vehicle.script_noteworthy)) && (vehicle.script_noteworthy == "playervehicle"))
    return;
  vehicle.zerospeed = true;
  if(!isDefined(vehicle.modeldummyon))
    vehicle.modeldummyon = false;
  type = vehicle.vehicletype;
  vehicle vehicle_life();
  vehicle vehicle_setteam();
  if(!isDefined(level.vehicleInitThread[vehicle.vehicletype][vehicle.model])) {
    println("vehicle.vehicletype is: " + vehicle.vehicletype);
    println("vehicle.model is: " + vehicle.model);
  }
  vehicle thread[[level.vehicleInitThread[vehicle.vehicletype][vehicle.model]]]();
  vehicle thread maingun_FX();
  if(!isDefined(vehicle.script_avoidplayer))
    vehicle.script_avoidplayer = false;
  vehicle.riders = [];
  vehicle.unloadque = [];
  vehicle.unload_group = "default";
  vehicle.getoutrig = [];
  if(isDefined(level.vehicle_attachedmodels) && isDefined(level.vehicle_attachedmodels[type])) {
    rigs = level.vehicle_attachedmodels[type];
    strings = getarraykeys(rigs);
    for (i = 0; i < strings.size; i++) {
      vehicle.getoutrig[strings[i]] = undefined;
      vehicle.getoutriganimating[strings[i]] = false;
    }
  }
  vehicle thread vehicle_badplace();
  if(isDefined(vehicle.script_vehicle_lights_on))
    vehicle thread lights_on(vehicle.script_vehicle_lights_on);
  if(!vehicle isCheap())
    vehicle thread friendlyfire_shield();
  vehicle thread maps\_vehicle_aianim::handle_attached_guys();
  if(!vehicle isCheap())
    vehicle thread vehicle_handleunloadevent();
  vehicle thread turret_attack_think();
  if(!vehicle isCheap())
    vehicle thread vehicle_weapon_fired();
  vehicle thread vehicle_rumble();
  if(isDefined(vehicle.script_physicsjolt) && vehicle.script_physicsjolt)
    vehicle thread physicsjolt_proximity();
  vehicle_Levelstuff(vehicle);
  if(isDefined(vehicle.script_team))
    vehicle setvehicleteam(vehicle.script_team);
  vehicle thread vehicle_compasshandle();
  vehicle thread animate_drive_idle();
  if(!vehicle isCheap())
    vehicle thread mginit();
  if(isDefined(level.vehicleSpawnCallbackThread))
    level thread[[level.vehicleSpawnCallbackThread]](vehicle);
  if(isDefined(vehicle.spawnflags) && vehicle.spawnflags & 1) {
    startinvehicle = (isDefined(vehicle.script_noteworthy) && vehicle.script_noteworthy == "startinside");
    vehicle maps\_vehicledrive::setup_vehicle_other();
    vehicle thread maps\_vehicledrive::vehicle_wait(startinvehicle);
    vehicle thread kill();
    return;
  }
  if(!vehicle isCheap())
    vehicle thread disconnect_paths_whenstopped();
  if(!isDefined(vehicle.script_flak88) && !isDefined(vehicle.script_nonmovingvehicle)) {
    vehicle thread getonpath();
  }
  if(isDefined(vehicle.script_vehicleattackgroup)) {
    vehicle thread attackgroup_think();
  }
  if(vehicle hasHelicopterDustKickup()) {
    if(!level.clientscripts) {
      vehicle thread aircraft_dust_kickup();
    }
  }
  vehicle thread debug_vehicle();
  vehicle spawn_group();
  vehicle thread kill();
  if(!isDefined(vehicle.script_volume))
    vehicle thread init_ramp_volume();
  vehicle apply_truckjunk();
}

init_ramp_volume() {
  time = 2;
  if(self is_aircraft())
    time = 1;
  if(isDefined(self.script_volumeramp))
    time = self.script_volumeramp;
  self volume_up(time);
}

kill_damage(type) {
  if(!isDefined(level.vehicle_death_radiusdamage) || !isDefined(level.vehicle_death_radiusdamage[type]))
    return;
  if(isDefined(self.deathdamage_max))
    maxdamage = self.deathdamage_max;
  else
    maxdamage = level.vehicle_death_radiusdamage[type].maxdamage;
  if(isDefined(self.deathdamage_min))
    mindamage = self.deathdamage_min;
  else
    mindamage = level.vehicle_death_radiusdamage[type].mindamage;
  if(isDefined(level.vehicle_death_radiusdamage[type].delay))
    wait level.vehicle_death_radiusdamage[type].delay;
  if(!isDefined(self))
    return;
  if(level.vehicle_death_radiusdamage[type].bKillplayer) {
    players = get_players();
    for (i = 0; i < players.size; i++) {
      players[i] enableHealthShield(false);
    }
  }
  radiusDamage(self.origin + level.vehicle_death_radiusdamage[type].offset, level.vehicle_death_radiusdamage[type].range, maxdamage, mindamage);
  if(level.vehicle_death_radiusdamage[type].bKillplayer) {
    players = get_players();
    for (i = 0; i < players.size; i++) {
      players[i] enableHealthShield(true);
    }
  }
}

vehicle_is_tank() {
  return self.vehicletype == "sherman" ||
    self.vehicletype == "panzer4" ||
    self.vehicletype == "type97" ||
    self.vehicletype == "t34" ||
    self.vehicletype == "see2_panzeriv" ||
    self.vehicletype == "see2_tiger" ||
    self.vehicletype == "see2_ot34" ||
    self.vehicletype == "see2_t34" ||
    self.vehicletype == "see2_panther" ||
    self.vehicletype == "tiger" ||
    self.vehicletype == "see2_physics_t34";
}

kill() {
  self endon("nodeath_thread");
  type = self.vehicletype;
  model = self.model;
  targetname = self.targetname;
  attacker = undefined;
  arcadeModePointsRewarded = false;
  while (1) {
    if(isDefined(self)) {
      self waittill("death", attacker);
    }
    if(arcadeMode() && false == arcadeModePointsRewarded) {
      if(self.script_team != "allies") {
        if(isDefined(self.attackers)) {
          for (i = 0; i < self.attackers.size; i++) {
            player = self.attackers[i];
            if(!isDefined(player))
              continue;
            if(player == attacker)
              continue;
            maps\_challenges_coop::doMissionCallback("playerAssist", player);
            player.assists++;
            arcademode_assignpoints("arcademode_score_tankassist", player);
          }
          self.attackers = [];
          self.attackerData = [];
        }
        if(IsPlayer(attacker)) {
          arcademode_assignpoints("arcademode_score_tank", attacker);
          attacker.kills++;
        }
      } else {
        arcademode_assignpoints("arcademode_score_tank_friendly", attacker);
      }
      arcadeModePointsRewarded = true;
    }
    if(isDefined(self.rumbletrigger)) {
      self.rumbletrigger delete();
    }
    if(isDefined(self.mgturret)) {
      array_levelthread(self.mgturret, ::turret_deleteme);
      self.mgturret = undefined;
    }
    if(isDefined(self.script_team)) {
      level.vehicles[self.script_team] = array_remove(level.vehicles[self.script_team], self);
    }
    if(isDefined(self.script_linkname)) {
      level.vehicle_link[self.script_linkname] = array_remove(level.vehicle_link[self.script_linkname], self);
    }
    if(isDefined(targetname)) {
      level.vehicle_target[targetname] = array_remove(level.vehicle_target[targetname], self);
    }
    if(isDefined(self.script_VehicleSpawngroup)) {
      level.vehicle_SpawnGroup[self.script_VehicleSpawngroup] = array_remove(level.vehicle_SpawnGroup[self.script_VehicleSpawngroup], self);
    }
    if(isDefined(self.script_VehicleStartMove)) {
      level.vehicle_StartMoveGroup[self.script_VehicleStartMove] = array_remove(level.vehicle_StartMoveGroup[self.script_VehicleStartMove], self);
    }
    if(isDefined(self.script_vehicleGroupDelete)) {
      level.vehicle_DeleteGroup[self.script_vehicleGroupDelete] = array_remove(level.vehicle_DeleteGroup[self.script_vehicleGroupDelete], self);
    }
    thread lights_kill();
    if(!isDefined(self) || is_corpse()) {
      if(isDefined(self.riders)) {
        for (j = 0; j < self.riders.size; j++) {
          if(isDefined(self.riders[j])) {
            self.riders[j] delete();
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
    if(isDefined(level.vehicle_rumble[type])) {
      self StopRumble(level.vehicle_rumble[type].rumble);
    }
    if(isDefined(level.vehicle_death_thread[type])) {
      thread[[level.vehicle_death_thread[type]]]();
    }
    if(!isDefined(self.destructibledef)) {
      if(isDefined(level.vehicle_death_earthquake[type])) {
        earthquake(
          level.vehicle_death_earthquake[type].scale,
          level.vehicle_death_earthquake[type].duration,
          self.origin,
          level.vehicle_death_earthquake[type].radius
        );
      }
      thread kill_damage(type);
      if(isDefined(level.vehicle_deathmodel[model])) {
        self thread set_death_model(level.vehicle_deathmodel[model], level.vehicle_deathmodel_delay[model]);
      }
      if((!isDefined(self.mantled) || !self.mantled) && !isDefined(self.nodeathfx)) {
        thread kill_fx(model);
      }
      if(isDefined(self.delete_on_death)) {
        wait(0.05);
        if(!isDefined(self))
          continue;
        if(!isDefined(self.dontDisconnectPaths)) {
          self disconnectpaths();
        }
        self freevehicle();
        wait 0.05;
        if(!isDefined(self))
          continue;
        self notify("death_finished");
        self delete();
        continue;
      }
    }
    maps\_vehicle_aianim::blowup_riders();
    thread kill_badplace(type);
    if(isDefined(level.vehicle_deathnotify) && isDefined(level.vehicle_deathnotify[self.vehicletype])) {
      level notify(level.vehicle_deathnotify[self.vehicletype], attacker);
    }
    if(self.classname == "script_vehicle") {
      self thread kill_jolt(type);
    }
    if(!isDefined(self.destructibledef)) {
      if(isDefined(self.script_crashtypeoverride)) {
        crashtype = self.script_crashtypeoverride;
      } else if(self is_aircraft()) {
        crashtype = "aircraft";
      } else if(isDefined(self.currentnode) && crash_path_check(self.currentnode)) {
        crashtype = "none";
      } else {
        crashtype = "tank";
      }
      if(crashtype == "aircraft") {
        self thread aircraft_crash();
      }
      if(crashtype == "tank") {
        if(!isDefined(self.rollingdeath)) {
          self vehicle_setspeed(0, 25, "Dead");
        } else {
          self waittill("deathrolloff");
          self vehicle_setspeed(0, 25, "Dead, finished path intersection");
        }
        wait .4;
        self vehicle_setspeed(0, 10000, "deadstop");
        self notify("deadstop");
        if(!isDefined(self.dontDisconnectPaths)) {
          self disconnectpaths();
        }
        if((isDefined(self.tankgetout)) && (self.tankgetout > 0)) {
          self waittill("animsdone");
        }
      }
    }
    if(isDefined(level.vehicle_hasMainTurret[model]) && level.vehicle_hasMainTurret[model]) {
      self clearTurretTarget();
    }
    if(self is_aircraft() || self is_boat()) {
      if((isDefined(self.crashing)) && (self.crashing == true)) {
        self waittill("crash_done");
      }
    } else {
      while (isDefined(self) && self getspeedmph() > 0) {
        wait(0.1);
      }
    }
    self notify("stop_looping_death_fx");
    self notify("death_finished");
    wait(0.5);
    if(is_corpse()) {
      continue;
    }
    if(isDefined(self)) {
      while (isDefined(self.dontfreeme) && isDefined(self)) {
        wait(.05);
      }
      if(!isDefined(self)) {
        continue;
      }
      self freevehicle();
      if(self.modeldummyon) {
        self hide();
      }
    }
    if((isDefined(self.crashing)) && (self.crashing == true)) {
      self delete();
      continue;
    }
  }
}

is_corpse() {
  is_corpse = false;
  if(isDefined(self) && self.classname == "script_vehicle_corpse")
    is_corpse = true;
  return is_corpse;
}

set_death_model(sModel, fDelay) {
  assert(isDefined(sModel));
  if(isDefined(fDelay) && (fDelay > 0))
    wait fDelay;
  if(!isDefined(self))
    return;
  eModel = get_dummy();
  if(isDefined(self.clear_anims_on_death))
    eModel clearanim( % root, 0);
  if(isDefined(self))
    eModel setmodel(sModel);
}

aircraft_crash() {
  self.crashing = true;
  if(isDefined(self.unloading)) {
    while (isDefined(self.unloading)) {
      wait(0.05);
    }
  }
  if(!isDefined(self)) {
    return;
  }
  self thread aircraft_crash_move();
}

_hasweapon(weapon) {
  weapons = self getweaponslist();
  for (i = 0; i < weapons.size; i++) {
    if(issubstr(weapons[i], weapon))
      return true;
  }
  return false;
}

get_unused_crash_locations() {
  unusedLocations = [];
  for (i = 0; i < level.helicopter_crash_locations.size; i++) {
    if(isDefined(level.helicopter_crash_locations[i].claimed))
      continue;
    unusedLocations[unusedLocations.size] = level.helicopter_crash_locations[i];
  }
  return unusedLocations;
}

detach_getoutrigs() {
  if(!isDefined(self.getoutrig))
    return;
  if(!self.getoutrig.size)
    return;
  keys = getarraykeys(self.getoutrig);
  for (i = 0; i < keys.size; i++) {
    self.getoutrig[keys[i]] unlink();
  }
}

aircraft_crash_move() {
  self endon("death");
  forward = AnglesToForward(self.angles + (45, 0, 0));
  dest_point = self.origin + vector_multiply(forward, 10000);
  dest_point = (dest_point[0], dest_point[1], -700);
  self SetSpeed(300, 30);
  self SetNearGoalNotifyDist(300);
  self SetVehGoalPos(dest_point, 1);
  self waittill_any("goal", "near_goal");
  self notify("crash_done");
}

crash_path_check(node) {
  targ = node;
  while (isDefined(targ)) {
    if((isDefined(targ.detoured)) && (targ.detoured == 0)) {
      detourpath = path_detour_get_detourpath(getvehiclenode(targ.target, "targetname"));
      if(isDefined(detourpath) && isDefined(detourpath.script_crashtype))
        return true;
    }
    if(isDefined(targ.target)) {
      targ1 = getvehiclenode(targ.target, "targetname");
      if(isDefined(targ1) && isDefined(targ1.target) && isDefined(targ.targetname) && targ1.target == targ.targetname) {
        return false;
      } else {
        targ = targ1;
      }
    } else
      targ = undefined;
  }
  return false;
}

death_firesound(sound) {
  self thread play_loop_sound_on_tag(sound, undefined, false);
  self waittill_any("fire_extinguish", "stop_crash_loop_sound");
  if(!isDefined(self))
    return;
  self notify("stop sound" + sound);
}

kill_fx(model) {
  if(self isdestructible())
    return;
  level notify("vehicle_explosion", self.origin);
  self notify("explode");
  type = self.vehicletype;
  for (i = 0; i < level.vehicle_death_fx[type].size; i++) {
    struct = level.vehicle_death_fx[type][i];
    thread kill_fx_thread(model, struct, type);
  }
}

vehicle_flag_arrived(msg) {
  if(!isDefined(self.vehicle_flags)) {
    self.vehicle_flags = [];
  }
  while (!isDefined(self.vehicle_flags[msg])) {
    self waittill("vehicle_flag_arrived", notifymsg);
    if(msg == notifymsg)
      return;
  }
}

kill_fx_thread(model, struct, type) {
  assert(isDefined(struct));
  if(isDefined(struct.waitDelay)) {
    if(struct.waitDelay >= 0)
      wait struct.waitDelay;
    else
      self waittill("death_finished");
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(struct.notifyString))
    self notify(struct.notifyString);
  eModel = get_dummy();
  if(isDefined(struct.effect)) {
    if((struct.bEffectLooping) && (!isDefined(self.delete_on_death))) {
      if(isDefined(struct.tag)) {
        if((isDefined(struct.stayontag)) && (struct.stayontag == true))
          thread loop_fx_on_vehicle_tag(struct.effect, struct.delay, struct.tag);
        else
          thread playLoopedFxontag(struct.effect, struct.delay, struct.tag);
      } else {
        forward = (eModel.origin + (0, 0, 100)) - eModel.origin;
        playfx(struct.effect, eModel.origin, forward);
      }
    } else if(isDefined(struct.tag))
      playfxontag(struct.effect, deathfx_ent(), struct.tag);
    else {
      forward = (eModel.origin + (0, 0, 100)) - eModel.origin;
      playfx(struct.effect, eModel.origin, forward);
    }
  }
  if((isDefined(struct.sound)) && (!isDefined(self.delete_on_death))) {
    if(struct.bSoundlooping)
      thread death_firesound(struct.sound);
    else
      self play_sound_in_space(struct.sound);
  }
}

loop_fx_on_vehicle_tag(effect, loopTime, tag) {
  assert(isDefined(effect));
  assert(isDefined(tag));
  assert(isDefined(loopTime));
  self endon("stop_looping_death_fx");
  while (isDefined(self)) {
    playfxontag(effect, deathfx_ent(), tag);
    wait loopTime;
  }
}

build_radiusdamage(offset, range, maxdamage, mindamage, bKillplayer, delay) {
  if(!isDefined(level.vehicle_death_radiusdamage))
    level.vehicle_death_radiusdamage = [];
  if(!isDefined(bKillplayer))
    bKillplayer = false;
  if(!isDefined(offset))
    offset = (0, 0, 0);
  struct = spawnstruct();
  struct.offset = offset;
  struct.range = range;
  struct.maxdamage = maxdamage;
  struct.mindamage = mindamage;
  struct.bKillplayer = bKillplayer;
  struct.delay = delay;
  level.vehicle_death_radiusdamage[level.vttype] = struct;
}

build_rumble(rumble, scale, duration, radius, basetime, randomaditionaltime) {
  if(!isDefined(level.vehicle_rumble))
    level.vehicle_rumble = [];
  struct = build_quake(scale, duration, radius, basetime, randomaditionaltime);
  assert(isDefined(rumble));
  precacherumble(rumble);
  struct.rumble = rumble;
  level.vehicle_rumble[level.vttype] = struct;
}

build_deathquake(scale, duration, radius) {
  if(!isDefined(level.vehicle_death_earthquake))
    level.vehicle_death_earthquake = [];
  level.vehicle_death_earthquake[level.vttype] = build_quake(scale, duration, radius);
}

build_quake(scale, duration, radius, basetime, randomaditionaltime) {
  struct = spawnstruct();
  struct.scale = scale;
  struct.duration = duration;
  struct.radius = radius;
  if(isDefined(basetime))
    struct.basetime = basetime;
  if(isDefined(randomaditionaltime))
    struct.randomaditionaltime = randomaditionaltime;
  return struct;
}

build_fx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString) {
  if(!isDefined(bSoundlooping))
    bSoundlooping = false;
  if(!isDefined(bEffectLooping))
    bEffectLooping = false;
  if(!isDefined(delay))
    delay = 1;
  struct = spawnstruct();
  struct.effect = loadfx(effect);
  struct.tag = tag;
  struct.sound = sound;
  struct.bSoundlooping = bSoundlooping;
  struct.delay = delay;
  struct.waitDelay = waitDelay;
  struct.stayontag = stayontag;
  struct.notifyString = notifyString;
  struct.bEffectLooping = bEffectLooping;
  return struct;
}

build_deathfx_override(type, effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString) {
  level.vttype = type;
  level.vehicle_death_fx_override[type] = true;
  if(!isDefined(level.vehicle_death_fx))
    level.vehicle_death_fx = [];
  build_deathfx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, true);
}

build_deathfx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, bOverride) {
  if(!isDefined(bOverride))
    bOverride = false;
  assertEx(isDefined(effect), "Failed to build death effect because there is no effect specified for the model used for that vehicle.");
  type = level.vttype;
  if(
    isDefined(level.vehicle_death_fx_override) &&
    isDefined(level.vehicle_death_fx_override[type]) &&
    level.vehicle_death_fx_override[type] &&
    !bOverride
  )
    return;
  if(!isDefined(level.vehicle_death_fx[type]))
    level.vehicle_death_fx[type] = [];
  level.vehicle_death_fx[type][level.vehicle_death_fx[type].size] = build_fx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString);
}

get_script_modelvehicles() {
  array = [];
  models = getentarray("script_model", "classname");
  if(isDefined(level.modelvehicles))
    return level.modelvehicles;
  level.modelvehicles = [];
  for (i = 0; i < models.size; i++) {
    if(isDefined(models[i].targetname) &&
      (models[i].targetname == "destructible" ||
        models[i].targetname == "zpu" ||
        models[i].targetname == "exploder")
    )
      continue;
    if(isDefined(models[i].script_noteworthy) && models[i].script_noteworthy == "notvehicle")
      continue;
    if(maps\_vehicletypes::is_type(models[i].model)) {
      array[array.size] = models[i];
      models[i].vehicletype = maps\_vehicletypes::get_type(models[i].model);
    }
  }
  level.modelvehicles = array;
  return level.modelvehicles;
}

precache_scripts() {
  allvehiclesprespawn = [];
  vehicles = getentarray("script_vehicle", "classname");
  vehicles = array_combine(vehicles, get_script_modelvehicles());
  level.needsprecaching = [];
  playerdrivablevehicles = [];
  allvehiclesprespawn = [];
  if(!isDefined(level.vehicleInitThread))
    level.vehicleInitThread = [];
  for (i = 0; i < vehicles.size; i++) {
    vehicles[i].vehicletype = tolower(vehicles[i].vehicletype);
    if(vehicles[i].vehicletype == "bog_mortar")
      continue;
    if(isDefined(vehicles[i].spawnflags) && vehicles[i].spawnflags & 1)
      playerdrivablevehicles[playerdrivablevehicles.size] = vehicles[i];
    allvehiclesprespawn[allvehiclesprespawn.size] = vehicles[i];
    if(!isDefined(level.vehicleInitThread[vehicles[i].vehicletype]))
      level.vehicleInitThread[vehicles[i].vehicletype] = [];
    loadstring = "maps\\\_" + vehicles[i].vehicletype + "::main( \"" + vehicles[i].model + "\" );";
    if(level.bScriptgened)
      script_gen_dump_addline(loadstring, vehicles[i].model);
    precachesetup(loadstring, vehicles[i]);
  }
  if(!level.bScriptgened && level.needsprecaching.size > 0) {
    println(" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
    println(" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
    println(" -- -- - add these lines to your level script above maps\\\_load::main(); -- -- -- -- -- -- - ");
    for (i = 0; i < level.needsprecaching.size; i++)
      println(level.needsprecaching[i]);
    println(" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
    println(" -- -- -- -- -- -- -- -- -- -- -- -- - hint copy paste them from console.log -- -- -- -- -- -- -- -- -- -- ");
    println(" -- -- if it already exists then check for unmatching vehicletypes in your map -- -- -- ");
    println(" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
  }
  if(playerdrivablevehicles.size > 0)
    thread maps\_vehicledrive::main();
  return allvehiclesprespawn;
}

precachesetup(string, vehicle) {
  if(isDefined(level.vehicleInitThread[vehicle.vehicletype][vehicle.model]))
    return;
  matched = false;
  for (i = 0; i < level.needsprecaching.size; i++)
    if(level.needsprecaching[i] == string)
      matched = true;
  if(!matched)
    level.needsprecaching[level.needsprecaching.size] = string;
}

vehicle_modelinarray(arrayofmodels, model) {
  for (i = 0; i < arrayofmodels.size; i++)
    if(arrayofmodels[i] == model)
      return true;
  return false;
}

vehicle_kill_disconnect_paths_forever() {
  self notify("kill_disconnect_paths_forever");
}

disconnect_paths_whenstopped() {
  self endon("death");
  self endon("kill_disconnect_paths_forever");
  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    self.dontDisconnectPaths = true;
    return;
  }
  wait(randomfloat(1));
  while (isDefined(self)) {
    if(self getspeed() < 1) {
      if(!isDefined(self.dontDisconnectPaths))
        self disconnectpaths();
      self notify("speed_zero_path_disconnect");
      while (self getspeed() < 1)
        wait .05;
    }
    self connectpaths();
    wait 1;
  }
}

vehicle_setspeed(speed, rate, msg) {
  if(self getspeedmph() == 0 && speed == 0)
    return;
  self thread debug_vehiclesetspeed(speed, rate, msg);
  self setspeed(speed, rate);
}

debug_vehiclesetspeed(speed, rate, msg) {
  self notify("new debug_vehiclesetspeed");
  self endon("new debug_vehiclesetspeed");
  self endon("resuming speed");
  self endon("death");
  while (1) {
    while (getdvar("debug_vehiclesetspeed") != "off") {
      print3d(self.origin + (0, 0, 192), "vehicle setspeed: " + msg, (1, 1, 1), 1, 3);
      wait .05;
    }
    wait .5;
  }
}

script_resumespeed(msg, rate) {
  self endon("death");
  fSetspeed = 0;
  type = "resumespeed";
  if(!isDefined(self.resumemsgs))
    self.resumemsgs = [];
  if(isDefined(self.waitingforgate) && self.waitingforgate)
    return;
  if(isDefined(self.attacking)) {
    if(self.attacking) {
      fSetspeed = self.attackspeed;
      type = "setspeed";
    }
  }
  self.zerospeed = false;
  if(fSetspeed == 0)
    self.zerospeed = true;
  if(type == "resumespeed")
    self resumespeed(rate);
  else if(type == "setspeed")
    self vehicle_setspeed(fSetspeed, 15, "resume setspeed from attack");
  self notify("resuming speed");
  self thread debug_vehicleresume(msg + " :" + type);
}

debug_vehicleresume(msg) {
  if(getdvar("debug_vehicleresume") == "off")
    return;
  self endon("death");
  number = self.resumemsgs.size;
  self.resumemsgs[number] = msg;
  timer = 3;
  self thread print_resumespeed(gettime() + (timer * 1000));
  wait timer;
  newarray = [];
  for (i = 0; i < self.resumemsgs.size; i++) {
    if(i != number)
      newarray[newarray.size] = self.resumemsgs[i];
  }
  self.resumemsgs = newarray;
}

print_resumespeed(timer) {
  self notify("newresumespeedmsag");
  self endon("newresumespeedmsag");
  self endon("death");
  while (gettime() < timer && isDefined(self.resumemsgs)) {
    if(self.resumemsgs.size > 6)
      start = self.resumemsgs.size - 5;
    else
      start = 0;
    for (i = start; i < self.resumemsgs.size; i++) {
      position = i * 32;
      print3d(self.origin + (0, 0, position), "resuming speed: " + self.resumemsgs[i], (0, 1, 0), 1, 3);
    }
    wait .05;
  }
}
vclogin_vehicles() {
  if(getdvar("vclogin_vehicles") == "off")
    return;
  precachemodel("vehicle_blackhawk");
  level.vclogin_vehicles = 1;
  vehicles = getentarray("script_vehicle", "classname");
  for (i = 0; i < vehicles.size; i++)
    vehicles[i] delete();
  paths = getallvehiclenodes();
  for (i = 0; i < paths.size; i++) {
    if(!(isDefined(paths[i].spawnflags) && (paths[i].spawnflags & 1)))
      continue;
    crashtype = paths[i].script_crashtype;
    if(!isDefined(crashtype))
      crashtype = "default";
    if(crashtype == "plane")
      vehicle = spawnVehicle("vehicle_blackhawk", "vclogger", "blackhawk", (0, 0, 0), (0, 0, 0));
    else
      vehicle = spawnVehicle("vehicle_blackhawk", "vclogger", "blackhawk", (0, 0, 0), (0, 0, 0));
    vehicle attachpath(paths[i]);
    if(isDefined(vehicle.model) && vehicle.model == "vehicle_blackhawk") {
      tagorg = vehicle gettagorigin("tag_bigbomb");
      get_players()[0] setorigin(tagorg);
      get_players()[0] playerLinkTodelta(vehicle, "tag_bigbomb", 1.0);
    } else {
      tagorg = vehicle gettagorigin("tag_player");
      get_players()[0] setorigin(tagorg);
      get_players()[0] playerLinkToDelta(vehicle, "tag_player", 0.1);
    }
    vehicle startpath();
    vehicle.zerospeed = false;
    vehicle waittill("reached_end_node");
    get_players()[0] unlink();
    vehicle delete();
    crashtype = undefined;
  }
  level waittill("never");
}

godon() {
  self.godmode = true;
}
godoff() {
  self.godmode = false;
}

setturretfireondrones(b) {
  if(isDefined(self.mgturret) && self.mgturret.size)
    for (i = 0; i < self.mgturret.size; i++)
      self.mgturret[i].script_fireondrones = b;
}

getnormalanimtime(animation) {
  animtime = self getanimtime(animation);
  animlength = getanimlength(animation);
  if(animtime == 0)
    return 0;
  return self getanimtime(animation) / getanimlength(animation);
}

rotor_anim() {
  length = getanimlength(self getanim("rotors"));
  for (;;) {
    self setanim(self getanim("rotors"), 1, 0, 1);
    wait(length);
  }
}

animate_drive_idle() {
  if(!isDefined(self.wheeldir))
    self.wheeldir = 1;
  model = self.model;
  newanimtime = undefined;
  self UseAnimTree(#animtree);
  if(!isDefined(level.vehicle_DriveIdle[model]))
    return;
  if(!isDefined(level.vehicle_DriveIdle_r[model]))
    level.vehicle_DriveIdle_r[model] = level.vehicle_DriveIdle[model];
  self endon("death");
  normalspeed = level.vehicle_DriveIdle_normal_speed[model];
  thread animate_drive_idle_death();
  animrate = 1.0;
  if((isDefined(level.vehicle_DriveIdle_animrate)) && (isDefined(level.vehicle_DriveIdle_animrate[model])))
    animrate = level.vehicle_DriveIdle_animrate[model];
  lastdir = self.wheeldir;
  animatemodel = self;
  animation = level.vehicle_DriveIdle[model];
  while (1) {
    if(!normalspeed) {
      animatemodel setanim(level.vehicle_DriveIdle[model], 1, .2, animrate);
      thread animtimer(.5);
      self waittill("animtimer");
      continue;
    }
    speed = self getspeedmph();
    if(lastdir != self.wheeldir) {
      dif = 0;
      if(self.wheeldir) {
        animation = level.vehicle_DriveIdle[model];
        dif = 1 - animatemodel getnormalanimtime(level.vehicle_DriveIdle_r[model]);
        animatemodel clearanim(level.vehicle_DriveIdle_r[model], 0);
      } else {
        animation = level.vehicle_DriveIdle_r[model];
        dif = 1 - animatemodel getnormalanimtime(level.vehicle_DriveIdle[model]);
        animatemodel clearanim(level.vehicle_DriveIdle[model], 0);
      }
      newanimtime = 0.01;
      if(newanimtime >= 1 || newanimtime == 0)
        newanimtime = 0.01;
      lastdir = self.wheeldir;
    }
    if(speed == 0)
      animatemodel setanim(animation, 1, .2, 0);
    else
      animatemodel setanim(animation, 1, .2, speed / normalspeed);
    if(isDefined(newanimtime)) {
      animatemodel setanimtime(animation, newanimtime);
      newanimtime = undefined;
    }
    thread animtimer(.2);
    self waittill("animtimer");
  }
}

animtimer(time) {
  self endon("animtimer");
  wait time;
  self notify("animtimer");
}

animate_drive_idle_death() {
  model = self.model;
  self UseAnimTree(#animtree);
  self waittill("death_finished");
  if(isDefined(self))
    self clearanim(level.vehicle_DriveIdle[model], 0);
}

setup_dynamic_detour(pathnode, get_func) {
  prevnode = [[get_func]](pathnode.targetname);
  assertex(isDefined(prevnode), "detour can't be on start node");
  prevnode.detoured = 0;
}

setup_ai() {
  ai = getaiarray();
  for (i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_vehicleride))
      level.vehicle_RideAI = array_2dadd(level.vehicle_RideAI, ai[i].script_vehicleride, ai[i]);
    else
    if(isDefined(ai[i].script_vehiclewalk))
      level.vehicle_WalkAI = array_2dadd(level.vehicle_WalkAI, ai[i].script_vehiclewalk, ai[i]);
  }
  ai = getspawnerarray();
  for (i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_vehicleride))
      level.vehicle_RideSpawners = array_2dadd(level.vehicle_RideSpawners, ai[i].script_vehicleride, ai[i]);
    if(isDefined(ai[i].script_vehiclewalk))
      level.vehicle_walkspawners = array_2dadd(level.vehicle_walkspawners, ai[i].script_vehiclewalk, ai[i]);
  }
}

array_2dadd(array, firstelem, newelem) {
  if(!isDefined(array[firstelem]))
    array[firstelem] = [];
  array[firstelem][array[firstelem].size] = newelem;
  return array;
}

is_node_script_origin(pathnode) {
  return isDefined(pathnode.classname) && pathnode.classname == "script_origin";
}

node_trigger_process() {
  processtrigger = false;
  if(isDefined(self.spawnflags) && (self.spawnflags & 1)) {
    if(isDefined(self.script_crashtype))
      level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;
    level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
  }
  if(isDefined(self.script_vehicledetour) && isDefined(self.targetname)) {
    get_func = undefined;
    if(isDefined(get_from_entity(self.targetname)))
      get_func = ::get_from_entity_target;
    if(isDefined(get_from_spawnstruct(self.targetname)))
      get_func = ::get_from_spawnstruct_target;
    if(isDefined(get_func)) {
      setup_dynamic_detour(self, get_func);
      processtrigger = true;
    } else {
      setup_groundnode_detour(self);
    }
    level.vehicle_detourpaths = array_2dadd(level.vehicle_detourpaths, self.script_vehicledetour, self);
    if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2)
      println("more than two script_vehicledetour grouped in group number: ", self.script_vehicledetour);
  }
  if(isDefined(self.script_gatetrigger)) {
    level.vehicle_gatetrigger = array_2dadd(level.vehicle_gatetrigger, self.script_gatetrigger, self);
    self.gateopen = false;
  }
  if(isDefined(self.script_flag_set)) {
    if(!isDefined(level.flag[self.script_flag_set]))
      flag_init(self.script_flag_set);
  }
  if(isDefined(self.script_flag_clear)) {
    if(!isDefined(level.flag[self.script_flag_clear]))
      flag_init(self.script_flag_clear);
  }
  if(isDefined(self.script_flag_wait)) {
    if(!isDefined(level.flag[self.script_flag_wait]))
      flag_init(self.script_flag_wait);
  }
  if(
    isDefined(self.script_VehicleSpawngroup) ||
    isDefined(self.script_VehicleStartMove) ||
    isDefined(self.script_gatetrigger) ||
    isDefined(self.script_Vehiclegroupdelete)
  )
    processtrigger = true;
  if(processtrigger)
    add_proccess_trigger(self);
}

setup_triggers() {
  level.vehicle_processtriggers = [];
  triggers = [];
  triggers = array_combine(getallvehiclenodes(), getentarray("script_origin", "classname"));
  triggers = array_combine(triggers, level.struct);
  triggers = array_combine(triggers, getentarray("trigger_radius", "classname"));
  triggers = array_combine(triggers, getentarray("trigger_multiple", "classname"));
  triggers = array_combine(triggers, getentarray("trigger_lookat", "classname"));
  array_thread(triggers, ::node_trigger_process);
}

is_node_script_struct(node) {
  if(!isDefined(node.targetname))
    return false;
  return isDefined(getstruct(node.targetname, "targetname"));
}

setup_vehicles(allvehiclesprespawn) {
  vehicles = allvehiclesprespawn;
  spawnvehicles = [];
  groups = [];
  nonspawned = [];
  for (i = 0; i < vehicles.size; i++) {
    if(isDefined(vehicles[i].script_vehiclespawngroup)) {
      if(!isDefined(spawnvehicles[vehicles[i].script_vehiclespawngroup]))
        spawnvehicles[vehicles[i].script_vehiclespawngroup] = [];
      spawnvehicles[vehicles[i].script_vehiclespawngroup]
        [spawnvehicles[vehicles[i].script_vehiclespawngroup].size] = vehicles[i];
      addgroup[0] = vehicles[i].script_vehiclespawngroup;
      groups = array_merge(groups, addgroup);
      continue;
    } else
      nonspawned[nonspawned.size] = vehicles[i];
  }
  for (i = 0; i < groups.size; i++)
    thread spawner_setup(spawnvehicles[groups[i]], groups[i], "main");
  for (i = 0; i < nonspawned.size; i++)
    thread vehicle_init(nonspawned[i]);
}

vehicle_life() {
  type = self.vehicletype;
  if(!isDefined(level.vehicle_life) || !isDefined(level.vehicle_life[self.vehicletype])) {
    wait 2;
  }
  assertEX(isDefined(level.vehicle_life[type]), "need to specify build_life() in vehicle script for vehicletype: " + type);
  if(isDefined(self.script_startinghealth))
    self.health = self.script_startinghealth;
  else {
    if(level.vehicle_life[type] == -1)
      return;
    else if(isDefined(level.vehicle_life_range_low[type]) && isDefined(level.vehicle_life_range_high[type]))
      self.health = (randomint(level.vehicle_life_range_high[type] - level.vehicle_life_range_low[type]) + level.vehicle_life_range_low[type]);
    else
      self.health = level.vehicle_life[type];
  }
}

mginit() {
  type = self.vehicletype;
  if(((isDefined(self.script_nomg)) && (self.script_nomg > 0)))
    return;
  if(!isDefined(level.vehicle_mgturret[type]))
    return;
  mgangle = 0;
  if(isDefined(self.script_mg_angle))
    mgangle = self.script_mg_angle;
  turret_template = level.vehicle_mgturret[type];
  if(!isDefined(turret_template))
    return;
  for (i = 0; i < turret_template.size; i++) {
    self.mgturret[i] = spawnTurret("misc_turret", (0, 0, 0), turret_template[i].info);
    self.mgturret[i] linkto(self, turret_template[i].tag, (0, 0, 0), (0, -1 * mgangle, 0));
    self.mgturret[i] setmodel(turret_template[i].model);
    self.mgturret[i].angles = self.angles;
    self.mgturret[i].isvehicleattached = true;
    self.mgturret[i] thread maps\_mgturret::burst_fire_unmanned();
    self.mgturret[i] maketurretunusable();
    level thread maps\_mgturret::mg42_setdifficulty(self.mgturret[i], getdifficulty());
    if(isDefined(self.script_fireondrones))
      self.mgturret[i].script_fireondrones = self.script_fireondrones;
    self.mgturret[i] setshadowhint("never");
    if(isDefined(turret_template[i].deletedelay))
      self.mgturret[i].deletedelay = turret_template[i].deletedelay;
    if(isDefined(turret_template[i].defaultOFFmode))
      self.mgturret[i] setmode(turret_template[i].defaultOFFmode);
    if(isDefined(turret_template[i].maxrange))
      self.mgturret[i].maxrange = turret_template[i].maxrange;
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "onemg") {
      break;
    }
  }
  if(!isDefined(self.script_turretmg))
    self.script_turretmg = true;;
  if(isDefined(self.script_turretmg) && self.script_turretmg == 0)
    self thread mgoff();
  else {
    self.script_turretmg = 1;
    self thread mgon();
  }
  self thread mgtoggle();
}

mgtoggle() {
  self endon("death");
  if(self.script_turretmg)
    lasttoggle = 1;
  else
    lasttoggle = 0;
  while (1) {
    if(lasttoggle != self.script_turretmg) {
      lasttoggle = self.script_turretmg;
      if(self.script_turretmg)
        self thread mgon();
      else
        self thread mgoff();
    }
    wait .5;
  }
}

mgoff() {
  type = self.vehicletype;
  self.script_turretmg = 0;
  if((self is_aircraft()) && (self hasHelicopterTurret())) {
    self thread chopper_Turret_Off();
    return;
  }
  if(!isDefined(self) || !isDefined(self.mgturret))
    return;
  for (i = 0; i < self.mgturret.size; i++) {
    if(isDefined(self.mgturret[i].script_fireondrones))
      self.mgturret[i].script_fireondrones = false;
    if(isDefined(level.vehicle_mgturret[type][i].defaultOFFmode))
      self.mgturret[i] setmode(level.vehicle_mgturret[type][i].defaultOFFmode);
    else
      self.mgturret[i] setmode("manual");
  }
}

mgon() {
  type = self.vehicletype;
  self.script_turretmg = 1;
  if(!isDefined(self) || !isDefined(self.mgturret))
    return;
  for (i = 0; i < self.mgturret.size; i++) {
    if(isDefined(self.mgturret[i].bAiControlled) && !self.mgturret[i].bAiControlled) {
      continue;
    }
    if(isDefined(self.mgturret[i].script_fireondrones))
      self.mgturret[i].script_fireondrones = true;
    if(isDefined(level.vehicle_mgturret[type][i].defaultONmode))
      self.mgturret[i] setmode(level.vehicle_mgturret[type][i].defaultONmode);
    else
      self.mgturret[i] setmode("auto_nonai");
    if((self.script_team == "allies") || (self.script_team == "friendly"))
      self.mgturret[i] setTurretTeam("allies");
    else if((self.script_team == "axis") || (self.script_team == "enemy"))
      self.mgturret[i] setTurretTeam("axis");
  }
}

is_aircraft() {
  return isDefined(level.aircraft_list[self.vehicletype]);
}

is_boat() {
  return isDefined(level.boat_list[self.vehicletype]);
}

isCheap() {
  if(!isDefined(self.script_cheap))
    return false;
  if(!self.script_cheap)
    return false;
  return true;
}

hasHelicopterDustKickup() {
  if(!is_aircraft())
    return false;
  if(isCheap())
    return false;
  return true;
}

hasHelicopterTurret() {
  if(!isDefined(self.vehicletype))
    return false;
  if(isCheap())
    return false;
  if(self.vehicletype == "cobra")
    return true;
  if(self.vehicletype == "cobra_player")
    return true;
  return false;
}

chopper_Turret_Off() {
  self notify("mg_off");
}

playLoopedFxontag(effect, durration, tag) {
  eModel = get_dummy();
  effectorigin = spawn("script_origin", eModel.origin);
  self endon("fire_extinguish");
  thread playLoopedFxontag_originupdate(tag, effectorigin);
  while (1) {
    playfx(effect, effectorigin.origin, effectorigin.upvec);
    wait durration;
  }
}

playLoopedFxontag_originupdate(tag, effectorigin) {
  effectorigin.angles = self gettagangles(tag);
  effectorigin.origin = self gettagorigin(tag);
  effectorigin.forwardvec = anglestoforward(effectorigin.angles);
  effectorigin.upvec = anglestoup(effectorigin.angles);
  while (isDefined(self) && self.classname == "script_vehicle" && self getspeedmph() > 0) {
    eModel = get_dummy();
    effectorigin.angles = eModel gettagangles(tag);
    effectorigin.origin = eModel gettagorigin(tag);
    effectorigin.forwardvec = anglestoforward(effectorigin.angles);
    effectorigin.upvec = anglestoup(effectorigin.angles);
    wait .05;
  }
}

build_turret(info, tag, model, bAicontrolled, maxrange, defaultONmode, defaultOFFmode, deletedelay, max_turrets) {
  if(!isDefined(level.vehicle_mgturret))
    level.vehicle_mgturret = [];
  if(!isDefined(level.vehicle_mgturret[level.vttype]))
    level.vehicle_mgturret[level.vttype] = [];
  if(isDefined(max_turrets) && level.vehicle_mgturret[level.vttype].size >= max_turrets) {
    return;
  }
  precachemodel(model);
  precacheturret(info);
  struct = spawnstruct();
  struct.info = info;
  struct.tag = tag;
  struct.model = model;
  struct.bAicontrolled = bAicontrolled;
  struct.maxrange = maxrange;
  struct.defaultONmode = defaultONmode;
  struct.defaultOFFmode = defaultOFFmode;
  struct.deletedelay = deletedelay;
  level.vehicle_mgturret[level.vttype][level.vehicle_mgturret[level.vttype].size] = struct;
}

setup_dvars() {
  if(getdvar("debug_tankcrush") == "")
    setdvar("debug_tankcrush", "0");
  if(getdvar("vclogin_vehicles") == "")
    setdvar("vclogin_vehicles", "off");
  if(getdvar("debug_vehicleresume") == "")
    setdvar("debug_vehicleresume", "off");
  if(getdvar("debug_vehiclesetspeed") == "")
    setdvar("debug_vehiclesetspeed", "off");
}

setup_levelvars() {
  level.vehicle_ResumeSpeed = 5;
  level.vehicle_DeleteGroup = [];
  level.vehicle_SpawnGroup = [];
  level.vehicle_StartMoveGroup = [];
  level.vehicle_RideAI = [];
  level.vehicle_WalkAI = [];
  level.vehicle_DeathSwitch = [];
  level.vehicle_RideSpawners = [];
  level.vehicle_walkspawners = [];
  level.vehicle_gatetrigger = [];
  level.vehicle_crashpaths = [];
  level.vehicle_target = [];
  level.vehicle_link = [];
  level.vehicle_truckjunk = [];
  level.vehicle_detourpaths = [];
  level.vehicle_startnodes = [];
  level.vehicle_spawners = [];
  level.helicopter_crash_locations = getentarray("helicopter_crash_location", "targetname");
  level.vclogin_vehicles = 0;
  level.playervehicle = spawn("script_origin", (0, 0, 0));
  level.playervehiclenone = level.playervehicle;
  level.vehicles = [];
  level.vehicles["allies"] = [];
  level.vehicles["axis"] = [];
  level.vehicles["neutral"] = [];
  if(!isDefined(level.vehicle_team)) {
    level.vehicle_team = [];
  }
  if(!isDefined(level.vehicle_deathmodel)) {
    level.vehicle_deathmodel = [];
  }
  if(!isDefined(level.vehicle_death_thread)) {
    level.vehicle_death_thread = [];
  }
  if(!isDefined(level.vehicle_DriveIdle)) {
    level.vehicle_DriveIdle = [];
  }
  if(!isDefined(level.vehicle_DriveIdle_r)) {
    level.vehicle_DriveIdle_r = [];
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
  if(!isDefined(level.vehicle_mgturret)) {
    level.vehicle_mgturret = [];
  }
  if(!isDefined(level.vehicle_isStationary)) {
    level.vehicle_isStationary = [];
  }
  if(!isDefined(level.vehicle_rumble)) {
    level.vehicle_rumble = [];
  }
  if(!isDefined(level.vehicle_death_earthquake)) {
    level.vehicle_death_earthquake = [];
  }
  if(!isDefined(level.vehicle_treads)) {
    level.vehicle_treads = [];
  }
  if(!isDefined(level.vehicle_compassicon)) {
    level.vehicle_compassicon = [];
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
  if(!isDefined(level.vehicle_frontarmor)) {
    level.vehicle_frontarmor = [];
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
  if(!isDefined(level.vehicle_death_jolt)) {
    level.vehicle_death_jolt = [];
  }
  if(!isDefined(level.vehicle_death_badplace)) {
    level.vehicle_death_badplace = [];
  }
  maps\_vehicle_aianim::setup_aianimthreads();
}

attacker_isonmyteam(attacker) {
  if((isDefined(attacker)) && isDefined(attacker.script_team) && (isDefined(self.script_team)) && (attacker.script_team == self.script_team)) {
    return true;
  } else
    return false;
}

is_godmode() {
  if(isDefined(self.godmode) && self.godmode)
    return true;
  else
    return false;
}

attacker_troop_isonmyteam(attacker) {
  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(attacker) && isDefined(level.player) && attacker == level.player)
    return true;
  else if(isai(attacker) && attacker.team == self.script_team)
    return true;
  else
    return false;
}

has_frontarmor() {
  return (isDefined(level.vehicle_frontarmor[self.vehicletype]));
}

bulletshielded(type) {
  if(!isDefined(self.script_bulletshield))
    return false;
  type = tolower(type);
  if(!isDefined(type) || !issubstr(type, "bullet"))
    return false;
  if(self.script_bulletshield)
    return true;
  else
    return false;
}

friendlyfire_shield() {
  self endon("death");
  self endon("stop_friendlyfire_shield");
  if(isDefined(level.vehicle_bulletshield[self.vehicletype]) && !isDefined(self.script_bulletshield))
    self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
  self.healthbuffer = 20000;
  self.health += self.healthbuffer;
  self.currenthealth = self.health;
  attacker = undefined;
  while (self.health > 0) {
    self waittill("damage", amount, attacker, direction_vec, point, type, modelName, tagName);
    if(
      (!isDefined(attacker) && self.script_team != "neutral") ||
      is_godmode() ||
      attacker_isonmyteam(attacker) ||
      attacker_troop_isonmyteam(attacker) ||
      isDestructible() ||
      bulletshielded(type)
    )
      self.health = self.currenthealth;
    else if(self has_frontarmor()) {
      self regen_front_armor(attacker, amount);
      self.currenthealth = self.health;
    } else
      self.currenthealth = self.health;
    if(self.health < self.healthbuffer) {
      break;
    }
    amount = undefined;
    attacker = undefined;
    direction_vec = undefined;
    point = undefined;
    modelName = undefined;
    tagName = undefined;
    type = undefined;
  }
  self notify("death", attacker);
}

regen_front_armor(attacker, amount) {
  forwardvec = anglestoforward(self.angles);
  othervec = vectorNormalize(attacker.origin - self.origin);
  if(vectordot(forwardvec, othervec) > .86)
    self.health += int(amount * level.vehicle_frontarmor[self.vehicletype]);
}

vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

vehicle_rumble() {
  self endon("kill_rumble_forever");
  type = self.vehicletype;
  if(!isDefined(level.vehicle_rumble[type]))
    return;
  if(level.clientScripts)
    return;
  rumblestruct = level.vehicle_rumble[type];
  height = rumblestruct.radius * 2;
  zoffset = -1 * rumblestruct.radius;
  areatrigger = spawn("trigger_radius", self.origin + (0, 0, zoffset), 0, rumblestruct.radius, height);
  areatrigger enablelinkto();
  areatrigger linkto(self);
  self.rumbletrigger = areatrigger;
  self endon("death");
  if(!isDefined(self.rumbleon))
    self.rumbleon = true;
  if(isDefined(rumblestruct.scale))
    self.rumble_scale = rumblestruct.scale;
  else
    self.rumble_scale = 0.15;
  if(isDefined(rumblestruct.duration))
    self.rumble_duration = rumblestruct.duration;
  else
    self.rumble_duration = 4.5;
  if(isDefined(rumblestruct.radius))
    self.rumble_radius = rumblestruct.radius;
  else
    self.rumble_radius = 600;
  if(isDefined(rumblestruct.basetime))
    self.rumble_basetime = rumblestruct.basetime;
  else
    self.rumble_basetime = 1;
  if(isDefined(rumblestruct.randomaditionaltime))
    self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
  else
    self.rumble_randomaditionaltime = 1;
  areatrigger.radius = self.rumble_radius;
  while (1) {
    areatrigger waittill("trigger");
    if(self getspeedmph() == 0 || !self.rumbleon) {
      wait .1;
      continue;
    }
    self PlayRumbleLoopOnEntity(level.vehicle_rumble[type].rumble);
    players = get_players();
    player_touching = false;
    for (i = 0; i < players.size; i++) {
      if(players[i] istouching(areatrigger)) {
        player_touching = true;
      }
    }
    while (player_touching && self.rumbleon && self getspeedmph() > 0) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
      players = get_players();
      player_touching = false;
      for (i = 0; i < players.size; i++) {
        if(players[i] istouching(areatrigger)) {
          player_touching = true;
        }
      }
    }
    println("*** Server vehicle : Stop rumble.");
    self StopRumble(level.vehicle_rumble[type].rumble);
  }
}

vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

vehicle_badplace() {
  if(!isDefined(self.script_badplace))
    return;
  self endon("kill_badplace_forever");
  self endon("death");
  self endon("delete");
  if(isDefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }
  hasturret = isDefined(level.vehicle_hasMainTurret[self.model]) && level.vehicle_hasMainTurret[self.model];
  bp_duration = .5;
  bp_height = 300;
  bp_angle_left = 17;
  bp_angle_right = 17;
  for (;;) {
    if(!self.script_badplace) {
      while (!self.script_badplace)
        wait .5;
    }
    speed = self getspeedmph();
    if(speed <= 0) {
      wait bp_duration;
      continue;
    }
    if(speed < 5)
      bp_radius = 200;
    else if((speed > 5) && (speed < 8))
      bp_radius = 350;
    else
      bp_radius = 500;
    if(isDefined(self.BadPlaceModifier))
      bp_radius = (bp_radius * self.BadPlaceModifier);
    if(hasturret)
      bp_direction = anglestoforward(self gettagangles("tag_turret"));
    else
      bp_direction = anglestoforward(self.angles);
    badplace_arc("", bp_duration, self.origin, bp_radius * 1.9, bp_height, bp_direction, bp_angle_left, bp_angle_right, "allies", "axis");
    badplace_cylinder("", bp_duration, self.origin, 200, bp_height, "allies", "axis");
    wait bp_duration + .05;
  }
}

turret_attack_think() {
  if(self is_aircraft())
    return;
  thread turret_shoot();
}

isStationary() {
  type = self.vehicletype;
  if(isDefined(level.vehicle_isStationary[type]) && level.vehicle_isStationary[type])
    return true;
  else
    return false;
}

turret_shoot() {
  type = self.vehicletype;
  self endon("death");
  self endon("stop_turret_shoot");
  index = 0;
  turrets = [];
  if(isDefined(level.vehicle_mainTurrets) && level.vehicle_mainTurrets[level.vtmodel].size) {
    turrets = getarraykeys(level.vehicle_mainTurrets[level.vtmodel]);
  }
  while (self.health > 0) {
    self waittill("turret_fire");
    self notify("groupedanimevent", "turret_fire");
    if(!turrets.size)
      self fireWeapon();
    else {
      self fireweapon(turrets[index]);
      index++;
      if(index >= turrets.size)
        index = 0;
    }
  }
}

vehicle_weapon_fired() {
  if(!(self vehicle_is_tank())) {
    return;
  }
  self endon("death");
  while (true) {
    self waittill("weapon_fired");
    owner = self GetVehicleOwner();
    if(isDefined(owner) && IsPlayer(owner)) {
      if(!isDefined(owner.vehicle_shoot_shock_overlay)) {
        owner.vehicle_shoot_shock_overlay = newClientHudElem(owner);
        owner.vehicle_shoot_shock_overlay.x = 0;
        owner.vehicle_shoot_shock_overlay.y = 0;
        owner.vehicle_shoot_shock_overlay setshader("black", 640, 480);
        owner.vehicle_shoot_shock_overlay.alignX = "left";
        owner.vehicle_shoot_shock_overlay.alignY = "top";
        owner.vehicle_shoot_shock_overlay.horzAlign = "fullscreen";
        owner.vehicle_shoot_shock_overlay.vertAlign = "fullscreen";
        owner.vehicle_shoot_shock_overlay.alpha = 0;
      }
      owner.vehicle_shoot_shock_overlay.alpha = .5;
      owner.vehicle_shoot_shock_overlay fadeOverTime(0.2);
      owner.vehicle_shoot_shock_overlay.alpha = 0;
    }
  }
}

vehicle_compasshandle() {
  wait_for_first_player();
  self endon("stop_vehicle_compasshandle");
  type = self.vehicletype;
  if(!isDefined(level.vehicle_compassicon[type]))
    return;
  if(!level.vehicle_compassicon[type])
    return;
  self endon("death");
  level.compassradius = int(getdvar("compassMaxRange"));
  self.onplayerscompass = false;
  while (1) {
    player = get_closest_player(self.origin);
    if(distance(self.origin, player.origin) < level.compassradius) {
      if(!(self.onplayerscompass)) {
        self AddVehicleToCompass(maps\_vehicletypes::get_compassTypeForVehicleType(self.vehicletype));
        self.onplayerscompass = true;
      }
    } else {
      if(self.onplayerscompass) {
        self RemoveVehicleFromCompass();
        self.onplayerscompass = false;
      }
    }
    wait .5;
  }
}

vehicle_setteam() {
  type = self.vehicletype;
  if(!isDefined(self.script_team) && isDefined(level.vehicle_team[type]))
    self.script_team = level.vehicle_team[type];
  if(isDefined(self.script_team) && self.script_team == "allies") {
    no_name = self is_aircraft() || (isDefined(self.script_friendname) && (self.script_friendname == "" || self.script_friendname == "none" || self.script_friendname == "0"));
    correct_type = (type == "sherman" || type == "sherman_flame" || type == "t34" || type == "ot34" || type == "see2_t34" || type == "see2_ot34");
    if(!no_name && correct_type) {
      self maps\_vehiclenames::get_name();
    }
  }
  level.vehicles[self.script_team] = array_add(level.vehicles[self.script_team], self);
}

vehicle_handleunloadevent() {
  self endon("death");
  type = self.vehicletype;
  while (1) {
    self waittill("unload", who);
    self notify("groupedanimevent", "unload");
  }
}

get_vehiclenode_any_dynamic(target) {
  path_start = getvehiclenode(target, "targetname");
  if(!isDefined(path_start)) {
    path_start = getent(target, "targetname");
  } else if(is_aircraft()) {
    println("helicopter node targetname: " + path_start.targetname);
    println("vehicletype: " + self.vehicletype);
    assertmsg("helicopter on vehicle path( see console for info )");
  }
  if(!isDefined(path_start)) {
    path_start = getstruct(target, "targetname");
  }
  return path_start;
}

vehicle_resumepathvehicle() {
  if(!self is_aircraft()) {
    self resumespeed(35);
    return;
  }
  node = undefined;
  if(isDefined(self.currentnode.target))
    node = get_vehiclenode_any_dynamic(self.currentnode.target);
  if(!isDefined(node))
    return;
  vehicle_paths(node);
}

vehicle_landvehicle() {
  self setNearGoalNotifyDist(2);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(flat_angle(self.angles)[1]);
  self setvehgoalpos_wrap(groundpos(self.origin), 1);
  self waittill("goal");
}

setvehgoalpos_wrap(origin, bStop) {
  if(self.health <= 0)
    return;
  if(isDefined(self.originheightoffset))
    origin += (0, 0, self.originheightoffset);
  self setvehgoalpos(origin, bStop);
}

vehicle_liftoffvehicle(height) {
  if(!isDefined(height))
    height = 512;
  dest = self.origin + (0, 0, height);
  self setNearGoalNotifyDist(10);
  self setvehgoalpos_wrap(dest, 1);
  self waittill("goal");
}

waittill_stable() {
  offset = 12;
  stabletime = 400;
  timer = gettime() + stabletime;
  while (isDefined(self)) {
    if(self.angles[0] > offset || self.angles[0] < (-1 * offset))
      timer = gettime() + stabletime;
    if(self.angles[2] > offset || self.angles[2] < (-1 * offset))
      timer = gettime() + stabletime;
    if(gettime() > timer) {
      break;
    }
    wait .05;
  }
}

unload_node(node) {
  if(!isDefined(node.script_flag_wait)) {
    self notify("newpath");
  }
  assert(isDefined(self));
  pathnode = getnode(node.targetname, "target");
  if(isDefined(pathnode) && self.riders.size)
    for (i = 0; i < self.riders.size; i++)
      if(isai(self.riders[i]))
        self.riders[i] thread maps\_spawner::go_to_node(pathnode);
  if(self is_aircraft())
    waittill_stable();
  else
    self setspeed(0, 35);
  if(isDefined(node.script_noteworthy))
    if(node.script_noteworthy == "wait_for_flag")
      flag_wait(node.script_flag);
  self notify("unload", node.script_unload);
  if(maps\_vehicle_aianim::riders_unloadable(node.script_unload))
    self waittill("unloaded");
  if(isDefined(node.script_flag_wait)) {
    return;
  }
  if(isDefined(self))
    thread vehicle_resumepathvehicle();
}

move_turrets_here(model) {
  type = self.vehicletype;
  if(!isDefined(self.mgturret))
    return;
  if(self.mgturret.size == 0)
    return;
  for (i = 0; i < self.mgturret.size; i++) {
    self.mgturret[i] unlink();
    self.mgturret[i] linkto(model, level.vehicle_mgturret[type][i].tag, (0, 0, 0), (0, 0, 0));
  }
}

vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");
  self setGoalyaw(flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

vehicle_to_dummy() {
  assertEx(!isDefined(self.modeldummy), "Vehicle_to_dummy was called on a vehicle that already had a dummy.");
  self.modeldummy = spawn("script_model", self.origin);
  self.modeldummy setmodel(self.model);
  self.modeldummy.origin = self.origin;
  self.modeldummy.angles = self.angles;
  self.modeldummy useanimtree(#animtree);
  self hide();
  self notify("animtimer");
  self thread model_dummy_death();
  move_riders_here(self.modelDummy);
  move_turrets_here(self.modeldummy);
  move_ghettotags_here(self.modeldummy);
  move_lights_here(self.modeldummy);
  move_effects_ent_here(self.modeldummy);
  copy_destructable_attachments(self.modeldummy);
  self.modeldummyon = true;
  return self.modeldummy;
}

move_effects_ent_here(model) {
  ent = deathfx_ent();
  ent unlink();
  ent linkto(model);
}

model_dummy_death() {
  modeldummy = self.modeldummy;
  modeldummy endon("death");
  while (isDefined(self)) {
    self waittill("death");
    waittillframeend;
  }
  modeldummy delete();
}

move_lights_here(model) {
  if(!isDefined(self.lights))
    return;
  keys = getarraykeys(self.lights);
  for (i = 0; i < keys.size; i++) {
    self.lights[keys[i]] unlink();
    self.lights[keys[i]] linkto(model, self.lights[keys[i]].lighttag, (0, 0, 0), (0, 0, 0));
  }
}

move_ghettotags_here(model) {
  if(!isDefined(self.ghettotags))
    return;
  for (i = 0; i < self.ghettotags.size; i++) {
    self.ghettotags[i] unlink();
    self.ghettotags[i] linkto(model);
  }
}

dummy_to_vehicle() {
  assertEx(isDefined(self.modeldummy), "Tried to turn a vehicle from a dummy into a vehicle. Can only be called on vehicles that have been turned into dummies with vehicle_to_dummy.");
  if(self is_aircraft())
    self.modeldummy.origin = self gettagorigin("tag_ground");
  else {
    self.modeldummy.origin = self.origin;
    self.modeldummy.angles = self.angles;
  }
  self show();
  move_riders_here(self);
  move_turrets_here(self);
  move_lights_here(self);
  move_effects_ent_here(self);
  self.modeldummyon = false;
  self.modeldummy delete();
  self.modeldummy = undefined;
  if(self hasHelicopterDustKickup()) {
    if(!level.clientscripts) {
      self notify("stop_kicking_up_dust");
      self thread aircraft_dust_kickup();
    }
  }
  return self.modeldummy;
}

move_riders_here(base) {
  if(!isDefined(self.riders))
    return;
  riders = self.riders;
  for (i = 0; i < riders.size; i++) {
    if(!isDefined(riders[i]))
      continue;
    guy = riders[i];
    guy unlink();
    animpos = maps\_vehicle_aianim::anim_pos(self, guy.pos);
    guy linkto(base, animpos.sittag, (0, 0, 0), (0, 0, 0));
    if(isai(guy))
      guy teleport(base gettagorigin(animpos.sittag));
    else
      guy.origin = base gettagorigin(animpos.sittag);
  }
}

setup_targetname_spawners() {
  level.vehicle_targetname_array = [];
  vehicles = array_combine(getentarray("script_vehicle", "classname"), get_script_modelvehicles());
  for (i = 0; i < vehicles.size; i++) {
    if(!isDefined(vehicles[i].targetname))
      continue;
    if(!isDefined(vehicles[i].script_vehicleSpawnGroup)) {
      continue;
    }
    targetname = vehicles[i].targetname;
    spawngroup = vehicles[i].script_vehicleSpawnGroup;
    if(!isDefined(level.vehicle_targetname_array[targetname]))
      level.vehicle_targetname_array[targetname] = [];
    level.vehicle_targetname_array[targetname][spawngroup] = true;
  }
}

spawn_vehicles_from_targetname(name) {
  assertEx(isDefined(level.vehicle_targetname_array[name]), "No vehicle spawners had targetname " + name);
  array = level.vehicle_targetname_array[name];
  keys = getArrayKeys(array);
  vehicles = [];
  for (i = 0; i < keys.size; i++) {
    vehicleArray = scripted_spawn(keys[i]);
    vehicles = array_combine(vehicles, vehicleArray);
  }
  return vehicles;
}

spawn_vehicle_from_targetname(name) {
  vehicleArray = spawn_vehicles_from_targetname(name);
  assertEx(vehicleArray.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehicleArray.size + " vehicles, instead of 1");
  return vehicleArray[0];
}

spawn_vehicle_from_targetname_and_drive(name) {
  vehicleArray = spawn_vehicles_from_targetname(name);
  assertEx(vehicleArray.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehicleArray.size + " vehicles, instead of 1");
  thread gopath(vehicleArray[0]);
  return vehicleArray[0];
}

spawn_vehicles_from_targetname_and_drive(name) {
  vehicleArray = spawn_vehicles_from_targetname(name);
  for (i = 0; i < vehicleArray.size; i++)
    thread goPath(vehicleArray[i]);
  return vehicleArray;
}

aircraft_dust_kickup(model) {
  self endon("death_finished");
  self endon("stop_kicking_up_dust");
  assert(isDefined(self.vehicletype));
  maxHeight = 1200;
  minHeight = 350;
  slowestRepeatWait = 0.15;
  fastestRepeatWait = 0.05;
  numFramesPerTrace = 3;
  doTraceThisFrame = numFramesPerTrace;
  defaultRepeatRate = 1.0;
  repeatRate = defaultRepeatRate;
  trace = undefined;
  d = undefined;
  trace_ent = self;
  if(isDefined(model))
    trace_ent = model;
  while (isDefined(self)) {
    if(repeatRate <= 0)
      repeatRate = defaultRepeatRate;
    wait repeatRate;
    if(!isDefined(self))
      return;
    doTraceThisFrame--;
    if(doTraceThisFrame <= 0) {
      doTraceThisFrame = numFramesPerTrace;
      trace = bullettrace(trace_ent.origin, trace_ent.origin - (0, 0, 100000), false, trace_ent);
      d = distance(trace_ent.origin, trace["position"]);
      repeatRate = ((d - minHeight) / (maxHeight - minHeight)) * (slowestRepeatWait - fastestRepeatWait) + fastestRepeatWait;
    }
    if(!isDefined(trace))
      continue;
    assert(isDefined(d));
    if(d > maxHeight) {
      repeatRate = defaultRepeatRate;
      continue;
    }
    if(isDefined(trace["entity"])) {
      repeatRate = defaultRepeatRate;
      continue;
    }
    if(!isDefined(trace["position"])) {
      repeatRate = defaultRepeatRate;
      continue;
    }
    if(!isDefined(trace["surfacetype"]))
      trace["surfacetype"] = "dirt";
    assertEx(isDefined(level._vehicle_effect[self.vehicletype]), self.vehicletype + " vehicle script hasn't run _tradfx properly");
    assertEx(isDefined(level._vehicle_effect[self.vehicletype][trace["surfacetype"]]), "UNKNOWN SURFACE TYPE: " + trace["surfacetype"]);
    if(level._vehicle_effect[self.vehicletype][trace["surfacetype"]] != -1)
      playfx(level._vehicle_effect[self.vehicletype][trace["surfacetype"]], trace["position"]);
  }
}

tank_crush(crushedVehicle, endNode, tankAnim, truckAnim, animTree, soundAlias) {
  assert(isDefined(crushedVehicle));
  assert(isDefined(endNode));
  assert(isDefined(tankAnim));
  assert(isDefined(truckAnim));
  assert(isDefined(animTree));
  animatedTank = vehicle_to_dummy();
  self setspeed(7, 5, 5);
  animLength = getanimlength(tankAnim);
  move_to_time = (animLength / 3);
  move_from_time = (animLength / 3);
  node_origin = crushedVehicle.origin;
  node_angles = crushedVehicle.angles;
  node_forward = anglesToForward(node_angles);
  node_up = anglesToUp(node_angles);
  node_right = anglesToRight(node_angles);
  anim_start_org = getStartOrigin(node_origin, node_angles, tankAnim);
  anim_start_ang = getStartAngles(node_origin, node_angles, tankAnim);
  animStartingVec_Forward = anglesToForward(anim_start_ang);
  animStartingVec_Up = anglesToUp(anim_start_ang);
  animStartingVec_Right = anglesToRight(anim_start_ang);
  tank_Forward = anglesToForward(animatedTank.angles);
  tank_Up = anglesToUp(animatedTank.angles);
  tank_Right = anglesToRight(animatedTank.angles);
  offset_Vec = (node_origin - anim_start_org);
  offset_Forward = vectorDot(offset_Vec, animStartingVec_Forward);
  offset_Up = vectorDot(offset_Vec, animStartingVec_Up);
  offset_Right = vectorDot(offset_Vec, animStartingVec_Right);
  dummy = spawn("script_origin", animatedTank.origin);
  dummy.origin += vector_multiply(tank_Forward, offset_Forward);
  dummy.origin += vector_multiply(tank_Up, offset_Up);
  dummy.origin += vector_multiply(tank_Right, offset_Right);
  offset_Vec = anglesToForward(node_angles);
  offset_Forward = vectorDot(offset_Vec, animStartingVec_Forward);
  offset_Up = vectorDot(offset_Vec, animStartingVec_Up);
  offset_Right = vectorDot(offset_Vec, animStartingVec_Right);
  dummyVec = vector_multiply(tank_Forward, offset_Forward);
  dummyVec += vector_multiply(tank_Up, offset_Up);
  dummyVec += vector_multiply(tank_Right, offset_Right);
  dummy.angles = vectorToAngles(dummyVec);
  if(getdvar("debug_tankcrush") == "1") {
    thread draw_line_from_ent_for_time(get_players()[0], animatedTank.origin, 1, 0, 0, animLength / 2);
    thread draw_line_from_ent_for_time(get_players()[0], anim_start_org, 0, 1, 0, animLength / 2);
    thread draw_line_from_ent_to_ent_for_time(get_players()[0], dummy, 0, 0, 1, animLength / 2);
  }
  if(isDefined(soundAlias))
    level thread play_sound_in_space(soundAlias, node_origin);
  animatedTank linkto(dummy);
  crushedVehicle useAnimTree(animTree);
  animatedTank useAnimTree(animTree);
  assert(isDefined(level._vehicle_effect["tankcrush"]["window_med"]));
  assert(isDefined(level._vehicle_effect["tankcrush"]["window_large"]));
  crushedVehicle thread tank_crush_fx_on_tag("tag_window_left_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.2);
  crushedVehicle thread tank_crush_fx_on_tag("tag_window_right_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.4);
  crushedVehicle thread tank_crush_fx_on_tag("tag_windshield_back_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 0.7);
  crushedVehicle thread tank_crush_fx_on_tag("tag_windshield_front_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 1.5);
  crushedVehicle animscripted("tank_crush_anim", node_origin, node_angles, truckAnim);
  animatedTank animscripted("tank_crush_anim", dummy.origin, dummy.angles, tankAnim);
  dummy moveTo(node_origin, move_to_time, (move_to_time / 2), (move_to_time / 2));
  dummy rotateTo(node_angles, move_to_time, (move_to_time / 2), (move_to_time / 2));
  wait move_to_time;
  animLength -= move_to_time;
  animLength -= move_from_time;
  wait animLength;
  temp = spawn("script_model", (anim_start_org));
  temp.angles = anim_start_ang;
  anim_end_org = temp localToWorldCoords(getMoveDelta(tankAnim, 0, 1));
  anim_end_ang = anim_start_ang + (0, getAngleDelta(tankAnim, 0, 1), 0);
  temp delete();
  animEndingVec_Forward = anglesToForward(anim_end_ang);
  animEndingVec_Up = anglesToUp(anim_end_ang);
  animEndingVec_Right = anglesToRight(anim_end_ang);
  attachPos = self getAttachPos(endNode);
  tank_Forward = anglesToForward(attachPos[1]);
  tank_Up = anglesToUp(attachPos[1]);
  tank_Right = anglesToRight(attachPos[1]);
  offset_Vec = (node_origin - anim_end_org);
  offset_Forward = vectorDot(offset_Vec, animEndingVec_Forward);
  offset_Up = vectorDot(offset_Vec, animEndingVec_Up);
  offset_Right = vectorDot(offset_Vec, animEndingVec_Right);
  dummy.final_origin = attachPos[0];
  dummy.final_origin += vector_multiply(tank_Forward, offset_Forward);
  dummy.final_origin += vector_multiply(tank_Up, offset_Up);
  dummy.final_origin += vector_multiply(tank_Right, offset_Right);
  offset_Vec = anglesToForward(node_angles);
  offset_Forward = vectorDot(offset_Vec, animEndingVec_Forward);
  offset_Up = vectorDot(offset_Vec, animEndingVec_Up);
  offset_Right = vectorDot(offset_Vec, animEndingVec_Right);
  dummyVec = vector_multiply(tank_Forward, offset_Forward);
  dummyVec += vector_multiply(tank_Up, offset_Up);
  dummyVec += vector_multiply(tank_Right, offset_Right);
  dummy.final_angles = vectorToAngles(dummyVec);
  if(getdvar("debug_tankcrush") == "1") {
    thread draw_line_from_ent_for_time(get_players()[0], self.origin, 1, 0, 0, animLength / 2);
    thread draw_line_from_ent_for_time(get_players()[0], anim_end_org, 0, 1, 0, animLength / 2);
    thread draw_line_from_ent_to_ent_for_time(get_players()[0], dummy, 0, 0, 1, animLength / 2);
  }
  dummy moveTo(dummy.final_origin, move_from_time, (move_from_time / 2), (move_from_time / 2));
  dummy rotateTo(dummy.final_angles, move_from_time, (move_from_time / 2), (move_from_time / 2));
  wait move_from_time;
  self dontInterpolate();
  self attachPath(endNode);
  dummy_to_vehicle();
}

tank_crush_fx_on_tag(tagName, fxName, soundAlias, startDelay) {
  if(isDefined(startDelay))
    wait startDelay;
  playfxontag(fxName, self, tagName);
  if(isDefined(soundAlias))
    self thread play_sound_on_tag(soundAlias, tagName);
}

loadplayer(player, position, animfudgetime) {
  if(getdvar("fastrope_arms") == "")
    setdvar("fastrope_arms", "0");
  if(!isDefined(animfudgetime))
    animfudgetime = 0;
  assert(isDefined(self.riders));
  assert(self.riders.size);
  guy = undefined;
  for (i = 0; i < self.riders.size; i++) {
    if(self.riders[i].pos == position) {
      guy = self.riders[i];
      guy.drone_delete_on_unload = true;
      guy.playerpiggyback = true;
      break;
    }
  }
  assertex(!isai(guy), "guy in position of player needs to have script_drone set, use script_startingposition ans script drone in your map");
  assert(isDefined(guy));
  thread show_rigs(position);
  animpos = maps\_vehicle_aianim::anim_pos(self, position);
  guy notify("newanim");
  guy detachall();
  guy setmodel("fastrope_arms");
  guy useanimtree(animpos.player_animtree);
  thread maps\_vehicle_aianim::guy_idle(guy, position);
  player playerlinktodelta(guy, "tag_player", 1.0, 70, 70, 90, 90);
  guy hide();
  animtime = getanimlength(animpos.getout);
  animtime -= animfudgetime;
  self waittill("unload");
  if(getdvar("fastrope_arms") != "0")
    guy show();
  player disableweapons();
  guy notsolid();
  wait animtime;
  player unlink();
  player enableweapons();
}

show_rigs(position) {
  wait .01;
  self thread maps\_vehicle_aianim::getout_rigspawn(self, position);
  if(!self.riders.size)
    return;
  for (i = 0; i < self.riders.size; i++)
    self thread maps\_vehicle_aianim::getout_rigspawn(self, self.riders[i].pos);
}

vehicle_deleteme() {
  self delete();
}

turret_deleteme(turret) {
  if(isDefined(self))
    if(isDefined(turret.deletedelay))
      wait turret.deletedelay;
  turret delete();
}

wheeldirectionchange(direction) {
  if(direction <= 0)
    self.wheeldir = 0;
  else
    self.wheeldir = 1;
}

maingun_FX() {
  if(!isDefined(level.vehicle_deckdust[self.model]))
    return;
  self endon("death");
  while (true) {
    self waittill("weapon_fired");
    playfxontag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
    barrel_origin = self gettagorigin("tag_flash");
    ground = physicstrace(barrel_origin, barrel_origin + (0, 0, -128));
    physicsExplosionSphere(ground, 192, 100, 1);
  }
}

playTankExhaust() {
  if(!isDefined(level.vehicle_exhaust[self.model]))
    return;
  exhaustDelay = 0.1;
  for (;;) {
    if(!isDefined(self))
      return;
    if(!isalive(self))
      return;
    playfxontag(level.vehicle_exhaust[self.model], self, "tag_engine_left");
    playfxontag(level.vehicle_exhaust[self.model], self, "tag_engine_right");
    wait exhaustDelay;
  }
}

build_light(model, name, tag, effect, group, delay) {
  if(!isDefined(level.vehicle_lights))
    level.vehicle_lights = [];
  struct = spawnstruct();
  struct.name = name;
  struct.tag = tag;
  struct.delay = delay;
  struct.effect = loadfx(effect);
  level.vehicle_lights[model][name] = struct;
  group_light(model, name, "all");
  if(isDefined(group))
    group_light(model, name, group);
}

group_light(model, name, group) {
  if(!isDefined(level.vehicle_lights_group))
    level.vehicle_lights_group = [];
  if(!isDefined(level.vehicle_lights_group[model]))
    level.vehicle_lights_group[model] = [];
  if(!isDefined(level.vehicle_lights_group[model][group]))
    level.vehicle_lights_group[model][group] = [];
  level.vehicle_lights_group[model][group][level.vehicle_lights_group[model][group].size] = name;
}

lights_on(group) {
  groups = strtok(group, " ");
  array_levelthread(groups, ::lights_on_internal);
}

lights_delayfxforframe() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");
  if(!isDefined(level.fxdelay))
    level.fxdelay = 0;
  level.fxdelay += randomfloatrange(0.2, 0.4);
  if(level.fxdelay > 2)
    level.fxdelay = 0;
  wait 0.05;
  level.fxdelay = undefined;
}

lights_on_internal(group) {
  level.lastlighttime = gettime();
  if(!isDefined(group))
    group = "all";
  if(!isDefined(level.vehicle_lights_group[self.model]) ||
    !isDefined(level.vehicle_lights_group[self.model][group])
  )
    return;
  thread lights_delayfxforframe();
  if(!isDefined(self.lights))
    self.lights = [];
  lights = level.vehicle_lights_group[self.model][group];
  count = 0;
  delayoffsetter = [];
  for (i = 0; i < lights.size; i++) {
    if(isDefined(self.lights[lights[i]]))
      continue;
    template = level.vehicle_lights[self.model][lights[i]];
    if(isDefined(template.delay))
      delay = template.delay;
    else
      delay = 0;
    while (isDefined(delayoffsetter["" + delay]))
      delay += .05;
    delay += level.fxdelay;
    delayoffsetter["" + delay] = true;
    if(isDefined(self.script_light_toggle) && self.script_light_toggle) {
      light = spawn("script_model", (0, 0, 0));
      light setmodel("fx");
      light hide();
      light linkto(self, template.tag, (0, 0, 0), (0, 0, 0));
      thread playfxontag_delay(template.effect, light, "Trim_Char_F_1_1", delay);
    } else {
      light = self;
      thread playfxontag_delay(template.effect, light, template.tag, delay);
    }
    light.lighttag = template.tag;
    self.lights[lights[i]] = light;
    if(!isDefined(self)) {
      break;
    }
  }
  level.fxdelay = false;
}

playfxontag_delay(effect, entity, tag, delay) {
  entity endon("death");
  wait delay;
  playfxontag(effect, entity, tag);
}

deathfx_ent() {
  if(!isDefined(self.deathfx_ent)) {
    ent = spawn("script_model", (0, 0, 0));
    emodel = get_dummy();
    ent setmodel(self.model);
    ent.origin = emodel.origin;
    ent.angles = emodel.angles;
    ent notsolid();
    ent hide();
    ent linkto(emodel);
    self.deathfx_ent = ent;
  } else
    self.deathfx_ent setmodel(self.model);
  return self.deathfx_ent;
}

lights_off(group) {
  groups = strtok(group, " ");
  array_levelthread(groups, ::lights_off_internal);
}

lights_kill() {
  if(!isDefined(self.lights))
    return;
  keys = getarraykeys(self.lights);
  for (i = 0; i < keys.size; i++) {
    if(self.lights[keys[i]] == self)
      return;
    self.lights[keys[i]] delete();
    if(isDefined(self))
      self.lights[keys[i]] = undefined;
  }
}

lights_off_internal(group) {
  if(!isDefined(group))
    group = "all";
  assertEX(isDefined(self.script_light_toggle) && self.script_light_toggle, "can't turn off lights on a vehicle without script_light_toggle");
  if(!isDefined(self.lights))
    return;
  if(!isDefined(level.vehicle_lights_group[self.model][group])) {
    println("vehicletype: " + self.vehicletype);
    println("light group: " + group);
    assertmsg("lights not defined for this vehicle( see console");
  }
  lights = level.vehicle_lights_group[self.model][group];
  for (i = 0; i < lights.size; i++) {
    self.lights[lights[i]] delete();
    self.lights[lights[i]] = undefined;
  }
}

build_deathmodel(model, deathmodel, swapDelay, do_build_death) {
  if(isDefined(do_build_death) && !do_build_death) {
    deathmodel = model;
  }
  if(model != level.vtmodel)
    return;
  if(!isDefined(deathmodel))
    deathmodel = model;
  precachemodel(model);
  precachemodel(deathmodel);
  level.vehicle_deathmodel[model] = deathmodel;
  if(!isDefined(swapDelay))
    swapDelay = 0;
  level.vehicle_deathmodel_delay[model] = swapDelay;
}

build_shoot_shock(shock) {
  precacheShader("black");
  precacheshellshock(shock);
}

build_shoot_rumble(rumble) {
  PrecacheRumble(rumble);
}

build_drive(forward, reverse, normalspeed, rate) {
  if(!isDefined(normalspeed))
    normalspeed = 10;
  level.vehicle_DriveIdle[level.vtmodel] = forward;
  if(isDefined(reverse))
    level.vehicle_DriveIdle_r[level.vtmodel] = reverse;
  level.vehicle_DriveIdle_normal_speed[level.vtmodel] = normalspeed;
  if(isDefined(rate))
    level.vehicle_DriveIdle_animrate[level.vtmodel] = rate;
}

build_template(type, model, typeoverride) {
  if(isDefined(typeoverride))
    type = typeoverride;
  precachevehicle(type);
  if(!isDefined(level.vehicle_death_fx))
    level.vehicle_death_fx = [];
  if(!isDefined(level.vehicle_death_fx[type]))
    level.vehicle_death_fx[type] = [];
  level.vehicle_compassicon[type] = false;
  level.vehicle_team[type] = "axis";
  level.vehicle_life[type] = 999;
  level.vehicle_hasMainTurret[model] = false;
  level.vehicle_mainTurrets[model] = [];
  level.vtmodel = model;
  level.vttype = type;
}

build_exhaust(effect) {
  level.vehicle_exhaust[level.vtmodel] = loadfx(effect);
}

build_treadfx(type) {
  if(!isDefined(type))
    type = level.vttype;
  maps\_treadfx::main(type);
}

build_team(team) {
  level.vehicle_team[level.vttype] = team;
}

build_mainturret(tag1, tag2, tag3, tag4) {
  level.vehicle_hasMainTurret[level.vtmodel] = true;
  if(isDefined(tag1))
    level.vehicle_mainTurrets[level.vtmodel][tag1] = true;
  if(isDefined(tag2))
    level.vehicle_mainTurrets[level.vtmodel][tag2] = true;
  if(isDefined(tag3))
    level.vehicle_mainTurrets[level.vtmodel][tag3] = true;
  if(isDefined(tag4))
    level.vehicle_mainTurrets[level.vtmodel][tag4] = true;
}

build_bulletshield(bShield) {
  assert(isDefined(bShield));
  level.vehicle_bulletshield[level.vttype] = bShield;
}

build_aianims(aithread, vehiclethread) {
  level.vehicle_aianims[level.vttype] = [[aithread]]();
  if(isDefined(vehiclethread))
    level.vehicle_aianims[level.vttype] = [
      [vehiclethread]
    ](level.vehicle_aianims[level.vttype]);
}

build_frontarmor(armor) {
  level.vehicle_frontarmor[level.vttype] = armor;
}

build_attach_models(modelsthread) {
  level.vehicle_attachedmodels[level.vttype] = [[modelsthread]]();;
}

build_unload_groups(unloadgroupsthread) {
  level.vehicle_unloadgroups[level.vttype] = [[unloadgroupsthread]]();
}

build_life(health, minhealth, maxhealth) {
  level.vehicle_life[level.vttype] = health;
  level.vehicle_life_range_low[level.vttype] = minhealth;
  level.vehicle_life_range_high[level.vttype] = maxhealth;
}

build_compassicon() {
  level.vehicle_compassicon[level.vttype] = true;
}

build_deckdust(effect) {
  level.vehicle_deckdust[level.vtmodel] = loadfx(effect);
}

build_vehiclewalk(num_walkers) {
  level.vehicle_walkercount[level.vttype] = num_walkers;
}

build_localinit(init_thread) {
  level.vehicleInitThread[level.vttype][level.vtmodel] = init_thread;
}

get_from_spawnstruct(target) {
  return getstruct(target, "targetname");
}

get_from_entity(target) {
  return getent(target, "targetname");
}

get_from_spawnstruct_target(target) {
  return getstruct(target, "target");
}

get_from_entity_target(target) {
  return getent(target, "target");
}

get_from_vehicle_node(target) {
  return getvehiclenode(target, "targetname");
}

set_lookat_from_dest(dest) {
  viewTarget = getent(dest.script_linkto, "script_linkname");
  if(!isDefined(viewTarget) || level.script == "hunted")
    return;
  self setLookAtEnt(viewTarget);
  self.set_lookat_point = true;
}

getspawner_byid(id) {
  return level.vehicle_spawners[id];
}

vehicle_getspawner() {
  assert(isDefined(self.spawner_id));
  return getspawner_byid(self.spawner_id);
}

isDestructible() {
  return isDefined(self.destructible_type);
}

attackgroup_think() {
  self endon("death");
  self endon("switch group");
  self endon("killed all targets");
  if(isDefined(self.script_vehicleattackgroupwait)) {
    wait(self.script_vehicleattackgroupwait);
  }
  for (;;) {
    group = getentarray("script_vehicle", "classname");
    valid_targets = [];
    for (i = 0; i < group.size; i++) {
      if(!isDefined(group[i].script_vehiclespawngroup)) {
        continue;
      }
      if(group[i].script_vehiclespawngroup == self.script_vehicleattackgroup) {
        if(group[i].script_team != self.script_team) {
          valid_targets = array_add(valid_targets, group[i]);
        }
      }
    }
    if(valid_targets.size == 0) {
      wait(0.5);
      continue;
    }
    for (;;) {
      current_target = undefined;
      if(valid_targets.size != 0) {
        current_target = self get_nearest_target(valid_targets);
      } else {
        self notify("killed all targets");
      }
      if(current_target.health <= 0) {
        valid_targets = array_remove(valid_targets, current_target);
        continue;
      } else {
        self setturrettargetent(current_target, (0, 0, 50));
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
}

get_nearest_target(valid_targets) {
  nearest_dist = 999999;
  nearest = undefined;
  for (i = 0; i < valid_targets.size; i++) {
    if(!isDefined(valid_targets[i])) {
      continue;
    }
    current_dist = distance(self.origin, valid_targets[i].origin);
    if(current_dist < nearest_dist) {
      nearest_dist = current_dist;
      nearest = valid_targets[i];
    }
  }
  return nearest;
}

debug_vehicle() {
  self endon("death");
  if(GetDvar("debug_vehicle_health") == "") {
    SetDvar("debug_vehicle_health", "0");
  }
  while (1) {
    if(GetDvarInt("debug_vehicle_health") > 0) {
      print3d(self.origin, "Health: " + self.health, (1, 1, 1), 1, 3);
    }
    wait(0.05);
  }
}

generate_colmaps_vehicles() {
  if(!isDefined(level.vehicleInitThread) || !level.vehicleInitThread.size)
    return;
  script_vehicles = getentarray("script_vehicle", "classname");
  hascol = [];
  for (i = 0; i < script_vehicles.size; i++) {
    if(!isDefined(hascol[script_vehicles[i].vehicletype]))
      hascol[script_vehicles[i].vehicletype] = [];
    hascol[script_vehicles[i].vehicletype][script_vehicles[i].model] = true;
  }
  dump = false;
  keys1 = getarraykeys(level.vehicleInitThread);
  needscol = [];
  for (i = 0; i < keys1.size; i++) {
    keys2 = getarraykeys(level.vehicleInitThread[keys1[i]]);
    for (j = 0; j < keys2.size; j++) {
      if(!isDefined(hascol[keys1[i]]) ||
        !isDefined(hascol[keys1[i]][keys2[j]])) {
        dump = true;
        needscol[keys1[i]][keys2[j]] = true;
      }
    }
    if(dump) {
      break;
    }
  }
  if(dump)
    dump_vehicles();
  array_levelthread(getentarray("colmap_vehicle", "targetname"), maps\_utility::deleteEnt);
}
dump_vehicles() {
  level.script = tolower(getdvar("mapname"));
  fileprint_map_start(level.script + "_vehicledump");
  stackupinc = 64;
  keys1 = getarraykeys(level.vehicleInitThread);
  for (i = 0; i < keys1.size; i++) {
    keys2 = getarraykeys(level.vehicleInitThread[keys1[i]]);
    for (j = 0; j < keys2.size; j++) {
      origin = fileprint_radiant_vec((0, 0, (stackupinc * i)));
      fileprint_map_entity_start();
      fileprint_map_keypairprint("classname", "script_vehicle");
      fileprint_map_keypairprint("model", keys2[j]);
      fileprint_map_keypairprint("origin", origin);
      fileprint_map_keypairprint("vehicletype", keys1[i]);
      fileprint_map_keypairprint("targetname", "colmap_vehicle");
      fileprint_map_entity_end();
    }
  }
  fileprint_end();
  println(" ");
  println(" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - ");
  println(" ");
  println("add this prefab to your map, it contains the vehicles needed to make the system happy");
  fabname = "xenon_export\\" + level.script + "_vehicledump.map";
  println("prefab is : " + fabname);
  println(" ");
  println("after you've done this you'll need to compile");
  println("I appologize for this very roundabout workaround to some stuff. ");
  println("It's on my next - game list to be fixed - nate");
  println("the workaround is for getting colmaps on script_vehicles that exists as script_models in the map source and are purely spawned by scripts");
  println(" ");
  println(" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - ");
  println(" ");
}

get_deletegroups(script_vehiclegroupdelete) {
  deletegroups = [];
  vehicles = getentarray("script_vehicle", "classname");
  for (i = 0; i < vehicles.size; i++) {
    if(!isDefined(vehicles[i].script_vehiclegroupdelete) ||
      vehicles[i].script_vehiclegroupdelete != script_vehiclegroupdelete
    )
      continue;
    deletegroups[deletegroups.size] = vehicles[i];
  }
  return deletegroups;
}

damage_hints() {
  level.armorDamageHints = false;
  self.displayingDamageHints = false;
  self thread damage_hints_cleanup();
  while (isDefined(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(!IsPlayer(attacker))
      continue;
    switch (tolower(type)) {
      case "mod_grenade":
      case "mod_grenade_splash":
      case "mod_pistol_bullet":
      case "mod_rifle_bullet":
      case "bullet":
        if(!level.armorDamageHints) {
          level.armorDamageHints = true;
          self.displayingDamageHints = true;
          display_hint("armor_damage");
          wait(8);
          level.armorDamageHints = false;
          self.displayingDamageHints = false;
          break;
        }
    }
  }
}

damage_hints_cleanup() {
  self waittill("death");
  if(self.displayingDamageHints)
    level.armorDamageHints = false;
}

copy_destructable_attachments(modeldummy) {
  attachedModelCount = self getattachsize();
  attachedModels = [];
  for (i = 0; i < attachedModelCount; i++)
    attachedModels[i] = tolower(self getAttachModelName(i));
  for (i = 0; i < attachedModels.size; i++)
    modeldummy attach(attachedModels[i], tolower(self getattachtagname(i)));
}

get_dummy() {
  if(self.modeldummyon)
    eModel = self.modeldummy;
  else
    eModel = self;
  return eModel;
}

apply_truckjunk(eVehicle, truckjunk) {
  if(!isDefined(self.spawner_id))
    return;
  if(!isDefined(level.vehicle_truckjunk[self.spawner_id]))
    return;
  truckjunk = level.vehicle_truckjunk[self.spawner_id];
  self.truckjunk = [];
  for (i = 0; i < truckjunk.size; i++) {
    model = spawn("script_model", self.origin);
    model setmodel(truckjunk[i].model);
    model linkto(self, "tag_body", truckjunk[i].origin, truckjunk[i].angles);
    self.truckjunk[i] = model;
  }
}

truckjunk() {
  assert(isDefined(self.target));
  linked_vehicle = getent(self.target, "targetname");
  assert(isDefined(linked_vehicle));
  spawner_id = vehicle_spawnidgenerate(linked_vehicle.origin);
  target = getent(self.target, "targetname");
  ghettotag = ghetto_tag_create(target);
  if(isDefined(self.script_noteworthy))
    ghettotag.script_noteworthy = self.script_noteworthy;
  if(!isDefined(level.vehicle_truckjunk[spawner_id]))
    level.vehicle_truckjunk[spawner_id] = [];
  if(isDefined(self.script_startingposition))
    ghettotag.script_startingposition = self.script_startingposition;
  level.vehicle_truckjunk[spawner_id][level.vehicle_truckjunk[spawner_id].size] = ghettotag;
  self delete();
}

ghetto_tag_create(target) {
  struct = spawnstruct();
  struct.origin = self.origin - target gettagorigin("tag_body");
  struct.angles = self.angles - target gettagangles("tag_body");
  struct.model = self.model;
  if(isDefined(struct.targetname))
    level.struct_class_names["targetname"][struct.targetname] = undefined;
  if(isDefined(struct.target))
    level.struct_class_names["target"][struct.target] = undefined;
  return struct;
}

vehicle_dump() {
  predumpvehicles = getentarray("script_vehicle", "classname");
  vehicles = [];
  for (i = 0; i < predumpvehicles.size; i++) {
    struct = spawnstruct();
    struct.classname = predumpvehicles[i].classname;
    struct.origin = predumpvehicles[i].origin;
    struct.angles = predumpvehicles[i].angles;
    struct.spawner_id = predumpvehicles[i].spawner_id;
    struct.speedbeforepause = predumpvehicles[i] getspeedmph();
    struct.script_vehiclespawngroup = predumpvehicles[i].script_vehiclespawngroup;
    struct.script_vehiclestartmove = predumpvehicles[i].script_vehiclestartmove;
    struct.model = predumpvehicles[i].model;
    struct.angles = predumpvehicles[i].angles;
    if(isDefined(level.playersride) && predumpvehicles[i] == level.playersride)
      struct.playersride = true;
    vehicles[i] = struct;
  }
  fileprint_map_start(level.script + "_veh_ref");
  for (i = 0; i < vehicles.size; i++) {
    origin = fileprint_radiant_vec(vehicles[i].origin);
    angles = fileprint_radiant_vec(vehicles[i].angles);
    fileprint_map_entity_start();
    fileprint_map_keypairprint("classname", "script_struct");
    fileprint_map_keypairprint("spawnflags", "4");
    fileprint_map_keypairprint("model", vehicles[i].model);
    fileprint_map_keypairprint("origin", origin);
    fileprint_map_keypairprint("angles", angles);
    if(isDefined(vehicles[i].playersride))
      fileprint_map_keypairprint("target", "delete_on_load");
    else {
      fileprint_map_keypairprint("target", "structtarg" + i);
      fileprint_map_keypairprint("targetname", "delete_on_load");
    }
    if(isDefined(vehicles[i].speedbeforepause))
      fileprint_map_keypairprint("current_speed", vehicles[i].speedbeforepause);
    if(isDefined(vehicles[i].script_vehiclespawngroup))
      fileprint_map_keypairprint("script_vehiclespawngroup", vehicles[i].script_vehiclespawngroup);
    if(isDefined(vehicles[i].script_vehiclestartmove))
      fileprint_map_keypairprint("script_vehiclestartmove", vehicles[i].script_vehiclestartmove);
    fileprint_map_entity_end();
    if(
      !isDefined(vehicles[i].spawner_id) ||
      !isDefined(level.vehicle_spawners) ||
      !isDefined(level.vehicle_spawners[vehicles[i].spawner_id])
    )
      continue;
    fileprint_map_entity_start();
    fileprint_map_keypairprint("classname", "script_struct");
    fileprint_map_keypairprint("origin", fileprint_radiant_vec(level.vehicle_spawners[vehicles[i].spawner_id].origin));
    fileprint_map_keypairprint("_color", "0.300000 0.300000 0.300000");
    fileprint_map_keypairprint("angles", angles);
    fileprint_map_keypairprint("model", vehicles[i].model);
    fileprint_map_keypairprint("targetname", "structtarg" + i);
    if(isDefined(vehicles[i].speedbeforepause))
      fileprint_map_keypairprint("current_speed", vehicles[i].speedbeforepause);
    if(isDefined(vehicles[i].script_vehiclespawngroup))
      fileprint_map_keypairprint("script_vehiclespawngroup", vehicles[i].script_vehiclespawngroup);
    if(isDefined(vehicles[i].script_vehiclestartmove))
      fileprint_map_keypairprint("script_vehiclestartmove", vehicles[i].script_vehiclestartmove);
    fileprint_map_entity_end();
  }
  fileprint_end();
}

dump_handle() {
  button1 = "r";
  button2 = "CTRL";
  wait_for_first_player();
  while (1) {
    while (!twobuttonspressed(button1, button2))
      wait .05;
    vehicle_dump();
    while (twobuttonspressed(button1, button2))
      wait .05;
  }
}

twobuttonspressed(button1, button2) {
  players = get_players();
  if(!isDefined(players[0]))
    return false;
  return players[0] buttonpressed(button1) && players[0] buttonpressed(button2);
}

vehicle_load_ai(ai) {
  maps\_vehicle_aianim::load_ai(ai);
}

volume_up(timer) {
  self notify("new_volume_command");
  self endon("new_volume_command");
  assertex(isDefined(timer), "No timer defined! ");
  self endon("death");
  timer = timer * 20;
  for (i = 0; i <= timer; i++) {
    self setenginevolume(i / timer);
    wait(0.05);
  }
}

volume_down(timer) {
  self notify("new_volume_command");
  self endon("new_volume_command");
  assertex(isDefined(timer), "No timer defined! ");
  self endon("death");
  timer = timer * 20;
  for (i = 0; i <= timer; i++) {
    self setenginevolume((timer - i) / timer);
    wait(0.05);
  }
}

lerp_enginesound(time, base_vol, dest_vol) {
  self endon("death");
  assert(isDefined(base_vol));
  assert(isDefined(dest_vol));
  if(time == 0) {
    self SetEngineVolume(dest_vol);
    return;
  }
  incs = int(time / .05);
  inc_vol = (dest_vol - base_vol) / incs;
  current_vol = base_vol;
  for (i = 0; i < incs; i++) {
    current_vol += inc_vol;
    self SetEngineVolume(current_vol);
    wait .05;
  }
}

kill_badplace(type) {
  if(!isDefined(level.vehicle_death_badplace[type]))
    return;
  struct = level.vehicle_death_badplace[type];
  if(isDefined(struct.delay))
    wait struct.delay;
  if(!isDefined(self))
    return;
  BadPlace_Cylinder("vehicle_kill_badplace", struct.duration, self.origin, struct.radius, struct.height, struct.team1, struct.team2);
}

build_death_badplace(delay, duration, height, radius, team1, team2) {
  if(!isDefined(level.vehicle_death_badplace))
    level.vehicle_death_badplace = [];
  struct = spawnstruct();
  struct.delay = delay;
  struct.duration = duration;
  struct.height = height;
  struct.radius = radius;
  struct.team1 = team1;
  struct.team2 = team2;
  level.vehicle_death_badplace[level.vttype] = struct;
}

build_death_jolt(delay) {
  if(!isDefined(level.vehicle_death_jolt))
    level.vehicle_death_jolt = [];
  struct = spawnstruct();
  struct.delay = delay;
  level.vehicle_death_jolt[level.vttype] = struct;
}

kill_jolt(type) {
  if(isDefined(level.vehicle_death_jolt[type])) {
    self.dontfreeme = true;
    wait level.vehicle_death_jolt[type].delay;
  }
  if(!isDefined(self))
    return;
  self joltbody((self.origin + (23, 33, 64)), 3);
  wait 2;
  if(!isDefined(self))
    return;
  self.dontfreeme = undefined;
}

build_tankmantle() {}