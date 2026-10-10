/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_f3b4a4783ede654.gsc
************************************************/

#using script_24e4405cf93f20ed;
#using scripts\common\utility;
#using scripts\cp\damagefeedback;
#using scripts\cp\laststand;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\engine\utility;
#namespace namespace_2a181c7ed170fc79;

function armored_vehicle() {
  self.var_9acfc0bd86b2e2c1 = &fn_damagefeedback;
  self.fn_death = &function_6a0b2a08499a9842;
  function_66b0113fe0bf4a88(self);
}

function fn_damagefeedback(hittype) {
  if(hittype == "hitveharmorbreak") {
    level notify("armorplate_broken", self);
  }

  scripts\cp\damagefeedback::updatedamagefeedback(hittype);
}

function function_1719eb8cd9e18f2d() {
  self endon("drove_away");
  thread function_f4d3d0edd18649cb();
}

function function_ab23ae9a33e231fe() {
  self removecomponent("p2p");
}

function function_f4d3d0edd18649cb() {
  self endon("death");
  self endon("stop_chasing");
  self endon("unloaded");
  self endon("driverdeath");
  self addcomponent("p2p");
  self function_77320e794d35465a("p2p", "brakeAtGoal", 0);
  self function_77320e794d35465a("p2p", "goalThreshold", 128);
  self function_77320e794d35465a("p2p", "steeringMultiplier", 2.5);
  self function_77320e794d35465a("p2p", "stuckTime", 4);
  thread function_58c9bbddc21b16ca();
  level thread vehicle_watchflipped(self, &flippedstart);

  if(!isDefined(level.var_6e5ff6cae14c4081)) {
    level.var_6e5ff6cae14c4081 = [];
  }

  if(!array_contains(level.var_6e5ff6cae14c4081, self)) {
    level.var_6e5ff6cae14c4081[level.var_6e5ff6cae14c4081.size] = self;
  }

  veh_speed = 4000;

  if(isDefined(self.vehicle_spawner) && isDefined(self.vehicle_spawner.speed)) {
    veh_speed = self.vehicle_spawner.speed;
  }

  thread function_268d401afde15f5d();
  ticks = 0;
  var_351502b59e0b2e47 = 0;
  var_6519ab119008aad4 = 100;
  var_f08a38441765c6f = 8;
  var_28b139524196455b = 15;
  prevpos = undefined;
  self.var_393832bcec3afd03 = self.riders;

  while(true) {
    wait 0.2;
    veh_speed = 4000;

    if(isDefined(self.vehicle_spawner) && isDefined(self.vehicle_spawner.speed)) {
      veh_speed = self.vehicle_spawner.speed;
    }

    player_vehicles = [];
    var_bffb55e2f8be21ef = undefined;
    closest_player = undefined;

    foreach(player in level.players) {
      if(!isDefined(player.vehicle)) {
        continue;
      }

      player_vehicles[player_vehicles.size] = player.vehicle;
    }

    if(player_vehicles.size) {
      var_bffb55e2f8be21ef = getclosest(self.origin, player_vehicles);
    }

    final_dest = undefined;

    if(isDefined(var_bffb55e2f8be21ef) && function_f32c4025f3271080(var_bffb55e2f8be21ef)) {
      if(!istrue(var_bffb55e2f8be21ef.var_11437de736f62cb7)) {
        var_bffb55e2f8be21ef thread function_2bf62999798d0b53();
        var_bffb55e2f8be21ef.var_11437de736f62cb7 = 1;
      }

      waittillframeend();
      dest = var_bffb55e2f8be21ef function_d866a6b5497200c5(self);
      final_dest = dest.origin;
      lead_amount = 100;

      if(isDefined(self.leading_magnitude)) {
        lead_amount = self.leading_magnitude;
      }

      var_fb957ab80e292860 = final_dest + anglesToForward(var_bffb55e2f8be21ef.angles) * lead_amount;
      var_5b7feb61dd19201b = isnavmeshloaded("vehicle_med") ? "vehicle_med" : "tank_med";
      var_fb957ab80e292860 = getclosestpointonnavmesh(var_fb957ab80e292860, var_5b7feb61dd19201b);
    } else {
      closest_player = get_closest_living_player();

      if(!isDefined(closest_player)) {
        wait 1;
        continue;
      }

      if(!istrue(closest_player.var_11437de736f62cb7)) {
        closest_player thread function_f0a7e47a3ffdefb6();
        closest_player.var_11437de736f62cb7 = 1;
      }

      dest = closest_player function_d866a6b5497200c5(self);
      final_dest = dest.origin;
      var_fb957ab80e292860 = final_dest;
      var_5b7feb61dd19201b = isnavmeshloaded("vehicle_med") ? "vehicle_med" : "tank_med";
      var_fb957ab80e292860 = getclosestpointonnavmesh(var_fb957ab80e292860, var_5b7feb61dd19201b);
    }

    if(distancesquared(var_fb957ab80e292860, self.origin) > squared(800)) {
      if(isDefined(prevpos)) {
        if(distancesquared(prevpos, self.origin) < squared(100)) {
          var_351502b59e0b2e47++;

          if(var_351502b59e0b2e47 > var_6519ab119008aad4) {
            if(self isnearanyplayer(3000)) {
              thread namespace_cbe993018617a21d::unloadvehicle();
              return;
            } else {
              self dodamage(self.health + 10000, self.origin);
            }
          }
        }
      }

      prevpos = self.origin;
    } else {
      var_351502b59e0b2e47 = 0;
    }

    if(isDefined(var_bffb55e2f8be21ef)) {
      var_d92a8ee9e2c8eeb6 = var_bffb55e2f8be21ef vehicle_getspeed();

      if(var_d92a8ee9e2c8eeb6 < 2 && distancesquared(self.origin, var_bffb55e2f8be21ef.origin) < squared(750)) {
        ticks++;

        if(ticks > var_28b139524196455b) {
          thread namespace_cbe993018617a21d::unloadvehicle();
          return;
        }
      } else {
        ticks = 0;
      }
    } else if(isDefined(closest_player)) {
      if(distancesquared(self.origin, closest_player.origin) < squared(750)) {
        ticks++;

        if(ticks > var_f08a38441765c6f) {
          thread namespace_cbe993018617a21d::unloadvehicle();
          return;
        }
      } else {
        ticks = 0;
      }
    }

    if(function_b67104292a9ddcf6()) {
      unloaded = function_fb08b61559c93460();

      if(unloaded) {
        return;
      }

      continue;
    }

    function_b55351cf0020d1b8(final_dest);

    if(distancesquared(self.origin, final_dest) < squared(256)) {
      veh_speed *= 0.5;
    }

    function_26e9e22860c819ce(self.origin, final_dest, veh_speed, var_fb957ab80e292860);
  }
}

