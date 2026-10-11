/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d05e472a90adb1d.gsc
*************************************************/

#using script_2d05e472a90adb1d;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace namespace_d595138a91ee4a1d;

function function_f1620ddb70094ea9(spawn_ref, is_landed, heli_ref, var_fa78bf82ddd9f37c, heli_team) {
  heli = undefined;
  is_landed = default_to(is_landed, 0);
  var_fa78bf82ddd9f37c = default_to(var_fa78bf82ddd9f37c, 1);
  spawndata = spawnStruct();
  spawndata.origin = spawn_ref.origin + (0, 0, 128);
  spawndata.angles = (0, 0, 0);

  if(isDefined(spawn_ref.angles)) {
    spawndata.angles = (0, spawn_ref.angles[1], 0);
  }

  spawndata.team = heli_team;
  heli = vehicle_spawn(heli_ref, spawndata);
  assertex(isDefined(heli), "<dev string:x1c>");

  if(isDefined(heli)) {
    heli.is_landed = is_landed;
    heli.vehiclename = heli_ref;
    heli function_1719f58673bf5508();
  }

  return heli;
}

function function_1719f58673bf5508() {
  self.speed = 100;

  if(iscp()) {
    self.speed = 50;
  }

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
  self setvehicleteam(self.team);
  self.ignorelist = [self];
  self.crashoffset = 1030;
  self.currenthealth = 2500;
  self.health = 2500;
  self.maxhealth = 2500;
  self.damagestate = 0;
  scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", self.team);
  self.attackers = [];
  thread function_214472d69776db78();

  if(!isDefined(level.averagealliesz)) {
    level.averagealliesz = 0;
  }
}

function function_19139560550e356e(target_location) {
  self notify("new_orders");
  self endon("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!isDefined(target_location)) {
    target_location = self.origin;
  }

  self sethoverparams(50, 5, 2.5);
  self vehicle_setspeed(40, 15);
  wait 2;
  function_3c2a39b0d7da4e01(target_location, 1);
  self.is_landed = 0;
  self vehicle_setspeed(self.originalspeed, self.accel);
}

function ai_spawn_director_heli_land(target_location) {
  self notify("new_orders");
  self endon("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(iscp()) {
    takeoff_pos = self.origin + (0, 0, 1000);
    self setvehgoalpos(takeoff_pos, 1);

    while(distance(self.origin, takeoff_pos) > 50) {
      waitframe();
    }
  }

  if(!isDefined(target_location)) {
    target_location = self.origin;
  }

  if(!isvector(target_location)) {
    target_location = target_location.origin;
  }

  force_height = 10000;

  if(iscp()) {
    force_height = 3000;
  }

  function_3c2a39b0d7da4e01(target_location, 1, force_height);

  while(distance2dsquared(self.origin, target_location) > 65536) {
    waitframe();
  }

  if(iscp()) {
    self notify("started_landing");
  }

  self vehicle_setspeed(40, 15);
  function_3c2a39b0d7da4e01(target_location, 1, 128);
  self.is_landed = 1;
  self notify("ai_spawn_director_heli_landed");
  self sethoverparams(0, 0, 0);
}

