/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\shellshock.gsc
***********************************************/

#using scripts\common\concussion_utility;
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment\flash_grenade;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\laststand;
#using scripts\mp\utility\player;
#namespace shellshock;

function init() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
  level._effect["hit_left"] = loadfx("vfx/core/screen/vfx_blood_hit_left");
  level._effect["hit_right"] = loadfx("vfx/core/screen/vfx_blood_hit_right");
  scripts\engine\utility::registersharedfunc("shellshock", "flashInterruptDelayFunc", &scripts\mp\equipment\flash_grenade::calculateinterruptdelay);
  scripts\engine\utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", &scripts\common\concussion_utility::calculateinterruptdelay);
  scripts\engine\utility::registersharedfunc("shellshock", "gasInterruptDelayFunc", &scripts\mp\equipment\gas_grenade::gas_getblurinterruptdelayms);
  scripts\engine\utility::registersharedfunc("shellshock", "lastStandInterruptDelayFunc", &scripts\mp\laststand::getshellshockinterruptdelayms);
}

function shellshockondamage(cause, damage) {
  if(isDefined(self.flashendtime) && gettime() < self.flashendtime) {
    return;
  }

  if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
    if(damage > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction) {
        _shellshock("light_damage_mp", "damage", self.shellshockreduction);
        return;
      }

      _shellshock("light_damage_mp", "damage", 0.5);
    }
  }
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function grenade_earthquake(scale, var_7bb0eac0599aa23d) {
  assertex(!isDefined(scale) || scale > 0, "<dev string:x1c>");
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(var_7bb0eac0599aa23d) || var_7bb0eac0599aa23d) {
    self waittill("explode", position);
  } else {
    position = self.origin;
  }

  grenade_earthquakeatposition_internal(position, scale);
}

function grenade_earthquakeatposition(position, scale) {
  grenade_earthquakeatposition_internal(position, scale);
}

function grenade_earthquakeatposition_internal(position, scale) {
  if(!isDefined(scale)) {
    scale = 1;
  }

  playrumbleonposition("grenade_rumble", position);
  sca = 0.45 * scale;
  dur = 0.7;
  rad = 800;
  earthquake(sca, dur, position, rad);
  _screenshakeonposition(position, 600);
}

function bloodmeleeeffect(objweapon) {
  scripts\common\shellshock_utility::bloodmeleeeffect(objweapon);
}

function c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", position);
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.4, 0.75, position, 512);
  var_99aff74b8ea85298 = utility::playersinsphere(position, 512);

  foreach(player in var_99aff74b8ea85298) {
    if(player isusingremote()) {
      continue;
    }

    player setclientomnvar("ui_hud_shake", 1);
  }
}

function artillery_earthquake(position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_a03583ed539bdb39) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  if(!isDefined(scalemax)) {
    scalemax = 0.35;
  }

  if(!isDefined(scalemid)) {
    scalemid = 0.15;
  }

  if(!isDefined(scalemin)) {
    scalemin = 0.05;
  }

  if(!isDefined(radiusmax)) {
    radiusmax = 800;
  }

  if(!isDefined(radiusmid)) {
    radiusmid = 2500;
  }

  if(!isDefined(radiusmin)) {
    radiusmin = 10000;
  }

  if(!isDefined(playrumble)) {
    playrumble = 1;
  }

  if(!isDefined(var_a03583ed539bdb39)) {
    var_a03583ed539bdb39 = 1;
  }

  function_e45e5fd94ec4af36(scalemax, scalemid, scalemin, duration, position, radiusmax, radiusmid, radiusmin);

  if(istrue(playrumble)) {
    playrumbleonposition("artillery_rumble", position);
  }

  if(istrue(var_a03583ed539bdb39)) {
    _screenshakeonposition(position, radiusmax, ignoreclients);
  }
}

function stealthairstrike_earthquake(position) {
  playrumbleonposition("grenade_rumble", position);
  earthquake(1, 0.6, position, 2000);
  var_99aff74b8ea85298 = utility::playersinsphere(position, 1000);

  foreach(player in var_99aff74b8ea85298) {
    if(player isusingremote()) {
      continue;
    }

    player setclientomnvar("ui_hud_shake", 1);
  }
}

function airstrike_earthquake(position) {
  playrumbleonposition("artillery_rumble", position);
  earthquake(0.5, 0.65, position, 1000);
  _screenshakeonposition(position, 900);
}

function pulsegrenade_earthquake(var_7bb0eac0599aa23d) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(var_7bb0eac0599aa23d) || var_7bb0eac0599aa23d) {
    self waittill("explode", position);
  } else {
    position = self.origin;
  }

  playrumbleonposition("grenade_rumble", position);
  earthquake(0.3, 0.35, position, 800);
  var_99aff74b8ea85298 = utility::playersinsphere(position, 300);

  foreach(player in var_99aff74b8ea85298) {
    if(player isusingremote()) {
      continue;
    }

    player setclientomnvar("ui_hud_shake", 1);
  }
}

function engineerdrone_earthquake(var_7bb0eac0599aa23d) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(var_7bb0eac0599aa23d) || var_7bb0eac0599aa23d) {
    self waittill("explode", position);
  } else {
    position = self.origin;
  }

  playrumbleonposition("grenade_rumble", position);
  earthquake(0.3, 0.35, position, 800);
  var_99aff74b8ea85298 = utility::playersinsphere(position, 300);

  foreach(player in var_99aff74b8ea85298) {
    if(player isusingremote()) {
      continue;
    }

    player setclientomnvar("ui_hud_shake", 1);
  }
}

function _screenshakeonposition(position, radius, ignoreclients) {
  shakeplayers = utility::playersinsphere(position, radius);

  foreach(player in shakeplayers) {
    if(isDefined(ignoreclients)) {
      if(isarray(ignoreclients)) {
        if(array_contains(ignoreclients, player)) {
          continue;
        }
      } else if(player == ignoreclients) {
        continue;
      }
    }

    if(player isusingremote()) {
      continue;
    }

    player setclientomnvar("ui_hud_shake", 1);
  }
}