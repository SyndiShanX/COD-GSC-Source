/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include codescripts\struct;
#include maps\_vehicle_death;
#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include maps\_destructible;
#include maps\_turret;
#include maps\_huey;
#include maps\_hind_player;
#include maps\_blackhawk;
#include maps\_hind;
#include maps\_avenger;
#include maps\_pegasus;
#include maps\_f35;
#include maps\_osprey;
#include maps\_treadfx;
#include maps\_dynamic_nodes;
#include maps\_spawner;
#include maps\_t72;
#include maps\_tank_zsu23;
#include maps\_truck;
#include maps\_truck_gaz66;
#include maps\_truck_gaz63;
#include maps\_uaz;
#include maps\_jeep;
#include maps\_chinook;
#include maps\_cobra;
#include maps\_hip;
#include maps\_pavelow;
#include maps\_littlebird;
#include maps\_mig17;
#include maps\_zpu_antiair;
#include maps\_apc;
#include maps\_apc_buffel;
#include maps\_btr;
#include maps\_truck_gaztigr;
#include maps\_civ_pickup;
#include maps\_civ_pickup_big;
#include maps\_civ_vehicle;
#include maps\_tiara;
#include maps\_policecar;
#include maps\_snowcat;
#include maps\_rcbomb;
#include maps\_sampan;
#include maps\_motorcycle_lapd;
#include maps\_motorcycle;
#include maps\_van;
#include maps\_horse;
#include maps\_soct;

init_vehicles() {
  precachemodel("fx");
  precachestring(&"hud_vehicle_turret_fire");

  if(isDefined(level.bypassvehiclescripts)) {
    return;
  }
  level.heli_default_decel = 10;
  setup_targetname_spawners();
  setup_dvars();
  setup_levelvars();
  setup_ai();
  setup_triggers();
  setup_nodes();
  maps\_vehicle_death::init();
  allvehiclesprespawn = getentarray("script_vehicle", "classname");

  level thread vehicle_spawner_tool(allvehiclesprespawn);

  setup_vehicles(allvehiclesprespawn);
  level array_ent_thread(level.vehicle_processtriggers, ::trigger_process);
  level.vehicle_processtriggers = undefined;
  level.vehicle_enemy_tanks = [];
  level.vehicle_enemy_tanks["vehicle_ger_tracked_king_tiger"] = 1;
}

setup_script_gatetrigger(trigger) {
  gates = [];

  if(isDefined(trigger.script_gatetrigger))
    return level.vehicle_gatetrigger[trigger.script_gatetrigger];

  return gates;
}

trigger_process(trigger) {
  if(isDefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat" || trigger.classname == "trigger_box"))
    btriggeronce = 1;
  else
    btriggeronce = 0;

  if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple")
    btriggeronce = 0;

  trigger.processed_trigger = undefined;
  gates = setup_script_gatetrigger(trigger);
  script_vehicledetour = isDefined(trigger.script_vehicledetour) && (is_node_script_origin(trigger) || is_node_script_struct(trigger));
  detoured = isDefined(trigger.detoured) && !(is_node_script_origin(trigger) || is_node_script_struct(trigger));
  gotrigger = 1;

  while(gotrigger) {
    trigger trigger_wait();
    other = trigger.who;

    if(isDefined(trigger.script_vehicletriggergroup)) {
      if(!isDefined(other.script_vehicletriggergroup)) {
        continue;
      }
      if(isDefined(other) && other.script_vehicletriggergroup != trigger.script_vehicletriggergroup)
        continue;
    }

    if(isDefined(trigger.enabled) && !trigger.enabled)
      trigger waittill("enable");

    if(isDefined(trigger.script_flag_set)) {
      if(isDefined(other) && isDefined(other.vehicle_flags))
        other.vehicle_flags[trigger.script_flag_set] = 1;

      if(isDefined(other))
        other notify("vehicle_flag_arrived", trigger.script_flag_set);

      flag_set(trigger.script_flag_set);
    }

    if(isDefined(trigger.script_flag_clear)) {
      if(isDefined(other) && isDefined(other.vehicle_flags))
        other.vehicle_flags[trigger.script_flag_clear] = 0;

      flag_clear(trigger.script_flag_clear);
    }

    if(isDefined(other) && script_vehicledetour)
      other thread path_detour_script_origin(trigger);
    else if(detoured && isDefined(other))
      other thread path_detour(trigger);

    trigger script_delay();

    if(btriggeronce)
      gotrigger = 0;

    if(isDefined(trigger.script_vehiclegroupdelete)) {
      if(!isDefined(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete])) {
        println("failed to find deleteable vehicle with script_vehicleGroupDelete group number: ", trigger.script_vehiclegroupdelete);

        level.vehicle_deletegroup[trigger.script_vehiclegroupdelete] = [];
      }

      array_delete(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete]);
    }

    if(isDefined(trigger.script_vehiclespawngroup)) {
      level notify("spawnvehiclegroup" + trigger.script_vehiclespawngroup);
      level waittill("vehiclegroup spawned" + trigger.script_vehiclespawngroup);
    }

    if(gates.size > 0 && btriggeronce)
      level array_ent_thread(gates, ::path_gate_open);

    if(isDefined(trigger.script_vehiclestartmove)) {
      if(!isDefined(level.vehicle_startmovegroup[trigger.script_vehiclestartmove])) {
        println("^3Vehicle start trigger is: ", trigger.script_vehiclestartmove);

        return;
      }

      array_thread(array_copy(level.vehicle_startmovegroup[trigger.script_vehiclestartmove]), ::gopath);
    }
  }
}

path_detour_get_detourpath(detournode) {
  detourpath = undefined;

  for(j = 0; j < level.vehicle_detourpaths[detournode.script_vehicledetour].size; j++) {
    if(level.vehicle_detourpaths[detournode.script_vehicledetour][j] != detournode) {
      if(!islastnode(level.vehicle_detourpaths[detournode.script_vehicledetour][j]))
        detourpath = level.vehicle_detourpaths[detournode.script_vehicledetour][j];
    }
  }

  return detourpath;
}

path_detour_script_origin(detournode) {
  detourpath = path_detour_get_detourpath(detournode);

  if(isDefined(detourpath))
    self thread vehicle_paths(detourpath);
}

crash_detour_check(detourpath) {
  return isDefined(detourpath.script_crashtype) && (isDefined(self.deaddriver) || self.health <= 0 || detourpath.script_crashtype == "forced") && (!isDefined(detourpath.derailed) || isDefined(detourpath.script_crashtype) && detourpath.script_crashtype == "plane");
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
    self setswitchnode(node, detourpath);
    return;
  } else {
    if(crash_derailed_check(detourpath)) {
      return;
    }
    if(isDefined(detourpath.script_vehicledetourgroup)) {
      if(!isDefined(self.script_vehicledetourgroup)) {
        return;
      }
      if(detourpath.script_vehicledetourgroup != self.script_vehicledetourgroup)
        return;
    }
  }
}

vehicle_levelstuff(vehicle) {
  if(isDefined(vehicle.script_linkname))
    level.vehicle_link = array_2dadd(level.vehicle_link, vehicle.script_linkname, vehicle);

  if(isDefined(vehicle.script_vehiclespawngroup))
    level.vehicle_spawngroup = array_2dadd(level.vehicle_spawngroup, vehicle.script_vehiclespawngroup, vehicle);

  if(isDefined(vehicle.script_vehiclestartmove))
    level.vehicle_startmovegroup = array_2dadd(level.vehicle_startmovegroup, vehicle.script_vehiclestartmove, vehicle);

  if(isDefined(vehicle.script_vehiclegroupdelete))
    level.vehicle_deletegroup = array_2dadd(level.vehicle_deletegroup, vehicle.script_vehiclegroupdelete, vehicle);
}

