/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2042.gsc
*************************************************/

init() {
  _func_01B2("objpoint_default");
  level._id_A918 = [];
  level._id_A919 = [];

  if(level.splitscreen) {
    level._id_A91B = 15;
  } else {
    level._id_A91B = 8;
  }

  level._id_A917 = 0.75;
  level._id_A91A = 1.0;
}

_id_4060(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = "objpoint_default";
  }

  if(!isDefined(var_5)) {
    var_5 = 1.0;
  }

  var_6 = undefined;

  if(var_2 != "all") {
    var_6 = newteamhudelem(var_2);
  } else {
    var_6 = newhudelem();
  }

  var_6._id_7C8C = var_0;
  var_6.x = var_1[0];
  var_6.y = var_1[1];
  var_6._id_050C = var_1[2];
  var_6.team = var_2;
  var_6._id_8864 = 0;
  var_6._id_8A30 = 1;
  var_6 setshader(var_3, level._id_A91B, level._id_A91B);
  var_6 _meth_83B2(1, 0);

  if(isDefined(var_4)) {
    var_6.alpha = var_4;
  } else {
    var_6.alpha = level._id_A917;
  }

  var_6._id_22AE = var_6.alpha;
  return var_6;
}

_id_4776(var_0) {
  if(level._id_A919.size == 1) {
    level._id_A919 = [];
    level._id_A918 = [];
    var_0 destroy();
    return;
  }

  var_1 = var_0.index;
  var_2 = level._id_A918.size - 1;
  var_3 = _id_6BC3(var_2);
  level._id_A918[var_1] = var_3.name;
  var_3.index = var_1;
  level._id_A918[var_2] = undefined;
  level._id_A919[var_0.name] = undefined;
  var_0 destroy();
}

_id_FCE0(var_0) {
  if(self.x != var_0[0]) {
    self.x = var_0[0];
  }

  if(self.y != var_0[1]) {
    self.y = var_0[1];
  }

  if(self._id_050C != var_0[2]) {
    self._id_050C = var_0[2];
  }
}

_id_D62C(var_0, var_1) {
  var_2 = _id_6BC4(var_0);
  var_2 _id_FCE0(var_1);
}

_id_6BC4(var_0) {
  if(isDefined(level._id_A919[var_0])) {
    return level._id_A919[var_0];
  } else {
    return undefined;
  }
}

_id_6BC3(var_0) {
  if(isDefined(level._id_A918[var_0])) {
    return level._id_A919[level._id_A918[var_0]];
  } else {
    return undefined;
  }
}

_id_E6AC() {
  self endon("stop_flashing_thread");

  if(self._id_8864) {
    return;
  }
  self._id_8864 = 1;

  while(self._id_8864) {
    self fadeovertime(0.75);
    self.alpha = 0.35 * self._id_22AE;
    wait 0.75;
    self fadeovertime(0.75);
    self.alpha = self._id_22AE;
    wait 0.75;
  }

  self.alpha = self._id_22AE;
}

_id_E90C() {
  if(!self._id_8864) {
    return;
  }
  self._id_8864 = 0;
}