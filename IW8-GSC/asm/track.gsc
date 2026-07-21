/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\track.gsc
***********************************************/

track(var_0) {
  self endon("_encstr_A6F10F617BFFE8E0674AEBFB4E4EA84D63");
  setglobalaimsettings();
  self.asm.trackasm = var_0;
  var_1 = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_82E506B096B5F58C"));
  var_2 = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_91E506B02DDA7D43"));
  var_3 = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_B8E5069E731339E6"));
  var_4 = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_AAE506A832FD17AA"));
  trackinit(var_1, var_2, var_3, var_4);
  trackloop(var_0);
}

trackinit(var_0, var_1, var_2, var_3) {
  self.a.aimweight = 1.0;
  self.a.aimweight_start = 1.0;
  self.a.aimweight_end = 1.0;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  var_4 = spawnStruct();
  var_4.aim_2_default = var_0;
  var_4.aim_4_default = var_1;
  var_4.aim_6_default = var_2;
  var_4.aim_8_default = var_3;
  self.asm.track = var_4;
}

sniperdeathcleanup() {
  self endon("_encstr_A50B0CB9D1F61CEB37DC4B0EAC9C");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.sniper_laser)) {
    self.sniper_laser delete();
    self.sniper_laser = undefined;
  }
}

sniperlaserhackstop() {
  if(isDefined(self.sniper_laser)) {
    self notify("_encstr_A50B0CB9D1F61CEB37DC4B0EAC9C");
    self.sniper_laser[[self.fnlaseroff]]();
    self.sniper_laser delete();
    self.sniper_laser = undefined;
    self.bhaslasertag = undefined;
    self[[self.fnsetlaserflag]]("_encstr_8BBA05185F8B99");
  }
}

shoulduselasertag() {
  var_0 = getweaponbasename(self.weapon);

  switch (var_0) {
    case "_encstr_AA41072DEEDCEBAD1C":
      return 1;
    default:
      break;
  }

  return 0;
}

getlaserstartpoint() {
  if(!isDefined(self.bhaslasertag)) {
    if(shoulduselasertag()) {
      var_0 = self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E", 1);

      if(isDefined(var_0)) {
        self.bhaslasertag = 1;
        return var_0;
      }
    }

    self.bhaslasertag = 0;
  } else if(istrue(self.bhaslasertag)) {
    if(!shoulduselasertag())
      self.bhaslasertag = 0;
  }

  if(self.bhaslasertag)
    return self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E");

  return self getmuzzlepos();
}

getlaserdirection() {
  return self getmuzzledir();
}

getlaserangles() {
  return self getmuzzleangle();
}

sniperlaserhackstart() {
  if(isDefined(self.sniper_laser)) {
    return;
  }
  thread sniperdeathcleanup();
  var_0 = getlaserstartpoint();
  self.sniper_laser = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  self.sniper_laser setModel("_encstr_9A1E0A3A85B3F5632CB9954E");
  self.sniper_laser setmoverlaserweapon(self.weapon);
  self.sniper_laser setotherent(self);
  self.sniper_laser.origin = var_0;
  self[[self.fnsetlaserflag]]("_encstr_9B650C813548B73BCF10C21A9BAD");
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

      if(var_4 < 0.996)
        self.sniper_laser.angles = getlaserangles();
      else
        self.sniper_laser.angles = vectortoangles(self.convergence.aim_pos - self.sniper_laser.origin);
    }

    waitframe();
  }
}

trackturnofflaser() {
  sniperlaserhackstop();
}

trackturnonlaser() {
  if(!isDefined(self.sniper_laser))
    thread sniperlaserhackstart();
}

clearconvergence() {
  self.convergence = undefined;
}

