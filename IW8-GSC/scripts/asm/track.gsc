/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\track.gsc
***********************************************/

function track(var0) {
  self endon("asm_terminated");
  setglobalaimsettings();
  self.asm.trackasm = var0;
  var1 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_2"));
  var2 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_4"));
  var3 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_6"));
  var4 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_8"));
  trackinit(var1, var2, var3, var4);
  trackloop(var0);
}

function trackinit(var0, var1, var2, var3) {
  self.a.aimweight = 1;
  self.a.aimweight_start = 1;
  self.a.aimweight_end = 1;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  var4 = spawnStruct();
  var4.aim_2_default = var0;
  var4.aim_4_default = var1;
  var4.aim_6_default = var2;
  var4.aim_8_default = var3;
  self.asm.track = var4;
}

function sniperdeathcleanup() {
  self endon("stop_sniper");
  self waittill("death");

  if(isDefined(self.sniper_laser)) {
    self.sniper_laser delete();
    self.sniper_laser = undefined;
    return;
  }
}

function sniperlaserhackstop() {
  if(isDefined(self.sniper_laser)) {
    self notify("stop_sniper");
    self.sniper_laser[[self.fnlaseroff]]();
    self.sniper_laser delete();
    self.sniper_laser = undefined;
    self.bhaslasertag = undefined;
    self[[self.fnsetlaserflag]]("none");
    return;
  }
}

function shoulduselasertag() {
  var0 = getweaponbasename(self.weapon);

  switch (var0) {
    case "iw7_m8":
      return true;
    default:
      break;
  }

  return false;
}

