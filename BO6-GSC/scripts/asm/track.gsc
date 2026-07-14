/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\track.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\gameskill;
#namespace track;

function track(asmname) {
  assert(!isDefined(self.asmtrackasm), "<dev string:x24>");
  self.asmtrackasm = asmname;
  knobaim2 = asm::asm_lookupanimfromaliasifexists("?\xd3b\x8e/", "\xa8E\xcd\xc5\x8c");

  if(!isDefined(knobaim2)) {
    return;
  }

  aim2 = asm::asm_getxanim("?\xd3b\x8e/", asm::asm_lookupanimfromalias("?\xd3b\x8e/", "\xa8E\xcd\xc5\x8c"));
  aim4 = asm::asm_getxanim("?\xd3b\x8e/", asm::asm_lookupanimfromalias("?\xd3b\x8e/", "=T\x8e\xf3\xa1"));
  aim6 = asm::asm_getxanim("?\xd3b\x8e/", asm::asm_lookupanimfromalias("?\xd3b\x8e/", "P\xee&_\x8d"));
  aim8 = asm::asm_getxanim("?\xd3b\x8e/", asm::asm_lookupanimfromalias("?\xd3b\x8e/", "?d\xad\x90x"));
  trackinit(aim2, aim4, aim6, aim8);
  thread trackloop(asmname);
}

function trackinit(aim_2, aim_4, aim_6, aim_8) {
  self.a.aimweight = 1;
  self.a.aimweight_start = 1;
  self.a.aimweight_end = 1;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  self.asm.track = spawnStruct();
  self.asm.track.aim_2_default = aim_2;
  self.asm.track.aim_4_default = aim_4;
  self.asm.track.aim_6_default = aim_6;
  self.asm.track.aim_8_default = aim_8;
}

function laserthread() {
  self endon("<dev string:x68>");
  self notify("<dev string:x71>");
  self endon("<dev string:x71>");

  while(true) {
    if(isDefined(self.convergence) && isDefined(self.convergence.aim_pos)) {
      startpos = getlaserstartpoint();
      dir = vectorNormalize(self.convergence.aim_pos - startpos);
      endpos = startpos + dir * 2048;
      line(startpos, endpos, (255, 0, 0), 1, 1);
    }

    wait 0.05;
  }
}

function sniperdeathcleanup() {
  self endon("\xd5L\xba\n\x10\xbd\x9e\xb8\x83\xd2;");
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.sniper_laser)) {
    self.sniper_laser delete();
  }
}

function sniperlaserhackstop() {
  if(isDefined(self.sniper_laser)) {
    self notify("\xd5L\xba\n\x10\xbd\x9e\xb8\x83\xd2;");

    if(isDefined(self.fnlaseroff)) {
      self.sniper_laser[[self.fnlaseroff]]();
    }

    self.sniper_laser delete();
    self.sniper_laser = undefined;
    self.bhaslasertag = undefined;

    if(isDefined(self.fnsetlaserflag)) {
      self[[self.fnsetlaserflag]]("\r+x5");
    }
  }
}

function shoulduselasertag() {
  if(!(isDefined(self.weapon) && isDefined(self.weapon.basenamehash))) {
    return false;
  }

  switch (self.weapon.basenamehash) {
    case % "iw7_m8":
      return true;
    default:
      break;
  }

  return false;
}

function getlaserstartpoint() {
  if(!isDefined(self.bhaslasertag)) {
    if(shoulduselasertag()) {
      var_6aa7673c97634f8b = self gettagorigin("fJn\xc8\x10r\xf3\x94\xf6", 1);

      if(isDefined(var_6aa7673c97634f8b)) {
        self.bhaslasertag = 1;
        return var_6aa7673c97634f8b;
      }
    }

    self.bhaslasertag = 0;
  } else if(istrue(self.bhaslasertag)) {
    if(!shoulduselasertag()) {
      self.bhaslasertag = 0;
    }
  }

  if(self.bhaslasertag) {
    return self gettagorigin("fJn\xc8\x10r\xf3\x94\xf6");
  }

  return self getmuzzlepos();
}

function getlaserdirection() {
  return self getmuzzledir();
}

function getlaserangles() {
  return self getmuzzleangle();
}

