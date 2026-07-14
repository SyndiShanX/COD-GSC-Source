/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_e9bca00ec07d3c6.gsc
****************************************************/

#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_5a0ff95f3569ef9c;

function function_2667f225f2e4c2bc() {
  level.var_76aeba28d6ac69be = &function_57d75440725e5920;
  level.var_92482472ee6a32cb = &function_2b6066bf692a1ca;
  level.var_4823431e4270285c = &function_76556f8f6fd0bc2e;
  level.var_9eb557a4e6789d68 = &function_4a0fd63dd56d5ff9;
  level.var_97faf134381093f0 = &function_2b81d0aff0c6118b;
  level.var_6a4270dc9dd1669c = &ai_spawn_director_heli_land;
  level.var_8fcb09c70b0d0f1 = &function_e70bd2fbceb5b67f;
}

function function_57d75440725e5920(spawnnode, is_landed, heli_ref, var_69680e216d706b4d, heli_team, model_name, skinoverride, requestid) {
  assert(isDefined(heli_ref));
  heli = undefined;

  if(!isDefined(is_landed)) {
    is_landed = 0;
  }

  if(!isDefined(var_69680e216d706b4d)) {
    var_69680e216d706b4d = 1;
  }

  spawndata = spawnStruct();
  spawndata.origin = spawnnode.origin + (0, 0, 128);
  spawndata.angles = (0, 0, 0);
  spawndata.initai = 1;

  if(isDefined(skinoverride)) {
    spawndata.var_d22ac03c16b6e075 = skinoverride;
  }

  if(isDefined(spawnnode.angles)) {
    spawndata.angles = (0, spawnnode.angles[1], 0);
  }

  spawndata.team = heli_team;

  if(isDefined(level.var_31ad6669d66173da)) {
    [[level.var_31ad6669d66173da]](requestid, heli_ref, spawndata);
  }

  heli = vehicle::spawn(heli_ref, spawndata);
  assert(isDefined(heli), "<dev string:x24>");

  if(isDefined(heli)) {
    heli.directorrequestid = requestid;
    heli.is_landed = is_landed;
    heli.vehiclename = heli_ref;
    function_cbdc7e7025cd7640(requestid, heli);
    level.var_f0477d10e8497c86 = gettime();
  }

  return heli;
}

function function_865b49129edc5789() {
  self.speed = 100;
  self.usedpositions = [];
  self.originalspeed = self.speed;
  self.accel = 50;
  self.heightoffset = (0, 0, 1280);
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(self.speed, self.accel);

  if(self.is_landed) {
    self sethoverparams(0, 0, 0);
  } else {
    self sethoverparams(50, 5, 2.5);
  }

  self setturningability(0.5);
  self setyawspeed(100, 25, 25, 0.1);
  self setCanDamage(1);
  self setneargoalnotifydist(512);

  if(isDefined(self.team)) {
    self setvehicleteam(self.team);
  }

  self.ignorelist = [self];
  self.crashoffset = 1030;
  self.currenthealth = 1250;
  self.health = 1250;
  self.maxhealth = 1250;
  self.damagestate = 0;
  self.attackers = [];
  thread function_2e10756963eae0d9();

  if(!isDefined(level.averagealliesz)) {
    level.averagealliesz = 0;
  }
}

function function_5797bdda25cdf5a3(target_location) {
  self notify("\x98I\x87\xbfU9T\\\xb6\xba");
  self endon("\x98I\x87\xbfU9T\\\xb6\xba");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93]y\xb7\xf2,I");
  self endon("\xcc\x15n\xfb\x98|?\xc5");

  if(!isDefined(target_location)) {
    target_location = self.origin;
  }

  self sethoverparams(50, 5, 2.5);
  self vehicle_setspeed(40, 15);
  wait 2;
  function_fa0dc037b2dba97c(target_location, 1);
  self.is_landed = 0;
  self vehicle_setspeed(self.originalspeed, self.accel);
}

