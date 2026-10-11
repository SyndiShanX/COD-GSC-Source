/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_608c50392df8c7d1.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_8894a0caa4c34dc6;

function function_9469d528dd1ee44d(streakname, scorepopup, vodestroyed, destroyedsplash) {
  self.streakname = streakname;
  self.scorepopup = scorepopup;
  self.vodestroyed = vodestroyed;
  self.destroyedsplash = destroyedsplash;
}

function function_66a7440055d386c3(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  notifyattacker = 0;

  if(issharedfuncdefined("damage", "onKillstreakKilled") && isDefined(self.streakname)) {
    notifyattacker = self[[getsharedfunc("damage", "onKillstreakKilled")]](self.streakname, attacker, objweapon, meansofdeath, damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  }

  if(notifyattacker) {
    attacker notify("destroyed_equipment");
  }

  params = spawnStruct();
  params.meansofdeath = meansofdeath;
  callback::callback("on_functional_death", params);
}

function function_7bdb3610d602438d(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  modifieddamage = damage;

  if(!isDefined(self.weapon_object) || !callsharedfunc("killstreak", "isKillstreakWeapon", self.weapon_object)) {
    modifieddamage = utility::handlemeleedamage(objweapon, type, modifieddamage);
  }

  if(issharedfuncdefined("damage", "handleAPDamage")) {
    modifieddamage = self[[getsharedfunc("damage", "handleAPDamage")]](objweapon, type, modifieddamage, attacker);
  }

  return modifieddamage;
}

function function_90663ca0d2564cb(data, hitstokillenemyteam, hitstokillownerteam, meleehitcount) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;

  if(type == "MOD_IMPACT") {
    return 0;
  }

  if(!istrue(self.bundle.var_b66f1c97537f8793)) {
    return damage;
  }

  isenemydamage = 1;

  if(isDefined(self.owner) && issharedfuncdefined("player", "isEnemy")) {
    isenemydamage = self.owner[[getsharedfunc("player", "isEnemy")]](attacker);
  }

  if(isenemydamage) {
    hitstokill = hitstokillenemyteam;
  } else {
    hitstokill = hitstokillownerteam;
  }

  hits = undefined;

  if(isexplosivedamagemod(type) && istrue(self.bundle.explosivedamagetohits)) {
    hits = function_f9dbf2d9862d62ab(data, isenemydamage);
  } else if(isbulletdamage(type) && istrue(self.bundle.bulletdamagetohits)) {
    hits = function_d2c1bb18b26d0a9c(data, isenemydamage);
  } else if(type == "MOD_MELEE") {
    if(isDefined(meleehitcount) && meleehitcount < 0) {
      return damage;
    } else if(meleehitcount > 0) {
      hits = meleehitcount;
    } else {
      hits = hitstokill;
    }
  }

  if(isDefined(hits)) {
    damage = int(ceil(min(1, hits / hitstokill) * self.maxhealth));
  }

  if(isDefined(self.damagecallback)) {
    [[self.damagecallback]](damage);
  }

  return damage;
}

function function_79a97ee01dc267d3(data) {
  assertex(isDefined(self.bundle), "The super entity must have the .bundle variable defined.");
  return function_90663ca0d2564cb(data, self.bundle.hitstokillenemy, self.bundle.hitstokillowner, self.bundle.meleehitcount);
}

function private function_d2c1bb18b26d0a9c(data, isenemydamage) {
  isfmjdamage = 0;

  if(issharedfuncdefined("damage", "isFMJDamage")) {
    isfmjdamage = [[getsharedfunc("damage", "isFMJDamage")]](data.objweapon, data.meansofdeath);
  }

  basehits = ter_op(isfmjdamage && isenemydamage, 2, 0);

  if(data.damage > 150) {
    return (basehits + 10);
  }

  if(data.damage >= 80) {
    return (basehits + 5);
  }

  if(data.damage >= 30) {
    return (basehits + 2);
  }

  return basehits + 1;
}

function private function_f9dbf2d9862d62ab(data, isenemydamage) {
  if(data.damage > 200) {
    return 20;
  }

  if(data.damage > 70) {
    return 10;
  }

  if(data.damage > 30) {
    return 7;
  }

  return 2;
}

