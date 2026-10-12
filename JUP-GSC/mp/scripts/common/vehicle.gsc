/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_paths;
#using scripts\engine\utility;
#namespace vehicle;

function init_vehicles() {
  if(getdvarint(@ "hash_742caa13b3c2e685", 0)) {
    return;
  }

  if(isDefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }

  if(!add_init_script("vehicles", &init_vehicles)) {
    return;
  }

  thread init_vehicles_thread();
  cleanup_vt();
}

function cleanup_vt() {
  level.vtclassname = undefined;
  level.vtmodel = undefined;
  level.vttype = undefined;
}

function init_vehicles_thread() {
  create_lock("aircraft_wash_math");
  vehicle_setuplevelvariables();
  level.vehicle.helicopter_crash_locations = array_combine(level.vehicle.helicopter_crash_locations, getstructarray_delete("helicopter_crash_location", "targetname"));
  vehicle_setupspawners();
  allvehiclesprespawn = vehicle_precachescripts();
  setup_vehicles(allvehiclesprespawn);
  level.vehicle.has_vehicles = getEntArray("script_vehicle", "code_classname").size > 0;
  script_func("add_hint_string", "invulerable_frags", &"SCRIPT/INVULERABLE_FRAGS");
  script_func("add_hint_string", "invulerable_bullets", &"SCRIPT/INVULERABLE_BULLETS");
  script_func("add_hint_string", "enter_vehicle", &"SCRIPT/ENTER_VEHICLE");
  script_func("add_hint_string", "exit_vehicle", &"SCRIPT/EXIT_VEHICLE", &function_3e3d0013d3b2b92a);
}

function vehicle_paths(node, bhelicopterwaitforstart, var_cfa3aafb71b08d36) {
  return _vehicle_paths(node, bhelicopterwaitforstart, var_cfa3aafb71b08d36);
}

function vehicle_spawn(vspawner) {
  return vehicle_spawn_internal(vspawner);
}

function godon() {
  self.godmode = 1;
}

function godoff() {
  self.godmode = 0;
}

function function_7461e330c56d791e(parts) {
  if(!isarray(parts)) {
    parts = [parts];
  }

  self.var_9868a2f0e52a82bd = parts;
}

function function_20fc7af6688ea282(parts) {
  if(!isDefined(self.var_845b5beb82aa6bda)) {
    return;
  }

  if(!isarray(parts)) {
    parts = [parts];
  }

  self.var_9868a2f0e52a82bd = array_remove(parts, self.var_845b5beb82aa6bda);
}

function function_9ce59aa48970a667() {
  self.demigodmode = 1;
}

function function_7d7628da4296efab() {
  self.demigodmode = 0;
}

function mainturretoff() {
  return _mainturretoff();
}

function mainturreton() {
  return _mainturreton();
}

function mgoff() {
  return _mgoff();
}

function mgon() {
  return _mgon();
}

function isvehicle() {
  return isDefined(self.vehicletype);
}

function vehicle_is_crashing() {
  return vehicle_iscrashing();
}

function vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

function spawn_vehicles_from_targetname(targetname, var_a7333fc35fb3cc3a) {
  vehicles = [];
  spawners = getEntArray(targetname, "targetname");

  foreach(spawner in spawners) {
    if(!isDefined(spawner.code_classname) || spawner.code_classname != "script_vehicle") {
      continue;
    }

    if(isspawner(spawner)) {
      vehicle = vehicle_spawn_internal(spawner, var_a7333fc35fb3cc3a);

      if(istrue(var_a7333fc35fb3cc3a)) {
        vehicle waittill("vehicle_init_complete");
      }

      vehicles = array_add(vehicles, vehicle);
    }
  }

  assertex(vehicles.size, "<dev string:x1c>" + targetname);
  return vehicles;
}

function spawn_vehicle_from_targetname(name) {
  vehiclearray = spawn_vehicles_from_targetname(name);
  assertex(vehiclearray.size == 1, "<dev string:x43>" + name + "<dev string:x70>" + vehiclearray.size + "<dev string:x85>");
  return vehiclearray[0];
}

