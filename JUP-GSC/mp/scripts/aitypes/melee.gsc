/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\aitypes\melee.gsc
***********************************************/

#using scripts\aitypes\bt_util;
#using scripts\aitypes\combat;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace melee;

function initmeleefunctions(taskid) {
  self.meleerangesq = 6724;
  self.meleechargedistvsplayer = 100;
  self.meleeactorboundsradius = 32;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = &ismeleevalid;
  self.fncanmovefrompointtopoint = &canmovefrompointtopoint;
  return anim.success;
}

function canmovefrompointtopoint(start, end) {
  return self maymovefrompointtopoint(start, end, 0, 1);
}

function meleedeathhandler(enemy) {
  self endon("melee_finished");
  self waittill("terminate_ai_threads");
  bb_clearmeleetarget();
}

function melee_destroy() {
  self clearbtgoal(3);
  self function_bdcb37a9431e654();
}

function getmeleechargerange(target) {
  if(isPlayer(target)) {
    var_a8dde70c8a3396f3 = self.meleechargedistvsplayer;
  } else {
    var_a8dde70c8a3396f3 = self.meleechargedist;
  }

  if(!hasammoinclip()) {
    reloadmultiplier = self.meleechargedistreloadmultiplier;
    var_a8dde70c8a3396f3 *= reloadmultiplier;
  }

  return var_a8dde70c8a3396f3;
}

function gettargetchargepos(target) {
  assert(isDefined(target));
  targetpos = target.origin;
  metotarget = target.origin - self.origin;
  metotarget = vectorNormalize(metotarget);
  targetpos -= metotarget * self.meleeactorboundsradius;
  targetposdropped = getclosestpointonnavmesh(targetpos, self);

  if(abs(targetpos[2] - targetposdropped[2]) > self.maxzdiff) {
    return undefined;
  }

  traceresults = navtrace(self.origin, targetposdropped, self, 1);
  fraction = traceresults["fraction"];

  if(fraction < self.acceptablemeleefraction) {
    return undefined;
  }

  return targetposdropped;
}

function canmeleeduringstealth() {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"]) {
    if(isDefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"]) {
      return 0;
    }
  }

  return anim.success;
}

function iseitherofusalreadyinmelee(var_e37bb2c17a470a0) {
  meleetarget = self.enemy;

  if(isDefined(var_e37bb2c17a470a0)) {
    meleetarget = var_e37bb2c17a470a0;
  }

  if(self.in_melee) {
    return true;
  }

  if(meleetarget.in_melee) {
    if(!isDefined(meleetarget.meleepartner)) {
      if(isPlayer(meleetarget)) {
        meleetarget function_bdcb37a9431e654();
      } else {
        assert(isDefined(meleetarget.var_42c47bf5f8a7fdf6) || meleetarget.var_4ecd594ae357f55b || istrue(meleetarget.var_9aedaf1da799bd67), "<dev string:x1c>");
      }
    }

    if(meleetarget.in_melee) {
      return true;
    }
  }

  return false;
}

function ismeleerangevalid(target) {
  assert(isDefined(self.meleemaxzdiff));

  if(abs(target.origin[2] - self.origin[2]) > self.meleemaxzdiff) {
    return false;
  }

  chargedist = getmeleechargerange(target);
  chargedistsq = chargedist * chargedist;
  enemydistancesq = distancesquared(self.origin, target.origin);
  return enemydistancesq <= chargedistsq;
}

function ismeleevalid_common(target, var_92493ae5a92d3699) {
  if(istrue(self.dontmelee)) {
    return false;
  }

  if(!isDefined(target)) {
    return false;
  }

  if(istrue(target.dontmelee)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(!isalive(target)) {
    return false;
  }

  return true;
}

function ismeleevalid(target, var_92493ae5a92d3699) {
  if(!ismeleevalid_common(target, var_92493ae5a92d3699)) {
    return false;
  }

  if(var_92493ae5a92d3699) {
    if(isDefined(self.a.onback) || self.currentpose == "prone") {
      return false;
    }

    if(!scripts\asm\shared\utility::melee_checktimer(self.unittype, 1)) {
      return false;
    }

    if(isDefined(self.pathgoalpos) && self.facemotion && lengthsquared(self.velocity) > 1) {
      metotarget = target.origin - self.origin;
      var_e69c9108f53988f3 = length(metotarget);

      if(var_e69c9108f53988f3 > 60) {
        metotarget /= var_e69c9108f53988f3;
        lookaheadpos = self getposonpath(30);
        var_81c732b62ff30ed4 = vectorNormalize(lookaheadpos - self.origin);

        if(vectordot(var_81c732b62ff30ed4, metotarget) < -0.5) {
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

  if(istrue(target.dontattackme) || istrue(target.ignoreme) || istrue(target.dontmeleeme)) {
    return false;
  }

  if(!isai(target) && !isPlayer(target)) {
    return false;
  }

  if(isDefined(self.meleealwayswin) && isDefined(target.meleealwayswin)) {
    return false;
  }

  if(isDefined(self.meleealwayswin) && isDefined(target.magic_bullet_shield) || isDefined(target.meleealwayswin) && isDefined(self.magic_bullet_shield)) {
    return false;
  }

  var_55f3401ee64f60b1 = 0;

  if(isagent(target)) {
    if(istrue(self.bsoldier)) {
      var_55f3401ee64f60b1 = 1;
    }
  } else if(!isbot(target)) {
    var_55f3401ee64f60b1 = isai(target);
  }

  if(var_55f3401ee64f60b1) {
    if(target isinscriptedstate()) {
      return false;
    }

    if(target scripts\engine\utility::doinglongdeath() || target.delayeddeath) {
      return false;
    }

    assert(isDefined(self.stairsstate));
    assert(isDefined(target.stairsstate));

    if(self.stairsstate != "none" || target.stairsstate != "none") {
      return false;
    }

    if(target.unittype != "soldier" && target.unittype != "civilian" && target.unittype != "juggernaut") {
      return false;
    }
  }

  if(!isDefined(self.meleeignoreplayerstance) || !self.meleeignoreplayerstance || !isPlayer(target)) {
    if(isPlayer(target)) {
      enemypose = target getstance();
    } else {
      enemypose = target.currentpose;
    }

    if(enemypose != "stand" && enemypose != "crouch") {
      return false;
    }
  }

  if(isDefined(self.magic_bullet_shield) && isDefined(target.magic_bullet_shield)) {
    return false;
  }

  if(isDefined(target.grenade)) {
    return false;
  }

  if(isDefined(target.lowcovervolume) && istrue(target.underlowcover)) {
    return false;
  }

  return true;
}