/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\track.gsc
***********************************************/

track(asmname) {
  self._id_A709FBD9FEA148F6 = asmname;
  _id_A60D2AE5B60F0734 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "aim_2");

  if(!isDefined(_id_A60D2AE5B60F0734)) {
    return;
  }
  _id_910177FE29603C10 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_2"));
  _id_91017DFE29604942 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_4"));
  _id_91017BFE296044DC = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_6"));
  _id_910181FE2960520E = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "aim_8"));
  trackinit(_id_910177FE29603C10, _id_91017DFE29604942, _id_91017BFE296044DC, _id_910181FE2960520E);
  thread trackloop(asmname);
}

trackinit(aim_2, aim_4, aim_6, aim_8) {
  self.a.aimweight = 1.0;
  self.a.aimweight_start = 1.0;
  self.a.aimweight_end = 1.0;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  self.asm.track = spawnStruct();
  self.asm.track.aim_2_default = aim_2;
  self.asm.track.aim_4_default = aim_4;
  self.asm.track.aim_6_default = aim_6;
  self.asm.track.aim_8_default = aim_8;
}

sniperdeathcleanup() {
  self endon("stop_sniper");
  self waittill("death");

  if(isDefined(self.sniper_laser))
    self.sniper_laser delete();
}

sniperlaserhackstop() {
  if(isDefined(self.sniper_laser)) {
    self notify("stop_sniper");

    if(isDefined(self.fnlaseroff))
      self.sniper_laser[[self.fnlaseroff]]();

    self.sniper_laser delete();
    self.sniper_laser = undefined;
    self.bhaslasertag = undefined;

    if(isDefined(self.fnsetlaserflag))
      self[[self.fnsetlaserflag]]("none");
  }
}

shoulduselasertag() {
  _id_5C3F9357F11D2223 = getweaponbasename(self.weapon);

  switch (_id_5C3F9357F11D2223) {
    case "iw7_m8":
      return 1;
    default:
      break;
  }

  return 0;
}

getlaserstartpoint() {
  if(!isDefined(self.bhaslasertag)) {
    if(shoulduselasertag()) {
      _id_F15B345C31B99E56 = self gettagorigin("tag_laser", 1);

      if(isDefined(_id_F15B345C31B99E56)) {
        self.bhaslasertag = 1;
        return _id_F15B345C31B99E56;
      }
    }

    self.bhaslasertag = 0;
  } else if(istrue(self.bhaslasertag)) {
    if(!shoulduselasertag())
      self.bhaslasertag = 0;
  }

  if(self.bhaslasertag)
    return self gettagorigin("tag_laser");

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
  _id_3C0DBCD729E6D642 = getlaserstartpoint();
  self.sniper_laser = spawn("script_model", _id_3C0DBCD729E6D642);
  self.sniper_laser setModel("tag_laser");
  self.sniper_laser setmoverlaserweapon(self.weapon);
  self.sniper_laser setotherent(self);
  self.sniper_laser.origin = _id_3C0DBCD729E6D642;

  if(isDefined(self.fnsetlaserflag))
    self[[self.fnsetlaserflag]]("interpolate");

  if(isDefined(self.fnlaseron))
    self.sniper_laser[[self.fnlaseron]]();

  while(isalive(self) && isDefined(self.sniper_laser)) {
    if(isDefined(self.convergence.aim_pos)) {
      _id_3C0DBCD729E6D642 = getlaserstartpoint();
      self.sniper_laser.origin = _id_3C0DBCD729E6D642;
      desiredaimpos = self.convergence.aim_pos;
      _id_D4C7B1E5457A2668 = vectorNormalize(desiredaimpos - _id_3C0DBCD729E6D642);
      _id_8D02D1D6A93EA41F = getlaserdirection();
      _id_D4C7B1E5457A2668 = vectorNormalize((_id_D4C7B1E5457A2668[0], _id_D4C7B1E5457A2668[1], 0));
      _id_8D02D1D6A93EA41F = vectorNormalize((_id_8D02D1D6A93EA41F[0], _id_8D02D1D6A93EA41F[1], 0));
      dot = vectordot(_id_D4C7B1E5457A2668, _id_8D02D1D6A93EA41F);

      if(dot < 0.996)
        self.sniper_laser.angles = getlaserangles();
      else
        self.sniper_laser.angles = vectortoangles(self.convergence.aim_pos - self.sniper_laser.origin);
    }

    waitframe();
  }
}

