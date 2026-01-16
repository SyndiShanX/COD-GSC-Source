/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#using_animtree("vehicles");
init_vehicles() {
  precachemodel("fx");
  if(isDefined(level.bypassVehicleScripts)) {
    return;
  }
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
  setup_ai();
  setup_triggers();
  allvehiclesprespawn = precache_scripts();
  setup_vehicles(allvehiclesprespawn);
  array_levelthread(level.vehicle_processtriggers, ::trigger_process);
  level.vehicle_processtriggers = undefined;
  init_level_has_vehicles();
  level.vehicle_enemy_tanks = [];
  level.vehicle_enemy_tanks["vehicle_ger_tracked_king_tiger"] = true;
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
  if(level.vehicle_spawngroup.size > 0) {
    level.levelHasVehicles = true;
  }
  if(level.vehicle_spawners.size > 0) {
    level.levelHasVehicles = true;
  }
  if(level.vehicles["allies"].size > 0) {
    level.levelHasVehicles = true;
  }
  if(level.vehicles["axis"].size > 0) {
    level.levelHasVehicles = true;
  }
  if(level.vehicles["neutral"].size > 0) {
    level.levelHasVehicles = true;
  }
  classname = getentarray("script_vehicle", "classname");
  if(classname.size > 0) {
    level.levelHasVehicles = true;
  }
}

trigger_getlinkmap(trigger) {
  linkMap = [];
  if(isDefined(trigger.script_linkTo)) {
    links = strtok(trigger.script_linkTo, " ");
    for(i = 0; i < links.size; i++) {
      linkMap[links[i]] = true;
    }
    links = undefined;
  }
  return linkMap;
}

setup_script_gatetrigger(trigger) {
  gates = [];
  if(isDefined(trigger.script_gatetrigger)) {
    return level.vehicle_gatetrigger[trigger.script_gatetrigger];
  }
  return gates;
}

setup_script_vehiclespawngroup(trigger, vehicles) {
  script_vehiclespawngroup = false;
  if(isDefined(trigger.script_vehiclespawngroup)) {
    script_vehiclespawngroup = true;
  }
  return script_vehiclespawngroup;
}

trigger_process(trigger) {
  if(isDefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat")) {
    bTriggeronce = true;
  } else {
    bTriggeronce = false;
  }
  trigger.processed_trigger = undefined;
  if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple") {
    bTriggeronce = false;
  }
  gates = setup_script_gatetrigger(trigger);
  script_vehiclespawngroup = isDefined(trigger.script_vehiclespawngroup);
  script_vehicledetour = isDefined(trigger.script_vehicledetour) && (is_node_script_origin(trigger) || is_node_script_struct(trigger));
  detoured = isDefined(trigger.detoured) && !(is_node_script_origin(trigger) || is_node_script_struct(trigger));
  gotrigger = true;
  while(gotrigger) {
    trigger waittill("trigger", other);
    if(isDefined(trigger.script_vehicletriggergroup)) {
      if(!isDefined(other.script_vehicletriggergroup)) {
        continue;
      }
      if(isDefined(other) && other.script_vehicletriggergroup != trigger.script_vehicletriggergroup) {
        continue;
      }
    }
    if(isDefined(trigger.enabled) && !trigger.enabled) {
      trigger waittill("enable");
    }
    if(isDefined(trigger.script_flag_set)) {
      if(isDefined(other) && isDefined(other.vehicle_flags)) {
        other.vehicle_flags[trigger.script_flag_set] = true;
      }
      if(isDefined(other)) {
        other notify("vehicle_flag_arrived", trigger.script_flag_set);
      }
      flag_set(trigger.script_flag_set);
    }
    if(isDefined(trigger.script_flag_clear)) {
      if(isDefined(other) && isDefined(other.vehicle_flags)) {
        other.vehicle_flags[trigger.script_flag_clear] = false;
      }
      flag_clear(trigger.script_flag_clear);
    }
    if(isDefined(other) && script_vehicledetour) {
      other thread path_detour_script_origin(trigger);
    } else if(detoured && isDefined(other)) {
      other thread path_detour(trigger);
    }
    if(isDefined(trigger.script_delay)) {
      wait trigger.script_delay;
    }
    targs = [];
    if(bTriggeronce) {
      if(isDefined(trigger.target) && isDefined(level.vehicle_target[trigger.target])) {
        targs = level.vehicle_target[trigger.target];
      }
      gotrigger = false;
    }
    if(isDefined(trigger.script_vehicleGroupDelete)) {
      if(!isDefined(level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete])) {
        println("failed to find deleteable vehicle with script_vehicleGroupDelete group number: ", trigger.script_vehicleGroupDelete);
        level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete] = [];
      }
      array_delete(level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete]);
    }
    if(script_vehiclespawngroup) {
      level notify("spawnvehiclegroup" + trigger.script_vehiclespawngroup);
      waittillframeend;
    }
    if(gates.size > 0 && bTriggeronce) {
      array_levelthread(gates, ::path_gate_open);
    }
    if(isDefined(trigger.script_VehicleStartMove)) {
      if(!isDefined(level.vehicle_StartMoveGroup[trigger.script_VehicleStartMove])) {
        println("^3Vehicle start trigger is: ", trigger.script_VehicleStartMove);
        return;
      }
      array_thread(level.vehicle_StartMoveGroup[trigger.script_VehicleStartMove], ::gopath);
    }
  }
}

