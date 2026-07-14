/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_608c50392df8c7d1.gsc
*****************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_3763e9c81d7363c7;

function function_755d00ea6375ad14(streakname, scorepopup, vodestroyed, destroyedsplash) {
  self.streakname = streakname;
  self.scorepopup = scorepopup;
  self.vodestroyed = vodestroyed;
  self.destroyedsplash = destroyedsplash;
}

function function_f1dc442212872162(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  notifyattacker = 0;

  if(utility::issharedfuncdefined(#"damage", #"onkillstreakkilled") && isDefined(self.streakname)) {
    notifyattacker = self[[utility::getsharedfunc(#"damage", #"onkillstreakkilled")]](self.streakname, attacker, objweapon, meansofdeath, damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  } else if(utility::issharedfuncdefined(#"equipment", #"givescoreforequipment") && isDefined(self.owner.team) && isDefined(self.equipmentref) && isDefined(attacker.team) && isenemyteam(self.owner.team, attacker.team)) {
    attacker utility::callsharedfunc(#"equipment", #"givescoreforequipment", self, objweapon);
    notifyattacker = 1;
  }

  if(notifyattacker) {
    attacker notify("\xa5F_s\x8b%\xae\xd6v\x94\\Gu\xef\xe1\xf7<\xecI");
  }

  params = spawnStruct();
  params.meansofdeath = meansofdeath;
  callback::callback(#"on_functional_death", params);
}

function function_c1a8c4930cfc6f28(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  modifieddamage = damage;

  if(!isDefined(self.weapon_object) || !utility::callsharedfunc(#"killstreak", #"iskillstreakweapon", self.weapon_object)) {
    modifieddamage = utility::handlemeleedamage(objweapon, type, modifieddamage);
  }

  if(utility::issharedfuncdefined(#"damage", #"handleapdamage")) {
    modifieddamage = self[[utility::getsharedfunc(#"damage", #"handleapdamage")]](objweapon, type, modifieddamage, attacker);
  }

  return modifieddamage;
}

function function_addea75c898f01b2(data, hitstokillenemyteam, hitstokillownerteam, meleehitcount) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;

  if(type == "M\x81\xaf\xee\xc9\xcfD\xef\x91J") {
    return 0;
  }

  if(!istrue(self.bundle.var_be85376af89c5f32)) {
    return damage;
  }

  isenemydamage = 1;

  if(isDefined(self.owner) && utility::issharedfuncdefined(#"player", #"isenemy")) {
    isenemydamage = self.owner[[utility::getsharedfunc(#"player", #"isenemy")]](attacker);
  }

  if(isenemydamage) {
    hitstokill = hitstokillenemyteam;
  } else {
    hitstokill = hitstokillownerteam;
  }

  hits = undefined;

  if(isexplosivedamagemod(type) && istrue(self.bundle.explosivedamagetohits)) {
    hits = function_bc0ed7e9a1a6ed86(data, isenemydamage);
  } else if(utility::isbulletdamage(type) && istrue(self.bundle.bulletdamagetohits)) {
    hits = function_331156030c5baf8d(data, isenemydamage);
  } else if(type == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
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

function function_1aadf644565fbb8e(data) {
  assert(isDefined(self.bundle), "<dev string:x24>");
  return function_addea75c898f01b2(data, self.bundle.hitstokillenemy, self.bundle.hitstokillowner, self.bundle.meleehitcount);
}

function private function_331156030c5baf8d(data, isenemydamage) {
  isfmjdamage = 0;

  if(utility::issharedfuncdefined(#"damage", #"isfmjdamage")) {
    isfmjdamage = [[utility::getsharedfunc(#"damage", #"isfmjdamage")]](data.objweapon, data.meansofdeath);
  }

  basehits = isfmjdamage && isenemydamage ? 2 : 0;

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

function private function_bc0ed7e9a1a6ed86(data, isenemydamage) {
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

function function_b56504c4507259f9(maxrolldegrees, maxyawdiff) {
  self notify("\xbbb7x9`s*\x84w\x0e-\x16\xe9\xc2Hr\x16[D\x89\xfa\x10");
  self endon("\x1e\xfd\xd1\xa2\a");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xbbb7x9`s*\x84w\x0e-\x16\xe9\xc2Hr\x16[D\x89\xfa\x10");
  var_1cf2db5ea744f35f = (1, 0, 0);
  unityvector = (0, 1, 0);
  var_7691edb3f04dfd89 = (0, 0, -1);
  waitframe();
  self.previousorigin = self.origin;
  self.targetangles = self.angles;

  while(true) {
    stepvector = self.origin - self.previousorigin;
    stepunit = vectorNormalize(stepvector);
    pitch = asin(vectordot(stepunit, var_7691edb3f04dfd89));
    stepunit = (stepunit[0], stepunit[1], 0);
    stepunit = vectorNormalize(stepunit);
    yaw = acos(vectordot(stepunit, var_1cf2db5ea744f35f));

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

function function_9feb6199f8d6493e(var_270bdffac394be64, var_bdfe777690dcba9b, var_5bb1bb6dd3fcfd22) {
  self notify("\\\xd3m\xa8SP\xfb\x8f\x99\xd9l\xe3\xc0\x81\x1e\xee\x95\"\xcc\xedX8\\\xfc!B\xddn");
  self endon("\x1e\xfd\xd1\xa2\a");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\\\xd3m\xa8SP\xfb\x8f\x99\xd9l\xe3\xc0\x81\x1e\xee\x95\"\xcc\xedX8\\\xfc!B\xddn");
  self.previousangles = self.angles;
  lastsign = 1;

  while(true) {
    if(isDefined(self.targetangles)) {
      fixedtargetpitch = angleclamp(self.targetangles[0]);
      fixedcurrentpitch = angleclamp(self.angles[0]);
      fixedtargetyaw = angleclamp(self.targetangles[1]);
      fixedcurrentyaw = angleclamp(self.angles[1]);
      var_4c7cea9ab914fcbe = angleclamp(self.targetangles[2]);
      var_3489fd224d09f9a8 = angleclamp(self.angles[2]);
      pitcherror = fixedtargetpitch - fixedcurrentpitch;
      yawerror = fixedtargetyaw - fixedcurrentyaw;
      rollerror = var_4c7cea9ab914fcbe - var_3489fd224d09f9a8;
      var_3fc00b685596d55d = fixedtargetpitch - fixedcurrentpitch + 360;
      var_e4f2c148ac9c5485 = fixedtargetpitch - fixedcurrentpitch - 360;

      if(abs(var_3fc00b685596d55d) < abs(pitcherror)) {
        pitcherror = var_3fc00b685596d55d;
      } else if(abs(var_e4f2c148ac9c5485) < abs(pitcherror)) {
        pitcherror = var_e4f2c148ac9c5485;
      }

      var_f6ce1d75b41bc23a = fixedtargetyaw - fixedcurrentyaw + 360;
      var_4dedc0b92298bcf2 = fixedtargetyaw - fixedcurrentyaw - 360;

      if(abs(var_f6ce1d75b41bc23a) < abs(yawerror)) {
        yawerror = var_f6ce1d75b41bc23a;
      } else if(abs(var_4dedc0b92298bcf2) < abs(yawerror)) {
        yawerror = var_4dedc0b92298bcf2;
      }

      var_570e92e430795aa = var_4c7cea9ab914fcbe - var_3489fd224d09f9a8 + 360;
      var_33e12a549fd143f2 = var_4c7cea9ab914fcbe - var_3489fd224d09f9a8 - 360;

      if(abs(var_570e92e430795aa) < abs(rollerror)) {
        rollerror = var_570e92e430795aa;
      } else if(abs(var_33e12a549fd143f2) < abs(rollerror)) {
        rollerror = var_33e12a549fd143f2;
      }

      pitchstep = self.angles[0] + clamp(pitcherror, var_bdfe777690dcba9b * -1, var_bdfe777690dcba9b);
      yawstep = self.angles[1] + clamp(yawerror, var_270bdffac394be64 * -1, var_270bdffac394be64);
      rollstep = self.angles[2] + clamp(rollerror, var_5bb1bb6dd3fcfd22 * -1, var_5bb1bb6dd3fcfd22);
      newangles = (pitchstep, yawstep, rollstep);
      self.angles = newangles;
      lastsign = utility::sign(yawerror);
    }

    wait 0.05;
  }
}

function function_d4d620c21d7d4bc5(streakinfo, var_a90f7d67beb81aa5, destroyfunc) {
  params = spawnStruct();
  params.streakinfo = streakinfo;
  params.var_a90f7d67beb81aa5 = var_a90f7d67beb81aa5;
  params.destroyfunc = destroyfunc;
  callback::add(#"on_functional_death", &onfunctionaldeath, params);
}

function onfunctionaldeath(callbackparams, initparams) {
  streakinfo = initparams.streakinfo;
  var_a90f7d67beb81aa5 = initparams.var_a90f7d67beb81aa5;
  destroyfunc = initparams.destroyfunc;
  self endon("z\xf9`\xde\x98L1\x1b\xa6");
  self playSound("y\xe9;\xd8\xcb3\xebC\xa2\x85\xbcO\xf3\xfd088)");

  if(isDefined(streakinfo)) {
    level callback::callback(#"killstreak_finish_use", {
      #streakinfo: streakinfo
    });
  }

  if(isDefined(var_a90f7d67beb81aa5)) {
    self[[var_a90f7d67beb81aa5]](callbackparams);
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
    if(utility::issharedfuncdefined(#"game", #"returnobjectiveid")) {
      [[utility::getsharedfunc(#"game", #"returnobjectiveid")]](self.minimapid);
    }

    self.minimapid = undefined;
  }
}

function function_4d0e26a0c491d60(maxlifetime, debugactivedvar, var_f3aa354c59084de, var_46a531ac742cc231) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.owner endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  self endon("z\xf9`\xde\x98L1\x1b\xa6");

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
      var_255bcbba31670a19 = self.weapon_name ?? "<dev string:x60>";
      print3d(self.origin, var_255bcbba31670a19 + "<dev string:x64>" + self.lifetime + "<dev string:x73>", (0, 0, 1), 1, 0.5, 1);
    }

    waitframe();
  }

  if(isDefined(var_f3aa354c59084de)) {
    self[[var_f3aa354c59084de]](var_46a531ac742cc231);
  }

  callback::callback(#"on_functional_death");
}

function function_938ecd17995731bc(direction, velocity) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb5B\xd7\x904}\x11");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self.owner endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
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

function function_7161e0392ab6fc89(newowner, challengeeventid, outlineasset, onhackedcallback) {
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

  if(utility::issharedfuncdefined(#"challenges", #"onhack")) {
    newowner[[utility::getsharedfunc(#"challenges", #"onhack")]](challengeeventid);
  }

  if(utility::issharedfuncdefined(#"killstreak", #"givescoreforhack")) {
    newowner[[utility::getsharedfunc(#"killstreak", #"givescoreforhack")]]();
  }

  if(isDefined(outlineasset) && utility::issharedfuncdefined(#"outline", #"outlineenableforplayer")) {
    if(isDefined(self.streakname)) {
      priority = "\xbb\xbfj\x1e\xa2\x96\xc8\x01d(";
    } else {
      priority = "\v`\x90^V\xb2\xac\xd0\x86";
    }

    [[utility::getsharedfunc(#"outline", #"outlineenableforplayer")]](self, newowner, outlineasset, priority);
  }

  if(isDefined(onhackedcallback)) {
    self[[onhackedcallback]](newowner, oldowner);
  }
}

function function_9edc5382dd0802e2(aabbmin, aabbmax, duration) {
  self notify("<dev string:x79>");
  level endon("<dev string:x92>");
  self endon("<dev string:xa0>");
  self endon("<dev string:x79>");
  drawcolor = (0, 255, 0);
  var_b3c7ac66c748af5d = (aabbmax[0] - aabbmin[0], 0, 0);
  var_33d509de89db7c10 = (0, aabbmax[1] - aabbmin[1], 0);
  var_4a5f7b1c0b052152 = (0, 0, aabbmax[2] - aabbmin[2]);
  line(aabbmin, aabbmin + (aabbmax - aabbmin) / 2, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_b3c7ac66c748af5d, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_33d509de89db7c10, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_4a5f7b1c0b052152, drawcolor, 1, 0, duration);
  sphere(aabbmin, 5, drawcolor, 0, duration);
  drawcolor = (255, 0, 0);
  line(aabbmax, aabbmax + (aabbmin - aabbmax) / 2, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_b3c7ac66c748af5d, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_33d509de89db7c10, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_4a5f7b1c0b052152, drawcolor, 1, 0, duration);
  sphere(aabbmax, 5, drawcolor, 0, duration);
}

# /