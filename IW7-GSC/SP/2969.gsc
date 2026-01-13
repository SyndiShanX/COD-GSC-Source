/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2969.gsc
************************/

func_1324B() {
  var_0 = self.classname;
  if(!isDefined(level.vehicle.var_116CE.var_112D9[var_0])) {
    return;
  }

  if(scripts\sp\vehicle_code::func_C018()) {
    return;
  }

  if(isDefined(level.var_126F0)) {
    self thread[[level.var_126F0]]("tag_origin", "back_left", (160, 0, 0));
    return;
  }

  if(isDefined(level.vehicle.var_116CE.var_1020A) && isDefined(level.vehicle.var_116CE.var_1020A[self.var_380])) {
    thread func_57BE();
    return;
  }

  thread func_579F();
}

func_579F() {
  self endon("death");
  self endon("kill_treads_forever");
  for(;;) {
    var_0 = func_126F1();
    if(var_0 == -1) {
      wait(0.1);
      continue;
    }

    func_126EF(self, var_0, "tag_wheel_back_left", "back_left", 0);
    wait(0.05);
    func_126EF(self, var_0, "tag_wheel_back_right", "back_right", 0);
    wait(0.05);
  }
}

func_126F1() {
  var_0 = self vehicle_getspeed();
  if(!var_0) {
    return -1;
  }

  var_0 = var_0 * 17.6;
  var_1 = 1 / var_0;
  var_1 = clamp(var_1 * 35, 0.1, 0.3);
  if(isDefined(self.var_126F2)) {
    var_1 = var_1 * self.var_126F2;
  }

  wait(var_1);
  return var_1;
}

func_126EF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_7D1B(self, var_3);
  if(!isDefined(var_6)) {
    return;
  }

  var_7 = var_0 gettagangles(var_2);
  var_8 = anglesToForward(var_7);
  var_9 = self gettagorigin(var_2);
  if(var_4) {
    var_0A = self gettagorigin(var_5);
    var_9 = var_9 + var_0A / 2;
  }

  playFX(var_6, var_9, anglestoup(var_7), var_8 * var_1);
}

func_7D1B(var_0, var_1) {
  var_2 = self _meth_8178(var_1);
  if(!isDefined(var_0.var_380)) {
    var_3 = -1;
    return var_3;
  }

  var_4 = var_1.classname;
  return scripts\sp\vehicle_code::func_7D44(var_4, var_3);
}

func_57BE() {
  self endon("death");
  self endon("kill_treads_forever");
  for(;;) {
    var_0 = func_126F1();
    if(var_0 == -1) {
      wait(0.1);
      continue;
    }

    func_126EF(self, var_0, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}