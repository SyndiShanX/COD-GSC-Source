/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_vehicle.gsc
********************************************************/

#include maps\_utility;
#include maps\_anim;
#include maps\_vehicle_aianim;
#include common_scripts\utility;
#using_animtree("vehicles");

CONST_MPHCONVERSION = 17.6;
CONST_bp_height = 300;

init_vehicles() {
  if(isDefined(level.disableVehicleScripts) && level.disableVehicleScripts) {
    return;
  }
  level.heli_default_decel = 10;

  init_helicopter_list();
  init_airplane_list();

  setup_dvars();

  setup_levelvars();

  setup_vehicle_spawners();

  array_thread(getEntArray("truckjunk", "targetname"), ::truckjunk);

  setup_ai();

  setup_triggers();

  allvehiclesprespawn = precache_scripts();

  setup_vehicles(allvehiclesprespawn);

  array_levelthread(level.vehicle_processtriggers, ::trigger_process, allvehiclesprespawn);

  array_thread(getStructArray("gag_stage_littlebird_unload", "script_noteworthy"), ::setup_gag_stage_littlebird_unload);
  array_thread(getStructArray("gag_stage_littlebird_load", "script_noteworthy"), ::setup_gag_stage_littlebird_load);

  level.vehicle_processtriggers = undefined;

  init_level_has_vehicles();

  add_hint_string("invulerable_frags", &"SCRIPT_INVULERABLE_FRAGS", undefined);
  add_hint_string("invulerable_bullets", &"SCRIPT_INVULERABLE_BULLETS", undefined);
}

init_helicopter_list() {
  level.helicopter_list = [];
  level.helicopter_list["blackhawk"] = true;
  level.helicopter_list["blackhawk_minigun"] = true;
  level.helicopter_list["blackhawk_minigun_so"] = true;
  level.helicopter_list["apache"] = true;
  level.helicopter_list["seaknight"] = true;
  level.helicopter_list["seaknight_airlift"] = true;
  level.helicopter_list["hind"] = true;
  level.helicopter_list["mi17"] = true;
  level.helicopter_list["mi17_noai"] = true;
  level.helicopter_list["mi17_bulletdamage"] = true;
  level.helicopter_list["cobra"] = true;
  level.helicopter_list["cobra_player"] = true;
  level.helicopter_list["viper"] = true;
  level.helicopter_list["littlebird_player"] = true;
  level.helicopter_list["littlebird"] = true;
  level.helicopter_list["mi28"] = true;
  level.helicopter_list["pavelow"] = true;
  level.helicopter_list["pavelow_noai"] = true;
  level.helicopter_list["harrier"] = true;
}

init_airplane_list() {
  level.airplane_list = [];
  level.airplane_list["mig29"] = true;
  level.airplane_list["b2"] = true;
}

init_level_has_vehicles() {
  level.levelHasVehicles = false;

  vehicles = getEntArray("script_vehicle", "code_classname");
  if(vehicles.size > 0)
    level.levelHasVehicles = true;
}

trigger_getlinkmap(trigger) {
  linkMap = [];
  if(isDefined(trigger.script_linkTo)) {
    links = StrTok(trigger.script_linkTo, " ");
    foreach(link in links)
    linkMap[link] = true;
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
  if(isDefined(trigger.script_VehicleSpawngroup))
    script_vehiclespawngroup = true;
  return script_vehiclespawngroup;
}

setup_vehicle_spawners() {
  spawners = _getvehiclespawnerarray();
  foreach(spawner in spawners) {
    spawner thread vehicle_spawn_think();
  }
}

vehicle_spawn_think() {
  if(isDefined(self.script_kill_vehicle_spawner)) {
    group = self.script_kill_vehicle_spawner;
    if(!isDefined(level.vehicle_killspawn_groups[group])) {
      level.vehicle_killspawn_groups[group] = [];
    }
    level.vehicle_killspawn_groups[group][level.vehicle_killspawn_groups[group].size] = self;
  }

  if(isDefined(self.script_deathflag))
    thread maps\_spawner::vehicle_spawner_deathflag();

  self thread vehicle_linked_entities_think();

  self.count = 1;
  self.spawn_functions = [];
  for(;;) {
    vehicle = undefined;
    self waittill("spawned", vehicle);
    self.count--;
    if(!isDefined(vehicle)) {
      PrintLn("Vehicle spawned from spawner at " + self.origin + " but didnt exist!");
      continue;
    }
    vehicle.spawn_funcs = self.spawn_functions;
    vehicle.spawner = self;

    vehicle thread maps\_spawner::run_spawn_functions();
  }
}

vehicle_linked_entities_think() {
  if(!isDefined(self.script_vehiclecargo))
    return;
  if(!isDefined(self.script_linkTo)) {
    return;
  }

  aLinkedEnts = getEntArray(self.script_linkTo, "script_linkname");
  if(aLinkedEnts.size == 0) {
    return;
  }

  targetname = aLinkedEnts[0].targetname;
  aLinkedEnts = getEntArray(targetname, "targetname");

  eOrg = undefined;
  foreach(ent in aLinkedEnts) {
    if(ent.classname == "script_origin")
      eOrg = ent;
    ent Hide();
  }

  AssertEx(isDefined(eOrg), "Vehicles that have script_linkTo pointing to entities must have one of those entities be a script_origin to be used as a link point of reference");

  foreach(ent in aLinkedEnts) {
    if(ent != eOrg)
      ent LinkTo(eOrg);
  }

  self waittill("spawned", vehicle);

  foreach(ent in aLinkedEnts) {
    ent Show();
    if(ent != eOrg)
      ent LinkTo(vehicle);
  }
  vehicle waittill("death");

  foreach(ent in aLinkedEnts)
  ent Delete();
}

is_trigger_once() {
  if(!isDefined(self.classname))
    return false;

  if(self.classname == "trigger_multiple")
    return true;

  if(self.classname == "trigger_radius")
    return true;

  if(self.classname == "trigger_lookat")
    return true;

  return self.classname == "trigger_disk";
}

trigger_process(trigger, vehicles) {
  bTriggerOnce = trigger is_trigger_once();

  trigger.processed_trigger = undefined;

  if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple")
    bTriggeronce = false;

  gates = setup_script_gatetrigger(trigger);

  script_vehiclespawngroup = isDefined(trigger.script_VehicleSpawngroup);

  script_vehicledetour = isDefined(trigger.script_vehicledetour) && (is_node_script_origin(trigger) || is_node_script_struct(trigger));

  detoured = isDefined(trigger.detoured) && !(is_node_script_origin(trigger) || is_node_script_struct(trigger));
  gotrigger = true;

  vehicles = undefined;

  while(gotrigger) {
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

    trigger script_delay();

    if(bTriggeronce)
      gotrigger = false;

    if(isDefined(trigger.script_vehicleGroupDelete)) {
      if(!isDefined(level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete])) {
        PrintLn("failed to find deleteable vehicle with script_vehicleGroupDelete group number: ", trigger.script_vehicleGroupDelete);
        level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete] = [];
      }
      array_levelthread(level.vehicle_DeleteGroup[trigger.script_vehicleGroupDelete], ::deleteEnt);
    }

    if(script_vehiclespawngroup) {
      scripted_spawn(trigger.script_VehicleSpawngroup);
    }

    if(gates.size > 0 && bTriggeronce)
      array_levelthread(gates, ::path_gate_open);
    if(isDefined(trigger.script_VehicleStartMove)) {
      if(!isDefined(level.vehicle_StartMoveGroup[trigger.script_VehicleStartMove])) {
        PrintLn("^3Vehicle start trigger is: ", trigger.script_VehicleStartMove);
        return;
      }
      array_levelthread(level.vehicle_StartMoveGroup[trigger.script_VehicleStartMove], ::gopath);
    }
  }
}

path_detour_get_detourpath(detournode) {
  detourpath = undefined;
  foreach(vehicle_detourpath in level.vehicle_detourpaths[detournode.script_vehicledetour]) {
    if(vehicle_detourpath != detournode)
      if(!islastnode(vehicle_detourpath))
        detourpath = vehicle_detourpath;
  }
  return detourpath;
}

path_detour_script_origin(detournode) {
  detourpath = path_detour_get_detourpath(detournode);
  if(isDefined(detourpath))
    self thread vehicle_paths(detourpath);
}

crash_detour_check(detourpath) {
  Assert(isDefined(detourpath.script_crashtype));

  return ((isDefined(self.deaddriver) || (self.health < self.healthbuffer) || detourpath.script_crashtype == "forced") && (!isDefined(detourpath.derailed) || detourpath.script_crashtype == "plane"));
}

crash_derailed_check(detourpath) {
  return isDefined(detourpath.derailed) && detourpath.derailed;
}

path_detour(node) {
  detournode = GetVehicleNode(node.target, "targetname");
  detourpath = path_detour_get_detourpath(detournode);

  if(!isDefined(detourpath)) {
    return;
  }
  if(node.detoured && !isDefined(detourpath.script_vehicledetourgroup)) {
    return;
  }

  if(isDefined(detourpath.script_crashtype)) {
    if(!crash_detour_check(detourpath)) {
      return;
    }
    self notify("crashpath", detourpath);
    detourpath.derailed = 1;
    self notify("newpath");
    self _SetSwitchNode(node, detourpath);
    return;
  } else {
    if(crash_derailed_check(detourpath)) {
      return;
    }

    if(isDefined(detourpath.script_vehicledetourgroup)) {
      if(!isDefined(self.script_vehicledetourgroup))
        return;
      if(detourpath.script_vehicledetourgroup != self.script_vehicledetourgroup)
        return;
    }

    self notify("newpath");
    self _SetSwitchNode(detournode, detourpath);
    thread detour_flag(detourpath);
    if(!islastnode(detournode) && !(isDefined(node.scriptdetour_persist) && node.scriptdetour_persist))
      node.detoured = 1;
    self.attachedpath = detourpath;
    thread vehicle_paths();

    if(self Vehicle_IsPhysVeh() && isDefined(detournode.script_transmission))
      self thread reverse_node(detournode);
    return;
  }
}

reverse_node(detournode) {
  self endon("death");

  detournode waittillmatch("trigger", self);
  self.veh_transmission = detournode.script_transmission;
  if(self.veh_transmission == "forward")
    self vehicle_wheels_forward();
  else
    self vehicle_wheels_backward();
}

_SetSwitchNode(detournode, detourpath) {
  AssertEx(!(detourpath.lookahead == 1 && detourpath.speed == 1), "Detourpath has lookahead and speed of 1, this is indicative that neither has been set.");
  self SetSwitchNode(detournode, detourpath);
}

detour_flag(detourpath) {
  self endon("death");
  self.detouringpath = detourpath;
  detourpath waittillmatch("trigger", self);
  self.detouringpath = undefined;
}

vehicle_Levelstuff(vehicle, trigger) {
  if(isDefined(vehicle.script_linkName))
    level.vehicle_link = array_2dadd(level.vehicle_link, vehicle.script_linkname, vehicle);

  if(isDefined(vehicle.script_VehicleStartMove))
    level.vehicle_StartMoveGroup = array_2dadd(level.vehicle_StartMoveGroup, vehicle.script_VehicleStartMove, vehicle);

  if(isDefined(vehicle.script_vehicleGroupDelete))
    level.vehicle_DeleteGroup = array_2dadd(level.vehicle_DeleteGroup, vehicle.script_vehicleGroupDelete, vehicle);
}

spawn_array(spawners) {
  ai = [];
  stalinggradspawneverybody = ent_flag_exist("no_riders_until_unload");

  foreach(spawner in spawners) {
    spawner.count = 1;
    dronespawn = false;
    if(isDefined(spawner.script_drone)) {
      dronespawn = true;
      spawned = dronespawn_bodyonly(spawner);
      spawned maps\_drone::drone_give_soul();
      Assert(isDefined(spawned));
    } else {
      dontShareEnemyInfo = (isDefined(spawner.script_stealth) && flag("_stealth_enabled") && !flag("_stealth_spotted"));

      if(isDefined(spawner.script_forcespawn) || stalinggradspawneverybody)
        spawned = spawner Stalingradspawn(dontShareEnemyInfo);
      else
        spawned = spawner Dospawn(dontShareEnemyInfo);
    }

    if(!dronespawn && !isalive(spawned))
      continue;
    Assert(isDefined(spawned));
    ai[ai.size] = spawned;
  }

  ai = remove_non_riders_from_array(ai);
  return ai;
}

remove_non_riders_from_array(aiarray) {
  living_ai = [];
  foreach(ai in aiarray) {
    if(!ai_should_be_added(ai)) {
      continue;
    }
    living_ai[living_ai.size] = ai;
  }
  return living_ai;
}

ai_should_be_added(ai) {
  if(IsAlive(ai))
    return true;

  if(!isDefined(ai))
    return false;

  if(!isDefined(ai.classname))
    return false;

  return ai.classname == "script_model";
}

get_vehicle_ai_spawners() {
  spawners = [];
  if(isDefined(self.target)) {
    targets = getEntArray(self.target, "targetname");
    foreach(target in targets) {
      if(!IsSubStr(target.code_classname, "actor"))
        continue;
      if(!(target.spawnflags & 1))
        continue;
      if(isDefined(target.dont_auto_ride))
        continue;
      spawners[spawners.size] = target;
    }
  }

  if(!isDefined(self.script_vehicleride))
    return spawners;

  if(isDefined(level.vehicle_RideSpawners[self.script_vehicleride]))
    spawners = array_combine(spawners, level.vehicle_RideSpawners[self.script_vehicleride]);

  return spawners;
}

get_vehicle_ai_riders() {
  if(!isDefined(self.script_vehicleride))
    return [];
  if(!isDefined(level.vehicle_RideAI[self.script_vehicleride]))
    return [];

  return level.vehicle_RideAI[self.script_vehicleride];
}

spawn_group() {
  if(ent_flag_exist("no_riders_until_unload") && !ent_flag("no_riders_until_unload")) {
    return [];
  }

  spawners = get_vehicle_ai_spawners();
  if(!spawners.size)
    return [];

  startinvehicles = [];

  ai = spawn_array(spawners);

  ai = array_combine(ai, get_vehicle_ai_riders());

  ai = sort_by_startingpos(ai);

  foreach(guy in ai)
  self thread maps\_vehicle_aianim::guy_enter(guy);

  return ai;
}

sort_by_startingpos(guysarray) {
  firstarray = [];
  secondarray = [];
  foreach(guy in guysarray) {
    if(isDefined(guy.script_startingposition))
      firstarray[firstarray.size] = guy;
    else
      secondarray[secondarray.size] = guy;
  }
  return array_combine(firstarray, secondarray);
}

vehicle_rider_walk_setup(vehicle) {
  if(!isDefined(self.script_vehiclewalk)) {
    return;
  }
  if(isDefined(self.script_followmode))
    self.FollowMode = self.script_followmode;
  else
    self.FollowMode = "cover nodes";

  if(!isDefined(self.target)) {
    return;
  }
  node = GetNode(self.target, "targetname");
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
  for(i = 0; i < climbinnode.size; i++) {
    climborg = self GetTagOrigin(climbinnode[i]);
    climbang = self GetTagAngles(climbinnode[i]);
    org = GetStartOrigin(climborg, climbang, climbinanim[i]);
    distance = Distance(guy.origin, climborg);
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
    climborg = self GetTagOrigin(climbinnode[thenode]);
    climbang = self GetTagAngles(climbinnode[thenode]);
    org = GetStartOrigin(climborg, climbang, climbinanim[thenode]);
    guy set_forcegoal();
    guy SetGoalPos(org);
    guy.goalradius = 64;
    wait .25;
  }
  guy unset_forcegoal();

  if(self Vehicle_GetSpeed() < 1) {
    guy LinkTo(self);
    guy AnimScripted("hopinend", climborg, climbang, climbinanim[thenode]);
    guy waittillmatch("hopinend", "end");
    self guy_enter_vehicle(guy);
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
  realdetournode = GetVehicleNode(node.targetname, "target");
  if(!isDefined(realdetournode))
    return;
  realdetournode.detoured = 0;
  AssertEx(!isDefined(realdetournode.script_vehicledetour), "Detour nodes require one non-detour node before another detournode!");
  add_proccess_trigger(realdetournode);
}

turn_unloading_drones_to_ai() {
  unload_group = self get_unload_group();
  foreach(index, rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }

    if(isDefined(unload_group[rider.vehicle_position]))
      self.riders[index] = self guy_becomes_real_ai(rider, rider.vehicle_position);
  }
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
  if(!isDefined(GetVehicleNode(node.target, "targetname")) && !isDefined(get_vehiclenode_any_dynamic(node.target)))
    return true;
  return false;
}

get_path_getfunc(pathpoint) {
  get_func = ::get_from_vehicle_node;

  if(isHelicopter() && isDefined(pathpoint.target)) {
    if(isDefined(get_from_entity(pathpoint.target)))
      get_func = ::get_from_entity;
    if(isDefined(get_from_spawnStruct(pathpoint.target)))
      get_func = ::get_from_spawnstruct;
  }
  return get_func;
}