path_detour_get_detourpath(detournode) {
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

path_detour_script_origin(detournode) {
  detourpath = path_detour_get_detourpath(detournode);
  if(isDefined(detourpath)) {
    self thread vehicle_paths(detourpath);
  }
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
    self setSwitchNode(node, detourpath);
    return;
  } else {
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
}

vehicle_Levelstuff(vehicle, trigger) {
  if(isDefined(vehicle.script_linkname)) {
    level.vehicle_link = array_2dadd(level.vehicle_link, vehicle.script_linkname, vehicle);
  }
  if(isDefined(vehicle.targetname)) {
    level.vehicle_target = array_2dadd(level.vehicle_target, vehicle.targetname, vehicle);
  }
  if(isDefined(vehicle.script_VehicleSpawngroup)) {
    level.vehicle_SpawnGroup = array_2dadd(level.vehicle_SpawnGroup, vehicle.script_VehicleSpawngroup, vehicle);
  }
  if(isDefined(vehicle.script_VehicleStartMove)) {
    level.vehicle_StartMoveGroup = array_2dadd(level.vehicle_StartMoveGroup, vehicle.script_VehicleStartMove, vehicle);
  }
  if(isDefined(vehicle.script_vehicleGroupDelete)) {
    level.vehicle_DeleteGroup = array_2dadd(level.vehicle_DeleteGroup, vehicle.script_vehicleGroupDelete, vehicle);
  }
}

spawn_array(spawners) {
  ai = [];
  for(i = 0; i < spawners.size; i++) {
    spawners[i].count = 1;
    dronespawn = false;
    if(isDefined(spawners[i].script_drone)) {
      dronespawn = true;
      spawned = dronespawn(spawners[i]);
    } else {
      spawned = spawners[i] spawn_ai();
      if(!IsAlive(spawned)) {
        continue;
      }
    }
    assert(isDefined(spawned));
    ai[ai.size] = spawned;
  }
  ai = remove_non_riders_from_array(ai);
  return ai;
}

remove_non_riders_from_array(ai) {
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

spawn_group() {
  HasRiders = (isDefined(self.script_vehicleride));
  HasWalkers = (isDefined(self.script_vehiclewalk));
  if(!(HasRiders || HasWalkers)) {
    return;
  }
  spawners = [];
  riderspawners = [];
  walkerspawners = [];
  if(HasRiders) {
    riderspawners = level.vehicle_RideSpawners[self.script_vehicleride];
  }
  if(!isDefined(riderspawners)) {
    riderspawners = [];
  }
  if(HasWalkers) {
    walkerspawners = level.vehicle_walkspawners[self.script_vehiclewalk];
  }
  if(!isDefined(walkerspawners)) {
    walkerspawners = [];
  }
  spawners = array_combine(riderspawners, walkerspawners);
  startinvehicles = [];
  for(i = 0; i < spawners.size; i++) {
    spawners[i].script_forcespawn = true;
  }
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
  for(i = 0; i < ai.size; i++) {
    ai[i] thread maps\_vehicle_aianim::vehicle_enter(self, self.script_tag);
  }
}

sort_by_startingpos(guysarray) {
  firstarray = [];
  secondarray = [];
  for(i = 0; i < guysarray.size; i++) {
    if(isDefined(guysarray[i].script_startingposition)) {
      firstarray[firstarray.size] = guysarray[i];
    } else {
      secondarray[secondarray.size] = guysarray[i];
    }
  }
  return array_combine(firstarray, secondarray);
}

vehicle_rider_walk_setup(vehicle) {
  if(!isDefined(self.script_vehiclewalk)) {
    return;
  }
  if(isDefined(self.script_followmode)) {
    self.FollowMode = self.script_followmode;
  } else {
    self.FollowMode = "cover nodes";
  }
  if(!isDefined(self.target)) {
    return;
  }
  node = getnode(self.target, "targetname");
  if(isDefined(node)) {
    self.NodeAftervehicleWalk = node;
  }
}

runtovehicle(guy) {
  guyarray = [];
  climbinnode = self.climbnode;
  climbinanim = self.climbanim;
  closenode = climbinnode[0];
  currentdist = 5000;
  thenode = undefined;
  for(i = 0; i < climbinnode.size; i++) {
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
  while(!guy.vehicle_goal) {
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
    guy enter_vehicle(self);
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
  if(!isDefined(realdetournode)) {
    return;
  }
  realdetournode.detoured = 0;
  add_proccess_trigger(realdetournode);
}

add_proccess_trigger(trigger) {
  if(isDefined(trigger.processed_trigger)) {
    return;
  }
  level.vehicle_processtriggers[level.vehicle_processtriggers.size] = trigger;
  trigger.processed_trigger = true;
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

vehicle_paths(node) {
  assertex(isDefined(node) || isDefined(self.attachedpath), "vehicle_path() called without a path");
  self notify("newpath");
  if(isDefined(node)) {
    self.attachedpath = node;
  }
  pathstart = self.attachedpath;
  self.currentNode = self.attachedpath;
  if(!isDefined(pathstart)) {
    return;
  }
  self endon("newpath");
  nextpoint = pathstart;
  while(isDefined(nextpoint)) {
    self waittill("reached_node", nextpoint);
    if(!isDefined(self)) {
      return;
    }
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
    if(isDefined(nextpoint.script_notify)) {
      self notify(nextpoint.script_notify);
      level notify(nextpoint.script_notify);
    }
    waittillframeend;
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(nextpoint.script_noteworthy)) {
      if(nextpoint.script_noteworthy == "godon") {
        self godon();
      } else if(nextpoint.script_noteworthy == "godoff") {
        self godoff();
      } else if(nextpoint.script_noteworthy == "deleteme") {
        self Delete();
        return;
      } else if(nextpoint.script_noteworthy == "drivepath") {
        self DrivePath();
      } else if(nextpoint.script_noteworthy == "lockpath") {
        self StartPath();
      } else if(nextpoint.script_noteworthy == "brake") {
        if(self.isphysicsvehicle) {
          self SetBrake(1);
        }
      }
    }
    if(isDefined(nextpoint.script_crashtypeoverride)) {
      self.script_crashtypeoverride = nextpoint.script_crashtypeoverride;
    }
    if(isDefined(nextpoint.script_badplace)) {
      self.script_badplace = nextpoint.script_badplace;
    }
    if(isDefined(nextpoint.script_turretmg)) {
      self.script_turretmg = nextpoint.script_turretmg;
    }
    if(isDefined(nextpoint.script_team)) {
      self.vteam = nextpoint.script_team;
    }
    if(isDefined(nextpoint.script_turningdir)) {
      self notify("turning", nextpoint.script_turningdir);
    }
    if(isDefined(nextpoint.script_deathroll)) {
      if(nextpoint.script_deathroll == 0) {
        self thread deathrolloff();
      } else {
        self thread deathrollon();
      }
    }
    if(isDefined(nextpoint.script_vehicleaianim)) {
      if(isDefined(nextpoint.script_parameters) && nextpoint.script_parameters == "queue") {
        self.queueanim = true;
      }
      if(isDefined(nextpoint.script_startingposition)) {
        self.groupedanim_pos = nextpoint.script_startingposition;
      }
      self notify("groupedanimevent", nextpoint.script_vehicleaianim);
    }
    if(isDefined(nextpoint.script_wheeldirection)) {
      self wheeldirectionchange(nextpoint.script_wheeldirection);
    }
    if(isDefined(nextpoint.script_exploder)) {
      level exploder(nextpoint.script_exploder);
    }
    if(isDefined(nextpoint.script_flag_set)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[nextpoint.script_flag_set] = true;
      }
      self notify("vehicle_flag_arrived", nextpoint.script_flag_set);
      flag_set(nextpoint.script_flag_set);
    }
    if(isDefined(nextpoint.script_flag_clear)) {
      if(isDefined(self.vehicle_flags)) {
        self.vehicle_flags[nextpoint.script_flag_clear] = false;
      }
      flag_clear(nextpoint.script_flag_clear);
    }
    if(isDefined(nextpoint.script_unload)) {
      self thread unload_node(nextpoint);
    }
    if(isDefined(nextpoint.script_wait)) {
      self SetSpeed(0, 10, 10);
      nextpoint script_wait();
      self ResumeSpeed(10);
    }
    if(isDefined(nextpoint.script_flag_wait)) {
      if(!isDefined(self.vehicle_flags)) {
        self.vehicle_flags = [];
      }
      self.vehicle_flags[nextpoint.script_flag_wait] = true;
      self notify("vehicle_flag_arrived", nextpoint.script_flag_wait);
      self ent_flag_set("waiting_for_flag");
      if(!flag(nextpoint.script_flag_wait)) {
        self SetSpeed(0, 10, 10);
      }
      flag_wait(nextpoint.script_flag_wait);
      self ent_flag_clear("waiting_for_flag");
      self ResumeSpeed(10);
    }
    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearLookAtEnt();
    }
    if(isDefined(nextpoint.script_lights_on)) {
      if(nextpoint.script_lights_on) {
        self lights_on();
      } else {
        self lights_off();
      }
    }
    if(isDefined(nextpoint.script_sirens_on)) {
      if(nextpoint.script_sirens_on) {
        self sirens_on();
      } else {
        self sirens_off();
      }
    }
    if(!isDefined(nextpoint.target)) {
      break;
    }
  }
  self notify("reached_dynamic_path_end");
  if(isDefined(self.script_vehicle_selfremove)) {
    self delete();
  }
}

must_stop_at_next_point(nextpoint) {
  if(isDefined(nextpoint.script_unload)) {
    return true;
  }
  return isDefined(nextpoint.script_flag_wait) && !flag(nextpoint.script_flag_wait);
}

setvehgoalnode(node) {
  self endon("death");
  stop = false;
  if(!isDefined(stop)) {
    stop = true;
  }
  if(isDefined(node.script_stopnode)) {
    stop = node.script_stopnode;
  }
  if(isDefined(node.script_unload)) {
    stop = true;
  }
  script_anglevehicle = isDefined(node.script_anglevehicle) && node.script_anglevehicle;
  script_goalyaw = isDefined(node.script_goalyaw) && node.script_goalyaw;
  if(isDefined(node.script_anglevehicle) || isDefined(node.script_goalyaw)) {
    self forcetarget(node, script_goalyaw, script_anglevehicle);
  } else {
    self unforcetarget();
  }
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
  if(self.health > 0) {
    self.rollingdeath = 1;
  }
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

getonpath(path_start) {
  if(!isDefined(path_start)) {
    return;
  }
  if(isDefined(self.hasstarted)) {
    self.hasstarted = undefined;
  }
  self.attachedpath = path_start;
  if(!isDefined(self.drivepath) || !self.drivepath) {
    self.origin = path_start.origin;
    self AttachPath(path_start);
  }
  if(!isDefined(self.dontDisconnectPaths)) {
    self DisconnectPaths();
  }
  if(is_true(self.isphysicsvehicle)) {
    self SetBrake(true);
  }
  self thread vehicle_paths();
}

create_vehicle_from_spawngroup_and_gopath(spawnGroup) {
  vehicleArray = maps\_vehicle::scripted_spawn(spawnGroup);
  for(i = 0; i < vehicleArray.size; i++) {
    if(isDefined(vehicleArray[i])) {
      vehicleArray[i] thread maps\_vehicle::gopath();
    }
  }
  return vehicleArray;
}

gopath() {
  self endon("death");
  self endon("stop path");
  if(self.isphysicsvehicle) {
    self SetBrake(false);
  }
  if(isDefined(self.script_vehiclestartmove)) {
    level.vehicle_StartMoveGroup[self.script_vehiclestartmove] = array_remove(level.vehicle_StartMoveGroup[self.script_vehiclestartmove], self);
  }
  if(isDefined(self.hasstarted)) {
    println("vehicle already moving when triggered with a startmove");
    return;
  } else {
    self.hasstarted = true;
  }
  self script_delay();
  self notify("start_vehiclepath");
  if(isDefined(self.drivepath) && self.drivepath) {
    self DrivePath(self.attachedpath);
  } else {
    self StartPath();
  }
  wait .05;
  self ConnectPaths();
  self waittill("reached_end_node");
  if(!isDefined(self.dontDisconnectPaths)) {
    self DisconnectPaths();
  }
  if(isDefined(self.currentnode) && isDefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme") {
    return;
  }
  if(!isDefined(self.dontunloadonend)) {
    do_unload(self.script_unloaddelay);
  }
}

do_unload(delay) {
  self endon("unload");
  if(isDefined(delay) && delay > 0) {
    wait delay;
  }
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
  if(self.health > 0) {
    script_resumespeed("gate opened", level.vehicle_ResumeSpeed);
  }
}

spawner_setup(vehicles, spawngroup, from) {
  if(!isDefined(level.vehicleSpawners)) {
    level.vehicleSpawners = [];
  }
  level.vehicleSpawners[spawngroup] = [];
  vehicle = [];
  for(i = 0; i < vehicles.size; i++) {
    vehicles[i] thread vehicle_main();
    if(!isDefined(vehicle[spawngroup])) {
      vehicle[spawngroup] = [];
    }
    script_struct = SpawnStruct();
    script_struct setspawnervariables(vehicles[i], from);
    vehicle[spawngroup] = array_add(vehicle[spawngroup], script_struct);
    level.vehicleSpawners[spawngroup][i] = script_struct;
  }
  while(1) {
    spawnedvehicles = [];
    level waittill("spawnvehiclegroup" + spawngroup);
    for(i = 0; i < vehicle[spawngroup].size; i++) {
      spawnedvehicles[spawnedvehicles.size] = vehicle_spawn(vehicle[spawngroup][i]);
    }
    level notify("vehiclegroup spawned" + spawngroup, spawnedvehicles);
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
  if(isDefined(vehicle.script_delay)) {
    self.script_delay = vehicle.script_delay;
  }
  if(isDefined(vehicle.script_noteworthy)) {
    self.script_noteworthy = vehicle.script_noteworthy;
  }
  if(isDefined(vehicle.script_parameters)) {
    self.script_parameters = vehicle.script_parameters;
  }
  if(isDefined(vehicle.script_team)) {
    self.vteam = vehicle.script_team;
  }
  if(isDefined(vehicle.script_vehicleride)) {
    self.script_vehicleride = vehicle.script_vehicleride;
  }
  if(isDefined(vehicle.target)) {
    self.target = vehicle.target;
  }
  if(isDefined(vehicle.targetname)) {
    self.targetname = vehicle.targetname;
  } else {
    self.targetname = "notdefined";
  }
  self.spawnedtargetname = self.targetname;
  self.targetname = self.targetname + "_vehiclespawner";
  if(isDefined(vehicle.triggeredthink)) {
    self.triggeredthink = vehicle.triggeredthink;
  }
  if(isDefined(vehicle.script_sound)) {
    self.script_sound = vehicle.script_sound;
  }
  if(isDefined(vehicle.script_turretmg)) {
    self.script_turretmg = vehicle.script_turretmg;
  }
  if(isDefined(vehicle.script_startinghealth)) {
    self.script_startinghealth = vehicle.script_startinghealth;
  }
  if(isDefined(vehicle.spawnerNum)) {
    self.spawnerNum = vehicle.spawnerNum;
  }
  if(isDefined(vehicle.script_deathnotify)) {
    self.script_deathnotify = vehicle.script_deathnotify;
  }
  if(isDefined(vehicle.script_turret)) {
    self.script_turret = vehicle.script_turret;
  }
  if(isDefined(vehicle.script_linkTo)) {
    self.script_linkTo = vehicle.script_linkTo;
  }
  if(isDefined(vehicle.script_VehicleSpawngroup)) {
    self.script_VehicleSpawngroup = vehicle.script_VehicleSpawngroup;
  }
  if(isDefined(vehicle.script_VehicleStartMove)) {
    self.script_VehicleStartMove = vehicle.script_VehicleStartMove;
  }
  if(isDefined(vehicle.script_vehicleGroupDelete)) {
    self.script_vehicleGroupDelete = vehicle.script_vehicleGroupDelete;
  }
  if(isDefined(vehicle.script_vehicle_selfremove)) {
    self.script_vehicle_selfremove = vehicle.script_vehicle_selfremove;
  }
  if(isDefined(vehicle.script_nomg)) {
    self.script_nomg = vehicle.script_nomg;
  }
  if(isDefined(vehicle.script_badplace)) {
    self.script_badplace = vehicle.script_badplace;
  }
  if(isDefined(vehicle.script_vehicleride)) {
    self.script_vehicleride = vehicle.script_vehicleride;
  }
  if(isDefined(vehicle.script_vehiclewalk)) {
    self.script_vehiclewalk = vehicle.script_vehiclewalk;
  }
  if(isDefined(vehicle.script_linkName)) {
    self.script_linkName = vehicle.script_linkName;
  }
  if(isDefined(vehicle.script_crashtypeoverride)) {
    self.script_crashtypeoverride = vehicle.script_crashtypeoverride;
  }
  if(isDefined(vehicle.script_unloaddelay)) {
    self.script_unloaddelay = vehicle.script_unloaddelay;
  }
  if(isDefined(vehicle.script_unloadmgguy)) {
    self.script_unloadmgguy = vehicle.script_unloadmgguy;
  }
  if(isDefined(vehicle.script_keepdriver)) {
    self.script_keepdriver = vehicle.script_keepdriver;
  }
  if(isDefined(vehicle.script_fireondrones)) {
    self.script_fireondrones = vehicle.script_fireondrones;
  }
  if(isDefined(vehicle.script_tankgroup)) {
    self.script_tankgroup = vehicle.script_tankgroup;
  }
  if(isDefined(vehicle.script_playerconeradius)) {
    self.script_playerconeradius = vehicle.script_playerconeradius;
  }
  if(isDefined(vehicle.script_cobratarget)) {
    self.script_cobratarget = vehicle.script_cobratarget;
  }
  if(isDefined(vehicle.script_targettype)) {
    self.script_targettype = vehicle.script_targettype;
  }
  if(isDefined(vehicle.script_targetoffset_z)) {
    self.script_targetoffset_z = vehicle.script_targetoffset_z;
  }
  if(isDefined(vehicle.script_wingman)) {
    self.script_wingman = vehicle.script_wingman;
  }
  if(isDefined(vehicle.script_mg_angle)) {
    self.script_mg_angle = vehicle.script_mg_angle;
  }
  if(isDefined(vehicle.script_physicsjolt)) {
    self.script_physicsjolt = vehicle.script_physicsjolt;
  }
  if(isDefined(vehicle.script_lights_on)) {
    self.script_lights_on = vehicle.script_lights_on;
  }
  if(isDefined(vehicle.script_sirens_on)) {
    self.script_sirens_on = vehicle.script_sirens_on;
  }
  if(isDefined(vehicle.script_vehicledetourgroup)) {
    self.script_vehicledetourgroup = vehicle.script_vehicledetourgroup;
  }
  if(isDefined(vehicle.speed)) {
    self.speed = vehicle.speed;
  }
  if(isDefined(vehicle.script_vehicletriggergroup)) {
    self.script_vehicletriggergroup = vehicle.script_vehicletriggergroup;
  }
  if(isDefined(vehicle.script_cheap)) {
    self.script_cheap = vehicle.script_cheap;
  }
  if(isDefined(vehicle.script_volume)) {
    self.script_volume = vehicle.script_volume;
  }
  if(isDefined(vehicle.script_nonmovingvehicle)) {
    self.script_nonmovingvehicle = vehicle.script_nonmovingvehicle;
  }
  if(isDefined(vehicle.script_flag)) {
    self.script_flag = vehicle.script_flag;
  }
  if(isDefined(vehicle.script_disconnectpaths)) {
    self.script_disconnectpaths = vehicle.script_disconnectpaths;
  }
  if(isDefined(vehicle.script_bulletshield)) {
    self.script_bulletshield = vehicle.script_bulletshield;
  }
  if(isDefined(vehicle.script_volumeramp)) {
    self.script_volumeramp = vehicle.script_volumeramp;
  }
  if(isDefined(vehicle.script_godmode)) {
    self.script_godmode = vehicle.script_godmode;
  }
  if(isDefined(vehicle.script_vehicleattackgroup)) {
    self.script_vehicleattackgroup = vehicle.script_vehicleattackgroup;
  }
  if(isDefined(vehicle.script_vehicleattackgroupwait)) {
    self.script_vehicleattackgroupwait = vehicle.script_vehicleattackgroupwait;
  }
  if(isDefined(vehicle.script_friendname)) {
    self.script_friendname = vehicle.script_friendname;
  }
  if(isDefined(vehicle.script_unload)) {
    self.script_unload = vehicle.script_unload;
  }
  if(isDefined(vehicle.script_string)) {
    self.script_string = vehicle.script_string;
  }
  if(isDefined(vehicle.script_int)) {
    self.script_int = vehicle.script_int;
  }
  if(isDefined(vehicle.script_ignoreme)) {
    self.script_ignoreme = vehicle.script_ignoreme;
  }
  if(vehicle.count > 0) {
    self.count = vehicle.count;
  } else {
    self.count = 1;
  }
  if(!isDefined(self.vehicletype)) {
    if(isDefined(vehicle.vehicletype)) {
      self.vehicletype = vehicle.vehicletype;
    } else {
      self.vehicletype = maps\_vehicletypes::get_type(vehicle.model);
    }
  }
  if(isDefined(vehicle.destructibledef)) {
    self.destructibledef = vehicle.destructibledef;
  }
  if(!(vehicle.spawnflags & 2) && vehicle IsVehicleUsable()) {
    self.usable = 1;
  }
  if(isDefined(vehicle.drivepath)) {
    self.drivepath = vehicle.drivepath;
  }
  if(isDefined(vehicle.script_numbombs)) {
    self.script_numbombs = vehicle.script_numbombs;
  }
  if(isDefined(vehicle.exhaust_fx)) {
    self.exhaust_fx = vehicle.exhaust_fx;
  }
  if(isDefined(vehicle.deathfx)) {
    self.deathfx = vehicle.deathfx;
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
  while(true) {
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
  if(!vspawner.count) {
    return;
  }
  vehicle = spawnVehicle(vspawner.spawnermodel, vspawner.spawnedtargetname, vspawner.vehicletype, vspawner.origin, vspawner.angles, vspawner.destructibledef);
  if(isDefined(vspawner.destructibledef)) {
    vehicle.destructibledef = vspawner.destructibledef;
    vehicle thread maps\_destructible::destructible_think();
  }
  if(isDefined(vspawner.script_delay)) {
    vehicle.script_delay = vspawner.script_delay;
  }
  if(isDefined(vspawner.script_noteworthy)) {
    vehicle.script_noteworthy = vspawner.script_noteworthy;
  }
  if(isDefined(vspawner.script_parameters)) {
    vehicle.script_parameters = vspawner.script_parameters;
  }
  if(isDefined(vspawner.script_team)) {
    vehicle.vteam = vspawner.script_team;
  }
  if(isDefined(vspawner.script_vehicleride)) {
    vehicle.script_vehicleride = vspawner.script_vehicleride;
  }
  if(isDefined(vspawner.target)) {
    vehicle.target = vspawner.target;
  }
  if(isDefined(vspawner.vehicletype) && !isDefined(vehicle.vehicletype)) {
    vehicle.vehicletype = vspawner.vehicletype;
  }
  if(isDefined(vspawner.triggeredthink)) {
    vehicle.triggeredthink = vspawner.triggeredthink;
  }
  if(isDefined(vspawner.script_sound)) {
    vehicle.script_sound = vspawner.script_sound;
  }
  if(isDefined(vspawner.script_turretmg)) {
    vehicle.script_turretmg = vspawner.script_turretmg;
  }
  if(isDefined(vspawner.script_startinghealth)) {
    vehicle.script_startinghealth = vspawner.script_startinghealth;
  }
  if(isDefined(vspawner.script_deathnotify)) {
    vehicle.script_deathnotify = vspawner.script_deathnotify;
  }
  if(isDefined(vspawner.script_turret)) {
    vehicle.script_turret = vspawner.script_turret;
  }
  if(isDefined(vspawner.script_linkTo)) {
    vehicle.script_linkTo = vspawner.script_linkTo;
  }
  if(isDefined(vspawner.script_VehicleSpawngroup)) {
    vehicle.script_VehicleSpawngroup = vspawner.script_VehicleSpawngroup;
  }
  if(isDefined(vspawner.script_VehicleStartMove)) {
    vehicle.script_VehicleStartMove = vspawner.script_VehicleStartMove;
  }
  if(isDefined(vspawner.script_vehicleGroupDelete)) {
    vehicle.script_vehicleGroupDelete = vspawner.script_vehicleGroupDelete;
  }
  if(isDefined(vspawner.script_vehicle_selfremove)) {
    vehicle.script_vehicle_selfremove = vspawner.script_vehicle_selfremove;
  }
  if(isDefined(vspawner.script_nomg)) {
    vehicle.script_nomg = vspawner.script_nomg;
  }
  if(isDefined(vspawner.script_badplace)) {
    vehicle.script_badplace = vspawner.script_badplace;
  }
  if(isDefined(vspawner.script_vehicleride)) {
    vehicle.script_vehicleride = vspawner.script_vehicleride;
  }
  if(isDefined(vspawner.script_vehiclewalk)) {
    vehicle.script_vehiclewalk = vspawner.script_vehiclewalk;
  }
  if(isDefined(vspawner.script_linkName)) {
    vehicle.script_linkName = vspawner.script_linkName;
  }
  if(isDefined(vspawner.script_crashtypeoverride)) {
    vehicle.script_crashtypeoverride = vspawner.script_crashtypeoverride;
  }
  if(isDefined(vspawner.script_unloaddelay)) {
    vehicle.script_unloaddelay = vspawner.script_unloaddelay;
  }
  if(isDefined(vspawner.script_unloadmgguy)) {
    vehicle.script_unloadmgguy = vspawner.script_unloadmgguy;
  }
  if(isDefined(vspawner.script_keepdriver)) {
    vehicle.script_keepdriver = vspawner.script_keepdriver;
  }
  if(isDefined(vspawner.script_fireondrones)) {
    vehicle.script_fireondrones = vspawner.script_fireondrones;
  }
  if(isDefined(vspawner.script_tankgroup)) {
    vehicle.script_tankgroup = vspawner.script_tankgroup;
  }
  if(isDefined(vspawner.script_playerconeradius)) {
    vehicle.script_playerconeradius = vspawner.script_playerconeradius;
  }
  if(isDefined(vspawner.script_cobratarget)) {
    vehicle.script_cobratarget = vspawner.script_cobratarget;
  }
  if(isDefined(vspawner.script_targettype)) {
    vehicle.script_targettype = vspawner.script_targettype;
  }
  if(isDefined(vspawner.script_targetoffset_z)) {
    vehicle.script_targetoffset_z = vspawner.script_targetoffset_z;
  }
  if(isDefined(vspawner.script_wingman)) {
    vehicle.script_wingman = vspawner.script_wingman;
  }
  if(isDefined(vspawner.script_mg_angle)) {
    vehicle.script_mg_angle = vspawner.script_mg_angle;
  }
  if(isDefined(vspawner.script_physicsjolt)) {
    vehicle.script_physicsjolt = vspawner.script_physicsjolt;
  }
  if(isDefined(vspawner.script_cheap)) {
    vehicle.script_cheap = vspawner.script_cheap;
  }
  if(isDefined(vspawner.script_flag)) {
    vehicle.script_flag = vspawner.script_flag;
  }
  if(isDefined(vspawner.script_lights_on)) {
    vehicle.script_lights_on = vspawner.script_lights_on;
  }
  if(isDefined(vspawner.script_sirens_on)) {
    vehicle.script_sirens_on = vspawner.script_sirens_on;
  }
  if(isDefined(vspawner.script_vehicledetourgroup)) {
    vehicle.script_vehicledetourgroup = vspawner.script_vehicledetourgroup;
  }
  if(isDefined(vspawner.speed)) {
    vehicle.speed = vspawner.speed;
  }
  if(isDefined(vspawner.script_volume)) {
    vehicle.script_volume = vspawner.script_volume;
  }
  if(isDefined(vspawner.spawner_id)) {
    vehicle.spawner_id = vspawner.spawner_id;
  }
  if(isDefined(vspawner.script_vehicletriggergroup)) {
    vehicle.script_vehicletriggergroup = vspawner.script_vehicletriggergroup;
  }
  if(isDefined(vspawner.script_disconnectpaths)) {
    vehicle.script_disconnectpaths = vspawner.script_disconnectpaths;
  }
  if(isDefined(vspawner.script_godmode)) {
    vehicle.script_godmode = vspawner.script_godmode;
  }
  if(isDefined(vspawner.script_bulletshield)) {
    vehicle.script_bulletshield = vspawner.script_bulletshield;
  }
  if(isDefined(vspawner.script_volumeramp)) {
    vehicle.script_volumeramp = vspawner.script_volumeramp;
  }
  if(isDefined(vspawner.script_numbombs)) {
    vehicle.script_numbombs = vspawner.script_numbombs;
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
  if(isDefined(vspawner.script_unload)) {
    vehicle.unload_group = vspawner.script_unload;
  }
  if(isDefined(vspawner.script_string)) {
    vehicle.script_string = vspawner.script_string;
  }
  if(isDefined(vspawner.script_int)) {
    vehicle.script_int = vspawner.script_int;
  }
  vehicle_init(vehicle);
  if(isDefined(vehicle.targetname)) {
    level notify("new_vehicle_spawned" + vehicle.targetname, vehicle);
  }
  if(isDefined(vehicle.script_noteworthy)) {
    level notify("new_vehicle_spawned" + vehicle.script_noteworthy, vehicle);
  }
  if(isDefined(vehicle.spawner_id)) {
    level notify("new_vehicle_spawned" + vehicle.spawner_id, vehicle);
  }
  if(isDefined(vspawner.usable)) {
    vehicle makeVehicleUsable();
  }
  if(isDefined(vspawner.drivepath)) {
    vehicle.drivepath = vspawner.drivepath;
  }
  if(isDefined(vspawner.exhaust_fx)) {
    vehicle.exhaust_fx = vspawner.exhaust_fx;
  }
  if(isDefined(vspawner.deathfx)) {
    vehicle.deathfx = vspawner.deathfx;
  }
  if(isDefined(vspawner.script_ignoreme)) {
    vehicle.script_ignoreme = vspawner.script_ignoreme;
  }
  if(vehicle.vteam == "axis" && isDefined(level.vehicle_enemy_tanks[vspawner.spawnermodel])) {
    vehicle thread vehicleDamageAssist();
  }
  if(isDefined(vspawner.spawn_funcs)) {
    for(i = 0; i < vspawner.spawn_funcs.size; i++) {
      if(isDefined(vehicle)) {
        func = vspawner.spawn_funcs[i];
        single_thread(vehicle, func["function"], func["param1"], func["param2"], func["param3"], func["param4"]);
      }
    }
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
  struct setspawnervariables(vehicle);
  return vehicle_spawn(struct);
}

vehicle_init(vehicle) {
  vehicle UseAnimTree(#animtree);
  if(vehicle.classname == "script_model") {
    vehicle = spawn_through(vehicle);
    return;
  }
  vehicle ent_flag_init("waiting_for_flag");
  vehicle.takedamage = !is_true(vehicle.script_godmode);
  vehicle.zerospeed = true;
  if(!isDefined(vehicle.modeldummyon)) {
    vehicle.modeldummyon = false;
  }
  type = vehicle.vehicletype;
  vehicle vehicle_life();
  vehicle thread vehicle_main();
  vehicle vehicle_setteam();
  vehicle thread maingun_FX();
  vehicle.riders = [];
  vehicle.unloadque = [];
  if(!isDefined(vehicle.unload_group)) {
    vehicle.unload_group = "default";
  }
  vehicle.getoutrig = [];
  if(isDefined(level.vehicle_attachedmodels) && isDefined(level.vehicle_attachedmodels[type])) {
    rigs = level.vehicle_attachedmodels[type];
    strings = getarraykeys(rigs);
    for(i = 0; i < strings.size; i++) {
      vehicle.getoutrig[strings[i]] = undefined;
      vehicle.getoutriganimating[strings[i]] = false;
    }
  }
  vehicle thread vehicle_badplace();
  if(is_true(vehicle.script_lights_on)) {
    vehicle lights_on();
  }
  if(is_true(vehicle.script_sirens_on)) {
    vehicle sirens_on();
  }
  if(!vehicle isCheap()) {
    vehicle friendlyfire_shield();
  }
  vehicle thread maps\_vehicle_aianim::handle_attached_guys();
  if(!vehicle isCheap()) {
    vehicle thread vehicle_handleunloadevent();
  }
  vehicle thread turret_attack_think();
  if(!vehicle isCheap()) {
    vehicle thread vehicle_weapon_fired();
  }
  if(isDefined(vehicle.script_physicsjolt) && vehicle.script_physicsjolt) {
    vehicle thread physicsjolt_proximity();
  }
  vehicle_Levelstuff(vehicle);
  vehicle thread vehicle_compasshandle();
  vehicle thread animate_drive_idle();
  if(!vehicle isCheap()) {
    vehicle thread mginit();
  }
  if(isDefined(level.vehicleSpawnCallbackThread)) {
    level thread[[level.vehicleSpawnCallbackThread]](vehicle);
  }
  if(!vehicle isCheap()) {
    vehicle thread disconnect_paths_whenstopped();
  }
  if(!isDefined(vehicle.script_nonmovingvehicle)) {
    path_start = undefined;
    if(isDefined(vehicle.target)) {
      path_start = GetVehicleNode(vehicle.target, "targetname");
      if(!isDefined(path_start)) {
        path_start = getEnt(vehicle.target, "targetname");
        if(!isDefined(path_start)) {
          path_start = getstruct(vehicle.target, "targetname");
        }
      }
    }
    if(isDefined(path_start) && vehicle.vehicletype != "inc_base_jump_spotlight") {
      vehicle thread getonpath(path_start);
    }
  }
  if(isDefined(vehicle.script_vehicleattackgroup)) {
    vehicle thread attackgroup_think();
  }
  if(vehicle hasHelicopterDustKickup()) {
    if(!level.clientscripts) {
      vehicle thread aircraft_dust_kickup();
    }
  }
  vehicle spawn_group();
  vehicle thread kill();
  if(!isDefined(vehicle.script_volume)) {
    vehicle thread init_ramp_volume();
  }
  vehicle apply_truckjunk();
}

init_ramp_volume() {
  time = 2;
  if(self is_plane()) {
    time = 1;
  }
  if(isDefined(self.script_volumeramp)) {
    time = self.script_volumeramp;
  }
  self volume_up(time);
}

kill_damage() {
  if(!isDefined(self) || self.radiusdamageradius <= 0) {
    return;
  }
  wait(0.05);
  if(isDefined(self)) {
    self RadiusDamage(self.origin, self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");
  }
}

kill() {
  self endon("nodeath_thread");
  type = self.vehicletype;
  model = self.model;
  targetname = self.targetname;
  attacker = undefined;
  arcadeModePointsRewarded = false;
  while(1) {
    rumbletrigger = self.rumbletrigger;
    mgturret = self.mgturret;
    vteam = self.vteam;
    script_linkname = self.script_linkname;
    if(isDefined(self)) {
      self waittill("death", attacker);
    }
    if(arcadeMode() && false == arcadeModePointsRewarded) {
      if(isDefined(self.vteam) && (self.vteam != "allies")) {
        if(isDefined(self.attackers)) {
          for(i = 0; i < self.attackers.size; i++) {
            player = self.attackers[i];
            if(!isDefined(player)) {
              continue;
            }
            if(player == attacker) {
              continue;
            }
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
    if(isDefined(self)) {
      self lights_off();
      self sirens_off();
      self interior_lights_off();
    }
    if(isDefined(rumbletrigger)) {
      rumbletrigger delete();
    }
    if(isDefined(mgturret)) {
      array_levelthread(mgturret, ::turret_deleteme);
      mgturret = undefined;
    }
    if(isDefined(vteam)) {
      level.vehicles[vteam] = array_remove(level.vehicles[vteam], self);
    }
    if(isDefined(script_linkname)) {
      level.vehicle_link[script_linkname] = array_remove(level.vehicle_link[script_linkname], self);
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
    if(!isDefined(self) || is_corpse()) {
      if(isDefined(self.riders)) {
        for(j = 0; j < self.riders.size; j++) {
          if(isDefined(self.riders[j])) {
            self.riders[j] delete();
          }
        }
      }
      if(self is_corpse()) {
        self.riders = [];
        continue;
      }
      self notify("delete_destructible");
      return;
    }
    if(isDefined(level.vehicle_death_thread[type])) {
      thread[[level.vehicle_death_thread[type]]]();
    }
    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      Earthquake(
        self.deathquakescale,
        self.deathquakeduration,
        self.origin,
        self.deathquakeradius
      );
    }
    thread kill_damage();
    if(!isDefined(self.destructibledef)) {
      if(isDefined(self.deathmodel) && self.deathmodel != "") {
        self thread set_death_model(self.deathmodel, self.modelswapdelay);
      }
      if((!isDefined(self.mantled) || !self.mantled) && !isDefined(self.nodeathfx)) {
        thread kill_fx();
      }
      if(isDefined(self.delete_on_death)) {
        wait(0.05);
        if(!isDefined(self.dontDisconnectPaths)) {
          self disconnectpaths();
        }
        self freevehicle();
        self.isacorpse = true;
        wait 0.05;
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
      } else if(self is_plane()) {
        crashtype = "aircraft";
      } else if(self is_helicopter()) {
        crashtype = "helicopter";
      } else if(isDefined(self.currentnode) && crash_path_check(self.currentnode)) {
        crashtype = "none";
      } else {
        crashtype = "tank";
      }
      if(crashtype == "aircraft") {
        self thread aircraft_crash();
      }
      if(crashtype == "helicopter") {
        if(isDefined(self.script_nocorpse)) {
          self thread helicopter_explode();
        } else {
          self thread helicopter_crash();
        }
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
    if(isDefined(self.turretweapon) && self.turretweapon != "") {
      self clearTurretTarget();
    }
    if(isDefined(self) && (self is_plane() || self is_boat())) {
      if((isDefined(self.crashing)) && (self.crashing == true)) {
        self waittill("crash_done");
      }
    } else {
      if(isDefined(self.isphysicsvehicle) && self.isphysicsvehicle) {
        while(isDefined(self) && self GetSpeedMPH() > 2.0) {
          wait(0.1);
        }
      } else {
        while(isDefined(self) && self getspeedmph() > 0) {
          wait(0.1);
        }
      }
    }
    self notify("stop_looping_death_fx");
    self notify("death_finished");
    wait(0.5);
    if(is_corpse()) {
      continue;
    }
    if(isDefined(self)) {
      while(isDefined(self.dontfreeme) && isDefined(self)) {
        wait(.05);
      }
      if(!isDefined(self)) {
        continue;
      }
      occupants = self GetVehOccupants();
      if(isDefined(occupants) && occupants.size) {
        for(i = 0; i < occupants.size; i++) {
          self UseBy(occupants[i]);
        }
      }
      self freevehicle();
      self.isacorpse = true;
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
  if(isDefined(self)) {
    if(is_true(self.isacorpse)) {
      return true;
    } else if(isDefined(self.classname) && (self.classname == "script_vehicle_corpse")) {
      return true;
    }
  }
  return false;
}

set_death_model(sModel, fDelay) {
  assert(isDefined(sModel));
  if(isDefined(fDelay) && (fDelay > 0)) {
    wait fDelay;
  }
  if(!isDefined(self)) {
    return;
  }
  eModel = get_dummy();
  eModel clearanim( % root, 0);
  if(isDefined(self)) {
    eModel setModel(sModel);
    eModel SetVehicleAttachments(1);
  }
}

aircraft_crash() {
  self.crashing = true;
  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading)) {
      wait(0.05);
    }
  }
  if(!isDefined(self)) {
    return;
  }
  self thread aircraft_crash_move();
}

helicopter_crash() {
  self.crashing = true;
  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading)) {
      wait(0.05);
    }
  }
  if(!isDefined(self)) {
    return;
  }
  level thread helicopter_crash_move(self);
}

helicopter_explode() {
  fx_origin = self GetTagOrigin(self.kill_fx_struct.tag);
  PlayFx(self.kill_fx_struct.effect, fx_origin);
  self Delete();
}

get_unused_crash_locations() {
  unusedLocations = [];
  for(i = 0; i < level.helicopter_crash_locations.size; i++) {
    if(isDefined(level.helicopter_crash_locations[i].claimed)) {
      continue;
    }
    unusedLocations[unusedLocations.size] = level.helicopter_crash_locations[i];
  }
  return unusedLocations;
}

aircraft_crash_move() {
  self endon("death");
  forward = AnglesToForward(self.angles + (45, 0, 0));
  dest_point = self.origin + vector_scale(forward, 10000);
  dest_point = (dest_point[0], dest_point[1], -700);
  self SetSpeed(300, 30);
  self SetNearGoalNotifyDist(300);
  self SetVehGoalPos(dest_point, 1);
  self waittill_any("goal", "near_goal");
  self notify("crash_done");
}

helicopter_crash_move(heli) {
  death_model = heli.deathmodel;
  death_org = heli.origin;
  death_angles = heli.angles;
  death_heli = spawn("script_model", death_org);
  death_heli setModel(death_model);
  death_heli.angles = death_angles;
  death_heli PhysicsLaunch(death_heli.origin, (200, 0, 0));
  if(isDefined(heli.kill_fx_struct.effect) && isDefined(heli.kill_fx_struct.tag)) {
    PlayFxOnTag(heli.kill_fx_struct.effect, death_heli, heli.kill_fx_struct.tag);
  }
  heli Delete();
}

crash_path_check(node) {
  targ = node;
  search_depth = 5;
  while(isDefined(targ) && search_depth >= 0) {
    if((isDefined(targ.detoured)) && (targ.detoured == 0)) {
      detourpath = path_detour_get_detourpath(getvehiclenode(targ.target, "targetname"));
      if(isDefined(detourpath) && isDefined(detourpath.script_crashtype)) {
        return true;
      }
    }
    if(isDefined(targ.target)) {
      targ1 = getvehiclenode(targ.target, "targetname");
      if(isDefined(targ1) && isDefined(targ1.target) && isDefined(targ.targetname) && targ1.target == targ.targetname) {
        return false;
      } else if(isDefined(targ1) && targ1 == node) {
        return false;
      } else {
        targ = targ1;
      }
    } else {
      targ = undefined;
    }
    search_depth--;
  }
  return false;
}

death_firesound(sound) {
  self thread play_loop_sound_on_tag(sound, undefined, false);
  self waittill_any("fire_extinguish", "stop_crash_loop_sound");
  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + sound);
}

kill_fx() {
  if(self isdestructible()) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self explode_notify_wrapper();
  struct = build_death_fx(self.deathfx, self.deathfxtag, self.deathfxsound);
  thread kill_fx_thread(struct);
}

vehicle_flag_arrived(msg) {
  if(!isDefined(self.vehicle_flags)) {
    self.vehicle_flags = [];
  }
  while(!isDefined(self.vehicle_flags[msg])) {
    self waittill("vehicle_flag_arrived", notifymsg);
    if(msg == notifymsg) {
      return;
    }
  }
}

kill_fx_thread(struct) {
  assert(isDefined(struct));
  if(isDefined(struct.waitDelay)) {
    if(struct.waitDelay >= 0) {
      wait struct.waitDelay;
    } else {
      self waittill("death_finished");
    }
  }
  if(!isDefined(self)) {
    return;
  }
  if(self is_helicopter()) {
    self.kill_fx_struct = struct;
    return;
  }
  if(isDefined(struct.notifyString)) {
    self notify(struct.notifyString);
  }
  eModel = get_dummy();
  if(isDefined(struct.effect)) {
    if((struct.bEffectLooping) && (!isDefined(self.delete_on_death))) {
      if(isDefined(struct.tag)) {
        if((isDefined(struct.stayontag)) && (struct.stayontag == true)) {
          thread loop_fx_on_vehicle_tag(struct.effect, struct.delay, struct.tag);
        } else {
          thread playLoopedFxontag(struct.effect, struct.delay, struct.tag);
        }
      } else {
        forward = (eModel.origin + (0, 0, 100)) - eModel.origin;
        playfx(struct.effect, eModel.origin, forward);
      }
    } else if(isDefined(struct.tag)) {
      if(isDefined(self.modeldummyon) && self.modeldummyon) {
        playfxontag(struct.effect, deathfx_ent(), struct.tag);
      } else {
        playfxontag(struct.effect, self, struct.tag);
      }
    } else {
      forward = (eModel.origin + (0, 0, 100)) - eModel.origin;
      playfx(struct.effect, eModel.origin, forward);
    }
  }
  if((isDefined(struct.sound)) && (!isDefined(self.delete_on_death))) {
    if(struct.bSoundlooping) {
      thread death_firesound(struct.sound);
    } else {
      self play_sound_in_space(struct.sound);
    }
  }
}

loop_fx_on_vehicle_tag(effect, loopTime, tag) {
  assert(isDefined(effect));
  assert(isDefined(tag));
  assert(isDefined(loopTime));
  self endon("stop_looping_death_fx");
  while(isDefined(self)) {
    playfxontag(effect, deathfx_ent(), tag);
    wait loopTime;
  }
}

build_death_fx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString) {
  if(!isDefined(bSoundlooping)) {
    bSoundlooping = false;
  }
  if(!isDefined(bEffectLooping)) {
    bEffectLooping = false;
  }
  if(!isDefined(delay)) {
    delay = 1;
  }
  struct = spawnstruct();
  struct.effect = effect;
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

get_script_modelvehicles() {
  array = [];
  models = getentarray("script_model", "classname");
  if(isDefined(level.modelvehicles)) {
    return level.modelvehicles;
  }
  level.modelvehicles = [];
  for(i = 0; i < models.size; i++) {
    if(isDefined(models[i].targetname) &&
      (models[i].targetname == "destructible" ||
        models[i].targetname == "zpu" ||
        models[i].targetname == "exploder")) {
      continue;
    }
    if(isDefined(models[i].script_noteworthy) && models[i].script_noteworthy == "notvehicle") {
      continue;
    }
    if(maps\_vehicletypes::is_type(models[i].model)) {
      array[array.size] = models[i];
      models[i].vehicletype = maps\_vehicletypes::get_type(models[i].model);
    }
  }
  level.modelvehicles = array;
  return level.modelvehicles;
}

precache_scripts() {
  vehicles = getentarray("script_vehicle", "classname");
  vehicles = array_combine(vehicles, get_script_modelvehicles());
  playerdrivablevehicles = [];
  allvehiclesprespawn = [];
  for(i = 0; i < vehicles.size; i++) {
    if(vehicles[i] has_spawnflag(level.SPAWNFLAG_VEHICLE_USEABLE)) {
      playerdrivablevehicles[playerdrivablevehicles.size] = vehicles[i];
    }
    allvehiclesprespawn[allvehiclesprespawn.size] = vehicles[i];
  }
  if(playerdrivablevehicles.size > 0) {
    thread maps\_vehicledrive::main();
  }
  return allvehiclesprespawn;
}

vehicle_modelinarray(arrayofmodels, model) {
  for(i = 0; i < arrayofmodels.size; i++) {
    if(arrayofmodels[i] == model) {
      return true;
    }
  }
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
  while(isDefined(self)) {
    if(self getspeed() < 1) {
      if(!isDefined(self.dontDisconnectPaths)) {
        self disconnectpaths();
      }
      self notify("speed_zero_path_disconnect");
      while(self getspeed() < 1) {
        wait(0.05);
      }
    }
    self connectpaths();
    wait(1);
  }
}

vehicle_setspeed(speed, rate, msg) {
  if(self getspeedmph() == 0 && speed == 0) {
    return;
  }
  self setspeed(speed, rate);
}

debug_vehiclesetspeed(speed, rate, msg) {}
script_resumespeed(msg, rate) {
  self endon("death");
  fSetspeed = 0;
  type = "resumespeed";
  if(!isDefined(self.resumemsgs)) {
    self.resumemsgs = [];
  }
  if(isDefined(self.waitingforgate) && self.waitingforgate) {
    return;
  }
  if(isDefined(self.attacking) && self.attacking) {
    fSetspeed = self.attackspeed;
    type = "setspeed";
  }
  self.zerospeed = false;
  if(fSetspeed == 0) {
    self.zerospeed = true;
  }
  if(type == "resumespeed") {
    self resumespeed(rate);
  } else if(type == "setspeed") {
    self vehicle_setspeed(fSetspeed, 15, "resume setspeed from attack");
  }
  self notify("resuming speed");
}

print_resumespeed(timer) {
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
      print3d(self.origin + (0, 0, position), "resuming speed: " + self.resumemsgs[i], (0, 1, 0), 1, 3);
    }
    wait .05;
  }
}

godon() {
  self.takedamage = false;
}

godoff() {
  self.takedamage = true;
}

setturretfireondrones(b) {
  if(isDefined(self.mgturret) && self.mgturret.size) {
    for(i = 0; i < self.mgturret.size; i++) {
      self.mgturret[i].script_fireondrones = b;
    }
  }
}

getnormalanimtime(animation) {
  animtime = self getanimtime(animation);
  animlength = getanimlength(animation);
  if(animtime == 0) {
    return 0;
  }
  return self getanimtime(animation) / getanimlength(animation);
}

rotor_anim() {
  length = getanimlength(self getanim("rotors"));
  for(;;) {
    self setanim(self getanim("rotors"), 1, 0, 1);
    wait(length);
  }
}

animate_drive_idle() {
  if(!isDefined(self.wheeldir)) {
    self.wheeldir = 1;
  }
  model = self.model;
  if(isDefined(self.isphysicsvehicle) && self.isphysicsvehicle) {
    return;
  }
  if(!isDefined(level.vehicle_DriveIdle[model])) {
    return;
  }
  newanimtime = undefined;
  if(!isDefined(level.vehicle_DriveIdle_r[model])) {
    level.vehicle_DriveIdle_r[model] = level.vehicle_DriveIdle[model];
  }
  self endon("death");
  normalspeed = level.vehicle_DriveIdle_normal_speed[model];
  thread animate_drive_idle_death();
  animrate = 1.0;
  if((isDefined(level.vehicle_DriveIdle_animrate)) && (isDefined(level.vehicle_DriveIdle_animrate[model]))) {
    animrate = level.vehicle_DriveIdle_animrate[model];
  }
  lastdir = self.wheeldir;
  animatemodel = self;
  animation = level.vehicle_DriveIdle[model];
  while(1) {
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
      if(newanimtime >= 1 || newanimtime == 0) {
        newanimtime = 0.01;
      }
      lastdir = self.wheeldir;
    }
    if(speed == 0) {
      animatemodel setanim(animation, 1, .2, 0);
    } else {
      animatemodel setanim(animation, 1, .2, speed / normalspeed);
    }
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
  if(isDefined(self)) {
    self clearanim(level.vehicle_DriveIdle[model], 0);
  }
}

setup_dynamic_detour(pathnode, get_func) {
  prevnode = [[get_func]](pathnode.targetname);
  assertex(isDefined(prevnode), "detour can't be on start node");
  prevnode.detoured = 0;
}

setup_ai() {
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_vehicleride)) {
      level.vehicle_RideAI = array_2dadd(level.vehicle_RideAI, ai[i].script_vehicleride, ai[i]);
    } else if(isDefined(ai[i].script_vehiclewalk)) {
      level.vehicle_WalkAI = array_2dadd(level.vehicle_WalkAI, ai[i].script_vehiclewalk, ai[i]);
    }
  }
  ai = getspawnerarray();
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_vehicleride)) {
      level.vehicle_RideSpawners = array_2dadd(level.vehicle_RideSpawners, ai[i].script_vehicleride, ai[i]);
    }
    if(isDefined(ai[i].script_vehiclewalk)) {
      level.vehicle_walkspawners = array_2dadd(level.vehicle_walkspawners, ai[i].script_vehiclewalk, ai[i]);
    }
  }
}

array_2dadd(array, firstelem, newelem) {
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
  processtrigger = false;
  if(self has_spawnflag(level.SPAWNFLAG_VEHICLE_NODE_START_NODE)) {
    if(isDefined(self.script_crashtype)) {
      level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;
    }
    level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
  }
  if(isDefined(self.script_vehicledetour) && isDefined(self.targetname)) {
    get_func = undefined;
    if(isDefined(get_from_entity(self.targetname))) {
      get_func = ::get_from_entity_target;
    }
    if(isDefined(get_from_spawnstruct(self.targetname))) {
      get_func = ::get_from_spawnstruct_target;
    }
    if(isDefined(get_func)) {
      setup_dynamic_detour(self, get_func);
      processtrigger = true;
    } else {
      setup_groundnode_detour(self);
    }
    level.vehicle_detourpaths = array_2dadd(level.vehicle_detourpaths, self.script_vehicledetour, self);
    if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2) {
      println("more than two script_vehicledetour grouped in group number: ", self.script_vehicledetour);
    }
  }
  if(isDefined(self.script_gatetrigger)) {
    level.vehicle_gatetrigger = array_2dadd(level.vehicle_gatetrigger, self.script_gatetrigger, self);
    self.gateopen = false;
  }
  if(isDefined(self.script_flag_set)) {
    if(!isDefined(level.flag[self.script_flag_set])) {
      flag_init(self.script_flag_set);
    }
  }
  if(isDefined(self.script_flag_clear)) {
    if(!isDefined(level.flag[self.script_flag_clear])) {
      flag_init(self.script_flag_clear);
    }
  }
  if(isDefined(self.script_flag_wait)) {
    if(!isDefined(level.flag[self.script_flag_wait])) {
      flag_init(self.script_flag_wait);
    }
  }
  if(isDefined(self.script_VehicleSpawngroup) ||
    isDefined(self.script_VehicleStartMove) ||
    isDefined(self.script_gatetrigger) ||
    isDefined(self.script_Vehiclegroupdelete)) {
    processtrigger = true;
  }
  if(processtrigger) {
    add_proccess_trigger(self);
  }
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
  if(!isDefined(node.targetname)) {
    return false;
  }
  return isDefined(getstruct(node.targetname, "targetname"));
}

setup_vehicles(allvehiclesprespawn) {
  vehicles = allvehiclesprespawn;
  spawnvehicles = [];
  groups = [];
  nonspawned = [];
  for(i = 0; i < vehicles.size; i++) {
    vehicles[i] vehicle_load_assets();
    if(vehicles[i] has_spawnflag(level.SPAWNFLAG_VEHICLE_SPAWNER)) {
      AssertEX(isDefined(vehicles[i].script_vehiclespawngroup), "Vehicle of type: " + vehicles[i].vehicletype + " has SPAWNER flag set, but is not part of a script_vehiclespawngroup or doesn't have a targetname.");
    }
    if(isDefined(vehicles[i].script_vehiclespawngroup)) {
      if(!isDefined(spawnvehicles[vehicles[i].script_vehiclespawngroup])) {
        spawnvehicles[vehicles[i].script_vehiclespawngroup] = [];
      }
      spawnvehicles[vehicles[i].script_vehiclespawngroup]
        [spawnvehicles[vehicles[i].script_vehiclespawngroup].size] = vehicles[i];
      addgroup[0] = vehicles[i].script_vehiclespawngroup;
      groups = array_merge(groups, addgroup);
      continue;
    } else {
      nonspawned[nonspawned.size] = vehicles[i];
    }
  }
  for(i = 0; i < groups.size; i++) {
    thread spawner_setup(spawnvehicles[groups[i]], groups[i], "main");
  }
  for(i = 0; i < nonspawned.size; i++) {
    thread vehicle_init(nonspawned[i]);
  }
}

vehicle_life() {
  if(isDefined(self.destructibledef)) {
    self.health = 99999;
  } else {
    type = self.vehicletype;
    if(!isDefined(self.healthdefault)) {
      wait 2;
    }
    assertEX(isDefined(self.healthdefault), "need to specify health settings in vehicle gdt for vehicletype: " + type);
    if(isDefined(self.script_startinghealth)) {
      self.health = self.script_startinghealth;
    } else {
      if(self.healthdefault == -1) {
        return;
      } else if(isDefined(self.healthmin) && isDefined(self.healthmax) && (self.healthmax - self.healthmin) > 0) {
        self.health = (randomInt(self.healthmax - self.healthmin) + self.healthmin);
        println("set range health: " + self.health);
      } else {
        self.health = self.healthdefault;
        println("set health: " + self.health);
      }
    }
  }
}

vehicle_load_assets() {
  precachevehicle(self.vehicletype);
  precachemodel(self.model);
  precache_extra_models();
  if(isDefined(self.deathmodel) && self.deathmodel != "") {
    precache_death_model_wrapper(self.deathmodel);
  }
  if(isDefined(self.shootshock) && self.shootshock != "") {
    precacheShader("black");
    precacheShellShock(self.shootshock);
  }
  if(isDefined(self.shootrumble) && self.shootrumble != "") {
    PrecacheRumble(self.shootrumble);
  }
  if(isDefined(self.rumbletype) && self.rumbletype != "") {
    precacherumble(self.rumbletype);
  }
  if(isDefined(self.secturrettype) && self.secturrettype != "") {
    precacheturret(self.secturrettype);
  }
  if(isDefined(self.secturretmodel) && self.secturretmodel != "") {
    precachemodel(self.secturretmodel);
  }
  self vehicle_load_fx();
}

precache_death_model_wrapper(death_model_name) {
  if(!isDefined(self.script_string) || (isDefined(self.script_string) && self.script_string != "no_deathmodel")) {
    PrecacheModel(death_model_name);
  }
}

precache_extra_models() {
  switch (self.vehicletype) {
    case "heli_huey":
    case "heli_huey_player":
    case "heli_huey_small":
    case "heli_huey_heavyhog":
    case "heli_huey_heavyhog_creek":
    case "heli_huey_usmc_heavyhog_khesanh":
    case "heli_huey_medivac":
    case "heli_huey_medivac_khesanh":
    case "heli_huey_gunship":
    case "heli_huey_assault":
    case "heli_huey_usmc":
    case "heli_huey_usmc_khesanh":
    case "heli_huey_usmc_khesanh_std":
    case "heli_huey_side_minigun":
    case "heli_huey_side_minigun_uwb":
      self maps\_huey::precache_submodels();
      break;
    case "heli_hind_player":
      self maps\_hind_player::precache_models();
      self maps\_hind_player::precache_weapons();
      self maps\_hind_player::precache_hud();
      break;
    case "truck_gaz63_camorack":
      PrecacheModel("t5_veh_truck_gaz63_camo_rack");
      break;
    case "truck_gaz63_canvas":
    case "truck_gaz66_canvas":
      PrecacheModel("t5_veh_gaz66_flatbed");
      PrecacheModel("t5_veh_gaz66_flatbed_dead");
      PrecacheModel("t5_veh_gaz66_canvas");
      PrecacheModel("t5_veh_gaz66_canvas_dead");
      break;
    case "truck_gaz63_canvas_camorack":
      PrecacheModel("t5_veh_gaz66_troops");
      PrecacheModel("t5_veh_gaz66_troops_dead");
      PrecacheModel("t5_veh_gaz66_canvas");
      PrecacheModel("t5_veh_gaz66_canvas_dead");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_back_canvas");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_dead");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_back");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_back_dead");
      break;
    case "truck_gaz63_flatbed":
    case "truck_gaz66_flatbed":
      PrecacheModel("t5_veh_gaz66_flatbed");
      PrecacheModel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_flatbed_camorack":
      PrecacheModel("t5_veh_gaz66_flatbed");
      PrecacheModel("t5_veh_gaz66_flatbed_dead");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_dead");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_back");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_back_dead");
      break;
    case "truck_gaz63_tanker":
    case "truck_gaz66_tanker":
    case "truck_gaz66_tanker_physics":
      PrecacheModel("t5_veh_gaz66_tanker");
      precache_death_model_wrapper("t5_veh_gaz66_tanker_dead");
      break;
    case "truck_gaz63_troops":
    case "truck_gaz66_troops":
    case "truck_gaz66_troops_physics":
    case "truck_gaz63_troops_bulletdamage":
      PrecacheModel("t5_veh_gaz66_troops");
      PrecacheModel("t5_veh_gaz66_troops_dead");
      break;
    case "truck_gaz63_troops_camorack":
      PrecacheModel("t5_veh_gaz66_troops");
      PrecacheModel("t5_veh_gaz66_troops_dead");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_dead");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_back");
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_back_dead");
      break;
    case "truck_gaz66_troops_attacking_physics":
      PrecacheModel("t5_veh_gaz66_troops_no_benches");
      PrecacheModel("t5_veh_gaz66_troops_dead");
      break;
    case "truck_gaz63_single50":
    case "truck_gaz66_single50":
      PrecacheModel("t5_veh_gaz66_single50");
      PrecacheModel("t5_veh_gaz66_single50_dead");
      PrecacheModel("t5_veh_gaz66_flatbed");
      PrecacheModel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_player_single50":
    case "truck_gaz63_player_single50_physics":
    case "truck_gaz66_player_single50":
    case "truck_gaz63_player_single50_bulletdamage":
      PrecacheModel("t5_veh_gunner_turret_enemy_50cal");
      PrecacheModel("t5_veh_gaz66_flatbed");
      PrecacheModel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_player_single50_nodeath":
      PrecacheModel("t5_veh_gunner_turret_enemy_50cal");
      PrecacheModel("t5_veh_gaz66_flatbed");
      break;
    case "truck_gaz63_quad50":
    case "truck_gaz66_quad50":
      PrecacheModel("t5_veh_gaz66_quad50");
      PrecacheModel("t5_veh_gaz66_quad50_dead");
      PrecacheModel("t5_veh_gaz66_flatbed");
      PrecacheModel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_camorack_low":
      PrecacheModel("t5_veh_truck_gaz63_camo_rack_low");
      break;
    case "truck_gaz63_canvas_low":
      PrecacheModel("t5_veh_gaz66_flatbed_low");
      PrecacheModel("t5_veh_gaz66_flatbed_dead_low");
      PrecacheModel("t5_veh_gaz66_canvas_low");
      PrecacheModel("t5_veh_gaz66_canvas_dead_low");
      break;
    case "truck_gaz63_flatbed_low":
      PrecacheModel("t5_veh_gaz66_flatbed_low");
      PrecacheModel("t5_veh_gaz66_flatbed_dead_low");
      break;
    case "truck_gaz63_tanker_low":
      PrecacheModel("t5_veh_gaz66_tanker_low");
      PrecacheModel("t5_veh_gaz66_tanker_dead_low");
      break;
    case "truck_gaz63_troops_low":
      PrecacheModel("t5_veh_gaz66_troops_low");
      PrecacheModel("t5_veh_gaz66_troops_dead_low");
      break;
    case "truck_gaz63_single50_low":
      PrecacheModel("t5_veh_gaz66_single50_low");
      PrecacheModel("t5_veh_gaz66_single50_dead_low");
      PrecacheModel("t5_veh_gaz66_flatbed_low");
      PrecacheModel("t5_veh_gaz66_flatbed_dead_low");
      break;
    case "truck_gaz63_quad50_low":
      PrecacheModel("t5_veh_gaz66_quad50_low");
      PrecacheModel("t5_veh_gaz66_quad50_dead_low");
      PrecacheModel("t5_veh_gaz66_flatbed_low");
      PrecacheModel("t5_veh_gaz66_flatbed_dead_low");
      break;
    case "truck_gaz63_quad50_low_no_deathmodel":
      PrecacheModel("t5_veh_gaz66_quad50_low");
      break;
    case "tank_snowcat_plow":
      precacheModel("t5_veh_snowcat_plow");
      break;
    case "boat_pbr":
      PreCacheModel("t5_veh_boat_pbr_set01_friendly");
      PreCacheModel("t5_veh_boat_pbr_waterbox");
      break;
    case "boat_pbr_player":
      PrecacheModel("t5_veh_boat_pbr_set01");
      PrecacheModel("t5_veh_boat_pbr_stuff");
      break;
    case "police":
      PrecacheModel("t5_veh_police_lightbar");
      break;
  }
}