function function_ff4065536bad7017(start_node, activityinstance) {
  self notify("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("new_orders");
  self.next_target = start_node;
  path_end = 0;

  while(!path_end) {
    if(!isDefined(self.next_target.target)) {
      path_end = 1;
      self notify("ai_spawn_director_heli_reached_end_path");
    }

    function_3c2a39b0d7da4e01(self.next_target, path_end);

    if(!path_end) {
      var_6ba7370057392ca1 = self.next_target.target;
      self.next_target = getvehiclenode(var_6ba7370057392ca1, "targetname");

      if(!isDefined(self.next_target)) {
        assertmsg("<dev string:x3b>" + var_6ba7370057392ca1 + "<dev string:x90>");
        path_end = 1;
      }
    }

    waitframe();
  }
}

function function_3c2a39b0d7da4e01(target, forcestopatgoal, forceheight, ignoreblocks, goalyaw) {
  self notify("state_change");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("state_change");
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
      obstructiontrace = sphere_trace(currentpos, initialgoalpos, 256, self.ignorelist);

      if(isDefined(obstructiontrace)) {
        if(obstructiontrace["hittype"] != "hittype_none") {
          xpos = obstructiontrace["position"][0];
          ypos = obstructiontrace["position"][1];
          obstructed = 1;
        }
      }
    }

    if(isDefined(forceheight)) {
      newpos = (testtarget[0], testtarget[1], forceheight);
    } else if(iscp()) {
      newpos = (testtarget[0], testtarget[1], testtarget[2]);
    } else {
      properz = function_7c904b96baa6d5fb(xpos, ypos, 20);
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

    waittill_any_3("goal", "near_goal", "begin_evasive_maneuvers");

    if(iscp() && !isvector(target) && isDefined(target.script_delay)) {
      self sethoverparams(200, 5, 2.5);
      self vehicle_setspeed(2, 30, 30);
      self setyawspeed(0, 25, 25, 0.1);
      wait target.script_delay;
      self sethoverparams(0, 0, 0);
      self vehicle_setspeed(self.speed, self.accel);
      self setyawspeed(100, 25, 25, 0.1);
    }

    if(!istrue(obstructed)) {
      break;
    }
  }
}

function function_7c904b96baa6d5fb(x, y, rand) {
  offgroundheight = 1280;
  groundheight = function_aca7615e8bddce42(x, y);
  trueheight = groundheight + offgroundheight;
  trueheight += randomint(rand);
  return trueheight;
}

function function_aca7615e8bddce42(x, y) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  currz = self.origin[2] + 2000;
  minz = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates) {
      ignorelist[ignorelist.size] = crate;
    }
  }

  trc = sphere_trace((x, y, currz), (x, y, z), 800, ignorelist, undefined, 1);

  if(trc["position"][2] < minz) {
    hightrace = minz;
  } else {
    hightrace = trc["position"][2];
  }

  return hightrace;
}

function function_214472d69776db78() {
  level endon("game_ended");
  self endon("ai_spawn_director_heli_landed");

  while(isDefined(self) && !istrue(self.burningdown)) {
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.nocrash) && isDefined(self.var_eae10920b9197a32)) {
    self[[self.var_eae10920b9197a32]]();
    return;
  }

  function_841509516e1e0315(100);
  wait 0.35;

  if(isDefined(self)) {
    self dodamage(self.maxhealth + 100000, self.origin, undefined, undefined, "MOD_SUICIDE");
    self radiusdamage(self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  }
}

function function_841509516e1e0315(speed) {
  self endon("explode");
  self function_247ad6a91f6a4ffe(0);
  self vehphys_setdefaultmotion();
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("crashing");
  self.iscrashing = 1;
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);

  foreach(rider in self.riders) {
    rider scripts\cp_mp\agents\agent_utils::function_7056963336f2bbec();
  }

  var_6847739e80fb4e81 = function_1427dabcab7068cb(2000, 500, 1000);

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread function_acc5857fbb90a8be(speed);
  self vehicle_turnengineoff();
  self waittill("near_goal");
}

function function_1427dabcab7068cb(crashdist, var_6c56ff5ecc704c48, var_6c7af55ecc98b102) {
  crashstart = self.origin;
  crashoffset = self.crashoffset;
  crashpos = undefined;
  jetforward = anglesToForward(self.angles);
  jetright = anglestoright(self.angles);
  crashend = crashstart + jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward + jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetright - jetforward) - (0, 0, crashoffset);
  crashtrace = ray_trace(crashstart, crashend, self);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (-1 * jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  return crashpos;
}

function function_acc5857fbb90a8be(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.4);
    wait 0.5;
  }
}

