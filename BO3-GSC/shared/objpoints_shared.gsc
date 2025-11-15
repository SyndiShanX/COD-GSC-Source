/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\objpoints_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace objpoints;

function autoexec __init__sytem__() {
  system::register("objpoints", & __init__, undefined, undefined);
}

function __init__() {
  level.objpointnames = [];
  level.objpoints = [];
  if(isDefined(level.splitscreen) && level.splitscreen) {
    level.objpointsize = 15;
  } else {
    level.objpointsize = 8;
  }
  level.objpoint_alpha_default = 1;
  level.objpointscale = 1;
}

function create(name, origin, team, shader, alpha, scale) {
  assert(isDefined(level.teams[team]) || team == "");
  objpoint = get_by_name(name);
  if(isDefined(objpoint)) {
    delete(objpoint);
  }
  if(!isDefined(shader)) {
    shader = "objpoint_default";
  }
  if(!isDefined(scale)) {
    scale = 1;
  }
  if(team != "all") {
    objpoint = newteamhudelem(team);
  } else {
    objpoint = newhudelem();
  }
  objpoint.name = name;
  objpoint.x = origin[0];
  objpoint.y = origin[1];
  objpoint.z = origin[2];
  objpoint.team = team;
  objpoint.isflashing = 0;
  objpoint.isshown = 1;
  objpoint.fadewhentargeted = 1;
  objpoint.archived = 0;
  objpoint setshader(shader, level.objpointsize, level.objpointsize);
  objpoint setwaypoint(1);
  if(isDefined(alpha)) {
    objpoint.alpha = alpha;
  } else {
    objpoint.alpha = level.objpoint_alpha_default;
  }
  objpoint.basealpha = objpoint.alpha;
  objpoint.index = level.objpointnames.size;
  level.objpoints[name] = objpoint;
  level.objpointnames[level.objpointnames.size] = name;
  return objpoint;
}

function delete(oldobjpoint) {
  assert(level.objpoints.size == level.objpointnames.size);
  if(level.objpoints.size == 1) {
    assert(level.objpointnames[0] == oldobjpoint.name);
    assert(isDefined(level.objpoints[oldobjpoint.name]));
    level.objpoints = [];
    level.objpointnames = [];
    oldobjpoint destroy();
    return;
  }
  newindex = oldobjpoint.index;
  oldindex = level.objpointnames.size - 1;
  objpoint = get_by_index(oldindex);
  level.objpointnames[newindex] = objpoint.name;
  objpoint.index = newindex;
  level.objpointnames[oldindex] = undefined;
  level.objpoints[oldobjpoint.name] = undefined;
  oldobjpoint destroy();
}

function update_origin(origin) {
  if(self.x != origin[0]) {
    self.x = origin[0];
  }
  if(self.y != origin[1]) {
    self.y = origin[1];
  }
  if(self.z != origin[2]) {
    self.z = origin[2];
  }
}

function set_origin_by_name(name, origin) {
  objpoint = get_by_name(name);
  objpoint update_origin(origin);
}

function get_by_name(name) {
  if(isDefined(level.objpoints[name])) {
    return level.objpoints[name];
  }
  return undefined;
}

function get_by_index(index) {
  if(isDefined(level.objpointnames[index])) {
    return level.objpoints[level.objpointnames[index]];
  }
  return undefined;
}

function start_flashing() {
  self endon("stop_flashing_thread");
  if(self.isflashing) {
    return;
  }
  self.isflashing = 1;
  while(self.isflashing) {
    self fadeovertime(0.75);
    self.alpha = 0.35 * self.basealpha;
    wait(0.75);
    self fadeovertime(0.75);
    self.alpha = self.basealpha;
    wait(0.75);
  }
  self.alpha = self.basealpha;
}

function stop_flashing() {
  if(!self.isflashing) {
    return;
  }
  self.isflashing = 0;
}