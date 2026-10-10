/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2b736eb3fdd9b328.gsc
*************************************************/

#using script_1174abedbefe9ada;
#using script_1c47017ba325709a;
#using script_24e4405cf93f20ed;
#using script_4bac13d511590220;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\poi;
#namespace namespace_9e3d69dfe999c1f;

function function_a9e26388b8dc22b3() {
  assert(!isDefined(level.var_ad58c9c70a5db5bb));
  level.var_ad58c9c70a5db5bb = [];
  scripts\mp\flags::gameflaginit("vehicle_patrol_paths_selected", 0);
  level.var_5731a15ecc971a53 = getdvarint(@ "hash_71a6a8a8255b301f", 30);

  for(pathnum = 1; true; pathnum++) {
    pathnodes = getStructArray("vehiclePatrol_" + pathnum, "script_noteworthy");

    if(pathnodes.size == 0) {
      break;
    }

    level.var_ad58c9c70a5db5bb[level.var_ad58c9c70a5db5bb.size] = scripts\mp\ai_mp_controller::function_9edcf99159abb0b(pathnodes[0], 1);
  }

  if(false) {
    level thread function_5ae87677f3f767f0();
  }

  function_7bb5daf93766fb3d();
}

function function_7bb5daf93766fb3d() {
  assert(isDefined(level.var_ad58c9c70a5db5bb));
  level.var_f2c3218ec87ba30f = [];

  switch (level.mapname) {
    case #"hash_57eba45b7ddbdcd6":
    case #"hash_63326ac3e12f8da0":
      groups = [[0], [1], [2, 3, 4], [5, 6, 7], [5, 8, 9], [10]];

      foreach(group in groups) {
        var_a82af88aa7f18b2c = 0;

        foreach(member in group) {
          if(isDefined(level.var_f2c3218ec87ba30f[member])) {
            var_a82af88aa7f18b2c = 1;
            break;
          }
        }

        if(var_a82af88aa7f18b2c) {
          continue;
        }

        spawnindex = random(group);

        if(isDefined(level.var_ad58c9c70a5db5bb[spawnindex])) {
          level.var_f2c3218ec87ba30f[spawnindex] = 1;
        }
      }

      break;
    default:
      foreach(pathnum, pathdata in level.var_ad58c9c70a5db5bb) {
        level.var_f2c3218ec87ba30f[pathnum] = 1;
      }

      break;
  }

  level.var_9e7adb59a0cb3e3d = [];

  foreach(i, pathstruct in level.var_ad58c9c70a5db5bb) {
    if(!isDefined(level.var_f2c3218ec87ba30f[i])) {
      level.var_9e7adb59a0cb3e3d[level.var_9e7adb59a0cb3e3d.size] = pathstruct;
    }
  }

  scripts\mp\flags::gameflagset("vehicle_patrol_paths_selected");
}

function function_cbae2bd62d2e7086() {
  foreach(pathnum, value in level.var_f2c3218ec87ba30f) {
    function_8263f9488230c012(level.var_ad58c9c70a5db5bb[pathnum], pathnum, "veh9_techo_rebel_armor");
  }

  var_f228e29ae46b2fe6 = 0;

  if(false) {
    var_f228e29ae46b2fe6 = 1;
  }

  if(!var_f228e29ae46b2fe6) {
    level.var_ad58c9c70a5db5bb = undefined;
    return;
  }

  foreach(pathnum, pathdata in level.var_ad58c9c70a5db5bb) {
    pathdata.spawned = isDefined(level.var_f2c3218ec87ba30f[pathnum]);
  }
}

