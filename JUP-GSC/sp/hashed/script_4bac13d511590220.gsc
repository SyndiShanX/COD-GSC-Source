/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4bac13d511590220.gsc
*************************************************/

#using script_24e4405cf93f20ed;
#using scripts\common\vehicle_aianim;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;
#namespace namespace_a1044864694a4aae;

function function_7dcad89b9c0264a6() {
  if(!isDefined(level.var_6e5ff6cae14c4081)) {
    level.var_6e5ff6cae14c4081 = [];
  }

  if(!isDefined(level.var_a8dc22c62ba69b88)) {
    level.var_a8dc22c62ba69b88 = [];
  }
}

function function_28991b23dba743d8(final_dest) {
  if(!isDefined(self.var_324836dc0d03f0a4) || self.var_324836dc0d03f0a4 < 5) {
    if(distancesquared(self.origin, final_dest) < squared(750)) {
      if(!isDefined(self.var_ed5b42425e687d18)) {
        self.var_ed5b42425e687d18 = 0;
        self.var_324836dc0d03f0a4 = 0;
      }

      if(gettime() > self.var_ed5b42425e687d18) {
        if(soundexists("veh_horn_mid_random")) {
          self playsoundonmovingent("veh_horn_mid_random");
        }

        self.var_324836dc0d03f0a4++;
        self.var_ed5b42425e687d18 = gettime() + randomintrange(200, 1000);
      }
    }
  }
}

function function_c3889abf5cd6abbf(pathdata, speed, var_5b69959df7b5f457, navmeshlayer) {
  self endon("death");
  self endon("unloaded");
  self notify("newFollowPath");
  self endon("newFollowPath");

  while(!isDefined(level.var_2814a8f25a392eaa)) {
    waitframe();
  }

  while(true) {
    function_e8730cc0c5eac096(pathdata);
    function_28991b23dba743d8(pathdata.path[pathdata.index].origin);
    adjustedspeed = function_1d917ec593f5d37(pathdata.path[pathdata.index], speed);

    if(adjustedspeed != speed) {
      self function_77320e794d35465a("p2p", "goalThreshold", adjustedspeed * 4);
    }

    result = function_8f40a2c8678f8304(self.origin, pathdata.path[pathdata.index].origin, adjustedspeed, undefined, undefined, navmeshlayer);

    if(isDefined(var_5b69959df7b5f457) && isDefined(result) && result == "path_blocked") {
      [[var_5b69959df7b5f457]]();
    }

    waitframe();
  }
}

function function_1d917ec593f5d37(node, speed) {
  if(!isDefined(node.relativespeed)) {
    return speed;
  }

  if(node.relativespeed == "slow") {
    return 20;
  }

  if(node.relativespeed == "fast") {
    return 80;
  }

  if(node.relativespeed == "furious") {
    return 128;
  }

  return speed;
}

function function_e8730cc0c5eac096(pathdata) {
  pathdata.index = (pathdata.index + pathdata.direction) % pathdata.path.size;

  if(pathdata.index < 0) {
    pathdata.index += pathdata.path.size;
  }
}

function function_26e9e22860c819ce(start_point, end_point, speed, var_91b19cfb0a78c588) {
  assert(isDefined(level.var_2814a8f25a392eaa), "scriptscp_mpvehiclesvehicle::vehicle_findNavmeshLayer must find a navmesh layer before this function is called. Or maybe this level has no navmesh?");

  if(isDefined(var_91b19cfb0a78c588)) {
    newpath = findpathcustom(start_point, getclosestpointonnavmesh(var_91b19cfb0a78c588, level.var_2814a8f25a392eaa), 0, 1, level.var_2814a8f25a392eaa);
    end_point = function_c06bd2ea8930eebf(end_point, newpath);
  } else {
    newpath = findpathcustom(start_point, getclosestpointonnavmesh(end_point, level.var_2814a8f25a392eaa), 0, 1, level.var_2814a8f25a392eaa);
  }

  if(getDvar(@ "hash_5932a654e8efe1fa") != "<dev string:x1c>") {
    foreach(index, node in newpath) {
      sphere(node, 16, (1, 1, 1), 0, 10000);

      if(isDefined(newpath[index + 1])) {
        line(node, newpath[index + 1], (0, 1, 0), 1, 0, 10000);
      }
    }
  }

  if(getDvar(@ "hash_ec592c9ed8224d75") != "<dev string:x1c>") {
    sphere(end_point, 16, (1, 1, 1), 0, 2);
  }

  if(newpath.size) {
    thread function_69695f8c7ed9c3f6(newpath, speed);
    return;
  }

  self function_77320e794d35465a("p2p", "goalPoint", self.origin);
}

