/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\patrol.gsc
***********************************************/

_id_3ABA5F22B60D37F5() {
  scripts\aitypes\stealth::initstealthfunctions();
  self._id_5221CB0637CD44E7 = ::attachflashlight;
  self.fnstealthflashlightdetach = ::detachflashlight;
}

playanim_patrolreact_internal(asmname, statename, _id_004EF793291A6A73) {
  self._id_DE7AB32958C52392 = self._id_FD01AD49B4E38AE8;

  if(shouldpatrolreactaim()) {
    if(isDefined(self._id_1C9ED4A46D13EDC9) && distance2dsquared(self.origin, self._id_1C9ED4A46D13EDC9) > 1024)
      self setlookat(self._id_1C9ED4A46D13EDC9);
  }

  _id_93A2C35BC9547955 = self asmgetanim(asmname, statename);
  _id_9319232E93B989ED = scripts\asm\asm::asm_getxanim(_id_004EF793291A6A73, _id_93A2C35BC9547955);
  _id_07B60BC0EAB3FD1E = 1;

  if(isDefined(self._id_AEBF462EC3F3362D)) {
    endtime = 1;
    _id_1CF3CC2BFBD90835 = getnotetracktimes(_id_9319232E93B989ED, "code_move");

    if(_id_1CF3CC2BFBD90835.size > 0)
      endtime = _id_1CF3CC2BFBD90835[0];

    animlength = getanimlength(_id_9319232E93B989ED) * endtime;
    _id_E01C6C89A1EB3D21 = 0.05 + (self._id_AEBF462EC3F3362D - gettime()) / 1000;

    if(_id_E01C6C89A1EB3D21 < 0.2)
      _id_E01C6C89A1EB3D21 = 0.2;

    _id_07B60BC0EAB3FD1E = clamp(animlength / _id_E01C6C89A1EB3D21, 0.8, 1.3);
    self._id_AEBF462EC3F3362D = undefined;
  }

  self aisetanim(_id_004EF793291A6A73, _id_93A2C35BC9547955, _id_07B60BC0EAB3FD1E);
  self _meth_DF303D9C05757E6B(_id_93A2C35BC9547955, _id_004EF793291A6A73);
  scripts\asm\asm::asm_donotetrackswithinterceptor(asmname, statename, ::flashlightreactionnotehandler, undefined, _id_004EF793291A6A73);
}

shouldpatrolreactaim(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._id_FD01AD49B4E38AE8 == "med";
}

chooseanim_patrolreactlookaround(asmname, statename, params) {
  alias = "curious";

  if(self _meth_129CBB4366307F50("med") || self[[self.fnisinstealthcombat]]())
    alias = "threat";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\engine\utility::string(alias));
}

chooseanim_patrolreactlookaround_checkflashlight(asmname, statename, params) {
  alias = scripts\engine\utility::string(getpatrolreactdirindex());

  if(self _meth_129CBB4366307F50("med") || self[[self.fnisinstealthcombat]]())
    alias = "threat_" + alias;

  return chooseanim_patrol_checkflashlight(asmname, statename, alias);
}

getpatrolreactdirindex() {
  _id_C5E576CF2978534B = 0;

  if(isDefined(self._id_1C9ED4A46D13EDC9)) {
    _id_3777ECE6A73EADA5 = self._id_1C9ED4A46D13EDC9 - self.origin;

    if(length2dsquared(_id_3777ECE6A73EADA5) < 36)
      _id_C5E576CF2978534B = 0;
    else {
      _id_B98EE2D4674EBBE8 = vectortoyaw(_id_3777ECE6A73EADA5);
      _id_C5E576CF2978534B = self.angles[1] - _id_B98EE2D4674EBBE8;
    }
  }

  return getreactangleindex(_id_C5E576CF2978534B);
}

_id_A23A26ADCF97FDD0() {
  _id_C5E576CF2978534B = 0;

  if(isDefined(self._id_1C9ED4A46D13EDC9)) {
    _id_3777ECE6A73EADA5 = self._id_1C9ED4A46D13EDC9 - self.origin;
    _id_B98EE2D4674EBBE8 = vectortoyaw(_id_3777ECE6A73EADA5);
    _id_C5E576CF2978534B = self.angles[1] - _id_B98EE2D4674EBBE8;
  }

  _id_C5E576CF2978534B = angleclamp180(_id_C5E576CF2978534B);
  _id_394EFCEF72C7EBEA = _id_DE2AA7EB339A432C(_id_C5E576CF2978534B);
  _id_0E4731409BD255E0 = _id_394EFCEF72C7EBEA;

  if(_id_C5E576CF2978534B < -120 && _id_C5E576CF2978534B > -180)
    _id_0E4731409BD255E0 = _id_0E4731409BD255E0 + "l";
  else if(_id_C5E576CF2978534B > 120 && _id_C5E576CF2978534B < 180)
    _id_0E4731409BD255E0 = _id_0E4731409BD255E0 + "r";

  return _id_0E4731409BD255E0;
}