trackturnofflaser() {
  if(istrue(self._id_70BEB323DD9E1AC5)) {
    return;
  }
  sniperlaserhackstop();
}

trackturnonlaser() {
  if(istrue(self._id_70BEB323DD9E1AC5)) {
    return;
  }
  if(!isDefined(self.sniper_laser))
    thread sniperlaserhackstart();
}

clearconvergence() {
  self.convergence = undefined;
  self._id_03E580A3D5CD6664 = 0;
}

resetconvergence(_id_19935E0042FE0718, _id_C5686A51213BF45E, _id_6CBA42B1AB91DC15) {
  if(!isDefined(self.convergence)) {
    self.convergence = spawnStruct();
    self._id_03E580A3D5CD6664 = 1;
  }

  self._id_56DA037B6C1D635B = 0;
  self.convergence.target = self._blackboard.shootparams_ent;
  self.convergence.converge_missouterradius = 96;

  if(isDefined(self._id_6EB04341083AD82B))
    self.convergence.converge_time = self[[self._id_6EB04341083AD82B]](_id_19935E0042FE0718, _id_6CBA42B1AB91DC15);
  else if(_id_19935E0042FE0718)
    self.convergence.converge_time = 1500;
  else if(istrue(_id_6CBA42B1AB91DC15))
    self.convergence.converge_time = 1500;
  else
    self.convergence.converge_time = 2000;

  if(isDefined(self.fnsetlaserflag))
    self[[self.fnsetlaserflag]]("interpolate");

  _id_172E4152F3676D37 = scripts\common\gameskill::get_skill_from_index(level.gameskill);
  _id_B6782FBA64B69AB5 = level.difficultysettings["sniper_converge_scale"][_id_172E4152F3676D37];

  if(isDefined(_id_B6782FBA64B69AB5))
    self.convergence.converge_time = int(self.convergence.converge_time * _id_B6782FBA64B69AB5);

  if(isDefined(level.sniper_convergence_time_multiplier))
    self.convergence.converge_time = self.convergence.converge_time * level.sniper_convergence_time_multiplier;

  self.convergence.converge_missinnerradius = 12;
  self._id_551A69E2205249C5 = 750;
  self._id_1C2393F94226309C = -1;

  if(!isDefined(self.sniper_laser))
    self._id_7D4D41DB8D0295F9 = -1500;
  else
    self._id_7D4D41DB8D0295F9 = 0;

  self._id_33E6FF2F7D46B8D8 = int(self.convergence.converge_time + 1000);
  self.convergence.converge_laserofftime = self._id_33E6FF2F7D46B8D8 + 500;

  if(isDefined(self._blackboard.shootparams_pos)) {
    _id_78F2B58603CAF3AE = undefined;
    _id_C068649575851BDF = undefined;

    if(isDefined(self._id_8629DDC52F25A54E))
      _id_78F2B58603CAF3AE = self[[self._id_8629DDC52F25A54E]](self._blackboard.shootparams_ent, _id_6CBA42B1AB91DC15);
    else if(isDefined(_id_C5686A51213BF45E))
      _id_78F2B58603CAF3AE = _id_C5686A51213BF45E;
    else {
      if(isDefined(self._blackboard.shootparams_ent)) {
        targetpos = self._blackboard.shootparams_ent.origin;

        if(isPlayer(self._blackboard.shootparams_ent)) {
          _id_C068649575851BDF = self._blackboard.shootparams_ent getvelocity();

          if(_id_C068649575851BDF == (0, 0, 0))
            _id_C068649575851BDF = undefined;
        }
      } else
        targetpos = self._blackboard.shootparams_pos - (0, 0, 70);

      _id_D6CD43F7AC43CB72 = targetpos - self.origin;
      _id_D6CD43F7AC43CB72 = (_id_D6CD43F7AC43CB72[0], _id_D6CD43F7AC43CB72[1], 0);
      _id_BB709894B649925B = vectorNormalize(_id_D6CD43F7AC43CB72);

      if(istrue(_id_6CBA42B1AB91DC15)) {
        _id_78F2B58603CAF3AE = targetpos;
        _id_78F2B58603CAF3AE = _id_78F2B58603CAF3AE + (0, 0, randomfloatrange(12, 36));
      } else
        _id_78F2B58603CAF3AE = targetpos - _id_BB709894B649925B * randomfloatrange(120, 180);

      _id_A755BAC7DC657F85 = vectorcross(_id_BB709894B649925B, (0, 0, 1));
      _id_456D0752EF337BEB = randomfloatrange(6, 36);

      if(istrue(_id_6CBA42B1AB91DC15))
        _id_456D0752EF337BEB = randomfloatrange(12, 24);

      if(isDefined(_id_C068649575851BDF)) {
        dot = vectordot(_id_C068649575851BDF, _id_A755BAC7DC657F85);

        if(dot < 0)
          _id_78F2B58603CAF3AE = _id_78F2B58603CAF3AE + _id_A755BAC7DC657F85 * _id_456D0752EF337BEB;
        else
          _id_78F2B58603CAF3AE = _id_78F2B58603CAF3AE - _id_A755BAC7DC657F85 * _id_456D0752EF337BEB;
      } else if(randomintrange(0, 2))
        _id_78F2B58603CAF3AE = _id_78F2B58603CAF3AE + _id_A755BAC7DC657F85 * _id_456D0752EF337BEB;
      else
        _id_78F2B58603CAF3AE = _id_78F2B58603CAF3AE - _id_A755BAC7DC657F85 * _id_456D0752EF337BEB;
    }

    self.convergence.converge_offsetdir = vectorNormalize(_id_78F2B58603CAF3AE - self._blackboard.shootparams_pos);
    self.convergence.converge_missouterradius = distance(_id_78F2B58603CAF3AE, self._blackboard.shootparams_pos);
  }
}

