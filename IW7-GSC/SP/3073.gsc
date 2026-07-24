/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3073.gsc
**************************************/

_id_346D(var_0) {
  self.combatmode = "no_cover";
  self clearpath();
  self.dontmelee = undefined;
  self._id_596E = 1;
  self.allowpain = 0;
  self.grenadeawareness = 0;
  self._id_B781 = 200;
  self.pathenemylookahead = 24;
  self.pathenemyfightdist = 24;
  var_1 = gettime();
  self._id_FCA2 = var_1 + randomintrange(8000, 12000);
  self._id_BF80 = var_1 + randomintrange(15000, 17000);

  if(!isDefined(self._id_290A)) {
    self._id_290A = 1;
  }

  self._id_3138 = 0;
  self._id_10E67 = 128;
  self._id_10E68 = 16;
  _id_0A15::setupdestructibledoors();
  self._id_71A1 = ::_id_344D;
  self._id_719D = ::_id_3443;
  self._id_71C8 = ::_id_3445;
  self.bt._id_71CC = ::_id_34BD;
  self.fnismeleevalid = ::_id_347A;
  self.fncanmovefrompointtopoint = _id_0A10::canmovefrompointtopoint;
  self._id_71AE = ::_id_3476;
  self._blackboard.movemode = 0;
  self._blackboard._id_26A7 = self.origin;
  self.bt.lasttimekidnapped = 0;
  self.bt.enemies = [];
  self.bt._id_118F2 = var_1;
  self.bt._id_118F5 = var_1;
  self.bt._id_118F6 = var_1;
  self._id_BE11 = "c8_badplace_" + self getentitynumber();
  createnavrepulsor(self._id_BE11, 0, self, 128, 1);
  self setavoidanceradius(128);
  return anim.success;
}

_id_34EE(var_0) {
  if(!isalive(self)) {
    if(isDefined(self._id_BE11)) {
      destroynavrepulsor(self._id_BE11);
      self._id_BE11 = undefined;
    }

    return anim.failure;
  }

  scripts\asm\asm_bb::bb_setisincombat(isDefined(self.enemy));
  scripts\asm\asm_bb::bb_requestmovetype("walk");
  return anim.success;
}

_id_34EF(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = gettime();
  var_4 = undefined;

  if(isDefined(self.bt.enemies[0])) {
    var_4 = self.bt.enemies[0];
  }

  var_5 = 0;

  if(!self._id_3138 && _id_347B()) {
    var_1[var_1.size] = level.player;
    var_5 = 1;
    self.bt.lasttimekidnapped = var_3;
  }

  if(!var_5 && isDefined(self.enemy) && self.enemy != level.player && var_3 - self.bt.lasttimekidnapped < 4000 && var_3 - self lastknowntime(level.player) < 4000) {
    var_1[var_1.size] = level.player;
    var_5 = 1;
  }

  if(isDefined(self.enemy) && (!var_5 || self.enemy != level.player)) {
    var_1[var_1.size] = self.enemy;
  }

  if(!self._id_3138) {
    var_6 = self _meth_848B();

    if(isDefined(var_6)) {
      foreach(var_8 in var_6) {
        if(!var_5 || var_8 != level.player) {
          var_1[var_1.size] = var_8;
        }
      }
    }
  }

  foreach(var_11 in var_1) {
    if(!issentient(var_11) || var_3 - self lastknowntime(var_11) <= 1000) {
      var_2[var_2.size] = var_11.origin;
      continue;
    }

    var_2[var_2.size] = self lastknownpos(var_11);
  }

  self.bt.enemies = var_1;
  self.bt._id_656C = var_2;

  if(isDefined(self.bt.enemies[0]) && (!isDefined(var_4) || self.bt.enemies[0] != var_4)) {
    if(isPlayer(self.bt.enemies[0])) {
      _id_34A0("vox_c8_threatdetected");
    } else {
      _id_34A0("vox_c8_engaging");
    }
  }

  var_13 = var_1.size;

  if(var_13 == 0) {} else if(var_13 == 1) {
    self.bt._id_26A7 = var_2[0];
  } else if(var_13 > 1) {
    self.bt._id_26A7 = (0, 0, 0);
    var_14 = var_13;

    foreach(var_16 in var_2) {
      self.bt._id_26A7 = self.bt._id_26A7 + var_16;
    }

    if(self.bt.enemies[0] == level.player) {
      self.bt._id_26A7 = self.bt._id_26A7 + (var_2[0] + var_2[0]);
      var_14 = var_14 + 2;
    }

    self.bt._id_26A7 = self.bt._id_26A7 / var_14;
  }

  self._blackboard._id_26A7 = self.bt._id_26A7;
  return anim.success;
}

_id_347B() {
  var_0 = gettime();
  var_1 = 0;

  for(var_2 = 0; var_2 < 30; var_2++) {
    if(var_0 - self._blackboard._id_D41A[var_2] <= 2000) {
      var_1 = var_1 + self._blackboard._id_D418[var_2];
    }
  }

  return var_1 >= 200;
}

_id_34D8(var_0) {
  if(isDefined(self.asm._id_2AD2) || scripts\sp\utility::_id_9C11()) {
    return anim.failure;
  }

  if(gettime() > self._id_BF80 && !scripts\asm\asm_bb::bb_isheadless()) {
    var_1 = self.bt.enemies[0];

    if(distancesquared(var_1.origin, self.origin) < 810000) {
      var_2 = var_1 getshootatpos();

      if(self cansee(var_1) && self canshoot(var_2)) {
        return anim.success;
      }
    }
  }

  return anim.failure;
}

_id_FFB4() {
  if(!isDefined(self._blackboard.shootparams.target)) {
    return 1;
  }

  if(!isalive(self._blackboard.shootparams.target)) {
    return 1;
  }

  if(isDefined(self.asm._id_2AD2) || scripts\sp\utility::_id_9C11()) {
    return 1;
  }

  if(isDefined(self.bt.enemies) && isDefined(self.bt.enemies[0])) {
    if(isPlayer(self.bt.enemies[0]) && self.bt.enemies[0] != self._blackboard.shootparams.target && gettime() - self.bt.lasttimekidnapped < 100) {
      return 1;
    }
  }

  return 0;
}

