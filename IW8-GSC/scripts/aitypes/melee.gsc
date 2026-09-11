/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\melee.gsc
***********************************************/

function meleedeathhandler(var0) {
  self endon("melee_finished");
  self waittill("terminate_ai_threads");
  scripts\asm\asm_bb::bb_clearmeleetarget();
}

function melee_init(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self.enemy;
  }

  if(isDefined(self.melee)) {
    melee_destroy();
  }

  scripts\asm\asm_bb::bb_setmeleetarget(var1);
  self.melee.taskid = var0;
  var1.melee.taskid = var0;
  scripts\asm\asm_bb::bb_clearshootparams();
  scripts\asm\asm_bb::bb_requestfire(0);
  return anim.success;
}

function melee_destroy() {
  self clearbtgoal(1);

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.target)) {
      self.melee.target.melee = undefined;
    }

    self.melee = undefined;
    return;
  }
}

function canstealmelee(var0) {
  if(isDefined(self.melee)) {
    return false;
  }

  if(!isDefined(self.meleecansteal) || !self.meleecansteal) {
    return false;
  }

  if(!isDefined(var0.melee)) {
    return false;
  }

  var1 = var0.melee.partner;

  if(!isDefined(var1) || !isDefined(var1.melee)) {
    return false;
  }

  if(isDefined(var1.melee.bchargecomplete)) {
    return false;
  }

  var2 = distance(var0.origin, self.origin);
  var3 = distance(var0.origin, var1.origin);

  if(var2 + 48 > var3) {
    return false;
  }

  return true;
}

function ismeleeallowed(var0) {
  var1 = self.enemy;

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(istrue(self.dontmelee)) {
    return false;
  }

  if(isDefined(self.bt.cannotmelee)) {
    return false;
  }

  if(!isDefined(var1)) {
    return false;
  }

  if(istrue(var1.dontmelee)) {
    return false;
  }

  if(isDefined(self._stealth) && !canmeleeduringstealth()) {
    return false;
  }

  if(iseitherofusalreadyinmelee(var1)) {
    if(!canstealmelee(var1)) {
      return false;
    }
  }

  if(!scripts\aitypes\weapon::weaponcanmelee()) {
    return false;
  }

  return true;
}

function shouldmelee(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self.enemy;
  }

  if(!ismeleeallowed(var1)) {
    return anim.failure;
  }

  if(![[self.fnismeleevalid]](var1, 1)) {
    return anim.failure;
  }

  return anim.success;
}

function initmeleeaction(var0) {
  self.bt.instancedata[var0] = spawnStruct();
  self.bt.instancedata[var0].timeout = gettime();
  self.bt.instancedata[var0].bstarted = 0;

  if(isPlayer(self.melee.target)) {
    self.bt.instancedata[var0].grenadeawareness = self.grenadeawareness;
    self.grenadeawareness = 0;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.melee.target);

  if(isDefined(self.fnmeleeaction_init)) {
    self[[self.fnmeleeaction_init]]();
  }

  if(!isDefined(self.meleeallowoffground) && isPlayer(self.melee.target) && !self.melee.target isonground()) {
    self.melee.babort = 1;
  }

  self clearpath();

  if(isai(self.melee.target)) {
    self.melee.target clearpath();
  }

  var1 = self getreacquirestate();

  if(var1 != "disabled") {
    self reacquireclear();
    return;
  }
}

function domeleeaction(var0) {
  if(!isDefined(self.melee)) {
    return anim.failure;
  }

  if(isDefined(self.melee.babort)) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "end")) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "begin", 0)) {
    self.bt.instancedata[var0].bstarted = 1;
    self.bt.instancedata[var0].timeout = gettime() + 10000;
  }

  if(!self.bt.instancedata[var0].bstarted) {
    if(!isDefined(self.melee.target) || !isalive(self.melee.target)) {
      return anim.failure;
    }
  }

  if(gettime() > self.bt.instancedata[var0].timeout + 2000) {
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isDefined(self.melee.target) && isalive(self.melee.target) && !isPlayer(self.melee.target) && self.melee.target scripts\asm\asm_bb::bb_isanimScripted()) {
    return anim.failure;
  }

  return anim.running;
}