function ai_spawn_director_heli_land(target_location) {
  self notify("\x98I\x87\xbfU9T\\\xb6\xba");
  self endon("\x98I\x87\xbfU9T\\\xb6\xba");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93]y\xb7\xf2,I");
  self endon("\xcc\x15n\xfb\x98|?\xc5");

  if(!isDefined(target_location)) {
    target_location = self.origin;
  }

  if(!isvector(target_location)) {
    target_location = target_location.origin;
  }

  function_fa0dc037b2dba97c(target_location, 1, 2000);

  while(distance2dsquared(self.origin, target_location) > 65536) {
    waitframe();
  }

  self vehicle_setspeed(40, 15);
  function_fa0dc037b2dba97c(target_location, 1, 128);
  self.is_landed = 1;
  self notify("\\e\x9c\xbb\xa1,\xf9\xec<\xa2>D\xdb\xf8\x9d\x80\xcd\x131\xa5\xd1\xb0~#\xfc\xec?F\xfa");
  self sethoverparams(0, 0, 0);
}

function function_2b6066bf692a1ca(start_node, activityinstance) {
  self notify("\x98I\x87\xbfU9T\\\xb6\xba");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93]y\xb7\xf2,I");
  self endon("\xcc\x15n\xfb\x98|?\xc5");
  self endon("\x98I\x87\xbfU9T\\\xb6\xba");
  self.next_target = start_node;
  path_end = 0;

  while(!path_end) {
    forcestopatgoal = 0;

    if(!isDefined(self.next_target.target)) {
      forcestopatgoal = 1;
      path_end = 1;
      self notify("1\xf3\xdf\x18\xcbT\x9d:w\r)\xde6\xc6\x98\xc36z\a\x90P\r\xef\xab\xc6\xb7\x19Y@\xf0C9x\xe7\x9e\xc4\xf12\xac");
    }

    function_fa0dc037b2dba97c(self.next_target, path_end, 2000);

    if(!path_end) {
      self.next_target = getvehiclenode(self.next_target.target, #targetname);
    }

    waitframe();
  }
}

function function_fa0dc037b2dba97c(target, forcestopatgoal, forceheight, ignoreblocks, goalyaw) {
  self notify("\xe4\xdcJq)\x99\xc9\x04\xa6\xd5\x1bi");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93]y\xb7\xf2,I");
  self endon("\xcc\x15n\xfb\x98|?\xc5");
  self endon("\xe4\xdcJq)\x99\xc9\x04\xa6\xd5\x1bi");
  newpos = undefined;
  testtarget = target;

  if(!isvector(target)) {
    testtarget = target.origin;
  }

  while(!isDefined(self.ignorelist)) {
    waitframe();
  }

  while(true) {
    currentpos = self.origin;
    initialgoalpos = testtarget * (1, 1, 0) + (0, 0, self.origin[2]);
    obstructed = 0;
    xpos = testtarget[0];
    ypos = testtarget[1];

    if(istrue(ignoreblocks)) {
      obstructiontrace = trace::sphere_trace(currentpos, initialgoalpos, 256, self.ignorelist);

      if(isDefined(obstructiontrace)) {
        if(obstructiontrace[")\x9a\x94]\xee}s"] != "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
          xpos = obstructiontrace["\xc1\xbd\xdci\xe8i{7"][0];
          ypos = obstructiontrace["\xc1\xbd\xdci\xe8i{7"][1];
          obstructed = 1;
        }
      }
    }

    if(isDefined(forceheight)) {
      newpos = testtarget + (0, 0, forceheight);
    } else {
      properz = function_44bdc6488e8f2072(xpos, ypos, 20);
      newpos = (xpos, ypos, properz);
    }

    stopatgoal = 0;

    if(istrue(forcestopatgoal) && !istrue(obstructed)) {
      stopatgoal = forcestopatgoal;
    }

    self setvehgoalpos(newpos, stopatgoal);

    if(isDefined(goalyaw)) {
      self setgoalyaw(goalyaw);
    }

    utility::waittill_any("\x83\xd6\xaf\x11", "*\x9f}\b\x94[?\x81\"", "\xc2\x1e\xab+\x9c\xa5-\xf6\xad\xa8\x96\x8d\x05\xfcZ\xab\xdb\xfd\xad\x92*\x97\xa2");

    if(!istrue(obstructed)) {
      break;
    }
  }
}

function function_44bdc6488e8f2072(x, y, rand) {
  offgroundheight = 1280;
  groundheight = function_547f3e5ad883e26b(x, y);
  trueheight = groundheight + offgroundheight;
  trueheight += randomint(rand);
  return trueheight;
}

