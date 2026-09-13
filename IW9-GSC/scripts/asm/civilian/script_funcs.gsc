/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\civilian\script_funcs.gsc
*************************************************/

civilian_init(asmname, statename, params) {
  if(!isDefined(self.asm.customdata))
    self.asm.customdata = spawnStruct();

  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.anglelerprate = 100;
  self.dontsyncmelee = 1;
  self.allowstrafe = 0;

  if(self._id_AE3EA15396B65C1F == "hadir_yth")
    self.pathsmoothmultiplier = 2.0;

  initanimspeedthresholds_civilian(self._id_AE3EA15396B65C1F);
  initmaxspeedforpathlengthtable();

  if(self isscriptable())
    thread initscriptable();

  _id_010B6724C15A95E8::_id_136FB87AD4393EF8();
  civilianfocusstartthread();
}

initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

initanimspeedthresholds_civilian(_id_AE3EA15396B65C1F) {
  _id_68EEB9EEF5B25842 = self getbasearchetype();

  if(!isDefined(_id_68EEB9EEF5B25842))
    _id_68EEB9EEF5B25842 = _id_AE3EA15396B65C1F;

  if(animspeedthresholdsexist(_id_68EEB9EEF5B25842)) {
    return;
  }
  if(_id_68EEB9EEF5B25842 == "farah_civilian") {
    setspeedthreshold(_id_68EEB9EEF5B25842, "walk", 56);
    setspeedthreshold(_id_68EEB9EEF5B25842, "fast", 105);
    setspeedthreshold(_id_68EEB9EEF5B25842, "jog", 170);
    setspeedthreshold(_id_68EEB9EEF5B25842, "run", 220);
    setspeedthreshold(_id_68EEB9EEF5B25842, "sprint", 250);
  } else if(_id_68EEB9EEF5B25842 == "hadir_yth") {
    setspeedthreshold(_id_68EEB9EEF5B25842, "walk", 40);
    setspeedthreshold(_id_68EEB9EEF5B25842, "fast", 102);
    setspeedthreshold(_id_68EEB9EEF5B25842, "jog", 103);
    setspeedthreshold(_id_68EEB9EEF5B25842, "run", 163);
  } else {
    setspeedthreshold(_id_68EEB9EEF5B25842, "walk", 52);
    setspeedthreshold(_id_68EEB9EEF5B25842, "fast", 127);
    setspeedthreshold(_id_68EEB9EEF5B25842, "jog", 153);
    setspeedthreshold(_id_68EEB9EEF5B25842, "run", 220);
  }
}

chooseciviliantransitiontoidleanim(asmname, statename, params) {
  if(isDefined(self.asm.transtoidlealias)) {
    _id_0B6648A33085E43A = self.asm.transtoidlealias;

    if(statename == "trans_out_stand_idle")
      self.asm.transtoidlealias = undefined;

    return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_0B6648A33085E43A);
  } else {
    _id_0B6648A33085E43A = scripts\asm\asm::asm_getrandomalias(statename);
    self.asm.transtoidlealias = _id_0B6648A33085E43A;
    return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_0B6648A33085E43A);
  }
}

choosecivilianreactidleanim(asmname, statename, params) {
  if(isDefined(self.asm.civilianreactionalias)) {
    _id_D4F0250C8D7F6F7C = self.asm.civilianreactionalias;

    if(statename == "trans_out_combat_react")
      self.asm.civilianreactionalias = undefined;

    return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_D4F0250C8D7F6F7C);
  } else {
    _id_BD670C1E0F4290DA = self.asm.transtoidlealias;

    if(scripts\engine\utility::cointoss())
      alias = _id_BD670C1E0F4290DA + "_a";
    else
      alias = _id_BD670C1E0F4290DA + "_b";

    self.asm.civilianreactionalias = alias;
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  }
}

civilian_playexposedloop(asmname, statename, params) {
  self _meth_62004D7561FD321E();
  _id_4FBB46E48F524506 = self asmgetstatetransitioningfrom(asmname);

  if(isDefined(self.node))
    self._blackboard.lastusednode = self.node;

  scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, 1.0);
}