resetconvergence(var_0, var_1, var_2) {
  if(!isDefined(self.convergence))
    self.convergence = spawnStruct();

  self.convergence.sniper_fired = undefined;
  self.convergence.target = self._blackboard.shootparams_ent;
  self.convergence.converge_missouterradius = 96;

  if(var_0)
    self.convergence.converge_time = 1500;
  else if(istrue(var_2))
    self.convergence.converge_time = 1500;
  else
    self.convergence.converge_time = 2000;

  self[[self.fnsetlaserflag]]("_encstr_9B650C813548B73BCF10C21A9BAD");
  var_3 = scripts\common\gameskill::get_skill_from_index(level.gameskill);
  var_4 = level.difficultysettings["_encstr_A2A216EE36FF53ABFA99687B621353EB2FA56066938798E3"][var_3];

  if(isDefined(var_4))
    self.convergence.converge_time = self.convergence.converge_time * var_4;

  if(isDefined(level.sniper_convergence_time_multiplier))
    self.convergence.converge_time = self.convergence.converge_time * level.sniper_convergence_time_multiplier;

  self.convergence.converge_missinnerradius = 12;
  self.convergence.lock_duration_before_firing = 750;
  self.convergence.converge_locked_on_time = undefined;

  if(!isDefined(self.sniper_laser))
    self.convergence.converge_curtime = -1500;
  else
    self.convergence.converge_curtime = 0;

  self.convergence.converge_shoottime = self.convergence.converge_time + 1000;
  self.convergence.converge_laserofftime = self.convergence.converge_shoottime + 500;

  if(isDefined(self._blackboard.shootparams_pos)) {
    var_5 = undefined;
    var_6 = undefined;

    if(isDefined(var_1))
      var_5 = var_1;
    else {
      if(isDefined(self._blackboard.shootparams_ent)) {
        var_7 = self._blackboard.shootparams_ent.origin;

        if(isPlayer(self._blackboard.shootparams_ent)) {
          var_6 = self._blackboard.shootparams_ent getvelocity();

          if(var_6 == (0, 0, 0))
            var_6 = undefined;
        }
      } else
        var_7 = self._blackboard.shootparams_pos - (0, 0, 70);

      var_8 = var_7 - self.origin;
      var_8 = (var_8[0], var_8[1], 0);
      var_9 = vectorNormalize(var_8);

      if(istrue(var_2)) {
        var_5 = var_7;
        var_5 = var_5 + (0, 0, randomfloatrange(12, 36));
      } else
        var_5 = var_7 - var_9 * randomfloatrange(120, 180);

      var_10 = vectorcross(var_9, (0, 0, 1));
      var_11 = randomfloatrange(6, 36);

      if(istrue(var_2))
        var_11 = randomfloatrange(12, 24);

      if(isDefined(var_6)) {
        var_12 = vectordot(var_6, var_10);

        if(var_12 < 0)
          var_5 = var_5 + var_10 * var_11;
        else
          var_5 = var_5 - var_10 * var_11;
      } else if(randomintrange(0, 2))
        var_5 = var_5 + var_10 * var_11;
      else
        var_5 = var_5 - var_10 * var_11;
    }

    self.convergence.converge_offsetdir = vectorNormalize(var_5 - self._blackboard.shootparams_pos);
    self.convergence.converge_missouterradius = distance(var_5, self._blackboard.shootparams_pos);
  }
}

calcconvergencetarget() {
  if(isDefined(self.convergence.converge_locked_on_time) && gettime() - self.convergence.converge_locked_on_time >= 100) {
    var_0 = gettime() - self.convergence.converge_locked_on_time;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent))
      self[[self.fnsetlaserflag]]("_encstr_ACAD05F147D03F");
    else
      self[[self.fnsetlaserflag]]("_encstr_9B650C813548B73BCF10C21A9BAD");

    return self._blackboard.shootparams_pos - (0, 0, 1.3);
  }

  var_1 = vectorNormalize(self._blackboard.shootparams_pos - self.origin);
  var_2 = vectortoangles(var_1);

  if(self.convergence.converge_curtime < 0) {
    self[[self.fnsetlaserflag]]("_encstr_9B650C813548B73BCF10C21A9BAD");
    var_3 = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * self.convergence.converge_missouterradius;
    return var_3;
  }

  var_4 = (self.convergence.converge_time - self.convergence.converge_curtime) / self.convergence.converge_time;

  if(self.convergence.converge_curtime >= self.convergence.converge_time)
    var_4 = 0.0;

  var_5 = var_4 * (self.convergence.converge_missouterradius - self.convergence.converge_missinnerradius) + self.convergence.converge_missinnerradius;
  var_3 = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * var_5;

  if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent))
    self[[self.fnsetlaserflag]]("_encstr_9B650C813548B73BCF10C21A9BAD");

  return var_3;
}