function function_fe282a6dc1e0d0fa() {
  foreach(rider in self.riders) {
    rider scripts\cp_mp\agents\agent_utils::despawnagent();
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function function_1cbf90dc463c0d0b(data) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  self notify("death");
  return true;
}

function function_10ff61ea7267cf0b(droplocation) {
  endtrace = droplocation - (0, 0, 20000);
  starttrace = droplocation + (0, 0, 200);
  ignorelist = [self];
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignorelist);

  if(isDefined(trace) && trace["hittype"] != "hittype_none") {
    return trace["position"];
  }

  return droplocation;
}

function function_35c699c709e24b69(ai_group) {
  var_b5424ebe989b94b4 = 0;
  var_977851763cf38e9e = [];
  usedpositions = [];

  foreach(rider in ai_group) {
    if(isDefined(rider.var_af27b6a3d3a2f6af) && rider.var_af27b6a3d3a2f6af != -1) {
      if(!isDefined(usedpositions[rider.var_af27b6a3d3a2f6af])) {
        if(rider.var_af27b6a3d3a2f6af == 5) {
          var_b5424ebe989b94b4 = 1;
        }

        usedpositions[rider.var_af27b6a3d3a2f6af] = 1;
        rider.script_startingposition = rider.var_af27b6a3d3a2f6af;
        rider.vehicle_position = rider.script_startingposition;
        rider thread function_e7d3411db935e99b(int(rider.var_af27b6a3d3a2f6af));
      } else {
        assertmsg("<dev string:x95>" + rider.var_af27b6a3d3a2f6af);
      }

      continue;
    }

    var_977851763cf38e9e[var_977851763cf38e9e.size] = rider;
  }

  seatindex = 2;
  maxpos = 10;

  foreach(rider in var_977851763cf38e9e) {
    if(!var_b5424ebe989b94b4) {
      usedpositions[5] = 1;
      var_b5424ebe989b94b4 = 1;
      rider.script_startingposition = 5;
      rider.vehicle_position = rider.script_startingposition;
      rider thread function_e7d3411db935e99b(int(5));
      continue;
    }

    while(seatindex < maxpos) {
      if(!isDefined(usedpositions[seatindex])) {
        usedpositions[seatindex] = 1;
        rider.script_startingposition = seatindex;
        rider.vehicle_position = rider.script_startingposition;
        rider thread function_e7d3411db935e99b(int(seatindex));
        break;
      }

      seatindex++;
    }
  }

  function_f92faaaf5c5077c6(ai_group, 1, 1);
}

function function_9e55d8680a23ec64(unload_location) {
  var_ce9af1b7ad0dae24 = 650;

  if(iscp()) {
    var_d8fdb2b88f2194c8 = 150;
  }

  function_3c2a39b0d7da4e01(unload_location, 1, unload_location[2] + var_d8fdb2b88f2194c8);

  if(!iscp()) {
    thread function_2335f0235dab16e3(unload_location);
  }

  var_b3941e6a151cf4d2 = scripts\common\vehicle_code::_vehicle_unload();
  self waittill("unloaded");

  foreach(guy in var_b3941e6a151cf4d2) {
    guy.var_f327ed481efe4857 = undefined;
  }

  return var_b3941e6a151cf4d2;
}