civilian_exit_cleanup(asmname, statename, params) {
  self._blackboard._id_9FBDCE5FA10F8964 = 0;
  civilian_move_cleanup(asmname, statename, params);
}

civilian_playmoveloop(asmname, statename, params) {
  thread civilian_watchspeed(statename);
  scripts\asm\shared\utility::playmoveloop(asmname, statename, params);
}

civilian_playmoveloopblendspace(asmname, statename, param) {
  self endon(statename + "_finished");
  thread civilian_watchspeed(statename);
  self.requestarrivalnotify = 1;
  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 0;
  _id_0C8AAF5BC74C22BB = scripts\asm\asm::asm_lookupanimfromalias(statename, "blank");
  self aisetanim(statename, _id_0C8AAF5BC74C22BB);

  if(istrue(param)) {
    if(isDefined(self._blackboard._id_610CB18ECC1AF719)) {
      self._blackboard.civilianfocustargetentity = self._blackboard._id_610CB18ECC1AF719;
      _id_6C542B356D086308 = civilianfocuscomputeyawtotarget();
      _id_6C542B356D086308 = _id_6C542B356D086308 / 180.0;
      civilianfocusupdateanimparameter(_id_6C542B356D086308);
    }
  }

  for(;;)
    scripts\asm\asm::asm_donotetracks(asmname, statename);
}

civilian_watchspeed(statename) {
  self endon(statename + "_finished");

  if(isDefined(self.stayahead) && istrue(self.stayahead.active)) {
    return;
  }
  if(isDefined(self._blackboard.requestedspeed))
    self aisetdesiredspeed(self._blackboard.requestedspeed);

  while(!isDefined(self.stayahead) || !istrue(self.stayahead.active)) {
    if(self aigetdesiredspeed() > 153 && self pathdisttogoal() < 200 && !istrue(self.disablearrivals))
      self aisetdesiredspeed(153);

    waitframe();
  }
}

civilian_playsharpturnanim(asmname, statename, params) {
  self endon(statename + "_finished");
  turnanim = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_19B744B1CDEE4BCB = scripts\asm\asm::asm_getxanim(statename, turnanim);
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  turnrate = self.moveplaybackrate;
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_19B744B1CDEE4BCB);
  self aisetanim(statename, turnanim, turnrate);
  childthread _id_F350CD100563ACAF(_id_19B744B1CDEE4BCB, turnrate);
  _id_A234A65C378F3289 = scripts\asm\asm::asm_donotetracks(asmname, statename, ::_id_ACFE95F0C8655298, _id_19B744B1CDEE4BCB, undefined, 0);
  self motionwarpcancel();
  self orientmode("face enemy or motion");
  self animmode("normal", 0);

  if(_id_A234A65C378F3289 == "code_move") {
    self.requestarrivalnotify = 1;
    _id_D32FF27E82AB0ACC = getnotetracktimes(_id_19B744B1CDEE4BCB, "finish");

    if(_id_D32FF27E82AB0ACC.size > 0)
      scripts\asm\asm::asm_donotetracks(asmname, statename);
  }
}

_id_F350CD100563ACAF(_id_19B744B1CDEE4BCB, turnrate) {
  waitframe();
  _id_2D640A3E5DD38229 = getnotetracktimes(_id_19B744B1CDEE4BCB, "corner");

  if(_id_2D640A3E5DD38229.size > 0) {
    _id_72909A83A7755195 = _id_2D640A3E5DD38229[0];
    animlength = getanimlength(_id_19B744B1CDEE4BCB);
    _id_6B7BEE46F2C6DA28 = level.frameduration / 1000 / animlength;
    _id_07A0C9FC25755B0E = getmovedelta(_id_19B744B1CDEE4BCB, _id_6B7BEE46F2C6DA28, _id_72909A83A7755195);
    _id_E24356ACAD189F01 = (0, getangledelta(_id_19B744B1CDEE4BCB, _id_6B7BEE46F2C6DA28, _id_72909A83A7755195), 0);
    animduration = animlength * _id_72909A83A7755195 / turnrate;

    if(animduration > 0.05) {
      self.useanimgoalweight = 1;
      self _meth_2664AB4A4AB7100C(_id_07A0C9FC25755B0E, _id_E24356ACAD189F01, animduration);
    }
  }
}

