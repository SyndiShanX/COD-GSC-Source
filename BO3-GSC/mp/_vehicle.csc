/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_vehicle.csc
*************************************************/

#using scripts\mp\killstreaks\_ai_tank;
#using scripts\mp\killstreaks\_qrdrone;
#using scripts\mp\killstreaks\_rcbomb;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace vehicle;

function autoexec __init__sytem__() {
  system::register("vehicle", &__init__, undefined, undefined);
}

function __init__() {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }
  level.vehicles_inited = 1;
  clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
}

function vehicle_rumble(localclientnum) {
  self endon("entityshutdown");
  if(!isDefined(level.vehicle_rumble)) {
    return;
  }
  type = self.vehicletype;
  if(!isDefined(level.vehicle_rumble[type])) {
    return;
  }
  rumblestruct = level.vehicle_rumble[type];
  height = rumblestruct.radius * 2;
  zoffset = -1 * rumblestruct.radius;
  if(!isDefined(self.rumbleon)) {
    self.rumbleon = 1;
  }
  if(isDefined(rumblestruct.scale)) {
    self.rumble_scale = rumblestruct.scale;
  } else {
    self.rumble_scale = 0.15;
  }
  if(isDefined(rumblestruct.duration)) {
    self.rumble_duration = rumblestruct.duration;
  } else {
    self.rumble_duration = 4.5;
  }
  if(isDefined(rumblestruct.radius)) {
    self.rumble_radius = rumblestruct.radius;
  } else {
    self.rumble_radius = 600;
  }
  if(isDefined(rumblestruct.basetime)) {
    self.rumble_basetime = rumblestruct.basetime;
  } else {
    self.rumble_basetime = 1;
  }
  if(isDefined(rumblestruct.randomaditionaltime)) {
    self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }
  self.player_touching = 0;
  radius_squared = rumblestruct.radius * rumblestruct.radius;
  while(true) {
    if(distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() < 35) {
      wait(0.2);
      continue;
    }
    if(isDefined(self.rumbleon) && !self.rumbleon) {
      wait(0.2);
      continue;
    }
    self playrumblelooponentity(localclientnum, level.vehicle_rumble[type].rumble);
    while(distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 5) {
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
    }
    self stoprumble(localclientnum, level.vehicle_rumble[type].rumble);
  }
}

function set_static_amount(staticamount) {
  driverlocalclient = self getlocalclientdriver();
  if(isDefined(driverlocalclient)) {
    driver = getlocalplayer(driverlocalclient);
    if(isDefined(driver)) {
      setfilterpassconstant(driver.localclientnum, 4, 0, 1, staticamount);
    }
  }
}

function vehicle_variants(localclientnum) {}

function timeout_beep(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("timeout_beep");
  if(!newval) {
    return;
  }
  if(isDefined(self.killstreakbundle)) {
    beepalias = self.killstreakbundle.kstimeoutbeepalias;
  }
  self endon("entityshutdown");
  self endon("timeout_beep");
  interval = 1;
  if(newval == 2) {
    interval = 0.133;
  }
  while(true) {
    if(isDefined(beepalias)) {
      self playSound(localclientnum, beepalias);
    }
    if(self.timeoutlightsoff === 1) {
      self lights_on(localclientnum);
      self.timeoutlightsoff = 0;
    } else {
      self lights_off(localclientnum);
      self.timeoutlightsoff = 1;
    }
    util::server_wait(localclientnum, interval);
    interval = math::clamp(interval / 1.17, 0.1, 1);
  }
}