/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\patrol.gsc
******************************************/

#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace patrol;

function function_2335e386f4e1b97c() {
  self.var_9cdb21fc98e9c4f2 = &attachflashlight;
  self.fnstealthflashlightdetach = &detachflashlight;
}

function playanim_patrolreact_internal(asmname, statename, arcstatename) {
  assert(isDefined(self.stealth));
  self.var_b9f5596495e231f = self.var_7d8356884d4e9935;

  if(shouldpatrolreactaim()) {
    if(isDefined(self.var_e4a3e45d352d1234) && distance2dsquared(self.origin, self.var_e4a3e45d352d1234) > 1024) {
      self setlookat(self.var_e4a3e45d352d1234);
    }
  }

  reactanim = self asmgetanim(asmname, statename);
  assert(isDefined(reactanim));
  reactxanim = asm::asm_getxanim(arcstatename, reactanim);
  animrate = 1;

  if(isDefined(self.stealthreactendtime)) {
    endtime = 1;
    codemovetimes = getnotetracktimes(reactxanim, "f\x97\xb9`\xd1~\x80(\xca");

    if(codemovetimes.size > 0) {
      endtime = codemovetimes[0];
    }

    animlength = getanimlength(reactxanim) * endtime;
    desiredlength = 0.05 + (self.stealthreactendtime - gettime()) / 1000;

    if(desiredlength < 0.2) {
      desiredlength = 0.2;
    }

    animrate = clamp(animlength / desiredlength, 0.8, 1.3);
    self.stealthreactendtime = undefined;
  }

  self aisetanim(arcstatename, reactanim, animrate);
  self function_6a16475955e1ad6(reactanim, arcstatename);
  asm::asm_donotetrackswithinterceptor(asmname, statename, &flashlightreactionnotehandler, undefined, arcstatename);
}

function shouldpatrolreactaim(asmname, statename, tostatename, params) {
  assert(isDefined(self.var_7d8356884d4e9935));
  return self.var_7d8356884d4e9935 == "i\x14\x92";
}

function chooseanim_patrolreactlookaround(asmname, statename, params) {
  alias = "9\xa6H\n\b\xcd$";

  if(self function_dd3e24312b7a5f6d("i\x14\x92") || self[[self.fnisinstealthcombat]]()) {
    alias = "\x17\x06ottx";
  }

  return asm::asm_lookupanimfromalias(statename, utility::string(alias));
}

function chooseanim_patrolreactlookaround_checkflashlight(asmname, statename, params) {
  alias = utility::string(getpatrolreactdirindex());

  if(self function_dd3e24312b7a5f6d("i\x14\x92") || self[[self.fnisinstealthcombat]]()) {
    alias = "X\xcci\xad\x95Z\x96" + alias;
  }

  return chooseanim_patrol_checkflashlight(asmname, statename, alias);
}

function getpatrolreactdirindex() {
  reactyaw = 0;

  if(isDefined(self.var_e4a3e45d352d1234)) {
    delta = self.var_e4a3e45d352d1234 - self.origin;

    if(length2dsquared(delta) < 36) {
      reactyaw = 0;
    } else {
      deltayaw = vectortoyaw(delta);
      reactyaw = self.angles[1] - deltayaw;
    }
  }

  return getreactangleindex(reactyaw);
}

function function_9573800c8f1b2c21() {
  reactyaw = 0;

  if(isDefined(self.var_e4a3e45d352d1234)) {
    delta = self.var_e4a3e45d352d1234 - self.origin;
    deltayaw = vectortoyaw(delta);
    reactyaw = self.angles[1] - deltayaw;
  }

  reactyaw = angleclamp180(reactyaw);
  directionindex = function_f75f2018a9b9ed9d(reactyaw);
  suffix = utility::string(directionindex);

  if(reactyaw < -120 && reactyaw >= -180) {
    suffix += "\xd5";
  } else if(reactyaw > 120 && reactyaw <= 180) {
    suffix += "4";
  }

  return suffix;
}

function getpatrolreactalias() {
  assert(isDefined(self.var_7d8356884d4e9935));
  suffix = function_9573800c8f1b2c21();

  if(self.var_c4b113e73df52c1f) {
    alias = self.var_7d8356884d4e9935 + "WI#\x9e\xb9h\xe9" + suffix;
  } else {
    alias = self.var_7d8356884d4e9935 + "w" + suffix;
  }

  return alias;
}

