/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\track.gsc
***********************************************/

function track(var_0) {
  self endon("asm_terminated");
  setglobalaimsettings();
  self.asm.trackasm = var_0;
  var_1 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_2"));
  var_2 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_4"));
  var_3 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_6"));
  var_4 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_8"));
  trackinit(var_1, var_2, var_3, var_4);
  trackloop(var_0);
}

function trackinit(var_0, var_1, var_2, var_3) {
  self.a.aimweight = 1;
  self.a.aimweight_start = 1;
  self.a.aimweight_end = 1;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  var_4 = spawnStruct();
  var_4.aim_2_default = var_0;
  var_4.aim_4_default = var_1;
  var_4.aim_6_default = var_2;
  var_4.aim_8_default = var_3;
  self.asm.track = var_4;
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
  var_0 = getweaponbasename(self.weapon);

  switch (var_0) {
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
      var_0 = self gettagorigin("tag_laser", 1);

      if(isDefined(var_0)) {
        self.bhaslasertag = 1;
        return var_0;
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
  var_0 = getlaserstartpoint();
  self.sniper_laser = spawn("script_model", var_0);
  self.sniper_laser setModel("tag_laser");
  self.sniper_laser setmoverlaserweapon(self.weapon);
  self.sniper_laser setotherent(self);
  self.sniper_laser.origin = var_0;
  self[[self.fnsetlaserflag]]("interpolate");
  self.sniper_laser[[self.fnlaseron]]();

  while(isalive(self) && isDefined(self.sniper_laser)) {
    if(isDefined(self.convergence.aim_pos)) {
      var_0 = getlaserstartpoint();
      self.sniper_laser.origin = var_0;
      var_1 = self.convergence.aim_pos;
      var_2 = vectorNormalize(var_1 - var_0);
      var_3 = getlaserdirection();
      var_2 = vectorNormalize((var_2[0], var_2[1], 0));
      var_3 = vectorNormalize((var_3[0], var_3[1], 0));
      var_4 = vectordot(var_2, var_3);

      if(var_4 < 0.996) {
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

function resetconvergence(var_0, var_1, var_2) {
  if(!isDefined(self.convergence)) {
    self.convergence = spawnStruct();
  }

  self.convergence.sniper_fired = undefined;
  self.convergence.target = self._blackboard.shootparams_ent;
  self.convergence.converge_missouterradius = 96;

  if(var_0) {
    self.convergence.converge_time = 1500;
  } else if(istrue(var_2)) {
    self.convergence.converge_time = 1500;
  } else {
    self.convergence.converge_time = 2000;
  }

  self[[self.fnsetlaserflag]]("interpolate");
  var_3 = scripts\common\gameskill::get_skill_from_index(level.gameskill);
  var_4 = level.difficultysettings["sniper_converge_scale"][var_3];

  if(isDefined(var_4)) {
    self.convergence.converge_time *= var_4;
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
    var_5 = undefined;
    var_6 = undefined;

    if(isDefined(var_1)) {
      var_5 = var_1;
    } else {
      if(isDefined(self._blackboard.shootparams_ent)) {
        var_7 = self._blackboard.shootparams_ent.origin;

        if(isPlayer(self._blackboard.shootparams_ent)) {
          var_6 = self._blackboard.shootparams_ent getvelocity();

          if(var_6 == (0, 0, 0)) {
            var_6 = undefined;
          }
        }
      } else {
        var_7 = self._blackboard.shootparams_pos - (0, 0, 70);
      }

      var_8 = var_7 - self.origin;
      var_8 = (var_8[0], var_8[1], 0);
      var_9 = vectorNormalize(var_8);

      if(istrue(var_3)) {
        var_6 = var_7;
        var_6 += (0, 0, randomfloatrange(12, 36));
      } else {
        var_6 = var_7 - var_9 * randomfloatrange(120, 180);
      }

      var_10 = vectorcross(var_9, (0, 0, 1));
      var_11 = randomfloatrange(6, 36);

      if(istrue(var_3)) {
        var_11 = randomfloatrange(12, 24);
      }

      if(isDefined(var_7)) {
        var_12 = vectordot(var_7, var_10);

        if(var_12 < 0) {
          var_6 += var_10 * var_11;
        } else {
          var_6 -= var_10 * var_11;
        }
      } else if(randomintrange(0, 2)) {
        var_6 += var_10 * var_11;
      } else {
        var_6 -= var_10 * var_11;
      }
    }

    self.convergence.converge_offsetdir = vectorNormalize(var_6 - self._blackboard.shootparams_pos);
    self.convergence.converge_missouterradius = distance(var_6, self._blackboard.shootparams_pos);
    return;
  }
}

function calcconvergencetarget() {
  if(isDefined(self.convergence.converge_locked_on_time) && gettime() - self.convergence.converge_locked_on_time >= 100) {
    var_0 = gettime() - self.convergence.converge_locked_on_time;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
      self[[self.fnsetlaserflag]]("lock");
    } else {
      self[[self.fnsetlaserflag]]("interpolate");
    }

    return (self._blackboard.shootparams_pos - (0, 0, 1.3));
  }

  var_1 = vectorNormalize(self._blackboard.shootparams_pos - self.origin);
  var_2 = vectortoangles(var_1);

  if(self.convergence.converge_curtime < 0) {
    self[[self.fnsetlaserflag]]("interpolate");
    var_3 = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * self.convergence.converge_missouterradius;
    return var_3;
  }

  var_4 = (self.convergence.converge_time - self.convergence.converge_curtime) / self.convergence.converge_time;

  if(self.convergence.converge_curtime >= self.convergence.converge_time) {
    var_4 = 0;
  }

  var_5 = var_4 * (self.convergence.converge_missouterradius - self.convergence.converge_missinnerradius) + self.convergence.converge_missinnerradius;
  var_3 = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * var_5;

  if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
    self[[self.fnsetlaserflag]]("interpolate");
  }

  return var_3;
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

function turnlaserbackon(var_0) {
  self endon("death");
  wait var_0;

  if(isDefined(self.sniper_laser)) {
    self.sniper_laser[[self.fnlaseron]]();
    return;
  }
}

function convergencetargettick() {
  var_0 = 1;
  var_1 = 0;

  if(isDefined(self._blackboard.shootparams_ent)) {
    var_0 = self cansee(self._blackboard.shootparams_ent);

    if(isDefined(self.convergence) && isDefined(self.convergence.target) && self.convergence.target != self._blackboard.shootparams_ent) {
      var_1 = 1;
    }

    if(var_0) {
      scripts\asm\asm_bb::bb_updateshootparams_pos(self._blackboard.shootparams_ent getshootatpos());
    }
  }

  if(!isDefined(self.convergence) || var_1) {
    resetconvergence(var_1);
  } else if(var_0 && !istrue(self.convergence.bhaslos)) {
    if(isDefined(self.convergence.aim_pos) && distancesquared(self.convergence.aim_pos, self._blackboard.shootparams_pos) < 3600) {
      resetconvergence(var_1, undefined, 1);
    } else {
      resetconvergence(var_1);
    }
  } else if(istrue(self.convergence.sniper_fired)) {
    self[[self.fnsetlaserflag]]("interpolate");
    self.convergence.sniper_fired = undefined;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent) && self cansee(self._blackboard.shootparams_ent)) {
      resetconvergence(var_1, undefined, 1);
    }
  }

  self.convergence.bhaslos = var_0;
  var_2 = 1;
  var_3 = getlaserstartpoint();
  var_4 = calcconvergencetarget();
  var_5 = vectorNormalize(var_4 - var_3);
  var_6 = self getmuzzledir();

  if(self.convergence.converge_curtime < 0) {
    if(!isaiming()) {
      return 0;
    }

    self.convergence.converge_curtime += 50;
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0.984) {
      return 0;
    }

    var_5 = vectorNormalize((var_5[0], var_5[1], 0));
    var_6 = vectorNormalize((var_6[0], var_6[1], 0));
    var_8 = vectordot(var_5, var_6);

    if(var_8 < 0.996) {
      return 0;
    }

    self.convergence.converge_curtime = 0;
  } else {
    self.convergence.converge_curtime += 50;
    var_7 = vectordot(var_7, var_8);

    if(var_7 < 0.984) {
      var_4 = 0;
    }

    var_7 = vectorNormalize((var_7[0], var_7[1], 0));
    var_8 = vectorNormalize((var_8[0], var_8[1], 0));
    var_8 = vectordot(var_7, var_8);

    if(var_8 < 0.996) {
      var_4 = 0;
    }
  }

  if(self.convergence.converge_curtime >= self.convergence.converge_time) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      if(!isDefined(self.convergence.converge_locked_on_time)) {
        if(var_2) {
          self.convergence.converge_locked_on_time = gettime();
        }
      } else if(gettime() >= self.convergence.converge_locked_on_time + 200) {
        if(!var_2) {
          self.convergence.converge_locked_on_time = undefined;
        }
      }
    }
  }

  return var_4;
}