calcconvergencetarget() {
  if(self._id_1C2393F94226309C >= 0 && gettime() - self._id_1C2393F94226309C >= 100) {
    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
      if(isDefined(self.fnsetlaserflag))
        self[[self.fnsetlaserflag]]("lock");
    } else if(isDefined(self.fnsetlaserflag))
      self[[self.fnsetlaserflag]]("interpolate");

    if(isDefined(self._id_57E4656FC3904B2A))
      return self[[self._id_57E4656FC3904B2A]](self._blackboard.shootparams_pos - (0, 0, 1.3), self.convergence.aim_pos);

    return self._blackboard.shootparams_pos - (0, 0, 1.3);
  }

  _id_6A4277FF9E64049F = vectorNormalize(self._blackboard.shootparams_pos - self.origin);
  _id_9E61483C140A062B = vectortoangles(_id_6A4277FF9E64049F);

  if(self._id_7D4D41DB8D0295F9 < 0) {
    if(isDefined(self.fnsetlaserflag))
      self[[self.fnsetlaserflag]]("interpolate");

    shootpos = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * self.convergence.converge_missouterradius;
    return shootpos;
  }

  f = (self.convergence.converge_time - self._id_7D4D41DB8D0295F9) / self.convergence.converge_time;

  if(self._id_7D4D41DB8D0295F9 >= self.convergence.converge_time)
    f = 0.0;

  _id_6D4D4104E6E4639A = f * (self.convergence.converge_missouterradius - self.convergence.converge_missinnerradius) + self.convergence.converge_missinnerradius;
  shootpos = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * _id_6D4D4104E6E4639A;

  if(isDefined(self._id_57E4656FC3904B2A))
    shootpos = self[[self._id_57E4656FC3904B2A]](shootpos, self.convergence.aim_pos);

  if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent)) {
    if(isDefined(self.fnsetlaserflag))
      self[[self.fnsetlaserflag]]("interpolate");
  }

  return shootpos;
}

