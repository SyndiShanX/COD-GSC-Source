/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_paths.gsc
***********************************************/



#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace vehicle_paths;

function gopath(vehicle) {
  if(!isDefined(vehicle)) {
    vehicle = self;
    assertex(self.code_classname == "script_vehicle", "Tried to do goPath on a non-vehicle");
  }

  vehicle endon("death");

  if(isDefined(vehicle.hasstarted)) {
    println("<dev string:x1c>");
    return;
  } else {
    vehicle.hasstarted = 1;
  }

  vehicle script_delay();
  vehicle notify("start_vehiclepath");

  if(vehicle ishelicopter()) {
    vehicle notify("start_dynamicpath");
    return;
  }

  vehicle startpath();
}

function _vehicle_paths(node, bhelicopterwaitforstart, var_cfa3aafb71b08d36) {
  if(ishelicopter()) {
    vehicle_paths_helicopter(node, bhelicopterwaitforstart, var_cfa3aafb71b08d36);
    return;
  }

  vehicle_paths_non_heli(node);
}

function trigger_process_node(node) {
  if(isDefined(node.script_flag_set)) {
    flag_set(node.script_flag_set);
  }

  if(isDefined(node.script_flag_clear)) {
    flag_clear(node.script_flag_clear);
  }

  if(isDefined(node.script_prefab_exploder)) {
    node.script_exploder = node.script_prefab_exploder;
    node.script_prefab_exploder = undefined;
  }

  if(isDefined(node.script_exploder)) {
    delay = node.script_exploder_delay;

    if(isDefined(delay)) {
      level delaythread(delay, &exploder, node.script_exploder);
    } else {
      level exploder(node.script_exploder);
    }
  }

  if(isDefined(node.script_flag_set)) {
    flag_set(node.script_flag_set);
  }

  if(isDefined(node.script_ent_flag_set)) {
    ent_flag_set(node.script_ent_flag_set);
  }

  if(isDefined(node.script_ent_flag_clear)) {
    ent_flag_clear(node.script_ent_flag_clear);
  }

  if(isDefined(node.script_flag_clear)) {
    flag_clear(node.script_flag_clear);
  }

  if(isDefined(node.script_noteworthy)) {
    if(node.script_noteworthy == "deleteme") {
      if(isDefined(self.deathfunc)) {
        delete_riders();
        level thread[[self.deathfunc]](self);
        return;
      } else {
        scripts\common\vehicle_code::vehicle_deathcleanup();
        delete_riders();
        self delete();
        return;
      }
    } else if(node.script_noteworthy == "engineoff") {
      self vehicle_turnengineoff();
    } else {
      self notify(node.script_noteworthy);
      self notify("noteworthy", node.script_noteworthy);
    }
  }

  if(isDefined(node.script_badplace)) {
    self.script_badplace = node.script_badplace;
  }

  if(isDefined(node.script_turretmg)) {
    if(node.script_turretmg) {
      _mgon();
    } else {
      _mgoff();
    }
  }

  if(isDefined(node.script_turretmain)) {
    if(node.script_turretmain) {
      _mainturreton();
      return;
    }

    _mainturretoff();
  }
}

