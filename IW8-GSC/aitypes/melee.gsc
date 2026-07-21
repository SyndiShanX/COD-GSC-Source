/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\melee.gsc
***********************************************/

meleedeathhandler(var_0) {
  self endon("melee_finished");
  self waittill("terminate_ai_threads");
  scripts\asm\asm_bb::bb_clearmeleetarget();
}

melee_init(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.enemy;

  if(isDefined(self.melee))
    melee_destroy();

  scripts\asm\asm_bb::bb_setmeleetarget(var_1);
  self.melee.taskid = var_0;
  var_1.melee.taskid = var_0;
  scripts\asm\asm_bb::bb_clearshootparams();
  scripts\asm\asm_bb::bb_requestfire(0);
  return anim.success;
}

melee_destroy() {
  self clearbtgoal(1);

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.target))
      self.melee.target.melee = undefined;

    self.melee = undefined;
  }
}

canstealmelee(var_0) {
  if(isDefined(self.melee))
    return 0;

  if(!isDefined(self.meleecansteal) || !self.meleecansteal)
    return 0;

  if(!isDefined(var_0.melee))
    return 0;

  var_1 = var_0.melee.partner;

  if(!isDefined(var_1) || !isDefined(var_1.melee))
    return 0;

  if(isDefined(var_1.melee.bchargecomplete))
    return 0;

  var_2 = distance(var_0.origin, self.origin);
  var_3 = distance(var_0.origin, var_1.origin);

  if(var_2 + 48 > var_3)
    return 0;

  return 1;
}

ismeleeallowed(var_0) {
  var_1 = self.enemy;

  if(isDefined(var_0))
    var_1 = var_0;

  if(istrue(self.dontmelee))
    return 0;

  if(isDefined(self.bt.cannotmelee))
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(istrue(var_1.dontmelee))
    return 0;

  if(isDefined(self._stealth) && !canmeleeduringstealth())
    return 0;

  if(iseitherofusalreadyinmelee(var_1)) {
    if(!canstealmelee(var_1))
      return 0;
  }

  if(!scripts\aitypes\weapon::weaponcanmelee())
    return 0;

  return 1;
}

shouldmelee(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.enemy;

  if(!ismeleeallowed(var_1))
    return anim.failure;

  if(![[self.fnismeleevalid]](var_1, 1))
    return anim.failure;

  return anim.success;
}

initmeleeaction(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].timeout = gettime();
  self.bt.instancedata[var_0].bstarted = 0;

  if(isPlayer(self.melee.target)) {
    self.bt.instancedata[var_0].grenadeawareness = self.grenadeawareness;
    self.grenadeawareness = 0;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.melee.target);

  if(isDefined(self.fnmeleeaction_init))
    self[[self.fnmeleeaction_init]]();

  if(!isDefined(self.meleeallowoffground) && isPlayer(self.melee.target) && !self.melee.target isonground())
    self.melee.babort = 1;

  self clearpath();

  if(isai(self.melee.target))
    self.melee.target clearpath();

  var_1 = self getreacquirestate();

  if(var_1 != "disabled")
    self reacquireclear();
}

domeleeaction(var_0) {
  if(!isDefined(self.melee))
    return anim.failure;

  if(isDefined(self.melee.babort))
    return anim.failure;

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "end"))
    return anim.success;

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "begin", 0)) {
    self.bt.instancedata[var_0].bstarted = 1;
    self.bt.instancedata[var_0].timeout = gettime() + 10000;
  }

  if(!self.bt.instancedata[var_0].bstarted) {
    if(!isDefined(self.melee.target) || !isalive(self.melee.target))
      return anim.failure;
  }

  if(gettime() > self.bt.instancedata[var_0].timeout + 2000) {
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isDefined(self.melee.target) && isalive(self.melee.target) && !isPlayer(self.melee.target) && self.melee.target scripts\asm\asm_bb::bb_isanimScripted())
    return anim.failure;

  return anim.running;
}