_id_3479() {
  return isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams._id_2AA8);
}

_id_345B(var_0) {
  var_1 = gettime();
  self._blackboard.shootparams = spawnStruct();
  self._blackboard.shootparams.ent = self.bt.enemies[0];
  self._blackboard.shootparams._id_2AA6 = 0;
  self._blackboard.shootparams.target = self.bt.enemies[0];
  self._blackboard.shootparams._id_11935 = var_1;
  self._blackboard.shootparams._id_2AA8 = 1;
  self._blackboard.shootparams._id_32C5 = randomintrange(4000, 5000);
  self._blackboard.shootparams._id_32C2 = 0.5;
  self._blackboard.shootparams._id_3D2A = var_1 + 1750;
  self._id_BF80 = self._blackboard.shootparams._id_3D2A + self._blackboard.shootparams._id_32C5 + randomintrange(15000, 17000);
  self._blackboard.shootparams.taskid = var_0;
  return anim.success;
}

_id_345E(var_0) {
  self._blackboard.shootparams.taskid = var_0;
  self.bt.instancedata[var_0] = 0;
  self._blackboard.shootparams._id_E751 = (0, 0, 0);
  self playSound("c8_weap_charge_up");
  self._id_7211 = level._id_7649["c8_barrel_glow"];
  thread _id_345F();
}

_id_345F() {
  wait 0.05;

  if(isDefined(self) && isDefined(self._id_7211)) {
    playFXOnTag(self._id_7211, self, "tag_weapon_right");
  }
}

_id_345C(var_0) {
  if(_id_FFB4()) {
    return anim.failure;
  }

  var_1 = gettime();
  var_2 = self._blackboard.shootparams;

  if(self.bt.instancedata[var_0] % 4 == 0) {
    var_3 = var_2.target getshootatpos();

    if(self cansee(var_2.target) && self canshoot(var_3)) {
      var_4 = undefined;

      if(isDefined(var_2._id_A9EA)) {
        var_4 = var_2._id_A9EA;
      }

      var_2._id_A9EA = var_3;

      if(isDefined(var_4)) {
        var_2._id_E751 = vectorNormalize(var_2._id_A9EA - var_4);
      }
    }
  }

  self.bt.instancedata[var_0]++;

  if(var_1 < var_2._id_3D2A) {
    return anim.running;
  }

  if(self.bt.instancedata[var_0] > 80) {
    return anim.failure;
  }

  if(!scripts\aitypes\combat::isaimedataimtarget()) {
    return anim.running;
  }

  var_2._id_11935 = var_1;
  var_2._id_2AA7 = 1;
  self.weapon = self.secondaryweapon;
  return anim.success;
}

_id_345D(var_0) {
  if(self._blackboard.shootparams.taskid == var_0) {
    if(!isDefined(self._blackboard.shootparams._id_2AA7)) {
      self._blackboard.shootparams = undefined;
      killfxontag(self._id_7211, self, "tag_weapon_right");
      self._id_7211 = undefined;
    }
  }

  self.bt.instancedata[var_0] = undefined;
}

_id_10014(var_0, var_1) {
  if(isDefined(var_0.damageshield) && var_0.damageshield) {
    if(isDefined(var_0.script) && var_0.script == "pain") {
      return 0;
    }

    if(isDefined(var_0.asm) && isDefined(var_0.asm._id_2AD2) && var_0.asm._id_2AD2) {
      return 0;
    }
  }

  return self cansee(var_0) && self canshoot(var_1);
}

_id_345A(var_0) {
  var_1 = self._blackboard.shootparams;
  var_1.taskid = var_0;
  var_2 = var_1.target;

  if(_id_FFB4()) {
    return anim.failure;
  }

  var_3 = gettime();

  if(var_3 > var_1._id_11935 + var_1._id_32C5) {
    return anim.success;
  }

  if(!isDefined(self.bt.instancedata[var_0])) {
    self.bt.instancedata[var_0] = 0;
  }

  var_4 = var_2 getshootatpos();

  if(_id_10014(var_2, var_4)) {
    var_1.pos = var_4;
    var_1.ent = var_2;

    if(self.bt.instancedata[var_0] % 4 == 0) {
      var_1._id_E751 = vectorNormalize(var_1.pos - var_1._id_A9EA);
    }

    var_1._id_A9EA = var_1.pos;
    var_1._id_A9EB = undefined;
  } else {
    if(!isDefined(var_1._id_A9EB)) {
      var_5 = scripts\anim\shared::_id_811C();
      var_6 = bulletTrace(var_5, var_1._id_A9EA, 0, self);
      var_1._id_A9EB = var_6["position"] - vectorNormalize((var_1._id_E751[0], var_1._id_E751[1], 0)) * 12;
    }

    var_1.pos = var_1._id_A9EB;
    var_1.ent = undefined;
  }

  self.bt.instancedata[var_0]++;
  scripts\asm\asm_bb::bb_requestfire(1);
  return anim.running;
}

_id_3460(var_0) {
  if(self._blackboard.shootparams.taskid == var_0) {
    self._blackboard.shootparams = undefined;
  }

  scripts\asm\asm_bb::bb_requestfire(0);
  self.weapon = self.primaryweapon;
  self.bt.instancedata[var_0] = undefined;

  if(isDefined(self._id_7211)) {
    killfxontag(self._id_7211, self, "tag_weapon_right");
    self._id_7211 = undefined;
  }
}

_id_34CE(var_0) {
  var_1 = gettime();
  self._blackboard.shootparams = spawnStruct();
  self._blackboard.shootparams.ent = self.bt.enemies[0];
  self._blackboard.shootparams._id_2AA6 = 0;
  self._blackboard.shootparams.target = self.bt.enemies[0];
  self._blackboard.shootparams._id_11935 = var_1;
  self._blackboard.shootparams._id_32C5 = randomintrange(1000, 2000);
  self._blackboard.shootparams._id_32C2 = 1;
  self._blackboard.shootparams.taskid = var_0;
}

