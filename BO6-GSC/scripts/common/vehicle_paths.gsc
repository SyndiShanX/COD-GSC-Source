/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_paths.gsc
********************************************/

#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_roads;
#using scripts\engine\flags;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace vehicle_paths;

function function_53e592e2d38c05ca(checkStuck = 0, brakeAtGoal = 1, autonormal = 1, brakeOnGoalGasbrake = 1, goalThreshold = 100, throttleSpeedClose = 0, throttleSpeedThreshold = 1, var_f04cadb28ee6016d = 1, throttleSpeedFarBelow = 0, throttleSpeedFarAbove = 0, gasToStopMovement = 0.9, steeringMultiplier = 2) {
  if(!self hascomponent("p2p")) {
    self addcomponent("p2p");
  }

  self function_eb88c4e66edbc855("p2p", "checkStuck", checkStuck);
  self function_eb88c4e66edbc855("p2p", "brakeAtGoal", brakeAtGoal);
  self function_eb88c4e66edbc855("p2p", "automaticNormal", autonormal);
  self function_eb88c4e66edbc855("p2p", "brakeOnGoalGasbrake", brakeOnGoalGasbrake);
  self function_eb88c4e66edbc855("p2p", "goalThreshold", goalThreshold);
  self function_eb88c4e66edbc855("p2p", "throttleSpeedClose", throttleSpeedClose);
  self function_eb88c4e66edbc855("p2p", "throttleSpeedThreshold", throttleSpeedThreshold);
  self function_eb88c4e66edbc855("p2p", "automaticFastTopspeedFraction", var_f04cadb28ee6016d);
  self function_eb88c4e66edbc855("p2p", "throttleSpeedFarBelow", throttleSpeedFarBelow);
  self function_eb88c4e66edbc855("p2p", "throttleSpeedFarAbove", throttleSpeedFarAbove);
  self function_eb88c4e66edbc855("p2p", "gasToStopMovement", gasToStopMovement);
  self function_eb88c4e66edbc855("p2p", "steeringMultiplier", steeringMultiplier);
}

function function_6080e3e7e4316b48() {
  if(!self hascomponent("c2p")) {
    self addcomponent("c2p");
  }
}

function vehicle_init_path_radiant(stepradius = 300, stepSpeedFactor = 2, useManualSpeed) {
  if(!self hascomponent("path")) {
    self addcomponent("path");
  }

  var_9d84d0368e2af60d = self hascomponent("c2p");
  self.pathtype = "path_radiant";
  self function_eb88c4e66edbc855("path", "radiusToStep", stepradius);
  self function_eb88c4e66edbc855("path", "stepSpeedFactor", stepSpeedFactor);
  self function_eb88c4e66edbc855("path", "useManualSpeed", !var_9d84d0368e2af60d);
  self.stopping = 0;
}