path_array_setup(pathpoint) {
  get_func = ::get_from_vehicle_node;

  if(isHelicopter() && isDefined(pathpoint.target)) {
    if(isDefined(get_from_entity(pathpoint.target)))
      get_func = ::get_from_entity;
    if(isDefined(get_from_spawnStruct(pathpoint.target)))
      get_func = ::get_from_spawnstruct;
  }

  arraycount = 0;
  pathpoints = [];
  while(isDefined(pathpoint)) {
    pathpoints[arraycount] = pathpoint;
    arraycount++;

    if(isDefined(pathpoint.target))
      pathpoint = [[get_func]](pathpoint.target);
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
  nextpoint waittillmatch("trigger", self);
}

vehicle_paths(node, bhelicopterwaitforstart) {
  AssertEx(isDefined(node) || isDefined(self.attachedpath), "vehicle_path() called without a path");
  self notify("newpath");

  if(!isDefined(bhelicopterwaitforstart))
    bhelicopterwaitforstart = false;

  if(ishelicopter())
    self endon("death");

  if(isDefined(node))
    self.attachedpath = node;

  pathstart = self.attachedpath;
  self.currentNode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }
  self endon("newpath");

  pathpoint = pathstart;

  if(bhelicopterwaitforstart)
    self waittill("start_dynamicpath");

  wait_func = ::node_wait;

  if(isHelicopter()) {
    wait_func = ::heli_wait_node;
  }

  lastpoint = undefined;
  nextpoint = pathstart;
  get_func = get_path_getfunc(pathstart);

  while(isDefined(nextpoint)) {
    if(isHelicopter() && isDefined(nextpoint.script_linkTo))
      set_lookat_from_dest(nextpoint);

    [[wait_func]](nextpoint, lastpoint);

    if(!isDefined(self)) {
      return;
    }
    self.currentNode = nextpoint;

    if(isDefined(nextpoint.gateopen) && !nextpoint.gateopen)
      self thread path_gate_wait_till_open(nextpoint);

    if(isHelicopter()) {
      nextpoint notify("trigger", self);

      if(isDefined(nextpoint.script_helimove)) {
        set_heli_move(nextpoint.script_helimove);
      }
    }

    if(isDefined(nextpoint.script_noteworthy)) {
      self notify(nextpoint.script_noteworthy);
      self notify("noteworthy", nextpoint.script_noteworthy);
    }

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(nextpoint.script_prefab_exploder)) {
      nextpoint.script_exploder = nextpoint.script_prefab_exploder;
      nextpoint.script_prefab_exploder = undefined;
    }

    if(isDefined(nextpoint.script_exploder)) {
      delay = nextpoint.script_exploder_delay;
      if(isDefined(delay)) {
        level delayThread(delay, ::exploder, nextpoint.script_exploder);
      } else {
        level exploder(nextpoint.script_exploder);
      }
    }

    if(isDefined(nextpoint.script_flag_set)) {
      if(isDefined(self.vehicle_flags))
        self.vehicle_flags[nextpoint.script_flag_set] = true;
      self notify("vehicle_flag_arrived", nextpoint.script_flag_set);
      flag_set(nextpoint.script_flag_set);
    }

    if(isDefined(nextpoint.script_ent_flag_set)) {
      self ent_flag_set(nextpoint.script_ent_flag_set);
    }

    if(isDefined(nextpoint.script_ent_flag_clear)) {
      self ent_flag_clear(nextpoint.script_ent_flag_clear);
    }

    if(isDefined(nextpoint.script_flag_clear)) {
      if(isDefined(self.vehicle_flags))
        self.vehicle_flags[nextpoint.script_flag_clear] = false;
      flag_clear(nextpoint.script_flag_clear);
    }

    if(isDefined(nextpoint.script_noteworthy)) {
      if(nextpoint.script_noteworthy == "kill")
        self force_kill();
      if(nextpoint.script_noteworthy == "godon")
        self godon();
      if(nextpoint.script_noteworthy == "godoff")
        self godoff();
      if(nextpoint.script_noteworthy == "deleteme") {
        level thread deleteent(self);
        return;
      }
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
    }

    if(isDefined(nextpoint.script_wheeldirection))
      self wheeldirectionchange(nextpoint.script_wheeldirection);

    if(vehicle_should_unload(wait_func, nextpoint))
      self thread unload_node(nextpoint);

    if(isDefined(nextpoint.script_transmission)) {
      self.veh_transmission = nextpoint.script_transmission;
      if(self.veh_transmission == "forward")
        self vehicle_wheels_forward();
      else
        self vehicle_wheels_backward();
    }

    if(isDefined(nextpoint.script_pathtype))
      self.veh_pathtype = nextpoint.script_pathtype;
  }

  if(isDefined(nextpoint.script_delay)) {
    if(isHelicopter()) {} else {
      decel = 35;
      if(isDefined(nextpoint.script_decel))
        decel = nextpoint.script_decel;
      self Vehicle_SetSpeed(0, decel);
      if(isDefined(nextpoint.target))
        self thread overshoot_next_node([[get_func]](nextpoint.target));
      nextpoint script_delay();
      self notify("delay_passed");
      self ResumeSpeed(60);
    }
  }

  if(isDefined(nextpoint.script_flag_wait)) {
    if(!isDefined(self.vehicle_flags)) {
      self.vehicle_flags = [];
    }

    self.vehicle_flags[nextpoint.script_flag_wait] = true;
    self notify("vehicle_flag_arrived", nextpoint.script_flag_wait);

    if(!flag(nextpoint.script_flag_wait) || isDefined(nextpoint.script_delay_post)) {
      if(!isHelicopter()) {
        decel = 35;
        if(isDefined(nextpoint.script_decel))
          decel = nextpoint.script_decel;
        self Vehicle_SetSpeed(0, decel);
        self thread overshoot_next_node([[get_func]](nextpoint.target));
      }
    }

    flag_wait(nextpoint.script_flag_wait);

    if(isDefined(nextpoint.script_delay_post))
      wait nextpoint.script_delay_post;

    if(!isHelicopter()) {
      accel = 10;

      if(isDefined(nextpoint.script_accel))
        accel = nextpoint.script_accel;

      self ResumeSpeed(accel);
    }

    self notify("delay_passed");
  }

  if(isDefined(self.set_lookat_point)) {
    self.set_lookat_point = undefined;
    self ClearLookAtEnt();
  }

  if(isDefined(nextpoint.script_vehicle_lights_off))
    self thread lights_off(nextpoint.script_vehicle_lights_off);
  if(isDefined(nextpoint.script_vehicle_lights_on))
    self thread lights_on(nextpoint.script_vehicle_lights_on);
  if(isDefined(nextpoint.script_forcecolor))
    self thread vehicle_script_forcecolor_riders(nextpoint.script_forcecolor);

  lastpoint = nextpoint;
  if(!isDefined(nextpoint.target)) {
    break;
  }
  nextpoint = [[get_func]](nextpoint.target);

  if(!isDefined(nextpoint)) {
    nextpoint = lastpoint;
    assertmsg("can't find nextpoint for node at origin (node targets nothing or different type?): " + lastpoint.origin);
    break;
  }
}

if(isDefined(self.script_turretmg)) {
  if(self.script_turretmg == 1) {
    self mgOn();
  } else {
    self mgOff();
  }
}

if(isDefined(nextpoint.script_land))
  self thread vehicle_landvehicle();

self notify("reached_dynamic_path_end");

if(isDefined(self.script_vehicle_selfremove))
  self Delete();
}

vehicle_should_unload(wait_func, nextpoint) {
  if(isDefined(nextpoint.script_unload))
    return true;

  if(wait_func != ::node_wait)
    return false;

  if(!islastnode(nextpoint))
    return false;

  if(isDefined(self.dontunloadonend))
    return false;

  if(self.vehicletype == "empty")
    return false;

  return !is_script_vehicle_selfremove();
}

overshoot_next_node(vnode) {
  if(!isDefined(vnode)) {
    return;
  }
  self endon("delay_passed");
  vnode waittillmatch("trigger", self);
  PrintLn("^1**************************************************************************************");
  PrintLn("^1****** WARNING!!!********************************************************************");
  PrintLn("^1**************************************************************************************");
  PrintLn("^1A vehicle most likely overshoot a node at " + vnode.origin + " while trying to come to a stop.");
  PrintLn("^1This will stop any future nodes for that vehicle to be handled by the vehicle script.");
  PrintLn("^1**************************************************************************************");
}

is_script_vehicle_selfremove() {
  if(!isDefined(self.script_vehicle_selfremove))
    return false;
  return self.script_vehicle_selfremove;
}

set_heli_move(heliMove) {
  switch (heliMove) {
    case "instant":
      self SetYawSpeed(290, 245, 222.5, 0);
      break;
    case "faster":
      self SetMaxPitchRoll(25, 50);
      self SetYawSpeed(180, 90, 22.5, 0);
      break;
    case "fast":
      self SetYawSpeed(90, 45, 22.5, 0);
      break;
    case "slow":
      self SetYawSpeed(15, 5, 15, 0);
      break;
    default:
      self SetYawSpeed(90, 45, 22.5, 0);
      break;
  }
}

must_stop_at_next_point(nextpoint) {
  if(isDefined(nextpoint.script_unload))
    return true;

  if(isDefined(nextpoint.script_delay))
    return true;

  return isDefined(nextpoint.script_flag_wait) && !flag(nextpoint.script_flag_wait);
}

heli_wait_node(nextpoint, lastpoint) {
  self endon("newpath");

  if(isDefined(nextpoint.script_unload) && isDefined(self.fastropeoffset)) {
    nextpoint.radius = 2;
    neworg = groundpos(nextpoint.origin) + (0, 0, self.fastropeoffset);

    if(neworg[2] > nextpoint.origin[2] - 2000) {
      nextpoint.origin = groundpos(nextpoint.origin) + (0, 0, self.fastropeoffset);
    }
    self SetHoverParams(0, 0, 0);
  }

  if(isDefined(lastpoint)) {
    if(isDefined(lastpoint.script_airresistance)) {
      self SetAirResistance(lastpoint.script_airresistance);
    }

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

        if(accel < 15)
          accel = 15;
      }

      if(isDefined(decel)) {
        self Vehicle_SetSpeed(speed, accel, decel);
      } else {
        self Vehicle_SetSpeed(speed, accel);
      }
    } else {
      if(must_stop_at_next_point(nextpoint)) {}
    }
  }

  self set_heli_goal(nextpoint);

  if(isDefined(nextpoint.radius)) {
    self SetNearGoalNotifyDist(nextpoint.radius);
    AssertEx(nextpoint.radius > 0, "radius: " + nextpoint.radius);
    self waittill_any("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  if(isDefined(nextpoint.script_flag_set))
    self notify("reached_current_node", nextpoint, nextpoint.script_flag_set);
  else
    self notify("reached_current_node", nextpoint);

  if(isDefined(nextpoint.script_firelink)) {
    thread heli_firelink(nextpoint);
  }

  if(isDefined(nextpoint.script_stopnode)) {
    if(nextpoint.script_stopnode)
      self notify("reached_stop_node");
    nextpoint script_delay();
  }

  nextpoint script_delay();
}

heli_firelink(nextpoint) {
  target = GetEnt(nextpoint.script_linkto, "script_linkname");
  if(!isDefined(target)) {
    target = getstruct(nextpoint.script_linkto, "script_linkname");

    AssertEx(isDefined(target), "No target for script_firelink");
  }
  fire_burst = nextpoint.script_fireLink;

  switch (fire_burst) {
    case "zippy_burst":
      wait(1);
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait(0.1);
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait(0.2);
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait(0.3);
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait(0.3);
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, target);
      break;

    default:

      if(self.classname == "script_vehicle_littlebird_armed") {
        maps\_attack_heli::heli_fire_missiles(target, 2, 0.25);
      } else {
        maps\_helicopter_globals::fire_missile("hind_zippy", 5, target, 0.3);
      }
      break;
  }
}

helipath(msg, maxspeed, accel) {
  self SetAirResistance(30);
  self Vehicle_SetSpeed(maxspeed, accel, level.heli_default_decel);
  vehicle_paths(getstruct(msg, "targetname"));
}

set_heli_goal(node) {
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
  } else
  if(isDefined(node.script_delay)) {
    stop = true;
  }

  index = -1;
  foreach(index, struct in level.struct) {
    if(node == struct) {
      break;
    }
  }

  self setvehgoalpos_wrap(node.origin, stop);
}

forcetarget(node, script_goalyaw, script_anglevehicle) {
  AssertEx(isDefined(node.angles), "Node with targetname ", node.target, " has no .angles");

  if(script_goalyaw) {
    self ClearTargetYaw();
    self SetGoalYaw(node.angles[1]);
  } else {
    self ClearGoalYaw();
    self SetTargetYaw(node.angles[1]);
  }
}

unforcetarget() {
  self ClearGoalYaw();
  self ClearTargetYaw();
}

deathrollon() {
  if(self.health > 0)
    self.rollingdeath = 1;
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

getonpath(skip_attach) {
  path_start = undefined;
  type = self.vehicletype;
  if(isDefined(self.dontgetonpath)) {
    return;
  }
  if(isDefined(self.target)) {
    path_start = GetVehicleNode(self.target, "targetname");

    if(ishelicopter() && isDefined(path_start)) {
      PrintLn("helicopter node targetname: " + path_start.targetname);
      PrintLn("vehicletype: " + self.vehicletype);
      AssertMsg("helicopter on vehicle path( see console for info )");
    }

    if(!isDefined(path_start)) {
      path_start_array = getEntArray(self.target, "targetname");
      foreach(path in path_start_array) {
        if(path.code_classname == "script_origin") {
          path_start = path;
          break;
        }
      }
    }

    if(!isDefined(path_start)) {
      path_start = getstruct(self.target, "targetname");
    }
  }

  if(!isDefined(path_start)) {
    if(ishelicopter())
      self Vehicle_SetSpeed(60, 20, level.heli_default_decel);

    return;
  }

  self.attachedpath = path_start;

  if(!isHelicopter()) {
    self.origin = path_start.origin;

    if(!isDefined(skip_attach))
      self AttachPath(path_start);
  } else {
    if(isDefined(self.speed)) {
      self Vehicle_SetSpeedImmediate(self.speed, 20);
    } else
    if(isDefined(path_start.speed)) {
      accel = 20;
      decel = level.heli_default_decel;
      if(isDefined(path_start.script_accel))
        accel = path_start.script_accel;
      if(isDefined(path_start.script_decel))
        accel = path_start.script_decel;

      self Vehicle_SetSpeedImmediate(path_start.speed, accel, decel);
    } else {
      self Vehicle_SetSpeed(60, 20, level.heli_default_decel);
    }
  }

  if(!isDefined(self.dontDisconnectPaths))
    self DisconnectPaths();
  self thread vehicle_paths(undefined, isHelicopter());
}

create_vehicle_from_spawngroup_and_gopath(spawnGroup) {
  vehicleArray = maps\_vehicle::scripted_spawn(spawnGroup);
  foreach(vehicle in vehicleArray)
  level thread maps\_vehicle::gopath(vehicle);
  return vehicleArray;
}

gopath(vehicle) {
  if(!isDefined(vehicle)) {
    vehicle = self;
    AssertEx(self.code_classname == "script_vehicle", "Tried to do goPath on a non-vehicle");
  }

  if(isDefined(vehicle.script_VehicleStartMove))
    level.vehicle_StartMoveGroup[vehicle.script_VehicleStartMove] = array_remove(level.vehicle_StartMoveGroup[vehicle.script_VehicleStartMove], vehicle);

  vehicle endon("death");

  if(isDefined(vehicle.hasstarted)) {
    PrintLn("vehicle already moving when triggered with a startmove");
    return;
  } else
    vehicle.hasstarted = true;

  vehicle script_delay();

  vehicle notify("start_vehiclepath");

  if(vehicle isHelicopter())
    vehicle notify("start_dynamicpath");
  else
    vehicle StartPath();
}

path_gate_open(node) {
  node.gateopen = true;
  node notify("gate opened");
}

path_gate_wait_till_open(pathspot) {
  self endon("death");
  self.waitingforgate = true;
  self notify("wait for gate");
  self vehicle_setspeed_wrapper(0, 15, "path gate closed");
  pathspot waittill("gate opened");
  self.waitingforgate = false;
  if(self.health > 0)
    script_resumespeed("gate opened", level.vehicle_ResumeSpeed);
}

scripted_spawn(group) {
  spawners = _getvehiclespawnerarray_by_spawngroup(group);

  vehicles = [];
  foreach(spawner in spawners)
  vehicles[vehicles.size] = vehicle_spawn(spawner);
  return vehicles;
}

vehicle_spawn(vspawner) {
  Assert(isSpawner(vspawner));
  AssertEx(!isDefined(vspawner.vehicle_spawned_thisframe), "spawning two vehicles on one spawner on the same frame is not allowed");
  vehicle = vspawner Vehicle_Dospawn();
  Assert(isDefined(vehicle));
  vspawner.vehicle_spawned_thisframe = vehicle;
  vspawner.last_spawned_vehicle = vehicle;
  vspawner thread remove_vehicle_spawned_thisframe();
  thread vehicle_init(vehicle);

  vspawner notify("spawned", vehicle);
  return vehicle;
}
get_vehicle_spawned_from_spawner_with_targetname(targetname) {
  spawner = GetEnt(targetname, "targetname");
  Assert(isDefined(spawner));
  if(isDefined(spawner.last_spawned_vehicle))
    return spawner.last_spawned_vehicle;
  return undefined;
}

remove_vehicle_spawned_thisframe() {
  wait .05;
  self.vehicle_spawned_thisframe = undefined;
}

waittill_vehiclespawn(targetname) {
  spawner = GetEnt(targetname, "targetname");
  Assert(isSpawner(spawner));

  if(isDefined(spawner.vehicle_spawned_thisframe))
    return spawner.vehicle_spawned_thisframe;

  spawner waittill("spawned", vehicle);
  return vehicle;
}

waittill_vehiclespawn_noteworthy(noteworthy) {
  potential_spawners = getEntArray(noteworthy, "script_noteworthy");
  spawner = undefined;
  foreach(test in potential_spawners) {
    if(isSpawner(test)) {
      spawner = test;
      break;
    }
  }

  Assert(isDefined(spawner));

  if(isDefined(spawner.vehicle_spawned_thisframe))
    return spawner.vehicle_spawned_thisframe;

  spawner = GetEnt(noteworthy, "script_noteworthy");
  spawner waittill("spawned", vehicle);
  return vehicle;
}

waittill_vehiclespawn_noteworthy_array(noteworthy) {
  struct = spawnStruct();
  struct.array_count = 0;
  struct.vehicles = [];

  array = [];
  potentials_array = getEntArray(noteworthy, "script_noteworthy");
  foreach(test in potentials_array) {
    if(isSpawner(test))
      array[array.size] = test;
  }

  Assert(array.size);
  array_levelthread(array, ::waittill_vehiclespawn_noteworthy_array_countdown, struct);
  struct waittill("all_vehicles_spawned");
  return struct.vehicles;
}

waittill_vehiclespawn_noteworthy_array_countdown(spawner, struct) {
  struct.array_count++;

  if(!isDefined(spawner.vehicle_spawned_thisframe))
    spawner waittill("spawned", vehicle);
  else
    vehicle = spawner.vehicle_spawned_thisframe;

  Assert(isDefined(vehicle));
  struct.array_count--;
  struct.vehicles[struct.vehicles.size] = vehicle;
  if(!struct.array_count)
    struct notify("all_vehicles_spawned");
}

vehicle_init(vehicle) {
  Assert(vehicle.classname != "script_model");

  if(vehicle.vehicletype == "empty") {
    vehicle thread getonpath();
    return;
  }

  if(vehicle.vehicletype == "bog_mortar")
    return;
  if((isDefined(vehicle.script_noteworthy)) && (vehicle.script_noteworthy == "playervehicle")) {
    return;
  }
  vehicle set_ai_number();

  vehicle.zerospeed = true;

  if(!isDefined(vehicle.modeldummyon))
    vehicle.modeldummyon = false;

  type = vehicle.vehicletype;

  vehicle vehicle_life();

  vehicle vehicle_setteam();

  PrintLn("vehicle.vehicletype is: " + vehicle.vehicletype);
  PrintLn("vehicle.model is: " + vehicle.model);
}

vehicle thread[[level.vehicleInitThread[vehicle.vehicletype][vehicle.model]]]();
vehicle thread maingun_FX();
vehicle thread playTankExhaust();

if(!isDefined(vehicle.script_avoidplayer))
  vehicle.script_avoidplayer = false;

vehicle ent_flag_init("unloaded");
vehicle ent_flag_init("loaded");
vehicle.riders = [];
vehicle.unloadque = [];
vehicle.unload_group = "default";

vehicle.fastroperig = [];
if(isDefined(level.vehicle_attachedmodels) && isDefined(level.vehicle_attachedmodels[type])) {
  rigs = level.vehicle_attachedmodels[type];
  strings = GetArrayKeys(rigs);
  foreach(string in strings) {
    vehicle.fastroperig[string] = undefined;
    vehicle.fastroperiganimating[string] = false;
  }
}
vehicle thread vehicle_badplace();
if(isDefined(vehicle.script_vehicle_lights_on))
  vehicle thread lights_on(vehicle.script_vehicle_lights_on);

if(isDefined(vehicle.script_godmode)) {
  vehicle godon();
}
if(!vehicle isCheap())
  vehicle thread friendlyfire_shield();
vehicle thread maps\_vehicle_aianim::handle_attached_guys();

if(isDefined(vehicle.script_friendname))
  vehicle setVehicleLookAtText(vehicle.script_friendname, &"");
if(!vehicle isCheap())
  vehicle thread vehicle_handleunloadevent();

if(isDefined(vehicle.script_dontunloadonend))
  vehicle.dontunloadonend = true;
vehicle thread turret_attack_think();
if(!vehicle isCheap())
  vehicle thread vehicle_shoot_shock();
vehicle thread vehicle_rumble();
if(isDefined(vehicle.script_physicsjolt) && vehicle.script_physicsjolt)
  vehicle thread physicsjolt_proximity();
vehicle thread vehicle_treads();
vehicle thread vehicle_compasshandle();

vehicle thread idle_animations();
vehicle thread animate_drive_idle();

if(isDefined(vehicle.script_deathflag)) {
  vehicle thread maps\_spawner::vehicle_deathflag();
}
if(!vehicle isCheap())
  vehicle thread mginit();

if(isDefined(level.vehicleSpawnCallbackThread))
  level thread[[level.vehicleSpawnCallbackThread]](vehicle);
vehicle_Levelstuff(vehicle);

if(isDefined(vehicle.script_team))
  vehicle SetVehicleTeam(vehicle.script_team);
if(!vehicle isCheap())
  vehicle thread disconnect_paths_whenstopped();
vehicle thread getonpath();
if(vehicle hasHelicopterDustKickup())
  vehicle thread aircraft_dust_kickup();
if(vehicle Vehicle_IsPhysVeh()) {
  if(!isDefined(vehicle.script_pathtype)) {} else {
    vehicle.veh_pathtype = vehicle.script_pathtype;
  }
}
vehicle spawn_group();
vehicle thread vehicle_kill();

vehicle apply_truckjunk();
}