function clearmeleeaction(var0) {
  scripts\asm\asm_bb::bb_clearmeleerequest();

  if(isDefined(self.melee) && !isDefined(self.melee.bstarted)) {
    if(isDefined(self.melee.target)) {
      self.melee.target.melee = undefined;
    }

    self.melee = undefined;
  }

  if(isDefined(self.bt.instancedata[var0].grenadeawareness)) {
    self.grenadeawareness = self.bt.instancedata[var0].grenadeawareness;
  }

  self.bt.instancedata[var0] = undefined;
}

function melee_steal(var0) {
  if(isDefined(self.enemy) && isDefined(self.enemy.melee)) {
    if(isDefined(self.enemy.melee.partner)) {
      melee_destroy(self.enemy.melee.partner);
    } else {
      melee_destroy(self.enemy);
    }
  }

  return anim.success;
}

function meleevsplayer_init(var0) {
  melee_init(var0);

  if(isDefined(self.fnmeleevsplayer_init)) {
    self[[self.fnmeleevsplayer_init]](var0);
  }

  thread meleedeathhandler(self.enemy);
}

function meleevsplayer_terminate(var0) {
  scripts\asm\asm_bb::bb_clearmeleerequest();
  melee_destroy();

  if(isDefined(self.fnmeleevsplayer_terminate)) {
    self[[self.fnmeleevsplayer_terminate]](var0);
    return;
  }
}

function meleevsplayer_update(var0) {
  if(!isDefined(self.melee.target) || !isalive(self.melee.target)) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_attack", "end")) {
    return anim.success;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.melee.target);
  return anim.running;
}

function melee_setmeleetimer(var0, var1) {
  if(!isDefined(anim)) {
    return;
  }

  if(!isDefined(anim.meleechargeintervals)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(isPlayer(self.melee.target) && isDefined(anim.meleechargeplayerintervals[self.unittype])) {
    anim.meleechargeplayertimers[self.unittype] = gettime() + anim.meleechargeplayerintervals[self.unittype] * var1;
    return;
  }

  if(isDefined(anim.meleechargeintervals[self.unittype])) {
    anim.meleechargetimers[self.unittype] = gettime() + anim.meleechargeintervals[self.unittype] * var1;
    return;
  }
}

function meleecharge_init(var0) {
  self.melee.charging = 1;

  if(isDefined(self.fnmeleecharge_init)) {
    self[[self.fnmeleecharge_init]](var0);
  }

  melee_setmeleetimer(self.unittype, 3);
  var1 = spawnStruct();
  var1.checkpathtime = gettime() + 100;
  var1.timeout = gettime() + 4000;
  var1.enemystartpos = self.enemy.origin;
  self.bt.instancedata[var0] = var1;
  var1.grenadeawareness = self.grenadeawareness;
  self.grenadeawareness = 0;
  self.meleeattackdist = 64;
}

function meleecharge_terminate(var0) {
  if(isDefined(self.melee)) {
    melee_setmeleetimer(self.unittype, 0);
  }

  if(isDefined(self.melee) && (isDefined(self.melee.babort) || !isDefined(self.melee.bchargecomplete))) {
    melee_destroy();
  }

  self clearbtgoal(1);
  self.meleeattackdist = 0;

  if(isDefined(self.bt.instancedata[var0].grenadeawareness)) {
    self.grenadeawareness = self.bt.instancedata[var0].grenadeawareness;
  }

  scripts\asm\asm_bb::bb_clearmeleechargerequest();

  if(isDefined(self.fnmeleecharge_terminate)) {
    self[[self.fnmeleecharge_terminate]](var0);
  }

  self.bt.instancedata[var0] = undefined;
}

function getmeleechargerange(var0) {
  if(isPlayer(var0)) {
    var1 = self.meleechargedistvsplayer;
  } else {
    var1 = self.meleechargedist;
  }

  if(!scripts\aitypes\combat::hasammoinclip()) {
    var1 *= self.meleechargedistreloadmultiplier;
  }

  return var1;
}

function melee_shouldabort() {
  if(!isDefined(self.melee)) {
    return true;
  }

  var0 = self.melee.target;

  if(!isDefined(var0)) {
    return true;
  }

  if(!isalive(var0)) {
    return true;
  }

  if(!isPlayer(var0) && (var0 scripts\asm\asm_bb::bb_isanimScripted() || var0 scripts\engine\utility::doinglongdeath())) {
    return true;
  }

  return false;
}

function meleecharge_shouldabort() {
  if(melee_shouldabort()) {
    return true;
  }

  if(isDefined(self.bt.cannotmelee)) {
    return true;
  }

  if(isDefined(self.melee.babort)) {
    return true;
  }

  var0 = self.melee.target;

  if(!isalive(var0)) {
    return true;
  }

  if(isDefined(var0.offhandshield) && var0.offhandshield.active) {
    if(isai(var0) || !isDefined(self.meleeallowvsshieldedplayer) || !self.meleeallowvsshieldedplayer) {
      return true;
    }
  }

  if(!isDefined(self.enemy) || var0 != self.enemy) {
    return true;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_charge_state", "end")) {
    return true;
  }

  return false;
}

function meleecharge_failed_badpath(var0) {
  self.nextmeleechecktime = gettime() + 1500;
  self.lastfailedmeleechargetarget = var0;
}

function meleecharge_justtriedthis(var0, var1) {
  var2 = self.bt.instancedata[var0].targetpos;

  if(!isDefined(var2)) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16) {
    return false;
  }

  return distancesquared(var2, var1) < 4;
}