function chooseanim_patrolreact(asmname, statename, params) {
  alias = getpatrolreactalias();
  animindex = asm::asm_lookupanimfromalias(statename, alias);

  if(!isDefined(animindex)) {
    if(asm::asm_hasalias(statename, "mY#\xeb\x1c")) {
      return asm::asm_lookupanimfromalias(statename, "mY#\xeb\x1c");
    } else {
      return asm::asm_lookupanimfromalias(statename, "\xb7L\xb932.1");
    }
  }

  return animindex;
}

function chooseanim_patrolreact_checkflashlight(asmname, statename, params) {
  alias = getpatrolreactalias();
  return chooseanim_patrol_checkflashlight(asmname, statename, alias);
}

function getreactangleindex(angle) {
  angle = angleclamp180(angle);

  if(angle > 135 || angle < -135) {
    index = 2;
  } else if(angle < -45) {
    index = 4;
  } else if(angle > 45) {
    index = 6;
  } else {
    index = 8;
  }

  return index;
}

function function_f75f2018a9b9ed9d(angle) {
  angle = angleclamp180(angle);

  if(angle > 120 || angle < -120) {
    index = 2;
  } else if(angle < -30) {
    index = 4;
  } else if(angle > 30) {
    index = 6;
  } else {
    index = 8;
  }

  return index;
}

function function_3f9364eba374062b(turnanim, desiredyaw, beyondyaw, endtime) {
  currentanimtime = self aigetanimtime(turnanim);
  assert(currentanimtime < endtime);
  animyaw = getangledelta(turnanim, currentanimtime, endtime) + beyondyaw;
  totalyaw = self.angles[1] + animyaw;
  turnyaw = angleclamp180(desiredyaw - angleclamp(totalyaw));
  return turnyaw;
}

function handlefacegoalnotetrack(statename, note, params) {
  if(note == "6\x14\xc9`\xd1\xde\x80\x06\xc3" && isDefined(self.var_e4a3e45d352d1234)) {
    xanim = asm::asm_getxanim(self.var_3f70a39008d5c962, self.var_7d3f61ac69ca6496);

    if(!isDefined(xanim)) {
      return false;
    }

    finishtime = getnotetracktimes(xanim, "\xd7\xca\xae\xca\xff\xdb");

    if(finishtime.size == 0) {
      finishtime[0] = 1;
    }

    var_b2a501192671d8bc = getnotetracktimes(xanim, "\x03\xb1\xa9u7\xba\xd0\r\xce\x93\x19\xd6(\xce\x91Y");
    var_8351b2031ca8c90a = 1;

    if(var_b2a501192671d8bc.size == 0 || !self[[self.fnisinstealthcombat]]()) {
      var_8351b2031ca8c90a = 0;
      var_b2a501192671d8bc[0] = 1;
    }

    endtime = getnotetracktimes(xanim, "d\x91\x8b\xca<\x1c\xd0WZ\x10}'Z");

    if(endtime.size == 0) {
      endtime[0] = finishtime[0];
    }

    if(var_b2a501192671d8bc[0] < endtime[0]) {
      endtime[0] = var_b2a501192671d8bc[0];
    }

    [animtime] = getnotetracktimes(xanim, "6\x14\xc9`\xd1\xde\x80\x06\xc3");
    animrate = self getanimrate(xanim);
    assert(animrate != 0);

    if(animrate == 0) {
      animrate = 1;
    }

    anim_length = getanimlength(xanim) / animrate;
    turntime = endtime[0] - animtime;
    turntime *= anim_length;
    beyondyaw = 0;

    if(!var_8351b2031ca8c90a && endtime[0] < finishtime[0]) {
      beyondyaw = getangledelta(xanim, endtime[0], finishtime[0]);
    }

    metopos = self.var_e4a3e45d352d1234 - self.origin;
    reactworldyaw = vectortoyaw(metopos);
    turnyaw = function_3f9364eba374062b(xanim, reactworldyaw, beyondyaw, endtime[0]);
    thread facegoalthread(statename, turnyaw, beyondyaw, self.var_e4a3e45d352d1234, reactworldyaw, turntime, xanim, endtime[0]);
    return true;
  }

  return false;
}