_id_ACFE95F0C8655298(_id_A234A65C378F3289, params) {
  if(_id_A234A65C378F3289 == "corner") {
    self motionwarpcancel();

    if(!isDefined(self.pathgoalpos)) {
      return;
    }
    if(self.lookaheaddist > 4)
      _id_FDF39D9DBEEB2986 = vectortoyaw(self.lookaheaddir);
    else
      return;

    _id_19B744B1CDEE4BCB = params;
    _id_6955B58947031CD2 = getnotetracktimes(_id_19B744B1CDEE4BCB, "corner");
    _id_1CF3CC2BFBD90835 = getnotetracktimes(_id_19B744B1CDEE4BCB, "code_move");
    endtime = 1;

    if(_id_1CF3CC2BFBD90835.size > 0)
      endtime = _id_1CF3CC2BFBD90835[0];

    duration = (endtime - _id_6955B58947031CD2[0]) * getanimlength(_id_19B744B1CDEE4BCB) * 1000;

    if(duration < level.frameduration) {
      return;
    }
    _id_95ABCCFE668F369A = getmovedelta(_id_19B744B1CDEE4BCB, _id_6955B58947031CD2[0], endtime);
    _id_E24356ACAD189F01 = getangledelta(_id_19B744B1CDEE4BCB, _id_6955B58947031CD2[0], endtime);
    _id_077B9E4B599269EB = angleclamp180(_id_FDF39D9DBEEB2986 - self.angles[1] - _id_E24356ACAD189F01);

    if(abs(_id_077B9E4B599269EB) > 60) {
      return;
    }
    _id_6D41C6838B4B4E02 = (0, _id_FDF39D9DBEEB2986 - _id_E24356ACAD189F01, 0);
    targetpos = self.origin + rotatevector(_id_95ABCCFE668F369A, self.angles);
    targetpos = getclosestpointonnavmesh(targetpos, self, 0, 1);
    _id_94E50BB8653F6C84 = targetpos - rotatevector(_id_95ABCCFE668F369A, _id_6D41C6838B4B4E02);
    self motionwarpwithanim(_id_94E50BB8653F6C84, _id_6D41C6838B4B4E02, targetpos, (0, _id_FDF39D9DBEEB2986, 0), int(duration));
  }
}

civilian_move_cleanup(asmname, statename, params) {
  self motionwarpcancel();
}

iswhizbydetected(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_iswhizbyrequested();
}

shoulddirectlytransition(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(iswhizbydetected() || scripts\asm\asm_bb::bb_getcivilianstate() == "combat") {
    alias = self.asm.transtoidlealias;

    if(alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07")
      return 1;
  }

  return 0;
}

shouldcustomtransition(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm_bb::bb_getcivilianstate() == "noncombat") {
    alias = self.asm.transtoidlealias;

    if(alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07")
      return 1;
  }

  return 0;
}

cleanupcivilianreactionalias(asmname, statename, params) {
  self.asm.civilianreactionalias = undefined;
}

shouldsnaptocover(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm_bb::bb_moverequested())
    return 0;

  if(!scripts\asm\shared\utility::isatcovernode())
    return 0;

  if(!isDefined(self.node))
    return 0;

  if(isDefined(self.primaryweapon) && _id_2B79931B08683E0A::isusingsidearm() && weaponclass(self.primaryweapon) != "mg")
    return 0;

  if(!isDefined(params))
    return 1;

  return scripts\asm\shared\utility::isarrivaltype(asmname, statename, _id_F2B19B25D457C2A6, params);
}

enableciviliantargetfocus(ent, direction) {
  if(!isDefined(ent)) {
    return;
  }
  self._blackboard.civilianfocustargetentity = ent;
  self._blackboard.civilianfocusstate = 1;

  if(!isDefined(direction))
    self._blackboard.civilianfocusdirection = "";
  else
    self._blackboard.civilianfocusdirection = direction;

  self notify("civilian_focus_thread_enabled");
  civilianfocusstartthread();
}

