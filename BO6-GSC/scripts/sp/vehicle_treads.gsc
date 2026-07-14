/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\vehicle_treads.gsc
*****************************************/

#using scripts\common\vehicle;
#using scripts\sp\vehicle;
#namespace vehicle_treads;

function no_treads() {
  return vehicle::ishelicopter() || vehicle::isairplane();
}

function vehicle_treads() {
  tread_class = self.classname;

  if(!isDefined(level.vehicle.templates.surface_effects[tread_class])) {
    return;
  }

  if(no_treads()) {
    return;
  }

  if(isDefined(level.tread_override_thread)) {
    self thread[[level.tread_override_thread]]("\xec\xbfK|\au\xcd\xc2\x19<", "\x8d\xea,\xe40\t\xddt\x83", (160, 0, 0));
    return;
  }

  if(isDefined(level.vehicle.templates.single_tread_list) && isDefined(level.vehicle.templates.single_tread_list[self.vehicletype])) {
    thread do_single_tread();
    return;
  }

  thread do_multiple_treads();
}

function do_multiple_treads() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\tD#\xd8\xcb\bWKM\xc8\x01&m\x84h\x92\xd2#\xd9");

  while(true) {
    scale = tread_wait();

    if(scale == -1) {
      wait 0.1;
      continue;
    }

    tread(self, scale, "tXg}\xdd\xa1Y\xcac\xbeb\x85c\xad\xf5\x8d\x95fG", "\x8d\xea,\xe40\t\xddt\x83", 0);
    wait 0.05;
    tread(self, scale, "\x89\x16\x80\xf2.\xd6\x84\x96\xd4\x9d\xb2\x13\x8d\xacb\x94\x82\xe7\r\xc1", "\xfb\xac\xa5\r\xe3s[\xdd\xf4y", 0);
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

function tread(dummy, scale, tagname, side, var_19b68603757d862b, secondtag) {
  treadfx = get_treadfx(self, side);

  if(!isDefined(treadfx)) {
    return;
  }

  ang = dummy gettagangles(tagname);
  forwardvec = anglesToForward(ang);
  effectorigin = self gettagorigin(tagname);

  if(var_19b68603757d862b) {
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
  return vehicle::get_vehicle_effect(classname, surface);
}

function do_single_tread() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\tD#\xd8\xcb\bWKM\xc8\x01&m\x84h\x92\xd2#\xd9");

  while(true) {
    scale = tread_wait();

    if(scale == -1) {
      wait 0.1;
      continue;
    }

    tread(self, scale, "tXg}\xdd\xa1Y\xcac\xbeb\x85c\xad\xf5\x8d\x95fG", "\x8d\xea,\xe40\t\xddt\x83", 1, "\x89\x16\x80\xf2.\xd6\x84\x96\xd4\x9d\xb2\x13\x8d\xacb\x94\x82\xe7\r\xc1");
  }
}