function facegoalthread(statename, turnyaw, beyondyaw, reactpos, reactworldyaw, turntime, turnanim, endtime) {
  self notify("\xd6\x7f\x14l\xcb\xe4\v\x8d\xbe\x8f\x80\xa0\xdci");
  self endon("\xd6\x7f\x14l\xcb\xe4\v\x8d\xbe\x8f\x80\xa0\xdci");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  frames = ceil(turntime * 1000 / level.frameduration);
  var_c349b09d43802d21 = turnyaw / frames;
  var_900b6bec828d5560 = undefined;
  stopyaw = 0;

  while(frames > 0) {
    overrideent = self.enemy;

    if(!isDefined(overrideent)) {
      if(isDefined(self.var_7a463a19459a3197) && isPlayer(self.var_7a463a19459a3197)) {
        overrideent = self.var_7a463a19459a3197;
      }
    }

    bcansee = 0;

    if(isDefined(overrideent) && issentient(overrideent)) {
      lkp = self lastknownpos(overrideent);
      lktime = self lastknowntime(overrideent);

      if(!bcansee) {
        bcansee = self cansee(overrideent);
      }

      var_20cd5ff92b12169a = 0;

      if(bcansee) {
        if(distancesquared(self.var_e4a3e45d352d1234, overrideent.origin) >= 225) {
          self.var_e4a3e45d352d1234 = overrideent.origin;
          var_20cd5ff92b12169a = 1;
        }
      } else if(!bcansee) {
        if(isDefined(lkp) && lktime > 0) {
          self.var_e4a3e45d352d1234 = lkp;
          var_20cd5ff92b12169a = 1;
        }
      }

      if(var_20cd5ff92b12169a) {
        metopos = self.var_e4a3e45d352d1234 - self.origin;
        newreactworldyaw = vectortoyaw(metopos);
        turnyaw = angleclamp180(newreactworldyaw - reactworldyaw - beyondyaw);
        reactworldyaw = newreactworldyaw;
        var_c349b09d43802d21 += turnyaw / frames;
      }
    }

    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", angleclamp(self.angles[1] + var_c349b09d43802d21));
    frames -= 1;

    if(frames < 1) {
      if(isDefined(overrideent)) {
        if(absangleclamp180(self.angles[1] - reactworldyaw) <= 10) {
          if(!self[[self.fnisinstealthcombat]]() && isPlayer(overrideent) && bcansee) {
            self aieventlistenerevent("\xc7@\xe1xS", overrideent, overrideent.origin);
          }
        } else {
          self glanceatpos(self.var_e4a3e45d352d1234);
        }
      }
    }

    waitframe();
  }
}

function patrol_playanim_idlecurious(asmname, statename, params) {
  thread patrol_playanim_idlecurious_facelastknownhelper(statename, self.stealthidlecurioustarget);

  if(isDefined(level.battlechatter)) {
    function_99e8e66d1969d7cb(self, self.var_26b571dd57aaef93, "9\xa6H\n\b\xcd$");
  }

  asm::asm_playanimstate(asmname, statename);
}

function patrol_playanim_idlecurious_facelastknownhelper(statename, target) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  while(isDefined(target) && isalive(target)) {
    lastknown = self lastknownpos(target);
    var_a0964282568586f0 = lastknown - self.origin;
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", vectortoyaw(var_a0964282568586f0));
    waitframe();
  }
}

function patrol_magicflashlightdetach(asmname, statename, params) {
  if(isDefined(self.asmflashlight) && self.asmflashlight) {
    detachflashlight();
  }

  if(istrue(self._blackboard.bflashlight) && !istrue(self.asmflashlight)) {
    self[[self.fnstealthflashlighton]]();
  }
}

function patrol_magicflashlighton(asmname, statename, params) {
  if(istrue(self._blackboard.bflashlight)) {
    self[[self.fnstealthflashlighton]]();
  }
}