disableciviliantargetfocus() {
  self._blackboard.civilianfocustargetentity = undefined;
  self._blackboard.civilianfocusstate = 2;
}

civilianfocusstartthread() {
  if(isDefined(self._blackboard.civilianfocusthreadrunning)) {
    return;
  }
  self._blackboard.civilianfocusthreadrunning = 1;
  self._blackboard.civilianfocusstate = 0;
  self._blackboard.civilianfocuscurvalue = 0.0;
  thread civilianfocusupdatethread();
}

civilianfocuscomputeyawtotarget() {
  _id_A5106610AD76D39B = self._blackboard.civilianfocustargetentity.origin - self.origin;
  _id_A5106610AD76D39B = (_id_A5106610AD76D39B[0], _id_A5106610AD76D39B[1], 0.0);
  _id_5290B84B388B75D7 = vectortoangles(_id_A5106610AD76D39B);
  return angleclamp180(_id_5290B84B388B75D7[1] - self.angles[1]);
}

civilianfocusupdatecurrentfocus(_id_063A7BA4C102C8FD) {
  _id_B1DBABBA77C6A3F1 = 0.5;
  _id_128B23694D81A9B7 = 1.0 / _id_B1DBABBA77C6A3F1;
  _id_6B7BEE46F2C6DA28 = gettime();
  _id_4CEC6FA3FD0B423B = _id_6B7BEE46F2C6DA28 - self._blackboard.civilianfocuslasttime;
  self._blackboard.civilianfocuslasttime = _id_6B7BEE46F2C6DA28;
  currentvalue = self._blackboard.civilianfocuscurvalue;
  _id_4573A8725DD3748E = _id_063A7BA4C102C8FD - currentvalue;

  if(abs(_id_4573A8725DD3748E) > 0.01) {
    _id_FE828272EC411EFC = scripts\engine\utility::sign(_id_063A7BA4C102C8FD - currentvalue);
    _id_8F617FFD000EB682 = self._blackboard.civilianfocuscurvalue + _id_4CEC6FA3FD0B423B / 1000.0 * _id_128B23694D81A9B7 * _id_FE828272EC411EFC;
    _id_8F617FFD000EB682 = clamp(_id_8F617FFD000EB682, -1.0, 1.0);
    self._blackboard.civilianfocuscurvalue = _id_8F617FFD000EB682;
    return 0;
  }

  self._blackboard.civilianfocuscurvalue = _id_063A7BA4C102C8FD;
  return 1;
}

civilianfocusapproachingarrival() {
  _id_CC40BDDE3E81B83C = self aigettargetspeed();

  if(!self codemoverequested() || self pathdisttogoal() < _id_CC40BDDE3E81B83C * 1.3)
    return 1;
  else if(istrue(self._blackboard._id_9FBDCE5FA10F8964))
    return 1;

  return 0;
}

civilianfocusupdateanimparameter(_id_31061608BE28412F) {
  self _meth_2219BC2B5BE8918A(_id_31061608BE28412F);
}

