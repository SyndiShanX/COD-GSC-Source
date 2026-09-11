/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\vehicle_treads.gsc
***********************************************/

function vehicle_treads() {
  var0 = self.classname;

  if(!isDefined(level.vehicle.templates.surface_effects[var0])) {
    return;
  }

  if(scripts\common\vehicle_code::no_treads()) {
    return;
  }

  if(isDefined(level.tread_override_thread)) {
    self thread[[level.tread_override_thread]]("tag_origin", "back_left", (160, 0, 0));
    return;
  }

  if(isDefined(level.vehicle.templates.single_tread_list) && isDefined(level.vehicle.templates.single_tread_list[self.vehicletype])) {
    thread do_single_tread();
    return;
  }

  thread do_multiple_treads();
}

function do_multiple_treads() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var0 = tread_wait();

    if(var0 == -1) {
      wait 0.1;
      continue;
    }

    tread(self, var0, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    tread(self, var0, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

function tread_wait() {
  var0 = self vehicle_getspeed();

  if(!var0) {
    return -1;
  }

  var0 *= 17.6;
  var1 = 1 / var0;
  var1 = clamp(var1 * 35, 0.1, 0.3);

  if(isDefined(self.treadfx_freq_scale)) {
    var1 *= self.treadfx_freq_scale;
  }

  wait var1;
  return var1;
}

function tread(var0, var1, var2, var3, var4, var5) {
  var6 = get_treadfx(self, var3);

  if(!isDefined(var6)) {
    return;
  }

  var7 = var0 gettagangles(var2);
  var8 = anglesToForward(var7);
  var9 = self gettagorigin(var2);

  if(var4) {
    var10 = self gettagorigin(var5);
    var9 = (var9 + var10) / 2;
  }

  playFX(var6, var9, anglestoup(var7), var8 * var1);
}

function get_treadfx(var0, var1) {
  var2 = self getwheelsurface(var1);

  if(!isDefined(var0.vehicletype)) {
    var3 = -1;
    return var3;
  }

  var4 = var1.classname;
  return scripts\common\vehicle_code::get_vehicle_effect(var4, var3);
}

function do_single_tread() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var0 = tread_wait();

    if(var0 == -1) {
      wait 0.1;
      continue;
    }

    tread(self, var0, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}