function chooseanim_patrol_checkflashlight(asmname, statename, params) {
  assert(isDefined(params));
  alias = params;

  if(isDefined(self.asmflashlight) && self.asmflashlight) {
    alias = " \x9b\xe6" + alias;
  }

  return asm::asm_lookupanimfromalias(statename, alias);
}

function flashlightnotehandler(note) {
  if(note == "l\xcd\x8f\x8bX\x1b") {
    var_62f98de2e03da2b4 = self function_330ee11890a4ad66();
    attachflashlight(var_62f98de2e03da2b4);
    return;
  }

  if(note == "\x17\xa1\xa8i2\xcb") {
    assert(isDefined(self.fnstealthflashlighton));
    detachflashlight();

    if(asm::asm_getdemeanor() != "T\x1d\xd9\x0e L" && isDefined(self._blackboard.bflashlight) && self._blackboard.bflashlight) {
      self[[self.fnstealthflashlighton]]();
    }

    return;
  }

  if(note == "A\xf6\xaf\x87\x04\xfa\xd35\x0f\xf3\xbcC\xae") {
    self[[self.fnstealthflashlighton]]();
    return;
  }

  if(note == ">\x10\xc3\xcb\x92\xc0\xe4\x9f8s\xf3(\xbb;") {
    self[[self.fnstealthflashlightoff]](0);
  }
}

function setflashlightmodel(flashlightmodel) {
  if(isai(self)) {
    detachflashlight();
  }

  self.flashlightmodeloverride = flashlightmodel;

  if(isai(self) && istrue(self.asmflashlight)) {
    attachflashlight(1);
  }
}

function getflashlightmodel() {
  modelname = "\x90\x94\xd4U\xaeoM\x15C\xe7|aK\x7fJ\xb2\xb1\xe3c?o\xaeV5\xc22\xd8\x7f";

  if(isDefined(self.flashlightmodeloverride)) {
    modelname = self.flashlightmodeloverride;
  } else if(isDefined(level.flashlightmodeloverride)) {
    modelname = level.flashlightmodeloverride;
  }

  return modelname;
}

function attachflashlight(var_86dd1035c19bd478) {
  assert(isDefined(self.fnstealthflashlightoff) && isDefined(self.fnstealthflashlighton));
  assert(!isDefined(self.asmflashlight) || self.asmflashlight == 0);
  self[[self.fnstealthflashlightoff]](0);
  modelname = getflashlightmodel();
  self attach(modelname, "r\xfc}\xb0\xfc>\xe2~\xf7\x80\xa0\xa2\xd2\xae\x0e}\xf8G", 1);
  self.flashlightmodel = modelname;
  self.asmflashlight = 1;
  self.flashlightfxoverridetag = "b\xa8\xff\xd0\x18a\xc0\x97=";

  if(var_86dd1035c19bd478) {
    self[[self.fnstealthflashlighton]]();
  }
}

function detachflashlight() {
  assert(isDefined(self.fnstealthflashlightoff));

  if(!istrue(self.asmflashlight)) {
    return;
  }

  self[[self.fnstealthflashlightoff]](0);

  if(isDefined(self.flashlightmodel)) {
    self detach(self.flashlightmodel, "r\xfc}\xb0\xfc>\xe2~\xf7\x80\xa0\xa2\xd2\xae\x0e}\xf8G");
    self.flashlightmodel = undefined;
  }

  self.asmflashlight = 0;
  self.flashlightfxoverridetag = undefined;
}

function flashlightreactionnotehandler(statename, note, params) {
  flashlightnotehandler(note);
  return handlefacegoalnotetrack(statename, note, params);
}

function function_9a28e9504020473a(asmname, statename, params) {
  return istrue(level.var_10367059819ade3b);
}

function function_634db2274fd03124(asmname, statename, params) {
  alias = "9\xa6H\n\b\xcd$";

  if(self function_dd3e24312b7a5f6d("i\x14\x92") || self[[self.fnisinstealthcombat]]()) {
    alias = "\x17\x06ottx";
  }

  return asm::asm_lookupanimfromalias(statename, utility::string(alias));
}

function bc_notehandler(note, params) {
  if(isDefined(level.battlechatter) && isstartstr(note, "\xbao\xb1")) {
    event = getsubstr(note, 3);

    function_99e8e66d1969d7cb(self, undefined, event);
  }
}