turnlaserbackon(waittime) {
  self endon("death");
  wait(waittime);

  if(isDefined(self.sniper_laser)) {
    if(isDefined(self.fnlaseron))
      self.sniper_laser[[self.fnlaseron]]();
  }
}

convergencetargettick() {
  bcansee = 1;
  _id_19935E0042FE0718 = 0;

  if(isDefined(self._blackboard.shootparams_ent)) {
    bcansee = self cansee(self._blackboard.shootparams_ent);

    if(isDefined(self.convergence) && isDefined(self.convergence.target) && self.convergence.target != self._blackboard.shootparams_ent)
      _id_19935E0042FE0718 = 1;

    if(bcansee)
      scripts\asm\asm_bb::bb_updateshootparams_pos(self._blackboard.shootparams_ent getshootatpos());
  }

  if(!isDefined(self.convergence) || _id_19935E0042FE0718)
    resetconvergence(_id_19935E0042FE0718);
  else if(bcansee && !istrue(self.convergence.bhaslos)) {
    if(isDefined(self.convergence.aim_pos) && distancesquared(self.convergence.aim_pos, self._blackboard.shootparams_pos) < 3600)
      resetconvergence(_id_19935E0042FE0718, undefined, 1);
    else
      resetconvergence(_id_19935E0042FE0718);
  } else if(self._id_56DA037B6C1D635B) {
    if(isDefined(self.fnsetlaserflag))
      self[[self.fnsetlaserflag]]("interpolate");

    self._id_56DA037B6C1D635B = 0;

    if(isDefined(self._blackboard.shootparams_ent) && isPlayer(self._blackboard.shootparams_ent) && self cansee(self._blackboard.shootparams_ent))
      resetconvergence(_id_19935E0042FE0718, undefined, 1);
  }

  self.convergence.bhaslos = bcansee;
  _id_0BAEC6CD1D3A8C9B = 1;
  _id_3C0DBCD729E6D642 = getlaserstartpoint();
  desiredaimpos = calcconvergencetarget();
  _id_D4C7B1E5457A2668 = vectorNormalize(desiredaimpos - _id_3C0DBCD729E6D642);
  _id_8D02D1D6A93EA41F = self getmuzzledir();
  _id_12598611623A844D = 0.984;
  _id_65CF0275DA1BD77A = 0.996;

  if(isDefined(self._id_F0BC5C8A66C12F48))
    _id_12598611623A844D = self._id_F0BC5C8A66C12F48;

  if(isDefined(self._id_D78FA18248E7E3B1))
    _id_65CF0275DA1BD77A = self._id_D78FA18248E7E3B1;

  if(self._id_7D4D41DB8D0295F9 < 0) {
    if(!isaiming())
      return 0;

    self._id_7D4D41DB8D0295F9 = self._id_7D4D41DB8D0295F9 + 50;
    _id_31A129E448F45B0F = vectordot(_id_D4C7B1E5457A2668, _id_8D02D1D6A93EA41F);

    if(_id_31A129E448F45B0F < _id_12598611623A844D)
      return 0;

    _id_D4C7B1E5457A2668 = vectorNormalize((_id_D4C7B1E5457A2668[0], _id_D4C7B1E5457A2668[1], 0));
    _id_8D02D1D6A93EA41F = vectorNormalize((_id_8D02D1D6A93EA41F[0], _id_8D02D1D6A93EA41F[1], 0));
    dot = vectordot(_id_D4C7B1E5457A2668, _id_8D02D1D6A93EA41F);

    if(dot < _id_65CF0275DA1BD77A)
      return 0;

    self._id_7D4D41DB8D0295F9 = 0;
  } else {
    self._id_7D4D41DB8D0295F9 = self._id_7D4D41DB8D0295F9 + 50;
    _id_31A129E448F45B0F = vectordot(_id_D4C7B1E5457A2668, _id_8D02D1D6A93EA41F);

    if(_id_31A129E448F45B0F < _id_12598611623A844D)
      _id_0BAEC6CD1D3A8C9B = 0;

    _id_D4C7B1E5457A2668 = vectorNormalize((_id_D4C7B1E5457A2668[0], _id_D4C7B1E5457A2668[1], 0));
    _id_8D02D1D6A93EA41F = vectorNormalize((_id_8D02D1D6A93EA41F[0], _id_8D02D1D6A93EA41F[1], 0));
    dot = vectordot(_id_D4C7B1E5457A2668, _id_8D02D1D6A93EA41F);

    if(dot < _id_65CF0275DA1BD77A)
      _id_0BAEC6CD1D3A8C9B = 0;
  }

  if(self._id_7D4D41DB8D0295F9 >= self.convergence.converge_time) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      if(self._id_1C2393F94226309C < 0) {
        if(bcansee)
          self._id_1C2393F94226309C = gettime();
      } else if(gettime() >= self._id_1C2393F94226309C + 200) {
        if(!bcansee)
          self._id_1C2393F94226309C = -1;
      }
    }
  }

  return _id_0BAEC6CD1D3A8C9B;
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

  _id_431678B1875F5B5C = 100.0;
  _id_431678B1875F5B5C = _id_431678B1875F5B5C * 2;
  time = gettime();

  if(self.asm.aimstarttime + _id_431678B1875F5B5C < time)
    return 1;

  return 0;
}