getpatrolreactalias() {
  _id_0E4731409BD255E0 = _id_A23A26ADCF97FDD0();

  if(self._id_EE027A8F98390896)
    alias = self._id_FD01AD49B4E38AE8 + "_close_" + _id_0E4731409BD255E0;
  else
    alias = self._id_FD01AD49B4E38AE8 + "_" + _id_0E4731409BD255E0;

  return alias;
}

chooseanim_patrolreact(asmname, statename, params) {
  alias = getpatrolreactalias();
  animindex = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);

  if(!isDefined(animindex)) {
    if(scripts\asm\asm::asm_hasalias(statename, "med_8"))
      return scripts\asm\asm::asm_lookupanimfromalias(statename, "med_8");
    else
      return scripts\asm\asm::asm_lookupanimfromalias(statename, "small_8");
  }

  return animindex;
}

chooseanim_patrolreact_checkflashlight(asmname, statename, params) {
  alias = getpatrolreactalias();
  return chooseanim_patrol_checkflashlight(asmname, statename, alias);
}

getreactangleindex(angle) {
  angle = angleclamp180(angle);

  if(angle > 135 || angle < -135)
    index = 2;
  else if(angle < -45)
    index = 4;
  else if(angle > 45)
    index = 6;
  else
    index = 8;

  return index;
}

_id_DE2AA7EB339A432C(angle) {
  angle = angleclamp180(angle);

  if(angle > 120 || angle < -120)
    index = 2;
  else if(angle < -30)
    index = 4;
  else if(angle > 30)
    index = 6;
  else
    index = 8;

  return index;
}

_id_07889A8A760C6E02(turnanim, _id_2DB201E40E7AAF8C, _id_B8B42FEE0A565EE5, endtime) {
  _id_03572E193DBCA166 = self aigetanimtime(turnanim);
  _id_61F0E2AC4FDA97C7 = getangledelta(turnanim, _id_03572E193DBCA166, endtime) + _id_B8B42FEE0A565EE5;
  _id_397E17331B6DFE74 = self.angles[1] + _id_61F0E2AC4FDA97C7;
  _id_2AE9E639905974A1 = angleclamp180(_id_2DB201E40E7AAF8C - angleclamp(_id_397E17331B6DFE74));
  return _id_2AE9E639905974A1;
}

handlefacegoalnotetrack(statename, _id_A234A65C378F3289, params) {
  if(_id_A234A65C378F3289 == "face_goal" && isDefined(self._id_1C9ED4A46D13EDC9)) {
    xanim = scripts\asm\asm::asm_getxanim(self._id_39798B565DE83C7B, self._id_D1A6890D054957E7);

    if(!isDefined(xanim))
      return 0;

    _id_63D9E852FB3AF677 = getnotetracktimes(xanim, "finish");

    if(_id_63D9E852FB3AF677.size == 0)
      _id_63D9E852FB3AF677[0] = 1;

    _id_3611C8E9F9A8D539 = getnotetracktimes(xanim, "combat_early_out");
    _id_53C95344C2AB768F = 1;

    if(_id_3611C8E9F9A8D539.size == 0 || !self[[self.fnisinstealthcombat]]()) {
      _id_53C95344C2AB768F = 0;
      _id_3611C8E9F9A8D539[0] = 1;
    }

    endtime = getnotetracktimes(xanim, "face_goal_end");

    if(endtime.size == 0)
      endtime[0] = _id_63D9E852FB3AF677[0];

    if(_id_3611C8E9F9A8D539[0] < endtime[0])
      endtime[0] = _id_3611C8E9F9A8D539[0];

    _id_55D50EDB133ACB1B = getnotetracktimes(xanim, "face_goal");
    _id_EB5B1F36E255152D = _id_55D50EDB133ACB1B[0];
    _id_07B60BC0EAB3FD1E = self getanimrate(xanim);

    if(_id_07B60BC0EAB3FD1E == 0)
      _id_07B60BC0EAB3FD1E = 1;

    _id_228C1F2F3A2D92F1 = getanimlength(xanim) / _id_07B60BC0EAB3FD1E;
    _id_043530DE5F95F2F7 = endtime[0] - _id_EB5B1F36E255152D;
    _id_043530DE5F95F2F7 = _id_043530DE5F95F2F7 * _id_228C1F2F3A2D92F1;
    _id_B8B42FEE0A565EE5 = 0;

    if(!_id_53C95344C2AB768F && endtime[0] < _id_63D9E852FB3AF677[0])
      _id_B8B42FEE0A565EE5 = getangledelta(xanim, endtime[0], _id_63D9E852FB3AF677[0]);

    _id_63CC85541246C7B4 = self._id_1C9ED4A46D13EDC9 - self.origin;
    _id_1402D870C92DF1AF = vectortoyaw(_id_63CC85541246C7B4);
    _id_2AE9E639905974A1 = _id_07889A8A760C6E02(xanim, _id_1402D870C92DF1AF, _id_B8B42FEE0A565EE5, endtime[0]);
    thread facegoalthread(statename, _id_2AE9E639905974A1, _id_B8B42FEE0A565EE5, self._id_1C9ED4A46D13EDC9, _id_1402D870C92DF1AF, _id_043530DE5F95F2F7, xanim, endtime[0]);
    return 1;
  }

  return 0;
}

