/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\objpoints.gsc
***********************************************/

init() {
  precacheshader("objpoint_default");
  level.objpointnames = [];
  level.objpoints = [];

  if(level.splitscreen)
    level.objpointsize = 15;
  else
    level.objpointsize = 8;

  level.objpoint_alpha_default = 0.75;
  level.objpointscale = 1.0;
}

createteamobjpoint(index, origin, team, shader, alpha, scale) {
  if(!isDefined(shader))
    shader = "objpoint_default";

  if(!isDefined(scale))
    scale = 1.0;

  _id_B74984F8B12CF978 = undefined;

  if(team != "all")
    _id_B74984F8B12CF978 = newteamhudelem(team);
  else
    _id_B74984F8B12CF978 = newhudelem();

  _id_B74984F8B12CF978.id = index;
  _id_B74984F8B12CF978.x = origin[0];
  _id_B74984F8B12CF978.y = origin[1];
  _id_B74984F8B12CF978.z = origin[2];
  _id_B74984F8B12CF978.team = team;
  _id_B74984F8B12CF978.isflashing = 0;
  _id_B74984F8B12CF978.isshown = 1;
  _id_B74984F8B12CF978 setshader(shader, level.objpointsize, level.objpointsize);
  _id_B74984F8B12CF978 setwaypoint(1, 0);

  if(isDefined(alpha))
    _id_B74984F8B12CF978.alpha = alpha;
  else
    _id_B74984F8B12CF978.alpha = level.objpoint_alpha_default;

  _id_B74984F8B12CF978.basealpha = _id_B74984F8B12CF978.alpha;
  return _id_B74984F8B12CF978;
}

deleteobjpoint(_id_2F8B2FF7E0389B27) {
  if(level.objpoints.size == 1) {
    level.objpoints = [];
    level.objpointnames = [];
    _id_2F8B2FF7E0389B27 destroy();
    return;
  }

  _id_DC6CBFDA5CAFD043 = _id_2F8B2FF7E0389B27.index;
  _id_A7F6D4BE6B657D86 = level.objpointnames.size - 1;
  _id_B74984F8B12CF978 = getobjpointbyindex(_id_A7F6D4BE6B657D86);
  level.objpointnames[_id_DC6CBFDA5CAFD043] = _id_B74984F8B12CF978.name;
  _id_B74984F8B12CF978.index = _id_DC6CBFDA5CAFD043;
  level.objpointnames[_id_A7F6D4BE6B657D86] = undefined;
  level.objpoints[_id_2F8B2FF7E0389B27.name] = undefined;
  _id_2F8B2FF7E0389B27 destroy();
}

updateorigin(origin) {
  if(self.x != origin[0])
    self.x = origin[0];

  if(self.y != origin[1])
    self.y = origin[1];

  if(self.z != origin[2])
    self.z = origin[2];
}

setoriginbyname(name, origin) {
  _id_B74984F8B12CF978 = getobjpointbyname(name);
  _id_B74984F8B12CF978 updateorigin(origin);
}

getobjpointbyname(name) {
  if(isDefined(level.objpoints[name]))
    return level.objpoints[name];
  else
    return undefined;
}

getobjpointbyindex(index) {
  if(isDefined(level.objpointnames[index]))
    return level.objpoints[level.objpointnames[index]];
  else
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