civilianfocusupdatethread() {
  self endon("death");
  _id_00185BE4B1E6FEB6 = -1.0;
  _id_9AE98138A32C9405 = 1.0;
  _id_146B23F5A71E5333 = 170;
  _id_DF301AACF68898C7 = -170;
  self._blackboard.civilianfocuslasttime = 0;

  for(;;) {
    state = self._blackboard.civilianfocusstate;
    direction = self._blackboard.civilianfocusdirection;

    if(state == 0) {
      self waittill("civilian_focus_thread_enabled");
      self._blackboard.civilianfocuslasttime = gettime();
    } else if(state == 1) {
      _id_6C542B356D086308 = civilianfocuscomputeyawtotarget();
      _id_91F3F4366E4D2F1C = abs(_id_6C542B356D086308);

      if(civilianfocusapproachingarrival() || _id_91F3F4366E4D2F1C > 90)
        self._blackboard.civilianfocusstate = 5;
      else if(direction == "left")
        self._blackboard.civilianfocusstate = 3;
      else if(direction == "right")
        self._blackboard.civilianfocusstate = 4;
      else if(_id_6C542B356D086308 != 0)
        self._blackboard.civilianfocusstate = 6;
    } else if(state == 2)
      self._blackboard.civilianfocusstate = 7;
    else if(state == 5) {
      civilianfocusupdatecurrentfocus(0.0);

      if(!civilianfocusapproachingarrival() && isalive(self._blackboard.civilianfocustargetentity)) {
        _id_6C542B356D086308 = civilianfocuscomputeyawtotarget();

        if(abs(_id_6C542B356D086308) < 90) {
          if(direction == "left")
            self._blackboard.civilianfocusstate = 3;
          else if(direction == "right")
            self._blackboard.civilianfocusstate = 4;
          else if(_id_6C542B356D086308 != 0)
            self._blackboard.civilianfocusstate = 6;
        }
      }

      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);
    } else if(state == 6) {
      _id_6C542B356D086308 = civilianfocuscomputeyawtotarget();
      _id_DF693A224F2E44C4 = clamp(_id_6C542B356D086308, -45, 45) / 45.0;
      civilianfocusupdatecurrentfocus(_id_DF693A224F2E44C4);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival())
        self._blackboard.civilianfocusstate = 5;
    } else if(state == 3) {
      civilianfocusupdatecurrentfocus(_id_00185BE4B1E6FEB6);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival())
        self._blackboard.civilianfocusstate = 5;
      else {
        _id_6C542B356D086308 = civilianfocuscomputeyawtotarget();

        if(abs(_id_6C542B356D086308) < 90)
          self._blackboard.civilianfocusstate = 5;
        else if(direction == "right" || _id_6C542B356D086308 > _id_DF301AACF68898C7 && _id_6C542B356D086308 < -90)
          self._blackboard.civilianfocusstate = 4;
      }
    } else if(state == 4) {
      civilianfocusupdatecurrentfocus(_id_9AE98138A32C9405);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival())
        self._blackboard.civilianfocusstate = 5;
      else {
        _id_6C542B356D086308 = civilianfocuscomputeyawtotarget();

        if(abs(_id_6C542B356D086308) < 90)
          self._blackboard.civilianfocusstate = 5;
        else if(direction == "left" || _id_6C542B356D086308 > 90 && _id_6C542B356D086308 < _id_146B23F5A71E5333)
          self._blackboard.civilianfocusstate = 3;
      }
    } else if(state == 7) {
      done = civilianfocusupdatecurrentfocus(0.0);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(done)
        self._blackboard.civilianfocusstate = 0;
    }

    waitframe();
  }
}

civmoverequested(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_moverequested() && !istrue(self._blackboard.partialgestureplaying);
}

civilian_chooseanim_demeanor(asmname, statename, params) {
  if(isDefined(params))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\asm\asm_bb::bb_getcivilianstate() + params);
  else
    return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\asm\asm_bb::bb_getcivilianstate());
}

civilian_chooseanim_playerpushed(asmname, statename, params) {
  _id_F449E4F8397F13E7 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");
  _id_D5BE0521E83DF112 = vectorNormalize(_id_F449E4F8397F13E7);
  targetangles = vectortoangles(_id_D5BE0521E83DF112);
  _id_623F3095ECFA11FF = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = scripts\asm\asm::yawdiffto2468(_id_623F3095ECFA11FF);
  aliasname = "pushed_" + angleindex;
  turnanim = scripts\asm\asm::asm_lookupanimfromalias(statename, aliasname);
  return turnanim;
}

_id_B1BBE0DC316F2EFA(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._id_C4242158ADAEADD2))
    return 0;

  return scripts\asm\asm_bb::bb_getcivilianstate() == "casual";
}

