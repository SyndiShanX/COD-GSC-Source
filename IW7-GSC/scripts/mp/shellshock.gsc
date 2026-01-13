/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\shellshock.gsc
*********************************************/

init() {
  level._effect["slide_dust"] = loadfx("vfx\core\screen\vfx_scrnfx_tocam_slidedust_m");
  level._effect["hit_left"] = loadfx("vfx\core\screen\vfx_blood_hit_left");
  level._effect["hit_right"] = loadfx("vfx\core\screen\vfx_blood_hit_right");
  level._effect["melee_spray"] = loadfx("vfx\core\screen\vfx_melee_blood_spray");
}

shellshockondamage(var_0, var_1) {
  if(isDefined(self.flashendtime) && gettime() < self.flashendtime) {
    return;
  }

  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(isplayer(self) && self func_84CA()) {
        return;
      }

      if(isDefined(self.shellshockreduction) && self.shellshockreduction) {
        self shellshock("frag_grenade_mp", self.shellshockreduction);
        return;
      }

      self shellshock("frag_grenade_mp", 0.5);
      return;
    }
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

grenade_earthquake(var_0, var_1) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_2 = undefined;
  if(!isDefined(var_1) || var_1) {
    self waittill("explode", var_2);
  } else {
    var_2 = self.origin;
  }

  grenade_earthquakeatposition_internal(var_2, var_0);
}

grenade_earthquakeatposition(var_0, var_1, var_2) {
  grenade_earthquakeatposition_internal(var_0, var_1, var_2);
}

grenade_earthquakeatposition_internal(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  func_13B9("grenade_rumble", var_0, var_2);
  var_3 = 0.45 * var_1;
  var_4 = 0.7;
  var_5 = 800;
  _earthquake(var_3, var_4, var_0, var_5, var_2);
  _screenshakeonposition(var_0, 600, var_2);
}

bloodeffect(var_0) {
  self endon("disconnect");
  if(!scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  if(var_4 > 0 && var_4 > 0.5) {
    return;
  }

  if(abs(var_4) < 0.866) {
    var_6 = level._effect["hit_left"];
    if(var_5 > 0) {
      var_6 = level._effect["hit_right"];
    }

    var_7 = ["death", "damage"];
    thread play_fx_with_entity(var_6, var_7, 7);
  }
}

func_2BC3(var_0) {
  self endon("disconnect");
  if(isDefined(var_0) && scripts\mp\utility::getweaponrootname(var_0) == "iw7_axe" && self getweaponammoclip(var_0) > 0) {
    if(!isDefined(self.axeswingnum)) {
      self.axeswingnum = 1;
    }

    var_1 = "axe_blood_" + self.axeswingnum;
    thread activateaxeblood(var_1);
    self.axeswingnum++;
    if(self.axeswingnum > 5) {
      self.axeswingnum = 1;
      return;
    }

    return;
  }

  wait(0.5);
  var_2 = ["death"];
  thread play_fx_with_entity(level._effect["melee_spray"], var_2, 1.5);
}

activateaxeblood(var_0) {
  self endon("disconnect");
  self setscriptablepartstate(var_0, "blood");
  wait(5);
  self setscriptablepartstate(var_0, "neutral");
}

play_fx_with_entity(var_0, var_1, var_2) {
  self endon("disconnect");
  var_3 = spawnfxforclient(var_0, self getEye(), self);
  triggerfx(var_3);
  var_3 setfxkilldefondelete();
  scripts\engine\utility::waittill_any_in_array_or_timeout(var_1, var_2);
  var_3 delete();
}

c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.75, var_0, 512);
  foreach(var_2 in level.players) {
    if(var_2 scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

func_22FF(var_0, var_1, var_2) {
  var_3 = self.origin;
  func_13B9("artillery_rumble", var_3);
  if(!isDefined(var_0)) {
    var_0 = 0.7;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  if(!isDefined(var_2)) {
    var_2 = 800;
  }

  _earthquake(var_0, var_1, var_3, var_2);
  _screenshakeonposition(var_3, var_2);
}

func_10F44(var_0) {
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(1, 0.6, var_0, 2000);
  foreach(var_2 in level.players) {
    if(var_2 scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(distance(var_0, var_2.origin) > 1000) {
      continue;
    }

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

airstrike_earthquake(var_0) {
  func_13B9("artillery_rumble", var_0);
  _earthquake(0.5, 0.65, var_0, 1000);
  _screenshakeonposition(var_0, 900);
}

func_DAF3(var_0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_1 = undefined;
  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  foreach(var_3 in level.players) {
    if(var_3 scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var_1, var_3.origin) > 90000) {
      continue;
    }

    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

func_65C4(var_0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_1 = undefined;
  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  foreach(var_3 in level.players) {
    if(var_3 scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var_1, var_3.origin) > 90000) {
      continue;
    }

    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

_earthquake(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  foreach(var_6 in level.players) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_7 = scripts\mp\equipment\phase_shift::isentityphaseshifted(var_6);
    if((var_7 && var_4) || !var_7 && !var_4) {
      var_6 earthquakeforplayer(var_0, var_1, var_2, var_3);
    }
  }
}

func_13B9(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_5 = scripts\mp\equipment\phase_shift::isentityphaseshifted(var_4);
    if((var_5 && var_2) || !var_5 && !var_2) {
      var_4 getyaw(var_0, var_1);
    }
  }
}

_screenshakeonposition(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = var_1 * var_1;
  foreach(var_5 in level.players) {
    if(!isDefined(var_5)) {
      continue;
    }

    if(var_5 scripts\mp\utility::isusingremote()) {
      continue;
    }

    var_6 = scripts\mp\equipment\phase_shift::isentityphaseshifted(var_5);
    if((var_6 && var_2) || !var_6 && !var_2) {
      if(distancesquared(var_0, var_5.origin) <= var_3) {
        var_5 setclientomnvar("ui_hud_shake", 1);
      }
    }
  }
}