function shouldcqbaim() {
  var_0 = self aigettargetspeed();

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

function getshootpos(var_0) {
  var_1 = spawnStruct();

  if(istrue(self.casualkiller)) {
    if(isDefined(self.casualkillershootpos)) {
      var_1.shootpos = self.casualkillershootpos;
      var_1.bforceaim = 1;
      return var_1;
    }

    return undefined;
  }

  if(shouldcqbaim()) {
    var_2 = trackloop_cqbshootpos(var_0);

    if(isDefined(var_2.shootpos)) {
      return var_2;
    }
  }

  if(!scripts\asm\asm_bb::bb_shootparamsvalid()) {
    return undefined;
  } else if(isDefined(self._blackboard.shootparams_ent) && istrue(self._blackboard.shootparams_buseentinshootcalc)) {
    var_1.shootpos = self._blackboard.shootparams_ent getshootatpos();
  } else if(isDefined(self._blackboard.shootparams_pos)) {
    var_1.shootpos = self._blackboard.shootparams_pos;
  }

  if(isDefined(var_1.shootpos)) {
    if(istrue(self._blackboard.shootparams_forceaim)) {
      var_1.bforceaim = 1;
    }

    return var_1;
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

  var_0 = 100;
  var_0 *= 2;
  var_1 = gettime();

  if(self.asm.aimstarttime + var_0 < var_1) {
    return true;
  }

  return false;
}

function canaimwhilemoving() {
  var_0 = self aigettargetspeed();

  if(istrue(self.runngundisableaim)) {
    return false;
  }

  if(self.stairsstate != "none") {
    return true;
  }

  var_1 = scripts\asm\shared\utility::getbasearchetype();

  if(getanimspeedthreshold(var_1, "fast") && getanimspeedthreshold(var_1, "jog") && var_0 < getcoveranglelimits(var_1, "fast", "jog", 0.4)) {
    return true;
  }

  if(var_1 == "juggernaut" || var_1 == "juggernaut_cp" || var_1 == "juggernaut_lw") {
    return (var_0 < 60);
  }

  if(istrue(self.runngun)) {
    return true;
  }

  return false;
}

function trackloop(var_0) {
  self endon("death");
  self.asm.prevyawdelta = 0;
  self.asm.prevpitchdelta = 0;
  var_1 = (0, 0, 0);
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 10;

  for(;;) {
    incranimaimweight();
    var_6 = scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "aim");

    if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16 && !canaimwhilemoving()) {
      var_6 = 0;
    }

    var_7 = 0;

    if(!var_6 && scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "notetrackAim")) {
      var_6 = scripts\asm\asm::asm_eventfired(self.asm.trackasm, "start_aim");
    }

    if(!var_6 || !istrue(self._blackboard.shootparams_valid)) {
      if(!var_6 && isDefined(self.convergence)) {
        clearconvergence();
      }

      trackturnofflaser();
      self.asm.aimstarttime = undefined;
    } else if(!isDefined(self.asm.aimstarttime)) {
      self.asm.aimstarttime = gettime();
    }

    var_1 = (0, 0, 0);
    var_8 = undefined;
    var_9 = undefined;

    if(var_6) {
      var_9 = scripts\asm\shared\utility::getshootfrompos();
      var_8 = getshootpos(var_9);
      var_10 = undefined;

      if(isDefined(var_8)) {
        var_10 = var_8.shootpos;
        var_7 = istrue(var_8.busingcqbpoi);
      }

      if(isDefined(self.aimspeedoverride)) {
        self setaimstate(self.aimspeedoverride);
      } else if(var_7 || !isDefined(var_10)) {
        self setaimstate(6);
      } else if(!isDefined(var_10)) {
        self setaimstate(3);
      } else {
        self setaimstate(1);
      }

      var_11 = self getturret();
      var_12 = isDefined(var_11);

      if(var_12) {
        var_13 = var_11 turretgetaim();
        var_14 = anglesToForward(self.angles);
        var_15 = rotatevector(var_14, var_13);
        var_10 = var_9 + var_15 * 512;
      } else if(scripts\asm\asm_bb::bb_shootparamsvalid() && isDefined(self._blackboard.shootparams_pos)) {
        if(istrue(self._blackboard.shootparams_bconvergeontarget)) {
          var_16 = convergencetargettick();
          var_10 = calcconvergencetarget();
          self.convergence.aim_pos = var_10;

          if(var_16) {
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

      var_17 = isDefined(var_10);
      var_18 = (0, 0, 0);

      if(var_17) {
        var_18 = var_10;
      }

      var_21 = 0;
      var_22 = isDefined(self.stepoutyaw);

      if(var_22) {
        var_21 = self.stepoutyaw;
      }

      var_23 = 0;
      var_24 = 0;
      var_25 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var_25) && scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed") {
        var_26 = scripts\asm\asm_bb::bb_getrequestedcoverexposetype();

        if(isDefined(var_26)) {
          var_27 = scripts\asm\shared\utility::getbasearchetype();
          var_23 = scripts\asm\shared\utility::getnodeaimyawoffset(var_27, var_25, var_26);
          var_24 = scripts\asm\shared\utility::getnodeaimpitchoffset(var_27, var_25, var_26);
        }
      } else if(istrue(self.aimingdown)) {
        var_27 = scripts\asm\shared\utility::getbasearchetype();
        var_24 = anim.nodeexposedpitches[var_27]["Aim Down"];
      } else if(self.asm.archetype == "boss" || self.asm.archetype == "boss2") {
        var_23 = -12;
        var_28 = 10;
      }

      var_29 = (var_24, var_23, 0);
      var_30 = self getaimangle();
      var_31 = self aigetworldweaponoffset();
      var_9 += var_31;

      if(self iscurrentenemyvalid() || isDefined(var_8) && isDefined(var_8.bforceaim) && var_8.bforceaim) {
        var_1 = self setaimangles(var_9, var_18, var_17, var_29, var_21, var_22, 1);
      } else {
        var_1 = self setaimangles((0, 0, 0));
      }

      if(anglesdelta(var_30, var_1) > 12) {
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
      if(isDefined(var_8) && isDefined(var_8.shootpos)) {
        if(istrue(self.doingpoi)) {
          var_35 = self getmuzzledir();
          var_36 = vectorNormalize(var_8.shootpos - var_9);
          var_37 = vectordot(var_35, var_36);

          if(var_37 >= 0.966) {
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

    var_38 = var_1[0];
    var_39 = var_1[1];
    var_1 = undefined;

    if(var_4 > 0) {
      var_4 -= 1;
      var_5 = max(10, var_5 - 5);
    } else if(self.relativedir && self.relativedir != var_3) {
      var_4 = 2;
      var_5 = 30;
    } else if(scripts\anim\utility_common::isasniper()) {
      var_5 = 2;
    } else if(var_7) {
      var_5 = 5;
    } else {
      var_5 = 10;
    }

    var_40 = 4;
    var_3 = self.relativedir;
    var_41 = self.movemode != "stop" || !var_2;

    if(var_41) {
      var_42 = var_39 - self.asm.prevyawdelta;

      if(squared(var_42) > var_40) {
        var_43 = var_42 * 0.4;
        var_39 = self.asm.prevyawdelta + clamp(var_43, -1 * var_5, var_5);
        var_39 = clamp(var_39, self.rightaimlimit, self.leftaimlimit);
      }

      var_44 = var_38 - self.asm.prevpitchdelta;

      if(squared(var_44) > var_40) {
        var_45 = var_44 * 0.4;
        var_38 = self.asm.prevpitchdelta + clamp(var_45, -1 * var_5, var_5);
        var_38 = clamp(var_38, self.upaimlimit, self.downaimlimit);
      }
    }

    var_2 = 0;
    self.asm.prevyawdelta = var_39;
    self.asm.prevpitchdelta = var_38;

    if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking) {
      trackloop_setanimweightslmg(var_38, var_39);
    } else {
      trackloop_setanimweights(var_38, var_39);
    }

    wait 0.05;
  }
}

function trackloop_restoreaim() {
  if(!isDefined(self.asm.prevyawdelta)) {
    return;
  }

  var_0 = clamp(self.asm.prevyawdelta, self.rightaimlimit, self.leftaimlimit);
  var_1 = clamp(self.asm.prevpitchdelta, self.upaimlimit, self.downaimlimit);

  if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking) {
    trackloop_setanimweightslmg(var_1, var_0);
    return;
  }

  trackloop_setanimweights(var_1, var_0);
}

function trackloop_cqbshootpos(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);
  var_3 = 0;

  if(isDefined(self.cqb_target)) {
    if(isvector(self.cqb_target)) {
      var_1 = self.cqb_target;
    } else {
      var_1 = self.cqb_target getshootatpos();
    }

    if(isDefined(self.cqb_wide_target_track)) {
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643) {
      var_1 = undefined;
    }
  }

  if(!isDefined(var_1)) {
    var_3 = 1;
  }

  if(!isDefined(var_1)) {
    if(!isDefined(self.cqb_point_of_interest) && isDefined(self.currentpoi)) {
      setpoi(undefined);
      self.a.laseron = 0;
      scripts\anim\shared::updatelaserstatus();
    } else if(isDefined(self.cqb_point_of_interest)) {
      if(!scripts\engine\utility::is_equal(self.cqb_point_of_interest, self.currentpoi)) {
        setpoi(self.cqb_point_of_interest);

        if(!istrue(self.currentpoi.islookatonly)) {
          var_1 = self.currentpoi.origin;
          self.a.laseron = 0;
          scripts\anim\shared::updatelaserstatus();
        }
      } else if(!istrue(self.currentpoi.islookatonly)) {
        var_1 = self.currentpoi.origin;
      }
    }
  }

  if(isDefined(self.poiauto)) {
    var_1 = poiauto_getshootpos();
  }

  if(!isDefined(var_1) && isDefined(self.pathgoalpos) && !isDefined(self.enemy) && self.facemotion) {
    var_4 = self getposonpath(self.lookandaimdownpathdist);
    var_5 = var_4 - self.origin;
    var_5 = vectorNormalize((var_5[0], var_5[1], 0));

    if(vectordot(var_2, var_5) < 0.9994) {
      var_1 = var_4 + (0, 0, 54);
    }
  }

  var_6 = spawnStruct();
  var_6.shootpos = var_1;
  var_6.busingcqbpoi = var_3;
  var_6.bforceaim = 1;
  return var_6;
}

function poiauto_getshootpos() {
  if(isDefined(self.poiauto_nextaimtime) && gettime() > self.poiauto_nextaimtime) {
    self.poiauto_angles = self.poiauto_nextangles;
    self.poiauto_nextaimtime = undefined;
    self.poiauto_nextangles = undefined;
  }

  var_0 = undefined;

  if(isDefined(self.poiauto_angles)) {
    var_0 = scripts\asm\shared\utility::poiauto_relativeangletopos(self.poiauto_angles);
  }

  if(!istrue(self.poiauto.glancing)) {
    if(isDefined(self.poiauto_nextangles)) {
      var_1 = scripts\asm\shared\utility::poiauto_relativeangletopos(self.poiauto_nextangles);
      scripts\common\utility::lookatpos(var_1, 0);
    } else {
      scripts\common\utility::lookatpos(var_0, 0);
    }
  }

  return var_0;
}

function setpoi(var_0) {
  if(!isDefined(var_0)) {
    self.currentpoi = undefined;
    self._blackboard.forcestrafe = 0;
    self stoplookat();
    return;
  }

  if(istrue(var_0.islookatonly)) {
    self glanceatpos(var_0.origin, var_0.lookatduration);
  } else {
    self._blackboard.forcestrafe = istrue(var_0.script_poi_forcestrafe);
    self._blackboard.forcestrafefacingpos = var_0.origin;
    self setlookat(var_0.origin);
  }

  var_1 = gettime();
  self.poi_starttime = var_1;
  var_0.lastusedtime = var_1;
  self.currentpoi = var_0;
}

function trackloop_setanimweights(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.asm.track.aim_2)) {
    var_3 = self.asm.track.aim_2;
    var_4 = self.asm.track.aim_4;
    var_5 = self.asm.track.aim_6;
    var_6 = self.asm.track.aim_8;
  } else {
    var_3 = self.asm.track.aim_2_default;
    var_4 = self.asm.track.aim_4_default;
    var_5 = self.asm.track.aim_6_default;
    var_6 = self.asm.track.aim_8_default;
  }

  if(isDefined(self.asm.track.aim_5)) {
    var_6 = self.asm.track.aim_5;
  }

  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  if(var_5 < 0) {
    var_10 = var_5 / self.rightaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_5 > 0) {
    var_8 = var_5 / self.leftaimlimit * self.a.aimweight;
    var_9 = 1;
  }

  if(var_4 < 0) {
    var_11 = var_4 / self.upaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_4 > 0) {
    var_7 = var_4 / self.downaimlimit * self.a.aimweight;
    var_9 = 1;
  }

  self aisetanimlimited(var_3, var_7, 0.1, 1, 1);
  self aisetanimlimited(var_4, var_8, 0.1, 1, 1);
  self aisetanimlimited(var_5, var_10, 0.1, 1, 1);
  self aisetanimlimited(var_6, var_11, 0.1, 1, 1);

  if(isDefined(var_6)) {
    self aisetanimlimited(var_6, var_9, 0.1, 1, 1);
    return;
  }
}