function function_e690609c7d9a8dbc(vehicle) {
  if(!isDefined(level.var_6e5ff6cae14c4081)) {
    level.var_6e5ff6cae14c4081 = [];
  }

  if(!array_contains(level.var_6e5ff6cae14c4081, vehicle)) {
    level.var_6e5ff6cae14c4081[level.var_6e5ff6cae14c4081.size] = vehicle;
  }
}

function function_b55351cf0020d1b8(final_dest) {
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

function function_268d401afde15f5d() {
  self endon("death");

  while(!isDefined(self.aidriver)) {
    wait 0.5;
  }

  self.aidriver.var_71c1911e983f326d = &function_dc9b96be6aa3c3c0;
}

function function_b67104292a9ddcf6() {
  if(!isDefined(level.var_da571aa94ad22ce7) || level.var_da571aa94ad22ce7.size == 0) {
    return 0;
  }

  return function_1b81d51d30e14e95();
}

function function_2bf62999798d0b53() {
  self endon("death");
  self.var_3749eb0f11873d37 = spawnStruct();
  self.var_5da685db7d347340 = spawnStruct();
  self.var_29a8c62dd19d607e = spawnStruct();
  self.var_fd592ba2b21e3b2d = spawnStruct();
  self.var_4a35ce0251802293 = spawnStruct();
  self.var_adea6e80b5cbfbe2 = spawnStruct();
  var_5b7feb61dd19201b = isnavmeshloaded("vehicle_med") ? "vehicle_med" : "tank_med";

  while(true) {
    fwd = anglesToForward((0, self.angles[1], 0));
    var_cbac2203146ae84a = anglestoright((0, self.angles[1], 0));
    fwd_mag = 250;
    var_6d5e7baf4106d1dd = -250;

    if(isDefined(self.var_c72f42ebc770215f)) {
      fwd_mag = self.var_c72f42ebc770215f;
    }

    if(isDefined(self.var_b9428297abb94a7e)) {
      var_6d5e7baf4106d1dd = self.var_b9428297abb94a7e;
    }

    self.var_3749eb0f11873d37.origin = getclosestpointonnavmesh(self.origin + var_cbac2203146ae84a * 190 + fwd * fwd_mag, var_5b7feb61dd19201b);
    self.var_5da685db7d347340.origin = getclosestpointonnavmesh(self.origin + var_cbac2203146ae84a * -190 + fwd * fwd_mag, var_5b7feb61dd19201b);
    self.var_4a35ce0251802293.origin = getclosestpointonnavmesh(self.origin + fwd * -500, var_5b7feb61dd19201b);
    wait 0.05;
  }
}

function function_f0a7e47a3ffdefb6() {
  self endon("death");
  self.var_3749eb0f11873d37 = spawnStruct();
  self.var_5da685db7d347340 = spawnStruct();
  self.var_4a35ce0251802293 = spawnStruct();
  var_5b7feb61dd19201b = isnavmeshloaded("vehicle_med") ? "vehicle_med" : "tank_med";

  while(true) {
    fwd = anglesToForward((0, self.angles[1], 0));
    var_cbac2203146ae84a = anglestoright((0, self.angles[1], 0));
    fwd_mag = 250;
    var_6d5e7baf4106d1dd = -250;

    if(isDefined(self.var_c72f42ebc770215f)) {
      fwd_mag = self.var_c72f42ebc770215f;
    }

    if(isDefined(self.var_b9428297abb94a7e)) {
      var_6d5e7baf4106d1dd = self.var_b9428297abb94a7e;
    }

    self.var_3749eb0f11873d37.origin = getclosestpointonnavmesh(self.origin + var_cbac2203146ae84a * 190 + fwd * fwd_mag, var_5b7feb61dd19201b);
    self.var_5da685db7d347340.origin = getclosestpointonnavmesh(self.origin + var_cbac2203146ae84a * -190 + fwd * fwd_mag, var_5b7feb61dd19201b);
    self.var_4a35ce0251802293.origin = getclosestpointonnavmesh(self.origin, var_5b7feb61dd19201b);
    wait 1;
  }
}

function function_d866a6b5497200c5(enemy_veh) {
  if(isDefined(enemy_veh.claimed_pos) && gettime() <= enemy_veh.claimed_pos.claimrelease) {
    return enemy_veh.claimed_pos;
  }

  if(isDefined(enemy_veh.claimed_pos)) {
    enemy_veh.claimed_pos.claimed = undefined;
    enemy_veh.claimed_pos = undefined;
  }

  available_pos = [];
  var_7ebb34cae2c736f2 = undefined;
  level.var_6e5ff6cae14c4081 = array_removeundefined(level.var_6e5ff6cae14c4081);
  level.var_6e5ff6cae14c4081 = array_removedead(level.var_6e5ff6cae14c4081);
  positions = [self.var_3749eb0f11873d37, self.var_5da685db7d347340];

  foreach(pos in positions) {
    if(istrue(pos.blocked)) {
      continue;
    }

    if(isDefined(pos.claimed)) {
      continue;
    }

    closest = getclosest(pos.origin, level.var_6e5ff6cae14c4081);

    if(isDefined(closest) && closest != enemy_veh && !isDefined(closest.claimed_pos) && distancesquared(closest.origin, pos.origin) < distancesquared(enemy_veh.origin, pos.origin)) {
      continue;
    }

    available_pos[available_pos.size] = pos;
  }

  if(available_pos.size) {
    var_7ebb34cae2c736f2 = getclosest(enemy_veh.origin, available_pos);
  } else {
    var_7ebb34cae2c736f2 = self.var_4a35ce0251802293;
  }

  var_7ebb34cae2c736f2.claimed = enemy_veh;
  var_7ebb34cae2c736f2.claimrelease = gettime() + 1000;
  enemy_veh.claimed_pos = var_7ebb34cae2c736f2;
  return var_7ebb34cae2c736f2;
}

function function_26e9e22860c819ce(start_point, end_point, speed, var_91b19cfb0a78c588) {
  var_5b7feb61dd19201b = isnavmeshloaded("vehicle_med") ? "vehicle_med" : "tank_med";

  if(isDefined(var_91b19cfb0a78c588)) {
    newpath = findpathcustom(start_point, var_91b19cfb0a78c588, 1, 1, var_5b7feb61dd19201b);
    end_point = function_b3978eb0b7e5cd88(end_point, newpath);
  } else {
    newpath = findpathcustom(start_point, end_point, 1, 1, var_5b7feb61dd19201b);
  }

  if(getDvar(@ "hash_5932a654e8efe1fa") != "<dev string:x1c>") {
    foreach(index, node in newpath) {
      sphere(node, 16, (1, 1, 1), 0, 100);

      if(isDefined(newpath[index + 1])) {
        line(node, newpath[index + 1], (0, 1, 0), 1, 0, 2);
      }
    }
  }

  if(getDvar(@ "hash_ec592c9ed8224d75") != "<dev string:x1c>") {
    sphere(end_point, 16, (1, 1, 1), 0, 2);
  }

  if(newpath.size) {
    thread function_9804c82501de981b(newpath, speed);
    return;
  }

  if(distancesquared(self.origin, "goalPoint") > squared(512)) {
    self function_77320e794d35465a("p2p", "goalPoint", self.origin);
  }
}

function function_9804c82501de981b(newpath, speed) {
  self endon("death");
  self endon("driverdeath");
  self notify("path_updated");
  self endon("path_updated");
  self.var_b7d9b54851a59550 = 1;
  orig_speed = speed;

  foreach(index, point in newpath) {
    while(istrue(self.pausing)) {
      wait 0.05;
    }

    if(isstruct(point)) {
      point = point.origin;
    }

    self function_77320e794d35465a("p2p", "goalPoint", point);

    if(isDefined(speed)) {
      if(istrue(self.var_b7d9b54851a59550)) {
        speed = orig_speed;
        future_index = index + 2;
        cos_ang = cos(20);
        cur_node = point;
        ang = self.angles;
        var_d91c820e8d146557 = 0;

        if(isDefined(newpath[index + 1])) {
          next_node = newpath[index + 1];
          no_turn = within_fov(cur_node, ang, next_node, cos_ang);

          if(!no_turn) {
            speed *= 0.25;
            var_d91c820e8d146557 = 1;
          }

          ang = vectortoangles(next_node - cur_node);

          if(!var_d91c820e8d146557 && isDefined(newpath[index + 2])) {
            var_4f306fb3c32f2d49 = newpath[index + 2];
            no_turn = within_fov(next_node, ang, var_4f306fb3c32f2d49, cos_ang);

            if(!no_turn) {
              speed *= 0.5;
            }

            ang = vectortoangles(var_4f306fb3c32f2d49 - next_node);
          }
        }
      }

      dist = distancesquared(self.origin, point);
      time = undefined;

      if(dist > 0) {
        time = scripts\cp\vehicles::get_duration_between_points(self.origin, point, speed);
      }

      if(isDefined(time)) {
        self function_77320e794d35465a("p2p", "targetTime", time);
      } else {
        self function_77320e794d35465a("p2p", "targetTime", 0.2);
      }
    }

    goal_dist = 200;

    if(isDefined(self.goal_dist)) {
      goal_dist = self.goal_dist;
    }

    while(distancesquared(self.origin, point) > squared(goal_dist)) {
      waitframe();
    }
  }

  self notify("path_finished");
}

function function_f55c14f9168585a() {
  switch (self.model) {
    case #"hash_c8272f8e0a3654d2":
    case #"hash_c8472b8e0a4fe66c":
      ammo_box = spawnscriptable("cp_veh_cache", self.origin, self.angles);
      ammo_box utility::function_6e506f39f121ea8a(self, (-51, -5, 42), (0, 90, 0));
      rpg = spawnscriptable("cp_pickup_mike32", self.origin, self.angles);
      rpg utility::function_6e506f39f121ea8a(self, (-57, 23, 60), (-60, 0, 0));
      thread function_ed8121366a308031(ammo_box);
      thread function_ed8121366a308031(rpg);
      break;
    case #"hash_af14d55fb75a3928":
      ammo_box = spawnscriptable("cp_veh_cache", self.origin, self.angles);
      ammo_box utility::function_6e506f39f121ea8a(self, (-48, 0, 35), (0, 90, 0));
      rpg = spawnscriptable("cp_pickup_rpg", self.origin, self.angles);
      rpg utility::function_6e506f39f121ea8a(self, (-65, 23, 43), (0, 180, 0));
      thread function_ed8121366a308031(ammo_box);
      thread function_ed8121366a308031(rpg);
      break;
  }
}

function function_dc9b96be6aa3c3c0(idamage, smeansofdeath, sweapon, partname, damageloc) {
  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(self._blackboard.currentvehicle.healthbuffer)) {
      if(self._blackboard.currentvehicle.health - idamage < self._blackboard.currentvehicle.healthbuffer) {
        return true;
      }
    }
  }

  if(isexplosivedamagemod(smeansofdeath)) {
    return false;
  }

  return true;
}