_id_34CD(var_0) {
  if(!isDefined(self.bt.enemies) || !isDefined(self.bt.enemies[0])) {
    return anim.failure;
  }

  var_1 = self._blackboard.shootparams.target;
  var_2 = self.bt.enemies[0];

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(var_2 != self._blackboard.shootparams.target) {
    if(isPlayer(var_2) || gettime() - self._blackboard.shootparams._id_11935 > 4000) {
      return anim.failure;
    }
  }

  if(self cansee(var_1)) {
    self._blackboard.shootparams.pos = var_1 getshootatpos();
    self._blackboard.shootparams.ent = var_1;
  } else {
    if(issentient(var_1)) {
      self._blackboard.shootparams.pos = self lastknownpos(var_1);
    } else {
      self._blackboard.shootparams.pos = var_1.origin;
    }

    self._blackboard.shootparams.ent = undefined;
  }

  if(scripts\aitypes\combat::isaimedataimtarget() && self seerecently(var_1, 4)) {
    scripts\asm\asm_bb::bb_requestfire(1);
  } else {
    scripts\asm\asm_bb::bb_requestfire(0);
  }

  return anim.running;
}

_id_34CF(var_0) {
  if(self._blackboard.shootparams.taskid == var_0) {
    self._blackboard.shootparams = undefined;
  }

  scripts\asm\asm_bb::bb_requestfire(0);
}

_id_34DE(var_0) {
  if(_id_3479()) {
    return anim.failure;
  }

  var_1 = gettime();

  if(gettime() - self.bt._id_118F2 < 500) {
    return anim.failure;
  }

  if(var_1 - self.bt._id_118F6 < 6000 || var_1 - self.bt._id_118F5 < 6000) {
    return anim.failure;
  }

  var_2 = self.bt.enemies[0];
  var_3 = var_2.origin - self.origin;
  var_4 = lengthsquared(var_3);

  if(var_4 < 40000) {
    return anim.failure;
  }

  self.bt._id_118F1 = gettime();
  var_5 = var_2 getshootatpos();

  if(isPlayer(var_2)) {
    var_5 = var_5 - (0, 0, 6);
  }

  if(self canshoot(var_5)) {
    return anim.failure;
  }

  var_6 = 128;
  var_7 = sqrt(var_4);

  if(var_7 < 800) {
    var_6 = var_6 * (1 - (800 - var_7) / 800);
  }

  var_6 = randomfloat(var_6);
  var_8 = randomfloat(360);
  var_9 = var_2.origin + (var_6 * cos(var_8), var_6 * sin(var_8), 0);
  var_10 = _id_3462();
  var_11 = self _meth_806C(var_10, var_9, 0, "min energy", "min time", "max time");

  if(!isDefined(var_11)) {
    return anim.failure;
  }

  self._blackboard._id_1182B = var_9;
  self._blackboard._id_11833 = var_11;
  return anim.success;
}

_id_34DF(var_0) {
  if(gettime() - self.bt._id_118F5 > 10000 && randomint(100) < 20) {
    return anim.success;
  }

  return anim.failure;
}

_id_34F3(var_0) {
  self._blackboard._id_313C = 1;
  self._blackboard._id_11830 = self.bt.enemies[0];
  self._blackboard._id_11834 = "c8_grenade";
  self.bt.instancedata[var_0] = gettime() + 3000;
}

_id_34F2(var_0) {
  self._blackboard._id_313C = 1;
  self._blackboard._id_11830 = self.bt.enemies[0];
  self._blackboard._id_11834 = "antigrav";
  self.bt.instancedata[var_0] = gettime() + 3000;
}

_id_3438() {
  self._blackboard._id_313C = undefined;
  self._blackboard._id_11830 = undefined;
  self._blackboard._id_1182B = undefined;
  self._blackboard._id_11834 = undefined;
  self._blackboard._id_11833 = undefined;
}

_id_34F0(var_0) {
  if(gettime() > self.bt.instancedata[var_0]) {
    _id_3438();
    return anim.success;
  }

  if(!isDefined(self._blackboard._id_11830)) {
    _id_3438();
    return anim.success;
  }

  if(distancesquared(self._blackboard._id_11830.origin, self._blackboard._id_1182B) > 65536) {
    _id_3438();
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start")) {
    return anim.success;
  }

  return anim.running;
}

_id_34F1(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

_id_34E9(var_0) {
  var_1 = gettime();
  self.bt.instancedata[var_0] = var_1 + 5000;
  self.bt._id_118F6 = var_1;
}

_id_34E8(var_0) {
  var_1 = gettime();
  self.bt.instancedata[var_0] = var_1 + 5000;
  self.bt._id_118F5 = var_1;
}

_id_34E6(var_0) {
  if(!isDefined(self._blackboard._id_313C)) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    self.bt._id_118F6 = gettime();
    return anim.success;
  }

  if(gettime() > self.bt.instancedata[var_0]) {
    return anim.success;
  }

  return anim.running;
}

_id_34E7(var_0) {
  self.bt.instancedata[var_0] = undefined;
  _id_3438();
}

_id_3462() {
  var_0 = (0, 0, 84);
  var_1 = self.asm.archetype;
  var_2 = "exposed_throw_grenade";
  var_3 = "exposed_grenade";

  if(isDefined(anim._id_85DF) && isDefined(anim._id_85DF[var_1])) {
    if(isDefined(anim._id_85E1[var_1][var_2]) && isDefined(anim._id_85E1[var_1][var_2][var_3])) {
      var_0 = anim._id_85E1[var_1][var_2][var_3][0];
    }
  }

  return var_0;
}

_id_3427(var_0) {
  if(!_id_0C3D::_id_3427()) {
    return anim.failure;
  }

  if(isDefined(self._blackboard.btstate_addsubstate)) {
    return anim.failure;
  }

  return anim.success;
}

_id_3477() {
  return isDefined(self._blackboard._id_2BE1) || isDefined(self._blackboard._id_3105);
}

_id_347A(var_0, var_1) {
  if(isDefined(self.script) && self.script == "cover_arrival") {
    return 0;
  }

  if(!self seerecently(var_0, 2)) {
    return 0;
  }

  return _id_0A10::ismeleevalid(var_0, var_1);
}

_id_34C3(var_0) {
  self.meleechargedistvsplayer = 180;
  self.fnismeleevalid = ::_id_347A;
  return anim.success;
}

_id_347F(var_0) {
  self._blackboard._id_2BE1 = 1;
  scripts\aitypes\melee::_id_B5E8(var_0);
}