vehicle_load_fx() {
  if(isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
    self.exhaust_fx = loadfx(self.exhaustfxname);
  }
  maps\_treadfx::loadtreadfx(self);
  if(isDefined(self.deathfxname) && self.deathfxname != "") {
    self.deathfx = loadfx(self.deathfxname);
  }
  if(isDefined(self.rotorMainRunningFxName) && self.rotorMainRunningFxName != "") {
    self.rotorMainRunningFx = loadfx(self.rotorMainRunningFxName);
  }
  if(isDefined(self.rotorTailRunningFxName) && self.rotorTailRunningFxName != "") {
    self.rotorTailRunningFx = loadfx(self.rotorTailRunningFxName);
  }
  if(isDefined(self.rotorMainIdleFxName) && self.rotorMainIdleFxName != "") {
    self.rotorMainIdleFx = loadfx(self.rotorMainIdleFxName);
  }
  if(isDefined(self.rotorTailIdleFxName) && self.rotorTailIdleFxName != "") {
    self.rotorTailIdleFx = loadfx(self.rotorTailIdleFxName);
  }
  if(isDefined(self.rotorMainStartFxName) && self.rotorMainStartFxName != "") {
    self.rotorMainStartFx = loadfx(self.rotorMainStartFxName);
  }
  if(isDefined(self.rotorTailStartFxName) && self.rotorTailStartFxName != "") {
    self.rotorTailStartFx = loadfx(self.rotorTailStartFxName);
  }
  if(isDefined(self.rotorMainStopFxName) && self.rotorMainStopFxName != "") {
    self.rotorMainStopFx = loadfx(self.rotorMainStopFxName);
  }
  if(isDefined(self.rotorTailStopFxName) && self.rotorTailStopFxName != "") {
    self.rotorTailStopFx = loadfx(self.rotorTailStopFxName);
  }
  if(is_true(level._vehicle_load_lights)) {
    if(self.vehicletype == "police") {
      self.headlightFX = LoadFX("vehicle/light/fx_cuba_police_headlight");
      self.taillightLeftFX = LoadFX("vehicle/light/fx_cuba_police_taillight_left");
      self.taillightRightFX = LoadFX("vehicle/light/fx_cuba_police_taillight_right");
      self.frontDLightFX = LoadFX("maps/cuba/fx_cuba_veh_front_end_lights");
      self.interiorLightFX = LoadFX("maps/cuba/fx_cuba_veh_interior_lights");
    } else if(self.vehicletype == "cuba_player") {
      self.taillightFX = LoadFX("vehicle/light/fx_cuba_car_brakelight");
    } else {
      self.headlightFX = LoadFX("vehicle/light/fx_jeep_uaz_headlight");
      self.taillightFX = LoadFX("vehicle/light/fx_jeep_uaz_taillight");
    }
  }
  if(is_true(level._vehicle_load_sirens)) {
    self.sirenlightFX = LoadFX("maps/cuba/fx_cuba_siren_light");
  }
}