kill_damage(type) {
  if(!isDefined(level.vehicle_death_radiusdamage) || !isDefined(level.vehicle_death_radiusdamage[type])) {
    return;
  }
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

  if(!isDefined(self)) {
    return;
  }
  if(level.vehicle_death_radiusdamage[type].bKillplayer)
    level.player EnableHealthShield(false);

  self RadiusDamage(self.origin + level.vehicle_death_radiusdamage[type].offset, level.vehicle_death_radiusdamage[type].range, maxdamage, mindamage, self);

  if(level.vehicle_death_radiusdamage[type].bKillplayer)
    level.player EnableHealthShield(true);
}

vehicle_kill() {
  self endon("nodeath_thread");
  type = self.vehicletype;
  model = self.model;
  targetname = self.targetname;
  attacker = undefined;
  cause = undefined;
  registered_kill = false;

  while(1) {
    if(isDefined(self))
      self waittill("death", attacker, cause);

    if(!registered_kill) {
      registered_kill = true;
      if(isDefined(attacker) && isDefined(cause)) {
        attacker maps\_player_stats::register_kill(self, cause);
        if(isDefined(self.damage_type)) {
          self.damage_type = undefined;
        }
      }
    }

    self notify("clear_c4");

    self.rumbletrigger Delete();

    if(isDefined(self.mgturret)) {
      array_levelthread(self.mgturret, ::turret_deleteme);
      self.mgturret = undefined;
    }

    level.vehicles[self.script_team] = array_remove(level.vehicles[self.script_team], self);

    level.vehicle_link[self.script_linkName] = array_remove(level.vehicle_link[self.script_linkName], self);

    if(isDefined(self.script_VehicleStartMove))
      level.vehicle_StartMoveGroup[self.script_VehicleStartMove] = array_remove(level.vehicle_StartMoveGroup[self.script_VehicleStartMove], self);

    if(isDefined(self.script_vehicleGroupDelete))
      level.vehicle_DeleteGroup[self.script_vehicleGroupDelete] = array_remove(level.vehicle_DeleteGroup[self.script_vehicleGroupDelete], self);

    if(!isDefined(self) || is_corpse()) {
      if(isDefined(self.riders))
        foreach(rider in self.riders)
      if(isDefined(rider))
        rider Delete();

      if(is_corpse()) {
        self.riders = [];
        continue;
      }

      self notify("delete_destructible");
      return;
    }

    self StopRumble(level.vehicle_rumble[type].rumble);

    if(isDefined(level.vehicle_death_thread[type]))
      thread[[level.vehicle_death_thread[type]]]();

    self array_levelthread(self.riders, maps\_vehicle_aianim::guy_vehicle_death, attacker, type);

    thread kill_damage(type);
    thread kill_badplace(type);

    kill_lights(model);

    delete_corpses_around_vehicle();

    if(isDefined(level.vehicle_deathmodel[model]))
      self thread set_death_model(level.vehicle_deathmodel[model], level.vehicle_deathmodel_delay[model]);

    rocketdeath = vehicle_should_do_rocket_death(model, attacker, cause);
    vehOrigin = self.origin;

    thread kill_fx(model, rocketdeath);

    if(self.code_classname == "script_vehicle")
      self thread kill_jolt(type);

    if(isDefined(self.delete_on_death)) {
      wait 0.05;
      if(!isDefined(self.dontDisconnectPaths) && !self Vehicle_IsPhysVeh())
        self DisconnectPaths();

      self FreeVehicle();
      wait 0.05;
      self notify("death_finished");
      self Delete();
      continue;
    }

    if(isDefined(self.free_on_death)) {
      self notify("newpath");
      if(!isDefined(self.dontDisconnectPaths))
        self DisconnectPaths();

      Vehicle_kill_badplace_forever();
      self FreeVehicle();
      return;
    }

    vehicle_do_crash(model, attacker, cause);

    if(!rocketdeath)
      vehOrigin = self.origin;
    if(isDefined(level.vehicle_death_earthquake[type]))
      earthquake(level.vehicle_death_earthquake[type].scale, level.vehicle_death_earthquake[type].duration, vehOrigin, level.vehicle_death_earthquake[type].radius);

    wait .5;

    if(is_corpse()) {
      continue;
    }
    if(isDefined(self)) {
      while(isDefined(self.dontfreeme) && isDefined(self))
        wait .05;
      if(!isDefined(self)) {
        continue;
      }
      if(self Vehicle_IsPhysVeh()) {
        while(self.veh_speed != 0)
          wait 1;
        self DisconnectPaths();
        self notify("kill_badplace_forever");
        self kill();

        self notify("newpath");
        self Vehicle_TurnEngineOff();
        return;
      } else
        self FreeVehicle();

      if(self.modeldummyon)
        self Hide();
    }

    if(vehicle_is_crashing()) {
      self Delete();
      continue;
    }
  }
}

vehicle_should_do_rocket_death(model, attacker, cause) {
  if(isDefined(self.enableRocketDeath) && self.enableRocketDeath == false)
    return false;
  if(!isDefined(cause))
    return false;
  if(!((cause == "MOD_PROJECTILE") || (cause == "MOD_PROJECTILE_SPLASH")))
    return false;

  return vehicle_has_rocket_death(model);
}

vehicle_has_rocket_death(model) {
  return isDefined(level.vehicle_death_fx["rocket_death" + self.vehicletype + model]) && isDefined(self.enableRocketDeath) && self.enableRocketDeath == true;
}

vehicle_is_crashing() {
  return (isDefined(self.crashing)) && (self.crashing == true);
}

vehicle_do_crash(model, attacker, cause) {
  crashtype = "tank";
  if(self Vehicle_IsPhysVeh())
    crashtype = "physics";
  else
  if(isDefined(self.script_crashtypeoverride))
    crashtype = self.script_crashtypeoverride;
  else
  if(self isHelicopter())
    crashtype = "helicopter";
  else
  if(isDefined(self.currentnode) && crash_path_check(self.currentnode))
    crashtype = "none";

  switch (crashtype) {
    case "helicopter":
      self thread helicopter_crash(attacker, cause);
      break;

    case "tank":
      if(!isDefined(self.rollingdeath))
        self vehicle_setspeed_wrapper(0, 25, "Dead");
      else {
        self vehicle_setspeed_wrapper(8, 25, "Dead rolling out of path intersection");
        self waittill("deathrolloff");
        self vehicle_setspeed_wrapper(0, 25, "Dead, finished path intersection");
      }

      self notify("deadstop");
      if(!isDefined(self.dontDisconnectPaths))
        self DisconnectPaths();
      if((isDefined(self.tankgetout)) && (self.tankgetout > 0))
        self waittill("animsdone");

      break;

    case "physics":
      self VehPhys_Crash();

      self notify("deadstop");
      if(!isDefined(self.dontDisconnectPaths))
        self DisconnectPaths();
      if((isDefined(self.tankgetout)) && (self.tankgetout > 0))
        self waittill("animsdone");
      break;
  }

  if(isDefined(level.vehicle_hasMainTurret[model]) && level.vehicle_hasMainTurret[model])
    self ClearTurretTarget();

  if(self isHelicopter()) {
    if((isDefined(self.crashing)) && (self.crashing == true))
      self waittill("crash_done");
  } else {
    while(!is_corpse() && isDefined(self) && self Vehicle_GetSpeed() > 0)
      wait .1;
  }

  self notify("stop_looping_death_fx");
  self notify("death_finished");
}

is_corpse() {
  is_corpse = false;
  if(isDefined(self) && self.classname == "script_vehicle_corpse")
    is_corpse = true;
  return is_corpse;
}

set_death_model(sModel, fDelay) {
  Assert(isDefined(sModel));
  if(isDefined(fDelay) && (fDelay > 0))
    wait fDelay;
  if(!isDefined(self))
    return;
  eModel = get_dummy();
  if(isDefined(self.clear_anims_on_death))
    eModel ClearAnim(%root, 0);
  if(isDefined(self))
    eModel setModel(sModel);
}

helicopter_crash(attacker, cause) {
  if(isDefined(attacker) && isPlayer(attacker))
    self.achievement_attacker = attacker;

  self.crashing = true;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(attacker) && (isPlayer(attacker))) {
    thread arcadeMode_kill(self.origin, "explosive", 750);
    attacker thread giveXp("kill", 1000);

    if(getDvar("money_sharing") == "1") {
      foreach(player in level.players)
      player thread giveMoney("kill", 750, attacker);
    } else
      attacker thread giveMoney("kill", 750);
  }

  self thread helicopter_crash_move(attacker, cause);
}

_hasweapon(weapon) {
  weapons = self GetWeaponsListAll();
  for(i = 0; i < weapons.size; i++) {
    if(IsSubStr(weapons[i], weapon))
      return true;
  }
  return false;
}

get_unused_crash_locations() {
  unusedLocations = [];
  for(i = 0; i < level.helicopter_crash_locations.size; i++) {
    if(isDefined(level.helicopter_crash_locations[i].claimed))
      continue;
    unusedLocations[unusedLocations.size] = level.helicopter_crash_locations[i];
  }
  return unusedLocations;
}

detach_getoutrigs() {
  if(!isDefined(self.fastroperig))
    return;
  if(!self.fastroperig.size)
    return;
  keys = GetArrayKeys(self.fastroperig);
  for(i = 0; i < keys.size; i++) {
    self.fastroperig[keys[i]] Unlink();
  }
}

helicopter_crash_move(attacker, cause) {
  if(isDefined(self.perferred_crash_location))
    crashLoc = self.perferred_crash_location;
  else {
    AssertEx(level.helicopter_crash_locations.size > 0, "A helicopter tried to crash but you didn't have any script_origins with targetname helicopter_crash_location in the level");
    unusedLocations = get_unused_crash_locations();
    AssertEx(unusedLocations.size > 0, "You dont have enough script_origins with targetname helicopter_crash_location in the level");
    crashLoc = getClosest(self.origin, unusedLocations);
  }
  Assert(isDefined(crashLoc));

  crashLoc.claimed = true;

  self detach_getoutrigs();

  self thread helicopter_crash_rotate();
  self notify("newpath");

  if(isDefined(crashLoc.script_parameters) && crashLoc.script_parameters == "direct") {
    Assert(isDefined(crashLoc.radius));
    crash_speed = 60;
    self Vehicle_SetSpeed(crash_speed, 15, 10);
    self SetNearGoalNotifyDist(crashLoc.radius);
    self SetVehGoalPos(crashLoc.origin, 0);
    self waittill_any("goal", "near_goal");
  } else {
    self Vehicle_SetSpeed(40, 10, 10);
    self SetNearGoalNotifyDist(300);
    self SetVehGoalPos((crashLoc.origin[0], crashLoc.origin[1], self.origin[2]), 1);

    msg = "blank";

    while(msg != "death") {
      msg = self waittill_any("goal", "near_goal", "death");

      crashLoc.claimed = undefined;
      self notify("crash_done");
      return;
    } else
      msg = "death";
  }

  self SetVehGoalPos(crashLoc.origin, 0);
  self waittill("goal");
}

crashLoc.claimed = undefined;
self notify("stop_crash_loop_sound");
self notify("crash_done");
}

helicopter_crash_rotate() {
  self endon("crash_done");
  self ClearLookAtEnt();

  self SetYawSpeed(400, 100, 100);
  for(;;) {
    if(!isDefined(self))
      return;
    iRand = RandomIntRange(90, 120);
    self SetTargetYaw(self.angles[1] + iRand);
    wait 0.5;
  }
}

crash_path_check(node) {
  targ = node;
  while(isDefined(targ)) {
    if((isDefined(targ.detoured)) && (targ.detoured == 0)) {
      detourpath = path_detour_get_detourpath(GetVehicleNode(targ.target, "targetname"));
      if(isDefined(detourpath) && isDefined(detourpath.script_crashtype))
        return true;
    }
    if(isDefined(targ.target))
      targ = GetVehicleNode(targ.target, "targetname");
    else
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

kill_fx(model, rocketdeath) {
  if(self isDestructible()) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode");
  type = self.vehicletype;
  typemodel = type + model;
  if(rocketdeath)
    typemodel = "rocket_death" + typemodel;

  for(i = 0; i < level.vehicle_death_fx[typemodel].size; i++) {
    struct = level.vehicle_death_fx[typemodel][i];
    thread kill_fx_thread(model, struct, type);
  }
}

vehicle_flag_arrived(msg) {
  if(!isDefined(self.vehicle_flags)) {
    self.vehicle_flags = [];
  }

  while(!isDefined(self.vehicle_flags[msg])) {
    self waittill("vehicle_flag_arrived", notifymsg);
    if(msg == notifymsg)
      return;
  }
}

kill_fx_thread(model, struct, type) {
  Assert(isDefined(struct));
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
  if(isDefined(struct.selfDeleteDelay))
    self delayCall(struct.selfDeleteDelay, ::Delete);
  if(isDefined(struct.effect)) {
    if((struct.bEffectLooping) && (!isDefined(self.delete_on_death))) {
      if(isDefined(struct.tag)) {
        if((isDefined(struct.stayontag)) && (struct.stayontag == true))
          thread loop_fx_on_vehicle_tag(struct.effect, struct.delay, struct.tag);
        else
          thread playLoopedFxontag(struct.effect, struct.delay, struct.tag);
      } else {
        forward = (eModel.origin + (0, 0, 100)) - eModel.origin;
        playFX(struct.effect, eModel.origin, forward);
      }
    } else if(isDefined(struct.tag))
      playFXOnTag(struct.effect, deathfx_ent(), struct.tag);
    else {
      forward = (eModel.origin + (0, 0, 100)) - eModel.origin;
      playFX(struct.effect, eModel.origin, forward);
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
  Assert(isDefined(effect));
  Assert(isDefined(tag));
  Assert(isDefined(loopTime));

  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(effect, deathfx_ent(), tag);
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
  struct = spawnStruct();
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
  Assert(isDefined(rumble));
  PreCacheRumble(rumble);
  struct.rumble = rumble;
  level.vehicle_rumble[level.vttype] = struct;
}

build_deathquake(scale, duration, radius) {
  if(!isDefined(level.vehicle_death_earthquake))
    level.vehicle_death_earthquake = [];
  level.vehicle_death_earthquake[level.vttype] = build_quake(scale, duration, radius);
}

build_quake(scale, duration, radius, basetime, randomaditionaltime) {
  struct = spawnStruct();
  struct.scale = scale;
  struct.duration = duration;
  struct.radius = radius;
  if(isDefined(basetime))
    struct.basetime = basetime;
  if(isDefined(randomaditionaltime))
    struct.randomaditionaltime = randomaditionaltime;
  return struct;
}

build_fx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, selfDeleteDelay) {
  if(!isDefined(bSoundlooping))
    bSoundlooping = false;
  if(!isDefined(bEffectLooping))
    bEffectLooping = false;
  if(!isDefined(delay))
    delay = 1;
  struct = spawnStruct();
  struct.effect = _loadfx(effect);
  struct.tag = tag;
  struct.sound = sound;
  struct.bSoundlooping = bSoundlooping;
  struct.delay = delay;
  struct.waitDelay = waitDelay;
  struct.stayontag = stayontag;
  struct.notifyString = notifyString;
  struct.bEffectLooping = bEffectLooping;
  struct.selfDeleteDelay = selfDeleteDelay;
  return struct;
}

build_deathfx_override(type, model, effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, delete_vehicle_delay) {
  level.vttype = type;
  level.vtmodel = model;
  level.vtoverride = true;
  typemodel = type + model;

  if(!isDefined(level.vehicle_death_fx))
    level.vehicle_death_fx = [];

  if(!is_overrode(typemodel))
    level.vehicle_death_fx[typemodel] = [];

  level.vehicle_death_fx_override[typemodel] = true;

  if(!isDefined(level.vehicle_death_fx[typemodel]))
    level.vehicle_death_fx[typemodel] = [];

  level.vehicle_death_fx[typemodel][level.vehicle_death_fx[typemodel].size] = build_fx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, delete_vehicle_delay);

  level.vtoverride = undefined;
}

build_deathfx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, delete_vehicle_delay) {
  AssertEx(isDefined(effect), "Failed to build death effect because there is no effect specified for the model used for that vehicle.");
  typemodel = level.vttype + level.vtmodel;

  if(is_overrode(typemodel)) {
    return;
  }
  if(!isDefined(level.vehicle_death_fx[typemodel]))
    level.vehicle_death_fx[typemodel] = [];

  level.vehicle_death_fx[typemodel][level.vehicle_death_fx[typemodel].size] = build_fx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, delete_vehicle_delay);
}