function function_6a0b2a08499a9842() {
  if(isDefined(self.aidriver)) {
    self.aidriver.var_71c1911e983f326d = undefined;
  }
}

function vehicle_watchflipped(vehicle, var_7f2253bd1b8cfa5e, flippedendcallback, endnotify) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle endon("stop_chasing");

  if(isDefined(endnotify)) {
    vehicle endon(endnotify);
  }

  usedisabled = 0;
  starttime = undefined;
  endtime = undefined;
  var_4f951428959d4d04 = cos(91);

  while(true) {
    shouldeject = 0;
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

function function_58c9bbddc21b16ca() {
  self endon("death");
  self endon("stop_chasing");
  cos_25 = cos(25);

  while(true) {
    wait 0.05;
    var_1047a2d125e48b40 = 0;

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

      velocity = self vehicle_getvelocity();
      forward = anglesToForward(self.angles);

      if(distancesquared(self.origin, vehicle.origin) < squared(128)) {
        var_1047a2d125e48b40 = 1;
        continue;
      }

      if(distancesquared(self.origin, vehicle.origin) < squared(500)) {
        if(vectordot(velocity, forward) >= 0) {
          if(!within_fov(self.origin, self.angles, vehicle.origin, cos_25)) {
            continue;
          }
        } else if(!within_fov(self.origin, self.angles * -1, vehicle.origin, cos_25)) {
          continue;
        }

        var_1047a2d125e48b40 = 1;
      }
    }

    if(var_1047a2d125e48b40) {
      self.pausing = 1;
      self function_77320e794d35465a("p2p", "brake", 1);

      if(getDvar(@ "hash_ec592c9ed8224d75") != "<dev string:x1c>") {
        print3d(self.origin + (0, 0, 40), "<dev string:x1d>", (1, 1, 1), 1, 1, 20, 1);
      }

      wait 1;
      self.pausing = undefined;
      self function_77320e794d35465a("p2p", "brake", -1);
    }
  }
}