mginit() {
  type = self.vehicletype;
  if(((isDefined(self.script_nomg)) && (self.script_nomg > 0))) {
    return;
  }
  if(!isDefined(self.secturrettype) || self.secturrettype == "") {
    return;
  }
  mgangle = 0;
  if(isDefined(self.script_mg_angle)) {
    mgangle = self.script_mg_angle;
  }
  self.mgturret[0] = spawnTurret("misc_turret", (0, 0, 0), self.secturrettype);
  self.mgturret[0] linkto(self, self.secturrettag, (0, 0, 0), (0, -1 * mgangle, 0));
  self.mgturret[0] setModel(self.secturretmodel);
  self.mgturret[0].angles = self.angles;
  self.mgturret[0].isvehicleattached = true;
  self.mgturret[0] thread maps\_mgturret::burst_fire_unmanned();
  self.mgturret[0] maketurretunusable();
  level thread maps\_mgturret::mg42_setdifficulty(self.mgturret[0], getdifficulty());
  if(isDefined(self.script_fireondrones)) {
    self.mgturret[0].script_fireondrones = self.script_fireondrones;
  }
  self.mgturret[0] setshadowhint("never");
  if(isDefined(self.secturretdeletedelay)) {
    self.mgturret[0].deletedelay = self.secturretdeletedelay;
  }
  if(isDefined(self.secturretdefaultoffmode)) {
    self.mgturret[0] setmode(self.secturretdefaultoffmode);
  }
  if(isDefined(self.secturretmaxrange)) {
    self.mgturret[0].maxrange = self.secturretmaxrange;
  }
  if(!isDefined(self.script_turretmg)) {
    self.script_turretmg = true;;
  }
  if(isDefined(self.script_turretmg) && self.script_turretmg == 0) {
    self thread mgoff();
  } else {
    self.script_turretmg = 1;
    self thread mgon();
  }
  self thread mgtoggle();
}