onsniperfired() {
  self notify("_encstr_ABBF14B9B9960E569CF5EE590B077B37FA662DC95691");

  if(isDefined(self.convergence) && isDefined(self.sniper_laser))
    self.convergence.sniper_fired = 1;
}

onsniperabouttofire() {
  if(isDefined(self.sniper_laser)) {
    self.sniper_laser[[self.fnlaseroff]]();
    thread turnlaserbackon(0.5);
  }
}

turnlaserbackon(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);

  if(isDefined(self.sniper_laser))
    self.sniper_laser[[self.fnlaseron]]();
}

convergencetargettick() {
  var_0 = 1;
  var_1 = 0;

  if(isDefined(self._blackboard.shootparams_ent)) {
    var_0 = self cansee(self._blackboard.shootparams_ent);

    if(isDefined(self.convergence) && isDefined(self.convergence.target) && self.convergence.target != self._blackboard.shootparams_ent)
      var_1 = 1;

    if(var_0)
      scripts\asm\asm_bb::bb_updateshootparams_pos(self._blackboard.shootparams_ent getshootatpos());
  }

  if(!isDefined(self.convergence) || var_1)
    resetconvergence(var_1);
  else if(var_0 && !istrue(self.convergence.bhaslos)) {
    if(isDefined(self.convergence.aim_pos) && distancesquared(self.convergence.aim_pos, self._blackboard.shootparams_pos) < 3600)
      resetconvergence(var_1, undefined, 1);
    else
      resetconvergence(var_1);
  } else if(istrue(self.convergence.sniper_fired)) {
    self[[self.fnsetlaserflag]]("_encstr_9B650C813548B73BCF10C21A9BAD");
    self.convergence.sniper_fired = undefined;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent) && self cansee(self._blackboard.shootparams_ent))
      resetconvergence(var_1, undefined, 1);
  }

  self.convergence.bhaslos = var_0;
  var_2 = 1;
  var_3 = getlaserstartpoint();
  var_4 = calcconvergencetarget();
  var_5 = vectorNormalize(var_4 - var_3);
  var_6 = self getmuzzledir();

  if(self.convergence.converge_curtime < 0) {
    if(!isaiming())
      return 0;

    self.convergence.converge_curtime = self.convergence.converge_curtime + 50;
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0.984)
      return 0;

    var_5 = vectorNormalize((var_5[0], var_5[1], 0));
    var_6 = vectorNormalize((var_6[0], var_6[1], 0));
    var_8 = vectordot(var_5, var_6);

    if(var_8 < 0.996)
      return 0;

    self.convergence.converge_curtime = 0;
  } else {
    self.convergence.converge_curtime = self.convergence.converge_curtime + 50;
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0.984)
      var_2 = 0;

    var_5 = vectorNormalize((var_5[0], var_5[1], 0));
    var_6 = vectorNormalize((var_6[0], var_6[1], 0));
    var_8 = vectordot(var_5, var_6);

    if(var_8 < 0.996)
      var_2 = 0;
  }

  if(self.convergence.converge_curtime >= self.convergence.converge_time) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      if(!isDefined(self.convergence.converge_locked_on_time)) {
        if(var_0)
          self.convergence.converge_locked_on_time = gettime();
      } else if(gettime() >= self.convergence.converge_locked_on_time + 200) {
        if(!var_0)
          self.convergence.converge_locked_on_time = undefined;
      }
    }
  }

  return var_2;
}

shouldcqbaim() {
  var_0 = self aigettargetspeed();

  if(istrue(self.doingpoi) || isDefined(self.poiauto))
    return 1;

  if(isDefined(self.demeanoroverride)) {
    if(self.demeanoroverride == "_encstr_85BB067A08A3FAB3")
      return 1;

    if(self.demeanoroverride == "_encstr_96080730D8534E0A28" && isDefined(self.asm.flashlight) && self.asm.flashlight && isDefined(self.cqb_target))
      return 1;
  }

  return 0;
}