function sniperlaserhackstart() {
  if(isDefined(self.sniper_laser)) {
    return;
  }

  thread sniperdeathcleanup();
  muzzlepos = getlaserstartpoint();
  self.sniper_laser = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", muzzlepos);
  self.sniper_laser setModel("fJn\xc8\x10r\xf3\x94\xf6");
  self.sniper_laser setmoverlaserweapon(self.weapon);
  self.sniper_laser setotherent(self);
  self.sniper_laser.origin = muzzlepos;

  if(!isDefined(self.var_de1e7369ac7638c)) {
    self.var_de1e7369ac7638c = 0.996;
  }

  if(isDefined(self.fnsetlaserflag)) {
    self[[self.fnsetlaserflag]]("qb\x14\x90\x9c\x0eu\x1b#\x93d");
  }

  if(isDefined(self.fnlaseron)) {
    self.sniper_laser[[self.fnlaseron]]();
  }

  assert(isDefined(self.convergence));

  while(isalive(self) && isDefined(self.sniper_laser)) {
    if(isDefined(self.convergence) && isDefined(self.convergence.aim_pos)) {
      muzzlepos = getlaserstartpoint();
      self.sniper_laser.origin = muzzlepos;
      desiredaimpos = self.convergence.aim_pos;
      desireddir = vectorNormalize(desiredaimpos - muzzlepos);
      muzzledir = getlaserdirection();
      desireddir = vectorNormalize((desireddir[0], desireddir[1], 0));
      muzzledir = vectorNormalize((muzzledir[0], muzzledir[1], 0));
      dot = vectordot(desireddir, muzzledir);

      if(dot < self.var_de1e7369ac7638c) {
        self.sniper_laser.angles = getlaserangles();
      } else {
        self.sniper_laser.angles = vectortoangles(self.convergence.aim_pos - self.sniper_laser.origin);
      }
    }

    waitframe();
  }
}

function trackturnofflaser() {
  if(istrue(self.var_710551d8084487cc)) {
    return;
  }

  sniperlaserhackstop();
  self notify("\x81\xdd\x8e\xdb\xf0\x8a\x10\xb0\xa6Y\x81\x13.\x93\x1b\xa8");
}

function trackturnonlaser() {
  if(istrue(self.var_710551d8084487cc)) {
    return;
  }

  if(!isDefined(self.sniper_laser)) {
    thread sniperlaserhackstart();
    self notify("\xcc\x15)\x9c^Q\xdbA\v\xfd7\xf4\xcb'\xf6");
  }
}

function clearconvergence() {
  self.convergence = undefined;
  self.convergencevalid = 0;
}

