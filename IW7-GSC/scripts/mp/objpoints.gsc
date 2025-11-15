/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\objpoints.gsc
************************************/

init() {
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

func_4A23(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getobjpointbyname(param_00);
  if(isDefined(var_06)) {
    deleteobjpoint(var_06);
  }

  if(!isDefined(param_03)) {
    param_03 = "objpoint_default";
  }

  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  if(param_02 != "all") {
    var_06 = newteamhudelem(param_02);
  } else {
    var_06 = newhudelem();
  }

  var_06.name = param_00;
  var_06.x = param_01[0];
  var_06.y = param_01[1];
  var_06.var_3A6 = param_01[2];
  var_06.team = param_02;
  var_06.isflashing = 0;
  var_06.var_9F51 = 1;
  var_06 setshader(param_03, level.objpointsize, level.objpointsize);
  var_06 setwaypoint(1, 0);
  if(isDefined(param_04)) {
    var_06.alpha = param_04;
  } else {
    var_06.alpha = level.objpoint_alpha_default;
  }

  var_06.basealpha = var_06.alpha;
  var_06.index = level.objpointnames.size;
  level.objpoints[param_00] = var_06;
  level.objpointnames[level.objpointnames.size] = param_00;
  return var_06;
}

deleteobjpoint(param_00) {
  if(level.objpoints.size == 1) {
    level.objpoints = [];
    level.objpointnames = [];
    param_00 destroy();
    return;
  }

  var_01 = param_00.index;
  var_02 = level.objpointnames.size - 1;
  var_03 = getobjpointbyindex(var_02);
  level.objpointnames[var_01] = var_03.name;
  var_03.index = var_01;
  level.objpointnames[var_02] = undefined;
  level.objpoints[param_00.name] = undefined;
  param_00 destroy();
}

updateorigin(param_00) {
  if(self.x != param_00[0]) {
    self.x = param_00[0];
  }

  if(self.y != param_00[1]) {
    self.y = param_00[1];
  }

  if(self.var_3A6 != param_00[2]) {
    self.var_3A6 = param_00[2];
  }
}

setoriginbyname(param_00, param_01) {
  var_02 = getobjpointbyname(param_00);
  var_02 updateorigin(param_01);
}

getobjpointbyname(param_00) {
  if(isDefined(level.objpoints[param_00])) {
    return level.objpoints[param_00];
  }

  return undefined;
}

getobjpointbyindex(param_00) {
  if(isDefined(level.objpointnames[param_00])) {
    return level.objpoints[level.objpointnames[param_00]];
  }

  return undefined;
}

startflashing() {
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

stopflashing() {
  if(!self.isflashing) {
    return;
  }

  self.isflashing = 0;
}