spawn_array(spawners) {
  ai = [];

  for(i = 0; i < spawners.size; i++) {
    spawners[i].count = 1;

    if(isDefined(spawners[i].script_drone))
      spawned = spawners[i] spawn_drone();
    else {
      spawned = spawners[i] spawn_ai();

      if(!isalive(spawned))
        continue;
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
  if(isalive(ai))
    return true;

  if(!isDefined(ai))
    return false;

  if(!isDefined(ai.classname))
    return false;

  return ai.classname == "script_model";
}

spawn_ai_group() {
  hasriders = isDefined(self.script_vehicleride);
  haswalkers = isDefined(self.script_vehiclewalk);

  if(!(hasriders || haswalkers)) {
    return;
  }
  spawners = [];
  riderspawners = [];
  walkerspawners = [];

  if(hasriders)
    riderspawners = level.vehicle_ridespawners[self.script_vehicleride];

  if(!isDefined(riderspawners))
    riderspawners = [];

  if(haswalkers)
    walkerspawners = level.vehicle_walkspawners[self.script_vehiclewalk];

  if(!isDefined(walkerspawners))
    walkerspawners = [];

  spawners = arraycombine(riderspawners, walkerspawners, 1, 0);
  startinvehicles = [];

  for(i = 0; i < spawners.size; i++)
    spawners[i].script_forcespawn = 1;

  ai = spawn_array(spawners);

  if(hasriders) {
    if(isDefined(level.vehicle_rideai[self.script_vehicleride]))
      ai = arraycombine(ai, level.vehicle_rideai[self.script_vehicleride], 1, 0);
  }

  if(haswalkers) {
    if(isDefined(level.vehicle_walkai[self.script_vehiclewalk])) {
      ai = arraycombine(ai, level.vehicle_walkai[self.script_vehiclewalk], 1, 0);
      ai vehicle_rider_walk_setup(self);
    }
  }

  ai = sort_by_startingpos(ai);

  for(i = 0; i < ai.size; i++)
    ai[i] thread maps\_vehicle_aianim::vehicle_enter(self, self.script_tag);
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

vehicle_rider_walk_setup(vehicle) {
  if(!isDefined(self.script_vehiclewalk)) {
    return;
  }
  if(isDefined(self.script_followmode))
    self.followmode = self.script_followmode;
  else
    self.followmode = "cover nodes";

  if(!isDefined(self.target)) {
    return;
  }
  node = getnode(self.target, "targetname");

  if(isDefined(node))
    self.nodeaftervehiclewalk = node;
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
  trigger.processed_trigger = 1;
}

islastnode(node) {
  if(!isDefined(node.target))
    return true;

  if(!isDefined(getvehiclenode(node.target, "targetname")) && !isDefined(get_vehiclenode_any_dynamic(node.target)))
    return true;

  return false;
}

vehicle_paths(node) {
  self endon("death");
  assert(isDefined(node) || isDefined(self.attachedpath), "vehicle_path() called without a path");
  self notify("newpath");

  if(isDefined(node))
    self.attachedpath = node;

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
    self.nextnode = isDefined(currentpoint.target) ? getvehiclenode(currentpoint.target, "targetname") : undefined;

    if(isDefined(currentpoint.gateopen) && !currentpoint.gateopen)
      self thread path_gate_wait_till_open(currentpoint);

    currentpoint notify("trigger", self);

    if(isDefined(currentpoint.script_dropbombs) && currentpoint.script_dropbombs > 0) {
      amount = currentpoint.script_dropbombs;
      delay = 0;
      delaytrace = 0;

      if(isDefined(currentpoint.script_dropbombs_delay) && currentpoint.script_dropbombs_delay > 0)
        delay = currentpoint.script_dropbombs_delay;

      if(isDefined(currentpoint.script_dropbombs_delaytrace) && currentpoint.script_dropbombs_delaytrace > 0)
        delaytrace = currentpoint.script_dropbombs_delaytrace;

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

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(currentpoint.script_noteworthy)) {
      if(currentpoint.script_noteworthy == "godon")
        self godon();
      else if(currentpoint.script_noteworthy == "godoff")
        self godoff();
      else if(currentpoint.script_noteworthy == "deleteme") {
        if(isDefined(self.riders) && self.riders.size > 0)
          array_delete(self.riders);

        self.delete_on_death = 1;
        self notify("death");

        if(!isalive(self))
          self delete();

        return;
      } else if(currentpoint.script_noteworthy == "drivepath")
        self drivepath();
      else if(currentpoint.script_noteworthy == "lockpath")
        self startpath();
      else if(currentpoint.script_noteworthy == "brake") {
        if(self.isphysicsvehicle)
          self setbrake(1);

        self setspeed(0, 60, 60);
      } else if(currentpoint.script_noteworthy == "resumespeed") {
        accel = 30;

        if(isDefined(currentpoint.script_float))
          accel = currentpoint.script_float;

        self resumespeed(accel);
      }
    }

    if(isDefined(currentpoint.script_crashtypeoverride))
      self.script_crashtypeoverride = currentpoint.script_crashtypeoverride;

    if(isDefined(currentpoint.script_badplace))
      self.script_badplace = currentpoint.script_badplace;

    if(isDefined(currentpoint.script_team))
      self.vteam = currentpoint.script_team;

    if(isDefined(currentpoint.script_turningdir))
      self notify("turning", currentpoint.script_turningdir);

    if(isDefined(currentpoint.script_deathroll)) {
      if(currentpoint.script_deathroll == 0)
        self thread deathrolloff();
      else
        self thread deathrollon();
    }

    if(isDefined(currentpoint.script_vehicleaianim)) {
      if(isDefined(currentpoint.script_parameters) && currentpoint.script_parameters == "queue")
        self.queueanim = 1;

      if(isDefined(currentpoint.script_startingposition))
        self.groupedanim_pos = currentpoint.script_startingposition;

      self notify("groupedanimevent", currentpoint.script_vehicleaianim);
    }

    if(isDefined(currentpoint.script_exploder))
      exploder(currentpoint.script_exploder);

    if(isDefined(currentpoint.script_flag_set)) {
      if(isDefined(self.vehicle_flags))
        self.vehicle_flags[currentpoint.script_flag_set] = 1;

      self notify("vehicle_flag_arrived", currentpoint.script_flag_set);
      flag_set(currentpoint.script_flag_set);
    }

    if(isDefined(currentpoint.script_flag_clear)) {
      if(isDefined(self.vehicle_flags))
        self.vehicle_flags[currentpoint.script_flag_clear] = 0;

      flag_clear(currentpoint.script_flag_clear);
    }

    if(self.vehicleclass == "helicopter" && isDefined(self.drivepath) && self.drivepath == 1) {
      if(isDefined(self.nextnode) && isDefined(self.nextnode.script_unload)) {
        unload_node_helicopter(undefined);
        self.attachedpath = self.nextnode;
        self drivepath(self.attachedpath);
      }
    } else if(isDefined(currentpoint.script_unload))
      unload_node(currentpoint);

    if(isDefined(currentpoint.script_wait)) {
      vehicle_pause_path();
      currentpoint script_wait();
    }

    if(isDefined(currentpoint.script_waittill)) {
      vehicle_pause_path();
      self waittill(currentpoint.script_waittill);
    }

    if(isDefined(currentpoint.script_flag_wait)) {
      if(!isDefined(self.vehicle_flags))
        self.vehicle_flags = [];

      self.vehicle_flags[currentpoint.script_flag_wait] = 1;
      self notify("vehicle_flag_arrived", currentpoint.script_flag_wait);
      self ent_flag_set("waiting_for_flag");

      if(!flag(currentpoint.script_flag_wait)) {
        vehicle_pause_path();
        flag_wait(currentpoint.script_flag_wait);
      }

      self ent_flag_clear("waiting_for_flag");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(currentpoint.script_lights_on)) {
      if(currentpoint.script_lights_on)
        self lights_on();
      else
        self lights_off();
    }

    if(isDefined(currentpoint.script_stopnode))
      self setvehgoalpos_wrap(currentpoint.origin, 1);

    if(isDefined(self.switchnode)) {
      if(currentpoint == self.switchnode)
        self.switchnode = undefined;
    } else if(!isDefined(currentpoint.target)) {
      break;
    }

    vehicle_resume_path();
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove))
    self delete();
}

vehicle_pause_path() {
  if(!(isDefined(self.vehicle_paused) && self.vehicle_paused)) {
    if(self.isphysicsvehicle)
      self setbrake(1);

    if(self.vehicleclass == "helicopter") {
      if(isDefined(self.drivepath) && self.drivepath)
        self setvehgoalpos(self.origin, 1);
      else
        self setspeed(0, 100, 100);
    } else
      self setspeed(0, 35, 35);

    self.vehicle_paused = 1;
  }
}

vehicle_resume_path() {
  if(isDefined(self.vehicle_paused) && self.vehicle_paused) {
    if(self.isphysicsvehicle)
      self setbrake(0);

    if(self.vehicleclass == "helicopter") {
      if(isDefined(self.drivepath) && self.drivepath)
        self drivepath(self.currentnode);

      self resumespeed(100);
    } else
      self resumespeed(35);

    self.vehicle_paused = undefined;
  }
}

getonpath(path_start) {
  if(!isDefined(path_start)) {
    return;
  }
  if(isDefined(self.hasstarted))
    self.hasstarted = undefined;

  self.attachedpath = path_start;

  if(!(isDefined(self.drivepath) && self.drivepath))
    self attachpath(path_start);

  if(!isDefined(self.dontdisconnectpaths) && !issentient(self))
    self vehicle_disconnectpaths_wrapper();

  if(isDefined(self.isphysicsvehicle) && self.isphysicsvehicle)
    self setbrake(1);

  self thread vehicle_paths();
}

getoffpath() {
  self cancelaimove();
  self clearvehgoalpos();
}

create_vehicle_from_spawngroup_and_gopath(spawngroup) {
  vehiclearray = maps\_vehicle::scripted_spawn(spawngroup);

  for(i = 0; i < vehiclearray.size; i++) {
    if(isDefined(vehiclearray[i]))
      vehiclearray[i] thread maps\_vehicle::gopath();
  }

  return vehiclearray;
}

gopath() {
  self endon("death");
  self endon("stop path");

  if(self.isphysicsvehicle)
    self setbrake(0);

  if(isDefined(self.script_vehiclestartmove))
    arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);

  if(isDefined(self.hasstarted)) {
    println("vehicle already moving when triggered with a startmove");

    return;
  } else
    self.hasstarted = 1;

  self script_delay();
  self notify("start_vehiclepath");

  if(isDefined(self.drivepath) && self.drivepath)
    self drivepath(self.attachedpath);
  else
    self startpath();

  wait 0.05;
  self vehicle_connectpaths_wrapper();
  self waittill("reached_end_node");

  if(!isDefined(self.dontdisconnectpaths) && !issentient(self))
    self vehicle_disconnectpaths_wrapper();

  if(isDefined(self.currentnode) && isDefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme") {
    return;
  }
  if(!isDefined(self.dontunloadonend))
    do_unload(self.script_unloaddelay);
}

do_unload(delay) {
  self endon("unload");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  self notify("unload");
}

path_gate_open(node) {
  node.gateopen = 1;
  node notify("gate opened");
}

path_gate_wait_till_open(pathspot) {
  self endon("death");
  self.waitingforgate = 1;
  self vehicle_setspeed(0, 15, "path gate closed");
  pathspot waittill("gate opened");
  self.waitingforgate = 0;

  if(self.health > 0)
    script_resumespeed("gate opened", level.vehicle_resumespeed);
}

spawner_setup(vehicles, spawngroup) {
  level.vehicle_spawners[spawngroup] = [];

  foreach(veh in vehicles) {
    veh thread vehicle_main();
    s_spawner = createstruct();
    veh vehicle_dynamic_cover(s_spawner);
    s_spawner set_spawner_variables(veh);
    level.vehicle_spawners[spawngroup][level.vehicle_spawners[spawngroup].size] = s_spawner;
  }

  thread vehicle_spawn_group(spawngroup);
}

