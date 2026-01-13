/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3066.gsc
************************/

func_8987(var_0) {
  if(!isDefined(var_0) || var_0 == 0) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
    return;
  }

  if(var_0 == 1 || var_0 == 2) {
    if(self.bulletsinclip <= 0) {
      var_0 = 0;
    }
  }

  switch (var_0) {
    case 2:
      scripts\asm\asm_bb::func_295B();
      break;

    case 1:
      scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
      break;

    default:
      scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
      break;
  }
}

func_3E49(var_0) {
  if(!isDefined(self.var_EF7D) && !isDefined(self.var_EF7A) && !isDefined(self.var_EF7C)) {
    return level.failure;
  }

  func_8987(self.var_EF73);
  if(isDefined(self.isnodeoccupied)) {
    if(isDefined(self.var_3123)) {
      return level.failure;
    }

    if(isDefined(self.var_EF79) && self.var_EF79 > 0) {
      var_1 = self.var_EF79 * self.var_EF79;
      var_2 = distancesquared(self.origin, self.isnodeoccupied.origin);
      if(var_2 < var_1) {
        self.var_3123 = 1;
        return level.failure;
      }
    }
  } else {
    self.var_3123 = undefined;
  }

  if(isDefined(self.var_EF7E)) {
    self ghostskulls_total_waves(self.var_EF7E);
    var_3 = self.var_EF7E;
  } else {
    var_3 = 4;
  }

  if(isDefined(self.var_EF7D)) {
    self _meth_8484();
    self ghostskulls_complete_status(self.var_EF7D);
  } else if(isDefined(self.var_EF7A)) {
    var_4 = distancesquared(self.origin, self.var_EF7A.origin);
    if(var_4 > var_3 * var_3) {
      self _meth_8484();
      self ghosts_attack_logic(self.var_EF7A);
    } else {
      return level.failure;
    }
  } else if(isDefined(self.var_EF7C)) {
    self _meth_8484();
    self ghostshouldexplode(self.var_EF7C);
  }

  return level.success;
}

func_930A(var_0) {
  if(scripts\asm\asm_bb::bb_ismissingaleg()) {
    return level.success;
  }

  return level.failure;
}

func_930D(var_0) {
  if(!scripts\asm\asm_bb::bb_ismissingaleg() || !isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  var_1 = 0;
  if(scripts\asm\asm_bb::bb_moverequested()) {
    var_1 = self pathdisttogoal();
  }

  if(var_1 == 0) {
    var_1 = distance2d(self.origin, self.isnodeoccupied.origin);
  }

  if(!scripts\aitypes\combat::hasammoinclip() || var_1 < self.forcefastcrawldist) {
    return level.success;
  }

  return level.failure;
}

func_97FA(var_0) {
  if(self.health > self.fastcrawlmaxhealth) {
    self.health = self.fastcrawlmaxhealth;
  }

  scripts\asm\asm_bb::func_2979(1);
  return level.success;
}

func_5814() {
  playFX(level._effect["sentry_explode_mp"], self.origin);
  earthquake(0.5, 1, self.origin, 512);
  radiusdamage(self.origin, self.explosionradius, self.explosiondamagemax, self.explosiondamagemax, self, "MOD_EXPLOSIVE");
  self suicide();
}

func_5813(var_0) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  var_1 = distancesquared(self.origin, self.isnodeoccupied.origin);
  if(var_1 < self.dismemberchargeexplodedistsq) {
    func_5814();
    return level.success;
  }

  return level.running;
}

func_116F3(var_0) {
  scripts\asm\asm_bb::func_2979(0);
}

decidemovetype(var_0, var_1) {
  if(isDefined(self.var_4F63)) {
    [[self.var_4F63]](var_0, var_1);
    return;
  }

  var_2 = gettime();
  if(self.last_enemy_sight_time < 0 || var_2 - self.last_enemy_sight_time < self.maxtimetostrafewithoutlos) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
    return;
  }

  self.strafeifwithindist = self.desiredenemydistmax + 100;
  if(var_1 < self.strafeifwithindist) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
    return;
  }

  scripts\asm\asm_bb::func_295B();
}

func_9ED8() {
  return 0;
}