function delete_riders() {
  if(isDefined(self.riders)) {
    foreach(g in self.riders) {
      if(isDefined(g)) {
        if(isDefined(g.magic_bullet_shield)) {
          g scripts\common\ai::stop_magic_bullet_shield();
        }

        if(!issp() && isai(g)) {
          g.var_f543095c3ca1b743 = 1;
          g.diequietly = 1;
          g.nocorpse = 1;
          g kill();
          continue;
        }

        g delete();
      }
    }
  }
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

function vehicle_should_unload(wait_func, nextpoint) {
  if(isDefined(nextpoint.script_unload)) {
    return true;
  }

  if(wait_func != &node_wait) {
    return false;
  }

  if(!islastnode(nextpoint)) {
    return false;
  }

  if(istrue(self.dontunloadonend)) {
    return false;
  }

  if(self.vehicletype == "empty" || self.vehicletype == "empty_heli") {
    return false;
  }

  return !(isDefined(self.script_vehicle_selfremove) && self.script_vehicle_selfremove);
}

function overshoot_next_node(vnode) {
  if(!isDefined(vnode)) {
    return;
  }

  self endon("<dev string:x53>");
  vnode waittillmatch("<dev string:x60>", self);
  println("<dev string:x68>");
  println("<dev string:xc1>");
  println("<dev string:x68>");
  println("<dev string:x11a>" + vnode.origin + "<dev string:x147>");
  println("<dev string:x168>");
  println("<dev string:x68>");
}

function vehicle_resumepathvehicle() {
  if(!ishelicopter()) {
    self resumespeed(35);
    return;
  }

  node = undefined;

  if(isDefined(self.currentnode.target) && !isDefined(self.currentnode.exit_node)) {
    node = get_vehiclenode_any_dynamic(self.currentnode.target);
  }

  if(!isDefined(node)) {
    return;
  }

  _vehicle_paths(node);
}

function get_path_getfunc(pathpoint) {
  get_func = &get_from_vehicle_node;

  if(isDefined(pathpoint.target) && isstruct(pathpoint.target)) {
    get_func = &function_98c0327a3d5ce1c;
  } else if(ishelicopter() && isDefined(pathpoint.target)) {
    if(isDefined(get_from_entity(pathpoint.target))) {
      get_func = &get_from_entity;
    }

    if(isDefined(get_from_spawnStruct(pathpoint.target))) {
      get_func = &get_from_spawnstruct;
    }
  } else if(!issp() && isDefined(pathpoint.target)) {
    if(isDefined(get_from_spawnStruct(pathpoint.target))) {
      get_func = &get_from_spawnstruct;
    }
  }

  return get_func;
}

function struct_wait(nextpoint, lastpoint, dist_sq) {
  if(!isDefined(lastpoint)) {
    lastpoint = nextpoint;
  }

  wait 0.05;

  if(isDefined(lastpoint.speed) && lastpoint.speed >= 0) {
    self vehicledriveto(nextpoint.origin, int(lastpoint.speed));

    while(distancesquared(self.origin, nextpoint.origin) > dist_sq) {
      wait 0.1;

      if(utility::iscp()) {
        self vehicle_setspeedimmediate(lastpoint.speed, 15, 15);
      }
    }

    return;
  }

  if(isDefined(lastpoint.speed) && lastpoint.speed < 0) {
    self vehicle_setspeedimmediate(0, 15, 15);
  }
}

function node_wait(nextpoint, lastpoint, get_func) {
  if(isDefined(self.unique_id)) {
    nodeflag = "node_flag_triggered" + self.unique_id;
  } else {
    nodeflag = "node_flag_triggered";
  }

  nodes_flag_triggered(nodeflag, nextpoint, get_func);

  if(self.attachedpath == nextpoint) {
    self notify("node_wait_terminated");
    waittillframeend();
    return;
  }

  nextpoint ent_flag_wait_vehicle_node(nodeflag);
  nextpoint ent_flag_clear(nodeflag, 1);
  nextpoint notify("processed_node" + nodeflag);
}

function nodes_flag_triggered(nodeflag, nextpoint, get_func) {
  count = 0;

  while(isDefined(nextpoint) && count < 3) {
    count++;
    thread node_flag_triggered(nodeflag, nextpoint);

    if(!isDefined(nextpoint.target)) {
      return;
    }

    nextpoint = [[get_func]](nextpoint.target);
  }
}

function node_flag_triggered(nodeflag, node) {
  if(node ent_flag_exist(nodeflag)) {
    return;
  }

  node ent_flag_init(nodeflag);
  thread node_flag_triggered_cleanup(node, nodeflag);
  node endon("processed_node" + nodeflag);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  node waittillmatch("trigger", self);
  node ent_flag_set(nodeflag);
}

function node_flag_triggered_cleanup(node, nodeflag) {
  node endon("processed_node" + nodeflag);
  waittill_any_3("death", "newpath", "node_wait_terminated");
  node ent_flag_clear(nodeflag, 1);
}

function vehicle_paths_non_heli(node) {
  assertex(isDefined(node) || isDefined(self.attachedpath), "vehicle_path() called without a path");
  self notify("newpath");

  if(isDefined(node)) {
    self.attachedpath = node;
  }

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  pathpoint = pathstart;
  lastpoint = undefined;
  nextpoint = pathstart;
  get_func = get_path_getfunc(pathstart);
  dist_sq = 40000;

  while(isDefined(nextpoint)) {
    if(!isstruct(nextpoint)) {
      node_wait(nextpoint, lastpoint, get_func);
    } else {
      struct_wait(nextpoint, lastpoint, dist_sq);
    }

    if(!isDefined(self)) {
      return;
    }

    trigger_process_node(nextpoint);
    self.currentnode = nextpoint;

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(nextpoint.script_team)) {
      self.script_team = nextpoint.script_team;
    }

    if(isDefined(nextpoint.script_turningdir)) {
      self notify("turning", nextpoint.script_turningdir);
    }

    if(isDefined(nextpoint.script_deathroll)) {
      if(nextpoint.script_deathroll == 0) {
        thread deathrolloff();
      } else {
        thread deathrollon();
      }
    }

    if(isDefined(nextpoint.script_wheeldirection)) {
      vehicle_setwheeldirection(nextpoint.script_wheeldirection);
    }

    if(vehicle_should_unload(&node_wait, nextpoint)) {
      thread unload_node(nextpoint);
    }

    if(isDefined(nextpoint.script_transmission)) {
      self.veh_transmission = nextpoint.script_transmission;

      if(self.veh_transmission == "forward") {
        vehicle_setwheeldirection(1);
      } else {
        vehicle_setwheeldirection(0);
      }
    }

    if(isDefined(nextpoint.script_brake)) {
      self.veh_brake = nextpoint.script_brake;

      if(self vehicle_isphysveh()) {
        self vehphys_parkingbrake(1);
      }
    }

    if(isDefined(nextpoint.script_pathtype)) {
      self.veh_pathtype = nextpoint.script_pathtype;
    }

    if(isDefined(nextpoint.script_speed)) {
      accel = undefined;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      decel = undefined;

      if(isDefined(nextpoint.script_decel)) {
        decel = nextpoint.script_decel;
      }

      self vehicle_setspeed(nextpoint.script_speed, accel, decel);
    }

    if(isDefined(nextpoint.script_ent_flag_wait) && !ent_flag(nextpoint.script_ent_flag_wait)) {
      if(isDefined(nextpoint.script_decel)) {
        decel = nextpoint.script_decel;
      } else if(isDefined(nextpoint.target)) {
        stoppoint = [[get_func]](nextpoint.target);
        distance = distance(nextpoint.origin, stoppoint.origin) * 0.0568182;
        speed = self vehicle_getspeed();
        decel = squared(speed) / 2 * distance;
      } else {
        decel = 20;
      }

      self vehicle_setspeed(0, decel, decel);
      childthread vehicle_notifyonstop();
      ent_flag_wait(nextpoint.script_ent_flag_wait);

      if(!isDefined(self)) {
        return;
      }

      accel = 60;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      self notify("resumed_path");
      self resumespeed(accel);
    }

    if(isDefined(nextpoint.script_delay)) {
      decel = 20;

      if(isDefined(nextpoint.script_decel)) {
        decel = nextpoint.script_decel;
      }

      self vehicle_setspeed(0, decel);
      childthread vehicle_notifyonstop();

      if(isDefined(nextpoint.target)) {
        childthread overshoot_next_node([[get_func]](nextpoint.target));
      }

      nextpoint script_delay();
      self notify("delay_passed");
      accel = 60;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      self notify("resumed_path");
      self resumespeed(accel);
    }

    if(isDefined(nextpoint.script_flag_wait) || isDefined(nextpoint.script_flag_waitopen)) {
      was_stopped = 0;
      var_5b62e4fc3021a9a7 = isDefined(nextpoint.script_flag_wait) && !flag(nextpoint.script_flag_wait);
      var_d54eec4cdd1d8fab = isDefined(nextpoint.script_flag_waitopen) && flag(nextpoint.script_flag_waitopen);
      stopped_msg = undefined;

      if(var_5b62e4fc3021a9a7 || var_d54eec4cdd1d8fab || isDefined(nextpoint.script_delay_post)) {
        was_stopped = 1;
        accel = 5;
        decel = 20;

        if(isDefined(nextpoint.script_accel)) {
          accel = nextpoint.script_accel;
        }

        if(isDefined(nextpoint.script_decel)) {
          decel = nextpoint.script_decel;
        }

        if(var_5b62e4fc3021a9a7) {
          stopped_msg = "script_flag_wait_" + nextpoint.script_flag_wait;
        } else if(var_d54eec4cdd1d8fab) {
          stopped_msg = "script_flag_waitopen_" + nextpoint.script_flag_waitopen;
        } else if(isDefined(nextpoint.script_flag_wait)) {
          stopped_msg = "script_delay_post_" + nextpoint.script_flag_wait;
        } else {
          stopped_msg = "script_delay_post_" + nextpoint.script_flag_waitopen;
        }

        _vehicle_stop_named(stopped_msg, accel, decel);
        childthread vehicle_notifyonstop();

        if(isDefined(nextpoint.target)) {
          childthread overshoot_next_node([[get_func]](nextpoint.target));
        }
      }

      if(var_5b62e4fc3021a9a7) {
        flag_wait(nextpoint.script_flag_wait);
      }

      if(var_d54eec4cdd1d8fab) {
        flag_waitopen(nextpoint.script_flag_waitopen);
      }

      if(!isDefined(self)) {
        return;
      }

      if(isDefined(nextpoint.script_delay_post)) {
        wait nextpoint.script_delay_post;

        if(!isDefined(self)) {
          return;
        }
      }

      accel = 10;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      if(was_stopped) {
        self notify("resumed_path");
        _vehicle_resume_named(stopped_msg);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(nextpoint.script_vehicle_lights_off)) {
      thread lights_off(nextpoint.script_vehicle_lights_off);
    }

    if(isDefined(nextpoint.script_vehicle_lights_on)) {
      thread lights_on(nextpoint.script_vehicle_lights_on);
    }

    if(isDefined(nextpoint.script_forcecolor)) {
      thread script_func("forcecolor_riders", nextpoint.script_forcecolor);
    }

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

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    if(isDefined(self.deathfunc)) {
      delete_riders();
      level thread[[self.deathfunc]](self);
      return;
    }

    scripts\common\vehicle_code::vehicle_deathcleanup();
    delete_riders();
    self notify("delete");
    self delete();
  }
}

function vehicle_notifyonstop() {
  self endon("resumed_path");

  while(vehicle_is_stopped()) {
    waitframe();
  }

  self setwaitspeed(0);
  self waittill("reached_wait_speed");
  self notify("stopped_path");
}

function vehicle_waittill_stopped() {
  while(!vehicle_is_stopped()) {
    waitframe();
  }
}

function add_z(vec, zplus) {
  return (vec[0], vec[1], vec[2] + zplus);
}

function vehicle_paths_helicopter(node, bhelicopterwaitforstart, var_cfa3aafb71b08d36) {
  if(self vehicle_isphysveh()) {
    if(self hascomponent("p2p")) {
      function_fabc06bb049f87ee(node);
      return;
    } else if(getdvarint(@ "hash_31333fbc83a5058f") == 0) {
      println("<dev string:x1c0>");
      return;
    }
  }

  assertex(isDefined(node) || isDefined(self.attachedpath), "vehicle_path() called without a path");
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(bhelicopterwaitforstart)) {
    bhelicopterwaitforstart = 0;
  }

  if(isDefined(node)) {
    self.attachedpath = node;
  }

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }

  if(bhelicopterwaitforstart) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_cfa3aafb71b08d36)) {
    elevated_node = spawnStruct();
    elevated_node.origin = add_z(self.origin, var_cfa3aafb71b08d36);
    heli_wait_node(elevated_node, undefined);
  }

  lastpoint = undefined;
  nextpoint = pathstart;
  get_func = get_path_getfunc(pathstart);

  while(isDefined(nextpoint)) {
    if(isDefined(nextpoint.script_linkto)) {
      set_lookat_from_dest(nextpoint);
    }

    if(isDefined(nextpoint.script_land)) {
      hasnextpoint = 0;

      if(isDefined(nextpoint.target)) {
        hasnextpoint = isDefined([[get_func]](nextpoint.target));
      }

      thread vehicle_landanims(nextpoint.script_unload, hasnextpoint);
    }

    if(!isDefined(lastpoint)) {
      if(isDefined(self.var_918c5a31037e00ee)) {
        lastpoint = self.var_918c5a31037e00ee;
      }
    }

    heli_wait_node(nextpoint, lastpoint, var_cfa3aafb71b08d36);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = nextpoint;
    nextpoint notify("trigger", self);

    if(isDefined(nextpoint.script_helimove)) {
      self setyawspeedbyname(nextpoint.script_helimove);

      if(nextpoint.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    trigger_process_node(nextpoint);

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(nextpoint.script_team)) {
      self.script_team = nextpoint.script_team;
    }

    if(vehicle_should_unload(&heli_wait_node, nextpoint)) {
      unload_node(nextpoint);
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(nextpoint.script_pathtype)) {
        self.veh_pathtype = nextpoint.script_pathtype;
      }
    }

    var_3c7df338d0ac0d9e = 0;

    if(isDefined(nextpoint.script_flag_wait)) {
      var_3c7df338d0ac0d9e = 1;
      flag_wait(nextpoint.script_flag_wait);
    }

    if(isDefined(nextpoint.script_flag_waitopen)) {
      var_3c7df338d0ac0d9e = 1;
      flag_waitopen(nextpoint.script_flag_waitopen);
    }

    if(var_3c7df338d0ac0d9e) {
      if(isDefined(nextpoint.script_delay_post)) {
        wait nextpoint.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(nextpoint.script_vehicle_lights_off)) {
      thread lights_off(nextpoint.script_vehicle_lights_off);
    }

    if(isDefined(nextpoint.script_vehicle_lights_on)) {
      thread lights_on(nextpoint.script_vehicle_lights_on);
    }

    if(isDefined(nextpoint.script_forcecolor)) {
      thread script_func("forcecolor_riders", nextpoint.script_forcecolor);
    }

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

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    delete_riders();

    if(isDefined(self.deathfunc)) {
      level thread[[self.deathfunc]](self);
      return;
    }

    self delete();
  }
}