vehicle_spawn_group(spawngroup) {
  while(true) {
    level waittill("spawnvehiclegroup" + spawngroup);
    spawned_vehicles = [];

    for(i = 0; i < level.vehicle_spawners[spawngroup].size; i++)
      spawned_vehicles[spawned_vehicles.size] = vehicle_spawn(level.vehicle_spawners[spawngroup][i]);

    level notify("vehiclegroup spawned" + spawngroup, spawned_vehicles);
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

set_spawner_variables(vehicle) {
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

  if(isDefined(vehicle.script_startinghealth))
    self.script_startinghealth = vehicle.script_startinghealth;

  if(isDefined(vehicle.spawnernum))
    self.spawnernum = vehicle.spawnernum;

  if(isDefined(vehicle.script_deathflag)) {
    if(!level flag_exists(vehicle.script_deathflag))
      flag_init(vehicle.script_deathflag);

    self.script_deathflag = vehicle.script_deathflag;
  }

  if(isDefined(vehicle.script_enable_turret0))
    self.script_enable_turret0 = vehicle.script_enable_turret0;

  if(isDefined(vehicle.script_enable_turret1))
    self.script_enable_turret1 = vehicle.script_enable_turret1;

  if(isDefined(vehicle.script_enable_turret2))
    self.script_enable_turret2 = vehicle.script_enable_turret2;

  if(isDefined(vehicle.script_enable_turret3))
    self.script_enable_turret3 = vehicle.script_enable_turret3;

  if(isDefined(vehicle.script_enable_turret4))
    self.script_enable_turret4 = vehicle.script_enable_turret4;

  if(isDefined(vehicle.script_linkto))
    self.script_linkto = vehicle.script_linkto;

  if(isDefined(vehicle.script_vehiclespawngroup))
    self.script_vehiclespawngroup = vehicle.script_vehiclespawngroup;

  if(isDefined(vehicle.script_vehiclestartmove))
    self.script_vehiclestartmove = vehicle.script_vehiclestartmove;

  if(isDefined(vehicle.script_vehiclegroupdelete))
    self.script_vehiclegroupdelete = vehicle.script_vehiclegroupdelete;

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

  if(isDefined(vehicle.script_linkname))
    self.script_linkname = vehicle.script_linkname;

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

  if(isDefined(vehicle.script_lights_on))
    self.script_lights_on = vehicle.script_lights_on;

  if(isDefined(vehicle.script_vehicledetourgroup))
    self.script_vehicledetourgroup = vehicle.script_vehicledetourgroup;

  if(isDefined(vehicle.speed))
    self.speed = vehicle.speed;

  if(isDefined(vehicle.script_vehicletriggergroup))
    self.script_vehicletriggergroup = vehicle.script_vehicletriggergroup;

  if(isDefined(vehicle.script_cheap))
    self.script_cheap = vehicle.script_cheap;

  if(isDefined(vehicle.script_nonmovingvehicle))
    self.script_nonmovingvehicle = vehicle.script_nonmovingvehicle;

  if(isDefined(vehicle.script_flag))
    self.script_flag = vehicle.script_flag;

  if(isDefined(vehicle.script_disconnectpaths))
    self.script_disconnectpaths = vehicle.script_disconnectpaths;

  if(isDefined(vehicle.script_bulletshield))
    self.script_bulletshield = vehicle.script_bulletshield;

  if(isDefined(vehicle.script_godmode))
    self.script_godmode = vehicle.script_godmode;

  if(isDefined(vehicle.script_vehicleattackgroup))
    self.script_vehicleattackgroup = vehicle.script_vehicleattackgroup;

  if(isDefined(vehicle.script_vehicleattackgroupwait))
    self.script_vehicleattackgroupwait = vehicle.script_vehicleattackgroupwait;

  if(isDefined(vehicle.script_friendname))
    self.script_friendname = vehicle.script_friendname;

  if(isDefined(vehicle.script_unload))
    self.script_unload = vehicle.script_unload;

  if(isDefined(vehicle.script_string))
    self.script_string = vehicle.script_string;

  if(isDefined(vehicle.script_int))
    self.script_int = vehicle.script_int;

  if(isDefined(vehicle.script_animation))
    self.script_animation = vehicle.script_animation;

  if(isDefined(vehicle.script_ignoreme))
    self.script_ignoreme = vehicle.script_ignoreme;

  if(isDefined(vehicle.lockheliheight))
    self.lockheliheight = vehicle getheliheightlock();

  if(isDefined(vehicle.script_targetset))
    self.script_targetset = vehicle.script_targetset;

  if(isDefined(vehicle.script_targetoffset))
    self.script_targetoffset = vehicle.script_targetoffset;

  if(isDefined(vehicle.script_startstate))
    self.script_startstate = vehicle.script_startstate;

  if(isDefined(vehicle.script_animname))
    self.script_animname = vehicle.script_animname;

  if(isDefined(vehicle.script_animscripted))
    self.script_animscripted = vehicle.script_animscripted;

  if(isDefined(vehicle.script_recordent))
    self.script_recordent = vehicle.script_recordent;

  if(isDefined(vehicle.script_brake))
    self.script_brake = vehicle.script_brake;

  if(isDefined(vehicle.script_vehicleavoidance))
    self.script_vehicleavoidance = vehicle.script_vehicleavoidance;

  if(isDefined(vehicle.script_doorstate))
    self.script_doorstate = vehicle.script_doorstate;

  if(isDefined(vehicle.script_combat_getout))
    self.script_combat_getout = vehicle.script_combat_getout;

  if(isDefined(vehicle.radius))
    self.radius = vehicle.radius;

  if(vehicle.count > 0)
    self.count = vehicle.count;
  else
    self.count = 1;

  if(!isDefined(self.vehicletype)) {
    if(isDefined(vehicle.vehicletype))
      self.vehicletype = vehicle.vehicletype;
  }

  if(isDefined(vehicle.destructibledef))
    self.destructibledef = vehicle.destructibledef;

  if(!vehicle has_spawnflag(2) && vehicle isvehicleusable())
    self.usable = 1;

  if(isDefined(vehicle.drivepath))
    self.drivepath = vehicle.drivepath;

  if(isDefined(vehicle.script_numbombs))
    self.script_numbombs = vehicle.script_numbombs;

  if(isDefined(vehicle.deathfx))
    self.deathfx = vehicle.deathfx;

  if(isDefined(vehicle.fx_crash_effects))
    self.fx_crash_effects = vehicle.fx_crash_effects;

  if(isDefined(vehicle.m_objective_model))
    self.m_objective_model = vehicle.m_objective_model;

  vehicle delete();
  id = vehicle_spawnidgenerate(self.origin);
  self.spawner_id = id;
}

vehicle_spawnidgenerate(origin) {
  return "spawnid" + int(origin[0]) + "a" + int(origin[1]) + "a" + int(origin[2]);
}

vehicledamageassist() {
  self endon("death");
  self.attackers = [];
  self.attackerdata = [];

  while(true) {
    self waittill("damage", amount, attacker);

    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
    }
    if(!isDefined(self.attackerdata[attacker getentitynumber()])) {
      self.attackers[self.attackers.size] = attacker;
      self.attackerdata[attacker getentitynumber()] = 0;
    }
  }
}

vehicle_spawn(vspawner, from) {
  if(!vspawner.count) {
    return;
  }
  vehicle = spawnvehicle(vspawner.spawnermodel, vspawner.spawnedtargetname, vspawner.vehicletype, vspawner.origin, vspawner.angles, vspawner.destructibledef);

  if(isDefined(vspawner.destructibledef)) {
    vehicle.destructibledef = vspawner.destructibledef;
    vehicle thread maps\_destructible::destructible_think();
  }

  if(isDefined(vspawner.script_delay))
    vehicle.script_delay = vspawner.script_delay;

  if(isDefined(vspawner.script_noteworthy))
    vehicle.script_noteworthy = vspawner.script_noteworthy;

  if(isDefined(vspawner.script_parameters))
    vehicle.script_parameters = vspawner.script_parameters;

  if(isDefined(vspawner.script_team))
    vehicle.vteam = vspawner.script_team;

  if(isDefined(vspawner.script_vehicleride))
    vehicle.script_vehicleride = vspawner.script_vehicleride;

  if(isDefined(vspawner.target))
    vehicle.target = vspawner.target;

  if(isDefined(vspawner.vehicletype) && !isDefined(vehicle.vehicletype))
    vehicle.vehicletype = vspawner.vehicletype;

  if(isDefined(vspawner.triggeredthink))
    vehicle.triggeredthink = vspawner.triggeredthink;

  if(isDefined(vspawner.script_sound))
    vehicle.script_sound = vspawner.script_sound;

  if(isDefined(vspawner.script_startinghealth))
    vehicle.script_startinghealth = vspawner.script_startinghealth;

  if(isDefined(vspawner.script_deathflag))
    vehicle.script_deathflag = vspawner.script_deathflag;

  if(isDefined(vspawner.script_enable_turret0))
    vehicle.script_enable_turret0 = vspawner.script_enable_turret0;

  if(isDefined(vspawner.script_enable_turret1))
    vehicle.script_enable_turret1 = vspawner.script_enable_turret1;

  if(isDefined(vspawner.script_enable_turret2))
    vehicle.script_enable_turret2 = vspawner.script_enable_turret2;

  if(isDefined(vspawner.script_enable_turret3))
    vehicle.script_enable_turret3 = vspawner.script_enable_turret3;

  if(isDefined(vspawner.script_enable_turret4))
    vehicle.script_enable_turret4 = vspawner.script_enable_turret4;

  if(isDefined(vspawner.script_linkto))
    vehicle.script_linkto = vspawner.script_linkto;

  if(isDefined(vspawner.script_vehiclespawngroup))
    vehicle.script_vehiclespawngroup = vspawner.script_vehiclespawngroup;

  if(isDefined(vspawner.script_vehiclestartmove))
    vehicle.script_vehiclestartmove = vspawner.script_vehiclestartmove;

  if(isDefined(vspawner.script_vehiclegroupdelete))
    vehicle.script_vehiclegroupdelete = vspawner.script_vehiclegroupdelete;

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

  if(isDefined(vspawner.script_linkname))
    vehicle.script_linkname = vspawner.script_linkname;

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

  if(isDefined(vspawner.script_lights_on))
    vehicle.script_lights_on = vspawner.script_lights_on;

  if(isDefined(vspawner.script_vehicledetourgroup))
    vehicle.script_vehicledetourgroup = vspawner.script_vehicledetourgroup;

  if(isDefined(vspawner.speed))
    vehicle.speed = vspawner.speed;

  if(isDefined(vspawner.spawner_id))
    vehicle.spawner_id = vspawner.spawner_id;

  if(isDefined(vspawner.script_vehicletriggergroup))
    vehicle.script_vehicletriggergroup = vspawner.script_vehicletriggergroup;

  if(isDefined(vspawner.script_disconnectpaths))
    vehicle.script_disconnectpaths = vspawner.script_disconnectpaths;

  if(isDefined(vspawner.script_godmode))
    vehicle.script_godmode = vspawner.script_godmode;

  if(isDefined(vspawner.script_bulletshield))
    vehicle.script_bulletshield = vspawner.script_bulletshield;

  if(isDefined(vspawner.script_numbombs))
    vehicle.script_numbombs = vspawner.script_numbombs;

  if(isDefined(vspawner.script_flag))
    vehicle.script_flag = vspawner.script_flag;

  if(isDefined(vspawner.script_nonmovingvehicle))
    vehicle.script_nonmovingvehicle = vspawner.script_nonmovingvehicle;

  if(isDefined(vspawner.script_vehicleattackgroup))
    vehicle.script_vehicleattackgroup = vspawner.script_vehicleattackgroup;

  if(isDefined(vspawner.script_vehicleattackgroupwait))
    vehicle.script_vehicleattackgroupwait = vspawner.script_vehicleattackgroupwait;

  if(isDefined(vspawner.script_friendname))
    vehicle setvehiclelookattext(vspawner.script_friendname, & "");

  if(isDefined(vspawner.script_unload))
    vehicle.unload_group = vspawner.script_unload;

  if(isDefined(vspawner.script_string))
    vehicle.script_string = vspawner.script_string;

  if(isDefined(vspawner.script_int))
    vehicle.script_int = vspawner.script_int;

  if(isDefined(vspawner.script_animation))
    vehicle.script_animation = vspawner.script_animation;

  if(isDefined(vspawner.lockheliheight))
    vehicle setheliheightlock(vehicle.lockheliheight);

  if(isDefined(vspawner.script_targetset))
    vehicle.script_targetset = vspawner.script_targetset;

  if(isDefined(vspawner.script_targetoffset))
    vehicle.script_targetoffset = vspawner.script_targetoffset;

  if(isDefined(vspawner.script_startstate))
    vehicle.script_startstate = vspawner.script_startstate;

  if(isDefined(vspawner.script_recordent))
    vehicle.script_recordent = vspawner.script_recordent;

  if(isDefined(vspawner.e_dyn_path))
    vehicle.e_dyn_path = vspawner.e_dyn_path;

  if(isDefined(vspawner.script_brake))
    vehicle.script_brake = vspawner.script_brake;

  if(isDefined(vspawner.script_vehicleavoidance))
    vehicle.script_vehicleavoidance = vspawner.script_vehicleavoidance;

  if(isDefined(vspawner.script_doorstate))
    vehicle.script_doorstate = vspawner.script_doorstate;

  if(isDefined(vspawner.script_combat_getout))
    vehicle.script_combat_getout = vspawner.script_combat_getout;

  if(isDefined(vspawner.radius))
    vehicle.radius = vspawner.radius;

  vehicle_init(vehicle);

  if(isDefined(vehicle.targetname))
    level notify("new_vehicle_spawned" + vehicle.targetname, vehicle);

  if(isDefined(vehicle.script_noteworthy))
    level notify("new_vehicle_spawned" + vehicle.script_noteworthy, vehicle);

  if(isDefined(vehicle.spawner_id))
    level notify("new_vehicle_spawned" + vehicle.spawner_id, vehicle);

  if(isDefined(vspawner.usable))
    vehicle makevehicleusable();

  if(isDefined(vspawner.drivepath))
    vehicle.drivepath = vspawner.drivepath;

  if(isDefined(vspawner.deathfx))
    vehicle.deathfx = vspawner.deathfx;

  if(isDefined(vspawner.script_ignoreme))
    vehicle.script_ignoreme = vspawner.script_ignoreme;

  if(isDefined(vspawner.script_animname)) {
    vehicle.script_animname = vspawner.script_animname;
    vehicle.animname = vspawner.script_animname;
  }

  if(isDefined(vspawner.script_animscripted))
    vehicle.supportsanimscripted = vspawner.script_animscripted;

  if(isDefined(vspawner.fx_crash_effects))
    vehicle.fx_crash_effects = vspawner.fx_crash_effects;

  if(isDefined(vspawner.m_objective_model))
    vehicle.m_objective_model = vspawner.m_objective_model;

  if(vehicle.vteam == "axis" && isDefined(level.vehicle_enemy_tanks[vspawner.spawnermodel]))
    vehicle thread vehicledamageassist();

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

#using_animtree("vehicles");

vehicle_init(vehicle) {
  vehicle useanimtree(#animtree);

  if(isDefined(vehicle.e_dyn_path))
    vehicle.e_dyn_path linkto(vehicle);

  vehicle ent_flag_init("waiting_for_flag");
  vehicle.takedamage = !(isDefined(vehicle.script_godmode) && vehicle.script_godmode);
  vehicle.zerospeed = 1;

  if(!isDefined(vehicle.modeldummyon))
    vehicle.modeldummyon = 0;

  if(isDefined(vehicle.isphysicsvehicle) && vehicle.isphysicsvehicle) {
    if(isDefined(vehicle.script_brake) && vehicle.script_brake)
      vehicle setbrake(1);
  }

  type = vehicle.vehicletype;
  vehicle vehicle_life();
  vehicle thread vehicle_main();
  vehicle thread maingun_fx();
  vehicle.riders = [];
  vehicle.unloadque = [];

  if(!isDefined(vehicle.unload_group))
    vehicle.unload_group = "default";

  vehicle.getoutrig = [];

  if(isDefined(level.vehicle_attachedmodels) && isDefined(level.vehicle_attachedmodels[type])) {
    rigs = level.vehicle_attachedmodels[type];
    strings = getarraykeys(rigs);

    for(i = 0; i < strings.size; i++) {
      vehicle.getoutrig[strings[i]] = undefined;
      vehicle.getoutriganimating[strings[i]] = 0;
    }
  }

  if(isDefined(self.script_badplace))
    vehicle thread vehicle_badplace();

  if(isDefined(vehicle.script_lights_on) && vehicle.script_lights_on)
    vehicle lights_on();

  if(!vehicle ischeap())
    vehicle friendlyfire_shield();

  vehicle thread maps\_vehicle_aianim::handle_attached_guys();

  if(isDefined(vehicle.turretweapon) && vehicle.turretweapon != "")
    vehicle thread turret_shoot();

  if(isDefined(vehicle.script_physicsjolt) && vehicle.script_physicsjolt)
    vehicle thread physicsjolt_proximity();

  vehicle_levelstuff(vehicle);

  if(!vehicle ischeap() && !(vehicle.vehicleclass == "plane"))
    vehicle thread disconnect_paths_whenstopped();

  if(!isDefined(vehicle.script_nonmovingvehicle)) {
    if(isDefined(vehicle.target)) {
      path_start = getvehiclenode(vehicle.target, "targetname");

      if(!isDefined(path_start)) {
        path_start = getent(vehicle.target, "targetname");

        if(!isDefined(path_start))
          path_start = getstruct(vehicle.target, "targetname");
      }
    }

    if(isDefined(path_start) && vehicle.vehicletype != "inc_base_jump_spotlight")
      vehicle thread getonpath(path_start);
  }

  if(isDefined(vehicle.script_vehicleattackgroup))
    vehicle thread attackgroup_think();

  if(isDefined(vehicle.script_recordent) && vehicle.script_recordent)
    recordent(vehicle);

  if(vehicle hashelicopterdustkickup()) {
    if(!level.clientscripts)
      vehicle thread aircraft_dust_kickup();
  }

  vehicle thread debug_vehicle();

  vehicle spawn_ai_group();
  vehicle thread maps\_vehicle_death::main();

  if(isDefined(vehicle.script_targetset) && vehicle.script_targetset == 1) {
    offset = (0, 0, 0);

    if(isDefined(vehicle.script_targetoffset))
      offset = vehicle.script_targetoffset;

    target_set(vehicle, offset);
  }

  if(isDefined(vehicle.script_vehicleavoidance) && vehicle.script_vehicleavoidance == 1)
    vehicle setvehicleavoidance(1);

  vehicle enable_turrets();

  if(isDefined(level.vehiclespawncallbackthread))
    level thread[[level.vehiclespawncallbackthread]](vehicle);
}

detach_getoutrigs() {
  if(!isDefined(self.getoutrig)) {
    return;
  }
  if(!self.getoutrig.size) {
    return;
  }
  keys = getarraykeys(self.getoutrig);

  for(i = 0; i < keys.size; i++)
    self.getoutrig[keys[i]] unlink();
}

enable_turrets(veh) {
  if(!isDefined(veh))
    veh = self;

  if(isDefined(self.script_enable_turret0) && self.script_enable_turret0)
    veh maps\_turret::enable_turret(0);

  if(isDefined(self.script_enable_turret1) && self.script_enable_turret1)
    veh maps\_turret::enable_turret(1);

  if(isDefined(self.script_enable_turret2) && self.script_enable_turret2)
    veh maps\_turret::enable_turret(2);

  if(isDefined(self.script_enable_turret3) && self.script_enable_turret3)
    veh maps\_turret::enable_turret(3);

  if(isDefined(self.script_enable_turret4) && self.script_enable_turret4)
    veh maps\_turret::enable_turret(4);

  if(isDefined(self.script_enable_turret0) && !self.script_enable_turret0)
    veh maps\_turret::disable_turret(0);

  if(isDefined(self.script_enable_turret1) && !self.script_enable_turret1)
    veh maps\_turret::disable_turret(1);

  if(isDefined(self.script_enable_turret2) && !self.script_enable_turret2)
    veh maps\_turret::disable_turret(2);

  if(isDefined(self.script_enable_turret3) && !self.script_enable_turret3)
    veh maps\_turret::disable_turret(3);

  if(isDefined(self.script_enable_turret4) && !self.script_enable_turret4)
    veh maps\_turret::disable_turret(4);
}

disconnect_paths_whenstopped() {
  if(issentient(self)) {
    return;
  }
  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    self.dontdisconnectpaths = 1;
    return;
  }

  self endon("death");
  self endon("kill_disconnect_paths_forever");
  wait 1;

  while(isDefined(self)) {
    if(length(self.velocity) < 1) {
      if(!isDefined(self.dontdisconnectpaths))
        self vehicle_disconnectpaths_wrapper();

      self notify("speed_zero_path_disconnect");

      while(length(self.velocity) < 1)
        wait 1;
    }

    self vehicle_connectpaths_wrapper();

    while(length(self.velocity) > 1)
      wait 1;
  }
}

disconnect_paths_while_moving(interval) {
  if(issentient(self)) {
    return;
  }
  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    self.dontdisconnectpaths = 1;
    return;
  }

  self endon("death");
  self endon("kill_disconnect_paths_forever");

  while(isDefined(self)) {
    if(length(self.velocity) > 1) {
      if(!isDefined(self.dontdisconnectpaths))
        self vehicle_disconnectpaths_wrapper();

      self notify("moving_path_disconnect");
    }

    wait(interval);
  }
}

vehicle_setspeed(speed, rate, msg) {
  if(self getspeedmph() == 0 && speed == 0) {
    return;
  }
  self thread debug_vehiclesetspeed(speed, rate, msg);

  self setspeed(speed, rate);
}

debug_vehiclesetspeed(speed, rate, msg) {
  self notify("new debug_vehiclesetspeed");
  self endon("new debug_vehiclesetspeed");
  self endon("resuming speed");
  self endon("death");

  while(true) {
    while(getdvar(#"_id_7E7B1968") != "off") {
      print3d(self.origin + vectorscale((0, 0, 1), 192.0), "vehicle setspeed: " + msg, (1, 1, 1), 1, 3);
      wait 0.05;
    }

    wait 0.5;
  }

}

script_resumespeed(msg, rate) {
  self endon("death");
  fsetspeed = 0;
  type = "resumespeed";

  if(!isDefined(self.resumemsgs))
    self.resumemsgs = [];

  if(isDefined(self.waitingforgate) && self.waitingforgate) {
    return;
  }
  if(isDefined(self.attacking) && self.attacking) {
    fsetspeed = self.attackspeed;
    type = "setspeed";
  }

  self.zerospeed = 0;

  if(fsetspeed == 0)
    self.zerospeed = 1;

  if(type == "resumespeed")
    self resumespeed(rate);
  else if(type == "setspeed")
    self vehicle_setspeed(fsetspeed, 15, "resume setspeed from attack");

  self notify("resuming speed");

  self thread debug_vehicleresume(msg + " :" + type);
}

debug_vehicleresume(msg) {
  if(getdvar(#"_id_95A4535C") == "off") {
    return;
  }
  self endon("death");
  number = self.resumemsgs.size;
  self.resumemsgs[number] = msg;
  self thread print_resumespeed(gettime() + 3 * 1000);
  wait 3;
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

  while(gettime() < timer && isDefined(self.resumemsgs)) {
    if(self.resumemsgs.size > 6)
      start = self.resumemsgs.size - 5;
    else
      start = 0;

    for(i = start; i < self.resumemsgs.size; i++) {
      position = i * 32;

      print3d(self.origin + (0, 0, position), "resuming speed: " + self.resumemsgs[i], (0, 1, 0), 1, 3);

    }

    wait 0.05;
  }
}

godon() {
  self.takedamage = 0;
}

godoff() {
  self.takedamage = 1;
}

getnormalanimtime(animation) {
  animtime = self getanimtime(animation);
  animlength = getanimlength(animation);

  if(animtime == 0)
    return 0;

  return self getanimtime(animation) / getanimlength(animation);
}

setup_dynamic_detour(pathnode, get_func) {
  prevnode = [[get_func]](pathnode.targetname);
  assert(isDefined(prevnode), "detour can't be on start node");
  prevnode.detoured = 0;
}

setup_ai() {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_vehicleride)) {
      level.vehicle_rideai = array_2dadd(level.vehicle_rideai, ai[i].script_vehicleride, ai[i]);
      continue;
    }

    if(isDefined(ai[i].script_vehiclewalk))
      level.vehicle_walkai = array_2dadd(level.vehicle_walkai, ai[i].script_vehiclewalk, ai[i]);
  }

  ai = getspawnerarray();

  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_vehicleride))
      level.vehicle_ridespawners = array_2dadd(level.vehicle_ridespawners, ai[i].script_vehicleride, ai[i]);

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
  processtrigger = 0;

  if(self has_spawnflag(1)) {
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
      processtrigger = 1;
    } else
      setup_groundnode_detour(self);

    level.vehicle_detourpaths = array_2dadd(level.vehicle_detourpaths, self.script_vehicledetour, self);

    if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2)
      println("more than two script_vehicledetour grouped in group number: ", self.script_vehicledetour);

  }

  if(isDefined(self.script_gatetrigger)) {
    level.vehicle_gatetrigger = array_2dadd(level.vehicle_gatetrigger, self.script_gatetrigger, self);
    self.gateopen = 0;
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

  if(isDefined(self.script_vehiclespawngroup) || isDefined(self.script_vehiclestartmove) || isDefined(self.script_gatetrigger) || isDefined(self.script_vehiclegroupdelete))
    processtrigger = 1;

  if(processtrigger)
    add_proccess_trigger(self);
}

