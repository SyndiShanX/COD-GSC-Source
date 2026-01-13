/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3596.gsc
************************/

func_14FB() {
  level thread func_14FD();
}

func_14FD() {
  for(;;) {
    level waittill("player_spawned", var_0);
    if(isai(var_0)) {
      continue;
    }
  }
}

func_14FC() {}

func_14F9() {
  self.var_14F6 = 1;
  self iprintlnbold("Anti-Air Blaster");
  if(!self isonground() || self isjumping() || self iswallrunning()) {
    thread func_2B64();
  } else {
    thread func_2B62();
  }

  thread func_14FA();
  thread func_14F8();
  return 1;
}

func_2B64() {
  self endon("death");
  self endon("disconnect");
  var_0 = 262144;
  var_1 = 0;
  foreach(var_3 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_3)) {
      continue;
    }

    if(!scripts\mp\utility::isenemy(var_3)) {
      continue;
    }

    if(var_3.origin[2] > self.origin[2]) {
      continue;
    }

    var_4 = var_3.origin - self.origin;
    var_5 = length2dsquared(var_4);
    if(var_5 > var_0) {
      continue;
    }

    thread func_2B63(var_3, distance2d(var_3.origin, self.origin));
    var_1 = 1;
  }

  if(!var_1) {
    wait(0.5);
    self iprintlnbold(".No Targets.");
  }
}

func_2B62() {
  self endon("death");
  self endon("disconnect");
  var_0 = 262144;
  var_1 = 0;
  foreach(var_3 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_3)) {
      continue;
    }

    if(!scripts\mp\utility::isenemy(var_3)) {
      continue;
    }

    if(!var_3 isjumping() && !var_3 iswallrunning()) {
      continue;
    }

    if(var_3.origin[2] < self.origin[2]) {
      continue;
    }

    var_4 = var_3.origin - self.origin;
    var_5 = length2dsquared(var_4);
    if(var_5 > var_0) {
      continue;
    }

    thread func_2B63(var_3, distance2d(var_3.origin, self.origin));
    var_1 = 1;
  }

  if(!var_1) {
    wait(0.5);
    self iprintlnbold(".No Targets.");
  }
}

func_2B63(var_0, var_1) {
  self endon("death");
  var_2 = scripts\mp\utility::outlineenableforplayer(var_0, "orange", self, 0, 1, "level_script");
  var_3 = var_1 * 0.0001;
  wait(0.1 * var_3);
  if(!scripts\mp\utility::isreallyalive(var_0)) {
    return;
  }

  self earthquakeforplayer(0.2, 0.5, self.origin, 64);
  var_4 = var_0 gettagorigin("j_mainroot");
  var_5 = self gettagorigin("j_shouldertwist_le");
  var_6 = scripts\mp\utility::_magicbullet("iw7_chargeshot_mp", var_5, var_4, self);
  if(isDefined(var_0)) {
    scripts\mp\utility::outlinedisable(var_2, var_0);
  }
}

getcenterfrac() {
  var_0 = ["physicscontents_solid", "physicscontents_glass", "physicscontents_item", "physicscontents_clipshot", "physicscontents_actor", "physicscontents_playerclip", "physicscontents_fakeactor", "physicscontents_vehicle", "physicscontents_structural"];
  var_1 = physics_createcontents(var_0);
  return var_1;
}

func_14F7() {
  wait(0.5);
  if(!isDefined(self)) {
    return;
  }

  self.var_14F6 = 0;
  self setscriptablepartstate("aaGun", "aaGunOff", 0);
  self notify("aaGun_end");
}

func_14FA() {
  self endon("aaGun_end");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "game_ended");
  thread func_14F7();
}

func_9D23() {
  if(!isDefined(self.var_14F6)) {
    return 0;
  }

  return self.var_14F6;
}

func_14F8() {
  self endon("disconnect");
  self endon("aaGun_end");
  self forceplaygestureviewmodel("ges_hold");
  self setscriptablepartstate("aaGun", "aaGunOn", 0);
}