function resetconvergence(bnewtarget, var_6b8bc64046fadcef, bretarget) {
  if(!isDefined(self.convergence)) {
    self.convergence = spawnStruct();
    self.convergencevalid = 1;
  }

  self.var_4261477047d6c9b2 = 0;
  self.convergence.target = self._blackboard.shootparams_ent;
  self.convergence.converge_missouterradius = 96;

  if(isDefined(self.var_c0087d5890ec4816)) {
    self.convergence.converge_time = self[[self.var_c0087d5890ec4816]](bnewtarget, bretarget);
  } else if(bnewtarget) {
    self.convergence.converge_time = 1500;
  } else if(istrue(bretarget)) {
    self.convergence.converge_time = 1500;
  } else {
    self.convergence.converge_time = 2000;
  }

  if(isDefined(self.fnsetlaserflag)) {
    self[[self.fnsetlaserflag]]("qb\x14\x90\x9c\x0eu\x1b#\x93d");
  }

  currentskill = gameskill::get_skill_from_index(level.gameskill);
  convergencemultiplier = level.difficultysettings["x\xce|(Au_;`\xc5u>\x93\x87F\xe0\v\x10\xf2\xc1\x82"][currentskill];

  if(isDefined(convergencemultiplier)) {
    self.convergence.converge_time = int(self.convergence.converge_time * convergencemultiplier);
  }

  if(isDefined(level.sniper_convergence_time_multiplier)) {
    self.convergence.converge_time *= level.sniper_convergence_time_multiplier;
  }

  self.convergence.converge_missinnerradius = 12;
  self.convergencelockdurationbeforefiring = 750;
  self.convergencelockedontime = -1;

  if(getdvarint(@ "hash_75e9120fb2fd5fc3", 0)) {
    self._blackboard.var_75318b3b9fdee0d3 = 500;
  }

  if(!isDefined(self.sniper_laser)) {
    self.convergencecurtime = -1500;
  } else {
    self.convergencecurtime = 0;
  }

  self.convergenceshoottime = int(self.convergence.converge_time + 1000);
  self.convergence.converge_laserofftime = self.convergenceshoottime + 500;

  if(isDefined(self._blackboard.shootparams_pos)) {
    convergestartpos = undefined;
    targetvel = undefined;

    if(isDefined(self.var_45525eab75f9408f)) {
      convergestartpos = self[[self.var_45525eab75f9408f]](self._blackboard.shootparams_ent, bretarget);
    } else if(isDefined(var_6b8bc64046fadcef)) {
      convergestartpos = var_6b8bc64046fadcef;
    } else {
      if(isDefined(self._blackboard.shootparams_ent)) {
        targetpos = self._blackboard.shootparams_ent.origin;

        if(isPlayer(self._blackboard.shootparams_ent)) {
          targetvel = self._blackboard.shootparams_ent getvelocity();

          if(targetvel == (0, 0, 0)) {
            targetvel = undefined;
          }
        }
      } else {
        targetpos = self._blackboard.shootparams_pos - (0, 0, 70);
      }

      targetdelta = targetpos - self.origin;
      targetdelta = (targetdelta[0], targetdelta[1], 0);
      targetdir = vectorNormalize(targetdelta);

      if(istrue(bretarget)) {
        convergestartpos = targetpos;
        convergestartpos += (0, 0, randomfloatrange(12, 36));
      } else {
        convergestartpos = targetpos - targetdir * randomfloatrange(120, 180);
      }

      targetleft = vectorcross(targetdir, (0, 0, 1));
      var_2624ae8f69d0919a = randomfloatrange(6, 36);

      if(istrue(bretarget)) {
        var_2624ae8f69d0919a = randomfloatrange(12, 24);
      }

      if(isDefined(targetvel)) {
        dot = vectordot(targetvel, targetleft);

        if(dot < 0) {
          convergestartpos += targetleft * var_2624ae8f69d0919a;
        } else {
          convergestartpos -= targetleft * var_2624ae8f69d0919a;
        }
      } else if(randomintrange(0, 2)) {
        convergestartpos += targetleft * var_2624ae8f69d0919a;
      } else {
        convergestartpos -= targetleft * var_2624ae8f69d0919a;
      }
    }

    self.convergence.converge_offsetdir = vectorNormalize(convergestartpos - self._blackboard.shootparams_pos);
    self.convergence.converge_missouterradius = distance(convergestartpos, self._blackboard.shootparams_pos);
  }
}

function calcconvergencetarget() {
  assert(isDefined(self._blackboard.shootparams_pos));

  if(self.convergencelockedontime >= 0 && gettime() - self.convergencelockedontime >= 100) {
    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
      if(isDefined(self.fnsetlaserflag)) {
        self[[self.fnsetlaserflag]]("\x8a\xd9\xd1\x82");
      }
    } else if(isDefined(self.fnsetlaserflag)) {
      self[[self.fnsetlaserflag]]("qb\x14\x90\x9c\x0eu\x1b#\x93d");
    }

    if(isDefined(self.var_7f2de32286114977)) {
      return self[[self.var_7f2de32286114977]](self._blackboard.shootparams_pos - (0, 0, 1.3), self.convergence.aim_pos);
    }

    return (self._blackboard.shootparams_pos - (0, 0, 1.3));
  }

  metotarget = vectorNormalize(self._blackboard.shootparams_pos - self.origin);
  anglesmetotarget = vectortoangles(metotarget);

  if(self.convergencecurtime < 0) {
    if(isDefined(self.fnsetlaserflag)) {
      self[[self.fnsetlaserflag]]("qb\x14\x90\x9c\x0eu\x1b#\x93d");
    }

    shootpos = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * self.convergence.converge_missouterradius;
    return shootpos;
  }

  f = (self.convergence.converge_time - self.convergencecurtime) / self.convergence.converge_time;

  if(self.convergencecurtime >= self.convergence.converge_time) {
    f = 0;
  }

  foffset = f * (self.convergence.converge_missouterradius - self.convergence.converge_missinnerradius) + self.convergence.converge_missinnerradius;
  shootpos = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * foffset;

  if(isDefined(self.var_7f2de32286114977)) {
    shootpos = self[[self.var_7f2de32286114977]](shootpos, self.convergence.aim_pos);
  }

  if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
    if(isDefined(self.fnsetlaserflag)) {
      self[[self.fnsetlaserflag]]("qb\x14\x90\x9c\x0eu\x1b#\x93d");
    }
  }

  return shootpos;
}