function getlaserstartpoint() {
  if(!isDefined(self.bhaslasertag)) {
    if(shoulduselasertag()) {
      var0 = self gettagorigin("tag_laser", 1);

      if(isDefined(var0)) {
        self.bhaslasertag = 1;
        return var0;
      }
    }

    self.bhaslasertag = 0;
  } else if(istrue(self.bhaslasertag)) {
    if(!shoulduselasertag()) {
      self.bhaslasertag = 0;
    }
  }

  if(self.bhaslasertag) {
    return self gettagorigin("tag_laser");
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
  var0 = getlaserstartpoint();
  self.sniper_laser = spawn("script_model", var0);
  self.sniper_laser setModel("tag_laser");
  self.sniper_laser setmoverlaserweapon(self.weapon);
  self.sniper_laser setotherent(self);
  self.sniper_laser.origin = var0;
  self[[self.fnsetlaserflag]]("interpolate");
  self.sniper_laser[[self.fnlaseron]]();

  while(isalive(self) && isDefined(self.sniper_laser)) {
    if(isDefined(self.convergence.aim_pos)) {
      var0 = getlaserstartpoint();
      self.sniper_laser.origin = var0;
      var1 = self.convergence.aim_pos;
      var2 = vectorNormalize(var1 - var0);
      var3 = getlaserdirection();
      var2 = vectorNormalize((var2[0], var2[1], 0));
      var3 = vectorNormalize((var3[0], var3[1], 0));
      var4 = vectordot(var2, var3);

      if(var4 < 0.996) {
        self.sniper_laser.angles = getlaserangles();
      } else {
        self.sniper_laser.angles = vectortoangles(self.convergence.aim_pos - self.sniper_laser.origin);
      }
    }

    waitframe();
  }
}

function trackturnofflaser() {
  sniperlaserhackstop();
}

function trackturnonlaser() {
  if(!isDefined(self.sniper_laser)) {
    thread sniperlaserhackstart();
    return;
  }
}

function clearconvergence() {
  self.convergence = undefined;
}

function resetconvergence(var0, var1, var2) {
  if(!isDefined(self.convergence)) {
    self.convergence = spawnStruct();
  }

  self.convergence.sniper_fired = undefined;
  self.convergence.target = self._blackboard.shootparams_ent;
  self.convergence.converge_missouterradius = 96;

  if(var0) {
    self.convergence.converge_time = 1500;
  } else if(istrue(var2)) {
    self.convergence.converge_time = 1500;
  } else {
    self.convergence.converge_time = 2000;
  }

  self[[self.fnsetlaserflag]]("interpolate");
  var3 = scripts\common\gameskill::get_skill_from_index(level.gameskill);
  var4 = level.difficultysettings["sniper_converge_scale"][var3];

  if(isDefined(var4)) {
    self.convergence.converge_time *= var4;
  }

  if(isDefined(level.sniper_convergence_time_multiplier)) {
    self.convergence.converge_time *= level.sniper_convergence_time_multiplier;
  }

  self.convergence.converge_missinnerradius = 12;
  self.convergence.lock_duration_before_firing = 750;
  self.convergence.converge_locked_on_time = undefined;

  if(!isDefined(self.sniper_laser)) {
    self.convergence.converge_curtime = -1500;
  } else {
    self.convergence.converge_curtime = 0;
  }

  self.convergence.converge_shoottime = self.convergence.converge_time + 1000;
  self.convergence.converge_laserofftime = self.convergence.converge_shoottime + 500;

  if(isDefined(self._blackboard.shootparams_pos)) {
    var5 = undefined;
    var6 = undefined;

    if(isDefined(var1)) {
      var5 = var1;
    } else {
      if(isDefined(self._blackboard.shootparams_ent)) {
        var7 = self._blackboard.shootparams_ent.origin;

        if(isPlayer(self._blackboard.shootparams_ent)) {
          var6 = self._blackboard.shootparams_ent getvelocity();

          if(var6 == (0, 0, 0)) {
            var6 = undefined;
          }
        }
      } else {
        var7 = self._blackboard.shootparams_pos - (0, 0, 70);
      }

      var8 = var7 - self.origin;
      var8 = (var8[0], var8[1], 0);
      var9 = vectorNormalize(var8);

      if(istrue(var3)) {
        var6 = var7;
        var6 += (0, 0, randomfloatrange(12, 36));
      } else {
        var6 = var7 - var9 * randomfloatrange(120, 180);
      }

      var10 = vectorcross(var9, (0, 0, 1));
      var11 = randomfloatrange(6, 36);

      if(istrue(var3)) {
        var11 = randomfloatrange(12, 24);
      }

      if(isDefined(var7)) {
        var12 = vectordot(var7, var10);

        if(var12 < 0) {
          var6 += var10 * var11;
        } else {
          var6 -= var10 * var11;
        }
      } else if(randomintrange(0, 2)) {
        var6 += var10 * var11;
      } else {
        var6 -= var10 * var11;
      }
    }

    self.convergence.converge_offsetdir = vectorNormalize(var6 - self._blackboard.shootparams_pos);
    self.convergence.converge_missouterradius = distance(var6, self._blackboard.shootparams_pos);
    return;
  }
}

function calcconvergencetarget() {
  if(isDefined(self.convergence.converge_locked_on_time) && gettime() - self.convergence.converge_locked_on_time >= 100) {
    var0 = gettime() - self.convergence.converge_locked_on_time;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
      self[[self.fnsetlaserflag]]("lock");
    } else {
      self[[self.fnsetlaserflag]]("interpolate");
    }

    return (self._blackboard.shootparams_pos - (0, 0, 1.3));
  }

  var1 = vectorNormalize(self._blackboard.shootparams_pos - self.origin);
  var2 = vectortoangles(var1);

  if(self.convergence.converge_curtime < 0) {
    self[[self.fnsetlaserflag]]("interpolate");
    var3 = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * self.convergence.converge_missouterradius;
    return var3;
  }

  var4 = (self.convergence.converge_time - self.convergence.converge_curtime) / self.convergence.converge_time;

  if(self.convergence.converge_curtime >= self.convergence.converge_time) {
    var4 = 0;
  }

  var5 = var4 * (self.convergence.converge_missouterradius - self.convergence.converge_missinnerradius) + self.convergence.converge_missinnerradius;
  var3 = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * var5;

  if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
    self[[self.fnsetlaserflag]]("interpolate");
  }

  return var3;
}