function function_dc471bcc9cda9df(node, looped, tau = 0.23, usemanualspeeds = 1, yawHelper = 0, brakeatgoalonendnode = 1) {
  if(!self hascomponent("path")) {
    self addcomponent("path");
  }

  self.pathtype = "path_catmullrom";
  spline_id = 0;

  if(isarray(level.vehicle.var_235af58a8cf6d697) && isstruct(level.vehicle.var_235af58a8cf6d697[node.targetname])) {
    spline_id = level.vehicle.var_235af58a8cf6d697[node.targetname];
  } else {
    var_d4b32d94b070889b = [];
    notetimes = [];
    curnode = node;

    while(isDefined(curnode)) {
      var_d4b32d94b070889b[var_d4b32d94b070889b.size] = curnode.origin;
      notetimes[notetimes.size] = 10;

      if(isstring(curnode.target)) {
        curnode = getvehiclenode(curnode.target, #targetname);
        continue;
      }

      break;
    }

    spline_id = function_53253e8ea222ed60(var_d4b32d94b070889b, notetimes, istrue(looped), tau);

    if(isarray(level.vehicle.var_235af58a8cf6d697)) {
      level.vehicle.var_235af58a8cf6d697[node.targetname] = spline_id;
    }
  }

  self.catmullrom_spline_id = spline_id;
  self function_eb88c4e66edbc855("path", "useManualSpeed", usemanualspeeds);
  self function_eb88c4e66edbc855("path", "yawHelper", yawHelper);
  self function_eb88c4e66edbc855("path", "setBrakeAtGoalOnEndNode", brakeatgoalonendnode);
}

function function_2af4522b1fc2bcc9(var_9f701152d59c1d85) {
  if(!isDefined(self.pathtype)) {
    iprintlnbold("<dev string:x24>");

    return;
  }

  if(self hascomponent("p2p")) {
    self function_eb88c4e66edbc855("p2p", "resume", 1);
  }

  if(self.pathtype == "path_radiant") {
    index = isstring(var_9f701152d59c1d85) ? getvehiclenodeindex(var_9f701152d59c1d85, #targetname) : var_9f701152d59c1d85.index;
    assert(isDefined(index), "<dev string:x73>");
    self function_eb88c4e66edbc855("path", "radiantId", index);

    if(self function_24e10bf6894fa869("path", "pause")) {
      self function_eb88c4e66edbc855("path", "resume", 1);
    }

    return;
  }

  if(self.pathtype == "path_catmullrom") {
    self function_eb88c4e66edbc855("path", "catmullRomId", self.catmullrom_spline_id);
  }
}

function gopath(vehicle) {
  if(!isDefined(vehicle)) {
    vehicle = self;
    assert(self.code_classname == "<dev string:x9e>", "<dev string:xb0>");
  }

  vehicle endon("death");

  if(isDefined(vehicle.hasstarted)) {
    println("<dev string:xd7>");
    return;
  } else {
    vehicle.hasstarted = 1;
  }

  vehicle utility::script_delay();
  vehicle notify("start_vehiclepath");

  if(vehicle vehicle::ishelicopter()) {
    vehicle notify("start_dynamicpath");
    return;
  }

  vehicle startpath();
}

function _vehicle_paths(node, var_ad6ef44930971fe1, var_1f8d7b4146f4fe75) {
  if(vehicle::ishelicopter()) {
    vehicle_paths_helicopter(node, var_ad6ef44930971fe1, var_1f8d7b4146f4fe75);
    return;
  }

  vehicle_paths_non_heli(node);
}

function trigger_process_node(node) {
  if(node.script_flag_set) {
    utility::flag_set(node.script_flag_set);
  }

  if(node.script_flag_clear) {
    utility::flag_clear(node.script_flag_clear);
  }

  if(node.script_prefab_exploder) {
    node.script_exploder = node.script_prefab_exploder;
    node.script_prefab_exploder = undefined;
  }

  if(node.script_exploder) {
    delay = node.script_exploder_delay;

    if(isDefined(delay)) {
      level utility::delaythread(delay, &utility::exploder, node.script_exploder);
    } else {
      level utility::exploder(node.script_exploder);
    }
  }

  if(node.script_flag_set) {
    utility::flag_set(node.script_flag_set);
  }

  if(node.script_ent_flag_set) {
    utility::ent_flag_set(node.script_ent_flag_set);
  }

  if(node.script_ent_flag_clear) {
    utility::ent_flag_clear(node.script_ent_flag_clear);
  }

  if(node.script_flag_clear) {
    utility::flag_clear(node.script_flag_clear);
  }

  if(node.script_noteworthy) {
    if(node.script_noteworthy == "deleteme") {
      if(vehicle::function_df978a2fa3318bbd()) {
        self.dontspawnhusk = 1;
        thread vehicle::death(self);
        return;
      } else if(isDefined(self.deathfunc)) {
        vehicle_ai::delete_riders();
        level thread[[self.deathfunc]](self);
        return;
      } else {
        vehicle_ai::delete_riders();
        self delete();
        return;
      }
    } else if(node.script_noteworthy == "engineoff") {
      self vehicle_turnengineoff();
      self notify("engineoff");
    } else {
      self notify(node.script_noteworthy);
      self notify("noteworthy", node.script_noteworthy);
    }
  }

  if(node.arrivedcallback) {
    [[node.arrivedcallback]]();
  }

  if(node.script_badplace) {
    self.script_badplace = node.script_badplace;
  }

  if(node.script_turretmg) {
    if(node.script_turretmg) {
      vehicle_code::_mgon();
    } else {
      vehicle_code::_mgoff();
    }
  }

  if(node.script_turretmain) {
    if(node.script_turretmain) {
      vehicle_code::_mainturreton();
      return;
    }

    vehicle_code::_mainturretoff();
  }
}

function delete_riders() {
  assertmsg("<dev string:x111>");
  vehicle_ai::delete_riders();
}

function islastnode(node) {
  if(!isDefined(node.target)) {
    return true;
  }

  if(!isDefined(getvehiclenode(node.target, #targetname)) && !isDefined(vehicle_code::get_vehiclenode_any_dynamic(node.target))) {
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

  if(self.dontunloadonend) {
    return false;
  }

  if(self.vehicletype == "empty" || self.vehicletype == "empty_heli") {
    return false;
  }

  if(islastnode(nextpoint)) {
    return !(isDefined(self.script_vehicle_selfremove) && self.script_vehicle_selfremove);
  }

  return false;
}

function overshoot_next_node(vnode) {
  if(!isDefined(vnode)) {
    return;
  }

  self endon("<dev string:x16a>");
  vnode waittillmatch("<dev string:x17a>", self);
  println("<dev string:x185>");
  println("<dev string:x1e1>");
  println("<dev string:x185>");
  println("<dev string:x23d>" + vnode.origin + "<dev string:x26d>");
  println("<dev string:x291>");
  println("<dev string:x185>");
}

function vehicle_resumepathvehicle() {
  if(!vehicle::ishelicopter()) {
    self resumespeed(35);
    return;
  }

  node = undefined;

  if(isDefined(self.currentnode.target) && !isDefined(self.currentnode.exit_node)) {
    if(isstruct(self.currentnode.target)) {
      node = self.currentnode.target;
    } else if(isarray(self.currentnode.target)) {
      node = utility::random(self.currentnode.target);
    } else {
      node = vehicle_code::get_vehiclenode_any_dynamic(self.currentnode.target);
    }
  }

  if(!isDefined(node)) {
    return;
  }

  _vehicle_paths(node);
}

function get_path_getfunc(pathpoint) {
  get_func = &vehicle_code::get_from_vehicle_node;

  if(self.usenavmesh) {
    get_func = &vehicle_roads::function_8fe66e18c5435268;
  } else if(isstruct(pathpoint.target)) {
    get_func = &vehicle_code::function_b6c635d769164cf1;
  } else if(isarray(pathpoint.target)) {
    get_func = &function_f535f086527bcb5c;
  } else if(vehicle::ishelicopter() && pathpoint.target) {
    if(isDefined(vehicle_code::get_from_entity(pathpoint))) {
      get_func = &vehicle_code::get_from_entity;
    }

    if(isDefined(vehicle_code::get_from_spawnStruct(pathpoint))) {
      get_func = &vehicle_code::get_from_spawnstruct;
    }
  } else if(!utility::issp() && pathpoint.target) {
    if(isDefined(vehicle_code::get_from_spawnStruct(pathpoint))) {
      get_func = &vehicle_code::get_from_spawnstruct;
    }
  }

  return get_func;
}

function private get_nextpoint(get_func, point) {
  if(isstring(self.veh_pathdir) && self.veh_pathdir == "reverse") {
    return point.prevpoint;
  } else if(!point.target) {
    return undefined;
  }

  next_point = [[get_func]](point);

  if(!isDefined(next_point) && get_func != &vehicle_roads::function_8fe66e18c5435268) {
    assertmsg("<dev string:x2ec>" + point.origin);
  }

  return next_point;
}

function struct_wait(nextpoint, lastpoint, dist_sq) {
  if(!isDefined(lastpoint)) {
    lastpoint = nextpoint;
  }

  wait 0.05;

  if(lastpoint.speed >= 0) {
    self vehicledriveto(nextpoint.origin, int(lastpoint.speed));

    while(distancesquared(self.origin, nextpoint.origin) > dist_sq) {
      wait 0.1;
    }

    return;
  }

  if(lastpoint.speed < 0) {
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

  nextpoint utility::ent_flag_wait_vehicle_node(nodeflag);
  nextpoint utility::ent_flag_clear(nodeflag, 1);
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

    nextpoint = get_nextpoint(get_func, nextpoint);
  }
}

function node_flag_triggered(nodeflag, node) {
  if(node utility::ent_flag_exist(nodeflag)) {
    return;
  }

  node utility::ent_flag_init(nodeflag);
  thread node_flag_triggered_cleanup(node, nodeflag);
  node endon("processed_node" + nodeflag);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  node waittillmatch("trigger", self);
  node utility::ent_flag_set(nodeflag);
}

function node_flag_triggered_cleanup(node, nodeflag) {
  node endon("processed_node" + nodeflag);
  utility::waittill_any("death", "newpath", "node_wait_terminated");
  node utility::ent_flag_clear(nodeflag, 1);
}

function vehicle_paths_non_heli(node) {
  assert(isDefined(node) || isDefined(self.attachedpath), "<dev string:x343>");
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

  if(self.usenavmesh && self.navobstacleid) {
    vehicle_code::vehicle_disable_navobstacles();
    waitframe();
  }

  while(isDefined(nextpoint)) {
    if(self.usenavmesh) {
      vehicle_roads::navmesh_wait(nextpoint);
    } else if(!isstruct(nextpoint)) {
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
        thread vehicle_code::deathrolloff();
      } else {
        thread vehicle_code::deathrollon();
      }
    }

    if(isDefined(nextpoint.script_wheeldirection)) {
      vehicle_code::vehicle_setwheeldirection(nextpoint.script_wheeldirection);
    }

    if(vehicle_should_unload(&node_wait, nextpoint)) {
      if(islastnode(nextpoint)) {
        thread unload_node(nextpoint);
      } else {
        unload_node(nextpoint);
      }
    }

    if(isDefined(nextpoint.script_transmission)) {
      self.veh_transmission = nextpoint.script_transmission;

      if(self.veh_transmission == "forward") {
        vehicle_code::vehicle_setwheeldirection(1);
      } else {
        vehicle_code::vehicle_setwheeldirection(0);
      }
    }

    if(isDefined(nextpoint.script_pathdir)) {
      self.veh_pathdir = nextpoint.script_pathdir;
      vehicle::function_51906bc4fc51948(nextpoint.script_pathdir);
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

    if(isDefined(nextpoint.script_speed) || isDefined(nextpoint.speed)) {
      accel = undefined;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      decel = undefined;

      if(isDefined(nextpoint.script_decel)) {
        decel = nextpoint.script_decel;
      }

      if(self vehicle_isphysveh() && !utility::ent_flag("vehicle_paths_scripted_speed")) {
        vehicle::function_698648338e3e7b6d(nextpoint.script_speed ?? nextpoint.speed * 0.056818, accel, decel);
      }
    }

    if(isDefined(nextpoint.script_ent_flag_wait) && !utility::ent_flag(nextpoint.script_ent_flag_wait)) {
      stopped_msg = "script_ent_flag_wait_" + nextpoint.script_ent_flag_wait;
      vehicle_stop(nextpoint, stopped_msg, get_func);
      utility::ent_flag_wait(nextpoint.script_ent_flag_wait);

      if(!isDefined(self)) {
        return;
      }

      accel = 60;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      self notify("resumed_path");
      _vehicle_resume_named(stopped_msg);
    }

    if(isDefined(nextpoint.script_delay)) {
      stopped_msg = "script_delay_" + nextpoint.script_delay;
      vehicle_stop(nextpoint, stopped_msg, get_func);
      nextpoint utility::script_delay();
      self notify("delay_passed");
      accel = 60;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      self notify("resumed_path");
      _vehicle_resume_named(stopped_msg);
    }

    if(isDefined(nextpoint.script_flag_wait) || isDefined(nextpoint.script_flag_waitopen)) {
      was_stopped = 0;
      var_52ea4d23844bb252 = isDefined(nextpoint.script_flag_wait) && !utility::flag(nextpoint.script_flag_wait);
      var_e47e24cbe714049a = isDefined(nextpoint.script_flag_waitopen) && utility::flag(nextpoint.script_flag_waitopen);
      stopped_msg = undefined;

      if(var_52ea4d23844bb252 || var_e47e24cbe714049a || isDefined(nextpoint.script_delay_post)) {
        was_stopped = 1;

        if(var_52ea4d23844bb252) {
          stopped_msg = "script_flag_wait_" + nextpoint.script_flag_wait;
        } else if(var_e47e24cbe714049a) {
          stopped_msg = "script_flag_waitopen_" + nextpoint.script_flag_waitopen;
        } else if(isDefined(nextpoint.script_flag_wait)) {
          stopped_msg = "script_delay_post_" + nextpoint.script_flag_wait;
        } else {
          stopped_msg = "script_delay_post_" + nextpoint.script_flag_waitopen;
        }

        vehicle_stop(nextpoint, stopped_msg, get_func);
      }

      if(var_52ea4d23844bb252) {
        utility::flag_wait(nextpoint.script_flag_wait);
      }

      if(var_e47e24cbe714049a) {
        utility::flag_waitopen(nextpoint.script_flag_waitopen);
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
      thread vehicle_lights::lights_off(nextpoint.script_vehicle_lights_off);
    }

    if(isDefined(nextpoint.script_vehicle_lights_on)) {
      thread vehicle_lights::lights_on(nextpoint.script_vehicle_lights_on);
    }

    if(isDefined(nextpoint.script_forcecolor)) {
      thread utility::script_func("forcecolor_riders", nextpoint.script_forcecolor);
    }

    lastpoint = nextpoint;
    nextpoint = get_nextpoint(get_func, nextpoint);

    if(!isDefined(nextpoint)) {
      nextpoint = lastpoint;
      break;
    }

    if(!isstring(self.veh_pathdir) || self.veh_pathdir == "forward") {
      nextpoint.prevpoint = lastpoint;
    }
  }

  if(self vehicle_isphysveh() && self.var_75ea1b9acbb56f2a) {
    starttime = gettime();

    while(true) {
      if(distance2dsquared(lastpoint.origin, self.origin) < 10000) {
        break;
      } else if(gettime() - starttime > 5000) {
        break;
      }

      waitframe();
    }

    vehicle::function_698648338e3e7b6d(0);

    if(self.usenavmesh && self hascomponent("path")) {
      self setconfigvalue("path", "pause", 1);
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    if(isDefined(self.deathfunc)) {
      vehicle_ai::delete_riders();
      level thread[[self.deathfunc]](self);
      return;
    }

    vehicle_ai::delete_riders();
    self delete();
  }
}

function vehicle_stop(nextpoint, stopped_msg, get_func) {
  accel = nextpoint.script_accel ?? 5;
  decel = nextpoint.script_decel ?? 20;
  _vehicle_stop_named(stopped_msg, accel, decel);
  childthread vehicle_notifyonstop();

  if(get_func) {
    next_nextpoint = get_nextpoint(get_func, nextpoint);

    if(isDefined(next_nextpoint)) {
      childthread overshoot_next_node(next_nextpoint);
    }
  }
}

function vehicle_notifyonstop() {
  self endon("resumed_path");

  while(!vehicle_code::vehicle_is_stopped()) {
    waitframe();
  }

  self notify("stopped_path");
}

function vehicle_waittill_stopped() {
  while(!vehicle_code::vehicle_is_stopped()) {
    waitframe();
  }
}

function add_z(vec, zplus) {
  return (vec[0], vec[1], vec[2] + zplus);
}

function vehicle_paths_helicopter(node, var_ad6ef44930971fe1, var_1f8d7b4146f4fe75) {
  if(self vehicle_isphysveh()) {
    if(self hascomponent("p2p")) {
      function_4e87486ece806fb1(node);
      return;
    } else if(getdvarint(@ "vehlegacyhelipathingforphysicshelicopters") == 0) {
      println("<dev string:x36b>");
      return;
    }
  }

  assert(isDefined(node) || isDefined(self.attachedpath), "<dev string:x343>");
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_ad6ef44930971fe1)) {
    var_ad6ef44930971fe1 = 0;
  }

  if(isDefined(node)) {
    self.attachedpath = node;
  }

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }

  if(var_ad6ef44930971fe1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_1f8d7b4146f4fe75)) {
    elevated_node = spawnStruct();
    elevated_node.origin = add_z(self.origin, var_1f8d7b4146f4fe75);
    heli_wait_node(elevated_node, undefined);
  }

  lastpoint = undefined;
  nextpoint = pathstart;
  get_func = get_path_getfunc(pathstart);

  while(isDefined(nextpoint)) {
    if(isDefined(nextpoint.script_linkto)) {
      vehicle_code::set_lookat_from_dest(nextpoint);
    }

    if(isDefined(nextpoint.script_land)) {
      hasnextpoint = 0;

      if(isDefined(nextpoint.target)) {
        hasnextpoint = isDefined([[get_func]](nextpoint));
      }

      if(!vehicle::function_df978a2fa3318bbd()) {
        thread vehicle_code::vehicle_landanims(nextpoint.script_unload, hasnextpoint);
      }
    }

    if(!isDefined(lastpoint)) {
      if(isDefined(self.path_start_info)) {
        lastpoint = self.path_start_info;
      }
    }

    if(isDefined(nextpoint.script_land) && utility::issharedfuncdefined(#"helicopter", #"hash_a3ce13418d47712d")) {
      thread utility::callsharedfunc(#"helicopter", #"hash_a3ce13418d47712d", nextpoint.origin);
    }

    heli_wait_node(nextpoint, lastpoint, var_1f8d7b4146f4fe75);

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

    var_4bc864ba4959433f = 0;

    if(isDefined(nextpoint.script_flag_wait)) {
      var_4bc864ba4959433f = 1;
      utility::flag_wait(nextpoint.script_flag_wait);
    }

    if(isDefined(nextpoint.script_flag_waitopen)) {
      var_4bc864ba4959433f = 1;
      utility::flag_waitopen(nextpoint.script_flag_waitopen);
    }

    if(isDefined(nextpoint.script_ent_flag_wait)) {
      var_4bc864ba4959433f = 1;
      utility::ent_flag_wait(nextpoint.script_ent_flag_wait);
    }

    if(var_4bc864ba4959433f) {
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
      thread vehicle_lights::lights_off(nextpoint.script_vehicle_lights_off);
    }

    if(isDefined(nextpoint.script_vehicle_lights_on)) {
      thread vehicle_lights::lights_on(nextpoint.script_vehicle_lights_on);
    }

    if(isDefined(nextpoint.script_forcecolor)) {
      thread utility::script_func("forcecolor_riders", nextpoint.script_forcecolor);
    }

    lastpoint = nextpoint;

    if(!isDefined(nextpoint.target)) {
      break;
    }

    nextpoint = [[get_func]](nextpoint);

    if(!isDefined(nextpoint)) {
      nextpoint = lastpoint;
      assertmsg("<dev string:x2ec>" + lastpoint.origin);
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    vehicle_ai::delete_riders();

    if(isDefined(self.deathfunc)) {
      level thread[[self.deathfunc]](self);
      return;
    }

    self delete();
  }
}

function heli_wait_node(nextpoint, lastpoint, var_1f8d7b4146f4fe75) {
  self endon("newpath");
  self endon("cancel_heli_wait_node");
  origin = nextpoint.origin;
  angles = nextpoint.angles;

  if(isDefined(nextpoint.script_unload) || isDefined(nextpoint.script_land)) {
    unloadoffset = 0;

    if(isDefined(nextpoint.script_land)) {
      utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        unloadoffset = self.unload_land_offset;
      }
    } else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset)) {
      unloadoffset = self.unload_hover_offset;
    } else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset_max)) {
      groundorg = utility::drop_to_ground(origin, undefined, undefined, undefined, trace::create_world_contents());
      unloadoffset = origin[2] - groundorg[2];

      if(unloadoffset >= self.unload_hover_offset_max) {
        unloadoffset = self.unload_hover_offset_max;
      } else if(unloadoffset < self.unload_hover_land_height) {
        unloadoffset = self.unload_hover_land_height;
      }
    }

    nextpoint.radius = 2;

    if(vehicle_ai::has_anim_intro()) {
      animation = vehicle_ai::function_1f72bceb8e93b361();

      if(!isDefined(self.scenenode)) {
        self.scenenode = {
          #angles: angles, #origin: utility::drop_to_ground(origin, 100, -10000, undefined, trace::create_world_contents())
        };
      }

      if(!isDefined(self.scenenode.angles)) {
        self.scenenode.angles = (0, 0, 0);
      }

      origin = getstartorigin(self.scenenode.origin, self.scenenode.angles, animation);
      angles = getstartangles(self.scenenode.origin, self.scenenode.angles, animation);
      nextpoint.radius = vehicle_ai::function_3f791d10e984b5fc();
    } else if(isDefined(nextpoint.ground_pos)) {
      origin = nextpoint.ground_pos + (0, 0, unloadoffset);
    } else {
      neworg = utility::groundpos(origin) + (0, 0, unloadoffset);

      if(neworg[2] > origin[2] - 2000) {
        origin = utility::groundpos(origin) + (0, 0, unloadoffset);
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
  flag_wait = isDefined(nextpoint.script_flag_wait) && !utility::flag(nextpoint.script_flag_wait);
  flag_wait = flag_wait || isDefined(nextpoint.script_flag_waitopen) && utility::flag(nextpoint.script_flag_waitopen);
  flag_wait = flag_wait || isDefined(nextpoint.script_ent_flag_wait) && utility::ent_flag(nextpoint.script_ent_flag_wait);
  var_5bdcdba698716361 = !isDefined(nextpoint.target);
  hasdelay = isDefined(nextpoint.script_delay);

  if(isDefined(angles)) {
    yaw = angles[1];
  } else {
    yaw = 0;
  }

  if(self.health <= 0) {
    return;
  }

  if(isDefined(var_1f8d7b4146f4fe75)) {
    origin = add_z(origin, var_1f8d7b4146f4fe75);
  }

  if(isDefined(self.heliheightoverride)) {
    origin = (origin[0], origin[1], self.heliheightoverride);
  }

  self vehicle_helisetai(origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, airresistance, hasdelay, stopnode, unload, flag_wait, var_5bdcdba698716361);

  if(utility::issp()) {
    radius = nextpoint.radius;
  } else {
    radius = (nextpoint.radius ?? (nextpoint.speed ?? 60) * 6) + 200;
  }

  if(getdvarint(@ "hash_3c165272d6d3919", 0)) {
    start_pos = lastpoint.origin ?? self.origin;
    end_pos = origin;
    debug::line(start_pos, end_pos, undefined, 20, "<dev string:x3bc>");
    last_radius = lastpoint.radius ?? 10;
    debug::sphere(start_pos, last_radius, (0, 1, 0), 20, "<dev string:x3bc>");
    goal_color = stopnode || var_5bdcdba698716361 || unload || hasdelay || flag_wait ? (1, 0, 0) : (0, 1, 0);
    debug::sphere(origin, radius, goal_color, 20, "<dev string:x3bc>");

    if(nextpoint.origin != origin) {
      debug::sphere(nextpoint.origin, radius, goal_color, 20, "<dev string:x3bc>");
    }
  }

  if(isDefined(radius)) {
    self setneargoalnotifydist(radius);
    assert(radius > 0, "<dev string:x3dc>" + radius);
    utility::waittill_any("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  if(!isDefined(self)) {
    return;
  }

  trigger_process_node(nextpoint);

  if(isDefined(nextpoint.script_flag_set)) {
    self notify("<dev string:x3e8>", nextpoint, nextpoint.script_flag_set);
  } else {
    self notify("<dev string:x3e8>", nextpoint);
  }

  if(getdvarint(@ "hash_3c165272d6d3919", 0)) {
    level notify("<dev string:x3bc>");
  }

  if(isDefined(nextpoint.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {
      assertmsg("<dev string:x400>");
    }

    thread[[level.helicopter_firelinkfunk]](nextpoint);
  }

  nextpoint utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    utility::deletestruct_ref(nextpoint);
  }

  self notify("continuepath");
}

function function_4e87486ece806fb1(node, var_f886d81feaa5fab6) {
  assert(isDefined(node) || isDefined(self.attachedpath), "<dev string:x44d>");
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
      if(isDefined(self.path_start_info)) {
        lastpoint = self.path_start_info;
      }
    }

    function_222f50fae01a745a(nextpoint, lastpoint, var_f886d81feaa5fab6);

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

    var_4bc864ba4959433f = 0;

    if(isDefined(nextpoint.script_flag_wait)) {
      var_4bc864ba4959433f = 1;
      utility::flag_wait(nextpoint.script_flag_wait);
    }

    if(isDefined(nextpoint.script_flag_waitopen)) {
      var_4bc864ba4959433f = 1;
      utility::flag_waitopen(nextpoint.script_flag_waitopen);
    }

    if(var_4bc864ba4959433f) {
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
      thread vehicle_lights::lights_off(nextpoint.script_vehicle_lights_off);
    }

    if(isDefined(nextpoint.script_vehicle_lights_on)) {
      thread vehicle_lights::lights_on(nextpoint.script_vehicle_lights_on);
    }

    if(isDefined(nextpoint.script_forcecolor)) {
      thread utility::script_func("forcecolor_riders", nextpoint.script_forcecolor);
    }

    lastpoint = nextpoint;

    if(!isDefined(nextpoint.target)) {
      break;
    }

    nextpoint = [[get_func]](nextpoint);

    if(!isDefined(nextpoint)) {
      nextpoint = lastpoint;
      assertmsg("<dev string:x2ec>" + lastpoint.origin);
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    vehicle_ai::delete_riders();

    if(isDefined(self.deathfunc)) {
      level thread[[self.deathfunc]](self);
      return;
    }

    self delete();
  }
}

function function_222f50fae01a745a(nextpoint, lastpoint, var_f886d81feaa5fab6) {
  self endon("newpath");

  if(isDefined(nextpoint.script_unload) || isDefined(nextpoint.script_land)) {
    assertmsg("<dev string:x489>");
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
  flag_wait = isDefined(nextpoint.script_flag_wait) && !utility::flag(nextpoint.script_flag_wait);
  flag_wait = flag_wait || isDefined(nextpoint.script_flag_waitopen) && utility::flag(nextpoint.script_flag_waitopen);
  var_5bdcdba698716361 = !isDefined(nextpoint.target);
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
    assert(nextpoint.radius > 0, "<dev string:x3dc>" + nextpoint.radius);
    self setconfigvalue("p2p", "goalThreshold", nextpoint.radius);
  }

  if(isDefined(var_f886d81feaa5fab6)) {
    origin = add_z(origin, var_f886d81feaa5fab6);
  }

  self setconfigvalue("p2p", "goalPoint", origin);
  self setconfigvalue("p2p", "goalAngles", (0, yaw, 0));
  self waittill("near_goal");

  if(!isDefined(self)) {
    return;
  }

  trigger_process_node(nextpoint);

  if(isDefined(nextpoint.script_flag_set)) {
    self notify("<dev string:x3e8>", nextpoint, nextpoint.script_flag_set);
  } else {
    self notify("<dev string:x3e8>", nextpoint);
  }

  if(isDefined(nextpoint.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {
      assertmsg("<dev string:x400>");
    }

    thread[[level.helicopter_firelinkfunk]](nextpoint);
  }

  nextpoint utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    utility::deletestruct_ref(nextpoint);
  }

  self notify("continuepath");
}

function get_pathstruct() {
  structs = utility::getStructArray(self.target, "targetname");
  assert(structs.size != 0, "<dev string:x4c1>" + self.origin + "<dev string:x4d0>");

  if(structs.size == 1) {
    return structs[0];
  }

  filtered = [];

  foreach(struct in structs) {
    if(!isDefined(struct.script_demeanor)) {
      filtered[filtered.size] = struct;
    }
  }

  assert(filtered.size == 1, "<dev string:x4c1>" + self.origin + "<dev string:x4ee>");
  return filtered[0];
}

function getonpath(skip_attach) {
  path_start = undefined;
  type = self.vehicletype;

  if(isDefined(self.vehicle_spawner) && self.vehicle_spawner.dontgetonpath) {
    return;
  }

  if(isDefined(self.spawndata) && self.spawndata.dontgetonpath) {
    return;
  }

  if(isDefined(self.target)) {
    path_start = getvehiclenode(self.target, #targetname);

    if(vehicle::ishelicopter() && isDefined(path_start)) {
      println("<dev string:x52a>" + path_start.targetname);
      println("<dev string:x54a>" + getxhashsourcename(self.vehicletype));
      assertmsg("<dev string:x55b>");
    }

    if(!isDefined(path_start)) {
      path_start = utility::getStruct(self.target, "targetname");
    }
  }

  if(!isDefined(path_start)) {
    if(vehicle::ishelicopter()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self.attachedpath = path_start;

  if(!vehicle::ishelicopter() && !isstruct(path_start)) {
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

  thread _vehicle_paths(undefined, vehicle::ishelicopter());
}

function _vehicle_resume_named(stop_name) {
  if(utility::issharedfuncdefined(#"vehicle", #"vehicle_resume")) {
    utility::callsharedfunc(#"vehicle", #"vehicle_resume", stop_name);
    return;
  }

  resume_speed = self.vehicle_stop_named[stop_name];
  self.vehicle_stop_named[stop_name] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }

  if(self hascomponent("path")) {
    self setconfigvalue("path", "resume", 1);
  }

  if(self hascomponent("p2p")) {
    self setconfigvalue("p2p", "manualSpeed", resume_speed * 17.6);
    return;
  }

  vehicle::vehicle_resume_speed(resume_speed);
}

function _vehicle_stop_named(stop_name, acceleration, deceleration) {
  if(utility::issharedfuncdefined(#"vehicle", #"vehicle_stop")) {
    utility::callsharedfunc(#"vehicle", #"vehicle_stop", stop_name, acceleration, deceleration);
    return;
  }

  if(!isDefined(self.vehicle_stop_named)) {
    self.vehicle_stop_named = [];
  }

  assert(!isDefined(self.vehicle_stop_named[stop_name]), "<dev string:x591>");

  if(self hascomponent("p2p")) {
    self.vehicle_stop_named[stop_name] = self function_24e10bf6894fa869("p2p", "manualSpeed") * 0.056818;
  } else if(self hascomponent("c2p")) {
    self.vehicle_stop_named[stop_name] = self function_24e10bf6894fa869("path", "targetSpeed") * 0.056818;
  } else {
    self.vehicle_stop_named[stop_name] = acceleration;
  }

  vehicle::function_698648338e3e7b6d(0, acceleration, deceleration);

  if(self hascomponent("c2p")) {
    thread function_c817bde167e99ca6();
  }
}

function private function_c817bde167e99ca6() {
  self notify("da1d0c4494601884");
  self endon("da1d0c4494601884");
  self endon("resumed_path");

  while(!vehicle_code::vehicle_is_stopped()) {
    waitframe();
  }

  if(self hascomponent("path")) {
    self setconfigvalue("path", "pause", 1);
  }
}

function unload_node(node) {
  self endon("death");
  ishelicopter = vehicle::ishelicopter();
  var_45ed96868035eded = !ishelicopter && !islastnode(node);
  utility::ent_flag_set("unload_node");

  if(isDefined(node.targetname)) {
    pathnode = getnode(node.targetname, #target);

    if(isDefined(pathnode) && self.riders.size) {
      foreach(rider in self.riders) {
        if(isai(rider)) {
          rider thread utility::script_func("go_to_node", pathnode);
        }
      }
    }
  }

  if(ishelicopter) {
    if(vehicle_ai::has_anim_intro()) {
      self function_d2b8ee2e1275daaf(1);
      animation = vehicle_ai::function_1f72bceb8e93b361();
      origin = getstartorigin(self.scenenode.origin, self.scenenode.angles, animation);
      angles = getstartangles(self.scenenode.origin, self.scenenode.angles, animation);
      startorigin = self.origin;
      startangles = self.angles;
      speed = max(vehicle_ai::function_a17e8d27cb11154c(), utility::mph_to_ips(self vehicle_getspeed()));
      dist = distance(startorigin, origin);
      time = min(3, dist / speed);
      currenttime = 0;

      while(currenttime < time) {
        self vehicle_teleport(vectorlerp(startorigin, origin, currenttime / time), anglelerpquatfrac(startangles, angles, currenttime / time), 1);
        currenttime += level.framedurationseconds;
        waitframe();
      }
    } else {
      self sethoverparams(0, 0, 0);
      vehicle_code::waittill_stable(node);
    }
  } else if(var_45ed96868035eded) {
    accel = 5;
    decel = 20;
    stop_msg = "unloading_" + gettime();
    _vehicle_stop_named(stop_msg, accel, decel);
    childthread vehicle_notifyonstop();
  }

  if(node.script_noteworthy == "wait_for_flag") {
    utility::flag_wait(node.script_flag);
  }

  if(isDefined(node.script_unload)) {
    if(node.script_unload == "1") {
      node.script_unload = "default";
    }
  }

  var_9a90df07a9fe1a03 = vehicle_aianim::function_b7200b981d41e212(node.script_unload);
  script_unload = vehicle_ai::get_unload_group(node.script_unload);

  if(script_unload == "moving" && vehicle::function_df978a2fa3318bbd()) {
    vehicle_ai::unload(0, undefined, "moving");
  } else {
    var_9a90df07a9fe1a03 = vehicle_code::_vehicle_unload(script_unload);
  }

  if(vehicle_aianim::riders_unloadable(node.script_unload)) {
    self waittill("unloaded");
  }

  if(isDefined(node.script_flag_wait) || isDefined(node.script_flag_waitopen) || isDefined(node.script_delay)) {
    return var_9a90df07a9fe1a03;
  }

  if(var_45ed96868035eded) {
    self notify("resumed_path");
    _vehicle_resume_named(stop_msg);
  }

  utility::ent_flag_clear("unload_node");
  return var_9a90df07a9fe1a03;
}

function function_f535f086527bcb5c(node) {
  if(node.target.size == 1) {
    return node.target[0];
  }

  if(isDefined(node.target[self.choices[node.unique_id]])) {
    return node.target[self.choices[node.unique_id]];
  }

  return utility::random(node.target);
}

function function_fbae94e5f76ceeff() {
  if(!isDefined(self.script_unload)) {
    self.script_unload = "default";
  }

  foreach(root_node in function_49a1aee62245084()) {
    root_node function_e8bcb2225f1b8f0e([]);
  }

  return isDefined(self.target) && !arraycompare(self.target, [self]) && !arraycompare(self.rootnodes, [self]);
}

function private function_49a1aee62245084() {
  var_7237854e3be197ca = self.rootnodes;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  if(isDefined(self.targetname)) {
    prev = utility::getStructArray(self.targetname, "target");

    if(prev.size == 0) {
      assertmsg("<dev string:x5b4>" + self.origin);
      self.rootnodes = [self];
      return self.rootnodes;
    }

    roots = [];

    foreach(struct in prev) {
      roots = arraycombineunique(roots, struct function_49a1aee62245084());
    }

    self.rootnodes = roots;
    return self.rootnodes;
  }

  self.rootnodes = [self];
  return self.rootnodes;
}

function private function_e8bcb2225f1b8f0e(choices) {
  isunload = isDefined(self.script_unload);

  if(isunload) {
    if(!isDefined(self.choices)) {
      self.choices = [];
    }

    if(!isDefined(self.ground_pos)) {
      self.ground_pos = utility::groundpos(self.origin);
    }

    choices = function_c6c06162c8e6ae75(self.choices, choices);
    self.choices = choices;
  }

  var_978a6ddd4227c5d6 = 0;

  if(isstring(self.target)) {
    self.target = utility::getStructArray(self.target, "targetname");
    var_978a6ddd4227c5d6 = self.target.size > 1 && !isunload;

    if(var_978a6ddd4227c5d6 && !isDefined(self.unique_id)) {
      flags::assign_unique_id();
    }
  }

  if(isDefined(self.target)) {
    foreach(index, next in self.target) {
      if(var_978a6ddd4227c5d6) {
        choices[self.unique_id] = index;
      }

      next function_e8bcb2225f1b8f0e(choices);
    }
  }
}

function function_ce159681d679b75e() {
  if(isDefined(self.rootnodes)) {
    foreach(node in self.rootnodes) {
      node function_668194c122139323();
    }
  }
}

function private function_668194c122139323() {
  self.targetname = undefined;
  self.var_c58c73b693c2719b = undefined;
  rootnodes = self.rootnodes;

  if(!isDefined(self.script_unload)) {
    self.rootnodes = undefined;
    self.script_poi = undefined;
  }

  if(isDefined(self.target)) {
    foreach(node in self.target) {
      node function_668194c122139323();
    }
  }
}

function function_596216f58c3ed542(duration) {
  if(!isDefined(duration)) {
    duration = 100000;
  }

  if(isDefined(self.rootnodes)) {
    foreach(node in self.rootnodes) {
      sphere(node.origin, 300, (0, 1, 0), 1, duration);
      print3d(node.origin + (0, 0, 150), "<dev string:x632>", (1, 1, 1), 1, 2, duration, 1);
      print3d(node.origin + (0, 0, 100), "<dev string:x640>" + node.origin, (1, 1, 1), 1, 2, duration, 1);
      node function_584f61b8bbf3b638(isDefined(node.script_unload), duration);
    }
  }
}

function private function_584f61b8bbf3b638(is_exit, duration) {
  utility::draw_angles(self.angles, self.origin, undefined, duration, 100);

  if(isDefined(self.target)) {
    foreach(node in self.target) {
      line(self.origin, node.origin, is_exit ? (1, 0, 0) : (0, 1, 0), 1, 1, duration);

      if(isDefined(node.script_unload)) {
        sphere(node.origin, 300, (0, 0, 1), 1, duration);
        unload = node.script_unload == "<dev string:x64c>" || node.script_unload == "<dev string:x651>" ? "<dev string:x65c>" : node.script_unload;
        print3d(node.origin, "<dev string:x663>" + unload, (1, 1, 1), 1, 2, duration, 1);

        if(node.script_vehiclerefs) {
          print3d(node.origin + (0, 0, 50), "<dev string:x676>" + node.script_vehiclerefs, (1, 1, 1), 1, 2, duration, 1);
        } else if(node.script_vehiclebundle) {
          print3d(node.origin + (0, 0, 50), "<dev string:x68e>" + getxhashsourcename(node.script_vehiclebundle), (1, 1, 1), 1, 2, duration, 1);
        } else {
          print3d(node.origin + (0, 0, 50), "<dev string:x6a8>" + (node.script_vehicleref ?? "<dev string:x6bf>"), (1, 1, 1), 1, 2, duration, 1);
        }

        print3d(node.origin + (0, 0, 100), "<dev string:x640>" + node.origin, (1, 1, 1), 1, 2, duration, 1);
        print3d(node.origin + (0, 0, 150), "<dev string:x6cc>", (1, 1, 1), 1, 2, duration, 1);
      }

      if(isDefined(node.radius)) {
        print3d(node.origin - (0, 0, 50), "<dev string:x3dc>" + node.radius, (1, 1, 1), 1, 2, duration, 1);
      }

      if(isDefined(node.speed)) {
        print3d(node.origin - (0, 0, 100), "<dev string:x6db>" + node.speed, (1, 1, 1), 1, 2, duration, 1);
      }

      if(isDefined(node.script_accel)) {
        print3d(node.origin - (0, 0, 150), "<dev string:x6e6>" + node.script_accel, (1, 1, 1), 1, 2, duration, 1);
      }

      if(isDefined(node.script_decel)) {
        print3d(node.origin - (0, 0, 2000), "<dev string:x6f8>" + node.script_decel, (1, 1, 1), 1, 2, duration, 1);
      }

      node function_584f61b8bbf3b638(is_exit || isDefined(node.script_unload), duration);
    }
  }
}

# /