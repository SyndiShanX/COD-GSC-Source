/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2969.gsc
************************/

func_1324B() {
  var_00 = self.classname;
  if(!isDefined(level.vehicle.var_116CE.var_112D9[var_00])) {
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
    var_00 = func_126F1();
    if(var_00 == -1) {
      wait(0.1);
      continue;
    }

    func_126EF(self, var_00, "tag_wheel_back_left", "back_left", 0);
    wait(0.05);
    func_126EF(self, var_00, "tag_wheel_back_right", "back_right", 0);
    wait(0.05);
  }
}

func_126F1() {
  var_00 = self vehicle_getspeed();
  if(!var_00) {
    return -1;
  }

  var_00 = var_00 * 17.6;
  var_01 = 1 / var_00;
  var_01 = clamp(var_01 * 35, 0.1, 0.3);
  if(isDefined(self.var_126F2)) {
    var_01 = var_01 * self.var_126F2;
  }

  wait(var_01);
  return var_01;
}

func_126EF(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_7D1B(self, param_03);
  if(!isDefined(var_06)) {
    return;
  }

  var_07 = param_00 gettagangles(param_02);
  var_08 = anglesToForward(var_07);
  var_09 = self gettagorigin(param_02);
  if(param_04) {
    var_0A = self gettagorigin(param_05);
    var_09 = var_09 + var_0A / 2;
  }

  playFX(var_06, var_09, anglestoup(var_07), var_08 * param_01);
}

func_7D1B(param_00, param_01) {
  var_02 = self _meth_8178(param_01);
  if(!isDefined(param_00.var_380)) {
    var_03 = -1;
    return var_03;
  }

  var_04 = param_01.classname;
  return scripts\sp\vehicle_code::func_7D44(var_04, var_03);
}

func_57BE() {
  self endon("death");
  self endon("kill_treads_forever");
  for(;;) {
    var_00 = func_126F1();
    if(var_00 == -1) {
      wait(0.1);
      continue;
    }

    func_126EF(self, var_00, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}