function function_62c1c6833c19817c(maxrolldegrees, maxyawdiff) {
  self notify("stop_adjust_tilt_thread");
  self endon("death");
  level endon("game_ended");
  self endon("stop_adjust_tilt_thread");
  var_cf4febe91831ea56 = (1, 0, 0);
  unityvector = (0, 1, 0);
  var_d2f1914cf518b7e0 = (0, 0, -1);
  waitframe();
  self.previousorigin = self.origin;
  self.targetangles = self.angles;

  while(true) {
    stepvector = self.origin - self.previousorigin;
    stepunit = vectorNormalize(stepvector);
    pitch = asin(vectordot(stepunit, var_d2f1914cf518b7e0));
    stepunit = (stepunit[0], stepunit[1], 0);
    stepunit = vectorNormalize(stepunit);
    yaw = acos(vectordot(stepunit, var_cf4febe91831ea56));

    if(vectordot(stepunit, unityvector) < 0) {
      yaw = 360 - yaw;
    }

    yawdiff = yaw - self.targetangles[1];

    if(abs(yawdiff) > 300) {
      yawdiff -= 360;
    }

    yawdiffclamped = clamp(yawdiff, maxyawdiff * -1, maxyawdiff);
    turnproportion = yawdiffclamped / maxyawdiff;
    roll = maxrolldegrees * turnproportion * -1;
    self.previousorigin = self.origin;
    newangles = (pitch, yaw, roll);
    self.targetangles = newangles;
    wait 0.05;
  }
}

function function_74f5ba869b257143(var_38a541b4d6af30a9, var_9d60d851a7af2d4e, var_2a86c82583ac927b) {
  self notify("stop_functionals_step_thread");
  self endon("death");
  level endon("game_ended");
  self endon("stop_functionals_step_thread");
  self.previousangles = self.angles;
  lastsign = 1;

  while(true) {
    if(isDefined(self.targetangles)) {
      fixedtargetpitch = angleclamp(self.targetangles[0]);
      fixedcurrentpitch = angleclamp(self.angles[0]);
      fixedtargetyaw = angleclamp(self.targetangles[1]);
      fixedcurrentyaw = angleclamp(self.angles[1]);
      var_9f3eda8daa0eda03 = angleclamp(self.targetangles[2]);
      var_641a388819ce1d85 = angleclamp(self.angles[2]);
      pitcherror = fixedtargetpitch - fixedcurrentpitch;
      yawerror = fixedtargetyaw - fixedcurrentyaw;
      rollerror = var_9f3eda8daa0eda03 - var_641a388819ce1d85;
      var_a5a7ce89b43ee10c = fixedtargetpitch - fixedcurrentpitch + 360;
      var_3ef2bd1018948fcc = fixedtargetpitch - fixedcurrentpitch - 360;

      if(abs(var_a5a7ce89b43ee10c) < abs(pitcherror)) {
        pitcherror = var_a5a7ce89b43ee10c;
      } else if(abs(var_3ef2bd1018948fcc) < abs(pitcherror)) {
        pitcherror = var_3ef2bd1018948fcc;
      }

      var_cd314f4801f94ceb = fixedtargetyaw - fixedcurrentyaw + 360;
      var_8a83d2c73960daab = fixedtargetyaw - fixedcurrentyaw - 360;

      if(abs(var_cd314f4801f94ceb) < abs(yawerror)) {
        yawerror = var_cd314f4801f94ceb;
      } else if(abs(var_8a83d2c73960daab) < abs(yawerror)) {
        yawerror = var_8a83d2c73960daab;
      }

      var_fe6c7708be15720b = var_9f3eda8daa0eda03 - var_641a388819ce1d85 + 360;
      var_26e224b6a576bacb = var_9f3eda8daa0eda03 - var_641a388819ce1d85 - 360;

      if(abs(var_fe6c7708be15720b) < abs(rollerror)) {
        rollerror = var_fe6c7708be15720b;
      } else if(abs(var_26e224b6a576bacb) < abs(rollerror)) {
        rollerror = var_26e224b6a576bacb;
      }

      pitchstep = self.angles[0] + clamp(pitcherror, var_9d60d851a7af2d4e * -1, var_9d60d851a7af2d4e);
      yawstep = self.angles[1] + clamp(yawerror, var_38a541b4d6af30a9 * -1, var_38a541b4d6af30a9);
      rollstep = self.angles[2] + clamp(rollerror, var_2a86c82583ac927b * -1, var_2a86c82583ac927b);
      newangles = (pitchstep, yawstep, rollstep);
      self.angles = newangles;
      lastsign = sign(yawerror);
    }

    wait 0.05;
  }
}

function function_63d1a11f8b22244(streakinfo, var_c09f3239d7caa490, destroyfunc) {
  params = spawnStruct();
  params.streakinfo = streakinfo;
  params.var_c09f3239d7caa490 = var_c09f3239d7caa490;
  params.destroyfunc = destroyfunc;
  callback::add("on_functional_death", &onfunctionaldeath, params);
}