func_3DE6(var_0) {
  if(!isDefined(self.isnodeoccupied)) {
    if(isDefined(self.var_6571)) {
      return level.failure;
    }

    if(!func_9ED8()) {
      scripts\asm\asm_bb::bb_setshootparams(undefined);
      self clearpath();
    }

    return level.failure;
  }

  var_1 = gettime();
  if(isDefined(self.var_A938)) {
    if(var_1 < self.var_A938 + 250) {
      return level.success;
    }
  }

  self.var_A938 = var_1;
  if(isDefined(self.last_enemy_seen) && isDefined(self.isnodeoccupied)) {
    if(self.last_enemy_seen != self.isnodeoccupied) {
      self.last_enemy_sight_time = -99;
    }
  } else {
    self.last_enemy_sight_time = -99;
  }

  var_2 = 1;
  var_3 = self getpersstat(self.isnodeoccupied);
  var_4 = distance2d(self.origin, self.isnodeoccupied.origin);
  if(var_3) {
    var_2 = self canshoot(getdefaultenemychestpos());
  } else {
    var_2 = 0;
  }

  if(!var_2) {
    if(!scripts\engine\utility::istrue(self.var_3320)) {
      decidemovetype(0, var_4);
      self _meth_8484();
      self ghostskulls_complete_status(self.isnodeoccupied.origin);
    }

    return level.success;
  }

  self.var_3320 = undefined;
  self.last_enemy_sight_time = gettime();
  self.last_enemy_seen = self.isnodeoccupied;
  if(var_4 > self.desiredenemydistmax) {
    decidemovetype(1, var_4);
    self _meth_8484();
    self ghostskulls_complete_status(self.isnodeoccupied.origin);
    return level.success;
  }

  if(var_4 < self.backawayenemydist) {
    var_1 = gettime();
    if(isDefined(self.var_A88C) && var_1 - self.var_A88C < 500 && isDefined(self.vehicle_getspawnerarray)) {
      return level.success;
    }

    var_5 = vectornormalize(self.origin - self.isnodeoccupied.origin);
    var_6 = 100;
    var_7 = self.origin + var_5 * var_6;
    var_7 = getclosestpointonnavmesh(var_7, self);
    var_8 = var_7 - self.origin;
    var_8 = (var_8[0], var_8[1], 0);
    var_9 = vectornormalize(var_8);
    var_0A = vectordot(var_9, var_5);
    if(var_0A > 0) {
      scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
      self _meth_8484();
      self ghostskulls_complete_status(var_7);
      return level.success;
    }
  }

  if(var_4 < self.desiredenemydistmin) {
    if(!func_9ED8()) {
      self clearpath();
    }

    return level.success;
  }

  return level.success;
}

picktargetingfunction() {
  if(isDefined(self.isnodeoccupied) && isDefined(self.isnodeoccupied.dismember_crawl) && self.isnodeoccupied.dismember_crawl) {
    if(isDefined(self.var_3402)) {
      return self.var_3402;
    }
  }

  var_0 = 0;
  var_1 = randomint(100);
  for(var_2 = 0; var_2 < self.var_3403.size; var_2++) {
    var_3 = self.var_3403[var_2];
    if(var_1 < var_3 + var_0) {
      return self.var_3404[var_2];
    }

    var_0 = var_0 + var_3;
  }

  return undefined;
}

func_7E8E() {
  var_0 = self.isnodeoccupied gettagorigin("j_head");
  return var_0;
}

getdefaultenemychestpos() {
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return func_7E8E();
  }

  var_0 = 70;
  var_1 = 15;
  if(isDefined(self.isnodeoccupied.var_18F4)) {
    var_0 = self.isnodeoccupied.var_18F4;
    var_1 = self.isnodeoccupied.var_18F9;
  }

  var_2 = var_0 * 0.75;
  var_3 = (0, 0, var_2);
  var_4 = self.isnodeoccupied.origin + var_3;
  return var_4;
}

updatetarget(var_0) {
  if(!isDefined(self.var_3404)) {
    return scripts\aitypes\combat::func_12EC2(var_0);
  }

  if(isDefined(self.isnodeoccupied)) {
    self.doentitiessharehierarchy = undefined;
    if(!isDefined(self.fncustomtargetingfunc) || !isDefined(self.nexttargetchangetime) || gettime() > self.nexttargetchangetime) {
      self.fncustomtargetingfunc = picktargetingfunction();
      self.nexttargetchangetime = gettime() + randomintrange(1500, 2500);
    }

    if(isDefined(self.fncustomtargetingfunc)) {
      var_1 = self[[self.fncustomtargetingfunc]]();
      if(!self canshoot(var_1)) {
        var_1 = getdefaultenemychestpos();
      }
    } else {
      var_1 = getdefaultenemychestpos();
    }

    self.setplayerignoreradiusdamage = var_1;
  } else {
    scripts\asm\asm_bb::bb_setshootparams(undefined);
    self.setplayerignoreradiusdamage = undefined;
    self.nexttargetchangetime = undefined;
  }

  return level.success;
}

func_3401(var_0) {
  if(!isDefined(self.setplayerignoreradiusdamage)) {
    return scripts\aitypes\combat::func_FE88(var_0);
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("shoot", "shoot_finished")) {
    return level.success;
  }

  var_1 = self.bt.shootparams;
  if(self getpersstat(self.isnodeoccupied)) {
    self.doentitiessharehierarchy = undefined;
    var_1.pos = self.setplayerignoreradiusdamage;
    var_1.ent = undefined;
  } else if(isDefined(self.goodshootpos)) {
    var_1.pos = self.goodshootpos;
    var_1.ent = undefined;
  } else {
    return level.success;
  }

  if(!isDefined(var_1.objective)) {
    var_1.objective = "normal";
  }

  scripts\asm\asm_bb::bb_setshootparams(var_1, self.isnodeoccupied);
  if(scripts\aitypes\combat::isaimedataimtarget()) {
    if(!self.bt.m_bfiring) {
      scripts\aitypes\combat::resetmisstime_code();
      scripts\aitypes\combat::chooseshootstyle(var_1);
      scripts\aitypes\combat::choosenumshotsandbursts(var_1);
    }

    scripts\aitypes\combat::func_3EF8(var_1);
    self.bt.m_bfiring = 1;
  } else {
    self.bt.m_bfiring = 0;
  }

  if(!isDefined(var_1.pos) && !isDefined(var_1.ent)) {
    return level.success;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return level.running;
}