function heli_wait_node(nextpoint, lastpoint, var_cfa3aafb71b08d36) {
  self endon("newpath");

  if(isDefined(nextpoint.script_unload) || isDefined(nextpoint.script_land)) {
    unloadoffset = 0;

    if(isDefined(nextpoint.script_land)) {
      ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        unloadoffset = self.unload_land_offset;
      }
    } else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset)) {
      unloadoffset = self.unload_hover_offset;
    } else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset_max)) {
      groundorg = utility::groundpos(nextpoint.origin);
      unloadoffset = nextpoint.origin[2] - groundorg[2];

      if(unloadoffset >= self.unload_hover_offset_max) {
        unloadoffset = self.unload_hover_offset_max;
      } else if(isDefined(self.unload_hover_land_height) && unloadoffset < self.unload_hover_land_height) {
        unloadoffset = self.unload_hover_land_height;
      }
    }

    nextpoint.radius = 2;

    if(isDefined(nextpoint.ground_pos)) {
      nextpoint.origin = nextpoint.ground_pos + (0, 0, unloadoffset);
    } else {
      neworg = utility::groundpos(nextpoint.origin) + (0, 0, unloadoffset);

      if(neworg[2] > nextpoint.origin[2] - 2000) {
        nextpoint.origin = utility::groundpos(nextpoint.origin) + (0, 0, unloadoffset);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(lastpoint)) {
    airresistance = lastpoint.script_airresistance;

    if(isDefined(airresistance)) {
      airresistance = float(airresistance);
    }

    speed = lastpoint.speed;
    accel = lastpoint.script_accel;
    decel = lastpoint.script_decel;
  } else {
    airresistance = undefined;
    speed = undefined;
    accel = undefined;
    decel = undefined;
  }

  stopnode = isDefined(nextpoint.script_stopnode) && nextpoint.script_stopnode;
  unload = isDefined(nextpoint.script_unload);
  flag_wait = isDefined(nextpoint.script_flag_wait) && !flag(nextpoint.script_flag_wait);
  flag_wait = flag_wait || isDefined(nextpoint.script_flag_waitopen) && flag(nextpoint.script_flag_waitopen);
  var_ccf44cff39a902f0 = !isDefined(nextpoint.target);
  hasdelay = isDefined(nextpoint.script_delay);

  if(isDefined(nextpoint.angles)) {
    yaw = nextpoint.angles[1];
  } else {
    yaw = 0;
  }

  if(self.health <= 0) {
    return;
  }

  origin = nextpoint.origin;

  if(isDefined(var_cfa3aafb71b08d36)) {
    origin = add_z(origin, var_cfa3aafb71b08d36);
  }

  if(isDefined(self.heliheightoverride)) {
    origin = (origin[0], origin[1], self.heliheightoverride);
  }

  self vehicle_helisetai(origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, airresistance, hasdelay, stopnode, unload, flag_wait, var_ccf44cff39a902f0);

  if(isDefined(nextpoint.radius)) {
    self setneargoalnotifydist(nextpoint.radius);
    assertex(nextpoint.radius > 0, "radius: " + nextpoint.radius);
    waittill_any_2("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  if(!isDefined(self)) {
    return;
  }

  trigger_process_node(nextpoint);

  if(isDefined(nextpoint.script_flag_set)) {
    self notify("<dev string:x20e>", nextpoint, nextpoint.script_flag_set);
  } else {
    self notify("<dev string:x20e>", nextpoint);
  }

  if(isDefined(nextpoint.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {
      assertmsg("no Fire Link funk.. need scriptssphelicopter_globals::init_helicopters();");
    }

    thread[[level.helicopter_firelinkfunk]](nextpoint);
  }

  nextpoint script_delay();

  if(isDefined(self.path_gobbler)) {
    deletestruct_ref(nextpoint);
  }

  self notify("continuepath");
}

function function_fabc06bb049f87ee(node, var_b1f8b992bf79f2d3) {
  assertex(isDefined(node) || isDefined(self.attachedpath), "vehicle_paths_physics_helicopter() called without a path");
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(isDefined(node)) {
    self.attachedpath = node;
  }

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }

  lastpoint = undefined;
  nextpoint = pathstart;
  get_func = get_path_getfunc(pathstart);

  while(isDefined(nextpoint)) {
    if(!isDefined(lastpoint)) {
      if(isDefined(self.var_918c5a31037e00ee)) {
        lastpoint = self.var_918c5a31037e00ee;
      }
    }

    function_2936413eac5d78b1(nextpoint, lastpoint, var_b1f8b992bf79f2d3);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = nextpoint;
    nextpoint notify("trigger", self);

    if(isDefined(nextpoint.script_helimove)) {
      self setyawspeedbyname(nextpoint.script_helimove);

      if(nextpoint.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    trigger_process_node(nextpoint);

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(nextpoint.script_team)) {
      self.script_team = nextpoint.script_team;
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(nextpoint.script_pathtype)) {
        self.veh_pathtype = nextpoint.script_pathtype;
      }
    }

    var_3c7df338d0ac0d9e = 0;

    if(isDefined(nextpoint.script_flag_wait)) {
      var_3c7df338d0ac0d9e = 1;
      flag_wait(nextpoint.script_flag_wait);
    }

    if(isDefined(nextpoint.script_flag_waitopen)) {
      var_3c7df338d0ac0d9e = 1;
      flag_waitopen(nextpoint.script_flag_waitopen);
    }

    if(var_3c7df338d0ac0d9e) {
      if(isDefined(nextpoint.script_delay_post)) {
        wait nextpoint.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(nextpoint.script_vehicle_lights_off)) {
      thread lights_off(nextpoint.script_vehicle_lights_off);
    }

    if(isDefined(nextpoint.script_vehicle_lights_on)) {
      thread lights_on(nextpoint.script_vehicle_lights_on);
    }

    if(isDefined(nextpoint.script_forcecolor)) {
      thread script_func("forcecolor_riders", nextpoint.script_forcecolor);
    }

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

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    delete_riders();

    if(isDefined(self.deathfunc)) {
      level thread[[self.deathfunc]](self);
      return;
    }

    self delete();
  }
}

function function_2936413eac5d78b1(nextpoint, lastpoint, var_b1f8b992bf79f2d3) {
  self endon("newpath");

  if(isDefined(nextpoint.script_unload) || isDefined(nextpoint.script_land)) {
    assertmsg("script_unload and script_land are currently UNTESTED");
  }

  if(isDefined(lastpoint)) {
    airresistance = lastpoint.script_airresistance;
    speed = lastpoint.speed;
    accel = lastpoint.script_accel;
    decel = lastpoint.script_decel;
  } else {
    airresistance = undefined;
    speed = undefined;
    accel = undefined;
    decel = undefined;
  }

  stopnode = isDefined(nextpoint.script_stopnode) && nextpoint.script_stopnode;
  unload = isDefined(nextpoint.script_unload);
  flag_wait = isDefined(nextpoint.script_flag_wait) && !flag(nextpoint.script_flag_wait);
  flag_wait = flag_wait || isDefined(nextpoint.script_flag_waitopen) && flag(nextpoint.script_flag_waitopen);
  var_ccf44cff39a902f0 = !isDefined(nextpoint.target);
  hasdelay = isDefined(nextpoint.script_delay);
  yaw = 0;

  if(isDefined(nextpoint.angles)) {
    yaw = nextpoint.angles[1];
  }

  if(self.health <= 0) {
    return;
  }

  origin = nextpoint.origin;

  if(isDefined(nextpoint.radius)) {
    assertex(nextpoint.radius > 0, "radius: " + nextpoint.radius);
    self setconfigvalue("p2p", "goalThreshold", nextpoint.radius);
  }

  if(isDefined(var_b1f8b992bf79f2d3)) {
    origin = add_z(origin, var_b1f8b992bf79f2d3);
  }

  self setconfigvalue("p2p", "goalPoint", origin);
  self setconfigvalue("p2p", "goalAngles", (0, yaw, 0));
  self waittill("near_goal");

  if(!isDefined(self)) {
    return;
  }

  trigger_process_node(nextpoint);

  if(isDefined(nextpoint.script_flag_set)) {
    self notify("<dev string:x20e>", nextpoint, nextpoint.script_flag_set);
  } else {
    self notify("<dev string:x20e>", nextpoint);
  }

  if(isDefined(nextpoint.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {
      assertmsg("no Fire Link funk.. need scriptssphelicopter_globals::init_helicopters();");
    }

    thread[[level.helicopter_firelinkfunk]](nextpoint);
  }

  nextpoint script_delay();

  if(isDefined(self.path_gobbler)) {
    deletestruct_ref(nextpoint);
  }

  self notify("continuepath");
}

function get_pathstruct() {
  structs = getStructArray(self.target, "targetname");
  assertex(structs.size != 0, "Vehicle at " + self.origin + " is not targeting a struct");

  if(structs.size == 1) {
    return structs[0];
  }

  filtered = [];

  foreach(struct in structs) {
    if(!isDefined(struct.script_demeanor)) {
      filtered[filtered.size] = struct;
    }
  }

  assertex(filtered.size == 1, "Vehicle at " + self.origin + " is targeting too many path structs or no structs at all");
  return filtered[0];
}

function getonpath(skip_attach) {
  path_start = undefined;
  type = self.vehicletype;

  if(isDefined(self.vehicle_spawner)) {
    if(istrue(self.vehicle_spawner.dontgetonpath)) {
      return;
    }
  }

  if(isDefined(self.target)) {
    path_start = getvehiclenode(self.target, "targetname");

    if(ishelicopter() && isDefined(path_start)) {
      println("<dev string:x223>" + path_start.targetname);
      println("<dev string:x240>" + getxhashsourcename(self.vehicletype));
      assertmsg("<dev string:x24e>");
    }

    if(!isDefined(path_start)) {
      if(utility::iscp()) {
        path_start = get_pathstruct();
      } else {
        path_start = getStruct(self.target, "targetname");
      }
    }
  }

  if(!isDefined(path_start)) {
    if(ishelicopter()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self.attachedpath = path_start;

  if(!ishelicopter() && !isstruct(path_start)) {
    self.origin = path_start.origin;

    if(!isDefined(skip_attach)) {
      self attachpath(path_start);
    }
  } else if(isDefined(self.speed)) {
    self vehicle_setspeedimmediate(self.speed, 20);
  } else if(isDefined(path_start.speed)) {
    accel = 20;
    decel = 10;

    if(isDefined(path_start.script_accel)) {
      accel = path_start.script_accel;
    }

    if(isDefined(path_start.script_decel)) {
      accel = path_start.script_decel;
    }

    speedfloat = float(path_start.speed);
    self vehicle_setspeedimmediate(speedfloat, accel, decel);
  } else {
    self vehicle_setspeed(60, 20, 10);
  }

  thread _vehicle_paths(undefined, ishelicopter());
}

function _vehicle_resume_named(stop_name) {
  resume_speed = self.vehicle_stop_named[stop_name];
  self.vehicle_stop_named[stop_name] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }

  if(self hascomponent("p2p")) {
    self setconfigvalue("p2p", "manualSpeed", resume_speed * 17.6);
    return;
  }

  self resumespeed(resume_speed);
}

function _vehicle_stop_named(stop_name, acceleration, deceleration) {
  if(!isDefined(self.vehicle_stop_named)) {
    self.vehicle_stop_named = [];
  }

  assertex(!isDefined(self.vehicle_stop_named[stop_name]), "can't stop twice with same name");

  if(self hascomponent("p2p")) {
    self.vehicle_stop_named[stop_name] = self vehicle_getspeed();
    self setconfigvalue("p2p", "manualSpeed", 0);
    return;
  }

  self vehicle_setspeed(0, acceleration, deceleration);
  self.vehicle_stop_named[stop_name] = acceleration;
}

function unload_node(node) {
  self endon("death");

  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["prep_unload"]) && ent_flag("prep_unload")) {
    return;
  }

  assert(isDefined(self));

  if(isDefined(node.targetname)) {
    pathnode = getnode(node.targetname, "target");

    if(isDefined(pathnode) && self.riders.size) {
      foreach(rider in self.riders) {
        if(isai(rider)) {
          rider thread script_func("go_to_node", pathnode);
        }
      }
    }
  }

  if(ishelicopter()) {
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

  var_b3941e6a151cf4d2 = _vehicle_unload(node.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(node.script_unload)) {
    self waittill("unloaded");
  }

  if(isDefined(node.script_flag_wait) || isDefined(node.script_flag_waitopen) || isDefined(node.script_delay)) {
    return var_b3941e6a151cf4d2;
  }

  if(isDefined(self)) {
    thread vehicle_resumepathvehicle();
  }

  return var_b3941e6a151cf4d2;
}

function checkvehiclenavsplinestuck() {
  self notify("checkVehicleNavSplineStuck");
  self endon("checkVehicleNavSplineStuck");
  self endon("death");
  laststucktime = undefined;
  laststuckposition = undefined;
  stuckdistancethreshold = 100;
  var_196855bdf0b6d359 = 5;

  while(true) {
    self waittill("path_blocked");

    if(!isDefined(laststucktime) || !isDefined(laststuckposition)) {
      laststucktime = gettime();
      laststuckposition = self.origin;
      continue;
    }

    stuckdistance = length2d(self.origin - laststuckposition);

    if(stuckdistance > stuckdistancethreshold) {
      laststucktime = gettime();
      laststuckposition = self.origin;
      continue;
    }

    timeelapsed = gettime() - laststucktime;
    timeelapsedseconds = timeelapsed / 1000;

    if(timeelapsedseconds > var_196855bdf0b6d359) {
      duration = 400;
      print3d(self getcentroid(), "<dev string:x281>", (1, 1, 1), 1, 1, duration);

      self notify("vehicleStuckNavSpline");
      self stoppath();
      break;
    }
  }
}

function checkvehiclenavsplineinterrupted() {
  self notify("checkVehicleNavSplineInterrupted");
  self endon("checkVehicleNavSplineInterrupted");
  self endon("death");

  while(true) {
    self waittill("navspline_interrupted");

    duration = 400;
    print3d(self getcentroid(), "<dev string:x299>", (1, 1, 1), 1, 1, duration);

    self notify("vehicleNavSplineInterrupted");
    self stoppath();
  }
}

function function_b5e5b1755c705053(goallocation, speedmph, var_56c51d0b8c3270ca, debugdraw) {
  startlocation = self.origin;
  vehicleforward = anglesToForward(self.angles);
  splinepoints = self findsplinepath(startlocation, goallocation, 50, 200, 100, vehicleforward, (0, 0, 0), 300, 0.4, 0, 1, var_56c51d0b8c3270ca, 0, 1);
  speedips = mph_to_ips(speedmph);
  self setconfigvalue("p2p", "manualSpeed", speedips);

  if(isDefined(splinepoints) && istrue(debugdraw)) {
    thread function_68d5232181fec390(splinepoints, ter_op(isDefined(var_56c51d0b8c3270ca), (1, 1, 1), (1, 0, 0)));
    thread function_2a708e9755fc798b(var_56c51d0b8c3270ca, speedmph);
  }

  thread checkvehiclenavsplinestuck();
  thread checkvehiclenavsplineinterrupted();
}

function vehiclenavsplinesimplefollowbehavior(speedmph, var_56c51d0b8c3270ca, debugdraw) {
  self notify("vehicleNavSplineSimpleFollowBehavior");
  self endon("vehicleNavSplineSimpleFollowBehavior");
  self endon("death");
  minradius = 500;
  maxradius = 1200;
  var_888ed72045a81b60 = 150;
  var_3a23d1f807ed0162 = 1500;
  var_c71a100d3bdf9202 = 4000;

  while(true) {
    enemy = level.players[0];

    if(!isDefined(enemy)) {
      waitframe();
      continue;
    }

    if(!isDefined(self.attackpoint)) {
      tacpoint = getexposedtacpointwithvisinradius(enemy.origin, enemy.origin, minradius, maxradius, var_888ed72045a81b60);

      if(!isDefined(tacpoint)) {
        wait 1;
        continue;
      } else {
        self.attackpoint = tacpoint.origin;
      }
    }

    function_b5e5b1755c705053(self.attackpoint, speedmph, var_56c51d0b8c3270ca, debugdraw);

    if(istrue(debugdraw)) {
      duration = 100;
      line(self.attackpoint, self.origin, (0, 1, 0), 1, 0, duration);
      sphere(self.attackpoint, 15, (0, 1, 0), 1, duration);
    }

    waittill_any_3("near_goal", "vehicleNavSplineInterrupted", "vehicleStuckNavSpline");
    self.enemyvisibletime = gettime();

    while(true) {
      waitframe();
      attackpointdistance = distance2d(enemy.origin, self.attackpoint);

      if(attackpointdistance > var_3a23d1f807ed0162) {
        self.attackpoint = undefined;
        break;
      }

      trace = scripts\engine\trace::ray_trace(self.origin, enemy getcentroid(), self);

      if(istrue(debugdraw)) {
        visible = isDefined(trace) && trace["<dev string:x2b7>"] == "<dev string:x2bf>" && trace["<dev string:x2ce>"] == enemy;
        color = ter_op(visible, (1, 1, 0), (1, 0, 0));
        line(enemy getcentroid(), self.origin, color, 1, 0, 1);
        print3d(self.origin, "<dev string:x2d5>" + attackpointdistance, color, 1, 1, 1);
      }

      if(isDefined(trace) && trace["hittype"] == "hittype_entity" && trace["entity"] == enemy) {
        self.enemyvisibletime = gettime();
        continue;
      }

      if(gettime() - self.enemyvisibletime > var_c71a100d3bdf9202) {
        self.attackpoint = undefined;
        break;
      }
    }
  }
}

function function_2a708e9755fc798b(var_56c51d0b8c3270ca, speed) {
  duration = 400;
  textverticaloffset = 15;

  if(utility::issp()) {
    var_1b46e8b19292a40e = getDvar(@ "hash_4e06d4ff70605269", 0);
    print3d(self.origin, "<dev string:x2d6>" + var_1b46e8b19292a40e, (1, 1, 1), 1, 1, duration);
  }

  navmeshlayer = ter_op(isDefined(var_56c51d0b8c3270ca), var_56c51d0b8c3270ca, "<dev string:x2f2>");
  var_620e3a366fb95fcf = istrue(level.var_620e3a366fb95fcf);
  script_disconnectpaths = !isDefined(self.script_disconnectpaths) || istrue(self.script_disconnectpaths);
  bg_vehcheckp2pgoalinturningcircle = getDvar(@ "hash_b0706332ae0689bc", 1);
  print3d(self.origin + (0, 0, textverticaloffset * 3), "<dev string:x2fa>" + navmeshlayer + "<dev string:x308>" + speed, (1, 1, 1), 1, 1, duration);
  print3d(self.origin + (0, 0, textverticaloffset * 2), "<dev string:x310>" + var_620e3a366fb95fcf + "<dev string:x32b>" + script_disconnectpaths, (1, 1, 1), 1, 1, duration);
  print3d(self.origin + (0, 0, textverticaloffset), "<dev string:x344>" + bg_vehcheckp2pgoalinturningcircle, (1, 1, 1), 1, 1, duration);
}

function function_68d5232181fec390(splinepoints, pathcolor) {
  self notify("<dev string:x367>");
  self endon("<dev string:x367>");
  self endon("<dev string:x37b>");

  while(true) {
    waitframe();
    sphere(splinepoints[0], 5, pathcolor, 0, 1);
    pathcolor = ter_op(isDefined(pathcolor), pathcolor, (1, 1, 1));

    for(index = 1; index < splinepoints.size; index++) {
      line(splinepoints[index - 1], splinepoints[index], pathcolor, 1, 0, 1);
    }
  }
}

# /