function function_6fbbb66caba5ce98(vehicle) {
  newpath = create_radius_around_point(vehicle.origin, 16, 1024);

  while(isDefined(vehicle) && vehicle vehicle_getspeed() < 2) {
    thread function_9804c82501de981b(newpath, 300);
    self waittill("path_finished");
  }

  self notify("path_updated");
}

function create_radius_around_point(point, num_positions, path_radius) {
  degs_per_pos = 360 / num_positions;
  positions = [];
  fwd = (1, 0, 0);
  var_5b7feb61dd19201b = isnavmeshloaded("vehicle_med") ? "vehicle_med" : "tank_med";
  i = 0;

  while(i < 360) {
    altforward = fwd * path_radius;
    rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);
    pos = point + rotated_forward;
    position = spawnStruct();
    position.origin = pos;
    position.origin = getgroundposition(position.origin, 128, 5000, 4000);
    position.origin = getclosestpointonnavmesh(position.origin, var_5b7feb61dd19201b);
    positions[positions.size] = position;
    i += degs_per_pos;
  }

  return positions;
}

function function_5a5eed0db2e9f17() {
  return istrue(self.var_f4e9a19962a09084);
}

function function_9c21fe56edb135f2() {
  self notify("path_updated");
  self notify("stop_chasing");
  self endon("death");
  level.var_6e5ff6cae14c4081 = array_remove(level.var_6e5ff6cae14c4081, self);
  var_5b7feb61dd19201b = isnavmeshloaded("vehicle_med") ? "vehicle_med" : "tank_med";
  endpoint = function_1bd9b45ead8295a0();
  startpoint = self.origin;
  newpath = findpathcustom(startpoint, getclosestpointonnavmesh(endpoint, var_5b7feb61dd19201b), 0, 1, var_5b7feb61dd19201b);
  thread function_9804c82501de981b(newpath, 3000);
  self waittill("path_finished");
  self.fn_death = undefined;
  self delete();
}

