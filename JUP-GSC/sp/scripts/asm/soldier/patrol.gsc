/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\soldier\patrol.gsc
***********************************************/

#using scripts\aitypes\stealth;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\patrol;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace patrol;

function function_3aba5f22b60d37f5() {
  scripts\aitypes\stealth::initstealthfunctions();
  self.var_5221cb0637cd44e7 = &scripts\asm\soldier\patrol::attachflashlight;
  self.fnstealthflashlightdetach = &scripts\asm\soldier\patrol::detachflashlight;
}

function playanim_patrolreact_internal(asmname, statename, arcstatename) {
  assert(isDefined(self.stealth));
  self.var_de7ab32958c52392 = self.var_fd01ad49b4e38ae8;

  if(shouldpatrolreactaim()) {
    if(isDefined(self.var_1c9ed4a46d13edc9) && distance2dsquared(self.origin, self.var_1c9ed4a46d13edc9) > 1024) {
      self setlookat(self.var_1c9ed4a46d13edc9);
    }
  }

  reactanim = self asmgetanim(asmname, statename);
  assert(isDefined(reactanim));
  reactxanim = asm_getxanim(arcstatename, reactanim);
  animrate = 1;

  if(isDefined(self.var_aebf462ec3f3362d)) {
    endtime = 1;
    var_1cf3cc2bfbd90835 = getnotetracktimes(reactxanim, "code_move");

    if(var_1cf3cc2bfbd90835.size > 0) {
      endtime = var_1cf3cc2bfbd90835[0];
    }

    animlength = getanimlength(reactxanim) * endtime;
    desiredlength = 0.05 + (self.var_aebf462ec3f3362d - gettime()) / 1000;

    if(desiredlength < 0.2) {
      desiredlength = 0.2;
    }

    animrate = clamp(animlength / desiredlength, 0.8, 1.3);
    self.var_aebf462ec3f3362d = undefined;
  }

  self aisetanim(arcstatename, reactanim, animrate);
  self function_df303d9c05757e6b(reactanim, arcstatename);
  asm_donotetrackswithinterceptor(asmname, statename, &flashlightreactionnotehandler, undefined, arcstatename);
}

function shouldpatrolreactaim(asmname, statename, tostatename, params) {
  assert(isDefined(self.var_fd01ad49b4e38ae8));
  return self.var_fd01ad49b4e38ae8 == "med";
}

function chooseanim_patrolreactlookaround(asmname, statename, params) {
  alias = "curious";

  if(self function_129cbb4366307f50("med") || self[[self.fnisinstealthcombat]]()) {
    alias = "threat";
  }

  return asm_lookupanimfromalias(statename, string(alias));
}

function chooseanim_patrolreactlookaround_checkflashlight(asmname, statename, params) {
  alias = string(getpatrolreactdirindex());

  if(self function_129cbb4366307f50("med") || self[[self.fnisinstealthcombat]]()) {
    alias = "threat_" + alias;
  }

  return chooseanim_patrol_checkflashlight(asmname, statename, alias);
}

function getpatrolreactdirindex() {
  reactyaw = 0;

  if(isDefined(self.var_1c9ed4a46d13edc9)) {
    delta = self.var_1c9ed4a46d13edc9 - self.origin;

    if(length2dsquared(delta) < 36) {
      reactyaw = 0;
    } else {
      deltayaw = vectortoyaw(delta);
      reactyaw = self.angles[1] - deltayaw;
    }
  }

  return getreactangleindex(reactyaw);
}

function function_a23a26adcf97fdd0() {
  reactyaw = 0;

  if(isDefined(self.var_1c9ed4a46d13edc9)) {
    delta = self.var_1c9ed4a46d13edc9 - self.origin;
    deltayaw = vectortoyaw(delta);
    reactyaw = self.angles[1] - deltayaw;
  }

  reactyaw = angleclamp180(reactyaw);
  directionindex = function_de2aa7eb339a432c(reactyaw);
  suffix = string(directionindex);

  if(reactyaw < -120 && reactyaw > -180) {
    suffix += "l";
  } else if(reactyaw > 120 && reactyaw < 180) {
    suffix += "r";
  }

  return suffix;
}

function getpatrolreactalias() {
  assert(isDefined(self.var_fd01ad49b4e38ae8));
  suffix = function_a23a26adcf97fdd0();

  if(self.var_ee027a8f98390896) {
    alias = self.var_fd01ad49b4e38ae8 + "_close_" + suffix;
  } else {
    alias = self.var_fd01ad49b4e38ae8 + "_" + suffix;
  }

  return alias;
}

