/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2795.gsc
***************************************/

init() {
  level._effect["slide_dust"] = loadfx("vfx\core\screen\vfx_scrnfx_tocam_slidedust_m");
  level._effect["hit_left"] = loadfx("vfx\core\screen\vfx_blood_hit_left");
  level._effect["hit_right"] = loadfx("vfx\core\screen\vfx_blood_hit_right");
  level._effect["melee_spray"] = loadfx("vfx\core\screen\vfx_melee_blood_spray");
}

shellshockondamage(var_00, var_01) {
  if(isDefined(self.flashendtime) && gettime() < self.flashendtime) {
    return;
  }
  if(var_00 == "MOD_EXPLOSIVE" || var_00 == "MOD_GRENADE" || var_00 == "MOD_GRENADE_SPLASH" || var_00 == "MOD_PROJECTILE" || var_00 == "MOD_PROJECTILE_SPLASH") {
    if(var_01 > 10) {
      if(isplayer(self) && self _meth_84CA()) {
        return;
      }
      if(isDefined(self.shellshockreduction) && self.shellshockreduction)
        self shellshock("frag_grenade_mp", self.shellshockreduction);
      else
        self shellshock("frag_grenade_mp", 0.5);
    }
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

grenade_earthquake(var_00, var_01) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_02 = undefined;

  if(!isDefined(var_01) || var_01)
    self waittill("explode", var_02);
  else
    var_02 = self.origin;

  grenade_earthquakeatposition_internal(var_02, var_00);
}

grenade_earthquakeatposition(var_00, var_01, var_02) {
  grenade_earthquakeatposition_internal(var_00, var_01, var_02);
}

grenade_earthquakeatposition_internal(var_00, var_01, var_02) {
  if(!isDefined(var_01))
    var_01 = 1;

  func_13B9("grenade_rumble", var_00, var_02);
  var_03 = 0.45 * var_01;
  var_04 = 0.7;
  var_05 = 800;
  _earthquake(var_03, var_04, var_00, var_05, var_02);
  _screenshakeonposition(var_00, 600, var_02);
}

bloodeffect(var_00) {
  self endon("disconnect");

  if(!scripts\mp\utility\game::isreallyalive(self)) {
    return;
  }
  var_01 = vectornormalize(anglesToForward(self.angles));
  var_02 = vectornormalize(anglestoright(self.angles));
  var_03 = vectornormalize(var_00 - self.origin);
  var_04 = vectordot(var_03, var_01);
  var_05 = vectordot(var_03, var_02);

  if(var_04 > 0 && var_04 > 0.5) {
    return;
  }
  if(abs(var_04) < 0.866) {
    var_06 = level._effect["hit_left"];

    if(var_05 > 0)
      var_06 = level._effect["hit_right"];

    var_07 = ["death", "damage"];
    thread play_fx_with_entity(var_06, var_07, 7.0);
  } else {}
}

func_2BC3(var_00) {
  self endon("disconnect");

  if(isDefined(var_00) && scripts\mp\utility\game::getweaponrootname(var_00) == "iw7_axe" && self getweaponammoclip(var_00) > 0) {
    if(!isDefined(self.axeswingnum))
      self.axeswingnum = 1;

    var_01 = "axe_blood_" + self.axeswingnum;
    thread activateaxeblood(var_01);
    self.axeswingnum++;

    if(self.axeswingnum > 5) {
      self.axeswingnum = 1;
      return;
    }
  } else {
    wait 0.5;
    var_02 = ["death"];
    thread play_fx_with_entity(level._effect["melee_spray"], var_02, 1.5);
  }
}

activateaxeblood(var_00) {
  self endon("disconnect");
  self setscriptablepartstate(var_00, "blood");
  wait 5;
  self setscriptablepartstate(var_00, "neutral");
}

play_fx_with_entity(var_00, var_01, var_02) {
  self endon("disconnect");
  var_03 = spawnfxforclient(var_00, self getEye(), self);
  triggerfx(var_03);
  var_03 setfxkilldefondelete();
  scripts\engine\utility::waittill_any_in_array_or_timeout(var_01, var_02);
  var_03 delete();
}

c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_00);
  playrumbleonentity("grenade_rumble", var_00);
  earthquake(0.4, 0.75, var_00, 512);

  foreach(var_02 in level.players) {
    if(var_02 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(distance(var_00, var_2.origin) > 512) {
      continue;
    }
    var_02 setclientomnvar("ui_hud_shake", 1);
  }
}