clearmeleeaction(var_0) {
  scripts\asm\asm_bb::bb_clearmeleerequest();

  if(isDefined(self.melee) && !isDefined(self.melee.bstarted)) {
    if(isDefined(self.melee.target))
      self.melee.target.melee = undefined;

    self.melee = undefined;
  }

  if(isDefined(self.bt.instancedata[var_0].grenadeawareness))
    self.grenadeawareness = self.bt.instancedata[var_0].grenadeawareness;

  self.bt.instancedata[var_0] = undefined;
}

melee_steal(var_0) {
  if(isDefined(self.enemy) && isDefined(self.enemy.melee)) {
    if(isDefined(self.enemy.melee.partner))
      self.enemy.melee.partner melee_destroy();
    else
      self.enemy melee_destroy();
  }

  return anim.success;
}

meleevsplayer_init(var_0) {
  melee_init(var_0);

  if(isDefined(self.fnmeleevsplayer_init))
    self[[self.fnmeleevsplayer_init]](var_0);

  thread meleedeathhandler(self.enemy);
}

meleevsplayer_terminate(var_0) {
  scripts\asm\asm_bb::bb_clearmeleerequest();
  melee_destroy();

  if(isDefined(self.fnmeleevsplayer_terminate))
    self[[self.fnmeleevsplayer_terminate]](var_0);
}

meleevsplayer_update(var_0) {
  if(!isDefined(self.melee.target) || !isalive(self.melee.target))
    return anim.failure;

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "end"))
    return anim.success;

  scripts\asm\asm_bb::bb_requestmelee(self.melee.target);
  return anim.running;
}

melee_setmeleetimer(var_0, var_1) {
  if(!isDefined(anim)) {
    return;
  }
  if(!isDefined(anim.meleechargeintervals)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  if(isPlayer(self.melee.target) && isDefined(anim.meleechargeplayerintervals[self.unittype]))
    anim.meleechargeplayertimers[self.unittype] = gettime() + anim.meleechargeplayerintervals[self.unittype] * var_1;
  else if(isDefined(anim.meleechargeintervals[self.unittype]))
    anim.meleechargetimers[self.unittype] = gettime() + anim.meleechargeintervals[self.unittype] * var_1;
}

meleecharge_init(var_0) {
  self.melee.charging = 1;

  if(isDefined(self.fnmeleecharge_init))
    self[[self.fnmeleecharge_init]](var_0);

  melee_setmeleetimer(self.unittype, 3);
  var_1 = spawnStruct();
  var_1.checkpathtime = gettime() + 100;
  var_1.timeout = gettime() + 4000;
  var_1.enemystartpos = self.enemy.origin;
  self.bt.instancedata[var_0] = var_1;
  var_1.grenadeawareness = self.grenadeawareness;
  self.grenadeawareness = 0;
  self.meleeattackdist = 64;
}

meleecharge_terminate(var_0) {
  if(isDefined(self.melee))
    melee_setmeleetimer(self.unittype, 0);

  if(isDefined(self.melee) && (isDefined(self.melee.babort) || !isDefined(self.melee.bchargecomplete)))
    melee_destroy();

  self clearbtgoal(1);
  self.meleeattackdist = 0;

  if(isDefined(self.bt.instancedata[var_0].grenadeawareness))
    self.grenadeawareness = self.bt.instancedata[var_0].grenadeawareness;

  scripts\asm\asm_bb::bb_clearmeleechargerequest();

  if(isDefined(self.fnmeleecharge_terminate))
    self[[self.fnmeleecharge_terminate]](var_0);

  self.bt.instancedata[var_0] = undefined;
}

getmeleechargerange(var_0) {
  if(isPlayer(var_0))
    var_1 = self.meleechargedistvsplayer;
  else
    var_1 = self.meleechargedist;

  if(!scripts\aitypes\combat::hasammoinclip())
    var_1 = var_1 * self.meleechargedistreloadmultiplier;

  return var_1;
}

melee_shouldabort() {
  if(!isDefined(self.melee))
    return 1;

  var_0 = self.melee.target;

  if(!isDefined(var_0))
    return 1;

  if(!isalive(var_0))
    return 1;

  if(!isPlayer(var_0) && (var_0 scripts\asm\asm_bb::bb_isanimScripted() || var_0 scripts\engine\utility::doinglongdeath()))
    return 1;

  return 0;
}

meleecharge_shouldabort() {
  if(melee_shouldabort())
    return 1;

  if(isDefined(self.bt.cannotmelee))
    return 1;

  if(isDefined(self.melee.babort))
    return 1;

  var_0 = self.melee.target;

  if(!isalive(var_0))
    return 1;

  if(isDefined(var_0.offhandshield) && var_0.offhandshield.active) {
    if(isai(var_0) || !isDefined(self.meleeallowvsshieldedplayer) || !self.meleeallowvsshieldedplayer)
      return 1;
  }

  if(!isDefined(self.enemy) || var_0 != self.enemy)
    return 1;

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_charge_state", "end"))
    return 1;

  return 0;
}

meleecharge_failed_badpath(var_0) {
  self.nextmeleechecktime = gettime() + 1500;
  self.lastfailedmeleechargetarget = var_0;
}

meleecharge_justtriedthis(var_0, var_1) {
  var_2 = self.bt.instancedata[var_0].targetpos;

  if(!isDefined(var_2))
    return 0;

  if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16)
    return 0;

  return distancesquared(var_2, var_1) < 4;
}