mgtoggle() {
  self endon("death");
  if(self.script_turretmg) {
    lasttoggle = 1;
  } else {
    lasttoggle = 0;
  }
  while(1) {
    if(lasttoggle != self.script_turretmg) {
      lasttoggle = self.script_turretmg;
      if(self.script_turretmg) {
        self thread mgon();
      } else {
        self thread mgoff();
      }
    }
    wait .5;
  }
}

mgoff() {
  type = self.vehicletype;
  self.script_turretmg = 0;
  if((self is_plane()) && (self hasHelicopterTurret())) {
    self thread chopper_Turret_Off();
    return;
  }
  if(!isDefined(self) || !isDefined(self.mgturret)) {
    return;
  }
  for(i = 0; i < self.mgturret.size; i++) {
    if(isDefined(self.mgturret[i].script_fireondrones)) {
      self.mgturret[i].script_fireondrones = false;
    }
    if(isDefined(self.secturretdefaultoffmode)) {
      self.mgturret[i] setmode(self.secturretdefaultoffmode);
    } else {
      self.mgturret[i] setmode("manual");
    }
  }
}

mgon() {
  type = self.vehicletype;
  self.script_turretmg = 1;
  if(!isDefined(self) || !isDefined(self.mgturret)) {
    return;
  }
  for(i = 0; i < self.mgturret.size; i++) {
    if(isDefined(self.mgturret[i].bAiControlled) && !self.mgturret[i].bAiControlled) {
      continue;
    }
    if(isDefined(self.mgturret[i].script_fireondrones)) {
      self.mgturret[i].script_fireondrones = true;
    }
    if(isDefined(self.secturretdefaultonmode)) {
      self.mgturret[i] setmode(self.secturretdefaultonmode);
    } else {
      self.mgturret[i] setmode("auto_nonai");
    }
    if((self.vteam == "allies") || (self.vteam == "friendly")) {
      self.mgturret[i] setTurretTeam("allies");
    } else if((self.vteam == "axis") || (self.vteam == "enemy")) {
      self.mgturret[i] setTurretTeam("axis");
    }
  }
}