_id_3480(var_0) {
  self._blackboard._id_2BE1 = undefined;
  self._blackboard._id_2BE0 = undefined;
  scripts\aitypes\melee::_id_B5EE(var_0);
}

_id_347D(var_0, var_1) {
  var_2 = 8000;

  if(self.health < self.maxhealth) {
    var_2 = 4000;
  }

  if(isDefined(self._blackboard.timeoffset) && gettime() - self._blackboard.timeoffset < var_2) {
    return 0;
  }

  if(isDefined(self.script) && self.script == "cover_arrival") {
    return 0;
  }

  if(isDefined(self.asm._id_2AD2)) {
    return 0;
  }

  if(!self cansee(var_0)) {
    return 0;
  }

  return _id_0A10::ismeleevalid(var_0, var_1);
}

_id_34C5(var_0) {
  self.meleechargedistvsplayer = 500;
  self.fnismeleevalid = ::_id_347D;
  return anim.success;
}

_id_34B3(var_0) {
  _id_347F(var_0);
  self.melee._id_2AC6 = 1;
  var_1 = gettime();
  self._blackboard.timeoffset = var_1;
  self.bt.instancedata[var_0]._id_3E45 = var_1 + 500;
}

_id_34B2(var_0) {
  self._blackboard._id_2BE1 = 1;

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_charge_state", "started")) {
    self._blackboard._id_2BE0 = 1;
  }

  if(gettime() >= self.bt.instancedata[var_0]._id_3E45) {
    if(!isDefined(self.bt.instancedata[var_0]._id_10D9D)) {
      self.bt.instancedata[var_0]._id_10D9D = anglesToForward(self.angles);
    } else {
      var_1 = anglesToForward(self.angles);

      if(vectordot(var_1, self.bt.instancedata[var_0]._id_10D9D) < 0.966) {
        if(!isDefined(self._blackboard._id_2BE0)) {
          self.melee._id_2720 = 1;
          return anim.failure;
        } else {
          self.melee._id_29A8 = 1;
          self._blackboard._id_3105 = 1;
          return anim.success;
        }
      }
    }
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_rush_state", "end")) {
    self.melee._id_2720 = 1;
    return anim.failure;
  }

  var_2 = scripts\aitypes\melee::_id_B5F0(var_0);

  if(var_2 == anim.failure) {
    if(isDefined(self._blackboard._id_2BE0) && gettime() > self._blackboard.timeoffset) {
      var_3 = self _meth_84AC();
      var_1 = anglesToForward(self.angles);

      if(self maymovefrompointtopoint(var_3, var_3 + 24 * var_1, 1, 1)) {
        self._blackboard._id_3105 = 1;
      }

      self.melee._id_2720 = undefined;
      self.melee._id_29A8 = 1;
      var_2 = anim.success;
    }
  }

  return var_2;
}

_id_34B4(var_0) {
  _id_3480(var_0);
  self._blackboard.timeoffset = gettime();
}

_id_34B7(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].startpos = self.origin;
  self.bt.instancedata[var_0].timeout = gettime() + 3000;
}

_id_34B5(var_0) {
  if(!isDefined(self._blackboard._id_3105)) {
    return anim.success;
  }

  if(scripts\aitypes\melee::melee_shouldabort() || scripts\sp\utility::_id_9C11()) {
    if(isDefined(self.melee)) {
      self.melee._id_2720 = 1;
    }

    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_rush_state", "end")) {
    self.melee._id_2720 = 1;
    return anim.failure;
  }

  if(gettime() > self.bt.instancedata[var_0].timeout) {
    self.melee._id_2720 = 1;
    return anim.failure;
  }

  self _meth_8481(self.origin);
  self._blackboard.movemode = 5;
  return anim.running;
}

_id_34B8(var_0) {
  self._blackboard._id_3105 = undefined;
  self._blackboard.timeoffset = gettime();
  _id_3480(var_0);
}

_id_34DC(var_0) {
  if(isDefined(self._id_EDE3)) {
    return anim.failure;
  }

  if(!self._id_290A) {
    if(!_id_3479()) {
      self._blackboard.movemode = -1;
      return anim.failure;
    }
  }

  if(isDefined(self._blackboard._id_2BE1)) {
    self._blackboard.movemode = 0;
    return anim.failure;
  }

  if(scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    self._blackboard.movemode = 0;
    return anim.failure;
  }

  return anim.success;
}