function function_1bd9b45ead8295a0() {
  return (-5439.94, 9003.53, 4657.86);
}

function flippedstart(vehicle) {
  foreach(rider in vehicle.riders) {
    if(!isalive(rider)) {
      continue;
    }

    rider.do_immediate_ragdoll = 1;
    rider dodamage(rider.health + 1000, rider.origin);
  }

  vehicle notify("stop_chasing");
  vehicle notify("path_updated");
  vehicle dodamage(vehicle.health + 1000, (0, 0, 0));
  wait 1;
  level notify("vehicle_flipped");
}

function function_f32c4025f3271080(vehicle) {
  var_e7f0e4260e1f48c6 = 0;

  foreach(player in level.players) {
    if(scripts\cp\laststand::player_in_laststand(player)) {
      continue;
    }

    if(!isDefined(player.vehicle) && !istrue(player istouching(vehicle))) {
      continue;
    }

    var_e7f0e4260e1f48c6 = 1;
  }

  return var_e7f0e4260e1f48c6;
}

function function_de56a2b6b7fa16b0(file_str) {
  wait 1;
  self function_e4fe23e19f4bf900(file_str);
}

function function_66b0113fe0bf4a88(vehicle) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  level.special_lockon_target_list[level.special_lockon_target_list.size] = vehicle;
}