function function_547f3e5ad883e26b(x, y) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x10\xd0\xbf\xd9\r\x14\x17\xe6\xf8*u\xc3\xc6\x8e\x0e");
  self endon("\x93]y\xb7\xf2,I");
  z = -99999;
  currz = self.origin[2] + 2000;
  minz = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates) {
      ignorelist[ignorelist.size] = crate;
    }
  }

  trc = trace::sphere_trace((x, y, currz), (x, y, z), 800, ignorelist, undefined, 1);

  if(trc["\xc1\xbd\xdci\xe8i{7"][2] < minz) {
    hightrace = minz;
  } else {
    hightrace = trc["\xc1\xbd\xdci\xe8i{7"][2];
  }

  return hightrace;
}

function function_2e10756963eae0d9() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\\e\x9c\xbb\xa1,\xf9\xec<\xa2>D\xdb\xf8\x9d\x80\xcd\x131\xa5\xd1\xb0~#\xfc\xec?F\xfa");

  while(isDefined(self) && self.health > 0) {
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  if(utility::issharedfuncdefined(#"killstreak", #"iskillstreakweapon")) {
    if(![[utility::getsharedfunc(#"killstreak", #"iskillstreakweapon")]](self.killedbyweapon)) {
      function_9dfc42fe93437c04(100);
    }
  }

  function_95dc0f60ff66fc2();
}

function function_95dc0f60ff66fc2() {
  self notify("*\x83\xc10XI\x1e");
  self notify("\xe4\xdcJq)\x99\xc9\x04\xa6\xd5\x1bi");
  self radiusdamage(self.origin, 1000, 200, 200, undefined, "\xa2rl\xdaDn\x17b\xd9I\xc9=N", "\x95x\xfc}:wh\xccxa\xa3\x8a\xb1E$%\x89\xe4u\xf4\x8f\xe1_\x80h");
  self setscriptablepartstate("*\x83\xc10XI\x1e", "\xb8\"", 0);
  wait 0.35;

  if(isDefined(self)) {
    self dodamage(self.maxhealth + 100000, self.origin, undefined, undefined, "2a\\\xe1g5\xbf\xbf\xe0\xc6\x8c");
    self radiusdamage(self.origin, 1000, 200, 200, undefined, "\xa2rl\xdaDn\x17b\xd9I\xc9=N", "\x95x\xfc}:wh\xccxa\xa3\x8a\xb1E$%\x89\xe4u\xf4\x8f\xe1_\x80h");
  }
}

function function_9dfc42fe93437c04(speed) {
  self endon("*\x83\xc10XI\x1e");
  self setscriptablepartstate("\xc3\x869D\xfb", "\xb8\"", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("\xcc\x15n\xfb\x98|?\xc5");
  self.iscrashing = 1;
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);

  foreach(rider in self.riders) {
    rider ai::function_e26920a56f242d7a();
  }

  var_4c8dad3cd9f402c = function_fd1b089f1dee5dee(2000, 500, 1000);

  if(!isDefined(var_4c8dad3cd9f402c)) {
    return;
  }

  self setvehgoalpos(var_4c8dad3cd9f402c, 0);
  thread function_9303c3422e4b779f(speed);
  self vehicle_turnengineoff();
  self waittill("*\x9f}\b\x94[?\x81\"");
}

function function_fd1b089f1dee5dee(crashdist, var_bb664a0478fb1e21, var_d5c6e7f5697bf993) {
  crashstart = self.origin;
  crashoffset = self.crashoffset;
  crashpos = undefined;
  jetforward = anglesToForward(self.angles);
  jetright = anglestoright(self.angles);
  crashend = crashstart + jetforward * crashdist - (0, 0, crashoffset);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetforward * crashdist - (0, 0, crashoffset);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + jetright * crashdist - (0, 0, crashoffset);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetright * crashdist - (0, 0, crashoffset);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward + jetright) - (0, 0, crashoffset);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward - jetright) - (0, 0, crashoffset);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetright - jetforward) - (0, 0, crashoffset);
  crashtrace = trace::ray_trace(crashstart, crashend, self);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (-1 * jetforward - jetright) - (0, 0, crashoffset);

  if(trace::ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  return crashpos;
}

function function_9303c3422e4b779f(speed) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.4);
    wait 0.5;
  }
}