function meleecharge_update(var0) {
  if(meleecharge_shouldabort()) {
    if(isDefined(self.melee)) {
      self.melee.babort = 1;
    }

    return anim.failure;
  }

  var1 = self.bt.instancedata[var0];
  var2 = gettime();
  var3 = self.meleerangesq;

  if(!isDefined(var3)) {
    var3 = 4096;
  }

  var4 = self.melee.target;

  if(isDefined(self.meleeallowoffground) || isDefined(self.meleeignorefinalzdiff)) {
    var5 = distance2dsquared(var4.origin, self.origin);
  } else {
    var5 = distancesquared(var5.origin, self.origin);
  }

  var6 = getmeleechargerange(var5) + 24;
  var7 = var6 * var6;

  if(var5 > var7) {
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isPlayer(var5)) {
    var8 = getclosestpointonnavmesh(var5.origin, self);
  } else {
    var8 = var5 getnavposition();
  }

  var9 = var5;
  var10 = length(self.velocity);

  if(var10 > 1) {
    var9 = squared(sqrt(var5) + var10 * level.frameduration / 1000);
  }

  if(var6 <= var9) {
    if(isPlayer(var5)) {
      if(var5 scripts\common\utility::meleegrab_ksweapon_used()) {
        return anim.running;
      }
    }

    var11 = 18;

    if(isDefined(self.stairsstate) && self.stairsstate != "none" && isPlayer(var5)) {
      var11 = 32;
    }

    if(isDefined(self.meleeignorefinalzdiff) || abs(self.origin[2] - var5.origin[2]) < var11) {
      var12 = self getnavposition();

      if(self[[self.fncanmovefrompointtopoint]](var12, var8)) {
        self.melee.bchargecomplete = 1;
        return anim.success;
      }
    }

    if(isDefined(self.pathgoalpos) && distance2dsquared(self.origin, self.pathgoalpos) < 4) {
      meleecharge_failed_badpath(var5);
      self.melee.babort = 1;
      return anim.failure;
    }
  }

  if(self.badpath || var4 > var3.checkpathtime && !isDefined(self.pathgoalpos)) {
    meleecharge_failed_badpath(var5);
    self.melee.babort = 1;
    return anim.failure;
  }

  if(!istrue(self.melee.bignoretimeout)) {
    if(var4 >= var3.timeout) {
      meleecharge_failed_badpath(var5);
      self.melee.babort = 1;
      return anim.failure;
    }
  }

  if(!istrue(self.melee.bignoretargetflee)) {
    if(isDefined(self.meleeallowoffground)) {
      var13 = distance2dsquared(var5.origin, var3.enemystartpos);
    } else {
      var13 = distancesquared(var6.origin, var4.enemystartpos);
    }

    if(var13 > 16384) {
      meleecharge_failed_badpath(var6);
      self.melee.babort = 1;
      return anim.failure;
    }
  }

  var14 = undefined;

  if(isDefined(self.pathgoalpos) && var5 > var4.checkpathtime) {
    var14 = self pathdisttogoal();
  }

  if(isDefined(var4.prevpathdist) && isDefined(var14) && var14 - var4.prevpathdist > 72) {
    meleecharge_failed_badpath(var6);
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isDefined(var14)) {
    var4.prevpathdist = var14;
  }

  var15 = undefined;

  if(isDefined(self.pathgoalpos) && var5 > var4.checkpathtime) {
    var15 = self.lookaheaddir;
  }

  if(isDefined(var4.prevpathlookahead) && isDefined(var15) && vectordot(var15, var4.prevpathlookahead) < -0.866) {
    meleecharge_failed_badpath(var6);
    self.melee.babort = 1;
    return anim.failure;
  }

  if(isDefined(var15)) {
    var4.prevpathlookahead = var15;
  }

  var16 = max(sqrt(var5) - 24, 0);
  var17 = vectorNormalize(self.origin - var6.origin);
  var18 = scripts\engine\utility::ter_op(isPlayer(var6) && istrue(self.meleetryhard), var6.origin, var6.origin + var17 * var16);
  var19 = 36;

  if(isDefined(self.meleetargetallowedoffmeshdistsq)) {
    var19 = self.meleetargetallowedoffmeshdistsq;
  }

  var20 = 0;

  if(!meleecharge_justtriedthis(var3, var18)) {
    var21 = getclosestpointonnavmesh(var18, self);
    var20 = distance2dsquared(var18, var21) > var19;

    if(!var20) {
      var20 = !self[[self.fncanmovefrompointtopoint]](var21, var9);
    }
  }

  if(var20 && istrue(self.meleetryhard)) {
    if(isDefined(var6.node)) {
      if(scripts\engine\utility::isnodecoverleft(var6.node)) {
        var22 = anglestoleft(var6.node.angles);
        var18 = var6.node.origin + var22 * var16;
      } else if(scripts\engine\utility::isnodecoverright(var6.node)) {
        var23 = anglestoright(var6.node.angles);
        var18 = var6.node.origin + var23 * var16;
      } else {
        var24 = anglesToForward(var6.node.angles);
        var18 = var6.node.origin - var24 * var16;
      }

      if(!meleecharge_justtriedthis(var3, var18)) {
        var21 = getclosestpointonnavmesh(var18, self);
        var20 = distance2dsquared(var18, var21) > var19;
      }
    }

    if(var20) {
      var18 = var6.origin - var17 * var16;

      if(!meleecharge_justtriedthis(var3, var18)) {
        var21 = getclosestpointonnavmesh(var18, self);
        var20 = distance2dsquared(var18, var21) > var19;
      }
    }

    if(var20) {
      var18 = var9;
      var20 = 0;
    }
  }

  if(var20) {
    meleecharge_failed_badpath(var6);
    self.melee.babort = 1;
    return anim.failure;
  }

  self setbtgoalpos(1, var18);
  self setbtgoalRadius(1, 6);
  var4.targetpos = var18;
  scripts\asm\asm_bb::bb_requestmeleecharge(var6, var18);
  return anim.running;
}

