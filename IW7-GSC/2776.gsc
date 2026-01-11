/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2776.gsc
***************************************/

init() {
  precacheshader("objpoint_default");
  level.objpointnames = [];
  level.objpoints = [];

  if(level.splitscreen) {
    level.objpointsize = 15;
  }
  else {
    level.objpointsize = 8;
  }

  level.objpoint_alpha_default = 0.75;
  level.objpointscale = 1.0;
}

func_4A23(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = getobjpointbyname(var_00);

  if(isDefined(var_06)) {
    deleteobjpoint(var_06);
  }

  if(!isDefined(var_03)) {
    var_03 = "objpoint_default";
  }

  if(!isDefined(var_05)) {
    var_05 = 1.0;
  }

  if(var_02 != "all") {
    var_06 = newteamhudelem(var_02);
  }
  else {
    var_06 = newhudelem();
  }

  var_6.name = var_00;
  var_6.x = var_1[0];
  var_6.y = var_1[1];
  var_6.z = var_1[2];
  var_6.team = var_02;
  var_6.isflashing = 0;
  var_6.func_9F51 = 1;
  var_06 setshader(var_03, level.objpointsize, level.objpointsize);
  var_06 setwaypoint(1, 0);

  if(isDefined(var_04)) {
    var_6.alpha = var_04;
  }
  else {
    var_6.alpha = level.objpoint_alpha_default;
  }

  var_6.basealpha = var_6.alpha;
  var_6.index = level.objpointnames.size;
  level.objpoints[var_00] = var_06;
  level.objpointnames[level.objpointnames.size] = var_00;
  return var_06;
}

deleteobjpoint(var_00) {
  if(level.objpoints.size == 1) {
    level.objpoints = [];
    level.objpointnames = [];
    var_00 destroy();
    return;
  }

  var_01 = var_0.index;
  var_02 = level.objpointnames.size - 1;
  var_03 = getobjpointbyindex(var_02);
  level.objpointnames[var_01] = var_3.name;
  var_3.index = var_01;
  level.objpointnames[var_02] = undefined;
  level.objpoints[var_0.name] = undefined;
  var_00 destroy();
}

updateorigin(var_00) {
  if(self.x != var_0[0]) {
    self.x = var_0[0];
  }

  if(self.y != var_0[1]) {
    self.y = var_0[1];
  }

  if(self.z != var_0[2]) {
    self.z = var_0[2];
  }
}

setoriginbyname(var_00, var_01) {
  var_02 = getobjpointbyname(var_00);
  var_02 updateorigin(var_01);
}

getobjpointbyname(var_00) {
  if(isDefined(level.objpoints[var_00])) {
    return level.objpoints[var_00];
  }
  else {
    return undefined;
  }
}

getobjpointbyindex(var_00) {
  if(isDefined(level.objpointnames[var_00])) {
    return level.objpoints[level.objpointnames[var_00]];
  }
  else {
    return undefined;
  }
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
    wait 0.75;
    self fadeovertime(0.75);
    self.alpha = self.basealpha;
    wait 0.75;
  }

  self.alpha = self.basealpha;
}

stopflashing() {
  if(!self.isflashing) {
    return;
  }
  self.isflashing = 0;
}