function function_e7d3411db935e99b(pos) {
  self endon("death");
  wait 2;
  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

function function_2335f0235dab16e3(unloadnode) {
  self endon("death");
  unloadgroup = undefined;

  if(isDefined(unloadnode)) {
    if(!isvector(unloadnode)) {
      unloadorigin = unloadnode.origin;
      unloadgroup = unloadnode.script_unload;
    } else {
      unloadorigin = unloadnode;
    }
  }

  drop_height = 1000;
  start_height = 100;
  pos = getgroundposition(unloadorigin, 1, drop_height, start_height);
  pos += (0, 0, 50);

  if(getdvarint(@ "hash_f05c6973eb39f532", 0) == 1) {
    raystart = unloadorigin + (0, 0, start_height);
    rayend = unloadorigin + (0, 0, drop_height * -1);
    level thread debug_utility::drawline(raystart, rayend, 9999, game["<dev string:xe1>"]["<dev string:xeb>"]);
    level thread debug_utility::drawsphere(pos, 6, 9999, game["<dev string:xe1>"]["<dev string:xeb>"]);
    print3d(pos, "<dev string:xf4>", undefined, undefined, undefined, 9999);
  }

  dist = 500;
  dist_sq = dist * dist;

  while(distance2dsquared(unloadorigin, self.origin) > dist_sq) {
    wait 0.1;
  }

  if(istrue(self.animintro)) {
    wait 8;
  } else {
    wait 10;
  }

  if(scripts\common\vehicle_aianim::riders_unloadable(unloadgroup)) {
    magicgrenademanual("smoke_grenade_reinforcement_cover", pos, (0, 0, -10), 0.5);
    thread play_sound_in_space("smoke_grenade_expl_trans", self.origin);
  }
}

function function_9514a9690c80864a(start_node, var_2c2390497cfcfc4, unload_pos, var_b3a72f08adebdce1) {
  self notify("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("new_orders");
  self.animintro = 1;
  unloadnode = spawnStruct();
  unloadnode.origin = drop_to_ground(unload_pos, 100, -1000);
  unloadnode.angles = (0, 0, 0);
  var_19c5004cbb9d3a44 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()][0].vehicle_getoutanim;

  if(getdvarint(@ "hash_f05c6973eb39f532", 0) == 1) {
    level thread debug_utility::drawsphere(unloadnode.origin, 20, 9999, game["<dev string:xe1>"]["<dev string:x108>"]);
    print3d(unloadnode.origin, "<dev string:x111>", undefined, undefined, undefined, 9999);
    level thread debug_utility::drawsphere(start_node.origin, 20, 9999, game["<dev string:xe1>"]["<dev string:x108>"]);
    print3d(start_node.origin, "<dev string:x124>", undefined, undefined, undefined, 9999);
    debugnode = start_node;
    var_1beb7eb06a91cd4c = 0;

    while(isDefined(debugnode.target)) {
      var_89f47501ca05c6fb = getvehiclenode(debugnode.target, "<dev string:x132>");

      if(!isDefined(var_89f47501ca05c6fb)) {
        break;
      }

      var_1beb7eb06a91cd4c++;
      level thread debug_utility::drawline(debugnode.origin, var_89f47501ca05c6fb.origin, 9999, game["<dev string:xe1>"]["<dev string:x108>"]);
      level thread debug_utility::drawsphere(var_89f47501ca05c6fb.origin, 20, 9999, game["<dev string:xe1>"]["<dev string:x108>"]);
      print3d(var_89f47501ca05c6fb.origin, "<dev string:x140>" + var_1beb7eb06a91cd4c, undefined, undefined, undefined, 9999);
      debugnode = var_89f47501ca05c6fb;
    }
  }

  currentnode = start_node;

  while(isDefined(currentnode)) {
    var_456b498e5fffa4f = flatten_vector(unloadnode.origin - currentnode.origin);
    unloadnode.angles = vectortoangles(var_456b498e5fffa4f);
    animationstartposition = getstartorigin(unloadnode.origin, unloadnode.angles, var_19c5004cbb9d3a44);
    animationstartangles = getstartangles(unloadnode.origin, unloadnode.angles, var_19c5004cbb9d3a44);

    if(isDefined(currentnode.target)) {
      nextnode = getvehiclenode(currentnode.target, "targetname");

      if(isDefined(nextnode)) {
        var_87d5a37e0b7f419d = flatten_vector(animationstartposition - currentnode.origin);
        var_1952bd43437f827b = flatten_vector(animationstartposition - nextnode.origin);

        if(vectordot(var_87d5a37e0b7f419d, var_1952bd43437f827b) < 0) {
          nextnode = undefined;
        }
      }
    }

    if(isDefined(nextnode)) {
      var_fbbf0d4332cc598a = flatten_vector(nextnode.origin - currentnode.origin);
      currentnodeyaw = vectortoangles(var_fbbf0d4332cc598a)[1];
    } else {
      var_443055d80866aa72 = flatten_vector(animationstartposition - currentnode.origin);
      currentnodeyaw = vectortoangles(var_443055d80866aa72)[1];
    }

    if(getdvarint(@ "hash_f05c6973eb39f532", 0) == 1) {
      var_5e3ac85e5357dacf = default_to(var_5e3ac85e5357dacf, 0);
      debugposition = (currentnode.origin[0], currentnode.origin[1], animationstartposition[2]);
      level thread debug_utility::drawsphere(debugposition, 20, 9999, game["<dev string:xe1>"]["<dev string:x149>"]);
      print3d(debugposition, "<dev string:x140>" + var_5e3ac85e5357dacf, undefined, undefined, undefined, 9999);
      var_5e3ac85e5357dacf++;
    }

    height = animationstartposition[2];

    if(currentnode == start_node && currentnode.origin[2] > animationstartposition[2]) {
      height = currentnode.origin[2];
    }

    function_3c2a39b0d7da4e01(currentnode, currentnode == start_node, height, undefined, currentnodeyaw);
    currentnode = nextnode;
    nextnode = undefined;
  }

  self.scenenode = unloadnode;
  self.currentnode = unloadnode;

  if(getdvarint(@ "hash_f05c6973eb39f532", 0) == 1) {
    level thread debug_utility::drawsphere(animationstartposition, 20, 9999, game["<dev string:xe1>"]["<dev string:x149>"]);
    print3d(animationstartposition, "<dev string:x152>", undefined, undefined, undefined, 9999);
  }

  function_3c2a39b0d7da4e01(animationstartposition, 1, animationstartposition[2], undefined, animationstartangles[1]);
  var_80011eafbfff1c63 = 1.25;
  self function_6d14d24a1888c646(animationstartangles, 1, var_80011eafbfff1c63, 0.75, 0.25);
  self function_1c952754074bd3a1(animationstartposition, 1, var_80011eafbfff1c63, 0.9, 0.1, 1);
  wait var_80011eafbfff1c63;
  self vehicle_cleardrivingstate();
  self function_247ad6a91f6a4ffe(1);
  self vehphys_forcekeyframedmotion();
  thread function_2335f0235dab16e3(unloadnode);
  var_b3941e6a151cf4d2 = scripts\common\vehicle_paths::unload_node(unloadnode);

  if(!isDefined(var_b3941e6a151cf4d2)) {
    var_b3941e6a151cf4d2 = [];
  }

  if(isDefined(var_b3a72f08adebdce1)) {
    self thread[[var_b3a72f08adebdce1]](self, var_b3941e6a151cf4d2);
  }

  self function_247ad6a91f6a4ffe(0);
  self vehphys_setdefaultmotion();
  var_c29b34a84cd0839a = 1;
  self function_6d14d24a1888c646(self.angles, 1, var_c29b34a84cd0839a, 0.75, 0.25);
  self function_1c952754074bd3a1(self.origin, 1, var_c29b34a84cd0839a, 0.75, 0.25, 1);
  wait var_c29b34a84cd0839a;
  thread namespace_5d57e6b81b105f5d::function_3c2a39b0d7da4e01(start_node.origin, 0, 12000);
  waittill_any_timeout_3(45, "goal", "near_goal", "begin_evasive_maneuvers");
  var_95822e3d27d18fbc = 1;
  wait var_95822e3d27d18fbc;
  self cleargoalyaw();
}