getshootpos(var_0) {
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

    if(isDefined(var_2.shootpos))
      return var_2;
  }

  if(!scripts\asm\asm_bb::bb_shootparamsvalid())
    return undefined;
  else if(isDefined(self._blackboard.shootparams_ent) && istrue(self._blackboard.shootparams_buseentinshootcalc))
    var_1.shootpos = self._blackboard.shootparams_ent getshootatpos();
  else if(isDefined(self._blackboard.shootparams_pos))
    var_1.shootpos = self._blackboard.shootparams_pos;

  if(isDefined(var_1.shootpos)) {
    if(istrue(self._blackboard.shootparams_forceaim))
      var_1.bforceaim = 1;

    return var_1;
  }

  return undefined;
}

issniperconverging() {
  if(!isDefined(self.convergence))
    return 0;

  return 1;
}

issniperlaseron() {
  if(isDefined(self.sniper_laser))
    return 1;

  return 0;
}

isaiming() {
  if(!isDefined(self.asm.aimstarttime))
    return 0;

  var_0 = 100.0;
  var_0 = var_0 * 2;
  var_1 = gettime();

  if(self.asm.aimstarttime + var_0 < var_1)
    return 1;

  return 0;
}

canaimwhilemoving() {
  var_0 = self aigettargetspeed();

  if(istrue(self.runngundisableaim))
    return 0;

  if(self.stairsstate != "_encstr_8BBA05185F8B99")
    return 1;

  var_1 = scripts\asm\shared\utility::getbasearchetype();

  if(getanimspeedthreshold(var_1, "_encstr_8F7905C4AEC319") && getanimspeedthreshold(var_1, "_encstr_B4190453BD3B") && var_0 < getcoveranglelimits(var_1, "_encstr_8F7905C4AEC319", "_encstr_B4190453BD3B", 0.4))
    return 1;

  if(var_1 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79" || var_1 == "_encstr_ABCD0E9A57D976564E370BEA3A7D8D38" || var_1 == "_encstr_84CD0E908387D855CB4B3BEBDBE12990")
    return var_0 < 60;

  if(istrue(self.runngun))
    return 1;

  return 0;
}

trackloop(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.asm.prevyawdelta = 0;
  self.asm.prevpitchdelta = 0;
  var_1 = (0, 0, 0);
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 10;

  for(;;) {
    incranimaimweight();
    var_6 = scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "_encstr_8719040B4BB5");

    if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16 && !canaimwhilemoving())
      var_6 = 0;

    var_7 = 0;

    if(!var_6 && scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "_encstr_B43B0D73DE3AAC1DC9851B6D50D2B5"))
      var_6 = scripts\asm\asm::asm_eventfired(self.asm.trackasm, "_encstr_82AB0A82D3502A13E08BE78F");

    if(!var_6 || !istrue(self._blackboard.shootparams_valid)) {
      if(!var_6 && isDefined(self.convergence))
        clearconvergence();

      trackturnofflaser();
      self.asm.aimstarttime = undefined;
    } else if(!isDefined(self.asm.aimstarttime))
      self.asm.aimstarttime = gettime();

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

      if(isDefined(self.aimspeedoverride))
        self setaimstate(self.aimspeedoverride);
      else if(var_7 || !isDefined(var_10))
        self setaimstate(6);
      else if(!isDefined(var_10))
        self setaimstate(3);
      else
        self setaimstate(1);

      var_11 = self getturret();
      var_12 = isDefined(var_11);

      if(var_12) {
        var_13 = var_11 turretgetaim();
        var_14 = anglesToForward(self.angles);
        var_15 = rotatevector(var_14, var_13);
        var_10 = var_9 + var_15 * 512.0;
      } else if(scripts\asm\asm_bb::bb_shootparamsvalid() && isDefined(self._blackboard.shootparams_pos)) {
        if(istrue(self._blackboard.shootparams_bconvergeontarget)) {
          var_16 = convergencetargettick();
          var_10 = calcconvergencetarget();
          self.convergence.aim_pos = var_10;

          if(var_16)
            trackturnonlaser();
          else
            trackturnofflaser();
        } else
          trackturnofflaser();
      } else
        trackturnofflaser();

      var_17 = isDefined(var_10);
      var_18 = (0, 0, 0);

      if(var_17)
        var_18 = var_10;

      var_21 = 0;
      var_22 = isDefined(self.stepoutyaw);

      if(var_22)
        var_21 = self.stepoutyaw;

      var_23 = 0;
      var_24 = 0;
      var_25 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var_25) && scripts\asm\asm_bb::bb_getrequestedcoverstate() == "_encstr_8E2508591EE07BE6B246") {
        var_26 = scripts\asm\asm_bb::bb_getrequestedcoverexposetype();

        if(isDefined(var_26)) {
          var_27 = scripts\asm\shared\utility::getbasearchetype();
          var_23 = scripts\asm\shared\utility::getnodeaimyawoffset(var_27, var_25, var_26);
          var_24 = scripts\asm\shared\utility::getnodeaimpitchoffset(var_27, var_25, var_26);
        }
      } else if(istrue(self.aimingdown)) {
        var_27 = scripts\asm\shared\utility::getbasearchetype();
        var_24 = anim.nodeexposedpitches[var_27]["_encstr_959609825AD64011B7EEE6"];
      } else if(self.asm.archetype == "_encstr_919B052D873A78" || self.asm.archetype == "_encstr_97B20626DECDDC46") {
        var_23 = -12;
        var_28 = 10;
      }

      var_29 = (var_24, var_23, 0);
      var_30 = self getaimangle();
      var_31 = self aigetworldweaponoffset();
      var_9 = var_9 + var_31;

      if(self iscurrentenemyvalid() || isDefined(var_8) && isDefined(var_8.bforceaim) && var_8.bforceaim)
        var_1 = self setaimangles(var_9, var_18, var_17, var_29, var_21, var_22, 1);
      else
        var_1 = self setaimangles((0, 0, 0));

      if(anglesdelta(var_30, var_1) > 12)
        self.baimedataimtarget = 0;
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
            _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::updatelaserstatus();
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
      var_4 = var_4 - 1;
      var_5 = max(10, var_5 - 5);
    } else if(self.relativedir && self.relativedir != var_3) {
      var_4 = 2;
      var_5 = 30;
    } else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper())
      var_5 = 2;
    else if(var_7)
      var_5 = 5;
    else
      var_5 = 10;

    var_40 = 4;
    var_3 = self.relativedir;
    var_41 = self.movemode != "_encstr_B419059BD17BE0" || !var_2;

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

    if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking)
      trackloop_setanimweightslmg(var_38, var_39);
    else
      trackloop_setanimweights(var_38, var_39);

    wait 0.05;
  }
}

