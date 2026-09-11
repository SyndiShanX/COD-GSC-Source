/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\objpoints.gsc
***********************************************/

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

function createteamobjpoint(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    var3 = "objpoint_default";
  }

  if(!isDefined(var5)) {
    var5 = 1;
  }

  var6 = undefined;

  if(var2 != "all") {
    var6 = newteamhudelem(var2);
  } else {
    var6 = newhudelem();
  }

  var6.id = var0;
  var6.x = var1[0];
  var6.y = var1[1];
  var6.z = var1[2];
  var6.team = var2;
  var6.isflashing = 0;
  var6.isshown = 1;
  var6 setshader(var3, level.objpointsize, level.objpointsize);
  var6 setwaypoint(1, 0);

  if(isDefined(var4)) {
    var6.alpha = var4;
  } else {
    var6.alpha = level.objpoint_alpha_default;
  }

  var6.basealpha = var6.alpha;
  return var6;
}

function deleteobjpoint(var0) {
  if(level.objpoints.size == 1) {
    level.objpoints = [];
    level.objpointnames = [];
    var0 destroy();
    return;
  }

  var1 = var0.index;
  var2 = level.objpointnames.size - 1;
  var3 = getobjpointbyindex(var2);
  level.objpointnames[var1] = var3.name;
  var3.index = var1;
  level.objpointnames[var2] = undefined;
  level.objpoints[var0.name] = undefined;
  var0 destroy();
}

function updateorigin(var0) {
  if(self.x != var0[0]) {
    self.x = var0[0];
  }

  if(self.y != var0[1]) {
    self.y = var0[1];
  }

  if(self.z != var0[2]) {
    self.z = var0[2];
    return;
  }
}

function setoriginbyname(var0, var1) {
  var2 = getobjpointbyname(var0);
  updateorigin(var2, var1);
}

function getobjpointbyname(var0) {
  if(isDefined(level.objpoints[var0])) {
    return level.objpoints[var0];
  }

  return undefined;
}

function getobjpointbyindex(var0) {
  if(isDefined(level.objpointnames[var0])) {
    return level.objpoints[level.objpointnames[var0]];
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