function function_fb08b61559c93460() {
  self endon("death");

  if(isDefined(level.var_da571aa94ad22ce7)) {
    var_7408ed52662703d3 = 0;
    var_89bd9fe81e7a5877 = [];

    foreach(point in level.var_da571aa94ad22ce7) {
      active = 0;

      foreach(player in level.players) {
        if(distancesquared(player.origin, point.origin) <= squared(point.radius)) {
          var_7408ed52662703d3++;
          active = 1;
        }
      }

      if(active) {
        var_89bd9fe81e7a5877[var_89bd9fe81e7a5877.size] = point;
      }
    }

    if(var_7408ed52662703d3 == level.players.size) {
      if(!isDefined(self.var_a8d8ee0c52fb743f)) {
        self.var_a8d8ee0c52fb743f = gettime() + 5000;
      }

      if(gettime() < self.var_a8d8ee0c52fb743f) {
        return 0;
      }

      var_fb249e5742230f8 = getclosest(self.origin, var_89bd9fe81e7a5877);
      unloadpos = getclosest(self.origin, var_fb249e5742230f8.var_3d0eb27cde95d306);

      if(!isDefined(unloadpos.var_64e1820837556b52)) {
        unloadpos.var_64e1820837556b52 = 0;
      }

      unload_pos = getclosestpointonnavmesh(unloadpos.origin, 0);

      if(unloadpos.var_64e1820837556b52 > 0) {
        fwd = vectortoangles(unloadpos.origin - self.origin);
        unload_pos = getclosestpointonnavmesh(unloadpos.origin + anglesToForward(fwd) * 300 * unloadpos.var_64e1820837556b52, 0);
      }

      function_26e9e22860c819ce(self.origin, unload_pos, 4500);

      while(distance(self.origin, unload_pos) > 1500 && function_1b81d51d30e14e95()) {
        wait 1;
      }

      self notify("path_updated");
      var_7408ed52662703d3 = 0;
      var_89bd9fe81e7a5877 = [];

      foreach(point in level.var_da571aa94ad22ce7) {
        active = 0;

        foreach(player in level.players) {
          if(distancesquared(player.origin, point.origin) <= squared(point.radius)) {
            var_7408ed52662703d3++;
            active = 1;
          }
        }

        if(active) {
          var_89bd9fe81e7a5877[var_89bd9fe81e7a5877.size] = point;
        }
      }

      if(var_7408ed52662703d3 != level.players.size) {
        return 0;
      }

      unloadpos.var_64e1820837556b52++;
      thread namespace_cbe993018617a21d::unloadvehicle();
      self notify("stop_chasing");
      return 1;
    }
  }
}

function function_1b81d51d30e14e95() {
  var_7408ed52662703d3 = 0;

  foreach(point in level.var_da571aa94ad22ce7) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, point.origin) <= squared(point.radius)) {
        var_7408ed52662703d3++;
      }
    }
  }

  return var_7408ed52662703d3 == level.players.size;
}

function function_b3978eb0b7e5cd88(org, array) {
  closest = array[0];

  foreach(point in array) {
    if(distancesquared(point, org) > distancesquared(closest, org)) {
      continue;
    }

    closest = point;
  }

  return closest;
}