function onfunctionaldeath(callbackparams, initparams) {
  streakinfo = initparams.streakinfo;
  var_c09f3239d7caa490 = initparams.var_c09f3239d7caa490;
  destroyfunc = initparams.destroyfunc;
  self endon("isCarried");
  self playSound("mp_equip_destroyed");

  if(isDefined(streakinfo)) {
    level callback::callback("killstreak_finish_use", {
      #streakinfo: streakinfo
    });
  }

  if(isDefined(var_c09f3239d7caa490)) {
    self[[var_c09f3239d7caa490]](callbackparams);
  }

  clearminimapid();
  wait 0.2;

  if(isDefined(destroyfunc)) {
    self[[destroyfunc]]();
    return;
  }

  if(isDefined(self)) {
    self delete();
  }
}

function clearminimapid() {
  if(isDefined(self.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }
}

function function_47b5394a301d8c5(maxlifetime, debugactivedvar, var_70a1d6b89907db6b, var_b0dfff7cb4b7be34) {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnected");
  self endon("isCarried");

  if(!isDefined(self.lifetime)) {
    self.lifetime = maxlifetime * 1000;
  }

  previoustime = gettime();

  while(self.lifetime > 0) {
    currenttime = gettime();
    timeelapsed = currenttime - previoustime;
    self.lifetime -= timeelapsed;
    previoustime = currenttime;

    debugactive = getdvarint(debugactivedvar);

    if(debugactive > 0) {
      var_f09362cfe2d75614 = ter_op(isDefined(self.weapon_name), self.weapon_name, "<dev string:x1c>");
      print3d(self.origin, var_f09362cfe2d75614 + "<dev string:x1d>" + self.lifetime + "<dev string:x29>", (0, 0, 1), 1, 0.5, 1);
    }

    waitframe();
  }

  if(isDefined(var_70a1d6b89907db6b)) {
    self[[var_70a1d6b89907db6b]](var_b0dfff7cb4b7be34);
  }

  callback::callback("on_functional_death");
}

function function_708fc89de0e3cd1(direction, velocity) {
  self endon("death");
  self endon("timeout");
  level endon("game_ended");
  self.owner endon("disconnect");
  newposition = self.origin;
  previoustime = gettime();

  while(true) {
    deltatime = gettime() - previoustime;
    previoustime = gettime();
    newposition += direction * velocity * deltatime;
    self.origin = newposition;
    waitframe();
  }
}

function function_888f3a0124b03ddc(newowner, challengeeventid, outlineasset, onhackedcallback) {
  self.ishacked = 1;
  oldowner = self.owner;
  self.owner = newowner;
  self.team = newowner.team;
  self setentityowner(newowner);
  self setotherent(newowner);

  if(level.teambased) {
    self filteroutplayermarks(newowner.team);
  } else {
    self filteroutplayermarks(newowner);
  }

  if(issharedfuncdefined("challenges", "onHack")) {
    newowner[[getsharedfunc("challenges", "onHack")]](challengeeventid);
  }

  if(issharedfuncdefined("killstreak", "giveScoreForHack")) {
    newowner[[getsharedfunc("killstreak", "giveScoreForHack")]]();
  }

  if(isDefined(outlineasset) && issharedfuncdefined("outline", "outlineEnableForPlayer")) {
    if(isDefined(self.streakname)) {
      priority = "killstreak";
    } else {
      priority = "equipment";
    }

    [[getsharedfunc("outline", "outlineEnableForPlayer")]](self, newowner, outlineasset, priority);
  }

  if(isDefined(onhackedcallback)) {
    self[[onhackedcallback]](newowner, oldowner);
  }
}

function function_36c55ae71072bd03(aabbmin, aabbmax, duration) {
  self notify("<dev string:x2c>");
  level endon("<dev string:x42>");
  self endon("<dev string:x4d>");
  self endon("<dev string:x2c>");
  drawcolor = (0, 255, 0);
  var_eb404bf9ac5040f0 = (aabbmax[0] - aabbmin[0], 0, 0);
  var_a6c378e90c169b15 = (0, aabbmax[1] - aabbmin[1], 0);
  var_5b9a5467ae4bf353 = (0, 0, aabbmax[2] - aabbmin[2]);
  line(aabbmin, aabbmin + (aabbmax - aabbmin) / 2, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_eb404bf9ac5040f0, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_a6c378e90c169b15, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_5b9a5467ae4bf353, drawcolor, 1, 0, duration);
  sphere(aabbmin, 5, drawcolor, 0, duration);
  drawcolor = (255, 0, 0);
  line(aabbmax, aabbmax + (aabbmin - aabbmax) / 2, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_eb404bf9ac5040f0, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_a6c378e90c169b15, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_5b9a5467ae4bf353, drawcolor, 1, 0, duration);
  sphere(aabbmax, 5, drawcolor, 0, duration);
}

# /