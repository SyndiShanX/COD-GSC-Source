/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\melee.gsc
***********************************************/

initmeleefunctions(taskid) {
  self.meleerangesq = 6724;
  self.meleechargedistvsplayer = 100;
  self.meleeactorboundsradius = 32;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = ::ismeleevalid;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return anim.success;
}

canmovefrompointtopoint(start, end) {
  return self maymovefrompointtopoint(start, end, 0, 1);
}

meleedeathhandler(enemy) {
  self endon("melee_finished");
  self waittill("terminate_ai_threads");
  scripts\asm\asm_bb::bb_clearmeleetarget();
}

melee_destroy() {
  self clearbtgoal(3);
  self _meth_0BDCB37A9431E654();
}

getmeleechargerange(target) {
  if(isPlayer(target))
    _id_A8DDE70C8A3396F3 = self.meleechargedistvsplayer;
  else
    _id_A8DDE70C8A3396F3 = self.meleechargedist;

  if(!scripts\aitypes\combat::hasammoinclip()) {
    _id_0126639EA8D4D57F = self.meleechargedistreloadmultiplier;
    _id_A8DDE70C8A3396F3 = _id_A8DDE70C8A3396F3 * _id_0126639EA8D4D57F;
  }

  return _id_A8DDE70C8A3396F3;
}

gettargetchargepos(target) {
  targetpos = target.origin;
  _id_6A4277FF9E64049F = target.origin - self.origin;
  _id_6A4277FF9E64049F = vectorNormalize(_id_6A4277FF9E64049F);
  targetpos = targetpos - _id_6A4277FF9E64049F * self.meleeactorboundsradius;
  _id_625CDB6DDFEBBEF0 = getclosestpointonnavmesh(targetpos, self);

  if(abs(targetpos[2] - _id_625CDB6DDFEBBEF0[2]) > self.maxzdiff)
    return undefined;

  traceresults = navtrace(self.origin, _id_625CDB6DDFEBBEF0, self, 1);
  fraction = traceresults["fraction"];

  if(fraction < self.acceptablemeleefraction)
    return undefined;

  return _id_625CDB6DDFEBBEF0;
}

canmeleeduringstealth() {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"]) {
    if(isDefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"])
      return 0;
  }

  return anim.success;
}

iseitherofusalreadyinmelee(_id_0E37BB2C17A470A0) {
  _id_9BFC452192B23C7A = self.enemy;

  if(isDefined(_id_0E37BB2C17A470A0))
    _id_9BFC452192B23C7A = _id_0E37BB2C17A470A0;

  if(self._id_A97AC004F00C5DF9)
    return 1;

  if(_id_9BFC452192B23C7A._id_A97AC004F00C5DF9) {
    if(!isDefined(_id_9BFC452192B23C7A._id_68D2F73EE95055FB)) {
      if(isPlayer(_id_9BFC452192B23C7A))
        _id_9BFC452192B23C7A _meth_0BDCB37A9431E654();
      else {}
    }

    if(_id_9BFC452192B23C7A._id_A97AC004F00C5DF9)
      return 1;
  }

  return 0;
}

ismeleerangevalid(target) {
  if(abs(target.origin[2] - self.origin[2]) > self.meleemaxzdiff)
    return 0;

  _id_DA0F4D34E5114A91 = getmeleechargerange(target);
  _id_FB2FA63A4FE6E2B5 = _id_DA0F4D34E5114A91 * _id_DA0F4D34E5114A91;
  _id_A78370195E768E30 = distancesquared(self.origin, target.origin);
  return _id_A78370195E768E30 <= _id_FB2FA63A4FE6E2B5;
}

ismeleevalid_common(target, _id_92493AE5A92D3699) {
  if(istrue(self.dontmelee))
    return 0;

  if(!isDefined(target))
    return 0;

  if(istrue(target.dontmelee))
    return 0;

  if(!isalive(self))
    return 0;

  if(!isalive(target))
    return 0;

  return 1;
}

ismeleevalid(target, _id_92493AE5A92D3699) {
  if(!ismeleevalid_common(target, _id_92493AE5A92D3699))
    return 0;

  if(_id_92493AE5A92D3699) {
    if(isDefined(self.a.onback) || self.currentpose == "prone")
      return 0;

    if(!scripts\asm\shared\utility::melee_checktimer(self.unittype, 1))
      return 0;

    if(isDefined(self.pathgoalpos) && self.facemotion && lengthsquared(self.velocity) > 1) {
      _id_6A4277FF9E64049F = target.origin - self.origin;
      _id_E69C9108F53988F3 = length(_id_6A4277FF9E64049F);

      if(_id_E69C9108F53988F3 > 60) {
        _id_6A4277FF9E64049F = _id_6A4277FF9E64049F / _id_E69C9108F53988F3;
        _id_634E3D3B8E9B952F = self getposonpath(30);
        _id_81C732B62FF30ED4 = vectorNormalize(_id_634E3D3B8E9B952F - self.origin);

        if(vectordot(_id_81C732B62FF30ED4, _id_6A4277FF9E64049F) < -0.5)
          return 0;
      }
    }
  }

  if(isDefined(self.grenade) && self.frontshieldanglecos == 1)
    return 0;

  if(isDefined(self.lastfailedmeleechargetarget) && self.enemy == self.lastfailedmeleechargetarget && gettime() <= self.nextmeleechecktime)
    return 0;

  if(istrue(target.dontattackme) || istrue(target.ignoreme) || istrue(target.dontmeleeme))
    return 0;

  if(!isai(target) && !isPlayer(target))
    return 0;

  if(isDefined(self.meleealwayswin) && isDefined(target.meleealwayswin))
    return 0;

  if(isDefined(self.meleealwayswin) && isDefined(target.magic_bullet_shield) || isDefined(target.meleealwayswin) && isDefined(self.magic_bullet_shield))
    return 0;

  _id_55F3401EE64F60B1 = 0;

  if(isagent(target)) {
    if(istrue(self.bsoldier))
      _id_55F3401EE64F60B1 = 1;
  } else if(!isbot(target))
    _id_55F3401EE64F60B1 = isai(target);

  if(_id_55F3401EE64F60B1) {
    if(target isinscriptedstate())
      return 0;

    if(target scripts\engine\utility::doinglongdeath() || target.delayeddeath)
      return 0;

    if(self.stairsstate != "none" || target.stairsstate != "none")
      return 0;

    if(target.unittype != "soldier" && target.unittype != "civilian" && target.unittype != "juggernaut")
      return 0;
  }

  if(!isDefined(self.meleeignoreplayerstance) || !self.meleeignoreplayerstance || !isPlayer(target)) {
    if(isPlayer(target))
      _id_4A72F9EA547E267E = target getstance();
    else
      _id_4A72F9EA547E267E = target.currentpose;

    if(_id_4A72F9EA547E267E != "stand" && _id_4A72F9EA547E267E != "crouch")
      return 0;
  }

  if(isDefined(self.magic_bullet_shield) && isDefined(target.magic_bullet_shield))
    return 0;

  if(isDefined(target.grenade))
    return 0;

  if(isDefined(target.lowcovervolume) && istrue(target.underlowcover))
    return 0;

  return 1;
}