function private function_8263f9488230c012(pathdata, pathnum, vehicletype) {
  if(!scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1(vehicletype)) {
    return;
  }

  pathdata.direction = cointoss() * 2 - 1;
  pathdata.index = randomint(pathdata.path.size);
  reinforcenode = pathdata.path[pathdata.index];

  if(isDefined(level.vehiclepatrolspawns)) {
    for(i = 0; i < pathdata.path.size - 1; i++) {
      pathdata.index = (pathdata.index + 1) % pathdata.path.size;
      reinforcenode = pathdata.path[pathdata.index];
      closestspawn = sortbydistance(level.vehiclepatrolspawns, reinforcenode.origin)[0];

      if(distance(closestspawn.origin, reinforcenode.origin) > 4000) {
        break;
      }
    }
  }

  reinforceorigin = reinforcenode.origin;
  vehicle = function_3bdd3d9028bada3f(reinforceorigin, reinforcenode.angles, pathdata.direction, vehicletype, pathnum);

  if(!isDefined(vehicle)) {
    return;
  }

  if(scripts\mp\ai_mp_controller::function_8b178e05801f2daf(pathdata.path)) {
    foreach(rider in vehicle.riders) {
      scripts\mp\ai_mp_controller::function_c9b9fe3f7f739586(rider);
    }
  }

  if(!isDefined(level.vehiclepatrolspawns)) {
    level.vehiclepatrolspawns = [];
  }

  level.vehiclepatrolspawns[level.vehiclepatrolspawns.size] = reinforcenode;
  vehicle namespace_9246f10206f50768::function_1da2c31423c2676a(level.var_5731a15ecc971a53);
  vehicle function_77320e794d35465a("p2p", "brakeAtGoal", 0);
  vehicle function_77320e794d35465a("p2p", "goalThreshold", level.var_5731a15ecc971a53 * 4);
  vehicle function_77320e794d35465a("p2p", "steeringMultiplier", 2.5);
  vehicle function_77320e794d35465a("p2p", "stuckTime", 4);
  vehicle.pathdata = pathdata;
  vehicle thread namespace_9246f10206f50768::function_c3889abf5cd6abbf(pathdata, level.var_5731a15ecc971a53, &function_8667ff5c61e579ed);
  vehicle thread function_205a864c4dddc0ea(pathdata);

  if(false) {
    vehicle thread function_1c78f4e319f7100e();
  }
}

function private function_3bdd3d9028bada3f(origin, angles, direction, vehicletype, pathnum) {
  poiname = scripts\mp\poi::function_6cc445c02b5effac(origin);

  if(!scripts\mp\poi::poi_ispoiactive(poiname)) {
    return;
  }

  agenttypes = namespace_43bf74a2ee9234c0::function_236a093e8a0ec040(vehicletype);
  spawners = namespace_43bf74a2ee9234c0::function_f260b1cef943f1ab(vehicletype, 5, agenttypes, origin, poiname, "medium");
  riders = namespace_43bf74a2ee9234c0::function_4ad6c25d6754f697(spawners, 5, undefined, "medium", "vehiclePatrol", "patrol_" + pathnum, "team_hundred_ninety_five", undefined, vehicletype);

  if(!isDefined(riders) || riders.size == 0) {
    return;
  }

  foreach(rider in riders) {
    rider.var_c7845d939c783cef = 1;
  }

  spawndata = spawnStruct();
  spawndata.origin = origin;
  spawndata.angles = ter_op(direction > 0, angles, angles + (0, 180, 0));
  spawndata.spawntype = "GAME_MODE";
  spawndata.team = "team_hundred_ninety_five";
  spawndata.showheadicon = 1;
  spawndata.initai = 1;
  faildata = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(vehicletype, spawndata, faildata);

  if(!isDefined(vehicle)) {
    return;
  }

  vehicle.var_eb504fc7e1cfeb4c = getdvarint(@ "hash_9e4fff9024bd3a06", 1);
  waitframe();
  vehicle scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6(riders, 1, 1);

  if(isDefined(level.var_6e5ff6cae14c4081)) {
    level.var_6e5ff6cae14c4081[level.var_6e5ff6cae14c4081.size] = vehicle;
  }

  return vehicle;
}

function private function_205a864c4dddc0ea(pathdata) {
  self endon("death");

  while(!isDefined(self.aidriver)) {
    waitframe();
  }

  self.lastlocation = self.origin;
  self.var_84fb7053ab953427 = gettime();
  self.var_3d3dbb75643cce31 = 1;
  healthdamagetime = gettime();
  lasthealth = self.health;

  foreach(rider in self.riders) {
    thread function_9ec2524e968c9eb2(rider, rider == self.aidriver);
  }

  while(!istrue(self.beginningunload)) {
    if(isDefined(self.var_3d3dbb75643cce31) && self.var_3d3dbb75643cce31 <= 0 || lasthealth - self.health > 25) {
      if(false) {
        print3d(self.origin + (0, 0, 100), "<dev string:x1c>", (1, 1, 1), 1, 4, 100000);
      }

      thread function_ab0ee2215eb51dd5("combat");
      return;
    }

    if(gettime() - healthdamagetime > 3000) {
      healthdamagetime = gettime();
      lasthealth = self.health;
    }

    if(distancesquared(self.origin, self.lastlocation) > 22500) {
      self.var_84fb7053ab953427 = gettime();
      self.lastlocation = self.origin;
    } else if(gettime() - self.var_84fb7053ab953427 > 12000 || isDefined(self.goalpoint) && namespace_7789f919216d38a2::radiation_isinradiation(self.goalpoint)) {
      if(false) {
        print3d(self.origin + (0, 0, 100), "<dev string:x3b>", (1, 1, 1), 1, 4, 100000);
      }

      function_8667ff5c61e579ed();
    }

    waitframe();
  }
}