facegoalthread(statename, _id_2AE9E639905974A1, _id_B8B42FEE0A565EE5, _id_45C909CECC77138A, _id_1402D870C92DF1AF, _id_043530DE5F95F2F7, turnanim, endtime) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(statename + "_finished");
  _id_1AAD8F38CB38F703 = ceil(_id_043530DE5F95F2F7 * (1000 / level.frameduration));
  _id_D00AB4A1A5F59A50 = _id_2AE9E639905974A1 / _id_1AAD8F38CB38F703;
  _id_72C012A18C9E68F9 = undefined;
  _id_3C240B5D60B82FC4 = 0;

  while(_id_1AAD8F38CB38F703 > 0) {
    _id_05436F99DA0AB0D6 = self.enemy;

    if(!isDefined(_id_05436F99DA0AB0D6)) {
      if(isDefined(self._id_33107DCB50DF3CDE) && isPlayer(self._id_33107DCB50DF3CDE))
        _id_05436F99DA0AB0D6 = self._id_33107DCB50DF3CDE;
    }

    bcansee = 0;

    if(isDefined(_id_05436F99DA0AB0D6) && issentient(_id_05436F99DA0AB0D6)) {
      _id_47203C042B64F03C = self lastknownpos(_id_05436F99DA0AB0D6);
      _id_77E1544BD35826E5 = self lastknowntime(_id_05436F99DA0AB0D6);

      if(!bcansee)
        bcansee = self cansee(_id_05436F99DA0AB0D6);

      _id_0522F11C665D62DF = 0;

      if(bcansee) {
        if(distancesquared(self._id_1C9ED4A46D13EDC9, _id_05436F99DA0AB0D6.origin) >= 225) {
          self._id_1C9ED4A46D13EDC9 = _id_05436F99DA0AB0D6.origin;
          _id_0522F11C665D62DF = 1;
        }
      } else if(!bcansee) {
        if(isDefined(_id_47203C042B64F03C) && _id_77E1544BD35826E5 > 0) {
          self._id_1C9ED4A46D13EDC9 = _id_47203C042B64F03C;
          _id_0522F11C665D62DF = 1;
        }
      }

      if(_id_0522F11C665D62DF) {
        _id_63CC85541246C7B4 = self._id_1C9ED4A46D13EDC9 - self.origin;
        _id_B5C1DD0E7B0B043B = vectortoyaw(_id_63CC85541246C7B4);
        _id_2AE9E639905974A1 = angleclamp180(_id_B5C1DD0E7B0B043B - _id_1402D870C92DF1AF - _id_B8B42FEE0A565EE5);
        _id_1402D870C92DF1AF = _id_B5C1DD0E7B0B043B;
        _id_D00AB4A1A5F59A50 = _id_D00AB4A1A5F59A50 + _id_2AE9E639905974A1 / _id_1AAD8F38CB38F703;
      }
    }

    self orientmode("face angle", angleclamp(self.angles[1] + _id_D00AB4A1A5F59A50));
    _id_1AAD8F38CB38F703 = _id_1AAD8F38CB38F703 - 1;

    if(_id_1AAD8F38CB38F703 < 1) {
      if(isDefined(_id_05436F99DA0AB0D6)) {
        if(absangleclamp180(self.angles[1] - _id_1402D870C92DF1AF) <= 10) {
          if(!self[[self.fnisinstealthcombat]]() && isPlayer(_id_05436F99DA0AB0D6) && bcansee)
            self aieventlistenerevent("sight", _id_05436F99DA0AB0D6, _id_05436F99DA0AB0D6.origin);
        } else
          self glanceatpos(self._id_1C9ED4A46D13EDC9);
      }
    }

    waitframe();
  }
}