function trackloop_setanimweightslmg(var_0, var_1) {
  var_2 = self.asm.track.lmg_aim_1;
  var_3 = self.asm.track.lmg_aim_2;
  var_4 = self.asm.track.lmg_aim_3;
  var_5 = self.asm.track.lmg_aim_4;
  var_6 = self.asm.track.lmg_aim_6;
  var_7 = self.asm.track.lmg_aim_7;
  var_8 = self.asm.track.lmg_aim_8;
  var_9 = self.asm.track.lmg_aim_9;
  var_10 = [var_6, var_9, var_8, var_7, var_5, var_2, var_3, var_4, var_6];
  var_11 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  var_12 = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  var_13 = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  var_14 = (var_1, var_0, 0);
  var_15 = length2d(var_14);
  var_16 = vectorNormalize(var_14);
  var_17 = vectortoyaw(var_16);
  var_17 = angleclamp180(var_17);

  for(var_18 = 0; var_17 > var_11[var_18]; var_18++) {}

  if(var_18 == 0) {
    var_18 = 1;
  }

  var_19 = self.asm.track.lmg_aim_state;

  for(var_20 = 0; var_20 < var_10.size; var_20++) {
    if(var_20 == var_18 || var_20 == var_18 - 1) {
      var_21 = clamp(var_15 / var_13[var_20], 0, 1);
      var_22 = acos(vectordot(var_12[var_20], var_16));
      var_23 = clamp(1 - var_22 / var_13[var_20], 0, 1);
      var_24 = scripts\asm\asm::asm_getxanim(var_19, var_10[var_20]);
      var_25 = self aigetanimtime(var_24);

      if(var_25 > 0) {
        var_26 = getanimlength(var_24);
        var_27 = (var_21 - var_25) * var_26 / 0.05;
        self aisetanimlimited(var_24, var_23, 0.05, var_27);
      } else {
        self aisetanimlimited(var_24, var_23, 0.05, 0);
        self aisetanimtime(var_24, var_21);
      }

      continue;
    }

    if(var_10[var_20] != var_10[var_18] && var_10[var_20] != var_10[var_18 - 1]) {
      self aiclearanim(scripts\asm\asm::asm_getxanim(var_19, var_10[var_20]), 0.05);
    }
  }
}

