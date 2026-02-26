/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\airsupport.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\weapons;
#namespace airsupport;

function init_shared() {
  if(!isDefined(level.var_f81eb032)) {
    level.var_f81eb032 = {};
    level.var_f81eb032.var_176dc082 = &monitorspeed;
    level.noflyzones = [];
    level.noflyzones = getEntArray("no_fly_zone", "targetname");
    airsupport_heights = struct::get_array("air_support_height", "targetname");

    if(airsupport_heights.size > 1) {
      util::error("<dev string:x38>");
    }

    airsupport_heights = getEntArray("air_support_height", "targetname");

    if(airsupport_heights.size > 0) {
      util::error("<dev string:x77>");
    }

    heli_height_meshes = getEntArray("heli_height_lock", "classname");

    if(heli_height_meshes.size > 1) {
      util::error("<dev string:xdd>");
    }

    callback::on_spawned(&clearmonitoredspeed);
  }
}

function function_83904681(location, usedcallback, killstreakname) {
  self notify(#"used");
  waitframe(1);

  if(isDefined(usedcallback)) {
    killstreak_id = -1;

    if(isDefined(killstreakname)) {
      params = killstreaks::get_script_bundle(killstreakname);
      team = self.team;
      killstreak_id = self killstreakrules::killstreakstart(killstreakname, team, 0, 1);

      if(killstreak_id == -1) {
        return 0;
      }

      if(isDefined(level.var_1492d026)) {
        self[[level.var_1492d026]](killstreakname, team, killstreak_id);
      }

      self stats::function_e24eec31(params.ksweapon, #"used", 1);
    }

    return self[[usedcallback]](location, killstreak_id, killstreakname);
  }

  return 1;
}

function endselectionongameend() {
  self endon(#"death", #"disconnect", #"cancel_location", #"used", #"host_migration_begin");
  level waittill(#"game_ended");
  self notify(#"game_ended");
}

function endselectiononhostmigration() {
  self endon(#"death", #"disconnect", #"cancel_location", #"used", #"game_ended");
  level waittill(#"host_migration_begin");
  self notify(#"cancel_location");
}

function endselectionthink() {
  assert(isPlayer(self));
  assert(isalive(self));
  assert(isDefined(self.selectinglocation));
  assert(self.selectinglocation == 1);
  self thread endselectionongameend();
  self thread endselectiononhostmigration();
  event = self waittill(#"delete", #"death", #"disconnect", #"cancel_location", #"game_ended", #"used", #"weapon_change", #"emp_jammed");

  if(event._notify != "disconnect") {
    self.selectinglocation = undefined;

    if(event._notify === "weapon_change") {
      self endlocationselection();
    } else {
      self thread clearuplocationselection();
    }
  }

  if(event._notify != "used") {
    self notify(#"confirm_location");
  }
}

function clearuplocationselection() {
  event = self waittill(#"delete", #"death", #"disconnect", #"game_ended", #"used", #"weapon_change", #"emp_jammed", #"weapon_change_complete");

  if(event._notify != "disconnect" && isDefined(self)) {
    self endlocationselection();
  }
}

function stoploopsoundaftertime(time) {
  self endon(#"death");
  wait time;
  self stoploopsound(2);
}

function calculatefalltime(flyheight) {
  gravity = getdvarint(#"bg_gravity", 0);
  time = sqrt(2 * flyheight / gravity);
  return time;
}

function calculatereleasetime(flytime, flyheight, flyspeed, bombspeedscale, var_60b3d9e1 = 0.5) {
  falltime = calculatefalltime(flyheight);
  bomb_x = flyspeed * bombspeedscale * falltime;
  release_time = bomb_x / flyspeed;
  assert(var_60b3d9e1 >= 0 && var_60b3d9e1 <= 1, "<dev string:x11c>");
  return flytime * var_60b3d9e1 - release_time;
}

function callstrike(flightplan) {
  level.bomberdamagedents = [];
  level.bomberdamagedentscount = 0;
  level.bomberdamagedentsindex = 0;
  assert(flightplan.distance != 0, "<dev string:x155>");
  planehalfdistance = flightplan.distance / 2;
  path = getstrikepath(flightplan.target, flightplan.height, planehalfdistance);
  startpoint = path[#"start"];
  endpoint = path[#"end"];
  flightplan.height = path[#"height"];
  direction = path[#"direction"];
  d = length(startpoint - endpoint);
  flytime = d / flightplan.speed;
  bombtime = calculatereleasetime(flytime, flightplan.height, flightplan.speed, flightplan.bombspeedscale);

  if(bombtime < 0) {
    bombtime = 0;
  }

  assert(flytime > bombtime);
  flightplan.owner endon(#"disconnect");
  requireddeathcount = flightplan.owner.deathcount;
  side = vectorcross(anglesToForward(direction), (0, 0, 1));
  plane_seperation = 25;
  side_offset = vectorscale(side, plane_seperation);
  level thread planestrike(flightplan.owner, requireddeathcount, startpoint, endpoint, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
  wait flightplan.planespacing;
  level thread planestrike(flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
  wait flightplan.planespacing;
  side_offset = vectorscale(side, -1 * plane_seperation);
  level thread planestrike(flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
}

function planestrike(owner, requireddeathcount, pathstart, pathend, bombtime, flytime, flyspeed, bombspeedscale, direction, planespawnedfunction) {
  if(!isDefined(owner)) {
    return;
  }

  plane = spawn("script_model", pathstart);
  plane.angles = direction;
  plane.team = owner.team;
  plane setowner(owner);
  plane moveto(pathend, flytime, 0, 0);

  thread debug_plane_line(flytime, flyspeed, pathstart, pathend);

  if(isDefined(planespawnedfunction)) {
    plane[[planespawnedfunction]](owner, requireddeathcount, pathstart, pathend, bombtime, bombspeedscale, flytime, flyspeed);
  }

  wait flytime;
  plane notify(#"delete");
  plane delete();
}

function determinegroundpoint(player, position) {
  ground = (position[0], position[1], player.origin[2]);
  trace = bulletTrace(ground + (0, 0, 10000), ground, 0, undefined);
  return trace[#"position"];
}

function determinetargetpoint(player, position) {
  point = determinegroundpoint(player, position);
  return clamptarget(point);
}

function getmintargetheight() {
  return level.spawnmins[2] - 500;
}

function getmaxtargetheight() {
  return level.spawnmaxs[2] + 500;
}

function clamptarget(target) {
  min = getmintargetheight();
  max = getmaxtargetheight();

  if(target[2] < min) {
    target[2] = min;
  }

  if(target[2] > max) {
    target[2] = max;
  }

  return target;
}

function _insidecylinder(point, base, radius, height) {
  if(isDefined(height)) {
    if(point[2] > base[2] + height) {
      return false;
    }
  }

  dist = distance2d(point, base);

  if(dist < radius) {
    return true;
  }

  return false;
}

function _insidenoflyzonebyindex(point, index, disregardheight) {
  height = level.noflyzones[index].height;

  if(isDefined(disregardheight)) {
    height = undefined;
  }

  return _insidecylinder(point, level.noflyzones[index].origin, level.noflyzones[index].radius, height);
}

function getnoflyzoneheight(point) {
  height = point[2];
  origin = undefined;

  for(i = 0; i < level.noflyzones.size; i++) {
    if(_insidenoflyzonebyindex(point, i)) {
      if(height < level.noflyzones[i].height) {
        height = level.noflyzones[i].height;
        origin = level.noflyzones[i].origin;
      }
    }
  }

  if(!isDefined(origin)) {
    return point[2];
  }

  return origin[2] + height;
}

function insidenoflyzones(point, disregardheight) {
  noflyzones = [];

  for(i = 0; i < level.noflyzones.size; i++) {
    if(_insidenoflyzonebyindex(point, i, disregardheight)) {
      noflyzones[noflyzones.size] = i;
    }
  }

  return noflyzones;
}

function crossesnoflyzone(start, end) {
  for(i = 0; i < level.noflyzones.size; i++) {
    point = math::closest_point_on_line(level.noflyzones[i].origin + (0, 0, 0.5 * level.noflyzones[i].height), start, end);
    dist = distance2d(point, level.noflyzones[i].origin);

    if(point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height) {
      continue;
    }

    if(dist < level.noflyzones[i].radius) {
      return i;
    }
  }

  return undefined;
}

function crossesnoflyzones(start, end) {
  zones = [];

  for(i = 0; i < level.noflyzones.size; i++) {
    point = math::closest_point_on_line(level.noflyzones[i].origin, start, end);
    dist = distance2d(point, level.noflyzones[i].origin);

    if(point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height) {
      continue;
    }

    if(dist < level.noflyzones[i].radius) {
      zones[zones.size] = i;
    }
  }

  return zones;
}

function getnoflyzoneheightcrossed(start, end, minheight) {
  height = minheight;

  for(i = 0; i < level.noflyzones.size; i++) {
    point = math::closest_point_on_line(level.noflyzones[i].origin, start, end);
    dist = distance2d(point, level.noflyzones[i].origin);

    if(dist < level.noflyzones[i].radius) {
      if(height < level.noflyzones[i].height) {
        height = level.noflyzones[i].height;
      }
    }
  }

  return height;
}

function _shouldignorenoflyzone(noflyzone, noflyzones) {
  if(!isDefined(noflyzone)) {
    return true;
  }

  for(i = 0; i < noflyzones.size; i++) {
    if(isDefined(noflyzones[i]) && noflyzones[i] == noflyzone) {
      return true;
    }
  }

  return false;
}

function _shouldignorestartgoalnoflyzone(noflyzone, startnoflyzones, goalnoflyzones) {
  if(!isDefined(noflyzone)) {
    return true;
  }

  if(_shouldignorenoflyzone(noflyzone, startnoflyzones)) {
    return true;
  }

  if(_shouldignorenoflyzone(noflyzone, goalnoflyzones)) {
    return true;
  }

  return false;
}

function gethelipath(start, goal) {
  startnoflyzones = insidenoflyzones(start, 1);

  thread debug_line(start, goal, (1, 1, 1));

  goalnoflyzones = insidenoflyzones(goal);

  if(goalnoflyzones.size) {
    goal = (goal[0], goal[1], getnoflyzoneheight(goal));
  }

  goal_points = calculatepath(start, goal, startnoflyzones, goalnoflyzones);

  if(!isDefined(goal_points)) {
    return undefined;
  }

  assert(goal_points.size >= 1);
  return goal_points;
}

function function_a43d04ef(goalorigin) {
  self endon(#"death", #"hash_41aaa8d75d168e0a");
  distthresholdsq = 40000;
  wait 20;

  while(true) {
    distsq = distancesquared(self.origin, goalorigin);

    if(distsq <= distthresholdsq) {
      self notify(#"fallback_goal");
      break;
    }

    waitframe(1);
  }
}

function function_fabf8bc5(goalorigin) {
  self endon(#"death", #"hash_41aaa8d75d168e0a");
  distthresholdsq = 10000;

  if(isDefined(self.var_f766e12d)) {
    distthresholdsq = sqr(self.var_f766e12d);
  }

  while(true) {
    distsq = distancesquared(self.origin, goalorigin);

    if(distsq <= distthresholdsq) {
      self notify(#"fallback_goal");
      break;
    }

    waitframe(1);
  }
}

function function_e0e908c3(var_dbd23dc, path, stopatgoal) {
  self endon(#"death", #"hash_78e76e8d9370e349");

  if(var_dbd23dc) {
    while(true) {
      var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");

      if(var_baa92af9) {
        self util::make_sentient();
        break;
      }

      waitframe(1);
    }

    self setgoal(path[0], 1, stopatgoal);
    self function_a57c34b7(path[0], stopatgoal, 1);
    return;
  }

  if(issentient(self)) {
    while(true) {
      var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");

      if(!var_baa92af9) {
        if(issentient(self)) {
          self function_60d50ea4();
        }

        break;
      }

      waitframe(1);
    }

    self function_a57c34b7(path[0], stopatgoal, 0);
  }
}

function function_f1b7b432(path, donenotify, stopatgoal, var_135dc5d1, var_96e5d7f = 0) {
  self endon(#"death");
  var_dbd23dc = 0;

  if(!ispointinnavvolume(path[0], "navvolume_big")) {
    if(issentient(self)) {
      self function_60d50ea4();
    }

    self function_a57c34b7(path[0], stopatgoal, 0);
  } else if(!ispointinnavvolume(self.origin, "navvolume_big")) {
    if(issentient(self)) {
      self function_60d50ea4();
    }

    self function_a57c34b7(path[0], stopatgoal, 0);
    var_dbd23dc = 1;
  } else {
    self setgoal(path[0], 1, stopatgoal);
    self function_a57c34b7(path[0], stopatgoal, 1);
  }

  if(is_true(var_135dc5d1)) {
    self thread function_fabf8bc5(path[0]);
  }

  if(is_true(var_96e5d7f)) {
    self thread function_a43d04ef(path[0]);
  }

  self thread function_e0e908c3(var_dbd23dc, path, stopatgoal);

  thread debug_line(self.origin, path[0], (1, 1, 0));

  if(stopatgoal) {
    self waittill(#"goal", #"fallback_goal");
  } else {
    self waittill(#"near_goal", #"fallback_goal");
  }

  if(isDefined(donenotify)) {
    self notify(donenotify);
  }

  self notify(#"hash_41aaa8d75d168e0a");
  self notify(#"hash_78e76e8d9370e349");
}

function followpath(path, donenotify, stopatgoal) {
  self endon(#"death");

  for(i = 0; i < path.size - 1; i++) {
    self setgoal(path[i], 0);

    thread debug_line(self.origin, path[i], (1, 1, 0));

    self waittill(#"near_goal");
  }

  self setgoal(path[path.size - 1], stopatgoal);

  thread debug_line(self.origin, path[i], (1, 1, 0));

  if(stopatgoal) {
    self waittill(#"goal");
  } else {
    self waittill(#"near_goal");
  }

  if(isDefined(donenotify)) {
    self notify(donenotify);
  }
}

function setgoalposition(goal, donenotify, stopatgoal = 1) {
  start = self.origin;
  goal_points = gethelipath(start, goal);

  if(!isDefined(goal_points)) {
    goal_points = [];
    goal_points[0] = goal;
  }

  followpath(goal_points, donenotify, stopatgoal);
}

function clearpath(start, end, startnoflyzone, goalnoflyzone) {
  noflyzones = crossesnoflyzones(start, end);

  for(i = 0; i < noflyzones.size; i++) {
    if(!_shouldignorestartgoalnoflyzone(noflyzones[i], startnoflyzone, goalnoflyzone)) {
      return false;
    }
  }

  return true;
}

function append_array(dst, src) {
  for(i = 0; i < src.size; i++) {
    dst[dst.size] = src[i];
  }
}

function calculatepath_r(start, end, points, startnoflyzones, goalnoflyzones, depth) {
  depth--;

  if(depth <= 0) {
    points[points.size] = end;
    return points;
  }

  noflyzones = crossesnoflyzones(start, end);

  for(i = 0; i < noflyzones.size; i++) {
    noflyzone = noflyzones[i];

    if(!_shouldignorestartgoalnoflyzone(noflyzone, startnoflyzones, goalnoflyzones)) {
      return undefined;
    }
  }

  points[points.size] = end;
  return points;
}

function calculatepath(start, end, startnoflyzones, goalnoflyzones) {
  points = [];
  points = calculatepath_r(start, end, points, startnoflyzones, goalnoflyzones, 3);

  if(!isDefined(points)) {
    return undefined;
  }

  assert(points.size >= 1);

  debug_sphere(points[points.size - 1], 10, (1, 0, 0), 1, 1000);

  point = start;

  for(i = 0; i < points.size; i++) {
    thread debug_line(point, points[i], (0, 1, 0));
    debug_sphere(points[i], 10, (0, 0, 1), 1, 1000);

    point = points[i];
  }

  return points;
}

function _getstrikepathstartandend(goal, yaw, halfdistance) {
  direction = (0, yaw, 0);
  startpoint = goal + vectorscale(anglesToForward(direction), -1 * halfdistance);
  endpoint = goal + vectorscale(anglesToForward(direction), halfdistance);
  noflyzone = crossesnoflyzone(startpoint, endpoint);
  path = [];

  if(isDefined(noflyzone)) {
    path[#"noflyzone"] = noflyzone;
    startpoint = (startpoint[0], startpoint[1], level.noflyzones[noflyzone].origin[2] + level.noflyzones[noflyzone].height);
    endpoint = (endpoint[0], endpoint[1], startpoint[2]);
  } else {
    path[#"noflyzone"] = undefined;
  }

  path[#"start"] = startpoint;
  path[#"end"] = endpoint;
  path[#"direction"] = direction;
  return path;
}

function getstrikepath(target, height, halfdistance, yaw) {
  noflyzoneheight = getnoflyzoneheight(target);
  worldheight = target[2] + height;

  if(noflyzoneheight > worldheight) {
    worldheight = noflyzoneheight;
  }

  goal = (target[0], target[1], worldheight);
  path = [];

  if(!isDefined(yaw) || yaw != "random") {
    for(i = 0; i < 3; i++) {
      path = _getstrikepathstartandend(goal, randomint(360), halfdistance);

      if(!isDefined(path[#"noflyzone"])) {
        break;
      }
    }
  } else {
    path = _getstrikepathstartandend(goal, yaw, halfdistance);
  }

  path[#"height"] = worldheight - target[2];
  return path;
}

function doglassdamage(pos, radius, max, min, mod) {
  wait randomfloatrange(0.05, 0.15);
  glassradiusdamage(pos, radius, max, min, mod);
}

function entlosradiusdamage(ent, pos, radius, max, min, owner, einflictor) {
  dist = distance(pos, ent.damagecenter);

  if(ent.isplayer || ent.isactor) {
    assumed_ceiling_height = 800;
    eye_position = ent.entity getEye();
    head_height = eye_position[2];
    debug_display_time = 4000;
    trace = weapons::damage_trace(ent.entity.origin, ent.entity.origin + (0, 0, assumed_ceiling_height), 0, undefined);
    indoors = trace[#"fraction"] != 1;

    if(indoors) {
      test_point = trace[#"position"];

      debug_star(test_point, (0, 1, 0), debug_display_time);

      trace = weapons::damage_trace((test_point[0], test_point[1], head_height), (pos[0], pos[1], head_height), 0, undefined);
      indoors = trace[#"fraction"] != 1;

      if(indoors) {
        debug_star((pos[0], pos[1], head_height), (0, 1, 0), debug_display_time);

        dist *= 4;

        if(dist > radius) {
          return false;
        }
      } else {
        debug_star((pos[0], pos[1], head_height), (1, 0, 0), debug_display_time);

        trace = weapons::damage_trace((pos[0], pos[1], head_height), pos, 0, undefined);
        indoors = trace[#"fraction"] != 1;

        if(indoors) {
          debug_star(pos, (0, 1, 0), debug_display_time);

          dist *= 4;

          if(dist > radius) {
            return false;
          }
        } else {
          debug_star(pos, (1, 0, 0), debug_display_time);
        }
      }
    } else {
      debug_star(ent.entity.origin + (0, 0, assumed_ceiling_height), (1, 0, 0), debug_display_time);
    }
  }

  ent.damage = int(max + (min - max) * dist / radius);
  ent.pos = pos;
  ent.damageowner = owner;
  ent.einflictor = einflictor;
  return true;
}

function getrandommappoint(x_offset, y_offset, map_x_percentage, map_y_percentage) {
  minimaporigins = getEntArray("minimap_corner", "targetname");

  if(minimaporigins.size) {
    rand_x = 0;
    rand_y = 0;

    if(minimaporigins[0].origin[0] < minimaporigins[1].origin[0]) {
      rand_x = randomfloatrange(minimaporigins[0].origin[0] * map_x_percentage, minimaporigins[1].origin[0] * map_x_percentage);
      rand_y = randomfloatrange(minimaporigins[0].origin[1] * map_y_percentage, minimaporigins[1].origin[1] * map_y_percentage);
    } else {
      rand_x = randomfloatrange(minimaporigins[1].origin[0] * map_x_percentage, minimaporigins[0].origin[0] * map_x_percentage);
      rand_y = randomfloatrange(minimaporigins[1].origin[1] * map_y_percentage, minimaporigins[0].origin[1] * map_y_percentage);
    }

    return (x_offset + rand_x, y_offset + rand_y, 0);
  }

  return (x_offset, y_offset, 0);
}

function getmaxmapwidth() {
  minimaporigins = getEntArray("minimap_corner", "targetname");

  if(minimaporigins.size) {
    x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
    y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
    return max(x, y);
  }

  return 0;
}

function stoprotation(time) {
  self endon(#"death");
  wait time;
  self stoploopsound();
}

function flattenyaw(goal) {
  self endon(#"death");
  increment = 3;

  if(self.angles[1] > goal) {
    increment *= -1;
  }

  while(abs(self.angles[1] - goal) > 3) {
    self.angles = (self.angles[0], self.angles[1] + increment, self.angles[2]);
    waitframe(1);
  }
}

function flattenroll() {
  self endon(#"death");

  while(self.angles[2] < 0) {
    self.angles = (self.angles[0], self.angles[1], self.angles[2] + 2.5);
    waitframe(1);
  }
}

function leave(duration, var_384be02f = 0) {
  self unlink();
  self thread stoprotation(1);
  tries = 10;
  yaw = 0;

  while(tries > 0) {
    exitvector = anglesToForward(self.angles + (0, yaw, 0)) * 20000;
    exitpoint = (self.origin[0] + exitvector[0], self.origin[1] + exitvector[1], self.origin[2] + var_384be02f);
    nfz = crossesnoflyzone(self.origin, exitpoint);

    if(isDefined(nfz)) {
      if(tries != 1) {
        if(tries % 2 == 1) {
          yaw *= -1;
        } else {
          yaw += 10;
          yaw *= -1;
        }
      }

      tries--;
      continue;
    }

    tries = 0;
  }

  self thread flattenyaw(self.angles[1] + yaw);

  if(self.angles[2] != 0) {
    self thread flattenroll();
  }

  if(isvehicle(self)) {
    self setspeed(length(exitvector) / duration / 17.6, 60);
    self setgoal(exitpoint, 0, 0);
  } else {
    self moveto(exitpoint, duration, 0, 0);
  }

  self notify(#"leaving");
}

function getrandomhelicopterstartorigin() {
  dist = -1 * getdvarint(#"scr_supplydropincomingdistance", 10000);
  pathrandomness = 100;
  direction = (0, randomintrange(-2, 3), 0);
  start_origin = anglesToForward(direction) * dist;
  start_origin += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);

  if(getdvarint(#"scr_noflyzones_debug", 0)) {
    if(level.noflyzones.size) {
      index = randomintrange(0, level.noflyzones.size);
      delta = level.noflyzones[index].origin;
      delta = (delta[0] + randomint(10), delta[1] + randomint(10), 0);
      delta = vectornormalize(delta);
      start_origin = delta * dist;
    }
  }

  return start_origin;
}

function debug_no_fly_zones() {
  for(i = 0; i < level.noflyzones.size; i++) {
    debug_airsupport_cylinder(level.noflyzones[i].origin, level.noflyzones[i].radius, level.noflyzones[i].height, (1, 1, 1), undefined, 5000);
  }
}

function debug_plane_line(flytime, flyspeed, pathstart, pathend) {
  thread debug_line(pathstart, pathend, (1, 1, 1));

  delta = vectornormalize(pathend - pathstart);

  for(i = 0; i < flytime; i++) {
    thread debug_star(pathstart + vectorscale(delta, i * flyspeed), (1, 0, 0));
  }
}

function debug_draw_bomb_explosion(prevpos) {
  self notify(#"draw_explosion");
  waitframe(1);
  self endon(#"draw_explosion");
  waitresult = self waittill(#"projectile_impact");

  thread debug_line(prevpos, waitresult.position, (0.5, 1, 0));
  thread debug_star(waitresult.position, (1, 0, 0));
}

function debug_draw_bomb_path(projectile, color, time) {
  self endon(#"death");
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(!isDefined(color)) {
    color = (0.5, 1, 0);
  }

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    prevpos = self.origin;

    while(isDefined(self.origin)) {
      thread debug_line(prevpos, self.origin, color, time);

      prevpos = self.origin;

      if(isDefined(projectile) && projectile) {
        thread debug_draw_bomb_explosion(prevpos);
      }

      wait 0.2;
    }
  }
}

function debug_print3d_simple(message, ent, offset, frames) {
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    if(isDefined(frames)) {
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, frames);
      return;
    }

    thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, 0);
  }
}

function draw_text(msg, color, ent, offset, frames) {
  if(frames == 0) {
    while(isDefined(ent) && isDefined(ent.origin)) {
      print3d(ent.origin + offset, msg, color, 0.5, 4);
      waitframe(1);
    }

    return;
  }

  for(i = 0; i < frames; i++) {
    if(!isDefined(ent)) {
      break;
    }

    print3d(ent.origin + offset, msg, color, 0.5, 4);
    waitframe(1);
  }
}

function debug_print3d(message, color, ent, origin_offset, frames) {
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    self thread draw_text(message, color, ent, origin_offset, frames);
  }
}

function debug_line(from, to, color, time, depthtest) {
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    if(distancesquared(from, to) < 0.01) {
      return;
    }

    if(!isDefined(time)) {
      time = 1000;
    }

    if(!isDefined(depthtest)) {
      depthtest = 1;
    }

    line(from, to, color, 1, depthtest, time);
  }
}

function debug_star(origin, color, time) {
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    if(!isDefined(time)) {
      time = 1000;
    }

    if(!isDefined(color)) {
      color = (1, 1, 1);
    }

    debugstar(origin, time, color);
  }
}

function debug_circle(origin, radius, color, time) {
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    if(!isDefined(time)) {
      time = 1000;
    }

    if(!isDefined(color)) {
      color = (1, 1, 1);
    }

    circle(origin, radius, color, 1, 1, time);
  }
}

function debug_sphere(origin, radius, color, alpha, time) {
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    if(!isDefined(time)) {
      time = 1000;
    }

    if(!isDefined(color)) {
      color = (1, 1, 1);
    }

    sides = int(10 * (1 + int(radius / 100)));
    sphere(origin, radius, color, alpha, 1, sides, time);
  }
}

function debug_airsupport_cylinder(origin, radius, height, color, mustrenderheight, time) {
  level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1) {
    debug_cylinder(origin, radius, height, color, mustrenderheight, time);
  }
}

function debug_cylinder(origin, radius, height, color, mustrenderheight, time) {
  subdivision = 600;

  if(!isDefined(time)) {
    time = 1000;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  count = height / subdivision;

  for(i = 0; i < count; i++) {
    point = origin + (0, 0, i * subdivision);
    circle(point, radius, color, 1, 1, time);
  }

  if(isDefined(mustrenderheight)) {
    point = origin + (0, 0, mustrenderheight);
    circle(point, radius, color, 1, 1, time);
  }
}

function getpointonline(startpoint, endpoint, ratio) {
  nextpoint = (startpoint[0] + (endpoint[0] - startpoint[0]) * ratio, startpoint[1] + (endpoint[1] - startpoint[1]) * ratio, startpoint[2] + (endpoint[2] - startpoint[2]) * ratio);
  return nextpoint;
}

function cantargetplayerwithspecialty() {
  if(self hasperk(#"specialty_nottargetedbyairsupport") || isDefined(self.specialty_nottargetedbyairsupport) && self.specialty_nottargetedbyairsupport) {
    if(!isDefined(self.nottargettedai_underminspeedtimer) || self.nottargettedai_underminspeedtimer < getdvarint(#"perk_nottargetedbyai_graceperiod", 0)) {
      return false;
    }
  }

  return true;
}

function monitorspeed(spawnprotectiontime) {
  self endon(#"death", #"disconnect");

  if(self hasperk(#"specialty_nottargetedbyairsupport") == 0) {
    return;
  }

  getdvarstring(#"perk_nottargetted_graceperiod");
  graceperiod = getdvarint(#"perk_nottargetedbyai_graceperiod", 0);
  minspeed = getdvarint(#"perk_nottargetedbyai_min_speed", 0);
  minspeedsq = minspeed * minspeed;
  waitperiod = 0.25;
  waitperiodmilliseconds = int(waitperiod * 1000);

  if(minspeedsq == 0) {
    return;
  }

  self.nottargettedai_underminspeedtimer = 0;

  if(isDefined(spawnprotectiontime)) {
    wait spawnprotectiontime;
  }

  while(true) {
    velocity = self getvelocity();
    speedsq = lengthsquared(velocity);

    if(speedsq < minspeedsq) {
      self.nottargettedai_underminspeedtimer += waitperiodmilliseconds;
    } else {
      self.nottargettedai_underminspeedtimer = 0;
    }

    wait waitperiod;
  }
}

function clearmonitoredspeed() {
  if(isDefined(self.nottargettedai_underminspeedtimer)) {
    self.nottargettedai_underminspeedtimer = 0;
  }
}

function function_9e2054b0(var_65885f89) {
  self clientfield::set_player_uimodel("locSel.snapTo", 0);
  self[[var_65885f89]]();
  self.selectinglocation = 1;
  self thread endselectionthink();
  self clientfield::set_player_uimodel("locSel.commandMode", 0);
  self thread function_deb91ef4();
}

function waitforlocationselection() {
  self endon(#"emp_jammed", #"emp_grenaded");
  waitresult = self waittill(#"confirm_location");
  locationinfo = spawnStruct();
  locationinfo.origin = waitresult.position;
  locationinfo.yaw = waitresult.yaw;
  return locationinfo;
}

function function_deb91ef4() {
  self endon(#"emp_jammed", #"emp_grenaded", #"disconnect", #"confirm_location", #"cancel_location", #"enter_vehicle");

  while(true) {
    waitresult = self waittill(#"menuresponse");
    menu = waitresult.menu;
    response = waitresult.response;

    if(menu == "LocationSelector") {
      if(response == "cancel") {
        self notify(#"cancel_location");
        return;
      }

      if(response == "player_location") {
        self notify(#"confirm_location", {
          #position: self.origin, #yaw: 0
        });
        return;
      }

      if(response == "take_control") {
        self notify(#"enter_vehicle");
        return;
      }

      objid = waitresult.intpayload;

      foreach(point in level.var_51368c39) {
        if(point.objectiveid == objid) {
          self notify(#"confirm_location", {
            #position: point.origin, #yaw: point.yaw
          });
          return;
        }
      }

      objpos = function_cc3ada06(objid);

      if(isDefined(objpos)) {
        self notify(#"confirm_location", {
          #position: objpos, #yaw: 0
        });
        return;
      }
    }

    waitframe(1);
  }
}

function singleradarsweep() {
  self endon(#"disconnect", #"cancel_selection");
  wait 0.5;
  self playlocalsound(#"mpl_killstreak_satellite");

  if(!level.forceradar) {
    self thread radarsweep();
  }
}

function radarsweep() {
  self setclientuivisibilityflag("g_compassShowEnemies", 1);
  wait 0.2;
  self setclientuivisibilityflag("g_compassShowEnemies", 0);
}