trackloop_restoreaim() {
  if(!isDefined(self.asm.prevyawdelta)) {
    return;
  }
  var_0 = clamp(self.asm.prevyawdelta, self.rightaimlimit, self.leftaimlimit);
  var_1 = clamp(self.asm.prevpitchdelta, self.upaimlimit, self.downaimlimit);

  if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking)
    trackloop_setanimweightslmg(var_1, var_0);
  else
    trackloop_setanimweights(var_1, var_0);
}

trackloop_cqbshootpos(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);
  var_3 = 0;

  if(isDefined(self.cqb_target)) {
    if(isvector(self.cqb_target))
      var_1 = self.cqb_target;
    else
      var_1 = self.cqb_target getshootatpos();

    if(isDefined(self.cqb_wide_target_track)) {
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  if(!isDefined(var_1))
    var_3 = 1;

  if(!isDefined(var_1)) {
    if(!isDefined(self.cqb_point_of_interest) && isDefined(self.currentpoi)) {
      setpoi(undefined);
      self.a.laseron = 0;
      _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::updatelaserstatus();
    } else if(isDefined(self.cqb_point_of_interest)) {
      if(!scripts\engine\utility::is_equal(self.cqb_point_of_interest, self.currentpoi)) {
        setpoi(self.cqb_point_of_interest);

        if(!istrue(self.currentpoi.islookatonly)) {
          var_1 = self.currentpoi.origin;
          self.a.laseron = 0;
          _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::updatelaserstatus();
        }
      } else if(!istrue(self.currentpoi.islookatonly))
        var_1 = self.currentpoi.origin;
    }
  }

  if(isDefined(self.poiauto))
    var_1 = poiauto_getshootpos();

  if(!isDefined(var_1) && isDefined(self.pathgoalpos) && !isDefined(self.enemy) && self.facemotion) {
    var_4 = self getposonpath(self.lookandaimdownpathdist);
    var_5 = var_4 - self.origin;
    var_5 = vectorNormalize((var_5[0], var_5[1], 0));

    if(vectordot(var_2, var_5) < 0.9994)
      var_1 = var_4 + (0, 0, 54);
  }

  var_6 = spawnStruct();
  var_6.shootpos = var_1;
  var_6.busingcqbpoi = var_3;
  var_6.bforceaim = 1;
  return var_6;
}

poiauto_getshootpos() {
  if(isDefined(self.poiauto_nextaimtime) && gettime() > self.poiauto_nextaimtime) {
    self.poiauto_angles = self.poiauto_nextangles;
    self.poiauto_nextaimtime = undefined;
    self.poiauto_nextangles = undefined;
  }

  var_0 = undefined;

  if(isDefined(self.poiauto_angles))
    var_0 = scripts\asm\shared\utility::poiauto_relativeangletopos(self.poiauto_angles);

  if(!istrue(self.poiauto.glancing)) {
    if(isDefined(self.poiauto_nextangles)) {
      var_1 = scripts\asm\shared\utility::poiauto_relativeangletopos(self.poiauto_nextangles);
      scripts\common\utility::lookatpos(var_1, 0);
    } else
      scripts\common\utility::lookatpos(var_0, 0);
  }

  return var_0;
}

setpoi(var_0) {
  if(!isDefined(var_0)) {
    self.currentpoi = undefined;
    self._blackboard.forcestrafe = 0;
    self stoplookat();
  } else {
    if(istrue(var_0.islookatonly))
      self glanceatpos(var_0.origin, var_0.lookatduration);
    else {
      self._blackboard.forcestrafe = istrue(var_0.script_poi_forcestrafe);
      self._blackboard.forcestrafefacingpos = var_0.origin;
      self setlookat(var_0.origin);
    }

    var_1 = gettime();
    self.poi_starttime = var_1;
    var_0.lastusedtime = var_1;
    self.currentpoi = var_0;
  }
}

trackloop_setanimweights(var_0, var_1) {
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

  if(isDefined(self.asm.track.aim_5))
    var_2 = self.asm.track.aim_5;

  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  if(var_1 < 0) {
    var_10 = var_1 / self.rightaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_1 > 0) {
    var_8 = var_1 / self.leftaimlimit * self.a.aimweight;
    var_9 = 1;
  }

  if(var_0 < 0) {
    var_11 = var_0 / self.upaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_0 > 0) {
    var_7 = var_0 / self.downaimlimit * self.a.aimweight;
    var_9 = 1;
  }

  self aisetanimlimited(var_3, var_7, 0.1, 1, 1);
  self aisetanimlimited(var_4, var_8, 0.1, 1, 1);
  self aisetanimlimited(var_5, var_10, 0.1, 1, 1);
  self aisetanimlimited(var_6, var_11, 0.1, 1, 1);

  if(isDefined(var_2))
    self aisetanimlimited(var_2, var_9, 0.1, 1, 1);
}

trackloop_setanimweightslmg(var_0, var_1) {
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

  if(var_18 == 0)
    var_18 = 1;

  var_19 = self.asm.track.lmg_aim_state;

  for(var_20 = 0; var_20 < var_10.size; var_20++) {
    if(var_20 == var_18 || var_20 == var_18 - 1) {
      var_21 = clamp(var_15 / var_13[var_20], 0.0, 1.0);
      var_22 = acos(vectordot(var_12[var_20], var_16));
      var_23 = clamp(1 - var_22 / var_13[var_20], 0.0, 1.0);
      var_24 = scripts\asm\asm::asm_getxanim(var_19, var_10[var_20]);
      var_25 = self aigetanimtime(var_24);

      if(var_25 > 0) {
        var_26 = getanimlength(var_24);
        var_27 = (var_21 - var_25) * var_26 / 0.05;
        self aisetanimlimited(var_24, var_23, 0.05, var_27);
      } else {
        self aisetanimlimited(var_24, var_23, 0.05, 0.0);
        self aisetanimtime(var_24, var_21);
      }

      continue;
    }

    if(var_10[var_20] != var_10[var_18] && var_10[var_20] != var_10[var_18 - 1])
      self aiclearanim(scripts\asm\asm::asm_getxanim(var_19, var_10[var_20]), 0.05);
  }
}

setanimaimweight(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a.aimweight = var_0;
    self.a.aimweight_start = var_0;
    self.a.aimweight_end = var_0;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight))
      self.a.aimweight = 0;

    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = var_0;
    self.a.aimweight_transframes = int(var_1 * 20);
  }

  self.a.aimweight_t = 0;
}

incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    var_0 = 1.0 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - var_0) + self.a.aimweight_end * var_0;
  }
}

aimedataimtarget() {
  if(scripts\asm\asm_bb::bb_shootparams_empty()) {
    self.baimedataimtarget = 1;
    return 1;
  }

  if(istrue(self.runngun) && istrue(self.runngundisableaim)) {
    self.baimedataimtarget = 0;
    return 0;
  }

  if(istrue(self.casualkiller) && !istrue(self.leavecasualkiller)) {
    self.baimedataimtarget = 1;
    return 1;
  }

  if(istrue(self._blackboard.shootparams_bconvergeontarget)) {
    if(!isDefined(self.convergence)) {
      self.baimedataimtarget = 0;
      return 0;
    }

    if(isDefined(self.convergence.converge_locked_on_time)) {
      var_0 = gettime() - self.convergence.converge_locked_on_time;

      if(var_0 >= self.convergence.lock_duration_before_firing) {
        self.baimedataimtarget = 1;
        return 1;
      }
    } else if(self.convergence.converge_curtime >= self.convergence.converge_shoottime) {
      self.baimedataimtarget = 1;
      return 1;
    }

    self.baimedataimtarget = 0;
    return 0;
  }

  if(!self isinscriptedstate()) {
    var_1 = !scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "_encstr_8719040B4BB5");

    if(!var_1 && scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "_encstr_B43B0D73DE3AAC1DC9851B6D50D2B5"))
      var_1 = !scripts\asm\asm::asm_eventfired(self.asm.trackasm, "_encstr_82AB0A82D3502A13E08BE78F");

    if(!var_1)
      var_1 = isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 16 && !canaimwhilemoving();

    if(var_1) {
      self.baimedataimtarget = 0;
      return 0;
    }
  }

  var_2 = scripts\asm\shared\utility::getshootfrompos();
  var_3 = getshootpos(var_2);

  if(!isDefined(var_3)) {
    self.baimedataimtarget = 0;
    return 0;
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
  } else if(isDefined(var_5)) {
    var_12 = var_5 getturrettarget(1);
    self.baimedataimtarget = isDefined(var_12);
    return isDefined(var_12);
  } else if(istrue(self.runngun)) {
    var_11 = vectortoangles(var_4 - var_2);
    var_8 = self getmuzzleangle();
  } else {
    var_11 = vectortoangles(var_4 - var_2);

    if(scripts\engine\utility::absangleclamp180(var_11[1] - self.angles[1]) > 100 || scripts\engine\utility::absangleclamp180(var_11[0] - self.angles[0]) > 100)
      return 0;

    var_8 = self getmuzzleangle();
  }

  var_13 = anim.aimyawdifffartolerance;
  var_14 = anim.aimyawdiffclosetolerance;
  var_15 = anim.aimpitchdifftolerance;
  var_16 = scripts\engine\utility::absangleclamp180(var_8[1] - var_11[1]);

  if(var_16 > var_13) {
    if(var_16 > var_14 || distancesquared(self getapproxeyepos(), var_4) > anim.aimyawdiffclosedistsq) {
      self.baimedataimtarget = 0;
      return 0;
    }
  }

  var_17 = scripts\engine\utility::absangleclamp180(var_8[0] - var_11[0]);

  if(var_17 > var_15) {
    self.baimedataimtarget = 0;
    return 0;
  }

  self.baimedataimtarget = 1;
  return 1;
}

setglobalaimsettings() {
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