isCheap() {
  if(!isDefined(self.script_cheap)) {
    return false;
  }
  if(!self.script_cheap) {
    return false;
  }
  return true;
}

hasHelicopterDustKickup() {
  if(!is_plane()) {
    return false;
  }
  if(isCheap()) {
    return false;
  }
  return true;
}

hasHelicopterTurret() {
  if(!isDefined(self.vehicletype)) {
    return false;
  }
  if(isCheap()) {
    return false;
  }
  if(self.vehicletype == "cobra") {
    return true;
  }
  if(self.vehicletype == "cobra_player") {
    return true;
  }
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
  while(1) {
    playfx(effect, effectorigin.origin, effectorigin.upvec);
    wait durration;
  }
}

playLoopedFxontag_originupdate(tag, effectorigin) {
  effectorigin.angles = self gettagangles(tag);
  effectorigin.origin = self gettagorigin(tag);
  effectorigin.forwardvec = anglestoforward(effectorigin.angles);
  effectorigin.upvec = anglestoup(effectorigin.angles);
  while(isDefined(self) && self.classname == "script_vehicle" && self getspeedmph() > 0) {
    eModel = get_dummy();
    effectorigin.angles = eModel gettagangles(tag);
    effectorigin.origin = eModel gettagorigin(tag);
    effectorigin.forwardvec = anglestoforward(effectorigin.angles);
    effectorigin.upvec = anglestoup(effectorigin.angles);
    wait .05;
  }
}

setup_dvars() {}
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
  level.vehicle_walkercount = [];
  level.helicopter_crash_locations = getentarray("helicopter_crash_location", "targetname");
  level.vclogin_vehicles = 0;
  level.playervehicle = spawn("script_origin", (0, 0, 0));
  level.playervehiclenone = level.playervehicle;
  level.vehicles = [];
  level.vehicles["allies"] = [];
  level.vehicles["axis"] = [];
  level.vehicles["neutral"] = [];
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
  if(!isDefined(level.vehicle_isStationary)) {
    level.vehicle_isStationary = [];
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
  if(!isDefined(level.vehicle_death_jolt)) {
    level.vehicle_death_jolt = [];
  }
  if(!isDefined(level.vehicle_death_badplace)) {
    level.vehicle_death_badplace = [];
  }
  maps\_vehicle_aianim::setup_aianimthreads();
}

attacker_isonmyteam(attacker) {
  if((isDefined(attacker)) && isDefined(attacker.vteam) && (isDefined(self.vteam)) && (attacker.vteam == self.vteam)) {
    return true;
  } else {
    return false;
  }
}

is_godmode() {
  return (!self.takedamage);
}

attacker_troop_isonmyteam(attacker) {
  if(isDefined(self.vteam) && self.vteam == "allies" && isDefined(attacker) && isDefined(level.player) && attacker == level.player) {
    return true;
  } else if(isai(attacker) && attacker.team == self.vteam) {
    return true;
  } else {
    return false;
  }
}

bulletshielded(type) {
  if(!isDefined(self.script_bulletshield)) {
    return false;
  }
  type = tolower(type);
  if(!isDefined(type) || !issubstr(type, "bullet")) {
    return false;
  }
  if(self.script_bulletshield) {
    return true;
  } else {
    return false;
  }
}