function onsniperfired() {
  self notify("sniper_weapon_fired");

  if(isDefined(self.convergence) && isDefined(self.sniper_laser)) {
    self.convergence.sniper_fired = 1;
    return;
  }
}

function onsniperabouttofire() {
  if(isDefined(self.sniper_laser)) {
    self.sniper_laser[[self.fnlaseroff]]();
    thread turnlaserbackon(0.5);
    return;
  }
}

function turnlaserbackon(var0) {
  self endon("death");
  wait var0;

  if(isDefined(self.sniper_laser)) {
    self.sniper_laser[[self.fnlaseron]]();
    return;
  }
}

function convergencetargettick() {
  var0 = 1;
  var1 = 0;

  if(isDefined(self._blackboard.shootparams_ent)) {
    var0 = self cansee(self._blackboard.shootparams_ent);

    if(isDefined(self.convergence) && isDefined(self.convergence.target) && self.convergence.target != self._blackboard.shootparams_ent) {
      var1 = 1;
    }

    if(var0) {
      scripts\asm\asm_bb::bb_updateshootparams_pos(self._blackboard.shootparams_ent getshootatpos());
    }
  }

  if(!isDefined(self.convergence) || var1) {
    resetconvergence(var1);
  } else if(var0 && !istrue(self.convergence.bhaslos)) {
    if(isDefined(self.convergence.aim_pos) && distancesquared(self.convergence.aim_pos, self._blackboard.shootparams_pos) < 3600) {
      resetconvergence(var1, undefined, 1);
    } else {
      resetconvergence(var1);
    }
  } else if(istrue(self.convergence.sniper_fired)) {
    self[[self.fnsetlaserflag]]("interpolate");
    self.convergence.sniper_fired = undefined;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent) && self cansee(self._blackboard.shootparams_ent)) {
      resetconvergence(var1, undefined, 1);
    }
  }

  self.convergence.bhaslos = var0;
  var2 = 1;
  var3 = getlaserstartpoint();
  var4 = calcconvergencetarget();
  var5 = vectorNormalize(var4 - var3);
  var6 = self getmuzzledir();

  if(self.convergence.converge_curtime < 0) {
    if(!isaiming()) {
      return 0;
    }

    self.convergence.converge_curtime += 50;
    var7 = vectordot(var5, var6);

    if(var7 < 0.984) {
      return 0;
    }

    var5 = vectorNormalize((var5[0], var5[1], 0));
    var6 = vectorNormalize((var6[0], var6[1], 0));
    var8 = vectordot(var5, var6);

    if(var8 < 0.996) {
      return 0;
    }

    self.convergence.converge_curtime = 0;
  } else {
    self.convergence.converge_curtime += 50;
    var7 = vectordot(var7, var8);

    if(var7 < 0.984) {
      var4 = 0;
    }

    var7 = vectorNormalize((var7[0], var7[1], 0));
    var8 = vectorNormalize((var8[0], var8[1], 0));
    var8 = vectordot(var7, var8);

    if(var8 < 0.996) {
      var4 = 0;
    }
  }

  if(self.convergence.converge_curtime >= self.convergence.converge_time) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      if(!isDefined(self.convergence.converge_locked_on_time)) {
        if(var2) {
          self.convergence.converge_locked_on_time = gettime();
        }
      } else if(gettime() >= self.convergence.converge_locked_on_time + 200) {
        if(!var2) {
          self.convergence.converge_locked_on_time = undefined;
        }
      }
    }
  }

  return var4;
}

function shouldcqbaim() {
  var0 = self aigettargetspeed();

  if(istrue(self.doingpoi) || isDefined(self.poiauto)) {
    return true;
  }

  if(isDefined(self.demeanoroverride)) {
    if(self.demeanoroverride == "alert") {
      return true;
    }

    if(self.demeanoroverride == "patrol" && isDefined(self.asm.flashlight) && self.asm.flashlight && isDefined(self.cqb_target)) {
      return true;
    }
  }

  return false;
}

