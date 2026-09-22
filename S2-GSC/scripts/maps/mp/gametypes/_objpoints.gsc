/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_objpoints.gsc
****************************************************/

init() {
  _precacheshader("objpoint_default");
  level._id_6995 = [];
  level._id_6996 = [];

  if(level.splitscreen) {
    level._id_6998 = 15;
  } else {
    level._id_6998 = 8;
  }

  level._id_6994 = 0.7;
  level._id_6997 = 1.0;
}

_id_282F(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_45D6(var_0);

  if(isDefined(var_6)) {
    _id_2D3E(var_6);
  }

  if(!isDefined(var_3)) {
    var_3 = "objpoint_default";
  }

  if(!isDefined(var_5)) {
    var_5 = 1.0;
  }

  if(var_2 == "all") {
    var_6 = newhudelem();
  } else if(var_2 == "broadcaster") {
    var_6 = _newteamhudelem("spectator");
  } else {
    var_6 = _newteamhudelem(var_2);
  }

  var_6.name = var_0;
  var_6.x = var_1[0];
  var_6.y = var_1[1];
  var_6._id_01D9 = var_1[2];
  var_6.team = var_2;
  var_6._id_56F5 = 0;
  var_6._id_57CB = 1;
  var_6 setshader(var_3, level._id_6998, level._id_6998);
  var_6 setwaypoint(1, 0);

  if(isDefined(var_4)) {
    var_6.alpha = var_4;
  } else {
    var_6.alpha = level._id_6994;
  }

  var_6._id_15F3 = var_6.alpha;
  var_6._id_00D4 = level._id_6995.size;
  level._id_6996[var_0] = var_6;
  level._id_6995[level._id_6995.size] = var_0;
  return var_6;
}

_id_2D3E(var_0) {
  if(level._id_6996.size == 1) {
    level._id_6996 = [];
    level._id_6995 = [];
    var_0 destroy();
    return;
  }

  var_1 = var_0._id_00D4;
  var_2 = level._id_6995.size - 1;
  var_3 = _id_45D5(var_2);
  level._id_6995[var_1] = var_3.name;
  var_3._id_00D4 = var_1;
  level._id_6995[var_2] = undefined;
  level._id_6996[var_0.name] = undefined;
  var_0 destroy();
}

_id_A145(var_0) {
  if(self.x != var_0[0]) {
    self.x = var_0[0];
  }

  if(self.y != var_0[1]) {
    self.y = var_0[1];
  }

  if(self._id_01D9 != var_0[2]) {
    self._id_01D9 = var_0[2];
  }
}

_id_86E6(var_0, var_1) {
  var_2 = _id_45D6(var_0);
  var_2 _id_A145(var_1);
}

_id_45D6(var_0) {
  if(isDefined(level._id_6996[var_0])) {
    return level._id_6996[var_0];
  } else {
    return undefined;
  }
}

_id_45D5(var_0) {
  if(isDefined(level._id_6995[var_0])) {
    return level._id_6996[level._id_6995[var_0]];
  } else {
    return undefined;
  }
}

_id_92CF() {
  self endon("stop_flashing_thread");

  if(self._id_56F5) {
    return;
  }
  self._id_56F5 = 1;

  while(self._id_56F5) {
    self fadeovertime(0.75);
    self.alpha = 0.35 * self._id_15F3;
    wait 0.75;
    self fadeovertime(0.75);
    self.alpha = self._id_15F3;
    wait 0.75;
  }

  self.alpha = self._id_15F3;
}

_id_9401() {
  if(!self._id_56F5) {
    return;
  }
  self._id_56F5 = 0;
}