function gettargetchargepos(var0) {
  var1 = var0.origin;
  var2 = var0.origin - self.origin;
  var2 = vectorNormalize(var2);
  var1 -= var2 * self.meleeactorboundsradius;
  var3 = getclosestpointonnavmesh(var1, self);

  if(abs(var1[2] - var3[2]) > self.maxzdiff) {
    return undefined;
  }

  var4 = navtrace(self.origin, var3, self, 1);
  var5 = var4["fraction"];

  if(var5 < self.acceptablemeleefraction) {
    return undefined;
  }

  return var3;
}

function canmeleeduringstealth() {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"]) {
    if(isDefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"]) {
      return 0;
    }
  }

  return anim.success;
}

function iseitherofusalreadyinmelee(var0) {
  var1 = self.enemy;

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(isDefined(self.melee)) {
    return true;
  }

  if(isDefined(var1.melee)) {
    if(!isDefined(var1.melee.partner)) {
      if(isPlayer(var1)) {
        var1.melee = undefined;
      }
    }

    if(isDefined(var1.melee)) {
      return true;
    }
  }

  return false;
}

function ismeleerangevalid(var0) {
  if(abs(var0.origin[2] - self.origin[2]) > self.meleemaxzdiff) {
    return false;
  }

  var1 = getmeleechargerange(var0);
  var2 = var1 * var1;
  var3 = distancesquared(self.origin, var0.origin);
  return var3 <= var2;
}