_id_3426() {
  var_0 = 0;

  if(var_0) {
    var_1 = spawnStruct();
    var_1.pos = self.origin;
    var_1.radius = 12;
    var_1.movetype = 0;
    return var_1;
  }

  if(_id_3479() || isDefined(self._blackboard._id_313C)) {
    var_1 = spawnStruct();
    var_1.pos = self getposonpath(24);
    var_1.radius = 30;
    var_1.movetype = 4;
    return var_1;
  }

  if(!self _meth_84BA(self.origin, -6) && !self _meth_84BA(self.bt._id_656C[0])) {
    if(!self _meth_84BA(self.origin, 48) && self._blackboard.movemode != 6) {
      var_1 = spawnStruct();
      var_1.movetype = 6;
      return var_1;
    }

    return undefined;
  }

  if(_id_347C()) {
    return undefined;
  }

  if(_id_34DB()) {
    if(isDefined(self._blackboard._id_11936) && gettime() - self._blackboard._id_11936 > 2000) {
      if(self._blackboard.movemode != 2 || !isDefined(self.bt._id_A944) || distancesquared(self.bt._id_A944, self.bt.enemies[0].origin) > 36) {
        if(self._blackboard.movemode == 2 || self._blackboard.movemode == 1) {
          var_2 = self.bt.enemies[0].origin;
          var_3 = 2;
        } else {
          var_2 = self.bt._id_656C[0];
          var_3 = 1;
        }

        self.bt._id_A944 = var_2;
        var_1 = spawnStruct();
        var_1.pos = var_2;
        var_1.radius = 30;
        var_1.movetype = var_3;
        return var_1;
      }
    } else
      return undefined;
  }

  if(isDefined(self.bt._id_A944) && distancesquared(self.bt._id_26A7, self.bt._id_A944) < 1296) {
    if(isDefined(self._blackboard._id_11936) && gettime() - self._blackboard._id_11936 > 2000) {
      var_1 = spawnStruct();
      var_4 = self.bt.enemies[0] getshootatpos();
      var_5 = self canshoot(var_4);
      var_6 = 1;

      if(randomint(100) < 20) {
        var_7 = anglesToForward(self.angles);

        if(distancesquared(self.bt.enemies[0].origin, self.origin) < 22500 || scripts\engine\utility::cointoss()) {
          var_6 = -1;
        }
      } else {
        var_7 = anglestoright(self.angles);

        if(scripts\engine\utility::cointoss()) {
          var_6 = -1;
        }
      }

      var_8 = randomintrange(64, 80);

      if(!var_5) {
        var_8 = var_8 + 60;
      }

      var_1.radius = 30;
      var_9 = var_8 + 18;
      var_10 = 0;

      for(var_11 = self _meth_84AC(); var_10 < 2; var_10++) {
        var_12 = var_11 + var_6 * var_7 * var_9;

        if(self maymovefrompointtopoint(var_11, var_12)) {
          var_1.pos = var_11 + var_6 * var_7 * var_8;
          var_1.movetype = 3;
          return var_1;
        } else if(!var_5) {
          var_13 = navtrace(var_11, var_12, self, 1);

          if(var_13["fraction"] > 0.5) {
            var_1.pos = var_11 + var_6 * var_7 * var_8 * var_13["fraction"];
            var_1.movetype = 3;
            return var_1;
          }
        }

        var_6 = var_6 * -1;
      }
    }

    return undefined;
  }

  var_14 = undefined;

  if(self.bt.enemies.size == 1) {
    var_15 = self.bt._id_26A7 - self.origin;
    var_16 = length(var_15);
    var_15 = var_15 / var_16;
    var_14 = self.origin + var_15 * (var_16 - self._id_10E67);
  } else {
    var_17 = self.bt._id_26A7 - self.origin;
    var_18 = abs(var_17[2]);
    var_17 = vectorNormalize(var_17);
    var_19 = 99999;

    for(var_20 = 0; var_20 < self.bt._id_656C.size; var_20++) {
      if(!issentient(self.bt.enemies[var_20]) || gettime() - self lastknowntime(self.bt.enemies[var_20]) < 2000) {
        var_21 = self.bt._id_656C[var_20];
        var_15 = var_21 - self.origin;
        var_22 = vectordot(var_17, var_15);

        if(var_22 < var_19) {
          var_19 = var_22;
        }
      }
    }

    var_23 = self._id_10E67 + self._id_10E68 * self.bt.enemies.size;

    if(var_18 > 72) {
      var_23 = var_23 + var_18 * 0.5;
    }

    var_14 = self.origin + var_17 * (var_19 - var_23);
  }

  var_24 = getnodesinradius(var_14, 36, 0, 80);

  if(var_24.size > 0) {
    var_14 = _id_34BA(var_24[0], var_14);
  }

  if(self._blackboard.movemode == 0 && distancesquared(var_14, self.origin) < 576) {
    return undefined;
  }

  self.bt._id_A944 = self.bt._id_26A7;
  var_1 = spawnStruct();
  var_1.pos = var_14;
  var_1.radius = 60;
  var_1.movetype = 0;
  return var_1;
}

_id_34BA(var_0, var_1) {
  var_2 = var_0.type;
  var_3 = [];
  var_3["Cover Left"] = (-36, 36, 0);
  var_3["Cover Right"] = (-36, -36, 0);
  var_3["Cover Crouch"] = [(-36, 36, 0), (-36, -36, 0)];
  var_3["Cover Stand"] = [(-36, 36, 0), (-36, -36, 0)];
  var_3["Exposed"] = [(-36, 36, 0), (-36, -36, 0), (36, 36, 0), (36, -36, 0)];
  var_4 = var_3[var_2];

  if(isDefined(var_4)) {
    if(isarray(var_4)) {
      var_4 = var_4[self._id_6A0B % var_4.size];
    }

    return var_0.origin + rotatevector(var_4, var_0.angles);
  }

  return var_1;
}

_id_34BB(var_0) {
  if(!isDefined(self.bt.enemies) || !isDefined(self.bt.enemies[0])) {
    self _meth_8481(self.origin);
    self.btgoalradius = 60;
    self._blackboard.movemode = 0;
    return anim.failure;
  }

  if(isDefined(self._blackboard._id_2F36)) {
    self _meth_8481(self.origin);
    self.btgoalradius = 60;
    self._blackboard.movemode = 0;
    return anim.failure;
  }

  var_1 = _id_3426();

  if(self._blackboard.movemode == 1 || self._blackboard.movemode == 2) {
    _id_34A0("vox_c8_seeking");
  }

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(var_1.movetype == 6) {
    self _meth_8484();
  } else {
    var_2 = getclosestpointonnavmesh(var_1.pos, self);
    self _meth_8481(var_2);
    self.btgoalradius = var_1.radius;
  }

  self._blackboard.movemode = var_1.movetype;
  return anim.success;
}

_id_34EC(var_0) {
  if(!isDefined(self.pathgoalpos)) {
    return anim.failure;
  }

  if(self._blackboard.movemode == 6 || self._blackboard.movemode == 4) {
    return anim.success;
  }

  var_1 = self _meth_84B6();

  if(!isDefined(var_1) || distancesquared(self.origin, var_1) < 9) {
    self clearpath();
    self _meth_8484();
    return anim.failure;
  }

  self _meth_8481(var_1);
  return anim.success;
}

_id_34DB() {
  if(isDefined(self.pathgoalpos)) {
    return 0;
  }

  foreach(var_1 in self.bt.enemies) {
    if(self seerecently(var_1, 2)) {
      return 0;
    }
  }

  return 1;
}

_id_347C() {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(self._blackboard.movemode != 1 && self._blackboard.movemode != 2) {
    return 0;
  }

  if(issentient(self.bt.enemies[0]) && gettime() - self lastknowntime(self.bt.enemies[0]) < 1000) {
    return 0;
  }

  return 1;
}

