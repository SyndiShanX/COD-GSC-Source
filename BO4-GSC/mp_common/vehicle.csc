/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\vehicle.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\vehicle_shared;

#namespace vehicle;

autoexec __init__system__() {
  system::register(#"vehicle", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level.vehicles_inited = 1;
}

vehicle_rumble(localclientnum) {
  self endon(#"death");

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
      wait 0.2;
      continue;
    }

    if(isDefined(self.rumbleon) && !self.rumbleon) {
      wait 0.2;
      continue;
    }

    self playrumblelooponentity(localclientnum, level.vehicle_rumble[type].rumble);

    while(distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 5) {
      wait self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime);
    }

    self stoprumble(localclientnum, level.vehicle_rumble[type].rumble);
  }
}

vehicle_variants(localclientnum) {}