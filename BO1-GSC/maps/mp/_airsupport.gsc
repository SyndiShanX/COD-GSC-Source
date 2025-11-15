/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_airsupport.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

initAirsupport() {
  if(!isDefined(level.airsupportHeightScale))
    level.airsupportHeightScale = 1;
  level.airsupportHeightScale = getDvarIntDefault(#"scr_airsupportHeightScale", level.airsupportHeightScale);
  level.noFlyZones = [];
  level.noFlyZones = getEntArray("no_fly_zone", "targetname");
  airsupport_heights = getstructarray("air_support_height", "targetname");
  if(airsupport_heights.size > 1) {
    error("Found more then one 'air_support_height' structs in the map");
  }
  airsupport_heights = getEntArray("air_support_height", "targetname");
  if(airsupport_heights.size > 0) {
    error("Found an entity in the map with an 'air_support_height' targetname.There should be only structs.");
  }
  heli_height_meshes = getEntArray("heli_height_lock", "classname");
  if(heli_height_meshes.size > 1) {
    error("Found more then one 'heli_height_lock' classname in the map");
  }
}
finishHardpointLocationUsage(location, usedCallback) {
  self notify("used");
  wait(0.05);
  return self[[usedCallback]](location);
}
finishDualHardpointLocationUsage(locationStart, locationEnd, usedCallback) {
  self notify("used");
  wait(0.05);
  return self[[usedCallback]](locationStart, locationEnd);
}
endSelectionOnGameEnd() {
  self endon("death");
  self endon("disconnect");
  self endon("cancel_location");
  self endon("used");
  level waittill("game_ended");
  self notify("game_ended");
}
endSelectionThink() {
  assert(IsPlayer(self));
  assert(IsAlive(self));
  assert(isDefined(self.selectingLocation));
  assert(self.selectingLocation == true);
  self thread endSelectionOnGameEnd();
  event = self waittill_any_return("death", "disconnect", "cancel_location", "game_ended", "used", "weapon_change");
  if(event != "disconnect") {
    self endLocationSelection();
    self.selectingLocation = undefined;
  }
  if(event != "used") {
    self notify("confirm_location", undefined, undefined);
  }
}
deleteAfterTime(time) {
  self endon("death");
  wait(time);
  self delete();
}
stopLoopSoundAfterTime(time) {
  self endon("death");
  wait(time);
  self stoploopsound(2);
}
calculateFallTime(flyHeight) {
  gravity = GetDvarInt(#"bg_gravity");
  time = sqrt((2 * flyHeight) / gravity);
  return time;
}
calculateReleaseTime(flyTime, flyHeight, flySpeed, bombSpeedScale) {
  falltime = calculateFallTime(flyHeight);
  bomb_x = (flySpeed * bombSpeedScale) * falltime;
  release_time = bomb_x / flySpeed;
  return ((flyTime * 0.5) - release_time);
}
getMinimumFlyHeight() {
  airsupport_height = getstruct("air_support_height", "targetname");
  if(isDefined(airsupport_height)) {
    planeFlyHeight = airsupport_height.origin[2];
  } else {
    planeFlyHeight = 850;
    if(isDefined(level.airsupportHeightScale)) {
      level.airsupportHeightScale = getDvarIntDefault(#"scr_airsupportHeightScale", level.airsupportHeightScale);
      planeFlyHeight *= getDvarIntDefault(#"scr_airsupportHeightScale", level.airsupportHeightScale);
    }
    if(isDefined(level.forceAirsupportMapHeight)) {
      planeFlyHeight += level.forceAirsupportMapHeight;
    }
  }
  return planeFlyHeight;
}
callStrike(flightPlan) {
  level.bomberDamagedEnts = [];
  level.bomberDamagedEntsCount = 0;
  level.bomberDamagedEntsIndex = 0;
  AssertEx(flightPlan.distance != 0, "callStrike can not be passed a zero fly distance");
  planeHalfDistance = flightPlan.distance / 2;
  path = getStrikePath(flightPlan.target, flightPlan.height, planeHalfDistance);
  startPoint = path["start"];
  endPoint = path["end"];
  flightPlan.height = path["height"];
  direction = path["direction"];
  d = length(startPoint - endPoint);
  flyTime = (d / flightPlan.speed);
  bombTime = calculateReleaseTime(flyTime, flightPlan.height, flightPlan.speed, flightPlan.bombSpeedScale);
  if(bombTime < 0) {
    bombTime = 0;
  }
  assert(flyTime > bombTime);
  flightPlan.owner endon("disconnect");
  requiredDeathCount = flightPlan.owner.deathCount;
  side = vectorcross(anglesToForward(direction), (0, 0, 1));
  plane_seperation = 25;
  side_offset = vector_scale(side, plane_seperation);
  level thread planeStrike(flightPlan.owner, requiredDeathCount, startPoint, endPoint, bombTime, flyTime, flightPlan.speed, flightPlan.bombSpeedScale, direction, flightPlan.planeSpawnCallback);
  wait(flightPlan.planeSpacing);
  level thread planeStrike(flightPlan.owner, requiredDeathCount, startPoint + side_offset, endPoint + side_offset, bombTime, flyTime, flightPlan.speed, flightPlan.bombSpeedScale, direction, flightPlan.planeSpawnCallback);
  wait(flightPlan.planeSpacing);
  side_offset = vector_scale(side, -1 * plane_seperation);
  level thread planeStrike(flightPlan.owner, requiredDeathCount, startPoint + side_offset, endPoint + side_offset, bombTime, flyTime, flightPlan.speed, flightPlan.bombSpeedScale, direction, flightPlan.planeSpawnCallback);
}
planeStrike(owner, requiredDeathCount, pathStart, pathEnd, bombTime, flyTime, flyspeed, bombSpeedScale, direction, planeSpawnedFunction) {
  if(!isDefined(owner))
    return;
  plane = spawnplane(owner, "script_model", pathStart);
  plane.angles = direction;
  plane moveTo(pathEnd, flyTime, 0, 0);
  thread debug_plane_line(flyTime, flyspeed, pathStart, pathEnd);
  if(isDefined(planeSpawnedFunction)) {
    plane[[planeSpawnedFunction]](owner, requiredDeathCount, pathStart, pathEnd, bombTime, bombSpeedScale, flyTime, flyspeed);
  }
  wait flyTime;
  plane notify("delete");
  plane delete();
}
determineGroundPoint(player, position) {
  ground = (position[0], position[1], player.origin[2]);
  trace = bulletTrace(ground + (0, 0, 10000), ground, false, undefined);
  return trace["position"];
}
determineTargetPoint(player, position) {
  point = determineGroundPoint(player, position);
  return clampTarget(point);
}
getMinTargetHeight() {
  return level.spawnMins[2] - 500;
}
getMaxTargetHeight() {
  return level.spawnMaxs[2] + 500;
}
clampTarget(target) {
  min = getMinTargetHeight();
  max = getMaxTargetHeight();
  if(target[2] < min)
    target[2] = min;
  if(target[2] > max)
    target[2] = max;
  return target;
}
_insideCylinder(point, base, radius, height) {
  if(isDefined(height)) {
    if(point[2] > base[2] + height)
      return false;
  }
  dist = Distance2D(point, base);
  if(dist < radius)
    return true;
  return false;
}
_insideNoFlyZoneByIndex(point, index, disregardHeight) {
  height = level.noFlyZones[index].height;
  if(isDefined(disregardHeight))
    height = undefined;
  return _insideCylinder(point, level.noFLyZones[index].origin, level.noFlyZones[index].radius, height);
}
getNoFlyZoneHeight(point) {
  height = point[2];
  origin = undefined;
  for(i = 0; i < level.noFlyZones.size; i++) {
    if(_insideNoFlyZoneByIndex(point, i)) {
      if(height < level.noFlyZones[i].height) {
        height = level.noFlyZones[i].height;
        origin = level.noFlyZones[i].origin;
      }
    }
  }
  if(!isDefined(origin))
    return point[2];
  return origin[2] + height;
}
insideNoFlyZones(point, disregardHeight) {
  noFlyZones = [];
  for(i = 0; i < level.noFlyZones.size; i++) {
    if(_insideNoFlyZoneByIndex(point, i, disregardHeight)) {
      noFlyZones[noFlyZones.size] = i;
    }
  }
  return noFlyZones;
}
crossesNoFlyZone(start, end) {
  for(i = 0; i < level.noFlyZones.size; i++) {
    point = closestPointOnLine(level.noFlyZones[i].origin, start, end);
    dist = Distance2D(point, level.noFlyZones[i].origin);
    if(point[2] > (level.noFlyZones[i].origin[2] + level.noFlyZones[i].height))
      continue;
    if(dist < level.noFlyZones[i].radius) {
      return i;
    }
  }
  return undefined;
}
crossesNoFlyZones(start, end) {
  zones = [];
  for(i = 0; i < level.noFlyZones.size; i++) {
    point = closestPointOnLine(level.noFlyZones[i].origin, start, end);
    dist = Distance2D(point, level.noFlyZones[i].origin);
    if(point[2] > (level.noFlyZones[i].origin[2] + level.noFlyZones[i].height))
      continue;
    if(dist < level.noFlyZones[i].radius) {
      zones[zones.size] = i;
    }
  }
  return zones;
}
getNoFlyZoneHeightCrossed(start, end, minHeight) {
  height = minHeight;
  for(i = 0; i < level.noFlyZones.size; i++) {
    point = closestPointOnLine(level.noFlyZones[i].origin, start, end);
    dist = Distance2D(point, level.noFlyZones[i].origin);
    if(dist < level.noFlyZones[i].radius) {
      if(height < level.noFlyZones[i].height)
        height = level.noFlyZones[i].height;
    }
  }
  return height;
}
_shouldIgnoreNoFlyZone(noFlyZone, noFlyZones) {
  if(!isDefined(noFlyZone))
    return true;
  for(i = 0; i < noFlyZones.size; i++) {
    if(isDefined(noFlyZones[i]) && noFlyZones[i] == noFlyZone)
      return true;
  }
  return false;
}
_shouldIgnoreStartGoalNoFlyZone(noFlyZone, startNoFlyZones, goalNoFlyZones) {
  if(!isDefined(noFlyZone))
    return true;
  if(_shouldIgnoreNoFlyZone(noFlyZone, startNoFlyZones))
    return true;
  if(_shouldIgnoreNoFlyZone(noFlyZone, goalNoFlyZones))
    return true;
  return false;
}
getHeliPath(start, goal) {
  startNoFlyZones = insideNoFlyZones(start, true);
  thread debug_line(start, goal, (1, 1, 1));
  goalNoFlyZones = insideNoFlyZones(goal);
  if(goalNoFlyZones.size) {
    goal = (goal[0], goal[1], getNoFlyZoneHeight(goal));
  }
  goal_points = calculatePath(start, goal, startNoFlyZones, goalNoFlyZones);
  if(!isDefined(goal_points))
    return undefined;
  Assert(goal_points.size >= 1);
  return goal_points;
}
followPath(path, doneNotify, stopAtGoal) {
  for(i = 0; i < (path.size - 1); i++) {
    self SetVehGoalPos(path[i], false);
    thread debug_line(self.origin, path[i], (1, 1, 0));
    self waittill("goal");
  }
  self SetVehGoalPos(path[path.size - 1], stopAtGoal);
  thread debug_line(self.origin, path[i], (1, 1, 0));
  self waittill("goal");
  if(isDefined(doneNotify)) {
    self notify(doneNotify);
  }
}
setGoalPosition(goal, doneNotify, stopAtGoal) {
  if(!isDefined(stopAtGoal))
    stopAtGoal = true;
  start = self.origin;
  goal_points = getHeliPath(start, goal);
  if(!isDefined(goal_points)) {
    goal_points = [];
    goal_points[0] = goal;
  }
  followPath(goal_points, doneNotify, stopAtGoal);
}
clearPath(start, end, startNoFlyZone, goalNoFlyZone) {
  noFlyZones = crossesNoFlyZones(start, end);
  for(i = 0; i < noFlyZones.size; i++) {
    if(!_shouldIgnoreStartGoalNoFlyZone(noFlyZones[i], startNoFlyZone, goalNoFlyZone)) {
      return false;
    }
  }
  return true;
}
append_array(dst, src) {
  for(i = 0; i < src.size; i++) {
    dst[dst.size] = src[i];
  }
}
calculatePath_r(start, end, points, startNoFlyZones, goalNoFlyZones, depth) {
  depth--;
  if(depth <= 0) {
    points[points.size] = end;
    return points;
  }
  noFlyZones = crossesNoFlyZones(start, end);
  for(i = 0; i < noFlyZones.size; i++) {
    noFlyZone = noFlyZones[i];
    if(!_shouldIgnoreStartGoalNoFlyZone(noFlyZone, startNoFlyZones, goalNoFlyZones)) {
      return undefined;
    }
  }
  points[points.size] = end;
  return points;
}
calculatePath(start, end, startNoFlyZones, goalNoFlyZones) {
  points = [];
  points = calculatePath_r(start, end, points, startNoFlyZones, goalNoFlyZones, 3);
  if(!isDefined(points))
    return undefined;
  Assert(points.size >= 1);
  debug_sphere(points[points.size - 1], 10, (1, 0, 0), 1, 1000);
  point = start;
  for(i = 0; i < points.size; i++) {
    thread debug_line(point, points[i], (0, 1, 0));
    debug_sphere(points[i], 10, (0, 0, 1), 1, 1000);
    point = points[i];
  }
  return points;
}
_getStrikePathStartAndEnd(goal, yaw, halfDistance) {
  direction = (0, yaw, 0);
  startPoint = goal + vector_scale(anglesToForward(direction), -1 * halfDistance);
  endPoint = goal + vector_scale(anglesToForward(direction), halfDistance);
  noFlyZone = crossesNoFlyZone(startPoint, endPoint);
  path = [];
  if(isDefined(noFlyZone)) {
    path["noFlyZone"] = noFlyZone;
    startPoint = (startPoint[0], startPoint[1], level.noFlyZones[noFlyZone].origin[2] + level.noFlyZones[noFlyZone].height);
    endPoint = (endPoint[0], endPoint[1], startPoint[2]);
  } else {
    path["noFlyZone"] = undefined;
  }
  path["start"] = startPoint;
  path["end"] = endPoint;
  path["direction"] = direction;
  return path;
}
getStrikePath(target, height, halfDistance, yaw) {
  noFlyZoneHeight = getNoFlyZoneHeight(target);
  worldHeight = target[2] + height;
  if(noFlyZoneHeight > worldHeight) {
    worldHeight = noFlyZoneHeight;
  }
  goal = (target[0], target[1], worldHeight);
  path = [];
  if(!isDefined(yaw) || yaw != "random") {
    for(i = 0; i < 3; i++) {
      path = _getStrikePathStartAndEnd(goal, randomint(360), halfDistance);
      if(!isDefined(path["noFlyZone"])) {
        break;
      }
    }
  } else {
    path = _getStrikePathStartAndEnd(goal, yaw, halfDistance);
  }
  path["height"] = worldHeight - target[2];
  return path;
}
doGlassDamage(pos, radius, max, min, mod) {
  wait(RandomFloatRange(0.05, 0.15));
  glassRadiusDamage(pos, radius, max, min, mod);
}
entLOSRadiusDamage(ent, pos, radius, max, min, owner, eInflictor) {
  dist = distance(pos, ent.damageCenter);
  if(ent.isPlayer || ent.isActor) {
    assumed_ceiling_height = 800;
    eye_position = ent.entity getEye();
    head_height = eye_position[2];
    debug_display_time = 40 * 100;
    trace = maps\mp\gametypes\_weapons::weaponDamageTrace(ent.entity.origin, ent.entity.origin + (0, 0, assumed_ceiling_height), 0, undefined);
    indoors = (trace["fraction"] != 1);
    if(indoors) {
      test_point = trace["position"];
      debug_star(test_point, (0, 1, 0), debug_display_time);
      trace = maps\mp\gametypes\_weapons::weaponDamageTrace((test_point[0], test_point[1], head_height), (pos[0], pos[1], head_height), 0, undefined);
      indoors = (trace["fraction"] != 1);
      if(indoors) {
        debug_star((pos[0], pos[1], head_height), (0, 1, 0), debug_display_time);
        dist *= 4;
        if(dist > radius)
          return false;
      } else {
        debug_star((pos[0], pos[1], head_height), (1, 0, 0), debug_display_time);
        trace = maps\mp\gametypes\_weapons::weaponDamageTrace((pos[0], pos[1], head_height), pos, 0, undefined);
        indoors = (trace["fraction"] != 1);
        if(indoors) {
          debug_star(pos, (0, 1, 0), debug_display_time);
          dist *= 4;
          if(dist > radius)
            return false;
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
  ent.damageOwner = owner;
  ent.eInflictor = eInflictor;
  return true;
}
debug_plane_line(flyTime, flyspeed, pathStart, pathEnd) {
  thread debug_line(pathStart, pathEnd, (1, 1, 1));
  delta = VectorNormalize(pathEnd - pathStart);
  for(i = 0; i < flyTime; i++) {
    thread debug_star(pathStart + vector_scale(delta, i * flyspeed), (1, 0, 0));
  }
}
debug_draw_bomb_explosion(prevpos) {
  self notify("draw_explosion");
  wait(0.05);
  self endon("draw_explosion");
  self waittill("projectile_impact", weapon, position);
  thread debug_line(prevpos, position, (.5, 1, 0));
  thread debug_star(position, (1, 0, 0));
}
debug_draw_bomb_path(projectile, color, time) {}
debug_print3d_simple(message, ent, offset, frames) {}
draw_text(msg, color, ent, offset, frames) {
  if(frames == 0) {
    while(isDefined(ent)) {
      print3d(ent.origin + offset, msg, color, 0.5, 4);
      wait 0.05;
    }
  } else {
    for(i = 0; i < frames; i++) {
      if(!isDefined(ent)) {
        break;
      }
      print3d(ent.origin + offset, msg, color, 0.5, 4);
      wait 0.05;
    }
  }
}
debug_print3d(message, color, ent, origin_offset, frames) {}
debug_line(from, to, color, time) {}
debug_star(origin, color, time) {}
debug_circle(origin, radius, color, time) {}
debug_sphere(origin, radius, color, alpha, time) {}
debug_cylinder(origin, radius, height, color, mustRenderHeight, time) {}
getPointOnLine(startPoint, endPoint, ratio) {
  nextPoint = (startPoint[0] + ((endPoint[0] - startPoint[0]) * ratio),
    startPoint[1] + ((endPoint[1] - startPoint[1]) * ratio),
    startPoint[2] + ((endPoint[2] - startPoint[2]) * ratio));
  return nextPoint;
}