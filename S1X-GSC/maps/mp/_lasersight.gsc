/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_lasersight.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

lasersight_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self.laser_on = undefined;
  self.wasEMP = false;

  while(true) {
    has_laser = false;

    attachment_list = GetWeaponAttachments(self GetCurrentWeapon());

    if(isDefined(attachment_list)) {
      foreach(attachment in attachment_list) {
        if(attachment == "lasersight") {
          has_laser = true;
          break;
        }
      }
    }

    while(self isEMPed() && has_laser) {
      wait(0.05);
      self LaserOff();
      self.wasEMP = true;
      continue;
    }
    if(self.wasEMP && has_laser) {
      self.wasEMP = false;
      if(self maps\mp\gametypes\_class::isExoXMG(self GetCurrentWeapon()) || self maps\mp\gametypes\_class::isSac3(self GetCurrentWeapon())) {
        self LaserOn("mp_attachment_lasersight_short");
      } else {
        self LaserOn("mp_attachment_lasersight");
      }
    }

    if(IsSubStr(self GetCurrentWeapon(), "maaws")) {
      has_laser = true;
    }

    if(has_laser && self IsThrowingGrenade()) {
      if(isDefined(self.laser_on) && self.laser_on) {
        self LaserOff();
        self.laser_on = false;

        while(!self IsUsingOffhand() && self IsThrowingGrenade()) {
          wait(0.05);
        }

        while(self IsUsingOffhand() && self IsThrowingGrenade()) {
          wait(0.05);
        }

        while(self IsThrowingGrenade()) {
          wait(0.05);
        }

        if(self maps\mp\gametypes\_class::isExoXMG(self GetCurrentWeapon()) || self maps\mp\gametypes\_class::isSac3(self GetCurrentWeapon())) {
          self LaserOn("mp_attachment_lasersight_short");
        } else {
          self LaserOn("mp_attachment_lasersight");
        }

        self.laser_on = true;
      }
    }

    if(!has_laser) {
      if(isDefined(self.laser_on) && self.laser_on) {
        self LaserOff();
        self.laser_on = false;
      }
    } else {
      if(!isDefined(self.laser_on) || !self.laser_on) {
        if(self maps\mp\gametypes\_class::isExoXMG(self GetCurrentWeapon()) || self maps\mp\gametypes\_class::isSac3(self GetCurrentWeapon())) {
          self LaserOn("mp_attachment_lasersight_short");
        } else {
          self LaserOn("mp_attachment_lasersight");
        }

        self.laser_on = true;
      }
    }

    wait(0.05);
  }
}