function function_e70bd2fbceb5b67f() {
  foreach(rider in self.riders) {
    if(!utility::issp()) {
      rider[[level.var_291ff58abadc3b95]](0);
      continue;
    }

    rider delete();
  }

  if(isDefined(level.vehicles)) {
    vehicle_tracking::deregister_instance(self);
  }

  vehicle_tracking::delete_vehicle(self);
}

function function_76556f8f6fd0bc2e(droplocation) {
  endtrace = droplocation - (0, 0, 20000);
  starttrace = droplocation + (0, 0, 200);
  ignorelist = [self];
  trace = trace::ray_trace(starttrace, endtrace, ignorelist);

  if(isDefined(trace) && trace[")\x9a\x94]\xee}s"] != "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
    return trace["\xc1\xbd\xdci\xe8i{7"];
  }

  return droplocation;
}

function function_dbe837aa6a73f9e4(ai_group) {
  var_2ce0876be25e28e5 = 0;
  var_22dd114a78c39187 = [];
  usedpositions = [];

  foreach(rider in ai_group) {
    if(isDefined(rider.var_ba2cbe72aa748ebe) && rider.var_ba2cbe72aa748ebe != -1) {
      if(!isDefined(usedpositions[rider.var_ba2cbe72aa748ebe])) {
        if(rider.var_ba2cbe72aa748ebe == 5) {
          var_2ce0876be25e28e5 = 1;
        }

        usedpositions[rider.var_ba2cbe72aa748ebe] = 1;
        rider.script_startingposition = rider.var_ba2cbe72aa748ebe;
        rider.vehicle_position = rider.script_startingposition;
        rider thread function_348e6d482d47b622(int(rider.var_ba2cbe72aa748ebe));
      } else {
        assertmsg("<dev string:x43>" + rider.var_ba2cbe72aa748ebe);
      }

      continue;
    }

    var_22dd114a78c39187[var_22dd114a78c39187.size] = rider;
  }

  seatindex = 2;
  maxpos = 10;

  foreach(rider in var_22dd114a78c39187) {
    if(!var_2ce0876be25e28e5) {
      usedpositions[5] = 1;
      var_2ce0876be25e28e5 = 1;
      rider.script_startingposition = 5;
      rider.vehicle_position = rider.script_startingposition;
      rider thread function_348e6d482d47b622(int(5));
      continue;
    }

    while(seatindex < maxpos) {
      if(!isDefined(usedpositions[seatindex])) {
        usedpositions[seatindex] = 1;
        rider.script_startingposition = seatindex;
        rider.vehicle_position = rider.script_startingposition;
        rider thread function_348e6d482d47b622(int(seatindex));
        break;
      }

      seatindex++;
    }
  }

  vehicle_ai::load(ai_group, 1, 1);
}

function function_4a0fd63dd56d5ff9(unload_location) {
  function_fa0dc037b2dba97c(unload_location, 1, 650);
  thread function_9be99bcec545c8aa(unload_location, self.directorrequestid);
  var_49768539feee6dc3 = vehicle_code::_vehicle_unload();
  self waittill("\x9er\x94D?\xa3\x0f\xe2");

  foreach(guy in var_49768539feee6dc3) {
    guy.var_5bc580d92d8e427a = undefined;
  }

  return var_49768539feee6dc3;
}