is_overrode(typemodel) {
  if(!isDefined(level.vehicle_death_fx_override))
    return false;

  if(!isDefined(level.vehicle_death_fx_override[typemodel]))
    return false;

  if(isDefined(level.vtoverride))
    return true;

  return level.vehicle_death_fx_override[typemodel];
}

build_rocket_deathfx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, delete_vehicle_delay) {
  vttype = level.vttype;
  level.vttype = "rocket_death" + vttype;
  build_deathfx(effect, tag, sound, bEffectLooping, delay, bSoundlooping, waitDelay, stayontag, notifyString, delete_vehicle_delay);
  level.vttype = vttype;
}

precache_scripts() {
  allvehiclesprespawn = [];

  vehicles = getEntArray("script_vehicle", "code_classname");

  level.needsprecaching = [];
  playerdrivablevehicles = [];
  allvehiclesprespawn = [];
  if(!isDefined(level.vehicleInitThread))
    level.vehicleInitThread = [];

  for(i = 0; i < vehicles.size; i++) {
    vehicles[i].vehicletype = ToLower(vehicles[i].vehicletype);
    if(vehicles[i].vehicletype == "bog_mortar" || vehicles[i].vehicletype == "empty") {
      continue;
    }
    if(isDefined(vehicles[i].spawnflags) && vehicles[i].spawnflags & 1)
      playerdrivablevehicles[playerdrivablevehicles.size] = vehicles[i];

    allvehiclesprespawn[allvehiclesprespawn.size] = vehicles[i];

    if(!isDefined(level.vehicleInitThread[vehicles[i].vehicletype]))
      level.vehicleInitThread[vehicles[i].vehicletype] = [];

    loadstring = "maps\\\_" + vehicles[i].vehicletype + "::main( \"" + vehicles[i].model + "\" );";

    precachesetup(loadstring, vehicles[i]);
  }

  if(level.needsprecaching.size > 0) {
    PrintLn("----------------------------------------------------------------------------------");
    PrintLn("---missing vehicle script: run repackage zone and precache scripts from launcher--");
    PrintLn("----------------------------------------------------------------------------------");
    for(i = 0; i < level.needsprecaching.size; i++)
      PrintLn(level.needsprecaching[i]);
    PrintLn("----------------------------------------------------------------------------------");
    AssertEx(false, "missing vehicle scripts, see above console prints");
    level waittill("never");
  }

  return allvehiclesprespawn;
}

precachesetup(string, vehicle) {
  if(isDefined(level.vehicleInitThread[vehicle.vehicletype][vehicle.model]))
    return;
  matched = false;
  for(i = 0; i < level.needsprecaching.size; i++)
    if(level.needsprecaching[i] == string)
      matched = true;
  if(!matched)
    level.needsprecaching[level.needsprecaching.size] = string;
}

vehicle_kill_disconnect_paths_forever() {
  self notify("kill_disconnect_paths_forever");
}

disconnect_paths_whenstopped() {
  self endon("death");
  dont_disconnect_paths = false;
  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
    dont_disconnect_paths = true;

  if(dont_disconnect_paths) {
    self.dontDisconnectPaths = true;
    return;
  }
  wait(RandomFloat(1));
  while(isDefined(self)) {
    if(self Vehicle_GetSpeed() < 1) {
      if(!isDefined(self.dontDisconnectPaths))
        self DisconnectPaths();
      self notify("speed_zero_path_disconnect");
      while(self Vehicle_GetSpeed() < 1)
        wait .05;
    }
    self ConnectPaths();
    wait 1;
  }
}

vehicle_setspeed_wrapper(speed, rate, msg) {
  if(self Vehicle_GetSpeed() == 0 && speed == 0) {
    return;
  }
  self thread debug_vehiclesetspeed(speed, rate, msg);

  self Vehicle_SetSpeed(speed, rate);
}