friendlyfire_shield() {
  self.friendlyfire_shield = true;
  if(isDefined(level.vehicle_bulletshield[self.vehicletype]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
  }
}

friendlyfire_shield_callback(attacker, amount, type) {
  if(!isDefined(self.friendlyfire_shield) || !self.friendlyfire_shield) {
    return false;
  }
  if(
    (!isDefined(attacker) && self.vteam != "neutral") ||
    attacker_isonmyteam(attacker) ||
    attacker_troop_isonmyteam(attacker) ||
    isDestructible() ||
    bulletshielded(type)
  ) {
    return true;
  }
  return false;
}

vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

vehicle_badplace() {
  if(!isDefined(self.script_badplace)) {
    return;
  }
  self endon("kill_badplace_forever");
  self endon("death");
  self endon("delete");
  if(isDefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }
  hasturret = isDefined(self.turretweapon) && self.turretweapon != "";
  bp_duration = .5;
  bp_height = 300;
  bp_angle_left = 17;
  bp_angle_right = 17;
  for(;;) {
    if(!self.script_badplace) {
      while(!self.script_badplace) {
        wait .5;
      }
    }
    speed = self getspeedmph();
    if(speed <= 0) {
      wait bp_duration;
      continue;
    }
    if(speed < 5) {
      bp_radius = 200;
    } else if((speed > 5) && (speed < 8)) {
      bp_radius = 350;
    } else {
      bp_radius = 500;
    }
    if(isDefined(self.BadPlaceModifier)) {
      bp_radius = (bp_radius * self.BadPlaceModifier);
    }
    if(hasturret) {
      bp_direction = anglestoforward(self gettagangles("tag_turret"));
    } else {
      bp_direction = anglestoforward(self.angles);
    }
    badplace_arc("", bp_duration, self.origin, bp_radius * 1.9, bp_height, bp_direction, bp_angle_left, bp_angle_right, "allies", "axis");
    badplace_cylinder("", bp_duration, self.origin, 200, bp_height, "allies", "axis");
    wait bp_duration + .05;
  }
}

turret_attack_think() {
  if(self is_plane()) {
    return;
  }
  thread turret_shoot();
}

isStationary() {
  type = self.vehicletype;
  if(isDefined(level.vehicle_isStationary[type]) && level.vehicle_isStationary[type]) {
    return true;
  } else {
    return false;
  }
}

turret_shoot() {
  type = self.vehicletype;
  self endon("death");
  self endon("stop_turret_shoot");
  index = 0;
  turrets = self.turrettagarray;
  while(self.health > 0) {
    self waittill("turret_fire");
    self notify("groupedanimevent", "turret_fire");
    if(!turrets.size) {
      self fireWeapon();
    } else if(isDefined(turrets[index]) && turrets[index] != "") {
      self fireweapon(turrets[index]);
      index++;
      if(index >= turrets.size) {
        index = 0;
      }
    }
  }
}

vehicle_weapon_fired() {
  if(!(self is_tank())) {
    return;
  }
  self endon("death");
  while(true) {
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
  if(!isDefined(self.addtocompass) || !self.addtocompass) {
    return;
  }
  self endon("death");
  level.compassradius = int(getDvar(#"compassMaxRange"));
  self.onplayerscompass = false;
  while(1) {
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
  if(isDefined(self.vteam) && self.vteam == "allies") {
    no_name = self is_plane() || (isDefined(self.script_friendname) && (self.script_friendname == "" || self.script_friendname == "none" || self.script_friendname == "0"));
    correct_type = (type == "sherman" || type == "sherman_flame" || type == "t34" || type == "ot34" || type == "see2_t34" || type == "see2_ot34");
    if(!no_name && correct_type) {
      self maps\_vehiclenames::get_name();
    }
  }
  level.vehicles[self.vteam] = array_add(level.vehicles[self.vteam], self);
}

vehicle_handleunloadevent() {
  self endon("death");
  type = self.vehicletype;
  while(1) {
    self waittill("unload", who);
    self notify("groupedanimevent", "unload");
  }
}

get_vehiclenode_any_dynamic(target) {
  path_start = getvehiclenode(target, "targetname");
  if(!isDefined(path_start)) {
    path_start = getEnt(target, "targetname");
  } else if(is_plane()) {
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
  if(!self is_plane()) {
    self resumespeed(35);
    return;
  }
  node = undefined;
  if(isDefined(self.currentnode.target)) {
    node = get_vehiclenode_any_dynamic(self.currentnode.target);
  }
  if(!isDefined(node)) {
    return;
  }
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
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.originheightoffset)) {
    origin += (0, 0, self.originheightoffset);
  }
  self setvehgoalpos(origin, bStop);
}

vehicle_liftoffvehicle(height) {
  if(!isDefined(height)) {
    height = 512;
  }
  dest = self.origin + (0, 0, height);
  self setNearGoalNotifyDist(10);
  self setvehgoalpos_wrap(dest, 1);
  self waittill("goal");
}

waittill_stable() {
  offset = 12;
  stabletime = 400;
  timer = gettime() + stabletime;
  while(isDefined(self)) {
    if(self.angles[0] > offset || self.angles[0] < (-1 * offset)) {
      timer = gettime() + stabletime;
    }
    if(self.angles[2] > offset || self.angles[2] < (-1 * offset)) {
      timer = gettime() + stabletime;
    }
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
  if(isDefined(pathnode) && self.riders.size) {
    for(i = 0; i < self.riders.size; i++) {
      if(isai(self.riders[i])) {
        self.riders[i] thread maps\_spawner::go_to_node(pathnode);
      }
    }
  }
  if(self is_plane()) {
    waittill_stable();
  } else {
    self setspeed(0, 35);
  }
  if(isDefined(node.script_noteworthy)) {
    if(node.script_noteworthy == "wait_for_flag") {
      flag_wait(node.script_flag);
    }
  }
  self notify("unload", node.script_unload);
  if(maps\_vehicle_aianim::riders_unloadable(node.script_unload)) {
    self waittill("unloaded");
  }
  if(isDefined(node.script_flag_wait)) {
    return;
  }
  if(isDefined(self)) {
    thread vehicle_resumepathvehicle();
  }
}

move_turrets_here(model) {
  type = self.vehicletype;
  if(!isDefined(self.mgturret)) {
    return;
  }
  if(self.mgturret.size == 0) {
    return;
  }
  for(i = 0; i < self.mgturret.size; i++) {
    self.mgturret[i] unlink();
    self.mgturret[i] linkto(model, self.secturrettag, (0, 0, 0), (0, 0, 0));
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
  self.modeldummy setModel(self.model);
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
  while(isDefined(self)) {
    self waittill("death");
    waittillframeend;
  }
  modeldummy delete();
}

move_lights_here(model) {
  if(!isDefined(self.lights)) {
    return;
  }
  keys = getarraykeys(self.lights);
  for(i = 0; i < keys.size; i++) {
    self.lights[keys[i]] unlink();
    self.lights[keys[i]] linkto(model, self.lights[keys[i]].lighttag, (0, 0, 0), (0, 0, 0));
  }
}

move_ghettotags_here(model) {
  if(!isDefined(self.ghettotags)) {
    return;
  }
  for(i = 0; i < self.ghettotags.size; i++) {
    self.ghettotags[i] unlink();
    self.ghettotags[i] linkto(model);
  }
}

dummy_to_vehicle() {
  assertEx(isDefined(self.modeldummy), "Tried to turn a vehicle from a dummy into a vehicle. Can only be called on vehicles that have been turned into dummies with vehicle_to_dummy.");
  if(self is_plane()) {
    self.modeldummy.origin = self gettagorigin("tag_ground");
  } else {
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
  if(!isDefined(self.riders)) {
    return;
  }
  riders = self.riders;
  for(i = 0; i < riders.size; i++) {
    if(!isDefined(riders[i])) {
      continue;
    }
    guy = riders[i];
    guy unlink();
    animpos = maps\_vehicle_aianim::anim_pos(self, guy.pos);
    guy linkto(base, animpos.sittag, (0, 0, 0), (0, 0, 0));
    if(isai(guy)) {
      guy teleport(base gettagorigin(animpos.sittag));
    } else {
      guy.origin = base gettagorigin(animpos.sittag);
    }
  }
}

setup_targetname_spawners() {
  level.vehicle_targetname_array = [];
  vehicles = array_combine(getentarray("script_vehicle", "classname"), get_script_modelvehicles());
  highestGroup = 0;
  for(i = 0; i < vehicles.size; i++) {
    vehicle = vehicles[i];
    if(isDefined(vehicle.script_vehicleSpawnGroup)) {
      if(vehicle.script_vehicleSpawnGroup > highestGroup) {
        highestGroup = vehicle.script_vehicleSpawnGroup;
      }
    }
  }
  for(i = 0; i < vehicles.size; i++) {
    vehicle = vehicles[i];
    if(isDefined(vehicle.targetname) && vehicle has_spawnflag(level.SPAWNFLAG_VEHICLE_SPAWNER)) {
      if(!isDefined(vehicle.script_vehicleSpawnGroup)) {
        highestGroup++;
        vehicle.script_vehicleSpawnGroup = highestGroup;
      }
      if(!isDefined(level.vehicle_targetname_array[vehicle.targetname])) {
        level.vehicle_targetname_array[vehicle.targetname] = [];
      }
      level.vehicle_targetname_array[vehicle.targetname][vehicle.script_vehicleSpawnGroup] = true;
    }
  }
}

spawn_vehicles_from_targetname(name) {
  assertEx(isDefined(level.vehicle_targetname_array[name]), "No vehicle spawners had targetname " + name);
  array = level.vehicle_targetname_array[name];
  keys = getArrayKeys(array);
  vehicles = [];
  for(i = 0; i < keys.size; i++) {
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
  vehicleArray[0] thread gopath();
  return vehicleArray[0];
}

spawn_vehicles_from_targetname_and_drive(name) {
  vehicleArray = spawn_vehicles_from_targetname(name);
  for(i = 0; i < vehicleArray.size; i++) {
    vehicleArray[i] thread goPath();
  }
  return vehicleArray;
}

aircraft_dust_kickup(model) {
  self endon("death");
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
  if(isDefined(model)) {
    trace_ent = model;
  }
  while(isDefined(self)) {
    if(repeatRate <= 0) {
      repeatRate = defaultRepeatRate;
    }
    wait repeatRate;
    if(!isDefined(self)) {
      return;
    }
    doTraceThisFrame--;
    if(doTraceThisFrame <= 0) {
      doTraceThisFrame = numFramesPerTrace;
      trace = bullettrace(trace_ent.origin, trace_ent.origin - (0, 0, 100000), false, trace_ent);
      d = distance(trace_ent.origin, trace["position"]);
      repeatRate = ((d - minHeight) / (maxHeight - minHeight)) * (slowestRepeatWait - fastestRepeatWait) + fastestRepeatWait;
    }
    if(!isDefined(trace)) {
      continue;
    }
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
    if(!isDefined(trace["surfacetype"])) {
      trace["surfacetype"] = "dirt";
    }
    assertEx(isDefined(level._vehicle_effect[self.vehicletype]), self.vehicletype + " vehicle script hasn't run _tradfx properly");
    assertEx(isDefined(level._vehicle_effect[self.vehicletype][trace["surfacetype"]]), "UNKNOWN SURFACE TYPE: " + trace["surfacetype"]);
    if(level._vehicle_effect[self.vehicletype][trace["surfacetype"]] != -1) {
      playfx(level._vehicle_effect[self.vehicletype][trace["surfacetype"]], trace["position"]);
    }
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
  dummy.origin += vector_scale(tank_Forward, offset_Forward);
  dummy.origin += vector_scale(tank_Up, offset_Up);
  dummy.origin += vector_scale(tank_Right, offset_Right);
  offset_Vec = anglesToForward(node_angles);
  offset_Forward = vectorDot(offset_Vec, animStartingVec_Forward);
  offset_Up = vectorDot(offset_Vec, animStartingVec_Up);
  offset_Right = vectorDot(offset_Vec, animStartingVec_Right);
  dummyVec = vector_scale(tank_Forward, offset_Forward);
  dummyVec += vector_scale(tank_Up, offset_Up);
  dummyVec += vector_scale(tank_Right, offset_Right);
  dummy.angles = vectorToAngles(dummyVec);
  if(isDefined(soundAlias)) {
    level thread play_sound_in_space(soundAlias, node_origin);
  }
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
  dummy.final_origin += vector_scale(tank_Forward, offset_Forward);
  dummy.final_origin += vector_scale(tank_Up, offset_Up);
  dummy.final_origin += vector_scale(tank_Right, offset_Right);
  offset_Vec = anglesToForward(node_angles);
  offset_Forward = vectorDot(offset_Vec, animEndingVec_Forward);
  offset_Up = vectorDot(offset_Vec, animEndingVec_Up);
  offset_Right = vectorDot(offset_Vec, animEndingVec_Right);
  dummyVec = vector_scale(tank_Forward, offset_Forward);
  dummyVec += vector_scale(tank_Up, offset_Up);
  dummyVec += vector_scale(tank_Right, offset_Right);
  dummy.final_angles = vectorToAngles(dummyVec);
  if(getDvar(#"debug_tankcrush") == "1") {
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
  if(isDefined(startDelay)) {
    wait startDelay;
  }
  playfxontag(fxName, self, tagName);
  if(isDefined(soundAlias)) {
    self thread play_sound_on_tag(soundAlias, tagName);
  }
}

loadplayer(player, position, animfudgetime) {
  if(!isDefined(animfudgetime)) {
    animfudgetime = 0;
  }
  assert(isDefined(self.riders));
  assert(self.riders.size);
  guy = undefined;
  for(i = 0; i < self.riders.size; i++) {
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
  guy setModel("fastrope_arms");
  guy useanimtree(animpos.player_animtree);
  thread maps\_vehicle_aianim::guy_idle(guy, position);
  player playerlinktodelta(guy, "tag_player", 1.0, 70, 70, 90, 90);
  guy hide();
  animtime = getanimlength(animpos.getout);
  animtime -= animfudgetime;
  self waittill("unload");
  player disableweapons();
  guy notsolid();
  wait animtime;
  player unlink();
  player enableweapons();
}

show_rigs(position) {
  wait .01;
  self thread maps\_vehicle_aianim::getout_rigspawn(self, position);
  if(!self.riders.size) {
    return;
  }
  for(i = 0; i < self.riders.size; i++) {
    self thread maps\_vehicle_aianim::getout_rigspawn(self, self.riders[i].pos);
  }
}

turret_deleteme(turret) {
  if(isDefined(self)) {
    if(isDefined(turret.deletedelay)) {
      wait turret.deletedelay;
    }
  }
  turret delete();
}

wheeldirectionchange(direction) {
  if(direction <= 0) {
    self.wheeldir = 0;
  } else {
    self.wheeldir = 1;
  }
}

maingun_FX() {
  if(!isDefined(level.vehicle_deckdust[self.model])) {
    return;
  }
  self endon("death");
  while(true) {
    self waittill("weapon_fired");
    playfxontag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
    barrel_origin = self gettagorigin("tag_flash");
    ground = physicstrace(barrel_origin, barrel_origin + (0, 0, -128));
    physicsExplosionSphere(ground, 192, 100, 1);
  }
}

group_light(model, name, group) {
  if(!isDefined(level.vehicle_lights_group)) {
    level.vehicle_lights_group = [];
  }
  if(!isDefined(level.vehicle_lights_group[model])) {
    level.vehicle_lights_group[model] = [];
  }
  if(!isDefined(level.vehicle_lights_group[model][group])) {
    level.vehicle_lights_group[model][group] = [];
  }
  level.vehicle_lights_group[model][group][level.vehicle_lights_group[model][group].size] = name;
}

lights_on() {
  self SetClientFlag(10);
}

lights_off() {
  self ClearClientFlag(10);
}

sirens_on() {
  self SetClientFlag(11);
}

sirens_off() {
  self ClearClientFlag(11);
}

interior_lights_on() {
  self SetClientFlag(12);
}

interior_lights_off() {
  self ClearClientFlag(12);
}

deathfx_ent() {
  if(!isDefined(self.deathfx_ent)) {
    ent = spawn("script_model", (0, 0, 0));
    emodel = get_dummy();
    ent setModel(self.model);
    ent.origin = emodel.origin;
    ent.angles = emodel.angles;
    ent notsolid();
    ent hide();
    ent linkto(emodel);
    self.deathfx_ent = ent;
  } else {
    self.deathfx_ent setModel(self.model);
  }
  return self.deathfx_ent;
}

build_drive(forward, reverse, normalspeed, rate) {
  if(!isDefined(normalspeed)) {
    normalspeed = 10;
  }
  level.vehicle_DriveIdle[self.model] = forward;
  if(isDefined(reverse)) {
    level.vehicle_DriveIdle_r[self.model] = reverse;
  }
  level.vehicle_DriveIdle_normal_speed[self.model] = normalspeed;
  if(isDefined(rate)) {
    level.vehicle_DriveIdle_animrate[self.model] = rate;
  }
}

build_aianims(aithread, vehiclethread) {
  level.vehicle_aianims[self.vehicletype] = [[aithread]]();
  if(isDefined(vehiclethread)) {
    level.vehicle_aianims[self.vehicletype] = [
      [vehiclethread]
    ](level.vehicle_aianims[self.vehicletype]);
  }
}

build_attach_models(modelsthread) {
  level.vehicle_attachedmodels[level.vttype] = [[modelsthread]]();;
}

build_unload_groups(unloadgroupsthread) {
  level.vehicle_unloadgroups[self.vehicletype] = [[unloadgroupsthread]]();
}

build_vehiclewalk(num_walkers) {
  level.vehicle_walkercount[level.vttype] = num_walkers;
}

get_from_spawnstruct(target) {
  return getstruct(target, "targetname");
}

get_from_entity(target) {
  return getEnt(target, "targetname");
}

get_from_spawnstruct_target(target) {
  return getstruct(target, "target");
}

get_from_entity_target(target) {
  return getEnt(target, "target");
}

get_from_vehicle_node(target) {
  return getvehiclenode(target, "targetname");
}

set_lookat_from_dest(dest) {
  viewTarget = getEnt(dest.script_linkto, "script_linkname");
  if(!isDefined(viewTarget)) {
    return;
  }
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
  for(;;) {
    group = getentarray("script_vehicle", "classname");
    valid_targets = [];
    for(i = 0; i < group.size; i++) {
      if(!isDefined(group[i].script_vehiclespawngroup)) {
        continue;
      }
      if(group[i].script_vehiclespawngroup == self.script_vehicleattackgroup) {
        if(group[i].vteam != self.vteam) {
          valid_targets = array_add(valid_targets, group[i]);
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
        self notify("killed all targets");
      }
      if(current_target.health <= 0) {
        valid_targets = array_remove(valid_targets, current_target);
        continue;
      } else {
        self setturrettargetEnt(current_target, (0, 0, 50));
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
  for(i = 0; i < valid_targets.size; i++) {
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

generate_colmaps_vehicles() {
  array_delete(getEntArray("colmap_vehicle", "targetname"));
}

dump_vehicles() {}
copy_destructable_attachments(modeldummy) {
  attachedModelCount = self getattachsize();
  attachedModels = [];
  for(i = 0; i < attachedModelCount; i++) {
    attachedModels[i] = tolower(self getAttachModelName(i));
  }
  for(i = 0; i < attachedModels.size; i++) {
    modeldummy attach(attachedModels[i], tolower(self getattachtagname(i)));
  }
}

get_dummy() {
  if(self.modeldummyon) {
    eModel = self.modeldummy;
  } else {
    eModel = self;
  }
  return eModel;
}

apply_truckjunk(eVehicle, truckjunk) {
  if(!isDefined(self.spawner_id)) {
    return;
  }
  if(!isDefined(level.vehicle_truckjunk[self.spawner_id])) {
    return;
  }
  truckjunk = level.vehicle_truckjunk[self.spawner_id];
  self.truckjunk = [];
  for(i = 0; i < truckjunk.size; i++) {
    model = spawn("script_model", self.origin);
    model setModel(truckjunk[i].model);
    model linkto(self, "tag_body", truckjunk[i].origin, truckjunk[i].angles);
    self.truckjunk[i] = model;
  }
}

truckjunk() {
  assert(isDefined(self.target));
  linked_vehicle = getEnt(self.target, "targetname");
  assert(isDefined(linked_vehicle));
  spawner_id = vehicle_spawnidgenerate(linked_vehicle.origin);
  target = getEnt(self.target, "targetname");
  ghettotag = ghetto_tag_create(target);
  if(isDefined(self.script_noteworthy)) {
    ghettotag.script_noteworthy = self.script_noteworthy;
  }
  if(!isDefined(level.vehicle_truckjunk[spawner_id])) {
    level.vehicle_truckjunk[spawner_id] = [];
  }
  if(isDefined(self.script_startingposition)) {
    ghettotag.script_startingposition = self.script_startingposition;
  }
  level.vehicle_truckjunk[spawner_id][level.vehicle_truckjunk[spawner_id].size] = ghettotag;
  self delete();
}

ghetto_tag_create(target) {
  struct = spawnstruct();
  struct.origin = self.origin - target gettagorigin("tag_body");
  struct.angles = self.angles - target gettagangles("tag_body");
  struct.model = self.model;
  if(isDefined(struct.targetname)) {
    level.struct_class_names["targetname"][struct.targetname] = undefined;
  }
  if(isDefined(struct.target)) {
    level.struct_class_names["target"][struct.target] = undefined;
  }
  return struct;
}

vehicle_dump() {}
dump_handle() {}
twobuttonspressed(button1, button2) {}
vehicle_load_ai(ai) {
  maps\_vehicle_aianim::load_ai(ai);
}

volume_up(timer) {
  self notify("new_volume_command");
  self endon("new_volume_command");
  assertex(isDefined(timer), "No timer defined! ");
  self endon("death");
  timer = timer * 20;
  for(i = 0; i <= timer; i++) {
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
  for(i = 0; i <= timer; i++) {
    self setenginevolume((timer - i) / timer);
    wait(0.05);
  }
}

kill_badplace(type) {
  if(!isDefined(level.vehicle_death_badplace[type])) {
    return;
  }
  struct = level.vehicle_death_badplace[type];
  if(isDefined(struct.delay)) {
    wait struct.delay;
  }
  if(!isDefined(self)) {
    return;
  }
  BadPlace_Cylinder("vehicle_kill_badplace", struct.duration, self.origin, struct.radius, struct.height, struct.team1, struct.team2);
}

kill_jolt(type) {
  if(isDefined(level.vehicle_death_jolt[type])) {
    self.dontfreeme = true;
    wait level.vehicle_death_jolt[type].delay;
  }
  if(!isDefined(self)) {
    return;
  }
  self joltbody((self.origin + (23, 33, 64)), 3);
  wait 2;
  if(!isDefined(self)) {
    return;
  }
  self.dontfreeme = undefined;
}

vehicle_main() {
  switch (self.vehicletype) {
    case "tank_t72":
      self maps\_t72::main();
      break;
    case "tank_zsu23":
    case "tank_zsu23_low":
      self maps\_tank_zsu23::main();
      break;
    case "truck_bm21":
    case "truck_bm21_troops":
    case "truck_maz543":
      self maps\_truck::main();
      break;
    case "boat_pbr":
    case "boat_pbr_player":
      self maps\_boat_pbr::main();
      break;
    case "truck_gaz66":
    case "truck_gaz66_physics":
    case "truck_gaz66_canvas":
    case "truck_gaz66_flatbed":
    case "truck_gaz66_tanker":
    case "truck_gaz66_tanker_physics":
    case "truck_gaz66_troops":
    case "truck_gaz66_troops_physics":
    case "truck_gaz66_troops_attacking_physics":
    case "truck_gaz66_single50":
    case "truck_gaz66_quad50":
    case "truck_gaz66_player_single50":
      self maps\_truck_gaz66::main();
      break;
    case "truck_gaz63":
    case "truck_gaz63_canvas":
    case "truck_gaz63_canvas_camorack":
    case "truck_gaz63_flatbed":
    case "truck_gaz63_flatbed_camorack":
    case "truck_gaz63_tanker":
    case "truck_gaz63_troops":
    case "truck_gaz63_troops_bulletdamage":
    case "truck_gaz63_troops_camorack":
    case "truck_gaz63_single50":
    case "truck_gaz63_player_single50":
    case "truck_gaz63_player_single50_nodeath":
    case "truck_gaz63_player_single50_physics":
    case "truck_gaz63_player_single50_bulletdamage":
    case "truck_gaz63_quad50":
    case "truck_gaz63_camorack":
    case "truck_gaz63_low":
    case "truck_gaz63_canvas_low":
    case "truck_gaz63_flatbed_low":
    case "truck_gaz63_tanker_low":
    case "truck_gaz63_troops_low":
    case "truck_gaz63_single50_low":
    case "truck_gaz63_quad50_low":
    case "truck_gaz63_quad50_low_no_deathmodel":
    case "truck_gaz63_camorack_low":
      self maps\_truck_gaz63::main();
      break;
    case "jeep_uaz":
    case "jeep_uaz_closetop":
    case "jeep_uaz_closetop_physics":
    case "jeep_uaz_physics":
      self maps\_uaz::main();
      break;
    case "jeep_intl":
    case "jeep_player":
    case "jeep_player_slow":
    case "jeep_willys":
    case "jeep_ultimate":
      self maps\_jeep::main();
      break;
    case "heli_chinook":
      self maps\_chinook::main();
      break;
    case "heli_cobra":
    case "heli_cobra_khesanh":
      self maps\_cobra::main();
      break;
    case "heli_hip":
    case "heli_hip_sidegun":
    case "heli_hip_sidegun_uwb":
    case "heli_hip_sidegun_spotlight":
      self maps\_hip::main();
      break;
    case "heli_huey":
    case "heli_huey_vista":
    case "heli_huey_assault":
    case "heli_huey_assault_river":
    case "heli_huey_gunship":
    case "heli_huey_gunship_river":
    case "heli_huey_heavyhog":
    case "heli_huey_heavyhog_creek":
    case "heli_huey_usmc_heavyhog_khesanh":
    case "heli_huey_heavyhog_river":
    case "heli_huey_medivac":
    case "heli_huey_medivac_khesanh":
    case "heli_huey_medivac_river":
    case "heli_huey_minigun":
    case "heli_huey_player":
    case "heli_huey_small":
    case "heli_huey_usmc":
    case "heli_huey_usmc_gunship":
    case "heli_huey_usmc_heavyhog":
    case "heli_huey_usmc_khesanh":
    case "heli_huey_usmc_khesanh_std":
    case "heli_huey_usmc_minigun":
    case "heli_huey_side_minigun":
    case "heli_huey_side_minigun_uwb": {
      self maps\_huey::main();
    }
    break;
    case "heli_hind_player":
      self maps\_hind_player::main();
      break;
    case "plane_mig17":
      self maps\_mig17::main();
      break;
    case "plane_phantom":
      self maps\_mig17::main();
      break;
    case "wpn_zpu_antiair":
      self maps\_zpu_antiair::main();
      break;
    case "apc_brt40":
    case "apc_m113":
    case "apc_m113_khesanh_outcasts":
    case "apc_m113_khesanh_warchicken":
    case "apc_m113_khesanh_plain":
    case "apc_bmp":
      self maps\_apc::main();
      break;
    case "apc_btr40_flashpoint":
    case "apc_btr60":
    case "apc_btr60_grenade":
      self maps\_btr::main();
      break;
    case "civ_tanker":
    case "civ_tanker_civ":
    case "civ_sedan_luxury":
      self maps\_civ_vehicle::main();
      break;
    case "tiara":
      self maps\_tiara::main();
      break;
    case "police":
      self maps\_policecar::main();
      break;
    case "tank_snowcat":
    case "tank_snowcat_plow":
    case "tank_snowcat_troops":
      self maps\_snowcat::main();
      break;
    case "rcbomb":
      self maps\_rcbomb::main();
      break;
    case "boat_sampan_pow":
    case "boat_sampan":
      self maps\_sampan::main();
      break;
    case "boat_nvapbr":
      self maps\_boat_nvapbr::main();
      break;
    case "boat_patrol_nva":
      self maps\_boat_patrol_nva::main();
      break;
    case "motorcycle_ai":
      self maps\_motorcycle::main();
      break;
    default:
      break;
  }
}