function ismeleevalid_common(var0, var1) {
  if(istrue(self.dontmelee)) {
    return false;
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(istrue(var0.dontmelee)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(!isalive(var0)) {
    return false;
  }

  return true;
}

function ismeleevalid(var0, var1) {
  if(!ismeleevalid_common(var0, var1)) {
    return false;
  }

  if(var1) {
    if(isDefined(self.a.onback) || self.currentpose == "prone") {
      return false;
    }

    if(!scripts\asm\shared\utility::melee_checktimer(self.unittype, 1)) {
      return false;
    }

    if(isDefined(self.pathgoalpos) && self.facemotion && lengthsquared(self.velocity) > 1) {
      var2 = var0.origin - self.origin;
      var3 = length(var2);

      if(var3 > 60) {
        var2 /= var3;
        var4 = self getposonpath(30);
        var5 = vectorNormalize(var4 - self.origin);

        if(vectordot(var5, var2) < -0.5) {
          return false;
        }
      }
    }
  }

  if(isDefined(self.grenade) && self.frontshieldanglecos == 1) {
    return false;
  }

  if(isDefined(self.lastfailedmeleechargetarget) && self.enemy == self.lastfailedmeleechargetarget && gettime() <= self.nextmeleechecktime) {
    return false;
  }

  if(istrue(var0.dontattackme) || istrue(var0.ignoreme) || istrue(var0.dontmeleeme)) {
    return false;
  }

  if(!isai(var0) && !isPlayer(var0)) {
    return false;
  }

  if(isDefined(self.meleealwayswin) && isDefined(var0.meleealwayswin)) {
    return false;
  }

  if(isDefined(self.meleealwayswin) && isDefined(var0.magic_bullet_shield) || isDefined(var0.meleealwayswin) && isDefined(self.magic_bullet_shield)) {
    return false;
  }

  var6 = 0;

  if(isagent(var0)) {
    if(istrue(self.bsoldier)) {
      var6 = 1;
    }
  } else if(!isbot(var0)) {
    var6 = isai(var0);
  }

  if(var6) {
    if(var0 isinscriptedstate()) {
      return false;
    }

    if(var0 scripts\engine\utility::doinglongdeath() || var0.delayeddeath) {
      return false;
    }

    if(self.stairsstate != "none" || var0.stairsstate != "none") {
      return false;
    }

    if(var0.unittype != "soldier" && var0.unittype != "civilian" && var0.unittype != "juggernaut") {
      return false;
    }
  }

  if(!isDefined(self.meleeignoreplayerstance) || !self.meleeignoreplayerstance || !isPlayer(var0)) {
    if(isPlayer(var0)) {
      var7 = var0 getstance();
    } else {
      var7 = var1.currentpose;
    }

    if(var7 != "stand" && var7 != "crouch") {
      return false;
    }
  }

  if(isDefined(self.magic_bullet_shield) && isDefined(var1.magic_bullet_shield)) {
    return false;
  }

  if(isDefined(var1.grenade)) {
    return false;
  }

  if(isDefined(var1.lowcovervolume) && isDefined(var1.underlowcover)) {
    return false;
  }

  return true;
}