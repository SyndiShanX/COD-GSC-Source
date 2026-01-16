/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_lasersight.gsc
********************************/

lasersight_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.laser_on = undefined;
  self.wasemp = 0;
  self.has_laser = 0;

  for (;;) {
    while (maps\mp\_utility::isemped() && self.has_laser) {
      wait 0.05;
      self laseroff();
      self.wasemp = 1;
      continue;
    }

    if(self.wasemp && self.has_laser) {
      self.wasemp = 0;

      if(maps\mp\gametypes\_class::isexoxmg(self getcurrentweapon()) || maps\mp\gametypes\_class::issac3(self getcurrentweapon()))
        self laseron("mp_attachment_lasersight_short");
      else
        self laseron("mp_attachment_lasersight");
    }

    if(issubstr(self getcurrentweapon(), "maaws"))
      self.has_laser = 1;

    if(self.has_laser && self isthrowinggrenade()) {
      if(isdefined(self.laser_on) && self.laser_on) {
        self laseroff();
        self.laser_on = 0;

        while (!self isusingoffhand() && self isthrowinggrenade())
          wait 0.05;

        while (self isusingoffhand() && self isthrowinggrenade())
          wait 0.05;

        while (self isthrowinggrenade())
          wait 0.05;

        if(maps\mp\gametypes\_class::isexoxmg(self getcurrentweapon()) || maps\mp\gametypes\_class::issac3(self getcurrentweapon()))
          self laseron("mp_attachment_lasersight_short");
        else
          self laseron("mp_attachment_lasersight");

        self.laser_on = 1;
      }
    }

    if(!self.has_laser) {
      if(isdefined(self.laser_on) && self.laser_on) {
        self laseroff();
        self.laser_on = 0;
      }
    } else if(!isdefined(self.laser_on) || !self.laser_on) {
      if(maps\mp\gametypes\_class::isexoxmg(self getcurrentweapon()) || maps\mp\gametypes\_class::issac3(self getcurrentweapon()))
        self laseron("mp_attachment_lasersight_short");
      else
        self laseron("mp_attachment_lasersight");

      self.laser_on = 1;
    }

    wait 0.05;
  }
}