function function_348e6d482d47b622(pos) {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 2;
  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

function function_9be99bcec545c8aa(var_36626eba7a8d8890, requestid) {
  self endon("\x1e\xfd\xd1\xa2\a");
  unloadgroup = undefined;

  if(isDefined(var_36626eba7a8d8890)) {
    if(!isvector(var_36626eba7a8d8890)) {
      unloadorigin = var_36626eba7a8d8890.origin;
      unloadgroup = var_36626eba7a8d8890.script_unload;
    } else {
      unloadorigin = var_36626eba7a8d8890;
    }
  }

  if(istrue(level.var_2f28937c2dd690ac)) {
    return;
  }

  drop_height = 1000;
  start_height = 100;
  dist = 500;
  dist_sq = dist * dist;
  pos = getgroundposition(unloadorigin, 1, 1000, 0);

  while(distance2dsquared(unloadorigin, self.origin) > dist_sq) {
    wait 0.1;
  }

  if(istrue(vehicle_ai::function_e2de1fb05a7134c9())) {
    wait 2;
  } else {
    wait 10;
  }

  [[level.var_b77efaa6ba00d0e5]](pos, requestid);
}

function function_2b81d0aff0c6118b(start_node, var_a4534e940a22022d) {
  self notify("\x98I\x87\xbfU9T\\\xb6\xba");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93]y\xb7\xf2,I");
  self endon("\xcc\x15n\xfb\x98|?\xc5");
  self endon("\x98I\x87\xbfU9T\\\xb6\xba");

  for(unloadnode = start_node; isDefined(unloadnode.target); unloadnode = getvehiclenode(unloadnode.target, #targetname)) {}

  self.currentnode = unloadnode;
  ground_pos = utility::drop_to_ground(unloadnode.origin, 100, -1000);
  scenenode = spawnStruct();
  scenenode.origin = ground_pos;
  scenenode.angles = unloadnode.angles;
  self.scenenode = scenenode;
  animation = level.vehicle.templates.aianims[vehicle_code::get_vehicle_classname()][0].vehicle_getoutanim;
  neworg = getstartorigin(scenenode.origin, scenenode.angles, animation);
  newangles = getstartangles(scenenode.origin, scenenode.angles, animation);

  for(currentnode = start_node; isDefined(currentnode.target); currentnode = nextnode) {
    nextnode = getvehiclenode(currentnode.target, #targetname);

    if(!isDefined(nextnode)) {
      break;
    }

    unloadorg = (neworg[0], neworg[1], 0);
    currentnodeorg = (currentnode.origin[0], currentnode.origin[1], 0);
    nextnodeorg = (nextnode.origin[0], nextnode.origin[1], 0);
    var_e951bfc5d1b0a619 = unloadorg - currentnodeorg;
    var_8e241527f849bf8f = unloadorg - nextnodeorg;

    if(vectordot(var_e951bfc5d1b0a619, var_8e241527f849bf8f) < 0) {
      break;
    }

    function_fa0dc037b2dba97c(nextnode, 0);
  }

  function_fa0dc037b2dba97c(neworg, 1, 0, undefined, newangles[1]);
  wait randomfloatrange(3, 5);
  self vehicle_cleardrivingstate();
  self function_6c48315e9dbd2bc7(1);
  self vehphys_forcekeyframedmotion();
  thread function_9be99bcec545c8aa(unloadnode, self.directorrequestid);
  var_49768539feee6dc3 = vehicle_paths::unload_node(unloadnode);

  if(!isDefined(var_49768539feee6dc3)) {
    var_49768539feee6dc3 = [];
  }

  self function_6c48315e9dbd2bc7(0);
  self vehphys_setdefaultmotion();
  self cleargoalyaw();
  return var_49768539feee6dc3;
}

function function_2dbb189c949708c0(requestid) {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(isDefined(self.riders) && self.riders.size > 0) {
    wait 1;
  }

  function_60fd7d4376c1cfe6(requestid);
  self function_6c48315e9dbd2bc7(0);
  self.var_7efd034eb6be1585 = 1;
}

function function_3cd93ee4e1a391c6(start) {
  node = start;
  node.timeused = gettime();

  while(isDefined(node) && !isDefined(node.script_unload)) {
    node = vehicle_paths::function_adf744531a6883dc(node);
    node.timeused = gettime();
  }
}

function function_bdb39e70e21c409f() {
  node = self;

  for(mostrecent = node.timeused ?? -600; isDefined(node) && !isDefined(node.script_unload); mostrecent = min(mostrecent, node.timeused)) {
    node = vehicle_paths::function_adf744531a6883dc(node);

    if(isDefined(node.timeused)) {
      if(!isDefined(mostrecent)) {
        mostrecent = node.timeused;
        continue;
      }
    }
  }

  return mostrecent;
}

function function_25f0be0f74144dda() {
  if(!isDefined(self.rootnodes)) {
    if(!vehicle_paths::function_b48377e5924e8d73()) {
      return undefined;
    }
  }

  if(self.rootnodes.size == 1) {
    start = self.rootnodes[0];
  } else {
    start = undefined;
    starttime = undefined;

    foreach(potentialstart in self.rootnodes) {
      potentialstarttime = potentialstart function_bdb39e70e21c409f();

      if(!isDefined(start) || potentialstarttime < starttime) {
        start = potentialstart;
        starttime = potentialstarttime;
      }
    }
  }

  return start;
}