function getshootpos(var0) {
  var1 = spawnStruct();

  if(istrue(self.casualkiller)) {
    if(isDefined(self.casualkillershootpos)) {
      var1.shootpos = self.casualkillershootpos;
      var1.bforceaim = 1;
      return var1;
    }

    return undefined;
  }

  if(shouldcqbaim()) {
    var2 = trackloop_cqbshootpos(var0);

    if(isDefined(var2.shootpos)) {
      return var2;
    }
  }

  if(!scripts\asm\asm_bb::bb_shootparamsvalid()) {
    return undefined;
  } else if(isDefined(self._blackboard.shootparams_ent) && istrue(self._blackboard.shootparams_buseentinshootcalc)) {
    var1.shootpos = self._blackboard.shootparams_ent getshootatpos();
  } else if(isDefined(self._blackboard.shootparams_pos)) {
    var1.shootpos = self._blackboard.shootparams_pos;
  }

  if(isDefined(var1.shootpos)) {
    if(istrue(self._blackboard.shootparams_forceaim)) {
      var1.bforceaim = 1;
    }

    return var1;
  }

  return undefined;
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

  var0 = 100;
  var0 *= 2;
  var1 = gettime();

  if(self.asm.aimstarttime + var0 < var1) {
    return true;
  }

  return false;
}

function canaimwhilemoving() {
  var0 = self aigettargetspeed();

  if(istrue(self.runngundisableaim)) {
    return false;
  }

  if(self.stairsstate != "none") {
    return true;
  }

  var1 = scripts\asm\shared\utility::getbasearchetype();

  if(getanimspeedthreshold(var1, "fast") && getanimspeedthreshold(var1, "jog") && var0 < getcoveranglelimits(var1, "fast", "jog", 0.4)) {
    return true;
  }

  if(var1 == "juggernaut" || var1 == "juggernaut_cp" || var1 == "juggernaut_lw") {
    return (var0 < 60);
  }

  if(istrue(self.runngun)) {
    return true;
  }

  return false;
}