_id_C41DE664204E9824(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_24C6F607CFEED805 = level.player.origin - self.origin;
  setdvarifuninitialized("dvar_E423C827CA27E5C4", 120.0);
  dist = getdvarfloat("dvar_E423C827CA27E5C4", 120.0);
  dist = dist * dist;

  if(lengthsquared(_id_24C6F607CFEED805) > dist)
    return 0;

  _id_DDD5FB570E804BF0 = anglesToForward(self.angles);

  if(vectordot(_id_24C6F607CFEED805, _id_DDD5FB570E804BF0) < 0.0)
    return 0;

  _id_20AF753DED3657E1 = anglesToForward(level.player.angles);

  if(vectordot(_id_20AF753DED3657E1, _id_DDD5FB570E804BF0) > 0.0)
    return 0;

  return 1;
}

_id_7BD81EFB0ABDBC44(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_DB51C3E732A073B4 = 100.0;
  _id_1199D18507DB6169 = getaiarrayinradius(self.origin, _id_DB51C3E732A073B4);

  if(!isDefined(_id_1199D18507DB6169))
    return 0;

  _id_E7E2A008BFDCDB17 = self getposonpath(100);
  _id_DDD5FB570E804BF0 = vectorNormalize(_id_E7E2A008BFDCDB17 - self.origin);
  _id_94A0CE62771E3A6D = undefined;
  distsq = _id_DB51C3E732A073B4 * _id_DB51C3E732A073B4;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1199D18507DB6169.size; _id_AC0E594AC96AA3A8++) {
    if(self == _id_1199D18507DB6169[_id_AC0E594AC96AA3A8]) {
      continue;
    }
    _id_F04BA7F687E1B89E = _id_1199D18507DB6169[_id_AC0E594AC96AA3A8].origin - self.origin;
    dot = vectordot(_id_F04BA7F687E1B89E, _id_DDD5FB570E804BF0);

    if(dot < 0.0) {
      continue;
    }
    _id_D1CEA5FF06C3D300 = anglesToForward(_id_1199D18507DB6169[_id_AC0E594AC96AA3A8].angles);

    if(vectordot(_id_DDD5FB570E804BF0, _id_D1CEA5FF06C3D300) > 0.0) {
      continue;
    }
    _id_9EBE5D170917CA3D = _id_F04BA7F687E1B89E - _id_DDD5FB570E804BF0 * dot;

    if(length2dsquared(_id_9EBE5D170917CA3D) > 625.0) {
      continue;
    }
    _id_70BBCC66E8971969 = lengthsquared(_id_F04BA7F687E1B89E);

    if(_id_70BBCC66E8971969 < distsq) {
      distsq = _id_70BBCC66E8971969;
      _id_94A0CE62771E3A6D = _id_1199D18507DB6169[_id_AC0E594AC96AA3A8];
    }
  }

  if(!isDefined(_id_94A0CE62771E3A6D))
    return 0;

  self._id_AE59F0B817468ED7 = _id_94A0CE62771E3A6D;
  return 1;
}

_id_0E481D310D5CB87C(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_1199D18507DB6169 = self._id_AE59F0B817468ED7;
  _id_F04BA7F687E1B89E = _id_1199D18507DB6169.origin - self.origin;
  forward = anglesToForward(self.angles);

  if(length(_id_F04BA7F687E1B89E) > 200)
    return 1;

  _id_9BB5325F15E20E1D = vectordot(_id_F04BA7F687E1B89E, forward) < -20.0;
  return _id_9BB5325F15E20E1D;
}

_id_AE83A6295A6675C8(asmname, statename, params) {
  if(isDefined(self._id_B5780490703AB4D1))
    _id_FE8F7703F6313ED4 = self._id_B5780490703AB4D1;
  else
    _id_FE8F7703F6313ED4 = randomint(7) + 1;

  self._id_B18D004BEE7CA764 = _id_FE8F7703F6313ED4;
  return scripts\asm\asm::asm_lookupanimfromalias(statename, "walk_" + _id_FE8F7703F6313ED4);
}