trackloop(asmname) {
  self endon("asm_terminated");
  self endon("death");
  self.asm.prevyawdelta = 0;
  self.asm.prevpitchdelta = 0;
  _id_DDD3DF8D5EA97F86 = 1;
  _id_43892DB64EBC1E45 = 0;
  _id_3661ADF95124E37D = 0;
  _id_8260E607AB328509 = 10;

  for(;;) {
    self waittill("activate_track_loop");
    self._id_0B2AC51A99FD788E = 1;

    for(;;) {
      if(!isDefined(self._id_A709FBD9FEA148F6) || self asmcurrentstatehasaimset(self._id_A709FBD9FEA148F6) && !self _meth_E8CA4080D02A0BB4()) {
        self._id_0B2AC51A99FD788E = 0;
        break;
      }

      incranimaimweight();
      _id_7DFF387EDF36893B = scripts\asm\asm::asm_currentstatehasflag(self._id_A709FBD9FEA148F6, "aim");

      if(_id_7DFF387EDF36893B && self _meth_53FB16FCB6043BBC())
        _id_7DFF387EDF36893B = 0;

      if(!_id_7DFF387EDF36893B && scripts\asm\asm::asm_currentstatehasflag(self._id_A709FBD9FEA148F6, "notetrackAim"))
        _id_7DFF387EDF36893B = scripts\asm\asm::asm_eventfired(self._id_A709FBD9FEA148F6, "start_aim");

      if(!_id_7DFF387EDF36893B || !istrue(self._blackboard.shootparams_valid)) {
        if(!_id_7DFF387EDF36893B && isDefined(self.convergence))
          clearconvergence();

        trackturnofflaser();
        self.asm.aimstarttime = undefined;
      } else if(!isDefined(self.asm.aimstarttime))
        self.asm.aimstarttime = gettime();

      _id_35C8DB9FD47C4521 = 0;
      _id_4D8C29985E84735B = (0, 0, 0);
      _id_182A55F70AD78F5F = undefined;
      _id_63A5B32B096323BE = undefined;

      if(_id_7DFF387EDF36893B) {
        if(self bb_shootparamsvalid() && isDefined(self._blackboard.shootparams_pos)) {
          if(istrue(self._blackboard.shootparams_bconvergeontarget)) {
            _id_0BAEC6CD1D3A8C9B = convergencetargettick();
            shootpos = calcconvergencetarget();
            self.convergence.aim_pos = shootpos;

            if(_id_0BAEC6CD1D3A8C9B)
              trackturnonlaser();
            else
              trackturnofflaser();
          } else
            trackturnofflaser();
        } else
          trackturnofflaser();
      } else if(abs(self.asm.prevyawdelta) < 5 && abs(self.asm.prevpitchdelta) < 5) {
        self setaimangles((0, 0, 0));
        self setaimstate(3);
        self.baimedataimtarget = 0;
        waitframe();
        continue;
      }

      if(self asmcurrentstatehasaimset(self._id_A709FBD9FEA148F6)) {
        waitframe();
        continue;
      }

      if(istrue(self.runngun)) {
        waitframe();
        continue;
      }

      _id_4D8C29985E84735B = self getaimangle();
      pitchdelta = _id_4D8C29985E84735B[0];
      _id_5BABFFA7F03CE512 = _id_4D8C29985E84735B[1];
      _id_4D8C29985E84735B = undefined;

      if(_id_3661ADF95124E37D > 0) {
        _id_3661ADF95124E37D = _id_3661ADF95124E37D - 1;
        _id_8260E607AB328509 = max(10, _id_8260E607AB328509 - 5);
      } else if(self.relativedir && self.relativedir != _id_43892DB64EBC1E45) {
        _id_3661ADF95124E37D = 2;
        _id_8260E607AB328509 = 30;
      } else if(self _meth_E8CA4080D02A0BB4())
        _id_8260E607AB328509 = 2;
      else if(_id_35C8DB9FD47C4521)
        _id_8260E607AB328509 = 5;
      else
        _id_8260E607AB328509 = 10;

      _id_CC6E3D91CFE6FD55 = 4;
      _id_43892DB64EBC1E45 = self.relativedir;
      _id_E50573772AEDEA37 = self.movemode != "stop" || !_id_DDD3DF8D5EA97F86;

      if(_id_E50573772AEDEA37) {
        _id_4142633C790D3AE6 = _id_5BABFFA7F03CE512 - self.asm.prevyawdelta;

        if(squared(_id_4142633C790D3AE6) > _id_CC6E3D91CFE6FD55) {
          _id_D209185381BFF3DB = _id_4142633C790D3AE6 * 0.4;
          _id_5BABFFA7F03CE512 = self.asm.prevyawdelta + clamp(_id_D209185381BFF3DB, -1 * _id_8260E607AB328509, _id_8260E607AB328509);
          _id_5BABFFA7F03CE512 = clamp(_id_5BABFFA7F03CE512, self.rightaimlimit, self.leftaimlimit);
        }

        _id_9DEE51F9CC272C49 = pitchdelta - self.asm.prevpitchdelta;

        if(squared(_id_9DEE51F9CC272C49) > _id_CC6E3D91CFE6FD55) {
          _id_DBAB739E3612D18C = _id_9DEE51F9CC272C49 * 0.4;
          pitchdelta = self.asm.prevpitchdelta + clamp(_id_DBAB739E3612D18C, -1 * _id_8260E607AB328509, _id_8260E607AB328509);
          pitchdelta = clamp(pitchdelta, self.upaimlimit, self.downaimlimit);
        }
      }

      _id_DDD3DF8D5EA97F86 = 0;
      self.asm.prevyawdelta = _id_5BABFFA7F03CE512;
      self.asm.prevpitchdelta = pitchdelta;

      if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking)
        trackloop_setanimweightslmg(pitchdelta, _id_5BABFFA7F03CE512);
      else
        trackloop_setanimweights(pitchdelta, _id_5BABFFA7F03CE512);

      wait 0.05;
    }
  }
}