function trackloop(var0) {
  self endon("death");
  self.asm.prevyawdelta = 0;
  self.asm.prevpitchdelta = 0;
  var1 = (0, 0, 0);
  var2 = 1;
  var3 = 0;
  var4 = 0;
  var5 = 10;

  for(;;) {
    incranimaimweight();
    var6 = scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "aim");

    if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16 && !canaimwhilemoving()) {
      var6 = 0;
    }

    var7 = 0;

    if(!var6 && scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "notetrackAim")) {
      var6 = scripts\asm\asm::asm_eventfired(self.asm.trackasm, "start_aim");
    }

    if(!var6 || !istrue(self._blackboard.shootparams_valid)) {
      if(!var6 && isDefined(self.convergence)) {
        clearconvergence();
      }

      trackturnofflaser();
      self.asm.aimstarttime = undefined;
    } else if(!isDefined(self.asm.aimstarttime)) {
      self.asm.aimstarttime = gettime();
    }

    var1 = (0, 0, 0);
    var8 = undefined;
    var9 = undefined;

    if(var6) {
      var9 = scripts\asm\shared\utility::getshootfrompos();
      var8 = getshootpos(var9);
      var10 = undefined;

      if(isDefined(var8)) {
        var10 = var8.shootpos;
        var7 = istrue(var8.busingcqbpoi);
      }

      if(isDefined(self.aimspeedoverride)) {
        self setaimstate(self.aimspeedoverride);
      } else if(var7 || !isDefined(var10)) {
        self setaimstate(6);
      } else if(!isDefined(var10)) {
        self setaimstate(3);
      } else {
        self setaimstate(1);
      }

      var11 = self getturret();
      var12 = isDefined(var11);

      if(var12) {
        var13 = var11 turretgetaim();
        var14 = anglesToForward(self.angles);
        var15 = rotatevector(var14, var13);
        var10 = var9 + var15 * 512;
      } else if(scripts\asm\asm_bb::bb_shootparamsvalid() && isDefined(self._blackboard.shootparams_pos)) {
        if(istrue(self._blackboard.shootparams_bconvergeontarget)) {
          var16 = convergencetargettick();
          var10 = calcconvergencetarget();
          self.convergence.aim_pos = var10;

          if(var16) {
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

      var17 = isDefined(var10);
      var18 = (0, 0, 0);

      if(var17) {
        var18 = var10;
      }

      var21 = 0;
      var22 = isDefined(self.stepoutyaw);

      if(var22) {
        var21 = self.stepoutyaw;
      }

      var23 = 0;
      var24 = 0;
      var25 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var25) && scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed") {
        var26 = scripts\asm\asm_bb::bb_getrequestedcoverexposetype();

        if(isDefined(var26)) {
          var27 = scripts\asm\shared\utility::getbasearchetype();
          var23 = scripts\asm\shared\utility::getnodeaimyawoffset(var27, var25, var26);
          var24 = scripts\asm\shared\utility::getnodeaimpitchoffset(var27, var25, var26);
        }
      } else if(istrue(self.aimingdown)) {
        var27 = scripts\asm\shared\utility::getbasearchetype();
        var24 = anim.nodeexposedpitches[var27]["Aim Down"];
      } else if(self.asm.archetype == "boss" || self.asm.archetype == "boss2") {
        var23 = -12;
        var28 = 10;
      }

      var29 = (var24, var23, 0);
      var30 = self getaimangle();
      var31 = self aigetworldweaponoffset();
      var9 += var31;

      if(self iscurrentenemyvalid() || isDefined(var8) && isDefined(var8.bforceaim) && var8.bforceaim) {
        var1 = self setaimangles(var9, var18, var17, var29, var21, var22, 1);
      } else {
        var1 = self setaimangles((0, 0, 0));
      }

      if(anglesdelta(var30, var1) > 12) {
        self.baimedataimtarget = 0;
      }
    } else if(abs(self.asm.prevyawdelta) < 5 && abs(self.asm.prevpitchdelta) < 5) {
      self setaimangles((0, 0, 0));
      self setaimstate(3);
      self.baimedataimtarget = 0;
      waitframe();
      continue;
    }

    if(self asmcurrentstatehasaimset(self.asm.trackasm)) {
      if(isDefined(var8) && isDefined(var8.shootpos)) {
        if(istrue(self.doingpoi)) {
          var35 = self getmuzzledir();
          var36 = vectorNormalize(var8.shootpos - var9);
          var37 = vectordot(var35, var36);

          if(var37 >= 0.966) {
            self.a.laseron = 1;
            scripts\anim\shared::updatelaserstatus();
          }
        }
      }

      waitframe();
      continue;
    }

    if(istrue(self.runngun)) {
      waitframe();
      continue;
    }

    var38 = var1[0];
    var39 = var1[1];
    var1 = undefined;

    if(var4 > 0) {
      var4 -= 1;
      var5 = max(10, var5 - 5);
    } else if(self.relativedir && self.relativedir != var3) {
      var4 = 2;
      var5 = 30;
    } else if(scripts\anim\utility_common::isasniper()) {
      var5 = 2;
    } else if(var7) {
      var5 = 5;
    } else {
      var5 = 10;
    }

    var40 = 4;
    var3 = self.relativedir;
    var41 = self.movemode != "stop" || !var2;

    if(var41) {
      var42 = var39 - self.asm.prevyawdelta;

      if(squared(var42) > var40) {
        var43 = var42 * 0.4;
        var39 = self.asm.prevyawdelta + clamp(var43, -1 * var5, var5);
        var39 = clamp(var39, self.rightaimlimit, self.leftaimlimit);
      }

      var44 = var38 - self.asm.prevpitchdelta;

      if(squared(var44) > var40) {
        var45 = var44 * 0.4;
        var38 = self.asm.prevpitchdelta + clamp(var45, -1 * var5, var5);
        var38 = clamp(var38, self.upaimlimit, self.downaimlimit);
      }
    }

    var2 = 0;
    self.asm.prevyawdelta = var39;
    self.asm.prevpitchdelta = var38;

    if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking) {
      trackloop_setanimweightslmg(var38, var39);
    } else {
      trackloop_setanimweights(var38, var39);
    }

    wait 0.05;
  }
}