function turnlaserbackon(waittime) {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait waittime;

  if(isDefined(self.sniper_laser)) {
    if(isDefined(self.fnlaseron)) {
      self.sniper_laser[[self.fnlaseron]]();
    }
  }
}

function convergencetargettick() {
  bcansee = 1;
  bnewtarget = 0;

  if(isDefined(self._blackboard.shootparams_ent)) {
    bcansee = self cansee(self._blackboard.shootparams_ent);

    if(isDefined(self.convergence) && isDefined(self.convergence.target) && self.convergence.target != self._blackboard.shootparams_ent) {
      bnewtarget = 1;
    }

    if(bcansee) {
      asm_bb::bb_updateshootparams_pos(self._blackboard.shootparams_ent getshootatpos());
    }
  }

  if(!isDefined(self.convergence) || bnewtarget) {
    resetconvergence(bnewtarget);
  } else if(bcansee && !istrue(self.convergence.bhaslos)) {
    if(isDefined(self.convergence.aim_pos) && distancesquared(self.convergence.aim_pos, self._blackboard.shootparams_pos) < 3600) {
      resetconvergence(bnewtarget, undefined, 1);
    } else {
      resetconvergence(bnewtarget);
    }
  } else if(self.var_4261477047d6c9b2) {
    if(isDefined(self.fnsetlaserflag)) {
      self[[self.fnsetlaserflag]]("qb\x14\x90\x9c\x0eu\x1b#\x93d");
    }

    self.var_4261477047d6c9b2 = 0;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent) && self cansee(self._blackboard.shootparams_ent)) {
      resetconvergence(bnewtarget, undefined, 1);
    }
  }

  self.convergence.bhaslos = bcansee;
  var_32340cad588ca26 = 1;
  muzzlepos = getlaserstartpoint();
  desiredaimpos = calcconvergencetarget();
  desireddir = vectorNormalize(desiredaimpos - muzzlepos);
  muzzledir = self getmuzzledir();
  var_744c03f6da8096b0 = 0.984;
  var_84cdfe95834ae2df = 0.996;

  if(isDefined(self.var_660fa3348ddbb3ad)) {
    var_744c03f6da8096b0 = self.var_660fa3348ddbb3ad;
  }

  if(isDefined(self.var_b9581ccf694102d8)) {
    var_84cdfe95834ae2df = self.var_b9581ccf694102d8;
  }

  if(self.convergencecurtime < 0) {
    if(!isaiming()) {
      return 0;
    }

    self.convergencecurtime += 50;
    fulldot = vectordot(desireddir, muzzledir);

    if(fulldot < var_744c03f6da8096b0) {
      return 0;
    }

    desireddir = vectorNormalize((desireddir[0], desireddir[1], 0));
    muzzledir = vectorNormalize((muzzledir[0], muzzledir[1], 0));
    dot = vectordot(desireddir, muzzledir);

    if(dot < var_84cdfe95834ae2df) {
      return 0;
    }

    self.convergencecurtime = 0;
  } else {
    self.convergencecurtime += 50;
    fulldot = vectordot(desireddir, muzzledir);

    if(fulldot < var_744c03f6da8096b0) {
      var_32340cad588ca26 = 0;
    }

    desireddir = vectorNormalize((desireddir[0], desireddir[1], 0));
    muzzledir = vectorNormalize((muzzledir[0], muzzledir[1], 0));
    dot = vectordot(desireddir, muzzledir);

    if(dot < var_84cdfe95834ae2df) {
      var_32340cad588ca26 = 0;
    }
  }

  if(self.convergencecurtime >= self.convergence.converge_time) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      if(self.convergencelockedontime < 0) {
        if(bcansee) {
          self.convergencelockedontime = gettime();
        }
      } else if(gettime() >= self.convergencelockedontime + 200) {
        if(!bcansee) {
          self.convergencelockedontime = -1;
        }
      }
    }
  }

  return var_32340cad588ca26;
}