_id_3469(var_0) {
  self._blackboard.shootparams = spawnStruct();

  if(isDefined(self.bt.enemies[0])) {
    var_1 = vectortoyaw(self.bt.enemies[0].origin - self.origin);
    var_1 = angleclamp180(var_1 - self.angles[1]);
  } else
    var_1 = 0;

  var_2 = randomint(2);

  if(var_2 == 0) {
    var_2 = -1;
  }

  self._blackboard.shootparams._id_10E0E = var_1 + var_2 * randomintrange(40, 60);
  self._blackboard.shootparams._id_639C = var_1 - var_2 * randomintrange(40, 60);
  self._blackboard.shootparams._id_32C5 = randomintrange(750, 1500);
  self._blackboard.shootparams._id_32C4 = gettime();
  self._blackboard.shootparams._id_32C2 = 0.05;
  self._blackboard.shootparams.taskid = var_0;
}

_id_3468(var_0) {
  var_1 = self._blackboard.shootparams._id_639C - self._blackboard.shootparams._id_10E0E;
  var_2 = (gettime() - self._blackboard.shootparams._id_32C4) / self._blackboard.shootparams._id_32C5;

  if(var_2 > 1) {
    return anim.success;
  }

  var_3 = self._blackboard.shootparams._id_10E0E + var_1 * var_2;
  var_3 = var_3 + self.angles[1];
  var_4 = anglesToForward((0, var_3, 0));
  self._blackboard.shootparams.pos = self.origin + var_4 * 256;
  var_5 = self getmuzzleangle();
  var_6 = angleclamp180(var_3 - var_5[1]);

  if(abs(var_6 < 15)) {
    scripts\asm\asm_bb::bb_requestfire(1);
  } else {
    scripts\asm\asm_bb::bb_requestfire(0);
  }

  return anim.running;
}

_id_346A(var_0) {
  if(self._blackboard.shootparams.taskid == var_0) {
    self._blackboard.shootparams = undefined;
  }

  scripts\asm\asm_bb::bb_requestfire(0);
}

_id_346C(var_0) {
  self.bt.instancedata[var_0] = gettime() + randomintrange(500, 3000);
}

_id_346B(var_0) {
  if(gettime() >= self.bt.instancedata[var_0]) {
    return anim.success;
  }

  return anim.running;
}

_id_34DA(var_0) {
  if(!_id_0C3D::_id_3428(self._blackboard._id_B0E3)) {
    return anim.failure;
  }

  if(isDefined(self._id_5580) && self._id_5580) {
    return anim.failure;
  }

  if(gettime() < self._id_FCA2) {
    return anim.failure;
  }

  if(isDefined(self._blackboard.btstate_addsubstate)) {
    return anim.failure;
  }

  var_2 = getaiunittypearray(self.team, "soldier");

  if(var_2.size == 0) {
    return anim.failure;
  }

  var_3 = getaicount(scripts\engine\utility::get_enemy_team(self.team));

  if(var_3 < 4) {
    return anim.failure;
  }

  var_4 = 4194304;
  var_5 = anglesToForward(self.angles);
  var_6 = 0;
  var_7 = 0;

  foreach(var_9 in var_2) {
    var_10 = var_9.origin - self.origin;

    if(lengthsquared(var_10) < var_4) {
      var_11 = vectordot(var_5, var_10);
      var_12 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var_12)) {
        var_13 = anglesToForward(var_12.angles);
      } else {
        var_13 = anglesToForward(var_9.angles);
      }

      var_14 = vectorNormalize(-1 * var_10);
      var_15 = vectordot(var_13, var_14);

      if(var_11 < 24 && var_15 > 0.5) {
        var_6++;
      } else {
        var_7++;
      }
    }
  }

  if(var_6 > 1) {
    var_17 = _id_342E(self.origin, self.angles, 72, 192);

    if(var_17) {
      return anim.success;
    }
  }

  return anim.failure;
}

_id_348D(var_0) {
  self._blackboard._id_2F36 = 1;
  self._blackboard._id_FC93 = self.angles;
  self.bt.instancedata[var_0] = gettime();
}

_id_348C(var_0) {
  if(!isDefined(self._blackboard._id_2F36)) {
    return anim.success;
  }

  if(gettime() > self.bt.instancedata[var_0] + 5000) {
    return anim.failure;
  }

  return anim.running;
}

_id_348E(var_0) {
  self._blackboard._id_2F36 = undefined;
  self._blackboard._id_FC93 = undefined;
  self.bt.instancedata[var_0] = undefined;
}

_id_342E(var_0, var_1, var_2, var_3) {
  var_4 = getnodesinradius(var_0, 72, 0, 80, "Cover");

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      if(var_6.type == "Exposed" && distancesquared(var_0, var_6.origin) > 1296) {
        continue;
      }
      return 0;
    }
  }

  var_8 = anglesToForward(var_1);
  var_9 = anglestoright(var_1);

  if(navtrace(var_0, var_0 + var_8 * var_3, self, 0)) {
    return 0;
  }

  if(navtrace(var_0, var_0 + var_9 * var_2, self, 0)) {
    return 0;
  }

  if(navtrace(var_0, var_0 - var_9 * var_2, self, 0)) {
    return 0;
  }

  return 1;
}

_id_344D(var_0) {
  if(isDefined(self.bt._id_55CF)) {
    return;
  }
  if(_id_0A0B::_id_7C35(var_0.partname) == "dismember") {
    return;
  }
  self._blackboard.dismemberedparts[var_0.partname] = gettime();

  switch (var_0.partname) {
    case "head":
      _id_344B();
      _id_0A0B::_id_98C9(var_0.partname);
      _id_34BF(var_0.partname, "dismember");
      return;
    case "right_arm":
      _id_344F();
      break;
    case "left_arm_upper":
      _id_344C("shield_upper");
      break;
    case "left_arm_lower":
      _id_344C("shield_lower");
      break;
    case "torso":
    case "shield_lower":
    case "shield_upper":
    case "right_leg":
    case "left_leg":
      return;
  }

  _id_344E(var_0.partname);
}

