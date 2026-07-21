/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\vehicle_treads.gsc
***********************************************/

vehicle_treads() {
  var_0 = self.classname;

  if(!isDefined(level.vehicle.templates.surface_effects[var_0])) {
    return;
  }
  if(scripts\common\vehicle_code::no_treads()) {
    return;
  }
  if(isDefined(level.tread_override_thread))
    self thread[[level.tread_override_thread]]("tag_origin", "back_left", (160, 0, 0));
  else {
    if(isDefined(level.vehicle.templates.single_tread_list) && isDefined(level.vehicle.templates.single_tread_list[self.vehicletype])) {
      thread do_single_tread();
      return;
    }

    thread do_multiple_treads();
  }
}

do_multiple_treads() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = tread_wait();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    tread(self, var_0, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    tread(self, var_0, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

tread_wait() {
  var_0 = self vehicle_getspeed();

  if(!var_0)
    return -1;

  var_0 = var_0 * 17.6;
  var_1 = 1 / var_0;
  var_1 = clamp(var_1 * 35, 0.1, 0.3);

  if(isDefined(self.treadfx_freq_scale))
    var_1 = var_1 * self.treadfx_freq_scale;

  wait(var_1);
  return var_1;
}

tread(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_treadfx(self, var_3);

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

get_treadfx(var_0, var_1) {
  var_2 = self getwheelsurface(var_1);

  if(!isDefined(var_0.vehicletype)) {
    var_3 = -1;
    return var_3;
  }

  var_4 = var_0.classname;
  return scripts\common\vehicle_code::get_vehicle_effect(var_4, var_2);
}

do_single_tread() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = tread_wait();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    tread(self, var_0, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}