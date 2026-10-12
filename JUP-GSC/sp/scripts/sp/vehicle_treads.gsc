/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\vehicle_treads.gsc
***********************************************/



#using scripts\common\vehicle_code;
#namespace vehicle_treads;

function vehicle_treads() {
  tread_class = self.classname;

  if(!isDefined(level.vehicle.templates.surface_effects[tread_class])) {
    return;
  }

  if(no_treads()) {
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

  while(true) {
    scale = tread_wait();

    if(scale == -1) {
      wait 0.1;
      continue;
    }

    tread(self, scale, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    tread(self, scale, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

function tread_wait() {
  speed = self vehicle_getspeed();

  if(!speed) {
    return -1;
  }

  speed *= 17.6;
  waittime = 1 / speed;
  waittime = clamp(waittime * 35, 0.1, 0.3);

  if(isDefined(self.treadfx_freq_scale)) {
    waittime *= self.treadfx_freq_scale;
  }

  wait waittime;
  return waittime;
}

function tread(dummy, scale, tagname, side, var_974d8ff6c0e6f78e, secondtag) {
  treadfx = get_treadfx(self, side);

  if(!isDefined(treadfx)) {
    return;
  }

  ang = dummy gettagangles(tagname);
  forwardvec = anglesToForward(ang);
  effectorigin = self gettagorigin(tagname);

  if(var_974d8ff6c0e6f78e) {
    secondtagorigin = self gettagorigin(secondtag);
    effectorigin = (effectorigin + secondtagorigin) / 2;
  }

  playFX(treadfx, effectorigin, anglestoup(ang), forwardvec * scale);
}

function get_treadfx(vehicle, side) {
  if(vehicle vehicle_isphysveh()) {
    surface = self getwheelsurface(0);
  } else {
    surface = self getwheelsurface(side);
  }

  if(!isDefined(vehicle.vehicletype)) {
    treadfx = -1;
    return treadfx;
  }

  classname = vehicle.classname;
  return get_vehicle_effect(classname, surface);
}

function do_single_tread() {
  self endon("death");
  self endon("kill_treads_forever");

  while(true) {
    scale = tread_wait();

    if(scale == -1) {
      wait 0.1;
      continue;
    }

    tread(self, scale, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}