meleecharge_update(var_0) {
  if(meleecharge_shouldabort()) {
    if(isDefined(self.melee))
      self.melee.babort = 1;

    return anim.failure;
  }

  var_1 = self.bt.instancedata[var_0];
  var_2 = gettime();
  var_3 = self.meleerangesq;

  if(!isDefined(var_3))
    var_3 = 4096;

  var_4 = self.melee.target;

  if(isDefined(self.meleeallowoffground) || isDefined(self.meleeignorefinalzdiff))
    var_5 = distance2dsquared(var_4.origin, self.origin);
  else
    var_5 = distancesquared(var_4.origin, self.origin);

  var_6 = getmeleechargerange(var_4) + 24;
  var_7 = var_6 * var_6;

  if(var_5 > var_7) {
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isPlayer(var_4))
    var_8 = getclosestpointonnavmesh(var_4.origin, self);
  else
    var_8 = var_4 getnavposition();

  var_9 = var_3;
  var_10 = length(self.velocity);

  if(var_10 > 1)
    var_9 = squared(sqrt(var_3) + var_10 * (level.frameduration / 1000));

  if(var_5 <= var_9) {
    if(isPlayer(var_4)) {
      if(var_4 scripts\common\utility::meleegrab_ksweapon_used())
        return anim.running;
    }

    var_11 = 18;

    if(isDefined(self.stairsstate) && self.stairsstate != "none" && isPlayer(var_4))
      var_11 = 32;

    if(isDefined(self.meleeignorefinalzdiff) || abs(self.origin[2] - var_4.origin[2]) < var_11) {
      var_12 = self getnavposition();

      if(self[[self.fncanmovefrompointtopoint]](var_12, var_8)) {
        self.melee.bchargecomplete = 1;
        return anim.success;
      }
    }

    if(isDefined(self.pathgoalpos) && distance2dsquared(self.origin, self.pathgoalpos) < 4) {
      meleecharge_failed_badpath(var_4);
      self.melee.babort = 1;
      return anim.failure;
    }
  }

  if(self.badpath || var_2 > var_1.checkpathtime && !isDefined(self.pathgoalpos)) {
    meleecharge_failed_badpath(var_4);
    self.melee.babort = 1;
    return anim.failure;
  }

  if(!istrue(self.melee.bignoretimeout)) {
    if(var_2 >= var_1.timeout) {
      meleecharge_failed_badpath(var_4);
      self.melee.babort = 1;
      return anim.failure;
    }
  }

  if(!istrue(self.melee.bignoretargetflee)) {
    if(isDefined(self.meleeallowoffground))
      var_13 = distance2dsquared(var_4.origin, var_1.enemystartpos);
    else
      var_13 = distancesquared(var_4.origin, var_1.enemystartpos);

    if(var_13 > 16384) {
      meleecharge_failed_badpath(var_4);
      self.melee.babort = 1;
      return anim.failure;
    }
  }

  var_14 = undefined;

  if(isDefined(self.pathgoalpos) && var_2 > var_1.checkpathtime)
    var_14 = self pathdisttogoal();

  if(isDefined(var_1.prevpathdist) && isDefined(var_14) && var_14 - var_1.prevpathdist > 72) {
    meleecharge_failed_badpath(var_4);
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isDefined(var_14))
    var_1.prevpathdist = var_14;

  var_15 = undefined;

  if(isDefined(self.pathgoalpos) && var_2 > var_1.checkpathtime)
    var_15 = self.lookaheaddir;

  if(isDefined(var_1.prevpathlookahead) && isDefined(var_15) && vectordot(var_15, var_1.prevpathlookahead) < -0.866) {
    meleecharge_failed_badpath(var_4);
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isDefined(var_15))
    var_1.prevpathlookahead = var_15;

  var_16 = max(sqrt(var_3) - 24, 0);
  var_17 = vectorNormalize(self.origin - var_4.origin);
  var_18 = scripts\engine\utility::ter_op(isPlayer(var_4) && istrue(self.meleetryhard), var_4.origin, var_4.origin + var_17 * var_16);
  var_19 = 36;

  if(isDefined(self.meleetargetallowedoffmeshdistsq))
    var_19 = self.meleetargetallowedoffmeshdistsq;

  var_20 = 0;

  if(!meleecharge_justtriedthis(var_0, var_18)) {
    var_21 = getclosestpointonnavmesh(var_18, self);
    var_20 = distance2dsquared(var_18, var_21) > var_19;

    if(!var_20)
      var_20 = !self[[self.fncanmovefrompointtopoint]](var_21, var_8);
  }

  if(var_20 && istrue(self.meleetryhard)) {
    if(isDefined(var_4.node)) {
      if(scripts\engine\utility::isnodecoverleft(var_4.node)) {
        var_22 = anglestoleft(var_4.node.angles);
        var_18 = var_4.node.origin + var_22 * var_16;
      } else if(scripts\engine\utility::isnodecoverright(var_4.node)) {
        var_23 = anglestoright(var_4.node.angles);
        var_18 = var_4.node.origin + var_23 * var_16;
      } else {
        var_24 = anglesToForward(var_4.node.angles);
        var_18 = var_4.node.origin - var_24 * var_16;
      }

      if(!meleecharge_justtriedthis(var_0, var_18)) {
        var_21 = getclosestpointonnavmesh(var_18, self);
        var_20 = distance2dsquared(var_18, var_21) > var_19;
      }
    }

    if(var_20) {
      var_18 = var_4.origin - var_17 * var_16;

      if(!meleecharge_justtriedthis(var_0, var_18)) {
        var_21 = getclosestpointonnavmesh(var_18, self);
        var_20 = distance2dsquared(var_18, var_21) > var_19;
      }
    }

    if(var_20) {
      var_18 = var_8;
      var_20 = 0;
    }
  }

  if(var_20) {
    meleecharge_failed_badpath(var_4);
    self.melee.babort = 1;
    return anim.failure;
  }

  self setbtgoalpos(1, var_18);
  self setbtgoalRadius(1, 6);
  var_1.targetpos = var_18;
  scripts\asm\asm_bb::bb_requestmeleecharge(var_4, var_18);
  return anim.running;
}