trackloop_restoreaim() {
  if(!isDefined(self.asm.prevyawdelta)) {
    return;
  }
  _id_5BABFFA7F03CE512 = clamp(self.asm.prevyawdelta, self.rightaimlimit, self.leftaimlimit);
  pitchdelta = clamp(self.asm.prevpitchdelta, self.upaimlimit, self.downaimlimit);

  if(isDefined(self.asm.dolmgtracking) && self.asm.dolmgtracking)
    trackloop_setanimweightslmg(pitchdelta, _id_5BABFFA7F03CE512);
  else
    trackloop_setanimweights(pitchdelta, _id_5BABFFA7F03CE512);
}

_id_CB9CC0BF8A48E338() {
  if(self._id_F42C6628B5C02603) {
    if(isDefined(self.cqb_point_of_interest))
      self.cqb_point_of_interest.lastusedtime = self.poi_starttime;

    self.currentpoi = self.cqb_point_of_interest;
    self._id_F42C6628B5C02603 = 0;
  }

  return self.currentpoi;
}

trackloop_setanimweights(pitchdelta, _id_5BABFFA7F03CE512) {
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

  if(isDefined(self.asm.track.aim_5))
    aim_5 = self.asm.track.aim_5;

  _id_9B352FD430804555 = 0;
  _id_9B3529D430803823 = 0;
  _id_9B3528D4308035F0 = 0;
  _id_9B352BD430803C89 = 0;
  _id_9B3535D430805287 = 0;
  _id_5BABFFA7F03CE512 = clamp(_id_5BABFFA7F03CE512, self.rightaimlimit, self.leftaimlimit);
  pitchdelta = clamp(pitchdelta, self.upaimlimit, self.downaimlimit);

  if(_id_5BABFFA7F03CE512 < 0) {
    _id_9B352BD430803C89 = _id_5BABFFA7F03CE512 / self.rightaimlimit * self.a.aimweight;
    _id_9B3528D4308035F0 = 1;
  } else if(_id_5BABFFA7F03CE512 > 0) {
    _id_9B3529D430803823 = _id_5BABFFA7F03CE512 / self.leftaimlimit * self.a.aimweight;
    _id_9B3528D4308035F0 = 1;
  }

  if(pitchdelta < 0) {
    _id_9B3535D430805287 = pitchdelta / self.upaimlimit * self.a.aimweight;
    _id_9B3528D4308035F0 = 1;
  } else if(pitchdelta > 0) {
    _id_9B352FD430804555 = pitchdelta / self.downaimlimit * self.a.aimweight;
    _id_9B3528D4308035F0 = 1;
  }

  self aisetanimlimited(aim_2, _id_9B352FD430804555, 0.1, 1, 1);
  self aisetanimlimited(aim_4, _id_9B3529D430803823, 0.1, 1, 1);
  self aisetanimlimited(aim_6, _id_9B352BD430803C89, 0.1, 1, 1);
  self aisetanimlimited(aim_8, _id_9B3535D430805287, 0.1, 1, 1);

  if(isDefined(aim_5))
    self aisetanimlimited(aim_5, _id_9B3528D4308035F0, 0.1, 1, 1);
}

