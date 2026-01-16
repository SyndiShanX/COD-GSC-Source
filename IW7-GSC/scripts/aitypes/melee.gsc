/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\melee.gsc
***********************************************/

meleedeathhandler(var_0) {
  self endon("melee_finished");
  self waittill("terminate_ai_threads");
  scripts\asm\asm_bb::bb_clearmeleetarget();
}

melee_init(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.enemy;
  }

  if(isDefined(self.melee)) {
    melee_destroy();
  }

  scripts\asm\asm_bb::bb_setmeleetarget(var_1);
  self.melee.taskid = var_0;
  var_1.melee.taskid = var_0;
  return anim.success;
}

melee_destroy() {
  self func_8484();

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.target)) {
      self.melee.target.melee = undefined;
    }

    self.melee = undefined;
  }
}

func_3914(var_0) {
  if(isDefined(self.melee)) {
    return 0;
  }

  if(!isDefined(self.var_B5E4) || !self.var_B5E4) {
    return 0;
  }

  if(!isDefined(var_0.melee)) {
    return 0;
  }

  var_1 = var_0.melee.partner;

  if(!isDefined(var_1) || !isDefined(var_1.melee)) {
    return 0;
  }

  if(isDefined(var_1.melee.var_29A8)) {
    return 0;
  }

  var_2 = distance(var_0.origin, self.origin);
  var_3 = distance(var_0.origin, var_1.origin);

  if(var_2 + 48 > var_3) {
    return 0;
  }

  return 1;
}

func_9E96(var_0) {
  var_1 = self.enemy;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(isDefined(self.dontmelee)) {
    return 0;
  }

  if(isDefined(self.bt.cannotmelee)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(isDefined(var_1.dontmelee)) {
    return 0;
  }

  if(isDefined(self._stealth) && !canmeleeduringstealth()) {
    return 0;
  }

  if(func_9DD1(var_1)) {
    if(!func_3914(var_1)) {
      return 0;
    }
  }

  return 1;
}

shouldmelee(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.enemy;
  }

  if(!func_9E96(var_1)) {
    return anim.failure;
  }

  if(![[self.fnismeleevalid]](var_1, 1)) {
    return anim.failure;
  }

  if(!func_9E98(var_1)) {
    return anim.failure;
  }

  return anim.success;
}

func_9896(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].timeout = gettime();
  self.bt.instancedata[var_0].var_312F = 0;

  if(isplayer(self.melee.target)) {
    self.bt.instancedata[var_0].grenadeawareness = self.grenadeawareness;
    self.grenadeawareness = 0;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.melee.target);

  if(isDefined(self.var_71BF)) {
    self[[self.var_71BF]]();
  }

  if(!isDefined(self.var_B5DA) && isplayer(self.melee.target) && !self.melee.target isonground()) {
    self.melee.var_2720 = 1;
  }

  self clearpath();

  if(isai(self.melee.target)) {
    self.melee.target clearpath();
  }
}

func_5903(var_0) {
  if(!isDefined(self.melee)) {
    return anim.failure;
  }

  if(isDefined(self.melee.var_2720)) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "end")) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "begin", 0)) {
    self.bt.instancedata[var_0].var_312F = 1;
    self.bt.instancedata[var_0].timeout = gettime() + 10000;
  }

  if(!self.bt.instancedata[var_0].var_312F) {
    if(!isDefined(self.melee.target) || !isalive(self.melee.target)) {
      return anim.failure;
    }
  }

  if(gettime() > self.bt.instancedata[var_0].timeout + 2000) {
    self.melee.var_2720 = 1;
    return anim.failure;
  }

  if(isDefined(self.melee.target) && !isplayer(self.melee.target) && self.melee.target scripts\asm\asm_bb::bb_isanimscripted()) {
    return anim.failure;
  }

  return anim.running;
}