patrol_playanim_idlecurious(asmname, statename, params) {
  thread patrol_playanim_idlecurious_facelastknownhelper(statename, self._id_E0164BF8693E15E1);
  _func_216C67AB6749137A(self, undefined, "curious");
  scripts\asm\asm::asm_playanimstate(asmname, statename);
}

patrol_playanim_idlecurious_facelastknownhelper(statename, target) {
  self endon(statename + "_finished");

  while(isDefined(target) && isalive(target)) {
    _id_4FC502B1A10006CC = self lastknownpos(target);
    _id_B1DAE7CAE8885FB1 = _id_4FC502B1A10006CC - self.origin;
    self orientmode("face angle", vectortoyaw(_id_B1DAE7CAE8885FB1));
    waitframe();
  }
}

patrol_magicflashlightdetach(asmname, statename, params) {
  if(isDefined(self._id_1BAB8712529EB3C2) && self._id_1BAB8712529EB3C2)
    detachflashlight();

  if(istrue(self._blackboard.bflashlight) && !istrue(self._id_1BAB8712529EB3C2))
    self[[self.fnstealthflashlighton]]();
}

patrol_magicflashlighton(asmname, statename, params) {
  if(istrue(self._blackboard.bflashlight))
    self[[self.fnstealthflashlighton]]();
}

chooseanim_patrol_checkflashlight(asmname, statename, params) {
  alias = params;

  if(isDefined(self._id_1BAB8712529EB3C2) && self._id_1BAB8712529EB3C2)
    alias = "fl_" + alias;

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

flashlightnotehandler(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "attach") {
    _id_343B33980A5007B1 = self _meth_76D6356C94F30473();
    attachflashlight(_id_343B33980A5007B1);
  } else if(_id_A234A65C378F3289 == "detach") {
    detachflashlight();

    if(scripts\asm\asm::asm_getdemeanor() != "patrol" && isDefined(self._blackboard.bflashlight) && self._blackboard.bflashlight)
      self[[self.fnstealthflashlighton]]();
  } else if(_id_A234A65C378F3289 == "flashlight_on")
    self[[self.fnstealthflashlighton]]();
  else if(_id_A234A65C378F3289 == "flashlight_off")
    self[[self.fnstealthflashlightoff]](0);
}

setflashlightmodel(flashlightmodel) {
  if(isai(self))
    detachflashlight();

  self.flashlightmodeloverride = flashlightmodel;

  if(isai(self) && istrue(self._id_1BAB8712529EB3C2))
    attachflashlight(1);
}

getflashlightmodel() {
  modelname = "attachment_wm_tac_light_held";

  if(isDefined(self.flashlightmodeloverride))
    modelname = self.flashlightmodeloverride;
  else if(isDefined(level.flashlightmodeloverride))
    modelname = level.flashlightmodeloverride;

  return modelname;
}

attachflashlight(_id_4D65DB1B45602939) {
  self[[self.fnstealthflashlightoff]](0);
  modelname = getflashlightmodel();
  self attach(modelname, "tag_accessory_left", 1);
  self.flashlightmodel = modelname;
  self._id_1BAB8712529EB3C2 = 1;
  self.flashlightfxoverridetag = "tag_light";

  if(_id_4D65DB1B45602939)
    self[[self.fnstealthflashlighton]]();
}

detachflashlight() {
  if(!istrue(self._id_1BAB8712529EB3C2)) {
    return;
  }
  self[[self.fnstealthflashlightoff]](0);

  if(isDefined(self.flashlightmodel)) {
    self detach(self.flashlightmodel, "tag_accessory_left");
    self.flashlightmodel = undefined;
  }

  self._id_1BAB8712529EB3C2 = 0;
  self.flashlightfxoverridetag = undefined;
}

flashlightreactionnotehandler(statename, _id_A234A65C378F3289, params) {
  flashlightnotehandler(_id_A234A65C378F3289);
  return handlefacegoalnotetrack(statename, _id_A234A65C378F3289, params);
}

_id_2BE03B6FC63E8C8B(asmname, statename, params) {
  return istrue(level._id_DA217073B223521A);
}

_id_70D280C57C0CFEE9(asmname, statename, params) {
  alias = "curious";

  if(self _meth_129CBB4366307F50("med") || self[[self.fnisinstealthcombat]]())
    alias = "threat";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\engine\utility::string(alias));
}

_id_8C0E27519BE09045(_id_A234A65C378F3289, params) {
  if(isstartstr(_id_A234A65C378F3289, "bc_")) {
    event = getsubstr(_id_A234A65C378F3289, 3);
    _func_216C67AB6749137A(self, undefined, event);
  }
}