gettargetchargepos(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.origin - self.origin;
  var_2 = vectorNormalize(var_2);
  var_1 = var_1 - var_2 * self.meleeactorboundsradius;
  var_3 = getclosestpointonnavmesh(var_1, self);

  if(abs(var_1[2] - var_3[2]) > self.maxzdiff)
    return undefined;

  var_4 = navtrace(self.origin, var_3, self, 1);
  var_5 = var_4["fraction"];

  if(var_5 < self.acceptablemeleefraction)
    return undefined;

  return var_3;
}

canmeleeduringstealth() {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"]) {
    if(isDefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"])
      return 0;
  }

  return anim.success;
}

iseitherofusalreadyinmelee(var_0) {
  var_1 = self.enemy;

  if(isDefined(var_0))
    var_1 = var_0;

  if(isDefined(self.melee))
    return 1;

  if(isDefined(var_1.melee)) {
    if(!isDefined(var_1.melee.partner)) {
      if(isPlayer(var_1))
        var_1.melee = undefined;
      else {}
    }

    if(isDefined(var_1.melee))
      return 1;
  }

  return 0;
}

ismeleerangevalid(var_0) {
  if(abs(var_0.origin[2] - self.origin[2]) > self.meleemaxzdiff)
    return 0;

  var_1 = getmeleechargerange(var_0);
  var_2 = var_1 * var_1;
  var_3 = distancesquared(self.origin, var_0.origin);
  return var_3 <= var_2;
}