func_41C6(var_0) {
  scripts\asm\asm_bb::bb_clearmeleerequest();

  if(isDefined(self.melee) && !isDefined(self.melee.var_312F)) {
    if(isDefined(self.melee.target)) {
      self.melee.target.melee = undefined;
    }

    self.melee = undefined;
  }

  if(isDefined(self.bt.instancedata[var_0].grenadeawareness)) {
    self.grenadeawareness = self.bt.instancedata[var_0].grenadeawareness;
  }

  self.bt.instancedata[var_0] = undefined;
}

func_B5C3(var_0) {
  if(isDefined(self.enemy) && isDefined(self.enemy.melee)) {
    if(isDefined(self.enemy.melee.partner)) {
      self.enemy.melee.partner melee_destroy();
    } else {
      self.enemy melee_destroy();
    }
  }

  return anim.success;
}

func_B653(var_0) {
  melee_init(var_0);

  if(isDefined(self.fnmeleevsplayer_init)) {
    self[[self.fnmeleevsplayer_init]](var_0);
  }

  thread meleedeathhandler(self.enemy);
}

meleevsplayer_terminate(var_0) {
  scripts\asm\asm_bb::bb_clearmeleerequest();
  melee_destroy();

  if(isDefined(self.fnmeleevsplayer_terminate)) {
    self[[self.fnmeleevsplayer_terminate]](var_0);
  }
}

meleevsplayer_update(var_0) {
  if(!isDefined(self.melee.target) || !isalive(self.melee.target)) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "end")) {
    return anim.success;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.melee.target);
  return anim.running;
}

func_B5B4(var_0, var_1) {
  if(!isDefined(anim)) {
    return;
  }
  if(!isDefined(anim.var_B5F5)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(isplayer(self.melee.target) && isDefined(anim.var_B5F6[self.unittype])) {
    anim.var_B5F7[self.unittype] = gettime() + anim.var_B5F6[self.unittype] * var_1;
  } else if(isDefined(anim.var_B5F5[self.unittype])) {
    anim.var_B5F8[self.unittype] = gettime() + anim.var_B5F5[self.unittype] * var_1;
  }
}

func_B5E8(var_0) {
  self.melee.var_3D2C = 1;

  if(isDefined(self.fnmeleecharge_init)) {
    self[[self.fnmeleecharge_init]](var_0);
  }

  func_B5B4(self.unittype, 3);
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].var_3E30 = gettime() + 100;
  self.bt.instancedata[var_0].timeout = gettime() + 4000;
  self.bt.instancedata[var_0].var_6572 = self.enemy.origin;

  if(isplayer(self.melee.target)) {
    self.bt.instancedata[var_0].grenadeawareness = self.grenadeawareness;
    self.grenadeawareness = 0;
  }

  self.meleeattackdist = 64;
}

func_B5EE(var_0) {
  if(isDefined(self.melee)) {
    func_B5B4(self.unittype, 0);
  }

  if(isDefined(self.melee) && (isDefined(self.melee.var_2720) || !isDefined(self.melee.var_29A8))) {
    melee_destroy();
  }

  self func_8484();
  self.meleeattackdist = 0;

  if(isDefined(self.bt.instancedata[var_0].grenadeawareness)) {
    self.grenadeawareness = self.bt.instancedata[var_0].grenadeawareness;
  }

  scripts\asm\asm_bb::bb_clearmeleechargerequest();

  if(isDefined(self.fnmeleecharge_terminate)) {
    self[[self.fnmeleecharge_terminate]](var_0);
  }

  self.bt.instancedata[var_0] = undefined;
}

func_7FAB(var_0) {
  if(isplayer(var_0)) {
    var_1 = self.meleechargedistvsplayer;
  } else {
    var_1 = self.meleechargedist;
  }

  if(!scripts\aitypes\combat::hasammoinclip()) {
    var_1 = var_1 * self.meleechargedistreloadmultiplier;
  }

  return var_1;
}