function spawn_vehicle_from_targetname_and_drive(name, var_a7333fc35fb3cc3a) {
  vehiclearray = spawn_vehicles_from_targetname(name, var_a7333fc35fb3cc3a);
  assertex(vehiclearray.size == 1, "<dev string:x43>" + name + "<dev string:x70>" + vehiclearray.size + "<dev string:x85>");
  thread gopath(vehiclearray[0]);
  return vehiclearray[0];
}

function spawn_vehicles_from_targetname_and_drive(name) {
  vehiclearray = spawn_vehicles_from_targetname(name);

  foreach(vehicle in vehiclearray) {
    thread gopath(vehicle);
  }

  return vehiclearray;
}

function aircraft_wash(model) {
  thread aircraft_wash_thread(model);
}

function vehicle_wheels_forward() {
  vehicle_setwheeldirection(1);
}

function vehicle_wheels_backward() {
  vehicle_setwheeldirection(0);
}

function vehicle_load_ai(ai, goddriver, group) {
  if(!isarray(ai)) {
    ai = [ai];
  }

  scripts\common\vehicle_aianim::load_ai(ai, goddriver, group);

  if(getdvarint(@ "hash_9403d7d31fc1d981")) {
    if(!self.usedpositions[0] && !istrue(self.player_drivable)) {
      assert(self.riders.size);
      riders = self.riders;
      vehicle_unload();
      scripts\engine\utility::ent_flag_wait("unloaded");
      riders = array_removedead(riders);
      riders = array_remove_array(riders, self.riders);

      if(riders.size > 0) {
        vehicle_load_ai(riders);
      }

      return;
    }

    vehicleanim = level.vehicle.templates.aianims[get_vehicle_classname()];

    if(isDefined(vehicleanim[0].death)) {
      foreach(rider in self.riders) {
        if(istrue(rider.drivingvehicle)) {
          thread scripts\common\vehicle_aianim::driverdead(rider);
        }
      }
    }
  }
}

function spawn_vehicle_and_gopath() {
  vehicle = utility::spawn_vehicle();

  if(isDefined(self.script_speed)) {
    if(!ishelicopter()) {
      vehicle vehicle_setspeed(self.script_speed);
    }
  }

  thread gopath(vehicle);
  return vehicle;
}

function attach_vehicle(node) {
  self vehicle_teleport(node.origin, node.angles);

  if(!ishelicopter()) {
    waitframe();
    self attachpath(node);
  }

  thread vehicle_paths(node, 1);
}

function attach_vehicle_and_gopath(node) {
  self vehicle_teleport(node.origin, node.angles);
  waitframe();

  if(!ishelicopter()) {
    self attachpath(node);
  }

  thread vehicle_paths(node);
  gopath(self);
}

function vehicle_get_riders_by_group(groupname) {
  group = [];
  assert(isDefined(self.vehicletype));
  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[classname])) {
    return group;
  }

  vehicles_groups = level.vehicle.templates.unloadgroups[classname];

  if(!isDefined(groupname)) {
    return group;
  }

  foreach(guy in self.riders) {
    assert(isDefined(guy.vehicle_position));

    foreach(groupid in vehicles_groups[groupname]) {
      if(guy.vehicle_position == groupid) {
        group[group.size] = guy;
      }
    }
  }

  return group;
}

function vehicle_unload(who) {
  return _vehicle_unload(who);
}

function vehicle_turret_scan_off() {
  self notify("stop_scanning_turret");
}

function vehicle_get_path_array() {
  self endon("death");
  apathnodes = [];
  estartnode = self.attachedpath;

  if(!isDefined(self.attachedpath)) {
    return apathnodes;
  }

  nextnode = estartnode;
  nextnode.counted = 0;

  while(isDefined(nextnode)) {
    if(isDefined(nextnode.counted) && nextnode.counted == 1) {
      break;
    }

    apathnodes = array_add(apathnodes, nextnode);
    nextnode.counted = 1;

    if(!isDefined(nextnode.target)) {
      break;
    }

    if(!ishelicopter()) {
      nextnode = getvehiclenode(nextnode.target, "targetname");
      continue;
    }

    nextnode = getent_or_struct(nextnode.target, "targetname");
  }

  return apathnodes;
}