function trackloop_restoreaim() {
  if(!isDefined(self.asm.prevyawdelta)) {
    return;
  }

  var0 = clamp(self.asm.prevyawdelta, self.rightaimlimit, self.leftaimlimit);
  var1 = clamp(self.asm.prevpitchdelta, self.upaimlimit, self.downaimlimit);

  if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking) {
    trackloop_setanimweightslmg(var1, var0);
    return;
  }

  trackloop_setanimweights(var1, var0);
}

function trackloop_cqbshootpos(var0) {
  var1 = undefined;
  var2 = anglesToForward(self.angles);
  var3 = 0;

  if(isDefined(self.cqb_target)) {
    if(isvector(self.cqb_target)) {
      var1 = self.cqb_target;
    } else {
      var1 = self.cqb_target getshootatpos();
    }

    if(isDefined(self.cqb_wide_target_track)) {
      if(vectordot(vectorNormalize(var1 - var0), var2) < 0.177) {
        var1 = undefined;
      }
    } else if(vectordot(vectorNormalize(var1 - var0), var2) < 0.643) {
      var1 = undefined;
    }
  }

  if(!isDefined(var1)) {
    var3 = 1;
  }

  if(!isDefined(var1)) {
    if(!isDefined(self.cqb_point_of_interest) && isDefined(self.currentpoi)) {
      setpoi(undefined);
      self.a.laseron = 0;
      scripts\anim\shared::updatelaserstatus();
    } else if(isDefined(self.cqb_point_of_interest)) {
      if(!scripts\engine\utility::is_equal(self.cqb_point_of_interest, self.currentpoi)) {
        setpoi(self.cqb_point_of_interest);

        if(!istrue(self.currentpoi.islookatonly)) {
          var1 = self.currentpoi.origin;
          self.a.laseron = 0;
          scripts\anim\shared::updatelaserstatus();
        }
      } else if(!istrue(self.currentpoi.islookatonly)) {
        var1 = self.currentpoi.origin;
      }
    }
  }

  if(isDefined(self.poiauto)) {
    var1 = poiauto_getshootpos();
  }

  if(!isDefined(var1) && isDefined(self.pathgoalpos) && !isDefined(self.enemy) && self.facemotion) {
    var4 = self getposonpath(self.lookandaimdownpathdist);
    var5 = var4 - self.origin;
    var5 = vectorNormalize((var5[0], var5[1], 0));

    if(vectordot(var2, var5) < 0.9994) {
      var1 = var4 + (0, 0, 54);
    }
  }

  var6 = spawnStruct();
  var6.shootpos = var1;
  var6.busingcqbpoi = var3;
  var6.bforceaim = 1;
  return var6;
}

function poiauto_getshootpos() {
  if(isDefined(self.poiauto_nextaimtime) && gettime() > self.poiauto_nextaimtime) {
    self.poiauto_angles = self.poiauto_nextangles;
    self.poiauto_nextaimtime = undefined;
    self.poiauto_nextangles = undefined;
  }

  var0 = undefined;

  if(isDefined(self.poiauto_angles)) {
    var0 = scripts\asm\shared\utility::poiauto_relativeangletopos(self.poiauto_angles);
  }

  if(!istrue(self.poiauto.glancing)) {
    if(isDefined(self.poiauto_nextangles)) {
      var1 = scripts\asm\shared\utility::poiauto_relativeangletopos(self.poiauto_nextangles);
      scripts\common\utility::lookatpos(var1, 0);
    } else {
      scripts\common\utility::lookatpos(var0, 0);
    }
  }

  return var0;
}

function setpoi(var0) {
  if(!isDefined(var0)) {
    self.currentpoi = undefined;
    self._blackboard.forcestrafe = 0;
    self stoplookat();
    return;
  }

  if(istrue(var0.islookatonly)) {
    self glanceatpos(var0.origin, var0.lookatduration);
  } else {
    self._blackboard.forcestrafe = istrue(var0.script_poi_forcestrafe);
    self._blackboard.forcestrafefacingpos = var0.origin;
    self setlookat(var0.origin);
  }

  var1 = gettime();
  self.poi_starttime = var1;
  var0.lastusedtime = var1;
  self.currentpoi = var0;
}

