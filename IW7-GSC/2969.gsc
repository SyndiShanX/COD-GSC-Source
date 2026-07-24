/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2969.gsc
**************************************/

_id_1324B() {
  var_0 = self.classname;

  if(!isDefined(level.vehicle._id_116CE._id_112D9[var_0])) {
    return;
  }
  if(scripts\sp\vehicle_code::_id_C018()) {
    return;
  }
  if(isDefined(level._id_126F0)) {
    self thread[[level._id_126F0]]("tag_origin", "back_left", (160, 0, 0));
  } else {
    if(isDefined(level.vehicle._id_116CE._id_1020A) && isDefined(level.vehicle._id_116CE._id_1020A[self.vehicletype])) {
      thread _id_57BE();
      return;
    }

    thread _id_579F();
  }
}

_id_579F() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = _id_126F1();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    _id_126EF(self, var_0, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    _id_126EF(self, var_0, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

_id_126F1() {
  var_0 = self vehicle_getspeed();

  if(!var_0) {
    return -1;
  }

  var_0 = var_0 * 17.6;
  var_1 = 1 / var_0;
  var_1 = clamp(var_1 * 35, 0.1, 0.3);

  if(isDefined(self._id_126F2)) {
    var_1 = var_1 * self._id_126F2;
  }

  wait(var_1);
  return var_1;
}

_id_126EF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_7D1B(self, var_3);

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = var_0 gettagangles(var_2);
  var_8 = anglesToForward(var_7);
  var_9 = self gettagorigin(var_2);

  if(var_4) {
    var_10 = self gettagorigin(var_5);
    var_9 = (var_9 + var_10) / 2;
  }

  playFX(var_6, var_9, anglestoup(var_7), var_8 * var_1);
}

_id_7D1B(var_0, var_1) {
  var_2 = self _meth_8178(var_1);

  if(!isDefined(var_0.vehicletype)) {
    var_3 = -1;
    return var_3;
  }

  var_4 = var_0.classname;
  return scripts\sp\vehicle_code::_id_7D44(var_4, var_2);
}

_id_57BE() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = _id_126F1();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    _id_126EF(self, var_0, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}