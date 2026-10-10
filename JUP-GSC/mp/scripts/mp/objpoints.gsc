/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\objpoints.gsc
***********************************************/

#using scripts\mp\hud_util;
#namespace objpoints;

function init() {
  precacheshader("objpoint_default");
  level.objpointnames = [];
  level.objpoints = [];

  if(level.splitscreen) {
    level.objpointsize = 15;
  } else {
    level.objpointsize = 8;
  }

  level.objpoint_alpha_default = 0.75;
  level.objpointscale = 1;
}

function createteamobjpoint(index, origin, team, shader, alpha, scale) {
  assert(team == "<dev string:x1c>");

  if(!isDefined(shader)) {
    shader = "objpoint_default";
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  objpoint = undefined;

  if(team != "all") {
    objpoint = newteamhudelem(team);
  } else {
    objpoint = newhudelem();
  }

  objpoint.id = index;
  objpoint.x = origin[0];
  objpoint.y = origin[1];
  objpoint.z = origin[2];
  objpoint.team = team;
  objpoint.isflashing = 0;
  objpoint.isshown = 1;
  objpoint setshader(shader, level.objpointsize, level.objpointsize);
  objpoint setwaypoint(1, 0);

  if(isDefined(alpha)) {
    objpoint.alpha = alpha;
  } else {
    objpoint.alpha = level.objpoint_alpha_default;
  }

  objpoint.basealpha = objpoint.alpha;
  return objpoint;
}

function deleteobjpoint(var_2f8b2ff7e0389b27) {
  assert(level.objpoints.size == level.objpointnames.size);

  if(level.objpoints.size == 1) {
    assert(level.objpointnames[0] == var_2f8b2ff7e0389b27.name);
    assert(isDefined(level.objpoints[var_2f8b2ff7e0389b27.name]));
    level.objpoints = [];
    level.objpointnames = [];
    var_2f8b2ff7e0389b27 destroy();
    return;
  }

  newindex = var_2f8b2ff7e0389b27.index;
  oldindex = level.objpointnames.size - 1;
  objpoint = getobjpointbyindex(oldindex);
  level.objpointnames[newindex] = objpoint.name;
  objpoint.index = newindex;
  level.objpointnames[oldindex] = undefined;
  level.objpoints[var_2f8b2ff7e0389b27.name] = undefined;
  var_2f8b2ff7e0389b27 destroy();
}

function updateorigin(origin) {
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

function setoriginbyname(name, origin) {
  objpoint = getobjpointbyname(name);
  objpoint updateorigin(origin);
}

function getobjpointbyname(name) {
  if(isDefined(level.objpoints[name])) {
    return level.objpoints[name];
  }

  return undefined;
}

function getobjpointbyindex(index) {
  if(isDefined(level.objpointnames[index])) {
    return level.objpoints[level.objpointnames[index]];
  }

  return undefined;
}

function startflashing() {
  self endon("stop_flashing_thread");

  if(self.isflashing) {
    return;
  }

  self.isflashing = 1;

  while(self.isflashing) {
    self fadeovertime(0.75);
    self.alpha = 0.35 * self.basealpha;
    wait 0.75;
    self fadeovertime(0.75);
    self.alpha = self.basealpha;
    wait 0.75;
  }

  self.alpha = self.basealpha;
}

function stopflashing() {
  if(!self.isflashing) {
    return;
  }

  self.isflashing = 0;
}