_id_3443(var_0) {
  _id_0A0B::_id_98C9(var_0.partname);

  switch (var_0.partname) {
    case "head":
      return;
    case "left_arm_lower":
    case "left_arm_upper":
      var_1 = "dmg_" + var_0.subpartname;
      _id_0A0B::_id_98C9("shield_" + var_0.subpartname);
      _id_34BF(var_0.partname, var_1, "shield_" + var_0.subpartname);
      break;
    case "shield_lower":
    case "shield_upper":
      thread _id_344A(var_0.partname);
      break;
    case "torso":
    case "right_arm":
    case "right_leg":
    case "left_leg":
      var_1 = "dmg_" + var_0.subpartname;
      _id_34BF(var_0.partname, var_1);
      break;
  }
}

_id_344E(var_0) {
  var_1 = "dismember";
  _id_0A0B::_id_98C9(var_0);
  _id_0A0B::_id_F6C9(var_0);
  _id_34BF(var_0, var_1);

  if(isDefined(self._id_2029)) {
    return;
  }
  if(isDefined(self.bt._id_55CE)) {
    return;
  }
  scripts\asm\asm::asm_setstate("dismember");
}

_id_3470(var_0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    self._blackboard.scriptableparts = [];
  }

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    self._blackboard.scriptableparts[var_0] = spawnStruct();
    self._blackboard.scriptableparts[var_0].state = "normal";
  }
}

_id_344A(var_0) {
  self endon("death");
  _id_342C(var_0, "disabled");
}

_id_34BE(var_0, var_1) {
  if(self._blackboard.scriptableparts[var_0].state == "dismember") {
    return;
  }
  if(self._blackboard.scriptableparts[var_0].state != "normal" && var_1 != "dismember") {
    self._blackboard.scriptableparts[var_0].state = "dmg_both";
  } else {
    self._blackboard.scriptableparts[var_0].state = var_1;
  }
}

_id_34BF(var_0, var_1, var_2) {
  self endon("entitydeleted");

  if(isDefined(var_2) && _id_3467(var_2)) {
    self setscriptablepartstate(var_2, "disabled");
  }

  _id_34BE(var_0, var_1);

  if(isDefined(self._id_EF39)) {
    return 1;
  }

  self setscriptablepartstate(var_0, self._blackboard.scriptableparts[var_0].state);

  if(isDefined(var_2) && _id_3467(var_2)) {
    self setscriptablepartstate(var_2, self._blackboard.scriptableparts[var_2].state);
  }

  _id_0A0B::_id_98C9(var_0 + "_dmg_fx");
  self setscriptablepartstate(var_0 + "_dmg_fx", var_1);
}

_id_3467(var_0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    return 1;
  }

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    return 1;
  }

  var_1 = self._blackboard.scriptableparts[var_0].state;
  return var_1 != "disabled" && var_1 != "planted";
}

_id_344B() {
  if(isDefined(self.bt._id_55CE)) {
    return;
  }
  self._id_87F6 = 0;
  self.bt.cannotmelee = 1;
  scripts\asm\asm_bb::bb_setheadless(1);
}

_id_344F() {
  if(isDefined(self.bt._id_55CE)) {
    return;
  }
  self._id_87F6 = 0;
  self.bt.cannotmelee = 1;

  if(isDefined(self._id_C05C)) {
    self.dropweapon = 0;
    self._id_C05C = undefined;
    self._id_E282 = 1;
  }

  scripts\anim\shared::_id_5D19();

  if(isDefined(self._id_E282)) {
    self._id_C05C = 1;
    self._id_E282 = undefined;
  }

  scripts\asm\asm_bb::bb_setselfdestruct(1);
}

_id_344C(var_0, var_1) {
  if(isDefined(self.bt._id_55CE)) {
    return;
  }
  _id_3452(var_0, 1);
  self._id_87F6 = 0;
  self.bt.cannotmelee = 1;
  _id_0A0B::_id_98C9(var_0);
  self._blackboard.scriptableparts[var_0].state = "disabled";
  self setscriptablepartstate(var_0, self._blackboard.scriptableparts[var_0].state);
}

_id_3452(var_0, var_1) {
  if(var_0 == "shield_upper") {
    _id_0C3D::_id_34C4(1);
    var_2 = "j_wrist_le";
  } else {
    _id_0C3D::_id_34C1(1);
    var_2 = "j_wristbtm_le";
  }

  thread _id_5D55(var_2, var_1);
}

_id_5D55(var_0, var_1) {
  var_2 = spawn("script_model", self gettagorigin(var_0));
  var_2 setModel("weapon_retract_shield_wm");
  var_2.angles = self gettagangles(var_0);
  thread _id_5D56(var_2, var_0 == "j_wrist_le");
  var_3 = spawn("script_model", self gettagorigin(var_0));
  var_3 hide();
  var_3 linkTo(var_2, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 _meth_84A7("tag_origin");
  var_3 setCursorHint("HINT_BUTTON");
  var_3 setHintString(&"EQUIPMENT_PICKUP_SHIELD");
  var_3 _meth_84A6(360);
  var_3 setusefov(360);
  var_3 _meth_84A4(500);
  var_3 setuserange(80);
  var_3 _meth_84A9("show");
  var_3 sethintstringparams(&"hud_interaction_prompt_center_equipment");
  var_3 thread _id_13AFF();

  if(isDefined(self._id_3133) && self._id_3133) {
    if(!issubstr(var_0, "btm")) {
      var_4 = (0, -64, 0);
      var_5 = (0, 0, 90);
    } else {
      var_4 = (0, 64, 0);
      var_5 = (0, 45, 90);
    }

    var_2.origin = getgroundposition(getclosestpointonnavmesh(self.origin + rotatevector(var_4, self.angles)), 1) - (0, 0, 3);
    var_2.angles = var_5;
  } else {
    var_6 = anglesToForward(self.angles);
    var_7 = var_2.origin;
    var_8 = 0;

    if(var_1) {
      var_7 = var_7 + (-10, -25, -10);
      var_8 = 400;
    }

    var_2 _meth_841C(1, var_7, var_6 * var_8);
  }

  for(;;) {
    wait 0.05;
    var_3 waittill("trigger");
    var_9 = scripts\sp\utility::_id_7C3D();
    var_10 = scripts\sp\utility::_id_7C3E();
    var_2 thread _id_10883(var_9, var_10);
    var_3 delete();
    var_2 delete();
    level.player giveweapon("offhandshield");
    return;
  }
}

_id_13AFF() {
  self endon("death");

  for(;;) {
    wait 0.05;

    if(_id_D39D()) {
      self makeunusable();
      continue;
    }

    self makeusable();
  }
}

_id_D39D() {
  return scripts\sp\utility::_id_D0BD("offhandshield", 1) || scripts\sp\utility::_id_D0BD("offhandshield_up1", 1);
}

_id_10883(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 == 0) {
    return;
  }
  var_2 = spawnStruct();
  var_2.origin = self.origin + (0, 0, 2);
  var_2.script_noteworthy = var_0 + "_pickup";
  var_2._id_EDE7 = var_1;
  var_2 thread _id_0B04::_id_4842("equipment", 0);
}

