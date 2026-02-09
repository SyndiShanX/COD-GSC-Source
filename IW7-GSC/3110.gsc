/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3110.gsc
***********************************************/

func_98CB(var_0) {
  if(!isDefined(self.var_9F46)) {
    return anim.running;
  }

  self.nocorpse = 1;
  return anim.failure;
}

func_7EA9() {
  return 1000;
}

func_69F3(var_0) {
  self.var_69F5 = gettime();
  self setscriptablepartstate("beacon", "activeExplode", 0);
  self.var_2A9E = 1;
  return anim.success;
}

func_69F4(var_0) {
  if(gettime() - self.var_69F5 > func_7EA9()) {
    self notify("seeker_detonate");
    return anim.running;
  }

  return anim.running;
}

func_2A70(var_0) {
  thread func_13AEB();
  thread func_13B35();
  self notify("entering_passive_mode");
  return anim.failure;
}

func_8CA2(var_0) {
  self scragentsetgoalentity(self.owner);
  return anim.success;
}

func_8CA3(var_0) {
  if(!scripts\mp\utility::isreallyalive(self.owner)) {
    return anim.success;
  }

  var_1 = distancesquared(self.owner.origin, self.origin);

  if(var_1 <= 10000) {
    return anim.success;
  }

  return anim.running;
}

func_8CA4(var_0) {
  self clearpath();
}

func_136D0(var_0) {
  var_1 = distancesquared(self.owner.origin, self.origin);

  if(var_1 >= 40000) {
    if(!isDefined(self.var_CB49)) {
      self.var_CB49 = gettime();
    } else if(gettime() - self.var_CB49 > 100) {
      return anim.failure;
    }
  } else {
    self.var_CB49 = undefined;
  }

  return anim.running;
}

getseekenemytimeout() {
  return 1000;
}

func_2A73(var_0) {
  self.var_F109 = gettime();
  return anim.success;
}

func_2A74(var_0) {
  if(!func_9F3B()) {
    return anim.running;
  }

  return anim.success;
}

func_7E27() {
  return 1000;
}

func_3D47(var_0) {
  self.var_3D49 = gettime();
  return anim.success;
}

func_3D48(var_0) {
  self setscriptablepartstate("beacon", "activeChase", 0);

  if(!func_9F3B()) {
    if(!func_9FB2()) {
      thread scripts\mp\equipment\spider_grenade::spidergrenade_agenttoproxy(self, self.proxy);
      return anim.running;
    }

    self clearpath();
  } else if(distancesquared(self.var_F181.origin, self.origin) <= 4096) {
    self clearpath();
  } else {
    self scragentsetgoalentity(self.var_F181);
  }

  if(gettime() - self.var_3D49 > 1000) {
    return anim.success;
  }

  return anim.running;
}

func_24D6(var_0) {
  self.var_24D9 = gettime();
  self scragentsetgoalentity(self.var_F181);
  return anim.success;
}

func_24D7(var_0) {
  if(!func_9F3B()) {
    if(!func_9FB2()) {
      thread scripts\mp\equipment\spider_grenade::spidergrenade_agenttoproxy(self, self.proxy);
      return anim.running;
    }
  }

  if(distance2dsquared(self.var_F181.origin, self.origin) <= 10000) {
    if(!func_9FB2()) {
      thread scripts\mp\equipment\spider_grenade::spidergrenade_agenttoproxy(self, self.proxy);
      return anim.running;
    }
  }

  if(isDefined(self.var_24D9) && gettime() - self.var_24D9 > 2250) {
    if(!func_9FB2()) {
      thread scripts\mp\equipment\spider_grenade::spidergrenade_agenttoproxy(self, self.proxy);
      return anim.running;
    }
  }

  return anim.running;
}

func_6385(var_0) {
  self clearpath();
  self.var_F181 = undefined;
  return anim.failure;
}

func_7FDB() {
  var_0 = undefined;
  var_1 = 0;

  foreach(var_3 in level.characters) {
    var_4 = var_3;

    if(!isDefined(var_3)) {
      continue;
    }
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_3)) {
      continue;
    }
    if(isPlayer(var_3) || isagent(var_3)) {
      if(scripts\mp\utility::func_9F72(var_3)) {
        continue;
      }
      if(!scripts\mp\utility::isreallyalive(var_3)) {
        continue;
      }
      if(scripts\mp\utility::func_9F22(var_3)) {
        var_4 = self.owner;
      }
    }

    if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.owner, var_4))) {
      continue;
    }
    var_5 = distancesquared(var_3.origin, self.origin);

    if(var_5 >= 65536) {
      continue;
    }
    if(!isDefined(var_0) || var_5 < var_1) {
      var_0 = var_3;
      var_1 = var_5;
    }
  }

  return var_0;
}

func_9FB2() {
  return scripts\mp\utility::istrue(self.var_9FB2);
}

func_13AEB() {
  self endon("death");
  wait 10.0;
  func_A6CD();
}

func_13B35() {
  self endon("death");
  self.var_130F2 = spawn("script_origin", self.origin + (0, 0, 16));
  self.var_130F2.owner = self;
  self.var_130F2 thread func_4120(self);
  self.var_130F2 setcursorhint("HINT_NOICON");
  self.var_130F2 sethintstring(&"MP_PICKUP_SPIDER_GRENADE");
  self.var_130F2 scripts\mp\utility::setselfusable(self.owner);
  self.var_130F2 thread scripts\mp\utility::notusableforjoiningplayers(self.owner);
  self.var_130F2 linkto(self);

  for(;;) {
    self.var_130F2 waittill("trigger", var_0);
    self.owner playlocalsound("scavenger_pack_pickup");
    self.owner notify("scavenged_ammo", "power_spider_grenade_mp");
    func_A6CD();
  }
}

func_4120(var_0) {
  var_0 waittill("death");
  self delete();
}

func_A6CD() {
  scripts\mp\equipment\spider_grenade::func_5856(self.origin);
  self suicide();
}

func_9F3B() {
  return isDefined(self.var_F181) && scripts\mp\utility::isreallyalive(self.var_F181);
}