function vehicle_lights_on(group, classname) {
  if(!isDefined(group)) {
    group = "all";
  }

  lights_on(group, classname);
}

function vehicle_lights_off(group, classname) {
  if(!isDefined(group)) {
    group = "all";
  }

  lights_off(group, classname);
}

function vehicle_switch_paths(next_node, target_node) {
  self setswitchnode(next_node, target_node);
  self.attachedpath = target_node;
  thread vehicle_paths();
}

function vehicle_stop_named(stop_name, acceleration, deceleration) {
  return _vehicle_stop_named(stop_name, acceleration, deceleration);
}

function vehicle_resume_named(stop_name) {
  return _vehicle_resume_named(stop_name);
}

function ishelicopter() {
  if(isDefined(self.isheli)) {
    return true;
  }

  if(!isDefined(self.vehicletype)) {
    return false;
  }

  return isDefined(level.vehicle.templates.helicopter_list[getxhashasset(self.vehicletype)]);
}

function isboat() {
  if(!isDefined(self.vehicletype)) {
    return false;
  }

  return isDefined(level.vehicle.templates.boat_list[getxhashasset(self.vehicletype)]);
}

function isairplane() {
  return isDefined(level.vehicle.templates.airplane_list[getxhashasset(self.vehicletype)]);
}

function istank() {
  if(!isDefined(self.vehicletype)) {
    return false;
  }

  return isDefined(level.vehicle.templates.tank_list[getxhashasset(self.vehicletype)]);
}

function enable_global_vehicle_spawn_functions() {
  vehicle_setuplevelvariables();
  level.vehicle.spawn_functions_enable = 1;
}

function isplayerinvehicle(veh) {
  if(isDefined(veh) && isDefined(veh.driver) && isPlayer(veh.driver)) {
    return true;
  }

  if(!isDefined(veh) && isDefined(level.player.veh)) {
    return true;
  }

  return false;
}

function function_3e3d0013d3b2b92a(veh) {
  return !isplayerinvehicle(veh);
}

function vehicle_watch_for_driving(dist, entercallback, exitcallback, interact_delay) {
  self endon("death");
  self endon("stop_driveable");
  level.player endon("death");
  self.player_drivable = 1;

  while(true) {
    waitframe();

    if(self.code_classname == "script_vehicle") {
      if(!isDefined(level.player.veh)) {
        if(distance2dsquared(level.player.origin, self.origin) < squared(dist)) {
          script_func("display_hint", "enter_vehicle", 0.05);

          if(level.player useButtonPressed()) {
            level.player notify("drive_vehicle");
            self vehicle_turnengineon();
            level.player[[entercallback]](self);
            self.driver = level.player;
            level.player.veh = self;
            function_89cec1224ae724d5();

            while(level.player useButtonPressed()) {
              waitframe();
            }

            if(isDefined(interact_delay)) {
              wait interact_delay;
            }
          }
        }

        continue;
      }

      if(isDefined(level.player.veh) && level.player.veh == self) {
        if(level.player useButtonPressed()) {
          level.player[[exitcallback]](self);
          self.driver = undefined;
          level.player.veh = undefined;

          while(level.player useButtonPressed()) {
            waitframe();
          }

          if(isDefined(interact_delay)) {
            wait interact_delay;
          }
        }
      }
    }
  }
}

function function_32f7de64be76262() {
  if(isDefined(self.damagestate)) {
    return self.damagestate;
  }

  return undefined;
}

function function_a59f81db0ddb38c2() {
  if(isDefined(self.damagestate) && self.damagestate == "damageHeavy") {
    return true;
  }

  return false;
}