setup_triggers() {
  level.vehicle_processtriggers = [];
  triggers = [];
  triggers = arraycombine(getallvehiclenodes(), getentarray("script_origin", "classname"), 1, 0);
  triggers = arraycombine(triggers, level.struct, 1, 0);
  triggers = arraycombine(triggers, get_triggers("trigger_radius", "trigger_multiple", "trigger_once", "trigger_lookat", "trigger_box"), 1, 0);
  array_thread(triggers, ::node_trigger_process);
}

setup_nodes() {
  a_nodes = getallvehiclenodes();

  foreach(node in a_nodes) {
    if(isDefined(node.script_flag_set)) {
      if(!level flag_exists(node.script_flag_set))
        flag_init(node.script_flag_set);
    }
  }
}

is_node_script_struct(node) {
  if(!isDefined(node.targetname))
    return 0;

  return isDefined(getstruct(node.targetname, "targetname"));
}

setup_vehicles(allvehiclesprespawn) {
  vehicles = allvehiclesprespawn;
  spawnvehicles = [];
  groups = [];
  nonspawned = [];

  for(i = 0; i < vehicles.size; i++) {
    vehicles[i] vehicle_load_assets();

    if(vehicles[i] has_spawnflag(2))
      assert(isDefined(vehicles[i].script_vehiclespawngroup), "Vehicle of type: " + vehicles[i].vehicletype + " has SPAWNER flag set, but is not part of a script_vehiclespawngroup or doesn't have a targetname.");

    if(isDefined(vehicles[i].script_vehiclespawngroup)) {
      if(!isDefined(spawnvehicles[vehicles[i].script_vehiclespawngroup]))
        spawnvehicles[vehicles[i].script_vehiclespawngroup] = [];

      spawnvehicles[vehicles[i].script_vehiclespawngroup][spawnvehicles[vehicles[i].script_vehiclespawngroup].size] = vehicles[i];
      addgroup[0] = vehicles[i].script_vehiclespawngroup;
      groups = arraycombine(groups, addgroup, 0, 0);
      continue;
    } else
      nonspawned[nonspawned.size] = vehicles[i];
  }

  for(i = 0; i < groups.size; i++)
    thread spawner_setup(spawnvehicles[groups[i]], groups[i]);

  foreach(veh in nonspawned) {
    if(isDefined(veh.script_team))
      veh.vteam = veh.script_team;

    veh vehicle_dynamic_cover();
    thread vehicle_init(veh);
  }
}

