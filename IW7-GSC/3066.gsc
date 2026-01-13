/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3066.gsc
***********************************************/

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
    return anim.failure;
  }

  func_8987(self.var_EF73);

  if(isDefined(self.enemy)) {
    if(isDefined(self.var_3123)) {
      return anim.failure;
    }

    if(isDefined(self.var_EF79) && self.var_EF79 > 0) {
      var_1 = self.var_EF79 * self.var_EF79;
      var_2 = distancesquared(self.origin, self.enemy.origin);

      if(var_2 < var_1) {
        self.var_3123 = 1;
        return anim.failure;
      }
    }
  } else
    self.var_3123 = undefined;

  if(isDefined(self.var_EF7E)) {
    self scragentsetgoalradius(self.var_EF7E);
    var_3 = self.var_EF7E;
  } else
    var_3 = 4;

  if(isDefined(self.var_EF7D)) {
    self func_8484();
    self scragentsetgoalpos(self.var_EF7D);
  } else if(isDefined(self.var_EF7A)) {
    var_4 = distancesquared(self.origin, self.var_EF7A.origin);

    if(var_4 > var_3 * var_3) {
      self func_8484();
      self scragentsetgoalentity(self.var_EF7A);
    } else
      return anim.failure;
  } else if(isDefined(self.var_EF7C)) {
    self func_8484();
    self scragentsetgoalnode(self.var_EF7C);
  }

  return anim.success;
}

func_930A(var_0) {
  if(scripts\asm\asm_bb::bb_ismissingaleg()) {
    return anim.success;
  }

  return anim.failure;
}

func_930D(var_0) {
  if(!scripts\asm\asm_bb::bb_ismissingaleg() || !isDefined(self.enemy)) {
    return anim.failure;
  }

  var_1 = 0;

  if(scripts\asm\asm_bb::bb_moverequested()) {
    var_1 = self pathdisttogoal();
  }

  if(var_1 == 0) {
    var_1 = distance2d(self.origin, self.enemy.origin);
  }

  if(!scripts\aitypes\combat::hasammoinclip() || var_1 < self.forcefastcrawldist) {
    return anim.success;
  }

  return anim.failure;
}

func_97FA(var_0) {
  if(self.health > self.fastcrawlmaxhealth) {
    self.health = self.fastcrawlmaxhealth;
  }

  scripts\asm\asm_bb::func_2979(1);
  return anim.success;
}

func_5814() {
  playFX(level._effect["sentry_explode_mp"], self.origin);
  earthquake(0.5, 1, self.origin, 512);
  radiusdamage(self.origin, self.explosionradius, self.explosiondamagemax, self.explosiondamagemax, self, "MOD_EXPLOSIVE");
  self suicide();
}

func_5813(var_0) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  var_1 = distancesquared(self.origin, self.enemy.origin);

  if(var_1 < self.dismemberchargeexplodedistsq) {
    func_5814();
    return anim.success;
  }

  return anim.running;
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
  if(!isDefined(self.enemy)) {
    if(isDefined(self.var_6571)) {
      return anim.failure;
    }

    if(!func_9ED8()) {
      scripts\asm\asm_bb::bb_setshootparams(undefined);
      self clearpath();
    }

    return anim.failure;
  }

  var_1 = gettime();

  if(isDefined(self.var_A938)) {
    if(var_1 < self.var_A938 + 250) {
      return anim.success;
    }
  }

  self.var_A938 = var_1;

  if(isDefined(self.last_enemy_seen) && isDefined(self.enemy)) {
    if(self.last_enemy_seen != self.enemy) {
      self.last_enemy_sight_time = -99;
    }
  } else
    self.last_enemy_sight_time = -99;

  var_2 = 1;
  var_3 = self cansee(self.enemy);
  var_4 = distance2d(self.origin, self.enemy.origin);

  if(var_3) {
    var_2 = self canshoot(getdefaultenemychestpos());
  } else {
    var_2 = 0;
  }

  if(!var_2) {
    if(!scripts\engine\utility::is_true(self.var_3320)) {
      decidemovetype(0, var_4);
      self func_8484();
      self scragentsetgoalpos(self.enemy.origin);
    }

    return anim.success;
  }

  self.var_3320 = undefined;
  self.last_enemy_sight_time = gettime();
  self.last_enemy_seen = self.enemy;

  if(var_4 > self.desiredenemydistmax) {
    decidemovetype(1, var_4);
    self func_8484();
    self scragentsetgoalpos(self.enemy.origin);
    return anim.success;
  }

  if(var_4 < self.backawayenemydist) {
    var_1 = gettime();

    if(isDefined(self.var_A88C) && var_1 - self.var_A88C < 500 && isDefined(self.pathgoalpos)) {
      return anim.success;
    }

    var_5 = vectornormalize(self.origin - self.enemy.origin);
    var_6 = 100;
    var_7 = self.origin + var_5 * var_6;
    var_7 = getclosestpointonnavmesh(var_7, self);
    var_8 = var_7 - self.origin;
    var_8 = (var_8[0], var_8[1], 0);
    var_9 = vectornormalize(var_8);
    var_10 = vectordot(var_9, var_5);

    if(var_10 > 0) {
      scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
      self func_8484();
      self scragentsetgoalpos(var_7);
      return anim.success;
    }
  }

  if(var_4 < self.desiredenemydistmin) {
    if(!func_9ED8()) {
      self clearpath();
    }

    return anim.success;
  }

  return anim.success;
}