function function_69695f8c7ed9c3f6(newpath, speed) {
  self endon("death");
  self notify("path_updated");
  self endon("path_updated");

  foreach(point in newpath) {
    while(istrue(self.pausing)) {
      wait 0.05;
    }

    if(isstruct(point)) {
      point = point.origin;
    }

    self function_77320e794d35465a("p2p", "goalPoint", point);
    dist = distancesquared(self.origin, point);
    time = undefined;

    if(dist > 0) {
      time = function_cbc170d40c70cddf(self.origin, point, speed);
    }

    key = function_906e53c2fb9d3f9c("p2p", "targetTime");

    if(isDefined(time)) {
      self function_77320e794d35465a(key, time);
    } else {
      self function_77320e794d35465a(key, 0.2);
    }

    while(distancesquared(self.origin, point) > squared(200)) {
      waitframe();
    }
  }

  self notify("path_finished");
}

function fn_damagefeedback(hittype) {
  if(hittype == "hitveharmorbreak") {
    level notify("armorplate_broken", self);
  }

  if(isPlayer(self)) {
    if(issharedfuncdefined("damage", "updateDamageFeedback")) {
      self[[getsharedfunc("damage", "updateDamageFeedback")]](hittype);
    }
  }
}

function function_6a0b2a08499a9842() {
  if(isDefined(self.aidriver)) {
    self.aidriver.var_71c1911e983f326d = undefined;
  }

  origin = self.origin + (0, 0, 40);

  foreach(rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }

    rider.do_immediate_ragdoll = 1;
    rider.ragdoll_immediate = 1;

    if(!istrue(rider._blackboard.vehiclerequested)) {
      anim_pos = scripts\common\vehicle_aianim::anim_pos(self, rider.vehicle_position);
      rider scripts\vehicle\vehicle_common::requestentervehicle(self, 0, rider.vehicle_position, anim_pos);
    }

    if(isDefined(rider._blackboard) && isDefined(rider._blackboard.chosenvehicleanimpos)) {
      if(istrue(rider._blackboard.var_41c9f8c7891f19da)) {
        rider._blackboard.var_80912ec8ade08716 = 1;
      }
    }

    rider dodamage(rider.health + 100, self.origin + (0, 0, -100), undefined, undefined, "MOD_EXPLOSIVE");
  }
}

function function_6a9574988f246f34(vehicle, var_7f2253bd1b8cfa5e, flippedendcallback, endnotify) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle endon("stop_chasing");

  if(isDefined(endnotify)) {
    vehicle endon(endnotify);
  }

  usedisabled = 0;
  endtime = undefined;
  var_4f951428959d4d04 = cos(91);

  while(true) {
    dot = anglestoup(vehicle.angles)[2];

    if(dot <= var_4f951428959d4d04) {
      if(isDefined(var_7f2253bd1b8cfa5e)) {
        thread[[var_7f2253bd1b8cfa5e]](vehicle);
      }

      timedout = 0;
      endtime = gettime() + 3000;

      while(true) {
        if(vectordot(anglestoup(vehicle.angles), (0, 0, 1)) > var_4f951428959d4d04) {
          break;
        }

        if(gettime() >= endtime) {
          timedout = 1;
          break;
        }

        waitframe();
      }

      endtime = undefined;

      if(isDefined(flippedendcallback)) {
        thread[[flippedendcallback]](vehicle, timedout);
      }
    }

    wait 1;
  }
}