trackloop_setanimweightslmg(pitchdelta, _id_5BABFFA7F03CE512) {
  _id_473D10F4FF7E23C2 = self.asm.track.lmg_aim_1;
  aim_2 = self.asm.track.lmg_aim_2;
  _id_473D0EF4FF7E1F5C = self.asm.track.lmg_aim_3;
  aim_4 = self.asm.track.lmg_aim_4;
  aim_6 = self.asm.track.lmg_aim_6;
  _id_473D0AF4FF7E1690 = self.asm.track.lmg_aim_7;
  aim_8 = self.asm.track.lmg_aim_8;
  _id_473D18F4FF7E355A = self.asm.track.lmg_aim_9;
  _id_70662F647F89D5F7 = [aim_6, _id_473D18F4FF7E355A, aim_8, _id_473D0AF4FF7E1690, aim_4, _id_473D10F4FF7E23C2, aim_2, _id_473D0EF4FF7E1F5C, aim_6];
  _id_D90439D9C610BE2A = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  _id_9D05D7478C808090 = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  _id_CD2B912C7B5EC142 = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  _id_2B9E6A3057C13798 = (_id_5BABFFA7F03CE512, pitchdelta, 0);
  _id_B943808B345C0C66 = length2d(_id_2B9E6A3057C13798);
  _id_EFFBD89CEED72F4F = vectorNormalize(_id_2B9E6A3057C13798);
  _id_8DEC8D309EA036A5 = vectortoyaw(_id_EFFBD89CEED72F4F);
  _id_8DEC8D309EA036A5 = angleclamp180(_id_8DEC8D309EA036A5);

  for(_id_E3CA7482A8FAA932 = 0; _id_8DEC8D309EA036A5 > _id_D90439D9C610BE2A[_id_E3CA7482A8FAA932]; _id_E3CA7482A8FAA932++) {}

  if(_id_E3CA7482A8FAA932 == 0)
    _id_E3CA7482A8FAA932 = 1;

  statename = self.asm.track.lmg_aim_state;

  for(index = 0; index < _id_70662F647F89D5F7.size; index++) {
    if(index == _id_E3CA7482A8FAA932 || index == _id_E3CA7482A8FAA932 - 1) {
      anim_time = clamp(_id_B943808B345C0C66 / _id_CD2B912C7B5EC142[index], 0.0, 1.0);
      angle_diff = acos(vectordot(_id_9D05D7478C808090[index], _id_EFFBD89CEED72F4F));
      anim_weight = clamp(1 - angle_diff / _id_CD2B912C7B5EC142[index], 0.0, 1.0);
      _id_7F5C44A3B91FA3F7 = scripts\asm\asm::asm_getxanim(statename, _id_70662F647F89D5F7[index]);
      prev_time = self aigetanimtime(_id_7F5C44A3B91FA3F7);

      if(prev_time > 0) {
        _id_228C1F2F3A2D92F1 = getanimlength(_id_7F5C44A3B91FA3F7);
        _id_35A0F5AFB933E47B = (anim_time - prev_time) * _id_228C1F2F3A2D92F1 / 0.05;
        self aisetanimlimited(_id_7F5C44A3B91FA3F7, anim_weight, 0.05, _id_35A0F5AFB933E47B);
      } else {
        self aisetanimlimited(_id_7F5C44A3B91FA3F7, anim_weight, 0.05, 0.0);
        self aisetanimtime(_id_7F5C44A3B91FA3F7, anim_time);
      }

      continue;
    }

    if(_id_70662F647F89D5F7[index] != _id_70662F647F89D5F7[_id_E3CA7482A8FAA932] && _id_70662F647F89D5F7[index] != _id_70662F647F89D5F7[_id_E3CA7482A8FAA932 - 1])
      self aiclearanim(scripts\asm\asm::asm_getxanim(statename, _id_70662F647F89D5F7[index]), 0.05);
  }
}

setanimaimweight(_id_74B08543AE0443F2, goaltime) {
  if(!isDefined(goaltime) || goaltime <= 0) {
    self.a.aimweight = _id_74B08543AE0443F2;
    self.a.aimweight_start = _id_74B08543AE0443F2;
    self.a.aimweight_end = _id_74B08543AE0443F2;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight))
      self.a.aimweight = 0;

    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = _id_74B08543AE0443F2;
    self.a.aimweight_transframes = int(goaltime * 20);
  }

  self.a.aimweight_t = 0;
}

incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    t = 1.0 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
  }
}