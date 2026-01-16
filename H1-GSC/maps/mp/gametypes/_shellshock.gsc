/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_shellshock.gsc
*********************************************/

init() {}

shellshockondamage(var_0, var_1) {
  if(maps\mp\_flashgrenades::isflashbanged()) {
    return;
  }
  if(maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition()) {
    return;
  }
  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(!maps\mp\_utility::_hasperk("specialty_hard_shell"))
        self shellshock("frag_grenade_mp", 0.5);
    }
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

grenade_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.5, 0.75, var_0, 800);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(distancesquared(var_0, var_2.origin) > 360000) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

dirteffect(var_0) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!maps\mp\_utility::isreallyalive(self)) {
    return;
  }
  var_1 = vectornormalize(anglestoforward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["death", "damage"];

  if(var_4 > 0 && var_4 > 0.5)
    common_scripts\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
  else if(abs(var_4) < 0.866) {
    if(var_5 > 0)
      common_scripts\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
    else
      common_scripts\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
  }
}

bloodeffect(var_0) {
  self notify("bloodEffect");
  self endon("bloodEffect");
  self endon("disconnect");

  if(!maps\mp\_utility::isreallyalive(self)) {
    return;
  }
  var_1 = vectornormalize(anglestoforward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["death", "damage"];

  if(var_4 > 0 && var_4 > 0.5)
    common_scripts\utility::waittill_any_in_array_or_timeout(var_6, 7.0);
  else if(abs(var_4) < 0.866) {
    if(var_5 > 0)
      common_scripts\utility::waittill_any_in_array_or_timeout(var_6, 7.0);
    else
      common_scripts\utility::waittill_any_in_array_or_timeout(var_6, 7.0);
  }
}

bloodmeleeeffect() {
  self endon("disconnect");
  wait 0.5;

  if(isalive(self))
    common_scripts\utility::waittill_notify_or_timeout("death", 1.5);
}

c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.75, var_0, 512);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

barrel_earthquake() {
  var_0 = self.origin;
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.5, var_0, 512);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

artillery_earthquake() {
  var_0 = self.origin;
  playrumbleonposition("artillery_rumble", self.origin);
  earthquake(0.7, 0.5, self.origin, 800);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 600) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

stealthairstrike_earthquake(var_0) {
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.6, 0.6, var_0, 2000);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 1000) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

airstrike_earthquake(var_0) {
  playrumbleonposition("artillery_rumble", var_0);
  earthquake(0.7, 0.75, var_0, 1000);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 900) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}