function issniperconverging() {
  if(!isDefined(self.convergence)) {
    return false;
  }

  return true;
}

function issniperlaseron() {
  if(isDefined(self.sniper_laser)) {
    return true;
  }

  return false;
}

function isaiming() {
  if(!isDefined(self.asm.aimstarttime)) {
    return false;
  }

  aimblendtimems = 100;
  aimblendtimems *= 2;
  time = gettime();

  if(self.asm.aimstarttime + aimblendtimems < time) {
    return true;
  }

  return false;
}

function trackloop(asmname) {
  self endon("&\xe3\x15\x1e\xb9|(01/}\xa1\x13O");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.asm.prevyawdelta = 0;
  self.asm.prevpitchdelta = 0;
  firstframe = 1;
  var_42e706971333a1d0 = 0;
  var_4d30e381a6a1374 = 0;
  var_834f0d158babe364 = 10;

  while(true) {
    self waittill("\xaae\xf1\x9c9j \xab1M\x81\xa8\xf1\x12L\x1e\x97`\xe7");
    self.var_83393d822bfc2c17 = 1;

    for(;;) {
      if(!isDefined(self.asmtrackasm) || self asmcurrentstatehasaimset(self.asmtrackasm) && !self aiissniper()) {
        self.var_83393d822bfc2c17 = 0;
        break;
      }

      incranimaimweight();
      shouldaim = asm::asm_currentstatehasflag(self.asmtrackasm, "\xb5\x10\xb9");

      if(shouldaim && self function_1c5976c5ae9e4f09()) {
        shouldaim = 0;
      }

      if(!shouldaim && asm::asm_currentstatehasflag(self.asmtrackasm, "\x1e\x97\x86\xd0\xf5\xda\xaf\xf9\xdb\xb7\xc5'")) {
        shouldaim = asm::asm_eventfired(self.asmtrackasm, "\x93{\xdf\xe6\x03#\v-\xc7");
      }

      if(!shouldaim || !istrue(self._blackboard.shootparams_valid)) {
        if(!shouldaim && isDefined(self.convergence)) {
          clearconvergence();
        }

        trackturnofflaser();
        self.asm.aimstarttime = undefined;
      } else if(!isDefined(self.asm.aimstarttime)) {
        self.asm.aimstarttime = gettime();
      }

      if(isDefined(level.aimtestangles)) {
        shouldaim = 1;
      }

      var_5e9f2b9bd8ddd66c = 0;
      angledeltas = (0, 0, 0);
      shootposresult = undefined;
      shootfrompos = undefined;

      if(shouldaim) {
        if(self bb_shootparamsvalid() && isDefined(self._blackboard.shootparams_pos)) {
          if(isDefined(self.var_42f5cbcc7f83b70d) && istrue(self._blackboard.shootparams_bconvergeontarget)) {
            self[[self.var_42f5cbcc7f83b70d]]();
          } else if(istrue(self._blackboard.shootparams_bconvergeontarget)) {
            var_32340cad588ca26 = convergencetargettick();
            shootpos = calcconvergencetarget();
            assert(isDefined(self.convergence));
            self.convergence.aim_pos = shootpos;

            if(var_32340cad588ca26) {
              trackturnonlaser();
            } else {
              trackturnofflaser();
            }
          } else {
            trackturnofflaser();
          }
        } else {
          trackturnofflaser();
        }
      } else if(abs(self.asm.prevyawdelta) < 5 && abs(self.asm.prevpitchdelta) < 5) {
        self setaimangles((0, 0, 0));
        self setaimstate(3);
        self.baimedataimtarget = 0;
        waitframe();
        continue;
      }

      if(isDefined(level.aimtestangles)) {
        angledeltas = level.aimtestangles;
        self.asm.prevyawdelta = angledeltas[1];
        self.asm.prevpitchdelta = angledeltas[0];
      }

      if(self asmcurrentstatehasaimset(self.asmtrackasm)) {
        waitframe();
        continue;
      }

      if(istrue(self.runngun)) {
        waitframe();
        continue;
      }

      angledeltas = self getaimangle();
      pitchdelta = angledeltas[0];
      yawdelta = angledeltas[1];
      angledeltas = undefined;

      if(var_4d30e381a6a1374 > 0) {
        var_4d30e381a6a1374 -= 1;
        var_834f0d158babe364 = max(10, var_834f0d158babe364 - 5);
      } else if(self.relativedir && self.relativedir != var_42e706971333a1d0) {
        var_4d30e381a6a1374 = 2;
        var_834f0d158babe364 = 30;
      } else if(self aiissniper()) {
        var_834f0d158babe364 = 2;
      } else if(var_5e9f2b9bd8ddd66c) {
        var_834f0d158babe364 = 5;
      } else {
        var_834f0d158babe364 = 10;
      }

      var_e3fabe80660aaf58 = 4;
      var_42e706971333a1d0 = self.relativedir;
      var_42c610501594d15a = self.movemode != "\x04M\xed\xab" || !firstframe;

      if(var_42c610501594d15a) {
        yawdeltachange = yawdelta - self.asm.prevyawdelta;

        if(squared(yawdeltachange) > var_e3fabe80660aaf58) {
          var_9fe134a40a60cd52 = yawdeltachange * 0.4;
          yawdelta = self.asm.prevyawdelta + clamp(var_9fe134a40a60cd52, -1 * var_834f0d158babe364, var_834f0d158babe364);
          yawdelta = clamp(yawdelta, self.rightaimlimit, self.leftaimlimit);
        }

        pitchdeltachange = pitchdelta - self.asm.prevpitchdelta;

        if(squared(pitchdeltachange) > var_e3fabe80660aaf58) {
          var_711d3d05e66137bd = pitchdeltachange * 0.4;
          pitchdelta = self.asm.prevpitchdelta + clamp(var_711d3d05e66137bd, -1 * var_834f0d158babe364, var_834f0d158babe364);
          pitchdelta = clamp(pitchdelta, self.upaimlimit, self.downaimlimit);
        }
      }

      firstframe = 0;
      self.asm.prevyawdelta = yawdelta;
      self.asm.prevpitchdelta = pitchdelta;

      if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking) {
        trackloop_setanimweightslmg(pitchdelta, yawdelta);
      } else {
        trackloop_setanimweights(pitchdelta, yawdelta);
      }

      wait 0.05;
    }
  }
}