function private function_9ec2524e968c9eb2(rider, isdriver) {
  self endon("death");
  self endon("unloaded");
  rider waittill("death");

  if(!isDefined(self) || !isDefined(self.var_3d3dbb75643cce31)) {
    return;
  }

  self.var_3d3dbb75643cce31 -= ter_op(isdriver, 2, 1);
}

function function_8667ff5c61e579ed() {
  if(isDefined(self.var_9c986f0fa4fce8ea) && gettime() - self.var_9c986f0fa4fce8ea > 10000) {
    if(false) {
      print3d(self.origin + (0, 0, 100), "<dev string:x63>", (1, 1, 1), 1, 4, 100000);
    }

    thread function_ab0ee2215eb51dd5();
    return;
  }

  self.var_9c986f0fa4fce8ea = gettime();
  self.var_84fb7053ab953427 = gettime();
  self.lastlocation = self.origin;
  self.pathdata.direction *= -1;
  namespace_9246f10206f50768::function_e8730cc0c5eac096(self.pathdata);
  thread namespace_9246f10206f50768::function_c3889abf5cd6abbf(self.pathdata, level.var_5731a15ecc971a53, &function_8667ff5c61e579ed);
}

function private function_865676e356a22103() {
  return distancesquared(self.origin, getclosestpointonnavmesh(self.origin)) < 10000;
}

function function_ab0ee2215eb51dd5(exittype) {
  self.var_9c986f0fa4fce8ea = undefined;
  self.var_84fb7053ab953427 = undefined;
  self.lastlocation = undefined;
  self.pathdata = undefined;
  self.var_3d3dbb75643cce31 = undefined;
  self.beginningunload = 1;
  self notify("newFollowPath");

  if(!function_865676e356a22103()) {
    self.burndowntime = 4;
    scripts\cp_mp\vehicles\vehicle_spawn::function_357783d7c1d96273();
    return;
  }

  self endon("death");
  namespace_cbe993018617a21d::function_7d8f81a94dc08a15(1, exittype);
  scripts\cp_mp\vehicles\vehicle_occupancy::function_887b4e2cbe3ab92c();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
}

function function_6994a068636ec457() {
  setDvar(@ "hash_708c27714785445c", 0);

  while(true) {
    wait 1;

    if(getdvarint(@ "hash_708c27714785445c", 0) == 1) {
      setDvar(@ "hash_708c27714785445c", 0);
      angles = level.players[0].angles;
      origin = level.players[0].origin + anglesToForward(angles) * 400;
      function_3bdd3d9028bada3f(origin, angles, -1, "<dev string:x8d>", 0);
    }
  }
}

function private function_5ae87677f3f767f0() {
  wait 20;

  if(!isDefined(level.var_ad58c9c70a5db5bb)) {
    return;
  }

  foreach(pathdata in level.var_ad58c9c70a5db5bb) {
    for(i = 0; i < pathdata.path.size; i++) {
      startnode = pathdata.path[i];
      endnode = pathdata.path[(i + 1) % pathdata.path.size];
      line(startnode.origin, endnode.origin, ter_op(istrue(pathdata.spawned), (0, 1, 0), (0, 0, 1)), 1, 0, 100000);
    }
  }

  while(isDefined(level.var_ad58c9c70a5db5bb)) {
    foreach(pathnum, pathdata in level.var_ad58c9c70a5db5bb) {
      foreach(node in pathdata.path) {
        if(isDefined(level.players[0]) && isDefined(level.players[0].origin) && distancesquared(node.origin, level.players[0].origin) < 9000000) {
          print3d(node.origin + (0, 0, 10 * pathnum), "<dev string:xa7>" + pathnum, (1, 1, 1));
        }
      }
    }

    waitframe();
  }
}

function private function_1c78f4e319f7100e() {
  self endon("<dev string:xab>");
  start = self.origin + (0, 0, 50);
  end = self.origin + anglesToForward(self.angles) * 400 + (0, 0, 50);

  for(prevpos = self.origin; true; prevpos = self.origin) {
    wait 1;
    line(start, end, (1, 1, 1), 1, 0, 20);
    sphere(start, 100, (1, 1, 1), 0, 20);
    line(self.origin + (0, 0, 200), self.origin + (0, 0, 800), (1, 0, 0), 1, 0, 20);
    line(self.origin, prevpos, (1, 0, 1), 1, 0, 10000);

    if(isDefined(self.goalpoint)) {
      line(self.origin, self.goalpoint, (0, 1, 0), 1, 0, 20);
    }
  }
}

# /