vehicle_life() {
  if(isDefined(self.destructibledef))
    self.health = 99999;
  else {
    type = self.vehicletype;

    if(isDefined(self.script_startinghealth))
      self.health = self.script_startinghealth;
    else if(self.healthdefault == -1)
      return;
    else if(isDefined(self.healthmin) && isDefined(self.healthmax) && self.healthmax - self.healthmin > 0)
      self.health = randomint(self.healthmax - self.healthmin) + self.healthmin;
    else
      self.health = self.healthdefault;
  }
}

vehicle_load_assets() {
  precachevehicle(self.vehicletype);
  precachemodel(self.model);

  if(isDefined(self.vehmodel))
    precachemodel(self.vehmodel);

  if(isDefined(self.vehmodelenemy))
    precachemodel(self.vehmodelenemy);

  if(isDefined(self.vehviewmodel))
    precachemodel(self.vehviewmodel);

  precache_extra_models();

  if(isDefined(self.deathmodel) && self.deathmodel != "")
    precache_death_model_wrapper(self.deathmodel);

  if(isDefined(self.shootshock) && self.shootshock != "") {
    precacheshader("black");
    precacheshellshock(self.shootshock);
  }

  if(isDefined(self.shootrumble) && self.shootrumble != "")
    precacherumble(self.shootrumble);

  if(isDefined(self.rumbletype) && self.rumbletype != "")
    precacherumble(self.rumbletype);

  if(isDefined(self.secturrettype) && self.secturrettype != "")
    precacheturret(self.secturrettype);

  if(isDefined(self.secturretmodel) && self.secturretmodel != "")
    precachemodel(self.secturretmodel);

  self vehicle_load_fx();
}

precache_extra_models() {
  switch (self.vehicletype) {
    case "heli_huey":
    case "heli_huey_assault":
    case "heli_huey_gunship":
    case "heli_huey_heavyhog":
    case "heli_huey_heavyhog_creek":
    case "heli_huey_medivac":
    case "heli_huey_medivac_khesanh":
    case "heli_huey_player":
    case "heli_huey_side_minigun":
    case "heli_huey_side_minigun_uwb":
    case "heli_huey_small":
    case "heli_huey_usmc":
    case "heli_huey_usmc_heavyhog_khesanh":
    case "heli_huey_usmc_khesanh":
    case "heli_huey_usmc_khesanh_std":
      self maps\_huey::precache_submodels();
      break;
    case "heli_hind_player":
      self maps\_hind_player::precache_models();
      self maps\_hind_player::precache_weapons();
      self maps\_hind_player::precache_hud();
      break;
    case "heli_blackhawk_rts":
    case "heli_blackhawk_rts_axis":
    case "heli_blackhawk_stealth":
    case "heli_blackhawk_stealth_axis":
    case "heli_blackhawk_stealth_la2":
      maps\_blackhawk::precache_extra_models();
      break;
    case "heli_hind":
    case "heli_hind_pakistan":
    case "heli_hind_so":
      maps\_hind::precache_extra_models();
      break;
    case "truck_gaz63_camorack":
      precachemodel("t5_veh_truck_gaz63_camo_rack");
      break;
    case "truck_gaz63_canvas":
    case "truck_gaz66_canvas":
      precachemodel("t5_veh_gaz66_flatbed");
      precachemodel("t5_veh_gaz66_flatbed_dead");
      precachemodel("t5_veh_gaz66_canvas");
      precachemodel("t5_veh_gaz66_canvas_dead");
      break;
    case "truck_gaz63_canvas_camorack":
      precachemodel("t5_veh_gaz66_troops");
      precachemodel("t5_veh_gaz66_troops_dead");
      precachemodel("t5_veh_gaz66_canvas");
      precachemodel("t5_veh_gaz66_canvas_dead");
      precachemodel("t5_veh_truck_gaz63_camo_rack_back_canvas");
      precachemodel("t5_veh_truck_gaz63_camo_rack_dead");
      precachemodel("t5_veh_truck_gaz63_camo_rack_back");
      precachemodel("t5_veh_truck_gaz63_camo_rack_back_dead");
      break;
    case "truck_gaz63_flatbed":
    case "truck_gaz66_flatbed":
      precachemodel("t5_veh_gaz66_flatbed");
      precachemodel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_flatbed_camorack":
      precachemodel("t5_veh_gaz66_flatbed");
      precachemodel("t5_veh_gaz66_flatbed_dead");
      precachemodel("t5_veh_truck_gaz63_camo_rack");
      precachemodel("t5_veh_truck_gaz63_camo_rack_dead");
      precachemodel("t5_veh_truck_gaz63_camo_rack_back");
      precachemodel("t5_veh_truck_gaz63_camo_rack_back_dead");
      break;
    case "truck_gaz63_tanker":
    case "truck_gaz66_tanker":
    case "truck_gaz66_tanker_physics":
      precachemodel("t5_veh_gaz66_tanker");
      precache_death_model_wrapper("t5_veh_gaz66_tanker_dead");
      break;
    case "truck_gaz63_troops":
    case "truck_gaz63_troops_bulletdamage":
    case "truck_gaz66_troops":
    case "truck_gaz66_troops_physics":
      precachemodel("t5_veh_gaz66_troops");
      precachemodel("t5_veh_gaz66_troops_dead");
      break;
    case "truck_gaz63_troops_camorack":
      precachemodel("t5_veh_gaz66_troops");
      precachemodel("t5_veh_gaz66_troops_dead");
      precachemodel("t5_veh_truck_gaz63_camo_rack");
      precachemodel("t5_veh_truck_gaz63_camo_rack_dead");
      precachemodel("t5_veh_truck_gaz63_camo_rack_back");
      precachemodel("t5_veh_truck_gaz63_camo_rack_back_dead");
      break;
    case "truck_gaz66_troops_attacking_physics":
      precachemodel("t5_veh_gaz66_troops_no_benches");
      precachemodel("t5_veh_gaz66_troops_dead");
      break;
    case "truck_gaz63_single50":
    case "truck_gaz66_single50":
      precachemodel("t5_veh_gaz66_single50");
      precachemodel("t5_veh_gaz66_single50_dead");
      precachemodel("t5_veh_gaz66_flatbed");
      precachemodel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_player_single50":
    case "truck_gaz63_player_single50_bulletdamage":
    case "truck_gaz63_player_single50_physics":
    case "truck_gaz66_player_single50":
      precachemodel("t5_veh_gunner_turret_enemy_50cal");
      precachemodel("t5_veh_gaz66_flatbed");
      precachemodel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_player_single50_nodeath":
      precachemodel("t5_veh_gunner_turret_enemy_50cal");
      precachemodel("t5_veh_gaz66_flatbed");
      break;
    case "truck_gaz63_quad50":
    case "truck_gaz66_quad50":
      precachemodel("t5_veh_gaz66_quad50");
      precachemodel("t5_veh_gaz66_quad50_dead");
      precachemodel("t5_veh_gaz66_flatbed");
      precachemodel("t5_veh_gaz66_flatbed_dead");
      break;
    case "truck_gaz63_camorack_low":
      precachemodel("t5_veh_truck_gaz63_camo_rack_low");
      break;
    case "truck_gaz63_canvas_low":
      precachemodel("t5_veh_gaz66_flatbed_low");
      precachemodel("t5_veh_gaz66_flatbed_dead_low");
      precachemodel("t5_veh_gaz66_canvas_low");
      precachemodel("t5_veh_gaz66_canvas_dead_low");
      break;
    case "truck_gaz63_flatbed_low":
      precachemodel("t5_veh_gaz66_flatbed_low");
      precachemodel("t5_veh_gaz66_flatbed_dead_low");
      break;
    case "truck_gaz63_tanker_low":
      precachemodel("t5_veh_gaz66_tanker_low");
      precachemodel("t5_veh_gaz66_tanker_dead_low");
      break;
    case "truck_gaz63_troops_low":
      precachemodel("t5_veh_gaz66_troops_low");
      precachemodel("t5_veh_gaz66_troops_dead_low");
      break;
    case "truck_gaz63_single50_low":
      precachemodel("t5_veh_gaz66_single50_low");
      precachemodel("t5_veh_gaz66_single50_dead_low");
      precachemodel("t5_veh_gaz66_flatbed_low");
      precachemodel("t5_veh_gaz66_flatbed_dead_low");
      break;
    case "truck_gaz63_quad50_low":
      precachemodel("t5_veh_gaz66_quad50_low");
      precachemodel("t5_veh_gaz66_quad50_dead_low");
      precachemodel("t5_veh_gaz66_flatbed_low");
      precachemodel("t5_veh_gaz66_flatbed_dead_low");
      break;
    case "truck_gaz63_quad50_low_no_deathmodel":
      precachemodel("t5_veh_gaz66_quad50_low");
      break;
    case "tank_snowcat_plow":
      precachemodel("t5_veh_snowcat_plow");
      break;
    case "boat_pbr":
      precachemodel("t5_veh_boat_pbr_set01_friendly");
      precachemodel("t5_veh_boat_pbr_waterbox");
      break;
    case "boat_pbr_medium":
    case "boat_pbr_medium_breakable":
      precachemodel("veh_t6_sea_gunboat_medium_damaged");
      precachemodel("veh_t6_sea_gunboat_medium_wheelhouse_dmg0");
      precachemodel("veh_t6_sea_gunboat_medium_wheelhouse_dmg1");
      precachemodel("veh_t6_sea_gunboat_medium_wheelhouse_dmg2");
      precachemodel("veh_t6_sea_gunboat_medium_rear_dmg0");
      precachemodel("veh_t6_sea_gunboat_medium_rear_dmg1");
      precachemodel("veh_t6_sea_gunboat_medium_rear_dmg2");
      break;
    case "boat_pbr_player":
      precachemodel("t5_veh_boat_pbr_set01");
      precachemodel("t5_veh_boat_pbr_stuff");
      break;
    case "drone_avenger":
    case "drone_avenger_fast":
    case "drone_avenger_fast_la2":
      maps\_avenger::precache_extra_models();
      break;
    case "drone_avenger_fast_la2_2x":
      maps\_avenger::precache_extra_models(1);
      break;
    case "drone_pegasus":
    case "drone_pegasus_fast":
    case "drone_pegasus_fast_la2":
    case "drone_pegasus_low":
    case "drone_pegasus_low_la2":
      maps\_pegasus::precache_extra_models();
      break;
    case "drone_pegasus_fast_la2_2x":
      maps\_pegasus::precache_extra_models(1);
      break;
    case "plane_f35":
    case "plane_f35_fast":
    case "plane_f35_fast_la2":
    case "plane_f35_vtol":
    case "plane_f35_vtol_nocockpit":
    case "plane_fa38_hero":
      maps\_f35::precache_extra_models();
      break;
    case "heli_osprey":
    case "heli_osprey_pakistan":
    case "heli_osprey_rts_axis":
    case "heli_v78":
    case "heli_v78_blackout":
    case "heli_v78_blackout_low":
    case "heli_v78_rts":
    case "heli_v78_yemen":
      maps\_osprey::precache_extra_models();
      break;
  }
}