function trackloop_restoreaim() {
  if(!isDefined(self.asm.prevyawdelta)) {
    return;
  }

  yawdelta = clamp(self.asm.prevyawdelta, self.rightaimlimit, self.leftaimlimit);
  pitchdelta = clamp(self.asm.prevpitchdelta, self.upaimlimit, self.downaimlimit);

  if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking) {
    trackloop_setanimweightslmg(pitchdelta, yawdelta);
    return;
  }

  trackloop_setanimweights(pitchdelta, yawdelta);
}

function getcurrentpoi() {
  if(self.assigncurrentpoi) {
    if(isDefined(self.cqb_point_of_interest)) {
      self.cqb_point_of_interest.lastusedtime = self.poi_starttime;
    }

    self.currentpoi = self.cqb_point_of_interest;
    self.assigncurrentpoi = 0;
  }

  return self.currentpoi;
}

function trackloop_setanimweights(pitchdelta, yawdelta) {
  aim_5 = undefined;

  if(isDefined(self.asm.track.aim_2)) {
    aim_2 = self.asm.track.aim_2;
    aim_4 = self.asm.track.aim_4;
    aim_6 = self.asm.track.aim_6;
    aim_8 = self.asm.track.aim_8;
  } else {
    aim_2 = self.asm.track.aim_2_default;
    aim_4 = self.asm.track.aim_4_default;
    aim_6 = self.asm.track.aim_6_default;
    aim_8 = self.asm.track.aim_8_default;
  }

  if(isDefined(self.asm.track.aim_5)) {
    aim_5 = self.asm.track.aim_5;
  }

  weight2 = 0;
  weight4 = 0;
  weight5 = 0;
  weight6 = 0;
  weight8 = 0;
  yawdelta = clamp(yawdelta, self.rightaimlimit, self.leftaimlimit);
  pitchdelta = clamp(pitchdelta, self.upaimlimit, self.downaimlimit);

  if(yawdelta < 0) {
    weight6 = yawdelta / self.rightaimlimit * self.a.aimweight;
    weight5 = 1;
  } else if(yawdelta > 0) {
    weight4 = yawdelta / self.leftaimlimit * self.a.aimweight;
    weight5 = 1;
  }

  if(pitchdelta < 0) {
    weight8 = pitchdelta / self.upaimlimit * self.a.aimweight;
    weight5 = 1;
  } else if(pitchdelta > 0) {
    weight2 = pitchdelta / self.downaimlimit * self.a.aimweight;
    weight5 = 1;
  }

  self aisetanimlimited(aim_2, weight2, 0.1, 1, 1);
  self aisetanimlimited(aim_4, weight4, 0.1, 1, 1);
  self aisetanimlimited(aim_6, weight6, 0.1, 1, 1);
  self aisetanimlimited(aim_8, weight8, 0.1, 1, 1);

  if(isDefined(aim_5)) {
    self aisetanimlimited(aim_5, weight5, 0.1, 1, 1);
  }

  if(isDefined(level.aimtestangles)) {
    self aisetanimlimited(aim_2, weight2, 0, 1, 1);
    self aisetanimlimited(aim_4, weight4, 0, 1, 1);
    self aisetanimlimited(aim_6, weight6, 0, 1, 1);
    self aisetanimlimited(aim_8, weight8, 0, 1, 1);

    if(isDefined(aim_5)) {
      self aisetanimlimited(aim_5, weight5, 0, 1, 1);
    }
  }

}