func_22FF(var_00, var_01, var_02) {
  var_03 = self.origin;
  func_13B9("artillery_rumble", var_03);

  if(!isDefined(var_00))
    var_00 = 0.7;

  if(!isDefined(var_01))
    var_01 = 0.5;

  if(!isDefined(var_02))
    var_02 = 800;

  _earthquake(var_00, var_01, var_03, var_02);
  _screenshakeonposition(var_03, var_02);
}

func_10F44(var_00) {
  playrumbleonentity("grenade_rumble", var_00);
  earthquake(1.0, 0.6, var_00, 2000);

  foreach(var_02 in level.players) {
    if(var_02 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(distance(var_00, var_2.origin) > 1000) {
      continue;
    }
    var_02 setclientomnvar("ui_hud_shake", 1);
  }
}

airstrike_earthquake(var_00) {
  func_13B9("artillery_rumble", var_00);
  _earthquake(0.5, 0.65, var_00, 1000);
  _screenshakeonposition(var_00, 900);
}

func_DAF3(var_00) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_01 = undefined;

  if(!isDefined(var_00) || var_00)
    self waittill("explode", var_01);
  else
    var_01 = self.origin;

  playrumbleonentity("grenade_rumble", var_01);
  earthquake(0.3, 0.35, var_01, 800);

  foreach(var_03 in level.players) {
    if(var_03 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(distancesquared(var_01, var_3.origin) > 90000) {
      continue;
    }
    var_03 setclientomnvar("ui_hud_shake", 1);
  }
}

func_65C4(var_00) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_01 = undefined;

  if(!isDefined(var_00) || var_00)
    self waittill("explode", var_01);
  else
    var_01 = self.origin;

  playrumbleonentity("grenade_rumble", var_01);
  earthquake(0.3, 0.35, var_01, 800);

  foreach(var_03 in level.players) {
    if(var_03 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(distancesquared(var_01, var_3.origin) > 90000) {
      continue;
    }
    var_03 setclientomnvar("ui_hud_shake", 1);
  }
}

_earthquake(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04))
    var_04 = 0;

  foreach(var_06 in level.players) {
    if(!isDefined(var_06)) {
      continue;
    }
    var_07 = scripts\mp\equipment\phase_shift::isentityphaseshifted(var_06);

    if(var_07 && var_04 || !var_07 && !var_04)
      var_06 earthquakeforplayer(var_00, var_01, var_02, var_03);
  }
}

func_13B9(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 0;

  foreach(var_04 in level.players) {
    if(!isDefined(var_04)) {
      continue;
    }
    var_05 = scripts\mp\equipment\phase_shift::isentityphaseshifted(var_04);

    if(var_05 && var_02 || !var_05 && !var_02)
      var_04 getyaw(var_00, var_01);
  }
}

_screenshakeonposition(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 0;

  var_03 = var_01 * var_01;

  foreach(var_05 in level.players) {
    if(!isDefined(var_05)) {
      continue;
    }
    if(var_05 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    var_06 = scripts\mp\equipment\phase_shift::isentityphaseshifted(var_05);

    if(var_06 && var_02 || !var_06 && !var_02) {
      if(distancesquared(var_00, var_5.origin) <= var_03)
        var_05 setclientomnvar("ui_hud_shake", 1);
    }
  }
}