debug_vehiclesetspeed(speed, rate, msg) {
  self notify("new debug_vehiclesetspeed");
  self endon("new debug_vehiclesetspeed");
  self endon("resuming speed");
  self endon("death");
  while(1) {
    while(getDvar("debug_vehiclesetspeed") != "off") {
      Print3d(self.origin + (0, 0, 192), "vehicle setspeed: " + msg, (1, 1, 1), 1, 3);
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
  if(isDefined(self.waitingforgate) && self.waitingforgate) {
    return;
  }
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
    self ResumeSpeed(rate);
  else if(type == "setspeed")
    self vehicle_setspeed_wrapper(fSetspeed, 15, "resume setspeed from attack");
  self notify("resuming speed");
  self thread debug_vehicleresume(msg + " :" + type);
}

debug_vehicleresume(msg) {
  if(getDvar("debug_vehicleresume") == "off")
    return;
  self endon("death");
  number = self.resumemsgs.size;
  self.resumemsgs[number] = msg;
  timer = 3;
  self thread print_resumespeed(GetTime() + (timer * 1000));

  wait timer;
  newarray = [];
  for(i = 0; i < self.resumemsgs.size; i++) {
    if(i != number)
      newarray[newarray.size] = self.resumemsgs[i];
  }
  self.resumemsgs = newarray;
}

print_resumespeed(timer) {
  self notify("newresumespeedmsag");
  self endon("newresumespeedmsag");
  self endon("death");
  while(GetTime() < timer && isDefined(self.resumemsgs)) {
    if(self.resumemsgs.size > 6)
      start = self.resumemsgs.size - 5;
    else
      start = 0;
    for(i = start; i < self.resumemsgs.size; i++) {
      position = i * 32;
      Print3d(self.origin + (0, 0, position), "resuming speed: " + self.resumemsgs[i], (0, 1, 0), 1, 3);
    }
    wait .05;
  }
}

force_kill() {
  if(isDestructible()) {
    self common_scripts\_destructible::force_explosion();
  } else {
    self Kill();
  }
}

godon() {
  self.godmode = true;
}

godoff() {
  self.godmode = false;
}

setturretfireondrones(b) {
  if(isDefined(self.mgturret) && self.mgturret.size)
    for(i = 0; i < self.mgturret.size; i++)
      self.mgturret[i].script_fireondrones = b;
}

getnormalanimtime(animation) {
  animtime = self GetAnimTime(animation);
  animlength = GetAnimLength(animation);
  if(animtime == 0)
    return 0;
  return self GetAnimTime(animation) / GetAnimLength(animation);
}

rotor_anim() {
  length = GetAnimLength(self getanim("rotors"));
  for(;;) {
    self SetAnim(self getanim("rotors"), 1, 0, 1);
    wait(length);
  }
}

suspend_drive_anims() {
  self notify("suspend_drive_anims");

  model = self.model;

  self ClearAnim(level.vehicle_DriveIdle[model], 0);
  self ClearAnim(level.vehicle_DriveIdle_r[model], 0);
}

idle_animations() {
  self UseAnimTree(#animtree);

  if(!isDefined(level.vehicle_IdleAnim[self.model])) {
    return;
  }
  foreach(animation in level.vehicle_IdleAnim[self.model])
  self setanim(animation);
}

animate_drive_idle() {
  self endon("suspend_drive_anims");

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

  while(1) {
    if(!normalspeed) {
      if(isDefined(self.suspend_driveanims)) {
        wait .05;
        continue;
      }

      animatemodel SetAnim(level.vehicle_DriveIdle[model], 1, .2, animrate);
      thread animtimer(.5);
      self waittill("animtimer");
      continue;
    }

    speed = self Vehicle_GetSpeed();

    if(lastdir != self.wheeldir) {
      dif = 0;
      if(self.wheeldir) {
        animation = level.vehicle_DriveIdle[model];
        dif = 1 - animatemodel getnormalanimtime(level.vehicle_DriveIdle_r[model]);
        animatemodel ClearAnim(level.vehicle_DriveIdle_r[model], 0);
      } else {
        animation = level.vehicle_DriveIdle_r[model];
        dif = 1 - animatemodel getnormalanimtime(level.vehicle_DriveIdle[model]);
        animatemodel ClearAnim(level.vehicle_DriveIdle[model], 0);
      }

      newanimtime = 0.01;
      if(newanimtime >= 1 || newanimtime == 0)
        newanimtime = 0.01;
      lastdir = self.wheeldir;
    }

    if(speed == 0)
      animatemodel SetAnim(animation, 1, .05, 0);
    else
      animatemodel SetAnim(animation, 1, .05, speed / normalspeed);

    if(isDefined(newanimtime)) {
      animatemodel SetAnimTime(animation, newanimtime);
      newanimtime = undefined;
    }

    thread animtimer(.05);
    self waittill("animtimer");
  }
}

animtimer(time) {
  self endon("animtimer");
  wait time;
  self notify("animtimer");
}

animate_drive_idle_death() {
  self endon("suspend_drive_anims");

  model = self.model;
  self UseAnimTree(#animtree);
  self waittill("death_finished");
  if(isDefined(self))
    self ClearAnim(level.vehicle_DriveIdle[model], 0);
}

setup_dynamic_detour(pathnode, get_func) {
  prevnode = [[get_func]](pathnode.targetname);
  AssertEx(isDefined(prevnode), "detour can't be on start node");
  prevnode.detoured = 0;
}

setup_ai() {
  ai = GetAIArray();
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_vehicleride))
      level.vehicle_RideAI = array_2dadd(level.vehicle_RideAI, ai[i].script_vehicleride, ai[i]);
    else
    if(isDefined(ai[i].script_vehiclewalk))
      level.vehicle_WalkAI = array_2dadd(level.vehicle_WalkAI, ai[i].script_vehiclewalk, ai[i]);
  }
  ai = GetSpawnerArray();

  for(i = 0; i < ai.size; i++) {
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
    if(isDefined(get_from_spawnStruct(self.targetname)))
      get_func = ::get_from_spawnstruct_target;

    if(isDefined(get_func)) {
      setup_dynamic_detour(self, get_func);
      processtrigger = true;
    } else {
      setup_groundnode_detour(self);
    }

    level.vehicle_detourpaths = array_2dadd(level.vehicle_detourpaths, self.script_vehicledetour, self);
    if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2)
      PrintLn("more than two script_vehicledetour grouped in group number: ", self.script_vehicledetour);
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

  if(isDefined(self.script_VehicleSpawngroup) || isDefined(self.script_VehicleStartMove) || isDefined(self.script_gatetrigger) || isDefined(self.script_vehicleGroupDelete))
    processtrigger = true;

  if(processtrigger)
    add_proccess_trigger(self);
}

setup_triggers() {
  level.vehicle_processtriggers = [];

  triggers = [];
  triggers = array_combine(GetAllVehicleNodes(), getEntArray("script_origin", "code_classname"));
  triggers = array_combine(triggers, level.struct);
  triggers = array_combine(triggers, getEntArray("trigger_radius", "code_classname"));
  triggers = array_combine(triggers, getEntArray("trigger_disk", "code_classname"));
  triggers = array_combine(triggers, getEntArray("trigger_multiple", "code_classname"));
  triggers = array_combine(triggers, getEntArray("trigger_lookat", "code_classname"));

  array_thread(triggers, ::node_trigger_process);
}

is_node_script_struct(node) {
  if(!isDefined(node.targetname))
    return false;
  return isDefined(getstruct(node.targetname, "targetname"));
}

setup_vehicles(vehicles) {
  nonspawned = [];
  level.failed_spawnvehicles = [];

  foreach(vehicle in vehicles) {
    vehicle setup_gags();

    if(vehicle check_spawn_group_isspawner())
      continue;
    else
      nonspawned[nonspawned.size] = vehicle;
  }

  check_failed_spawn_groups();

  foreach(live_vehicle in nonspawned)
  thread vehicle_init(live_vehicle);
}

check_failed_spawn_groups() {
  if(!level.failed_spawnvehicles.size) {
    level.failed_spawnvehicles = undefined;
    return;
  }

  PrintLn("Error: FAILED SPAWNGROUPS");
  foreach(failed_spawner in level.failed_spawnvehicles) {
    PrintLn("Error: spawner at: " + failed_spawner.origin);
  }
  AssertMsg("Spawngrouped vehicle( s ) without spawnflag checked, see console");
}

check_spawn_group_isspawner() {
  if(isDefined(self.script_VehicleSpawngroup) && !isSpawner(self)) {
    level.failed_spawnvehicles[level.failed_spawnvehicles.size] = self;
    return true;
  }
  return isSpawner(self);
}

vehicle_life() {
  type = self.vehicletype;

  if(!isDefined(level.vehicle_life) || !isDefined(level.vehicle_life[self.vehicletype])) {
    wait 2;
  }
  AssertEx(isDefined(level.vehicle_life[type]), "need to specify build_life() in vehicle script for vehicletype: " + type);

  if(isDefined(self.script_startinghealth))
    self.health = self.script_startinghealth;
  else {
    if(level.vehicle_life[type] == -1)
      return;
    else if(isDefined(level.vehicle_life_range_low[type]) && isDefined(level.vehicle_life_range_high[type]))
      self.health = (RandomInt(level.vehicle_life_range_high[type] - level.vehicle_life_range_low[type]) + level.vehicle_life_range_low[type]);
    else
      self.health = level.vehicle_life[type];
  }

  if(isDefined(level.destructible_model[self.model])) {
    self.health = 2000;
    self.destructible_type = level.destructible_model[self.model];
    self common_scripts\_destructible::setup_destructibles(true);
  }
}

mginit() {
  typemodel = self.vehicletype + self.model;

  if(((isDefined(self.script_nomg)) && (self.script_nomg > 0))) {
    return;
  }
  if(!isDefined(level.vehicle_mgturret[typemodel])) {
    return;
  }
  mgangle = 0;
  if(isDefined(self.script_mg_angle))
    mgangle = self.script_mg_angle;

  turret_templates = level.vehicle_mgturret[typemodel];
  if(!isDefined(turret_templates)) {
    return;
  }
  one_turret = isDefined(self.script_noteworthy) && self.script_noteworthy == "onemg";

  foreach(index, turret_template in turret_templates) {
    turret = SpawnTurret("misc_turret", (0, 0, 0), turret_template.info);
    turret LinkTo(self, turret_template.tag, (0, 0, 0), (0, -1 * mgangle, 0));
    turret setModel(turret_template.model);
    turret.angles = self.angles;
    turret.isvehicleattached = true;
    turret.ownerVehicle = self;
    Assert(isDefined(self.script_team));
    turret.script_team = self.script_team;
    turret thread maps\_mgturret::burst_fire_unmanned();
    turret MakeUnusable();
    set_turret_team(turret);
    level thread maps\_mgturret::mg42_setdifficulty(turret, getDifficulty());

    if(isDefined(self.script_fireondrones))
      turret.script_fireondrones = self.script_fireondrones;
    if(isDefined(turret_template.deletedelay))
      turret.deletedelay = turret_template.deletedelay;

    if(isDefined(turret_template.maxrange))
      turret.maxrange = turret_template.maxrange;

    if(isDefined(turret_template.defaultdroppitch))
      turret SetDefaultDropPitch(turret_template.defaultdroppitch);

    self.mgturret[index] = turret;

    if(one_turret) {
      break;
    }
  }

  foreach(i, turret in self.mgturret) {
    defaultOnMode = level.vehicle_mgturret[typemodel][i].defaultONmode;
    if(isDefined(defaultOnMode)) {
      turret turret_set_default_on_mode(defaultOnMode);
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
  while(1) {
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
  self.script_turretmg = 0;

  if((self isHelicopter()) && (self hasHelicopterTurret())) {
    self thread chopper_Turret_Off();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(i, turret in self.mgturret) {
    if(isDefined(turret.script_fireondrones))
      turret.script_fireondrones = false;

    turret SetMode("manual");
  }
}

mgon() {
  self.script_turretmg = 1;

  if((self isHelicopter()) && (self hasHelicopterTurret())) {
    self thread chopper_Turret_On();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(turret in self.mgturret) {
    turret Show();

    if(isDefined(turret.script_fireondrones))
      turret.script_fireondrones = true;

    if(isDefined(turret.defaultONmode)) {
      turret SetMode(turret.defaultONmode);
    } else {
      turret SetMode("auto_nonai");
    }

    set_turret_team(turret);
  }
}

set_turret_team(turret) {
  switch (self.script_team) {
    case "allies":
    case "friendly":
      turret SetTurretTeam("allies");
      break;

    case "axis":
    case "enemy":
      turret SetTurretTeam("axis");
      break;
    case "team3":
      turret SetTurretTeam("team3");
      break;

    default:
      AssertMsg("Unknown script_team: " + self.script_team);
      break;
  }
}

turret_set_default_on_mode(defaultOnMode) {
  self.defaultONmode = defaultOnMode;
}

isHelicopter() {
  return isDefined(level.helicopter_list[self.vehicletype]);
}

isAirplane() {
  return isDefined(level.airplane_list[self.vehicletype]);
}

isCheap() {
  if(!isDefined(self.script_cheap))
    return false;

  if(!self.script_cheap)
    return false;

  return true;
}

hasHelicopterDustKickup() {
  if(!isHelicopter() && !isAirplane())
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
  if(self.vehicletype == "viper")
    return true;
  return false;
}

Chopper_Turret_On() {
  self endon("death");
  self endon("mg_off");

  cosine55 = Cos(55);

  while(self.health > 0) {
    eTarget = self maps\_helicopter_globals::getEnemyTarget(16000, cosine55, true, true);
    if(isDefined(eTarget))
      self thread maps\_helicopter_globals::shootEnemyTarget_Bullets(eTarget);
    wait 2;
  }
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
    playFX(effect, effectorigin.origin, effectorigin.upvec);
    wait durration;
  }
}

playLoopedFxontag_originupdate(tag, effectorigin) {
  effectorigin.angles = self GetTagAngles(tag);
  effectorigin.origin = self GetTagOrigin(tag);
  effectorigin.forwardvec = anglesToForward(effectorigin.angles);
  effectorigin.upvec = AnglesToUp(effectorigin.angles);
  while(isDefined(self) && self.code_classname == "script_vehicle" && self Vehicle_GetSpeed() > 0) {
    eModel = get_dummy();
    effectorigin.angles = eModel GetTagAngles(tag);
    effectorigin.origin = eModel GetTagOrigin(tag);
    effectorigin.forwardvec = anglesToForward(effectorigin.angles);
    effectorigin.upvec = AnglesToUp(effectorigin.angles);
    wait .05;
  }
}

build_turret(info, tag, model, maxrange, defaultONmode, deletedelay, defaultdroppitch, defaultdropyaw) {
  if(!isDefined(level.vehicle_mgturret))
    level.vehicle_mgturret = [];

  typemodel = level.vttype + level.vtmodel;
  if(!isDefined(level.vehicle_mgturret[typemodel]))
    level.vehicle_mgturret[typemodel] = [];

  PreCacheModel(model);
  PreCacheTurret(info);
  struct = spawnStruct();
  struct.info = info;
  struct.tag = tag;
  struct.model = model;
  struct.maxrange = maxrange;
  struct.defaultONmode = defaultONmode;
  struct.deletedelay = deletedelay;
  struct.defaultdroppitch = defaultdroppitch;
  struct.defaultdropyaw = defaultdropyaw;
  level.vehicle_mgturret[typemodel][level.vehicle_mgturret[typemodel].size] = struct;
}

setup_dvars() {
  SetDvarIfUninitialized("debug_tankcrush", "0");
  SetDvarIfUninitialized("debug_vehicleresume", "off");
  SetDvarIfUninitialized("debug_vehiclesetspeed", "off");
}

empty_var(var) {}

setup_levelvars() {
  level.vehicle_ResumeSpeed = 5;
  level.vehicle_DeleteGroup = [];
  level.vehicle_StartMoveGroup = [];
  level.vehicle_RideAI = [];
  level.vehicle_WalkAI = [];
  level.vehicle_DeathSwitch = [];
  level.vehicle_RideSpawners = [];
  level.vehicle_walkspawners = [];
  level.vehicle_gatetrigger = [];
  level.vehicle_crashpaths = [];
  level.vehicle_link = [];
  level.vehicle_detourpaths = [];

  level.vehicle_startnodes = [];
  level.vehicle_killspawn_groups = [];

  if(!isDefined(level.drive_spline_path_fun))
    level.drive_spline_path_fun = ::empty_var;

  level.helicopter_crash_locations = getEntArray("helicopter_crash_location", "targetname");

  level.playervehicle = spawn("script_origin", (0, 0, 0));
  level.playervehiclenone = level.playervehicle;

  level.vehicles = [];
  level.vehicles["allies"] = [];
  level.vehicles["axis"] = [];
  level.vehicles["neutral"] = [];
  level.vehicles["team3"] = [];

  if(!isDefined(level.vehicle_team))
    level.vehicle_team = [];
  if(!isDefined(level.vehicle_deathmodel))
    level.vehicle_deathmodel = [];
  if(!isDefined(level.vehicle_death_thread))
    level.vehicle_death_thread = [];
  if(!isDefined(level.vehicle_DriveIdle))
    level.vehicle_DriveIdle = [];
  if(!isDefined(level.vehicle_DriveIdle_r))
    level.vehicle_DriveIdle_r = [];
  if(!isDefined(level.attack_origin_condition_threadd))
    level.attack_origin_condition_threadd = [];
  if(!isDefined(level.vehiclefireanim))
    level.vehiclefireanim = [];
  if(!isDefined(level.vehiclefireanim_settle))
    level.vehiclefireanim_settle = [];
  if(!isDefined(level.vehicle_hasname))
    level.vehicle_hasname = [];
  if(!isDefined(level.vehicle_turret_requiresrider))
    level.vehicle_turret_requiresrider = [];
  if(!isDefined(level.vehicle_rumble))
    level.vehicle_rumble = [];
  if(!isDefined(level.vehicle_mgturret))
    level.vehicle_mgturret = [];
  if(!isDefined(level.vehicle_isStationary))
    level.vehicle_isStationary = [];
  if(!isDefined(level.vehicle_rumble))
    level.vehicle_rumble = [];
  if(!isDefined(level.vehicle_death_earthquake))
    level.vehicle_death_earthquake = [];
  if(!isDefined(level.vehicle_treads))
    level.vehicle_treads = [];
  if(!isDefined(level.vehicle_compassicon))
    level.vehicle_compassicon = [];
  if(!isDefined(level.vehicle_unloadgroups))
    level.vehicle_unloadgroups = [];
  if(!isDefined(level.vehicle_aianims))
    level.vehicle_aianims = [];
  if(!isDefined(level.vehicle_unloadwhenattacked))
    level.vehicle_unloadwhenattacked = [];
  if(!isDefined(level.vehicle_exhaust))
    level.vehicle_exhaust = [];
  if(!isDefined(level.vehicle_deckdust))
    level.vehicle_deckdust = [];
  if(!isDefined(level.vehicle_shoot_shock))
    level.vehicle_shoot_shock = [];
  if(!isDefined(level.vehicle_frontarmor))
    level.vehicle_frontarmor = [];
  if(!isDefined(level.destructible_model))
    level.destructible_model = [];
  if(!isDefined(level.vehicle_types))
    level.vehicle_types = [];
  if(!isDefined(level.vehicle_compass_types))
    level.vehicle_compass_types = [];
  if(!isDefined(level.vehicle_grenadeshield))
    level.vehicle_grenadeshield = [];
  if(!isDefined(level.vehicle_bulletshield))
    level.vehicle_bulletshield = [];
  if(!isDefined(level.vehicle_death_jolt))
    level.vehicle_death_jolt = [];
  if(!isDefined(level.vehicle_death_badplace))
    level.vehicle_death_badplace = [];
  if(!isDefined(level.vehicle_IdleAnim))
    level.vehicle_IdleAnim = [];

  maps\_vehicle_aianim::setup_aianimthreads();
}

attacker_isonmyteam(attacker) {
  if((isDefined(attacker)) && isDefined(attacker.script_team) && (isDefined(self.script_team)) && (attacker.script_team == self.script_team))
    return true;
  else
    return false;
}

is_invulnerable_from_ai(attacker) {
  if(!isDefined(self.script_AI_invulnerable))
    return false;
  if((isDefined(attacker)) && (IsAI(attacker)) && (self.script_AI_invulnerable == 1))
    return true;
  else
    return false;
}

is_godmode() {
  if(isDefined(self.godmode) && self.godmode)
    return true;
  else
    return false;
}

attacker_troop_isonmyteam(attacker) {
  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(attacker) && isPlayer(attacker))
    return true;
  else if(IsAI(attacker) && attacker.team == self.script_team)
    return true;
  else
    return false;
}

has_frontarmor() {
  return (isDefined(level.vehicle_frontarmor[self.vehicletype]));
}

grenadeshielded(type) {
  if(!isDefined(self.script_grenadeshield))
    return false;

  type = ToLower(type);

  if(!isDefined(type) || !IsSubStr(type, "grenade"))
    return false;

  if(self.script_grenadeshield)
    return true;
  else
    return false;
}

bulletshielded(type) {
  if(!isDefined(self.script_bulletshield))
    return false;

  type = ToLower(type);

  if(!isDefined(type) || !IsSubStr(type, "bullet") || IsSubStr(type, "explosive"))
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

  if(isDefined(level.vehicle_grenadeshield[self.vehicletype]) && !isDefined(self.script_grenadeshield))
    self.script_grenadeshield = level.vehicle_bulletshield[self.vehicletype];

  if(isDefined(self.script_mp_style_helicopter)) {
    self.script_mp_style_helicopter = true;
    self.bullet_armor = 5000;
    self.health = 350;
  } else
    self.script_mp_style_helicopter = false;

  self.healthbuffer = 20000;
  self.health += self.healthbuffer;
  self.currenthealth = self.health;
  attacker = undefined;
  type = undefined;

  while(self.health > 0) {
    self waittill("damage", amount, attacker, direction_vec, point, type, modelName, tagName);

    if(isDefined(attacker))
      attacker maps\_player_stats::register_shot_hit();

    if((!isDefined(attacker) && self.script_team != "neutral") || is_godmode() || attacker_isonmyteam(attacker) || attacker_troop_isonmyteam(attacker) || isDestructible() || is_invulnerable_from_ai(attacker) || bulletshielded(type) || grenadeshielded(type) || type == "MOD_MELEE")
      self.health = self.currenthealth;
    else if(self has_frontarmor()) {
      self regen_front_armor(attacker, amount);
      self.currenthealth = self.health;
    } else if(self hit_bullet_armor(type)) {
      self.health = self.currenthealth;
      self.bullet_armor -= amount;
    } else
      self.currenthealth = self.health;

    if(common_scripts\_destructible::getDamageType(type) == "splash")
      self.rocket_destroyed_for_achievement = true;
    else
      self.rocket_destroyed_for_achievement = undefined;

    if(self.health < self.healthbuffer && !isDefined(self.vehicle_stays_alive)) {
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

  self notify("death", attacker, type);
}

hit_bullet_armor(type) {
  if(!self.script_mp_style_helicopter)
    return false;
  if(self.bullet_armor <= 0)
    return false;
  if(!(isDefined(type)))
    return false;
  if(!IsSubStr(type, "BULLET"))
    return false;
  else
    return true;
}

regen_front_armor(attacker, amount) {
  forwardvec = anglesToForward(self.angles);
  othervec = VectorNormalize(attacker.origin - self.origin);
  if(VectorDot(forwardvec, othervec) > .86)
    self.health += Int(amount * level.vehicle_frontarmor[self.vehicletype]);
}

vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

vehicle_rumble() {
  self endon("kill_rumble_forever");
  type = self.vehicletype;
  if(!isDefined(level.vehicle_rumble[type])) {
    return;
  }
  rumblestruct = level.vehicle_rumble[type];
  height = rumblestruct.radius * 2;
  zoffset = -1 * rumblestruct.radius;
  areatrigger = spawn("trigger_radius", self.origin + (0, 0, zoffset), 0, rumblestruct.radius, height);
  areatrigger EnableLinkTo();
  areatrigger LinkTo(self);
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

  if(isDefined(rumblestruct.radius)) {
    self.rumble_radius = rumblestruct.radius;
  } else {
    self.rumble_radius = 600;
  }

  if(isDefined(rumblestruct.basetime)) {
    self.rumble_basetime = rumblestruct.basetime;
  } else {
    self.rumble_basetime = 1;
  }

  if(isDefined(rumblestruct.randomaditionaltime)) {
    self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }

  areatrigger.radius = self.rumble_radius;
  while(1) {
    areatrigger waittill("trigger");
    if(self Vehicle_GetSpeed() == 0 || !self.rumbleon) {
      wait .1;
      continue;
    }

    self PlayRumbleLoopOnEntity(level.vehicle_rumble[type].rumble);
    while(level.player IsTouching(areatrigger) && self.rumbleon && self Vehicle_GetSpeed() > 0) {
      Earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait(self.rumble_basetime + RandomFloat(self.rumble_randomaditionaltime));
    }
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
  if(!self Vehicle_IsPhysVeh())
    self endon("death");
  self endon("delete");
  if(isDefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }
  hasturret = isDefined(level.vehicle_hasMainTurret[self.model]) && level.vehicle_hasMainTurret[self.model];
  bp_duration = .5;
  bp_angle_left = 17;
  bp_angle_right = 17;
  for(;;) {
    if(!self.script_badplace) {
      while(!self.script_badplace)
        wait .5;
    }
    speed = self Vehicle_GetSpeed();
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
      bp_direction = anglesToForward(self GetTagAngles("tag_turret"));
    else
      bp_direction = anglesToForward(self.angles);

    BadPlace_Arc(self.unique_id + "arc", bp_duration, self.origin, bp_radius * 1.9, CONST_bp_height, bp_direction, bp_angle_left, bp_angle_right, "axis", "team3", "allies");
    BadPlace_Cylinder(self.unique_id + "cyl", bp_duration, self.origin, 200, CONST_bp_height, "axis", "team3", "allies");

    wait bp_duration + .05;
  }
}

no_treads() {
  if(self isHelicopter())
    return true;

  if(self isAirplane())
    return true;

  return false;
}

vehicle_treads() {
  if(!isDefined(level.vehicle_treads[self.vehicletype])) {
    return;
  }
  if(no_treads()) {
    return;
  }
  if(isDefined(level.tread_override_thread)) {
    self thread[[level.tread_override_thread]]("tag_origin", "back_left", (160, 0, 0));
    return;
  }

  singleTreadVehicles[0] = "snowmobile";
  singleTreadVehicles[1] = "snowmobile_friendly";
  singleTreadVehicles[2] = "snowmobile_player";
  singleTreadVehicles[3] = "motorcycle";
  if(is_in_array(singleTreadVehicles, self.vehicletype)) {
    self thread tread("tag_wheel_back_left", "back_left", undefined, "tag_wheel_back_right");
  } else {
    self thread tread("tag_wheel_back_left", "back_left");
    self thread tread("tag_wheel_back_right", "back_right");
  }
}

vehicle_kill_treads_forever() {
  self notify("kill_treads_forever");
}

tread(tagname, side, relativeOffset, secondTag, fakespeed) {
  self endon("death");
  treadfx = treadget(self, side);
  self endon("kill_treads_forever");
  for(;;) {
    speed = self Vehicle_GetSpeed();
    if(speed == 0) {
      if(isDefined(fakespeed)) {
        speed = fakespeed;
      } else {
        wait 0.1;
        continue;
      }
    }
    speed *= CONST_MPHCONVERSION;
    waitTime = (1 / speed);
    waitTime = (waitTime * 35);
    if(waitTime < 0.1)
      waitTime = 0.1;
    else if(waitTime > 0.3)
      waitTime = 0.3;
    wait waitTime;
    lastfx = treadfx;
    treadfx = treadget(self, side);
    if(treadfx != -1) {
      ang = self GetTagAngles(tagname);
      forwardVec = anglesToForward(ang);

      effectOrigin = self GetTagOrigin(tagname);

      if(isDefined(secondTag)) {
        secondTagOrigin = self GetTagOrigin(secondTag);
        effectOrigin = (effectOrigin + secondTagOrigin) / 2;
      }

      forwardVec = vector_multiply(forwardVec, waitTime);
      upVec = AnglesToUp(ang);
      playFX(treadfx, effectOrigin, upVec, forwardVec);
    }
  }
}

treadget(vehicle, side) {
  surface = self GetWheelSurface(side);
  if(!isDefined(vehicle.vehicletype)) {
    treadfx = -1;
    return treadfx;
  }

  if(!isDefined(level._vehicle_effect[vehicle.vehicletype])) {
    PrintLn("no treads setup for vehicle type: ", vehicle.vehicletype);
    wait 1;
    return -1;
  }
  treadfx = level._vehicle_effect[vehicle.vehicletype][surface];

  if(surface == "ice")
    self notify("iminwater");

  if(!isDefined(treadfx))
    treadfx = -1;

  return treadfx;
}

turret_attack_think() {
  if(self isHelicopter()) {
    return;
  }

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
  if(level.vehicle_mainTurrets[self.model].size) {
    turrets = GetArrayKeys(level.vehicle_mainTurrets[self.model]);
  }
  while(self.health > 0) {
    self waittill("turret_fire");
    self notify("groupedanimevent", "turret_fire");
    if(!turrets.size)
      self FireWeapon();
    else {
      self FireWeapon(turrets[index]);
      index++;
      if(index >= turrets.size)
        index = 0;
    }
  }
}

vehicle_shoot_shock() {
  if(!isDefined(level.vehicle_shoot_shock[self.model])) {
    return;
  }
  if(getDvar("disable_tank_shock_minspec") == "1") {
    return;
  }
  self endon("death");

  if(!isDefined(level.vehicle_shoot_shock_overlay)) {
    level.vehicle_shoot_shock_overlay = NewHudElem();
    level.vehicle_shoot_shock_overlay.x = 0;
    level.vehicle_shoot_shock_overlay.y = 0;
    level.vehicle_shoot_shock_overlay SetShader("black", 640, 480);
    level.vehicle_shoot_shock_overlay.alignX = "left";
    level.vehicle_shoot_shock_overlay.alignY = "top";
    level.vehicle_shoot_shock_overlay.horzAlign = "fullscreen";
    level.vehicle_shoot_shock_overlay.vertAlign = "fullscreen";
    level.vehicle_shoot_shock_overlay.alpha = 0;
  }

  while(true) {
    self waittill("weapon_fired");
    if(isDefined(self.shock_distance))
      shock_distance = self.shock_distance;
    else
      shock_distance = 400;

    if(isDefined(self.black_distance))
      black_distance = self.black_distance;
    else
      black_distance = 800;

    player_distance = Distance(self.origin, level.player.origin);
    if(player_distance > black_distance) {
      continue;
    }

    level.vehicle_shoot_shock_overlay.alpha = .5;
    level.vehicle_shoot_shock_overlay FadeOverTime(0.2);
    level.vehicle_shoot_shock_overlay.alpha = 0;

    if(player_distance > shock_distance) {
      continue;
    }
    if(isDefined(level.player.flashendtime) && ((level.player.flashendtime - GetTime()) > 200)) {
      continue;
    }
    fraction = player_distance / shock_distance;
    time = 4 - (3 * fraction);
    level.player ShellShock(level.vehicle_shoot_shock[self.model], time);
  }
}

vehicle_compasshandle() {
  type = self.vehicletype;
  if(!isDefined(level.vehicle_compassicon[type]))
    return;
  if(!level.vehicle_compassicon[type])
    return;
  self enable_vehicle_compass();
}

vehicle_setteam() {
  type = self.vehicletype;
  if(!isDefined(self.script_team) && isDefined(level.vehicle_team[type]))
    self.script_team = level.vehicle_team[type];
  if(isDefined(level.vehicle_hasname[type]))
    self thread maps\_vehiclenames::get_name();

  level.vehicles[self.script_team] = array_add(level.vehicles[self.script_team], self);
}

vehicle_handleunloadevent() {
  self endon("death");
  type = self.vehicletype;
  if(!ent_flag_exist("unloaded")) {
    ent_flag_init("unloaded");
  }
}

get_vehiclenode_any_dynamic(target) {
  path_start = GetVehicleNode(target, "targetname");

  if(!isDefined(path_start)) {
    path_start = GetEnt(target, "targetname");
  } else if(ishelicopter()) {
    PrintLn("helicopter node targetname: " + path_start.targetname);
    PrintLn("vehicletype: " + self.vehicletype);
    AssertMsg("helicopter on vehicle path( see console for info )");
  }
  if(!isDefined(path_start)) {
    path_start = getstruct(target, "targetname");
  }
  return path_start;
}

vehicle_resumepathvehicle() {
  if(!self ishelicopter()) {
    self ResumeSpeed(35);
    return;
  }

  node = undefined;

  if(isDefined(self.currentnode.target))
    node = get_vehiclenode_any_dynamic(self.currentnode.target);
  if(!isDefined(node))
    return;
  vehicle_paths(node);
}

setvehgoalpos_wrap(origin, bStop) {
  if(self.health <= 0)
    return;
  if(isDefined(self.originheightoffset))
    origin += (0, 0, self.originheightoffset);
  self SetVehGoalPos(origin, bStop);
}

vehicle_liftoffvehicle(height) {
  if(!isDefined(height))
    height = 512;
  dest = self.origin + (0, 0, height);
  self SetNearGoalNotifyDist(10);
  self setvehgoalpos_wrap(dest, 1);
  self waittill("goal");
}

waittill_stable() {
  offset = 12;
  stabletime = 400;
  timer = GetTime() + stabletime;
  while(isDefined(self)) {
    if(abs(self.angles[0]) > offset)
      timer = GetTime() + stabletime;
    if(abs(self.angles[2]) > offset)
      timer = GetTime() + stabletime;
    if(GetTime() > timer) {
      break;
    }
    wait .05;
  }
}

littlebird_landing() {
  self endon("death");

  self ent_flag_init("prep_unload");
  self ent_flag_wait("prep_unload");

  self turn_unloading_drones_to_ai();

  landing_node = self get_landing_node();
  landing_node littlebird_lands_and_unloads(self);
  self vehicle_paths(landing_node);
}

get_landing_node() {
  node = self.currentnode;
  for(;;) {
    nextnode = getent_or_struct(node.target, "targetname");
    AssertEx(isDefined(nextnode), "Was looking for landing node with script_unload but ran out of nodes to look through.");
    if(isDefined(nextnode.script_unload))
      return nextnode;
    node = nextnode;
  }
}

unload_node(node) {
  if(isDefined(self.ent_flag["prep_unload"]) && self ent_flag("prep_unload")) {
    return;
  }

  if(IsSubStr(self.classname, "snowmobile")) {
    while(self.veh_speed > 15) {
      wait(0.05);
    }
  }

  if(!isDefined(node.script_flag_wait) && !isDefined(node.script_delay)) {
    self notify("newpath");
  }

  Assert(isDefined(self));

  pathnode = GetNode(node.targetname, "target");
  if(isDefined(pathnode) && self.riders.size) {
    foreach(rider in self.riders) {
      if(IsAI(rider))
        rider thread maps\_spawner::go_to_node(pathnode);
    }
  }

  if(self ishelicopter()) {
    self SetHoverParams(0, 0, 0);
    waittill_stable();
  } else {
    self Vehicle_SetSpeed(0, 35);
  }

  if(isDefined(node.script_noteworthy))
    if(node.script_noteworthy == "wait_for_flag")
      flag_wait(node.script_flag);

  self vehicle_unload(node.script_unload);

  if(maps\_vehicle_aianim::riders_unloadable(node.script_unload))
    self waittill("unloaded");

  if(isDefined(node.script_flag_wait) || isDefined(node.script_delay)) {
    return;
  }

  if(isDefined(self))
    thread vehicle_resumepathvehicle();
}

move_turrets_here(model) {
  typemodel = self.vehicletype + self.model;
  if(!isDefined(self.mgturret))
    return;
  if(self.mgturret.size == 0)
    return;
  AssertEx(isDefined(level.vehicle_mgturret[typemodel]), "no turrets specified for model");

  foreach(i, turret in self.mgturret) {
    turret Unlink();
    turret LinkTo(model, level.vehicle_mgturret[typemodel][i].tag, (0, 0, 0), (0, 0, 0));
  }
}

vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");

  self SetGoalYaw(flat_angle(self.angles)[1]);
  self SetVehGoalPos(self.origin + (0, 0, 4), 1);
}

vehicle_to_dummy() {
  AssertEx(!isDefined(self.modeldummy), "Vehicle_to_dummy was called on a vehicle that already had a dummy.");
  self.modeldummy = spawn("script_model", self.origin);
  self.modeldummy setModel(self.model);
  self.modeldummy.origin = self.origin;
  self.modeldummy.angles = self.angles;
  self.modeldummy UseAnimTree(#animtree);
  self Hide();
  self notify("animtimer");

  self thread model_dummy_death();
  move_riders_here(self.modelDummy);
  move_turrets_here(self.modeldummy);
  move_ghettotags_here(self.modeldummy);

  move_effects_ent_here(self.modeldummy);
  copy_destructable_attachments(self.modeldummy);

  self.modeldummyon = true;

  if(self hasHelicopterDustKickup()) {
    self notify("stop_kicking_up_dust");
    self thread aircraft_dust_kickup(self.modeldummy);
  }

  return self.modeldummy;
}

move_effects_ent_here(model) {
  ent = deathfx_ent();
  ent Unlink();
  ent LinkTo(model);
}

model_dummy_death() {
  modeldummy = self.modeldummy;
  modeldummy endon("death");
  while(isDefined(self)) {
    self waittill("death");
    waittillframeend;
  }
  modeldummy Delete();
}

move_ghettotags_here(model) {
  if(!isDefined(self.ghettotags))
    return;
  foreach(ghettotag in self.ghettotags) {
    ghettotag Unlink();
    ghettotag LinkTo(model);
  }
}

dummy_to_vehicle() {
  AssertEx(isDefined(self.modeldummy), "Tried to turn a vehicle from a dummy into a vehicle. Can only be called on vehicles that have been turned into dummies with vehicle_to_dummy.");

  if(self isHelicopter())
    self.modeldummy.origin = self GetTagOrigin("tag_ground");
  else {
    self.modeldummy.origin = self.origin;
    self.modeldummy.angles = self.angles;
  }

  self Show();

  move_riders_here(self);
  move_turrets_here(self);

  move_effects_ent_here(self);

  self.modeldummyon = false;
  self.modeldummy Delete();
  self.modeldummy = undefined;

  if(self hasHelicopterDustKickup()) {
    self notify("stop_kicking_up_dust");
    self thread aircraft_dust_kickup();
  }

  return self.modeldummy;
}

move_riders_here(base) {
  if(!isDefined(self.riders))
    return;
  riders = self.riders;

  foreach(guy in riders) {
    if(!isDefined(guy))
      continue;
    guy Unlink();
    animpos = maps\_vehicle_aianim::anim_pos(self, guy.vehicle_position);
    guy LinkTo(base, animpos.sittag, (0, 0, 0), (0, 0, 0));
    if(IsAI(guy))
      guy Teleport(base GetTagOrigin(animpos.sittag));
    else
      guy.origin = base GetTagOrigin(animpos.sittag);
  }
}

spawn_vehicles_from_targetname_newstyle(name) {
  vehicles = [];
  test = getEntArray(name, "targetname");
  test_return = [];

  foreach(v in test) {
    if(!isDefined(v.code_classname) || v.code_classname != "script_vehicle")
      continue;
    if(isSpawner(v))
      vehicles[vehicles.size] = vehicle_spawn(v);
  }
  return vehicles;
}

spawn_vehicles_from_targetname(name) {
  vehicles = [];
  vehicles = spawn_vehicles_from_targetname_newstyle(name);
  AssertEx(vehicles.size, "No vehicle spawners had targetname " + name);
  return vehicles;
}

spawn_vehicle_from_targetname(name) {
  vehicleArray = spawn_vehicles_from_targetname(name);
  AssertEx(vehicleArray.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehicleArray.size + " vehicles, instead of 1");
  return vehicleArray[0];
}

spawn_vehicle_from_targetname_and_drive(name) {
  vehicleArray = spawn_vehicles_from_targetname(name);
  AssertEx(vehicleArray.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehicleArray.size + " vehicles, instead of 1");
  thread gopath(vehicleArray[0]);
  return vehicleArray[0];
}

spawn_vehicles_from_targetname_and_drive(name) {
  vehicleArray = spawn_vehicles_from_targetname(name);
  for(i = 0; i < vehicleArray.size; i++)
    foreach(vehicle in vehicleArray)
  thread gopath(vehicle);
  return vehicleArray;
}

aircraft_dust_kickup(model) {
  self endon("death_finished");
  self endon("stop_kicking_up_dust");

  assert(isDefined(self.vehicletype));

  maxHeight = 1200;
  if(isDefined(level.treadfx_maxheight))
    maxHeight = level.treadfx_maxheight;

  minHeight = 350;

  slowestRepeatWait = 0.15;
  fastestRepeatWait = 0.05;

  numFramesPerTrace = 3;
  doTraceThisFrame = numFramesPerTrace;

  defaultRepeatRate = 1.0;
  if(self isAirplane())
    defaultRepeatRate = 0.15;

  repeatRate = defaultRepeatRate;

  trace = undefined;
  d = undefined;

  trace_ent = self;
  if(isDefined(model))
    trace_ent = model;

  while(isDefined(self)) {
    if(isDefined(level.skip_treadfx))
      return true;

    if(repeatRate <= 0)
      repeatRate = defaultRepeatRate;
    wait repeatRate;

    if(!isDefined(self)) {
      return;
    }
    doTraceThisFrame--;

    if(doTraceThisFrame <= 0) {
      doTraceThisFrame = numFramesPerTrace;

      trace = bulletTrace(trace_ent.origin, trace_ent.origin - (0, 0, 100000), false, trace_ent);

      d = Distance(trace_ent.origin, trace["position"]);

      repeatRate = ((d - minHeight) / (maxHeight - minHeight)) * (slowestRepeatWait - fastestRepeatWait) + fastestRepeatWait;
    }

    if(!isDefined(trace)) {
      continue;
    }
    Assert(isDefined(d));

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

    AssertEx(isDefined(level._vehicle_effect[self.vehicletype]), self.vehicletype + " vehicle script hasn't run _tradfx properly");
    AssertEx(isDefined(level._vehicle_effect[self.vehicletype][trace["surfacetype"]]), "UNKNOWN SURFACE TYPE: " + trace["surfacetype"]);

    if(level._vehicle_effect[self.vehicletype][trace["surfacetype"]] != -1) {
      playFX(level._vehicle_effect[self.vehicletype][trace["surfacetype"]], trace["position"]);
    } else {}
  }
}

tank_crush(crushedVehicle, endNode, tankAnim, truckAnim, animTree, soundAlias) {
  Assert(isDefined(crushedVehicle));
  Assert(isDefined(endNode));
  Assert(isDefined(tankAnim));
  Assert(isDefined(truckAnim));
  Assert(isDefined(animTree));

  self Vehicle_SetSpeed(7, 5, 5);

  move_to_time = (animLength / 3);
  move_from_time = (animLength / 3);

  node_origin = crushedVehicle.origin;
  node_angles = crushedVehicle.angles;
  node_forward = anglesToForward(node_angles);
  node_up = AnglesToUp(node_angles);
  node_right = AnglesToRight(node_angles);

  anim_start_org = GetStartOrigin(node_origin, node_angles, tankAnim);
  anim_start_ang = GetStartAngles(node_origin, node_angles, tankAnim);

  animStartingVec_Forward = anglesToForward(anim_start_ang);
  animStartingVec_Up = AnglesToUp(anim_start_ang);
  animStartingVec_Right = AnglesToRight(anim_start_ang);

  tank_Forward = anglesToForward(animatedTank.angles);
  tank_Up = AnglesToUp(animatedTank.angles);
  tank_Right = AnglesToRight(animatedTank.angles);

  offset_Vec = (node_origin - anim_start_org);
  offset_Forward = VectorDot(offset_Vec, animStartingVec_Forward);
  offset_Up = VectorDot(offset_Vec, animStartingVec_Up);
  offset_Right = VectorDot(offset_Vec, animStartingVec_Right);
  dummy = spawn("script_origin", animatedTank.origin);
  dummy.origin += vector_multiply(tank_Forward, offset_Forward);
  dummy.origin += vector_multiply(tank_Up, offset_Up);
  dummy.origin += vector_multiply(tank_Right, offset_Right);

  offset_Vec = anglesToForward(node_angles);
  offset_Forward = VectorDot(offset_Vec, animStartingVec_Forward);
  offset_Up = VectorDot(offset_Vec, animStartingVec_Up);
  offset_Right = VectorDot(offset_Vec, animStartingVec_Right);
  dummyVec = vector_multiply(tank_Forward, offset_Forward);
  dummyVec += vector_multiply(tank_Up, offset_Up);
  dummyVec += vector_multiply(tank_Right, offset_Right);
  dummy.angles = VectorToAngles(dummyVec);

  thread draw_line_from_ent_for_time(level.player, animatedTank.origin, 1, 0, 0, animLength / 2);

  thread draw_line_from_ent_for_time(level.player, anim_start_org, 0, 1, 0, animLength / 2);

  thread draw_line_from_ent_to_ent_for_time(level.player, dummy, 0, 0, 1, animLength / 2);
}
level thread play_sound_in_space(soundAlias, node_origin);

animatedTank LinkTo(dummy);
crushedVehicle UseAnimTree(animTree);
animatedTank UseAnimTree(animTree);

Assert(isDefined(level._vehicle_effect["tankcrush"]["window_med"]));
Assert(isDefined(level._vehicle_effect["tankcrush"]["window_large"]));

crushedVehicle thread tank_crush_fx_on_tag("tag_window_left_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.2);
crushedVehicle thread tank_crush_fx_on_tag("tag_window_right_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.4);
crushedVehicle thread tank_crush_fx_on_tag("tag_windshield_back_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 0.7);
crushedVehicle thread tank_crush_fx_on_tag("tag_windshield_front_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 1.5);

crushedVehicle AnimScripted("tank_crush_anim", node_origin, node_angles, truckAnim);
animatedTank AnimScripted("tank_crush_anim", dummy.origin, dummy.angles, tankAnim);

dummy MoveTo(node_origin, move_to_time, (move_to_time / 2), (move_to_time / 2));
dummy RotateTo(node_angles, move_to_time, (move_to_time / 2), (move_to_time / 2));
wait move_to_time;

animLength -= move_to_time;
animLength -= move_from_time;
temp = spawn("script_model", (anim_start_org));
temp.angles = anim_start_ang;
anim_end_org = temp LocalToWorldCoords(GetMoveDelta(tankAnim, 0, 1));
anim_end_ang = anim_start_ang + (0, GetAngleDelta(tankAnim, 0, 1), 0);
temp Delete();
animEndingVec_Forward = anglesToForward(anim_end_ang);
animEndingVec_Up = AnglesToUp(anim_end_ang);
animEndingVec_Right = AnglesToRight(anim_end_ang);
attachPos = self GetAttachPos(endNode);
tank_Forward = anglesToForward(attachPos[1]);
tank_Up = AnglesToUp(attachPos[1]);
tank_Right = AnglesToRight(attachPos[1]);
offset_Vec = (node_origin - anim_end_org);
offset_Forward = VectorDot(offset_Vec, animEndingVec_Forward);
offset_Up = VectorDot(offset_Vec, animEndingVec_Up);
offset_Right = VectorDot(offset_Vec, animEndingVec_Right);
dummy.final_origin = attachPos[0];
dummy.final_origin += vector_multiply(tank_Forward, offset_Forward);
dummy.final_origin += vector_multiply(tank_Up, offset_Up);
dummy.final_origin += vector_multiply(tank_Right, offset_Right);
offset_Vec = anglesToForward(node_angles);
offset_Forward = VectorDot(offset_Vec, animEndingVec_Forward);
offset_Up = VectorDot(offset_Vec, animEndingVec_Up);
offset_Right = VectorDot(offset_Vec, animEndingVec_Right);
dummyVec = vector_multiply(tank_Forward, offset_Forward);
dummyVec += vector_multiply(tank_Up, offset_Up);
dummyVec += vector_multiply(tank_Right, offset_Right);
dummy.final_angles = VectorToAngles(dummyVec);
thread draw_line_from_ent_for_time(level.player, self.origin, 1, 0, 0, animLength / 2);
thread draw_line_from_ent_for_time(level.player, anim_end_org, 0, 1, 0, animLength / 2);
thread draw_line_from_ent_to_ent_for_time(level.player, dummy, 0, 0, 1, animLength / 2);
}
dummy RotateTo(dummy.final_angles, move_from_time, (move_from_time / 2), (move_from_time / 2));
wait move_from_time;
self AttachPath(endNode);
dummy_to_vehicle();
}

tank_crush_fx_on_tag(tagName, fxName, soundAlias, startDelay) {
  if(isDefined(startDelay))
    wait startDelay;
  playFXOnTag(fxName, self, tagName);
  if(isDefined(soundAlias))
    self thread play_sound_on_tag(soundAlias, tagName);
}

loadplayer(position, animfudgetime) {
  SetDvarIfUninitialized("fastrope_arms", "0");

  if(!isDefined(animfudgetime))
    animfudgetime = 0;
  Assert(isDefined(self.riders));
  Assert(self.riders.size);
  guy = undefined;
  foreach(rider in self.riders) {
    if(rider.vehicle_position == position) {
      guy = rider;
      guy.drone_delete_on_unload = true;
      guy.playerpiggyback = true;
      break;
    }
  }

  AssertEx(!isai(guy), "guy in position of player needs to have script_drone set, use script_startingposition ans script drone in your map");
  Assert(isDefined(guy));
  thread show_rigs(position);
  animpos = maps\_vehicle_aianim::anim_pos(self, position);

  guy notify("newanim");
  guy DetachAll();

  guy setModel("fastrope_arms");
  guy UseAnimTree(animpos.player_animtree);
  thread maps\_vehicle_aianim::guy_idle(guy, position);

  level.player PlayerLinkToDelta(guy, "tag_player", 1.0, 40, 18, 30, 30);

  guy Hide();

  animtime = GetAnimLength(animpos.getout);
  animtime -= animfudgetime;
  self waittill("unloading");

  if(getDvar("fastrope_arms") != "0")
    guy Show();

  level.player DisableWeapons();

  guy NotSolid();

  wait animtime;

  level.player Unlink();
  level.player EnableWeapons();
}

show_rigs(position) {
  wait .01;
  self thread maps\_vehicle_aianim::getout_rigspawn(self, position);
  if(!self.riders.size)
    return;
  foreach(rider in self.riders)
  self thread maps\_vehicle_aianim::getout_rigspawn(self, rider.vehicle_position);
}

turret_deleteme(turret) {
  if(isDefined(self))
    if(isDefined(turret.deletedelay))
      wait turret.deletedelay;
  if(isDefined(turret))
    turret Delete();
}

vehicle_wheels_forward() {
  wheeldirectionchange(1);
}

vehicle_wheels_backward() {
  wheeldirectionchange(0);
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
  while(true) {
    self waittill("weapon_fired");
    playFXOnTag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
    barrel_origin = self GetTagOrigin("tag_flash");
    ground = PhysicsTrace(barrel_origin, barrel_origin + (0, 0, -128));
    PhysicsExplosionSphere(ground, 192, 100, 1);
  }
}

playTankExhaust() {
  self endon("death");
  if(!isDefined(level.vehicle_exhaust[self.model])) {
    return;
  }
  exhaustDelay = 0.1;
  while(isDefined(self)) {
    if(!isDefined(self))
      return;
    if(!isalive(self))
      return;
    playFXOnTag(level.vehicle_exhaust[self.model], self, "tag_engine_exhaust");
    wait exhaustDelay;
  }
}

build_light(model, name, tag, effect, group, delay) {
  if(!isDefined(level.vehicle_lights))
    level.vehicle_lights = [];
  if(!isDefined(level.vehicle_lights_group_override))
    level.vehicle_lights_group_override = [];
  if(isDefined(level.vehicle_lights_group_override[group]) && !level.vtoverride) {
    return;
  }
  struct = spawnStruct();
  struct.name = name;
  struct.tag = tag;
  struct.delay = delay;
  struct.effect = _loadfx(effect);

  level.vehicle_lights[model][name] = struct;

  group_light(model, name, "all");
  if(isDefined(group))
    group_light(model, name, group);
}

build_light_override(type, model, name, tag, effect, group, delay) {
  level.vttype = type;
  level.vtmodel = type;
  level.vtoverride = true;
  build_light(model, name, tag, effect, group, delay);
  level.vtoverride = false;
  level.vehicle_lights_group_override[group] = true;
}

group_light(model, name, group) {
  if(!isDefined(level.vehicle_lights_group))
    level.vehicle_lights_group = [];
  if(!isDefined(level.vehicle_lights_group[model]))
    level.vehicle_lights_group[model] = [];
  if(!isDefined(level.vehicle_lights_group[model][group]))
    level.vehicle_lights_group[model][group] = [];
  foreach(lightgroup_name in level.vehicle_lights_group[model][group])
  if(name == lightgroup_name)
    return;
  level.vehicle_lights_group[model][group][level.vehicle_lights_group[model][group].size] = name;
}

lights_on(group) {
  groups = StrTok(group, " ");
  array_levelthread(groups, ::lights_on_internal);
}

lights_delayfxforframe() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");

  if(!isDefined(level.fxdelay))
    level.fxdelay = 0;

  level.fxdelay += RandomFloatRange(0.2, 0.4);

  if(level.fxdelay > 2)
    level.fxdelay = 0;

  wait 0.05;

  level.fxdelay = undefined;
}

lights_on_internal(group) {
  level.lastlighttime = GetTime();
  if(!isDefined(group))
    group = "all";

  if(!isDefined(level.vehicle_lights_group[self.model]) || !isDefined(level.vehicle_lights_group[self.model][group]))
    return;
  thread lights_delayfxforframe();
  if(!isDefined(self.lights))
    self.lights = [];
  lights = level.vehicle_lights_group[self.model][group];

  count = 0;

  delayoffsetter = [];
  for(i = 0; i < lights.size; i++) {
    if(isDefined(self.lights[lights[i]])) {
      continue;
    }
    template = level.vehicle_lights[self.model][lights[i]];

    if(isDefined(template.delay))
      delay = template.delay;
    else
      delay = 0;

    while(isDefined(delayoffsetter["" + delay]))
      delay += .05;

    delay += level.fxdelay;

    delayoffsetter["" + delay] = true;

    self endon("death");
    childthread noself_delayCall(delay, ::playfxontag, template.effect, self, template.tag);

    self.lights[lights[i]] = true;
    if(!isDefined(self)) {
      break;
    }
  }
  level.fxdelay = false;
}

deathfx_ent() {
  if(!isDefined(self.deathfx_ent)) {
    ent = spawn("script_model", (0, 0, 0));
    emodel = get_dummy();
    ent setModel(self.model);
    ent.origin = emodel.origin;
    ent.angles = emodel.angles;
    ent NotSolid();
    ent Hide();
    ent LinkTo(emodel);
    self.deathfx_ent = ent;
  } else
    self.deathfx_ent setModel(self.model);
  return self.deathfx_ent;
}

lights_off(group, model) {
  groups = StrTok(group, " ", model);
  array_levelthread(groups, ::lights_off_internal, model);
}

lights_off_internal(group, model) {
  if(!isDefined(model))
    model = self.model;
  if(!isDefined(group))
    group = "all";
  if(!isDefined(self.lights))
    return;
  if(!isDefined(level.vehicle_lights_group[model][group])) {
    PrintLn("vehicletype: " + self.vehicletype);
    PrintLn("light group: " + group);
    AssertMsg("lights not defined for this vehicle( see console");
  }
  lights = level.vehicle_lights_group[model][group];

  count = 0;
  for(i = 0; i < lights.size; i++) {
    template = level.vehicle_lights[model][lights[i]];
    stopFXOnTag(template.effect, self, template.tag);

    count++;
    if(count > 2) {
      count = 0;
      wait .05;
    }

    if(!isDefined(self)) {
      return;
    }
    self.lights[lights[i]] = undefined;
  }
}

build_deathmodel(model, deathmodel, swapDelay) {
  if(model != level.vtmodel)
    return;
  if(!isDefined(deathmodel))
    deathmodel = model;
  PreCacheModel(model);
  PreCacheModel(deathmodel);
  level.vehicle_deathmodel[model] = deathmodel;
  if(!isDefined(swapDelay))
    swapDelay = 0;
  level.vehicle_deathmodel_delay[model] = swapDelay;
}

build_shoot_shock(shock) {
  PreCacheShader("black");
  PreCacheShellShock(shock);
  level.vehicle_shoot_shock[level.vtmodel] = shock;
}

build_idle(animation) {
  if(!isDefined(level.vehicle_IdleAnim))
    level.vehicle_IdleAnim = [];
  if(!isDefined(level.vehicle_IdleAnim[level.vtmodel]))
    level.vehicle_IdleAnim[level.vtmodel] = [];
  level.vehicle_IdleAnim[level.vtmodel][level.vehicle_IdleAnim[level.vtmodel].size] = animation;
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
  typemodel = type + model;
  PrecacheVehicle(type);

  if(!isDefined(level.vehicle_death_fx))
    level.vehicle_death_fx = [];
  if(!isDefined(level.vehicle_death_fx[typemodel]))
    level.vehicle_death_fx[typemodel] = [];

  level.vehicle_compassicon[type] = false;
  level.vehicle_team[type] = "axis";
  level.vehicle_life[type] = 999;
  level.vehicle_hasMainTurret[model] = false;
  level.vehicle_mainTurrets[model] = [];
  level.vtmodel = model;
  level.vttype = type;
}

build_exhaust(effect) {
  level.vehicle_exhaust[level.vtmodel] = _loadfx(effect);
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
  Assert(isDefined(bShield));
  level.vehicle_bulletshield[level.vttype] = bShield;
}

build_grenadeshield(bShield) {
  Assert(isDefined(bShield));
  level.vehicle_grenadeshield[level.vttype] = bShield;
}

build_aianims(aithread, vehiclethread) {
  level.vehicle_aianims[level.vttype] = [[aithread]]();
  if(isDefined(vehiclethread))
    level.vehicle_aianims[level.vttype] = [[vehiclethread]](level.vehicle_aianims[level.vttype]);
}

build_frontarmor(armor) {
  level.vehicle_frontarmor[level.vttype] = armor;
}

build_hidden_riders_until_unload() {
  level.hidden_riders_until_unload[level.vttype] = true;
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

build_compassicon(compasstype, enabled) {
  Assert(isDefined(compasstype));

  if(!isDefined(enabled))
    enabled = false;

  level.vehicle_compassicon[level.vttype] = enabled;
  level.vehicle_compass_types[level.vttype] = compassType;
}

build_deckdust(effect) {
  level.vehicle_deckdust[level.vtmodel] = _loadfx(effect);
}

build_destructible(model, destructible) {
  if(isDefined(level.vehicle_csv_export)) {
    return;
  }
  Assert(isDefined(model));
  Assert(isDefined(destructible));
  if(model != level.vtmodel)
    return;
  struct = spawnStruct();
  passer = spawnStruct();
  passer.model = model;

  struct.destuctableInfo = passer common_scripts\_destructible_types::makeType(destructible);;
  struct thread common_scripts\_destructible::precache_destructibles();
  struct thread common_scripts\_destructible::add_destructible_fx();

  level.destructible_model[level.vtmodel] = destructible;
}

build_localinit(init_thread) {
  level.vehicleInitThread[level.vttype][level.vtmodel] = init_thread;
}

get_from_spawnStruct(target) {
  return getstruct(target, "targetname");
}

get_from_entity(target) {
  ent = getEntArray(target, "targetname");
  if(isDefined(ent) && ent.size > 0)
    return ent[RandomInt(ent.size)];
  return undefined;
}

get_from_spawnstruct_target(target) {
  return getstruct(target, "target");
}

get_from_entity_target(target) {
  return GetEnt(target, "target");
}

get_from_vehicle_node(target) {
  return GetVehicleNode(target, "targetname");
}

set_lookat_from_dest(dest) {
  viewTarget = GetEnt(dest.script_linkto, "script_linkname");

  if(!isDefined(viewTarget) || level.script == "hunted") {
    return;
  }
  self SetLookAtEnt(viewTarget);
  self.set_lookat_point = true;
}

get_deletegroups(script_vehiclegroupdelete) {
  deletegroups = [];
  vehicles = getEntArray("script_vehicle", "code_classname");
  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle.script_vehicleGroupDelete) || vehicle.script_vehicleGroupDelete != script_vehiclegroupdelete)
      continue;
    deletegroups[deletegroups.size] = vehicle;
  }
  return deletegroups;
}

damage_hint_bullet_only() {
  level.armorDamageHints = false;
  self.displayingDamageHints = false;
  self thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(!isPlayer(attacker))
      continue;
    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }
    type = ToLower(type);

    switch (type) {
      case "mod_pistol_bullet":
      case "mod_rifle_bullet":
      case "bullet":
        if(!level.armorDamageHints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armorDamageHints = true;
          self.displayingDamageHints = true;
          attacker display_hint("invulerable_bullets");
          wait(4);
          level.armorDamageHints = false;
          self.displayingDamageHints = false;
          break;
        }
    }
  }
}

damage_hints() {
  level.armorDamageHints = false;
  self.displayingDamageHints = false;
  self thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(!isPlayer(attacker))
      continue;
    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }
    type = ToLower(type);

    switch (type) {
      case "mod_grenade":
      case "mod_grenade_splash":
      case "mod_pistol_bullet":
      case "mod_rifle_bullet":
      case "bullet":
        if(!level.armorDamageHints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armorDamageHints = true;
          self.displayingDamageHints = true;
          if((type == "mod_grenade") || (type == "mod_grenade_splash"))
            attacker display_hint("invulerable_frags");
          else
            attacker display_hint("invulerable_bullets");
          wait(4);
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
  attachedModelCount = self GetAttachSize();
  attachedModels = [];
  for(i = 0; i < attachedModelCount; i++)
    attachedModels[i] = ToLower(self GetAttachModelName(i));

  for(i = 0; i < attachedModels.size; i++)
    modeldummy Attach(attachedModels[i], ToLower(self GetAttachTagName(i)));
}

get_dummy() {
  if(self.modeldummyon)
    eModel = self.modeldummy;
  else
    eModel = self;
  return eModel;
}

apply_truckjunk(eVehicle, truckjunk) {
  if(!isDefined(self.truckjunk)) {
    return;
  }
  junkarray = self.truckjunk;
  self.truckjunk = [];
  foreach(truckjunk in junkarray) {
    model = spawn("script_model", self.origin);
    model setModel(truckjunk.model);
    model LinkTo(self, "tag_body", truckjunk.origin, truckjunk.angles);
    self.truckjunk[self.truckjunk.size] = truckjunk;
  }
}

truckjunk() {
  Assert(isDefined(self.target));
  spawner = GetEnt(self.target, "targetname");
  Assert(isDefined(spawner));
  Assert(isSpawner(spawner));

  ghettotag = ghetto_tag_create(spawner);

  if(isDefined(self.script_noteworthy))
    ghettotag.script_noteworthy = self.script_noteworthy;
  if(!isDefined(spawner.truckjunk))
    spawner.truckjunk = [];
  if(isDefined(self.script_startingposition))
    ghettotag.script_startingposition = self.script_startingposition;
  spawner.truckjunk[spawner.truckjunk.size] = ghettotag;

  self Delete();
}

ghetto_tag_create(target) {
  struct = spawnStruct();
  struct.origin = self.origin - target GetTagOrigin("tag_body");
  struct.angles = self.angles - target GetTagAngles("tag_body");
  struct.model = self.model;
  if(isDefined(struct.targetname))
    level.struct_class_names["targetname"][struct.targetname] = undefined;
  if(isDefined(struct.target))
    level.struct_class_names["target"][struct.target] = undefined;
  return struct;
}

twobuttonspressed(button1, button2) {
  return level.player buttonPressed(button1) && level.player buttonPressed(button2);
}

vehicle_load_ai(ai, goddriver, group) {
  maps\_vehicle_aianim::load_ai(ai, undefined, group);
}

vehicle_load_ai_single(guy, goddriver, group) {
  ai = [];
  ai[0] = guy;
  maps\_vehicle_aianim::load_ai(ai, goddriver, group);
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

  struct = spawnStruct();
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
  struct = spawnStruct();
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
  self JoltBody((self.origin + (23, 33, 64)), 3);
  wait 2;
  if(!isDefined(self))
    return;
  self.dontfreeme = undefined;
}

heli_squashes_stuff(ender) {
  self endon("death");
  level endon(ender);
  for(;;) {
    self waittill("trigger", other);
    if(IsAlive(other)) {
      if(other.team == "allies" && !isPlayer(other))
        continue;
      other Kill((0, 0, 0));
    }
  }
}

_getvehiclespawnerarray_by_spawngroup(spawngroup) {
  spawners = _getvehiclespawnerarray();
  array = [];
  foreach(spawner in spawners)
  if(isDefined(spawner.script_VehicleSpawngroup) && spawner.script_VehicleSpawngroup == spawngroup)
    array[array.size] = spawner;

  return array;
}

_getvehiclespawnerarray(targetname) {
  vehicles = getEntArray("script_vehicle", "code_classname");
  if(isDefined(targetname)) {
    newArray = [];
    foreach(vehicle in vehicles) {
      if(!isDefined(vehicle.targetname))
        continue;
      if(vehicle.targetname == targetname)
        newArray = array_add(newArray, vehicle);
    }
    vehicles = newArray;
  }

  array = [];
  foreach(vehicle in vehicles) {
    if(isSpawner(vehicle))
      array[array.size] = vehicle;
  }
  return array;
}

get_compassTypeForVehicleType(type) {
  if(!isDefined(level.vehicle_compass_types[type])) {
    PrintLn("Compass - type doesn't exist for type '" + type + "'.");
    PrintLn("Set it in vehicle script:_" + type + ".gsc with build_compassicon.");
    AssertMsg("Compass - type for model doesn't exits, see console for info");
  }
  return level.vehicle_compass_types[type];
}

setup_gags() {
  if(!isDefined(self.script_parameters))
    return;
  if(self.script_parameters == "gag_ride_in")
    setup_gag_ride();
}

setup_gag_ride() {
  Assert(isDefined(self.targetname));
  linked = getEntArray(self.targetname, "target");
  self.script_vehicleride = auto_assign_ride_group();
  foreach(ent in linked) {
    ent.qSetGoalPos = false;
    level.vehicle_RideSpawners = array_2dadd(level.vehicle_RideSpawners, self.script_vehicleride, ent);
  }

  level.gag_heliride_spawner = self;
}

auto_assign_ride_group() {
  if(!isDefined(level.vehicle_group_autoasign))
    level.vehicle_group_autoasign = 1000;
  else
    level.vehicle_group_autoasign++;
  return level.vehicle_group_autoasign;
}

vehicle_script_forcecolor_riders(script_forcecolor) {
  foreach(rider in self.riders) {
    if(IsAI(rider))
      rider set_force_color(script_forcecolor);
    else if(isDefined(rider.spawner))
      rider.spawner.script_forcecolor = script_forcecolor;
    else
      AssertMsg("rider who's not an ai without a spawner..");
  }
}

vehicle_spawn_group_limit_riders(group, ridermax) {
  spawners = sort_by_startingpos(level.vehicle_RideSpawners[group]);
  array = [];
  for(i = 0; i < ridermax; i++)
    array[array.size] = spawners[i];
  level.vehicle_RideSpawners[group] = array;
}

enable_vehicle_compass() {}

update_steering(snowmobile) {
  if(snowmobile.update_time != GetTime()) {
    snowmobile.update_time = GetTime();
    if(snowmobile.steering_enable) {
      steering_goal = clamp(0 - snowmobile.angles[2], 0 - snowmobile.steering_maxroll, snowmobile.steering_maxroll) / snowmobile.steering_maxroll;
      delta = steering_goal - snowmobile.steering;
      if(delta != 0) {
        factor = snowmobile.steering_maxdelta / abs(delta);
        if(factor < 1)
          delta *= factor;
        snowmobile.steering += delta;
      }
    } else {
      snowmobile.steering = 0;
    }
  }
  return snowmobile.steering;
}

mount_snowmobile(vehicle, sit_position) {
  self endon("death");
  self endon("long_death");

  if(doinglongdeath()) {
    return;
  }
  rider_types = [];
  rider_types[0] = "snowmobile_driver";
  rider_types[1] = "snowmobile_passenger";

  tags = [];
  tags["snowmobile_driver"] = "tag_driver";
  tags["snowmobile_passenger"] = "tag_passenger";

  rider_type = rider_types[sit_position];
  AssertEx(isDefined(rider_type), "Tried to make a guy mount a snowmobile but it already had 2 riders!");
  tag = tags[rider_type];

  tag_origin = vehicle GetTagOrigin(tag);
  tag_angles = vehicle GetTagAngles(tag);

  closest_scene_name = undefined;
  closest_org = undefined;
  closest_dist = 9999999;
  foreach(scene_name, _ in level.snowmobile_mount_anims[rider_type]) {
    animation = getanim_generic(scene_name);
    org = GetStartOrigin(tag_origin, tag_angles, animation);

    new_dist = Distance(self.origin, org);
    if(new_dist < closest_dist) {
      closest_dist = new_dist;
      closest_org = org;
      closest_scene_name = scene_name;
    }
  }

  AssertEx(isDefined(closest_scene_name), "Somehow an AI could not find an animation to mount a snowmobile");

  closest_org = drop_to_ground(closest_org);
  self.goalradius = 8;
  self.disablearrivals = true;
  self SetGoalPos(closest_org);
  self waittill("goal");

  vehicle anim_generic(self, closest_scene_name, tag);
  vehicle thread maps\_vehicle_aianim::guy_enter(self);
  self.disablearrivals = false;
}

get_my_spline_node(org) {
  org = (org[0], org[1], 0);
  all_nodes = get_array_of_closest(org, level.snowmobile_path);
  close_nodes = [];
  for(i = 0; i < 3; i++) {
    close_nodes[i] = all_nodes[i];
  }

  for(i = 0; i < level.snowmobile_path.size; i++) {
    foreach(node in close_nodes) {
      if(node == level.snowmobile_path[i]) {
        return node;
      }
    }
  }
  AssertEx(0, "Found no node to be on!");
}

spawn_vehicle_and_attach_to_spline_path(default_speed) {
  if(level.enemy_snowmobiles.size >= 8) {
    return;
  }
  vehicle = self spawn_vehicle();
  if(isDefined(default_speed))
    vehicle VehPhys_SetSpeed(default_speed);

  vehicle thread vehicle_becomes_crashable();

  vehicle endon("death");
  vehicle.dontUnloadOnEnd = true;
  vehicle gopath(vehicle);
  vehicle leave_path_for_spline_path();
}

leave_path_for_spline_path() {
  self endon("script_crash_vehicle");
  self waittill_either("enable_spline_path", "reached_end_node");

  node = self get_my_spline_node(self.origin);

  node thread[[level.drive_spline_path_fun]](self);
}

kill_vehicle_spawner(trigger) {
  trigger waittill("trigger");
  foreach(spawner in level.vehicle_killspawn_groups[trigger.script_kill_vehicle_spawner]) {
    spawner Delete();
  }

  level.vehicle_killspawn_groups[trigger.script_kill_vehicle_spawner] = [];
}

spawn_vehicle_and_gopath() {
  vehicle = self spawn_vehicle();
  if(isDefined(self.script_speed)) {
    if(!isHelicopter())
      vehicle VehPhys_SetSpeed(self.script_speed);
  }
  vehicle thread maps\_vehicle::gopath(vehicle);
  return vehicle;
}

attach_vehicle_triggers() {
  triggers = getEntArray("vehicle_touch_trigger", "targetname");
  other_triggers = getEntArray("vehicle_use_trigger", "targetname");
  triggers = array_combine(triggers, other_triggers);

  origin = undefined;

  foreach(trigger in triggers) {
    if(trigger.script_noteworthy == self.model) {
      origin = trigger.origin;
      break;
    }
  }

  vehicle_triggers = [];

  foreach(trigger in triggers) {
    if(trigger.script_noteworthy != self.model) {
      continue;
    }
    if(trigger.origin != origin) {
      continue;
    }
    vehicle_triggers[vehicle_triggers.size] = trigger;
  }

  self.vehicle_triggers = [];

  foreach(trigger in vehicle_triggers) {
    trigger.targetname = undefined;
    trigger thread manual_tag_linkto(self, "tag_origin");
    if(!isDefined(self.vehicle_triggers[trigger.code_classname]))
      self.vehicle_triggers[trigger.code_classname] = [];

    self.vehicle_triggers[trigger.code_classname][self.vehicle_triggers[trigger.code_classname].size] = trigger;
  }
}

humvee_antenna_animates(anims) {
  self UseAnimTree(#animtree);
  humvee_antenna_animates_until_death(anims);
  if(!isDefined(self)) {
    return;
  }
  self clearanim(anims["idle"], 0);
  self clearanim(anims["rot_l"], 0);
  self clearanim(anims["rot_r"], 0);
}

humvee_antenna_animates_until_death(anims) {
  self endon("death");

  for(;;) {
    weight = self.veh_speed / 18;
    if(weight <= 0.0001)
      weight = 0.0001;

    rate = randomfloatrange(0.3, 0.7);
    self setanim(anims["idle"], weight, 0, rate);

    rate = randomfloatrange(0.1, 0.8);
    self setanim(anims["rot_l"], 1, 0, rate);

    rate = randomfloatrange(0.1, 0.8);
    self setanim(anims["rot_r"], 1, 0, rate);

    wait(0.5);
  }
}

manual_tag_linkto(entity, tag) {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }
    if(!isDefined(entity)) {
      break;
    }

    org = entity GetTagOrigin(tag);
    ang = entity GetTagAngles(tag);
    self.origin = org;
    self.angles = ang;
    wait(0.05);
  }
}

littlebird_lands_and_unloads(vehicle) {
  vehicle SetDeceleration(6);
  vehicle SetAcceleration(4);
  AssertEx(isDefined(self.angles), "Landing nodes must have angles set.");
  vehicle SetTargetYaw(self.angles[1]);

  vehicle Vehicle_SetSpeed(20, 7, 7);

  while(Distance(flat_origin(vehicle.origin), flat_origin(self.origin)) > 512)
    wait .05;

  vehicle endon("death");

  badplace_name = "landing" + RandomInt(99999);
  BadPlace_Cylinder(badplace_name, 30, self.origin, 200, CONST_bp_height, "axis", "allies", "neutral", "team3");

  vehicle thread vehicle_land_beneath_node(424, self);

  vehicle waittill("near_goal");

  BadPlace_Delete(badplace_name);
  BadPlace_Cylinder(badplace_name, 30, self.origin, 200, CONST_bp_height, "axis", "allies", "neutral", "team3");

  vehicle notify("groupedanimevent", "pre_unload");
  vehicle thread vehicle_ai_event("pre_unload");

  vehicle Vehicle_SetSpeed(20, 22, 7);
  vehicle notify("nearing_landing");

  if(isDefined(vehicle.custom_landing)) {
    switch (vehicle.custom_landing) {
      case "hover_then_land":
        vehicle Vehicle_SetSpeed(10, 22, 7);
        vehicle thread vehicle_land_beneath_node(32, self, 64);
        vehicle waittill("near_goal");
        vehicle notify("hovering");
        wait(1);
        break;

      default:
        assertmsg("Unsupported vehicle.custom_landing");
        break;
    }
  }

  vehicle thread vehicle_land_beneath_node(16, self);
  vehicle waittill("near_goal");
  BadPlace_Delete(badplace_name);

  self script_delay();

  vehicle vehicle_unload();
  vehicle waittill_stable();
  vehicle Vehicle_SetSpeed(20, 8, 7);
  wait .2;
  vehicle notify("stable_for_unlink");
  wait .2;

  if(isDefined(self.script_flag_set)) {
    flag_set(self.script_flag_set);
  }

  if(isDefined(self.script_flag_wait)) {
    flag_wait(self.script_flag_wait);
  }

  vehicle notify("littlebird_liftoff");
}
setup_gag_stage_littlebird_unload() {
  Assert(isDefined(self.targetname));
  Assert(isDefined(self.angles));

  while(1) {
    self waittill("trigger", vehicle);
    littlebird_lands_and_unloads(vehicle);
  }
}

setup_gag_stage_littlebird_load() {
  Assert(isDefined(self.targetname));
  Assert(isDefined(self.angles));

  while(1) {
    self waittill("trigger", vehicle);

    vehicle SetDeceleration(6);
    vehicle SetAcceleration(4);
    vehicle SetTargetYaw(self.angles[1]);
    vehicle Vehicle_SetSpeed(20, 7, 7);

    while(Distance(flat_origin(vehicle.origin), flat_origin(self.origin)) > 256)
      wait .05;

    vehicle endon("death");
    vehicle thread vehicle_land_beneath_node(220, self);

    vehicle waittill("near_goal");

    vehicle Vehicle_SetSpeed(20, 22, 7);
    vehicle thread vehicle_land_beneath_node(16, self);
    vehicle waittill("near_goal");

    vehicle waittill_stable();
    vehicle notify("touch_down", self);
    vehicle Vehicle_SetSpeed(20, 8, 7);
  }
}

vehicle_land_beneath_node(neargoal, node, height) {
  if(!isDefined(height))
    height = 0;

  self notify("newpath");
  if(!isDefined(neargoal))
    neargoal = 2;
  self SetNearGoalNotifyDist(neargoal);
  self SetHoverParams(0, 0, 0);
  self ClearGoalYaw();
  self SetTargetYaw(flat_angle(node.angles)[1]);

  self setvehgoalpos_wrap(groundpos(node.origin) + (0, 0, height), 1);
  self waittill("goal");
}

vehicle_landvehicle(neargoal, node) {
  self notify("newpath");
  if(!isDefined(neargoal))
    neargoal = 2;
  self SetNearGoalNotifyDist(neargoal);
  self SetHoverParams(0, 0, 0);
  self ClearGoalYaw();
  self SetTargetYaw(flat_angle(self.angles)[1]);
  self setvehgoalpos_wrap(groundpos(self.origin), 1);
  self waittill("goal");
}

vehicle_get_riders_by_group(groupname) {
  group = [];
  Assert(isDefined(self.vehicletype));
  if(!isDefined(level.vehicle_unloadgroups[self.vehicletype])) {
    return group;
  }
  vehicles_groups = level.vehicle_unloadgroups[self.vehicletype];
  if(!isDefined(groupname)) {
    return group;
  }

  foreach(guy in self.riders) {
    Assert(isDefined(guy.vehicle_position));
    foreach(groupid in vehicles_groups[groupname]) {
      if(guy.vehicle_position == groupid) {
        group[group.size] = guy;
      }
    }
  }
  return group;
}

vehicle_ai_event(event) {
  return self maps\_vehicle_aianim::animate_guys(event);
}

vehicle_unload(who) {
  self notify("unloading");
  ai = [];
  if(ent_flag_exist("no_riders_until_unload")) {
    ent_flag_set("no_riders_until_unload");
    ai = spawn_group();
    foreach(a in ai)
    spawn_failed(a);
  }
  if(isDefined(who))
    self.unload_group = who;

  foreach(guy in self.riders) {
    if(IsAlive(guy))
      guy notify("unload");
  }
  ai = self vehicle_ai_event("unload");

  return ai;
}

get_stage_nodes(pickup_node_before_stage, side) {
  Assert(isDefined(pickup_node_before_stage.target));
  targeted_nodes = GetNodeArray(pickup_node_before_stage.target, "targetname");
  stage_side_nodes = [];
  foreach(node in targeted_nodes) {
    Assert(isDefined(node.script_noteworthy));
    if(node.script_noteworthy == "stage_" + side)
      stage_side_nodes[stage_side_nodes.size] = node;
  }
  return stage_side_nodes;
}

set_stage(pickup_node_before_stage, guys, side) {
  if(!ent_flag_exist("staged_guy_" + side))
    ent_flag_init("staged_guy_" + side);
  else
    ent_flag_clear("staged_guy_" + side);

  if(!ent_flag_exist("guy2_in_" + side))
    ent_flag_init("guy2_in_" + side);
  else
    ent_flag_clear("guy2_in_" + side);

  nodes = get_stage_nodes(pickup_node_before_stage, side);
  Assert(nodes.size);
  heli_node = getstruct(pickup_node_before_stage.target, "targetname");
  stage_heli = spawn("script_model", (0, 0, 0));
  stage_heli setModel(self.model);
  stage_heli.origin = drop_to_ground(heli_node.origin) + (0, 0, self.originheightoffset);
  stage_heli.angles = heli_node.angles;
  stage_heli Hide();

  hop_on_guy1 = undefined;
  patting_back_second_guy = undefined;
  stage_guy = undefined;

  foreach(node in nodes) {
    guy = undefined;

    foreach(rider in guys) {
      if((isDefined(rider.script_startingposition)) && (rider.script_startingposition == node.script_startingposition)) {
        guy = rider;
        break;
      }
    }

    if(!isDefined(guy)) {
      guy = getClosest(node.origin, guys);
    }

    Assert(isDefined(guy));

    Assert(isDefined(node.script_startingposition));
    guy.script_startingposition = node.script_startingposition;

    if(guy.script_startingposition == 2 || guy.script_startingposition == 5) {
      hop_on_guy1 = guy;
      guy maps\_spawner::go_to_node_set_goal_node(node);
    } else if(guy.script_startingposition == 3 || guy.script_startingposition == 6) {
      stage_guy = guy;
    } else if(guy.script_startingposition == 4 || guy.script_startingposition == 7) {
      patting_back_second_guy = guy;
      guy maps\_spawner::go_to_node_set_goal_node(node);
    }

    guys = array_remove(guys, guy);
  }

  Assert(isDefined(hop_on_guy1));
  Assert(isDefined(patting_back_second_guy));
  Assert(isDefined(stage_guy));

  self thread stage_guy(stage_guy, side, patting_back_second_guy, stage_heli);
  self thread delete_on_death(stage_heli);
}

load_side(side, riders) {
  hop_on_guy1 = undefined;
  patting_back_second_guy = undefined;
  stage_guy = undefined;
  foreach(rider in riders) {
    Assert(isDefined(rider.script_startingposition));
    if(rider.script_startingposition == 2 || rider.script_startingposition == 5)
      hop_on_guy1 = rider;
    else if(rider.script_startingposition == 3 || rider.script_startingposition == 6)
      stage_guy = rider;
    else if(rider.script_startingposition == 4 || rider.script_startingposition == 7)
      patting_back_second_guy = rider;
  }
  Assert(isDefined(hop_on_guy1));
  Assert(isDefined(patting_back_second_guy));
  Assert(isDefined(stage_guy));

  ent_flag_wait("staged_guy_" + side);

  thread vehicle_load_ai_single(hop_on_guy1, undefined, side);

  hop_on_guy1 waittill("boarding_vehicle");

  thread vehicle_load_ai_single(patting_back_second_guy, undefined, side);
  patting_back_second_guy waittill("boarding_vehicle");
  ent_flag_set("guy2_in_" + side);
}
stage_guy(guy, side, otherguy, stag_objected) {
  scene = "stage_littlebird_" + side;
  array = [];
  array[0] = guy;

  stag_objected anim_generic_reach(array[0], scene, "tag_detach_" + side);
  stag_objected anim_generic(array[0], scene, "tag_detach_" + side);
  ent_flag_set("staged_guy_" + side);

  guy SetGoalPos(drop_to_ground(guy.origin));
  guy.goalradius = 16;

  ent_flag_wait("guy2_in_" + side);

  thread vehicle_load_ai_single(guy, undefined, side);
}

kill_riders(riders) {
  foreach(rider in riders) {
    if(!IsAlive(rider))
      continue;
    if(!isDefined(rider.ridingvehicle) && !isDefined(rider.drivingVehicle)) {
      continue;
    }
    if(isDefined(rider.magic_bullet_shield))
      rider stop_magic_bullet_shield();
    rider Kill();
  }
}

vehicle_rider_death_detection(vehicle, riders) {
  if(level.script == "af_chase")
    if(isDefined(self.vehicle_position) && self.vehicle_position != 0) {
      return;
    }
  self.health = 1;
  vehicle endon("death");
  self.baseaccuracy = 0.15;

  self waittill("death");
  vehicle notify("driver_died");
  kill_riders(riders);
}

vehicle_becomes_crashable() {
  self endon("death");
  self endon("enable_spline_path");

  waittillframeend;
  self.riders = remove_dead_from_array(self.riders);

  if(self.riders.size) {
    array_thread(self.riders, ::vehicle_rider_death_detection, self, self.riders);
    self waittill_either("veh_collision", "driver_died");
    kill_riders(self.riders);
    wait(0.25);
  }

  self notify("script_crash_vehicle");
  self VehPhys_Crash();
}

vehicle_turret_scan_on() {
  self endon("death");
  self endon("stop_scanning_turret");

  positive_range = RandomInt(2);

  while(isDefined(self)) {
    if(cointoss()) {
      self vehicle_aim_turret_at_angle(0);
      wait(RandomFloatRange(2, 10));
    }

    if(positive_range == 0) {
      angle = RandomIntRange(10, 30);
      positive_range = 1;
    } else {
      angle = RandomIntRange(-30, -10);
      positive_range = 0;
    }

    self vehicle_aim_turret_at_angle(angle);
    wait(RandomFloatRange(2, 10));
  }
}

vehicle_turret_scan_off() {
  self notify("stop_scanning_turret");
}

vehicle_aim_turret_at_angle(iAngle) {
  self endon("death");
  vec = anglesToForward(self.angles + (0, iAngle, 0));
  vec *= 10000;
  vec = vec + (0, 0, 70);
  self SetTurretTargetVec(vec);
}

vehicle_get_path_array() {
  self endon("death");
  aPathNodes = [];
  eStartNode = self.attachedpath;
  if(!isDefined(self.attachedpath))
    return aPathNodes;
  nextNode = eStartNode;
  nextNode.counted = false;
  while(isDefined(nextNode)) {
    if((isDefined(nextNode.counted)) && (nextNode.counted == true)) {
      break;
    }

    aPathNodes = array_add(aPathNodes, nextNode);
    nextNode.counted = true;

    if(!isDefined(nextNode.target)) {
      break;
    }

    if(!isHelicopter())
      nextNode = GetVehicleNode(nextNode.target, "targetname");
    else
      nextNode = getent_or_struct(nextNode.target, "targetname");
  }

  return aPathNodes;
}

kill_lights(model) {
  lights_off_internal("all", model);
}

vehicle_lights_on(group) {
  lights_on(group);
}

vehicle_lights_off(group) {
  lights_off(group);
}