function setanimaimweight(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a.aimweight = var_0;
    self.a.aimweight_start = var_0;
    self.a.aimweight_end = var_0;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight)) {
      self.a.aimweight = 0;
    }

    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = var_0;
    self.a.aimweight_transframes = int(var_1 * 20);
  }

  self.a.aimweight_t = 0;
}

function incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    var_0 = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - var_0) + self.a.aimweight_end * var_0;
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
      var_0 = gettime() - self.convergence.converge_locked_on_time;

      if(var_0 >= self.convergence.lock_duration_before_firing) {
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
    var_1 = !scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "aim");

    if(!var_1 && scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "notetrackAim")) {
      var_1 = !scripts\asm\asm::asm_eventfired(self.asm.trackasm, "start_aim");
    }

    if(!var_1) {
      var_1 = isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16 && !canaimwhilemoving();
    }

    if(var_1) {
      self.baimedataimtarget = 0;
      return false;
    }
  }

  var_2 = scripts\asm\shared\utility::getshootfrompos();
  var_3 = getshootpos(var_2);

  if(!isDefined(var_3)) {
    self.baimedataimtarget = 0;
    return false;
  }

  var_4 = var_3.shootpos;
  var_5 = self getturret();

  if(scripts\engine\utility::actor_is3d()) {
    var_6 = self getmuzzledir();
    var_7 = rotatevectorinverted(var_6, self.angles);
    var_8 = vectortoangles(var_7);
    var_9 = var_4 - var_2;
    var_10 = rotatevectorinverted(var_9, self.angles);
    var_11 = vectortoangles(var_10);
  } else if(isDefined(var_11)) {
    var_12 = var_11 getturrettarget(1);
    self.baimedataimtarget = isDefined(var_12);
    return isDefined(var_12);
  } else {
    jumpiffalse(istrue(self.runngun)) LOC_00000203;
    var_11 = vectortoangles(var_11 - var_5);
    var_8 = self getmuzzleangle();
    goto LOC_00000243;
  }

  LOC_00000243:
    var_13 = anim.aimyawdifffartolerance;
  var_14 = anim.aimyawdiffclosetolerance;
  var_15 = anim.aimpitchdifftolerance;
  var_16 = scripts\engine\utility::absangleclamp180(var_8[1] - var_11[1]);

  if(var_16 > var_13) {
    if(var_16 > var_14 || distancesquared(self getapproxeyepos(), var_8) > anim.aimyawdiffclosedistsq) {
      self.baimedataimtarget = 0;
      return false;
    }
  }

  var_17 = scripts\engine\utility::absangleclamp180(var_8[0] - var_11[0]);

  if(var_17 > var_15) {
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