function chooseanim_patrolreact(asmname, statename, params) {
  alias = getpatrolreactalias();
  animindex = asm_lookupanimfromalias(statename, alias);

  if(!isDefined(animindex)) {
    if(asm_hasalias(statename, "med_8")) {
      return asm_lookupanimfromalias(statename, "med_8");
    } else {
      return asm_lookupanimfromalias(statename, "small_8");
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

function function_de2aa7eb339a432c(angle) {
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

function function_7889a8a760c6e02(turnanim, desiredyaw, beyondyaw, endtime) {
  currentanimtime = self aigetanimtime(turnanim);
  assert(currentanimtime < endtime);
  animyaw = getangledelta(turnanim, currentanimtime, endtime) + beyondyaw;
  totalyaw = self.angles[1] + animyaw;
  turnyaw = angleclamp180(desiredyaw - angleclamp(totalyaw));
  return turnyaw;
}

function handlefacegoalnotetrack(statename, note, params) {
  if(note == "face_goal" && isDefined(self.var_1c9ed4a46d13edc9)) {
    xanim = asm_getxanim(self.var_39798b565de83c7b, self.var_d1a6890d054957e7);

    if(!isDefined(xanim)) {
      return false;
    }

    finishtime = getnotetracktimes(xanim, "finish");

    if(finishtime.size == 0) {
      finishtime[0] = 1;
    }

    var_3611c8e9f9a8d539 = getnotetracktimes(xanim, "combat_early_out");
    var_53c95344c2ab768f = 1;

    if(var_3611c8e9f9a8d539.size == 0 || !self[[self.fnisinstealthcombat]]()) {
      var_53c95344c2ab768f = 0;
      var_3611c8e9f9a8d539[0] = 1;
    }

    endtime = getnotetracktimes(xanim, "face_goal_end");

    if(endtime.size == 0) {
      endtime[0] = finishtime[0];
    }

    if(var_3611c8e9f9a8d539[0] < endtime[0]) {
      endtime[0] = var_3611c8e9f9a8d539[0];
    }

    [animtime] = getnotetracktimes(xanim, "face_goal");
    animrate = self getanimrate(xanim);
    assert(animrate != 0);

    if(animrate == 0) {
      animrate = 1;
    }

    anim_length = getanimlength(xanim) / animrate;
    turntime = endtime[0] - animtime;
    turntime *= anim_length;
    beyondyaw = 0;

    if(!var_53c95344c2ab768f && endtime[0] < finishtime[0]) {
      beyondyaw = getangledelta(xanim, endtime[0], finishtime[0]);
    }

    var_63cc85541246c7b4 = self.var_1c9ed4a46d13edc9 - self.origin;
    reactworldyaw = vectortoyaw(var_63cc85541246c7b4);
    turnyaw = function_7889a8a760c6e02(xanim, reactworldyaw, beyondyaw, endtime[0]);
    thread facegoalthread(statename, turnyaw, beyondyaw, self.var_1c9ed4a46d13edc9, reactworldyaw, turntime, xanim, endtime[0]);
    return true;
  }

  return false;
}

function facegoalthread(statename, turnyaw, beyondyaw, reactpos, reactworldyaw, turntime, turnanim, endtime) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(statename + "_finished");
  frames = ceil(turntime * 1000 / level.frameduration);
  var_d00ab4a1a5f59a50 = turnyaw / frames;
  var_72c012a18c9e68f9 = undefined;
  stopyaw = 0;

  while(frames > 0) {
    overrideent = self.enemy;

    if(!isDefined(overrideent)) {
      if(isDefined(self.var_33107dcb50df3cde) && isPlayer(self.var_33107dcb50df3cde)) {
        overrideent = self.var_33107dcb50df3cde;
      }
    }

    bcansee = 0;

    if(isDefined(overrideent) && issentient(overrideent)) {
      lkp = self lastknownpos(overrideent);
      lktime = self lastknowntime(overrideent);

      if(!bcansee) {
        bcansee = self cansee(overrideent);
      }

      var_522f11c665d62df = 0;

      if(bcansee) {
        if(distancesquared(self.var_1c9ed4a46d13edc9, overrideent.origin) >= 225) {
          self.var_1c9ed4a46d13edc9 = overrideent.origin;
          var_522f11c665d62df = 1;
        }
      } else if(!bcansee) {
        if(isDefined(lkp) && lktime > 0) {
          self.var_1c9ed4a46d13edc9 = lkp;
          var_522f11c665d62df = 1;
        }
      }

      if(var_522f11c665d62df) {
        var_63cc85541246c7b4 = self.var_1c9ed4a46d13edc9 - self.origin;
        var_b5c1dd0e7b0b043b = vectortoyaw(var_63cc85541246c7b4);
        turnyaw = angleclamp180(var_b5c1dd0e7b0b043b - reactworldyaw - beyondyaw);
        reactworldyaw = var_b5c1dd0e7b0b043b;
        var_d00ab4a1a5f59a50 += turnyaw / frames;
      }
    }

    self orientmode("face angle", angleclamp(self.angles[1] + var_d00ab4a1a5f59a50));
    frames -= 1;

    if(frames < 1) {
      if(isDefined(overrideent)) {
        if(absangleclamp180(self.angles[1] - reactworldyaw) <= 10) {
          if(!self[[self.fnisinstealthcombat]]() && isPlayer(overrideent) && bcansee) {
            self aieventlistenerevent("sight", overrideent, overrideent.origin);
          }
        } else {
          self glanceatpos(self.var_1c9ed4a46d13edc9);
        }
      }
    }

    waitframe();
  }
}

function patrol_playanim_idlecurious(asmname, statename, params) {
  thread patrol_playanim_idlecurious_facelastknownhelper(statename, self.var_e0164bf8693e15e1);
  function_216c67ab6749137a(self, undefined, "curious");
  asm_playanimstate(asmname, statename);
}

function patrol_playanim_idlecurious_facelastknownhelper(statename, target) {
  self endon(statename + "_finished");

  while(isDefined(target) && isalive(target)) {
    lastknown = self lastknownpos(target);
    var_b1dae7cae8885fb1 = lastknown - self.origin;
    self orientmode("face angle", vectortoyaw(var_b1dae7cae8885fb1));
    waitframe();
  }
}

function patrol_magicflashlightdetach(asmname, statename, params) {
  if(isDefined(self.var_1bab8712529eb3c2) && self.var_1bab8712529eb3c2) {
    detachflashlight();
  }

  if(istrue(self._blackboard.bflashlight) && !istrue(self.var_1bab8712529eb3c2)) {
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

  if(isDefined(self.var_1bab8712529eb3c2) && self.var_1bab8712529eb3c2) {
    alias = "fl_" + alias;
  }

  return asm_lookupanimfromalias(statename, alias);
}

function flashlightnotehandler(note) {
  if(note == "attach") {
    var_343b33980a5007b1 = self function_76d6356c94f30473();
    attachflashlight(var_343b33980a5007b1);
    return;
  }

  if(note == "detach") {
    assert(isDefined(self.fnstealthflashlighton));
    detachflashlight();

    if(asm_getdemeanor() != "patrol" && isDefined(self._blackboard.bflashlight) && self._blackboard.bflashlight) {
      self[[self.fnstealthflashlighton]]();
    }

    return;
  }

  if(note == "flashlight_on") {
    self[[self.fnstealthflashlighton]]();
    return;
  }

  if(note == "flashlight_off") {
    self[[self.fnstealthflashlightoff]](0);
  }
}

function setflashlightmodel(flashlightmodel) {
  if(isai(self)) {
    detachflashlight();
  }

  self.flashlightmodeloverride = flashlightmodel;

  if(isai(self) && istrue(self.var_1bab8712529eb3c2)) {
    attachflashlight(1);
  }
}

function getflashlightmodel() {
  modelname = "attachment_wm_tac_light_held";

  if(isDefined(self.flashlightmodeloverride)) {
    modelname = self.flashlightmodeloverride;
  } else if(isDefined(level.flashlightmodeloverride)) {
    modelname = level.flashlightmodeloverride;
  }

  return modelname;
}

function attachflashlight(var_4d65db1b45602939) {
  assert(isDefined(self.fnstealthflashlightoff) && isDefined(self.fnstealthflashlighton));
  assert(!isDefined(self.var_1bab8712529eb3c2) || self.var_1bab8712529eb3c2 == 0);
  self[[self.fnstealthflashlightoff]](0);
  modelname = getflashlightmodel();
  self attach(modelname, "tag_accessory_left", 1);
  self.flashlightmodel = modelname;
  self.var_1bab8712529eb3c2 = 1;
  self.flashlightfxoverridetag = "tag_light";

  if(var_4d65db1b45602939) {
    self[[self.fnstealthflashlighton]]();
  }
}

function detachflashlight() {
  assert(isDefined(self.fnstealthflashlightoff));

  if(!istrue(self.var_1bab8712529eb3c2)) {
    return;
  }

  self[[self.fnstealthflashlightoff]](0);

  if(isDefined(self.flashlightmodel)) {
    self detach(self.flashlightmodel, "tag_accessory_left");
    self.flashlightmodel = undefined;
  }

  self.var_1bab8712529eb3c2 = 0;
  self.flashlightfxoverridetag = undefined;
}

function flashlightreactionnotehandler(statename, note, params) {
  flashlightnotehandler(note);
  return handlefacegoalnotetrack(statename, note, params);
}

function function_2be03b6fc63e8c8b(asmname, statename, params) {
  return istrue(level.var_da217073b223521a);
}

function function_70d280c57c0cfee9(asmname, statename, params) {
  alias = "curious";

  if(self function_129cbb4366307f50("med") || self[[self.fnisinstealthcombat]]()) {
    alias = "threat";
  }

  return asm_lookupanimfromalias(statename, string(alias));
}

function function_8c0e27519be09045(note, params) {
  if(isstartstr(note, "bc_")) {
    event = getsubstr(note, 3);

    function_216c67ab6749137a(self, undefined, event);
  }
}