ismeleevalid_common(var_0, var_1) {
  if(istrue(self.dontmelee))
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(istrue(var_0.dontmelee))
    return 0;

  if(!isalive(self))
    return 0;

  if(!isalive(var_0))
    return 0;

  return 1;
}

ismeleevalid(var_0, var_1) {
  if(!ismeleevalid_common(var_0, var_1))
    return 0;

  if(var_1) {
    if(isDefined(self.a.onback) || self.currentpose == "prone")
      return 0;

    if(!scripts\asm\shared\utility::melee_checktimer(self.unittype, 1))
      return 0;

    if(isDefined(self.pathgoalpos) && self.facemotion && lengthsquared(self.velocity) > 1) {
      var_2 = var_0.origin - self.origin;
      var_3 = length(var_2);

      if(var_3 > 60) {
        var_2 = var_2 / var_3;
        var_4 = self getposonpath(30);
        var_5 = vectorNormalize(var_4 - self.origin);

        if(vectordot(var_5, var_2) < -0.5)
          return 0;
      }
    }
  }

  if(isDefined(self.grenade) && self.frontshieldanglecos == 1)
    return 0;

  if(isDefined(self.lastfailedmeleechargetarget) && self.enemy == self.lastfailedmeleechargetarget && gettime() <= self.nextmeleechecktime)
    return 0;

  if(istrue(var_0.dontattackme) || istrue(var_0.ignoreme) || istrue(var_0.dontmeleeme))
    return 0;

  if(!isai(var_0) && !isPlayer(var_0))
    return 0;

  if(isDefined(self.meleealwayswin) && isDefined(var_0.meleealwayswin))
    return 0;

  if(isDefined(self.meleealwayswin) && isDefined(var_0.magic_bullet_shield) || isDefined(var_0.meleealwayswin) && isDefined(self.magic_bullet_shield))
    return 0;

  var_6 = 0;

  if(isagent(var_0)) {
    if(istrue(self.bsoldier))
      var_6 = 1;
  } else if(!isbot(var_0))
    var_6 = isai(var_0);

  if(var_6) {
    if(var_0 isinscriptedstate())
      return 0;

    if(var_0 scripts\engine\utility::doinglongdeath() || var_0.delayeddeath)
      return 0;

    if(self.stairsstate != "none" || var_0.stairsstate != "none")
      return 0;

    if(var_0.unittype != "soldier" && var_0.unittype != "civilian" && var_0.unittype != "juggernaut")
      return 0;
  }

  if(!isDefined(self.meleeignoreplayerstance) || !self.meleeignoreplayerstance || !isPlayer(var_0)) {
    if(isPlayer(var_0))
      var_7 = var_0 getstance();
    else
      var_7 = var_0.currentpose;

    if(var_7 != "stand" && var_7 != "crouch")
      return 0;
  }

  if(isDefined(self.magic_bullet_shield) && isDefined(var_0.magic_bullet_shield))
    return 0;

  if(isDefined(var_0.grenade))
    return 0;

  if(isDefined(var_0.lowcovervolume) && isDefined(var_0.underlowcover))
    return 0;

  return 1;
}