vehicle_load_fx() {
  if(isDefined(self.exhaustfxname) && self.exhaustfxname != "")
    loadfx(self.exhaustfxname);

  maps\_treadfx::loadtreadfx(self);

  if(isDefined(self.deathfxname) && self.deathfxname != "")
    self.deathfx = loadfx(self.deathfxname);

  if(isDefined(self._vehicle_load_fx))
    self[[self._vehicle_load_fx]]();

  if(isDefined(level._vehicle_load_fx)) {
    if(isDefined(level._vehicle_load_fx[self.vehicletype]))
      self[[level._vehicle_load_fx[self.vehicletype]]]();
  }
}

vehicle_add_loadfx_callback(vehicletype, load_fx) {
  if(!isDefined(level._vehicle_load_fx))
    level._vehicle_load_fx = [];

  if(isDefined(level._vehicle_load_fx[vehicletype]))
    println("WARNING! LoadFX callback function for vehicle " + vehicletype + " already exists. Proceeding with override");

  level._vehicle_load_fx[vehicletype] = load_fx;
}

ischeap() {
  if(!isDefined(self.script_cheap))
    return false;

  if(!self.script_cheap)
    return false;

  return true;
}

hashelicopterdustkickup() {
  if(!(self.vehicleclass == "plane"))
    return false;

  if(ischeap())
    return false;

  return true;
}

playloopedfxontag(effect, durration, tag) {
  emodel = get_dummy();
  effectorigin = spawn("script_origin", emodel.origin);
  self endon("fire_extinguish");
  thread playloopedfxontag_originupdate(tag, effectorigin);

  while(true) {
    playfx(effect, effectorigin.origin, effectorigin.upvec);
    wait(durration);
  }
}

playloopedfxontag_originupdate(tag, effectorigin) {
  effectorigin.angles = self gettagangles(tag);
  effectorigin.origin = self gettagorigin(tag);
  effectorigin.forwardvec = anglestoforward(effectorigin.angles);
  effectorigin.upvec = anglestoup(effectorigin.angles);

  while(isDefined(self) && self.classname == "script_vehicle" && self getspeedmph() > 0) {
    emodel = get_dummy();
    effectorigin.angles = emodel gettagangles(tag);
    effectorigin.origin = emodel gettagorigin(tag);
    effectorigin.forwardvec = anglestoforward(effectorigin.angles);
    effectorigin.upvec = anglestoup(effectorigin.angles);
    wait 0.05;
  }
}

setup_dvars() {
  if(getdvar(#"_id_95A4535C") == "")
    setdvar("debug_vehicleresume", "off");

  if(getdvar(#"_id_7E7B1968") == "")
    setdvar("debug_vehiclesetspeed", "off");
}

setup_levelvars() {
  level.vehicle_resumespeed = 5;
  level.vehicle_deletegroup = [];
  level.vehicle_spawngroup = [];
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
  level.vehicle_spawners = [];
  level.vehicle_walkercount = [];
  level.helicopter_crash_locations = getentarray("helicopter_crash_location", "targetname");
  level.playervehicle = spawn("script_origin", (0, 0, 0));
  level.playervehiclenone = level.playervehicle;

  if(!isDefined(level.vehicle_death_thread))
    level.vehicle_death_thread = [];

  if(!isDefined(level.vehicle_driveidle))
    level.vehicle_driveidle = [];

  if(!isDefined(level.vehicle_driveidle_r))
    level.vehicle_driveidle_r = [];

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

  if(!isDefined(level.vehicle_isstationary))
    level.vehicle_isstationary = [];

  if(!isDefined(level.vehicle_compassicon))
    level.vehicle_compassicon = [];

  if(!isDefined(level.vehicle_unloadgroups))
    level.vehicle_unloadgroups = [];

  if(!isDefined(level.vehicle_aianims))
    level.vehicle_aianims = [];

  if(!isDefined(level.vehicle_unloadwhenattacked))
    level.vehicle_unloadwhenattacked = [];

  if(!isDefined(level.vehicle_deckdust))
    level.vehicle_deckdust = [];

  if(!isDefined(level.vehicle_types))
    level.vehicle_types = [];

  if(!isDefined(level.vehicle_compass_types))
    level.vehicle_compass_types = [];

  if(!isDefined(level.vehicle_bulletshield))
    level.vehicle_bulletshield = [];

  if(!isDefined(level.vehicle_death_badplace))
    level.vehicle_death_badplace = [];

  maps\_vehicle_aianim::setup_aianimthreads();
}

attacker_isonmyteam(attacker) {
  if(isDefined(attacker) && isDefined(attacker.vteam) && isDefined(self.vteam) && attacker.vteam == self.vteam)
    return true;
  else
    return false;
}

attacker_troop_isonmyteam(attacker) {
  if(isDefined(self.vteam) && self.vteam == "allies" && isDefined(attacker) && isDefined(level.player) && attacker == level.player)
    return true;
  else if(isai(attacker) && attacker.team == self.vteam)
    return true;
  else
    return false;
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
  self.friendlyfire_shield = 1;

  if(isDefined(level.vehicle_bulletshield[self.vehicletype]) && !isDefined(self.script_bulletshield))
    self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
}

friendlyfire_shield_callback(attacker, amount, type) {
  if(!isDefined(self.friendlyfire_shield) || !self.friendlyfire_shield)
    return false;

  if(!isDefined(attacker) && self.vteam != "neutral" || attacker_isonmyteam(attacker) || attacker_troop_isonmyteam(attacker) || isdestructible() || bulletshielded(type))
    return true;

  return false;
}

vehicle_dynamic_cover(s_spawner) {
  if(isDefined(self.targetname)) {
    ent = getent(self.targetname, "target");

    if(isDefined(ent)) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "dynamic_cover")
        e_dyn_path = ent;
    }
  }

  if(isDefined(e_dyn_path)) {
    if(isDefined(s_spawner))
      s_spawner.e_dyn_path = e_dyn_path;
    else
      self.e_dyn_path = e_dyn_path;
  } else
    e_dyn_path = self;

  e_dyn_path delay_thread(0.05, maps\_dynamic_nodes::entity_grab_attached_dynamic_nodes, !isDefined(s_spawner));
}

vehicle_badplace() {
  self endon("kill_badplace_forever");
  self endon("death");
  self endon("delete");

  if(isDefined(level.custombadplacethread)) {
    self thread[[level.custombadplacethread]]();
    return;
  }

  hasturret = isDefined(self.turretweapon) && self.turretweapon != "";

  while(true) {
    if(!self.script_badplace) {
      while(!self.script_badplace)
        wait 0.5;
    }

    speed = self getspeedmph();

    if(speed <= 0) {
      wait 0.5;
      continue;
    }

    if(speed < 5)
      bp_radius = 200;
    else if(speed > 5 && speed < 8)
      bp_radius = 350;
    else
      bp_radius = 500;

    if(isDefined(self.badplacemodifier))
      bp_radius = bp_radius * self.badplacemodifier;

    if(hasturret)
      bp_direction = anglestoforward(self gettagangles("tag_turret"));
    else
      bp_direction = anglestoforward(self.angles);

    badplace_arc("", 0.5, self.origin, bp_radius * 1.9, 300, bp_direction, 17, 17, "allies", "axis");
    badplace_cylinder("", 0.5, self.origin, 200, 300, "allies", "axis");
    wait(0.5 + 0.05);
  }
}

turret_shoot() {
  self endon("death");
  self endon("stop_turret_shoot");
  self.weapon_fire_time = 0;
  str_weapon = self seatgetweapon(0);

  if(isDefined(str_weapon))
    weapon_fire_time = weaponfiretime(str_weapon);

  while(self.health > 0) {
    self waittill("turret_fire");
    self notify("groupedanimevent", "turret_fire");
    self fireweapon();
    luinotifyevent(&"hud_vehicle_turret_fire", 1, int(weapon_fire_time * 1000));
  }
}

vehicle_handleunloadevent() {
  self notify("vehicle_handleunloadevent");
  self endon("vehicle_handleunloadevent");
  self endon("death");
  type = self.vehicletype;

  while(true) {
    self waittill("unload", who);
    self notify("groupedanimevent", "unload");
  }
}

get_vehiclenode_any_dynamic(target) {
  path_start = getvehiclenode(target, "targetname");

  if(!isDefined(path_start))
    path_start = getent(target, "targetname");
  else if(self.vehicleclass == "plane") {
    println("helicopter node targetname: " + path_start.targetname);
    println("vehicletype: " + self.vehicletype);

    assertmsg("helicopter on vehicle path( see console for info )");

  }

  if(!isDefined(path_start))
    path_start = getstruct(target, "targetname");

  return path_start;
}

vehicle_resumepathvehicle() {
  if(isDefined(self.currentnode.target))
    node = get_vehiclenode_any_dynamic(self.currentnode.target);

  if(isDefined(node)) {
    self resumespeed(35);
    vehicle_paths(node);
  }
}

vehicle_landvehicle() {
  self setneargoalnotifydist(2);
  self sethoverparams(0, 0, 10);
  self cleargoalyaw();
  self settargetyaw(flat_angle(self.angles)[1]);
  self setvehgoalpos_wrap(bullettrace(self.origin, self.origin + vectorscale((0, 0, -1), 100000.0), 0, self)["position"], 1);
  self waittill("goal");
}

setvehgoalpos_wrap(origin, bstop) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.originheightoffset))
    origin = origin + (0, 0, self.originheightoffset);

  self setvehgoalpos(origin, bstop);
}

vehicle_liftoffvehicle(height) {
  if(!isDefined(height))
    height = 512;

  dest = self.origin + (0, 0, height);
  self setneargoalnotifydist(10);
  self setvehgoalpos_wrap(dest, 1);
  self waittill("goal");
}