melee_shouldabort() {
  if(!isDefined(self.melee)) {
    return 1;
  }

  var_0 = self.melee.target;

  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isalive(var_0)) {
    return 1;
  }

  if(!isplayer(var_0) && var_0 scripts\asm\asm_bb::bb_isanimscripted()) {
    return 1;
  }

  return 0;
}

func_B5EB() {
  if(melee_shouldabort()) {
    return 1;
  }

  if(isDefined(self.bt.cannotmelee)) {
    return 1;
  }

  if(isDefined(self.melee.var_2720)) {
    return 1;
  }

  var_0 = self.melee.target;

  if(isDefined(var_0.var_C337) && var_0.var_C337.active) {
    if(isai(var_0) || !isDefined(self.var_B5DC) || !self.var_B5DC) {
      return 1;
    }
  }

  if(isDefined(self.enemy) && var_0 != self.enemy) {
    return 1;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_charge_state", "end")) {
    return 1;
  }

  return 0;
}

func_B5E7(var_0) {
  self.var_BF90 = gettime() + 1500;
  self.var_A985 = var_0;
}

func_B5EA(var_0, var_1) {
  var_2 = self.bt.instancedata[var_0].targetpos;

  if(!isDefined(var_2)) {
    return 0;
  }

  if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16) {
    return 0;
  }

  return distancesquared(var_2, var_1) < 4;
}

func_B5F0(var_0) {
  if(func_B5EB()) {
    if(isDefined(self.melee)) {
      self.melee.var_2720 = 1;
    }

    return anim.failure;
  }

  var_1 = self.meleerangesq;

  if(!isDefined(var_1)) {
    var_1 = 4096;
  }

  var_2 = self.melee.target;

  if(isDefined(self.var_B5DA) || isDefined(self.var_B621)) {
    var_3 = distance2dsquared(var_2.origin, self.origin);
  } else {
    var_3 = distancesquared(var_2.origin, self.origin);
  }

  var_4 = func_7FAB(var_2) + 24;
  var_5 = var_4 * var_4;

  if(var_3 > var_5) {
    self.melee.var_2720 = 1;
    return anim.failure;
  }

  if(isplayer(var_2)) {
    var_6 = getclosestpointonnavmesh(var_2.origin, self);
  } else {
    var_6 = var_2 func_84AC();
  }

  var_7 = var_1;
  var_8 = length(self.velocity);

  if(var_8 > 1) {
    var_7 = squared(sqrt(var_1) + var_8 * 0.1);
  }

  if(var_3 <= var_7) {
    if(isplayer(var_2)) {
      if(scripts\engine\utility::meleegrab_ksweapon_used()) {
        return anim.running;
      }
    }

    var_9 = 18;

    if(isDefined(self.stairsstate) && self.stairsstate != "none" && isplayer(var_2)) {
      var_9 = 32;
    }

    if(isDefined(self.var_B621) || abs(self.origin[2] - var_2.origin[2]) < var_9) {
      var_10 = self func_84AC();

      if(self[[self.fncanmovefrompointtopoint]](var_10, var_6)) {
        self.melee.var_29A8 = 1;
        return anim.success;
      }
    }
  }

  if(self.badpath || gettime() > self.bt.instancedata[var_0].var_3E30 && !isDefined(self.pathgoalpos)) {
    func_B5E7(var_2);
    self.melee.var_2720 = 1;
    return anim.failure;
  }

  if(!isDefined(self.melee.var_2AC7) || !self.melee.var_2AC7) {
    if(gettime() >= self.bt.instancedata[var_0].timeout) {
      func_B5E7(var_2);
      self.melee.var_2720 = 1;
      return anim.failure;
    }
  }

  if(!isDefined(self.melee.var_2AC6) || !self.melee.var_2AC6) {
    if(isDefined(self.var_B5DA)) {
      var_11 = distance2dsquared(var_2.origin, self.bt.instancedata[var_0].var_6572);
    } else {
      var_11 = distancesquared(var_2.origin, self.bt.instancedata[var_0].var_6572);
    }

    if(var_11 > 16384) {
      func_B5E7(var_2);
      self.melee.var_2720 = 1;
      return anim.failure;
    }
  }

  var_12 = max(sqrt(var_1) - 24, 0);
  var_13 = vectornormalize(self.origin - var_2.origin);
  var_14 = var_2.origin + var_13 * var_12;
  var_15 = 36;

  if(isDefined(self.var_B64F)) {
    var_15 = self.var_B64F;
  }

  var_16 = 1;

  if(!func_B5EA(var_0, var_14)) {
    var_17 = getclosestpointonnavmesh(var_14, self);
    var_16 = distance2dsquared(var_14, var_17) > var_15;

    if(!var_16) {
      var_16 = !self[[self.fncanmovefrompointtopoint]](var_17, var_6);
    }
  }

  if(var_16 && isDefined(self.var_B651) && self.var_B651) {
    if(isDefined(var_2.node)) {
      if(scripts\engine\utility::isnodecoverleft(var_2.node)) {
        var_18 = anglestoleft(var_2.node.angles);
        var_14 = var_2.node.origin + var_18 * var_12;
      } else if(scripts\engine\utility::isnodecoverright(var_2.node)) {
        var_19 = anglestoright(var_2.node.angles);
        var_14 = var_2.node.origin + var_19 * var_12;
      } else {
        var_20 = anglesToForward(var_2.node.angles);
        var_14 = var_2.node.origin - var_20 * var_12;
      }

      if(!func_B5EA(var_0, var_14)) {
        var_17 = getclosestpointonnavmesh(var_14, self);
        var_16 = distance2dsquared(var_14, var_17) > var_15;
      }
    }

    if(var_16) {
      var_14 = var_2.origin - var_13 * var_12;

      if(!func_B5EA(var_0, var_14)) {
        var_17 = getclosestpointonnavmesh(var_14, self);
        var_16 = distance2dsquared(var_14, var_17) > var_15;
      }
    }

    if(var_16) {
      var_14 = var_6;
      var_16 = 0;
    }
  }

  if(var_16) {
    func_B5E7(var_2);
    self.melee.var_2720 = 1;
    return anim.failure;
  }

  self func_8481(var_14);
  self.btgoalradius = 6;
  self.bt.instancedata[var_0].targetpos = var_14;
  scripts\asm\asm_bb::bb_requestmeleecharge(var_2, var_14);
  return anim.running;
}

