/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42817.gsc
**************************************/

lasersight_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.laser_on = undefined;
  self.wasemp = 0;
  self.has_laser = 0;

  for(;;) {
    while(maps\mp\_utility::isemped() && self.has_laser) {
      wait 0.05;
      self laseroff();
      self.wasemp = 1;
      continue;
    }

    if(self.wasemp && self.has_laser) {
      self.wasemp = 0;
      self laseron(get_laser_name());
    }

    if(issubstr(self getcurrentweapon(), "maaws") || issubstr(self getcurrentweapon(), "dlcgun11loot3")) {
      self.has_laser = 1;
    }

    if(self.has_laser && self isthrowinggrenade()) {
      if(isDefined(self.laser_on) && self.laser_on) {
        self laseroff();
        self.laser_on = 0;

        while(!self isusingoffhand() && self isthrowinggrenade()) {
          wait 0.05;
        }

        while(self isusingoffhand() && self isthrowinggrenade()) {
          wait 0.05;
        }

        while(self isthrowinggrenade()) {
          wait 0.05;
        }

        self laseron(get_laser_name());
        self.laser_on = 1;
      }
    }

    if(!self.has_laser) {
      if(isDefined(self.laser_on) && self.laser_on) {
        self laseroff();
        self.laser_on = 0;
      }
    } else if(!isDefined(self.laser_on) || !self.laser_on) {
      self laseron(get_laser_name());
      self.laser_on = 1;
    }

    wait 0.05;
  }
}

get_laser_name() {
  var_0 = self getcurrentweapon();

  if(issubstr(var_0, "_dlcgun10loot5") || maps\mp\gametypes\_class::isexoxmg(var_0) || maps\mp\gametypes\_class::issac3(var_0)) {
    return "mp_attachment_lasersight_short";
  }

  return "mp_attachment_lasersight";
}