picktargetingfunction() {
  if(isDefined(self.enemy) && isDefined(self.enemy.dismember_crawl) && self.enemy.dismember_crawl) {
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
  var_0 = self.enemy gettagorigin("j_head");
  return var_0;
}

getdefaultenemychestpos() {
  if(scripts\engine\utility::is_true(self.dismember_crawl)) {
    return func_7E8E();
  }

  var_0 = 70;
  var_1 = 15;

  if(isDefined(self.enemy.var_18F4)) {
    var_0 = self.enemy.var_18F4;
    var_1 = self.enemy.var_18F9;
  }

  var_2 = var_0 * 0.75;
  var_3 = (0, 0, var_2);
  var_4 = self.enemy.origin + var_3;
  return var_4;
}

updatetarget(var_0) {
  if(!isDefined(self.var_3404)) {
    return scripts\aitypes\combat::func_12EC2(var_0);
  }

  if(isDefined(self.enemy)) {
    self.looktarget = undefined;

    if(!isDefined(self.fncustomtargetingfunc) || !isDefined(self.nexttargetchangetime) || gettime() > self.nexttargetchangetime) {
      self.fncustomtargetingfunc = picktargetingfunction();
      self.nexttargetchangetime = gettime() + randomintrange(1500, 2500);
    }

    if(isDefined(self.fncustomtargetingfunc)) {
      var_1 = self[[self.fncustomtargetingfunc]]();

      if(!self canshoot(var_1)) {
        var_1 = getdefaultenemychestpos();
      }
    } else
      var_1 = getdefaultenemychestpos();

    self.lookposition = var_1;
  } else {
    scripts\asm\asm_bb::bb_setshootparams(undefined);
    self.lookposition = undefined;
    self.nexttargetchangetime = undefined;
  }

  return anim.success;
}

func_3401(var_0) {
  if(!isDefined(self.lookposition)) {
    return scripts\aitypes\combat::func_FE88(var_0);
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("shoot", "shoot_finished")) {
    return anim.success;
  }

  var_1 = self.bt.shootparams;

  if(self cansee(self.enemy)) {
    self.looktarget = undefined;
    var_1.pos = self.lookposition;
    var_1.ent = undefined;
  } else if(isDefined(self.goodshootpos)) {
    var_1.pos = self.goodshootpos;
    var_1.ent = undefined;
  } else
    return anim.success;

  if(!isDefined(var_1.objective)) {
    var_1.objective = "normal";
  }

  scripts\asm\asm_bb::bb_setshootparams(var_1, self.enemy);

  if(scripts\aitypes\combat::isaimedataimtarget()) {
    if(!self.bt.m_bfiring) {
      scripts\aitypes\combat::resetmisstime_code();
      scripts\aitypes\combat::chooseshootstyle(var_1);
      scripts\aitypes\combat::choosenumshotsandbursts(var_1);
    }

    scripts\aitypes\combat::func_3EF8(var_1);
    self.bt.m_bfiring = 1;
  } else
    self.bt.m_bfiring = 0;

  if(!isDefined(var_1.pos) && !isDefined(var_1.ent)) {
    return anim.success;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return anim.running;
}