function function_a3775811155639ea() {
  self endon("death");
  self endon("stop_chasing");
  cos_25 = cos(25);

  while(true) {
    wait 0.05;
    vehicles_close = [];

    foreach(vehicle in level.var_6e5ff6cae14c4081) {
      if(!isalive(vehicle)) {
        continue;
      }

      if(vehicle == self) {
        continue;
      }

      if(istrue(vehicle.pausing)) {
        continue;
      }

      if(distancesquared(self.origin, vehicle.origin) < squared(128)) {
        self.pausing = 1;
        self vehicle_setspeedimmediate(20, 150, 150);

        if(getDvar(@ "hash_ec592c9ed8224d75") != "<dev string:x1c>") {
          print3d(self.origin + (0, 0, 40), "<dev string:x1d>", (1, 1, 1), 1, 1, 20, 1);
        }

        wait 2;
        self.pausing = undefined;
        self resumespeed(150);
        continue;
      }

      if(distancesquared(self.origin, vehicle.origin) < squared(250) && within_fov(self.origin, self.angles, vehicle.origin, cos_25)) {
        self.pausing = 1;
        self vehicle_setspeedimmediate(20, 150, 150);

        if(getDvar(@ "hash_ec592c9ed8224d75") != "<dev string:x1c>") {
          print3d(self.origin + (0, 0, 40), "<dev string:x1d>", (1, 1, 1), 1, 1, 20, 1);
        }

        wait 2;
        self.pausing = undefined;
        self resumespeed(150);
      }
    }
  }
}

function function_be6d24ea93bcadf7(vehicle) {
  newpath = function_3a2f47ea8b6a51b3(vehicle.origin, 16, 1024);

  while(isDefined(vehicle) && vehicle vehicle_getspeed() < 2) {
    thread function_69695f8c7ed9c3f6(newpath, 300);
    self waittill("path_finished");
  }

  self notify("path_updated");
}