function vehicle_kill(inflictor) {
  if(istrue(self.godmode) || istrue(self.demigodmode)) {
    print("<dev string:xa0>");

    return;
  }

  damage = self.healthstarting * 2;
  self dodamage(damage, self.origin, inflictor, undefined, "MOD_EXECUTION");

  if(isDefined(level.player.veh) && self == level.player.veh) {
    setomnvar("ui_veh_health_percent", 0);
  }
}

function vehicle_damage(amount, inflictor, mod) {
  if(istrue(self.godmode) || istrue(self.demigodmode)) {
    print("<dev string:xd5>");

    return;
  }

  mod = default_to(mod, undefined);
  self dodamage(amount, self.origin, inflictor, undefined, mod);
  function_89cec1224ae724d5();
}

function function_af11cc0c8dc23332(inflictor) {
  if(istrue(self.godmode) || istrue(self.demigodmode)) {
    print("<dev string:x10b>");

    return;
  }

  burndownhealth = self.healthstarting * 0.3 - 1 + self.healthbuffer;
  burndowndamage = self.health - burndownhealth;

  if(burndowndamage > 1) {
    self dodamage(burndowndamage, self.origin, inflictor, undefined, "MOD_EXECUTION");
  }
}

function isvehiclehusk() {
  return istrue(self.isvehiclehusk);
}

function isvehiclealive() {
  if(isvehicle() || isDefined(self.code_classname) && self.code_classname == "script_vehicle") {
    return true;
  }

  return false;
}

function function_f6f26f5b1c244d5(scale) {
  assertex(isDefined(scale), "<dev string:x14a>");
  self.var_1de5acbb26e97918 = scale;
}

function function_2c8c048d81431d8b(scale) {
  assertex(isDefined(scale), "<dev string:x14a>");
  self.var_bd79128b30a2dfb2 = scale;
}

function vehicle_sethealth(amount, resetstarting) {
  if(!isDefined(self.healthbuffer)) {
    self.healthbuffer = 0;
  }

  amount = int(amount + self.healthbuffer);
  self.health = amount;
  self.healthactual = amount;

  if(istrue(resetstarting)) {
    self.healthstarting = amount - self.healthbuffer;
  }
}

function vehicle_addhealth(amount, resetstarting) {
  amount = int(amount);

  if(!isDefined(self.healthbuffer)) {
    self.healthbuffer = 0;
  }

  self.health += amount;
  self.healthactual = self.health;

  if(istrue(resetstarting)) {
    self.healthstarting = self.health - self.healthbuffer;
  }
}

function function_c8a94acef0beb362(amount, resetstarting) {
  amount = int(amount);

  if(!isDefined(self.healthbuffer)) {
    self.healthbuffer = 0;
  }

  if(amount >= self.health) {
    vehicle_kill(level);
    return;
  }

  self.health -= amount;
  self.healthactual = self.health;

  if(istrue(resetstarting)) {
    self.healthstarting = self.health - self.healthbuffer;
  }
}

function function_79a6e6e740893346() {
  return self.healthactual - self.healthbuffer;
}

function function_6cbb869150e32086() {
  return (self.healthactual - self.healthbuffer) / self.healthstarting;
}

function function_9e9dfc6f77569f4d() {
  return istrue(self.demigodmode);
}

function function_d7fe44ffb08b499a() {
  return istrue(self.godmode);
}

function function_7b7412ddbeed1f41(bool) {
  self.var_653c58271b7da4c9 = bool;
}

function function_34a2eb36fbca6e89() {
  return istrue(self.var_653c58271b7da4c9);
}

function function_27f6984d596866bf() {
  classname = get_vehicle_classname();
  return level.vehicle.templates.hudindex[classname];
}

function function_65976a53a9cbd110() {
  if(isDefined(function_27f6984d596866bf())) {
    setomnvar("ui_veh_vehicle", function_27f6984d596866bf());
    return;
  }

  setomnvar("ui_veh_vehicle", 2);
}

function function_37f33bfe6b63cb0a() {
  level.player setclientomnvar("ui_veh_vehicle", -1);
}

