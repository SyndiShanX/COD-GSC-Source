/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_objpoints.gsc
********************************************/

init() {
  precacheshader("objpoint_default");
  level.objpointnames = [];
  level.objpoints = [];

  if(level.splitscreen)
    level.objpointsize = 15;
  else
    level.objpointsize = 8;

  level.objpoint_alpha_default = 0.7;
  level.objpointscale = 1.0;
}

createteamobjpoint(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getobjpointbyname(var_0);

  if(isdefined(var_6))
    deleteobjpoint(var_6);

  if(!isdefined(var_3))
    var_3 = "objpoint_default";

  if(!isdefined(var_5))
    var_5 = 1.0;

  if(var_2 == "all")
    var_6 = newhudelem();
  else if(var_2 == "mlg")
    var_6 = newteamhudelem("spectator");
  else
    var_6 = newteamhudelem(var_2);

  var_6.name = var_0;
  var_6.x = var_1[0];
  var_6.y = var_1[1];
  var_6.z = var_1[2];
  var_6.team = var_2;
  var_6.isflashing = 0;
  var_6.isshown = 1;
  var_6 setshader(var_3, level.objpointsize, level.objpointsize);
  var_6 setwaypoint(1, 0);

  if(isdefined(var_4))
    var_6.alpha = var_4;
  else
    var_6.alpha = level.objpoint_alpha_default;

  var_6.basealpha = var_6.alpha;
  var_6.index = level.objpointnames.size;
  level.objpoints[var_0] = var_6;
  level.objpointnames[level.objpointnames.size] = var_0;
  return var_6;
}

deleteobjpoint(var_0) {
  if(level.objpoints.size == 1) {
    level.objpoints = [];
    level.objpointnames = [];
    var_0 destroy();
    return;
  }

  var_1 = var_0.index;
  var_2 = level.objpointnames.size - 1;
  var_3 = getobjpointbyindex(var_2);
  level.objpointnames[var_1] = var_3.name;
  var_3.index = var_1;
  level.objpointnames[var_2] = undefined;
  level.objpoints[var_0.name] = undefined;
  var_0 destroy();
}

deleteallobjpoints() {
  if(isdefined(level.objpoints) && level.objpoints.size > 0) {
    foreach(var_1 in level.objpoints) {
      if(isdefined(var_1))
        var_1 destroy();
    }

    level.objpoints = [];
    level.objpointnames = [];
  }
}

updateorigin(var_0) {
  if(self.x != var_0[0])
    self.x = var_0[0];

  if(self.y != var_0[1])
    self.y = var_0[1];

  if(self.z != var_0[2])
    self.z = var_0[2];
}

setoriginbyname(var_0, var_1) {
  var_2 = getobjpointbyname(var_0);
  var_2 updateorigin(var_1);
}

getobjpointbyname(var_0) {
  if(isdefined(level.objpoints[var_0]))
    return level.objpoints[var_0];
  else
    return undefined;
}

getobjpointbyindex(var_0) {
  if(isdefined(level.objpointnames[var_0]))
    return level.objpoints[level.objpointnames[var_0]];
  else
    return undefined;
}

startflashing() {
  self endon("stop_flashing_thread");

  if(self.isflashing) {
    return;
  }
  self.isflashing = 1;

  while (self.isflashing) {
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