_id_D13115C5F7B949E6(asmname, statename, params) {
  _id_24C6F607CFEED805 = level.player.origin - self.origin;
  forward = anglesToForward(self.angles);
  _id_775361D05A790917 = vectorcross(forward, _id_24C6F607CFEED805);
  _id_FE8F7703F6313ED4 = 1;

  if(isDefined(self._id_B18D004BEE7CA764))
    _id_FE8F7703F6313ED4 = self._id_B18D004BEE7CA764;

  alias = undefined;

  if(_id_775361D05A790917[2] < 0.0)
    alias = "avoid_" + _id_FE8F7703F6313ED4 + "_l";
  else
    alias = "avoid_" + _id_FE8F7703F6313ED4 + "_r";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_D98F49AEB63EDCE4(asmname, statename, params) {
  _id_1199D18507DB6169 = self._id_AE59F0B817468ED7;
  _id_F04BA7F687E1B89E = _id_1199D18507DB6169.origin - self.origin;
  forward = anglesToForward(self.angles);
  _id_775361D05A790917 = vectorcross(forward, _id_F04BA7F687E1B89E);
  _id_FE8F7703F6313ED4 = 1;

  if(isDefined(self._id_B18D004BEE7CA764))
    _id_FE8F7703F6313ED4 = self._id_B18D004BEE7CA764;

  alias = undefined;

  if(_id_775361D05A790917[2] < 0.0)
    alias = "avoid_" + _id_FE8F7703F6313ED4 + "_l";
  else
    alias = "avoid_" + _id_FE8F7703F6313ED4 + "_r";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_C4D5A733F656507F(asmname, statename, params) {
  self._id_AE59F0B817468ED7 = undefined;
}

_id_7490810D9786CC51(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._id_A57082FDF62BC898);
}

_id_28D7E9D4C9615969(asmname, statename, _id_F2B19B25D457C2A6, params) {
  self endon(statename + "_finished");
  turnanim = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_19B744B1CDEE4BCB = scripts\asm\asm::asm_getxanim(statename, turnanim);
  self.useanimgoalweight = 1;
  rate = 1;

  if(!isDefined(params) || params[2]) {
    _id_4A19093291D2C8CB = randomfloatrange(-0.2, 0.2);
    rate = rate + _id_4A19093291D2C8CB;
  }

  if(isai(self))
    self aisetanim(statename, turnanim, rate);
  else {
    _id_34EE65B16925D791 = scripts\asm\asm::asm_lookupanimfromalias("knobs", "body");
    _id_A0917315F76AB3F2 = scripts\asm\asm::asm_getxanim("knobs", _id_34EE65B16925D791);
    self setflaggedanimknoballrestart(statename, _id_19B744B1CDEE4BCB, _id_A0917315F76AB3F2, 1, 0.2, 1.0);
  }

  if(!isDefined(params) || params[1])
    thread _id_44224A1150C6D2C9(_id_19B744B1CDEE4BCB, statename);

  _id_3931FF7E891D898F = scripts\asm\asm::asm_getnotehandler(asmname, statename);
  scripts\asm\asm::asm_donotetracks(asmname, statename, _id_3931FF7E891D898F);
}

_id_44224A1150C6D2C9(_id_19B744B1CDEE4BCB, statename) {
  self endon("death");
  self endon(statename + "_finished");
  player = undefined;
  animlength = getanimlength(_id_19B744B1CDEE4BCB);

  if(animhasnotetrack(_id_19B744B1CDEE4BCB, "start_aim")) {
    _id_6AA303AAB36EA0EA = getnotetracktimes(_id_19B744B1CDEE4BCB, "start_aim");
    animlength = animlength * _id_6AA303AAB36EA0EA[0];
  } else if(animhasnotetrack(_id_19B744B1CDEE4BCB, "finish")) {
    _id_6AA303AAB36EA0EA = getnotetracktimes(_id_19B744B1CDEE4BCB, "finish");
    animlength = animlength * _id_6AA303AAB36EA0EA[0];
  }

  _id_7E3211AE44B15B55 = int(animlength * 20);
  _id_0C3DDCD0C37A60C5 = _id_7E3211AE44B15B55;
  _id_9BBFD0995D51760C = scripts\asm\shared\utility::_id_75996A8DAC6970F2(1024);

  if(isai(self)) {
    while(_id_0C3DDCD0C37A60C5 > 0) {
      _id_6BDB8335862F56EE = 1 / _id_0C3DDCD0C37A60C5;
      _id_A0F270EA6DC74BF3 = angleclamp180(vectortoyaw(_id_9BBFD0995D51760C - self.origin) - self.angles[1]);
      _id_03572E193DBCA166 = self aigetanimtime(_id_19B744B1CDEE4BCB);
      _id_993A8F9635E274CF = getangledelta(_id_19B744B1CDEE4BCB, _id_03572E193DBCA166, 1.0);
      _id_B1CBDF386B2C0DEA = angleclamp180(_id_A0F270EA6DC74BF3 - _id_993A8F9635E274CF);
      self orientmode("face angle", angleclamp(self.angles[1] + _id_B1CBDF386B2C0DEA * _id_6BDB8335862F56EE));
      _id_0C3DDCD0C37A60C5--;
      wait 0.05;
    }
  } else {
    while(_id_0C3DDCD0C37A60C5 > 0) {
      _id_6BDB8335862F56EE = 1 / _id_0C3DDCD0C37A60C5;
      _id_A0F270EA6DC74BF3 = angleclamp180(vectortoyaw(_id_9BBFD0995D51760C - self.origin) - self.angles[1]);
      _id_03572E193DBCA166 = self getanimtime(_id_19B744B1CDEE4BCB);
      _id_993A8F9635E274CF = getangledelta(_id_19B744B1CDEE4BCB, _id_03572E193DBCA166, 1.0);
      _id_B1CBDF386B2C0DEA = angleclamp180(_id_A0F270EA6DC74BF3 - _id_993A8F9635E274CF);
      yaw = angleclamp(self.angles[1] + _id_B1CBDF386B2C0DEA * _id_6BDB8335862F56EE);
      self.angles = (0, yaw, 0);
      _id_0C3DDCD0C37A60C5--;
      wait 0.05;
    }
  }
}

_id_8582E56563261E62(asmname, statename, params) {
  target = scripts\asm\shared\utility::_id_75996A8DAC6970F2(1024);

  if(isDefined(params) &isstring(params) && params == "return" && isDefined(self._id_718D80100704CC82))
    target = self._id_718D80100704CC82 + (0, 0, 55) + anglesToForward(self._id_A70672E669CA7F00) * 10;

  _id_935CE979BB3EF270 = vectortoyaw(target - self.origin);
  _id_077B9E4B599269EB = angleclamp180(_id_935CE979BB3EF270 - self.angles[1]);
  turnanim = undefined;

  if(isDefined(params) && params == "cardinal") {
    _id_5263A610669EFA35 = abs(_id_077B9E4B599269EB);
    animindex = "2";

    if(_id_5263A610669EFA35 > 135)
      animindex = "8";
    else if(_id_077B9E4B599269EB > 45 && _id_077B9E4B599269EB <= 135)
      animindex = "6";
    else if(_id_077B9E4B599269EB >= -135 && _id_077B9E4B599269EB < -45)
      animindex = "4";

    turnanim = scripts\asm\asm::asm_lookupanimfromalias(statename, animindex);
  } else {
    _id_3FBFA3AB7B1FB0F2 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
    animindex = getangleindex(_id_077B9E4B599269EB, 22.5);
    turnanim = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_3FBFA3AB7B1FB0F2[animindex]);
  }

  return turnanim;
}

_id_4BE295E4306DC70C(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return distancesquared(self.goalpos, self.origin) < params * params;
}

_id_89007AE298FB4B15(asmname, statename, params) {
  scripts\engine\utility::set_movement_speed(52);
}

_id_E7FC2FE7DDA8FC2C(asmname, statename, params) {
  scripts\engine\utility::set_movement_speed(127);
}

_id_94EC448629B086C8(asmname, statename, params) {
  scripts\engine\utility::set_movement_speed(153);
}

_id_D45457463F7A8EAB(asmname, statename, params) {
  scripts\engine\utility::set_movement_speed(220);
}

_id_92C056EC351F2F6E(asmname, statename, param) {
  if(isDefined(self._blackboard.requestedspeed) && self._blackboard.requestedspeed < 70)
    scripts\engine\utility::set_movement_speed(70);
}