function trackloop_setanimweightslmg(pitchdelta, yawdelta) {
  assert(isDefined(self.asm.track.lmg_aim_1));
  aim_1 = self.asm.track.lmg_aim_1;
  aim_2 = self.asm.track.lmg_aim_2;
  aim_3 = self.asm.track.lmg_aim_3;
  aim_4 = self.asm.track.lmg_aim_4;
  aim_6 = self.asm.track.lmg_aim_6;
  aim_7 = self.asm.track.lmg_aim_7;
  aim_8 = self.asm.track.lmg_aim_8;
  aim_9 = self.asm.track.lmg_aim_9;
  aim_anims = [aim_6, aim_9, aim_8, aim_7, aim_4, aim_1, aim_2, aim_3, aim_6];
  degrees = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  aim_vecs = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  max_angles = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  desired_vec = (yawdelta, pitchdelta, 0);
  desired_length = length2d(desired_vec);
  var_776fead18ac1c44e = vectorNormalize(desired_vec);
  desired_yaw = vectortoyaw(var_776fead18ac1c44e);
  desired_yaw = angleclamp180(desired_yaw);

  for(first_index = 0; desired_yaw > degrees[first_index]; first_index++) {}

  if(first_index == 0) {
    first_index = 1;
  }

  assert(first_index < aim_anims.size && first_index > 0, "<dev string:x7d>" + first_index + "<dev string:x8d>" + desired_yaw);
  statename = self.asm.track.lmg_aim_state;

  for(index = 0; index < aim_anims.size; index++) {
    if(index == first_index || index == first_index - 1) {
      anim_time = clamp(desired_length / max_angles[index], 0, 1);
      angle_diff = acos(vectordot(aim_vecs[index], var_776fead18ac1c44e));
      anim_weight = clamp(1 - angle_diff / max_angles[index], 0, 1);
      aimxanim = asm::asm_getxanim(statename, aim_anims[index]);
      prev_time = self aigetanimtime(aimxanim);

      if(prev_time > 0) {
        anim_length = getanimlength(aimxanim);
        anim_rate = (anim_time - prev_time) * anim_length / 0.05;
        self aisetanimlimited(aimxanim, anim_weight, 0.05, anim_rate);
      } else {
        self aisetanimlimited(aimxanim, anim_weight, 0.05, 0);
        self aisetanimtime(aimxanim, anim_time);
      }

      continue;
    }

    if(aim_anims[index] != aim_anims[first_index] && aim_anims[index] != aim_anims[first_index - 1]) {
      self aiclearanim(asm::asm_getxanim(statename, aim_anims[index]), 0.05);
    }
  }
}

function setanimaimweight(goalweight, goaltime) {
  if(!isDefined(goaltime) || goaltime <= 0) {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = goalweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight)) {
      self.a.aimweight = 0;
    }

    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = int(goaltime * 20);
  }

  self.a.aimweight_t = 0;
}

function incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    t = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
  }
}