waittill_stable() {
  timer = gettime() + 400;

  while(isDefined(self)) {
    if(self.angles[0] > 12 || self.angles[0] < -1 * 12)
      timer = gettime() + 400;

    if(self.angles[2] > 12 || self.angles[2] < -1 * 12)
      timer = gettime() + 400;

    if(gettime() > timer) {
      break;
    }

    wait 0.05;
  }
}

unload_node(node) {
  if(isDefined(self.custom_unload_function)) {
    [
      [self.custom_unload_function]
    ]();
    return;
  }

  vehicle_pause_path();

  if(self.riders.size > 0) {
    pathnode = getnode(node.targetname, "target");

    if(isDefined(pathnode)) {
      foreach(ai_rider in self.riders) {
        if(isai(ai_rider))
          ai_rider thread maps\_spawner::go_to_node(pathnode);
      }
    }
  }

  if(self.vehicleclass == "plane")
    waittill_stable();
  else if(self.vehicleclass == "helicopter") {
    self sethoverparams(0, 0, 10);
    waittill_stable();
  }

  self notify("unload", node.script_unload);

  if(maps\_vehicle_aianim::riders_unloadable(node.script_unload) || isDefined(self.custom_unload) && self.custom_unload)
    self waittill("unloaded");
}

unload_node_helicopter(node) {
  if(isDefined(self.custom_unload_function))
    self thread[[self.custom_unload_function]]();

  self sethoverparams(0, 0, 10);
  goal = self.nextnode.origin;
  start = self.nextnode.origin;
  end = start - vectorscale((0, 0, 1), 10000.0);
  trace = bullettrace(start, end, 0, undefined, 1);

  if(trace["fraction"] <= 1)
    goal = (trace["position"][0], trace["position"][1], trace["position"][2] + self.fastropeoffset);

  drop_offset_tag = "tag_fastrope_ri";

  if(isDefined(self.drop_offset_tag))
    drop_offset_tag = self.drop_offset_tag;

  drop_offset = self gettagorigin("tag_origin") - self gettagorigin(drop_offset_tag);
  goal = goal + (drop_offset[0], drop_offset[1], 0);
  self setvehgoalpos(goal, 1);
  self waittill("goal");
  self notify("unload", self.nextnode.script_unload);
  self waittill("unloaded");
}

vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");
  self setgoalyaw(flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + vectorscale((0, 0, 1), 4.0), 1);
}

setup_targetname_spawners() {
  level.vehicle_targetname_array = [];
  vehicles = getentarray("script_vehicle", "classname");
  highestgroup = 0;

  for(i = 0; i < vehicles.size; i++) {
    vehicle = vehicles[i];

    if(isDefined(vehicle.script_vehiclespawngroup)) {
      if(vehicle.script_vehiclespawngroup > highestgroup)
        highestgroup = vehicle.script_vehiclespawngroup;
    }
  }

  for(i = 0; i < vehicles.size; i++) {
    vehicle = vehicles[i];

    if(isDefined(vehicle.targetname) && vehicle has_spawnflag(2)) {
      if(!isDefined(vehicle.script_vehiclespawngroup)) {
        highestgroup++;
        vehicle.script_vehiclespawngroup = highestgroup;
      }

      if(!isDefined(level.vehicle_targetname_array[vehicle.targetname]))
        level.vehicle_targetname_array[vehicle.targetname] = [];

      level.vehicle_targetname_array[vehicle.targetname][vehicle.script_vehiclespawngroup] = 1;
    }
  }
}

spawn_vehicles_from_targetname(name, b_supress_assert) {
  if(!isDefined(b_supress_assert))
    b_supress_assert = 0;

  assert(b_supress_assert || isDefined(level.vehicle_targetname_array[name]), "No vehicle spawners had targetname " + name);
  vehicles = [];

  if(isDefined(level.vehicle_targetname_array[name])) {
    array = level.vehicle_targetname_array[name];

    if(array.size > 0) {
      keys = getarraykeys(array);

      foreach(key in keys) {
        vehicle_array = scripted_spawn(key);
        vehicles = arraycombine(vehicles, vehicle_array, 1, 0);
      }
    }
  }

  return vehicles;
}

spawn_vehicle_from_targetname(name, b_supress_assert) {
  if(!isDefined(b_supress_assert))
    b_supress_assert = 0;

  vehicle_array = spawn_vehicles_from_targetname(name, b_supress_assert);
  assert(b_supress_assert || vehicle_array.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehicle_array.size + " vehicles, instead of 1");

  if(vehicle_array.size > 0)
    return vehicle_array[0];
}

spawn_vehicle_from_targetname_and_drive(name) {
  vehiclearray = spawn_vehicles_from_targetname(name);
  assert(vehiclearray.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehiclearray.size + " vehicles, instead of 1");
  vehiclearray[0] thread gopath();
  return vehiclearray[0];
}

spawn_vehicles_from_targetname_and_drive(name) {
  vehiclearray = spawn_vehicles_from_targetname(name);

  for(i = 0; i < vehiclearray.size; i++)
    vehiclearray[i] thread gopath();

  return vehiclearray;
}

aircraft_dust_kickup(model) {
  self endon("death");
  self endon("death_finished");
  self endon("stop_kicking_up_dust");
  assert(isDefined(self.vehicletype));
  dotracethisframe = 3;
  repeatrate = 1.0;
  trace = undefined;
  d = undefined;
  trace_ent = self;

  if(isDefined(model))
    trace_ent = model;

  while(isDefined(self)) {
    if(repeatrate <= 0)
      repeatrate = 1.0;

    wait(repeatrate);

    if(!isDefined(self)) {
      return;
    }
    dotracethisframe--;

    if(dotracethisframe <= 0) {
      dotracethisframe = 3;
      trace = bullettrace(trace_ent.origin, trace_ent.origin - vectorscale((0, 0, 1), 100000.0), 0, trace_ent);
      d = distance(trace_ent.origin, trace["position"]);
      repeatrate = (d - 350) / (1200 - 350) * (0.15 - 0.05) + 0.05;
    }

    if(!isDefined(trace)) {
      continue;
    }
    assert(isDefined(d));

    if(d > 1200) {
      repeatrate = 1.0;
      continue;
    }

    if(isDefined(trace["entity"])) {
      repeatrate = 1.0;
      continue;
    }

    if(!isDefined(trace["position"])) {
      repeatrate = 1.0;
      continue;
    }

    if(!isDefined(trace["surfacetype"]))
      trace["surfacetype"] = "dirt";

    assert(isDefined(level._vehicle_effect[self.vehicletype]), self.vehicletype + " vehicle script hasn't run _tradfx properly");
    assert(isDefined(level._vehicle_effect[self.vehicletype][trace["surfacetype"]]), "UNKNOWN SURFACE TYPE: " + trace["surfacetype"]);

    if(level._vehicle_effect[self.vehicletype][trace["surfacetype"]] != -1)
      playfx(level._vehicle_effect[self.vehicletype][trace["surfacetype"]], trace["position"]);
  }
}

maingun_fx() {
  if(!isDefined(level.vehicle_deckdust[self.model])) {
    return;
  }
  self endon("death");

  while(true) {
    self waittill("weapon_fired");
    playfxontag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
    barrel_origin = self gettagorigin("tag_flash");
    ground = physicstrace(barrel_origin, barrel_origin + vectorscale((0, 0, -1), 128.0));
    physicsexplosionsphere(ground, 192, 100, 1);
  }
}

lights_on() {
  self clearclientflag(10);
}

lights_off() {
  self setclientflag(10);
}

build_drive(forward, reverse, normalspeed, rate) {
  if(!isDefined(normalspeed))
    normalspeed = 10;

  level.vehicle_driveidle[self.model] = forward;

  if(isDefined(reverse))
    level.vehicle_driveidle_r[self.model] = reverse;

  level.vehicle_driveidle_normal_speed[self.model] = normalspeed;

  if(isDefined(rate))
    level.vehicle_driveidle_animrate[self.model] = rate;
}

build_aianims(aithread, vehiclethread) {
  level.vehicle_aianims[self.vehicletype] = [[aithread]]();

  if(isDefined(vehiclethread))
    level.vehicle_aianims[self.vehicletype] = [
      [vehiclethread]
    ](level.vehicle_aianims[self.vehicletype]);
}

build_attach_models(modelsthread) {
  level.vehicle_attachedmodels[self.vehicletype] = [[modelsthread]]();
}