_id_5D56(var_0, var_1) {
  if(var_1) {
    wait 0.1;
  }

  level notify("c8_shield_dropped", var_0);
}

_id_3434(var_0) {
  if(!isDefined(self.bt._id_8C94)) {
    var_1[0] = "selfdestruct";
    var_1[1] = "shootrandomly";
    var_2 = [1, 3];

    if(isDefined(anim._id_A998)) {
      foreach(var_5, var_4 in var_1) {
        if(var_4 == anim._id_A998) {
          var_2[var_5] = var_2[var_5] - randomfloatrange(1, 5);
          var_2[var_5] = max(var_2[var_5], 0.2);
          break;
        }
      }
    }

    var_6 = _id_0BFE::_id_7D77(var_2);
    self.bt._id_8C94 = var_1[var_6];
    scripts\asm\asm_bb::_id_297B("haywire");

    if(self.bt._id_8C94 == "selfdestruct_running") {
      scripts\asm\asm_bb::_id_297B("haywire_walk");
    }
  }

  return anim.success;
}

_id_34BD(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.bt._id_F1F4)) {
    return;
  }
  var_4 = var_0.origin;
  var_0.bt._id_F1F4 = 1;

  if(!isDefined(var_1)) {
    var_1 = 250;
  }

  if(!isDefined(var_2)) {
    var_2 = 170;
  }

  if(!isDefined(var_3)) {
    var_3 = 20;
  }

  physicsexplosionsphere(var_4, 400, 50, 1);
  earthquake(2, 0.3, var_4, 400);

  foreach(var_8, var_6 in var_0._id_4D5D) {
    var_7 = var_0 _id_0A0B::_id_7C35(var_8);

    if(issubstr(var_8, "shield")) {
      if(var_0 _id_3467(var_8)) {
        var_0 _id_3452(var_8, 1);
        var_0 setscriptablepartstate(var_8, "disabled");
      }

      continue;
    }

    if(var_7 == "dismember") {
      continue;
    }
    var_0 _id_0A0B::_id_98C9(var_8 + "_dest_fx");
    var_0 setscriptablepartstate(var_8 + "_dest_fx", var_7);
  }

  var_0 thread _id_34BC();
}

_id_34BC() {
  if(!isDefined(self)) {
    return;
  }
  wait 0.05;
  self delete();
}

_id_3445() {
  if(isDefined(self.asm._id_2F3B)) {
    return;
  }
  self.asm._id_2F3B = 1;

  foreach(var_3, var_1 in self._id_4D5D) {
    var_2 = _id_0A0B::_id_7C35(var_3);

    if(issubstr(var_3, "shield")) {
      if(_id_3467(var_3)) {
        _id_3452(var_3, 1);
        self setscriptablepartstate(var_3, "disabled");
      }
    }
  }

  if(isDefined(self._id_12F8D)) {
    self._id_12F8D delete();
  }

  if(isDefined(self._id_B0DB)) {
    self._id_B0DB delete();
  }

  thread scripts\engine\utility::play_sound_in_space("c8_destruct", self.origin);
  playFX(level._id_7649["vfx_c8_explode_core"], self gettagorigin("j_spineupper"));
  self delete();
}

_id_342C(var_0, var_1) {
  if(var_1 == "open") {
    if(var_0 == "shield_upper") {
      _id_0C3D::_id_348B();
    } else {
      _id_0C3D::_id_348A();
    }
  } else if(var_1 == "closed" || var_1 == "disabled") {
    if(var_0 == "shield_upper") {
      if(var_1 == "disabled") {
        self._blackboard._id_12F90 = 1;
      }

      _id_0C3D::_id_343B();
    } else {
      if(var_1 == "disabled") {
        self._blackboard._id_B0E2 = 1;
      }

      _id_0C3D::_id_343A();
    }
  }
}

_id_34D6(var_0) {
  return anim.failure;
}

_id_342A(var_0) {
  self.bt.instancedata[var_0] = gettime();
}

_id_3429(var_0) {
  return anim.failure;
}

_id_342B(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

_id_34A0(var_0) {
  var_1 = gettime();
  var_2 = 2000;

  if(!isDefined(self._blackboard._id_A959) || var_1 - self._blackboard._id_A959 > var_2) {
    self playSound(var_0);
    self._blackboard._id_A959 = var_1;
  }
}

_id_3476() {
  if(!isDefined(self._blackboard.shootparams)) {
    return 1;
  }

  if(!isDefined(self._blackboard.shootparams.pos) && !isDefined(self._blackboard.shootparams.ent)) {
    return 1;
  }

  if(scripts\asm\asm_bb::_id_293E()) {
    return 1;
  }

  var_0 = scripts\anim\shared::_id_811C();
  var_1 = undefined;

  if(isDefined(self._blackboard.shootparams.ent)) {
    var_1 = self._blackboard.shootparams.ent getshootatpos();
  } else if(isDefined(self._blackboard.shootparams.pos)) {
    var_1 = self._blackboard.shootparams.pos;
  }

  var_2 = self getmuzzleangle();
  var_3 = vectortoangles(var_1 - var_0);
  var_4 = anim._id_1A52;
  var_5 = anim._id_1A51;
  var_6 = anim._id_1A44;
  var_7 = abs(angleclamp180(var_2[1] - var_3[1]));

  if(var_7 > var_4) {
    if(var_7 > var_5 || distancesquared(self getEye(), var_1) > anim._id_1A50) {
      return 0;
    }
  }

  var_8 = abs(angleclamp180(var_2[0] - var_3[0]));

  if(var_8 > var_6) {
    return 0;
  }

  return 1;
}