function function_cba4ff426a2f58ab(pos, delay) {
  self endon("death");

  if(isDefined(delay)) {
    wait delay;
  } else {
    wait 2;
  }

  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

function function_1da2c31423c2676a(veh_speed) {
  if(!isDefined(self.riders)) {
    self.riders = [];
  }

  if(!isDefined(self.unloadque)) {
    self.unloadque = [];
  }

  self addcomponent("p2p");
  thread function_4808177c29f56fb9();
}

function function_8f40a2c8678f8304(start_point, end_point, speed, setmaxspeed, var_a967646668185a6d, navmeshlayer) {
  navmeshlayer = default_to(navmeshlayer, level.var_2814a8f25a392eaa);
  assert(isDefined(level.var_2814a8f25a392eaa), "scriptscp_mpvehiclesvehicle::vehicle_findNavmeshLayer must find a navmesh layer before this function is called. Or maybe this level has no navmesh?");
  var_acb8205b4eae2fa0 = undefined;

  if(!isDefined(setmaxspeed)) {
    setmaxspeed = 1;
  }

  if(!isDefined(var_a967646668185a6d)) {
    var_a967646668185a6d = 0;
  }

  if(distancesquared(start_point, end_point) < 62500) {
    var_acb8205b4eae2fa0 = [getclosestpointonnavmesh(end_point, navmeshlayer)];
  } else {
    var_acb8205b4eae2fa0 = findpathcustom(start_point, getclosestpointonnavmesh(end_point, navmeshlayer), 1, 1, navmeshlayer);
    var_acb8205b4eae2fa0[0] = undefined;

    if(getDvar(@ "hash_5932a654e8efe1fa") != "<dev string:x1c>") {
      foreach(index, node in var_acb8205b4eae2fa0) {
        thread scripts\cp_mp\utility\debug_utility::drawsphere(node, 16, 10000, (1, 1, 1));

        if(isDefined(var_acb8205b4eae2fa0[index + 1])) {
          thread scripts\cp_mp\utility\debug_utility::drawline(node, var_acb8205b4eae2fa0[index + 1], 10000, (0, 1, 0));
        }
      }
    }

    if(getDvar(@ "hash_ec592c9ed8224d75") != "<dev string:x1c>") {
      sphere(end_point, 16, (1, 1, 1), 0, 2);
    }
  }

  if(var_acb8205b4eae2fa0.size >= 1) {
    return function_aa85eb39828a4d80(var_acb8205b4eae2fa0, speed, setmaxspeed, var_a967646668185a6d);
  }
}

function function_aa85eb39828a4d80(var_acb8205b4eae2fa0, speed, setmaxspeed, var_a967646668185a6d) {
  self notify("path_updated");
  self endon("path_updated");
  self endon("kill_thread_since_spotted");
  self endon("death");
  self endon("unloaded");

  if(!isDefined(speed) && !isDefined(self.var_5bbf95f73f01706e)) {
    assertmsg("vehicleP2P_gotoPath - No speed defined, and no AUTO_* Config Key detected!");
    return "path_blocked";
  }

  if(istrue(setmaxspeed) && isDefined(speed)) {
    function_b3b7d0915dc445c7(speed);
  }

  last_point = undefined;

  if(istrue(var_a967646668185a6d)) {
    last_point = scripts\engine\utility::function_350e192b13bea45c(var_acb8205b4eae2fa0);
  }

  foreach(point in var_acb8205b4eae2fa0) {
    var_8ffa366ec68f0c8b = 62500;

    if(isDefined(self.var_8ffa366ec68f0c8b)) {
      var_8ffa366ec68f0c8b = self.var_8ffa366ec68f0c8b;
    }

    if(distancesquared(self.origin, point) < var_8ffa366ec68f0c8b) {
      continue;
    }

    self function_77320e794d35465a("p2p", "goalPoint", point);

    if(istrue(var_a967646668185a6d) && point == last_point) {
      self function_77320e794d35465a("p2p", "brakeAtGoal", 1);
    }

    self.goalpoint = point;

    if(!istrue(setmaxspeed) && isDefined(speed)) {
      dist = distance(self.origin, point);
      time = undefined;

      if(dist > 0) {
        time = function_cbc170d40c70cddf(self.origin, point, speed);
      }

      key = function_906e53c2fb9d3f9c("p2p", "targetTime");

      if(isDefined(time)) {
        self function_77320e794d35465a(key, time);
      } else {
        self function_77320e794d35465a(key, 0.2);
      }
    }

    result = waittill_any_return_2("near_goal", "path_blocked");

    if(result == "path_blocked") {
      return "path_blocked";
    }
  }

  return "near_goal";
}

function function_b3b7d0915dc445c7(speed) {
  manualspeed = function_906e53c2fb9d3f9c("p2p", "manualSpeed");
  self function_77320e794d35465a(manualspeed, scripts\engine\utility::mph_to_ips(speed));
}

function function_9804c82501de981b(newpath, speed) {
  self endon("death");
  self notify("path_updated");
  self endon("path_updated");

  foreach(point in newpath) {
    while(istrue(self.pausing)) {
      wait 0.05;
    }

    if(isstruct(point)) {
      point = point.origin;
    }

    self function_77320e794d35465a("p2p", "goalPoint", point);
    dist = distancesquared(self.origin, point);
    time = undefined;

    if(dist > 0) {
      time = get_duration_between_points(self.origin, point, speed);
    }

    key = function_906e53c2fb9d3f9c("p2p", "targetTime");

    if(isDefined(time)) {
      self function_77320e794d35465a(key, time);
    } else {
      self function_77320e794d35465a(key, 0.2);
    }

    while(distancesquared(self.origin, point) > squared(200)) {
      waitframe();
    }
  }

  self notify("path_finished");
}

function get_duration_between_points(startpos, endpos, speed, convert) {
  dist = distance(startpos, endpos);

  if(istrue(convert)) {
    dist *= 0.0568182;
  }

  moverate = dist / speed;

  if(moverate < 0.05) {
    moverate = 0.05;
  }

  return moverate;
}