function function_89cec1224ae724d5() {
  if(!isDefined(level.player)) {
    return;
  }

  if(!isDefined(level.player.veh)) {
    return;
  }

  if(self != level.player.veh) {
    if(!isDefined(level.player.leanout_vehicle)) {
      return;
    }

    if(!is_equal(self, level.player.leanout_vehicle)) {
      return;
    }
  }

  healthpercentage = function_6cbb869150e32086();

  if(healthpercentage < 0) {
    setomnvar("ui_veh_health_percent", int(0));
  } else {
    setomnvar("ui_veh_health_percent", int(healthpercentage * 100));
  }

  if(isDefined(self.var_488f0fc49178c96)) {
    level.player setclientomnvar("ui_veh_flat_tire_mask", self.var_488f0fc49178c96);
  } else {
    level.player setclientomnvar("ui_veh_flat_tire_mask", 0);
  }

  if(isDefined(self.ui_warning)) {
    level.player setclientomnvarbit("ui_veh_warning", 1, self.ui_warning);
    return;
  }

  level.player setclientomnvarbit("ui_veh_warning", 1, 0);
}

function function_2f026409116444() {
  level.player setclientomnvarbit("ui_veh_warning", 1, 1);
}

function function_9fb6b2244163f2a1() {
  if(!isDefined(self.blowntires)) {
    return [];
  }

  return self.blowntires;
}

function function_9b915d163f6d1d5a(part) {
  if(isDefined(self.damageableparts) && isDefined(self.damageableparts[part]) && self.damageableparts[part] > 0) {
    return true;
  }

  return false;
}

#using_animtree("vehicles");

function function_97cbee6be1660a84(animation, husk) {
  vehicle = self;
  self.skiplaunch = 1;

  if(!isDefined(husk)) {
    husk = 1;
  }

  if(istrue(husk) && !ismp() && !iscp()) {
    vehicle = scripts\common\vehicle_code::function_18657584b6bd786a(0);
    vehicle useanimtree(#animtree);
  }

  if(!vehicle hascomponent("animator")) {
    vehicle addcomponent("animator");
    vehicle setconfigvalue("animator", "keyframed", 0);
  }

  vehicle animScripted("crash_anim_finished", vehicle.origin, vehicle.angles, animation, undefined, undefined, 0.2, 1);
  vehicle vehphys_crash();

  if(vehicle hascomponent("p2p")) {
    vehicle setconfigvalue("p2p", "pause", 1);
  }

  if(vehicle hascomponent("path")) {
    vehicle setconfigvalue("path", "pause", 1);
  }

  vehicle waittillmatch("crash_anim_finished", "end");
}

function function_a0f7306fc3c08ecf(vehicle, var_d5a3f788ef786063) {
  inoobtrigger = 0;

  if(isDefined(vehicle.oob)) {
    inoobtrigger = 1;
  }

  if(!istrue(inoobtrigger) && istrue(var_d5a3f788ef786063)) {
    oobtriggers = level.outofboundstriggers;

    foreach(trigger in oobtriggers) {
      if(vehicle istouching(trigger)) {
        inoobtrigger = 1;
        break;
      }
    }
  }

  return inoobtrigger;
}

function function_9039b650ffb212c8(str) {
  if(!isDefined(str)) {
    return;
  }

  if(!isDefined(level.var_d43e78e513933216)) {
    level.var_d43e78e513933216 = [];
  }

  if(!isDefined(level.var_d43e78e513933216[function_3db00f01cdba4538("tag_origin")])) {
    level.var_d43e78e513933216[function_3db00f01cdba4538("tag_origin")] = "tag_origin";
  }

  level.var_d43e78e513933216[function_3db00f01cdba4538(str)] = str;
}

function function_8ed0ffa3f8be7c75(xhash) {
  if(!isDefined(level.var_d43e78e513933216)) {
    return "";
  }

  return default_to(level.var_d43e78e513933216[xhash], "");
}

function codecallback_vehiclespawned() {
  if(isDefined(level.vehicle) && isDefined(level.vehicle.onvehiclespawned)) {
    self[[level.vehicle.onvehiclespawned]]();
  }
}