function trackloop_setanimweights(var0, var1) {
  var2 = undefined;

  if(isDefined(self.asm.track.aim_2)) {
    var3 = self.asm.track.aim_2;
    var4 = self.asm.track.aim_4;
    var5 = self.asm.track.aim_6;
    var6 = self.asm.track.aim_8;
  } else {
    var3 = self.asm.track.aim_2_default;
    var4 = self.asm.track.aim_4_default;
    var5 = self.asm.track.aim_6_default;
    var6 = self.asm.track.aim_8_default;
  }

  if(isDefined(self.asm.track.aim_5)) {
    var6 = self.asm.track.aim_5;
  }

  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = 0;

  if(var5 < 0) {
    var10 = var5 / self.rightaimlimit * self.a.aimweight;
    var9 = 1;
  } else if(var5 > 0) {
    var8 = var5 / self.leftaimlimit * self.a.aimweight;
    var9 = 1;
  }

  if(var4 < 0) {
    var11 = var4 / self.upaimlimit * self.a.aimweight;
    var9 = 1;
  } else if(var4 > 0) {
    var7 = var4 / self.downaimlimit * self.a.aimweight;
    var9 = 1;
  }

  self aisetanimlimited(var3, var7, 0.1, 1, 1);
  self aisetanimlimited(var4, var8, 0.1, 1, 1);
  self aisetanimlimited(var5, var10, 0.1, 1, 1);
  self aisetanimlimited(var6, var11, 0.1, 1, 1);

  if(isDefined(var6)) {
    self aisetanimlimited(var6, var9, 0.1, 1, 1);
    return;
  }
}

function trackloop_setanimweightslmg(var0, var1) {
  var2 = self.asm.track.lmg_aim_1;
  var3 = self.asm.track.lmg_aim_2;
  var4 = self.asm.track.lmg_aim_3;
  var5 = self.asm.track.lmg_aim_4;
  var6 = self.asm.track.lmg_aim_6;
  var7 = self.asm.track.lmg_aim_7;
  var8 = self.asm.track.lmg_aim_8;
  var9 = self.asm.track.lmg_aim_9;
  var10 = [var6, var9, var8, var7, var5, var2, var3, var4, var6];
  var11 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  var12 = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  var13 = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  var14 = (var1, var0, 0);
  var15 = length2d(var14);
  var16 = vectorNormalize(var14);
  var17 = vectortoyaw(var16);
  var17 = angleclamp180(var17);

  for(var18 = 0; var17 > var11[var18]; var18++) {}

  if(var18 == 0) {
    var18 = 1;
  }

  var19 = self.asm.track.lmg_aim_state;

  for(var20 = 0; var20 < var10.size; var20++) {
    if(var20 == var18 || var20 == var18 - 1) {
      var21 = clamp(var15 / var13[var20], 0, 1);
      var22 = acos(vectordot(var12[var20], var16));
      var23 = clamp(1 - var22 / var13[var20], 0, 1);
      var24 = scripts\asm\asm::asm_getxanim(var19, var10[var20]);
      var25 = self aigetanimtime(var24);

      if(var25 > 0) {
        var26 = getanimlength(var24);
        var27 = (var21 - var25) * var26 / 0.05;
        self aisetanimlimited(var24, var23, 0.05, var27);
      } else {
        self aisetanimlimited(var24, var23, 0.05, 0);
        self aisetanimtime(var24, var21);
      }

      continue;
    }

    if(var10[var20] != var10[var18] && var10[var20] != var10[var18 - 1]) {
      self aiclearanim(scripts\asm\asm::asm_getxanim(var19, var10[var20]), 0.05);
    }
  }
}

function setanimaimweight(var0, var1) {
  if(!isDefined(var1) || var1 <= 0) {
    self.a.aimweight = var0;
    self.a.aimweight_start = var0;
    self.a.aimweight_end = var0;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight)) {
      self.a.aimweight = 0;
    }

    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = var0;
    self.a.aimweight_transframes = int(var1 * 20);
  }

  self.a.aimweight_t = 0;
}

function incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    var0 = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - var0) + self.a.aimweight_end * var0;
    return;
  }
}

function aimedataimtarget() {
  if(scripts\asm\asm_bb::bb_shootparams_empty()) {
    self.baimedataimtarget = 1;
    return true;
  }

  if(istrue(self.runngun) && istrue(self.runngundisableaim)) {
    self.baimedataimtarget = 0;
    return false;
  }

  if(istrue(self.casualkiller) && !istrue(self.leavecasualkiller)) {
    self.baimedataimtarget = 1;
    return true;
  }

  if(istrue(self._blackboard.shootparams_bconvergeontarget)) {
    if(!isDefined(self.convergence)) {
      self.baimedataimtarget = 0;
      return false;
    }

    if(isDefined(self.convergence.converge_locked_on_time)) {
      var0 = gettime() - self.convergence.converge_locked_on_time;

      if(var0 >= self.convergence.lock_duration_before_firing) {
        self.baimedataimtarget = 1;
        return true;
      }
    } else if(self.convergence.converge_curtime >= self.convergence.converge_shoottime) {
      self.baimedataimtarget = 1;
      return true;
    }

    self.baimedataimtarget = 0;
    return false;
  }

  if(!self isinscriptedstate()) {
    var1 = !scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "aim");

    if(!var1 && scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "notetrackAim")) {
      var1 = !scripts\asm\asm::asm_eventfired(self.asm.trackasm, "start_aim");
    }

    if(!var1) {
      var1 = isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16 && !canaimwhilemoving();
    }

    if(var1) {
      self.baimedataimtarget = 0;
      return false;
    }
  }

  var2 = scripts\asm\shared\utility::getshootfrompos();
  var3 = getshootpos(var2);

  if(!isDefined(var3)) {
    self.baimedataimtarget = 0;
    return false;
  }

  var4 = var3.shootpos;
  var5 = self getturret();

  if(scripts\engine\utility::actor_is3d()) {
    var6 = self getmuzzledir();
    var7 = rotatevectorinverted(var6, self.angles);
    var8 = vectortoangles(var7);
    var9 = var4 - var2;
    var10 = rotatevectorinverted(var9, self.angles);
    var11 = vectortoangles(var10);
  } else if(isDefined(var11)) {
    var12 = var11 getturrettarget(1);
    self.baimedataimtarget = isDefined(var12);
    return isDefined(var12);
  } else {
    jumpiffalse(istrue(self.runngun)) LOC_00000203;
    var11 = vectortoangles(var11 - var5);
    var8 = self getmuzzleangle();
    goto LOC_00000243;
  }

  LOC_00000243:
    var13 = anim.aimyawdifffartolerance;
  var14 = anim.aimyawdiffclosetolerance;
  var15 = anim.aimpitchdifftolerance;
  var16 = scripts\engine\utility::absangleclamp180(var8[1] - var11[1]);

  if(var16 > var13) {
    if(var16 > var14 || distancesquared(self getapproxeyepos(), var8) > anim.aimyawdiffclosedistsq) {
      self.baimedataimtarget = 0;
      return false;
    }
  }

  var17 = scripts\engine\utility::absangleclamp180(var8[0] - var11[0]);

  if(var17 > var15) {
    self.baimedataimtarget = 0;
    return false;
  }

  self.baimedataimtarget = 1;
  return true;
}

function setglobalaimsettings() {
  anim.covercrouchleanpitch = 55;
  anim.aimyawdifffartolerance = 10;
  anim.aimyawdiffclosedistsq = 4096;
  anim.aimyawdiffclosetolerance = 45;
  anim.aimpitchdifftolerance = 20;
  anim.painyawdifffartolerance = 25;
  anim.painyawdiffclosedistsq = anim.aimyawdiffclosedistsq;
  anim.painyawdiffclosetolerance = anim.aimyawdiffclosetolerance;
  anim.painpitchdifftolerance = 30;
  anim.maxanglecheckyawdelta = 65;
  anim.maxanglecheckpitchdelta = 65;
}