build_unload_groups(unloadgroupsthread) {
  level.vehicle_unloadgroups[self.vehicletype] = [[unloadgroupsthread]]();
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

isdestructible() {
  return isDefined(self.destructible_type);
}

attackgroup_think() {
  self endon("death");
  self endon("switch group");
  self endon("killed all targets");

  if(isDefined(self.script_vehicleattackgroupwait))
    wait(self.script_vehicleattackgroupwait);

  for(;;) {
    group = getentarray("script_vehicle", "classname");
    valid_targets = [];

    for(i = 0; i < group.size; i++) {
      if(!isDefined(group[i].script_vehiclespawngroup)) {
        continue;
      }
      if(group[i].script_vehiclespawngroup == self.script_vehicleattackgroup) {
        if(group[i].vteam != self.vteam)
          valid_targets[valid_targets.size] = group[i];
      }
    }

    if(valid_targets.size == 0) {
      wait 0.5;
      continue;
    }

    for(;;) {
      current_target = undefined;

      if(valid_targets.size != 0)
        current_target = self get_nearest_target(valid_targets);
      else
        self notify("killed all targets");

      if(current_target.health <= 0) {
        arrayremovevalue(valid_targets, current_target);
        continue;
      } else {
        self setturrettargetent(current_target, vectorscale((0, 0, 1), 50.0));

        if(isDefined(self.fire_delay_min) && isDefined(self.fire_delay_max)) {
          if(self.fire_delay_max < self.fire_delay_min)
            self.fire_delay_max = self.fire_delay_min;

          wait(randomintrange(self.fire_delay_min, self.fire_delay_max));
        } else
          wait(randomintrange(4, 6));

        self fireweapon();
      }
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
  self endon("death");

  if(getdvar(#"_id_999365E0") == "")
    setdvar("debug_vehicle_health", "0");

  while(true) {
    if(getdvarint(#"_id_999365E0") > 0)
      print3d(self.origin, "Health: " + self.health, (1, 1, 1), 1, 3);

    wait 0.05;
  }

}

debug_vehicle_paths() {
  self endon("death");
  self endon("newpath");
  self endon("reached_dynamic_path_end");
  nextnode = self.currentnode;

  while(true) {
    if(getdvarint(#"_id_6A0F794A") > 0) {
      recordline(self.origin, self.currentnode.origin, (1, 0, 0), "Script", self);
      recordline(self.origin, nextnode.origin, (0, 1, 0), "Script", self);
      recordline(self.currentnode.origin, nextnode.origin, (1, 1, 1), "Script", self);
    }

    wait 0.05;

    if(isDefined(self.nextnode) && self.nextnode != nextnode)
      nextnode = self.nextnode;
  }

}

get_dummy() {
  if(self.modeldummyon)
    emodel = self.modeldummy;
  else
    emodel = self;

  return emodel;
}

vehicle_add_main_callback(vehicletype, main) {
  if(!isDefined(level.vehicle_main_callback))
    level.vehicle_main_callback = [];

  if(isDefined(level.vehicle_main_callback[vehicletype]))
    println("WARNING! Main callback function for vehicle " + vehicletype + " already exists. Proceeding with override");

  level.vehicle_main_callback[vehicletype] = main;
}

vehicle_main() {
  if(isDefined(level.vehicle_main_callback) && isDefined(level.vehicle_main_callback[self.vehicletype])) {
    if(!self has_spawnflag(2))
      self thread[[level.vehicle_main_callback[self.vehicletype]]]();
  }

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
    case "truck_gaz66":
    case "truck_gaz66_canvas":
    case "truck_gaz66_cargo":
    case "truck_gaz66_cargo_doors":
    case "truck_gaz66_flatbed":
    case "truck_gaz66_fuel":
    case "truck_gaz66_troops":
      self maps\_truck_gaz66::main();
      break;
    case "truck_gaz63":
    case "truck_gaz63_camorack":
    case "truck_gaz63_camorack_low":
    case "truck_gaz63_canvas":
    case "truck_gaz63_canvas_camorack":
    case "truck_gaz63_canvas_low":
    case "truck_gaz63_flatbed":
    case "truck_gaz63_flatbed_camorack":
    case "truck_gaz63_flatbed_low":
    case "truck_gaz63_low":
    case "truck_gaz63_player_single50":
    case "truck_gaz63_player_single50_bulletdamage":
    case "truck_gaz63_player_single50_nodeath":
    case "truck_gaz63_player_single50_physics":
    case "truck_gaz63_quad50":
    case "truck_gaz63_quad50_low":
    case "truck_gaz63_quad50_low_no_deathmodel":
    case "truck_gaz63_single50":
    case "truck_gaz63_single50_low":
    case "truck_gaz63_tanker":
    case "truck_gaz63_tanker_low":
    case "truck_gaz63_troops":
    case "truck_gaz63_troops_bulletdamage":
    case "truck_gaz63_troops_camorack":
    case "truck_gaz63_troops_low":
      self maps\_truck_gaz63::main();
      break;
    case "jeep_uaz":
    case "jeep_uaz_closetop":
      self maps\_uaz::main();
      break;
    case "jeep_intl":
    case "jeep_ultimate":
    case "jeep_willys":
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
    case "heli_hip_afghanistan":
    case "heli_hip_afghanistan_land":
    case "heli_hip_sidegun":
    case "heli_hip_sidegun_spotlight":
    case "heli_hip_sidegun_uwb":
      self maps\_hip::main();
      break;
    case "heli_pavelow":
    case "heli_pavelow_la2":
      self maps\_pavelow::main();
      break;
    case "heli_osprey":
    case "heli_osprey_pakistan":
    case "heli_osprey_rts_axis":
    case "heli_v78":
    case "heli_v78_blackout":
    case "heli_v78_blackout_low":
    case "heli_v78_rts":
    case "heli_v78_yemen":
      self maps\_osprey::main();
      break;
    case "heli_huey":
    case "heli_huey_assault":
    case "heli_huey_assault_river":
    case "heli_huey_gunship":
    case "heli_huey_gunship_river":
    case "heli_huey_heavyhog":
    case "heli_huey_heavyhog_creek":
    case "heli_huey_heavyhog_river":
    case "heli_huey_medivac":
    case "heli_huey_medivac_khesanh":
    case "heli_huey_medivac_river":
    case "heli_huey_minigun":
    case "heli_huey_player":
    case "heli_huey_side_minigun":
    case "heli_huey_side_minigun_uwb":
    case "heli_huey_small":
    case "heli_huey_usmc":
    case "heli_huey_usmc_gunship":
    case "heli_huey_usmc_heavyhog":
    case "heli_huey_usmc_heavyhog_khesanh":
    case "heli_huey_usmc_khesanh":
    case "heli_huey_usmc_khesanh_std":
    case "heli_huey_usmc_minigun":
    case "heli_huey_vista":
      self maps\_huey::main();
      break;
    case "heli_hind_player":
      self maps\_hind_player::main();
      break;
    case "heli_blackhawk_rts":
    case "heli_blackhawk_rts_axis":
    case "heli_blackhawk_stealth":
    case "heli_blackhawk_stealth_axis":
    case "heli_blackhawk_stealth_la2":
      self maps\_blackhawk::main();
      break;
    case "heli_hind":
    case "heli_hind_pakistan":
    case "heli_hind_so":
      self maps\_hind::main();
      break;
    case "heli_littlebird":
      self maps\_littlebird::main();
      break;
    case "plane_mig17":
    case "plane_mig23":
      self maps\_mig17::main();
      break;
    case "plane_phantom":
    case "plane_phantom_gearup_lowres":
      self maps\_mig17::main();
      break;
    case "wpn_zpu_antiair":
      self maps\_zpu_antiair::main();
      break;
    case "apc_bmp":
    case "apc_brt40":
    case "apc_m113":
    case "apc_m113_ally":
    case "apc_m113_axis":
    case "apc_m113_khesanh_outcasts":
    case "apc_m113_khesanh_plain":
    case "apc_m113_khesanh_warchicken":
      self maps\_apc::main();
      break;
    case "apc_buffel":
    case "apc_buffel_gun_turret":
    case "apc_buffel_gun_turret_nophysics":
      self maps\_apc_buffel::main();
      break;
    case "apc_btr40_flashpoint":
    case "apc_btr60":
    case "apc_btr60_grenade":
    case "apc_btr60_pakistan":
      self maps\_btr::main();
      break;
    case "apc_gaz_tigr":
    case "apc_gaz_tigr_monsoon":
    case "apc_gaz_tigr_pakistan":
    case "apc_gaz_tigr_wturret":
    case "apc_gaz_tigr_wturret_monsoon":
      self maps\_truck_gaztigr::main();
      break;
    case "civ_pickup":
    case "civ_pickup_4door":
    case "civ_pickup_wturret":
    case "civ_pickup_wturret_afghan":
    case "civ_pickup_wturret_angola":
    case "civ_pickup_wturret_beatup":
    case "civ_pickup_wturret_beatup_cartel":
    case "civ_pickup_wturret_panama":
    case "civ_technical_afgh":
      self maps\_civ_pickup::main();
      break;
    case "civ_pickup_red":
    case "civ_pickup_red_nophysics":
    case "civ_pickup_red_wturret":
    case "civ_pickup_red_wturret_la2":
    case "civ_pickup_red_wturret_light":
    case "civ_pickup_red_wturret_nophysics":
      self maps\_civ_pickup_big::main();
      break;
    case "civ_sedan_luxury":
    case "civ_tanker":
    case "civ_tanker_civ":
      self maps\_civ_vehicle::main();
      break;
    case "tiara":
      self maps\_tiara::main();
      break;
    case "civ_police":
    case "civ_police_light":
    case "civ_police_light_nophysics":
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
    case "boat_sampan":
    case "boat_sampan_pow":
      self maps\_sampan::main();
      break;
    case "motorcycle_lapd":
      self maps\_motorcycle_lapd::main();
      break;
    case "motorcycle_ai":
      self maps\_motorcycle::main();
      break;
    case "civ_van_sprinter":
    case "civ_van_sprinter_la2":
      self maps\_van::main();
      break;
    case "horse":
    case "horse_axis":
    case "horse_low":
    case "horse_player":
    case "horse_player_low":
    case "zhao_intro_horse":
      self maps\_horse::main();
      break;
    case "boat_soct_allies":
      self maps\_soct::main();
      break;
    default:
      break;
  }
}

vehicle_connectpaths_wrapper() {
  self connectpaths();

  if(isDefined(self.e_dyn_path))
    self.e_dyn_path maps\_dynamic_nodes::entity_disconnect_dynamic_nodes_from_navigation_mesh();
  else
    self maps\_dynamic_nodes::entity_disconnect_dynamic_nodes_from_navigation_mesh();
}

vehicle_disconnectpaths_wrapper() {
  if(isDefined(self.e_dyn_path))
    self.e_dyn_path thread maps\_dynamic_nodes::entity_connect_dynamic_nodes_to_navigation_mesh();
  else
    self thread maps\_dynamic_nodes::entity_connect_dynamic_nodes_to_navigation_mesh();

  self disconnectpaths();
}

stop() {
  if(!isDefined(self.emped))
    self notify("scripted");
}

defend(position, radius) {
  if(!isDefined(self.emped)) {
    old_goalpos = self.goalpos;
    self.goalpos = position;

    if(isDefined(radius))
      self.goalradius = radius;

    if(isDefined(level.quadrotor_forcegoal_if_closer))
      self notify("force_goal");

    self notify("main");
  }
}

vehicle_spawner_tool(allvehicles) {
  vehicletypes = [];

  foreach(veh in allvehicles)
  vehicletypes[veh.vehicletype] = veh.model;

  if(isassetloaded("vehicle", "civ_pickup_mini")) {
    veh = codespawnvehicle(1, "debug_spawn_vehicle", "civ_pickup_mini", vectorscale((0, 0, 1), 10000.0), (0, 0, 0));
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }

  if(isassetloaded("vehicle", "apc_cougar_player")) {
    veh = codespawnvehicle(1, "debug_spawn_vehicle", "apc_cougar_player", vectorscale((0, 0, 1), 10000.0), (0, 0, 0));
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }

  if(isassetloaded("vehicle", "rc_car_racer")) {
    veh = codespawnvehicle(1, "debug_spawn_vehicle", "rc_car_racer", vectorscale((0, 0, 1), 10000.0), (0, 0, 0));
    vehicletypes[veh.vehicletype] = veh.model;
    veh delete();
  }

  types = getarraykeys(vehicletypes);
  type_index = 0;

  while(true) {
    if(getdebugdvarint("debug_vehicle_spawn") > 0) {
      player = get_players()[0];
      dynamic_spawn_hud = newclienthudelem(player);
      dynamic_spawn_hud.alignx = "left";
      dynamic_spawn_hud.x = 20;
      dynamic_spawn_hud.y = 395;
      dynamic_spawn_hud.fontscale = 2;
      dynamic_spawn_dummy_model = spawn("script_model", (0, 0, 0));

      while(getdebugdvarint("debug_vehicle_spawn") > 0) {
        origin = player.origin + anglestoforward(player getplayerangles()) * 270.0;
        origin = origin + vectorscale((0, 0, 1), 40.0);

        if(player usebuttonpressed()) {
          dynamic_spawn_dummy_model hide();
          vehicle = codespawnvehicle(1, "debug_spawn_vehicle", types[type_index], origin, player.angles);
          vehicle_init(vehicle);
          vehicle makevehicleusable();

          if(getdebugdvarint("debug_vehicle_spawn") == 1) {
            setdvar("debug_vehicle_spawn", 0);
            continue;
          }

          wait 0.3;
        }

        if(player buttonpressed("DPAD_RIGHT")) {
          dynamic_spawn_dummy_model hide();
          type_index++;

          if(type_index >= types.size)
            type_index = 0;

          wait 0.3;
        }

        if(player buttonpressed("DPAD_LEFT")) {
          dynamic_spawn_dummy_model hide();
          type_index--;

          if(type_index < 0)
            type_index = types.size - 1;

          wait 0.3;
        }

        type = types[type_index];
        dynamic_spawn_hud settext("Press X to spawn vehicle " + type);
        dynamic_spawn_dummy_model setmodel(vehicletypes[type]);
        dynamic_spawn_dummy_model show();
        dynamic_spawn_dummy_model notsolid();
        dynamic_spawn_dummy_model.origin = origin;
        dynamic_spawn_dummy_model.angles = player.angles;
        wait 0.05;
      }

      dynamic_spawn_hud destroy();
      dynamic_spawn_dummy_model delete();
    }

    wait 2;
  }

}