gettargetchargepos(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.origin - self.origin;
  var_2 = vectornormalize(var_2);
  var_1 = var_1 - var_2 * self.meleeactorboundsradius;
  var_3 = getclosestpointonnavmesh(var_1, self);

  if(abs(var_1[2] - var_3[2]) > self.maxzdiff) {
    return undefined;
  }

  var_4 = navtrace(self.origin, var_3, self, 1);
  var_5 = var_4["fraction"];

  if(var_5 < self.acceptablemeleefraction) {
    return undefined;
  }

  return var_3;
}

canmeleeduringstealth() {
  if(isDefined(self.var_65DB) && isDefined(self.var_65DB["_stealth_enabled"]) && self.var_65DB["_stealth_enabled"]) {
    if(isDefined(self.var_65DB["_stealth_attack"]) && !self.var_65DB["_stealth_attack"]) {
      return 0;
    }
  }

  return anim.success;
}

func_9DD1(var_0) {
  var_1 = self.enemy;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(isDefined(self.melee)) {
    return 1;
  }

  if(isDefined(var_1.melee)) {
    return 1;
  }

  return 0;
}

func_9E98(var_0) {
  if(abs(var_0.origin[2] - self.origin[2]) > self.var_B627) {
    return 0;
  }

  var_1 = func_7FAB(var_0);
  var_2 = var_1 * var_1;
  var_3 = distancesquared(self.origin, var_0.origin);
  return var_3 <= var_2;
}

ismeleevalid_common(var_0, var_1) {
  if(isDefined(self.dontmelee)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0.dontmelee)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  return 1;
}